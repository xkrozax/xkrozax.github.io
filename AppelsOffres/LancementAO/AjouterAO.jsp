<%@ page language="java" import="java.util.*"   contentType="text/html; charset=UTF-8"%>
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
    String   role = "";
	if ((String) session.getAttribute("role") != null){
      role = (String) session.getAttribute("role");  
    }
    if( ! (role.equals("Représentant Chef Service Marchés") || role.equals("Chef Service Marchés") || role.equals("Chef Division Equipement") )) {
    String site = new String("../../PageNonAutorisee.jsp");
    response.setStatus(response.SC_MOVED_TEMPORARILY);
    response.setHeader("Location", site); 
    } %>
	<script type="text/javascript">
	$(function(){
      
      $("#site_title").load("menuTitre.html"); 
      $("#site_title2").load("menuTitre2.html"); 
      $("#chargement").load("menuChargement.html");
      $("#chargement").hide();
      $("#dialog").hide(); $("#dialog2").hide();
      
      $("#chargement").show();
      $("#natureProgramme").val("Travaux");
       
        $.ajax( 
        {    
            type: "POST", 
            enctype:"multipart/form-data",
            url: "rechercherProgramme2.do", 
            data:$("#formAjouterAppelOffre").serialize(),
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
               $("#idProgramme").html(html);                 
            } 
         });  
    
	$('#ajouterAppelOffre').click(function ajouterAppelOffre() 
    { 
        $("#chargement").show(); 
        $("#ajouterAppelOffre").attr("disabled", "disabled"); 
        $.ajax( 
        {    
            type: "POST", 
            enctype:"multipart/form-data",
            url: "ajouterAppelOffre.do", 
            data:$("#formAjouterAppelOffre").serialize(),
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
               $("#ajouterAppelOffre").removeAttr("disabled");             
               $("#dialog").dialog({
	           autoOpen: true, 
               buttons: {
               OK: function() {
                  $("#dialog").dialog("close");                   
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
               $( "#dialog" ).dialog("open");               
            } 
         }); 
    } 
    ); 
    
    $('#categorieAo').change(function () 
    { 
        $("#chargement").show();
        $("#natureProgramme").val($('#categorieAo').val());
       
        $.ajax( 
        {    
            type: "POST", 
            enctype:"multipart/form-data",
            url: "rechercherProgramme2.do", 
            data:$("#formAjouterAppelOffre").serialize(),
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
               $("#idProgramme").html(html);                 
            } 
         });  
    }); 
    
    $('#anneeProgramme').change(function () 
    { 
        $("#chargement").show();
       
        $.ajax( 
        {    
            type: "POST", 
            enctype:"multipart/form-data",
            url: "rechercherProgramme2.do", 
            data:$("#formAjouterAppelOffre").serialize(),
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
               $("#idProgramme").html(html);                 
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
	
        
    	<div id="site_title">  </div>
        	
		<div id="site_title2">
      
        </div>
        <div id="header_links">
        	
        </div>
    </div> <!-- end of header panel -->

    <div id="templatemo_menu">  	
    <ul class="niveau1">
            <li><a href="Marches/LancementMarches/ListeMarches.jsp" > <input type="button" class="btn btn-default" value= " Liste des marchés " />  </a></li>           
            <li><a href="AppelsOffres/LancementAO/AjouterAO.jsp" > <input type="button" class="btn btn-primary" value= " Nouveau Marché " /> </a></li>           
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
    	
	<div id = "dialog" title = "Ajouter nouveau marché" >
      <font color="#000000"> Le marché a été ajouté avec succès  </font>
    </div>
    
	
	<div id="ajouterAO"> 
    <div id="templatemo_content">
    <center> 
           	  		    
            <div class="content_section_box26">
            <div class="content_section_box_content6">
            <center>----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------</center>	   
            
            <form id="formAjouterAppelOffre" method="post"> 
            <input type="hidden" name="natureProgramme"  id="natureProgramme"  value="" />   
            <table bgcolor=""  bordercolor="#000000" class="table " width ="1620">
			<tr>
		        <td class="" align="left" > N° du marché </td>
				<td><input type="number" name="numAppelOffre" id="numAppelOffre"  class="number_input4"  value="" />  </td>				
	       
	            <td class=""  align="left"> Année du marché </td>
	            <td class=""  align="left"> <select name="anneeAppelOffre"  id="anneeAppelOffre" > 	            
				<% Date dateSysteme = new Date();
			       int yearSysteme = Integer.valueOf(String.format("%1$tY",dateSysteme));
			       				
				   for(int i=yearSysteme;i>=1950;i--){%>
				<option  value="<%=i%>"><%=i%></option>
				<%} %>
				</select>
	            </td>
	            <td class="" align="left" > Référence Appel d'offre </td>
				<td><input type="text" name="referenceAo" id="referenceAo" class="newsletter_input"  value="" size="10"/>  </td>				
	            
		        <td class="" align="left" > Mode de passation </td>
				<td><select name="typeAo" id="typeAo" class="newsletter_input" >  			
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
	            <option  value="Travaux">Travaux</option>
		        <option  value="Fourniture">Fournitures</option>
		        <option  value="Service">Services</option>	        
		        </select>
		        </td>	
		        
	            <td class=""  align="left">  </td>
	            <td class=""  align="left"> <input type="hidden" name="natureAo"  id="natureAo"  class="newsletter_input"  value="" size="28"/> </td>				
	        
	            <td class=""  align="left"> Type de Lot </td>
	            <td class=""  align="left"> <select name="typeLot"  id="typeLot"   > 				
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
	        
            <center> -  </center>
            <center>
            <table    bordercolor="#000000" class="table " width ="" >
     		<tr>
			    <td class="" align="left" > Objet du marché </td>
				<td><input type="text" name="objetAppelOffre" id="objetAppelOffre"   value="" size="78"/>  </td>
				<td class="" align="left" > Maitre d'Ouvrage </td>				
			    <td ><input type="text" name="objetAppelOffre2" id="objetAppelOffre2"  value="" size="50" />  </td>	
			</tr>
			</table>  
	        </center>  
	        <center>-------------</center> 
	        <table    bordercolor="#000000" class="table " width ="" >
     		<tr>
			    <td class="" align="left" > Montant du Marché (TTC)</td>
				<td align="left"><input type="number" name="estimation" id="estimation" class="number_input3"  value="0.00" size="17"/>  </td>				
	            <td class="" align="left" > Cautionnement provisoire </td>
				<td align="left"><input type="number" name="cautionnementP" id="cautionnementP" class="number_input3"  value="0.00" size="17"/>  </td>							    
			    <td class="" align="left" > Date ouverture des plis</td>
				<td><input type="date" name="dateOp" id="dateOp" class="newsletter_input"  value="" size="20"/>  </td>
			</tr>
			</table>  
	     
            
	        <table >    
		    <tr> 
		        <td class="" align="left" >  </td>
				<td align="center"><input type="hidden"  name="serviceAo"   id="serviceAo"  value="" > </td>
           
		        <td class=""  align="right">  </td>
	            <td class=""  align="left"> <input type="hidden" name="anneeProgramme"  id="anneeProgramme"  value="0" > </td> 	            
				<td align="center" width="40" ><input type="hidden" name="idProgramme"  id="idProgramme" value="0">
                </td>	 	                    
           </tr>       
	        </table>
	        
            <center>
            <table   >    
		    <tr>   
		        				
		        <td class="" align="left" >  </td>
				<td><input type="hidden" name="heureOp" id="heureOp" value="0" />  </td>	
				
	            <td class=""  align="left">  </td>
	            <td class=""  align="left"> <input type="hidden" name="minuteOp"  id="minuteOp" value="0" />  </td>			
	            
	            <td class=""  align="left"> </td>
	            <td class=""  align="left"> <input type="hidden" name="lieuOp"  id="lieuOp"  class="newsletter_input"  value="" size="52"/> </td>					        
	            <td class="" align="right"> <input type="hidden" name="lieuOp2"  id="lieuOp2" dir="rtl" class="newsletter_input"  value="" size="52"/> </td>					                    
	            <td class="" align="right" >  </td>
	        </tr>       
	        </table>   
	        </center> 	        
	        
	        <table bgcolor=""  bordercolor="#000000" class="table " width ="1620" >    
		    <tr>   		        
				<td class="" align="left" > Date de Commencement des travaux</td>
				<td><input type="date" name="dateVisiteDesLieux" id="dateVisiteDesLieux" class="newsletter_input"  value="" size="20"/>  </td>
	            <td align="left" > Date Prévue Fin des travaux  </td>
			    <td align="left"><input type="date" name="dateDepotEchantillons" id="dateDepotEchantillons"  value="" size="10"/>  </td>
	            <td class="" align="left" > Délai d'exécution (par mois) </td>
				<td align="left"><input type="number" name="delaisExecution" id="delaisExecution" class="number_input"  value="" />  </td>				
	            <td class="" align="left" > Délai d'exécution (par Jour) </td>
				<td align="left"><input type="number" name="modeDelaiExecution" id="modeDelaiExecution" class="number_input"  value="" />  </td>					            	            
	            <td class="" align="left" > Lieu d'exécution </td>
				<td align="left"><input type="text" name="lieuExecution" id="lieuExecution" class="newsletter_input"  value="" size="42"/>  </td>				
	        </tr>       
	        </table>
	        
	        <table   >    
		    <tr>   		        		        	          
		        <td class="" align="left" >  </td>
				<td align="left"> <input type="hidden" name="heureDepotEchantillons" id="heureDepotEchantillons"  value="0" size="10"/>  </td>	
			
	            <td class=""  align="left">  </td>
	            <td class=""  align="left"> <input type="hidden" name="minuteDepotEchantillons"  id="minuteDepotEchantillons"  value="0" size="10"/>  </td>			
	            	
		        <td class="" align="left" >  </td>
				<td align="left"><input type="hidden" name="lieuDepotEchantillons" id="lieuDepotEchantillons" class="newsletter_input"  value="" size="62"/>  </td>				                   
	        </tr>       
	        </table>      
	       
	        <table  >    
		    <tr>   
		        <td align="left" >   </td>
			    <td align="left">  </td>	          
		        <td class="" align="left" >  </td>
				<td align="left"><input type="hidden" name="heureVisiteDesLieux" id="heureVisiteDesLieux" value="0" size="10"/>  </td> 	
				
	            <td class=""  align="left">  </td>
	            <td class=""  align="left"> <input type="hidden" name="minuteVisiteDesLieux"  id="minuteVisiteDesLieux"  value="0" size="10"/>  </td>		
	            
		        <td class="" align="left" >  </td>
				<td align="left"><input type="hidden" name="numArticlePieceJ" id="numArticlePieceJ" class="newsletter_input"  value="" size="8"/>  </td>						        
		        <td align="left" > <input type="hidden" name="reserverPme"  id="reserverPme" value="0" /> </td>        
	        </tr>       
	        </table> 	
	        
	        <table bgcolor=""  bordercolor="#000000" class="table " >    
		    <tr>   
		        <td class="" align="left" > Secteur </td>
				<td align="left"><input type="text" name="secteur" id="secteur"  value="" size="20"/>  </td>				
	            <td class="" align="left" > Qualification </td>
				<td align="left"><input type="text" name="qualification" id="qualification"  value="" size="20"/>  </td>				
	            <td class="" align="left" > Classe </td>
				<td align="left"><input type="text" name="classe" id="classe"  value="" size="20"/>  </td>				
	        </tr>       
	        </table>        
	        <center>--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------</center>
            <table>
	        <tr>
	            <td class="" align="right"> </td>
		        <td class="" align="right"> </td>
		        <td><input type="button" id="ajouterAppelOffre"  class="btn btn-default" value="  Enregistrer  " size="35"/>  </td>
		        <td class="" align="right"> </td>
		        <td class="" align="right"> </td>
	        </tr>
	        </table>	        
	        <div id="chargement">               
            </div>             
	     
	        </form>
	        </div>         
            </div>  
	        </center>
	        </div>         
            </div>  	      
	                    
 </div>  
    <!-- end of content -->
    
<!-- Free Website Templates @ TemplateMo.com -->
 <!-- end of container -->
  </body>  
</html>
