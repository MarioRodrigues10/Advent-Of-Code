
function decreasing12(lists){
    count = 0;
    for(let i = 0; i < lists.length; i++){
        flag = 0, flag_incr = 0, flag_decr = 0;
        for (let j = 0; j < (lists[i].length)-1; j++){
            val1 = parseInt(lists[i][j]);
            val2 = parseInt(lists[i][j+1]);
            val_abs = val2 - val1;
            if(j == 0){
                if(val_abs > 0) flag_incr = 1;
                if(val_abs < 0) flag_decr = 1;
            }
            if((Math.abs(val_abs) > 3 || val_abs==0) || (val_abs < 0 && flag_incr == 1) || (val_abs > 0 && flag_decr == 1)) {
                flag = 1;
            }
        }
        if(flag == 0){   
            console.log(lists[i]);
            count++;
        }
    }
    return count;
}

const fs = require('fs');
const input = fs.readFileSync('input1', 'utf8').split('\n');
let list = [[]];
let count = 0;
for (let i = 0; i < input.length; i++) {
    let l = input[i].split(' ');
    console.log(l)
    list[count] = l;
    count++
}
console.log(list);
output = decreasing12(list);
console.log(output);