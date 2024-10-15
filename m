Return-Path: <netdev+bounces-135802-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CEF5E99F3E3
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 19:19:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8CD15281C37
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 17:19:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A24371F9EBA;
	Tue, 15 Oct 2024 17:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="NbZ1Bvu+";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="pEW5qufc"
X-Original-To: netdev@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C72E21B3958;
	Tue, 15 Oct 2024 17:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729012743; cv=fail; b=IniZEL9gh50c5AFC+BWbOlmAz7gBMRJTx+2KKq7oDEYnSUpcaQ8UaBNUHCefdnWdmQD8Ic2U/OS1SrveEVjKrUkLqzzKqjttbfHIjDYYsfn/xY6H9VlLwGe73YjNHTEJsrS60PiEy9bJOU0qEJolCW3DhsU7K6fqSsZ+ZW45BOg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729012743; c=relaxed/simple;
	bh=zK1J5b8KwL2BCPfuL/owGz6uAuR5EpgOB3sffNEoekw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=UwBKkuXioTvpmi7CbrtR/7Smec+o68zjJx7vod1gghjgkdBBTOBIdP7wYEhftBBiVcPkvn46eVMJ7eerKuBD1OwcwkWldUHIaQ3oKH267cCpfxKnKkJYVTwGkL71D2duCn5gzXozUydYwlWO9K/Ocyo1CDK4LH6wO23Uzqy6xr4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=NbZ1Bvu+; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=pEW5qufc; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 8e14ca668b1911ef8b96093e013ec31c-20241016
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=zK1J5b8KwL2BCPfuL/owGz6uAuR5EpgOB3sffNEoekw=;
	b=NbZ1Bvu+pArTzW21vAG7I97jBE1n0Y6AZMftTaGKjCJSOAutUfVU3gZ4U3+sMTmYPcP3hRbrCoRcyC4hAR6LjZJmE/s9WE99I62zv21KCMBWfo5K6Gh1t43jo81Ofdg9RMPTHF189v0wKGfBARr4m94izNLWp73c8fv3JJ4Uahw=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.41,REQID:573cdcdd-a5e0-4d10-9e46-b44c4d344ad4,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6dc6a47,CLOUDID:43e6d406-3d5c-41f6-8d90-a8be388b5b5b,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0|-5,EDM:-3,IP:ni
	l,URL:1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-UUID: 8e14ca668b1911ef8b96093e013ec31c-20241016
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw02.mediatek.com
	(envelope-from <skylake.huang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1545114929; Wed, 16 Oct 2024 01:18:54 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 MTKMBS09N2.mediatek.inc (172.21.101.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 15 Oct 2024 10:18:53 -0700
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 16 Oct 2024 01:18:53 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Rg03vSwqAOhkVDsLvvbh4A5opStSSaF04GIoLVih+47HMXEjr4AxNajT1NC0qQLyVCNmI1COd7przgWVhtQ64MQU2Etoef5Bub+Fhi9kPjhYZ+tnF6xXEILE8lDQy+4y1UJ5gXmwNVGO5Pj2zVZkUVrfkuiu9a5iPZRAZhR86zY8KK3WyD1qp9jGpkIUCl8TlonjoqTaqeBpAUQNHCS9Y4F3afR1bRrGc2VVxUR2DxhbSgblS2VYrAv5ulRSEqt+6CX3zqy840aQAKh14m8E3qRbVuT6K6+CUwTNyFrbT5rrS2GrJcvY8KMEjoy4sWkF89o6SrtuxYVFDleQaztJng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zK1J5b8KwL2BCPfuL/owGz6uAuR5EpgOB3sffNEoekw=;
 b=i0f7vyMIOCwGn0zikS3jbDC5SU5DA54UrubDzPkvRu3CnollA3fOlCuGInOwSAhgAA6jXr0vCzbChET47Ie0B+3yGxC5CHxBwiYyD5AP3zvYKjlZ1Kr2ELxjGy7+9nx/2L227l2gxINGTzZPdxTM8FO2O6dTAdLMvfPWmSi5JfehgBx5Gllhdhif8rlJYAqiKywGND2gTfZYodrURXLp2aVfobFq3uJZYtMtXb5WXeTIXSel3F9TcSBWWvdCsJcr2OPw9rzh2bHCGCwxb1XNsKHbYEPyjFDMfgZZ5CyjT200H9NU6Y4o/nyZk6fWx0w9yQmTDTx0LC6xRsFRikgkNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zK1J5b8KwL2BCPfuL/owGz6uAuR5EpgOB3sffNEoekw=;
 b=pEW5qufcjOlKS/Wqf4RaVERM3XXO6I3YduQgsSj3kAyqhkgK/w5qj9Wp+JICO1gF+PAVnQqMZL0lppmTjhd0+P9168c8PCho+6sTRD4P3So7SletJDm+m5KMFSPnYWZL3QBzDu8fZHJrFv65B4OY6aJR5p94lzdkof0mQ8NT/ls=
Received: from KL1PR03MB6226.apcprd03.prod.outlook.com (2603:1096:820:8c::14)
 by SG2PR03MB6585.apcprd03.prod.outlook.com (2603:1096:4:1d6::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.21; Tue, 15 Oct
 2024 17:18:50 +0000
Received: from KL1PR03MB6226.apcprd03.prod.outlook.com
 ([fe80::f3:c11:8422:7ce3]) by KL1PR03MB6226.apcprd03.prod.outlook.com
 ([fe80::f3:c11:8422:7ce3%4]) with mapi id 15.20.8048.020; Tue, 15 Oct 2024
 17:18:49 +0000
From: =?utf-8?B?U2t5TGFrZSBIdWFuZyAo6buD5ZWf5r6kKQ==?=
	<SkyLake.Huang@mediatek.com>
To: "horms@kernel.org" <horms@kernel.org>
CC: "andrew@lunn.ch" <andrew@lunn.ch>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-mediatek@lists.infradead.org"
	<linux-mediatek@lists.infradead.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux@armlinux.org.uk"
	<linux@armlinux.org.uk>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "edumazet@google.com"
	<edumazet@google.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"dqfext@gmail.com" <dqfext@gmail.com>,
	=?utf-8?B?U3RldmVuIExpdSAo5YqJ5Lq66LGqKQ==?= <steven.liu@mediatek.com>,
	"matthias.bgg@gmail.com" <matthias.bgg@gmail.com>, "davem@davemloft.net"
	<davem@davemloft.net>, "hkallweit1@gmail.com" <hkallweit1@gmail.com>,
	"daniel@makrotopia.org" <daniel@makrotopia.org>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH net-next 1/1] net: phy: Refactor mediatek-ge-soc.c for
 clarity and correctness
Thread-Topic: [PATCH net-next 1/1] net: phy: Refactor mediatek-ge-soc.c for
 clarity and correctness
Thread-Index: AQHbHe5Po7rJbLYEpUGiX5WMtC7nnLKF52iAgAIpUYA=
Date: Tue, 15 Oct 2024 17:18:49 +0000
Message-ID: <d2c24d063bea99be5380203ec4fafe3e4f0f9043.camel@mediatek.com>
References: <20241014040521.24949-1-SkyLake.Huang@mediatek.com>
	 <20241014081823.GL77519@kernel.org>
In-Reply-To: <20241014081823.GL77519@kernel.org>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR03MB6226:EE_|SG2PR03MB6585:EE_
x-ms-office365-filtering-correlation-id: 20dc87f1-3c4e-4a34-aafe-08dced3d6f5a
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?YUpmVkdyakF3VWpFRzZZUWhuaU5aRkxCMUcrZ1FiNVJRUDN1eUhGcG9PZ0h4?=
 =?utf-8?B?a1dJNUV4VTMwaDk3bVoxRnlKREl3akkzZkpQYXJ1TThEZEk4aHZOcys0WVBy?=
 =?utf-8?B?cVMwa3hHOUhlNHpiUXRoclR4QnRrK0lIYlVMRmVUOFF5RnBDSnpPL0lITXQ0?=
 =?utf-8?B?ZmNVbCttUlc2eUxaQXJTcEU3SU5FNmlJUElhaU55T0h1emYzQ2Vrenl3KzZQ?=
 =?utf-8?B?YmRtZTNBMjJ2NFYvazJ1SHcraWJJalhkN25OTEx4WmZabnN6cDhuL0ZWU3gr?=
 =?utf-8?B?SkRRUlVRbzhMSzE1YURjUFZwbW9JbXk4ZjlrbjV6SGpWUHNyNVl3cTlFSTd5?=
 =?utf-8?B?djRhd3hTUWROUDRiVSs1MU9abWhtcmJCRlpQendlV3doVUppQndLWm1PaDhG?=
 =?utf-8?B?R2hBNzQ4WHdra3RlaERIbFVLVm9nZkI4WkJ2TW93MG4xWk1xQ01rQ1Vhem00?=
 =?utf-8?B?bFJMYUFDZEZIelp6R0xEdEVCMWcrL0pEUm5IdERzcjBtWjFmMDg3TjJSZVJD?=
 =?utf-8?B?UG8zTTBsYVJkSGt3dkk1REN3ZzdKSjUzRTd0eUx2a1pjVWN1K3dJdWtvSWsy?=
 =?utf-8?B?WmtVSGJ5Z3ovMVJlNGRpSzV1dUtvNDBheVBnTlRwbXpFQ2EzZkV4ZGM4cTNs?=
 =?utf-8?B?ZVBRamRPYUpGV1lHczBlUStHb0JybjIxY1piUi9SS3lTNlk4R1dyaTRCN3Nw?=
 =?utf-8?B?R0ozdHNtckxvaHMzSUhsZ1RGWGJRWms0MjRmcDVYRnpua2J1WlNibG53cXpW?=
 =?utf-8?B?emdvZC8wRE5PUHNpd0Jya0l6NG9WaGdna2ErU3phbTZ1ZHRabEZEUGpodkFz?=
 =?utf-8?B?QmZPMDVGQWRWTkZINU1wTFFMOXpnUlZPVmVlMlR4QnRTZ29yN2Y1emlKZVA3?=
 =?utf-8?B?NXp3M0pQbkJ2S0F1RXBPL1VTSDFrUkFaTEpUamdFVVRKaTRtQ0JaTVNRU2ho?=
 =?utf-8?B?V05SK1VQekRCLzF1d08yZkk1U3VFbW9qbXRYVTNrV3AzNHhKZXR2dUxzS2Zq?=
 =?utf-8?B?NUNic1B6L2NQcytYa2ZXb3VsOFZmZ0lwbTZJOTZJTnExejZ0Q2lKWi9hRFUv?=
 =?utf-8?B?UjZHOWZzTGhjUHNpK1Z5eEdjZ0dEZDNtM0N2UmlMUG9KSExBNktvQVpqc2ZO?=
 =?utf-8?B?V1RNcVFmSFk1bzcrYUN0MGtzTGh0dm1rSUk2WWhzVThDdm5lNXk4ZzlEZnJL?=
 =?utf-8?B?NFFJYWtTblRYYlNJb1ZFM3RuSE1ySU93a3o3b3V3d0p1a3MxajBHZXBQbzNP?=
 =?utf-8?B?SS8xK043c09sUHU5WDAvdVoxSTk3NlRmdW5BblNBa0lqTER6dXp5a2tzU1ZI?=
 =?utf-8?B?emJmTVgyc1dJK1lxQlBmeUtLLzl4dHduZ2tvRWg0d2NtemlHRWdFckNQMnBF?=
 =?utf-8?B?Q3ZLanh4eVUzdWJVRUFqR3QyL1FBSkM5ZEJFWnpLYTQ5M3lDYmdVYmM2S1NL?=
 =?utf-8?B?cVFWNXhQY1RUbHVXWHpYQjl6U1pZL2x6Z2hJcXdrTjBXSThoMmQ0eFZUQjJS?=
 =?utf-8?B?aUUreWx5Ykc3VGlBeTlGclFmbzZ5bFI2NTZiLy9zWlNYeFZJcHRnZ0RaYStZ?=
 =?utf-8?B?aU5SZVprTVd5alNhL3FzOW83QkRCaVBSaFVnam8xWGNhU2ZraUY4MjdhQ2gr?=
 =?utf-8?B?dGQyUXNSSGYxY3ZLQVZ2VTZVemRtTktQVUNTQXh2aVd2cEV5WWlSajRHTmpV?=
 =?utf-8?B?MnZIaTlXNWNxeGpSUW1vQ0NxYVV4SlhydkJ3YUJzN1Vhd3Q2L0VObEFteUxW?=
 =?utf-8?B?a0lPYXBQaUR5bW5Qay8zanArQ0NaTnBVeDZhbzZYbWlCcEZxU0dJZlc2SmlH?=
 =?utf-8?B?dWZUeWFwcnpVMHNrZmhDdz09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR03MB6226.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WEhjS2h3bDhQTSsxS0F4cjNjYndsbWp0UGxlNDVvZVFMQlVaMERxR01tb0Nm?=
 =?utf-8?B?SW9Ua2twTWFreGpDZ0tvUmJPL0VHOWprTFhHS1NIUlA3ZUZIbnBOVCtVK3hT?=
 =?utf-8?B?Ym5Tbm1RL2dkOHA0bXJQUHBZQ3NsaXhIczJDZlhVQ0toQ1JrazVkRUJrNFFP?=
 =?utf-8?B?eDZkekQza0xZUVpWZ1NOMmNGa0o0a0RNY2NUM3NQcjlIZDMxZWNDY2VqL0Rh?=
 =?utf-8?B?RjB2TDNrSFdxcVorQVFyVy9kNk0zRFM4T1N5emJJaXBlN2FwMFM2QWpPbzM2?=
 =?utf-8?B?c2FmZ2tueWpFYkJDdEY2WVZhTVRWUXpSTGpkREp4eE1IZjQweXlWOXJtdURR?=
 =?utf-8?B?RkY3OG94QW1hcGcrekk5LzFpbVgwZ1dzRlVzRHJ6RGNhN0Z2bUxEbkRTZFZK?=
 =?utf-8?B?aW5JQXd5R3NTNUxYYWNOblZsdjhTaE1ZRFN1V0o1M1ROWjVTNHpWTE1JdU82?=
 =?utf-8?B?d014NDBlNldLYjU1R2tPK2tBYzgzWCtIZEwwUnpWQ3VFU1VDSElBUHNqSUNm?=
 =?utf-8?B?S0dxdmdYb3EwN2EzdW9qWm1YTytHcWExZE1JSEVwUjV0WE5HemU5Ry9YZTdz?=
 =?utf-8?B?ck9uUk5QejY3M0ZaRUZGOTdXMTk0YmkyNVJpN1dwUFdzM1N1MStLeXpVdmZH?=
 =?utf-8?B?MGlvNTJSaExOMUZNYUJwUW0reWRLYms5cHNWVEZMWkhLMWFON3hNM2JIL3Ra?=
 =?utf-8?B?bDFiQllyT1dmZlU3Y29sRXBmWFMvZzlKQ2xLb2tlVGphM2RuUUwzRS8xOVRj?=
 =?utf-8?B?bVdzRGRvbkt6Y3M5enMwR3NiQzdEc0o5RXY3S1NrUE1BVTUwQUdUVWRlUlFC?=
 =?utf-8?B?UkJTckhyQ28wVkI0cHpheWdieStodHgvZ3ErTHk3UGVBUUc2R0wwaWp2dTNC?=
 =?utf-8?B?VFRaZHhWQmVCWjY0THZ1ODVDYlp0VDhyc3VxSFFuSVk0RFN2K1JBU0p3eDcr?=
 =?utf-8?B?ZG5GRS9FZ0dKZnRzMHNxYU1mcFhkVDhtRDNnSHp6UlJEaWNLc3RmN3hPUVdr?=
 =?utf-8?B?ejMyazlCZDFobG9lZEI5SWlmVGZpbUFwOUMrdGUxN3VPR0VxNlhlaGx1SjN1?=
 =?utf-8?B?NlhxQVFaaVd2SW1NTXg1ZUJ6ck5BNFFrSm9taWI2SzY3ZjFwaFlBSTNPRU95?=
 =?utf-8?B?bmtzemlXNHB0RjliK1NWZHJpRDBhMjhEWEJUTHhZd0ZPTURLcUpHbzhic1ZW?=
 =?utf-8?B?ZHNSeVVxV1JpVlZoNEp6eUIwb3V5bk9RdlZyUmVQYjk4RkdyZEMzZWFDQVFL?=
 =?utf-8?B?bVZmSUhRRVlkRGc3bkpML05Ha0ZiU05UU2NwTEllMkRXTTZwd2JRWElRMWRx?=
 =?utf-8?B?R1ZaYkpVZURGRWFPWURMa0VWV1FUY3VrM0Rac3JTTzdtZ0wrRytmN29HZVVW?=
 =?utf-8?B?RkZib2d0R2t4NGtOOForU3ZiRE5ScXY2NDU5STVyWGJxRENvWVpRanZUOUhN?=
 =?utf-8?B?OXRKNkJXUjRtcmlJU3RkOUNoNXB5WkFWbHVmR2UrMURjTkNzdG1ZeVJZYitt?=
 =?utf-8?B?RlY0SzV3NHFhNjBuM2JrT1pScTkrT3JsaGNUZzc4RkpMT2lUYmRPcGZGb0ND?=
 =?utf-8?B?aHBUcU45VmZVbm9WanA0ZjMrd1BxSlNyU01WRnV6SmpGV1JrWXhRaEdmOWFX?=
 =?utf-8?B?NVR3UnEvTFdhK1cyQzdSYTVtdnJzbFprVU5icGEyWDNIcTBHNUdpbDc0Njdt?=
 =?utf-8?B?VGgxUUxqakdOa0t5R2c1MmQ2RmQ3a1ZrRlNxQjVkbmR2RmZ0eWpsM3lXWG04?=
 =?utf-8?B?blpJOStNNzlqcVdwSFEvSGRZclM4a0dSOFdrUDluNzFIdDYwMksyU1hLeFRt?=
 =?utf-8?B?L1praHRkMDJhdUlxeUNQdWFHN04xYmsvZFE0UmJCamdtRld2UjR4bVBxM2Uw?=
 =?utf-8?B?RFpucHJ5bmF2WW4zZVJVejFtOW8wd2dvb20vQUN5OEJuUzIrRjhZVjJGMnA5?=
 =?utf-8?B?dDJxSGtBQnFONGNGc1FuQVh1NitzaHBKNXI4ZkQ2RFdqd0F1UjhzclNvaW80?=
 =?utf-8?B?TVM0cEh2SFNoakhJNkoySVRBSkxWNkRsdkFkR25DSUpOMUpYTVhvVWlweDdG?=
 =?utf-8?B?V1lDQmZ4U0R2T0N1NWZtaVpNUS9zZWpEVnBNeEtyeDJYdktVcGpxZ1JzUUd4?=
 =?utf-8?B?NllnQmh4Y1V1QnMrdE9RMkFya1o0clRnczV5aUp4dFZMVVlPc3ZvNG9vKzVK?=
 =?utf-8?B?aXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3AB0AB063896BE4EA60B77E96C9A46B0@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR03MB6226.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20dc87f1-3c4e-4a34-aafe-08dced3d6f5a
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2024 17:18:49.6547
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eFOwa7Nnpa0ZhsSW5n0mYxjkQzpUSCPw3fhX0PyP2yFygVYQ1RpVF9eiMhQIGtGpy1xp35Z1Junnx1e+rzKSoQxtYPxvQGfJT2rQO5svV0E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR03MB6585

T24gTW9uLCAyMDI0LTEwLTE0IGF0IDA5OjE4ICswMTAwLCBTaW1vbiBIb3JtYW4gd3JvdGU6DQo+
ICAJIA0KPiBFeHRlcm5hbCBlbWFpbCA6IFBsZWFzZSBkbyBub3QgY2xpY2sgbGlua3Mgb3Igb3Bl
biBhdHRhY2htZW50cyB1bnRpbA0KPiB5b3UgaGF2ZSB2ZXJpZmllZCB0aGUgc2VuZGVyIG9yIHRo
ZSBjb250ZW50Lg0KPiAgT24gTW9uLCBPY3QgMTQsIDIwMjQgYXQgMTI6MDU6MjFQTSArMDgwMCwg
U2t5IEh1YW5nIHdyb3RlOg0KPiA+IEZyb206ICJTa3lMYWtlLkh1YW5nIiA8c2t5bGFrZS5odWFu
Z0BtZWRpYXRlay5jb20+DQo+ID4gDQo+ID4gVGhpcyBwYXRjaCBkb2VzIHRoZSBmb2xsb3dpbmcg
Y2xlYW4tdXA6DQo+ID4gMS4gRml4IHNwZWxsaW5nIGVycm9ycyBhbmQgcmVhcnJhbmdlIHZhcmlh
YmxlcyB3aXRoIHJldmVyc2UNCj4gPiAgICBYbWFzIHRyZWUgb3JkZXIuDQo+ID4gMi4gU2hyaW5r
IG10ay1nZS1zb2MuYyBsaW5lIHdyYXBwaW5nIHRvIDgwIGNoYXJhY3RlcnMuDQo+ID4gMy4gUHJv
cGFnYXRlIGVycm9yIGNvZGUgY29ycmVjdGx5IGluIGNhbF9jeWNsZSgpLg0KPiA+IDQuIEZpeCBz
b21lIGZ1bmN0aW9ucyB3aXRoIEZJRUxEX1BSRVAoKS9GSUVMRF9HRVQoKS4NCj4gPiA1LiBSZW1v
dmUgdW5uZWNlc3Nhcnkgb3V0ZXIgcGFyZW5zIG9mIHN1cHBvcnRlZF90cmlnZ2VycyB2YXIuDQo+
ID4gDQo+ID4gU2lnbmVkLW9mZi1ieTogU2t5TGFrZS5IdWFuZyA8c2t5bGFrZS5odWFuZ0BtZWRp
YXRlay5jb20+DQo+ID4gLS0tDQo+ID4gVGhpcyBwYXRjaCBpcyBkZXJpdmVkIGZyb20gTWVzc2Fn
ZSBJRDoNCj4gPiAyMDI0MTAwNDEwMjQxMy41ODM4LTktU2t5TGFrZS5IdWFuZ0BtZWRpYXRlay5j
b20NCj4gDQo+IEhpIFNreSwNCj4gDQo+IEkgdGhpbmsgdGhpcyBwYXRjaCBpcyB0cnlpbmcgdG8g
ZG8gdHdvIG1hbnkgdGhpbmdzIChhdCBsZWFzdCA1IGFyZQ0KPiBsaXN0ZWQNCj4gYWJvdmUpLiBQ
bGVhc2UgY29uc2lkZXIgYnJlYWtpbmcgdGhpcyB1cCBpbnRvIHNlcGFyYXRlIHBhdGNoZXMsDQo+
IHBlcmhhcHMNCj4gb25lIGZvciBlYWNoIG9mIHRoZSBwb2ludHMgYWJvdmUuDQo+IA0KPiBBbHNv
LCBJIHRoaW5rIGl0IHdvdWxkIGJlIGJlc3QgdG8gZHJvcCB0aGUgZm9sbG93aW5nIGNoYW5nZXMg
dW5sZXNzDQo+IHlvdSBhcmUNCj4gdG91Y2hpbmcgdGhvc2UgbGluZXMgZm9yIHNvbWUgb3RoZXIg
cmVhc29uIFsxXSBvciBhcmUgcHJlcGFyaW5nIHRvIGRvDQo+IHNvOg0KPiANCj4gKiB4bWFzIHRy
ZWUNCj4gKiA4MCBjaGFyYWN0ZXIgbGluZXMNCj4gKiBwYXJlbnRoZXNlcyB1cGRhdGVzDQo+IA0K
PiBbMV0gDQo+IGh0dHBzOi8vZG9jcy5rZXJuZWwub3JnL3Byb2Nlc3MvbWFpbnRhaW5lci1uZXRk
ZXYuaHRtbCNjbGVhbi11cC1wYXRjaGVzDQoNCkhpIFNpbW9uLA0KICBSZXZlcnNlIFhtYXMgdHJl
ZSBzdHlsZSAmIDgwIGNoYXIgcHJlZmVyZW5jZXMgY29tZSBmcm9tIHlvdXIgYWR2aXNlDQppbiAg
DQpodHRwczovL2xvcmUua2VybmVsLm9yZy9hbGwvMjAyNDA1MzAwMzQ4NDQuMTExNzYtNi1Ta3lM
YWtlLkh1YW5nQG1lZGlhdGVrLmNvbS8NCiAgUGFyZW5zIHJlbW92aW5nIGNvbWVzIGZyb20gRGFu
aWVsJ3MgYWR2aXNlIGluIA0KaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxsLzIwMjQwNzAxMTA1
NDE3LjE5OTQxLTE0LVNreUxha2UuSHVhbmdAbWVkaWF0ZWsuY29tLw0KDQogIEJlY2F1c2UgcHJl
dmlvdXMgcGF0Y2hzZXQoDQpodHRwczovL2xvcmUua2VybmVsLm9yZy9hbGwvMjAyNDA3MDExMDU0
MTcuMTk5NDEtMS1Ta3lMYWtlLkh1YW5nQG1lZGlhdGVrLmNvbS8NCikgaXMgdG9vIGxhcmdlLCBJ
IGd1ZXNzIGl0J3MgYmV0dGVyIHRvIGNvbW1pdCB0aGlzIGNoYW5nZSBmaXJzdCBzbyB0aGF0DQpJ
IGNhbiBoYW5kbGUgdGhlIHJlc3QuIEFuZCB0aGlzIHNob3VsZCBiZSAic29tZSBvdGhlciByZWFz
b24iPw0KICBBbmQgc2luY2UgdGhpcyBwYXRjaCBpcyBzaW1wbGUgY2xlYW4tdXBzLCBpcyBpdCBu
ZWNlc3NhcnkgdG8gc2VwYXJhdGUNCml0Pw0KDQpCUnMsDQpTa3kNCg==

