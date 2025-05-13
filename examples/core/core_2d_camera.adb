--/////////////////////////////////////////////////////////////////////////////
--
-- raylib_ada example - 2D camera system
--
--/////////////////////////////////////////////////////////////////////////////

with Raylib_Ada; use Raylib_Ada;

--///////////////////////////////////////////////////////////////////////
-- Program entry point
--///////////////////////////////////////////////////////////////////////
procedure Core_2D_Camera is
   Width  : constant Integer := 800;
   Height : constant Integer := 450;

   Player : Raylib_Ada.Rectangle := (400.0, 280.0, 40.0, 40.0);
   Camera : Raylib_Ada.Camera_2D := 
      ((Player.X + 20.0, Player.Y + 20.0),
       (Float (Width) / 2.0, Float (Height) / 2.0),
       0.0,
       1.0); 

   Buildings_Count : constant Integer := 100;
   Buildings       : Array (1 .. Buildings_Count) of Raylib_Ada.Rectangle;
   Build_Colors    : Array (1 .. Buildings_Count) of Raylib_Ada.Color;

   TestVal : Integer := Raylib_Ada.Get_Random_Value (10, 100);
begin
   --///////////////////////////////////////////////////////////////////////
   -- Initialization
   --///////////////////////////////////////////////////////////////////////
   Raylib_Ada.Init_Window (Width, Height, "raylib_ada - core/core_2d_camera");
   Raylib_Ada.Set_Target_FPS (60);
  
   declare
      Spacing : Integer := 0;
   begin
      for I in 1 .. Buildings_Count loop
         Buildings (I).Width  := Float (Raylib_Ada.Get_Random_Value (50, 200));
         Buildings (I).Height := Float (Raylib_Ada.Get_Random_Value (100, 800));
         Buildings (I).Y      := Float (Height) - 130.0 - Buildings (I).Height;
         Buildings (I).X      := -6000.0 + Float (Spacing);

         Spacing := Spacing + Integer (Buildings (I).Width);

         Build_Colors (I) := (0, 170, 0, 255);
      end loop;
   end;

   --///////////////////////////////////////////////////////////////////////
   -- Main game loop
   --///////////////////////////////////////////////////////////////////////
   while not Raylib_Ada.Window_Should_Close loop
      --///////////////////////////////////////////////////////////////////////
      -- Update
      --///////////////////////////////////////////////////////////////////////
      -- Player movement
      if Raylib_Ada.Is_Key_Down (Raylib_Ada.Key_Right) then
         Player.X := Player.X + 2.0;
      elsif Raylib_Ada.Is_Key_Down (Raylib_Ada.Key_Left) then
         Player.X := Player.X - 2.0;
      end if;

      -- Camera follows the player
      Camera.Target := (Player.X + 20.0, Player.Y + 20.0);

      -- Camera rotation controls
      if Raylib_Ada.Is_Key_Down (Raylib_Ada.Key_A) then
         Camera.Rotation := Camera.Rotation - 1.0;
      elsif Raylib_Ada.Is_Key_Down (Raylib_Ada.Key_S) then
         Camera.Rotation := Camera.Rotation + 1.0;
      end if;

      -- Limit camera rotation to -40 to 40 degrees
      if Camera.Rotation < -40.0 then
         Camera.Rotation := -40.0;
      elsif Camera.Rotation > 40.0 then
         Camera.Rotation := 40.0;
      end if;

      -- Camera zoom controls
      Camera.Zoom := Camera.Zoom + Raylib_Ada.Get_Mouse_Wheel_Move * 0.05;

      -- Limit camera zoom
      if Camera.Zoom < 0.1 then
         Camera.Zoom := 0.1;
      elsif Camera.Zoom > 3.0 then
         Camera.Zoom := 3.0;
      end if;

      -- Reset the camera zoom and rotation
      if Raylib_Ada.Is_Key_Pressed (Raylib_Ada.Key_R) then
         Camera.Zoom := 1.0;
         Camera.Rotation := 0.0;
      end if;

      --///////////////////////////////////////////////////////////////////////
      -- Draw
      --///////////////////////////////////////////////////////////////////////
      Raylib_Ada.Begin_Drawing;
         Raylib_Ada.Clear_Background (Raylib_Ada.Ray_White);
         
         Raylib_Ada.Begin_Mode_2D (Camera);
            Raylib_Ada.Draw_Rectangle 
               (-6000, 320, 13000, 8000, Raylib_Ada.Dark_Gray);

            for I in 1 .. Buildings_Count loop
               Raylib_Ada.Draw_Rectangle_Rec (Buildings (I), Build_Colors (I));
            end loop;

            Raylib_Ada.Draw_Rectangle_Rec (Player, Raylib_Ada.Red);
         Raylib_Ada.End_Mode_2D;
      Raylib_Ada.End_Drawing;
   end loop;

   --///////////////////////////////////////////////////////////////////////
   -- De-initialization
   --///////////////////////////////////////////////////////////////////////
   Raylib_Ada.Close_Window; -- Close the window and OpenGL context
end Core_2D_Camera;
