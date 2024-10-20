<%@ page language="java" import="java.util.*" import="java.math.BigDecimal"  contentType="text/html; charset=UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%
String   role = "";
	if ((String) session.getAttribute("role") != null){
      role = (String) session.getAttribute("role");  
    } 
    if( ! ( (role.equals("Directeur")) || (role.equals("Gérant")) || (role.equals("GRH")) ) )  {
    String site = new String("../PageNonAutorisee.jsp");
    response.setStatus(response.SC_MOVED_TEMPORARILY);
    response.setHeader("Location", site); 
    }
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
    
	<script type="text/javascript">
	
	   
	$(function(){   
      $("#site_title").load("menuTitre.html"); 
      $("#site_title2").load("menuTitre2.html"); 
      $("#chargement").load("menuChargement.html");
      $("#chargement").hide();        
      
     $("#chargement").show();  
        $.ajax( 
        {    
            type: "POST", 
            enctype:"multipart/form-data",
            url: "getArticle.do", 
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
            } 
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
               <a href="GestionParametres/Parametres.jsp" > <input type="button" class="btn btn-primary" value= " Paramètres Achats" /> </a>
        </div>
    </div> <!-- end of header panel -->
    
    <div id="templatemo_menu">  	
    <ul class="niveau1"> 
             <li><a href="GestionParametres/ParametresArticleDepenses.jsp"> <input type="button" class="btn btn-default" value= " Paramètres Article Achats" /> </a>  </li>            
            <li><a href="GestionParametres/ParametresSousArticleDepenses.jsp"> <input type="button" class="btn btn-default" value= " Paramètres Sous Article Achats" /> </a>  </li>                                         	                                            	                                         	                                            	                                                   	                                            	                                         	                                            	                             
    </ul>
    </div> <!-- end of menu -->
    
    
         
    <div id="templatemo_content">
         <center>         		  		    
            <form id="formRechercherListeOperation" method="post"> 
	        <input type="hidden" name="typeArticle" value="Depense"/>
	        </form>
	 </center>
    </div> 
             				
    
    <!-- end of content -->
    
<!-- Free Website Templates @ TemplateMo.com -->
 <!-- end of container -->
  </body>  
</html>
