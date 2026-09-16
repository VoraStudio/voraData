# Normes tècniques — Landing Page

> Regles no negociables per a cada landing que surti de VoraData.

## Estructura de fitxers i URLs

Cada secció és una **carpeta amb el seu propi `index.html`**, no un fitxer `.html` solt.

```
arrel-projecte/
├── index.html                  # → example.com/
├── serveis/
│   └── index.html              # → example.com/serveis/
├── sobre-nosaltres/
│   └── index.html              # → example.com/sobre-nosaltres/
└── assets/
    ├── css/app.css
    ├── js/app.js
    ├── js/modules/
    └── img/
```

!!! tip "Per què carpetes i no fitxers .html?"
    `example.com/serveis/` és una URL neta, sense extensió, fàcil de compartir i de recordar. A més, permet afegir sub-pàgines (`/serveis/web/`, `/serveis/apps/`) sense trencar la URL pare. Google tracta les dues formes equivalent en ranking, però la jerarquia de carpetes millora el CTR als resultats de cerca i facilita l'estructuració de breadcrumbs i schema markup.

!!! warning "Aclariment SEO"
    La convenció de carpetes **no és un factor de ranking directe** — Google ho confirma explícitament. El benefici és indirecte: URLs més netes → millor CTR, jerarquia clara → millor comprensió del lloc per part de Google. Els factors que realment mouen el SEO continuen sent contingut, Core Web Vitals i backlinks.

**Regles de fitxers:**
- Sense CSS en atributs `style=""` — tot va a Tailwind o `app.css`
- Sense JS inline en HTML — tot va a `app.js` o mòduls
- Imatges: WebP, amb `width` i `height` explícits en l'HTML
- SVGs d'icones: inline en HTML o sprite, mai `<img src="icon.svg">`

## Rendiment

| Mètrica | Objectiu |
|---|---|
| LCP | < 2.5s |
| CLS | < 0.1 |
| FID / INP | < 100ms |
| Total JS | < 50KB (sense frameworks) |
| Total CSS | < 20KB (post-purge Tailwind) |

**Obligatori:**
- `loading="lazy"` en totes les imatges fora del viewport inicial
- Fonts: `font-display: swap`, preload del subset necessari
- Critical CSS inline al `<head>` si LCP > 2.5s

## SEO

```html
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Títol pàgina | Marca</title>
  <meta name="description" content="150-160 caràcters">
  
  <!-- Open Graph -->
  <meta property="og:title" content="">
  <meta property="og:description" content="">
  <meta property="og:image" content="">
  <meta property="og:url" content="">
  
  <!-- Canonical -->
  <link rel="canonical" href="">
</head>
```

- Un sol `<h1>` per pàgina
- Estructura de headings semàntica (h1 → h2 → h3, sense saltar nivells)
- Alt en totes les imatges no decoratives

## Accessibilitat (WCAG 2.1 AA)

- Contrast mínim 4.5:1 text normal, 3:1 text gran
- Tots els elements interactius accessibles amb teclat (`Tab`)
- `aria-label` en botons/links amb només icona
- `aria-current="page"` en nav actiu
- `role="banner"`, `role="main"`, `role="contentinfo"` en nav/main/footer

## HTML semàntic

```
<header>  → navbar + hero
<main>    → contingut principal
<section> → cada bloc de contingut (amb aria-label o heading)
<article> → contingut independent (cards, posts)
<footer>  → peu de pàgina
```

- Mai `<div>` on existeix un element semàntic apropiat
- Botons són `<button>`, enllaços de navegació són `<a href>`

## Git

- Commits convencionals: `feat:`, `fix:`, `style:`, `docs:`, `chore:`
- Sense commits de "WIP" al main
- PR amb descripció: què, per què, com testejar
