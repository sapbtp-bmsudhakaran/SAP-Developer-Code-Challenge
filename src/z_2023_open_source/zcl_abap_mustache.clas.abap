CLASS zcl_abap_mustache DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.

    TYPES:
      BEGIN OF lty_shop_item,
        name  TYPE string,
        price TYPE p LENGTH 15 DECIMALS 2,
      END OF lty_shop_item,

      ltt_shop_item TYPE STANDARD TABLE OF lty_shop_item WITH DEFAULT KEY,

      BEGIN OF lty_shop,
        shop_name TYPE string,
        items     TYPE ltt_shop_item,
      END OF lty_shop.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_abap_mustache IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.
    DATA: lo_mustache  TYPE REF TO zcl_mustache,
          lv_text      TYPE string,
          ls_shop_data TYPE lty_shop.

    " c_nl is a local shortcut for newline char, e.g. from cl_abap_char_utilities
    " it is not mandatory, I just suppose that we want readable html as output
    lo_mustache = zcl_mustache=>create(
      'Welcome to <b>{{shop_name}}</b>!' && cl_abap_char_utilities=>newline &&
      '<table>' && cl_abap_char_utilities=>newline &&
      ' {{#items}}' && cl_abap_char_utilities=>newline &&
      ' <tr><td>{{name}}</td><td>${{price}}</td>' && cl_abap_char_utilities=>newline &&
      ' {{/items}}' && cl_abap_char_utilities=>newline &&
      '</table>' ).

    ls_shop_data-shop_name = 'Amazon'.

    APPEND INITIAL LINE TO ls_shop_data-items ASSIGNING FIELD-SYMBOL(<lfs_item>).
    <lfs_item>-name = 'Sandals'.
    <lfs_item>-price ='359'.

    APPEND INITIAL LINE TO ls_shop_data-items ASSIGNING <lfs_item>.
    <lfs_item>-name = 'Flip Flops'.
    <lfs_item>-price ='270'.

    lv_text = lo_mustache->render( ls_shop_data ).

    out->write(
      EXPORTING
        data   = lv_text
    ).

  ENDMETHOD.
ENDCLASS.
