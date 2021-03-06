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
    constructor: (@trigger, @src) ->
        @dest = @trigger.siblings('.target')
        super(@trigger, @dest, @src)

    activate: ->
        super
        @trigger.html("Ukryj")

    deactivate: ->
        super
        @trigger.html("Pokaż")

    listen: ->
        super
        $('.nav a').on 'click', (e) =>
            if not e.target?.href?.split('#')[1] != 'gpg'
                @deactivate()


class CVTab
    constructor: (f) ->
        @trigger = $ "a[href=##{f}]"
        @dest = $ "##{f} > .cv-target"
        @src = "/files/#{f}.html"
        @cached = false

    listen: ->
        @trigger.on 'show.bs.tab', (event) =>
            unless @cached
                @dest.load @src
                @cached = true
            @postload()

    postload: ->
        @dest.children('table').addClass 'table'


# main
$('a[data-toggle="tab"]').on 'shown.bs.tab', (e) ->
        $('.jumbotron').hide()


$('.nav a[href="#"]').on 'click', (e) ->
    $('.jumbotron').show()
    $('ul.nav li.active').removeClass 'active'
    $('.tab-pane.active').removeClass 'active'
    e.preventDefault()


$('textarea.pubkey-apt-target').on 'click', (e) ->
    this.focus()
    this.select()


# location hash
$(document).on 'click.bs.tab.data-api', '[data-toggle="tab"], [data-toggle="pill"]', (e) ->
    if e.target.href
        _href = e.target.href
    else
        _href = '#'
    history.pushState null, null, _href


# navigate to a tab when the history changes
window.onpopstate = (e) ->
    _hash = window.location.hash
    if _hash
        $(".nav a[href=#{_hash}]").tab('show')
    else
        $('.nav a[href=#]')?.click()


$.ready = () ->
    try
        if window.location.hash
            hash = window.location.hash
            $(".nav a[href=#{hash}]")?.tab('show')
    catch error
        console.log error
        return


$('textarea.target').on 'click', (event) ->
    this.focus()
    this.select()


(new GPGButton $('#pubkey'), 'files/kamil_e.asc').listen()
(new GPGButton $('#pubkey-transition'), 'files/transition_2016-05-14-signed.txt').listen()
(new CVTab('cv-pl')).listen()
(new CVTab('cv-en')).listen()
