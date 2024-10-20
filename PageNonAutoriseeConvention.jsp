<%@ page language="java" import="java.util.*"   contentType="text/html; charset=UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>Gestion des Marchés publics</title>
    
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
	<script>
	$(function(){
      
      $("#site_title").load("menuTitre.html"); 
      $("#site_title2").load("menuTitre2.html");
           
      $("#chargement").load("menuChargement.html");
      $("#chargement").show();
      $("#modules").hide();$("#authentificationNonCorrecte").hide();
      $("#connecterUtilisateur").show();
      
      $.ajax( 
        {    
            type: "POST", 
            enctype:"multipart/form-data",
            url: "rechercherNotification.do", 
            data:$("formNotification").serialize(),
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
         
    $('#seConnecter').click(function seConnecter() 
    { 
        $("#chargement").show();        
        $.ajax( 
        {           
            type: "POST", 
            enctype:"multipart/form-data",
            url: "authentifier.do", 
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
                $("#authentification").html(html);            
            } 
        }); 
    } 
    );
    });
	</script>
	<%    
	Integer nombreNotificatiton=0;	
	if ((Integer)session.getAttribute("nombreNotifications") != null) {
	nombreNotificatiton= (Integer)session.getAttribute("nombreNotifications"); 
	}  
    %>
	
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
            <li><a href="GestionMarchesPublics.jsp"  class="current"> <input type="button" class="btn btn-primary" value= " Gestion des Marchés Publics " /> </a></li>   
            <li><a href="AppelsOffres/ListeAppelsOffres.jsp"  class="current"> <input type="button" class="btn btn-primary" value= " Liste Appels d’offres " />  </a></li>   
            <li><a href="AppelsOffres/LancementAO/AjouterAO.jsp" > <input type="button" class="btn btn-default" value= " Création AO " /> </a></li>           
            <li><a href="AppelsOffres/DossierAO/DossierAO.jsp" > <input type="button" class="btn btn-default" value= " Dossier AO " /> </a></li>          
            <li><a href="AppelsOffres/PreparationOuverturePlis/PreparationOuverturePlis.jsp"> <input type="button" class="btn btn-default" value= " Publications et Convocations " /></a></li>           
            <li><a href="AppelsOffres/OuvertureDesPlis/OuvertureDesPlis.jsp"> <input type="button" class="btn btn-default" value= " Ouverture des plis " /> </a></li>        
            <li><a href="AppelsOffres/EvaluationDesOffres/EvaluationDesOffres.jsp" class="current2"> <input type="button" class="btn btn-default" value= " Evaluation des offres " /> </a></li>           
            <li><a href="AppelsOffres/ResultatAO/ResultatAO.jsp"> <input type="button" class="btn btn-default" value= " Résultat AO " /></a></li>	
    </ul>	
    </div> <!-- end of menu -->
    
	
	<div id="rechercherDossier"> 
    <div id="templatemo_content">
    <center>            		  		    
                          
            <div class="content_section_box16">
            <div  id="pageNonAutorise"> 
			<table   bgcolor=""  bordercolor="#000000" class="table " width="576" align="center"> 
			<tr>
			    <td align="left"> </td>	     
	        </tr>
			<tr>	
			    <td align="center"> <font color="#ff0000" > <h2> <b>  Accès à cette page est non autorisé pour cet utilisateur ! </b> </h2> </font>   </td>	    
	        </tr>
	        <tr>
			    <td align="left"> </td>	     
	        </tr>
	        </table>
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
