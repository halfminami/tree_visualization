<script lang="ts">
  import DescLink from './DescLink.svelte';

  export let id: string;
  export let lab: string;
  export let value: number;
  export let min = 0;
  export let max = 100;
  export let step = 5;
  export let className = '';
  export let unit = 'px';
  export let desc = '';
</script>

<label for={id} class="form-label {className}"
  >{lab} <output for={id}>{value}{unit}</output>
  <DescLink id={desc} /></label
>
<input
  type="range"
  class="form-range {className}"
  {id}
  bind:value
  {min}
  {max}
  {step}
/>
