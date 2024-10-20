<%@ page language="java" import="java.util.*" import="metier.Personnel" import="java.math.BigDecimal" import="metier.Appelsoffres"  import="metier.Chefprojet" contentType="text/html; charset=UTF-8"%>
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
    Date dateSysteme = new Date();
    int yearSysteme = Integer.valueOf(String.format("%1$tY",dateSysteme));
    int moisSysteme = dateSysteme.getMonth()+1;
    Personnel selectedPersonnel = (Personnel) session.getAttribute("Personnel");
    selectedPersonnel = selectedPersonnel!=null? selectedPersonnel: new Personnel();
    %>
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
	function recupererBulletinPaie(){
	   
	    $("#chargement").show();         
	   	$.ajax({    
            type: "POST", 
            enctype:"multipart/form-data",
            url: "rechercherListeBulletinPaie.do", 
            data:$("#formRechercherBulletinPaie").serialize(),
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
	function AjouterListeBulletinPaie(){ 
	    
	    $("#chargement").show(); 
	   	$.ajax({    
            type: "POST", 
            enctype:"multipart/form-data",
            url: "ajouterListeBulletinPaie.do", 
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
            } 
         }); 
	   };   
	$(function(){
	
	  $("#idPersonne").val(<%=selectedPersonnel.getIdPersonnel()%>);
      $("#moisBulletinPaie").val(<%=moisSysteme%>);
      $("#anneeBulletinPaie").val(<%=yearSysteme%>);
     
      $("#site_title2").load("menuTitre2.html"); 
      $("#chargement").load("menuChargement.html");
      $("#chargement").hide();        
      $("#dialogAjouterBulletinPaie").hide();
      $("#dialogBienEnregistrer").hide();$("#dialogBienModifier").hide();
      $("#dialog4").hide();$("#dialog5").hide();$("#dialogModifier").hide(); 
      $("#dialogBienValider").hide();$("#dialogValider").hide();;$("#dialogAjouterPrime").hide();
      $("#numContratAnapec").attr("disabled", 'disabled'); 
      
      $("#chargement").show();
      //AjouterListeBulletinPaie();
      recupererBulletinPaie();
      

	  $("#rechercherBulletinPaie").click(function rechercherBulletinPaie(){ 
          recupererBulletinPaie();
      }); 
      
      $("#ajouterJournalPaie").click(function ajouterJournalPaie2(){ 
          $("#chargement").show(); 
	   	  $.ajax({    
            type: "POST", 
            enctype:"multipart/form-data",
            url: "ajouterListeBulletinPaie.do", 
            data:$("#formRechercherBulletinPaie").serialize(),
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
               recupererBulletinPaie();                   
            } 
         });
      }); 
     
      $("#ajouterBulletinPaie").click(function ajouterBulletinPaie(){         
               $("#dialogAjouterBulletinPaie").dialog({
	           autoOpen: true, 
               buttons: {
               Enregistrer: function() {
                     $.ajax({    
                            type: "POST", 
                            enctype:"multipart/form-data",
                            url: "ajouterBulletinPaie.do", 
                            data:$("#formAjouterBulletinPaie").serialize(),
                            dataType: "html", 
                            error: function(){ 
                             	alert("invalid"); 
                             	$("#chargement").hide();                  
                            }, 
                            beforeSend : function(){ 
                            }, 
                            success: function(html){                                                       
                            	$("#dialogAjouterBulletinPaie").dialog("close");
                            	afficherBienEnregistrer();
                            }
                      }); 
                  },
               },
               width: '80%',
               height: 420,        
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
               $( "#dialogAjouterBulletinPaie" ).dialog( "open" );                                    
      }); 
    
        $('#contratAnapec').change(function()  { 
    		if($(this).val()=="oui"){
    			$("#numContratAnapec").removeAttr("disabled");  
    		} else {
    			$("#numContratAnapec").attr("disabled", true);  
    		}    
       	 });
     
   
    $('#exporterJournalPaieAnnuelle').click(function exporterJournalPaieAnnuelle() 
    {         
        $("#chargement").show();
        $.ajax( 
        {    
            type: "POST", 
            enctype:"multipart/form-data",
            url: "exporterJournalPaieAnnuelle.do", 
            data:$("#formRechercherBulletinPaie").serialize(),
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
               window.location.replace("../../GestionEntrepriseBTP/Fichiers/JournalDePaie.pdf");                         
            } 
         }); 
    });
       
     
    
    
         
    
    $('#exporterJournalPaie').click(function exporterJournalPaie() 
    {         
        $("#chargement").show();
        $.ajax( 
        {    
            type: "POST", 
            enctype:"multipart/form-data",
            url: "exporterJournalPaie.do", 
            data:$("#formRechercherBulletinPaie").serialize(),
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
    			   window.location.replace("../../GestionEntrepriseBTP/Fichiers/JournalDePaie.pdf");                      
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
    	<table  >	     	    
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
    <div id = "dialog5" title = "Supprimer le bulletin de paie" >
      <font color="#000000"> Vous voulez supprimer ce bulletin de paie </font>
    </div>
    
    <div id = "dialog4" title = "Supprimer le bulletin de paie" >
      <font color="#000000"> Le bulletin de paie a été supprimé avec succès   </font>     
    </div>
    
    <div id = "dialogModifier" title = "Enregistrer les données du bulletin de paie" >
      <font color="#000000"> Vous voulez enregistrer ce bulletin de paie !  </font>    
    </div>
    
    <div id = "dialogValider" title = "Valider les données du bulletin de paie" >
      <font color="#000000"> Vous voulez valider ce bulletin de paie !  </font>    
    </div>
    
    <div id = "dialogBienValider" title = "Validation" >
       <font color="#000000"> La validation a été effectué avec succès  </font>                   	             
    </div>
         
    <div id="templatemo_content">
         <center>         		  		    
            <form id="formModifierBulletinPaie" method="post">
            
            </form>  
            <div class="content_section_box26">
            <div class="content_section_box_content6">
            
         <center>----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------</center>	   
         <form id="formRechercherBulletinPaie" method="post">  
            <input type="hidden" name="idBulletinPaie" id="idBulletinPaie"/>
            <input type="hidden" name="idPersonnel" id="idPersonnel"/>
            <input type="hidden" name="idAppelOffre"   value="<%=idAppelOffre%>"/>
            <input type="hidden" name="modeReglement" id="modeReglement"/>
            <input type="hidden" name="dateReglement" id="dateReglement"/>
            <input type="hidden" name="salaireParHeure" id="salaireParHeure" value="00.00"/> 
            <input type="hidden" name="salaireParJour" id="salaireParJour" value="00.00"/>        
            <input type="hidden" name="dateReglementListeBulletin" id="dateReglementListeBulletin"/>
            <input type="hidden" name="montantPayer" id="montantPayer"/>
            <input type="hidden" name="jour1" id="jour1" value="00.00"/>
            <input type="hidden" name="jour2" id="jour2" value="00.00"/>
            <input type="hidden" name="jour3" id="jour3" value="00.00"/>
            <input type="hidden" name="jour4" id="jour4" value="00.00"/>
            <input type="hidden" name="jour5" id="jour5" value="00.00"/>
            <input type="hidden" name="jour6" id="jour6" value="00.00"/>
            <input type="hidden" name="jour7" id="jour7" value="00.00"/>
            <input type="hidden" name="jour8" id="jour8" value="00.00"/>
            <input type="hidden" name="jour9" id="jour9" value="00.00"/>
            <input type="hidden" name="jour10" id="jour10" value="00.00"/>
            <input type="hidden" name="jour11" id="jour11" value="00.00"/>
            <input type="hidden" name="jour12" id="jour12"/>
            <input type="hidden" name="jour13" id="jour13"/>
            <input type="hidden" name="jour14" id="jour14"/>
            <input type="hidden" name="jour15" id="jour15"/>
            <input type="hidden" name="jour16" id="jour16"/>
            <input type="hidden" name="jour17" id="jour17"/>
            <input type="hidden" name="jour18" id="jour18"/>
            <input type="hidden" name="jour19" id="jour19"/>
            <input type="hidden" name="jour20" id="jour20"/>
            <input type="hidden" name="jour21" id="jour21"/>
            <input type="hidden" name="jour22" id="jour22"/>
            <input type="hidden" name="jour23" id="jour23"/>
            <input type="hidden" name="jour24" id="jour24"/>
            <input type="hidden" name="jour25" id="jour25"/>
            <input type="hidden" name="jour26" id="jour26"/>
            <input type="hidden" name="jour27" id="jour27"/>
            <input type="hidden" name="jour28" id="jour28"/>
            <input type="hidden" name="jour29" id="jour29"/>
            <input type="hidden" name="jour30" id="jour30"/>
            <input type="hidden" name="jour31" id="jour31"/>
            
            <input type="hidden" name="heurejour1" id="heurejour1"/>
            <input type="hidden" name="heurejour2" id="heurejour2"/>
            <input type="hidden" name="heurejour3" id="heurejour3"/>
            <input type="hidden" name="heurejour4" id="heurejour4"/>
            <input type="hidden" name="heurejour5" id="heurejour5"/>
            <input type="hidden" name="heurejour6" id="heurejour6"/>
            <input type="hidden" name="heurejour7" id="heurejour7"/>
            <input type="hidden" name="heurejour8" id="heurejour8"/>
            <input type="hidden" name="heurejour9" id="heurejour9"/>
            <input type="hidden" name="heurejour10" id="heurejour10"/>
            <input type="hidden" name="heurejour11" id="heurejour11"/>
            <input type="hidden" name="heurejour12" id="heurejour12"/>
            <input type="hidden" name="heurejour13" id="heurejour13"/>
            <input type="hidden" name="heurejour14" id="heurejour14"/>
            <input type="hidden" name="heurejour15" id="heurejour15"/>
            <input type="hidden" name="heurejour16" id="heurejour16"/>
            <input type="hidden" name="heurejour17" id="heurejour17"/>
            <input type="hidden" name="heurejour18" id="heurejour18"/>
            <input type="hidden" name="heurejour19" id="heurejour19"/>
            <input type="hidden" name="heurejour20" id="heurejour20"/>
            <input type="hidden" name="heurejour21" id="heurejour21"/>
            <input type="hidden" name="heurejour22" id="heurejour22"/>
            <input type="hidden" name="heurejour23" id="heurejour23"/>
            <input type="hidden" name="heurejour24" id="heurejour24"/>
            <input type="hidden" name="heurejour25" id="heurejour25"/>
            <input type="hidden" name="heurejour26" id="heurejour26"/>
            <input type="hidden" name="heurejour27" id="heurejour27"/>
            <input type="hidden" name="heurejour28" id="heurejour28"/>
            <input type="hidden" name="heurejour29" id="heurejour29"/>
            <input type="hidden" name="heurejour30" id="heurejour30"/>
            <input type="hidden" name="heurejour31" id="heurejour31"/>
            
         <table bgcolor=""  bordercolor="#000000" class="table " >
			<tr>								
					
			    <td> Mois  </td>
			    <td> 
					<select name="moisBulletinPaie" id="moisBulletinPaie">  
			            <option  value="1">Janvier</option>
			            <option  value="2">Février</option>
			            <option  value="3">Mars</option>
			            <option  value="4">Avril</option>
			            <option  value="5">Mai</option>
			            <option  value="6">Juin</option>
			            <option  value="7">Juillet</option>
			            <option  value="8">Août</option>
			            <option  value="9">Septembre</option>
			            <option  value="10">Octobre</option>
			            <option  value="11">Novembre </option>
			            <option  value="12">Décembre </option>
			        </select>
				</td>
				<td> Année  </td>
				<td>  
					<select name="anneeBulletinPaie" id="anneeBulletinPaie">  
						<% for(int i=yearSysteme;i>=2014;i--){%>
							<option  value="<%=i%>"><%=i%></option>
						<%} %>
			        </select>
				 </td>
				 <td> </td>
				<td><input type="hidden" name="nom"  size="20"/>  </td>							
		        <td>  </td>
				<td><input type="hidden" name="numcnss" size="20"/>  </td>
				<td>  </td>	
				<td><input type="hidden" name="cin" size="20"/>  </td>
				<td>  </td>
				<td>  <input type="hidden" name="contratAnapec" value="Non">   </td>			
			               		        						
			</tr>
		 </table>	          	        	       	       
         <table>
	        <tr>
		        <td><input type="button" id="rechercherBulletinPaie"  class="btn btn-default"  value="  Rechercher  " size="35"/>  </td>
	            <td><input type="button" id="ajouterJournalPaie"  class="btn btn-default"  value="  Fiche de Pointage  " size="35"/>  </td> 
	            <td><input type="button" id="exporterJournalPaie"  class="btn btn-default2"   value="  Journal de Paie  " size="35"/>  </td>                                                        
	       </tr>
	     </table>
	   </form>	
	   <center>----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------</center>	   
	   <div id="chargement"> </div>	
       <div id="resultatRecherche"></div> 
        
        <div id = "dialogAjouterPrime" title = "Ajouter Prime / Indemnité " >       
        <form id="formAjouterPrime" method="post">
         <input type="hidden" name="idBulletinPaie" id="idBulletinPaie2" value="" />
		 <table bgcolor=""  bordercolor="#000000" class="table " width="" >
		   <tr> 	
				<td> Indemnité de déplacement et de frais de déplacement </td>
				<td> <input type="number" name="indemniteDeDeplacement" id="IndemniteDeDeplacement" class="number_input4" value="00.00" /> </td>
				<td> Indemnité de transport vers le lieu de travail </td>
				<td><input type="number" name="indemniteDeTransport" id="IndemniteDeTransport" class="number_input4" value="00.00" />  </td>	
		   </tr>
		   <tr>   
		        <td> Voiture de fonction ou de service </td>
				<td>  <input type="number" name="primeVoitureDeFonction" id="PrimeVoitureDeFonction" class="number_input4" value="00.00" />  </td>   
				<td> Prime de tournée </td>
				<td>  <input type="number" name="primeDeTournee" id="PrimeDeTournee" class="number_input4" value="00.00" />  </td>
				
			</tr>
		   <tr>   
		        <td> Prime d’outillage </td>
				<td>  <input type="number" name="primeOutillage" id="PrimeOutillage" class="number_input4" value="00.00" />  </td>   
				<td> Prime de salissure d’usure des vêtements </td>
				<td>  <input type="number" name="primeSalissure" id="PrimeSalissure" class="number_input4" value="00.00" />  </td>
				
			</tr>
			<tr> 				
		        <td> Prime de panier, de casse croûte ou de cantine </td>
				<td><input type="number" name="primePanier" id="PrimePanier" class="number_input4" value="00.00"/>  </td>
				<td> Bons représentatifs des frais de nourriture </td>
				<td> <input type="number" name="primeBonsRepresentatifs" id="PrimeBonsRepresentatifs" class="number_input4" value="00.00"/> </td>
		   </tr>
		   <tr> 	
				<td> Repas servis à l’occasion du mois de ramadan </td>
				<td> <input type="number" name="primeRepasRamadan" id="PrimeRepasRamadan" class="number_input4" value="00.00"/> </td>	
		        <td> Dépenses relatives aux postes téléphoniques </td>
				<td><input type="number" name="primeDepensesTelephoniques" id="PrimeDepensesTelephoniques" class="number_input4" value="00.00"/>  </td>	
		   </tr>
		   <tr> 	
				<td> Indemnité de licenciement </td>
				<td> <input type="number" name="indemniteDeLicenciement" id="IndemniteDeLicenciement" class="number_input4" value="00.00" /> </td>
				<td> Indemnité de lait </td>
				<td><input type="number" name="indemniteDeLait" id="IndemniteDeLait" class="number_input4" value="00.00" />  </td>	
		   </tr>
		   <tr> 	
				<td> Indemnité d’utilisation de véhicule personnel </td>
				<td> <input type="number" name="indemniteVehiculePersonnel" id="IndemniteVehiculePersonnel" class="number_input4" value="00.00" /> </td>
				<td> Indemnité de déménagement </td>
				<td><input type="number" name="indemniteDeDemenagement" id="IndemniteDeDemenagement" class="number_input4" value="00.00" />  </td>	
		   </tr>
		   <tr> 	
				<td> Indemnité de caisse </td>
				<td> <input type="number" name="indemniteDeCaisse" id="IndemniteDeCaisse" class="number_input4" value="00.00" /> </td>
				<td> Indemnité de représentation </td>
				<td><input type="number" name="indemniteDeRepresentation" id="IndemniteDeRepresentation" class="number_input4" value="00.00" />  </td>	
		   </tr>   
		    <tr> 	
				<td> Indemnité journalière </td>
				<td> <input type="number" name="indemniteJournaliere" id="IndemniteJournaliere" class="number_input4" value="00.00" /> </td>
				<td> Salaire maintenu en totalité ou en partie </td>
				<td><input type="number" name="primeSalaireMaintenu" id="PrimeSalaireMaintenu" class="number_input4" value="00.00" />  </td>	
		   </tr>
		   <tr> 	
				<td> Aide médicale </td>
				<td> <input type="number" name="primeAideMedicale" id="PrimeAideMedicale" class="number_input4" value="00.00" /> </td>
				<td> Gratifications sociales liées à un événement familial </td>
				<td><input type="number" name="primeGratificationsSociales" id="PrimeGratificationsSociales" class="number_input4" value="00.00" />  </td>	
		   </tr>
		   <tr> 	
				<td> Indemnité de stage formation insertion professionnelle </td>
				<td> <input type="number" name="indemniteStageFormation" id="IndemniteStageFormation" class="number_input4" value="00.00" /> </td>
				<td> Allocation de stage </td>
				<td><input type="number" name="indemniteAllocationDeStage" id="IndemniteAllocationDeStage" class="number_input4" value="00.00" />  </td>	
		   </tr>
	
		  </table>		
		 </form>
        </div>  
                                	             
	   </div> 
      </div>      	        
	 </center>
    </div> 				
   </div>
              	  
    <!-- end of content -->
    
<!-- Free Website Templates @ TemplateMo.com -->
 <!-- end of container -->
  </body>  
</html>
