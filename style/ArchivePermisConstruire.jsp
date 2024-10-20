<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'ArchivePermisConstruire.jsp' starting page</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	
	
	<script src="style/js/bootstrap.min.js"></script>
	<link href="css/font-awesome.min.css" rel="stylesheet">
	
	<link href="templatemo_style.css" rel="stylesheet" type="text/css" />
	<script src="//ajax.googleapis.com/ajax/libs/jquery/1.9.0/jquery.min.js"></script>
	<script type="text/javascript" src="jquery.js"></script>
    
	<link rel="stylesheet" href="//code.jquery.com/ui/1.10.4/themes/smoothness/jquery-ui.css">
	<script src="//code.jquery.com/jquery-1.10.2.js"></script>
    <script src="//code.jquery.com/ui/1.10.4/jquery-ui.js"></script>
    <%String   privilege =null;
    privilege = (String) session.getAttribute("grade");  
    if( privilege ==null   || ( privilege !=null &&  !privilege.equals("gestionTotale") )  ) {
 
   // New location to be redirected
    String site = new String("../Service.jsp");
    response.setStatus(response.SC_MOVED_TEMPORARILY);
    response.setHeader("Location", site); 
    }
    %>
    
  
    <script type="text/javascript">
            var size = 20;  
			var sizeParPage = 4;
			var nbPage = size/sizeParPage;
			var numPage = 0;
    
     $(document).ready(function(){
     
     for(var i=0;i<nbPage;i++){
	        	if(i==numPage){
	        		$("#"+i+"").show();
	        	} else {
	        		$("#"+i+"").hide();
	        	}
	        }
   
     $("#consulterPermis").hide();
         $("#certificatPropriete").hide();
         $("#copieCIN").hide();
         $("#certificatArchitecte").hide();
         $("#noteRenseignements").hide();
         $("#planConstruction").hide();
         $("#planTopographique").hide(); 
         $("#circle").show();
     
    $('#rechercherPermisConstruire').click(function rechercherPermisConstruire() 
    { 
      $("#circle").show();
      //envoyer les donnees en POST 
        $.ajax( 
        {      
            type: "POST", 
            enctype:"multipart/form-data",
            url: "rechercherPermisConstruirePourConsultation.do", 
            data:$("#formRechercherPermisConstruire").serialize(),
            dataType: "html", 
            //timeout : 4000, 
            error: function()
            { 
               alert("invalid"); 
            }, 
            beforeSend : function() 
            { 
            }, 
             success: function(html) 
            { 
                //mettre le résultat dans la balise <div/> concernee
               
                $("#circle").hide();
                $("#listeDossiers").html(html);      
                
            } 
        }); 
    } 
    );
    
    $('#GenererCertificatPropriete').click(function GenererCertificatPropriete() 
    { 
      //envoyer les donnees en POST 
        $.ajax( 
        {    
            type: "POST", 
            enctype:"multipart/form-data",
            url: "genererCertificatPropriete.do", 
            data:$("#formModifierPermisConstruire").serialize(),
            dataType: "html", 
            //timeout : 4000, 
            error: function()
            { 
               alert("invalid"); 
            }, 
            beforeSend : function() 
            { 
            }, 
             success: function(html) 
            { 
                //mettre le résultat dans la balise <div/> concernee
               
                $("#listeDossiers").html(html);      
                
            } 
        }); 
    } 
    );
    
    $('#GenererCopieCIN').click(function GenererCopieCIN() 
    { 
      //envoyer les donnees en POST 
        $.ajax( 
        {    
            type: "POST", 
            enctype:"multipart/form-data",
            url: "genererCopieCIN.do", 
            data:$("#formModifierPermisConstruire").serialize(),
            dataType: "html", 
            //timeout : 4000, 
            error: function()
            { 
               alert("invalid"); 
            }, 
            beforeSend : function() 
            { 
            }, 
             success: function(html) 
            { 
                //mettre le résultat dans la balise <div/> concernee
               
                $("#listeDossiers").html(html);      
                
            } 
        }); 
    } 
    );
    
    $('#GenererCertificatArchitecte').click(function GenererCertificatArchitecte() 
    { 
      //envoyer les donnees en POST 
        $.ajax( 
        {    
            type: "POST", 
            enctype:"multipart/form-data",
            url: "genererCertificatArchitecte.do", 
            data:$("#formModifierPermisConstruire").serialize(),
            dataType: "html", 
            //timeout : 4000, 
            error: function()
            { 
               alert("invalid"); 
            }, 
            beforeSend : function() 
            { 
            }, 
             success: function(html) 
            { 
                //mettre le résultat dans la balise <div/> concernee
               
                $("#listeDossiers").html(html);      
                
            } 
        }); 
    } 
    );
    
    $('#GenererNoteRenseignements').click(function GenererNoteRenseignements() 
    { 
      //envoyer les donnees en POST 
        $.ajax( 
        {    
            type: "POST", 
            enctype:"multipart/form-data",
            url: "genererNoteRenseignements.do", 
            data:$("#formModifierPermisConstruire").serialize(),
            dataType: "html", 
            //timeout : 4000, 
            error: function()
            { 
               alert("invalid"); 
            }, 
            beforeSend : function() 
            { 
            }, 
             success: function(html) 
            { 
                //mettre le résultat dans la balise <div/> concernee
               
                $("#listeDossiers").html(html);      
                
            } 
        }); 
    } 
    );
    
    $('#GenererPlanConstruction').click(function GenererPlanConstruction() 
    { 
      //envoyer les donnees en POST 
        $.ajax( 
        {    
            type: "POST", 
            enctype:"multipart/form-data",
            url: "genererPlanConstruction.do", 
            data:$("#formModifierPermisConstruire").serialize(),
            dataType: "html", 
            //timeout : 4000, 
            error: function()
            { 
               alert("invalid"); 
            }, 
            beforeSend : function() 
            { 
            }, 
             success: function(html) 
            { 
                //mettre le résultat dans la balise <div/> concernee
               
                $("#listeDossiers").html(html);      
                
            } 
        }); 
    } 
    );
    
    $('#GenererPlanTopographique').click(function  GenererPlanTopographique() 
    { 
      //envoyer les donnees en POST 
        $.ajax( 
        {    
            type: "POST", 
            enctype:"multipart/form-data",
            url: "genererPlanTopographique.do", 
            data:$("#formModifierPermisConstruire").serialize(),
            dataType: "html", 
            //timeout : 4000, 
            error: function()
            { 
               alert("invalid"); 
            }, 
            beforeSend : function() 
            { 
            }, 
             success: function(html) 
            { 
                //mettre le résultat dans la balise <div/> concernee
               
                $("#listeDossiers").html(html);      
                
            } 
        }); 
    } 
    );
    
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

  </head>
  
  <body>
  <div id="templatemo_container">
<!-- Free CSS Templates @ www.TemplateMo.com -->
	<div id="templatemo_header_panel">
    	<div id="site_title">
        	ZAI-ConceptInfo
        </div>
		<div id="site_title2">
      برنامج تسيير مصلحة التعمير
        </div>
        <div id="header_links">
        	<a href="#">Sitemap</a> | <a href="#">Login</a> | <a href="#">Contact</a>
        </div>
    </div> <!-- end of header panel -->

    <div id="templatemo_menu">
    	<ul class="niveau1">
            <li><a href="GestionServiceUrbanisme.jsp" ><span></span>الرئيسية</a></li>
            <li><a href="GestionBureauOrdre.jsp" class="current"><span></span>مكتب الضبط</a></li>
            <li><a href="GestionBureauCommissions.jsp"><span></span>مكتب اللجان</a></li>
            <li><a href="GestionBureauPermisConstruire.jsp"><span></span>مكتب رخص البناء</a></li>
            <li><a href="GestionBureauPermisHabiter.jsp"><span></span>مكتب رخص السكن</a></li>
            <li><a href="GestionBureauInfractions.jsp"><span></span>مكتب المخالفات</a></li>
            <li><a href="GestionUtilisateurs.jsp"><span></span>المستخدمين</a></li>     
         </ul>
    </div> <!-- end of menu -->
    
    <div id="templatemo_menu_right">
	<ul class="niveau1">
           <li><span href="#" class="a1" >سجلات رخص البناء</span></li>
		   <li><a href="ajouterDossier.do" class="a2"><span></span>تسجيل طلب الرخصة</a></li>
		   <li><a href="GestionBureauOrdre/AjouterDocumentsDossier.jsp" class="a2"><span></span>تسجيل وثائق الملف</a></li>
		   <li><a href="ajouterPermisDeConstruire.do" class="a2"><span></span>تغيير معلومات الطلب</a></li>
		   <li><a href="GestionBureauOrdre/SupprimerPermisConstruire.jsp" class="a2"><span></span>حذف طلب رخصة</a></li>
		   <li><a href="GestionBureauOrdre/ArchivePermisConstruire.jsp" class="a2"><span></span><font color=red>أرشيف طلبات الرخص</font></a></li>
		   <li><span href=".jsp" class="a11">سجلات رخص السكن</span></li>
		   <li><a href="GestionBureauOrdre/AjouterPermisHabiter.jsp" class="a2"><span></span>تسجيل طلب الرخصة</a></li>
		   <li><a href="GestionBureauOrdre/ModifierPermisDeHabiter.jsp" class="a2"><span></span>تغيير معلومات الطلب</a></li>
		   <li><a href="GestionBureauOrdre/SupprimerPermisHabiter.jsp" class="a2"><span></span>حذف طلب رخصة</a></li>
		   <li><a href="GestionBureauOrdre/ArchivePermisHabiter.jsp" class="a2"><span></span>أرشيف طلبات الرخص</a></li>                  
    </ul>
	</div>
	
    <div id="rechercherDossier"> 
    <div id="templatemo_content">
             <center>
             <div class="content_section_box">
              <div class="content_section_box_bottom"></div>
                <div class="content_section_box_header">  أرشيف طلبات الرخص  </div>
                <div class="content_section_box_content">
	        <center>
	        <form id="formRechercherPermisConstruire" method="post"> 
			<table>
			<tr>
			    <td  align="right" ><select name="typeRegistre" dir="rtl" class="newsletter_input" > 
		        <option  value="-----------------">
		        -----------------
		        </option>
		        <option  value="سجل المشاريع الصغرى">
		        سجل المشاريع الصغرى
		        </option>
		        <option  value="سجل المشاريع الكبرى">
		        سجل المشاريع الكبرى
		        </option>
		        </select>
		        </td>
		        <td class="" align="right">  نوع السجل  </td>
		        <td  align="right" ><select name="typePermisDeposer" dir="rtl" class="newsletter_input" > 
		        <option  value="-----------------">
		        -----------------
		        </option>
		        <option  value="PermisDeConstruire">
		        رخصة البناء
		        </option>
		        <option  value="PermisEntretien">
		        رخصة الإصلاح
		        </option>
		        <option  value="AutorisationDeMorcellement">
		        إذن بتقسيم عقار
		        </option>
		        <option  value="AutorisationDeLotir1">
		        إذن بإحداث تجزئة عقارية
		        </option>
		        <option  value="AutorisationDeLotir2">
		        إحداث مجموعات سكنية
		        </option>
		        <option  value="Autre">
		        أخر
		        </option>
		        </select>
		        </td>
		        <td class="" align="right">  طبيعة الرخصة  </td>

				<td align="right"><select  name="anneeDossier"  >  
				<% Date dateSysteme = new Date();
			       int yearSysteme = Integer.valueOf(String.format("%1$tY",dateSysteme));
			       				
				   for(int i=yearSysteme;i>=1950;i--){%>
				<option  value="<%=i%>"><%=i%></option>
				<%} %>
				</select>
				</td>
				<td class="" align="right"> سنة </td>
			    <td class="">  </td>
		        <td align="right"><input type="text" name="numDossier"  class="newsletter_input" style="text-align:center" value="" size="10"/>  </td>
		        <td class="" align="right"> رقم الملف </td>
				<td class="" >  </td>
	        </tr>
	        </table>
	        <center>-----------------------------</center>
	        <table>
	        <tr>
			    <td align="right"><input type="text" name="cinMaitreOuvrage"  style="text-align:center"  style="text-transform:uppercase" class="newsletter_input" value="" size="20"/>  </td>
		        <td class="" align="right"> رقم البطاقة الوطنية </td>
		        <td align="right"><input type="text" name="nomMaitreOuvrage"  dir="rtl" class="newsletter_input" value="" size="26"/>  </td>
		        <td class="" align="right"> إسم صاحب المشروع </td>		        
	        </tr>
	        </table>
	        <center>-------------------------------------------------------------------------------------------------------------------------------------------------------------------------</center>
	        <center>-------------------------------------------------------------------------------------------------------------------------------------------------------------------------</center>
	        <table>
	        <tr>
	            <td class="" align="right"> </td>
		        <td class="" align="right"> </td>
		        <td><input type="button" id="rechercherPermisConstruire"   value="  بحث  " size="35"/>  </td>
		        <td class="" align="right"> </td>
		        <td class="" align="right"> </td>
	        </tr>
	        </table>
	        </form>
	 
     <div id="circle" class="row">
        <div class="col-md-6">
            <button class="btn btn-danger btn-lg"><i class="fa fa-circle-o-notch fa-spin"></i> Loading</button>
            <button class="btn btn-default btn-lg"> <i class="fa fa-refresh fa-spin"></i> Loading </button>
            <button class="btn btn-default btn-lg"><i class="fa fa-spinner fa-spin"></i> Loading</button>
           
        </div>
        
        
     </div>
     
   </div>
	        <div id="listeDossiers">
		    </div>
			</center>
    	          
                </div>
                </div>
                 </center>
                </div>
         </div>
    
    <div id="consulterPermis">     
    <div id="templatemo_content">
             <center>
            <div class="content_section_box">
            <div class="content_section_box_bottom"></div>
                <div class="content_section_box_header">  أرشيف طلبات الرخص  </div>
                <div class="content_section_box_content">
	        <center>
	        <form id="formRecusDeposerDossier" method="post">
	        <input type="hidden" name="idPermisConstruire"  id="idPermisConstruireRecus" value="" size="10"/>
            <input type="hidden" name="nomUtilisateur" value=""/>
	        </form>
	        <form id="formModifierPermisConstruire" method="post">
	        <input type="hidden" name="idPermisConstruire"  id="idPermisConstruire" value="" size="10"/>
            <input type="hidden" name="nomUtilisateur" value=""/>
			<table>
			<tr>
		        <td  align="right" ><select name="typeRegistre" id="typeRegistre" dir="rtl" class="newsletter_input" > 
		        <option  value="-----------------">
		        -----------------
		        </option>
		        <option  value="سجل المشاريع الصغرى">
		        سجل المشاريع الصغرى
		        </option>
		        <option  value="سجل المشاريع الكبرى">
		        سجل المشاريع الكبرى
		        </option>
		        </select>
		        </td>
		        <td class="" align="right">  نوع السجل  </td>
	        </tr>
	        </table>
	        <table>
	        <tr>
	            <td  align="right" ><select name="typePermisDeposer" id="typePermisDeposer" dir="rtl" class="newsletter_input" >
	            <option  value="-----------------">
		        -----------------
		        </option>
		        <option  value="PermisDeConstruire">
		        رخصة البناء
		        </option>
		        <option  value="PermisEntretien">
		        رخصة الإصلاح
		        </option>
		        <option  value="AutorisationDeMorcellement">
		        إذن بتقسيم عقار
		        </option>
		        <option  value="AutorisationDeLotir1">
		        إذن بإحداث تجزئة عقارية
		        </option>
		        <option  value="AutorisationDeLotir2">
		        إحداث مجموعات سكنية
		        </option>
		        <option  value="Autre">
		        أخر
		        </option>
		        </select>
		        </td>
		        <td class="" align="right">  طبيعة الرخصة  </td>
	        </tr>
	        </table>
	        <center>-----------------------------</center>
	        <table>
			<tr>
			    <td><input type="date" name="dateDossier" id="dateDossier" class="newsletter_input"  style="text-align:center" value=""  size="20"/>  </td>
			    <td class="" align="right"> بتاريخ </td>
				<td align="right"><select  name="anneeDossier" id="anneeDossier" >  
				<% dateSysteme = new Date();
			       yearSysteme = Integer.valueOf(String.format("%1$tY",dateSysteme));
			       				
				   for(int i=yearSysteme;i>=1950;i--){%>
				<option  value="<%=i%>"><%=i%></option>
				<%} %>
				</select>
				</td>
				<td class="" align="right"> سنة </td>
			    <td class="">  </td>
		        <td align="right"><input type="text" name="numDossier" id="numDossier"  class="newsletter_input" style="text-align:center" value="" size="10"/>  </td>
		        <td class="" align="right"> رقم الملف </td>
				<td class="" >  </td>
	        </tr>
	        </table>
	        <center>-----------------------------</center>
	        <table>
			<tr>
		        <td class="" align="left" > Maitre Ouvrage </td>
				<td><input type="text" name="nom" id="nom" class="newsletter_input" style="text-transform:uppercase" value="" size="27"/>  </td>
				<td align="right"><input type="text" name="nomA" id="nomA" dir="rtl" class="newsletter_input" value="" size="27"/>  </td>
		        <td class="" align="right"> صاحب المشروع </td>
	        </tr>
	        </table>
	        <center>-----------------------------</center>
	        <table>
			<tr>
			    <td class=""> CIN </td>
		        <td  align="left"><input type="text" name="cin" id="cin"  style="text-align:center"  style="text-transform:uppercase" class="newsletter_input" value="" size="15" />  </td>
	            <td class="" align="left" > Num Telephone </td>
				<td><input type="text" name="numTel" id="numTel" class="newsletter_input" style="text-align:center"  value="" size="16"/>
	        </tr>
	        </table>
	        <center>-----------------------------</center>
	        <table>
	        <tr>
	            <td class="" align="left">  Architecte </td>
				<td class="" align="left"><input type="text" name="architecte"  id="architecte" class="newsletter_input" value=""  size="37"/>  </td>
				<td  align="right"><input type="text" name="architecteA" id="architecteA" dir="rtl"   class="newsletter_input" value="" size="37"/>  </td>
		     	<td class="" align="right" >  المهندس المعماري </td>
	        </tr>
	        <tr>
	            <td class="" align="left">  Type Travaux </td>
				<td class="" align="left"><input type="text" name="typeTravaux"  id="typeTravaux" class="newsletter_input" value=""  size="37"/>  </td>
				<td  align="right"><input type="text" name="typeTravauxA" id="typeTravauxA" dir="rtl"   class="newsletter_input" value="" size="37"/>  </td>
		     	<td class="" align="right" >  بيان الأشغال </td>
	        </tr>
	        </table>
	        <center>-----------------------------</center>
	        <table>
	        <tr>
	            <td  align="right"><input type="text" name="referenceDossier" id="referenceDossier" style="text-align:center"   class="newsletter_input" value="" size="37"/>  </td>
		        <td class="" align="right"> المراجع العقارية  </td>
	        </tr>
	        </table>
	        <center>-----------------------------</center>
	        <table>
	        <tr>
	            <td class="" align="left">  Objet du plan </td>
				<td class="" align="left"><input type="text" name="objetDuPlan" id="objetDuPlan" class="newsletter_input" value=""  size="37"/>  </td>
	        </tr>
	        <tr>
				<td class=""  align="left"> Adresse Travaux  </td>
				<td   class="" align="left" ><input type="text" name="adresseTravaux" id="adresseTravaux"  class="newsletter_input" value="" size="37"/></td>
				<td  align="right"><input type="text" name="adresseTravauxA" id="adresseTravauxA"  dir="rtl" class="newsletter_input" value="" size="37"/>  </td>
		        <td class="" align="right" >  مكان الأشغال </td>	
	        </tr>
	        </table>
	        </form>
	        <center>-------------------------------------</center>
	        <table  border="5" bgcolor="#2F4F4F"  bordercolor="#000000"  class="table table-striped table-hover " >
	        <tr>
				<th> وثائق الملف  </th>
			</tr>
	        
	        <tr id="certificatPropriete" >
	        <td align="center"> <input type="button" id="GenererCertificatPropriete" value= " نسخة عقد الملكية " /> </td>
	        </tr>
	        
	        <tr id="copieCIN">
	        <td align="center"> <input type="button" id="GenererCopieCIN" value= " نسخة بطاقة التعريف الوطنية " /> </td>
	        </tr>
	        
	        <tr id="certificatArchitecte">
	        <td align="center"> <input type="button" id="GenererCertificatArchitecte" value= " نسخة عقدة المهندس " /> </td>
	        </tr>
	        
	        <tr id="noteRenseignements">
	        <td align="center"> <input type="button" id="GenererNoteRenseignements" value= " نسخة مذكرة المعلومات " /> </td>
	        </tr>
	        
	        <tr id="planConstruction" >
	        <td align="center"> <input type="button" id="GenererPlanConstruction" value= " تصميم البناء " /> </td>
	        </tr>
	        
	        <tr id="planTopographique" >
	        <td align="center"> <input type="button" id="GenererPlanTopographique" value= " تصميم المسح الطبوغرافي " /> </td>
	        </tr>
	        </table>
	        </div>
	        
			</center>
    	          
                </div>
                </div>
                 </center>
                </div>
         </div>
         <div class="cleaner"></div>
        </div>
        <div class="content_section_w600 margin_right_10">
        	<div class="header_01"><center></center></div>
			
      
           
            <div class="cleaner"></div>
        </div>
        <div class="cleaner"></div>
        <div class="horizontal_divider"></div>
        <div class="margin_bottom_30"></div>

  
        
        <div class="cleaner"></div>
    
    <!-- end of content -->
     <center>
	<div id="templatemo_footer"> 
    	<div id="top"></div>  
    	Copyright © 2016 <a href="#"><strong>Gestion d'urbanisme</strong></a> | Designed by <a href="http://www.templatemo.com" target="_parent">ZAI-ConceptInfo</a>
        <div id="bottom"></div> 
	</div> <!-- end of footer --> </center>
<!-- Free Website Templates @ TemplateMo.com -->
 <!-- end of container -->
  </body>  
</html>