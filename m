Return-Path: <netdev+bounces-97190-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F19508C9CAC
	for <lists+netdev@lfdr.de>; Mon, 20 May 2024 13:53:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D0C81F219AD
	for <lists+netdev@lfdr.de>; Mon, 20 May 2024 11:53:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 439FA36134;
	Mon, 20 May 2024 11:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="a0MsF0JH";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="SZ452eW3"
X-Original-To: netdev@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 534CD548F7;
	Mon, 20 May 2024 11:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716206004; cv=fail; b=ri8jEooxPEdiu72mH9ADohH6u6I+xCpKNCoezNEZRRq1jCc95iAT2Ahxg4B8ZmimhSEr2zsMF2RrGvnoe7wxNSUNw2hsQxGYiBuWhsGWDZdsJ+grbTbbYc1U9iPBunz/mN6Y3UlQ3OQ0+QFuidrDrGg79Nao/Yao5HuqYDMTKR8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716206004; c=relaxed/simple;
	bh=o+eguoCmc5kAzUtU/2xquh/rzF9n9KRbt2kuzqjRjSc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HIdG4faK9TAXfj+DZ/J8b/YUtXnPbpNy1vddXqahpcPHluQ6pNxJaGV6jibMK0sK4mBbtm1W3zIcBkfx5tW/74P8FGqa8ogB02FfZHqafWQuh5wSdxF2xoM/K1wIjMIyKn8CZ7R3EmtriCHtl7CNK3P43zqKojd7/n8Va7Acph0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=a0MsF0JH; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=SZ452eW3; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 8beb2a26169f11ef8065b7b53f7091ad-20240520
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=o+eguoCmc5kAzUtU/2xquh/rzF9n9KRbt2kuzqjRjSc=;
	b=a0MsF0JHZe6lGovyLZu/5/0tyROlm60DgOJjopwlfhQKRBIALVuDLJDv4rcVqKMf1pwZp/HOYAcmhxw6qIHCtM0L5MKiXSlLKmypcsteN83FKkOihDVO9OFOP8J3Qiu2GH7heuVIwi6auiXquY9pjhyuRnaKQizutt7dr2XWBVw=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.38,REQID:a5943f9d-bcf9-43a7-96c6-46b53b698084,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:82c5f88,CLOUDID:0e4ffb92-e2c0-40b0-a8fe-7c7e47299109,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-UUID: 8beb2a26169f11ef8065b7b53f7091ad-20240520
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw02.mediatek.com
	(envelope-from <skylake.huang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 973206719; Mon, 20 May 2024 19:53:17 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 20 May 2024 19:53:15 +0800
Received: from SINPR02CU002.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 20 May 2024 19:53:15 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dPgedOjB0PJXdfuqjxBg8R67KV6PsYsn9DVU3BWpI/otXTDWbtC3jJfepWpxmjW/3ERk/Z7c/HD1Nug9Tyns2TPVdZA+qxlFusYDyFt/+wde2E5KKRwFz0RrRqWMeDY4oiVV7l1j5w5z7a0mrP72XPQGSYaRHLPnRNZEUufFRp/l+kCKUK1vvuehCF7x9EhWyBJPE/zi9BHYQ8qTsj60KL5q+5Jbn+V+I+l2gOmcciO2y1OQn6tmXBTJvlcifvpdExyaFQwE7Cho+4I4NY5FqGv8rqIR/IQKctU2q5L9vZdHRuiHw5nV/2ZnaryQgnY2IIydSVqSl7PM7TjwxJxu4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o+eguoCmc5kAzUtU/2xquh/rzF9n9KRbt2kuzqjRjSc=;
 b=lb9AtJSBDYFhpHibr/pvl/9EgfUw1tt7zMiWu747gXqwvE1yVN08yKT9+9ljXlWGH8XRQ6maTWQINTqthvnu8TFHDxbmbIrUAlHj/8cPZYb/dNE2Ox78sSvPaIvPr/VoISclRXdnORK0U0lFpI+i1R04VmGRUWvk95oXzmyoK0R8XAzzOlJrVjIWPQiNPIXqoHKBtHM01Q3+11dczHt0tFHksnT5sC7HoRr57qR+n/hF3O7jaRmOaN+nN/X7NE0Y1MFpuTjaXr/y3d6QA623t0BXLaw9oe64PgqQoSSJyPMHIDAl03sAHIntNckf1b5C8SsbaZEAQnAok7x+br0GJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o+eguoCmc5kAzUtU/2xquh/rzF9n9KRbt2kuzqjRjSc=;
 b=SZ452eW3mfZeoHRn1fl67KA0R7R1F5pigOvCPQzeMBY5PxaIkxusBzrk8BirAp3FotpewLaFIcvYhgDYV7EuA/Zc5Lv8xUCl060To4kxfxLM+AqlfHJjmSCBzm+SAeDw5L4KZ5saHousLy2LjlhT6F+LHD4qG3zKxuEFuqoaD1A=
Received: from KL1PR03MB6226.apcprd03.prod.outlook.com (2603:1096:820:8c::14)
 by SEZPR03MB6851.apcprd03.prod.outlook.com (2603:1096:101:96::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.16; Mon, 20 May
 2024 11:53:13 +0000
Received: from KL1PR03MB6226.apcprd03.prod.outlook.com
 ([fe80::f3:c11:8422:7ce3]) by KL1PR03MB6226.apcprd03.prod.outlook.com
 ([fe80::f3:c11:8422:7ce3%5]) with mapi id 15.20.7611.013; Mon, 20 May 2024
 11:53:13 +0000
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
Subject: Re: [PATCH net-next v2 0/5] net: phy: mediatek: Introduce mtk-phy-lib
 and add 2.5Gphy support
Thread-Topic: [PATCH net-next v2 0/5] net: phy: mediatek: Introduce
 mtk-phy-lib and add 2.5Gphy support
Thread-Index: AQHaqEUUvlSt3c0Sj0mKrON+kWVxDLGbyzSAgAQ81gA=
Date: Mon, 20 May 2024 11:53:13 +0000
Message-ID: <ffac8ffad3ec09d26bcdc537bfe9f74970ad9782.camel@mediatek.com>
References: <20240517102908.12079-1-SkyLake.Huang@mediatek.com>
	 <20240517121025.42b76cb4@kernel.org>
In-Reply-To: <20240517121025.42b76cb4@kernel.org>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR03MB6226:EE_|SEZPR03MB6851:EE_
x-ms-office365-filtering-correlation-id: 11f89498-e6af-41fc-9cd3-08dc78c36de7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|7416005|1800799015|376005|366007|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?dTZtdG1JS2xrb3U1L1J1TE5FdXJUckg3NDlUY3pLQzRFK2R5VzMzL0xOWTQr?=
 =?utf-8?B?YkhDbXVvbnlVenBWSDBTckVUSUpKL0NwVHhEanBZcWVyU0RRNXJiMStYWExq?=
 =?utf-8?B?VDU4ak04R3BRMWlaQm92RjI4TVhaM1pxYndPSVlrUDlSODkyYlNvalVHbjk0?=
 =?utf-8?B?ZnJuS0F6WTZtRVR1ZHN3bFRYcWRpNVdXS3YzSDVPbnVSMTdYczlCZmxCdWxq?=
 =?utf-8?B?TDc2VEJkUXpuMk5aU0pzemVKMGRaMFF0MW4xV3JxdE1TN05DV2RBa0srUGVX?=
 =?utf-8?B?QXhmNGN4SHpiRXprdlRHRENoVGpQRng0emFLUzBkWW5TdHRkRzBMMU5kbHp2?=
 =?utf-8?B?K1A1UnlqUUw2OVZzWmh4U2t2WkVjRnhoQWVPL1NNOEFleS85V0xTdVpBZVZk?=
 =?utf-8?B?SzcrRzFSZkM4clRGWStqcW9HL1FoeGZ6SURxNyt1b2hBK3cwODdYcVVOVW5R?=
 =?utf-8?B?NWxJWHlsRWJkWGYwQjlYb1B3ME5NTTRtMFZtTW9pSXpRYUFVQVpOc3VRN1p0?=
 =?utf-8?B?SEF0YWFEU0ovYmN3Q3A4Q1pOSE4reCtIVE9rWm5vdUUyaWRTOVcreWJiK2hE?=
 =?utf-8?B?SEtqTzRmakF6WndWOW0zeTNlRXVlVWluT3NicHlTR1JUU05lYjk4RFZ3ZGJZ?=
 =?utf-8?B?TkluOE1zTmJLQUR3S1VSM0ZTMzVFekhRM0FHN3hBWE1XTVZsckRiZHpXN1A4?=
 =?utf-8?B?amtWcXlFUDZ1Ni9QMTNScktnR0F2anFsclJMWVhUN2RLYThnTVpPdGduY29v?=
 =?utf-8?B?K3dURTJkNnFIbXNCSnNtZFZaOWtsb0ZaTTFkcTlFeHhoblgvN1JqVm1kc1dH?=
 =?utf-8?B?REJzamtaZDVxSUdSRzNxTlI5bVM2S3pUUm5aZmluNmtQZGhqdTBqL2RxcTd1?=
 =?utf-8?B?QlorVlpna056MmJUdmcrZGFjb0tZL3JlVW5CT1BwaHNDRHdEajBiVDBhNFYy?=
 =?utf-8?B?eDlWanhBMHRadEtkSGs5aXA1WmtuYURhZmptZjhPRlUyTjJTZVkyUFdGNlVP?=
 =?utf-8?B?UGFyOGpXMUdRT0p2SUhnaWFmZ0dpS093ZEd1UkZwWlJFZm91SjEzSStkT0Nv?=
 =?utf-8?B?RE41cmw3UVI2RncyamwzRmQ1YjZObEE3a2RLMDVGWlJEb0l4ZVRLRFY3Smdw?=
 =?utf-8?B?UWUvOENSMWJ5dUh6bTRLL1NmUWlzVU1FbjFaSjVpblgzYndhNllJQ1BHMFNZ?=
 =?utf-8?B?TlBJRXpmakZrTGNsaUFKVTZTaUswVldPaFllN2I0T1dZbUNhN2dydTFKZGlQ?=
 =?utf-8?B?d2x0Qlk2endtWTNENmg5Z3NUZmlsLzhhSFdBOEllQUxrUUt0WGhhN05QYXdQ?=
 =?utf-8?B?b0IwZlZLNkF4aDlXRm9kSUtwdCtFanlaTUFjNXlFWlZpYXVCWnFXcVl0S1dn?=
 =?utf-8?B?bERjWWJLSWZVNllCQVZsWkgrN3JySFdVZVFHQXBBMmZGZGlGVFJOYklMYit4?=
 =?utf-8?B?dnpBdU1TcnBLSVlieEtiNGJpandqeG1nYUdoRkJ2aDZrSEFWYnpPN1pFZ3Y5?=
 =?utf-8?B?LzNST0hHYUxwM2pFVktubjk1dlZJc2FGOCs5cTRRa1U4K0phN2k5Y3hxd0ZS?=
 =?utf-8?B?NEpaRmxzL3NWSXFveXI4NUZwdFBKWkUyZFR6NkRMSlgwQW1NVDZyY1BSaTBp?=
 =?utf-8?B?ckZmTFdmWEVrQmZUQVhwQ0JiWFFwT3hXTTNjZGprMDh5NVQ3amFiSzFqRmY3?=
 =?utf-8?B?eFl5RU1jOGZMSHNyNFphZ0pKSnlTbkFYMkwrb2l6Y0pnWXR6Mjk2dkpRPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR03MB6226.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(376005)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NHhJUVFRanFGaFQvRUtCTXo1V2NYVmdEU0I0Z2RVd2J2Q0prbnU1N1cyVlJ3?=
 =?utf-8?B?TmVhaEJvUU9sUjI2MTVpUVNuTCtKUFhPYUthMHlsYjF5bW1wWnJPNm5jVGlz?=
 =?utf-8?B?SlFSZTBnc1NRSktrVk15Vkd3b1NEM1l4YWRVU0RqMkw2WmdQQ1g2UGl2Nmxs?=
 =?utf-8?B?V3h0ZE1Ya3J0R29ZbHpTMEQ1WDlZa2JOMCtFVU5NUGpVZWtHQWwrTVNjYTBF?=
 =?utf-8?B?elkvdlJEWVFSUGwvZmJsd0Q4SDJzNXR1bkVRZzlhcmJVKzFURXNwbWFPUUIr?=
 =?utf-8?B?bGdSNUEwVjVrb1dxa2NBNmhvYWxVWkZqekNMZlM4dzZIZ0tJaStqSFljZER4?=
 =?utf-8?B?RWM1TUtnOExwYlg3SWZWOVVUbDBHdlloRXFqR3RMaWRMeVdMVGtaRWxEemhk?=
 =?utf-8?B?TklnbXFWSVlORVd4bjlrYzZ6N0VWOW9DNk55aVNoeDVoaGtCbGkvWU5QRVFo?=
 =?utf-8?B?VlRpRjRJQmNPU2ZFd1RDWFFOOU5ZaGVpQVhtM2l4L3RQV2pacHJsbHg4ZTFy?=
 =?utf-8?B?WFA4b08va2VZaU5OTEpYMEM1em5FUS9lWlVUUzVGR0x4dzJNQ1E1OXVVRG9T?=
 =?utf-8?B?M2tOQWZXSXpRR1h5RkVCcnN5SzJtNkJiR05zaHFsQlNqUlVwUVlxT2l5VVRt?=
 =?utf-8?B?a0tJbTJNYmZXWXlCdWRkVnVHVkdwWHlSMGNyckJLQTU0V28zQ1FTZHhkREgv?=
 =?utf-8?B?RGV2cGZTL0trVm5jUk92blR1RFpOYXl6bmppYVBEcUdSUzFRVlZGL3FtMkl5?=
 =?utf-8?B?c0VyRFRxVTNTclJoVCtTM0E3ajM2OTZEU1UwYmUxR2JOWW1MS01RblgwZURC?=
 =?utf-8?B?dEZpVUxKVWxjbXQrUGlxVDI5MzRHdHVjKzk5MkFuTllhdXhFbkE3WTUvRTQ3?=
 =?utf-8?B?d3ZUS0hHUStPd2NsV1V4QzVDcEw4MkQ3OHlaUE8yR0VaUW5YLzQxVGt5K2ZR?=
 =?utf-8?B?L3JDRjh6SmhzNmZ0cVp3U3lBc0xsMml4SEpWbFFuSHlPeTFRQlZ2cHpKUDhp?=
 =?utf-8?B?YWluN2pseUkwNWxocC9PVDBJVXg0UjIxMXRKUUdtMGM1TzNPYWFxdXJJNGhZ?=
 =?utf-8?B?RDFzd2FQSVhaT2o1YkJhRlBpd05CbnRNV1QveHpHM2c2ODNxbVVjQ3BjVjNp?=
 =?utf-8?B?bTFwRGFzMEpyaEkwbXA3Y3BJTm1mNTB3Ynh2UEhYbkdvVDZmalFtTTNNcExx?=
 =?utf-8?B?d1BDUVRlM2JuL2ZxeE1ic3JNUHdwU1VGNGpaUWhiV3NlYU96SzFZSlMwUXVr?=
 =?utf-8?B?UVI2SVFIZThmUG41eE82Qzc4K1YxL2RONDlJVmovdWJPYlRtTEh6eStQNDd4?=
 =?utf-8?B?OVoyQU5TYlJ3VnJTemtMN0tXT2dRYTlGZWpWV294WFhIL3MwS0VheWs2UDB3?=
 =?utf-8?B?dDJVSXRiN2pYeXMxaW9wYXZDRllxTW94ajZKeDZuVndKU2h1LzYrTktFT0kx?=
 =?utf-8?B?UG9BRjJFd3dma1NHd0REV3dCaFh6SmlMRmVDOFd3Wkh4WnFaeHI0eWxSekhJ?=
 =?utf-8?B?VVZSVE54NXdQaHZiRDhWeFdKdGxUTnYvQnk0MG94bDhtdXhIbkRhWVpDVThC?=
 =?utf-8?B?aUlKUVJVb3hJYjlwSStKZFY0QXR0eHFWQnhBMzAreG9MNDdDb1hGclFnd1pM?=
 =?utf-8?B?SUVJR0JxdGZncnNkUXowU2tCUURXbGo5Y01SME0zQlZWTTFCVjVMWU9rdXNM?=
 =?utf-8?B?aEpLNGFrRXZYZTNoZ2J5RVNtbXYvNnd1Q0VFb2JyYW12QjZRTzduS2g4RlJ1?=
 =?utf-8?B?c1hkR1BlOTVZcEhNTzdvZE5LUzIxbmhycG9FRkEwem0vazZvaHhrTlJpWVJK?=
 =?utf-8?B?NXhPVEFrS2Q2blZxNVZhRGwvcVlnUDR6aGtjelRBRDMwVXhKSjE2SzdWUnRE?=
 =?utf-8?B?OUJlU0UvdmwxZllpZGdMSWJ3bFJES3lXVEhvMkRoRzg5bVd0ZjBVM01kbjJK?=
 =?utf-8?B?b2JyZzBkVmhvc0d2WlBkakF3TEZwb2NLZmVPcWxqMXdlVnlJckFuL1hBZlo4?=
 =?utf-8?B?TzNMWVRnQVNXQ1BJUXhINjNQdWZoelJDYWdDcVRuNGdzRzc3SGNMQVlnNnlP?=
 =?utf-8?B?ZkVsS1h3YWNsNFg5WmlJK1loaTVHUVlmNGpMSk9oRmhmcEtZTy9laENSdWVG?=
 =?utf-8?B?R2xnOFBaYXZhelhrcC9McWxhN290ZHZ4M1VSL0ZTRXkwWjJ0Z2VyWDBhaFU3?=
 =?utf-8?B?aHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <67B5C53967EDC84EBCB09FFA43890797@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR03MB6226.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11f89498-e6af-41fc-9cd3-08dc78c36de7
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 May 2024 11:53:13.7469
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6Au/crC1Q5yoRHTkWm7z+6aE/E6WTrFONbbX2k6hAbuXh0dUfdxkVvnkkqbMhwx7nOB2UCMXrm0zrcOC31y60h5DntagtTuSwGeZR0C2Ayo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR03MB6851
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--23.406500-8.000000
X-TMASE-MatchedRID: GBgFBUqwD4HUL3YCMmnG4ia1MaKuob8PCJpCCsn6HCHBnyal/eRn3gzR
	CsGHURLuwpcJm2NYlPAF6GY0Fb6yCrgUEZdR+F9imlaAItiONP1oOg4viDMipFwpnAAvAwaz1sT
	lzu9ctp2MJPmE7ns2w4ClOLfERFXzBJEiC38WiBrKl4yJoI+fG6APS3vFyaW6Z5yuplze9pv1O9
	p2Fcb2DT7pk9xWlyUdEeUpnQq0Boj7OgBbxHXmXxlckvO1m+JcPj366R4tj3WbKItl61J/yfmS+
	aPr0Ve8oTCA5Efyn8CNo+PRbWqfRJBlLa6MK1y4
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--23.406500-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	C5A224E1DEDE931660DBFA9F8B722109DEEC1C43C68BA076457C002F00236C9A2000:8

T24gRnJpLCAyMDI0LTA1LTE3IGF0IDEyOjEwIC0wNzAwLCBKYWt1YiBLaWNpbnNraSB3cm90ZToN
Cj4gIAkgDQo+IEV4dGVybmFsIGVtYWlsIDogUGxlYXNlIGRvIG5vdCBjbGljayBsaW5rcyBvciBv
cGVuIGF0dGFjaG1lbnRzIHVudGlsDQo+IHlvdSBoYXZlIHZlcmlmaWVkIHRoZSBzZW5kZXIgb3Ig
dGhlIGNvbnRlbnQuDQo+ICBPbiBGcmksIDE3IE1heSAyMDI0IDE4OjI5OjAzICswODAwIFNreSBI
dWFuZyB3cm90ZToNCj4gPiBGcm9tOiAiU2t5TGFrZS5IdWFuZyIgPHNreWxha2UuaHVhbmdAbWVk
aWF0ZWsuY29tPg0KPiA+IA0KPiA+IFJlLW9yZ2FuaXplIE1USyBldGhlcm5ldCBwaHkgZHJpdmVy
cyBhbmQgaW50ZWdyYXRlIGNvbW1vbg0KPiBtYW5pcHVsYXRpb25zDQo+ID4gaW50byBtdGstcGh5
LWxpYi4gQWxzbywgYWRkIHN1cHBvcnQgZm9yIGJ1aWxkLWluIDIuNUdwaHkgb24gTVQ3OTg4Lg0K
PiANCj4gIyMgRm9ybSBsZXR0ZXIgLSBuZXQtbmV4dC1jbG9zZWQNCj4gDQo+IFRoZSBtZXJnZSB3
aW5kb3cgZm9yIHY2LjEwIGhhcyBiZWd1biBhbmQgd2UgaGF2ZSBhbHJlYWR5IHBvc3RlZCBvdXIN
Cj4gcHVsbA0KPiByZXF1ZXN0LiBUaGVyZWZvcmUgbmV0LW5leHQgaXMgY2xvc2VkIGZvciBuZXcg
ZHJpdmVycywgZmVhdHVyZXMsIGNvZGUNCj4gcmVmYWN0b3JpbmcgYW5kIG9wdGltaXphdGlvbnMu
IFdlIGFyZSBjdXJyZW50bHkgYWNjZXB0aW5nIGJ1ZyBmaXhlcw0KPiBvbmx5Lg0KPiANCj4gUGxl
YXNlIHJlcG9zdCB3aGVuIG5ldC1uZXh0IHJlb3BlbnMgYWZ0ZXIgTWF5IDI2dGguDQo+IA0KPiBS
RkMgcGF0Y2hlcyBzZW50IGZvciByZXZpZXcgb25seSBhcmUgb2J2aW91c2x5IHdlbGNvbWUgYXQg
YW55IHRpbWUuDQo+IA0KPiBTZWU6IA0KPiBodHRwczovL3d3dy5rZXJuZWwub3JnL2RvYy9odG1s
L25leHQvcHJvY2Vzcy9tYWludGFpbmVyLW5ldGRldi5odG1sI2RldmVsb3BtZW50LWN5Y2xlDQo+
IC0tIA0KPiBwdy1ib3Q6IGRlZmVyDQo+IA0KT0suIEkgc2VudCB2MyBmb3IgcmV2aWV3aW5nIGZp
cnN0LiBJZiB2MyBwYXRjaCBpcyBmaW5lLCBJJ2xsIHNlbmQgdjQNCmFmdGVyIE1heSAyNnRoLg0K
DQpTa3kNCg==

