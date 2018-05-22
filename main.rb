playerInfo = Array.new
#[name, age, upp, service, terms]

#get name
puts "enter the character name"
name = gets.chomp
playerInfo << name
puts ""

#set age
age = 18
playerInfo <<age
puts "#{name} is 18 years old."
puts ""

#make upp
upp = Array.new
def makeUpp(upp, playerInfo)
  runs = 0
  until runs == 6 do
    val = (1+rand(6)) + (1+rand(6))
    upp << val
    runs = runs + 1
  end
  playerInfo << upp
end
makeUpp(upp, playerInfo)

#get service
draft = ['NAVY','MARINES','ARMY','SCOUTS','MERCHANTS','OTHER']
enlistRolls = [8,9,5,7,7,3]
surviveRecs = [5,6,5,7,5,5]

loop do
  puts "will #{name} join navy, marines, army, scouts, merchants, or other?"
  puts "enter 'help' for a brief description of each branch"
  puts ""
  service = gets.chomp.upcase
  if service == 'HELP'
    puts "navy: space police"
    puts "marines: space soldiers"
    puts "army: planet soldiers"
    puts "scouts: space scouts"
    puts "merchants: space merchants"
    puts "other: anything else. sometimes illegal things? ;)"
    puts ""
  elsif service == 'NAVY' || service == 'MARINES' || service == 'ARMY' ||
        service == 'SCOUTS' || service == 'MERCHANTS' || service == 'OTHER'
    puts "rolling for enlistment in #{service}"
    roll = (1+rand(6))+(1+rand(6))

        #dm checks
        if service == 'NAVY'
          if playerInfo[2][3] >= 8 #intelligence 8+
            roll = roll + 1
          elsif playerInfo[2][4] >= 9 #education 9+
            roll = roll + 2
          end
        end

        if service == 'MARINES'
          if playerInfo[2][4] >= 8 #intelligence 8+
            roll = roll + 1
          elsif playerInfo[2][0] >= 8 #strength 8+
            roll = roll + 2
          end
        end

        if service == 'ARMY'
          if playerInfo[2][1] >= 6 #dexterity 6+
            roll = roll + 1
          elsif playerInfo[2][2] >= 5 #endurance 5+
            roll = roll + 2
          end
        end

        if service == 'SCOUTS'
          if playerInfo[2][3] >= 6 #intelligence 6+
            roll = roll + 1
          elsif playerInfo[2][0] >= 8 #strength 8+
            roll = roll + 2
          end
        end

        if service == 'MERCHANTS'
          if playerInfo[2][0] >= 7 #strength 7+
            roll = roll + 1
          elsif playerInfo[2][3] >= 6 #intelligence 6+
            roll = roll + 2
          end
        end

    if roll >= enlistRolls[draft.index(service)]
      puts "rolled #{roll}. successfully enrolled in #{service}"
      puts ""
      playerInfo << service
    else
      puts "rolled #{roll}. failed enrollment into #{service}"
      puts "rolling for draft"
      draftRoll = (1 + rand(6))
      service = draft[draftRoll]
      puts "drafted into #{service}"
      puts ""
      playerInfo << service
    end
    break
  else
    puts "invalid input"
    puts ""
  end
end

#check to survive
puts "FIRST TERM"
puts "rolling for survival"
surviveRoll = (1+rand(6)) + (1+rand(6))

  #dm checks
  if service == 'NAVY' && playerInfo[2][3] >= 7 #intelligence 7+
    surviveRoll = surviveRoll + 2
  end

  if service == 'MARINES' && playerInfo[2][2] >= 8 #endurance 8+
    surviveRoll = surviveRoll + 2
  end

  if service == 'ARMY' && playerInfo[2][4] >= 6 #education 6+
    surviveRoll = surviveRoll + 2
  end

  if service == 'SCOUTS' && playerInfo[2][2] >= 9 #endurance 9+
    surviveRoll = surviveRoll + 2
  end

  if service == 'MERCHANTS' && playerInfo[2][3] >= 7 #intelligence 7+
    surviveRoll = surviveRoll + 2
  end

  if service == 'OTHER' && playerInfo[2][3] >= 9 #intelligence 9+
    surviveRoll = surviveRoll + 2
  end

if surviveRoll >= surviveRecs[draft.index(service)]
  puts "rolled #{surviveRoll} on roll for survival."
  puts "survived"
else
  puts "rolled #{surviveRoll} on roll for survival."
  puts "died"
end

# flips = ['A','B','C']
# if val >= 10
#   val = flips[val - 10]
# end
print playerInfo
