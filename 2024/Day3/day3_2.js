sum_all = 0;
function strSplit(input) {
    const regex = /(do\(\)|don\'t\(\)|mul\((\d{1,3}\,\d{1,3})\))/g
    let do_it = true

    input.forEach(line => {
        const matches = [...line.match(regex)]

        matches.forEach(match => {
        if (match === 'do()') {
            do_it = true
        } else if (match === 'don\'t()') {
            do_it = false
        } else if (do_it) {
            const pair = match.slice(4,-1).split(',')
            
            sum_all += parseInt(pair[0]) * parseInt(pair[1])
        }
        });
    })
}




const fs = require('fs');
const input = fs.readFileSync('input1', 'utf8').split('\n');
strSplit(input);
console.log(sum_all);