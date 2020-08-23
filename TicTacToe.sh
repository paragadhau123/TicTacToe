#!/bin/bash -x

echo "*************************Welcome to TICTACTOE WORLD****************************"

declare -a boardOfTicTacToe

PLAYER=0
COMPUTER=0

winCount1=0;
winCount=false;

switchPlayers=0;
playerCount=0;
computerCount=0;

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

function symbolAssignment()
{
 resetTheBoard
 whoPlayFirst $resultOfToss
 if [ $resultOfToss -eq 1 ]
 then
     player=X;
     computer=O;
     checkWhoWins
 else
     player=O;
     computer=X;
     checkWhoWins
 fi
}


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
 if [ $resultOfToss -eq 1 ]
 then
     read -p "Enter the Position Computer Show Your Skills: " position
     if [[ position -le 9 ]] && [[ position -ne 0 ]]
     then
          if  [[ ${boardOfTicTacToe["$position"]} -eq "$player" ]] || [[ ${boardOfTicTacToe["position"]} -eq "$computer" ]]
          then
              echo "Please Select Another Block....Already Occupied!!!!!!!!!!" 
              play $resultOfToss
          else
              boardOfTicTacToe[$position]=$computer
              displayBoard
              resultOfToss=0;
          fi
     fi
 else
    read -p "Enter the Position Player Show Your Skills: " position
    if [[ position -le 9 ]] && [[ position -ne 0 ]]
    then
        if  [[ ${boardOfTicTacToe["$position"]} -eq "$player" ]] || [[ ${boardOfTicTacToe["position"]} -eq "$computer" ]]
        then
            echo "Please Select Another Block....Already Occupied!!!!!!!!!!" 
            play $resultOfToss
        else
            boardOfTicTacToe[$position]=$player
            displayBoard
            resultOfToss=1;
        fi
    fi
 fi
}

function checkWhoWins()
{
 local count=0;
 while [[ $( winInRows $winCount ) == false ]] || [[ $( winInColumns $winCount ) == false ]] || [[ $( winInDiagonals $winCount ) == false ]] 
 do
  count=$(($count + 1 ))
   play
   winInRows $winCount
   winInColumns $winCount
   winInDiagonals $winCount
   if [ $count -ge 9 ]
   then
       echo Match Tie
       break
   fi
 done
}


function winInRows()
{
   local count=1;
   for (( i=1; i<=3; i++ ))
   do
     if [ $resultOfToss -eq 1]
     then
         if  [ "${boardOfTicTacToe[$(($count))]}" = "${boardOfTicTacToe[$(($count+1))]}" ] && [ "${boardOfTicTacToe[$(($count+1))]}" = "${boardOfTicTacToe[$(($count+2))]}" ] && [ "${boardOfTicTacToe[$(($count))]}" = "$player" ]

         then
             winCount=true;
             echo You Win
             break;
         else
            count=$((count+3))
       fi 
     else 
        if  [ "${boardOfTicTacToe[$(($count))]}" = "${boardOfTicTacToe[$(($count+1))]}" ] && [ "${boardOfTicTacToe[$(($count))]}" = "${boardOfTicTacToe[$(($count+2))]}" ] && [ "${boardOfTicTacToe[$(($count))]}" = "$computer" ]
        then 
            winCount=true;
            echo Computer You Win
            break
        else
            count=$((count+3))
        fi

     fi
   done
 echo $winCount
}
function winInColumns()
{
 for (( i=1; i<=3; i++ ))
 do
   if [ $resultOfToss -eq 1 ]
   then
    if [ "${boardOfTicTacToe[$((i))]}" = "${boardOfTicTacToe[$(($i+3))]}" ] && [ "${boardOfTicTacToe[$(($i))]}" = "${boardOfTicTacToe[$(($i+6))]}" ] && [ "${boardOfTicTacToe[$(($i+3))]}" = "$player" ]
       then 
           winCount=true
           echo Player You Win 
           break
       fi
   else
       if [ "${boardOfTicTacToe[$i]}" = "${boardOfTicTacToe[$(($i+3))]}" ] && [ "${boardOfTicTacToe[$i]}" = "${boardOfTicTacToe[$(($i+6))]}" ] && [ "${boardOfTicTacToe[$(($i+3))]}" = "$computer" ]
       then 
           winCount=true
           echo Computer You Win
           break
       fi

   fi
 done
 echo $winCount
}
function winInDiagonals()
{
 local count=1;
   for (( i=1; i<=3; i++ ))
   do
     if [ $resultOfToss -eq 1 ]
     then
         if [ "${boardOfTicTacToe[$count]}" = "${boardOfTicTacToe[$(($count+4))]}" ] && [ "${boardOfTicTacToe[$(($count+4))]}" = "${boardOfTicTacToe[$((count+8))]}" ] && [ "${boardOfTicTacToe[$(($count+8))]}" = "$player" ] 
         then
           winCount=true
           echo Player You Win
           break;
         elif [ "${boardOfTicTacToe[$(($count+2))]}" = "${boardOfTicTacToe[$(($count+4))]}" ] && [ "${boardOfTicTacToe[$(($count+2))]}" = "${boardOfTicTacToe[$(($count+6))]}" ] && [ "${boardOfTicTacToe[$(($count+6))]}" = "$player" ] 
         then
             winCount=true
             echo Player You Win
             break;
         fi
    else
        if [ "${boardOfTicTacToe[$count]}" = "${boardOfTicTacToe[$(($count+4))]}" ] && [ "${boardOfTicTacToe[$(($count+4))]}" = "${boardOfTicTacToe[$(($count+8))]}" ] && [ "$boardOfTicTacToe[$(($count+8))]" = "$computer" ] 
        then
            winCount=true
            echo Computer You Win
            break
        elif [ "${boardOfTicTacToe[$(($count+2))]}" = "${boardOfTicTacToe[$(($count+4))]}" ] && [ "${boardOfTicTacToe[$(($count+2))]}" = "${boardOfTicTacToe[$(($count+6))]}" ] && [ "${boardOfTicTacToe[$(($count+6))]}" = "$computer" ]
        then
            winCount=true
            echo Computer You Win
            break
       fi
   fi
 done
 echo $winCount
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

