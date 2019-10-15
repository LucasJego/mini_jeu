class Game

	attr_accessor :human_player, :enemies

  def initialize(name)
    @human_player = HumanPlayer.new(name)
    @enemies = []
    
    # Boucle qui créé quatre ennemis et qui les met dans le tableau @enemies
    4.times do |i|
    	@enemies << Player.new("bot_#{i+1}")
    end
  end

  # Fonction qui enlève un ennemi du tableau des ennemis
  def kill_player(player)
    @enemies -= [player]
  end

  # Fonction qui renvoie true si le jeu continue et false sinon
  def is_still_going?
    if ((gamer.life_points > 0) && (@enemies.size > 0))
    	return true
    else
    	return false
    end
  end

  # Fonction qui affiche l'état du joueur et le nombre d'ennemis toujours en vie
  def show_players
  	gamer.show_state
  	puts "Il reste #{@enemies.size} ennemies."
  end

  def menu_choice(choice)
    # Affichage du menu d'action
	  sleep(1.5)
	  puts "\nQuelle action veux-tu effectuer ?\n\n"
	  puts 'a - chercher une meilleure arme'
	  puts "s - chercher à se soigner\n\n"
	  puts 'attaquer un joueur en vue :'
	  print '0 - '
	  player1.show_state
	  print '1 - '
	  player2.show_state
	  print '3 - '
	  player3.show_state
	  print '4 - '
	  player4.show_state

	  puts "\n\n"
	  print"> "
	  choice = gets.chomp

	  while !["a", "s", "0", "1", "2", "3"].include?(choice)
	  	puts 'Action impossible. Quel est votre choix ?'
      print '> '
		  action = gets.chomp
	  end

	  puts "=========================================\n\n"

	  # Chargement
	  6.times do |i|
	  	system('clear')
	  	sleep(0.1)
	  	#print "#" * (i+1)
	  	print "\t\t\t\tChargement..."
	  	sleep(0.1)
	  	system('clear')
	  	#sleep(0.5)
	  end

		# Action à réaliser en fonction du choix du joueur
		if choice == "a" 
			gamer.search_weapon

		elsif choice == "s"
		  gamer.search_health_pack

		elsif choice == "0"
		  gamer.attacks(player1)
		  if player1.life_points <= 0
		    player1.kill_player
		  end

		elsif choice == "1"
			gamer.attacks(player2)
			if player2.life_points <= 0
				player2.kill_player
			end

		elsif choice == "2"
			gamer.attacks(player3)
			if player3.life_points <= 0
				player3.kill_player
			end

		elsif choice == "3"
			gamer.attack(player4)
			if player4.life_points <= 0
				player4.kill_player
			end
		end

  end

  # Fonction
  def enemies_attack
  	@enemies.each do |enemy|
  		enemy.attacks(gamer)
  	end
  end

  def final_dispaly
    # Si je joueur est mort ou si les deux ennemies sont morts, on sort de la boucle while
		#if (gamer.life_points) <= 0 || (player1.life_points <= 0 && player2.life_points <= 0)
		#	break
		#end

		sleep(1.2)
		puts "\n\nLes autres joueurs t\'attaquent !\n\n"
	  sleep(0.8)

		# Attaque des autres joueurs
		enemies_array.each do |enemy|
			# Seul les ennemis qui possèdent encore des points de vie peuvent attaquer
			if enemy.life_points > 0
				enemy.attacks(gamer)
			end
		end

		puts "\nLa partie est finie!\n"

		# Si le joueur a toujours des points de vie, 
		if gamer.life_points > 0
		  # Le programme affiche un message de félicitation
		  puts "\t\t\t-------------------------"
		  puts "\t\t\t|                       |"
		 	puts "\t\t\t| BRAVO ! TU AS GAGNE ! |"
		 	puts "\t\t\t|                       |"
		 	puts "\t\t\t-------------------------"

		 	puts"\n\nAAAAAAAAH! TU LES AS BIEN DEFONCEES!!!"
		# Sinon	
		else
		  # Le programme affiche un message comme quoi tu sers à rien
		 	puts 'Loser ! Tu as perdu !'
	  end
  end

end



#binding.pry