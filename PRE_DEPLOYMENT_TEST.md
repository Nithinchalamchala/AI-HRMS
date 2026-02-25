# ✅ Pre-Deployment Testing Checklist

## Quick Test Before Deployment (10-15 minutes)

Run through this checklist to ensure everything works before deploying.

---

## 🏃 Quick Start

```bash
# Make sure both servers are running
# Terminal 1 - Backend
cd backend && npm run dev

# Terminal 2 - Frontend  
cd frontend && npm run dev
```

**URLs**:
- Frontend: http://localhost:5173
- Backend: http://localhost:3000

---

## ✅ Test Checklist

### 1. Authentication (2 minutes)

- [ ] **Register New Organization**
  - Go to http://localhost:5173/register
  - Fill form with valid data
  - Click Register
  - ✅ Should redirect to login
  - ✅ Should show success message

- [ ] **Login**
  - Use: admin@testcompany.com / Admin123!
  - Click Login
  - ✅ Should redirect to dashboard
  - ✅ Should see welcome message

- [ ] **Logout**
  - Click logout button
  - ✅ Should redirect to login
  - ✅ Should clear session

- [ ] **Protected Routes**
  - Try accessing /dashboard without login
  - ✅ Should redirect to login

---

### 2. Dashboard (1 minute)

- [ ] **View Metrics**
  - ✅ Total employees shows number
  - ✅ Active employees shows number
  - ✅ Task counts display
  - ✅ Productivity indicators visible
  - ✅ No console errors

---

### 3. Employee Management (3 minutes)

- [ ] **Create Employee**
  - Click "Add Employee"
  - Fill all fields:
    - Name: Test Employee
    - Email: test@example.com
    - Role: Developer
    - Department: Engineering
    - Skills: JavaScript, React
  - Click Save
  - ✅ Employee appears in list
  - ✅ Success toast shows

- [ ] **View Employee List**
  - ✅ All employees display
  - ✅ Can see name, email, role, department
  - ✅ Skills show as tags

- [ ] **Edit Employee**
  - Click edit on an employee
  - Change name or role
  - Click Save
  - ✅ Changes reflect immediately
  - ✅ Success toast shows

- [ ] **Filter Employees**
  - Use department filter
  - ✅ List updates correctly

- [ ] **Delete Employee** (optional - be careful!)
  - Click delete on test employee
  - Confirm deletion
  - ✅ Employee removed from list

---

### 4. Task Management (4 minutes)

- [ ] **Create Task**
  - Click "Create Task"
  - Fill form:
    - Title: Test Task
    - Description: Testing task creation
    - Assign to: (select employee)
    - Complexity: Medium
    - Due date: (future date)
  - Click Save
  - ✅ Task appears in list
  - ✅ Status shows "Assigned"

- [ ] **View Task List**
  - ✅ All tasks display
  - ✅ Can see title, assignee, status, complexity
  - ✅ Due dates visible

- [ ] **Update Task Status**
  - Select a task
  - Change status: Assigned → In Progress
  - ✅ Status updates
  - Change status: In Progress → Completed
  - ✅ Status updates
  - ✅ Can't skip states (try Assigned → Completed, should fail)

- [ ] **Edit Task**
  - Click edit on a task
  - Change title or description
  - Click Save
  - ✅ Changes reflect

- [ ] **Filter Tasks**
  - Filter by status
  - ✅ List updates correctly
  - Filter by employee
  - ✅ Shows only that employee's tasks

---

### 5. AI Features (5 minutes)

#### Productivity Scores

- [ ] **View Scores**
  - Navigate to Productivity page
  - ✅ Employee list with scores displays
  - ✅ Scores are between 0-100
  - ✅ Rankings visible

- [ ] **Batch Recalculate**
  - Click "Recalculate All"
  - ✅ Success message shows
  - ✅ Scores may update

#### Skill Gaps

- [ ] **Organization View**
  - Navigate to Skill Gaps page
  - ✅ Organization-wide gaps display
  - ✅ Shows missing skills count
  - ✅ Priority levels visible

- [ ] **Employee View**
  - Select an employee from dropdown
  - ✅ Individual skill gaps show
  - ✅ Missing skills listed
  - ✅ Recommendations display

#### Performance Trends

- [ ] **View Trends**
  - Navigate to Performance Trends page
  - ✅ All employee trends display
  - ✅ Trend indicators show (📈📉➡️)
  - ✅ Confidence scores visible

- [ ] **At Risk Filter**
  - Click "At Risk" filter
  - ✅ Shows only declining employees
  - ✅ Contributing factors visible

#### Smart Task Assignment

- [ ] **Get Recommendations**
  - Go to Tasks page
  - Click "Create Task"
  - Fill in:
    - Required Skills: JavaScript, React
    - Complexity: High
    - Department: Engineering
  - ✅ Recommendations appear
  - ✅ Suitability scores show
  - ✅ Reasoning displayed
  - ✅ Can assign to recommended employee

---

### 6. API Tests (2 minutes)

Run automated tests:

```bash
# Test basic API
./test-api-simple.sh

# Test AI features
./test-ai-features.sh
```

- [ ] ✅ All API tests pass (7/7)
- [ ] ✅ All AI tests pass (5/5)

---

### 7. Browser Console Check (1 minute)

- [ ] **Check for Errors**
  - Open browser DevTools (F12)
  - Go to Console tab
  - Navigate through all pages
  - ✅ No red errors
  - ✅ No failed network requests
  - ⚠️ Warnings are OK

---

### 8. Responsive Design (1 minute)

- [ ] **Test Different Sizes**
  - Open DevTools (F12)
  - Toggle device toolbar (Ctrl+Shift+M)
  - Try different sizes:
    - Desktop (1920x1080)
    - Laptop (1366x768)
    - Tablet (768x1024)
  - ✅ Layout adjusts properly
  - ✅ No horizontal scroll
  - ✅ Buttons accessible

---

## 🐛 Common Issues & Fixes

### Issue: Can't login
**Fix**: Check backend is running on port 3000

### Issue: No data showing
**Fix**: Run database seed: `cd backend && npm run seed`

### Issue: API errors
**Fix**: Check backend logs for errors

### Issue: Frontend won't load
**Fix**: Check frontend is running on port 5173

### Issue: CORS errors
**Fix**: Check backend CORS_ORIGIN in .env

---

## ✅ All Tests Passed?

If everything above works:
- ✅ **Ready for deployment!**
- ✅ **Ready for video recording!**

If issues found:
- 🔧 Fix issues first
- 🔄 Re-test
- 📝 Document any workarounds

---

## 📊 Test Results

**Date**: _____________
**Tester**: _____________

**Results**:
- Authentication: ☐ Pass ☐ Fail
- Dashboard: ☐ Pass ☐ Fail
- Employees: ☐ Pass ☐ Fail
- Tasks: ☐ Pass ☐ Fail
- AI Features: ☐ Pass ☐ Fail
- API Tests: ☐ Pass ☐ Fail
- Console: ☐ Pass ☐ Fail
- Responsive: ☐ Pass ☐ Fail

**Overall**: ☐ READY FOR DEPLOYMENT ☐ NEEDS FIXES

**Notes**:
_____________________________________________
_____________________________________________
_____________________________________________

---

## 🚀 Next Steps

After all tests pass:

1. ✅ Commit any fixes
2. ✅ Push to GitHub
3. ✅ Follow DEPLOYMENT_GUIDE.md
4. ✅ Test deployed version
5. ✅ Record video using VIDEO_DEMO_GUIDE.md

**Estimated Time**: 10-15 minutes for complete testing
