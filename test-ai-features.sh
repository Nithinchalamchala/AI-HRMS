#!/bin/bash

# AI Features Test Script
echo "🤖 AI-HRMS AI Features Test"
echo "============================"
echo ""

API="http://localhost:3000/api"
PASSED=0
FAILED=0

# Login to get token
echo "Logging in..."
LOGIN_RESPONSE=$(curl -s -X POST $API/auth/login \
  -H "Content-Type: application/json" \
  -d '{"email":"admin@testcompany.com","password":"Admin123!"}')

TOKEN=$(echo "$LOGIN_RESPONSE" | grep -o '"accessToken":"[^"]*"' | cut -d'"' -f4)

if [ -z "$TOKEN" ]; then
    echo "❌ Failed to get authentication token"
    echo "Response: $LOGIN_RESPONSE"
    exit 1
fi

echo "✅ Authenticated successfully"
echo ""

# Test 1: Get All Productivity Scores
echo "Test 1: Get All Productivity Scores"
SCORES_RESPONSE=$(curl -s $API/ai/scores -H "Authorization: Bearer $TOKEN")
if echo "$SCORES_RESPONSE" | grep -q "scores"; then
    echo "✅ PASS"
    PASSED=$((PASSED + 1))
else
    echo "❌ FAIL"
    echo "Response: $SCORES_RESPONSE"
    FAILED=$((FAILED + 1))
fi
echo ""

# Test 2: Get Organization Skill Gaps
echo "Test 2: Get Organization Skill Gaps"
SKILL_GAPS_RESPONSE=$(curl -s $API/ai/skill-gaps -H "Authorization: Bearer $TOKEN")
if echo "$SKILL_GAPS_RESPONSE" | grep -q "skillGaps"; then
    echo "✅ PASS"
    PASSED=$((PASSED + 1))
else
    echo "❌ FAIL"
    echo "Response: $SKILL_GAPS_RESPONSE"
    FAILED=$((FAILED + 1))
fi
echo ""

# Test 3: Get Task Assignment Recommendations
echo "Test 3: Get Task Assignment Recommendations"
RECOMMENDATIONS_RESPONSE=$(curl -s -X POST $API/ai/recommend-assignment \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer $TOKEN" \
  -d '{"requiredSkills":["JavaScript","React"],"complexity":"high","department":"Engineering"}')

if echo "$RECOMMENDATIONS_RESPONSE" | grep -q "recommendations"; then
    echo "✅ PASS"
    PASSED=$((PASSED + 1))
else
    echo "❌ FAIL"
    echo "Response: $RECOMMENDATIONS_RESPONSE"
    FAILED=$((FAILED + 1))
fi
echo ""

# Test 4: Get Organization Performance Trends
echo "Test 4: Get Organization Performance Trends"
TRENDS_RESPONSE=$(curl -s $API/ai/performance-trends -H "Authorization: Bearer $TOKEN")
if echo "$TRENDS_RESPONSE" | grep -q "trends"; then
    echo "✅ PASS"
    PASSED=$((PASSED + 1))
else
    echo "❌ FAIL"
    echo "Response: $TRENDS_RESPONSE"
    FAILED=$((FAILED + 1))
fi
echo ""

# Test 5: Get At-Risk Employees
echo "Test 5: Get At-Risk Employees"
AT_RISK_RESPONSE=$(curl -s $API/ai/at-risk -H "Authorization: Bearer $TOKEN")
if echo "$AT_RISK_RESPONSE" | grep -q "employees"; then
    echo "✅ PASS"
    PASSED=$((PASSED + 1))
else
    echo "❌ FAIL"
    echo "Response: $AT_RISK_RESPONSE"
    FAILED=$((FAILED + 1))
fi
echo ""

# Summary
echo "============================"
echo "📊 AI Features Test Summary"
echo "============================"
echo "Total: $((PASSED + FAILED))"
echo "✅ Passed: $PASSED"
echo "❌ Failed: $FAILED"
echo ""

if [ $FAILED -eq 0 ]; then
    echo "🎉 All AI features working!"
    exit 0
else
    echo "⚠️  Some AI features failed"
    exit 1
fi
