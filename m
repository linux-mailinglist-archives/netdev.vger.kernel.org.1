Return-Path: <netdev+bounces-99458-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F05018D4F86
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 18:01:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 39F6EB21327
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 16:01:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E02B1CABA;
	Thu, 30 May 2024 16:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="dHGzGBSQ";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="isO+MleC"
X-Original-To: netdev@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCDAA3D68;
	Thu, 30 May 2024 16:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717084889; cv=fail; b=IeH92ObU2eSeec6zTu8PQEQt+6jEK+zkxgyTdUWiLnUUcTvtBp4VqTtZgFe9fYP/1gtdF9SPOCnCm7SI0GbOhAgyB8U+Mapfx5fup2IviB6NWaO+BdxUFY0V8L7cab7Jk8tvugrhLNiDm76dS/FQYHuJWuG7+156GMlE/EejqMk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717084889; c=relaxed/simple;
	bh=mNqU7x212PL8nQWtFx0Sapz9khZb1HBM5p5POUb25Q8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=OCjIxTMN2AH2DHm7oyL5etJpkfvDTdVpGC85JnVsANvQ0lFBV7Aht/1zPBzw7QlljJb2FApsT0RO79Tu8eStdG8LfLV+kVDfX0DPmemvnHGnI2T3QIqJUZCdkTSlQeDYUb2w8xdUx6I0De+5DxE1PxHT3HKEFzJmNy7gwQVngl8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=dHGzGBSQ; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=isO+MleC; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: d8a8ab3a1e9d11ef8c37dd7afa272265-20240531
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=mNqU7x212PL8nQWtFx0Sapz9khZb1HBM5p5POUb25Q8=;
	b=dHGzGBSQoolrWoLvmGAEkSxJVijkzHAIA4dZIShjv925igDreN6seZ1z9zTzVwmA+Rw/pG42RxnYR/rn824iC8nj5skPs64RfJ5AD3ySt3oaBJY9zgKKwF2LLRMkVzxLt78pnVxcyyAj7UB65YZXp9QFec0VwsWVqbtMpMBf7FI=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.39,REQID:aba70e7c-84d1-4f61-a568-5eabf3aa5a8a,IP:0,U
	RL:25,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:25
X-CID-META: VersionHash:393d96e,CLOUDID:a84c8484-4f93-4875-95e7-8c66ea833d57,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:1,EDM:-3,IP:nil,U
	RL:11|42|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,
	LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: d8a8ab3a1e9d11ef8c37dd7afa272265-20240531
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw01.mediatek.com
	(envelope-from <skylake.huang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 365960561; Fri, 31 May 2024 00:01:16 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 31 May 2024 00:01:10 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 31 May 2024 00:01:10 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iwqjF2xJW8pnOTvQr+quAccBHyNxdVkYFytG6mEu4FF8dWsyrNFt6/ZFRPKFpOEfToC1wX/xfpYIBCWx2ciiAiyPDk619aGiBreQR+zA+eGHolc7S4LbEm4ayRy6oHawLZC2tpmoxw7QXObCdAyOISTE5h8JbzhFC3tkgLKoHrFxCjvnW59JjNViNLgjvtFPY2RZHroHXBi8qMVnXUSHj4QdSX0JOcLDGM3etpW3pGp7mliPJeQTGJOwxfdXsa+fR3kUIwMKtr6fETOjlpLTxio0AAGFcMNOGhez20Lsuep/1OW9D6ONEz4EDe1RMLGnJfayeGEp+NaL/3+kfjXq+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mNqU7x212PL8nQWtFx0Sapz9khZb1HBM5p5POUb25Q8=;
 b=X1AwroICDL6wb94b0hIwIYmFLeWRx2jZRh5rr2PigD9VSE9CVjVBhPEo/HhEy2k7NlqYFwJapf4olkaXaSkKGkMcnfptSPLX1QNovVYvWmbma0FAGHT0J/A+oowObM/tf0fqkl5tm0dViraYDfUj9yAZDEyUY6CE2nKxbCJxxkIf9EfeHeo/pra3KB5zuE+cAaowt2QvCRi50LopSNQuBNESQtV0RTYGzLgmBhVtbRSUc4OK103/0HnE8fI/Zm9Wp5iqfdaSRf8imQ3dhFtqjE/nQxVwWTY8+Ro7hGHE2tu2N6ZfB+mOWxKHgW9ffnOTA0RUm0h+2y37uj5jJ9rfEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mNqU7x212PL8nQWtFx0Sapz9khZb1HBM5p5POUb25Q8=;
 b=isO+MleCq7orJDwj1SAC+AkAN3sr9IGU0ysE2pFPUFnDvJyznc7RmxIATljprWyxZ1KLMsGLkyprVePb9rmPCssq7m32SPN5V+jP9+WdyZvqoJNbF0eiLEFnCGD3CHP/svrY0TqVtY3famEw2t4Y9ie+2I96tJbixppRvR07F24=
Received: from KL1PR03MB6226.apcprd03.prod.outlook.com (2603:1096:820:8c::14)
 by KL1PR03MB8118.apcprd03.prod.outlook.com (2603:1096:820:102::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.16; Thu, 30 May
 2024 16:01:09 +0000
Received: from KL1PR03MB6226.apcprd03.prod.outlook.com
 ([fe80::f3:c11:8422:7ce3]) by KL1PR03MB6226.apcprd03.prod.outlook.com
 ([fe80::f3:c11:8422:7ce3%3]) with mapi id 15.20.7656.007; Thu, 30 May 2024
 16:01:08 +0000
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
Subject: Re: [PATCH net-next v5 4/5] net: phy: mediatek: Extend 1G TX/RX link
 pulse time
Thread-Topic: [PATCH net-next v5 4/5] net: phy: mediatek: Extend 1G TX/RX link
 pulse time
Thread-Index: AQHaskSf1DfXvyWrZkOPqw4pAUjQdrGvkmKAgABeO4A=
Date: Thu, 30 May 2024 16:01:08 +0000
Message-ID: <a6280b885cf1cffa845310e7e565e1dd7421dc66.camel@mediatek.com>
References: <20240530034844.11176-1-SkyLake.Huang@mediatek.com>
	 <20240530034844.11176-5-SkyLake.Huang@mediatek.com>
	 <ZlhTtSHRVrjWO0KD@shell.armlinux.org.uk>
In-Reply-To: <ZlhTtSHRVrjWO0KD@shell.armlinux.org.uk>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR03MB6226:EE_|KL1PR03MB8118:EE_
x-ms-office365-filtering-correlation-id: 128fde34-5eb2-4375-e38e-08dc80c1b7f6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|376005|7416005|366007|1800799015|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?WnM4Q0o3dEFKWWIvTVhiOTlZcUgvL2k2bEVJZUVndGE4TEt3QWVhWTBScFZV?=
 =?utf-8?B?dHBhMWhkbTU5dmE1b0hsb3h3MnRTNDBGMmIwaVYzWHl0UC8rNXl1Szd3YndM?=
 =?utf-8?B?eXJka1JWOTd4VDRldS9oNVpyTEhxZ3JnSk0wcVVkaVJOZjNYRFNNZFpwRzlK?=
 =?utf-8?B?Y3BkU0V0eGdTZzQwY3hla2Fic2k0aVA4T0VISkM5RlUwTnJKUUhpeTV6TkFv?=
 =?utf-8?B?bkpCVUQrRVpZbTBqSFl4Ui81bzc4VGkzSW5jTEZ1dlF2b0ZZOVQ1eWV2dHdw?=
 =?utf-8?B?aXU0OTJHcFVNdTY1RjRJSlI4TjNkQmIzWnVRaG9OcHJMdnBROXBzaGNmRzEw?=
 =?utf-8?B?OFVTbDBVbjgzcGNScncwNmx6WHZ2eld1QnZDdC8rSkRJazRvYUR4S2NCTUIx?=
 =?utf-8?B?OGxZa2o1c29Ydnl0SFBST09HUUt0eDU2ZWJwNGlkVStEMUVidjYzaWlVWWpl?=
 =?utf-8?B?dG9jc28rSDJqb2RaR1NCdkdvMkMyWFpQN2dqRFE5WlpLWExEWVFnOXF2RkZv?=
 =?utf-8?B?QlZpNVJBSFVtbFRrN0JwYTZid0tsWFV3VHVpZXRiTHMrdnFUdlZ2cXBkWWM1?=
 =?utf-8?B?MHZPajBIeHlrS0g1MWZEU294d2xEL1RQMEYxdTRUbGN6ZytLQXNGSU1zYUoy?=
 =?utf-8?B?QTZqTjFqa0JlYmNvK1NLbXVMS3AzUDRqaTBJSkVqRVFWNDZmMEhRaHNyNDhY?=
 =?utf-8?B?Qk9CaVpoYjZsdW9IZk05bjkwUUNDbFdXVlRpbUJVckdjOE5aMW41ekM4NldE?=
 =?utf-8?B?Wm5CNExDMTIrMWJLdXBxRUEyZm93RXZTNU9iZVFDcnl1UFBmZm1kZjdnMUk0?=
 =?utf-8?B?QWwxcUI4VVU0U1RUUStCNEoxeGZmNWtSdnJNUUwvRG9YSGR5RW9vaTRuMUt3?=
 =?utf-8?B?c1lsK1J1Yk5JRUZEMUh0eEFmRWR6UTRkU3lYZ2JoTXdYclA2Nm14R1VFWGJw?=
 =?utf-8?B?Q2NESWZJNEFTY3VMRTZiOXFlTHV5Y3RUZEczQTdWMjkwd2VkSDk2ckNGb1ht?=
 =?utf-8?B?ejBCNWJzcElCNWpxZlJLUE9SWFJsSk9pUytlRWZYMnlrcnEvM1ZOSzFDYmpG?=
 =?utf-8?B?U1YxalI0REZtbnhZeDVaTlBiM1hPMUFNeUZraFpqRFNCd0NsNHpMYmhrUE01?=
 =?utf-8?B?SmRoT1lTWmQ4ai9mNzUvU0lKazBIQUkzWUdoRDc2M3Rya2dQRU9CU0V5dEJ1?=
 =?utf-8?B?cm5OQ05vTXNrbXBWa3FLYThTYTByZkFXc2s1dytmZ21NeE0zRml4OUxkSlIy?=
 =?utf-8?B?UEYyZEx1Z1A2Q09LVVY4aUR4OTBBd0tEQUFrejh1K0xhK1VZZkdiQWo5dk0v?=
 =?utf-8?B?bVVid3diaWdDc0E5L3NSOTVzV0VGZFpXRkoySnd4M3hsWkhEd05uSXpQT2hH?=
 =?utf-8?B?QWk0bGVpUFdQRS9IZnd5SkVZMmhubEdjMDJLcGxBaGRwMERvL1lid3Y0UUs0?=
 =?utf-8?B?a0hGMWZaMEVNdVJYV2VIeURtZkp0ZVpxb25vR09WaXB1VU1hOWlNa3MyL2Ri?=
 =?utf-8?B?ZnZuL2NsdEJnazl3SHc2NnZqTUFCbldKK2xaSzlpVXFNZzdSbFE5cmNIRDRW?=
 =?utf-8?B?NjRXRjBqREpWMEFqdHBlUS9vb0pxd0sxSkFZTjVMZC8rQWZ1aVJONlRFaUxD?=
 =?utf-8?B?akJRaUlYS0d3S054NWlOQjJHeDFzNWJqRGV6K2VnVlBMcjAvZ05zN2swZmlO?=
 =?utf-8?B?SUx4T0ZWazh5Y0pjaFZrblpmNEpWRTRvTGRJMEpURjFqSUFEWjZoYnJRPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR03MB6226.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(366007)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Ymx0aE9JQ0tPZ05TdDZNdWVFRjdyWUxjMEsrUWZXd1VNcW42cnQ4MHBHM1N4?=
 =?utf-8?B?N0IyajBwL2szNFVWM1RmeDRKT25IWXNsUHA4aytjVExEWEpYZndqYlF0eWVo?=
 =?utf-8?B?R3ZyTUpDWHU5ZFBwMDdGUTA0TTl0bkJmMi9wTzJoNVVZaXdodktJeG10V0s0?=
 =?utf-8?B?TzJpa001VS94STVkMER0RlIvdSt2U1FyNVplU3M3RXBrUlZlZzNQR2UvWEdr?=
 =?utf-8?B?dHhaaE4ycGgxczZoR3NTdW53MTV3Sk12ZnRYTnZ3QmgrdWRjZHhpR0V1dDVS?=
 =?utf-8?B?RjhPZVRPRDNXVUN6Y0JjZ1hnYlA2ZVlMRWN0TytRM2l6MXdHNjZCZ2JIQWc2?=
 =?utf-8?B?bEZXdFRpeUs4Z0RDZlVPMWFSSThmeUZLVElCVk9VOHA5NGZnaXIxZGlmK3lL?=
 =?utf-8?B?UmEwMTNoRUsra0xJWVY4V05Seit0eC9FVmZHSjVWM1pLVWhPcjVzNHNSQ0JP?=
 =?utf-8?B?OGkzOEpkNi8vRHF5TjVqQXBGSkJsZFFzWkZydTJET0J5TEFreUxUc1kwK1Va?=
 =?utf-8?B?TzU1WjNOWFBWVzZpL0FuSWIwY2dSTFdjT0Y0T0xJQ0ZQSWxoTkpPMk1NOGxM?=
 =?utf-8?B?dVhzNnM1ZWxMRy9JaytMRnFDZC9XNFdaZVVMT3d2Q1VBY1RtWGg2R0hXNEda?=
 =?utf-8?B?MkdWb2dZcTFsYmlzdUZSVldoMUxMM05xdmpabmRMVTR1cGlrbVVXdFRZYWw2?=
 =?utf-8?B?WEU2bnNreDBWSG9FRmVCaHNYNVJCMWZ3ZEVZM1ZZQzJEd1RuY2xnZFJQQ3B0?=
 =?utf-8?B?a0NyRTU3WW1ZRHRKUHE0ZUVVRWhGUGkxOHBJZktyc3g3a1BpUVlCK000Vy9Q?=
 =?utf-8?B?MG51V3FjSlNJOUpYNDRFWm9uak9GL0dscjlaZGhpTjFUUXNwNkRZSVJsUGgv?=
 =?utf-8?B?eFNLMHRJc0xNK3g5VzJUOFNBd1VUajdQZUZzY205OG9NOEcwTjlQWTNZNWN4?=
 =?utf-8?B?Z3dUZENDWUp2Zlp4U0t6WE1tWHVHYWVEcE5tRkxraGZxQkhWRXJZNXc3clJ6?=
 =?utf-8?B?R3hqSWsvS0x6Rks2L0Zoek9xUnFtaVpKa1YyNlVYS3FGMkx6ellGem5iTGtw?=
 =?utf-8?B?blhqSldoTXhGM05XU3dxczhEVkF1N0FxNmtUTlB2NldGM083Yk5mQklTVXZR?=
 =?utf-8?B?eE9xTnZtZUdoazRnQ2xXZEl5WHVKVjVPa3h0Vko0S0wrNjQ3WjcwTnhZYlNp?=
 =?utf-8?B?dmJrSm1UVnl5c3BXMzJlRU1xeFI5S2MrYmpDcjhBNXZYOFVKNGgraHcxMHEx?=
 =?utf-8?B?dVE0cHdHRlVMVkJWMWFxMksvVnJlSlBuNkxxQmdtSU1UVUZ0SWdoVXBEQ2R5?=
 =?utf-8?B?SjltZ2E5QmdreWFyTTUzN3JzTW9XczYzR0pkUjdSTG5ZMTVoK0REdDk1MW9s?=
 =?utf-8?B?K3lIbno1UjNwemNobkpXdUU5VU5IMWVIbklneGFWd1pxZGNBVE9SeE5uM1BN?=
 =?utf-8?B?SVQ4VjR1ZENWRkRZTEhycWdPQXNBZTh3TUZobTBYdnRUM2dTK1MzRjI0UTNX?=
 =?utf-8?B?WEw0ZzgvT2haUXYvWnNDekVJdWdvTkYxblpha05Yek03ZW55SnhuUzB1Y29F?=
 =?utf-8?B?SGpzTW9sMHZmMmR1V01welI4ZjhldzFrL1VtNFZ2M1FvS3M5K1F4aGVSNW9x?=
 =?utf-8?B?TnFoTlFnQjczQjJhdFFQWGN0amdmOENLbHdVTXhKZFp1NDRrQ2RZaDZSVWJ0?=
 =?utf-8?B?VXZNbkxFV1ZDWjNhWFB5dVROTEFiY3RwNmZuMjRQUXJpUmpkZTBqcXAzYTRl?=
 =?utf-8?B?c3lNRlhSVS92VVFGOFVrVFdpUjRvQUFHZFNXRGNsM0xxYm8rbTNMbFg0REFs?=
 =?utf-8?B?V2t5d05mK0x3VDlIbmZXWHY4YjlTSFJwT0hvbmFkeUcxbU5ISHB2U0tCMmtn?=
 =?utf-8?B?Z29JTWRzYmtvZ3IvckRhYnphQmpKUzYyUFNtVVFGMFFkdTNSZTJqTDdYODVL?=
 =?utf-8?B?RTF1cDVnN3VSbHR5N0lsZGhONlNlQVNRaDE0UTl0c1VLb1ZLbVJtVDN0dVhL?=
 =?utf-8?B?MHhiMGEwTUsxU1NXN2lQRHd6TklreUx5VG1EUVI3eEZGdDJuaitjVmpGVVNR?=
 =?utf-8?B?TVQrWFZyb1VmdW1zZXZVZUdUZWhnRzlTbjdZREpDYWVrUHd1Z1RJTEF0UFdS?=
 =?utf-8?B?clVaSFd5MmFkNlRZYXpxRGdKZFBQUGE1Tng0ejVZTmh3UzZFcjdiWnFBZWd1?=
 =?utf-8?B?REE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FCCE0736F500604D944E8D95095FD0D4@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR03MB6226.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 128fde34-5eb2-4375-e38e-08dc80c1b7f6
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 May 2024 16:01:08.3133
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zBwI3nmPi0yTwR5oIsZz6pUkeh3QSx5pSphhhSXTToTMy5ZuomQti975pKLTEe9JnRuzDZmS3hycOZENGGBAZI6E5KtAvlg8guE1XNLkLIs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB8118
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--23.785100-8.000000
X-TMASE-MatchedRID: gIwa0kWWszLUL3YCMmnG4qfOxh7hvX71PbKer+BoZT9SHuP4uj8E9MkU
	hKWc+gwPyGJ1SiZNgOOsXAiB6VK48AbbLE2rYg/9wvqOGBrge3shmbYg1ZcOnr84twmKEd99h7Y
	HWQOgdau+8mjGjS5MxD+Y4Ojh3fJRt/K29VNwEQWO0rt0LpQGeacJxWZ5/lR8feHPnu31iHA30E
	eCx5K2K2VdND2VIZc0bj2aLY2YKTXLRU+lYaWxvp1U1lojafr/g3XZcphu4kteNs5tWYvjCVfoZ
	Tbv2LGTdgpFqmK1AE+Rk6XtYogiatLvsKjhs0ldVnRXm1iHN1bEQdG7H66TyOk/y0w7JiZo
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--23.785100-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	5D3D61B6B1AA27C46040F3D6E4B8738E0C84FC7E9225534D804CF4AABA3826DB2000:8

T24gVGh1LCAyMDI0LTA1LTMwIGF0IDExOjIzICswMTAwLCBSdXNzZWxsIEtpbmcgKE9yYWNsZSkg
d3JvdGU6DQo+ICAJIA0KPiBFeHRlcm5hbCBlbWFpbCA6IFBsZWFzZSBkbyBub3QgY2xpY2sgbGlu
a3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bnRpbA0KPiB5b3UgaGF2ZSB2ZXJpZmllZCB0aGUgc2Vu
ZGVyIG9yIHRoZSBjb250ZW50Lg0KPiAgSGksDQo+IA0KPiBBIGZldyBzdWdnZXN0aW9uczoNCj4g
DQo+IE9uIFRodSwgTWF5IDMwLCAyMDI0IGF0IDExOjQ4OjQzQU0gKzA4MDAsIFNreSBIdWFuZyB3
cm90ZToNCj4gPiArc3RhdGljIGludCBleHRlbmRfYW5fbmV3X2xwX2NudF9saW1pdChzdHJ1Y3Qg
cGh5X2RldmljZSAqcGh5ZGV2KQ0KPiA+ICt7DQo+ID4gK2ludCBtbWRfcmVhZF9yZXQ7DQo+ID4g
K3UzMiByZWdfdmFsOw0KPiA+ICtpbnQgdGltZW91dDsNCj4gPiArDQo+ID4gK3RpbWVvdXQgPSBy
ZWFkX3BvbGxfdGltZW91dChtbWRfcmVhZF9yZXQgPSBwaHlfcmVhZF9tbWQsIHJlZ192YWwsDQo+
ID4gKyAgICAobW1kX3JlYWRfcmV0IDwgMCkgfHwgcmVnX3ZhbCAmIE1US19QSFlfRklOQUxfU1BF
RURfMTAwMCwNCj4gPiArICAgIDEwMDAwLCAxMDAwMDAwLCBmYWxzZSwgcGh5ZGV2LA0KPiA+ICsg
ICAgTURJT19NTURfVkVORDEsIE1US19QSFlfTElOS19TVEFUVVNfTUlTQyk7DQo+IA0KPiB0aW1l
b3V0ID0gcGh5X3JlYWRfbW1kX3BvbGxfdGltZW91dChwaHlkZXYsIE1ESU9fTU1EX1ZFTkQxLA0K
PiAgICAgTVRLX1BIWV9MSU5LX1NUQVRVU19NSVNDLA0KPiAgICAgcmVnX3ZhbCwNCj4gICAgIHJl
Z192YWwgJiBNVEtfUEhZX0ZJTkFMX1NQRUVEXzEwMDAsDQo+ICAgICAxMDAwMCwgMTAwMDAwMCwg
ZmFsc2UpOw0KPiANCj4gPiAraWYgKG1tZF9yZWFkX3JldCA8IDApDQo+ID4gK3JldHVybiBtbWRf
cmVhZF9yZXQ7DQo+IA0KPiBTbywgd2hhdCBpZiB0aGUgcG9sbCB0aW1lcyBvdXQgKHRpbWVvdXQg
PT0gLUVUSU1FRE9VVCkgPyBJZiB5b3Ugd2FudA0KPiB0bw0KPiBpZ25vcmUgdGhhdCwgdGhlbjoN
Cj4gDQo+IGlmICh0aW1lb3V0IDwgMCAmJiB0aW1lb3V0ICE9IC1FVElNRURPVVQpDQo+IHJldHVy
biB0aW1lb3V0Ow0KPiANCkknbSBub3QgZ29pbmcgdG8gaGFuZGxlIHRpbWVvdXQgY2FzZSBoZXJl
LiBJZiB3ZSBjYW4ndCBkZXRlY3QNCk1US19QSFlfRklOQUxfU1BFRURfMTAwMCBpbiAxIHNlY29u
ZCwgbGV0IGl0IGdvIGFuZCB3ZSdsbCBkZXRlY3QgaXQNCm5leHQgcm91bmQuDQoNCj4gPiAraW50
IG10a19ncGh5X2NsMjJfcmVhZF9zdGF0dXMoc3RydWN0IHBoeV9kZXZpY2UgKnBoeWRldikNCj4g
PiArew0KPiA+ICtpbnQgcmV0Ow0KPiA+ICsNCj4gPiArcmV0ID0gZ2VucGh5X3JlYWRfc3RhdHVz
KHBoeWRldik7DQo+ID4gK2lmIChyZXQpDQo+ID4gK3JldHVybiByZXQ7DQo+ID4gKw0KPiA+ICtp
ZiAocGh5ZGV2LT5hdXRvbmVnID09IEFVVE9ORUdfRU5BQkxFICYmICFwaHlkZXYtDQo+ID5hdXRv
bmVnX2NvbXBsZXRlKSB7DQo+ID4gK3JldCA9IHBoeV9yZWFkKHBoeWRldiwgTUlJX0NUUkwxMDAw
KTsNCj4gPiAraWYgKChyZXQgJiBBRFZFUlRJU0VfMTAwMEZVTEwpIHx8IChyZXQgJiBBRFZFUlRJ
U0VfMTAwMEhBTEYpKSB7DQo+IA0KPiBUaGlzIGlzIGVxdWl2YWxlbnQgdG86DQo+IA0KPiBpZiAo
cmV0ICYgKEFEVkVSVElTRV8xMDAwRlVMTCB8IEFEVkVSVElTRV8xMDAwSEFMRikpIHsNCj4gDQo+
IHdoaWNoIGlzIGVhc2llciB0byByZWFkLg0KPiANCj4gVGhhbmtzLg0KPiANCj4gLS0gDQo+IFJN
SydzIFBhdGNoIHN5c3RlbTogaHR0cHM6Ly93d3cuYXJtbGludXgub3JnLnVrL2RldmVsb3Blci9w
YXRjaGVzLw0KPiBGVFRQIGlzIGhlcmUhIDgwTWJwcyBkb3duIDEwTWJwcyB1cC4gRGVjZW50IGNv
bm5lY3Rpdml0eSBhdCBsYXN0IQ0KDQpBZ3JlZS4gSSdsbCBtb2RpZnkgdGhpcyBpbiBuZXh0IHZl
cnNpb24uDQoNClNreQ0K

