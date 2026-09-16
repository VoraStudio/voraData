# Preline MCP — Components UI via Agent

> Preline MCP connecta l'agent al catàleg de components Preline en temps real. En lloc de generar codi de memòria (que pot estar desactualitzat), l'agent consulta el codi font real i l'integra directament al projecte.

---

## Configuració

Instal·la l'Agent Skill des de l'arrel del projecte:

```bash
npx skills add htmlstreamofficial/preline
```

Això configura Preline per a OpenCode automàticament. No cal modificar `opencode.json` manualment.

!!! warning "Cost"
    Gratuït fins l'**1 de gener de 2027** inclòs amb Preline Pro. A partir de llavors requereix subscripció.

---

## Què fa l'agent amb Preline MCP

L'agent té accés a 7 eines en temps real:

| Eina | Què fa |
|---|---|
| `components_list` | Llista tots els components disponibles per secció |
| `single_component` | Retorna el codi HTML/CSS/JS d'un component concret |
| `blocks_categories` | Mostra la jerarquia de blocs pre-assemblats |
| `blocks_in_category` | Llista els blocs d'una categoria |
| `single_block` | Retorna un bloc complet (HTML + CSS + scripts) |
| `component_documentation` | Referència de l'API JavaScript interactiva |
| `framework_documentation` | Guies d'integració (Laravel, Vue, React...) |

**La diferència clau**: sense MCP l'agent inventa classes que potser no existeixen. Amb MCP, obté el codi font real de la versió instal·lada.

---

## Fórmula de prompt

Preline MCP funciona millor amb prompts estructurats en 5 parts:

| Part | Descripció | Exemple |
|---|---|---|
| **Trigger** | Nomena Preline explícitament | *"Using Preline..."* |
| **Unitat** | Component (element únic) o Block (secció pre-assemblada) | *"...add a pricing table component..."* |
| **Què** | Descriu en llenguatge planer | *"...with monthly/yearly toggle..."* |
| **Estil** | Sistema de classes i tema | *"...utility classes, ocean theme..."* |
| **On** | Fitxer i ubicació exacta | *"...into pricing.html, below the hero"* |

!!! tip "Regla d'or"
    **Mai especifiquis IDs de components** — descriu el que necessites en paraules. L'agent fa la cerca al catàleg.

---

## Casos d'ús amb exemples

### Landing page — navbar responsive

```
Using Preline, add a responsive navbar component with a logo on the left,
navigation links in the center, and a CTA button on the right.
Include mobile hamburger menu. Use utility classes.
Add it to the top of index.html inside the <header> tag.
```

---

### Landing page — secció de preus

```
Using Preline, add a pricing block with 3 tiers (Free, Pro, Enterprise),
monthly/yearly toggle, and feature comparison list.
Use utility classes with the default theme.
Insert it into pricing.html after the hero section.
```

---

### Landing page — formulari de contacte

```
Using Preline, add a contact form component with fields for name, email,
subject and message, plus a submit button.
Include client-side validation states (error, success).
Use utility classes. Place it in contact/index.html inside <main>.
```

---

### SaaS — modal de confirmació

```
Using Preline, add a confirmation modal component that asks
"Are you sure you want to delete this item?" with Cancel and Confirm buttons.
Use utility classes. Add it to dashboard.html before the closing </body>.
```

---

### SaaS — sidebar de navegació

```
Using Preline, add an application sidebar block with logo, main navigation links,
user avatar at the bottom, and collapsible sub-menus.
Use utility classes with the moon theme.
Start from an application layout example as the base.
Save as layouts/dashboard.html.
```

---

### Generar un tema per a un client

```
Using Preline, generate a theme file based on brand primary color #f48e24
and a professional, modern aesthetic. Use utility classes.
```

---

## Temes disponibles

`default` · `harvest` · `retro` · `moon` · `ocean` · `bubblegum` · `cashmere` · `autumn` · `olive`

Especifica el tema al prompt o deixa `default` si la paleta del client no encaixa amb cap.

---

## Bones pràctiques

!!! tip "Un component a la vegada"
    Demana un component o bloc cada vegada. Deixa que l'agent acabi la integració abans de demanar el següent. Acumular peticions en un sol prompt genera codi inconsistent.

!!! tip "Component vs Block"
    - **Component**: element únic reutilitzable (botó, input, badge, dropdown)
    - **Block**: secció pre-assemblada llesta per usar (hero, pricing, testimonials, footer)

    Per a una landing, usa **blocks**. Per a elements individuals d'una UI, usa **components**.

!!! tip "Layouts: skeleton primer"
    Per a pàgines complexes, no descrius cada element. Ancla a un exemple existent:

    ```
    Start from an application layout example as the base.
    Then: add a notifications panel on the right sidebar.
    Keep the top navbar and left navigation as-is.
    Use utility classes. Save as dashboard.html.
    ```

!!! warning "Resposta molt llarga"
    Per a blocs complexos, el servidor retorna una URL d'artefacte temporal en lloc del codi directament. L'agent gestiona la descàrrega automàticament.

---

## Workflow recomanat durant el BUILD d'una landing

```
1. INTAKE completat → paleta, fonts, seccions definides
2. Per cada secció:
   → Prompt Preline MCP per al bloc corresponent
   → L'agent integra el codi
   → Adaptes colors i tipografia al design system del client via @theme {}
3. Components interactius (navbar, modal, formulari):
   → Prompt Preline MCP component per component
4. Revisió humana de cada bloc major
```
