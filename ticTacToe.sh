#!/bin/bash

echo "Welcome to TicTacToe Problem !!"

#variable
counter=0

board=(1 2 3 4 5 6 7 8 9)

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
			sign='X'
	else
			sign='O'
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
				checkWin
		else
				echo "Choose Another Position"
		fi
	else
		echo "Game Over"
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
	checkDiagonal $sign
	playerTurn  $sign
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
			playerTurn $sign
	fi
}

#Start Game
viewBoard
checkWhoPlayFirst
playerTurn $sign
