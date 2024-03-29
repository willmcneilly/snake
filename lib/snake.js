// Generated by CoffeeScript 1.3.3
(function() {
  var Snake,
    __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

  Snake = (function() {

    function Snake(canvas) {
      this.canvas = canvas;
      this.checkKey = __bind(this.checkKey, this);

      this.move = __bind(this.move, this);

      this.moveRight = __bind(this.moveRight, this);

      this.moveLeft = __bind(this.moveLeft, this);

      this.moveUp = __bind(this.moveUp, this);

      this.moveDown = __bind(this.moveDown, this);

      this.generateSnake = __bind(this.generateSnake, this);

      this.drawSnakePart = __bind(this.drawSnakePart, this);

      this.drawScene = __bind(this.drawScene, this);

      this.init = __bind(this.init, this);

      this.init();
    }

    Snake.prototype.options = {
      fps: 5,
      canvasWidth: 600,
      canvasHeight: 600
    };

    Snake.prototype.snake = {
      parts: [[0, 100], [0, 75], [0, 50], [0, 25], [0, 0]],
      width: 25,
      height: 25,
      moveVal: 25,
      currentDirection: 'down'
    };

    Snake.prototype.cherry = {
      width: 25,
      height: 25,
      x: 50,
      y: 50,
      colour: "red"
    };

    Snake.prototype.score = {
      points: 0
    };

    Snake.prototype.init = function() {
      this.ctx = this.canvas.getContext('2d');
      this.addEvents();
      return this.drawScene();
    };

    Snake.prototype.addEvents = function() {
      var _this = this;
      return $(document).keydown(function(e) {
        return _this.checkKey(e);
      });
    };

    Snake.prototype.drawScene = function() {
      var _this = this;
      return setTimeout(function() {
        window.webkitRequestAnimationFrame(_this.drawScene);
        _this.ctx.clearRect(0, 0, 600, 600);
        _this.drawScore();
        _this.move();
        _this.drawCherry();
        return _this.detectCollision(_this.snake.parts[0][0], _this.snake.parts[0][1], _this.snake.width, _this.snake.height, _this.cherry.x, _this.cherry.y, _this.cherry.width, _this.cherry.height);
      }, 1000 / this.options.fps);
    };

    Snake.prototype.generateCherry = function() {
      this.cherry.x = this.getRandomInt(0, (this.options.canvasWidth / this.cherry.width) - 1) * this.cherry.width;
      this.cherry.y = this.getRandomInt(0, (this.options.canvasHeight / this.cherry.height) - 1) * this.cherry.height;
      return this.drawCherry();
    };

    Snake.prototype.getRandomInt = function(min, max) {
      return Math.floor(Math.random() * (max - min + 1)) + min;
    };

    Snake.prototype.drawCherry = function() {
      this.ctx.fillStyle = this.cherry.colour;
      return this.ctx.fillRect(this.cherry.x, this.cherry.y, this.cherry.width, this.cherry.height);
    };

    Snake.prototype.drawScore = function() {
      this.ctx.fillStyle = "green";
      this.ctx.font = "bold 22px sans-serif";
      return this.ctx.fillText(this.score.points, 570, 30);
    };

    Snake.prototype.updateScore = function() {
      return this.score.points += 1;
    };

    Snake.prototype.drawSnakePart = function(x, y) {
      this.ctx.fillStyle = "rgba(0, 0, 200, 1)";
      return this.ctx.fillRect(x, y, 25, 25);
    };

    Snake.prototype.generateSnake = function() {
      var _this = this;
      return _.each(this.snake.parts, function(num) {
        return _this.drawSnakePart(num[0], num[1]);
      });
    };

    Snake.prototype.eatCherry = function() {
      return this.snake.parts.unshift([this.cherry.x, this.cherry.y]);
    };

    Snake.prototype.moveDown = function() {
      var newX, newY;
      this.snake.parts.pop();
      newX = this.snake.parts[0][0];
      newY = this.snake.parts[0][1] + this.snake.moveVal;
      this.snake.parts.unshift([newX, newY]);
      this.snake.currentDirection = 'down';
      return this.generateSnake();
    };

    Snake.prototype.moveUp = function() {
      var newX, newY;
      this.snake.parts.pop();
      newX = this.snake.parts[0][0];
      newY = this.snake.parts[0][1] - this.snake.moveVal;
      this.snake.parts.unshift([newX, newY]);
      this.snake.currentDirection = 'up';
      return this.generateSnake();
    };

    Snake.prototype.moveLeft = function() {
      var newX, newY;
      this.snake.parts.pop();
      newX = this.snake.parts[0][0] - this.snake.moveVal;
      newY = this.snake.parts[0][1];
      this.snake.parts.unshift([newX, newY]);
      this.snake.currentDirection = 'left';
      return this.generateSnake();
    };

    Snake.prototype.moveRight = function() {
      var newX, newY;
      this.snake.parts.pop();
      newX = this.snake.parts[0][0] + this.snake.moveVal;
      newY = this.snake.parts[0][1];
      this.snake.parts.unshift([newX, newY]);
      this.snake.currentDirection = 'right';
      return this.generateSnake();
    };

    Snake.prototype.move = function() {
      switch (this.snake.currentDirection) {
        case 'up':
          return this.moveUp();
        case 'down':
          return this.moveDown();
        case 'right':
          return this.moveRight();
        case 'left':
          return this.moveLeft();
      }
    };

    Snake.prototype.checkKey = function(e) {
      switch (e.keyCode) {
        case 40:
          return this.moveDown();
        case 38:
          return this.moveUp();
        case 37:
          return this.moveLeft();
        case 39:
          return this.moveRight();
        default:
          return console.log('other');
      }
    };

    Snake.prototype.detectCollision = function(x1, y1, w1, h1, x2, y2, w2, h2) {
      w2 += x2;
      w1 += x1;
      if (x2 > w1 || x1 > w2) {
        return false;
      }
      h2 += y2;
      h1 += y1;
      if (y2 > h1 || y1 > h2) {
        return false;
      }
      return this.collisionDetected();
    };

    Snake.prototype.collisionDetected = function() {
      this.eatCherry();
      this.generateCherry();
      return this.updateScore();
    };

    return Snake;

  })();

  if (typeof window !== "undefined" && window !== null) {
    window.Snake = Snake;
  }

}).call(this);
