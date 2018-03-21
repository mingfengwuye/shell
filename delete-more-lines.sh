删除匹配行的前后几行，包括匹配行
arr=(`grep xxx -n ./file | tac`)

for v in ${arr[@]}; do

　　echo $v;

    let begin=$v-2
    let end=$v+3
    sed -i "$begin","$end"d file　　　　
done