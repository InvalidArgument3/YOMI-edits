extends ObjectState

const FIRE_TIME = 120
const DAMAGE = 2
export  var width = 100

func _tick():
	var fighter = host.get_fighter()
	if fighter:
		var opponent = fighter.opponent

		var local_pos = host.obj_local_pos(opponent).x
		if opponent != null and Utils.int_abs(local_pos) < width:
			if fighter.flame_touching_opponent == null:
				fighter.flame_touching_opponent = host.obj_name
			if fighter.flame_touching_opponent == host.obj_name:
				if not opponent.invulnerable and opponent.is_grounded():
					opponent.take_damage(DAMAGE)
		else :
			if fighter and fighter.flame_touching_opponent == host.obj_name:
				fighter.flame_touching_opponent = null

	if current_tick > FIRE_TIME:
		host.disable()
		if not host.from_loic and host.creator:
			host.creator.can_flamethrower = true
	if current_tick % 20 == 0:
		host.play_sound("Fire")
	host.set_y(0)
