function setup() {
  var canvasDiv = document.getElementById('myCanvas');
  var width = canvasDiv.offsetWidth;
  var sketchCanvas = createCanvas(width/3, 500);
  sketchCanvas.parent("myCanvas");
}

let x = 50;
let y = 0;

function draw() {
  background(220);
  ellipse(x, 50, 80, 80);
  fill(y);
  x++;
  y++;
}