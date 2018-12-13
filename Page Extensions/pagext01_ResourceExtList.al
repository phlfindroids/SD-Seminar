pageextension 50101 "CSD Resource List Ext" extends "Resource List"
//CSD1.00 - 2018-01-01
{
    layout
    {
        modify(Type)
        {
            Visible = ShowType;
        }
        addafter("Type")
        {
            field("CSD Resource Type"; "CSD Resource Type")
            {

            }
            field("CSD Maximum Participants"; "CSD Maximum Participants")
            {
                Visible = ShowMaxField;
            }
        }
    }

    trigger OnOpenPage();
    begin
        ShowType := (GetFilter(Type) = '');
        ShowMaxField := (GetFilter(Type) =
                format(Type::Machine));
    end;


    var
        [InDataSet]
        ShowMaxField: Boolean;
        [InDataSet]
        ShowType: Boolean;
}