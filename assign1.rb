# Anthony Giacalone
# CECS 424
# September 3, 2011
# Assignment 1
# Coin arranging program

# First we set up some variables

# Establish what turn the game is in.
# The game lasts up until 5 turns, but it can end early if the player
#   discovers a solution before the 5-turn limit is up.
turn = 1
wingame = false
prevmove = 0

# The coin array - this will change as the game is played
#   The array will be either 10 or 12 nodes, depending on if there
#   are blanks ('-') or not.
coins = ['H','H','H','H','H','T','T','T','T','T']

puts "Welcome to Coin Arranger!\n\n"

# Method to 'take a turn' - this moves the array position
def taketurn(movefrom,moveto,coins)        
    # This method changes the position of the coins

    # Check to see if the moveto position is 1
    #   and if so, move all of the values over two

    if moveto == 1 && coins[0] != '-'
        2.times {coins.insert(0,'-')}
        movefrom += 2
    elsif moveto == 11 && coins[11] != '-'
        coins.push('-','-')
    end

    # Copy the variables that need to be moved
    arrange1 = coins[movefrom-1]
    arrange2 = coins[movefrom]
    arrange3 = coins[moveto-1]
    arrange4 = coins[moveto]  

    # Move the variables into their new places within the array
    coins[moveto-1] = arrange1
    coins[moveto] = arrange2
    coins.delete('-')
    coins[movefrom-1] = arrange3
    coins[movefrom] = arrange4
    
    # Check the end positions to see if there are dashes after turn and
    #   eliminate them
    if (coins[0] == '-') || (coins[11] == '-')
        coins.delete('-')
    end
end

while(turn < 6 && wingame == false)
    # Error catching while loop
    validmove = false
    while (validmove == false)
        print("Turn ",turn, "\n")       # Print out the coin arrangement

        # Join function used to display array as string literal
        str_coins = coins.join
        puts str_coins
        movefrom = gets.length
        
        # Check the user-selected move to see if it is a valid move
        #   Moves cannot be from nil or blank spaces
        if coins[movefrom-1] == (nil || '-') || coins[movefrom] == (nil || '-')  || movefrom < 1 || movefrom >= coins.count
            puts "That is not a valid move. Try again."
        else
            if coins.count == 10 || turn == 1
                puts ("Front or back? (1/11)")                
                move_decision = false
                while (move_decision == false)                 
                    moveto = gets.to_i       
                    if (moveto == 1) || (moveto == 11)
                        move_decision = true
                    else
                        puts "That is not a valid move. Try again."
                    end
                end
            else
                moveto = prevmove
            end
            validmove = true
        end
    end
    prevmove = movefrom
    
    # Run the taketurn method
    taketurn(movefrom,moveto,coins)
    
    # The two conditions for a successful endgame
    if str_coins == ('HTHTHTHTHT' || 'THTHTHTHTH')
        wingame = true
    end

    # Increment the turn counter    
    turn += 1
end

# The endgame
str_coins = coins.join
puts "\nEnding positon: ",str_coins
if wingame == true
    puts "\nCongratulations! You Win!"
else
    puts "\nYou lose!"
end
