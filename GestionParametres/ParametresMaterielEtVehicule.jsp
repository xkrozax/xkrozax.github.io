<%@ page language="java" import="java.util.*"  import="metier.Article" contentType="text/html; charset=UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title> Paramètres </title>
    
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
	Article [] tabArticle;
	tabArticle = (Article[]) session.getAttribute("ListeArticle"); 
	%>
    <% 
    String typeTaxe = "";
    Date dateSysteme = new Date();
    int yearSysteme = Integer.valueOf(String.format("%1$tY",dateSysteme));
    %>
    <%
	String role="";
	if ((String) session.getAttribute("role") != null){
      role = (String) session.getAttribute("role");  
    }  
    if( role.equals("") ) {
    String site = new String("../PageNonAutoriseeMarches.jsp");
    response.setStatus(response.SC_MOVED_TEMPORARILY);
    response.setHeader("Location", site); 
    }
    %>
	<script type="text/javascript">
	$(function(){
      
      
      $("#site_title2").load("menuTitre2.html"); 
      $("#chargement").load("menuChargement.html");
      $("#chargement").hide();        
     
      $("#formRechercherArticle").hide();
      $("#dialogBienEnregistrer").hide();$("#dialogSupprimerRedevable1").hide();
      $("#dialogSupprimerRedevable2").hide(); $("#dialogAjouterArticle").show();$("#dialogModifierRedevable").hide();
      $("#IDsousArticle").hide();$("#IDreference").hide();$("#IDprixAchat").hide();
      $("#IDprixVente").hide();$("#IDstockInitial").hide();$("#IDaffichierAjouterArticle").hide();
      $("#IDsousArticle2").hide();$("#IDreference2").hide();$("#IDprixAchat2").hide();
      $("#IDprixVente2").hide();$("#IDstockInitial2").hide();$("#IDaffichierAjouterArticle2").hide();
      
      $("#chargement").show();  
        $.ajax( 
        {    
            type: "POST", 
            enctype:"multipart/form-data",
            url: "rechercherSousArticle.do", 
            data:$("#formAjouterArticle").serialize(),
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
         
    $('#rechercherArticle').click(function rechercherArticle() 
    { 
        $("#chargement").show();  
        $.ajax( 
        {    
            type: "POST", 
            enctype:"multipart/form-data",
            url: "rechercherSousArticle.do", 
            data:$("#formAjouterArticle").serialize(),
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
    
    $('#affichierAjouterArticle').click(function affichierAjouterArticle() 
    {         
        $("#article").val(""); $("#affichierAjouterArticle").hide();
        $("#IDsousArticle").show();$("#IDreference").show();$("#IDprixAchat").show();
        $("#IDprixVente").show();$("#IDstockInitial").show(); $("#IDaffichierAjouterArticle").show();
        $("#IDsousArticle2").show();$("#IDreference2").show();$("#IDprixAchat2").show();
        $("#IDprixVente2").show();$("#IDstockInitial2").show();$("#IDaffichierAjouterArticle2").show();                                     
    } 
    ); 
    
    $('#ajouterArticle').click(function ajouterArticle() 
    {         
                     $("#chargement").show();
                     $.ajax( 
                           {    
                            type: "POST", 
                            enctype:"multipart/form-data",
                            url: "ajouterSousArticle.do", 
                            data:$("#formAjouterArticle").serialize(),
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
                                $.ajax( 
                                {    
                                type: "POST", 
                                enctype:"multipart/form-data",
                                url: "rechercherSousArticle.do", 
                                data:$("#formAjouterArticle").serialize(),
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
                            afficherBienEnregistrer();   
                            $("#IDsousArticle").hide();$("#IDreference").hide();$("#IDprixAchat").hide();
                            $("#IDprixVente").hide();$("#IDstockInitial").hide(); $("#IDaffichierAjouterArticle").hide();  
                            $("#IDsousArticle2").hide();$("#IDreference2").hide();$("#IDprixAchat2").hide();
                            $("#IDprixVente2").hide();$("#IDstockInitial2").hide();$("#IDaffichierAjouterArticle2").hide(); 
                            $("#affichierAjouterArticle").show();        
                           }
                      });                                
    } 
    ); 
    
  
    $('#idArticle').change(function()  { 
        
        $("#chargement").show();  
        $.ajax( 
        {    
            type: "POST", 
            enctype:"multipart/form-data",
            url: "rechercherSousArticle.do", 
            data:$("#formAjouterArticle").serialize(),
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
          <td><a href="GestionParametres/ParametresRecettes.jsp" > <input type="button" class="btn btn-primary" value= " Gestion Articles-Stock-Fournisseurs" /> </a> </td>                
          <td><a href="GestionSalaries/GestionPersonnelsSalaries.jsp" > <input type="button" class="btn btn-default3" value= " Gestion Salariés" /> </a> </td>                      
          
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
            <li> <a href="GestionParametres/ParametresArticleRecettes.jsp"> <input type="button" class="btn btn-default" value= " Gestion des Articles" /> </a>  </li>            
            <li> <a href="GestionParametres/ParametresSousArticleRecettes.jsp"> <input type="button" class="btn btn-default" value= "  Gestion Sous-Article ou Produits du stock" /> </a>  </li>                                                        
            <li> <a href="GestionParametres/ParametresMaterielEtVehicule.jsp"  > <input type="button" class="btn btn-primary" value= " Gestion Matériels-Engins-Vehicules" />  </a>   </li>             
            <li> <a href="GestionParametres/ParametresFournisseurs.jsp"  > <input type="button" class="btn btn-default" value= " Gestion Fournisseurs" />  </a>   </li>                        
    </ul>
    </div> <!-- end of menu -->
    
    <div id="ajouterDossierAO"> 
    <div id="templatemo_content">
                    		  		    
            <div class="content_section_box26">
            <div class="content_section_box_content6">
            <center>
            <center>----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------</center>	   
            <center>----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------</center>	   
            <input type="button" id="affichierAjouterArticle"  class="btn btn-default"  value=" Ajouter Engins/Véhicule (+)" size="35"/>
                              	            
           	<form id="formAjouterArticle" method="post">                     
	        <table align="left">  
	        <tr>	
	            <td> Article </td>
				<td>
				<select name="idArticle"  id="idArticle"> 
				<option  value="1">Engins/Véhicule</option>				
				</select>
				</td>
				<td> </td> <td> </td> <td> </td> <td> </td> <td> </td>
				<td> </td> <td> </td> <td> </td> <td> </td> 
			</tr>
			</table> 
			<table align="left" bordercolor="#000000" class="table "  width="1120">  
			<tr> 	       
			    <td id="IDsousArticle"> Type Engins/Véhicule </td>
				<td id="IDsousArticle2"><input type="text" name="sousArticle"  size="28"/>  </td>
				<td id="IDprixVente"> Marque </td>
				<td id="IDprixVente2"><input type="text" name="nomArticle"  size="28"/>  </td>						
			    <td id="IDreference"> Réference </td>
				<td id="IDreference2"><input type="text" name="reference"  size="25"/>  </td>
				<td id="IDstockInitial"> Matricule</td>
				<td id="IDstockInitial2"><input type="text" name="matricule"  size="25"/>  </td>					
			    <td id="IDprixAchat"> Prix Achat </td>
				<td id="IDprixAchat2"><input type="number" name="prixAchat"  class="number_input"/>  </td>				
			    				
			    
				<td><input type="hidden" name="stockInitial"  class="number_input"/>  </td>
				<td><input type="hidden" name="prixVente"  class="number_input"/>  </td>				
				<td id="IDaffichierAjouterArticle"><input type="button" id="ajouterArticle"   value="  Enregistrer " size="35"/>	  </td>					
			</tr>				
			</table>		             
	        </form>           	
           	</br> </br>   
           		        
	        <div id="chargement"> </div>
	        <div id="listeArticle"> </div>	
            </center> 	         
            </div> 
            </div>
             	     	    	
	    	
           	                   	            
           	<form id="formModifierArticle" method="post"> 
	        <input type="hidden" name="idSousArticle"  id="idSousArticle" />					                    
	        <input type="hidden" name="sousArticle"  id="sousArticle" />
	        <input type="hidden" name="reference"  id="reference" />	
	        <input type="hidden" name="prixAchat"  id="prixAchat" />	
	        <input type="hidden" name="prixVente"  id="prixVente" />
	        <input type="hidden" name="nomArticle"  id="nomArticle" />
	        <input type="hidden" name="matricule"  id="matricule" />
	        <input type="hidden" name="marque"  id="marque" />
	        <input type="hidden" name="dateAchat"  id="dateAchat" />
	        <input type="hidden" name="statut"  id="statut" />
	        <input type="hidden" name="remarque"  id="remarque" />
	        <input type="hidden" name="responsable"  id="responsable" />	
	        <input type="hidden" name="stockInitial"  id="stockInitial" />	
	        </form>
	   	       	        	             	             	             	             	                                                                  
     </div> 
     </div> 
   
    <div id = "dialogBienEnregistrer" title = "Enregistrement" >
       <font color="#000000"> L'enregistrement a été effectué avec succès  </font>                   	             
    </div> 
    
    <div id = "dialogModifierRedevable" title = "Modifier les données" >
      <font color="#000000"> Vous voulez modifier ?   </font>
    </div>
    
    <div id = "dialogSupprimerRedevable1" title = "Supprimer " >
      <font color="#000000"> Vous voulez supprimer ?   </font>
    </div>
    
    <div id = "dialogSupprimerRedevable2" title = "Supprimer" >
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
    