page 50100 "CSD Seminar Setup"
{
    Caption = 'Seminar Setup';
    SourceTable = "CSD Seminar Setup";
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    //SourceTable = TableName;
    InsertAllowed = false;
    DeleteAllowed = false;

    layout
    {
        area(Content)
        {
            group(Numbering)
            {
                field("CSD Seminar No."; "CSD Seminar Nos.")
                {

                }
                field("CSD Seminar Registration Nos."; "CSD Seminar Registration Nos.")
                {

                }
                field("CSD Posted Seminar Reg. Nos."; "CSD Posted Seminar Reg. Nos.")
                {

                }

            }
        }
    }

    trigger OnOpenPage();

    begin
        if not get then begin
            Init();
            Insert();
        end;
    end;
}