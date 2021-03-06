# =require '../backbone.paginator'

class @Teeble.ClientCollection extends Backbone.Paginator.clientPager

    sortDirections: {}

    default_paginator_core:
        dataType: 'json'
        url: ->
            @url()


    default_paginator_ui:
        sortColumn: ''
        sortDirection: 'desc'
        firstPage: 1
        currentPage: 1
        perPage: 10
        pagesInRange: 3

    initialize: =>
        @paginator_ui = _.extend( {}, @default_paginator_ui, @paginator_ui )
        @paginator_core = _.extend( {}, @default_paginator_core, @paginator_core )
        super

    whereAll: (attrs) =>
        if _.isEmpty(attrs)
            return []
        return _.filter @origModels, (model) ->
            for key, value of attrs
                if value isnt model.get(key)
                    return false
            return true

    getFromAll: (obj) =>
        unless obj?
            return undefined

        id = obj.id or obj.cid or obj
        @_byId[id] or _.findWhere(@origModels, {id})

    eachAll: =>
        _.each.call _, (@origModels ? @models), arguments...
