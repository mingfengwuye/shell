#!/bin/bash


#脚本实现，遍历当前目录下子文件夹。
#子文件夹内包含三个文件，onchip,data_for_ddr和output_param
#读取output_param文件的addr和size参数
#output_param文件内容格式如下
# output addr（unsigned int）: 6
# output size ：2016

#四个参数读取完成后，传递给run_net.sh进行执行

nets_addr="models/mlp"
    for dir in `ls` 
    do
        if [ -d $dir ]
        then
            cd $dir
            for file in `ls`
            do
                if [ $file == onchip* ];then
                    onchip_temp=$file
                    echo $onchip_temp
                elif [ $file == data_for_ddr ];then
                    data_for_ddr_temp=$file
                    echo $data_for_ddr_temp
                elif [ $file == output_param ];then
                    addr_temp=(`cat ./$file | grep addr | awk -F : '{print $2}'`)
                    size_temp=(`cat ./$file | grep size | awk -F : '{print $2}'`)
                    echo $addr_temp
                    echo $size_temp
                fi          
            done
            cd ../../..
            ./run_nets.sh $nets_addr/$dir/$onchip_temp $2 $3 $4
            diff -u myout* data_for_ddr_result > compare_result.txt
            compare_diff=(`cat compare_result.txt`)
            if [ ! $compare_diff ];then
                echo "$nets_addr/$dir  Same" >> ../net_result.txt
            else
                echo "$nets_addr/$dir  Diff" >> ../net_result.txt
            fi                
            cd $nets_addr
    #       cd - 
        fi
    done 

#for file in $(ls *)
#do
#    if [ $file == onchip* ];then
#        onchip_temp=$file
#    elif [ $file == data_for_ddr ];then
#        data_for_ddr_temp=$file;
#    elif [ $file == output_param ];then
#        addr_temp=(`cat $file | grep addr | awk -F : '{print $2}'`)
#        size_temp=(`cat $file | grep size | awk -F : '{print $2}'`)
#    fi    
#done
#
#echo "$(date)" >> nansong_run_nets.sh

#
##echo ./run_nets.sh $(pwd)/$onchip_temp $(pwd)/$data_for_ddr_temp $addr_temp $size_temp >> nansong_run_nets.sh
#
#
