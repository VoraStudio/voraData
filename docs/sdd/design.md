# Disseny — Normes visuals i recursos

> Criteris estètics i recursos de disseny aplicables a tots els projectes de VoraData.

---

!!! info "Contingut d'aquesta secció"
    Aquesta secció recull les decisions de disseny visuals que afecten tots els projectes — landing pages i aplicacions SaaS. No és un design system per projecte (això viu a `presets/landing/design-system.md`), sinó les **normes globals** que defineixen l'estètica VoraData.

    Contingut que s'ampliarà progressivament:

    - Normes de gradients i backgrounds
    - Criteris tipogràfics globals
    - Ús d'animacions i transicions
    - Recursos externs validats
    - Patrons visuals recurrents

---

## Gradients de background

Els gradients de VoraData segueixen un **estil editorial amb capes de llum**. L'objectiu és que els backgrounds semblin fotografiats, no generats — profunditat visual amb radial gradients superposats.

### Criteri

- **Mai** gradients plans lineals de dos colors sense profunditat
- **Sempre** múltiples capes radials amb opacitats baixes
- Efectes admesos: mesh glow, aurora, film grain, bokeh
- Els colors segueixen la paleta del client — el patró de capes és constant

### Patró CSS base

```css
/* Hero fosc — adaptar colors al client */
background:
  radial-gradient(ellipse 80% 50% at 50% -10%, rgba(R,G,B,.25), transparent),
  radial-gradient(ellipse 60% 40% at 80% 60%,  rgba(R,G,B,.12), transparent),
  radial-gradient(ellipse 40% 30% at 20% 80%,  rgba(R,G,B,.08), transparent),
  var(--color-neutral-900);
```

```css
/* Hero clar — adaptar colors al client */
background:
  radial-gradient(ellipse 70% 50% at 50% 0%,   rgba(R,G,B,.15), transparent),
  radial-gradient(ellipse 50% 40% at 90% 50%,  rgba(R,G,B,.08), transparent),
  var(--color-neutral-50);
```

### Eina de generació

Per a gradients molt elaborats o quan el client necessita una estètica específica:

**[Gradient Studio](https://gradientsaas.blogspot.com)** — generador de gradients editorials.

- Export directe a **CSS**, **Tailwind** o **SCSS**
- Gratuït, sense compte, ús comercial permès
- Modes recomanats: *Full* o *Duotone*
- Exporta i enganxa a `@theme {}` o directament al hero

!!! tip "Flux recomanat"
    1. Tens la paleta del client
    2. Genera el gradient a Gradient Studio amb els colors del client
    3. Exporta com a CSS
    4. Adapta els valors a `@theme {}` com a custom property
    5. Aplica via classe Tailwind o CSS custom al hero

---

## Recursos externs validats

| Recurs | Tipus | Ús |
|---|---|---|
| [Gradient Studio](https://gradientsaas.blogspot.com) | Generador CSS | Backgrounds editorials per a heroes i seccions |
| [WebAIM Contrast Checker](https://webaim.org/resources/contrastchecker/) | Verificació | Contrast text/fons (WCAG 2.1 AA) |
| [Name That UI](https://namethatui.com) | Referència | Nomenclatura estàndard de components UI |
