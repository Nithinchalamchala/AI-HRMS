#!/bin/bash

# AI-HRMS Platform - Automated API Testing Script
# This script tests all backend API endpoints

set -e

# Colors
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

API_BASE="http://localhost:3000/api"
TOKEN=""
ORG_ID=""
EMPLOYEE_IDS=()
TASK_IDS=()

echo -e "${BLUE}╔════════════════════════════════════════╗${NC}"
echo -e "${BLUE}║  AI-HRMS API Automated Test Suite     ║${NC}"
echo -e "${BLUE}╔════════════════════════════════════════╗${NC}"
echo ""

# Test counter
TESTS_PASSED=0
TESTS_FAILED=0
TOTAL_TESTS=0

# Function to print test result
test_result() {
    TOTAL_TESTS=$((TOTAL_TESTS + 1))
    if [ $1 -eq 0 ]; then
        echo -e "${GREEN}✓ PASS${NC} - $2"
        TESTS_PASSED=$((TESTS_PASSED + 1))
    else
        echo -e "${RED}✗ FAIL${NC} - $2"
        TESTS_FAILED=$((TESTS_FAILED + 1))
    fi
}

# Test 1: Health Check
echo -e "\n${YELLOW}Test 1: Health Check${NC}"
RESPONSE=$(curl -s -w "\n%{http_code}" $API_BASE/health)
HTTP_CODE=$(echo "$RESPONSE" | tail -n 1)
BODY=$(echo "$RESPONSE" | sed '$d')

if [ "$HTTP_CODE" = "200" ] && echo "$BODY" | grep -q "healthy"; then
    test_result 0 "Health check endpoint"
else
    test_result 1 "Health check endpoint (HTTP $HTTP_CODE)"
fi

# Test 2: Register Organization
echo -e "\n${YELLOW}Test 2: Register Organization${NC}"
RESPONSE=$(curl -s -w "\n%{http_code}" -X POST $API_BASE/auth/register \
  -H "Content-Type: application/json" \
  -d '{
    "name": "Test Organization",
    "email": "test@example.com",
    "password": "Test123!",
    "industry": "Technology"
  }')
HTTP_CODE=$(echo "$RESPONSE" | tail -n1)
BODY=$(echo "$RESPONSE" | head -n-1)

if [ "$HTTP_CODE" = "201" ] && echo "$BODY" | grep -q "Organization registered successfully"; then
    test_result 0 "Organization registration"
    ORG_ID=$(echo "$BODY" | grep -o '"id":"[^"]*"' | head -1 | cut -d'"' -f4)
else
    test_result 1 "Organization registration (HTTP $HTTP_CODE)"
fi

# Test 3: Login
echo -e "\n${YELLOW}Test 3: Login${NC}"
RESPONSE=$(curl -s -w "\n%{http_code}" -X POST $API_BASE/auth/login \
  -H "Content-Type: application/json" \
  -d '{
    "email": "test@example.com",
    "password": "Test123!"
  }')
HTTP_CODE=$(echo "$RESPONSE" | tail -n1)
BODY=$(echo "$RESPONSE" | head -n-1)

if [ "$HTTP_CODE" = "200" ] && echo "$BODY" | grep -q "accessToken"; then
    test_result 0 "Login with valid credentials"
    TOKEN=$(echo "$BODY" | grep -o '"accessToken":"[^"]*"' | cut -d'"' -f4)
else
    test_result 1 "Login with valid credentials (HTTP $HTTP_CODE)"
    echo "Cannot proceed without token. Exiting."
    exit 1
fi

# Test 4: Create Employees
echo -e "\n${YELLOW}Test 4: Create Employees${NC}"

# Employee 1
RESPONSE=$(curl -s -w "\n%{http_code}" -X POST $API_BASE/employees \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer $TOKEN" \
  -d '{
    "name": "Alice Johnson",
    "email": "alice@example.com",
    "role": "Frontend Developer",
    "department": "Engineering",
    "skills": ["JavaScript", "React", "TypeScript"]
  }')
HTTP_CODE=$(echo "$RESPONSE" | tail -n1)
BODY=$(echo "$RESPONSE" | head -n-1)

if [ "$HTTP_CODE" = "201" ]; then
    test_result 0 "Create employee (Alice)"
    EMP_ID=$(echo "$BODY" | grep -o '"id":[0-9]*' | head -1 | cut -d':' -f2)
    EMPLOYEE_IDS+=($EMP_ID)
else
    test_result 1 "Create employee (Alice) (HTTP $HTTP_CODE)"
fi

# Employee 2
RESPONSE=$(curl -s -w "\n%{http_code}" -X POST $API_BASE/employees \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer $TOKEN" \
  -d '{
    "name": "Bob Smith",
    "email": "bob@example.com",
    "role": "Backend Developer",
    "department": "Engineering",
    "skills": ["Node.js", "PostgreSQL"]
  }')
HTTP_CODE=$(echo "$RESPONSE" | tail -n1)

if [ "$HTTP_CODE" = "201" ]; then
    test_result 0 "Create employee (Bob)"
    BODY=$(echo "$RESPONSE" | head -n-1)
    EMP_ID=$(echo "$BODY" | grep -o '"id":[0-9]*' | head -1 | cut -d':' -f2)
    EMPLOYEE_IDS+=($EMP_ID)
else
    test_result 1 "Create employee (Bob) (HTTP $HTTP_CODE)"
fi

# Test 5: List Employees
echo -e "\n${YELLOW}Test 5: List Employees${NC}"
RESPONSE=$(curl -s -w "\n%{http_code}" $API_BASE/employees \
  -H "Authorization: Bearer $TOKEN")
HTTP_CODE=$(echo "$RESPONSE" | tail -n1)
BODY=$(echo "$RESPONSE" | head -n-1)

if [ "$HTTP_CODE" = "200" ] && echo "$BODY" | grep -q "Alice Johnson"; then
    test_result 0 "List all employees"
else
    test_result 1 "List all employees (HTTP $HTTP_CODE)"
fi

# Test 6: Get Single Employee
echo -e "\n${YELLOW}Test 6: Get Single Employee${NC}"
if [ ${#EMPLOYEE_IDS[@]} -gt 0 ]; then
    RESPONSE=$(curl -s -w "\n%{http_code}" $API_BASE/employees/${EMPLOYEE_IDS[0]} \
      -H "Authorization: Bearer $TOKEN")
    HTTP_CODE=$(echo "$RESPONSE" | tail -n1)
    
    if [ "$HTTP_CODE" = "200" ]; then
        test_result 0 "Get employee by ID"
    else
        test_result 1 "Get employee by ID (HTTP $HTTP_CODE)"
    fi
else
    test_result 1 "Get employee by ID (No employee ID available)"
fi

# Test 7: Update Employee
echo -e "\n${YELLOW}Test 7: Update Employee${NC}"
if [ ${#EMPLOYEE_IDS[@]} -gt 0 ]; then
    RESPONSE=$(curl -s -w "\n%{http_code}" -X PUT $API_BASE/employees/${EMPLOYEE_IDS[0]} \
      -H "Content-Type: application/json" \
      -H "Authorization: Bearer $TOKEN" \
      -d '{
        "name": "Alice Johnson",
        "email": "alice@example.com",
        "role": "Senior Frontend Developer",
        "department": "Engineering",
        "skills": ["JavaScript", "React", "TypeScript", "Next.js"]
      }')
    HTTP_CODE=$(echo "$RESPONSE" | tail -n1)
    
    if [ "$HTTP_CODE" = "200" ]; then
        test_result 0 "Update employee"
    else
        test_result 1 "Update employee (HTTP $HTTP_CODE)"
    fi
else
    test_result 1 "Update employee (No employee ID available)"
fi

# Test 8: Create Tasks
echo -e "\n${YELLOW}Test 8: Create Tasks${NC}"
if [ ${#EMPLOYEE_IDS[@]} -gt 0 ]; then
    RESPONSE=$(curl -s -w "\n%{http_code}" -X POST $API_BASE/tasks \
      -H "Content-Type: application/json" \
      -H "Authorization: Bearer $TOKEN" \
      -d "{
        \"title\": \"Build Dashboard\",
        \"description\": \"Create admin dashboard\",
        \"assigned_to\": ${EMPLOYEE_IDS[0]},
        \"complexity\": \"high\",
        \"estimated_hours\": 16
      }")
    HTTP_CODE=$(echo "$RESPONSE" | tail -n1)
    BODY=$(echo "$RESPONSE" | head -n-1)
    
    if [ "$HTTP_CODE" = "201" ]; then
        test_result 0 "Create task"
        TASK_ID=$(echo "$BODY" | grep -o '"id":[0-9]*' | head -1 | cut -d':' -f2)
        TASK_IDS+=($TASK_ID)
    else
        test_result 1 "Create task (HTTP $HTTP_CODE)"
    fi
else
    test_result 1 "Create task (No employee ID available)"
fi

# Test 9: List Tasks
echo -e "\n${YELLOW}Test 9: List Tasks${NC}"
RESPONSE=$(curl -s -w "\n%{http_code}" $API_BASE/tasks \
  -H "Authorization: Bearer $TOKEN")
HTTP_CODE=$(echo "$RESPONSE" | tail -n1)

if [ "$HTTP_CODE" = "200" ]; then
    test_result 0 "List all tasks"
else
    test_result 1 "List all tasks (HTTP $HTTP_CODE)"
fi

# Test 10: Update Task Status
echo -e "\n${YELLOW}Test 10: Update Task Status${NC}"
if [ ${#TASK_IDS[@]} -gt 0 ]; then
    # Update to in_progress
    RESPONSE=$(curl -s -w "\n%{http_code}" -X PATCH $API_BASE/tasks/${TASK_IDS[0]}/status \
      -H "Content-Type: application/json" \
      -H "Authorization: Bearer $TOKEN" \
      -d '{"status": "in_progress"}')
    HTTP_CODE=$(echo "$RESPONSE" | tail -n1)
    
    if [ "$HTTP_CODE" = "200" ]; then
        test_result 0 "Update task status to in_progress"
    else
        test_result 1 "Update task status to in_progress (HTTP $HTTP_CODE)"
    fi
    
    # Update to completed
    RESPONSE=$(curl -s -w "\n%{http_code}" -X PATCH $API_BASE/tasks/${TASK_IDS[0]}/status \
      -H "Content-Type: application/json" \
      -H "Authorization: Bearer $TOKEN" \
      -d '{"status": "completed"}')
    HTTP_CODE=$(echo "$RESPONSE" | tail -n1)
    
    if [ "$HTTP_CODE" = "200" ]; then
        test_result 0 "Update task status to completed"
    else
        test_result 1 "Update task status to completed (HTTP $HTTP_CODE)"
    fi
else
    test_result 1 "Update task status (No task ID available)"
fi

# Test 11: Dashboard Metrics
echo -e "\n${YELLOW}Test 11: Dashboard Metrics${NC}"
RESPONSE=$(curl -s -w "\n%{http_code}" $API_BASE/dashboard/metrics \
  -H "Authorization: Bearer $TOKEN")
HTTP_CODE=$(echo "$RESPONSE" | tail -n1)
BODY=$(echo "$RESPONSE" | head -n-1)

if [ "$HTTP_CODE" = "200" ] && echo "$BODY" | grep -q "totalEmployees"; then
    test_result 0 "Get dashboard metrics"
else
    test_result 1 "Get dashboard metrics (HTTP $HTTP_CODE)"
fi

# Test 12: AI Productivity Scoring
echo -e "\n${YELLOW}Test 12: AI Productivity Scoring${NC}"
if [ ${#EMPLOYEE_IDS[@]} -gt 0 ]; then
    RESPONSE=$(curl -s -w "\n%{http_code}" $API_BASE/ai/productivity/${EMPLOYEE_IDS[0]} \
      -H "Authorization: Bearer $TOKEN")
    HTTP_CODE=$(echo "$RESPONSE" | tail -n1)
    BODY=$(echo "$RESPONSE" | head -n-1)
    
    if [ "$HTTP_CODE" = "200" ] && echo "$BODY" | grep -q "score"; then
        test_result 0 "Get productivity score"
    else
        test_result 1 "Get productivity score (HTTP $HTTP_CODE)"
    fi
else
    test_result 1 "Get productivity score (No employee ID available)"
fi

# Test 13: Authentication Without Token
echo -e "\n${YELLOW}Test 13: Authentication Security${NC}"
RESPONSE=$(curl -s -w "\n%{http_code}" $API_BASE/employees)
HTTP_CODE=$(echo "$RESPONSE" | tail -n1)

if [ "$HTTP_CODE" = "401" ]; then
    test_result 0 "Reject request without token"
else
    test_result 1 "Reject request without token (Expected 401, got $HTTP_CODE)"
fi

# Summary
echo -e "\n${BLUE}╔════════════════════════════════════════╗${NC}"
echo -e "${BLUE}║           Test Summary                 ║${NC}"
echo -e "${BLUE}╚════════════════════════════════════════╝${NC}"
echo -e "Total Tests:  ${TOTAL_TESTS}"
echo -e "${GREEN}Passed:       ${TESTS_PASSED}${NC}"
echo -e "${RED}Failed:       ${TESTS_FAILED}${NC}"
echo -e "Success Rate: $(awk "BEGIN {printf \"%.1f\", ($TESTS_PASSED/$TOTAL_TESTS)*100}")%"
echo ""

if [ $TESTS_FAILED -eq 0 ]; then
    echo -e "${GREEN}🎉 All tests passed!${NC}"
    exit 0
else
    echo -e "${RED}❌ Some tests failed. Please review the output above.${NC}"
    exit 1
fi
