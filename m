Return-Path: <netdev+bounces-154959-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F632A007CF
	for <lists+netdev@lfdr.de>; Fri,  3 Jan 2025 11:28:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 76B317A1AFF
	for <lists+netdev@lfdr.de>; Fri,  3 Jan 2025 10:28:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFCBC1F8EFC;
	Fri,  3 Jan 2025 10:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="iO35CLs5";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="VAHofCEQ"
X-Original-To: netdev@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE7B51B6D1A;
	Fri,  3 Jan 2025 10:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735900083; cv=fail; b=UCMUJLxX7xOLbRxp0z8BvM+JkvorNDLF97ViQ06ESHcCpCgBONrn4Z24+gKNWIKEUjabDxk9Xqo8XBXQmSQY+6GL7qhpRPr/dqn6/kmcwukPXx8fo6dtAqbJDOwGc2ClTuTaNVSIiBSLXlaveAbH93tghZ+yQgpYyNK7fnm3Mzs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735900083; c=relaxed/simple;
	bh=FGjBKqwi88LoIrvYFiklSCzjJjJFHdUoUhvT3UJCVMY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=avb0Pb6LuQPYSEcI4P5SrO8iQEAvXN2XeczOydVOFfw8Vl7XVvFAbRL4gVA52kuO4EAABp6XQjYVYKwCfZhreqBqRYN2aCnwDMM0Iv0T8q2l1RK7xkdBmBEmedexEvqeXfeRnjQwaJvXVkM/DJwbnQBeH01qBWG/f36DlskeA1M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=iO35CLs5; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=VAHofCEQ; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 642262e4c9bd11ef99858b75a2457dd9-20250103
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=FGjBKqwi88LoIrvYFiklSCzjJjJFHdUoUhvT3UJCVMY=;
	b=iO35CLs5KY2LHgXwXvqUXFO2041WByHj2/M/hSKoqwh/MLYDK+5HjJgCLsgjoJNIjnAEq5UI6ko780SgW/SwS+/Di5x6C9bnZskjVZXBwknEU6l5E0ItbdRHHkc2wVQ1lJsTuQFLuGuSDWLCOVBgtut8Mi5NdcbRxZRZuBG4ADI=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.46,REQID:2ee7df43-7c04-432b-83d4-87123a72f1da,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:60aa074,CLOUDID:ec6d9c25-8650-4337-bf57-045b64170f0c,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102,TC:nil,Content:0|50,
	EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OS
	A:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 642262e4c9bd11ef99858b75a2457dd9-20250103
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw01.mediatek.com
	(envelope-from <shiming.cheng@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 2140708674; Fri, 03 Jan 2025 18:27:53 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 3 Jan 2025 18:27:52 +0800
Received: from SEYPR02CU001.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 3 Jan 2025 18:27:52 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j4M0AAmav85xps/x+3j6vpbJdTjAgf1XkTKiujXK8SojpS9y/tHgm1tL5ZW7WRqCGLn8ZJ7uEX7b2TH/rznGvfgJiP9yImhPeG/xBP5fQjk44UXLaVQyM2hnqav11j0ueMiM3eN5RRsQ1oeoJtnW0552dlSe6gy4Y2Q5SmByB6swylM+cGsWKBU1iBXbbazM8ZIzScZiix/o/LTw2vyxtCDR7gQPyU7goXzKk+gse8tGDoK+LTIfxkVIqNYzgBF6JNTSzVM0PUGnDvXQFx9fEpP6p/RIJ7crQRYnpfM0zAPh+Va/8MbL7/sOlY2xEqRI2VA+y4f8ziSGPTHOEjOClw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FGjBKqwi88LoIrvYFiklSCzjJjJFHdUoUhvT3UJCVMY=;
 b=utmlPZtFVM3Oc0PwkUsAHXUR2LnOGgh8o8vtWoVfU0eSRv0GIGuqrqIgLK0NBwzBXmy6VPwr9tQ6NC3vAhAUgnW7FWi2Y7aYmVxIG2wyn9OTHbBD2CLeIuGYcE+K4qzsb736S1+kT7POhOajYoqF55l+U23yidrSFLWmkoMcXMpqTpu2bOGQxNyo1Uv7v7Y1/B9bbY6lKIF7qnsj8b1XIOUoQJxvtQspoo2YetfOAN/m5rd6LuVOq+NPaOgtBvRN/YjGYe6DnINHO5bcQGIYYabCdeUwPfx9uUO8DZ/5lKDozqXh46DH953fofbJW17t9lq8ThKh/TmRp8rWJH9i0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FGjBKqwi88LoIrvYFiklSCzjJjJFHdUoUhvT3UJCVMY=;
 b=VAHofCEQCvFkLxxjbhc2GqTy0UXTSX6cMoHvT6kIWbyyyYF7mUFMtCLOyizxwQ4xbC21UXYSURSCXhL6K74ibsCnKe1RqU+DxezV2mJQy+sRbBeaE/pMiXbGav7KnaOgQ/q69XuQkeVGbk2/QPsA1p/1MISBSftnSFee+FXSm7U=
Received: from SEZPR03MB7958.apcprd03.prod.outlook.com (2603:1096:101:17d::12)
 by SEZPR03MB6891.apcprd03.prod.outlook.com (2603:1096:101:a2::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8293.19; Fri, 3 Jan
 2025 10:27:47 +0000
Received: from SEZPR03MB7958.apcprd03.prod.outlook.com
 ([fe80::4418:55b7:fe04:f3f2]) by SEZPR03MB7958.apcprd03.prod.outlook.com
 ([fe80::4418:55b7:fe04:f3f2%7]) with mapi id 15.20.8293.000; Fri, 3 Jan 2025
 10:27:46 +0000
From: =?utf-8?B?U2hpbWluZyBDaGVuZyAo5oiQ6K+X5piOKQ==?=
	<Shiming.Cheng@mediatek.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"dsahern@kernel.org" <dsahern@kernel.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"horms@kernel.org" <horms@kernel.org>, "kuba@kernel.org" <kuba@kernel.org>,
	"edumazet@google.com" <edumazet@google.com>, "pabeni@redhat.com"
	<pabeni@redhat.com>, "willemdebruijn.kernel@gmail.com"
	<willemdebruijn.kernel@gmail.com>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "matthias.bgg@gmail.com"
	<matthias.bgg@gmail.com>, "davem@davemloft.net" <davem@davemloft.net>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	=?utf-8?B?TGVuYSBXYW5nICjnjovlqJwp?= <Lena.Wang@mediatek.com>
Subject: Re: [PATCH net v2] ipv6: socket SO_BINDTODEVICE lookup routing fail
 without IPv6 rule.
Thread-Topic: [PATCH net v2] ipv6: socket SO_BINDTODEVICE lookup routing fail
 without IPv6 rule.
Thread-Index: AQHbXaIcTtnwFPYChUWrZVTAQZ/kp7ME2d2A
Date: Fri, 3 Jan 2025 10:27:46 +0000
Message-ID: <76edb53b44ba5f073206d70cee1839ecaabc7d2a.camel@mediatek.com>
References: <20250103054413.31581-1-shiming.cheng@mediatek.com>
In-Reply-To: <20250103054413.31581-1-shiming.cheng@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR03MB7958:EE_|SEZPR03MB6891:EE_
x-ms-office365-filtering-correlation-id: c3bfea04-805a-4f7c-b4b4-08dd2be1442b
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016|921020|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?NXVrNlhjRVFFQzZQbXBPWjRwdW1hVHF5YzZOQ0J0Wjg0bFFrZ3RNQ3A0R0wy?=
 =?utf-8?B?SFZHUk9HV1RTNitCY0IxcGxkdHVUdWNocVp0VHJWUHFIdkVJYmd5elFRUG9i?=
 =?utf-8?B?TmN4NEpSQkdWeFNMTlRjVWhxRnM0UkJNNjNEaHZxY2N3UXlXdmNGVmFrakI4?=
 =?utf-8?B?cENzeTBvUVkyWWZYRmlybWdYK3BZMkl0akVGMC9MNEJHREtkZDBnb2dobkQ3?=
 =?utf-8?B?VFJtd1hYcERSbU14Q3JhcUQvY2Y3UDEyQzRkZWl4YmNkUDZMcDRVd2QzRTFj?=
 =?utf-8?B?cHdrNnBTaWtLZW5udVJmWDlxQXJPMEx1MVN3RGNlMlA2RzlMdTk4cTlOVUZx?=
 =?utf-8?B?NHpObU8yUEQyS050MmV3UVZzMDFCV1VKMFJnUG8rWHl4WlJ2RWRDZnRpOXd4?=
 =?utf-8?B?ajNqcldITUhYWnNSZ3p3TnNuV3hyTFptVUV1S2NQTXFZWkRqSXFncUZTT3BW?=
 =?utf-8?B?eHVPQlhjZzVjb0t6NkQxaHRlV0hIc0tYa1pVSTZtWHpqZWVkYm5xazMvR3lz?=
 =?utf-8?B?alZRZnZhcmVXNlNoRmp6NW0vL3BjVzM5VjRyMXkrTHJTOTVwWVA5clBJWXVl?=
 =?utf-8?B?R1dyZEZVQWNKUFZTQThWdVJQWU0vQTFkMmRHRW9hMmp5dUJuQzJWLzR3dmlV?=
 =?utf-8?B?Qm43RVNTaWhtWWpnVkZpYlRIcXBJcGUvdWVXQlYyY2JpUHBabUJGZ04yTTht?=
 =?utf-8?B?bG0wT0FUclBpL0UvU3RqeHNWUVZQbjN1c2YrMjFjQ3JXTFpQZkhzOURvNjFu?=
 =?utf-8?B?L3N0UTVodUNQR0FNTUV4RTM4ODFIbG9BZWpqZEtGbER3eCtuUzVxenR0OWtl?=
 =?utf-8?B?TVRvUTlwMFBiRGM4ZzZZc1o0bExkYjQvZDZUL042SWkySFFLMkg5dDZibW9a?=
 =?utf-8?B?L1BiMkJDazZZOFAwdi9SWDFwVExSRG11amFZb244U3o5TjRmS3ZISStCcW5U?=
 =?utf-8?B?UFczUFFtMkRFS2ZpUzF6alczWUpIa01hMDdyY00zU2FVNXpOQUhTdElzYkVH?=
 =?utf-8?B?R1NTdTlBam41MmlQQkordVlPTEFvZHViOTRJLzM3Y2dWOGUzNjhiVG1oMmdj?=
 =?utf-8?B?czV3QUF4NXREVVpyanRYeVoyMmJBTlZoN3pkZkwzdEhVV0JVcUhqanptWUhU?=
 =?utf-8?B?RG9SS0lOVUJmNm12bjVyT2o0cGlJTVFJbWhNWklIMWpZVUdRbnlvZExSQUIz?=
 =?utf-8?B?V1d3OGlrQUdjNUZYaldjNWo3c2Q3cWFoeExvVzlwUE1henExSUVLZnZlZVlV?=
 =?utf-8?B?cWdzM09ZcWVNdWQxbEdLWWU3ZC9SQ1NFR0xsQ3NJR3VHOUl3bm8rRVVnSnNu?=
 =?utf-8?B?QkN5djZwMWxITGlob1VWbXNPMVBwSDJFVzNYa2VzaXU4dFFUbGpWNHAxT0lJ?=
 =?utf-8?B?YUErNTU4TEo0V2N0ZUg4YkZGZGtTYlZDd2s0dnczcFdPTEQ4Q3RUb2gvLzNV?=
 =?utf-8?B?bkZhNUlvdUdrODJsV1pnanNkTmRMeEVybnQ4Yyt0YzFWaUY1YXYzcFRUMEpX?=
 =?utf-8?B?SDg0RXdVL3FnL2Y0Vk55bkk2RGw1RUZqVC9JdDZlU2JaVjJmdGlIMWtOcmxi?=
 =?utf-8?B?UGszeExuYlZlTncySDlBRWdpN1RXb0k1dHNzei9MdmRDOVhxbG5GUFhOcU92?=
 =?utf-8?B?ZVI1dXpFVkNwWG5Oc1ZNUkMyekZsY1orU2lYa2pKYW5QeWhDeld2SkFjMk8v?=
 =?utf-8?B?S2h5Snhwd0EvZmVXUWFXLzdJTUU3Rml2NGxUU1RnaHNHYlRqNUQ5Z1JZSEoy?=
 =?utf-8?B?aFFVVUpzQjN6UEJvaEsyN2I5M3M3OTJ2enE3ZnM4bUJJZHBLRlVVZy9lcW0x?=
 =?utf-8?B?RTdaeDA0WnptaUlScjY3dW8xc3VkbTlDdGtOeDE4bXI0NFljNWt6MnR5SUdC?=
 =?utf-8?B?QlVDb084UkR5YlVLYlVNUllKSnpIOEFvNUtzOWxJYzdnQkk4WkVyL2dtL0xW?=
 =?utf-8?B?cnNlbnNUZVBJRHFXN1FPM2tLWTljZDkwcG41bmsySFRacjlhQ052TzhXNFg4?=
 =?utf-8?B?MWhTMkptaitRPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR03MB7958.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(921020)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?djI1a0YyTWtucStsNC9wRDEzSVJlaFh1eHFyVGllVENBVFRyN0RidUpxR0E2?=
 =?utf-8?B?cHFUcWlaME40UGRxc05XTFZZNlRGMVRjNGFkSDNSUzJTZ00rbTJOTGFVRXRU?=
 =?utf-8?B?NU1PdUtlZFh0bHJTQXdUa1pxMmtzcTVtdTJEMnAvcmVNcGtGQThBaUloYms2?=
 =?utf-8?B?Ymp3Uzl6dS9QY0hUVUdqbzB5aUtrM2t1NEpLTHkwRWpZSFYyTnZHdEM1K0VZ?=
 =?utf-8?B?SVkrWEwwOWNtZ0hSamk4cDNmdnpBaENnUCtWbGRoQlpzS0hZSnlvS1JRaUNs?=
 =?utf-8?B?YmcvMkZSQmtLMEV1RFZ1aW5SS1V4Mml6VE5hVkJCOWlqcXl1TjgyMERLZTdl?=
 =?utf-8?B?OVRjQW05Q3RzK0h3WGRHY2RHMkdjOWVXbGhXY204eGd5Z1VWKzhjeit5OUsr?=
 =?utf-8?B?NkVEenZiZE5yT3VzTEJwYWlkVWpzZlBoS05ya3RvLzFCU2hhWWJKRndUN1J0?=
 =?utf-8?B?UjdpZGpDcWcwKy9Xa3c2ZjdJblBON0hYZFQ4Tk1qbU0xVmJEOXJGdmdGSFdj?=
 =?utf-8?B?RDFNUVlKQW9kVlV2OGcvRkFvNEUwLzlKT3NUMFA3R2l1SVNueDhyK2ZldmpS?=
 =?utf-8?B?akFaUE40aWlUa0xyZjRWTjJ5TGxubUlNZWVEOTB2bUdIWWV2TGh3MUJvZW5C?=
 =?utf-8?B?d21PM1lrZzZOSDlCWVlVQ0ZTTXJsMXUzWHl2VGFPVDFySi9ZMnFuN0V5bWpn?=
 =?utf-8?B?OExZRExoSGdmUlFFUHFUbnVzWFd1eVBBZW5CTldsZGkzejF3K0RWeHNLVkJh?=
 =?utf-8?B?SE5yeCttNE1iVlJJaFd1TldoZEQzMUZ0bjJVUjI1ZEVmMDV3OXdNeUhuc0d2?=
 =?utf-8?B?NzZ3M1NYd2FlOTdkUjUxbS9WeXFZZXBvdUg2Wkt3S0dTeFRIVjVXNlV5WXhL?=
 =?utf-8?B?aEl0ZVVmVytzb1hQT1A0azdJM080SmVNeVVKcmNDdk9abUFhNkNaM0RvYXRt?=
 =?utf-8?B?cEYra09vKzRSSFdhQXROek9vaFQ1alAvUE1xT1AxZW81ZkVlVUFsMVNFZDhj?=
 =?utf-8?B?Zk9idkJmRDJFZU1ycks3dnAxMXUvOUR5UHpMUGMvS3k2bU1nbWdVTEJhRGEy?=
 =?utf-8?B?U2N1MFB5VzlHQmlROUdlR0lNdzYvaGoxcUg2bzZOR1VhV3NjcytxajBYUkVJ?=
 =?utf-8?B?eEVMc2hYYXQ0citQREd0cXFWMlRqeHhhemtpaHNuU3hLVHpLazRscXhxdHA3?=
 =?utf-8?B?bndGUGV6TzkyTmZnVGMyWWFUMmFSaGtNRXl1aFdNbWkrdlhqVTZUMGZXSk9y?=
 =?utf-8?B?VmxaZloxOHl0c2o2QU9xamJReThlQ1dyN3crelplcU1qWXBMS2RQYTJvby84?=
 =?utf-8?B?dW92QWdvZ09RRys5VFFMeXZzbzRXM0daOHZvOTViT1BNQ2hyRFRpa3ZVY29v?=
 =?utf-8?B?ZngvejJ3UlpBcWhsQ1J4Y3RGV3FhR0FMbk5EZGhocmVCMWZ1RnNCcFZuQnB4?=
 =?utf-8?B?TTRpVGEyQktlR1lmQzFUQWw4bzlsQVBNMW5xbmRpWENXc3J4cjZzbEtDMVFO?=
 =?utf-8?B?L3VPM0ZITExxbUN2RFhXVmsvd0IyMVY0dytjSld4WG9rU1lLOXV2VUhxNmF5?=
 =?utf-8?B?Ylc2VVNDMzBJRmFQVWc5aWV4Y3c1cFZoMmt0dEpTNlFRT1JyRHEwZW16Wi9Q?=
 =?utf-8?B?UjVWeFhyV2dLYzcwa0VJV0FId3JSdmI5NXhtKzNwdGU4eHZaYUR0V2VYZ25H?=
 =?utf-8?B?NVM4ZjVPaWJrU21xNWkyMGNtRDNQNVZWQkNYUTBvbjNjMC9pNmI4UEVONFNX?=
 =?utf-8?B?RUtuUW9QNXBycnJQd2dwWXZ2K054K3lLVGxXVmxoYkNHWFRCdGFTSk1oOHBz?=
 =?utf-8?B?QktqUStwaUJSNGlrZGhWck9zTkJQbEdYRmJZa1dMSjBkUU9Za2ZhTTZoNnRp?=
 =?utf-8?B?b2h5bVlTbkYxZkdPYW5PcVd2R0k1YmlVQVVjbllmTittR09DTTdnaEVsdzFK?=
 =?utf-8?B?YUN6YWhzUmh1SXNzUGdDY05ralk2WEpsbnlJNUdTbEFWQ3JFWlNiVExqMG53?=
 =?utf-8?B?WTN4QnFEalN2U214b3VkTHpNWE8zQVd1YWtZZDYzZ2UwSnplbDFwOFIwYk5n?=
 =?utf-8?B?TlJCMkh3R00wNUlOYmgwdjNHSWxxa2hOQlBILzlPay81WHhyM2NTYUh3LzhH?=
 =?utf-8?B?MllSNVU5cERUV2hObmNnUjA1QnZQc0FVS3BTYWRsd3lmU2JuVytMY3psSUxx?=
 =?utf-8?B?YUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B79F6A8D5BBA074C877F9332893E0DDA@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR03MB7958.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3bfea04-805a-4f7c-b4b4-08dd2be1442b
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jan 2025 10:27:46.7737
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8GWrDLZaOG9pJLJCnC96P1xYpBP8LFe/4Tp9SghGB0IBTnmE23WaPP4sg/qeBOYyVBfyXSYX5TluQhpxUdEyWC9khOvnjt8wZ0WCiSu9A5E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR03MB6891

SGkgRGF2aWQNCg0KVGVzdCBjYXNlcyB3aWxsIGJlIHByb3ZpZGVkIGxhdGVyLCAgYmVsb3cgYXJl
IHRoZSBjb3JyZXNwb25kaW5nIElQIHJ1bGUNCmNvbmZpZ3VyYXRpb25zIGZvciBJUHY0IGFuZCBJ
UHY2IHRoYXQgaSBwcm92aWRlZCwgYXMgd2VsbCBhcyB0aGUNCmRpZmZlcmVuY2VzIGluIHBpbmcg
cmVzdWx0cywgdGhlIElQdjQgcmVzdWx0IHBhc3NlZCwgYnV0IHRoZSBJUHY2DQpyZXN1bHQgZmFp
bGVkLCBhZnRlciBhZGRpbmcgdGhpcyBwYXRjaCwgdGhlIElQdjYgcmVzdWx0IHBhc3NlZC4NCg0K
VGhhbmtzDQoNCmJpbmQgb3V0IGludGVyZmFjZSBjY21uaTIgYWRkcmVzczoNCmNjbW5pMiAgICBM
aW5rIGVuY2FwOlVOU1BFQw0KICAgICAgICAgIGluZXQgYWRkcjoxMC4yMzMuMzMuMTY5ICBNYXNr
OjI1NS4wLjAuMA0KICAgICAgICAgIGluZXQ2IGFkZHI6IGZlODA6OjE4MTc6MWRhNDoxOWExOmRj
NDIvNjQgU2NvcGU6IExpbmsNCiAgICAgICAgICBpbmV0NiBhZGRyOiAyNDA5Ojg5MDA6MjZmMzoy
NTQxOjE4MTc6MWRhNDoxOWExOmRjNDIvNjQgU2NvcGU6DQoNCjEuVGhlcmUgaXMgbm8gaXAgcnVs
ZSBmb3IgY2NtbmkyIGFuZCBhbHNvIHBhc3MuDQprNjk5MXYxXzY0Oi8gIyBpcCBydWxlIGxpc3QN
CjA6ICAgICAgZnJvbSBhbGwgbG9va3VwIGxvY2FsDQoxMDAwMDogIGZyb20gYWxsIGZ3bWFyayAw
eGMwMDAwLzB4ZDAwMDAgbG9va3VwIGxlZ2FjeV9zeXN0ZW0NCjExMDAwOiAgZnJvbSBhbGwgaWlm
IGxvIG9pZiBkdW1teTAgdWlkcmFuZ2UgMC0wIGxvb2t1cCBkdW1teTANCjExMDAwOiAgZnJvbSBh
bGwgaWlmIGxvIG9pZiBjY21uaTEgdWlkcmFuZ2UgMC0wIGxvb2t1cCBjY21uaTENCjE2MDAwOiAg
ZnJvbSBhbGwgZndtYXJrIDB4MTAwNjMvMHgxZmZmZiBpaWYgbG8gbG9va3VwIGxvY2FsX25ldHdv
cmsNCjE2MDAwOiAgZnJvbSBhbGwgZndtYXJrIDB4ZDAwNzEvMHhkZmZmZiBpaWYgbG8gbG9va3Vw
IGNjbW5pMQ0KMTcwMDA6ICBmcm9tIGFsbCBpaWYgbG8gb2lmIGR1bW15MCBsb29rdXAgZHVtbXkw
DQoxNzAwMDogIGZyb20gYWxsIGZ3bWFyayAweGMwMDAwLzB4YzAwMDAgaWlmIGxvIG9pZiBjY21u
aTEgbG9va3VwIGNjbW5pMQ0KMTgwMDA6ICBmcm9tIGFsbCBmd21hcmsgMHgwLzB4MTAwMDAgbG9v
a3VwIGxlZ2FjeV9zeXN0ZW0NCjE5MDAwOiAgZnJvbSBhbGwgZndtYXJrIDB4MC8weDEwMDAwIGxv
b2t1cCBsZWdhY3lfbmV0d29yaw0KMjAwMDA6ICBmcm9tIGFsbCBmd21hcmsgMHgwLzB4MTAwMDAg
bG9va3VwIGxvY2FsX25ldHdvcmsNCjMyMDAwOiAgZnJvbSBhbGwgdW5yZWFjaGFibGUNCms2OTkx
djFfNjQ6LyAjDQprNjk5MXYxXzY0Oi8gIw0KazY5OTF2MV82NDovICMNCms2OTkxdjFfNjQ6LyAj
IHBpbmcgLUkgY2NtbmkyIDguOC44LjgNClBJTkcgOC44LjguOCAoOC44LjguOCkgZnJvbSAxMC4y
MzMuMzMuMTY5IGNjbW5pMjogNTYoODQpIGJ5dGVzIG9mIGRhdGEuDQo2NCBieXRlcyBmcm9tIDgu
OC44Ljg6IGljbXBfc2VxPTEgdHRsPTUwIHRpbWU9MTc5IG1zDQo2NCBieXRlcyBmcm9tIDguOC44
Ljg6IGljbXBfc2VxPTIgdHRsPTUwIHRpbWU9NzQuMyBtcw0KNjQgYnl0ZXMgZnJvbSA4LjguOC44
OiBpY21wX3NlcT0zIHR0bD01MCB0aW1lPTcyLjcgbXMNCjY0IGJ5dGVzIGZyb20gOC44LjguODog
aWNtcF9zZXE9NCB0dGw9NTAgdGltZT02Ny4xIG1zDQo2NCBieXRlcyBmcm9tIDguOC44Ljg6IGlj
bXBfc2VxPTUgdHRsPTUwIHRpbWU9NjMuMyBtcw0KNjQgYnl0ZXMgZnJvbSA4LjguOC44OiBpY21w
X3NlcT02IHR0bD01MCB0aW1lPTkwLjggbXMNCl5DDQotLS0gOC44LjguOCBwaW5nIHN0YXRpc3Rp
Y3MgLS0tDQo2IHBhY2tldHMgdHJhbnNtaXR0ZWQsIDYgcmVjZWl2ZWQsIDAlIHBhY2tldCBsb3Nz
LCB0aW1lIDUwMTdtcw0KcnR0IG1pbi9hdmcvbWF4L21kZXYgPSA2My4zMjMvOTEuMjUzLzE3OS4w
ODIvNDAuMjEzIG1zDQoNCg0KDQoyLlRoZXJlIGlzIG5vIGlwdjYgcnVsZSBmb3IgY2NtbmkyIGFu
ZCBmYWlsLg0KazY5OTF2MV82NDovICMgaXAgLTYgcnVsZSBsaXN0DQowOiAgICAgIGZyb20gYWxs
IGxvb2t1cCBsb2NhbA0KMTAwMDA6ICBmcm9tIGFsbCBmd21hcmsgMHhjMDAwMC8weGQwMDAwIGxv
b2t1cCBsZWdhY3lfc3lzdGVtDQoxMTAwMDogIGZyb20gYWxsIGlpZiBsbyBvaWYgZHVtbXkwIHVp
ZHJhbmdlIDAtMCBsb29rdXAgZHVtbXkwDQoxMTAwMDogIGZyb20gYWxsIGlpZiBsbyBvaWYgY2Nt
bmkxIHVpZHJhbmdlIDAtMCBsb29rdXAgY2NtbmkxDQoxNjAwMDogIGZyb20gYWxsIGZ3bWFyayAw
eDEwMDYzLzB4MWZmZmYgaWlmIGxvIGxvb2t1cCBsb2NhbF9uZXR3b3JrDQoxNjAwMDogIGZyb20g
YWxsIGZ3bWFyayAweGQwMDcxLzB4ZGZmZmYgaWlmIGxvIGxvb2t1cCBjY21uaTENCjE3MDAwOiAg
ZnJvbSBhbGwgaWlmIGxvIG9pZiBkdW1teTAgbG9va3VwIGR1bW15MA0KMTcwMDA6ICBmcm9tIGFs
bCBmd21hcmsgMHhjMDAwMC8weGMwMDAwIGlpZiBsbyBvaWYgY2NtbmkxIGxvb2t1cCBjY21uaTEN
CjE4MDAwOiAgZnJvbSBhbGwgZndtYXJrIDB4MC8weDEwMDAwIGxvb2t1cCBsZWdhY3lfc3lzdGVt
DQoxOTAwMDogIGZyb20gYWxsIGZ3bWFyayAweDAvMHgxMDAwMCBsb29rdXAgbGVnYWN5X25ldHdv
cmsNCjIwMDAwOiAgZnJvbSBhbGwgZndtYXJrIDB4MC8weDEwMDAwIGxvb2t1cCBsb2NhbF9uZXR3
b3JrDQozMjAwMDogIGZyb20gYWxsIHVucmVhY2hhYmxlDQprNjk5MXYxXzY0Oi8gIyBwaW5nNiAt
SSBjY21uaTIgMjAwMTo0ODYwOjQ4NjA6Ojg4ODgNCmNvbm5lY3Q6IE5ldHdvcmsgaXMgdW5yZWFj
aGFibGUNCg0KDQozLkFmdGVyIG1lcmdpbmcgdGhlIHN1Ym1pdHRlZCBwYXRjaC4NClRoZXJlIGlz
IG5vIGlwdjYgcnVsZSBmb3IgY2NtbmkyIGFuZCBwYXNzLg0KDQpjY21uaTIgICAgTGluayBlbmNh
cDpVTlNQRUMNCiAgICAgICAgICBpbmV0IGFkZHI6MTAuMTg1LjQ2LjIzNiAgTWFzazoyNTUuMC4w
LjANCiAgICAgICAgICBpbmV0NiBhZGRyOiAyNDA5Ojg5MDA6MjRkOTo0MDRlOjE4MTc6MjVjNDpl
MWM3OjRlNTIvNjQgU2NvcGU6DQoNCms2ODk3djFfNjQ6LyAjIGlwIC02IHJ1bGUgbGlzdA0KMDog
ICAgICBmcm9tIGFsbCBsb29rdXAgbG9jYWwNCjEwMDAwOiAgZnJvbSBhbGwgZndtYXJrIDB4YzAw
MDAvMHhkMDAwMCBsb29rdXAgbGVnYWN5X3N5c3RlbQ0KMTEwMDA6ICBmcm9tIGFsbCBpaWYgbG8g
b2lmIGR1bW15MCB1aWRyYW5nZSAwLTAgbG9va3VwIGR1bW15MA0KMTEwMDA6ICBmcm9tIGFsbCBp
aWYgbG8gb2lmIGNjbW5pMSB1aWRyYW5nZSAwLTAgbG9va3VwIGNjbW5pMQ0KMTYwMDA6ICBmcm9t
IGFsbCBmd21hcmsgMHgxMDA2My8weDFmZmZmIGlpZiBsbyBsb29rdXAgbG9jYWxfbmV0d29yaw0K
MTYwMDA6ICBmcm9tIGFsbCBmd21hcmsgMHhkMDA3MC8weGRmZmZmIGlpZiBsbyBsb29rdXAgY2Nt
bmkxDQoxNzAwMDogIGZyb20gYWxsIGlpZiBsbyBvaWYgZHVtbXkwIGxvb2t1cCBkdW1teTANCjE3
MDAwOiAgZnJvbSBhbGwgZndtYXJrIDB4YzAwMDAvMHhjMDAwMCBpaWYgbG8gb2lmIGNjbW5pMSBs
b29rdXAgY2NtbmkxDQoxODAwMDogIGZyb20gYWxsIGZ3bWFyayAweDAvMHgxMDAwMCBsb29rdXAg
bGVnYWN5X3N5c3RlbQ0KMTkwMDA6ICBmcm9tIGFsbCBmd21hcmsgMHgwLzB4MTAwMDAgbG9va3Vw
IGxlZ2FjeV9uZXR3b3JrDQoyMDAwMDogIGZyb20gYWxsIGZ3bWFyayAweDAvMHgxMDAwMCBsb29r
dXAgbG9jYWxfbmV0d29yaw0KMzIwMDA6ICBmcm9tIGFsbCB1bnJlYWNoYWJsZQ0KazY4OTd2MV82
NDovICMgcGluZzYgLUkgY2NtbmkyIDIwMDE6NDg2MDo0ODYwOjo4ODg4DQpQSU5HIDIwMDE6NDg2
MDo0ODYwOjo4ODg4KDIwMDE6NDg2MDo0ODYwOjo4ODg4KSBmcm9tDQoyNDA5Ojg5MDA6MjRkOTo0
MDRlOjE4MTc6MjVjNDplMWM3OjRlNTIgY2NtbmkyOiA1NiBkYXRhIGJ5dGVzDQo2NCBieXRlcyBm
cm9tIDIwMDE6NDg2MDo0ODYwOjo4ODg4OiBpY21wX3NlcT0xIHR0bD01MSB0aW1lPTE2NyBtcw0K
NjQgYnl0ZXMgZnJvbSAyMDAxOjQ4NjA6NDg2MDo6ODg4ODogaWNtcF9zZXE9MiB0dGw9NTEgdGlt
ZT03My45IG1zDQo2NCBieXRlcyBmcm9tIDIwMDE6NDg2MDo0ODYwOjo4ODg4OiBpY21wX3NlcT0z
IHR0bD01MSB0aW1lPTEwMSBtcw0KNjQgYnl0ZXMgZnJvbSAyMDAxOjQ4NjA6NDg2MDo6ODg4ODog
aWNtcF9zZXE9NCB0dGw9NTEgdGltZT02Mi4zIG1zDQpeQw0KLS0tIDIwMDE6NDg2MDo0ODYwOjo4
ODg4IHBpbmcgc3RhdGlzdGljcyAtLS0NCjUgcGFja2V0cyB0cmFuc21pdHRlZCwgNCByZWNlaXZl
ZCwgMjAlIHBhY2tldCBsb3NzLCB0aW1lIDQwMTFtcw0KDQoNCk9uIEZyaSwgMjAyNS0wMS0wMyBh
dCAxMzo0MyArMDgwMCwgU2hpbWluZyBDaGVuZyB3cm90ZToNCj4gV2hlbiB1c2luZyBzb2NrZXQg
SVB2NiB3aXRoIFNPX0JJTkRUT0RFVklDRSwgaWYgSVB2NiBydWxlIGlzIG5vdA0KPiBtYXRjaGVk
LCBpdCB3aWxsIHJldHVybiBFTkVUVU5SRUFDSC4gSW4gZmFjdCwgSVB2NCBkb2VzIG5vdCBiZWhh
dmUNCj4gdGhpcyB3YXkuIElQdjQgcHJpb3JpdGl6ZXMgbG9va2luZyB1cCBJUCBydWxlcyBmb3Ig
cm91dGluZyBhbmQNCj4gZm9yd2FyZGluZywgaWYgbm90IG1hdGNoZWQgaXQgd2lsbCB1c2Ugc29j
a2V0LWJvdW5kIG91dCBpbnRlcmZhY2UNCj4gdG8gc2VuZCBwYWNrZXRzLiBUaGUgbW9kaWZpY2F0
aW9uIGhlcmUgaXMgdG8gbWFrZSBJUHY2IGJlaGF2ZSB0aGUNCj4gc2FtZSBhcyBJUHY0LiBJZiBJ
UCBydWxlIGlzIG5vdCBmb3VuZCwgaXQgd2lsbCBhbHNvIHVzZSBzb2NrZXQtYm91bmQNCj4gb3V0
IGludGVyZmFjZSB0byBzZW5kIHBhY2t0cy4NCj4gDQo+IEZpeGVzOiA2ZjIxYzk2YTc4YjggKCJp
cHY2OiBlbmZvcmNlIGZsb3dpNl9vaWYgdXNhZ2UgaW4NCj4gaXA2X2RzdF9sb29rdXBfdGFpbCgp
IikNCj4gU2lnbmVkLW9mZi1ieTogU2hpbWluZyBDaGVuZyA8c2hpbWluZy5jaGVuZ0BtZWRpYXRl
ay5jb20+DQo+IC0tLQ0KPiAgaW5jbHVkZS9uZXQvaXA2X3JvdXRlLmggfCAgMiArKw0KPiAgbmV0
L2lwdjYvaXA2X291dHB1dC5jICAgfCAgNyArKysrKystDQo+ICBuZXQvaXB2Ni9yb3V0ZS5jICAg
ICAgICB8IDM0ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysNCj4gIDMgZmlsZXMg
Y2hhbmdlZCwgNDIgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPiANCj4gZGlmZiAtLWdp
dCBhL2luY2x1ZGUvbmV0L2lwNl9yb3V0ZS5oIGIvaW5jbHVkZS9uZXQvaXA2X3JvdXRlLmgNCj4g
aW5kZXggNmRiZGY2MGIzNDJmLi4wNjI1NTk3ZGVmNmYgMTAwNjQ0DQo+IC0tLSBhL2luY2x1ZGUv
bmV0L2lwNl9yb3V0ZS5oDQo+ICsrKyBiL2luY2x1ZGUvbmV0L2lwNl9yb3V0ZS5oDQo+IEBAIC0y
MTQsNiArMjE0LDggQEAgdm9pZCBydDZfbXVsdGlwYXRoX3JlYmFsYW5jZShzdHJ1Y3QgZmliNl9p
bmZvDQo+ICpmNmkpOw0KPiAgDQo+ICB2b2lkIHJ0Nl91bmNhY2hlZF9saXN0X2FkZChzdHJ1Y3Qg
cnQ2X2luZm8gKnJ0KTsNCj4gIHZvaWQgcnQ2X3VuY2FjaGVkX2xpc3RfZGVsKHN0cnVjdCBydDZf
aW5mbyAqcnQpOw0KPiArc3RydWN0IHJ0Nl9pbmZvICppcDZfY3JlYXRlX3J0X29pZl9yY3Uoc3Ry
dWN0IG5ldCAqbmV0LCBjb25zdCBzdHJ1Y3QNCj4gc29jayAqc2ssDQo+ICsJCXN0cnVjdCBmbG93
aTYgKmZsNiwgaW50IGZsYWdzKTsNCj4gIA0KPiAgc3RhdGljIGlubGluZSBjb25zdCBzdHJ1Y3Qg
cnQ2X2luZm8gKnNrYl9ydDZfaW5mbyhjb25zdCBzdHJ1Y3QNCj4gc2tfYnVmZiAqc2tiKQ0KPiAg
ew0KPiBkaWZmIC0tZ2l0IGEvbmV0L2lwdjYvaXA2X291dHB1dC5jIGIvbmV0L2lwdjYvaXA2X291
dHB1dC5jDQo+IGluZGV4IGY3YjQ2MDhiYjMxNi4uOTU3MjhjODkyMWNiIDEwMDY0NA0KPiAtLS0g
YS9uZXQvaXB2Ni9pcDZfb3V0cHV0LmMNCj4gKysrIGIvbmV0L2lwdjYvaXA2X291dHB1dC5jDQo+
IEBAIC0xMTU2LDggKzExNTYsMTMgQEAgc3RhdGljIGludCBpcDZfZHN0X2xvb2t1cF90YWlsKHN0
cnVjdCBuZXQNCj4gKm5ldCwgY29uc3Qgc3RydWN0IHNvY2sgKnNrLA0KPiAgCQkqZHN0ID0gaXA2
X3JvdXRlX291dHB1dF9mbGFncyhuZXQsIHNrLCBmbDYsIGZsYWdzKTsNCj4gIA0KPiAgCWVyciA9
ICgqZHN0KS0+ZXJyb3I7DQo+IC0JaWYgKGVycikNCj4gKwlpZiAoZXJyICYmIChmbGFncyAmIFJU
Nl9MT09LVVBfRl9JRkFDRSkpIHsNCj4gKwkJKmRzdCA9IChzdHJ1Y3QgZHN0X2VudHJ5ICopaXA2
X2NyZWF0ZV9ydF9vaWZfcmN1KG5ldCwNCj4gc2ssIGZsNiwgZmxhZ3MpOw0KPiArCQlpZiAoISpk
c3QpDQo+ICsJCQlnb3RvIG91dF9lcnJfcmVsZWFzZTsNCj4gKwl9IGVsc2UgaWYgKGVycikgew0K
PiAgCQlnb3RvIG91dF9lcnJfcmVsZWFzZTsNCj4gKwl9DQo+ICANCj4gICNpZmRlZiBDT05GSUdf
SVBWNl9PUFRJTUlTVElDX0RBRA0KPiAgCS8qDQo+IGRpZmYgLS1naXQgYS9uZXQvaXB2Ni9yb3V0
ZS5jIGIvbmV0L2lwdjYvcm91dGUuYw0KPiBpbmRleCA2N2ZmMTZjMDQ3MTguLjdkNzQ1MGZhYjQ0
ZiAxMDA2NDQNCj4gLS0tIGEvbmV0L2lwdjYvcm91dGUuYw0KPiArKysgYi9uZXQvaXB2Ni9yb3V0
ZS5jDQo+IEBAIC0xMjE0LDYgKzEyMTQsNDAgQEAgc3RhdGljIHN0cnVjdCBydDZfaW5mbw0KPiAq
aXA2X2NyZWF0ZV9ydF9yY3UoY29uc3Qgc3RydWN0IGZpYjZfcmVzdWx0ICpyZXMpDQo+ICAJcmV0
dXJuIG5ydDsNCj4gIH0NCj4gIA0KPiArc3RydWN0IHJ0Nl9pbmZvICppcDZfY3JlYXRlX3J0X29p
Zl9yY3Uoc3RydWN0IG5ldCAqbmV0LCBjb25zdCBzdHJ1Y3QNCj4gc29jayAqc2ssDQo+ICsJCQkJ
ICAgICAgIHN0cnVjdCBmbG93aTYgKmZsNiwgaW50IGZsYWdzKQ0KPiArew0KPiArCXN0cnVjdCBy
dDZfaW5mbyAqcnQ7DQo+ICsJdW5zaWduZWQgaW50IHByZWZzOw0KPiArCWludCBlcnI7DQo+ICsJ
c3RydWN0IG5ldF9kZXZpY2UgKmRldiA9IGRldl9nZXRfYnlfaW5kZXhfcmN1KG5ldCwgZmw2LQ0K
PiA+Zmxvd2k2X29pZik7DQo+ICsNCj4gKwlpZiAoIWRldikNCj4gKwkJcmV0dXJuIE5VTEw7DQo+
ICsJcnQgPSBpcDZfZHN0X2FsbG9jKGRldl9uZXQoZGV2KSwgZGV2LCBmbGFncyk7DQo+ICsNCj4g
KwlpZiAoIXJ0KQ0KPiArCQlyZXR1cm4gTlVMTDsNCj4gKwlydC0+ZHN0LmVycm9yID0gMDsNCj4g
KwlydC0+ZHN0Lm91dHB1dCA9IGlwNl9vdXRwdXQ7DQo+ICsJcnQtPmRzdC5sYXN0dXNlID0gamlm
ZmllczsNCj4gKwlwcmVmcyA9IHNrID8gaW5ldDZfc2soc2spLT5zcmNwcmVmcyA6IDA7DQo+ICsJ
ZXJyID0gaXB2Nl9kZXZfZ2V0X3NhZGRyKG5ldCwgZGV2LCAmZmw2LT5kYWRkciwgcHJlZnMsICZm
bDYtDQo+ID5zYWRkcik7DQo+ICsNCj4gKwlpZiAoZXJyKSB7DQo+ICsJCWRzdF9yZWxlYXNlKCZy
dC0+ZHN0KTsNCj4gKwkJcmV0dXJuIE5VTEw7DQo+ICsJfQ0KPiArCXJ0LT5ydDZpX2RzdC5hZGRy
ID0gZmw2LT5kYWRkcjsNCj4gKwlydC0+cnQ2aV9kc3QucGxlbiA9IDEyODsNCj4gKwlydC0+cnQ2
aV9zcmMuYWRkciA9IGZsNi0+c2FkZHI7DQo+ICsJcnQtPnJ0NmlfZHN0LnBsZW4gPSAxMjg7DQo+
ICsJcnQtPnJ0NmlfaWRldiA9IGluNl9kZXZfZ2V0KGRldik7DQo+ICsJcnQtPnJ0NmlfZmxhZ3Mg
PSBmbGFnczsNCj4gKwlyZXR1cm4gcnQ7DQo+ICt9DQo+ICtFWFBPUlRfU1lNQk9MX0dQTChpcDZf
Y3JlYXRlX3J0X29pZl9yY3UpOw0KPiArDQo+ICBJTkRJUkVDVF9DQUxMQUJMRV9TQ09QRSBzdHJ1
Y3QgcnQ2X2luZm8gKmlwNl9wb2xfcm91dGVfbG9va3VwKHN0cnVjdA0KPiBuZXQgKm5ldCwNCj4g
IAkJCQkJICAgICBzdHJ1Y3QgZmliNl90YWJsZSAqdGFibGUsDQo+ICAJCQkJCSAgICAgc3RydWN0
IGZsb3dpNiAqZmw2LA0K

