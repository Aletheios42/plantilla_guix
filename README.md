# Template Repository

Plantilla agnóstica de lenguaje basada en [GNU Guix](https://guix.gnu.org) para entornos reproducibles.

## Requisitos

- [GNU Guix](https://guix.gnu.org) instalado y actualizado (`guix pull`)
- [act](https://github.com/nektos/act) + Docker/Podman (opcional, para simular CI local)

## Comandos

| Comando | Descripción |
|---|---|
| `make help` | Lista todos los comandos disponibles |
| `make pull` | Sincroniza los canales Guix con `manifest/channels.scm` |
| `make dev` | Abre un shell de desarrollo con el entorno Guix |
| `make prod` | Abre un shell de producción con el entorno Guix |
| `make lint` | Ejecuta el linter (requiere definir `LINT_CMD`) |
| `make test` | Ejecuta los tests (requiere definir `TEST_CMD`) |
| `make build` | Compila el proyecto (requiere definir `BUILD_CMD`) |
| `make ci` | Pipeline CI completa: lint + test + build |
| `make ci-act` | Simula la pipeline de GitHub Actions localmente (requiere Docker/Podman) |

## Primera vez

Antes de `make dev` por primera vez, sincroniza los canales Guix:

```bash
make pull
```

Esto configura los canales definidos en `manifest/channels.scm` (por defecto: GNU Guix oficial + nonguix).

## Simulación de CI local

Para ejecutar la pipeline completa de GitHub Actions en tu máquina (mismo contenedor, mismos pasos):

```bash
make ci-act
```

Esto usa [act](https://github.com/nektos/act) con la imagen `metacall/guix:latest` y arranca `guix-daemon` manualmente dentro del contenedor. Requiere Docker o Podman instalado.

Alternativamente, si tienes Guix en tu host, puedes ejecutar directamente:

```bash
make ci
```

## Configuración de herramientas

Los comandos `lint`, `test` y `build` son hooks que debes configurar para tu proyecto. Define las variables en tu `Makefile` local o como variables de entorno:

```makefile
LINT_CMD = <tu-linter>
TEST_CMD = <tu-test-runner>
BUILD_CMD = <tu-build-tool>
```

O invoca directamente:

```bash
make lint LINT_CMD="golangci-lint run"
make test TEST_CMD="go test ./..."
```

## Estructura

```
.
├── .github/
│   ├── CODEOWNERS              # Revisores automáticos de PRs
│   ├── ISSUE_TEMPLATE/         # Plantillas de issues
│   ├── PULL_REQUEST_TEMPLATE.md
│   └── workflows/
│       └── ci.yaml             # GitHub Actions CI
├── manifest/
│   ├── channels.scm            # Canales Guix (fuente de verdad)
│   ├── base.scm                # Paquetes Guix base (comunes a todos los entornos)
│   ├── ci.scm                  # Paquetes para CI (lint, test, build)
│   ├── dev.scm                 # Paquetes para desarrollo
│   └── prod.scm                # Paquetes para producción
├── Makefile                    # Comandos del proyecto
├── AGENTS.md                   # Instrucciones para asistentes AI
├── CONTRIBUTING.md             # Guía de contribución
├── SECURITY.md                 # Política de seguridad
├── CHANGELOG.md                # Registro de cambios
└── README.md
```

## Personalización

1. **Añade canales** en `manifest/channels.scm` si necesitas paquetes de otros repositorios Guix (ej. `guix-science`). Ejecuta `make pull` después.
2. **Añade paquetes** en los manifests (`manifest/*.scm`) según tu lenguaje/framework.
3. **Configura `LINT_CMD`**, `TEST_CMD`, `BUILD_CMD` en tu Makefile o entorno.
4. **Actualiza `CODEOWNERS`** con los usernames de GitHub de tu equipo.
5. **Añade una licencia** cuando estés listo (ej. MIT, Apache-2.0, GPL-3.0).

## Política de commits

Este proyecto sigue [Conventional Commits](https://www.conventionalcommits.org/):

```
feat: nueva funcionalidad
fix: corrección de bug
refactor: refactorización sin cambios funcionales
docs: cambios en documentación
test: añadir o actualizar tests
chore: tareas de mantenimiento, CI, dependencias
```
