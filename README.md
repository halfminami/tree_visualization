# Visualize Tree

Draws undirected tree into SVG.

## Uses

- Js_of_ocaml, which compiles Ocaml to JavaScript.
*(There's no need to use [JavaScript compiler over native JavaScript in this site](./memo.md#foreign-language-in-browser). This is for my interest only!)*
- Svelte with Vite *(I'm a newbie!)*
- Bootstrap (CDN)

## Install
#### Clone
```bash
git clone https://github.com/halfminami/tree_visualization.git
cd tree_visualization
```

#### Run Vite Dev Server
```bash
# on ./ (root)
npm install
npm run dev
```

## Build JavaScript

Needs Ocaml, opam and dune to build, other than node and npm.
(Though there's a compiled JavaScript file `mainjs.bc.js` included so no need to run build)

#### Install opam dependencies
```bash
# on ./ocaml
opam install ./ --deps-only
```
#### Compile ocaml code
```bash
# on ./ (root)
npm run build:ocaml
```
