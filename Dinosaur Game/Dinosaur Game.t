var win := Window.Open ("graphics:1200;600,offscreenonly")

const GROUND_HEIGHT := 40
const JUMP_SPEED := 30
const GRAVITY := 3
const EXTRA_GRAVITY := 6
const POS_X := 250
const CACTUS_Y := 25
const BIRD_HIGH_Y := 125
const BIRD_MED_Y := 100
const BIRD_LOW_Y := 50

var posy, mouseButton, mousex, mousey, timer : int
var dinoAnimation, dinoHitbox_x1, dinoHitbox_y1, dinoHitbox_x2, dinoHitbox_y2 : int
var cactusx1, cactusx2, cactusx3, cactusRandom, cactusSelect, cactusAllow, cactusSpeed, obstacleCount : int
var cactusMoving1, cactusHitbox1_x1, cactusHitbox1_y1, cactusHitbox1_x2, cactusHitbox1_y2 : int
var cactusMoving2, cactusHitbox2_x1, cactusHitbox2_y1, cactusHitbox2_x2, cactusHitbox2_y2 : int
var cactusMoving3, cactusHitbox3_x1, cactusHitbox3_y1, cactusHitbox3_x2, cactusHitbox3_y2 : int
var birdMoving, birdx, birdHitbox_x1, birdHitbox_x2, birdHitbox_y1, birdHitbox_y2, birdy, birdRandomizer : int
var birdDirection : int := 0
var highScore : real := 0
var chars : array char of boolean
var lose : boolean
var score, vely : real

var dinosaur : int := Pic.FileNew ("Dinosaur.bmp")
var deadDinosaur : int := Pic.FileNew ("DeadDinosaur.bmp")
var dinosaurLeft : int := Pic.FileNew ("DinosaurLeft.jpg")
var dinosaurRight : int := Pic.FileNew ("DinosaurRight.jpg")
var dinosaurDuckLeft : int := Pic.FileNew ("DinosaurDuckLeft.jpg")
var dinosaurDuckRight : int := Pic.FileNew ("DinosaurDuckRight.jpg")
var birdDown : int := Pic.FileNew ("BirdDown.jpg")
var birdUp : int := Pic.FileNew ("BirdUp.jpg")
var cactus1 : int := Pic.FileNew ("Cactus 1.jpg")
var cactus2 : int := Pic.FileNew ("Cactus 2.jpg")
var cactus3 : int := Pic.FileNew ("Cactus 3.jpg")
var restart : int := Pic.FileNew ("Restart.jpg")
var gameOver : int := Pic.FileNew ("GameOver.jpg")

loop
    cactusSpeed := 15
    cactusMoving1 := 0
    cactusMoving2 := 0
    cactusMoving3 := 0
    birdMoving := 0
    lose := false
    score := 0
    vely := 0
    timer := 0
    posy := 40
    birdy := 125
    dinoAnimation := 0
    cactusx1 := -100
    cactusx2 := -100
    cactusx3 := -100
    birdx := -100
    obstacleCount := 3

    loop
	%Spacebar Input
	Input.KeyDown (chars)
	if (chars (' ') and posy = GROUND_HEIGHT) or (chars (KEY_UP_ARROW) and posy = GROUND_HEIGHT) then
	    vely := JUMP_SPEED
	end if

	%Gravity
	if chars (KEY_DOWN_ARROW) then
	    vely -= EXTRA_GRAVITY
	else
	    vely -= GRAVITY
	end if
	posy += round (vely)

	%Y-Position
	if posy < GROUND_HEIGHT then
	    posy := GROUND_HEIGHT
	    vely := 0
	end if

	if posy < 0 then
	    posy := 0
	end if

	%Cactus Moving
	if cactusx1 > -225 then
	    cactusMoving1 := 1
	else
	    cactusMoving1 := 0
	end if
	if cactusx2 > -225 then
	    cactusMoving2 := 1
	else
	    cactusMoving2 := 0
	end if
	if cactusx3 > -225 then
	    cactusMoving3 := 1
	else
	    cactusMoving3 := 0
	end if
	if birdx > -225 then
	    birdMoving := 1
	else
	    birdMoving := 0
	end if
	
	%Cactus Spawn
	if cactusx1 > 1000 or cactusx2 > 1000 or cactusx3 > 1000 or birdx > 1000 then
	    cactusAllow := 0
	else
	    cactusAllow := 1
	end if

	if score > 300 then
	    obstacleCount := 4
	end if

	%Cactus Randomizer
	if cactusAllow = 1 then
	    randint (cactusRandom, 1, 10)
	    if cactusRandom = 1 then
		randint (cactusSelect, 1, obstacleCount)
		if cactusSelect = 1 and cactusMoving1 = 0 then
		    cactusx1 := 1500
		elsif cactusSelect = 2 and cactusMoving2 = 0 then
		    cactusx2 := 1500
		elsif cactusSelect = 3 and cactusMoving3 = 0 then
		    cactusx3 := 1500
		elsif cactusSelect = 4 and birdMoving = 0 then
		    birdx := 1500
		    randint (birdRandomizer, 1, 3)
		    case birdRandomizer of
			label 1 :
			    birdy := BIRD_LOW_Y
			label 2 :
			    birdy := BIRD_MED_Y
			label 3 :
			    birdy := BIRD_HIGH_Y
		    end case
		end if
	    end if
	end if

	%Speed Increments
	if score > 1500 then
	    cactusSpeed := 35
	elsif score > 1400 then
	    cactusSpeed := 33
	elsif score > 1300 then
	    cactusSpeed := 32
	elsif score > 1200 then
	    cactusSpeed := 31
	elsif score > 1100 then
	    cactusSpeed := 30
	elsif score > 1000 then
	    cactusSpeed := 29
	elsif score > 900 then
	    cactusSpeed := 28
	elsif score > 800 then
	    cactusSpeed := 26
	elsif score > 700 then
	    cactusSpeed := 24
	elsif score > 600 then
	    cactusSpeed := 22
	elsif score > 500 then
	    cactusSpeed := 20
	elsif score > 400 then
	    cactusSpeed := 19
	elsif score > 300 then
	    cactusSpeed := 18
	elsif score > 200 then
	    cactusSpeed := 17
	elsif score > 100 then
	    cactusSpeed := 16
	end if

	%Cactus Animation
	if cactusx1 > -250 then
	    cactusx1 -= cactusSpeed
	end if
	if cactusx2 > -250 then
	    cactusx2 -= cactusSpeed
	end if
	if cactusx3 > -250 then
	    cactusx3 -= cactusSpeed
	end if
	if birdx > -250 then
	    birdx -= cactusSpeed
	end if

	%Cactii & Bird
	Pic.Draw (cactus1, cactusx1, CACTUS_Y, picMerge)
	Pic.Draw (cactus2, cactusx2, CACTUS_Y, picMerge)
	Pic.Draw (cactus3, cactusx3, CACTUS_Y, picMerge)

	%Hitbox Declaration
	dinoHitbox_x1 := POS_X + 20
	dinoHitbox_x2 := POS_X + 55
	dinoHitbox_y1 := posy + 10
	dinoHitbox_y2 := posy + 90
	cactusHitbox1_x1 := cactusx1 + 5
	cactusHitbox1_x2 := cactusx1 + 43
	cactusHitbox1_y1 := CACTUS_Y + 10
	cactusHitbox1_y2 := CACTUS_Y + 75
	cactusHitbox2_x1 := cactusx2
	cactusHitbox2_x2 := cactusx2 + 112
	cactusHitbox2_y1 := CACTUS_Y + 10
	cactusHitbox2_y2 := CACTUS_Y + 75
	cactusHitbox3_x1 := cactusx3
	cactusHitbox3_x2 := cactusx3 + 75
	cactusHitbox3_y1 := CACTUS_Y + 10
	cactusHitbox3_y2 := CACTUS_Y + 75
	birdHitbox_x1 := birdx + 25
	birdHitbox_x2 := birdx + 75
	birdHitbox_y1 := birdy + 15
	birdHitbox_y2 := birdy + 75

	%Cactii Hitbox Overlap
	for x : dinoHitbox_x1 .. dinoHitbox_x2
	    if x >= cactusHitbox1_x1 and x <= cactusHitbox1_x2 or x >= cactusHitbox2_x1 and x <= cactusHitbox2_x2 or x >= cactusHitbox3_x1 and x <= cactusHitbox3_x2 then
		for y : dinoHitbox_y1 .. dinoHitbox_y2
		    if y >= cactusHitbox1_y1 and y <= cactusHitbox1_y2 or y >= cactusHitbox2_y1 and y <= cactusHitbox3_y2 or y >= cactusHitbox3_y1 and y <= cactusHitbox3_y2
			    then
			lose := true
			exit
		    end if
		end for
	    end if
	end for

	%Pterodactyl Hitbox Overlap
	for x : dinoHitbox_x1 .. dinoHitbox_x2
	    if x >= birdHitbox_x1 and x <= birdHitbox_x2 then
		for y : dinoHitbox_y1 .. dinoHitbox_y2
		    if y >= birdHitbox_y1 and y <= birdHitbox_y2 then
			if chars (KEY_DOWN_ARROW) and posy = GROUND_HEIGHT then
			    if birdy = BIRD_LOW_Y then
				lose := true
				exit
			    end if
			else
			    lose := true
			    exit
			end if
		    end if
		    if lose = true then
			exit
		    end if
		end for
	    end if
	end for

	if lose = true then
	    exit
	end if

	%Jump
	if posy > GROUND_HEIGHT then
	    Pic.Draw (dinosaur, POS_X - 55, posy, picMerge)

	    %Ducking
	elsif dinoAnimation < 5 and chars (KEY_DOWN_ARROW) then
	    dinoAnimation += 1
	    Pic.Draw (dinosaurDuckLeft, POS_X, posy, picMerge)
	elsif dinoAnimation < 9 and chars (KEY_DOWN_ARROW) then
	    dinoAnimation += 1
	    Pic.Draw (dinosaurDuckRight, POS_X, posy, picMerge)
	elsif dinoAnimation = 9 and chars (KEY_DOWN_ARROW) then
	    dinoAnimation := 0
	    Pic.Draw (dinosaurDuckRight, POS_X, posy, picMerge)
	    %Running
	elsif dinoAnimation < 5 then
	    dinoAnimation += 1
	    Pic.Draw (dinosaurLeft, POS_X, posy, picMerge)
	elsif dinoAnimation < 9 then
	    dinoAnimation += 1
	    Pic.Draw (dinosaurRight, POS_X, posy, picMerge)
	elsif dinoAnimation = 9 then
	    dinoAnimation := 0
	    Pic.Draw (dinosaurRight, POS_X, posy, picMerge)
	end if

	%Pterodactyl Animation
	if birdDirection < 5 then
	    birdDirection += 1
	    Pic.Draw (birdUp, birdx, birdy + 18, picMerge)
	elsif birdDirection < 9 then
	    birdDirection += 1
	    Pic.Draw (birdDown, birdx, birdy, picMerge)
	elsif birdDirection = 9 then
	    birdDirection := 0
	    Pic.Draw (birdDown, birdx, birdy, picMerge)
	end if

	%DinoHitbox
	%Draw.FillBox (POS_X + 20, posy + 10, POS_X + 55, posy + 90, black)

	%CactiiHitbox1
	%Draw.FillBox (cactusx1 + 5, CACTUS_Y + 10, cactusx1 + 43, CACTUS_Y + 90, black)

	%CactusHitbox2
	%Draw.FillBox (cactusx2, CACTUS_Y + 10, cactusx2 + 112, CACTUS_Y + 90, black)

	%CactusHitbox2
	%Draw.FillBox (cactusx3 , CACTUS_Y + 10, cactusx3 + 75, CACTUS_Y + 90, black)

	%BirdHitbox
	%Draw.FillBox (birdx + 25, birdy + 15, birdx + 75, birdy + 40, black)

	%Score Counter
	score += 0.25

	%Score Display
	locate (2, 135)
	if highScore < 10 then
	    put "HI 0000", round (highScore), " " ..
	elsif highScore < 100 then
	    put "HI 000", round (highScore), " " ..
	elsif highScore < 1000 then
	    put "HI 00", round (highScore), " " ..
	elsif highScore < 10000 then
	    put "HI 0", round (highScore), " " ..
	elsif highScore < 100000 then
	    put "HI ", round (highScore), " " ..
	end if
	if score < 10 then
	    put "0000", round (score), " " ..
	elsif score < 100 then
	    put "000", round (score), " " ..
	elsif score < 1000 then
	    put "00", round (score), " " ..
	elsif score < 10000 then
	    put "0", round (score), " " ..
	elsif score < 100000 then
	    put round (score), " " ..
	end if

	Draw.FillBox (-50, 40, 1500, 35, darkgrey)

	View.Update

	delay (25)
	cls
    end loop

    %End Game Images
    Pic.Draw (cactus1, cactusx1, CACTUS_Y, picMerge)
    Pic.Draw (cactus2, cactusx2, CACTUS_Y, picMerge)
    Pic.Draw (cactus3, cactusx3, CACTUS_Y, picMerge)
    Pic.Draw (birdUp, birdx, birdy + 18, picMerge)
    Pic.Draw (deadDinosaur, POS_X, posy + 2, picMerge)
    Pic.Draw (restart, 582, 300, 0)
    Pic.Draw (gameOver, 500, 350, 0)
    Draw.FillBox (-50, 40, 1500, 35, darkgrey)

    %Score Display
    if score > highScore then
	highScore := score
    end if
    locate (2, 135)
    if highScore < 10 then
	put "HI 0000", round (highScore), " " ..
    elsif highScore < 100 then
	put "HI 000", round (highScore), " " ..
    elsif highScore < 1000 then
	put "HI 00", round (highScore), " " ..
    elsif highScore < 10000 then
	put "HI 0", round (highScore), " " ..
    elsif highScore < 100000 then
	put "HI ", round (highScore), " " ..
    end if
    if score < 10 then
	put "0000", round (score), " " ..
    elsif score < 100 then
	put "000", round (score), " " ..
    elsif score < 1000 then
	put "00", round (score), " " ..
    elsif score < 10000 then
	put "0", round (score), " " ..
    elsif score < 100000 then
	put round (score), " " ..
    end if

    %Restart Button
    loop
	Mouse.Where (mousex, mousey, mouseButton)
	Input.KeyDown (chars)
	View.Update
	exit when mousex >= 582 and mousex <= 617 and mousey >= 300 and mousey <= 330 and mouseButton = 1
    end loop
end loop
