Return-Path: <netdev+bounces-306053-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id PeN6FHxBT2rpcwIAu9opvQ
	(envelope-from <netdev+bounces-306053-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Jul 2026 08:36:44 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A2CC72D39B
	for <lists+netdev@lfdr.de>; Thu, 09 Jul 2026 08:36:43 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=est.tech header.s=selector1 header.b=cNcWthWs;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306053-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-306053-lists+netdev=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 868D03049FC6
	for <lists+netdev@lfdr.de>; Thu,  9 Jul 2026 06:33:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 069853D3CE2;
	Thu,  9 Jul 2026 06:33:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013005.outbound.protection.outlook.com [40.107.162.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C4E13D3D0C
	for <netdev@vger.kernel.org>; Thu,  9 Jul 2026 06:33:37 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783578820; cv=fail; b=DiQ3oQkDt6sjpKGsYrab4WDIT2gHKL6ag99Mt+1nB0/IZLz5JZ/bT7lylIW0TEAkOZaqWn0ohRO3Vk1wz1q91tJgD8mswS3ysg/r3iIc5sRzBOxyPVI49FEuyP1yQasCRkEMzLo9sx6oqCQgi8YheffLtSO3SEa7hzIkCwI1+wU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783578820; c=relaxed/simple;
	bh=j8uBsNQ4+qJpHPHVOXv+VfaoRNACsHsCEQQ0g4b3OK0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=YWCGTsISF0uBB2fhJdUVnesnRWTJWOFDAvvgpNo5tsT7H3f0GHtW3JKV+18kzCqdhxcyHmaatFzRIoreeZEG4435twA3RLwTbDycKLt4pOWQTTxOTPcFcmNYEFV6dR7om0AtFkTt2DtkRfnBwwILfiotFwNvpApBk06vRgEbtcY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech; spf=pass smtp.mailfrom=est.tech; dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b=cNcWthWs; arc=fail smtp.client-ip=40.107.162.5
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fofvni7WgsdI6ibj7Xf/QHWVwxkQIybAvtx5bwk9gO3eBNyeDKhH17BnPQUuytEvmhMG31OBgjyeEjeCShE/QK/p3ETx8eE7mbiIQ1/1X6Ua8aQdHRSBgmPg5liIYAbuSHmYJRq+4dsBLXZlL1A/RngUC5gNQkFwBwQT/uh4T6F0OJnsERMgNa1K0uo2DIQd7i7chndGVdK8jv/gt4ndlglUfQT+cQi7jboMm+4Tiq4cYBOK0AirDAw3RC3pmEX7aUxoT0+glqWdnYfXN25i33pL5PUPtCjS4MI0bxeQn09fj9dNO+Dji8us4UQo5zTF0jI8JIqfTsT+6Ynxp+qvYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8F7Myo7urtcGekxwwq/I3yeJtCGE+HnL1UklTquj6OE=;
 b=TIy0+dpAjHMKXZY42zjbMg8fHjT+/IPlgSQ/Szrl6GTZxyJS5IUytryZlIwTv9vgwUVRp+SDNBmJth2nfKgqVVVPkUuEGd1XPytuQL4lnuTP28Donivd+b2jKJpTnJe2SCf/3wSYTGwDRDu7gbM9rFLNLfkO2lrxRixo1Vlyi7hAeWNLd0z1LX8AXnak50jTPmrJir84KOfo4cgxhYZc6R9nLHbmnF75GrsBUFE7flIikTv/G87BonXyocdMuMtUDJGFTcHPvWe3F8vI0TcUbgdjkqyHcAK4vd9bI+sJ02VphuBKrAFu71zVttzmpVR8yZgZ1zRRCTVV2MNtvCbgkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=est.tech; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8F7Myo7urtcGekxwwq/I3yeJtCGE+HnL1UklTquj6OE=;
 b=cNcWthWsYKRxuW92PAS/FBgRL7lYomVwtiRYxV5txC2QTiTueXtljyiW9hEXfgTI72fyVmZSpCm8V0I5d8FH+7t6cpC9+6VeE1KNJ93Jtb1gbtOi5QGn4kk5gqBosre0mK2tUtMii8cKP2sHS8jTkzOaYg3GJa/9SxlOz53ZTTnusQb8lQB+55G9G2OxcZ9NAkG0SGfsU3Ckl2ljRp6kN7QtarjpDnRvNdwBLtNcCYjcJ62GqummxMvcJ8CjC28hI/3BboWje37KGrrkvaioT5Ws+J2DHjIbz3FiNCr6RBAoPh0sSCgx/HBN3dF8z/L3asPWFSg1ZaSypWDHxeBgBw==
Received: from GV1P189MB1988.EURP189.PROD.OUTLOOK.COM (2603:10a6:150:63::5) by
 AS4P189MB2134.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:519::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.11; Thu, 9 Jul 2026 06:33:34 +0000
Received: from GV1P189MB1988.EURP189.PROD.OUTLOOK.COM
 ([fe80::bfff:5391:8a49:21b7]) by GV1P189MB1988.EURP189.PROD.OUTLOOK.COM
 ([fe80::bfff:5391:8a49:21b7%6]) with mapi id 15.21.0181.010; Thu, 9 Jul 2026
 06:33:33 +0000
From: Tung Quang Nguyen <tung.quang.nguyen@est.tech>
To: Weiming Shi <bestswngs@gmail.com>
CC: Xiang Mei <xmei5@asu.edu>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "tipc-discussion@lists.sourceforge.net"
	<tipc-discussion@lists.sourceforge.net>, Jon Maloy <jmaloy@redhat.com>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, "David S . Miller" <davem@davemloft.net>, Simon Horman
	<horms@kernel.org>
Subject: RE: [PATCH net] tipc: guard against empty buffer list in
 tipc_node_xmit()
Thread-Topic: [PATCH net] tipc: guard against empty buffer list in
 tipc_node_xmit()
Thread-Index: AQHdDvgRr26QDNc4+0aHW85v4iB7BLZkui5g
Date: Thu, 9 Jul 2026 06:33:33 +0000
Message-ID:
 <GV1P189MB1988683F0940A1DC37094256C6FE2@GV1P189MB1988.EURP189.PROD.OUTLOOK.COM>
References: <20260708161324.2954113-2-bestswngs@gmail.com>
In-Reply-To: <20260708161324.2954113-2-bestswngs@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV1P189MB1988:EE_|AS4P189MB2134:EE_
x-ms-office365-filtering-correlation-id: 4cdda995-51a5-4fb8-9482-08dedd83ffbe
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|366016|23010399003|1800799024|376014|56012099006|6133799003|11063799006|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info:
 EbQehTNpym+v2RGMdWGvR6d0edOnWkf/wdOBARDB+rxEmeZceZdxohawC1XD73XHBCWmuOB5M/vGPbVCqz++W83TrKLy2BxtfcAsnZVCFEXr8LZjLfmPailQaQQYLg8SiB2t9KH8VKKB1yrRGBNYGtc0M+XSVWLwyT8mWSfB2mtVjfVWqVX3Aazg94jBUW8pJyMeHMovxBQEOANjhQVjyCxziwPruz8pHVzFnoahmxKJWGgrCM/zNiqD8cnT6Qi9070zNRkiBfGKaOmrWGSefzMdxuasd/QWhI6CD5WrE7xQQVz83J0iQxGH2rk+x9cCDvpDCocu1kl5xbO6R9SIUjjeUBU5ubuLuyCIyC4CS56p8M5yTWfHwx/607wHQ4p+H1ApjLvnEoSUMcDS2pfqKfuP/o5G7BhWrizA7DRRiN1RmX/QfF1IktXQToZA8bBBztsN/8l1lnqcbzLnaRI+OvUGMLCrGXPZ1YM4fwvwar7xGHrh0kvc1Qnrgk6j92cLa69YOwWUXVcL+4OXmSiXUOfbwg/0XEIrxq9Xpf2op3SoiDFsZ0koS36sAUIvWeo6ZsiVUuSjDZb4860+jUwsiIgeCFuk0wgdGdsfNxxBQaWWOH7+N4j0RMQlqRHOSWur7zuuhX1I/31RrWiO0gr3VyU5mrdfRC2x/w5KtkWy5EnkgdsyTohXm7XZGV6vy/E4SzFIRcD07+Q2PzRhUq+dBmYQEdJ69rHiNkOkcmERx3Q=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1P189MB1988.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(23010399003)(1800799024)(376014)(56012099006)(6133799003)(11063799006)(18002099003)(22082099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?iAfggH+TC+nCLj4gGvSSS1gw9rttm1JZSuIqvEnKx1hUMaToZHZ+PBkf+Nca?=
 =?us-ascii?Q?y1WO4tDIYqJP3fB8UmO6vCXh7OCyYHyR5jR5ri0hleSyRXClbWppH9YHvjZ9?=
 =?us-ascii?Q?ie+PXwdbjfRh6g3J98mAD0pmiR1HBhsohcNAKJgt+ljwAf5hoZOo9+V7kRZ2?=
 =?us-ascii?Q?VpuhOZgEymV9gc25xniKXONBWeGx7qzEpt/yW4yUOiuE8WxED/7l5FclvTtV?=
 =?us-ascii?Q?qNRm7YZgPKxyvFnwSGFYkC+8vwTKsjqjyVJBvEj/tyoDb60061LYoVeOhuyy?=
 =?us-ascii?Q?HJu+vFnAsXTt8sSa/HkyKDRuAMxHotDJzYI4x45tLYIWNd8ptTFJ4bVVP94P?=
 =?us-ascii?Q?Kf6C2E2iaFUCQsoukn2KMINYrVzya/tA+WdWsNaFySmU4LEGtnJ2qq5YKLKF?=
 =?us-ascii?Q?uZ0MXFEczduYzBehoqL9pCKek7+TO5eFTCcmvL1vMd8P10SXSWpPqY/qG2F/?=
 =?us-ascii?Q?9sxKrcTPcUbuqf6sEIgS2VfLvElFI35WNlFcU1si3F6hJcPQVJZJel+kaxPZ?=
 =?us-ascii?Q?gMfa1Poymv3tzBNOBekbWYIUSPnYJHaGeO9kzSOdagonxcWGHAkyTr5iowFb?=
 =?us-ascii?Q?FxdgJxJ+BOlo3ea8NZo/DGLW1napnBPc0EXLk4hXe51GurVUn2K2n6J1xkL6?=
 =?us-ascii?Q?tYQtCr5JV2HuSfi6mTANwQu693tl2gcJSR2HTrDRBH0kDVwYEZLP1IcLAD7w?=
 =?us-ascii?Q?IdLwR7kN+Kb4oDfBs++GhhRsj1D/sUyiBfypsS7peJKog8Qs9RmPbMmLFpMb?=
 =?us-ascii?Q?jgBJSUFkdm0sDXd5j4slLduM/+VrKrNOB8YSrHvnbmARw3wgH/jyyezvUYa1?=
 =?us-ascii?Q?Qyq7UMvr/NYUMjDj3jGzIJDhDF/+himeAtTEwXqLgWOuRKbbuwC+IkBujxPP?=
 =?us-ascii?Q?r0xSXE4JcItpAqqsTU97jRCOjr/B1j/IjfY9rS+124AP2tu97q2T2RjQL06a?=
 =?us-ascii?Q?rfv5EFGiObFmawx0wfSPtN38k8k5fqwsIPvzbLYB3DjWIs/es9pn7+3A0d+p?=
 =?us-ascii?Q?/B1Ae4ONKqDSzCmjBHE67yBf/tFq3OMrWS2O/CgfA2hpo4kF9CCrMu3luAxa?=
 =?us-ascii?Q?oydeT6AdurxN9y/j9hASHAo+vx5SrZoqYX66cS3jpXsnGo/VdeHiWQ4yv5lc?=
 =?us-ascii?Q?SlHC2k0iTaX5KKeY/TFK3fxeLL+lrHxPwyN8FLC7XBy7f6RqwZLmPRhGsdmF?=
 =?us-ascii?Q?+7lQ3Ix+qJPCd8+Q4+/FccWrAL1PbxqXoBDJ4JVlY5SKjrghGYW1oMn8NpWG?=
 =?us-ascii?Q?g4/Hesh8gsdOKy9E/dfl704rItH3VGBlHFxhoWq5FP0cmQFk2tkoWyqcdjiZ?=
 =?us-ascii?Q?R48/fGAwa1hHvsa1htf5J01DKYm0179WWzN3W6egmZwV7NeAHr0MY0YKTcKq?=
 =?us-ascii?Q?ynAeYsOiBP1XgZGrVaoqdQLvhcT+pKxTN6TnIgZ57SXcIvLtyjySmTND4YyU?=
 =?us-ascii?Q?V5D6vbYjmvM3BzfAPmXjEmNzWYoNQo57BpMBysyJmiC5GfMZV8a+LrNWAP34?=
 =?us-ascii?Q?Z+2lbt18D/xP7ytGBMkDbmfEzPpRFWZ6WH5RbbM1bMcJYRZU5kUv4aMThgDE?=
 =?us-ascii?Q?inSi/ugylRqIdf1DCMPJcsDvK79emUv4VFybhXtG93jIU6ohcpJ/LB6i0Ovn?=
 =?us-ascii?Q?qEuzklcjv6t5Vj9G3b9Pae8Ye6YB857Hq6VnRHEhGYs7PUq59LjMPJMTdYOi?=
 =?us-ascii?Q?OXbJsi065HEXeENwYz6jW5lTwSUBsdcoJhzUzvwUGLgIH1ODQUpw+XNE6n/c?=
 =?us-ascii?Q?3PnN8ZmmXQ=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cdda995-51a5-4fb8-9482-08dedd83ffbe
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jul 2026 06:33:33.3131
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4KbK/B4I/FK9dfdS7BFU/rdIPD6ZsH9rnLFLHR+uGtGSzsHo613CCNfAcH3ZKcYXWrQ7j12eYhFcGbnhRYB5Wd19XzD+q2sKG2Yn6i4i8dA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4P189MB2134
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_DKIM_ALLOW(-0.20)[est.tech:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER(0.00)[tung.quang.nguyen@est.tech,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:bestswngs@gmail.com,m:xmei5@asu.edu,m:netdev@vger.kernel.org,m:tipc-discussion@lists.sourceforge.net,m:jmaloy@redhat.com,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:davem@davemloft.net,m:horms@kernel.org,s:lists@lfdr.de];
	DMARC_NA(0.00)[est.tech];
	FREEMAIL_TO(0.00)[gmail.com];
	FORWARDED(0.00)[lists@lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-306053-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,GV1P189MB1988.EURP189.PROD.OUTLOOK.COM:mid,asu.edu:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9A2CC72D39B

>Subject: [PATCH net] tipc: guard against empty buffer list in tipc_node_xm=
it()
>
>tipc_node_xmit() dispatches a buffer list either to the bearer path via
>tipc_link_xmit() or, when the destination node lives in a sibling network
>namespace on the same host (n->peer_net set), to tipc_lxc_xmit(). The bear=
er
>path returns early on an empty list, but tipc_node_xmit() does not, and
>tipc_lxc_xmit() dereferences the first buffer without checking:
>
>	struct tipc_msg *hdr =3D buf_msg(skb_peek(list));
>
>named_distribute() can hand tipc_node_xmit() an empty list. It bails out e=
arly
>when named_prepare_buf() fails its GFP_ATOMIC allocation, leaving the queu=
e
>empty, and tipc_named_node_up() then calls tipc_node_xmit() on it
>unconditionally. On the intra-host container path skb_peek() returns NULL =
and
>msg_user() reads through it.
>
>The TIPC configuration ops are flagged GENL_UNS_ADMIN_PERM, so an
>unprivileged user can reach this via
>unshare(CLONE_NEWUSER|CLONE_NEWNET).
>
>  Oops: general protection fault, probably for non-canonical address
>0xdffffc000000001b
>  KASAN: null-ptr-deref in range [0x00000000000000d8-0x00000000000000df]
>  CPU: 0 Comm: ksoftirqd/0
>  RIP: 0010:tipc_lxc_xmit (net/tipc/msg.h:202 net/tipc/node.c:1629)
>  Call Trace:
>   tipc_node_xmit (net/tipc/node.c:1721)
>   tipc_named_node_up (net/tipc/name_distr.c:223)
>   tipc_node_write_unlock (net/tipc/node.c:428)
>   tipc_rcv (net/tipc/node.c:2189)
>   tipc_l2_rcv_msg (net/tipc/bearer.c:670)
>
>Return early from tipc_node_xmit() when the list is empty.
>
>Fixes: f73b12812a3d ("tipc: improve throughput between nodes in netns")
>Reported-by: Xiang Mei <xmei5@asu.edu>
>Assisted-by: Claude:claude-opus-4-8
>Signed-off-by: Weiming Shi <bestswngs@gmail.com>
>---
> net/tipc/node.c | 3 +++
> 1 file changed, 3 insertions(+)
>
>diff --git a/net/tipc/node.c b/net/tipc/node.c index
>8e4ef2630ae4..cd05269e5335 100644
>--- a/net/tipc/node.c
>+++ b/net/tipc/node.c
>@@ -1695,6 +1695,9 @@ int tipc_node_xmit(struct net *net, struct
>sk_buff_head *list,
> 	int bearer_id;
> 	int rc;
>
>+	if (skb_queue_empty(list))
>+		return 0;
>+

Most callers of tipc_node_xmit() prepares a non-empty list before calling e=
xcept tipc_named_node_up().
So, it is not optimal to add this check in tipc_node_xmit().
I can see this issue needs to be addressed as part of your existing commit:
https://patchwork.kernel.org/project/netdevbpf/patch/20260706163024.1205930=
-2-bestswngs@gmail.com/

Please update above patch.

> 	if (in_own_node(net, dnode)) {
> 		tipc_loopback_trace(net, list);
> 		spin_lock_init(&list->lock);
>--
>2.43.0
>


