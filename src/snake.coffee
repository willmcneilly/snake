$ ->

	
	@snake = { 
		parts: [  [0,100], [0,75], [0,50], [0,25], [0,0] ],
		moveVal : 25,
		currentDirection : 'down',
		cherryPos : [10, 10]
	}


	@ctx = null
	
	init = =>
		canvas = document.getElementById('canvas')
		@ctx = canvas.getContext('2d')
		drawScene()

	drawScene = =>
		fps = 10
		setTimeout(=>
			window.webkitRequestAnimationFrame(drawScene)
			@ctx.clearRect(0,0,600,600)
			move()
			drawCherry()
		, 1000 / fps)
		
		
	generateCherry = =>
		drawCherry(10, 10)

	drawCherry = (x, y) =>
		#console.log 'triggered'
		#console.log x
		#console.log y
		@ctx.fillStyle = "red"
		@ctx.fillRect(10,10,25,25)

	drawSnakePart = (x, y) =>
		@ctx.fillStyle = "rgba(0, 0, 200, 0.5)"
		@ctx.fillRect(x,y,25,25)
		
	generateSnake = =>
		_.each @snake.parts, (num) =>
			drawSnakePart(num[0], num[1])

	moveDown = =>
		@snake.parts.pop()
		newX = @snake.parts[0][0]
		newY = @snake.parts[0][1] + @snake.moveVal
		@snake.parts.unshift([newX, newY])
		@snake.currentDirection = 'down'
		generateSnake()

	moveUp = =>
		@snake.parts.pop()
		newX = @snake.parts[0][0]
		newY = @snake.parts[0][1] - @snake.moveVal
		@snake.parts.unshift([newX, newY])
		@snake.currentDirection = 'up'
		generateSnake()

	moveLeft = =>
		@snake.parts.pop()
		newX = @snake.parts[0][0] - @snake.moveVal
		newY = @snake.parts[0][1] 
		@snake.parts.unshift([newX, newY])
		@snake.currentDirection = 'left'
		generateSnake()

	moveRight = =>
		@snake.parts.pop()
		newX = @snake.parts[0][0] + @snake.moveVal
		newY = @snake.parts[0][1] 
		@snake.parts.unshift([newX, newY])
		@snake.currentDirection = 'right'
		generateSnake()

	move = =>
		switch @snake.currentDirection
			when 'up' then moveUp()
			when 'down' then moveDown()
			when 'right' then moveRight()
			when 'left' then moveLeft()


	checkKey = (e) =>
		switch e.keyCode
			when 40 then moveDown()
			when 38 then moveUp()
			when 37 then moveLeft()
			when 39 then moveRight()
			else console.log 'other'


	init()
	$(document).keydown (e) =>
		checkKey(e)
		











