Return-Path: <netdev+bounces-303042-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id p/tFGcGFQ2oxaAoAu9opvQ
	(envelope-from <netdev+bounces-303042-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 11:00:49 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 64EB26E1DD3
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 11:00:46 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=est.tech header.s=selector1 header.b=UsDepvCB;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303042-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-303042-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 92AD7301A913
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 09:00:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3759C3E5A14;
	Tue, 30 Jun 2026 09:00:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011038.outbound.protection.outlook.com [52.101.65.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4622D3CF95E;
	Tue, 30 Jun 2026 09:00:39 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782810042; cv=fail; b=bmWNfgTzWSvUD2MMKEdxPeTFSa7zW2GXcoEuWk1oWcPCS+P7rJZ6tfts4AoIVbUFoFmvzLf+QM6hFaZHjFR86r0B2DfX63GjSukDE6De0HbK8taZKtQ39DBDOKG/+mLEP9jCPwT2Rn6U9mqS1LikLvWm9JBJKcBN80Y30UQ/6ko=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782810042; c=relaxed/simple;
	bh=LwBGST8dl8u+7vZdF6lzUlaJYpK4SqHHAI+3l4faYV0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=WL0Z5LYLhg6iPGmkyvXPIyWss/FTwc4S6BOousXDglqSj1SL4swLCcRrlhZh8OnprCBRV/GzFbBDq1cG5zZ3EhNbZKQa+VxPb9tWAWJygLIZLMPfaYhFKxC7wcCLbf0zqbyTlir/lXH0ZkaJzFQZ5RWPF/D0U8AdIdKzk2g2Pok=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech; spf=pass smtp.mailfrom=est.tech; dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b=UsDepvCB; arc=fail smtp.client-ip=52.101.65.38
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xfrf6DHddTpQ6eJ4zACRJGOnb/E6+I8p6HsWDGOlDzXzeKyf73a/ALJVnA4JyCAFQg8a6xuei3ZFzAGdzGEOFPF6befhyi7jLXf5CgtAJGwq8HXgasnM0UcxjH+FBx/A8XuwpAjSHBRXPq6rG/2CbspNK+GIWdYiUqyc0aVKJpxsM7H7vFb4EzhPxUg2+wfMmhFcQCEjEdNSbxfxTC3XFT0G3J5KwxWO3PZUF8rOCucm0NDyc473HFdZTYex2olJa6x/xu8cHSquvxuO/Ks98x4xk5RIsXvzt+yfg56b/B2tLXvfy1fnMnC/x5vxslUwmN6C785ec2y0AQ9BkQ8fNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6wXPlZs2sjuifqdiRdvyiTEzzUIjDTIsqgyhcpf0eno=;
 b=yhoqLY1WjcIWXpnD3nHQvMzs4X10/E0/PxmKr5UpYiiGh4N7osgiV25UcXb7B64x5cECDgv2hV38zbsNJZsdbHWeWaYF7SAPrjeGBC3/g7HvMoFygy7PSW5aPE/7osmkrECN30ZfOijkaF76fhhhql0HgrKVMr9d1ilL8jzMnORv/1dMvkBiX2ptKAK5T9JlPiKXAt7Bu23rcoWYNLnQX7TwKhpcM0XcgdO3qkL3NhNSWtZOFETa/eS7wav5uGe9RFmSmWYo2e+YB6d0LWCAQ6eqL+0zS1ioJjqw517AemLPZUmVc6sFehhn7PY3/z/2fyuCQ+bWAQ8crEpqBz9SwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=est.tech; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6wXPlZs2sjuifqdiRdvyiTEzzUIjDTIsqgyhcpf0eno=;
 b=UsDepvCBQB673wkGgMuFN78QyHnEXWdBFlOdKbc1x6ouDRMprGPKIU4bPboMM7JWu4Nm5q9z2owKFPG+Rju8p+aabBWGs/xtRB5dkv7oasZR90gvjUFNLXrdAYD9CzXKfbLZPwhdvc/cVRnj/2Ly6UfuVZdMXneLaJmwwXUDfZyEK0uZzTR+u1g/cA9F4/KTFI4UWZf/31Em3S94yAlmJEbX8NvR6hlBCH6rSI5hLS/HJCX++7zQyiD4ubYJnBMVJWAwNmarvLWLF59vXCuDmOhlGPmYlsQdZlCV4TTg/X7H4SPElFRb9J/8T240O7gvEZCMgs/Bn5cEoYRII0NXPw==
Received: from GV1P189MB1988.EURP189.PROD.OUTLOOK.COM (2603:10a6:150:63::5) by
 VE1P189MB1136.EURP189.PROD.OUTLOOK.COM (2603:10a6:800:16c::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.19; Tue, 30 Jun 2026 09:00:33 +0000
Received: from GV1P189MB1988.EURP189.PROD.OUTLOOK.COM
 ([fe80::bfff:5391:8a49:21b7]) by GV1P189MB1988.EURP189.PROD.OUTLOOK.COM
 ([fe80::bfff:5391:8a49:21b7%6]) with mapi id 15.21.0181.008; Tue, 30 Jun 2026
 09:00:32 +0000
From: Tung Quang Nguyen <tung.quang.nguyen@est.tech>
To: Markov Gleb <markov.gi@npc-ksb.ru>
CC: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"tipc-discussion@lists.sourceforge.net"
	<tipc-discussion@lists.sourceforge.net>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "lvc-project@linuxtesting.org"
	<lvc-project@linuxtesting.org>, Jon Maloy <jmaloy@redhat.com>
Subject: RE: [PATCH net] tipc: make sure bc_rcvlink is not dereferenced with
 NULL value
Thread-Topic: [PATCH net] tipc: make sure bc_rcvlink is not dereferenced with
 NULL value
Thread-Index: AQHdB8zujMI0mdhj30iuXUhVwXt5d7ZWyu0g
Date: Tue, 30 Jun 2026 09:00:32 +0000
Message-ID:
 <GV1P189MB1988D6818E45C9FB69874E4CC6F72@GV1P189MB1988.EURP189.PROD.OUTLOOK.COM>
References: <20260629130942.469-1-markov.gi@npc-ksb.ru>
In-Reply-To: <20260629130942.469-1-markov.gi@npc-ksb.ru>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV1P189MB1988:EE_|VE1P189MB1136:EE_
x-ms-office365-filtering-correlation-id: 63b77816-9b50-422f-c17c-08ded6860ab7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|23010399003|18002099003|22082099003|11063799006|56012099006|38070700021;
x-microsoft-antispam-message-info:
 DA1wfXbkph0DGRppYhw/D934h1vggnEYVMbaEvtOAUTDMO+t2JIQojRIBcC7QWazYgtSBBr6i4i0TpZuU8c16lVbpuQUHpaPp9Pdk2gG7dulNIlKSj3GJc/r77rgWmIrrbgXLtxBhevbJQKXb4qXNP49sl4maeFJE0mNLWXrTDeATsspw4jg4ml2+i2XkX29eqsYnlT5MqvTA/SEgYSKvrZCBfX8qtOctLEJ7bpjK80yV6vA63F/uCU24l1NmnT82NCJWBiFXhMEOYHul7UbBtbL/K/Xa+OeDDQph+hqx3qvBdE8R//d07siGLmy/DK3k9O+EhmuucwtrLFpwN9Xszuw8DVFsTo0BP4TawVw+3JqwRpDnP2bgU2+da7zBKqgFTnKYYBeHqqzEa2p2UeFUNT3X45Fcif6K2IqUZ93Mx8KyaV8gcNwGr5s2YbS087pHpc6g5JxaI3aio8d/+SptlD6aTBYNAsHp4jdwI1w8YzbQVl/tLzh1pCHOx3P1CEwHBHLdjerQlX24vV1pW9BpbHix3uIdPcR+dmydjAVTsMU6s8HnMEH6hcutlyYniuTkwtXTAc1ClYiZ4hTNY6rab3Cax0iOdLelN3ImvyZ+Lb0W+A9MdJjmZHz+BOrQTW0F6SQImCcH/gN+oOu+Tm237sG3ONtd8S32uKqH5ms4MU/XlxWB7rK759reuHJ+pf5ARfxYzitlvVaFoyPvtkl7VaTND2psp7z1HUhzMF0NJo=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1P189MB1988.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(23010399003)(18002099003)(22082099003)(11063799006)(56012099006)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?p1Fwe9dTo8D8Ui9biCybhGfbgnlaZJT46YEUKlRuV0A3ve26/4CuX109dsWi?=
 =?us-ascii?Q?29JLwD28xuT6PkhA0A+jI0jTdRa0SQ6MjvqhhhTrkMyH7dyKgS6nib+sf275?=
 =?us-ascii?Q?tZlZTXYuhXcDPmfmDVzzqqsG5VuRhyvLK/bK4BAo6te6/pUhKzHTyqVj7RQs?=
 =?us-ascii?Q?xagAZ7OhfLR89hA1zTak7NM78B+kktzzaPN+eKONgDfFXsHUGV3k/fJQp+ns?=
 =?us-ascii?Q?QLjOVRrvrlDk+pZdlJrPuhT6802tS4NyQXoHitvVVKeD2YwBFgS+Pn/WVb0w?=
 =?us-ascii?Q?EyJu8WNhOgw+KjJhXxk7kwuYCHvT0Ba0VyFS5apRKpOp6LV22hweo/I2t8wt?=
 =?us-ascii?Q?c0M+qWBfGqIzkTjeBc97ylqFitvcW84Z3ED+6sUDMfY5xPIYoyq/+6kukksK?=
 =?us-ascii?Q?p979SJtCSS4pBVHZ+HvvMLoJnHQq29JLJg3J7x6lYgIECyjxrHNakOODurd5?=
 =?us-ascii?Q?55lIlyiCnmVYEyBYkYJNHx9uhaVYVFo1Z+RPcXLwcWyQMaUrVRGGp3IkChU5?=
 =?us-ascii?Q?H2va5csLmQ5zJxl7kj8EI4DU0izT9KB+UfQf9A3ynn9ehORXa+cw6IZcN8Ow?=
 =?us-ascii?Q?xiTZE0GPlJPEJpvz/6ob2nn+hl9bVujtoMMb3nJFtXT14Jt7J3K2cyXTRhIw?=
 =?us-ascii?Q?xMV1pA+MWCg7HfvW7zkAEScDrPBn0CFT5hJTiuY24xZpUVRZEjzswN5zx4vH?=
 =?us-ascii?Q?1ZndrC+TLTKR3uGzyGsA0dQrdUUJ0d9Nx+q5cEzpAv98/niKhzc6teulfYl8?=
 =?us-ascii?Q?5/zVgt1w6c5ycO0X34m4rCYu/NxlCQD5GbvHCwjUwjdh6/CzK1001ADxLzY+?=
 =?us-ascii?Q?YiiP05wFauakLyqnQKNidnIzwnp+c2ahoJjz1AyrGhK0P7NC843+sev1YH/q?=
 =?us-ascii?Q?ApIrbYBTJHRFRQbPbV+Ku05IQHHuKUbVIw2yiW6YVKJiRQYlVzSfkSCHaMiY?=
 =?us-ascii?Q?Kn0/iwhiNOF5ifXMbAr5O3HGdi6gICOq0OVK1h+/bBhJmYUJkV6AiUaIrOO3?=
 =?us-ascii?Q?s5PRFSpiCgfVGX4yhg6WMwmOAdRGL9o8T0FmkZqSXi4FOCLt1R1EInXhr/3k?=
 =?us-ascii?Q?jUpCgcB/dejbwvtpkTxplFmAPe31ix5IV8Kac8dU0GRT1DqFFcZjM/8AYv7u?=
 =?us-ascii?Q?vNb2Hqn2ZymuLNqh6RBlCng4p7TiHsxfrYjiExLAaUdtK9/cB6Awz7hadnO8?=
 =?us-ascii?Q?e2mh2pop+Kk8L3xodRqBM7P3iM96urXep7D8xDtEQvXS1g7FtXj3oVyYa9wL?=
 =?us-ascii?Q?vHQbmRie2rS9deG0/ulqXwbBUoRLGrfYzxBa+3IDaD31zMjYsrO11tKW84GC?=
 =?us-ascii?Q?jZjuqAt+ia2+J/MVlWC1ymqixw10kyWPifC/mkXXusWvMxVobS4gcB3KV25T?=
 =?us-ascii?Q?J+/Vf48LWPOWOInOxerxwlWsMiJxKa//f+qXVeJtovsS/hMeGBOVqDx8cueN?=
 =?us-ascii?Q?TvKm3kSjD3GGVkRKsU9u/PdOzXW5AzCRJrtoJ1TWu78NcGyl5viWHGXm54jT?=
 =?us-ascii?Q?qTUh/rVa5D/Izu517gCDM4hQP87c1Ntr0A/lId8k2nKocf86QPD5LgWtWQvF?=
 =?us-ascii?Q?PcISIaTXfw1fQwGHv+wt5B/sAZFFYiDy6089ZiLxJa+hYa8aVnofY401kbLy?=
 =?us-ascii?Q?3Y1gbDUvvRZwcdKJVzX6JKNbRu7JjQMJ/i+7JrA+W7DDQnblomDNPTmDp9RV?=
 =?us-ascii?Q?RGHzvmmBZ/i5NHm1Yx65Tm/fcepC2Kn2OhNh58HPuD+CW0aZsw/EcHiJYlHT?=
 =?us-ascii?Q?FlCfvNEHoQ=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 63b77816-9b50-422f-c17c-08ded6860ab7
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jun 2026 09:00:32.6791
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: H+XDfR7SfN79SghrJ+S0GmqThEblZp3WO9GYbF7aP1/DxuP2Q69AMxTrVBLgWH5KF9Am7nYPPROMyPtNXlliVJTWh+V0klzgoFStWwpmY68=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1P189MB1136
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_DKIM_ALLOW(-0.20)[est.tech:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_NA(0.00)[est.tech];
	TAGGED_FROM(0.00)[bounces-303042-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:markov.gi@npc-ksb.ru,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:tipc-discussion@lists.sourceforge.net,m:linux-kernel@vger.kernel.org,m:lvc-project@linuxtesting.org,m:jmaloy@redhat.com,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,npc-ksb.ru:email,linuxtesting.org:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 64EB26E1DD3

>Subject: [PATCH net] tipc: make sure bc_rcvlink is not dereferenced with N=
ULL
>value
>
>From: Gleb Markov <markov.gi@npc-ksb.ru>
>
>The direct dependence of the tipc_link_is_up() value on l->bc_rcvlink is n=
ot
>explicitly specified.
>
>If link is up, it is assumed that the sender and receiver have valid value=
s
>(communication with the receiver is required for timeout synchronization),
>which is not guaranteed in this code segment.
>
>Turning independent conditions into nested conditions ensures that NULL
>cannot be dereferenced at tipc_link_build_proto_msg() and allows for the
>logical structure to be fixed at the functional interaction level.
>
>Make tipc_link_build_proto_msg() call only if l->bc_rcvlink is not NULL.
>
>Found by Linux Verification Center (linuxtesting.org) with SVACE.
>
>Fixes: 047491ea334a ("tipc: set link tolerance correctly in broadcast link=
")
>Signed-off-by: Gleb Markov <markov.gi@npc-ksb.ru>
>---
> net/tipc/link.c | 8 +++++---
> 1 file changed, 5 insertions(+), 3 deletions(-)
>
>diff --git a/net/tipc/link.c b/net/tipc/link.c index 49dfc098d89b..b0a640c=
419c8
>100644
>--- a/net/tipc/link.c
>+++ b/net/tipc/link.c
>@@ -2863,10 +2863,12 @@ void tipc_link_set_tolerance(struct tipc_link *l,
>u32 tol,
> 			     struct sk_buff_head *xmitq)
> {
> 	l->tolerance =3D tol;
>-	if (l->bc_rcvlink)
>+	if (l->bc_rcvlink) {
> 		l->bc_rcvlink->tolerance =3D tol;
>-	if (tipc_link_is_up(l))
>-		tipc_link_build_proto_msg(l, STATE_MSG, 0, 0, 0, tol, 0, xmitq);
>+		if (tipc_link_is_up(l))
>+			tipc_link_build_proto_msg(l, STATE_MSG,
>+						  0, 0, 0, tol, 0, xmitq);
>+	}

This is not correct and redundant because:
1. ' l->bc_rcvlink' is non-NULL for any unicast link. Checking of ' l->bc_r=
cvlink' is even redundant in current code.
2. Checking of 'tipc_link_is_up(l)' does not depend on ' l->bc_rcvlink'. It=
 just verifies if the unicast link is UP to populate the new tolerance to i=
ts peer.

> }
>
> void tipc_link_set_prio(struct tipc_link *l, u32 prio,
>--
>2.43.0
>


