Return-Path: <netdev+bounces-247566-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B100CFBC97
	for <lists+netdev@lfdr.de>; Wed, 07 Jan 2026 03:58:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 54CEB30021FA
	for <lists+netdev@lfdr.de>; Wed,  7 Jan 2026 02:58:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A71242139C9;
	Wed,  7 Jan 2026 02:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="hMWq6vsW";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="WODI+5zI"
X-Original-To: netdev@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9931963B9;
	Wed,  7 Jan 2026 02:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767754690; cv=fail; b=Yg4apebUD9/y2zz0s5HHdMCgSNKSXiS42hJw6dTdnoPhUIawT4UspEPg7AuSds40jHPhUUo3dM8FLASzp1gAUi8kxyJax8M/YV0ly6tvMw+mfiO/QDRRUhKf5nxPdYxwfqr4UXotc3p9an6pCZyQgZk3YmDlP7/bUT7ae+ot8/Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767754690; c=relaxed/simple;
	bh=Ua+ZSVwUc6dLIa7EU65xqWYhpak98jCOVARUVyUl2BI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qU6H/cRJv7f3a7n5u0ZFSy6mIdhZDPtvoXH7BEsIMtW+2W+1MBk4R9PD6r0Tm5MPwpeq1r0kuPwhHIFE9fBXPQ5mmaxhXWysDSyCP/lY6T+a8tsyuCxZE+ML9Y2+htIel0pfINPoDq9pdrkd8hGO+NzeCGGWoSrUb4wJMOpoLTI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=hMWq6vsW; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=WODI+5zI; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: acbf1b9eeb7411f0942a039f3f28ce95-20260107
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=Ua+ZSVwUc6dLIa7EU65xqWYhpak98jCOVARUVyUl2BI=;
	b=hMWq6vsWKjA/g0CXkZvtklImh941bvGVR4tdrMWCO25stT/npfILVHsD4ETPJ65DC5D/V/FMokx6HYoHxEBX1uyT6YkGfUPxq7ueAnoeRJOMbts/fMz8/KjyyCvB7cMQh4omcMOacVUF3IygXOfWcrVs3WlGYg0IeWUU5r8nkFQ=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.9,REQID:f18a1495-871d-4c9e-a99d-dc4a23f26824,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:5047765,CLOUDID:5c744f29-e3a2-4f78-a442-8c73c4eb9e9d,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|110|111|836|888|898,
	TC:-5,Content:0|15|50,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BE
	C:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: acbf1b9eeb7411f0942a039f3f28ce95-20260107
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw01.mediatek.com
	(envelope-from <shiming.cheng@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1777377521; Wed, 07 Jan 2026 10:57:59 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Wed, 7 Jan 2026 10:57:58 +0800
Received: from SG2PR04CU010.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Wed, 7 Jan 2026 10:57:58 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p48DZqGtkU+6KXBlf7qHb1lo/b4pLPK9cf+iqB72Dx7F1Jq5aMRZ8FRUNbkQr4gbUxW+H465KY/lPEA98alBZkR+FjW05KztY5yc+CnIDgix7XfyuqEsUM3JqcflXA2/TGFKNEBIU9TDZGpdTPd3SMZPt4MpcbXyYkggO1hIpsf6xGYWD5ZKk/05cdYXaMiKtFSrbt2hXe+1Eel3sY6VOl9RhlFfN7JSPHPrim5YqGiaoJ52oGcO/xeoLMc3/loWsYQq7RrO0oBlewp3ru2hAwYVgLeVNe9z9X1sNUBGqw1qvDIyxE/pnA5ioZk1lMzNs/aPBb8M3FSg4rrqI3ZxTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ua+ZSVwUc6dLIa7EU65xqWYhpak98jCOVARUVyUl2BI=;
 b=QfzYqGM0XH1F/M0fEMR9ycxu7k5uFljKVp+V4t0g4+yx0+ILtwZkoBSEzU+46KvT728cynEI9tlFqYCTaKzUCGCe9pUv5+TVOI03GuB0d/9e8u0LgpaMyi4IpUs7YnN9wu0GbpsyOfUZYtfO1IphAsqKQVth52sDf+zWaFAVs/DkkP6ZKRU2Ba48NhfpFxH2eg4zDS1FS3bi58O8uu9cSp8j9hBy+yljfatnCxi37YcHXg12fi4KVGVIy0dws/9Y3P5ei6DJMGDBlV3ZW/zBRWz5R9MtFsjf5xUaSZ2tznbbS7olc1IjHvTGkX/UiQqF/4tVBmBiwnkvFnIK5HK04A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ua+ZSVwUc6dLIa7EU65xqWYhpak98jCOVARUVyUl2BI=;
 b=WODI+5zIqSJHLrcYQcp5TDjMDqI1AyB+beN2x4l6a2BpuheR5YIX0E5GBHAn0pvWnzps2uo0pmNg4dM7isPGBpY8WEP29R2bm2bUslmSfJ8uVMEJ1N+eM48f68n2FZtlDYtKVie/PhaRzVfbYsgNTVEvbOtY2rETgB3iQ1V+tWQ=
Received: from PSAPR03MB5622.apcprd03.prod.outlook.com (2603:1096:301:62::11)
 by SEZPR03MB7898.apcprd03.prod.outlook.com (2603:1096:101:182::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Wed, 7 Jan
 2026 02:57:53 +0000
Received: from PSAPR03MB5622.apcprd03.prod.outlook.com
 ([fe80::b639:3572:f154:28d0]) by PSAPR03MB5622.apcprd03.prod.outlook.com
 ([fe80::b639:3572:f154:28d0%6]) with mapi id 15.20.9499.002; Wed, 7 Jan 2026
 02:57:53 +0000
From: =?utf-8?B?U2hpbWluZyBDaGVuZyAo5oiQ6K+X5piOKQ==?=
	<Shiming.Cheng@mediatek.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"kuba@kernel.org" <kuba@kernel.org>, "willemb@google.com"
	<willemb@google.com>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"willemdebruijn.kernel@gmail.com" <willemdebruijn.kernel@gmail.com>,
	"edumazet@google.com" <edumazet@google.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
	"davem@davemloft.net" <davem@davemloft.net>
CC: =?utf-8?B?TGVuYSBXYW5nICjnjovlqJwp?= <Lena.Wang@mediatek.com>
Subject: Re: [PATCH] net: fix udp gso skb_segment after pull from frag_list
Thread-Topic: [PATCH] net: fix udp gso skb_segment after pull from frag_list
Thread-Index: AQHcfrB9VATjsuD+pEaW3WvjKBAl97VFhDgAgACBOYA=
Date: Wed, 7 Jan 2026 02:57:52 +0000
Message-ID: <1f232ad5c879a30ac94586a56a387d9d48a95765.camel@mediatek.com>
References: <20260106020208.7520-1-shiming.cheng@mediatek.com>
	 <willemdebruijn.kernel.f3b2fe8186f4@gmail.com>
In-Reply-To: <willemdebruijn.kernel.f3b2fe8186f4@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PSAPR03MB5622:EE_|SEZPR03MB7898:EE_
x-ms-office365-filtering-correlation-id: 16323fb2-b012-4a5c-400f-08de4d988d0f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?SlV4UUFBUm1vT0E1SVhOOEFDdWRxQzBScjR5WlJzb0ZvRWxUWjdpblI4a0ho?=
 =?utf-8?B?MnZ2NkNuS3ltTU81aFVTU1JPRHFpNVFFVTg0RVlrMGEwOTk5cThReHR3WER6?=
 =?utf-8?B?SzY1OTJxeEw3THRxWUhRYSt6ZU9Uak56bjVUZXZhRGRFYmYveUNPWExhWE9a?=
 =?utf-8?B?UkI3ZkF6Wkg0RzlWekdlcHBJS3RBSElYVXlBa1lqcy83aUk4K0ZJR2ZaNUlY?=
 =?utf-8?B?cXJCbGg2ZWlla0JFM3U5c1lTS0FNQk4rRS9JK2xNZWlGMVRMNDY3OER1SUNi?=
 =?utf-8?B?UThOYjRQYW85c3hUb3h5eHEybTdTV0g0R0JVdkp0TEpWK3N5STd5TldrYkNo?=
 =?utf-8?B?MEtXZ0djaU50R0VuQ3lnYXNyR1pkM3hCUGFYZEgyZHlvZ0twRzA5YkVmT245?=
 =?utf-8?B?K0FCaDlTSXc5bklDQVYreHltUDVUQjhOUFJsZFlyWFhCRmRxRUxnNU9rWmtu?=
 =?utf-8?B?L0pZSjRQdVVvNkw2Mmd3RXl2S3JLaGtqbnpYVFVTa0NKbXBuOGxNYWhCbjNi?=
 =?utf-8?B?cTh3RFlsZGRsbEx5dGloNE9heTc2QW03K01RL25jSXJlSFplb1FORmhjaTFT?=
 =?utf-8?B?bjZhYmFvL0laaEpScnJudXhDWEdmZ2hEbkdMUm5aZSsvdnhDemVOa2Y2QmJm?=
 =?utf-8?B?b0dseWxZVkIwNFNFZ1NqYWxJOVg3NHYreEJDS0NMTEF4bjA4MFBDSE9PMnRP?=
 =?utf-8?B?dVBWb3pHWlZkOVArTkF1bFpSNVhBNFFNcHJOWFRPSkJVRkUwQnByRUw0U0lH?=
 =?utf-8?B?RkZvcklsdmtkMFhQOW5tV0hGTnFEOHdtQmVyUkhyTjJvNWIwRkJwUzc4UUkv?=
 =?utf-8?B?K1RadTd1bEtaQkNMS2QvekdaM0cxbE82YmozOVhDVTdXK096VGNzWmpwV1RY?=
 =?utf-8?B?NUJhM2h2T0NNc2UzNisrTzhPRzhwU3Vjai9SR1A0ZFE1eXVMOHNoMXRPaGE4?=
 =?utf-8?B?ZjgwUzZTVWNmWFFQUVF2QUwwRnF5ZTVkVXh5ZnhQMStaWjRRckxETGllSkRC?=
 =?utf-8?B?aGh5bDhKaDJhWllGdExNaURFS0tPb1ZVd0U5M1QybEV5ZHNxTXM3R0N1enpv?=
 =?utf-8?B?cVNqMFVTVnFTOGtUWGFSQ0o5QTJHZzZuOGZCSkp4ajVvWGhhaWVwYXVtMU51?=
 =?utf-8?B?UHd4Tnd1VnRvbEhiRGo3YXdLMUtGZXZJcHk0d0xaaXFjNkJIbzk2MFlabXRl?=
 =?utf-8?B?SmdQYlhpMnU5T1B1SWtzSTdaWFpac05DQ2l5eFQ1VXBPWFVHQmtVYWE0RDFu?=
 =?utf-8?B?bW9JNE1zVW5Bc0dTY0lUcmhvNENpV3kvbTV0WWVvVklXLzIybGtRSmxybm1Q?=
 =?utf-8?B?YnFVTWdhR3dXNFNFZGpIMk1pSk0rSlJWKzVrRjJtUUhyUjV2VzhMWEVxaUFH?=
 =?utf-8?B?UnppaW92NDJwNHE3QnprcDdmRW9CN2k3STV0aXg1b1RYajVZUHlEUUQvSmpJ?=
 =?utf-8?B?d0JOYkE2bzhnQm9vWVFtQktQSjN1RjlaekpTaXpOUXZXSkcyUS9pa3NYL3hJ?=
 =?utf-8?B?dUhzdTRwRHJEOTk1Z2tPcjdtdzhFaGI5ZGs5Y2IvZDVSZm5RT1k4MXdLcEtk?=
 =?utf-8?B?c2xMTkFsZXlYWnFBVmQzOWtWSXlSMmd6UlF4NTBVZFowWVg2U0VUb0xlTmJk?=
 =?utf-8?B?RmczY1JhTzNuTG96UlJJcDk3RmR0NHI2TGxyMExtT0JkcHN5Zjd1Q05idzhx?=
 =?utf-8?B?UEQxQ0F6UHhoRFRWOFRmU3ZKOW1id1krdEtnS09jdUphL1BVcTFhT2kxVHlX?=
 =?utf-8?B?cmhNOE9MRFJWZHErNWZvODVpSytkazJhQ013YWtSeXhYQ016R2F2dlRPVEdV?=
 =?utf-8?B?VEJWVXRDMHVoSUcxcVFXRkUzU1hhdE5xZk55SWpTZmk5UEx5OVFWN1pNbU13?=
 =?utf-8?B?TDFhekFRR3dKQ01tQ012WWl4U1FyK3c4ZHp3SWxpTlpmeWtzSWpCWkFYYzl4?=
 =?utf-8?B?U2J4Z0dFRVBqOFovV2lJc3V5MjBuUGFtRkFsMXY2bTFoTmFmQkNqNWhvRkVL?=
 =?utf-8?B?ZlBYNjJLQWpPb3NTZWxZSmJVdmRJaGs2QSs3YXJrTWhqeFVIN2N1UHpxenR3?=
 =?utf-8?Q?MjfHBp?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PSAPR03MB5622.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aXVxNDZEZnhoNUlTVWFRMTZnMVY3V0dBcnJ3VTZ4U1V3YWlMeFVlSisyUHdl?=
 =?utf-8?B?NkJ2TlZMQVBCb0owYTI1TFdvZlczcVRkcXNpak9ISmtOSTJvMXRRYWdYeWYx?=
 =?utf-8?B?ZVRseDNsK1FZdlE2S0x1QlJ0OGl1Q3l3bEFVbDJtOVhhcWtwR09pT05vTW9Y?=
 =?utf-8?B?NmZOWWNKaWp3c3BFd2ZYWERkS0ZXaS9tMitIUk5SMFlYWXAyWGtEbXZvWVND?=
 =?utf-8?B?RU4xTVZDUTlGd2llUmUyQjQ2OVZMa3VBSG5SZ0NJdHNjcE0vYkJFSWNYR2hY?=
 =?utf-8?B?S3R4M2ZLZmVGWGZHQnRIT1RGL1RnRXRLNXVxVGV5SmRQa0ZZSjZyVGtmbDRT?=
 =?utf-8?B?U3ZhVFFsM1dHckFQVUQ1NDE4ek9RY0d1S1U5TVA1MmliZnJFUWhpQ2NlTVE1?=
 =?utf-8?B?cTJJUC9qdHdzalpYR0ZYYWhaYThKWFhjMUFVOUdqOVppc1lMcnptekpiZnVz?=
 =?utf-8?B?QzNOMmRyUmxkSUh3bm9qMkE3c1FXZWttdHdQUXFqbGtoTmp1d0Z6K3pxYm9v?=
 =?utf-8?B?Z2t5WXFLaS94TTdwRXBBNklORGJvWEcvSTNjd1YrbFFPa3hyNTd2ajIyNTFu?=
 =?utf-8?B?TTlLWE5vUHF0SHVTcmZyczNZa3k3VjFxK0o4RFJLdnZhTVNBR3BESDNRQTd5?=
 =?utf-8?B?T1J5UzJTRHIxSHg2MGhoT3U3RmYxVnl1U0JoUm1oSWZ4VWhJL1BpMTFyMmdO?=
 =?utf-8?B?c0N6ZStBT1V3TTFiWGpqemtzMGhwUlFLamVHblBoS2Jib1krZG5HTW5OY2I2?=
 =?utf-8?B?NFNBR0VqRGVQRG04bEQrOU4yTy9tM2xkNzZEZmdJOWdtN29jNS9OT3lWYTJx?=
 =?utf-8?B?ZzVRSU4zb1NId0NpQjNYOWY1bFAwQUNMWVc3SURQY2hrWk5nR1Z0RTRLTURn?=
 =?utf-8?B?MEhvVmpqK0RNWkxWUVpHZUl4NkptWnUvL0MwbHNqSXJRT3pOelFJc2gvZEcz?=
 =?utf-8?B?V2dWOEQ5dit0bEY4cnFSMTJlREduNHVXTkkrQ0FqVWI3T0owcWJoVTl1SXRS?=
 =?utf-8?B?ZlZoUFR0Qld6REt5cmhvcEdRSGdMd3l3Z0FZYUxnM3EvN2pwMHQrSkp1N1lV?=
 =?utf-8?B?bVJkS1YrM09vL3p2U1RpeXBMS1V0WXp2a2toTlp0cG5wMW04ZWFidVRUQ0N3?=
 =?utf-8?B?dWF3MVduRHFYZm05cDJFeGw5Qm5hRWVidWxIdHpBanY3Q0Q1eWFvTFlZelBi?=
 =?utf-8?B?NjRoL0tXZEs4OFVYM3RWUWhudUhFSmJkOHlqNHVBSUM1YkMrY2xyNzZ2dlV5?=
 =?utf-8?B?WmIwWjRNcEJlVDE2ZG0rK2pOSkIycmVqZjZ4TWE4L1pGTnVjSG9BWkhNTUIr?=
 =?utf-8?B?TTJJRWk0UDRGaDBncWdsQ3JrbExOQTJ1VVI2ZjJhNzA0b2ZESkl6UURpV2pE?=
 =?utf-8?B?dTlTSU02d2NUcjAvOGlZSlhoc2lpQ2xJNmhzeEVNcWd1WmFGaFdtMTkyRW5p?=
 =?utf-8?B?SStlWStoQzVIeTVDTmNuYndUZzlmQ3owRFMzbEh6UGNwYUFNMmVTQmFNaVMy?=
 =?utf-8?B?dkRSR3dDNjFIVitwUkoxdHhybW1vcyt2dk5sdEZHREJOZzBWWDljSDh6Rk1T?=
 =?utf-8?B?SFV6Z2p6bEhnWlpZdUpUY0hJVGZ4SHZ5eDBLSDM5anNDVEloamRMV3VBVnA5?=
 =?utf-8?B?SWhOeDFQWFdUVitQVjQzaDhIU3JJTTlUbm9NNU52QW5kTm12N1B1MG1jRGc5?=
 =?utf-8?B?NnVaNkpPMVpvMTl5SnltSEdnZGlWU0ZQVm80V21MUXV0S1lHTVFQQkEwNC9T?=
 =?utf-8?B?aFNqVTE1WE1Cem1lTTI4dGRJSlQxQTNjR0F1RkNEV0dqRkc2ejJzREhKcE94?=
 =?utf-8?B?RW85ZFo3UXkxcERZMmd0bFRNdmZQTThoZUtCekZIMHNlczRtUzF3QVB0ZWR0?=
 =?utf-8?B?SHQybklISGZDaEV1RHRPZXltYStROEJWMk4yYWhidUljV3dTNGptR1NBdUZ1?=
 =?utf-8?B?cm5KMFFTM2ozT2hWS2ZQQjFNU1NIMGE5eHpSUFRkaVdFcFAwTzVTRTRuT0ZP?=
 =?utf-8?B?LzdydFhkcW5Takx2akkrRk9vU3NaZ0o3cUUrMjQzcXl2bXFKbDV3bDVXS1lS?=
 =?utf-8?B?VVVZTE9hT01DTTYzd0dCZm9zc3d3cVNjc1Uzb2lGWDNCbjNiRFRrUy9mTWtO?=
 =?utf-8?B?TlZFRFpXemNvalBmSmlla1BjS0RUV0dqbG5INjFGN0MwcGRFaUROZ21uVnN1?=
 =?utf-8?B?YTJhZlFweEFWZ0NmR2ZxU0xoaTdWVndkUE1vRXcrZEVBc01RdmVtbDM4WDc1?=
 =?utf-8?B?MHljN3l4cmJSOHVPYTdYcTlKaEcvNmNLckJDOFcwTWJDTW1rVGtwZWtYdC9W?=
 =?utf-8?B?byt4RUM2VmdUd0RkcVdreEhMYjhJQjlEWUhLMlQvSEZ2RUw2WlNCajFEeE0w?=
 =?utf-8?Q?8JlidiuSk5ukRaL8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3E59F4C1655498409D2D2C68595D09DC@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PSAPR03MB5622.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16323fb2-b012-4a5c-400f-08de4d988d0f
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jan 2026 02:57:52.9672
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ymyKqFe2fqJS5TFCghsHNJfuGMtrSTVV/dhsnr4jPbSH2zg8/mkB9d+UbKxYSmoZqe4u7YXAVlfjSZl+F0ShpWY4T5xtHuWpbbAyYHAciao=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR03MB7898
X-MTK: N

RGVhciBXaWxsZW0NCg0KZnJhZ19saXN0IGFzc2lnbm1lbnQgdHJpZ2dlcjoNCmZyYWdfbGlzdCBp
cyBhc3NpZ25lZCB0byB0aGUgbmV4dCBza2Igd2l0aG91dCB0byBlbmFibGUgZGV2aWNlIGZlYXR1
cmUNCk5FVElGX0ZfR1JPX0ZSQUdMSVNUIGlmIGhlYWRfZnJhZyBpcyB6ZXJvLg0KDQpBZnRlciBw
YWNrZXQgaW4gZnJhZ2xpc3QgaXMgcHJvY2Vzc2VkIGJ5IEJQRiBwdWxsIHRpYWwsIHBlcmZvcm1p
bmcgR1NPDQpzZWdtZW50YXRpb24gZGlyZWN0bHkgd2lsbCBjYXVzZSBwcm9ibGVtcy4NCg0KDQp1
ZHBfZ3JvX3JlY2VpdmVfc2VnbWVudA0KICBza2JfZ3JvX3JlY2VpdmUNCiAgIGlmIChza2ItPmhl
YWRfZnJhZz09MCkNCiAgICAgZ290byBtZXJnZTsNCg0KDQptZXJnZToNCiAgICAgICAgLyogc2sg
b3duZXJzaGlwIC0gaWYgYW55IC0gY29tcGxldGVseSB0cmFuc2ZlcnJlZCB0byB0aGUNCmFnZ3Jl
Z2F0ZWQgcGFja2V0ICovDQogICAgICAgIHNrYi0+ZGVzdHJ1Y3RvciA9IE5VTEw7DQogICAgICAg
IHNrYi0+c2sgPSBOVUxMOw0KICAgICAgICBkZWx0YV90cnVlc2l6ZSA9IHNrYi0+dHJ1ZXNpemU7
DQogICAgICAgIGlmIChvZmZzZXQgPiBoZWFkbGVuKSB7DQogICAgICAgICAgICAgICAgdW5zaWdu
ZWQgaW50IGVhdCA9IG9mZnNldCAtIGhlYWRsZW47DQoNCiAgICAgICAgICAgICAgICBza2JfZnJh
Z19vZmZfYWRkKCZza2JpbmZvLT5mcmFnc1swXSwgZWF0KTsNCiAgICAgICAgICAgICAgICBza2Jf
ZnJhZ19zaXplX3N1Yigmc2tiaW5mby0+ZnJhZ3NbMF0sIGVhdCk7DQogICAgICAgICAgICAgICAg
c2tiLT5kYXRhX2xlbiAtPSBlYXQ7DQogICAgICAgICAgICAgICAgc2tiLT5sZW4gLT0gZWF0Ow0K
ICAgICAgICAgICAgICAgIG9mZnNldCA9IGhlYWRsZW47DQogICAgICAgIH0NCg0KICAgICAgICBf
X3NrYl9wdWxsKHNrYiwgb2Zmc2V0KTsNCg0KICAgICAgICBpZiAoTkFQSV9HUk9fQ0IocCktPmxh
c3QgPT0gcCkNCiAgICAgICAgICAgICAgICBza2Jfc2hpbmZvKHApLT5mcmFnX2xpc3QgPSBza2I7
ICAgDQogICAgICAgIDw8PCBoZXJlIGZyYWdfbGlzdCBpcyBhc3NpZ25lZCB0byB0aGUgbmV4dCBz
a2Igd2l0aG91dCB0bw0KZW5hYmxlIGRldmljZSBmZWF0dXJlIE5FVElGX0ZfR1JPX0ZSQUdMSVNU
IGlmIGhlYWRfZnJhZyBpcyB6ZXJvDQogICAgICAgIGVsc2UNCiAgICAgICAgICAgICAgICBOQVBJ
X0dST19DQihwKS0+bGFzdC0+bmV4dCA9IHNrYjsNCiAgICAgICAgTkFQSV9HUk9fQ0IocCktPmxh
c3QgPSBza2I7DQogICAgICAgIF9fc2tiX2hlYWRlcl9yZWxlYXNlKHNrYik7DQogICAgICAgIGxw
ID0gcDsNCg0KDQoNCg0KT24gVHVlLCAyMDI2LTAxLTA2IGF0IDE0OjE1IC0wNTAwLCBXaWxsZW0g
ZGUgQnJ1aWpuIHdyb3RlOg0KPiBFeHRlcm5hbCBlbWFpbCA6IFBsZWFzZSBkbyBub3QgY2xpY2sg
bGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bnRpbA0KPiB5b3UgaGF2ZSB2ZXJpZmllZCB0aGUg
c2VuZGVyIG9yIHRoZSBjb250ZW50Lg0KPiANCj4gDQo+IFNoaW1pbmcgQ2hlbmcgd3JvdGU6DQo+
ID4gQ29tbWl0IDMzODJhMWVkN2Y3NyAoIm5ldDogZml4IHVkcCBnc28gc2tiX3NlZ21lbnQgYWZ0
ZXIgIHB1bGwgZnJvbQ0KPiA+IGZyYWdfbGlzdCIpDQo+ID4gaWYgZ3NvX3R5cGUgaXMgbm90IFNL
Ql9HU09fRlJBR0xJU1QgYnV0IHNrYi0+aGVhZF9mcmFnIGlzIHplcm8sDQo+IA0KPiBXaGF0IGNv
ZGVwYXRoIHRyaWdnZXJzIHRoaXMgc2NlbmFyaW8/DQo+IA0KPiBXZSBzaG91bGQgbWFrZSBzdXJl
IHRoYXQgdGhlIGZpeCBjb3ZlcnMgYWxsIHN1Y2ggaW5zdGFuY2VzLiBMaWtlbHkNCj4gaW5zdGFu
Y2VzIG9mIHdoZXJlIHNvbWUgbW9kdWxlIGluIHRoZSBkYXRhcGF0aCwgbGlrZSBhIEJQRiBwcm9n
cmFtLA0KPiBtb2RpZmllcyBhIHZhbGlkIHNrYiBpbnRvIG9uZSB0aGF0IGlzIG5vdCBzYWZlIHRv
IHBhc3MgdG8NCj4gc2tiX3NlZ21lbnQuDQo+IA0KPiBJIGRvbid0IGZ1bGx5IHVuZGVyc3RhbmQg
eWV0IHRoYXQgc2tiLT5oZWFkX2ZyYWcgPT0gMCBpcyB0aGUgb25seQ0KPiBzdWNoIGNvbmRpdGlv
biBpbiBzY29wZS4NCj4gDQo+ID4gdGhlbiBkZXRlY3RlZCBpbnZhbGlkIGdlb21ldHJ5IGluIGZy
YWdfbGlzdCBza2JzIGFuZCBjYWxsDQo+ID4gc2tiX3NlZ21lbnQuIEJ1dCBzb21lIHBhY2tldHMg
d2l0aCBtb2RpZmllZCBnZW9tZXRyeSBjYW4gYWxzbyBoaXQNCj4gPiBidWdzIGluIHRoYXQgY29k
ZS4gSW5zdGVhZCwgbGluZWFyaXplIGFsbCB0aGVzZSBwYWNrZXRzIHRoYXQgZmFpbA0KPiA+IHRo
ZSBiYXNpYyBpbnZhcmlhbnRzIG9uIGdzbyBmcmFnbGlzdCBza2JzLiBUaGF0IGlzIG1vcmUgcm9i
dXN0Lg0KPiA+IGNhbGwgc3RhY2sgaW5mb3JtYXRpb24sIHNlZSBiZWxvdy4NCj4gPiANCj4gPiBW
YWxpZCBTS0JfR1NPX0ZSQUdMSVNUIHNrYnMNCj4gPiAtIGNvbnNpc3Qgb2YgdHdvIG9yIG1vcmUg
c2VnbWVudHMNCj4gPiAtIHRoZSBoZWFkX3NrYiBob2xkcyB0aGUgcHJvdG9jb2wgaGVhZGVycyBw
bHVzIGZpcnN0IGdzb19zaXplDQo+ID4gLSBvbmUgb3IgbW9yZSBmcmFnX2xpc3Qgc2ticyBob2xk
IGV4YWN0bHkgb25lIHNlZ21lbnQNCj4gPiAtIGFsbCBidXQgdGhlIGxhc3QgbXVzdCBiZSBnc29f
c2l6ZQ0KPiA+IA0KPiA+IE9wdGlvbmFsIGRhdGFwYXRoIGhvb2tzIHN1Y2ggYXMgTkFUIGFuZCBC
UEYgKGJwZl9za2JfcHVsbF9kYXRhKSBjYW4NCj4gPiBtb2RpZnkgZnJhZ2xpc3Qgc2ticywgYnJl
YWtpbmcgdGhlc2UgaW52YXJpYW50cy4NCj4gPiANCj4gPiBJbiBleHRyZW1lIGNhc2VzIHRoZXkg
cHVsbCBvbmUgcGFydCBvZiBkYXRhIGludG8gc2tiIGxpbmVhci4gRm9yDQo+ID4gVURQLA0KPiA+
IHRoaXMgIGNhdXNlcyB0aHJlZSBwYXlsb2FkcyB3aXRoIGxlbmd0aHMgb2YgKDExLDExLDEwKSBi
eXRlcyB3ZXJlDQo+ID4gcHVsbGVkIHRhaWwgdG8gYmVjb21lICgxMiwxMCwxMCkgYnl0ZXMuDQo+
ID4gDQo+ID4gVGhlIHNrYnMgbm8gbG9uZ2VyIG1lZXRzIHRoZSBhYm92ZSBTS0JfR1NPX0ZSQUdM
SVNUIGNvbmRpdGlvbnMNCj4gPiBiZWNhdXNlDQo+ID4gcGF5bG9hZCB3YXMgcHVsbGVkIGludG8g
aGVhZF9za2IsIGl0IG5lZWRzIHRvIGJlIGxpbmVhcml6ZWQgYmVmb3JlDQo+ID4gcGFzcw0KPiA+
IHRvIHJlZ3VsYXIgc2tiX3NlZ21lbnQuDQo+IA0KPiBNb3N0IG9mIHRoaXMgY29tbWl0IG1lc3Nh
Z2UgZHVwbGljYXRlcyB0aGUgdGV4dCBpbiBjb21taXQNCj4gMzM4MmExZWQ3Zjc3DQo+ICgibmV0
OiBmaXggdWRwIGdzbyBza2Jfc2VnbWVudCBhZnRlciAgcHVsbCBmcm9tIGZyYWdfbGlzdCIpLiBB
bmQNCj4gc29tZXdoYXQgZ2FyYmxlcyBpdCwgYXMgaW4gdGhlIGZpcnN0IHNlbnRlbmNlLg0KPiAN
Cj4gQnV0IHRoaXMgaXMgYSBkaWZmZXJlbnQgZGF0YXBhdGgsIG5vdCByZWxhdGVkIHRvIFNLQl9H
U09fRlJBR0xJU1QuDQo+IFNvIHRoZSBmaXhlcyB0YWcgaXMgYWxzbyBpbmNvcnJlY3QuIFRoZSBi
bGFtZWQgY29tbWl0IGZpeGVzIGFuIGlzc3VlDQo+IHdpdGggZnJhZ2xpc3QgR1JPLiBUaGlzIG5l
dyBpc3N1ZSBpcyB3aXRoIHNrYnMgdGhhdCBoYXZlIGEgZnJhZ2xpc3QsDQo+IGJ1dCBub3Qgb25l
IGNyZWF0ZWQgd2l0aCB0aGF0IGZlYXR1cmUuICh0aGUgbmFtaW5nIGlzIGNvbmZ1c2luZywgYnV0
DQo+IGZyYWdsaXN0LWdybyBpcyBvbmx5IG9uZSB1c2Ugb2YgdGhlIHNrYiBmcmFnX2xpc3QpLg0K
PiANCj4gPiAgIHNrYl9zZWdtZW50KzB4Y2QwLzB4ZDE0DQo+ID4gICBfX3VkcF9nc29fc2VnbWVu
dCsweDMzNC8weDVmNA0KPiA+ICAgdWRwNF91Zm9fZnJhZ21lbnQrMHgxMTgvMHgxNWMNCj4gPiAg
IGluZXRfZ3NvX3NlZ21lbnQrMHgxNjQvMHgzMzgNCj4gPiAgIHNrYl9tYWNfZ3NvX3NlZ21lbnQr
MHhjNC8weDEzYw0KPiA+ICAgX19za2JfZ3NvX3NlZ21lbnQrMHhjNC8weDEyNA0KPiA+ICAgdmFs
aWRhdGVfeG1pdF9za2IrMHg5Yy8weDJjMA0KPiA+ICAgdmFsaWRhdGVfeG1pdF9za2JfbGlzdCsw
eDRjLzB4ODANCj4gPiAgIHNjaF9kaXJlY3RfeG1pdCsweDcwLzB4NDA0DQo+ID4gICBfX2Rldl9x
dWV1ZV94bWl0KzB4NjRjLzB4ZTVjDQo+ID4gICBuZWlnaF9yZXNvbHZlX291dHB1dCsweDE3OC8w
eDFjNA0KPiA+ICAgaXBfZmluaXNoX291dHB1dDIrMHgzN2MvMHg0N2MNCj4gPiAgIF9faXBfZmlu
aXNoX291dHB1dCsweDE5NC8weDI0MA0KPiA+ICAgaXBfZmluaXNoX291dHB1dCsweDIwLzB4ZjQN
Cj4gPiAgIGlwX291dHB1dCsweDEwMC8weDFhMA0KPiA+ICAgTkZfSE9PSysweGM0LzB4MTZjDQo+
ID4gICBpcF9mb3J3YXJkKzB4MzE0LzB4MzJjDQo+ID4gICBpcF9yY3YrMHg5MC8weDExOA0KPiA+
ICAgX19uZXRpZl9yZWNlaXZlX3NrYisweDc0LzB4MTI0DQo+ID4gICBwcm9jZXNzX2JhY2tsb2cr
MHhlOC8weDFhNA0KPiA+ICAgX19uYXBpX3BvbGwrMHg1Yy8weDFmOA0KPiA+ICAgbmV0X3J4X2Fj
dGlvbisweDE1NC8weDMxNA0KPiA+ICAgaGFuZGxlX3NvZnRpcnFzKzB4MTU0LzB4NGI4DQo+ID4g
DQo+ID4gICBbMTE4LjM3NjgxMV0gW0MyMDExMzRdIHJ4cTBfcHVzOiBbbmFtZTpidWcmXWtlcm5l
bCBCVUcgYXQNCj4gPiBuZXQvY29yZS9za2J1ZmYuYzo0Mjc4IQ0KPiA+ICAgWzExOC4zNzY4Mjld
IFtDMjAxMTM0XSByeHEwX3B1czogW25hbWU6dHJhcHMmXUludGVybmFsIGVycm9yOg0KPiA+IE9v
cHMgLSBCVUc6IDAwMDAwMDAwZjIwMDA4MDAgWyMxXQ0KPiA+ICAgWzExOC40NzA3NzRdIFtDMjAx
MTM0XSByeHEwX3B1czogW25hbWU6bXJkdW1wJl1LZXJuZWwgT2Zmc2V0Og0KPiA+IDB4MTc4Y2Mw
MDAwMCBmcm9tIDB4ZmZmZmZmYzAwODAwMDAwMA0KPiA+ICAgWzExOC40NzA4MTBdIFtDMjAxMTM0
XSByeHEwX3B1czogW25hbWU6bXJkdW1wJl1QSFlTX09GRlNFVDoNCj4gPiAweDQwMDAwMDAwDQo+
ID4gICBbMTE4LjQ3MDgyN10gW0MyMDExMzRdIHJ4cTBfcHVzOiBbbmFtZTptcmR1bXAmXXBzdGF0
ZTogNjA0MDAwMDUNCj4gPiAoblpDdiBkYWlmICtQQU4gLVVBTykNCj4gPiAgIFsxMTguNDcwODQ4
XSBbQzIwMTEzNF0gcnhxMF9wdXM6IFtuYW1lOm1yZHVtcCZdcGMgOg0KPiA+IFsweGZmZmZmZmQ3
OTU5OGFlZmNdIHNrYl9zZWdtZW50KzB4Y2QwLzB4ZDE0DQo+ID4gICBbMTE4LjQ3MDkwMF0gW0My
MDExMzRdIHJ4cTBfcHVzOiBbbmFtZTptcmR1bXAmXWxyIDoNCj4gPiBbMHhmZmZmZmZkNzk1OThh
NWU4XSBza2Jfc2VnbWVudCsweDNiYy8weGQxNA0KPiA+ICAgWzExOC40NzA5MjhdIFtDMjAxMTM0
XSByeHEwX3B1czogW25hbWU6bXJkdW1wJl1zcCA6DQo+ID4gZmZmZmZmYzAwODAxMzc3MA0KPiA+
IA0KPiA+IEZpeGVzOiAzMzgyYTFlZDdmNzcgKCJuZXQ6IGZpeCB1ZHAgZ3NvIHNrYl9zZWdtZW50
IGFmdGVyIHB1bGwgZnJvbQ0KPiA+IGZyYWdfbGlzdCIpDQo+ID4gU2lnbmVkLW9mZi1ieTogU2hp
bWluZyBDaGVuZyA8c2hpbWluZy5jaGVuZ0BtZWRpYXRlay5jb20+DQo+ID4gLS0tDQo+ID4gIG5l
dC9pcHY0L3VkcF9vZmZsb2FkLmMgfCA2ICsrKysrKw0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgNiBp
bnNlcnRpb25zKCspDQo+ID4gDQo+ID4gZGlmZiAtLWdpdCBhL25ldC9pcHY0L3VkcF9vZmZsb2Fk
LmMgYi9uZXQvaXB2NC91ZHBfb2ZmbG9hZC5jDQo+ID4gaW5kZXggMTlkMGI1YjA5ZmZhLi42MDZk
OWNlOGM5OGUgMTAwNjQ0DQo+ID4gLS0tIGEvbmV0L2lwdjQvdWRwX29mZmxvYWQuYw0KPiA+ICsr
KyBiL25ldC9pcHY0L3VkcF9vZmZsb2FkLmMNCj4gPiBAQCAtNTM1LDYgKzUzNSwxMiBAQCBzdHJ1
Y3Qgc2tfYnVmZiAqX191ZHBfZ3NvX3NlZ21lbnQoc3RydWN0DQo+ID4gc2tfYnVmZiAqZ3NvX3Nr
YiwNCj4gPiAgICAgICAgICAgICAgICAgICAgICAgdWgtPmNoZWNrID0gfnVkcF92NF9jaGVjayhn
c29fc2tiLT5sZW4sDQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgaXBfaGRyKGdzb19za2IpLQ0KPiA+ID5zYWRkciwNCj4gPiAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBpcF9oZHIoZ3NvX3NrYiktDQo+ID4g
PmRhZGRyLCAwKTsNCj4gPiArICAgICB9IGVsc2UgaWYgKHNrYl9zaGluZm8oZ3NvX3NrYiktPmZy
YWdfbGlzdCAmJiBnc29fc2tiLQ0KPiA+ID5oZWFkX2ZyYWcgPT0gMCkgew0KPiA+ICsgICAgICAg
ICAgICAgaWYgKHNrYl9wYWdlbGVuKGdzb19za2IpIC0gc2l6ZW9mKCp1aCkgIT0NCj4gPiBza2Jf
c2hpbmZvKGdzb19za2IpLT5nc29fc2l6ZSkgew0KPiA+ICsgICAgICAgICAgICAgICAgICAgICBy
ZXQgPSBfX3NrYl9saW5lYXJpemUoZ3NvX3NrYik7DQo+ID4gKyAgICAgICAgICAgICAgICAgICAg
IGlmIChyZXQpDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgcmV0dXJuIEVSUl9Q
VFIocmV0KTsNCj4gPiArICAgICAgICAgICAgIH0NCj4gPiAgICAgICB9DQo+ID4gDQo+ID4gICAg
ICAgc2tiX3B1bGwoZ3NvX3NrYiwgc2l6ZW9mKCp1aCkpOw0KPiA+IC0tDQo+ID4gMi40NS4yDQo+
ID4gDQo+IA0KPiANCg==

