if (Creator == noone || Creator == other || ds_list_find_index(hit_objects,other) != -1) exit;

other.hp -= Damage;
repeat (10)
{
	instance_create_layer(other.x,other.y-24, "Effects", O_HitParticle);
}


if(instance_exists(O_Skeleton)){

	if (Creator.object_index == O_Skeleton && other.hp <= 0 && other.State != "death") 
		{O_Skeleton.kills += 1;}
	
	if (other.object_index == O_Skeleton){ 
		add_sceenshake(15,8);

		if( other.hp <=0)
			{
				var number = sprite_get_number(s_skeleton_bones);
				for(var i =0; i<number; i++){
					var bx = other.x + random_range(-8,8);
					var by = other.y + random_range(-24,0);
					var bone = instance_create_layer(bx,by,"Instances",O_SkeletonBones);
					bone.direction = 90 - (image_xscale * random_range(30,60));
					bone.speed = random_range(5,10);
					bone.image_index = i;
					if(i == 5) bone.image_angle = 130;
				}
				ini_open("save.ini");
				ini_write_real("Scores","Kills", other.kills);
				var highscore = ini_read_real("Scores", "Highscore",0);
				if(other.kills > highscore){
					ini_write_real("Scores","Highscore", other.kills);
				}
				ini_close();
			}
	}else
	{
		other.alarm[0] = 120;
		add_sceenshake(3,15);
	
	}

}



	


ds_list_add(hit_objects,other);
if(other.State != "death" && other.object_index != O_Boss)	other.State ="knockback"; 
//else{other.State = "chase";}
other.knockback_speed = Knockback;