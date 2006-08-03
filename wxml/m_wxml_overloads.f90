 
! This file is AUTOGENERATED!!!!
! Do not edit this file; edit m_wxml_overloads.m4 and regenerate.
!
!
module m_wxml_overloads

  use m_common_format, only: str
  use m_common_realtypes, only: sp, dp
  use m_wxml_core, only: xmlf_t
  use m_wxml_core, only: xml_AddCharacters
  use m_wxml_core, only: xml_AddAttribute
  use m_wxml_core, only: xml_AddPseudoAttribute

  implicit none
  private

  interface xml_AddCharacters
    module procedure CharactersScalarRealDp
    module procedure CharactersScalarRealSp
    module procedure CharactersScalarInt
    module procedure CharactersScalarLg

    module procedure CharactersArrayRealDp
    module procedure CharactersArrayRealSp
    module procedure CharactersArrayInt
    module procedure CharactersArrayLg
    module procedure CharactersArrayCh

    module procedure CharactersMatrixRealDp
    module procedure CharactersMatrixRealSp
    module procedure CharactersMatrixInt
    module procedure CharactersMatrixLg
    module procedure CharactersMatrixCh
  end interface xml_AddCharacters

  interface xml_AddAttribute
    module procedure AttributeScalarRealDp
    module procedure AttributeScalarRealSp
    module procedure AttributeScalarInt
    module procedure AttributeScalarLg

    module procedure AttributeArrayRealDp
    module procedure AttributeArrayRealSp
    module procedure AttributeArrayInt
    module procedure AttributeArrayLg
    module procedure AttributeArrayCh

    module procedure AttributeMatrixRealDp
    module procedure AttributeMatrixRealSp
    module procedure AttributeMatrixInt
    module procedure AttributeMatrixLg
    module procedure AttributeMatrixCh
  end interface xml_AddAttribute

  interface xml_AddPseudoAttribute
    module procedure AttributeScalarRealDp
    module procedure AttributeScalarRealSp
    module procedure AttributeScalarInt
    module procedure AttributeScalarLg

    module procedure AttributeArrayRealDp
    module procedure AttributeArrayRealSp
    module procedure AttributeArrayInt
    module procedure AttributeArrayLg
    module procedure AttributeArrayCh

    module procedure AttributeMatrixRealDp
    module procedure AttributeMatrixRealSp
    module procedure AttributeMatrixInt
    module procedure AttributeMatrixLg
    module procedure AttributeMatrixCh
  end interface xml_AddPseudoAttribute

  public :: xml_AddCharacters
  public :: xml_AddAttribute
  public :: xml_AddPseudoAttribute

contains

  subroutine CharactersScalarRealDp &
    (xf, chars , fmt)

    type(xmlf_t), intent(inout) :: xf
    real(dp) , intent(in)   :: chars
    character(len=*), intent(in), optional :: fmt

    if (present(fmt)) then
       call xml_AddCharacters(xf=xf, chars=str(chars, fmt))
    else
       call xml_AddCharacters(xf=xf, chars=str(chars  ))
     endif
 
  end subroutine CharactersScalarRealDp

  subroutine CharactersScalarRealSp &
    (xf, chars , fmt)

    type(xmlf_t), intent(inout) :: xf
    real(sp) , intent(in)   :: chars
    character(len=*), intent(in), optional :: fmt

    if (present(fmt)) then
       call xml_AddCharacters(xf=xf, chars=str(chars, fmt))
    else
       call xml_AddCharacters(xf=xf, chars=str(chars  ))
     endif
 
  end subroutine CharactersScalarRealSp

  subroutine CharactersScalarInt &
    (xf, chars )

    type(xmlf_t), intent(inout) :: xf
    integer , intent(in)   :: chars

       call xml_AddCharacters(xf=xf, chars=str(chars  ))
 
  end subroutine CharactersScalarInt

  subroutine CharactersScalarLg &
    (xf, chars )

    type(xmlf_t), intent(inout) :: xf
    logical , intent(in)   :: chars

       call xml_AddCharacters(xf=xf, chars=str(chars  ))
 
  end subroutine CharactersScalarLg


  subroutine CharactersArrayRealDp &
    (xf, chars , fmt)

    type(xmlf_t), intent(inout) :: xf
    real(dp) , intent(in) , dimension(:)  :: chars
    character(len=*), intent(in), optional :: fmt

    if (present(fmt)) then
       call xml_AddCharacters(xf=xf, chars=str(chars, fmt))
    else
       call xml_AddCharacters(xf=xf, chars=str(chars  ))
     endif
 
  end subroutine CharactersArrayRealDp

  subroutine CharactersArrayRealSp &
    (xf, chars , fmt)

    type(xmlf_t), intent(inout) :: xf
    real(sp) , intent(in) , dimension(:)  :: chars
    character(len=*), intent(in), optional :: fmt

    if (present(fmt)) then
       call xml_AddCharacters(xf=xf, chars=str(chars, fmt))
    else
       call xml_AddCharacters(xf=xf, chars=str(chars  ))
     endif
 
  end subroutine CharactersArrayRealSp

  subroutine CharactersArrayInt &
    (xf, chars )

    type(xmlf_t), intent(inout) :: xf
    integer , intent(in) , dimension(:)  :: chars

       call xml_AddCharacters(xf=xf, chars=str(chars  ))
 
  end subroutine CharactersArrayInt

  subroutine CharactersArrayLg &
    (xf, chars )

    type(xmlf_t), intent(inout) :: xf
    logical , intent(in) , dimension(:)  :: chars

       call xml_AddCharacters(xf=xf, chars=str(chars  ))
 
  end subroutine CharactersArrayLg

  subroutine CharactersArrayCh &
    (xf, chars , delimiter)

    type(xmlf_t), intent(inout) :: xf
    character(len=*) , intent(in) , dimension(:)  :: chars
    character(len=1), intent(in), optional :: delimiter

       call xml_AddCharacters(xf=xf, chars=str(chars , delimiter ))
 
  end subroutine CharactersArrayCh


  subroutine CharactersMatrixRealDp &
    (xf, chars , fmt)

    type(xmlf_t), intent(inout) :: xf
    real(dp) , intent(in) , dimension(:,:)  :: chars
    character(len=*), intent(in), optional :: fmt

    if (present(fmt)) then
       call xml_AddCharacters(xf=xf, chars=str(chars, fmt))
    else
       call xml_AddCharacters(xf=xf, chars=str(chars  ))
     endif
 
  end subroutine CharactersMatrixRealDp

  subroutine CharactersMatrixRealSp &
    (xf, chars , fmt)

    type(xmlf_t), intent(inout) :: xf
    real(sp) , intent(in) , dimension(:,:)  :: chars
    character(len=*), intent(in), optional :: fmt

    if (present(fmt)) then
       call xml_AddCharacters(xf=xf, chars=str(chars, fmt))
    else
       call xml_AddCharacters(xf=xf, chars=str(chars  ))
     endif
 
  end subroutine CharactersMatrixRealSp

  subroutine CharactersMatrixInt &
    (xf, chars )

    type(xmlf_t), intent(inout) :: xf
    integer , intent(in) , dimension(:,:)  :: chars

       call xml_AddCharacters(xf=xf, chars=str(chars  ))
 
  end subroutine CharactersMatrixInt

  subroutine CharactersMatrixLg &
    (xf, chars )

    type(xmlf_t), intent(inout) :: xf
    logical , intent(in) , dimension(:,:)  :: chars

       call xml_AddCharacters(xf=xf, chars=str(chars  ))
 
  end subroutine CharactersMatrixLg

  subroutine CharactersMatrixCh &
    (xf, chars , delimiter)

    type(xmlf_t), intent(inout) :: xf
    character(len=*) , intent(in) , dimension(:,:)  :: chars
    character(len=1), intent(in), optional :: delimiter

       call xml_AddCharacters(xf=xf, chars=str(chars , delimiter ))
 
  end subroutine CharactersMatrixCh




  subroutine AttributeScalarRealDp &
    (xf, name, value , fmt)

    type(xmlf_t), intent(inout) :: xf
    character(len=*), intent(in) :: name
    real(dp) , intent(in)   :: value
    character(len=*), intent(in), optional :: fmt

    if (present(fmt)) then
       call xml_AddAttribute(xf=xf, name=name, value=str(value, fmt))
    else
       call xml_AddAttribute(xf=xf, name=name, value=str(value  ))
     endif
 
  end subroutine AttributeScalarRealDp

  subroutine AttributeScalarRealSp &
    (xf, name, value , fmt)

    type(xmlf_t), intent(inout) :: xf
    character(len=*), intent(in) :: name
    real(sp) , intent(in)   :: value
    character(len=*), intent(in), optional :: fmt

    if (present(fmt)) then
       call xml_AddAttribute(xf=xf, name=name, value=str(value, fmt))
    else
       call xml_AddAttribute(xf=xf, name=name, value=str(value  ))
     endif
 
  end subroutine AttributeScalarRealSp

  subroutine AttributeScalarInt &
    (xf, name, value )

    type(xmlf_t), intent(inout) :: xf
    character(len=*), intent(in) :: name
    integer , intent(in)   :: value

       call xml_AddAttribute(xf=xf, name=name, value=str(value  ))
 
  end subroutine AttributeScalarInt

  subroutine AttributeScalarLg &
    (xf, name, value )

    type(xmlf_t), intent(inout) :: xf
    character(len=*), intent(in) :: name
    logical , intent(in)   :: value

       call xml_AddAttribute(xf=xf, name=name, value=str(value  ))
 
  end subroutine AttributeScalarLg


  subroutine AttributeArrayRealDp &
    (xf, name, value , fmt)

    type(xmlf_t), intent(inout) :: xf
    character(len=*), intent(in) :: name
    real(dp) , intent(in) , dimension(:)  :: value
    character(len=*), intent(in), optional :: fmt

    if (present(fmt)) then
       call xml_AddAttribute(xf=xf, name=name, value=str(value, fmt))
    else
       call xml_AddAttribute(xf=xf, name=name, value=str(value  ))
     endif
 
  end subroutine AttributeArrayRealDp

  subroutine AttributeArrayRealSp &
    (xf, name, value , fmt)

    type(xmlf_t), intent(inout) :: xf
    character(len=*), intent(in) :: name
    real(sp) , intent(in) , dimension(:)  :: value
    character(len=*), intent(in), optional :: fmt

    if (present(fmt)) then
       call xml_AddAttribute(xf=xf, name=name, value=str(value, fmt))
    else
       call xml_AddAttribute(xf=xf, name=name, value=str(value  ))
     endif
 
  end subroutine AttributeArrayRealSp

  subroutine AttributeArrayInt &
    (xf, name, value )

    type(xmlf_t), intent(inout) :: xf
    character(len=*), intent(in) :: name
    integer , intent(in) , dimension(:)  :: value

       call xml_AddAttribute(xf=xf, name=name, value=str(value  ))
 
  end subroutine AttributeArrayInt

  subroutine AttributeArrayLg &
    (xf, name, value )

    type(xmlf_t), intent(inout) :: xf
    character(len=*), intent(in) :: name
    logical , intent(in) , dimension(:)  :: value

       call xml_AddAttribute(xf=xf, name=name, value=str(value  ))
 
  end subroutine AttributeArrayLg

  subroutine AttributeArrayCh &
    (xf, name, value , delimiter)

    type(xmlf_t), intent(inout) :: xf
    character(len=*), intent(in) :: name
    character(len=*) , intent(in) , dimension(:)  :: value
    character(len=1), intent(in), optional :: delimiter

       call xml_AddAttribute(xf=xf, name=name, value=str(value , delimiter ))
 
  end subroutine AttributeArrayCh


  subroutine AttributeMatrixRealDp &
    (xf, name, value , fmt)

    type(xmlf_t), intent(inout) :: xf
    character(len=*), intent(in) :: name
    real(dp) , intent(in) , dimension(:,:)  :: value
    character(len=*), intent(in), optional :: fmt

    if (present(fmt)) then
       call xml_AddAttribute(xf=xf, name=name, value=str(value, fmt))
    else
       call xml_AddAttribute(xf=xf, name=name, value=str(value  ))
     endif
 
  end subroutine AttributeMatrixRealDp

  subroutine AttributeMatrixRealSp &
    (xf, name, value , fmt)

    type(xmlf_t), intent(inout) :: xf
    character(len=*), intent(in) :: name
    real(sp) , intent(in) , dimension(:,:)  :: value
    character(len=*), intent(in), optional :: fmt

    if (present(fmt)) then
       call xml_AddAttribute(xf=xf, name=name, value=str(value, fmt))
    else
       call xml_AddAttribute(xf=xf, name=name, value=str(value  ))
     endif
 
  end subroutine AttributeMatrixRealSp

  subroutine AttributeMatrixInt &
    (xf, name, value )

    type(xmlf_t), intent(inout) :: xf
    character(len=*), intent(in) :: name
    integer , intent(in) , dimension(:,:)  :: value

       call xml_AddAttribute(xf=xf, name=name, value=str(value  ))
 
  end subroutine AttributeMatrixInt

  subroutine AttributeMatrixLg &
    (xf, name, value )

    type(xmlf_t), intent(inout) :: xf
    character(len=*), intent(in) :: name
    logical , intent(in) , dimension(:,:)  :: value

       call xml_AddAttribute(xf=xf, name=name, value=str(value  ))
 
  end subroutine AttributeMatrixLg

  subroutine AttributeMatrixCh &
    (xf, name, value , delimiter)

    type(xmlf_t), intent(inout) :: xf
    character(len=*), intent(in) :: name
    character(len=*) , intent(in) , dimension(:,:)  :: value
    character(len=1), intent(in), optional :: delimiter

       call xml_AddAttribute(xf=xf, name=name, value=str(value , delimiter ))
 
  end subroutine AttributeMatrixCh




  subroutine PseudoAttributeScalarRealDp &
    (xf, name, value , fmt)

    type(xmlf_t), intent(inout) :: xf
    character(len=*), intent(in) :: name
    real(dp) , intent(in)   :: value
    character(len=*), intent(in), optional :: fmt

    if (present(fmt)) then
       call xml_AddPseudoAttribute(xf=xf, name=name, value=str(value, fmt))
    else
       call xml_AddPseudoAttribute(xf=xf, name=name, value=str(value  ))
     endif
 
  end subroutine PseudoAttributeScalarRealDp

  subroutine PseudoAttributeScalarRealSp &
    (xf, name, value , fmt)

    type(xmlf_t), intent(inout) :: xf
    character(len=*), intent(in) :: name
    real(sp) , intent(in)   :: value
    character(len=*), intent(in), optional :: fmt

    if (present(fmt)) then
       call xml_AddPseudoAttribute(xf=xf, name=name, value=str(value, fmt))
    else
       call xml_AddPseudoAttribute(xf=xf, name=name, value=str(value  ))
     endif
 
  end subroutine PseudoAttributeScalarRealSp

  subroutine PseudoAttributeScalarInt &
    (xf, name, value )

    type(xmlf_t), intent(inout) :: xf
    character(len=*), intent(in) :: name
    integer , intent(in)   :: value

       call xml_AddPseudoAttribute(xf=xf, name=name, value=str(value  ))
 
  end subroutine PseudoAttributeScalarInt

  subroutine PseudoAttributeScalarLg &
    (xf, name, value )

    type(xmlf_t), intent(inout) :: xf
    character(len=*), intent(in) :: name
    logical , intent(in)   :: value

       call xml_AddPseudoAttribute(xf=xf, name=name, value=str(value  ))
 
  end subroutine PseudoAttributeScalarLg


  subroutine PseudoAttributeArrayRealDp &
    (xf, name, value , fmt)

    type(xmlf_t), intent(inout) :: xf
    character(len=*), intent(in) :: name
    real(dp) , intent(in) , dimension(:)  :: value
    character(len=*), intent(in), optional :: fmt

    if (present(fmt)) then
       call xml_AddPseudoAttribute(xf=xf, name=name, value=str(value, fmt))
    else
       call xml_AddPseudoAttribute(xf=xf, name=name, value=str(value  ))
     endif
 
  end subroutine PseudoAttributeArrayRealDp

  subroutine PseudoAttributeArrayRealSp &
    (xf, name, value , fmt)

    type(xmlf_t), intent(inout) :: xf
    character(len=*), intent(in) :: name
    real(sp) , intent(in) , dimension(:)  :: value
    character(len=*), intent(in), optional :: fmt

    if (present(fmt)) then
       call xml_AddPseudoAttribute(xf=xf, name=name, value=str(value, fmt))
    else
       call xml_AddPseudoAttribute(xf=xf, name=name, value=str(value  ))
     endif
 
  end subroutine PseudoAttributeArrayRealSp

  subroutine PseudoAttributeArrayInt &
    (xf, name, value )

    type(xmlf_t), intent(inout) :: xf
    character(len=*), intent(in) :: name
    integer , intent(in) , dimension(:)  :: value

       call xml_AddPseudoAttribute(xf=xf, name=name, value=str(value  ))
 
  end subroutine PseudoAttributeArrayInt

  subroutine PseudoAttributeArrayLg &
    (xf, name, value )

    type(xmlf_t), intent(inout) :: xf
    character(len=*), intent(in) :: name
    logical , intent(in) , dimension(:)  :: value

       call xml_AddPseudoAttribute(xf=xf, name=name, value=str(value  ))
 
  end subroutine PseudoAttributeArrayLg

  subroutine PseudoAttributeArrayCh &
    (xf, name, value , delimiter)

    type(xmlf_t), intent(inout) :: xf
    character(len=*), intent(in) :: name
    character(len=*) , intent(in) , dimension(:)  :: value
    character(len=1), intent(in), optional :: delimiter

       call xml_AddPseudoAttribute(xf=xf, name=name, value=str(value , delimiter ))
 
  end subroutine PseudoAttributeArrayCh


  subroutine PseudoAttributeMatrixRealDp &
    (xf, name, value , fmt)

    type(xmlf_t), intent(inout) :: xf
    character(len=*), intent(in) :: name
    real(dp) , intent(in) , dimension(:,:)  :: value
    character(len=*), intent(in), optional :: fmt

    if (present(fmt)) then
       call xml_AddPseudoAttribute(xf=xf, name=name, value=str(value, fmt))
    else
       call xml_AddPseudoAttribute(xf=xf, name=name, value=str(value  ))
     endif
 
  end subroutine PseudoAttributeMatrixRealDp

  subroutine PseudoAttributeMatrixRealSp &
    (xf, name, value , fmt)

    type(xmlf_t), intent(inout) :: xf
    character(len=*), intent(in) :: name
    real(sp) , intent(in) , dimension(:,:)  :: value
    character(len=*), intent(in), optional :: fmt

    if (present(fmt)) then
       call xml_AddPseudoAttribute(xf=xf, name=name, value=str(value, fmt))
    else
       call xml_AddPseudoAttribute(xf=xf, name=name, value=str(value  ))
     endif
 
  end subroutine PseudoAttributeMatrixRealSp

  subroutine PseudoAttributeMatrixInt &
    (xf, name, value )

    type(xmlf_t), intent(inout) :: xf
    character(len=*), intent(in) :: name
    integer , intent(in) , dimension(:,:)  :: value

       call xml_AddPseudoAttribute(xf=xf, name=name, value=str(value  ))
 
  end subroutine PseudoAttributeMatrixInt

  subroutine PseudoAttributeMatrixLg &
    (xf, name, value )

    type(xmlf_t), intent(inout) :: xf
    character(len=*), intent(in) :: name
    logical , intent(in) , dimension(:,:)  :: value

       call xml_AddPseudoAttribute(xf=xf, name=name, value=str(value  ))
 
  end subroutine PseudoAttributeMatrixLg

  subroutine PseudoAttributeMatrixCh &
    (xf, name, value , delimiter)

    type(xmlf_t), intent(inout) :: xf
    character(len=*), intent(in) :: name
    character(len=*) , intent(in) , dimension(:,:)  :: value
    character(len=1), intent(in), optional :: delimiter

       call xml_AddPseudoAttribute(xf=xf, name=name, value=str(value , delimiter ))
 
  end subroutine PseudoAttributeMatrixCh



end module m_wxml_overloads