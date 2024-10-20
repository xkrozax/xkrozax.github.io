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
      
      <%String   role = "";
      if ((String) session.getAttribute("role") != null){
      role = (String) session.getAttribute("role");  
      }
      if( (role.equals("") )) {  %>
      $("#modules").hide();
      $("#connecterUtilisateur").show();
      <%} else {%>
      $("#modules").show();
      $("#connecterUtilisateur").hide();
      <%} %>
      
      $("#site_title").load("menuTitre.html"); 
      $("#site_title2").load("menuTitre2.html");
           
      $("#chargement").load("menuChargement.html");
      $("#chargement").show();
      $("#authentificationNonCorrecte").hide();
      
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
                $("#modules").hide();
                $("#connecterUtilisateur").show();            
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
             <li><a href="GestionMarchesPublics.jsp" > <input type="button" class="btn btn-primary" value= " Gestion des Marchés Publics " /> </a></li>    
             <% if (nombreNotificatiton > 0 ){%>             
             <li><a href="Notifications/Notifications.jsp" class="fab fa-facebook-messenger">  <input type="button" class="btn btn-notification" value= "<%=nombreNotificatiton%> Notifications" /> </a></li>                                                    
             <% }else {%> 
             <li><a href="Notifications/Notifications.jsp" class="fab fa-facebook-messenger">  <input type="button" class="btn btn-default" value= "<%=nombreNotificatiton%> Notifications" /> </a></li>                                                    
             <%}%> 
    </ul> 	
    </div> <!-- end of menu -->
    
	
	<div id="rechercherDossier"> 
    <div id="templatemo_content">
    <center>            		  		    
                          
            <div class="content_section_box16">
            <div id="connecterUtilisateur">  
            <div  id="authentificationNonCorrecte"> <font color="#ff0000"> <b>  Nom utilisateur ou le mot de passe est incorrect ! </b> </font> </div>
            <form id="formSeConnecter" method="post"> 
			<table   bgcolor=""  bordercolor="#000000" class="table " width="520" align="center"> 
			<tr>	
			    <td align="left"> </td>	  
			    <td align="left"> </td>	     
	        </tr>
	        <tr>	
			    <td align="left"> </td>	  
			    <td align="left"> </td>	     
	        </tr>
			<tr>	
			    <td align="left"> Utilisateur   </td>	    
		        <td align="left"><input type="text" id="login" name="login"  value="" size="52" autofocus/>  </td>
	        </tr>
			<tr>	
			    <td align=left"> Mot de passe  </td>		    
		        <td align="left"><input type="password" id="password" name="password"  value="" size="52"/>  </td>
	        </tr>	        
		    <tr>
		        <td > </td>
		        <td ><input type="button" id="seConnecter" name="seConnecter" value="  OK  " size="35"/>  </td>
	        </tr>    
	        </table>
	        </form>
	        <div id="authentification"> </div>  
			</div>
                <div id="modules">  
                <table    bgcolor=""   class="" width="952" >
                <tr>
                <td><a href="ProgrammesPrevisionnels/ProgrammePrevisionnel.jsp"  > <input type="button" class="btn3 btn-default" value= " Les programmes prévisionnels" />  </a></td>                              
                <td><a href="AppelsOffres/ListeAppelsOffres.jsp"  > <input type="button" class="btn3 btn-default" value= " Les appels d’offres " />  </a></td>
                <td><a href="Marches/LancementMarches/ListeMarches.jsp"  class="current"> <input type="button" class="btn3 btn-default" value= " Les marchés " />  </a></td>
                <td><a href="BonsDeCommande/ListeBonsDeCommande.jsp"  > <input type="button" class="btn3 btn-default" value= " Les bons de commande" />  </a></td>                             
                <td><a href="Contrats/ListeContrats.jsp"  > <input type="button" class="btn3 btn-default" value= " Les contrats et les conventions" />  </a></td>                                          
                <td><input type="button" name="deConnecter" id="deConnecter"  value="  Déconnecter  " size="35"/></td>
                </tr>
                </table> 
                </div>  
                <div id="chargement">  </div>                                        
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
