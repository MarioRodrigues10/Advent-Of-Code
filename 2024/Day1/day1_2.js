function count(list, value) {
    let count = 0;
    
    for (let i = 0; i < list.length; i++) {
        if (list[i] === value) {
            count++;
        }
    }
    
    return count;
}

function multiply(list1, list2) {
    let result = 0;
    
    for (let i = 0; i < list1.length; i++) {
        result += list1[i] * count(list2, list1[i]);
    }

    return result;
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
output = multiply(left, right);
console.log(output);