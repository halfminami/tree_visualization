<script lang="ts">
  import Controls from './lib/Controls.svelte';
  import Description from './lib/Description.svelte';
  import DrawTree from './lib/DrawTree.svelte';
  import { adjacent, names, idCntr } from './lib/service';

  const formId = idCntr.get();

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
      <output form={formId}>
        <DrawTree bind:self={svgEl} />
      </output>
    </div>
  </section>
  <section>
    <h1>Edit the Tree</h1>
    <form id={formId}>
      <Controls bind:svgEl />
    </form>
  </section>
</main>

<section class="container my-5">
  <h1>Description</h1>
  <Description />
</section>

<footer class="navbar bg-primary-subtle mt-5">
  <nav>
    <ul class="nav">
      <li class="navi-item">
        <a
          href="https://github.com/halfminami/tree_visualization"
          class="nav-link">this repo</a
        >
      </li>
    </ul>
  </nav>
</footer>
