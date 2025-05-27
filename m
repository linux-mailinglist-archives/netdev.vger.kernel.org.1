Return-Path: <netdev+bounces-193550-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 142CCAC46A0
	for <lists+netdev@lfdr.de>; Tue, 27 May 2025 04:53:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 97CBE188CBCA
	for <lists+netdev@lfdr.de>; Tue, 27 May 2025 02:53:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D65B81991B6;
	Tue, 27 May 2025 02:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="CIYMBCa7";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="pMW++3KL"
X-Original-To: netdev@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06BAEBA2E;
	Tue, 27 May 2025 02:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748314413; cv=fail; b=CmLVlgW7uJnchIiqTfQTbPl20gcBdFAMtKqD2/bzbBGp9QLlKYztwCfR8KTBLGAOTiKbYpi9yV4T0g3L9A85tT28o8P6RIkZRD2e2YZUjQuMapVBihIAN7lR4HpcufbY0w8MNsdPRIsKIkbY9KedVpDVnSc49CiNvILoZ21LjSE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748314413; c=relaxed/simple;
	bh=lP20UFyH/PDLWmypxEKshZ0iwG18GjTl0enY5SSosAs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=U2sZDmfUmtAxLQaJMc5Wr5VBgJcq53X41Tfrl8WgPevmxJ2i7D7NOiTlq0QuWW8QaeXVjEpmqDc57Md7g2ludUFxgn0wLQmyGeGNS5Dj6tuM9mybVyv+AZG3LV8hUmS3jnksMl9xkR6riYzqs1fzXwoCdqLzGFe5nR/5QXbtJdo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=CIYMBCa7; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=pMW++3KL; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: c2eeb6663aa511f082f7f7ac98dee637-20250527
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=lP20UFyH/PDLWmypxEKshZ0iwG18GjTl0enY5SSosAs=;
	b=CIYMBCa7lSv1lBCKMnq/qStZB05vHhOo0BDEiA/2hAhm7c5Ynd03vg4dw2YEYmCVkoSp3FK3fIWktQUjD2bStPl4wjhl2PdOFou9j6QcBtwuQ2bB3vZ4zVr7b+nTCSx1giah5unP3z3gm0cwJK+1n9fSaOVrwjRX2XORYS4CmeI=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.2.1,REQID:f71cb871-bf35-43ab-89ad-1875d5d7eaee,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:0ef645f,CLOUDID:4c082559-eac4-4b21-88a4-d582445d304a,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|110|111,TC:nil,Conte
	nt:0|50,EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,
	OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: c2eeb6663aa511f082f7f7ac98dee637-20250527
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
	(envelope-from <shiming.cheng@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 305464920; Tue, 27 May 2025 10:53:26 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.39; Tue, 27 May 2025 10:53:23 +0800
Received: from HK3PR03CU002.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1258.39 via Frontend Transport; Tue, 27 May 2025 10:53:11 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=huw/UbDRN3gfIexGorvaeRvT0jMUvLqpNQ9DizwnrOG5/q+AIdo7CRJZAEF4xLTLGv+p00aD+cpAMgBjU6hbeEP8btv8LZU1FX02FNeSOC+9bSh6Mzs0IKgzmvaqE4/LSnjO1S2H8N6npceNNEmfwfA2bLZmSZY12bYsIchl87DH+7nSnBUOaCGBqqtBn5cJfwvjklBkmmoOCOAG/Kmvn8DgQSQNTh+bJBpZYPvC7bIeBxn255g5bBoIYnQlXxBQgH57lpeYQ6V5yOmx8JYBubYtTY+aRlUwmePGYlwxVgTqiftFL+2AnsLzjPHnm82HY4gJwExmIp2l8QLVHG6w4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lP20UFyH/PDLWmypxEKshZ0iwG18GjTl0enY5SSosAs=;
 b=o1t3g+iKLTbemCtFr7c9a/zqo6dDecCpsqwe0iu9rN5iuSADdiaWuPNqjl0lVkJeHukwCYhrxW9D94my1p4I2Uq6I+FdPswGCtK6GSxzhJrMD8hdNOEIvf0tepjfr88fnExWnSyUBlZ+0h+65DKFquBglZpu2H8JU4U3fPSVd2snEXKF8lcSjzQOusdZTYigPtdLyt/OtvulyfS5thZTHm8BSI0So84gvNuyR6gcaWpQuo1oJ3u5nbMTsxWgas49MVU2YRLrlNe1uyablrdI+DeTmAGbjYg1jqRUknZl4bzKTiU8XeHdLdMSkOzR7OhGPtiL7+VUHH+iHUo3W87pJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lP20UFyH/PDLWmypxEKshZ0iwG18GjTl0enY5SSosAs=;
 b=pMW++3KLiyg2z116MSBsIZmKn3LJztB1fj+rVIrTi9x4aL/ozZWsEq/PEJ5MrgymgQxUQ7hUidVUkd7G/jAruoq7NsJP0V32RAMrKEgsOQ1vmQyAI4Ki+FqSi37+Tr9v79PjAScxj/nXn+UP6+br9YNvwbYKZBBZH7Wo0b/J0mg=
Received: from TYZPR03MB7963.apcprd03.prod.outlook.com (2603:1096:400:451::12)
 by KL1PR03MB8496.apcprd03.prod.outlook.com (2603:1096:820:137::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.24; Tue, 27 May
 2025 02:53:22 +0000
Received: from TYZPR03MB7963.apcprd03.prod.outlook.com
 ([fe80::74b:1a26:a3e0:7d51]) by TYZPR03MB7963.apcprd03.prod.outlook.com
 ([fe80::74b:1a26:a3e0:7d51%7]) with mapi id 15.20.8769.022; Tue, 27 May 2025
 02:53:21 +0000
From: =?utf-8?B?U2hpbWluZyBDaGVuZyAo5oiQ6K+X5piOKQ==?=
	<Shiming.Cheng@mediatek.com>
To: "davem@davemloft.net" <davem@davemloft.net>, "kuba@kernel.org"
	<kuba@kernel.org>, "willemb@google.com" <willemb@google.com>,
	"matthias.bgg@gmail.com" <matthias.bgg@gmail.com>, "pabeni@redhat.com"
	<pabeni@redhat.com>, "willemdebruijn.kernel@gmail.com"
	<willemdebruijn.kernel@gmail.com>, "edumazet@google.com"
	<edumazet@google.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	=?utf-8?B?TGVuYSBXYW5nICjnjovlqJwp?= <Lena.Wang@mediatek.com>
Subject: Re: [PATCH v2] t: fix udp gso skb_segment after pull from frag_list
Thread-Topic: [PATCH v2] t: fix udp gso skb_segment after pull from frag_list
Thread-Index: AQHbzgawz4fFnfYFRkaD6azHevSjTLPk/JmAgADNTYA=
Date: Tue, 27 May 2025 02:53:21 +0000
Message-ID: <1fa8a9fd42a1835b6644bbb8e2b966b57167e698.camel@mediatek.com>
References: <20250526062638.20539-1-shiming.cheng@mediatek.com>
	 <68347db362e10_28cacc29479@willemb.c.googlers.com.notmuch>
In-Reply-To: <68347db362e10_28cacc29479@willemb.c.googlers.com.notmuch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB7963:EE_|KL1PR03MB8496:EE_
x-ms-office365-filtering-correlation-id: 50fcb59b-3782-4d4c-52f4-08dd9cc9a476
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?dnYvOWswOXhvYlVpNWtKZ041a2hqRDlZb0ttOUFscks2Y2F1MmZieHdxMnQr?=
 =?utf-8?B?c2VsaHNOeW54b3RlamJZbm9aN0dXMXhnQ3VqbVN3QnFLaWZ6cW1nN1I5WG5G?=
 =?utf-8?B?aGcxc1RjRVRaa256RDZyaHdKVnVDQjIyblIrUHNiK1owa0ZLYnNPMTU1SzdV?=
 =?utf-8?B?WTRDZXZIazQvL3pObVFacm4zY0Q2REhPNnp3UG5Ca29TVXNhTlpFZXI0Y08w?=
 =?utf-8?B?MGE1RnZWcE9LUy9SOGp1eDBBWXRXZ3RxOVJiU0xSQndtWVFISDFsTi91d3FS?=
 =?utf-8?B?aVB6YXpnL0l5RDBYOVpDZGdreER2SmtUQ0U3bElqbm9oMTVWb3Yvb3I1a0VH?=
 =?utf-8?B?MUNyVFlQYktkRWt0MlplNFltUjRKeWRIeit3RWVSUFh0WlVNaWRMWldERGJN?=
 =?utf-8?B?NDFKRnZxR3RiTXlQSXorUVZ4UU9BL2RlVVdWYlB4V1ZkeVA3TksrQkNuc0F4?=
 =?utf-8?B?dXVjZmMyOXVHK1J4NjA2eGNmSlZobnFaZm4ySnNSWDJsUlJ1azdKQjEwTzY4?=
 =?utf-8?B?YTZIeHA3SG45R1pVa1llaXpnVVNmS0tyWlBYQ0poMC9NVVZ5NXM3aEpVQ0d0?=
 =?utf-8?B?MUR4OCthYzZGUWVrOTRrMjUrN1ZzalRlZ2N4bHlMTXI1a09qdXA3LzBPWVVZ?=
 =?utf-8?B?cTFuTG1nNXZjNWgwQVgvaXBpUDkxdkI5Nis1eStpR2NRcjNaK2piS0dCN3VU?=
 =?utf-8?B?Z2cxU2h2R3dOWnlEclhxNWVUZEI1bEh6Z3hhRzBzSzVEaVZOUDQ5d1ZQcnJy?=
 =?utf-8?B?M3NxZmJpdDZ5Qnl1QUVKbnZiSkU4bUNKdTZtUktBMlE1cytGRlZlSEFuS21S?=
 =?utf-8?B?ZWUycXZCa0tWU3N6dStWUTBvQmNRbTJvaWxWalNzOGc1YXNBZzRyS2hQL1VG?=
 =?utf-8?B?WmNlU1daNTZXRHowTUZKL1Mwc0syekVubitBczhGOUltRkdJRjR4dUxBWkJI?=
 =?utf-8?B?ZjBOMkFZQUNuRm10TUZKN3d3Q1FpdVdJKzl6anNLaERPZjRVNmxMYkxxVG15?=
 =?utf-8?B?WXlHaE56VmNveVVlaXJlckNyQTg2MGRjUXduU1RaNWV1dVBLZEtKRmY0NnIz?=
 =?utf-8?B?SXpqTEV3YXJQbGJpL1ZiVyt4ellHd3k1Z1FQNXp6T0V4UXA2Sk9yOFk2cjR2?=
 =?utf-8?B?Y2tUY3RNWVVucnY0K3AxV1VsekJnS3NydGVpbHZqZktBclhkK252SVRCVDZH?=
 =?utf-8?B?anBYcXJPTVBTVC9uNy9xRlZTbXdwUm52VndSRklqNUxqTnYwM20wY3RqcGRU?=
 =?utf-8?B?NVd3UnpkUFZrM2JuM09JWVluM1p5dDRiS0h0WmUzMGdDdFhYb1BNUFdmWmU5?=
 =?utf-8?B?bmd0MjNPSkdrMkNoYUpnM2xKeGdBMmNYaDF5TlRmcUx5NDNsaEhoS0M3VGZR?=
 =?utf-8?B?QWhWalF2T2J6QldaMXoveVphMFhRamFIamdYbkswOUNVdTNEZ2tmeFlVNXdD?=
 =?utf-8?B?bmlLSUdsS2haT1RWK01Bd29PYXNiOTMwOGRWR0t5d1NwVzN1MXBFR1U3RWtl?=
 =?utf-8?B?THBiTEhDOGp2U2V0TDV3QTNOWFI5OC84Z2d3bnlVcEpKQUxaYUFEbUp0ejJG?=
 =?utf-8?B?ZFRoUHhhRDlhekp6ekdOMDQybWV5MTB3QnJSL2Erajl6VzMxOVU1cE43S3pO?=
 =?utf-8?B?VCtDNzNGaHhNLzdsdU9UYXJVNGlvSnBKZWIzak9lT3QydjVsKzRKQ3VUUVQw?=
 =?utf-8?B?SlJKVFhrZmFCYlR6NlNBLzdQdVVFYnZ2YTQrckZjWWVNeXFoc1NaUmEvM2ts?=
 =?utf-8?B?bTNyUHFHWTdyYlNRTmcvVkwweDlxdFR5d0piN2tldEJCbjd0SVNVenN3NWpD?=
 =?utf-8?B?MjB5TWpkaXptc21SYXFSbFAzeElrNC9VZWkxdUtMSjlmV3Y5eEV1aWxNRkFW?=
 =?utf-8?B?c2pYQjA0b1grVnlQRmlvTTN0WDVtSmZGMUVwV3VKdmkvd0NoMWlxcEpSMFlw?=
 =?utf-8?B?MVgzYzVGTzBRZzJ1TEdDRUQ4M2xWZk1QWDNPWEFHdjNaZ0FMdXdjYkY3cWUr?=
 =?utf-8?Q?v/Z1XZ7XkfW7V2I60dKuWkAwGVK2+8=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB7963.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZGFwUjZ2ZEdMNUxPNFAwYUVqcmtidlJDajg1c1ZHa1dQTGY0WE5GcGtVWXRL?=
 =?utf-8?B?UzdnOXhUN3d5emhISXdQZVllb0txaXNlRUVCa0xWVFVUaGhEMHVwQm5vNEtO?=
 =?utf-8?B?Sm1iY0tGU2p1ajErNzlIbE1wM0JsZWdZUXZma3Y3VUNoSEJFZlJtNmNIc09j?=
 =?utf-8?B?eGdkb0l3d1VHL0Z5a0xyUDBtWXRWSzJTUEg3dFpocXk4QXF5Tm55RjY4djcr?=
 =?utf-8?B?R0VjTHdVbGVMUkxNWDQyWEFLejkrNzBUWmkyeVloUVBPS3MxaWRxVGxxck5E?=
 =?utf-8?B?RmJweWdmcG5jbDZ1SmdYOXQxb09CL0pUWHlocFQ3YzdoSkcwWUxWNkNtM2hT?=
 =?utf-8?B?VXhRWHgxSVE5d0o1OE9PYzVuQ01wQ2ZJYWRQclVJUVlKei9kVW5qZ3dPRGNt?=
 =?utf-8?B?eW1BWVA2cUkrWGpIN1lUQkwxV2lSRi9EMThFRUlKdVlpZnhsSURaODl3ZW43?=
 =?utf-8?B?ZWdRK3NTSEZhWmQ3dkFpdm9kSE9ad0JGZVBNby85VjQ0bTFXRzYzTTJ3cG9Q?=
 =?utf-8?B?b3JpOHFnTkZZN1ZyMm1hdWRGY0dOY2NNdWJuRHBWZUw0NW9IWHlPNTBINWlL?=
 =?utf-8?B?WFZoemFETEpacGhPbUx4T2pKeU5rV2VMSWRMNTF6T0VRL09taS9OY1lLSXFY?=
 =?utf-8?B?MGt1dG96eFhJTGozejFEa3M3c3Y5MkQ5UC9mcnFkcnkzQXZQSnBiZXEyK1Jl?=
 =?utf-8?B?WmhyZEFYd0JqbUxpWlg4U01QTU11YVh5WjZwN0twZFJvV0E3TTVXTlpEcS9T?=
 =?utf-8?B?TjNwaytuUGxzNnNhc3RSSXpicWhDcnVOZWlSVEc1QldBS1NnbGtvcHAraXRP?=
 =?utf-8?B?eVduejBZTDZIRkg2alJuc0svVUFwSVJQazA3QitBdzhaV1V6RGhHSmlDS0Rt?=
 =?utf-8?B?Z1FjTkZJdVZzU0s5VEtwWjNPbG5VZ1NDcDRkVERselJTUmxWOGxESkNSdzhk?=
 =?utf-8?B?c20xTkhDNkxDWURlemVKMElZRUZpZE8zNWt2MXYrRDRUc3BsNi9jNUVFRE03?=
 =?utf-8?B?N25CUDBXTElqTmU5eTNGYnNpTUtTNTNhc2h1RnZjSWU3elRoU1hXTkczdCtj?=
 =?utf-8?B?OTBzVlBpNDJCaHAwME1qeG40VnlWL0JhRE1XVUQ0VmZJWDdmTUcvS21HMkdX?=
 =?utf-8?B?UnE3SUdSUmcrbnJkdS9aRkRnTFl1aVZJS3lwdGNnb1hKSjJ4M2I2VzVVbEl5?=
 =?utf-8?B?U1NkYTZNVE1lYW12MzdtaVY3R3NyQXhmSVFXRGx0aXJKUnlLNEkyNW1Dai9I?=
 =?utf-8?B?Tkd4c0N4MUQvakFLSlhiOHAwbVZCckQyOEozTDVsVE9zMlNSd2lXVEsrc1Za?=
 =?utf-8?B?bVRRVnVjMUIrdCsva3VNYkZWWitsRTRMLzQ2SVJuS3RhZlpnZzZhU1I3Q3Vx?=
 =?utf-8?B?NFdkbGd6TXM4YXZBVlNMZTZ5cnR2bWp1R1E2WEFpY3B0QzJ5NVV0NjNzZS80?=
 =?utf-8?B?OFAvS0NabmFmZHZJMHVwNmRsK2E2cStTVEhDd1FrZzc3Uy94b1NFTWR4ZTZk?=
 =?utf-8?B?K0Z4V1EySG9LVjFscTRGUWtOT3gvOWZOM0FVZnd2eGExaEhUOXNwTU1ROHY4?=
 =?utf-8?B?WElObWtlOTE1Q0w5NG1XeXhJTzJSR0sxb0tBT09UMmQrOXc5bUh5VVFhOTY2?=
 =?utf-8?B?eUtWWmE1MzZSL2pvaWZTakhxWUFkQkZZcVB5Yng2bytoVkpySGVOaG9yTG1L?=
 =?utf-8?B?YWpOdTR1U095TnJLb3V4OE5VVmJSaFMrV2VwcGVCRnI4bkRPdFV3R2MyMWFw?=
 =?utf-8?B?MXZ1b3dQRTkvWkFtc08wMDJ0L3dMMnQ0SWdrVGNGcjJzS3JBelhXdzNHMHBu?=
 =?utf-8?B?WEt3QzBDd2cwM0lndXhERHhmM2FhazBkdTlWNHlTTHNSd2wxdHJSK3NQbUhi?=
 =?utf-8?B?RW9QWFEwYmJ2QnZJZFZZVk5tQTIxU3M3b0Q5NjJXbWtUdWFmY3JwSEhxY1ZL?=
 =?utf-8?B?ekFlMStOK295N3NwZGhYdTdITnZNSUlDck9Fb3hnZWs1Sm92NjlhSCtMVGw3?=
 =?utf-8?B?Uk5IQVkzcU5lRmY0YXRmU3czbFlMZzZZVWNON1c4Ykx4T09jb2JPSGJ3ZThK?=
 =?utf-8?B?Um9sa0RzK1JvKzVNbzczeGVPSThxVEZOL0QvWGdHakR3bmtZMC9OSUVyK25v?=
 =?utf-8?B?MTh6TTlrMXdVN2NvemVEZWErVkE2ME5oK3B6S0g4ZFlHT0w5MmtUSGtMYStC?=
 =?utf-8?B?b1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <48DF2968DB8A834DA4E868BBB1EEC5F3@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB7963.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50fcb59b-3782-4d4c-52f4-08dd9cc9a476
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 May 2025 02:53:21.7687
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ALSWW4AdqbS1eI9NccBJJcNgTZRqSRf8q2Wk5iY6odtCRyD4O3QWKJrmgbByaCrhtOTsa8rnplX6fVYmPzfk7q3eqfB+cFpEDFnRdMA7AG0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB8496

T24gTW9uLCAyMDI1LTA1LTI2IGF0IDEwOjQxIC0wNDAwLCBXaWxsZW0gZGUgQnJ1aWpuIHdyb3Rl
Og0KPiBFeHRlcm5hbCBlbWFpbCA6IFBsZWFzZSBkbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBh
dHRhY2htZW50cyB1bnRpbA0KPiB5b3UgaGF2ZSB2ZXJpZmllZCB0aGUgc2VuZGVyIG9yIHRoZSBj
b250ZW50Lg0KPiANCj4gDQo+IHMvdC9uZXQNCj4gDQo+IHMvW1BBVENIIHZYXS9bUEFUQ0ggbmV0
IHZYXQ0KDQpJdCBoYXMgYWxyZWFkeSBiZWVuIHVwZGF0ZWQgaW4gdjMuDQoNCj4gDQo+IFNoaW1p
bmcgQ2hlbmcgd3JvdGU6DQo+ID4gRGV0ZWN0IGludmFsaWQgZ2VvbWV0cnkgZHVlIHRvIHB1bGwg
ZnJvbSBmcmFnX2xpc3QsIGFuZCBwYXNzIHRvDQo+ID4gcmVndWxhciBza2Jfc2VnbWVudC4gaWYg
b25seSBwYXJ0IG9mIHRoZSBmcmFnbGlzdCBwYXlsb2FkIGlzIHB1bGxlZA0KPiA+IGludG8gaGVh
ZF9za2IsIFdoZW4gc3BsaXR0aW5nIHBhY2tldHMgaW4gdGhlIHNrYl9zZWdtZW50IGZ1bmN0aW9u
LA0KPiANCj4gUHVuY3R1YXRpb24gaXMgb2ZmDQoNCkl0IGhhcyBhbHJlYWR5IGJlZW4gdXBkYXRl
ZCBpbiB2My4NCg0KPiANCj4gPiBpdCB3aWxsIGFsd2F5cyBjYXVzZSBleGNlcHRpb24gYXMgYmVs
b3cuDQo+ID4gDQo+ID4gVmFsaWQgU0tCX0dTT19GUkFHTElTVCBza2JzDQo+ID4gLSBjb25zaXN0
IG9mIHR3byBvciBtb3JlIHNlZ21lbnRzDQo+ID4gLSB0aGUgaGVhZF9za2IgaG9sZHMgdGhlIHBy
b3RvY29sIGhlYWRlcnMgcGx1cyBmaXJzdCBnc29fc2l6ZQ0KPiA+IC0gb25lIG9yIG1vcmUgZnJh
Z19saXN0IHNrYnMgaG9sZCBleGFjdGx5IG9uZSBzZWdtZW50DQo+ID4gLSBhbGwgYnV0IHRoZSBs
YXN0IG11c3QgYmUgZ3NvX3NpemUNCj4gPiANCj4gPiBPcHRpb25hbCBkYXRhcGF0aCBob29rcyBz
dWNoIGFzIE5BVCBhbmQgQlBGIChicGZfc2tiX3B1bGxfZGF0YSkgY2FuDQo+ID4gbW9kaWZ5IGZy
YWdsaXN0IHNrYnMsIGJyZWFraW5nIHRoZXNlIGludmFyaWFudHMuDQo+ID4gDQo+ID4gSW4gZXh0
cmVtZSBjYXNlcyB0aGV5IHB1bGwgb25lIHBhcnQgb2YgZGF0YSBpbnRvIHNrYiBsaW5lYXIuIEZv
cg0KPiA+IFVEUCwNCj4gPiB0aGlzICBjYXVzZXMgdGhyZWUgcGF5bG9hZHMgd2l0aCBsZW5ndGhz
IG9mICgxMSwxMSwxMCkgYnl0ZXMgd2VyZQ0KPiA+IHB1bGxlZCB0YWlsIHRvIGJlY29tZSAoMTIs
MTAsMTApIGJ5dGVzLg0KPiA+IA0KPiA+IFdoZW4gc3BsaXR0aW5nIHBhY2tldHMgaW4gdGhlIHNr
Yl9zZWdtZW50IGZ1bmN0aW9uLCB0aGUgZmlyc3QgdHdvDQo+ID4gcGFja2V0cyBvZiAoMTEsMTEp
IGJ5dGVzIGFyZSBzcGxpdCB1c2luZyBza2JfY29weV9iaXRzLiBCdXQgd2hlbg0KPiA+IHRoZSBs
YXN0IHBhY2tldCBvZiAxMCBieXRlcyBpcyBzcGxpdCwgYmVjYXVzZSBoc2l6ZSBiZWNvbWVzDQo+
ID4gbmFnYXRpdmUsDQo+ID4gaXQgZW50ZXJzIHRoZSBza2JfY2xvbmUgcHJvY2VzcyBpbnN0ZWFk
IG9mIGNvbnRpbnVpbmcgdG8gdXNlDQo+ID4gc2tiX2NvcHlfYml0cy4gSW4gZmFjdCwgdGhlIGRh
dGEgZm9yIHNrYl9jbG9uZSBoYXMgYWxyZWFkeSBiZWVuDQo+ID4gY29waWVkIGludG8gdGhlIHNl
Y29uZCBwYWNrZXQuDQo+ID4gDQo+ID4gd2hlbiBoc2l6ZSA8IDAsICB0aGUgcGF5bG9hZCBvZiB0
aGUgZnJhZ2xpc3QgaGFzIGFscmVhZHkgYmVlbg0KPiA+IGNvcGllZA0KPiA+ICh3aXRoIHNrYl9j
b3B5X2JpdHMpLCBzbyB0aGVyZSBpcyBubyBuZWVkIHRvIGVudGVyIHNrYl9jbG9uZSB0bw0KPiA+
IHByb2Nlc3MgdGhpcyBwYWNrZXQuIEluc3RlYWQsIGNvbnRpbnVlIHVzaW5nIHNrYl9jb3B5X2Jp
dHMgdG8NCj4gPiBwcm9jZXNzDQo+ID4gdGhlIG5leHQgcGFja2V0Lg0KPiANCj4gTm8gbG9uZ2Vy
IG1hdGNoZXMgdGhlIGN1cnJlbnQgcGF0Y2gNCg0KSXQgaGFzIGFscmVhZHkgYmVlbiB1cGRhdGVk
IGluIHYzLg0KDQo+IA0KPiA+IEJVR19PTiBoZXJl77yaDQo+ID4gcG9zICs9IHNrYl9oZWFkbGVu
KGxpc3Rfc2tiKTsNCj4gPiB3aGlsZSAocG9zIDwgb2Zmc2V0ICsgbGVuKSB7DQo+ID4gICAgIEJV
R19PTihpID49IG5mcmFncyk7DQo+ID4gICAgIHNpemUgPSBza2JfZnJhZ19zaXplKGZyYWcpOw0K
PiA+IA0KPiA+ICAgICBlbDFoXzY0X3N5bmNfaGFuZGxlcisweDNjLzB4OTANCj4gPiAgICAgZWwx
aF82NF9zeW5jKzB4NjgvMHg2Yw0KPiA+ICAgICBza2Jfc2VnbWVudCsweGNkMC8weGQxNA0KPiA+
ICAgICBfX3VkcF9nc29fc2VnbWVudCsweDMzNC8weDVmNA0KPiA+ICAgICB1ZHA0X3Vmb19mcmFn
bWVudCsweDExOC8weDE1Yw0KPiA+ICAgICBpbmV0X2dzb19zZWdtZW50KzB4MTY0LzB4MzM4DQo+
ID4gICAgIHNrYl9tYWNfZ3NvX3NlZ21lbnQrMHhjNC8weDEzYw0KPiA+ICAgICBfX3NrYl9nc29f
c2VnbWVudCsweGM0LzB4MTI0DQo+ID4gICAgIHZhbGlkYXRlX3htaXRfc2tiKzB4OWMvMHgyYzAN
Cj4gPiAgICAgdmFsaWRhdGVfeG1pdF9za2JfbGlzdCsweDRjLzB4ODANCj4gPiAgICAgc2NoX2Rp
cmVjdF94bWl0KzB4NzAvMHg0MDQNCj4gPiAgICAgX19kZXZfcXVldWVfeG1pdCsweDY0Yy8weGU1
Yw0KPiA+ICAgICBuZWlnaF9yZXNvbHZlX291dHB1dCsweDE3OC8weDFjNA0KPiA+ICAgICBpcF9m
aW5pc2hfb3V0cHV0MisweDM3Yy8weDQ3Yw0KPiA+ICAgICBfX2lwX2ZpbmlzaF9vdXRwdXQrMHgx
OTQvMHgyNDANCj4gPiAgICAgaXBfZmluaXNoX291dHB1dCsweDIwLzB4ZjQNCj4gPiAgICAgaXBf
b3V0cHV0KzB4MTAwLzB4MWEwDQo+ID4gICAgIE5GX0hPT0srMHhjNC8weDE2Yw0KPiA+ICAgICBp
cF9mb3J3YXJkKzB4MzE0LzB4MzJjDQo+ID4gICAgIGlwX3JjdisweDkwLzB4MTE4DQo+ID4gICAg
IF9fbmV0aWZfcmVjZWl2ZV9za2IrMHg3NC8weDEyNA0KPiA+ICAgICBwcm9jZXNzX2JhY2tsb2cr
MHhlOC8weDFhNA0KPiA+ICAgICBfX25hcGlfcG9sbCsweDVjLzB4MWY4DQo+ID4gICAgIG5ldF9y
eF9hY3Rpb24rMHgxNTQvMHgzMTQNCj4gPiAgICAgaGFuZGxlX3NvZnRpcnFzKzB4MTU0LzB4NGI4
DQo+ID4gICAgIF9fZG9fc29mdGlycSsweDE0LzB4MjANCj4gPiANCj4gPiAgICAgWyAgMTE4LjM3
NjgxMV0gW0MyMDExMzRdIGRwbWFpZl9yeHEwX3B1czogW25hbWU6YnVnJl1rZXJuZWwgQlVHDQo+
ID4gYXQgbmV0L2NvcmUvc2tidWZmLmM6NDI3OCENCj4gPiAgICAgWyAgMTE4LjM3NjgyOV0gW0My
MDExMzRdIGRwbWFpZl9yeHEwX3B1czogW25hbWU6dHJhcHMmXUludGVybmFsDQo+ID4gZXJyb3I6
IE9vcHMgLSBCVUc6IDAwMDAwMDAwZjIwMDA4MDAgWyMxXSBQUkVFTVBUIFNNUA0KPiA+ICAgICBb
ICAxMTguMzc2ODU4XSBbQzIwMTEzNF0gZHBtYWlmX3J4cTBfcHVzOg0KPiA+IFtuYW1lOm1lZGlh
dGVrX2NwdWZyZXFfaHcmXWNwdWZyZXEgc3RvcCBEVkZTIGxvZyBkb25lDQo+ID4gICAgIFsgIDEx
OC40NzA3NzRdIFtDMjAxMTM0XSBkcG1haWZfcnhxMF9wdXM6IFtuYW1lOm1yZHVtcCZdS2VybmVs
DQo+ID4gT2Zmc2V0OiAweDE3OGNjMDAwMDAgZnJvbSAweGZmZmZmZmMwMDgwMDAwMDANCj4gPiAg
ICAgWyAgMTE4LjQ3MDgxMF0gW0MyMDExMzRdIGRwbWFpZl9yeHEwX3B1czoNCj4gPiBbbmFtZTpt
cmR1bXAmXVBIWVNfT0ZGU0VUOiAweDQwMDAwMDAwDQo+ID4gICAgIFsgIDExOC40NzA4MjddIFtD
MjAxMTM0XSBkcG1haWZfcnhxMF9wdXM6IFtuYW1lOm1yZHVtcCZdcHN0YXRlOg0KPiA+IDYwNDAw
MDA1IChuWkN2IGRhaWYgK1BBTiAtVUFPKQ0KPiA+ICAgICBbICAxMTguNDcwODQ4XSBbQzIwMTEz
NF0gZHBtYWlmX3J4cTBfcHVzOiBbbmFtZTptcmR1bXAmXXBjIDoNCj4gPiBbMHhmZmZmZmZkNzk1
OThhZWZjXSBza2Jfc2VnbWVudCsweGNkMC8weGQxNA0KPiA+ICAgICBbICAxMTguNDcwOTAwXSBb
QzIwMTEzNF0gZHBtYWlmX3J4cTBfcHVzOiBbbmFtZTptcmR1bXAmXWxyIDoNCj4gPiBbMHhmZmZm
ZmZkNzk1OThhNWU4XSBza2Jfc2VnbWVudCsweDNiYy8weGQxNA0KPiA+ICAgICBbICAxMTguNDcw
OTI4XSBbQzIwMTEzNF0gZHBtYWlmX3J4cTBfcHVzOiBbbmFtZTptcmR1bXAmXXNwIDoNCj4gPiBm
ZmZmZmZjMDA4MDEzNzcwDQo+ID4gICAgIFsgIDExOC40NzA5NDFdIFtDMjAxMTM0XSBkcG1haWZf
cnhxMF9wdXM6IFtuYW1lOm1yZHVtcCZdeDI5Og0KPiA+IGZmZmZmZmMwMDgwMTM4MTAgeDI4OiAw
MDAwMDAwMDAwMDAwMDQwDQo+ID4gICAgIFsgIDExOC40NzA5NjFdIFtDMjAxMTM0XSBkcG1haWZf
cnhxMF9wdXM6IFtuYW1lOm1yZHVtcCZdeDI3Og0KPiA+IDAwMDAwMDAwMDAwMDAwMmEgeDI2OiBm
YWZmZmY4MTMzOGY1NTAwDQo+ID4gICAgIFsgIDExOC40NzA5NzZdIFtDMjAxMTM0XSBkcG1haWZf
cnhxMF9wdXM6IFtuYW1lOm1yZHVtcCZdeDI1Og0KPiA+IGY5ZmZmZjgwMGM4N2UwMDAgeDI0OiAw
MDAwMDAwMDAwMDAwMDAwDQo+ID4gICAgIFsgIDExOC40NzA5OTFdIFtDMjAxMTM0XSBkcG1haWZf
cnhxMF9wdXM6IFtuYW1lOm1yZHVtcCZdeDIzOg0KPiA+IDAwMDAwMDAwMDAwMDAwNGIgeDIyOiBm
NGZmZmY4MTMzOGY0YzAwDQo+ID4gICAgIFsgIDExOC40NzEwMDVdIFtDMjAxMTM0XSBkcG1haWZf
cnhxMF9wdXM6IFtuYW1lOm1yZHVtcCZdeDIxOg0KPiA+IDAwMDAwMDAwMDAwMDAwMGIgeDIwOiAw
MDAwMDAwMDAwMDAwMDAwDQo+ID4gICAgIFsgIDExOC40NzEwMTldIFtDMjAxMTM0XSBkcG1haWZf
cnhxMF9wdXM6IFtuYW1lOm1yZHVtcCZdeDE5Og0KPiA+IGZkZmZmZjgwNzdkYjVkYzggeDE4OiAw
MDAwMDAwMDAwMDAwMDAwDQo+ID4gICAgIFsgIDExOC40NzEwMzNdIFtDMjAxMTM0XSBkcG1haWZf
cnhxMF9wdXM6IFtuYW1lOm1yZHVtcCZdeDE3Og0KPiA+IDAwMDAwMDAwYWQ2YjYzYjYgeDE2OiAw
MDAwMDAwMGFkNmI2M2I2DQo+ID4gICAgIFsgIDExOC40NzEwNDddIFtDMjAxMTM0XSBkcG1haWZf
cnhxMF9wdXM6IFtuYW1lOm1yZHVtcCZdeDE1Og0KPiA+IGZmZmZmZmQ3OTVhYTU5ZDQgeDE0OiBm
ZmZmZmZkNzk1YWE3YmM0DQo+ID4gICAgIFsgIDExOC40NzEwNjFdIFtDMjAxMTM0XSBkcG1haWZf
cnhxMF9wdXM6IFtuYW1lOm1yZHVtcCZdeDEzOg0KPiA+IGY0ZmZmZjgwNmQ0MGJjMDAgeDEyOiAw
MDAwMDAwMTAwMDAwMDAwDQo+ID4gICAgIFsgIDExOC40NzEwNzVdIFtDMjAxMTM0XSBkcG1haWZf
cnhxMF9wdXM6IFtuYW1lOm1yZHVtcCZdeDExOg0KPiA+IDAwNTQwMDA4MDAwMDAwMDAgeDEwOiAw
MDAwMDAwMDAwMDAwMDQwDQo+ID4gICAgIFsgIDExOC40NzEwODldIFtDMjAxMTM0XSBkcG1haWZf
cnhxMF9wdXM6IFtuYW1lOm1yZHVtcCZdeDkgOg0KPiA+IDAwMDAwMDAwMDAwMDAwNDAgeDggOiAw
MDAwMDAwMDAwMDAwMDU1DQo+ID4gICAgIFsgIDExOC40NzExMDRdIFtDMjAxMTM0XSBkcG1haWZf
cnhxMF9wdXM6IFtuYW1lOm1yZHVtcCZdeDcgOg0KPiA+IGZmZmZmZmQ3OTU5YjA4NjggeDYgOiBm
ZmZmZmZkNzk1OWFlZWJjDQo+ID4gICAgIFsgIDExOC40NzExMThdIFtDMjAxMTM0XSBkcG1haWZf
cnhxMF9wdXM6IFtuYW1lOm1yZHVtcCZdeDUgOg0KPiA+IGY4ZmZmZjgxMzJhYzU3MjAgeDQgOiBm
ZmZmZmZjMDA4MDEzNGE4DQo+ID4gICAgIFsgIDExOC40NzExMzFdIFtDMjAxMTM0XSBkcG1haWZf
cnhxMF9wdXM6IFtuYW1lOm1yZHVtcCZdeDMgOg0KPiA+IDAwMDAwMDAwMDAwMDBhMjAgeDIgOiAw
MDAwMDAwMDAwMDAwMDAxDQo+ID4gICAgIFsgIDExOC40NzExNDVdIFtDMjAxMTM0XSBkcG1haWZf
cnhxMF9wdXM6IFtuYW1lOm1yZHVtcCZdeDEgOg0KPiA+IDAwMDAwMDAwMDAwMDAwMGEgeDAgOiBm
YWZmZmY4MTMzOGY1NTAwDQo+IA0KPiBQbGVhc2UgdHJ1bmNhdGUgdG8gdGhlIG1vc3QgcmVsZXZh
bnQgaW5mb3JtYXRpb24uDQoNCkl0IGhhcyBhbHJlYWR5IGJlZW4gdXBkYXRlZCBpbiB2My4NCg0K
PiANCj4gVGhhdCBbbmFtZTouLl0gc3R1ZmYgbG9va3Mgb2RkIHRvbz8gSXMgdGhpcyBub3JtYWwg
ZG1lc2c/IElmIHNvLCB3aGF0DQo+IGlzIHRoZSBwbGF0Zm9ybS4NCg0KVGhlIGRldmljZSB3aGVy
ZSB0aGUgaXNzdWUgb2NjdXJyZWQgaXMgQW5kcm9pZCBNZWRpYXRlayBtb2JpbGUNCnBsYXRmb3Jt
LiBUaHJlYWQgYW5kIG5hbWUgYXJlIHJlbGF0ZWQgdG8gTWVkaWF0ZWsuDQoNCg0KPiANCj4gSW4g
dGhpcyBjYXNlLCB0aGUgKHBvc3NpYmx5IHNvbWV3aGF0IHRydW5jYXRlZCkgc3RhY2sgdHJhY2Ug
YW5kDQo+IGV4cGxpY2l0DQo+IGtlcm5lbCBCVUcgYXQgc3RhdGVtZW50IHByb2JhYmx5IHN1ZmZp
Y2UuDQo+IA0KPiA+IEZpeGVzOiBhMWU0MGFjNWI1ZTkgKCJuZXQ6IGdzbzogZml4IHVkcCBnc28g
ZnJhZ2xpc3Qgc2VnbWVudGF0aW9uDQo+ID4gYWZ0ZXIgcHVsbCBmcm9tIGZyYWdfbGlzdCIpDQo+
ID4gU2lnbmVkLW9mZi1ieTogU2hpbWluZyBDaGVuZyA8c2hpbWluZy5jaGVuZ0BtZWRpYXRlay5j
b20+DQo+ID4gLS0tDQo+ID4gIG5ldC9pcHY0L3VkcF9vZmZsb2FkLmMgfCA0ICsrKysNCj4gPiAg
MSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKQ0KPiA+IA0KPiA+IGRpZmYgLS1naXQgYS9u
ZXQvaXB2NC91ZHBfb2ZmbG9hZC5jIGIvbmV0L2lwdjQvdWRwX29mZmxvYWQuYw0KPiA+IGluZGV4
IGE1YmU2ZTRlZDMyNi4uZWMwNWJiN2QxZTIyIDEwMDY0NA0KPiA+IC0tLSBhL25ldC9pcHY0L3Vk
cF9vZmZsb2FkLmMNCj4gPiArKysgYi9uZXQvaXB2NC91ZHBfb2ZmbG9hZC5jDQo+ID4gQEAgLTI3
Myw2ICsyNzMsNyBAQCBzdHJ1Y3Qgc2tfYnVmZiAqX191ZHBfZ3NvX3NlZ21lbnQoc3RydWN0DQo+
ID4gc2tfYnVmZiAqZ3NvX3NrYiwNCj4gPiAgICAgICBib29sIGNvcHlfZHRvcjsNCj4gPiAgICAg
ICBfX3N1bTE2IGNoZWNrOw0KPiA+ICAgICAgIF9fYmUxNiBuZXdsZW47DQo+ID4gKyAgICAgaW50
IHJldCA9IDA7DQo+ID4gDQo+ID4gICAgICAgbXNzID0gc2tiX3NoaW5mbyhnc29fc2tiKS0+Z3Nv
X3NpemU7DQo+ID4gICAgICAgaWYgKGdzb19za2ItPmxlbiA8PSBzaXplb2YoKnVoKSArIG1zcykN
Cj4gPiBAQCAtMzAxLDYgKzMwMiw5IEBAIHN0cnVjdCBza19idWZmICpfX3VkcF9nc29fc2VnbWVu
dChzdHJ1Y3QNCj4gPiBza19idWZmICpnc29fc2tiLA0KPiA+ICAgICAgICAgICAgICAgaWYgKHNr
Yl9wYWdlbGVuKGdzb19za2IpIC0gc2l6ZW9mKCp1aCkgPT0NCj4gPiBza2Jfc2hpbmZvKGdzb19z
a2IpLT5nc29fc2l6ZSkNCj4gPiAgICAgICAgICAgICAgICAgICAgICAgcmV0dXJuIF9fdWRwX2dz
b19zZWdtZW50X2xpc3QoZ3NvX3NrYiwNCj4gPiBmZWF0dXJlcywgaXNfaXB2Nik7DQo+ID4gDQo+
ID4gKyAgICAgICAgICAgICByZXQgPSBfX3NrYl9saW5lYXJpemUoZ3NvX3NrYik7DQo+ID4gKyAg
ICAgICAgICAgICBpZiAocmV0KQ0KPiA+ICsgICAgICAgICAgICAgICAgICAgICByZXR1cm4gRVJS
X1BUUihyZXQpOw0KPiANCj4gY29kZSBMR1RNLCB0aGFua3MuDQo+IA0KPiA+ICAgICAgICAgICAg
ICAgIC8qIFNldHVwIGNzdW0sIGFzIGZyYWdsaXN0IHNraXBzIHRoaXMgaW4NCj4gPiB1ZHA0X2dy
b19yZWNlaXZlLiAqLw0KPiA+ICAgICAgICAgICAgICAgZ3NvX3NrYi0+Y3N1bV9zdGFydCA9IHNr
Yl90cmFuc3BvcnRfaGVhZGVyKGdzb19za2IpIC0NCj4gPiBnc29fc2tiLT5oZWFkOw0KPiA+ICAg
ICAgICAgICAgICAgZ3NvX3NrYi0+Y3N1bV9vZmZzZXQgPSBvZmZzZXRvZihzdHJ1Y3QgdWRwaGRy
LA0KPiA+IGNoZWNrKTsNCj4gPiAtLQ0KPiA+IDIuNDUuMg0KPiA+IA0KPiANCj4gDQo=

