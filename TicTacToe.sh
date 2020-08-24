#!/bin/bash -x
echo "*************************Welcome to TIC-TAC-TOE WORLD****************************"
# Constant
NUM_OF_POSITION=9
HEAD=0
# Global
player=''
computer=''
won=false
number=0
switchPlayers=false
computerWinMove=false
declare -a boardOfTicTacToe

function resetTheBoard()
{
local count=1;
 for (( i=1; i<=$NUM_OFPOSITION; i++ ))
 do
   boardOfTicTacToe[$i]='-'
 done

}
function symbolAssignment()
{
 resetTheBoard
 letters=$(( RANDOM%2 ))
 if [ $letters -eq 1 ]
 then
     player='X';
     computer='O';
 else
     player='O';
     computer='X';

 fi
 echo $resultOfToss
}
function whoPlayFirst()
{
 toss=$(( RANDOM%2 ))

	if [ $toss -eq $HEAD ]
	then
		echo "Player will play first"
		symbolAssignment
		displayBoard
		switchPlayers=false
	else
		echo "Computer will play first"
		symbolAssignment
		displayBoard
		switchPlayers=true
	fi
}
function player() {
	echo "Player's Turn"
	read -p "Enter number between 1-9 to place symbol : " number
	if [[ number -le 9 ]] && [[ number -ne 0 ]]
        then
            if  [[ ${boardOfTicTacToe["$number"]} == "$player" ]] || [[ ${boardOfTicTacToe["number"]} == "$computer" ]]
            then
                echo "Please Select Another Block....Already Occupied!!!!!!!!!!" 
                player
                displayBoard
            else 
		if [ $switchPlayers == false ]
		then
			boardOfTicTacToe[$number]=$player
		fi
			displayBoard
            fi
	fi
}
function checkToWin()
{
	counter=1
	if [ $computerWinMove=false ]
	then
		for (( i=1; i<=3; i++ ))
		do
			if [[ ${boardOfTicTacToe[$counter]} == ${boardOfTicTacToe[$counter+$1+$1]} ]] && [[ ${boardOfTicTacToe[$counter+$1]} == '-' ]] && [[ ${boardOfTicTacToe[$counter]} == $3 ]]
			then
				computerPosition=$(($counter+$1))
				boardOfTicTacToe[$computerPosition]=$computer
				computerWinMove=true
                                displayBoard
				break
			elif [[  ${boardOfTicTacToe[$counter]} == ${boardOfTicTacToe[$counter+$1]} ]] && [[  ${boardOfTicTacToe[$counter+$1+$1]} == '-' ]] && [[ ${boardOfTicTacToe[$counter]} == $3 ]]
			then
				computerPosition=$(($counter+$1+$1))
				boardOfTicTacToe[$computerPosition]=$computer
				computerWinMove=true
                                displayBoard
				break
			elif [[ ${boardOfTicTacToe[$counter+$1]} == ${boardOfTicTacToe[$counter+$1+$1]} ]] && [[ ${boardOfTicTacToe[$counter]} == '-' ]] && [[ ${boardOfTicTacToe[$counter+$1]} == $3 ]]
			then
				computerPosition=$counter
				boardOfTicTacToe[$computerPosition]=$computer
				computerWinMove=true
                                displayBoard 
				break
			fi
			counter=$(($counter+$2))
		done
	fi
}
function computer() {
	echo "Computer's Turn"
	rowValue=1
	columnValue=3
	leftDiagonalValue=4
	rightDiagonalValue=2

	checkToWin $rowValue $columnValue $1
	checkToWin $columnValue $rowValue $1
	checkToWin $leftDiagonalValue 0 $1
	checkToWin $rightDiagonalValue 0 $1
        if [ $computerWinMove = false ]
        then
            positionForComputer=$(( RANDOM%9+1 ))
            if  [[ ${boardOfTicTacToe["$positionForComputer"]} == "$player" ]] || [[ ${boardOfTicTacToe["positionForComputer"]} == "$computer" ]]
            then
                echo "Please Select Another Block....Already Occupied!!!!!!!!!!"
                computer
            else

		boardOfTicTacToe["$positionForComputer"]="$computer"
		displayBoard
            fi

          }
function winInRowsAndColumns() {
	startPosition=1
	while [ $startPosition -le 3 ]
	do
		if [[ ${boardOfTicTacToe[$startPosition]} == $1 ]] && [[ ${boardOfTicTacToe[$startPosition+$2]} == $1 ]] &&  [[ ${boardOfTicTacToe[$startPosition+$2+$2]} == $1 ]]
		then
			echo "$1 Winner!"
                        displayBoard
			won=true
			break
		else
			startPosition=$(( $startPosition + $3 ))
		fi
	done
        echo $won
}
function winInDiagonals() {
	startPosition=1
	count=1
	while [ $count -le 2 ]
	do
		if [[ ${boardOfTicTacToe[$startPosition]} == $1 ]] && [[ ${boardOfTicTacToe[$startPosition + 4]} == $1 ]] &&  [[ ${boardOfTicTacToe[$startPosition+8]} == $1 ]]
		then
			echo "$1 Winner!"
			won=true
			break
		elif [[ ${boardOfTicTacToe[$startPosition + 2]} == $1 ]] && [[ ${boardOfTicTacToe[$startPosition + 4]} == $1 ]] &&  [[ ${boardOfTicTacToe[$startPosition + 6]} == $1 ]]
		then
			echo "$1 Winner!"
			won=true
			break
		fi
	count=$(( $count + 1 ))
	done
        echo $won
}
function play(){
local temp=1;
	while [[ $won != true ]]
do
                echo Hiii
		rowBlock=1
		columnBlock=3
	        if [ $switchPlayers == false ]
                then
                    player
                    winInRowsAndColumns $player $rowBlock  $columnBlock
                    winInRowsAndColumns $player $columnBlock $rowBlock
                    winInDiagonals $player
                    if [ $temp -ge 9 ]
                    then
                        displayBoard
                        break
                    fi
                    switchPlayers=true
      	        elif [ $switchPlayers == true ]
        	then
               	    computer
                    winInRowsAndColumns $computer $rowBlock $columnBlock $won
                    winInRowsAndColumns $computer $columnBlock $rowBlock $won
                    winInDiagonals $computer $won
                    if [ $temp -ge 9 ]
                    then
                        displayBoard
                        break
                    fi
                    switchPlayers=false

                fi
                temp=$(( $temp + 1 ))

	done

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
resetTheBoard
whoPlayFirst
play
