<%@ page language="java" import="java.util.*" import="metier.Appelsoffres" import="java.math.BigDecimal" contentType="text/html; charset=UTF-8"%>
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
	<%for(int i=0;i<tabAppelsoffres.length;i++) {%>
    <script type="text/javascript">
   	$('#ajouterMarches<%=i%>').click(function ajouterMarches() 
    {         
        $("#chargement").show();
        $("#idAppelOffre").val("<%= tabAppelsoffres[i].getIdAppelOffre() %>");
        $("#numMarches").val($('#numMarches2<%=i%>').val());
        $("#anneeMarches").val($('#anneeMarches2<%=i%>').val());
        $.ajax( 
        {    
            type: "POST", 
            enctype:"multipart/form-data",
            url: "ajouterMarches.do", 
            data:$("#formRechercherAppelOffre").serialize(),
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
     <table id="<%=j%>"  border="3" bgcolor=""  bordercolor="#000000" class="table table-hover " width="1650" >     <tr>    
     <tr> 
     <th width="52"> N° AO </th>
     <th> Annee </th> 
     <th  width="614"> Objet </th>
     <th width="83"> Nature prestation </th>
     <th width="90"> N° Lot </th>
     <th> Date OP </th>
     <th  width="120"> Montant d'estimation </th>
     <th  width="152"> Concurrent Retenu </th>
     <th width="120"> Montant d'engagement </th>
     <th width="82"> Statut </th>
     <th width="166"> num Marché </th>
     <th>  </th>
     </tr>   
     <% int debut = j*sizeParPage, fin = (j+1)*sizeParPage; %>
     <%for(int i=debut;i<fin && i < size;i++) {%>
     <tr>  
     <td align="center"><%= tabAppelsoffres[i].getNumAppelOffre() %> </td>
     <td align="center"><%= tabAppelsoffres[i].getAnneeAppelOffre() %> </td>    
     <td align="center"><%= tabAppelsoffres[i].getObjetAppelOffre() %> </td>   
     <td align="center"><%= tabAppelsoffres[i].getCategorieAo() %> </td> 
     <td align="center"><%= tabAppelsoffres[i].getTypeLot() %> </td>  
     <td align="center"><%= tabAppelsoffres[i].getDateOp().replace("-", "/") %> </td>
     <%if ( ! tabAppelsoffres[i].getEstimation().equals(nombreDecimal) ) {	%>
     <td align="center"><%= tabAppelsoffres[i].getEstimation() %> </td>
     <%}else  {%><td align="center"> </td><%} %>
     <td align="center"><%= tabAppelsoffres[i].getConcurrentRetenu() %> </td>
     <%if (! tabAppelsoffres[i].getMontantTtc().equals(nombreDecimal)) {	%>
     <td align="center"><%= tabAppelsoffres[i].getMontantTtc() %> </td>
     <%}else  {%><td align="center"> </td><%} %>
     <td align="center"><%= tabAppelsoffres[i].getStatutActuel() %> </td>
     <% if (tabAppelsoffres[i].getNumMarches() != 0 ) {%>  
     <td align="center"> <input type="number" name="numMarches2<%=i%>" id="numMarches2<%=i%>" class="newsletter_input"  value="<%=tabAppelsoffres[i].getNumMarches()%>" size="4"/> 
     <%} else {%> <td align="center"> <input type="number" name="numMarches2<%=i%>" id="numMarches2<%=i%>" class="newsletter_input"  value="" size="4"/> <%} %>
     <% Date dateSysteme2 = new Date();
	 int yearSysteme2 = Integer.valueOf(String.format("%1$tY",dateSysteme2));%>
     <select name="anneeMarches2<%=i%>"  id="anneeMarches2<%=i%>" > 
     <% if (tabAppelsoffres[i].getAnneeMarches() != 0 ) {%> 	            
	 <option  value="<%=tabAppelsoffres[i].getAnneeMarches()%>"><%=tabAppelsoffres[i].getAnneeMarches()%></option>
	 <%} else {%> <option  value="<%=yearSysteme2%>"><%=yearSysteme2%></option><%} %>
	 <% for(int k=yearSysteme2;k>=1950;k--){%>
	 <option  value="<%=k%>"><%=k%></option>
	 <%} %>
	 </select>
	 </td>         
     <td align="center"><input type="button" class="btn btn-default4" id="ajouterMarches<%=i%>"  value="Enregistrer" size="35"/> </td>
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