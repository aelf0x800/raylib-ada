with Ada.Text_IO;
with Raylib;

procedure Example is
    use Ada.Text_IO;

    Rect : Raylib.Rectangle  := (300.0, 300.0, 200.0, 200.0);
    Img  : Raylib.Image      := Raylib.Textures.Load_Image ("test.jpg");
    Tex  : Raylib.Texture_2D;
begin
    Raylib.Init_Window (640, 480, "Hello world!");
    Raylib.Timing.Set_Target_FPS (60);
    
    Raylib.Set_Window_Title ("Title change test!");

    Tex := Raylib.Textures.Load_Texture_2D_From_Image (Img);

    while not Raylib.Window_Should_Close loop
        Put_Line ("FPS : " & Raylib.Timing.Get_FPS'Img);

        Raylib.Begin_Drawing;
        Raylib.Clear_Background (Raylib.Black);
        Raylib.Textures.Draw_Texture (Tex, 0, 0, Raylib.White);
        Raylib.Draw_Line (10, 10, 100, 100, Raylib.Red);
        Raylib.Draw_Ellipse (200, 200, 50.0, 100.0, Raylib.Green);
        Raylib.Draw_Rectangle_Rec (Rect, Raylib.Blue);
        Raylib.End_Drawing;
    end loop;
    
    Raylib.Textures.Unload_Image (Img);
    Raylib.Close_Window;
end Example; 
