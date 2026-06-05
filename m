Return-Path: <netdev+bounces-295554-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id skqOCb0rImrNTQEAu9opvQ
	(envelope-from <netdev+bounces-295554-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 03:51:57 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 60CEE644890
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 03:51:56 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=est.tech header.s=selector1 header.b=gV9PXCDe;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295554-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-295554-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BAFBD307DFD4
	for <lists+netdev@lfdr.de>; Fri,  5 Jun 2026 01:38:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 706863CFF6C;
	Fri,  5 Jun 2026 01:38:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013028.outbound.protection.outlook.com [40.107.159.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4258031ED83;
	Fri,  5 Jun 2026 01:38:02 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780623500; cv=fail; b=dPdVayZ471i/8bNNEgey7P6auTKh8hYwzqCrkg3N8TSAWEPs2absIbXtGx1aWO8ACxSW3BrorvaUY2NH6eTGsYr033JmtWO5kFEYS+sqdHQvMLW+FlJYvQ9F4FQEu08jVqfHHUBkxqrxdZBR9f2MZTzaV5dFYQ1UXGtadZtaWcs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780623500; c=relaxed/simple;
	bh=K5cqSMFpEVdAOBxdlyt8kKrvPSpJ2Hr/nI64Z+F7bUk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=H+PoLeRfht5lLgkMlyM1rqEXNKzNc6jW9ZSbvuBatniWzSt2ZmrdO48VJ+Mj8nCs4SwF6V++UJT547r5xus140AWC/VCuVqHRh35W67futf0SZT/pSwQ8fDinH3MhFJmMNY2tK427lOX86wCaW9jFYmOuMvz+2jZu8T5VaRcV3U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech; spf=pass smtp.mailfrom=est.tech; dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b=gV9PXCDe; arc=fail smtp.client-ip=40.107.159.28
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H0ij6Ye4hBLBV8pnDUAyzZBwKijNf7dRJZuVjS1AkzGnMbKYJJ1X4qVk0HmA/Za+tHJRUZ+u7mXPg+hsskRWbAvKGa+B8TqIlmTzkfVAy6YrtUt3gvlKMetgc9YW3ImPvXWAh4LjUPqCpo34qHyP9cXaT0ddRr1nwKEOQpd/9jVAyqhMPn2RmPMuaQBTUZ2vogA40lbuvfHmfdHT3Hlrx61t2SXMmaeWqV83FGVBy0mInJ3otdATAJ0JxcNWWF++uyO9LkJ8fR5LZAqfhQtCtgjyLUTtWM9Jjc1xENK/OrRqag8a/OsAUmDQWTSA1LQZFCUHpC/HcoeV+V0Yx1KlkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mAANxIi/xmMY0on/RaCkhPEgwqhFT13BiM5R+IS5lvc=;
 b=lRWon2uhVQ7y95VlDvwF4JhJbe9qh22QZrJvpVq5VlTsH/jDYFXNcU9Tzky5L8vctKYg253irBNL56BKAi4D+2Jjy1S5oDZuLrBiL3Rucj76SF83l9wneCTPduks8h+ioHg5wG2et+TBDJtenZhLkHPFONLV/cQPRXgD8OnV+c6U4IuqjxZEwLABAlHoVRfjoEk+1AJhsPZutFv7j/VJYsRfn9u0oB6CjaQBnITvrqBUk1r+2RFuZJAhiTcfPtkCnD3PoyfWUsdWqDYkLZSthD1iwug724X5Q37lNlxsOuIFNKidTJexvHEMf7ZH+KQMciCqAcfqAYeL8DhZftmz6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=est.tech; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mAANxIi/xmMY0on/RaCkhPEgwqhFT13BiM5R+IS5lvc=;
 b=gV9PXCDeUN8KzClL9lcZ9PhrSqmwNiskP79DHrNfdZ6aBR0iN145asT6rbEUajZ5iwmVE/NkGrvJqMEk+82vWlOQZdagE1dwaTwKg72AfIbDa5UtEnTBGw77T4T8H/yMXGPjlzvZvEW7mjLaRNRdWi323jqIzgrp87JN+19sBTktmBs5VJKOwdtCbWH1hMEDPXJpDCu9pIsRVLe6O7A7pxW/ag6+57q3PpQcFC6scuhs7/cGccD+8CDGev9ULmlHJAhxKJUnfBlRYTBISg2wOkg44056eHagqXFc0fZuzv5SMskt5j8LV740sg3CFnP9dBz268BTHj8Ap0kCSDk7RQ==
Received: from GV1P189MB1988.EURP189.PROD.OUTLOOK.COM (2603:10a6:150:63::5) by
 DU7PPF93C7E04F1.EURP189.PROD.OUTLOOK.COM (2603:10a6:18:3::adf) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.8; Fri, 5 Jun 2026 01:37:58 +0000
Received: from GV1P189MB1988.EURP189.PROD.OUTLOOK.COM
 ([fe80::bfff:5391:8a49:21b7]) by GV1P189MB1988.EURP189.PROD.OUTLOOK.COM
 ([fe80::bfff:5391:8a49:21b7%6]) with mapi id 15.21.0092.007; Fri, 5 Jun 2026
 01:37:57 +0000
From: Tung Quang Nguyen <tung.quang.nguyen@est.tech>
To: Tim Bird <tim.bird@sony.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"tipc-discussion@lists.sourceforge.net"
	<tipc-discussion@lists.sourceforge.net>, "linux-spdx@vger.kernel.org"
	<linux-spdx@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "jmaloy@redhat.com" <jmaloy@redhat.com>,
	"davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "horms@kernel.org"
	<horms@kernel.org>
Subject: RE: [PATCH] tipc: Add SPDX id lines to source files
Thread-Topic: [PATCH] tipc: Add SPDX id lines to source files
Thread-Index: AQHc9FGJbV5WutgYYkuYt2Ohyz8RjbYvLawA
Date: Fri, 5 Jun 2026 01:37:57 +0000
Message-ID:
 <GV1P189MB1988FB0E53EA8D3FCC2533BDC6112@GV1P189MB1988.EURP189.PROD.OUTLOOK.COM>
References: <20260604183805.747630-1-tim.bird@sony.com>
In-Reply-To: <20260604183805.747630-1-tim.bird@sony.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV1P189MB1988:EE_|DU7PPF93C7E04F1:EE_
x-ms-office365-filtering-correlation-id: 59622872-c0b9-449b-9af4-08dec2a3123e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|7416014|1800799024|6133799003|38070700021|56012099006|22082099003|18002099003|11063799006;
x-microsoft-antispam-message-info:
 rzGRybM6ujXWt70oTDfp0+WEb5+Z33SzRpgrIaNoydb3FHwm8Vu8fzLahu3JdtzbRTwF/fihC0CTAOyL3xSnAv7HS7TVUoMa9Wb1KrtXTh3EJ1tL4h2pialIfw1b7Ic15YoR0xACzpYICCqTEMX5HMPZ0WvqEIqE6ECYGVB2n0N72CGeFsFIbKfXPs15jdael1YWbc6PIg8bgW8kvs2E/64O27oc3U1eIHS9Ss3nhgvApHerOHqZI5L7xE5lWGmP4o/u88zuzFDSHonT3V0Kx+yn7COEajcRin/0NyOGSu+xN/gQupY2xCkcV2rMitZIT2jUm1B8LNViwqwhpkwAju6svHmHn8/768fOCxp7xVF6Wr+NyTYf+Ql3PazbhNKqS8tnDVwI4K7D2tUmUynMZ3/yKqkFGWm6GB5HvH4/fv4+7V2UW6Xi2eLTerpXIas7Nfv/AeC6Xl9PVMCObjh5cHJqRJNvjCmZVcBjYjj2mi1Dufzv6fjNvN4q/6dyTslu9OTtG6C1UDo395Ew7J/JGl4SAHPgCVLjQoICvZ+CludpAJLlfCcYLQvFyaGfwGXi9lAZvpiR7aXOoNoUlnOtNMRwNdTqqNpbq4ZB8U8p+HfMqrig2g2w/DHI6wKekWjVgEtEB0hUzH66phBlk7Z8b9lctW2+VJNDk5ZPzr4uigPRxQcsE3GrSzq4lmjGpkQJg6V4FOtIPE3qhVnb08aigV6mXxO7yk2mtqBxthldLGyINeEsJmVsrnNz5yXKABtv
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1P189MB1988.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(6133799003)(38070700021)(56012099006)(22082099003)(18002099003)(11063799006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?7ntdc5hEsdw7eIz0lvnQltpi9fw1htmKHKH81d0zkiEEXN9oT7eX/djCZJbT?=
 =?us-ascii?Q?HvyVAr/XpqZmzfM6sbWzhL8tzIFjo+dxZLxDINa7fuATB6IZijmxsFhsSVfi?=
 =?us-ascii?Q?d536yrrlbSUQaumKWXeAF+iX4zIHkuAeJGDymyf2Qe1fZ/B9rm0Valr7w9FP?=
 =?us-ascii?Q?C45EVvfMN9u3tLAiFsUYOnjQJNzPnJwGVYG0nV0KpJMSY3qXBbfhKzrz388D?=
 =?us-ascii?Q?cSBQEiswz7mTc7NTk8gwRjMFW+7BxmAhLZ5VTXF17H/tMR4IZl+DhxfJqDCj?=
 =?us-ascii?Q?mFsEwSI6Ru13sDX5f5pXEUI/oFuU2u3GHfVM5wJSewfUHJi4/GXRi7C11q5H?=
 =?us-ascii?Q?1HTk/SUDkF1ujLZe4D1H2BsSUXFAtEWg698Y0vzzd48mZxAhWioUFU0OBio/?=
 =?us-ascii?Q?Y7cWAacohVoK9hsbvGbIqyPDjw6xr12hWxF9YJILOw3uxdcAZWSXqR2/0zw7?=
 =?us-ascii?Q?jeeAsaa6C2dUjm4slntL89MCcLWSOpsAJQK+WnLGCT0Ii61Q+OebinGepg7g?=
 =?us-ascii?Q?yRsbd9PgMJ2JxaLmf+lmPH1htF+2/WJ1TGJpSlUQRggm9c36k4tcg6Q6bKhC?=
 =?us-ascii?Q?3mGiSwQ2b8ahI75iEQQ6zf4LyVJdkvG5MDRO4hK9UXxs0PZ+XYdvxjdIEho5?=
 =?us-ascii?Q?qTne6Iu0OQ93risn/1yMazpTO9+qhmglXr8zICFhUFSXj/k753IgajCiWGew?=
 =?us-ascii?Q?STU0semDPccGv2EYFiiNYhJMjwU7znkayQXgCACp4yE9e1U4v3C4+Pz3FkKc?=
 =?us-ascii?Q?g3hIP17437TeEyfiuxN15JuqfjNSqyYqITZN6Bg4adlc4CgxckzrpK8sE5Zy?=
 =?us-ascii?Q?K4wsJ7OmAfgrRp/gnYItlxzosbsAqHDSX3jJdejWg6/+ZPMNDdI60yztYFzn?=
 =?us-ascii?Q?/zrflIlqKdwqw2n8jPqowsYb0ze0B0HeQdE7X7BdIQViQttw7HvNjMUPbTsO?=
 =?us-ascii?Q?Q2Y25W3A/X4SxDJJLDTEcW6KH+6R59TdtZ+m3jRyutFoLuA5bv0gV9L9/k0u?=
 =?us-ascii?Q?AVwIsmuTPQoTztcVsMgzQC58+rRXNF9p2r7iO1RxoNM+t/SlqtxgvmZtyjqA?=
 =?us-ascii?Q?pRS/Wf1knkcF+cR4ElJcXcXWQEDhhv7Ci8mDVdqOh73iFBy38JdKOCpFbpZl?=
 =?us-ascii?Q?2zB4YDNNn6U4zdyy/HhkTCQdS3OKC/orJ/qrDwZYdKTQ2I52oYcBgt72hwqo?=
 =?us-ascii?Q?SEUFIGhZLBQ1tjaSUn5IWTx0xTcAN2riKNx9ZI6J1DB3V1zfUJpNHNqW8fYs?=
 =?us-ascii?Q?Jvi/cNEhC8t8rrDgbRNm4oJJC+siUSYVFP4P9WZB5aid3++6ukoOFNiqGMUn?=
 =?us-ascii?Q?mtBui27FiM8FEbmqXWmzZ7TzJ6lQ9YB/0KLpkO0RSPEz+p/Wmxk53jlZ4v2s?=
 =?us-ascii?Q?dUOhbO+nluJxSzqT4yeCyghNm5yJXb/7A7HrfVtZkeY9sJ/4kM67f5XZ7PC8?=
 =?us-ascii?Q?xF1J/txz/De+/r/yf13CqaQnPsI2inJ3kh6s+e//JXwkaCTUWb18WrzlnF7r?=
 =?us-ascii?Q?53Y1vqnCEc9iO1krZQxZ/oR68xr3s6lucOpPbxgqBwKZbS/UnkdWpj4ifJDY?=
 =?us-ascii?Q?nY+K7TSwuLMY+SJ8IBbSCfzGwiKDGruNO5wjK0jyRM3GQcR/AN951ZTnHLCT?=
 =?us-ascii?Q?fzkXAP6yy+46GN/aRS1tId9703nsv+7a/mLWJ2X2PVaGUO57xkMxNQdPyGH2?=
 =?us-ascii?Q?iksiwIiCOWhaBApyNQxuYZ+F0vDaZEo6mNpHijXaRe567zG1P3dHUgx9G/gY?=
 =?us-ascii?Q?VdCQwLfCIQ=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 59622872-c0b9-449b-9af4-08dec2a3123e
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jun 2026 01:37:57.4431
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Xp6VUhGHEYlUkZm+rR+J2Wx0U187btAfLNVMy618g4xTIQzbcBKffp/FvbYI834SMO+2oeOSozC3P8JYAuGkM/Ga+ZiG/kx82UbzeXlm9R4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU7PPF93C7E04F1
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_DKIM_ALLOW(-0.20)[est.tech:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_NA(0.00)[est.tech];
	TAGGED_FROM(0.00)[bounces-295554-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:tim.bird@sony.com,m:netdev@vger.kernel.org,m:tipc-discussion@lists.sourceforge.net,m:linux-spdx@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:jmaloy@redhat.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[tung.quang.nguyen@est.tech,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[est.tech:+];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tung.quang.nguyen@est.tech,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[est.tech:from_mime,est.tech:dkim,sony.com:email,GV1P189MB1988.EURP189.PROD.OUTLOOK.COM:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 60CEE644890

>Subject: [PATCH] tipc: Add SPDX id lines to source files
>
>Most of the tipc source files are missing SPDX-License-Identifier
>lines.  Add appropriate IDs to these files, and remove the
>previous license lines from the headers.  In this case,
>every file received the 'GPL-2.0 OR BSD-3-Clause' ID expression.

The original license of TIPC is GPL-2.0. Why do you think it should be dual=
 licensing now ?

>
>Signed-off-by: Tim Bird <tim.bird@sony.com>
>---
> net/tipc/addr.c           | 29 +----------------------------
> net/tipc/addr.h           | 29 +----------------------------
> net/tipc/bcast.c          | 29 +----------------------------
> net/tipc/bcast.h          | 29 +----------------------------
> net/tipc/bearer.c         | 29 +----------------------------
> net/tipc/bearer.h         | 29 +----------------------------
> net/tipc/core.c           | 29 +----------------------------
> net/tipc/core.h           | 29 +----------------------------
> net/tipc/diag.c           | 29 +----------------------------
> net/tipc/discover.c       | 29 +----------------------------
> net/tipc/discover.h       | 29 +----------------------------
> net/tipc/eth_media.c      | 29 +----------------------------
> net/tipc/group.c          | 29 +----------------------------
> net/tipc/group.h          | 29 +----------------------------
> net/tipc/ib_media.c       | 29 +----------------------------
> net/tipc/link.c           | 29 +----------------------------
> net/tipc/link.h           | 29 +----------------------------
> net/tipc/monitor.c        | 29 +----------------------------
> net/tipc/monitor.h        | 29 +----------------------------
> net/tipc/msg.c            | 29 +----------------------------
> net/tipc/msg.h            | 29 +----------------------------
> net/tipc/name_distr.c     | 29 +----------------------------
> net/tipc/name_distr.h     | 29 +----------------------------
> net/tipc/name_table.c     | 29 +----------------------------
> net/tipc/name_table.h     | 29 +----------------------------
> net/tipc/net.c            | 29 +----------------------------
> net/tipc/net.h            | 29 +----------------------------
> net/tipc/netlink.c        | 29 +----------------------------
> net/tipc/netlink.h        | 29 +----------------------------
> net/tipc/netlink_compat.c | 29 +----------------------------
> net/tipc/node.c           | 29 +----------------------------
> net/tipc/node.h           | 29 +----------------------------
> net/tipc/socket.c         | 29 +----------------------------
> net/tipc/socket.h         | 29 +----------------------------
> net/tipc/subscr.c         | 29 +----------------------------
> net/tipc/subscr.h         | 29 +----------------------------
> net/tipc/sysctl.c         | 29 +----------------------------
> net/tipc/topsrv.c         | 29 +----------------------------
> net/tipc/topsrv.h         | 29 +----------------------------
> net/tipc/trace.c          | 29 +----------------------------
> net/tipc/trace.h          | 29 +----------------------------
> net/tipc/udp_media.c      | 29 +----------------------------
> net/tipc/udp_media.h      | 29 +----------------------------
> 43 files changed, 43 insertions(+), 1204 deletions(-)
>
>diff --git a/net/tipc/addr.c b/net/tipc/addr.c
>index 6f5c54cbf8d9..ee73b58bcc69 100644
>--- a/net/tipc/addr.c
>+++ b/net/tipc/addr.c
>@@ -1,3 +1,4 @@
>+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
> /*
>  * net/tipc/addr.c: TIPC address utility routines
>  *
>@@ -5,34 +6,6 @@
>  * Copyright (c) 2004-2005, 2010-2011, Wind River Systems
>  * Copyright (c) 2020-2021, Red Hat Inc
>  * All rights reserved.
>- *
>- * Redistribution and use in source and binary forms, with or without
>- * modification, are permitted provided that the following conditions are=
 met:
>- *
>- * 1. Redistributions of source code must retain the above copyright
>- *    notice, this list of conditions and the following disclaimer.
>- * 2. Redistributions in binary form must reproduce the above copyright
>- *    notice, this list of conditions and the following disclaimer in the
>- *    documentation and/or other materials provided with the distribution=
.
>- * 3. Neither the names of the copyright holders nor the names of its
>- *    contributors may be used to endorse or promote products derived fro=
m
>- *    this software without specific prior written permission.
>- *
>- * Alternatively, this software may be distributed under the terms of the
>- * GNU General Public License ("GPL") version 2 as published by the Free
>- * Software Foundation.
>- *
>- * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND
>CONTRIBUTORS "AS IS"
>- * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
>LIMITED TO, THE
>- * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A
>PARTICULAR PURPOSE
>- * ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR
>CONTRIBUTORS BE
>- * LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
>- * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
>PROCUREMENT OF
>- * SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR
>BUSINESS
>- * INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
>WHETHER IN
>- * CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR
>OTHERWISE)
>- * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
>ADVISED OF THE
>- * POSSIBILITY OF SUCH DAMAGE.
>  */
>
> #include "addr.h"
>diff --git a/net/tipc/addr.h b/net/tipc/addr.h
>index a113cf7e1f89..0eccd4719092 100644
>--- a/net/tipc/addr.h
>+++ b/net/tipc/addr.h
>@@ -1,3 +1,4 @@
>+/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
> /*
>  * net/tipc/addr.h: Include file for TIPC address utility routines
>  *
>@@ -5,34 +6,6 @@
>  * Copyright (c) 2004-2005, Wind River Systems
>  * Copyright (c) 2020-2021, Red Hat Inc
>  * All rights reserved.
>- *
>- * Redistribution and use in source and binary forms, with or without
>- * modification, are permitted provided that the following conditions are=
 met:
>- *
>- * 1. Redistributions of source code must retain the above copyright
>- *    notice, this list of conditions and the following disclaimer.
>- * 2. Redistributions in binary form must reproduce the above copyright
>- *    notice, this list of conditions and the following disclaimer in the
>- *    documentation and/or other materials provided with the distribution=
.
>- * 3. Neither the names of the copyright holders nor the names of its
>- *    contributors may be used to endorse or promote products derived fro=
m
>- *    this software without specific prior written permission.
>- *
>- * Alternatively, this software may be distributed under the terms of the
>- * GNU General Public License ("GPL") version 2 as published by the Free
>- * Software Foundation.
>- *
>- * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND
>CONTRIBUTORS "AS IS"
>- * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
>LIMITED TO, THE
>- * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A
>PARTICULAR PURPOSE
>- * ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR
>CONTRIBUTORS BE
>- * LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
>- * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
>PROCUREMENT OF
>- * SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR
>BUSINESS
>- * INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
>WHETHER IN
>- * CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR
>OTHERWISE)
>- * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
>ADVISED OF THE
>- * POSSIBILITY OF SUCH DAMAGE.
>  */
>
> #ifndef _TIPC_ADDR_H
>diff --git a/net/tipc/bcast.c b/net/tipc/bcast.c
>index 76a1585d3f6b..27dbb5fcdb3a 100644
>--- a/net/tipc/bcast.c
>+++ b/net/tipc/bcast.c
>@@ -1,3 +1,4 @@
>+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
> /*
>  * net/tipc/bcast.c: TIPC broadcast code
>  *
>@@ -5,34 +6,6 @@
>  * Copyright (c) 2004, Intel Corporation.
>  * Copyright (c) 2005, 2010-2011, Wind River Systems
>  * All rights reserved.
>- *
>- * Redistribution and use in source and binary forms, with or without
>- * modification, are permitted provided that the following conditions are=
 met:
>- *
>- * 1. Redistributions of source code must retain the above copyright
>- *    notice, this list of conditions and the following disclaimer.
>- * 2. Redistributions in binary form must reproduce the above copyright
>- *    notice, this list of conditions and the following disclaimer in the
>- *    documentation and/or other materials provided with the distribution=
.
>- * 3. Neither the names of the copyright holders nor the names of its
>- *    contributors may be used to endorse or promote products derived fro=
m
>- *    this software without specific prior written permission.
>- *
>- * Alternatively, this software may be distributed under the terms of the
>- * GNU General Public License ("GPL") version 2 as published by the Free
>- * Software Foundation.
>- *
>- * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND
>CONTRIBUTORS "AS IS"
>- * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
>LIMITED TO, THE
>- * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A
>PARTICULAR PURPOSE
>- * ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR
>CONTRIBUTORS BE
>- * LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
>- * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
>PROCUREMENT OF
>- * SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR
>BUSINESS
>- * INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
>WHETHER IN
>- * CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR
>OTHERWISE)
>- * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
>ADVISED OF THE
>- * POSSIBILITY OF SUCH DAMAGE.
>  */
>
> #include <linux/tipc_config.h>
>diff --git a/net/tipc/bcast.h b/net/tipc/bcast.h
>index 2d9352dc7b0e..8a453b3796af 100644
>--- a/net/tipc/bcast.h
>+++ b/net/tipc/bcast.h
>@@ -1,37 +1,10 @@
>+/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
> /*
>  * net/tipc/bcast.h: Include file for TIPC broadcast code
>  *
>  * Copyright (c) 2003-2006, 2014-2015, Ericsson AB
>  * Copyright (c) 2005, 2010-2011, Wind River Systems
>  * All rights reserved.
>- *
>- * Redistribution and use in source and binary forms, with or without
>- * modification, are permitted provided that the following conditions are=
 met:
>- *
>- * 1. Redistributions of source code must retain the above copyright
>- *    notice, this list of conditions and the following disclaimer.
>- * 2. Redistributions in binary form must reproduce the above copyright
>- *    notice, this list of conditions and the following disclaimer in the
>- *    documentation and/or other materials provided with the distribution=
.
>- * 3. Neither the names of the copyright holders nor the names of its
>- *    contributors may be used to endorse or promote products derived fro=
m
>- *    this software without specific prior written permission.
>- *
>- * Alternatively, this software may be distributed under the terms of the
>- * GNU General Public License ("GPL") version 2 as published by the Free
>- * Software Foundation.
>- *
>- * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND
>CONTRIBUTORS "AS IS"
>- * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
>LIMITED TO, THE
>- * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A
>PARTICULAR PURPOSE
>- * ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR
>CONTRIBUTORS BE
>- * LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
>- * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
>PROCUREMENT OF
>- * SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR
>BUSINESS
>- * INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
>WHETHER IN
>- * CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR
>OTHERWISE)
>- * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
>ADVISED OF THE
>- * POSSIBILITY OF SUCH DAMAGE.
>  */
>
> #ifndef _TIPC_BCAST_H
>diff --git a/net/tipc/bearer.c b/net/tipc/bearer.c
>index a3bd1ef17558..ba362ea61ccf 100644
>--- a/net/tipc/bearer.c
>+++ b/net/tipc/bearer.c
>@@ -1,37 +1,10 @@
>+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
> /*
>  * net/tipc/bearer.c: TIPC bearer code
>  *
>  * Copyright (c) 1996-2006, 2013-2016, Ericsson AB
>  * Copyright (c) 2004-2006, 2010-2013, Wind River Systems
>  * All rights reserved.
>- *
>- * Redistribution and use in source and binary forms, with or without
>- * modification, are permitted provided that the following conditions are=
 met:
>- *
>- * 1. Redistributions of source code must retain the above copyright
>- *    notice, this list of conditions and the following disclaimer.
>- * 2. Redistributions in binary form must reproduce the above copyright
>- *    notice, this list of conditions and the following disclaimer in the
>- *    documentation and/or other materials provided with the distribution=
.
>- * 3. Neither the names of the copyright holders nor the names of its
>- *    contributors may be used to endorse or promote products derived fro=
m
>- *    this software without specific prior written permission.
>- *
>- * Alternatively, this software may be distributed under the terms of the
>- * GNU General Public License ("GPL") version 2 as published by the Free
>- * Software Foundation.
>- *
>- * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND
>CONTRIBUTORS "AS IS"
>- * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
>LIMITED TO, THE
>- * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A
>PARTICULAR PURPOSE
>- * ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR
>CONTRIBUTORS BE
>- * LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
>- * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
>PROCUREMENT OF
>- * SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR
>BUSINESS
>- * INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
>WHETHER IN
>- * CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR
>OTHERWISE)
>- * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
>ADVISED OF THE
>- * POSSIBILITY OF SUCH DAMAGE.
>  */
>
> #include <net/sock.h>
>diff --git a/net/tipc/bearer.h b/net/tipc/bearer.h
>index 41eac1ee0c09..ce913ac16924 100644
>--- a/net/tipc/bearer.h
>+++ b/net/tipc/bearer.h
>@@ -1,37 +1,10 @@
>+/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
> /*
>  * net/tipc/bearer.h: Include file for TIPC bearer code
>  *
>  * Copyright (c) 1996-2006, 2013-2016, Ericsson AB
>  * Copyright (c) 2005, 2010-2011, Wind River Systems
>  * All rights reserved.
>- *
>- * Redistribution and use in source and binary forms, with or without
>- * modification, are permitted provided that the following conditions are=
 met:
>- *
>- * 1. Redistributions of source code must retain the above copyright
>- *    notice, this list of conditions and the following disclaimer.
>- * 2. Redistributions in binary form must reproduce the above copyright
>- *    notice, this list of conditions and the following disclaimer in the
>- *    documentation and/or other materials provided with the distribution=
.
>- * 3. Neither the names of the copyright holders nor the names of its
>- *    contributors may be used to endorse or promote products derived fro=
m
>- *    this software without specific prior written permission.
>- *
>- * Alternatively, this software may be distributed under the terms of the
>- * GNU General Public License ("GPL") version 2 as published by the Free
>- * Software Foundation.
>- *
>- * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND
>CONTRIBUTORS "AS IS"
>- * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
>LIMITED TO, THE
>- * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A
>PARTICULAR PURPOSE
>- * ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR
>CONTRIBUTORS BE
>- * LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
>- * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
>PROCUREMENT OF
>- * SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR
>BUSINESS
>- * INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
>WHETHER IN
>- * CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR
>OTHERWISE)
>- * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
>ADVISED OF THE
>- * POSSIBILITY OF SUCH DAMAGE.
>  */
>
> #ifndef _TIPC_BEARER_H
>diff --git a/net/tipc/core.c b/net/tipc/core.c
>index 434e70eabe08..0fa53f05fd10 100644
>--- a/net/tipc/core.c
>+++ b/net/tipc/core.c
>@@ -1,37 +1,10 @@
>+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
> /*
>  * net/tipc/core.c: TIPC module code
>  *
>  * Copyright (c) 2003-2006, 2013, Ericsson AB
>  * Copyright (c) 2005-2006, 2010-2013, Wind River Systems
>  * All rights reserved.
>- *
>- * Redistribution and use in source and binary forms, with or without
>- * modification, are permitted provided that the following conditions are=
 met:
>- *
>- * 1. Redistributions of source code must retain the above copyright
>- *    notice, this list of conditions and the following disclaimer.
>- * 2. Redistributions in binary form must reproduce the above copyright
>- *    notice, this list of conditions and the following disclaimer in the
>- *    documentation and/or other materials provided with the distribution=
.
>- * 3. Neither the names of the copyright holders nor the names of its
>- *    contributors may be used to endorse or promote products derived fro=
m
>- *    this software without specific prior written permission.
>- *
>- * Alternatively, this software may be distributed under the terms of the
>- * GNU General Public License ("GPL") version 2 as published by the Free
>- * Software Foundation.
>- *
>- * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND
>CONTRIBUTORS "AS IS"
>- * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
>LIMITED TO, THE
>- * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A
>PARTICULAR PURPOSE
>- * ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR
>CONTRIBUTORS BE
>- * LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
>- * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
>PROCUREMENT OF
>- * SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR
>BUSINESS
>- * INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
>WHETHER IN
>- * CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR
>OTHERWISE)
>- * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
>ADVISED OF THE
>- * POSSIBILITY OF SUCH DAMAGE.
>  */
>
> #include "core.h"
>diff --git a/net/tipc/core.h b/net/tipc/core.h
>index 9ce5f9ff6cc0..ff96b66c8bb7 100644
>--- a/net/tipc/core.h
>+++ b/net/tipc/core.h
>@@ -1,3 +1,4 @@
>+/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
> /*
>  * net/tipc/core.h: Include file for TIPC global declarations
>  *
>@@ -5,34 +6,6 @@
>  * Copyright (c) 2005-2007, 2010-2013, Wind River Systems
>  * Copyright (c) 2020, Red Hat Inc
>  * All rights reserved.
>- *
>- * Redistribution and use in source and binary forms, with or without
>- * modification, are permitted provided that the following conditions are=
 met:
>- *
>- * 1. Redistributions of source code must retain the above copyright
>- *    notice, this list of conditions and the following disclaimer.
>- * 2. Redistributions in binary form must reproduce the above copyright
>- *    notice, this list of conditions and the following disclaimer in the
>- *    documentation and/or other materials provided with the distribution=
.
>- * 3. Neither the names of the copyright holders nor the names of its
>- *    contributors may be used to endorse or promote products derived fro=
m
>- *    this software without specific prior written permission.
>- *
>- * Alternatively, this software may be distributed under the terms of the
>- * GNU General Public License ("GPL") version 2 as published by the Free
>- * Software Foundation.
>- *
>- * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND
>CONTRIBUTORS "AS IS"
>- * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
>LIMITED TO, THE
>- * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A
>PARTICULAR PURPOSE
>- * ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR
>CONTRIBUTORS BE
>- * LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
>- * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
>PROCUREMENT OF
>- * SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR
>BUSINESS
>- * INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
>WHETHER IN
>- * CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR
>OTHERWISE)
>- * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
>ADVISED OF THE
>- * POSSIBILITY OF SUCH DAMAGE.
>  */
>
> #ifndef _TIPC_CORE_H
>diff --git a/net/tipc/diag.c b/net/tipc/diag.c
>index 54dde8c4e4d4..e6a1cb0a52da 100644
>--- a/net/tipc/diag.c
>+++ b/net/tipc/diag.c
>@@ -1,36 +1,9 @@
>+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
> /*
>  * net/tipc/diag.c: TIPC socket diag
>  *
>  * Copyright (c) 2018, Ericsson AB
>  * All rights reserved.
>- *
>- * Redistribution and use in source and binary forms, with or without
>- * modification, are permitted provided that the following conditions are=
 met:
>- *
>- * 1. Redistributions of source code must retain the above copyright
>- *    notice, this list of conditions and the following disclaimer.
>- * 2. Redistributions in binary form must reproduce the above copyright
>- *    notice, this list of conditions and the following disclaimer in the
>- *    documentation and/or other materials provided with the distribution=
.
>- * 3. Neither the names of the copyright holders nor the names of its
>- *    contributors may be used to endorse or promote products derived fro=
m
>- *    this software without specific prior written permission.
>- *
>- * Alternatively, this software may be distributed under the terms of the
>- * GNU General Public License ("GPL") version 2 as published by the Free
>- * Software Foundation.
>- *
>- * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND
>CONTRIBUTORS "ASIS"
>- * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
>LIMITED TO,THE
>- * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A
>PARTICULAR PURPOSE
>- * ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR
>CONTRIBUTORS BE
>- * LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
>- * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
>PROCUREMENT OF
>- * SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR
>BUSINESS
>- * INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
>WHETHER IN
>- * CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR
>OTHERWISE)
>- * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
>ADVISED OF THE
>- * POSSIBILITY OF SUCH DAMAGE.
>  */
>
> #include "core.h"
>diff --git a/net/tipc/discover.c b/net/tipc/discover.c
>index 3e54d2df5683..bb4d7c066521 100644
>--- a/net/tipc/discover.c
>+++ b/net/tipc/discover.c
>@@ -1,37 +1,10 @@
>+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
> /*
>  * net/tipc/discover.c
>  *
>  * Copyright (c) 2003-2006, 2014-2018, Ericsson AB
>  * Copyright (c) 2005-2006, 2010-2011, Wind River Systems
>  * All rights reserved.
>- *
>- * Redistribution and use in source and binary forms, with or without
>- * modification, are permitted provided that the following conditions are=
 met:
>- *
>- * 1. Redistributions of source code must retain the above copyright
>- *    notice, this list of conditions and the following disclaimer.
>- * 2. Redistributions in binary form must reproduce the above copyright
>- *    notice, this list of conditions and the following disclaimer in the
>- *    documentation and/or other materials provided with the distribution=
.
>- * 3. Neither the names of the copyright holders nor the names of its
>- *    contributors may be used to endorse or promote products derived fro=
m
>- *    this software without specific prior written permission.
>- *
>- * Alternatively, this software may be distributed under the terms of the
>- * GNU General Public License ("GPL") version 2 as published by the Free
>- * Software Foundation.
>- *
>- * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND
>CONTRIBUTORS "AS IS"
>- * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
>LIMITED TO, THE
>- * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A
>PARTICULAR PURPOSE
>- * ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR
>CONTRIBUTORS BE
>- * LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
>- * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
>PROCUREMENT OF
>- * SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR
>BUSINESS
>- * INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
>WHETHER IN
>- * CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR
>OTHERWISE)
>- * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
>ADVISED OF THE
>- * POSSIBILITY OF SUCH DAMAGE.
>  */
>
> #include "core.h"
>diff --git a/net/tipc/discover.h b/net/tipc/discover.h
>index 521d96c41dfd..87945cd1ed62 100644
>--- a/net/tipc/discover.h
>+++ b/net/tipc/discover.h
>@@ -1,37 +1,10 @@
>+/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
> /*
>  * net/tipc/discover.h
>  *
>  * Copyright (c) 2003-2006, Ericsson AB
>  * Copyright (c) 2005, 2010-2011, Wind River Systems
>  * All rights reserved.
>- *
>- * Redistribution and use in source and binary forms, with or without
>- * modification, are permitted provided that the following conditions are=
 met:
>- *
>- * 1. Redistributions of source code must retain the above copyright
>- *    notice, this list of conditions and the following disclaimer.
>- * 2. Redistributions in binary form must reproduce the above copyright
>- *    notice, this list of conditions and the following disclaimer in the
>- *    documentation and/or other materials provided with the distribution=
.
>- * 3. Neither the names of the copyright holders nor the names of its
>- *    contributors may be used to endorse or promote products derived fro=
m
>- *    this software without specific prior written permission.
>- *
>- * Alternatively, this software may be distributed under the terms of the
>- * GNU General Public License ("GPL") version 2 as published by the Free
>- * Software Foundation.
>- *
>- * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND
>CONTRIBUTORS "AS IS"
>- * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
>LIMITED TO, THE
>- * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A
>PARTICULAR PURPOSE
>- * ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR
>CONTRIBUTORS BE
>- * LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
>- * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
>PROCUREMENT OF
>- * SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR
>BUSINESS
>- * INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
>WHETHER IN
>- * CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR
>OTHERWISE)
>- * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
>ADVISED OF THE
>- * POSSIBILITY OF SUCH DAMAGE.
>  */
>
> #ifndef _TIPC_DISCOVER_H
>diff --git a/net/tipc/eth_media.c b/net/tipc/eth_media.c
>index cb0d185e06af..3eb8c5218f73 100644
>--- a/net/tipc/eth_media.c
>+++ b/net/tipc/eth_media.c
>@@ -1,37 +1,10 @@
>+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
> /*
>  * net/tipc/eth_media.c: Ethernet bearer support for TIPC
>  *
>  * Copyright (c) 2001-2007, 2013-2014, Ericsson AB
>  * Copyright (c) 2005-2008, 2011-2013, Wind River Systems
>  * All rights reserved.
>- *
>- * Redistribution and use in source and binary forms, with or without
>- * modification, are permitted provided that the following conditions are=
 met:
>- *
>- * 1. Redistributions of source code must retain the above copyright
>- *    notice, this list of conditions and the following disclaimer.
>- * 2. Redistributions in binary form must reproduce the above copyright
>- *    notice, this list of conditions and the following disclaimer in the
>- *    documentation and/or other materials provided with the distribution=
.
>- * 3. Neither the names of the copyright holders nor the names of its
>- *    contributors may be used to endorse or promote products derived fro=
m
>- *    this software without specific prior written permission.
>- *
>- * Alternatively, this software may be distributed under the terms of the
>- * GNU General Public License ("GPL") version 2 as published by the Free
>- * Software Foundation.
>- *
>- * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND
>CONTRIBUTORS "AS IS"
>- * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
>LIMITED TO, THE
>- * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A
>PARTICULAR PURPOSE
>- * ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR
>CONTRIBUTORS BE
>- * LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
>- * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
>PROCUREMENT OF
>- * SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR
>BUSINESS
>- * INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
>WHETHER IN
>- * CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR
>OTHERWISE)
>- * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
>ADVISED OF THE
>- * POSSIBILITY OF SUCH DAMAGE.
>  */
>
> #include "core.h"
>diff --git a/net/tipc/group.c b/net/tipc/group.c
>index 14e6732624e2..5b2990b1533e 100644
>--- a/net/tipc/group.c
>+++ b/net/tipc/group.c
>@@ -1,37 +1,10 @@
>+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
> /*
>  * net/tipc/group.c: TIPC group messaging code
>  *
>  * Copyright (c) 2017, Ericsson AB
>  * Copyright (c) 2020, Red Hat Inc
>  * All rights reserved.
>- *
>- * Redistribution and use in source and binary forms, with or without
>- * modification, are permitted provided that the following conditions are=
 met:
>- *
>- * 1. Redistributions of source code must retain the above copyright
>- *    notice, this list of conditions and the following disclaimer.
>- * 2. Redistributions in binary form must reproduce the above copyright
>- *    notice, this list of conditions and the following disclaimer in the
>- *    documentation and/or other materials provided with the distribution=
.
>- * 3. Neither the names of the copyright holders nor the names of its
>- *    contributors may be used to endorse or promote products derived fro=
m
>- *    this software without specific prior written permission.
>- *
>- * Alternatively, this software may be distributed under the terms of the
>- * GNU General Public License ("GPL") version 2 as published by the Free
>- * Software Foundation.
>- *
>- * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND
>CONTRIBUTORS "AS IS"
>- * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
>LIMITED TO, THE
>- * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A
>PARTICULAR PURPOSE
>- * ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR
>CONTRIBUTORS BE
>- * LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
>- * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
>PROCUREMENT OF
>- * SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR
>BUSINESS
>- * INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
>WHETHER IN
>- * CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR
>OTHERWISE)
>- * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
>ADVISED OF THE
>- * POSSIBILITY OF SUCH DAMAGE.
>  */
>
> #include "core.h"
>diff --git a/net/tipc/group.h b/net/tipc/group.h
>index ea4c3be64c78..2eefe626d550 100644
>--- a/net/tipc/group.h
>+++ b/net/tipc/group.h
>@@ -1,37 +1,10 @@
>+/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
> /*
>  * net/tipc/group.h: Include file for TIPC group unicast/multicast functi=
ons
>  *
>  * Copyright (c) 2017, Ericsson AB
>  * Copyright (c) 2020, Red Hat Inc
>  * All rights reserved.
>- *
>- * Redistribution and use in source and binary forms, with or without
>- * modification, are permitted provided that the following conditions are=
 met:
>- *
>- * 1. Redistributions of source code must retain the above copyright
>- *    notice, this list of conditions and the following disclaimer.
>- * 2. Redistributions in binary form must reproduce the above copyright
>- *    notice, this list of conditions and the following disclaimer in the
>- *    documentation and/or other materials provided with the distribution=
.
>- * 3. Neither the names of the copyright holders nor the names of its
>- *    contributors may be used to endorse or promote products derived fro=
m
>- *    this software without specific prior written permission.
>- *
>- * Alternatively, this software may be distributed under the terms of the
>- * GNU General Public License ("GPL") version 2 as published by the Free
>- * Software Foundation.
>- *
>- * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND
>CONTRIBUTORS "AS IS"
>- * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
>LIMITED TO, THE
>- * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A
>PARTICULAR PURPOSE
>- * ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR
>CONTRIBUTORS BE
>- * LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
>- * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
>PROCUREMENT OF
>- * SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR
>BUSINESS
>- * INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
>WHETHER IN
>- * CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR
>OTHERWISE)
>- * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
>ADVISED OF THE
>- * POSSIBILITY OF SUCH DAMAGE.
>  */
>
> #ifndef _TIPC_GROUP_H
>diff --git a/net/tipc/ib_media.c b/net/tipc/ib_media.c
>index b9ad0434c3cd..504d36777a23 100644
>--- a/net/tipc/ib_media.c
>+++ b/net/tipc/ib_media.c
>@@ -1,3 +1,4 @@
>+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
> /*
>  * net/tipc/ib_media.c: Infiniband bearer support for TIPC
>  *
>@@ -8,34 +9,6 @@
>  * Copyright (c) 2001-2007, Ericsson AB
>  * Copyright (c) 2005-2008, 2011, Wind River Systems
>  * All rights reserved.
>- *
>- * Redistribution and use in source and binary forms, with or without
>- * modification, are permitted provided that the following conditions are=
 met:
>- *
>- * 1. Redistributions of source code must retain the above copyright
>- *    notice, this list of conditions and the following disclaimer.
>- * 2. Redistributions in binary form must reproduce the above copyright
>- *    notice, this list of conditions and the following disclaimer in the
>- *    documentation and/or other materials provided with the distribution=
.
>- * 3. Neither the names of the copyright holders nor the names of its
>- *    contributors may be used to endorse or promote products derived fro=
m
>- *    this software without specific prior written permission.
>- *
>- * Alternatively, this software may be distributed under the terms of the
>- * GNU General Public License ("GPL") version 2 as published by the Free
>- * Software Foundation.
>- *
>- * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND
>CONTRIBUTORS "AS IS"
>- * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
>LIMITED TO, THE
>- * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A
>PARTICULAR PURPOSE
>- * ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR
>CONTRIBUTORS BE
>- * LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
>- * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
>PROCUREMENT OF
>- * SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR
>BUSINESS
>- * INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
>WHETHER IN
>- * CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR
>OTHERWISE)
>- * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
>ADVISED OF THE
>- * POSSIBILITY OF SUCH DAMAGE.
>  */
>
> #include <linux/if_infiniband.h>
>diff --git a/net/tipc/link.c b/net/tipc/link.c
>index 49dfc098d89b..ff966b9892ee 100644
>--- a/net/tipc/link.c
>+++ b/net/tipc/link.c
>@@ -1,37 +1,10 @@
>+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
> /*
>  * net/tipc/link.c: TIPC link code
>  *
>  * Copyright (c) 1996-2007, 2012-2016, Ericsson AB
>  * Copyright (c) 2004-2007, 2010-2013, Wind River Systems
>  * All rights reserved.
>- *
>- * Redistribution and use in source and binary forms, with or without
>- * modification, are permitted provided that the following conditions are=
 met:
>- *
>- * 1. Redistributions of source code must retain the above copyright
>- *    notice, this list of conditions and the following disclaimer.
>- * 2. Redistributions in binary form must reproduce the above copyright
>- *    notice, this list of conditions and the following disclaimer in the
>- *    documentation and/or other materials provided with the distribution=
.
>- * 3. Neither the names of the copyright holders nor the names of its
>- *    contributors may be used to endorse or promote products derived fro=
m
>- *    this software without specific prior written permission.
>- *
>- * Alternatively, this software may be distributed under the terms of the
>- * GNU General Public License ("GPL") version 2 as published by the Free
>- * Software Foundation.
>- *
>- * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND
>CONTRIBUTORS "AS IS"
>- * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
>LIMITED TO, THE
>- * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A
>PARTICULAR PURPOSE
>- * ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR
>CONTRIBUTORS BE
>- * LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
>- * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
>PROCUREMENT OF
>- * SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR
>BUSINESS
>- * INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
>WHETHER IN
>- * CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR
>OTHERWISE)
>- * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
>ADVISED OF THE
>- * POSSIBILITY OF SUCH DAMAGE.
>  */
>
> #include "core.h"
>diff --git a/net/tipc/link.h b/net/tipc/link.h
>index d80f5649b395..102ff0184fa8 100644
>--- a/net/tipc/link.h
>+++ b/net/tipc/link.h
>@@ -1,37 +1,10 @@
>+/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
> /*
>  * net/tipc/link.h: Include file for TIPC link code
>  *
>  * Copyright (c) 1995-2006, 2013-2014, Ericsson AB
>  * Copyright (c) 2004-2005, 2010-2011, Wind River Systems
>  * All rights reserved.
>- *
>- * Redistribution and use in source and binary forms, with or without
>- * modification, are permitted provided that the following conditions are=
 met:
>- *
>- * 1. Redistributions of source code must retain the above copyright
>- *    notice, this list of conditions and the following disclaimer.
>- * 2. Redistributions in binary form must reproduce the above copyright
>- *    notice, this list of conditions and the following disclaimer in the
>- *    documentation and/or other materials provided with the distribution=
.
>- * 3. Neither the names of the copyright holders nor the names of its
>- *    contributors may be used to endorse or promote products derived fro=
m
>- *    this software without specific prior written permission.
>- *
>- * Alternatively, this software may be distributed under the terms of the
>- * GNU General Public License ("GPL") version 2 as published by the Free
>- * Software Foundation.
>- *
>- * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND
>CONTRIBUTORS "AS IS"
>- * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
>LIMITED TO, THE
>- * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A
>PARTICULAR PURPOSE
>- * ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR
>CONTRIBUTORS BE
>- * LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
>- * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
>PROCUREMENT OF
>- * SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR
>BUSINESS
>- * INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
>WHETHER IN
>- * CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR
>OTHERWISE)
>- * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
>ADVISED OF THE
>- * POSSIBILITY OF SUCH DAMAGE.
>  */
>
> #ifndef _TIPC_LINK_H
>diff --git a/net/tipc/monitor.c b/net/tipc/monitor.c
>index a94b9b36a700..fe1906e103d3 100644
>--- a/net/tipc/monitor.c
>+++ b/net/tipc/monitor.c
>@@ -1,36 +1,9 @@
>+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
> /*
>  * net/tipc/monitor.c
>  *
>  * Copyright (c) 2016, Ericsson AB
>  * All rights reserved.
>- *
>- * Redistribution and use in source and binary forms, with or without
>- * modification, are permitted provided that the following conditions are=
 met:
>- *
>- * 1. Redistributions of source code must retain the above copyright
>- *    notice, this list of conditions and the following disclaimer.
>- * 2. Redistributions in binary form must reproduce the above copyright
>- *    notice, this list of conditions and the following disclaimer in the
>- *    documentation and/or other materials provided with the distribution=
.
>- * 3. Neither the names of the copyright holders nor the names of its
>- *    contributors may be used to endorse or promote products derived fro=
m
>- *    this software without specific prior written permission.
>- *
>- * Alternatively, this software may be distributed under the terms of the
>- * GNU General Public License ("GPL") version 2 as published by the Free
>- * Software Foundation.
>- *
>- * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND
>CONTRIBUTORS "AS IS"
>- * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
>LIMITED TO, THE
>- * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A
>PARTICULAR PURPOSE
>- * ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR
>CONTRIBUTORS BE
>- * LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
>- * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
>PROCUREMENT OF
>- * SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR
>BUSINESS
>- * INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
>WHETHER IN
>- * CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR
>OTHERWISE)
>- * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
>ADVISED OF THE
>- * POSSIBILITY OF SUCH DAMAGE.
>  */
>
> #include <net/genetlink.h>
>diff --git a/net/tipc/monitor.h b/net/tipc/monitor.h
>index ed63d2e650b0..3b849c683371 100644
>--- a/net/tipc/monitor.h
>+++ b/net/tipc/monitor.h
>@@ -1,36 +1,9 @@
>+/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
> /*
>  * net/tipc/monitor.h
>  *
>  * Copyright (c) 2015, Ericsson AB
>  * All rights reserved.
>- *
>- * Redistribution and use in source and binary forms, with or without
>- * modification, are permitted provided that the following conditions are=
 met:
>- *
>- * 1. Redistributions of source code must retain the above copyright
>- *    notice, this list of conditions and the following disclaimer.
>- * 2. Redistributions in binary form must reproduce the above copyright
>- *    notice, this list of conditions and the following disclaimer in the
>- *    documentation and/or other materials provided with the distribution=
.
>- * 3. Neither the names of the copyright holders nor the names of its
>- *    contributors may be used to endorse or promote products derived fro=
m
>- *    this software without specific prior written permission.
>- *
>- * Alternatively, this software may be distributed under the terms of the
>- * GNU General Public License ("GPL") version 2 as published by the Free
>- * Software Foundation.
>- *
>- * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND
>CONTRIBUTORS "AS IS"
>- * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
>LIMITED TO, THE
>- * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A
>PARTICULAR PURPOSE
>- * ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR
>CONTRIBUTORS BE
>- * LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
>- * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
>PROCUREMENT OF
>- * SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR
>BUSINESS
>- * INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
>WHETHER IN
>- * CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR
>OTHERWISE)
>- * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
>ADVISED OF THE
>- * POSSIBILITY OF SUCH DAMAGE.
>  */
>
> #ifndef _TIPC_MONITOR_H
>diff --git a/net/tipc/msg.c b/net/tipc/msg.c
>index b0bba0feef56..22f0274c4505 100644
>--- a/net/tipc/msg.c
>+++ b/net/tipc/msg.c
>@@ -1,37 +1,10 @@
>+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
> /*
>  * net/tipc/msg.c: TIPC message header routines
>  *
>  * Copyright (c) 2000-2006, 2014-2015, Ericsson AB
>  * Copyright (c) 2005, 2010-2011, Wind River Systems
>  * All rights reserved.
>- *
>- * Redistribution and use in source and binary forms, with or without
>- * modification, are permitted provided that the following conditions are=
 met:
>- *
>- * 1. Redistributions of source code must retain the above copyright
>- *    notice, this list of conditions and the following disclaimer.
>- * 2. Redistributions in binary form must reproduce the above copyright
>- *    notice, this list of conditions and the following disclaimer in the
>- *    documentation and/or other materials provided with the distribution=
.
>- * 3. Neither the names of the copyright holders nor the names of its
>- *    contributors may be used to endorse or promote products derived fro=
m
>- *    this software without specific prior written permission.
>- *
>- * Alternatively, this software may be distributed under the terms of the
>- * GNU General Public License ("GPL") version 2 as published by the Free
>- * Software Foundation.
>- *
>- * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND
>CONTRIBUTORS "AS IS"
>- * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
>LIMITED TO, THE
>- * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A
>PARTICULAR PURPOSE
>- * ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR
>CONTRIBUTORS BE
>- * LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
>- * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
>PROCUREMENT OF
>- * SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR
>BUSINESS
>- * INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
>WHETHER IN
>- * CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR
>OTHERWISE)
>- * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
>ADVISED OF THE
>- * POSSIBILITY OF SUCH DAMAGE.
>  */
>
> #include <net/sock.h>
>diff --git a/net/tipc/msg.h b/net/tipc/msg.h
>index c5eec16213d7..3416bf07869e 100644
>--- a/net/tipc/msg.h
>+++ b/net/tipc/msg.h
>@@ -1,37 +1,10 @@
>+/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
> /*
>  * net/tipc/msg.h: Include file for TIPC message header routines
>  *
>  * Copyright (c) 2000-2007, 2014-2017 Ericsson AB
>  * Copyright (c) 2005-2008, 2010-2011, Wind River Systems
>  * All rights reserved.
>- *
>- * Redistribution and use in source and binary forms, with or without
>- * modification, are permitted provided that the following conditions are=
 met:
>- *
>- * 1. Redistributions of source code must retain the above copyright
>- *    notice, this list of conditions and the following disclaimer.
>- * 2. Redistributions in binary form must reproduce the above copyright
>- *    notice, this list of conditions and the following disclaimer in the
>- *    documentation and/or other materials provided with the distribution=
.
>- * 3. Neither the names of the copyright holders nor the names of its
>- *    contributors may be used to endorse or promote products derived fro=
m
>- *    this software without specific prior written permission.
>- *
>- * Alternatively, this software may be distributed under the terms of the
>- * GNU General Public License ("GPL") version 2 as published by the Free
>- * Software Foundation.
>- *
>- * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND
>CONTRIBUTORS "AS IS"
>- * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
>LIMITED TO, THE
>- * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A
>PARTICULAR PURPOSE
>- * ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR
>CONTRIBUTORS BE
>- * LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
>- * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
>PROCUREMENT OF
>- * SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR
>BUSINESS
>- * INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
>WHETHER IN
>- * CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR
>OTHERWISE)
>- * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
>ADVISED OF THE
>- * POSSIBILITY OF SUCH DAMAGE.
>  */
>
> #ifndef _TIPC_MSG_H
>diff --git a/net/tipc/name_distr.c b/net/tipc/name_distr.c
>index 190b49c5cbc3..e9af08463caf 100644
>--- a/net/tipc/name_distr.c
>+++ b/net/tipc/name_distr.c
>@@ -1,3 +1,4 @@
>+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
> /*
>  * net/tipc/name_distr.c: TIPC name distribution code
>  *
>@@ -5,34 +6,6 @@
>  * Copyright (c) 2005, 2010-2011, Wind River Systems
>  * Copyright (c) 2020-2021, Red Hat Inc
>  * All rights reserved.
>- *
>- * Redistribution and use in source and binary forms, with or without
>- * modification, are permitted provided that the following conditions are=
 met:
>- *
>- * 1. Redistributions of source code must retain the above copyright
>- *    notice, this list of conditions and the following disclaimer.
>- * 2. Redistributions in binary form must reproduce the above copyright
>- *    notice, this list of conditions and the following disclaimer in the
>- *    documentation and/or other materials provided with the distribution=
.
>- * 3. Neither the names of the copyright holders nor the names of its
>- *    contributors may be used to endorse or promote products derived fro=
m
>- *    this software without specific prior written permission.
>- *
>- * Alternatively, this software may be distributed under the terms of the
>- * GNU General Public License ("GPL") version 2 as published by the Free
>- * Software Foundation.
>- *
>- * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND
>CONTRIBUTORS "AS IS"
>- * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
>LIMITED TO, THE
>- * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A
>PARTICULAR PURPOSE
>- * ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR
>CONTRIBUTORS BE
>- * LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
>- * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
>PROCUREMENT OF
>- * SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR
>BUSINESS
>- * INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
>WHETHER IN
>- * CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR
>OTHERWISE)
>- * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
>ADVISED OF THE
>- * POSSIBILITY OF SUCH DAMAGE.
>  */
>
> #include "core.h"
>diff --git a/net/tipc/name_distr.h b/net/tipc/name_distr.h
>index c677f6f082df..cd08ec9943f9 100644
>--- a/net/tipc/name_distr.h
>+++ b/net/tipc/name_distr.h
>@@ -1,37 +1,10 @@
>+/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
> /*
>  * net/tipc/name_distr.h: Include file for TIPC name distribution code
>  *
>  * Copyright (c) 2000-2006, Ericsson AB
>  * Copyright (c) 2005, Wind River Systems
>  * All rights reserved.
>- *
>- * Redistribution and use in source and binary forms, with or without
>- * modification, are permitted provided that the following conditions are=
 met:
>- *
>- * 1. Redistributions of source code must retain the above copyright
>- *    notice, this list of conditions and the following disclaimer.
>- * 2. Redistributions in binary form must reproduce the above copyright
>- *    notice, this list of conditions and the following disclaimer in the
>- *    documentation and/or other materials provided with the distribution=
.
>- * 3. Neither the names of the copyright holders nor the names of its
>- *    contributors may be used to endorse or promote products derived fro=
m
>- *    this software without specific prior written permission.
>- *
>- * Alternatively, this software may be distributed under the terms of the
>- * GNU General Public License ("GPL") version 2 as published by the Free
>- * Software Foundation.
>- *
>- * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND
>CONTRIBUTORS "AS IS"
>- * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
>LIMITED TO, THE
>- * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A
>PARTICULAR PURPOSE
>- * ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR
>CONTRIBUTORS BE
>- * LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
>- * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
>PROCUREMENT OF
>- * SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR
>BUSINESS
>- * INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
>WHETHER IN
>- * CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR
>OTHERWISE)
>- * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
>ADVISED OF THE
>- * POSSIBILITY OF SUCH DAMAGE.
>  */
>
> #ifndef _TIPC_NAME_DISTR_H
>diff --git a/net/tipc/name_table.c b/net/tipc/name_table.c
>index 253c72d1366e..b0f95a13a812 100644
>--- a/net/tipc/name_table.c
>+++ b/net/tipc/name_table.c
>@@ -1,3 +1,4 @@
>+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
> /*
>  * net/tipc/name_table.c: TIPC name table code
>  *
>@@ -5,34 +6,6 @@
>  * Copyright (c) 2004-2008, 2010-2014, Wind River Systems
>  * Copyright (c) 2020-2021, Red Hat Inc
>  * All rights reserved.
>- *
>- * Redistribution and use in source and binary forms, with or without
>- * modification, are permitted provided that the following conditions are=
 met:
>- *
>- * 1. Redistributions of source code must retain the above copyright
>- *    notice, this list of conditions and the following disclaimer.
>- * 2. Redistributions in binary form must reproduce the above copyright
>- *    notice, this list of conditions and the following disclaimer in the
>- *    documentation and/or other materials provided with the distribution=
.
>- * 3. Neither the names of the copyright holders nor the names of its
>- *    contributors may be used to endorse or promote products derived fro=
m
>- *    this software without specific prior written permission.
>- *
>- * Alternatively, this software may be distributed under the terms of the
>- * GNU General Public License ("GPL") version 2 as published by the Free
>- * Software Foundation.
>- *
>- * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND
>CONTRIBUTORS "AS IS"
>- * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
>LIMITED TO, THE
>- * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A
>PARTICULAR PURPOSE
>- * ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR
>CONTRIBUTORS BE
>- * LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
>- * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
>PROCUREMENT OF
>- * SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR
>BUSINESS
>- * INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
>WHETHER IN
>- * CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR
>OTHERWISE)
>- * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
>ADVISED OF THE
>- * POSSIBILITY OF SUCH DAMAGE.
>  */
>
> #include <net/sock.h>
>diff --git a/net/tipc/name_table.h b/net/tipc/name_table.h
>index 7ff6eeebaae6..fff7e79dd936 100644
>--- a/net/tipc/name_table.h
>+++ b/net/tipc/name_table.h
>@@ -1,3 +1,4 @@
>+/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
> /*
>  * net/tipc/name_table.h: Include file for TIPC name table code
>  *
>@@ -5,34 +6,6 @@
>  * Copyright (c) 2004-2005, 2010-2011, Wind River Systems
>  * Copyright (c) 2020-2021, Red Hat Inc
>  * All rights reserved.
>- *
>- * Redistribution and use in source and binary forms, with or without
>- * modification, are permitted provided that the following conditions are=
 met:
>- *
>- * 1. Redistributions of source code must retain the above copyright
>- *    notice, this list of conditions and the following disclaimer.
>- * 2. Redistributions in binary form must reproduce the above copyright
>- *    notice, this list of conditions and the following disclaimer in the
>- *    documentation and/or other materials provided with the distribution=
.
>- * 3. Neither the names of the copyright holders nor the names of its
>- *    contributors may be used to endorse or promote products derived fro=
m
>- *    this software without specific prior written permission.
>- *
>- * Alternatively, this software may be distributed under the terms of the
>- * GNU General Public License ("GPL") version 2 as published by the Free
>- * Software Foundation.
>- *
>- * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND
>CONTRIBUTORS "AS IS"
>- * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
>LIMITED TO, THE
>- * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A
>PARTICULAR PURPOSE
>- * ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR
>CONTRIBUTORS BE
>- * LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
>- * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
>PROCUREMENT OF
>- * SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR
>BUSINESS
>- * INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
>WHETHER IN
>- * CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR
>OTHERWISE)
>- * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
>ADVISED OF THE
>- * POSSIBILITY OF SUCH DAMAGE.
>  */
>
> #ifndef _TIPC_NAME_TABLE_H
>diff --git a/net/tipc/net.c b/net/tipc/net.c
>index 7e65d0b0c4a8..1883f1a76d6b 100644
>--- a/net/tipc/net.c
>+++ b/net/tipc/net.c
>@@ -1,37 +1,10 @@
>+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
> /*
>  * net/tipc/net.c: TIPC network routing code
>  *
>  * Copyright (c) 1995-2006, 2014, Ericsson AB
>  * Copyright (c) 2005, 2010-2011, Wind River Systems
>  * All rights reserved.
>- *
>- * Redistribution and use in source and binary forms, with or without
>- * modification, are permitted provided that the following conditions are=
 met:
>- *
>- * 1. Redistributions of source code must retain the above copyright
>- *    notice, this list of conditions and the following disclaimer.
>- * 2. Redistributions in binary form must reproduce the above copyright
>- *    notice, this list of conditions and the following disclaimer in the
>- *    documentation and/or other materials provided with the distribution=
.
>- * 3. Neither the names of the copyright holders nor the names of its
>- *    contributors may be used to endorse or promote products derived fro=
m
>- *    this software without specific prior written permission.
>- *
>- * Alternatively, this software may be distributed under the terms of the
>- * GNU General Public License ("GPL") version 2 as published by the Free
>- * Software Foundation.
>- *
>- * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND
>CONTRIBUTORS "AS IS"
>- * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
>LIMITED TO, THE
>- * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A
>PARTICULAR PURPOSE
>- * ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR
>CONTRIBUTORS BE
>- * LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
>- * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
>PROCUREMENT OF
>- * SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR
>BUSINESS
>- * INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
>WHETHER IN
>- * CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR
>OTHERWISE)
>- * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
>ADVISED OF THE
>- * POSSIBILITY OF SUCH DAMAGE.
>  */
>
> #include "core.h"
>diff --git a/net/tipc/net.h b/net/tipc/net.h
>index 1cb1e43cf34a..1c56ae964c46 100644
>--- a/net/tipc/net.h
>+++ b/net/tipc/net.h
>@@ -1,37 +1,10 @@
>+/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
> /*
>  * net/tipc/net.h: Include file for TIPC network routing code
>  *
>  * Copyright (c) 1995-2006, 2014, Ericsson AB
>  * Copyright (c) 2005, 2010-2011, Wind River Systems
>  * All rights reserved.
>- *
>- * Redistribution and use in source and binary forms, with or without
>- * modification, are permitted provided that the following conditions are=
 met:
>- *
>- * 1. Redistributions of source code must retain the above copyright
>- *    notice, this list of conditions and the following disclaimer.
>- * 2. Redistributions in binary form must reproduce the above copyright
>- *    notice, this list of conditions and the following disclaimer in the
>- *    documentation and/or other materials provided with the distribution=
.
>- * 3. Neither the names of the copyright holders nor the names of its
>- *    contributors may be used to endorse or promote products derived fro=
m
>- *    this software without specific prior written permission.
>- *
>- * Alternatively, this software may be distributed under the terms of the
>- * GNU General Public License ("GPL") version 2 as published by the Free
>- * Software Foundation.
>- *
>- * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND
>CONTRIBUTORS "AS IS"
>- * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
>LIMITED TO, THE
>- * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A
>PARTICULAR PURPOSE
>- * ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR
>CONTRIBUTORS BE
>- * LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
>- * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
>PROCUREMENT OF
>- * SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR
>BUSINESS
>- * INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
>WHETHER IN
>- * CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR
>OTHERWISE)
>- * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
>ADVISED OF THE
>- * POSSIBILITY OF SUCH DAMAGE.
>  */
>
> #ifndef _TIPC_NET_H
>diff --git a/net/tipc/netlink.c b/net/tipc/netlink.c
>index 1a9a5bdaccf4..8dc5b1daee5b 100644
>--- a/net/tipc/netlink.c
>+++ b/net/tipc/netlink.c
>@@ -1,37 +1,10 @@
>+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
> /*
>  * net/tipc/netlink.c: TIPC configuration handling
>  *
>  * Copyright (c) 2005-2006, 2014, Ericsson AB
>  * Copyright (c) 2005-2007, Wind River Systems
>  * All rights reserved.
>- *
>- * Redistribution and use in source and binary forms, with or without
>- * modification, are permitted provided that the following conditions are=
 met:
>- *
>- * 1. Redistributions of source code must retain the above copyright
>- *    notice, this list of conditions and the following disclaimer.
>- * 2. Redistributions in binary form must reproduce the above copyright
>- *    notice, this list of conditions and the following disclaimer in the
>- *    documentation and/or other materials provided with the distribution=
.
>- * 3. Neither the names of the copyright holders nor the names of its
>- *    contributors may be used to endorse or promote products derived fro=
m
>- *    this software without specific prior written permission.
>- *
>- * Alternatively, this software may be distributed under the terms of the
>- * GNU General Public License ("GPL") version 2 as published by the Free
>- * Software Foundation.
>- *
>- * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND
>CONTRIBUTORS "AS IS"
>- * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
>LIMITED TO, THE
>- * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A
>PARTICULAR PURPOSE
>- * ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR
>CONTRIBUTORS BE
>- * LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
>- * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
>PROCUREMENT OF
>- * SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR
>BUSINESS
>- * INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
>WHETHER IN
>- * CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR
>OTHERWISE)
>- * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
>ADVISED OF THE
>- * POSSIBILITY OF SUCH DAMAGE.
>  */
>
> #include "core.h"
>diff --git a/net/tipc/netlink.h b/net/tipc/netlink.h
>index 7cf777723e3e..56b395b216a6 100644
>--- a/net/tipc/netlink.h
>+++ b/net/tipc/netlink.h
>@@ -1,36 +1,9 @@
>+/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
> /*
>  * net/tipc/netlink.h: Include file for TIPC netlink code
>  *
>  * Copyright (c) 2014, Ericsson AB
>  * All rights reserved.
>- *
>- * Redistribution and use in source and binary forms, with or without
>- * modification, are permitted provided that the following conditions are=
 met:
>- *
>- * 1. Redistributions of source code must retain the above copyright
>- *    notice, this list of conditions and the following disclaimer.
>- * 2. Redistributions in binary form must reproduce the above copyright
>- *    notice, this list of conditions and the following disclaimer in the
>- *    documentation and/or other materials provided with the distribution=
.
>- * 3. Neither the names of the copyright holders nor the names of its
>- *    contributors may be used to endorse or promote products derived fro=
m
>- *    this software without specific prior written permission.
>- *
>- * Alternatively, this software may be distributed under the terms of the
>- * GNU General Public License ("GPL") version 2 as published by the Free
>- * Software Foundation.
>- *
>- * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND
>CONTRIBUTORS "AS IS"
>- * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
>LIMITED TO, THE
>- * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A
>PARTICULAR PURPOSE
>- * ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR
>CONTRIBUTORS BE
>- * LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
>- * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
>PROCUREMENT OF
>- * SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR
>BUSINESS
>- * INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
>WHETHER IN
>- * CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR
>OTHERWISE)
>- * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
>ADVISED OF THE
>- * POSSIBILITY OF SUCH DAMAGE.
>  */
>
> #ifndef _TIPC_NETLINK_H
>diff --git a/net/tipc/netlink_compat.c b/net/tipc/netlink_compat.c
>index 2a786c56c8c5..c110b9844a91 100644
>--- a/net/tipc/netlink_compat.c
>+++ b/net/tipc/netlink_compat.c
>@@ -1,34 +1,7 @@
>+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
> /*
>  * Copyright (c) 2014, Ericsson AB
>  * All rights reserved.
>- *
>- * Redistribution and use in source and binary forms, with or without
>- * modification, are permitted provided that the following conditions are=
 met:
>- *
>- * 1. Redistributions of source code must retain the above copyright
>- *    notice, this list of conditions and the following disclaimer.
>- * 2. Redistributions in binary form must reproduce the above copyright
>- *    notice, this list of conditions and the following disclaimer in the
>- *    documentation and/or other materials provided with the distribution=
.
>- * 3. Neither the names of the copyright holders nor the names of its
>- *    contributors may be used to endorse or promote products derived fro=
m
>- *    this software without specific prior written permission.
>- *
>- * Alternatively, this software may be distributed under the terms of the
>- * GNU General Public License ("GPL") version 2 as published by the Free
>- * Software Foundation.
>- *
>- * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND
>CONTRIBUTORS "AS IS"
>- * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
>LIMITED TO, THE
>- * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A
>PARTICULAR PURPOSE
>- * ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR
>CONTRIBUTORS BE
>- * LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
>- * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
>PROCUREMENT OF
>- * SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR
>BUSINESS
>- * INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
>WHETHER IN
>- * CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR
>OTHERWISE)
>- * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
>ADVISED OF THE
>- * POSSIBILITY OF SUCH DAMAGE.
>  */
>
> #include "core.h"
>diff --git a/net/tipc/node.c b/net/tipc/node.c
>index 97aa970a0d83..724fec939a85 100644
>--- a/net/tipc/node.c
>+++ b/net/tipc/node.c
>@@ -1,37 +1,10 @@
>+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
> /*
>  * net/tipc/node.c: TIPC node management routines
>  *
>  * Copyright (c) 2000-2006, 2012-2016, Ericsson AB
>  * Copyright (c) 2005-2006, 2010-2014, Wind River Systems
>  * All rights reserved.
>- *
>- * Redistribution and use in source and binary forms, with or without
>- * modification, are permitted provided that the following conditions are=
 met:
>- *
>- * 1. Redistributions of source code must retain the above copyright
>- *    notice, this list of conditions and the following disclaimer.
>- * 2. Redistributions in binary form must reproduce the above copyright
>- *    notice, this list of conditions and the following disclaimer in the
>- *    documentation and/or other materials provided with the distribution=
.
>- * 3. Neither the names of the copyright holders nor the names of its
>- *    contributors may be used to endorse or promote products derived fro=
m
>- *    this software without specific prior written permission.
>- *
>- * Alternatively, this software may be distributed under the terms of the
>- * GNU General Public License ("GPL") version 2 as published by the Free
>- * Software Foundation.
>- *
>- * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND
>CONTRIBUTORS "AS IS"
>- * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
>LIMITED TO, THE
>- * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A
>PARTICULAR PURPOSE
>- * ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR
>CONTRIBUTORS BE
>- * LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
>- * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
>PROCUREMENT OF
>- * SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR
>BUSINESS
>- * INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
>WHETHER IN
>- * CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR
>OTHERWISE)
>- * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
>ADVISED OF THE
>- * POSSIBILITY OF SUCH DAMAGE.
>  */
>
> #include "core.h"
>diff --git a/net/tipc/node.h b/net/tipc/node.h
>index 154a5bbb0d29..28da1d7025e5 100644
>--- a/net/tipc/node.h
>+++ b/net/tipc/node.h
>@@ -1,37 +1,10 @@
>+/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
> /*
>  * net/tipc/node.h: Include file for TIPC node management routines
>  *
>  * Copyright (c) 2000-2006, 2014-2016, Ericsson AB
>  * Copyright (c) 2005, 2010-2014, Wind River Systems
>  * All rights reserved.
>- *
>- * Redistribution and use in source and binary forms, with or without
>- * modification, are permitted provided that the following conditions are=
 met:
>- *
>- * 1. Redistributions of source code must retain the above copyright
>- *    notice, this list of conditions and the following disclaimer.
>- * 2. Redistributions in binary form must reproduce the above copyright
>- *    notice, this list of conditions and the following disclaimer in the
>- *    documentation and/or other materials provided with the distribution=
.
>- * 3. Neither the names of the copyright holders nor the names of its
>- *    contributors may be used to endorse or promote products derived fro=
m
>- *    this software without specific prior written permission.
>- *
>- * Alternatively, this software may be distributed under the terms of the
>- * GNU General Public License ("GPL") version 2 as published by the Free
>- * Software Foundation.
>- *
>- * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND
>CONTRIBUTORS "AS IS"
>- * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
>LIMITED TO, THE
>- * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A
>PARTICULAR PURPOSE
>- * ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR
>CONTRIBUTORS BE
>- * LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
>- * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
>PROCUREMENT OF
>- * SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR
>BUSINESS
>- * INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
>WHETHER IN
>- * CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR
>OTHERWISE)
>- * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
>ADVISED OF THE
>- * POSSIBILITY OF SUCH DAMAGE.
>  */
>
> #ifndef _TIPC_NODE_H
>diff --git a/net/tipc/socket.c b/net/tipc/socket.c
>index 9329919fb07f..ec79eb6e35b3 100644
>--- a/net/tipc/socket.c
>+++ b/net/tipc/socket.c
>@@ -1,3 +1,4 @@
>+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
> /*
>  * net/tipc/socket.c: TIPC socket API
>  *
>@@ -5,34 +6,6 @@
>  * Copyright (c) 2004-2008, 2010-2013, Wind River Systems
>  * Copyright (c) 2020-2021, Red Hat Inc
>  * All rights reserved.
>- *
>- * Redistribution and use in source and binary forms, with or without
>- * modification, are permitted provided that the following conditions are=
 met:
>- *
>- * 1. Redistributions of source code must retain the above copyright
>- *    notice, this list of conditions and the following disclaimer.
>- * 2. Redistributions in binary form must reproduce the above copyright
>- *    notice, this list of conditions and the following disclaimer in the
>- *    documentation and/or other materials provided with the distribution=
.
>- * 3. Neither the names of the copyright holders nor the names of its
>- *    contributors may be used to endorse or promote products derived fro=
m
>- *    this software without specific prior written permission.
>- *
>- * Alternatively, this software may be distributed under the terms of the
>- * GNU General Public License ("GPL") version 2 as published by the Free
>- * Software Foundation.
>- *
>- * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND
>CONTRIBUTORS "AS IS"
>- * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
>LIMITED TO, THE
>- * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A
>PARTICULAR PURPOSE
>- * ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR
>CONTRIBUTORS BE
>- * LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
>- * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
>PROCUREMENT OF
>- * SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR
>BUSINESS
>- * INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
>WHETHER IN
>- * CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR
>OTHERWISE)
>- * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
>ADVISED OF THE
>- * POSSIBILITY OF SUCH DAMAGE.
>  */
>
> #include <linux/rhashtable.h>
>diff --git a/net/tipc/socket.h b/net/tipc/socket.h
>index 02cdf166807d..4d3a31590395 100644
>--- a/net/tipc/socket.h
>+++ b/net/tipc/socket.h
>@@ -1,35 +1,8 @@
>+/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
> /* net/tipc/socket.h: Include file for TIPC socket code
>  *
>  * Copyright (c) 2014-2016, Ericsson AB
>  * All rights reserved.
>- *
>- * Redistribution and use in source and binary forms, with or without
>- * modification, are permitted provided that the following conditions are=
 met:
>- *
>- * 1. Redistributions of source code must retain the above copyright
>- *    notice, this list of conditions and the following disclaimer.
>- * 2. Redistributions in binary form must reproduce the above copyright
>- *    notice, this list of conditions and the following disclaimer in the
>- *    documentation and/or other materials provided with the distribution=
.
>- * 3. Neither the names of the copyright holders nor the names of its
>- *    contributors may be used to endorse or promote products derived fro=
m
>- *    this software without specific prior written permission.
>- *
>- * Alternatively, this software may be distributed under the terms of the
>- * GNU General Public License ("GPL") version 2 as published by the Free
>- * Software Foundation.
>- *
>- * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND
>CONTRIBUTORS "AS IS"
>- * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
>LIMITED TO, THE
>- * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A
>PARTICULAR PURPOSE
>- * ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR
>CONTRIBUTORS BE
>- * LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
>- * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
>PROCUREMENT OF
>- * SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR
>BUSINESS
>- * INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
>WHETHER IN
>- * CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR
>OTHERWISE)
>- * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
>ADVISED OF THE
>- * POSSIBILITY OF SUCH DAMAGE.
>  */
>
> #ifndef _TIPC_SOCK_H
>diff --git a/net/tipc/subscr.c b/net/tipc/subscr.c
>index 352d304c3acd..6d6c34871485 100644
>--- a/net/tipc/subscr.c
>+++ b/net/tipc/subscr.c
>@@ -1,3 +1,4 @@
>+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
> /*
>  * net/tipc/subscr.c: TIPC network topology service
>  *
>@@ -5,34 +6,6 @@
>  * Copyright (c) 2005-2007, 2010-2013, Wind River Systems
>  * Copyright (c) 2020-2021, Red Hat Inc
>  * All rights reserved.
>- *
>- * Redistribution and use in source and binary forms, with or without
>- * modification, are permitted provided that the following conditions are=
 met:
>- *
>- * 1. Redistributions of source code must retain the above copyright
>- *    notice, this list of conditions and the following disclaimer.
>- * 2. Redistributions in binary form must reproduce the above copyright
>- *    notice, this list of conditions and the following disclaimer in the
>- *    documentation and/or other materials provided with the distribution=
.
>- * 3. Neither the names of the copyright holders nor the names of its
>- *    contributors may be used to endorse or promote products derived fro=
m
>- *    this software without specific prior written permission.
>- *
>- * Alternatively, this software may be distributed under the terms of the
>- * GNU General Public License ("GPL") version 2 as published by the Free
>- * Software Foundation.
>- *
>- * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND
>CONTRIBUTORS "AS IS"
>- * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
>LIMITED TO, THE
>- * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A
>PARTICULAR PURPOSE
>- * ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR
>CONTRIBUTORS BE
>- * LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
>- * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
>PROCUREMENT OF
>- * SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR
>BUSINESS
>- * INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
>WHETHER IN
>- * CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR
>OTHERWISE)
>- * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
>ADVISED OF THE
>- * POSSIBILITY OF SUCH DAMAGE.
>  */
>
> #include "core.h"
>diff --git a/net/tipc/subscr.h b/net/tipc/subscr.h
>index 60b877531b66..0262e6589b69 100644
>--- a/net/tipc/subscr.h
>+++ b/net/tipc/subscr.h
>@@ -1,3 +1,4 @@
>+/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
> /*
>  * net/tipc/subscr.h: Include file for TIPC network topology service
>  *
>@@ -5,34 +6,6 @@
>  * Copyright (c) 2005-2007, 2012-2013, Wind River Systems
>  * Copyright (c) 2020-2021, Red Hat Inc
>  * All rights reserved.
>- *
>- * Redistribution and use in source and binary forms, with or without
>- * modification, are permitted provided that the following conditions are=
 met:
>- *
>- * 1. Redistributions of source code must retain the above copyright
>- *    notice, this list of conditions and the following disclaimer.
>- * 2. Redistributions in binary form must reproduce the above copyright
>- *    notice, this list of conditions and the following disclaimer in the
>- *    documentation and/or other materials provided with the distribution=
.
>- * 3. Neither the names of the copyright holders nor the names of its
>- *    contributors may be used to endorse or promote products derived fro=
m
>- *    this software without specific prior written permission.
>- *
>- * Alternatively, this software may be distributed under the terms of the
>- * GNU General Public License ("GPL") version 2 as published by the Free
>- * Software Foundation.
>- *
>- * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND
>CONTRIBUTORS "AS IS"
>- * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
>LIMITED TO, THE
>- * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A
>PARTICULAR PURPOSE
>- * ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR
>CONTRIBUTORS BE
>- * LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
>- * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
>PROCUREMENT OF
>- * SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR
>BUSINESS
>- * INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
>WHETHER IN
>- * CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR
>OTHERWISE)
>- * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
>ADVISED OF THE
>- * POSSIBILITY OF SUCH DAMAGE.
>  */
>
> #ifndef _TIPC_SUBSCR_H
>diff --git a/net/tipc/sysctl.c b/net/tipc/sysctl.c
>index 30d2e06e3d8c..1ce7c6dea30b 100644
>--- a/net/tipc/sysctl.c
>+++ b/net/tipc/sysctl.c
>@@ -1,36 +1,9 @@
>+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
> /*
>  * net/tipc/sysctl.c: sysctl interface to TIPC subsystem
>  *
>  * Copyright (c) 2013, Wind River Systems
>  * All rights reserved.
>- *
>- * Redistribution and use in source and binary forms, with or without
>- * modification, are permitted provided that the following conditions are=
 met:
>- *
>- * 1. Redistributions of source code must retain the above copyright
>- *    notice, this list of conditions and the following disclaimer.
>- * 2. Redistributions in binary form must reproduce the above copyright
>- *    notice, this list of conditions and the following disclaimer in the
>- *    documentation and/or other materials provided with the distribution=
.
>- * 3. Neither the names of the copyright holders nor the names of its
>- *    contributors may be used to endorse or promote products derived fro=
m
>- *    this software without specific prior written permission.
>- *
>- * Alternatively, this software may be distributed under the terms of the
>- * GNU General Public License ("GPL") version 2 as published by the Free
>- * Software Foundation.
>- *
>- * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND
>CONTRIBUTORS "AS IS"
>- * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
>LIMITED TO, THE
>- * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A
>PARTICULAR PURPOSE
>- * ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR
>CONTRIBUTORS BE
>- * LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
>- * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
>PROCUREMENT OF
>- * SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR
>BUSINESS
>- * INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
>WHETHER IN
>- * CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR
>OTHERWISE)
>- * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
>ADVISED OF THE
>- * POSSIBILITY OF SUCH DAMAGE.
>  */
>
> #include "core.h"
>diff --git a/net/tipc/topsrv.c b/net/tipc/topsrv.c
>index af530c9ed840..9346578327d2 100644
>--- a/net/tipc/topsrv.c
>+++ b/net/tipc/topsrv.c
>@@ -1,37 +1,10 @@
>+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
> /*
>  * net/tipc/server.c: TIPC server infrastructure
>  *
>  * Copyright (c) 2012-2013, Wind River Systems
>  * Copyright (c) 2017-2018, Ericsson AB
>  * All rights reserved.
>- *
>- * Redistribution and use in source and binary forms, with or without
>- * modification, are permitted provided that the following conditions are=
 met:
>- *
>- * 1. Redistributions of source code must retain the above copyright
>- *    notice, this list of conditions and the following disclaimer.
>- * 2. Redistributions in binary form must reproduce the above copyright
>- *    notice, this list of conditions and the following disclaimer in the
>- *    documentation and/or other materials provided with the distribution=
.
>- * 3. Neither the names of the copyright holders nor the names of its
>- *    contributors may be used to endorse or promote products derived fro=
m
>- *    this software without specific prior written permission.
>- *
>- * Alternatively, this software may be distributed under the terms of the
>- * GNU General Public License ("GPL") version 2 as published by the Free
>- * Software Foundation.
>- *
>- * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND
>CONTRIBUTORS "AS IS"
>- * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
>LIMITED TO, THE
>- * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A
>PARTICULAR PURPOSE
>- * ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR
>CONTRIBUTORS BE
>- * LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
>- * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
>PROCUREMENT OF
>- * SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR
>BUSINESS
>- * INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
>WHETHER IN
>- * CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR
>OTHERWISE)
>- * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
>ADVISED OF THE
>- * POSSIBILITY OF SUCH DAMAGE.
>  */
>
> #include "subscr.h"
>diff --git a/net/tipc/topsrv.h b/net/tipc/topsrv.h
>index c7ea71293748..b98c37c98738 100644
>--- a/net/tipc/topsrv.h
>+++ b/net/tipc/topsrv.h
>@@ -1,37 +1,10 @@
>+/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
> /*
>  * net/tipc/server.h: Include file for TIPC server code
>  *
>  * Copyright (c) 2012-2013, Wind River Systems
>  * Copyright (c) 2017, Ericsson AB
>  * All rights reserved.
>- *
>- * Redistribution and use in source and binary forms, with or without
>- * modification, are permitted provided that the following conditions are=
 met:
>- *
>- * 1. Redistributions of source code must retain the above copyright
>- *    notice, this list of conditions and the following disclaimer.
>- * 2. Redistributions in binary form must reproduce the above copyright
>- *    notice, this list of conditions and the following disclaimer in the
>- *    documentation and/or other materials provided with the distribution=
.
>- * 3. Neither the names of the copyright holders nor the names of its
>- *    contributors may be used to endorse or promote products derived fro=
m
>- *    this software without specific prior written permission.
>- *
>- * Alternatively, this software may be distributed under the terms of the
>- * GNU General Public License ("GPL") version 2 as published by the Free
>- * Software Foundation.
>- *
>- * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND
>CONTRIBUTORS "AS IS"
>- * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
>LIMITED TO, THE
>- * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A
>PARTICULAR PURPOSE
>- * ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR
>CONTRIBUTORS BE
>- * LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
>- * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
>PROCUREMENT OF
>- * SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR
>BUSINESS
>- * INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
>WHETHER IN
>- * CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR
>OTHERWISE)
>- * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
>ADVISED OF THE
>- * POSSIBILITY OF SUCH DAMAGE.
>  */
>
> #ifndef _TIPC_SERVER_H
>diff --git a/net/tipc/trace.c b/net/tipc/trace.c
>index 7d2931521e0e..e052e59dfb44 100644
>--- a/net/tipc/trace.c
>+++ b/net/tipc/trace.c
>@@ -1,36 +1,9 @@
>+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
> /*
>  * net/tipc/trace.c: TIPC tracepoints code
>  *
>  * Copyright (c) 2018, Ericsson AB
>  * All rights reserved.
>- *
>- * Redistribution and use in source and binary forms, with or without
>- * modification, are permitted provided that the following conditions are=
 met:
>- *
>- * 1. Redistributions of source code must retain the above copyright
>- *    notice, this list of conditions and the following disclaimer.
>- * 2. Redistributions in binary form must reproduce the above copyright
>- *    notice, this list of conditions and the following disclaimer in the
>- *    documentation and/or other materials provided with the distribution=
.
>- * 3. Neither the names of the copyright holders nor the names of its
>- *    contributors may be used to endorse or promote products derived fro=
m
>- *    this software without specific prior written permission.
>- *
>- * Alternatively, this software may be distributed under the terms of the
>- * GNU General Public License ("GPL") version 2 as published by the Free
>- * Software Foundation.
>- *
>- * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND
>CONTRIBUTORS "ASIS"
>- * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
>LIMITED TO,THE
>- * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A
>PARTICULAR PURPOSE
>- * ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR
>CONTRIBUTORS BE
>- * LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
>- * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
>PROCUREMENT OF
>- * SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR
>BUSINESS
>- * INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
>WHETHER IN
>- * CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR
>OTHERWISE)
>- * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
>ADVISED OF THE
>- * POSSIBILITY OF SUCH DAMAGE.
>  */
>
> #define CREATE_TRACE_POINTS
>diff --git a/net/tipc/trace.h b/net/tipc/trace.h
>index 865142ed0ab4..47656cb64c67 100644
>--- a/net/tipc/trace.h
>+++ b/net/tipc/trace.h
>@@ -1,36 +1,9 @@
>+/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
> /*
>  * net/tipc/trace.h: TIPC tracepoints
>  *
>  * Copyright (c) 2018, Ericsson AB
>  * All rights reserved.
>- *
>- * Redistribution and use in source and binary forms, with or without
>- * modification, are permitted provided that the following conditions are=
 met:
>- *
>- * 1. Redistributions of source code must retain the above copyright
>- *    notice, this list of conditions and the following disclaimer.
>- * 2. Redistributions in binary form must reproduce the above copyright
>- *    notice, this list of conditions and the following disclaimer in the
>- *    documentation and/or other materials provided with the distribution=
.
>- * 3. Neither the names of the copyright holders nor the names of its
>- *    contributors may be used to endorse or promote products derived fro=
m
>- *    this software without specific prior written permission.
>- *
>- * Alternatively, this software may be distributed under the terms of the
>- * GNU General Public License ("GPL") version 2 as published by the Free
>- * Software Foundation.
>- *
>- * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND
>CONTRIBUTORS "ASIS"
>- * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
>LIMITED TO,THE
>- * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A
>PARTICULAR PURPOSE
>- * ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR
>CONTRIBUTORS BE
>- * LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
>- * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
>PROCUREMENT OF
>- * SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR
>BUSINESS
>- * INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
>WHETHER IN
>- * CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR
>OTHERWISE)
>- * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
>ADVISED OF THE
>- * POSSIBILITY OF SUCH DAMAGE.
>  */
>
> #undef TRACE_SYSTEM
>diff --git a/net/tipc/udp_media.c b/net/tipc/udp_media.c
>index 2c66b356025a..b2aeb63ad48f 100644
>--- a/net/tipc/udp_media.c
>+++ b/net/tipc/udp_media.c
>@@ -1,35 +1,8 @@
>+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
> /* net/tipc/udp_media.c: IP bearer support for TIPC
>  *
>  * Copyright (c) 2015, Ericsson AB
>  * All rights reserved.
>- *
>- * Redistribution and use in source and binary forms, with or without
>- * modification, are permitted provided that the following conditions are=
 met:
>- *
>- * 1. Redistributions of source code must retain the above copyright
>- *    notice, this list of conditions and the following disclaimer.
>- * 2. Redistributions in binary form must reproduce the above copyright
>- *    notice, this list of conditions and the following disclaimer in the
>- *    documentation and/or other materials provided with the distribution=
.
>- * 3. Neither the names of the copyright holders nor the names of its
>- *    contributors may be used to endorse or promote products derived fro=
m
>- *    this software without specific prior written permission.
>- *
>- * Alternatively, this software may be distributed under the terms of the
>- * GNU General Public License ("GPL") version 2 as published by the Free
>- * Software Foundation.
>- *
>- * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND
>CONTRIBUTORS "AS IS"
>- * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
>LIMITED TO, THE
>- * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A
>PARTICULAR PURPOSE
>- * ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR
>CONTRIBUTORS BE
>- * LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
>- * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
>PROCUREMENT OF
>- * SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR
>BUSINESS
>- * INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
>WHETHER IN
>- * CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR
>OTHERWISE)
>- * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
>ADVISED OF THE
>- * POSSIBILITY OF SUCH DAMAGE.
>  */
>
> #include <linux/socket.h>
>diff --git a/net/tipc/udp_media.h b/net/tipc/udp_media.h
>index e7455cc73e16..8b92aef7246a 100644
>--- a/net/tipc/udp_media.h
>+++ b/net/tipc/udp_media.h
>@@ -1,37 +1,10 @@
>+/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
> /*
>  * net/tipc/udp_media.h: Include file for UDP bearer media
>  *
>  * Copyright (c) 1996-2006, 2013-2016, Ericsson AB
>  * Copyright (c) 2005, 2010-2011, Wind River Systems
>  * All rights reserved.
>- *
>- * Redistribution and use in source and binary forms, with or without
>- * modification, are permitted provided that the following conditions are=
 met:
>- *
>- * 1. Redistributions of source code must retain the above copyright
>- *    notice, this list of conditions and the following disclaimer.
>- * 2. Redistributions in binary form must reproduce the above copyright
>- *    notice, this list of conditions and the following disclaimer in the
>- *    documentation and/or other materials provided with the distribution=
.
>- * 3. Neither the names of the copyright holders nor the names of its
>- *    contributors may be used to endorse or promote products derived fro=
m
>- *    this software without specific prior written permission.
>- *
>- * Alternatively, this software may be distributed under the terms of the
>- * GNU General Public License ("GPL") version 2 as published by the Free
>- * Software Foundation.
>- *
>- * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND
>CONTRIBUTORS "AS IS"
>- * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
>LIMITED TO, THE
>- * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A
>PARTICULAR PURPOSE
>- * ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR
>CONTRIBUTORS BE
>- * LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
>- * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
>PROCUREMENT OF
>- * SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR
>BUSINESS
>- * INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
>WHETHER IN
>- * CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR
>OTHERWISE)
>- * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
>ADVISED OF THE
>- * POSSIBILITY OF SUCH DAMAGE.
>  */
>
> #ifdef CONFIG_TIPC_MEDIA_UDP
>--
>2.43.0
>


