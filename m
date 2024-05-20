Return-Path: <netdev+bounces-97189-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B8FDB8C9C99
	for <lists+netdev@lfdr.de>; Mon, 20 May 2024 13:50:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6DBAC28330A
	for <lists+netdev@lfdr.de>; Mon, 20 May 2024 11:50:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8990155E74;
	Mon, 20 May 2024 11:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="SOzwkA9Q";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="qVwGNxsa"
X-Original-To: netdev@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB5025645E;
	Mon, 20 May 2024 11:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716205753; cv=fail; b=VstNAJ3EmMAgpjFmP1piblGwMmLokfdV49DnqVOd7oPmk4klSzRWJKEnbNY6G/cbHpDQZy4/YsaxcheSLxhmjsxYy7oybq7amZvWk2rST5pKcUksadVZ116pjnW/qu+i5t+EkdRds8lurFPA24K5gGAU2qZIqr0NJ+ajygEQOAc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716205753; c=relaxed/simple;
	bh=YhTqDGfLsszj8RJ+8D/ub8avX8yznVLCDQyr3R42yVw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BoOrP+Vdv3SNMEyCsI7qyCH0mHwPEldK5glaYJeJcJ5P58ER2WyVck2kdF3fBmTgbSYBDaZSSDsRSmfnbYXxAmNhxYbdItK62YCzV1dNTWqnQQ0zmDS2F//ZY+psTpCFKT0iPWNGfnn3MpQKLx14/p8yw/pEoOujifaUPH1dErM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=SOzwkA9Q; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=qVwGNxsa; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: f77f7388169e11efb92737409a0e9459-20240520
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=YhTqDGfLsszj8RJ+8D/ub8avX8yznVLCDQyr3R42yVw=;
	b=SOzwkA9QJBFqx33pIc6jmXcAUwxC6E5ERP9P8wOBL81bfutlxuEGg94bl5XsaXUB8GXcGZfm8EF5zRjU7EmfJtmNaZPCyqmrQf/yTw94o0But/tadS+s43v+kC/E0/GQq6wWdCUPtdcKKnlzUCIgiNZ/N5IrYOvAmFf6g2yG8ug=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.38,REQID:7eae1d37-fe67-4f3f-ab41-d3e404c7bc9b,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:82c5f88,CLOUDID:b047fb92-e2c0-40b0-a8fe-7c7e47299109,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: f77f7388169e11efb92737409a0e9459-20240520
Received: from mtkmbs09n1.mediatek.inc [(172.21.101.35)] by mailgw01.mediatek.com
	(envelope-from <skylake.huang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1006314393; Mon, 20 May 2024 19:49:08 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 20 May 2024 19:49:07 +0800
Received: from HK2PR02CU002.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 20 May 2024 19:49:07 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oOZBJIQFW8hKoBhsmMj+T1EDc/hZNW4fOsHtj0AerQxZ+l8+XniHxq4Fb1WoBh3hSz+aNE56rQv/jQ+WpoL3o70gh1QED62NAGuUxQu666BeUGE00nDAFFIsprzojI/fHntyLk447g39L+sz91Z7/VFXCyP1KhRLuknsHOo1UolTq7m3Tqfo6QlqnobyPBEKmBip3nit48slWYW1D685flJS15+B5qGTSur5EKZWDIymLyH2sozaPRlnfEOleKbonRy9dMuq4SOSdv2Gt4xtUZ3hS4X3dCuFHIKMEkbmY+7GaTmaR9VnJy6EAZ8PpO1HhboeQI8xEU0tMLUCKlzBaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YhTqDGfLsszj8RJ+8D/ub8avX8yznVLCDQyr3R42yVw=;
 b=DJYuTpMP0EijTDpKqg0BCMUCdf1fz8bt0jSeaosa65B8M4M1UWOd5fgSHw/sNA/HBTV+Or5j0cTAP70GoYQXlon54dF/ZiAWXA3DmgoDb1tYHZxJKIHXhJiHCkICviyQCxfZnP+4kzF1jiwf+BLHpqQ+8PTfCBjgc99FTGu8UQIInvePuHdtiEKopqoxmVHoq5zR0gTtw17POqBv+sJ/XHyoR45vyJ0TXB1uuVySEEjbwm1kMQQTDVkkQNCQv02xc1NW4E9ECQ77BGGFwD1mdBhZjiJ+WLMNmCMpNqr5LwKYNXtbF8bl56H74l26C468eAirN7EBJ8xExuv5YT2lPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YhTqDGfLsszj8RJ+8D/ub8avX8yznVLCDQyr3R42yVw=;
 b=qVwGNxsatAFG08gIg2y97dmOSCbQr+oN2Sj0x5BgUAPP+IJWKLO8hTK6akb55qQ9GP9lt1qlGLCkA0wLl0r88TfUCH0K6WzRo/rwYbwkXMwVzXkuTOjtChXTit/ku6K1p+D+4OHzBXniZ5JgbW8djGoP/v9AAu5MoEBmJLK5hZk=
Received: from KL1PR03MB6226.apcprd03.prod.outlook.com (2603:1096:820:8c::14)
 by SEZPR03MB6851.apcprd03.prod.outlook.com (2603:1096:101:96::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.16; Mon, 20 May
 2024 11:49:03 +0000
Received: from KL1PR03MB6226.apcprd03.prod.outlook.com
 ([fe80::f3:c11:8422:7ce3]) by KL1PR03MB6226.apcprd03.prod.outlook.com
 ([fe80::f3:c11:8422:7ce3%5]) with mapi id 15.20.7611.013; Mon, 20 May 2024
 11:49:03 +0000
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
Subject: Re: [PATCH net-next v2 5/5] net: phy: add driver for built-in 2.5G
 ethernet PHY on MT7988
Thread-Topic: [PATCH net-next v2 5/5] net: phy: add driver for built-in 2.5G
 ethernet PHY on MT7988
Thread-Index: AQHaqEVm+42yGefZlke0FSmJqexdqrGcNSIAgAPRvQA=
Date: Mon, 20 May 2024 11:49:03 +0000
Message-ID: <283c893aa17837e7189a852af4f88662cda5536f.camel@mediatek.com>
References: <20240517102908.12079-1-SkyLake.Huang@mediatek.com>
	 <20240517102908.12079-6-SkyLake.Huang@mediatek.com>
	 <cc0f67de-171e-45e1-90d9-b6b40ec71827@lunn.ch>
In-Reply-To: <cc0f67de-171e-45e1-90d9-b6b40ec71827@lunn.ch>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR03MB6226:EE_|SEZPR03MB6851:EE_
x-ms-office365-filtering-correlation-id: 435a41e0-a7f6-4064-ad9e-08dc78c2d8be
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|7416005|1800799015|376005|366007|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?bXF1cFZqWEdpdUxBSWw3V09heW9PbjRnSWpHVUxiR3VSWG9tVUN0YSs1enBN?=
 =?utf-8?B?RS9SSERnM2dNdHlUM2JsZUVMaEwzQWwydFVMTE0xL1MxYU9vbFVnTVA0U01U?=
 =?utf-8?B?Y0RtOUJ3cHhJaFhnWk1tdkx6b0pYeWFndDgwdXJDaWNqblZ5OFlWNjI3YU00?=
 =?utf-8?B?UTMrc2wzUXN6d3crNXA2dTJoZEtwWkc3YUJNK3A4ZlVHOEVJWDllczl3WklM?=
 =?utf-8?B?TS84Yi9kYXJnejlTZExJUGRIbUV3bjZIdWVPRmV2UVNDcDNlYlNHMEtNbXRs?=
 =?utf-8?B?NHBOM0JRKzVvK2ZhcVN1N000RjNBSnVrNy9WeFMyMDEzVmR6WlorcW9XSE10?=
 =?utf-8?B?amFWL2loNTN4NmEwN2IzU3JBWEE4Y0VBSU16bG5WLzlPZVdYMGhlSCtrVWhj?=
 =?utf-8?B?M2pjaGVMRW9ITGptNFREZkxKS0w0T0VuekJlSFBncDlTVzFET2w1ZTZTQTYv?=
 =?utf-8?B?NmsrRllkdldFRGIxcGQ0dUl6dTlWaVNmOFh2QUpHR0x0VTFnejVBREVUeG03?=
 =?utf-8?B?bERhRlpldmVpcmU5QVgwT2pUcHBPM3UrSndVSmxwcU50VXdtR2ExazJqWXlv?=
 =?utf-8?B?RVJ4ZEE5bkljd0J0cklMZ25IeVpqWHU1TGx0MGI2d0gzWU05NWVwdnJCSjk3?=
 =?utf-8?B?dDI4bWFOdUxnTXArL2ZkcXVJeUl3R1k4bFE4SDFRbjFxS3RFWnFqVTdVSWdE?=
 =?utf-8?B?UlpDNEcwZ0xGQ0I3WHQ3a0pzak9NdjlSaE1weS82MHIzOU1UOHFOdklhdEI0?=
 =?utf-8?B?RVlwczZUVGd5MVdERStxd3VORlgzelc2c09vdlVUZ3NlM3BqdEJEUzF0VERm?=
 =?utf-8?B?cUN3dUxnN1I3RjJ1TXgwaUsyc09LeERzOFpNcU15clpSZm1uaVNsQ05XWklE?=
 =?utf-8?B?azNPYjd0S3VsNklyUUwwR3lDT29CMmVxQ05TR09RZGhkTC80RkhDL0txTU5P?=
 =?utf-8?B?NCswWXJkK2h2eHVxZXRGMG5WOHZSY3ZpN1NMelFLb204RW9WN1RnTGxlNWpj?=
 =?utf-8?B?TW9DU0Y0R0NXMnlpNEFldDFkb3pEUU4wUzc3KzloUzhuYmhkZTFvR0ViNWlh?=
 =?utf-8?B?ZWNnQVNjMjVobVBVSmUzVHZxRDNGenZwYktFZ3ZOL0ZwdnRodUxVeERKM0hY?=
 =?utf-8?B?a0EzY2F1eWdvak96dG42aTg0UXczWFNQR1hGVHE4amhTNlEwNE52YmRlT0NR?=
 =?utf-8?B?enFGRmp1SzZqQVRVV3FvN0NRaXowUDR4enF6dG9hcUFkZ3lycDNSY0FBeWlG?=
 =?utf-8?B?WFJJSWROemFsZFkrMytLa2duL0R6S0t4Qnh3T1FXa3B0N3kxZlBPanlML3cx?=
 =?utf-8?B?V2FMZ2c5WE9EaFNpclFJV2ROZEF0NGtpbzdzMzU0ZkIwdWR2TzdmeC9DQ1JQ?=
 =?utf-8?B?QW83ZGQvRXFiNTBvWktIbzVMS3YrVEk5eTF4aVVIWGFwVVcvUytRZ3ZCMzlG?=
 =?utf-8?B?aDVrdlZsTjNpS2pic2Y0NWphOGxpdWhaUk5zNHdWT0hXUDBpZmdkZ1YrRE5V?=
 =?utf-8?B?ZG5kaWZ5UHhENHMwUzRBQ2J5MGJYQkpPOG8vcEtjeGQxdkVReWsvWGlnb2Yv?=
 =?utf-8?B?UlZqWU0wZXdYY3JtcEJPMzBoTzhFSTBBaTJjcVJyWHYvajhHcGcyM1BjMngv?=
 =?utf-8?B?VEdIMUlnbTdZSDQ4bHRGeS9hRnNGSzBWbzd0OGpuUFVDKzAzTWZnYVNGN1Vy?=
 =?utf-8?B?M3k2Z1lhRWxVY1U4TkJBQmRieklNRHNtUks2Q0UwR0VSdXNoek96bzRGbWFj?=
 =?utf-8?B?djI5dlBNOU4rV3J6azJvL2cxN0I2SENSUTVLVlFxQ1daMWVLR1FXSmdaMTBm?=
 =?utf-8?B?bHpBTjArdkcwSEliZUgxdz09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR03MB6226.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(376005)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Z1c2YTdybzRIdUZCVXJVLzNtdlBvV0VINHYzN0ZGRFBXOHRNVXVQdFl3ak9T?=
 =?utf-8?B?Z1VpTW9PbU1sYW95TnVQNXp1dnVEOFZmeHNISXpndVFzN2FiTndaVTkzelVR?=
 =?utf-8?B?eXdmUWZDWk52NUJhbTRZYkVtWWVOQktpYUNvYllFTzBPUmRSVlZjbk9IaGc5?=
 =?utf-8?B?QURLY25sUnlxNGRPb2hTZThQZ2pVZHEzSG1LQVVVaUY5dE1OSkc3Um1UUm54?=
 =?utf-8?B?TTZ0Wk1CWHkrVURBSTlna1grYlNaeUErZDhYQTJGY1Jtc0tvYVFGQzQ3bERO?=
 =?utf-8?B?ZUcrbkpmKzE4bkFNcUFzU2NQWjB5TTMwTzNCTUdTL0xoVGthTFBuN0tVT005?=
 =?utf-8?B?Zm4zLzdnSUNlN0xHamVPMlg0RzFhdGlpNUhRWTdDQjZDSU1ZNWhoaDVDQlpG?=
 =?utf-8?B?SVVGRTRlcjZZN3cvNjcyZ1ZHNHFjVlVLSXZLVGZHdXFsN29Ic3VBVlB2RW5X?=
 =?utf-8?B?WTVYNDdEK2VqTFpLZTVCaUpWYlZvbnphakxKSUI0UTFwNmlHc3lESmJ5MFgr?=
 =?utf-8?B?UEFodWltSWJRd0xDZ1JuanR2c0ZGNVowNjdBM0hGZm8zMFFqcHE0UzRONy9Y?=
 =?utf-8?B?YlNPQnNNUlhkRnBzQTVHNDB1alNTWlRPSGRsZlNnRlBhc1hmL2pqNW9oN1hQ?=
 =?utf-8?B?eGRNT0R2ZzE2MTI2YmVna2s4R1lxamZrVmVGMjA2ajJTVVQ5dzIvY1I1R3hU?=
 =?utf-8?B?LzF1RUR6VGh5VmRPKzVlV1lzdWx5WnFkZ25wNTNPQ1VYR0lDRmUrejFsWnpP?=
 =?utf-8?B?ekJ5R3FBWlBENFJLWXBaUzcxQWt0Rk1uaFhxaWxZNmlTc2QrVi9zZG9kSjZr?=
 =?utf-8?B?MUw2VW52TlhiR2UwMlRtRGgxZVdoMXMrNnMwYzgzb0M2SWlNSGN2T3liTjFq?=
 =?utf-8?B?SXNjQ00yQ2F1d0Rua1BDUGxvRTNDTEtBUVVES09oOUpPdUdvYXdobXVKZGJK?=
 =?utf-8?B?MHowb25wNVVqSHBFNTRPSUkxR2lDNWcvK3NaM3g3Qml6YmNrWmFjdUhHY1Yy?=
 =?utf-8?B?UldFQi9HSUhLdmNhbEdyTXB4OTQrd1FQWGhkTjlCWkVnVjVMZmVOMjFSUjgw?=
 =?utf-8?B?b2RXbTFkbXBQWDdoRTRhOHBPTXZuQkQxZ0dYNzhEbnAxRlRJcXlBQVVmNFNJ?=
 =?utf-8?B?bUkvZkZxdlNnbTQ2Q3NMcUtJWGhGM3Fxa1RrRTZIU0pzWmxwU21GRy9YQXll?=
 =?utf-8?B?amNjUEVOUVBQbExlVDVWQ3JXRjFBRDVsblNwakFvcy9nRkJPNFZwN3FHa2VD?=
 =?utf-8?B?N3NWTWFhUVVpT0tPZThkQUVUK05MQVVwZjc4TFFCLzBTcXpER0wwL3VTQjJ4?=
 =?utf-8?B?K29WMEJNU1NHUXlKU0xsVmhJRnk2aUl2dGdiYXhiSlNMNWFvZEhIQzdtOTYr?=
 =?utf-8?B?WjhyTGRjWWE4SjZBMFl0VDZsZDdRNXVqeHd2MnVVVzRHTG13TTN0REp2Vk1K?=
 =?utf-8?B?SGFXRjJMSTdiWDVNUnY1QW1VMDJhSnljR0d3NTBWTE5RRmhOYXEzM1EwZmk2?=
 =?utf-8?B?R3BsNFdRU2lnR0JoRzEzcENpQUVYeEdzNWZRaE01WURodjBlUzRqTExvbnBx?=
 =?utf-8?B?YmkxNUNFNXVUbTQrSnQzSUFrT1QrbFNiOTVMd3plQjJKdS80Y2dpUWdNNVR3?=
 =?utf-8?B?NS9xV2FMc3YwRlREZFdLSFlzcTV0Q0JLbkpMemtEd3pyYmlDeDZMcDNFeUdo?=
 =?utf-8?B?dzlKVUZ2OUtMZFRjakp0Qno2MFUwT0dyTUdOaU9hU2EwcC82d1lOUkZyVHkz?=
 =?utf-8?B?eTAvMmplZXJxTlVZdndaQmR1ak5TNHBjYWI3T0FrUWp5MGVJR0RvZzY2MW8y?=
 =?utf-8?B?RElFK3dZTEJxQ3pqekl1N2k4U2NFQmxBeVoydjBjbmJWczJFZkZYU1AyWjFu?=
 =?utf-8?B?OHduSWcrd2ZzY25Gbm4zczVIVStUaXVCeFdRQW1DK0RDNWJQNUl6RStHSGxF?=
 =?utf-8?B?clAwdUppaW42dE9Fd0ozN1BvVDY3bWFqSEEySWNPU01IdHF4NFlmcXhVL3h6?=
 =?utf-8?B?SVRiYUgxMSt0RGUxTlNpZzluVk9DS2NTNTFzdk9ONHRZSUJUUjVVTEtEaFM0?=
 =?utf-8?B?eTNnNW45blV5TkVncnduU2hXMmZuRHN5UjFRQUhGbm9hWFJaYzMxb1hWZ3FR?=
 =?utf-8?B?bGcrWFBvTC9BTy80WHM2R0xTUzRyaDlZc0RMRExnZzdaQ21FMmxrUTJDUUF6?=
 =?utf-8?B?UlE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7A8E3ECE141E3F4E86D460B0A5434DCA@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR03MB6226.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 435a41e0-a7f6-4064-ad9e-08dc78c2d8be
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 May 2024 11:49:03.5116
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6Fzi4zLAZG6doqmP7XkYJ1qgOjV0JM7ESbfZX9iJvp5XHwQZhUlAAX9MUizvFy3lW67kZ5S5HQHDlnQ+hERJUCIKjkhNJ+OZRDbwai8gwoE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR03MB6851

T24gU2F0LCAyMDI0LTA1LTE4IGF0IDAzOjI5ICswMjAwLCBBbmRyZXcgTHVubiB3cm90ZToNCj4g
IAkgDQo+IEV4dGVybmFsIGVtYWlsIDogUGxlYXNlIGRvIG5vdCBjbGljayBsaW5rcyBvciBvcGVu
IGF0dGFjaG1lbnRzIHVudGlsDQo+IHlvdSBoYXZlIHZlcmlmaWVkIHRoZSBzZW5kZXIgb3IgdGhl
IGNvbnRlbnQuDQo+ICA+ICtzdGF0aWMgaW50IG10Nzk4eF8ycDVnZV9waHlfY29uZmlnX2luaXQo
c3RydWN0IHBoeV9kZXZpY2UNCj4gKnBoeWRldikNCj4gPiArew0KPiA+ICtzdHJ1Y3QgbXRrX2ky
cDVnZV9waHlfcHJpdiAqcHJpdiA9IHBoeWRldi0+cHJpdjsNCj4gPiArc3RydWN0IGRldmljZSAq
ZGV2ID0gJnBoeWRldi0+bWRpby5kZXY7DQo+ID4gK2NvbnN0IHN0cnVjdCBmaXJtd2FyZSAqZnc7
DQo+ID4gK3N0cnVjdCBwaW5jdHJsICpwaW5jdHJsOw0KPiA+ICtpbnQgcmV0LCBpOw0KPiA+ICt1
MTYgcmVnOw0KPiA+ICsNCj4gPiAraWYgKCFwcml2LT5md19sb2FkZWQpIHsNCj4gPiAraWYgKCFw
cml2LT5tZDMyX2VuX2NmZ19iYXNlIHx8ICFwcml2LT5wbWJfYWRkcikgew0KPiA+ICtkZXZfZXJy
KGRldiwgIk1EMzJfRU5fQ0ZHIGJhc2UgJiBQTUIgYWRkcmVzc2VzIGFyZW4ndCB2YWxpZFxuIik7
DQo+ID4gK3JldHVybiAtRUlOVkFMOw0KPiA+ICt9DQo+ID4gKw0KPiA+ICtyZXQgPSByZXF1ZXN0
X2Zpcm13YXJlKCZmdywgTVQ3OTg4XzJQNUdFX1BNQiwgZGV2KTsNCj4gPiAraWYgKHJldCkgew0K
PiA+ICtkZXZfZXJyKGRldiwgImZhaWxlZCB0byBsb2FkIGZpcm13YXJlOiAlcywgcmV0OiAlZFxu
IiwNCj4gPiArTVQ3OTg4XzJQNUdFX1BNQiwgcmV0KTsNCj4gPiArcmV0dXJuIHJldDsNCj4gPiAr
fQ0KPiA+ICsNCj4gPiArcmVnID0gcmVhZHcocHJpdi0+bWQzMl9lbl9jZmdfYmFzZSk7DQo+ID4g
K2lmIChyZWcgJiBNRDMyX0VOKSB7DQo+ID4gK3BoeV9zZXRfYml0cyhwaHlkZXYsIE1JSV9CTUNS
LCBCTUNSX1JFU0VUKTsNCj4gPiArdXNsZWVwX3JhbmdlKDEwMDAwLCAxMTAwMCk7DQo+ID4gK30N
Cj4gPiArcGh5X3NldF9iaXRzKHBoeWRldiwgTUlJX0JNQ1IsIEJNQ1JfUERPV04pOw0KPiA+ICsN
Cj4gPiArLyogV3JpdGUgbWFnaWMgbnVtYmVyIHRvIHNhZmVseSBzdGFsbCBNQ1UgKi8NCj4gPiAr
cGh5X3dyaXRlX21tZChwaHlkZXYsIE1ESU9fTU1EX1ZFTkQxLCAweDgwMGUsIDB4MTEwMCk7DQo+
ID4gK3BoeV93cml0ZV9tbWQocGh5ZGV2LCBNRElPX01NRF9WRU5EMSwgMHg4MDBmLCAweDAwZGYp
Ow0KPiA+ICsNCj4gPiArZm9yIChpID0gMDsgaSA8IGZ3LT5zaXplIC0gMTsgaSArPSA0KQ0KPiA+
ICt3cml0ZWwoKigodWludDMyX3QgKikoZnctPmRhdGEgKyBpKSksIHByaXYtPnBtYl9hZGRyICsg
aSk7DQo+IA0KPiBZb3Ugc2hvdWxkIG5vdCB0cnVzdCB0aGUgZmlybXdhcmUuIEF0IGxlYXN0IGRv
IGEgcmFuZ2UgY2hlY2suIEhvdyBiaWcNCj4gaXMgdGhlIFNSQU0gdGhlIGZpcm13YXJlIGlzIGJl
aW5nIHdyaXR0ZW4gaW50bz8gSWYgeW91IGFyZSBnaXZlbiBhDQo+IGZpcm13YXJlIHdoaWNoIGlz
IDFNQiBpbiBzaXplLCB3aGF0IHdpbGwgaGFwcGVuPw0KPiANCkZpeCBpbiB2My4NCg0KPiA+ICty
ZWxlYXNlX2Zpcm13YXJlKGZ3KTsNCj4gPiArDQo+ID4gK3dyaXRldyhyZWcgJiB+TUQzMl9FTiwg
cHJpdi0+bWQzMl9lbl9jZmdfYmFzZSk7DQo+ID4gK3dyaXRldyhyZWcgfCBNRDMyX0VOLCBwcml2
LT5tZDMyX2VuX2NmZ19iYXNlKTsNCj4gPiArcGh5X3NldF9iaXRzKHBoeWRldiwgTUlJX0JNQ1Is
IEJNQ1JfUkVTRVQpOw0KPiA+ICsvKiBXZSBuZWVkIGEgZGVsYXkgaGVyZSB0byBzdGFiaWxpemUg
aW5pdGlhbGl6YXRpb24gb2YgTUNVICovDQo+ID4gK3VzbGVlcF9yYW5nZSg3MDAwLCA4MDAwKTsN
Cj4gPiArZGV2X2luZm8oZGV2LCAiRmlybXdhcmUgbG9hZGluZy90cmlnZ2VyIG9rLlxuIik7DQo+
IA0KPiBJcyB0aGVyZSBhIHZlcnNpb24gYXZhaWxhYmxlIGFueXdoZXJlIGZvciB0aGUgZmlybXdh
cmU/DQo+IA0KQ3VycmVudGx5LCBJIHVzZSAiJG1kNXN1bSAvbGliL2Zpcm13YXJlL21lZGlhdGVr
L210Nzk4OC9pMnA1Z2UtcGh5LQ0KcG1iLmJpbiIgY29tbWFuZCB0byBjaGVjayB2ZXJzaW9uLg0K
DQo+ID4gK3N0YXRpYyBpbnQgbXQ3OTh4XzJwNWdlX3BoeV9nZXRfZmVhdHVyZXMoc3RydWN0IHBo
eV9kZXZpY2UNCj4gKnBoeWRldikNCj4gPiArew0KPiA+ICtpbnQgcmV0Ow0KPiA+ICsNCj4gPiAr
cmV0ID0gZ2VucGh5X2M0NV9wbWFfcmVhZF9hYmlsaXRpZXMocGh5ZGV2KTsNCj4gPiAraWYgKHJl
dCkNCj4gPiArcmV0dXJuIHJldDsNCj4gPiArDQo+ID4gKy8qIFdlIGRvbid0IHN1cHBvcnQgSERY
IGF0IE1BQyBsYXllciBvbiBtdDc5ODguDQo+IA0KPiBUaGF0IGlzIGEgTUFDIGxpbWl0YXRpb24s
IHNvIGl0IHNob3VsZCBiZSB0aGUgTUFDIHdoaWNoIGRpc2FibGVzDQo+IHRoaXMsDQo+IG5vdCB0
aGUgUGh5Lg0KPiANCkFjdHVhbGx5IHRoaXMgcGh5IGlzIHN0cmljdGx5IGJpbmRlZCB0byAoWEZJ
KU1BQyBvbiB0aGlzIHBsYXRmb3JtLg0KU28gSSBkaXJlY3RseSBkaXNhYmxlIEhEWCBmZWF0dXJl
IG9mIFBIWS4NCg0KPiA+ICsvKiBGSVhNRTogQU4gZGV2aWNlIChNRElPX0RFVlNfQU4paXMgaW5k
ZWVkIGluIHRoaXMgcGFja2FnZS4NCj4gSG93ZXZlciwgTURJT19ERVZTX0FOIHNlZW1zDQo+ID4g
KyAqIHRoYXQgaXQgd29uJ3QgYmUgc2V0IGFzIHdlIGRldGVjdCBwaHlkZXYtPmM0NV9pZHMubW1k
c19wcmVzZW50LiANCj4gU28gQXV0b25lZ19CSVQgd29uJ3QgYmUNCj4gPiArICogc2V0IGluIGdl
bnBoeV9jNDVfcG1hX3JlYWRfYWJpbGl0aWVzKCksIGVpdGhlci4gV29ya2Fyb3VuZCBoZXJlDQo+
IHRlbXBvcmFyaWx5Lg0KPiA+ICsgKi8NCj4gPiArbGlua21vZGVfc2V0X2JpdChFVEhUT09MX0xJ
TktfTU9ERV9BdXRvbmVnX0JJVCwgcGh5ZGV2LQ0KPiA+c3VwcG9ydGVkKTsNCj4gPiArDQo+ID4g
K3JldHVybiAwOw0KPiA+ICt9DQo+ID4gKw0KPiA+ICtzdGF0aWMgaW50IG10Nzk4eF8ycDVnZV9w
aHlfcmVhZF9zdGF0dXMoc3RydWN0IHBoeV9kZXZpY2UgKnBoeWRldikNCj4gPiArew0KPiA+ICt1
MTYgYm1zcjsNCj4gPiAraW50IHJldDsNCj4gPiArDQo+ID4gKy8qIFVzZSB0aGlzIGluc3RlYWQg
b2YgZ2VucGh5X2M0NV9yZWFkX2xpbmsoKSBiZWNhdXNlIE1ESU9fREVWU19BTg0KPiBiaXQgaXNu
J3Qgc2V0IGluDQo+ID4gKyAqIHBoeWRldi0+YzQ1X2lkcy5tbWRzX3ByZXNlbnQuDQo+IA0KPiBZ
b3UgaGF2ZSB0aGlzIHR3aWNlIG5vdy4gSXMgdGhlIGhhcmR3YXJlIGJyb2tlbj8gSWYgc28sIG1h
eWJlIGNoYW5nZQ0KPiBwaHlkZXYtPmM0NV9pZHMubW1kc19wcmVzZW50IGluIHRoZSBwcm9iZSBm
dW5jdGlvbiB0byBzZXQgdGhlIGJpdD8NCj4gDQpGaXggaW4gdjMuDQoNCj4gPiArICovDQo+ID4g
K3JldCA9IGdlbnBoeV91cGRhdGVfbGluayhwaHlkZXYpOw0KPiA+ICtpZiAocmV0KQ0KPiA+ICty
ZXR1cm4gcmV0Ow0KPiA+ICsNCj4gPiArcGh5ZGV2LT5zcGVlZCA9IFNQRUVEX1VOS05PV047DQo+
ID4gK3BoeWRldi0+ZHVwbGV4ID0gRFVQTEVYX1VOS05PV047DQo+ID4gK3BoeWRldi0+cGF1c2Ug
PSAwOw0KPiA+ICtwaHlkZXYtPmFzeW1fcGF1c2UgPSAwOw0KPiA+ICsNCj4gPiArLyogV2UnbGwg
cmVhZCBsaW5rIHNwZWVkIHRocm91Z2ggdmVuZG9yIHNwZWNpZmljIHJlZ2lzdGVycyBkb3duDQo+
IGJlbG93LiBTbyByZW1vdmUNCj4gPiArICogcGh5X3Jlc29sdmVfYW5lZ19saW5rbW9kZSAoQU4g
b24pICYgZ2VucGh5X2M0NV9yZWFkX3BtYSAoQU4NCj4gb2ZmKS4NCj4gPiArICovDQo+ID4gK2lm
IChwaHlkZXYtPmF1dG9uZWcgPT0gQVVUT05FR19FTkFCTEUgJiYgcGh5ZGV2LT5hdXRvbmVnX2Nv
bXBsZXRlKSANCj4gew0KPiA+ICtyZXQgPSBnZW5waHlfYzQ1X3JlYWRfbHBhKHBoeWRldik7DQo+
ID4gK2lmIChyZXQgPCAwKQ0KPiA+ICtyZXR1cm4gcmV0Ow0KPiA+ICsNCj4gPiArLyogQ2xhdXNl
IDQ1IGRvZXNuJ3QgZGVmaW5lIDEwMDBCYXNlVCBzdXBwb3J0LiBSZWFkIHRoZSBsaW5rDQo+IHBh
cnRuZXIncyAxRw0KPiA+ICsgKiBhZHZlcnRpc2VtZW50IHZpYSBDbGF1c2UgMjINCj4gPiArICov
DQo+ID4gK3JldCA9IHBoeV9yZWFkKHBoeWRldiwgTUlJX1NUQVQxMDAwKTsNCj4gPiAraWYgKHJl
dCA8IDApDQo+ID4gK3JldHVybiByZXQ7DQo+ID4gK21paV9zdGF0MTAwMF9tb2RfbGlua21vZGVf
bHBhX3QocGh5ZGV2LT5scF9hZHZlcnRpc2luZywgcmV0KTsNCj4gPiArfSBlbHNlIGlmIChwaHlk
ZXYtPmF1dG9uZWcgPT0gQVVUT05FR19ESVNBQkxFKSB7DQo+ID4gKy8qIE1hc2sgbGluayBwYXJ0
bmVyJ3MgYWxsIGFkdmVydGlzaW5nIGNhcGFiaWxpdGllcyB3aGVuIEFOIGlzDQo+IG9mZi4gSW4g
ZmFjdCwNCj4gPiArICogaWYgd2UgZGlzYWJsZSBhbnR1bmVnLCB3ZSBjYW4ndCBsaW5rIHVwIGNv
cnJlY3RseToNCj4gPiArICogICAyLjVHLzFHOiBOZWVkIEFOIHRvIGV4Y2hhbmdlIG1hc3Rlci9z
bGF2ZSBpbmZvcm1hdGlvbi4NCj4gPiArICogICAxMDBNOiBXaXRob3V0IEFOLCBsaW5rIHN0YXJ0
cyBhdCBoYWxmIGR1cGxleCwgd2hpY2ggdGhpcyBwaHkNCj4gZG9lc24ndCBzdXBwb3J0Lg0KPiA+
ICsgKiAgIDEwTTogRGVwcmVjYXRlZCBpbiB0aGlzIGV0aGVybmV0IHBoeS4NCj4gPiArICovDQo+
IA0KPiBTbyBpdCBzb3VuZHMgbGlrZSBwaHlkZXYtPmF1dG9uZWcgPT0gQVVUT05FR19ESVNBQkxF
IGlzIGJyb2tlbiB3aXRoDQo+IHRoaXMgaGFyZHdhcmUuIFNvIGp1c3QgZG9uJ3QgYWxsb3cgaXQs
IHJldHVybiAtRU9QTk9UU1VQUCBpbg0KPiBjb25maWdfYW5lZygpDQo+IA0KPiAgICAgIEFuZHJl
dw0KRml4IGluIHYzLg0K

