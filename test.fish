#set first_quote "abcde it is a first quote"
#set second_quote "fghij it is a second quote"
#set third_quote "klmno it is a third quote"

#random first_quote second_quote third_quote | read quote

#random choice $first_quote $second_quote $third_quote | read quote
#echo $quote

set 1 'one'
set 2 'two'
set 3 'three'
set 4 'four'

random $1 $4 | read quote
echo $quote
