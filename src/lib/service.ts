import { writable } from 'svelte/store';

export const rectWidth = writable(80);
export const rectHeight = writable(80);
export const circleR = writable(30);
export const textWidth = writable(30);
export const names = writable<string[]>([]);
export const adjacent = writable<number[][]>([]);

class IdCntr {
  #id;
  constructor(n: number) {
    this.#id = n;
  }
  get() {
    const ret = `id-${this.#id}`;
    this.#id++;
    return ret;
  }
}

export const idCntr = new IdCntr(0);
