ɾ��ƥ���е�ǰ���У�����ƥ����
arr=(`grep xxx -n ./file | tac`)

for v in ${arr[@]}; do

����echo $v;

    let begin=$v-2
    let end=$v+3
    sed -i "$begin","$end"d file��������
done