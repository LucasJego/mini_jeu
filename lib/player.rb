require 'pry'


class Player

  attr_accessor :name, :life_points

  def initialize(name)
    @name = name
    @life_points = 10
  end

  # Fonction qui va afficher le nombre de point du joueur
  def show_state
    puts "#{@name} a #{@life_points} points de vie."
    # Si la méthode show_state est appliqué à l'instance player1 (Josiane), le programme sait que la variable @nom est "Josiane" et @life_points est le nombre de points de vie de Josiane
  end

  # Fonction qui fait baisser le nombre de points de vie d'un joueur
  def get_damage(damage_points)
  	# On soustraie les points de dommage aux points de vie
  	@life_points = @life_points - damage_points

  	# On vérifie s'il reste des points de vie au joueur
  	if @life_points <= 0
  		puts "Le joueur #{@name} a été tué !"
  	end
  end

  # Fonction qui permet d'attaquer un joueur 
  def attacks(player)
  	puts "Le joueur #{@name} attaque le joueur #{player.name}."
    # On récupère le nombre de points de dommage correspondant au lancer de dé via la méthode compute_damage
    damage_points = compute_damage
    puts "Il lui inflige #{damage_points} points de dommage."
    # Ces points de dommage sont infligés à player. Si player n'a plus de points de vie, le programme affiche qu'il est mort.
    player.get_damage(damage_points)
  end

  # Fonction qui génère aléatoirement un nombre entre 1 et 6. Ce nombre correspondra au nombre de points de dommages infligés.
  def compute_damage
    return rand(1..6)
  end  

end



class HumanPlayer < Player

  # On ne déclare que la nouvelle variable valable pour la classe HumanPlayer. Les autres variables nom et life_points seront héritées de la classe Player.
  attr_accessor :weapon_level

  def initialize(name)
    @life_points = 100
    @weapon_level = 1
    @name = name
  end

  # Fonction qui va afficher les caractéristiques du joueur
  def show_state
    puts "#{@name} a #{@life_points} points de vie et une arme de niveau #{@weapon_level}."
  end

  # Fonction qui génère aléatoirement un niveau d'arme entre 1 et 6.
  def compute_damage
    rand(1..6) * @weapon_level
  end

  # Fonction qui génère une nouvelle arme de niveau aléatoire entre 1 et 6
  def search_weapon
    # Le programme génère aléatoirement le niveau de l'arme entre 1 et 6.
    @new_weapon_level = rand(1..6)
    puts "Tu as trouvé une arme de niveau #{@new_weapon_level}"

    # Si le niveau de la nouvelle arme est strictement supérieur au niveau de l'arme actuelle,
    if @new_weapon_level > @weapon_level
      puts 'Youhou ! Elle est meilleure que ton arme actuelle : tu la prends.'
      # Le joueur "change" d'arme.
      @weapon_level = @new_weapon_level
    else
      puts 'M@*#$... Elle n\'est pas mieux que ton arme actuelle... Tu la laisses.'
    end
  end

  # Fonction qui permet de trouver des packs de vie en fonction d'un résultat de lancer de dé.
  def search_health_pack
    # Le programme simule un lancé de dé
    @die_roll = rand(1..6)

    # Si le résultat du lancer est 1, le joueur ne trouve rien.
    if @die_roll == 1
      puts 'Tu n\'as rien trouvé...'
    
    # Si le résultat est 2, 3, 4 ou 5, le joueur trouve un pack de 50 points de vie.
    elsif (2..5).include?(@die_roll)
      if @life_points < 50
        @life_points += 50
      else
        @life_points = 100
      end
      puts 'Bravo, tu as trouvé un pack de 50 points de vie !'
   
    # Si le résultats est 6, le joueur trouve un pack de 80 points de vie.
    else
      if @life_points < 30
        @life_points += 80
      else
        @life_points = 100
      end
      puts 'Waow, tu as trouvé un pack de 80 points de vie !'
    end
  end
end


