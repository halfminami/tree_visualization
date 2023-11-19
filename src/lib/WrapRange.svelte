<script lang="ts">
  import type { Writable } from 'svelte/store';
  export let id: string;
  export let lab: string;
  export let value: number;
  export let min = 0;
  export let max = 100;
  export let step = 5;
  export let className = '';
  export let unit = 'px';
</script>

<label for={id} class="form-label"
  >{lab} <output for={id}>{value}{unit}</output></label
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
