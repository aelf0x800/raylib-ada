with Interfaces.C;
with Interfaces.C.Strings;

package body Raylib is
    use Interfaces.C;
    use Interfaces.C.Strings;

    -- TODO : rework this maybe
    package body Window is
        procedure Init (Width, Height : int; Title : String) is
            procedure InitWindow (Width, Height : int; Title : chars_ptr)
                with Import        => true,
                     Convention    => C,
                     External_Name => "InitWindow";
            
            C_Title : chars_ptr := New_String (Title);
        begin
            InitWindow (Width, Height, C_Title);
            Free (C_Title);
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
    end Window;

    package body Textures is
        --/////////////////////////////////////////////////////////////////////////////
        -- Image loading functions
        -- NOTE: These functions do not require GPU access
        --/////////////////////////////////////////////////////////////////////////////
        -- Load image from file into CPU memory (RAM)
        function Load_Image (File_Name : String) return Image is
            function LoadImage (File_Name : chars_ptr) return Image
                with Import        => true,
                     Convention    => C,
                     External_Name => "LoadImage";

            C_File_Name : chars_ptr := New_String (File_Name);
            Img         : Image     := LoadImage (C_File_Name);
        begin
            Free (C_File_Name);
            return Img;
        end Load_Image;
    
        -- Load image from RAW file data
        function Load_Image_Raw (File_Name : String; Width, Height, Format, Header_Size : int) return Image;
            function LoadImageRaw (File_Name : chars_ptr; Width, Height, Format, Header_Size : int) return Image;
                with Import        => true,
                     Convention    => C,
                     External_Name => "LoadImageRaw";
            
            C_File_Name : chars_ptr := New_String (File_Name);
            Img         : Image     := LoadImageRaw (C_File_Name, Width, Height, Format, Header_Size);
        begin
            Free (C_File_Name);
            return Img;
        end Load_Image_Anim;
        
        -- Load image sequence from file (frames appended to image.data)
        function Load_Image_Anim (File_Name : String; Frames : access int) return Image is
            function LoadImageAnim (File_Name : chars_ptr; Frames : access int) return Image
                with Import        => true,
                     Convention    => C,
                     External_Name => "LoadImageAnim";
            
            C_File_Name : chars_ptr := New_String (File_Name);
            Img         : Image     := LoadImageAnim (C_File_Name, Frames);
        begin
            Free (C_File_Name);
            return Img;
        end Load_Image_Anim;
        
        -- TODO : function Load_Image_Anim_From_Memory (const char *fileType, const unsigned char *fileData, int dataSize, int *frames); // Load image sequence from memory buffer
        -- TODO : function Load_Image_From_Memory (File_Type : String; const unsigned char *fileData, int dataSize);      // Load image from memory buffer, fileType refers to extension: i.e. '.png'
    end Textures;
end Raylib;
