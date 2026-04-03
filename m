Return-Path: <netdev+bounces-274950-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uKs8N22Az2mvwgYAu9opvQ
	(envelope-from <netdev+bounces-274950-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 10:55:09 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CAA40392631
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 10:55:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4CCA8301B7A7
	for <lists+netdev@lfdr.de>; Fri,  3 Apr 2026 08:55:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB81B383C7F;
	Fri,  3 Apr 2026 08:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="dm4GM8MM";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="vJHlTAXM"
X-Original-To: netdev@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB0C93806B3;
	Fri,  3 Apr 2026 08:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775206492; cv=fail; b=SszwlWlAAzF7kg0eKksFt72hK1jxnX1UGMP/K0wChbtEa2bWcJhRHfUe3pn7b6se+nfE+urjIIGkgC+sFE4dsaRrhsRPtfnjytK/mhKJPQYiZATAufJH+SXCtdfWHM/gAVZjEWjCqahafxDA29Muw26eyMYfTv7iV20jRNKm1Ek=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775206492; c=relaxed/simple;
	bh=749l+8tmuSGDLXg49Hfrlvxrxrf3wW2fMXTmsAj8E9g=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=OmeXU0G7AEkZvjXwVbkAtfEhzqDU64AZDVCxOA6Aelnk0mtk6JXy9X9iy8Cva0j3DqAwYOL97NkFzFA6jyu7LyuWdURz5/T8s9CbzpbbK1A2AqprKTlFhZwGV8+Gtopi21CNc7OSxP93yRS673INFZunrNBXwHSV7zXtNIgrlXA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=dm4GM8MM; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=vJHlTAXM; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: c22405a82f3a11f1ae70033691e9ac7d-20260403
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=749l+8tmuSGDLXg49Hfrlvxrxrf3wW2fMXTmsAj8E9g=;
	b=dm4GM8MMmxfFf9utn7d1quqUvl9tn2m8Z52qElYNkf8iHpnnYKUgULrB9Lvz1/qAjCEmIdFkvrG8qECR51LkVTJEIvLNsCFdV+Y5aOnjvM4dLdAnbiD0HNGrUvNwvDPZfBVCfoj20cbdGYVITaeegDsNyKxfXMswhkFdreIGHA0=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:669f3032-2bd3-4a94-91f9-86d061b24da4,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:e7bac3a,CLOUDID:d8048da7-e101-400a-acb5-0dbb5a913469,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|110|111|836|865|888|
	898,TC:-5,Content:-10|3|15|50,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,Q
	S:nil,BEC:-1,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,A
	RC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: c22405a82f3a11f1ae70033691e9ac7d-20260403
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw01.mediatek.com
	(envelope-from <jason-jh.lin@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1907524965; Fri, 03 Apr 2026 16:54:43 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Fri, 3 Apr 2026 16:54:42 +0800
Received: from SI4PR04CU002.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Fri, 3 Apr 2026 16:54:42 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GoRiyuB50lQvuRKGeA6MSFNAkRXrfvNM7rP5DVQ1vslZdw7G3jLO+UQPm+lRMynZXf5/8i3UrTDdm+jqSjyQqaWjILRCgHiaGI6srBLYOdb5dHUqLwTPTtkODzNXCECuGAu51zF8ELzijyytUWP7mAxfRF+ObCQS3QUSeyNdaCrLaSOvFglFJxEUwu0XXngqgkeRW5LiOI1/3mGqTdc/S301GkxhZh4TthCJtAWA49kRBSW/ODwFO14Ue567dYak8kVPniqk4PYut+vpg+djVdOcx+7py0xb6gAu0FE5QrjCSXxqvpfuLQseH64rOY+2JSpm4fa5Lg1tQkisK9Ak2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=749l+8tmuSGDLXg49Hfrlvxrxrf3wW2fMXTmsAj8E9g=;
 b=Z/u7BroJo4sjET3Zd11tbPSF86yvyuqg0E48rTH7bGg41SHZjynTUPT8P+LIpNGPU6CgYQAr6fzq5KFRGJe/zHmXDUw0jRQkTZqSw/TKenD8nl00tm/07QyO+REgDCQ1wsImO3ZekWf+jnIWiy7pY5u2Xb0wbCQ5AXbO6IvinkZNFwe858jd9p8WHJ3y8oY4DLbqHovaE7g+u98qjrbj4cwn+M5uyATa7STgBaVKkZQgCW2KbLVGIGDE+RABVI5M8K9LVtbe+FIQ7D8qj2f/BztVT/xuuI34TshpWcd7V+SiDHw+OjSg3HbFGYfAs0dEIdXZNYXHc5bn0pkJjBGupw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=749l+8tmuSGDLXg49Hfrlvxrxrf3wW2fMXTmsAj8E9g=;
 b=vJHlTAXMMRifB4X++EQrnxFS2/0GaXZBilIMCwfNsxdTkEFqB9rTaqrio+GR92rudpbRvrtn+k1I/RxzKkFAF26nBjVpJGE1lL5q2FVj4mElIr/7GJsF4NMC5e1bXp9fWwoDySkLuYDU8RqiMmqPJj7rnWpLMjRCgA9fo1Dmd+U=
Received: from SEYPR03MB7682.apcprd03.prod.outlook.com (2603:1096:101:149::11)
 by TYZPR03MB7819.apcprd03.prod.outlook.com (2603:1096:400:464::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.20; Fri, 3 Apr
 2026 08:54:39 +0000
Received: from SEYPR03MB7682.apcprd03.prod.outlook.com
 ([fe80::1fe4:fb59:1b1:1646]) by SEYPR03MB7682.apcprd03.prod.outlook.com
 ([fe80::1fe4:fb59:1b1:1646%6]) with mapi id 15.20.9769.020; Fri, 3 Apr 2026
 08:54:39 +0000
From: =?utf-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= <Jason-JH.Lin@mediatek.com>
To: Laura Nao <laura.nao@collabora.com>
CC: =?utf-8?B?R3VhbmdqaWUgU29uZyAo5a6L5YWJ5p2wKQ==?=
	<Guangjie.Song@mediatek.com>, "robh@kernel.org" <robh@kernel.org>,
	"kernel@collabora.com" <kernel@collabora.com>,
	=?utf-8?B?U2lyaXVzIFdhbmcgKOeOi+eak+aYsSk=?= <Sirius.Wang@mediatek.com>,
	=?utf-8?B?TmFuY3kgTGluICjmnpfmrKPonqIp?= <Nancy.Lin@mediatek.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>,
	=?utf-8?B?UGF1bC1wbCBDaGVuICjpmbPmn4/pnJYp?= <Paul-pl.Chen@mediatek.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Project_Global_Chrome_Upstream_Group
	<Project_Global_Chrome_Upstream_Group@mediatek.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"richardcochran@gmail.com" <richardcochran@gmail.com>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "mturquette@baylibre.com" <mturquette@baylibre.com>,
	Nicolas Prado <nfraprado@collabora.com>, "p.zabel@pengutronix.de"
	<p.zabel@pengutronix.de>, =?utf-8?B?U2luZ28gQ2hhbmcgKOW8teiIiOWciyk=?=
	<Singo.Chang@mediatek.com>, "wenst@chromium.org" <wenst@chromium.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-clk@vger.kernel.org"
	<linux-clk@vger.kernel.org>, "matthias.bgg@gmail.com"
	<matthias.bgg@gmail.com>, "sboyd@kernel.org" <sboyd@kernel.org>
Subject: Re: [PATCH v5 23/27] clk: mediatek: Add MT8196 disp-ao clock support
Thread-Topic: [PATCH v5 23/27] clk: mediatek: Add MT8196 disp-ao clock support
Thread-Index: AQHcGNelXPSfqVm58E66r9ASuZOvZbXMoqQAgAA8LwCAAX5+AA==
Date: Fri, 3 Apr 2026 08:54:39 +0000
Message-ID: <04a1848e3ffb43fae727ca0110d57e81fe88a4a1.camel@mediatek.com>
References: <2d418383ff2d6ff40ffb3b4f8e2b0c0e665c3b58.camel@mediatek.com>
	 <20260402100538.27291-1-laura.nao@collabora.com>
In-Reply-To: <20260402100538.27291-1-laura.nao@collabora.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR03MB7682:EE_|TYZPR03MB7819:EE_
x-ms-office365-filtering-correlation-id: f396c047-9ab3-4385-6138-08de915ea3a8
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7416014|38070700021|22082099003|18002099003|56012099003;
x-microsoft-antispam-message-info: gxniqvuysKYY5PL5eU3rg9rRfKBbW134VbRVimALStZ0RkBUEU6vXtKcdKeYk300H5fCdtHdb45yDHdyPRq8kZtwtFnnzROgrOx4dzL9m6+iJQtgEWMUEt/+doo1mGm437YncjCG9RD0KjWIib44s3ijPkwDaz+Z8avGTQ78qv93Od/RFlhC42Cv6eQBgBrTdZ5aKMfbFf/Sz6CeoCJf9Cq1Lj6PgaoaWPyrGYWQDTmF6Bze8eQ+Oxb2zNeVrta0PvGtT03FX+v1lye5uiHkur1IMVWv+4fVnUtzGV7yZ3OJ/fPjt5xI6tCoB/q+8MEmu6w5to6Wr8MDGPXYmD8DJl4czHtYsk1432WfFJzITS25feZ/qlqrjxZVAyGUB9WZiE5EiFmTOuSgOHhXCzf64OIjBV1GVw9+sUkicLsIBYBwpZK3HpjfGAf6nHK9f0GE1vT1JiQN9goX9iIPwk/tD0kF21rzIvbEScFYPuuJyuVjTyGcztvCGGuhg0VglMQrLPp855G1nqhVsGA7x/+v5Wp8+23mQP9wwnmVv0T2OiaIfnVTX4ccIdY3elpP2f2gsuUydn/Xm3fhfO/jOteFMDvY0oyb4A9bjF2VGeH3aTGL2lTFts77Haa88hX/NXURgait4qKvI8bAC7jJewdykvS5rzfa+NKAuP0m2JHyiOyvjKPsfeW6ZiuV1DUQYWe76Xp+h/bx5/+KY5z2OBDzm2+/h7CYynJrSbsVbijo0yV3PsuEdiFe7XrQvdpX3YetX/2r+EI6jw2RNJebPmzXqA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR03MB7682.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7416014)(38070700021)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SmNvOGJ1eEIrUVZrbEppMkp6Ulk1Z0poZDAyYUlkdVZLMy8wV3J3bk5weklo?=
 =?utf-8?B?T0pWR0dtNTdaZjk3ZmFuK2poMzRzVElzVm5kYzBEZjIyWitKeUs4UWFCRUN2?=
 =?utf-8?B?azdmbk5yYnJFRnIrTVBaNWEzanJHK3JtdFpMQWUvcHFMdm4reCthUkN5OFc3?=
 =?utf-8?B?VHdnK1ozSFFtU1lnb0o0TWh2R1hBTWgyemZOQVYrR1dxWVRrbTdhYThhcTBZ?=
 =?utf-8?B?SEo0SWlHMDNEWVVmMDRvdnVnZDNBcXdwR2RaN2R6cjBSd1pra1luaHFQRnJi?=
 =?utf-8?B?NlV6WjNiUHM1ZEJ1eU1EQVNEZ1puaGVZMTQ2WUtUdjVhZG5lL1hrVUdJeE1o?=
 =?utf-8?B?Zk9hTHlsQ2haaVIyaE5Vc29UOXhYOXArZ3FsMzZmcnRma0tVT25Pa0Uyc09M?=
 =?utf-8?B?bElYallRdGdjQ1FtYnJPL0xORlArSkw0N0U1RVc1c3Z6VTgwUzZKd2RDd3lG?=
 =?utf-8?B?bUxVRDVXb3NvSXMwdEhkUnJKVkx3aG9PdzJURlRZRWZrTVpXMUFPbXVsQnJo?=
 =?utf-8?B?TEQwelM4YmpBM2VGK3pPUzhIL0NTRHFuZ1gzQ2oxU0FScEYveDhlNUczU0lD?=
 =?utf-8?B?RUNZZkxrWXZFNWNvckZ5Q3cyVStpVVJPbmNMYWErNGd6cSttSUFiWTIzL1da?=
 =?utf-8?B?ajhvb1l3aDBrLytNVm1mRnc2V05SRW16M3ByMitVMUFNSHFhdDdkbGpySS9S?=
 =?utf-8?B?Z2hLOW1OOWpXeG9DdXlUNHFDNDkrODdqdFVkTnRnM0F4STY3U0Q0dDI5Y0Q2?=
 =?utf-8?B?bEtnSGNOU1RiSWhQaVdST01qdnYrSnB5WjA5aUtmZk1Bc2F1WG1QSzVEQ2E1?=
 =?utf-8?B?MlB0US9zN1BwZnRLY0FvZWU0NzlhcmgxYytaN2E1aVdKTTdGV0Z5cFVNeEpq?=
 =?utf-8?B?R05nMVNpZytqMktQNVBENkZpT0JpWlRHcThQZWxZbXZUVE1tRXFWZytxNDIy?=
 =?utf-8?B?U0E1Nno0NVhUc1lZZ29rZDJOdCtzTlE3dER3dzMzOENveFBtVDIyUzZUSHVE?=
 =?utf-8?B?M1dobjZjSXlIOVpqR0QyeG9MQkZLbXNJSXFCc3FENDFoTElqZmIrZS94bGlF?=
 =?utf-8?B?TnMrTk50bW1HZ1JLeHYxOUFpbUdtNWlzWmVIZURtZ3NabVFiMmtrRHVmcitz?=
 =?utf-8?B?eTltQis0VENacmlhdkVmUWVFMHAwSkRwa1dKYThuQUd6c3FzMEtFVDd2TXlk?=
 =?utf-8?B?T3JhVURGdy9HaVkwSEZCWFlNOGQ5aFEwbG8wZ1l6OXUrUWREYmlRc1d5aUho?=
 =?utf-8?B?REJWdXE5ekI1OFFJUjhiQXJpc2trcmJqTGlrbk9kbGt1VUVMbEdteU9zandW?=
 =?utf-8?B?MEJTT0FuVUlRWEc5OUlnMElENGFEb2Y1aThvSzFmckFXQkZBVVF2c3p2WWVu?=
 =?utf-8?B?cXQrK2NzTUlyY0IxNDA3WjdCYlNJR1ppZjZsR1g3RmFkRi9rbENIRzJucXNV?=
 =?utf-8?B?OHRhdnZnSzQ0QSt2Z240dyticTVINk94ZnFOeFQ1eHV0dEdyV0NiN0F2VlFH?=
 =?utf-8?B?aWg5S3BPOWVESmN3WDdyODZJaThTQkJFL2UvVW1Sd2tKczZPYmx0TXNCQ1Y5?=
 =?utf-8?B?RU9jQmxqY1FqaUI4Wm5tWjFJYU83MXhJb21TQkdEMHZHZW16YUFmY2dERUpZ?=
 =?utf-8?B?ZnJnWUlibm9melFVaEhVdTNhLy9zRjF6QXdJeG4xbVQvZSs5VytaalZLem4x?=
 =?utf-8?B?N0dyaTVJL3BobU1IRWU4RWN0NEx6ZnpDVUZSajhHaDVrNjJYaVRiMUpBdXpI?=
 =?utf-8?B?bHNSSk1BcXdsbGJEbDVFSTltOG1mTUZERUpoNmg4eDI3U1BGWCtmSzRON1Z3?=
 =?utf-8?B?bDV0cU1TV2w5RG9EQkhmNHhRY3lNZ0NTd3p1UTdkeXZHN2tvRHJXWXptVE1U?=
 =?utf-8?B?bWEvVnhmUi9WQWNpejUyL1FuTlZHdkdjQVEyby91MGhxaXpVcDFDeFovNlo0?=
 =?utf-8?B?Wko0TVVwc2k2bzZ5Wmw2ZzhXN1g1MjZYUUZTeWtyVlE0QURJeHRnMTlvMFNK?=
 =?utf-8?B?azkraWRHaDlBbDh4eEY1c1doL1NoRmQ4b2lSbzNzY3hTZDdRbVNraFB4RHhJ?=
 =?utf-8?B?ZTcvTCt1Zms1U2dJcGpJcjZva09aYnVzay9DdVd3YlFlcHdHNUNCSXhReTRs?=
 =?utf-8?B?RCtxVVdQYTVkQWQ4RlZJUENwZnhGM3hlclVKdU90Q2FvcUhZZ2kxeVkxSnlu?=
 =?utf-8?B?ZmlsdEk0dlIzanlwbllxQUtLc2VZRGJxTy9TY25lUzVZRWxMdldNSlEvakps?=
 =?utf-8?B?b01UK3FScEQ0M0w4a0xSQW1lcFVXOTQvT0dWeURzd2tsQTloNU42cmtBWUZx?=
 =?utf-8?B?UFVtSTZqc2JLMTZMNk9RVWUvR1lqT3lydlhENGQ1cUI2bVNaNkMrYUhOMFpp?=
 =?utf-8?Q?PgrI0j+Kq3mcLHVU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6CEAD2A2AA83B048AFBFEFCA9F6728CC@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: HIyk6ZbZFJ/WvqlRHv5JMMOi2SEkvC08EMLsZqLJKF6nUIgYgvCSVPb2N4fOWAgBEuxtFCdN0IRMD0FULyX86cyDKA10PCENCI+C8wbJUrKPQThgViJRRies2eTG0yfbLXgmtDV9BMNwPnqxThrj3ajAg5GjiDP4Uu+V9lIMlZiODPMJPaL7Gg65V1wY857tm9b6P0uBz5+B8ECIU7K9JYMDD+KHu5UGZ16LpD8LNDnQF3inbGfQUjaFIVc+k2sA9MTAlBANUxsDl5ZMKKr5UMDHvsWKe72kMVmMb//5tUtBi5JOTxrnnnLWhlTOwEB8/PWkpprOvBN2k0ZxixvQqA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEYPR03MB7682.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f396c047-9ab3-4385-6138-08de915ea3a8
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Apr 2026 08:54:39.1434
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7PFMwQSo7GPFNI0MjlKGslA4kXg7tbX+fvpO/l2ofu7MXNcjT3oMHY5RCFmQTfjFR/R3CspH1+s0Q3pkhwVkxyPbcVYwYvVjkJIpywX78R8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB7819
X-MTK: N
X-Spamd-Result: default: False [2.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[mediatek.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[mediatek.com:s=dk,mediateko365.onmicrosoft.com:s=selector2-mediateko365-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[25];
	FREEMAIL_CC(0.00)[mediatek.com,kernel.org,collabora.com,lists.infradead.org,vger.kernel.org,gmail.com,baylibre.com,pengutronix.de,chromium.org];
	TAGGED_FROM(0.00)[bounces-274950-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,mediateko365.onmicrosoft.com:dkim,mediatek.com:dkim,mediatek.com:mid];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Jason-JH.Lin@mediatek.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[mediatek.com:+,mediateko365.onmicrosoft.com:+];
	NEURAL_HAM(-0.00)[-0.990];
	TAGGED_RCPT(0.00)[netdev,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: CAA40392631
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

W3NuaXBdDQoNCj4gPiA+ICtzdGF0aWMgY29uc3Qgc3RydWN0IG9mX2RldmljZV9pZCBvZl9tYXRj
aF9jbGtfbXQ4MTk2X3ZkaXNwX2FvW10NCj4gPiA+ID0gew0KPiA+ID4gKwl7IC5jb21wYXRpYmxl
ID0gIm1lZGlhdGVrLG10ODE5Ni12ZGlzcC1hbyIsIC5kYXRhID0NCj4gPiA+ICZtbV92X21jZCB9
LA0KPiA+IA0KPiA+IEhpIExhdXJhLA0KPiA+IA0KPiA+IFdlIGFyZSBnb2luZyB0byBzZW5kIG10
ay1tbXN5cyBkcml2ZXIgZm9yIE1UODE5NiByZWNlbnRseSwgYnV0IHdlDQo+ID4gZm91bmQNCj4g
PiB0aGUgY29tcGF0aWJsZSBuYW1lIGlzIHVzZWQgaGVyZS4NCj4gPiANCj4gPiBBcyB5b3VyIGNv
bW1pdCBtZXNzYWdlLCB2ZGlzcC1hbyBpcyBpbnRlZ3JhdGVkIHdpdGggdGhlIG10ay1tbXN5cw0K
PiA+IGRyaXZlciwgd2hpY2ggcmVnaXN0ZXJzIHRoZSB2ZGlzcC1hbyBjbG9jayBkcml2ZXIgdmlh
IA0KPiA+IHBsYXRmb3JtX2RldmljZV9yZWdpc3Rlcl9kYXRhKCkuDQo+ID4gDQo+ID4gU2hvdWxk
bid0IHRoaXMgY29tcGF0aWJsZSBuYW1lIGJlbG9uZyB0byBtbXN5cyBkcml2ZXIgZm9yIE1UODE5
Nj8NCj4gPiANCj4gDQo+IFRoYXQncyByaWdodCwgbXkgZmF1bHQgZm9yIG1pc3NpbmcgdGhhdCEg
VGhhbmtzIGZvciB0aGUgaGVhZHMgdXAuDQo+IA0KPiBJJ20gYXdhcmUgQW5nZWxvIGlzIGN1cnJl
bnRseSByZXN0cnVjdHVyaW5nIG1lZGlhdGVrLWRybSAoaW5jbHVkaW5nIA0KPiBtbXN5cyBhbmQg
bXV0ZXgpLCBhbmQgdGhhdCBtaWdodCBhZmZlY3QgdGhlIHdheSB2ZGlzcC1hbyBpcyBsb2FkZWQN
Cj4gdG9vLiANCj4gU28gSSdtIG5vdCBzdXJlIHdoZXRoZXIgaXQgbWFrZXMgc2Vuc2UgdG8gc2Vu
ZCBhIHBhdGNoIHRvIGZpeCB0aGlzIA0KPiByaWdodCBhd2F5Lg0KDQpPSywgd2UnbGwgdHJ5IHRv
IGNvbnRhY3QgQW5nZWxvIGZyb20gb3RoZXIgcGxhY2VzLg0KVGhhbmtzIGZvciB5b3VyIGNvbmZp
cm1hdGlvbiENCg0KUmVnYXJkcywNCkphc29uLUpILkxpbg0KDQo+IA0KPiBCZXN0LA0KPiANCj4g
TGF1cmENCj4gDQo=

