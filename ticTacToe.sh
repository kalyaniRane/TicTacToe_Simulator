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
	if [[ $counter -lt 9 ]]
	then
		read -p "Enter a position to mark a sign: " position
		if [[ $(checkValidCell) -eq 1 ]]
		then
				board[position-1]=$1
				((counter++))
				viewBoard
				checkWin $1 "User"	
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
	if [[ $counter -lt 9 ]]
	then
		checkRowWinning $1 $2
		position=$((RANDOM % 9 + 1))
		if [[ $(checkValidCell) -eq 1 ]]
		then
				board[((position-1))]=$1
				((counter++))
				viewBoard
				checkWin $1 "Computer"
				userTurn $2 $1
		else
				computerTurn $1 $2
		fi
	else
			echo "Game Over"
			exit
	fi
	viewBoard
}

#Function to check Rows for Winning
function checkRowWinning(){
		for((i=0;i<9;i=i+3))
		do
			if [[ ${board[((i))]} == ${board[((i+1))]} && ${board[((i))]} == $1 && ${board[((i+2))]} == $((i+3)) ]]
			then
					board[((i+2))]=$1
					((counter++))
					viewBoard
			elif [[ ${board[((i+1))]} == ${board[((i+2))]} &&  ${board[((i+1))]} == $1 && ${board[((i))]} == $((i+1)) ]]
			then
					board[((i))]=$1
					((counter++))
					viewBoard
			elif [[ ${board[((i))]} == ${board[((i+2))]} &&  ${board[((i))]} == $1 && ${board[((i+1))]} == $((i+2)) ]]
			then
					board[((i+1))]=$1
					((counter++))
					viewBoard
			fi
		done
		checkWin $1 "Computer"
		checkColumnWin $1 $2
}

#Function to check Columns for Winning
function checkColumnWin(){

	for((j=0;j<9;j++))
	do
			if [[ ${board[((j))]} == ${board[((j+3))]} &&  ${board[((j))]} == $1 && ${board[((j+6))]} == $((j+7)) ]]
			then
				board[((j+6))]=$1
				((counter++))
				viewBoard
			elif [[ ${board[((j+3))]} == ${board[((j+6))]} &&  ${board[((j+3))]} == $1 && ${board[((j))]} == $((j+1)) ]]
			then
				board[((j))]=$1
				((counter++))
				viewBoard
			elif [[ ${board[((j))]} == ${board[((j+6))]} &&  ${board[((j))]} == $1 && ${board[((j+3))]} == $((j+4)) ]]
			then
				board[((j+3))]=$1
				((counter++))
				viewBoard
		fi
	done
	checkWin $1 "Computer"
	checkLeftDiagonal $1 $2
}

#Function to check left diagonal for Winning
function checkLeftDiagonal(){
	if [[ ${board[0]} == ${board[4]} && ${board[0]} == $1 && ${board[8]} == 9 ]]
	then
				board[8]=$1
				((counter++))
				viewBoard
	elif [[ ${board[0]} == ${board[8]} && ${board[0]} == $1 && ${board[4]} == 5 ]]
	then
				board[4]=$1
				((counter++))
				viewBoard
	elif [[ ${board[4]} == ${board[8]} && ${board[4]} == $1 && ${board[0]} == 1 ]]
	then
				board[0]=$1
				((counter++))
				viewBoard
	fi
	checkRightDiagonal $1 $2
}

#Function to check right diagonal fo Winning
function checkRightDiagonal(){
	if [[ ${board[2]} == ${board[4]} && ${board[2]} == $1 && ${board[6]} == 7 ]]
	then
				board[6]=$1
				((counter++))
				viewBoard
	elif [[ ${board[2]} == ${board[6]} && ${board[2]} == $1 && ${board[4]} == 5 ]]
	then
				board[4]=$1
				((counter++))
				viewBoard
	elif [[ ${board[4]} == ${board[6]} && ${board[4]} == $1 && ${board[2]} == 3 ]]
	then
				board[2]=$1
				((counter++))
				viewBoard
	fi
	checkWin $1 "Computer"
}

#Function to check rows and columns of player/computer is Win or not
function checkWin(){
	j=0

	for((i=0;i<9;i=i+3))
	do
		if [[ ${board[((i))]} == ${board[((i+1))]} && ${board[((i+1))]} == ${board[((i+2))]} ]]
		then
				echo "$2 win"
				exit
		elif [[ ${board[((j))]} == ${board[((j+3))]} && ${board[((j+3))]} == ${board[((j+6))]} ]]
		then
				echo "$2 win"
				exit
		fi
		((j++))
	done
	checkDiagonal $2 $1
}

#Function to check diagonal of player/computer is Win or not
function checkDiagonal(){
	if [[ ${board[0]} == ${board[4]} &&  ${board[4]} == ${board[8]} ]]
	then
			echo "$2 win"
			exit
	elif [[ ${board[2]} == ${board[4]} &&  ${board[4]} == ${board[6]} ]]
	then
			echo "$2 win"
			exit
	fi
}

#Start Game
viewBoard
checkWhoPlayFirst

if [[ $user == 'X' ]]
then
	echo "User Turn"
	userTurn $user $computer
else
	echo "Computer Turn"
	computerTurn $computer $user
fi
