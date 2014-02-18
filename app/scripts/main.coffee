$('a[data-toggle="tab"]').on 'shown.bs.tab', (e) ->
        $('.jumbotron').hide()

$('a[href="#"]').on 'click', (e) ->
    $('.jumbotron').show()
    $('ul.nav li.active').removeClass('active')
    $('.tab-pane.active').removeClass('active')
    e.preventDefault()


class Toggler
    constructor: (@btn, @dst) ->
        @properties =
            active: false
            cached: false

    getData: ->
        if not @cached
            $.get "/files/KamilE.asc", (data) =>
                @dst.html(data)
                @cached = true
        @btn.html("Ukryj klucz")
        @dst.show()

    clear: ->
        @dst.hide()
        @btn.html("Pokaż klucz")

    listen: ->
        @btn.on 'click', (event) =>
            if @active
                @active = false
                @clear()
            else
                @active = true
                @getData()


toggler = new Toggler $('#pubkey-show'), $("#pubkey")
toggler.listen()


cvHandler = (f) ->
    bt = $("a[href=##{f}]")
    target = $("##{f}")
    bt.on 'shown.bs.tab', (e) ->
        unless target.hasClass 'cached'
            target.load "/#{f}.txt"
            target.addClass 'cached'


cvHandler('cv-pl')
cvHandler('cv-en')
