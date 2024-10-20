<%@ page language="java" import="java.util.*"  import="metier.Appelsoffres" import="metier.Chefprojet" import="java.text.DecimalFormat"  contentType="text/html; charset=UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title> Gestion des Marchés Publics </title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<script src="style/js/bootstrap.min.js"></script>
	<link href="css/font-awesome.min.css" rel="stylesheet">	
	<link href="templatemo_style.css" rel="stylesheet" type="text/css" />
	<script type="text/javascript" src="jquery.js"></script>   
	<link rel="stylesheet" href="jquery-ui-1.10.4/themes/base/jquery-ui.css">
	<script src="jquery-ui-1.10.4/jquery-1.10.2.js"></script>
    <script src="jquery-ui-1.10.4/ui/jquery-ui.js"></script>
    <link href="awesome-bootstrap-checkbox-master/awesome-bootstrap-checkbox.css" rel="stylesheet">        
    <style>
	.ui-widget-header,.ui-state-default, ui-button {          
    background:#b9cd6d;
    border: 1px solid #b9cd6d;        
    font-weight: bold;
    filter: progid:DXImageTransform.Microsoft.gradient( startColorstr='#3774a0', endColorstr='#316e9b',GradientType=0 ); /* IE6-9 */
    color: #000000;
    padding: 2px 6px;
    border-radius: 5px;
    }
    .ui-widget-content { background: url(images/img06.jpg); }
    </style>
	
	<%
	Integer  idFonctionnaire = 0;
	if ( (Integer) session.getAttribute("idFonctionnaire") != null){
      idFonctionnaire = (Integer) session.getAttribute("idFonctionnaire");  
    } 
    String roleChefDeProjet="Non";
	List listeChefDeProjet=new ArrayList<Chefprojet>();
	if ( (ArrayList<Chefprojet>) session.getAttribute("listeChefDeProjet") != null){
      listeChefDeProjet = (ArrayList<Chefprojet>) session.getAttribute("listeChefDeProjet"); 
      for(int i=0;i<listeChefDeProjet.size();i++)
	  {		
			if(  (((ArrayList<Chefprojet>) listeChefDeProjet).get(i).getIdFonctionnaire()) == idFonctionnaire )
			{
				roleChefDeProjet="Oui";			
			}
	  }
	}  
	String   role = "";
	if ((String) session.getAttribute("role") != null){
      role = (String) session.getAttribute("role");  
    } 
    System.out.println("chef de projet : "+roleChefDeProjet); 
    if( ! ( roleChefDeProjet.equals("Oui") || role.equals("Employé Service Marchés") || role.equals("Représentant Chef Service Marchés") 
    || role.equals("Chef Service Marchés") || role.equals("Chef Division Equipement") || role.equals("Président") )) {
    String site = new String("../../PageNonAutorisee.jsp");
    response.setStatus(response.SC_MOVED_TEMPORARILY);
    response.setHeader("Location", site); 
    }
    %>	
	<% 
    Appelsoffres appelsoffres=null;
    appelsoffres=(Appelsoffres)session.getAttribute("Appelsoffres"); 
    Integer idAppelOffre=0; 
    String numAppelOffre="";
	String anneeAppelOffre="";
	String objetAppelOffre="";
	String categorieAo="";
	String statutActuel="";
	String dateOp="";
	String typeBordereau="Bordereau des prix détail estimatif";
	String tauxTva="20";
	Integer tauxTva2=20;
	Integer idProgramme = 0;
	String numMarches="";
	String anneeMarches="";
    if (appelsoffres != null) {
    idAppelOffre=appelsoffres.getIdAppelOffre();
    numMarches=appelsoffres.getNumMarches().toString();
	anneeAppelOffre=appelsoffres.getAnneeAppelOffre().toString();
	objetAppelOffre=appelsoffres.getObjetAppelOffre();
	anneeMarches=appelsoffres.getAnneeMarches().toString();
	numMarches=appelsoffres.getNumMarches().toString()+" / "+anneeMarches;
	dateOp=appelsoffres.getDateOp();
	categorieAo=appelsoffres.getCategorieAo();
	statutActuel=appelsoffres.getStatutActuel();
	typeBordereau=appelsoffres.getTypeBordereau();	
	idProgramme=appelsoffres.getIdProgramme();
	}
	String natureAo = "";
	if (appelsoffres != null) {
	natureAo = appelsoffres.getNatureAo();
	}
	if( ! (natureAo.equals("Marché")) ) {
    String site = new String("../../DossierAppelOffreNonOuvert.jsp");
    response.setStatus(response.SC_MOVED_TEMPORARILY);
    response.setHeader("Location", site); 
    }
    %>
	<script type="text/javascript">
	$(function(){
     
      $("#site_title").load("menuTitre.html"); 
      $("#site_title2").load("menuTitre2.html"); 
      $("#chargement").load("menuChargement.html");
      $("#chargement").hide();
      $("#bienAjouter").hide();
      $("#prixGlobal").hide(); $("#prixDetail3").hide(); 
      
              var typePrix = $(typeBordereau).val();
              if(typePrix =="Bordereau du prix global" )
              {
               $("#prixGlobal").show();$("#prixGlobal2").show();
               $("#prixDetail2").hide();$("#prixDetail3").hide();$("#prixDetail4").hide();
               $("#prixDetail6").hide();
              }else
              {
                $("#prixGlobal").hide();$("#prixGlobal2").hide();
                $("#prixDetail2").show();$("#prixDetail3").show();$("#prixDetail4").show();
                $("#prixDetail6").show();
              } 
      
      $("#AjouterBordereauPrixAO").hide(); $("#BordereauPrix1").hide(); 
      $("#dialog").hide();$("#dialog2").hide();$("#dialog3").hide();
      $("#dialog4").hide();$("#dialog5").hide();$("#dialogDonnees").hide();$("#dialogDonnees2").hide();  
      $("#donneeAO").hide();$("#pageNonAutorisee").hide(); 
      $("#dialogChefDeProjet4").hide();$("#dialogChefDeProjet5").hide();
      $("#interfaceAjouterCopieCPS").hide();$("#dialogBienEnregistrer").hide();
                               	             
	$('#BtnAvisAO').click(function  BtnAvisAO() 
    {           
        $("#chargement").show();
      
        $.ajax( 
        {    
            type: "POST", 
            enctype:"multipart/form-data",
            url: "exporterAvisAO.do", 
            data:$("#formAjouterBordereauPrix").serialize(),
            dataType: "html", 
            //timeout : 4000, 
            error: function()
            { 
               alert("invalid"); 
               $("#chargement").hide();                  
            }, 
            beforeSend : function() 
            { 
            }, 
             success: function(html) 
            { 
               $("#chargement").hide(); 
               window.location.replace("../../MarchesPublics/Fichiers/AvisAppelOffres.docx");                         
            } 
         });
       
    });
    
    $('#BtnDonneesGenerales').click(function BtnDonneesGenerales()   
    {   
        $("#BtnDonneesGenerales").addClass("active btn-info");
        $("#BtnChefDeProjet").removeClass("active btn-info");
        $("#BtnBordereauPrix").removeClass("active btn-info");
        $("#BtnNoteDeFinancement").removeClass("active btn-info"); 
        $("#BtnValidationCPS").removeClass("active btn-info");    
        $('#BordereauPrix1').hide();$("#listeChefDeProjet").hide();$("#listeNoteDeFinancement").hide();
        $("#AjouterBordereauPrixAO").hide();
        $("#donneeAO").show(); $("#pageNonAutorisee").hide();      
        $('#CPS').hide();
        $('#CPS').removeClass("content_section_box16");
        $('#CPS').removeClass("content_section_box_content16");
        $('#ChefDeProjetMarches').hide();
        $('#ChefDeProjetMarches').removeClass("content_section_box16");
        $('#ChefDeProjetMarches').removeClass("content_section_box_content16"); 
        
               
    });
    $('#BtnNoteDeFinancement').click(function BtnNoteDeFinancement() 
    { 
        $("#BtnNoteDeFinancement").addClass("active btn-info");
        $("#BtnChefDeProjet").removeClass("active btn-info");
        $("#BtnDonneesGenerales").removeClass("active btn-info");
        $("#BtnBordereauPrix").removeClass("active btn-info");
        $("#BtnValidationCPS").removeClass("active btn-info");  
        $('#BordereauPrix1').hide();
        $("#AjouterBordereauPrixAO").hide();
        $('#donneeAO').hide(); $("#pageNonAutorisee").hide(); 
        $('#donneeAO').removeClass("content_section_box16");
        $('#donneeAO').removeClass("content_section_box_content16");        
        $('#CPS').hide();
        $('#CPS').removeClass("content_section_box16");
        $('#CPS').removeClass("content_section_box_content16"); 
        $('#ChefDeProjetMarches').show();   
        $("#chargement").show();
      
        $.ajax( 
        {    
            type: "POST", 
            enctype:"multipart/form-data",
            url: "rechercherMarches.do", 
            data:$("#formNoteDeFinancement").serialize(),
            dataType: "html", 
            //timeout : 4000, 
            error: function()
            { 
               alert("invalid"); 
               $("#chargement").hide();                  
            }, 
            beforeSend : function() 
            { 
            }, 
             success: function(html) 
            { 
               $("#chargement").hide();              
               $("#listeNoteDeFinancement").html(html); 
               $("#listeNoteDeFinancement").show();  
               $("#listeBordereauPrix").hide();   
               $("#listeChefDeProjet").hide(); 
               $("#listeValidationCPS").hide();                              
            } 
         });  
    });
    $('#BtnChefDeProjet').click(function BtnChefDeProjet() 
    { 
        $("#BtnChefDeProjet").addClass("active btn-info");
        $("#BtnDonneesGenerales").removeClass("active btn-info");
        $("#BtnNoteDeFinancement").removeClass("active btn-info");
        $("#BtnBordereauPrix").removeClass("active btn-info");  
        $("#BtnValidationCPS").removeClass("active btn-info");  
        $('#BordereauPrix1').hide();
        $("#AjouterBordereauPrixAO").hide();
        $('#donneeAO').hide(); $("#pageNonAutorisee").hide(); 
        $('#donneeAO').removeClass("content_section_box16");
        $('#donneeAO').removeClass("content_section_box_content16");        
        $('#CPS').hide();
        $('#CPS').removeClass("content_section_box16");
        $('#CPS').removeClass("content_section_box_content16"); 
        $('#ChefDeProjetMarches').show();

        $("#chargement").show();
      
        $.ajax( 
        {    
            type: "POST", 
            enctype:"multipart/form-data",
            url: "rechercherChefDeProjet.do", 
            data:$("#formChefDeProjet").serialize(),
            dataType: "html", 
            //timeout : 4000, 
            error: function()
            { 
               alert("invalid"); 
               $("#chargement").hide();                  
            }, 
            beforeSend : function() 
            { 
            }, 
             success: function(html) 
            { 
               $("#chargement").hide();              
               $("#listeChefDeProjet").html(html); 
               $("#listeChefDeProjet").show();   
               $("#listeBordereauPrix").hide(); 
               $("#listeNoteDeFinancement").hide(); 
               $("#listeValidationCPS").hide();                      
            } 
         });  
    });
    $('#BtnValidationCPS').click(function BtnValidationCPS() 
    { 
        $("#BtnValidationCPS").addClass("active btn-info");
        $("#BtnChefDeProjet").removeClass("active btn-info");
        $("#BtnDonneesGenerales").removeClass("active btn-info");
        $("#BtnNoteDeFinancement").removeClass("active btn-info");
        $("#BtnBordereauPrix").removeClass("active btn-info");  
        $('#BordereauPrix1').hide();
        $("#AjouterBordereauPrixAO").hide();
        $('#donneeAO').hide(); $("#pageNonAutorisee").hide(); 
        $('#donneeAO').removeClass("content_section_box16");
        $('#donneeAO').removeClass("content_section_box_content16");        
        $('#CPS').hide();
        $('#CPS').removeClass("content_section_box16");
        $('#CPS').removeClass("content_section_box_content16"); 
        $('#ChefDeProjetMarches').show();

        $("#chargement").show();
      
        $.ajax( 
        {    
            type: "POST", 
            enctype:"multipart/form-data",
            url: "rechercherValidationCPS.do", 
            data:$("#formValidationCPS").serialize(),
            dataType: "html", 
            //timeout : 4000, 
            error: function()
            { 
               alert("invalid"); 
               $("#chargement").hide();                  
            }, 
            beforeSend : function() 
            { 
            }, 
             success: function(html) 
            { 
               $("#chargement").hide();              
               $("#listeValidationCPS").html(html); 
               $("#listeValidationCPS").show();   
               $("#listeBordereauPrix").hide(); 
               $("#listeNoteDeFinancement").hide();
               $("#listeChefDeProjet").hide();                     
            } 
         });  
    });
	$('#BtnBordereauPrix').click(function BtnBordereauPrix() 
    {        
        $("#BtnBordereauPrix").addClass("active btn-info");
        $("#BtnChefDeProjet").removeClass("active btn-info");
        $("#BtnDonneesGenerales").removeClass("active btn-info");
        $("#BtnNoteDeFinancement").removeClass("active btn-info"); 
        $("#BtnValidationCPS").removeClass("active btn-info");   
        $("#donneeAO").hide(); $("#pageNonAutorisee").hide(); 
        $("#listeChefDeProjet").hide(); $("#listeNoteDeFinancement").hide();     
        $("#chargement").show();
        $('#CPS').hide();
        $('#CPS').removeClass("content_section_box16");
        $('#CPS').removeClass("content_section_box_content16"); 
        $('#ChefDeProjetMarches').hide();
        $('#ChefDeProjetMarches').removeClass("content_section_box16");
        $('#ChefDeProjetMarches').removeClass("content_section_box_content16"); 
        
        <%
        if( ! (roleChefDeProjet.equals("Oui") || role.equals("Chef Division Equipement") )) { %>
          $("#chargement").hide();
          $("#pageNonAutorisee").show(); 
        <% }else {%>
        $("#AjouterBordereauPrixAO").show();          
        $.ajax( 
        {    
            type: "POST", 
            enctype:"multipart/form-data",
            url: "rechercherBordereauPrix.do", 
            data:$("#formAjouterBordereauPrix").serialize(),
            dataType: "html", 
            //timeout : 4000, 
            error: function()
            { 
               alert("invalid"); 
               $("#chargement").hide();                  
            }, 
            beforeSend : function() 
            { 
            }, 
             success: function(html) 
            { 
               $("#chargement").hide();              
               $("#listeBordereauPrix").html(html); 
               $("#BordereauPrix1").show();  
               $("#listeBordereauPrix").show();            
            } 
         });
         <%} %> 
    });
    $('#BtnCPS').click(function BtnCPS() 
    {         
        $("#chargement").show();
        $('#BordereauPrix1').hide(); $("#pageNonAutorisee").hide(); 
        $("#AjouterBordereauPrixAO").hide();
        $("#donneeAO").hide();   
        $('#CPS').show();
        
        $.ajax( 
        {    
            type: "POST", 
            enctype:"multipart/form-data",
            url: "rechercherArticlesCPS.do", 
            data:$("#formCPS").serialize(),
            dataType: "html", 
            //timeout : 4000, 
            error: function()
            { 
               alert("invalid"); 
               $("#chargement").hide();                  
            }, 
            beforeSend : function() 
            { 
            }, 
             success: function(html) 
            { 
               $("#chargement").hide();              
               $("#listeArticle").html(html); 
               $("#listeArticle").show();              
            } 
         });
       
    });
   $('#exporterCPS3').click(function  exporterCPS() 
    {           
        $("#chargement").show();
      
        $.ajax( 
        {    
            type: "POST", 
            enctype:"multipart/form-data",
            url: "exporterCPS.do", 
            data:$("#formCPS").serialize(),
            dataType: "html", 
            //timeout : 4000, 
            error: function()
            { 
               alert("invalid"); 
               $("#chargement").hide();                  
            }, 
            beforeSend : function() 
            { 
            }, 
             success: function(html) 
            { 
               $("#chargement").hide();                          
            } 
         });
       
    });       
    $('#ajouterBordereauPrix').click(function ajouterBordereauPrix() 
    { 
        $("#chargement").show();        
        var typePrix = $(typeBordereau).val();
        if(typePrix =="Bordereau du prix global" )
        {           
        $("#unite").val("Forfait");
        $("#quantite").val("1.00");
        }
        $.ajax( 
        {    
            type: "POST", 
            enctype:"multipart/form-data",
            url: "ajouterBordereauPrix.do", 
            data:$("#formAjouterBordereauPrix").serialize(),
            dataType: "html", 
            //timeout : 4000, 
            error: function()
            { 
               alert("invalid"); 
               $("#chargement").hide();                  
            }, 
            beforeSend : function() 
            { 
            }, 
             success: function(html) 
            { 
               $("#chargement").hide();              
               $("#listeBordereauPrix").html(html);  
               $("#BordereauPrix1").show();     
            } 
         }); 
    } 
    );
    
    $('#ajoutertypeBordereau').click(function ajoutertypeBordereau() 
    { 
        $("#chargement").show();  
        $.ajax( 
        {    
            type: "POST", 
            enctype:"multipart/form-data",
            url: "ajoutertypeBordereau.do", 
            data:$("#formAjouterBordereauPrix").serialize(),
            dataType: "html", 
            //timeout : 4000, 
            error: function()
            { 
               alert("invalid"); 
               $("#chargement").hide();                  
            }, 
            beforeSend : function() 
            { 
            }, 
             success: function(html) 
            { 
              $("#chargement").hide();              
              var typePrix = $(typeBordereau).val();
              if(typePrix =="Bordereau du prix global" )
              {
               $("#prixGlobal").show();$("#prixGlobal2").show();
               $("#prixDetail2").hide();$("#prixDetail3").hide();$("#prixDetail4").hide();
               $("#prixDetail6").hide();
               $("#unite").val("Forfait");$("#quantite").val("1.00");
              }else
              {
                $("#unite").val("");$("#quantite").val("");
                $("#prixGlobal").hide();$("#prixGlobal2").hide();
                $("#prixDetail2").show();$("#prixDetail3").show();$("#prixDetail4").show();
                $("#prixDetail6").show();
              }  
              $("#dialog5").dialog({
	                           autoOpen: true, 
                               buttons: {
                               Ok: function() {                    
                               $( this ).dialog("close");                     
                               },
                            },
                            width: 420,
                            height: 214,         
                            position: {
			                my: "center", at: "center", of: window, collision: "fit",			      
			                using: function( pos ) {
			     	           var topOffset = $( this ).css( pos ).offset().top;
				               if ( topOffset < 0 ) {
					           $( this ).css( "top", pos.top - topOffset );
				               }
			                }
		                    }              
                            });   
            } 
         }); 
    } 
    );
    
   $('#typeBordereau2').change(function()  {

      var typePrix = $(this).val();
      if(typePrix =="Bordereau du prix global" )
      {
        $("#prixGlobal").show();$("#prixGlobal2").show();
        $("#prixDetail2").hide();$("#prixDetail3").hide();$("#prixDetail4").hide();
        $("#prixDetail6").hide();
        $("#unite").val("Forfait");$("#quantite").val("1.00");
      }else
      {
        $("#unite").val("");$("#quantite").val("");
        $("#prixGlobal").hide();$("#prixGlobal2").hide();
        $("#prixDetail2").show();$("#prixDetail3").show();$("#prixDetail4").show();
        $("#prixDetail6").show();
      }
      
    });
         
    $('#modifierAppelOffre').click(function modifierAppelOffre() 
    { 
        $("#chargement").show();  
        $.ajax( 
        {    
            type: "POST", 
            enctype:"multipart/form-data",
            url: "modifierAppelOffre.do", 
            data:$("#formAjouterAppelOffre").serialize(),
            dataType: "html", 
            //timeout : 4000, 
            error: function()
            { 
               $("#chargement").hide();
               $("#dialogDonnees2").dialog({
	           autoOpen: true, 
               buttons: {
               OK: function() {
                  $("#dialogDonnees2").dialog("close");                   
                  },
               },
               width: 422,
               height: 192,          
               position: {
			       my: "center",
			       at: "center",
			       of: window,
			       collision: "fit",
			       // Ensure the titlebar is always visible
			       using: function( pos ) {
			     	   var topOffset = $( this ).css( pos ).offset().top;
				       if ( topOffset < 0 ) {
					   $( this ).css( "top", pos.top - topOffset );
				       }
			      }
		       }             
               });
               $( "#dialogDonnees2" ).dialog("open");                   
            }, 
            beforeSend : function() 
            { 
            }, 
             success: function(html) 
            { 
               $("#chargement").hide();              
               $("#dialogDonnees").dialog({
	           autoOpen: true, 
               buttons: {
               OK: function() {
                  $("#dialogDonnees").dialog("close");                   
                  },
               },
               width: 422,
               height: 192,          
               position: {
			       my: "center",
			       at: "center",
			       of: window,
			       collision: "fit",
			       // Ensure the titlebar is always visible
			       using: function( pos ) {
			     	   var topOffset = $( this ).css( pos ).offset().top;
				       if ( topOffset < 0 ) {
					   $( this ).css( "top", pos.top - topOffset );
				       }
			      }
		       }             
               });
               $( "#dialogDonnees" ).dialog("open");               
            } 
         }); 
    } 
    );      
     
    $('#deConnecter').click(function deConnecter() 
    { 
        $("#chargement").show();        
        $.ajax( 
        {           
            type: "POST", 
            enctype:"multipart/form-data",
            url: "deConnecter.do", 
            data:$("#formSeConnecter").serialize(),
            dataType: "html", 
            //timeout : 4000, 
            error: function()
            { 
               $("#message").show();
               $("#chargement").hide();                      
            }, 
            beforeSend : function() 
            { 
            }, 
             success: function(html) 
            {              
                $("#chargement").hide();
                window.location.replace("../../GestionMarches/GestionMarchesPublics.jsp");             
            } 
        }); 
    } 
    );
                
    });    
    </script>
	
	</head>
  
  <body>
  <div id="templatemo_container">
<!-- Free CSS Templates @ www.TemplateMo.com -->
	<div id="templatemo_header_panel">
    	<div id="site_title">
        	
        </div>
		<div id="site_title2">
      
        </div>
        <div id="header_links">
        	
        </div>
    </div> <!-- end of header panel -->

    <div id="templatemo_menu"> 
    <ul class="niveau1"> 
           <li><a href="Marches/LancementMarches/ListeMarches.jsp" > <input type="button" class="btn btn-default" value= " Liste des marchés " />  </a></li>           
            <li><a href="AppelsOffres/LancementAO/AjouterAO.jsp" > <input type="button" class="btn btn-default" value= " Nouveau Marché " /> </a></li>           
            <li><a href="AppelsOffres/DossierAO/DossierAO.jsp" > <input type="button" class="btn btn-primary" value= " Dossier Marché " /> </a></li>          
            <li><a href="Marches/ApprobationMarches/ApprobationMarches.jsp"> <input type="button" class="btn btn-default" value= " Approbation " /> </a></li>           
            <li><a href="Marches/EnregistrementMarches/EnregistrementMarches.jsp" class="current2"> <input type="button" class="btn btn-default" value= " Cautions " /> </a></li>            
            <li><a href="Marches/Execution/ExecutionMarches.jsp"> <input type="button" class="btn btn-default" value= " Exécution du marché" /></a></li>
            <li><a href="AppelsOffres/OuvertureDesPlis/OuvertureDesPlis.jsp"> <input type="button" class="btn btn-default" value= " Etat d'avancement" /> </a></li>                    	
            <li><a href="Marches/Depenses.jsp"  > <input type="button" class="btn btn-default" value= " Dépenses " /> </a> </li> 
            <li><a href="GestionPersonnel/GestionPersonnel.jsp"  > <input type="button" class="btn btn-default" value= " Personnels " />  </a> </li>
            <li><a href="GestionPointageChantier/PointageChantier.jsp"  > <input type="button" class="btn btn-default" value= " Pointage chantier " />  </a> </li> 
            <li><a href="GestionMateriels/GestionMateriels.jsp"  > <input type="button" class="btn btn-default" value= " Matériels Chantier" />  </a> </li>
            <li><a href="Marches/ReceptionMarches/ReceptionMarches.jsp" > <input type="button" class="btn btn-default" value= " Réception Marché" /> </a></li>          
    </ul>
    </div> <!-- end of menu -->
	
	<div id="ajouterDossierAO"> 
    <div id="templatemo_content">
            <center> 
            <form id="formRechercherAppelOffre" method="post">           		  		    
            <div class="content_section_box26">
            <div class="content_section_box_content6">
            <center>
            <center>-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------</center> 	       
            <table border="0" bgcolor="#D8D38D"   class="table" width="850"  >
            <tr>
		        <td align="center">  <font color="#0B3573"> N° du marché : </font> <font color="#000000"> <%=numMarches%> </font> </td>	
		        <td align="center">  <font color="#0B3573"> Objet du marché : </font> <font color="#000000"> <%=objetAppelOffre%> </font> </td>		        
			</tr>		       
	        </table>
	        <center>-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------</center> 	        	                     
            </center> 	         
            </div> 
            </div>
            </form> 
            <div class="content_section_box8">
            <div class="content_section_box_content6">                 
                               
                 <table >
	             <tr>	
	                <td><input type="button" id="BtnDonneesGenerales"   class="btn btn-default"  value= " Données Générales du marché " />  </td>          	               
	                <td><input type="button" id="BtnBordereauPrix"   class="btn btn-default"  value= " Bordereau Des Prix" />  </td>              		             	
				 </tr>
		         </table>		         	         	        		                      	        
	             <center>
		         <table bgcolor=""  bordercolor="#000000" class="table " width="1674" border="2">
	             </table>
	             <div id="chargement">               
                 </div>		             
	             </center>
	       </div>
	       </div>             
	             <div id="AjouterBordereauPrixAO">
	             <div class="content_section_box21">
                 <div class="content_section_box_content21">
	             <form id="formAjouterBordereauPrix" method="post"> 
	             <input type="hidden" name="idAppelOffre"  id="idAppelOffre"  value="<%=idAppelOffre%>" size="28"/>					                    
	             <input type="hidden" name="idBordereau"  id="idBordereau"  value="" size="28"/>	
	             <input type="hidden" name="typeBordereau"  id="typeBordereau"  value="Bordereau des prix" size="28"/>					                    	            	            
	             <center>
	             
		         <center> ------------------------------------------------------------</center>
		         <table bgcolor=""  bordercolor="#000000" class="table " width="502" >
		         <tr>	
		            <td> </td>		        
		            <td class="" align="left" > <font color="#000000">----------------------Ajouter un prix au Bordereau des prix ---------------------------</font></td>		
	             </tr>
			     <tr>			        
		            <td class="" align="left" > N° de Prix</td>
				    <td><input type="number" name="numPrix" id="numPrix" class="number_input4"  value="" size="42"/>  </td>				
	             </tr>
	             <tr>  
	                <td class=""  align="left"> Désignation </td>
	                <td class=""  align="left"> <input type="text" name="designation"  id="designation"    value="" size="42"/> </td>				
	             </tr>
	             <tr>  
	                <td class=""  align="left"> Taux de TVA </td>
	                <td class=""  align="left"> <input type="number" name="tauxTva"  id="tauxTva"  class="number_input4"  value="20" size="42"/> </td>				
	             </tr>
	             <tr id="prixDetail1">  
	                <td class=""  align="left"> Unité </td>
	                <td class=""  align="left"> <input type="text" name="unite"  id="unite"   value="U" size="30"/> </td>				
	             </tr>
	             <tr id="prixDetail2">  
	                <td class=""  align="left"> Quantité </td>
	                <td class=""  align="left"> <input type="number" name="quantite"  id="quantite"  class="number_input4"  value="1" size="42"/> </td>				
	             </tr>
	             <tr > 
	                <td id="prixGlobal" class=""  align="left"> Prix Forfaitaire  </td> 
	                <td id="prixDetail3" class=""  align="left"> Prix Unitaire </td>
	                <td class=""  align="left"> <input type="number" name="prixUnitaire"  id="prixUnitaire"  class="number_input3"  value="" size="42"/> </td>				
	             </tr>	             	                 		               
	             <tr>	
	                <td class="" align="left" > </td>            
		            <td><input type="button" id="ajouterBordereauPrix" class="btn btn-default4" value=" Enregistrer " size="35"/>  </td>	        
	             </tr>	             
	             </table>
	             </center>
	             </form>
	             	               
                 </div>                 
	             </div>
	             </div>
	             
                 
	             <div id="BordereauPrix1">	             
	             <div class="content_section_box22">	             
                 <div class="content_section_box_content22">
                 <div id="listeBordereauPrix">  </div>                          
                 </div>                 
	             </div>
	             </div>
	               
	             <div  id="pageNonAutorisee">     
	             <div class="content_section_box16">	             
                 <div class="content_section_box_content16">                     
			        <table   bgcolor=""  bordercolor="" class="table " width="576" align="center"> 
			        <tr>
			        <td align="left"> </td>	     
	                </tr>
			        <tr>	
			        <td align="center"> <font color="#ff0000" > <h2> <b>  Accés à cette page est non autorisée pour cet utilisateur ! </b> </h2> </font>   </td>	    
	                </tr>
	                <tr>
			        <td align="left"> </td>	     
	                </tr>
	                </table>
			     </div>     
                 </div>                 
	             </div>
	             
	             <div id="CPS">	             
	             <div class="content_section_box16">	             
                 <div class="content_section_box_content16">
                 <form id="formCPS" method="post"> 
                 <input type="hidden" name="idAppelOffre"  id="idAppelOffre"  value="<%=idAppelOffre%>" size="28"/>	
                 <input type="hidden" name="idArticle"  id="idArticle"  size="28"/>
                 <input type="hidden" name="texteArticle"  id="texteArticle"  size="28"/>  
                 </form>
                 <div id="listeArticle">                        
	             </div>
                 </div>                 
	             </div>
	             </div>
	             
	             <div id="ChefDeProjetMarches">
	             <div class="content_section_box16">	             
                 <div class="content_section_box_content16">
                 <div id="listeValidationCPS"> </div>
                 <div id="listeChefDeProjet">   </div>
                 <div id="listeNoteDeFinancement"> </div> 
                 <form id="formValidationCPS" method="post">  
	             <input type="hidden" name="idAppelOffre"   value="<%=idAppelOffre%>" />
	             <input type="hidden" name="validerCpsparService" id="validerCpsparService" />  							 
				 <input type="hidden" name="validerCpsparDivision" id="validerCpsparDivision" />  				
	     	     </form>  
	     	<div id ="interfaceAjouterCopieCPS"  title = "Ajouter une copie du CPS" >
            <center>
           	<form id="formAjouterCopieCPS" action="ajouterCopieCPS.do" method="post" enctype="multipart/form-data" >
           	<input type="hidden" name="idAppelOffre"   value="<%=idAppelOffre%>" />      	
           	<table>
		    <tr>
			    <td > Copie de CPS </td>
		        <td><input type="file" name="copieCps"  id="copieCps" value="télécharger" size="35"/>  </td>   
	        </tr>
	        </table>
	        -----------------------------------------------------------------------------        
	        <table>
	        <tr>	           
	            <td> </td> 
		        <td> <input type="submit"  class="btn btn-default" value=" Enregistrer " size="35" />  </td>      
	        </tr>
	        </table>
	        </form>  
	        </center>
	        </div>        
                 <form id="formChefDeProjet" method="post"> 
	             <input type="hidden" name="idAppelOffre"  value="<%=idAppelOffre%>" size="28"/>					                   	                             	            	            	           
				 <input type="hidden" name="idChefDeProjet" id="idChefDeProjet" />  							 
				 <input type="hidden" name="idFonctionnaire" id="idFonctionnaire" />  							 
	             <input type="hidden" name="role"  id="role" />  	              		
	             </form> 
                <form id="formNoteDeFinancement" method="post">  
	            <input type="hidden" name="idAppelOffre"   value="<%=idAppelOffre%>" size="28"/>		
	     	    <input type="hidden" name="typeRecherche"  value="noteDeFinancement" size="28"/> 
	     	    </form> 
	     	    <form id="formAjouterNoteFinancement1" method="post">  
	            <input type="hidden" name="idAppelOffre"   value="<%=idAppelOffre%>" size="28"/>		
	     	    <input type="hidden" name="budgetFinancement"  id="budgetFinancement" />
	     	    <input type="hidden" name="anneeBudgetaire"  id="anneeBudgetaire" />
	     	    <input type="hidden" name="imputationBudgetaire"  id="imputationBudgetaire" />
	     	    <input type="hidden" name="rubrique"  id="rubrique" />
	     	    <input type="hidden" name="observationNf"  id="observationNf" /> 
	     	    </form>
	     	    <form id="formAjouterNoteFinancement2" method="post">  
	            <input type="hidden" name="idAppelOffre"   value="<%=idAppelOffre%>" size="28"/>		
	     	    <input type="hidden" name="creditDisponible"  id="creditDisponible" /> 
	     	    <input type="hidden" name="totalAengager"  id="totalAengager" />
	     	    <input type="hidden" name="disponibleApresEngagement"  id="disponibleApresEngagement" />
	     	    </form>                       
                 </div>                 
	             </div>
	             </div>
	             	            	             	             	             	             	             	                  
        </center>
        </div> 
        </div>     
     	
     	<div id ="dialog" title ="Modifier un prix" > 
     	<form id="formModifierPrixBordereau" method="post"> 
	             <input type="hidden" name="idAppelOffre"  id="idAppelOffre2"   value="<%=idAppelOffre%>" size="28"/>					                    
	             <input type="hidden" name="idBordereau"  id="idBordereau2"   value="" size="28"/>					                    	            	            
	             <center>             
	             <table bgcolor="#b9cd6d"  bordercolor="#ffffff" class="table " width="652">
			     <tr>			        
		            <td class="" align="left" > <font color="rgba(240, 173, 78, 0.55)" size="2"> N° de Prix</font></td>
				    <td><input type="number" name="numPrix" id="numPrix2"   value="" size="42"/>  </td>				
	             </tr>
	             <tr>  
	                <td class=""  align="left"> <font color="rgba(240, 173, 78, 0.55)" size="2">Désignation </font></td>
	                <td class=""  align="left"> <input type="text" name="designation"  id="designation2"   value="" size="62"/> </td>				
	             </tr>
	             <tr>  
	                <td class=""  align="left"><font color="rgba(240, 173, 78, 0.55)" size="2"> Taux de TVA </font></td>
	                <td class=""  align="left"> <input type="number" name="tauxTva"  id="tauxTva2"  class="number_input"  value="20" size="42"/> </td>				
	             </tr>
	             <tr id="prixDetail5">  
	                <td class=""  align="left"> <font color="rgba(240, 173, 78, 0.55)" size="2"> Unité </font></td>
	                <td class=""  align="left"> <input type="text" name="unite"  id="unite2"  class="newsletter_input"  value="" size="30"/> </td>				
	             </tr>
	             <tr id="prixDetail6">  
	                <td class=""  align="left"><font color="rgba(240, 173, 78, 0.55)" size="2"> Quantité </font></td>
	                <td class=""  align="left"> <input type="number" name="quantite"  id="quantite2"  class="number_input3"  value="" size="42"/> </td>				
	             </tr>
	             <tr > 
	                <td id="prixGlobal2" class=""  align="left"> <font color="rgba(240, 173, 78, 0.55)" size="2">Prix Forfaitaire </font> </td> 
	                <td id="prixDetail4" class=""  align="left"> <font color="rgba(240, 173, 78, 0.55)" size="2">Prix Unitaire </font> </td>
	                <td class=""  align="left"> <input type="number" name="prixUnitaire"  id="prixUnitaire2"  class="number_input3"  value="" size="42"/> </td>				
	             </tr>	             	                 		               	             
	             </table>
	             </center>
	             </form>
        </div> 
        
        <div id="donneeAO">
        <div class="content_section_box16">
            <div class="content_section_box_content16">
            <center>
            <form id="formAjouterAppelOffre" method="post"> 
            <input type="hidden" name="idAppelOffre"  id="idAppelOffre3"   value="<%=idAppelOffre%>" size="28"/>
            <input type="hidden" name="natureProgramme"  id="natureProgramme"  value="" />   
            <table bgcolor=""  bordercolor="#000000" class="table " width ="1620">
			<tr>
		        <td class="" align="left" > N° du marché </td>
				<td><input type="number" name="numAppelOffre" id="numAppelOffre"  class="number_input4"  value="<%=appelsoffres.getNumAppelOffre()%>" />  </td>				
	       
	            <td class=""  align="left"> Année du marché </td>
	            <td class=""  align="left"> <select name="anneeAppelOffre"  id="anneeAppelOffre" > 
	            <option  value="<%=appelsoffres.getAnneeAppelOffre()%>"><%=appelsoffres.getAnneeAppelOffre()%></option>	            
				<% Date dateSysteme = new Date();
			       int yearSysteme = Integer.valueOf(String.format("%1$tY",dateSysteme));
			       				
				   for(int i=yearSysteme;i>=1950;i--){%>
				<option  value="<%=i%>"><%=i%></option>
				<%} %>
				</select>
	            </td>
	            <td class="" align="left" > Référence Appel d'offre </td>
				<td><input type="text" name="referenceAo" id="referenceAo" class="newsletter_input"  value="<%=appelsoffres.getReferenceAo()%>" size="10"/>  </td>				
	            
		        <td class="" align="left" > Mode de passation </td>
				<td><select name="typeAo" id="typeAo"  >  
				<option  value="<%=appelsoffres.getTypeAo() %>"><%=appelsoffres.getTypeAo() %></option>			
	            <option  value="Appel d'offres ouvert">Appel d'Offres ouvert</option>
		        <option  value="Appel d'offres restreint">Appel d'Offres restreint</option>
		        <option  value="Appel d'offres avec présélection">Appel d'offres avec présélection</option>
		        <option  value="Consultation architecturale">Consultation architecturale</option>
		        <option  value="Concours architectural">Concours architectural</option>
		        <option  value="Concours">Concours</option>	
		        <option  value="Marché négocié">Marché négocié</option>	 
		        <option  value="Appel d'offres ouvert simplifié">Appel d'Offres ouvert simplifié</option>
                <option  value="Appel d'offres national">Appel d'Offres national</option>
                <option  value="Appel d'offres international">Appel d'Offres international</option>        
		        </select>
		        </td>	
	            
	            <td class=""  align="left"> Nature de prestation </td>
	            <td class=""  align="left"> <select  name="categorieAo"  id="categorieAo"  class="newsletter_input" > 
	            <option  value="<%=appelsoffres.getCategorieAo() %>"><%=appelsoffres.getCategorieAo() %></option>					
	            <option  value="Travaux">Travaux</option>
		        <option  value="Fourniture">Fournitures</option>
		        <option  value="Service">Services</option>	        
		        </select>
		        </td>	
		        
	            <td class=""  align="left">  </td>
	            <td class=""  align="left">&nbsp;<input type="hidden" name="natureAo"  id="natureAo"  class="newsletter_input"  value="" size="28"/> </td>				
	        
	            <td class=""  align="left"> Type de Lot </td>
	            <td class=""  align="left"> <select name="typeLot"  id="typeLot"  class="newsletter_input" > 
	            <option  value="<%=appelsoffres.getTypeLot() %>"><%=appelsoffres.getTypeLot() %></option>				
	            <option  value="Lot unique"> Lot unique </option>
		        <option  value="Lot N1"> Lot N° 1 </option><option  value="Lot N2"> Lot N° 2 </option>
		        <option  value="Lot N3"> Lot N° 3 </option><option  value="Lot N4"> Lot N° 4 </option>     
		        <option  value="Lot N5"> Lot N° 5 </option><option  value="Lot N6"> Lot N° 6 </option>
		        <option  value="Lot N7"> Lot N° 7 </option><option  value="Lot N8"> Lot N° 8 </option>
		        <option  value="Lot N9"> Lot N° 9 </option><option  value="Lot N10"> Lot N° 10 </option>
		        <option  value="Lot N11"> Lot N° 11 </option><option  value="Lot N12"> Lot N° 12 </option>
		        <option  value="Lot N13"> Lot N° 13 </option><option  value="Lot N14"> Lot N° 14 </option>     
		        <option  value="Lot N15"> Lot N° 15 </option><option  value="Lot N16"> Lot N° 16 </option>
		        <option  value="Lot N17"> Lot N° 17 </option><option  value="Lot N18"> Lot N° 18 </option>
		        <option  value="Lot N19"> Lot N° 19 </option><option  value="Lot N20"> Lot N° 20 </option>
		        </select>
		        </td>	
	        </tr> 	       	        
	        </table>  
	     
            <center>-</center> 
            <center>
            <table    bordercolor="#000000" class="table " width ="" >
     		<tr>
			    <td class="" align="left" > Objet du marché </td>
				<td><input type="text" name="objetAppelOffre" id="objetAppelOffre"   value="<%=appelsoffres.getObjetAppelOffre()%>" size="78"/>  </td>				
			    <td class="" align="left" > Maitre d'Ouvrage </td>
			    <td ><input type="text" name="objetAppelOffre2" id="objetAppelOffre2"   value="<%=appelsoffres.getObjetAppelOffre2()%>" size="50" />  </td>							    
			</tr>
			</table>  
	        </center>  
            <center>-------------</center> 
            <table    bordercolor="#000000" class="table " width ="" >
     		<tr>
			    <td class="" align="left" > Montant du Marché (TTC) </td>
				<td align="left"><input type="number" name="estimation" id="estimation" class="number_input3"  value="<%=appelsoffres.getEstimation()%>" size="17"/>  </td>				
	            <td class="" align="left" > Cautionnement provisoire </td>
				<td align="left"><input type="number" name="cautionnementP" id="cautionnementP" class="number_input3"  value="<%=appelsoffres.getCautionnementP()%>" size="17"/>  </td>				
			    <td class="" align="left" >  Date ouverture des plis </td>
				<td><input type="date" name="dateOp" id="dateOp"   value="<%=appelsoffres.getDateOp()%>" size="10"/>  </td>	
			</tr>    
			</table>  
	        <table>    
		    <tr> 
		        <td class="" align="left" > </td>
				<td align="center"><input type="hidden" name="serviceAo"   id="serviceAo" value=""  > </td>			
		        <td class=""  align="right"> </td>
	            <td class=""  align="left"> <input type="hidden" name="anneeProgramme"  id="anneeProgramme" value="0"  > </td>
	            <td align="center" width="40" ><input type="hidden" name="idProgramme"  id="idProgramme" value="0">	
	            	 	                    
           </tr>       
	        </table>
	        <center>-------------------------------</center>
            <center>
            <table  >    
		    <tr>   
		        			
		        <td class="" align="left" >  </td>
				<td><input type="hidden" name="heureOp" id="heureOp" value="0"  > </td>
	            <td class=""  align="left">  </td>
	            <td class=""  align="left"> <input type="hidden" name="minuteOp"  id="minuteOp"  value="0"  > </td>
	            
	            <td class=""  align="left">  </td>
	            <td class=""  align="left"> <input type="hidden" name="lieuOp"  id="lieuOp"  class="newsletter_input"  value="<%=appelsoffres.getLieuOp()%>" size="52"/> </td>					        
	            <td class="" align="right"> <input type="hidden" name="lieuOp2"  id="lieuOp2" dir="rtl" class="newsletter_input"  value="<%=appelsoffres.getLieuOp2()%>" size="52"/> </td>					                    
	            <td class="" align="right" >  </td>
	        </tr>       
	        </table>   
	        </center> 	        
	        
	        <table bgcolor=""  bordercolor="#000000" class="table " width ="1620" >    
		    <tr>   		        
				<td align="left" >  Date de Commencement des travaux </td>
			    <td align="left"><input type="date" name="dateVisiteDesLieux" id="dateVisiteDesLieux"   value="<%=appelsoffres.getDateVisiteDesLieux()%>" size="10"/>  </td>	          			
				<td align="left" > Date Prévue Fin des travaux </td>
			    <td align="left"><input type="date" name="dateDepotEchantillons" id="dateDepotEchantillons"  value="<%=appelsoffres.getDateDepotEchantillons()%>" size="10"/>  </td>	          		
	            <td class="" align="left" > Délai d'exécution (par Mois) </td>
				<td align="left"><input type="number" name="delaisExecution" id="delaisExecution" class="number_input"  value="<%=appelsoffres.getDelaisExecution()%>" />  </td>				
	            <td class="" align="left" > Délai d'exécution (par Jour) </td>
				<td align="left"><input type="number" name="modeDelaiExecution" id="modeDelaiExecution" class="number_input"  value="<%=appelsoffres.getModeDelaiExecution()%>" />  </td>					            
	            <td class="" align="left" > Lieu d'exécution </td>
				<td align="left"><input type="text" name="lieuExecution" id="lieuExecution" class="newsletter_input"  value="<%=appelsoffres.getLieuExecution()%>" size="42"/>  </td>				
	        </tr>       
	        </table>
	       
	        <table  >    
		    <tr>   		        
		        		        <td class="" align="left" >  </td>
				<td align="left"><<input type="hidden" name="heureDepotEchantillons" id="heureDepotEchantillons" value="0"  > </td> 
				
	            <td class=""  align="left">  </td>
	            <td class=""  align="left"> <input type="hidden" name="minuteDepotEchantillons"  id="minuteDepotEchantillons"  value="0"  > </td>
	            	
		        <td class="" align="left" >  </td>
				<td align="left"><input type="hidden" name="lieuDepotEchantillons" id="lieuDepotEchantillons"  value="<%=appelsoffres.getLieuDepotEchantillons()%>" size="62"/>  </td>				                   
	        </tr>       
	        </table>      
	        
	        <table  >    
		    <tr>   
		       <td class="" align="left" >  </td>
				<td align="left"><input type="hidden" name="heureVisiteDesLieux" id="heureVisiteDesLieux" value="0" size="10"/>  </td> 
				
	            <td class=""  align="left">  </td>
	            <td class=""  align="left"> <input type="hidden" name="minuteVisiteDesLieux"  id="minuteVisiteDesLieux"  value="0" size="10"/>  </td>
	            	
		        <td class="" align="left" >  </td>
				<td align="left"><input type="hidden" name="numArticlePieceJ" id="numArticlePieceJ"   value="<%=appelsoffres.getNumArticlePieceJ()%>" size="8"/>  </td>						        
               <td align="left" > <input type="hidden" name="reserverPme"  id="reserverPme" value="0" /> </td>                       
	        </tr>       
	        </table> 	
	        
	        <table bgcolor=""  bordercolor="#000000" class="table " >    
		    <tr>   
		        <td class="" align="left" > Secteur </td>
				<td align="left"><input type="text" name="secteur" id="secteur"  value="<%=appelsoffres.getSecteur()%>" size="20"/>  </td>				
	            <td class="" align="left" > Qualification </td>
				<td align="left"><input type="text" name="qualification" id="qualification"  value="<%=appelsoffres.getQualification()%>" size="20"/>  </td>				
	            <td class="" align="left" > Classe </td>
				<td align="left"><input type="text" name="classe" id="classe"  value="<%=appelsoffres.getClasse()%>" size="20"/>  </td>				
	        </tr>       
	        </table>        
	        <center>---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------</center>
            <% if( (role.equals("Représentant Chef Service Marchés") || role.equals("Chef Service Marchés") || role.equals("Chef Division Equipement") )) { %>  
            <table>
	        <tr>
	            <td class="" align="right"> </td>
		        <td class="" align="right"> </td>
		        <td><input type="button" id="modifierAppelOffre"  class="btn btn-default" value="  Enregistrer  " size="35"/>  </td>
		        <td class="" align="right"> </td>
		        <td class="" align="right"> </td>
	        </tr>
	        </table>	                    
	        <%}%>
	        </form>
	        </center>
	        </div>         
            </div>
            </div> 
        
   <div id = "dialogBienEnregistrer" title = "Enregistrement" >
       <font color="#000000"> L'enregistrement a été effectué avec succès  </font>                   	             
    </div>
   <div id = "dialog4" title = "Supprimer un prix" >
      <font color="#000000"> Vous voulez supprimer ce prix ?   </font>
    </div>
    
    <div id = "dialog3" title = "Supprimer un prix" >
      <font color="#000000"> Le prix a été supprimé avec succès   </font>
      
    </div>
    <div id = "dialog5" title = "L'enregistrement de type de bordereau" >
      <font color="#000000"> L'enregistrement a été réalisée avec succès   </font>
      
    </div>
    
    <div id = "dialog2" title = "Modifier un prix" >
      <font color="#000000"> La modificiation de prix a été réalisée avec succès  </font>      
    </div>
    
    <div id = "dialogDonnees" title = "Enregistrer les données générales" >
      <font color="#000000"> L'enregistrement a été réalisée avec succès  </font>      
    </div>
    
    <div id = "dialogDonnees2" title = "Enregistrer les données générales" >
      <font color="#000000"> Ce numéro existe dèja pour cet lot ! </font>
    </div>
    <div id = "dialogChefDeProjet5" title = "Supprimer personne chargée de suivi du marché " >
      <font color="#000000"> Vous voulez supprimer la personne chargée de suivi du marché ?   </font>
    </div>
    
    <div id = "dialogChefDeProjet4" title = "Supprimer personne chargée de suivi du marché" >
      <font color="#000000"> L'opération a été réalisée avec succès   </font>  
    </div>
	    <div class="cleaner"></div>
        </div>
        <div class="content_section_w600 margin_right_10">
        	<div class="header_01"><center></center></div>			        
            <div class="cleaner"></div>
        </div>
        <div class="cleaner"></div>
        <div class="horizontal_divider"></div>
        <div class="margin_bottom_30"></div>
      
        <div class="cleaner"></div>
    
    <!-- end of content -->
    
<!-- Free Website Templates @ TemplateMo.com -->
 <!-- end of container -->
  </body>  
</html>
