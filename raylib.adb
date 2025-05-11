with Interfaces.C;
with Interfaces.C.Strings;

package body Raylib is
    use Interfaces.C;
    use Interfaces.C.Strings;

   --//////////////////////////////////////////////////////////////////////////
   -- Window-related functions and procedures
   --//////////////////////////////////////////////////////////////////////////
   function Window_Should_Close return Boolean is
      function WindowShouldClose return C_bool
         with 
            Import        => true,
            Convention    => C,
            External_Name => "WindowShouldClose";
   
      Result : Boolean := Boolean (WindowShouldClose);
   begin
      return Result;
   end Window_Should_Close;

    -- Check if window has been initialized successfully
   function Is_Window_Ready return Boolean is
      function C_Is_Window_Ready return C_bool
         with 
            Import        => true,
            Convention    => C,
            External_Name => "IsWindowReady";
   
      Result : Boolean := Boolean (C_Is_Window_Ready);
   begin
      return Result;
   end Is_Window_Ready;

   -- Check if window is currently fullscreen
   function Is_Window_Fullscreen return Boolean is
      function C_Is_Window_Fullscreen return C_bool
         with 
            Import        => true,
            Convention    => C,
            External_Name => "IsWindowFullscreen";
   
      Result : Boolean := Boolean (C_Is_Window_Fullscreen);
   begin
      return Result;
   end Is_Window_Fullscreen;

   -- Check if window is currently hidden
   function Is_Window_Hidden return Boolean is
      function C_Is_Window_Hidden return C_bool
         with 
            Import        => true,
            Convention    => C,
            External_Name => "IsWindowHidden";
   
      Result : Boolean := Boolean (C_Is_Window_Hidden);
   begin
      return Result;
   end Is_Window_Hidden;

   -- Check if window is currently minimized
   function Is_Window_Minimized return Boolean is
      function C_Is_Window_Minimized return C_bool
         with 
            Import        => true,
            Convention    => C,
            External_Name => "IsWindowMinimized";
   
      Result : Boolean := Boolean (C_Is_Window_Minimized);
   begin
      return Result;
   end Is_Window_Minimized;

   -- Check if window is currently maximized
   function Is_Window_Maximized return Boolean is
      function C_Is_Window_Maximized return C_bool
         with 
            Import        => true,
            Convention    => C,
            External_Name => "IsWindowMaximized";
   
      Result : Boolean := Boolean (C_Is_Window_Maximized);
   begin
      return Result;
   end Is_Window_Maximized;

   -- Check if window is currently focused
   function Is_Window_Focused return Boolean is
      function C_Is_Window_Focused return C_bool
         with
            Import        => true,
            Convention    => C,
            External_Name => "IsWindowFocused";
   
      Result : Boolean := Boolean (C_Is_Window_Focused);
   begin
      return Result;
   end Is_Window_Focused;


   -- Check if window has been resized last frame
   function Is_Window_Resized return Boolean is
      function C_Is_Window_Resized return C_bool
         with 
            Import        => true,
            Convention    => C,
            External_Name => "IsWindowResized";
   
      Result : Boolean := Boolean (C_Is_Window_Resized);
   begin
      return Result;
   end Is_Window_Resized;

   -- Check if one specific window flag is enabled
   function Is_Window_State (Flag : unsigned) return Boolean is
      function C_Is_Window_State (Flag : unsigned) return C_bool
         with
            Import        => true,
            Convention    => C,
            External_Name => "IsWindowState";
   
      Result : Boolean := Boolean (C_Is_Window_State (Flag));
   begin
      return Result;
   end Is_Window_State;

   --//////////////////////////////////////////////////////////////////////////
   -- Shader management functions and procedures
   -- NOTE: Shader functionality is not available on OpenGL 1.1
   --//////////////////////////////////////////////////////////////////////////
   function Is_Shader_Valid (Shadr : Shader) return Boolean is
      function C_Is_Shader_Valid (Shadr : Shader) return C_bool
         with 
            Import        => true,
            Convention    => C,
            External_Name => "IsShaderValid";
   
      Result : Boolean := Boolean (C_Is_Shader_Valid (Shadr));
   begin
      return Result;
   end Is_Shader_Valid;

   package body Textures is
        --/////////////////////////////////////////////////////////////////////////////
        -- Image loading functions
        -- NOTE: These functions do not require GPU access
        --/////////////////////////////////////////////////////////////////////////////
        -- Load image from file into CPU memory (RAM)
        function Load_Image (File_Name : String) return Image 
        is
            function LoadImage (File_Name : chars_ptr) return Image
                with
                    Import        => true,
                    Convention    => C,
                    External_Name => "LoadImage";

            C_File_Name : chars_ptr := New_String (File_Name);
            Img         : Image     := LoadImage (C_File_Name);
        begin
            Free (C_File_Name);
            return Img;
        end Load_Image;
    
        -- Load image from RAW file data
        function Load_Image_Raw (File_Name : String; Width, Height, Format, Header_Size : int) return Image 
        is
            function LoadImageRaw (File_Name : chars_ptr; Width, Height, Format, Header_Size : int) return Image
                with
                    Import        => true,
                    Convention    => C,
                    External_Name => "LoadImageRaw";
            
            C_File_Name : chars_ptr := New_String (File_Name);
            Img         : Image     := LoadImageRaw (C_File_Name, Width, Height, Format, Header_Size);
        begin
            Free (C_File_Name);
            return Img;
        end Load_Image_Raw;
        
        -- Load image sequence from file (frames appended to image.data)
        function Load_Image_Anim (File_Name : String; Frames : access int) return Image is
            function LoadImageAnim (File_Name : chars_ptr; Frames : access int) return Image
                with
                    Import        => true,
                    Convention    => C,
                    External_Name => "LoadImageAnim";
            
            C_File_Name : chars_ptr := New_String (File_Name);
            Img         : Image     := LoadImageAnim (C_File_Name, Frames);
        begin
            Free (C_File_Name);
            return Img;
        end Load_Image_Anim;

        -- Load image sequence from memory buffer        
        function Load_Image_Anim_From_Memory 
            (File_Type : String; 
             File_Data : access unsigned_char; 
             Data_Size : int; 
             Frames : access int) return Image is
            function LoadImageAnimFromMemory 
                (File_Type : chars_ptr; 
                 File_Data : access unsigned_char; 
                 Data_Size : int; 
                 Frames : access int) return Image
                with
                    Import        => true,
                    Convention    => C,
                    External_Name => "LoadImageAnimFromMemory";
   
            C_File_Type : chars_ptr := New_String (File_Type);
            Img         : Image     := LoadImageAnimFromMemory (C_File_Type, File_Data, Data_Size, Frames);
        begin
            Free (C_File_Type);
            return Img;
        end Load_Image_Anim_From_Memory;

        -- Load image from memory buffer, fileType refers to extension: i.e. '.png'
        function Load_Image_From_Memory (File_Type : String; File_Data : access unsigned_char; Data_Size : int) return Image is
            function LoadImageFromMemory (File_Type : chars_ptr; File_Data : access unsigned_char; Data_Size : int) return Image 
                with 
                    Import        => true,
                    Convention    => C,
                    External_Name => "LoadImageFromMemory";

            C_File_Type : chars_ptr := New_String (File_Type);
            Img         : Image     := LoadImageFromMemory (C_File_Type, File_Data, Data_Size);
        begin
            Free (C_File_Type);
            return Img;
        end Load_Image_From_Memory;

        -- Check if an image is valid (data and parameters)
        function Is_Image_Valid (Img : Image) return Boolean is
            function IsImageValid (Img : Image) return C_bool
                with 
                    Import        => true,
                    Convention    => C,
                    External_Name => "IsImageValid";

            Result : Boolean := Boolean (IsImageValid (Img));
        begin
            return Result;
        end Is_Image_Valid;

        -- Export image data to file, returns true on success
        function Export_Image (Img : Image; File_Name : String) return Boolean is
            function ExportImage (Img : Image; File_Name : chars_ptr) return C_Bool
                with 
                    Import        => true,
                    Convention    => C,
                    External_Name => "ExportImage";
            
            C_File_Name : chars_ptr := New_String (File_Name);
            Result      : Boolean   := Boolean (ExportImage (Img, C_File_Name));
        begin
            Free (C_File_Name);
            return Result;
        end Export_Image;

        -- Export image to memory buffer
        function Export_Image_To_Memory (Img : Image; File_Type : String; File_Size : access int) return access unsigned_char is
            function ExportImageToMemory (Img : Image; File_Type : chars_ptr; File_Size : access int) return access unsigned_char
                with
                    Import        => true,
                    Convention    => C,
                    External_Name => "ExportImageToMemory";

            C_File_Type : chars_ptr            := New_String (File_Type);
            Result      : access unsigned_char := ExportImageToMemory (Img, C_File_Type, File_Size);
        begin
            Free (C_File_Type);
            return Result;
        end Export_Image_To_Memory;

        -- Export image as code file defining an array of bytes, returns true on success
        function Export_Image_As_Code (Img : Image; File_Name : String) return Boolean is
            function ExportImageAsCode (Img : Image; File_Name : chars_ptr) return C_bool
                with
                    Import        => true,
                    Convention    => C,
                    External_Name => "ExportImageAsCode";

            C_File_Name : chars_ptr := New_String (File_Name);
            Result      : Boolean   := Boolean (ExportImageAsCode (Img, C_File_Name));
        begin
            Free (C_File_Name);
            return Result;
        end Export_Image_As_Code;
    end Textures;
end Raylib;
