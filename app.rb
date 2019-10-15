# lignes qui appellent les gems du Gemfile. Ca évite d'avoir à mettre les require dans les fichiers player.rb et game.rb
require 'bundler'
Bundler.require
require 'pry'

# Lignes qui appellent les fichiers lib/user.rb et lib/event.rb
require_relative 'lib/player'
require_relative 'lib/game'



player1 = Player.new("Josiane")
player2 = Player.new("José")

# Fonction qui gère le déroulement du combat
def fight

	# On définit une variable pour compter les phases de combat
	number_rounds = 1

	# Affiche l'état initial de player2
	puts "\n\t\t\tVoici l\'état de chaque joueur :\n\n"
	player2.show_state

	# Tant que les deux joueurs ont des points de vie, je jeu a lieu.
	while player1.life_points > 0 && player2.life_points > 0
		# Affiche l'état initial de player1
		player1.show_state

	  puts "\n\n\t\t\tPassons à la phase d\'attaque n°#{number_rounds} :\n\n"
	  
	  # player2 se fait attaquer par player1
	  player1.attacks(player2)

	  # A chaque tour, on vérifie que le player2 a toujours des points de vie. Sinon le combat se termine et le programme sort de la boucle while
	  if player2.life_points <= 0
	  	puts "#{player2.name} s'est fait défoncer!"
	  	puts 'Le combat est terminé !'
	  	break
	  end

	  # Si player2 a toujours des points de vie, on affiche son état.
	  player2.show_state
	  
	  # Puis player2 attaque player1
	  player2.attacks(player1)
	  #player1.show_state

	  number_rounds += 1
	end
end


fight

binding.pry


