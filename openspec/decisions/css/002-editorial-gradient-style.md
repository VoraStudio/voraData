# 002 — Gradients de background en estil editorial

**Stack**: css
**Estat**: acceptat
**Data**: 2026-09-16

## Context

Calia definir un criteri estètic per als gradients de background de landings i aplicacions. Sense una convenció, cada projecte pot acabar amb gradients plans i genèrics que no reflecteixen la qualitat visual de VoraData.

## Decisió

Els gradients de background segueixen un **estil editorial amb capes de llum**: radial gradients superposats, efectes de mesh glow, aurora o film grain. Mai gradients lineals plans de dos colors sense profunditat.

Quan l'agent generi CSS de gradient, ha de produir codi amb múltiples capes radials. Quan el gradient visual ha de ser molt específic o complex, usar [Gradient Studio](https://gradientsaas.blogspot.com) per generar i exportar a CSS/Tailwind.

## Conseqüències

- Consistència visual entre tots els projectes de VoraData
- Els heroes i backgrounds tindran profunditat visual sense necessitat de imatges
- L'agent pot generar el CSS directament seguint el patró de capes radials
- Per a gradients molt elaborats: Gradient Studio exporta CSS/Tailwind vàlid per a ús comercial
