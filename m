Return-Path: <netdev+bounces-212782-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BBC6B21EC1
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 09:05:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 305B51AA3246
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 07:05:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39BB92D6E78;
	Tue, 12 Aug 2025 07:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="neqOyT6z";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="Zh893f8x"
X-Original-To: netdev@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5904B2D6E42;
	Tue, 12 Aug 2025 07:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754982304; cv=fail; b=DVJ0EJg21XDUkiKCkEshAKBa2DY3dAQ3dRbvczrCp+gjGUq70TAAKwTBNwVNlhJg0A2j/Alqt4bjseaVK4QMOjoE7/hbnBE/oklWMxnqfLfpWvYg2oCvcbKO2ukb+xDevWOBMJbPU6WJCd+JU7EEzM9mMG8vPkMHoJuLktGnKRs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754982304; c=relaxed/simple;
	bh=l/1G6g4Z0VAHkdqySl7+PXW7ab7tV+fg/yyxF+yclHw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=T9WKnIWmgc8cIbfBcE2AnY1V+EyP8kSYjBSPOYIMD8/qa6+W02eCOVppBP8MeQ7ZLkws3zT6WuMmSZQYJ2BmfP5XlMh8+yGbSLlklzcjOGXjpwe0JsL1Op3b5zSHk/09h7FaL3i3TETVf3bChX3F7xC+2d7dCEqzUXLR5ifWIPQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=neqOyT6z; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=Zh893f8x; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: a74ea600774a11f0b33aeb1e7f16c2b6-20250812
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=l/1G6g4Z0VAHkdqySl7+PXW7ab7tV+fg/yyxF+yclHw=;
	b=neqOyT6zObCAEXB8v95soZHf/V2tJklmLIddDUIVKcdCNRAhAYTOTWZxncP8BdhjB6T7LRhLlBekJCwPwndhREcJWrfwyJpUmP+2gJDWsvhTr2bt8EkT3gkJly78ty3DsxQDxSGH8QW4a/3su543zVDUZbCNrbW3WeXnHS6PMXo=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.3,REQID:ae7643ae-31d9-4c21-9388-5deb35c5f9f7,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:f1326cf,CLOUDID:b064d99d-7ad4-4169-ab95-78e9164f00fe,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|110|111,TC:-5,Conten
	t:0|15|50,EDM:-3,IP:nil,URL:99|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,C
	OL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: a74ea600774a11f0b33aeb1e7f16c2b6-20250812
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw02.mediatek.com
	(envelope-from <liju-clr.chen@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 927017660; Tue, 12 Aug 2025 15:04:56 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.39; Tue, 12 Aug 2025 15:04:55 +0800
Received: from OS8PR02CU002.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1258.39 via Frontend Transport; Tue, 12 Aug 2025 15:04:55 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LAhlddiRKIugye5q7FVrWtuOviVnypX9ycm0KgoHfglG5iPPn7dA54JQcVHVGWGoGPRGSTmqLNJKpL6JrwXLvoPJHdyUlASBCyB1If0GUDSuxlD1Qcpcts2lH1hdMOUDaDWeGDO6mL2I+rv8vHleg6yoa0xmgWPTdlb2uPOuDVHPwM7Z5+J/gNMPbQnuCD7Bk8nvGhbJnQnfauTjge43Aa37dChk5FTUtbwWrLerrj0eD+Vrc5hNOeI2SmnRU85FaKTMVcZWtBv/dn6bN/DPN9kby3jHGYUpmE3BB3e9Yvdh8+OquUoTZiK1Xc2wsAAWhg2vjFfQu7kSGdGSAGYzKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l/1G6g4Z0VAHkdqySl7+PXW7ab7tV+fg/yyxF+yclHw=;
 b=cnXU/jgq2mLN7fbhBTq1V0EjqRlTespS5vTTCwSEo4rXy7Y8+zZpBAWBC1RKYIj4sJJ1gNOWEA3HJyjeA96gCE/aIzzfX/8sW16rA43JEcHOIoWD4ShEnZAXQ9R6Q9s5mlEjbgqZD3zaT1QEE4/z7te6V/1+Xr3v+0fDTX2kKlHvz1YsVbWB7tMV5uyQ5o1D2jSRUowCZjkKOOhe9VHvGSEvU+bPs2XuGaqG5xw7t540+gUtnEEsacddoyWaGR2biHwjGHLnbhva7NqyHdbh1rlHYOOTjdo3RMadeO85sJlUM2bIgIUuvAO9L4ZR0b3frde8jphZQlPbU4zjUvPx1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l/1G6g4Z0VAHkdqySl7+PXW7ab7tV+fg/yyxF+yclHw=;
 b=Zh893f8xEV+VoJMc9fKGhbARugUEl7S1aTI68UVS2e2aoAYO/imdU7AhFUEitpjTVWxEhDYTtPnGZLfGCxczsJra85ILbPdizU2x+p2dAGtQGQe3gJbhG1jjJPbg1aRZFWPTj+NZ9XpfePlil7MGmSqnmSyhsuViz9N1pTsm/Bw=
Received: from SEZPR03MB8273.apcprd03.prod.outlook.com (2603:1096:101:19a::11)
 by KL1PR03MB8305.apcprd03.prod.outlook.com (2603:1096:820:115::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.20; Tue, 12 Aug
 2025 07:04:52 +0000
Received: from SEZPR03MB8273.apcprd03.prod.outlook.com
 ([fe80::f7ac:70cb:3cb4:acac]) by SEZPR03MB8273.apcprd03.prod.outlook.com
 ([fe80::f7ac:70cb:3cb4:acac%5]) with mapi id 15.20.9009.018; Tue, 12 Aug 2025
 07:04:51 +0000
From: =?utf-8?B?TGlqdS1jbHIgQ2hlbiAo6Zmz6bqX5aaCKQ==?=
	<Liju-clr.Chen@mediatek.com>
To: "corbet@lwn.net" <corbet@lwn.net>, "krzk@kernel.org" <krzk@kernel.org>,
	"mhiramat@kernel.org" <mhiramat@kernel.org>,
	=?utf-8?B?WWluZ3NoaXVhbiBQYW4gKOa9mOepjui7kik=?=
	<Yingshiuan.Pan@mediatek.com>, "rostedt@goodmis.org" <rostedt@goodmis.org>,
	"robh@kernel.org" <robh@kernel.org>, "mathieu.desnoyers@efficios.com"
	<mathieu.desnoyers@efficios.com>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"will@kernel.org" <will@kernel.org>, "richardcochran@gmail.com"
	<richardcochran@gmail.com>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	"matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
	=?utf-8?B?WmUteXUgV2FuZyAo546L5r6k5a6HKQ==?= <Ze-yu.Wang@mediatek.com>,
	"catalin.marinas@arm.com" <catalin.marinas@arm.com>, "AngeloGioacchino Del
 Regno" <angelogioacchino.delregno@collabora.com>
CC: =?utf-8?B?S2V2ZW5ueSBIc2llaCAo6Kyd5a6c6Iq4KQ==?=
	<Kevenny.Hsieh@mediatek.com>, =?utf-8?B?U2hhd24gSHNpYW8gKOiVreW/l+elpSk=?=
	<shawn.hsiao@mediatek.com>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, =?utf-8?B?UGVpTHVuIFN1ZWkgKOmai+WfueWAqyk=?=
	<PeiLun.Suei@mediatek.com>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-mediatek@lists.infradead.org"
	<linux-mediatek@lists.infradead.org>, "linux-trace-kernel@vger.kernel.org"
	<linux-trace-kernel@vger.kernel.org>,
	=?utf-8?B?Q2hpLXNoZW4gWWVoICjokYnlpYfou5Ip?= <Chi-shen.Yeh@mediatek.com>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
Subject: Re: [PATCH v13 04/25] virt: geniezone: Add GenieZone hypervisor
 driver
Thread-Topic: [PATCH v13 04/25] virt: geniezone: Add GenieZone hypervisor
 driver
Thread-Index: AQHbNn029Xq+tnHy3U+kHaTtB6IkebLg5LqAgX9dFQA=
Date: Tue, 12 Aug 2025 07:04:51 +0000
Message-ID: <cb84d8d87a67516f9b92a89f81fe4efc088f7617.camel@mediatek.com>
References: <20241114100802.4116-1-liju-clr.chen@mediatek.com>
	 <20241114100802.4116-5-liju-clr.chen@mediatek.com>
	 <7b79d4b5-ba91-41a0-90d1-c64bcab53cec@kernel.org>
In-Reply-To: <7b79d4b5-ba91-41a0-90d1-c64bcab53cec@kernel.org>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR03MB8273:EE_|KL1PR03MB8305:EE_
x-ms-office365-filtering-correlation-id: cc1d0db1-6fed-4024-58ac-08ddd96e8871
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024|921020|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?amZ6TUVwWEd2OHM1amFzNWZnY2x2WlZ4YXVHUi9rd0pWclVGM3VDMTFsT3dx?=
 =?utf-8?B?V083U04xU2JNQVllNWlIOFVNWXNxOVoxZTdNUFhQMHEvcmZYUXJadFZMTWZU?=
 =?utf-8?B?cDhJMkFqYVkxWFdQMVFMOUZGV2ZnZE1ETGxQdUo4S3gyNUowdm1namRSNkwz?=
 =?utf-8?B?dFN3SkJmVDNTbXNTanpBajloalNWeHpwcXBvWkxhUGt2MzIyTHBDTzllRkJh?=
 =?utf-8?B?VUFjZEp0bzA1djY1S2hmSU5Bb0lkTWFYbWUrWE9rMlRIUlZiWUxqOTNCcjNC?=
 =?utf-8?B?eTFrUVFDNlcwaUNjUzgxNEVwcDcwUW1ib1RGY2NrNmU1MFgwUitCbjlBNjBs?=
 =?utf-8?B?ajJOOXM4L2ErTSs1WEJ2TWxCK0RrNFJlQTV6TGdYYis0MDY3RVNMb3liV0pn?=
 =?utf-8?B?cm1IREhRVGZoa1dnWTVmMGVILy9ORzhWUFlWZFFkU0pXZlpzQjlJVTgyK0Jm?=
 =?utf-8?B?WHdaWjJUVDNZVThaNlpGeGkwWCthWGVOMVJKSzhjQnIvWXdWTTc3SHJjc0M3?=
 =?utf-8?B?amxMRkxQendPY2s0cURrRjVwNXc1OXZ4cmx4Z1lBcU9VTW1FaFl4d2tpTnU0?=
 =?utf-8?B?dFh0T0V6aXZUNlBRMUEyRXFtT1ZsSjFyek83dVlkVGpQVEFEUjJkME5YTlZr?=
 =?utf-8?B?eGRtWmUzMFlrNENDYjhSUVhtNHJ1UUhnckQ2RzkxVUdkV0RKb05rTjZhOFBC?=
 =?utf-8?B?MFBPTzlDMktTa0hCckZvM0tPaklDZUNVTHNyNVpyVnBJcnRQT3IvYUx6dk9t?=
 =?utf-8?B?eWd2bXBGNVZLeGF5UmpxL0VnNXBWcFNicjRaMjNDNjJ0QStHaEJHL04ydDVk?=
 =?utf-8?B?anJHTGQyeHI3Y09uVWRJaHpKSFdyTWdsaHhvT3NteXE3aGhRYWRYSWQ1aGRu?=
 =?utf-8?B?NEdaT0htTWJibVY4VHNzdVdsWHZUaGNkVytTdFU3TUZVeTV3MHRwbitxZTBs?=
 =?utf-8?B?NlVJVWRuODBhdzlwUWR2eEpqUDFiaFdrVjZaeDh2eXNtQ2VLaVB1NUJFU0lW?=
 =?utf-8?B?b3hUYTVmcUV1aU9XQm9FV3BqZjVxQ2NFUis4TnI4WkF0MFRuc3dTeHV6MEtO?=
 =?utf-8?B?SUNHTGpKcVp5cHBmbTBjTlFMcmtuWmZXSlo5WitQUDVxdzhtRkpMdTNYT0dS?=
 =?utf-8?B?Wk5nVnR1Wm1zczBWRThjWXFKVGNuZU1MMnlTeHJIT2E3Ky9nT25qNmg0VktP?=
 =?utf-8?B?VjFmTWhUUUphL1doem85dEdZb2NsME1EemZDNzU3ei9tc0NoNmRkK3RmQktX?=
 =?utf-8?B?WU1Lc3BRL2Z4LzVPYTl6UGNGTzh2dG9UMkxhMmF5Y1pGUzJITVlvOWdoR2ZI?=
 =?utf-8?B?Y0dJaHQvWGh3NXE0djgzUEI3UlhVNjBqVG1weVp1QUc0TFo0dU1lWDM1S2FR?=
 =?utf-8?B?bUxLNWxIM2NvMnVuU2lWalphZFFrVXd1Mm13aTJVV0l5NE5HNVkydTJvOEVN?=
 =?utf-8?B?ZjZOcWkycG9MZE00djYvZ3FzWUFRdkFGbVBOdW9uYkZhOWUwdTdnaE1GNlpT?=
 =?utf-8?B?dHhIRGU1WnczbVgwZmJsNllCand3V3AzVGN3ZlF5OVE2aDdPd0UyVnJucHRE?=
 =?utf-8?B?UDFrZXNpcThQZ2xtVTc3VWpIYnoxWnkyZUJFRnlUNEtNZHFRdG43UkYrYU9D?=
 =?utf-8?B?enY2Rlk3QW5PZUtkRmhudkl1bjRuVTNySVd5bUVHUDBJQ3Z0cmhadTRFbnJr?=
 =?utf-8?B?RXNEb1NYcnAzS3Yvb2xSZjBIcDBKUm1nM3lJZEYvdXVsMWxoYWF6c0N4UWFj?=
 =?utf-8?B?NnlPc2hDZUdxT3p5alI3SitCMVVERExJc2FabzN5RFVPeTR3WTJRQmo4aGdk?=
 =?utf-8?B?NkNCbnp5cUdjZlExNk83NE90S0NSbXFsWGxuNklHMHNsaDFDemRFbTVpczA0?=
 =?utf-8?B?QTVuU3Rma2VoY2tpQURnakp3a1RVc2pYK25nZHJ0cnN1VTVUUnJKWk5teU1W?=
 =?utf-8?B?MktDTGFhb2lGN01zeHBtTHBmSjNZWUhGNFpYOGNHcFRCS0F4YzhnUnRsaThp?=
 =?utf-8?B?RDdjVVpqZEQ0RUdlSjVRVE9nek0wcGVYdTF0VzBCM1ZzVDZGRk9PQ3g3VWdU?=
 =?utf-8?Q?DAYHKu?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR03MB8273.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(921020)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?em9zRnFyL3ZVaDQ2K3BYVHdsaTA3MzVUTGJSWXNtQm5Db0FiV0dPd01GRXg5?=
 =?utf-8?B?SHBTTHd2V0crT1VjaVc5RXp0NVBBbHRobUcvK213V3JZeHIyZVZMNXNnNW1s?=
 =?utf-8?B?bUJxZGxtUzNLR2szR3BWMEpBWEZpVFU1ODExYVBlWUZzUUdwdHRQY0FXZjl3?=
 =?utf-8?B?YjJTV0xaWS8xdG44SDZibzB0elVuK2VsNUo1YTU0WjZSbFpRMkozdE9GRFVi?=
 =?utf-8?B?REl3WDRUcDg2M0dHUkI5ckZ5YlFaTzFlNGpMcXZ1bnpUbjN5S0h3YVRBY0tM?=
 =?utf-8?B?Y3o3MldTbzZuSGJVb0dxR0xldVBVWTE3SkJlMG5RUUg0YTM0OExibGtvSDc5?=
 =?utf-8?B?TmhtM2VlMWVCSDVSL0R1aExMeFBtNU50Wk1EQXpZWUwxTlc5ejc3Sm0rSWpK?=
 =?utf-8?B?UTZ6KzJNOXR2OS9nWWd4aHpOYnpKS2l2TFNCVDdTV3I3OHVmUXhYMHplVHJh?=
 =?utf-8?B?KzNJM2loZ3VmUDVDaFBtWlFQeTRPRUlSV0lhYVNRcXlKaDFBMVlNMllUWExZ?=
 =?utf-8?B?dE1qdWhGQ0FkUS9YaVhJdFZNeGhNOW42Wi9JU3djUTVDSk5BVnhQLzVGKzVE?=
 =?utf-8?B?bUpRWWZhTmE3VHdobFN4aVh2eS9QZ1NOZ3p1dUlpVUw0azlWRHVNYzlUT2lz?=
 =?utf-8?B?eUJXeElNaHJhb00yZDZrRVEyc1NjQzhJdmRFRzlRc0V3cEJKOVUweGZOZjJ6?=
 =?utf-8?B?TTkzaGtGU2FXK05rRHFUWEJudFNxakJkemdxcGdkWno4WVZRV09Dc2c5OVBJ?=
 =?utf-8?B?MmYvUlZTWmZUa28vaUo2a0NZVjRlcWZQMk9GQ0RJWExWVjVqcjYyK09ib3JW?=
 =?utf-8?B?TmtVVzl2RXVOK2pubnpySGFyYldiOWZzam1sUDhVejM4eWdOUXlWYWxBUE1t?=
 =?utf-8?B?azU3djR4Rk1sL2Z2R29LV1JER1NSdWxscElvalpMTC9vWFRkTEFhWU0wNDBH?=
 =?utf-8?B?Vk53RENvRWswYUs0TkFVaWVYUmdnZ05EakFxeHZxZzZWa2ZqSnkwNE15VXhW?=
 =?utf-8?B?QXR5NEgxWk85aWFsQlRmMnFjU3lsZERkWTZPeFErWEFCQncvNm9FcEZ3aDVJ?=
 =?utf-8?B?QkZSNTc1OFEzM2YwVFE2dnloMytlcHpLNEs0N1AxRFhVaXJEblp0UUNJMnNy?=
 =?utf-8?B?am1RYlkvc05nOW1TTXJMeEhpYmhBRGtiVGNkN0dLa2V2R0xWY1JXdkRFMzVQ?=
 =?utf-8?B?VEZCaG9MeUQ2cXFMYzFPZ1BPRnFxc0cxSmgyQWlmTTZQbnA4MXlObW5QN0Nh?=
 =?utf-8?B?U2dEbitWNnJ2bnZ3M1hYK2JvOEJsMndjaHV6dnMzVGlmN1hxdStCaVpOZFdo?=
 =?utf-8?B?KzZiY1FiUXZYM1o4b3dRaDVhSGhtTU4ySFZaVUJwbDluc01HTld5MWxyVStE?=
 =?utf-8?B?THpIclNRUnMvbHpSQWRuOFpNTTNCbytLaFhDZ3JBOU45UDc4dE16eG1lM05F?=
 =?utf-8?B?bHZoMXdmTk8zN2RZQkw2QkR3RmlLZk9QUHhaQzNJYjM2dUdnOGVBZE8wdkVo?=
 =?utf-8?B?VVdCckdETCs3UXN2b0ZEcXMzd3JCUmcvMnlzbnBMN0Q1RHJ4ekdYcDF6TDRI?=
 =?utf-8?B?VllJUGFzYzZNSTBWTjNHS3dGRktDeDltc3VkS3NSRUd5MEhZYndSRE9UaUJp?=
 =?utf-8?B?MHM5cEs4dlh4VHh0SW1ESW1TdEtiSk9MTndxR29lU0dMZmoxWEg4bWNISUh0?=
 =?utf-8?B?QzJveWx6MGsvcDFXenpFQmphdEhhSGdGYmlKUXMrTnJjS3JUQ1diYVI5VjJr?=
 =?utf-8?B?MUhlelZSNFk4UnBDdlBRTHpmWXNNVEozMzdicmtPZEFtQTJQcWpOdmcwQTRD?=
 =?utf-8?B?emIvc2FjcjZtMXRwMTk4bUlQVHFOM1ZJVUZYQXB4OUU5eUZlNlMxRlpsaW4y?=
 =?utf-8?B?aDlOa1FDQUZ5dVN1dnhhS3JpQWxPN2VxN3B6UEQ1VTA0T2gzTUNEU284ejhp?=
 =?utf-8?B?NmpHUWRQN1F2bnkwMHFRYW9NeFdWM1Y0RDZwTVBOWnBmK3JiSk9wZ293bHd1?=
 =?utf-8?B?UEplZEV1TUZiaCtLekpnYTV3UzhTTURsbW55Wld2c1o4ZjUyaWdidWJ3MmNW?=
 =?utf-8?B?TEExNDRCSFJXakhGUFFudUE4NHRSMVpuQVNGSHNoQkFHaCtCRjcwSUlKUlNE?=
 =?utf-8?B?am4xbWZqenZwZXVkUEFLWCtqdEJLbkRuZTMzREo1cE5pcHZmcVBoWVRFbHhB?=
 =?utf-8?B?MWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5F469BC1D3156348AAB655B2A9EC52F0@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR03MB8273.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc1d0db1-6fed-4024-58ac-08ddd96e8871
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Aug 2025 07:04:51.5108
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OPqUkM+RNE+fFSZbZSP8F2viTxixjm9Lu32yLYGbtg+ya5k31zLsOSEmZI0pb181Nmb5lV3dj7kucpXQAfelNWYdUwp8Ilj2b9KouwWisq0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB8305

T24gV2VkLCAyMDI0LTEyLTExIGF0IDA5OjQ0ICswMTAwLCBLcnp5c3p0b2YgS296bG93c2tpIHdy
b3RlOg0KPiANCj4gRXh0ZXJuYWwgZW1haWwgOiBQbGVhc2UgZG8gbm90IGNsaWNrIGxpbmtzIG9y
IG9wZW4gYXR0YWNobWVudHMgdW50aWwNCj4geW91IGhhdmUgdmVyaWZpZWQgdGhlIHNlbmRlciBv
ciB0aGUgY29udGVudC4NCj4gDQo+IA0KPiBPbiAxNC8xMS8yMDI0IDExOjA3LCBMaWp1LWNsciBD
aGVuIHdyb3RlOg0KPiA+ICsNCj4gPiArc3RhdGljIGludCBnenZtX2Rldl9vcGVuKHN0cnVjdCBp
bm9kZSAqaW5vZGUsIHN0cnVjdCBmaWxlICpmaWxlKQ0KPiA+ICt7DQo+ID4gK8KgwqDCoMKgIC8q
DQo+ID4gK8KgwqDCoMKgwqAgKiBSZWZlcmVuY2UgY291bnQgdG8gcHJldmVudCB0aGlzIG1vZHVs
ZSBpcyB1bmxvYWQgd2l0aG91dA0KPiA+IGRlc3Ryb3lpbmcNCj4gPiArwqDCoMKgwqDCoCAqIFZN
DQo+IA0KPiBTbyB5b3UgcmUtaW1wbGVtZW50ZWQgc3VwcHJlc3MtYmluZCBhdHRycy4uLiBubywg
ZHJvcC4NCj4gDQoNClRoYW5rcywgd2lsbCBmaXggaW4gbmV4dCB2ZXJzaW9uLg0KDQo+ID4gK8Kg
wqDCoMKgwqAgKi8NCj4gPiArwqDCoMKgwqAgdHJ5X21vZHVsZV9nZXQoVEhJU19NT0RVTEUpOw0K
PiA+ICvCoMKgwqDCoCByZXR1cm4gMDsNCj4gPiArfQ0KPiA+ICsNCj4gPiArc3RhdGljIGludCBn
enZtX2Rldl9yZWxlYXNlKHN0cnVjdCBpbm9kZSAqaW5vZGUsIHN0cnVjdCBmaWxlDQo+ID4gKmZp
bGUpDQo+ID4gK3sNCj4gPiArwqDCoMKgwqAgbW9kdWxlX3B1dChUSElTX01PRFVMRSk7DQo+ID4g
K8KgwqDCoMKgIHJldHVybiAwOw0KPiA+ICt9DQo+ID4gKw0KPiA+ICtzdGF0aWMgY29uc3Qgc3Ry
dWN0IGZpbGVfb3BlcmF0aW9ucyBnenZtX2NoYXJkZXZfb3BzID0gew0KPiA+ICvCoMKgwqDCoCAu
bGxzZWVrwqDCoMKgwqDCoMKgwqDCoCA9IG5vb3BfbGxzZWVrLA0KPiA+ICvCoMKgwqDCoCAub3Bl
bsKgwqDCoMKgwqDCoMKgwqDCoMKgID0gZ3p2bV9kZXZfb3BlbiwNCj4gPiArwqDCoMKgwqAgLnJl
bGVhc2XCoMKgwqDCoMKgwqDCoCA9IGd6dm1fZGV2X3JlbGVhc2UsDQo+ID4gK307DQo+ID4gKw0K
PiA+ICtzdGF0aWMgc3RydWN0IG1pc2NkZXZpY2UgZ3p2bV9kZXYgPSB7DQo+ID4gK8KgwqDCoMKg
IC5taW5vciA9IE1JU0NfRFlOQU1JQ19NSU5PUiwNCj4gPiArwqDCoMKgwqAgLm5hbWUgPSBLQlVJ
TERfTU9ETkFNRSwNCj4gPiArwqDCoMKgwqAgLmZvcHMgPSAmZ3p2bV9jaGFyZGV2X29wcywNCj4g
PiArfTsNCj4gPiArDQo+ID4gK3N0YXRpYyBpbnQgZ3p2bV9kcnZfcHJvYmUoc3RydWN0IHBsYXRm
b3JtX2RldmljZSAqcGRldikNCj4gPiArew0KPiA+ICvCoMKgwqDCoCBpZiAoZ3p2bV9hcmNoX3By
b2JlKGd6dm1fZHJ2LmRydl92ZXJzaW9uLA0KPiA+ICZnenZtX2Rydi5oeXBfdmVyc2lvbikgIT0g
MCkgew0KPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZGV2X2VycigmcGRldi0+ZGV2LCAi
Tm90IGZvdW5kIGF2YWlsYWJsZSBjb25kdWl0XG4iKTsNCj4gDQo+IFNvIHlvdSBjYW4gYXV0b2Rl
dGVjdCB5b3VyIGh5cGVydmlzb3I/IFdoeSB5b3VyIHNvYyBpbmZvIGRyaXZlcnMNCj4gY2Fubm90
DQo+IGluc3RhbnRpYXRlIHRoaXMgZGV2aWNlIHRodXMgcmVtb3ZpbmcgYW55IG5lZWQgZm9yIGZh
a2UgRFQgbm9kZSAoZmFrZQ0KPiBiZWNhdXNlIG5vIHJlc291cmNlcyBhbmQgdXNlZCBvbmx5IHRv
IHNhdGlzZnkgTGludXggZHJpdmVyDQo+IGluc3RhbnRpYXRpb24pPw0KPiANCj4gDQpIaSBLcnp5
c3p0b2YsDQoNCkknbSBmb2xsb3dpbmcgdXAgcmVnYXJkaW5nIHlvdXIgcmVjZW50IGZlZWRiYWNr
IG9uIHRoZSBNVEsgU29DIGRyaXZlcg0KaW5zdGFudGlhdGlvbiwgYXMgd2VsbCBhcyB5b3VyIGVh
cmxpZXIgY29uY2VybnMgYWJvdXQgcHJvYmluZyBmb3IgdGhlDQpoeXBlcnZpc29yIG9uIGFsbCBz
eXN0ZW1zLg0KDQpUbyByZWNhcCB5b3VyIHByZXZpb3VzIGNvbW1lbnQgWzFdOg0KDQo+IFNvIGZv
ciBldmVyeSBzeXN0ZW0gYW5kIGFyY2hpdGVjdHVyZSB5b3Ugd2FudCB0bzogcHJvYmUsIHJ1biBz
b21lIFNNQw0KPiBhbmQgdGhlbiBwcmludCBlcnJvciB0aGF0IGl0IGlzIG5vdCBvdGhlIHN5c3Rl
bSB5b3Ugd2FudGVkLg0KPg0KPiBJIGRvbid0IHRoaW5rIHRoaXMgaXMgd2hhdCB3ZSB3YW50LiBZ
b3UgYmFzaWNhbGx5IHBvbGx1dGUgYWxsIG9mDQpvdGhlcg0KPiB1c2VycyBqdXN0IHRvIGhhdmUg
eW91ciBoeXBlcnZpc29yIGd1ZXN0IGFkZGl0aW9ucy4uLg0KDQpXZSB1bmRlcnN0YW5kIHRoZSBj
b25jZXJuIGFib3V0IHVubmVjZXNzYXJ5IHByb2JpbmcgYW5kIHBvdGVudGlhbA0KaW1wYWN0IG9u
IHBsYXRmb3JtcyB0aGF0IGRvIG5vdCBzdXBwb3J0IHRoZSBHZW5pZVpvbmUgaHlwZXJ2aXNvci4N
Ckhvd2V2ZXIsIHVzaW5nIGEgZ2VuZXJpYyBTb0MgaW5mbyBkcml2ZXIgaXMgbm90IHByYWN0aWNh
bCBpbiBvdXIgY2FzZSwNCmFzIG5vdCBhbGwgcHJvZHVjdHMgYmFzZWQgb24gdGhlIHNhbWUgU29D
IHN1cHBvcnQgdGhlIGh5cGVydmlzb3Igb3INCnJlcXVpcmUgdGhlIGd6dm0gZHJpdmVyLg0KDQpQ
cmV2aW91c2x5LCB3ZSBhdHRlbXB0ZWQgYSBkZXZpY2UgdHJlZSBzb2x1dGlvbiwgYnV0IGFzIFJv
YiBhbmQgQ29ub3INCnBvaW50ZWQgb3V0LCBpbnRyb2R1Y2luZyBhIERUIG5vZGUgd2l0aG91dCBo
YXJkd2FyZSByZXNvdXJjZXMgaXMgbm90DQphY2NlcHRhYmxlIGZvciB1cHN0cmVhbWluZy4NCg0K
R2l2ZW4gdGhlc2UgY29uc3RyYWludHMsIHdlIGFyZSBjb25zaWRlcmluZyByZXZlcnRpbmcgdG8g
dGhlIG9yaWdpbmFsDQphcHByb2FjaCwgd2hlcmUgdGhlIGRyaXZlciBwcm9iZXMgZm9yIHRoZSBo
eXBlcnZpc29yJ3MgcHJlc2VuY2UNCmRpcmVjdGx5IHZpYSBIVkMuIFRvIGFkZHJlc3MgeW91ciBj
b25jZXJuIGFib3V0IHN5c3RlbS13aWRlIHBvbGx1dGlvbiwNCndlIGhhdmUgZ3VhcmRlZCB0aGUg
Z3p2bSBkcml2ZXIgd2l0aCB0aGUgQ09ORklHX01US19HWlZNIEtjb25maWcNCm9wdGlvbi4gVGhp
cyBlbnN1cmVzIHRoZSBjb2RlIGlzIG9ubHkgY29tcGlsZWQgYW5kIGFjdGl2ZSBvbiBzZWxlY3Rl
ZA0KcGxhdGZvcm1zLCBhbmQgd2lsbCBub3QgYWZmZWN0IG90aGVyIHVzZXJzIG9yIHN5c3RlbXMu
DQoNCklmIHlvdSBoYXZlIGFueSBmdXJ0aGVyIHN1Z2dlc3Rpb25zIG9yIHNlZSBhIGJldHRlcg0K
c29sdXRpb24gZm9yIHRoaXMgc2NlbmFyaW8sIHdlIHdvdWxkIGFwcHJlY2lhdGUgeW91ciBhZHZp
Y2UuDQoNClRoYW5rcyBmb3IgeW91ciB0aW1lIGFuZCBmZWVkYmFjay4NCg0KWzFdDQpodHRwczov
L2xvcmUua2VybmVsLm9yZy9hbGwvMmZlMGM3ZjktNTVmYy1hZTYzLTM2MzEtODUyNmEwMjEyY2Nk
QGxpbmFyby5vcmcvDQoNCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJldHVybiAtRU5P
REVWOw0KPiA+ICvCoMKgwqDCoCB9DQo+ID4gKw0KPiA+ICvCoMKgwqDCoCBwcl9kZWJ1ZygiRm91
bmQgR2VuaWVab25lIGh5cGVydmlzb3IgdmVyc2lvbiAldS4ldS4lbGx1XG4iLA0KPiA+ICvCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBnenZtX2Rydi5oeXBfdmVyc2lvbi5tYWpvciwNCj4gPiBn
enZtX2Rydi5oeXBfdmVyc2lvbi5taW5vciwNCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgZ3p2bV9kcnYuaHlwX3ZlcnNpb24uc3ViKTsNCj4gPiArDQo+ID4gK8KgwqDCoMKgIHJldHVy
biBtaXNjX3JlZ2lzdGVyKCZnenZtX2Rldik7DQo+ID4gK30NCj4gPiArDQo+ID4gK3N0YXRpYyB2
b2lkIGd6dm1fZHJ2X3JlbW92ZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KPiA+ICt7
DQo+ID4gK8KgwqDCoMKgIG1pc2NfZGVyZWdpc3RlcigmZ3p2bV9kZXYpOw0KPiA+ICt9DQo+ID4g
Kw0KPiA+ICtzdGF0aWMgY29uc3Qgc3RydWN0IG9mX2RldmljZV9pZCBnenZtX29mX21hdGNoW10g
PSB7DQo+ID4gK8KgwqDCoMKgIHsgLmNvbXBhdGlibGUgPSAibWVkaWF0ZWssZ2VuaWV6b25lIiB9
LA0KPiA+ICvCoMKgwqDCoCB7Lyogc2VudGluZWwgKi99LA0KPiA+ICt9Ow0KPiA+ICsNCj4gPiAr
c3RhdGljIHN0cnVjdCBwbGF0Zm9ybV9kcml2ZXIgZ3p2bV9kcml2ZXIgPSB7DQo+ID4gK8KgwqDC
oMKgIC5wcm9iZSA9IGd6dm1fZHJ2X3Byb2JlLA0KPiA+ICvCoMKgwqDCoCAucmVtb3ZlID0gZ3p2
bV9kcnZfcmVtb3ZlLA0KPiA+ICvCoMKgwqDCoCAuZHJpdmVyID0gew0KPiA+ICvCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgLm5hbWUgPSBLQlVJTERfTU9ETkFNRSwNCj4gPiArwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIC5vZl9tYXRjaF90YWJsZSA9IGd6dm1fb2ZfbWF0Y2gsDQo+ID4gK8KgwqDC
oMKgIH0sDQo+ID4gK307DQo+ID4gKw0KPiA+ICttb2R1bGVfcGxhdGZvcm1fZHJpdmVyKGd6dm1f
ZHJpdmVyKTsNCj4gPiArDQo+ID4gK01PRFVMRV9ERVZJQ0VfVEFCTEUob2YsIGd6dm1fb2ZfbWF0
Y2gpOw0KPiANCj4gVGhpcyBpcyBpbW1lZGlhdGVseSBhZnRlciBuZXh0IHRvIElEIHRhYmxlLiBO
ZXZlciBpbiBkaWZmZXJlbnQgcGxhY2UsDQo+IHNvDQo+IEkgd29uZGVyIGZyb20gd2hpY2ggb2Jz
Y3VyZSBjb2RlIGRpZCB5b3UgY29weSBpdCBhbmQgd2hhdCBvdGhlcg0KPiBpc3N1ZXMNCj4gbGlr
ZSB0aGF0IHdlIGNhbiBmaW5kLi4uDQo+IA0KDQpUaGFua3MsIHdpbGwgZml4IGluIG5leHQgdmVy
c2lvbi4NCg0KPiA+ICtNT0RVTEVfQVVUSE9SKCJNZWRpYVRlayIpOw0KPiA+ICtNT0RVTEVfREVT
Q1JJUFRJT04oIkdlbmllWm9uZSBpbnRlcmZhY2UgZm9yIFZNTSIpOw0KPiA+ICtNT0RVTEVfTElD
RU5TRSgiR1BMIik7DQo+IEJlc3QgcmVnYXJkcywNCj4gS3J6eXN6dG9mDQoNCg==

