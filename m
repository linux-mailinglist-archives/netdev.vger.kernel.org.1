Return-Path: <netdev+bounces-263627-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eFBGNx/gp2lnkgAAu9opvQ
	(envelope-from <netdev+bounces-263627-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 08:32:47 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4175C1FB9EA
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 08:32:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 23AB83024130
	for <lists+netdev@lfdr.de>; Wed,  4 Mar 2026 07:32:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5235036AB75;
	Wed,  4 Mar 2026 07:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="W39isyUG"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010068.outbound.protection.outlook.com [52.101.69.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F245E30649C;
	Wed,  4 Mar 2026 07:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772609561; cv=fail; b=IxU66HXA/x91rwEmI7IUVvRLaTtzbaooxj7sbfG3znr/5EHrm1Hm6A3BA31YBxFJcTEiuCZWCDU8WguzSUzf778OemOoZFjNnlPd8Qjlf0lRzugoowLw0vec5LpCfkIHEjo6QQQX9iB06rZuKggnOteOeleHgTogGQ4/LIiCx58=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772609561; c=relaxed/simple;
	bh=+BaDke9Eb4Ly0OlxjCZuPTELg2hQoQrqEtKAm19PfZs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=OgXvv172j3I/tSnTtZ+NKVL+c4EeHt9uYsyE3bj3OdP90Qd5D3gbBL2dtryaMbc+vVZdYQEfS/t3SyvkYwognW7EbUwk/COFpIJ3ttloSIXnq0Qr+Kh9vDMb018gFHQCeSMkyUrywsCtW+h+ONolaqsL+ENF8daphUu8KS/u550=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=W39isyUG; arc=fail smtp.client-ip=52.101.69.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LZkCBVeSD+Ym+SxbUiudZmOQ4svMZVq8gJMfdSo8GL6Cl1cvP/+PcJZVqKZR5P2/AFitYXxoNeQ6sMzdqlfi1DKbWBxg9PPueSElglSsUW/lZW0cNTCe7NOHBemKy57G+4uytOlSxoYXGo/I69PwokKQN1TJV7ak+E8zaQ9IqLB46s5OL0OaOHy3kbivQGHpLR1e3fT5FIPHmFZPnbnKh6C9t0NA0ZzKd1+4h7MFeiqkckCrS7VtAuA5Td4YV1bOYim1jz1W8dLVre+rvdYo/c2Rl1JpU9/Uu+o/Ao0GpTMNtOyYzUMQ8yFh6cEpGK+RW9bSnGEgjN9AzAG1cU0wHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4zx7RQd1cChKKd3BgM3N+fgQfJCK7qHbgJ/xIwVKflU=;
 b=dC85x1C4i10wCyPLtiV6etDNFNoz8QQ6xbeYgCxWrshmG/pNx1xddLyzDVmJXSirS5Qgm2CSSsSCIXQ7zhTMMwwIDR1BF9lN8swOVbx9to76o+rYpreS9Dvmcs6xVXBOH0/oKLarHyVz3VOaLvcfM7Ww+TL+/sqZwf4gKv0yDqr5fH4Vtsy0d+JAfjy/yKhGOvFUuWSbNRppUao4M14ugOlW5RvzT7btfzXyk1Z7EKqtmviYU/K+9HlvM+MOnLIwhKs8HSf/Nu82SeR11slZu9YuyoOW1ZFYN55s20qUP+CAHfyj1Ubjiu0iIIIwQSow0jWSMqpTkzllcud43q+3eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4zx7RQd1cChKKd3BgM3N+fgQfJCK7qHbgJ/xIwVKflU=;
 b=W39isyUG7YrAviGGC0kfvlwgFdV4iI7aG79Gtw/zm5skjTAYRTP2BYnOkzV7cbgBYgXRv+2sEowt9TER5iFe3OLlOyq93Awyx0ZqLN4pAKdKZ1NCFA6ODRKfsV0ys5HUJ/ouQvJCOup4VkQZE/XuJcBYG7491wCgWDWhdVRR45OsEAfWEiW8jRK8/JOR8BqpLOd9L78errxnLq/+pgeo8NDpbT8aX6qfiVZjgnLcn56x7UqeujOoCeq2r1UGNWw2z32EhQgjvyUksCGJZtdVnKXZcbTCxiXBaUiCg646WbInxTqqT753s1gL5/TxMILWqcRutlVBOSF8fF2g20u7mA==
Received: from AM9PR04MB8382.eurprd04.prod.outlook.com (2603:10a6:20b:3ea::11)
 by VI2PR04MB11076.eurprd04.prod.outlook.com (2603:10a6:800:279::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.17; Wed, 4 Mar
 2026 07:32:35 +0000
Received: from AM9PR04MB8382.eurprd04.prod.outlook.com
 ([fe80::f02b:c2a0:7fd:6d63]) by AM9PR04MB8382.eurprd04.prod.outlook.com
 ([fe80::f02b:c2a0:7fd:6d63%3]) with mapi id 15.20.9678.016; Wed, 4 Mar 2026
 07:32:35 +0000
From: Clark Wang <xiaoning.wang@nxp.com>
To: Wei Fang <wei.fang@nxp.com>, Claudiu Manoil <claudiu.manoil@nxp.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"alexander.stein@ew.tq-group.com" <alexander.stein@ew.tq-group.com>
CC: Aziz Sellami <aziz.sellami@nxp.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>
Subject: RE: [PATCH net] net: enetc: fix fallback PHY address handling and do
 not skip setting for addr 0
Thread-Topic: [PATCH net] net: enetc: fix fallback PHY address handling and do
 not skip setting for addr 0
Thread-Index: AQHcqviOpjbtGSL300qey6gG6/Ti/LWd7xXA
Date: Wed, 4 Mar 2026 07:32:35 +0000
Message-ID:
 <AM9PR04MB8382C3FED0AFF56F67D8653CF37CA@AM9PR04MB8382.eurprd04.prod.outlook.com>
References: <20260303103047.228005-1-wei.fang@nxp.com>
In-Reply-To: <20260303103047.228005-1-wei.fang@nxp.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM9PR04MB8382:EE_|VI2PR04MB11076:EE_
x-ms-office365-filtering-correlation-id: 86896b7c-dadc-443a-e772-08de79c034b1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|19092799006|1800799024|38070700021;
x-microsoft-antispam-message-info:
 pEuKf4VEwbxk7FkixyYQ74oD3p9gcXZ+nhMHpjCdqdZ0oU/8M74y3rm2YpVrYQJfvVVzHVJvpbZKnA9hu4HOTJP+IfQbt1fy++G634v+IBiCjfwnU7eXY1vsfalMwU7l/Du3FTH3aurlta/sYzQluWtRC5eh35+POQGnBLtftUvmB8A7Ir+fY3R4HWEAwHnIQJ1TVoFxiT9GV63THvQfFdr8xCJbSrbe2X1Vc1fjn8bvK1O5aVOBBsmks/dup6CNvX/pNU7Dei0cZALF1FpuMPgEXmD/P+GHFxxWJXI9WP0Hpa+KM64Na3kg6I9ZazT2565X0J1Px6GmOmfrANizH8KExnCkEtl99Je5mAdpih6imfe10EiMfnaSqGriYHAcewqSEIowZQYVvmO/zQIz25gMzheZ36pGGcc8xb1W+pvtec7q3utuUgkxWEdvKxAwUpj66Ighd48mjqj7EabKtDcxpIL2okVMq/pSOVBHwc3VFfOkHj9OYGpjBb7AIKJpwRqp5zXaEhbPaWLY5BF3ktKewW4QPy0DNUdXCCFzIGqSz4hRNNmq20JJ8p2twgWZfqGw1KTXHrpxWGapMId/GKVask4n9iWx/u/VtF+m/9Q9ncVtNNr1rfcM15g6gxDhVubnbK8+/nBDNg9VQjBS/v58e8CIEZB8JzKydThBtNUqyVQOl2AnY3QhUdVuzVfFdqYN5M8KLRznav6xjykTfl7FdsxMcAaRwgZFBH9fdPYIf/xvIhcZChL9hJbo8fUKZAJR+nogdPCcRnH15yIF2qrnZe26e72vN3j/tFcZl4k=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8382.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(19092799006)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?C5132dqlLreiMIiH7fKmuOkp6MXELpNLZwIujtk/VBEQ2J1eZXybABKGiJd/?=
 =?us-ascii?Q?SH3uml57L4whPkv4wMHRx0WFW5wUlZ5ms2jfmnU5sbOqUHkAYhYFs1nSG1+5?=
 =?us-ascii?Q?5Nx6ZQrOuGbY8vP72bBdCeoVsoZf2bUjHYtuMA22X96aO/cvt2wQNjPPWXMZ?=
 =?us-ascii?Q?pk36Rm57G8/f0JoxyFb7Fog85ZF5AOqCPjMdWKUnQGjKl9RO4REl6PWqKln3?=
 =?us-ascii?Q?1y+EzOQQ8rR0w9QjzWY+f/+7CH3WZBQsqx5LWlNZz4wAAmlSCKhXEzwsLAWY?=
 =?us-ascii?Q?oyneOu54Nr9TGaEuKIGCvIwSdOG1l2W7/ZF6MGkQBgEk39PTJIn7jOX2qleG?=
 =?us-ascii?Q?l4erXKoW1VLohEw1d0nYkWR5JOdcT5JDilhrYwGX6TDCY1/3nKGxD2+sdy6q?=
 =?us-ascii?Q?/myVXZF+wjPrcyxm5sHAZtmIUvfO9BQt5l1rC6Su962LdRP+g0raf5/gRE8B?=
 =?us-ascii?Q?iHGyRgs0DAUQ2lbB+gAW/pBeQ69S4qpF27loaLTj+GOKUtWr+wAOLekmTXZW?=
 =?us-ascii?Q?09r/qdezhJJiF03MQcgpwtsAYaW3qolsNK0JKP2VpS/FmGysRlcQNZjVEkNW?=
 =?us-ascii?Q?PnNfOy9yEoeoJBNarYOxVyGyPQc7vq2uFXONHqo4veo/9qUekOPR9LGQT2o9?=
 =?us-ascii?Q?CMFVL9eMpHpBLlNoLk6onKDGZmf6rz8R+Ln+94NdF1HhgNpyUGD57Grcx8Je?=
 =?us-ascii?Q?8xBopC0R2xj4/ly7BSNe+XKbQ9AeWi1drrd8zD0VtNTbBDCrKLSVRTEoQ6Ml?=
 =?us-ascii?Q?IPcJxYKbM2yrOgT5N54Rc2/bFrhnOFIr/tC7IIzDv5WAw9f7ddAu8hhWxOUZ?=
 =?us-ascii?Q?s0RPiM1kwm9TkzLXrqj9fO3N4VTR2wUO1zTbLaAWYF2uFLJ/3X3OcvTMPz4m?=
 =?us-ascii?Q?+q5aDhdaxSbU32NK4UDqyXLMBFgg/QYrN25AkE+Wq9SgQ/jGhBaux5zDtUdk?=
 =?us-ascii?Q?Xpd+/VZz0alvUoNqz2ejsxmxaL0/zTGPd2GsGFfCNuI3B8htmZp4Xvid1tsp?=
 =?us-ascii?Q?2Hp7PDXn/B6yis+kgUP5HBBxv76pkvN6sIhUEk3fGH5CDmiMk7a80VGDWZcj?=
 =?us-ascii?Q?+VD2W2wIu3rAI7wddZ/hejJatfmak4KnWqIoHzSqpR70ZiRn4mKOifUO7O6r?=
 =?us-ascii?Q?d+mUVXHB7WH4Kn0nHTNf+r+mqYzehtBk9VfuMu78T+njBF7Ve1y1v9KwwSqi?=
 =?us-ascii?Q?IVmaIiTIqT7vkdoxvA9e829nX/CWJC4hwvfJIYqr3iDOzR+PMGo1zvrMFgGc?=
 =?us-ascii?Q?HxvKH1VNIVpZPcHRTkcBx8oVn4T+ycS2U+y0yUkkl4E3s/uFhUqe3+rq9o+m?=
 =?us-ascii?Q?X/0ugmQJ98oPXRLQZnvGMp2k1iz3BkuJA918OifBGJopn68+3OXeEC8pPdaa?=
 =?us-ascii?Q?tHaVe9kGU8d90ic0AVtJXECMjjTwG2KJjGJOztoCd+EmZi4PFbHeF3LzkP4G?=
 =?us-ascii?Q?CkYN8560SxC7AKY6mizSKIVUEq15AeIQoESg9dke/74c0t/pDcTLB2s8wwrY?=
 =?us-ascii?Q?5aJ3h1kD9c4jcnbrG90Tfsn2o/QbMxSJwfEMm7Twy2lIeyH42bM11HG/3CND?=
 =?us-ascii?Q?69XOhhvPBpk+X21NSJiIJ5822b60xqxtEw4fLYEYaVYG2ZALFSHvf6ev8I3C?=
 =?us-ascii?Q?mCiQuD6duHBT157qMMFo1joqtLTi+gjSA98iUbju7G2+raRlSnDvPt5nUFTa?=
 =?us-ascii?Q?s2V631n6P44PFRUXMny3EKTXncCKjTdpq9hMmGBE82tB2pKRoUkKegAIRy1f?=
 =?us-ascii?Q?EPxcQbIGeQ=3D=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8382.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86896b7c-dadc-443a-e772-08de79c034b1
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Mar 2026 07:32:35.7315
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fDfEVswATKepS+qZUPhkapo/Sbzm8K/f5NqgqKvRgsg1U9MyyXvCKDnodOFdUjxG3tWrZ7V21WX0GXSDruuzpA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB11076
X-Rspamd-Queue-Id: 4175C1FB9EA
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-263627-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[nxp.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xiaoning.wang@nxp.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,nxp.com:dkim,nxp.com:email,tq-group.com:email]
X-Rspamd-Action: no action

> The current netc_get_phy_addr() implementation falls back to PHY address
> 0 when the "mdio" node or any PHY child node is missing. On i.MX95, this
> causes failures when a real PHY is actually assigned address 0 and is
> managed through the EMDIO interface, the bit 0 of phy_mask becomes set,
> leading imx95_enetc_mdio_phyaddr_config() to return an error, and the
> netc_blk_ctrl driver probe subsequently fails. Fix this by returning
> -ENODEV when neither an "mdio" node nor any PHY node is present.
>=20
> Given that some platforms may use PHY address 0 (I suppose the PHY may
> not treat address 0 as a broadcast address or default response address).
> It is possible for some boards to connect multiple PHYs to a single
> ENETC MAC, for example:
>=20
>   - a SGMII PHY with a non-zero address (selected via DTS_A)
>   - a RGMII PHY with address 0 (selected via DTS_B)
>=20
> For the case where the ENETC port MDIO is used to manage the PHY, when
> switching from DTS_A to DTS_B via soft reboot,
> LaBCR[MDIO_PHYAD_PRTAD]
> must be updated to 0 because the NETCMIX block is not reset during soft
> reboot. However, the current driver explicitly skips configuring address
> 0, which leaves the hardware in an inconsistent state.
>=20
> Therefore, remove the special-case skip of PHY address 0 so that valid
> configurations using address 0 are properly supported.
>=20
> Reported-by: Alexander Stein <alexander.stein@ew.tq-group.com>
> Closes: https://lore.kernel.org/all/7825188.GXAFRqVoOG@steina-w
> Fixes: 6633df05f3ad ("net: enetc: set the external PHY address in IERB fo=
r
> port MDIO usage")
> Fixes: 50bfd9c06f0f ("net: enetc: set external PHY address in IERB for i.=
MX94
> ENETC")
> Signed-off-by: Wei Fang <wei.fang@nxp.com>

Reviewed-by: Clark Wang <xiaoning.wang@nxp.com>

Thanks!
Clark Wang

