# 001 — Tailwind v4 amb mobile-first obligatori

**Stack**: css
**Estat**: acceptat
**Data**: 2026-09-16

## Context

Calia definir la versió de Tailwind i la convenció d'ordre de breakpoints per evitar inconsistències entre landings i aplicacions Symfony.

## Decisió

- Tailwind **v4** (no v3) — variables de disseny a `@theme {}` en lloc de `tailwind.config.js`
- Estils **mobile-first** sempre: classes base per a mòbil, breakpoints (`md:`, `lg:`) per ampliar
- CSS custom **únicament** per al que Tailwind no cobreix (animacions complexes, gradients de text, glassmorphism)
- Mai `<style>` inline ni atribut `style=""` a l'HTML

## Conseqüències

- Consistència entre tots els projectes de VoraData
- Tailwind v4 és incompatible amb v3 en la configuració — no barrejar
- El CSS custom és deute tècnic: documentar sempre per què s'ha afegit
