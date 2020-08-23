#!/bin/bash -x

echo "*************************Welcome to TICTACTOE WORLD****************************"

declare -a boardOfTicTacToe

function resetTheBoard()
{
 for (( i=1; i<=9; i++ ))
 do
   boardOfTicTacToe["$i"]="-";
 done
}

resetTheBoard

echo ${boardOfTicTacToe[@]}
