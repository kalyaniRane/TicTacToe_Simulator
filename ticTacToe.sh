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

#Function to play a player
function playerTurn(){
	if [[ $counter -lt 9 ]]
	then
		read -p "Enter a position to mark a sign: " position
		if [[ $(checkValidCell) -eq 1 ]]
		then
				board[position-1]=$1
				((counter++))
				viewBoard
				checkWin $2 $1
		else
				echo "Choose Another Position"
				playerTurn $1 $2
		fi
	else
			echo "Board is Full"
			exit
	fi
	viewBoard
}

#Function to check winning condition for rows and columns
function checkWin(){
	j=0

	for((i=0;i<9;i=i+3))
	do
		if [[ ${board[((i))]} == ${board[((i+1))]} && ${board[((i+1))]} == ${board[((i+2))]} ]]
		then
				exit
		elif [[ ${board[((j))]} == ${board[((j+3))]} && ${board[((j+3))]} == ${board[((j+6))]} ]]
		then

				exit
		fi
		((j++))
	done
	checkDiagonal $2 $1
	playerTurn $2 $1
}

#Function to check diagonal for user win
function checkDiagonal(){
	if [[ ${board[0]} == ${board[4]} &&  ${board[4]} == ${board[8]} ]]
	then
			exit
	elif [[ ${board[2]} == ${board[4]} &&  ${board[4]} == ${board[6]} ]]
	then
			exit
	else
			playerTurn $2 $1
	fi
}

#Start Game
viewBoard
checkWhoPlayFirst

if [[ $user == 'X' ]]
then
	playerTurn $user $computer
else
	playerTurn $computer $user
fi
