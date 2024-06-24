Return-Path: <netdev+bounces-106061-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88FEC9147A7
	for <lists+netdev@lfdr.de>; Mon, 24 Jun 2024 12:39:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC15D1C20990
	for <lists+netdev@lfdr.de>; Mon, 24 Jun 2024 10:39:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9045A1369AF;
	Mon, 24 Jun 2024 10:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="RgOw8tjw";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="ieJPqyR9"
X-Original-To: netdev@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42D6613699A;
	Mon, 24 Jun 2024 10:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719225580; cv=fail; b=bKe71pBqsLBWjb4XEgVGH1ouAvuxjsysNStJJIXuZegv/34kVTewGaKsyeQc5TlR6ajzGB80hXZaaVMwOcRvzl0ZiN65esI90kmi5Z40nzofj4L1MZuJ3EU5Vq4cy0epiSuwVKirHeDIjkWNUYqt0/UZUaPJVWNmUIJ/qI9YKms=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719225580; c=relaxed/simple;
	bh=1QXfDktWgyeazoFePT2M4jbmszrN3jNZ4WgvM3jyiOM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hPbGmYhYLB1AqrohNHBmiySTAEfP3hoXtQXZSwf9Kmtyo0fl7NA9dFE2PBYlcKiEMgEO0JG/dbCAC5Q5PfMDZG8kRxkQv34xSaEzecPOApZBmOUDu4p+0ZAo88CbrgE/9N2zUmD0IrgIjlZT89K9BJKqb9Y77UAZUEAbkteXh6M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=RgOw8tjw; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=ieJPqyR9; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 0b46a7be321611ef99dc3f8fac2c3230-20240624
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=1QXfDktWgyeazoFePT2M4jbmszrN3jNZ4WgvM3jyiOM=;
	b=RgOw8tjw/r1UrEZBjiJJ/K0oTyxYGJVFaFORb6EJE+izM5LXyZGd1uzs1/+Bqq5mSZUU2nj7dqrSu7jKV4TJw7/T6WhaiEJO8YlNNhvC8JW9HV5aLexVV5PcdSsYVJW0Ls2cHd9HbGLm9h9YM5urcotSAKMDRzZMDVCo/rR/GIU=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.39,REQID:671c1143-d568-4c3c-8208-44606e5cab5c,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:393d96e,CLOUDID:2fc25d94-e2c0-40b0-a8fe-7c7e47299109,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 0b46a7be321611ef99dc3f8fac2c3230-20240624
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
	(envelope-from <skylake.huang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1214101006; Mon, 24 Jun 2024 18:39:33 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 24 Jun 2024 18:39:32 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 24 Jun 2024 18:39:32 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CAVBn0Z4Cra/6kKouBH6pohntz+IyzQUNDyIKm6ayqUFjxoavrsZpD1AnQEArm+9ahzBr3nyiB/2xZBU8Z8gPPuWgsab0Fk68b0ZxgUXWEWG95uj5x1aojTwnmtq6MgMYrZV79/3PdhAWIYZ52m/qX+xMTwNqSBBTyhKV5dPhoX72CCBa69uIpf1n/e3Zho7bjQWLHz9WfETb8fNW7Fn8PtnxSYnQsGl+AscIqaS3SwQtXq9mC5MvgThZnb7TlE4aEK+asVLieFDarUkSRzPEBQewUzxxs9TefkSjbYjYR/8j9804W/LL4WwLuY8DefkVwRCY4Pjn5gThv5hGSQxQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1QXfDktWgyeazoFePT2M4jbmszrN3jNZ4WgvM3jyiOM=;
 b=XKg6Lae4wAA7nUApt1qP5bMOQRmnHuKOF7srklaR/V4meJ05+0tXxiAz/DPCrx5GNrL/GDkEZfK0IrARzHKFlHoTEdyQmDZf/1cD7VzDBawkm70BaYydYmBQcUpez0waT3b8xn+Z3X0mSUi83y0NPJjuRUHSRRgaIuxCLwYRPyKmKKMtKOng/dXtQd0/q8pKDpX56a3NwN57zJZLdtOvf8e3rAmmdFRgrkdFyH4fGuJdk0cEA2I8x2WN7wn9vjaQkWxX03lj4UL4k+GUnMTcyryR2CwVylbH6/cYgQcygCr5gYmmB7GU3L40UEwlN5TUXT3zFS6lmNi6359FJPhZSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1QXfDktWgyeazoFePT2M4jbmszrN3jNZ4WgvM3jyiOM=;
 b=ieJPqyR9DjPusIyXKj7/JMR7g3Rujr8SyuAWEoeivMEl3eIyrcGjbYtXhEgZaxmhHVZ4jNGnFIVrX4MDTFgC1nkvQ8ZD9ABpjDMxiLMpqSbYMGSD8iF18BRUa758OwyoNCVVEQi9w9wmjbg4kpTzK2ia4VSLEd7Hw2H1GZaL4GI=
Received: from KL1PR03MB6226.apcprd03.prod.outlook.com (2603:1096:820:8c::14)
 by SEZPR03MB7193.apcprd03.prod.outlook.com (2603:1096:101:e6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.26; Mon, 24 Jun
 2024 10:39:28 +0000
Received: from KL1PR03MB6226.apcprd03.prod.outlook.com
 ([fe80::f3:c11:8422:7ce3]) by KL1PR03MB6226.apcprd03.prod.outlook.com
 ([fe80::f3:c11:8422:7ce3%5]) with mapi id 15.20.7698.025; Mon, 24 Jun 2024
 10:39:28 +0000
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
Subject: Re: [PATCH net-next v8 07/13] net: phy: mediatek: add MT7530 &
 MT7531's PHY ID macros
Thread-Topic: [PATCH net-next v8 07/13] net: phy: mediatek: add MT7530 &
 MT7531's PHY ID macros
Thread-Index: AQHaw9Ywnyw9RjeJyki+vFpV8FUknrHUDIIAgAKxYwA=
Date: Mon, 24 Jun 2024 10:39:28 +0000
Message-ID: <22eb091dd34bbd9b3a159eee9d8b2557c83c434f.camel@mediatek.com>
References: <20240621122045.30732-1-SkyLake.Huang@mediatek.com>
	 <20240621122045.30732-8-SkyLake.Huang@mediatek.com>
	 <9515b596-c151-4e46-95f1-768e76de34cc@lunn.ch>
In-Reply-To: <9515b596-c151-4e46-95f1-768e76de34cc@lunn.ch>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR03MB6226:EE_|SEZPR03MB7193:EE_
x-ms-office365-filtering-correlation-id: f372abfb-ddf9-44a1-6c79-08dc9439ec83
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230037|7416011|366013|1800799021|376011|38070700015;
x-microsoft-antispam-message-info: =?utf-8?B?amFNZHh1dm9qMDNKT2FNUGtNaVVUOFN0Sm5kelR4MWJSSzEyYVY3WTNQRTZh?=
 =?utf-8?B?dThERnJQblc4UVczbTZudDNnSVFFTVZwYnEwSFN2OEx3Ri9yOFhMS2FWMGJL?=
 =?utf-8?B?VGhQUGhqc21LK1FEajVxeE1ldVdMMXFJT2FxemJLVUZpU2o5aFlyMnp0RUdG?=
 =?utf-8?B?Z2NzdDJqUnBsRXZ3NG1IcmJ0aHQ0ZlQwYlJVVHlBc2toWkcrV3pWa05rQTM5?=
 =?utf-8?B?ZlZpa1hhV1JpbDVXcHVhMkVNNXR1SHZSVit0N3BTM2dRRGxQUktkNHhieEZD?=
 =?utf-8?B?VmxxZm9Tb0NCelZrVHBMNVNWak92L1hjY3ZQenBNOVVXMGkrajkwZUUrQTlj?=
 =?utf-8?B?Ui9DU0dVQkhtdW9Da3NQREhna2hPYUk2YUlDZEx3Q2pORU5TTFptSEhpTFM4?=
 =?utf-8?B?Y0FzZk44UkZnL1hnN3VnOXUwcFNkRG5iWjlIK0xYWURMSXMzTkFkUm52RTFn?=
 =?utf-8?B?SThHWWNEQ1ovdVdDelRPNkRpbU85VG8zemxhdGZGaFo0dUY2eFgvQ01WSEpk?=
 =?utf-8?B?ZHBicVpSMXZDTlV4Tlc2TXlQVzgxS0owb01rdnl3K1UySDdxbE4zSWwwK3lB?=
 =?utf-8?B?WFFDTVNJRSttMmtlOE91YzdTUk44b2xWeUF5YTJtSGV3d1RML3FDbWxma3Qv?=
 =?utf-8?B?ZnJhUnRuZm9KRzVDYnpFeExEYVIvVCsyV1dzYURyQjlhb00zQ0lHdGlycXVS?=
 =?utf-8?B?a0tsbHlVYVAzcUtKQVIyQ04zSTh4K1E5anduTzBTd0pKVkxvWjhDeVVpc0U4?=
 =?utf-8?B?UlUyNG8zdXR4WFR2U0lGbXNPVkY2SEhFejhNUXhXc2VnN1VxOGg1Q1NDNGtS?=
 =?utf-8?B?cDFCcDl2UUVuZ0hpUEdvT0NUTTMrL3N1aGFZRHFYbTZ6RXduOUo4cWxwakVl?=
 =?utf-8?B?NUxlVWROaklsczBYaXN1L0xaVEFqNUIxdEI1cFZ3Z052RUZRS0JybWdsN3Yy?=
 =?utf-8?B?V1FJcjJGL1hBM2xZLysydTd4Wk9QcGlGQ0VER0FXQUVqUDllNDNpOFJVajUy?=
 =?utf-8?B?VlFVT1diT0Q4TjdxMVh6cHdUeG5uZUx2NitNM3c3TURwM3liTm9aL2lqci9K?=
 =?utf-8?B?aURmWXY1d3NWZXZRUDRrWmVjNVl1d083M2w2TzNSRnlBNDdONDl5eko1c0lq?=
 =?utf-8?B?eXhBSjRDVGprZ1ZrTERGQ0g2dDdzL0h0aW1lYkRDR2IxOFVoZzBLN0huTnI1?=
 =?utf-8?B?K3hkdFNhczJ6YUluaVlqelBJNXkrWnc3VTMwdU1NSkdMMjRzMklQK3BTYkx1?=
 =?utf-8?B?YndaZTBxcytpaHJuc2RMQ2xKd3N5ZXBDZndoNTh6QnZwL2xqdUowQWhNZzc2?=
 =?utf-8?B?RDNtSk1ZL1FyQUw1Ni9XZlRjZkQ3MjFyRUJGTm5lOWNzdTZoMmVYNW0xaE1R?=
 =?utf-8?B?QnZZL2ErNVViVExsTDdkTE1yT294K1dlZFYxUlI4YU5yOVFNZEpMLy9ad0h2?=
 =?utf-8?B?cTFkVmpIK2QrRThtNnJaQzlZQmNoZklwVFZvL1NJamh0RUxXenJJU0RBT2tq?=
 =?utf-8?B?Q0gxcGRXYkt1Y3FmOXJCcSt6bWFoSzRmcFlBNHZHaHc2dDREM0VjZlF0c1R3?=
 =?utf-8?B?NkVLWngyRDl4QlFMQmRrNnJScDVET2czL2dNZnoydWpKMTI1SGF5UnpUWk5E?=
 =?utf-8?B?TmRzY1lYZEdTczZsbFpQME4wY0hleVgxcGpBdk9MbTU5UzJ0Q2N4U1RPVXUz?=
 =?utf-8?B?eDI4MEpUbk5lMDhtei9VZ255TWlTQ2xJdXpBbU4xMmxKY2VTcFJJSGhFcSsz?=
 =?utf-8?B?RXFKSUt2akxQNWpRRHB4ZXYwWkJyTk5tdmdVb043a3VoelR3eGtJTVJBdThF?=
 =?utf-8?Q?GbTmNyKJqlYcU3TtMmI2KSPkX50VQIIwwidgQ=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR03MB6226.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(7416011)(366013)(1800799021)(376011)(38070700015);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dDRwQVBDQTlMZDdNWGhidStIaFhRS2x6THFjM2pmS2VXQ0xueWFsZUc3VklQ?=
 =?utf-8?B?Z0Y1OTNDRmdFL3o1UGtKV215RzNzbXlNckhjeXVjRzh6dzNHWnEzRjZPQXAy?=
 =?utf-8?B?Y3BHQ2ZRSnZqemRUU2VyN2xPVGVETjYyZFN5WXR1VU5oRjdlUTFrdTdQYVZn?=
 =?utf-8?B?MFg0YkE1OENiejdobVdpQVVpVGFGK3VEN1h0K2d4TnAxZUxudTFyVWxLbHFD?=
 =?utf-8?B?cFVONXBsNWVtcEkzMFZvWFhBNk9ab0daYkp3bWQ2bFJUdEloY1h1YVMzSjV0?=
 =?utf-8?B?M0dSSjdhVTdOTmdubS83Z1haaS9mZ1JUYTl4MkJNdEN5VnhJVTJ0RzV6UEJm?=
 =?utf-8?B?ckxhcytsUnphYWZDQm16V0dDdHRSR2JpY0tHai9JVUZTWnZQVk1nS0dBdEtz?=
 =?utf-8?B?UGQ5aGxMOS9XL3Z3Rm1xSnkwM21NTndLeS9RTmljb1FKak9OT0VvL2RkcUFW?=
 =?utf-8?B?enJoM2xQVFJQak5DZ1ZBcHZ5bjNGN2R5OEIvUndPa3IrR0FpZWJ3VDhYd3J2?=
 =?utf-8?B?UFhZZ09iQmRkQVhwaVVOYjhRY0FKRlNsNjZiZFNvRnhGK1doUEFkd21tR01k?=
 =?utf-8?B?bUpZN1lrTU1VYjhKTXc1eWNOZmJ2allWaGd0cWo1ZTJYSHVpVVJORTllSmRp?=
 =?utf-8?B?Q0ZFMnJ4YTA1Z2FNQ3YyelgybC83SmQ4VXVzK042YlRsUGdUTUNBOVNkbVNT?=
 =?utf-8?B?TGJCVVVKS3ZQcGIra3VuYk5ka2lySFV5cnJrUmZKYnRselcydUxhQS83Tlpp?=
 =?utf-8?B?VjlxYmllejhSbXRWUXpGdyt5aWh2bFFGTVdXSmk4TEhkaFM3NlVaaDZZcmcv?=
 =?utf-8?B?NzRzS1M2MlptcEMzNUM1UEdyRUhZRlRyRktyR0FhbStiTHJBVnN1RXpNZGhj?=
 =?utf-8?B?dTJ1VDZodkJ5bzZBckZJZXR4VGJQTmxxc3Z2ZnJhbndiZmw1c2VrbkluUm1x?=
 =?utf-8?B?Wm52T2s1VWlYYnN5L0g4TVByeXdBbzFsendXaGdTUDB5VTUxcWthQi8vUHc0?=
 =?utf-8?B?RGxmcGFUMDY2czVzdnNzalBZMnppckJ0MFEzZU0xNFlZSFRsN2s0Zy8rYmda?=
 =?utf-8?B?VVdtb2VPeXAzN0llYzlaQm9COFA4L0RlRkIyUCtLL0xERHZQV1ZZVjJhUmpu?=
 =?utf-8?B?KzF4eTdSUHBSZjQraWtKT0NxZXFqSXhRUnRRcU00aks0dkNrLzNOd1BWVkZZ?=
 =?utf-8?B?RHEyQkxjUG9ST00vMExrUmRzeFZDQzRPcE9uRm5IeHNrZDdEUGM5M0xvbUtF?=
 =?utf-8?B?aWExanlRS1NTSGZsbGkrdHU3MDhqV0NRTHo3MDZUYVRLdTd3Ri9xU2M2Smov?=
 =?utf-8?B?WkZxcHpMUzEyM21SRm9FTmExVFk0QUNlYVJ3QW5HVFFRMmhrWDZMRVMydkZr?=
 =?utf-8?B?QkJBaWhqZGtXWTZEMnNwU3o5VFViVnYxZmx5b3ZUZkR5YmVHaFQ2bGVhaHZY?=
 =?utf-8?B?NGZjQ1U1Q1pJN0FnckdGcXFYY3ZPc21HYkQ1U204R08rWWZ6aWwydFBoTE5R?=
 =?utf-8?B?ZXNJVFFiNDVsUFBTVktGUFRFeCtOTGJKMk5LdGlqZStPdjVyR3V4NVhkWk84?=
 =?utf-8?B?SlBhQlZaOGNFdm1RM1VjQW5JSzJndWxMbThSRjFHaG1LUXBDODFuZjJzQnQ4?=
 =?utf-8?B?dW1PeWJQSFNvY2IxRDZxaXU3YnQ1ZUdXVWplUFZVWjVsWG5WWmhScXdZVkRS?=
 =?utf-8?B?OGRxdEkzaFJlV0JHdUFsZlZwMDBQeW5NM0JYemlaY2hBdnVBVCtleVpOZWxa?=
 =?utf-8?B?RFJ4TkRTblpsZ1lBbGhueUVnKzlVY0VXQ3k2VGgvaUFQRmRGeWg0K3BMei9X?=
 =?utf-8?B?OUtCR1hlbitydWRFeXlpTUtDUXhDcjFaSmQrdk1ONlRLVUtBZDdueDJVcE96?=
 =?utf-8?B?NXJQYzM2VHp1ZkIyajhvZHNYSFIrdXB5WkRuU1hWL0lwT05KclBkVllRb0FB?=
 =?utf-8?B?UVpkamFLVHZpOHhlME1mbW9JVXViZzQwaU8rcEdOUzBtc3J3OC9XaCtpOEVh?=
 =?utf-8?B?RFF6cEs4TXJPbnM2aHQvdWYxeXZiYlFCK2VXNjkwVlp4YWxDcmdpbkdpQy9H?=
 =?utf-8?B?Wmt4V1BEb0wyN2dBdyt3WWFzVm1JV1B2UmU1NkF5b3VGNkdhZG5rOG83Z092?=
 =?utf-8?B?bzU3ZjlpNUVvRTJlQ3J2SFkwMmZCTWFocW56d2psVXVxSldYVlQvSldNNDRD?=
 =?utf-8?B?QWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <92374ABDC4DF6049B9C45A7F7D73E94A@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR03MB6226.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f372abfb-ddf9-44a1-6c79-08dc9439ec83
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jun 2024 10:39:28.1345
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JOSkh8UmrYQqeeuDqXJ1oE5+cOjtOzaxUiJ+SQ1xo5hw5hjAh/EftkL4ip3qbO/r9P7ouTH16owTbHt2RBd85rJkMnDvRQVM8nd7BFoffqI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR03MB7193
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--16.401200-8.000000
X-TMASE-MatchedRID: h20DFeLkM8/UL3YCMmnG4ia1MaKuob8PCJpCCsn6HCHBnyal/eRn3gzR
	CsGHURLuwpcJm2NYlPAF6GY0Fb6yCsup1wbeiPwat8Hj/rv1Iph+Mk6ACsw4JgqiCYa6w8tvdKZ
	/CwUKSZ3pu8xihWWE0QKnB6R02m6RDIkzW3ewGUlNI82n17+7UxhH6ApagZfOmyiLZetSf8n5kv
	mj69FXvEl4W8WVUOR/joczmuoPCq2UTGVAhB5EbQ==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--16.401200-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	E67F4FAD3D466C364CB579B7E4D6157415CE8440CE2D775087F7DBDDC376FC922000:8

T24gU2F0LCAyMDI0LTA2LTIyIGF0IDE5OjMyICswMjAwLCBBbmRyZXcgTHVubiB3cm90ZToNCj4g
IAkgDQo+IEV4dGVybmFsIGVtYWlsIDogUGxlYXNlIGRvIG5vdCBjbGljayBsaW5rcyBvciBvcGVu
IGF0dGFjaG1lbnRzIHVudGlsDQo+IHlvdSBoYXZlIHZlcmlmaWVkIHRoZSBzZW5kZXIgb3IgdGhl
IGNvbnRlbnQuDQo+ICBPbiBGcmksIEp1biAyMSwgMjAyNCBhdCAwODoyMDozOVBNICswODAwLCBT
a3kgSHVhbmcgd3JvdGU6DQo+ID4gRnJvbTogIlNreUxha2UuSHVhbmciIDxza3lsYWtlLmh1YW5n
QG1lZGlhdGVrLmNvbT4NCj4gPiANCj4gPiBUaGlzIHBhdGNoIGFkZHMgTVQ3NTMwICYgTVQ3NTMx
J3MgUEhZIElEIG1hY3JvcyBpbiBtdGstZ2UuYyBzbyB0aGF0DQo+ID4gaXQgZm9sbG93cyB0aGUg
c2FtZSBydWxlIG9mIG10ay1nZS1zb2MuYy4NCj4gPiBAQCAtMTcwLDkgKzE3MywxMCBAQCBzdGF0
aWMgc3RydWN0IHBoeV9kcml2ZXIgbXRrX2dlcGh5X2RyaXZlcltdID0NCj4gew0KPiA+ICAucmVz
dW1lPSBnZW5waHlfcmVzdW1lLA0KPiA+ICAucmVhZF9wYWdlPSBtdGtfcGh5X3JlYWRfcGFnZSwN
Cj4gPiAgLndyaXRlX3BhZ2U9IG10a19waHlfd3JpdGVfcGFnZSwNCj4gPiArLmxlZF9od19pc19z
dXBwb3J0ZWQgPSBtdDc1M3hfcGh5X2xlZF9od19pc19zdXBwb3J0ZWQsDQo+IA0KPiBXYXMgdGhp
cyBpbnRlbnRpb25hbC4gSXQgZG9lcyBub3QgZml0IHRoZSBjb21taXQgbWVzc2FnZSwgc28gaQ0K
PiB3b3VuZGVyDQo+IGlmIGl0IHNob3VsZCBiZSBzb21ld2hlcmUgZWxzZT8NCj4gDQo+IE90aGVy
d2lzZToNCj4gDQo+IFJldmlld2VkLWJ5OiBBbmRyZXcgTHVubiA8YW5kcmV3QGx1bm4uY2g+DQo+
IA0KPiAgICAgQW5kcmV3DQoNCkkgdGhpbmsgSSBtaXN0YWtlbHkgYWRkZWQgdGhpcyBpbnRvIE1U
NzUzMCdzIGNhbGxiYWNrIGZ1bmN0aW9ucw0KZGVjbGFyYXRpb25zLiBJJ2xsIHJlbW92ZSB0aGlz
IGluIG5leHQgdmVyc2lvbi4NCg0KQlJzLA0KU2t5DQo=

