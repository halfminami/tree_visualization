<script lang="ts">
  import {
    descSvg,
    descTextWidth,
    descResize,
    descQuestion,
    idCntr,
    descCircleR,
    descRectWidth,
    descRectHeight,
    descAdjacent,
    descNames,
    descDownload,
    descEdges,
  } from './service';

  // if not sure whether a description for a control is present
  // check if descId is set when placing the control
  $descQuestion = idCntr.get();
  $descSvg = idCntr.get();
  $descResize = idCntr.get();
  $descTextWidth = idCntr.get();
  $descCircleR = idCntr.get();
  $descRectWidth = idCntr.get();
  $descRectHeight = idCntr.get();
  $descAdjacent = idCntr.get();
  $descNames = idCntr.get();
  $descDownload = idCntr.get();
  $descEdges = idCntr.get();
</script>

<h1 id={$descQuestion} tabindex="-1">Description</h1>
<p>Draws undirected tree into a downloadable svg file.</p>
<!-- controls desc -->

<h2 id={$descSvg} tabindex="-1">SVG View</h2>
<p>Generates SVG representing a tree graph.</p>
<dl>
  <dt>Outer Border (solid)</dt>
  <dd>Defines the boundary for displaying the SVG.</dd>
  <dt>Inner Border (dotted)</dt>
  <dd>Indicates the size of the SVG.</dd>
  <dt>Bottom Box Area (gray)</dt>
  <dd id={$descResize} tabindex="-1">Adjusts the height of the SVG View.</dd>
</dl>

<h2 id={$descEdges} tabindex="-1">Edge Input</h2>
<p>Enter edges represented by pairs of node names.</p>
<dl>
  <dt>Pairs of Edges</dt>
  <dd>
    Enter one pair per line, with names separated by a space. Ensure there is at
    least one space per line. Note that only a single tree is supported; the
    tool does not work with graphs containing multiple components or loops.
  </dd>
  <dt>Top Node of a Tree</dt>
  <dd>
    Specifies the node to position at the top. This node must be present in the
    edge names.
  </dd>
</dl>

<h2>Nodes' Settings in Detail</h2>
<p>
  Configure the adjacency list and nodes' names separately. The settings are
  folded in the accordion.
</p>
<dl>
  <dt id={$descAdjacent} tabindex="-1">Adjacent Nodes</dt>
  <dd>
    Define nodes on each line, starting from index 0. Each node is represented
    by its line index. Multiple nodes on the same line are separated by a space.
    Ensure there are one or more empty lines to represent tree leaves.
  </dd>
  <dt id={$descNames} tabindex="-1">Nodes' Names</dt>
  <dd>
    Names are assigned based on the corresponding index in the adjacency list.
    To try renaming, click the convert button first to get an adjacency list
    representation of an example input. Then deleting all names will display a
    tree without labels. Note that longer names may overflow easily.
  </dd>
</dl>

<h2>Other Settings</h2>
<p>
  Customize some aspects of the tree's appearance. The settings are folded in
  the accordion.
</p>
<dl>
  <dt id={$descTextWidth} tabindex="-1">Text Width</dt>
  <dd>Adjust the width of the node name text.</dd>
  <dt id={$descCircleR} tabindex="-1">Circle Radius</dt>
  <dd>
    Modify the circle radius of the nodes. Note that this does not affect the
    spacing between nodes.
  </dd>
  <dt id={$descRectWidth} tabindex="-1">Rect Width</dt>
  <dd>
    Alter the horizontal spacing between nodes. Nodes' circles are positioned at
    the center of the rectangle.
  </dd>
  <dt id={$descRectHeight} tabindex="-1">Rect Height</dt>
  <dd>
    Adjust the vertical spacing between nodes. Nodes' circles are centered
    within the rectangle.
  </dd>
</dl>

<h2 id={$descDownload} tabindex="-1">Download SVG</h2>
<p>
  Download an SVG file of the tree. Some visual aspects are defined in the
  <code>&lt;style&gt;</code>, allowing you to make further adjustments if
  needed.
</p>

<style>
  p,
  dl {
    margin-left: 0.6em;
  }
  *:focus {
    background-color: ghostwhite;
  }
</style>
