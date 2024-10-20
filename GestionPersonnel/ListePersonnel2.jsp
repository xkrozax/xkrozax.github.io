<%@ page language="java" import="java.util.*" import="metier.Personnel" import="java.math.BigDecimal"  import="TrierObjet.TrierFormatDate"   contentType="text/html; charset=UTF-8"%>
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
	Personnel[] tabPersonnel;
	tabPersonnel=(Personnel[])request.getAttribute("listePersonnel");
	 %>
	<% int size = tabPersonnel.length;  
			int sizeParPage = 120;
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
     var size =<%=tabPersonnel.length%>;  
			var sizeParPage = 120;
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
	<%for(int i=0;i<tabPersonnel.length;i++) {%>
    <script type="text/javascript"> 	
    
    $('#rechercherAvancePersonnel<%=i%>').click(function rechercherAvancePersonnel() 
    {         
        $("tr").removeClass("table tr tr-selectionner");
        $("#ligne<%=i%>").addClass("table tr tr-selectionner");
        $("#idPersonnelAvance").val("<%= tabPersonnel[i].getIdPersonnel() %>");
        $("#chargement").show();
        $.ajax( 
        {    
            type: "POST", 
            enctype:"multipart/form-data",
            url: "rechercherAvancePersonnel.do", 
            data:$("#formAjouterAvance").serialize(),
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
               $("#listeAvance").html(html);  
               $("#listeAvance").show(); 
               $("#dialog1").dialog({
	           autoOpen: true, 
               buttons: {
               OK: function() {
                  $("#dialog1").dialog("close");                   
                  },
               },
               width: 1022,
               height: 450,
               title : "Liste des avances",        
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
               $( "#dialog1" ).dialog("open");                                  
            } 
         }); 
    } 
    ); 
    </script>
    <%} %>   
  </head> 
  <body>  
     <%if(tabPersonnel.length>0){ %>
     <%}
       else
       { %>
         <center>  Aucun Résultat </center>
      <%} %>
     <%if(tabPersonnel.length>0){ %>
     <%for(int j=0;j<nbPage;j++){ %>
     <table id="<%=j%>"  border="4" bgcolor=""  bordercolor="#000000"  class="table table-hover " width="" >     
	     <tr>
	         <th> Matricule </th> 
		     <th> Nom Salarié  </th> 
		     <th> CIN  </th>  
		     <th> Numéro CNSS </th>
		     <th> Adresse </th>	      
		     <th> Fonction </th>  
		     <th width="178">  </th>
	     </tr>   
	     <% int debut = j*sizeParPage, fin = (j+1)*sizeParPage; %>
	     <%for(int i=debut;i<fin && i < size;i++) {%>
	     <tr id="ligne<%=i%>" > 
	         <td id="matricule<%=i%>" align="center"><%= tabPersonnel[i].getMatricule() %> </td> 
		     <td id="nom<%=i%>"><%= tabPersonnel[i].getNom() %> </td>
		     <td id="cin<%=i%>"><%= tabPersonnel[i].getCin() %> </td>
		     <td id="numCnss<%=i%>"><%= tabPersonnel[i].getNumCnss() %></td>
		     <td id="adresse<%=i%>"><%= tabPersonnel[i].getAdresse() %> </td>    
		     <td id="fonction<%=i%>"><%= tabPersonnel[i].getFonction() %> </td>  
		     <td>
		     	<input type="button" id="rechercherAvancePersonnel<%=i%>"  value="Liste Avance / Prêt" size="35"/>	     	
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