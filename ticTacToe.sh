#!/bin/bash

echo "Welcome to TicTacToe Problem !!"

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
			player='X'
			echo "Player $player play first"
	else
			player='O'
			echo "Player $player play first"
	fi
}

#Function to check the cell is valid to enter symbol or not
function checkValidCell(){
	read -p "Enter a position to mark a sign: " position
	if [[ ${board[position-1]} -eq $position ]]
	then
			viewBoard
	else
			echo "Choose another position"
	fi
}

#Start Game
checkWhoPlayFirst
checkValidCell
