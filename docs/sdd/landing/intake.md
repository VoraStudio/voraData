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

## Extracció de colors des de Canva

Canva no exporta tokens directament. Per obtenir els colors exactes:

1. **Canva** → disseny → clic a qualsevol element de color → copia el hex
2. Alternativament: exporta a PNG i usa [Realtime Colors](https://realtimecolors.com) per visualitzar la paleta
3. Fonts: a Canva → selecciona text → veure nom de font al panel lateral

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
