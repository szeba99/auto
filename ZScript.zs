




class teher : Actor 
{
    Default
    {
        Radius 26;
        Height 30;
        Health 100;
        ProjectilePassHeight -16;
        Mass 1000;
        +SOLID
        +SHOOTABLE
        +NOFRICTIONBOUNCE
        +ACTLIKEBRIDGE
		+NOGRAVITY
		+NOBLOOD
		+INTERPOLATEANGLES
		-DONTINTERPOLATE
		+NOINTERACTION
        }
    States
    {
    Spawn:
        0000 A -1;
        Stop;
    Death:
        0000 A 1;
        Stop;
    }
}



class wheel2 : Actor 
{
    Default
    {
        +NOBLOOD
        +NOFRICTIONBOUNCE
        +ACTLIKEBRIDGE
		+CLIENTSIDEONLY
		+NOGRAVITY
		+ROLLSPRITE
		+ROLLCENTER
        }
    States
    {
    Spawn:
        0000 A -1;
        Stop;
    Death:
        0000 A 1;
        Stop;
    }
}

class wheel : Actor 
{

	actor kerek;

	Override void Tick()
	{
	super.Tick();
	kerek.angle = angle;
	kerek.pitch = pitch;
	kerek.SetOrigin((pos.x,pos.y,pos.z+18),1);
	}
	
	Override void PostBeginPlay()
	{
	super.PostBeginPlay();
	kerek = Spawn("wheel2");
	}



    Default
    {
        Radius 15;
        Height 25;
        Health 100;
        ProjectilePassHeight -16;
        Mass 1000;
        +SOLID
        +SHOOTABLE
        +NOBLOOD
        +NOFRICTIONBOUNCE
        +ACTLIKEBRIDGE
		-NOGRAVITY
		+ROLLSPRITE
		+ROLLCENTER
        }
    States
    {
    Spawn:
        0000 A -1;
        Stop;
    Death:
        0000 A 1;
        Stop;
    }
}





class teherauto : Actor 
{
	vector3 forwards;
	vector3 sideways;

	actor imp1;
	actor imp2;
	actor imp3;
	actor imp4;
	actor imp5;
	actor imp6;
	actor teher;
	actor kerek1;
	actor kerek2;
	actor kerek3;
	actor kerek4;
	
	int wheelHeight;
	
	


	override void Tick() 
	{
	
	
	
		
			//don't forget to call this! otherwise your actor will be frozen and won't interact with the world
		
		forwards = (cos(angle),sin(angle),0);
		sideways = (cos(angle - 90), sin(angle - 90), 0);
		
		//angle += 0.5;
		//SetOrigin((pos.x,pos.y,pos.z) + 4 * forwards + 4 * sideways,0);
		//Thrust(0.5,angle);
		//SetZ(pos.z+0.33);
		
		
		
		
		if (imp1)
		{
			//pos + offsetX * forwards + offsetY * sideways; x 110 y 30 z 53
			//imp1.Warp(self,0,0,0);
			imp1.SetOrigin((pos.x,pos.y,pos.z+63) - 110 * forwards + 30 * sideways,1);
		}
		
		if (imp2) {imp2.SetOrigin((pos.x,pos.y,pos.z+63) - 110 * forwards - 30 * sideways,1);}
			
		if (imp3) {imp3.SetOrigin((pos.x,pos.y,pos.z+63) - 167 * forwards + 30 * sideways,1);}
		if (imp4) {imp4.SetOrigin((pos.x,pos.y,pos.z+63) - 167 * forwards - 30 * sideways,1);}
			
		if (imp5) {imp5.SetOrigin((pos.x,pos.y,pos.z+63) - 230 * forwards + 30 * sideways,1);}
		if (imp6) {imp6.SetOrigin((pos.x,pos.y,pos.z+63) - 230 * forwards - 30 * sideways,1);}
			
		
		
		if (kerek1) 
			{
				kerek1.SetOrigin((pos.x,pos.y,kerek1.pos.z) - 1 * forwards - 80 * sideways,1);
				//kerek1.angle = self.angle;
			}
			
		if (kerek2)
			{
				kerek2.SetOrigin((pos.x,pos.y,kerek2.z) - 1 * forwards + 80 * sideways,1);
				//kerek2.angle = self.angle;
			}
			
		if (kerek3)
			{
				kerek3.SetOrigin((pos.x,pos.y,kerek3.z) - 210 * forwards - 80 * sideways,1);
				kerek3.angle = self.angle;
			}
			
		if (kerek4)
			{
				kerek4.SetOrigin((pos.x,pos.y,kerek4.z) - 210 * forwards + 80 * sideways,1);
				kerek4.angle = self.angle;
			}
		
		
		if (teher && kerek1 && kerek2 && kerek3 && kerek4)
		{
			teher.angle = self.angle;
			teher.pitch = (kerek1.pos.z - kerek4.pos.z)*-0.2;
			teher.roll = (kerek1.pos.z - kerek2.pos.z) * 0.35;
			teher.SetOrigin((pos.x,pos.y,pos.z+20),1);
		}
		
		//super.Tick();
		
	}
	
	
	override void PostBeginPlay()
	{
		//super.PostBeginPlay();
		
		
		
		imp1 = Spawn("DoomImpFloat",pos);
		imp2 = Spawn("DoomImpFloat",pos);
		imp3 = Spawn("DoomImpFloat",pos);
		imp4 = Spawn("DoomImpFloat",pos);
		imp5 = Spawn("DoomImpFloat",pos);
		imp6 = Spawn("DoomImpFloat",pos);
		teher = Spawn("teher",(pos.x,pos.y,pos.z+40));
		kerek1 = Spawn("wheel",pos);
		kerek2 = Spawn("wheel",pos);
		kerek3 = Spawn("wheel",pos);
		kerek4 = Spawn("wheel",pos);
		wheelHeight = 10;
		
	}



    Default
    {
        Radius 15;
        Height 25;
        Health 100;
        ProjectilePassHeight -16;
        Mass 1000;
        +NOBLOOD
		+INTERPOLATEANGLES
		-DONTINTERPOLATE
    }
    States
    {
    Spawn:
        TROO A 1 ThrustThingZ(0,1,0,0);
		TROO A 1;
		TROO A 1;
		Loop;
    Death:
        0000 A 1;
        Stop;
    }
}

class DoomImpFloat : DoomImp
{
	Default
	{
	+NOGRAVITY
	+FRIENDLY
	speed 0;
	}
	States
	{
		Death:
		TROO IIIJJJKKKLLLMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM 1 A_FadeOut(0.02);
		Stop;
	}
}




class Driver : DoomPlayer
{
	
	actor kocsid;
	teherauto kocsid2;
	double sideInput;
	double forwardInput;
	vector3 forwards;
	vector3 sideways;
	float friction;
	float MaxCarSpeed;
	float MinCarSpeed;
	float CarSpeed;
	int timerasd;
	
	override void Tick()
	{
	
	super.Tick();
	
	if (kocsid && kocsid2 && kocsid2.kerek1 && kocsid2.kerek2 && kocsid2.kerek3 && kocsid2.kerek4)
	{
		///movement
		
		forwards = (cos(kocsid.angle),sin(kocsid.angle),0);
		sideways = (cos(kocsid.angle - 90), sin(kocsid.angle - 90), 0);
		
		sideInput = GetPlayerInput(INPUT_SIDEMOVE);
		forwardInput = GetPlayerInput(INPUT_FORWARDMOVE);
		
		if (forwardInput > 0)
			{
				//FORWARD
				CarSpeed += 0.2;
				
				if (CarSpeed > MaxCarSpeed)
				{
					CarSpeed = MaxCarSpeed;
				}
			}
		
		
		else if (forwardInput < 0)
			{
				//BACKWARDS
				CarSpeed -= 0.1;
				
				if (CarSpeed < MinCarSpeed)
				{
					CarSpeed = MinCarSpeed;
				}
			}
		
		kocsid2.kerek1.angle = kocsid.angle;
		kocsid2.kerek2.angle = kocsid.angle;
		kocsid2.kerek1.pitch+=CarSpeed*1.3;
		kocsid2.kerek2.pitch+=CarSpeed*1.3;
		kocsid2.kerek3.pitch+=CarSpeed*1.3;
		kocsid2.kerek4.pitch+=CarSpeed*1.3;
		
		if (CarSpeed != 0)
		{
			
			CarSpeed -= friction;
			
		}
		if (CarSpeed < 0)
		{
		
		CarSpeed += friction;
		
		}
		
		if (CarSpeed ~== 0)
		{
		CarSpeed = 0;
		}
		
		SetOrigin(pos+CarSpeed*forwards,TRUE);
		
		
		if (sideInput < 0 && forwardInput != 0 ||sideInput < 0 && CarSpeed > 3)
			{
				//LEFT
				kocsid.angle += 0.5;
				kocsid2.kerek1.angle=kocsid.angle+30;
				kocsid2.kerek2.angle=kocsid.angle+30;
			}
		else if (sideInput > 0 && forwardInput != 0 ||sideInput > 0 && CarSpeed > 3)
			{
				//RIGHT
				kocsid.angle -= 0.5;
				kocsid2.kerek1.angle=kocsid.angle-30;
				kocsid2.kerek2.angle=kocsid.angle-30;
			}
		
		//sound
		if (timerasd == 66)
		{
		if (CarSpeed > 1 && CarSpeed < 10)
		{
			A_PlaySound("bike/a");
		}
		
		else if (CarSpeed > 10 && CarSpeed < 20)
		{
			A_PlaySound("bike/b");
		}
		
		else if (CarSpeed > 20 && CarSpeed < 27)
		{
			A_PlaySound("bike/c");
		}
		
		else if (CarSpeed > 30)
		{
			A_PlaySound("bike/d");
		}
		timerasd=0;
		}
		timerasd++;
		///movement-end
		
		
		
		kocsid.SetOrigin(pos,0);
		
		//kocsid.angle = angle;
	}
	}
	
	override void PostBeginPlay()
	{
	super.PostBeginPlay();
	kocsid = Spawn("teherauto",pos);
	kocsid2 = teherauto(kocsid);
	
	CarSpeed = 0;
	MaxCarSpeed = 30;
	MinCarSpeed = -30;
	friction = 0.1;
	}
	
	Default
	{
	Speed 0;
	}
}