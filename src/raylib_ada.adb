package body Raylib_Ada is
   --//////////////////////////////////////////////////////////////////////////
   -- Window-related functions and procedures
   --//////////////////////////////////////////////////////////////////////////
   -- Initialize window and OpenGL context
   procedure Init_Window (Width, Height : C_Int; Title : String) is
      procedure C_Init_Window 
         (Width, Height : C_Int; Title : C.Strings.chars_ptr)
         with 
            Import        => true,
            Convention    => C,
            External_Name => "InitWindow";
   
      C_Title : C.Strings.chars_ptr := C.Strings.New_String (Title);
   begin
      C_Init_Window (Width, Height, C_Title);
      C.Strings.Free (C_Title);
   end Init_Window;

   -- Check if application should close (KEY_ESCAPE pressed or windows close icon clicked)
   function Window_Should_Close return Boolean is
      function C_Window_Should_Close return C.C_bool
         with 
            Import        => true,
            Convention    => C,
            External_Name => "WindowShouldClose";
   
      Result : constant Boolean := Boolean (C_Window_Should_Close);
   begin
      return Result;
   end Window_Should_Close;

    -- Check if window has been initialized successfully
   function Is_Window_Ready return Boolean is
      function C_Is_Window_Ready return C.C_bool
         with 
            Import        => true,
            Convention    => C,
            External_Name => "IsWindowReady";
   
      Result : constant Boolean := Boolean (C_Is_Window_Ready);
   begin
      return Result;
   end Is_Window_Ready;

   -- Check if window is currently fullscreen
   function Is_Window_Fullscreen return Boolean is
      function C_Is_Window_Fullscreen return C.C_bool
         with 
            Import        => true,
            Convention    => C,
            External_Name => "IsWindowFullscreen";
   
      Result : constant Boolean := Boolean (C_Is_Window_Fullscreen);
   begin
      return Result;
   end Is_Window_Fullscreen;

   -- Check if window is currently hidden
   function Is_Window_Hidden return Boolean is
      function C_Is_Window_Hidden return C.C_bool
         with 
            Import        => true,
            Convention    => C,
            External_Name => "IsWindowHidden";
   
      Result : constant Boolean := Boolean (C_Is_Window_Hidden);
   begin
      return Result;
   end Is_Window_Hidden;

   -- Check if window is currently minimized
   function Is_Window_Minimized return Boolean is
      function C_Is_Window_Minimized return C.C_bool
         with 
            Import        => true,
            Convention    => C,
            External_Name => "IsWindowMinimized";
   
      Result : constant Boolean := Boolean (C_Is_Window_Minimized);
   begin
      return Result;
   end Is_Window_Minimized;

   -- Check if window is currently maximized
   function Is_Window_Maximized return Boolean is
      function C_Is_Window_Maximized return C.C_bool
         with 
            Import        => true,
            Convention    => C,
            External_Name => "IsWindowMaximized";
   
      Result : constant Boolean := Boolean (C_Is_Window_Maximized);
   begin
      return Result;
   end Is_Window_Maximized;

   -- Check if window is currently focused
   function Is_Window_Focused return Boolean is
      function C_Is_Window_Focused return C.C_bool
         with
            Import        => true,
            Convention    => C,
            External_Name => "IsWindowFocused";
   
      Result : constant Boolean := Boolean (C_Is_Window_Focused);
   begin
      return Result;
   end Is_Window_Focused;

   -- Check if window has been resized last frame
   function Is_Window_Resized return Boolean is
      function C_Is_Window_Resized return C.C_bool
         with 
            Import        => true,
            Convention    => C,
            External_Name => "IsWindowResized";
   
      Result : constant Boolean := Boolean (C_Is_Window_Resized);
   begin
      return Result;
   end Is_Window_Resized;

   -- Check if one specific window flag is enabled
   function Is_Window_State (Flag : C.unsigned) return Boolean is
      function C_Is_Window_State (Flag : C.unsigned) return C.C_bool
         with
            Import        => true,
            Convention    => C,
            External_Name => "IsWindowState";
   
      Result : constant Boolean := Boolean (C_Is_Window_State (Flag));
   begin
      return Result;
   end Is_Window_State;

   -- Set title for window
   procedure Set_Window_Title (Title : String) is
      procedure C_Set_Window_Title (Title : C.Strings.chars_ptr)
         with
            Import        => true,
            Convention    => C,
            External_Name => "SetWindowTitle";
 
      C_Title : C.Strings.chars_ptr := C.Strings.New_String (Title);
   begin
      C_Set_Window_Title (C_Title);
      C.Strings.Free (C_Title);
   end Set_Window_Title;

   -- Get the human-readable, UTF-8 encoded name of the specified monitor
   function Get_Monitor_Name (Monitor : C_Int) return String is
      function C_Get_Monitor_Name (Monitor : C_Int) return C.Strings.chars_ptr
         with
            Import        => true,
            Convention    => C,
            External_Name => "GetMonitorName";
  
      C_Name : C.Strings.chars_ptr := C_Get_Monitor_Name (Monitor);
      Name   : String              := C.Strings.Value (C_Name);
   begin
      return Name;
   end Get_Monitor_Name;

   -- Set clipboard text content
   procedure Set_Clipboard_Text (Text : String) is
      procedure C_Set_Clipboard_Text (Text : C.Strings.chars_ptr)
         with
            Import        => true,
            Convention    => C,
            External_Name => "SetClipboardText";

      C_Text : C.Strings.chars_ptr := C.Strings.New_String (Text);
   begin
      C_Set_Clipboard_Text (C_Text);
      C.Strings.Free (C_Text);
   end Set_Clipboard_Text;

   -- Get clipboard text content
   function Get_Clipboard_Text return String is
      function C_Get_Clipboard_Text return C.Strings.chars_ptr
         with
            Import        => true,
            Convention    => C,
            External_Name => "GetClipboardText";

      C_Text : C.Strings.chars_ptr := C_Get_Clipboard_Text;
      Text   : String              := C.Strings.Value (C_Text);
   begin
      return Text;
   end Get_Clipboard_Text;

   --//////////////////////////////////////////////////////////////////////////
   -- Cursor-related functions and procedures
   --//////////////////////////////////////////////////////////////////////////
   -- Check if cursor is not visible
   function Is_Cursor_Hidden return Boolean is
      function C_Is_Cursor_Hidden return C.C_bool
      with
         Import        => true,
         Convention    => C,
         External_Name => "IsCursorHidden";
  
      Result : constant Boolean := Boolean (C_Is_Cursor_Hidden);
   begin
      return Result;
   end Is_Cursor_Hidden;
  
   -- Check if cursor is on the screen
   function Is_Cursor_On_Screen return Boolean is
      function C_Is_Cursor_On_Screen return C.C_bool
      with
         Import        => true,
         Convention    => C,
         External_Name => "IsCursorOnScreen";

      Result : constant Boolean := Boolean (C_Is_Cursor_On_Screen);
   begin
      return Result;
   end Is_Cursor_On_Screen;


   --//////////////////////////////////////////////////////////////////////////
   -- Shader management functions and procedures
   -- NOTE: Shader functionality is not available on OpenGL 1.1
   --//////////////////////////////////////////////////////////////////////////
   -- Load shader from files and bind default locations
   function Load_Shader (Vs_File_Name, Fs_File_Name : String) return Shader is
      function C_Load_Shader 
         (Vs_File_Name, Fs_File_Name : C.Strings.chars_ptr) return Shader 
         with
            Import        => true,
            Convention    => C,
            External_Name => "LoadShader";
  
      C_Vs_File_Name : C.Strings.chars_ptr := 
         C.Strings.New_String (Vs_File_Name);
      C_Fs_File_Name : C.Strings.chars_ptr := 
         C.Strings.New_String (Fs_File_Name);
      Shadr          : Shader              := 
         C_Load_Shader (C_Vs_File_Name, C_Fs_File_Name); 
   begin
      C.Strings.Free (C_Vs_File_Name);
      C.Strings.Free (C_Fs_File_Name);
      return Shadr;
   end Load_Shader;

   -- Load shader from code strings and bind default locations
   function Load_Shader_From_Memory 
      (Vs_Code, Fs_Code : String) return Shader 
   is
      function C_Load_Shader_From_Memory 
         (Vs_Code, Fs_Code : C.Strings.chars_ptr) return Shader 
         with
            Import        => true,
            Convention    => C,
            External_Name => "LoadShaderFromMemory";

      C_Vs_Code : C.Strings.chars_ptr := C.Strings.New_String (Vs_Code);
      C_Fs_Code : C.Strings.chars_ptr := C.Strings.New_String (Fs_Code);
      Shadr     : Shader              := 
         C_Load_Shader_From_Memory (C_Vs_Code, C_Fs_Code);
   begin
      C.Strings.Free (C_Vs_Code);
      C.Strings.Free (C_Fs_Code);
      return Shadr;
   end Load_Shader_From_Memory;

   function Is_Shader_Valid (Shadr : Shader) return Boolean is
      function C_Is_Shader_Valid (Shadr : Shader) return C.C_bool
         with 
            Import        => true,
            Convention    => C,
            External_Name => "IsShaderValid";
   
      Result : constant Boolean := Boolean (C_Is_Shader_Valid (Shadr));
   begin
      return Result;
   end Is_Shader_Valid;

   -- Get shader uniform location
   function Get_Shader_Location 
      (Shadr : Shader; Uniform_Name : String) return C_Int
   is
      function C_Get_Shader_Location 
         (Shadr : Shader; Uniform_Name : C.Strings.chars_ptr) return C_Int 
         with
            Import        => true,
            Convention    => C,
            External_Name => "GetShaderLocation";

      C_Uniform_Name : C.Strings.chars_ptr := 
         C.Strings.New_String (Uniform_Name);
      Location       : C_Int               := 
         C_Get_Shader_Location (Shadr, C_Uniform_Name);
   begin
      C.Strings.Free (C_Uniform_Name);
      return Location;
   end Get_Shader_Location;

   -- Get shader attribute location
   function Get_Shader_Location_Attrib 
      (Shadr : shader; Attrib_Name : String) return C_Int
   is
      function C_Get_Shader_Location_Attrib 
         (Shadr : shader; Attrib_Name : C.Strings.chars_ptr) return C_Int 
         with
            Import        => true,
            Convention    => C,
            External_Name => "GetShaderLocationAttrib";
      
      C_Attrib_Name : C.Strings.chars_ptr := 
         C.Strings.New_String (Attrib_Name);
      Location      : C_Int               := 
         C_Get_Shader_Location_Attrib (Shadr, C_Attrib_Name);
   begin
      C.Strings.Free (C_Attrib_Name);
      return Location;
   end Get_Shader_Location_Attrib;

   --//////////////////////////////////////////////////////////////////////////
   -- Misc. procedures
   --//////////////////////////////////////////////////////////////////////////
   -- Takes a screenshot of current screen (filename extension defines format)
   procedure Take_Screenshot (File_Name : String) is
      procedure C_Take_Screenshot (File_Name : C.Strings.chars_ptr) 
      with
         Import        => true,
         Convention    => C,
         External_Name => "TakeScreenshot";

      C_File_Name : C.Strings.chars_ptr := C.Strings.New_String (File_Name);
   begin
      C_Take_Screenshot (C_File_Name);
      C.Strings.Free (C_File_Name);
   end Take_Screenshot;

   -- Open URL with default system browser (if available)
   procedure Open_URL (URL : String) is
      procedure C_Open_URL (URL : C.Strings.chars_ptr) 
      with
         Import        => true,
         Convention    => C,
         External_Name => "OpenURL";
 
      C_URL : C.Strings.chars_ptr := C.Strings.New_String (URL);
   begin
      C_Open_URL (C_URL);
      C.Strings.Free (C_URL);
   end Open_URL;

   --//////////////////////////////////////////////////////////////////////////
   -- Input handling functions and procedures
   --//////////////////////////////////////////////////////////////////////////
   -- Input-related functions: keyboard
   -- Check if a key has been pressed once
   function Is_Key_Pressed (Key : Keyboard_Key) return Boolean is
      function C_Is_Key_Pressed (Key : Keyboard_Key) return C.C_bool
         with
            Import        => true,
            Convention    => C,
            External_Name => "IsKeyPressed";

      Result : constant Boolean := Boolean (C_Is_Key_Pressed (Key));
   begin
      return Result;
   end Is_Key_Pressed;

   -- Check if a key has been pressed again
   function Is_Key_Pressed_Repeat (Key : Keyboard_Key) return Boolean is
      function C_Is_Key_Pressed_Repeat (Key : Keyboard_Key) return C.C_bool
         with
            Import        => true,
            Convention    => C,
            External_Name => "IsKeyPressedRepeat";

      Result : constant Boolean := Boolean (C_Is_Key_Pressed_Repeat (Key));
   begin
      return Result;
   end Is_Key_Pressed_Repeat;
   
   -- Check if a key is being pressed
   function Is_Key_Down (Key : Keyboard_Key) return Boolean is
      function C_Is_Key_Down (Key : Keyboard_Key) return C.C_bool
         with
            Import        => true,
            Convention    => C,
            External_Name => "IsKeyDown";

      Result : constant Boolean := Boolean (C_Is_Key_Down (Key));
   begin
      return Result;
   end Is_Key_Down;
   
   -- Check if a key has been released once
   function Is_Key_Released (Key : Keyboard_Key) return Boolean is
      function C_Is_Key_Released (Key : Keyboard_Key) return C.C_bool
         with
            Import        => true,
            Convention    => C,
            External_Name => "IsKeyReleased";

      Result : constant Boolean := Boolean (C_Is_Key_Released (Key));
   begin
      return Result;
   end Is_Key_Released;

   -- Check if a key is NOT being pressed
   function Is_Key_Up (Key : Keyboard_Key) return Boolean is
      function C_Is_Key_Up (Key : Keyboard_Key) return C.C_bool
         with
            Import        => true,
            Convention    => C,
            External_Name => "IsKeyUp";

      Result : constant Boolean := Boolean (C_Is_Key_Up (Key));
   begin
      return Result;
   end Is_Key_Up;

   -- Get char pressed (unicode), call it multiple times for chars queued, returns 0 when the queue is empty
   function Get_Char_Pressed return Wide_Character is
      function C_Get_Char_Pressed return C_Int
         with
            Import        => true,
            Convention    => C,
            External_Name => "GetCharPressed";

      --Wide_Char : Wide_Character := Wide_Character (C_Get_Char_Pressed);
   begin
      return 'X';
      --return Wide_Char;
   end Get_Char_Pressed;

   -- Input-related functions: gamepads
   -- Check if a gamepad is available
   function Is_Gamepad_Available (Gamepad : C_Int) return Boolean is
      function C_Is_Gamepad_Available (Gamepad : C_Int) return C.C_bool
         with
            Import        => true,
            Convention    => C,
            External_Name => "IsGamepadAvailable";

      Result : constant Boolean := Boolean (C_Is_Gamepad_Available (Gamepad)); 
   begin
      return Result;
   end Is_Gamepad_Available;
   
   -- Get gamepad C_Internal name id
   function Get_Gamepad_Name (Gamepad : C_Int) return String is
      function C_Get_Gamepad_Name (Gamepad : C_Int) return C.Strings.chars_ptr 
         with
            Import        => true,
            Convention    => C,
            External_Name => "GetGamepadName";

      C_Gamepad_Name : C.Strings.chars_ptr := C_Get_Gamepad_Name (Gamepad);
      Gamepad_Name   : String              := C.Strings.Value (C_Gamepad_Name);
   begin
      return Gamepad_Name;
   end Get_Gamepad_Name;
   
   -- Check if a gamepad button has been pressed once
   function Is_Gamepad_Button_Pressed 
      (Gamepad : C_Int; Button : Gamepad_Button) return Boolean is
      function C_Is_Gamepad_Button_Pressed 
         (Gamepad : C_Int; Button : Gamepad_Button) return C.C_bool 
         with
            Import        => true,
            Convention    => C,
            External_Name => "IsGamepadButtonPressed";

      Result : constant Boolean := 
         Boolean (C_Is_Gamepad_Button_Pressed (Gamepad, Button));
   begin
      return Result;
   end Is_Gamepad_Button_Pressed;

   -- Check if a gamepad button is being pressed
   function Is_Gamepad_Button_Down
      (Gamepad : C_Int; Button : Gamepad_Button) return Boolean is
      function C_Is_Gamepad_Button_Down 
         (Gamepad : C_Int; Button : Gamepad_Button) return C.C_bool
         with
            Import        => true,
            Convention    => C,
            External_Name => "IsGamepadButtonDown";

      Result : constant Boolean := 
         Boolean (C_Is_Gamepad_Button_Down (Gamepad, Button));
   begin
      return Result;
   end Is_Gamepad_Button_Down;

   -- Check if a gamepad button has been released once
   function Is_Gamepad_Button_Released 
      (Gamepad : C_Int; Button : Gamepad_Button) return Boolean is
      function C_Is_Gamepad_Button_Released 
         (Gamepad : C_Int; Button : Gamepad_Button) return C.C_bool
         with
            Import        => true,
            Convention    => C,
            External_Name => "IsGamepadButtonReleased";

      Result : constant Boolean := 
         Boolean (C_Is_Gamepad_Button_Released (Gamepad, Button));
   begin
      return Result;
   end Is_Gamepad_Button_Released;

   -- Check if a gamepad button is NOT being pressed
   function Is_Gamepad_Button_Up 
      (Gamepad : C_Int; Button : Gamepad_Button) return Boolean is
      function C_Is_Gamepad_Button_Up 
         (Gamepad : C_Int; Button : Gamepad_Button) return C.C_bool
         with
            Import        => true,
            Convention    => C,
            External_Name => "IsGamepadButtonUp";

      Result : constant Boolean := 
         Boolean (C_Is_Gamepad_Button_Up (Gamepad, Button));
   begin
      return Result;
   end Is_Gamepad_Button_Up;

   -- Set C_Internal gamepad mappings (SDL_GameControllerDB)
   function Set_Gamepad_Mappings (Mappings : String) return C_Int is
      function C_Set_Gamepad_Mappings 
         (Mappings : C.Strings.chars_ptr) return C_Int 
         with
            Import        => true,
            Convention    => C,
            External_Name => "SetGamepadMappings";

      C_Mappings : C.Strings.chars_ptr := C.Strings.New_String (Mappings);
      Result     : C_Int               := C_Set_Gamepad_Mappings (C_Mappings);
   begin
      C.Strings.Free (C_Mappings);
      return Result;
   end Set_Gamepad_Mappings;

   -- Input-related functions: mouse
   -- Check if a mouse button has been pressed once
   function Is_Mouse_Button_Pressed (Button : Mouse_Button) return Boolean is
      function C_Is_Mouse_Button_Pressed 
         (Button : Mouse_Button) return C.C_bool
         with
            Import        => true,
            Convention    => C,
            External_Name => "IsMouseButtonPressed";

      Result : constant Boolean := 
         Boolean (C_Is_Mouse_Button_Pressed (Button));
   begin
      return Result;
   end Is_Mouse_Button_Pressed;

   -- Check if a mouse button is being pressed
   function Is_Mouse_Button_Down (Button : Mouse_Button) return Boolean is
      function C_Is_Mouse_Button_Down (Button : Mouse_Button) return C.C_bool 
         with
            Import        => true,
            Convention    => C,
            External_Name => "IsMouseButtonDown";

      Result : constant Boolean := Boolean (C_Is_Mouse_Button_Down (Button));
   begin
      return Result;
   end Is_Mouse_Button_Down;

   -- Check if a mouse button has been released once
   function Is_Mouse_Button_Released (Button : Mouse_Button) return Boolean is
      function C_Is_Mouse_Button_Released 
         (Button : Mouse_Button) return C.C_bool 
         with
            Import        => true,
            Convention    => C,
            External_Name => "IsMouseButtonReleased";

      Result : constant Boolean := 
         Boolean (C_Is_Mouse_Button_Released (Button));
   begin
      return Result;
   end Is_Mouse_Button_Released;

   -- Check if a mouse button is NOT being pressed
   function Is_Mouse_Button_Up (Button : Mouse_Button) return Boolean is
      function C_Is_Mouse_Button_Up (Button : Mouse_Button) return C.C_bool 
         with
            Import        => true,
            Convention    => C,
            External_Name => "IsMouseButtonUp";

      Result : constant Boolean := Boolean (C_Is_Mouse_Button_Up (Button));
   begin
      return Result;
   end Is_Mouse_Button_Up;
end Raylib_Ada;
