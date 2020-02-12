#!/bin/bash

echo "Welcome to TicTacToe Problem !!"

board=(1 2 3 4 5 6 7 8 9)

#variable
counter=0

#Function to display the board
function viewBoard(){
	for ((i=0;i<9;i+=3))
	do
		echo " ${board[i]} | ${board[i+1]} | ${board[i+2]} "
		echo " ---------"
	done
}

#Function to check who play first and assign a symbol to player
function checkWhoPlayFirst(){
	if [[ $((RANDOM % 2)) -eq 0 ]]
	then
			user='X'
			computer='O'
	else
			user='O'
			computer='X'
	fi
}

#Function to check the cell is valid to enter symbol or not
function checkValidCell(){
	if [[ ${board[position-1]} -eq $position ]]
	then
			available=1
	else
			available=0
	fi
	echo $available
}

#Function to play a user
function userTurn(){
	echo "User Turn"
	if [[ $counter -lt 9 ]]
	then
		read -p "Enter a position to mark a sign: " position
		if [[ $(checkValidCell) -eq 1 ]]
		then
				board[position-1]=$1
				((counter++))
				viewBoard
				checkWin $player
			echo "Computer Turn"
				computerTurn $2 $1
		else
				echo "Choose Another Position"
				userTurn $1 $2
		fi
	else
			echo "Game Over"
			exit
	fi
	viewBoard
}

#Function to play a computer
function computerTurn(){
	flag=0
	if [[ $counter -lt 9 ]]
	then
		checkRowWinning $1 $2 "win"
		checkRowWinning $2 $1 "block"
	if [[ $flag -eq 0 ]]
	then
		position=$((RANDOM % 9 + 1))
		if [[ $(checkValidCell) -eq 1 ]]
		then
				board[((position-1))]=$1
				((counter++))
				viewBoard
				checkWin $player
				userTurn $2 $1
		else
				computerTurn $1 $2
		fi
	else
			userTurn $2 $1
	fi
	else
			echo "Game Over"
			exit
	fi
	ViewBoard
}

#Function to set a sign for block and win conditions
function checkBlockWin(){
if [[ $3 == "block" ]]
		then
				sign=$2
				player="User"
		else
				sign=$1
				player="Computer"
		fi
}

#Function to store value after checking Win or block condition
function storeValue(){
	board[$1]=$sign
	((counter++))
	viewBoard
	flag=1
}
#Function to check Rows for Winning
function checkRowWinning(){
		checkBlockWin $1 $2 $3
		for((i=0;i<9;i=i+3))
		do
			if [[ ${board[((i))]} == ${board[((i+1))]} && ${board[((i))]} == $1 && ${board[((i+2))]} == $((i+3)) ]]
			then
				storeValue $((i+2))				
			elif [[ ${board[((i+1))]} == ${board[((i+2))]} &&  ${board[((i+1))]} == $1 && ${board[((i))]} == $((i+1)) ]]
			then
				storeValue $((i))
			elif [[ ${board[((i))]} == ${board[((i+2))]} &&  ${board[((i))]} == $1 && ${board[((i+1))]} == $((i+2)) ]]
			then
				storeValue $((i+1))
			fi
		done
		checkWin $player
		checkColumnWin $1 $2 $3
}

#Function to check Columns for Winning
function checkColumnWin(){
	checkBlockWin $1 $2 $3
	for((j=0;j<9;j++))
	do
			if [[ ${board[((j))]} == ${board[((j+3))]} &&  ${board[((j))]} == $1 && ${board[((j+6))]} == $((j+7)) ]]
			then
				storeValue $((j+6))
			elif [[ ${board[((j+3))]} == ${board[((j+6))]} &&  ${board[((j+3))]} == $1 && ${board[((j))]} == $((j+1)) ]]
			then
				storeValue $((j))
			elif [[ ${board[((j))]} == ${board[((j+6))]} &&  ${board[((j))]} == $1 && ${board[((j+3))]} == $((j+4)) ]]
			then
				storeValue $((j+3))
		fi
	done
	checkWin $player
	checkLeftDiagonal $1 $2 $3
}

#Function to check left diagonal for Winning
function checkLeftDiagonal(){
	checkBlockWin $1 $2 $3
	if [[ ${board[0]} == ${board[4]} && ${board[0]} == $1 && ${board[8]} == 9 ]]
	then
				storeValue 8
	elif [[ ${board[0]} == ${board[8]} && ${board[0]} == $1 && ${board[4]} == 5 ]]
	then
				storeValue 4
	elif [[ ${board[4]} == ${board[8]} && ${board[4]} == $1 && ${board[0]} == 1 ]]
	then
				storeValue 0
	fi
	checkWin $player
	checkRightDiagonal $1 $2 $3
}

#Function to check right diagonal fo Winning
function checkRightDiagonal(){
	checkBlockWin $1 $2 $3
	if [[ ${board[2]} == ${board[4]} && ${board[2]} == $1 && ${board[6]} == 7 ]]
	then
				storeValue 6
	elif [[ ${board[2]} == ${board[6]} && ${board[2]} == $1 && ${board[4]} == 5 ]]
	then
				storeValue 4
	elif [[ ${board[4]} == ${board[6]} && ${board[4]} == $1 && ${board[2]} == 3 ]]
	then
				storeValue 2
	fi
	checkWin $player
}

#Function to check rows and columns of player/computer is Win or not
function checkWin(){
	j=0

	for((i=0;i<9;i=i+3))
	do
		if [[ ${board[((i))]} == ${board[((i+1))]} && ${board[((i+1))]} == ${board[((i+2))]} ]]
		then
				echo "$1 win"
				exit
		elif [[ ${board[((j))]} == ${board[((j+3))]} && ${board[((j+3))]} == ${board[((j+6))]} ]]
		then
				echo "$1 win"
				exit
		fi
		((j++))
	done
	checkDiagonal $1
}

#Function to check diagonal of player/computer is Win or not
function checkDiagonal(){
	if [[ ${board[0]} == ${board[4]} &&  ${board[4]} == ${board[8]} ]]
	then
			echo "$1 win"
			exit
	elif [[ ${board[2]} == ${board[4]} &&  ${board[4]} == ${board[6]} ]]
	then
			echo "$1 win"
			exit
	fi
}

#StartGame
checkWhoPlayFirst
viewBoard

if [[ $user == 'X' ]]
then
	userTurn $user $computer
else
	echo "Computer Turn"
	computerTurn $computer $user
fi
