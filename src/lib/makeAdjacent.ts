export function makeAdjacent(
  arr: [string, string][],
  head: string
): {
  names: string[];
  adjacent: number[][];
} {
  const namesToIndx = new Map<string, number>();
  const adjacentNodes: number[][] = Array(arr.length + 1)
    .fill(0)
    .map((_) => []);

  // parse lines
  arr.forEach((item) => {
    let left = namesToIndx.get(item[0]),
      right = namesToIndx.get(item[1]);
    if (left == undefined) {
      namesToIndx.set(item[0], namesToIndx.size);
      left = namesToIndx.get(item[0])!;
    }
    if (right == undefined) {
      namesToIndx.set(item[1], namesToIndx.size);
      right = namesToIndx.get(item[1])!;
    }
    if (adjacentNodes[left] && adjacentNodes[right]) {
      adjacentNodes[left].push(right);
      adjacentNodes[right].push(left);
    } else {
      throw new Error('The tree may not be connected or looped');
    }
  });

  const idx = namesToIndx.get(head);
  if (adjacentNodes.length > namesToIndx.size) {
    // not a tree
    throw new Error('The tree may not be connected or looped');
  }
  if (adjacentNodes.length < namesToIndx.size) {
    throw new Error('The tree may have a loop');
  }
  if (idx == undefined) {
    throw new Error('Top node must be present');
  }

  // map -> array
  const names: string[] = [];
  for (const item of namesToIndx) {
    names[item[1]] = item[0];
  }

  // make directed graph; traverse from head
  const adjacent: number[][] = Array(arr.length + 1)
    .fill(0)
    .map((_) => []);
  const vsd: boolean[] = Array(arr.length + 1).fill(false);
  const q = [idx];
  while (q.length) {
    const a = q.shift()!;
    vsd[a] = true;
    adjacentNodes[a].forEach((item) => {
      if (!vsd[item]) {
        q.push(item);
        adjacent[a].push(item);
      }
    });
  }

  return { names, adjacent };
}

export const examples: { edges: [string, string][]; head: string }[] = [
  { edges: [['0', '1']], head: '0' },
  {
    edges: [
      ['0', '1'],
      ['1', '2'],
      ['2', '3'],
      ['2', '4'],
      ['2', '5'],
      ['3', '6'],
      ['4', '7'],
      ['5', '8'],
      ['6', '9'],
      ['6', '10'],
      ['6', '11'],
      ['8', '12'],
      ['8', '13'],
    ],
    head: '0',
  },
  {
    edges: [
      ['1', '4'],
      ['1', '5'],
      ['1', '13'],
      ['5', '8'],
      ['13', '2'],
      ['13', '3'],
      ['3', '6'],
      ['3', '7'],
      ['7', '9'],
      ['7', '10'],
      ['7', '11'],
      ['7', '12'],
      ['7', '0'],
    ],
    head: '13',
  },
];
