{
	"patcher" : 	{
		"fileversion" : 1,
		"appversion" : 		{
			"major" : 9,
			"minor" : 0,
			"revision" : 9,
			"architecture" : "x64",
			"modernui" : 1
		}
,
		"classnamespace" : "box",
		"rect" : [ 594.0, 512.0, 787.0, 718.0 ],
		"openrect" : [ 0.0, 0.0, 0.0, 159.0 ],
		"openinpresentation" : 1,
		"default_fontsize" : 10.0,
		"default_fontname" : "Arial Bold",
		"gridsize" : [ 8.0, 8.0 ],
		"boxanimatetime" : 500,
		"boxes" : [ 			{
				"box" : 				{
					"id" : "obj-4",
					"maxclass" : "newobj",
					"numinlets" : 0,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"patching_rect" : [ 431.5, 236.0, 128.0, 20.0 ],
					"text" : "r ---parent-restore-trigger"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-5",
					"maxclass" : "message",
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"patching_rect" : [ 282.0, 556.0, 29.5, 20.0 ],
					"text" : "dec"
				}

			}
, 			{
				"box" : 				{
					"fontsize" : 20.0,
					"id" : "obj-2",
					"maxclass" : "live.text",
					"mode" : 0,
					"numinlets" : 1,
					"numoutlets" : 2,
					"outlettype" : [ "", "" ],
					"parameter_enable" : 1,
					"patching_rect" : [ 282.0, 511.0, 101.0, 32.0 ],
					"presentation" : 1,
					"presentation_rect" : [ 44.0, 74.0, 62.0, 30.0 ],
					"saved_attribute_attributes" : 					{
						"valueof" : 						{
							"parameter_enum" : [ "val1", "val2" ],
							"parameter_longname" : "Decrease",
							"parameter_mmax" : 1,
							"parameter_modmode" : 0,
							"parameter_shortname" : "Dec",
							"parameter_type" : 2
						}

					}
,
					"text" : "-",
					"varname" : "decrease"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-3",
					"maxclass" : "message",
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"patching_rect" : [ 231.0, 406.0, 29.5, 20.0 ],
					"text" : "inc"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-bank",
					"maxclass" : "live.tab",
					"num_lines_patching" : 1,
					"num_lines_presentation" : 5,
					"numinlets" : 1,
					"numoutlets" : 3,
					"outlettype" : [ "", "", "float" ],
					"parameter_enable" : 1,
					"patching_rect" : [ 80.0, 105.0, 180.0, 18.0 ],
					"presentation" : 1,
					"presentation_rect" : [ 2.0, 39.0, 40.0, 101.0 ],
					"saved_attribute_attributes" : 					{
						"valueof" : 						{
							"parameter_enum" : [ "U1", "F1", "U2", "F2", "U3", "F3", "U4", "F4", "U5", "F5" ],
							"parameter_longname" : "Bank",
							"parameter_mmax" : 9,
							"parameter_modmode" : 0,
							"parameter_shortname" : "Bank",
							"parameter_type" : 2,
							"parameter_unitstyle" : 9
						}

					}
,
					"varname" : "bank_selector"
				}

			}
, 			{
				"box" : 				{
					"fontsize" : 18.0,
					"id" : "obj-pc",
					"maxclass" : "live.numbox",
					"numinlets" : 1,
					"numoutlets" : 2,
					"outlettype" : [ "", "float" ],
					"parameter_enable" : 1,
					"patching_rect" : [ 80.0, 237.0, 83.0, 25.0 ],
					"presentation" : 1,
					"presentation_rect" : [ 2.0, 6.0, 106.0, 25.0 ],
					"saved_attribute_attributes" : 					{
						"valueof" : 						{
							"parameter_longname" : "Program",
							"parameter_mmax" : 99.0,
							"parameter_mmin" : 1.0,
							"parameter_modmode" : 0,
							"parameter_shortname" : "Program",
							"parameter_type" : 0,
							"parameter_unitstyle" : 0
						}

					}
,
					"varname" : "program_input"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-send-ui",
					"maxclass" : "message",
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"patching_rect" : [ 194.0, 251.0, 45.0, 20.0 ],
					"text" : "send"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-current-label",
					"maxclass" : "comment",
					"numinlets" : 1,
					"numoutlets" : 0,
					"patching_rect" : [ 32.0, 238.0, 55.0, 18.0 ],
					"text" : "Current"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-send-label",
					"maxclass" : "comment",
					"numinlets" : 1,
					"numoutlets" : 0,
					"patching_rect" : [ 572.0, 257.0, 42.0, 18.0 ],
					"text" : "Send"
				}

			}
, 			{
				"box" : 				{
					"fontsize" : 9.5,
					"id" : "obj-delay-label",
					"maxclass" : "comment",
					"numinlets" : 1,
					"numoutlets" : 0,
					"patching_rect" : [ 360.0, 40.0, 34.0, 17.0 ],
					"presentation" : 1,
					"presentation_rect" : [ 44.0, 108.0, 34.0, 17.0 ],
					"text" : "Delay"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-current-display",
					"maxclass" : "message",
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"patching_rect" : [ 520.0, 224.0, 235.0, 20.0 ],
					"text" : "Current: U1 / PC 1"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-send-display",
					"maxclass" : "message",
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"patching_rect" : [ 620.0, 256.0, 180.0, 20.0 ],
					"text" : "Send: CC#32=0 / PC=0"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-delay",
					"maxclass" : "live.menu",
					"numinlets" : 1,
					"numoutlets" : 3,
					"outlettype" : [ "", "", "float" ],
					"parameter_enable" : 1,
					"patching_rect" : [ 402.0, 41.0, 72.0, 15.0 ],
					"presentation" : 1,
					"presentation_rect" : [ 46.0, 124.0, 60.0, 15.0 ],
					"saved_attribute_attributes" : 					{
						"valueof" : 						{
							"parameter_enum" : [ "0 ms", "5 ms", "10 ms" ],
							"parameter_longname" : "Delay",
							"parameter_mmax" : 2,
							"parameter_modmode" : 0,
							"parameter_shortname" : "Delay",
							"parameter_type" : 2,
							"parameter_unitstyle" : 9
						}

					}
,
					"varname" : "delay_menu"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-restore-begin-msg",
					"maxclass" : "message",
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"patching_rect" : [ 559.5, 236.0, 76.0, 20.0 ],
					"text" : "restorebegin"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-delay-init",
					"maxclass" : "message",
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"patching_rect" : [ 431.5, 298.0, 68.0, 20.0 ],
					"text" : "outputvalue"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-restore-delay",
					"maxclass" : "newobj",
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "bang" ],
					"patching_rect" : [ 431.5, 266.0, 50.0, 20.0 ],
					"text" : "delay 50"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-restore-delay-late",
					"maxclass" : "newobj",
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "bang" ],
					"patching_rect" : [ 495.5, 266.0, 58.0, 20.0 ],
					"text" : "delay 200"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-restore-end",
					"maxclass" : "newobj",
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "bang" ],
					"patching_rect" : [ 559.5, 266.0, 58.0, 20.0 ],
					"text" : "delay 260"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-restore-end-msg",
					"maxclass" : "message",
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"patching_rect" : [ 559.5, 298.0, 68.0, 20.0 ],
					"text" : "restoreend"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-send-restore",
					"maxclass" : "newobj",
					"numinlets" : 1,
					"numoutlets" : 0,
					"patching_rect" : [ 559.5, 330.0, 109.0, 20.0 ],
					"text" : "s ---ui-restore-action"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-send-bank",
					"maxclass" : "newobj",
					"numinlets" : 1,
					"numoutlets" : 0,
					"patching_rect" : [ 80.0, 137.0, 121.0, 20.0 ],
					"text" : "s ---ui-bankindex-action"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-recv-bank",
					"maxclass" : "newobj",
					"numinlets" : 0,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"patching_rect" : [ 520.0, 40.0, 90.0, 20.0 ],
					"text" : "r ---ui-bankindex"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-set-bank",
					"maxclass" : "newobj",
					"numinlets" : 1,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"patching_rect" : [ 520.0, 72.0, 70.0, 20.0 ],
					"text" : "prepend set"
				}

			}
, 			{
				"box" : 				{
					"activebgcolor" : [ 1.0, 0.568627450980392, 0.764705882352941, 1.0 ],
					"activebgoncolor" : [ 0.094117647058824, 0.098039215686275, 0.117647058823529, 1.0 ],
					"activetextcolor" : [ 0.015686274509804, 0.019607843137255, 0.023529411764706, 1.0 ],
					"activetextoncolor" : [ 0.490196078431373, 0.501960784313725, 0.533333333333333, 1.0 ],
					"id" : "obj-clockmode",
					"maxclass" : "live.text",
					"numinlets" : 1,
					"numoutlets" : 2,
					"outlettype" : [ "", "" ],
					"parameter_enable" : 1,
					"patching_rect" : [ 80.0, 330.0, 104.0, 20.0 ],
					"presentation" : 1,
					"presentation_rect" : [ 2.0, 144.0, 106.0, 20.0 ],
					"saved_attribute_attributes" : 					{
						"activebgcolor" : 						{
							"expression" : "themecolor.live_control_selection"
						}
,
						"activebgoncolor" : 						{
							"expression" : "themecolor.live_control_bg"
						}
,
						"activetextcolor" : 						{
							"expression" : "themecolor.live_control_fg_on"
						}
,
						"activetextoncolor" : 						{
							"expression" : "themecolor.live_control_text_zombie"
						}
,
						"valueof" : 						{
							"parameter_enum" : [ "val1", "val2" ],
							"parameter_longname" : "Sequencer Play",
							"parameter_mmax" : 1,
							"parameter_modmode" : 0,
							"parameter_shortname" : "SEQ Play",
							"parameter_type" : 2
						}

					}
,
					"text" : "SEQ SYNC",
					"texton" : "SEQ MANUAL",
					"varname" : "midi_clock_mode"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-send-clockmode",
					"maxclass" : "newobj",
					"numinlets" : 1,
					"numoutlets" : 0,
					"patching_rect" : [ 200.0, 330.0, 126.0, 20.0 ],
					"text" : "s ---ui-clockmode-action"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-recv-clockmode",
					"maxclass" : "newobj",
					"numinlets" : 0,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"patching_rect" : [ 800.0, 136.0, 99.0, 20.0 ],
					"text" : "r ---ui-clockmode"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-set-clockmode",
					"maxclass" : "newobj",
					"numinlets" : 1,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"patching_rect" : [ 800.0, 168.0, 70.0, 20.0 ],
					"text" : "prepend set"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-send-pc",
					"maxclass" : "newobj",
					"numinlets" : 1,
					"numoutlets" : 0,
					"patching_rect" : [ 80.0, 288.0, 83.0, 20.0 ],
					"text" : "s ---ui-pc-action"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-recv-pc",
					"maxclass" : "newobj",
					"numinlets" : 0,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"patching_rect" : [ 620.0, 40.0, 64.0, 20.0 ],
					"text" : "r ---ui-pc"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-set-pc",
					"maxclass" : "newobj",
					"numinlets" : 1,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"patching_rect" : [ 620.0, 72.0, 70.0, 20.0 ],
					"text" : "prepend set"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-send-dec",
					"maxclass" : "newobj",
					"numinlets" : 1,
					"numoutlets" : 0,
					"patching_rect" : [ 282.0, 582.0, 89.0, 20.0 ],
					"text" : "s ---ui-dec-action"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-send-inc",
					"maxclass" : "newobj",
					"numinlets" : 1,
					"numoutlets" : 0,
					"patching_rect" : [ 231.0, 437.0, 86.0, 20.0 ],
					"text" : "s ---ui-inc-action"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-send-trigger",
					"maxclass" : "newobj",
					"numinlets" : 1,
					"numoutlets" : 0,
					"patching_rect" : [ 194.0, 288.0, 95.0, 20.0 ],
					"text" : "s ---ui-send-action"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-send-delay",
					"maxclass" : "newobj",
					"numinlets" : 1,
					"numoutlets" : 0,
					"patching_rect" : [ 402.0, 320.0, 97.0, 20.0 ],
					"text" : "s ---ui-delay-action"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-delay-send-select",
					"maxclass" : "newobj",
					"numinlets" : 4,
					"numoutlets" : 4,
					"outlettype" : [ "bang", "bang", "bang", "" ],
					"patching_rect" : [ 402.0, 352.0, 70.0, 20.0 ],
					"text" : "sel 0 1 2"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-delay-value0",
					"maxclass" : "message",
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"patching_rect" : [ 402.0, 384.0, 28.0, 20.0 ],
					"text" : "0"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-delay-value5",
					"maxclass" : "message",
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"patching_rect" : [ 438.0, 384.0, 28.0, 20.0 ],
					"text" : "5"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-delay-value10",
					"maxclass" : "message",
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"patching_rect" : [ 474.0, 384.0, 34.0, 20.0 ],
					"text" : "10"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-recv-delay",
					"maxclass" : "newobj",
					"numinlets" : 0,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"patching_rect" : [ 800.0, 40.0, 82.0, 20.0 ],
					"text" : "r ---ui-delay"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-set-delay",
					"maxclass" : "newobj",
					"numinlets" : 4,
					"numoutlets" : 4,
					"outlettype" : [ "bang", "bang", "bang", "" ],
					"patching_rect" : [ 800.0, 72.0, 74.0, 20.0 ],
					"text" : "sel 0 5 10"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-set-delay-index0",
					"maxclass" : "message",
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"patching_rect" : [ 800.0, 104.0, 42.0, 20.0 ],
					"text" : "set 0"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-set-delay-index1",
					"maxclass" : "message",
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"patching_rect" : [ 848.0, 104.0, 42.0, 20.0 ],
					"text" : "set 1"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-set-delay-index2",
					"maxclass" : "message",
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"patching_rect" : [ 896.0, 104.0, 42.0, 20.0 ],
					"text" : "set 2"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-recv-current",
					"maxclass" : "newobj",
					"numinlets" : 0,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"patching_rect" : [ 520.0, 136.0, 88.0, 20.0 ],
					"text" : "r ---ui-current"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-set-current",
					"maxclass" : "newobj",
					"numinlets" : 1,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"patching_rect" : [ 520.0, 168.0, 70.0, 20.0 ],
					"text" : "prepend set"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-recv-send-values",
					"maxclass" : "newobj",
					"numinlets" : 0,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"patching_rect" : [ 620.0, 136.0, 114.0, 20.0 ],
					"text" : "r ---ui-send-values"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-set-send-values",
					"maxclass" : "newobj",
					"numinlets" : 1,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"patching_rect" : [ 620.0, 168.0, 70.0, 20.0 ],
					"text" : "prepend set"
				}

			}
, 			{
				"box" : 				{
					"fontsize" : 20.0,
					"id" : "obj-1",
					"maxclass" : "live.text",
					"mode" : 0,
					"numinlets" : 1,
					"numoutlets" : 2,
					"outlettype" : [ "", "" ],
					"parameter_enable" : 1,
					"patching_rect" : [ 231.0, 366.0, 93.0, 32.0 ],
					"presentation" : 1,
					"presentation_rect" : [ 44.0, 39.0, 62.0, 30.0 ],
					"saved_attribute_attributes" : 					{
						"valueof" : 						{
							"parameter_enum" : [ "val1", "val2" ],
							"parameter_longname" : "Increase",
							"parameter_mmax" : 1,
							"parameter_modmode" : 0,
							"parameter_shortname" : "Inc",
							"parameter_type" : 2
						}

					}
,
					"text" : "+",
					"varname" : "increase"
				}

			}
 ],
		"lines" : [ 			{
				"patchline" : 				{
					"destination" : [ "obj-3", 0 ],
					"source" : [ "obj-1", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-5", 0 ],
					"source" : [ "obj-2", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-send-inc", 0 ],
					"source" : [ "obj-3", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-restore-begin-msg", 0 ],
					"order" : 1,
					"source" : [ "obj-4", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-restore-delay", 0 ],
					"order" : 3,
					"source" : [ "obj-4", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-restore-delay-late", 0 ],
					"order" : 2,
					"source" : [ "obj-4", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-restore-end", 0 ],
					"order" : 0,
					"source" : [ "obj-4", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-send-dec", 0 ],
					"source" : [ "obj-5", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-send-bank", 0 ],
					"source" : [ "obj-bank", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-send-clockmode", 0 ],
					"source" : [ "obj-clockmode", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-delay-send-select", 0 ],
					"source" : [ "obj-delay", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-bank", 0 ],
					"order" : 3,
					"source" : [ "obj-delay-init", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-clockmode", 0 ],
					"order" : 1,
					"source" : [ "obj-delay-init", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-delay", 0 ],
					"order" : 0,
					"source" : [ "obj-delay-init", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-pc", 0 ],
					"order" : 2,
					"source" : [ "obj-delay-init", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-delay-value0", 0 ],
					"source" : [ "obj-delay-send-select", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-delay-value10", 0 ],
					"source" : [ "obj-delay-send-select", 2 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-delay-value5", 0 ],
					"source" : [ "obj-delay-send-select", 1 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-send-delay", 0 ],
					"source" : [ "obj-delay-value0", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-send-delay", 0 ],
					"source" : [ "obj-delay-value10", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-send-delay", 0 ],
					"source" : [ "obj-delay-value5", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-send-pc", 0 ],
					"source" : [ "obj-pc", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-set-bank", 0 ],
					"source" : [ "obj-recv-bank", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-set-clockmode", 0 ],
					"source" : [ "obj-recv-clockmode", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-set-current", 0 ],
					"source" : [ "obj-recv-current", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-set-delay", 0 ],
					"source" : [ "obj-recv-delay", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-set-pc", 0 ],
					"source" : [ "obj-recv-pc", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-set-send-values", 0 ],
					"source" : [ "obj-recv-send-values", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-send-restore", 0 ],
					"source" : [ "obj-restore-begin-msg", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-delay-init", 0 ],
					"source" : [ "obj-restore-delay", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-delay-init", 0 ],
					"source" : [ "obj-restore-delay-late", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-restore-end-msg", 0 ],
					"source" : [ "obj-restore-end", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-send-restore", 0 ],
					"source" : [ "obj-restore-end-msg", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-send-trigger", 0 ],
					"source" : [ "obj-send-ui", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-bank", 0 ],
					"source" : [ "obj-set-bank", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-clockmode", 0 ],
					"source" : [ "obj-set-clockmode", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-current-display", 0 ],
					"source" : [ "obj-set-current", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-set-delay-index0", 0 ],
					"source" : [ "obj-set-delay", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-set-delay-index1", 0 ],
					"source" : [ "obj-set-delay", 1 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-set-delay-index2", 0 ],
					"source" : [ "obj-set-delay", 2 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-delay", 0 ],
					"source" : [ "obj-set-delay-index0", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-delay", 0 ],
					"source" : [ "obj-set-delay-index1", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-delay", 0 ],
					"source" : [ "obj-set-delay-index2", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-pc", 0 ],
					"source" : [ "obj-set-pc", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-send-display", 0 ],
					"source" : [ "obj-set-send-values", 0 ]
				}

			}
 ],
		"saved_attribute_attributes" : 		{
			"default_plcolor" : 			{
				"expression" : ""
			}

		}

	}

}
