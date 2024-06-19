Return-Path: <netdev+bounces-104838-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC82E90E9FB
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 13:44:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1E64FB22845
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 11:44:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C970F13DB90;
	Wed, 19 Jun 2024 11:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="dCnaa6uK";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="efrqZK+U"
X-Original-To: netdev@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AD0613D52E;
	Wed, 19 Jun 2024 11:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718797486; cv=fail; b=dUWwYaunqPQCjPlaqe9J8yqp5Hxx6l9K8cBVniG8RE8jH/YXVsUrASzFJCsrEDi5snHSzlAOw/z1yvNkhlO/4SGPnMduGuh7e49Ryt9sEyLbHR2ojNsE3TmIh+VEkZBx/V4BG6A4DD4UJxVS/OoFFO/YB784GyWvD6eDCBZpD5Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718797486; c=relaxed/simple;
	bh=0xYuwq62mGTdCIrn9B0+iJibFW9hH+9RhrLWaVbM+/A=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tJuxD+PiRH5m1FSyGQfU7lNrBGstW22thQ8zfiF1phwVkOvzJSIkE3Hmu/x7SZCgOLqiQ8LVptsAp8EfsaZwCX/MY2/kNsT4cBFvHuUiyRm7Xku6vk9C2dLVR4mG9mhM6xJMUqJsVdNM3vQjGu8aq++p5b9Byg957WbVO4roQdY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=dCnaa6uK; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=efrqZK+U; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 4e2f047e2e3111efa22eafcdcd04c131-20240619
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=0xYuwq62mGTdCIrn9B0+iJibFW9hH+9RhrLWaVbM+/A=;
	b=dCnaa6uKdMDNwoCgFkamsoEyLA5mNckcFSR13JuU7TeLqaqF4zkUhGe+N3F2r4zjWsMEyzoT/R++N8w3RH3VphXW582KuAhRxiXE7YFstQnQu10+Z02X+/aa+vkb/VShrPy+kXttm2TQsjn3k+XiudcXZ0RLZMlvqDbdS4BH/uo=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.39,REQID:037a632e-4cbb-44e8-9aba-4af952636554,IP:0,U
	RL:25,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:25
X-CID-META: VersionHash:393d96e,CLOUDID:6bce2e94-e2c0-40b0-a8fe-7c7e47299109,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_ULN,TF_CID_SPAM_SNR
X-UUID: 4e2f047e2e3111efa22eafcdcd04c131-20240619
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by mailgw02.mediatek.com
	(envelope-from <skylake.huang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1368729697; Wed, 19 Jun 2024 19:44:37 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 19 Jun 2024 19:44:35 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 19 Jun 2024 19:44:35 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IE9VjEGAO/ZEgU4txunRBxSRkCAYE972IG+L081QEUJAXAlbh1cvfnmgprKtiKp2Lgq3XWc9ENkm+Aaw3g1A3wdXlEoYRpghUmPi3YeqP/JWNLZCHC63eNRiLBjyPQucIZA8F38t6YEGYNu10Q3ypUI9pI04O9+et156//CktWJtaYIB1OCxcuYyrlXRVMJlWtQx4XcNJ6PF7VW1TV0+AinU2Ppsc2vCxpVJgX53fwyqD/fPMzf9d8pKOS8LHG0F9PIo4LCaNAC5V8JoADRtcXHlY9RKRx6ZJ5hLtsVo277Ra+1yW7fNJAJe6Vs5KFKR1Z0RQ6qaBSqEQy4xHPMbYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0xYuwq62mGTdCIrn9B0+iJibFW9hH+9RhrLWaVbM+/A=;
 b=bI1A+iiOcK4na4ocfe2PcMJpdF21M/9IIE8xRYoDKuKJMfboE5K2zLxs1SvX/5irQrhVX/wSnCohLqO/iPbrvAn8bqEcon43F8glCor4CTZ2p5YI7oTlW0g8Mm/ymhE4y3eJpuKyCZ42ZefDAsQT8Bx4jTtLNL4O0I7ExSfVlVz6jjBu7Zqn6ef/W/CavXtcCPe9oDIWtjQg6dZMHmwddDCTxfa21S4HBcC4uFJrPpNnv2PIKxw08DVd1FJ5so44tHPqeRrWjt8Jir+D2hXUESf/3XuQeO3qkLhJlzWKB9DUeyT5zMUTHyxYjho1KpTYOiu35imeI1lTXaTMjallSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0xYuwq62mGTdCIrn9B0+iJibFW9hH+9RhrLWaVbM+/A=;
 b=efrqZK+UMRFfnpfTD26DM0W1bEm7mQw7iq5Zkj4va3FteLOLr0IbXAsWkZViTsFw3WEs4JjHv2oCii1kmAdii2qc88nVV00kGhFV6doECXHNdqxAs/LWVY7dk01Sjb0/BlQwBxlBzUvCRi4Eh37EBBFqeyZ8mC7s5miC4Tk6tpQ=
Received: from KL1PR03MB6226.apcprd03.prod.outlook.com (2603:1096:820:8c::14)
 by KL1PR03MB7624.apcprd03.prod.outlook.com (2603:1096:820:e8::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Wed, 19 Jun
 2024 11:44:33 +0000
Received: from KL1PR03MB6226.apcprd03.prod.outlook.com
 ([fe80::f3:c11:8422:7ce3]) by KL1PR03MB6226.apcprd03.prod.outlook.com
 ([fe80::f3:c11:8422:7ce3%5]) with mapi id 15.20.7677.030; Wed, 19 Jun 2024
 11:44:33 +0000
From: =?utf-8?B?U2t5TGFrZSBIdWFuZyAo6buD5ZWf5r6kKQ==?=
	<SkyLake.Huang@mediatek.com>
To: "linux@armlinux.org.uk" <linux@armlinux.org.uk>
CC: "andrew@lunn.ch" <andrew@lunn.ch>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-mediatek@lists.infradead.org"
	<linux-mediatek@lists.infradead.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "edumazet@google.com"
	<edumazet@google.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"dqfext@gmail.com" <dqfext@gmail.com>,
	=?utf-8?B?U3RldmVuIExpdSAo5YqJ5Lq66LGqKQ==?= <steven.liu@mediatek.com>,
	"matthias.bgg@gmail.com" <matthias.bgg@gmail.com>, "davem@davemloft.net"
	<davem@davemloft.net>, "hkallweit1@gmail.com" <hkallweit1@gmail.com>,
	"daniel@makrotopia.org" <daniel@makrotopia.org>,
	"angelogioacchino.delregno@collabora.com"
	<angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH net-next v7 5/5] net: phy: add driver for built-in 2.5G
 ethernet PHY on MT7988
Thread-Topic: [PATCH net-next v7 5/5] net: phy: add driver for built-in 2.5G
 ethernet PHY on MT7988
Thread-Index: AQHavX6rqn6FofMcLkServtyDdJOQbHO1eaAgAArMwA=
Date: Wed, 19 Jun 2024 11:44:32 +0000
Message-ID: <ac5cfcdeefb350af4467fe163b8a93b7873d3889.camel@mediatek.com>
References: <20240613104023.13044-1-SkyLake.Huang@mediatek.com>
	 <20240613104023.13044-6-SkyLake.Huang@mediatek.com>
	 <ZnKgYSi81+JdAdhC@shell.armlinux.org.uk>
In-Reply-To: <ZnKgYSi81+JdAdhC@shell.armlinux.org.uk>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR03MB6226:EE_|KL1PR03MB7624:EE_
x-ms-office365-filtering-correlation-id: e2f8cbf8-602e-454f-46e0-08dc90552fec
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230037|366013|7416011|376011|1800799021|38070700015;
x-microsoft-antispam-message-info: =?utf-8?B?blk2RDY2NTEwVFN5eG5EcG11WThtRGRSOWRKTXprMDA1bm82N2s1dHNyb1Fn?=
 =?utf-8?B?cE5sL2twVmtvS2RWL1dIYVdyWS9VeVdJSE5na0FoQlVxQXFnTkd6ZWtaS29i?=
 =?utf-8?B?UmI4Z1dsNVFkclN6czBuamZNNnd1QVY5WUJORjFQK1NrSTNyaGpueVNGZjNq?=
 =?utf-8?B?Z2Jmam1mQU1NWWJUOGZJK1EvREpLMnlwaGdrRy92T0hrcGlMZVVQKzdheFRQ?=
 =?utf-8?B?dXhQaDlrZEV0alhOeTZ4U3hKTGxKMWJXVXVnRkt3MlkzV2o5VUFtZERISzFG?=
 =?utf-8?B?S1UzbStsQjE2VlozOStTZS96b0pDMVIzZWFpQnNaMWR3WEhJMkk2ODM0SnBL?=
 =?utf-8?B?S0M2V1RxUmtYclFKY1E1dEF0UHlGaE90R1ZXSThWRXlFOVlXOE5ZK1lrTXNw?=
 =?utf-8?B?dW9TNWE5V3hwdXR2Z0dBQlBWUFZhc2RGR3RTOUwyZnk4OXZSQXdBdU92ZUVr?=
 =?utf-8?B?OHgrdG91NXBpWFJBaHEzbmRQRFFQVjBqTTJXNVkyMkQzSisvZkpUR3FJWlJH?=
 =?utf-8?B?MHltQnNIYlQ1cUJJN1NVdHJQM2VmMWlSTkNtaXEzNndRbTZtWGIzeDZ3TDJ0?=
 =?utf-8?B?WDN5VTFmaTFVMEFYU2x5VFVFeTQrMTR3VVBkUHMxd1dWUGpXUlhRSm92V3FP?=
 =?utf-8?B?Y3ZkQkNjd2d0NEFocmthbFpVWjRWZ0ptV2ozbnlBbWc3MkZheTJZWEV3VVlR?=
 =?utf-8?B?MjlLSU9Wam93VWlYYmhybnRpMk5rYXdYTlU3WForWTAvcGY1Z1V4U0R2cDBU?=
 =?utf-8?B?c0xIakxIWUErdWV6YWtoSS9qalBUaUdzVmJ2L2NGWlY0a0xLMXZrNTUrMHpo?=
 =?utf-8?B?TzJISG9UdEFLRjdWMHlEUWpZNXRPRUFKQjZ1bFhvbFh3WjYzVGcybDF4NGgx?=
 =?utf-8?B?UnZoWHo0QW1wSVpzZzdtUXNBUFc4MWZuT0dnWVhuL3ZhZTBnK2VsRm1UUW5k?=
 =?utf-8?B?SVN1V2FydC9jNkF6WmdSV0dSSDRkWUxkb3hRNDh6OEZIamxJVmh5ajVHcUw5?=
 =?utf-8?B?UExlNEViWXhjb2FEc0QwTitZeW0zZTVpRit0NmhjWDFnbURRNDFsaGt3L3Fs?=
 =?utf-8?B?dDV0cU80ekNDbEIycC9iM2VnSGh6Vm5DTlQ4QlpWZVNubVUxNUdJTndET2hp?=
 =?utf-8?B?ZnRVNWNrWTc4dDJMZmRLZmtWM1NWVlN0QUhhN3RjOVhFdDJ6NG05d1FMR3FO?=
 =?utf-8?B?V0N4Ny9OSDJ3OGtvWFdxb1BYMTNWMUM2RnR4WkRoSzhLaGljSk5tZHVMZlFz?=
 =?utf-8?B?SzFsNmFjZEZrSytNM2I2dXE1RW1UTzRFWndpS1ZkSVFtTkVaclZtOGYrT0pG?=
 =?utf-8?B?M2huelFLTk5YVUQzTU1WZTc4b3dZanl2MUlLalU2U0pucEt3Q3FZWDY0bGdR?=
 =?utf-8?B?dDJzTnFIczVERlAvdmxPNXhzSWQ1eUZhaUFvSk5ZRmlrZExGQXRNMVRraWxU?=
 =?utf-8?B?OFpoN1NocFZ6RGNNcVkrRzZRbzhZS0ZmZDBkYUhTYlVQbkdHa2xjemhIZXYz?=
 =?utf-8?B?QjJFMkpuNU5OS0VFUXlsazgzRzlJMUd6NFU5K0RacVh3cHU5ZkpvbDFiWE96?=
 =?utf-8?B?NHFQbXNHWE5GbGVJNjUyU0REa3RjWFV3OUJBOXhWZ3pqMVNLaXJaMFVOT0Vo?=
 =?utf-8?B?R3J3QzNHTW1iK2FhcnZQUktoSVZZaUR6eERMOXB3TGdVSWxFRE1RTklzNzF4?=
 =?utf-8?B?TUI4bEsyRk02Tmo0WHhlSERtSURGMFNYc1ZHK3dzanNrZlE5MXA3NThQUmc5?=
 =?utf-8?Q?3vwxgYeu313mn+0JK/8XRq+4nCp/tGyxi+NUr24?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR03MB6226.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(366013)(7416011)(376011)(1800799021)(38070700015);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YWRrVVEzL2JJUFY2QnB2NlBNZTNVaHJOcm9JRG5QN09oSnBiV0dseS9ZS3R4?=
 =?utf-8?B?Tk5VdkZKNzI0MFNNeHNiN2NvQ2FGN3d2ZnJRQkQ0ZUNKTnhVWS9Yckg1WGk0?=
 =?utf-8?B?M055UUQwbXhoeVNGeXVXazBLWGVpR1VBWXZHcjNGelZTL21hOVk1enF2MXBn?=
 =?utf-8?B?U2FQZmFuMWpWdDZ0Yk8xZWN3RWh1Kys2STMydnhpd1FkVkppZmJ6RlIvR3Zp?=
 =?utf-8?B?R3pFSGwzZEs5YjZJRzNNeGRabCtrK2c3UmcvRkMxbUlxZEJJbk8vbE5SVjlW?=
 =?utf-8?B?RGJBM3NycVZVUG8ycjlFYUtYcGxGT21Ra2tSNFZORU5xMERnc3duNFdOandZ?=
 =?utf-8?B?TS9zdXBuTTRyb0s2cWxVV09Sd252N3pmeGdWSnZvdm1WTmFvNjQ5dkRUc05O?=
 =?utf-8?B?STJTUXlXMlBQQUxZQllLRW9xU21PaFdZUFVRbUhxQWdyVk96aFZjRGhnMitx?=
 =?utf-8?B?K05XQjlEeTZVZ3RzbUxSemVJanBqR09INFZjTGpjSDk3dzU1bUc2MVU5UC9P?=
 =?utf-8?B?MVhnSVlKOCtTRE9hWkptQXlrb0tIZ2FITThvQ1FSaXV4b3hWOGU0YlordXRZ?=
 =?utf-8?B?WjYrSnBWSFdBZHJjQ25obWVMSGt0WlAwN0t3OEUrMlJWbTNVcitRS3pYYnhm?=
 =?utf-8?B?cWVudTFxS0pBRU96UjdlQ3BQelJVK3h4QXdsdGZOYjdXbEd5OFZXdmZDOHFH?=
 =?utf-8?B?QlFiazlKbVpkbFFoQ05ZZEUwMTNCVXRtbHUwZkUzNkJydlhPdk1rQVNHdlAr?=
 =?utf-8?B?S0gvYy85WGJkcWJFRS9SczYwTEpGcTQ2eVc5dzlZZEZBT0JsaG5ybldvYlNu?=
 =?utf-8?B?dHRZV1VnUnlnbUprcS9kc1dNWkVYVmJSSlAzdHVGMkt4RUwvNlowWDFOZTdJ?=
 =?utf-8?B?aWs5Y2hORVpjVUh6RllFWEJDKzhFSHRVYTZyYzNhcHpqMFIxUWgvWkxIMUVQ?=
 =?utf-8?B?UlRWU2NrOFdtd2pIKy9tbFBITnJNYW5zeWQ4cTVMZjNFcEpZSk9FZnBaSTdI?=
 =?utf-8?B?czZGTktPZ1VDOU9ob3BEVGJQTU4zazNTTlQ4bVRGaTNCZjgwY052YVd5K3Zr?=
 =?utf-8?B?UHBwYjY4TzhsVU5TeGVZSUVycGJmYmJLbDg5N0Fnd3ZVWWE4eFVMM0N3bzV4?=
 =?utf-8?B?Z0x4UWJRcVlYdEs0bjhtWkhUY2F2VVVTVHdRL0pSQUJFNHBYeUhwOThFaXZW?=
 =?utf-8?B?MmRsdU9CMnJmWTM1QlpYQW56a1UyWkVmaVdsTjR5d0hIRm0xbVdrL3JlR045?=
 =?utf-8?B?T3huM3JhMCs5dzJrZHV6MlU2aHlrcmptZWRKNmRIUHA3S3NYY1I5aGtUeUhB?=
 =?utf-8?B?bWRhYUc4dmFBcTdHZkpjcEVMS29rdmRYNkFxbDFpU2FKcmthL1JXOTRZc0hj?=
 =?utf-8?B?SFpEUlUvN1dTZjI4TEJFSXBOekREOE5BS2tLRHJpZ1RXcE9GOFJySnNOdjRt?=
 =?utf-8?B?WmV6SVorV3E4cFZYcXBzQ0ZaTlo5UmhxbW0yemZpZ2VpUkhPZEM4YnJRVnFI?=
 =?utf-8?B?UFRKajRqT3U1a1dMRktpRUtOWkZraXVtNVZNa1V4M0hVNm50bGJNRWJIam5Y?=
 =?utf-8?B?bEVBVUIzQ2hWVUN1ZS9hUSs0bUZIdkVmcUM5ZUY4VlJ6WVpuU2Y2c3pvT3Zy?=
 =?utf-8?B?R2JMRVJIWjZxV2JlOXRtUHlqTTJLejFnZXB5NUxycmR1V1cvQlJNcFJiT3Vj?=
 =?utf-8?B?Sjl6eHJGVjVMcm1BbEN4QVZDR2lQZWJPZHRkUUFRUVVGT0NmMHRNaUZFOFhy?=
 =?utf-8?B?aE9jK2VKaFptczhUZWJrRHpYNFZlbUFmQXpaYXY3ZTJFUnVaejhaYklVQ3Zi?=
 =?utf-8?B?K1pSY3BPMDdRT2FlMGh0UmI5TE5yVlhsSCtxNXRpOHpjU3dyT0RKb3NHTFdx?=
 =?utf-8?B?QUZXL2RORDNtK0JON0pnYWVoUXB3WGY3Y0doNm12Q1ZiclE3TkppRnZCRStX?=
 =?utf-8?B?QXVnUlpPa0VyRzNCakIxQnUzbnB4ZDg3UVkrc2k1VzNjd00xQVVJcmlEeXhR?=
 =?utf-8?B?NnFGUzR2VCs5bjRhV3pBeE12OHQ1MlNHR3FvTW9Bay9velRDWVJFMFFsM1Fz?=
 =?utf-8?B?RUl3WWprODVac3B6LzV1SjRmZzNzenVVcnJpSzdLZWhyMXV2dTZOYktveWZX?=
 =?utf-8?B?STBnTTRMU1hpRkYyeUpaYzEyV3ZDQ2RFMmY4My9JK2RERFM4ZXRJYnlOOVFs?=
 =?utf-8?B?ekE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5D12FE31D47ACC48B6F99E26205F4440@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR03MB6226.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2f8cbf8-602e-454f-46e0-08dc90552fec
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jun 2024 11:44:33.0039
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mEHr6ddIycnHTZvIiFk/xsDYdmXd+YBic7v1CDGeKWw6CBi7CLJjpphhT7Ek23T06FpVibHWMMk/jDN8KLoBeMdS8fiaHkRt06u/E7DYydM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB7624

T24gV2VkLCAyMDI0LTA2LTE5IGF0IDEwOjA5ICswMTAwLCBSdXNzZWxsIEtpbmcgKE9yYWNsZSkg
d3JvdGU6DQo+ICAJIA0KPiBFeHRlcm5hbCBlbWFpbCA6IFBsZWFzZSBkbyBub3QgY2xpY2sgbGlu
a3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bnRpbA0KPiB5b3UgaGF2ZSB2ZXJpZmllZCB0aGUgc2Vu
ZGVyIG9yIHRoZSBjb250ZW50Lg0KPiAgT24gVGh1LCBKdW4gMTMsIDIwMjQgYXQgMDY6NDA6MjNQ
TSArMDgwMCwgU2t5IEh1YW5nIHdyb3RlOg0KPiA+ICtzdGF0aWMgY29uc3QgdW5zaWduZWQgbG9u
ZyBzdXBwb3J0ZWRfdHJpZ2dlcnMgPQ0KPiA+ICsoQklUKFRSSUdHRVJfTkVUREVWX0ZVTExfRFVQ
TEVYKSB8DQo+ID4gKyBCSVQoVFJJR0dFUl9ORVRERVZfTElOSykgICAgICAgIHwNCj4gPiArIEJJ
VChUUklHR0VSX05FVERFVl9MSU5LXzEwKSAgICAgfA0KPiA+ICsgQklUKFRSSUdHRVJfTkVUREVW
X0xJTktfMTAwKSAgICB8DQo+ID4gKyBCSVQoVFJJR0dFUl9ORVRERVZfTElOS18xMDAwKSAgIHwN
Cj4gPiArIEJJVChUUklHR0VSX05FVERFVl9MSU5LXzI1MDApICAgfA0KPiA+ICsgQklUKFRSSUdH
RVJfTkVUREVWX1JYKSAgICAgICAgICB8DQo+ID4gKyBCSVQoVFJJR0dFUl9ORVRERVZfVFgpKTsN
Cj4gDQo+IEFic29sdXRlbHkgbm8gbmVlZCBmb3IgdGhlIG91dGVyIHBhcmVucyBhcm91bmQgdGhp
cy4NCj4gDQo+IHR5cGUgZm9vIGFzc2lnbm1lbnQtb3BlcmF0b3IgZXhwcjsNCj4gDQo+IFRoZXJl
IGlzIG5vIHJlYXNvbiB0byBldmVyIHB1dCBwYXJlbnMgYXJvdW5kIGV4cHIgaW4gdGhpcyBraW5k
IG9mDQo+IHRoaW5nLg0KPiBhc3NpZ25tZW50LW9wZXJhdG9yIGFyZSB0aGluZ3MgbGlrZSA9LCB8
PSwgJj0sIDw8PSwgPj49LCBhbmQgc28NCj4gZm9ydGguDQo+IA0KPiBFeGNlc3NpdmUgcGFyZW5z
IGRldHJhY3RzIGZyb20gcmVhZGFiaWxpdHksIGFuZCBsZWFkcyB0byBtaXN0YWtlcy4gSWYNCj4g
b3BlcmF0b3IgcHJlY2VkZW5jZSBpcyBhIHdvcnJ5LCB0aGVuIGtub3dpbmcgdGhlIGNvbW1vbiBD
IHByZWNlZGVuY2UNCj4gcnVsZXMgcmF0aGVyIHRoYW4gbGl0dGVyaW5nIGNvZGUgd2l0aCBleHRy
YSBwYXJlbnMgd291bGQgYmUgZ29vZCBzbw0KPiB0aGF0IGNvZGUgY2FuIHJlbWFpbiByZWFkYWJs
ZS4NCj4gDQpJJ2xsIGZpeCB0aGlzIGluIG5leHQgdmVyc2lvbi4NCg0KPiA+ICtzdGF0aWMgc3Ry
dWN0IHBoeV9kcml2ZXIgbXRrX2dlcGh5X2RyaXZlcltdID0gew0KPiA+ICt7DQo+ID4gK1BIWV9J
RF9NQVRDSF9NT0RFTChNVEtfMlA1R1BIWV9JRF9NVDc5ODgpLA0KPiA+ICsubmFtZT0gIk1lZGlh
VGVrIE1UNzk4OCAyLjVHYkUgUEhZIiwNCj4gPiArLnByb2JlPSBtdDc5OHhfMnA1Z2VfcGh5X3By
b2JlLA0KPiA+ICsuY29uZmlnX2luaXQ9IG10Nzk4eF8ycDVnZV9waHlfY29uZmlnX2luaXQsDQo+
ID4gKy5jb25maWdfYW5lZyAgICA9IG10Nzk4eF8ycDVnZV9waHlfY29uZmlnX2FuZWcsDQo+ID4g
Ky5nZXRfZmVhdHVyZXM9IG10Nzk4eF8ycDVnZV9waHlfZ2V0X2ZlYXR1cmVzLA0KPiA+ICsucmVh
ZF9zdGF0dXM9IG10Nzk4eF8ycDVnZV9waHlfcmVhZF9zdGF0dXMsDQo+ID4gKy5nZXRfcmF0ZV9t
YXRjaGluZz0gbXQ3OTh4XzJwNWdlX3BoeV9nZXRfcmF0ZV9tYXRjaGluZywNCj4gPiArLnN1c3Bl
bmQ9IGdlbnBoeV9zdXNwZW5kLA0KPiA+ICsucmVzdW1lPSBnZW5waHlfcmVzdW1lLA0KPiA+ICsu
cmVhZF9wYWdlPSBtdGtfcGh5X3JlYWRfcGFnZSwNCj4gPiArLndyaXRlX3BhZ2U9IG10a19waHlf
d3JpdGVfcGFnZSwNCj4gPiArLmxlZF9ibGlua19zZXQ9IG10Nzk4eF8ycDVnZV9waHlfbGVkX2Js
aW5rX3NldCwNCj4gPiArLmxlZF9icmlnaHRuZXNzX3NldCA9IG10Nzk4eF8ycDVnZV9waHlfbGVk
X2JyaWdodG5lc3Nfc2V0LA0KPiA+ICsubGVkX2h3X2lzX3N1cHBvcnRlZCA9IG10Nzk4eF8ycDVn
ZV9waHlfbGVkX2h3X2lzX3N1cHBvcnRlZCwNCj4gPiArLmxlZF9od19jb250cm9sX2dldCA9IG10
Nzk4eF8ycDVnZV9waHlfbGVkX2h3X2NvbnRyb2xfZ2V0LA0KPiA+ICsubGVkX2h3X2NvbnRyb2xf
c2V0ID0gbXQ3OTh4XzJwNWdlX3BoeV9sZWRfaHdfY29udHJvbF9zZXQsDQo+IA0KPiBJIGRvbid0
IHNlZSB0aGUgcG9pbnQgb2YgdHJ5aW5nIHRvIGFsaWduIHNvbWUgb2YgdGhlc2UgbWV0aG9kDQo+
IGRlY2xhcmF0b3JzIGJ1dCBub3Qgb3RoZXJzLiBDb25zaXN0ZW5jeSBpcyBpbXBvcnRhbnQuDQo+
IA0KU29ycnkgSSBkb24ndCBnZXQgeW91ciBwb2ludCBvbiB0aGlzLiBXaGF0IGRvIHlvdSBtZWFu
IGJ5ICJ0cnlpbmcgdG8NCmFsaWduIHNvbWUgb2YgdGhlc2UgbWV0aG9kIGRlY2xhcmF0b3JzIGJ1
dCBub3Qgb3RoZXJzIj8gRG8geW91IG1lYW4NCiJtdDc5OHhfMnA1Z2VfcGh5IiBwcmVmaXg/DQoN
CkJScywNClNreQ0KDQo+IEkga25vdyBzZXZlcmFsIFBIWSBkcml2ZXJzIGRvIHRoaXMsIHRoaXMg
d2lsbCBiZSBiZWNhdXNlIG5ldyBtZXRob2RzDQo+IHdpdGggbG9uZ2VyIG5hbWVzIGhhdmUgYmVl
biBhZGRlZCBvdmVyIHRpbWUsIGFuZCB0byByZWZvcm1hdCB0aGUNCj4gdGFibGVzIG9mIGV2ZXJ5
IGRyaXZlciB3b3VsZCBiZSBub2lzZS4gSG93ZXZlciwgbmV3IGltcGxlbWVudGF0aW9ucw0KPiBz
aG91bGQgYXQgbGVhc3QgbWFrZSBhbiBlZmZvcnQgdG8gaGF2ZSBjb25zaXN0ZW5jeS4NCj4gDQo+
IFRoYW5rcy4NCj4gDQo+IC0tIA0KPiBSTUsncyBQYXRjaCBzeXN0ZW06IGh0dHBzOi8vd3d3LmFy
bWxpbnV4Lm9yZy51ay9kZXZlbG9wZXIvcGF0Y2hlcy8NCj4gRlRUUCBpcyBoZXJlISA4ME1icHMg
ZG93biAxME1icHMgdXAuIERlY2VudCBjb25uZWN0aXZpdHkgYXQgbGFzdCENCg==

