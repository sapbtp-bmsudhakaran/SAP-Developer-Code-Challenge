CLASS zcl_abap2ui5 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES z2ui5_if_app.

    DATA user  TYPE string.
    DATA date TYPE string.
    DATA check_initialized TYPE abap_bool.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_abap2ui5 IMPLEMENTATION.
  METHOD z2ui5_if_app~main.

    IF check_initialized = abap_false.
      check_initialized = abap_true.
      user  = 'Sudhakaran'.
      date = '02.06.2023'.
    ENDIF.

    CASE client->get( )-event.
      WHEN 'BUTTON_POST'.
        client->popup_message_toast( |{ user } { date } - send to the server| ).
    ENDCASE.

    client->set_next( VALUE #( xml_main = z2ui5_cl_xml_view=>factory(
        )->shell(
        )->page( title = 'SAP Developer Code Challenge – Open-Source ABAP'
            )->simple_form( title = 'Week 2 Code Challenge' editable = abap_true
                )->content( ns = `form`
                    )->title( 'Make an input here and send it to the server...'
                    )->label( 'User'
                    )->input(
                        value = user
                    )->label( 'Date'
                    )->date_picker( client->_bind( date )
                    )->button(
                        text  = 'post'
                        press = client->_event( 'BUTTON_POST' )
         )->get_root( )->xml_get( ) ) ).

  ENDMETHOD.
ENDCLASS.
