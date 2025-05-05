package Raylib is
    type RGBA is 0 .. 255;

    type Color is record
        R : RGBA;
        G : RGBA;
        B : RGBA;
        A : RGBA;
    end record;

    package Window is
        procedure Init (W, H : Positive; Title : String);
        procedure Close
            with Import        => true,
                 Convention    => C,
                 External_Name => "CloseWindow";
        function Should_Close return Boolean;
    end Window;

    package Drawing is
        procedure Clear_Background (C : Color); 
    end Drawing;
end Raylib;
