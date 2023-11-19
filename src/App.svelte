<script lang="ts">
  import Controls from './lib/Controls.svelte';
  import Description from './lib/Description.svelte';
  import DrawTree from './lib/DrawTree.svelte';
  import { idCntr } from './lib/service';

  const formId = idCntr.get();
  const headingId = idCntr.get();

  let svgEl: SVGSVGElement;
</script>

<header class="navbar bg-body-tertiary shadow-sm">
  <div class="container-fluid">
    <span class="navbar-brand" id={headingId}>Tree SVG</span>
  </div>
</header>

<main class="container my-5">
  <section>
    <h1>Draw Tree with SVG</h1>
    <div class="m-auto" style="width: fit-content;">
      <output form={formId}>
        <DrawTree bind:self={svgEl} labelledBy={headingId} />
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
