playerInfo = Array.new
#[name, age, upp, service, ]

#get name
puts "enter the character name"
name = gets.chomp
playerInfo << name

#set age
age = 18
playerInfo <<age
puts "#{name} is 18 years old."

#make upp
upp = Array.new
flips = ['A','B','C']
def makeUpp(upp, flips, playerInfo)
  runs = 0
  until runs == 6 do
    val = (1+rand(6)) + (1+rand(6))
    if val >= 10
      val = flips[val - 10]
    end
    upp << val
    runs = runs + 1
  end
  playerInfo << upp
end
makeUpp(upp, flips, playerInfo)

#get service
loop do
  puts "will #{name} join navy, marines, army, scouts, merchants, or other?"
  puts "enter 'help' for a brief description of each branch"
  service = gets.chomp.upcase
  if service == 'HELP'
    puts "navy: space police"
    puts "marines: space soldiers"
    puts "army: planet soldiers"
    puts "scouts: space scouts"
    puts "merchants: space merchants"
    puts "other: anything else. sometimes illegal things? ;)"
  elsif service == 'NAVY' || service == 'MARINES' || service == 'ARMY' ||
        service == 'SCOUTS' || service == 'MERCHANTS' || service == 'OTHER'
    playerInfo << service
    break
  else
    puts "invalid input"
  end
end

print playerInfo
