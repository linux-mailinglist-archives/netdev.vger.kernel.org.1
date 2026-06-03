Return-Path: <netdev+bounces-294673-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id MpoZNorfH2pBrgAAu9opvQ
	(envelope-from <netdev+bounces-294673-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 10:02:18 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F2FC635781
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 10:02:18 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=NXP1.onmicrosoft.com header.s=selector1-NXP1-onmicrosoft-com header.b=OmWkpiJN;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294673-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-294673-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=nxp.com (policy=none);
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8F024306809C
	for <lists+netdev@lfdr.de>; Wed,  3 Jun 2026 08:00:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EF13408022;
	Wed,  3 Jun 2026 08:00:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013017.outbound.protection.outlook.com [52.101.83.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 805C6407CDC
	for <netdev@vger.kernel.org>; Wed,  3 Jun 2026 08:00:40 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780473641; cv=fail; b=a2X1uhP3QHzzu2N3TmETRrPZhs9BAWXdUxj1DEI2sAka8kMVgpRvMm0pu9KWjTobT9uxoD/ky8ppWtHRWl0zmnvnkhpcpMqR1Rs2jiL4D3pQwwyrHmltijX8JGYxeBom15W7xq9K7QZnH9pgRRPNwobJS6nx0dThn/MueGJKkoU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780473641; c=relaxed/simple;
	bh=oE++pFtvJb9c7hi8yLACAP0UpN6crLMdUypecNccybs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ddayf0DM1Tg1qB14n8+yt7X2esDqkGOZDj7BWoy0/uXFSyQr6baJ/TcCzA9PfHxBZfXVL+rQACvEIfcaurR65BOh13P6GL3QSc9l5jbD6VhkWLk+ogmQt6RLajFrr/s/bjPWDKKu+x7ZKnWoj9QjtefyAVln7lQ6PCLMHIVJ3RY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=OmWkpiJN; arc=fail smtp.client-ip=52.101.83.17
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XvHCeUAPX6o/5HOb6rVTorEPWlTpcRLrM4fm2oCrPw2sAH3nPshl76B/jMDcYG1C1eLp5clI4SBuplaoeLavKpVywJe3+zzkSkPAxP8sPG/nKw+KDgc56nB8SpDA7IrVPmX/D6hggSjjeL6lRB9u9/PawBlaYa0t4LiUwq3w9TPVDI1YpmMqGPUQcmjfmcSt5ikJPwYtwI1blK8q9qX/xCLszrlhyfm4cOXnhCokNone+DTF2PvfCWCd53Yjp70JrC/ns9tUx0qzyImD+Xj7EFQrBThRwXPjv33Fvi79/JT2xSBzLMXo4e5pGB+uCcb3runsxpil4zw+w7A2hkN93g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oE++pFtvJb9c7hi8yLACAP0UpN6crLMdUypecNccybs=;
 b=vzSAvxiyQoDM7UJPETKm9BFV9KcyWAerfhKlHa654SJ6ViJn9fmWv9CnEiY7NhRLAjrc/kcSmP3GiUaosCYQ5hb+nQm+B203gkUGy7AqJm4q14B3CoLIrltFXMnjelQmJBg7VXDIDwlAgZv9rPxUdvAx1GWg0M5fgOQLtOy0U17WAvpRcPIA84Imdz/utLnoTRnyHAadhj01QCzhANNBHsHZbWNSbpfT+2yXgsV1st/iGuk0XuwDhJbe+KIyxqIwYGmt4XW3ZkiOP65u9kSlZrUkLcMomGAJa5uQhhVctNFYrqt7xtNKMwWEs/TgHL/RZLlB7yl3d1fj3QA9LQrGqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oE++pFtvJb9c7hi8yLACAP0UpN6crLMdUypecNccybs=;
 b=OmWkpiJNyfHmsWtbKqrVueBtGprJrFqJXiUHD+OCPLBXB7qtrrk/TAhmMpUfcBcaLknEDCFb8FzWwLWyloS9rjF0TpdP2MJ3BqdiW9VW9bF6QtqPFqSxg+kkQJJJKbY4JbzM+m/fJ9E7c7pv1sQ8aklJS0CO+QPTknySXSKRnH8mak02lNlBSsCPoEt93JCZ/r1+9tVox/YnrqRWxlbKNfwsayfAvjhl1sXFeAf0uhMZjOWHcaxmu+s39GBg5pes8YAHveb2R4RZIRCTU/SODTlhRlUmOkloDpwPZwyWFSqdEk+85o5m3L8QAbkPEs+JU7qPtMKkZVvHEv3vHUr9zQ==
Received: from DU2PR04MB8629.eurprd04.prod.outlook.com (2603:10a6:10:2dc::6)
 by GVXPR04MB12015.eurprd04.prod.outlook.com (2603:10a6:150:312::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.15; Wed, 3 Jun 2026
 08:00:36 +0000
Received: from DU2PR04MB8629.eurprd04.prod.outlook.com
 ([fe80::9d04:7526:a901:fe47]) by DU2PR04MB8629.eurprd04.prod.outlook.com
 ([fe80::9d04:7526:a901:fe47%6]) with mapi id 15.21.0092.006; Wed, 3 Jun 2026
 08:00:36 +0000
From: "Wei Fang (OSS)" <wei.fang@oss.nxp.com>
To: "sashiko-reviews@lists.linux.dev" <sashiko-reviews@lists.linux.dev>
CC: "imx@lists.linux.dev" <imx@lists.linux.dev>, "Frank.Li@kernel.org"
	<Frank.Li@kernel.org>, Wei Fang <wei.fang@nxp.com>, Networking
	<netdev@vger.kernel.org>
Subject: RE: [PATCH v2 net-next 8/9] net: dsa: netc: add bridge mode support
Thread-Topic: [PATCH v2 net-next 8/9] net: dsa: netc: add bridge mode support
Thread-Index: AQHc8mBfBio/azfOok6M0vQgF2ylsLYsbnKAgAAK6FA=
Date: Wed, 3 Jun 2026 08:00:35 +0000
Message-ID:
 <DU2PR04MB8629B81101289AC20D7F1D3E88132@DU2PR04MB8629.eurprd04.prod.outlook.com>
References: <20260602072313.3162120-9-wei.fang@oss.nxp.com>
 <20260603072132.53C501F00893@smtp.kernel.org>
In-Reply-To: <20260603072132.53C501F00893@smtp.kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU2PR04MB8629:EE_|GVXPR04MB12015:EE_
x-ms-office365-filtering-correlation-id: 9041e594-b4df-4da9-f0d4-08dec14631cb
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|19092799006|376014|366016|1800799024|38070700021|18002099003|56012099006|22082099003|11063799006|4143699003;
x-microsoft-antispam-message-info:
 4htSSSw1dhlgLIB4zt01NlB/78Cbkpx0ZkUrDv1IBAXuAAeK5vfjS3DdtwStnpAuZBiR1FISYUT9NhDRnR//OdR8nRHkx8Ei9i29lD9KglsInthIxFiS3OYTbVxmH34V41RQ3BxzPRFXToOVFYCCAwmrE6nXv8ewq6WF5Gnjw5YS/phTcyie+MRU5IVKiXGH9TbppgBJzo10lqMfxNWE3ueneSQ0lo4r8LdeBmoV/gkfxWZ9woNT7RutEVZ4VaP4l6wCL3nK4ORJRMvVCQJXbNFTPzUnu6Mp3rZ2/sXymclAsqxTW8sRzEqxzMAOFlvZlyx22vm62BvEqb298AUv9Lwb26aRZP3Zir24/w5aBxXObkDO/Tx6LVr69OIQYM43697MBXPce1c2lXewqhOj3vifkPjzxzPy6JKPK1Hsw/4zfpXRhioACI3nl4B9EQwa0SrAK6WbqAsABI6hBktjl/GrxCOzwhoEG7KD/fL7CBjiQ6rr3+PLd7jAxieGKjFJ2Xn5N2HVG+IX6umj7W4KxJL0NcSiaJKkBOkXz3c8flyrYJ0lIaZwFXoyIJZIyuNUONXwMtpJ2I3pr2/ne2+te7vOu9VUU8TraxNkqmAKy7j33m6MWYRU6vyj+wMZ18j4YeDHFOYhX0XB3gZIpfYLG3pIpfWff3QnkvbrNSD4OtyWkwGa1rLgW/c3S2d0aCSKS4QJAXuLKiaicFiO2/ci7XCkqAdD2t645DfXbnzRRKxOtklXG1Oq3xHuG3/7pAcB
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8629.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(376014)(366016)(1800799024)(38070700021)(18002099003)(56012099006)(22082099003)(11063799006)(4143699003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ek5STjUyTUsxT0NiaFdwb3cwang3ZmlQOEpMZGJ0MmpsNjhRQTVmempIcHgx?=
 =?utf-8?B?MXgvd1VjcHJ4emZWd0QzYndUbzdrVzhzYldTOFd6L1l2OGFHOGtMVXk0ZHRU?=
 =?utf-8?B?aUJ1SENmczl3aForRXVYcHNTand0Y1ZtQWtERXdscmRFcWZUbTJhZ2s4aTE0?=
 =?utf-8?B?NTkxNXNXRUY1bWNrMGVaL0RsNWlSQ25CN0NRUWlJMitLazRVVmJVdGs4Q1Rm?=
 =?utf-8?B?aWVuSWFXMDY4WThqRnVaQy9wZU5nUEM4TERPeTUzYXkzaGJMV29uS0RZY0hH?=
 =?utf-8?B?UFBsUlZmZmtiNW9GTG9KOXZ5eTh5MGtWamZOSTZXMzFDUEpZMnU2UzFLNDVk?=
 =?utf-8?B?TUtjZitHaEFRemNZOHN3ZmtQTEFxOW1FOHpnYTFON3BhWUVYZk1iQzZHOUt2?=
 =?utf-8?B?bU03VHRxd3dBTWd4aGpzS0RGb2hIcW1hN1ZlWURpMnlDZldPTk05Tkl5ZWZt?=
 =?utf-8?B?bTIyeGNndldXRjlCbmMyMzVMK3BTeWgyNnFQTTY2c2NOczVmZzh0VnVGOWpz?=
 =?utf-8?B?K2orVmU0anZJcW5zdzFQOFMycU91RGhRQ0RkVmt1UUl3c2IwNWZNYlcxWWdT?=
 =?utf-8?B?WnVNTCtxTExSdlZVcXZ4M1NJVDU5cGo2MTJLWHEwZTZ4SlZiZVdXN0ZVZWFh?=
 =?utf-8?B?c0p3cmU0ck9mTTB4WWdzaGtKMzFJWUEydVc3d0xBYmo3c29lKzYrSmEyRm85?=
 =?utf-8?B?L3NhWTd2YS9KdGlscVZBNkZQZ0txeEI3YTNpbXZCaWxhZFBKa2hTMTFrUU1Q?=
 =?utf-8?B?eHd2NGVmL1JydWZ1Vk11MEZCcEl5SmJySm5TRXBKRDZYWit6L0hITE5NZ3BU?=
 =?utf-8?B?ZW1pcGFGQXVISEE1WUJMQlVUYlpuYS9jc3FZTmNSak5aQ2lIbHNkdmhzNUw4?=
 =?utf-8?B?cC93TnE2TitmZHFEL3M2Sy9leFVjelNPVm0raUJXV3ZreUpFNmdvNFlIdVho?=
 =?utf-8?B?VTdUQWtVZ0g2QWNQcUZ0S3hrL2YydWxrL0MzSmNWczU5djRjMGxTNFhKYzM2?=
 =?utf-8?B?WEx4VU1wVWE3VDhEU0VuUlh2L3c0NC9uVkY4STRBVW1GN202Q2xXVnFTSWV3?=
 =?utf-8?B?NHp5bHUvSVpoTUlRYUFVbWs1SEl5azkxSVdBUzJqOEgyUFV1U1lTamk5YlNj?=
 =?utf-8?B?RGtQMUEwYTFFc093YmttSHJMQWplSnNYKzV2dWxCSm5UcUpuUEtvSWs5K0FK?=
 =?utf-8?B?TUgwOTVlT2oxQnJSbFZFVkFuWXRtY2hPcmxJb1lLTWpoQzlXWERqM3huajE2?=
 =?utf-8?B?MHpTZTJRbUZCNzBtaWFlVzFMZU1Db3N5a3FpTHg5ZnJ6VUxvMDhIZkQ0MnJz?=
 =?utf-8?B?YXNFVk5hclp6TllvYXo0YlYyaVRnM09XdEdwTVR6VWkxSFRjMEQwWWU4eGlV?=
 =?utf-8?B?dHQ3M1hLSzFHWGFtMU8zUjRTSjdHeFhUcDgzczBQQ24xRVJNMS9xY0t2QTM1?=
 =?utf-8?B?eXFYRU01NjBGVm9RNHNISVJBTHVsa3pGekdVQ09HRFRmRnY3b0g0YW9aV1kz?=
 =?utf-8?B?aHdVU3lEWnpOUzB0ZXlJc0xHeFFhV3hESEtVNHc3QjFoVEhBYUU0NWNGZCt6?=
 =?utf-8?B?cHlJclltOXBKdGlZTktRUENrSk1sdnc1eXJDeVl0VFMraWZHbk1INmpaMnNP?=
 =?utf-8?B?WldLcnJHK3IwMllVeXRYNVFpRFZ4QlZDWjVLOGJPNm1ZSmhIdVhwSmJPTzcv?=
 =?utf-8?B?ZExlWGtDZnR3Q2ZBZ3J6ZS9GVitLeTNBWkV3QzQ4WGpFQWxPTmlBVGZYSjA4?=
 =?utf-8?B?THdCT0dxa0RyeFVtM1RTd2RLS1ZnZEJjZ3dHbjFkMUZqVkYwVmpnSnorNGhD?=
 =?utf-8?B?Qmt2b0x0cXBXbjg2NGtXSUQzSDNibDFkVlJIZ29sMW1SVUQ1UXBvWFpSNmE4?=
 =?utf-8?B?UFRVeHNuVlpPSlpaa0NEZjJZVEJDOVRHU2Znc0VvbUcrbEJwbld5dGlkV0g3?=
 =?utf-8?B?K2ZuY3l4bGtka1BEaXl2MG9wblJGV2I1WWFLU3liU25aQ1RxelRzY01NcWFq?=
 =?utf-8?B?SlFONWFzK3VkemJzK29SaVY2N2U5L1paUU44Ylp6M3BueXd1dkhIcng1UmdJ?=
 =?utf-8?B?SVFJWktqZmdnczJHdUNZTHVrMjFTcWFXaWw2LzY4T2ZoMXJZZjdNa1ozeTBJ?=
 =?utf-8?B?Sk1ENmJPeHZ4M3RDZHE0emNSOTdBcGo0Ykl3ZEUrSjhTNUNhclErdHNjZjA2?=
 =?utf-8?B?bVZoSHE1aDlWOEVLWFlvQjR0ZUowbS9tSUZHem0wdyszZmhHcTY5eGwxdy9J?=
 =?utf-8?B?K2d2RFUvUXFxRUMwc25uV1U2azZwQ1RIUmYzM2JoNEU0OUQ3c2hjNVpmL0xl?=
 =?utf-8?Q?u1ahpoLk9n8otgrQm3?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8629.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9041e594-b4df-4da9-f0d4-08dec14631cb
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2026 08:00:35.9865
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ry09mVBnRFOK5u2uokm1qKkgEYmoVU3J/KTNNOwDTFdpLvCQUn7HKLo4PmhrRjHiyrXh0vvklHfJ8VEY7w/6Ow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB12015
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.54 / 15.00];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:sashiko-reviews@lists.linux.dev,m:imx@lists.linux.dev,m:Frank.Li@kernel.org,m:wei.fang@nxp.com,m:netdev@vger.kernel.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[wei.fang@oss.nxp.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[NXP1.onmicrosoft.com:+];
	RCPT_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wei.fang@oss.nxp.com,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-294673-lists,netdev=lfdr.de];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp,oss.nxp.com:from_mime,DU2PR04MB8629.eurprd04.prod.outlook.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3F2FC635781

PiA+IEBAIC0xNTA3LDE3ICsxNTQwLDU3IEBAIHN0YXRpYyBpbnQgbmV0Y19wb3J0X21heF9tdHUo
c3RydWN0IGRzYV9zd2l0Y2gNCj4gKmRzLCBpbnQgcG9ydCkNCj4gWyAuLi4gXQ0KPiA+ICtzdGF0
aWMgdTE2IG5ldGNfdmxhbl91bmF3YXJlX3B2aWQoc3RydWN0IGRzYV9zd2l0Y2ggKmRzLA0KPiA+
ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgY29uc3Qgc3RydWN0IG5ldF9kZXZpY2Ug
KmJyX25kZXYpDQo+ID4gK3sNCj4gPiArICAgICBzdHJ1Y3QgZHNhX3BvcnQgKmRwOw0KPiA+ICsg
ICAgIGludCBicl9udW0gPSAtMTsNCj4gPiArDQo+ID4gKyAgICAgaWYgKCFicl9uZGV2KQ0KPiA+
ICsgICAgICAgICAgICAgcmV0dXJuIE5FVENfU1RBTkRBTE9ORV9QVklEOw0KPiA+ICsNCj4gPiAr
ICAgICBkc2Ffc3dpdGNoX2Zvcl9lYWNoX2F2YWlsYWJsZV9wb3J0KGRwLCBkcykgew0KPiA+ICsg
ICAgICAgICAgICAgaWYgKGRzYV9wb3J0X2JyaWRnZV9kZXZfZ2V0KGRwKSA9PSBicl9uZGV2KSB7
DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgIGJyX251bSA9IGRwLT5icmlkZ2UtPm51bTsNCj4g
PiArICAgICAgICAgICAgICAgICAgICAgYnJlYWs7DQo+ID4gKyAgICAgICAgICAgICB9DQo+ID4g
KyAgICAgfQ0KPiANCj4gW1NldmVyaXR5OiBIaWdoXQ0KPiBDb3VsZCB0aGlzIGxvY2tsZXNzIGFj
Y2VzcyB0byBkcC0+YnJpZGdlIHJlc3VsdCBpbiBhIE5VTEwgcG9pbnRlciBkZXJlZmVyZW5jZT8N
Cj4gDQo+IEJlY2F1c2UgbmV0Y19wb3J0X2ZkYl9hZGQoKSBhbmQgbmV0Y19wb3J0X2ZkYl9kZWwo
KSBhcmUgY2FsbGVkIGZyb20gdGhlIERTQQ0KPiB3b3JrcXVldWUgd2l0aG91dCBob2xkaW5nIHJ0
bmxfbG9jaygpLCB0aGlzIG1pZ2h0IHJhY2Ugd2l0aCBhbm90aGVyIHBvcnQNCj4gYmVpbmcgcmVt
b3ZlZCBmcm9tIHRoZSBicmlkZ2UgKHdoaWNoIHNldHMgZHAtPmJyaWRnZSB0byBOVUxMKS4NCj4g
DQo+IElzIHRoaXMgbG9vcCBuZWNlc3Nhcnkgc2luY2UgdGhlIGJyaWRnZSBudW1iZXIgaXMgYWxy
ZWFkeSBwcm92aWRlZCBkaXJlY3RseQ0KPiBpbiB0aGUgc3RydWN0IGRzYV9kYiBhcmd1bWVudCAo
ZGIuYnJpZGdlLm51bSkgcGFzc2VkIHRvIHRoZSBGREIgY2FsbGJhY2tzPw0KPiANCg0KSXQgaXMg
dW5uZWNlc3NhcnksIEkgd2lsbCBmaXggaXQuDQoNCj4gWyAuLi4gXQ0KPiA+IEBAIC0yMDA5LDgg
KzIyODUsMTEgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBkc2Ffc3dpdGNoX29wcw0KPiBuZXRjX3N3
aXRjaF9vcHMgPSB7DQo+ID4gICAgICAgLnBvcnRfbWRiX2FkZCAgICAgICAgICAgICAgICAgICA9
IG5ldGNfcG9ydF9tZGJfYWRkLA0KPiA+ICAgICAgIC5wb3J0X21kYl9kZWwgICAgICAgICAgICAg
ICAgICAgPSBuZXRjX3BvcnRfbWRiX2RlbCwNCj4gPiAgICAgICAucG9ydF9zZXRfaG9zdF9mbG9v
ZCAgICAgICAgICAgID0gbmV0Y19wb3J0X3NldF9ob3N0X2Zsb29kLA0KPiA+ICsgICAgIC5wb3J0
X3ZsYW5fZmlsdGVyaW5nICAgICAgICAgICAgPSBuZXRjX3BvcnRfdmxhbl9maWx0ZXJpbmcsDQo+
ID4gICAgICAgLnBvcnRfdmxhbl9hZGQgICAgICAgICAgICAgICAgICA9IG5ldGNfcG9ydF92bGFu
X2FkZCwNCj4gPiAgICAgICAucG9ydF92bGFuX2RlbCAgICAgICAgICAgICAgICAgID0gbmV0Y19w
b3J0X3ZsYW5fZGVsLA0KPiA+ICsgICAgIC5wb3J0X2JyaWRnZV9qb2luICAgICAgICAgICAgICAg
PSBuZXRjX3BvcnRfYnJpZGdlX2pvaW4sDQo+ID4gKyAgICAgLnBvcnRfYnJpZGdlX2xlYXZlICAg
ICAgICAgICAgICA9IG5ldGNfcG9ydF9icmlkZ2VfbGVhdmUsDQo+ID4gICAgICAgLmdldF9wYXVz
ZV9zdGF0cyAgICAgICAgICAgICAgICA9IG5ldGNfcG9ydF9nZXRfcGF1c2Vfc3RhdHMsDQo+IA0K
PiBbU2V2ZXJpdHk6IEhpZ2hdDQo+IFdpbGwgdGhlIGxhY2sgb2YgYSAucG9ydF9mYXN0X2FnZSBj
YWxsYmFjayBjYXVzZSBhIHRyYWZmaWMgYmxhY2tob2xlIHdoZW4gYQ0KPiBwb3J0IGxlYXZlcyBh
IGJyaWRnZT8NCj4gDQo+IFdpdGhvdXQgdGhpcyBjYWxsYmFjaywgdGhlIGhhcmR3YXJlIEZEQiB0
YWJsZSByZXRhaW5zIGR5bmFtaWNhbGx5IGxlYXJuZWQNCj4gTUFDIGVudHJpZXMgcG9pbnRpbmcg
dG8gdGhlIGRlcGFydGluZyBwb3J0LiBBdCB0aGUgc2FtZSB0aW1lLA0KPiBuZXRjX3BvcnRfYnJp
ZGdlX2xlYXZlKCkgcmVtb3ZlcyB0aGUgZWdyZXNzIHJ1bGVzLiBUcmFmZmljIHdvdWxkIGJlIHJv
dXRlZA0KPiB0byB0aGUgZGVwYXJ0ZWQgcG9ydCBhbmQgZHJvcHBlZCBhdCBlZ3Jlc3MgdW50aWwg
dGhlIEZEQiBlbnRyaWVzIG5hdHVyYWxseQ0KPiBhZ2Ugb3V0Lg0KPiANCj4gSSBzZWUgdGhpcyBp
cyBmaXhlZCBsYXRlciBpbiB0aGUgcGF0Y2ggc2VyaWVzIGluIHRoZSBjb21taXQgIm5ldDogZHNh
Og0KPiBuZXRjOiBpbXBsZW1lbnQgZHluYW1pYyBGREIgZW50cnkgYWdlaW5nIiwgYnV0IEkgd2Fu
dGVkIHRvIG1lbnRpb24gaXQgYXMNCj4gaXQgYnJlYWtzIGZvcndhcmRpbmcgdGVtcG9yYXJpbHkg
ZHVyaW5nIHRoZSBzZXJpZXMuDQo+IA0KDQpTdWJzZXF1ZW50IHBhdGNoIHJlc29sdmVkIHRoaXMg
aXNzdWUsIHNvIEkgdGhpbmsgaXQgY2FuIGJlIGlnbm9yZWQuDQoNCi0tDQpwdy1ib3Q6IGNyDQo=

