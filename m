Return-Path: <netdev+bounces-169722-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 39E55A455FD
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 07:49:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C226318824DA
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 06:48:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E0D4267B77;
	Wed, 26 Feb 2025 06:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="G1YtQzjk";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="H5tRBpoc"
X-Original-To: netdev@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD9981C84BD;
	Wed, 26 Feb 2025 06:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740552525; cv=fail; b=p2CmdterLQJ6S55od8ugQQ+nxZRlkBKDdapusH7QD6EwN/MAgsGsUlWMiTGOxNONnrstTDf4pkeYs97e6oN98l5ONy2D3XYYlNxv+xiS5YZf59k+W9jz9fKZtzpkK9xFtXgCzA1IM7P4zO/Ps5rNeHT+5rIUZcW4UMkMsaOL4qI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740552525; c=relaxed/simple;
	bh=AZM4JsfOyzQtKsCqqnDM0R/g78NNkqpkDVQUoOvBXek=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gyyL+Rb6+sRIUANt2sZfZ3uMVb6kR+HhQ6PCeQpJDCD4veeTGn6vuDOGzSFbBaLuaF3I/htrR+fy0vfSUWS8Z8mMo35RMbLSxmKt3cPy6UkR4RXOdP+2+65TiWtUHd7jxRdcTTb6dIbTXwnuWiPQcv+uhAjc+jIR2Rrk6naiRQ0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=G1YtQzjk; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=H5tRBpoc; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: b561cd6ef40d11efaae1fd9735fae912-20250226
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=AZM4JsfOyzQtKsCqqnDM0R/g78NNkqpkDVQUoOvBXek=;
	b=G1YtQzjkCUEiueSiAEVoVw7subrkhnrSVbAe73O6sxtbFslxC5nyRcWgRiLIx0hTNQrT7DnXOCfWgRKiT6PcshGla2MoZiTK9dd6iVxr8czgZMHP8vUcSJrYg+s15D2WOMF+9b8rdtclc2F3jK1Kgc+6d/ZVQYclKKdskKFJLQ8=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.46,REQID:0a43be48-9347-4f49-8b11-b571f9ab02ec,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:60aa074,CLOUDID:6b2bf0d9-654e-41f2-8a8e-a96c1e834c64,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102,TC:nil,Content:0|50,
	EDM:-3,IP:nil,URL:80|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0
	,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-UUID: b561cd6ef40d11efaae1fd9735fae912-20250226
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw01.mediatek.com
	(envelope-from <skylake.huang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1955213078; Wed, 26 Feb 2025 14:48:38 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Wed, 26 Feb 2025 14:48:37 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1258.28 via Frontend Transport; Wed, 26 Feb 2025 14:48:37 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Uz/ovE6307o5DPcXiQpu8FPFkKgitcNvJ9LJ77RFxYivhQQJ5ouXtRSzPiZHiYEG7FjghspF5X8m2ORVP7TrmW6NBkBuW0hEfTgS4WJ4kOvXtBbOBTqqClC5BB1CTZZy3+JwcDwU0Ci0FansdP+/D20fOv8vCw+NtwTHwtiz/8UFWD98JPI3OGMKlUejQ8/oYbfzaumQW8SlQBc7fHTcSbkP5rmp0+ZjwclKpYB8laGrV89++GDmEUKyDbQeFImsRQ0Bc8PAJX6dhNxd8QlMYuDDtXs9bHxSFSPDgyd5siJwPPFmP2L8KFx5jBvs2Mj6xFU+ibszrwdTkKqjmnQrOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AZM4JsfOyzQtKsCqqnDM0R/g78NNkqpkDVQUoOvBXek=;
 b=ltwMjK5J1G4vZEhq4HuKbGu2JPsax5Nd/xdFxt3VyTo1BIfkJT2rc5qeVJJxrQCeCvrc5FE1rbQp0re8542FAIPChikOhC1Xvgo59Zr55QT3ENl80WbRUbjXYKOqThCF/2EDQpMRaZZGOO0KJKSbe3e956FPAVLPIEMjxIBUdy6OZzSm0erUcBkF/OJppEDG5xo3akeZDYvaLRBjx9w6yh88L8rQi82in5EJqueydqijZQGvPekdMvqUZZ9A+KU5aE9qjoUU5VEuD+OAHqbg5AIiCqZ1FZMCxkuKTZpo3nb1RilkyqDQbmVy5y1YYiKNYLN5E8P99DHLjgaFJTE61A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AZM4JsfOyzQtKsCqqnDM0R/g78NNkqpkDVQUoOvBXek=;
 b=H5tRBpocv4BYIA3ktL+LcEJiBfncHYIkYBpOKfqPBajHsstnS8ufFEwYqBPvIYtQ4zJpexnXnzAon3VsgonkyByTb8XiLs6m+Vxp6wxjbAiPI8HXMHgYsjgimMlzmh0Wi8KgeX4MSPUy+zWox0ZKIBk8NEjy4q0r51l5HMFBVm4=
Received: from KL1PR03MB6226.apcprd03.prod.outlook.com (2603:1096:820:8c::14)
 by KL1PR03MB8143.apcprd03.prod.outlook.com (2603:1096:820:100::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.19; Wed, 26 Feb
 2025 06:48:34 +0000
Received: from KL1PR03MB6226.apcprd03.prod.outlook.com
 ([fe80::f3:c11:8422:7ce3]) by KL1PR03MB6226.apcprd03.prod.outlook.com
 ([fe80::f3:c11:8422:7ce3%5]) with mapi id 15.20.8466.020; Wed, 26 Feb 2025
 06:48:34 +0000
From: =?utf-8?B?U2t5TGFrZSBIdWFuZyAo6buD5ZWf5r6kKQ==?=
	<SkyLake.Huang@mediatek.com>
To: "linux@armlinux.org.uk" <linux@armlinux.org.uk>
CC: "andrew@lunn.ch" <andrew@lunn.ch>, "dqfext@gmail.com" <dqfext@gmail.com>,
	=?utf-8?B?U3RldmVuIExpdSAo5YqJ5Lq66LGqKQ==?= <steven.liu@mediatek.com>,
	"davem@davemloft.net" <davem@davemloft.net>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "edumazet@google.com"
	<edumazet@google.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "hkallweit1@gmail.com"
	<hkallweit1@gmail.com>, "horms@kernel.org" <horms@kernel.org>,
	"daniel@makrotopia.org" <daniel@makrotopia.org>, "kuba@kernel.org"
	<kuba@kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>
Subject: Re: [PATCH net-next v2 3/3] net: phy: mediatek: add driver for
 built-in 2.5G ethernet PHY on MT7988
Thread-Topic: [PATCH net-next v2 3/3] net: phy: mediatek: add driver for
 built-in 2.5G ethernet PHY on MT7988
Thread-Index: AQHbgqn0+oUccgrII0yLc8X4a8i6V7NOXWgAgArSKgA=
Date: Wed, 26 Feb 2025 06:48:34 +0000
Message-ID: <5fae9c69a09320b0b24f25a178137bd0256a72d8.camel@mediatek.com>
References: <20250219083910.2255981-1-SkyLake.Huang@mediatek.com>
	 <20250219083910.2255981-4-SkyLake.Huang@mediatek.com>
	 <Z7WleP9v6Igx2MjC@shell.armlinux.org.uk>
In-Reply-To: <Z7WleP9v6Igx2MjC@shell.armlinux.org.uk>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR03MB6226:EE_|KL1PR03MB8143:EE_
x-ms-office365-filtering-correlation-id: 058d54ad-5bf1-48d3-211e-08dd563196f0
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?ZzBpTk5NU3VYRjNEQzI4U3F1WXFwNGJrYjc4b1liTThGcGc2TkZhbHgrVzJE?=
 =?utf-8?B?MFNXQks4NWU4SjByM3JIN3JmUHJkekhYYThpZWZVS3gvR1NaNVFJakVCL0tX?=
 =?utf-8?B?dFdKcy9CbUFwNzNzeTZTWmwvRGF3SnF4MDY5N0F5d1I2K0NWRWNKQ283L1hR?=
 =?utf-8?B?VVZ3cDFxTE1USFpCeUtNNkx4TmZNcVJsdWV4SmtNQS9TNjFGSDZ2bFNwNmwy?=
 =?utf-8?B?TU9xVkhyNU5ON1lsRy9ZdWtPMzZaZ1IrSys4YS9ETEU2OXE0SUNzeU14Zi9U?=
 =?utf-8?B?Uk9relJSWDU0ZVhwaTBiQmZPOGFtdHRTdnNRUStmMGhrMmFGd0NtL2xSVTBV?=
 =?utf-8?B?MVo3RFdHZGd0RE1tNHJrWjJ4dzE0WXFhZUdFYXQrbHl5aFBtKzA2ZUt0VnZq?=
 =?utf-8?B?aXJudE1EMUl3aXErY2laRWFBKzBFdDgvdktxVk1NbnZqNUxVM0hCOTFoQWM2?=
 =?utf-8?B?cDcxZnhZTk9uNlA1c3M2dnZRYk9DOFpSY3hCMDdJS1lOUVNrbWh4QXl1Q3BJ?=
 =?utf-8?B?VXMveUJUaW8wOUJFTnFXVXNaY0ovSmhKSlBnZDc4SjB3cTJ3cjZZODhUcVAv?=
 =?utf-8?B?c05MMjRGRllWV2ZhV1ZoMWxqdU83Z1JITWRVTkF4ZzlMbEJ1MXhaSHUzSGVl?=
 =?utf-8?B?MjAxVERLeWdsNzFLMS93ZU9Wa204Uk9VbURKaUx3ZmVTdmRPRHFVZUtPMzJ2?=
 =?utf-8?B?bGxmYWd3aHh4TjNEK3Z4U0tHNTNMTjZFRGU1dUJSdkpHc0lmK2JhS25DY0lS?=
 =?utf-8?B?YXMyS2V6Nm1vcFNCYzk5YmZGTTRoVjl4OEYvcDZKRmp4SDJwODJSa0RIM0s4?=
 =?utf-8?B?c2luc2MvNG5LcGVxQ3F1L0hnbmJBQWFjQTUyMml6Q040Nm5USi9wZHduWGFM?=
 =?utf-8?B?UGNTSTg0UXluQzhBUExaR05SYlUyM2lPd3QwMzA2bytSeXNSK0xUSU1sQlFl?=
 =?utf-8?B?SExvNWQ2K1NReGZ2WUc5ZU8wWlUramNJVkhSMTdZcHVWVlRIdnpUcjgvQVVv?=
 =?utf-8?B?d0R0LzdGd2lweVhSTllhZGZ1UHhIOEh3RGt2cGNzZnAvQi83b2ZoMmtYb2Uy?=
 =?utf-8?B?aitYZUlRaXp2Nzl4ZjBWLzZERmpieEdrRFM3aEhuem5wMFhmVmZQZ0NZb29P?=
 =?utf-8?B?K3FoYXMxbWx1R0NrdjN6NWNLWDZMMStrU0JwSTZOMlMwNmhrK1lTWllyWHhs?=
 =?utf-8?B?d0w5NzdldGttdVo0ZEVCK00wYmpZVnB6UHN4cFZFUXRhRnZWK3ErUHJpcTNy?=
 =?utf-8?B?dURiNmM1aUZyYm4wU0kxRFBSUE5halhITS9qUzZvdVdHOEw4L3lKR3FmRlls?=
 =?utf-8?B?RVFJZHJWamtHVEIrZklyNDZ5VmlKemN6ZUFKQWU0ek9NQzJzZmUwcUJBRVJQ?=
 =?utf-8?B?YlJET3FWdlNWenV2NjhNaStwVlYwV2M1Y20waVdsNmV5YU1pVjJ2bkdST0Vh?=
 =?utf-8?B?THJDeVdqQXp0MDlIbDluaGlRQTZqZm83RFhGR2dTUzFKSmd3UVpKOTUvelRE?=
 =?utf-8?B?R0lMRjVRaHI0b2M2dkJIYjA3NEt2UmpqS0NDY2RtaXdnaUliTG42TGMxZlJw?=
 =?utf-8?B?SzE2dytxdmZpSFd2aUlxbCsxUzNjVnJEd1NSU3JzK2cwL1ZJdXdqK2ViVXdj?=
 =?utf-8?B?NE5nZkEyazVSbmRibnR3V1RsR3lDaHFwbXFMMXBoS1ZEelZ3TkhqdWxBSnY3?=
 =?utf-8?B?T0UrVDhzT3dOa2lLUzFpcGFCSWZOeVB5SmwvRFE5NmQwSkIrOHd4bWdIZFdt?=
 =?utf-8?B?SllOZC9LRVBFYlpscG1WUWtZR3VIQXBrNHhKeGh0RXRQT0kwM0VjQ095ZlpW?=
 =?utf-8?B?MVF2TC9UbmxraXYweklDUmlaeE83K0hXY1VkTWZ5akxJVzA5SDQvZHB6U0o4?=
 =?utf-8?B?OUErNW9hZU1UWkpEaUZYUXVORkJJaU0xa0syWWhuSCsyQUE9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR03MB6226.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?d0ZvRy9wT0UxRUJEUTZIdVR1cExlWUJLTjBrZUpIdXJEZU12WWtCclNHaGtn?=
 =?utf-8?B?eGxZTTdITFhESDFuZVU3L0JXVG5rYzBPWTB1YU4xMEZ0ZnpTSnVCWEdyUjJU?=
 =?utf-8?B?QzNRbSsyT2k0MEpnbWVJWnp4bU9hYnFZUHdMeEozckpxTEV5NEliODdOa0NB?=
 =?utf-8?B?VWNpUmlxQU5VVjFrS3M3WWZhbG8xTWV1Zmc5ajA0RGY2OGZGUk4wSVFlMVdk?=
 =?utf-8?B?cjVLUlkwUm9nMFI3SFNpd0p1TXdvalpWV3RqY3M5WklYSHV2TSt1VWJ1dG9Z?=
 =?utf-8?B?VDBYTnlMNEVBVkozSmtiWHhJNUdpLzRMWnJONXFqcGRGQWhxck5sTnExZlVr?=
 =?utf-8?B?YWpHWUE4VTc1VVlybHJkaWlzSDcwaWJpWWJta2hKZmYyRnVwbmNvVjFsWkVS?=
 =?utf-8?B?dENvWVVldUNjaWlPdlRyQXZETThjTnVqMUxsWEliY3Q2MlJrMmp4RlFjVDVY?=
 =?utf-8?B?bWZ1Z3Uya3JGeG51QXdGZGg5dWNzRXdqYXRSMmZpZWRDVFZLOEg1Mi9MbHdT?=
 =?utf-8?B?MUkxaklUQUVuZk5qcVVnSnFYYnpJSWdVTW9HdEtEemFaQjJ5czl5TTF6MkE1?=
 =?utf-8?B?NjZRaTNmRkpDajB3YkJNV2NQOXpoQkRydWxLWTJoYzk5eTNheWg1YXFPU21M?=
 =?utf-8?B?MEdzbFRCWkgyQlcydzhpV240ZFFPbnQwVnRhekFTZmJZTE1lNjhkV2xBeU9k?=
 =?utf-8?B?c2x5MmVXcVZMSXA5YzMxZjNTNis3M3cvKzYxUnYwREtjRnFxUkd2ck1RV0Nq?=
 =?utf-8?B?aDFtRG5LQ0d6eFJGaTlKdXVBTnVMMDVhSWtkcm15eUpvemJRUk9LYnd5dVM2?=
 =?utf-8?B?RGVqWnJZaFB3Um5ZUHVQdFVoUHUwVlg0Wlh3c1gxWk9rQnJIeVBwSXNBTlVl?=
 =?utf-8?B?M1crL3dITE5tMjdjVmRNcEZjZzA5d3VPMVI4SW9FY2NTM1RrK0VNTm0wTVRN?=
 =?utf-8?B?VXRic1pMT1dDRFBQZUtaam1TS2M3RXpvR1M5YjhHZDVGVGxybkZuN3NIUFFu?=
 =?utf-8?B?dVVqRmRRbjNVM1dRbVEyZDBUR1JPMzBaM0tjM1JyWngrWjF1djBNM3IwdGlk?=
 =?utf-8?B?TkcwSlZSNys5cU0rWTRydHk4aDVkdmtBS3cza3pLR2dZN0FLYjl1YlQxODI5?=
 =?utf-8?B?eFpVbUFzK2hTdmR2K2pMSThxZHFiZWFWMXZsWVJmdnIyMTdwM1NwRzc3eFoz?=
 =?utf-8?B?cUlTQjRPRDlzZ05paGhucWRPTUd6WFN3bmFiTTlJL0k1ODVxZ0E3QkhWamtZ?=
 =?utf-8?B?ZmtpZVhZT3lvVXFRaHcxcVU1NkFGKzhVSUJBb2Jtd0ZMSlVvZ0dJc0Q2aDBJ?=
 =?utf-8?B?dnRWaXFybWdCNUV4MWUzN3BTTWVKeTFIMmUwUndwdnk5aTl3dmd2R1hTTnNk?=
 =?utf-8?B?V3BpdjdERGtmVlpSQW5IYTAvR054bFYrcnVqa0RPSEcrTWhjeTdEWURIU2pj?=
 =?utf-8?B?Y1QxMmhEV0VNS3hjL01FcHB6aEtEajJVSk1RZUFhQnpUSFNqUnJid0VhbVBU?=
 =?utf-8?B?YTdaaGlsM2E3aWRvWEhjZHJFOWhQaS9WTFhpMzR1SlUzUExqZHRudm10TDRa?=
 =?utf-8?B?YnVkQUZmdDlHU1FWamRrcFc0bnJGdUN2azU4YTRaMWFCV0ZnRUpPUHhHbHk4?=
 =?utf-8?B?VUtvdkFpMXRLejJRMU5TVGI3WnQzTDZZRTRkbmp2d1h6Q0JNZlgxbm5sTzBJ?=
 =?utf-8?B?K1dhaGVPZ3FxZGNjUVcxL0c3NmFJdXNPTC9EM3RFUUhFZE5zeEZ3K3Z6NmhG?=
 =?utf-8?B?OVU3UHNRRkJvTVhUUnFnOHRHd08zaFVVdU9qY2k0ei8yY0RVTmdNSkJ1WmtW?=
 =?utf-8?B?QWxZcGFNbU0rN1FIemVibU0razJKL2Z2SE5zeXNkR1d4aklMT0t5dTEzOUZL?=
 =?utf-8?B?SUphdWVJWnBlMGJ4WEVUTWlybDE2VWJVY2c4S3lRQUtTZWVSYVoxWFhzWkhR?=
 =?utf-8?B?SUxhYzN6aDdGREJiRml6V1RqWlpWeEZxNlY0a0FsVDNmbUJhaVJWWEpTQmYv?=
 =?utf-8?B?M3BnRzBPU00vVFhZY3Nyc2F4ZjFrUjIvRWZUdTIwTEE4NitLNERVTnJDN0lR?=
 =?utf-8?B?dHZFaFp3UldxSGJWbDdteFBXZ040ZUc5RkROVHJNNy9pNFFrWk4wNXBURldJ?=
 =?utf-8?B?T3Vjb05XcFhLcXdJZEFZOVZ1OUNtSkZ2WFhDcmpEVVpiSjhwd3R0dzhGTUo3?=
 =?utf-8?Q?zmodRx/5gFf+yKnh+p5lS38=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <395E63B24F92F9458AA04EBB7E5FD936@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR03MB6226.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 058d54ad-5bf1-48d3-211e-08dd563196f0
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2025 06:48:34.1831
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hqclf8W6nI+o9MQlqTWM/TEIUJRObRFUB8gkrM6R5VCfN1AKaJ6kRGIslgSJdaL91pB0O0l110nWaovA0rEe7ad9XQZcNihovwjLRwNqeX0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB8143

T24gV2VkLCAyMDI1LTAyLTE5IGF0IDA5OjMzICswMDAwLCBSdXNzZWxsIEtpbmcgKE9yYWNsZSkg
d3JvdGU6DQo+IA0KPiBFeHRlcm5hbCBlbWFpbCA6IFBsZWFzZSBkbyBub3QgY2xpY2sgbGlua3Mg
b3Igb3BlbiBhdHRhY2htZW50cyB1bnRpbA0KPiB5b3UgaGF2ZSB2ZXJpZmllZCB0aGUgc2VuZGVy
IG9yIHRoZSBjb250ZW50Lg0KPiANCj4gDQo+IE9uIFdlZCwgRmViIDE5LCAyMDI1IGF0IDA0OjM5
OjEwUE0gKzA4MDAsIFNreSBIdWFuZyB3cm90ZToNCj4gPiArc3RhdGljIGludCBtdDc5OHhfMnA1
Z2VfcGh5X2NvbmZpZ19pbml0KHN0cnVjdCBwaHlfZGV2aWNlICpwaHlkZXYpDQo+ID4gK3sNCj4g
PiArwqDCoMKgwqAgc3RydWN0IHBpbmN0cmwgKnBpbmN0cmw7DQo+ID4gK8KgwqDCoMKgIGludCBy
ZXQ7DQo+ID4gKw0KPiA+ICvCoMKgwqDCoCAvKiBDaGVjayBpZiBQSFkgaW50ZXJmYWNlIHR5cGUg
aXMgY29tcGF0aWJsZSAqLw0KPiA+ICvCoMKgwqDCoCBpZiAocGh5ZGV2LT5pbnRlcmZhY2UgIT0g
UEhZX0lOVEVSRkFDRV9NT0RFX0lOVEVSTkFMKQ0KPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgcmV0dXJuIC1FTk9ERVY7DQo+ID4gKw0KPiA+ICvCoMKgwqDCoCByZXQgPSBtdDc5OHhfMnA1
Z2VfcGh5X2xvYWRfZncocGh5ZGV2KTsNCj4gPiArwqDCoMKgwqAgaWYgKHJldCA8IDApDQo+ID4g
K8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZXR1cm4gcmV0Ow0KPiANCj4gRmlybXdhcmUgc2hv
dWxkIG5vdCBiZSBsb2FkZWQgaW4gdGhlIC5jb25maWdfaW5pdCBtZXRob2QuIFRoZSBhYm92ZQ0K
PiBjYWxsIHdpbGwgYmxvY2sgd2hpbGUgaG9sZGluZyB0aGUgUlROTCB3aGljaCB3aWxsIHByZXZl
bnQgYWxsIG90aGVyDQo+IG5ldHdvcmsgY29uZmlndXJhdGlvbiB1bnRpbCB0aGUgZmlybXdhcmUg
aGFzIGJlZW4gbG9hZGVkIG9yIHRoZSBsb2FkDQo+IGZhaWxzLg0KPiANCj4gVGhhbmtzLg0KPiAN
Cj4gLS0NCj4gUk1LJ3MgUGF0Y2ggc3lzdGVtOg0KPiBodHRwczovL3VybGRlZmVuc2UuY29tL3Yz
L19faHR0cHM6Ly93d3cuYXJtbGludXgub3JnLnVrL2RldmVsb3Blci9wYXRjaGVzL19fOyEhQ1RS
TktBOXdNZzBBUmJ3IWlWLTFWaVBGc1VWLWxMajdhSXljYW44bmVyeTZzUU8zdDZta3BkbGJfR1c4
aHN3aHhjNGVqSm96eHFrVTNzMld6eFNpenM0a2ZkQzc3eXI3SEdHUkl1VSQNCj4gRlRUUCBpcyBo
ZXJlISA4ME1icHMgZG93biAxME1icHMgdXAuIERlY2VudCBjb25uZWN0aXZpdHkgYXQgbGFzdCEN
CkhpIFJ1c3NlbGwsDQptdDc5OHhfcDVnZV9waHlfbG9hZF9mdygpIHdpbGwgb25seSBsb2FkIGZp
cm13YXJlIG9uY2UgYWZ0ZXIgZHJpdmVyIGlzDQpwcm9iZWQgdGhyb3VnaCBwcml2LT5md19sb2Fk
ZWQuIEFuZCBhY3R1YWxseSwgZmlybXdhcmUgbG9hZGluZw0KcHJvY2VkdXJlIG9ubHkgdGFrZXMg
YWJvdXQgMTFtcy4gVGhpcyB3YXMgZGlzY3Vzc2VkIGVhcmxpZXIgaW46DQpodHRwczovL3BhdGNo
d29yay5rZXJuZWwub3JnL3Byb2plY3QvbGludXgtbWVkaWF0ZWsvcGF0Y2gvMjAyNDA1MjAxMTM0
NTYuMjE2NzUtNi1Ta3lMYWtlLkh1YW5nQG1lZGlhdGVrLmNvbS8jMjU4NTY0NjINCmh0dHBzOi8v
cGF0Y2h3b3JrLmtlcm5lbC5vcmcvcHJvamVjdC9saW51eC1tZWRpYXRlay9wYXRjaC8yMDI0MDUy
MDExMzQ1Ni4yMTY3NS02LVNreUxha2UuSHVhbmdAbWVkaWF0ZWsuY29tLyMyNTg1NzE3NA0KDQpC
UnMsDQpTa3kNCg==

