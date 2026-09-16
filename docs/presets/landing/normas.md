# Normas técnicas — Landing Page

> Reglas no negociables para cada landing que salga de VoraData.

## Estructura de ficheros

```
proyecto/
├── index.html              # Única página (landing)
├── assets/
│   ├── css/app.css         # Entrada Tailwind — NO CSS inline en HTML
│   ├── js/app.js           # Entrada JS — módulos separados si > 100 líneas
│   ├── js/modules/         # Un fichero por responsabilidad
│   └── img/                # WebP por defecto, SVG para iconos/logo
├── tailwind.config.js
└── package.json
```

**Reglas de ficheros:**
- Sin CSS en atributos `style=""` — todo va a Tailwind o `app.css`
- Sin JS inline en HTML — todo va a `app.js` o módulos
- Imágenes: WebP, con `width` y `height` explícitos en el HTML
- SVGs de iconos: inline en HTML o sprite, nunca `<img src="icon.svg">`

## Rendimiento

| Métrica | Objetivo |
|---|---|
| LCP | < 2.5s |
| CLS | < 0.1 |
| FID / INP | < 100ms |
| Total JS | < 50KB (sin frameworks) |
| Total CSS | < 20KB (post-purge Tailwind) |

**Obligatorio:**
- `loading="lazy"` en todas las imágenes fuera del viewport inicial
- Fuentes: `font-display: swap`, preload del subset necesario
- Critical CSS inline en `<head>` si LCP > 2.5s

## SEO

```html
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Título página | Marca</title>
  <meta name="description" content="150-160 caracteres">
  
  <!-- Open Graph -->
  <meta property="og:title" content="">
  <meta property="og:description" content="">
  <meta property="og:image" content="">
  <meta property="og:url" content="">
  
  <!-- Canonical -->
  <link rel="canonical" href="">
</head>
```

- Un solo `<h1>` por página
- Estructura de headings semántica (h1 → h2 → h3, sin saltar niveles)
- Alt en todas las imágenes no decorativas

## Accesibilidad (WCAG 2.1 AA)

- Contraste mínimo 4.5:1 texto normal, 3:1 texto grande
- Todos los elementos interactivos alcanzables con teclado (`Tab`)
- `aria-label` en botones/links con solo icono
- `aria-current="page"` en nav activo
- `role="banner"`, `role="main"`, `role="contentinfo"` en nav/main/footer

## HTML semántico

```
<header>  → navbar + hero
<main>    → contenido principal
<section> → cada bloque de contenido (con aria-label o heading)
<article> → contenido independiente (cards, posts)
<footer>  → pie de página
```

- Nunca `<div>` donde existe un elemento semántico apropiado
- Botones son `<button>`, enlaces de navegación son `<a href>`

## Git

- Commits convencionales: `feat:`, `fix:`, `style:`, `docs:`, `chore:`
- Sin commits de "WIP" al main
- PR con descripción: qué, por qué, cómo testear
