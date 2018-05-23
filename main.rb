$alive = true

unless $alive == false
  playerInfo = Array.new
  #[name, age, upp, service, terms, commissions, promotions]


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

  #set terms
  @terms = 0

  commission = 0

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
  #ARRAYS!!
  draft = ['NAVY','MARINES','ARMY','SCOUTS','MERCHANTS','OTHER']
  enlistRolls = [8,9,5,7,7,3]
  surviveRecs = [5,6,5,7,5,5]
  commRecs = [10,9,5,'nil',4,'nil']
  promRecs = [8,9,6,'nil',10,'nil']
  reinlistRolls = [6,6,7,3,4,5]


  loop do
    puts "will #{name} join navy, marines, army, scouts, merchants, or other?"
    puts "enter 'help' for a brief description of each branch"
    puts ""
    @service = gets.chomp.upcase

    if @service == 'HELP'
      puts "navy: space police"
      puts "marines: space soldiers"
      puts "army: planet soldiers"
      puts "scouts: space scouts"
      puts "merchants: space merchants"
      puts "other: anything else. sometimes illegal things? ;)"
      puts ""
    elsif @service == 'NAVY' || @service == 'MARINES' || @service == 'ARMY' ||
          @service == 'SCOUTS' || @service == 'MERCHANTS' || @service == 'OTHER'
      puts "rolling for enlistment in #{@service}"
      roll = (1+rand(6))+(1+rand(6))

          #dm checks
          if @service == 'NAVY'
            if playerInfo[2][3] >= 8 #intelligence 8+
              roll = roll + 1
            elsif playerInfo[2][4] >= 9 #education 9+
              roll = roll + 2
            end
          end

          if @service == 'MARINES'
            if playerInfo[2][4] >= 8 #intelligence 8+
              roll = roll + 1
            elsif playerInfo[2][0] >= 8 #strength 8+
              roll = roll + 2
            end
          end

          if @service == 'ARMY'
            if playerInfo[2][1] >= 6 #dexterity 6+
              roll = roll + 1
            elsif playerInfo[2][2] >= 5 #endurance 5+
              roll = roll + 2
            end
          end

          if @service == 'SCOUTS'
            if playerInfo[2][3] >= 6 #intelligence 6+
              roll = roll + 1
            elsif playerInfo[2][0] >= 8 #strength 8+
              roll = roll + 2
            end
          end

          if @service == 'MERCHANTS'
            if playerInfo[2][0] >= 7 #strength 7+
              roll = roll + 1
            elsif playerInfo[2][3] >= 6 #intelligence 6+
              roll = roll + 2
            end
          end


      if roll >= enlistRolls[draft.index(@service)]
        puts "rolled #{roll}. successfully enlisted in #{@service}"
        puts ""
        playerInfo << @service
        break
      else
        puts "rolled #{roll}. failed enlisted into #{@service}"
        puts "rolling for draft"
        draftRoll = (rand(6))
        @service = draft[draftRoll]
        puts "drafted into #{@service}"
        puts ""
        playerInfo << @service
        @drafted = true
        break
      end
    else
      puts "invalid input"
      puts ""
    end
  end

    #check to survive
    def survival(playerInfo, surviveRecs, draft)
      puts "terms served = #{@terms}"
      puts "rolling for survival in term #{@terms + 1}"
      surviveRoll = (1+rand(6)) + (1+rand(6))
      #@service = playerInfo[3]

        #dm checks
        if @service == 'NAVY' && playerInfo[2][3] >= 7 #intelligence 7+
          surviveRoll = surviveRoll + 2
        end

        if @service == 'MARINES' && playerInfo[2][2] >= 8 #endurance 8+
          surviveRoll = surviveRoll + 2
        end

        if @service == 'ARMY' && playerInfo[2][4] >= 6 #education 6+
          surviveRoll = surviveRoll + 2
        end

        if @service == 'SCOUTS' && playerInfo[2][2] >= 9 #endurance 9+
          surviveRoll = surviveRoll + 2
        end

        if @service == 'MERCHANTS' && playerInfo[2][3] >= 7 #intelligence 7+
          surviveRoll = surviveRoll + 2
        end

        if @service == 'OTHER' && playerInfo[2][3] >= 9 #intelligence 9+
          surviveRoll = surviveRoll + 2
        end

      if surviveRoll >= surviveRecs[draft.index(@service)]
        puts "rolled #{surviveRoll} on roll for survival."
        puts "survived"
        @terms = @terms + 1
      else
        puts "rolled #{surviveRoll} on roll for survival."
        puts "died"
        print playerInfo
        puts ""
        $alive = false
        exit
      end
      playerInfo[4] = @terms
    end

  #roll for commission
  def checkComm(playerInfo, commRecs, draft, commission)
    commRoll = (1+rand(6)) + (1+rand(6))

    #dm checks
    if @service == 'NAVY' && playerInfo[2][5] >= 9 #social 9+
          commRoll = commRoll + 1
    end

    if @service == 'MARINES' && playerInfo[2][4] >= 7 #education 7+
          commRoll = commRoll + 1
    end

    if @service == 'ARMY' && playerInfo[2][2] >= 9 #endurance 7+
          commRoll = commRoll + 1
    end

    if @service == 'SCOUTS'
          puts "scouts do not receive commissions or promotions"
    end

    if @service == 'MERCHANTS' && playerInfo[2][3] >= 6 #intelligence 6+
          commRoll = commRoll + 1
    end

    if @service == 'OTHER'
          puts "players in the 'other' service do not receive commissions or promotions"
    end


    if @drafted
      puts "draftees can't apply for commissions or promotions in their first year"
      @drafted = false
    else
      if @service != 'SCOUTS' && @service != 'OTHER'
       if commRoll >= commRecs[draft.index(@service)]
          puts "rolled #{commRoll} on roll for commission."
          puts "received commission"
          commission = commission + 1
        else
          puts "rolled #{commRoll} on roll for commission."
          puts "did not receive commission"
        end
      end
    end
    playerInfo[5] = commission
  end

  #attempt promotion
    promotion = 0
    playerInfo[6] = promotion
    def checkProm(playerInfo, promRecs, draft, promotion)
      promRoll = (1+rand(6)) + (1+rand(6))

      #dm checks
      if @service == 'NAVY' && playerInfo[2][4] >= 8 #education 8+
            promRoll = promRoll + 1
      end

      if @service == 'MARINES' && playerInfo[2][5] >= 8 #social 8+
            promRoll = promRoll + 1
      end

      if @service == 'ARMY' && playerInfo[2][4] >= 7 #education 7+
            promRoll = promRoll + 1
      end

      if @service == 'SCOUTS'
            puts "scouts do not receive commissions or promotions"
      end

      if @service == 'MERCHANTS' && playerInfo[2][3] >= 9 #intelligence 9+
            promRoll = promRoll + 1
      end

      if @service == 'OTHER'
            puts "players in the 'other' service do not receive commissions or promotions"
      end

      if @service != 'SCOUTS' && @service != 'OTHER'
        if playerInfo[5] < 1
          puts "#{name} needs to be commissioned before being promoted"
        else
         if promRoll >= promRecs[draft.index(@service)]
            puts "rolled #{promRoll} on roll for promotion."
            puts "received promotion"
            promotion = promotion + 1
          else
            puts "rolled #{promRoll} on roll for promotion."
            puts "did not receive promotion"
          end
        end
      else
        promotion = 0
      end
      playerInfo[6] = promotion
    end

    #roll to reinlist
    def reinlistment(reinlistRolls, draft, age)
      reinRoll = (1+rand(6) + 1+rand(6))
      if reinRoll >= reinlistRolls[draft.index(@service)]
        puts "successfully reinlisted in the #{@service}"
        age = age + 4
      else
        puts "failed reinlistment into the #{@service}"
        enlisted = false
      end
    end

    enlisted = true
    while enlisted == true
      survival(playerInfo, surviveRecs, draft)
      checkComm(playerInfo, commRecs, draft, commission)
      checkProm(playerInfo, promRecs, draft, promotion)

      reqRoll = (1+rand(6) + 1+rand(6))
        if reqRoll == 12
          reinlistment(reinlistRolls, draft, age)
        else
          loop do
            puts ""
            puts "reinlist?"
            enlistAgain = gets.chomp.upcase
            if enlistAgain == 'YES'
              reinlistment(reinlistRolls, draft, age)
              break
            elsif enlistAgain == 'NO'
              enlisted = false
              break
            else
              puts "invalid answer"
            end
          end
        end
        if @terms > 4
          enlisted = false
          "character may only serve up to 5 terms"
        end
      end

end

puts "player info format = [name, age, upp, service, terms, commissions, promotions]"
#just so that player info doesn't print twice if the character died
unless $alive == false
  print playerInfo
end
