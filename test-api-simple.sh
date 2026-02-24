#!/bin/bash

# Simple API Test Script for macOS
echo "🧪 AI-HRMS API Test Suite"
echo "=========================="
echo ""

API="http://localhost:3000/api"
PASSED=0
FAILED=0

# Test 1: Health Check
echo "Test 1: Health Check"
if curl -s $API/health | grep -q "healthy"; then
    echo "✅ PASS"
    PASSED=$((PASSED + 1))
else
    echo "❌ FAIL"
    FAILED=$((FAILED + 1))
fi
echo ""

# Test 2: Register
echo "Test 2: Register Organization"
REGISTER_RESPONSE=$(curl -s -X POST $API/auth/register \
  -H "Content-Type: application/json" \
  -d '{"name":"TestOrg","email":"test'$(date +%s)'@test.com","password":"Test123!"}')

if echo "$REGISTER_RESPONSE" | grep -q "Organization registered successfully"; then
    echo "✅ PASS"
    PASSED=$((PASSED + 1))
else
    echo "❌ FAIL"
    echo "Response: $REGISTER_RESPONSE"
    FAILED=$((FAILED + 1))
fi
echo ""

# Test 3: Login
echo "Test 3: Login"
LOGIN_RESPONSE=$(curl -s -X POST $API/auth/login \
  -H "Content-Type: application/json" \
  -d '{"email":"admin@testcompany.com","password":"Admin123!"}')

if echo "$LOGIN_RESPONSE" | grep -q "accessToken"; then
    echo "✅ PASS"
    TOKEN=$(echo "$LOGIN_RESPONSE" | grep -o '"accessToken":"[^"]*"' | cut -d'"' -f4)
    PASSED=$((PASSED + 1))
else
    echo "❌ FAIL - Cannot get token, remaining tests will fail"
    echo "Response: $LOGIN_RESPONSE"
    FAILED=$((FAILED + 1))
    TOKEN=""
fi
echo ""

if [ -z "$TOKEN" ]; then
    echo "⚠️  No token available. Skipping authenticated tests."
    echo ""
    echo "Summary: $PASSED passed, $FAILED failed"
    exit 1
fi

# Test 4: Create Employee
echo "Test 4: Create Employee"
EMP_RESPONSE=$(curl -s -X POST $API/employees \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer $TOKEN" \
  -d '{"name":"Test Employee","email":"emp'$(date +%s)'@test.com","role":"Developer","department":"Engineering"}')

if echo "$EMP_RESPONSE" | grep -q "Test Employee"; then
    echo "✅ PASS"
    PASSED=$((PASSED + 1))
else
    echo "❌ FAIL"
    echo "Response: $EMP_RESPONSE"
    FAILED=$((FAILED + 1))
fi
echo ""

# Test 5: List Employees
echo "Test 5: List Employees"
if curl -s $API/employees -H "Authorization: Bearer $TOKEN" | grep -q "email"; then
    echo "✅ PASS"
    PASSED=$((PASSED + 1))
else
    echo "❌ FAIL"
    FAILED=$((FAILED + 1))
fi
echo ""

# Test 6: Dashboard Metrics
echo "Test 6: Dashboard Metrics"
if curl -s $API/dashboard/metrics -H "Authorization: Bearer $TOKEN" | grep -q "totalEmployees"; then
    echo "✅ PASS"
    PASSED=$((PASSED + 1))
else
    echo "❌ FAIL"
    FAILED=$((FAILED + 1))
fi
echo ""

# Test 7: Auth Security (no token)
echo "Test 7: Authentication Security"
STATUS=$(curl -s -o /dev/null -w "%{http_code}" $API/employees)
if [ "$STATUS" = "401" ]; then
    echo "✅ PASS - Correctly rejected request without token"
    PASSED=$((PASSED + 1))
else
    echo "❌ FAIL - Expected 401, got $STATUS"
    FAILED=$((FAILED + 1))
fi
echo ""

# Summary
echo "=========================="
echo "📊 Test Summary"
echo "=========================="
echo "Total: $((PASSED + FAILED))"
echo "✅ Passed: $PASSED"
echo "❌ Failed: $FAILED"
echo ""

if [ $FAILED -eq 0 ]; then
    echo "🎉 All tests passed!"
    exit 0
else
    echo "⚠️  Some tests failed"
    exit 1
fi
