define(`TOHW_m_dom_namespaceFixup', `'`
      ! Clear all current namespace nodes:
      nsnodes => getNamespaceNodes(this)
      do i = 1, getLength(nsNodes)
        call destroyNode(nsNodes%nodes(i)%this)
      enddo
      deallocate(nsNodes%nodes)
      
      relevantAncestor => getParentNode(this)
      do while (associated(relevantAncestor))
        ! Go up (through perhaps multiple entref nodes)
        if (getNodeType(relevantAncestor)==ELEMENT_NODE) exit
        relevantAncestor => getParentNode(relevantAncestor)
      enddo
      ! Inherit from parent (or not ...)
      if (associated(relevantAncestor)) then
        nsNodesParent => getNamespaceNodes(relevantAncestor)
        allocate(nsNodes%nodes(getLength(nsNodesParent)))
        nsNodes%length = getLength(nsNodesParent)
        do i = 1, getLength(nsNodes)
          nsNodes%nodes(i)%this => &
            createNamespaceNode(getOwnerDocument(this), &
            getPrefix(item(nsNodesParent, i-1)), &
            getNamespaceURI(item(nsNodesParent, i-1)), &
            specified=.false.)
        enddo
      else
        allocate(nsNodes%nodes(0))
        nsNodes%length = 0
      endif

      ! Now check for broken NS declarations, and add namespace
      ! nodes for all non-broken declarations
      attrs => getAttributes(this)
      do i = 0, getLength(attrs)-1
        attr => item(attrs, i)
        if ((getLocalName(attr)=="xmlns" &
          .or.getPrefix(attr)=="xmlns") &
          .and.getNamespaceURI(attr)/="http://www.w3.org/2000/xmlns/") then
          ! This can only I think happen if we bugger about with setPrefix ...
          TOHW_m_dom_throw_error(NAMESPACE_ERR)
        endif
        if (getNamespaceURI(attr)=="http://www.w3.org/2000/xmlns/") then
          if (getLocalName(attr)=="xmlns") then
            call appendNSNode(this, "", getValue(attr), specified=.true.)
          else
            call appendNSNode(this, getLocalName(attr), &
              getValue(attr), specified=.true.)
          endif
        endif
      enddo


      if (getNamespaceURI(this)/="") then
        if (lookupNamespaceURI(this, getPrefix(this))/=getNamespaceURI(this)) then
          ! This is a namespaced node, but its nsURI
          ! is not bound to its prefix.
          ! This will automatically do any necessary replacements ...
          if (getPrefix(this)=="") then
            ! We are dealing with the default prefix
            call setAttributeNS(this, "http://www.w3.org/2000/xmlns/", &
              "xmlns", getNamespaceURI(this))
          else
            call setAttributeNS(this, "http://www.w3.org/2000/xmlns/", &
              "xmlns:"//getPrefix(this), getNamespaceURI(this))
          endif
          ! and add a namespace node (so that we can do lookups on it)
          call appendNSNode(this, getPrefix(this), getNamespaceURI(this), specified=.true.)
        endif ! else it was already declared ...
      else
        ! No (or empty) namespace URI ...
        if (getLocalName(this)=="") then
          ! DOM level 1 node ... report error
          TOHW_m_dom_throw_error(NAMESPACE_ERR)
        else
          ! We must declare the elements prefix to have an empty nsURI
          if (lookupNamespaceURI(this, getPrefix(this))/="") then
            if (getPrefix(this)=="") then
              call setAttributeNS(this, "http://www.w3.org/2000/xmlns/", &
                "xmlns", "")
            else
              call setAttributeNS(this, "http://www.w3.org/2000/xmlns/", &
                "xmlns:"//getPrefix(this), "")
            endif
            ! and add a namespace node for the empty nsURI
            call appendNSNode(this, getPrefix(this), "", specified=.true.)
          endif
        endif
      endif

      do i = 0, getLength(attrs)-1
        ! This loops over the number of attrs present initially, so any we
        ! add within this loop will not get checked - but they will only
        ! be namespace declarations about which we dont care anyway.
        attr => item(attrs, i)
        if (getNamespaceURI(attr)=="http://www.w3.org/2000/xmlns/") then
          cycle ! We already worried about it above.
        elseif (getNamespaceURI(attr)/="") then
          ! This is a namespaced attribute
          if (getPrefix(attr)=="" &
            .or. lookupNamespaceURI(this, getPrefix(attr))/=getNamespaceURI(attr)) then
            ! It has an inappropriate prefix
            if (lookupPrefix(this, getNamespaceURI(attr))/="") then
              ! then an appropriate prefix exists, use it.
              call setPrefix(attr, lookupPrefix(this, getNamespaceURI(attr)))
              ! FIXME should be "most local" prefix. Make sure lookupPrefix does that.
            else
              ! No suitable prefix exists, declare one.
              if (getPrefix(attr)/="") then
                ! Then the current prefix is not in use, its just undeclared.
                call setAttributeNS(this, "http://www.w3.org/2000/xmlns/", &
                  "xmlns:"//getPrefix(attr), getNamespaceURI(attr))
                call appendNSNode(this, getPrefix(attr), getNamespaceURI(attr), specified=.true.)
              else
                ! This node has no prefix, but needs one. Make it up.
                nsIndex = 1
                do while (lookupNamespaceURI(this, "NS"//nsIndex)/="")
                  ! FIXME this will exit if the namespace is undeclared *or* if it is declared to be empty.
                  nsIndex = nsIndex+1
                enddo
                call setAttributeNS(this, "http://www.w3.org/2000/xmlns/", &
                  "xmlns:NS"//nsIndex, getNamespaceURI(attr))
                ! and create namespace node
                call setPrefix(attr, "NS"//nsIndex)
              endif
            endif
          endif
        else 
          ! attribute has no namespace URI
          if (getLocalName(this)=="") then
            ! DOM level 1 node ... report error
            TOHW_m_dom_throw_error(NAMESPACE_ERR)
          endif
          ! otherwise no problem
        endif
      enddo
')`'dnl
TOHW_m_dom_publics(`
  
  public :: normalizeDocument

  public :: getNamespaceNodes
  public :: namespaceFixup

')`'dnl
dnl
TOHW_m_dom_contents(`

  TOHW_m_dom_get(NodeList, namespaceNodes, np%elExtras%namespaceNodes, (ELEMENT_NODE))

  TOHW_subroutine(appendNSNode, (np, prefix, namespaceURI, specified))
    type(Node), pointer :: np
    character(len=*), intent(in) :: prefix
    character(len=*), intent(in) :: namespaceURI
    logical, intent(in) :: specified

    type(Node), pointer :: nnp, dummy
    type(NodeList), pointer :: nsnodes
    integer :: i
    logical :: quickFix

    if (.not.associated(np)) then
      TOHW_m_dom_throw_error(FoX_NODE_IS_NULL)
    endif
    
    if (np%nodeType /= ELEMENT_NODE) then
      TOHW_m_dom_throw_error(FoX_INVALID_NODE)
    endif
    
    ! We never put namespace nodes in the hanging nodes
    ! list since they can never be separated from their
    ! parent element node, so will always be destroyed alongside it.
    quickFix = getGCState(getOwnerDocument(np))
    call setGCState(getOwnerDocument(np), .false.)
    nsnodes => getNamespaceNodes(np)
    ! If we already have this prefix registered in the list, then remove it
    do i = 0, getLength(nsNodes)-1
      if (getPrefix(item(nsNodes, i))==prefix) then
        dummy => remove_nl(nsNodes, i)
        exit
      endif
    enddo

    call append_nl(nsNodes, &
      createNamespaceNode(getOwnerDocument(np), &
        prefix, namespaceURI, specified))
    call setGCState(getOwnerDocument(np), quickFix)

  end subroutine appendNSNode

  TOHW_subroutine(normalizeDocument, (doc))
    type(Node), pointer :: doc

    type(Node), pointer :: this, treeroot, dummy, new, old
    type(DOMConfiguration), pointer :: dc
    logical :: doneAttributes, doneChildren
    integer :: i_tree, i_children

    type(Node), pointer :: relevantAncestor, child, attr
    type(NamedNodeMap), pointer :: attrs
    type(NodeList), pointer :: nsNodes, nsNodesParent
    integer :: i, nsIndex

    if (.not.associated(doc)) then
      TOHW_m_dom_throw_error(FoX_NODE_IS_NULL)
    endif

    if (getNodeType(doc)/=DOCUMENT_NODE) then
      TOHW_m_dom_throw_error(FoX_INVALID_NODE)
    endif

    dc => getDomConfig(doc)
    treeroot => doc

    call setGCstate(doc, .false.)
    ! switch off the memory management, we are going
    ! to destroy all nodes we remove from the tree
    ! immediately.

    ! exception object is *not* passed through in any
    ! of the DOM calls below. This is because all of
    ! these should succeed - if they dont then there
    ! is a problem so we need to terminate immediately
    TOHW_m_dom_treewalk(`

      select case (getNodeType(this))
      case (ELEMENT_NODE)
        TOHW_m_dom_namespaceFixup

      case (ATTRIBUTE_NODE)
        if (getParameter(dc, "entities")) then
          ! we dont care about any attribute children,
          ! we arent going to do anything
          doneChildren = .true.
        endif

      case (TEXT_NODE)
        ! we may need to reset "this" later on ...
        old => getPreviousSibling(this)
        if (.not.associated(old)) old => getParentNode(this)
        dummy => null()
        if (getIsElementContentWhitespace(this) &
          .and..not.getParameter(dc, "element-content-whitespace")) then
          dummy => removeChild(getParentNode(this), this)
          call destroy(dummy)
          this => old
        endif
        if (.not.associated(dummy)) then
          ! We didnt just remove this node.
          ! Do we need to normalize?
          dummy => getPreviousSibling(this)
          if (associated(dummy)) then
            if (getNodeType(dummy)==TEXT_NODE) then
              call appendData(dummy, getData(this))
              dummy => removeChild(getParentNode(this), this)
              call destroy(dummy)
              this => old
            endif
          endif
        endif

      case (CDATA_SECTION_NODE)
        if (.not.getParameter(dc, "cdata-sections")) then
          ! we may need to reset "this" later on ...
          old => getPreviousSibling(this)
          if (.not.associated(old)) old => getParentNode(this)
          dummy => getPreviousSibling(this)
          if (associated(dummy)) then
            if (getNodeType(dummy)==TEXT_NODE) then
              ! append the data to the previous node & chuck away this node
              call appendData(dummy, getData(this))
              dummy => removeChild(getParentNode(this), this)
              call destroy(dummy)
              this => old
            endif
          endif
          if (associated(dummy, getPreviousSibling(this))) then
            ! we didnt merge it so just convert this to a text node
            new => createTextNode(doc, getData(this))
            dummy => replaceChild(doc, this, dummy)
            call destroy(dummy)
            this => new
          endif
        elseif (.not.getParameter(dc, "split-cdata-sections")) then
          ! Actually, on re-reading DOM 3, this is a ridiculous
          ! option. Ignoring for now.
        endif

      case (ENTITY_REFERENCE_NODE)
        if (.not.getParameter(dc, "entities")) then
          if (associated(getFirstChild(this))) then
            !If this node is not representing an unexpanded entity
            ! we will need to reset "this" later on ...
            old => getPreviousSibling(this)
            if (.not.associated(old)) old => getParentNode(this)
            ! take each child, and insert it immediately before the current node
            do i_children = 0, getLength(getChildNodes(this))-1
              dummy => insertBefore(getParentNode(this), getFirstChild(this), this)
            enddo
            ! and finally remove the current node
            dummy => removeChild(getParentNode(this), this)
            call destroy(dummy)
            ! and set the "this" pointer back so we go over these again
            this => old
          endif
        endif

      case (COMMENT_NODE)
        if (.not.getParameter(dc, "comments")) then
          old => getPreviousSibling(this)
          if (.not.associated(old)) old => getParentNode(this)
          dummy => removeChild(getParentNode(this), this)
          call destroy(dummy)
          this => old
        endif
        
      case (DOCUMENT_TYPE_NODE)
        if (getParameter(dc, "canonical-form")) then
          old => getPreviousSibling(this)
          if (.not.associated(old)) old => getParentNode(this)
          dummy => removeChild(getParentNode(this), this)
          call destroy(this)
          this => old
        endif

      end select

', `')

  end subroutine normalizeDocument

  recursive TOHW_subroutine(namespaceFixup, (this))
    type(Node), pointer :: this

    type(Node), pointer :: relevantAncestor, child, attr
    type(NamedNodeMap), pointer :: attrs
    type(NodeList), pointer :: nsNodes, nsNodesParent
    integer :: i, nsIndex

    if (getNodeType(this) /= ELEMENT_NODE &
      .and. getNodeType(this) /= ENTITY_REFERENCE_NODE &
      .and. getNodeType(this)/=DOCUMENT_FRAGMENT_NODE) then
      return
    endif

    if (this%nodeType==ELEMENT_NODE) then
      TOHW_m_dom_namespaceFixup
    endif

    ! And now call this on all appropriate children ...
    child => getFirstChild(this)
    do while (associated(child))
      call namespaceFixup(child)
      child => getNextSibling(child)
    enddo

  end subroutine namespaceFixup

')`'dnl
