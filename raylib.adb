with Interfaces.C;
with Interfaces.C.Strings;

package body Raylib is
    use Interfaces.C;

    package body Window is
        procedure Init (Width, Height : int; Title : String) is
            use Interfaces.C.Strings;

            procedure InitWindow (Width, Height : int; Title : chars_ptr)
                with Import        => true,
                     Convention    => C,
                     External_Name => "InitWindow";
            
            C_Title : chars_ptr := New_String (Title);
        begin
            InitWindow (Width, Height, C_Title);
        end Init;

        function Should_Close return Boolean is
            function WindowShouldClose return C_bool
                with Import        => true,
                     Convention    => C,
                     External_Name => "WindowShouldClose";
        
            Result : Boolean := Boolean (WindowShouldClose);
        begin
            return Result;
        end Should_Close;
    
        function Is_Ready return Boolean is
            function IsWindowReady return C_bool
                with Import        => true,
                     Convention    => C,
                     External_Name => "IsWindowReady";
        
            Result : Boolean := Boolean (IsWindowReady);
        begin
            return Result;
        end Is_Ready;

    end Window;
end Raylib;
