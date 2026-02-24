# 🧪 Manual Testing Guide - Step by Step

## Overview
This guide will walk you through testing EVERY feature of the AI-HRMS platform manually. Follow each test case in order and check off as you complete them.

**Estimated Time:** 45-60 minutes  
**Prerequisites:** Backend and frontend servers running

---

## 🚀 Pre-Testing Setup

### Step 1: Verify Servers Are Running

**Backend Check:**
```bash
curl http://localhost:3000/api/health
```
✅ **Expected:** `{"status":"healthy","timestamp":"..."}`

**Frontend Check:**
Open browser: http://localhost:5173
✅ **Expected:** Login page loads

**If servers aren't running:**
```bash
# Terminal 1 - Backend
npm run dev --prefix backend

# Terminal 2 - Frontend  
npm run dev --prefix frontend
```

---

## 📋 Test Suite 1: Authentication System

### Test Case 1.1: Registration - Happy Path
**Objective:** Verify new organization can register successfully

**Steps:**
1. Open http://localhost:5173
2. Click "Sign up" or "Create account" link
3. Fill in the registration form:
   - Organization Name: `TechCorp Solutions`
   - Email: `admin@techcorp.com`
   - Password: `SecurePass123!`
   - Confirm Password: `SecurePass123!`
   - Industry: `Technology` (if field exists)
4. Click "Create Account" or "Register" button

**Expected Results:**
- ✅ Success message appears
- ✅ Redirected to login page
- ✅ No error messages
- ✅ Form clears after submission

**Actual Results:**
- [ ] Pass
- [ ] Fail (describe issue): _______________

---

### Test Case 1.2: Registration - Validation Testing
**Objective:** Verify form validation works correctly

**Test 1.2a: Weak Password**
1. Go to registration page
2. Enter:
   - Organization Name: `Test Company`
   - Email: `test@test.com`
   - Password: `123`
   - Confirm Password: `123`
3. Click "Create Account"

**Expected:** ❌ Error message about weak password
**Actual:** [ ] Pass [ ] Fail

**Test 1.2b: Password Mismatch**
1. Enter:
   - Password: `SecurePass123!`
   - Confirm Password: `DifferentPass123!`
2. Click "Create Account"

**Expected:** ❌ Error message about passwords not matching
**Actual:** [ ] Pass [ ] Fail

**Test 1.2c: Invalid Email**
1. Enter:
   - Email: `notanemail`
   - Password: `SecurePass123!`
2. Click "Create Account"

**Expected:** ❌ Error message about invalid email
**Actual:** [ ] Pass [ ] Fail

**Test 1.2d: Duplicate Email**
1. Try to register again with: `admin@techcorp.com`
2. Click "Create Account"

**Expected:** ❌ Error message about email already exists
**Actual:** [ ] Pass [ ] Fail

---

### Test Case 1.3: Login - Happy Path
**Objective:** Verify successful login

**Steps:**
1. Go to login page (http://localhost:5173)
2. Enter credentials:
   - Email: `admin@techcorp.com`
   - Password: `SecurePass123!`
3. Click "Login" button

**Expected Results:**
- ✅ Redirected to dashboard
- ✅ User info displayed in header (name/email)
- ✅ Navigation menu visible
- ✅ No error messages

**Actual Results:**
- [ ] Pass
- [ ] Fail (describe): _______________

---

### Test Case 1.4: Login - Error Scenarios
**Objective:** Verify login error handling

**Test 1.4a: Wrong Password**
1. Enter:
   - Email: `admin@techcorp.com`
   - Password: `WrongPassword123!`
2. Click "Login"

**Expected:** ❌ Error message "Invalid credentials"
**Actual:** [ ] Pass [ ] Fail

**Test 1.4b: Non-existent Email**
1. Enter:
   - Email: `nonexistent@test.com`
   - Password: `SecurePass123!`
2. Click "Login"

**Expected:** ❌ Error message "Invalid credentials"
**Actual:** [ ] Pass [ ] Fail

**Test 1.4c: Empty Fields**
1. Leave fields empty
2. Click "Login"

**Expected:** ❌ Validation errors for required fields
**Actual:** [ ] Pass [ ] Fail

---

### Test Case 1.5: Session Persistence
**Objective:** Verify user stays logged in

**Steps:**
1. Login successfully
2. Refresh the page (F5 or Cmd+R)
3. Check if still logged in

**Expected:** ✅ Still on dashboard, not redirected to login
**Actual:** [ ] Pass [ ] Fail

---

### Test Case 1.6: Logout
**Objective:** Verify logout functionality

**Steps:**
1. While logged in, click "Logout" button
2. Try to access dashboard directly: http://localhost:5173/dashboard

**Expected Results:**
- ✅ Redirected to login page
- ✅ Cannot access protected pages
- ✅ User info removed from header

**Actual:** [ ] Pass [ ] Fail

---

## 📋 Test Suite 2: Dashboard

### Test Case 2.1: Dashboard Display
**Objective:** Verify dashboard loads and displays metrics

**Steps:**
1. Login as `admin@techcorp.com`
2. Verify you're on dashboard page

**Expected Results:**
- ✅ Dashboard page loads
- ✅ Metric cards visible:
  - Total Employees
  - Active Employees
  - Assigned Tasks
  - Completed Tasks
  - Completion Rate
  - Average Productivity Score
- ✅ All metrics show numbers (may be 0 initially)
- ✅ No loading spinners stuck
- ✅ No error messages

**Actual:** [ ] Pass [ ] Fail

**Record Initial Metrics:**
- Total Employees: _____
- Active Employees: _____
- Assigned Tasks: _____
- Completed Tasks: _____
- Completion Rate: _____%
- Avg Productivity: _____

---

## 📋 Test Suite 3: Employee Management

### Test Case 3.1: View Empty Employee List
**Objective:** Verify employee page loads when empty

**Steps:**
1. Click "Employees" in navigation
2. Observe the page

**Expected Results:**
- ✅ Employee page loads
- ✅ "Add Employee" button visible
- ✅ Empty state message or empty table
- ✅ No errors

**Actual:** [ ] Pass [ ] Fail

---

### Test Case 3.2: Create Employee - Happy Path
**Objective:** Create first employee successfully

**Steps:**
1. Click "Add Employee" button
2. Fill in form:
   - Name: `Alice Johnson`
   - Email: `alice@techcorp.com`
   - Role: `Senior Frontend Developer`
   - Department: `Engineering`
   - Skills: `JavaScript, React, TypeScript, CSS`
   - Status: `Active` (if field exists)
3. Click "Save" or "Create"

**Expected Results:**
- ✅ Success message appears
- ✅ Modal/form closes
- ✅ Alice appears in employee list
- ✅ All entered data displays correctly

**Actual:** [ ] Pass [ ] Fail

---

### Test Case 3.3: Create Multiple Employees
**Objective:** Add more employees for testing

**Create Employee 2:**
- Name: `Bob Smith`
- Email: `bob@techcorp.com`
- Role: `Backend Developer`
- Department: `Engineering`
- Skills: `Node.js, PostgreSQL, Python, Docker`

**Create Employee 3:**
- Name: `Carol Davis`
- Email: `carol@techcorp.com`
- Role: `Product Manager`
- Department: `Product`
- Skills: `Product Strategy, Agile, User Research`

**Create Employee 4:**
- Name: `David Wilson`
- Email: `david@techcorp.com`
- Role: `UI/UX Designer`
- Department: `Design`
- Skills: `Figma, Sketch, Adobe XD, Prototyping`

**Expected:** ✅ All 4 employees visible in list
**Actual:** [ ] Pass [ ] Fail

---

### Test Case 3.4: Employee List Display
**Objective:** Verify employee list shows all data

**Steps:**
1. View the employee list
2. Check each employee card/row

**Expected Results:**
- ✅ All 4 employees visible
- ✅ Names displayed correctly
- ✅ Emails displayed correctly
- ✅ Roles displayed correctly
- ✅ Departments displayed correctly
- ✅ Skills displayed correctly
- ✅ Edit and Delete buttons visible

**Actual:** [ ] Pass [ ] Fail

---

### Test Case 3.5: Edit Employee
**Objective:** Verify employee can be updated

**Steps:**
1. Click "Edit" button for Alice Johnson
2. Modify:
   - Role: `Lead Frontend Developer` (changed from Senior)
   - Add skill: `Next.js`
3. Click "Save"

**Expected Results:**
- ✅ Success message appears
- ✅ Modal closes
- ✅ Alice's role updated to "Lead Frontend Developer"
- ✅ Skills now include "Next.js"
- ✅ Other fields unchanged

**Actual:** [ ] Pass [ ] Fail

---

### Test Case 3.6: Employee Validation
**Objective:** Test form validation

**Test 3.6a: Duplicate Email**
1. Click "Add Employee"
2. Enter email: `alice@techcorp.com` (already exists)
3. Fill other fields
4. Click "Save"

**Expected:** ❌ Error about duplicate email
**Actual:** [ ] Pass [ ] Fail

**Test 3.6b: Invalid Email Format**
1. Enter email: `notanemail`
2. Try to save

**Expected:** ❌ Validation error
**Actual:** [ ] Pass [ ] Fail

**Test 3.6c: Required Fields**
1. Leave Name empty
2. Try to save

**Expected:** ❌ Required field error
**Actual:** [ ] Pass [ ] Fail

---

### Test Case 3.7: Search/Filter Employees
**Objective:** Test employee filtering (if implemented)

**Steps:**
1. Look for search or filter options
2. Try filtering by:
   - Department: "Engineering"
   - Role: "Developer"
   - Status: "Active"

**Expected:** ✅ List filters correctly
**Actual:** [ ] Pass [ ] Fail [ ] Not Implemented

---

### Test Case 3.8: Delete Employee
**Objective:** Verify employee deletion

**Steps:**
1. Click "Add Employee" and create:
   - Name: `Test User`
   - Email: `test@techcorp.com`
   - Role: `Tester`
   - Department: `QA`
2. Click "Delete" button for Test User
3. Confirm deletion (if confirmation dialog appears)

**Expected Results:**
- ✅ Confirmation dialog appears
- ✅ After confirming, Test User removed from list
- ✅ Success message appears
- ✅ Other employees unaffected

**Actual:** [ ] Pass [ ] Fail

---

### Test Case 3.9: Dashboard Update After Employee Creation
**Objective:** Verify dashboard reflects new employees

**Steps:**
1. Go back to Dashboard
2. Check metrics

**Expected Results:**
- ✅ Total Employees: 4
- ✅ Active Employees: 4
- ✅ Metrics updated from initial values

**Actual:** [ ] Pass [ ] Fail

**Record Updated Metrics:**
- Total Employees: _____
- Active Employees: _____

---

## 📋 Test Suite 4: Task Management

### Test Case 4.1: View Empty Task List
**Objective:** Verify tasks page loads when empty

**Steps:**
1. Click "Tasks" in navigation
2. Observe the page

**Expected Results:**
- ✅ Tasks page loads
- ✅ "Add Task" or "Create Task" button visible
- ✅ Empty state or empty table
- ✅ No errors

**Actual:** [ ] Pass [ ] Fail

---

### Test Case 4.2: Create Task - Happy Path
**Objective:** Create first task successfully

**Steps:**
1. Click "Add Task" button
2. Fill in form:
   - Title: `Build User Dashboard`
   - Description: `Create responsive dashboard with charts and metrics`
   - Assign To: Select `Alice Johnson`
   - Complexity: `High`
   - Estimated Hours: `16`
   - Due Date: Select a future date (e.g., 7 days from now)
3. Click "Save" or "Create"

**Expected Results:**
- ✅ Success message appears
- ✅ Modal/form closes
- ✅ Task appears in list
- ✅ Status is "Assigned"
- ✅ Assigned to Alice Johnson
- ✅ All data displays correctly

**Actual:** [ ] Pass [ ] Fail

---

### Test Case 4.3: Create Multiple Tasks
**Objective:** Add more tasks for testing

**Create Task 2:**
- Title: `Implement REST API`
- Description: `Build authentication and CRUD endpoints`
- Assign To: `Bob Smith`
- Complexity: `Medium`
- Estimated Hours: `12`
- Due Date: Future date

**Create Task 3:**
- Title: `Design System Components`
- Description: `Create reusable UI components library`
- Assign To: `Alice Johnson`
- Complexity: `Medium`
- Estimated Hours: `10`
- Due Date: Future date

**Create Task 4:**
- Title: `User Research Study`
- Description: `Conduct interviews with 10 users`
- Assign To: `Carol Davis`
- Complexity: `Low`
- Estimated Hours: `8`
- Due Date: Future date

**Create Task 5:**
- Title: `Mobile App Wireframes`
- Description: `Create wireframes for mobile application`
- Assign To: `David Wilson`
- Complexity: `Medium`
- Estimated Hours: `12`
- Due Date: Future date

**Expected:** ✅ All 5 tasks visible in list
**Actual:** [ ] Pass [ ] Fail

---

### Test Case 4.4: Task List Display
**Objective:** Verify task list shows all data

**Steps:**
1. View the task list
2. Check each task

**Expected Results:**
- ✅ All 5 tasks visible
- ✅ Titles displayed
- ✅ Descriptions visible (or truncated)
- ✅ Assigned employee names shown
- ✅ Status badges visible (all should be "Assigned")
- ✅ Complexity shown
- ✅ Due dates displayed
- ✅ Status dropdown or buttons visible

**Actual:** [ ] Pass [ ] Fail

---

### Test Case 4.5: Update Task Status - Valid Transition
**Objective:** Test status workflow (assigned → in_progress → completed)

**Test 4.5a: Assigned → In Progress**
1. Find "Build User Dashboard" task (Alice's task)
2. Change status to "In Progress"

**Expected Results:**
- ✅ Status updates immediately
- ✅ Badge color changes (e.g., yellow/orange)
- ✅ Success message appears
- ✅ No errors

**Actual:** [ ] Pass [ ] Fail

**Test 4.5b: In Progress → Completed**
1. Change "Build User Dashboard" status to "Completed"

**Expected Results:**
- ✅ Status updates to "Completed"
- ✅ Badge color changes (e.g., green)
- ✅ Completion timestamp recorded
- ✅ Success message appears

**Actual:** [ ] Pass [ ] Fail

---

### Test Case 4.6: Update Task Status - Invalid Transition
**Objective:** Verify invalid status transitions are prevented

**Steps:**
1. Find a task with status "Assigned" (e.g., "Implement REST API")
2. Try to change status directly to "Completed" (skipping "In Progress")

**Expected:** ❌ Error message about invalid transition OR dropdown doesn't allow it
**Actual:** [ ] Pass [ ] Fail [ ] Not Enforced

---

### Test Case 4.7: Complete Multiple Tasks
**Objective:** Complete more tasks for testing

**Complete these tasks (assigned → in_progress → completed):**
1. "Implement REST API" (Bob's task)
2. "User Research Study" (Carol's task)

**Expected:** ✅ Both tasks show "Completed" status
**Actual:** [ ] Pass [ ] Fail

**Current Status:**
- Completed: 3 tasks (Build Dashboard, REST API, User Research)
- In Progress: 0 tasks
- Assigned: 2 tasks (Design System, Mobile Wireframes)

---

### Test Case 4.8: Task Filtering
**Objective:** Test task filters (if implemented)

**Steps:**
1. Look for filter options
2. Try filtering by:
   - Status: "Completed"
   - Status: "Assigned"
   - Employee: "Alice Johnson"

**Expected:** ✅ List filters correctly
**Actual:** [ ] Pass [ ] Fail [ ] Not Implemented

---

### Test Case 4.9: Edit Task
**Objective:** Verify task can be updated

**Steps:**
1. Click "Edit" for "Design System Components"
2. Modify:
   - Estimated Hours: `15` (changed from 10)
   - Complexity: `High` (changed from Medium)
3. Click "Save"

**Expected Results:**
- ✅ Success message
- ✅ Changes reflected in list
- ✅ Other fields unchanged

**Actual:** [ ] Pass [ ] Fail

---

### Test Case 4.10: Dashboard Update After Task Completion
**Objective:** Verify dashboard reflects task changes

**Steps:**
1. Go to Dashboard
2. Check metrics

**Expected Results:**
- ✅ Assigned Tasks: 2
- ✅ Completed Tasks: 3
- ✅ Completion Rate: 60% (3 out of 5)
- ✅ Metrics updated correctly

**Actual:** [ ] Pass [ ] Fail

**Record Metrics:**
- Assigned Tasks: _____
- Completed Tasks: _____
- Completion Rate: _____%

---

## 📋 Test Suite 5: AI Productivity Scoring

### Test Case 5.1: View Productivity Page
**Objective:** Verify productivity page loads

**Steps:**
1. Click "Productivity" in navigation
2. Observe the page

**Expected Results:**
- ✅ Productivity page loads
- ✅ Employee list with scores visible
- ✅ "Recalculate All" button visible (if exists)
- ✅ Scores displayed (0-100 range)

**Actual:** [ ] Pass [ ] Fail

---

### Test Case 5.2: Check Initial Productivity Scores
**Objective:** Verify scores are calculated

**Steps:**
1. View productivity scores for each employee
2. Note the scores

**Expected Results:**
- ✅ All employees have scores
- ✅ Scores are between 0-100
- ✅ Employees with completed tasks have higher scores
- ✅ Alice (1 completed) has a score
- ✅ Bob (1 completed) has a score
- ✅ Carol (1 completed) has a score
- ✅ David (0 completed) has lower/baseline score

**Actual:** [ ] Pass [ ] Fail

**Record Scores:**
- Alice Johnson: _____
- Bob Smith: _____
- Carol Davis: _____
- David Wilson: _____

---

### Test Case 5.3: Recalculate Scores
**Objective:** Test score recalculation

**Steps:**
1. Click "Recalculate All" button (if available)
2. Wait for calculation
3. Check if scores update

**Expected:** ✅ Scores recalculate, success message appears
**Actual:** [ ] Pass [ ] Fail [ ] Button Not Available

---

### Test Case 5.4: Score Ranking
**Objective:** Verify scores are ranked correctly

**Steps:**
1. Check if employees are sorted by score
2. Verify ranking makes sense

**Expected:**
- ✅ Employees with completed tasks ranked higher
- ✅ Sorting is logical
- ✅ Scores reflect task completion

**Actual:** [ ] Pass [ ] Fail

---

### Test Case 5.5: Score Updates After New Task Completion
**Objective:** Verify scores update when tasks are completed

**Steps:**
1. Go to Tasks page
2. Complete "Design System Components" (Alice's 2nd task)
   - Change to In Progress
   - Change to Completed
3. Go back to Productivity page
4. Check Alice's score

**Expected:** ✅ Alice's score increased (she now has 2 completed tasks)
**Actual:** [ ] Pass [ ] Fail

**Alice's New Score:** _____

---

## 📋 Test Suite 6: Integration & Data Flow

### Test Case 6.1: End-to-End Workflow
**Objective:** Test complete user journey

**Scenario: New Employee Joins and Completes Work**

**Steps:**
1. **Add New Employee:**
   - Name: `Emma Thompson`
   - Email: `emma@techcorp.com`
   - Role: `QA Engineer`
   - Department: `Engineering`
   - Skills: `Testing, Selenium, Jest`

2. **Check Dashboard:**
   - Total Employees should be 5

3. **Create Task for Emma:**
   - Title: `Write Test Cases`
   - Assign To: `Emma Thompson`
   - Complexity: `Medium`
   - Estimated Hours: `8`

4. **Check Dashboard:**
   - Assigned Tasks should increase by 1

5. **Complete Emma's Task:**
   - Change status: Assigned → In Progress → Completed

6. **Check Dashboard:**
   - Completed Tasks should increase by 1
   - Completion Rate should update

7. **Check Productivity:**
   - Emma should have a productivity score

**Expected:** ✅ All steps work, data flows correctly
**Actual:** [ ] Pass [ ] Fail

---

### Test Case 6.2: Multi-User Simulation
**Objective:** Test with multiple employees working

**Steps:**
1. Create 3 new tasks assigned to different employees
2. Complete 2 of them
3. Leave 1 in progress
4. Check dashboard metrics update correctly

**Expected:** ✅ All metrics accurate
**Actual:** [ ] Pass [ ] Fail

---

## 📋 Test Suite 7: Multi-Tenancy (Data Isolation)

### Test Case 7.1: Create Second Organization
**Objective:** Verify data isolation between organizations

**Steps:**
1. **Logout** from current session
2. **Register new organization:**
   - Organization Name: `DesignStudio Inc`
   - Email: `admin@designstudio.com`
   - Password: `Design123!`
3. **Login** with new credentials

**Expected Results:**
- ✅ Successfully registered and logged in
- ✅ Dashboard shows 0 employees
- ✅ Dashboard shows 0 tasks
- ✅ Empty employee list
- ✅ Empty task list
- ✅ Cannot see TechCorp's data

**Actual:** [ ] Pass [ ] Fail

---

### Test Case 7.2: Add Data to Second Organization
**Objective:** Verify second org can create its own data

**Steps:**
1. Create 2 employees in DesignStudio
2. Create 2 tasks
3. Check dashboard shows correct counts

**Expected:** ✅ DesignStudio has its own separate data
**Actual:** [ ] Pass [ ] Fail

---

### Test Case 7.3: Verify Data Isolation
**Objective:** Confirm organizations cannot see each other's data

**Steps:**
1. **Logout** from DesignStudio
2. **Login** as TechCorp (`admin@techcorp.com`)
3. Check employee and task lists

**Expected Results:**
- ✅ See only TechCorp's 5 employees
- ✅ See only TechCorp's tasks
- ✅ Dashboard shows TechCorp's metrics
- ✅ No DesignStudio data visible

**Actual:** [ ] Pass [ ] Fail

---

## 📋 Test Suite 8: UI/UX & Responsiveness

### Test Case 8.1: Navigation
**Objective:** Test all navigation links

**Steps:**
1. Click each menu item:
   - Dashboard
   - Employees
   - Tasks
   - Productivity
2. Verify each page loads correctly

**Expected:** ✅ All pages load without errors
**Actual:** [ ] Pass [ ] Fail

---

### Test Case 8.2: Responsive Design - Desktop
**Objective:** Test on desktop resolution

**Steps:**
1. Set browser to 1920x1080
2. Navigate through all pages
3. Check layout

**Expected Results:**
- ✅ Full sidebar visible
- ✅ Tables display properly
- ✅ Forms are readable
- ✅ No horizontal scrolling
- ✅ Content well-spaced

**Actual:** [ ] Pass [ ] Fail

---

### Test Case 8.3: Responsive Design - Tablet
**Objective:** Test on tablet resolution

**Steps:**
1. Resize browser to 768px width
2. Navigate through all pages

**Expected Results:**
- ✅ Layout adapts
- ✅ Sidebar collapses or becomes hamburger menu
- ✅ Tables scroll or stack
- ✅ Forms remain usable
- ✅ Buttons accessible

**Actual:** [ ] Pass [ ] Fail

---

### Test Case 8.4: Responsive Design - Mobile
**Objective:** Test on mobile resolution

**Steps:**
1. Resize browser to 375px width
2. Navigate through all pages

**Expected Results:**
- ✅ Mobile layout active
- ✅ Hamburger menu for navigation
- ✅ Tables scroll horizontally or stack
- ✅ Forms stack vertically
- ✅ Touch targets large enough
- ✅ All features accessible

**Actual:** [ ] Pass [ ] Fail

---

### Test Case 8.5: Loading States
**Objective:** Verify loading indicators work

**Steps:**
1. Refresh dashboard page
2. Watch for loading indicators
3. Navigate to employees page
4. Watch for loading

**Expected:** ✅ Loading spinners/skeletons appear briefly
**Actual:** [ ] Pass [ ] Fail

---

### Test Case 8.6: Error Messages
**Objective:** Verify error messages are user-friendly

**Steps:**
1. Review all error messages encountered during testing
2. Check they are:
   - Clear and understandable
   - Actionable (tell user what to do)
   - Not showing technical details to users

**Expected:** ✅ All error messages are user-friendly
**Actual:** [ ] Pass [ ] Fail

---

## 📋 Test Suite 9: Security

### Test Case 9.1: Protected Routes
**Objective:** Verify authentication is required

**Steps:**
1. **Logout** completely
2. Try to access these URLs directly:
   - http://localhost:5173/dashboard
   - http://localhost:5173/employees
   - http://localhost:5173/tasks
   - http://localhost:5173/productivity

**Expected:** ✅ All redirect to login page
**Actual:** [ ] Pass [ ] Fail

---

### Test Case 9.2: Session Timeout
**Objective:** Test token expiration (if implemented)

**Steps:**
1. Login
2. Wait for token to expire (1 hour by default)
3. Try to perform an action

**Expected:** ✅ Redirected to login or token refresh happens
**Actual:** [ ] Pass [ ] Fail [ ] Cannot Test (takes too long)

---

### Test Case 9.3: XSS Prevention
**Objective:** Verify XSS attacks are prevented

**Steps:**
1. Try to create employee with name: `<script>alert('XSS')</script>`
2. Save and view employee list

**Expected:** ✅ Script tags displayed as text, not executed
**Actual:** [ ] Pass [ ] Fail

---

## 📋 Test Suite 10: Performance

### Test Case 10.1: Page Load Times
**Objective:** Verify pages load quickly

**Steps:**
1. Open browser DevTools (F12)
2. Go to Network tab
3. Navigate to each page
4. Check load times

**Expected:** ✅ Pages load in < 2 seconds
**Actual:** [ ] Pass [ ] Fail

**Record Times:**
- Dashboard: _____ ms
- Employees: _____ ms
- Tasks: _____ ms
- Productivity: _____ ms

---

### Test Case 10.2: API Response Times
**Objective:** Verify API is responsive

**Steps:**
1. In DevTools Network tab
2. Filter by "XHR" or "Fetch"
3. Perform actions and check API call times

**Expected:** ✅ API calls complete in < 500ms
**Actual:** [ ] Pass [ ] Fail

---

## 📊 Test Results Summary

### Overall Results

**Authentication (6 tests):**
- Passed: _____
- Failed: _____

**Dashboard (2 tests):**
- Passed: _____
- Failed: _____

**Employee Management (9 tests):**
- Passed: _____
- Failed: _____

**Task Management (10 tests):**
- Passed: _____
- Failed: _____

**AI Productivity (5 tests):**
- Passed: _____
- Failed: _____

**Integration (2 tests):**
- Passed: _____
- Failed: _____

**Multi-Tenancy (3 tests):**
- Passed: _____
- Failed: _____

**UI/UX (6 tests):**
- Passed: _____
- Failed: _____

**Security (3 tests):**
- Passed: _____
- Failed: _____

**Performance (2 tests):**
- Passed: _____
- Failed: _____

---

**Total Tests:** 48
**Total Passed:** _____
**Total Failed:** _____
**Success Rate:** _____%

---

## 🐛 Bugs Found

Document any bugs found during testing:

**Bug #1:**
- Test Case: _____
- Description: _____
- Steps to Reproduce: _____
- Severity: Critical / High / Medium / Low
- Screenshot: _____

**Bug #2:**
- ...

---

## ✅ Sign-Off

**Tester Name:** _____________________
**Date:** _____________________
**Overall Assessment:** Pass / Fail / Pass with Issues

**Comments:**
_____________________________________
_____________________________________
_____________________________________

---

**Testing Complete! 🎉**

*Save this document with your test results for reference.*
