factorio_facts_header = [[<html>
<head>
    <meta http-equiv="refresh" content="5">
    <style>
        body {
            background-color: #]]

factorio_facts_header_2 = [[;
}
.VisibleContent{
    color: #]]

factorio_facts_header_3 = [[;
font-size: ]]

factorio_facts_pre_json = [[px;
}
</style>
</head>
<body>
<div>
<span class="VisibleContent" id="EvolutionHeader">Evolution:</span><span class="VisibleContent" id="EvolutionValue">4%</span>
</div>
<div class="VisibleContent" id="AmmoVal"></div>

<script>
obj = JSON.parse(']]

factorio_facts_post_json = [[');
document.getElementById("EvolutionValue").innerHTML = obj.evolution.evolution.toFixed(2) + "%";
ammoDest = document.getElementById("AmmoVal");
var ammoHtml = "<table>";

obj.players.forEach((playerRef) => {
    ammoHtml += "<tr><td class=\"VisibleContent\">"+playerRef.name+"</td>";
    playerRef.slots.forEach(slot => {
        if(slot.slot!=1){
            ammoHtml+="</tr><tr><td/>"
        }
        if(slot.name != "Empty"){
            ammoHtml += "<td class=\"VisibleContent\">" + slot.name + ": (" + slot.perc.toFixed(2) + "%)</td>"
        }else{
            ammoHtml +="<td class=\"VisibleContent\">Empty</td>"
        }
    });  
    ammoHtml += "</tr></table>"
});

ammoDest.innerHTML = ammoHtml;

</script>
</body>
</html>]]