<%@ page language="java" import="java.util.*" import="java.text.DecimalFormat" import="metier.Appelsoffres" import="metier.Ligneattachement" import="metier.Seances" contentType="text/html; charset=UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'ListeDossierPermisConstruire2.jsp' starting page</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<%
	Ligneattachement[] tabLigneAttachement;
	tabLigneAttachement=(Ligneattachement[])request.getAttribute("listeLignesAttachements");
	Integer numAttachement = (Integer) request.getAttribute("numAttachement");
	String dateAttachement = (String) request.getAttribute("dateAttachement");
	DecimalFormat f = new DecimalFormat();
	f.setMaximumFractionDigits(2); 
	f.setMinimumFractionDigits(2);
	%>
	
	<% int sizeA = tabLigneAttachement.length;  
			int sizeParPageA = 32;
			int nbPageA = 0;
			int margeA = sizeA%sizeParPageA;
			if ( sizeA <= sizeParPageA ){
			nbPageA = 1;
			}
			else 
			 {
			   if (margeA==0){
			   nbPageA = sizeA/sizeParPageA;
			   }
			   else{
			   nbPageA = sizeA/sizeParPageA+1;
			   }
			 } 		 
			int numPageA = 0;		
	%>		
	 <script type="text/javascript">
     var sizeA =<%=tabLigneAttachement.length%>;  
			var sizeParPageA = 32;
			var nbPageA = <%=nbPageA%>;
			var numPageA = 0;
    	
	 $(document).ready(function(){   		
	        for(var i=0;i<nbPageA;i++){
	        	if(i==numPageA){
	        		$("#"+i+"A").show();
	        	} else {
	        		$("#"+i+"A").hide();
	        	}
	        }
   
	   });
	   
	   function afficherA(){
	   			//alert(numP);
	   			//e.preventDefault();

				if(numPageA==(nbPageA-1)){
				  
					$("#premierA").removeAttr("disabled");
		   			$("#precedentA").removeAttr("disabled");
		   			$("#nextA").attr("disabled", "disabled");
		   			$("#dernierA").attr("disabled", "disabled");
				}else if(numPageA==0){
					$("#premierA").attr("disabled", "disabled");
		   			$("#precedentA").attr("disabled", "disabled");
		   			$("#nextA").removeAttr("disabled");
		   			$("#dernierA").removeAttr("disabled");
				} else {
					$("#premierA").removeAttr("disabled");
		   			$("#precedentA").removeAttr("disabled");
		   			$("#nextA").removeAttr("disabled");
		   			$("#dernierA").removeAttr("disabled");
				}

	   			for(var i=0;i<nbPageA;i++){
	   			    
	        		if(i==numPageA){
		        		$("#"+i+"A").show();
		        		$("#pageA"+i+"").addClass("active btn-info");
		        		$("#pageA"+i+"").removeClass("btn-default");
		        	} else {
		        		$("#"+i+"A").hide();
		        		$("#pageA"+i+"").addClass("btn-default");
		        		$("#pageA"+i+"").removeClass("active btn-info");
		        	}
	            }
	   		
	   };
	   		
	   function precedentA(){
	   
	   		if(numPageA>0){
	   			numPageA--;
	   		}
	   		afficherA();
	   };
	   function nextA(){
	   
	   		if(numPageA<(nbPageA-1)){
	   			numPageA++; 
	   		}
	   		afficherA();
	   };
	   function afficherPageA(numP){
	   		numPageA = numP;
	   		afficherA();
	   };
	  
	</script>		
	<%for(int i=0;i<tabLigneAttachement.length;i++) {%>
    <script type="text/javascript">
   	$('#ajouterQuantiteA<%=i%>').click(function ajouterQuantiteA() 
    {         
        $("#chargement").show();
        $("#idLigneAttachement").val("<%= tabLigneAttachement[i].getIdLigneAttachement() %>");
        $("#idBordereau").val("<%= tabLigneAttachement[i].getIdBordereau() %>");
        $("#quantiteAttachement").val($('#quantiteAttachement2<%=i%>').val()); 
        $.ajax( 
        {    
            type: "POST", 
            enctype:"multipart/form-data",
            url: "ajouterLigneAttachement.do", 
            data:$("#formAjouterAttachement").serialize(),
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
               $("#dialog").dialog({
	                           autoOpen: true, 
                               buttons: {
                               Ok: function() {                  
                               $( this ).dialog("close");                     
                               },
                            },
                            width: 452, height: 165,         
                            position: {
			                my: "center", at: "center", of: window, collision: "fit",			      
			                using: function( pos ) {
			     	           var topOffset = $( this ).css( pos ).offset().top;
				               if ( topOffset < 0 ) {
					           $( this ).css( "top", pos.top - topOffset );
				               }
			                }
		                    }              
                            });                                     
            } 
         });            
    } 
    ); 
    $('#supprimerPrixAttachement<%=i%>').click(function supprimerPrixAttachement() 
    {         
        $("#idLigneAttachement").val("<%= tabLigneAttachement[i].getIdLigneAttachement() %>");
        $("tr").removeClass("table tr tr-selectionner");  
        $("#ligne<%=i%>").addClass("table tr tr-selectionner"); 
        
        $("#dialog4").dialog({
	           autoOpen: true, 
               buttons: {
               Non: function() {
                  $("#dialog4").dialog("close");  
                  $("tr").removeClass("table tr tr-selectionner");                   
                  },
               Oui: function() {
                               $("#chargement").show();        
                               $.ajax( 
                               {    
                               type: "POST", 
                               enctype:"multipart/form-data",
                               url: "supprimerPrixAttachement.do", 
                               data:$("#formAjouterAttachement").serialize(),
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
                              $("#dialog3").dialog({
	                          autoOpen: true, 
                              buttons: {
                              OK: function() {
                              $("#dialog3").dialog("close");                   
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
               $( "#dialog3" ).dialog("open");                                 
            } 
         }); 
               // ---------------------------                                     
                 $("#dialog4").dialog("close"); 
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
               $( "#dialog4" ).dialog("open");          
    } 
    );   
    </script>
    <%} %>   
  </head> 
  <body>  
     
     <%if(tabLigneAttachement.length>0){ %>
     <%}
       else
       { %>
         <center>  Aucun Prix </center>
      <%} %>
     <%if(tabLigneAttachement.length>0){ %>
     <table  border="3" bgcolor=""  bordercolor="#000000" class="table table-hover " width="992" >    
     <tr>    
     <th width="52"> N° Prix </th>
     <th width="465" class="" align="center"> Désignation  </th> 
     <th width="92"> Unité </th>
     <th width="95"> Quantité Marché </th>
     <th width="95"> Quantité Réalisée </th>
     <th width="95"> Quantité Attachement </th>   
     <th colspan="2">  </th>
     </tr>   
     <%for(int i=0;i<tabLigneAttachement.length;i++) {%>
     <tr id="ligne<%=i%>"  class="table tr tr-selectionner"> 
     <td align="center"><%= tabLigneAttachement[i].getNumPrix() %> </td>
     <td align="left"><%= tabLigneAttachement[i].getDesignation() %> </td>
     <td align="center"><%= tabLigneAttachement[i].getUnite() %> </td>
     <td align="center"><%= tabLigneAttachement[i].getQuantiteMarches() %> </td>
     <td align="center"><%= tabLigneAttachement[i].getQuantiteRealiser() %> </td>
     <td align="center"><input type="text" name="quantiteAttachement2<%=i%>" id="quantiteAttachement2<%=i%>" class="newsletter_input"  value="<%= (f.format(tabLigneAttachement[i].getQuantiteAttachement() )).replace(",", ".") %>" size="10"/> </td>
     <td align="center"><input type="button" id="ajouterQuantiteA<%=i%>" class="btn btn-default4" value="Enregistrer" size="35"/> </td>
     <td align="center"><input type="button" id="supprimerPrixAttachement<%=i%>" class="btn btn-default4" value="X" size="35"/> </td>          
     </tr>
     <%} %>
     </table>
     <%} %>
    
  </body>
</html>