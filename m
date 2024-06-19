Return-Path: <netdev+bounces-104836-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A264490E983
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 13:33:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 322DC1F2309F
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 11:33:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1D3513C699;
	Wed, 19 Jun 2024 11:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="IIZfQy+T";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="gByZ+yWg"
X-Original-To: netdev@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41593137747;
	Wed, 19 Jun 2024 11:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718796826; cv=fail; b=AkawlL4cnaNasLBgRwTa5q13Qxzcdaj5pgBa8fT0D807rgI8yb1DZfbH8xtveLxTgpi6j4P2g2dLoTjQmqednl/6D47D7RQmUWUKE7pt5WU33pL2N6yvfzMSjkY2YL8YaSRq2nYkCpAsqpprJ1TOrhcOIsdFmltl3Fh+g5qIVAQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718796826; c=relaxed/simple;
	bh=G3Wd37JQZQtvxKbljAvMavFu+Z5Jb9gO4tywAVm5E2I=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FZySJStioVZiwHWcndpd2T9BLOrs3LnHPOgnA5m9vhnj25aIXG/JgpUF/4ulBtRL+ROtq7BIPYl+MgofgN0SLtoN39hgS0vAagRy6rEu/QQtk0SmlI8N9gsL1ykdsg2T8fekEx0zXlaodSW42v1flfTQObQBL2SM/hR/xvIT0mI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=IIZfQy+T; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=gByZ+yWg; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: c781f1442e2f11efa54bbfbb386b949c-20240619
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=G3Wd37JQZQtvxKbljAvMavFu+Z5Jb9gO4tywAVm5E2I=;
	b=IIZfQy+TcUzIh5GbtqkcOcM0xjXF0GG32bT+nNPPFDlUrAkFKIu1GdRF2E0Z7F2GAqOpCAjc4oBNBz3iLkKpkzTjOFqtmlujiSfEK3ow+7WZmEx5ubWqB6knaDwipFyDQzHAePjAxJZYsFtFNrWlJHw5XPmBE9LxCG6LJOt9W8g=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.39,REQID:920ef419-1acd-445d-86f2-c41202e9da4d,IP:0,U
	RL:25,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:25
X-CID-META: VersionHash:393d96e,CLOUDID:71e34785-4f93-4875-95e7-8c66ea833d57,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: c781f1442e2f11efa54bbfbb386b949c-20240619
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw01.mediatek.com
	(envelope-from <skylake.huang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 2129920249; Wed, 19 Jun 2024 19:33:41 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 MTKMBS09N2.mediatek.inc (172.21.101.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 19 Jun 2024 04:33:40 -0700
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 19 Jun 2024 19:33:40 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bz8zVksEuWdp8LqgVGvPKq8fmxFdvZ/OnPEShxcq4wFIe9f6xyWnXTwJtxCQH9ahE2lIAQjWNqjqDIocNlJJgav3R2OnbFh4N7yA4O4zGOSITuJw5ku4acVKuVJZVKHesrtI/yRnLQZwbuxlwaAh2YCoXS7iLSIfccXpSDiVhGKdBHbTxt8pRgk4F3X9tL01yIKYHufmezK/zJvSM2S7FWFdSbMVitoIHsym6SYm6S+cBthZH58Juga7FOX+IX1ksCs2HQqnmrwPnwTDjya2FAq3qsEWATi8ZYrF69Hx9gwBp2mzyvAvsW2M2HhUxYtWL0Zc7YKxR/4YmXMqrJmZPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G3Wd37JQZQtvxKbljAvMavFu+Z5Jb9gO4tywAVm5E2I=;
 b=B9/aOOl3HAUIZkl64dRblemIF8mr2+2V4jwxQCgYZGTgNGPgpHRQUpxgPGBodMMA4ktFET9mkWSvUov2ExSdi63PUkaOfpLxNEl7bP9VDsxgoE1hnxlMZV94gv30CfDDCvQWBO4QgG/MDxaBT4kvXJyCUYNA3zMYyFWB8BzlnttZOK/UJZJS53q7jyoH/tAO+vhp43fjpUkzq1wvHcZKlqU0DXIi0a3b/f9KmmdCufWQt9lwZqEcQn1dQY6WyD7wKtIjKjikBrX3NXrAZPl3UGfans9vjNSQ4CeuGGXQh6nhdm1pxZdKsOC3nyGLPeeX+es/rppXLwKNV66qc+8cvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G3Wd37JQZQtvxKbljAvMavFu+Z5Jb9gO4tywAVm5E2I=;
 b=gByZ+yWg8c2BiI5nWjdQ5LgQzG/J+NdJwC29zTySNSdoVmT4bYXIGknqTc70VPRL0YUUuWft9hPH8Msv1MxFyt5Je3sqEOLWf72msDY322c+8jqu3+d55PuEiiAfyxRx8ki4A/JVCZNBFZcedCCNvGcrfDOl2DX+D35kNUC3yfI=
Received: from KL1PR03MB6226.apcprd03.prod.outlook.com (2603:1096:820:8c::14)
 by JH0PR03MB8309.apcprd03.prod.outlook.com (2603:1096:990:42::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.31; Wed, 19 Jun
 2024 11:33:38 +0000
Received: from KL1PR03MB6226.apcprd03.prod.outlook.com
 ([fe80::f3:c11:8422:7ce3]) by KL1PR03MB6226.apcprd03.prod.outlook.com
 ([fe80::f3:c11:8422:7ce3%5]) with mapi id 15.20.7677.030; Wed, 19 Jun 2024
 11:33:38 +0000
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
Subject: Re: [PATCH net-next v7 3/5] net: phy: mediatek: Add token ring access
 helper functions in mtk-phy-lib
Thread-Topic: [PATCH net-next v7 3/5] net: phy: mediatek: Add token ring
 access helper functions in mtk-phy-lib
Thread-Index: AQHavX6ZEGWZU0BPUEee+mesWiidMbHO04uAgAAqgwA=
Date: Wed, 19 Jun 2024 11:33:38 +0000
Message-ID: <4ddab7b1cca8496b91c6d908dce96e66a4514d98.camel@mediatek.com>
References: <20240613104023.13044-1-SkyLake.Huang@mediatek.com>
	 <20240613104023.13044-4-SkyLake.Huang@mediatek.com>
	 <ZnKeZ91TOYvSyjuN@shell.armlinux.org.uk>
In-Reply-To: <ZnKeZ91TOYvSyjuN@shell.armlinux.org.uk>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR03MB6226:EE_|JH0PR03MB8309:EE_
x-ms-office365-filtering-correlation-id: 52ef9fcf-4862-4ff9-528c-08dc9053a9c0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230037|1800799021|376011|7416011|366013|38070700015;
x-microsoft-antispam-message-info: =?utf-8?B?U1RveUhCRzVHdkJyWlpJOU52OXdoVjlzUkRLSkJaVU9yZkFyd2s2akN3cE96?=
 =?utf-8?B?dGxUQytGSUIvMnJGUUdud0FLSkdVNW0vYjdjbGlaOTFLOEZZWE5wazFpTVVU?=
 =?utf-8?B?S3V4NzlwSitKeUJ6TFE2WEhaaWo3bk0yR2RRYlJsVC85VENoR2M5QzFVR1hH?=
 =?utf-8?B?bVowUTNLL1JZQ3V6S3RPV09uY1JWS3VFbDFhYjVaMnpCZUZzaFRFbWk0OUJo?=
 =?utf-8?B?WHZISWpuVENBQks4QUhTT3ZFeUlGb2dUSy91Q2pyMjVORjhjSHVFRk40S2k1?=
 =?utf-8?B?T3NqaEJvV0FqWFptTXNGQlJSSDNRNUZZaXA2dUNwSldjK0VTdFhVYjhVV2VL?=
 =?utf-8?B?SDBMRWNtTDdYaksyb1luUEwwcnB4d0VOS0N3VEw4Z25pWldZK2cvemwwRmJ3?=
 =?utf-8?B?ZndMNXI2MFlxNmpndjQxbDk2QlRmSWM1ZVI0L3BFbEZ1MnJIYVI3QmFTeE9a?=
 =?utf-8?B?eXdobURxMG5OallhMTFQNFFuNWtzQUVIc0ovNDI0NkhOa2tOR21VVnFrMU90?=
 =?utf-8?B?TWVjUk0zUEU1b2dKQzVWL0tPNCtTa1VhTzRwYUdPN3RIM3dhUlp1ZTladE4r?=
 =?utf-8?B?Q2ZlUDR5VC8wOVc2Zk9vRTZ6S0s5ZzFwZmhFaFZCL0MyTnpLMG1RUXVtNFh6?=
 =?utf-8?B?c2VMbGtNZnhHeWRDeGhMbFVrTnNpUWNrNDlwTkNmZzRKOHluR1R4TTEvZ2dU?=
 =?utf-8?B?cURQcVV0Tzk0MFF6eWV0eFpMY21sS1F4OXJENm5Gb0hBK0ZHL2ZYMkg5TGZh?=
 =?utf-8?B?Q3JqWGsreTBxV2h6VjRSUzlTbE5BTlRaU00zNktuTVc4UGFLUlhZMTVHUEFS?=
 =?utf-8?B?cmF6T2VFZENyeDh4cXRXWFh3Q0grL1FkQmttbm9ZaW1xMFVlNVRsZTVUUWx3?=
 =?utf-8?B?RzlrVllrbXJ2WWtkZTMzTXE2MEl1eGN2YlZvTEMwamR4TzdLOUFJaklXaGM3?=
 =?utf-8?B?cWJPUEpyVmFhSDR3ckRRbmxCWFpyN2g4aWRUT3Z1cWl1enk1eUxPUnZtQ2Fh?=
 =?utf-8?B?WlZOc2hYZWI1WU9Jang4VFVCTkdvbWd6RlpubHJkREpLRHQvdXYrRU0zVlBO?=
 =?utf-8?B?dWlCUmp0MVlSRmowcFlNVTdwQUZudlEzUVZwREhBeGM0Q3BPNHk0OTZhcnI0?=
 =?utf-8?B?TlZIcEZzcWxPeUpHOEhvQkdNd2ZzcmhRdUFvZk93WHJhajVueURwNGh1eDNS?=
 =?utf-8?B?K21jQklwOThYM0hIZHVQdDhvS2U3VVJENXM4Q2JtbHRYK2YwS2xscmNoYkRu?=
 =?utf-8?B?MlFHeUFNUEdOdUJtM3pCcFZmbmI1Q0NkZDFDSnlkSGRVYzQrQWlRWmhuck5C?=
 =?utf-8?B?OGkxSzQ2V3Z3OU1scllMSTlHZ0FVb3JLcmRqek5TMlNITWdkNk92U3dBcFdv?=
 =?utf-8?B?N3ladlFEVExRRGg1SFJ1Z3hSZVd5YWlpWDZCVDFoQ1hldWJXSzBDYkJ4cE1R?=
 =?utf-8?B?VlpaWXN5aTJOS0dxVXNLNHlXM2RKSDBVODFFanpVbCs3YkdqNlBXK2ZvZngy?=
 =?utf-8?B?clE0cFBVZGJwcU1YRG5Ma21ySXhPYk5TZ3ZvQ1YrVC9XdE5QUkRyMkdDZU5y?=
 =?utf-8?B?TVlLeGdVakhoVTV3YTFTMndJL004RmJ2TEM0L0NvK3QvOEtLT0o0eXVLaGxR?=
 =?utf-8?B?MS9kdDd0bDcwNzlCb3ZCVzFkMCtQcHB6NTFmS2ZzODIzc2o5aG9qenFZT1lU?=
 =?utf-8?B?eFNpUEZEdDhiV0dXVGdNT1FrTUZFNW9rdGhtOXRjR3dCYjBRZk1kR2xWUUJK?=
 =?utf-8?Q?ZdvuPQt8inZGskuSOhtnhOLdlnD841fmE0dyF/T?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR03MB6226.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(1800799021)(376011)(7416011)(366013)(38070700015);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bFRyNEwrcUZLekhGZW1pbDY2RG0rQXlsL05zL3kzOVNvOENiU2NSOTdFanB0?=
 =?utf-8?B?S01tRjhjZkk1bkU4SzBJUGhEL0pqSzRwRFg5cXBtdDVPb1VDdHZCTW9odWZo?=
 =?utf-8?B?VjJRVzF2Qzh4aEkvRnIzeUlmVmloZE1rWmxla3ZmNEZ4eTc3UWM5RkNXTTY3?=
 =?utf-8?B?Tms5dS9WSzN5aUhVWFpIUC82NU9BdnlpdXlxYmxIcU9aYUQvaTVUQlhoSkE5?=
 =?utf-8?B?dlZURWIvdnJraWU5VkZ1MUF3OGl0RFFVcVhsc3NlWm1CMCtLSzFXQlIwanRP?=
 =?utf-8?B?K1pGUlhpU295cnVpLzAxRlhtb3JCeHBab2dySm1BUmdRN0swM3BQeW5xY3Vh?=
 =?utf-8?B?ZUNWQzJtYTN2VXdGbjhudWJnSS9SNWxmMDJqSCt4ZUMvcmhrWmUxUGpuWEpV?=
 =?utf-8?B?aERod0t4VmtxY0VJenFsZ2p5cWt4K0dSMkVzUDkvZHBnanI2MHQvcGlIeW9s?=
 =?utf-8?B?V3NnM1N3REZybU5GblEySnJDVHFITVQ3a3NiWjh5WUM2bWl2ZHY1WDFZYnBJ?=
 =?utf-8?B?WUJyQUF5N1Q5T1pjWlc1S1hPR3Vhc24zNzhtV1JVTWo0dWNZTU1RalV1aFdv?=
 =?utf-8?B?U2IvYURvSDRCQld4MWEwbzBmdGY5SFRqSDBnbm9oZUpSSnBaUUh4ZGg2M2FP?=
 =?utf-8?B?cXpuSFBIZ2NpMnFsVldUbU5wRVV4RCs1UTZtS3MvM09BMS9ZbzlMRGhFNlJI?=
 =?utf-8?B?dGREbyszL3Y0Wi83M2lzUUFRR1dadk1adkoyZHJJRzNFR2JFQUJLMFNxcytm?=
 =?utf-8?B?dmpZeXJoeHZ3UVNzZUZQOU9EeGpPclQ3TDArdC8zYWlQMmN3ZnlJbHdkcHVs?=
 =?utf-8?B?K21JNjFUcW9UZ0RDaUliQ1pPTW5NeXNTKzhwM3A1T2RyQlBtSXNUbDFtMFE5?=
 =?utf-8?B?cnlEMkIzY3I5eVV1ZXo1eTArallNOVdFUDBSZ3JwcFZiT2xVdFVWOUdJWWhk?=
 =?utf-8?B?MkVoVFA4c3l3bHd2end3d1liKzlXTHNYNmd3S1FoTnhCb0tQN25WaVhBMjRo?=
 =?utf-8?B?dU9Xb1NQait4cVQrdFc0enZ5Y1VaMW00SitHNUovYXQwdW5pMU1kUVZEbFU4?=
 =?utf-8?B?NDZ3elJkcEp0MWNLcTkrOHpnMlpUMUF4cDE0NkhGYU5EeTVOeUR0YVpoSWRS?=
 =?utf-8?B?YmU5SjV0NmppUmNZTGVwZ3dlSXVKM3FpaEpTc0tZUVUwcnozK2dlYW0xd3lj?=
 =?utf-8?B?eWRObkY5SGdIU2w4KzFkZzJQUFJpVTZNSmRTZ1lhdnBuVlJGaG1NYitjOGZB?=
 =?utf-8?B?VUl0N1RCbDgvUUNXR1BaQURuOFY4QXQwUmVIUzdpc1FNNnhSSVBlbUZqVmEr?=
 =?utf-8?B?ZXVCalRWRW5GZ0NLRW1iTEdqU2lzVTBhNEpKMnVqMnBLakJZQUdna05ONFdS?=
 =?utf-8?B?MmFNenlxdzdlekdBRUJJU29naVdwSW0xUERPWHJraUFSWGJBWnRCeTlqMGpG?=
 =?utf-8?B?OU5hSGl6aElFU21ZblNIZXB0cm9hYUFURGcwRE4wM0lsaTB4bHZoQU9xbkl1?=
 =?utf-8?B?UmFYRnZJSnQvbGlabC96NGdGekN3OUNPYzJRLzBqWDRPdWRhVWN3VWtDUWpr?=
 =?utf-8?B?dkh5Z0NMbFBYSGE5eVV2N2xRa21Tbk9zZFJNTVhJUlpGY2RNVUJCc1RXTEVp?=
 =?utf-8?B?M3g0MXVRNWFHN2tKd21hc1lVOWxMZDlEd2Exc3RYcEtKdzJ5blVBTmFONmdG?=
 =?utf-8?B?QXVCWWc1NUQxVlYzVUErWmZkSDNHU3IvenZVaFdEaWJnT1o4SG9DdTdVSWZK?=
 =?utf-8?B?Tk8rYzJWSVcyMzB5aGtSTk02Z050WldzMXNmdjVGS0xSamtWbkFIOUU3USsr?=
 =?utf-8?B?QlNQTndEKzlsVEJRdzhhemd6M2p2N0JOUDhBVksrVEwvTEtML1F2dkZZZ0dI?=
 =?utf-8?B?T1hsMlY3SktRRHVBSHR3RU1tREZqTU9keVgyMkdWS0ozaks2eGswODl6b3ZL?=
 =?utf-8?B?bHNNVnlxV0RpaHdvNThobDBWSWR3V2dRRXk1WlRsY1RYRTRidVVHMUFpM3l2?=
 =?utf-8?B?SUxRTFNUTVVXbG8xdjlEQWFGT3JOUTZURnhxeDFsZUZ6bFIwT1dRenJYdTJG?=
 =?utf-8?B?bXBvb3E5aTZORHhHY1ZHN25RdE9ZMmZhSnR5WFNxZ3Y2a1l2QmpPUkJreDBR?=
 =?utf-8?B?ak5taWtrWm5VUzJVbUJMaExiQ1IyNnBDU3NGVEcwb05NdGRQZlV6UEhyMzlX?=
 =?utf-8?B?d3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B144E3BFE2C57E46B1932D83E5AB7AE9@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR03MB6226.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52ef9fcf-4862-4ff9-528c-08dc9053a9c0
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jun 2024 11:33:38.3970
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: E+pmCvEXqqnOAkHBtsguYKv0P9Os4pwTF2XqY2fxsfUjtNVseby2H8IHuq2baZ2oNIPGZDHFHIgmSWx0Bm/ZlMRezH3bpGjUBGRWDsINDkg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR03MB8309

T24gV2VkLCAyMDI0LTA2LTE5IGF0IDEwOjAxICswMTAwLCBSdXNzZWxsIEtpbmcgKE9yYWNsZSkg
d3JvdGU6DQo+ICAJIA0KPiBFeHRlcm5hbCBlbWFpbCA6IFBsZWFzZSBkbyBub3QgY2xpY2sgbGlu
a3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bnRpbA0KPiB5b3UgaGF2ZSB2ZXJpZmllZCB0aGUgc2Vu
ZGVyIG9yIHRoZSBjb250ZW50Lg0KPiAgT24gVGh1LCBKdW4gMTMsIDIwMjQgYXQgMDY6NDA6MjFQ
TSArMDgwMCwgU2t5IEh1YW5nIHdyb3RlOg0KPiA+ICsvKiBEaWZmZXJlbmNlIGJldHdlZW4gZnVu
Y3Rpb25zIHdpdGggdHIqIGFuZCBfX3RyKiBwcmVmaXhlcyBpcw0KPiA+ICsgKiAgIHRyKiBmdW5j
dGlvbnM6IHdyYXBwZWQgYnkgcGFnZSBzd2l0Y2hpbmcgb3BlcmF0aW9ucw0KPiA+ICsgKiBfX3Ry
KiBmdW5jdGlvbnM6IG5vIHBhZ2Ugc3dpdGNoaW5nIG9wZXJhdGlvbnMNCj4gDQo+IFBsZWFzZSBk
b24ndCBhbGlnbiAidHIiIGxpa2UgdGhpcyAgdGhlIGxhY2sgb2YgX18gZG9lc24ndCBzdGFuZCBv
dXQNCj4gd2l0aA0KPiB0aGlzIGZvcm1hdHRpbmcuDQo+IA0KPiA+ICt2b2lkIF9fdHJfbW9kaWZ5
KHN0cnVjdCBwaHlfZGV2aWNlICpwaHlkZXYsIHU4IGNoX2FkZHIsIHU4DQo+IG5vZGVfYWRkciwN
Cj4gPiArIHU4IGRhdGFfYWRkciwgdTMyIG1hc2ssIHUzMiBzZXQpDQo+ID4gK3sNCj4gPiArdTMy
IHRyX2RhdGE7DQo+ID4gK3UxNiB0cl9oaWdoOw0KPiA+ICt1MTYgdHJfbG93Ow0KPiA+ICsNCj4g
PiArX190cl9yZWFkKHBoeWRldiwgY2hfYWRkciwgbm9kZV9hZGRyLCBkYXRhX2FkZHIsICZ0cl9o
aWdoLA0KPiAmdHJfbG93KTsNCj4gPiArdHJfZGF0YSA9ICh0cl9oaWdoIDw8IDE2KSB8IHRyX2xv
dzsNCj4gPiArdHJfZGF0YSA9ICh0cl9kYXRhICYgfm1hc2spIHwgc2V0Ow0KPiA+ICtfX3RyX3dy
aXRlKHBoeWRldiwgY2hfYWRkciwgbm9kZV9hZGRyLCBkYXRhX2FkZHIsIHRyX2RhdGEpOw0KPiA+
ICt9DQo+ID4gK0VYUE9SVF9TWU1CT0xfR1BMKF9fdHJfbW9kaWZ5KTsNCj4gDQo+IFRoZXNlIF9f
dHJfKiBzeW1ib2xzIHdpbGwgYmUgdmlzaWJsZSB0byB0aGUgZW50aXJlIGtlcm5lbCwgc28gdGhl
eQ0KPiBzaG91bGQgYmUgbW9yZSBzcGVjaWZpYyB0byBlbnN1cmUgdGhhdCB0aGV5IHdvbid0IGNs
YXNoIGluIHRoZQ0KPiBmdXR1cmUuDQo+IE1heWJlIF9fbXRrX3RyXyogPw0KPiANCj4gLS0gDQo+
IFJNSydzIFBhdGNoIHN5c3RlbTogaHR0cHM6Ly93d3cuYXJtbGludXgub3JnLnVrL2RldmVsb3Bl
ci9wYXRjaGVzLw0KPiBGVFRQIGlzIGhlcmUhIDgwTWJwcyBkb3duIDEwTWJwcyB1cC4gRGVjZW50
IGNvbm5lY3Rpdml0eSBhdCBsYXN0IQ0KDQpBZ3JlZS4gSSdsbCBmaXggdGhlIGFib3ZlIGFuZCBy
ZXBsYWNlIHRyKi9fX3RyKiB3aXRoIG10a190ciovX19tdGtfdHIqLg0KDQpCUnMsDQpTa3kNCg==

