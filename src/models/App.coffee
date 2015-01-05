# TODO: Refactor this model to use an internal Game Model instead
# of containing the game logic directly.
class window.App extends Backbone.Model
  initialize: ->
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()
  #listen to win/loss events
    @on 'busted' =>
      console.log @

      #if player == buster

      #dealer win
    #if dealer == buster
      #player win
    #else
      #dealer <=> player
        #win/psuh


  #case player win
  #case dealer win
  #case tie



