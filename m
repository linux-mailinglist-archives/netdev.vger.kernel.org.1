Return-Path: <netdev+bounces-304824-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id nCGkEhoES2q1KwEAu9opvQ
	(envelope-from <netdev+bounces-304824-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 03:25:46 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AAFCD70BE75
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 03:25:45 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=NXP1.onmicrosoft.com header.s=selector1-NXP1-onmicrosoft-com header.b=mjH0fWGg;
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=nxp.com (policy=none);
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304824-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-304824-lists+netdev=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AFE5030099AE
	for <lists+netdev@lfdr.de>; Mon,  6 Jul 2026 01:25:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CD34322B6D;
	Mon,  6 Jul 2026 01:25:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011002.outbound.protection.outlook.com [40.107.130.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC991324B06
	for <netdev@vger.kernel.org>; Mon,  6 Jul 2026 01:25:41 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783301143; cv=fail; b=qfbLio1aI+ey+JMtaXiyZtfRwk6PU/bCKry+XKXUT7RzPk1ueogY5SMdGVSA39Fznh/JeiisRTuVlQwqtA7CyPF7Mm1ADV7dUL1GXHwL2cxCcZYLNwseA+vCcWHUpckK/mnbohV8z/jCZ9GwRKZKGpBwfPER4+TOkfTaoKLfB8E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783301143; c=relaxed/simple;
	bh=3BHodUfpGd8B3Gi5qhyDCk/Dme5CZzXQmEsTERaD6G0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hUrwLAnBu4MPaBpGzxdf1m1eeWgpymikPttJKaS0CFgLJmynpLr5YWjhi2STC1+AJejIOD3F2oCmYycL+2X5l/RAPGexnLBqhpMB/REwW3w/iBP+lA12SscgHdFqtnto2MSXOXh67L5vxLHllM1C9wsoAAvspVA6H5ERtQ/egjI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=mjH0fWGg; arc=fail smtp.client-ip=40.107.130.2
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tv6Tw7aGlgM51fzb+523XvE+d0n27ityFyGctiO6Gjrba5NLdmOPxiQhyhoo6BdkIXjcnHvY0hnfnr8bVIal0b1uts6yQdYbKKzAFoHcSjdOe3/4cSvWBSajD1Ib3xufShxxly1hxksPag8S4dbF2CsBvkixWv7H28YSAPx2+EJX3xDpEbADDPFQoU7av27gA2pjtw2UORsGFCSmbTLu2bvLOma2hxfowlkcDNxKqBrjpef4TwaMzVb0L3PoqhcfGs1a5DUDfMe9s1cerV/t70B+HvopULq8+9+Utea8M49Iui5U+s/yqrSTBHZLFqYu/NOo/WWdzjXfL2SwG8o6HQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3BHodUfpGd8B3Gi5qhyDCk/Dme5CZzXQmEsTERaD6G0=;
 b=x1rZt+pOWT1G4MiZhb9DaWuUaPqsr2A9Dryk79zAHPqYuOcL639QYKTAc7pDXxKDRLKe1gpWISuxu0zkeQyMJg4NkAVeo1NFTkNzDqW8wRY+OApP0biKwn3nkbo2Y5uGremWswSCg2A7HQuPzqGm8g46r39X+KnDJstnNlHZ36E/x5IqG6EwQo6NLE/y3aXT8fRWrcTfwBu7jZ0Pe2iQSTP6eT/9r3P0B9vAphvnLWR0kWBF6tcpVv7Vekx5kE4FtbYmiL9HW6PNyKnTQMDhDFzXPVSxB1GVZj0jbJceKMinB7UKoc3Wz4pKIvLkBOSYBxbyppg8G/BDPY6nXzyo6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3BHodUfpGd8B3Gi5qhyDCk/Dme5CZzXQmEsTERaD6G0=;
 b=mjH0fWGgqN7/XgkKxsO/InKI+OaWyVYem3pFolnIiUGFVXzb5NZFDOgqeCF0kOrcCRpPV783O0vM5qJls3tzTIiNXe1f8X/e0PfZrAquBoj+ju1szLxluvKyLcqh7SxXIhEDvgU/mv8Ulbo9AHaElRKi8pkEJt2O/ePfZx0J16JGIW/pnjdoIodTjQ+rY1xhhAUKQiNS4ABCQflVBMOQQ6fa+83eUSh82c9NE39HN4AAMwhJV6D+3OaTLWQ8pxPkv6ORWLgP0ec8Cr6o8LyuhvBSvOV6wurM19g3jn42RK7zexY4z8st0/wbO1Z9JFEWZ6b+h+QZKQS3JNRCl9xdGw==
Received: from GV2PR04MB11739.eurprd04.prod.outlook.com
 (2603:10a6:150:2fc::18) by GVXPR04MB10705.eurprd04.prod.outlook.com
 (2603:10a6:150:223::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.11; Mon, 6 Jul
 2026 01:25:36 +0000
Received: from GV2PR04MB11739.eurprd04.prod.outlook.com
 ([fe80::71c2:937b:d466:174a]) by GV2PR04MB11739.eurprd04.prod.outlook.com
 ([fe80::71c2:937b:d466:174a%6]) with mapi id 15.21.0181.008; Mon, 6 Jul 2026
 01:25:36 +0000
From: "Wei Fang (OSS)" <wei.fang@oss.nxp.com>
To: "sashiko-reviews@lists.linux.dev" <sashiko-reviews@lists.linux.dev>
CC: "imx@lists.linux.dev" <imx@lists.linux.dev>, "Frank.Li@kernel.org"
	<Frank.Li@kernel.org>, network dev <netdev@vger.kernel.org>
Subject: RE: [PATCH v3 net-next 07/14] net: enetc: differentiate phylink
 capabilities for pseudo-MAC and standalone MAC
Thread-Topic: [PATCH v3 net-next 07/14] net: enetc: differentiate phylink
 capabilities for pseudo-MAC and standalone MAC
Thread-Index: AQHdCtit8E60dIl+pkiCajdQzz/ugLZdLkcAgAKIrpA=
Date: Mon, 6 Jul 2026 01:25:35 +0000
Message-ID:
 <GV2PR04MB11739F976E16A353FC3EF1D4D88F12@GV2PR04MB11739.eurprd04.prod.outlook.com>
References: <20260703101328.550714-1-wei.fang@oss.nxp.com>
 <20260703101328.550714-8-wei.fang@oss.nxp.com>
 <20260704104345.5B94F1F00A3A@smtp.kernel.org>
In-Reply-To: <20260704104345.5B94F1F00A3A@smtp.kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV2PR04MB11739:EE_|GVXPR04MB10705:EE_
x-ms-office365-filtering-correlation-id: 0a2b5ff3-be55-451f-8d5d-08dedafd7b22
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|19092799006|376014|23010399003|18002099003|22082099003|38070700021|56012099006|4143699003|11063799006|6133799003;
x-microsoft-antispam-message-info:
 QuPpXrcVdHtaU1VlVTdVw6RRzlljgh5HwC072/YlsRmucKLntzU+lbq4ahQOvX8k0jhrK7jGdRxV6GeCA5w1Tww7coppSCyl/6vzk5G3JSYwssMzLG48+XUD2ynVMPncK9bNP+pTBuEFcRSfJRpwCkYnmySxNVg/PtF0olOZml4+S3NvnCUH3HeaO9GPu1nOdhZOHkwlxgs+zHaW4nhZPo9wfYmxC7OoJJUtBcERJzCGuN/Onq/mdWylEx8fuLGmGkGBlngnFy4MVYkidqWaY5ih7qykMHvHkDbkE2vDqiPJK+2VVUu22X7Bz5HElTbzsXhhs51Pw5aSJ8Mx3fBQ1l8vNWhT7Q8QV6xSm+4/CPr8BTozw03hYIO0CtFXaBiHG001iZWAVjrxRQQxv3kctEb7dTlLQmJ9LJ2bZ3VxOfB67/BYVd15KK4IKTE/ewrECzrZhcnnQP0/aJmLQA14s0BQUQaJs0L0CiFxsqBFzLrboS83xO7+0ERUBLU8A17moF26rY1XUNnIJwyh7zXIy/V/OhCweavk0gzf5kmRfNBOWrRu/rhqkn/QVtILS2fYD/7M6surE/KQoVPzss5xxY1v3ZZipHf9lyoJ6bT2XumHUFdy3Nkeisgr0bJ1CE6ffb2VILkjuNKDiiFqRnL7MeaF2BFWxBtdTbncPOij2clDWB4TZTTIT34BIf7NpRkyjxMUXUCFaH0dnUWrm3C+O4QJOZPGS11CFWJCeITqLx0=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11739.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(19092799006)(376014)(23010399003)(18002099003)(22082099003)(38070700021)(56012099006)(4143699003)(11063799006)(6133799003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?T2VIUWZQUjlDN3FWWHo4UkFZRFZsUGhNSzU1S2t0R1RYcHd1S3BLU0tDOEpS?=
 =?utf-8?B?RVZOcTNpVndzdW9tN2hqSUE3Mmg1WGduWVEwRHNhNUtLczIwZUU5Rno4MzlV?=
 =?utf-8?B?ZnJhWm5kcVVRSzNiUzRuQU04akxSZjR2YjRVMXZleDF3aXJiZGdZWTFjdWxZ?=
 =?utf-8?B?Qi80d1FjODNwakh0d2Nvb0M2eTRqVGtRcHFqSjUvZGptY1lpeVQyT2EzMHF3?=
 =?utf-8?B?eG5uamM0TjllbnhueDVQVzFOZ3RMRnFuSGFlZGozUFN5SDY4NkRhaFUyc1pm?=
 =?utf-8?B?aHRHd0V3K3hGWnpqTjIzdXF5MHJaenRIN0lDZHI0NEt0bG9WelBXUTRHSGxm?=
 =?utf-8?B?b1VURUlNR0wyTm5KckZyTllTdTNqcFlyU3BWTmRXUG1kME0wd2t0TjZqRTcx?=
 =?utf-8?B?VmZIdWFJRVU3ek81SjlzdWNHaktoYmVIYlhBR3pjcWVOV2xUZGFlOWFWZm43?=
 =?utf-8?B?cFVrRmVQOENPS1ZKL00reGZXL3NlTzRUWm4zUVI1anZoUVZqbC8xVXBiTFJI?=
 =?utf-8?B?aTNuS082aUxMYm1Qak90WEN2cjcyZUVJR3cvN2dxeCtQMGdEOENJcG5WcUxU?=
 =?utf-8?B?aFhldXVvL2hkWm9MVmpaQ3V3WmtEaUs4UEtqWVhuRVJ4QmRoekF0RXBhNG84?=
 =?utf-8?B?aExtQjFlOHBQN2gzWFJNSTFRYm9hQWE2Z3Z1NDUxUkY2VExGVk95SkY5elZt?=
 =?utf-8?B?bHJkMnR2bWI2akpZRW5ta0JITDRPZFlMeDNPbjFLNTZUUDdSd3A3QnowQ2Uv?=
 =?utf-8?B?cUlBQlVDWE1UbGFJQnVXbnUwQytMZ0pXL3d2aVRKa3llNVMzdVNybFZjQkJm?=
 =?utf-8?B?YnNIdmo2bHNKV0RNeC9QZENGWjZLUW1MdTAra1BkYlpkRlpwdnppTkplYnd5?=
 =?utf-8?B?WU9yOS9USUNQQjZKUEdnWUV6bkZkOUVBT2owSXU3d0pnNWJxcGQ5QWZRbUY5?=
 =?utf-8?B?dDc4UjU5MDBmeno5TFJxa21rNEIzVHlwSmpKVFNWa1J1YVZSYnIwNlhTbE9o?=
 =?utf-8?B?dDhGU0w2SC9iTTNhOGZtNVZmQmZrZk9CbnF1YTZVUDZvRDN3SWRNSU16Uk5B?=
 =?utf-8?B?MUs4OFpvdjB3c2xhR3ZMdWRyQ0V0YnNNNU42NjJUSEV1VTJFZldkVFJPa1pm?=
 =?utf-8?B?cVEzSENBNmMzQjJSWktSVGFGcGxhUmkvNXNPUUtEcGpSYzNmN1NpSktxc2JM?=
 =?utf-8?B?dTBjUEhHUXVFemNQMEdVcWVCTURrbnFYNzU0RC9JR3UyZWsxUEpSUGs3Y0Jo?=
 =?utf-8?B?OHBWSmZXcVZGWUZ5N1dNZjE1ZHE0S21WRWJTc3lTNERuNC9SUXlUb2NNekp6?=
 =?utf-8?B?VFhEbkpEUDBuWjl1VlpaSXRFUVI1Y2RQL0dVSHp0RVNiaGV6bVREOWV5ZGtw?=
 =?utf-8?B?VU1CNllXeUQ0YjFIaHpTcEwxSW5MMnhiMC90dE5JYnFhaGtrVWNBRC9iNkl4?=
 =?utf-8?B?aTc4elBkUWR2eGl5R2tONnh1TGRremxwTWNXU2ZMdXp5aGQ1NVFUSGVVMDRl?=
 =?utf-8?B?dHllOHI0cFBVeU9nYmQzT2lBTDVsaXRFMmptZElSeUY2Tm1POUFtYVAwL01C?=
 =?utf-8?B?OUdJM3EyZ0h5RlZLSGZlTVArTkhFRTJzOW1DaVI2VkdobldWTTNVVmxiQk8x?=
 =?utf-8?B?N2xMUDRPZElWTWJ2UE10QnBIOWtCbHJGSWpSUHRSRDVTa3pxbFB3RlF2eVBu?=
 =?utf-8?B?S2NmY1lvUVNzMzRZQi95MkVIL1ZCdjBQdS85eUN6emM4UDZuY3hndjNqSlpR?=
 =?utf-8?B?cVQzNXAzZ3B1N3diWEFhTG16V1pTeThVR1JvYXMzRlUyLzN1WGVFODdzV2dn?=
 =?utf-8?B?V2xJWm1NWHdPcTQ2Q2RjejB0dm1jMC9JczR2OHpodFo2eFI2WkJOTHBkNkJR?=
 =?utf-8?B?NHN1enlNeVlCaFR0TTJqYnAxL29tMEFvaDFyTlJpckZ5Z0VlUnFzMnRteFJt?=
 =?utf-8?B?S1d5WFFRaFZGQkdSTDhtSVhSSjhvSUlMclZ2ZmVHV2RjQmllelUweVBqVHZw?=
 =?utf-8?B?L1RZNTNEWkVtT1RYMUdqcVRVT0pHMENINjZLekdweGoxaVE3c3J2Q2d4UzV0?=
 =?utf-8?B?QkhEeDNsODJncmJrOEhsSEYxSDBta1VGWm11OGFrWjd3Mko2eTBlU1lkeC92?=
 =?utf-8?B?TW1GV0twU3duS3loMEJMV1hwNlZOVGwxM3M1bUZhU1liZ2ZqYUFvTlBMUTZO?=
 =?utf-8?B?SE51dnZFQ1JTYU5VTVpvV2h6dk8reC9TclplbCs0bDlDR3htMDF3eHgzYm1v?=
 =?utf-8?B?akVtZ0VlODY3U0QrZzlWQmRsM1lIZEg2QmoxVVZyd0k4SU9GNmhLdzBXSHpj?=
 =?utf-8?Q?SbdAwXyFuFfvarz8Wu?=
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
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11739.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a2b5ff3-be55-451f-8d5d-08dedafd7b22
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jul 2026 01:25:36.0383
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0CGEiSTZzdKbLH7OEby4a1MJTsfWNdO+/b2un2nTauQstcG0TvZ2zfL8ESIgz3UZ2bSge13McIPF/nS8jWE+vg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10705
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.54 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:sashiko-reviews@lists.linux.dev,m:imx@lists.linux.dev,m:Frank.Li@kernel.org,m:netdev@vger.kernel.org,s:lists@lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[wei.fang@oss.nxp.com,netdev@vger.kernel.org];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-304824-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[NXP1.onmicrosoft.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wei.fang@oss.nxp.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,NXP1.onmicrosoft.com:dkim,GV2PR04MB11739.eurprd04.prod.outlook.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: AAFCD70BE75

PiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC9ldGhlcm5ldC9mcmVlc2NhbGUvZW5ldGMvZW5l
dGNfcGZfY29tbW9uLmMNCj4gYi9kcml2ZXJzL25ldC9ldGhlcm5ldC9mcmVlc2NhbGUvZW5ldGMv
ZW5ldGNfcGZfY29tbW9uLmMNCj4gPiBpbmRleCAzNTk3Y2I4MWE3Y2NiLi43ODFiMjIxOThjYTg2
IDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvbmV0L2V0aGVybmV0L2ZyZWVzY2FsZS9lbmV0Yy9l
bmV0Y19wZl9jb21tb24uYw0KPiA+ICsrKyBiL2RyaXZlcnMvbmV0L2V0aGVybmV0L2ZyZWVzY2Fs
ZS9lbmV0Yy9lbmV0Y19wZl9jb21tb24uYw0KPiA+IEBAIC0zNTksNyArMzU5LDggQEAgc3RhdGlj
IGJvb2wgZW5ldGNfcG9ydF9oYXNfcGNzKHN0cnVjdCBlbmV0Y19wZiAqcGYpDQo+ID4gIAlyZXR1
cm4gKHBmLT5pZl9tb2RlID09IFBIWV9JTlRFUkZBQ0VfTU9ERV9TR01JSSB8fA0KPiA+ICAJCXBm
LT5pZl9tb2RlID09IFBIWV9JTlRFUkZBQ0VfTU9ERV8xMDAwQkFTRVggfHwNCj4gPiAgCQlwZi0+
aWZfbW9kZSA9PSBQSFlfSU5URVJGQUNFX01PREVfMjUwMEJBU0VYIHx8DQo+ID4gLQkJcGYtPmlm
X21vZGUgPT0gUEhZX0lOVEVSRkFDRV9NT0RFX1VTWEdNSUkpOw0KPiA+ICsJCXBmLT5pZl9tb2Rl
ID09IFBIWV9JTlRFUkZBQ0VfTU9ERV9VU1hHTUlJIHx8DQo+ID4gKwkJcGYtPmlmX21vZGUgPT0g
UEhZX0lOVEVSRkFDRV9NT0RFXzEwR0JBU0VSKTsNCj4gPiAgfQ0KPiANCj4gW1NldmVyaXR5OiBI
aWdoXQ0KPiBXaWxsIGFkZGluZyBQSFlfSU5URVJGQUNFX01PREVfMTBHQkFTRVIgaGVyZSBjYXVz
ZSB0aGUgRU5FVEMgdjQgcHJvYmUNCj4gdG8gZmFpbD8NCj4gDQo+IElmIGVuZXRjX3BvcnRfaGFz
X3BjcygpIHJldHVybnMgdHJ1ZSBmb3IgMTBnYmFzZS1yLCBlbmV0Y19tZGlvYnVzX2NyZWF0ZSgp
DQo+IHdpbGwgY2FsbCBlbmV0Y19pbWRpb19jcmVhdGUoKSwgd2hpY2ggZG9lcyB0aGlzIGNoZWNr
Og0KPiANCj4gZW5ldGNfaW1kaW9fY3JlYXRlKCkgew0KPiAgICAgLi4uDQo+IAlpZiAoIXBmLT5v
cHMtPmNyZWF0ZV9wY3MpIHsNCj4gCQlkZXZfZXJyKGRldiwgIkNyZWF0aW5nIFBDUyBpcyBub3Qg
c3VwcG9ydGVkXG4iKTsNCj4gCQlyZXR1cm4gLUVPUE5PVFNVUFA7DQo+IAl9DQo+ICAgICAuLi4N
Cj4gfQ0KPiANCj4gU2luY2UgZW5ldGM0X3BmX29wcyBkb2Vzbid0IGFwcGVhciB0byBpbXBsZW1l
bnQgLmNyZWF0ZV9wY3MsIHdpbGwgZGV2aWNlDQo+IGluaXRpYWxpemF0aW9uIG5vdyBmYWlsIGVu
dGlyZWx5IHdpdGggLUVPUE5PVFNVUFAgd2hlbiBjb25maWd1cmVkIHdpdGgNCj4gdGhlIG5ld2x5
IHN1cHBvcnRlZCAxMEdCQVNFUiBtb2RlPw0KDQpUaGlzIGlzIHByZXBhcmF0aW9uIGZvciB0aGUg
dXBjb21pbmcgc3VwcG9ydCBvZiAxMEdCQVNFLVIgbW9kZS4NCjEwR0JBU0UtUiBpcyBub3QgY3Vy
cmVudGx5IHN1cHBvcnRlZCwgc28gdGhlIHByb2JlIGZhaWx1cmUgaXMgZXhwZWN0ZWQuDQoNCg==

