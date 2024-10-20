<%@ page language="java" import="java.util.*" import="metier.Appelsoffres"  import="metier.Chefprojet" import="metier.Caisse" import="java.math.BigDecimal" contentType="text/html; charset=UTF-8"%>
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
    .ui-widget-content { background: "#b9cd6d"; background: url(images/img06.jpg); }
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
    String site = new String("../../PageNonAutoriseeMarches.jsp");
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
    if (appelsoffres != null) {
    idAppelOffre=appelsoffres.getIdAppelOffre();
    anneeAppelOffre=appelsoffres.getAnneeAppelOffre().toString();
    numAppelOffre=appelsoffres.getNumAppelOffre().toString()+" / "+anneeAppelOffre;
	anneeMarches=appelsoffres.getAnneeMarches().toString();
	numMarches=appelsoffres.getNumMarches().toString()+" / "+anneeMarches;
	objetAppelOffre=appelsoffres.getObjetAppelOffre();
	dateOp=appelsoffres.getDateOp();
	categorieAo=appelsoffres.getCategorieAo();
	statutActuel=appelsoffres.getStatutActuel();
	}
    %>
    <% 
    Caisse caisse=null;
    caisse=(Caisse)session.getAttribute("Caisse");
    Integer idCaisse=0;  
	BigDecimal montantDeCaisse=new BigDecimal("00.00").setScale(2, BigDecimal.ROUND_DOWN);   
    if (caisse != null) {
    idCaisse = caisse.getIdCaisse();
	if (caisse.getMontantDeCaisse() != 0.00) {
	montantDeCaisse = new BigDecimal( (caisse.getMontantDeCaisse().toString()) ).setScale(2, BigDecimal.ROUND_DOWN);    
	}
	}
	%>
	<script type="text/javascript">
	$(function(){
      
      $("#site_title").load("menuTitre.html"); 
      $("#site_title2").load("menuTitre2.html"); 
      $("#chargement").load("menuChargement.html");
      $("#chargement").hide();
      $("#bienAjouter").hide();
      $("#dialog").hide();$("#dialog4").hide();$("#dialog5").hide();
      $("#dialogDocumentsCourrier").hide();$("#dialogAjouterDocument").hide();
      $("#dialogSupprimerPieceJointe1").hide();$("#dialogSupprimerPieceJointe2").hide();
    
    $('#exporterListeAppelOffre').click(function exporterListeAppelOffre() 
    { 
        $("#chargement").show();  
        $.ajax( 
        {    
            type: "POST", 
            enctype:"multipart/form-data",
            url: "exporterListeMarches.do", 
            data:$("#formRechercherMarches").serialize(),
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
               window.location.replace("../../GestionEntrepriseBTP/Fichiers/ListeDesMarches.pdf"); 
            } 
         }); 
    } 
    );
    $('#exporterListeDetailleAO').click(function exporterListeDetailleAO() 
    { 
        $("#chargement").show();  
        $.ajax( 
        {    
            type: "POST", 
            enctype:"multipart/form-data",
            url: "exporterListeDetailAO.do", 
            data:$("#formRechercherMarches").serialize(),
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
               window.location.replace("../../GestionEntrepriseBTP/Fichiers/ListeDesMarches.xls"); 
            } 
         }); 
    } 
    );
	$('#rechercherMarches').click(function rechercherrMarches() 
    {   
        $("#chargement").show();
        $.ajax( 
        {    
            type: "POST", 
            enctype:"multipart/form-data",
            url: "rechercherListeMarches.do", 
            data:$("#formRechercherMarches").serialize(),
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
            <li><a href="Marches/LancementMarches/ListeMarches.jsp" > <input type="button" class="btn btn-primary" value= " Liste des marchés " />  </a></li>           
            <li><a href="AppelsOffres/LancementAO/AjouterAO.jsp" > <input type="button" class="btn btn-default" value= " Nouveau Marché " /> </a></li>           
            <li><a href="AppelsOffres/DossierAO/DossierAO.jsp" > <input type="button" class="btn btn-default" value= " Dossier Marché " /> </a></li>          
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
    
      <div id = "dialog" title = "Ouvrir Marché" >
      <font color="#000000"> Le marché est ouvert avec succès  </font>
      </div>
      
      <div id = "dialog5" title = "Supprimer Marché" >
      <font color="#000000"> Vous voulez supprimer ce Marché ?   </font>
    </div>
    
    <div id = "dialog4" title = "Supprimer le dossier du Marché" >
      <font color="#000000"> Le dossier du Marché a été supprimé avec succès   </font>   
    </div>
	 
	<div id = "dialogSupprimerPieceJointe2" title = "Supprimer Pièce jointe" >
      <font color="#000000"> Vous voulez supprimer cette pièce jointe ?   </font>
    </div>
	 <div id = "dialogSupprimerPieceJointe1" title = "Supprimer Pièce jointe" >
      <font color="#000000"> La pièce jointe a été supprimée avec succès   </font>   
    </div> 
    
     
	<div id="ajouterDossierAO"> 
    <div id="templatemo_content">
            <center>         		  		    
            <form id="formOuvrirAppelOffre" method="post">
            <input type="hidden" name="idAppelOffre" id="idAppelOffre" class="newsletter_input"  value="" size="52"/>
            </form> 
            <form id="formRechercherMarches" method="post">
            <input type="hidden" name="typeRecherche"  class="newsletter_input"  value="recherche2" size="28"/>            
            <div class="content_section_box26">
            <div class="content_section_box_content6">
            
            <center>----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------</center>	   
            
            <table bgcolor=""  bordercolor="#000000" class="table " width ="1320">
			<tr>
		        <td class="" align="left" > N° du Marché </td>
				<td><input type="number" name="numMarches" id="numMarches"   value="" />  </td>						        
	            <td class=""  align="left"><select name="anneeMarches"  id="anneeMarches" > 	            
				<% Date dateSysteme = new Date();
			       int yearSysteme = Integer.valueOf(String.format("%1$tY",dateSysteme));%>
			       <option  value="<%=yearSysteme%>"><%=yearSysteme%></option>
			       <option  value="0">------</option>				
				   <%for(int i=yearSysteme;i>=1950;i--){%>
				<option  value="<%=i%>"><%=i%></option>
				<%} %>
				</select>
	            </td>
		        <td class="" align="left" >  </td>
				<td><input type="hidden" name="numAppelOffre" id="numAppelOffre"  class="newsletter_input"  value="" /> 	
				<td><input type="hidden" name="anneeAppelOffre" id="anneeAppelOffre"  class="newsletter_input"  value="" />
				<td><input type="hidden" name="typeAo" id="typeAo"  class="newsletter_input"  value="" /> 			       	            
	            
	            <td class=""  align="left"> Nature de prestation </td>
	            <td class=""  align="left"> <select  name="categorieAo"  id="categorieAo"  class="newsletter_input" > 				
	            <option  value="">--------------</option>
	            <option  value="Travaux">Travaux</option>
		        <option  value="Fourniture">Fourniture</option>
		        <option  value="Service">Service</option>	        
		        </select>
		        </td>	
		        <td class="" align="left" > Objet du Marché </td>
				<td><input type="text" name="objetAppelOffre" id="objetAppelOffre" class="newsletter_input"  value="" size="80"/>  </td>				
		        
		        <td class=""  align="left"> </td>
		        <td><input type="hidden" name="serviceAo"  class="newsletter_input"  value="" /> 	
		        <td align="right"><input type="hidden" name="objetAppelOffre2" id="objetAppelOffre2" dir="rtl" class="newsletter_input"  value="" size="80"/>  </td>				
		            
		        </td>					        		        
	        </tr> 	       	        
	        </table>  
            <center>
            
	        </center>              	        	       
	        <center>-------------------------------</center> 
            <table>
	        <tr>
	            <td class="" align="right"> </td>
		        <td class="" align="right"> </td>
		        <td><input type="button" id="rechercherMarches"  class="btn btn-default"  value="  Rechercher  " size="35"/>  </td>
		   		<td><input type="button" id="exporterListeDetailleAO"  class="btn btn-default2"  value="  Exporter la Liste des Marchés " size="35"/>  </td>		        	        
		        <td class="" align="right"> </td>
		        <td class="" align="right"> </td>
	        </tr>
	        </table>	
	        <center>----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------</center>	   
	             <div id="chargement">               
                 </div>	
                 <div id="resultatRecherche">	       	      	       	    	       
	        </div> 	             
	        </div> 
            </div>
	        </form>	
	        
	        <div id = "dialogDocumentsCourrier" title = "Pièces Jointes" >       
            <form id="formDocumentsCourrier" method="post">
            <input type="hidden" name="idCourrier" id="idCourrier1"/> 
            <input type="hidden" name="typeDocument" value="AppelOffre"/>  	
            </form>
            <div id="listeDocumentsCourrier">  </div>
            </div>  
            
            <div id ="dialogAjouterDocument"  title = "Ajouter Pièce Jointe" >
            <center>
           	<form id="formAjouterDocument"  method="post" enctype="multipart/form-data" >
            <input type="hidden" name="idCourrier" id="idCourrier2"/>
            <input type="hidden" name="typeDocument" value="AppelOffre"/>
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
             		
	<div id="ajouterAO"> 
    <div id="templatemo_content">
    <center> 
            <form id="formAjouterAppelOffre" method="post">           		  		                              
            </form>                     
     </center>
     </div>
     </div>
			
    </div>
              
    
    <!-- end of content -->
    
<!-- Free Website Templates @ TemplateMo.com -->
 <!-- end of container -->
  </body>  
</html>
