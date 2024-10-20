<%@ page language="java" import="java.util.*" import="java.text.DecimalFormat" import="java.math.BigDecimal" import="metier.Appelsoffres" import="metier.Ligneattachement" import="metier.Attachement" contentType="text/html; charset=UTF-8"%>
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
	BigDecimal nombreDecimal=new BigDecimal("00.00").setScale(2, BigDecimal.ROUND_DOWN);
	Attachement decompte;
	decompte=(Attachement)request.getAttribute("Decompte");
	Integer numAttachement = (Integer) request.getAttribute("numAttachement");
	String dateAttachement = (String) request.getAttribute("dateAttachement");
	int d=0;
	BigDecimal [] tabMontant;
	tabMontant =(BigDecimal[]) request.getAttribute("listeMontant");
	DecimalFormat f = new DecimalFormat();
	f.setMaximumFractionDigits(2); 
	f.setMinimumFractionDigits(2);
	%>
	
	<% int size = tabLigneAttachement.length;  
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
     var size =<%=tabLigneAttachement.length%>;  
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
	<%for(int i=0;i<tabLigneAttachement.length;i++) {%>
    <script type="text/javascript">
   	$('#ajouterQuantiteA<%=i%>').click(function ajouterQuantiteA() 
    {         
        $("#chargement").show();
        $("#idLigneAttachement").val("<%= tabLigneAttachement[i].getIdLigneAttachement() %>");
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
               $("#dialog").show();                                     
            } 
         });            
    } 
    );  
    </script>
    <%} %>   
  </head> 
  <body>  
     <center>
     <center>  -------------------------------------------------------------------------------------------------------------------------------- </center>
     <%if(tabLigneAttachement.length>0){ %>
     <%}
       else
       { %>
         <center>  Aucun Prix </center>
      <%} %>
     <%if(tabLigneAttachement.length>0){ %>
     <table  border="3" bgcolor=""  bordercolor="#000000" class="table table-hover " width="1302" >    
     <tr>    
     <th width="52"> N° Prix </th>
     <th width="493" class="" align="center"> Désignation  </th> 
     <th width="92"> Unité </th>
     <th width="95"> Quantité Marché </th>
     <th width="95"> Quantité Réalisée </th>
     <th width="152"> Prix Unitaire </th> 
     <th width="152"> Prix Total </th>   
     </tr>   
     <%for(int i=0;i<tabLigneAttachement.length;i++) {%>
     <tr> 
     <td align="center"><%= tabLigneAttachement[i].getNumPrix() %> </td>
     <td align="left"><%= tabLigneAttachement[i].getDesignation() %> </td>
     <td align="center"><%= tabLigneAttachement[i].getUnite() %> </td>
     <td align="right"><%= tabLigneAttachement[i].getQuantiteMarches() %> </td>
     <td align="right"><%= (f.format(tabLigneAttachement[i].getQuantiteAttachement())).replace(",", ".") %> </td>
     <%if(tabLigneAttachement[i].getPrixUnitaire() != nombreDecimal){ %> 
     <td align="right"><%= (f.format(tabLigneAttachement[i].getPrixUnitaire())).replace(",", ".") %> </td>
     <%}else { %> <td align="center"></td> <%} %>
     <%if(tabLigneAttachement[i].getPrixTotal() != nombreDecimal){ %> 
     <td align="right"><%= (f.format(tabLigneAttachement[i].getPrixTotal())).replace(",", ".") %> </td>
     <%}else { %> <td align="center"></td> <%} %>
     </tr>
     <%} %>
     <tr> 
     <td align="left" colspan="6"> Prix  Total  HT </td>   
     <td align="right"> <%=(f.format(decompte.getMontantHt())).replace(",", ".") %> </td>
     </tr>
     <tr> 
     <td align="left" colspan="6"> TOTAL de TVA  </td>   
     <td align="right"> <%=(f.format(decompte.getMontantTva())).replace(",", ".") %> </td>   
     </tr>
     <tr>
     <td align="left" colspan="6"> Prix Total TTC </td>   
     <td align="right"> <%=(f.format(decompte.getMontantTtc())).replace(",", ".") %> </td>
     </tr>
     <% if ( (decompte.getMontantRevisionPrix().doubleValue() != 0 )) { %>
     <tr>
     <td align="left" colspan="6"> Montant de Révision des prix TTC </td>   
     <td align="right"> <%=(f.format(decompte.getMontantRevisionPrix())).replace(",", ".") %> </td>
     </tr>
     <%} %>
     <tr>
     <td align="left" colspan="6"> Montant Total TTC </td>   
     <td align="right">  <%=(f.format(decompte.getMontantDecompte())).replace(",", ".") %> </td>
     </tr>
     </table>
     <center> RECAPITULATION </center>
     <table  border="3" bgcolor=""  bordercolor="#000000" class="table table-hover " width="1302" >    
     <tr>    
     <th width="200"> Nature des dépenses </th>
     <th width="92" > Dépenses  faites  </th> 
     <th width="92"> Retenue de garantie </th>
     <th width="95"> Reste </th>
     </tr> 
     <tr>
     <% if ( (decompte.getTravauxT() == 20 )) { %>
     <td align="left" > Travaux terminés </td> 
     <%} else { %>
     <td align="left"> Travaux non terminés </td>
     <%} %>
     <td align="center"> <%=(f.format(decompte.getMontantDepense())).replace(",", ".") %> </td>
     <% if ( (decompte.getTypeRetenue()).equals ("Caution bancaire") ) { %>
     <td align="center" width="92"> <%=decompte.getTypeRetenue() %> </td>
     <%} else if ( (decompte.getTypeRetenue()).equals ("Retenue de garantie") ) { %>
     <td align="right"> <%=(f.format(decompte.getMontantRetenue())).replace(",", ".") %> </td>
     <%} else { %>
     <td align="right">  </td>
     <%} %>
     <td align="right"> <%=(f.format(decompte.getResteDepense())).replace(",", ".") %> </td>
     </tr>
     <tr>
     <td align="left" colspan="3"> A déduire les dépenses imputées sur les exercices antérieurs </td>   
     <td align="right"> <%=(f.format(decompte.getDepensesImputees())).replace(",", ".") %>  </td>
     </tr>
     <tr>
     <td align="left" colspan="3"> Reste à payer sur l’exercice en cours </td>   
     <td align="right"> <%=(f.format(decompte.getResteApayer())).replace(",", ".") %>  </td>
     </tr>
     <tr>
     <td align="left" colspan="3"> A déduire le montant des acomptes délivrés sur  l'exercice en cours </td>   
     <td align="right"> <%=(f.format(decompte.getMontantDesAcomptes())).replace(",", ".") %>  </td>
     </tr>
     <% if ( (decompte.getMontantP().doubleValue() > 0 )) { %>
     <tr>
     <td align="left" colspan="3"> A déduire le montant de pénalité </td>   
     <td align="right"> <%=(f.format(decompte.getMontantP())).replace(",", ".") %>  </td>
     </tr>
     <%} %>
     <tr>
     <td align="left" colspan="3"> Montant de l'acompte à délivrer </td>   
     <td align="right"> <%=(f.format(decompte.getMontantAcompte())).replace(",", ".") %>  </td>
     </tr>
     </table>
     <%} %> 
  </center>  
  </body>
</html>