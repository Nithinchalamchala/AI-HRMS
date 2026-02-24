#!/bin/bash

# AI-HRMS Platform - Setup and Test Script
# This script automates the setup process for testing

set -e  # Exit on error

# Add PostgreSQL to PATH
export PATH="/opt/homebrew/opt/postgresql@15/bin:$PATH"

echo "🚀 AI-HRMS Platform - Setup Script"
echo "=================================="
echo ""

# Colors for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Function to print colored output
print_success() {
    echo -e "${GREEN}✓ $1${NC}"
}

print_warning() {
    echo -e "${YELLOW}⚠ $1${NC}"
}

print_error() {
    echo -e "${RED}✗ $1${NC}"
}

print_info() {
    echo -e "ℹ $1"
}

# Step 1: Check PostgreSQL
echo "Step 1: Checking PostgreSQL..."
if command -v psql &> /dev/null; then
    print_success "PostgreSQL is already installed"
    PSQL_VERSION=$(psql --version | awk '{print $3}')
    print_info "Version: $PSQL_VERSION"
else
    print_warning "PostgreSQL not found. Installing..."
    brew install postgresql@15
    brew services start postgresql@15
    print_success "PostgreSQL installed and started"
fi

# Check if PostgreSQL is running
if brew services list | grep postgresql | grep started &> /dev/null; then
    print_success "PostgreSQL is running"
else
    print_warning "Starting PostgreSQL..."
    brew services start postgresql@15
    sleep 3
    print_success "PostgreSQL started"
fi

echo ""

# Step 2: Create Database
echo "Step 2: Creating database..."
if psql -lqt | cut -d \| -f 1 | grep -qw ai_hrms; then
    print_warning "Database 'ai_hrms' already exists"
    read -p "Do you want to drop and recreate it? (y/N): " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        dropdb ai_hrms
        createdb ai_hrms
        print_success "Database recreated"
    else
        print_info "Using existing database"
    fi
else
    createdb ai_hrms
    print_success "Database 'ai_hrms' created"
fi

echo ""

# Step 3: Configure Backend Environment
echo "Step 3: Configuring backend environment..."
if [ -f "backend/.env" ]; then
    print_warning "backend/.env already exists"
    read -p "Do you want to overwrite it? (y/N): " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        print_info "Keeping existing backend/.env"
    else
        cat > backend/.env << EOF
NODE_ENV=development
PORT=3000

# Database Configuration
DB_HOST=localhost
DB_PORT=5432
DB_NAME=ai_hrms
DB_USER=$(whoami)
DB_PASSWORD=
DB_POOL_MIN=2
DB_POOL_MAX=10

# JWT Configuration
JWT_SECRET=my-super-secret-jwt-key-for-development-12345
JWT_REFRESH_SECRET=my-super-secret-refresh-key-for-development-67890
JWT_EXPIRES_IN=1h
JWT_REFRESH_EXPIRES_IN=7d

# CORS Configuration
CORS_ORIGIN=http://localhost:5173

# Logging
LOG_LEVEL=info
EOF
        print_success "backend/.env created"
    fi
else
    cat > backend/.env << EOF
NODE_ENV=development
PORT=3000

# Database Configuration
DB_HOST=localhost
DB_PORT=5432
DB_NAME=ai_hrms
DB_USER=$(whoami)
DB_PASSWORD=
DB_POOL_MIN=2
DB_POOL_MAX=10

# JWT Configuration
JWT_SECRET=my-super-secret-jwt-key-for-development-12345
JWT_REFRESH_SECRET=my-super-secret-refresh-key-for-development-67890
JWT_EXPIRES_IN=1h
JWT_REFRESH_EXPIRES_IN=7d

# CORS Configuration
CORS_ORIGIN=http://localhost:5173

# Logging
LOG_LEVEL=info
EOF
    print_success "backend/.env created"
fi

echo ""

# Step 4: Run Database Migrations
echo "Step 4: Running database migrations..."
if npm run migrate --prefix backend; then
    print_success "Migrations completed successfully"
else
    print_error "Migration failed. Check the error above."
    exit 1
fi

echo ""

# Step 5: Seed Database
echo "Step 5: Seeding database..."
read -p "Do you want to seed the database with sample data? (Y/n): " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Nn]$ ]]; then
    if npm run seed --prefix backend; then
        print_success "Database seeded successfully"
    else
        print_warning "Seeding failed, but continuing..."
    fi
else
    print_info "Skipping database seeding"
fi

echo ""

# Step 6: Install Frontend Packages
echo "Step 6: Installing frontend packages..."
if [ -d "frontend/node_modules" ]; then
    print_warning "Frontend packages already installed"
    read -p "Do you want to reinstall? (y/N): " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        npm install --prefix frontend
        print_success "Frontend packages installed"
    else
        print_info "Using existing frontend packages"
    fi
else
    npm install --prefix frontend
    print_success "Frontend packages installed"
fi

echo ""

# Step 7: Configure Frontend Environment
echo "Step 7: Configuring frontend environment..."
if [ -f "frontend/.env" ]; then
    print_warning "frontend/.env already exists"
else
    cat > frontend/.env << 'EOF'
VITE_API_BASE_URL=http://localhost:3000/api
EOF
    print_success "frontend/.env created"
fi

echo ""
echo "=================================="
echo "✅ Setup Complete!"
echo "=================================="
echo ""
echo "📋 Next Steps:"
echo ""
echo "1. Start the backend server:"
echo "   npm run dev --prefix backend"
echo ""
echo "2. In a new terminal, start the frontend:"
echo "   npm run dev --prefix frontend"
echo ""
echo "3. Open your browser to:"
echo "   http://localhost:5173"
echo ""
echo "4. Run tests:"
echo "   npm test --prefix backend"
echo ""
echo "📖 For detailed testing instructions, see:"
echo "   TESTING_CHECKLIST.md"
echo ""
echo "🎉 Happy testing!"
