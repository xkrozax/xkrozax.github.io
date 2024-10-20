<%@ page language="java" import="java.util.*" import="metier.Utilisateur" import="metier.Article" contentType="text/html; charset=UTF-8"%>
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
    Utilisateur utilisateur=null;
    utilisateur=(Utilisateur)session.getAttribute("utilisateur");
    Integer idUser=0;
	String nomUser="";
	String role="";
	if (utilisateur != null){
      idUser = utilisateur.getIdUser(); 
      nomUser =  utilisateur.getNomUser(); 
      role =  utilisateur.getRole();  
    };
    if( role.equals("") ) {
    String site = new String("../PageNonAutorisee.jsp");
    response.setStatus(response.SC_MOVED_TEMPORARILY);
    response.setHeader("Location", site); 
    }
    %>
    <%
	Article [] tabArticle;
	tabArticle = (Article[]) session.getAttribute("ListeArticle"); 
	%>
    <% 
    String typeTaxe = "";
    Date dateSysteme = new Date();
    int yearSysteme = Integer.valueOf(String.format("%1$tY",dateSysteme));
    %>
	<script type="text/javascript">
	$(function(){
      
      $("#site_title").load("menuTitre.html"); 
      $("#site_title2").load("menuTitre2.html"); 
      $("#chargement").load("menuChargement.html");
      $("#chargement").hide();        
     
      $("#formModifierRedevable").hide();
      $("#dialogBienEnregistrer").hide();$("#dialogSupprimerRedevable1").hide();
      $("#dialogSupprimerRedevable2").hide(); $("#dialogAjouterArticle").hide();$("#dialogModifierRedevable").hide();
      $("#IDidentifiantFiscale1").hide();$("#IDregistreCommerce1").hide();$("#IDtaxeProfessionnelle1").hide();
      $("#IDidentifiantFiscale2").hide();$("#IDregistreCommerce2").hide();$("#IDtaxeProfessionnelle2").hide();
      $("#IDidentifiantFiscale3").hide();$("#IDregistreCommerce3").hide();$("#IDtaxeProfessionnelle3").hide();
      $("#IDidentifiantFiscale4").hide();$("#IDregistreCommerce4").hide();$("#IDtaxeProfessionnelle4").hide();
      
      $("#chargement").show();  
        $.ajax( 
        {    
            type: "POST", 
            enctype:"multipart/form-data",
            url: "rechercherSousArticle.do", 
            data:$("#formRechercherArticle").serialize(),
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
            data:$("#formRechercherArticle").serialize(),
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
    
    $('#ajouterArticle').click(function ajouterArticle() 
    {         
        $("#article").val(""); 
        
               $("#dialogAjouterArticle").dialog({
	           autoOpen: true, 
               buttons: {
               Enregistrer: function() {
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
                            $("#chargement").hide();                                                
                            $("#dialogAjouterArticle").dialog("close");
                            afficherBienEnregistrer();
                            location.reload(true);   
                           }
                      }); 
                  },
               },
               width: 402,
               height: 220,        
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
               $( "#dialogAjouterArticle" ).dialog( "open" );                                    
    } 
    ); 
    
    $('#idArticle2').change(function()  { 
        
        $("#chargement").show();  
        $.ajax( 
        {    
            type: "POST", 
            enctype:"multipart/form-data",
            url: "rechercherSousArticle.do", 
            data:$("#formRechercherArticle").serialize(),
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
        	   <a href="GestionCommerciale.jsp" > <input type="button" class="btn btn-default" value= " Gestion Commerciale " /> </a>
               <a href="GestionParametres/Parametres.jsp" > <input type="button" class="btn btn-primary" value= " Paramètres Achats " /> </a>
        </div>
    </div> <!-- end of header panel -->

    <div id="templatemo_menu">  	
    <ul class="niveau1">   
                       <li><a href="GestionParametres/ParametresArticleDepenses.jsp"> <input type="button" class="btn btn-default" value= " Paramètres Article Achats" /> </a>  </li>            
            <li><a href="GestionParametres/ParametresSousArticleDepenses.jsp"> <input type="button" class="btn btn-primary" value= " Paramètres Sous Article Achats" /> </a>  </li>                                   
               </ul>
    </div> <!-- end of menu -->
    
    <div id="ajouterDossierAO"> 
    <div id="templatemo_content">
                    		  		    
            <div class="content_section_box26">
            <div class="content_section_box_content6">
            <center>
            <center>----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------</center>	   
            <form id="formRechercherArticle" method="post">           
	        <table bgcolor=""  bordercolor="2" class="table " >
	        <tr>	
	            <td> Article </td>
				<td>
				<select name="idArticle" id="idArticle2"> 
				<%for(int i=0;i<tabArticle.length;i++){%>
				<option  value="<%=tabArticle[i].getIdArticle()%>"><%=tabArticle[i].getArticle()%></option>				
				<%} %>	
				</select>
				</td>
				<td><input type="button" id="ajouterArticle"  class="btn btn-default"  value="  Ajouter Sous Article  " size="35"/>  </td>
			</tr>		
			</table>	        
	        </form>		        
	        <div id="chargement"> </div>
	        <div id="listeArticle"> </div>	
            </center> 	         
            </div> 
            </div>
             	     	    	
	    	<div id ="dialogAjouterArticle"  title = "Ajouter Sous Article" >                    	            
           	<form id="formAjouterArticle" method="post">                     
	        <table class="table ">  
	        <tr>	
	            <td> Article </td>
				<td>
				<select name="idArticle"  id="idArticle"> 
				<%for(int i=0;i<tabArticle.length;i++){%>
				<option  value="<%=tabArticle[i].getIdArticle()%>"><%=tabArticle[i].getArticle()%></option>				
				<%} %>	
				</select>
				</td>
			</tr>	       
			<tr>	
			    <td> Sous Article </td>
				<td><input type="text" name="sousArticle"  size="40"/>  </td>				
			</tr>			
			</table>		             
	        </form>
           	</div> 
           	                   	            
           	<form id="formModifierArticle" method="post"> 
	        <input type="hidden" name="idSousArticle"  id="idSousArticle" />					                    
	        <input type="hidden" name="sousArticle"  id="sousArticle" />
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
    