#!/bin/bash

echo "*************************Welcome to TICTACTOE WORLD****************************"


MAX_BOARD_POSITION=9
NUM_OF_POSITION=9

playerPosition=0
computerPosition=0
player=''
computer=''
nonEmptyBlockCount=1

won=false
whoPlays=false
computerWinMove=false
computerblockedMove=false

declare -a boardOfTicTacToe


function resetTheBoard() {
        local count1=1;
	for (( i=1; i<=$NUM_OF_POSITION; i++ ))
	do
		boardOfTicTacToe[$i]='-'
                
	done
}


function symbolAssignment()
{
	result=$((RANDOM%2))

	if [ $result -eq 1 ]
	then
		whoPlays=true
		player='X'
		computer='O'
		echo "Player symobol : X | Computer symbol : O"
		echo "Player plays First"
	else
		player='O'
		computer='X'
		echo "Player symobol : O | Computer symbol : X"
		echo "Computer Plays First"
	fi
}



function player()
{
	read -p "Enter  position Number to put $player at Empty Position " playerPosition
	if [ ${boardOfTicTacToe[$playerPosition]} == '-' ]
	then
		boardOfTicTacToe[$playerPosition]=$player
	else
		echo ":Position Occupied Please enter new Position"
		player
	fi
	whoPlays=false
}

function winBlockPlayMove()
{
	rowValue=1
	columnValue=3
	leftDiagonalValue=4
	rightDiagonalValue=2

	checkWinningMove $rowValue $1 $columnValue
	checkWinningMove $columnValue $1 $rowValue
	checkWinningMove $leftDiagonalValue $1 0
	checkWinningMove $rightDiagonalValue $1 0

}

function computer()
{
	computerWinMove=false
	echo "Computer is playing"
	sleep 1
	winBlockPlayMove $computer
	winBlockPlayMove $player
	checkInCorners
	if [ $computerWinMove = false ]
	then

		computerPosition=$((RANDOM%9+1))
		if [[ ${boardOfTicTacToe[$computerPosition]} != '-' ]]
		then
			echo "Computer played Wrong move "
			computer
		else
			boardOfTicTacToe[$computerPosition]=$computer
		fi
	fi
	whoPlays=true
}

function checkWinningMove()
{
	counter=1
	symbol=$2
	if [ $computerWinMove = false ]
	then
		for (( i=1; i<=3; i++ ))
		do
			if [[ ${boardOfTicTacToe[$counter]} == ${boardOfTicTacToe[$counter+$1+$1]} ]] && [[ ${boardOfTicTacToe[$counter+$1]} == '-' ]] && [[ ${boardOfTicTacToe[$counter]} == $symbol ]]
			then
				computerPosition=$(($counter+$1))
				boardOfTicTacToe[$computerPosition]=$computer
				computerWinMove=true
				break
			elif [[  ${boardOfTicTacToe[$counter]} == ${boardOfTicTacToe[$counter+$1]} ]] && [[  ${boardOfTicTacToe[$counter+$1+$1]} == '-' ]] && [[ ${boardOfTicTacToe[$counter]} == $symbol ]]
			then
				computerPosition=$(($counter+$1+$1))
				boardOfTicTacToe[$computerPosition]=$computer
				computerWinMove=true
				break
			elif [[ ${boardOfTicTacToe[$counter+$1]} == ${boardOfTicTacToe[$counter+$1+$1]} ]] && [[ ${boardOfTicTacToe[$counter]} == '-' ]] && [[ ${boardOfTicTacToe[$counter+$1]} == $symbol ]]
			then
				computerPosition=$counter
				boardOfTicTacToe[$computerPosition]=$computer
				computerWinMove=true
				break
			fi
			counter=$(($counter+$3))
		done
	fi
}
function checkInCorners
{
	 if [ $computerWinMove = false ]
   then
		for((i=1; i<=MAX_BOARD_POSITION; i=$(($i+2)) ))
		do
				if [ ${boardOfTicTacToe[$i]} == '-' ]
				then
					computerPosition=$i
            	boardOfTicTacToe[$computerPosition]=$computer
            	computerWinMove=true
            break
				fi
				if [ $i -eq 3 ]
				then
					i=$(($i+2))
				fi
		done
	fi
}

function checkInCorners
{
	 if [ $computerWinMove = false ]
   then
		for((i=1; i<=MAX_BOARD_POSITION; i=$(($i+2)) ))
		do
				if [ ${boardOfTicTacToe[$i]} == '-' ]
				then
					computerPosition=$i
            	boardOfTicTacToe[$computerPosition]=$computer
            	computerWinMove=true
            break
				fi
				if [ $i -eq 3 ]
				then
					i=$(($i+2))
				fi
		done
	fi
}



function winInRowsAndColumns()
{
	position=1
	temp=1
	while [  $temp -le 3 ]
	do
		if [[ ${boardOfTicTacToe[$position]} == ${boardOfTicTacToe[$position+$3]} ]] && [[  ${boardOfTicTacToe[$position+$3]}  ==  ${boardOfTicTacToe[$position+$3+$3]} ]] && [[ ${boardOfTicTacToe[$position+$3+$3]} == $1 ]]
		then
			displayBoard
			echo "$1 wins "
			won=true
			exit
			break
		else
			position=$(( $position+$2 ))
		fi
		temp=$(($temp+1))
	done
}




function winInDiagonals()
{
	position=1
	temp=1
	while [ $temp -le 2 ]
	do
		if [[ ${boardOfTicTacToe[$position]} == ${boardOfTicTacToe[$position+4]} ]] && [[  ${boardOfTicTacToe[$position+4]}  ==  ${boardOfTicTacToe[$position+8]} ]] && [[ ${boardOfTicTacToe[$position+8]} == $1 ]]
		then
			displayBoard
			echo "$1 wins "
			won=true
			break
		elif [[ ${boardOfTicTacToe[$position+2]} == ${boardOfTicTacToe[$position+4]} ]] && [[  ${boardOfTicTacToe[$position+4]}  ==  ${boardOfTicTacToe[$position+6]} ]] && [[ ${boardOfTicTacToe[$position+6]} == $1 ]]
		then
			displayBoard
			echo "$1 wins "
			won=true
			break
		fi
		temp=$(($temp+1))
	done
}


function checkGameTie()
{
	while [ ${boardOfTicTacToe[$nonEmptyBlockCount]} != '-' ]
	do
		if [ $nonEmptyBlockCount -eq $MAX_BOARD_POSITION ]
		then
			displayBoard
			echo "Game Is Tie"
			won=true
			computerWinMove=true
			break
		else
			nonEmptyBlockCount=$(($nonEmptyBlockCount+1))
		fi
	done
}



function checkWon()
{
	symbol=$1
	rowValue=1
	columnValue=3

	winInRowsAndColumns $symbol $columnValue  $rowValue
 	winInRowsAndColumns $symbol $rowValue $columnValue
	winInDiagonals $symbol
}

function play()
{
 while [ $won == false ]
 do
	displayBoard
	if [ $whoPlays == true ]
	then
		player
		checkWon $player
		checkGameTie
	else
		computer
		checkWon $computer
		checkGameTie
	fi

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
symbolAssignment
play
