Return-Path: <netdev+bounces-106065-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 726329147CA
	for <lists+netdev@lfdr.de>; Mon, 24 Jun 2024 12:46:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A4E14B213ED
	for <lists+netdev@lfdr.de>; Mon, 24 Jun 2024 10:46:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8233113774D;
	Mon, 24 Jun 2024 10:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="timKgLK8";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="RWA6KJZr"
X-Original-To: netdev@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C73692F24;
	Mon, 24 Jun 2024 10:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719226001; cv=fail; b=Fx0bHZu4Ybg8iob2XoHslvWsZNj+20TRDsFw0vM7vx1zYA18LX6UnzkLvd93zJQ0giV/E65cGiV8LDR8mPIa6avHNsWJkwX4Ba9wy4dEBetnm9chIuZRT1xDGZGrD5DUquWiqXetkZhc7+xCn8XiTAxeb9KKfMp+JZycrOVDxjA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719226001; c=relaxed/simple;
	bh=U/w/aKK47SHsJzkVz/Rvl67ahfqDeJA3nfJNWgcf24g=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BeGV8bOroZ2Y2UfKLzDdtWgvMuBvSShYn2JHQVLY12cC3w1UwW5y9s7g75OUmuPAu/DaKu6bXw0XXAlWHiquSr3JQ9cbl0ddFltRaQ9z5g5L+gN35ymDdUixiY/+k6LD2jtkj1T49PqKox6j6+zne5SUI9s/fPky5p+p4RAvNE0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=timKgLK8; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=RWA6KJZr; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 0526d0e2321711ef99dc3f8fac2c3230-20240624
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=U/w/aKK47SHsJzkVz/Rvl67ahfqDeJA3nfJNWgcf24g=;
	b=timKgLK8NMPAb65y7POAxpT5XTislT7s1+5uJNib+xHZCkK4X5s2sZe9qyjBw9bAZn2Xu9VD2fIExKEqgYdk+3/FY1XMEGUfHwtnfdbCI3HD5LFFDZ5DplM8o9TV2Tw/0WHHysMHcRT5lA2b6x1IWhEOpaTXuS/jU4epLAecG+g=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.39,REQID:ad2df192-b8e9-48f3-a2ad-a2b4d6f5687e,IP:0,U
	RL:0,TC:0,Content:1,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:1
X-CID-META: VersionHash:393d96e,CLOUDID:60ccf688-8d4f-477b-89d2-1e3bdbef96d1,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:817|102,TC:nil,Content:4|-5,EDM:-3,I
	P:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0
	,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 1,FCT|NGT
X-CID-BAS: 1,FCT|NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 0526d0e2321711ef99dc3f8fac2c3230-20240624
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw02.mediatek.com
	(envelope-from <skylake.huang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1846724238; Mon, 24 Jun 2024 18:46:32 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 24 Jun 2024 18:46:31 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 24 Jun 2024 18:46:31 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aXZDmX/JjC2nXR8/ZSVrp6vtmsVV+RMYzrI9dR5FnqEU++TIVx9ZUGrzjZRE4cVpSYh/vX4yTH8/tRDWje30Yu8k4CKPkMezGpHmxLTfnO3MarrqJU7U70BYEiicvC69fi9tU0G56bObVMkW90J7BDcFEwyZZKNY77LulJmvUqWVqioTuJg6/UxCOAVJQIPcYNNyLrteM+BJTHzDEye94f5mzMFklzq5wU0RGDKDCq8joRJfZgr1GOK5wWu/HPgBDCJUckyVHXZSUFVqLeMzZHZMCEpCvFr1EaT7PTiEEiZTgKpVhybc99OvxxbiKooI+oPPHcTcZVvHJX9DLupp5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U/w/aKK47SHsJzkVz/Rvl67ahfqDeJA3nfJNWgcf24g=;
 b=jePhiOd4TIfRbbA2AocOqSQHwpbUtpfTWn56A1wrRMl25ibkrP1LSiQgOr9bQrbkzvXpJl9w0dALqyhNxLnzLSSlnaaGnjAplfSc9+4d5XnCXul1OOdexlPne7D2D88Kp03AqXksuxtm+LLnvmUiNXmBt6uE/eJzJgtVU4jycS++anrUplGzNPNi18pVbFB60nYp11x92X0F/RWneYop70WOCh3P5gTIxS4KR0U5+OZ4hsaTvU72x43Fh+EmoeUuGIboT7hCbKrG33DLHImSXduDGpK7FHYHzWm5GZcKcRkU7m2N3J1iHVF+GqKnLOLtwQ7aOJ6DH2tZmmEoFiYOBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U/w/aKK47SHsJzkVz/Rvl67ahfqDeJA3nfJNWgcf24g=;
 b=RWA6KJZr1a1tsyKHo3ZdZBfBsxCBQBAqv5HexnPcR0cOpsTbfR6DYjMUqruVPcgS7xiFXurA++m/uANybKcu7SeymHuP2GABBgmrMj2HgMuczILZQtwzS01pFcpn4r96ijzKJNvQH85Q+Y4dCtg/moNxi62hkHCZLF/KluS7OuU=
Received: from KL1PR03MB6226.apcprd03.prod.outlook.com (2603:1096:820:8c::14)
 by SEZPR03MB7247.apcprd03.prod.outlook.com (2603:1096:101:9f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.25; Mon, 24 Jun
 2024 10:46:25 +0000
Received: from KL1PR03MB6226.apcprd03.prod.outlook.com
 ([fe80::f3:c11:8422:7ce3]) by KL1PR03MB6226.apcprd03.prod.outlook.com
 ([fe80::f3:c11:8422:7ce3%5]) with mapi id 15.20.7698.025; Mon, 24 Jun 2024
 10:46:25 +0000
From: =?utf-8?B?U2t5TGFrZSBIdWFuZyAo6buD5ZWf5r6kKQ==?=
	<SkyLake.Huang@mediatek.com>
To: "andrew@lunn.ch" <andrew@lunn.ch>
CC: "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-mediatek@lists.infradead.org"
	<linux-mediatek@lists.infradead.org>, "linux@armlinux.org.uk"
	<linux@armlinux.org.uk>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "edumazet@google.com"
	<edumazet@google.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"dqfext@gmail.com" <dqfext@gmail.com>,
	=?utf-8?B?U3RldmVuIExpdSAo5YqJ5Lq66LGqKQ==?= <steven.liu@mediatek.com>,
	"matthias.bgg@gmail.com" <matthias.bgg@gmail.com>, "davem@davemloft.net"
	<davem@davemloft.net>, "hkallweit1@gmail.com" <hkallweit1@gmail.com>,
	"daniel@makrotopia.org" <daniel@makrotopia.org>,
	"angelogioacchino.delregno@collabora.com"
	<angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH net-next v8 11/13] net: phy: add driver for built-in 2.5G
 ethernet PHY on MT7988
Thread-Topic: [PATCH net-next v8 11/13] net: phy: add driver for built-in 2.5G
 ethernet PHY on MT7988
Thread-Index: AQHaw9aJWe9EmDGaH06UfWuUSACTJLHUE7AAgAKsJYA=
Date: Mon, 24 Jun 2024 10:46:24 +0000
Message-ID: <461abaf6b5386071fed9d5b1eba629d794c1810c.camel@mediatek.com>
References: <20240621122045.30732-1-SkyLake.Huang@mediatek.com>
	 <20240621122045.30732-12-SkyLake.Huang@mediatek.com>
	 <86e5c28a-42dd-432b-8bd7-2ccc4567520f@lunn.ch>
In-Reply-To: <86e5c28a-42dd-432b-8bd7-2ccc4567520f@lunn.ch>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR03MB6226:EE_|SEZPR03MB7247:EE_
x-ms-office365-filtering-correlation-id: ce7d37d9-6335-4ed2-6611-08dc943ae4f4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230037|366013|1800799021|7416011|376011|38070700015;
x-microsoft-antispam-message-info: =?utf-8?B?MkJlN3V2R0tXOG92bzR2SlhnUkthYXk5bHo1S0VMSnZUS1E4U1MyZXQ3WUJQ?=
 =?utf-8?B?OGQzOGt3VXB5b1JsaXVQYUQvWXc2VHBSSC9xN3VBZjF2SkV6SDdNTnFWVnk3?=
 =?utf-8?B?M3p2SlZZWE1EalByek1yQUR4U0NXd3F3YjVyYm5uUEFNTS9DZ2NIa1RDc1kw?=
 =?utf-8?B?ZUE5a01XQUEzVlYvWElCTzh2R3Y4T2psU0NaUmN6TzFjRzFuWEszM25TN2Z3?=
 =?utf-8?B?bVVOVmVTWTcrOFVXTy96eDZ4Qlc2RHQyTkcxZnJXejNZd25LTFlaaGR6L2hV?=
 =?utf-8?B?aElVVjFKMUVuM0lJOTU3bTkzb28rMkkwNTBoWCt6bmVFdklZWUFrd3Yyb1E2?=
 =?utf-8?B?UnhjUU9ldHF3OTJPMzhpRVc5ZHAwM09IUThXVEM4ekVQbjBrdVdTb29BM2hQ?=
 =?utf-8?B?RTJ1V1dialRteTlIVU56VnRWRmZnY0I2VS9hSmN5NERzbEFJL3RoWkczVFBl?=
 =?utf-8?B?SUl2NE5BSXRJZ2c3V0lZQjBzeTRlelVwRjV0NFFFcnZrdHNCSVZIZjF3cE1v?=
 =?utf-8?B?UDRHcm9NeTU3TzQxcEMyc3NueGQ1b1ZIUnBCWUdtLzlLSXVhMGNySTA0UlZt?=
 =?utf-8?B?Znp6OU5GZ3MyY3JhY0RHYXVkNitHU1oySTRuTVJFUHM2VmR2V3p0UnZSdzFP?=
 =?utf-8?B?MzRheThVRURER2dKRThkVjZjMmJlMVVOM1pucjIzU3FkUHdLTythYVcyVmx4?=
 =?utf-8?B?TWpkbjAxRHdldHNac093YjhxL2RjUU0yYzRoWHRtZGpUWk5RaXNjbWxkNUtG?=
 =?utf-8?B?c083MUhhRDFHb3FlT3VZTUx4WndVMlJSbHliVUVZL3QxZGwyL05mOHQvWHg5?=
 =?utf-8?B?dFpGemwwQkhQbjFkNXYwaWdwTlIzT3FrclhMZzN5b1hxYjdnMkgySWlSN2Fa?=
 =?utf-8?B?YTZVNXVRbzdvcnRUK21HVEZlSzF1NmtDbVhRZ1BUS3ZJdFgrSU5yZzRsR3JK?=
 =?utf-8?B?bmx2WWNLK2luVHZwYnZEaStGR05OSTFWMFo0dm9RN3BWaEtza2x0c1A2b0xM?=
 =?utf-8?B?V0lFSUE1amRzMWVHM0lkV2hsSnVqMXd6UTg1a2xNVnAwbTg4aWZKdWl1SVBa?=
 =?utf-8?B?TURKZmY0WFhKN2JQRWsva29jS1R5dlF1M01wTnZ6bjc0S09RMU0vWTRvUzFR?=
 =?utf-8?B?NmpvNU4wbGU5OWRTVElZZEpxdml2dWY4TmwvenA0MUN4VXVDZGg2b3Yzdzdr?=
 =?utf-8?B?d3VqemhjWDJnV1lUSVdnTnJjWGpPUUo0cEdiWkJJSWpNYm1UbFgzd2pPZUVh?=
 =?utf-8?B?SXdFZXhwL0pRK1dIT1g5NzJTZXdFQlptZjZkYUNzNW9UZk9JUTk5ZGJGRGxr?=
 =?utf-8?B?a3RkUU9FcE5jaGJ6ZVBXbERSZUQveVRCRXhxNkIrMDNWVDB0RlNaNjdGVmpm?=
 =?utf-8?B?dVdFVm1oTGN0aFJoQkhMR0VkeGd2T2dVQk1qTWtoQ1Bicko0bEk0SGNHenBl?=
 =?utf-8?B?bHJYUC83ckVXZnNRbTZDVmpHWkRVQWJEeEFKQm9JMEZ1NmJGYVhWVmdJOTl4?=
 =?utf-8?B?REE4K2d3YVgzSU1HQjFyVFlvMUpvYVhIY2oycVFCUy9LcEcvampKdG5GWkRF?=
 =?utf-8?B?c3ZFakE1V1dpTmFKNUtXSmQ4R214d1BxTmF3Tnl1YnFkUGt5dWNPeFJvOXdI?=
 =?utf-8?B?YU9sbVYyYi9JT09IcjJGaDRTSlVsY0hoRXVHWGtwWHo2NzdENEgyUGZZRlNu?=
 =?utf-8?B?TUJRTmtPQzEzWjMyK3BtWVdTTGRuSm1vbllQTU12U0pSMDRoRGpaNk9oMDgz?=
 =?utf-8?B?dFZkbURpS2FndHRYODRtMmJodmNjTFRRWHBuanBPWVBSQU0vZXEyQ0UvcVRo?=
 =?utf-8?B?eXFxcEE4bTQwdm1KQjVBMDBLWUR1TWVoV0FJTFdLeUxQbHRYaEJKejNHL0xs?=
 =?utf-8?B?TnhiRk5VdGFxQkE0RHc0dkRkN2tpbWp5QkVsSnVRZmFqTnc9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR03MB6226.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(366013)(1800799021)(7416011)(376011)(38070700015);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RVhMcXd4UkN1VURKemlmUEJ1Sk00SVhIM3dFWFJ1MnA3OXpsa21BUUpQNXpJ?=
 =?utf-8?B?Q2lqd1FZbFVMbU9mREFUYUxsbFhMOGFXK1pmTk9kNWJuV2Z2S2pvZ1VWdGY4?=
 =?utf-8?B?QTRPdnBEMkJ1ZVNiRlAyTjVpYXgxenFnVks3YVluRWlxMGt5TjNHVTRzMHYr?=
 =?utf-8?B?ZUZWS2ppbGVEY0tPQ1d1NW9NMjVJTHBIaVlETzF0bDFmMTh2bzhPN3VLMDUz?=
 =?utf-8?B?cGhzcFl3K09NYmkvMmsxWEsxc1B6UldpbHhlVGJ4aGEvY1dLYU1Hc3dUb2dT?=
 =?utf-8?B?aHlPOXI3Y2VVZEF1L2djTU52TkJSek1HRUl0clFPK3RtellNVmtRYnVmajdH?=
 =?utf-8?B?L1FPenRrM09Yekd4bzAybTVvWHhTTFlHeWZaRFBaQ2lCOFhlMVM0aUpYdlhY?=
 =?utf-8?B?QVkvY0xiQkVIVHF1dTdZeGJBYVhvcUo2ZTJYZlFUdnF3d2ZMMXRScVA5Rk1F?=
 =?utf-8?B?T2FrSC84N2QvSEh6QkYyaWVsNXRLcjVoT3BTTENOcW1Uc2w2Y2VJbW04YW0v?=
 =?utf-8?B?QnVHaFEyRnUyUFJBOElHL28rTFFLU2RLMTVNZS92bThUSmNCbUkwWXlyeUk3?=
 =?utf-8?B?S1IzMmxGTmFlckRVMXk5cnhqWVZQSDRCL3VUQWY1SDZVZUJEY1VlcVd3c2lP?=
 =?utf-8?B?d2lVTGxZZFhyM2wrY0svQlk5MkdFWEFQRmU0dHZ6Y1NPZG85Y0M2OGxKYmRM?=
 =?utf-8?B?VzFLbVhFL0VacG5MRDU3YXZ4cHluT0U4K3JFelFKTDdUUkVua0x4T0tmTkVH?=
 =?utf-8?B?YmJVdm1zL3hiTE5QcnJtQzBTazQwNEtsREt3WHhVRnVPNTJzU3psWmlydEpu?=
 =?utf-8?B?b0h1cEMvdXRycEg1UmJpZHZUT09sS2YvMjFyVWkydjBmZjRreDZ0dHB6a3VF?=
 =?utf-8?B?Z1o3V05oenlVUWVmUThucjFhYnVYL1BYamt6bDZoaEhlem1aeDdzbkNkUjll?=
 =?utf-8?B?UUh0b0FKd2FlS1IxTTdyS3Uzd21HdHMzRE5EakJ5YkdLTy9YQzd2OS9tZ2VG?=
 =?utf-8?B?d1BYd1VQdDNycWxmd2tlbzdWcExGZjlmMWs1NEloRElZN1FsS0VMQ2FSMG5o?=
 =?utf-8?B?cTZzQTdsUHJFNnpGUWFmRE5YMm5CRk1IdkpoZzhWK0VOcUcrYzRSbm9vZzUy?=
 =?utf-8?B?aEUzZVlWQmFkdmp0cHJBTVdVS290bitXZzZUWUlIdHNjRFBLN3NxdmRXZmkz?=
 =?utf-8?B?OUl5K3ZsYmZ5SkcvMXpQTmxneTlSbUZta0tkdTd5alFxa1ROUXJ3d1JUL1pR?=
 =?utf-8?B?M2FobWM5MXZHRG4zMTNUZE9oOVZsWXJPd04xM3hUbWcyMUN2eXU3NHJDaVM1?=
 =?utf-8?B?RzRVMTZNK1h1NzRxM0tiMUNUY0ZHTmNWNjQyQWVhV2xQNmI3QjFZQWM0Rm81?=
 =?utf-8?B?QUNvRUZpRDFST2VvUnNLSzFvUVR6UjVyMk5EM0wzOTUzRXIxWmxGbzd6RVpT?=
 =?utf-8?B?M3BnMGpmdEVCY0x2V2YxbEJvWThzdnBuTXdFNEpHZ2FOOWV2UjAxZVZKSGFr?=
 =?utf-8?B?NWI1U0xkVWlBelA0ZUV1ZmVRVEFkV1BnZDhSOXF6Mm15SlNKdjR3NzdjaTM4?=
 =?utf-8?B?L0ROYncvKzlka3U0Q09wMUlnRTMweVdMYUtaV1BDdGRDa2xDVk1GejY2eE5C?=
 =?utf-8?B?T1BBeVZyNmtEdzYzRGVqanlwUzRtcmFFY0RJNEdXbWUzdE1jK3NDV3EzQTZN?=
 =?utf-8?B?cWtZZFBhdVc0M2QydzNaSU1rMGZobHF2aXdwWE56Wk05ZXFNM1AxYkNBditC?=
 =?utf-8?B?SCtyODd2SzZleUwxYURTOE12Sk15dXl5N3F5RlV3a0U1MmwxMkJwRGxSZ2NR?=
 =?utf-8?B?YnpGUjd3Y2hrSk9ZazJBdmxBejNuTlFqNTIrWEtKUmtrT1FYSDVMbGI2Ym5p?=
 =?utf-8?B?eWM2WkN6S0NkZFljaGJlV3NDT1dSeDRKZFRtcytLSDRGR2k3a0c3bXVYWEEz?=
 =?utf-8?B?SjRQSG84RWVTNjRrVGVER1Z1K0dwejU1bUJoRU5MRjhybFdwK0xocEpFV2p6?=
 =?utf-8?B?T0FoOFBPR2J5aTVNbHYvZG9sZndYMUlxWndRblVzdUUxTk0rc1c2cjloQkl0?=
 =?utf-8?B?Q25oWGY2SHlSQVFtMllHZVNLeXRKRlVlYWk5dWVyVEFGd1IrK3Ztd0NBOEpR?=
 =?utf-8?B?eXRQRlEwb2V5bHhHbzhMU0orYzU5WXB3dkV0VHJIS2tQV1J1UTY1Tk1HNFBh?=
 =?utf-8?B?OWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <99A2EC9C1974EC43BAF6E097542E3C54@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR03MB6226.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce7d37d9-6335-4ed2-6611-08dc943ae4f4
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jun 2024 10:46:24.9509
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SG0YGT8nEkN1GwTLaGAZDRGO3TN0nv6tpLD9xpwMzCNJToeyWvTfrBS6DPeuls/mcTipuXLVQRx6D47kXhHL6VBvn7F3Qfl1YiXSba1AVO0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR03MB7247
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--8.980900-8.000000
X-TMASE-MatchedRID: 9886Ub8IUanUL3YCMmnG4ppWgCLYjjT9C/ExpXrHizzqLnOUXH9QdFyM
	cRJB+wt55JlNPX8nfeToHSc2VDU1/W4WiVVX+O7QEhGH3CRdKUV9LQinZ4QefKU8D0b0qFy9Iq9
	5DjCZh0z9RzpTdIDZ1dAtbEEX0MxBxEHRux+uk8jHUU+U0ACZwABIpxQnkcEieM2UtHru5X0AgT
	3Sf0lJwG+RiUHicBOWnqg/VrSZEiM=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--8.980900-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	086DA7E529963C9428B7B934E2A1FA6ACE9496283C84F85531CBD0AD77C770732000:8

PiA+ICsNCj4gPiArI2RlZmluZSBNVEtfMlA1R1BIWV9JRF9NVDc5ODgoMHgwMDMzOWMxMSkNCj4g
PiArDQo+ID4gKyNkZWZpbmUgTVQ3OTg4XzJQNUdFX1BNQiAibWVkaWF0ZWsvbXQ3OTg4L2kycDVn
ZS1waHktcG1iLmJpbiINCj4gDQo+IFlvdSBwcm9iYWJseSB3YW50IGEgTU9EVUxFX0ZJUk1XQVJF
KCkgc28gdGhlIGZpcm13YXJlIGdldHMgcGxhY2VkDQo+IGludG8NCj4gdGhlIGluaXRyZC4NCj4g
DQpBZ3JlZS4gSSdsbCBhZGQgTU9EVUxFX0ZJUk1XQVJFKCkgaW4gbmV4dCB2ZXJzaW9uLg0KDQo+
ID4gKyNkZWZpbmUgQkFTRTEwMFRfU1RBVFVTX0VYVEVORCgweDEwKQ0KPiA+ICsjZGVmaW5lIEJB
U0UxMDAwVF9TVEFUVVNfRVhURU5EKDB4MTEpDQo+ID4gKyNkZWZpbmUgRVhURU5EX0NUUkxfQU5E
X1NUQVRVUygweDE2KQ0KPiANCj4gVGhlc2UgZG9uJ3QgYXBwZWFyIHRvIGJlIHVzZWQuDQo+IA0K
PiAgICAgICBBbmRyZXcNCg0KU29ycnkgZm9yIHRoaXMgbGVmdC1vdmVyLiBJJ2xsIHJlbW92ZSB0
aGVzZSB0aHJlZSB1bnVzZWQgbWFjcm8gbmFtZXMNCmFuZCBQSFlfQVVYX0RQWF9NQVNLLg0KDQpC
UnMsDQpTa3kNCg==

