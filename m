Return-Path: <netdev+bounces-104781-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 54D1390E55F
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 10:18:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A4E16B22AC5
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 08:18:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEA4D78C83;
	Wed, 19 Jun 2024 08:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="MfhnFlyG";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="HlZG2eJx"
X-Original-To: netdev@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B4F877F2C;
	Wed, 19 Jun 2024 08:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718785089; cv=fail; b=vBZZW5pgUREwOjNXd/+bhiHbxJ1P3XhK8JK9V/gnYWD4YR0FMJWa/D6zmd7wScUjlPNM4d6R5AWuJIVDQJbEjuhWZJbHUSYhYRhk3d9mMv3LDT5U1Mr/+hnXkT+BzmTkX2K+c6EFR4G7YCMweXz0n0BLx0XjrqviMyC2t2uzImE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718785089; c=relaxed/simple;
	bh=WLbAaHrclNgEqVqSIQy8HzFaFB0DZyWJ0R9RK20LwPM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hJ+taz7ypPRrV5NYXb9ZUm9tlowEkZwNIApnrxWVrULRhLCFqwT7b1wQpkOXnnPOoorhBtq/pk2DWsv3tXlM8ZLGbP6iYDO/lAOi5SN2/NlhbYBMTvm77fQ7ex0seGlRGjzxk94I7u3eMIwazwz4zY9pQqVK0GD+WjEzbCvyyeY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=MfhnFlyG; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=HlZG2eJx; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 728217522e1411efa54bbfbb386b949c-20240619
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=WLbAaHrclNgEqVqSIQy8HzFaFB0DZyWJ0R9RK20LwPM=;
	b=MfhnFlyG6w1VsoC2hZyWcbQw2tcu5zXNBNh5oepmPKgjlLl90ux5oOuOoao7eQeKFa/mv5A2NS6iPfNpzJjn2MaLwL/NPifyQONQazGImYG+pdbC8Fivq5VbASR+CvePKS0+WC9cgxsTadG4+3ldTunPUebQMLljFZ+QwnWFlwA=;
X-CID-CACHE: Type:Local,Time:202406191613+08,HitQuantity:2
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.39,REQID:6ca16a3f-94c9-444f-b373-da04a15e3c52,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:393d96e,CLOUDID:d912c344-4544-4d06-b2b2-d7e12813c598,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-UUID: 728217522e1411efa54bbfbb386b949c-20240619
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
	(envelope-from <skylake.huang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 540562854; Wed, 19 Jun 2024 16:18:02 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 MTKMBS09N1.mediatek.inc (172.21.101.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 19 Jun 2024 16:18:01 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 19 Jun 2024 16:18:01 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QCCCF70kCmB9sJ0oFWBef3SjRwIGPV0FX7luEGNhEr/aaOyYJKeUAu+HyW4bpv7CT/GQ9Nb83zRIUjuXhG0h6zwLbZjdW0jEynBdtMpLswn8k3jVepCbE+vuGJ2XVd8gU2hpOSXw275R6hxXuC/bFE9B0urSBBwm5voH6oz0PcnJEPDOEc8ypjmjJL9fEmz3ANWaA0D2FL2JTwMMehU1Ah1rCtccZNrmLRnHxYM4pCpcQ43sMe1j0SwcSGsa49xw4hueFZ8gz7p3tBLadIhz10OXAR2dEX/oKVPELbu/pJ0rRDGS8mNUB7IEp1tQoNsmIbhHEeiVLb9xCWA7Eg7tLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WLbAaHrclNgEqVqSIQy8HzFaFB0DZyWJ0R9RK20LwPM=;
 b=EZ12NVwteRI9gQ1HVxvnuIKa9pJjaehIC3PA1AlRYqOnyRC37HoTKCs/jG6A+BANXtbRUUc5AtR1GCpOHNO3mLvk8InwlGYv5a9h63vMHBhODCSx6fjVrH7+oScQ5SIb6Y6bDPKJah7L22VxqoV1cTt6DrCpLi0o+VTXG/XzK49z5gYucTYzePS5icF/gAEdEYnuoP6nMGNx/KdLWIJEjm5JYqS74OaWJsuRKHnhYtZhELFiuj1hUOi5B0bmV+K9YYSAm2T1ote9YV02vtYg8DRBuhqWEegBM1FeXyKHhgyIR+yBLsd4G2CGwzJoUfRMXJ067/ee8/L7s/qGlqK8xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WLbAaHrclNgEqVqSIQy8HzFaFB0DZyWJ0R9RK20LwPM=;
 b=HlZG2eJxluSnKOozkAlgJSg4A5kbWkHphVjAOL4ThAojLxoFwf5L07CgQdW+sthWbcRR0oR39x9+UQQMuXUk4goJLS/3lVYYcZqCcmQYtUF4PPp9pVNdH9Vr1UrTvRzDg4kZCYmbrsSfe1n3yNE0vYUiCGuoMKnWel5LL89CfSY=
Received: from KL1PR03MB6226.apcprd03.prod.outlook.com (2603:1096:820:8c::14)
 by SEZPR03MB8738.apcprd03.prod.outlook.com (2603:1096:101:215::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Wed, 19 Jun
 2024 08:17:58 +0000
Received: from KL1PR03MB6226.apcprd03.prod.outlook.com
 ([fe80::f3:c11:8422:7ce3]) by KL1PR03MB6226.apcprd03.prod.outlook.com
 ([fe80::f3:c11:8422:7ce3%5]) with mapi id 15.20.7677.030; Wed, 19 Jun 2024
 08:17:56 +0000
From: =?utf-8?B?U2t5TGFrZSBIdWFuZyAo6buD5ZWf5r6kKQ==?=
	<SkyLake.Huang@mediatek.com>
To: "kuba@kernel.org" <kuba@kernel.org>
CC: "andrew@lunn.ch" <andrew@lunn.ch>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-mediatek@lists.infradead.org"
	<linux-mediatek@lists.infradead.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux@armlinux.org.uk"
	<linux@armlinux.org.uk>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"edumazet@google.com" <edumazet@google.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "dqfext@gmail.com" <dqfext@gmail.com>,
	=?utf-8?B?U3RldmVuIExpdSAo5YqJ5Lq66LGqKQ==?= <steven.liu@mediatek.com>,
	"matthias.bgg@gmail.com" <matthias.bgg@gmail.com>, "davem@davemloft.net"
	<davem@davemloft.net>, "hkallweit1@gmail.com" <hkallweit1@gmail.com>,
	"daniel@makrotopia.org" <daniel@makrotopia.org>,
	"angelogioacchino.delregno@collabora.com"
	<angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH net-next v7 2/5] net: phy: mediatek: Move LED and
 read/write page helper functions into mtk phy lib
Thread-Topic: [PATCH net-next v7 2/5] net: phy: mediatek: Move LED and
 read/write page helper functions into mtk phy lib
Thread-Index: AQHavX543grjkC4X80W7mzpSDXaiMLHNq0+AgAEcEgA=
Date: Wed, 19 Jun 2024 08:17:56 +0000
Message-ID: <680c25911c9a564960a371870bdaf59aa9d3b991.camel@mediatek.com>
References: <20240613104023.13044-1-SkyLake.Huang@mediatek.com>
	 <20240613104023.13044-3-SkyLake.Huang@mediatek.com>
	 <20240618082111.27d386b6@kernel.org>
In-Reply-To: <20240618082111.27d386b6@kernel.org>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR03MB6226:EE_|SEZPR03MB8738:EE_
x-ms-office365-filtering-correlation-id: 15706a2c-86ea-4a74-add1-08dc9038533e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230037|366013|7416011|376011|1800799021|38070700015;
x-microsoft-antispam-message-info: =?utf-8?B?cFFtYnBMUk1tM05VMFBxWHExM3AzZCtLdWZiV3FFSGMzN3JHdU5nNjZOY1cz?=
 =?utf-8?B?Y3VNc3huZVdPMnZVUDlzRTlmTXZOaWx0a2cyeVVuTlhwU2ttNTFoSDdSd0dQ?=
 =?utf-8?B?d2tmWjcweENidmpuRDZhSTJyZlp5U1I5b3BPOE5JdFRJMnZjSnE0OFJPeDgv?=
 =?utf-8?B?NEsyMnh2RU9KYmFFZ0xQV1NDeHFUZUFWbjNPQnFiQ1R1Rzc0c013RDhCK29u?=
 =?utf-8?B?a3RBQVVFb2g5WmEyUUFCSm5YVlJ0K0JJc3JmVDlVSkgrcExHNE5vbVFXcFhs?=
 =?utf-8?B?cmVUOFNlY2t2c0FDL0grMWx6WktEejMxcGlHZ2p5YkNLNVdvUU9vbXpHRDVH?=
 =?utf-8?B?TkNuYWpzTVRsa0dZeUZFc3YrVFlVYW50anRhTFY2M1ZLOWxyNERueFA4NVlh?=
 =?utf-8?B?MXFGY1A3OXRwQ3paNzlhd2tVbmJ5dVgxdnZEVW00NnNmUWdZejNqK1hvdmdT?=
 =?utf-8?B?QkxOVE5CTlRzMlFpVXlmMmpGaC9RL3JhR29VVWRCeVBoVWdZVWx2VEREZVdx?=
 =?utf-8?B?bG5lb0tMazB2SGh3YmxnRXB2WlVhWStjcFQwOHlFVzdUMzRsYTRVaUhzUVM4?=
 =?utf-8?B?RUt0a0VYRlZpYWcwNGRkZGJmclROVTZrV0hLY0RNNElkckFLZUZXNk1sYnp6?=
 =?utf-8?B?YnZoT0UxeW1PNGVrRUVSSzd0UGpLMXYyWHM4b1JWYkd5a1VONk1GemhGRU8z?=
 =?utf-8?B?eS9td2RIVjRWdkNoM2xOWDkyVTZDL3hxRWZMNDdXVHltVWZWWnNxWnhkd1Yw?=
 =?utf-8?B?NHQ1VDNVL1VZektVUjB1aUEvWEt3MVlMNEVTSmNIZjFhMVN1MFRMZGhqTmRI?=
 =?utf-8?B?NWdmSFgycW1FZmlISGVnYWJKcThtZHZBZktXdVdKVjlaUDJHQ1RxZUFtS09p?=
 =?utf-8?B?WkJ1VlBLdGhxVGZscVlRYkN0MU9KVENuRDlub0JBVUJvNm4yL3J1eG9zWjRK?=
 =?utf-8?B?TDZ5NEZVNmFtdWlJVXRnZHI1N3ZITGlFeFJQQnUwOE1Pc3p5dTQrWDF2ckFT?=
 =?utf-8?B?TEF5RktuMFU0Mzl5WWw3Zm9lRGJYbjZlVmlkZ3FHYzE3ekR3ZXVZS2FxREtq?=
 =?utf-8?B?U3VJdllnZzFBc0JUYnpPRmpsNjh5L2RWVVZFTUlnNjZTcVRGaEdjdDV1YWVx?=
 =?utf-8?B?QnFHOGVoTXJPemhiQkJQWVBxc0hma1ptdlRnUHB2K3VOcWFYK0FVSWJrOW5m?=
 =?utf-8?B?bDc1NFN5YjB1K3QxTkxTdVVMd3NnOHhHM3FLcHhQTmRnTTk1aldxNFhEdlBi?=
 =?utf-8?B?b3B4eit6Vit5c2QxYTg0MVgrYWczSE5LMzZOM1hNQ3ZuL05Ldkx6RDgxVWx4?=
 =?utf-8?B?bDhSOEc5MU5rQXFZdXFKeWRENmtiaVVoTTZkYS9yRmQyYnRRWE90Y090eDlu?=
 =?utf-8?B?MksyWGRUV2lNd1NaTGZCY3pLYVdrUE5Jbzc4TFZnVWNmRjZnM2dTUU05Sjhj?=
 =?utf-8?B?NzIwTGl3Rkpnd2tyUkN6ZDFjSUJaampUWStuTWEyeDRwVkt4eTdKVDlJODBV?=
 =?utf-8?B?N3hGZTVTNkJwblNkU2p3Q21Zc3lxMXVvZmthdkcrMllNU0xvR0ZIdWlKTE1a?=
 =?utf-8?B?RzAwaUpvVlk1QmFRNE54UjNNVHJQMkplQVB3d21rT3Jac1MraXBXRFFxcVVJ?=
 =?utf-8?B?czNWbmtuMFcwUVZZS1E2S29lWHQ5aUp5Z29nYjREU0c0NHJTVkVqZW9BVTdS?=
 =?utf-8?B?Y0FHSS8zTFp1aGtUOWVnUTlGNzFYRytHWG1yRFFFL05WYWs2b3IyVE5acGxQ?=
 =?utf-8?B?eWM1Wlhjb2FZZWpIY2FTRGdTVVFBWHRvaFBoSGJ3d1ZGSlZrTzhuSlVIVW1x?=
 =?utf-8?Q?1eTkMQaHxq5OOwKhFTfMoCIr2yXFMCqkTreyg=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR03MB6226.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(366013)(7416011)(376011)(1800799021)(38070700015);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZkpRMWZEOEZ6YTlzd3RkV3p6cFFGMUJRcDNnS1dtb1hrbFNNdWRmbzBsOWpF?=
 =?utf-8?B?alRhV3dIaVBxSG1MYnIwRC9LWldVeVVlNDlENGdRWjB4QTlzcVczZG54TG1s?=
 =?utf-8?B?T2ZPYkVjN0QwcmRVL3RqL0ttKzNKRTBDVDR5NFRxRHgyUFVBUEx2aVFrY1Nu?=
 =?utf-8?B?NUR2MmgvdS90T1dva0xhZGpDSXRTM01kdUJNTzFIZC9ZRytlZ2tkTFNsREFp?=
 =?utf-8?B?d0NvMHAybk9FQlE2SEZSTUNWWXVkbVpvdTVHMDdJNnpmL3hoNEk1QnQxcDlx?=
 =?utf-8?B?Q2o0NlFVTGJFZ1FWTGVPZlhvSGZMT1NWRklMRmpFVk1FOTFsS3lVZkFjTHYr?=
 =?utf-8?B?ckRVajBFUld0U0V0OGlId3JGOTFBY250STJJb1lZdDJLY1h0KzBPR2xXR2hm?=
 =?utf-8?B?QjhuNUNSeU1DWlFUa09GQXdjdTZ2azkzZTA1cW53cldOdm9LRmZIdWNSTmVP?=
 =?utf-8?B?SHZ5STVkVEVoblh4dnRNdE9URWxSQU5aeWhzS1pVYUxIZ2tWeStTZk5LVGJ3?=
 =?utf-8?B?dnB6U0plOU11dis1RXRTSVFrZnhNOFQvVjg3RXNNTmVNOE1BNkF1MmE2eVli?=
 =?utf-8?B?VUxLaVl4K1NsaUdETm85Q3BPTjBuWEthSDVyd2tyczFjVzV3VkV0ZXJKY1pL?=
 =?utf-8?B?MkNYM0hubXRtb1RpVHJMdmdnaldCNEhYdkZoVjgxUmd2dEcyVUZyNko5RVA2?=
 =?utf-8?B?REtLbTBYMkNDS2RnSkozd2o0NGtaWmxOUVBMZTRlM2c2UlMxMTBrL1BESk9i?=
 =?utf-8?B?RmJkOHYvMjlpVGsvdUZrcTcva3lEeXBkSDlJMXNFcmcyMU9RVHh3WDJrV2oy?=
 =?utf-8?B?TzVIUGF4ZzVhS2xFT0ZOckk3Qi9JZEgrOU9sVGNlOVlJM1Jadk9OWWoyaDQ5?=
 =?utf-8?B?N3U2aUJ3RnRVVWc5WkZCQnFhbzllQjBlWVZ1SjVNemhTWFZsVHkrWmxhWmll?=
 =?utf-8?B?akFsSWMrRVkzcGNZMEJDQ1NuUUhmczJKKzE4ZzZpSGdSWE1TVGtLdTBoWlNp?=
 =?utf-8?B?TWMvZW5vR3gxaitVb0htazZnSDMzdXRHN0c0eWJZSjZWdk4zenNiVUZiR1dX?=
 =?utf-8?B?dHk5Z1dFN3d6YmtwajMvTHk2L3FrSklUQ0F5Zzc5UEFjY29qbm1tMnR5bW5o?=
 =?utf-8?B?bVdtOUdqa01sZG5LK3hKVWEyVW9sTUVwUFRFaHdQK0l6Z3kyN0xabHJTM3NF?=
 =?utf-8?B?VzRReStmblg1eDEzQUFaeVFhWWw0UkNGNy9Uck9GNWlwREhEV2lhZ3BZaXNi?=
 =?utf-8?B?MWFJc3NRR3NGUDJLRU9kaVBxbEJCbGVGSnhvZnRqM0pvMklwUzh6M1IrYU1h?=
 =?utf-8?B?WC9tRkQwWGxQUlJmakVLRHQzd3dGQmw1ZGVoSUpBVnVHODZ4QnlEdDNNUUQy?=
 =?utf-8?B?YjYwdWYyQnRsUi9kSmpOeEZqd1JyQ0JORkpxVlU4dDA5Zk1tbVhrQW41c0tw?=
 =?utf-8?B?VUFnZmRDcFp2M0VVS2g2aU1lVWcyM2RZSzNjUnArOFRzYUdsOXROUGJESzhK?=
 =?utf-8?B?dXV6YjBQS3gySFJkZWllSUQzT3pyS2d1Z1dzK0dJNmwza3pqcVNzTjIzUU1O?=
 =?utf-8?B?ZUlWTkdyMTVVMGcxOHJTcmd1ZXlxVm1oSzNyQWZKOXEzNEJsbGVYb2REVlpR?=
 =?utf-8?B?U1Z3M3dBQ0x4L1d5M0pJUmptVjlQU0tmWVhYZjdCcDRCaHdhWC8zc01xdTd1?=
 =?utf-8?B?aTZRNXlzSFpMSDhxNUJQS3BFaHgrZ2JBU1dKSVhpNG4yUnZBZ2E2WG9Wc3VS?=
 =?utf-8?B?ZFZ2bUhIU3hFWVp1REdxdzh0S04zWVVPa2cwQnkzZWlvZVZIRDRYbHduVURV?=
 =?utf-8?B?bnVkUlpud3h6ajd6L2hxSmUveE9VeVZvMVZCUEU1TUR4Ynp2dlJCWlRZcHp2?=
 =?utf-8?B?UkkvQ3Irc1F0Q04vdGVIdmdHaWNLdDB4UUVIOVBKOFgwMFJBWWFtRFV5bDNp?=
 =?utf-8?B?V1NkZ2doYkxLcG5OUlZicDJPTU5Lb2xteVE0dUFwczJxT1M1UHNIL1hmb25H?=
 =?utf-8?B?aC93OHVCekh5N0ZHVzgzOTlOSkpLL1FReDJmMVI2dHlhVFRjWHlGUVQvd25s?=
 =?utf-8?B?cDVXdVp1bWJicmtIMFRxVk9SRktWSjBCclREWDUvQ2hSZ3lWM1dlM0ppUlVX?=
 =?utf-8?B?TDlma2d6U1hIRnluZitMNjJyS2dHZkxZMDBkOXlIMjZTMzRRbEl2ZUVPT01U?=
 =?utf-8?B?VlE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B0407963D22D1F4F86A3912E9AD38F9C@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR03MB6226.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15706a2c-86ea-4a74-add1-08dc9038533e
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jun 2024 08:17:56.8779
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HU/o11MTPvIHzprfnY6wMlZbqQojlXuhwcWss3zAc8FcHHKAXUM1vlpoX6Nbydm2L+qQtY/acON8RWBwos3lEnupb4THDxiAdzcpILaphn4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR03MB8738

T24gVHVlLCAyMDI0LTA2LTE4IGF0IDA4OjIxIC0wNzAwLCBKYWt1YiBLaWNpbnNraSB3cm90ZToN
Cj4gIAkgDQo+IEV4dGVybmFsIGVtYWlsIDogUGxlYXNlIGRvIG5vdCBjbGljayBsaW5rcyBvciBv
cGVuIGF0dGFjaG1lbnRzIHVudGlsDQo+IHlvdSBoYXZlIHZlcmlmaWVkIHRoZSBzZW5kZXIgb3Ig
dGhlIGNvbnRlbnQuDQo+ICBPbiBUaHUsIDEzIEp1biAyMDI0IDE4OjQwOjIwICswODAwIFNreSBI
dWFuZyB3cm90ZToNCj4gPiBUaGlzIHBhdGNoIG1vdmVzIG10ay1nZS1zb2MuYydzIExFRCBjb2Rl
IGludG8gbXRrIHBoeSBsaWIuIFdlDQo+ID4gY2FuIHVzZSB0aG9zZSBoZWxwZXIgZnVuY3Rpb25z
IGluIG10ay1nZS5jIGFzIHdlbGwuIFRoYXQgaXMgdG8NCj4gPiBzYXksIHdlIGhhdmUgYWxtb3N0
IHRoZSBzYW1lIEhXIExFRCBjb250cm9sbGVyIGRlc2lnbiBpbg0KPiA+IG10NzUzMC9tdDc1MzEv
bXQ3OTgxL210Nzk4OCdzIEdpZ2EgZXRoZXJuZXQgcGh5Lg0KPiA+IA0KPiA+IEFsc28gaW50ZWdy
YXRlIHJlYWQvd3JpdGUgcGFnZXMgaW50byBvbmUgaGVscGVyIGZ1bmN0aW9uLiBUaGV5DQo+ID4g
YXJlIGJhc2ljYWxseSB0aGUgc2FtZS4NCj4gDQo+IENvdWxkIHlvdSBwbGVhc2Ugc3BsaXQgdGhp
cyBpbnRvIG11bHRpcGxlIHBhdGNoZXM/IG1heWJlOg0KPiAgLSBjaGFuZ2UgdGhlIGxpbmUgd3Jh
cHBpbmcNCj4gIC0gaW50ZWdyYXRlIHJlYWQvd3JpdGUgcGFnZXMgaW50byBvbmUgaGVscGVyIA0K
PiAgLSBjcmVhdGUgbXRrLXBoeS1saWIuYyBhbmQgbXRrLmggKHB1cmUgY29kZSBtb3ZlKQ0KPiAg
LSBhZGQgc3VwcG9ydCBmb3IgTEVEcyB0byB0aGUgb3RoZXIgU29DDQoNCkhpIEpha3ViLA0KICBN
bW0uLi5Tb3JyeS4gQnV0IGlzIHRoaXMgcmVhbGx5IG5lY2Vzc2FyeT8gSSBhbHJlYWR5IGRpZCBz
aW1pbGFyDQp0aGluZ3MgaW4gdjIuIElNSE8sIGN1cnJlbnQgcGF0Y2hzZXQgaXMgc21hbGwgZW5v
dWdoIGZvciByZXZpZXdpbmcuIFlvdQ0KY2FuIGVhc2lseSB0ZWxsIHRoYXQgd2hpY2ggcGFydHMg
Y29tZSBmcm9tIG9yaWdpbmFsIG1lZGlhdGVrLWdlLmMgJg0KbWVkaWF0ZWstZ2Utc29jLmMgYW5k
IHdoaWNoIHBhcnQgaXMgdXNlZCBmb3IgTVQ3OTg4J3MgbXRrLTJwNWdlLmMNCg0KQlJzLA0KU2t5
DQo=

