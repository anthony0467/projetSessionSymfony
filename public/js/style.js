function myFunction() {
    var x = document.getElementById("myLinks");
    if (x.style.display === "block") {
      x.style.display = "none";
    } else {
      x.style.display = "block";
    }
  }

// alert message formateur et formation effacer
 
  function alertSupp(e) {
    if (!confirm('En cliquant, vous effacez également toutes les sessions qui lui sont rattachées. Voulez-vous continuer ?')) {
      e.preventDefault();
      e.stopPropagation();
      return false;
    }
    // Si l'utilisateur clique sur "Oui", la fonction ne renvoie rien et l'action par défaut se produira
  }

// alert supprimer une categorie

  function alertSuppCat(e) {
    if (!confirm('En cliquant, vous effacez également tous les modules  qui lui sont rattachées. Voulez-vous continuer ?')) {
      e.preventDefault();
      e.stopPropagation();
      return false;
    }
    // Si l'utilisateur clique sur "Oui", la fonction ne renvoie rien et l'action par défaut se produira
  }