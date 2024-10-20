<%@ page language="java" import="java.util.*"  import="metier.Appelsoffres" import="metier.Chefprojet"  contentType="text/html; charset=UTF-8"%>
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
	String natureAo = "";
	int numMarchesAo = 0;
	if (appelsoffres != null) {
	natureAo = appelsoffres.getNatureAo();
	numMarchesAo = appelsoffres.getNumMarches();
	}
	if(  (!(natureAo.equals("Marché"))) || numMarchesAo == 0 ) {
    String site = new String("../../DossierMarchesNonOuvert.jsp");
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
      $("#dialog").hide(); $("#Enregistrement").hide();
      $("#CautionProvisoire").hide();$("#CautionDefinitive").hide(); $("#listeCautions").hide(); 
      $("#resultatRecherche").hide();$("#dialogBienEnregistrer").hide();
      $("#dialogDocumentsCourrier").hide();$("#dialogAjouterDocument").hide();
      $("#dialogSupprimerPieceJointe1").hide();$("#dialogSupprimerPieceJointe2").hide();
    
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
    
    $('#btnEnregistrement').click(function btnEnregistrement() 
    {                 
        $('#btnEnregistrement').addClass("active btn-info");
        $('#btnCautionProvisoire').removeClass("active btn-info");
        $('#btnCautionDefinitive').removeClass("active btn-info");
        $("#CautionProvisoire").hide();
        $("#CautionDefinitive").hide();  
        $("#listeCautions").hide();      
        $("#chargement").show();     
        $.ajax( 
        {    
            type: "POST", 
            enctype:"multipart/form-data",
            url: "rechercherMarches.do", 
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
               $("#Enregistrement").show();             
            } 
         });      
    }); 
    
    $('#btnCautionProvisoire').click(function btnCautionProvisoire() 
    {                 
        $('#btnEnregistrement').removeClass("active btn-info");
        $('#btnCautionProvisoire').addClass("active btn-info");
        $('#btnCautionDefinitive').removeClass("active btn-info");
        $("#resultatRecherche").hide();
        $("#CautionDefinitive").hide();
        $("#CautionProvisoire").show(); 
        $("#chargement").show();  
        $.ajax( 
        {    
            type: "POST", 
            enctype:"multipart/form-data",
            url: "rechercherCaution.do", 
            data:$("#formAjouterCaution").serialize(),
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
               $("#listeCautions").html(html);  
               $("#listeCautions").show();     
            } 
         });      
    });
    
    $('#btnCautionDefinitive').click(function btnCautionDefinitive() 
    {                 
        $('#btnEnregistrement').removeClass("active btn-info");
        $('#btnCautionProvisoire').removeClass("active btn-info");
        $('#btnCautionDefinitive').addClass("active btn-info");
        $("#resultatRecherche").hide();
        $("#CautionProvisoire").hide();
        $("#CautionDefinitive").show(); 
        $("#chargement").show();   
        $.ajax( 
        {    
            type: "POST", 
            enctype:"multipart/form-data",
            url: "rechercherCautionDefinitive.do", 
            data:$("#formAjouterCaution").serialize(),
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
               $("#listeCautions").html(html);  
               $("#listeCautions").show();     
            } 
         });  
    }); 
         
    $('#ajouterCaution2').click(function ajouterCaution2() 
    { 
        $("#chargement").show();  
        $.ajax( 
        {    
            type: "POST", 
            enctype:"multipart/form-data",
            url: "ajouterCaution.do", 
            data:$("#formAjouterCaution").serialize(),
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
               $("#listeCautions").html(html);  
               $("#listeCautions").show();     
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
            <li><a href="AppelsOffres/DossierAO/DossierAO.jsp" > <input type="button" class="btn btn-default" value= " Dossier Marché " /> </a></li>          
            <li><a href="Marches/ApprobationMarches/ApprobationMarches.jsp"> <input type="button" class="btn btn-default" value= " Approbation " /> </a></li>           
            <li><a href="Marches/EnregistrementMarches/EnregistrementMarches.jsp" class="current2"> <input type="button" class="btn btn-primary" value= " Cautions " /> </a></li>            
            <li><a href="Marches/Execution/ExecutionMarches.jsp"> <input type="button" class="btn btn-default" value= " Exécution du marché" /></a></li>
            <li><a href="AppelsOffres/OuvertureDesPlis/OuvertureDesPlis.jsp"> <input type="button" class="btn btn-default" value= " Etat d'avancement" /> </a></li>                    	
            <li><a href="Marches/Depenses.jsp"  > <input type="button" class="btn btn-default" value= " Dépenses " /> </a> </li> 
            <li><a href="GestionPersonnel/GestionPersonnel.jsp"  > <input type="button" class="btn btn-default" value= " Personnels " />  </a> </li>
            <li><a href="GestionPointageChantier/PointageChantier.jsp"  > <input type="button" class="btn btn-default" value= " Pointage chantier " />  </a> </li> 
            <li><a href="GestionMateriels/GestionMateriels.jsp"  > <input type="button" class="btn btn-default" value= " Matériels Chantier" />  </a> </li>
            <li><a href="Marches/ReceptionMarches/ReceptionMarches.jsp" > <input type="button" class="btn btn-default" value= " Réception Marché" /> </a></li>          
    </ul>
    </div> <!-- end of menu -->
    
    
	<div id="gestionEnregistrementMarches"> 
    <div id="templatemo_content">
                        		  		    
            <div class="content_section_box26">
            <div class="content_section_box_content6">
            <form id="formRechercherMarches" method="post">
            <input type="hidden" name="idAppelOffre" id="idAppelOffre" class="newsletter_input"  value="<%=idAppelOffre%>" size="28"/>           
            <input type="hidden" name="typeRecherche"   class="newsletter_input"  value="recherche4" size="28"/> 
            <input type="hidden" name="numEnregistrement" id="numEnregistrement"   class="newsletter_input"  value="" size="28"/> 
            <input type="hidden" name="dateEnregistrement" id="dateEnregistrement"   class="newsletter_input"  value="" size="28"/>            
            <center>
            <center>--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------</center> 	        	                                
	        <table border="0" bgcolor="#D8D38D"   class="table" width="850"  >
            <tr>
		        <td align="center">  <font color="#0B3573"> N° du marché : </font> <font color="#000000"> <%=numMarches%> </font> </td>	
		        <td align="center">  <font color="#0B3573"> Objet du marché : </font> <font color="#000000"> <%=objetAppelOffre%> </font> </td>		        
			</tr>		       
	        </table>
	        <center>--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------</center> 	        	                                
	        </center>              	        	       	     
	        </form> 	             
	        </div> 
            </div>
	 
	        <div class="content_section_box8">
            <div class="content_section_box_content6"> 
                 <center>                           
                 <table >
	             <tr>
		            <td><input type="button" id="btnEnregistrement" class="btn btn-default" value=" Enregistrement " size="28"/>
		            <td><input type="button" id="btnCautionProvisoire" class="btn btn-default" value=" Caution provisoire " size="28"/>
		             <td><input type="button" id="btnCautionDefinitive" class="btn btn-default" value=" Caution Définitive " size="28"/>
		         </tr>
		         </table>		         	         	        		                      	        
		         <table bgcolor=""  bordercolor="#000000" class="table " width="1674" border="2">
	             </table>
	             <div id="chargement">               
                 </div>	             	             
	             </center>
	       </div>
	       </div>	      
	             
	             <div class="content_section_box34">	             
                 <div class="content_section_box_content34">
                 <center>
                 <div id="resultatRecherche"> </div>
                 <div id="listeCautions"></div>
                 </center>                        	            
                 </div>                 
	             </div>
	             </div>
	             
	             <div id="CautionProvisoire">
                 <center>
                 <form id="formAjouterCaution" method="post"> 
	             <input type="hidden" name="idAppelOffre"  id="idAppelOffre2"  class="newsletter_input"  value="<%=idAppelOffre%>" size="28"/>					                    	             
	        	 <input type="hidden" name="typeConcurrent"  value="Adjudicataire" />
	        	 <input type="hidden" name="idCaution"  id="idCaution"  class="newsletter_input"  value="" size="28"/>
	        	 <input type="hidden" name="numCaution4"  id="numCaution4"  class="newsletter_input"  value="" size="28"/>
	        	 <input type="hidden" name="dateEtablissement4"  id="dateEtablissement4"  class="newsletter_input"  value="" size="28"/>
	        	 <input type="hidden" name="typeCaution4"  id="typeCaution4"  class="newsletter_input"  value="" size="28"/>
	        	 <input type="hidden" name="montantCaution4"  id="montantCaution4"  class="newsletter_input"  value="" size="28"/>					                    	             
	        	 <input type="hidden" name="etablissement4"  id="etablissement4"  class="newsletter_input"  value="" size="28"/>
	        	 <input type="hidden" name="etatCaution4"  id="etatCaution4"  class="newsletter_input"  value="" size="28"/>
	        	 <input type="hidden" name="dateDepot4"  id="dateDepot4"  class="newsletter_input"  value="" size="28"/>
	        	 <input type="hidden" name="dateRemise4"  id="dateRemise4"  class="newsletter_input"  value="" size="28"/>	        	              
	             </form>	             
                 </center>                
	             </div>
	             
	             <div id = "dialogDocumentsCourrier" title = "Pièces Jointes" >       
            <form id="formDocumentsCourrier" method="post">
            <input type="hidden" name="idCourrier" id="idCourrier1"/> 
            <input type="hidden" name="typeDocument" value="Caution"/>  	
            </form>
            <div id="listeDocumentsCourrier">  </div>
            </div>  
            
            <div id ="dialogAjouterDocument"  title = "Ajouter Pièce Jointe" >
            <center>
           	<form id="formAjouterDocument"  method="post" enctype="multipart/form-data" >
            <input type="hidden" name="idCourrier" id="idCourrier2"/>
            <input type="hidden" name="typeDocument" value="Caution"/>
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
	             	             	             	                        	 	
	 </div> 
     </div>
             	
	 <div id = "dialogBienEnregistrer" title = "Enregistrement" >
       <font color="#000000"> L'enregistrement a été effectué avec succès  </font>                   	             
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
