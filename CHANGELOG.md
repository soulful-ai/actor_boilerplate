# Changelog

All notable changes to the Actor Boilerplate will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

## [1.0.0] - 2024-06-17

### Added
- Initial actor boilerplate implementation
- Core actor framework with Nx monorepo structure
- MCP server implementation with Python/uv
- Configurable port assignment for director communication
- PM Director integration patterns
- Shared workspace communication protocol
- Dual environment support (local and GitHub Codespaces)
- Environment variable template system
- Task response patterns for director communication
- Background process management examples
- Essential documentation structure (CLAUDE.md, README.md)
- Prompt guides for actor development
- GitHub Actions CI/CD pipeline
- Jest and Python testing configurations

### Security
- Telegram authentication system integration
- TEST_MODE environment variable for CI/CD
- Secure credential handling patterns

### Documentation
- Comprehensive README for actor development
- CLAUDE.md template for actor specialization
- Usage instructions for creating new actors
- PM Director communication examples
- Architecture and workflow documentation

## Future Releases

### [1.1.0] - Planned
- Interactive actor creation CLI
- Enhanced testing utilities
- Docker containerization
- VS Code development extensions

### [1.2.0] - Planned
- Multi-language support (Node.js, Go, Rust)
- Actor state persistence
- Performance monitoring tools
- Hot reload capabilities

### [2.0.0] - Planned
- Nx plugin generator conversion
- Pre-built actor type templates
- Tool marketplace integration
- Cloud deployment templates

## Migration Guide

### From Custom Actor to Boilerplate (v1.0.0)
1. Clone actor_boilerplate
2. Copy your specialized apps/ content
3. Update CLAUDE.md with your actor's role
4. Migrate environment variables to .env
5. Update port assignment (900X series)
6. Test PM Director communication