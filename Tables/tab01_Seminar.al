table 50101 "CSD Seminar"
{


    fields
    {
        field(10; "No."; Code[20])
        {
            Caption = 'No.';
            trigger OnValidate()
            begin
                if "No." <> xRec."No." then begin
                    SeminarSetup.GET;
                    NoSeriesMgt.TestManual(SeminarSetup."CSD Seminar Nos.");
                    "CSD No. Series" := '';
                end;
            end;
        }
        field(20; "CSD Name"; Text[50])
        {
            Caption = 'Name';
            trigger OnValidate()
            begin
                if ("CSD Search Name" = UpperCase(xRec."CSD Name")) or
                    ("CSD Search Name" = '') then
                    "CSD Search Name" := "CSD Name";
            end;
        }
        field(30; "CSD Seminar Duration"; Decimal)
        {
            Caption = 'Seminar Duration';
            DecimalPlaces = 0 : 1;

        }
        field(40; "CSD Minimum Participants."; Integer)
        {
            Caption = 'Minimum Participants';

        }
        field(50; "CSD Maximum Participants"; Integer)
        {
            Caption = 'Maximum Participants';

        }
        field(60; "CSD Search Name"; Code[50])
        {
            Caption = 'Search Name';

        }
        field(70; "CSD Blocked"; Boolean)
        {
            Caption = 'Blocked';
        }
        field(80; "CSD Last Date Modified"; Date)
        {
            Caption = 'Last Date Modified';
            Editable = false;
        }
        field(90; "CSD Comment"; Boolean)
        {
            Caption = 'Comment';
            Editable = false;
            FieldClass = FlowField;
            //CalcFormula=Exist("CSD Seminar comment Line" where("Tbale Name"=const("Seminar"),
            //"No."=field("No."))));

        }
        field(100; "CSD Seminar Price"; Decimal)
        {
            Caption = 'Number';
            AutoFormatType = 1;

        }
        field(110; "CSD Gen. Prod. Posting Group"; Code[10])
        {
            Caption = 'Gen. Prod. Posting Group';
            TableRelation = "Gen. Product Posting Group";
            trigger OnValidate()
            begin
                if (xRec."CSD Gen. Prod. Posting Group" <>
                    "CSD Gen. Prod. Posting Group") then begin
                    if GenProdPostingGroup.ValidateVatProdPostingGroup
                    (GenProdPostingGroup, "CSD Gen. Prod. Posting Group") then
                        Validate("CSD VAT Prod. Posting Group",
                        GenProdPostingGroup."Def. VAT Prod. Posting Group");
                end;
            end;
        }
        field(120; "CSD VAT Prod. Posting Group"; Code[10])
        {
            Caption = 'VAT Prod. Posting Group';
            TableRelation = "VAT Product Posting Group";

        }
        field(130; "CSD No. Series"; Code[20])
        {
            Caption = 'No. Series';
            Editable = false;
            TableRelation = "No. Series";

        }
    }

    keys
    {
        key(PK; "No.")
        {
            Clustered = true;
        }
        key(Key1; "CSD Search Name")
        {

        }
    }

    var
        SeminarSetup: Record "CSD Seminar Setup";
        //CommentLine : Record "CSD Seminar Comment Line"
        Seminar: Record "CSD Seminar";
        GenProdPostingGroup: Record "Gen. Product Posting Group";
        NoSeriesMgt: Codeunit NoSeriesManagement;

    trigger OnInsert()
    begin
        if "No." = '' then begin
            SeminarSetup.get;
            SeminarSetup.TestField("CSD Seminar Nos.");
            NoSeriesMgt.InitSeries(SeminarSetup."CSD Seminar Nos.", xRec."CSD No. Series", 0D, "No.", "CSD No. Series");
        end;
    end;

    trigger OnModify()
    begin
        "CSD Last Date Modified" := Today;
    end;

    trigger OnDelete()
    begin
        //CommentLine.Reset;
        //CommentLine.SetRange("Table Name",
        //CommentLine."Table Name"::Seminar);
        //CommentLine.SetRange("No.","No.");
        // CommentLine.DeleteAll;
    end;

    trigger OnRename()
    begin
        "CSD Last Date Modified" := Today;
    end;

    procedure AssistEdit(): Boolean
    begin
        with Seminar do begin
            Seminar := Rec;
            SeminarSetup.get;
            SeminarSetup.TestField("CSD Seminar Nos.");
            if NoSeriesMgt.SelectSeries(SeminarSetup."CSD Seminar Nos."
            , xRec."CSD No. Series", "CSD No. Series") then begin
                NoSeriesMgt.SetSeries("No.");
                Rec := Seminar;
                exit(true);
            end;
        end;
    end;
}