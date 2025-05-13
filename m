Return-Path: <netdev+bounces-190025-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B97C6AB502C
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 11:45:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4256A1B409EC
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 09:46:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE64F23AE7C;
	Tue, 13 May 2025 09:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="gu5+XahE";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="ImAM/QNm"
X-Original-To: netdev@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE10B23908B;
	Tue, 13 May 2025 09:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747129538; cv=fail; b=GzxnSvVaab5d1JEgvr48XA5x7j/ZXzukkuhjppePNfIx76NuRQi7fH4SrlgRcY+lMDqiDpuKSQhwv1SGYgulpETx5jmFxB/RHJGK4WhQq3UKH8VmuBahygYCobTLOv1bRUvL9fuNJ6ou9BVHdtNL/Ps8CRv4V6QhxcE2ozWDjbI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747129538; c=relaxed/simple;
	bh=HAzsRSHZOBJhDymArU5gLCIk3rWLZPFU5zYiqOy6jfU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=SniC/KNeP3e06N/VnRiEonhkPcW/6p1tqY0m8VnU5poATl/CJ+bYNTY8ttSVrTWiPrFH+v58ARYF4kmYl2mCqNQFFGTo4VKPVZdA1dPfzl0ZwqNDow5sDP7ZDsOsLdiwYal4Y3CbwarGpFJ/7gxivUN26E+ioLbL7nKPrNF+n90=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=gu5+XahE; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=ImAM/QNm; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 024340882fdf11f082f7f7ac98dee637-20250513
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=HAzsRSHZOBJhDymArU5gLCIk3rWLZPFU5zYiqOy6jfU=;
	b=gu5+XahE+L5lxhEEh/KqkUj4lhdAAdPyTlrW9IAxleqZRahIvAg2kTkXgFEqcyflui4ItUlL9AzYh1UNgT7X+/w/2J5lcbQOvCgd6GflMGRxx5UrLMyVnuczq0rXY/jjWR68CxlWkWfgdCj3m2SUnlIW9PSrWNKnJnDV0Zbm4dQ=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.2.1,REQID:7a461da1-7012-4246-bf63-79d1ad12835a,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:0ef645f,CLOUDID:c7eba7b7-5e6b-4d0f-a080-a5e9cb36bea6,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|110|111,TC:nil,Conte
	nt:0|50,EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,
	OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 024340882fdf11f082f7f7ac98dee637-20250513
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw02.mediatek.com
	(envelope-from <skylake.huang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1479957682; Tue, 13 May 2025 17:45:31 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.39; Tue, 13 May 2025 17:45:29 +0800
Received: from HK3PR03CU002.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1258.39 via Frontend Transport; Tue, 13 May 2025 17:45:29 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ViEaxJQSgbxaZ5DuT7RTsKy3o/t47iVG+7UANb+/q7to6UhKr6XbwiKSDuXSCZg+vFpyE7dYLu/CX/W1DpeXh1+POTi8lAc5yVYwuBbQaRd5XbyCJRzqY9SEAsASI0bEMPthAqhNSUs55DLTO06oPnzdR3vEesEJmon46GpjBlLQ+zSG0n7ReEa12J6FP5DimOkoQ4+W060Vo84Ol3/Nnn0oaOAlGHYieVjKI2aSC5FLNEBmsBrLpuHjZe1f0JLXRY4bNKGzJzURE3k5xISq20Tfo+nF8jguPSbJwY9/l2lV3AZH3BqEdJMlq2Dq7uscIm4kwdyA3+aOYauBtRObMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HAzsRSHZOBJhDymArU5gLCIk3rWLZPFU5zYiqOy6jfU=;
 b=a0L+kyG6R5sH1ScPM1wwua2FC7/znIAUberPJpTE6JCztinCR+96V/1bkSFqx3Mqry+OYikPWaDN7ZIpeqLJsIyLon8w04psjlSBcc8ykqVOwF/A46Ca9a72UDhOlWorU6QnkGHp2+yqhI8ny509GANuWIehunUw6/EMCdwplK9ESbqkIBPs486zSTr+clKW3Vix+Y5p8vIXZbF9QOfi1VIbf1nn/itrbQCdftBuC3SfhBqWTIVmzrSwPHXM3NoybS/TtuMQUSfWD3prGjZgxpy3IXk0j9cnfVSZyXzUQoLZvLqQwHQG42AWKNODCrNdgQEXcC5+NSjC+leOgaiwgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HAzsRSHZOBJhDymArU5gLCIk3rWLZPFU5zYiqOy6jfU=;
 b=ImAM/QNmsNXC70zvxsuv09kp5dgW8T+91Jz/khT0BEsikeb6x5ZcdYHXN9PeJ0mdEJyQzRGmEkXjl8bADMrE8DifWX1Qt/u8rx1/+2EB3CzLvXGGq3N1Hd3avWKZ9Apl45UgKGw7IILEtotIHiVsr0NfwNsggFUVi/zOGMLaLzM=
Received: from KL1PR03MB6226.apcprd03.prod.outlook.com (2603:1096:820:8c::14)
 by TY2PPF55FE3F4B5.apcprd03.prod.outlook.com (2603:1096:408::9d4) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.29; Tue, 13 May
 2025 09:45:26 +0000
Received: from KL1PR03MB6226.apcprd03.prod.outlook.com
 ([fe80::f3:c11:8422:7ce3]) by KL1PR03MB6226.apcprd03.prod.outlook.com
 ([fe80::f3:c11:8422:7ce3%3]) with mapi id 15.20.8722.027; Tue, 13 May 2025
 09:45:26 +0000
From: =?utf-8?B?U2t5TGFrZSBIdWFuZyAo6buD5ZWf5r6kKQ==?=
	<SkyLake.Huang@mediatek.com>
To: "andrew@lunn.ch" <andrew@lunn.ch>
CC: "dqfext@gmail.com" <dqfext@gmail.com>,
	=?utf-8?B?U3RldmVuIExpdSAo5YqJ5Lq66LGqKQ==?= <steven.liu@mediatek.com>,
	"davem@davemloft.net" <davem@davemloft.net>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"edumazet@google.com" <edumazet@google.com>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"linux@armlinux.org.uk" <linux@armlinux.org.uk>, "hkallweit1@gmail.com"
	<hkallweit1@gmail.com>, "daniel@makrotopia.org" <daniel@makrotopia.org>,
	"horms@kernel.org" <horms@kernel.org>, "kuba@kernel.org" <kuba@kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "matthias.bgg@gmail.com"
	<matthias.bgg@gmail.com>
Subject: Re: [PATCH net-next v2 1/3] net: phy: mediatek: Add 2.5Gphy firmware
 dt-bindings and dts node
Thread-Topic: [PATCH net-next v2 1/3] net: phy: mediatek: Add 2.5Gphy firmware
 dt-bindings and dts node
Thread-Index: AQHbgqnLe8B1VmttFEm1xmvjplPof7NOv+6AgAABHwCACSJvgIAAL8sAgADxXwCAAJoMAIB3M3kA
Date: Tue, 13 May 2025 09:45:26 +0000
Message-ID: <a7f1848eb200c1ee117ba4aa192751f4266efc6e.camel@mediatek.com>
References: <20250219083910.2255981-1-SkyLake.Huang@mediatek.com>
	 <20250219083910.2255981-2-SkyLake.Huang@mediatek.com>
	 <a15cfd5d-7c1a-45b2-af14-aa4e8761111f@lunn.ch>
	 <Z7X5Dta3oUgmhnmk@makrotopia.org>
	 <ff96f5d38e089fdd76294265f33d7230c573ba69.camel@mediatek.com>
	 <176f8fe1-f4cf-4bbd-9aea-5f407cef8ac5@lunn.ch>
	 <c5728ec30db963c97b6e292b51e73e2c075d1757.camel@mediatek.com>
	 <8bc68f1a-5abd-478c-9b9d-2c8baa6bb36a@lunn.ch>
In-Reply-To: <8bc68f1a-5abd-478c-9b9d-2c8baa6bb36a@lunn.ch>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR03MB6226:EE_|TY2PPF55FE3F4B5:EE_
x-ms-office365-filtering-correlation-id: a72c6baa-b359-44ff-427a-08dd9202e395
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?cXV0dnJJUStCUHBTK3dUbGR6T0RXaTNFM1VDYnd1OThQdDBTeEdYVUk4MURz?=
 =?utf-8?B?YmE0UHhha3J3SzZuN3M5UWFQVVhIZ3k3cGdON1BwSXJmN1YycEx2bk01enlW?=
 =?utf-8?B?em1hQzV0bG4xRFV0ZE04MHMyVlN5TStWaFBQQnFQUE5mUlZHWEg3Z09wd3p3?=
 =?utf-8?B?b3lOZHZ5RGFwaS90eFo3NmZNVnJhLzdoMXFsdWY3a1lhQjRZZWJGR3M4bWJM?=
 =?utf-8?B?Yk1udDAvUXFUUmdKUFZaR1NKZk1GaHFqd2phN21mUzZYQjBVZEc3V21kSVdi?=
 =?utf-8?B?L2VzUEN3VzM4bmJoVFpGRmp4bFRTR1lMMTg2Wm1iOTBrMTN4MHJGN0FMQnFI?=
 =?utf-8?B?RlR0UUczWGxEeWlBRzBoblBRK2tJQkFHRVk2ak9RYmVmSmF6aHg1dndzM1dx?=
 =?utf-8?B?T1diWXNiL3M3TGI2Tm95TC9jK0xGemxhZThJZ1RaSzJjUHpWNHZVeWliYjI4?=
 =?utf-8?B?KzNKZTh1dHlmaThIUFlHczJRcGdhSk5qdjAzakw1R3R5OUg1cXV4clJDZWl0?=
 =?utf-8?B?dDZuSlNHTWhGcmZqU0h5UTdUaFpIcW50amhVaUFqTWVzK2lKVVNpMkczOWF3?=
 =?utf-8?B?dGthMWN2MGxxN3BkOUJQNVVKTUtNSEFkOUh1V0QyOGk5QndtWWEyUEJLaUFL?=
 =?utf-8?B?K3pKekloUHlNZlBmWXhZRzJCeG4yRUZRU1pvenROcmxJb3ZWeEhJeFZsOGtO?=
 =?utf-8?B?VW1ob2pxZmg2V0JSejZkTHBvcUJOY2ppSkhsWkJ4bmhselRteXY5ZjZlaGpO?=
 =?utf-8?B?Z210WjFxRmRNNHNuaW1RWjJZcHViZndsRWhkSmtNSGxaMzlqSDdrV1lBVmR0?=
 =?utf-8?B?bENrLzkzK2dPd3ZFRDlWWm9nZTI3Zk5haHZNdFo4UFRTL2ZFT25NM2pKWC9Z?=
 =?utf-8?B?RkNVa0hWZ2J6UVhQTldPdlN5Tkx2RmlQTURsYm5YcXhTMW5CSGc1U1p4Ukdi?=
 =?utf-8?B?Rld2SXFrZUxhc3RYcWZhVFdFVXR2VlRRQWNoVzBqRkJVNThDVFhoUzhRWWIy?=
 =?utf-8?B?SnlXUFJ4b1FnKzIvQ0JTbFlOMUk3K1Z6K2wrZ1dkelByWFlDTmJwcmR4V1VN?=
 =?utf-8?B?eFdrODNKWFk0cmMyL3k1d0p6cVpQTzVldkZyNUVvTHJ4NUJkQjRZVHZ6Y0Yr?=
 =?utf-8?B?czRyVWZGb2RURnlLNjRpUjBWWGxNT3V1MU83S24vTExPTG5zc3FCU0NiaFFt?=
 =?utf-8?B?WUxxeEpscjFQRkVsNFpiMUN0c1RMbDhJS3dqUUdTdzhlSTQ2aWxKZVdKcW8v?=
 =?utf-8?B?N3pITFAyVTF6eW8vdld0MXIrUEJFNWRLMVZSWk5nV0dEMFNhNzR0T2NYNGRn?=
 =?utf-8?B?MVhtcVdpbnNCMTNrQ0Y5SFRrOHlFUnNkNU9WQ1J2d3plWFdkUitRc3pKWWhI?=
 =?utf-8?B?WGdFaHdYRTlFRENpR0pJZVI4K2hkR2FvZGpFZTJ6enMyamtQU1dOMFlEQmNQ?=
 =?utf-8?B?NUUyRXpsMXNsVUloby8vUktPdGhjTzROcXJBQVowbEg1YnJKcndOV3FKRVdF?=
 =?utf-8?B?TFRsVXJuQ0hPcEdPcWtuN3pJQ0xnekM5VW1JNlhQbGpidHU5T0dnM3Q3VitE?=
 =?utf-8?B?ZTZvVkpJeHdVODRxRlFMM2MyNWJIN0RkeHZXcXB3eTMvZ3FjemVpSHBUZG04?=
 =?utf-8?B?OC9UWXhFSURqQ2htOHN2TS9uUzRUOUF2TmdZZDBtZ1ErTjlyR1U5WXR0RzlU?=
 =?utf-8?B?cDN1Z3BiaWZvallUbkg3aXJ5cmdiRzBJdHhJSGpJL3h4clFLTnM1T1B2bkZX?=
 =?utf-8?B?NG84WlVBU1ljaHpMR0FwVVErK3FJbURXMk5HZXRkWUxDUzVzTmlMYWYrSFE3?=
 =?utf-8?B?QmZJWGtYamRaS0lLYnJ1TmNmSzdPVWZ3eGd0TWMyTDEyVGtDemd2UUR5akc3?=
 =?utf-8?B?NEJubHd5SVhOemNYdmpMbm5TOGVTVGFCSGs4VXBOVitMVUxhdDZjT3NTa2Z0?=
 =?utf-8?B?Z09iSWpqa1Y3Q3B6SVhwMWtqc0JnVTVXb0Q2TDBFNHlYYW5wY0tYZlg4NWNr?=
 =?utf-8?Q?L+yToa8WVFSS1aCMC3ErH0lhvA4ox4=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR03MB6226.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Y0dHaXpuK0pzQzRxazNWM2tZTTdua29vZUhnT1UrYi9tMzBwVmtmOUZlYy9P?=
 =?utf-8?B?dDREZUxXenMxRVYrV0d2ck5Ecm1LRUw5MTJMN0hSWjVJdS9lMG16czNMb2Na?=
 =?utf-8?B?Z0kvUjN4bS9HbzdKa1JrWEpaQk5IYVVEUXVtdHFjYW5DR0lEMklLMHQvWlo4?=
 =?utf-8?B?d3F2a3lGMnp5djl4M20xT1FsU3B2ZDZ4eWFRRDRiem1kZTNjYmdDbTB1cXJi?=
 =?utf-8?B?RkgxN0tRZ0hzUzVmdjlPS2dFTjJNay9zeCsyWWZtNkl2VTN1TzdwZzhvNklK?=
 =?utf-8?B?emtDc0R5M00ycytJMGVpSXVMbWZYSTlDZ004LzBaQ2FEb2hhN1lhM0NLN00v?=
 =?utf-8?B?VUhXTzVyVit6Ti80S016RW1KaW1lOHlQdEsrQWp0QmJNZHNjVWYvNHZYeWJ0?=
 =?utf-8?B?ejJ4L0pNeWpSbG5GOFppT3N1ZUxkamNpbEZTeE1ZcG80bDJnSmtXdUgrZDNl?=
 =?utf-8?B?b3AvNk5QZmg3bUtvR3BsUlZ4SDRNWVVSbkhoWjFnV3YvdXIxRHdCNDhxdm9P?=
 =?utf-8?B?V3ZXU2JYRGR4UTdCVzhMc3dFUjFQb0JOdk5JMEtjWFRKMjRwSFJlZEJhYk5k?=
 =?utf-8?B?OWpDS3hGRFdodVZlUjVtVDlRSm52eGcyUHpVamxHWkV6UWx1UlZBT2tqbzZL?=
 =?utf-8?B?YzBWYlNySGJVc2RpM29QOW5yTG9pbG85SXI3NUg3MW1DV1VWVFpISXJhNjNF?=
 =?utf-8?B?Szc0U2ZCVkp0OEMzSU9jSSt2Qm9aRFRXREsrOHVGM0IxSTNteVRkOGdmK3pr?=
 =?utf-8?B?aTNwaE9JbUxuMmVVNmVNelNnSkw1SHBydGdzRFJWVEJZZXRneTNoU01Gd2h0?=
 =?utf-8?B?RU05SUxSa2IxMTBVdkpsamVMRkhZa0haMWpPMW9qVDJPUVpBdVp5QUFkaEtS?=
 =?utf-8?B?aGhVaDljdnFuU1FmM2N4TFZUdjd2L09jaDlXVVNoZklwNmhLcHNPM09MNC9J?=
 =?utf-8?B?NitYS1I4cE9xUGRPS2hNVTBhWEs3SytEN1hrYncxK2xlQjZFbVFuYklGOW9S?=
 =?utf-8?B?aFpDRk5ISVNQUWJSRmE5VFZDakUvK1Uxb1BDWGpyZ1I2U3ptQ0tZQzhNc0pL?=
 =?utf-8?B?WVNoL3F1Qm1SeHFHd095MWg0K3RPUDRQUHNCUEx1TkVnRzZCUEg0TzdlckxD?=
 =?utf-8?B?OXkrR0Y0UFhXZHRJa1BXeWJxWkdYTjFyYjd6cVk3MnZmMlpwckl5WE5nbU0x?=
 =?utf-8?B?OWdENEJ6STVITDV6SHlQMEhKV0VJRzQ4MFJsSndBUU1nQjRIRUtLSkQ4Y0d3?=
 =?utf-8?B?N1ZyamRlbjcyZStvNi9tZkozSHdwbXJhRmhtZ0JrZW5Hd3ZCOS8xalNvZk9Y?=
 =?utf-8?B?N3drWkd6STJVakFsZ0dUb2EvSFc3NUtRWWhyZzN2RDJXWDdNQjlFdGVYNmwz?=
 =?utf-8?B?K0pobGl1c2E1UzhLcjBleFNidnNaa3pISzVlQUY4T3RvaW1JMWF2d1A1UUV1?=
 =?utf-8?B?WVJteTNzeGxsZDhPU0xMYTdKa215VExCZlN4NTA2R1JQLzBmMWJ5ck90UTZX?=
 =?utf-8?B?M0ZYeFVlNS9TVlMwSW82dXowYlZXejRzQ3FHZTBSYUpsbTZzYnZZN09hUU5S?=
 =?utf-8?B?cElmS0RodUtUTTJWL2QxSHpmTDRrS2tmSzZod0NGd2xPL2tnbmZKRDh4Ti92?=
 =?utf-8?B?VkwzamxwYzcvSjV2LzgxTEpXcXBhMWJlY1ZtcFRlUXluQ01jaHpKR2RRUm5o?=
 =?utf-8?B?eXRlWlpoeHA0R0JENjNRb3ExY1FBd3FaODBjUkx5REh1MmhsVkU1Qy8zQWxD?=
 =?utf-8?B?ZCtRRnpMb0h5K0l1Q01GSHIwK29NWDBMNm1nU0RvdFpROUFFRVRhUHordC80?=
 =?utf-8?B?cmkvOGxBRHM3bjV6N2xubEgyYWIzMlVlMFI3QTV3bnlGem5vcDd0RGpGaTdh?=
 =?utf-8?B?akRyU0FHenhOUVpIQkhrbi9Mb01FQjdpL1dzbGJLQlFCNGt6QzVkRzRrdklI?=
 =?utf-8?B?UG1mQU5TbjJZbm9DUXJGaXJJU2tER2taVWRhdGxtbzY0anNlOTJDbzcwamI4?=
 =?utf-8?B?YmhPRkFhTXkxT05nWmJjUFlEUkhNMVpHT3lIeHRpU0VkUGxxQkdtZkhtRkdq?=
 =?utf-8?B?emtMQnM3UklWS3hPbm11alIwUzE1Zk1aVzdZRUZud29VM2tRbkhYY0grcHI2?=
 =?utf-8?B?Qk9sVEpwdkcwaU9vMEZQdFBrR2p5WXlsMmExYnBPR0ROU0dCTUQzWk1OTmNj?=
 =?utf-8?B?Nnc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4A564A53D6A1FF47A971942DB6A5D16C@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR03MB6226.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a72c6baa-b359-44ff-427a-08dd9202e395
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 May 2025 09:45:26.1791
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Jgno7Pde+yuXBXl4a6Yre0ToAGrtu/P6XSuNhBbtIP5ECp1WCCtEzvti3eKmeiTKjgtuvEVMPNlSkCb2aNjzLjU71i1Lm9ywwxIpBDlt8Xc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PPF55FE3F4B5

T24gV2VkLCAyMDI1LTAyLTI2IGF0IDE0OjI2ICswMTAwLCBBbmRyZXcgTHVubiB3cm90ZToKPiAK
PiBFeHRlcm5hbCBlbWFpbCA6IFBsZWFzZSBkbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRh
Y2htZW50cyB1bnRpbAo+IHlvdSBoYXZlIHZlcmlmaWVkIHRoZSBzZW5kZXIgb3IgdGhlIGNvbnRl
bnQuCj4gCj4gCj4gPiBTbyBJIGd1ZXNzIEkgY2FuIGRvIHRoZSBmb2xsb3dpbmcgYWNjb3JkaW5n
IHRvIHRoZSBwcmV2aW91cwo+ID4gZGlzY3Vzc2lvbjoKPiA+IDEpIFJlc2VydmUgYSBtZW1vcnkg
cmVnaW9uIGluIG10Nzk4OC5kdHNpCj4gPiByZXNlcnZlZC1tZW1vcnkgewo+ID4gwqDCoMKgwqDC
oCAjYWRkcmVzcy1jZWxscyA9IDwyPjsKPiA+IMKgwqDCoMKgwqAgI3NpemUtY2Vsc3MgPSA8Mj47
Cj4gPiDCoMKgwqDCoMKgIHJhbmdlczsKPiA+IAo+ID4gwqDCoMKgwqDCoCAvKiAweDBmMDEwMDAw
MH4weDBmMWYwMDI0IGFyZSBzcGVjaWZpYyBmb3IgYnVpbHQtaW4gMi41R3BoeS4KPiA+IMKgwqDC
oMKgwqDCoCAqIEluIHRoaXMgcmFuZ2UsIGl0IGluY2x1ZGVzICJQTUJfRldfQkFTRSIoMHgwZjEw
MDAwMCkKPiA+IMKgwqDCoMKgwqDCoCAqIGFuZCAiTUNVX0NTUl9CQVNFIigweDBmMGYwMDAwKQo+
ID4gwqDCoMKgwqDCoMKgICovCj4gPiDCoMKgwqDCoMKgIGkycDVnOiBpMnA1Z0AwZjEwMDAwMCB7
Cj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZWcgPSA8MCAweDBmMDEwMDAwIDAgMHgx
ZTAwMjQ+Owo+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgbm8tbWFwOwo+ID4gwqDCoMKg
wqDCoCB9Owo+ID4gfTsKPiAKPiBEbyB5b3UgZXZlbiBuZWVkIHRoZXNlPyBJIGFzc3VtZSB0aGlz
IGlzIGluIHRoZSBJTyBzcGFjZSwgbm90IERSQU0uCj4gU28KPiB0aGUga2VybmVsIGlzIG5vdCBn
b2luZyB0byB1c2UgaXQgYnkgZGVmYXVsdC4gVGhhdCBpcyB3aHkgeW91IG5lZWQgdG8KPiBzcGVj
aWZpY2FsbHkgaW9yZW1hcCgpIGl0LgoKQWdyZWUuIEknbGwgcmVtb3ZlIHRoaXMuCgo+IAo+ID4g
MikgU2luY2UgUEhZcyBkb24ndCB1c2UgY29tcGF0aWJsZXMsIGhhcmRjb2RlIGFkZHJlc3MgaW4g
bXRrLQo+ID4gMnA1Z2UuYzoKPiA+IC8qIE1US18gcHJlZml4IG1lYW5zIHRoYXQgdGhlIG1hY3Jv
IGlzIHVzZWQgZm9yIGJvdGggTVQ3OTg4ICYKPiA+IE1UNzk4NyovCj4gPiAjZGVmaW5lIE1US18y
UDVHUEhZX1BNQl9GV19CQVNFwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAoMHgwZjEwMDAw
MCkKPiA+ICNkZWZpbmUgTVQ3OTg4XzJQNUdFX1BNQl9GV19MRU7CoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgICgweDIwMDAwKQo+ID4gI2RlZmluZSBNVDc5ODdfMlA1R0VfUE1CX0ZXX0xFTsKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgKDB4MTgwMDApCj4gPiAjZGVmaW5lIE1US18yUDVH
UEhZX01DVV9DU1JfQkFTRcKgwqDCoMKgwqAgKDB4MGYwZjAwMDApCj4gPiAjZGVmaW5lIE1US18y
UDVHUEhZX01DVV9DU1JfTEVOwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAoMHgyMCkKPiA+
IAo+ID4gLyogT24gTVQ3OTg3LCB3ZSBzZXBhcmF0ZSBmaXJtd2FyZSBiaW4gdG8gMiBmaWxlcyBh
bmQgdG90YWwgc2l6ZQo+ID4gwqAqIGlzIGRlY3JlYXNlZCBmcm9tIDEyOEtCKG1lZGlhdGVrL210
Nzk4OC9pMnA1Z2UtcGh5LXBtYi5iaW4pIHRvCj4gPiDCoCogOTZLQihtZWRpYXRlay9tdDc5ODcv
aTJwNWdlLXBoeS1wbWIuYmluKSsKPiA+IMKgKiAyOEtCKG1lZGlhdGVrL210Nzk4Ny9pMnA1Z2Ut
cGh5LURTUEJpdFRiLmJpbikKPiA+IMKgKiBBbmQgaTJwNWdlLXBoeS1EU1BCaXRUYi5iaW4gd2ls
bCBiZSBsb2FkZWQgdG8KPiA+IMKgKiBNVDc5ODdfMlA1R0VfWEJaX1BNQV9SWF9CQVNFCj4gPiDC
oCovCj4gPiAjZGVmaW5lIE1UNzk4N18yUDVHRV9YQlpfUE1BX1JYX0JBU0XCoCAoMHgwZjA4MDAw
MCkKPiA+ICNkZWZpbmUgTVQ3OTg3XzJQNUdFX1hCWl9QTUFfUlhfTEVOwqDCoCAoMHg1MjI4KQo+
ID4gI2RlZmluZSBNVDc5ODdfMlA1R0VfRFNQQklUVEJfU0laRcKgwqDCoCAoMHg3MDAwKQo+ID4g
Cj4gPiAvKiBNVDc5ODcgcmVxdWlyZXMgdGhlc2UgYmFzZSBhZGRyZXNzZXMgdG8gbWFuaXB1bGF0
ZSBzb21lCj4gPiDCoCogcmVnaXN0ZXJzIGJlZm9yZSBsb2FkaW5nIGZpcm13YXJlLgo+ID4gwqAq
Lwo+ID4gI2RlZmluZSBNVDc5ODdfMlA1R0VfQVBCX0JBU0XCoMKgwqDCoMKgwqDCoMKgICgweDEx
YzMwMDAwKQo+ID4gI2RlZmluZSBNVDc5ODdfMlA1R0VfQVBCX0xFTsKgwqDCoMKgwqDCoMKgwqDC
oCAoMHg5YykKPiA+ICNkZWZpbmUgTVQ3OTg3XzJQNUdFX1BNRF9SRUdfQkFTRcKgwqDCoMKgICgw
eDBmMDEwMDAwKQo+ID4gI2RlZmluZSBNVDc5ODdfMlA1R0VfUE1EX1JFR19MRU7CoMKgwqDCoMKg
ICgweDIxMCkKPiA+ICNkZWZpbmUgTVQ3OTg3XzJQNUdFX1hCWl9QQ1NfUkVHX0JBU0UgKDB4MGYw
MzAwMDApCj4gPiAjZGVmaW5lIE1UNzk4N18yUDVHRV9YQlpfUENTX1JFR19MRU7CoCAoMHg4NDQp
Cj4gCj4gU2hvdWxkIHRoZSBQQ1MgcmVnaXN0ZXJzIGFjdHVhbGx5IGJlIGluIHRoZSBQQ1MgZHJp
dmVyLCBub3QgdGhlIFBIWQo+IGRyaXZlcj8gSGFyZCB0byBzYXkgdW50aWwgd2Uga25vdyB3aGF0
IHRoZXNlIHJlZ2lzdGVycyBhY3R1YWxseSBhcmUuCj4gClRoZXNlIFBDUyByZWdpc3RlcnMgYXJl
IGluIGRpZmZlcmVudCBkb21haW4gd2l0aCBVU1hHTUlJJ3MgUENTIG9uCk1UNzk4OC4gVGhlc2Ug
UENTIHJlZ2lzdGVycyBhcmUgb25seSB1c2VkIGJ5IGJ1aWx0LWluIDIuNUdwaHkgd2hlbgpsb2Fk
aW5nIGZpcm13YXJlLiBJJ2xsIHN1Ym1pdCBNVDc5ODcncyBidWlsdC1pbiAyLjVHcGh5IGRyaXZl
ciBsYXRlcgphbmQgd2UgY2FuIGNoZWNrIGlmIGFub3RoZXIgUENTIGRyaXZlciBpcyBuZWVkZWQg
b3Igbm90LgoKPiA+ICNkZWZpbmUgTVQ3OTg3XzJQNUdFX0NISVBfU0NVX0JBU0XCoMKgwqAgKDB4
MGYwY2Y4MDApCj4gPiAjZGVmaW5lIE1UNzk4N18yUDVHRV9DSElQX1NDVV9MRU7CoMKgwqDCoCAo
MHgxMmMpCj4gPiAKPiA+IHN0YXRpYyBpbnQgbXQ3OTg4XzJwNWdlX3BoeV9sb2FkX2Z3KHN0cnVj
dCBwaHlfZGV2aWNlICpwaHlkZXYpCj4gPiB7Cj4gPiDCoMKgwqDCoMKgIHN0cnVjdCBtdGtfaTJw
NWdlX3BoeV9wcml2ICpwcml2ID0gcGh5ZGV2LT5wcml2Owo+ID4gwqDCoMKgwqDCoCB2b2lkIF9f
aW9tZW0gKm1jdV9jc3JfYmFzZSwgKnBtYl9hZGRyOwo+ID4gwqDCoMKgwqDCoCBzdHJ1Y3QgZGV2
aWNlICpkZXYgPSAmcGh5ZGV2LT5tZGlvLmRldjsKPiA+IMKgwqDCoMKgwqAgY29uc3Qgc3RydWN0
IGZpcm13YXJlICpmdzsKPiA+IMKgwqDCoMKgwqAgaW50IHJldCwgaTsKPiA+IMKgwqDCoMKgwqAg
dTMyIHJlZzsKPiA+IAo+ID4gwqDCoMKgwqDCoCBpZiAocHJpdi0+ZndfbG9hZGVkKQo+ID4gwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuIDA7Cj4gPiAKPiA+IMKgwqDCoMKgwqAgcG1i
X2FkZHIgPSBpb3JlbWFwKE1US18yUDVHUEhZX1BNQl9GV19CQVNFLAo+ID4gwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIE1UNzk4OF8yUDVHRV9QTUJfRldf
TEVOKTsKPiA+IMKgwqDCoMKgwqAgaWYgKCFwbWJfYWRkcikKPiA+IMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIHJldHVybiAtRU5PTUVNOwo+ID4gwqDCoMKgwqDCoCBtY3VfY3NyX2Jhc2UgPSBp
b3JlbWFwKE1US18yUDVHUEhZX01DVV9DU1JfQkFTRSwKPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIE1US18yUDVHUEhZX01DVV9DU1Jf
TEVOKTsKPiA+IMKgwqDCoMKgwqAgaWYgKCFtY3VfY3NyX2Jhc2UpIHsKPiA+IMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIHJldCA9IC1FTk9NRU07Cj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCBnb3RvIGZyZWVfcG1iOwo+ID4gwqDCoMKgwqDCoCB9Cj4gPiAuLi4KPiA+IGZyZWU6Cj4g
PiDCoMKgwqDCoMKgIGlvdW5tYXAobWN1X2Nzcl9iYXNlKTsKPiA+IGZyZWVfcG1iOgo+ID4gwqDC
oMKgwqDCoCBpb3VubWFwKHBtYl9hZGRyKTsKPiA+IC4uLgo+ID4gfQo+IAo+IFRoaXMgbG9va3Mg
Ty5LLiBJdCBpcyBiYXNpY2FsbHkgd2hhdCB3ZSBkaWQgYmVmb3JlIGRldmljZSB0cmVlIHdhcwo+
IHVzZWQuCj4gCj4gwqDCoMKgwqDCoMKgwqAgQW5kcmV3CgpPSy4gSSdsbCBzdWJtaXQgdjMgaW4g
dGhpcyB3YXkuCgpCUnMsClNreQo=

