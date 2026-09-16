# Normes de Git

> Com versionem el codi a VoraData. Regles clares per a un historial net i professional.

---

!!! danger "Regla fonamental"
    **L'agent mai fa `git commit` ni `git push` de forma autònoma.** Només quan Pau o Carles ho indiquin explícitament amb branca i acció (ex: "fes push a main", "commiteja això").

---

## Commits convencionals

Tots els commits segueixen el format `tipus: descripció` en anglès:

| Tipus | Quan usar-lo |
|---|---|
| `feat:` | Nova funcionalitat |
| `fix:` | Correcció d'error |
| `style:` | Canvis visuals, CSS, format |
| `docs:` | Documentació |
| `chore:` | Manteniment, dependències |
| `refactor:` | Reestructuració sense canvi de comportament |

!!! tip "Exemples de bons commits"
    ```
    feat: add sticky navbar with scroll detection
    fix: correct hero image aspect ratio on mobile
    style: update brand colors to match VoraData palette
    docs: add landing workflow to SDD section
    chore: update mkdocs-material to 9.5.39
    ```

!!! warning "Mai fer això"
    ```
    git commit -m "canvis"
    git commit -m "wip"
    git commit -m "arreglat"
    git commit -m "Co-Authored-By: Claude"
    ```

---

## Branques

<div class="grid cards" markdown>

-   :material-source-branch:{ .lg .middle } **`main`**

    ---

    Branca de producció. Sempre estable. Només s'hi mergeja feina revisada i provada.

    **Mai commits de treball en curs a `main`.**

-   :material-source-branch:{ .lg .middle } **Feature branches**

    ---

    Per a cada nova funcionalitat o landing:

    ```
    feat/landing-nomclient
    fix/navbar-mobile
    docs/sdd-landing-workflow
    ```

</div>

---

## Pull Requests

Tota PR ha d'incloure:

- **Títol**: curt i descriptiu (màx. 70 caràcters)
- **Descripció**: què canvia, per què, com verificar
- **Sense atribució a IA** als commits ni a la descripció

!!! tip "Consell sènior"
    Una bona PR és la que el teu company pot revisar en 10 minuts sense preguntar-te res. Si la descripció necessita una reunió per explicar-la, la PR és massa gran o massa opaca.

---

## `.gitignore` — mai al repo

```
.env
*.env.*
/vendor/
/node_modules/
/site/
```

!!! danger "Verificar sempre"
    Abans de cada commit, comprova que no hi ha `.env` ni fitxers amb credencials staged. Un error aquí exposa credencials públicament i és irreversible.
