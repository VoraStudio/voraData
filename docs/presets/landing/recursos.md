# Recursos — Landing Page

> Eines per a la fase de **disseny en Figma**, abans del handoff a l'agent. Per als recursos tècnics usats durant la construcció (Preline, GSAP, verificació de contrast...), vegeu [Disseny — normes visuals i recursos](../../sdd/design.md).

## Components i inspiració

<div class="grid cards" markdown>

-   :material-creation:{ .lg .middle } **[UIverse.io](https://uiverse.io)**

    ---

    Components CSS/HTML fets per la comunitat — botons, cards, loaders, inputs, toggles. Útil per trencar el "look genèric de Tailwind" abans de dissenyar la secció des de zero.

    !!! tip "Com usar-lo a Figma"
        No cal maquetar-ho pixel a pixel: agafa la idea (forma, micro-interacció, jerarquia) i dissenya-la amb els tokens del client. El codi final es genera després amb `design-system/`, no copiant l'HTML d'UIverse directament.

-   :material-layers-outline:{ .lg .middle } **[Mobbin](https://mobbin.com)**

    ---

    Base de dades de UIs reals d'apps i webs — filtrable per patró (onboarding, pricing, navegació). Per veure com resolen altres el mateix problema, no per copiar.

    !!! tip "Quan usar-lo"
        Quan una secció (pricing, FAQ, social proof) no surt bé a la primera — mira 3-4 exemples reals abans de decidir la teva versió.

-   :material-monitor-screenshot:{ .lg .middle } **[Shots.so](https://shots.so)**

    ---

    Mockups ràpids (dispositiu + fons) per presentar el disseny al client abans de picar cap línia de codi.

    !!! tip "Quan usar-lo"
        Entre el disseny a Figma i l'aprovació del client — evita ensenyar un frame de Figma nu en una reunió.

-   :material-image-multiple-outline:{ .lg .middle } **[Land-book](https://land-book.com) / [Lapa Ninja](https://lapa.ninja)**

    ---

    Galeries d'inspiració **específiques de landing pages** (a diferència de Mobbin, que és d'apps en general) — filtrable per sector i estil visual.

    !!! tip "Quan usar-lo"
        Al començar el disseny, abans de la Fase A — per decidir l'estructura general de la pàgina segons el sector del client.

</div>

## Icones

<div class="grid cards" markdown>

-   :material-vector-polyline:{ .lg .middle } **[Lucide](https://lucide.dev) — recomanada**

    ---

    És el set d'icones que ja fa servir el codi (vegeu [Icones](../../sdd/design.md#icones)). Té **plugin oficial de Figma** i fitxer de comunitat amb totes les 1.500+ icones — dissenya amb les mateixes icones que després es generen al HTML, sense sorpreses en el handoff.

    Consistent, gratuïta (MIT), 1.500+ icones.

-   :material-shape-outline:{ .lg .middle } **[Phosphor Icons](https://phosphoricons.com) — alternativa**

    ---

    Si un projecte necessita més varietat d'estil (thin, light, bold, duotone, fill) que Lucide no cobreix. També té plugin de Figma.

    !!! warning "No barrejar sets"
        Si es tria Phosphor per a un projecte, cal fer-ho servir consistentment a tota la landing — mai mesclar icones de Lucide i Phosphor a la mateixa pàgina, es nota el canvi d'estil visual.

</div>

## Imatges i il·lustracions

<div class="grid cards" markdown>

-   :material-image-outline:{ .lg .middle } **[Unsplash](https://unsplash.com) / [Pexels](https://pexels.com)**

    ---

    Banc de fotos gratuït, ús comercial permès. Per al INTAKE quan el client marca "no" o "usar placeholders" a la casella d'imatges.

    !!! warning "No és substitut de fotos reals del client"
        Fes-les servir com a placeholder d'entrega ràpida, però marca-ho clarament en la revisió — el client hauria d'acabar aportant les seves pròpies fotos (producte, equip, local) per a la versió final.

-   :material-vector-square:{ .lg .middle } **[unDraw](https://undraw.co)**

    ---

    Il·lustracions SVG gratuïtes i **personalitzables al color de marca** (un sol camp de color a triar abans de descarregar). Ideal per a seccions Features o empty-states quan no hi ha fotografia.

</div>

## Color i tipografia

<div class="grid cards" markdown>

-   :material-palette-swatch:{ .lg .middle } **[Realtime Colors](https://realtimecolors.com)**

    ---

    Visualitza la paleta del client sobre una UI real abans de portar-la a Figma. Detecta ràpid si un color de marca falla en contrast sobre fons clar/fosc.

-   :material-format-letter-case:{ .lg .middle } **[Fontpair.co](https://fontpair.co)**

    ---

    Combinacions de fonts curades — per quan el client no especifica tipografia i cal triar-ne una amb personalitat, fora d'Inter+Roboto.

</div>

!!! note "Aquesta pàgina duplica entrades de `sdd/design.md`"
    Land-book/Lapa Ninja, Unsplash/Pexels, unDraw, Realtime Colors i Fontpair.co ja estan documentats a [Disseny — normes visuals i recursos](../../sdd/design.md#eines-de-disseny) — es repeteixen aquí perquè són d'ús diari en la fase de disseny, no només de construcció. Aquella pàgina és la font de veritat: si canvien, actualitzar allà primer.
