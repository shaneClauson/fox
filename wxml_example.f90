program wxml_example

use xmlf90_wxml

type(xmlf_t) :: xf

integer :: age = 34
real, dimension(20)  :: x
real, dimension(4,4)  :: y

call xml_OpenFile("simple.xml",xf, indent=.true.)

call xml_AddXMLDeclaration(xf,"UTF-8")
call xml_AddXMLStylesheet(xf,href="simple.css",type="text/css",media="braille")
call xml_AddXMLPI(xf, name="robots")
call xml_AddPseudoAttribute(xf, "index", "yes")
call xml_AddPseudoAttribute(xf, "follow", "no")
call xml_AddXMLPI(xf,name="ccode", data="{hello_world();}")
!
! Uncomment this to test name checks
!
!!call xml_NewElement(xf,"98_john")
!
call xml_NewElement(xf,"john")
call xml_AddAttribute(xf,"age",str(age))
!
! Markup escaping in attributes
!
call xml_AddAttribute(xf,"with_markup","O'Reilly & Assoc is < OUP but > Wiley")
call xml_NewElement(xf,"peter")
call xml_NewElement(xf,"tim")
call xml_AddAttribute(xf,"age","37")
call xml_AddAttribute(xf,"weight",str(123.45,"(f7.3)"))
call xml_AddAttribute(xf,"cholesterol",str(167.0,format="(f8.0)"))
call xml_EndElement(xf,"tim")
call xml_AddPcdata(xf,"Ping-pong")
call xml_AddPcdata(xf,"champion", line_feed=.false.)
!
! Markup escaping in pcdata
!
call xml_AddPcdata(xf," in years < 2004", space=.false., line_feed=.false.)
!
call xml_NewElement(xf,"data")
call xml_AddAttribute(xf,"units","eV")
call random_number(x)
!call xml_AddArray(xf,x)
call xml_EndElement(xf,"data")
call xml_NewElement(xf,"data")
call xml_AddAttribute(xf,"units","Ryd")
call random_number(y)
!
! Writing multidimensional arrays... index order?
!
!call xml_AddArray(xf,reshape(y,(/ 16 /)))
!
! xml_Close will take care to close all outstanding elements
!
call xml_Close(xf)

! Equivalent code:
!
!!call xml_EndElement(xf,"data")
!!call xml_EndElement(xf,"peter")
!!call xml_EndElement(xf,"john")


end program wxml_example
