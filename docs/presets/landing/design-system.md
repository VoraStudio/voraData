# Design System — Landing Page

> Tokens de diseño en Tailwind CSS. Base para construir cualquier landing con consistencia visual.

## Colores

Definir mediante CSS custom properties en `app.css` (Tailwind v4):

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

!!! note "Por proyecto"
    Cada cliente tiene su paleta. Estos son los valores de fallback/ejemplo.

## Tipografía

| Rol | Clase Tailwind | Uso |
|---|---|---|
| Display | `text-5xl font-bold tracking-tight` | Hero headline |
| H1 | `text-4xl font-bold` | Títulos de sección |
| H2 | `text-2xl font-semibold` | Subtítulos |
| Body | `text-base font-normal leading-relaxed` | Cuerpo de texto |
| Caption | `text-sm text-neutral-500` | Notas, etiquetas |

## Espaciado

Sistema basado en múltiplos de 4px (escala por defecto de Tailwind). Convenciones:

- **Sección**: `py-20 lg:py-32`
- **Contenedor**: `max-w-6xl mx-auto px-4 sm:px-6 lg:px-8`
- **Gap entre elementos**: `gap-8 lg:gap-12`

## Breakpoints

| Nombre | px | Uso |
|---|---|---|
| `sm` | 640px | Móvil landscape |
| `md` | 768px | Tablet |
| `lg` | 1024px | Desktop |
| `xl` | 1280px | Desktop ancho |

Mobile-first siempre — estilos base = móvil.

## Sombras y radios

```
rounded-xl  → tarjetas, modales
rounded-lg  → botones, inputs
shadow-md   → tarjetas en reposo
shadow-xl   → tarjetas en hover
```

## Transiciones

```css
transition-all duration-300 ease-in-out
```
