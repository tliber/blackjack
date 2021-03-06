class window.Hand extends Backbone.Collection
  model: Card

  initialize: (array, @deck, @isDealer) ->
    @on 'reveal', @reveal, @

  stand: ->

    @trigger 'reveal', @

    #TODO: needs logic
    console.log("in stand")

  score: 0,

  hit: ->
    @add(@deck.pop())

  hasAce: -> @reduce (memo, card) ->
    memo or card.get('value') is 1
  , 0

  minScore: -> @reduce (score, card) ->
    score + if card.get 'revealed' then card.get 'value' else 0
  , 0

  stand: ->
    if @isDealer
      @at(0).flip()
      while @scores() < 17
        @hit()
    @score = @scores()
    # @trigger 'showdown'
    #trigger compare hands

  # busted: ->
  # scores() == 'Bust!'

  scores: ->
    # The scores are an array of potential scores.
    # Usually, that array contains one element. That is the only score.
    # when there is an ace, it offers you two scores - the original score, and score + 10.

    #fred's awesome array
    # [@minScore(), @minScore() + 10 * @hasAce()]
    if @minScore() > 21
      #TO DO: trigger @loss
      @trigger 'busted'
      return 'Bust!'


    unless @hasAce()
      return @minScore()
    score = @minScore()
    aces = [1..@hasAce()]
    for count in aces
      if score + 10 <= 21
        score = score + 10
    #if two cards and score is 21, trigger blackjack
    if @.length is 2 and score is 21
      score = 'Blackjack!'
    score
