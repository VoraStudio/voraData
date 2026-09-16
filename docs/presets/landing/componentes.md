# Componentes — Landing Page

> Catálogo de secciones estándar. Cada componente define estructura HTML, clases Tailwind y variantes.

## Checklist estándar

```
[ ] Navbar
[ ] Hero
[ ] Features / Propuesta de valor
[ ] Social proof (logos, testimonios)
[ ] CTA intermedio
[ ] Pricing (si aplica)
[ ] FAQ (si aplica)
[ ] CTA final
[ ] Footer
```

---

## Navbar

**Variantes**: sticky transparente → sólido al scroll / simple centrado

```html
<nav class="fixed top-0 w-full z-50 transition-all duration-300" data-navbar>
  <div class="max-w-6xl mx-auto px-6 h-16 flex items-center justify-between">
    <a href="/" class="font-bold text-xl">Logo</a>
    <ul class="hidden md:flex items-center gap-8 text-sm">
      <!-- items -->
    </ul>
    <a href="#contacto" class="btn-primary">Contactar</a>
  </div>
</nav>
```

JS: añadir clase `bg-white shadow-md` al hacer scroll > 50px.

---

## Hero

**Variantes**: centrado / split (texto + imagen) / vídeo de fondo

```html
<section class="pt-32 pb-20 lg:pt-40 lg:pb-32">
  <div class="max-w-6xl mx-auto px-6 text-center">
    <h1 class="text-5xl lg:text-7xl font-bold tracking-tight mb-6">
      Headline principal
    </h1>
    <p class="text-xl text-neutral-600 max-w-2xl mx-auto mb-10">
      Subheadline — propuesta de valor en una frase.
    </p>
    <div class="flex flex-col sm:flex-row gap-4 justify-center">
      <a href="#contacto" class="btn-primary">CTA principal</a>
      <a href="#features" class="btn-secondary">CTA secundario</a>
    </div>
  </div>
</section>
```

---

## Features

**Variantes**: grid 3 columnas / lista alternada / cards con icono

```html
<section class="py-20 lg:py-32">
  <div class="max-w-6xl mx-auto px-6">
    <h2 class="text-4xl font-bold text-center mb-16">Título sección</h2>
    <div class="grid md:grid-cols-3 gap-8">
      <!-- feature card -->
    </div>
  </div>
</section>
```

---

## CTA

**Regla**: max. 1 acción por CTA. Nunca dos CTAs iguales en la misma página.

```html
<section class="py-20 bg-brand-primary text-white text-center">
  <div class="max-w-2xl mx-auto px-6">
    <h2 class="text-4xl font-bold mb-4">Headline CTA</h2>
    <p class="text-lg mb-8 opacity-90">Subheadline breve.</p>
    <a href="#contacto" class="btn-white">Acción</a>
  </div>
</section>
```

---

## Footer

```html
<footer class="py-12 border-t border-neutral-200">
  <div class="max-w-6xl mx-auto px-6 flex flex-col md:flex-row justify-between gap-8">
    <div>
      <span class="font-bold text-xl">Logo</span>
      <p class="text-sm text-neutral-500 mt-2">Tagline breve.</p>
    </div>
    <nav class="flex gap-6 text-sm text-neutral-600">
      <!-- links legales -->
    </nav>
  </div>
</footer>
```
