Return-Path: <netdev+bounces-267659-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IMQ2Ksa5tGl7sQAAu9opvQ
	(envelope-from <netdev+bounces-267659-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 02:28:38 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CBD328B3B4
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 02:28:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 595373019FCA
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 01:28:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16B502BD5A8;
	Sat, 14 Mar 2026 01:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ZxUnfZra"
X-Original-To: netdev@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011051.outbound.protection.outlook.com [40.107.130.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A35A7248F66;
	Sat, 14 Mar 2026 01:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773451710; cv=fail; b=rFMabNS47dc7gyctkBffKiZXaD+8b1SXja3zMqB3wktjYYS6sjgE39ZPqK4T7tAy8fAtE6kiQNdEB7fQXnNUzFUFwj9a/V9EhzQhZZGqSG7Z/kxpLzn2IB4BxvY7Op+wM3gg1W09ru3iNVFUvTZ2n5DNnrXM6+PlkGvMlqYwPaw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773451710; c=relaxed/simple;
	bh=c6YPbO5S4gYyhyarPh2QZwMWACXZqYdiI/h9Axw4nLQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=DKW13fRQ/XPYxt1Hm6LJrfHKaWSc1bBCIycqx+U9aOP2cfU6RIOSwLWQuLjUh/8N0vh054R7wOga/a2X21SRtw80TdxBuiDIX6VzOwo/IAmJp+b9UyfH/dnXDzJJIdnRezb0tQrOsD7h8G9NWTVau9fGAtUrJ6Qq60SuLZVtKqo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ZxUnfZra; arc=fail smtp.client-ip=40.107.130.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=raMa4m2pAXtzjtgh0nLx+YmFWwAKEcf4k7JqwGIXHLr5juGDAAfdR/w6TThy4rA1K4MIWOgJ5BHY6pwT7ff+OJVzGNsNgETLn7ROg89P55Bn2iwh8wqUEbJKOeHupEd5qWCNABlH1M13al6OgNHdpIQmpcnZG/PMEHzR5V9jXG0oBlKg3KyfmhGrGF5Biry5RHjsPj5XHWdIE7QSGwHKVCNgBCwM2ygHLr0TNvd1MFFbGMXW/PgeAsipWdpuojsn5IW+sO5zNpOR/VwVvbj4dy2992H1mXim3K6X0ywjYgUpU52KtWggIAuAkU5yJHVgajT3k/jXx+5gFwrrBre2aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c6YPbO5S4gYyhyarPh2QZwMWACXZqYdiI/h9Axw4nLQ=;
 b=VNXjRgKkDPLWJIyFikH1PEOs/XdQXl4I1F+p+zG7M5XQjLwe1kPZagfGScItiT2/N5HJPPjqQyzq3nvXkb/ttPwJyA7hTi/AxULYK3F8ubBFFBtalPTB2quxOJDo7XeJfi8xD7cSxpUqpLLgQjsP77Ea8Oj4KO/jYEvytACqAimu7XE/IZ5wNJQCYC0FARqu8b0HyiyCVNKCesB37CzA6LsoMIiYfas4+nDHEMC+2p2r5gEF3d7c97b9LYDtgt6gfBvoRK2lfYJfRgMPWtudm4ycg9O7wxf0FlhB5qCy6niLiZHL7reQ1pEyDRVCvIWHVDq/bWhCd8mOZBWjJepxjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c6YPbO5S4gYyhyarPh2QZwMWACXZqYdiI/h9Axw4nLQ=;
 b=ZxUnfZraXs5Veh5Cogcnpq6wifeIdov/1r/N7Zk8uesalfhnrow+ITaK4QYW27nXdBbZjJ5QrhYk2fRCzHgofBAC4Twq/VBRACCouHHaijSE82H5zYSQ7irBhVB+7lgx0gTVhhXKEB59VUuuHecoHrxV1L4spY0+0XzcjOSymQczt34Qiitf1VuHTqBIVjfGREZc6O9ef5r8NgI78PpOjjfzOEuKgttsGGD8m9kjTpacHLqyA5LEUQ92ANrMJfIJIvxn8f9C0ZNLcHqZ57jbC6QbVVPyYyFD5nahvAr5Dc78BqmZP4MVq9MLcYDFA6lLc3+yb46i1NDDprZ/mDq8IQ==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by GV2PR04MB11093.eurprd04.prod.outlook.com (2603:10a6:150:278::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.18; Sat, 14 Mar
 2026 01:28:07 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::b476:c19a:24cd:3694]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::b476:c19a:24cd:3694%3]) with mapi id 15.20.9700.013; Sat, 14 Mar 2026
 01:28:22 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Vladimir Oltean <vladimir.oltean@nxp.com>, Joe Damato <joe@dama.to>
CC: Claudiu Manoil <claudiu.manoil@nxp.com>, Clark Wang
	<xiaoning.wang@nxp.com>, "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>
Subject: RE: [PATCH net-next] net: enetc: remove stray semicolon
Thread-Topic: [PATCH net-next] net: enetc: remove stray semicolon
Thread-Index: AQHcst9ywAzOlLQTjkS3WrmAXGqJQrWtJ/wAgAAECYCAABDvoA==
Date: Sat, 14 Mar 2026 01:28:22 +0000
Message-ID:
 <PAXPR04MB8510D3E374C64119CA2A584C8842A@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20260313112454.427191-1-wei.fang@nxp.com>
 <abSnSjp7cIj/qWGG@devvm20253.cco0.facebook.com>
 <20260314002413.i36jrsuih6j2lmtc@skbuf>
In-Reply-To: <20260314002413.i36jrsuih6j2lmtc@skbuf>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|GV2PR04MB11093:EE_
x-ms-office365-filtering-correlation-id: 7c22eb5a-a4ec-49f2-3dca-08de8168fb36
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|19092799006|366016|38070700021|56012099003|18002099003|22082099003;
x-microsoft-antispam-message-info:
 zWLxUuSYkRJk9ip6qrzrE9elA99KK0vH+sFncIbrYX6s4UEZqzjHQOEnuyvWo3s/n7HY832BIIppo9onSlyBiCBL3/FUnddVQ5vUh6c7ZFlZ2RkyZ7Fvxil9VOHBzc0z2xviOcu3LbnE00lZ4wo1p0bMp+IOCanHMizOPuFOHupGSG9nA+Rna17U+LtGhh6RjbnL1UP2WDoUkg0oOSN4eeLkOUqWWsSmlxKabSaxuW6DnDmWh1pZWbHjafC7YHhpuk5R1XU3fIX7r8U6BuAxSPxdrP9qvtmBn/DIQyso4sEQNvFSRBARzs21t1YpnUwUF6v+5dSIyCYhDfqNtUmdCiQEJZullkrKxO8rHhHQtY+UZyiJxVLDir5ehyg2JjL8gpvQD6TaU0BKGxTRi7ljaSLXp+G7yhpgLIXEt6WJTB90XSUhGrpqS5rYwfsXygrDBHNm1Ezcjivz4AJRVt4Vic4Qfdw4esbbysS9sadVnpKIumeWOEXFey2UOfu+Jnk2sBO8d6iCWG/zF5+yoPdLei6ls5IdZ3HUvRrNWzhw+YPkbX+/6d3V2B/aX4IXfTDH/dmJCHmnzSBtuSZFPqDSmWP0dQRuYipHHDLvspQQsxV+gqitlARTbEwu7GQqN4LiyUJ53cblzByuUJmPLgcy2bZskg1y/8FRLL2wdIp4I07qvt3H7VtlBT8O6Zr7+FuzcslEyIGBfEu76Pn+ATQIxtUTaehGpAqqo/Nt9NC2gj3Qtr3EJ9yJfO8exjOmYobZuIRl15uWaTRdThnIr2hh40VkpIyqSWDj+cFjadfo2/0=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(19092799006)(366016)(38070700021)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?uLpmk7aM8UrV0NskBOCflya6zHBi2tYeWyEO2SKsInLN6Kf57sdbVXqhMBI2?=
 =?us-ascii?Q?s/6tFjPE4veMfTa6QWL932A4xzvjDtpz1EpKxk6TvbPzeXakvqI0dcPMIVje?=
 =?us-ascii?Q?YFZGnrxqqEJ0g/w+BphgRFnCNNkDWAZUHKBAIWuO9w2bG9JSpO5Z8eGwoBfm?=
 =?us-ascii?Q?wXDVJ1uFe/k9cRi/OuS5OWcvFOfmYSd0xhGSkBFbO2CHpdc5kIfbJXZwWU7N?=
 =?us-ascii?Q?1+F8UVNYuDxQ4Sxti0nknnV2PmRqJHVuW7QCHw5ElSqTaFAfYGhg0ZGSgaZn?=
 =?us-ascii?Q?xD9617W/se/931bvm+kBxGnBeplnyw6cZUNa4BjBqfnXDPjVh/7Ke4umWDA5?=
 =?us-ascii?Q?tAfHn0gWTuQKoPXBTRFnjUwtr5rKwV6d/8MxpYfU7hRXtkd8/mb+lPk2FMHS?=
 =?us-ascii?Q?su+k2LqDcR4/4Y96UU+8oyxpjx2MXEmRqJGzwoWUUH/DKlMhqY2ujEy3FJ3n?=
 =?us-ascii?Q?moqXcQJIHFfXMxjrh7he36KfvYlKIKQ2Om7mp1TksnijizESPvMqtj606qwV?=
 =?us-ascii?Q?h/dggtvxWivbDqg+Vlq1pcoIJEaJdWORxb97KrtNy0SXrjqCtyZ2Wr8KYdqv?=
 =?us-ascii?Q?xBo//UwIH1lMlITGpuOELDay44/mxIbpUl6rW+Id1dByjWQec3I0qf5WIG44?=
 =?us-ascii?Q?qQgma16NLdwYxtz9O3tFlcsZc3WgTJSuq+aMQE3oV3we7zR4qZEnCbjAR0Lp?=
 =?us-ascii?Q?3WMJz7vcxSTACeviRvFgMaa5Xa48mFnFRn9HgAu0G+l3cK0S6p2oVAQ/22sE?=
 =?us-ascii?Q?YHRifyCco6F2IibW9G1W3Bu2nnsr1DsatK9lX6NFd4L/AZOzs2Mg/Xcf//+E?=
 =?us-ascii?Q?Mp1r3B7K3Qri4QY8wLjtgWyEPQL6sRvgMSbmnsGFenUs5UaOgMFfvJevb9XL?=
 =?us-ascii?Q?LB8KYFUcGfEht5kttV9wQfkmXD7X0dQq8kt2IapJ/PaJuhX0VQjFhrBU66Rv?=
 =?us-ascii?Q?+jz68Np66QcxvNGe61TbG9ZaUajZkBe2Fj5wgjtWelrV/wryXS0VzZYkDH/3?=
 =?us-ascii?Q?icxic4dqRTqu7596hkHgJPbpQXVE4nReLnbK1aVJsGLClLMLUnE/u42Wsgqa?=
 =?us-ascii?Q?nGoXlIKil+T+oo3vUD8klCSdSDTDS3AfUMHT3qPbJGDRQJ7mO8pYQ/eFJIpd?=
 =?us-ascii?Q?Abmhs4cseIpNDpyeflbH2+NInys51q+b8mliI7H08vM6J+8eKBjYt1VPf4q1?=
 =?us-ascii?Q?2uSnc1BfF9m05nAcFQkxKi/JO1f48CU0SJOa/6AweJEi8yrdeNf4y7pmK3Hl?=
 =?us-ascii?Q?oaN+raJGkSP+hDxt2eXzihk6D6rQid4nfzprJbJEYGiaGjWqQ18JTL7yGsGn?=
 =?us-ascii?Q?Tz2gZIaOIVWeGBhSuSCdoywbRlA8l5v7jiaq32UtUQjs3gzGGP1Wx7hmpTAW?=
 =?us-ascii?Q?R6YF9kI+Wp67E5wBvKXFCR+TRWWQLv0UJFyUb2+qRCWpYQ+Gzs4uY15NGYLO?=
 =?us-ascii?Q?XUsuCli+YIrwO5skw+as/wgzDpFbMZa5cPgfuOiSw+ZKR18n6biWd/dWCK5u?=
 =?us-ascii?Q?w+rjyMbYLNAua0sqAeI2O/rIC+7FXUZXOsOp5HeRHk78nrac35v3TmvMjQfx?=
 =?us-ascii?Q?hCrkG7rsynzR/CVWhNC9bNK3Y+/kSMSRIDBigDwa44bYLXFpioEnhyOACIhQ?=
 =?us-ascii?Q?PFFyH11UcX5dDxKdYVxwTlMlc2UZBXtcaNn6H8HHfpzCrdGLhfY6Xg2qr83h?=
 =?us-ascii?Q?O0h672hVSgJnb4FRdmzI/EYNrvRlmYCOAZFKeD2c/JUqONHd?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c22eb5a-a4ec-49f2-3dca-08de8168fb36
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Mar 2026 01:28:22.3820
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uYw5/yc/w/SIGNbO8XwodeQE/JZ5/spRfqnouaW80E0W2t1iK2Gu+4KI3OpkQJFoBCyJgXQsmFoMuAdY0cUoGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR04MB11093
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-267659-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[nxp.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wei.fang@nxp.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9CBD328B3B4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> > Hm, I'm not sure, but I suspect this might be rejected due to the note =
about
> > cleanup in the docs, which generally seems to discourage this sort of t=
hing:
> >
> >
> https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#clean
> -up-patches
>=20
> "simple clean-ups, which are not in the context of other work"
>=20
> The ENETC NTMP code is under active development, and Wei is developing it=
.
> The semicolon was added in May last year and was found as part of other
> review touching that area.

Yes, this cleanup is for the upcoming NETC switch patches, which has some
changes to ntmp_table_name().


