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

## Color i tipografia

<div class="grid cards" markdown>

-   :material-palette-swatch:{ .lg .middle } **[Realtime Colors](https://realtimecolors.com)**

    ---

    Visualitza la paleta del client sobre una UI real abans de portar-la a Figma. Detecta ràpid si un color de marca falla en contrast sobre fons clar/fosc.

-   :material-format-letter-case:{ .lg .middle } **[Fontpair.co](https://fontpair.co)**

    ---

    Combinacions de fonts curades — per quan el client no especifica tipografia i cal triar-ne una amb personalitat, fora d'Inter+Roboto.

</div>

!!! note "Aquests dos ja estan documentats a `sdd/design.md`"
    Es repeteixen aquí perquè són d'ús diari en la fase de disseny, no només de construcció. La font de veritat és [Disseny — normes visuals i recursos](../../sdd/design.md#eines-de-disseny) — si canvien, actualitzar allà primer.
