<script lang="ts">
  import Controls from './lib/Controls.svelte';
  import DrawTree from './lib/DrawTree.svelte';
  import { adjacent, names } from './lib/service';

  const ins = [
    [1],
    [2],
    [3, 4, 5],
    [6],
    [7],
    [8],
    [9, 10, 11],
    [],
    [12, 13],
    [],
    [],
    [],
    [],
    [],
  ];
  // const ins = [
  //   [],
  //   [4, 5],
  //   [],
  //   [6, 7],
  //   [],
  //   [8],
  //   [],
  //   [9, 10, 11, 12, 0],
  //   [],
  //   [],
  //   [],
  //   [],
  //   [],
  //   [1, 2, 3],
  // ];
  const namesStr = Array(ins.length)
    .fill(0)
    .map((_, i) => i.toString());

  adjacent.set(ins);
  names.set(namesStr);
  let svgEl: SVGSVGElement;
</script>

<header class="navbar bg-body-tertiary shadow-sm">
  <div class="container-fluid"><span class="navbar-brand">Tree SVG</span></div>
</header>

<main class="container my-5">
  <section>
    <h1>Draw Tree with SVG</h1>
    <div class="m-auto" style="width: fit-content;">
      <DrawTree bind:self={svgEl} />
    </div>
  </section>
  <section>
    <h1>Edit the Tree</h1>
    <Controls bind:svgEl />
  </section>
</main>

<section class="container my-5"><h1>Description</h1></section>

<footer class="navbar bg-primary-subtle mt-5">
  <nav>
    <ul class="nav">
      <li class="navi-item"><a href="#" class="nav-link">this repo</a></li>
    </ul>
  </nav>
</footer>
