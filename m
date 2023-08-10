Return-Path: <netdev+bounces-26438-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 26772777C3C
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 17:33:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E4F441C20DD9
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 15:33:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 759B820C98;
	Thu, 10 Aug 2023 15:33:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68E76200BC
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 15:33:20 +0000 (UTC)
Received: from AUS01-SY4-obe.outbound.protection.outlook.com (mail-sy4aus01olkn2173.outbound.protection.outlook.com [40.92.62.173])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13E4E2690
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 08:33:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XtUnQ43DO9NiFebakhLcuoUweQHm0ja+88fKlx9sLyJXl7hw9m4Oyo6xx5DI4sffbOOn5X5QeEyXF7NtD4fPmXjIyipRL/1tBkJPLtquH2SH8k234iWxYEbNeyIHimyvFgrsqBksmfe9CSw70vEALLPxhAzyr6k01O2IBdxLWixZBC+Q3qZhR/1f3pu04g4gb0s/L6kk7mEhIKO/PmjAYqgroP1x+RG51m8gd/fo19GndnST5awzyj0hqnAYUhbMO1rI0uITz/QNI3X4TLPTLVC053V/VYNQWl52F/+zW3rymAa/+b7Mt01RBAhS9ZCoDe6iBl0kaYD07nQl6twCFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=At72umnLN6LEVS/NNv4gzuvyAUghRMLezp/gyVsaaao=;
 b=f4265X2ufWWz+9oKSSS5ChznMdXqutyugdmnL8Gm8B7NlMwT7/LjrjMoVqxNAivwky9W0az2Y0VQHbfqktzoU5UZARBdd/CvDij52CtVUHe9dGU2T1c2QcB3Akpj3mb9ioi0Sn5Wdj88qyNbRXVvgmTJ2S1bLXJVyCr1ZBHE6CurlrW3N6XewNcXVKPE42mIdhncHfk2mDXDhMM00VN9MVTNkaz+1OcjHy7+vdo+TQ0beIhf/hf3yzDJQwdJHQ4DiaW/88c4go423iIpwC2Tjl1YRUQ7brrCUMTdLBmoHuC/Rl8Eeg/jQfzbP5IciFQRS3+eun+ab8rSjDLCTCRu3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=At72umnLN6LEVS/NNv4gzuvyAUghRMLezp/gyVsaaao=;
 b=i4xCtNGdb4zcoIlKoFKk6Q9KDmuQo6I8s0VOuXKqRIO6agZv1n0L50s+xvfzYGNwpjkpObXtgrLC9rS4cqHeAeFaxFzPTY3E52qocfzzw2g+T+969+E2ywMEhAlXEXfi0iI7HW/EN6jKvF67ztcp45zXWCr50zUZAb81lJSFbE5t2qZdOljtK+8M2w8b4+UJtSqqR+d8DOcAfYa3dUK+Fc6vI2cotjJYxGK7L9pr6qcSC6LVeFWclcLPRQMeBVclRq7o0zKf+62dp/fFL7h030IbXI80rnrU1nZJ4e/a6QRtDU7paTY9otUZj7r3k0AsqbQkLMunLPGCRV3bSaOYUw==
Received: from MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM (2603:10c6:220:14c::12)
 by SY4P282MB2586.AUSP282.PROD.OUTLOOK.COM (2603:10c6:10:126::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30; Thu, 10 Aug
 2023 15:33:12 +0000
Received: from MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM
 ([fe80::826:d9a5:23be:3b14]) by MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM
 ([fe80::826:d9a5:23be:3b14%3]) with mapi id 15.20.6652.029; Thu, 10 Aug 2023
 15:33:12 +0000
From: Jinjian Song <songjinjian@hotmail.com>
To: jiri@resnulli.us
Cc: chandrashekar.devegowda@intel.com,
	chiranjeevi.rapolu@linux.intel.com,
	danielwinkler@google.com,
	davem@davemloft.net,
	edumazet@google.com,
	haijun.liu@mediatek.com,
	ilpo.jarvinen@linux.intel.com,
	jesse.brandeburg@intel.com,
	jinjian.song@fibocom.com,
	johannes@sipsolutions.net,
	kuba@kernel.org,
	linuxwwan@intel.com,
	linuxwwan_5g@intel.com,
	loic.poulain@linaro.org,
	m.chetan.kumar@linux.intel.com,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	ricardo.martinez@linux.intel.com,
	ryazanov.s.a@gmail.com,
	songjinjian@hotmail.com,
	soumya.prakash.mishra@intel.com,
	vsankar@lenovo.com
Subject: Re: [net-next 3/6] net: wwan: t7xx: Implements devlink ops of firmware flashing
Date: Thu, 10 Aug 2023 23:32:52 +0800
Message-ID:
 <MEYP282MB2697C334D0476215C8167B13BB13A@MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <MEYP282MB2697E81E8FEC49757A385A5FBB0CA@MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM>
References: <20230803021812.6126-1-songjinjian@hotmail.com> <MEYP282MB2697937841838C688E1237FDBB08A@MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM> <MEYP282MB269742CBB438E43607FA3BC4BB0EA@MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM> <MEYP282MB2697E81E8FEC49757A385A5FBB0CA@MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net
Content-Transfer-Encoding: 8bit
X-TMN: [sTyFxwKBuTiPTG65kQev4Nh0hrNQnBda]
X-ClientProxiedBy: SG3P274CA0012.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::24)
 To MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM (2603:10c6:220:14c::12)
X-Microsoft-Original-Message-ID: <ZNDrQpikNYBTgb60@nanopsycho>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MEYP282MB2697:EE_|SY4P282MB2586:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d2d4258-5965-4c65-4193-08db99b71b42
X-MS-Exchange-SLBlob-MailProps:
	7J/vb0KDx3g95xIFleXDt9v7AebcisefnrN7ypRBwvmDNkNeYX2T3UWOnDHKlmd9LkdkGmGa0SFoqnCARAycUEIjMGXE6b7I/5yuev1riLHhUZORCKXsL+mQzpajn0eUInBt/Fdv/idUiC2qwWLWL0x+1ONmlohx+NwcdYySTJaSbeWo6rQijd+fbjbTTf2X6vBCFH92FCD9JETzOcyF3wq44u/Re6RHwdyikb7oChmb8KPp7KvRVPmeVhnSqWszspZfQDYSYnz2zh8re+/ixFYRr+5q/1dpFr24B/yts9NqubAtCcmNibw9z2qEDc1PJwQjrSKSlwK32LwpPJ7w9EOvmsMcWbyi7xBuBB/EtOY+FHOZDO7S7L7plHsdsyVJAJtV+KXYhgFziNt6EMrD6vapXKC82AxUjUSqWVrcq5Jjb+4vhXfpe+dz9Bz5Xg7cVVvgbOsBiRiaI6TwNjG8Be2vIBXJtAEJAU645MKa1RYv4gdNeaFgo5DSAYG3i1AWmzglhszQp7EuoPEGS+Y2I0w2aqJ1tbzELCzYiAJ9dcj2MejsnoZhCeQp76hH18BbiidDWOlEGRfpkfUpSi53KbvrsQaNFFr3S+MEIPWhUIuKd27bzA6AI9eeqei4F5p4QyxvBJDVJyKLnUHy/revgf5pkV7RM+seFwrqrncoKQYWjAs/KL9ILQQLOx+8deCYwuolFDkwxO7XGNRR/RI4Jju9OSYOHfK0ySJODzKDwY/xT8OchOgIzWgHsiD3tBXLsoMMNcop/S7csMXlQgDxRBlFrspLUPUI2ww5Z0tAXbM=
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	hbKz6lbg/dJ/z4jSqmsmCUcoRIYfqNh38ZQdBJUnT0PWIABL8oLnlW4c9h7jC1lhDN0X1xDXBz9AdTXBj+tNY0nKk+hFBVEOEu0SLdI6zi+klm6L/pXBTVlHsrHmn9S2qmBAOeNRdzzIzSIXmaMi+h+l0CF4uHbF6xhtK2yJ1MN6+iVVeKJVbgpvB2xNcfMHA8fsla31cT/h5WQCl8Rj01QAkvXa3vX7OIIfPRUJhDoogJUxVqmXarofoDFhK3n07DHSJ+IsKYX1idBHVGdGd0XxxaQnLfkginf4bGgQYC045ShOlysszUBWGDhdJjmdKlJabt7Oc8JMfdBPjYHPYl8eRnQRFqA2zDmCYnERahv4C47V7IFtb/S/uIeMzBrNEQc7mv7M/VxZy0WrFpsbjbeI6huog3+pd/1kdp/SaWJMBtFDHpTQpGubKNqutf8bokQxGNMp9qCs55ITw2VlGmKDTHh3xGNnQy/yCSeFQNgy+l2tJu3ONTEU2VWVaOmDnDCMq7IqtdvUkdSA1a7Tv5ttkztZa1/E+imsZ/f8XERW8e/zdagaNjvWXJv749fieI7w+DO+Q1rzr8rMFp7u979yOIh8WaR8rV7dzBhGaFE=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?k3VdmevamraWbLVq38ixoZyu3so7DfnZpp895ixUWyK2sklqwC6pqEVTg4mH?=
 =?us-ascii?Q?TaTAOv6nYStBxBC3nEj17eMVzAdgODLJFQJ9JFj/PfHWdlphUgyUV+i+nixG?=
 =?us-ascii?Q?YwCO1wuG6W78+KGDuUbGqTmsADDtXq2K6OMAWyIXJJvahcpgAwRzFdCYatK/?=
 =?us-ascii?Q?gckZt7DfW3rWDjnQJgINWbumBgLipejeTmEpM1SLPC66vImtr0a5/x1wbaQT?=
 =?us-ascii?Q?yVPfuD0MJS0svJkVlV6KL+96L2lHA9v3iGNZ3CPlvL3Ng4WQlmE3dFiffPOr?=
 =?us-ascii?Q?zPTMY90FWCNymtL3imDNHEyhF4swQA4zBnBZhhNRdP7jP4KqmQFYfxRnKB7y?=
 =?us-ascii?Q?7452OrOdIXxfIpDF4C9rJnl8653aieWEtgyxKhIQ/A6opOy0j1GPDVYKfYN1?=
 =?us-ascii?Q?tbY1ODc8mSwm9xrPKUHuG+IfWQ1tx2S326VHXHk5iWRchz7fCgEbMMWSKOmF?=
 =?us-ascii?Q?tvUxqPij+9WqAER2ue0bnxEkZJtQTrbArmsAFGgokO5H1nGzjeReYmEKf6h3?=
 =?us-ascii?Q?xUiruJorTLvRC72p5BH9shlWpUPAa7UCXSj6dmRXf5uTaeFxkoetqO3x7qNQ?=
 =?us-ascii?Q?FvZ0qCT+mjPG1pGpB6dstRqYbG0L0nNH/dybQgkdjz7Qp3ZGf9lBOayn/y1H?=
 =?us-ascii?Q?mqWyDcpsxZqd1tYHIaQwuTmQyiTQcE4Mfe25kryjsfuSC5gBr2YCUhchYy5e?=
 =?us-ascii?Q?pIunfAL/UsbJxq43m3clUVxv3yxGZfWxw0cZRECVeFomi7HD29Mj92OJDUZd?=
 =?us-ascii?Q?Xy864IZe1k5vve3Ua0QChp6J1XMkzCxxljc8/6rucOyCzOIWXGHBV62AoE25?=
 =?us-ascii?Q?3DN2+Ub0f+SnhsRdDQlY9sa3CCfSBEJbiBe8VbeyyRVNsGJZRbN2cuWy2puv?=
 =?us-ascii?Q?l8lgWqAz+qIUEFCq40p4VICim+NNeq2LFAmyo1gR6A+DCZIgvRm6RZCodqRf?=
 =?us-ascii?Q?zZ9dtU6smPyLCP7u2FDqz107CMavP839BwOeCnuuxqObTjvQ+twErpOYvGp1?=
 =?us-ascii?Q?UJTOgDqnbsc1RZPhe7EFdp6UHR/6fu2GDlqrHKunEqBpK6byjLfjgqFD6+fZ?=
 =?us-ascii?Q?daoT64of55h+1d0JrMTdWN0i26ppE3DwMoV1sUl4mNpO9l4fs6Ea5zEmj/E8?=
 =?us-ascii?Q?1ki0M4sQBErEUPh42mAXQN01+9hhTTImRCZQpZc3Rpxo9HBQQDBo4X1Yngn+?=
 =?us-ascii?Q?+7yGOFCDIbGkG0w9ige2ySkv13GzjxbgP/POJ9CZwZ9r9ZtXetf2uA1dEVs?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-746f3.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d2d4258-5965-4c65-4193-08db99b71b42
X-MS-Exchange-CrossTenant-AuthSource: MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2023 15:33:12.0822
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY4P282MB2586

>Mon, Aug 07, 2023 at 02:26:53PM CEST, songjinjian@hotmail.com wrote:
>>Thansk for your review.
>>Witch command: echo 1 > /sys/bus/pci/devices/${bdf}/remove, then driver will run the
>>.remove ops, during this steps, driver get the fastboot param then send command to 
>>device let device reset to fastboot download mode.
>
>Ugh.
>
>
>>
>>>
>>>
>>>>4.use space command rescan device, driver probe and export flash port.
>>>
>>>Again, what's "command rescan device" ?
>>>
>>>Could you perhaps rather use command line examples?
>>
>>Thansk for your review.
>>With the command: echo 1 > /sys/bus/pci/rescan, then driver will run the .probe options
>>then driver will follow the fastboot download process to export the download ports.
>
>That is certainly incorrect. No configuration or operation with the
>device instance should require to unbind&bind the device on the bus.

Thanks for your review, this remove rescan logic impliment in V5 patch driver version, as it can't be allowned 
in driver so I move it out driver patch, just now it seemed no other suitable way to reprobe device and identify 
device in download mode after device reset.
By the way,this remove rescan logic works with iosm driver also, so if there is no idea of other way, I hope it
can be allowned without effect the kernel. 

>>
>>>
>>>>5.devlink flash firmware image.
>>>>
>>>>if don't suggest use devlink param fastboot driver_reinit, I think set 
>>>>fastboot flag during this action, but Intel colleague Kumar have drop that way in the old 
>>>>v2 patch version.
>>>>https://patchwork.kernel.org/project/netdevbpf/patch/20230105154300.198873-1-m.chetan.kumar@linux.intel.com/ 
>>>>
>>>>>+	case DEVLINK_RELOAD_ACTION_FW_ACTIVATE:
>>>>>+		return 0;
>>>>>+	default:
>>>>>+		/* Unsupported action should not get to this function */
>>>>>+		return -EOPNOTSUPP;
>>>>>+	}
>>>>>+}
>>>
>>>>>>+static int t7xx_devlink_info_get_loopback(struct devlink *devlink, struct devlink_info_req *req,
>>>>>>+					  struct netlink_ext_ack *extack)
>>>>>>+{
>>>>>>+	struct devlink_flash_component_lookup_ctx *lookup_ctx = req->version_cb_priv;
>>>>>>+	int ret;
>>>>>>+
>>>>>>+	if (!req)
>>>>>>+		return t7xx_devlink_info_get(devlink, req, extack);
>>>>>>+
>>>>>>+	ret = devlink_info_version_running_put_ext(req, lookup_ctx->lookup_name,
>>>>>
>>>>>It actually took me a while why you are doing this. You try to overcome
>>>>>the limitation for drivers to expose version for all components that are
>>>>>valid for flashing. That is not nice
>>>>>
>>>>>Please don't do things like this!
>>>>>
>>>>>Expose the versions for all valid components, or don't flash them.
>>>>
>>>>For the old modem firmware, it don't support the info_get function, so add the logic here to 
>>>>compatible with old modem firmware update during devlink flash.
>>>
>>>No! Don't do this. I don't care about your firmware. We enforce info_get
>>>and flash component parity, obey it. Either provide the version info for
>>>all components you want to flash with proper versions, or don't
>>>implement the flash.
>>
>>Thanks for your review, I will delete the info_get_loopback function.
>>
>>>
>>>
>>>>
>>>>>>+						   "1.0", DEVLINK_INFO_VERSION_TYPE_COMPONENT);
>>>>>>+
>>>>>>+	return ret;
>>>>>> }
>>>>>> 
>>
>

