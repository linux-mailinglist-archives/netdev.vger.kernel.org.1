Return-Path: <netdev+bounces-60376-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F271981EE43
	for <lists+netdev@lfdr.de>; Wed, 27 Dec 2023 11:36:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7DD5283824
	for <lists+netdev@lfdr.de>; Wed, 27 Dec 2023 10:36:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34E0043179;
	Wed, 27 Dec 2023 10:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="qab+LuSb"
X-Original-To: netdev@vger.kernel.org
Received: from AUS01-ME3-obe.outbound.protection.outlook.com (mail-me3aus01olkn2149.outbound.protection.outlook.com [40.92.63.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4D8C42AAD
	for <netdev@vger.kernel.org>; Wed, 27 Dec 2023 10:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xqs44mwikdDlG68S+UDWZE46RaRosRUvmwqRxxXywbYwiknWv9h0jvnxO4OG/qyBkIZ1rYP3EH/Lwdr3L2apr69O629lK3Swlhdgnot82aw8hOmkiCTyjTys+6NfQ+shRTWwy/+STllxBczW8wa/S7cP2n1cvlUhJ83KetOynSVUl5YdsHsf/Ok09WQub6IKexDdsJIVfEluEN0yypqLK1pLhEUxK4JbjSowN1K2zWKOusuHGZ/SC5EzVyXeMgDttARcaQFwOnO7VzUqmrhgZUSzIPiscuXXWCIk6UEx9ScQxOTN9nJgmNT59rOBPf+dvqt07oayJ93qcBtSQ5tMnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KJsloz9jWRSICR4loJc55qlkRMAYl6tGVMz5kXvDm/8=;
 b=kCy00vPzC9DzG6beQ2otUfwRz6O4tDskHMtBEwVti85ciZafAYcrje4+V34q9kE2hEg6KoIxw3dScWD9RfQF+cXEpTLSs5nr7dLnFBdkYKnnQFDgAWwi/oBWbeZzenvseRTpGkNmQklDKKcOC1Mc45k3MRqI8TbIZcxvLi2oVOBYOo4tVIhtAnLBdP3zSitGO+vW2d1ba1YJTjStkLTUchX6fHivNL0yH1iLdeY3tVTzxcrcJX3CdWj1gXVzF4AjUoQrkutLcz2UFjSYzWKVpn/kGZIdbPCbCzFQmcR4WAlsFDN+o00ck7pYZjU2Y5QSasZuxWxkAoAj3soRs/oP3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KJsloz9jWRSICR4loJc55qlkRMAYl6tGVMz5kXvDm/8=;
 b=qab+LuSbRuQ3CBveWiwzzMd+sDbqleCQAQNXyPmy7ZvXIlntuxJUuR8pZpYGVDXPIhqx56Pm465maDQ/5hux2NQ+J+3USAenLGK6+n6prBZJOR8XRQnzdLzjfY6pdIZeQ+NfEkGJtxb2oGomSlUdVapwQDLF5Gj/vWHCkAGYJlQhWZwD5IM4+b6x0jOTUomtuOjBsGVX1WGkrY+TbtoNcIcypJhu0uK73HgIxv+zr3cWTO5CUxezXEQka0a6tBqJyVFy/11WzAcI+Jlqzd9Ad/al6eyB/WvKT/dDQX8xIAcy5MqbnYvoOqfaTMeVYaZ+LI5UNd2Oh270i58B7fND2g==
Received: from MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM (2603:10c6:220:14c::12)
 by ME4P282MB0741.AUSP282.PROD.OUTLOOK.COM (2603:10c6:220:98::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.27; Wed, 27 Dec
 2023 10:36:37 +0000
Received: from MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM
 ([fe80::6867:103:3120:36a9]) by MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM
 ([fe80::6867:103:3120:36a9%4]) with mapi id 15.20.7113.027; Wed, 27 Dec 2023
 10:36:37 +0000
From: Jinjian Song <songjinjian@hotmail.com>
To: loic.poulain@linaro.org,
	Jinjian Song <songjinjian@hotmail.com>
Cc: chandrashekar.devegowda@intel.com,
	chiranjeevi.rapolu@linux.intel.com,
	danielwinkler@google.com,
	davem@davemloft.net,
	edumazet@google.com,
	felix.yan@fibocom.com,
	haijun.liu@mediatek.com,
	jinjian.song@fibocom.com,
	joey.zhao@fibocom.com,
	johannes@sipsolutions.net,
	kuba@kernel.org,
	linux-kernel@vger.kernel.com,
	liuqf@fibocom.com,
	m.chetan.kumar@linux.intel.com,
	netdev@vger.kernel.org,
	nmarupaka@google.com,
	pabeni@redhat.com,
	ricardo.martinez@linux.intel.com,
	ryazanov.s.a@gmail.com,
	vsankar@lenovo.com
Subject: Re: [PATCH v2] net: wwan: t7xx: Add fastboot interface
Date: Wed, 27 Dec 2023 18:36:12 +0800
Message-ID:
 <MEYP282MB2697D1BF57A9C72BA8B7C0E2BB9FA@MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <CAMZdPi9TLiKgtPrE=XLnn694mkScj=aASN7Kc8-Qu-hKGXR0Lg@mail.gmail.com>
References: <CAMZdPi9TLiKgtPrE=XLnn694mkScj=aASN7Kc8-Qu-hKGXR0Lg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-TMN: [NW+Ux9QGl0GAyYAu6aDGVLyfm/8yZF23]
X-ClientProxiedBy: TYAPR01CA0191.jpnprd01.prod.outlook.com
 (2603:1096:404:ba::35) To MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:220:14c::12)
X-Microsoft-Original-Message-ID:
 <20231227103612.5270-1-songjinjian@hotmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MEYP282MB2697:EE_|ME4P282MB0741:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a24c407-e7ce-4553-daa2-08dc06c7b3f3
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Xtx5zWQanoLWapX8h3dCYMGQOM526JSVgqLQaasOTBUSOpz+R9JU8EXAKAUx9x0eP7Ql79CLkfnQPXV9T99hjnJUncDjjDum8Kc7ihymjw3rYbl+A142csQ31rlG6Ce02YOd0KIwE1FYvsUkyUv6UDrXDxLXN1alj3ucGTNR9jeWUZOBorNhEQn2Cykf55txdg4eB7JTNVYILy90LnMfBIafLogpw/N9bV8ZDwJqDqO9hs2eEp2eZjwmGgG+39iDGT96EHsCuINFLwGOXlV0RpUjER5O7gk9EcsF820fL73pW3tGU3JSqJoCVqxZeFH54Q4+g8GzcletFDKLoSx0TJjG0VJKOQJCaGZLqRhG5EnK9y+jTMg8QKuKe6fpcR2SNu+Np/alGQrWSw5Sss1bRHGGMSIRdRTXZs/yB4w/ByHsnB+a7mHBPHyiDNjRwKrFoXntfhDhxj426ng8wojfC4jNqnZFj0U/vgvvbzJlM7WbkPFufGzrr/Hd7WHoVwDIVyJM4smUD3QWx4laTI8zM7MnEkTw9yRNmJJY+gRyMcZ32DYIhyUb4s+XSmP5CIgHCkNhOuN5Fr/NQA1CDPtcs8Ci6zR9Tp9tb5PbRr8yMSZm3WDzQ2m/ctKUUDyf5bZW
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ekNFTm4rZnowSGdMSm5HbVF5c1RrT1pyMy9xRmVTaENwekNVTzA4T3BiV1JM?=
 =?utf-8?B?Q3dWUGlLeUZHMW5ZWjB4c3M2dTJLZzY3WU5GU09Db09YcGFSZ1d6NXlleG1V?=
 =?utf-8?B?UWx5cnkwOVExenRXd2ZDQnQ2REs0dHNnWWNsTFJlVndUd0FZMHRCSGtBUkJN?=
 =?utf-8?B?K29tNUxoYVg1SmtBcXJUVzJDby9QSjhXR0FtRGlJMTJPK05BNnFqZ1hwY1NE?=
 =?utf-8?B?N0tFY3RkeUJTM3pBb1h4dU5hUjJNVHorYkdkYldsRGFOd1RpUjY4WEdWNlVD?=
 =?utf-8?B?dWZXRFIzU2d5OUkyUEYybDBOTHh4b0QrMS9XbWF5eUV3NEU2RVRzMTRveStG?=
 =?utf-8?B?Y0FwTUFsSmV2cjJMbngzRklUSW1TbVJXYkNFZ1o2Sm10QSt4eWFjNUZSZkZX?=
 =?utf-8?B?U1ErM1BZa08wLzJIdWM2Q1BIcE43NFVWZjFoemlzTy9GNDFBQXdrR3JNcy8w?=
 =?utf-8?B?bGRCNy9pZDJVOVh0WEhuRmhCbjczVmVMVzVQWVBpem1CV0RIYTQ1djJ1aWZK?=
 =?utf-8?B?aTlYMU4rK25oZnBiNFJYeDZGZE1iWkFsNGlyNUR3MTJZdHBGVDVSR0JQMGVw?=
 =?utf-8?B?MktERVZIRytXRWNjcjBSclhRTktiZDBacW1IOW9DeHFsekx6UTNFNUR6VEUr?=
 =?utf-8?B?SmxOM2ZDVHI5MzhmZEE2T3BoeDVCVTJEWTNaYmtCRytXNHE5ZERvcGhnWjQ3?=
 =?utf-8?B?NlR5MGVma0ZWaFB0VzJXWHBqT2hrR2xPcktUK09sWXQvYjdGUWxXdXFQa0hw?=
 =?utf-8?B?RVFuVHFZNGNtNzdMYTdhdmJDeEg1aENnTnQwYzJURFRIZVZSQTBJY1hnRm8z?=
 =?utf-8?B?d2Z6ZXVaclBtQzYyUG5YY2djZ1lzWVU3b2R5ZEM1VmRaUW92NTRGZThJU3dD?=
 =?utf-8?B?bUZCUXJkMG1ISHhZeXNaaFNicTN4Z1FWSkkweTBkZ1NUbDlKTXpJMm9LSzFa?=
 =?utf-8?B?SFE3WlpLY0tDblVGRTB5T2M4Q3VjR3VuQU9PUVpUcWF1L0VEaUtVZWRBOGJY?=
 =?utf-8?B?dlZER0wvbW1jT2ZjSmlOYnlyMllDRWlQNWxJaVBobE9HVkZ5Y3BsZnNHRW1U?=
 =?utf-8?B?S2R0RkJLWTFyMGFRSFJpMUUzSHRyK1FlMG5jWktWd3E3QjFFcjBXWVN3S0hp?=
 =?utf-8?B?V2JzMGJWSHdjQ0dORGpSV2pVZWR6MFRMRUVaSGxHMWQxU2NmdlR6amtRZk9Y?=
 =?utf-8?B?L3o3ZUsvTkJtVnVucTViOHJhSXpNM09ZMC9KMHNYRkkvNXV6K3VKRjhrakcx?=
 =?utf-8?B?TEVrTFJ4K2Yzek9zVEFMdC9uM2xCWThxMXNNVWw5T2MzN2p6NVBjVzhYc29K?=
 =?utf-8?B?OTNBUU9TVjJZSUZkOUhoMktOWURlR2FYUWQ2ZDg4eGZyaEpaWTdCbnEwWEJC?=
 =?utf-8?B?RmxMN0hjOGVTR3hHM1YyVldmb2hNWHJjcm5GalpwUVRub3NwZklLV2h0NVZB?=
 =?utf-8?B?aFQvSnNlQnVmOWRSSjZCb0lIZzEyd0RyU0EwN3N5ZFpieldldG41MWMyYzNj?=
 =?utf-8?B?cHV5MGJxRjFyanMrSzR4Tkpxc005b2ZMWWlmbVFTK3I4ZGN5Z012bWtrRGx0?=
 =?utf-8?B?aVRiWVZRWXM3YjAvcTVVUWpYNlFDbUdvVHlsVmNPOGZsMFg4aWNJR3RYN3RG?=
 =?utf-8?Q?NBC3IxMAvNmeOG0qcSx3XM/8t0cJqUygxTamNUBE5mJM=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-746f3.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a24c407-e7ce-4553-daa2-08dc06c7b3f3
X-MS-Exchange-CrossTenant-AuthSource: MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Dec 2023 10:36:37.4599
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ME4P282MB0741

Hello Loic,

>Could you please split this single commit int a proper series. At
>least one dedicated commit for adding new port to the core, and you
>may want one for the new sysfs attributes and state machine, then one
>for  your driver fastboot port support...
>

Thanks, please let me do that.

Best Regards
Jinjian

