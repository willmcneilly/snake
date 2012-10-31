class Snake

	constructor : (@canvas) ->
		@init()

	options :
		fps : 5
		canvasWidth : 600
		canvasHeight : 600

	snake :
		parts: [ [0,100], [0,75], [0,50], [0,25], [0,0] ],
		width: 25
		height: 25
		moveVal : 25,
		currentDirection : 'down'

	cherry :
		width : 25
		height : 25
		x : 50
		y : 50
		colour : "red"

	score :
		points : 0

	init : =>
		@ctx = @canvas.getContext('2d')
		@addEvents()
		@drawScene()
		
	addEvents : ->
		$(document).keydown (e) =>
			@checkKey(e)

	drawScene : =>
		setTimeout( =>
			window.webkitRequestAnimationFrame(@drawScene)
			@ctx.clearRect(0,0,600,600)
			@move()
			@drawCherry()
			@detectCollision(@snake.parts[0][0], @snake.parts[0][1], @snake.width, @snake.height, @cherry.x, @cherry.y, @cherry.width, @cherry.height)			
		, 1000 / @options.fps)
		
	generateCherry : ->
		@cherry.x = @getRandomInt(0, ((@options.canvasWidth / @cherry.width) - 1 ) ) * @cherry.width
		@cherry.y = @getRandomInt(0, ((@options.canvasHeight / @cherry.height) - 1) ) * @cherry.height
		@drawCherry()

	getRandomInt : (min, max) ->
    Math.floor(Math.random() * (max - min + 1)) + min

	drawCherry : ->
		console.log @cherry.x
		console.log @cherry.y
		@ctx.fillStyle = @cherry.colour
		@ctx.fillRect(@cherry.x, @cherry.y, @cherry.width, @cherry.height)

	drawSnakePart : (x, y) =>
		@ctx.fillStyle = "rgba(0, 0, 200, 1)"
		@ctx.fillRect(x,y,25,25)
		
	generateSnake : =>
		_.each @snake.parts, (num) =>
			@drawSnakePart(num[0], num[1])

	eatCherry : ->
		@snake.parts.unshift([@cherry.x, @cherry.y])

	moveDown : =>
		@snake.parts.pop()
		newX = @snake.parts[0][0]
		newY = @snake.parts[0][1] + @snake.moveVal
		@snake.parts.unshift([newX, newY])
		@snake.currentDirection = 'down'
		@generateSnake()

	moveUp : =>
		@snake.parts.pop()
		newX = @snake.parts[0][0]
		newY = @snake.parts[0][1] - @snake.moveVal
		@snake.parts.unshift([newX, newY])
		@snake.currentDirection = 'up'
		@generateSnake()

	moveLeft : =>
		@snake.parts.pop()
		newX = @snake.parts[0][0] - @snake.moveVal
		newY = @snake.parts[0][1] 
		@snake.parts.unshift([newX, newY])
		@snake.currentDirection = 'left'
		@generateSnake()

	moveRight : =>
		@snake.parts.pop()
		newX = @snake.parts[0][0] + @snake.moveVal
		newY = @snake.parts[0][1] 
		@snake.parts.unshift([newX, newY])
		@snake.currentDirection = 'right'
		@generateSnake()

	move : =>
		switch @snake.currentDirection
			when 'up' then @moveUp()
			when 'down' then @moveDown()
			when 'right' then @moveRight()
			when 'left' then @moveLeft()

	checkKey : (e) =>
		switch e.keyCode
			when 40 then @moveDown()
			when 38 then @moveUp()
			when 37 then @moveLeft()
			when 39 then @moveRight()
			else console.log 'other'

	detectCollision : (x1, y1, w1, h1, x2, y2, w2, h2) ->
    w2 += x2
    w1 += x1
    if x2 > w1 || x1 > w2 
    	return false
    h2 += y2
    h1 += y1
    if y2 > h1 || y1 > h2 
    	return false
    
    console.log 'collsion detected'
    @collisionDetected()


   collisionDetected : ->
   	@eatCherry()
   	@generateCherry()




		

window?.Snake = Snake
