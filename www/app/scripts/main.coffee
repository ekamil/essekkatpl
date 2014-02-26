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
        console.log @dest
        super(@trigger, @dest, @src)

    activate: ->
        console.log @dest
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


class CVTab
    constructor: (f) ->
        @trigger = $ ".nav a[href=##{f}]"
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
        location.href = e.target.href
    else
        location.href = '#'


$('document').ready = () ->
    try
        if window.location.hash
            hash = window.location.hash
            $(".nav a[href=#{hash}]")?.tab('show')
        else
            hash = '#'
            $(".nav a[href=#{hash}]")?.tab('show')
    catch error
        console.log error
        return


$('.jumbotron a[role="button"]').on 'click', (event) ->
    if this.hash
        $(".nav a[href=#{this.hash}]")?.tab('show')


$('textarea.target').on 'click', (event) ->
    this.focus()
    this.select()



(new GPGButton $('#pubkey'), 'files/kamil_e.asc').listen()
(new GPGButton $('#pubkey-apt'), 'files/debian.asc').listen()
(new CVTab('cv-pl')).listen()
(new CVTab('cv-en')).listen()
