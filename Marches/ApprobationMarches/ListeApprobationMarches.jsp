<%@ page language="java" import="java.util.*" import="java.text.SimpleDateFormat"  import="java.math.BigDecimal"  import="metier.Appelsoffres" contentType="text/html; charset=UTF-8"%>
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
	Appelsoffres[] tabAppelsoffres;
	tabAppelsoffres=(Appelsoffres[])request.getAttribute("listeAppelsoffres");
	BigDecimal nombreDecimal=new BigDecimal("00.00").setScale(2, BigDecimal.ROUND_DOWN);
	String   role = "";
	if ((String) session.getAttribute("role") != null){
      role = (String) session.getAttribute("role");  
    }
	 %>
	<% int size = tabAppelsoffres.length;  
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
     var size =<%=tabAppelsoffres.length%>;  
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
	<script type="text/javascript">
	$('#genererOrdreDeNotification').click(function genererOrdreDeNotification() 
    {                         
        $("#chargement").show();     
        $.ajax( 
        {    
            type: "POST", 
            enctype:"multipart/form-data",
            url: "genererOrdreDeNotification.do", 
            data:$("#formRechercherMarches").serialize(),
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
               window.location.replace("../../MarchesPublics/Fichiers/OrdreNotificationApprobation.docx");               
               
            } 
         });      
    });
    </script>
	<%for(int i=0;i<tabAppelsoffres.length;i++) {%>
    <script type="text/javascript">
   	$('#ajouterApprobationMarches<%=i%>').click(function ajouterApprobationMarches() 
    {         
        $("#chargement").show();
        $("#idAppelOffre").val("<%= tabAppelsoffres[i].getIdAppelOffre() %>");
        $("#dateApprobation").val($('#dateApprobation2<%=i%>').val());
        $("#numNotificationApprobation").val($('#numNotificationApprobation2<%=i%>').val());
        $("#dateNotificationApprobation").val($('#dateNotificationApprobation2<%=i%>').val());
        $("#dateReceptionApprobation").val($('#dateReceptionApprobation2<%=i%>').val());
        $("#montantCautionD").val($('#montantCautionD2').val());
        if( $('input[id=pieceQuittance2<%=i%>]').is(':checked') ){ $("#pieceQuittance").val("Oui");
        } else { $("#pieceQuittance").val("Non");}
        if( $('input[id=pieceCaution2<%=i%>]').is(':checked') ){ $("#pieceCaution").val("Oui");
        } else { $("#pieceCaution").val("Non");}
        if( $('input[id=pieceAttestation2<%=i%>]').is(':checked') ){ $("#pieceAttestation").val("Oui");
        } else { $("#pieceAttestation").val("Non");}
        $.ajax( 
        {    
            type: "POST", 
            enctype:"multipart/form-data",
            url: "ajouterApprobationMarches.do", 
            data:$("#formRechercherMarches").serialize(),
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
    } 
    ); 
    $('input[id=pieceCaution2<%=i%>]').change(function afficherCautionD() 
    {
     
     if(this.checked) {
        $('#montantCautionD2').show(); 
        $('#MontantCaution').show();        
      }else  {
        $('#montantCautionD2').hide();
        $('#MontantCaution').hide();      
      }
    } 
    ); 
    
    $('#afficherDocuments<%=i%>').click(function afficherDocuments() 
    {         
        $("tr").removeClass("table tr tr-selectionner2");
        $("#ligne<%=i%>").addClass("table tr tr-selectionner2");
        $("#idCourrier1").val("<%= tabAppelsoffres[i].getIdAppelOffre() %>");
        $("#idCourrier2").val("<%= tabAppelsoffres[i].getIdAppelOffre() %>");
        $("#chargement").show();
        $.ajax( 
        {    
            type: "POST", 
            enctype:"multipart/form-data",
            url: "rechercherDocumentPieceJointe.do", 
            data:$("#formDocumentsCourrier").serialize(),
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
               $("#listeDocumentsCourrier").html(html);  
               $("#listeDocumentsCourrier").show(); 
               $("#dialogDocumentsCourrier").dialog({
	           autoOpen: true, 
               buttons: {
               OK: function() {
                  $("#dialogDocumentsCourrier").dialog("close");                   
                  },
               },
               width: 560,
               height: 320,
               title : "Pièces Jointes",        
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
               $( "#dialogDocumentsCourrier" ).dialog("open");                                  
            } 
         }); 
    } 
    );   
    </script>
    <%} %>   
  </head> 
  <body>  
     <%if(tabAppelsoffres.length>0){ %>
     <%}
       else
       { %>
         <center>  Aucun Résultat </center>
      <%} %>
     <%if(tabAppelsoffres.length>0){ %>
     <%for(int j=0;j<nbPage;j++){ %>
     <table id="<%=j%>"  border="3" bgcolor=""  bordercolor="#000000" class="table table-hover " width="1460" >        
     <tr> 
     <th> Date approbation </th>
     <th width="52"> N° d'ordre de notification </th>
     <th> Date d'odre de notification </th>
     <th> Date récue de la notification de l'approbation </th>
     <th> Pièce à fournire </th>
     <% if( (role.equals("Représentant Chef Service Marchés") || role.equals("Chef Service Marchés") || role.equals("Chef Division Equipement") )) { %>                 
     <th width="">  </th>
     <%} %>
     </tr>   
     <% int debut = j*sizeParPage, fin = (j+1)*sizeParPage; %>
     <%for(int i=debut;i<fin && i < size;i++) {%>
     <tr>  
     <td > <input type="date" name="dateApprobation2<%=i%>" id="dateApprobation2<%=i%>"  value="<%=tabAppelsoffres[i].getDateApprobation()%>" size="4"/>     
     <td align="center"> <input type="text" name="numNotificationApprobation2<%=i%>" id="numNotificationApprobation2<%=i%>"   value="<%=tabAppelsoffres[i].getNumNotificationApprobation()%>" size="14"/> </td>        
     <td align="center"> <input type="date" name="dateNotificationApprobation2<%=i%>" id="dateNotificationApprobation2<%=i%>" dir="ltr"  value="<%=tabAppelsoffres[i].getDateNotificationApprobation()%>" size="4"/>             
     <td align="center"> <input type="date" name="dateReceptionApprobation2<%=i%>" id="dateReceptionApprobation2<%=i%>" class="newsletter_input"  value="<%=tabAppelsoffres[i].getDateReceptionApprobation()%>" size="4"/> 
     <td align="left">
     <%if (tabAppelsoffres[i].getPieceQuittance().equals("Oui")) {%>
     <div class="checkbox checkbox-warning"><input type="checkbox"  id="pieceQuittance2<%=i%>" value="" checked="checked" /> <label for="pieceQuittance2<%=i%>"><b>La quittance d'enregistrement</b></label></div> 
     <%} else {%> <div class="checkbox checkbox-warning"><input type="checkbox"  id="pieceQuittance2<%=i%>" value=""  /> <label for="pieceQuittance2<%=i%>"><b>La quittance d'enregistrement</b></label></div><% } %>     
     <%if (tabAppelsoffres[i].getPieceCaution().equals("Oui")) {%>
     <div class="checkbox checkbox-warning"><input type="checkbox" name="pieceCaution2<%=i%>" id="pieceCaution2<%=i%>" value="" checked="checked" /> <label for="pieceCaution2<%=i%>"><b>La caution définitive </b></label><input type="text" id="montantCautionD2" class="number_input2"  value="<%=tabAppelsoffres[i].getMontantCautionD()%>" size="14"/></div>
     <%} else {%> <div class="checkbox checkbox-warning"><input type="checkbox" name="pieceCaution2<%=i%>" id="pieceCaution2<%=i%>" value=""  /> <label for="pieceCaution2<%=i%>"><b>La caution définitive </b></label><input type="text" id="montantCautionD2" class="number_input2"  value="<%=tabAppelsoffres[i].getMontantCautionD()%>" size="14"/></div><% } %>     
     <%if (tabAppelsoffres[i].getPieceAttestation().equals("Oui")) {%>
      <div class="checkbox checkbox-warning"><input type="checkbox" id="pieceAttestation2<%=i%>" value="" checked="checked" /> <label for="pieceAttestation2<%=i%>"><b>Les attestations d’assurances</b></label></div>
     <%} else {%><div class="checkbox checkbox-warning"><input type="checkbox" id="pieceAttestation2<%=i%>" value=""  /> <label for="pieceAttestation2<%=i%>"><b>Les attestations d’assurances</b></label></div><% } %> 
     </td> 
     <% if( (role.equals("Représentant Chef Service Marchés") || role.equals("Chef Service Marchés") || role.equals("Chef Division Equipement") )) { %>                                  
     <td align="center"><input type="button" class="btn btn-default4" id="ajouterApprobationMarches<%=i%>"  value="Valider" size="35"/>  </td>     
     <%} %>
     </tr>
     <%} %>
     </table>
     <%} %>
     <%} %>
    
  </body>
</html>