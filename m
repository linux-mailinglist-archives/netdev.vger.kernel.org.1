Return-Path: <netdev+bounces-304108-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id sR+FFjVERmrFNAsAu9opvQ
	(envelope-from <netdev+bounces-304108-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 12:57:57 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DBFA6F64C4
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 12:57:56 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=airoha.com header.s=dk header.b=FeWclECj;
	dkim=pass header.d=mediateko365.onmicrosoft.com header.s=selector2-mediateko365-onmicrosoft-com header.b=rYmPt07T;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304108-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-304108-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=airoha.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4FCD0315739C
	for <lists+netdev@lfdr.de>; Thu,  2 Jul 2026 10:44:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBCBE34BA20;
	Thu,  2 Jul 2026 10:44:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0967346AFD
	for <netdev@vger.kernel.org>; Thu,  2 Jul 2026 10:44:44 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782989087; cv=fail; b=Cyl3Nq5TsquO72tewwx5MAhjQwGkXsm1VSMa/SRH72bCM2S8hWWabAf7hpSoszBjFQxthDmg+TInrAfb7ZABqyB112ZLxnn6Pv8CUcQ//abVdj4qn1Dp9IUje7CbXTvahQhM6ahE2JKguyGodL9ynRJkR6AQWWXZB0+aHZaNs5U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782989087; c=relaxed/simple;
	bh=AjBmac4hFwaXUchP6qJTNNZsIlSUTyZe4hJxQ7nzfiw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=IbL+NZM5xApYLY8Hu9ERCzmfdyXPCdgekKyo++gPEP2uaUU16iWs2OYjbpU8czl6TYa0HIB5337WHZ9EF7ESuNXijqrdaSl1qkuzBAg0cWbVVhrfsZmei4acp7T4SmwN0CHDdPDq5s0pi6ylfC408GwI4sQfYHp9pwgZe7Y9/aM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=airoha.com; spf=pass smtp.mailfrom=airoha.com; dkim=pass (1024-bit key) header.d=airoha.com header.i=@airoha.com header.b=FeWclECj; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=rYmPt07T; arc=fail smtp.client-ip=60.244.123.138
X-UUID: 076539fc760311f1b1788b6acf885367-20260702
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=airoha.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=AjBmac4hFwaXUchP6qJTNNZsIlSUTyZe4hJxQ7nzfiw=;
	b=FeWclECjFrA5dDmSqTPlP9CmxqLM3lDvkG6IFza1Yd2oID6JFlQXdI/wL3fFgjwjJD8QtxAO/ubw12IYGX+S9jF26dHZ/eQJfH15ZaKC6AqYXrYRn20g5t7teQWxCilwKdK1RmXB6tkEbKuGRVO8CcdWChtDhVblJyw1llHp1FU=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.17,REQID:3e658dab-8e5c-4e8c-92db-eb65043ea72c,IP:0,U
	RL:12,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:12
X-CID-META: VersionHash:d497b38,CLOUDID:5d03e981-6310-4e6b-a6b1-aca20d98ed8b,B
	ulkID:nil,BulkQuantity:0,SF:80|81|82|83|102|110|111|836|865|888|898,TC:-5,
	Content:0|15|50|99,EDM:-3,IP:nil,URL:94|82|106|11|1,File:130,RT:0,Bulk:nil
	,QS:nil,BEC:-1,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
	,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 076539fc760311f1b1788b6acf885367-20260702
Received: from mtkmbs09n1.mediatek.inc [(172.21.101.35)] by mailgw01.mediatek.com
	(envelope-from <leto.liu@airoha.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1733668779; Thu, 02 Jul 2026 18:44:40 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 2 Jul 2026 18:44:39 +0800
Received: from SI4PR04CU002.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Thu, 2 Jul 2026 18:44:39 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O2uo6S4Ao3iAx63OejpLliuADiFLsbgHSqh+ojy8qmLDvG05zGuooOzvc+hG6w8J0DIFeJkcdxMsFCWFRL4iIfxKYqCb05klUCvXPCu7EAkipd5JszbOlBhafNt3J8nvhrFWWtGOL9Cl1pckBvuxuP1l7b9agL6C/RX/z2f8+fJo+I/N8eh3hoKeeAI27GmbK3dfxUSHH9eJEKpUbC003hTSXadhkZNUVe6f1cGpWPhyr2cwhai+xSVM/hcavqF4EMhBYL/CbOFT5Ot6f7avnXx3uEmlFLf2MpvKYuUUYcYWiajvqIEbkQ6FeBv+lGvNf1KfQxvmgrQxr6RAjuD2TA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AjBmac4hFwaXUchP6qJTNNZsIlSUTyZe4hJxQ7nzfiw=;
 b=Zepd5qHFiPWw3Jub5r3xoT+EYq372GGjW7ju12xgg29aPHdY43CuMg17NeQ801m0k8if/kBwHdCezLgW1GarCqBh/x25XFFmG+UFHnfVcr3ds9Ggiyfva59llmSoE3u81ycXNU6RVXb6ZaS2+1H+cACZO0G+HOC5e7W6EEcGruKQopIJgYfSFtT91CF4EgrZxDn2oN+vOwWD9PvebEaJyvfdZAJ+IW0QYu/l+tEv/2KIKu8DwZ7kkFO7DyRwKD8Gzg5oMaADZ2WdMF0gcN7mXkSXdmkvUGx0e/OSumL8vNeZZpTRKdYWoHIc0Aakc0pCbLd1l3XMODgg2bKdI2oPRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=airoha.com; dmarc=pass action=none header.from=airoha.com;
 dkim=pass header.d=airoha.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AjBmac4hFwaXUchP6qJTNNZsIlSUTyZe4hJxQ7nzfiw=;
 b=rYmPt07T10BzrpucxFFL+fhlGa6V+f1YKKyEnXD5iY037EWimR3GcpJSUG4AFLgG9KTDEJ+5q+Gh63/5Pb+bZ9NspoJo2xkbn02Y5pn3LNHQZwAum8dEl0mPWG9+ER3F3NuCZ8OdMme+zvpFAVxs3pFK1U2Bf5Y9ezxcXsg3FUo=
Received: from JH0PR03MB8619.apcprd03.prod.outlook.com (2603:1096:990:9b::6)
 by SEZPR03MB7567.apcprd03.prod.outlook.com (2603:1096:101:132::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Thu, 2 Jul
 2026 10:44:35 +0000
Received: from JH0PR03MB8619.apcprd03.prod.outlook.com
 ([fe80::e172:cb68:ccdc:8ea1]) by JH0PR03MB8619.apcprd03.prod.outlook.com
 ([fe80::e172:cb68:ccdc:8ea1%5]) with mapi id 15.21.0181.009; Thu, 2 Jul 2026
 10:44:35 +0000
From: =?utf-8?B?TGV0byBMaXUgKOWImOa2myk=?= <Leto.Liu@airoha.com>
To: Lorenzo Bianconi <lorenzo@kernel.org>, Simon Horman <horms@kernel.org>
CC: "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-mediatek@lists.infradead.org"
	<linux-mediatek@lists.infradead.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, =?utf-8?B?QnJvd24gSHVhbmcgKOm7g+afj+e/sCk=?=
	<Brown.Huang@airoha.com>
Subject: Re: [PATCH net v2] net: airoha: Add retry mechanism to
 airoha_qdma_set_trtcm_param()
Thread-Topic: [PATCH net v2] net: airoha: Add retry mechanism to
 airoha_qdma_set_trtcm_param()
Thread-Index: AQHdAiqKZXMZqnQKjkaO9XHfgk3HFbZL+McAgACh1ICADYCZAA==
Date: Thu, 2 Jul 2026 10:44:35 +0000
Message-ID: <JH0PR03MB861905C94AE76A6B8DC7BE8AE5F52@JH0PR03MB8619.apcprd03.prod.outlook.com>
References: <20260622-airoha_qdma_set_trtcm_param-retry-fix-v2-1-95a83ac99dbd@kernel.org>
 <20260623105341.1076863-3-horms@kernel.org> <ajrtd5WA2GFzQyV9@lore-desk>
In-Reply-To: <ajrtd5WA2GFzQyV9@lore-desk>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-dg-rorf: true
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: JH0PR03MB8619:EE_|SEZPR03MB7567:EE_
x-ms-office365-filtering-correlation-id: 153db7b0-2daf-411f-3d72-08ded826e86c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014|23010399003|6133799003|56012099006|11063799006|5023799004|4143699003|18002099003|22082099003|3023799007|38070700021;
x-microsoft-antispam-message-info: SYPP0+HXT+4f5tW4+ge0A/3Z0k7H46pDKRThkQhacVqLKgHQBUMccQoPZYORfR6t7TlxNerzK+toNd1gMp3pOYVx/viEANWXzV3E2J2wIanm/Hb5DjBh79Unx/QC6DKE7mstrfy4LPVhm6fu2JvrEExktUt4egq8gmH+IwJQUF3Hlf7z7YamiEvkHgfWUykFw8dCOjRaBezf687pZq9fR1mB2DM8PYCgk+C/0RNwN9gBtQ0tap2BYEAlBIeGUTZfKvTZOBqm5NuwBouNs2kNIY7j7fTJCAHZes1yHJxEMqYDhLjITk/Afe5puXRNiyWieFSFqjQTRJ/rpA+n8bOVxIKcuUYRW0Rnect6YelTtKfniny3ptaWiR3L5duJ+1K2yxFSCnQY6xe/lv+20F+ZdfL/gHPcUPelW5C1x45q67k68xsp+IMEfU/IXuyUntM1l8o60kw6ZptofZxIMK0/LMO6IsAV117TUrOAe0HxrfiuDzn6uKb49OxlrcV3IEn+AzKJsqZYa4LMrl+SXbkfzDiANyh5acbfKgPCzdEzAQZhAfy5jogjjKpjZAhx8/T6CrgqoFyZ6txqF7L3bWlVq/5Q8VUZqlTJoy5o/tWyLarFr0riCjSDKw70GEQRJVJVvLP3fPiFoAkht8VpIwwCrDN6DRJNa3om0bvVr1D5V/k=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:JH0PR03MB8619.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(23010399003)(6133799003)(56012099006)(11063799006)(5023799004)(4143699003)(18002099003)(22082099003)(3023799007)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?K0xiNEJ4RWQ4alJDUkNITDB6TlY0OVBkUUM1ZjNDVW5Lb3VVNkpidytYSUwy?=
 =?utf-8?B?NHVueEZMRjFqVXpKc0gwcTFKK2VKZWtOQWlPT3ZETU96cVBiNHRyZ09nc2Nm?=
 =?utf-8?B?VnlSdjA1aU53anBWa1dhZEZBbDhHZ2NlaXlPbHdyaVdyb0tYWitZZm9uMmdp?=
 =?utf-8?B?bUhCZUdqOG5SamJMWXlEb01FZzY3SURPT1QzbEEycXdZZmhURkdvaEl5c1Uz?=
 =?utf-8?B?NXRjMFJnU2UwQ3Nhb29kbTJCM0Ezc3QrQk56Y0J2YTNCWDJyQmxQa1ZvakxC?=
 =?utf-8?B?dzdoM1h5YzhWaFBSTCtYWlNSNEZINWduNFFsVnVMZHZJMms4ejFjcW10ZE9l?=
 =?utf-8?B?OEtSQ0tqeEVnUFVWeUFzWFBiK1pCNGN1dmxtL29YS1V1WFhKaXdhSXRmTm9H?=
 =?utf-8?B?eFh3bWp3QnJMR004Sy9vTUZDUHFxRDdraHIvdDVkVGRwTHB1dzV2dFBCZUN5?=
 =?utf-8?B?YmtxNEJZcUozc3RCakc4K0d0ZloveUoveUtHRm42MnIrbnk0T1ZrRGFaczlS?=
 =?utf-8?B?N1VZa0tRd0dlbDJ4ZG9meVJBRlJTWktERWFJZmtYaW9yU0FTa0RFNHh1VVo1?=
 =?utf-8?B?dXpNYnJMamlnTjlDOEZUcHpub28rQmdsbG1tNHdmb0d4ZjFNeTF3dUdpdGRK?=
 =?utf-8?B?RTVSREErc1pPZWVmV3NZc29PNTk3cHZJa1g5bmZSZCs0cm51REMrNkFnVGtv?=
 =?utf-8?B?RlNySzFyZ1JVSnNpTzRKS1VZT0I1cDdzTjRQNmk2RFZ0RHhQcTQ0Rlhob1Fh?=
 =?utf-8?B?WmNyQ3ZMd2V4SzNVLzQyYXlrdkhHMmJqQUwvSGpXRVROeUdrcWhUZlhBRWJX?=
 =?utf-8?B?dFBaK3ZNQ3R1dVFJN0l2bTVyODh6eUFTQkE3R1p2cm5mWUgwbTZnV3lGN2Jh?=
 =?utf-8?B?MTFMRjEvS0xrK3piVXY3ZUVielp1OWpxVGxqZXIvdEdDNzRWSkZuc3pVSVdQ?=
 =?utf-8?B?b25wRHpKOW1qYVNUZ2dxd1RaV3FrVHRBNkJXckxzZGlndlFpdnkwUDYvaEF2?=
 =?utf-8?B?cmZLU0NJL1JJRzBhSWh4MjQyTDRkbEtINWN6Smo3Q1pZdzJKcDlHb0NxMFBm?=
 =?utf-8?B?K0lMdkhGZ2ZTWGNuZTlBVFZjNndtRlZGKy9FdzNiaHlad25McWVCSFo5cThR?=
 =?utf-8?B?Sm9qMkIrRVFJVWhzUWp1aHRlaHZIYkxmMzVubG85cW44eEtaamdXZ0wvLzNC?=
 =?utf-8?B?b0drbm8rN0orVUp0cWRMZ1hUTnYvb21ZT0dVdlg1anZFQ0pJbVJsVTkvQmJZ?=
 =?utf-8?B?bi90QkYwYXI4VU1DbWRnUnRyTzFESGlhTlh1NnRvVTFrQkFQTnVObGl3ZU9t?=
 =?utf-8?B?S3Q2Y2dtWnpTalN3ZWJxblBRazFjWFUxaS9lRWE5Z2tPU0ZMWENoeno0bEtw?=
 =?utf-8?B?cEVsclN5K0VaWVhhRkcxVEl6MlZiM2xKT1EwK0V5Z3VJaXhtbVdkUWNDM1Jj?=
 =?utf-8?B?MGJ1UU1FS2Y5Ni9NQ3NLY1VRR3FJbzBhcUgvR1VQVGZ4SjBjT0ZqVXZKZEo1?=
 =?utf-8?B?NVlRZ29GR3JFYkdHQms2VmxleFY1QXRnUU4vYWx1bUZ6dGg4RHV4RlEwRmhI?=
 =?utf-8?B?RE5VWFJPeXBialB0RDArQVRsbkkzcmJqVDNFQzR4OFBQWXVBRVdpNGFIYUQw?=
 =?utf-8?B?OTR4WDYxdGF1VElFOTlCSGRibkpYbFZZaTBmYnBDVHcxS0lKeTRRc05EbEtY?=
 =?utf-8?B?b2VLeGNnVTFubXJJaFdLaFBnQUdpb0VRM3E5ZlRPN1hsSTZwWVVjeVdrd1NV?=
 =?utf-8?B?SlEydUQ0ZEk0dmtzUFFXd3htdTdZVFp3NVpZMzFFdXgweXhJZlB1bHlUU2Mr?=
 =?utf-8?B?Rm5rbFg1TUpqbTMrdW1KTmt3WXU5WVlMRllrUXQ4bVRnWWlObmhNdW5Yd05j?=
 =?utf-8?B?bmhHeG1EbFdEU0hwOEtqcXJyclY4ZkpXdkd3THVHVnk0VmpDSzBFbXhWdkVs?=
 =?utf-8?B?YW5BdlpRUDkvR1UxRGFTN0N5NzkyVTRDT0ljZUJQcU5JVTJJbERtM1QwakVq?=
 =?utf-8?B?TmNCK3gwSHZMTzdoTXpNWWd3eS9obkh4bFMvVHZoZDRhVlFwaXV2STBWTkhj?=
 =?utf-8?B?UnMvbTFXQ2lIaWhFYnpsSzloZ3pYVnQ2ZzY1S04rU2ZyUjhVWUdKZWNueFlm?=
 =?utf-8?B?R1lmTklUVTV2Wi9vaFp2RnhiL2l4emtsSXhWMXVDeUd6emp5aWpHMkRiUCtl?=
 =?utf-8?B?Y3d1S1BqakEvTzUwNlloUWZRY1JOcHQxUnAya1VST1kvZnZUSGY0Zzc2WHRL?=
 =?utf-8?B?OW02Wk9iaHBmMTRmNWxWUHZjUUFrckU0ZUVGZCtyaEo2R1Vkb0wxVnA3NzBN?=
 =?utf-8?Q?dcG0W839TppChDwxHc?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: Qsd1OcPJA3DuCMOCU3q7uOiDg6J4tanLv8qIxRQKpzzfJ5Fu+Uj+iiT2Vi8BMXJPlNoemX8SRuc4ZwzOh2COjpFwkYVhnOna/lCpLs9kD78eIN2IMC6lyiI71/LGCALk3gb/ki2Xs1p1eh5oTmhvpgnUSlk5GnBll+MfcnQrrffXf8cC+Onfd7QnZeS2Fp32pQQwLBY1a/XbVSwrCp4xMK9tmHbRADoPd2vMfa1xm2euIvp40Egcb4U0l8zx3/FTH6Eb8j5CJUX7SMpqhd7Im8ama/epuU3OupJTGUqo1QSxdV2ojox0TQY8X7mp5wVFIXdcdwEAJoZK8ZRSGxMQPw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: JH0PR03MB8619.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 153db7b0-2daf-411f-3d72-08ded826e86c
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jul 2026 10:44:35.2927
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IevXNedR9M//gNNDltm1it5NqjesLApAxxfuvScpytLiBl8MYcjHDgUR5KkjS08SSd/5K87WEFTmjKDk7Y4dcw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR03MB7567
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[airoha.com,quarantine];
	R_DKIM_ALLOW(-0.20)[airoha.com:s=dk,mediateko365.onmicrosoft.com:s=selector2-mediateko365-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-304108-lists,netdev=lfdr.de];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[Leto.Liu@airoha.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:lorenzo@kernel.org,m:horms@kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:linux-arm-kernel@lists.infradead.org,m:linux-mediatek@lists.infradead.org,m:netdev@vger.kernel.org,m:Brown.Huang@airoha.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,sashiko.dev:url,mediateko365.onmicrosoft.com:dkim,airoha.com:dkim,airoha.com:from_mime];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Leto.Liu@airoha.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[airoha.com:+,mediateko365.onmicrosoft.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1DBFA6F64C4

Rmlyc3QsIGxldCBtZSBkZXNjcmlwdCB0aGUgZGV0YWlsZWQgbWVjaGFuaXNtIG9mIGhhcmR3YXJl
IFFETUEgcmVnaXN0ZXIgcmVhZC93cml0ZSBpcyBhcyBmb2xsb3dzOg0KDQpDUFUgcmVnaXN0ZXIg
cmVhZHMgZG8gbm90IGhhdmUgYSDigJx3cml0ZS1mYWls4oCdIGlzc3VlOyBhIENQVSByZWFkIG9w
ZXJhdGlvbiBkb2VzIG5vdCBmYWlsIHRvIGV4ZWN1dGUuDQpBIENQVSByZWdpc3RlciB3cml0ZSBt
YXkgbm90IHRha2UgZWZmZWN0IGFzIGV4cGVjdGVkLCBpLmUuLCB0aGUgdmFsdWUgd3JpdHRlbiBi
eSB0aGUgQ1BVIG1heSBub3QgYmUgcHJlc2VydmVkLiBUaGlzIGlzIGJlY2F1c2UgUURNQSBwZXJm
b3JtcyBub24tYXRvbWljIHJlYWQtbW9kaWZ5LXdyaXRlIChSTVcpIG9wZXJhdGlvbnMsIGFuZCBh
IGhhcmR3YXJlIHdyaXRlIGNhbiBvdmVyd3JpdGUgYSBDUFUgd3JpdGUsIGNhdXNpbmcgdGhlIENQ
VSB3cml0ZSB0byBiZSBsb3N0Lg0KcndfZG9uZSBpcyBjbGVhcmVkIHRvIDAgd2hlbiB0aGUgQ1BV
IGlzc3VlcyBhIHdyaXRlIHJlcXVlc3QsIGFuZCBpcyBzZXQgdG8gMSBhZnRlciBjb21wbGV0aW9u
LiBUaGUgaW50ZXJ2YWwgaXMgb25seSBhIGZldyBoYXJkd2FyZSBjbG9jayBjeWNsZXMgKGxlc3Mg
dGhhbiAxMCBucykuDQpSZWdhcmRpbmcgd3JpdGUgY29udGVudGlvbjoNCg0KICAgICAgQ1BVIHNp
ZGUgKGRyaXZlci9zb2Z0d2FyZSkgICAgICAgICAgICAgICAgIEhXIHNpZGUgKHJhdGUtbGltaXRl
ciBlbmdpbmUpDQogICAgICAgICAgICAgfCAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgfA0KICAgICAgICAgICAgIHwgd3JpdGUgY2ZnX3BhcmFtIHJlZ2lzdGVy
ICAgICAgICAgICAgICAgICAgICAgICB8IHRva2VuLWJ1Y2tldCByZWZpbGwgdGljayAvIHBhY2tl
dCBpbmdyZXNzL2VncmVzcw0KICAgICAgICAgICAgIHwgKGluZGlyZWN0bHkgd3JpdGVzIFNSQU0p
ICAgICAgICAgICAgICAgICAgICAgICB8ICh1cGRhdGVzIFNSQU0pDQogICAgICAgICAgICAgfCAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfA0KICAgICAgICAg
ICAgIHYgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHYNCist
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLSsNCnwgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgSFcgU1JBTSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfA0KfCAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgfA0KfCAgSFcgcGVyZm9ybXMgUmVhZC1Nb2RpZnktV3Jp
dGUgKG5vbi1hdG9taWMpICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IHwNCnwgICAgICAgIHwgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwNCnwgICAgICAgIHwgMS4gSFcgcmVhZHMg
dGhlIG9sZCB2YWx1ZSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgfA0KfCAgICAgICAgfCAyLiBDUFUgd3JpdGUgaGFwcGVucyBmaXJzdCAgICAgLS0t
PiAgY29udGVudGlvbiBwb2ludCAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfA0KfCAgICAg
ICAgfCAzLiBIVyB3cml0ZSBvdmVyd3JpdGVzIHdpdGggb2xkL21vZCB2YWx1ZSAgLS0tPiAgQ1BV
IHZhbHVlIG92ZXJ3cml0dGVuICAgICAgICAgICAgIHwNCnwgICAgICAgIHYgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIHwNCistLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLSsNCkJlc3QgUmVnYXJkcywgTGV0bw0KDQo+
ID4gVGhpcyBpcyBhbiBBSS1nZW5lcmF0ZWQgcmV2aWV3IG9mIHlvdXIgcGF0Y2guIFRoZSBodW1h
biBzZW5kaW5nIHRoaXMgDQo+ID4gZW1haWwgaGFzIGNvbnNpZGVyZWQgdGhlIEFJIHJldmlldyB2
YWxpZCwgb3IgYXQgbGVhc3QgcGxhdXNpYmxlLg0KPiA+IEZ1bGwgcmV2aWV3IGF0OiBodHRwczov
L3Nhc2hpa28uZGV2DQo+ID4gDQo+ID4gU2ltb24gc2F5czogSSdkIGFwcHJlY2lhdGUgaXQgaWYg
eW91IGNvdWxkIGxvb2sgb3ZlciB0aGUgZmlyc3QgdHdvIGlzc3Vlcw0KPiA+ICAgICAgICAgICAg
IGZsYWdnZWQgYmVsb3cgaW4gdGhlIGNvbnRleHQgb2YgdGhpcyBwYXRjaC4gV2hpbGUgdGhlIHRo
aXJkDQo+ID4gCSAgICBhbmQgZmluYWwgaXNzdWUgbG9va3MgbGlrZSBpdCBpcyBpbiBwb3NzaWJs
ZSBzZXBhcmF0ZSBmb2xsb3ctdXANCj4gPiAJICAgIHRlcnJpdG9yeS4NCj4gPiANCj4gPiAtLS0N
Cj4gPiBuZXQ6IGFpcm9oYTogQWRkIHJldHJ5IG1lY2hhbmlzbSB0byBhaXJvaGFfcWRtYV9zZXRf
dHJ0Y21fcGFyYW0oKQ0KPiA+ICAgICANCj4gPiBUaGlzIHBhdGNoIGludHJvZHVjZXMgYSByZXRy
eSBsb29wIHRvIGFpcm9oYV9xZG1hX3NldF90cnRjbV9wYXJhbSgpIHRvIA0KPiA+IG1pdGlnYXRl
IGJ1cyB0aW1lb3V0cyB3aGVuIGNvbmZpZ3VyaW5nIFFETUEgcGFyYW1ldGVycy4gSXQgYXR0ZW1w
dHMgdG8gDQo+ID4gdmVyaWZ5IHRoYXQgdGhlIGNvbmZpZ3VyYXRpb24gaXMgY29ycmVjdGx5IGFw
cGxpZWQgdG8gdGhlIGhhcmR3YXJlLg0KPiA+IA0KPiA+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMv
bmV0L2V0aGVybmV0L2Fpcm9oYS9haXJvaGFfZXRoLmMgDQo+ID4gPiBiL2RyaXZlcnMvbmV0L2V0
aGVybmV0L2Fpcm9oYS9haXJvaGFfZXRoLmMNCj4gPiA+IGluZGV4IDMzNzBjM2RmN2MxMDcuLmJi
NWMwNTk5YTRlZWQgMTAwNjQ0DQo+ID4gPiAtLS0gYS9kcml2ZXJzL25ldC9ldGhlcm5ldC9haXJv
aGEvYWlyb2hhX2V0aC5jDQo+ID4gPiArKysgYi9kcml2ZXJzL25ldC9ldGhlcm5ldC9haXJvaGEv
YWlyb2hhX2V0aC5jDQo+ID4gPiBAQCAtMjY3MywxNCArMjY3MywzMCBAQCBzdGF0aWMgaW50IGFp
cm9oYV9xZG1hX3NldF90cnRjbV9wYXJhbShzdHJ1Y3QgYWlyb2hhX3FkbWEgKnFkbWEsIGludCBj
aGFubmVsLA0KPiA+ID4gIAkJICAgICBGSUVMRF9QUkVQKFRSVENNX01FVEVSX0dST1VQX01BU0ss
IGdyb3VwKSB8DQo+ID4gPiAgCQkgICAgIEZJRUxEX1BSRVAoVFJUQ01fUEFSQU1fSU5ERVhfTUFT
SywgaWR4KSB8DQo+ID4gPiAgCQkgICAgIEZJRUxEX1BSRVAoVFJUQ01fUEFSQU1fUkFURV9UWVBF
X01BU0ssIG1vZGUpOw0KPiA+ID4gKwlpbnQgaTsNCj4gPiA+ICANCj4gPiA+IC0JYWlyb2hhX3Fk
bWFfd3IocWRtYSwgUkVHX1RSVENNX0RBVEFfTE9XKGFkZHIpLCB2YWwpOw0KPiA+ID4gLQlhaXJv
aGFfcWRtYV93cihxZG1hLCBSRUdfVFJUQ01fQ0ZHX1BBUkFNKGFkZHIpLCBjb25maWcpOw0KPiA+
ID4gKwlmb3IgKGkgPSAwOyBpIDwgMTAwOyBpKyspIHsNCj4gPiA+ICsJCXUzMiBkYXRhOw0KPiA+
ID4gIA0KPiA+ID4gLQlyZXR1cm4gcmVhZF9wb2xsX3RpbWVvdXQoYWlyb2hhX3FkbWFfcnIsIHZh
bCwNCj4gPiA+IC0JCQkJIHZhbCAmIFRSVENNX1BBUkFNX1JXX0RPTkVfTUFTSywNCj4gPiA+IC0J
CQkJIFVTRUNfUEVSX01TRUMsIDEwICogVVNFQ19QRVJfTVNFQywgdHJ1ZSwNCj4gPiA+IC0JCQkJ
IHFkbWEsIFJFR19UUlRDTV9DRkdfUEFSQU0oYWRkcikpOw0KPiA+ID4gKwkJYWlyb2hhX3FkbWFf
d3IocWRtYSwgUkVHX1RSVENNX0RBVEFfTE9XKGFkZHIpLCB2YWwpOw0KPiA+ID4gKwkJd21iKCk7
DQo+ID4gPiArCQlhaXJvaGFfcWRtYV93cihxZG1hLCBSRUdfVFJUQ01fQ0ZHX1BBUkFNKGFkZHIp
LCBjb25maWcpOw0KPiA+ID4gKw0KPiA+ID4gKwkJaWYgKHJlYWRfcG9sbF90aW1lb3V0KGFpcm9o
YV9xZG1hX3JyLCBkYXRhLA0KPiA+ID4gKwkJCQkgICAgICBkYXRhICYgVFJUQ01fUEFSQU1fUldf
RE9ORV9NQVNLLA0KPiA+ID4gKwkJCQkgICAgICBVU0VDX1BFUl9NU0VDLCAxMCAqIFVTRUNfUEVS
X01TRUMsDQo+ID4gPiArCQkJCSAgICAgIHRydWUsIHFkbWEsIFJFR19UUlRDTV9DRkdfUEFSQU0o
YWRkcikpKQ0KPiA+ID4gKwkJCXJldHVybiAtRVRJTUVET1VUOw0KPiA+IA0KPiA+IFtTZXZlcml0
eTogSGlnaF0NCj4gPiBJZiBhIGJ1cyB0aW1lb3V0IGNhdXNlcyB0aGUgd3JpdGUgcGhhc2UncyBy
ZWFkX3BvbGxfdGltZW91dCgpIGluDQo+ID4gYWlyb2hhX3FkbWFfc2V0X3RydGNtX3BhcmFtKCkg
dG8gZmFpbCwgdGhpcyBpbW1lZGlhdGVseSByZXR1cm5zIA0KPiA+IC1FVElNRURPVVQsIGFib3J0
aW5nIHRoZSAxMDAtaXRlcmF0aW9uIHJldHJ5IGxvb3AuDQo+ID4gDQo+ID4gRG9lc24ndCB0aGlz
IGRlZmVhdCB0aGUgbWl0aWdhdGlvbj8NCg0KSGVyZSB3ZSBhcmUgcG9sbGluZyB0aGUgaGFyZHdh
cmUgZG9uZSBiaXQuIEJhc2VkIG9uIHRoZSBoYXJkd2FyZSBiZWhhdmlvciBkZXNjcmliZWQgYWJv
dmUsIGEgcmVhZCBvcGVyYXRpb24gd2lsbCBub3QgZmFpbC4gSW4gYWRkaXRpb24sIHRoZSBoYXJk
d2FyZSByZWdpc3RlciB3cml0ZSBjb21wbGV0ZXMgd2l0aGluIGF0IG1vc3QgMTAgbnMsIHdoaWxl
IHRoZSBwb2xsIHRpbWVvdXQgaGVyZSBpcyBjb25maWd1cmVkIG1vcmUgdGhhbiAxIG1zLiBGcm9t
IHRoZXNlIHR3byBwb2ludHMsIHdlIGNhbiBjb25jbHVkZSB0aGF0IHRoaXMgcmVhZF9wb2xsX3Rp
bWVvdXQgd2lsbCBhbHdheXMgc3VjY2VlZCAoaS5lLiwgaXQgd2lsbCByZXR1cm4gMCkuIFRoZXJl
Zm9yZSwgYWRkaW5nIGEgcmV0dXJuIC1FVElNRURPVVQgcGF0aCBoZXJlIHdpbGwgbm90IGNhdXNl
IGFueSBpc3N1ZXMuDQpCZXN0IFJlZ2FyZHMsIExldG8NCg0KPg0KPiBJIGFncmVlIHdlIGp1c3Qg
cnVuICdjb250aW51ZScgaGVyZSBpbnN0ZWFkIG9mIHJldHVyaW5nIC1FVElNRURPVVQNCk5vIGNo
YW5nZSBpcyBuZWVkZWQgaGVyZSwgYW5kIGV2ZW4gaWYgd2UgbW9kaWZ5IGl0LCBpdCB3aWxsIG5v
dCBjYXVzZSBhbnkgaXNzdWVzLiANCkJlc3QgUmVnYXJkcywgTGV0bw0KDQo+ID4gDQo+ID4gPiAr
DQo+ID4gPiArCQlpZiAoYWlyb2hhX3FkbWFfZ2V0X3RydGNtX3BhcmFtKHFkbWEsIGNoYW5uZWws
IGFkZHIsIHBhcmFtLA0KPiA+ID4gKwkJCQkJCW1vZGUsICZkYXRhLCBOVUxMKSkNCj4gPiA+ICsJ
CQljb250aW51ZTsNCj4gPiANCj4gPiBbU2V2ZXJpdHk6IEhpZ2hdDQo+ID4gSWYgYWlyb2hhX3Fk
bWFfZ2V0X3RydGNtX3BhcmFtKCkgdGltZXMgb3V0IGR1cmluZyB0aGUgdmVyaWZpY2F0aW9uIA0K
PiA+IHBoYXNlLCBpdCBpbmRpY2F0ZXMgdGhlIGhhcmR3YXJlIGhhc24ndCBmaW5pc2hlZCB0aGUg
cmVhZCBjb21tYW5kIChET05FIGJpdCBpcyBzdGlsbCAwKS4NCj4gPiANCj4gPiBUaGUgY29udGlu
dWUgc3RhdGVtZW50IHRoZW4gaW1tZWRpYXRlbHkgc3RhcnRzIHRoZSBuZXh0IGl0ZXJhdGlvbiwg
DQo+ID4gd3JpdGluZyBuZXcgY29tbWFuZHMgdG8gREFUQV9MT1cgYW5kIENGR19QQVJBTS4NCj4g
PiANCj4gPiBDYW4gd3JpdGluZyB0byBjb21tYW5kIHJlZ2lzdGVycyB3aGlsZSB0aGUgaGFyZHdh
cmUgc3RhdGUgbWFjaGluZSBpcyANCj4gPiBhY3RpdmVseSBidXN5IHZpb2xhdGUgaGFyZHdhcmUg
cHJvdG9jb2xzIGFuZCBsZWFkIHRvIHVucmVjb3ZlcmFibGUgbG9ja3Vwcz8NCj4NCj4gQEJyb3du
IGFuZCBATGV0bzogY2FuIHlvdSBwbGVhc2UgY29tbWVudCBvbiB0aGlzIGNhc2U/DQo+DQp0aGUg
aGFyZHdhcmUgcmVnaXN0ZXIgd3JpdGUgY29tcGxldGVzIHdpdGhpbiBhdCBtb3N0IDEwIG5zLCB3
aGlsZSB0aGUgcG9sbCB0aW1lb3V0IGhlcmUgaXMgY29uZmlndXJlZCBtb3JlIHRoYW4gMSBtcy4g
V2hlbiBhaXJvaGFfcWRtYV9nZXRfdHJ0Y21fcGFyYW0oKSBpcyBjYWxsZWQgaGVyZSwgdGhlIGhh
cmR3YXJlIGhhcyBhbHJlYWR5IGNvbXBsZXRlZCB0aGUgcHJldmlvdXMgcmVnaXN0ZXIgd3JpdGUg
b3BlcmF0aW9uLiBUaGVyZWZvcmUsIHRoZSBjb25jZXJuIG1lbnRpb25lZCBoZXJlIHdpbGwgZGVm
aW5pdGVseSBub3Qgb2NjdXIsIGFuZCB0aGVyZSB3aWxsIGJlIG5vIGlzc3VlIGF0IHRoaXMgcG9p
bnQuDQpCZXN0IFJlZ2FyZHMsIExldG8NCg0KPiA+IA0KPiA+ID4gKw0KPiA+ID4gKwkJaWYgKGRh
dGEgPT0gdmFsKQ0KPiA+ID4gKwkJCXJldHVybiAwOw0KPiA+IA0KPiA+IFtTZXZlcml0eTogSGln
aF0NCj4gPiBUaGlzIGlzbid0IGEgYnVnIGludHJvZHVjZWQgYnkgdGhpcyBwYXRjaCwgYnV0IGlm
IHRoZSBidXMgZHJvcHMgdGhlIA0KPiA+IGNvbW1hbmQgd3JpdGUgdG8gUkVHX1RSVENNX0NGR19Q
QVJBTSwgdGhlIGhhcmR3YXJlIG5ldmVyIGV4ZWN1dGVzIHRoZSANCj4gPiBjb21tYW5kIGFuZCB0
aGUgVFJUQ01fUEFSQU1fUldfRE9ORV9NQVNLIGJpdCByZW1haW5zIHNldCBmcm9tIHRoZSBwcmV2
aW91cyBvcGVyYXRpb24uDQo+ID4gDQo+ID4gQ29uc2VxdWVudGx5LCByZWFkX3BvbGxfdGltZW91
dCgpIHJldHVybnMgYW4gaW1tZWRpYXRlIGZhbHNlIHN1Y2Nlc3MuDQo+ID4gDQo+ID4gSWYgYm90
aCB0aGUgc2V0IGFuZCBnZXQgY29tbWFuZCB3cml0ZXMgYXJlIGRyb3BwZWQgYnkgdGhlIGJ1cywg
dGhlIGdldCANCj4gPiBvcGVyYXRpb24gd2lsbCByZWFkIGJhY2sgdGhlIG5ld2x5IHdyaXR0ZW4g
REFUQV9MT1cgcmVnaXN0ZXIgdmFsdWUuDQo+ID4gDQo+ID4gV2lsbCB0aGUgZGF0YSA9PSB2YWwg
Y2hlY2sgZXZhbHVhdGUgdG8gdHJ1ZSBhbmQgZmFsc2VseSByZXBvcnQgc3VjY2VzcyANCj4gPiB3
aXRob3V0IHRoZSBoYXJkd2FyZSBldmVyIHByb2Nlc3NpbmcgdGhlIGNvbmZpZ3VyYXRpb24/DQo+
DQo+IFRoaXMgc2VlbXMgcXVpdGUgYSAncGF0aG9sb2dpY2FsJyBzY2VuYXJpbywgaXMgaXQgcmVh
bGx5IGFuIGlzc3VlPw0KPg0KPiBSZWdhcmRzLA0KPiBMb3JlbnpvDQo+DQpBcyBleHBsYWluZWQg
YWJvdmUsIHRoZSBjb25jZXJuIGhlcmUgZG9lcyBub3QgYXBwbHkgYW5kIHRoZXJlIHdpbGwgYmUg
bm8gaXNzdWUuDQpCZXN0IFJlZ2FyZHMsIExldG8NCg0KPiA+IA0KPiA+ID4gKwl9DQo+ID4gPiAr
DQo+ID4gPiArCXJldHVybiAtRUJVU1k7DQo+ID4gPiAgfQ0KPiA+ID4gIA0KPiA+IA0KPiA+IFsg
Li4uIF0NCj4gPiANCj4gPiA+ICBzdGF0aWMgaW50IGFpcm9oYV9xZG1hX3NldF90cnRjbV9jb25m
aWcoc3RydWN0IGFpcm9oYV9xZG1hICpxZG1hLCBpbnQgY2hhbm5lbCwNCj4gPiA+ICAJCQkJCXUz
MiBhZGRyLCBlbnVtIHRydGNtX21vZGVfdHlwZSBtb2RlLA0KPiA+ID4gIAkJCQkJYm9vbCBlbmFi
bGUsIHUzMiBlbmFibGVfbWFzaykNCj4gPiA+ICB7DQo+ID4gPiAgCXUzMiB2YWw7DQo+ID4gPiAg
DQo+ID4gPiAgCWlmIChhaXJvaGFfcWRtYV9nZXRfdHJ0Y21fcGFyYW0ocWRtYSwgY2hhbm5lbCwg
YWRkciwgVFJUQ01fTUlTQ19NT0RFLA0KPiA+ID4gIAkJCQkJbW9kZSwgJnZhbCwgTlVMTCkpDQo+
ID4gPiAgCQlyZXR1cm4gLUVJTlZBTDsNCj4gPiANCj4gPiBbU2V2ZXJpdHk6IEhpZ2hdDQo+ID4g
U3RhbmRhbG9uZSBjYWxscyB0byBhaXJvaGFfcWRtYV9nZXRfdHJ0Y21fcGFyYW0oKSwgbGlrZSB0
aGlzIG9uZSBpbiANCj4gPiBhaXJvaGFfcWRtYV9zZXRfdHJ0Y21fY29uZmlnKCksIGxhY2sgYSBy
ZXRyeSBsb29wIGVudGlyZWx5Lg0KPiA+IA0KPiA+IERvZXMgdGhpcyBsZWF2ZSByZWFkLW1vZGlm
eS13cml0ZSBjeWNsZXMgZnVsbHkgdnVsbmVyYWJsZSB0byB0aGUgc2FtZSANCj4gPiBidXMgdGlt
ZW91dHMgdGhlIHBhdGNoIGF0dGVtcHRzIHRvIG1pdGlnYXRlPw0KPiA+IA0KTm8gY2hhbmdlIGlz
IG5lZWRlZCBoZXJlLiBFdmVuIGlmIHRoZSB3cml0ZSBzdWNjZWVkcyBidXQgdGhlIHJlYWQtYmFj
ayBkdXJpbmcgdmVyaWZpY2F0aW9uIHJldHVybnMgYW4gaW5jb3JyZWN0IHZhbHVlLCB0aGUgdmVy
aWZpY2F0aW9uIHdpbGwgZmFpbCBhbmQgdGhlIGNvZGUgd2lsbCBwcm9jZWVkIHRvIHRoZSBuZXh0
IHJldHJ5LiBBIGZhaWx1cmUgd291bGQgb25seSBvY2N1ciBpZiB0aGlzIGhhcHBlbmVkIGZvciAx
MDAgY29uc2VjdXRpdmUgYXR0ZW1wdHMsIHdoaWNoIGhhcyBhbiBhbG1vc3QgemVybyBwcm9iYWJp
bGl0eS4gVGhlcmVmb3JlLCB0aGlzIGNvZGUgZG9lcyBub3QgYWZmZWN0IHRoZSBmaW5hbCBvdXRj
b21lLg0KVGhhdCBzYWlkLCB5b3VyIHN1Z2dlc3Rpb24gaXMgYSBnb29kIG9uZSwgYW5kIGl0IGlz
IHN0aWxsIHdvcnRod2hpbGUgdG8gaW1wcm92ZS9vcHRpbWl6ZSB0aGUgcmVhZCBmdW5jdGlvbi4N
CkJlc3QgUmVnYXJkcywgTGV0bw0KDQo+ID4gW1NldmVyaXR5OiBIaWdoXQ0KPiA+IFRoaXMgaXNu
J3QgYSBidWcgaW50cm9kdWNlZCBieSB0aGlzIHBhdGNoLCBidXQgdGhlIHBhdGNoIG1pdGlnYXRl
cyBidXMgDQo+ID4gdGltZW91dHMgaW4gYWlyb2hhX3FkbWFfc2V0X3RydGNtX3BhcmFtKCkgd2hp
bGUgZW50aXJlbHkgbWlzc2luZyANCj4gPiBhaXJvaGFfcWRtYV9zZXRfcmxfcGFyYW0oKS4NCj4g
PiANCj4gPiBUaGUgbGF0dGVyIHBlcmZvcm1zIHRoZSBleGFjdCBzYW1lIHdyaXRlLWFuZC1wb2xs
IHNlcXVlbmNlIG9uIA0KPiA+IGlkZW50aWNhbCBRRE1BIGNvbmZpZ3VyYXRpb24gcmVnaXN0ZXJz
Og0KPiA+IA0KPiA+IGRyaXZlcnMvbmV0L2V0aGVybmV0L2Fpcm9oYS9haXJvaGFfZXRoLmM6YWly
b2hhX3FkbWFfc2V0X3JsX3BhcmFtKCkgew0KPiA+ICAgICAuLi4NCj4gPiAgICAgcmV0dXJuIHJl
YWRfcG9sbF90aW1lb3V0KC4uLiwgdmFsICYgUkFURV9MSU1JVF9QQVJBTV9SV19ET05FX01BU0ss
IA0KPiA+IC4uLik7IH0NCj4gPiANCj4gPiBJZiBidXMgdGltZW91dHMgYWZmZWN0IFFETUEgYWNj
ZXNzIGJyb2FkbHkgYXMgc3RhdGVkIGluIHRoZSBjb21taXQgDQo+ID4gbWVzc2FnZSwgYXJlIHRo
ZSByYXRlLWxpbWl0aW5nIGNvbmZpZ3VyYXRpb24gcGF0aHMgcmFuZG9tbHkgdnVsbmVyYWJsZSB0
byB0aGUgc2FtZSBmYWlsdXJlcz8NCj4gPiANCg0KWWVzLCB5b3UgYXJlIHJpZ2h0LiBGdW5jdGlv
biBhaXJvaGFfcWRtYV9zZXRfcmxfcGFyYW0gbmVlZCByZWFkYmFjayBwcm90ZWN0aW5nLg0KQmVz
dCBSZWdhcmRzLCBMZXRvDQoNCj4gPiBbU2V2ZXJpdHk6IEhpZ2hdDQo+ID4gVGhpcyBpc24ndCBh
IGJ1ZyBpbnRyb2R1Y2VkIGJ5IHRoaXMgcGF0Y2gsIGJ1dCBpbiANCj4gPiBhaXJvaGFfdGNfcmVt
b3ZlX2h0Yl9xdWV1ZSgpLCBoYXJkd2FyZSB0ZWFyZG93biBpbmNvcnJlY3RseSB1c2VzIHF1ZXVl
ICsgMSBpbnN0ZWFkIG9mIHF1ZXVlOg0KPiA+IA0KPiA+IGRyaXZlcnMvbmV0L2V0aGVybmV0L2Fp
cm9oYS9haXJvaGFfZXRoLmM6YWlyb2hhX3RjX3JlbW92ZV9odGJfcXVldWUoKSB7DQo+ID4gICAg
IC4uLg0KPiA+ICAgICBhaXJvaGFfcWRtYV9zZXRfdHhfcmF0ZV9saW1pdChuZXRkZXYsIHF1ZXVl
ICsgMSwgMCwgMCk7DQo+ID4gICAgIC4uLg0KPiA+IH0NCj4gPiANCj4gPiBEb2VzIHRoaXMgbGVh
dmUgdGhlIHJlbW92ZWQgcXVldWUncyBoYXJkd2FyZSBsaW1pdHMgcGVybWFuZW50bHkgYWN0aXZl
IA0KPiA+IChyZXNvdXJjZSBsZWFrKSBhbmQgaW5hZHZlcnRlbnRseSBkaXNhYmxlIHRoZSByYXRl
IGxpbWl0cyBmb3IgcXVldWUgKyANCj4gPiAxLCBjb3JydXB0aW5nIHRoZSBRb1Mgc3RhdGUgb2Yg
YW5vdGhlciBhY3RpdmUgY2hhbm5lbD8NCkl0IGhhcyBhbHJlYWR5IGJlZW4gZml4ZWQsIHJlZmVy
IHRvIGh0dHBzOi8vZ2l0aHViLmNvbS9Mb3JlbnpvQmlhbmNvbmkvbmV0LW5leHQvY29tbWl0L2Q3
NzVkNTQyNTA0Y2JmZWEyYjIxNDE0OTQwNWQ5N2ViMDBhODhkYzQNCkJlc3QgUmVnYXJkcywgTGV0
bw0K

