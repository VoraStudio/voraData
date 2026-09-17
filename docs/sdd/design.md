# Disseny — Normes visuals i recursos

> Criteris estètics i recursos de disseny aplicables a tots els projectes de VoraData.

---

## Evitar dissenys genèrics

El problema: sense un brief fort, qualsevol agent (i qualsevol developer) cau en el genèric. Tailwind blau-500, Inter, cards amb `shadow-md`. Tots iguals.

**La solució és al INTAKE** — cal extreure tokens reals i referències visuals *abans* d'escriure una línia de codi:

- Color primari → secundari → neutral → accent
- Font heading → font body (fora d'Inter+Roboto)
- Estil visual (minimalista, editorial, bold, orgànic...)
- **2–3 webs de referència** que el client admira — sense referència, l'agent omple amb defaults

<div class="grid cards" markdown>

-   :material-cards:{ .lg .middle } **[awesome-design-md](https://github.com/voltagent/awesome-design-md)**

    ---

    Col·lecció de fitxers `DESIGN.md` de 70+ marques (Stripe, Vercel, Apple, Figma, Spotify...) en format que els agents entenen directament.

    **Com usar-lo a l'INTAKE:**

    1. El client diu "m'agrada com fa Stripe" o "vull algo com Vercel"
    2. Agafes el `DESIGN.md` de la marca del repo
    3. L'incloues com a context de sessió a OpenCode
    4. L'agent segueix aquelles regles de color, tipografia i components — adaptat als tokens del client

    No s'instal·la. És un repo de referència puntual.

</div>

---

## Gradients de background

Els gradients de VoraData segueixen un **estil editorial amb capes de llum**. Mai gradients plans de dos colors sense profunditat.

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

!!! tip "Flux recomanat"
    1. Tens la paleta del client → obre Gradient Studio
    2. Genera (mode *Full* o *Duotone*) → exporta CSS
    3. Adapta a `@theme {}` → aplica al hero

---

## Eines de disseny

<div class="grid cards" markdown>

-   :material-palette-swatch:{ .lg .middle } **[Realtime Colors](https://realtimecolors.com)**

    ---

    Visualitza la paleta del client sobre una UI real en temps real. Veus immediatament si la combinació de colors funciona abans de tocar codi.

    **Quan usar-lo:** al INTAKE, en rebre els colors del client.

-   :material-format-letter-case:{ .lg .middle } **[Fontpair.co](https://fontpair.co)**

    ---

    Combinacions de fonts curades. Per sortir d'Inter+Roboto i donar personalitat tipogràfica al projecte.

    **Quan usar-lo:** quan la dissenyadora no especifica fonts — triar parella aquí.

-   :material-creation:{ .lg .middle } **[UIverse.io](https://uiverse.io)**

    ---

    Components CSS/HTML únics fets per la comunitat. Botons, cards, loaders i inputs que no semblen de plantilla genèrica.

    **Quan usar-lo:** per a elements UI petits (botons, badges, inputs) que necessiten personalitat visual.

-   :material-monitor-screenshot:{ .lg .middle } **[Shots.so](https://shots.so)**

    ---

    Mockups ràpids per ensenyar al client com quedarà la web abans de construir-la. Ideal per a validar disseny sense codi.

    **Quan usar-lo:** entre INTAKE i BUILD per a aprovació visual del client.

-   :material-layers-outline:{ .lg .middle } **[Mobbin](https://mobbin.com)**

    ---

    Base de dades de UIs reals d'apps i webs de referència. Per entendre com es resolen patrons, no per copiar.

    **Quan usar-lo:** quan cal resoldre un patró de navegació, onboarding o layout complex.

-   :material-image-multiple-outline:{ .lg .middle } **[Land-book](https://land-book.com) / [Lapa Ninja](https://lapa.ninja)**

    ---

    Galeries d'inspiració específiques de **landing pages** (a diferència de Mobbin, que és d'apps en general), filtrables per sector i estil visual.

    **Quan usar-lo:** al començar el disseny d'una landing, abans de l'skeleton (Fase A).

-   :material-image-outline:{ .lg .middle } **[Unsplash](https://unsplash.com) / [Pexels](https://pexels.com)**

    ---

    Banc de fotos gratuït, ús comercial permès. Per al INTAKE quan el client marca "no" o "usar placeholders" a la casella d'imatges.

    **Quan usar-lo:** com a placeholder d'entrega ràpida — marcar-ho a la revisió perquè el client acabi aportant fotos pròpies (producte, equip, local) per a la versió final.

-   :material-vector-square:{ .lg .middle } **[unDraw](https://undraw.co)**

    ---

    Il·lustracions SVG gratuïtes i personalitzables al color de marca (un sol camp de color abans de descarregar). Per a seccions Features o empty-states sense fotografia.

    **Quan usar-lo:** quan una secció necessita suport visual però no té fotos ni sentit tenir-ne.

-   :material-blur:{ .lg .middle } **[Gradient Studio](https://gradientsaas.blogspot.com)**

    ---

    Generador de gradients editorials. Export directe a CSS, Tailwind o SCSS. Gratuït, ús comercial permès.

    **Quan usar-lo:** per a backgrounds de hero i seccions. Modes *Full* o *Duotone*.

</div>

---

## Components UI

<div class="grid cards" markdown>

-   :material-toy-brick:{ .lg .middle } **[Preline UI](https://preline.co)**

    ---

    Biblioteca open source Tailwind + Vanilla JS. Compatible amb **Tailwind v4.3**. MIT License, gratuït per a clients. Té **MCP propi** per importar components des de l'agent.

    **Quan usar-lo:** dropdowns, modals, tabs, accordions, formularis interactius.

    ```bash
    npm install preline
    ```
    ```html
    <script src="./node_modules/preline/dist/preline.js"></script>
    ```

    → Guia completa: [docs MCP Preline](../ia/mcp/preline.md)

-   :material-toy-brick-outline:{ .lg .middle } **[Flowbite](https://flowbite.com)**

    ---

    Alternativa a Preline. Bona cobertura de taules de dades, datepickers i inputs complexos. Gratuït en la versió base. Té **MCP oficial** open source.

    **Quan usar-lo:** quan Preline no tingui el component que necessites.

    ```bash
    npx -y flowbite-mcp
    ```

</div>

---

## Animacions

<div class="grid cards" markdown>

-   :material-play-speed:{ .lg .middle } **[GSAP](https://gsap.com)**

    ---

    Estàndard de la indústria. Vanilla JS pur. **Tots els plugins gratuïts des de v3.13+** (SplitText, MorphSVG, ScrambleText...).

    **Quan usar-lo:** timelines encadenades, ScrollTrigger, SplitText, efectes hero elaborats, scroll horitzontal.

    ```bash
    npm install gsap
    ```

    → Guia completa amb patrons de producció: [docs GSAP](../ia/gsap.md)

-   :material-eye-outline:{ .lg .middle } **[AOS](https://michalsnik.github.io/aos/)**

    ---

    Animate On Scroll. Zero dependències, una línia de JS. CSS-driven, lleuger.

    **Quan usar-lo:** reveals simples en scroll (fade, slide). El 90% de les landings no necessiten més.

    ```html
    <link rel="stylesheet" href="https://unpkg.com/aos@2.3.1/dist/aos.css">
    <script src="https://unpkg.com/aos@2.3.1/dist/aos.js"></script>
    <script>AOS.init({ duration: 600, once: true })</script>
    ```
    ```html
    <div data-aos="fade-up" data-aos-delay="100">Element</div>
    ```

-   :material-cursor-move:{ .lg .middle } **[Lenis](https://lenis.darkroom.engineering)**

    ---

    Smooth scroll ultralleuger. Millora dràsticament la sensació de qualitat d'una landing sense esforç.

    **Quan usar-lo:** sempre. Especialment combinat amb GSAP ScrollTrigger.

    ```bash
    npm install lenis
    ```
    ```js
    const lenis = new Lenis({ duration: 1.2 })
    gsap.ticker.add(time => lenis.raf(time * 1000))
    lenis.on('scroll', ScrollTrigger.update)
    ```

</div>

---

## Icones

<div class="grid cards" markdown>

-   :material-vector-polyline:{ .lg .middle } **[Lucide](https://lucide.dev)**

    ---

    El millor SVG icon set gratuït. Consistent, lleuger, 1500+ icones. MIT License. Tots els projectes.

    **Opció A — inline (recomanada):**
    ```html
    <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24"
         viewBox="0 0 24 24" fill="none" stroke="currentColor"
         stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
      <path d="M5 12h14"/><path d="m12 5 7 7-7 7"/>
    </svg>
    ```

    **Opció B — CDN (prototips):**
    ```html
    <script src="https://unpkg.com/lucide@latest/dist/umd/lucide.min.js"></script>
    <script>lucide.createIcons()</script>
    <i data-lucide="arrow-right"></i>
    ```

</div>

---

## Verificació i referència

<div class="grid cards" markdown>

-   :material-shield-check:{ .lg .middle } **[WebAIM Contrast Checker](https://webaim.org/resources/contrastchecker/)**

    ---

    Verificar contrast text/fons. WCAG 2.1 AA: mínim **4.5:1** text normal, **3:1** text gran.

    Obligatori abans de lliurar qualsevol projecte.

-   :material-book-alphabet:{ .lg .middle } **[Name That UI](https://namethatui.com)**

    ---

    Nomenclatura estàndard de components UI. Per quan la dissenyadora descriu un component i cal saber el nom tècnic.

</div>
