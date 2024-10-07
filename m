Return-Path: <netdev+bounces-132640-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EDA1F9929BF
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 13:00:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E18D1F226F9
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 11:00:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CCAE1D14EF;
	Mon,  7 Oct 2024 10:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="KxrNe7Lw";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="vvi0j1ou"
X-Original-To: netdev@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBB6F189F45;
	Mon,  7 Oct 2024 10:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728298789; cv=fail; b=GKJH38CRC37JGnwfqXEbWhvf4sqaX0sDk7u3Xubh9QaTVlL+mkxWj9/KTP/mkQA8YWBeFlV182mX8FpXOiEAmNe+WZvjzsLvOo2gvvhGu6vwklZ/aREkugiN3MIUQOMjkiHYKQRb/c1JIBd+y7kDAT0sPqvOj3YfkYruDWZ+d8c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728298789; c=relaxed/simple;
	bh=tvXUMTOd2XNlguuxC6izFRhLs7LxOdmXpku30ncD4Tw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=YcezzmxOlEN8KAS5z9e53MLLyGw1/G2gnj2kD6/91C+7r6SLwGWSM4NrBEonctH6R6/zJqpqA9X7wCMYKxjtzQ66A8jmvJxefPHw7zu4U36/lH202bkq/YxIWrtABpU5GCFTNFdJQcPEfl2k9QDlA6wW0bp6roS71yGaynJYTpE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=KxrNe7Lw; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=vvi0j1ou; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 4197b556849b11efb66947d174671e26-20241007
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=tvXUMTOd2XNlguuxC6izFRhLs7LxOdmXpku30ncD4Tw=;
	b=KxrNe7Lw8SD6nSMUnnPbnwBWPVwiMJZpxUL1/mHJ+ALJ4AecKUJ5qPKFoXyvDWG2drfIzFgmNkX/nsyVSi8RjYamvgnCGxO33e0F5NB+Iqwd5fMVEU8E77UGb+IKrn5D3HOg5GnOB6ZlfF/H7JwGA35P+MF63qAaTAfHyHToqCY=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.41,REQID:c742c05a-5728-4d3c-bdad-ab0b693e5ccd,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6dc6a47,CLOUDID:65bedd64-444a-4b47-a99a-591ade3b04b2,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0|-5,EDM:-3,IP:ni
	l,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 4197b556849b11efb66947d174671e26-20241007
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
	(envelope-from <skylake.huang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1133566298; Mon, 07 Oct 2024 18:59:42 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 7 Oct 2024 18:59:41 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 7 Oct 2024 18:59:41 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iLX9xY7iRHWkVV5KW4LP1U0qKbpyI7ZF7O+4WE4T8EqzR8oeOzToLHEmfGXa4VRRMKkh979HBe8Pw9ZY5C+McwHXg7i12qhjBUlI6ImzDJz3cdk9JnGGmyERFX/eltBZ1KIi940Swfe0x9q0x67QyDCzJ31pehLEoeI2tj/Jg3MRoUNiePf4DeElDEYJgcQFYtcGOq5hboDpQ7xlczJGjMPksVetcRoYaqYLG5gcaHxSM8wHuw5mJCqs3AMAzSb7Bv7jkcWgaYbpsWmBnjjffMQWBYbHQFBy8V3eWG/TGR3Ls0F+GHHj8VxHBjnBjKOOpOYgxFpYydrPgnJsyoRJmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tvXUMTOd2XNlguuxC6izFRhLs7LxOdmXpku30ncD4Tw=;
 b=NI/D+Vpx8/x10B3q27Cyfdt1bGzUEsNLJSX7WyZNw/3mz6jPlh3z7VCt+j12GvH/6CAh3QrIKPCYNECriRYsqn04f+4ehjGgq0KwGJcdYILGUVHmR0l4aORwscH6SXBdP1tuYaKM1LAfmXscU9nHF0WbAOOurRZ1muQu4S6PvJ4np8ykegi9U088mvkMGBm1UziiUmp06/apivcfa84AYHTDS9X65nnORNpmSrF/KIthhqMw9JG0U6fQbnGz+IS6D7Ch3JR4kbKLu1CpQkNQ3oR3URSqIhKjJzUXc5+ZiFrpmHRL79AIBNkDqgQTT+iixzw/uPcuER22SRTWv5II3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tvXUMTOd2XNlguuxC6izFRhLs7LxOdmXpku30ncD4Tw=;
 b=vvi0j1ouNPYW3mwXfFR623GyzvamIwzXM0mJVWfRHou+4O+X0fhKP/TUOmYxIzLWyPIvxIEEb0grtE7t1W+FnqkW6JzHXhZwTNCHdjIzNBZzmggb4XACYpCblB2boeDlt6gmFzFQh3fbk+HXkQdFnbhP7LZRXERlelmNgsa1jPY=
Received: from KL1PR03MB6226.apcprd03.prod.outlook.com (2603:1096:820:8c::14)
 by SEYPR03MB7843.apcprd03.prod.outlook.com (2603:1096:101:166::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.22; Mon, 7 Oct
 2024 10:59:39 +0000
Received: from KL1PR03MB6226.apcprd03.prod.outlook.com
 ([fe80::f3:c11:8422:7ce3]) by KL1PR03MB6226.apcprd03.prod.outlook.com
 ([fe80::f3:c11:8422:7ce3%4]) with mapi id 15.20.8026.020; Mon, 7 Oct 2024
 10:59:38 +0000
From: =?utf-8?B?U2t5TGFrZSBIdWFuZyAo6buD5ZWf5r6kKQ==?=
	<SkyLake.Huang@mediatek.com>
To: "kuba@kernel.org" <kuba@kernel.org>
CC: "andrew@lunn.ch" <andrew@lunn.ch>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-mediatek@lists.infradead.org"
	<linux-mediatek@lists.infradead.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux@armlinux.org.uk"
	<linux@armlinux.org.uk>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"edumazet@google.com" <edumazet@google.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "dqfext@gmail.com" <dqfext@gmail.com>,
	=?utf-8?B?U3RldmVuIExpdSAo5YqJ5Lq66LGqKQ==?= <steven.liu@mediatek.com>,
	"matthias.bgg@gmail.com" <matthias.bgg@gmail.com>, "davem@davemloft.net"
	<davem@davemloft.net>, "hkallweit1@gmail.com" <hkallweit1@gmail.com>,
	"daniel@makrotopia.org" <daniel@makrotopia.org>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH net-next 0/9] net: phy: mediatek: Introduce mtk-phy-lib
 which integrates common part of MediaTek's internal ethernet PHYs
Thread-Topic: [PATCH net-next 0/9] net: phy: mediatek: Introduce mtk-phy-lib
 which integrates common part of MediaTek's internal ethernet PHYs
Thread-Index: AQHbFkeVNI5C8hKlM0iV2xqX30Her7J3MPgAgAPyeIA=
Date: Mon, 7 Oct 2024 10:59:38 +0000
Message-ID: <c40a80ee0cc5cb54018ca0d19c35bb0c0889f9cb.camel@mediatek.com>
References: <20241004102413.5838-1-SkyLake.Huang@mediatek.com>
	 <20241004154300.69b30a98@kernel.org>
In-Reply-To: <20241004154300.69b30a98@kernel.org>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR03MB6226:EE_|SEYPR03MB7843:EE_
x-ms-office365-filtering-correlation-id: db77561c-26f8-4992-2bad-08dce6bf235b
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7416014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?WTBFUnFxWUdlR2lUbzMva2hXVU4wbnN3NTBxczA2c0hqV3BVa3Jtb0FxMURy?=
 =?utf-8?B?UjdvMEQxWndTUDVXeHhzVE9qMGZ0QVNkQU05dU8xSDRFK29iMTNqd2hxY2xY?=
 =?utf-8?B?TFAyelUzbmZlVG43V1JsUlErRG5WSUxEcFo2UnBVdDdhYjNqTzZEbVA4VTFY?=
 =?utf-8?B?d093aThNb3JmWU42NS9kaVh4Q2JFM1o2eW8wVExEdEZFUU5lQ0QxaExRRFVX?=
 =?utf-8?B?eWVQYU1aS09GQ1N4N0pncTAvZWdpenpVSWxORGNHL2hIVVFkTVNzU2FYTGVC?=
 =?utf-8?B?cEZiN2ppTS9LMXVmWmxLNXlQQnlhcXdLRzVTNHdxWnR2MnR6bUJnQlRrYWtJ?=
 =?utf-8?B?NXRxaHRjQzkyb0tKWFRCNUZURnFiNHFCbUIrUTU5RUVYaEp4bjFZSFJWeVhl?=
 =?utf-8?B?K041QXBtL25RL1ltUGVGb0hMZW9QUnFEaWJnMXBucnI4ZDN2cHZFcEdzRDM0?=
 =?utf-8?B?WjE5RjNSUUlYQ2MwYyttQVdleUs2SENvRDkyUXkzaS9ITUxLSXVoZ0ZjYkcw?=
 =?utf-8?B?R3VMTW9RZ2xPZDF1R1RZUEJ4VFYyTWxvaVpzcE12MFgzSkh5dzBSaXo5N1Vw?=
 =?utf-8?B?aUpXNUwyTENNejhndnBacnY5YmhFVUlVU2FIVTRra2lKbzRYeEVnT2JQcVli?=
 =?utf-8?B?YnBCZDZvVnErOFhWTCtjZU9zODUyVFNOM2xXdnlPQUVsZS94NWVBcklqdUM0?=
 =?utf-8?B?R3BhbCtKY1NNdmw1VUhRdXI3ZXVhUFlndFZuejBtcVp1RmF0Vi8vZVJrT2l3?=
 =?utf-8?B?SlFFQ2JORUUwMmp6WWdicVNmMksrWWJhWDdqLzUrOUZnQlVqOFhmVW9zb0hN?=
 =?utf-8?B?RDNvbUw4RHd6ZlNCd1o3OWRMRzY4SzNGNlhlM2ZMRVVBVk8vYWlwODYzUElz?=
 =?utf-8?B?aVlrM0dJSGZOZW1Zcm5Ob1p0aFp2aGxKUU9XUkRwZXdtWWVOUmVXOEdZTVJV?=
 =?utf-8?B?NEtTa2dnSkFWNU1nZ2NaeUdvYVFvTjh5SzhxWmFTWGZmUXNsWEtzZlhWUUJm?=
 =?utf-8?B?YlFKY3lIcHRVQ01SSkxkT29RZWUvR0h6TDNvcUoxNFJtRUdlV0g4S3ArOGNQ?=
 =?utf-8?B?emhQL0R3bFJ5Y3Z6VVZBRldPcGtxTlUzaTVtVUZ2T2tXZFREdDlpbUNUd0VT?=
 =?utf-8?B?SWpxYjZJblVCVUJHUFlVRmg2b1VucURERHNPUjljUDc2NGR1c29VUHNZUjZm?=
 =?utf-8?B?bnMvMlBUMFVxME5LQjViMDRRcTVRQ2ZiQjllaE5abW1Wb09VOC9iYTI4ZEUx?=
 =?utf-8?B?Y216SFBhcjdtL294SDRWa0Zocm1raVRuNUtDV3pUN3huSzRhZzN2Sk0vMjBz?=
 =?utf-8?B?aHpmM2twd2VZK0FmZVNTWlo1NU0wdHd6VXJrWjZHTkN2YVlpeDk5WUovTzN6?=
 =?utf-8?B?VGt6YkFJd0MzSTB1RFQzbVJ6eUQ4dUErYmNUeDhBaTB1dWhXSU9TWUNIUEwy?=
 =?utf-8?B?b3ZadHJxZStFb1VsbjZHSWlDMUlBRVJ4QlU5eXV3VnF1U1JaVkNHUW9FQzlK?=
 =?utf-8?B?OFE4UGwyRU9FcTZrbmhJVDdEbDZxSWZWMnRGSlZwdEFRdWxMdC9nKytON1Bt?=
 =?utf-8?B?WUNjSTJjTi8vMmQ3d09ObGsyTTFhaElUL2Q2aFhMdkxYV3EvSnhjWVFQODlp?=
 =?utf-8?B?VU1mN1oyY3UxdjJoMmRqa0JDRkhPSGhOSzVLcisydTNZS1F3VHlpeWJ4YUI4?=
 =?utf-8?B?bE1rZnVLZGVVeW5QWFZrOXY4WkVuNjRwQkthbyt6WXROL05vTTI3MDlsYlBa?=
 =?utf-8?B?cHRsRHhvSmRrdmtmQTZMTTJNcDlZK0Foa0tKZGNMNHlha3FaUzlmeFZNVlhJ?=
 =?utf-8?B?WHB5TVlMaFdYNm1sbnkxQT09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR03MB6226.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cFlVUXROOHluYnRjNU9ocDlZVkZKZGxqZCtUWUNTT3ZJWElZWFZqVnhCYklK?=
 =?utf-8?B?RXI0Tkk1SC8zMS9iTUVuNTBjRDNrcWxOQ2VHTHNIT3BNcVhnQ2d5VllnWDJP?=
 =?utf-8?B?OTM3OG1MakY4d1ZDcllHbGFrNVdKWlZOWDd1bGFMRkdYaFVKTnk5dWJ1c0Z0?=
 =?utf-8?B?VzdobHJQWVVuV0lsYXFuSE1mcVZvb0FXNGM0SW5vR21EWkx1emxrZDA5NmUv?=
 =?utf-8?B?T1R3SjE0OGZpK3dqZDVTbGlXT2ZmeTNTWGV3UnpiL3JxOXRNQ2xCNExBQ1BG?=
 =?utf-8?B?RExVSTRsTUE0YlN4Q0l3VFdFci95ck5VSktJV3ZVRXhZWHNOb2I4ZGY0SUd3?=
 =?utf-8?B?ZGhhaXNoQ1ZmamNmRDN1WTJPYXNENUhRNXFJNjd4d2hmbXVRU08zU3JKTXJq?=
 =?utf-8?B?OGw3U1lQSFFMaHhFUURUM1psOEszaURYNEZZTFBrdlRkNXVON1BGUE50cFRC?=
 =?utf-8?B?SnBReHJybG1STXNQY0R1TnFDQjI1ZkJqVEZwVkJJMnBkdVZUOS9iMUI2b2Uy?=
 =?utf-8?B?TDNzSUthYUREa0VPcVJaOHBFRHhCdVBVVkVQRDc3eEM4bnNvSVJieUdtQjZE?=
 =?utf-8?B?bmllZjYrTVh1NzBFWFlCeWJnZ0RIMXdDeGtGeVN4UkZaM1hrY0c3YXROSUZY?=
 =?utf-8?B?a2J4cXdXdy9LNWZLUTRXaTRMaVB6bVVuRy9INmNSR0tHRlo5ZVpQZUc0bURM?=
 =?utf-8?B?TkVoTFJOT0hFb0R5Y040d1o5NlllVGlQL0JSSTZuTk12d1F5bWhRUjFWTXI3?=
 =?utf-8?B?LzlyOVNaWGJzdmpzcllXN1NHL3ZsdlhYQ2Y0S2tVRHFmRmlITjZSTXZhcWlQ?=
 =?utf-8?B?WkJyczgvWjBxSUpsMHpTOGUyMDRvSjF3TzJxTXlUU1RielNhK2EvckhIUjV2?=
 =?utf-8?B?eEpNZjZ6ZjdjajZ4UDMyQi96YTJJL24xUi9aaTRPR1pZZFZTdFQ3WVJLanpD?=
 =?utf-8?B?eUNzVHpUdTN0SzJRcU1WWnNyWHY2bVlUcW90SW5adFBIYlhLWi9TNGYrZVI4?=
 =?utf-8?B?VFBSMEtab0lSWGdyakIvSXIrZGg2OWFRVFA0NFVRaEVHUFBpK0p1Um1HQ252?=
 =?utf-8?B?b3ZJaGozejM2UTRpelRiam0vMEJPSEZHSE9UWjBiKzNaUTUycVVBS0t4alhL?=
 =?utf-8?B?UEg4UVFyeGNiSmNRSVZQQytEL2hYT3RkdEI2QkJ5THRlS3BtN2xRTm1Ma1Rv?=
 =?utf-8?B?NlUvRG1GS3hRTGJ2OFBObDFKSXhIL3Y0QVZZdWtkL2dmSC9GYitXNm16UDRH?=
 =?utf-8?B?bmEycTRRdGdSYjdwdjFqWTlFajVvamd2SUJHL1ROZmtIN1U5MHRXWEZ2a0sx?=
 =?utf-8?B?bEwzeFJxeEhUamwxbS81enl0bDM3Y0lhMFpZN0k4NWk4ODRzbk81REdheFNE?=
 =?utf-8?B?aUxJcStUVWFZOEYxa2ZuWGJPVUQ1Z3FHVWlCN3htdmtydW9yUmdmRDc0QUZm?=
 =?utf-8?B?WnVlejRPWGt1UnU3WXU3Y2duVUcvbGo5QTBCWEE3ZlArN1Q0cmFtUnZKYTNa?=
 =?utf-8?B?L0tMRG92VnBKMjRJNDVWdzFLdVg0MVlLbXdDbWppZjB0dkZrZTJXaG4rWnV3?=
 =?utf-8?B?S05DQ3M3SGN4YUhYOWlOaDBrY2ptMW16clVZT1ZPRmdiOU9NN0YyZWk2c3RN?=
 =?utf-8?B?b1YrQ0JaaFR0Qk1wanV0dThPalo3SnZURVFwVFFzeHo2WVY2a3hwYW1XUG90?=
 =?utf-8?B?M1NDL1lLejAzdGVaazJVMVV6Wk9hQVV1Ym0wSHZob1ZPdDVCbkwwZE1kZmln?=
 =?utf-8?B?V0w4YkdCTDVaM3NRdmtiZ2YvMkdOdi9MTUtzN3ozODU1OVA4c2pBY1k1SGZ1?=
 =?utf-8?B?SzdOUmZrdVRCWHBPTUo3MUtrQUhlbjZyTE55OW05R2k5Zi9PU2JJeTFlZFNJ?=
 =?utf-8?B?TG1nZUZRcjBxSHFIYkJWTzJ2NjNOMVJ3cVo3b0xTQmV4aGl5c3Z4LzRxelFW?=
 =?utf-8?B?K0pvY3RGeFJuL1B5QXMrL3JPbzhyWWljbVBkMzBEQjY1ZW1CN2tnYkMvbUt1?=
 =?utf-8?B?YVNJMDZ0cHp0Z3VtSkJOQmsyd2tCMFlLVHE5Y3hCNmZYeTlxak50SklkcDIv?=
 =?utf-8?B?THFsYWs2ZXZjQzFRbVJLZ3RqeHNIL0RGYWNXR0dRb0FXa2gxSC8xS3hyd3B5?=
 =?utf-8?B?d09OTDlIZTdoK1NKKys0QTRiMmRieHZGZS9xNEV0ejJQYXRGa1NmcTArWDdp?=
 =?utf-8?B?R1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <18FF3C9A5D5FB34590E5A6F0AD14F0CB@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR03MB6226.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db77561c-26f8-4992-2bad-08dce6bf235b
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Oct 2024 10:59:38.5975
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4pEmJWAbK/hK/Z8YnSzTHHXwND+/px9eTECAPr5MaRz1sMjyBjDpCh+18LMOJi82L2o4ll/xYwh0l1MNHNwvI/sgrofoQ4s1bqgS4h/vxDQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR03MB7843

T24gRnJpLCAyMDI0LTEwLTA0IGF0IDE1OjQzIC0wNzAwLCBKYWt1YiBLaWNpbnNraSB3cm90ZToN
Cj4gIAkgDQo+IEV4dGVybmFsIGVtYWlsIDogUGxlYXNlIGRvIG5vdCBjbGljayBsaW5rcyBvciBv
cGVuIGF0dGFjaG1lbnRzIHVudGlsDQo+IHlvdSBoYXZlIHZlcmlmaWVkIHRoZSBzZW5kZXIgb3Ig
dGhlIGNvbnRlbnQuDQo+ICBPbiBGcmksIDQgT2N0IDIwMjQgMTg6MjQ6MDQgKzA4MDAgU2t5IEh1
YW5nIHdyb3RlOg0KPiA+IFN1YmplY3Q6IFtQQVRDSCBuZXQtbmV4dCAwLzldIG5ldDogcGh5OiBt
ZWRpYXRlazogSW50cm9kdWNlIG10ay0NCj4gcGh5LWxpYiB3aGljaCBpbnRlZ3JhdGVzIGNvbW1v
biBwYXJ0IG9mIE1lZGlhVGVrJ3MgaW50ZXJuYWwgZXRoZXJuZXQNCj4gUEhZcw0KPiANCj4gV2hl
biB5b3UgcmVwb3N0IHBsZWFzZSBzaG9ydGVuIHRoaXMgc3ViamVjdC4NCg0KSSdsbCBjaGFuZ2Ug
aXQgdG8gIm5ldDogcGh5OiBtZWRpYXRlazogSW50cm9kdWNlIG10ay1waHktbGliIGZvcg0KTVQ3
NTMxL01UNzk4MS9NVDc5ODgiDQoNCkJScywNClNreQ0K

