#!/bin/bash
# Test changed templates detected by detect-changes.sh
# Used by pipelight test-changed pipeline

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Read templates to test
if [ ! -f /tmp/pipelight-templates-to-test ]; then
    echo -e "${RED}❌ Error: No templates detected${NC}"
    echo -e "${BLUE}ℹ️  Run detect-changes.sh first${NC}"
    exit 1
fi

TEMPLATES=$(cat /tmp/pipelight-templates-to-test)

if [ -z "$TEMPLATES" ]; then
    echo -e "${YELLOW}⚠️  No templates to test${NC}"
    exit 0
fi

echo -e "${BLUE}🧪 Testing changed templates...${NC}"

# Test each template
FAILED_TEMPLATES=""
PASSED_TEMPLATES=""

for TEMPLATE in $TEMPLATES; do
    echo ""
    echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo -e "${BLUE}📦 Testing: $TEMPLATE${NC}"
    echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    
    # Build template
    echo -e "${BLUE}🔨 Building template...${NC}"
    if .github/actions/smoke-test/build.sh "$TEMPLATE"; then
        echo -e "${GREEN}✓ Build successful${NC}"
    else
        echo -e "${RED}✗ Build failed${NC}"
        FAILED_TEMPLATES="$FAILED_TEMPLATES $TEMPLATE"
        continue
    fi
    
    # Test template
    echo -e "${BLUE}🧪 Running tests...${NC}"
    if .github/actions/smoke-test/test.sh "$TEMPLATE"; then
        echo -e "${GREEN}✓ Tests passed${NC}"
        PASSED_TEMPLATES="$PASSED_TEMPLATES $TEMPLATE"
    else
        echo -e "${RED}✗ Tests failed${NC}"
        FAILED_TEMPLATES="$FAILED_TEMPLATES $TEMPLATE"
    fi
    
    # Cleanup
    echo -e "${BLUE}🧹 Cleaning up...${NC}"
    ID_LABEL="test-container=$TEMPLATE"
    docker rm -f $(docker container ls -f "label=$ID_LABEL" -q) 2>/dev/null || true
    rm -rf "/tmp/$TEMPLATE" 2>/dev/null || true
done

# Summary
echo ""
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${BLUE}📊 Test Summary${NC}"
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"

if [ -n "$PASSED_TEMPLATES" ]; then
    echo -e "${GREEN}✓ Passed:${NC}$PASSED_TEMPLATES"
fi

if [ -n "$FAILED_TEMPLATES" ]; then
    echo -e "${RED}✗ Failed:${NC}$FAILED_TEMPLATES"
    exit 1
fi

echo -e "${GREEN}✅ All tests passed!${NC}"