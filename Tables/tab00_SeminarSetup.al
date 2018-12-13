table 50100 "CSD Seminar Setup"
{
    Caption = 'Seminar Setup';


    fields
    {
        field(10; "Primary Key"; Code[10])
        {
            Caption = 'Primary Key';
        }
        field(20; "CSD Seminar Nos."; Code[20])

        {
            Caption = 'Seminar Nos.';
            TableRelation = "No. Series";
        }
        field(30; "CSD Seminar Registration Nos."; Code[20])
        {
            Caption = 'Seminar Registration Nos.';
            TableRelation = "No. Series";
        }
        field(40; "CSD Posted Seminar Reg. Nos."; Code[20])
        {
            Caption = ' Posted Seminar Registration Nos.';
            TableRelation = "No. Series";
        }
    }

    keys
    {
        key(PK; "Primary Key")
        {
            Clustered = true;
        }
    }

}