Return-Path: <netdev+bounces-297607-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id RMNwFog+KWqrSwMAu9opvQ
	(envelope-from <netdev+bounces-297607-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 12:38:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B28E36685C3
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 12:37:59 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=NXP1.onmicrosoft.com header.s=selector1-NXP1-onmicrosoft-com header.b=JWBlFhHS;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297607-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-297607-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=nxp.com (policy=none);
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 016A03150614
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 10:31:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 513B03F6C2A;
	Wed, 10 Jun 2026 10:30:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013032.outbound.protection.outlook.com [52.101.72.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F3A23905F4
	for <netdev@vger.kernel.org>; Wed, 10 Jun 2026 10:30:14 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781087416; cv=fail; b=m7oBYl9bTtdexkQ6u8Lr/EBeRD3H7RNrb6j+Cn2LWroQoSwWLY8P9aDl1inmTeXcOVGJ8flCGeTSBybTWM/9d4/cbh0btJFrQYG/7jajEzxrekzriJWStkiM2h2TXWqhzi8SAldXGEsXLABvOWB55ulgwDNRw+cVcvmZOCdOcms=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781087416; c=relaxed/simple;
	bh=d6R94Dr3TboVGVqnjDwQyG4NKfvbvVXfSMh57HuP2NM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=je+I5jRp50U4I0a0jp0LVtzd180Ajzoq4euMWFTzY+TQNYDjmuBlzYQAxd5ayxxFRuHfeUTSkSNFpJa2xWqOo2LZt4VXK9tOt2GZy+kIVpUL9Fl1FLdMk7kN6iU3MER+XlpqPSs6FP3KEMUtJx1/mv/QoqZJCb2LPU1y8CzptmY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=JWBlFhHS; arc=fail smtp.client-ip=52.101.72.32
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n5GvHJMGjGRe+Qp5B4WFApRL6ebEhixOGLXRodN3iCbYoZdG4S+N72ghtwis/+OkpZ6uek8KukZP7BQTzpGnWED/rAiWkzjsxV4QaJg9rqeyZWHzabIuRgreK4yvBk6Ed5PUvN5jR9Ac0NWRpP4+Hc4RjRTuzirbtq6WH31YaeuZQo4Q5lx51o4VePVt0+8+poik6OZuZ7uM7EF31kdQGxBNdgN1FSQa42m0hY30Q6EyCE4ppIHSvJMRAkaojaZ42Bqzs7+29EyOUCXIufDn+9bX7WtsHpZ/e/Ny8Qi0W8o4fLbkwrijPpsEmz0F6b3Itdyr8FAb23c8Yyj1cp4Esw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d6R94Dr3TboVGVqnjDwQyG4NKfvbvVXfSMh57HuP2NM=;
 b=QYj8nh9q/zIh1inT8DLk9hrJlFSeMejQHdOiz/YMUp7XihUbCgGGpwzpXbu0ghj8Cth6F8fKr+S/sZjMRIGl3tauoKWybFAHLK6UcmA1Mi6mfkfAvcvptInixWxoyGI+PioQKyT09Vm1Yt//6YODaR4HCSmUqNTbrYdTVlTGJyjm/w2ejqUmWV1A3RA8j5lMrwLJAE/pHgXow6A+q/+wZUcDZ1OE9ZuZ5+nlhrmzwBR60N1G0syvc5RWgWZGB6+tJfr/w8UZdWEgqyrWZNvOdG0sqTv3Wnhl6eIJ6brogqZEfAYr9CGg1nv0jaIg01MRXUttSICQ9jErWofJfOF01A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d6R94Dr3TboVGVqnjDwQyG4NKfvbvVXfSMh57HuP2NM=;
 b=JWBlFhHSiTxzSDUP1ii+RTb8foD2YVmMg/1LVok0gQLkBv8fusnsWqgA4huKAoiuse9BnNa5pdmoRiVI/0WLtBvEGp+cn9tqbVCa9TTv0ufNLDtkJsQgkai3flZEMIObioEmBicA8nNsXzGB8Ae7entA3PgexoXZRJebRvnAga2JbINTgZgcV0hLStWH8+r2A3wkYoMPbnRN7yDOOZByaCT7b44+9qW4tDe8Dtl3vLTMHd5WcRiBdyb8UxyVKdMW7BamsotTyvOLyx9D/1nmwHzmmsr2Z+EhvTH/IA1D0DoPmVcsAY1M+TLWMXeJLieP8rJVCTq3Xwx8+b9jXo0uvg==
Received: from DU2PR04MB8629.eurprd04.prod.outlook.com (2603:10a6:10:2dc::6)
 by DU4PR04MB12084.eurprd04.prod.outlook.com (2603:10a6:10:63f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.14; Wed, 10 Jun
 2026 10:30:09 +0000
Received: from DU2PR04MB8629.eurprd04.prod.outlook.com
 ([fe80::9d04:7526:a901:fe47]) by DU2PR04MB8629.eurprd04.prod.outlook.com
 ([fe80::9d04:7526:a901:fe47%6]) with mapi id 15.21.0113.011; Wed, 10 Jun 2026
 10:30:09 +0000
From: "Wei Fang (OSS)" <wei.fang@oss.nxp.com>
To: "sashiko-reviews@lists.linux.dev" <sashiko-reviews@lists.linux.dev>
CC: "imx@lists.linux.dev" <imx@lists.linux.dev>, "Frank.Li@kernel.org"
	<Frank.Li@kernel.org>, network dev <netdev@vger.kernel.org>
Subject: RE: [PATCH v4 net-next 8/9] net: dsa: netc: add bridge mode support
Thread-Topic: [PATCH v4 net-next 8/9] net: dsa: netc: add bridge mode support
Thread-Index: AQHc97/w0Go1wFMDHUm01FXLKIauvLY3IsYAgAB17/A=
Date: Wed, 10 Jun 2026 10:30:09 +0000
Message-ID:
 <DU2PR04MB86295096E35D58102EF5548E881A2@DU2PR04MB8629.eurprd04.prod.outlook.com>
References: <20260609032955.2066089-9-wei.fang@oss.nxp.com>
 <20260610032801.07C8C1F00893@smtp.kernel.org>
In-Reply-To: <20260610032801.07C8C1F00893@smtp.kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU2PR04MB8629:EE_|DU4PR04MB12084:EE_
x-ms-office365-filtering-correlation-id: bff93bbf-df8d-4ef6-8ebd-08dec6db3f39
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|19092799006|23010399003|366016|376014|1800799024|38070700021|56012099006|4143699003|11063799006|18002099003|22082099003;
x-microsoft-antispam-message-info:
 cIuRkIZU4hLDcnQDG4gBkieyWUo5F6yb9/TlPGPon9jl+D+gqLS/UQsNpWbv/RhMdfyJKpADUUFbf3qaoJwIn6kxaG7s2sJrA3Juc6pqwnsZhbwYLPeBQcOWPA0zdqnunOapJob3AIpGxiC+157T7GYwFyu+UmUHanf8VTX16Ica12UTmJj42qkzZwbTBy4/4CrjP5N8PdfplfGDm/wi1MJoV+9Opmfby4Uqgc5UFyjIRM2HmcEkTwNZQDytncpde+WJ7JJQ579bMnvDGv1PeJDktCdF8JA86VUa/c7XTI41lNyMlfUf5vTgbbd22kKWIIdVlSop6ik64i9yxAS1+Rcqn4ex8xOP/fh2Ttbs6V6lgxk1J6xbH6qsQ3Fq/dp2YkFJrj2e0CdHgspDK+AswKmoWFb+TTfbUDZaCJkjrZeB2b54Baj5Gw0bnzOfXmZacM5kkBAELoHVk3ap+SHvy3OTR6dR9TSiagvUL+/ykfs2C6fQI5nI/TRsNPYyNj8fxPP+UVjAF/h6y2QCZBYFaw+ziYduopKXa9gk7zYQdroy9fR5SVEaWuCZlRzk16cduKRhyCydwZIrR2UdDF0NQ0SsD2Jm/OS+YPzwZe/noI/mome7uM7Bp3Bs0pWiwGghtNPREYIm36Djmdlx8npNqezOK4KiHvtjc8DTRGQxfU4+ElChuz5KPmdfmk/uaIhszrhYrOFWKDzuBhgzdeD8UM2d2EVKhdLHKwrSqcNoQhXm3ofM+7cy+ZVAgHmAk8R7
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8629.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(23010399003)(366016)(376014)(1800799024)(38070700021)(56012099006)(4143699003)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TFg5TDhycCtwS01ldWpFZ2FZQ1JkUGlqeGpGUng0WG9mK0paV3JwQWpNVGpO?=
 =?utf-8?B?TEx5RUdwSmt6c2Jqdzh3MzByc09FU1RwTVI5R0FEQXFJbEhzZUVSNFE2S200?=
 =?utf-8?B?NFFlNWtkTU5vUExlVmV1VHNDV0IrYXlMWTE1YjlPWUIyWG1zT3g0dWZtcisv?=
 =?utf-8?B?UHVJbkwrYVczeUNkRWVoaUxUVWNtb0ZSSUo0NjdHa0pENk5TZHZvQkNOLzg4?=
 =?utf-8?B?QmxJZWpnWElySVF1RHNyWnhzWHQ0dm1jQ3hBNTI1WEVkOTNVVXZsak5PT2RF?=
 =?utf-8?B?aWVPVEdNRjNqMVprTHlLYjFIOFI2ZUlENFhsVlB4TXdCK1NHNzcyM3Bpa05v?=
 =?utf-8?B?TXh4Mis1VURLb3Zlck9BT1ZqWkRKTUluV0dtTU5mNEdNTEJPUFpvZnNrM3hT?=
 =?utf-8?B?bWFLZ3A0Mzk4amZwVjVQUTVCSDVyWGVzSXZ4VEQzUFNOZldVVm1Ecm1tMVVq?=
 =?utf-8?B?UmlGMTBweU9kU1pVRXd0Sm5mdGF3clpuRWpya1prci9BVGhzSkF6cjMrUGE1?=
 =?utf-8?B?Q2s3OGJneGlsRGZtSldYZkhJRkdqVUdOQXBCbWNBeDk0RFdKc09RbHl3RUd3?=
 =?utf-8?B?MnB4c0tDYkJNOFp2RnMyWmV2TWUyL2lIa0tXdGhET1Y5eDhBelpaVUl2OEE5?=
 =?utf-8?B?TkE0UThoU3JZM1Nnd0ZUaXFiTE5TWm5zU1A1Ty9PS2NnQkVOZHQ4Z29OMVVj?=
 =?utf-8?B?TFg5WXBTdXBONTl2a0w3a2pQdk9IZUpHRXd1Y2djWk0ycTFSTklaR1ZOQnht?=
 =?utf-8?B?a3UrbHo4eFJ6Qm1sQlpKMTRXenVnQXNhTnUweDBlOENuTHB5TkJiYVRZS3ZN?=
 =?utf-8?B?eFdFa0N2Zk85MDk1YmZYcVl3Wi9WWVpOOHZVZHJzZFRYbTgrRUs0UFpUak0w?=
 =?utf-8?B?VGNJZHc2QWpnLzlkQ3dRN2ovUW0wamFvWEdCeHhKSDFTcHNmL3lXeHU5cUY1?=
 =?utf-8?B?NFcyZEpNT210NkFxN3FFeE1UNXRWMytZc3M1M0U2d1J3bkdROG1ETDZrVGlQ?=
 =?utf-8?B?TldKbDdzOHpmQjZlNVgrMG1HZjdnZHZ4dWoxYmZrcS95aXdFR2puTjFrMEM3?=
 =?utf-8?B?aW5YdUFWYkVoVzkyTjlMRXhBZWFHYlJCWWxOakkvcmJSY2JUdHNEbExVeU9T?=
 =?utf-8?B?R2hpYUl4TzFBbjdZc2c0UVBOQ1FuSnVBaXcrSmtFZmliSGQzbGVIeE0xWDdM?=
 =?utf-8?B?elRYcDI5MFJncHZWUlcrVnRUMmNDbVlUaEtyREFzUmIyaDBpNWZjWWJxOVg5?=
 =?utf-8?B?UUNOYU9IZ3NDWVBOWUpGZUZEcW1hRWl5ZU5DYWJUaGZoL2wvV013ZnA1OTE0?=
 =?utf-8?B?OTFsVnc0UUIzMGdYOVZNU1RubkVTZ0QzS2paYTBPNys3cFc5NzhJMklLdm5w?=
 =?utf-8?B?K2VkTFd1V0RWMFNDbEkvck9wTDNHREg3VjhBUllkbXRYMGd1UDM2RG9YN1U0?=
 =?utf-8?B?Y1RTakhkUnYxQXpYdzhBblJlMkpuc2ZvbFFKTjRHNjhQK05RVnJzWXR6TDJH?=
 =?utf-8?B?eEJpTjVRVHlxMFJaU2FvSWdTajFFTVJMVXpVVXVhYXM1ZEtnc2dNenBUTGp3?=
 =?utf-8?B?L3ZkWnY3Zmd0eC9SZm56Z0JJTnE1ckJrNVE3OWhPbW9tRDFoUlBCRzRwTzFP?=
 =?utf-8?B?cnp1Y205aDc4WnNvZ0hRMXNKQy90alIwN2ZqZnZ5c0NEdE0zWjBnUnU4ak1Y?=
 =?utf-8?B?VDc0Y2tOR05iZTA0SlZqM0swOXdJV0ZrM3hYQzRPTktZUmVuNW5WbzlsOXRo?=
 =?utf-8?B?Q1dGd1FoYUVFbWViVExPZVl6RS9maWhVdkd0U2c4dHg0KzkrbkIvVlNsN1FK?=
 =?utf-8?B?SDdqV0lJYnU4UlpFN1ZKQ2V3TkVWMzRxeTlTRjNmOGk5WGJEN2Y0NGdCcTFo?=
 =?utf-8?B?K3piZS9KeEtaMFg3TU1xMjRNNk9HYUNtSjBCV1lyL3lvSy83U2QwNHpySDM5?=
 =?utf-8?B?UHdwaE1YcFhYL04yWFFDRjh3bkczMDR6SnhaYnB0QVBnbnV4bnlGdGFqeU8y?=
 =?utf-8?B?bkNmcGtnNXM4eDB5OUhyOHYra3VqWkdKWjRxVG5VZEtIei8wVnFSK0pwNm1i?=
 =?utf-8?B?S2s5TERMSkdVZHlZMU1iQTFTck50clVQdGx1dm93VjF5THJQeW9BTGd5VHUr?=
 =?utf-8?B?MTdWeXE2R0FzaEJKZFlqVTdxalJ5YkRTdyt6cVhVclZEQlNkWGV1ZS9IV2t2?=
 =?utf-8?B?S0VUbGJIVGRJcExqdnJHUTB6ai9UZUUwckQwVW52NWcvUVJJWWw1anp3MnhT?=
 =?utf-8?B?VWg5VTJBRjBDSXJtTjh1ZFczM0lqa3ZvMHduR2kvWU9hSVU1a2dhL0k5MFQz?=
 =?utf-8?Q?FYIw8be6brp6TJYuqU?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: bff93bbf-df8d-4ef6-8ebd-08dec6db3f39
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jun 2026 10:30:09.3137
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Vo2+KD9S65DXCaM1HmKJVAqjochhwe5FhjbXhx2+m7IiG20WTQ6XzPVsW75K83w23E4UtU7xwTS5Ou1AnQOoKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB12084
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
	TAGGED_FROM(0.00)[bounces-297607-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,DU2PR04MB8629.eurprd04.prod.outlook.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B28E36685C3

PiA+ICBzdGF0aWMgaW50IG5ldGNfcG9ydF9mZGJfYWRkKHN0cnVjdCBkc2Ffc3dpdGNoICpkcywg
aW50IHBvcnQsDQo+ID4gIAkJCSAgICAgY29uc3QgdW5zaWduZWQgY2hhciAqYWRkciwgdTE2IHZp
ZCwNCj4gPiAgCQkJICAgICBzdHJ1Y3QgZHNhX2RiIGRiKQ0KPiA+ICB7DQo+ID4gKwlzdHJ1Y3Qg
bmV0X2RldmljZSAqYnJfbmRldiA9IG5ldGNfY2xhc3NpZnlfZGIoZGIpOw0KPiA+ICAJc3RydWN0
IG5ldGNfcG9ydCAqbnAgPSBORVRDX1BPUlQoZHMsIHBvcnQpOw0KPiA+DQo+ID4gLQkvKiBDdXJy
ZW50bHksIG9ubHkgc3VwcG9ydCBzdGFuZGFsb25lIHBvcnQgbW9kZSwgc28gb25seQ0KPiA+IC0J
ICogTkVUQ19TVEFOREFMT05FX1BWSUQgKD0gMCkgaXMgc3VwcG9ydGVkIGhlcmUuDQo+ID4gLQkg
Ki8NCj4gPiAtCWlmICh2aWQgIT0gTkVUQ19TVEFOREFMT05FX1BWSUQpDQo+ID4gLQkJcmV0dXJu
IC1FT1BOT1RTVVBQOw0KPiA+ICsJaWYgKElTX0VSUihicl9uZGV2KSkNCj4gPiArCQlyZXR1cm4g
UFRSX0VSUihicl9uZGV2KTsNCj4gPiArDQo+ID4gKwlpZiAoIXZpZCkNCj4gPiArCQl2aWQgPSBu
ZXRjX3ZsYW5fdW5hd2FyZV9wdmlkKGJyX25kZXYgPyAmZGIuYnJpZGdlIDogTlVMTCk7DQo+IA0K
PiBbU2V2ZXJpdHk6IEhpZ2hdDQo+IFdpbGwgdGhpcyB1bmNvbmRpdGlvbmFsbHkgbWFwIFZJRCAw
IGVudHJpZXMgdG8gdGhlIGJyaWRnZSdzIGludGVybmFsDQo+IFZMQU4tdW5hd2FyZSBQVklELCBl
dmVuIGlmIHRoZSBicmlkZ2UgaGFzIFZMQU4gZmlsdGVyaW5nIGVuYWJsZWQ/DQo+IA0KPiBXaGVu
IGFuIEZEQiBlbnRyeSBpcyBhZGRlZCB3aXRob3V0IGEgc3BlY2lmaWMgVkxBTiAoVklEIDApIC0g
c3VjaCBhcyBsb2NhbA0KPiBwb3J0IE1BQyBhZGRyZXNzZXMgYXV0b21hdGljYWxseSBhZGRlZCBi
eSB0aGUgYnJpZGdlIGNvcmUgLSBpdCBhcHBlYXJzIHRoaXMNCj4gY29kZSB0cmFuc2xhdGVzIGl0
IHRvIHRoZSB1bmF3YXJlIFBWSUQgKGUuZy4sIDQwOTUpLiBIb3dldmVyLCBpZiB0aGUgYnJpZGdl
DQo+IGlzIFZMQU4tYXdhcmUsIHRoZSBwb3J0J3MgaW5ncmVzcyB0cmFmZmljIHVzZXMgdGhlIHVz
ZXItY29uZmlndXJlZCBQVklEIG9yDQo+IGV4cGxpY2l0bHkgdGFnZ2VkIFZMQU5zLCBub3QgdGhl
IHVuYXdhcmUgUFZJRC4NCj4gDQo+IFNpbmNlIHRoaXMgcGF0Y2ggYWxzbyByZW1vdmVzIHRoZSBo
b3N0IGZsb29kIHJ1bGUgd2hlbiBhIHBvcnQgam9pbnMgYSBicmlkZ2UsDQo+IHRyYWZmaWMgZGVz
dGluZWQgdG8gdGhlIGxvY2FsIG1hY2hpbmUgd291bGQgbWlzcyB0aGUgRkRCIGxvb2t1cCBhbmQg
YmUgdHJlYXRlZA0KPiBhcyB1bmtub3duIHVuaWNhc3QuIENvdWxkIHRoaXMgcmVzdWx0IGluIGxv
Y2FsIHRyYWZmaWMgYmVpbmcgbGVha2VkIHRvIG90aGVyDQo+IHBvcnRzIHZpYSBmbG9vZGluZywg
b3IgZHJvcHBlZCBlbnRpcmVseSBpZiB1bmtub3duIHVuaWNhc3QgZmxvb2RpbmcgaXMNCj4gZGlz
YWJsZWQ/DQoNCldlIGRvIG5vdCBzdXBwb3J0IGNvbmZpZ3VyaW5nIFZJRCAwIGZyb20gdXBwZXIg
bGF5ZXIsIHNlZToNCg0Kc3RhdGljIGludCBuZXRjX3BvcnRfdmxhbl9hZGQoc3RydWN0IGRzYV9z
d2l0Y2ggKmRzLCBpbnQgcG9ydCwNCgkJCSAgICAgIGNvbnN0IHN0cnVjdCBzd2l0Y2hkZXZfb2Jq
X3BvcnRfdmxhbiAqdmxhbiwNCgkJCSAgICAgIHN0cnVjdCBuZXRsaW5rX2V4dF9hY2sgKmV4dGFj
aykNCnsNCglbLi4uXQ0KCS8qIFRoZSA4MDIxcSBsYXllciBtYXkgYXR0ZW1wdCB0byBjaGFuZ2Ug
TkVUQ19TVEFOREFMT05FX1BWSUQNCgkgKiAoVklEIDApLCBzbyB3ZSBuZWVkIHRvIGlnbm9yZSBp
dC4NCgkgKi8NCglpZiAodmxhbi0+dmlkID09IE5FVENfU1RBTkRBTE9ORV9QVklEKQ0KCQlyZXR1
cm4gMDsNCglbLi4uXQ0KfQ0KDQpTbyBWSUQgMCBjYW5ub3QgYmUgdXNlZCBhcyBhIFBWSUQgb2Yg
YSBWTEFOLWF3YXJlIGJyaWRnZSBwb3J0Lg0KDQo+IA0KPiA+DQo+ID4gIAlyZXR1cm4gbmV0Y19w
b3J0X3NldF9mZGJfZW50cnkobnAsIGFkZHIsIHZpZCk7DQo+ID4gIH0NCj4gPiBAQCAtMTUyOSwx
MCArMTYwNiwxNCBAQCBzdGF0aWMgaW50IG5ldGNfcG9ydF9mZGJfZGVsKHN0cnVjdCBkc2Ffc3dp
dGNoDQo+ICpkcywgaW50IHBvcnQsDQo+ID4gIAkJCSAgICAgY29uc3QgdW5zaWduZWQgY2hhciAq
YWRkciwgdTE2IHZpZCwNCj4gPiAgCQkJICAgICBzdHJ1Y3QgZHNhX2RiIGRiKQ0KPiA+ICB7DQo+
ID4gKwlzdHJ1Y3QgbmV0X2RldmljZSAqYnJfbmRldiA9IG5ldGNfY2xhc3NpZnlfZGIoZGIpOw0K
PiA+ICAJc3RydWN0IG5ldGNfcG9ydCAqbnAgPSBORVRDX1BPUlQoZHMsIHBvcnQpOw0KPiA+DQo+
ID4gLQlpZiAodmlkICE9IE5FVENfU1RBTkRBTE9ORV9QVklEKQ0KPiA+IC0JCXJldHVybiAtRU9Q
Tk9UU1VQUDsNCj4gPiArCWlmIChJU19FUlIoYnJfbmRldikpDQo+ID4gKwkJcmV0dXJuIFBUUl9F
UlIoYnJfbmRldik7DQo+ID4gKw0KPiA+ICsJaWYgKCF2aWQpDQo+ID4gKwkJdmlkID0gbmV0Y192
bGFuX3VuYXdhcmVfcHZpZChicl9uZGV2ID8gJmRiLmJyaWRnZSA6IE5VTEwpOw0KPiANCj4gW1Nl
dmVyaXR5OiBIaWdoXQ0KPiBEb2VzIHRoZSBzYW1lIHVuY29uZGl0aW9uYWwgdHJhbnNsYXRpb24g
aGFwcGVuIGhlcmUgZHVyaW5nIEZEQiBlbnRyeQ0KPiBkZWxldGlvbiwNCj4gcG90ZW50aWFsbHkg
cHJldmVudGluZyBWSUQgMCBlbnRyaWVzIGZyb20gYmVpbmcgcmVtb3ZlZCBmcm9tIHRoZSBoYXJk
d2FyZSBpZg0KPiB0aGUgYnJpZGdlIGlzIFZMQU4tYXdhcmU/DQoNCkxpa2V3aXNlLg0KDQpUaGVz
ZSBhcmUgZmFsc2UgcG9zaXRpdmVzLg0KDQo=

