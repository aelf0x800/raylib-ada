with Interfaces.C;
with Interfaces.C.Strings;

package body Raylib is
    use Interfaces.C;

    package body Window is
        procedure Init (W, H : Positive; Title : String) is
            use Interfaces.C.Strings;

            procedure InitWindow (W, H : int; Title : chars_ptr)
                with Import        => true,
                     Convention    => C,
                     External_Name => "InitWindow";
            
            C_W     : int       := int(W);
            C_H     : int       := int(H);
            C_Title : chars_ptr := New_String(Title);
        begin
            InitWindow (C_W, C_H, C_Title);
        end Init;

        function Should_Close return Boolean is
            function WindowShouldClose return C_bool
                with Import        => true,
                     Convention    => C,
                     External_Name => "WindowShouldClose";
        
            Result : Boolean := Boolean(WindowShouldClose);
        begin
            return Result;
        end Should_Close;
    end Window;

    package body Drawing is
        procedure Clear_Background (C : Color) 
    end package;
end Raylib;
