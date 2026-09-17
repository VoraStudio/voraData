# Preset — Landing Page

> Plantilla base per a landing pages modernes, ràpides i sostenibles.

**Stack**: HTML semàntic + Tailwind CSS v4 + Vanilla JS  
**Backend opcional**: Symfony (formularis, CMS lleuger)

## Contingut del preset

- [Design System](design-system.md) — tokens de disseny en Tailwind
- [Components](componentes.md) — seccions estàndard amb variants
- [Normes tècniques](normas.md) — estructura, rendiment, SEO, a11y
- [Recursos](recursos.md) — eines per a la fase de disseny en Figma (components, icones, color, tipografia)

## Estructura de fitxers base

```
proyecto/
├── index.html
├── assets/
│   ├── css/
│   │   └── app.css          # Entrada Tailwind
│   ├── js/
│   │   └── app.js           # Entrada JS
│   └── img/
└── package.json
```

Tailwind v4 pur — sense `tailwind.config.js`, tota la configuració (tokens, tema) viu al bloc `@theme` dins `app.css` (vegeu [Design System](design-system.md)).
