$(".share").click(function (e) {
    if (e.target.tagName === "INPUT") {
        e.preventDefault();

        var btn = $("input[type='button'][name='" + e.target.name + "']");
        btn.click();
    }
});

function share_it(id, path) {
    var username = prompt("Share with");
    if (username == null)
        return;
    $.ajax({
        type: 'POST',
        data: {
            authenticity_token: "<%= form_authenticity_token %>",
            id: id,
            username_to: username
        },
        dataType: 'json',
        url: path,
        success: function (res) {
        },
        error: function (event, xhr, data, status) {
            alert(event.responseJSON.error);
        }
    });
}