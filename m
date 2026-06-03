Return-Path: <netdev+bounces-294537-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id vVhNLWmgH2rqoAAAu9opvQ
	(envelope-from <netdev+bounces-294537-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 05:32:57 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5436A633F5D
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 05:32:57 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=est.tech header.s=selector1 header.b=z6ceAtX5;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294537-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-294537-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2FC7E304D4B0
	for <lists+netdev@lfdr.de>; Wed,  3 Jun 2026 03:30:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 240043F39CB;
	Wed,  3 Jun 2026 03:30:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013064.outbound.protection.outlook.com [40.107.159.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5376D3F410B;
	Wed,  3 Jun 2026 03:30:09 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780457411; cv=fail; b=Z7wGYDQDou9nhUdq1OVSjm3+jRUuoPSqQ3281qto1gc+Nsi7sJzo4zbtRMEKKvH3rhC0zGBa+4X20MygOAo/iT6K2REQuaPDkJcAPV0h9cQdTD88jnjsFFCJau8l8jb5xaKy7S3qcLLktqBcY84nOhIkBum0dR3t9fI6UHDkbPQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780457411; c=relaxed/simple;
	bh=HwguqAdDeXobzwp4o4R4/cp8IZGaJ9cBEjSuoUi1I88=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=TV5Mub8B5Etq3IfP9B3cseUjT7LxGgaxhARoHnDXBSUzISo9xWO7vq4NAbtFepNKT1eNRMAEbLZDZ0wNuAilhdPI1a/ydTnh7rQPuRhitzzG66hE4+cBKcKMmQ7e0Qdv+8NrFfU/AaW3hpaDpDrCLqo7NbEshoOXcN8W61CybM8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech; spf=pass smtp.mailfrom=est.tech; dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b=z6ceAtX5; arc=fail smtp.client-ip=40.107.159.64
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aMiY0xxXEMuG/oCVy3G4ytHL8zlYAhMSmagUBuOy0C/Q0Jq1nWR8XBx1xvMQjyKcclqoeP+x2Id3I4C2eCh5SaNh5qPABDJeun3zBZLfuJ3ZNRBZM+XwoTbKWA/StomxHmbtfxxJBp6s2v/spZy1f1ydPlTp3HZzjNxOr69unnT+WUSXXmLcoQzRIKfYVzteSSmQak4oVw9nzq6Db4d3st5lDcjgeU+GP7BBAiOOjT1NPCKMbrQ1xbCOE6Pdr7Z/2XeuN/paSoHdqqOyEH4Vk5+/Km8qyAdIabh4BNkM4GZrFZpWRVl3ySvhjG7JIV7PemtLoDkmx1LOjXjQ5dBjyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8UCQ8NM+Hbj0O8ehLC0zsCyRG/89z54R6NhJy2TMEjc=;
 b=BOcl7AmUKvx/TCl5QeWjioIIOhzD01Ydi2z8CsGJctsGkNXwS4BA3pI9q5Kz6ee89d+TlgvJTS7XG3bltdJbL0ch2KDuIySTCR8PWV8YUsQGiMJQGDFq16eF94iHe1vALqWdUDMeTJKVhaqT3QkdSzTAOre5o8i+/iNMkSDLiqo82LyAkgU1gYB9FK+s5mUCx9IZo7vMQDkIgE1p9zaEaCPd+0Ibvpdfw4ZZ7wO1RoClEV/dmRa/cOH0IDZYtTA3QwnB7xz0XZW68SsdI6506+ee0AoznzrhPraa4yd8amFjTF4TcjMuobSuFjuaXx6e6+EeRr1PGPs1O/ZfebSGuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=est.tech; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8UCQ8NM+Hbj0O8ehLC0zsCyRG/89z54R6NhJy2TMEjc=;
 b=z6ceAtX5Temhj2yTAxF0kIJXotMAfnrpLKsd26zEPM3zhhEbjfs++P83EeFPilXsI+dHWGI1S2c1TJoHhFzeoIwlKzY4/B9/pp1uy+bl2PGXVI2PykBCBZsVlOys0hirl8lRFiWpos3I1fDAUTGBihsVGlUBBkdP2bWRVfFX4Q5/KV3IXbSXljkUDqqnxNTDBDYNdQWpQM6ZYLj74hOhtCMbWJNx4n+lau46Ep8t+WgY9rWUIk1i0KgA98ymPa6nbzoOLdG+GMKeZE2/ioDjbNbKxNNSvbKBCYikVA3H2xZHf5ciAHgn+u1Y/9wZ1aymEcir+qaF8zdgmJ8ecwPOpQ==
Received: from GV1P189MB1988.EURP189.PROD.OUTLOOK.COM (2603:10a6:150:63::5) by
 PA1P189MB3626.EURP189.PROD.OUTLOOK.COM (2603:10a6:102:4fe::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.7; Wed, 3 Jun 2026 03:30:05 +0000
Received: from GV1P189MB1988.EURP189.PROD.OUTLOOK.COM
 ([fe80::bfff:5391:8a49:21b7]) by GV1P189MB1988.EURP189.PROD.OUTLOOK.COM
 ([fe80::bfff:5391:8a49:21b7%6]) with mapi id 15.21.0092.006; Wed, 3 Jun 2026
 03:30:05 +0000
From: Tung Quang Nguyen <tung.quang.nguyen@est.tech>
To: Michael Bommarito <michael.bommarito@gmail.com>
CC: Simon Horman <horms@kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "tipc-discussion@lists.sourceforge.net"
	<tipc-discussion@lists.sourceforge.net>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Jon Maloy <jmaloy@redhat.com>, "David S .
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: RE: [PATCH net 4/4] tipc: reject inverted service ranges from peer
 bindings
Thread-Topic: [PATCH net 4/4] tipc: reject inverted service ranges from peer
 bindings
Thread-Index: AQHc8pd94lTwvoP1vku5ggPXrfYR5bYsLAKg
Date: Wed, 3 Jun 2026 03:30:04 +0000
Message-ID:
 <GV1P189MB198844129A1F511A3455B7B2C6132@GV1P189MB1988.EURP189.PROD.OUTLOOK.COM>
References: <20260602133555.769727-1-michael.bommarito@gmail.com>
 <20260602133555.769727-5-michael.bommarito@gmail.com>
In-Reply-To: <20260602133555.769727-5-michael.bommarito@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV1P189MB1988:EE_|PA1P189MB3626:EE_
x-ms-office365-filtering-correlation-id: 754e89ea-3b55-4d30-fa82-08dec1206759
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014|4143699003|18002099003|22082099003|56012099006|11063799006|38070700021;
x-microsoft-antispam-message-info:
 fN3nBcRm42ra+eWf8zltNmXaV+XKwcu4Sy/Tk6QdQlCabluRyktslXgbbtcdpi0u/d5IrME+eI8YEAeMHOV0GSVBDucX7q4LLstkl2QBgkt7JBV1HoiUMm2vkfq29QBoOhvRIZiRDFxTTccK5N1F/AnzF9ygF9WfxG6ouLUXl/QDDVKIdUWsevnpivd6gKmmKo6xUVsdfXjRxp0FrDGtYZ91Re9Ftrpk5r7ak6VoSF09dYvnSJRNhWP77IjYYhx5zTEb/cFOXGzJEc8tf92H0TW0CtcgHaOUk79uJw4oyJm2Dvsff/QSFraxvdMApYOtNgGoKjDhkKFkAgJtQDwC3BZinPmHJGcz2PsF2/iYNhgGG1HeK+8+G9kHgflPR/nMt+dt37AeLpV+zZj8ytPpDJcPCIThmK/sL+yIrCpya+GQaQtC/Pll7IN7uOBgWXkkjpH6C1gr7hXnB1J04rDLHhzkDfv69hYZJD8xMQsyTVoj4HX5TJ0Zsmwtk/pRLS5IWb9PXDbZjr/A/aWU3GKVXYGCNbGKbPymjl0GgWkUrJv69ACxloMFgP5+nHs5bF0cKTcmpGFEDyR/jjCM5ghZcupdgyTiclp9SSQt//mp9/jknOKIl9uVJCqOdLeyKRJhaDhs5v2IUDKSTOshhh6LGnQq3ffpNascbpxUPaeWQXRKDkIsf9WQL9FjXtnPXstFRz1tkMXsWRZ7dkuXoYc1bGRAggKiVSHHsJNTRxX1m1vNpcGK2DGjWi9Ns6vGIIq2
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1P189MB1988.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(4143699003)(18002099003)(22082099003)(56012099006)(11063799006)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?5o8f3wM6/q3+s2t3HlZ/aH2HzGbdaiOiaXi+945EsLo4H18kGRT8hO4/6Zp5?=
 =?us-ascii?Q?/g9hk0Q/I0ND4zYaPXYPejEP8Ua/TOagpUiV03WBA3nL1oLZUCxps/LMenKX?=
 =?us-ascii?Q?iukO6/i4H7BBk6NHLC0W+RlhqIdd0uTlq0USS4dJ0XWD0bFuCzTweeIofD2V?=
 =?us-ascii?Q?N+kMxUD3RBGTOATGJ0nr9XiTa1r243I4m67MIrJJqawByH1gWHYkBnMYaPuU?=
 =?us-ascii?Q?J8abT0hqY/vX9QgJdbA7L1InYJxgCXG7thaOy8FwEGFDIVyxVl5LtE27Ffjz?=
 =?us-ascii?Q?zERl4lCd51Tk7WfdoUNubhE49xprRsECHwQDTbhdL68bIZlusLeosQfp18dn?=
 =?us-ascii?Q?P73MU1sEWlojFtWcUG7WoItHWRbaDOOzSjymaViUmhm30AY7wqZaBEwKpjYG?=
 =?us-ascii?Q?fLK2NUDF7p23QObJzv18ddrZLOMO/cPzVBc8tZzvp7IkiDSYHpHo3o1tGZA+?=
 =?us-ascii?Q?VQZalOSjY/5pXcRBXagfaNkvddUNeE/jXrhjweJdqyN9HtL4kJc/krXRcJzf?=
 =?us-ascii?Q?KmchorVpz3ClDU8SmDzA2HOZP+FBTcq/aFZVPNLoz4tKal2jJfjh7lugPshT?=
 =?us-ascii?Q?+HRpsAHNod5/AZNZhrE65uCaCTqpC/09Zcj6UPT5f93ksJul+90oMWvwjbYl?=
 =?us-ascii?Q?DEhEUiyYX+LbxEu8hb8vDxNoqvgVxPqvdj5PsjSg1o5AYUF7RvXdDPSUGgnm?=
 =?us-ascii?Q?XPShA4kihsqES/ZMkp0nM+7toaSoXuhCiXRq+M2T5PjNcYpHwLmiKV3DA6ZO?=
 =?us-ascii?Q?vesFbMATULPJ33LnCRNGFnfj+r9BANJxH6x5UBa1arzIJ58icZJza2FF5hee?=
 =?us-ascii?Q?TiV4F7+r5gucaoXB1Yd4QAWL5rOv7+Sfs30TdDQDwYVyj0Qx/2vbBXhN7AVK?=
 =?us-ascii?Q?hM+ryYRK3bnmlf4EhK8iURxtSD46a06n+yitD/NF5y9OEbgi7vfNl05QH2sq?=
 =?us-ascii?Q?pgzegUQzKxTwBd1Z2vVvNXUX1grkeIoFUkIR8764dgSe8v724vW6Eetyd/gG?=
 =?us-ascii?Q?IOq3ikHSLVlnRb952tdg3TaPu1DglAiaNf0MCk2yA5LC4fLBaDWOg6dYoahN?=
 =?us-ascii?Q?/JSqBLq/CvJ8w+jlhXp1ArXSkldfSZOGpis5gf4SGIT94hN+dtFneqOGs70e?=
 =?us-ascii?Q?ZuaLJlMJe+QHAb+KG6tK7afsqr0ch1GQW1mJ7NULEX+BG3hPeWhEYhHqgHnj?=
 =?us-ascii?Q?jWNJthjgtRwBFbV8hl7Vm3AElAZ3dEXIxTgPy0zBWK6DwImNISeKMJ1YWiI/?=
 =?us-ascii?Q?8mM0FhqGRQBHxb5thQ36gfgTPresIwbvC8ziSd33wg8M6yh4O6yVWLaOpOtE?=
 =?us-ascii?Q?hWHM519ahjyeJRlwM0SuaVF5gcBrF+13g3wP6qTjKRvwsjq4xFEgN67bNXVg?=
 =?us-ascii?Q?LNDOvmUQhZiJUrwAt0ZBwpYwA5dPsRSeZyrfuk57Amf1X2SqssqaV5cA5xR7?=
 =?us-ascii?Q?XeCH0ej/5+EXNts+DWym3sjtKSyXGBYEVkJpFLu7VVL2Z3Xx67K9Ldh8PDcv?=
 =?us-ascii?Q?20LoJk8mYt+KR8vpkBhqn4Pa79WbL/BDmLtYEku/qe0npF79fBH1tqWgh2vF?=
 =?us-ascii?Q?5J+vFjmG/VZJcuj0r0gRthYJWxaVIsEPx/HkCbMBrKCNPByV0GYxdXjLJJJm?=
 =?us-ascii?Q?L/P7Dfni1/EZ4uUtOBaW3nuLSOLbpd3cocrLr/Q/ce3rTgpAIG4YaZZsf7AJ?=
 =?us-ascii?Q?kFptSYRGFFYqRjNiF1xeO8qjLq29rBTH4qg9zqKRT16R9lnCuV6sMW8RH2yl?=
 =?us-ascii?Q?1I1UeFJUNQ=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 754e89ea-3b55-4d30-fa82-08dec1206759
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2026 03:30:05.0236
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EEWEtJY4QIl07WL7hMPpj967HnktOvzp/EkQcUMErcAZ9ji7zMhqxfK/4esP2A8TInzId27ys00rkrZzewutPEyOSvQCzPk00NjTzpTT0OY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1P189MB3626
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[est.tech:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-294537-lists,netdev=lfdr.de];
	FORGED_SENDER(0.00)[tung.quang.nguyen@est.tech,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:michael.bommarito@gmail.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:tipc-discussion@lists.sourceforge.net,m:linux-kernel@vger.kernel.org,m:jmaloy@redhat.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:michaelbommarito@gmail.com,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	DMARC_NA(0.00)[est.tech];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tung.quang.nguyen@est.tech,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[est.tech:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp,GV1P189MB1988.EURP189.PROD.OUTLOOK.COM:mid,est.tech:from_mime,est.tech:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5436A633F5D

>Subject: [PATCH net 4/4] tipc: reject inverted service ranges from peer bi=
ndings
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
> net/tipc/name_distr.c | 11 ++++++++++-
> 1 file changed, 10 insertions(+), 1 deletion(-)
>
>diff --git a/net/tipc/name_distr.c b/net/tipc/name_distr.c index
>190b49c5cbc3e..b4ff074a2babd 100644
>--- a/net/tipc/name_distr.c
>+++ b/net/tipc/name_distr.c
>@@ -283,9 +283,18 @@ static bool tipc_update_nametbl(struct net *net,
>struct distr_item *i,
> 	struct tipc_socket_addr sk;
> 	struct tipc_uaddr ua;
> 	u32 key =3D ntohl(i->key);
>+	u32 lower =3D ntohl(i->lower);
>+	u32 upper =3D ntohl(i->upper);

Please restructure these variable declarations following reverse Xmas tree =
style.

>+
>+	/* A peer-advertised binding with lower > upper can never be
>matched
>+	 * or withdrawn and would leak the publication; the local bind path
>+	 * rejects such ranges, so reject ranges learned from the network too.
>+	 */
>+	if (lower > upper)
>+		return false;
>
> 	tipc_uaddr(&ua, TIPC_SERVICE_RANGE, TIPC_CLUSTER_SCOPE,
>-		   ntohl(i->type), ntohl(i->lower), ntohl(i->upper));
>+		   ntohl(i->type), lower, upper);
> 	sk.ref =3D ntohl(i->port);
> 	sk.node =3D node;
>
>--
>2.53.0
>


