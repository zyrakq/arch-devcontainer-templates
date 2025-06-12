#!/bin/bash

# Test for arch-base template
# Checks basic functionality of Arch Linux dev container

set -e

# Load common utilities
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../test-utils/test-utils.sh"

# Test counters
PASSED=0
TOTAL=0

# Test base system
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
    
    # Check pacman
    if check_command "pacman" "Pacman package manager"; then
        ((tests_passed++))
    fi
    
    # Check basic commands
    if check_command "bash" "Bash shell"; then
        ((tests_passed++))
    fi
    
    if check_command "curl" "Curl utility"; then
        ((tests_passed++))
    fi
    
    [ $tests_passed -eq $tests_total ]
}

# Test Git
test_git() {
    local tests_passed=0
    local tests_total=3
    
    if check_command "git" "Git"; then
        ((tests_passed++))
    fi
    
    if check_version "git" "--version" "Git version"; then
        ((tests_passed++))
    fi
    
    # Check basic Git configuration
    log "Checking Git configuration"
    if git config --global --get-regexp ".*" >/dev/null 2>&1; then
        success "Git has global configuration"
        ((tests_passed++))
    else
        warning "Git has no global configuration (this is normal for base template)"
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

# Test packages
test_packages() {
    local tests_passed=0
    local tests_total=5
    
    # Essential packages that should be installed
    local packages=("base" "base-devel" "git" "curl" "wget")
    
    for package in "${packages[@]}"; do
        if check_pacman_package "$package"; then
            ((tests_passed++))
        fi
    done
    
    [ $tests_passed -eq $tests_total ]
}

# Test filesystem
test_filesystem() {
    local tests_passed=0
    local tests_total=3
    
    # Check essential directories
    if check_path "/home" "Home directory"; then
        ((tests_passed++))
    fi
    
    if check_path "/tmp" "Temporary directory"; then
        ((tests_passed++))
    fi
    
    if check_path "/var" "System directory /var"; then
        ((tests_passed++))
    fi
    
    [ $tests_passed -eq $tests_total ]
}

# Test environment variables
test_environment() {
    local tests_passed=0
    local tests_total=3
    
    if check_env_var "PATH" "PATH variable"; then
        ((tests_passed++))
    fi
    
    if check_env_var "HOME" "HOME variable"; then
        ((tests_passed++))
    fi
    
    if check_env_var "USER" "USER variable"; then
        ((tests_passed++))
    fi
    
    [ $tests_passed -eq $tests_total ]
}

# Test Docker (if available)
test_docker() {
    local tests_passed=0
    local tests_total=1
    
    if command -v docker >/dev/null 2>&1; then
        log "Docker detected, checking functionality"
        if docker --version >/dev/null 2>&1; then
            success "Docker is working"
            ((tests_passed++))
        else
            error "Docker is installed but not working"
        fi
    else
        warning "Docker is not installed (this is normal for base template)"
        ((tests_passed++))
    fi
    
    [ $tests_passed -eq $tests_total ]
}

# Main testing function
main() {
    echo "========================================"
    log "TESTING ARCH-BASE TEMPLATE"
    echo "========================================"
    
    # Run all tests
    if run_test "Base System" test_base_system; then
        ((PASSED++))
    fi
    ((TOTAL++))
    
    if run_test "Git" test_git; then
        ((PASSED++))
    fi
    ((TOTAL++))
    
    if run_test "Network Connectivity" test_network; then
        ((PASSED++))
    fi
    ((TOTAL++))
    
    if run_test "Packages" test_packages; then
        ((PASSED++))
    fi
    ((TOTAL++))
    
    if run_test "Filesystem" test_filesystem; then
        ((PASSED++))
    fi
    ((TOTAL++))
    
    if run_test "Environment Variables" test_environment; then
        ((PASSED++))
    fi
    ((TOTAL++))
    
    if run_test "Docker (Optional)" test_docker; then
        ((PASSED++))
    fi
    ((TOTAL++))
    
    # Generate report
    generate_report $PASSED $TOTAL
}

# Run tests
main "$@"
