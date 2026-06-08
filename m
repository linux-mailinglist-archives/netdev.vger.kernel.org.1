Return-Path: <netdev+bounces-296396-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id GDQcEqVyJmqcWgIAu9opvQ
	(envelope-from <netdev+bounces-296396-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 09:43:33 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id AD8BD653A7D
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 09:43:32 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=est.tech header.s=selector1 header.b="hXWHG/ya";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296396-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-296396-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7D3E13027D8A
	for <lists+netdev@lfdr.de>; Mon,  8 Jun 2026 07:38:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55157399357;
	Mon,  8 Jun 2026 07:38:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013058.outbound.protection.outlook.com [52.101.83.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EEC53988E1;
	Mon,  8 Jun 2026 07:38:14 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780904296; cv=fail; b=Zkfqs2P39Rl/VT/sQKyrV36Pb1bSqbiu6jIPKvBw1zkK5IXIjSMab8MNcHV8T1NOn27lcAF1hU3bZNaSjtn9h+unc2guFl1Ew8qkk6d1+jA/aPbKIvYkJrdDeItdOCw50Nh7ckkfK3mGVlkZGOPE8jCIW5vVx8wS2oLftvmJjpI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780904296; c=relaxed/simple;
	bh=QMyouCDbyxkND1J2eimETGesWgf6fo0NU1zC54JexIM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=shWHHRXw5ebn0UE5hJ72vzr2T0H47Y9rPi1zYXGpqfsCMsDJT3yf4MAGLel6V6UaMsxX5hDLoSY4EWBDpuPJ9SlycIWTb08Wv/j6ta3eN4AExuoVLHMKZFX7/YavWyoq9S79W3Dr5LqRB0fGz5Co4Ldn9cAuwvnCJZrUFfvHMKQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech; spf=pass smtp.mailfrom=est.tech; dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b=hXWHG/ya; arc=fail smtp.client-ip=52.101.83.58
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GT+MHtZlFd3TECOIwobtVxCEe1iptO5EWHG/pdXAUh4OEOSYAB9AAB8DtCCMGLufAKna7ONA7yW6AS+HmzWIz2ZEMcNdkLBgacSQkmGiQThI+/8IpxydEW/Y+7dEbHRjyflMIdIAdlmuEuZQ/W28d41hA/LbOaAHwh7N+EEAgLktSw8NFC+P9CKuv1Ex8GLh0luAHYlh3qjkpn0gP/vlpdHV+EhSOalKu1MowqTz60AV0BJO2Fk7L6L0dORyfyEjN+PD9BO5KYeIV62jR+7mmvugo9tqT4iTy5MTwg4dcc2arFAdGoyObeMwjQMTDw0RC8K4s6jiFradKbXyCaFi/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gFrAtWGvHLsgSX9xeSnY8mwUW2tnKj3w1E4UUVLL6yI=;
 b=YqWCCgRi4dyjJaw4VqNoXfcTOP/TriUXHSeAmH5UhKe/5HaqYxVuETQbF4AoIAvI7uucrCxNwopKQZo/S+AKrNEi2vWnQYs+wavKHJYwqtkmDM8sATnGo5VWOdI0KLkTf9YD01tjU2LGuBj3jykizTzaZBsOvV033xyWFOoD9T3Kk4YOp/myF4VL8S5Ul1lazBlddwFPjDHnon3K+XvV1jm1+YPoc3OjM7jfoKqAaG2DKzoLZPtl92f/lQ+KH5daaVvKn3yFCFQAVyjnpa5887w/W4XX4Ny4iEZUvHRDBgVgXWYR5C1us1B3r4Mi98jmr9aDjUxhiimyGPKoWnur+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=est.tech; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gFrAtWGvHLsgSX9xeSnY8mwUW2tnKj3w1E4UUVLL6yI=;
 b=hXWHG/yapBe4tb9SDp+SZeIpXTelFgtXxV2ZifaJ6buhUOiuasCwouEWIwjXc7iEHkAtMOH6nknDQ7iw4uoDDHNfU/qEUBJjALg2kNtfE8GNR0gPcYkvu5hdw/we2JR33HwXHfD7dgG5S0j6AzyXrn8kPErdG6q74GsG4B79J7kBwtJB0K6ekKjMny74VW9rNQ9rCwe0cMDjYbEZf3Zoyz67KuuLYrTN4kk+Sml0TD78+vnbslYUkNRf6zGsJY3G6GpDcC6qjgwn8qm1QEutrmHCwN107u4n3fSWygXB+nCJmhQk4+yREQxyISdOXHlli9znJJWpWvvUoaue35SK3A==
Received: from GV1P189MB1988.EURP189.PROD.OUTLOOK.COM (2603:10a6:150:63::5) by
 AM8P189MB1202.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:243::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.13; Mon, 8 Jun 2026 07:38:10 +0000
Received: from GV1P189MB1988.EURP189.PROD.OUTLOOK.COM
 ([fe80::bfff:5391:8a49:21b7]) by GV1P189MB1988.EURP189.PROD.OUTLOOK.COM
 ([fe80::bfff:5391:8a49:21b7%6]) with mapi id 15.21.0092.011; Mon, 8 Jun 2026
 07:38:10 +0000
From: Tung Quang Nguyen <tung.quang.nguyen@est.tech>
To: Michael Bommarito <michael.bommarito@gmail.com>
CC: Simon Horman <horms@kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "tipc-discussion@lists.sourceforge.net"
	<tipc-discussion@lists.sourceforge.net>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Jon Maloy <jmaloy@redhat.com>, "David S .
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: RE: [PATCH net v2 4/4] tipc: reject inverted service ranges from peer
 bindings
Thread-Topic: [PATCH net v2 4/4] tipc: reject inverted service ranges from
 peer bindings
Thread-Index: AQHc9ektliqNaVX/nUavQCSszSR/g7Y0RsQw
Date: Mon, 8 Jun 2026 07:38:10 +0000
Message-ID:
 <GV1P189MB1988518425346AF7A37EE282C61C2@GV1P189MB1988.EURP189.PROD.OUTLOOK.COM>
References: <cover.1780766454.git.michael.bommarito@gmail.com>
 <6691aa72214b0741477b479ffe5eb2b272664da3.1780766454.git.michael.bommarito@gmail.com>
In-Reply-To:
 <6691aa72214b0741477b479ffe5eb2b272664da3.1780766454.git.michael.bommarito@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV1P189MB1988:EE_|AM8P189MB1202:EE_
x-ms-office365-filtering-correlation-id: 55c5097d-c7d1-45f3-232d-08dec530e3cc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|7416014|376014|366016|38070700021|22082099003|18002099003|56012099006|11063799006|4143699003;
x-microsoft-antispam-message-info:
 XRuMknDpLDutxF1ixtvEKYezC+c2xz8HlWN/RoC51yCYXSg1PDnFNM5v1PlqBZIdLZejnBsn2P2cBLmrei5u27Z4eybRlwKyEuWGZIfaha8sKk8vsMUjxQNzwsfubndAu9A5tXh3LQiJUUqg7JK4Qdchy+xISwK3KLKZZIi5sXHt40DmNnACx7HK6Viq6a+3MKnf62e9PtqxtwOB3r1oSZWeO3aUTsrBSlEZHTDICpL5SXyrk5dz7DK9j4gO28DYMFfqvvA6y7byGoOWr6ioSBRRs19Wg/W5pnKyt0Sz6mn2C0QD2cuau4Mx4l9EJZ+vKSGyWAnW7hbv4lCmj/YNTU+AKVub/KjkOW+ALg3gPskts7YwyXZFmEmGHsxCZRIint4Ovros3vKxAr6SKY6KVCd8EFTGA3JmBGQb3d+9PetJq71n3JXnTfr+IJoOklg0UxcB1lIgsf25jTcDqmLDMF3SqsE8K71CEtWBpxzgWoStvcWIwP5klQaendEVgEx5CesKBTy5Owvl8EeXcCz9Gh5L9GWI6g308Jxw6X5t02K74OnzOag+P5f4VCa+GOoi85PsLctGGU1G9/hkE+m7+BrQIF27MyOjBhb1MwoeZdSvbyA5KZoIboRfsb4yQtqqlVSzwiBqmiXF1a3UoaK++rb1gwVhy5UKYVCE/XMhv/PrYTZwrpIfZpfzvYmET3GgF9S45WyL5mrrzQ4WKvewjnMjDIx1sDMPpEfpoEUginKWA2XXtsVp/W9ayBEu5PNk
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1P189MB1988.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700021)(22082099003)(18002099003)(56012099006)(11063799006)(4143699003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?QwqMc37lb1fa17Kj3sPWct1NiDNv49lhL5smEhmsuc3hkF06BzkKYA4jlJ7D?=
 =?us-ascii?Q?wgeYhQ9IA0z+nBCGQoMTOD2J+hxlgpncdTr8r7ttjxZUpW/dgHCNKmvDhw6X?=
 =?us-ascii?Q?t4euoIC8CXUBl+J12juFiO9i4JomspTGsqqZbVctWhGc50IJK9dKSpTP8gXa?=
 =?us-ascii?Q?ee6MyTF78Vi8kY+qAj5UkwFzLNGw7wEEape4YEXL/+i6d+pcXcC97hVrZGNX?=
 =?us-ascii?Q?mFjdICjhgtlupXjpLImjOuDscOavkoGFVLUU8mC1q9Ox4sc3CnhWSM8dApwj?=
 =?us-ascii?Q?MYWGKGEM33M8zlfJhUn7u9sji369BcizLo98lI9cF31QhLOPBaODjy401gji?=
 =?us-ascii?Q?9H7KwVNA3BsAs8i9rZDd3nRrhHTQ3uwo8O9UaOcRaU8NWe5z+zkcrK4LwETy?=
 =?us-ascii?Q?ELUrRPr2Fkjm0zGE/jgBZBb+MutXG11PZ/M0wE8Y/x5vBZdNsEKvCOvdmzpM?=
 =?us-ascii?Q?AykH2rv7hX2yklDP9S8EFfoBKKLKO+TrvgtPrn6gOwHCxRSNm+ReOFRA9mBY?=
 =?us-ascii?Q?iwQxAMxhTTaYloDecMH1pNM6ab6afmkUFC//hbycJsywGTz1c+EmHO6mVK9V?=
 =?us-ascii?Q?Y5J9Mf9nbbQgdmNiFJamlqm3uPAVbkhdp0TU3hl4/jnM3X5oww5IPfQ7N/9R?=
 =?us-ascii?Q?nSZumh1LRUCUsYy8TfN2rZstXXJ+W86B/Rby09mTO2TeMZabuRVhWgz3Qjpn?=
 =?us-ascii?Q?o9ECqXw7sYVTZqCiAFc8OZJvrMu+utkQVlJHxyFnVl1+qWjTO3yiCnSpNCuJ?=
 =?us-ascii?Q?QCPI3Al2ijNcma1k2wi5udON2GHMwa5ElEmhe+BcjquK6l+Y18TsHkqRFZqw?=
 =?us-ascii?Q?TwZzID6PMa3TH4J1jbDoLhejsDBpSoyvNWXKDzPHv/0ACQIqujmleL2QTD6S?=
 =?us-ascii?Q?OoRAXw917WzuaHAyxrVR/3XyiPSiKQ6lfkPvoRIVU72mYveAE+S6zk+uGacQ?=
 =?us-ascii?Q?KYlUvkNnU6HGqmS659iNxaWvQnZjaA3E3xlwOdaoNeJDUXmU2m6BhbtPV11B?=
 =?us-ascii?Q?FOs6AQkQG+zKdczhLPyWjj0GTTAg7nISZJoZKIEN6jW/jYY4yy4swQd/3Xz+?=
 =?us-ascii?Q?iQyeho/HhNL+jHFdCN6gt8BWLXivFtvAi2T65RGZtYAMbVelrFhPYJf6G/EI?=
 =?us-ascii?Q?zSYNd6WaOixXHSbnm7oKNIGlaRkpR0WSItIGGBadBUtSc5S8FxJm4ZIi9i/E?=
 =?us-ascii?Q?oFAKcN+aGOv51pvLAVSiTcnf4I0Lgv+yenZR/aLs1myjhLxZKKpRux65h6Rc?=
 =?us-ascii?Q?t9VpyPoZ50cczBNqpilYReIAsMWDR3LOqCoe43wOA/zx7S7CGLEyxNlPjwnZ?=
 =?us-ascii?Q?g0h/fPYJUKNf/ZrSFLmbMZVZot9nRLNsyMXVkebhCuCVyQ6NX72HNqkI3yWj?=
 =?us-ascii?Q?GL3weRtOPesJkZ3qvC94ZpGNCaroNSAZ1K0aRMVr1slLu1W2TID1N5hs8gIa?=
 =?us-ascii?Q?uNCcKdBg7dpinTZiT/vNvGzKgmPUsNpPLcLXCCVSkjiw00M4c5rhFWU/tzAx?=
 =?us-ascii?Q?LubrB/xdADiK9ejQxRjxRHmQqeX1OdvlZXfNn/xn8lUS0f6WyBthjOKe2AtY?=
 =?us-ascii?Q?LiSyfhWR6PotmyN3beX5A0oLD/Ric4BlyH45MlQUznpwJvnkeciJZeVAqIl6?=
 =?us-ascii?Q?CkrwMqqlLnLBNDrnVQMycbL5m/hURPozvFniEnx1tBMMEJU6SprPnOGys7il?=
 =?us-ascii?Q?W2LZBHFO2qbF0q1cpFYuEvIC0Z0duaVhP1jn6oE8Hp2RMokHDVid5Jar9mPc?=
 =?us-ascii?Q?/jOG9xhflQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: est.tech
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GV1P189MB1988.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 55c5097d-c7d1-45f3-232d-08dec530e3cc
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jun 2026 07:38:10.3988
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eIw29ohcyIgd5vqeWIlo7+s4sWBCplNTxbEDghQnKI7HVnYkf+FTxVCqkctrpZWj3NuIRMe+jY7ZNYHG/EzQRIBaff2dd8UDUYxlPoYDwgY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8P189MB1202
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_DKIM_ALLOW(-0.20)[est.tech:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-296396-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:michael.bommarito@gmail.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:tipc-discussion@lists.sourceforge.net,m:linux-kernel@vger.kernel.org,m:jmaloy@redhat.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:michaelbommarito@gmail.com,s:lists@lfdr.de];
	DMARC_NA(0.00)[est.tech];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[tung.quang.nguyen@est.tech,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tung.quang.nguyen@est.tech,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[est.tech:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_SENDER_MAILLIST(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: AD8BD653A7D

>Subject: [PATCH net v2 4/4] tipc: reject inverted service ranges from peer
>bindings
>
>tipc_update_nametbl() inserts a binding advertised by a peer node using th=
e
>lower and upper service-range bounds taken directly from the wire, without
>checking that lower <=3D upper. The local bind path validates the ordering
>(tipc_uaddr_valid()), but the name-distribution path does not.
>
>A binding with lower > upper is inserted at the far end of the service-ran=
ge
>rbtree (keyed on lower) where no lookup or withdrawal can ever match it
>(service_range_foreach_match() requires sr->lower <=3D end).
>The publication, its service_range node and the augmented rbtree entry are
>then leaked for the lifetime of the namespace, and there is no per-peer ca=
p
>equivalent to TIPC_MAX_PUBL on locally created bindings.
>
>Reject inverted ranges in the network path as well. A peer node can otherw=
ise
>leak unbounded binding-table memory by sending PUBLICATION items with
>lower > upper.
>
>Fixes: 37922ea4a310 ("tipc: permit overlapping service ranges in name tabl=
e")
>Assisted-by: Claude:claude-opus-4-7
>Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
>---
>v2:
>- Reorder the new u32 declarations in reverse-Xmas-tree order.
>
> net/tipc/name_distr.c | 11 ++++++++++-
> 1 file changed, 10 insertions(+), 1 deletion(-)
>
>diff --git a/net/tipc/name_distr.c b/net/tipc/name_distr.c index
>190b49c5cbc3e..da8a5eb6e63f1 100644
>--- a/net/tipc/name_distr.c
>+++ b/net/tipc/name_distr.c
>@@ -282,10 +282,19 @@ static bool tipc_update_nametbl(struct net *net,
>struct distr_item *i,
> 	struct publication *p =3D NULL;
> 	struct tipc_socket_addr sk;
> 	struct tipc_uaddr ua;
>+	u32 lower =3D ntohl(i->lower);
>+	u32 upper =3D ntohl(i->upper);

I meant to say we need to restructure the whole block of current declaratio=
ns like this:

diff --git a/net/tipc/name_distr.c b/net/tipc/name_distr.c
index 190b49c5cbc3..c3fd7196b00c 100644
--- a/net/tipc/name_distr.c
+++ b/net/tipc/name_distr.c
@@ -280,9 +280,11 @@ static bool tipc_update_nametbl(struct net *net, struc=
t distr_item *i,
                                u32 node, u32 dtype)
 {
        struct publication *p =3D NULL;
+       u32 lower =3D ntohl(i->lower);
+       u32 upper =3D ntohl(i->upper);
        struct tipc_socket_addr sk;
-       struct tipc_uaddr ua;
        u32 key =3D ntohl(i->key);
+       struct tipc_uaddr ua;

> 	u32 key =3D ntohl(i->key);
>
>+	/* A peer-advertised binding with lower > upper can never be
>matched
>+	 * or withdrawn and would leak the publication; the local bind path
>+	 * rejects such ranges, so reject ranges learned from the network too.
>+	 */
>+	if (lower > upper)
>+		return false;
>+
> 	tipc_uaddr(&ua, TIPC_SERVICE_RANGE, TIPC_CLUSTER_SCOPE,
>-		   ntohl(i->type), ntohl(i->lower), ntohl(i->upper));
>+		   ntohl(i->type), lower, upper);
> 	sk.ref =3D ntohl(i->port);
> 	sk.node =3D node;
>
>--
>2.53.0


