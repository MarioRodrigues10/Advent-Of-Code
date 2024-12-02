function decreasing12(lists){
    count = 0;
    for(let i = 0; i < lists.length; i++){
        flag = 0, flag_incr = 0, flag_decr = 0;
        for (let j = 0; j < (lists[i].length)-1; j++){
            val1 = parseInt(lists[i][j]), val2 = parseInt(lists[i][j+1]);
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
            count++;
        }
        else if (flag == 1){
            value = anyFix(lists[i]);
            value? count++ : count;
        }
    }
    return count;
}

function anyFix(list){
    for(let i=0; i<list.length; i++){
        flag = 0, flag_incr = 0, flag_decr = 0;
        let copy = list.slice(); 
        copy.splice(i, 1); 
        for(let j=0; j<copy.length; j++){
            val1 = parseInt(copy[j]);
            val2 = parseInt(copy[j+1]);
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
            return true;
        }
    }
    return false;
}

const fs = require('fs');
const input = fs.readFileSync('input1', 'utf8').split('\n');
let list = [[]];
let count = 0;
for (let i = 0; i < input.length; i++) {
    let l = input[i].split(' ');
    list[count] = l;
    count++
}
output = decreasing12(list);
console.log(output);