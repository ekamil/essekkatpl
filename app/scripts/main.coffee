class ButtonGetter
    constructor: (@trigger, @dest, @src) ->
        @properties =
            cached: false

    activate: ->
        if not @cached
            @dest.load @src
            @cached = true
        @dest.show()
        @active = true

    deactivate: ->
        @dest.hide()
        @active = false
        
    listen: ->
        @trigger.on 'click', (event) =>
            if @active
                @deactivate()
            else
                @activate()


class GPGButton extends ButtonGetter
    activate: ->
        super
        @trigger.html("Ukryj klucz")

    deactivate: ->
        super
        @trigger.html("Pokaż klucz")

    listen: ->
        super
        $('.nav a').on 'click', (e) =>
            if not e.target?.href?.split('#')[1] != 'gpg'
                @deactivate()


class CVTab extends ButtonGetter
    constructor: (f) ->
        super $("a[href=##{f}]"), $("##{f}"), "/files/#{f}.html"

    load: ->
        if not @cached
            @dest.load @src
            @cached = true

    listen: ->
        @trigger.on 'shown.bs.tab', (event) =>
            unless @cached
                @load()


# main
$('a[data-toggle="tab"]').on 'shown.bs.tab', (e) ->
        $('.jumbotron').hide()


# location hash
$(document).on 'click.bs.tab.data-api', '[data-toggle="tab"], [data-toggle="pill"]', (e) ->
    if e.target.href
        location.href = e.target.href
    else
        location.href = '#'


$('a[href="#"]').on 'click', (e) ->
    $('.jumbotron').show()
    $('ul.nav li.active').removeClass 'active'
    $('.tab-pane.active').removeClass 'active'
    e.preventDefault()


window.onload = () ->
    if window.location.hash
        hash = window.location.hash
        $("a[href=#{hash}]")?.tab('show')
    else
        hash = window.location
        $("a[href=#{hash}]")?.tab('show')


(new GPGButton $('#pubkey-show'), $("#pubkey"), 'files/kamil_e.asc').listen()
(new CVTab('cv-pl')).listen()
(new CVTab('cv-en')).listen()
