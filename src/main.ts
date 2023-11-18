import './app.css';
import App from './App.svelte';

declare global {
  var treeGrid: {
    main: () => (_: number[][]) => {
      vertices: [number, number][];
      edges: [number, number][];
    };
  };
}

const app = new App({
  target: document.getElementById('app')!,
});

export default app;
