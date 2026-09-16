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
  --color-neutral-100:   #f5f5f5;
  --color-neutral-50:    #fafafa;
}
```

!!! note "Per projecte"
    Cada client té la seva paleta. Aquests són els valors de fallback/exemple.

## Tipografia

| Rol | Classe Tailwind | Ús |
|---|---|---|
| Display | `text-5xl font-bold tracking-tight` | Hero headline |
| H1 | `text-4xl font-bold` | Títols de secció |
| H2 | `text-2xl font-semibold` | Subtítols |
| Body | `text-base font-normal leading-relaxed` | Cos de text |
| Caption | `text-sm text-neutral-500` | Notes, etiquetes |

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
