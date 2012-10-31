class Snake

	constructor : (@canvas) ->
		@init()

	options :
		fps : 10

	snake :
		parts: [ [0,100], [0,75], [0,50], [0,25], [0,0] ],
		moveVal : 25,
		currentDirection : 'down'

	cherry :
		width : 25
		height : 25
		x : 50
		y : 50

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
			@generateCherry()
		, 1000 / @options.fps)
		
	generateCherry : ->
		@drawCherry( @cherry.x, @cherry.y, @cherry.width, @cherry.height )

	drawCherry : (x, y, width, height) ->
		@ctx.fillStyle = "red"
		@ctx.fillRect(x,y,width,height)

	drawSnakePart : (x, y) =>
		@ctx.fillStyle = "rgba(0, 0, 200, 1)"
		@ctx.fillRect(x,y,25,25)
		
	generateSnake : =>
		_.each @snake.parts, (num) =>
			@drawSnakePart(num[0], num[1])

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
		

window?.Snake = Snake
