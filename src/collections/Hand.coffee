class window.Hand extends Backbone.Collection
  model: Card

  initialize: (array, @deck, @isDealer) ->

  hit: ->
    @add(@deck.pop())

  hasAce: -> @reduce (memo, card) ->
    memo or card.get('value') is 1
  , 0

  minScore: -> @reduce (score, card) ->
    score + if card.get 'revealed' then card.get 'value' else 0
  , 0

  scores: ->
    # The scores are an array of potential scores.
    # Usually, that array contains one element. That is the only score.
    # when there is an ace, it offers you two scores - the original score, and score + 10.
    #fred's awesome array
    # [@minScore(), @minScore() + 10 * @hasAce()]
    unless @hasAce()
      return @minScore()
    score = @minScore()
    aces = [1..@hasAce()]
    for count in aces
      if score + 10 <= 21
        score = score + 10
    score


