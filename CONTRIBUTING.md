# Contributing to buildx.zig

Thank you for your interest in contributing!

## Development

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Run tests: `zig build test`
5. Submit a pull request

## Code Style

- Follow standard Zig style conventions
- Keep functions focused and small
- Add tests for new features
- Update documentation as needed

## Testing

```bash
zig build test
```

All examples should also build successfully:

```bash
cd examples/basic-executable && zig build
cd examples/library-with-tests && zig build test
cd examples/cross-compile && zig build
cd examples/monorepo && zig build
```
