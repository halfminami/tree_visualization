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
    adjacentNodes[left].push(right);
    adjacentNodes[right].push(left);
  });

  const idx = namesToIndx.get(head);
  if (adjacentNodes.length != namesToIndx.size || idx == undefined) {
    // not a tree
    return { names: ['0'], adjacent: [[]] };
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
