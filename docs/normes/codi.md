# Normes de codi

> Estàndards tècnics aplicables a tots els projectes de VoraData.

---

## HTML

!!! danger "Prohibit"
    Mai `<style>` ni CSS inline a l'HTML. Mai `<script>` inline ni JS en atributs (`onclick`, `onload`, etc.).

<div class="grid cards" markdown>

-   :material-check:{ .lg .middle } **Semàntica**

    ---

    Utilitza sempre els elements correctes:

    ```html
    <header>   → capçalera + navbar
    <main>     → contingut principal
    <section>  → blocs de contingut
    <article>  → contingut independent
    <footer>   → peu de pàgina
    ```

    Mai un `<div>` on existeix un element semàntic adequat.

-   :material-format-header-1:{ .lg .middle } **Headings**

    ---

    - Un sol `<h1>` per pàgina
    - Jerarquia correcta: h1 → h2 → h3, sense saltar nivells
    - Els headings descriuen el contingut, no l'estil

-   :material-image:{ .lg .middle } **Imatges**

    ---

    ```html
    <img
      src="hero.webp"
      alt="Descripció significativa"
      width="800"
      height="600"
      loading="lazy"
    >
    ```

    - Format WebP per defecte
    - `width` i `height` sempre explícits (evita CLS)
    - `loading="lazy"` excepte above-the-fold
    - SVGs d'icones: inline o sprite, mai `<img src="icon.svg">`

</div>

!!! tip "Accessibilitat des del principi"
    Escriure HTML semàntic correctament ja resol el 70% dels requisits d'accessibilitat. No és feina extra — és fer-ho bé des del principi.

---

## CSS / Tailwind

!!! danger "Prohibit"
    Mai `<style>` ni atribut `style=""` a l'HTML. Tot el CSS va a fitxers externs.

<div class="grid cards" markdown>

-   :material-cellphone:{ .lg .middle } **Mobile-first**

    ---

    Els estils base sempre per a mòbil. S'amplien per a pantalles més grans:

    ```html
    <!-- ✅ Correcte -->
    <div class="text-base md:text-lg lg:text-xl">

    <!-- ❌ Incorrecte -->
    <div class="text-xl lg:text-base">
    ```

-   :material-variable:{ .lg .middle } **Variables de disseny**

    ---

    Tokens de disseny a `@theme {}` (Tailwind v4):

    ```css
    @theme {
      --color-brand-primary: #f48e24;
      --color-brand-accent:  #E98525;
      --font-heading: 'Outfit', sans-serif;
    }
    ```

-   :material-puzzle:{ .lg .middle } **Quan usar CSS custom**

    ---

    Tailwind primer, sempre. CSS custom **només** per al que Tailwind no pot cobrir:

    - Animacions complexes
    - Gradients de text (`background-clip: text`)
    - Efectes de glassmorphism

</div>

!!! tip "Consell sènior"
    Abans d'escriure CSS custom, busca si Tailwind ja té una classe per a això. El 95% de vegades la té. El CSS custom és deute tècnic — afegeix-lo només quan sigui imprescindible.

---

## JavaScript

!!! danger "Prohibit"
    Mai `<script>` inline ni gestors d'events en atributs HTML (`onclick`, `addEventListener` directament al markup). Tot va a fitxers externs.

<div class="grid cards" markdown>

-   :material-folder-multiple:{ .lg .middle } **Estructura de fitxers**

    ---

    ```
    assets/js/
    ├── app.js           ← punt d'entrada, importa mòduls
    └── modules/
        ├── navbar.js    ← un fitxer per responsabilitat
        ├── slider.js
        └── form.js
    ```

-   :material-code-braces:{ .lg .middle } **Estàndards**

    ---

    - Sense frameworks — Vanilla JS
    - Sense `var` — només `const` i `let`
    - Sense `console.log` a producció
    - Funcions amb nom descriptiu en anglès

-   :material-connection:{ .lg .middle } **DOM i events**

    ---

    ```js
    // ✅ Correcte — fitxer extern
    document.addEventListener('DOMContentLoaded', () => {
      const btn = document.querySelector('[data-menu-toggle]')
      btn?.addEventListener('click', toggleMenu)
    })

    // ❌ Incorrecte — mai inline
    // <button onclick="toggleMenu()">
    ```

</div>

!!! tip "Consell sènior"
    Atributs `data-*` per a seleccionar elements JS en lloc de classes CSS. Separa responsabilitats: les classes CSS serveixen per a estils, els `data-*` per a comportament.

---

## PHP / Symfony

<div class="grid cards" markdown>

-   :material-shield-check:{ .lg .middle } **Tipat estricte**

    ---

    Sempre al principi de cada fitxer PHP:

    ```php
    <?php
    declare(strict_types=1);
    ```

-   :material-layers:{ .lg .middle } **Arquitectura**

    ---

    - Sense lògica de negoci als Controllers — va als Services
    - Controllers prims: reben petició, criden Service, retornen resposta
    - Un Service per responsabilitat

-   :material-format-list-checks:{ .lg .middle } **Estàndards**

    ---

    - PSR-12 per a format de codi
    - Noms de classes en PascalCase
    - Mètodes i variables en camelCase
    - Constants en UPPER_SNAKE_CASE

</div>

!!! tip "Consell sènior"
    Si un Controller té més de 30 línies de lògica, alguna cosa va malament. Extreu-la a un Service. Els Controllers han de ser tan llegibles com una taula de continguts.
