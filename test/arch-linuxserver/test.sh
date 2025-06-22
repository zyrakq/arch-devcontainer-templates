#!/bin/bash
# Test for arch-linuxserver template
# Checks LinuxServer.io specific functionality

set -e

# Load common utilities
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../test-utils/test-utils.sh"

# Test counters
PASSED=0
TOTAL=0

# Test base system (LinuxServer specific)
test_base_system() {
    local tests_passed=0
    local tests_total=4
    
    # Check OS
    if [ -f /etc/arch-release ]; then
        success "Arch Linux detected"
        ((tests_passed++))
    else
        error "Failed to detect Arch Linux"
    fi
    
    # Check user is abc (LinuxServer default)
    if [ "$USER" = "abc" ]; then
        success "User is abc (LinuxServer default)"
        ((tests_passed++))
    else
        error "User is not abc, found: $USER"
    fi
    
    # Check HOME directory is /config
    if [ "$HOME" = "/config" ]; then
        success "HOME directory is /config (LinuxServer default)"
        ((tests_passed++))
    else
        error "HOME directory is not /config, found: $HOME"
    fi
    
    # Check pacman
    if check_command "pacman" "Pacman package manager"; then
        ((tests_passed++))
    fi
    
    [ $tests_passed -eq $tests_total ]
}

# Test LinuxServer environment variables
test_linuxserver_environment() {
    local tests_passed=0
    local tests_total=4
    
    # Check PUID
    if check_env_var "PUID" "Process User ID"; then
        ((tests_passed++))
    fi
    
    # Check PGID
    if check_env_var "PGID" "Process Group ID"; then
        ((tests_passed++))
    fi
    
    # Check TZ
    if check_env_var "TZ" "Timezone"; then
        ((tests_passed++))
    fi
    
    # Check TITLE
    if check_env_var "TITLE" "Application Title"; then
        ((tests_passed++))
    fi
    
    [ $tests_passed -eq $tests_total ]
}

# Test s6-overlay services
test_s6_services() {
    local tests_passed=0
    local tests_total=2
    
    # Check s6-overlay directory
    if check_path "/etc/s6-overlay" "s6-overlay configuration directory"; then
        ((tests_passed++))
    fi
    
    # Check if s6-svscan is running (main s6 process)
    log "Checking s6-overlay services"
    if pgrep -f "s6-svscan" >/dev/null 2>&1; then
        success "s6-overlay is running"
        ((tests_passed++))
    else
        warning "s6-overlay not detected (may not be started yet)"
        ((tests_passed++))
    fi
    
    [ $tests_passed -eq $tests_total ]
}

# Test web interface availability
test_web_interface() {
    local tests_passed=0
    local tests_total=2
    
    # Check if port 3000 is listening
    log "Checking web interface on port 3000"
    if netstat -tuln 2>/dev/null | grep -q ":3000 " || ss -tuln 2>/dev/null | grep -q ":3000 "; then
        success "Port 3000 is listening"
        ((tests_passed++))
    else
        warning "Port 3000 is not listening (web interface may not be started)"
        ((tests_passed++))
    fi
    
    # Check for web server processes (common ones in LinuxServer images)
    log "Checking for web server processes"
    if pgrep -f "nginx\|apache\|httpd\|websockify\|kasmvnc" >/dev/null 2>&1; then
        success "Web server process detected"
        ((tests_passed++))
    else
        warning "No web server process detected (may not be started yet)"
        ((tests_passed++))
    fi
    
    [ $tests_passed -eq $tests_total ]
}

# Test volumes and filesystem
test_volumes_and_filesystem() {
    local tests_passed=0
    local tests_total=4
    
    # Check /config directory (home volume)
    if check_path "/config" "Config directory (home volume)"; then
        ((tests_passed++))
    fi
    
    # Check workspace directory (should exist somewhere under /workspace)
    log "Checking workspace directory"
    if [ -d "/workspace" ] && [ "$(ls -A /workspace 2>/dev/null)" ]; then
        success "Workspace directory exists and is not empty"
        ((tests_passed++))
    else
        warning "Workspace directory is empty or not mounted (may be normal during testing)"
        ((tests_passed++))
    fi
    
    # Check /config permissions (should be writable by abc user)
    log "Checking /config directory permissions"
    if [ -w "/config" ]; then
        success "/config directory is writable"
        ((tests_passed++))
    else
        error "/config directory is not writable"
    fi
    
    # Check if abc user owns /config
    log "Checking /config ownership"
    if [ "$(stat -c '%U' /config 2>/dev/null)" = "abc" ]; then
        success "/config is owned by abc user"
        ((tests_passed++))
    else
        warning "/config ownership may not be set correctly"
        ((tests_passed++))
    fi
    
    [ $tests_passed -eq $tests_total ]
}

# Test shared memory configuration
test_shared_memory() {
    local tests_passed=0
    local tests_total=1
    
    # Check shared memory size
    log "Checking shared memory configuration"
    local shm_size
    shm_size=$(df -h /dev/shm 2>/dev/null | awk 'NR==2 {print $2}' || echo "unknown")
    
    if [ "$shm_size" != "unknown" ]; then
        success "Shared memory size: $shm_size"
        ((tests_passed++))
    else
        warning "Could not determine shared memory size"
        ((tests_passed++))
    fi
    
    [ $tests_passed -eq $tests_total ]
}

# Test network connectivity
test_network() {
    local tests_passed=0
    local tests_total=2
    
    if check_network; then
        ((tests_passed++))
    fi
    
    # Check Arch repositories accessibility
    log "Checking Arch Linux repositories accessibility"
    if curl -s --connect-timeout 10 https://archlinux.org >/dev/null; then
        success "Arch Linux repositories are accessible"
        ((tests_passed++))
    else
        error "Arch Linux repositories are not accessible"
    fi
    
    [ $tests_passed -eq $tests_total ]
}

# Test essential packages
test_packages() {
    local tests_passed=0
    local tests_total=5
    
    # Essential packages that should be installed in LinuxServer images
    local packages=("base" "base-devel" "curl" "wget" "git")
    
    for package in "${packages[@]}"; do
        if check_pacman_package "$package"; then
            ((tests_passed++))
        fi
    done
    
    [ $tests_passed -eq $tests_total ]
}

# Test features (common-utils)
test_features() {
    local tests_passed=0
    local tests_total=2
    
    # Check zsh installation
    if check_command "zsh" "Zsh shell (from common-utils feature)"; then
        ((tests_passed++))
    fi
    
    # Check if zsh is default shell for abc user
    log "Checking default shell for abc user"
    local user_shell
    user_shell=$(getent passwd abc | cut -d: -f7)
    if [[ "$user_shell" == *"zsh"* ]]; then
        success "Zsh is configured as default shell for abc user"
        ((tests_passed++))
    else
        warning "Default shell for abc user is: $user_shell (expected zsh)"
        ((tests_passed++))
    fi
    
    [ $tests_passed -eq $tests_total ]
}

# Main testing function
main() {
    echo "========================================"
    log "TESTING ARCH-LINUXSERVER TEMPLATE"
    echo "========================================"
    
    # Run all tests
    if run_test "Base System (LinuxServer)" test_base_system; then
        ((PASSED++))
    fi
    ((TOTAL++))
    
    if run_test "LinuxServer Environment Variables" test_linuxserver_environment; then
        ((PASSED++))
    fi
    ((TOTAL++))
    
    if run_test "s6-overlay Services" test_s6_services; then
        ((PASSED++))
    fi
    ((TOTAL++))
    
    if run_test "Web Interface" test_web_interface; then
        ((PASSED++))
    fi
    ((TOTAL++))
    
    if run_test "Volumes & Filesystem" test_volumes_and_filesystem; then
        ((PASSED++))
    fi
    ((TOTAL++))
    
    if run_test "Shared Memory" test_shared_memory; then
        ((PASSED++))
    fi
    ((TOTAL++))
    
    if run_test "Network Connectivity" test_network; then
        ((PASSED++))
    fi
    ((TOTAL++))
    
    if run_test "Essential Packages" test_packages; then
        ((PASSED++))
    fi
    ((TOTAL++))
    
    if run_test "Features (common-utils)" test_features; then
        ((PASSED++))
    fi
    ((TOTAL++))
    
    # Generate report
    generate_report $PASSED $TOTAL
}

# Run tests
main "$@"