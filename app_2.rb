# lignes qui appellent les gems du Gemfile. Ca évite d'avoir à mettre les require dans les fichiers player.rb et game.rb
require 'bundler'
Bundler.require
require 'pry'

# Lignes qui appellent les fichiers lib/user.rb et lib/event.rb
require_relative 'lib/player'
require_relative 'lib/game'


5.times do
	system('clear')
	sleep(0.2)
	puts "\n\n"
	puts "\t" * 3 + '-------------------------------------------'
	puts "\t" * 3 + '|          Bienvenue dans le jeu          |'
	puts "\t" * 3 + '| Le but du jeu est de buter tout le monde|'
	puts "\t" * 3 + '|       Mais sans te faire buter :)       |'
	puts "\t" * 3 + '-------------------------------------------'
	puts "\n\n"
	sleep(0.7)
end


puts "Entrez votre pseudo pour créer votre personnage : "
print "> "
name = gets.chomp
gamer = HumanPlayer.new(name)


puts '--------------------------------------------------------------------'

# Création des énnemies
player1 = Player.new("Josiane")
player2 = Player.new("José")
enemies_array = [player1, player2]


# Déroulement du combat

# Tant que le joueur et qu'au moins un des deux ennemies ont toujours des points de vie
while gamer.life_points > 0 && (player1.life_points > 0 or player2.life_points > 0) 
  
	# Le programme affiche l'état du joueur
	gamer.show_state

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

	# Le programme récupère l'action du joueur
	print "\n> "
	action = gets.chomp

  # Tant que l'instruction envoyée par le joueur ne fait pas partie des 4 possibilités, le programme lui redemande.
  while !['a', 's', '0', '1'].include?(action)
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

	# Action en fonction du choix du joueur
	if action == "a" 
		gamer.search_weapon
	elsif action == "s"
	  gamer.search_health_pack
	elsif action == "0"
	  gamer.attacks(player1)
	elsif action == "1"
		gamer.attacks(player2)
	end

	# Si je joueur est mort ou si les deux ennemies sont morts, on sort de la boucle while
	if gamer.life_points <= 0 || (player1.life_points <= 0 && player2.life_points <= 0)
		break
	end

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
# Sinon	
else
  # Le programme affiche un message comme quoi tu sers à rien
 	puts 'Loser ! Tu as perdu !'
end


binding.pry