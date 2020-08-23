#!/bin/bash -x

echo "*************************Welcome to TICTACTOE WORLD****************************"

declare -a boardOfTicTacToe

PLAYER="X"
COMPUTER="O"

winCount1=0;
winCount=false;

function resetTheBoard()
{
 count=1;
 for (( i=1; i<=9; i++ ))
 do
   boardOfTicTacToe["$i"]="-";
   count=$(($count+1))
 done
 displayBoard
}

#echo ${boardOfTicTacToe[@]}

function whoPlayFirst()
{
 resultOfToss=$((RANDOM%2))
 if [ $resultOfToss -eq 0 ]
 then
     echo "Player play First....."
     playerCount=1;
     resetTheBoard
     play
 else
     echo "Computer play First..."
      computerCount=0;
 fi
}

function play()
{
 #local turn=1;
 while [ $winCount == false ]
 do
   read -p "Enter the Position to Insert the "X" : " position
   boardOfTicTacToe["$position"]="X"
   displayBoard
   winInRows $winCount
   winInColumns $winCount
   winInDiagonals $winCount
 done
}

function winInRows()
{
   local count=1;
   for (( i=1; i<=3; i++ ))
   do
     if [[ $computerCount -eq 1 ]] || [[ $playerCount -eq 1 ]] 
     then
         if [[ ${boardOfTicTacToe[$count]} == ${boardOfTicTacToe[$count+1]} ]] && [[ ${boardOfTicTacToe[$count+1]} == ${boardOfTicTacToe[$count+2]} ]] && [[ ${boardOfTicTacToe[$count+2]} == $PLAYER ]]
         then
             winCount=true;
             echo You Win
             break;
         else
            count=$((count+3))
         fi
     fi
   done
}
function winInColumns()
{
 for (( i=1; i<=3; i++ ))
 do
   if [[ ${boardOfTicTacToe["$i"]} == ${boardOfTicTacToe["$i+3"]} ]] && [[ ${boardOfTicTacToe["$i"]} == ${boardOfTicTacToe["$i+6"]} ]] && [[ ${boardOfTicTacToe["$i"]} == $PLAYER ]]
   then
       winCount=true
       echo You Win
       break;
   fi
 done
}
function winInDiagonals()
{
 count=1;

   if [[ ${boardOfTicTacToe["$count"]} == ${boardOfTicTacToe["$count+4"]} ]] && [[ ${boardOfTicTacToe["$count+4"]} == ${boardOfTicTacToe["$count+8"]} ]] && [[ ${boardOfTicTacToe["$count"]} == $PLAYER ]]
   then
       winCount=true;
       echo You Win
   elif [[ ${boardOfTicTacToe["$count+2"]} == ${boardOfTicTacToe["$count+4"]} ]] && [[ ${boardOfTicTacToe["$count+2"]} == ${boardOfTicTacToe["$count+6"]} ]] && [[ ${boardOfTicTacToe["$count+6"]} == $PLAYER ]]
   then
       winCount=true;
       echo You Win
   fi
}
function displayBoard()
{
   echo "    |---|---|---|"
   echo "    | "${boardOfTicTacToe[1]}" | "${boardOfTicTacToe[2]}" | "${boardOfTicTacToe[3]}" |"
   echo "    |---|---|---|"
   echo "    | "${boardOfTicTacToe[4]}" | "${boardOfTicTacToe[5]}" | "${boardOfTicTacToe[6]}" |"
   echo "    |---|---|---|"
   echo "    | "${boardOfTicTacToe[7]}" | "${boardOfTicTacToe[8]}" | "${boardOfTicTacToe[9]}" |"
   echo "    |---|---|---|"

}

whoPlayFirst

