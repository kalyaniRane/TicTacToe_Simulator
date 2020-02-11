#!/bin/bash -x

echo "Welcome to TicTacToe Problem !!"
#Reset Board
board=(1 2 3 4 5 6 7 8  9)

#Function to display the board
function viewBoard(){
	for ((i=0;i<9;i+=3))
	do
		echo " ${board[i]} | ${board[i+1]} | ${board[i+2]} "
		echo " ---------"
	done
}
