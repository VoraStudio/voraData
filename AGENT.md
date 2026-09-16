# AGENT.md — VoraData

Contexto global para cualquier agente IA que trabaje en este repositorio.
Lee este fichero al inicio de cada sesión antes de hacer cualquier cosa.

---

## Quiénes somos

**VoraData** es una consultora de transformación digital especializada en IA local y privada, desarrollo a medida y estrategia digital.

- **Equipo técnico**: Carles + Pau
- **Rama creativa**: VoraStudio (diseño, Canvas/Figma, brand)
- **Rama técnica**: VoraData (desarrollo, IA, arquitectura)
- **Web**: https://www.voradata.cat

## Cómo llegan los proyectos

```
VoraStudio (diseñadora)
  → Canvas/Figma + brand PDF (colores, fuentes, identidad)
    → Reunión de alineación con Pau/Carles
      → VoraData construye
```

El diseño ES el brief. No esperamos un documento de requisitos textual.

---

## Stack

| Capa                 | Tecnología                                    |
| -------------------- | --------------------------------------------- |
| Frontend             | HTML semántico + Tailwind CSS v4 + Vanilla JS |
| Backend              | Symfony (PHP)                                 |
| IA local             | DGX Spark — modelo `qwen38-27b` via SGLang    |
| IDE IA               | OpenCode (conectado al DGX Spark)             |
| Docs                 | MkDocs + Material for MkDocs                  |
| Control de versiones | Git — GitHub (org: VoraStudio)                |

**Cambiar el stack requiere decisión explícita del equipo.** No introducir nuevas dependencias sin consenso.

---

## Principios IA

1. **Local primero** — el DGX Spark es el backend por defecto. No enviar datos de clientes a APIs externas.
2. **Human on the loop** — el agente ejecuta, el equipo dirige y verifica. Nunca autonomía total.
3. **Agnóstico a herramienta** — este repo y todo lo que contiene funciona con cualquier LLM, no solo Claude.
4. **LOPD** — datos de clientes, contratos y documentación sensible nunca van al repo.

---

## Flujos de trabajo

### Landing Workflow

Para webs que llegan con diseño de VoraStudio.

```
INTAKE → BUILD → DELIVER
```

- **INTAKE**: extraer tokens (colores, fuentes, espaciado) del diseño → checklist de activos completa → confirmación humana
- **BUILD**: construir por componentes usando el preset → revisión humana por bloque mayor (hero, body, footer)
- **DELIVER**: performance, SEO, a11y, cross-browser → aprobación final

→ Detalle: `docs/sdd/landing/index.md`

### SaaS Workflow

Para aplicaciones Symfony con requisitos complejos.

```
Proposal → Spec → Design → Tasks → Apply → Verify → Archive
```

→ Detalle: `docs/sdd/index.md` _(pendiente de definir)_

---

## Normas de código

### General

- Sin comentarios obvios — el código se explica solo con buenos nombres
- Sin `TODO` en producción — si no está hecho, no se mergea
- Sin lógica en vistas (HTML/Twig)

### HTML

- Semántico siempre: `<header>`, `<main>`, `<section>`, `<article>`, `<footer>`
- Un solo `<h1>` por página
- `alt` en todas las imágenes no decorativas
- `width` y `height` explícitos en `<img>`

### CSS / Tailwind

- Mobile-first siempre — los estilos base son para móvil
- **Jamás `<style>` ni CSS inline en HTML** — todo va a ficheros externos, salvo clases Tailwind en el markup
- Sin `style=""` inline en HTML
- Clases de utilidad de Tailwind; CSS custom solo para lo que Tailwind no cubre
- Variables de diseño en `@theme {}` (Tailwind v4)

### JavaScript

- **Jamás `<script>` inline ni JS en atributos HTML** (`onclick`, `onload`, etc.) — todo va a ficheros externos
- Sin frameworks — Vanilla JS
- Un fichero por responsabilidad en `assets/js/modules/`
- Sin `var` — solo `const` y `let`
- Sin `console.log` en producción

### PHP / Symfony

- PSR-12
- Sin lógica de negocio en Controllers — va en Services
- Tipado estricto siempre (`declare(strict_types=1)`)

### Git

- Commits convencionales: `feat:`, `fix:`, `style:`, `docs:`, `chore:`, `refactor:`
- Sin commits de trabajo en progreso en `main`
- PRs con descripción: qué, por qué, cómo verificar
- Sin "Co-Authored-By" ni atribución a IA en commits

---

## Hooks

### Git (pre-commit)

Ejecutar antes de cada commit:

- Verificar que no hay `.env` ni archivos con credenciales staged
- Verificar que no hay `console.log` en ficheros JS staged
- Lint CSS (si está configurado)

### Git (pre-push)

- Build de MkDocs sin errores (`mkdocs build --strict`)

### Agent (inicio de sesión)

Al arrancar cualquier sesión de trabajo:

1. Leer este fichero (`AGENT.md`)
2. Identificar el tipo de proyecto (landing / SaaS)
3. Cargar el preset correspondiente (`docs/presets/landing/` o equivalente)
4. Confirmar con el equipo el alcance de la sesión antes de escribir código

---

## Automatizaciones (GitHub Actions)

| Workflow     | Trigger       | Acción                               |
| ------------ | ------------- | ------------------------------------ |
| `deploy.yml` | Push a `main` | Build y deploy MkDocs → GitHub Pages |

→ Ficheros: `.github/workflows/`

---

## Normas de entrega

Antes de entregar cualquier landing a VoraStudio:

**Rendimiento**

- [ ] LCP < 2.5s (medir con Lighthouse)
- [ ] CLS < 0.1
- [ ] JS total < 50KB
- [ ] Imágenes en WebP con `loading="lazy"` (excepto above-the-fold)

**SEO**

- [ ] `<title>` y `<meta name="description">` únicos
- [ ] Open Graph completo (og:title, og:description, og:image, og:url)
- [ ] `<link rel="canonical">`
- [ ] Estructura de headings correcta (h1 → h2 → h3)

**Accesibilidad**

- [ ] Contraste 4.5:1 mínimo (texto normal)
- [ ] Navegación completa con teclado
- [ ] `aria-label` en botones/links con solo icono

**Cross-browser**

- [ ] Chrome, Firefox, Safari (macOS + iOS), Edge

---

## Seguridad & LOPD

**Va al repo:**

- Código fuente
- Documentación técnica
- Configuraciones no sensibles (`opencode.json` sin credenciales)

**NO va al repo:**

- `.env` con credenciales o API keys
- Datos de clientes (nombres, emails, contratos)
- Brand assets de clientes (imágenes, logos, PDFs) — se gestionan fuera
- Documentación interna sensible (presupuestos, acuerdos)

El `.gitignore` incluye `.env` por defecto. Verificar siempre antes de hacer commit.

---

## Mapa del repo

```
AGENT.md                    ← este fichero — leer primero
├── docs/                   ← documentación MkDocs (human-readable)
│   ├── sdd/                ← flujos SDD y presets
│   └── presets/landing/    ← design system, componentes, normas técnicas
├── .github/workflows/      ← automatizaciones GitHub Actions
└── overrides/              ← custom overrides MkDocs Material
```
