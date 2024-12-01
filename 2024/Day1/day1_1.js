function calculateDistance(left, right) {
    left.sort((a, b) => a - b);
    right.sort((a, b) => a - b);
    console.log(left, right);
    let totalDistance = 0;
    for (let i = 0; i < left.length; i++) {
        totalDistance += Math.abs(left[i] - right[i]);
    }

    return totalDistance;
}

const fs = require('fs');
const input = fs.readFileSync('input', 'utf8').split('\n');
let left = [];
let right = [];
for (let i = 0; i < input.length; i++) {
    let [l, r] = input[i].split('  ');
    left.push(parseInt(l));
    right.push(parseInt(r));
}
console.log(left, right);
output = calculateDistance(left, right);
console.log(output);