function toggleTheme(){

    let theme = localStorage.getItem("theme");
	console.log("JS Loaded");
    if(theme === "dark"){
        document.body.classList.remove("dark");
        document.body.classList.add("light");
        localStorage.setItem("theme","light");
    }else{
        document.body.classList.remove("light");
        document.body.classList.add("dark");
        localStorage.setItem("theme","dark");
    }

}

window.onload = function(){

    let savedTheme = localStorage.getItem("theme");

    if(savedTheme === "dark"){
        document.body.classList.add("dark");
        document.body.classList.remove("light");
    }

}

function toggleTheme(){

let body = document.body;
let icon = document.querySelector(".theme-toggle");

if(body.classList.contains("dark")){
body.classList.remove("dark");
body.classList.add("light");
icon.textContent = "🌙";
}else{
body.classList.remove("light");
body.classList.add("dark");
icon.textContent = "☀";
}

}