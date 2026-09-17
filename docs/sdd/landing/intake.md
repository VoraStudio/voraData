# INTAKE — Template de sessió

> Omple aquest formulari en 5 minuts abans d'obrir OpenCode. Copia el bloc i enganxa'l com a primer prompt de sessió.

---

## Com usar-lo

1. Copia el template de sota
2. Omple els camps — deixa `?` als que no saps
3. Enganxa'l com a **primer missatge** a OpenCode
4. L'agent llegirà `AGENT.md` + el teu INTAKE i estarà llest per construir

---

## Template — Landing Page

```
INTAKE: Landing Page
Client: [nom client]
Projecte: [nom web / domini]

— IDENTITAT VISUAL —
Color primari:   #______
Color secundari: #______
Color neutre:    #______ (fons clar) / #______ (fons fosc)
Color accent:    #______

Font heading:  [nom font] — ex: Playfair Display, Syne, Space Grotesk
Font body:     [nom font] — ex: DM Sans, Nunito, Lato
(Si no especificades, triar parella a fontpair.co)

Estil visual: [minimalista / editorial / bold / orgànic / corporatiu / tècnic]

Webs de referència (2–3 que el client admira):
- [url1]
- [url2]
- [url3]

— ESTRUCTURA —
Seccions (en ordre):
- Hero: [descripció breu — ex: titular + subtítol + CTA]
- [secció 2]
- [secció 3]
- [secció 4]
- Footer

Animacions: [cap / AOS reveals / GSAP hero / scroll horitzontal]
Idioma del contingut: [català / castellà / anglès]

Objectiu de conversió principal: [reservar demo / comprar / deixar email / trucar]
Tracking: [GA4 / Meta Pixel / cap]

— CONTINGUT —
Copy proporcionat pel client: [sí / no / parcial]
Imatges: [sí (WebP) / no (usar placeholders) / generades amb IA]
Logo: [sí / no]

— NOTES —
[Qualsevol restricció, preferència o context addicional]
```

---

## Template — SaaS UI

```
INTAKE: SaaS Application
Client: [nom client]
Projecte: [nom app]
Descripció: [1–2 frases de què fa l'app]

— IDENTITAT VISUAL —
Color primari:   #______
Color secundari: #______
Color neutre bg: #______
Color accent:    #______

Font heading:  [nom font]
Font body:     [nom font]

Estil visual: [dashboard tècnic / SaaS modern / minimalista / bold]

Webs de referència:
- [url1]
- [url2]

— ARQUITECTURA —
Tipus d'usuaris: [ex: admin + client final]
Pàgines principals:
- [pàgina 1: descripció]
- [pàgina 2: descripció]
- [pàgina 3: descripció]

Backend: [Symfony / cap / ja existent]
Auth: [sí / no / ja existent]
Rol agent en aquesta sessió: [BUILD complet / només UI / components específics]

— NOTES —
[Restriccions tècniques, integracions, context addicional]
```

---

## Extracció de tokens des de Figma (versió gratuïta)

Figma no exporta un `@theme {}` directament, però el pla gratuït sí exposa els valors exactes sense eines de tercers:

1. **Colors**: selecciona qualsevol element → panell dret "Fill" → copia el hex directament (icona de pipeta o clic al valor)
2. **Fonts**: selecciona un element de text → panell dret "Text" → nom de la font i pes hi apareixen
3. **Espaiat/mides**: amb l'element seleccionat, el panell "Design" mostra amplada/alçada i el gap en Auto Layout — útil per calibrar les proporcions dels tokens d'espaiat
4. Exporta captures (PNG) per seccions amb l'eina d'Export del panell dret quan calgui passar la imatge de referència a l'agent

!!! tip "Si el client no té colors definitius"
    Passa els hex aproximats igualment. L'agent generarà el `@theme {}` amb ells i podràs ajustar. Millor tokens aproximats que cap token.

---

## Primer prompt recomanat

Després del template INTAKE, afegeix:

```
Llegeix AGENT.md. Inicia fase INTAKE amb la informació anterior.
Extreu els design tokens → genera el @theme {} de Tailwind v4.
Confirma la paleta i fonts abans de construir res.
```
