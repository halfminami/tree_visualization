<script lang="ts">
  export let id: string;
  export let text = '?';
  export let className = '';
</script>

<a href="#{id}" class="link-secondary link-underline-opacity-25 {className}"
  >{text}</a
>
