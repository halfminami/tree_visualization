## Memo

### Foreign Language in Browser

This uses Ocaml code in calculating positions of vertices and edges.
Generally, writing tree operations in ML languages is more straightforward than in JavaScript.

There are some ways to write foreign language and run it in a web browser.
These ways include compiling to JavaScript and WebAssembly, as far as I know.

This is helpful when you want to use libraries that are not written in JavaScript.
Additionally, it is faster in some scenarios, as I have heard.

While configuring and converting types may pose some challenges,
using a language other than JavaScript within a browser is enjoyable and surprising!

### Tree Traversal Implementation

To find the centered positions of tree nodes, the algorithm (ocaml code) follows these steps:

1. Left Alignment (DFS):
- Utilized Depth-First Search (DFS) with return values to position nodes to the left. This takes into account the width of other nodes during this left alignment.
1. Center Alignment (BFS with Stack):
- After left alignment, the algorithm centers the nodes from the bottom left by referencing the positions of their children.
  - Implements a stack and pushes nodes in a right-to-left order using Breadth-First Search (BFS).
