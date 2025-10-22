#!/bin/bash
# Detect changed templates based on git diff
# Used by pipelight test-changed pipeline

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}🔍 Detecting changed templates...${NC}"

# Get list of changed files
CHANGED_FILES=$(git diff --name-only HEAD 2>/dev/null || git diff --name-only 2>/dev/null || echo "")

if [ -z "$CHANGED_FILES" ]; then
    echo -e "${YELLOW}⚠️  No changes detected in git${NC}"
    echo -e "${BLUE}ℹ️  Checking for uncommitted changes...${NC}"
    CHANGED_FILES=$(git status --porcelain | awk '{print $2}')
fi

if [ -z "$CHANGED_FILES" ]; then
    echo -e "${YELLOW}⚠️  No changes detected${NC}"
    echo -e "${BLUE}ℹ️  Use 'pipelight run test-all' to test all templates${NC}"
    exit 0
fi

# Detect which templates were changed
TEMPLATES_TO_TEST=""

# Check arch-base
if echo "$CHANGED_FILES" | grep -q "src/arch-base/"; then
    TEMPLATES_TO_TEST="$TEMPLATES_TO_TEST arch-base"
    echo -e "${GREEN}✓ arch-base template changed${NC}"
fi

# Check arch-webtop
if echo "$CHANGED_FILES" | grep -q "src/arch-webtop/"; then
    TEMPLATES_TO_TEST="$TEMPLATES_TO_TEST arch-webtop"
    echo -e "${GREEN}✓ arch-webtop template changed${NC}"
fi

# Check test files
if echo "$CHANGED_FILES" | grep -q "test/arch-base/"; then
    if ! echo "$TEMPLATES_TO_TEST" | grep -q "arch-base"; then
        TEMPLATES_TO_TEST="$TEMPLATES_TO_TEST arch-base"
        echo -e "${GREEN}✓ arch-base tests changed${NC}"
    fi
fi

if echo "$CHANGED_FILES" | grep -q "test/arch-webtop/"; then
    if ! echo "$TEMPLATES_TO_TEST" | grep -q "arch-webtop"; then
        TEMPLATES_TO_TEST="$TEMPLATES_TO_TEST arch-webtop"
        echo -e "${GREEN}✓ arch-webtop tests changed${NC}"
    fi
fi

# Export for use in next steps
if [ -n "$TEMPLATES_TO_TEST" ]; then
    echo "$TEMPLATES_TO_TEST" > /tmp/pipelight-templates-to-test
    echo -e "${BLUE}📋 Templates to test:${NC} $TEMPLATES_TO_TEST"
else
    echo -e "${YELLOW}⚠️  No template changes detected${NC}"
    echo "" > /tmp/pipelight-templates-to-test
fi