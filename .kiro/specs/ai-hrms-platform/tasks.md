# Implementation Plan: AI-HRMS Platform

## Overview

This implementation plan breaks down the AI-HRMS Platform into discrete, actionable tasks. The platform will be built using Node.js/Express for the backend, PostgreSQL for the database, React for the frontend, Solidity for smart contracts, and Polygon for blockchain integration. Tasks are organized to build incrementally, with testing integrated throughout.

## Tasks

- [x] 1. Project setup and infrastructure
  - Initialize Node.js backend project with TypeScript, Express, and necessary dependencies
  - Initialize React frontend project with TypeScript, Tailwind CSS, and React Query
  - Set up PostgreSQL database with connection pooling
  - Configure environment variables for development, staging, and production
  - Set up ESLint, Prettier, and TypeScript configurations
  - Create project directory structure following best practices
  - _Requirements: 23.1, 23.2, 23.3_

- [x] 2. Database schema implementation
  - [x] 2.1 Create database migration scripts for all tables
    - Implement Organizations table with indexes
    - Implement Employees table with foreign keys and indexes
    - Implement Tasks table with status constraints and indexes
    - Implement Productivity_Scores table with unique constraints
    - Implement Blockchain_Transactions table with status tracking
    - Implement Skill_Taxonomy and Role_Requirements tables
    - _Requirements: 15.1, 15.2, 15.3, 15.4, 15.5, 15.6_
  
  - [x] 2.2 Write property test for database constraints
    - **Property: Data integrity enforcement**
    - **Validates: Requirements 15.2, 15.3, 15.4**
  
  - [x] 2.3 Create database seeding scripts for development
    - Seed skill taxonomy with common technical and soft skills
    - Seed role requirements for common roles (Developer, Manager, Designer, etc.)
    - _Requirements: 29.5_


- [x] 3. Authentication and authorization system
  - [x] 3.1 Implement password hashing service using bcrypt
    - Create password hashing and verification functions
    - Configure bcrypt with 10 rounds
    - _Requirements: 1.6_
  
  - [x] 3.2 Implement JWT token generation and verification
    - Create token generation with 1-hour expiration
    - Implement refresh token rotation logic
    - Create token verification middleware
    - _Requirements: 1.3, 1.5_
  
  - [x] 3.3 Implement organization registration endpoint
    - Create POST /api/auth/register endpoint
    - Validate registration data (email format, password strength)
    - Check for duplicate email addresses
    - Hash password and store organization
    - _Requirements: 1.1, 1.2_
  
  - [x] 3.4 Implement organization login endpoint
    - Create POST /api/auth/login endpoint
    - Verify credentials against database
    - Generate and return JWT tokens
    - _Requirements: 1.3, 1.4_
  
  - [x] 3.5 Implement authentication middleware
    - Extract and verify JWT from Authorization header
    - Inject organizationId and role into request context
    - Handle expired tokens and invalid signatures
    - _Requirements: 12.1, 1.5_
  
  - [x] 3.6 Write property tests for authentication
    - **Property: Password hashing is one-way**
    - **Validates: Requirements 1.6**
  
  - [x] 3.7 Write unit tests for authentication endpoints
    - Test successful registration and login flows
    - Test duplicate email rejection
    - Test invalid credentials rejection
    - Test token expiration handling
    - _Requirements: 1.1, 1.2, 1.3, 1.4, 1.5_

- [x] 4. Multi-tenancy and access control
  - [x] 4.1 Implement organization context middleware
    - Automatically inject organization_id filter into all queries
    - Create helper functions for organization-scoped queries
    - _Requirements: 30.1, 30.2, 12.2, 12.3_
  
  - [x] 4.2 Implement role-based access control middleware
    - Create middleware to check admin vs employee roles
    - Implement permission checking for admin-only operations
    - _Requirements: 12.5, 12.6_
  
  - [x] 4.3 Write property test for data isolation
    - **Property: Cross-organization data leakage prevention**
    - **Validates: Requirements 30.1, 30.3, 12.2, 12.3**


- [x] 5. Employee management implementation
  - [x] 5.1 Implement employee data validation service
    - Create validation schemas for employee data
    - Implement email format validation
    - Implement wallet address format validation
    - _Requirements: 2.2, 2.6, 18.1, 18.3, 18.4_
  
  - [x] 5.2 Implement employee CRUD endpoints
    - Create POST /api/employees endpoint (create employee)
    - Create GET /api/employees endpoint (list with filters)
    - Create GET /api/employees/:id endpoint (get single employee)
    - Create PUT /api/employees/:id endpoint (update employee)
    - Create DELETE /api/employees/:id endpoint (delete employee)
    - _Requirements: 2.1, 2.3, 2.4, 2.5_
  
  - [x] 5.3 Implement wallet connection endpoint
    - Create POST /api/employees/:id/wallet endpoint
    - Validate wallet address format for Polygon network
    - Update employee profile with wallet address
    - _Requirements: 9.2, 9.5, 9.6_
  
  - [x] 5.4 Implement employee deletion cascade logic
    - Update related tasks when employee is deleted
    - Maintain referential integrity
    - _Requirements: 2.4, 15.3_
  
  - [x] 5.5 Write property tests for employee management
    - **Property: Employee email uniqueness within organization**
    - **Validates: Requirements 15.4**
  
  - [x] 5.6 Write unit tests for employee endpoints
    - Test employee creation with valid data
    - Test validation error handling
    - Test employee filtering by department and role
    - Test wallet connection and validation
    - _Requirements: 2.1, 2.2, 2.6_

- [x] 6. Task management implementation
  - [x] 6.1 Implement task status validation service
    - Create status transition validation logic
    - Enforce valid transitions: assigned → in_progress → completed
    - _Requirements: 3.6_
  
  - [x] 6.2 Implement task CRUD endpoints
    - Create POST /api/tasks endpoint (create task)
    - Create GET /api/tasks endpoint (list with filters)
    - Create GET /api/tasks/:id endpoint (get single task)
    - Create PUT /api/tasks/:id endpoint (update task)
    - Create PATCH /api/tasks/:id/status endpoint (update status)
    - Create DELETE /api/tasks/:id endpoint (delete task)
    - _Requirements: 3.1, 3.2, 3.3, 3.4, 3.7_
  
  - [x] 6.3 Implement task completion trigger logic
    - Trigger productivity score recalculation on completion
    - Trigger blockchain logging on completion (if wallet connected)
    - Record completion timestamp
    - _Requirements: 3.5_
  
  - [x] 6.4 Write property tests for task management
    - **Property: Task status transition validity**
    - **Validates: Requirements 3.6**
  
  - [x] 6.5 Write unit tests for task endpoints
    - Test task creation and assignment
    - Test invalid employee assignment rejection
    - Test status transition enforcement
    - Test task filtering by status and employee
    - _Requirements: 3.1, 3.2, 3.3, 3.4, 3.6_


- [x] 7. Dashboard metrics implementation
  - [x] 7.1 Implement dashboard metrics calculation service
    - Calculate total employee count
    - Calculate active employee count (activity within 7 days)
    - Calculate assigned and completed task counts
    - Calculate productivity indicators (completion rate, average score)
    - _Requirements: 4.1, 4.2, 4.3, 4.4, 4.5, 4.7_
  
  - [x] 7.2 Implement dashboard caching layer
    - Set up Redis or in-memory cache
    - Cache metrics with 5-minute TTL
    - Implement cache invalidation on data changes
    - _Requirements: 4.6, 17.2_
  
  - [x] 7.3 Implement dashboard endpoints
    - Create GET /api/dashboard/metrics endpoint
    - Create GET /api/dashboard/trends endpoint with time period filters
    - _Requirements: 4.1, 4.2, 4.3, 4.4, 4.5_
  
  - [x] 7.4 Write property tests for dashboard calculations
    - **Property: Metric calculation accuracy**
    - **Validates: Requirements 4.1, 4.2, 4.3, 4.4, 4.5**
  
  - [x] 7.5 Write unit tests for dashboard endpoints
    - Test metrics calculation with various data scenarios
    - Test organization-scoped metric filtering
    - Test cache hit and miss scenarios
    - _Requirements: 4.7, 17.2_

- [ ] 8. Checkpoint - Core HRMS functionality complete
  - Ensure all tests pass for authentication, employees, tasks, and dashboard
  - Verify multi-tenancy isolation is working correctly
  - Test end-to-end flow: register → login → create employee → assign task → view dashboard
  - Ask the user if questions arise

- [x] 9. AI productivity scoring engine
  - [x] 9.1 Implement productivity score calculation algorithm
    - Calculate completion rate (completed / total assigned)
    - Calculate average completion time ratio
    - Calculate complexity bonus based on task complexity
    - Normalize score to 0-100 scale using weighted formula
    - _Requirements: 5.1, 5.3, 5.5, 19.1_
  
  - [x] 9.2 Implement productivity score persistence
    - Store scores with historical tracking
    - Create indexes for efficient querying
    - _Requirements: 5.6_
  
  - [x] 9.3 Implement productivity score endpoints
    - Create GET /api/ai/productivity/:employeeId endpoint
    - Create POST /api/ai/batch-calculate endpoint for batch processing
    - _Requirements: 5.4_
  
  - [x] 9.4 Implement baseline score assignment
    - Assign baseline score for employees with no completed tasks
    - _Requirements: 5.2_
  
  - [x] 9.5 Write property tests for productivity scoring
    - **Property: Score normalization to 0-100 range**
    - **Validates: Requirements 5.3**
  
  - [x] 9.6 Write unit tests for productivity scoring
    - Test score calculation with various completion rates
    - Test baseline score assignment
    - Test recent task weighting
    - _Requirements: 5.1, 5.2, 5.5_


- [ ] 10. AI skill gap detection
  - [ ] 10.1 Implement skill comparison algorithm
    - Compare employee skills against role requirements
    - Identify missing skills
    - Use industry-standard skill sets when role requirements undefined
    - _Requirements: 6.1, 6.2, 6.3, 19.2_
  
  - [ ] 10.2 Implement skill gap prioritization
    - Rank skill gaps by priority (critical, high, medium, low)
    - Consider role criticality and skill demand
    - _Requirements: 6.5_
  
  - [ ] 10.3 Implement organization-wide skill gap analysis
    - Aggregate skill gaps across all employees
    - Identify critical missing skills at organization level
    - _Requirements: 6.4_
  
  - [ ] 10.4 Implement skill gap endpoints
    - Create GET /api/ai/skill-gaps/:employeeId endpoint
    - Create GET /api/ai/skill-gaps/organization endpoint
    - _Requirements: 6.1, 6.4_
  
  - [ ] 10.5 Write property tests for skill gap detection
    - **Property: Empty skill gap for fully qualified employees**
    - **Validates: Requirements 6.3**
  
  - [ ] 10.6 Write unit tests for skill gap detection
    - Test skill comparison logic
    - Test prioritization algorithm
    - Test organization-wide aggregation
    - _Requirements: 6.1, 6.2, 6.4, 6.5_

- [ ] 11. AI smart task assignment recommendations
  - [ ] 11.1 Implement task assignment scoring algorithm
    - Calculate skills match score (40% weight)
    - Calculate workload score (30% weight)
    - Calculate productivity score contribution (20% weight)
    - Calculate availability score (10% weight)
    - Compute weighted suitability score
    - _Requirements: 7.2, 19.3_
  
  - [ ] 11.2 Implement employee filtering logic
    - Exclude employees at maximum task capacity
    - Filter by required skills
    - _Requirements: 7.5_
  
  - [ ] 11.3 Implement recommendation ranking
    - Sort employees by suitability score
    - Handle tie-breaking by workload
    - Return empty list with explanation when no matches
    - _Requirements: 7.1, 7.3, 7.4_
  
  - [ ] 11.4 Implement task assignment recommendation endpoint
    - Create POST /api/ai/recommend-assignment endpoint
    - Accept task requirements (skills, complexity, department)
    - Return ranked list of employee recommendations
    - _Requirements: 7.1_
  
  - [ ] 11.5 Write property tests for task assignment
    - **Property: Recommendation ranking consistency**
    - **Validates: Requirements 7.2, 7.4**
  
  - [ ] 11.6 Write unit tests for task assignment
    - Test scoring algorithm with various employee profiles
    - Test capacity filtering
    - Test empty recommendation scenarios
    - _Requirements: 7.1, 7.3, 7.5_


- [ ] 12. AI performance trend prediction
  - [ ] 12.1 Implement historical data collection
    - Query productivity scores for minimum 30 days
    - Validate sufficient data points (minimum 4 weekly scores)
    - _Requirements: 8.2, 8.3_
  
  - [ ] 12.2 Implement trend analysis algorithm
    - Apply linear regression to historical scores
    - Calculate slope and R² confidence value
    - Classify trend: improving (slope > 0.05), declining (slope < -0.05), stable
    - _Requirements: 8.1, 19.4_
  
  - [ ] 12.3 Implement contributing factors analysis
    - Identify factors contributing to declining trends
    - Include confidence level in predictions
    - _Requirements: 8.4_
  
  - [ ] 12.4 Implement trend prediction endpoint
    - Create GET /api/ai/performance-trend/:employeeId endpoint
    - Return trend classification, confidence, and factors
    - Handle insufficient data scenarios
    - _Requirements: 8.1, 8.2_
  
  - [ ] 12.5 Implement weekly trend update job
    - Create scheduled job to update trends weekly
    - _Requirements: 8.5_
  
  - [ ] 12.6 Write property tests for trend prediction
    - **Property: Trend classification consistency**
    - **Validates: Requirements 8.1**
  
  - [ ] 12.7 Write unit tests for trend prediction
    - Test trend classification with various score patterns
    - Test insufficient data handling
    - Test confidence calculation
    - _Requirements: 8.1, 8.2, 8.4_

- [ ] 13. AI engine caching and optimization
  - [ ] 13.1 Implement AI result caching
    - Cache productivity scores with 1-hour TTL
    - Cache skill gap analysis with 1-hour TTL
    - Cache task recommendations with 30-minute TTL
    - Include organization_id in cache keys
    - _Requirements: 19.6, 30.4_
  
  - [ ] 13.2 Implement graceful degradation for AI failures
    - Return fallback values when AI calculations fail
    - Log errors without blocking system operation
    - _Requirements: 19.5, 16.3_
  
  - [ ] 13.3 Write unit tests for caching behavior
    - Test cache hit and miss scenarios
    - Test cache invalidation
    - Test organization-scoped cache keys
    - _Requirements: 19.6, 30.4_

- [ ] 14. Checkpoint - AI features complete
  - Ensure all AI endpoints are functional
  - Verify productivity scoring accuracy
  - Test skill gap detection with various employee profiles
  - Test task assignment recommendations
  - Test performance trend predictions
  - Ask the user if questions arise


- [ ] 15. Blockchain smart contract development
  - [ ] 15.1 Set up Hardhat development environment
    - Initialize Hardhat project
    - Configure Polygon testnet (Mumbai) and mainnet
    - Set up deployment scripts
    - _Requirements: 20.1, 20.2_
  
  - [ ] 15.2 Implement WorkforceLogger smart contract
    - Create contract with WorkforceEvent struct
    - Implement authorization mechanism for organizations
    - Implement logEvent function with validation
    - Implement getEmployeeEvents query function
    - Implement getOrganizationEvents query function
    - Emit EventLogged events for off-chain indexing
    - _Requirements: 11.1, 11.2, 11.3, 11.4, 11.5, 11.6_
  
  - [ ] 15.3 Write Solidity unit tests for smart contract
    - Test event logging functionality
    - Test authorization enforcement
    - Test query functions
    - Test invalid data rejection
    - _Requirements: 11.1, 11.2, 11.3, 11.6_
  
  - [ ] 15.4 Deploy smart contract to testnet
    - Deploy to Polygon Mumbai testnet
    - Verify contract on PolygonScan
    - Document contract address
    - _Requirements: 20.2_

- [ ] 16. Blockchain integration backend
  - [ ] 16.1 Implement Web3 provider connection
    - Set up ethers.js provider for Polygon
    - Configure RPC endpoints for mainnet and testnet
    - Implement network connectivity verification
    - _Requirements: 20.2, 20.4_
  
  - [ ] 16.2 Implement wallet management service
    - Securely store organization blockchain wallet private key
    - Implement wallet encryption/decryption
    - _Requirements: 20.3_
  
  - [ ] 16.3 Implement workforce event queue
    - Create database table for pending blockchain events
    - Implement event batching logic (5-minute window)
    - _Requirements: 10.6_
  
  - [ ] 16.4 Implement blockchain transaction service
    - Submit workforce events to smart contract
    - Implement gas price estimation and limits
    - Store transaction hashes in database
    - Implement retry logic (max 3 attempts)
    - Handle transaction failures gracefully
    - _Requirements: 10.2, 10.3, 10.4, 20.6_
  
  - [ ] 16.5 Implement blockchain event logging trigger
    - Trigger on task completion when employee has wallet
    - Skip logging when no wallet connected
    - Queue events for async processing
    - _Requirements: 10.1, 10.5_
  
  - [ ] 16.6 Implement blockchain verification service
    - Query blockchain for transaction details
    - Verify transaction status and data
    - _Requirements: 10.7_
  
  - [ ] 16.7 Implement blockchain endpoints
    - Create POST /api/blockchain/connect-wallet endpoint
    - Create GET /api/blockchain/events endpoint
    - Create GET /api/blockchain/verify/:txHash endpoint
    - Create GET /api/blockchain/employee-history/:walletAddress endpoint
    - _Requirements: 9.1, 10.7_
  
  - [ ] 16.8 Write unit tests for blockchain service
    - Test event queuing and batching
    - Test transaction submission and retry logic
    - Test wallet validation
    - Mock blockchain interactions
    - _Requirements: 10.1, 10.3, 10.4, 10.6_


- [ ] 17. Blockchain async worker implementation
  - [ ] 17.1 Implement background job processor
    - Set up job queue (Bull or similar)
    - Create worker to process pending blockchain events
    - Implement job scheduling and retry logic
    - _Requirements: 10.3, 20.5_
  
  - [ ] 17.2 Implement network unavailability handling
    - Queue events when blockchain network is unavailable
    - Retry submission when network recovers
    - _Requirements: 20.5_
  
  - [ ] 17.3 Write integration tests for blockchain worker
    - Test event processing flow
    - Test retry mechanism
    - Test network failure handling
    - _Requirements: 10.3, 20.5_

- [ ] 18. Error handling and logging infrastructure
  - [ ] 18.1 Implement centralized error handler
    - Create error handler middleware for Express
    - Log errors with timestamp, context, and stack trace
    - Sanitize error messages before returning to clients
    - _Requirements: 16.1, 16.6_
  
  - [ ] 18.2 Implement structured logging system
    - Set up logging library (Winston or Pino)
    - Configure log levels (INFO, WARN, ERROR, CRITICAL)
    - Separate logs by severity
    - _Requirements: 16.4_
  
  - [ ] 18.3 Implement blockchain-specific error logging
    - Log blockchain transaction failures with details
    - _Requirements: 16.2_
  
  - [ ] 18.4 Implement AI calculation error handling
    - Log AI failures and return fallback values
    - _Requirements: 16.3_
  
  - [ ] 18.5 Implement critical error alerting
    - Configure notification channels for critical errors
    - _Requirements: 16.5_
  
  - [ ] 18.6 Write unit tests for error handling
    - Test error sanitization
    - Test logging at different severity levels
    - _Requirements: 16.1, 16.4, 16.6_

- [ ] 19. API rate limiting and security
  - [ ] 19.1 Implement rate limiting middleware
    - Set up rate limiter (express-rate-limit)
    - Configure per-organization limits based on subscription tier
    - Return 429 status with retry-after header
    - Exclude health check endpoints
    - _Requirements: 25.1, 25.2, 25.3, 25.5_
  
  - [ ] 19.2 Implement abuse monitoring
    - Log repeated rate limit violations
    - _Requirements: 25.4_
  
  - [ ] 19.3 Implement input validation and sanitization
    - Validate all inputs against schemas
    - Sanitize text inputs to prevent SQL injection and XSS
    - Validate email and wallet address formats
    - Validate numeric ranges
    - Enforce payload size limits
    - _Requirements: 18.1, 18.2, 18.3, 18.4, 18.5, 18.6_
  
  - [ ] 19.4 Write property tests for input validation
    - **Property: All inputs validated before processing**
    - **Validates: Requirements 18.1**
  
  - [ ] 19.5 Write unit tests for rate limiting
    - Test rate limit enforcement
    - Test tier-based limits
    - Test excluded endpoints
    - _Requirements: 25.1, 25.3, 25.5_


- [ ] 20. Performance optimization
  - [ ] 20.1 Implement database connection pooling
    - Configure PostgreSQL connection pool
    - Set appropriate pool size limits
    - _Requirements: 17.4_
  
  - [ ] 20.2 Implement database query optimization
    - Add indexes for frequently queried fields
    - Optimize dashboard metric queries
    - _Requirements: 15.5, 17.1_
  
  - [ ] 20.3 Implement async processing for AI calculations
    - Execute AI calculations asynchronously
    - Avoid blocking API responses
    - _Requirements: 17.3_
  
  - [ ] 20.4 Write performance tests
    - Test query response times with large datasets
    - Test concurrent request handling
    - _Requirements: 17.1, 17.4_

- [ ] 21. Health monitoring and system status
  - [ ] 21.1 Implement health check endpoint
    - Create GET /api/health endpoint
    - Verify database connectivity
    - Verify blockchain connectivity (if configured)
    - Return appropriate status codes (200 for healthy, 503 for unhealthy)
    - _Requirements: 28.1, 28.2, 28.3, 28.4, 28.5, 28.6_
  
  - [ ] 21.2 Write unit tests for health endpoint
    - Test healthy system response
    - Test database failure scenario
    - Test blockchain failure scenario
    - Test response time requirements
    - _Requirements: 28.1, 28.4, 28.5, 28.6_

- [ ] 22. Data export and reporting
  - [ ] 22.1 Implement data export service
    - Generate CSV export of employee data, tasks, and scores
    - Generate JSON export of employee data, tasks, and scores
    - Filter exports by organization
    - _Requirements: 26.1, 26.2, 26.3_
  
  - [ ] 22.2 Implement productivity report generator
    - Create formatted reports with charts and trend analysis
    - _Requirements: 26.4_
  
  - [ ] 22.3 Implement export endpoints
    - Create GET /api/export/data endpoint with format parameter
    - Create GET /api/export/report endpoint
    - _Requirements: 26.1, 26.4_
  
  - [ ] 22.4 Write unit tests for export functionality
    - Test CSV and JSON generation
    - Test organization-scoped filtering
    - Test export performance with large datasets
    - _Requirements: 26.1, 26.2, 26.3, 26.5_

- [ ] 23. Notification system
  - [ ] 23.1 Implement notification data model
    - Create notifications table in database
    - Store notification type, recipient, message, read status
    - _Requirements: 27.1, 27.2, 27.6_
  
  - [ ] 23.2 Implement notification creation service
    - Create notifications on task assignment
    - Create notifications on task status updates
    - _Requirements: 27.1, 27.2_
  
  - [ ] 23.3 Implement notification endpoints
    - Create GET /api/notifications endpoint (list unread)
    - Create PATCH /api/notifications/:id/read endpoint (mark as read)
    - _Requirements: 27.3, 27.4_
  
  - [ ] 23.4 Write unit tests for notification system
    - Test notification creation triggers
    - Test notification retrieval and filtering
    - Test mark as read functionality
    - _Requirements: 27.1, 27.2, 27.3, 27.4_


- [ ] 24. Checkpoint - Backend complete
  - Ensure all backend endpoints are functional
  - Verify all tests pass (unit, integration, property-based)
  - Test complete API flow from authentication to blockchain logging
  - Verify error handling and logging work correctly
  - Test rate limiting and security measures
  - Ask the user if questions arise

- [x] 25. Frontend project setup
  - [x] 25.1 Initialize React project with TypeScript
    - Set up Create React App or Vite with TypeScript template
    - Configure Tailwind CSS
    - Set up React Router for navigation
    - _Requirements: 14.2_
  
  - [x] 25.2 Set up state management
    - Install and configure React Query for server state
    - Create AuthContext for authentication state
    - Create WalletContext for Web3 wallet state
    - Create NotificationContext for toast notifications
    - _Requirements: 21.1, 21.2, 21.3_
  
  - [x] 25.3 Create API client service
    - Implement axios-based API client
    - Configure base URL and interceptors
    - Add JWT token injection to requests
    - Handle token refresh logic
    - _Requirements: 13.1, 13.2, 13.3_
  
  - [x] 25.4 Set up routing and navigation
    - Create route configuration
    - Implement ProtectedRoute component
    - Create navigation layout with sidebar/header
    - _Requirements: 14.2_

- [x] 26. Frontend authentication module
  - [x] 26.1 Implement LoginPage component
    - Create login form with email and password fields
    - Implement form validation
    - Handle login API call and token storage
    - Display error messages
    - _Requirements: 1.3, 1.4, 14.5_
  
  - [x] 26.2 Implement RegisterPage component
    - Create registration form with organization details
    - Implement real-time validation feedback
    - Handle registration API call
    - Redirect to login on success
    - _Requirements: 1.1, 1.2, 14.3, 14.5_
  
  - [x] 26.3 Implement AuthContext and hooks
    - Create useAuth hook for authentication state
    - Implement login, logout, and token refresh methods
    - Persist tokens in secure storage
    - _Requirements: 21.4_
  
  - [x] 26.4 Write frontend unit tests for authentication
    - Test login form validation
    - Test registration form validation
    - Test authentication state management
    - _Requirements: 1.1, 1.2, 1.3, 1.4_


- [x] 27. Frontend dashboard module
  - [x] 27.1 Implement DashboardPage component
    - Create dashboard layout with metrics cards
    - Display total employees, active employees, tasks counts
    - Display productivity indicators
    - _Requirements: 4.1, 4.2, 4.3, 4.4, 4.5, 14.1_
  
  - [x] 27.2 Implement MetricsCard component
    - Create reusable card component for displaying single metric
    - Add loading states
    - _Requirements: 14.4_
  
  - [x] 27.3 Implement ProductivityChart component
    - Create chart visualization for productivity trends
    - Use charting library (Chart.js or Recharts)
    - _Requirements: 4.5_
  
  - [x] 27.4 Implement useDashboardData hook
    - Fetch dashboard metrics using React Query
    - Handle loading and error states
    - Implement automatic refetching
    - _Requirements: 4.6_
  
  - [x] 27.5 Write frontend unit tests for dashboard
    - Test metrics display
    - Test loading states
    - Test error handling
    - _Requirements: 14.4, 14.5_

- [x] 28. Frontend employee management module
  - [x] 28.1 Implement EmployeeListPage component
    - Create table view of employees
    - Implement search and filter functionality
    - Add pagination for large lists
    - _Requirements: 2.5, 14.7_
  
  - [x] 28.2 Implement EmployeeFormModal component
    - Create form for adding/editing employees
    - Implement field validation
    - Handle skills input (multi-select or tags)
    - _Requirements: 2.1, 2.3, 14.3_
  
  - [x] 28.3 Implement EmployeeDetailPage component
    - Display employee details
    - Show assigned tasks
    - Show productivity scores
    - Include wallet connection button
    - _Requirements: 2.5_
  
  - [x] 28.4 Implement WalletConnectButton component
    - Trigger MetaMask connection
    - Display wallet address when connected
    - Handle connection errors
    - _Requirements: 9.1, 9.3_
  
  - [x] 28.5 Implement useEmployees hook
    - Fetch employees list with React Query
    - Implement CRUD mutations with cache invalidation
    - _Requirements: 2.1, 2.3, 2.4, 2.5_
  
  - [x] 28.6 Write frontend unit tests for employee management
    - Test employee list rendering
    - Test form validation
    - Test wallet connection flow
    - _Requirements: 2.1, 2.2, 2.5_


- [x] 29. Frontend task management module
  - [x] 29.1 Implement TaskListPage component
    - Create table view of tasks
    - Implement filters (status, employee, department)
    - Add pagination
    - _Requirements: 3.7, 14.7_
  
  - [x] 29.2 Implement TaskFormModal component
    - Create form for creating/editing tasks
    - Implement employee selection dropdown
    - Implement complexity selection
    - Add due date picker
    - _Requirements: 3.1, 14.3_
  
  - [x] 29.3 Implement TaskStatusBadge component
    - Display task status with color coding
    - _Requirements: 3.7_
  
  - [x] 29.4 Implement TaskAssignmentRecommendations component
    - Display AI-powered employee recommendations
    - Show suitability scores and reasoning
    - Allow selection from recommendations
    - _Requirements: 7.1_
  
  - [x] 29.5 Implement useTasks hook
    - Fetch tasks list with React Query
    - Implement CRUD mutations with cache invalidation
    - _Requirements: 3.1, 3.3, 3.4, 3.7_
  
  - [x] 29.6 Write frontend unit tests for task management
    - Test task list rendering and filtering
    - Test form validation
    - Test status badge display
    - Test recommendation display
    - _Requirements: 3.1, 3.7_

- [x] 30. Frontend AI insights module
  - [x] 30.1 Implement ProductivityScorePage component
    - Display employee productivity scores in table
    - Show score rankings
    - Add sorting and filtering
    - _Requirements: 5.4_
  
  - [x] 30.2 Implement SkillGapAnalysisPage component
    - Display skill gaps for employees
    - Visualize missing skills with priority indicators
    - Show organization-wide skill gap summary
    - _Requirements: 6.1, 6.4_
  
  - [x] 30.3 Implement PerformanceTrendsPage component
    - Display performance trend predictions
    - Show trend charts with confidence levels
    - Highlight declining trends
    - _Requirements: 8.1, 8.4_
  
  - [x] 30.4 Implement useAIInsights hook
    - Fetch AI insights data with React Query
    - Handle loading and error states
    - _Requirements: 5.4, 6.1, 8.1_
  
  - [x] 30.5 Write frontend unit tests for AI insights
    - Test score display and ranking
    - Test skill gap visualization
    - Test trend chart rendering
    - _Requirements: 5.4, 6.1, 8.1_


- [ ] 31. Frontend Web3 module
  - [ ] 31.1 Implement WalletContext and hooks
    - Create useWallet hook for wallet connection state
    - Implement MetaMask connection logic
    - Handle wallet disconnection
    - Detect network changes
    - _Requirements: 9.1, 9.4_
  
  - [ ] 31.2 Implement BlockchainActivityPage component
    - Display list of on-chain logged events
    - Show transaction hashes and status
    - Add filtering by event type
    - _Requirements: 10.7_
  
  - [ ] 31.3 Implement TransactionDetailModal component
    - Display detailed transaction information
    - Show blockchain verification status
    - Link to blockchain explorer
    - _Requirements: 10.7_
  
  - [ ] 31.4 Implement useBlockchainLogger hook
    - Fetch blockchain events with React Query
    - Implement transaction verification
    - _Requirements: 10.7_
  
  - [ ] 31.5 Write frontend unit tests for Web3 module
    - Test wallet connection flow
    - Test event list rendering
    - Test transaction detail display
    - _Requirements: 9.1, 9.3, 10.7_

- [ ] 32. Frontend responsive design and accessibility
  - [ ] 32.1 Implement responsive layouts
    - Ensure all pages work on desktop and tablet
    - Use Tailwind responsive utilities
    - Test on various screen sizes
    - _Requirements: 14.6_
  
  - [ ] 32.2 Implement loading states
    - Add loading indicators for all async operations
    - Use skeleton loaders for better UX
    - _Requirements: 14.4_
  
  - [ ] 32.3 Implement error handling UI
    - Display user-friendly error messages
    - Provide actionable guidance for errors
    - _Requirements: 14.5_
  
  - [ ] 32.4 Implement accessibility features
    - Add ARIA labels and roles
    - Ensure keyboard navigation works
    - Test with screen readers
    - _Requirements: 14.6_
  
  - [ ] 32.5 Write accessibility tests
    - Test keyboard navigation
    - Test ARIA attributes
    - _Requirements: 14.6_

- [ ] 33. Checkpoint - Frontend complete
  - Ensure all frontend pages are functional
  - Test complete user flows (login → dashboard → employees → tasks → AI insights → blockchain)
  - Verify responsive design on different screen sizes
  - Test error handling and loading states
  - Ask the user if questions arise


- [ ] 34. Integration testing
  - [ ] 34.1 Write API integration tests
    - Test complete authentication flow
    - Test employee management flow
    - Test task management flow
    - Test dashboard metrics calculation
    - Test AI endpoints integration
    - Test blockchain logging flow
    - _Requirements: 22.2_
  
  - [ ] 34.2 Write end-to-end tests
    - Test critical user flows with automated browser testing
    - Test organization registration and login
    - Test employee creation and task assignment
    - Test dashboard viewing
    - _Requirements: 22.5_
  
  - [ ] 34.3 Write property-based integration tests
    - **Property: Multi-tenancy data isolation across API calls**
    - **Validates: Requirements 30.1, 30.2, 30.3**

- [ ] 35. Deployment preparation
  - [ ] 35.1 Create deployment documentation
    - Document database setup steps
    - Document environment variable configuration
    - Document dependency installation
    - Document application startup procedures
    - Specify minimum system requirements
    - _Requirements: 23.4, 23.5_
  
  - [ ] 35.2 Create environment configuration templates
    - Create .env.example files for backend and frontend
    - Document all required environment variables
    - _Requirements: 23.1, 23.2_
  
  - [ ] 35.3 Implement environment variable validation
    - Validate required variables on startup
    - Prevent startup with missing configuration
    - Log descriptive errors for missing variables
    - _Requirements: 23.2, 23.3, 23.6_
  
  - [ ] 35.4 Create Docker configuration (optional)
    - Create Dockerfile for backend
    - Create Dockerfile for frontend
    - Create docker-compose.yml for local development
    - _Requirements: 23.4_
  
  - [ ] 35.5 Write deployment verification tests
    - Test environment variable validation
    - Test startup procedures
    - _Requirements: 23.2, 23.3_

- [ ] 36. GTM strategy document
  - [ ] 36.1 Create GTM strategy document
    - Identify target customer segments (company size, industries)
    - Define 3-month roadmap with milestones for onboarding 50-100 companies
    - Create ₹5,000 experimental marketing plan with channel allocation
    - Define minimum 2 revenue streams (SaaS tiers, AI add-ons, premium analytics)
    - Specify pricing tiers based on employee count and features
    - Identify key value propositions and competitive differentiators
    - Define target personas and their pain points
    - _Requirements: 24.1, 24.2, 24.3, 24.4, 24.5, 24.6_


- [ ] 37. Documentation and code quality
  - [ ] 37.1 Write API documentation
    - Document all API endpoints with request/response examples
    - Create OpenAPI/Swagger specification
    - Document authentication requirements
    - _Requirements: 13.1, 13.2, 13.3, 13.4, 13.5, 13.6, 13.7_
  
  - [ ] 37.2 Write code documentation
    - Add JSDoc comments to all public functions
    - Document complex algorithms (AI scoring, trend prediction)
    - Document smart contract functions
    - _Requirements: 19.1, 19.2, 19.3, 19.4_
  
  - [ ] 37.3 Create developer setup guide
    - Document local development setup
    - Document testing procedures
    - Document debugging tips
    - _Requirements: 23.4_
  
  - [ ] 37.4 Create user guide
    - Document how to use the platform
    - Create screenshots and walkthroughs
    - Document Web3 wallet connection process
    - _Requirements: 14.1, 14.2, 9.1_

- [ ] 38. Final testing and quality assurance
  - [ ] 38.1 Run complete test suite
    - Execute all unit tests
    - Execute all integration tests
    - Execute all property-based tests
    - Verify minimum 80% code coverage
    - _Requirements: 22.1, 22.2, 22.3, 22.4_
  
  - [ ] 38.2 Perform security audit
    - Review authentication and authorization implementation
    - Review input validation and sanitization
    - Review SQL injection prevention
    - Review XSS prevention
    - Review rate limiting configuration
    - _Requirements: 18.1, 18.2, 18.3, 25.1_
  
  - [ ] 38.3 Perform performance testing
    - Test API response times with realistic data volumes
    - Test concurrent user handling
    - Test database query performance
    - Verify dashboard metrics cache effectiveness
    - _Requirements: 17.1, 17.2, 17.3, 17.4_
  
  - [ ] 38.4 Test blockchain integration on testnet
    - Verify smart contract deployment
    - Test workforce event logging end-to-end
    - Verify transaction verification
    - Test gas cost optimization
    - _Requirements: 10.1, 10.2, 10.6, 10.7, 20.6_

- [ ] 39. Final checkpoint - Production readiness
  - Ensure all tests pass
  - Verify all documentation is complete
  - Verify deployment procedures are documented
  - Test complete system end-to-end
  - Verify security measures are in place
  - Confirm GTM strategy document is complete
  - Ask the user if questions arise

## Notes

- All tasks are required for comprehensive implementation
- Each task references specific requirements for traceability
- Checkpoints ensure incremental validation at major milestones
- Property-based tests validate universal correctness properties
- Unit tests validate specific examples and edge cases
- Integration tests validate component interactions
- The implementation follows a bottom-up approach: database → backend services → API → frontend
- Blockchain integration is designed to be fail-safe (failures don't block core HRMS functionality)
- AI features use caching to optimize performance
- Multi-tenancy is enforced at every layer (database, API, cache)
