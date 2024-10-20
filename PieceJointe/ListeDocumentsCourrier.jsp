<%@ page language="java" import="java.util.*" import="metier.Document"  contentType="text/html; charset=UTF-8"%>
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
	Document[] tabDocument;
	tabDocument=(Document[])request.getAttribute("listeDocumentsCourrier");
	%>
	 
	<% int size = tabDocument.length;  
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
    $('#ajouterDocument').click(function ajouterDocument() 
    { 
        $("#dialogAjouterDocument").dialog({
	     autoOpen: true, 
         buttons: {
         Annuler: function() {                    
         $( this ).dialog("close");              
         },},
            width: 452,
            height: 240,         
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
           $( "#dialogAjouterDocument" ).dialog( "open" );                                    
    } 
    );    
    </script>
    
	<%for(int i=0;i<tabDocument.length;i++) {%>
    <script type="text/javascript">   
    $('#exporterDocument<%=i%>').click(function exporterDocument<%=i%>() 
       {       
        $("#chargement").show();
        window.location.replace("../../GestionEntrepriseBTP/DocumentsPieceJointe/"+"<%=tabDocument[i].getNomFichier()%>"); 
           
        $("#chargement").hide();     
     });    
   	$('#supprimerDocument<%=i%>').click(function supprimerDocument() 
    {         
        $("#idDocument").val("<%= tabDocument[i].getIdDocument() %>");
        $("tr").removeClass("table tr tr-selectionner");  
        $("#ligneM<%=i%>").addClass("table tr tr-selectionner"); 
        
        $("#dialogSupprimerPieceJointe2").dialog({
	           autoOpen: true, 
               buttons: {
               Non: function() {
                  $("#dialogSupprimerPieceJointe2").dialog("close");  
                  $("tr").removeClass("table tr tr-selectionner");                   
                  },
               Oui: function() {
                               $("#chargement").show();        
                               $.ajax( 
                               {    
                               type: "POST", 
                               enctype:"multipart/form-data",
                               url: "supprimerDocumentPieceJointe.do", 
                               data:$("#formSupprimerDocument").serialize(),
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
                              $('#ligneM<%=i%>').hide(); 
                              $("#dialogSupprimerPieceJointe1").dialog({
	                          autoOpen: true, 
                              buttons: {
                              OK: function() {
                              $("#dialogSupprimerPieceJointe1").dialog("close");                   
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
               $( "#dialogdialogSupprimerPieceJointe1" ).dialog("open");                                 
            } 
         }); 
               // ---------------------------                                     
                 $("#dialogSupprimerPieceJointe2").dialog("close"); 
                  },
               },
               width: 322,
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
               $( "#dialogSupprimerPieceJointe2" ).dialog("open");          
    } 
    );  
    </script>  
    <%} %>   
  </head> 
  <body>  
     <%if(tabDocument.length>0){ %>
     <%}
       else
       { %>
     <table   border="3" bgcolor=""  bordercolor="#000000" class="table table-hover " width="520" >       
     <tr>
     <th  width="520"> Pièce jointe <input type="button" class="btn btn-default2" id="ajouterDocument"  value=" Ajouter Pièce jointe " size="35"/></th>
     </tr> 
     <tr>
     <td> <center> </center> </td>
     </tr>    
     </table>
      <%} %>
     <%if(tabDocument.length>0){ %>
     <table   border="3" bgcolor=""   bordercolor="#000000" class="table table-hover "  width="520" >    
     <tr>    
     <th  width="470"> Pièce jointe  </th>  
     <th  width="50"> <input type="button" class="btn btn-default2" id="ajouterDocument"  value=" Ajouter Pièce jointe " size="35"/> </th>
     </tr>   
     <%for(int i=0;i < size;i++) {%>
     <tr id="ligneM<%=i%>"> 
     <%if(!tabDocument[i].getNomDocument().equals("")){  %>
     <td align="left"> <input type="button" id="exporterDocument<%=i%>" value= " <%=tabDocument[i].getNomDocument()%> " /> </td>                   
     <%}else{ %> <td align="center">  </td><%} %>     
      <td align="center"><input type="button" id="supprimerDocument<%=i%>" class="btn btn-default4"  value="X" size="35"/> </td>         
     </tr>
     <%} %>
     </table>
     <%} %>
    
  </body>
</html>