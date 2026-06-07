Return-Path: <netdev+bounces-296179-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id VFAyMjbtJGqyBwIAu9opvQ
	(envelope-from <netdev+bounces-296179-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 07 Jun 2026 06:01:58 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 17D0B64EC4B
	for <lists+netdev@lfdr.de>; Sun, 07 Jun 2026 06:01:58 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=NXP1.onmicrosoft.com header.s=selector1-NXP1-onmicrosoft-com header.b=TnX88S2r;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296179-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-296179-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=nxp.com (policy=none);
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7CAD4300CE54
	for <lists+netdev@lfdr.de>; Sun,  7 Jun 2026 04:01:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00DA6267B07;
	Sun,  7 Jun 2026 04:01:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013009.outbound.protection.outlook.com [52.101.83.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9788D4071FE
	for <netdev@vger.kernel.org>; Sun,  7 Jun 2026 04:01:54 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780804915; cv=fail; b=lIDJUpTzcCZBjvUOVsujljCPjtoiGb5AmmiOikQ9pO4oz/+Zwmcr69xTJsn5zpLixJ3Ir7nFOk4tNZtrOE9LceYrWm44cP7kgxEC5zinCSqANUbVNG8Fx6OmwAOWeoceqNVaAjEBdkezuE44vG/5PUj7jTJPAWFNkZx5ZQ+yLkY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780804915; c=relaxed/simple;
	bh=AnR/3NoM9KpxufVw4aKnD6Mk2mQiGnl5bAkKGQf+WzQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mjn1N4Hisej2IfbOksPPbePxCBvDCz+z+E0Vdr6A3gu7g4+61LI6CP+uMK0DuCtBMy11xbWdjW14sFFOtql2Aasctl0AEsB2+1t0tEykV2ZKeDTCKdqzwFhiar8wBJmeJ+jdfR1kxkTHOwhQWMAq85yQy3h6FncjDSIMgoSibno=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=TnX88S2r; arc=fail smtp.client-ip=52.101.83.9
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HLkNIzXtS7mO8TlYYEck/xd7DfIC8l3pLrQUWDkY1XxxxZrrdNw2upDIzwS9yRDyAqdYYZ1PNHClgclRZ8WQ4m2hkEwyGwChOteeKg9oWrFs1lLBRn4w06HYb5g1jMiUvxKzDAMuL20Qjk4tXmMmqg7091qLmkIsCNmCmHyoyy8oqbsauBNHytNejAxchuLzt0r37BmoG20p2MdBOdGj7Q5Q5Tave/HKW3z5WYRoW3e9xPBNHF5fpbC/8vI+93+9mUn/IrEggejJ7J2OBz+8mbmEqTHq7ttAUJyN1Lu0sys3RR374S47unt8k+W5WOSti4SjTSW3LTUfY+AIA2wL4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AnR/3NoM9KpxufVw4aKnD6Mk2mQiGnl5bAkKGQf+WzQ=;
 b=qA+aUs6EQ1fSOfQzP4HCpNhNU4Ahtzpe1sngxkTeaei/4UnSdlPMA1RaLI2yPAHr9D6+cqcpYBtaYzsY0zp4pkPW9sXwGwErh+9TNoqry6bAkKtYHmIzht3gs1C1QQBUGGp5P5VcDJmSGN95ZWGmWiLT8DN+EAMSWW3tkP96bWvYpHmemedryatQbE/IyYqubhJo10QqeIIUfrFOjF9zd+sd3ztnkVxtOsxMQk3L935WA6VWYH08ZU9HfK4y1zGB902S6gHSq+1GFxzwjZARC7vvkuQG/H2vHPjbmg1XZfefWGq1rjzaqN7C3kokznsQN8HRgYoHMgNIhDoMrv0lTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AnR/3NoM9KpxufVw4aKnD6Mk2mQiGnl5bAkKGQf+WzQ=;
 b=TnX88S2rE/6BrzmPX0EgK94DisBgSKu2M46dfhiur25d1zale7STYA2zgiQJx8ctzs/KH3v82OBzUUaueq/zWom2HxRY5D9B2/eLA8fKNBPNPW+GALhkHLWjKum9CjwzKn/J1vs6GJZm6N52985N+3OkdbMaN2n2/qDUgR9KZKgA42FVHOhVC2Jk1oi0JI91QojAsWcB8ItlbfhziNzSJCCtTOZ4InWq+imW0vY3mTranhgN2fknhIfqsAxAoE6raXxmZvuM20k1fNrLigp1x9zGaekHLLVU3IKWbtYliEeZckGGEGHt6NpZ0OyzKjPG1aJp4sTUhKOdghPBslLyUA==
Received: from DU2PR04MB8629.eurprd04.prod.outlook.com (2603:10a6:10:2dc::6)
 by AM0PR04MB6979.eurprd04.prod.outlook.com (2603:10a6:208:18b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.12; Sun, 7 Jun 2026
 04:01:50 +0000
Received: from DU2PR04MB8629.eurprd04.prod.outlook.com
 ([fe80::9d04:7526:a901:fe47]) by DU2PR04MB8629.eurprd04.prod.outlook.com
 ([fe80::9d04:7526:a901:fe47%6]) with mapi id 15.21.0092.010; Sun, 7 Jun 2026
 04:01:50 +0000
From: "Wei Fang (OSS)" <wei.fang@oss.nxp.com>
To: "sashiko-reviews@lists.linux.dev" <sashiko-reviews@lists.linux.dev>
CC: "Frank.Li@kernel.org" <Frank.Li@kernel.org>, "imx@lists.linux.dev"
	<imx@lists.linux.dev>, Networking <netdev@vger.kernel.org>
Subject: RE: [PATCH net-next 13/15] net: enetc: implement
 ndo_set_rx_mode_async for ENETC v4 VF
Thread-Topic: [PATCH net-next 13/15] net: enetc: implement
 ndo_set_rx_mode_async for ENETC v4 VF
Thread-Index: AQHc9LxR4CrneHx9e0GeRZRA7XswFrYxIZ2AgAFZo8A=
Date: Sun, 7 Jun 2026 04:01:50 +0000
Message-ID:
 <DU2PR04MB8629C3E161FE6CE4064C8B05881F2@DU2PR04MB8629.eurprd04.prod.outlook.com>
References: <20260605065550.3038579-14-wei.fang@oss.nxp.com>
 <20260606072443.B83D31F00898@smtp.kernel.org>
In-Reply-To: <20260606072443.B83D31F00898@smtp.kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU2PR04MB8629:EE_|AM0PR04MB6979:EE_
x-ms-office365-filtering-correlation-id: e9d1402d-4c1a-4340-2c26-08dec4498096
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|19092799006|1800799024|376014|366016|38070700021|22082099003|18002099003|56012099006|11063799006|4143699003;
x-microsoft-antispam-message-info:
 zRbQAcdwHCeglt49EGyFZITfAo1UOsPZ8SKEH4+H+RFPAeft1AAQmM4mu6IDYR4RiAjTTIeJEYl3jHTgMq1sjwzZpfJ0qgqCFJoDYdSy6VT6EDIU6V+JnJh3JAuhqnCnvp+3pQHHWC+4YJRpR+dCoFY3JHQJFfy1t4L9ZJ2RI7xEp+CzggowyK9vsJvY9pMyQ7U19m1ySsPfpkMjKSWnpnIvOlhko3XvZG6S64r1eFZBeFo/RCrNA40JUHvtD2iteJOQQh0f/0ED36K2a1AcbUWstv2cbXKmr6POxROg27+tqJZbJZTN1RMRtzvYU+plU1dSIMDjIVCAROUUSMxaiERGMAoVfs9muGQNo/dqOqfrN/1NpRINFLrTMHTX2D0lHvj0e3kiv4Tiyl2gWAB7Kl77WFIm1cqqtZG24Yi08fx0Rgaxi5J20lti5SZzbyPKylECAQtl74CkamZACB3mzSdDwyg672XuCUcYycityDmIF6nbfqSqaKaoohYq820hm5ko7zMaI/fxv+KwXLwzYRmmTth7MLxI9A2VOxqD2ayhjhh3RIgj1FC08oUhpEOmn1nm0+35L2oXpOTvbiFB6fIZXBD/bDxaSfEMdtgmjq75OlhXY3PLwJXzYKgblbZNQlpVHhzyP8yOoO7dTysx80uLweyHctC13rQfnYPUhwuHiisU4vmMordOXYbOhzVveE3Y32qat18Tqcab58y9/+KLEztdIW6NSIVHkpapA8UHdrvjEai1kU4M25Rgz5K6
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8629.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(376014)(366016)(38070700021)(22082099003)(18002099003)(56012099006)(11063799006)(4143699003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?aVdMTDN3cFAra3BWeTdGTFFuNjdDU0FNaG1kbm1FZTlxaEZsUVNKQVY3bzl2?=
 =?utf-8?B?ZFpXMk1DT3JteVBrL3VHd3hGOW1UMnRUYmR3bE9WSTQ5SVZXcjFzWmU3ekhk?=
 =?utf-8?B?NVQrM0oyWktCTDUydkdZeU8wQ1FLMU9UNzlLcU9rajBFSUVjVUNDZCtjaTdn?=
 =?utf-8?B?YnVBOXZqNld1cVkwRURyRFBPK0czV3FBRGhkMkJYSVgraU5jZEFNR0xmWnkx?=
 =?utf-8?B?NmV5eGcrT2RZYm5raGRxdCtFZHM2OFNSOUNRR0t5QkxiWXFaLzJzNDlnVmp3?=
 =?utf-8?B?ZDlGMVVmK3BSSklIampEeTdzN0xnMWREZVBjcGlIODBSbHdsNGdJRHVUNGJ4?=
 =?utf-8?B?b1ZXc1IyT0ZuR3F1WUsxQXNZazByN0t1NlFhTXRyMklNWHNyb2lncmxPRHhi?=
 =?utf-8?B?RStLRnk1dHhBU2pCaGIxeENncGVrVVowb1RadS90QnR0TCs5Y2VBY1hOV25t?=
 =?utf-8?B?cnoxVkZlRWxnd2hGcnVLRWVsQkJoZHBoRDFGSWY1SXZ5dDJUeHRNMitUNFR0?=
 =?utf-8?B?ajlIRkhWaGJZQUVWMG9ZbnE0L2pLejN3VFJhNHBsMHdjU3Q3RFhXdEpYZWhu?=
 =?utf-8?B?S1d4VnJDaWhaNlZIV1M3TzI2MTRqVDlzMzduQnpUck1VOWxoL1JqZXJySjMr?=
 =?utf-8?B?bkRRWU9wbnlaVGprYStFVTJXOW5wK3VFeERUcVNxeHFoS2hLdGxjejgzWjJD?=
 =?utf-8?B?OHdBOWM0b24xWmozS0gxWlg5ckFKNE9YdWdnNTN1bnpzRUlRZG5VUU91YmFU?=
 =?utf-8?B?OWl4a1llR1BHNXk2M21oTGtEOUJqcjl1MGNWWVdaZmdVTFJNVVhvN1FFRnpO?=
 =?utf-8?B?OHpQNFhvdnJoN0ZGa21Hd1ZZaGt5ZDJ6VURQK2R0Y1B3TENESWZzWk1GaGR1?=
 =?utf-8?B?a2w3cEZYelpuVWVLQXVEdzQ1RzBDK1ZBZHQrSGhpRERrMEJ2VHZ6NUZPQzJL?=
 =?utf-8?B?NGxIVTk1VGVZYUVkNkJKMEM4WE4yRms0SFQxYjR6MEhmWHRMR2QzMUVuUDl2?=
 =?utf-8?B?endGcUdQcEVNTStncHlqUW5peXlpcHRGVG9JQ2JWeEdRY1Z4bGs1MllpWnM3?=
 =?utf-8?B?SThXZm9HTFZvc2pzSFppaldWbDlHVXNKcFQwUVV3L1pCbi9uRlVGL3pWTGF2?=
 =?utf-8?B?c3dtS3k0RUVkMEM2WXRDNlBkUDRldmRmVmhHWllYZGN0d09SYlBzcGR5aWNF?=
 =?utf-8?B?TnMxN1NsTHB6a3BMbG14UEtQN0szNFBGWlVDTDhrU2d4Qm1TMzFRSll5Yys2?=
 =?utf-8?B?NENGL3hWOGdZbE1iN2NkMFBEQnZ0MzJJNUNWOTRENDV5WUJpb3NXa0YzVUF5?=
 =?utf-8?B?TXE4YVU4a0k5YU1vdzZKVXhiZnVCMk9XckJVdEhYV21sV1VIZkxva3hYeVRU?=
 =?utf-8?B?bDIwZXF0dzltMVFHb2poM2gwaG1UdGV3TnJVTWtTYnRwa01aSjRGQmxCK2Ft?=
 =?utf-8?B?MytMcjlQcXZtczFOYWZSN3ptZnU4a2ZGUzVHdDBQdmNvNm9GcHZoTGlEUHFq?=
 =?utf-8?B?VjJZbkpoL1dxM3hiZ010VXpDZVBkWVllWGpTeituTEp2NjFJNi80TGF1U2JZ?=
 =?utf-8?B?dUE3ODB0WTdQbGd0alBIQlJ1L1p6amtOdTJYdlkyOVNtZkcrU0N5bnc4NVUy?=
 =?utf-8?B?dnNvcWVpN3pCTlBpT2FORjE2ZWFCVEVXTWl4QXFwNlA1UENqY2hDSTVmdCta?=
 =?utf-8?B?b3g3VFhkRlBXVG9VcGdMMC9VWkVhblZCdHFkMFZQSjduVFBwbW54UXd3L3NN?=
 =?utf-8?B?WmNnV3VLYTdTWXU3Zm1GZmh2UlJFcWRiRGFlcENUTEVuL3F5Rm5uY2ROWFJG?=
 =?utf-8?B?QytGSUJ4YTRxa1JkMk5OdTlQNWNZazY3RXByY3Q3N2wvNEF4T1B2N2NlTDY1?=
 =?utf-8?B?Z01NelZ0QTlIRklabDZNMlhFYXNQcUp0a2QzakRZbTdITlFLVHAxd0JwbDM5?=
 =?utf-8?B?UnRJN2E5UVluQ0MyTS8yOFE3bTJncmtVaURHd2hTaDYwNHJkdEg0SnRIYjVr?=
 =?utf-8?B?OHNZNjNjSWxsZUFaaExnN2F4QmxOWlJaR1ZxT0tDd2crb3VURFI2M1dyM0Jv?=
 =?utf-8?B?SHpyWnJLamFDVGhYQmo5Y2VCb3lJTVRXeUhJOGhlUit4dUsxb01nMG96SXI1?=
 =?utf-8?B?dm9TcWRBUW4rV1ZyM3VwYWF1MW9GdDVnaXRUWGZtSXAzWUYzd1RNeDlrazVO?=
 =?utf-8?B?VUlRWDdVMXpmZis3Y0hzcEVYeFFhK2lCTllBU0MzanJYR1IxUjg4cXE1OUtu?=
 =?utf-8?B?aWtNaGw0c29VeEhUV1FGZDJoeTJDVXRybEpiRW9tN3BxMUg3UloyYU9IMUNF?=
 =?utf-8?Q?NSkTleU7eYfzI6ob5Q?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e9d1402d-4c1a-4340-2c26-08dec4498096
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jun 2026 04:01:50.1727
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1OGGU9yZFGijNEqVohlBNbwf9AWVC+GxA9nrFJPPH2X+wwPEbrg6Qo9GJ9/pO+bmvfBxNfPNkg2xAktakR9H7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6979
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.54 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:sashiko-reviews@lists.linux.dev,m:Frank.Li@kernel.org,m:imx@lists.linux.dev,m:netdev@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[wei.fang@oss.nxp.com,netdev@vger.kernel.org];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-296179-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,oss.nxp.com:from_mime,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,DU2PR04MB8629.eurprd04.prod.outlook.com:mid,NXP1.onmicrosoft.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 17D0B64EC4B

PiA+IEBAIC0yMDksNiArMjA5LDEyMiBAQCBzdGF0aWMgaW50IGVuZXRjX3ZmX3NldHVwX3RjKHN0
cnVjdCBuZXRfZGV2aWNlDQo+ID4gKm5kZXYsIGVudW0gdGNfc2V0dXBfdHlwZSB0eXBlLA0KPiA+
ICtzdGF0aWMgaW50IGVuZXRjX3ZmX3NldF9tYWNfaGFzaF9maWx0ZXIoc3RydWN0IGVuZXRjX25k
ZXZfcHJpdiAqcHJpdiwNCj4gPiArCQkJCQlzdHJ1Y3QgbmV0ZGV2X2h3X2FkZHJfbGlzdCAqdWMs
DQo+ID4gKwkJCQkJc3RydWN0IG5ldGRldl9od19hZGRyX2xpc3QgKm1jKQ0KPiA+ICt7DQo+IA0K
PiBbIC4uLiBdDQo+IA0KPiA+ICsJaWYgKG1hY19maWx0ZXJfdHlwZSAmIEVORVRDX01BQ19GSUxU
RVJfVFlQRV9VQykgew0KPiA+ICsJCW1hY19maWx0ZXIgPSAmc2ktPm1hY19maWx0ZXJbVUNdOw0K
PiA+ICsJCWVuZXRjX3Jlc2V0X21hY19hZGRyX2ZpbHRlcihtYWNfZmlsdGVyKTsNCj4gPiArCQlu
ZXRkZXZfaHdfYWRkcl9saXN0X2Zvcl9lYWNoKGhhLCB1YykNCj4gPiArCQkJZW5ldGNfYWRkX21h
Y19hZGRyX2h0X2ZpbHRlcihtYWNfZmlsdGVyLCBoYS0+YWRkcik7DQo+ID4gKw0KPiA+ICsJCW1l
bWNweSgmaGFzaF92YWwsIG1hY19maWx0ZXItPm1hY19oYXNoX3RhYmxlLA0KPiA+ICsJCSAgICAg
ICBzaXplb2YoaGFzaF92YWwpKTsNCj4gPiArCQltc2ctPmhhc2hfdGJsW2krK10gPSBoYXNoX3Zh
bCAmIEdFTk1BU0soMzEsIDApOw0KPiA+ICsJCW1zZy0+aGFzaF90YmxbaSsrXSA9IGhhc2hfdmFs
ID4+IDMyOw0KPiANCj4gW1NldmVyaXR5OiBIaWdoXQ0KPiBEb2VzIHRoaXMgbWVtY3B5KCkgYW5k
IGJpdHdpc2Ugc2hpZnQgbG9naWMgY29ycmVjdGx5IGhhbmRsZSB0aGUgYml0bWFwDQo+IGNvbnZl
cnNpb24gb24gMzItYml0IGJpZy1lbmRpYW4gc3lzdGVtcz8NCj4gDQo+IFNpbmNlIG1hY19oYXNo
X3RhYmxlIGlzIGRlY2xhcmVkIHdpdGggREVDTEFSRV9CSVRNQVAobWFjX2hhc2hfdGFibGUsIDY0
KSwNCj4gaXQgaXMgYW4gYXJyYXkgb2YgdW5zaWduZWQgbG9uZy4gT24gMzItYml0IGFyY2hpdGVj
dHVyZXMsIHRoaXMgaXMgYW4gYXJyYXkgb2YgdHdvDQo+IDMyLWJpdCB3b3Jkcy4NCj4gDQo+IE9u
IDMyLWJpdCBiaWctZW5kaWFuIHN5c3RlbXMsIG1lbWNweSgpIHdpbGwgcGxhY2UgdGhlIGZpcnN0
IDMyLWJpdCB3b3JkDQo+IChtYWNfaGFzaF90YWJsZVswXSwgY29udGFpbmluZyBiaXRzIDAtMzEp
IGludG8gdGhlIG1vc3Qgc2lnbmlmaWNhbnQgMzIgYml0cyBvZg0KPiB0aGUgdTY0IGhhc2hfdmFs
LCBhbmQgdGhlIHNlY29uZCB3b3JkIChtYWNfaGFzaF90YWJsZVsxXSwgY29udGFpbmluZyBiaXRz
DQo+IDMyLTYzKSBpbnRvIHRoZSBsZWFzdCBzaWduaWZpY2FudCAzMiBiaXRzLg0KPiANCj4gVGhl
biwgaGFzaF92YWwgJiBHRU5NQVNLKDMxLCAwKSBncmFicyB0aGUgbG93ZXIgMzIgYml0cyAod2hp
Y2ggaXMgYWN0dWFsbHkNCj4gYml0cyAzMi02MyBvZiB0aGUgYml0bWFwKSBhbmQgYXNzaWducyB0
aGVtIHRvIG1zZy0+aGFzaF90YmxbMF0uIFRoaXMgc3dhcHMNCj4gdGhlIGhhbHZlcyBvZiB0aGUg
Yml0bWFwIGFuZCBjb3JydXB0cyB0aGUgaGFyZHdhcmUgbWFpbGJveCBwYXlsb2FkLg0KPiANCj4g
QWRkaXRpb25hbGx5LCB0aGlzIGNvZGUgYXBwZWFycyB0byBsYWNrIGV4cGxpY2l0IGNwdV90b19s
ZTMyKCkgY29udmVyc2lvbnMgZm9yDQo+IHNlcmlhbGl6YXRpb24gaW50byBzaGFyZWQgbWVtb3J5
LiBDb3VsZCBhIGhlbHBlciBsaWtlIGJpdG1hcF90b19hcnIzMigpIGJlDQo+IHVzZWQgaGVyZSBp
bnN0ZWFkIHRvIGF2b2lkIHRoZXNlIGlzc3Vlcz8NCj4gDQo+ID4gKwl9DQo+ID4gKw0KPiA+ICsJ
aWYgKG1hY19maWx0ZXJfdHlwZSAmIEVORVRDX01BQ19GSUxURVJfVFlQRV9NQykgew0KPiA+ICsJ
CW1hY19maWx0ZXIgPSAmc2ktPm1hY19maWx0ZXJbTUNdOw0KPiA+ICsJCWVuZXRjX3Jlc2V0X21h
Y19hZGRyX2ZpbHRlcihtYWNfZmlsdGVyKTsNCj4gPiArCQluZXRkZXZfaHdfYWRkcl9saXN0X2Zv
cl9lYWNoKGhhLCBtYykNCj4gPiArCQkJZW5ldGNfYWRkX21hY19hZGRyX2h0X2ZpbHRlcihtYWNf
ZmlsdGVyLCBoYS0+YWRkcik7DQo+ID4gKw0KPiA+ICsJCW1lbWNweSgmaGFzaF92YWwsIG1hY19m
aWx0ZXItPm1hY19oYXNoX3RhYmxlLA0KPiA+ICsJCSAgICAgICBzaXplb2YoaGFzaF92YWwpKTsN
Cj4gPiArCQltc2ctPmhhc2hfdGJsW2krK10gPSBoYXNoX3ZhbCAmIEdFTk1BU0soMzEsIDApOw0K
PiA+ICsJCW1zZy0+aGFzaF90YmxbaSsrXSA9IGhhc2hfdmFsID4+IDMyOw0KPiANCj4gW1NldmVy
aXR5OiBIaWdoXQ0KPiBUaGlzIGJsb2NrIGhhcyB0aGUgc2FtZSAzMi1iaXQgYmlnLWVuZGlhbiBj
b252ZXJzaW9uIGFuZCBzZXJpYWxpemF0aW9uIGlzc3VlIGZvcg0KPiB0aGUgbXVsdGljYXN0IGJp
dG1hcCBhcyBkZXNjcmliZWQgYWJvdmUgZm9yIHRoZSB1bmljYXN0IGJpdG1hcC4NCj4gDQoNCkFs
bCBwbGF0Zm9ybXMgdXNlIEVORVRDIGFyZSBhcm02NCBsaXR0bGVyLWVuZGlhbiBzeXN0ZW1zLCBz
byB0aGlzIGlzIG5vDQpzdWNoIGlzc3VlLg0KDQo=

