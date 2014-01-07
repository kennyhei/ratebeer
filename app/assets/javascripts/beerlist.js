var BEERS = {};

BEERS.show = function (){

    $("#beertable tr:gt(0)").remove()

    var table = $("#beertable");

    $.each(BEERS.list, function (index, beer) {

        table.append('<tr>'
            + '<td>' + beer.name + '</td>'
            + '<td>' + beer.style.name + '</td>'
            + '<td>' + beer.brewery.name + '</td>'
            + '</tr>');
    });
};

BEERS.compare = function (a, b) {

    if (a.toUpperCase() === b.toUpperCase()) {
        return 0;
    }

    return (a.toUpperCase() > b.toUpperCase() ? 1 : -1)
}

BEERS.sort_by_name = function () {

    BEERS.list.sort( function(a, b) {
        return BEERS.compare(a.name, b.name);
    });
};

BEERS.sort_by_style = function () {

    BEERS.list.sort( function(a, b) {
        return BEERS.compare(a.style.name, b.style.name);
    });
};

BEERS.sort_by_brewery = function () {

    BEERS.list.sort( function(a, b) {
        return BEERS.compare(a.brewery.name, b.brewery.name);
    });
};

$(document).ready(function () {
    $("#name").click(function (e) {

        BEERS.sort_by_name();
        BEERS.show();
        e.preventDefault();
    });

    $("#style").click(function (e) {
        console.log("MATAFAKAA")
        BEERS.sort_by_style();
        BEERS.show();
        e.preventDefault();
    });

    $("#brewery").click(function (e) {
        BEERS.sort_by_brewery();
        BEERS.show();
        e.preventDefault();
    });

    if ($('#beertable').length > 0) {
        $.getJSON('beers.json', function (beers) {
            BEERS.list = beers;
            BEERS.sort_by_name();
            BEERS.show();
        });
    }
});