# Visualize Tree

Draws undirected tree into SVG.

## Uses

- Js_of_ocaml, which compiles Ocaml to JavaScript.
*(There's no need to use [JavaScript compiler over native JavaScript in this site](./memo.md#foreign-language-in-browser). This is for my interest only!)*
- Vite with Svelte *(I'm a newbie!)*

## Build

Needs Ocaml, opam and dune to build, other than node and npm.

<!-- git clone -->

#### Install opam dependencies
```bash
# on ./ocaml
opam install ./ --deps-only
```

#### Run Vite Dev Server
```bash
# on root
npm install
npm run build:ocaml
npm run dev
```
