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
		"rect" : [ 256.0, 523.0, 1125.0, 746.0 ],
		"default_fontsize" : 10.0,
		"default_fontname" : "Arial Bold",
		"gridsize" : [ 8.0, 8.0 ],
		"boxanimatetime" : 500,
		"boxes" : [ 			{
				"box" : 				{
					"id" : "obj-prepend-delay",
					"maxclass" : "newobj",
					"numinlets" : 1,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"patching_rect" : [ 303.0, 63.0, 80.0, 20.0 ],
					"text" : "prepend delay"
				}

			}
, 			{
				"box" : 				{
					"filename" : "bank_pc_controller_as1.js",
					"id" : "obj-v8",
					"maxclass" : "newobj",
					"numinlets" : 1,
					"numoutlets" : 3,
					"outlettype" : [ "", "", "" ],
					"patching_rect" : [ 87.0, 159.0, 148.0, 20.0 ],
					"saved_object_attributes" : 					{
						"parameter_enable" : 0
					}
,
					"text" : "v8 bank_pc_controller_as1.js",
					"textfile" : 					{
						"filename" : "bank_pc_controller_as1.js",
						"flags" : 0,
						"embed" : 0,
						"autowatch" : 1
					}

				}

			}
, 			{
				"box" : 				{
					"id" : "obj-midiin",
					"maxclass" : "newobj",
					"numinlets" : 1,
					"numoutlets" : 1,
					"outlettype" : [ "int" ],
					"patching_rect" : [ 15.0, 159.0, 42.0, 20.0 ],
					"text" : "midiin"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-midiout",
					"maxclass" : "newobj",
					"numinlets" : 1,
					"numoutlets" : 0,
					"patching_rect" : [ 15.0, 207.0, 50.0, 20.0 ],
					"text" : "midiout"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-prepend-bank",
					"maxclass" : "newobj",
					"numinlets" : 1,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"patching_rect" : [ 15.0, 63.0, 104.0, 20.0 ],
					"text" : "prepend bankindex"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-prepend-pc",
					"maxclass" : "newobj",
					"numinlets" : 1,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"patching_rect" : [ 127.0, 63.0, 72.0, 20.0 ],
					"text" : "prepend pc"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-route-ui",
					"maxclass" : "newobj",
					"numinlets" : 4,
					"numoutlets" : 4,
					"outlettype" : [ "", "", "", "" ],
					"patching_rect" : [ 87.0, 207.0, 190.0, 20.0 ],
					"text" : "route set_bankindex set_pc set_delay"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-route-status",
					"maxclass" : "newobj",
					"numinlets" : 3,
					"numoutlets" : 3,
					"outlettype" : [ "", "", "" ],
					"patching_rect" : [ 359.0, 207.0, 116.0, 20.0 ],
					"text" : "route Current: Send:"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-recv-bank",
					"maxclass" : "newobj",
					"numinlets" : 0,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"patching_rect" : [ 15.0, 15.0, 122.0, 20.0 ],
					"text" : "r ---ui-bankindex-action"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-recv-pc",
					"maxclass" : "newobj",
					"numinlets" : 0,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"patching_rect" : [ 127.0, 15.0, 92.0, 20.0 ],
					"text" : "r ---ui-pc-action"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-recv-delay",
					"maxclass" : "newobj",
					"numinlets" : 0,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"patching_rect" : [ 303.0, 15.0, 100.0, 20.0 ],
					"text" : "r ---ui-delay-action"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-recv-send",
					"maxclass" : "newobj",
					"numinlets" : 0,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"patching_rect" : [ 407.0, 15.0, 102.0, 20.0 ],
					"text" : "r ---ui-send-action"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-recv-dec",
					"maxclass" : "newobj",
					"numinlets" : 0,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"patching_rect" : [ 407.0, 55.0, 96.0, 20.0 ],
					"text" : "r ---ui-dec-action"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-recv-inc",
					"maxclass" : "newobj",
					"numinlets" : 0,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"patching_rect" : [ 407.0, 95.0, 94.0, 20.0 ],
					"text" : "r ---ui-inc-action"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-recv-restore",
					"maxclass" : "newobj",
					"numinlets" : 0,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"patching_rect" : [ 511.0, 95.0, 115.0, 20.0 ],
					"text" : "r ---ui-restore-action"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-send-bank-ui",
					"maxclass" : "newobj",
					"numinlets" : 1,
					"numoutlets" : 0,
					"patching_rect" : [ 87.0, 271.0, 89.0, 20.0 ],
					"text" : "s ---ui-bankindex"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-send-pc-ui",
					"maxclass" : "newobj",
					"numinlets" : 1,
					"numoutlets" : 0,
					"patching_rect" : [ 183.0, 271.0, 58.0, 20.0 ],
					"text" : "s ---ui-pc"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-send-delay-ui",
					"maxclass" : "newobj",
					"numinlets" : 1,
					"numoutlets" : 0,
					"patching_rect" : [ 335.0, 271.0, 72.0, 20.0 ],
					"text" : "s ---ui-delay"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-send-current-ui",
					"maxclass" : "newobj",
					"numinlets" : 1,
					"numoutlets" : 0,
					"patching_rect" : [ 359.0, 271.0, 86.0, 20.0 ],
					"text" : "s ---ui-current"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-send-send-values-ui",
					"maxclass" : "newobj",
					"numinlets" : 1,
					"numoutlets" : 0,
					"patching_rect" : [ 455.0, 271.0, 112.0, 20.0 ],
					"text" : "s ---ui-send-values"
				}

			}
 ],
		"lines" : [ 			{
				"patchline" : 				{
					"destination" : [ "obj-midiout", 0 ],
					"source" : [ "obj-midiin", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-v8", 0 ],
					"source" : [ "obj-prepend-bank", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-v8", 0 ],
					"source" : [ "obj-prepend-delay", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-v8", 0 ],
					"source" : [ "obj-prepend-pc", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-prepend-bank", 0 ],
					"source" : [ "obj-recv-bank", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-v8", 0 ],
					"source" : [ "obj-recv-dec", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-prepend-delay", 0 ],
					"source" : [ "obj-recv-delay", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-v8", 0 ],
					"source" : [ "obj-recv-inc", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-prepend-pc", 0 ],
					"source" : [ "obj-recv-pc", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-v8", 0 ],
					"source" : [ "obj-recv-restore", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-v8", 0 ],
					"source" : [ "obj-recv-send", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-send-current-ui", 0 ],
					"source" : [ "obj-route-status", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-send-send-values-ui", 0 ],
					"source" : [ "obj-route-status", 1 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-send-bank-ui", 0 ],
					"source" : [ "obj-route-ui", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-send-delay-ui", 0 ],
					"source" : [ "obj-route-ui", 2 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-send-pc-ui", 0 ],
					"source" : [ "obj-route-ui", 1 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-midiout", 0 ],
					"source" : [ "obj-v8", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-route-status", 0 ],
					"source" : [ "obj-v8", 2 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-route-ui", 0 ],
					"source" : [ "obj-v8", 1 ]
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
