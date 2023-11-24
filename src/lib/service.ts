import { writable } from 'svelte/store';

export const rectWidth = writable(80);
export const rectHeight = writable(80);
export const circleR = writable(30);
export const textWidth = writable(30);
export const names = writable<string[]>(['0', '1']);
export const adjacent = writable<number[][]>([[1], []]);

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

export const descTextWidth = writable('');
export const descCircleR = writable('');
export const descRectWidth = writable('');
export const descRectHeight = writable('');
export const descAdjacent = writable('');
export const descNames = writable('');
export const descDownload = writable('');
export const descEdges = writable('');
export const descSvg = writable('');
export const descResize = writable('');
export const descQuestion = writable('');
