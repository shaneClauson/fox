module m_common_namecheck

  use m_common_charset, only: isLegalCharRef
  use m_common_format, only: str_to_int_10, str_to_int_16

  implicit none
  private

  character(len=*), parameter :: spaces = " "//achar(9)//achar(10)//achar(13)
  character(len=*), parameter :: lowerCase = "abcdefghijklmnopqrstuvwxyz"
  character(len=*), parameter :: upperCase = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
  character(len=*), parameter :: letters = lowerCase//upperCase
  character(len=*), parameter :: digits = "0123456789"
  character(len=*), parameter :: hexdigits = "0123456789abcdefABCDEF"
  character(len=*), parameter :: NameChars = lowerCase//upperCase//digits//".-_:"
  character(len=*), parameter :: NCNameChars = lowerCase//upperCase//digits//".-_"
  character(len=*), parameter :: PubIdChars = NameChars//spaces//"'()+,/=?;!*#@$%"

  public :: checkName
  public :: checkQName
  public :: checkNCName
  public :: checkEncName
  public :: checkPITarget
  public :: checkSystemId
  public :: checkPubId
  public :: checkIRI
  public :: checkCharacterEntityReference
  public :: checkEntityValue

  public :: prefixOfQName
  public :: localpartOfQName

contains

  pure function checkEncName(name) result(good)
    ![81]   	EncName	   ::=   	[A-Za-z] ([A-Za-z0-9._] | '-')*
    character(len=*), intent(in) :: name
    logical :: good

    integer :: n
    
    n = len(name)
    good = (n > 0)
    if (good) good = (scan(name(1:1), letters) /= 0)
    if (good .and. n > 1) &
         good = (verify(name(2:), NCNameChars) == 0)
  end function checkEncName


  pure function checkPITarget(name) result(good)
    character(len=*), intent(in) :: name
    logical :: good
    ! Validates a string against the XML requirements for a NAME
    ! Is not fully compliant; ignores UTF issues.

    integer :: n

    n = len(name)
    good = (n > 0)
    if (good) good = (scan(name(1:1), letters//'_'//':') /= 0) 
    if (good .and. n > 1) &
             good = (verify(name(2:), NameChars) == 0) 
    if (good .and. n > 2) then
      good = (.not.(scan(name(1:1), 'Xx') == 1 .and. &
                    scan(name(2:2), 'Mm') == 1 .and. &
                    scan(name(3:3), 'Ll') == 1))
    endif
       
  end function checkPITarget


  pure function checkName(name) result(good)
    character(len=*), intent(in) :: name
    logical :: good
    ! Validates a string against the XML requirements for a NAME
    ! Is not fully compliant; ignores UTF issues.

    integer :: n

    n = len(name)
    good = (n > 0)
    if (good) good = (scan(name(1:1), letters//'_'//':') /= 0) 
    if (good .and. n > 1) &
             good = (verify(name(2:), NameChars) == 0) 
       
  end function checkName


  pure function checkQName(name) result(good)
    character(len=*), intent(in) :: name
    logical :: good
    ! Validates a string against the XML requirements for a NAME
    ! Is not fully compliant; ignores UTF issues.

    integer :: n

    n = index(name, ':')
    if (n == 0) then
      good = checkNCName(name)
    else
      good = (checkNCName(name(:n-1)) .and. checkNCName(name(n+1:)))
    endif
  end function checkQName


  pure function checkNCName(name) result(good)
    character(len=*), intent(in) :: name
    logical :: good
    ! Validates a string against the XML requirements for an NCNAME
    ! Is not fully compliant; ignores UTF issues.

    integer :: n

    n = len(name)
    good = (n > 0)
    if (good) good = (scan(name(1:1), letters//'_') /= 0) 
    if (good .and. n > 1) &
             good = (verify(name(2:), NCNameChars) == 0) 
       
  end function checkNCName


  pure function checkPubId(PubId) result(good)
    character(len=*), intent(in) :: PubId
    logical :: good
    character :: q
    ! We are assuming all non-legitimate Chars are already excluded.
    !FIXME should we?
    q = PubId(1:1)
    good = (q/='"'.or.q/="'") 
    good = good.and.(PubId(len(PubId):len(PubId))==q)
    good =  (verify(PubId(2:len(Pubid)-1), PubIdChars) == 0) 
  end function checkPubId


  pure function checkSystemId(SystemId) result(good)
    character(len=*), intent(in) :: SystemId
    logical :: good
    character :: q
    ! We are assuming all non-legitimate Chars are already excluded.
    !FIXME should we?
    q = SystemId(1:1)
    good = (q/='"'.or.q/="'") 
    good = good.and.(SystemId(len(SystemId):len(SystemId))==q)
    good = good.and.(index(SystemId(2:len(SystemId)-1), q)==0)

  end function checkSystemId
    

  function checkIRI(IRI) result(good)
    character(len=*), intent(in) :: IRI
    logical :: good
    !By [Namespaces] section 9, there is no
    ! formal definition of IRI's yet.
    ! The result of this depends whether we are doing
    ! namespaces 1.1 or 1.0. Firstly, because 1.1
    ! allows IRIs as well as URIs, and secondly because
    ! 1.1 allows undeclaring prefixes, so an empty
    ! string is valid here (which is how FoX signals
    ! an undeclared prefix)
    good = .true.
  end function checkIRI


  pure function checkCharacterEntityReference(code, xv) result(good)
    character(len=*), intent(in) :: code
    integer, intent(in) :: xv
    logical :: good

    integer :: i

    good = .false.
    if (len(code) > 0) then
      if (code(1:1) == "#") then
        if (code(2:2) == "x") then
          if (len(code) > 2) then
            good = (verify(code(3:), hexdigits) == 0)
            if (good) then
              i = str_to_int_16(code(3:))
            endif
          endif
        else
          good = (verify(code(2:), digits) == 0)
          if (good) then
            i = str_to_int_10(code(3:))
          endif
        endif
      endif
    endif
    if (good) &
      good = isLegalCharRef(i, xv)
!      good = ((0<i .and. i<55296) &
!      .or.(57343<i .and. i<65534) &
!      .or.(65535<i .and. i<4177778))

  end function checkCharacterEntityReference

  
  pure function checkEntityValue(value) result (good)
    ![9] EntityValue ::= '"' ([^%&"] | PEReference | Reference)* '"'
    !                 |  "'" ([^%&'] | PEReference | Reference)* "'"
    character(len=*), intent(in) :: value
    logical :: good
    ! this is a very imperfect check and should really be in
    ! m_common_entities, and have better error messages
    ! FIXME
    good = (len(value) > 0)
    !good = good.and.(index(value,'&') > 0)
    ! unless it is a char entity reference...
    !if (good) &
    !  good = (index(value, "%") == 0).and.(index(value,"&")==0))
    if (good) then
      if (index(value, '"') > 0) then
        good = (index(value, "'") == 0)
      elseif (index(value, "'") > 0) then
        good = (index(value, '"') == 0)
      endif
    endif

  end function checkEntityValue


  pure function prefixOfQName(qname) result(prefix)
    character(len=*), intent(in) :: qname
    character(len=max(index(qname, ':')-1,0)) :: prefix

    prefix = qname ! automatic truncation
  end function prefixOfQName

  
  pure function localpartOfQname(qname) result(localpart)
    character(len=*), intent(in) :: qname
    character(len=max(len(qname)-index(qname,':'),0)) ::localpart

    localpart = qname(index(qname,':')+1:)
  end function localpartOfQname

end module m_common_namecheck
