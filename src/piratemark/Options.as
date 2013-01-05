// =================================================================================================
//
//	Starling Framework
//	Copyright 2012 Gamua OG. All Rights Reserved.
//
//	This program is free software. You can redistribute and/or modify it
//	in accordance with the terms of the accompanying license agreement.
//
// =================================================================================================

package piratemark
{
    import flash.system.System;
    
    import starling.display.BlendMode;
    import starling.display.Quad;
    import starling.display.Sprite;
    import starling.events.EnterFrameEvent;
    import starling.events.Event;
    import starling.text.BitmapFont;
    import starling.text.TextField;
    import starling.utils.HAlign;
    import starling.utils.VAlign;
    
    /** A small, lightweight box with PirateMark options */
    internal class Options extends Sprite
    {
        private var mBackground:Quad;
        private var mTextField:TextField;
        
        /** Creates a new Statistics Box. */
        public function Options()
        {
            mBackground = new Quad(70, 25, 0x0);
            mTextField = new TextField(68, 25, "", BitmapFont.MINI, BitmapFont.NATIVE_SIZE, 0xffffff);
            mTextField.x = 2;
            mTextField.hAlign = HAlign.LEFT;
            mTextField.vAlign = VAlign.TOP;
            
            addChild(mBackground);
            addChild(mTextField);
            
            updateText(0);
            blendMode = BlendMode.NONE;
        }
        
        public function updateText(numPirates:int):void
        {
            mTextField.text = "PIRATES: " + numPirates + 
                            "\nPRESS TO ADD MORE"; 
        }
    }
}