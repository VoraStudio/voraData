# 001 — Estructura d'URLs basada en carpetes amb index.html

**Stack**: html
**Estat**: acceptat
**Data**: 2026-09-16

## Context

Carles va proposar que cada secció d'una web tingui la seva pròpia carpeta amb `index.html` en lloc d'un fitxer `.html` solt. La motivació inicial era millorar el SEO.

## Decisió

Totes les pàgines de VoraData segueixen l'estructura de carpetes:

```
serveis/index.html       → example.com/serveis/
contacte/index.html      → example.com/contacte/
```

Mai `serveis.html` → `example.com/serveis.html`.

## Conseqüències

**Positiu:**
- URLs netes sense extensió, millor per a compartir i CTR
- Jerarquia natural per a sub-pàgines futures sense trencar URLs
- Breadcrumbs i schema markup més clars per a Google

**Aclariment SEO:**
Google tracta `/serveis/` i `/serveis.html` de forma equivalent en ranking. El benefici és indirecte: CTR més alt per URLs netes, no un salt de posicions directe. Els factors que realment mouen el SEO (Core Web Vitals, contingut, backlinks) continuen sent prioritaris.
