Return-Path: <netdev+bounces-99465-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BD8B8D4FCD
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 18:26:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2EEF4283333
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 16:26:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47B1320B3E;
	Thu, 30 May 2024 16:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="BlgA0tPE";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="IOcXn6aU"
X-Original-To: netdev@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 795C56AA1;
	Thu, 30 May 2024 16:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717086371; cv=fail; b=VhWj9QB1rrl4YXQCd3DBr4tRe3FIrPR9OWSiP06gZ2xSogYmjjZzvU8iO6B4eh56a9Y377Dz2mYQPGW2XX1eZdh+Nv5DFQLyuinKKLkYfcukPlvPrzBajSBpT7Y7eZsaG1YP/prjk9S8wO9ZkDDOzTmCUTjnMBES33HAIh3Xvfo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717086371; c=relaxed/simple;
	bh=Xm62PcRRGCC+D/J8EG5PMaYOEe7x5l59012VZNfy9ak=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=s9hfW4podrWT3xq4NO8g3lsHZcpCFjqsBXe0gTLP6JlX+74SD8oHD2e6AwSeLSBhIURGU9vQ0nMtkcP3v27GF8xvtVl09W06R3x/nCP8Hen+l7O81mo9ZprR7sWF/ENXT/Ks47PAwRndTaC6IWxL8YVg/nC9juQ70tDjdhtIhZ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=BlgA0tPE; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=IOcXn6aU; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 4e306e4e1ea111ef8c37dd7afa272265-20240531
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=Xm62PcRRGCC+D/J8EG5PMaYOEe7x5l59012VZNfy9ak=;
	b=BlgA0tPEvfGv06GWkY28pLFSVMfUfVpnqNi4NNMJsOxO3dQMVFojJJWtNhz7z1ImOoir768P88QaTUZ1iiQe7/v7EQGWxqG4eZPSGfA6ek/DPBz8LhwpB7qFwyKAXFmbnD26Fmn3AYCf9dbqhtAI5100PMx5CNXRrrDLZHL/xJM=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.39,REQID:ef976a58-43af-4d66-aee8-568f792094a3,IP:0,U
	RL:25,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:25
X-CID-META: VersionHash:393d96e,CLOUDID:b1850488-8d4f-477b-89d2-1e3bdbef96d1,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:1,EDM:-3,IP:nil,U
	RL:11|42|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,
	LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 4e306e4e1ea111ef8c37dd7afa272265-20240531
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
	(envelope-from <skylake.huang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1553648509; Fri, 31 May 2024 00:26:02 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 MTKMBS09N2.mediatek.inc (172.21.101.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 30 May 2024 09:26:00 -0700
Received: from SINPR02CU002.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 31 May 2024 00:26:00 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CbL5leAVmVKxaXbskaHSflW+cWHr4Ofc4nueVVFCo+I2Y72NP14U+sO23tGXxSFXTQujEqF2GlvsmABQLSitmllnpEaRN+t7ptGE3Dm6XzkOXnXHe4TA54SnF3HHWlESen9+3ZQTJoYSpEfbkjwIbg/vFhmiF3lcXYwrANv8gTKI6WI5rbVcoTftYta7Skj2uAxTAy/rtOw60QHo3ObFDUubL9HhC8ljSOxLJwguqKuvrSG6xKTU7n/VpXjj1LERpgFjBg41FpvS6KAecBK9xqHFL5vWCa6v+vFUkmlgHHNC+7gTl+U9Z2fR0A+jx0Qw1N8OpQGBocTrTExGrrw8Kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xm62PcRRGCC+D/J8EG5PMaYOEe7x5l59012VZNfy9ak=;
 b=D3pK0YizZZuFAtiOsYioAugWBUm1A9QBfT0gb9K8l7fd1tNvHbE/uqQLIMh2P76o+PJ/25Z4Y+CX01KtCOr/5MJ/FJwtFQMswzNgRlgXPBMf8uJSYTeQdycXptr/SCjsIcxpIM2kk4M8Z1xrjtN+ziQFKCwQQDzOtQHSTAcboXixPr8nHoeIf7xmFKH98H13ApBNDzkhJjd88jpJSrFLAyfQaxQd/o/aJ79MSw6aFPJ8aHXsGjqeAT25Y1JOEn5HIMam4QZEeuBioQ8Yax5dDDJ1mMtt5va1SQxM/rXkPX7uaqZMfM5Ko4YN2EZnNxtB5TFVHnjo2BC1FfaGM/P9iQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xm62PcRRGCC+D/J8EG5PMaYOEe7x5l59012VZNfy9ak=;
 b=IOcXn6aUj1IbjHbGZNUQFHnalxN1CcCz3G2dDRb8DJY6GXqxfazVrbG9FIeHsZb0F8ebr9TiyVR+tRmJQFHg2fi4zx0Wn/jVDzCadtZGUmWCIz1JT72V6T2nUZCnxMSmoFbni26mLZXxvbGor6fh+I8yMF+6k7+G1LaIMVoJIzo=
Received: from KL1PR03MB6226.apcprd03.prod.outlook.com (2603:1096:820:8c::14)
 by SG2PR03MB6540.apcprd03.prod.outlook.com (2603:1096:4:1d4::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.16; Thu, 30 May
 2024 16:25:58 +0000
Received: from KL1PR03MB6226.apcprd03.prod.outlook.com
 ([fe80::f3:c11:8422:7ce3]) by KL1PR03MB6226.apcprd03.prod.outlook.com
 ([fe80::f3:c11:8422:7ce3%3]) with mapi id 15.20.7656.007; Thu, 30 May 2024
 16:25:56 +0000
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
Subject: Re: [PATCH net-next v5 5/5] net: phy: add driver for built-in 2.5G
 ethernet PHY on MT7988
Thread-Topic: [PATCH net-next v5 5/5] net: phy: add driver for built-in 2.5G
 ethernet PHY on MT7988
Thread-Index: AQHaskSsuAYxyIGHGE6fd61psDix3LGvlbQAgABh2AA=
Date: Thu, 30 May 2024 16:25:56 +0000
Message-ID: <0707897b44cfbc479cd08a092829a8bfc480281b.camel@mediatek.com>
References: <20240530034844.11176-1-SkyLake.Huang@mediatek.com>
	 <20240530034844.11176-6-SkyLake.Huang@mediatek.com>
	 <ZlhWfua01SCOor80@shell.armlinux.org.uk>
In-Reply-To: <ZlhWfua01SCOor80@shell.armlinux.org.uk>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR03MB6226:EE_|SG2PR03MB6540:EE_
x-ms-office365-filtering-correlation-id: beeeff37-37d8-4f19-6a64-08dc80c52f23
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|376005|1800799015|7416005|366007|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?WjFUOFN2cGl6cWx4cFRjTHR2YkJZMUpiQURpam0vMUVYb08yTWNBMWJHLzVQ?=
 =?utf-8?B?QVNsWnZHalNyL2RMNUtUVnR3cEFXamNHSDJqQkl2Lzc2b3d5TWh5SjJkd1NC?=
 =?utf-8?B?V3J5WEZqajdUOUN6VWhybmcyYVN1VjJDV3lhN2h3eTg3LzRzSHJnNEtNdVBY?=
 =?utf-8?B?ODlualQ2STRhZTBjVERjcEppMldWdDI4MVN2NDhwQ1l1RDgrc1NySkVNK0Vv?=
 =?utf-8?B?RDZ6NEJEcklMZnIxM0thOG1uZmUzRTljbE1mbTljdWZwMlRjTU03OUZQUGpv?=
 =?utf-8?B?bHJsVW1sbEkrc3JWdFRVMUJvcGNhTWVGWDNtMWdJbVJmZSs1bHRxK1VnRTRh?=
 =?utf-8?B?UGZ4MFZ1K3U0bjRraUdwRVo0SWlFWDNzODVkYmZ4OHEzanpFN3EvY09oa29L?=
 =?utf-8?B?ajV2SXRqcmlZRDJucEVFWDVIcVJ2YTlpOXZlNEV5aVkyMjVIYmRMNTNuL3o1?=
 =?utf-8?B?OS81WHFWS2UydDg3WE92MVJ0dWcyVjRtY0JSM2NzMDZCNk9NTXVHcFphQlRk?=
 =?utf-8?B?MnExcXZ3UWNKWUJ4S0t3anJPbHQ3QVNsK2ZUUzhYNURWcElqamYwMVdtYVJ1?=
 =?utf-8?B?Y2tZMU9YNmpiVE9TODdDZTM0V0ZGZlcwWndaQ0VBOStkdHZUTVRGS3JxWG1r?=
 =?utf-8?B?S3I4ZjRVQ3pWSUh3dHlJSUtvUGNyd3RWMklMYVZ5ZEs2bWRwS1YwTWVWZGhO?=
 =?utf-8?B?bWxEK0ZDd1BaSTF5YitIa210d2o3WUJEUW9KRU41THJVVU5HdXBvYnNuSFUv?=
 =?utf-8?B?ZEhjUElhZy9qK205VXNEYUE1NGpyemp6dEwwYkJsUkZjeDYxVURZTEJtT1BU?=
 =?utf-8?B?c1FnTEI1OHRNUlJ6SWExdFUrTzU2ajVhQjhsQ1IrVDJ0dWk2TUt4RGx4L2gx?=
 =?utf-8?B?M2NxRUFzZ2ZYZWVGSlgwdkZvSTM1N01ZVkZDYm1RS1luT1QzNThyREFITWEv?=
 =?utf-8?B?ZnNLUDZuT2Zhc2VGWDJwcTNDbjY1eHBZamN5SzR1L0JzUy8rMHk0eGhGdnMx?=
 =?utf-8?B?MXJMdXN0OE9qazJ1RjJwQWU4RmRUY1QvbnJoUHhWMVd6ZjBCeHEra05hMkxD?=
 =?utf-8?B?YktGS3ZUZHAzOEFVbExnYjhkUjU2cDR5WXo1UXlhNnJkTW9GNVd1ZTlVZzNY?=
 =?utf-8?B?MjdwVVVJSUZlQmZUNm5PdjFiWWRnV0pBZER5ZGxNWWVlZGFXbjV3L3pZL3dY?=
 =?utf-8?B?dnNQVHJIN09YdStmZ3FLUE8vZm5JQy9VaXAwMmQ0ZDBXSlBFMDRlQysyUXg1?=
 =?utf-8?B?Y3FJSUNCM1pEQlI5MlYyQ1RvL1RGcTMxRjNnYmR5SzBDb09yZVFIaXpxaGs5?=
 =?utf-8?B?dFdMV3NUKzZXeEd3REg4Zktnd1NpRXZEVWpaK3ViVW03UVlyQXBjRlF6bkdt?=
 =?utf-8?B?K1NiT1h0cnAzS1IwN3B5SHdCWGpXeGtyVVhVREFkZXdoa2s1TWNvbk1GcUNY?=
 =?utf-8?B?YW1OWm1UY2hmZmpuMlZuczRndFN2RVRvL1BydnhuVy9kMGx5eGo3TWkyck9o?=
 =?utf-8?B?NXZEenpDbDIxZS9lTG1lQnJEWWozcFEvUW9CZnhtRG5XeW96a2U1RG5LZ01X?=
 =?utf-8?B?Y29MUXBhU0lGRzI2anlMb2NGaU00T1A0WDdiVitRQTFVWXV2UXlTOUIvZGxB?=
 =?utf-8?B?c3Jwb1pXcHJCdEJPYTgwSGVsVU5sNkVpSVp6bHd6bU8vWDFqR1hPSXdXb3ds?=
 =?utf-8?B?UUVEVnpDVUNhV1VDRjBZZVo3ZWh5aHprTk9jTmYyYzJtSVFqL3FGTXhRPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR03MB6226.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(7416005)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SU1HY1JaYmx5Q3lrajRTWFJ3bEdXeWYrUmlMdHF5MHBDQlR5WjZpOHVOQWxj?=
 =?utf-8?B?S28xcUhQRWw5ZzEwV3ZnU2tBd2kxS05EZGlBWldXdWZhdEQrTGdwcnhuZStm?=
 =?utf-8?B?azB1QUZWZ01FV2pVWFUyWHEvV1RNVnFVTHJleHV5eXF4MkhQVHNGMlROUzE1?=
 =?utf-8?B?VmJHS1NncU1mb0tDWFJLYUdhTFkyUWRMT1lkWU9LTFdlMHhvLzFlcXQyeEhX?=
 =?utf-8?B?RmR6SUFpT0Z3cUxsMk9wRUFiOHFDcVd3ZkIyMkQxbTZuaWQwOEFyTENzenN2?=
 =?utf-8?B?cStRb3ZSbGhha1kxR29UeXluL000SWNuVHFJZkEvYUpFNWVlNVU2Y3dhS3dv?=
 =?utf-8?B?aHhiTEJZZzE0ZFBYd0h6NkkrWGZTWWJmeVExcThRcU10MS9qZkJDMndDcnM5?=
 =?utf-8?B?YWpNZVVXNkZjM0lHRE1lUy9CeEV4RitBdElqYTRrTVRWbEhrcGdUUFhMZGY1?=
 =?utf-8?B?M3p3QUcrbDgyQXordENJNHdhTmo3aDlLODMrYlRvMml4eEJVY1NFWFl4VW92?=
 =?utf-8?B?WmplQkxlNlgzU1hMdXhoNXpId2xLb2VuREVXSGkzVnpTK1VrMXZtWFJjN3Iy?=
 =?utf-8?B?R0wwTmsyVW95SERJLzV4VHhNM3VnT0xwYTZSQnZOT2dLTEV4aS95RzJDdmpr?=
 =?utf-8?B?N1JLRVFJaXY5clJXazdtVm5kbW5QSWdrZ05Wa2VycEtsZEZpOTdtc3dIMG94?=
 =?utf-8?B?cHVvMEsrTHF3MnhjdVY4ekozV1J4KzJHZ1hjM3JydkRXU3drdFRCMmpPWDlo?=
 =?utf-8?B?WjYwbzAzdUd3c1RReDdMbkc5RERpUUdYVnovU0RLZUdZNERTWDYrN2Z4VzAx?=
 =?utf-8?B?bnQxYmh1aW1UN1pjY2ROTGh5SmRIOWphRXBLTjZ4REtlaXdnNVgrMGxmZkc5?=
 =?utf-8?B?cEEvbTJvMFVyczJGblkvVWZtR3dlUWxGV1RPYVdlOHJsTk4yZ05iTldJUkZT?=
 =?utf-8?B?dUdkblpRK0g4M29UMUttUmhVRmsvTUNXVUM0NHRTcFQ2U2t4VEh3Qjk4dnNO?=
 =?utf-8?B?dTBkY2Y4QlhuUEszZUljZFBTNlBOQ0d2YURKOEF6d2JaNVdLVEF1Z1VQb1g4?=
 =?utf-8?B?cFh4MERsR0VKcllQdEU3Y1huRFMxV1I4Q3QyZGhIc3NCbDBIcTY4RWxlOUdG?=
 =?utf-8?B?S1d3QWk0ZGtvcXE1TjBMc2l2a2hSYnNmOTk5cVY4ZzUyaG55Sk9FckRXOXNY?=
 =?utf-8?B?WFdWZ3lHd01sOGwwVkJsN2xuRHRuWWU3ZVN1U2xnNkxldE05UUtIZHdNNERZ?=
 =?utf-8?B?RVV6VG1DSzRvNG1ZZ3ZrOXpNZWRmOEVRMDh5U0IzYWZuQzYyN2ZKeXJYRmZ4?=
 =?utf-8?B?SnJneHpoUTlwSW11eXMzblVRdXFCdk5OaEttM0FOUzZkdkhneTU1QU9kbk5I?=
 =?utf-8?B?YTViTFkzY3E5dHUvTFNPODA4U0hXY2ozSzRvUWVkRncwdnBickd5ZmNsVzVL?=
 =?utf-8?B?blROL2MrZ2lHREI1Y0Ivai9DazRQNlNFeEhrd25ranE3WWpVc09GdllVUVBo?=
 =?utf-8?B?eXcwYmxKd2I0K2pPWGFIcjBqSVhtcmI1QzZsclFjYStHamxYRndBREN1eWVz?=
 =?utf-8?B?UXJscTI3UDRKWE9HT2VXSnAvQ1ZraGtxcld6aHAzU2xRV2trQStvUXR1VDcw?=
 =?utf-8?B?aVBUWm0yTVZPU21jQis1QWNUQWZWekViMmwrR3l6cGZZODVRYTBGOVozTldn?=
 =?utf-8?B?RlVTbUg1cFMwOVVXQnJldzZDbitrOFpIUjRKeVlIVXFkN0dXTXNsWjNIRm9Y?=
 =?utf-8?B?bEl4SFlrL0JCM25EUG9JcWtQNWttT3NETzg2SHhRUk1OVER5WDU0Yzlxb3h5?=
 =?utf-8?B?Z2lDOUp1UWp4U0dhczhxaUNQeTljaDJDd3BieVpmM0t3Yjd2Vzh1R1BlKzRZ?=
 =?utf-8?B?WkdXU2dEOXpkNzhuSy8zVkIrVVVFalFyUWFvRTRYakpEVXlXQ0dUY2VMOW9j?=
 =?utf-8?B?UUwxamE5aDc4YkRRZHhJUXQzbCtSaGc0NC85cFNDS0JxdDh3UjRXMVkwWVp5?=
 =?utf-8?B?OGdBUjU3c3ljUXcvQzJtZXIrbTdvY0ZYbDhWSkRma0RYTHFNMThSbUJrVThm?=
 =?utf-8?B?ZllTekR6dFR0Um5QOUhZSzk1aWt3OVhndmFQdDRuSTV2cG9SbkFxcGhxWitQ?=
 =?utf-8?B?a3prcFJpZUJXQktkS1hia3JuUCtGeFV2ZVFTeE4xRURrVlg0OXBMaTNYOXJQ?=
 =?utf-8?B?Umc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7129ED40843F724B8D23A281322484D3@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR03MB6226.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: beeeff37-37d8-4f19-6a64-08dc80c52f23
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 May 2024 16:25:56.7274
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Qswb6izFHuyIwcaZZhsc5fu/haPzbm9tmUaQLqu9Rt5ZChqwg7Psq3wBQ3R0tDIXniz0hTedWnWWjGU6RhplXQQYUjAoOEIM2tb01prAJ5g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR03MB6540

T24gVGh1LCAyMDI0LTA1LTMwIGF0IDExOjM1ICswMTAwLCBSdXNzZWxsIEtpbmcgKE9yYWNsZSkg
d3JvdGU6DQo+ICAJIA0KPiBFeHRlcm5hbCBlbWFpbCA6IFBsZWFzZSBkbyBub3QgY2xpY2sgbGlu
a3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bnRpbA0KPiB5b3UgaGF2ZSB2ZXJpZmllZCB0aGUgc2Vu
ZGVyIG9yIHRoZSBjb250ZW50Lg0KPiAgT24gVGh1LCBNYXkgMzAsIDIwMjQgYXQgMTE6NDg6NDRB
TSArMDgwMCwgU2t5IEh1YW5nIHdyb3RlOg0KPiA+ICtzdGF0aWMgaW50IG10Nzk4eF8ycDVnZV9w
aHlfY29uZmlnX2FuZWcoc3RydWN0IHBoeV9kZXZpY2UgKnBoeWRldikNCj4gPiArew0KPiA+ICti
b29sIGNoYW5nZWQgPSBmYWxzZTsNCj4gPiArdTMyIGFkdjsNCj4gPiAraW50IHJldDsNCj4gPiAr
DQo+ID4gKy8qIEluIGZhY3QsIGlmIHdlIGRpc2FibGUgYXV0b25lZywgd2UgY2FuJ3QgbGluayB1
cCBjb3JyZWN0bHk6DQo+ID4gKyAqICAyLjVHLzFHOiBOZWVkIEFOIHRvIGV4Y2hhbmdlIG1hc3Rl
ci9zbGF2ZSBpbmZvcm1hdGlvbi4NCj4gPiArICogIDEwME06IFdpdGhvdXQgQU4sIGxpbmsgc3Rh
cnRzIGF0IGhhbGYgZHVwbGV4KEFjY29yZGluZyB0byBJRUVFDQo+IDgwMi4zLTIwMTgpLA0KPiA+
ICsgKiAgICAgICAgd2hpY2ggdGhpcyBwaHkgZG9lc24ndCBzdXBwb3J0Lg0KPiA+ICsgKiAgIDEw
TTogRGVwcmVjYXRlZCBpbiB0aGlzIGV0aGVybmV0IHBoeS4NCj4gPiArICovDQo+ID4gK2lmIChw
aHlkZXYtPmF1dG9uZWcgPT0gQVVUT05FR19ESVNBQkxFKQ0KPiA+ICtyZXR1cm4gLUVPUE5PVFNV
UFA7DQo+IA0KPiBXZSBoYXZlIGFub3RoZXIgZHJpdmVyIChzdG1tYWMpIHdoZXJlIGEgcGxhdGZv
cm0gZHJpdmVyIGlzIHdhbnRpbmcgdG8NCj4gcHV0IGEgaGFjayBpbiB0aGUga3NldHRpbmdzX3Nl
dCgpIGV0aHRvb2wgcGF0aCB0byBlcnJvciBvdXQgb24NCj4gZGlzYWJsaW5nIEFOIGZvciAxRyBz
cGVlZHMuIFRoaXMgc291bmRzIGxpa2Ugc29tZXRoaW5nIHRoYXQgaXMNCj4gYXBwbGljYWJsZSB0
byBtb3JlIHRoYW4gb25lIGhhcmR3YXJlIChhbmQgSSd2ZSBiZWVuIHdvbmRlcmluZyB3aGV0aGVy
DQo+IGl0IGlzIHVuaXZlcnNhbGx5IHRydWUgdGhhdCAxRyBjb3BwZXIgbGlua3MgYW5kIGZhc3Rl
ciBhbGwgcmVxdWlyZQ0KPiBBTiB0byBmdW5jdGlvbi4pDQo+IA0KPiBUaHVzLCBJJ20gd29uZGVy
aW5nIHdoZXRoZXIgdGhpcyBpcyBzb21ldGhpbmcgdGhhdCB0aGUgY29yZSBjb2RlDQo+IHNob3Vs
ZA0KPiBiZSBkb2luZy4NCj4gDQpZZWFoLi5BcyBmYXIgYXMgSSBrbm93LCAxRy8yLjVHLzVHLzEw
RyBzcGVlZCByZXF1aXJlIEFOIHRvIGRlY2lkZQ0KbWFzdGVyL3NsYXZlIHJvbGUuIEFjdHVhbGx5
IEkgY2FuIHVzZSBmb3JjZSBtb2RlIGJ5IGNhbGxpbmcNCmdlbnBoeV9jNDVfcG1hX3NldF9mb3Jj
ZWQsIHdoaWNoIHdpbGwgc2V0IGNvcnJlc3BvZGluZyBDNDUgcmVnaXN0ZXJzLg0KSG93ZXZlciwg
YWZ0ZXIgdGhhdCwgdGhpcyAyLjVHIFBIWSBjYW4ndCBzdGlsbCBsaW5rIHVwIHdpdGggcGFydG5l
cnMuDQoNCkknbGwgbGVhdmUgRU9QTk9UU1VQUCBoZXJlIHRlbXBvcmFyaWx5LiBIb3BlIHBoeWxp
YiBjYW4gYmUgcGF0Y2hlZA0Kc29tZWRheS4NCg0KPiA+ICsvKiBUaGlzIHBoeSBjYW4ndCBoYW5k
bGUgY29sbGlzaW9uLCBhbmQgbmVpdGhlciBjYW4gKFhGSSlNQUMgaXQncw0KPiBjb25uZWN0ZWQg
dG8uDQo+ID4gKyAqIEFsdGhvdWdoIGl0IGNhbiBkbyBIRFggaGFuZHNoYWtlLCBpdCBkb2Vzbid0
IHN1cHBvcnQgQ1NNQS9DRA0KPiB0aGF0IEhEWCByZXF1aXJlcy4NCj4gPiArICovDQo+IA0KPiBX
aGF0IHRoZSBNQUMgY2FuIGFuZCBjYW4ndCBkbyByZWFsbHkgaGFzIGxpdHRsZSBiZWFyaW5nIG9u
IHdoYXQgbGluaw0KPiBtb2RlcyB0aGUgUEhZIGRyaXZlciBzaG91bGQgYmUgcHJvdmlkaW5nLiBJ
dCBpcyB0aGUgcmVzcG9uc2liaWxpdHkgb2YNCj4gdGhlIE1BQyBkcml2ZXIgdG8gYXBwcm9wcmlh
dGVseSBjaGFuZ2Ugd2hhdCBpcyBzdXBwb3J0ZWQgd2hlbg0KPiBhdHRhY2hpbmcNCj4gdG8gdGhl
IFBIWS4gSWYgdXNpbmcgcGh5bGluaywgdGhpcyBpcyBkb25lIGJ5IHBoeWxpbmsgdmlhIHRoZSBN
QUMNCj4gZHJpdmVyDQo+IHRlbGxpbmcgcGh5bGluayB3aGF0IGl0IGlzIGNhcGFibGUgb2Ygdmlh
IG1hY19jYXBhYmlsaXRpZXMuDQo+IA0KPiA+ICtzdGF0aWMgaW50IG10Nzk4eF8ycDVnZV9waHlf
Z2V0X3JhdGVfbWF0Y2hpbmcoc3RydWN0IHBoeV9kZXZpY2UNCj4gKnBoeWRldiwNCj4gPiArICAg
ICAgcGh5X2ludGVyZmFjZV90IGlmYWNlKQ0KPiA+ICt7DQo+ID4gK2lmIChpZmFjZSA9PSBQSFlf
SU5URVJGQUNFX01PREVfWEdNSUkpDQo+ID4gK3JldHVybiBSQVRFX01BVENIX1BBVVNFOw0KPiAN
Cj4gWW91IG1lbnRpb24gYWJvdmUgWEZJLi4uDQo+IA0KPiBYRkkgaXMgMTBHQkFTRS1SIHByb3Rv
Y29sIHRvIFhGUCBtb2R1bGUgZWxlY3RyaWNhbCBzdGFuZGFyZHMuDQo+IFNGSSBpcyAxMEdCQVNF
LVIgcHJvdG9jb2wgdG8gU0ZQKyBtb2R1bGUgZWxlY3RyaWNhbCBzdGFuZGFyZHMuDQo+IA0KPiBw
aHlfaW50ZXJmYWNlX3QgaXMgaW50ZXJlc3RlZCBpbiB0aGUgcHJvdG9jb2wuIFNvLCBnaXZlbiB0
aGF0IHlvdQ0KPiBtZW50aW9uIFhGSSwgd2h5IGRvZXNuJ3QgdGhpcyB0ZXN0IGZvciBQSFlfSU5U
RVJGQUNFX01PREVfMTBHQkFTRVI/DQo+IA0KV2UgaGF2ZSAyIFhGSS1NQUMgb24gbXQ3OTg4IHBs
YXRmb3JtLiBPbmUgaXMgY29ubmVjdGVkIHRvIGludGVybmFsDQoyLjVHcGh5KFNvQyBidWlsdC1p
biksIGFzIHdlIGRpc2N1c3NlZCBoZXJlIChXZSBkb24ndCB0ZXN0IHRoaXMgcGh5IGZvcg0KMTBH
IHNwZWVkLikgQW5vdGhlciBvbmUgaXMgY29ubmVjdGVkIHRvIGV4dGVybmFsIDEwRyBwaHkuDQoN
Cj4gPiArc3RhdGljIGludCBtdDc5OHhfMnA1Z2VfcGh5X3Byb2JlKHN0cnVjdCBwaHlfZGV2aWNl
ICpwaHlkZXYpDQo+ID4gK3sNCj4gPiArc3RydWN0IG10a19pMnA1Z2VfcGh5X3ByaXYgKnByaXY7
DQo+ID4gKw0KPiA+ICtwcml2ID0gZGV2bV9remFsbG9jKCZwaHlkZXYtPm1kaW8uZGV2LA0KPiA+
ICsgICAgc2l6ZW9mKHN0cnVjdCBtdGtfaTJwNWdlX3BoeV9wcml2KSwgR0ZQX0tFUk5FTCk7DQo+
ID4gK2lmICghcHJpdikNCj4gPiArcmV0dXJuIC1FTk9NRU07DQo+ID4gKw0KPiA+ICtzd2l0Y2gg
KHBoeWRldi0+ZHJ2LT5waHlfaWQpIHsNCj4gPiArY2FzZSBNVEtfMlA1R1BIWV9JRF9NVDc5ODg6
DQo+ID4gKy8qIFRoZSBvcmlnaW5hbCBoYXJkd2FyZSBvbmx5IHNldHMgTURJT19ERVZTX1BNQVBN
RCAqLw0KPiA+ICtwaHlkZXYtPmM0NV9pZHMubW1kc19wcmVzZW50IHw9IChNRElPX0RFVlNfUENT
IHwgTURJT19ERVZTX0FOIHwNCj4gPiArIE1ESU9fREVWU19WRU5EMSB8IE1ESU9fREVWU19WRU5E
Mik7DQo+IA0KPiBObyBuZWVkIGZvciBwYXJlbnMgb24gdGhlIFJIUy4gVGhlIFJIUyBpcyBhbiBl
eHByZXNzaW9uIGluIGl0cyBvd24NCj4gcmlnaHQsIGFuZCB0aGVyZSdzIG5vIHBvaW50IGluIHB1
dHRpbmcgcGFyZW5zIGFyb3VuZCB0aGUgZXhwcmVzc2lvbg0KPiB0byB0dXJuIGl0IGludG8gYW5v
dGhlciBleHByZXNzaW9uIQ0KPiANCj4gLS0gDQo+IFJNSydzIFBhdGNoIHN5c3RlbTogaHR0cHM6
Ly93d3cuYXJtbGludXgub3JnLnVrL2RldmVsb3Blci9wYXRjaGVzLw0KPiBGVFRQIGlzIGhlcmUh
IDgwTWJwcyBkb3duIDEwTWJwcyB1cC4gRGVjZW50IGNvbm5lY3Rpdml0eSBhdCBsYXN0IQ0KDQpE
byB5b3UgbWVhbiB0aGVzZSB0d28gbGluZT8NCitwaHlkZXYtPmM0NV9pZHMubW1kc19wcmVzZW50
IHw9IChNRElPX0RFVlNfUENTIHwgTURJT19ERVZTX0FOIHwNCisgTURJT19ERVZTX1ZFTkQxIHwg
TURJT19ERVZTX1ZFTkQyKTsNCg0KV2hhdCBkbyB5b3UgbWVhbiBieSAiUkhTIGlzIGFuIGV4cHJl
c3Npb24gaW4gaXRzIG93biByaWdodCI/DQpJIHB1dCBwYXJlbnMgaGVyZSB0byBlbmhhbmNlIHJl
YWRhYmlsaXR5IHNvIHdlIGRvbid0IG5lZWQgY2hlY2sNCm9wZXJhdG9yIHByZWNlZGVuY2UgYWdh
aW4uDQoNClNreQ0K

