PoliceApplication = {};
const form = document.getElementById("form");

PoliceApplication.EventManager = function(event) {
    let data = event.data;
    PoliceApplication[data.event] && PoliceApplication[data.event](data.data || {});
};

PoliceApplication.PostManager = function(event, data) {
    $.post("https://p1_policeapplication/EventManager", JSON.stringify({
        event: event,
        data: data || {}
    }));
};

PoliceApplication.OpenWindow = function() {
    $(".container").show();
}

PoliceApplication.CloseWindow = function() {
    $(".container").hide();
}

$("#close").click(function() {
    PoliceApplication.CloseWindow();
    PoliceApplication.PostManager("Exit");
    return;
});

submitInformation = function() {
    let data = {
        name: $("#name").val(),
        birthdate: $("#birthdate").val(),
        discordname: $("#discord-name").val(),
        lived_here: $("#lived-here").val(),
        xp_police: $("#xp-police").val(),
        veh_license: $("#veh-license").val(),
        info_you: $("#info-you").val(),
        logic_thinking: $("#logic-thinking").val(),
        good_cop: $("#good-cop").val(),
        police_tasks: $("#police-tasks").val(),
        accept_you: $("#accept-you").val(),
        plans: $("#plans").val(),
        in_duty: $("#in-duty").val(),
        additions: $("#additions").val(),
    }
    PoliceApplication.PostManager("ReceivedApplication", data);
    PoliceApplication.CloseWindow();
};

form.addEventListener("submit", submitInformation);
window.addEventListener("message", PoliceApplication.EventManager);