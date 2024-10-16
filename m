Return-Path: <netdev+bounces-136199-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 634EB9A0FA1
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 18:25:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F7B71C2249E
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 16:25:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A36091DAC9C;
	Wed, 16 Oct 2024 16:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="JwsxZwUB";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="TotZH2Qu"
X-Original-To: netdev@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA3A745008;
	Wed, 16 Oct 2024 16:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729095936; cv=fail; b=ea7cdWGQz6oCgrww+y0Hn594pinOUvtcMIhTW9Th4KTkgMGu1Cb5Wnd+k7/atQpGeX1ZY3T2403X2MyTng1NPdhTOPqdLgZ7P4X5qi7O7rO3i7BPW+rZOsukOk8y3ELVHOkbSbSSCjoeFdTv2JZ6GJVkJwa2Vk6HsEqZ19VCXBw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729095936; c=relaxed/simple;
	bh=EHkGm0BQqqrfbCpFZJ/DyXZ59oJiHd93UsPPnwqKLpE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=q616glDs5U7fqI6wZle7J1RmuHCT1AAnUvKSXNqQEhQ/YA+XhNXPBKbWnY4ZOVT3kvTmZ49l+mhK6R7Ss+4vmMnf4LLLOZX6i7QToIsaTSrsseZngifkjWANhUy0t7JZ3zAYfs+4Po5W0jUmKo82tih0H3vmIBMnwto2f6X+FH4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=JwsxZwUB; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=TotZH2Qu; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 3ca1f7908bdb11efbd192953cf12861f-20241017
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=EHkGm0BQqqrfbCpFZJ/DyXZ59oJiHd93UsPPnwqKLpE=;
	b=JwsxZwUBNXV1rOex322lRTbfArN7Wl8ZU5CkvxEV//9A0Z1VcMOzk71bLa6Kgz1BhncKz8YQMMEeZ6XPhUquAMWVvmy4J1vLkstZxb4PE+edrClRH6Z1AQJivh9+EVXXDrPg7CT8giELKC22ZAlIqN85jnYDyeZSIQ0qUmLc2ss=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.41,REQID:d6468342-5262-4a78-94da-e736847183f0,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6dc6a47,CLOUDID:de59e406-3d5c-41f6-8d90-a8be388b5b5b,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 3ca1f7908bdb11efbd192953cf12861f-20241017
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
	(envelope-from <skylake.huang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 113812967; Thu, 17 Oct 2024 00:25:20 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 17 Oct 2024 00:25:19 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 17 Oct 2024 00:25:18 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gWkSbp2OhBLmoN1NYdbNK/00LZ61beNfKIoL+t69mTAuYvOKTb5w2nReph7Uj4KbOvwlk05xW6CTod5BriYcfxzpfgWnpucF0xYdMplhWfUBN3i6PVZu7hDhgAvpsq1HIR3Pcw41KZuEFKJFerx0sB2+JH6w3ErCn+fi85tJBFShNyTUbNX7u1RYA8+1WbNskrJii37v47D5QuD1Uh55WBbmpULiSrFufwCOpIYk1wDWM/UlSCMWHrTWnxJq7VYVqzNIgVNEuVmdMDbo0/YLAXHsN1RD2FXW/gpwu+51QIXsSb06WkhoLxYQRMyKTSSSZzYl5kPWl6RsmASFApQ6qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EHkGm0BQqqrfbCpFZJ/DyXZ59oJiHd93UsPPnwqKLpE=;
 b=WiIbcBKWwRXjXGu7kcTF9RIDHoM5kcAx5emXM8rnfX3In0CZUlIGmUMKVcKCYwWwPBu/CSxjj9zqDOZtQ1mYrkK8eVFKr+pBEfbqKiegOuUiy7FuBUi2HlFBpcchSwuj92Y/O5M1hJNie3KLYg4jCeL2DxN/CdGPtxFIS/fSgcpMHZDxheVzpjR4oVAmE9u+JhwJ8akP3DkL8120G9Jz5Yi5cHiQ8jVn4HRHlKv2xRKDdqHKxoQua+FHDnjrasu/sZ5jSmSvZalgLgr5IDucVE0P0ntgFlJbcGiB73NEba7D9PSsBVOiJEr/+l17zmavZjbadPjMtKIp+J4enVlIcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EHkGm0BQqqrfbCpFZJ/DyXZ59oJiHd93UsPPnwqKLpE=;
 b=TotZH2QuNyJBvHn7NQWYH22GHlGEHrFydRZRVbTVnrlNbUxnUQ4ppb08fbrc4WzMrJmIYekwj31TMGlhWt2A0QoSkODn9vk9Q14BHXbAue89L6L9JPCq7IQwvgQUFhEzsT+0s+1uJh+zjgJY1W9D9oYJu3UD9SRzI4ZqDEA9qYs=
Received: from KL1PR03MB6226.apcprd03.prod.outlook.com (2603:1096:820:8c::14)
 by TYSPR03MB7306.apcprd03.prod.outlook.com (2603:1096:400:414::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.27; Wed, 16 Oct
 2024 16:25:15 +0000
Received: from KL1PR03MB6226.apcprd03.prod.outlook.com
 ([fe80::f3:c11:8422:7ce3]) by KL1PR03MB6226.apcprd03.prod.outlook.com
 ([fe80::f3:c11:8422:7ce3%4]) with mapi id 15.20.8048.020; Wed, 16 Oct 2024
 16:25:14 +0000
From: =?utf-8?B?U2t5TGFrZSBIdWFuZyAo6buD5ZWf5r6kKQ==?=
	<SkyLake.Huang@mediatek.com>
To: "horms@kernel.org" <horms@kernel.org>
CC: "andrew@lunn.ch" <andrew@lunn.ch>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-mediatek@lists.infradead.org"
	<linux-mediatek@lists.infradead.org>, "linux@armlinux.org.uk"
	<linux@armlinux.org.uk>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "edumazet@google.com"
	<edumazet@google.com>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "dqfext@gmail.com" <dqfext@gmail.com>,
	"matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
	=?utf-8?B?U3RldmVuIExpdSAo5YqJ5Lq66LGqKQ==?= <steven.liu@mediatek.com>,
	"davem@davemloft.net" <davem@davemloft.net>, "hkallweit1@gmail.com"
	<hkallweit1@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>, "daniel@makrotopia.org"
	<daniel@makrotopia.org>
Subject: Re: [PATCH net-next 1/1] net: phy: Refactor mediatek-ge-soc.c for
 clarity and correctness
Thread-Topic: [PATCH net-next 1/1] net: phy: Refactor mediatek-ge-soc.c for
 clarity and correctness
Thread-Index: AQHbHe5Po7rJbLYEpUGiX5WMtC7nnLKF52iAgAIpUYCAAWRwgIAAHu0A
Date: Wed, 16 Oct 2024 16:25:14 +0000
Message-ID: <a498aca1ac932d66d38282fbfe614d927691ec01.camel@mediatek.com>
References: <20241014040521.24949-1-SkyLake.Huang@mediatek.com>
	 <20241014081823.GL77519@kernel.org>
	 <d2c24d063bea99be5380203ec4fafe3e4f0f9043.camel@mediatek.com>
	 <20241016143431.GJ2162@kernel.org>
In-Reply-To: <20241016143431.GJ2162@kernel.org>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR03MB6226:EE_|TYSPR03MB7306:EE_
x-ms-office365-filtering-correlation-id: e7babcae-a788-4d90-c2ca-08dcedff1d66
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?b2VLMXhkNEdwaUpsNXhvdHdoYVlsVHlCUnNEM3BXaCs5U01QUWg3ZGZXTFZS?=
 =?utf-8?B?K0NIeUFhc3RWeDI1MmEzK2NpbzZmNzU0azEwNHk3U0krOVkrcmxlQm0rV0c4?=
 =?utf-8?B?emVNUUhZNGJOTTJoYzN6MEQySlFQZTNlUU9KV0hSYjlKTHN1MnNYT0oxQnQx?=
 =?utf-8?B?Vjc4aTcydTJPNDNxbWJ6dmRlVWdRUlV5QmxuU2pHR0lvWnhqS1UyTDZnNkxM?=
 =?utf-8?B?NklvZDhJeWo0akszZmZCK1NhQXdpb2xES1BGeWcybm85WVkyODdidFpaUHk4?=
 =?utf-8?B?eFU2WlVYa3N4WW51c2l6eWxjM2ZSejhOZHNqQllkLzhwU0VrN09qMXhWdVhP?=
 =?utf-8?B?eEo4TlVPcEZzdjdRaWQrcTFDWmlyQW9YM0Z4RXVBSThWSTNtMGQ3ZVpoaVBq?=
 =?utf-8?B?Mzk1aWVTU3JFbWgwQ2VxMFhjUHFVY2Q4Z1RHbSs4NzYxdTJmd1RLSGtDN2tw?=
 =?utf-8?B?T255a20yRS91dTB5WnZyK2d1bnVRTkhzbVJ2bXVvL00wSHNQSDRhd2t5Mitk?=
 =?utf-8?B?QTB2U0Zzenlwb2x0YU5SSjd2QVdTNm41bXZldmtYajJta1hhL1pKR0xOWDVB?=
 =?utf-8?B?S1M4UDBGM0hhZGJNYzlDN0JTYWtJcnRSWDZsNzg0UUlKSVl2dnNaNXFWYlA4?=
 =?utf-8?B?c3VxYXFHaW1YRm0yazlkcXhFdG5qWmU5WnlON2MvL2o5a0pialdIaGg5T1Y3?=
 =?utf-8?B?ODJqalROeDNkMThyS1pDMXJSb1FyTkNxdWpqeFcvNFp2MExCODJXQlNFamNU?=
 =?utf-8?B?V05Tb0hUeU9ZcG1aMitkaHhhZi9rZHdNOWlveWRhbVFRSkFxTUVzN3h6NlNT?=
 =?utf-8?B?SnVwMjFmYXJLSmlXNlM1YzZhbktsMkFjNTBmVVZnVS9GY1ZReVJ4aDh2NlU1?=
 =?utf-8?B?cWpraS9YY2RMRWllQlppc3o5WlowWFBmMlRXR2d2ZG9QTlNZWGFBRDM3cXg1?=
 =?utf-8?B?TWVTUW9peS92NWFJZENYT2gwa2UzbkZ4OHphSTUyMngxUEFCU3ZqdUZFRVVy?=
 =?utf-8?B?dkx5NHlPS3pjNlhjelJlbXBYSTV4THBueG90QUpYcVJwY1d1TEFwRFkrQWxI?=
 =?utf-8?B?SXFzc1JnQys3dEpLaUNnQy9zTTF0WE9Vd1RCd2dORXhHT0pHZ05NQ0ZldmNQ?=
 =?utf-8?B?Y3IwV3JJOGlRWlJHWTZsNlNZaHRQMGxrVXlaME5TWlIyS0U0c1lURVl1UHVP?=
 =?utf-8?B?a1B6WG9rNmFOak0ycTI4b09nNjliazc5UXBFZlQySHRERStJMGEzRURKeVQw?=
 =?utf-8?B?YlVBb2xDUUZBTTB0bGRpa2ZZV21RY3ZjdFZ1S3YwUXYyNGtKa1BpdXN3Rkcr?=
 =?utf-8?B?djlJL1ZhWU9oSzhONU12RXVGY1RITUhRaG1ESkRLbjhQaWZWUjVZTGFMeHI0?=
 =?utf-8?B?cEw4M3pVUDFUbG1jTEU1WWJabHhYLzlhMmZNR3I1QzRFUFdkdnZiWlNuNi9T?=
 =?utf-8?B?Sm5tWStPWDR0d2VmTkZaWmt3NlV0S05tQ3BacDEvcnFaOGZVRStRQlpqeXh5?=
 =?utf-8?B?d0dJdmgyc2ZuZG9rTkZKTUN4SU1IdjJzWVZ6dFBoUCt5T29oRDlPRDIwY0Ru?=
 =?utf-8?B?WUJ5VkYxQy9KaWxiZlNxc0VoNVp6di9za0lGVFBweE5rUVhUNFFRd0FXWGFF?=
 =?utf-8?B?MStLN05nOFpPdFd1MWNMT1EramlTN0RLUzFIcTRHMjErVEtwYTlKaStXT1Zz?=
 =?utf-8?B?UVAzSEFvQzhaQ3VVRDBucnhDTENHNGQ1VFE5QXllY1hkT2tmalYzc3VMVlJq?=
 =?utf-8?B?ODJOUzB1cWZCYW1idHEzcnJxQmkxdzR6c3RDSFRxMkkycXRkd2V4WnZUeFdK?=
 =?utf-8?B?bVVxNzNlQWFnaDN1NWl2Zz09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR03MB6226.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Wmo1czRvY0xmaUN1dEl3bVZESzQ2UEY0UnJ0WWRNQkYvclU0Ynh2KzVLWk5O?=
 =?utf-8?B?ZWExc1FpckZzSFk0ZFNmbWJYZUxod0NIZnRqUzBVREh4WmFxK0RQZUdPQ0xt?=
 =?utf-8?B?RGw3K2ZERHo4SC9mVmFHL0Nwd244L2NPSUM2dGFVU2JvU1F4a2VBM3pDM0VF?=
 =?utf-8?B?czVTQ1B2aWpKUE9yazY3blkwbS91c0JxVThlczFGQlJiVm5BN2RGeFhNK2Vj?=
 =?utf-8?B?QmdHYzdhUWZWMVd4YU9nL3R2d1EzY0VjcUFjYmZxOHBKL2ZzVEdhd1duZ2lo?=
 =?utf-8?B?ajNjcWd0R3pNd2kwc2k3NmJTT1Z4YjY5SXkvK2h1RktlblJucUF2SDErMDJn?=
 =?utf-8?B?NWhHQ1BoTkRvRTBPZkowNzFsYW5FOHNLU2ppMWN5MjFiWmgxVVVlbHUvRFVp?=
 =?utf-8?B?ekNkUk1FV3ZzNHJKWnMzYmxuVkNuT3llRUlOUnVXRFpsa1IvTy9zdExTOXB4?=
 =?utf-8?B?SlZ5M1JyY01IeTVjZVFkbUN2NU02YWFNSDFNN0dnNHZmVDZuWUFzRU4xczN3?=
 =?utf-8?B?c3RCcmRXaEtWOGFHUVJLQ3NHR25pblRjWFpvUEhNbUF5ZGFncGZoMlQwdEdH?=
 =?utf-8?B?ZHJuZW5yVjYvVncycGx2T0VTaXI0RnZSOGIyY0xqdjhORUh2NVZyZVpyM0tm?=
 =?utf-8?B?NC9yR3J4Q1kwNC9RSXVXUks0M2tRNDA5OEZISHB4UnlXNmpNWUtsMFpzTzZB?=
 =?utf-8?B?c2VkMWVzTHFPODgwSTJIOXZyamRqVzZiUENkY21hNXpFY1Z4V0piUE5qenBJ?=
 =?utf-8?B?d0tZTlRndit2QjJlc05aYjFxeVM4RDNFRE5QVXNTMWRwK0VkY1ZnRFpFL3R2?=
 =?utf-8?B?dURRK1c0U2UyZTc0c2pNZ2UvcVB0Vnl0VzVHd096eEt2TjFkRDUzOUlacWdm?=
 =?utf-8?B?SWF5TitTK1RVOGJuMkFXUUZMYkFJT0VJbE5lTzJhZk4zMTgwM1ZnZmxrOGsz?=
 =?utf-8?B?anBvcTdodDVJV1A4eXI1TzBjL0x3b2Y1TGg4TFVTS2pkNVF4bEltU1RvNjhr?=
 =?utf-8?B?RU1nMnhWM3pCcjZ5NVdWWmZEVFFQVUErRnVmME9KdnVseWlKa3A1azcwdVJ6?=
 =?utf-8?B?S2lPWUhKRFdVcmpmRk5hNUg0Z0d5blB2bXc0NEdjSlZZb2xueGFoRUdQeEhD?=
 =?utf-8?B?TzIrRTBVMWcvbDBWQnowaks2a2N0MmxYOHNzL3V0ZUZ3dGtGRi9ySFpmRlBG?=
 =?utf-8?B?cVNqNW1pOTViUGlYY01zZnh0TDVneUlRWjRla0hzZlVaN3RuVFBJbWtha2dS?=
 =?utf-8?B?UDhzUGRhaHVsTU1MSUVDMm84NTVMRDI3QkVsZThrdjFFQVFBRFJFelQwa2hX?=
 =?utf-8?B?SXljUEloTUgwZmVDbXpDR0gxUklUMWtRNzBQQS9XQ1pSd01PeWxuaFJ0d2k1?=
 =?utf-8?B?NWdUVlNJc1FlRjA4dGVsamxLa1ZPT29qcWc1R29OUHk4QU9Za0ZORjFUbEY0?=
 =?utf-8?B?Q3RWbHRaWTBkZVgzc1d3aWt0dmRjTm9YT3pwdjg3alJscFBsWTdzOVBLanRG?=
 =?utf-8?B?aEFtd3liTlAreUw4VUpla0VYN3JaaEpoNGN4cVB4ZzZtVUJiMnVyK3dYYmdH?=
 =?utf-8?B?THRoWW1EemF5NENEd3VGdDZBSWR2VWo4eENHb3VFSVBXUXZkMC8vVzZKeEJy?=
 =?utf-8?B?emdJVk9ocko1TEh4czRQL0dZcXc5UEREdmRZWnE2TXZYUUJXR3hNNjdqWWJn?=
 =?utf-8?B?c0RkNGFWN09DOHZacTl3NS90TjRBV29ya1BKYThMcGZJc2RQZTZzam1iYm1z?=
 =?utf-8?B?SnZueklFRmwwZWpRdHFZOXpud0gxdGpTM0JGbmFuNTNJenZDTkprSzlGVVJ4?=
 =?utf-8?B?bHl5TzllNVhReTA4eXA4ODlLd0NUVzVPOXJhM1pJTjVTV1B0S1RFYTJHWkZo?=
 =?utf-8?B?dTIrcFhaVFNZUDFVNmV4S1NkNjJoWiszWXlEN012eVhuNEpnV0FocmNvSDFW?=
 =?utf-8?B?bkRRN0h3ejhEblRXRVJhZVRtQkw3QUFZVDJaaGtHRmFyWjhab0dYWll5Qkgx?=
 =?utf-8?B?N0J4dFFNcWhPbU15aExjK0JnVjJkbTZpWVgzeXl3WFZibUJVbGFaUXV3NW55?=
 =?utf-8?B?aVdRSUhnTjFZMXZYNllldTk2VzVPNlNSbmRFR1BMSU83SkJnOU9CTDdCYUt1?=
 =?utf-8?B?R0kzb2k2a1N6dldqTkN4WjdWbzAwUVN4eUwyQ1FNYnF4VWlYZlhKOWVvamw2?=
 =?utf-8?B?REE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EFD5DC6F580DDC4FB58120B800E5E19C@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR03MB6226.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7babcae-a788-4d90-c2ca-08dcedff1d66
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Oct 2024 16:25:14.5419
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5weqWex4sTOh6mDAzpEHqLzEMrIDPRN2PYtbXmD/ylWv3mUFqACbsixJ8sv9Vke4e4sQpF5xtPMiuvsC6totjpN8XLCuTSxxjU5HC1DD74U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR03MB7306

PiBJIGRvIHRoaW5rIHRoYXQgd291bGQgYmUgYmVzdC4NCj4gQnV0IGlmIHlvdSBzdHJvbmdseSB0
aGluayBvdGhlcndpc2UgSSBjYW4gdHJ5IHRvIHJldmlldyBpdCBhcy1pcy4NCg0KSGkgU2ltb24s
DQogIElmIHRoaXMgZG9lcyBjYXVzZSB0cm91YmxlIGZvciByZXZpZXdpbmcsIEkgY2FuIHNwbGl0
IGl0IGludG8gYSBmZXcNCnBhdGNoZXM6DQpQYXRjaCAxOiBGaXggc3BlbGxpbmcgZXJyb3JzICsg
cmV2ZXJzZSBYbWFzIHRyZWUgKyByZW1vdmUgdW5uZWNlc3NhcnkNCnBhcmVucw0KUGF0Y2ggMjog
U2hyaW5rIG10ay1nZS1zb2MuYyBsaW5lIHdyYXBwaW5nIHRvIDgwIGNoYXJhY3RlcnMuDQpQYXRj
aCAzOiBQcm9wYWdhdGUgZXJyb3IgY29kZSBjb3JyZWN0bHkgaW4gY2FsX2N5Y2xlKCkgKyBGSUVM
RF9HRVQoKQ0KY2hhbmdlDQpQYXRjaCA0OiBGaXggbXVsdGkgZnVuY3Rpb25zIHdpdGggRklFTERf
UFJFUCgpLg0KDQogIElzIHRoaXMgb2theSBmb3IgeW91PyBEbyBJIG5lZWQgdG8gc3BsaXQgdGhl
bSBpbnRvIG1vcmUgcGF0Y2hlcz8NCg0KQlJzLA0KU2t5DQo=

