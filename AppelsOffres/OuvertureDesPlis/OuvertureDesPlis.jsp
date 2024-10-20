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
	String   role = "";
	if ((String) session.getAttribute("role") != null){
      role = (String) session.getAttribute("role");  
    }
    if( ! ( role.equals("Directeur Des Services") || role.equals("Employé Service Marchés") || role.equals("Représentant Chef Service Marchés")
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
	String numMarches="";
	String anneeMarches="";
    if (appelsoffres != null) {
    idAppelOffre=appelsoffres.getIdAppelOffre();
    numAppelOffre=appelsoffres.getNumAppelOffre().toString();
	anneeAppelOffre=appelsoffres.getAnneeAppelOffre().toString();
	objetAppelOffre=appelsoffres.getObjetAppelOffre();
	anneeMarches=appelsoffres.getAnneeMarches().toString();
	numMarches=appelsoffres.getNumMarches().toString()+" / "+anneeMarches;
	dateOp=appelsoffres.getDateOp();
	categorieAo=appelsoffres.getCategorieAo();
	statutActuel=appelsoffres.getStatutActuel();
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
      $("#dialogBienEnregistrer").hide();
      $("#dialog1").hide();$("#dialog2").hide();$("#dialog3").hide();$("#dialog").hide();
      $("#dialog4").hide();$("#dialog5").hide();$("#dialog6").hide();$("#dialog8").hide(); 
      $("#listeMembresCommission").hide(); $("#dialogAjouterFonctionnaire").hide();  
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
                       	             	
	$('#BtnSeancesAO').click(function BtnSeancesAO() 
    { 
        $("#BtnSeancesAO").addClass("active btn-info");
        $("#BtnConcurrents").removeClass("active btn-info");
        $("#BtnConcurrents2").removeClass("active btn-info"); 
        $("#BtnConcurrents3").removeClass("active btn-info");
        $("#chargement").show();
      
        $.ajax( 
        {    
            type: "POST", 
            enctype:"multipart/form-data",
            url: "rechercherSeancesAO.do", 
            data:$("#formAjouterSeance").serialize(),
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
               $("#listeSeances").html(html); 
               $("#listeSeances").show();  
               $("#listeConcurrents").hide();
               $("#listeMembresCommission").hide();             
            } 
         });  
    });
    
    $('#BtnConcurrents').click(function btnConcurrents() 
    { 
        $("#BtnSeancesAO").removeClass("active btn-info");
        $("#BtnConcurrents").addClass("active btn-info");  
        $("#BtnConcurrents2").removeClass("active btn-info"); 
        $("#BtnConcurrents3").removeClass("active btn-info");    
        $("#chargement").show();
        $.ajax( 
        {    
            type: "POST", 
            enctype:"multipart/form-data",
            url: "rechercherConcurrent.do", 
            data:$("#formAjouterConcurrent").serialize(),
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
               $("#listeConcurrents").html(html); 
               $("#listeConcurrents").show(); 
               $("#listeSeances").hide(); 
               $("#listeMembresCommission").hide();             
            } 
         });
    });
    
    $('#BtnConcurrents2').click(function btnConcurrents2() 
    { 
        $("#BtnSeancesAO").removeClass("active btn-info");
        $("#BtnConcurrents").removeClass("active btn-info"); 
        $("#BtnConcurrents2").addClass("active btn-info"); 
        $("#BtnConcurrents3").removeClass("active btn-info");     
        $("#chargement").show();
        $.ajax( 
        {    
            type: "POST", 
            enctype:"multipart/form-data",
            url: "rechercherConcurrent.do", 
            data:$("#formAjouterConcurrent2").serialize(),
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
               $("#listeConcurrents").html(html); 
               $("#listeConcurrents").show(); 
               $("#listeSeances").hide(); 
               $("#listeMembresCommission").hide();             
            } 
         });
    });
    
    $('#BtnConcurrents3').click(function btnConcurrents3() 
    { 
        $("#BtnSeancesAO").removeClass("active btn-info");
        $("#BtnConcurrents").removeClass("active btn-info"); 
        $("#BtnConcurrents2").removeClass("active btn-info"); 
        $("#BtnConcurrents3").addClass("active btn-info");      
        $("#chargement").show();
        $.ajax( 
        {    
            type: "POST", 
            enctype:"multipart/form-data",
            url: "rechercherBordereauC.do", 
            data:$("#formAjouterConcurrent3").serialize(),
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
               $("#listeConcurrents").html(html); 
               $("#listeConcurrents").show(); 
               $("#listeSeances").hide(); 
               $("#listeMembresCommission").hide();             
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
            <li><a href="Marches/EnregistrementMarches/EnregistrementMarches.jsp" class="current2"> <input type="button" class="btn btn-default" value= " Cautions " /> </a></li>            
            <li><a href="Marches/Execution/ExecutionMarches.jsp"> <input type="button" class="btn btn-default" value= " Exécution du marché" /></a></li>
            <li><a href="AppelsOffres/OuvertureDesPlis/OuvertureDesPlis.jsp"> <input type="button" class="btn btn-primary" value= " Etat d'avancement" /> </a></li>                    	
            <li><a href="Marches/Depenses.jsp"  > <input type="button" class="btn btn-default" value= " Dépenses " /> </a> </li> 
            <li><a href="GestionPersonnel/GestionPersonnel.jsp"  > <input type="button" class="btn btn-default" value= " Personnels " />  </a> </li>
            <li><a href="GestionPointageChantier/PointageChantier.jsp"  > <input type="button" class="btn btn-default" value= " Pointage chantier " />  </a> </li> 
            <li><a href="GestionMateriels/GestionMateriels.jsp"  > <input type="button" class="btn btn-default" value= " Matériels Chantier" />  </a> </li>
            <li><a href="Marches/ReceptionMarches/ReceptionMarches.jsp" > <input type="button" class="btn btn-default" value= " Réception Marché" /> </a></li>          
     </ul> 	
     </div> 
           <div id="templatemo_content">     
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
                 <center>               
                 <table>
	             <tr>	
	                <td><input type="button" id="BtnSeancesAO"   class="btn btn-default"  value= " Réunions du chantier " size="28"/>  </td>            
		            <td><input type="button" id="BtnConcurrents2"  class="btn btn-default"   value= " Tâches du chantier  " size="28"/>  </td>
		            <td><input type="button" id="BtnConcurrents"  class="btn btn-default"   value= " Suivie des Tâches  " size="28"/>  </td>          		           		           
				    <td><input type="button" id="BtnConcurrents3"  class="btn btn-default"   value= " Travaux exécutés   " size="28"/>  </td>          		           		           			    
				 </tr>
		         </table>
		         </center>
		         		        		                      	        
	             <center>
	             <table bgcolor=""  bordercolor="#000000" class="table " width="1674" border="2">
	             </table>
	             <div id="chargement">               
                 </div>	             
	             </center>
	      </div>
	       </div>  	   	             	           
	            
	             <form id="formAjouterSeance" method="post"> 
	             <input type="hidden" name="idAppelOffre"  id="idAppelOffre1"    value="<%=idAppelOffre%>" size="28"/>					                    	             
	          	 <input type="hidden" name="typeRecherche"  id="typeRecherche"   value="recherche1" size="28"/>					                    	            	          	 
	          	 <input type="hidden" name="idSeance"  id="idSeance"   size="28"/>					                    	            
	             <input type="hidden" name="numSeance"   id="numSeance"  />	                                                   	            	            
		         <input type="hidden" name="typeSeance"   id="typeSeance"    />
	             <input type="hidden" name="dateSeance"  id="dateSeance"   size="20"/> 					         	                 
	             <input type="hidden" name="heureSeance"   id="heureSeance"  />	
	             <input type="hidden" name="minuteSeance"   id="minuteSeance"   />
	             <input type="hidden" name="seanceExamenAt"  id="seanceExamenAt" value="0" /> 
                 <input type="hidden" name="seanceExamenEchantillons"  id="seanceExamenEchantillons" value="0" />                 
                 <input type="hidden" name="seanceExamenOt"  id="seanceExamenOt" value="0" />                     
                 <input type="hidden" name="seanceExamenOf"  id="seanceExamenOf" value="0" />                   
                 <input type="hidden" name="seanceExamenCd"  id="seanceExamenCd" value="0" />                    
	             </form>	             	            
           	           
	             <div class="content_section_box16">
                 <div class="content_section_box_content16">            
                 <center> 
                 <div id="listeSeances">                        
	             </div>
	             <div  id="listeConcurrents">   
                 </div>
	             </center>
	             <form id="formAjouterCommission" method="post"> 
	             <input type="hidden" name="idAppelOffre"  id="idAppelOffre2"  class="newsletter_input"  value="<%=idAppelOffre%>" size="28"/>					                    
	             <input type="hidden" name="idSeance"  id="idSeance2"  class="newsletter_input"  value="" size="28"/>					                    	            	            	           
				 <input type="hidden" name="idMembreCommission" id="idMembreCommission" class="newsletter_input"  value="" size="42"/>  							 
				 <input type="hidden" name="idFonctionnaire" id="idFonctionnaire" class="newsletter_input"  value="" size="42"/>  							 
				 <input type="hidden" name="nomMembreCommission" id="nomMembreCommission" class="newsletter_input"  value="" size="42"/>  			
	             <input type="hidden" name="fonction"  id="fonction"  class="newsletter_input"  value="" size="42"/> 				
	             <input type="hidden" name="role"  id="role"  class="newsletter_input" />
	             <input type="hidden" name="typeCommssion"  id="typeCommssion"  class="newsletter_input"  />	      	              		
	             </form>
	             
	             <form id="formAjouterConcurrent" method="post"> 
	             <input type="hidden" name="idAppelOffre"  id="idAppelOffre3"  value="<%=idAppelOffre%>" size="28"/>					                    
	             <input type="hidden" name="typeRecherche"  id="typeRecherche2" value="recherche1" size="28"/> 					                    
	             <input type="hidden" name="idConcurrent"  id="idConcurrent"   value="" size="28"/>					                    	            	            	           
				 <input type="hidden" name="nomConcurrent" id="nomConcurrent"  value="" size="42"/> 			 
				 <input type="hidden" name="typeDepotPlis" id="typeDepotPlis"  value="" size="42"/>  							 
				 <input type="hidden" name="numDepotPlis" id="numDepotPlis"  value="" size="42"/>  			
	             <input type="hidden" name="dateDepotPlis"  id="dateDepotPlis"   value="" size="42"/> 				
	             <input type="hidden" name="plisAcompleter" id="plisAcompleter"  value="" size="42"/>  			
	             <input type="hidden" name="depotEchantillons"  id="depotEchantillons"   value="" size="42"/> 					             
	             <input type="hidden" name="numDepotEchantillons" id="numDepotEchantillons" value="" size="42"/>  			
	             <input type="hidden" name="dateDepotEchantillons"  id="dateDepotEchantillons"  value="" size="42"/>
	              <input type="hidden" name="adresse" id="adresse"  value="" />  				             
	             </form>
	             
	             <form id="formAjouterConcurrent2" method="post"> 
	             <input type="hidden" name="idAppelOffre"  id="idAppelOffre4"  value="<%=idAppelOffre%>" size="28"/>					                    
	             <input type="hidden" name="typeRecherche"  id="typeRecherche3" value="recherche17" size="28"/> 					                    
	             <input type="hidden" name="idConcurrent"  id="idConcurrent3"   value="" />					                    	            	            	           
				 <input type="hidden" name="nomConcurrent" id="nomConcurrent3"  value="" /> 
				 <input type="hidden" name="adresse" id="adresse3"  value="" />  	 							 
				 <input type="hidden" name="ville" id="ville"  value="" />  							 	
	             <input type="hidden" name="email"  id="email"   value="" /> 				
	             <input type="hidden" name="numTel" id="numTel"  value="" />  			             
	             </form>
	             
	             <form id="formAjouterConcurrent3" method="post"> 
	             <input type="hidden" name="idAppelOffre"  id="idAppelOffre5"  value="<%=idAppelOffre%>" size="28"/>					                    					                    				                    	            	            	           	              
	             </form>
	                         
	             <form id="formAjouterConcurrent7" method="post"> 
	             <input type="hidden" name="idAppelOffre"  id="idAppelOffre7"  class="newsletter_input"  value="<%=idAppelOffre%>" size="28"/>					                    	             
	             <input type="hidden" name="typeRecherche"  id="typeRecherche7"  class="newsletter_input"  value="recherche7" size="28"/> 
	             <input type="hidden" name="idConcurrent"  id="idConcurrent7"  class="newsletter_input"  value="" size="28"/>					                                 					                    
	             <input type="hidden" name="idBordereauAo"  id="idBordereauAo"  class="newsletter_input"  value="" size="28"/>					                                 					                    	             
	             <input type="hidden" name="prixUnitaire"  id="prixUnitaire"  class="newsletter_input"  value="" size="28"/>					                                 					                    
	             <input type="hidden" name="prixPartiel"  id="prixPartiel"  class="newsletter_input"  value="" size="28"/>
	             <input type="hidden" name="prixTotal"  id="prixTotal"  class="newsletter_input"  value="" size="28"/>					                                 					                    
	             <input type="hidden" name="prixForfaitaire"  id="prixForfaitaire"  class="newsletter_input"  value="" size="28"/>					                                 					                    	             
	             </form>	                          
	   	             
	             <form id="formAjouterCaution" method="post"> 
	             <input type="hidden" name="idAppelOffre"  id="idAppelOffre6"  class="newsletter_input"  value="<%=idAppelOffre%>" size="28"/>					                    	             
	        	 <input type="hidden" name="typeConcurrent"  value="" />
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
	             
	             <div id ="dialogAjouterFonctionnaire" title ="Ajouter nouveau membre dans la base des données" > 
	             <form id="formAjouterFonctionnaire" method="post"> 
	             <table>	
	             <tr>
	                 <td > Nom du membre </td>
	                 <td> <input type="text" name="nom" value="Mr. " size="56"/> </td> 				
                 </tr>
                 <tr>
                     <td > Fonction du membre </td>
                     <td> <input type="text" name="fonction"  size="56"/>  </td>
                 </tr>
                 </table>
                 </form>
                 </div>
                 
            <div id = "dialogDocumentsCourrier" title = "Pièces Jointes" >       
            <form id="formDocumentsCourrier" method="post">
            <input type="hidden" name="idCourrier" id="idCourrier1"/> 
            <input type="hidden" name="typeDocument" id="typeDocument1" value="Seance"/>  	
            </form>
            <div id="listeDocumentsCourrier">  </div>
            </div>  
            
            <div id ="dialogAjouterDocument"  title = "Ajouter Pièce Jointe" >
            <center>
           	<form id="formAjouterDocument"  method="post" enctype="multipart/form-data" >
            <input type="hidden" name="idCourrier" id="idCourrier2"/>
            <input type="hidden" name="typeDocument" id="typeDocument2" value="Seance"/>
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
	   	       	        	             	             	             	             	                                                               
     
     </div> 
     </div> 
   
    <div id = "dialogBienEnregistrer" title = "Enregistrement" >
       <font color="#000000"> L'enregistrement a été effectué avec succès  </font>                   	             
    </div> 
    <div id = "dialog1"  >
       <div id="listeMembresCommission">  </div>                       	             
    </div>  
    
    <div id = "dialog3" title = "Supprimer Réunion" >
      <font color="#000000"> Vous voulez supprimer cet Réunion ?   </font>
    </div>
    
    <div id = "dialog2" title = "Supprimer Réunion" >
      <font color="#000000"> Le Réunion a été supprimé avec succès   </font>
      
    </div>  
    <div id = "dialog5" title = "Supprimer membre de l'équipe" >
      <font color="#000000"> Vous voulez supprimer ce membre de l'équipe ?   </font>
    </div>
    
    <div id = "dialog4" title = "Supprimer membre de l'équipe" >
      <font color="#000000"> Le membre de l'équipe a été supprimé avec succès   </font>
     
    </div> 
    <div id = "dialog8" title = "Supprimer Tâche" >
      <font color="#000000"> Vous voulez supprimer cette Tâche ?   </font>
    </div>
    
    <div id = "dialog6" title = "Supprimer Tâche" >
      <font color="#000000"> La Tâche a été supprimé avec succès   </font>
      
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
