# Normes de lliurament

> Checklist obligatori abans de lliurar qualsevol landing a VoraStudio.

Cap landing surt de VoraData sense passar per aquesta llista. No és opcional.

---

## Rendiment

!!! tip "Mesura amb Lighthouse"
    Obre Chrome DevTools → Lighthouse → Mobile. Els valors de mòbil són els que importen.

<div class="grid cards" markdown>

-   :material-speedometer:{ .lg .middle } **Core Web Vitals**

    ---

    | Mètrica | Objectiu |
    |---|---|
    | LCP (Largest Contentful Paint) | < 2.5s |
    | CLS (Cumulative Layout Shift) | < 0.1 |
    | INP (Interaction to Next Paint) | < 100ms |

-   :material-file-code:{ .lg .middle } **Pes de fitxers**

    ---

    | Recurs | Màxim |
    |---|---|
    | JavaScript total | < 50KB |
    | CSS total (post-purge) | < 20KB |
    | Imatge hero | < 200KB (WebP) |

-   :material-image-multiple:{ .lg .middle } **Imatges**

    ---

    - Format WebP per defecte
    - `loading="lazy"` a totes excepte above-the-fold
    - `width` i `height` explícits per evitar CLS
    - Font del hero: `preload` al `<head>`

</div>

---

## SEO

```html
<head>
  <title>Títol pàgina | Marca</title>
  <meta name="description" content="150-160 caràcters únics">

  <meta property="og:title"       content="">
  <meta property="og:description" content="">
  <meta property="og:image"       content="">
  <meta property="og:url"         content="">

  <link rel="canonical" href="">
</head>
```

- [ ] `<title>` únic i descriptiu
- [ ] `<meta name="description">` entre 150-160 caràcters
- [ ] Open Graph complet
- [ ] `<link rel="canonical">` present
- [ ] Un sol `<h1>` per pàgina
- [ ] Jerarquia de headings correcta (h1 → h2 → h3)
- [ ] `alt` a totes les imatges no decoratives

!!! tip "Consell sènior"
    El `<title>` i la `<meta description>` són el que veu l'usuari a Google abans de fer clic. Escriu-los pensant en el client del client, no en tu.

---

## Accessibilitat (WCAG 2.1 AA)

<div class="grid cards" markdown>

-   :material-contrast:{ .lg .middle } **Contrast**

    ---

    - Text normal: mínim **4.5:1**
    - Text gran (+18px bold): mínim **3:1**

    Verifica amb [WebAIM Contrast Checker](https://webaim.org/resources/contrastchecker/).

-   :material-keyboard:{ .lg .middle } **Teclat**

    ---

    Tots els elements interactius han de ser accessibles amb `Tab`:
    - Botons, links, formularis
    - Menú mòbil
    - Modals (si n'hi ha)

-   :material-tag:{ .lg .middle } **Etiquetes**

    ---

    - `aria-label` a botons/links amb només icona
    - `aria-current="page"` al nav actiu
    - `role="banner"`, `role="main"`, `role="contentinfo"` al nav/main/footer

</div>

---

## Cross-browser

- [ ] Chrome (últimes 2 versions)
- [ ] Firefox (últimes 2 versions)
- [ ] Safari macOS (últimes 2 versions)
- [ ] Safari iOS (iPhone — la més restrictiva)
- [ ] Edge (última versió)

!!! warning "Safari iOS — el més exigent"
    Safari iOS té el motor WebKit més restrictiu. Prova sempre en dispositiu real o simulador iOS. Les propietats CSS modernes (`@layer`, alguns `@container`) poden no funcionar igual.

---

## Checklist final

Copia i enganxa a la PR o al missatge a VoraStudio:

```markdown
## Checklist de lliurament

### Rendiment
- [ ] LCP < 2.5s (Lighthouse mòbil)
- [ ] CLS < 0.1
- [ ] JS < 50KB, CSS < 20KB
- [ ] Imatges WebP amb lazy loading

### SEO
- [ ] Title + meta description únics
- [ ] Open Graph complet
- [ ] Canonical present
- [ ] Estructura headings correcta

### Accessibilitat
- [ ] Contrast 4.5:1 mínim
- [ ] Navegació per teclat
- [ ] aria-labels presents

### Cross-browser
- [ ] Chrome ✓
- [ ] Firefox ✓
- [ ] Safari macOS ✓
- [ ] Safari iOS ✓
- [ ] Edge ✓
```
