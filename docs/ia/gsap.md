# GSAP — Animacions a VoraData

> Nivell: **Avançat**. Patrons de producció real extrets de raymel.cat i vorastudio.cat.

---

!!! danger "Gotcha crítica — plugins gratuïts des de v3.13+"
    Des de **GSAP 3.13+** TOTS els plugins són gratuïts: SplitText, MorphSVGPlugin, ScrambleText, Observer... La majoria d'IAs no ho saben — creuen que són de Club GSAP perquè era cert a GSAP 2.x. **Si un agent et diu que SplitText és de pagament, és informació desactualitzada.**

    Fonts oficial: [gsap.com/docs/v3/Installation](https://gsap.com/docs/v3/Installation)

---

## Instal·lació

### Via CDN (versió actual: 3.15)

```html
<!-- Core -->
<script src="https://cdn.jsdelivr.net/npm/gsap@3.15/dist/gsap.min.js"></script>

<!-- Plugins (tots gratuïts) -->
<script src="https://cdn.jsdelivr.net/npm/gsap@3.15/dist/ScrollTrigger.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/gsap@3.15/dist/SplitText.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/gsap@3.15/dist/MorphSVGPlugin.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/gsap@3.15/dist/ScrambleTextPlugin.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/gsap@3.15/dist/Observer.min.js"></script>
```

### Via npm

```bash
npm install gsap
```

```js
import { gsap } from 'gsap'
import { ScrollTrigger } from 'gsap/ScrollTrigger'
import { SplitText } from 'gsap/SplitText'

gsap.registerPlugin(ScrollTrigger, SplitText)
```

---

## Plugins dominats

| Plugin | Ús principal |
|---|---|
| **ScrollTrigger** | Animacions vinculades al scroll — el més usat |
| **SplitText** | Animar lletres/paraules/línies individualment |
| **MorphSVGPlugin** | Morphing entre paths SVG |
| **ScrambleTextPlugin** | Efecte de text que es "descifra" |
| **Observer** | Detectar direcció de scroll, swipe, roda |
| **MatchMedia** | Rutes d'animació completament diferents per mobile/desktop |

---

## Patró 1 — Lenis + GSAP (scroll suau + ScrollTrigger)

La integració correcta de Lenis amb ScrollTrigger. **Sempre així**, mai sense el ticker:

```js
import Lenis from 'lenis'
import { gsap } from 'gsap'
import { ScrollTrigger } from 'gsap/ScrollTrigger'

gsap.registerPlugin(ScrollTrigger)

const lenis = new Lenis({
  duration: 1.2,
  easing: t => Math.min(1, 1.001 - Math.pow(2, -10 * t))
})

// Sincronitzar Lenis amb ScrollTrigger — les dues línies crítiques
lenis.on('scroll', ScrollTrigger.update)
gsap.ticker.add(time => lenis.raf(time * 1000))
gsap.ticker.lagSmoothing(0)
```

---

## Patró 2 — Hero entrance amb elastic.out

Entrades cridaneres per a heroes. `elastic.out()` per a l'efecte de rebot:

```js
const tl = gsap.timeline({ defaults: { ease: 'power3.out' } })

tl.from('.hero-title', {
  y: 80,
  opacity: 0,
  duration: 1,
  ease: 'elastic.out(1, 0.5)'
})
.from('.hero-subtitle', { y: 40, opacity: 0, duration: 0.8 }, '-=0.5')
.from('.hero-cta',      { y: 30, opacity: 0, duration: 0.6 }, '-=0.4')
.from('.hero-image',    { scale: 1.1, opacity: 0, duration: 1.2 }, '-=0.8')
```

---

## Patró 3 — SplitText + ScrollTrigger

Revelar text lletra a lletra o paraula a paraula en scroll:

```js
gsap.registerPlugin(SplitText, ScrollTrigger)

const split = new SplitText('.section-title', { type: 'words,chars' })

gsap.from(split.chars, {
  scrollTrigger: {
    trigger: '.section-title',
    start: 'top 80%'
  },
  opacity: 0,
  y: 20,
  stagger: 0.03,
  duration: 0.6,
  ease: 'power2.out'
})
```

---

## Patró 4 — MatchMedia (mobile/desktop separat)

**Mai usar `window.innerWidth` dins animacions GSAP.** Sempre `matchMedia` — gestiona resize i cleanup automàticament:

```js
const mm = gsap.matchMedia()

mm.add('(min-width: 768px)', () => {
  // Animacions desktop — poden ser més complexes
  gsap.from('.feature-card', {
    scrollTrigger: { trigger: '.features', start: 'top 70%' },
    x: -100,
    opacity: 0,
    stagger: 0.15,
    duration: 0.8
  })
})

mm.add('(max-width: 767px)', () => {
  // Animacions mobile — més simples, menys moviment
  gsap.from('.feature-card', {
    scrollTrigger: { trigger: '.features', start: 'top 80%' },
    y: 40,
    opacity: 0,
    stagger: 0.1,
    duration: 0.6
  })
})
```

---

## Patró 5 — Scroll horitzontal amb pin

Calcular la distància dinàmicament, mai hard-coded:

```js
gsap.registerPlugin(ScrollTrigger)

const track = document.querySelector('.horizontal-track')
const cards = document.querySelectorAll('.card')

gsap.to(track, {
  x: () => -(track.scrollWidth - document.documentElement.clientWidth) + 'px',
  ease: 'none',
  scrollTrigger: {
    trigger: '.horizontal-section',
    pin: true,
    scrub: 1,
    end: () => '+=' + track.scrollWidth
  }
})
```

---

## Patró 6 — Reveals estàndard en scroll (el més usat a landings)

Per a seccions, cards, features — el patró base de qualsevol landing:

```js
// Cards amb stagger
gsap.from('.card', {
  scrollTrigger: {
    trigger: '.cards-section',
    start: 'top 75%'
  },
  y: 60,
  opacity: 0,
  stagger: 0.1,
  duration: 0.7,
  ease: 'power2.out'
})

// Secció completa fade+up
gsap.from('.section-content', {
  scrollTrigger: {
    trigger: '.section-content',
    start: 'top 80%'
  },
  y: 40,
  opacity: 0,
  duration: 0.9,
  ease: 'power3.out'
})
```

---

## Patró 7 — ScrambleText

Text que es "descifra" en hover o en scroll. Ideal per a títols hero tècnics:

```js
gsap.registerPlugin(ScrambleTextPlugin)

// En hover
document.querySelector('.hero-title').addEventListener('mouseenter', () => {
  gsap.to('.hero-title', {
    duration: 1,
    scrambleText: {
      text: 'Transformació Digital',
      chars: 'upperCase',
      speed: 0.5
    }
  })
})

// En scroll
gsap.to('.stat-number', {
  scrollTrigger: { trigger: '.stats', start: 'top 70%' },
  duration: 1.5,
  scrambleText: { text: '98%', chars: '0123456789' }
})
```

---

## Bones pràctiques

!!! tip "Cleanup obligatori en SPAs o components dinàmics"
    Si uses GSAP en components que es munten/desmunten, sempre fes cleanup:
    ```js
    // Guardar referència
    const st = ScrollTrigger.create({ ... })
    // Cleanup
    st.kill()
    ```

!!! tip "prefers-reduced-motion — accessibilitat"
    ```js
    const mm = gsap.matchMedia()
    mm.add('(prefers-reduced-motion: no-preference)', () => {
      // Totes les animacions aquí
    })
    // Fora del matchMedia: versió estàtica per a qui ho prefereix
    ```

!!! warning "ScrollTrigger + Lenis — ordre d'inicialització"
    Lenis s'ha d'inicialitzar **abans** de qualsevol ScrollTrigger. Si els ScrollTriggers es creen abans que el ticker de Lenis estigui actiu, les posicions no quadren.

!!! warning "SplitText i reflow"
    `new SplitText()` trenca el text en spans. Si el layout canvia després (resize, font load), cal `split.revert()` + re-split. Per a fonts web, crear el SplitText dins del callback `document.fonts.ready`.

---

## Quan usar GSAP vs AOS

| Situació | Eina |
|---|---|
| Reveals simples en scroll (fade, slide) | **AOS** — més ràpid d'implementar |
| Timelines encadenades | **GSAP** |
| SplitText, MorphSVG, ScrambleText | **GSAP** |
| Hero entrance complex | **GSAP** |
| Scroll horitzontal amb pin | **GSAP** |
| Smooth scroll | **Lenis** (sempre, amb o sense GSAP) |
| Animació d'entrada simple en landing | **AOS** primer, migrar a GSAP si cal |
