<%@ page language="java" import="java.util.*"  import="metier.Caisse" import="metier.Utilisateur"  import="metier.Appelsoffres" import="metier.Chefprojet"   import="java.math.BigDecimal" contentType="text/html; charset=UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title> Gestion Matériels </title>
    
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
    String site = new String("../PageNonAutoriseeMarches.jsp");
    response.setStatus(response.SC_MOVED_TEMPORARILY);
    response.setHeader("Location", site); 
    }
    %>
    <% 
    Date dateSysteme = new Date();
    int yearSysteme = Integer.valueOf(String.format("%1$tY",dateSysteme));
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
	Caisse caisseAssurance=null;
    caisseAssurance=(Caisse)session.getAttribute("CaisseAssurance");
    Integer idCaisseAssurance=0;  
	BigDecimal montantDeCaisseAssurance=new BigDecimal("00.00").setScale(2, BigDecimal.ROUND_DOWN);   
    if (caisseAssurance != null) {
    idCaisse = caisseAssurance.getIdCaisse();
	if (caisseAssurance.getMontantDeCaisse() != 0.00) {
	montantDeCaisseAssurance = new BigDecimal( (caisseAssurance.getMontantDeCaisse().toString()) ).setScale(2, BigDecimal.ROUND_DOWN);    
	}
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
    String site = new String("../DossierMarchesNonOuvert.jsp");
    response.setStatus(response.SC_MOVED_TEMPORARILY);
    response.setHeader("Location", site); 
    }
	%>
	<script type="text/javascript">
	function rechercherOperation() 
    { 
        $("#chargement").show();  
        $.ajax( 
        {    
            type: "POST", 
            enctype:"multipart/form-data",
            url: "rechrcherOperationFinanciere.do", 
            data:$("#formRechercherListeOperation").serialize(),
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
               $("#listeOperation").html(html);
               $("#listeOperation").show();             
            } 
         }); 
     }
	$(function(){
      
      $("#site_title").load("menuTitre.html"); 
      $("#site_title2").load("menuTitre2.html"); 
      $("#chargement").load("menuChargement.html");
      $("#chargement").hide();
      $("#bienAjouter").hide();
      $("#dialogBienEnregistrer").hide();$("#dialogBienValider").hide();
      $("#dialog").hide(); $("#dialog1").hide(); $("#dialog2").hide();
      $("#dialog3").hide(); $("#dialog4").hide();$("#dialog5").hide(); $("#dialog6").hide();
      $("#compteBancaire").hide();  $("#dialogAjouterOperationFinanciere").hide();  
      $("#dialogDocumentsCourrier").hide();$("#dialogAjouterDocument").hide();
      $("#dialogSupprimerPieceJointe1").hide();$("#dialogSupprimerPieceJointe2").hide(); 
     
     rechercherOperation();
     
    $("#chargement").show();  
        $.ajax( 
        {    
            type: "POST", 
            enctype:"multipart/form-data",
            url: "getSousArticle.do", 
            data:$("#formRechercherListeOperation").serialize(),
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
               $("#idSousArticle").html(html); 
               $("#idSousArticle2").html(html);        
            } 
         });
        
    
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
    
    $('#idArticle').change(function()  {     
      $("#chargement").show();  
        $.ajax( 
        {    
            type: "POST", 
            enctype:"multipart/form-data",
            url: "getSousArticle.do", 
            data:$("#formRechercherListeOperation").serialize(),
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
               $("#idSousArticle").html(html);       
            } 
         });
       });    
       
      $('#idArticle2').change(function()  {     
      $("#chargement").show();  
        $.ajax( 
        {    
            type: "POST", 
            enctype:"multipart/form-data",
            url: "getSousArticle.do", 
            data:$("#formAjouterOperationFinanciere").serialize(),
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
               $("#idSousArticle2").html(html);       
            } 
         });
       });    
    $('#rechercherOperation').click(function rechercherOperation() 
    { 
        $("#chargement").show();  
        $.ajax( 
        {    
            type: "POST", 
            enctype:"multipart/form-data",
            url: "rechrcherOperationFinanciere.do", 
            data:$("#formRechercherListeOperation").serialize(),
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
               $("#listeOperation").html(html);
               $("#listeOperation").show();             
            } 
         }); 
     }); 
    
    $('#ajouterOperation').click(function ajouterOperation() 
    {             
               $("#dialogAjouterOperationFinanciere").dialog({
	           autoOpen: true,              
               width: 600,
               height: 440,        
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
               $( "#dialogAjouterOperationFinanciere" ).dialog( "open" );                                    
    } 
    );    
    
    $('#ajouterOperationFinanciere').click(function ajouterOperationFinanciere() 
    {             
                     $("#chargement").show();
                     $("#ajouterOperationFinanciere").attr("disabled", "disabled");
                     $.ajax( 
                           {    
                            type: "POST", 
                            enctype:"multipart/form-data",
                            url: "ajouterOperationFinanciere.do", 
                            data:$("#formAjouterOperationFinanciere").serialize(),
                            dataType: "html", 
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
                            $("#ajouterOperationFinanciere").removeAttr("disabled");                                              
                            $("#dialogAjouterOperationFinanciere").dialog("close");                          
                            //location.reload(true);                       
                            rechercherOperation();
                            afficherBienEnregistrer();
                           }
                      });                                             
    } 
    );    
    
    $('#type').change(function()  { 
    		if($(this).val()=="Versement en Banque"){
    			$("#compteBancaire").show();  
    		} else {
    			$("#compteBancaire").hide();  
    		}    
       	});    
    
     
   $('#idSousArticle2').change(function()  {    
       $("#chargement").show();  
        $.ajax( 
        {    
            type: "POST", 
            enctype:"multipart/form-data",
            url: "getPrixSousArticle.do", 
            data:$("#formAjouterOperationFinanciere").serialize(),
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
               $("#montantTotal").html(html); 
               $("#montant").val(html);  
            } 
         });    
     }); 
     $('#quantite').keyup(function()  {     
       $("#chargement").show();  
        $.ajax( 
        {    
            type: "POST", 
            enctype:"multipart/form-data",
            url: "getPrixSousArticle.do", 
            data:$("#formAjouterOperationFinanciere").serialize(),
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
               $("#montantTotal").html(html);
               $("#montant").val($("#montantTotal").val());         
            } 
         }); 
     });                            
    $('#exporterDepensesEnEspece').click(function exporterDepensesEnEspece() 
    {         
        $("#chargement").show();
        $.ajax( 
        {    
            type: "POST", 
            enctype:"multipart/form-data",
            url: "exporterDepensesEnEspece.do", 
            data:$("#formRechercherListeOperation").serialize(),
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
               window.location.replace("../../GestionMarches/Fichiers/ListeDesDesenses.pdf");                         
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
                window.location.replace("../GestionMarches/GestionMarchesPublics.jsp");             
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
            <li><a href="AppelsOffres/OuvertureDesPlis/OuvertureDesPlis.jsp"> <input type="button" class="btn btn-default" value= " Etat d'avancement" /> </a></li>                    	
            <li><a href="Marches/Depenses.jsp"  > <input type="button" class="btn btn-default" value= " Dépenses " /> </a> </li> 
            <li><a href="GestionPersonnel/GestionPersonnel.jsp"  > <input type="button" class="btn btn-default" value= " Personnels " />  </a> </li>
            <li><a href="GestionPointageChantier/PointageChantier.jsp"  > <input type="button" class="btn btn-default" value= " Pointage chantier " />  </a> </li> 
            <li><a href="GestionMateriels/GestionMateriels.jsp"  > <input type="button" class="btn btn-primary" value= " Matériels Chantier" />  </a> </li>
            <li><a href="Marches/ReceptionMarches/ReceptionMarches.jsp" > <input type="button" class="btn btn-default" value= " Réception Marché" /> </a></li>          
    </ul>
    </div> <!-- end of menu -->
    
    
    <div id="templatemo_content">
                        		  		    
            <center>         		  		           
            <div class="content_section_box26">
            <div class="content_section_box_content6">
            <center>----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------</center>	   
            <table border="0" bgcolor="#D8D38D"   class="table" width=""  >
            <tr>
		        <td align="center">  <font color="#0B3573"> N° du marché : </font> <font color="#000000"> <%=numMarches%> </font> </td>	
		        <td align="center">  <font color="#0B3573"> Objet du marché : </font> <font color="#000000"> <%=objetAppelOffre%> </font> </td>		        
			</tr>		       
	        </table>
	        <center>----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------</center>	   
	        <center>
	        <form id="formRechercherListeOperation" method="post"> 
	        <input type="hidden" name="idAppelOffre"  value="<%=idAppelOffre%>" />	
	        <input type="hidden" name="type" value="Alimentation de caisse"/>  
	        <input type="hidden" name="categorie"  value="Materiel"/> 
	        <input type="hidden" name="typeArticle" value="Recette"/>
	        <input type="hidden" name="idFournisseur" value="0"/>
	        <table bordercolor="2" class="table ">	
			<tr>
				<td> Article </td>
				<td><select name="idArticle"  id="idArticle">	
				    <option  value="1">Engins/Véhicule</option>	
				    </select>
				</td>
				<td>  Sous Article </td>
				<td><select name="idSousArticle" id="idSousArticle"  >
				     <option  value="0"></option>		
				    </select>
				</td>		
			    <td> Année </td>
				<td><select name="annee">
				<option  value="0"></option>	  
				<%for(int i=yearSysteme;i>=2023;i--){%>
				<option  value="<%=i%>"><%=i%></option>				
				<%} %>	
				</select>
				</td>
				<td> Mois </td>
				<td><select name="mois">
				    <option  value="0"></option>
				    <option  value="1">Janvier</option><option  value="2">Février</option>	  
				    <option  value="3">Mars</option>	<option  value="4">Avril</option>
				    <option  value="5">Mai</option>	<option  value="6">Juin</option>
				    <option  value="7">Juillet</option>	<option  value="8">Août</option>
				    <option  value="9">Septembre</option>	<option  value="10">Octobre</option>
				    <option  value="11">Dovembre</option>	<option  value="12">Décembre</option>				
				</select>
				</td>	
				<td> De </td>
				<td><input type="date" name="date1" size="20"/>  </td>	
				<td> à </td>
				<td><input type="date" name="date2" size="20"/>  </td>							    
		    </table>		    
		    <center>-----------------------------------------------------------------------------------------------------------------</center>                 	        	                          
			<table>
	        <tr>
		        <td><input type="button" id="rechercherOperation"  class="btn btn-default"  value="  Rechercher  " size="35"/>  </td>
		        <td><input type="button" id="ajouterOperation"  class="btn btn-default"  value="  Nouvelle Affectation " size="35"/>  </td>
	        </tr>
	        </table>	    		                    					                    	             	             	             	                          
		    </form>	
		    <center>----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------</center>	   			 	                    	        	              		    
	        <div id="chargement"> </div>	
	        <div id="listeOperation"> </div>	
	        </center>                                                     	        	       	     	             
	        </div> 
            </div>
            </center>            
	             	              	             
	             <form id="formModifierOperationFinanciere" method="post">
	                <input type="hidden" name="idOperation" id="idOperation" value="" /> 
	                <input type="hidden" name="typeModification" id="typeModification"  value="" /> 
	                <input type="hidden" name="statut" id="statut"   />   
	                <input type="hidden" name="type"  value="Caisse" />		 	        	 	      	         
	        	 </form>
	        	 <form id="formSupprimerOperationFinanciere" method="post">
	                <input type="hidden" name="idOperation" id="idOperation2" value="" />     	 	        	 	      	         
	        	 </form>
	        	 
	      <div id = "dialogAjouterOperationFinanciere" title = "Ajouter Affectation" >   	         	
	      <form id="formAjouterOperationFinanciere" method="post"> 
	      <input type="hidden" name="idUser"  value="" />
	      <input type="hidden" name="nomUser"  value="" />
	      <input type="hidden" name="type" id="type" value="Alimentation de caisse"/>
	      <input type="hidden" name="categorie" id="categorie" value="Caisse"/>      
	      <input type="hidden" name="montant" id="montant" size="40"/> 
	      <input type="hidden" name="modePaiement" id="modePaiement" size="40"/>
	      <input type="hidden" name="objet" id="objet" size="40"/>  
	      <input type="hidden" name="idAppelOffre"  value="<%=idAppelOffre%>" />
	      <input type="hidden" name="idFournisseur" value="0"/>
	      <table bgcolor=""  bordercolor="#000000" class="table " width="" >
			<tr>
			    <td> Article </td>		
				<td><select name="idArticle"  id="idArticle2">	
				    <option  value="1">Engins/Véhicule</option>	
				    </select>
				</td>
			</tr>
			<tr>
			     <td> Engins-Véhicule </td>	
				<td><select name="idSousArticle" id="idSousArticle2"  >		
				     <option  value="0"></option>
				    </select>
				</td>	
			</tr>	
			<tr> 				
		        <td> Date Entrée au chantier </td>
				<td><input type="date" name="date" id="date" size="40"/>  </td>
			</tr>
			<tr> 				
		        <td> Quantité </td>
				<td><input type="number" name="quantite" id="quantite" value="1" class="number_input3"/>  </td>
			</tr>
           <tr> 	
				<td> Responsable </td>
				<td> <input type="text" name="personne" id="personne" size="50"/> </td>			     
		   </tr>  
		   <tr> 	
				<td> Remarque </td>
				<td> <input type="text" name="remarque" id="remarque" size="50"/> </td>			     
		   </tr>
		   <tr> 
		        <td>  </td>	
		        <td align="right"> <input type="button" id="ajouterOperationFinanciere"  class="btn btn-default"  value="  Enregistrer  " size="35"/>  </td>
		   </tr> 	   
		   </table>				                    					                    	             	             	             	                          
		         </form>
		         </div> 	
		         
		         
		     <div id = "dialogDocumentsCourrier" title = "Pièces Jointes" >       
            <form id="formDocumentsCourrier" method="post">
            <input type="hidden" name="idCourrier" id="idCourrier1"/> 
            <input type="hidden" name="typeDocument" id="typeDocument1" value="Depense"/>  	
            </form>
            <div id="listeDocumentsCourrier">  </div>
            </div>  
            
            <div id ="dialogAjouterDocument"  title = "Ajouter Pièce Jointe" >
            <center>
           	<form id="formAjouterDocument"  method="post" enctype="multipart/form-data" >
            <input type="hidden" name="idCourrier" id="idCourrier2"/>
            <input type="hidden" name="typeDocument" id="typeDocument2" value="Depense"/>
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
     <div id = "dialogBienValider" title = "Enregistrement" >
       <font color="#000000"> La validation a été effectué avec succès  </font>                   	             
    </div> 
    <div id = "dialog2" title = "Supprimer Operation" >
      <font color="#000000"> Vous voulez supprimer cette Operation ?   </font>
    </div>   
    <div id = "dialog1" title = "Supprimer Operation" >
      <font color="#000000"> Cette Operation a été supprimé avec succès   </font>   
    </div>
    <div id = "dialog4" title = "Valider Operation" >
      <font color="#000000"> Vous voulez valider cette Operation ?   </font>
    </div>   
    <div id = "dialog3" title = "Valider Operation" >
      <font color="#000000"> Cette Operation a été validé avec succès   </font>   
    </div>
    <div id = "dialog6" title = "Enregistrement de l'opération" >
      <font color="#000000"> Vous voulez valider cette Operation ?   </font>
    </div>   
    <div id = "dialog5" title = "Enregistrement de l'opération" >
      <font color="#000000"> L'enregistrement a été réalisée avec succès   </font>   
    </div>
    <div id = "dialog" title = "Enregistrement de l'opération" >
      <font color="#000000"> L'enregistrement a été réalisée avec succès   </font>  
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
