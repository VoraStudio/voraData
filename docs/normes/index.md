# 📋 Normes Globals

> Les regles base de VoraData. S'apliquen a tots els projectes, sigui quin sigui el tipus o el client.

Aquestes normes no són opcionals. Defineixen com treballem, com lliurem i com garantim la qualitat.

---

## Resum

<div class="grid cards" markdown>

-   :material-code-tags:{ .lg .middle } **Codi**

    ---

    HTML semàntic, Tailwind mobile-first, Vanilla JS i PHP/Symfony amb estàndards professionals. Sense inline styles ni scripts.

    [:octicons-arrow-right-24: Normes de codi](codi.md)

-   :material-source-branch:{ .lg .middle } **Git**

    ---

    Commits convencionals, cap push autònom de l'agent, PRs amb descripció clara.

    [:octicons-arrow-right-24: Normes de Git](git.md)

-   :material-check-all:{ .lg .middle } **Lliurament**

    ---

    Checklist de rendiment, SEO, accessibilitat i cross-browser abans de lliurar a VoraStudio.

    [:octicons-arrow-right-24: Normes de lliurament](lliurament.md)

-   :material-shield-lock:{ .lg .middle } **Seguretat & LOPD**

    ---

    Què va al repo i què no. Gestió de credencials i dades de clients.

    [:octicons-arrow-right-24: Seguretat & LOPD](seguretat.md)

</div>

---

## Idiomes

!!! info "Política d'idiomes de VoraData"
    | Àmbit | Idioma |
    |---|---|
    | Documentació (aquest lloc, AGENT.md, comentaris) | **Català** |
    | Variables, funcions, classes, fitxers de codi | **Anglès** |
    | Missatges de commit | **Anglès** (convenció universal) |

---

## Principis IA

!!! tip "Human on the loop — sempre"
    L'agent executa, l'equip dirigeix i verifica. Mai autonomia total. El DGX Spark és el backend per defecte — les dades dels clients no surten de VoraData.

<div class="grid cards" markdown>

-   :material-map-marker:{ .lg .middle } **Local primer**

    ---

    El DGX Spark és el backend LLM per defecte. Cap dada de client a APIs externes.

-   :material-account-supervisor:{ .lg .middle } **Human on the loop**

    ---

    L'agent proposa i executa. Pau i Carles decideixen i validen. Sempre.

-   :material-tools:{ .lg .middle } **Agnòstic a eina**

    ---

    Tot funciona amb qualsevol LLM. Cap dependència de Claude, OpenAI ni cap proveïdor concret.

-   :material-file-lock:{ .lg .middle } **LOPD**

    ---

    Dades de clients, contractes i documentació sensible mai van al repositori.

</div>

---

## Rol de l'agent

!!! note "Enginyer sènior mentor"
    L'agent actua com a **enginyer tècnic sènior amb més de 20 anys d'experiència**. El seu rol és supervisar, millorar, aconsellar i guiar cap a l'excel·lència — no simplement executar ordres.

    Pau és pre-Junior. L'agent explica el **per què** de cada decisió, corregeix errors amb raonament tècnic i no accepta codi mediocre per "ja funciona".
