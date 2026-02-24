# ✅ Simple Testing Checklist

Quick checklist for manual testing. Check off each item as you test.

## 🚀 Pre-Testing
- [ ] Backend running on http://localhost:3000
- [ ] Frontend running on http://localhost:5173
- [ ] Health check passes: `curl http://localhost:3000/api/health`

---

## 🔐 Authentication
- [ ] Can register new organization
- [ ] Password validation works (weak password rejected)
- [ ] Email validation works (invalid email rejected)
- [ ] Duplicate email rejected
- [ ] Can login with correct credentials
- [ ] Wrong password rejected
- [ ] Session persists after page refresh
- [ ] Can logout successfully
- [ ] Cannot access protected pages when logged out

---

## 📊 Dashboard
- [ ] Dashboard loads without errors
- [ ] All metric cards visible
- [ ] Metrics show correct numbers
- [ ] Metrics update after creating employees/tasks

---

## 👥 Employee Management
- [ ] Can view employee list (empty initially)
- [ ] Can create new employee
- [ ] Employee appears in list with correct data
- [ ] Can create multiple employees (create 4-5)
- [ ] Can edit employee
- [ ] Changes save correctly
- [ ] Can delete employee
- [ ] Duplicate email validation works
- [ ] Required field validation works
- [ ] Search/filter works (if implemented)

---

## 📋 Task Management
- [ ] Can view task list (empty initially)
- [ ] Can create new task
- [ ] Can assign task to employee
- [ ] Task appears in list with correct data
- [ ] Can create multiple tasks (create 5+)
- [ ] Can update task status: Assigned → In Progress
- [ ] Can update task status: In Progress → Completed
- [ ] Cannot skip status (Assigned → Completed blocked)
- [ ] Can edit task details
- [ ] Can filter tasks by status (if implemented)
- [ ] Completed tasks show completion timestamp

---

## 🤖 AI Productivity
- [ ] Productivity page loads
- [ ] All employees have scores (0-100)
- [ ] Employees with completed tasks have higher scores
- [ ] Can recalculate scores (if button exists)
- [ ] Scores update after completing new tasks
- [ ] Scores are ranked/sorted correctly

---

## 🔗 Integration & Data Flow
- [ ] Creating employee increases dashboard count
- [ ] Creating task increases dashboard count
- [ ] Completing task updates completion rate
- [ ] Completing task updates productivity score
- [ ] All data persists after page refresh
- [ ] Complete end-to-end workflow works

---

## 🏢 Multi-Tenancy
- [ ] Can create second organization
- [ ] Second org has empty dashboard
- [ ] Second org cannot see first org's data
- [ ] First org cannot see second org's data
- [ ] Data is completely isolated

---

## 📱 UI/UX
- [ ] All navigation links work
- [ ] Desktop layout looks good (1920px)
- [ ] Tablet layout adapts (768px)
- [ ] Mobile layout works (375px)
- [ ] Loading states appear
- [ ] Error messages are clear
- [ ] Forms are user-friendly
- [ ] No console errors in browser

---

## 🔒 Security
- [ ] Protected routes redirect to login
- [ ] XSS attempts are prevented
- [ ] SQL injection attempts are prevented
- [ ] Authentication required for all API calls

---

## ⚡ Performance
- [ ] Pages load quickly (< 2 seconds)
- [ ] API calls respond quickly (< 500ms)
- [ ] No lag when interacting with UI
- [ ] Large lists scroll smoothly

---

## 📊 Final Counts

After completing all tests, record final state:

**Organization 1 (TechCorp):**
- Employees: _____
- Tasks Created: _____
- Tasks Completed: _____
- Completion Rate: _____%

**Organization 2 (DesignStudio):**
- Employees: _____
- Tasks Created: _____
- Tasks Completed: _____

---

## ✅ Overall Result

- [ ] All critical features work
- [ ] No blocking bugs found
- [ ] Ready for submission

**Total Tests Passed:** _____ / 60
**Success Rate:** _____%

---

## 🐛 Issues Found

List any issues:
1. _____________________
2. _____________________
3. _____________________

---

**Tested By:** _____________________
**Date:** _____________________
**Status:** ✅ PASS / ❌ FAIL / ⚠️ PASS WITH ISSUES
