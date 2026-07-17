# AGENTS.md

Instrucciones para asistentes AI (opencode, Aider, Claude Code, Cursor, etc.).

## Entorno

Este proyecto usa **GNU Guix** para gestionar dependencias. Todos los comandos se ejecutan dentro del entorno Guix.

## Comandos clave

```bash
make dev          # Shell de desarrollo
make ci           # Pipeline completa: lint + test + build
make ci-act       # Simular GitHub Actions localmente
make pull         # Sincronizar canales Guix con manifest/channels.scm
make lint         # Linter (requiere LINT_CMD)
make test         # Tests (requiere TEST_CMD)
make build        # Build (requiere BUILD_CMD)
```

## Validación

Antes de proponer cambios, ejecuta siempre:

```bash
make ci
```

Si `make ci` falla, **no propongas el cambio** hasta que pase.

## Convenciones de código

- **Sin comentarios innecesarios** en el código fuente.
- **Sin secretos ni credenciales** en el código.
- **Commits**: seguir [Conventional Commits](https://www.conventionalcommits.org/) — `feat:`, `fix:`, `refactor:`, `docs:`, `test:`, `chore:`.
- **PRs**: usar la plantilla en `.github/PULL_REQUEST_TEMPLATE.md`.

## Estructura de manifests

- `manifest/channels.scm` — canales Guix disponibles (fuente de verdad).
- `manifest/base.scm` — paquetes comunes a todos los entornos.
- `manifest/dev.scm` — extiende base con herramientas de desarrollo.
- `manifest/ci.scm` — extiende base con linter, test runner y build tool.
- `manifest/prod.scm` — extiende base con dependencias de producción.

Para añadir un paquete nuevo, agrégalo al manifest correspondiente, no al Makefile.
Para añadir un canal nuevo, agrégalo a `manifest/channels.scm` y ejecuta `make pull`.
