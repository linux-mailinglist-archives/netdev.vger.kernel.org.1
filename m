Return-Path: <netdev+bounces-100480-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C91E08FADC8
	for <lists+netdev@lfdr.de>; Tue,  4 Jun 2024 10:43:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E60128134F
	for <lists+netdev@lfdr.de>; Tue,  4 Jun 2024 08:43:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D83C81428EF;
	Tue,  4 Jun 2024 08:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="P/dMdI3a";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="hYOZem4Q"
X-Original-To: netdev@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1C9A1420DA;
	Tue,  4 Jun 2024 08:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717490590; cv=fail; b=Os5Rs1naxNkvhy9BuK97ZC9uedzYAdPuAjPHk0/5YFDaUbItodm+HvnMNcNpWyiGVzfTafVXqlCcwSd3K3pAiXRrXCsd7LXDKm6smeVGC22+MCvbmga+sOtzCYFsIs2qOn7POD2x5BaXCmDGUF5Mdk9UWgQguGD2CMlQQOZVLrY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717490590; c=relaxed/simple;
	bh=8gHZX0XC4C6hu3pX92NHEPF+3mtEuHvVzuQSsTma+fY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=plbqD7IrPpwShOalxtnPHGFYpw4KlIrhzHe7i6It9ewswcWbj6mvOOILxnN8e/kUqSecxnurEPotvOIW3LYFEB4M2sul2YoPaviSg1urP6Jb9WkHmoP0RVeNsLyn0y1mehRKHJGJiDWJZdycf06zFfPBWDYSky/dkwhSlw9/Sis=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=P/dMdI3a; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=hYOZem4Q; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 7468079c224e11efbace61486a71fe2b-20240604
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=8gHZX0XC4C6hu3pX92NHEPF+3mtEuHvVzuQSsTma+fY=;
	b=P/dMdI3azApPzCSgnjWjt6Qtlzvewl7W0XGBVbsE+v2Ug2Jz3muMo1RRx6clZRfzeLWTFqt84ceNK2oBlRfr1MqQtR/OBHbDTMxeVYkTgztaLdr994Xhme28z2pqegfcM4lQ4xSXvkR/fGN7FAVzCvvg0HnaSsccp7WeUFwvvM0=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.39,REQID:a4c4ab75-a76b-4d69-a8d0-896e719a655d,IP:0,U
	RL:25,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:25
X-CID-META: VersionHash:393d96e,CLOUDID:06663188-8d4f-477b-89d2-1e3bdbef96d1,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 7468079c224e11efbace61486a71fe2b-20240604
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw01.mediatek.com
	(envelope-from <skylake.huang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 828284331; Tue, 04 Jun 2024 16:43:02 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 4 Jun 2024 16:43:01 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 4 Jun 2024 16:43:01 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ke2kl6/6w2wtfsS5H1cpNM5Zp9u8jl/lBso9SDC93s3CdReV7BbXZTfNy5vST1VOLzad+RVN2RZQ8UkJF4YzpaOrk2od2MwQNkxYO0LhAwphmDKTAjbPACc8aC3PWKmHP9XemwgdziM2dAog9QkefKXgnAlrHITT8yta5YD3f3V7nBsBVHKu9UIXAkCSD7v0ERdOTFH3CstRbnqTQXDa+5rZgQ4h7malAHM0vQ7T8/DQ2vq6BasmrgsWrjQxJGNXVMxgMSGWebAxTkdOWgStY34s09dHfSI+0s+1MdbyCcr/bOHcWDcfUSuPQCH15NND52Qaqf3aYvY4VCs4koCW6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8gHZX0XC4C6hu3pX92NHEPF+3mtEuHvVzuQSsTma+fY=;
 b=gr6QoK3U0kBsib59JsKFSmE2yW9SxuW9Mt9SfleX2kCRANA8w4KWmxAoJuK2pCC3wLzi7P1KinArwC5u13lqKqrZC/BXeMdW6Gh4GT6gjRWvnjYrlzGcSTYzJRXKsKrMUCbzCgq/GMj6H9Pz/u+/3E714QxGbRIz9CaciLbg2g7rKrVHil+p5Xe86Nv/HhT7ZL2nriw8BtsdewoY3SfjBvauC4Q1BXyuvrjv/dRiAPWUFOm4UcvNGzwxFNGV/XUbIFs/0nekBV+M/SsWftcTDefLFVMzhWZP+gjIMkMNUMXuXZwmQNt7+4LbxEkVIsgJ8kpVy2uM+LnutlLpQS6CzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8gHZX0XC4C6hu3pX92NHEPF+3mtEuHvVzuQSsTma+fY=;
 b=hYOZem4QLq8rtHVDWZ/KJhMgHVSRdnbrE3TcGMlPj9vMKUY99m2hyCeS+rjmmiVwZcm0jmL2n5q6BPnuq0amBWqqhStFc1KueKwMLK/NsLav6xNFzfMttK1zpFVTeZ3jFVtC6mBKUrYuIOmfeHtfKy4MHOabuAEjvcw0ChvRL2A=
Received: from KL1PR03MB6226.apcprd03.prod.outlook.com (2603:1096:820:8c::14)
 by TYSPR03MB8625.apcprd03.prod.outlook.com (2603:1096:405:83::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7656.7; Tue, 4 Jun
 2024 08:42:58 +0000
Received: from KL1PR03MB6226.apcprd03.prod.outlook.com
 ([fe80::f3:c11:8422:7ce3]) by KL1PR03MB6226.apcprd03.prod.outlook.com
 ([fe80::f3:c11:8422:7ce3%3]) with mapi id 15.20.7656.007; Tue, 4 Jun 2024
 08:42:57 +0000
From: =?utf-8?B?U2t5TGFrZSBIdWFuZyAo6buD5ZWf5r6kKQ==?=
	<SkyLake.Huang@mediatek.com>
To: "linux@armlinux.org.uk" <linux@armlinux.org.uk>, "daniel@makrotopia.org"
	<daniel@makrotopia.org>
CC: "andrew@lunn.ch" <andrew@lunn.ch>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-mediatek@lists.infradead.org"
	<linux-mediatek@lists.infradead.org>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "edumazet@google.com"
	<edumazet@google.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"dqfext@gmail.com" <dqfext@gmail.com>,
	=?utf-8?B?U3RldmVuIExpdSAo5YqJ5Lq66LGqKQ==?= <steven.liu@mediatek.com>,
	"matthias.bgg@gmail.com" <matthias.bgg@gmail.com>, "davem@davemloft.net"
	<davem@davemloft.net>, "hkallweit1@gmail.com" <hkallweit1@gmail.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	"angelogioacchino.delregno@collabora.com"
	<angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH net-next v6 5/5] net: phy: add driver for built-in 2.5G
 ethernet PHY on MT7988
Thread-Topic: [PATCH net-next v6 5/5] net: phy: add driver for built-in 2.5G
 ethernet PHY on MT7988
Thread-Index: AQHatbCSfQp9e/Gy/kieT40tWkycBLG2B36AgAAB4wCAAALJAIAAE7iAgAAPaQCAABR+gIAAGQMAgADuNYA=
Date: Tue, 4 Jun 2024 08:42:57 +0000
Message-ID: <864a09b213169bc20f33af2f35239c6154ca81e3.camel@mediatek.com>
References: <20240603121834.27433-1-SkyLake.Huang@mediatek.com>
	 <20240603121834.27433-6-SkyLake.Huang@mediatek.com>
	 <Zl3ELbG8c8y0/4DN@shell.armlinux.org.uk> <Zl3Fwoiv1bJlGaQZ@makrotopia.org>
	 <Zl3IGN5ZHCQfQfmt@shell.armlinux.org.uk> <Zl3Yo3dwQlXEfP3i@makrotopia.org>
	 <Zl3lkIDqnt4JD//u@shell.armlinux.org.uk> <Zl32waW34yTiuF9u@makrotopia.org>
	 <Zl4LvKlhty/9o38y@shell.armlinux.org.uk>
In-Reply-To: <Zl4LvKlhty/9o38y@shell.armlinux.org.uk>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR03MB6226:EE_|TYSPR03MB8625:EE_
x-ms-office365-filtering-correlation-id: fcb7cec1-7aa9-49c4-d2b3-08dc84725597
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|1800799015|366007|376005|7416005|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?L2UzZTZmZWhGWitkU0xiZ0dzU0xZZlJUc3dEeFB2R2I1dG5MQWhtbUJNZUF0?=
 =?utf-8?B?RVA4c2IvMFFxZ0hqN0pwUG9KZ0cvQ3B1TnZ5Ly81ZVRpMi9BMXlNd201WHVk?=
 =?utf-8?B?YzE1allKQ01FUEhvMFl5ekwzS3lQdUExOGpVRlR1Y1N4bUR1cElpZnplc1ln?=
 =?utf-8?B?Tm9lOThsZUVpYkZJcEdLSSs3U1REOUhaV25takg4TUhkRUk4bUhvNWhaRFpO?=
 =?utf-8?B?UExpaENDWWFpMUkybGlHU1RFL1dSd2xycjJBWXhYRk9aUmJ6VTBFMTByRWFw?=
 =?utf-8?B?UUQrT28rYnlDd2RDbkMwY3d5Y0NWNVVqb2w4QVlEbmxzdzBXdHhwRnA1clc2?=
 =?utf-8?B?MERzeGNuSWZWc0ZxbllEOWxvckVtak9OQ1Q3YzdxNkxQRHVpZ2xHT29UR0ZB?=
 =?utf-8?B?MUlqNWtvNU1abUFleUlNbmk0RG1Fc240bXhEQTl3MGdJV1VNV2RwQy9MUzYz?=
 =?utf-8?B?QlZoZ0xwV25WWktKTHdIaXp0ZHg5aUVEUXRCZTRMTERVVEpVNnBHTEtOemtH?=
 =?utf-8?B?SFViV0M5Vnhnb2pxcFA4V1Z6dHd0SVhIT2lJbkgrblhWRjFYRG1OcEVVWm1B?=
 =?utf-8?B?cWY0MndCK01qT3hJa2lWQTZMTlJjSHdqUUdPeVVxbnJYeGZrSkJFU2NoeUxo?=
 =?utf-8?B?aUlRb2VveUNZdnR5MzJDSlloRFVhUGNRZ0ZFRU02V1YzYTc5RUNBTEhRTjh3?=
 =?utf-8?B?VzYzSUdQdlBHSHJFWWhYYVdWUFRvTmdybEJPNm5jK3dzS1NTNDJxWi8vKzJQ?=
 =?utf-8?B?L0JtVk13bHVtbkJXa0plTUZCVVNXT3hoT2ZaeVE4WE1pdm1FN2EzMjhzc1ov?=
 =?utf-8?B?S0U3NXBXS2Viem1MVXZzNzNxbDc3VG91aTJJcGxjc0JjWmdWbVRPSGxPaVRi?=
 =?utf-8?B?bHVvUmc1UXdGbGgzSmYwNmxvQ29KVkduU1NIREpyQjl4eFRDQWFIRnRNTXEw?=
 =?utf-8?B?Zk15eDg3N0tBOHM1VjZ5ZW5qekdvOTJWdUhuMWFvRW5pL1JxUU13bHRjNDUz?=
 =?utf-8?B?MjB2bi8vMHlJMDI3a2J3S2ZORWhtd2hkcmJKUDEvR0lPQVRDMGJ4bHBFMlRW?=
 =?utf-8?B?eG5RVEJkVVdKOFRlUVhtN0lBeElvYjhpRUdvTVQ1M2hNQ054ZG03MEhqSXJj?=
 =?utf-8?B?WnlEVmZRakhuYkoxRGxOSi93NWFEZmp6ZEF5K0hwRWZEWFJWRUIrbGJPS2dX?=
 =?utf-8?B?WWp2allhWVdHcWxDZE1KZ2oxdWJHL2F4eHM2WlUzOGN1SjFNSDY2ek1ic0NB?=
 =?utf-8?B?Mnp1VHhDQzBwaHBYamxpVHpMcDU1ZG56VXNKNUZvRHpSbzVEdHRtMEMzSFUx?=
 =?utf-8?B?T1BMK0QySU5qNFp5V25WZ1NyN25xZzhOUENVSFhoMVlnOU14RDkwZjdlaGc3?=
 =?utf-8?B?WlVtYytpV1NpUldwbWVqQ3BJU1I3dmMxYmYwRG5IRDl6VjJVVXc1SDVzVXJ6?=
 =?utf-8?B?dHEyL1dSaVExUGZkVWltRnpzVFBaei8zQlBpb0lsUWpOc0xmQ2hNenRLU3VI?=
 =?utf-8?B?TXJ2VWE1ZytNc2hBY3oxM3Q3RVYzVnBSU3VYQlVDMHJ5SDQwR3Q4K005Tmoy?=
 =?utf-8?B?NnU3RWFmam1LTjZNKzhqZW9mNTZJNkcreDUwc09ZblpJWEhKTlNxcnQ3RnhL?=
 =?utf-8?B?UkRzZHdjVnMzZUp2TW9DZTBrMXd4VXNNeU95LzUrZFFQWjIySURqN3YxNjZa?=
 =?utf-8?B?NnVacGJJU1RtdGJDY2FmcFN0QXVicmV3TzREVmszNEtWN2JZaWNlMDFTR2J6?=
 =?utf-8?Q?UGBkhaddpF2N86Oxw0ISdsLfQBqiWFlratTt69v?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR03MB6226.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005)(7416005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aW1MY3Btbm9Xdzl5ZHQ0WUFzOWdiU01iNVV4M3pzdFdZTXpQRXd2TXRKZzdx?=
 =?utf-8?B?Tk92NEtHaExWZnZYcmpvLy9QTUUxdEdaeXNlNHdaNjJZVzZ5MENrSnNWRVlB?=
 =?utf-8?B?VjliN2NVcW9nYmdPL212a1lRUVFjZ1lteGJxeFpudXVrVDFtYldOcFlLTFli?=
 =?utf-8?B?Ly9mNWtRTjlTN1lsZEhYYVJ5RzRhYlZCeHlvSS9peVZKK2pKNi8xdGhBeGk2?=
 =?utf-8?B?NXdZWlNoZEgwL1NVYTNXem5Jb2tUSnZJaUZZeE00WlFQME5jYWZxTS85a292?=
 =?utf-8?B?UmhGM1JMTSt4elNuZytsQXdBSTJJek1BaUxWUm51UFZ6bCtYS05zZzFORmFG?=
 =?utf-8?B?MTg1UldBc1pWWlR5UStOdWpBOEw5ckJTVlJDdlBUUlR1S2hpd0R1NGVQeDRX?=
 =?utf-8?B?bm5uK3k0dmRzRnkwaW8wTmpOUXhxV21WODFmeUhmalR2UGtHT0xSaWNBWkNl?=
 =?utf-8?B?MUtPTlhubTVHa3pxZnVDOGdPSCtQLy9QckdZcnlvdGpmRGRKUTBkT1JBV0U1?=
 =?utf-8?B?SDczYXR5Tk85WXNsY3FqeEdBWEM2S3NxYU5Sdk9uZXB0RUM2RVhCQkphUmJ0?=
 =?utf-8?B?S3dIN1czSXBIMEV3aWJ5L3JoeTNKNlFuclFzRnV5REluTHdRU1hzY2EwQXlS?=
 =?utf-8?B?ZnBoR3Ruc0J3R21hN09rSVdoZXZUS3pmU3pDcXFnbERuOVFhRUFTRm5JWHVn?=
 =?utf-8?B?QSt6eE11MlFSUmRwVE9SejM0UkN4VXFzR084b1l0UUlvZnF3ZlBKK3YyaHNq?=
 =?utf-8?B?UUZTNVVoV2svVVJIcWs1QXEyVHU5Vm94OFZ6NHBrYUg4Znp2Um5ZYi8vTHRi?=
 =?utf-8?B?TFFBeTB6aVByRjM4TU9rTGt1VmVvWEw4cndkYjQ2MzQrR1JqMlg4WGJDckF6?=
 =?utf-8?B?OTJSZUN6eDdRVWtWRXBScndqUXBBTzI3SUNlQ1E2NXErTHVmQjRsNjZ6Qm5G?=
 =?utf-8?B?TEpZVUY3RHBwZjhNNUsxMDFuQjA2SjQwS3dtd0ZqZ3RZdHgyU21FZlBaNDlY?=
 =?utf-8?B?QmlXdkwyVmM0VTZadDNBZ3ZsZnd5dHRhTzJkcUhWKzBhOVFyekdWZGZjdndQ?=
 =?utf-8?B?TVNQRDhwL1lHNGVtWWt4MGZCWE1sSjJGdkRibG96Z1RzOGsxNzBVaXZKRFFG?=
 =?utf-8?B?Q1lLdHFHeDd5dko1NGIydHJPQ1REK1VDZE5JSHhVZ2YreHNMc2xNM1N6d2M1?=
 =?utf-8?B?bVdTSW5qZk9XV0lLQnF1NFlJQWg3bkt5YnZWcm1WWHdKODZRNlhoOTlrbThP?=
 =?utf-8?B?U3ZwbS9PSmxpOUs5Mnd3dWx3Ukt1YkxhdDJ5M2c4NmdQMWpqQ0RKclhoOVBO?=
 =?utf-8?B?bHROa0VVQ0kxZUVWbG9ZNmY2U1N5eStoT0dPcEcvRkd2YTZKK2hOV2V4UEd4?=
 =?utf-8?B?TEpBYzN1TlhRdnBjWmM0dzQ2T2lkSlBuOUdlWUo4Z0YzUGJUV1RodGE4aUx1?=
 =?utf-8?B?ejlZU3dMZ1duSzZlbFlkeHJQRWxEKzFtRGUwWlROY2t1TkhZalFhcjFkd052?=
 =?utf-8?B?YTBHVjR3cHZFZ096STFGUEJIQ3EzdWJzUWFSSjhhY01rTTBLNWF0elplYnhU?=
 =?utf-8?B?djdRMU5aTS9FVTBKM25ZSy9DR1puYTIwVExUbmVCWTNZTkN2YWxHRGpubXhp?=
 =?utf-8?B?R1FkaFdDamhGTWtnQkcrUXNpbCtRdlVwOWgxeHVZeVprMU9iempId3hkZXJH?=
 =?utf-8?B?OGxkSkpmbVFkaisxRWV3N2xLdlVseE5qbnhiOGFIWmJaRE9adEd2V0hWTVpU?=
 =?utf-8?B?NGtXRzc5TkVrZHE4RXh4bUlWMHMvaStsQXpaMjk4VmpsODRpMDVkWlJld25J?=
 =?utf-8?B?WWZwV1VGdUtjd3lXNVZUeGxGcTlkMk5FQkNOWFhLbzJ4RExOakR2aGlySDhW?=
 =?utf-8?B?ZStjdnBuUC9oRy9vN1l3eStFUXRmRVdUd3B1STRZeHJiQjBvYjl2alYwRnph?=
 =?utf-8?B?cmlyTXdNZ2g5ZFg0eDFobThLVmFNdDNQeWI4c29TTEJlaFQ1SVFuY1F4ZG9K?=
 =?utf-8?B?UDRMdXRsdldNUE9iVFZHeTZRU2Z2MW1hdWpYMlN1dkhUM2dxbzZpazFLVHdS?=
 =?utf-8?B?TWduTU5TQmpRYWx0anRDRlB4UG5PVFBjRkZmYlJ0eHQxNlJibXNVMGxBNDBN?=
 =?utf-8?B?YUZJYmt6QXRjVUgzZzhWQVhzZTQ5N2M5c1RLQ2FleTB2MW96eThzVFcyTTdQ?=
 =?utf-8?B?SVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7811992C9A006F41A5F3CAF85BB070B0@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR03MB6226.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fcb7cec1-7aa9-49c4-d2b3-08dc84725597
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jun 2024 08:42:57.6397
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bEkTUnWSc/7/jGAcXMMgauNTfuCKygL/JqE8b388XbNCymr67027a8BoeP3hicQ6iV0j7ejniiG676npRMqeQpJbbtq4O51DeNc4spMbeQk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR03MB8625

T24gTW9uLCAyMDI0LTA2LTAzIGF0IDE5OjMwICswMTAwLCBSdXNzZWxsIEtpbmcgKE9yYWNsZSkg
d3JvdGU6DQo+ICAJIA0KPiBFeHRlcm5hbCBlbWFpbCA6IFBsZWFzZSBkbyBub3QgY2xpY2sgbGlu
a3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bnRpbA0KPiB5b3UgaGF2ZSB2ZXJpZmllZCB0aGUgc2Vu
ZGVyIG9yIHRoZSBjb250ZW50Lg0KPiAgT24gTW9uLCBKdW4gMDMsIDIwMjQgYXQgMDY6MDA6NDlQ
TSArMDEwMCwgRGFuaWVsIEdvbGxlIHdyb3RlOg0KPiA+IE9uIE1vbiwgSnVuIDAzLCAyMDI0IGF0
IDA0OjQ3OjI4UE0gKzAxMDAsIFJ1c3NlbGwgS2luZyAoT3JhY2xlKQ0KPiB3cm90ZToNCj4gPiA+
IE9uIE1vbiwgSnVuIDAzLCAyMDI0IGF0IDAzOjUyOjE5UE0gKzAxMDAsIERhbmllbCBHb2xsZSB3
cm90ZToNCj4gPiA+ID4gT24gTW9uLCBKdW4gMDMsIDIwMjQgYXQgMDI6NDE6NDRQTSArMDEwMCwg
UnVzc2VsbCBLaW5nIChPcmFjbGUpDQo+IHdyb3RlOg0KPiA+ID4gPiA+IE9uIE1vbiwgSnVuIDAz
LCAyMDI0IGF0IDAyOjMxOjQ2UE0gKzAxMDAsIERhbmllbCBHb2xsZSB3cm90ZToNCj4gPiA+ID4g
PiA+IE9uIE1vbiwgSnVuIDAzLCAyMDI0IGF0IDAyOjI1OjAxUE0gKzAxMDAsIFJ1c3NlbGwgS2lu
Zw0KPiAoT3JhY2xlKSB3cm90ZToNCj4gPiA+ID4gPiA+ID4gT24gTW9uLCBKdW4gMDMsIDIwMjQg
YXQgMDg6MTg6MzRQTSArMDgwMCwgU2t5IEh1YW5nDQo+IHdyb3RlOg0KPiA+ID4gPiA+ID4gPiA+
IEFkZCBzdXBwb3J0IGZvciBpbnRlcm5hbCAyLjVHcGh5IG9uIE1UNzk4OC4gVGhpcyBkcml2ZXIN
Cj4gd2lsbCBsb2FkDQo+ID4gPiA+ID4gPiA+ID4gbmVjZXNzYXJ5IGZpcm13YXJlLCBhZGQgYXBw
cm9wcmlhdGUgdGltZSBkZWxheSBhbmQNCj4gZmlndXJlIG91dCBMRUQuDQo+ID4gPiA+ID4gPiA+
ID4gQWxzbywgY2VydGFpbiBjb250cm9sIHJlZ2lzdGVycyB3aWxsIGJlIHNldCB0byBmaXgNCj4g
bGluay11cCBpc3N1ZXMuDQo+ID4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gPiBCYXNlZCBvbiBv
dXIgcHJldmlvdXMgZGlzY3Vzc2lvbiwgaXQgbWF5IGJlIHdvcnRoDQo+IGNoZWNraW5nIGluIHRo
ZQ0KPiA+ID4gPiA+ID4gPiAuY29uZmlnX2luaXQoKSBtZXRob2Qgd2hldGhlciBwaHlkZXYtPmlu
dGVyZmFjZSBpcyBvbmUgb2YNCj4gdGhlDQo+ID4gPiA+ID4gPiA+IFBIWSBpbnRlcmZhY2UgbW9k
ZXMgdGhhdCB0aGlzIFBIWSBzdXBwb3J0cy4gQXMgSQ0KPiB1bmRlcnN0YW5kIGZyb20gb25lDQo+
ID4gPiA+ID4gPiA+IG9mIHlvdXIgcHJldmlvdXMgZW1haWxzLCB0aGUgcG9zc2liaWxpdGllcyBh
cmUgWEdNSUksDQo+IFVTWEdNSUkgb3INCj4gPiA+ID4gPiA+ID4gSU5URVJOQUwuIFRodXM6DQo+
ID4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gPiA+ICtzdGF0aWMgaW50IG10Nzk4eF8ycDVnZV9w
aHlfY29uZmlnX2luaXQoc3RydWN0DQo+IHBoeV9kZXZpY2UgKnBoeWRldikNCj4gPiA+ID4gPiA+
ID4gPiArew0KPiA+ID4gPiA+ID4gPiA+ICtzdHJ1Y3QgcGluY3RybCAqcGluY3RybDsNCj4gPiA+
ID4gPiA+ID4gPiAraW50IHJldDsNCj4gPiA+ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiA+IC8qIENo
ZWNrIHRoYXQgdGhlIFBIWSBpbnRlcmZhY2UgdHlwZSBpcyBjb21wYXRpYmxlICovDQo+ID4gPiA+
ID4gPiA+IGlmIChwaHlkZXYtPmludGVyZmFjZSAhPSBQSFlfSU5URVJGQUNFX01PREVfSU5URVJO
QUwgJiYNCj4gPiA+ID4gPiA+ID4gICAgIHBoeWRldi0+aW50ZXJmYWNlICE9IFBIWV9JTlRFUkZB
Q0VfTU9ERV9YR01JSSAmJg0KPiA+ID4gPiA+ID4gPiAgICAgcGh5ZGV2LT5pbnRlcmZhY2UgIT0g
UEhZX0lOVEVSRkFDRV9NT0RFX1VTWEdNSUkpDQo+ID4gPiA+ID4gPiA+IHJldHVybiAtRU5PREVW
Ow0KPiA+ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiBUaGUgUEhZIGlzIGJ1aWx0LWludG8gdGhlIFNv
QywgYW5kIGFzIHN1Y2ggdGhlIGNvbm5lY3Rpb24NCj4gdHlwZSBzaG91bGQNCj4gPiA+ID4gPiA+
IGFsd2F5cyBiZSAiaW50ZXJuYWwiLiBUaGUgUEhZIGRvZXMgbm90IGV4aXN0IGFzIGRlZGljYXRl
ZA0KPiBJQywgb25seQ0KPiA+ID4gPiA+ID4gYXMgYnVpbHQtaW4gcGFydCBvZiB0aGUgTVQ3OTg4
IFNvQy4NCj4gPiA+ID4gPiANCj4gPiA+ID4gPiBUaGF0J3Mgbm90IGhvdyBpdCB3YXMgZGVzY3Jp
YmVkIHRvIG1lIGJ5IFNreS4NCj4gPiA+ID4gPiANCj4gPiA+ID4gPiBJZiB3aGF0IHlvdSBzYXkg
aXMgY29ycmVjdCwgdGhlbiB0aGUgaW1wbGVtZW50YXRpb24gb2YNCj4gPiA+ID4gPiBtdDc5OHhf
MnA1Z2VfcGh5X2dldF9yYXRlX21hdGNoaW5nKCkgd2hpY2ggY2hlY2tzIGZvcg0KPiBpbnRlcmZh
Y2UgbW9kZXMNCj4gPiA+ID4gPiBvdGhlciB0aGFuIElOVEVSTkFMIGlzIG5vdCBjb3JyZWN0LiBB
bHNvIGl0IG1lYW5zIHRoYXQNCj4gY29uZmlnX2luaXQoKQ0KPiA+ID4gPiA+IHNob3VsZCBub3Qg
cGVybWl0IGFueXRoaW5nIGJ1dCBJTlRFUk5BTC4NCj4gPiA+ID4gDQo+ID4gPiA+IFRoZSB3YXkg
dGhlIFBIWSBpcyBjb25uZWN0ZWQgdG8gdGhlIE1BQyAqaW5zaWRlIHRoZSBjaGlwKiBpcw0KPiBY
R01JSQ0KPiA+ID4gPiBhY2NvcmRpbmcgdGhlIE1lZGlhVGVrLiBTbyBjYWxsIGl0ICJpbnRlcm5h
bCIgb3IgInhnbWlpIiwNCj4gaG93ZXZlciwgdXAgdG8NCj4gPiA+ID4gbXkga25vd2xlZGdlIGl0
J3MgYSBmYWN0IHRoYXQgdGhlcmUgaXMgKipvbmx5IG9uZSB3YXkqKiB0aGlzDQo+IFBIWSBpcw0K
PiA+ID4gPiBjb25uZWN0ZWQgYW5kIHVzZWQsIGFuZCB0aGF0IGlzIGJlaW5nIGFuIGludGVybmFs
IHBhcnQgb2YgdGhlDQo+IE1UNzk4OCBTb0MuDQo+ID4gPiA+IA0KPiA+ID4gPiBJbWhvLCBhcyB0
aGVyZSBhcmUgbm8gYWN0dWFsIFhHTUlJIHNpZ25hbHMgZXhwb3NlZCBhbnl3aGVyZSBJJ2QNCj4g
dXNlDQo+ID4gPiA+ICJpbnRlcm5hbCIgdG8gZGVzY3JpYmUgdGhlIGxpbmsgYmV0d2VlbiBNQUMg
YW5kIFBIWSAod2hpY2ggYXJlDQo+IGJvdGgNCj4gPiA+ID4gaW5zaWRlIHRoZSBzYW1lIGNoaXAg
cGFja2FnZSkuDQo+ID4gPiANCj4gPiA+IEkgZG9uJ3QgY2FyZSB3aGF0IGdldHMgZGVjaWRlZCBh
Ym91dCB3aGF0J3MgYWNjZXB0YWJsZSBmb3IgdGhlDQo+IFBIWSB0bw0KPiA+ID4gYWNjZXB0LCBq
dXN0IHRoYXQgaXQgY2hlY2tzIGZvciB0aGUgYWNjZXB0YWJsZSBtb2RlcyBpbg0KPiAuY29uZmln
X2luaXQoKQ0KPiA+ID4gYW5kIHRoZSAuZ2V0X3JhdGVfbWF0Y2hpbmcoKSBtZXRob2QgaXMgbm90
IGNoZWNraW5nIGZvciBpbnRlcmZhY2UNCj4gPiA+IG1vZGVzIHRoYXQgYXJlIG5vdCBwZXJtaXR0
ZWQuDQo+ID4gDQo+ID4gV2hhdCBJIG1lYW50IHRvIGV4cHJlc3MgaXMgdGhhdCB0aGVyZSBpcyBu
byBuZWVkIGZvciBzdWNoIGEgY2hlY2ssDQo+IGFsc28NCj4gPiBub3QgaW4gY29uZmlnX2luaXQu
IFRoZXJlIGlzIG9ubHkgb25lIHdheSBhbmQgb25lIE1BQy1zaWRlDQo+IGludGVyZmFjZSBtb2Rl
DQo+ID4gdG8gb3BlcmF0ZSB0aGF0IFBIWSwgc28gdGhlIHZhbHVlIHdpbGwgYW55d2F5IG5vdCBi
ZSBjb25zaWRlcmVkDQo+IGFueXdoZXJlDQo+ID4gaW4gdGhlIGRyaXZlci4NCj4gDQo+IE5vLCBp
dCBtYXR0ZXJzLiBXaXRoIGRyaXZlcnMgdXNpbmcgcGh5bGluaywgdGhlIFBIWSBpbnRlcmZhY2Ug
bW9kZSBpcw0KPiB1c2VkIGluIGNlcnRhaW4gY2lyY3Vtc3RhbmNlcyB0byBjb25zdHJhaW4gd2hh
dCB0aGUgbmV0IGRldmljZSBjYW4NCj4gZG8uDQo+IFNvLCBpdCBtYWtlcyBzZW5zZSBmb3IgbmV3
IFBIWSBkcml2ZXJzIHRvIGVuc3VyZSB0aGF0IHRoZSBQSFkNCj4gaW50ZXJmYWNlDQo+IG1vZGUg
aXMgb25lIHRoYXQgdGhleSBjYW4gc3VwcG9ydCwgcmF0aGVyIHRoYW4ganVzdCBhY2NlcHRpbmcN
Cj4gd2hhdGV2ZXINCj4gaXMgcGFzc2VkIHRvIHRoZW0gKHdoaWNoIHRoZW4gY2FuIGxlYWQgdG8g
bWFpbnRhaW5hYmlsaXR5IGlzc3VlcyBmb3INCj4gc3Vic3lzdGVtcy4pDQo+IA0KPiBTbywgZXhj
dXNlIG1lIGZvciBkaXNhZ3JlZWluZyB3aXRoIHlvdSwgYnV0IEkgZG8gd2FudCB0byBzZWUgc3Vj
aCBhDQo+IGNoZWNrIGluIG5ldyBQSFkgZHJpdmVycy4NCj4gDQo+IC0tIA0KPiBSTUsncyBQYXRj
aCBzeXN0ZW06IGh0dHBzOi8vd3d3LmFybWxpbnV4Lm9yZy51ay9kZXZlbG9wZXIvcGF0Y2hlcy8N
Cj4gRlRUUCBpcyBoZXJlISA4ME1icHMgZG93biAxME1icHMgdXAuIERlY2VudCBjb25uZWN0aXZp
dHkgYXQgbGFzdCENCg0KSGkgUnVzc2VsbC9EYW5pZWwsDQogIElNTywgd2UgY2FuIGNoZWNrIFBI
WV9JTlRFUkZBQ0VfTU9ERV9JTlRFUk5BTCAmDQpQSFlfSU5URVJGQUNFX01PREVfWEdNSUkgaW4g
Y29uZmlnX2luaXQoKSBvciBwcm9iZSgpLiBIb3dldmVyLA0KUEhZX0lOVEVSRkFDRV9NT0RFX1VT
WEdNSUkgaXNuJ3Qgc3VwcG9ydGVkIGJ5IHRoaXMgcGh5LCBhbmQNCmRyaXZlcnMvbmV0L2V0aGVy
bmV0L21lZGlhdGVrL210a19ldGhfcGF0aC5jIHVzZXMNClBIWV9JTlRFUkZBQ0VfTU9ERV9VU1hH
TUlJIHRvIHN3aXRjaCBuZXRzeXMgcGNzIG11eCAoc2V0DQpNVVhfRzJfVVNYR01JSV9TRUwgYml0
IGluIFRPUF9NSVNDX05FVFNZU19QQ1NfTVVYKSBzbyB0aGF0IFhGSS1NQUMgY2FuDQpiZSBjb25u
ZWN0ZWQgdG8gZXh0ZXJuYWwgMTBHcGh5Lg0KICBTbywgYmFzaWNhbGx5LCBmb3IgMXN0IFhGSS1N
QUMgb24gbXQ3OTg4Og0KLSBQSFlfSU5URVJGQUNFX01PREVfWEdNSUkvUEhZX0lOVEVSRkFDRV9N
T0RFX0lOVEVSTkFMOiBidWlsdC1pbg0KMi41R3BoeQ0KLSBQSFlfSU5URVJGQUNFX01PREVfVVNY
R01JSTogZXh0ZXJuYWwgMTBHcGh5DQoNCiAgSSBhZGQgY2hlY2sgaW4gY29uZmlnX2luaXQoKToN
Ci8qIENoZWNrIGlmIFBIWSBpbnRlcmZhY2UgdHlwZSBpcyBjb21wYXRpYmxlICovDQppZiAocGh5
ZGV2LT5pbnRlcmZhY2UgIT0gUEhZX0lOVEVSRkFDRV9NT0RFX1hHTUlJICYmDQogICAgcGh5ZGV2
LT5pbnRlcmZhY2UgIT0gUEhZX0lOVEVSRkFDRV9NT0RFX0lOVEVSTkFMKQ0KCXJldHVybiAtRU5P
REVWOw0KDQogIEFsc28sIHRlc3Qgd2l0aCBkaWZmZXJlbnQgcGh5IG1vZGUgaW4gZHRzOg0KW1BI
WV9JTlRFUkZBQ0VfTU9ERV9VU1hHTUlJXQ0KWyAgIDE4LjcwMjEwMl0gbXRrX3NvY19ldGggMTUx
MDAwMDAuZXRoZXJuZXQgZXRoMTogbXRrX29wZW46IGNvdWxkIG5vdA0KYXR0YWNoIFBIWTogLTE5
DQpyb290QE9wZW5XcnQ6LyMgY2F0IC9wcm9jL2RldmljZS10cmVlL3NvYy9ldGhlcm5ldEAxNTEw
MDAwMC9tYWNAMS9waHktYw0Kb25uZWN0aW9uLXR5cGUNCnVzeGdtaWkNCg0KW1BIWV9JTlRFUkZB
Q0VfTU9ERV9JTlRFUk5BTF0NClsgICAxOC4zMjk1MTNdIG10a19zb2NfZXRoIDE1MTAwMDAwLmV0
aGVybmV0IGV0aDE6IFBIWSBbbWRpby1idXM6MGZdDQpkcml2ZXIgW01lZGlhVGVrIE1UNzk4OCAy
LjVHYkUgUEhZXSAoaXJxPVBPTEwpDQpbICAgMTguMzM5NzA4XSBtdGtfc29jX2V0aCAxNTEwMDAw
MC5ldGhlcm5ldCBldGgxOiBjb25maWd1cmluZyBmb3INCnBoeS9pbnRlcm5hbCBsaW5rIG1vZGUN
CnJvb3RAT3BlbldydDovIyBjYXQgL3Byb2MvZGV2aWNlLXRyZWUvc29jL2V0aGVybmV0QDE1MTAw
MDAwDQovbWFjQDEvcGh5LWNvbm5lY3Rpb24tdHlwZQ0KaW50ZXJuYWwNCg0KU2t5DQo=

