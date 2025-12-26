if status is-interactive
	echo ''
	fastfetch
    # Commands to run in interactive sessions can go here
end



set 1 'Unfortunately, no one can be told what the Matrix is. \nYou have to see it for yourself,'
set 2 "Dear Government... I'm going to have a serious talk with you \nif I ever find anyone to talk to."
set 3 "I can’t go into detail, but it’s why I went to the special meeting at the Pentagon."
set 4 'Taxation is robbery based on monopoly of weapons.'
set 5 'Down, down, down. Would the fall never come to an end?'
set 6 'You take the red pill—you stay in Wonderland, \nand I show you how deep the rabbit hole goes,'
set 7 'Welcome to the real world,'
set 8 'How deep the rabbit hole goes?'
set 9 'Oh, I like going down the rabbit hole. That’s kind of my job.'
set 10 'We’re down the hole to Wonderland, and no White Rabbit to guide us.'
set 11 'Every great discovery starts with a rabbit hole.'
set 12 'What a strange world we live in...'
set 13 'How long is forever? \nSometimes, just one second.'


set list $1 $6 $7

random choice $1 $2 $3 $4 $5 $6 $7 $8 $9 $10 $11 $12 $13  | read quote

function fish_greeting
	if contains $quote $list
		echo -e $quote $USER
	else
		echo -e $quote
	end
end
