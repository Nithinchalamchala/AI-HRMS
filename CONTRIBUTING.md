# Contributing to AI-HRMS Platform

Thank you for your interest in contributing to the AI-HRMS Platform! This document provides guidelines and instructions for contributing.

## 🤝 How to Contribute

### Reporting Bugs

If you find a bug, please create an issue with:
- Clear description of the bug
- Steps to reproduce
- Expected behavior
- Actual behavior
- Screenshots (if applicable)
- Environment details (OS, Node version, etc.)

### Suggesting Features

Feature suggestions are welcome! Please create an issue with:
- Clear description of the feature
- Use case and benefits
- Possible implementation approach
- Any relevant examples or mockups

### Pull Requests

1. **Fork the repository**
2. **Create a feature branch**
   ```bash
   git checkout -b feature/your-feature-name
   ```

3. **Make your changes**
   - Follow the existing code style
   - Add tests for new features
   - Update documentation as needed

4. **Test your changes**
   ```bash
   # Backend tests
   cd backend && npm test
   
   # API tests
   ./test-api-simple.sh
   ```

5. **Commit your changes**
   ```bash
   git commit -m "feat: add amazing feature"
   ```
   
   Follow [Conventional Commits](https://www.conventionalcommits.org/):
   - `feat:` - New feature
   - `fix:` - Bug fix
   - `docs:` - Documentation changes
   - `test:` - Test changes
   - `refactor:` - Code refactoring
   - `style:` - Code style changes
   - `chore:` - Build/tooling changes

6. **Push to your fork**
   ```bash
   git push origin feature/your-feature-name
   ```

7. **Create a Pull Request**
   - Provide clear description
   - Reference related issues
   - Include screenshots for UI changes

## 📝 Code Style

### TypeScript/JavaScript
- Use TypeScript for all new code
- Follow ESLint configuration
- Use meaningful variable names
- Add JSDoc comments for functions
- Keep functions small and focused

### React Components
- Use functional components with hooks
- Keep components focused and reusable
- Use TypeScript interfaces for props
- Follow React best practices

### Database
- Use migrations for schema changes
- Never modify existing migrations
- Add indexes for frequently queried fields
- Document complex queries

## 🧪 Testing

- Write tests for new features
- Ensure all tests pass before submitting PR
- Aim for >80% code coverage
- Test edge cases and error scenarios

## 📚 Documentation

- Update README.md for major changes
- Add JSDoc comments for functions
- Update API documentation
- Include examples in documentation

## 🔍 Code Review Process

1. Automated tests must pass
2. Code review by maintainers
3. Address review feedback
4. Approval and merge

## 🎯 Development Setup

See [SETUP_GUIDE.md](./SETUP_GUIDE.md) for detailed setup instructions.

## 📞 Questions?

- Open an issue for questions
- Check existing documentation
- Review closed issues and PRs

## 📄 License

By contributing, you agree that your contributions will be licensed under the MIT License.

Thank you for contributing! 🎉
