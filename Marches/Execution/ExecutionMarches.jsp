<%@ page language="java" import="java.util.*"  import="metier.Appelsoffres" import="metier.Chefprojet"  contentType="text/html; charset=UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title> Gestion des Marchés Publics </title>
    
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
    .ui-widget-content { background: "#b9cd6d"; background: url(images/img06.jpg); }
    </style>
    <%
	Integer  idFonctionnaire = 0;
	if ( (Integer) session.getAttribute("idFonctionnaire") != null){
      idFonctionnaire = (Integer) session.getAttribute("idFonctionnaire");  
    } 
    String roleChefDeProjet="Non";
	List listeChefDeProjet=new ArrayList<Chefprojet>();
	if ( (ArrayList<Chefprojet>) session.getAttribute("listeChefDeProjet") != null){
      listeChefDeProjet = (ArrayList<Chefprojet>) session.getAttribute("listeChefDeProjet"); 
      for(int i=0;i<listeChefDeProjet.size();i++)
	  {		
			if(  (((ArrayList<Chefprojet>) listeChefDeProjet).get(i).getIdFonctionnaire()) == idFonctionnaire )
			{
				roleChefDeProjet="Oui";			
			}
	  }
	}  
	String   role = "";
	if ((String) session.getAttribute("role") != null){
      role = (String) session.getAttribute("role");  
    }  
    if( ! ( roleChefDeProjet.equals("Oui") || role.equals("Employé Service Marchés") || role.equals("Représentant Chef Service Marchés") 
    || role.equals("Chef Service Marchés") || role.equals("Chef Division Equipement") || role.equals("Président") )) {
    String site = new String("../../PageNonAutoriseeMarches.jsp");
    response.setStatus(response.SC_MOVED_TEMPORARILY);
    response.setHeader("Location", site); 
    }
    %>
    <% 
    Appelsoffres appelsoffres=null;
    appelsoffres=(Appelsoffres)session.getAttribute("Appelsoffres"); 
    Integer idAppelOffre=0; 
    String numAppelOffre="";
	String anneeAppelOffre="";
	String numMarches="";
	String anneeMarches="";
	String objetAppelOffre="";
	String categorieAo="";
	String statutActuel="";
	String dateOp="";
    if (appelsoffres != null) {
    idAppelOffre=appelsoffres.getIdAppelOffre();
    anneeAppelOffre=appelsoffres.getAnneeAppelOffre().toString();
    numAppelOffre=appelsoffres.getNumAppelOffre().toString()+" / "+anneeAppelOffre;
	anneeMarches=appelsoffres.getAnneeMarches().toString();
	numMarches=appelsoffres.getNumMarches().toString()+" / "+anneeMarches;
	objetAppelOffre=appelsoffres.getObjetAppelOffre();
	dateOp=appelsoffres.getDateOp();
	categorieAo=appelsoffres.getCategorieAo();
	statutActuel=appelsoffres.getStatutActuel();
	}
	String natureAo = "";
	int numMarchesAo = 0;
	if (appelsoffres != null) {
	natureAo = appelsoffres.getNatureAo();
	numMarchesAo = appelsoffres.getNumMarches();
	}
	if(  (!(natureAo.equals("Marché"))) || numMarchesAo == 0 ) {
    String site = new String("../../DossierMarchesNonOuvert.jsp");
    response.setStatus(response.SC_MOVED_TEMPORARILY);
    response.setHeader("Location", site); 
    }
    %>
	<script type="text/javascript">
	$(function(){
      
      $("#site_title").load("menuTitre.html"); 
      $("#site_title2").load("menuTitre2.html"); 
      $("#chargement").load("menuChargement.html");
      $("#chargement").hide();
      $("#bienAjouter").hide();
      $("#dialogBienEnregistrer").hide();
      $("#dialog").hide(); $("#OrdreDeService").hide(); $("#DelaisExecution").hide();
      $("#listeOrdreDeService").hide();$("#listePenaliteDeRetard").hide(); $("#listeRetenueDeGarantie").hide();   
      
      $("#listeAttachements").hide();
      $("#AjouterAttachement").hide();$("#listeBordereauPrix").hide();
      $("#Attachements").hide();$("#Livraisons").hide();$("#Decomptes").hide();$("#Decomptes2").hide();
      $("#dialog").hide(); $("#dialog3").hide(); $("#dialog4").hide(); 
      $("#dialog1").hide(); $("#dialog2").hide(); 
      $("#dialogPublication1").hide(); $("#dialogPublication2").hide();
      $("#dialogOrdreService2").hide();$("#dialogOrdreService3").hide();
      $("#dialogDelaiPrestation2").hide();$("#dialogDelaiPrestation3").hide();
      $("#dialogCaution2").hide();$("#dialogCaution3").hide();
      $("#interfaceAjouterCopieAttachement").hide(); $("#formAjouterPublication").hide(); 
      $("#dialogDocumentsCourrier").hide();$("#dialogAjouterDocument").hide();
      $("#dialogSupprimerPieceJointe1").hide();$("#dialogSupprimerPieceJointe2").hide();
      
      $("#chargement").show();     
        $.ajax( 
        {    
            type: "POST", 
            enctype:"multipart/form-data",
            url: "rechercherBordreauMarches.do", 
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
               $("#listeBordereauPrix").html(html);           
            } 
         });
    
    $("form#formAjouterDocument").submit(function(){
    var formData = new FormData($(this)[0]);

    $("#chargement").show();
    $.ajax({
        url: "ajouterDocumentPieceJointe.do",
        type: 'POST',
        data: formData,
        async: false,
        cache: false,
        contentType: false,
        processData: false,
        error: function()
            { 
               alert("invalid"); 
               $("#chargement").hide();                  
            }, 
        success: function(html) 
           { 
               $("#chargement").hide();
               $("#listeDocumentsCourrier").html(html);  
               $("#listeDocumentsCourrier").show(); 
               $("#dialogAjouterDocument").dialog("close"); 
           }
    });
    return false;
    }); 
    
    $('#btnOrdreDeServiceC').click(function btnOrdreDeServiceC() 
    {                 
        $('#btnOrdreDeServiceAR').removeClass("active btn-info");
        $('#btnOrdreDeServiceC').addClass("active btn-info");
        $('#btnDelaisExecution').removeClass("active btn-info");
        $('#btnCautionProvisoire').removeClass("active btn-info");
        $('#btnCautionDefinitive').removeClass("active btn-info");  
        $('#btnPenaliteDeRetard').removeClass("active btn-info");  
        $('#btnDecomptes').removeClass("active btn-info");
        $('#btnLivraisons').removeClass("active btn-info");
        $('#btnAttachements').removeClass("active btn-info"); 
        $('#btnRetenueDeGarantie').removeClass("active btn-info");
        $("#BtnPublication").removeClass("active btn-info");
        
        $('#tabAttachement1').removeClass("content_section_box31");
        $('#tabAttachement2').removeClass("content_section_box_content21");   
        $('#tabBordereauAttachement1').removeClass("content_section_box30");
        $('#tabBordereauAttachement2').removeClass("content_section_box_content22");   
        $('#tabDecomptes1').removeClass("content_section_box31");
        $('#tabDecomptes2').removeClass("content_section_box_content21");   
       
        $("#chargement").show();     
        $.ajax( 
        {    
            type: "POST", 
            enctype:"multipart/form-data",
            url: "rechercherOrdreDeService.do", 
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
               $("#listeOrdreDeService").html(html);
               $("#listeOrdreDeService").show(); 
               $("#listeDelaisExecution").hide();   
               $("#listePenaliteDeRetard").hide(); 
               $("#listeRetenueDeGarantie").hide();
               $("#Attachements").hide();
               $("#Livraisons").hide();    
               $("#Decomptes").hide();              
               $("#listeDecomptes").hide();   
               $("#listeAttachements").hide();
               $("#listeBordereauPrix").hide();
               $("#listeBordereauPrix2").hide(); 
               $("#listePublication").hide();        
            } 
         });      
    }); 
    
    $('#btnOrdreDeServiceAR').click(function btnOrdreDeServiceAR() 
    {                 
        $('#btnOrdreDeServiceAR').addClass("active btn-info");
        $('#btnOrdreDeServiceC').removeClass("active btn-info");
        $('#btnDelaisExecution').removeClass("active btn-info");
        $('#btnCautionProvisoire').removeClass("active btn-info");
        $('#btnCautionDefinitive').removeClass("active btn-info");  
        $('#btnPenaliteDeRetard').removeClass("active btn-info");  
        $('#btnDecomptes').removeClass("active btn-info");
        $('#btnLivraisons').removeClass("active btn-info");
        $('#btnAttachements').removeClass("active btn-info");
        $('#btnRetenueDeGarantie').removeClass("active btn-info");
        $("#BtnPublication").removeClass("active btn-info");
          
        $('#tabAttachement1').removeClass("content_section_box31");
        $('#tabAttachement2').removeClass("content_section_box_content21");   
        $('#tabBordereauAttachement1').removeClass("content_section_box30");
        $('#tabBordereauAttachement2').removeClass("content_section_box_content22");   
        $('#tabDecomptes1').removeClass("content_section_box31");
        $('#tabDecomptes2').removeClass("content_section_box_content21");   
        $("#chargement").show();     
        $.ajax( 
        {    
            type: "POST", 
            enctype:"multipart/form-data",
            url: "rechercherOrdreDeService2.do", 
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
               $("#listeOrdreDeService").html(html);
               $("#listeOrdreDeService").show(); 
               $("#listeDelaisExecution").hide();   
               $("#listePenaliteDeRetard").hide(); 
               $("#listeRetenueDeGarantie").hide();
               $("#Attachements").hide();
               $("#Livraisons").hide();    
               $("#Decomptes").hide();              
               $("#listeDecomptes").hide();   
               $("#listeAttachements").hide();
               $("#listeBordereauPrix").hide();
               $("#listeBordereauPrix2").hide();
               $("#listePublication").hide();           
            } 
         });      
    }); 
   
    $('#btnDelaisExecution').click(function btnDelaisExecution() 
    {                 
        $('#btnOrdreDeServiceAR').removeClass("active btn-info");
        $('#btnOrdreDeServiceC').removeClass("active btn-info");
        $('#btnDelaisExecution').addClass("active btn-info");
        $('#btnOrdreDeService').removeClass("active btn-info");
        $('#btnCautionProvisoire').removeClass("active btn-info");
        $('#btnCautionDefinitive').removeClass("active btn-info");
        $('#btnPenaliteDeRetard').removeClass("active btn-info");
        $('#btnDecomptes').removeClass("active btn-info");
        $('#btnLivraisons').removeClass("active btn-info");
        $('#btnAttachements').removeClass("active btn-info"); 
        $('#btnRetenueDeGarantie').removeClass("active btn-info");
        $("#BtnPublication").removeClass("active btn-info");
        
        $('#tabAttachement1').removeClass("content_section_box31");
        $('#tabAttachement2').removeClass("content_section_box_content21");   
        $('#tabBordereauAttachement1').removeClass("content_section_box30");
        $('#tabBordereauAttachement2').removeClass("content_section_box_content22");   
        $('#tabDecomptes1').removeClass("content_section_box31");
        $('#tabDecomptes2').removeClass("content_section_box_content21");   
        $("#chargement").show();     
        $.ajax( 
        {    
            type: "POST", 
            enctype:"multipart/form-data",
            url: "rechercherDelaisExecution.do", 
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
               $("#listeDelaisExecution").html(html);
               $("#listeDelaisExecution").show(); 
               $("#listeOrdreDeService").hide(); 
               $("#listePenaliteDeRetard").hide();  
               $("#listeRetenueDeGarantie").hide();
               $("#Attachements").hide();
               $("#Livraisons").hide();    
               $("#Decomptes").hide();              
               $("#listeDecomptes").hide();   
               $("#listeAttachements").hide();
               $("#listeBordereauPrix").hide();
               $("#listeBordereauPrix2").hide(); 
               $("#listePublication").hide();           
            } 
         });      
    });
  
    $('#btnPenaliteDeRetard').click(function btnPenaliteDeRetard() 
    {                 
        $('#btnOrdreDeServiceAR').removeClass("active btn-info");
        $('#btnOrdreDeServiceC').removeClass("active btn-info");
        $('#btnPenaliteDeRetard').addClass("active btn-info");
        $('#btnDelaisExecution').removeClass("active btn-info");
        $('#btnOrdreDeService').removeClass("active btn-info");
        $('#btnCautionProvisoire').removeClass("active btn-info");
        $('#btnCautionDefinitive').removeClass("active btn-info"); 
        $('#btnDecomptes').removeClass("active btn-info");
        $('#btnLivraisons').removeClass("active btn-info");
        $('#btnAttachements').removeClass("active btn-info");
        $('#btnRetenueDeGarantie').removeClass("active btn-info");
        $("#BtnPublication").removeClass("active btn-info");
        
        $('#tabAttachement1').removeClass("content_section_box31");
        $('#tabAttachement2').removeClass("content_section_box_content21");   
        $('#tabBordereauAttachement1').removeClass("content_section_box30");
        $('#tabBordereauAttachement2').removeClass("content_section_box_content22");   
        $('#tabDecomptes1').removeClass("content_section_box31");
        $('#tabDecomptes2').removeClass("content_section_box_content21");     
        $("#chargement").show();     
        $.ajax( 
        {    
            type: "POST", 
            enctype:"multipart/form-data",
            url: "rechercherPenaliteDeRetard.do", 
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
               $("#listePenaliteDeRetard").html(html);
               $("#listePenaliteDeRetard").show(); 
               $("#listeOrdreDeService").hide(); 
               $("#listeDelaisExecution").hide();
               $("#listeRetenueDeGarantie").hide();
               $("#Attachements").hide();
               $("#Livraisons").hide();    
               $("#Decomptes").hide();              
               $("#listeDecomptes").hide();   
               $("#listeAttachements").hide();
               $("#listeBordereauPrix").hide();
               $("#listeBordereauPrix2").hide();
               $("#listePublication").hide();   
            } 
         });      
    });
    $('#btnRetenueDeGarantie').click(function btnRetenueDeGarantie() 
    {                 
        $('#btnRetenueDeGarantie').addClass("active btn-info");
        $('#btnOrdreDeServiceAR').removeClass("active btn-info");
        $('#btnOrdreDeServiceC').removeClass("active btn-info");
        $('#btnDelaisExecution').removeClass("active btn-info");
        $('#btnCautionProvisoire').removeClass("active btn-info");
        $('#btnCautionDefinitive').removeClass("active btn-info");  
        $('#btnPenaliteDeRetard').removeClass("active btn-info");  
        $('#btnDecomptes').removeClass("active btn-info");
        $('#btnLivraisons').removeClass("active btn-info");
        $('#btnAttachements').removeClass("active btn-info"); 
        $("#BtnPublication").removeClass("active btn-info");
        
        $('#tabAttachement1').removeClass("content_section_box31");
        $('#tabAttachement2').removeClass("content_section_box_content21");   
        $('#tabBordereauAttachement1').removeClass("content_section_box30");
        $('#tabBordereauAttachement2').removeClass("content_section_box_content22");   
        $('#tabDecomptes1').removeClass("content_section_box31");
        $('#tabDecomptes2').removeClass("content_section_box_content21");   
       
        $("#chargement").show();     
        $.ajax( 
        {    
            type: "POST", 
            enctype:"multipart/form-data",
            url: "rechercherCautionRg.do", 
            data:$("#formAjouterCaution").serialize(),
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
               $("#listeRetenueDeGarantie").html(html);
               $("#listeRetenueDeGarantie").show(); 
               $("#listeOrdreDeService").hide(); 
               $("#listeDelaisExecution").hide();   
               $("#listePenaliteDeRetard").hide(); 
               $("#Attachements").hide();
               $("#Livraisons").hide();    
               $("#Decomptes").hide();              
               $("#listeDecomptes").hide();   
               $("#listeAttachements").hide();
               $("#listeBordereauPrix").hide();
               $("#listeBordereauPrix2").hide(); 
               $("#listePublication").hide();          
            } 
         });      
    }); 
    $('#btnAttachements').click(function btnAttachements() 
    {                 
        $('#btnAttachements').addClass("active btn-info");
        $('#btnLivraisons').removeClass("active btn-info");
        $('#btnDecomptes').removeClass("active btn-info");
        $('#btnOrdreDeServiceAR').removeClass("active btn-info");
        $('#btnOrdreDeServiceC').removeClass("active btn-info");
        $('#btnDelaisExecution').removeClass("active btn-info");
        $('#btnOrdreDeService').removeClass("active btn-info");
        $('#btnCautionProvisoire').removeClass("active btn-info");
        $('#btnCautionDefinitive').removeClass("active btn-info");
        $('#btnPenaliteDeRetard').removeClass("active btn-info");
        $('#btnRetenueDeGarantie').removeClass("active btn-info");
        $("#BtnPublication").removeClass("active btn-info");
        
        $('#tabAttachement1').addClass("content_section_box31");
        $('#tabAttachement2').addClass("content_section_box_content21");   
        $('#tabBordereauAttachement1').addClass("content_section_box30");
        $('#tabBordereauAttachement2').addClass("content_section_box_content22");   
        $('#tabDecomptes1').addClass("content_section_box31");
        $('#tabDecomptes2').addClass("content_section_box_content21");   
        
        $("#chargement").show();     
        $.ajax( 
        {    
            type: "POST", 
            enctype:"multipart/form-data",
            url: "rechercherAttachements.do", 
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
               $("#Livraisons").hide();
               $("#Attachements").show();
               $("#AjouterAttachement").show();            
               $("#listeAttachements").html(html);  
               $("#listeAttachements").show();
               $("#listeBordereauPrix").hide(); 
               $("#listeBordereauPrix2").hide();  
               $("#Decomptes").hide(); 
               $("#listeDecomptes").hide();   
               $("#listeDelaisExecution").hide();   
               $("#listePenaliteDeRetard").hide();
               $("#listeOrdreDeService").hide();   
               $("#listeRetenueDeGarantie").hide(); 
               $("#listePublication").hide();     
            } 
         });
       
    });
    
    $('#btnDecomptes').click(function btnDecomptes() 
    {                 
        $('#btnDecomptes').addClass("active btn-info");
        $('#btnLivraisons').removeClass("active btn-info");
        $('#btnAttachements').removeClass("active btn-info");
        $('#btnOrdreDeServiceAR').removeClass("active btn-info");
        $('#btnOrdreDeServiceC').removeClass("active btn-info");
        $('#btnDelaisExecution').removeClass("active btn-info");
        $('#btnOrdreDeService').removeClass("active btn-info");
        $('#btnCautionProvisoire').removeClass("active btn-info");
        $('#btnCautionDefinitive').removeClass("active btn-info");
        $('#btnPenaliteDeRetard').removeClass("active btn-info");
        $('#btnRetenueDeGarantie').removeClass("active btn-info");
        $("#BtnPublication").removeClass("active btn-info");
        
        $('#tabAttachement1').addClass("content_section_box31");
        $('#tabAttachement2').addClass("content_section_box_content21");   
        $('#tabBordereauAttachement1').addClass("content_section_box30");
        $('#tabBordereauAttachement2').addClass("content_section_box_content22");   
        $('#tabDecomptes1').addClass("content_section_box31");
        $('#tabDecomptes2').addClass("content_section_box_content21");   
        $("#chargement").show();     
        
        $.ajax( 
        {    
            type: "POST", 
            enctype:"multipart/form-data",
            url: "rechercherDecompte.do", 
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
               $("#listeDecomptes").html(html); 
               $("#Decomptes").show(); 
               $("#listeDecomptes").show();
               $("#listeAttachements").hide();
               $("#listeBordereauPrix").hide();
               $("#listeBordereauPrix2").hide();
               $("#Attachements").hide();
               $("#Livraisons").hide();
               $("#listeDelaisExecution").hide();   
               $("#listePenaliteDeRetard").hide();
               $("#listeOrdreDeService").hide();   
               $("#listePrixDecompte").hide();    
               $("#listeRetenueDeGarantie").hide();  
               $("#listePublication").hide();         
            } 
         });          
    });
    
    $('#btnLivraisons').click(function btnLivraisons() 
    {                 
        $('#btnLivraisons').addClass("active btn-info");
        $('#btnAttachements').removeClass("active btn-info");
        $('#btnDecomptes').removeClass("active btn-info");
        $('#btnOrdreDeServiceAR').removeClass("active btn-info");
        $('#btnOrdreDeServiceC').removeClass("active btn-info");
        $('#btnDelaisExecution').removeClass("active btn-info");
        $('#btnOrdreDeService').removeClass("active btn-info");
        $('#btnCautionProvisoire').removeClass("active btn-info");
        $('#btnCautionDefinitive').removeClass("active btn-info");
        $('#btnPenaliteDeRetard').removeClass("active btn-info");
        $('#btnRetenueDeGarantie').removeClass("active btn-info");
        $("#BtnPublication").removeClass("active btn-info");
        
        $('#tabAttachement1').addClass("content_section_box31");
        $('#tabAttachement2').addClass("content_section_box_content21");   
        $('#tabBordereauAttachement1').addClass("content_section_box30");
        $('#tabBordereauAttachement2').addClass("content_section_box_content22");   
        $('#tabDecomptes1').addClass("content_section_box31");
        $('#tabDecomptes2').addClass("content_section_box_content21");   
        $("#chargement").show();     
        $.ajax( 
        {    
            type: "POST", 
            enctype:"multipart/form-data",
            url: "rechercherAttachements.do", 
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
               $("#Attachements").hide();
               $("#Livraisons").show();
               $("#AjouterAttachement").show();            
               $("#listeAttachements").html(html);  
               $("#listeAttachements").show();
               $("#listeBordereauPrix").hide(); 
               $("#listeBordereauPrix2").hide();   
               $("#Decomptes").hide(); 
               $("#listeDecomptes").hide(); 
               $("#listeDelaisExecution").hide();   
               $("#listePenaliteDeRetard").hide();
               $("#listeOrdreDeService").hide();   
               $("#listeRetenueDeGarantie").hide();
               $("#listePublication").hide();           
            } 
         });
       
    });
            
    $('#ajouterAttachement1').click(function ajouterAttachement1() 
    { 
        $("#chargement").show();  
        $.ajax( 
        {    
            type: "POST", 
            enctype:"multipart/form-data",
            url: "ajouterAttachement.do", 
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
               $("#listeAttachements").html(html);  
               $("#listeAttachements").show(); 
               $("#listeBordereauPrix").hide(); 
               $("#listeBordereauPrix2").hide();    
            } 
         }); 
    } 
    );
    
    $('#ajouterAttachement2').click(function ajouterAttachement2() 
    { 
        $("#chargement").show();  
        $.ajax( 
        {    
            type: "POST", 
            enctype:"multipart/form-data",
            url: "ajouterAttachement.do", 
            data:$("#formAjouterAttachement2").serialize(),
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
               $("#listeAttachements").html(html);  
               $("#listeAttachements").show();
               $("#listeBordereauPrix").hide(); 
               $("#listeBordereauPrix2").hide();     
            } 
         }); 
    } 
    );  
    
    $('#ajouterDecomptes').click(function ajouterDecomptes() 
    { 
        $("#chargement").show();  
        $.ajax( 
        {    
            type: "POST", 
            enctype:"multipart/form-data",
            url: "ajouterDecomptes.do", 
            data:$("#formAjouterDecomptes").serialize(),
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
               $("#listeAttachements").html(html);  
               $("#listeAttachements").show();     
            } 
         }); 
    } 
    );
  $('#BtnPublication').click(function BtnPublication() 
    {        
        $("#formAjouterPublication").show(); 
        $("#formAjouterMembresCommission1").hide();
        $("#chargement").show();
        $("#BtnPublication").addClass("active btn-info");
        $('#btnLivraisons').removeClass("active btn-info");
        $('#btnAttachements').removeClass("active btn-info");
        $('#btnDecomptes').removeClass("active btn-info");
        $('#btnOrdreDeServiceAR').removeClass("active btn-info");
        $('#btnOrdreDeServiceC').removeClass("active btn-info");
        $('#btnDelaisExecution').removeClass("active btn-info");
        $('#btnOrdreDeService').removeClass("active btn-info");
        $('#btnCautionProvisoire').removeClass("active btn-info");
        $('#btnCautionDefinitive').removeClass("active btn-info");
        $('#btnPenaliteDeRetard').removeClass("active btn-info");
        $('#btnRetenueDeGarantie').removeClass("active btn-info");
        
        $('#tabAttachement1').removeClass("content_section_box31");
        $('#tabAttachement2').removeClass("content_section_box_content21");   
        $('#tabBordereauAttachement1').removeClass("content_section_box30");
        $('#tabBordereauAttachement2').removeClass("content_section_box_content22");   
        $('#tabDecomptes1').removeClass("content_section_box31");
        $('#tabDecomptes2').removeClass("content_section_box_content21");   
      
        $.ajax( 
        {    
            type: "POST", 
            enctype:"multipart/form-data",
            url: "rechercherPublication.do", 
            data:$("#formAjouterPublication").serialize(),
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
               $("#listePublication").html(html);  
               $("#listePublication").show();
               $("#listeRetenueDeGarantie").hide(); 
               $("#listeOrdreDeService").hide(); 
               $("#listeDelaisExecution").hide();   
               $("#listePenaliteDeRetard").hide(); 
               $("#Attachements").hide();
               $("#Livraisons").hide();    
               $("#Decomptes").hide();              
               $("#listeDecomptes").hide();   
               $("#listeAttachements").hide();
               $("#listeBordereauPrix").hide();
               $("#listeBordereauPrix2").hide();                     
            } 
         });
       
    });
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
                window.location.replace("../../GestionMarches/GestionMarchesPublics.jsp");             
            } 
        }); 
    } 
    );              
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
        	
        </div>
    </div> <!-- end of header panel -->

    <div id="templatemo_menu">  	
    <ul class="niveau1">
            <li><a href="Marches/LancementMarches/ListeMarches.jsp" > <input type="button" class="btn btn-default" value= " Liste des marchés " />  </a></li>           
            <li><a href="AppelsOffres/LancementAO/AjouterAO.jsp" > <input type="button" class="btn btn-default" value= " Nouveau Marché " /> </a></li>           
            <li><a href="AppelsOffres/DossierAO/DossierAO.jsp" > <input type="button" class="btn btn-default" value= " Dossier Marché " /> </a></li>          
            <li><a href="Marches/ApprobationMarches/ApprobationMarches.jsp"> <input type="button" class="btn btn-default" value= " Approbation " /> </a></li>           
            <li><a href="Marches/EnregistrementMarches/EnregistrementMarches.jsp" class="current2"> <input type="button" class="btn btn-default" value= " Cautions " /> </a></li>            
            <li><a href="Marches/Execution/ExecutionMarches.jsp"> <input type="button" class="btn btn-primary" value= " Exécution du marché" /></a></li>
            <li><a href="AppelsOffres/OuvertureDesPlis/OuvertureDesPlis.jsp"> <input type="button" class="btn btn-default" value= " Etat d'avancement" /> </a></li>                    	
            <li><a href="Marches/Depenses.jsp"  > <input type="button" class="btn btn-default" value= " Dépenses " /> </a> </li> 
            <li><a href="GestionPersonnel/GestionPersonnel.jsp"  > <input type="button" class="btn btn-default" value= " Personnels " />  </a> </li>
            <li><a href="GestionPointageChantier/PointageChantier.jsp"  > <input type="button" class="btn btn-default" value= " Pointage chantier " />  </a> </li> 
            <li><a href="GestionMateriels/GestionMateriels.jsp"  > <input type="button" class="btn btn-default" value= " Matériels Chantier" />  </a> </li>
            <li><a href="Marches/ReceptionMarches/ReceptionMarches.jsp" > <input type="button" class="btn btn-default" value= " Réception Marché" /> </a></li>          
    </ul>
    </div> <!-- end of menu -->
    
    
	<div id="gestionEnregistrementMarches"> 
    <div id="templatemo_content">
                        		  		    
            <div class="content_section_box26">
            <div class="content_section_box_content6">
            <form id="formRechercherMarches" method="post">
            <input type="hidden" name="idAppelOffre"  id="idAppelOffre"    value="<%=idAppelOffre%>" />
            <input type="hidden" name="modeOrdreDeService"  id="modeOrdreDeService"  value="" />
            <input type="hidden" name="typeService"  id="typeService"  value="" />  
            <center>--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------</center> 	        	                                
            <center>
            <table border="0" bgcolor="#D8D38D"   class="table" width="850"  >
            <tr>
		        <td align="center">  <font color="#0B3573"> N° du marché : </font> <font color="#000000"> <%=numMarches%> </font> </td>	
		        <td align="center">  <font color="#0B3573"> Objet du marché : </font> <font color="#000000"> <%=objetAppelOffre%> </font> </td>		        
			</tr>		       
	        </table>
	        <center>--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------</center> 	        	                                
	        </center>              	        	       	     
	        </form> 	             
	        </div> 
            </div>
	 
	        <div class="content_section_box8">
            <div class="content_section_box_content6"> 
                 <center>                           
                 <table >
	             <tr>
		            <td><input type="button" id="btnOrdreDeServiceC" class="btn btn-default" value=" Ordre de service de commencement" size="28"/>
		    		<td><input type="button" id="btnOrdreDeServiceAR" class="btn btn-default" value=" Ordre de service d'arrêt et reprise " size="28"/>
		            <td><input type="button" id="btnDelaisExecution" class="btn btn-default" value=" Délais d'execution et Pénalité De Retard" size="28"/>	
		            <td><input type="button" id="btnRetenueDeGarantie" class="btn btn-default" value=" Retenue de garantie " size="28"/>
		            <td><input type="button" id="btnAttachements" class="btn btn-default" value=" Attachement " size="28"/>
		            <td><input type="button" id="btnLivraisons" class="btn btn-default" value=" Bon de Livraison / Facture" size="28"/>		            
		            <td><input type="button" id="btnDecomptes" class="btn btn-default" value=" Décompte " size="28"/>
		            <td><input type="button" id="BtnPublication"   class="btn btn-default"  value= " Sous-Traitance " size="28"/>  </td>            
		            	            
		         </tr>
		         </table>		         	         	        		                      	        
		         <table bgcolor=""  bordercolor="#000000" class="table " width="1674" border="2">
	             </table>
	             <div id="chargement">               
                 </div>	             	             
	             </center>
	       </div>
	       </div>	      
	             
	             <div id="tab1" class="content_section_box34">	             
                 <div id="tab2" class="content_section_box_content34">
                 <center>
                 <div id="listeOrdreDeService"></div>
                 <div id="listeDelaisExecution"></div>
                 <div id="listePenaliteDeRetard"></div>
                 <div id="listeRetenueDeGarantie"></div>
                 <div id="listePublication">   </div>	  
                 </center>                        	            
                 </div>                 
	             </div>
	             </div>
	             
	             <form id="formAjouterPublication" method="post"> 
	             <input type="hidden" name="idAppelOffre"  id="idAppelOffre"    value="<%=idAppelOffre%>" size="28"/>					                    	             
	        	 <input type="hidden" name="idJournal"  id="idJournal"   value="" size="28"/>					                    	                   			                    	             
	             <input type="hidden" name="nomJournal"  id="nomJournal"  value="" size="28"/>	
	             <input type="hidden" name="typeJournal"  id="typeJournal"  value="" size="28"/>
	             <input type="hidden" name="typeAvis"  id="typeAvis"   value="" size="28"/>							                    	             
	             <input type="hidden" name="numAvis"  id="numAvis"  value="" size="28"/>					                    	             
	             <input type="hidden" name="dateAvis"  id="dateAvis" value="" size="28"/>					                    	             	       	             
	             </form>
	             
	             <div id="OrdreDeService">
                 <form id="formAjouterOrdreDeService" method="post"> 
	             <input type="hidden" name="idAppelOffre"     value="<%=idAppelOffre%>" />					                    	             
	        	 <input type="hidden" name="idOrdreDeService"  id="idOrdreDeService" value="" />
	        	 <input type="hidden" name="numOrdreService"   id="numOrdreService"   value="" />
	        	 <input type="hidden" name="dateOrdreService"  id="dateOrdreService"  value="" />
	        	 <input type="hidden" name="dateSignatureMo"  id="dateSignatureMo"  value="" />
	        	 <input type="hidden" name="dateRecuEntreprise"  id="dateRecuEntreprise"  value="" />
	        	 <input type="hidden" name="typeOrdreService"  id="typeOrdreService"  value="" />
	        	 <input type="hidden" name="motifsOrdreService"  id="motifsOrdreService"  value="" />					                    	             
	        	 <input type="hidden" name="delaiArretPrestation"  id="delaiArretPrestation"  value="" />
	        	 <input type="hidden" name="numPhase"  id="numPhase"  value="" />	   	             
	             </form>	                        
	             </div>	 
	             
	             <div id="DelaisExecution">
                 <form id="formDelaiPrestation" method="post"> 
	             <input type="hidden" name="idAppelOffre"    value="<%=idAppelOffre%>" />					                    	             
	        	 <input type="hidden" name="idDelaiPrestation"  id="idDelaiPrestation" value="" />
	        	 <input type="hidden" name="delaiInitial"   id="delaiInitial"   value="" />        	           
	        	 <input type="hidden" name="delaiEffectif"  id="delaiEffectif"  value="" />
	        	 <input type="hidden" name="numPhase"  id="numPhase3"  value="" />
	        	 <input type="hidden" name="tauxPenalite"  id="tauxPenalite"  value="" />	   	             
	             </form>	                        
	             </div>	 
	             
	             <form id="formAjouterCaution" method="post"> 
	             <input type="hidden" name="idAppelOffre"   class="newsletter_input"  value="<%=idAppelOffre%>" size="28"/>					                    	             
	        	 <input type="hidden" name="idCaution"  id="idCaution"  class="newsletter_input"  value="" size="28"/>
	        	 <input type="hidden" name="typeConcurrent"  value="Adjudicataire" />
	        	 <input type="hidden" name="numCaution4"  id="numCaution4"  class="newsletter_input"  value="" size="28"/>
	        	 <input type="hidden" name="dateEtablissement4"  id="dateEtablissement4"  class="newsletter_input"  value="" size="28"/>
	        	 <input type="hidden" name="typeCaution4"  id="typeCaution4"  class="newsletter_input"  value="" size="28"/>
	        	 <input type="hidden" name="montantCaution4"  id="montantCaution4"  class="newsletter_input"  value="" size="28"/>					                    	             
	        	 <input type="hidden" name="etablissement4"  id="etablissement4"  class="newsletter_input"  value="" size="28"/>
	        	 <input type="hidden" name="etatCaution4"  id="etatCaution4"  class="newsletter_input"  value="" size="28"/>
	        	 <input type="hidden" name="dateDepot4"  id="dateDepot4"  class="newsletter_input"  value="" size="28"/>
	        	 <input type="hidden" name="dateRemise4"  id="dateRemise4"  class="newsletter_input"  value="" size="28"/>	        	              
	             </form>
	             	             
	             <form id="formModifierAttachement" method="post"> 
	             <input type="hidden" name="idAttachement"  id="idAttachementModifier"   value="" /> 					                    	             				                    	             
	        	 <input type="hidden" name="numAttachement"  id="numAttachementModifier" value="" />
	        	 <input type="hidden" name="typeAttachement"  id="typeAttachementModifier" value="" />
	        	 <input type="hidden" name="dateAttachement"  id="dateAttachementModifier" value="" />
	        	 <input type="hidden" name="dateDepotAttachement"  id="dateDepotAttachement" value="" />
	        	 <input type="hidden" name="montantAttachement"  id="montantAttachement" value="" />
	        	 <input type="hidden" name="validerParChefProjet"  id="validerParChefProjet" value="" />
	        	 <input type="hidden" name="validerParService"  id="validerParService" value="" />
	        	 <input type="hidden" name="validerParDivision"  id="validerParDivision" value="" />
	        	 <input type="hidden" name="dateValidationChefProjet"  id="dateValidationChefProjet" value="" />
	        	 <input type="hidden" name="dateValidationService"  id="dateValidationService" value="" />
	        	 <input type="hidden" name="dateValidationDivision"  id="dateValidationDivision" value="" /> 
	        	 </form>
	             
	        <div id ="interfaceAjouterCopieAttachement"  title = "Ajouter une copie de l'attachement / facture" >
            <center>
           	<form id="formAjouterCopieAttachement" action="ajouterCopieAttachement.do" method="post" enctype="multipart/form-data" >
           	<input type="hidden" name="idAttachement"  id="idAttachementAjouterCopie"   value="" />   	
           	<table>
		    <tr>
			    <td > Copie de l'attachement / facture </td>
		        <td><input type="file" name="copieAttachement"  id="copieAttachement" value="télécharger" size="35"/>  </td>   
	        </tr>
	        </table>
	        -----------------------------------------------------------------------------        
	        <table>
	        <tr>	           
	            <td> </td> 
		        <td> <input type="submit"  class="btn btn-default" value=" Enregistrer " size="35" />  </td>      
	        </tr>
	        </table>
	        </form>  
	        </center>
	        </div> 
	             <div id="AjouterAttachement">
	             <div id="tabAttachement1" class="content_section_box31">
                 <div id="tabAttachement2" class="content_section_box_content21">
	     	     <center>
	             <div id="Attachements">	
	             <form id="formAjouterAttachement" method="post"> 
	             <input type="hidden" name="idAppelOffre"    value="<%=idAppelOffre%>" size="28"/>					                    
	             <input type="hidden" name="typeRecherche"  id="typeRecherche"  class="newsletter_input"  value="recherche1" size="28"/> 					                    
	             <input type="hidden" name="idAttachement"  id="idAttachement"  class="newsletter_input"  value="" size="28"/> 					                    	             
	             <input type="hidden" name="idBordereau"  id="idBordereau"  class="newsletter_input"  value="" size="28"/> 					                    	             	             
	             <input type="hidden" name="idLigneAttachement"  id="idLigneAttachement"  class="newsletter_input"  value="" size="28"/> 					                    	             
	             <input type="hidden" name="quantiteAttachement"  id="quantiteAttachement"  class="newsletter_input"  value="" size="28"/> 					                    	             	             	             
	                          
	             <table bgcolor=""  bordercolor="#000000" class="table " width="642" >                        
	             <tr>	         			        
		            <td align="left" > N° Attachement </td>
				    <td align="left"><input type="number" name="numAttachement"   style="text-align:center"  value="" size="4"/> </td>				
	                <td align="left"><input type="hidden" name="dateAttachement"   style="text-align:center"  value="" size="4"/> </td>					             
	                <td align="left" > Type </td>
	                <td><select name="typeAttachement"  class="newsletter_input"  >	                   	                    
	                    <option  value="">---------------------------</option>
	                    <option  value="Provisoire"> Provisoire </option>
		                <option  value="Provisoire et dérnier"> Provisoire et dérnier </option>                       
		                <option  value="Définitif"> Définitif </option>
		                <option  value="Partiel provisoire">Partiel provisoire</option>
		                <option  value="Géneral provisoire">Géneral provisoire</option>		                
		                <option  value="Partiel définitif">Partiel définitif</option>
		                <option  value="Géneral définitif">Géneral définitif</option>
		                </select>
		            </td>
		            <td>  <input type="hidden" name="categorieAttachement"   class="newsletter_input"  value="Attachement" size="28"/> </td>					                    	             	             	             
		            <td><input type="button" id="ajouterAttachement1"  class="btn btn-default4" value=" Ajouter Attachement " size="35"/>  </td>		                  
	             </tr> 
		         </table>
		         </form>
		         </div>
		         
		         <div id="Decomptes2">	
			     <table bgcolor=""  bordercolor="#000000" class="table "  >                        	             
	             <tr>    
		            <td align="left" > Attachement / Livraison </td>	              
		            <td><select name="idAttachement" id="listeAttachements2"  class="newsletter_input"> 
		           
		            </select>
		            </td>
		         </tr>	             
		         </table>
		         </div>
		         
		         <div id="Livraisons">	
		         <form id="formAjouterAttachement2" method="post"> 
		         <input type="hidden" name="idAppelOffre"    class="newsletter_input"  value="<%=idAppelOffre%>" size="28"/>					                    		                      
	             <table bgcolor=""  bordercolor="#000000" class="table " width="642" >                        
	             <tr>	         			        
		            <td align="left" > N° Bon de Livraison </td>
				    <td align="left"><input type="number" name="numAttachement"  class="newsletter_input" style="text-align:center"  value="" size="4"/> </td>				   
	                <td align="left"><input type="hidden" name="dateAttachement"  class="newsletter_input" style="text-align:center"  value="" size="4"/> </td>				
	                <td align="left" > Type </td>
	                <td><select name="typeAttachement"  class="newsletter_input"  >	                   	                    
	                    <option  value="">---------------------------</option>
	                    <option  value="Provisoire"> Provisoire </option>
		                <option  value="Provisoire et dérnier"> Provisoire et dérnier </option>                       
		                <option  value="Définitif"> Définitif </option>
		                <option  value="Partiel provisoire">Partiel provisoire</option>
		                <option  value="Géneral provisoire">Géneral provisoire</option>		                
		                <option  value="Partiel définitif">Partiel définitif</option>
		                <option  value="Géneral définitif">Géneral définitif</option>
		                </select>
		            </td>
		            <td>  <input type="hidden" name="categorieAttachement"   class="newsletter_input"  value="Livraison" size="28"/> </td>					                    	             	             	             		            
		            <td><input type="button" id="ajouterAttachement2"  class="btn btn-default4" value=" Ajouter Bon de Livraison " size="35"/>  </td>		            
		         </tr>   
		         </table>
		         </form>
		         </div>		         
		         	         
	             <div id="listeBordereauPrix">                        
	             </div>
	             </center>               
                 </div>                 
	             </div>
	             </div>
       
	             <div id="BordereauAttachements">	             
	             <div id="tabBordereauAttachement1" class="content_section_box30">	             
                 <div id="tabBordereauAttachement2" class="content_section_box_content22">
                 <div id="listeAttachements"  align="left">                        
	             </div>
	             <div id="listeBordereauPrix2">                        
	             </div>                                  
                 </div>                 
	             </div>
	             </div>
	             
	             
	             <div id="Decomptes">	
	             <center>             
	             <div id="tabDecomptes1" class="content_section_box31">	             
                 <div id="tabDecomptes2" class="content_section_box_content21"> 
                 <form id="formAjouterDecomptes" method="post"> 
		         <input type="hidden" name="idAppelOffre"     value="<%=idAppelOffre%>" size="28"/>					                    		                      
                 <input type="hidden" name="idAttachement"  id="idAttachement2"  class="newsletter_input"  value="" size="28"/> 					                    	             
                 <input type="hidden" name="numDecompte"  id="numDecompte"  class="newsletter_input"  value="" size="28"/> 					                    	             
                 <input type="hidden" name="typeDecompte"  id="typeDecompte"  class="newsletter_input"  value="" size="28"/> 					                    	             
                 <input type="hidden" name="dateDecompte"  id="dateDecompte"  class="newsletter_input"  value="" size="28"/> 					                    	                              
                 <input type="hidden" name="typeRetenue"  id="typeRetenue"  class="newsletter_input"  value="" size="28"/> 					                    	             
                 <input type="hidden" name="montantRevisionPrix"  id="montantRevisionPrix"  class="newsletter_input"  value="0.00" size="28"/> 					                    	                              
                 <input type="hidden" name="montantP"  id="montantP"  class="newsletter_input"  value="0.00" size="28"/>
                 <input type="hidden" name="travauxT"  id="travauxT"  class="newsletter_input"  value="0.00" size="28"/> 					                    	             
                 </form>           
	             <center><div id="listeDecomptes"  align="left"> </div></center>
	             <center><div id="listePrixDecompte" align="left"> </div></center>                                               
                 </div>                 
	             </div>
	             </center>
	             </div> 
	             
	        <div id = "dialogDocumentsCourrier" title = "Pièces Jointes" >       
            <form id="formDocumentsCourrier" method="post">
            <input type="hidden" name="idCourrier" id="idCourrier1"/> 
            <input type="hidden" name="typeDocument"  id="typeDocument1" value=""/>  	
            </form>
            <div id="listeDocumentsCourrier">  </div>
            </div>  
            
            <div id ="dialogAjouterDocument"  title = "Ajouter Pièce Jointe" >
            <center>
           	<form id="formAjouterDocument"  method="post" enctype="multipart/form-data" >
            <input type="hidden" name="idCourrier" id="idCourrier2"/>
            <input type="hidden" name="typeDocument" id="typeDocument2" value=""/>
           	<table>
           	<tr>	
				<td> Nom Pièce jointe </td>
				<td><input type="text" name="nomDocument" size="24"/>  </td>	
			</tr>         	
		    <tr>
			    <td > Pièce jointe en PDF </td>
		        <td><input type="file" name="documentCourrier"  value="télécharger" size="20"/>  </td>   
	        </tr>
	        </table>
	        -----------------------------------------------       
	        <table>
	        <tr>	           
	            <td> </td> 
		        <td> <button>Enregistrer</button>  </td>      
	        </tr>
	        </table>
	        </form>  
	        </center>
	        </div>
	        
	        <form id="formSupprimerDocument" method="post">
            <input type="hidden" name="idDocument" id="idDocument"/>  	
            </form>          	             	             	                        	 	
	 </div> 
     </div>
     
     <div id = "dialogBienEnregistrer" title = "Enregistrement" >
       <font color="#000000"> L'enregistrement a été effectué avec succès  </font>                   	             
    </div> 
    <div id = "dialogPublication1" title = "Supprimer Sous-Traitance" >
      <font color="#000000"> Vous voulez supprimer cette Sous-Traitance ?   </font>
    </div>   
    <div id = "dialogPublication2" title = "Supprimer Sous-Traitance" >
      <font color="#000000"> La Sous-Traitance a été supprimée avec succès   </font>
    
    </div>
     <div id = "dialog4" title = "Supprimer un prix" >
      <font color="#000000"> Vous voulez supprimer ce prix ?   </font>
    </div>   
    <div id = "dialog3" title = "Supprimer un prix" >
      <font color="#000000"> Le prix a été supprimé avec succès   </font>
     
    </div>
    <div id = "dialog2" title = "Supprimer attachement/livraison" >
      <font color="#000000"> Vous voulez supprimer cet attachement/livraison ?   </font>
    </div>   
    <div id = "dialog1" title = "Supprimer attachement/livraison" >
      <font color="#000000"> L'attachement/livraison a été supprimé avec succès   </font>
    
    </div>
    <div id = "dialog" title = "Enregistrement de quantité" >
      <font color="#000000"> L'enregistrement a été réalisée avec succès   </font>
     
    </div> 
     
     <div id = "dialogOrdreService2" title = "Supprimer ordre de service" >
      <font color="#000000"> L'ordre de service a été supprimé avec succès   </font>
     
    </div>
    <div id = "dialogOrdreService3" title = "Supprimer ordre de service" >
      <font color="#000000"> Vous voulez supprimer cet ordre de service ?   </font>
    </div> 
    
    <div id = "dialogDelaiPrestation2" title = "Supprimer délai de prestation" >
      <font color="#000000"> Le délai de prestation a été supprimé avec succès   </font>
     
    </div>
    <div id = "dialogDelaiPrestation3" title = "Supprimer délai de prestation" >
      <font color="#000000"> Vous voulez supprimer ce délai de prestation ?   </font>
    </div>  
    
    <div id = "dialogCaution2" title = "Supprimer Caution" >
      <font color="#000000"> La caution a été supprimé avec succès   </font>
     
    </div>
    <div id = "dialogCaution3" title = "Supprimer Caution" >
      <font color="#000000"> Vous voulez supprimer cette caution ?   </font>
    </div> 
    <div id = "dialogSupprimerPieceJointe2" title = "Supprimer Pièce jointe" >
      <font color="#000000"> Vous voulez supprimer cette pièce jointe ?   </font>
    </div>
	 <div id = "dialogSupprimerPieceJointe1" title = "Supprimer Pièce jointe" >
      <font color="#000000"> La pièce jointe a été supprimée avec succès   </font>   
    </div>        		                
    <!-- end of content -->
    
<!-- Free Website Templates @ TemplateMo.com -->
 <!-- end of container -->
  </body>  
</html>
