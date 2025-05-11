with Raylib_Ada; use Raylib_Ada;

procedure Test is
begin
   Raylib_Ada.Init_Window (640, 480, "Test window!");
   while not Raylib_Ada.Window_Should_Close loop
      Raylib_Ada.Begin_Drawing;
      Raylib_Ada.Clear_Background (Raylib_Ada.Blue);
      Raylib_Ada.End_Drawing;
   end loop;
   Raylib_Ada.Close_Window;
end Test;
