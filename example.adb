with Ada.Text_IO;
with Raylib;

procedure Example is
    use Ada.Text_IO;

    Rect : Raylib.Rectangle := (300.0, 300.0, 200.0, 200.0);
begin
    Raylib.Window.Init (640, 480, "Hello wrodl!");
    Raylib.Timing.Set_Target_FPS (60);

    if Raylib.Window.Is_Ready then
        Put_Line ("Window is ready!");
    end if;

    while not Raylib.Window.Should_Close loop
        Put_Line ("FPS : " & Raylib.Timing.Get_FPS'Img);

        Raylib.Drawing.Start;
        Raylib.Drawing.Clear_Background (Raylib.Black);
        Raylib.Drawing.Draw_Line (10, 10, 100, 100, Raylib.Red);
        Raylib.Drawing.Draw_Ellipse (200, 200, 50.0, 100.0, Raylib.Green);
        Raylib.Drawing.Draw_Rectangle_Rec (Rect, Raylib.Blue);
        Raylib.Drawing.Stop;
    end loop;
    
    Raylib.Window.Close;
end Example; 
