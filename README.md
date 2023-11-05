# Visualize Tree

Draws undirected tree into SVG.

## Uses

- Js_of_ocaml, which compiles Ocaml to JavaScript.
*(There's no need to use JavaScript compiler over native JavaScript in this site. This is for my interest only!)*
- Vite with Svelte *(I'm newbie!)*

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

## Memo

This uses Ocaml code in calculating positions of vertices and edges.
Generally, writing tree operations in ML languages is more straightforward than in JavaScript.

There are some ways to write foreign language and run it in a web browser.
These ways include compiling to JavaScript and WebAssembly, as far as I know.

This is helpful when you want to use libraries that are not written in JavaScript.
Additionally, it is faster in some scenarios, as I have heard.

While configuring and converting types may pose some challenges,
using a language other than JavaScript within a browser is enjoyable and surprising!
