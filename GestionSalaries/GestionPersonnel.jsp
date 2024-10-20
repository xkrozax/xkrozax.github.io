<%@ page language="java" import="java.util.*" import="java.math.BigDecimal" import="metier.Appelsoffres"  import="metier.Chefprojet" contentType="text/html; charset=UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title> Gestion Marchés Publics </title>
    
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
    if( ! ( roleChefDeProjet.equals("Oui") || role.equals("Employé Service Marchés") || role.equals("Représentant Chef Service Marchés") 
    || role.equals("Chef Service Marchés") || role.equals("Chef Division Equipement") || role.equals("Président") )) {
    String site = new String("../PageNonAutoriseeMarches.jsp");
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
	String numMarches="";
	String anneeMarches="";
	String objetAppelOffre="";
	String categorieAo="";
	String statutActuel="";
	String dateOp="";
    
	String natureAo = "";
	int numMarchesAo = 0;
	if (appelsoffres != null) {
	natureAo = appelsoffres.getNatureAo();
	numMarchesAo = appelsoffres.getNumMarches();
	}
	
    %>
	<script type="text/javascript">
	function recupererPersonnel(){
	   
	   	$.ajax({    
            type: "POST", 
            enctype:"multipart/form-data",
            url: "rechercherListPersonnel.do", 
            data:$("#formRechercherPersonnel").serialize(),
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
               $("#resultatRecherche").html(html);
               $("#resultatRecherche").show();             
            } 
         }); 
	   };
	   	   
	$(function(){   
      
      $("#site_title2").load("menuTitre2.html"); 
      $("#chargement").load("menuChargement.html");
      $("#chargement").hide();        
      $("#dialogAjouterPersonnel").hide();$("#dialog1").hide();
      $("#dialogBienEnregistrer").hide();
      $("#dialog4").hide();$("#dialog5").hide();$("#dialog3").hide(); 
      $("#dialogAvance4").hide();$("#dialogAvance5").hide();
      $("#numContratAnapec").attr("disabled", 'disabled'); 
      $("#dialogDocumentsCourrier").hide();$("#dialogAjouterDocument").hide();
      $("#dialogSupprimerPieceJointe1").hide();$("#dialogSupprimerPieceJointe2").hide();
      
      $("#chargement").show();
      recupererPersonnel();

	  $("#rechercherPersonnel").click(function rechercherPersonnel(){ 
          recupererPersonnel();
      }); 
     
      $("#ajouterPersonnel").click(function ajouterPersonnel(){         
               $("#dialogAjouterPersonnel").dialog({
	           autoOpen: true, 
               buttons: {
               Enregistrer: function() {
                     $.ajax({    
                            type: "POST", 
                            enctype:"multipart/form-data",
                            url: "ajouterPersonnel.do", 
                            data:$("#formAjouterPersonnel").serialize(),
                            dataType: "html", 
                            error: function(){ 
                             	alert("invalid"); 
                             	$("#chargement").hide();                  
                            }, 
                            beforeSend : function(){ 
                            }, 
                            success: function(html){                                                       
                            	$("#dialogAjouterPersonnel").dialog("close");
                            	afficherBienEnregistrer();
                            }
                      }); 
                  },
               },
               width: 900,
               height: 540,        
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
               $( "#dialogAjouterPersonnel" ).dialog( "open" );                                    
      }); 
    
      $('#contratAnapec').change(function()  { 
    		if($(this).val()=="Oui"){
    			$("#numContratAnapec").removeAttr("disabled");  
    		} else {
    			$("#numContratAnapec").attr("disabled", true);  
    		}    
       	});
       	
    $('#exporterListePersonnel').click(function exporterListePersonnel() 
    {         
        $("#chargement").show();
        $.ajax( 
        {    
            type: "POST", 
            enctype:"multipart/form-data",
            url: "exporterListePersonnel.do", 
            data:$("#formRechercherPersonnel").serialize(),
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
    			   window.location.replace("../../GestionEntrepriseBTP/Fichiers/ListePersonnels.pdf");                        
            } 
         }); 
    });
    
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
                window.location.replace("../../GestionEntrepriseBTP/GestionMarchesPublics.jsp");             
            } 
        }); 
    } 
    );
    
    $("form#formAjouterDocument").submit(function(){
    var formData = new FormData($(this)[0]);

    $("#chargement").show();
    $.ajax({
        url: "ajouterDocumentPieceJointe.do",
        type: 'POST',
        data: formData,
        async: false,
        cache: false,
        contentType: false,
        processData: false,
        error: function()
            { 
               alert("invalid"); 
               $("#chargement").hide();                  
            }, 
        success: function(html) 
           { 
               $("#chargement").hide();
               $("#listeDocumentsCourrier").html(html);  
               $("#listeDocumentsCourrier").show(); 
               $("#dialogAjouterDocument").dialog("close"); 
           }
    });
    return false;
    }); 
    
    
      });    
    </script>
	
	</head>
  
  <body>
  <div id="templatemo_container">
<!-- Free CSS Templates @ www.TemplateMo.com -->
	<div id="templatemo_header_panel">
	
    	<div id="site_title">
    	<table>	     	    
         <tr> 	
	      <td><a href="GestionMarchesPublics.jsp" > <input type="button" class="btn-default3" value= " Connexion " /> </a> </td>   
          <td><a href="Marches/LancementMarches/ListeMarches.jsp" > <input type="button" class="btn-default3" value= " Gestion des marchés " />  </a> </td>
          <td><a href="GestionParametres/ParametresRecettes.jsp" > <input type="button" class="btn btn-default3" value= " Gestion du Stock et Articles" /> </a> </td>                
          <td><a href="GestionSalaries/GestionPersonnelsSalaries.jsp" > <input type="button" class="btn btn-primary" value= " Gestion Salariés" /> </a> </td>                      
           <td><input type="button"  name="deConnecter" id="deConnecter" class="btn btn-danger" value="  Déconnecter  " size="35"/>  </td>            
	     </tr>
         </table>
        </div>
		<div id="site_title2">
           
        </div>
        <div id="header_links">
               
        </div>
    </div> <!-- end of header panel -->
    
    <div id="templatemo_menu">  	
    <ul class="niveau1">                      
            <li><a href="GestionSalaries/GestionPersonnel.jsp"> <input type="button" class="btn btn-default" value= " Liste des Salariés " /> </a>  </li>            
            <li><a href="GestionSalaries/GestionDePaie.jsp"> <input type="button" class="btn btn-default" value= " Gestion De Paie " /> </a>  </li>                                                                    
    </ul>
    </div> <!-- end of menu -->
    
    <div id = "dialogBienEnregistrer" title = "Enregistrement" >
       <font color="#000000"> L'enregistrement a été effectué avec succès  </font>                   	             
    </div>
    <div id = "dialog5" title = "Supprimer le dossier du Personnel" >
      <font color="#000000"> Vous voulez supprimer cette Personnel ?   </font>
    </div>
    
    <div id = "dialog4" title = "Supprimer le dossier du Personnel" >
      <font color="#000000"> Le Personnel a été supprimé avec succès   </font>
      
    </div>
    
         
    <div id="templatemo_content">
         <center>         		  		    
            <form id="formOuvrirPersonnel" method="post">
            <input type="hidden" name="idPersonnel" id="idPersonnel"/>
            </form>
            <form id="formModifierRetenueSalaire" method="post">
            <input type="hidden" name="idPersonnel" id="idPersonnelRetenue"/>
            <input type="hidden" name="retenue" id="retenueSalaire"/>
            <input type="hidden" name="retenuePret" id="retenuePretSalaire"/>
            </form> 
            <form id="formAjouterAvance" method="post">
            <input type="hidden" name="idAvance" id="idAvance"/>
            <input type="hidden" name="idPersonnel" id="idPersonnelAvance"/>
            <input type="hidden" name="type" id="type"/>
            <input type="hidden" name="dateAvance" id="dateAvance"/>
            <input type="hidden" name="modePaiement" id="modePaiement"/>
            <input type="hidden" name="montant" id="montant"/>
            <input type="hidden" name="montantAdeduire" id="montantAdeduire"/>
            <input type="hidden" name="idCompteBancaire" id="idCompteBancaire"/>
            </form> 
            <div class="content_section_box26">
            <div class="content_section_box_content6">
            
         <center>----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------</center>	   
         <form id="formRechercherPersonnel" method="post"> 
         <input type="hidden" name="idPersonnel" value="" />  
         <input type="hidden" name="idAppelOffre"  value="<%=idAppelOffre%>" />  
         <td><input type="hidden" name="numcnss" value=""/>  </td>   
         <table bgcolor=""  bordercolor="#000000" class="table " >
			<tr>			
				<td> Nom Salarié</td>
				<td><input type="text" name="nom"  size="15"/>  </td>							
				<td> CIN </td>
				<td><input type="text" name="cin" size="20"/>  </td>	
			    <td>  </td>
				<td>  <input type="hidden" name="dateEmbauche"  size="10"/>  </td>	        		        						
			</tr>
		 </table>	          	        	       	       
         <table>
	        <tr>
		        <td><input type="button" id="rechercherPersonnel"  class="btn btn-default"  value="  Rechercher  " size="35"/>  </td>
	            <td><input type="button" id="ajouterPersonnel"  class="btn btn-default"  value="  Nouveau Personnel  " size="35"/>  </td>                                    
	            <td><input type="button" id="exporterListePersonnel"  class="btn btn-default2"   value="  Liste Personnels  " size="35"/>  </td>                                               	                        
	        </tr>
	     </table>
	   </form>	
	   <center>----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------</center>	   
	   <div id="chargement"> </div>	
       <div id="resultatRecherche"></div> 
             
       <div id = "dialogAjouterPersonnel" title = "Les données du Personnel" >       
        <form id="formAjouterPersonnel" method="post">
         <input type="hidden" name="idPersonnel" id="id" value="" /> 
         <input type="hidden" name="idAppelOffre" id="idAppelOffre" value="<%=idAppelOffre%>" />        
		 <table bgcolor=""  bordercolor="#000000" class="table " width="" >
		  <tr>   
		        <td> Matricule Salarié </td>
				<td>  <input type="number" name="matricule" id="matricule" size="20"/>  </td> 
				<td> Fonction </td>
				<td> <input type="text" name="fonction" id="fonction" size="20"/> </td>	  
				
				
			</tr>
			<tr> 				
		        <td> Nom Salarié </td>
				<td><input type="text" name="nom" id="nom" size="40"/>  </td>
				<td> CIN </td>
				<td> <input type="text" name="cin" id="cin" size="20"/> </td>
		   </tr>
		   <tr> 	
				<td> Salaire  </td>
				<td> <input type="number" name="salaireBase" id="salaireBase" class="number_input4" /> 
					<select name="contratAnapec" id="contratAnapec">  
			            <option  value="Par Jour">Par Jour</option>
			            <option  value="Par Mois">Par Mois</option>
			        </select>
				</td>	   
		        <td> Numéro de CNSS </td>
				<td><input type="text" name="numCnss" id="numCnss" size="20"/>  </td>	
		   </tr>
		   <tr> 	
				
				<td> Date Embauche </td>
				<td>  <input type="date" name="dateEmbauche" id="dateEmbauche" size="10"/>  </td>
				<td> Date Fin de Travail</td>
				<td> <input type="date" name="dateArretTravail" id="dateArretTravail" /> </td>	
		   </tr>
		   <tr>	        	   		
				<td> Adresse </td>
				<td> <input type="text" name="adresse" id="adresse" size="40"/> </td>
				<td> Situation Familiale </td>
				<td> 
					<select name="situationFamiliale" id="situationFamiliale">  
			            <option  value="Célibataire">Célibataire</option>
			            <option  value="Marié">Marié</option>
			            <option  value="Divorcé">Divorcé</option>
			            <option  value="Veuf">Veuf</option>
			        </select>
				</td>	             		 	        		        						
			</tr>
			<tr>         	        	        
		        <td> N° Compte Bancaire </td>
				<td> <input type="text" name="compteBancaire" id="compteBancaire" size="40"/> </td>
				<td> Banque </td>
				<td> <input type="text" name="banque" id="banque" size="40"/></td>
		   </tr>
		   <tr>         	        	        		        
				<td> </td>
				<td> <input type="hidden" name="agenceBancaire" id="agenceBancaire" size="40"/> </td>
				<td> </td>
				<td> <input type="hidden" name="villeBanque" id="villeBanque" size="40"/></td>
		   </tr>
			<tr>         	        	        
		        <td> </td>
				<td> <input type="hidden" name="nbEnfants" id="nbEnfants" size="8"/> </td>   
				<td>  </td>
				<td><input type="hidden" name="salaireNetApayer" id="salaireNetApayer" value ="00.00" class="number_input4" />  </td>
		   </tr>
		   	
		   <tr>					
				<td>  </td>
				<td>  
						      
				</td>	
				<td>  </td>
				<td><input type="hidden" name="numContratAnapec" id="numContratAnapec" size="20" disabled="disabled"/>  </td>
		    </tr>
		  </table>		
		 </form>
        </div> 
                         	             
	   </div> 
      </div> 
     
      <div id = "dialogDocumentsCourrier" title = "Pièces Jointes" >       
            <form id="formDocumentsCourrier" method="post">
            <input type="hidden" name="idCourrier" id="idCourrier1"/> 
            <input type="hidden" name="typeDocument" id="typeDocument1" value="Personnel"/>  	
            </form>
            <div id="listeDocumentsCourrier">  </div>
            </div>  
            
            <div id ="dialogAjouterDocument"  title = "Ajouter Pièce Jointe" >
            <center>
           	<form id="formAjouterDocument"  method="post" enctype="multipart/form-data" >
            <input type="hidden" name="idCourrier" id="idCourrier2"/>
            <input type="hidden" name="typeDocument" id="typeDocument2" value="Personnel"/>
           	<table>
           	<tr>	
				<td> Nom Pièce jointe </td>
				<td><input type="text" name="nomDocument" size="24"/>  </td>	
			</tr>         	
		    <tr>
			    <td > Pièce jointe en PDF </td>
		        <td><input type="file" name="documentCourrier"  value="télécharger" size="20"/>  </td>   
	        </tr>
	        </table>
	        -----------------------------------------------       
	        <table>
	        <tr>	           
	            <td> </td> 
		        <td> <button>Enregistrer</button>  </td>      
	        </tr>
	        </table>
	        </form>  
	        </center>
	        </div>
	        
	        <form id="formSupprimerDocument" method="post">
            <input type="hidden" name="idDocument" id="idDocument"/>  	
            </form>
                 	        
	 </center>
    </div> 
             				
   </div>
   
   <div id = "dialog1"  >
       <div id="listeAvance">  </div>                       	             
    </div>  
    <div id = "dialogAvance5" title = "Supprimer Avance" >
      <font color="#000000"> Vous voulez supprimer cette Avance ?   </font>
    </div>   
    <div id = "dialogAvance4" title = "Supprimer Avance" >
      <font color="#000000"> L'avance a été supprimé avec succès   </font>   
    </div> 
    <div id = "dialogSupprimerPieceJointe2" title = "Supprimer Pièce jointe" >
      <font color="#000000"> Vous voulez supprimer cette pièce jointe ?   </font>
    </div>
	 <div id = "dialogSupprimerPieceJointe1" title = "Supprimer Pièce jointe" >
      <font color="#000000"> La pièce jointe a été supprimée avec succès   </font>   
    </div>            	  
    <!-- end of content -->
    
<!-- Free Website Templates @ TemplateMo.com -->
 <!-- end of container -->
  </body>  
</html>
