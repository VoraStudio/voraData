# Components — Landing Page

> Catàleg de seccions estàndard. Cada component defineix estructura HTML, classes Tailwind i variants.

## Checklist estàndard

```
[ ] Navbar
[ ] Hero
[ ] Features / Proposta de valor
[ ] Social proof (logos, testimonis)
[ ] CTA intermedi
[ ] Pricing (si s'escau)
[ ] FAQ (si s'escau)
[ ] CTA final
[ ] Footer
```

---

## Navbar

**Variants**: sticky transparent → sòlid al scroll / simple centrat

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

JS: afegir classe `bg-white shadow-md` en fer scroll > 50px.

---

## Hero

**Variants**: centrat / split (text + imatge) / vídeo de fons

```html
<section class="pt-32 pb-20 lg:pt-40 lg:pb-32">
  <div class="max-w-6xl mx-auto px-6 text-center">
    <h1 class="text-5xl lg:text-7xl font-bold tracking-tight mb-6">
      Headline principal
    </h1>
    <p class="text-xl text-neutral-600 max-w-2xl mx-auto mb-10">
      Subheadline — proposta de valor en una frase.
    </p>
    <div class="flex flex-col sm:flex-row gap-4 justify-center">
      <a href="#contacto" class="btn-primary">CTA principal</a>
      <a href="#features" class="btn-secondary">CTA secundari</a>
    </div>
  </div>
</section>
```

---

## Features

**Variants**: grid 3 columnes / llista alternada / cards amb icona

```html
<section class="py-20 lg:py-32">
  <div class="max-w-6xl mx-auto px-6">
    <h2 class="text-4xl font-bold text-center mb-16">Títol secció</h2>
    <div class="grid md:grid-cols-3 gap-8">
      <!-- feature card -->
    </div>
  </div>
</section>
```

---

## Social proof

**Variants**: tira de logos / testimonis en cards

```html
<section class="py-16 border-y border-neutral-200">
  <div class="max-w-6xl mx-auto px-6">
    <p class="text-center text-sm text-neutral-500 mb-8">Empreses que confien en nosaltres</p>
    <div class="flex flex-wrap items-center justify-center gap-x-12 gap-y-6 grayscale opacity-70">
      <!-- <img src="..." alt="Nom client" class="h-8" /> repetit per client -->
    </div>
  </div>
</section>
```

---

## Pricing

**Variants**: cards comparatives / taula

```html
<section class="py-20 lg:py-32">
  <div class="max-w-6xl mx-auto px-6">
    <h2 class="font-heading text-4xl font-bold text-center mb-16">Plans i preus</h2>
    <div class="grid md:grid-cols-3 gap-8">
      <div class="rounded-xl border border-neutral-200 p-8 shadow-md">
        <h3 class="font-heading text-xl font-semibold mb-2">Pla</h3>
        <p class="text-3xl font-bold mb-4">€__<span class="text-base font-normal text-neutral-500">/mes</span></p>
        <ul class="text-sm text-neutral-600 space-y-2 mb-8">
          <!-- <li>Característica</li> -->
        </ul>
        <a href="#contacto" class="btn-secondary w-full">Triar pla</a>
      </div>
      <!-- repetir card per pla, destacar el recomanat amb border-brand-primary + shadow-xl -->
    </div>
  </div>
</section>
```

---

## FAQ

**Patró accessible**: `<details>`/`<summary>` natiu — no cal JS ni `aria-expanded` manual.

```html
<section class="py-20 lg:py-32">
  <div class="max-w-2xl mx-auto px-6">
    <h2 class="font-heading text-4xl font-bold text-center mb-16">Preguntes freqüents</h2>
    <div class="divide-y divide-neutral-200">
      <details class="group py-6">
        <summary class="flex items-center justify-between cursor-pointer font-semibold list-none">
          Pregunta?
          <span class="transition-transform group-open:rotate-45">+</span>
        </summary>
        <p class="mt-4 text-neutral-600">Resposta.</p>
      </details>
      <!-- repetir <details> per pregunta -->
    </div>
  </div>
</section>
```

---

## CTA

**Regla**: màx. 1 acció per CTA. Mai dos CTAs iguals a la mateixa pàgina.

```html
<section class="py-20 bg-brand-primary text-white text-center">
  <div class="max-w-2xl mx-auto px-6">
    <h2 class="text-4xl font-bold mb-4">Headline CTA</h2>
    <p class="text-lg mb-8 opacity-90">Subheadline breu.</p>
    <a href="#contacto" class="btn-white">Acció</a>
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
      <p class="text-sm text-neutral-500 mt-2">Tagline breu.</p>
    </div>
    <nav class="flex gap-6 text-sm text-neutral-600">
      <!-- links legals -->
    </nav>
  </div>
</footer>
```
