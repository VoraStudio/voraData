# Seguretat & LOPD

> Què va al repositori i què no. Gestió de credencials i dades de clients.

---

!!! danger "Regla absoluta"
    Les dades de clients **mai** surten de VoraData. Cap API externa, cap repositori públic, cap eina cloud que no haguem aprovat explícitament.

---

## Què va al repo

<div class="grid cards" markdown>

-   :material-check-circle:{ .lg .middle } **Sí al repo**

    ---

    - Codi font
    - Documentació tècnica
    - Configuracions no sensibles (`opencode.json` sense credencials)
    - Fitxers de disseny (si no contenen dades de clients)
    - `AGENT.md`, presets, normes

-   :material-close-circle:{ .lg .middle } **Mai al repo**

    ---

    - `.env` amb credencials o API keys
    - Dades de clients (noms, emails, contractes)
    - Brand assets de clients (imatges, logos, PDFs)
    - Documentació interna sensible (pressupostos, acords)
    - Claus SSH o certificats

</div>

---

## Gestió de credencials

Totes les credencials van a fitxers `.env`:

```bash
# .env — mai al repo
AI_BASE_URL="http://voradata-ia.hopto.org:30000"
AI_API_KEY="la-clau-aqui"
AI_MODEL="qwen38-27b"
```

El `.gitignore` inclou `.env` per defecte. **Verifica sempre abans de fer commit.**

!!! tip "Consell sènior"
    Si mai has pujat una credencial al repo per error, no n'hi ha prou amb fer un commit que la tregui — la credencial queda a l'historial. Caldrà revocar-la immediatament i fer un `git filter-branch` o usar `git filter-repo` per netejar l'historial.

---

## LOPD — dades de clients

VoraData treballa amb empreses que gestionen dades personals. Les obligacions bàsiques:

- Cap dada personal de clients finals al codi font ni als tests
- Si cal fer proves amb dades, usar dades fictícies (`faker`)
- Els backups de bases de dades mai al repo
- Els formularis de contacte han de tenir una política de privacitat linkada

!!! warning "Base de dades de proves"
    Mai usar un dump de producció per a desenvolupament. Crea un fixture amb dades fictícies. Les dades reals d'usuaris en un entorn de dev és una infracció de la LOPD.

---

## DGX Spark — perquè local

El DGX Spark és la resposta tècnica a la LOPD:

- Les converses amb el LLM no surten de la xarxa de VoraData
- Cap proveïdor extern (OpenAI, Anthropic, etc.) processa dades de clients
- El model `qwen38-27b` corre localment via SGLang

!!! info "Quan usar un LLM extern"
    Si per alguna raó cal usar un LLM extern (Claude, GPT, etc.), **mai** incloure dades de clients al prompt. Usar sempre dades anonimitzades o fictícies.
