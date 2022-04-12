function getAngle(pos){

    let x_nose = pos[33][0]; let y_nose = pos[33][1];

    let x_left = pos[0][0]; let y_left = pos[0][1];
    let x_right = pos[16][0]; let y_right = pos[16][1];

    let x_reye = pos[45][0]; let y_reye = pos[45][1];
    let x_leye = pos[36][0]; let y_leye = pos[36][1];

    let x_rmouse = pos[54][0]; let y_rmouse = pos[54][1];
    let x_lmouse = pos[48][0]; let y_lmouse = pos[48][1];


    let x_mid_eye = (x_reye + x_leye) / 2;
    let y_mid_eye = (y_reye + y_leye) / 2;

    let x_mid_mouse = (x_rmouse + x_lmouse) / 2;
    let y_mid_mouse = (y_rmouse + y_lmouse) / 2;

    let x_eye_mouse_mid = (x_mid_eye + x_mid_mouse) / 2;
    let y_eye_mouse_mid = (y_mid_eye + y_mid_mouse) / 2;

    let mid_eye_mouse_dist = Math.sqrt((x_mid_mouse - x_eye_mouse_mid) ** 2 + (y_mid_mouse - y_eye_mouse_mid) ** 2);

    let eye_mouse_dist = Math.sqrt((x_mid_eye - x_mid_mouse) ** 2 + (y_mid_eye - y_mid_mouse) ** 2);
    let nose_mouse_dist = Math.sqrt((x_eye_mouse_mid - x_nose) ** 2 + (y_eye_mouse_mid - y_nose) ** 2);

    let nose_mouse_difference = eye_mouse_dist - nose_mouse_dist;

    let nose_mouse = Math.min(nose_mouse_difference, nose_mouse_dist);
    let nose_difference = mid_eye_mouse_dist - nose_mouse;

    let angle_yaxis = (nose_mouse / mid_eye_mouse_dist) * 90;

    let lenght1 = Math.sqrt((x_left - x_nose) ** 2 + (y_left - y_nose) ** 2);
    let length2 = Math.sqrt((x_left - x_right) ** 2 + (y_left - y_right) ** 2);
    let lenght3 = Math.sqrt((x_right - x_nose) ** 2 + (y_right - y_nose) ** 2);

    let k = (y_right - y_left) / (x_right - x_left);
    let b = (y_right - k * x_right);

    let dist_y = Math.abs(k * x_nose - y_nose + b) / Math.sqrt(k ** 2 + 1);
    if (dist_y <= length1){
        let angle1 = Math.asin(dist_y / lenght1) * 180 / Math.PI;
    }else{
        let angle1 = Math.asin(1) * 180 / Math.PI;
    }
    if (dist_y <= length3){
        let angle2 = Math.asin(dist_y / lenght3) * 180 / Math.PI;
    }else {
        let angle2 = Math.asin(1) * 180 / Math.PI;
    }

    let dist_a = Math.atan(angle1 * Math.PI / 180) * dist_y
    let dist_b = length2 - dist_a
    return Math.min(angle1, angle2)
}