# Design System — Landing Page

> Tokens de disseny en Tailwind CSS. Base per construir qualsevol landing amb consistència visual.

## Colors

Definir mitjançant CSS custom properties a `app.css` (Tailwind v4):

```css
@theme {
  --color-brand-primary: #5c35b8;
  --color-brand-accent:  #8b5cf6;

  --color-neutral-900:   #0f0f0f;
  --color-neutral-800:   #1a1a1a;
  --color-neutral-700:   #2e2e2e;
  --color-neutral-600:   #525252;
  --color-neutral-500:   #737373;
  --color-neutral-400:   #a3a3a3;
  --color-neutral-300:   #d4d4d4;
  --color-neutral-200:   #e5e5e5;
  --color-neutral-100:   #f5f5f5;
  --color-neutral-50:    #fafafa;

  --font-heading: "Space Grotesk", system-ui, sans-serif;
  --font-body:    "Inter", system-ui, sans-serif;
}
```

!!! note "Per projecte"
    Cada client té la seva paleta. Aquests són els valors de fallback/exemple. `--font-heading`/`--font-body` també es sobreescriuen per projecte — un canvi de client només toca aquestes dues línies, mai les classes `font-*` escampades per l'HTML.

## Botons

Definits com a components compostos a `app.css`, mai repetint la cadena d'utilitats a cada HTML:

```css
@layer components {
  .btn-primary {
    @apply inline-flex items-center justify-center rounded-lg bg-brand-primary px-6 py-3
           font-semibold text-white transition-all duration-300 hover:opacity-90;
  }
  .btn-secondary {
    @apply inline-flex items-center justify-center rounded-lg border border-neutral-300 px-6 py-3
           font-semibold text-neutral-900 transition-all duration-300 hover:bg-neutral-100;
  }
  .btn-white {
    @apply inline-flex items-center justify-center rounded-lg bg-white px-6 py-3
           font-semibold text-brand-primary transition-all duration-300 hover:opacity-90;
  }
}
```

## Tipografia

| Rol | Classe Tailwind | Ús |
|---|---|---|
| Display | `font-heading text-5xl font-bold tracking-tight` | Hero headline |
| H1 | `font-heading text-4xl font-bold` | Títols de secció |
| H2 | `font-heading text-2xl font-semibold` | Subtítols |
| Body | `font-body text-base font-normal leading-relaxed` | Cos de text |
| Caption | `font-body text-sm text-neutral-500` | Notes, etiquetes |

## Espaiat

Sistema basat en múltiples de 4px (escala per defecte de Tailwind). Convencions:

- **Secció**: `py-20 lg:py-32`
- **Contenidor**: `max-w-6xl mx-auto px-4 sm:px-6 lg:px-8`
- **Gap entre elements**: `gap-8 lg:gap-12`

## Breakpoints

| Nom | px | Ús |
|---|---|---|
| `sm` | 640px | Mòbil landscape |
| `md` | 768px | Tauleta |
| `lg` | 1024px | Desktop |
| `xl` | 1280px | Desktop ample |

Mobile-first sempre — estils base = mòbil.

## Ombres i radis

```
rounded-xl  → targetes, modals
rounded-lg  → botons, inputs
shadow-md   → targetes en repòs
shadow-xl   → targetes en hover
```

## Transicions

```css
transition-all duration-300 ease-in-out
```

## Gradients de background

Els gradients de VoraData segueixen un **estil editorial amb capes de llum** — mesh glow, aurora, film grain, bokeh. Mai gradients plans de dos colors sense profunditat.

```css
/* Exemple: gradient hero fosc amb mesh glow */
background:
  radial-gradient(ellipse 80% 50% at 50% -10%, rgba(244,142,36,.25), transparent),
  radial-gradient(ellipse 60% 40% at 80% 60%, rgba(244,142,36,.10), transparent),
  #02040a;
```

!!! tip "Eina de generació"
    Usa [Gradient Studio](https://gradientsaas.blogspot.com) per generar gradients editorials i exportar directament a CSS o Tailwind. Gratuït, sense compte, ús comercial permès.

    Modes recomanats: **Full** o **Duotone** amb la paleta de color del client. Exporta com a CSS i enganxa a `@theme {}` o directament a la classe del hero.

## Generació a partir d'una imatge de referència (Canva/PDF)

Quan es genera markup a partir d'una captura de disseny, l'agent ha de rebre **sempre** la imatge juntament amb aquest `design-system.md` i `componentes.md` en el mateix prompt, i se li ha de demanar explícitament que:

1. Identifiqui a quin component estàndard correspon cada secció de la imatge.
2. Reutilitzi els tokens i classes ja definits (`--color-*`, `--font-*`, `btn-*`) en comptes d'inventar valors nous a partir dels píxels.

Sense aquestes dues instruccions, el model tendeix a extreure colors/mides directament de la imatge (`bg-[#2563eb]`, `min-height: 250px` inline) encara que el token equivalent ja existeixi — no és fiable per pixel-perfect a la primera passada. Revisa manualment espaiat i jerarquia abans de donar per bona cada secció.
