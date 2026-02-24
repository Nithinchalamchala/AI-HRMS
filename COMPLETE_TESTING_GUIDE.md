# 🧪 Complete Testing Guide - AI-HRMS Platform

## Overview
This guide provides step-by-step instructions to test all implemented features of the AI-HRMS platform.

**Estimated Testing Time:** 30-45 minutes

**Prerequisites:**
- ✅ Backend running on http://localhost:3000
- ✅ Frontend running on http://localhost:5173
- ✅ Database migrations completed
- ✅ Database seeded with skills and roles

---

## 📋 Testing Sections

1. [Backend API Testing](#backend-api-testing) (15 minutes)
2. [Frontend UI Testing](#frontend-ui-testing) (20 minutes)
3. [Integration Testing](#integration-testing) (10 minutes)
4. [Security Testing](#security-testing) (5 minutes)

---

## 🔧 Backend API Testing

### Test 1: Health Check
**Purpose:** Verify server is running and healthy

```bash
curl http://localhost:3000/api/health
```

**Expected Response:**
```json
{
  "status": "healthy",
  "timestamp": "2026-02-24T..."
}
```

**✅ Pass Criteria:** Status code 200, status is "healthy"

---

### Test 2: Organization Registration
**Purpose:** Test user registration and organization creation

```bash
curl -X POST http://localhost:3000/api/auth/register \
  -H "Content-Type: application/json" \
  -d '{
    "name": "TechCorp Solutions",
    "email": "admin@techcorp.com",
    "password": "SecurePass123!",
    "industry": "Technology"
  }'
```

**Expected Response:**
```json
{
  "message": "Organization registered successfully",
  "organization": {
    "id": "uuid-here",
    "name": "TechCorp Solutions",
    "email": "admin@techcorp.com",
    "industry": "Technology",
    "subscriptionTier": "free",
    "createdAt": "2026-02-24T..."
  }
}
```

**✅ Pass Criteria:**
- Status code 201
- Organization ID generated
- Email matches input
- Subscription tier is "free"

**Test Edge Cases:**
```bash
# Test duplicate email (should fail)
curl -X POST http://localhost:3000/api/auth/register \
  -H "Content-Type: application/json" \
  -d '{
    "name": "Another Company",
    "email": "admin@techcorp.com",
    "password": "SecurePass123!"
  }'
```
**Expected:** Error message about duplicate email

---

### Test 3: Organization Login
**Purpose:** Test authentication and JWT token generation

```bash
curl -X POST http://localhost:3000/api/auth/login \
  -H "Content-Type: application/json" \
  -d '{
    "email": "admin@techcorp.com",
    "password": "SecurePass123!"
  }'
```

**Expected Response:**
```json
{
  "message": "Login successful",
  "accessToken": "eyJhbGc...",
  "refreshToken": "eyJhbGc...",
  "expiresIn": "1h",
  "organization": {
    "id": "uuid-here",
    "name": "TechCorp Solutions",
    "email": "admin@techcorp.com",
    "subscriptionTier": "free"
  }
}
```

**✅ Pass Criteria:**
- Status code 200
- Access token present
- Refresh token present
- Organization details returned

**💾 IMPORTANT:** Save the accessToken for next tests!
```bash
export TOKEN="paste-your-access-token-here"
```

**Test Edge Cases:**
```bash
# Test wrong password (should fail)
curl -X POST http://localhost:3000/api/auth/login \
  -H "Content-Type: application/json" \
  -d '{
    "email": "admin@techcorp.com",
    "password": "WrongPassword"
  }'
```
**Expected:** 401 Unauthorized error

---

### Test 4: Create Employee
**Purpose:** Test employee creation with authentication

```bash
curl -X POST http://localhost:3000/api/employees \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer $TOKEN" \
  -d '{
    "name": "Alice Johnson",
    "email": "alice@techcorp.com",
    "role": "Senior Frontend Developer",
    "department": "Engineering",
    "skills": ["JavaScript", "React", "TypeScript", "CSS"],
    "status": "active"
  }'
```

**Expected Response:**
```json
{
  "id": 1,
  "name": "Alice Johnson",
  "email": "alice@techcorp.com",
  "role": "Senior Frontend Developer",
  "department": "Engineering",
  "skills": ["JavaScript", "React", "TypeScript", "CSS"],
  "status": "active",
  "organizationId": "uuid-here",
  "createdAt": "2026-02-24T..."
}
```

**✅ Pass Criteria:**
- Status code 201
- Employee ID generated
- All fields match input
- Organization ID matches your org

**Create More Employees:**
```bash
# Employee 2
curl -X POST http://localhost:3000/api/employees \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer $TOKEN" \
  -d '{
    "name": "Bob Smith",
    "email": "bob@techcorp.com",
    "role": "Backend Developer",
    "department": "Engineering",
    "skills": ["Node.js", "PostgreSQL", "Python"]
  }'

# Employee 3
curl -X POST http://localhost:3000/api/employees \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer $TOKEN" \
  -d '{
    "name": "Carol Davis",
    "email": "carol@techcorp.com",
    "role": "Product Manager",
    "department": "Product",
    "skills": ["Product Strategy", "Agile", "User Research"]
  }'
```

---

### Test 5: List Employees
**Purpose:** Test employee retrieval and filtering

```bash
# Get all employees
curl http://localhost:3000/api/employees \
  -H "Authorization: Bearer $TOKEN"
```

**Expected Response:**
```json
[
  {
    "id": 1,
    "name": "Alice Johnson",
    "email": "alice@techcorp.com",
    "role": "Senior Frontend Developer",
    "department": "Engineering",
    ...
  },
  {
    "id": 2,
    "name": "Bob Smith",
    ...
  },
  {
    "id": 3,
    "name": "Carol Davis",
    ...
  }
]
```

**✅ Pass Criteria:**
- Status code 200
- Array of employees returned
- All created employees present

**Test Filtering:**
```bash
# Filter by department
curl "http://localhost:3000/api/employees?department=Engineering" \
  -H "Authorization: Bearer $TOKEN"

# Filter by status
curl "http://localhost:3000/api/employees?status=active" \
  -H "Authorization: Bearer $TOKEN"
```

---

### Test 6: Get Single Employee
**Purpose:** Test retrieving specific employee details

```bash
curl http://localhost:3000/api/employees/1 \
  -H "Authorization: Bearer $TOKEN"
```

**Expected Response:**
```json
{
  "id": 1,
  "name": "Alice Johnson",
  "email": "alice@techcorp.com",
  "role": "Senior Frontend Developer",
  "department": "Engineering",
  "skills": ["JavaScript", "React", "TypeScript", "CSS"],
  "status": "active",
  ...
}
```

**✅ Pass Criteria:**
- Status code 200
- Correct employee details returned

---

### Test 7: Update Employee
**Purpose:** Test employee information updates

```bash
curl -X PUT http://localhost:3000/api/employees/1 \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer $TOKEN" \
  -d '{
    "name": "Alice Johnson",
    "email": "alice@techcorp.com",
    "role": "Lead Frontend Developer",
    "department": "Engineering",
    "skills": ["JavaScript", "React", "TypeScript", "CSS", "Next.js"]
  }'
```

**Expected Response:**
```json
{
  "id": 1,
  "name": "Alice Johnson",
  "role": "Lead Frontend Developer",
  "skills": ["JavaScript", "React", "TypeScript", "CSS", "Next.js"],
  ...
}
```

**✅ Pass Criteria:**
- Status code 200
- Updated fields reflect changes
- Unchanged fields remain the same

---

### Test 8: Create Tasks
**Purpose:** Test task creation and assignment

```bash
# Task 1 - Assigned to Alice
curl -X POST http://localhost:3000/api/tasks \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer $TOKEN" \
  -d '{
    "title": "Build User Dashboard",
    "description": "Create responsive dashboard with charts and metrics",
    "assigned_to": 1,
    "complexity": "high",
    "estimated_hours": 16,
    "due_date": "2026-03-01"
  }'

# Task 2 - Assigned to Bob
curl -X POST http://localhost:3000/api/tasks \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer $TOKEN" \
  -d '{
    "title": "Implement REST API",
    "description": "Build authentication and CRUD endpoints",
    "assigned_to": 2,
    "complexity": "medium",
    "estimated_hours": 12,
    "due_date": "2026-02-28"
  }'

# Task 3 - Assigned to Alice
curl -X POST http://localhost:3000/api/tasks \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer $TOKEN" \
  -d '{
    "title": "Design System Components",
    "description": "Create reusable UI components library",
    "assigned_to": 1,
    "complexity": "medium",
    "estimated_hours": 10,
    "due_date": "2026-02-27"
  }'
```

**Expected Response (for each):**
```json
{
  "id": 1,
  "title": "Build User Dashboard",
  "description": "Create responsive dashboard...",
  "assigned_to": 1,
  "status": "assigned",
  "complexity": "high",
  "estimated_hours": 16,
  ...
}
```

**✅ Pass Criteria:**
- Status code 201
- Task ID generated
- Status is "assigned"
- Assigned employee ID matches

---

### Test 9: List Tasks
**Purpose:** Test task retrieval and filtering

```bash
# Get all tasks
curl http://localhost:3000/api/tasks \
  -H "Authorization: Bearer $TOKEN"
```

**Expected Response:**
```json
[
  {
    "id": 1,
    "title": "Build User Dashboard",
    "status": "assigned",
    "assigned_to": 1,
    "employee_name": "Alice Johnson",
    ...
  },
  ...
]
```

**Test Filtering:**
```bash
# Filter by status
curl "http://localhost:3000/api/tasks?status=assigned" \
  -H "Authorization: Bearer $TOKEN"

# Filter by employee
curl "http://localhost:3000/api/tasks?employee_id=1" \
  -H "Authorization: Bearer $TOKEN"
```

**✅ Pass Criteria:**
- Status code 200
- All tasks returned
- Filters work correctly

---

### Test 10: Update Task Status
**Purpose:** Test task status transitions

```bash
# Update Task 1: assigned → in_progress
curl -X PATCH http://localhost:3000/api/tasks/1/status \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer $TOKEN" \
  -d '{"status": "in_progress"}'

# Update Task 1: in_progress → completed
curl -X PATCH http://localhost:3000/api/tasks/1/status \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer $TOKEN" \
  -d '{"status": "completed"}'

# Complete Task 2
curl -X PATCH http://localhost:3000/api/tasks/2/status \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer $TOKEN" \
  -d '{"status": "in_progress"}'

curl -X PATCH http://localhost:3000/api/tasks/2/status \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer $TOKEN" \
  -d '{"status": "completed"}'
```

**Expected Response:**
```json
{
  "id": 1,
  "status": "completed",
  "completed_at": "2026-02-24T...",
  ...
}
```

**✅ Pass Criteria:**
- Status code 200
- Status updated correctly
- Completed_at timestamp set when completed

**Test Invalid Transition:**
```bash
# Try to go from assigned to completed (should fail)
curl -X PATCH http://localhost:3000/api/tasks/3/status \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer $TOKEN" \
  -d '{"status": "completed"}'
```
**Expected:** Error about invalid status transition

---

### Test 11: Dashboard Metrics
**Purpose:** Test dashboard statistics calculation

```bash
curl http://localhost:3000/api/dashboard/metrics \
  -H "Authorization: Bearer $TOKEN"
```

**Expected Response:**
```json
{
  "totalEmployees": 3,
  "activeEmployees": 3,
  "assignedTasks": 1,
  "completedTasks": 2,
  "completionRate": 66.67,
  "averageProductivityScore": 75
}
```

**✅ Pass Criteria:**
- Status code 200
- Total employees = 3
- Completed tasks = 2
- Completion rate calculated correctly
- All metrics are numbers

---

### Test 12: AI Productivity Scoring
**Purpose:** Test AI-powered productivity calculation

```bash
# Get productivity score for Alice (employee 1)
curl http://localhost:3000/api/ai/productivity/1 \
  -H "Authorization: Bearer $TOKEN"
```

**Expected Response:**
```json
{
  "employeeId": 1,
  "score": 85,
  "completionRate": 100,
  "averageCompletionTime": 8,
  "tasksCompleted": 1,
  "tasksAssigned": 2,
  "calculatedAt": "2026-02-24T..."
}
```

**✅ Pass Criteria:**
- Status code 200
- Score between 0-100
- Completion rate calculated
- Tasks counted correctly

**Test Batch Calculation:**
```bash
curl -X POST http://localhost:3000/api/ai/batch-calculate \
  -H "Authorization: Bearer $TOKEN"
```

**Expected Response:**
```json
{
  "message": "Productivity scores calculated for 3 employees",
  "scores": [
    {"employeeId": 1, "score": 85},
    {"employeeId": 2, "score": 90},
    {"employeeId": 3, "score": 50}
  ]
}
```

---

### Test 13: Delete Employee
**Purpose:** Test employee deletion (optional - creates test data)

```bash
# Create a test employee to delete
curl -X POST http://localhost:3000/api/employees \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer $TOKEN" \
  -d '{
    "name": "Test User",
    "email": "test@techcorp.com",
    "role": "Tester",
    "department": "QA"
  }'

# Delete the employee (use the returned ID)
curl -X DELETE http://localhost:3000/api/employees/4 \
  -H "Authorization: Bearer $TOKEN"
```

**Expected Response:**
```json
{
  "message": "Employee deleted successfully"
}
```

**✅ Pass Criteria:**
- Status code 200
- Employee removed from database
- Associated tasks handled properly

---

## 🎨 Frontend UI Testing

### Setup
1. Open browser to: **http://localhost:5173**
2. Open browser DevTools (F12) to check for errors
3. Keep the Console tab open during testing

---

### Test 14: Registration Page
**Purpose:** Test user registration flow

**Steps:**
1. ✅ Click "Sign up" or "Create account" link
2. ✅ Verify registration form displays
3. ✅ Fill in the form:
   - Organization Name: "Design Studio"
   - Email: "admin@designstudio.com"
   - Password: "Design123!"
   - Confirm Password: "Design123!"
   - Industry: "Design" (optional)
4. ✅ Click "Create Account" button
5. ✅ Verify success message appears
6. ✅ Verify redirect to login page

**Test Validation:**
- Try weak password (e.g., "123") → Should show error
- Try mismatched passwords → Should show error
- Try invalid email format → Should show error
- Try duplicate email → Should show error

**✅ Pass Criteria:**
- Form validates inputs
- Success message displays
- Redirects to login
- No console errors

---

### Test 15: Login Page
**Purpose:** Test authentication flow

**Steps:**
1. ✅ Enter email: "admin@designstudio.com"
2. ✅ Enter password: "Design123!"
3. ✅ Click "Login" button
4. ✅ Verify redirect to dashboard
5. ✅ Verify user info displays (name/email in header)

**Test Error Handling:**
- Try wrong password → Should show error message
- Try non-existent email → Should show error message
- Leave fields empty → Should show validation errors

**✅ Pass Criteria:**
- Login successful with correct credentials
- Error messages display for invalid credentials
- Redirects to dashboard after login
- No console errors

---

### Test 16: Dashboard Page
**Purpose:** Test dashboard metrics display

**Steps:**
1. ✅ Verify dashboard loads
2. ✅ Check metrics cards display:
   - Total Employees
   - Active Employees
   - Assigned Tasks
   - Completed Tasks
   - Completion Rate
   - Average Productivity Score
3. ✅ Verify numbers match backend data
4. ✅ Check for loading states
5. ✅ Verify responsive layout (resize window)

**✅ Pass Criteria:**
- All metric cards visible
- Numbers display correctly
- Loading states work
- No console errors
- Responsive on different screen sizes

---

### Test 17: Employees Page - List View
**Purpose:** Test employee list display

**Steps:**
1. ✅ Click "Employees" in sidebar
2. ✅ Verify employee list displays
3. ✅ Check table columns:
   - Name
   - Email
   - Role
   - Department
   - Skills
   - Status
   - Actions (Edit/Delete)
4. ✅ Verify all employees from backend appear
5. ✅ Test search/filter functionality (if available)
6. ✅ Test pagination (if available)

**✅ Pass Criteria:**
- Employee list loads
- All employees visible
- Table is readable and formatted
- Actions buttons visible

---

### Test 18: Employees Page - Create Employee
**Purpose:** Test employee creation via UI

**Steps:**
1. ✅ Click "Add Employee" button
2. ✅ Verify modal/form opens
3. ✅ Fill in employee details:
   - Name: "David Wilson"
   - Email: "david@designstudio.com"
   - Role: "UI Designer"
   - Department: "Design"
   - Skills: "Figma, Sketch, Adobe XD"
   - Status: "active"
4. ✅ Click "Save" or "Create" button
5. ✅ Verify success message
6. ✅ Verify new employee appears in list
7. ✅ Verify modal closes

**Test Validation:**
- Try duplicate email → Should show error
- Try invalid email → Should show error
- Leave required fields empty → Should show errors

**✅ Pass Criteria:**
- Form validates inputs
- Employee created successfully
- List updates automatically
- No console errors

---

### Test 19: Employees Page - Edit Employee
**Purpose:** Test employee updates

**Steps:**
1. ✅ Click edit icon/button for an employee
2. ✅ Verify form pre-fills with current data
3. ✅ Update some fields:
   - Change role to "Senior UI Designer"
   - Add skill: "Prototyping"
4. ✅ Click "Save" button
5. ✅ Verify success message
6. ✅ Verify changes appear in list
7. ✅ Refresh page and verify changes persist

**✅ Pass Criteria:**
- Form pre-fills correctly
- Updates save successfully
- Changes persist after refresh
- No console errors

---

### Test 20: Employees Page - Delete Employee
**Purpose:** Test employee deletion

**Steps:**
1. ✅ Click delete icon/button for an employee
2. ✅ Verify confirmation dialog appears
3. ✅ Click "Confirm" or "Delete"
4. ✅ Verify success message
5. ✅ Verify employee removed from list
6. ✅ Refresh page and verify deletion persists

**✅ Pass Criteria:**
- Confirmation dialog shows
- Employee deleted successfully
- List updates automatically
- Deletion persists

---

### Test 21: Tasks Page - List View
**Purpose:** Test task list display

**Steps:**
1. ✅ Click "Tasks" in sidebar
2. ✅ Verify task list displays
3. ✅ Check table columns:
   - Title
   - Description
   - Assigned To
   - Status
   - Complexity
   - Due Date
   - Actions
4. ✅ Verify status badges have colors:
   - Assigned (blue/gray)
   - In Progress (yellow/orange)
   - Completed (green)
5. ✅ Test filters (by status, employee, etc.)

**✅ Pass Criteria:**
- Task list loads
- All tasks visible
- Status badges colored correctly
- Filters work (if implemented)

---

### Test 22: Tasks Page - Create Task
**Purpose:** Test task creation via UI

**Steps:**
1. ✅ Click "Add Task" or "Create Task" button
2. ✅ Verify form opens
3. ✅ Fill in task details:
   - Title: "Create Landing Page"
   - Description: "Design and implement homepage"
   - Assign To: Select "David Wilson"
   - Complexity: "Medium"
   - Estimated Hours: 8
   - Due Date: Select future date
4. ✅ Click "Save" or "Create" button
5. ✅ Verify success message
6. ✅ Verify new task appears in list
7. ✅ Verify status is "assigned"

**✅ Pass Criteria:**
- Form validates inputs
- Employee dropdown populated
- Task created successfully
- List updates automatically

---

### Test 23: Tasks Page - Update Task Status
**Purpose:** Test task status transitions

**Steps:**
1. ✅ Find a task with status "assigned"
2. ✅ Change status dropdown to "in_progress"
3. ✅ Verify status updates immediately
4. ✅ Verify badge color changes
5. ✅ Change status to "completed"
6. ✅ Verify status updates
7. ✅ Verify completion timestamp shows

**Test Invalid Transition:**
- Try changing "assigned" directly to "completed"
- Should show error or prevent the action

**✅ Pass Criteria:**
- Status updates work
- Badge colors change
- Invalid transitions prevented
- No console errors

---

### Test 24: Productivity Page
**Purpose:** Test AI productivity scoring display

**Steps:**
1. ✅ Click "Productivity" in sidebar
2. ✅ Verify productivity page loads
3. ✅ Check employee list with scores:
   - Employee Name
   - Role
   - Productivity Score (0-100)
   - Completion Rate
   - Tasks Completed
4. ✅ Verify scores are displayed as numbers or progress bars
5. ✅ Click "Recalculate All" button (if available)
6. ✅ Verify scores update
7. ✅ Check sorting (by score, name, etc.)

**✅ Pass Criteria:**
- Productivity scores display
- Scores are between 0-100
- Recalculation works
- Sorting works (if implemented)
- No console errors

---

### Test 25: Navigation & Layout
**Purpose:** Test overall UI navigation

**Steps:**
1. ✅ Verify sidebar navigation:
   - Dashboard link
   - Employees link
   - Tasks link
   - Productivity link
2. ✅ Click each navigation item
3. ✅ Verify correct page loads
4. ✅ Verify active state highlights current page
5. ✅ Check header displays:
   - Organization name
   - User email
   - Logout button
6. ✅ Test logout:
   - Click logout button
   - Verify redirect to login
   - Try accessing protected pages
   - Should redirect to login

**✅ Pass Criteria:**
- All navigation links work
- Active states display correctly
- Logout works properly
- Protected routes require authentication

---

### Test 26: Responsive Design
**Purpose:** Test UI on different screen sizes

**Steps:**
1. ✅ Desktop (1920x1080):
   - Verify full layout displays
   - Check sidebar is visible
   - Check tables are readable
2. ✅ Tablet (768x1024):
   - Verify layout adjusts
   - Check sidebar behavior (collapse/hamburger?)
   - Check tables scroll or stack
3. ✅ Mobile (375x667):
   - Verify mobile layout
   - Check navigation (hamburger menu?)
   - Check forms are usable
   - Check tables are scrollable

**✅ Pass Criteria:**
- Layout adapts to screen size
- All features accessible on mobile
- No horizontal scrolling (unless intentional)
- Touch targets are large enough

---

### Test 27: Error Handling & Loading States
**Purpose:** Test UI feedback mechanisms

**Steps:**
1. ✅ Test loading states:
   - Refresh dashboard
   - Verify loading spinner/skeleton appears
   - Verify data loads after
2. ✅ Test error states:
   - Stop backend server
   - Try to load data
   - Verify error message displays
   - Restart backend
   - Verify recovery
3. ✅ Test form validation:
   - Submit empty forms
   - Verify validation messages
   - Fix errors
   - Verify submission works

**✅ Pass Criteria:**
- Loading states display
- Error messages are clear
- Validation messages are helpful
- UI recovers from errors

---

## 🔗 Integration Testing

### Test 28: End-to-End User Flow
**Purpose:** Test complete user journey

**Scenario: New Organization Onboarding**

**Steps:**
1. ✅ Register new organization:
   - Name: "StartupCo"
   - Email: "ceo@startupco.com"
   - Password: "Startup123!"
2. ✅ Login with new credentials
3. ✅ Verify empty dashboard (0 employees, 0 tasks)
4. ✅ Create 3 employees:
   - Engineer
   - Designer
   - Product Manager
5. ✅ Verify dashboard shows 3 employees
6. ✅ Create 5 tasks assigned to different employees
7. ✅ Verify dashboard shows 5 assigned tasks
8. ✅ Complete 3 tasks:
   - Change status to in_progress
   - Change status to completed
9. ✅ Verify dashboard updates:
   - Assigned tasks: 2
   - Completed tasks: 3
   - Completion rate: 60%
10. ✅ View productivity page
11. ✅ Verify scores calculated for employees
12. ✅ Logout
13. ✅ Login again
14. ✅ Verify all data persists

**✅ Pass Criteria:**
- Complete flow works without errors
- Data persists across sessions
- Metrics calculate correctly
- No console errors throughout

---

### Test 29: Multi-Tenancy Isolation
**Purpose:** Test data isolation between organizations

**Steps:**
1. ✅ Login as Organization A (TechCorp)
2. ✅ Note employee count and names
3. ✅ Logout
4. ✅ Login as Organization B (Design Studio)
5. ✅ Verify different employee list
6. ✅ Verify cannot see Organization A's data
7. ✅ Create employee in Organization B
8. ✅ Logout
9. ✅ Login as Organization A
10. ✅ Verify Organization B's employee not visible
11. ✅ Verify Organization A's data unchanged

**✅ Pass Criteria:**
- Each organization sees only their data
- No data leakage between organizations
- Creating data in one org doesn't affect another

---

### Test 30: Task Completion Workflow
**Purpose:** Test complete task lifecycle

**Steps:**
1. ✅ Create new task assigned to employee
2. ✅ Verify task appears with status "assigned"
3. ✅ Verify dashboard shows +1 assigned task
4. ✅ Update task status to "in_progress"
5. ✅ Verify status badge changes
6. ✅ Update task status to "completed"
7. ✅ Verify completion timestamp set
8. ✅ Verify dashboard updates:
   - Assigned tasks -1
   - Completed tasks +1
   - Completion rate increases
9. ✅ Check productivity page
10. ✅ Verify employee's score updated

**✅ Pass Criteria:**
- Task lifecycle works correctly
- Dashboard metrics update in real-time
- Productivity scores recalculate
- All state changes persist

---

## 🔒 Security Testing

### Test 31: Authentication Security
**Purpose:** Test authentication protection

**Steps:**
1. ✅ Logout from application
2. ✅ Try to access protected URLs directly:
   - http://localhost:5173/dashboard
   - http://localhost:5173/employees
   - http://localhost:5173/tasks
3. ✅ Verify redirect to login page
4. ✅ Try API calls without token:
```bash
curl http://localhost:3000/api/employees
```
5. ✅ Verify 401 Unauthorized response

**✅ Pass Criteria:**
- Protected routes require authentication
- API returns 401 without token
- Redirects work properly

---

### Test 32: Authorization Security
**Purpose:** Test cross-organization access prevention

**Steps:**
1. ✅ Login as Organization A
2. ✅ Get employee ID from Organization A
3. ✅ Get access token
4. ✅ Logout
5. ✅ Login as Organization B
6. ✅ Try to access Organization A's employee via API:
```bash
curl http://localhost:3000/api/employees/[ORG_A_EMPLOYEE_ID] \
  -H "Authorization: Bearer [ORG_B_TOKEN]"
```
7. ✅ Verify 403 Forbidden or 404 Not Found

**✅ Pass Criteria:**
- Cannot access other organization's data
- Proper error codes returned
- No data leakage

---

### Test 33: Input Validation
**Purpose:** Test input sanitization and validation

**Test SQL Injection:**
```bash
curl -X POST http://localhost:3000/api/employees \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer $TOKEN" \
  -d '{
    "name": "Robert\"; DROP TABLE employees; --",
    "email": "test@test.com",
    "role": "Tester"
  }'
```
**Expected:** Employee created with literal name, no SQL injection

**Test XSS:**
```bash
curl -X POST http://localhost:3000/api/employees \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer $TOKEN" \
  -d '{
    "name": "<script>alert(\"XSS\")</script>",
    "email": "xss@test.com",
    "role": "Tester"
  }'
```
**Expected:** Script tags escaped or sanitized

**✅ Pass Criteria:**
- SQL injection prevented
- XSS attacks prevented
- Input properly sanitized

---

## 📊 Test Results Summary

### Backend API Tests (13 tests)
- [ ] Test 1: Health Check
- [ ] Test 2: Organization Registration
- [ ] Test 3: Organization Login
- [ ] Test 4: Create Employee
- [ ] Test 5: List Employees
- [ ] Test 6: Get Single Employee
- [ ] Test 7: Update Employee
- [ ] Test 8: Create Tasks
- [ ] Test 9: List Tasks
- [ ] Test 10: Update Task Status
- [ ] Test 11: Dashboard Metrics
- [ ] Test 12: AI Productivity Scoring
- [ ] Test 13: Delete Employee

### Frontend UI Tests (14 tests)
- [ ] Test 14: Registration Page
- [ ] Test 15: Login Page
- [ ] Test 16: Dashboard Page
- [ ] Test 17: Employees List View
- [ ] Test 18: Create Employee
- [ ] Test 19: Edit Employee
- [ ] Test 20: Delete Employee
- [ ] Test 21: Tasks List View
- [ ] Test 22: Create Task
- [ ] Test 23: Update Task Status
- [ ] Test 24: Productivity Page
- [ ] Test 25: Navigation & Layout
- [ ] Test 26: Responsive Design
- [ ] Test 27: Error Handling

### Integration Tests (3 tests)
- [ ] Test 28: End-to-End User Flow
- [ ] Test 29: Multi-Tenancy Isolation
- [ ] Test 30: Task Completion Workflow

### Security Tests (3 tests)
- [ ] Test 31: Authentication Security
- [ ] Test 32: Authorization Security
- [ ] Test 33: Input Validation

**Total Tests: 33**

---

## 🐛 Bug Tracking Template

If you find bugs during testing, document them:

**Bug #1:**
- **Test:** Test number and name
- **Severity:** Critical / High / Medium / Low
- **Description:** What went wrong
- **Steps to Reproduce:** How to recreate the bug
- **Expected:** What should happen
- **Actual:** What actually happened
- **Screenshot:** (if applicable)

---

## ✅ Sign-Off Checklist

Before proceeding to next implementation phase:

- [ ] All backend API tests pass
- [ ] All frontend UI tests pass
- [ ] Integration tests pass
- [ ] Security tests pass
- [ ] No critical bugs found
- [ ] Performance is acceptable
- [ ] Documentation is accurate
- [ ] Ready for next features

---

## 📝 Notes

- Keep browser DevTools console open during testing
- Check Network tab for API call details
- Take screenshots of any issues
- Document any unexpected behavior
- Test on multiple browsers if possible (Chrome, Firefox, Safari)

---

## 🎯 What's Working (Expected Results)

After completing all tests, you should have verified:

✅ **Authentication System**
- Registration with validation
- Login with JWT tokens
- Protected routes
- Multi-tenancy isolation

✅ **Employee Management**
- Create, read, update, delete employees
- Skills and role tracking
- Department organization
- Data validation

✅ **Task Management**
- Create and assign tasks
- Status transitions (assigned → in_progress → completed)
- Task filtering and search
- Due date tracking

✅ **Dashboard**
- Real-time metrics
- Employee statistics
- Task statistics
- Completion rates

✅ **AI Features**
- Productivity score calculation
- Automatic scoring on task completion
- Score rankings
- Batch calculations

✅ **Security**
- Password hashing
- JWT authentication
- Input validation
- SQL injection prevention
- XSS prevention
- Multi-tenancy isolation

---

**Testing Complete! 🎉**

Once all tests pass, you're ready to implement the remaining features:
- AI Skill Gap Detection
- Smart Task Assignment
- Performance Trend Prediction
- Blockchain Integration
- Advanced Analytics

Good luck with your testing!
