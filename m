Return-Path: <netdev+bounces-132636-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B6E2D99296D
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 12:43:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 476101F2440B
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 10:43:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9F151C8FD4;
	Mon,  7 Oct 2024 10:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="rkN5nYOZ";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="glH4IjxF"
X-Original-To: netdev@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C96F14AD17;
	Mon,  7 Oct 2024 10:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728297823; cv=fail; b=LzUW/CcbbvSngLePo8aY6JprojjCkD3/q1lqs+6CSczi2UnGovlWZqWMy3yV6M6Gi2ePjtGdbwQUvqorbDd2UtQdLC6WRjxAMyesfnni02kcWWtjeA4IENxBJOyOlHaw6h3jIjhQRAOals2r9/mf4VR9Si3+DdUq8FgysmK/dNc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728297823; c=relaxed/simple;
	bh=SXflQEBl2vhlOgZiBxd8QC0rbIoF0aWnvbQ4Xpo6Hy0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=nOVMRuFFiHOoq8DcsfrD+rN2mkMwu7n3GpmaDfZUWl+SMjH5pimlsM7RfghNCAjulOCnSb3nSgipOVjXGJiyMoCWYSI5o1apUajXM+jmm5RDUJnmrqbPvAN5y09yCG4u42TDYgzz4+qcsUQHcSPcXrwVZxPfbXNUxK77lN4jZH8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=rkN5nYOZ; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=glH4IjxF; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 028856ec849911ef8b96093e013ec31c-20241007
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=SXflQEBl2vhlOgZiBxd8QC0rbIoF0aWnvbQ4Xpo6Hy0=;
	b=rkN5nYOZg+C/arprt4RGXSwSnPoFAQ9Z+Xmlu/8OCTuhqMmXBoYMr69TsHMuNCdBp3TFPm3heaWV3Yi5Yq8Yo4YeDP+AbAuHmVwdBLNmw3MEJTQvExbwRUTVTuzO/5QCYTdpF8MsxS7+5qmDlBg1J+0huGADV7nXltpkA7C1NdQ=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.41,REQID:f5297d9c-f2f9-4d52-ac84-7ca77b7be19f,IP:0,U
	RL:0,TC:0,Content:5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:5
X-CID-META: VersionHash:6dc6a47,CLOUDID:dad3df40-8751-41b2-98dd-475503d45150,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:4|-5,EDM:-3,IP:ni
	l,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 028856ec849911ef8b96093e013ec31c-20241007
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
	(envelope-from <skylake.huang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 2107316030; Mon, 07 Oct 2024 18:43:37 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 7 Oct 2024 18:43:36 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 7 Oct 2024 18:43:35 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k7NX+A9gvw197Ucii0SP8chM/fBjK0peAPX02v/o4XvXu/iHG1ekbqJsK09lqyAvoXEezoC4RFnvL3pKYuCYUV4yCuslqDEeo2XqmUhvC85PDsysWWb7sYu8W1nb7CUOXKWewKpgOQ2VkepxjD9I1Hr//pJSjd9G6SU608ryfJEzzQgmodNGMk30MzEFYyIocquXUcibZYptNKFmaS1lna43RLpXK3zyNYg8wuk+vXBLeM5/+nJUfwGRFkEaE9yZOs/2lg1myy6mGkJZAOZXLLcNc9nt2GMQZbzSvNHBTsZaA5XC8ml3bqoMNmhEfq906jeZiTPgIMWOndHAlcEYVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SXflQEBl2vhlOgZiBxd8QC0rbIoF0aWnvbQ4Xpo6Hy0=;
 b=KIJxLX/fnwTyEjnWqC/8Sl+Fu4+F1WS31aFZG8Skdi/ngbu2umqlX0DDxQMNDhCydIJpV0ZK9/kjTKUVp+ar3Ue2GWQFDKcMsOo5/hRAprp5K6hhedlOWBFVUamMuEZ172HhpdiK06/VKAcjDC/6DCqqBfIeOfYKyqAsrjnZtpAM2qgm41b0zC27GfOQSqlMCVksVFxKFcabRF5lMOZXdtkq+10+kAC9swbdq+IhxtotQNeh1fHVogKNfjRRH0VJvNTdyn8sc9b/k/DNUmXx2K2sPczsBH8FfYHNmyI7BpEWVto+5QNmNfLCXfu25Dw6SVc14eqD7+idab7NRfrOZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SXflQEBl2vhlOgZiBxd8QC0rbIoF0aWnvbQ4Xpo6Hy0=;
 b=glH4IjxFrBVk+ZQ9UbvGVTWEVO5ziBPyXJjJDUFeZegdlN307rZm2Sn/8qDcAIbw55TUneqXzShpxYiyX61Dysz8je0SU313G6XBCYy1FGWiC/0iPaTFuU+6a1GLGNGd0dyEsfbYY5exT6iw5mKCV5Mji/M/IEQr/xHjU1Yeyc4=
Received: from KL1PR03MB6226.apcprd03.prod.outlook.com (2603:1096:820:8c::14)
 by SEYPR03MB7009.apcprd03.prod.outlook.com (2603:1096:101:b1::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.21; Mon, 7 Oct
 2024 10:43:30 +0000
Received: from KL1PR03MB6226.apcprd03.prod.outlook.com
 ([fe80::f3:c11:8422:7ce3]) by KL1PR03MB6226.apcprd03.prod.outlook.com
 ([fe80::f3:c11:8422:7ce3%4]) with mapi id 15.20.8026.020; Mon, 7 Oct 2024
 10:43:30 +0000
From: =?utf-8?B?U2t5TGFrZSBIdWFuZyAo6buD5ZWf5r6kKQ==?=
	<SkyLake.Huang@mediatek.com>
To: "andrew@lunn.ch" <andrew@lunn.ch>
CC: "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-mediatek@lists.infradead.org"
	<linux-mediatek@lists.infradead.org>, "linux@armlinux.org.uk"
	<linux@armlinux.org.uk>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "edumazet@google.com"
	<edumazet@google.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"dqfext@gmail.com" <dqfext@gmail.com>,
	=?utf-8?B?U3RldmVuIExpdSAo5YqJ5Lq66LGqKQ==?= <steven.liu@mediatek.com>,
	"matthias.bgg@gmail.com" <matthias.bgg@gmail.com>, "davem@davemloft.net"
	<davem@davemloft.net>, "hkallweit1@gmail.com" <hkallweit1@gmail.com>,
	"daniel@makrotopia.org" <daniel@makrotopia.org>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH net-next 6/9] net: phy: mediatek: Hook LED helper
 functions in mtk-ge.c
Thread-Topic: [PATCH net-next 6/9] net: phy: mediatek: Hook LED helper
 functions in mtk-ge.c
Thread-Index: AQHbFkhCYquJAKYq+0u+Cq826/eVErJ6QcoAgADdIgA=
Date: Mon, 7 Oct 2024 10:43:30 +0000
Message-ID: <b8f2736312bf424262e2327a711c0366da2ce18f.camel@mediatek.com>
References: <20241004102413.5838-1-SkyLake.Huang@mediatek.com>
	 <20241004102413.5838-7-SkyLake.Huang@mediatek.com>
	 <3e27eddb-91c6-4903-9de5-f3df8098a38c@lunn.ch>
In-Reply-To: <3e27eddb-91c6-4903-9de5-f3df8098a38c@lunn.ch>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR03MB6226:EE_|SEYPR03MB7009:EE_
x-ms-office365-filtering-correlation-id: a68477a8-928b-4c31-c73e-08dce6bce232
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?SXR2eFl1UWRlaVZTd3ZRcWllVFpTa1ZJNWdaMDZHR0k2eDJISDk2TDhvMG9Z?=
 =?utf-8?B?TDlxdmhoUmhBaERYbURaN1hyb0E5VEVNY21xUjZ3RURYd1VYd2wxMjBmQ0tR?=
 =?utf-8?B?ZGsrRFUwSDNJOVVCY2VIanljeTJ2SGR4WWszZ1Z4Z1hrTDk4OGV5MldrSFQ2?=
 =?utf-8?B?VmMwUldiVmdwRzZkNmRTR3ZTWkYvV1A3NjBaNEYwOCtscWdIZWtwSDkvRTFD?=
 =?utf-8?B?QmdZME9IY3RONWR6T1ZhQmhXakVDZUdXZ0tnR1hrYjdNWXdRZURRYlM3Ukhm?=
 =?utf-8?B?VjdPd29MQStwaUp3TDR1SFNFOGZ1Zys4bXV6ZjlWZ0RsN21ZVUhGWGNuOHJB?=
 =?utf-8?B?Q0V4Q0cvRU4vWmNGbDdrZE1YSzltRVBwVEpnZFJhNzlnRDU3d2dwb3hLWVda?=
 =?utf-8?B?TXpTTVlScFo2TTBDZGZZdmxTM0IvZWFSTEk5YytYaWtrWXhNemp5MEFhT3di?=
 =?utf-8?B?VWw2YTduRDlvVjB2bkpLQ20wN1BjYlh4bVNNZHRpMzB4bDZxZytIRE1qWkJk?=
 =?utf-8?B?NWREUTdHdi9CemFPd2pNR3JxeXEyL01iRG5UR1VOd3hIV256RStRRTJ0ZGJi?=
 =?utf-8?B?U3RjOVlJckRZckJOSGlTclo4SXZ5T21TdGRqOFZTNnBYRm42cmdrZGM3Smxy?=
 =?utf-8?B?MUVhSnQwTWF6M0xCZjZkZUdBd2lPOW5rdjRrVFgwb0VTOTNXUnEwL3BkWlRM?=
 =?utf-8?B?NlpseVhKMUFzQ0lXRWRqS293Q0l1RzBGTjRDZ2ZDeFNIazZsQmhPRjArMmV2?=
 =?utf-8?B?OUVFcmFZWGVJbVdjWlIvbXZBdUxpMEtSQzlEeUlndnhpUEhEREFrU2pzemNP?=
 =?utf-8?B?Q1JhRm1JSUIrcTFLS1V3SEZyTnBOcmpwdVdOYmZvSmtPdVpyYXZjUDRTNmkw?=
 =?utf-8?B?K0YrMWJHd1hKcUc2cFlMWDNlNXZ0UE5scGNYMWNCSlU5LzRNOGtFQkpib0tt?=
 =?utf-8?B?N0RGQ0tjRHVCTVRGK0ZSOHA4Z2xTMHdTMEtlME1Rc08xQnlWeHBYU3cxWjhu?=
 =?utf-8?B?bjlEOW54c3dOUXg5Y29rYVdHdDVRNmZIdnNsSTZobFg0cEUya3hWTDJvUVRa?=
 =?utf-8?B?eEp1ZC9zSGtUY01aRkRPeXovL01mUXhTVHNsQ1RPZG02OGFyd0dqbnZ5NVhC?=
 =?utf-8?B?NXBIYjBLWXIyOUFuYUNjMmVNZEVydTJJMEljM25rbWtkQnVVN1J3OWhwbHFF?=
 =?utf-8?B?ZGZUK20zZ2VtR3pBQkd4OSsrcHhyZzBDbWFMNXNiUDNoeHRGZHI5dis4a3c2?=
 =?utf-8?B?S2ptSHIyazdIRklrZ0dkTkRZNUY1ZlEySzZhZFIxY2kxcnNab2lObkwyR0NE?=
 =?utf-8?B?RklvM2NNT1NjUHZ0K2hpSk9uczQ4akkrdnZUOXpMSVJTVDFTS3U1QUNvSDUv?=
 =?utf-8?B?Q094b0lCWjFiNU5OWTYzZGNyU2dQM25pM1J2ZDBMSkIwNkw1Q2p0K2t4SWxk?=
 =?utf-8?B?QTlCN2E0MjdXWHlZVEQ2QkUrSzlyTkRNUE1xRzZDU2R6N3lZem56RFI4MWlC?=
 =?utf-8?B?R3dIVHNucWdMZWxiVWk1OC9lNDZtcngyT3ZEQit1aDROZU0rUTMwVHFaU0Zk?=
 =?utf-8?B?SzRzTE5QMFUyS2NLYWU4U09ZMjFNQnJya0xaWG1wRGg4UFlJRUU5ZFJZdmJ3?=
 =?utf-8?B?R3BpNkZ1dXArWkhpSnNiamZ4L0JlYU56TkorRG9VV0tBeEhVTXJDNzhRaGVz?=
 =?utf-8?B?aStPTmxDUVJteDBFNmh3Zzh4Yk1aZVMvbWtVSFZYNll3dTdna3QzQ0YzZENi?=
 =?utf-8?B?NWtxTjdXMGtyVldhd0Y3L2ttMytRcHoxeFEzbDd4U2p4MVd5Tms4SGVkdW9S?=
 =?utf-8?B?UXpzYzV3d1ZDclBoUHJkUT09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR03MB6226.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?S1VFR0RXWC9id0l3eGFra3YrWngyMTBBSk1KTW9mVWdieC9XR21jdVFwcDJr?=
 =?utf-8?B?MGVqc3BrYTk0d3VtTWMxSkJaUFVDenNsSEJzS1lueDlENEJXQk1wdzZEekhz?=
 =?utf-8?B?cnRoZ2NveUxxQ0d1czBEbFJJTWMybmVGMWZyRS9xM2l6L3VBbU0zYkFnNnEy?=
 =?utf-8?B?NkZBanVHOTRScXp6SHBYVTRGV29LT2ZPSThuMjU1U254RUFWOXR4TGJVOUJY?=
 =?utf-8?B?MFF4S2UwSnYvOERROE1zZy96MGM3QU9qR0tLaUZaVkVnZlNUdGt3cXFPUmgw?=
 =?utf-8?B?UXg3MkJpZWVGVXBFNENldXVLa0U0Sm1TRFdzcWNaSHBSOXNXZzRaUktBQnhz?=
 =?utf-8?B?L2FaYWtaM1JZZ3I3L2ZGZVZFSmZPdkpMN3pXaktSWkpTeTA5RENJdlF2V0pD?=
 =?utf-8?B?cktiUVVVZVpITmlXMFFBQ25sL01CSllWajJTS1hUSEVybkxxNnNqUm1WMnJ0?=
 =?utf-8?B?ejFPditCbXZDOHF1N2hzczBmeXlPS2tvZW5nY3hVb1VOVFdHUVMzWjZEVzdw?=
 =?utf-8?B?ME5yMUhrVEF0bHc0ZXptb1gxTmxhMzdDajNPTjUvZXd4TlZPdUNVd3hBYVI3?=
 =?utf-8?B?QjJxVnNESUFsVC9LRVI3OGJxMisvTXgrMW9EYjYwTWZ0ajNQd1ZsK0dYamhl?=
 =?utf-8?B?dlhYZHFqcGhKRWw0SHo1VmJuSWgwUmdqanVuS3ZyQ2Uyc3J6UEx0dEpRSWxE?=
 =?utf-8?B?dGx6RkRueEMrbDhDVEsvQVJqc25nZVByNEw1cDdtd3ljc3hTMHFUSFB0R1VE?=
 =?utf-8?B?VTF5RGFseGwrbmgwOWRoRDNPdHlPSUl1dUgvVWM5eTFxMTFrRWRCY2dBc1VT?=
 =?utf-8?B?RWtYeTEyVXlxYnZNYmp0T0t4R1ZyQ1lzWWdTeTBrcVJ1OHMrZm1RL0RGV1hH?=
 =?utf-8?B?RG5CM3lyTHJYSEZFMEhnYTU5eG53QzFTOWNMaGFyRENLcUpqQ2FhUTYydlg5?=
 =?utf-8?B?SlgxSWpraldiK1FjcVlPcCt3eERiM2ZXOGx6MkM1NENuTlkxT2x5WGVkNWVy?=
 =?utf-8?B?eEo2SGVqVlYrMmlZZTdkc281d0RxVnl5NE05Y256Rmp2N2oxUTA0dUhmSVdh?=
 =?utf-8?B?VEdTaS9IZUxaMzhJSVBaaWY0aVF3cUFESWdTQ1B2Wm1nbVF4endDamlNejBN?=
 =?utf-8?B?ZitTNlB3WkJaQk5kcDRYU2t3TGRoYVoxdm1wU3labzc4N1hwZ0g2RGViV3Za?=
 =?utf-8?B?a1QxYitTV3BKN1ZhdjFuQksvRlpXN09kUDBJR1k3c0o1NlNtaEoyUlhLbHdN?=
 =?utf-8?B?MlEzZ29GVE5Zc2JaQS9KbFh5YlgrSDZXT0w0cS8wL2RMSGI4OGtCK2Ztcnly?=
 =?utf-8?B?d3VxbWpsUGlSbkc3VWNwMk1oSUJFcVJsb1NoditRajBWUFBRSU9sNzkvVDdU?=
 =?utf-8?B?ZkFXVTFmMmxyRTJUbkdxVkRjZ1RJK2hFeXQ2ZUt6U0N3S0p0ekM3UzFMZjdV?=
 =?utf-8?B?YXNuMXcxMk1jOEFMc0Y3eUo4SmxjSjQ2c0xqWWZVV1NnZ290MHBLT2hGMnZK?=
 =?utf-8?B?eHp6bkc2OGkwNWpXYzhRZG0wV2tuTU0reFNyUzdMSytMSkhKcFNwRjArRHNB?=
 =?utf-8?B?dWdMTVZsNWJKSU1XS2xaZk5IM0FJVFZyS2kwUzlQNmw5RG1LcVUyZ2VHVmRI?=
 =?utf-8?B?VHRyOWNEUVduaXVwM09sVW10cm1TRzExSk00VWJGUW5Ec3A2US84Z3MvT3RX?=
 =?utf-8?B?a09ySTErS0Z2WUhpUUtXL0RlaFhBeHVGK2ZJemh6bkFGdmtJS2VMTUU0ZHdC?=
 =?utf-8?B?bEdIcGdmT0IvcSs5OGJTWVBTd2xSU2cwTVRoRFdSNVpGckZrYVA2VFp0Q3FC?=
 =?utf-8?B?bEZUcHVsb0VZekhuaGpTaTUwNXIzcGIxKzc0Uzd4dllTL21SeGxaemJGclkz?=
 =?utf-8?B?Tm05NTRzazRnOVNUSXpXaERRR1oxOTkwNU0wYXV2eHFRTWJ0Q0d1R2sraWZl?=
 =?utf-8?B?aVpSU3BwNHZqamxhT0hINytWcUttYjhGL0NaSmNyb2p1TVdqTnkvV1hIMGk3?=
 =?utf-8?B?ZDlDc2Mwc3FheDBheVZjRmVvWnNkbEtrWElZS3pjZ1UyR21tZ05aSnFUYjlC?=
 =?utf-8?B?TU5QSlNxZ3NhSGE2SllwOGZmTGFMUkdPdXRwVzJ1L3l6V25BdEprdStybTJ1?=
 =?utf-8?B?dkVQWkp5RmlocHVSSG5aQy9Zb2p5akNMR0YvMjl1SnhHVDN6anhiRGhtV0Uy?=
 =?utf-8?B?c0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4FB656BB3589AF418F24E378C58EC3B3@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR03MB6226.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a68477a8-928b-4c31-c73e-08dce6bce232
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Oct 2024 10:43:30.2548
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dfOFOFWbhoc1uyQ4QZJjyJ9tLs0LtLcdvjCP3SeNXlf0E8mn0KhUC9kFt8mZjJ1VcMDIV413jIVtY/k+gWMmJhVDK4ZOy4mrOBIE9AWdT2g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR03MB7009
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--17.524900-8.000000
X-TMASE-MatchedRID: TDQWNTPftUDUL3YCMmnG4ia1MaKuob8PCJpCCsn6HCHBnyal/eRn3gzR
	CsGHURLuwpcJm2NYlPAF6GY0Fb6yCih5A3bWOsipTXYizR8Ym5e5+1figft3Lp722hDqHosT56y
	iAZYPrXfZgnfo9CmRvHotqe6GyX/IYYF7llze03aeAiCmPx4NwMFrpUbb72MUZYJ9vPJ1vSCMa+
	I77rKoOxMQLQ/0+9hG3QfwsVk0UbuAUC1moT5enH7cGd19dSFd
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--17.524900-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	FCF9298D18B069711FFA785A9D92F1B3398B759ABE955DAF28C348060C35DF082000:8

T24gU3VuLCAyMDI0LTEwLTA2IGF0IDIzOjMyICswMjAwLCBBbmRyZXcgTHVubiB3cm90ZToNCj4g
IAkgDQo+IEV4dGVybmFsIGVtYWlsIDogUGxlYXNlIGRvIG5vdCBjbGljayBsaW5rcyBvciBvcGVu
IGF0dGFjaG1lbnRzIHVudGlsDQo+IHlvdSBoYXZlIHZlcmlmaWVkIHRoZSBzZW5kZXIgb3IgdGhl
IGNvbnRlbnQuDQo+ICA+ICtzdGF0aWMgaW50IG10NzUzeF9waHlfbGVkX2JsaW5rX3NldChzdHJ1
Y3QgcGh5X2RldmljZSAqcGh5ZGV2LCB1OA0KPiBpbmRleCwNCj4gPiArICAgIHVuc2lnbmVkIGxv
bmcgKmRlbGF5X29uLA0KPiA+ICsgICAgdW5zaWduZWQgbG9uZyAqZGVsYXlfb2ZmKQ0KPiA+ICt7
DQo+ID4gK3N0cnVjdCBtdGtfZ2VwaHlfcHJpdiAqcHJpdiA9IHBoeWRldi0+cHJpdjsNCj4gPiAr
Ym9vbCBibGlua2luZyA9IGZhbHNlOw0KPiA+ICtpbnQgZXJyID0gMDsNCj4gDQo+IFRoZXJlIGlz
IG5vIG5lZWQgdG8gc2V0IGVyci4NCj4gDQo+ID4gKw0KPiA+ICtlcnIgPSBtdGtfcGh5X2xlZF9u
dW1fZGx5X2NmZyhpbmRleCwgZGVsYXlfb24sIGRlbGF5X29mZiwNCj4gJmJsaW5raW5nKTsNCj4g
PiAraWYgKGVyciA8IDApDQo+ID4gK3JldHVybiBlcnI7DQo+IA0KPiANCj4gICAgIEFuZHJldw0K
PiANCj4gLS0tDQo+IHB3LWJvdDogY3INCg0KSSdsbCBmaXggdGhpcyBpbiBuZXh0IHZlcnNpb24u
IFRoeCENCg0KQlJzLA0KU2t5DQo=

