Return-Path: <netdev+bounces-233220-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 76BFAC0ED27
	for <lists+netdev@lfdr.de>; Mon, 27 Oct 2025 16:10:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB41419C468E
	for <lists+netdev@lfdr.de>; Mon, 27 Oct 2025 15:05:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87289824BD;
	Mon, 27 Oct 2025 15:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="FZ1l8KPj"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA1BD2877DE
	for <netdev@vger.kernel.org>; Mon, 27 Oct 2025 15:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.156.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761577499; cv=fail; b=OIP122pdD/TJqXO0ngl4Be0Ao1rkNyD4e8voa+PB4xb8oahhbnKoFVFBXelRlhuIlwjqNWvyJTdi1DmtHxnkSgCjkdO95tXfkijXSH9gExNlLxDXJkXueeeCDpagYhCtzLnoRJ+3sa8xIax8/gIVz+w1DvltV4Bv5xGplFmtBls=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761577499; c=relaxed/simple;
	bh=i8JZ1lfWa/4pU2XCedDbCAR486BHl/j1VhihS3sOKZ4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=H6fGT/SXoWqAMMR+Wmb06BapaDwcUwEoXlcmWltLa09lvzD+EI/q3p1MbfzthlHSRTtvpyQ1+mZhCEWoHm2HBqNHldJClMTvs/iH79jUYFVlOqzsrOOSylVUfd4qapC+dnys9CkGcljEK29HwM7QjC2iDMwQ+jgOUl+ZIwUj3iI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=FZ1l8KPj; arc=fail smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59RBAA1o1913415;
	Mon, 27 Oct 2025 08:04:54 -0700
Received: from bl2pr02cu003.outbound.protection.outlook.com (mail-eastusazon11021108.outbound.protection.outlook.com [52.101.52.108])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4a27mfghg4-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 27 Oct 2025 08:04:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qod0HGBmt+hXegmI3bbPUgEK2Hj/gnLKSokfbdhie1noZyb1Al35+dM/Cnkyjw+Z/VKqDVl63TVDSoHsKzK0q9QVvRWtkb7hz97LDPAqQY8eVt9QEzGkOC+LPrrA0R7mpYDN8NI0bDdPEt83pTsrUcb+4FoW8VY8hHqYaWfoX4W5B8Fk6w7jpSrOQEs7bw6AYn4XECOi+AGj9l61WxIJy9Z5olXU+rxb3YRuZjG24gbtDqDQEj1/pqdkx1UA5WWv8XiRtwlL8v2D5cF3HdvUWY782D8sHUhnYMIgWi8wJqSgvWpcF28joLny1+gkQ5AaYjgZAD0jTSeRyCJHGRQjSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i8JZ1lfWa/4pU2XCedDbCAR486BHl/j1VhihS3sOKZ4=;
 b=B7QmDIzf1Q2y62ggKic1cnOla8e7yKvnTi9A3IaCK8IhSHlnQvnq5Z4sa6Exp7vhiMBYE3VntZMsFmGwmHVHyAIH4uG1UW12cbC2lEtQA/g3MdhzcPCicWO4/Nhsyw3tnlHi+DPACJaTqu5KJ6lmBsIwlGr9B4MPDwsgMbrAb4WUg287POPYP9kFa6ZpH3qTSmGZt5JDQfheVouy5VtfUICuoDG8veoUaWNVdoSfZancpTHGyc4pmCb7tdWOqOJEm0NWRrDoPPinj0IP6fSYGUd5SOOX+75mfg+wGpsdN+c2gY9+CJFtBmrKTNj4b9k9zWkPku4LptDXfRW/pxPD8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i8JZ1lfWa/4pU2XCedDbCAR486BHl/j1VhihS3sOKZ4=;
 b=FZ1l8KPjrbzz3wgK9GbvYElvy0HZsmaVEBOqda7gKWiYNNBlAdQiJlpWtA6mS/e+eH2JobKNm9CssI9PPAo9O1QbHuxx3BXCkGD0dA6NVEjhuicKo8ImeoGMwMFAV8bSKn1+6cbv4Q0grc2SOALmCfKm+KA2kjc8fAdtIwo6V80=
Received: from MN0PR18MB5847.namprd18.prod.outlook.com (2603:10b6:208:4c4::12)
 by PH0PR18MB4441.namprd18.prod.outlook.com (2603:10b6:510:e0::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.19; Mon, 27 Oct
 2025 15:04:50 +0000
Received: from MN0PR18MB5847.namprd18.prod.outlook.com
 ([fe80::15ae:f628:1ae0:65c0]) by MN0PR18MB5847.namprd18.prod.outlook.com
 ([fe80::15ae:f628:1ae0:65c0%5]) with mapi id 15.20.9253.017; Mon, 27 Oct 2025
 15:04:50 +0000
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: Donald Hunter <donald.hunter@gmail.com>
CC: Jakub Kicinski <kuba@kernel.org>, Netdev <netdev@vger.kernel.org>
Subject: RE: [EXTERNAL] Re: ynl newbie question
Thread-Topic: [EXTERNAL] Re: ynl newbie question
Thread-Index: AQHcRbC9dlu4wvCkAU6bg2004geX5rTVzkcAgABL9ZA=
Date: Mon, 27 Oct 2025 15:04:50 +0000
Message-ID:
 <MN0PR18MB58471EF89DE9B676A3967ED6D3FCA@MN0PR18MB5847.namprd18.prod.outlook.com>
References:
 <MN0PR18MB5847A875201DF2889543A61DD3F1A@MN0PR18MB5847.namprd18.prod.outlook.com>
	<20251024080959.55e7679d@kernel.org>
	<MN0PR18MB58478446CEBD0532BB7CD453D3FEA@MN0PR18MB5847.namprd18.prod.outlook.com>
 <m2ms5cr5zd.fsf@gmail.com>
In-Reply-To: <m2ms5cr5zd.fsf@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR18MB5847:EE_|PH0PR18MB4441:EE_
x-ms-office365-filtering-correlation-id: 66e9ad8d-37f6-461a-a21b-08de156a2d59
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?Unh3MHJpSkJPNjlSUFgrTm84cEEwYXpWWFBZS1N2Mk94RXRyempnNVJNMlNy?=
 =?utf-8?B?MkY4QThJT2ZwQXhDeEFJOGxPZTZ2SlJlVWNTUVdTODQ1ck1BMzdmY2hJbFNt?=
 =?utf-8?B?QTB1bGZSdGhDQXhTcDRaamVWSm5iU01Eb1FvS3gySmZBVmV0ZTVEL1cyRUpq?=
 =?utf-8?B?b1ZMMTZybGt4VlJvUm5IL2s0b0duaWFiZWM0NGhaNllEckhrS05aRW14NURS?=
 =?utf-8?B?ekJ3dnFkNCt6N0NzaStQbTVUUWRHU1VPVjZyQitsVlZqb1I4d0tGd0hic2lM?=
 =?utf-8?B?WkVabkJEajlwc1BneHBxeHVvSzBJMzZlMGphUWg1MkhEem1Rc1pLZ3ZXYnRu?=
 =?utf-8?B?M3lYckpyUFZRY1ozU2p0TUxPT0toSkN0MXBpWW16Y1FBd1FyZFV2MzRqS0oy?=
 =?utf-8?B?R0d4MWxYNk4wV0lUODJzOFV4M2FDeTNZek12TlRnWDJLN3MvRXFpZjEvZ2ph?=
 =?utf-8?B?ZC9OQVJLN3BwZXNrYUZKMFFIVUx4Nk9HSHFkY3NCUkJZL3RiT2szVzczaVZN?=
 =?utf-8?B?aVcwNDhlbEJlREhVcGZ2ajJ5ZFowV1pYN3g4MjlPbDdORFJ1OXRZTmdIWGRu?=
 =?utf-8?B?N05nU1JnNmovOW9ydTFObXpMdi9BWUZ2VVhvVmVERUV6UUJoeFQ3REhEOTJ2?=
 =?utf-8?B?YVJZMHNwWVVYZnRocWRUWHE0SGkxdXJHcjJsZE9XcGc1TEo3N29DQnBrT1Y4?=
 =?utf-8?B?cVpPb2JENkUrVEVBV2MrWFYvNndjcnFEUDNTOGZuMG1XcDZiZU1JalN5QTJa?=
 =?utf-8?B?bXJSRGN0dldEQWh0aERrVVM1cDVacDRNNGs5TTZUYlNxLysyL0hxSXpYeFkr?=
 =?utf-8?B?TFdCNk9FUkZOWHVHM2Q2ZE1xaGxEc1NvNXVaVHl6emhDU2RZKzRzTU5ycTc4?=
 =?utf-8?B?VzRSakZoVGJoN3JkaWNLclhkM0wzblQzbWpDNmkvMVYxOXRHeTVZL0Jvd09Z?=
 =?utf-8?B?UnNPNVB5cXFkRm83RTNIRCtySE94bFQ5V0hvZGRjaE12S3QzeWRYWTVvM0d5?=
 =?utf-8?B?NUIzM0dvbklsV1J4dHdVUUZtdnFFeWJRTk05RDhJQWh1NFl6L3k4Um4rLzVY?=
 =?utf-8?B?ZUtKeUJ5ZVUwMjgxVnhqNXNYV1IwdUtQcEorUWY4Q1BGUnVnWkc4RkhsMmNp?=
 =?utf-8?B?ZnZiSGFNWnA0YU44aFA1bE82RjJKcUdtOHpNL0FXeVdKWU5MaGQrTjVxbmtt?=
 =?utf-8?B?SDJlSzRqSEpZcjNPQ28vODVoaGZzZDkxVjlkRjlTaGMvOENHZVl1UStJYklD?=
 =?utf-8?B?dmorTStoNGhGTVE2VGFxSUtEdldHY2p0b1VQWDNWLzRFZVlsT2J5dmp5UjFu?=
 =?utf-8?B?dWh1d1J3Q1FIc3hLY0RWWmxCNExtMEhXRXNla3QxN2RSVnRDWVJnNE5LZWlU?=
 =?utf-8?B?VHIxakZ1bUhCU1dGMzRicUV4bjV4WGhZZGVMM2x1WENvQXhmR0pzMm9WMjNh?=
 =?utf-8?B?ektqZWdsUVZaQzBnZ0RtVHpjL1h5eG85RkEralU1UWtydFdUNCtGK05vWkNG?=
 =?utf-8?B?U2daN1U2eFpmSzBkM1pEdFhyeTlIL0tZMGlKaXI5Z0NIUk5mQlJGbTdGSVRE?=
 =?utf-8?B?cyt4UE9wbnIwS2Y4SjBlN0VNVDczOEdzMCsvc2V6dXEybCtJZFVHblVEWHVI?=
 =?utf-8?B?TC9WL2lwcmFTVFZrT0lTMHB4VnlJT2EwRWxTRzVmRklpNXRoVGcxK3l6VVpn?=
 =?utf-8?B?NW9kcTFjUk5LV2tHL0s4TUhTLzBuNGpLVzZnT1BhTzNmWFdnYlZMaFc1WlQ4?=
 =?utf-8?B?bzdsWlI4MmhTY1FBS3JyUndoaXVrMWhLTlBpVzYrSTNLeCtQRWlteTRUMFpC?=
 =?utf-8?B?RGYyZ0cyTjhhdHRrbVM0NkdRTTZ4VmVtUU52aVpXcnplajZ0b1psRm50SitT?=
 =?utf-8?B?V05lTTJlb0xpMlV4TjU2UjZKcUpIaTVnQ25rZzBuZTR2cWVuWlA1MmZZVUxK?=
 =?utf-8?B?Z2FnNmd2d3ZYeVVXM1FTaHJRRmRjTFArSGdRK3lhZVpKTDR6eDVaWlNNRjdI?=
 =?utf-8?B?aDZma3pjbzYrc3dqdWVxMGRqSmZXTG02VENXSlJOTnlUdUkxeGlDb3YzLy8x?=
 =?utf-8?Q?PLfMH7?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR18MB5847.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?R2luQkxvWEYwOTF6bjd5cWVkWnRvaXpvbERzRHBHZW5WQ0NveGNYMEoyYWtT?=
 =?utf-8?B?dnZiRTNwWUNZaDhEVkcvK0pxV0MxT2VlK1VzTTdQNXlEYjJFZmlvTjF4K2Ra?=
 =?utf-8?B?ZVUrSnc3YUtyQzJXVmRKYTdQdU90eU1RU0MvMnV3a2JuYWdvdzFzdThwVGQ3?=
 =?utf-8?B?ZkcxQWJWc2UrVWFNZlBYanNHR0hZaFF0MXdBQXBmWmxrL1pTeXRwTk9ud3Vj?=
 =?utf-8?B?R3NmQ1Q2V3dWVlYwS0tnQjNBMDRLNkd0RGtyMU5kVXlNZjN3Nkw3dmNCNHlY?=
 =?utf-8?B?eTlZRFM4Vkt4aFF2K2RQaTYwNStjQTV2K3JJRVJFN1R6UWVtWklOZ0kvc2RP?=
 =?utf-8?B?eUZBaStCbll0SGhQS0l3OUtwUndPNWk0TWRqZkNUY3JYZ0lQNHRaeXZYb29W?=
 =?utf-8?B?cU5KcWZNTjVxbFNJRURLSEdwenhoVE1ldG9RSkJzVUNuSGNmeElCWW1FNEhh?=
 =?utf-8?B?dkFTcGd0cCtqSzZCeWVoWVI0UTFIVEVGY0VEM3BvKzNjMGdBZHp4c3dTNGNW?=
 =?utf-8?B?UWxaUmtiVEVjUjFJZytvbXNOZ1gzcWhrQkh2K0RndDI2M1czS29xM2tSMDBU?=
 =?utf-8?B?L0g0Vkttb1k2b3hVZ01GVCs1eW9SdHc1M2dWWGRiMDVyNEJxa0JWMXpoZlM0?=
 =?utf-8?B?OXJGdUpMTEIyUWtXNDJTTW82MUVVSktzZWdKcE5OcVhGb1pLYjM5Ukc1SlJw?=
 =?utf-8?B?MkhPUUNTN2xlUkVZc0RBTC9FdUhvdHpSSmk3SHJiOEU1cER0RnY5ZmNuK2hJ?=
 =?utf-8?B?YmRGVnh0ZjlKYUdWUE1HcDVCWU81TTJRYmpCTVpjLzZoNlBOSjZ4K002YjlW?=
 =?utf-8?B?M09Vcjl1TmVha0ZBZi9ZejdTb1M0QWV2K3k2RGkyTXQ5ZHQ3blVzMkxmd2hJ?=
 =?utf-8?B?NllZK251VG5JYng2cHk2WG9sR1U5aW9Cb3Ira3M3b0xsMGlQZVRkbFFmS0Yv?=
 =?utf-8?B?QUY2bGx5LzhwWmFubE1SVEZSTGd6ekp3RStRTWdNeFdaek5lL201V09HdU5k?=
 =?utf-8?B?ZGh6bXFZQmdldE9SOHltb2tOSXVzY0lYMEpxVytHQ0IxZnZoK1FydEFKbmZI?=
 =?utf-8?B?SnVyVjJEMFY3SGV0c1ExNUZrNEdqWnJybUN0ZTZtSmFmbTUyYWdKQllPc3J5?=
 =?utf-8?B?bFoycXJWeFExT29EY2Fha2dqcjFpNnlwai9sL1BkeGtOQ0ptbldWdkhEMWY2?=
 =?utf-8?B?cnVEUGFLQkhkYXhGZW9JQXBOYnVTN09BSXJWMElieWlFUW1vZHFMazhCaEFU?=
 =?utf-8?B?bDF1eE00K1Z1Y2VmbEtKWVU1ZkkwY014Q05kM3NZTFovQkNFTGI0ZWZ1RWUv?=
 =?utf-8?B?RHBwVEhkVTJDOUVzZmI2eWFtSFJMeGN6VUM5d3NDdWZESzFCR2NvcjJQb0NP?=
 =?utf-8?B?YXBXY1R1bzJ2Q1JjK1loSG5hMW40MVVobkp3WnBrcHpaV2xHZDhHZUtXem5m?=
 =?utf-8?B?aXhVcEFqWDd0d25NdDB0K0hSVWpOOG4wS1VPQkdzZndxMG41YlNycWF3Zi9B?=
 =?utf-8?B?MktaU0NYQS90a2lqUDltaGlXTVJmSlZva0hmUXlMQWo4d2U4eG1STlZ6cUht?=
 =?utf-8?B?ZnhjUW9LNlBnNHFvSm1jUUVhaW5mVjJRTHZ1VWNmWWF1NUhCcDJZd1JUWG9r?=
 =?utf-8?B?cjN4OHp3QWNnMi9vWE5vZlUvZXE5Sk93Wjg4VW5rcGFjbVlKYWs4Y0lvRXk4?=
 =?utf-8?B?YmhUc2RueEQydDJzcXQxaXEvMU5Zc0czSE5DM3Z2TmZtcjllMS9NNFMzZnF3?=
 =?utf-8?B?dzg2cWNqZ0Q5R0Nsb2FNQ1pjbi85VEg4Sm5EWjBEdWExNmJWMnJRZUxXdFZQ?=
 =?utf-8?B?Tk5WTTR1cXB4Sk12UVExeUpIR0VETE9kRkhGNzVhdnluUUkyN2MyREtUODR6?=
 =?utf-8?B?OHBHaWREL2dTSDdXT2JFeEZXVnk5a0dTRjg3WmV3emExaXNiRGZ6MEphbVEz?=
 =?utf-8?B?a1NsejdWcDd0Sm4yaVd2ZGl3dW0xZ1lsUTFTeFZqb1RqbWZZWDNKekNqVExU?=
 =?utf-8?B?TEFZT3E3YTlsZU9hN0syOFBZZ0gvQTdBU3Z2cU1QOXFYazJCcXl1eTlkZUhn?=
 =?utf-8?B?c1YvOE8zSTRwQUVTSEk1WjlqTEl3RFNQMVg3MTFKU0s2eVIzOFZGRVNBOVoy?=
 =?utf-8?Q?sQ0MvJ7IPpTMCgO3z2tiqHlod?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR18MB5847.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66e9ad8d-37f6-461a-a21b-08de156a2d59
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Oct 2025 15:04:50.4703
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZzCVGMYS2hvJsHmMs+Cb8Lh9d6jX0T/g24OGZO4rDcFrvawEK4ZjuT/f+bbK9yxKuEu+3jgJcOOmTuz+p/xILA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR18MB4441
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI3MDE0MCBTYWx0ZWRfX1rT/TxfD4ym0
 d7AbFfpOIEMp9sVZjNXNhRaEzc6zEaYUGy0ZJvgn5GqGXJS7rn4CPbzhULUb+fAgP28C2fpCS2H
 mYAQIfYUVrDImi7Gdq43qW3UTxHm3/HPY5rf1JwKhudjwJLT2N9R4ouOb1nW0eu4OxDdcz9K4In
 R+Tv9idXpVn4i2zaowGdXCqil56FIjDEaglBs8W6Asy5wrAtG3ML+sdAmBNDN2+jSzZvI9GTl1B
 QMcmjwhJ3nQQzQ/8atPyXkVBlG/vw9E4ZI/YeqmWADD8qmwJhwUKrF8IMgl915mMMOpMKE4XOcB
 62UqHEmXWZDtSrnfTtvIGeEjUDkDqM6xAoKvNs2E7lyJTntbQ1UMbIKGVBLVc0GxvDoSdiQK5fY
 mcX94dQH3GGK8EnW9InStiZBJ4ZVMw==
X-Authority-Analysis: v=2.4 cv=MthfKmae c=1 sm=1 tr=0 ts=68ff8a16 cx=c_pps
 a=YAKI/8xHzFBsvVJXN74WDg==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=x6icFKpwvdMA:10 a=-AAbraWEqlQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=pGLkceISAAAA:8 a=x3GDGfkQir6GRh3ZBosA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: RTCqwd6Ws3fhiiujD88PMHr41v5GvCaM
X-Proofpoint-GUID: RTCqwd6Ws3fhiiujD88PMHr41v5GvCaM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-27_06,2025-10-22_01,2025-03-28_01

RnJvbTogRG9uYWxkIEh1bnRlciA8ZG9uYWxkLmh1bnRlckBnbWFpbC5jb20+IA0KU3ViamVjdDog
W0VYVEVSTkFMXSBSZTogeW5sIG5ld2JpZSBxdWVzdGlvbg0KDQo+DQo+PiBCZWxvdyBpcyB0aGUg
ZnVsbCBvdXRwdXQuDQo+Pg0KPiA+IyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMj
IyMjIyMNCj4gPnJvb3RAbG9jYWxob3N0On4vbGludXgjIC4vdG9vbHMvbmV0L3lubC9weXlubC9j
bGkucHkgLS1zcGVjIERvY3VtZW50YXRpb24vbmV0bGluay9zcGVjcy9ldGh0b29sLnlhbWwgICAg
ICAgLS1kbyByaW5ncy1nZXQgICAgICAgLS1qc29uICd7ImhlYWRlciI6eyJkZXYtaW5kZXgiOiAx
OH19Jw0KPiA+ICBGaWxlICIuL3Rvb2xzL25ldC95bmwvcHl5bmwvY2xpLnB5IiwgbGluZSAyMw0K
PiA+ICAgIHJhaXNlIEV4Y2VwdGlvbihmIlNjaGVtYSBkaXJlY3Rvcnkge3NjaGVtYV9kaXJ9IGRv
ZXMgbm90IGV4aXN0IikNCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgXg0KPiA+IFN5bnRheEVycm9yOiBpbnZhbGlkIHN5
bnRheA0KPiA+ICMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIw0KDQo+SXMgdGhhdCBh
biBvbGQgcHl0aG9uIHRoYXQgZG9lc24ndCBoYXZlIGYtc3RyaW5nIHN1cHBvcnQsIG9yIHNvbWV0
aGluZz8NCj5DYW4geW91IHRlbGwgdXMgdGhlIHB5dGhvbiB2ZXJzaW9uIHlvdSBhcmUgdXNpbmc/
DQpCaW5nbyAhLiAgdXBncmFkZWQgcHl0aG9uIGFuZCBpdCB3b3Jrcy4gVGhhbmtzIGEgdG9uLg0K
DQo=

