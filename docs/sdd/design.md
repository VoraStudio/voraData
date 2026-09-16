# Disseny — Normes visuals i recursos

> Criteris estètics i recursos de disseny aplicables a tots els projectes de VoraData.

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

**[Gradient Studio](https://gradientsaas.blogspot.com)** — export directe a CSS, Tailwind o SCSS. Gratuït, sense compte, ús comercial permès.

!!! tip "Flux recomanat"
    1. Tens la paleta del client
    2. Genera el gradient a Gradient Studio (mode *Full* o *Duotone*)
    3. Exporta com a CSS
    4. Adapta els valors a `@theme {}` com a custom property
    5. Aplica via classe Tailwind o CSS custom al hero

---

## Components UI

### Preline UI — [preline.co](https://preline.co)

Biblioteca open source de components Tailwind + Vanilla JS. Compatible amb **Tailwind v4.3**. MIT License, gratuït per a projectes de clients.

**Quan usar-lo:** dropdowns, modals, tabs, accordions, formularis interactius.

**Instal·lació:**

```bash
npm install preline
```

```html
<!-- Al final del <body> -->
<script src="./node_modules/preline/dist/preline.js"></script>
```

**Exemple — dropdown:**

```html
<div class="hs-dropdown relative">
  <button type="button" data-hs-dropdown-toggle>
    Opcions
  </button>
  <div class="hs-dropdown-menu hidden min-w-48 bg-white shadow-md rounded-lg">
    <a class="block px-4 py-2 hover:bg-gray-100" href="#">Opció 1</a>
    <a class="block px-4 py-2 hover:bg-gray-100" href="#">Opció 2</a>
  </div>
</div>
```

**Exemple — modal:**

```html
<!-- Trigger -->
<button data-hs-overlay="#modal-example">Obre modal</button>

<!-- Modal -->
<div id="modal-example" class="hs-overlay hidden fixed inset-0 z-50">
  <div class="hs-overlay-open:opacity-100 bg-white rounded-xl p-6 max-w-lg mx-auto mt-20">
    <h3 class="text-lg font-bold">Títol del modal</h3>
    <p class="mt-2 text-gray-600">Contingut del modal.</p>
    <button data-hs-overlay="#modal-example" class="mt-4">Tanca</button>
  </div>
</div>
```

---

### Flowbite — [flowbite.com](https://flowbite.com)

Alternativa a Preline. Bona cobertura de taules, formularis avançats i datepickers. Gratuït en la versió base.

**Quan usar-lo:** quan Preline no tingui el component que necessites, especialment per a taules de dades i inputs complexos.

---

## Animacions

### AOS — Animate On Scroll

**[michalsnik.github.io/aos](https://michalsnik.github.io/aos/)** — animacions d'entrada en scroll. Zero dependències, una línia de JS.

**Quan usar-lo:** reveals de seccions, cards que apareixen en scroll. El 90% de les landings.

**Instal·lació:**

```html
<link rel="stylesheet" href="https://unpkg.com/aos@2.3.1/dist/aos.css">
<script src="https://unpkg.com/aos@2.3.1/dist/aos.js"></script>
<script>AOS.init({ duration: 600, once: true });</script>
```

**Exemple:**

```html
<div data-aos="fade-up">Apareix en scroll</div>
<div data-aos="fade-up" data-aos-delay="100">Apareix amb delay</div>
<div data-aos="zoom-in" data-aos-duration="800">Zoom in</div>
```

---

### GSAP — GreenSock Animation Platform

**[gsap.com](https://gsap.com)** — estàndard de la indústria. Vanilla JS pur. Gratuït per a ús comercial.

**Quan usar-lo:** animacions complexes, scroll-driven animations, timelines encadenades, efectes hero elaborats.

**Instal·lació:**

```bash
npm install gsap
```

**Exemple — reveal amb scroll trigger:**

```js
import { gsap } from 'gsap'
import { ScrollTrigger } from 'gsap/ScrollTrigger'

gsap.registerPlugin(ScrollTrigger)

gsap.from('.hero-title', {
  scrollTrigger: '.hero-title',
  y: 60,
  opacity: 0,
  duration: 1,
  ease: 'power3.out'
})
```

**Exemple — timeline encadenada:**

```js
const tl = gsap.timeline({ defaults: { duration: 0.6, ease: 'power2.out' } })

tl.from('.hero-title',    { y: 40, opacity: 0 })
  .from('.hero-subtitle', { y: 30, opacity: 0 }, '-=0.3')
  .from('.hero-cta',      { y: 20, opacity: 0 }, '-=0.3')
```

---

### Lenis — Smooth Scroll

**[lenis.darkroom.engineering](https://lenis.darkroom.engineering)** — smooth scroll ultralleuger.

**Quan usar-lo:** sempre que la landing necessiti sensació de qualitat premium. Una línia de configuració.

**Instal·lació:**

```bash
npm install lenis
```

**Exemple:**

```js
import Lenis from 'lenis'

const lenis = new Lenis({ duration: 1.2, easing: t => Math.min(1, 1.001 - Math.pow(2, -10 * t)) })

function raf(time) {
  lenis.raf(time)
  requestAnimationFrame(raf)
}
requestAnimationFrame(raf)
```

---

## Icones

### Lucide — [lucide.dev](https://lucide.dev)

SVG icon set gratuït, consistent i lleuger. MIT License.

**Quan usar-lo:** tots els projectes. Substitueix qualsevol altre icon set.

**Opció A — inline SVG (recomanada per a icones crítiques):**

```html
<!-- Copiar SVG directament des de lucide.dev -->
<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24"
     viewBox="0 0 24 24" fill="none" stroke="currentColor"
     stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
  <path d="M5 12h14"/><path d="m12 5 7 7-7 7"/>
</svg>
```

**Opció B — via CDN (per a prototips):**

```html
<script src="https://unpkg.com/lucide@latest/dist/umd/lucide.min.js"></script>
<script>lucide.createIcons()</script>

<i data-lucide="arrow-right"></i>
<i data-lucide="check-circle"></i>
```

---

## Referència i verificació

| Recurs | Ús |
|---|---|
| [WebAIM Contrast Checker](https://webaim.org/resources/contrastchecker/) | Verificar contrast text/fons (WCAG 2.1 AA mínim 4.5:1) |
| [Name That UI](https://namethatui.com) | Nomenclatura estàndard de components UI |
