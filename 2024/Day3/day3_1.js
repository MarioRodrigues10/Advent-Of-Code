sum_all = 0;
function regexMatch(str) {
    
    const regex2 = /mul\(\s*(\d+)\s*,\s*(\d+)\s*\)/g; 
    const matches = str.matchAll(regex2);
    for (const match of matches) {
        sum_all += parseInt(match[1]) * parseInt(match[2]);
    }
}



const fs = require('fs');
const input = fs.readFileSync('input1', 'utf8').split('\n');
console.log(input);
for(let i = 0; i < input.length; i++){
    regexMatch(input[i]);
}

console.log(sum_all);