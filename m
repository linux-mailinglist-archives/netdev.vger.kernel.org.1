Return-Path: <netdev+bounces-293558-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oQt/IiggHWqUVwkAu9opvQ
	(envelope-from <netdev+bounces-293558-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 08:01:12 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 1260A619F08
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 08:01:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 260CC3006904
	for <lists+netdev@lfdr.de>; Mon,  1 Jun 2026 06:01:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD174334374;
	Mon,  1 Jun 2026 06:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="hCZ6GwBy";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="V9cx3tIb"
X-Original-To: netdev@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFD6C273D6D;
	Mon,  1 Jun 2026 06:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780293666; cv=fail; b=pYpFR5So1ge9VeR4zVVr/KbM9OfPYG8pXCcnYugYDONB5yhO6M7xO9q6A4VOW8MIL0ckcJqG/LyCOVdYwod+i+d9gwxx1bg/jQNFY/Tl4ag5Y9BgCrEl3tdsh57oZUtanFETZTjbLFnSz9EW1c4NODSRYnlEeIjQ65i8YC6RYQo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780293666; c=relaxed/simple;
	bh=tVcQAhwTDwgTfZRX3DYtFcOgSI9loIk2hZtG1ZAxL1g=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jHhOZ61a866tn3nGw/UrD9slsWyBlxHMDZk/fjTk9eF4rSGycQKXJihCPav9bxaJOuyCcM0H/BdJ/ztDzfS4CwEGXjaXYiX3rWiOesbtrjIPj5Me7CJkUavXrn7p/u9jZej1q5sRnkUE09/rvXO2dB/TcZL7et5bh3ZEy/Xx6tA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=hCZ6GwBy; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=V9cx3tIb; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 3e9cbcd45d7f11f18dc8c9802ae25ab1-20260601
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=tVcQAhwTDwgTfZRX3DYtFcOgSI9loIk2hZtG1ZAxL1g=;
	b=hCZ6GwByLBl1IVmX/El5WIOzHaRTSBpqX/kV53flZ/xGlN1FTlux2bfAaOVE9jt+rFRstEsuICGzd0ahcPMn2YZP6SQbDABdeekZjMvLnhSCWjsH0Knm6Okh7IAJ9rO8k5zHv3OxWWdysQwfI5o8OUq4KknBW7Rkj0ceEegetqk=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.15,REQID:5fb990a8-26a0-4d0c-943c-388536b4f9c4,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:e276073,CLOUDID:d13ff0da-f671-434b-8e4e-d2570788da16,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|110|111|836|865|888|
	898,TC:-5,Content:0|15|50,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:ni
	l,BEC:-1,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 3e9cbcd45d7f11f18dc8c9802ae25ab1-20260601
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw02.mediatek.com
	(envelope-from <jianyu.li@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 780780364; Mon, 01 Jun 2026 14:00:51 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Mon, 1 Jun 2026 14:00:50 +0800
Received: from SI4PR04CU001.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Mon, 1 Jun 2026 14:00:50 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yi/8pnJ3qjYKGN/lAyJU8RVGNbQc20U6+mzmaUq7BIaqT178I3nC6cITso3w4QHZ5ZKlkRBE2B+HL+b67+AevTKD89WexKSFmqypWP3VCd7ANbCIZjaE/0hfpkiHg+IvH8fCgGja41CvrTVE6SS2G6sTJVsa0Jl1typKsLa+mvUlpe/Q64DclQI0BGPbZQUVniGVGVB9Qzao73BmblUykQoRz0mMXi8fdaUJsl99pOxOk2lr1dzTyY90dben3kK9q5mkjc/iwrXm2SpipLK93TJjePE3lfvEsUw3irKUwASkhhdsn4Gms/IkbzIZmRwx4wVgzY74Rxa2VrFXNS3nNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tVcQAhwTDwgTfZRX3DYtFcOgSI9loIk2hZtG1ZAxL1g=;
 b=TAAyP1dDoBk7rjCbe4006Sr+kkDNbDFTZDhSzR0kCVkq8zAidR33lLTE58DYaH05OGpLc1Whpw3TdnUDyTMCrifu/0GifXBeAXqEr1gNm1TxKdyB/pGrzeUGxk/X4nEUVJSAZbc0D4J4FhAF6JvaAiUmrJh9WZhqfe8gsA1JOg07KNXNY4rfXnEHgod6AdZsuVRS+BN4NXnTSJNXH3+Nd3GKJLkhWZ8ZIQSCSp8WsS+sVSdMKqGCddL6/AlGfv1q2lXs2Io3K5Vr8ozq/pqI1cy6XTWU6wVaiK2TKnkdrmPU7kqm+gM/BcPnfcfvaSYY1Kv4Nzshfq0oIN3fjB0bJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tVcQAhwTDwgTfZRX3DYtFcOgSI9loIk2hZtG1ZAxL1g=;
 b=V9cx3tIbRh8N0lVaBrboiUD2VdC2nUNxIfpKQyIMNmKC/6GfV4cYs6TxMPUGHA/iwTMXAp5XUBelAIMtBLdOq0n+C+2J/6ubHHTpOUCpBSUfcwk3HnUxRlqoHj4nZDTGj2mDmH7/m9asse8gBKjSce9te4fWLNQOgtlq+DMEQm4=
Received: from SI2PR03MB6566.apcprd03.prod.outlook.com (2603:1096:4:1e1::11)
 by SI6PR03MB8654.apcprd03.prod.outlook.com (2603:1096:4:24c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.4; Mon, 1 Jun 2026
 06:00:46 +0000
Received: from SI2PR03MB6566.apcprd03.prod.outlook.com
 ([fe80::cab:e6b9:ce78:23ea]) by SI2PR03MB6566.apcprd03.prod.outlook.com
 ([fe80::cab:e6b9:ce78:23ea%5]) with mapi id 15.21.0071.011; Mon, 1 Jun 2026
 06:00:45 +0000
From: =?utf-8?B?Smlhbnl1IExpICjmnY7lgaXnkYAp?= <Jianyu.Li@mediatek.com>
To: "kuniyu@google.com" <kuniyu@google.com>
CC: =?utf-8?B?SXZhbiBUc2VuZyAo5pu+5b+X6LuSKQ==?= <ivan.tseng@mediatek.com>,
	"davem@davemloft.net" <davem@davemloft.net>, "willemb@google.com"
	<willemb@google.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
	=?utf-8?B?QmxhY2stQ0ggQ2hlbiAo6Zmz5bu66I+vKQ==?=
	<black-ch.chen@mediatek.com>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"horms@kernel.org" <horms@kernel.org>, "edumazet@google.com"
	<edumazet@google.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-mediatek@lists.infrade" <linux-mediatek@lists.infrade>,
	"kuba@kernel.org" <kuba@kernel.org>
Subject: Re: [PATCH net v2 2/2] af_unix: Add test for SCM_INQ on partial read
Thread-Topic: [PATCH net v2 2/2] af_unix: Add test for SCM_INQ on partial read
Thread-Index: AQHc7pFGS4UCAsaGCUSTzw1ORyfRirYl+wIAgAM/0gA=
Date: Mon, 1 Jun 2026 06:00:45 +0000
Message-ID: <585d7297afb0dc915b33205d1530d8cde5731c6c.camel@mediatek.com>
References: <20260528110033.3327744-1-jianyu.li@mediatek.com>
	 <20260528110033.3327744-3-jianyu.li@mediatek.com>
	 <CAAVpQUDg-oSRvG4h+YinP8TSPfR+ug=_Fn1ON-TL5WsAvj8Oog@mail.gmail.com>
In-Reply-To: <CAAVpQUDg-oSRvG4h+YinP8TSPfR+ug=_Fn1ON-TL5WsAvj8Oog@mail.gmail.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR03MB6566:EE_|SI6PR03MB8654:EE_
x-ms-office365-filtering-correlation-id: d4951787-91ae-4d3c-d3fc-08debfa31f4a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016|38070700021|22082099003|18002099003|6133799003|11063799006|56012099006|4143699003;
x-microsoft-antispam-message-info: szjtNV6KCQMAtMm/N/HBALfCnKR2Em5fkbBESAd8eY57YDmnzh7GR8NJNbYjHRcn9lVC/ABpLiYlqWLTk346Iz76JC8BO5j8/O0gU6ecmXs92OK0BWy+feVsZpB566BFZzvvY0Dv2fm1IprAjgBCIVNSKeSt018JUrxnSwHVV3FUAwYGyR1g4Pg7CMzsTIS4lGzuEXETevLk/y4YGH1OhmYQ8Zyi0jdJ1WxGybvAz4KUo61JEVu3LinX+jl9V06x1JeIK5mHhnhQnQgzYoeZDeeIhEXt6pF2KGvhx6Rtqw2UXRfH/rfeQ4nawu5JgQBug5w+J1nwYUj0GCYRM65knn/nYjqrgAQMPPdLLPsy58HTSnfY1aNDtc3ClWHFaE+StfO7h9CXD66vfiIu5EvRFvx97gxB43qC0DyNLZJTgFk+zQinjmR2sjylmWqgkqstkui3ynEiweO3ZWUVJYzIP+zqQpVT+J/jLRFP/MIr5jrfKNVBgYQRGTrufTWU7djHx3eGUE9aHeplg6uag11wa1KwS2CpXJ2xViVbj5EexDjW1iLVz97Sh3BdqNsIiWCQyE2ii+DbClRCu97T6/wasm0lM8rd5wkWylh9ij5+PGxL7aKiHDlGLTg9QnBb4Cvt28QeOBGVAPTIf64nbqNI0Bjh212vbDJ0xhkkG6UXydC/lRdNVxG76Sl+5X9W/SjlhE8NcoN449obfUPmOKZAONElySJVLfqi4YzBMbpW5wf4WpewuxEKYvvgnKw6/14U
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR03MB6566.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700021)(22082099003)(18002099003)(6133799003)(11063799006)(56012099006)(4143699003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Z1BCdTh6M2VFQXpCM2o2dkVhN3FLRlY5dW12Skw0ZEVqN2RNaUtON1BDenpv?=
 =?utf-8?B?b1YyYlNSRXF3azdTb2ZDcDV3UWNPQ20zcjFIVHRhQk11VHFrRDREWkZXVTJi?=
 =?utf-8?B?QS9QMktYYmdVSUdEbFo4WVAxaEMvaDJDTVJUalhqSG9VMWNjemhPMjZ5R1Nl?=
 =?utf-8?B?cnJkY0ZxRHAwRGxvSTFoYTAvWVNUWFU1dWw5QzdWOVp0QWQ2Sjc0V2VKTmQv?=
 =?utf-8?B?Z0kycXhtRUVoMTA0SzBORzJydVR6RDY5MXR6WnJtZUM2TzhWTDk2bllyVmM3?=
 =?utf-8?B?c3VvT3N2Q3AveHcrTE1YNUNndkFhcGR5MVo1djF2QkhEYWQzZWJqclVuc0ZJ?=
 =?utf-8?B?TGlmT3lFTkVGVnh5K1RsWG0zRXJ2Sm90V0Z4bENQMzdSL3JWamJjZy9GU2Fo?=
 =?utf-8?B?cWUwTVNvem9BM1N5Mlo0T2ExZW84enpMckVXL2tVeGhSR1ZYdzFTSjl1S1pq?=
 =?utf-8?B?WUQyeWVRY0k1aTJSOGw5c2FlSkdOWm11NHVQdGpWWUlDbVppOG9WM01BeWtr?=
 =?utf-8?B?Y2RWVUEzTjI4KzNVckc4NnByS1dVZDFTOFZEb2x3VzZCNncrZnI0dEhNQ3dC?=
 =?utf-8?B?MVY1ZmczK1d3TzhreE5OTzNlVUcraW82ajM0MlVVRmNZZTNOZmU1Vmp1Nmp1?=
 =?utf-8?B?Wk5ZM3dZTG0yYzZCWW1zcGlYWm5oWDBLaUVQSG5yYy9ucGhtV2RhM0ZYd0hX?=
 =?utf-8?B?K0VnajZJeDQvWTZBV293UEF0UEtyQ3d4SFg2aEJjOE42R3RlMzNBaGdSWXNw?=
 =?utf-8?B?aFZVMHd1ekg4TWp2SzhvNXpwa3JXL3VXT1EwVHZ3OStXV0VlTEo3eEd4dFNC?=
 =?utf-8?B?OWQyRnFKM243NHBiM1djbXVjWTJjTHZYaEEvMU1Na3Q0MU9WdzBPWHdSdVpz?=
 =?utf-8?B?SlZxREtJSmg2Z255NEw2SDArV3N6NEZyNlF1Y3VQbkFSUy9IOUhqLy8xcE1k?=
 =?utf-8?B?V1ZzOWNiekFJUEZ3M3dFQy9yYzYrVm5WZElZdXZlU2JOTUZCOTkxZXAxU0Ey?=
 =?utf-8?B?WkZxbzh6Sm94Tm5kVDZSN1lpa0s1ZDZkSG9aZjIxTjFvVEdQNFJpaEpFZllG?=
 =?utf-8?B?UHZGMm5jczVEWnFBcEtQQWNpa0U0ZlMwbktnMExEblA4SzBQc2hKT2VkS0R0?=
 =?utf-8?B?b2tSRktYZnlhUGMvaStOa1JhSHlDL2M4TXhIWGo0Ynl3VWEyUE92KzlLTjIr?=
 =?utf-8?B?S3pzdmRzaXBmTXFZYkkzTGVTektDSkJ2RGtjYWNVNWVFUTg5aG9tbmVIMXN6?=
 =?utf-8?B?Nk9NdzlIUVA5UVlJT1JoVkFRY01BSklqQk55QVRtQVhEVGcxS1cxMGpXMHFK?=
 =?utf-8?B?cnZFK0VzcjRmR3VyWkM5NWprL3g0UHBjODh4ZTdNTFVKd3lUNmpQOXBMeVJT?=
 =?utf-8?B?TXo4U3dLeFVKam1oSURYajlzTitBOVEvZngwcm1lTjVDT3o4RlVXZngwVjRw?=
 =?utf-8?B?L21FK2pEZmZrTmUwWHZ6VVdvWmZzZGJmS1B3RUwrWEEzMnMyZURtWG5vNWdm?=
 =?utf-8?B?ckdZMERqby9kNG9FNkVyL09yVUpNWHRCaDR3ZjBJVWRVWGRESndGRFg5Ry9m?=
 =?utf-8?B?VjY1OFZ0R20ya0l5Yk9HSFpNQnEzaWtObTYxTEg1TUhGVC9uaWFmTWNLL20w?=
 =?utf-8?B?dFVpYkwwcm1ERHVMcHpaTXQ4Y05nVGRFc1h2ZHNudVowdzh6aGtmSlAvT3dh?=
 =?utf-8?B?QlRaYUF5K2hIdWF4bVMrUEpXWm9CZjNiTHVIdVNIbFdNaytlK1MrWDVqU0JE?=
 =?utf-8?B?UCtKR1pRNjgxUmVvR3E0RjJmbGR3Q2p5UEdZY1BXSFVFWGltZFJ6M0F4SDBn?=
 =?utf-8?B?alRYdXpNRnBwNXl4SURRSGtjdDFnRHZ1RmdMeEdJVVhuUGlqYm1wd0s4TnpH?=
 =?utf-8?B?T09WclN0WTFXNkpCL1ZHa2grY2pmZEtreHpnaGRTdmNtL3RxWmdERU02NDdW?=
 =?utf-8?B?TEdsWmlqRTIzRjlZU0VDRzBlajBKWkNrSjVnck1sdncxQUhLaFI5aHpXZHJn?=
 =?utf-8?B?OVZzajZMK2wrd0NuZDg2WmVhUjh3Mks4Q2JFRU00QjliaG5pbEU0MWxrWjRR?=
 =?utf-8?B?OVE3KzNJSjlZYy8wWVV5dXJMbm5PZEZvTFBvbXVJU094Z2FtVVVETVJMYnY4?=
 =?utf-8?B?TnA4dlBNSzJ6aENCVTVsUEVyYVB0RnpFQXRJbm90czloOXVYS1NqME04eUZq?=
 =?utf-8?B?LyszMHN2U3FZbElMNm1zcDM3bmV6TWtQQUx3WTlhYzcwR1FIdDR3b2EyUjRw?=
 =?utf-8?B?WmM3Slh5UVZFOW9uSnVJL3NWZ1VPSVAxWWFnMmIvdEU0MXFGblJ5ZmEvTVVR?=
 =?utf-8?B?ak9halRPVTZzdDdxd2Z0OWYwdE56ZjU3TWR4TUdoTVBPWU52a0FlQT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <91921E544EBDA34D887104C7AC0887F2@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: aWJ187TcQY/7MrPFsdTgltPoSphHGQXgxwQ4uK4xmez9Opxd3FTZF/kv4Xomh+Z7cQW6gp0dxB07x4fyW1H1qpSL4MDHhhInald3Y/MTJuZg7NWNMCxqsGyB+t2MEugyPxI3uq3n8bmJ9Ogx6WbKzagKkDeko6uyT8u7EDdPG9ZzmSDr5ryDw6h7hKd/x1cQRNGLl+WgpeXte4xNSPP8ut/pmq4x2UNCUdMx8AfElsJzjqqKEsa4+TaSAFDXO63qh6YevWQR6IiuUjBWNm4KkfmxObQ8Ou68XwsgrJJsP2OwCH73Uo7uFcspSVgsnokF5+cxLnc3RnpMjlw8MdxsSg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR03MB6566.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4951787-91ae-4d3c-d3fc-08debfa31f4a
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jun 2026 06:00:45.8316
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SV/s+7SzyKDVDlJakgbITGZjmzKbAKew1MofMoU4NuwP5pQyGybB1ia+cAOYXxneOKv0fq406lGEaGW62S5hDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI6PR03MB8654
X-MTK: N
X-Spamd-Result: default: False [-0.06 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[mediatek.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[mediatek.com:s=dk,mediateko365.onmicrosoft.com:s=selector2-mediateko365-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-293558-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	DKIM_TRACE(0.00)[mediatek.com:+,mediateko365.onmicrosoft.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Jianyu.Li@mediatek.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: 1260A619F08
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

T24gRnJpLCAyMDI2LTA1LTI5IGF0IDIxOjIzIC0wNzAwLCBLdW5peXVraSBJd2FzaGltYSB3cm90
ZToNCj4gT24gVGh1LCBNYXkgMjgsIDIwMjYgYXQgNDowMOKAr0FNIDxqaWFueXUubGlAbWVkaWF0
ZWsuY29tPiB3cm90ZToNCj4gPiANCj4gPiBGcm9tOiBKaWFueXUgTGkgPGppYW55dS5saUBtZWRp
YXRlay5jb20+DQo+ID4gDQo+ID4gQWRkIHRlc3QgdG8gdmVyaWZ5IHRoYXQgd2hlbiBhIHNrYiBp
cyBwYXJ0aWFsbHkgY29uc3VtZWQsDQo+ID4gdW5peF9pbnFfbGVuKCkgcmV0dXJuIGNvcnJlY3Qg
cmVtYWluaW5nIGJ5dGUgY291bnQuDQo+ID4gDQo+ID4gQmVmb3JlOg0KPiA+IA0KPiA+IMKgICPC
oCBSVU7CoMKgwqDCoMKgwqDCoMKgwqDCoCBzY21faW5xLnN0cmVhbS5wYXJ0aWFsX3JlYWQgLi4u
DQo+ID4gwqAgIyBzY21faW5xLmM6MTY1OnBhcnRpYWxfcmVhZDpFeHBlY3RlZCByZW1haW4gKDUx
MikgPT0gKihpbnQNCj4gPiAqKUNNU0dfREFUQShjbXNnKSAoNzY4KQ0KPiA+IMKgICMgcGFydGlh
bF9yZWFkOiBUZXN0IHRlcm1pbmF0ZWQgYnkgYXNzZXJ0aW9uDQo+ID4gwqAgI8KgwqDCoMKgwqDC
oMKgwqDCoCBGQUlMwqAgc2NtX2lucS5zdHJlYW0ucGFydGlhbF9yZWFkDQo+ID4gwqAgbm90IG9r
IDIgc2NtX2lucS5zdHJlYW0ucGFydGlhbF9yZWFkDQo+ID4gDQo+ID4gQWZ0ZXI6DQo+ID4gDQo+
ID4gwqAgI8KgIFJVTsKgwqDCoMKgwqDCoMKgwqDCoMKgIHNjbV9pbnEuc3RyZWFtLnBhcnRpYWxf
cmVhZCAuLi4NCj4gPiDCoCAjwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBPS8KgIHNjbV9pbnEuc3Ry
ZWFtLnBhcnRpYWxfcmVhZA0KPiA+IMKgIG9rIDIgc2NtX2lucS5zdHJlYW0ucGFydGlhbF9yZWFk
DQo+ID4gDQo+ID4gU2lnbmVkLW9mZi1ieTogSmlhbnl1IExpIDxqaWFueXUubGlAbWVkaWF0ZWsu
Y29tPg0KPiA+IC0tLQ0KPiA+IHYyOiBGb2xsb3cgcmV2ZXJzZSB4bWFzIHRyZWUgb3JkZXJpbmcg
aW4gcGFydGlhbF9yZWFkIHRlc3QgY2FzZQ0KPiA+IC0tLQ0KPiA+IMKgdG9vbHMvdGVzdGluZy9z
ZWxmdGVzdHMvbmV0L2FmX3VuaXgvc2NtX2lucS5jIHwgNTQNCj4gPiArKysrKysrKysrKysrKysr
KystDQo+ID4gwqAxIGZpbGUgY2hhbmdlZCwgNTIgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMo
LSkNCj4gPiANCj4gPiBkaWZmIC0tZ2l0IGEvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvbmV0L2Fm
X3VuaXgvc2NtX2lucS5jDQo+ID4gYi90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9uZXQvYWZfdW5p
eC9zY21faW5xLmMNCj4gPiBpbmRleCAzYTg2YmU5YmRhLi40OWNmYTZlZjA3IDEwMDY0NA0KPiA+
IC0tLSBhL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL25ldC9hZl91bml4L3NjbV9pbnEuYw0KPiA+
ICsrKyBiL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL25ldC9hZl91bml4L3NjbV9pbnEuYw0KPiA+
IEBAIC04LDggKzgsOSBAQA0KPiA+IA0KPiA+IMKgI2luY2x1ZGUgImtzZWxmdGVzdF9oYXJuZXNz
LmgiDQo+ID4gDQo+ID4gLSNkZWZpbmUgTlJfQ0hVTktTwqDCoMKgwqDCoCAxMDANCj4gPiAtI2Rl
ZmluZSBNU0dfTEVOwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIDI1Ng0KPiA+ICsjZGVm
aW5lIE5SX0NIVU5LU8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAx
MDANCj4gPiArI2RlZmluZSBNU0dfTEVOwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgMjU2DQo+IA0KPiBuaXQ6IHBsZWFzZSBhbGln
biB0aGUgaW5kZW50YXRpb24gb2YgdGhlIGFib3ZlIHR3byBsaW5lcw0KPiB3aXRoIHRoZSBsaW5l
IGJlbG93Lg0KPiANCj4gU29ycnksIEkgc2hvdWxkJ3ZlIGxvb2tlZCBjbG9zZXIuDQo+IA0KPiA+
ICsjZGVmaW5lIE5SX1BBUlRJQUxfUkVBRFPCoMKgwqDCoMKgwqAgMw0KPiANCj4gT3RoZXJ3aXNl
IGxvb2tzIGdvb2QuDQo+IA0KPiBSZXZpZXdlZC1ieTogS3VuaXl1a2kgSXdhc2hpbWEgPGt1bml5
dUBnb29nbGUuY29tPg0KPiANCj4gVGhhbmtzDQoNClRoYW5rcyBLdW5peXVraSwgbXkgaW5kZW50
IHdpZHRoIHNldHRpbmcgd2FzIDQgc28gSSBkaWQgbm90IG5vdGljZSBpdC4NCkkgd2lsbCBmaXgg
aXQgaW4gbmV4dCBwYXRjaC4NCg0KQmVzdCBSZWdhcmRzLA0KSmlhbnl1DQo=

