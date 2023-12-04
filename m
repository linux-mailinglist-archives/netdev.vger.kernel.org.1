Return-Path: <netdev+bounces-53466-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B151F80316C
	for <lists+netdev@lfdr.de>; Mon,  4 Dec 2023 12:23:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E06001C20A8C
	for <lists+netdev@lfdr.de>; Mon,  4 Dec 2023 11:23:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7406422EFC;
	Mon,  4 Dec 2023 11:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="TobAfpin"
X-Original-To: netdev@vger.kernel.org
Received: from AUS01-SY4-obe.outbound.protection.outlook.com (mail-sy4aus01olkn2167.outbound.protection.outlook.com [40.92.62.167])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EED1BA7;
	Mon,  4 Dec 2023 03:23:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I1tdvJOv+kWFkrAI8cYj7mbKEfATPsKC8V9BLytjEkFvHH7U0l+mhXJecganFbzkvYKhy9xJPrvKf5IhmDhi4OCkjkEPN7J0gibrunRNOaqtqeKN9oYP3eRPmw6PAWO5G2PApFLGgAXxsGrIktTbBwTuGQQsTe9TrF3sQUcLTVJj0wgfKvFzP7aGKt5BvlQHeyomDaWhm39aLozQ8eThXPElHvEPFZtlDfmc02Fton2b3UDFhKfJY92JyBmF0qmCCauIrAjdvEBJYQ2ukru527NvGz/tOvX6bINLWCXGKEDCnVDpSAWCTKAFm6Pl7Pw2JsU32ULbLA5yQ40awIxjeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZJo5vpRzOHeWUu6NoSpVDYvvQjwgRojgNIYPoN8bPmw=;
 b=hqCjQwklKdnIsj2axLhSxjZrow6wimJ8pV4iXpLCr/9Y7+nRyqNYfgwX9ZgNUemWDLSlYhsRO5DJQ9Ssl+GwIPiidwB/Ek52wb3gcDLnT6zkcMOUjdnYK4IvO+A+MivEjAKn66tudtB1MYJsTsN1gwstgLGVG0ZB2YUjFgQbboSkKYZ1aKzocH5kresR0BvD0xoCpK9f+cZ98/Y9yt6XJkMzYlbGuqvcW7y3EOT+2MJ1Qw7LAF6rLY7Duq/xPUgjhfKWEFNPIP/fOeNugrlZ8YryzegqqavD8qJ6ZYQwhZwRdeqM/q7V/u2D8uuDdlYb1ECxJ0d+vyHje4w0oiOKDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZJo5vpRzOHeWUu6NoSpVDYvvQjwgRojgNIYPoN8bPmw=;
 b=TobAfpinXsLzq8JcBr9yVwabGcGrFfQGIfmNvxh6E+mIwU9Ghf+8RtZg9MM9esi/Ihdu1GrMIn/PCCbM8ugEfYDV6rpaCZJxIB71QCCUdi0PY7cNotkIby3yIOgCweTZ0KIKBLiNbgof+iIdVo5o3EMalnhsAHk6dbPNeCI9It5zPAtm6W9K/QZAdjmMN+egskQdTz3qKnkg4UwywCeIbqh6JO+XoSrIxzk4WPMeW+yAVjmKJ7yoAMTG44bzmlX8EtuLLJpKbDEHv8NsyAGrpZAHmTpHWJUUvK6oY4NwRn9IwlonqbNeN1FrVoSg4wUqQxf0SLTZDFbrIiBGsiDY0w==
Received: from MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM (2603:10c6:220:14c::12)
 by ME3P282MB1361.AUSP282.PROD.OUTLOOK.COM (2603:10c6:220:8c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.33; Mon, 4 Dec
 2023 11:23:03 +0000
Received: from MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM
 ([fe80::6867:103:3120:36a9]) by MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM
 ([fe80::6867:103:3120:36a9%4]) with mapi id 15.20.7046.033; Mon, 4 Dec 2023
 11:23:03 +0000
From: Jinjian Song <songjinjian@hotmail.com>
To: loic.poulain@linaro.org,
	"SongJinJian@hotmail.com" <songjinjian@hotmail.com>
Cc: chandrashekar.devegowda@intel.com,
	chiranjeevi.rapolu@linux.intel.com,
	corbet@lwn.net,
	danielwinkler@google.com,
	davem@davemloft.net,
	edumazet@google.com,
	haijun.liu@mediatek.com,
	jiri@resnulli.us,
	johannes@sipsolutions.net,
	kuba@kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linuxwwan@intel.com,
	m.chetan.kumar@linux.intel.com,
	netdev@vger.kernel.org,
	nmarupaka@google.com,
	pabeni@redhat.com,
	ricardo.martinez@linux.intel.com,
	ryazanov.s.a@gmail.com,
	vsankar@lenovo.com
Subject: Re: [net-next v4 0/5] net: wwan: t7xx: fw flashing & coredump support
Date: Mon,  4 Dec 2023 19:22:31 +0800
Message-ID:
 <MEYP282MB2697E19F0654B3C53AF7E8FCBB86A@MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <ZUTOX0oSCPpdtjJV@nanopsycho>
References: <MEYP282MB2697B33940B6E9F3BA802729BBFBA@MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM> <ZUTOX0oSCPpdtjJV@nanopsycho>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
Content-Transfer-Encoding: 8bit
X-TMN: [JGzqciBqaNiIzRvjZIlmEpxa4As/IAAu]
X-ClientProxiedBy: SI2PR04CA0018.apcprd04.prod.outlook.com
 (2603:1096:4:197::9) To MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:220:14c::12)
X-Microsoft-Original-Message-ID:
 <CAMZdPi-GgchY2tWobFSohCzc2eBq=dUsSJS5qu_LW3xAPLVwBQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MEYP282MB2697:EE_|ME3P282MB1361:EE_
X-MS-Office365-Filtering-Correlation-Id: dfcc21be-5193-4428-fcd5-08dbf4bb60d1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	0oDyAOxjzs5eYbKNJEGf446DAwS0jpbC6+gP0m+xtCyC+qujzjC3DwdhL9ju6SCUwxYudXMzsBZRruUfDCrrCDkX6D2L0Q6l/ccHLFfRjCGLVx6cxBSv/dvLOABM5NyMqyrYlC636P+YnttwPSY45BYUGmhs9jmtEFa9SqwtIcOwt2TgGraVMuJ9SJUn8GhYG6abkqIRtTl42ymkl1yfmcHVxWGusKOsKayy5bUN6GVpMRXlrC0WW3dazocuoS94L3wwfRnPTOPvMDzIH+RBLNHyMvP7LjS2A8vuAQmcOSJZF8R4PGP7j3ojQHCwtrMU1yZApw1PJkaGs8bVwX9s2Zbfd0066ewEGyCodSDMSDmj2ZyFlw3Ja7OgqdLd84ey7NU1kU9f+9mWl+1+w999EV9ap0OBvT+dz+V+Nr3r5rwSQJOt+DZESBBtMpzPe3OJjsW4+d3rBfbH81Rc+bixrVHEz5CkPgPTbMzAoJSqAx23eFv2PQTpg3wr/vGVJtMOh82N/IxKwBh2K7kte3HFNXUlrHLbZ0sl1hrZ/GruhTDHoH2qFK0YAmuwPvat4WHQXxKNFZbiVNKgWgs0yYGjp/olfUAw9PkkW/r9QV6YnRfLbso2Ic4+drWRfZiX3CE6
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RTV5OG1KcFQrTkZ1UUx1WkxGTEdSZ0lCRWt1b25LaHpxWitlUzBZcnRJTmcv?=
 =?utf-8?B?ekc5V3d3elNKdUhGTkZTL1NMMWhIdnZFTkpGbTI2TGsxbnY3MFhBNEhKc0wr?=
 =?utf-8?B?VlRDTnV5VDVkOXJIZnVPM0RWQWIwM0tUbDdFN1djVWpDVU4rUW1rdTcwaGpi?=
 =?utf-8?B?TlFxSjZ5TktBa2V3a1kwSGRwMU9DK1UxV2ppY1BFSHJEc2c3U21nczJDYVNh?=
 =?utf-8?B?VVRJYjdaT3kyRlluckNTSXNOOGVoSFI5WmdpT0ZWNG0zbHJlbDJDak5rckpt?=
 =?utf-8?B?ZWlYZWVTTVlncWR0ck85dXROZnhIL1U5UVpSNWRxWkd1S1RuZ21vMys5Szcy?=
 =?utf-8?B?QlF6UFJBMWUxMDlFTjNSU2lJZXVTdlZ0SzBrdkhWb0tKenhrWCtHU09iVisz?=
 =?utf-8?B?aW1tM2F4dTFheVNzMzBMOFNRVFBvMGVPZkdiRWwydkRuNFJwWlI0Z00zNzVF?=
 =?utf-8?B?cGxCRmpNQkI2bS9JZC9NWWwzWFpkcGluNVBMKzFQbit6cS9hOXpsV3dJZVRJ?=
 =?utf-8?B?b3JoU29DRk9nWVl3bjM0MGFTS0Npb3BMZkRPVnVkckt1eXlOZjQ3YWFmTTky?=
 =?utf-8?B?Mzh0ZTQvOGI4WFJ4RmpZeU9NTDNLNGdWWXFIRkd1SldqdzBacUljd0c3T2Vt?=
 =?utf-8?B?dW0ya2kyUjFRbm9kSEdHVmVLNHlYWSsvQjEwNEpBN1dpcXZQTExSejZ3MWJU?=
 =?utf-8?B?MFFQNFI3MDk1YmdKemNpR1JlL0JjN0RSZVZiZmQ1S2RQSlNqNzBEYWFsV3hP?=
 =?utf-8?B?L3lzbkpaQnZQeFFwTWpNeDlhemwyVXR0WDhjSUJPVkcvY043M2xUQzV0MUdt?=
 =?utf-8?B?Q2xJMEttRmV4UHRDTXJqVVdTb1lKbDUzMitmZ2pxa0ljcmpMUGpVQmpURHlG?=
 =?utf-8?B?eDNlUlRwaFgzK1dwK1d6OHBDU1RpM2hJMzJZU210eFJkYUhVaWQ3V3JYNXBW?=
 =?utf-8?B?SkxlZEJsRGZ1ZmMzVndudzV1bG94dDlHcFFpdC84N25YWUQvZ28yMUZ6a3E1?=
 =?utf-8?B?Y1hSWTdEMHJRVXhDU2xZaXc4OUhJRmJmV0ZIRlBKR2xhdVBTdVM4ZUtpTGx4?=
 =?utf-8?B?TDlSelhrNFhlVkFoRHpPdUxnU3BYTmdaakdlZC9Qc1c2K2VuNHVoMXY0RVkv?=
 =?utf-8?B?eVJ6WjF3SC8wV0QzWmxSS05uTC9SRWMvZENkMmZCQURyTVpWcHF0NCtzYUxT?=
 =?utf-8?B?dlNUNVA4Tmk1ZmkwdmFGYkoyYjNXLzVFeDBMNTh0ejU5RE4wSU9MVWFQckQ3?=
 =?utf-8?B?cS9MTEFuU0NnaGE5VGc5L1lFQ3ptRkRwdnJlU0I5ZmNVSlEzbWxMcVNmRjRm?=
 =?utf-8?B?MWdMenozZFdpeFFRRjB5cGloNTkxajBsMDdKSGZXQ0s5cEwxcU4rcGJQN2sv?=
 =?utf-8?B?aXNyWWN6Sm9NTEFSL2xTYlZlME4vcmJIVmREbkIybzdMTHRzRVdRRjYyUS92?=
 =?utf-8?B?VWRqNGxPV2k1K2huNGcwR254NWo1VkpZMUZVUlJmZ05UVUZXYSt1R0tNR2VC?=
 =?utf-8?B?NXdGeGx0YmZQcmJZWUtVbWludVhqTTFzUGUrMEhqaTIrcURPQlhrSDA5NUxI?=
 =?utf-8?B?TENjejBURytHNnRTYjY0T2R1RmFLSk0zK0R3Zm5KaHZjK3JXeTByRTJ0c1JD?=
 =?utf-8?Q?YBC1dpM+7FaD5CLmCy1u9BPCVc2tumuG0uNZu3ZKqwo0=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-746f3.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: dfcc21be-5193-4428-fcd5-08dbf4bb60d1
X-MS-Exchange-CrossTenant-AuthSource: MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2023 11:23:03.9149
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ME3P282MB1361

From: Loic Poulain <loic.poulain@linaro.org>

Hi Loic,

Thank you very much.

> On Fri, 3 Nov 2023 at 11:41, Jiri Pirko <jiri@resnulli.us> wrote:
> > >
> > > Mon, Sep 18, 2023 at 08:56:26AM CEST, SongJinJian@hotmail.com wrote:
> > >Tue, Sep 12, 2023 at 11:48:40AM CEST, songjinjian@hotmail.com wrote:
> > >>>Adds support for t7xx wwan device firmware flashing & coredump
> > >>>collection using devlink.
> > >
> > >>I don't believe that use of devlink is correct here. It seems like a misfit. IIUC, what you need is to communicate with the modem. Basically a communication channel to modem. The other wwan drivers implement these channels in _ctrl.c files, using multiple protocols. Why can't you do something similar and let devlink out of this please?
> > >
> > >>Until you put in arguments why you really need devlink and why is it a good fit, I'm against this. Please don't send any other versions of this patchset that use devlink.
> > >
> > > Yes, t7xx driver need communicate with modem with a communication channel to modem.
> > > I took a look at the _ctrl.c files under wwan directory, it seemed the implementation can be well integrated with QualCommon's modem, if we do like this, I think we need modem firmware change, maybe not be suitable for current MTK modem directly.
> > > Except for Qualcomm modem driver, there is also an Intel wwan driver 'iosm' and it use devlink to implement firmware flash(https://www.kernel.org/doc/html/latest/networking/devlink/iosm.html), Intel and MTK design and use devlink to do this work on
> >
> > If that exists, I made a mistake as a gatekeeper. That usage looks
> > wrong.
> >
> > > 'mtk_t7xx' driver and I continue to do this work.
> > >
> > > I think devlink framework can support this scene and if we use devlink we don't need to develop other flash tools or other user space applications, use upstream devlink commands directly.
> >
> > Please don't.

> So this is clear that devlink should not be used for this wwan
firmware upgrade, if you still want to abstract the fastboot protocol
part, maybe the easier would be to move on the generic firmware
framework, and especially the firmware upload API which seems to be a
good fit here? https://docs.kernel.org/driver-api/firmware/fw_upload.html#firmware-upload-api

1.This api seemed fit here, but I haven't find the refer to use the API, codes
in /lib/test_firmware.c shown some intruduce, I think if I'm consider how to
implement ops.prepare(what to verify, it seemed modem will do that) and
ops.poll_complete? And it seemed request_firmware API also can recieve the
data from use space, is it a way to use sysfs to trigger request firmware
to kernel?

In addition to this, I may have to create sysfs interface to pass the firmware
partition parameter.And find a nother way to export the coredump port to user
space.

2.How about we add a new WWAN port type, abstract fastboot and dump channel,
like WWAN_PORT_XXX, then use this port with WWAN framework to handle firmware
ops and dump ops.


Hope to get your advice, thanks very much.

Regards,
Jinjian


