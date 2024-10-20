<%@ page language="java" import="java.util.*" import="metier.Article" import="java.math.BigDecimal"  contentType="text/html; charset=UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title> </title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<%
	Article[] tabArticle;
	tabArticle=(Article[])request.getAttribute("listeArticle");
	
	%>
	<% int size = tabArticle.length;  
			int sizeParPage = 16;
			int nbPage = 0;
			int marge = size%sizeParPage;
			if ( size <= sizeParPage ){
			nbPage = 1;
			}
			else 
			 {
			   if (marge==0){
			   nbPage = size/sizeParPage;
			   }
			   else{
			   nbPage = size/sizeParPage+1;
			   }
			 } 		 
			int numPage = 0;		
	%>		
	 <script type="text/javascript">
     var size =<%=tabArticle.length%>;  
			var sizeParPage = 16;
			var nbPage = <%=nbPage%>;
			var numPage = 0;
    	
	 $(document).ready(function(){   		
	        for(var i=0;i<nbPage;i++){
	        	if(i==numPage){
	        		$("#"+i+"").show();
	        	} else {
	        		$("#"+i+"").hide();
	        	}
	        }
   
	   });
	   
	   function afficher(){
	   			//alert(numP);
	   			//e.preventDefault();

				if(numPage==(nbPage-1)){
				  
					$("#premier").removeAttr("disabled");
		   			$("#precedent").removeAttr("disabled");
		   			$("#next").attr("disabled", "disabled");
		   			$("#dernier").attr("disabled", "disabled");
				}else if(numPage==0){
					$("#premier").attr("disabled", "disabled");
		   			$("#precedent").attr("disabled", "disabled");
		   			$("#next").removeAttr("disabled");
		   			$("#dernier").removeAttr("disabled");
				} else {
					$("#premier").removeAttr("disabled");
		   			$("#precedent").removeAttr("disabled");
		   			$("#next").removeAttr("disabled");
		   			$("#dernier").removeAttr("disabled");
				}

	   			for(var i=0;i<nbPage;i++){
	   			    
	        		if(i==numPage){
		        		$("#"+i+"").show();
		        		$("#page"+i+"").addClass("active btn-info");
		        		$("#page"+i+"").removeClass("btn-default");
		        	} else {
		        		$("#"+i+"").hide();
		        		$("#page"+i+"").addClass("btn-default");
		        		$("#page"+i+"").removeClass("active btn-info");
		        	}
	            }
	   		
	   };
	   		
	   function precedent(){
	   
	   		if(numPage>0){
	   			numPage--;
	   		}
	   		afficher();
	   };
	   function next(){
	   
	   		if(numPage<(nbPage-1)){
	   			numPage++; 
	   		}
	   		afficher();
	   };
	   function afficherPage(numP){
	   		numPage = numP;
	   		afficher();
	   };
	</script>	
   
	<%for(int i=0;i<tabArticle.length;i++) {%>
    <script type="text/javascript">
    
      
    $('#modifierArticle<%=i%>').click(function modifierArticle() 
    { 
        $("tr").removeClass("table tr tr-selectionner");
        $("#ligne<%=i%>").addClass("table tr tr-selectionner");
        $("#idArticle").val("<%=tabArticle[i].getIdArticle()%>");
        $("#article").val($('#article2<%=i%>').val()); 
                        
        $("#dialogModifierRedevable").dialog({
	           autoOpen: true, 
               buttons: {
               Non: function() {
                  $("#dialogModifierRedevable").dialog("close");  
                  $("tr").removeClass("table tr tr-selectionner");                   
                  },
               Oui: function() {
                               $("#chargement").show();        
                               $.ajax( 
                               {    
                                  type: "POST", 
                                  enctype:"multipart/form-data",
                                  url: "modifierArticleDepenses.do", 
                                  data:$("#formModifierArticle").serialize(),
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
                                  afficherBienEnregistrer();                                                            
                                  } 
                                });                                           
                                $("#dialogModifierRedevable").dialog("close"); 
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
               $( "#dialogModifierRedevable" ).dialog("open");          
    } 
    );                   
                        
   
   	$('#supprimerArticle<%=i%>').click(function supprimerArticle() 
    {         
        $("#idArticle").val("<%= tabArticle[i].getIdArticle() %>");
        $("tr").removeClass("table tr tr-selectionner");  
        $("#ligne<%=i%>").addClass("table tr tr-selectionner"); 
        
        $("#dialogSupprimerRedevable1").dialog({
	           autoOpen: true, 
               buttons: {
               Non: function() {
                  $("#dialogSupprimerRedevable1").dialog("close");  
                  $("tr").removeClass("table tr tr-selectionner");                   
                  },
               Oui: function() {
                               $("#chargement").show();        
                               $.ajax( 
                               {    
                               type: "POST", 
                               enctype:"multipart/form-data",
                               url: "supprimerArticleDepenses.do", 
                               data:$("#formModifierArticle").serialize(),
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
                              $('#ligne<%=i%>').hide(); 
                              $("#dialogSupprimerRedevable2").dialog({
	                          autoOpen: true, 
                              buttons: {
                              OK: function() {
                              $("#dialogSupprimerRedevable2").dialog("close");                   
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
               $( "#dialogSupprimerRedevable2" ).dialog("open");                                 
            } 
         }); 
               // ---------------------------                                     
                 $("#dialogSupprimerRedevable1").dialog("close"); 
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
               $( "#dialogSupprimerRedevable1" ).dialog("open");          
    } 
    );  
    
    </script>
    <%} %>   
  </head> 
  <body>  
     <%if(tabArticle.length>0){ %>
     <%}
       else
       { %>
     <table  border="2" bgcolor=""  bordercolor="#000000" class="table table-hover " width="1350" >    
     <tr> 
     <th> Article </h3> </font></th>   
     <th>  </th>   
     </tr>
     <tr><td colspan="11"> <center>Aucune Article</center> </td></tr> 
     </table> 
     <%} %>
     <%if(tabArticle.length>0){ %>
     <%for(int j=0;j<nbPage;j++){ %>
     <table id="<%=j%>"  border="2" bgcolor=""  bordercolor="#000000" class="table table-hover " width="" >    
     <tr> 
     <th> <font color="#000000"> <h3>Article </h3> </font></th>   
     <th>  </th>     
     </tr>   
     <% int debut = j*sizeParPage, fin = (j+1)*sizeParPage; %>
     <%for(int i=debut;i<fin && i < size;i++) {%>
     <tr id="ligne<%=i%>">  
	 <td><input type="text" name="article2<%=i%>"  id="article2<%=i%>" value="<%=tabArticle[i].getArticle()%>"  size="30"/>  </td>										 			
     
     <td align="center">
     <%if(!(tabArticle[i].getArticle().equals("Engins/Véhicule")|| tabArticle[i].getArticle().equals("Sous-Traitance")) ){ %>
     <input type="button" class="btn btn-default4" id="modifierArticle<%=i%>"  value="Enregistrer" size="35"/>                      
     <input type="button" class="btn btn-default4" id="supprimerArticle<%=i%>"  value=" X " size="35"/>
     <%} %>
     </td>                        
     
     </tr>
     <%} %>
     </table>
     <%} %>
     <%} %>
    
     <div class="col-md-8 center">
        <%if(numPage>1){ %>
        	<button class="btn btn-default" id="premier" onclick="afficherPage(0)"> << </button>
        <%} else {%>
        	<button class="btn btn-default" id="premier" onclick="afficherPage(0)" disabled="disabled" > << </button>
        <%} %>
        <%if(numPage>1){ %>
        	<button class="btn btn-default" id="precedent" onclick="precedent()"> < </button>
        <%} else {%>
        	<button class="btn btn-default" id="precedent" onclick="precedent()" disabled="disabled" > < </button>
        <%} %>
        
        
     	<%for(int i=0;i<nbPage;i++){ %>
     		
     		<%if(i==0){ %>
     			<button class="btn btn-info active" id="page<%=i%>" type="button" onclick="afficherPage(<%=i%>)"> <%=i+1 %> </button>
     		<%} else { %>
     			<button class="btn btn-default" id="page<%=i%>" type="button" onclick="afficherPage(<%=i%>)"> <%=i+1 %> </button>
     		<%} %>
     	<%} %>
     	
     	
     	<%if(numPage<size){ %> 
        	<button class="btn btn-default" id="next" onclick="next()"> > </button>
        <%} else {%>
        	<button class="btn btn-default" id="next" onclick="next()" disabled="disabled"> > </button>
        <%} %>
        <%if(numPage<size){ %> 
        	<button class="btn btn-default" id="dernier" onclick="afficherPage(<%=nbPage-1%>)"> >> </button>
        <%} else {%>
        	<button class="btn btn-default" id="dernier" onclick="afficherPage(<%=nbPage-1%>)" disabled="disabled"> >> </button>
        <%} %>
     </div>
  </body>
</html>