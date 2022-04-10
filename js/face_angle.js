let x_nose = 5; let y_nose = 1;
let x_left = 2; let y_left = 2;
let x_right = 0; let y_right = 0;

let lenght1 = Math.sqrt((x_left - x_nose) ** 2 + (y_left - y_nose) ** 2);
let length2 = Math.sqrt((x_left - x_right) ** 2 + (y_left - y_right) ** 2);
let lenght3 = Math.sqrt((x_right - x_nose) ** 2 + (y_right - y_nose) ** 2);

let k = (y_right - y_left) / (x_right - x_left);
let b = (y_right - k * x_right);

let dist_y = Math.abs(k * x_nose - y_nose + b) / Math.sqrt(k ** 2 + 1);
let angle1 = Math.asin(dist_y / lenght1) * 180 / Math.PI;
let angle2 = Math.asin(dist_y / lenght3) * 180 / Math.PI;

let dist_a = Math.atan(angle1 * Math.PI / 180) * dist_y
let dist_b = length2 - dist_a

 