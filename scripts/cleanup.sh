#!/bin/bash
# Cleanup all test artifacts and Docker containers
# Can be run standalone or as part of pipelight cleanup pipeline

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}🧹 Starting cleanup...${NC}"

# Stop and remove test containers
echo -e "${BLUE}🛑 Stopping test containers...${NC}"
CONTAINERS=$(docker container ls -a -f "label=test-container" -q 2>/dev/null || true)
if [ -n "$CONTAINERS" ]; then
    docker rm -f $CONTAINERS 2>/dev/null || true
    echo -e "${GREEN}✓ Removed test containers${NC}"
else
    echo -e "${YELLOW}ℹ️  No test containers found${NC}"
fi

# Remove temporary directories
echo -e "${BLUE}🗑️  Removing temporary directories...${NC}"
REMOVED=0
for TEMPLATE in arch-base arch-webtop; do
    if [ -d "/tmp/$TEMPLATE" ]; then
        rm -rf "/tmp/$TEMPLATE"
        echo -e "${GREEN}✓ Removed /tmp/$TEMPLATE${NC}"
        ((REMOVED++))
    fi
done

if [ $REMOVED -eq 0 ]; then
    echo -e "${YELLOW}ℹ️  No temporary directories found${NC}"
fi

# Remove pipelight temporary files
if [ -f /tmp/pipelight-templates-to-test ]; then
    rm -f /tmp/pipelight-templates-to-test
    echo -e "${GREEN}✓ Removed pipelight temporary files${NC}"
fi

# Prune unused Docker images with test-container label
echo -e "${BLUE}🧹 Pruning unused Docker images...${NC}"
PRUNED=$(docker image prune -f --filter 'label=test-container' 2>/dev/null || echo "")
if [ -n "$PRUNED" ]; then
    echo -e "${GREEN}✓ Pruned unused images${NC}"
else
    echo -e "${YELLOW}ℹ️  No unused images to prune${NC}"
fi

echo -e "${GREEN}✅ Cleanup completed!${NC}"