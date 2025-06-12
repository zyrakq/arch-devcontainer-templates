#!/bin/bash

# Common utilities for testing dev container templates

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Logging function
log() {
    echo -e "${BLUE}[$(date +'%Y-%m-%d %H:%M:%S')] $1${NC}"
}

# Success message function
success() {
    echo -e "${GREEN}✓ $1${NC}"
}

# Error message function
error() {
    echo -e "${RED}✗ $1${NC}"
}

# Warning message function
warning() {
    echo -e "${YELLOW}⚠ $1${NC}"
}

# Check if command exists
check_command() {
    local cmd="$1"
    local description="$2"
    
    log "Checking: $description"
    
    if command -v "$cmd" >/dev/null 2>&1; then
        success "$cmd is available"
        return 0
    else
        error "$cmd not found"
        return 1
    fi
}

# Check command version
check_version() {
    local cmd="$1"
    local version_flag="$2"
    local description="$3"
    
    log "Checking version: $description"
    
    if command -v "$cmd" >/dev/null 2>&1; then
        local version_output
        version_output=$($cmd $version_flag 2>&1)
        success "$cmd version: $version_output"
        return 0
    else
        error "$cmd not found"
        return 1
    fi
}

# Check network connectivity
check_network() {
    log "Checking network connectivity"
    
    if ping -c 1 8.8.8.8 >/dev/null 2>&1; then
        success "Network connectivity is working"
        return 0
    else
        error "No network connectivity"
        return 1
    fi
}

# Check pacman package
check_pacman_package() {
    local package="$1"
    
    log "Checking package: $package"
    
    if pacman -Q "$package" >/dev/null 2>&1; then
        local version
        version=$(pacman -Q "$package" | awk '{print $2}')
        success "Package $package is installed (version: $version)"
        return 0
    else
        error "Package $package is not installed"
        return 1
    fi
}

# Check file or directory path
check_path() {
    local path="$1"
    local description="$2"
    
    log "Checking path: $description"
    
    if [ -e "$path" ]; then
        success "Path $path exists"
        return 0
    else
        error "Path $path not found"
        return 1
    fi
}

# Check environment variable
check_env_var() {
    local var_name="$1"
    local description="$2"
    
    log "Checking environment variable: $description"
    
    if [ -n "${!var_name}" ]; then
        success "Variable $var_name is set: ${!var_name}"
        return 0
    else
        error "Variable $var_name is not set"
        return 1
    fi
}

# Run test with result tracking
run_test() {
    local test_name="$1"
    local test_function="$2"
    
    echo
    log "=== Running test: $test_name ==="
    
    if $test_function; then
        success "Test '$test_name' passed"
        return 0
    else
        error "Test '$test_name' failed"
        return 1
    fi
}

# Generate final report
generate_report() {
    local passed="$1"
    local total="$2"
    local failed=$((total - passed))
    
    echo
    echo "=================================="
    log "TEST REPORT"
    echo "=================================="
    echo -e "Total tests: ${BLUE}$total${NC}"
    echo -e "Passed: ${GREEN}$passed${NC}"
    echo -e "Failed: ${RED}$failed${NC}"
    
    if [ "$failed" -eq 0 ]; then
        echo
        success "ALL TESTS PASSED!"
        return 0
    else
        echo
        error "SOME TESTS FAILED!"
        return 1
    fi
}
