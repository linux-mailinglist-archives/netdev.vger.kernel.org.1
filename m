Return-Path: <netdev+bounces-271861-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oORCOKDSxGmw4AQAu9opvQ
	(envelope-from <netdev+bounces-271861-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 07:30:56 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5966732FD86
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 07:30:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6C9B930A8F26
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 06:28:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE8043B52FC;
	Thu, 26 Mar 2026 06:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="QEAI0F/Y"
X-Original-To: netdev@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013005.outbound.protection.outlook.com [40.107.159.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EDC73B4EB1;
	Thu, 26 Mar 2026 06:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774506467; cv=fail; b=LlkLS/NDYNOIRiOLuECi/Cds2l0H+3MRanAymKTvVkCbTKNE7VjNc6BTcys1hBzlyNj72mW2xR1X/aRb40NsoDOhuR3UmcieKa80PxDCwOD5n5qOp6auA/6KT8rhDbaADdr9MIQh0iUT1yLxuqJoDFgFNuh2G/VjfU6MiGkX/GI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774506467; c=relaxed/simple;
	bh=NNeGu1ta4yzus4+vX4tY6Kuk36CDRu/N03fWOjxvs38=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Wb3ql7QdQI3b6VZ34gC9bDnrZ5E/myxCiEu8RS4oGFaambYCMikLYfjtTELFFR7iLQ1DHG0PWIPncO/nHsAb75YQU9wymeKLpJL95wuGAFEJaFY3LbO6Y3c1YRQBApGd17wS23+gDIlsOyzoLEPifhDywYokJLhhTfzvrBW5s6Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=QEAI0F/Y; arc=fail smtp.client-ip=40.107.159.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qNxzHhO1WClnOBu8Hb+FzDwFDbZ4VsJnZ6KeTkd14bm8VmfzFGDila2JhQdNIvP6Kk3hFNtOIsJYI49/xrIEFPnwYrs0nYwfFncQZNdJmRhgo1EwySMKOuZYt0PdOpso56Dc13Y9ZdRJcz4o1pkAJynxxvTHgjvSHXEkEwlSnUinOmismskwUYrA8C5zHuiMJEq/6u3AXAOw5acsiax3EbT/5hzGNy69FHXMKfNEnYUcZt4/DSAeR5brlMF7lG2bRn22YW29yAMJDLDCZmVFpLvXno2YAN29jG0EFh7ztWZRvV2rDWW5q7keauzTWuK7g7piGnLUIrsQI4+6DfQzGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tziJeOEw/BS+e7YU+4V7x/VXYezCf1g2NlxkGwA58ng=;
 b=M4QZrx2bUrkI+KwnL8CS9v26kW9vUXY3aZYoUYoBBeJjRPGTPvMD1EB+0dm5voA2Wk3424gDk3mXi8OeFNDStD7qzKjzn+dzLFO6rdnMi+EgPJHD0+7WYX6A8nnLHWZDq8g7qTJ9+Oejjx4r92/+sc95BQ81nz8Wi6Kg0nsKbho4qoQTUNnzFSF1q6hU4ua39ceweyCK0G90nDZ6oXfsmfEwSdrQT4OuUkRqqZJe8xbxmtq7Y34glY/2Us4B4qZhMT/gIZffvHTyWyDjmgS0+SeF5MSuA83GwWGE9mz2HXeyvwYWKEo8uwQQ4oq8Ym/SXo6nV0GErWNySMTzH7yCgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tziJeOEw/BS+e7YU+4V7x/VXYezCf1g2NlxkGwA58ng=;
 b=QEAI0F/YHxoYinAOgTrEq1nDprGDIwD9kJHKkiXujM44fDaclAKcjkRHCtFXwSEl2DWaRPMH45pl9dfsJCfpoi2le7mlz9NPeJV7uqZfmvL/Rn/BmzlS3gdmRMoGuR9y69LLA4SW7/USdmGHdZ7UpUHtqnWSjd4MtaawiybeIMghENpTA1GhmmGl7+/KI/O35E2NilIZU+Ga1tvNBRdDHppO3JBWXVYR4sxmAvT/QSMIEtqM6OaNkXQDvGbNHXWcR7nDD3FyntzV/N/3rrQUQXVXvHdWwtlOZv+jlImC/YOLk1Wda0ICsVJMY++3rsuaN6CdpIE9Y93SsxKb1dCqhg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by PA2PR04MB10309.eurprd04.prod.outlook.com (2603:10a6:102:41f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.31; Thu, 26 Mar
 2026 06:27:42 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::b476:c19a:24cd:3694]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::b476:c19a:24cd:3694%3]) with mapi id 15.20.9745.019; Thu, 26 Mar 2026
 06:27:42 +0000
From: Wei Fang <wei.fang@nxp.com>
To: claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	f.fainelli@gmail.com,
	frank.li@nxp.com,
	chleroy@kernel.org,
	horms@kernel.org,
	linux@armlinux.org.uk,
	andrew@lunn.ch
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev
Subject: [PATCH v3 net-next 03/14] net: enetc: add pre-boot initialization for i.MX94 switch
Date: Thu, 26 Mar 2026 14:29:06 +0800
Message-Id: <20260326062917.3552334-4-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260326062917.3552334-1-wei.fang@nxp.com>
References: <20260326062917.3552334-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA5PR01CA0046.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1d6::15) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|PA2PR04MB10309:EE_
X-MS-Office365-Filtering-Correlation-Id: eb17e2ef-039e-48df-3839-08de8b00c90e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|19092799006|366016|52116014|921020|38350700014|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	W+c92oseSDAglEGejr4KcCO10hXkZewzQptCq1F79BaWDl+C4jcNjwxyWAzGj17vG5sODrDnKsSyiusZaA9H8P+c1kwIkelSfMbnG12IjX1dQR9ceLd+T86NaczdhrjpLwF5w3hDiEclB/uKJMO8yjInt3xAfDACaLbL45AMofkanvOnUlP8RuM48T4E2h7OiTa2UmnkHv9peF+jLyZhdUiJcgjFwJsutu51gJVe2pHjqAVk312ySTQEcEifTRPSGiu5x75vw5n/FWRCHYs82sEiM+REcaTjOETr0sAkmJIPIzpDWH5GNydt7OPJQpxciUOfqn27B0JKa81Ctfw5/Hzt7JBhbX3UqJtW9XGaEjlS8Mmg14OZksb896sVH9QfYvboDXsEbotvsmnPSzOLf8qQm4CCfalVsgFlncGHVmYBm6ZCRhFZLPXMaZEz/4vYomPi6SU1taQutVrSPxq3M4LBZV9IkQncod9L7OsuAN+dh1lpEuAe7LN82WxiRRUqbmCZb2m7l0UmTiIHh1jzXUmUuhU3kp83sTdzcwhGIocRicIgLDWS0xpTdQ4fvzuQN1bd2W9vPIgIt8NkS6I0L4UAB6WMMYQrXSnHP2iBZeRIC9KgF2cAFM1UU0dK+kSw2TFTnt9pyP5XcBGuKNFpyrRHWBZhE9L2sCU8zi8vrJzwiykN3XoFCJesy40N5WCVndHsBFq4OfFffrQCjV8glHDJ0yajYi+/G83GkUP4EBbOmtPViRDIc6XXdlkf4MiOENQVdknJjqNm2O+eQGErJWSzmCXikxr0D1zRO39iQO4SyNEXgkGndX+8KmRmNIJt
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(19092799006)(366016)(52116014)(921020)(38350700014)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fQiiLcN9IUJHNF+TsWhU2M9cEwx0xGOpE8C6tAHPG+K7xo3E8GP5UeLZfDnr?=
 =?us-ascii?Q?iISIEVCD5cmB3pXPyoYAvqt8iVdk4mvtR5aaL+UK7InCR4jxAvZlJPiRtX13?=
 =?us-ascii?Q?5BoOGjPaqZaV7E3+TnMVy5JXEyItqHEQ6BzzN2D/btp+jOsZFZgK3EUsM7Tq?=
 =?us-ascii?Q?uORbC5HdWo0WyXqzzbdlJOCEfuZIwJRWOR37rSTu/zsIe/HMFWDmy4h3GsjW?=
 =?us-ascii?Q?qTzffdRnm0lWzYwojJLZQ2uWgf85e2ovcSCdMtqxYNVEsY1p7rgjQifGm7fx?=
 =?us-ascii?Q?Uzn1dYmf/Dutf6kvTxUpfoKVyA70pUt/KFthcgYBqInCM8eLHN9x2ErSzPxr?=
 =?us-ascii?Q?JNs4vYw2oBJjQaCOVbPp6z7XCmTOCdJz0E/LXTjk0SjWuI7NhzeaRsGoYB9s?=
 =?us-ascii?Q?LVLcVi0ywdq2E9RBfFQMpCWDwG/p/ppOmsyJGLbISlhVPiS2PloUJig8hPZ6?=
 =?us-ascii?Q?lHOoo7NLbGFJ3tVFCKbrG8l1Sn9MJj2wY4DM8PI7a96EJ50Vgy8VMDD2KfFS?=
 =?us-ascii?Q?o3O7d/68ddPnNGNoTcOe2XdwWnxe/YNtXzrOdOAhL6j70YaZx6tZSQM+Gdrm?=
 =?us-ascii?Q?XLV7Ok4DJlro9oOA3BnHwu09Fprkmsr+MDKhvRYwWdVZP7EMVqrnCjO8xXle?=
 =?us-ascii?Q?hA7u0lGLyFg65zcHQtjYLCmG1kc6ZfxYSvV/FqZqeUaujqLXhIl5soMOv3GW?=
 =?us-ascii?Q?Rcgi+4veN6ZzrxNncxWul8DOBsswnJQcGVVBOxoEplJ4sqh/7a+woyXhP8N1?=
 =?us-ascii?Q?n6HJ52/6dJFtevp0uzVcGxIUD8D2tTq67P5Gc3btE0r8neecMr05+6tZlg1U?=
 =?us-ascii?Q?dP2iZaVSJ/i7uFwAyLlcmfc8idX6XYHKbgMBH+co8yOTeMxnubVWUtOguCcp?=
 =?us-ascii?Q?H5sf9wez+0xF2kjnJd9RzhInCs81b6tEEu9Dx5er7MUMq6DLyO9lEoFOduBf?=
 =?us-ascii?Q?jeGi0rSE8gSkHFo7Xl2iaWfnfu1yFfo3NwSIEvguYcVmtwjfDfkDkYSPrgmN?=
 =?us-ascii?Q?GPeypEbGPFCQpIHHh5gJ8Pdf9HrxSR3bUjfe0nSWmjD+7XTg5xFz92FiuSXH?=
 =?us-ascii?Q?s/iTh/j0cNJtu3YPNIqSMAltUro910hQ5Z2mLgLNk35GAaetPfXhvu6dAtVI?=
 =?us-ascii?Q?J3GDq+wM/znweDhvyIF2NeR7EpwU/T+jDeWLykKglh95vyy3qB4aas9tLyXG?=
 =?us-ascii?Q?UKiPrpJKB0qS34kvrJuJBJYMVNjLKhWHHAh0F/P+AAIoA6FBhkecMiGXC/1q?=
 =?us-ascii?Q?dsAV395EYVXpFek/Oia0u7ISX/hVjTFuSGe2qsx58Asul1reqclSAwyy9BcX?=
 =?us-ascii?Q?qaKXIdH+XSKaajD6dL/eqNnDYSyemTcdJGvDPUhx9G66oIPjkIrwWVGf/WAV?=
 =?us-ascii?Q?hJjOCbfgQ7Gzaa0bzqTD6MWd/M18LSNLcWY25niAgL/25eO6oksvk29aZK30?=
 =?us-ascii?Q?EmabjCw1z+rl43/h7doXw3YlYI3u7qpihTayNZmx6RXEOlbGeyNtiFHAtpji?=
 =?us-ascii?Q?xvLH8Lwqw42O0WZw7WDslHJwrdbcDeiYxHWtsKOclCIFblp6o4ByYnju7Y/z?=
 =?us-ascii?Q?CwFQMr0yarjwhOXyIj1jLnyXDUdt4DZKfJuy9gtIXKhgUjynvrCuNvhFfeaD?=
 =?us-ascii?Q?KksXykx3zJxBTz46I7j6C1PhjTY9yaWiHIQbORHu52gk5nVR4EoY3n5zDoAc?=
 =?us-ascii?Q?FnnALxJGqFDV9C7YprfLdLKVCYtyLc1cFfeZvvJaQdmI4qV0?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb17e2ef-039e-48df-3839-08de8b00c90e
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2026 06:27:42.4606
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m+1ivN+IDKye9ms9W+eCpz6ML94pMfz9BOIyoeBkLS07mZBM2ibte76p0oFYOELd3MewoG+a7/GSxhah6ELWVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR04MB10309
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[nxp.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,armlinux.org.uk];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-271861-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wei.fang@nxp.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nxp.com:dkim,nxp.com:email,nxp.com:mid]
X-Rspamd-Queue-Id: 5966732FD86
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Before probing the NETC switch driver, some pre-initialization needs to
be set in NETCMIX and IERB to ensure that the switch can work properly.
For example, i.MX94 NETC switch has three external ports and each port
is bound to a link. And each link needs to be configured so that it can
work properly, such as I/O variant and MII protocol.

In addition, the switch port 2 (MAC 2) and ENETC 0 (MAC 3) share the same
parallel interface, they cannot be used at the same time due to the SoC
constraint. And the MAC selection is controlled by the mac2_mac3_sel bit
of EXT_PIN_CONTROL register. Currently, the interface is set for ENETC 0
by default unless the switch port 2 is enabled in the DT node.

Like ENETC, each external port of the NETC switch can manage its external
PHY through its port MDIO registers. And the port can only access its own
external PHY by setting the PHY address to the LaBCR[MDIO_PHYAD_PRTAD].
If the accessed PHY address is not equal to LaBCR[MDIO_PHYAD_PRTAD], then
the MDIO access initiated by port MDIO will be invalid.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 .../ethernet/freescale/enetc/netc_blk_ctrl.c  | 188 ++++++++++++++++--
 1 file changed, 166 insertions(+), 22 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/netc_blk_ctrl.c b/drivers/net/ethernet/freescale/enetc/netc_blk_ctrl.c
index 92a0f824dae7..c21230f7a7fb 100644
--- a/drivers/net/ethernet/freescale/enetc/netc_blk_ctrl.c
+++ b/drivers/net/ethernet/freescale/enetc/netc_blk_ctrl.c
@@ -261,40 +261,112 @@ static int imx94_link_config(struct netc_blk_ctrl *priv,
 }
 
 static int imx94_enetc_link_config(struct netc_blk_ctrl *priv,
-				   struct device_node *np)
+				   struct device_node *np,
+				   bool *enetc0_en)
 {
 	int link_id = imx94_enetc_get_link_id(np);
 
 	if (link_id < 0)
 		return link_id;
 
+	if (link_id == IMX94_ENETC0_LINK && of_device_is_available(np))
+		*enetc0_en = true;
+
 	return imx94_link_config(priv, np, link_id);
 }
 
+static struct device_node *netc_get_switch_ports(struct device_node *np)
+{
+	struct device_node *ports;
+
+	ports = of_get_child_by_name(np, "ports");
+	if (!ports)
+		ports = of_get_child_by_name(np, "ethernet-ports");
+
+	return ports;
+}
+
+static int imx94_switch_link_config(struct netc_blk_ctrl *priv,
+				    struct device_node *np,
+				    bool *swp2_en)
+{
+	struct device_node *ports;
+	int port_id, err = 0;
+
+	ports = netc_get_switch_ports(np);
+	if (!ports)
+		return -ENODEV;
+
+	for_each_available_child_of_node_scoped(ports, child) {
+		if (of_property_read_u32(child, "reg", &port_id) < 0) {
+			err = -ENODEV;
+			goto end;
+		}
+
+		switch (port_id) {
+		case 0 ... 2: /* External ports */
+			err = imx94_link_config(priv, child, port_id);
+			if (err)
+				goto end;
+
+			if (port_id == 2)
+				*swp2_en = true;
+
+			break;
+		case 3: /* CPU port */
+			break;
+		default:
+			err = -EINVAL;
+			goto end;
+		}
+	}
+
+end:
+	of_node_put(ports);
+
+	return err;
+}
+
 static int imx94_netcmix_init(struct platform_device *pdev)
 {
 	struct netc_blk_ctrl *priv = platform_get_drvdata(pdev);
 	struct device_node *np = pdev->dev.of_node;
+	bool enetc0_en = false, swp2_en = false;
 	u32 val;
 	int err;
 
 	for_each_child_of_node_scoped(np, child) {
 		for_each_child_of_node_scoped(child, gchild) {
-			if (!of_device_is_compatible(gchild, "pci1131,e101"))
-				continue;
-
-			err = imx94_enetc_link_config(priv, gchild);
-			if (err)
-				return err;
+			if (of_device_is_compatible(gchild, "pci1131,e101")) {
+				err = imx94_enetc_link_config(priv, gchild,
+							      &enetc0_en);
+				if (err)
+					return err;
+			} else if (of_device_is_compatible(gchild,
+							   "pci1131,eef2")) {
+				err = imx94_switch_link_config(priv, gchild,
+							       &swp2_en);
+				if (err)
+					return err;
+			}
 		}
 	}
 
-	/* ENETC 0 and switch port 2 share the same parallel interface.
-	 * Currently, the switch is not supported, so this interface is
-	 * used by ENETC 0 by default.
+	if (enetc0_en && swp2_en) {
+		dev_err(&pdev->dev,
+			"Cannot enable swp2 and enetc0 at the same time\n");
+		return -EINVAL;
+	}
+
+	/* ENETC 0 and switch port 2 share the same parallel interface, they
+	 * cannot be enabled at the same time. The interface is set for the
+	 * ENETC 0 by default unless the switch port 2 is enabled in the DTS.
 	 */
 	val = netc_reg_read(priv->netcmix, IMX94_EXT_PIN_CONTROL);
-	val |= MAC2_MAC3_SEL;
+	if (!swp2_en)
+		val |= MAC2_MAC3_SEL;
+	else
+		val &= ~MAC2_MAC3_SEL;
 	netc_reg_write(priv->netcmix, IMX94_EXT_PIN_CONTROL, val);
 
 	return 0;
@@ -610,6 +682,77 @@ static int imx94_enetc_mdio_phyaddr_config(struct netc_blk_ctrl *priv,
 	return 0;
 }
 
+static int imx94_ierb_enetc_init(struct netc_blk_ctrl *priv,
+				 struct device_node *np,
+				 u32 phy_mask)
+{
+	int err;
+
+	err = imx94_enetc_update_tid(priv, np);
+	if (err)
+		return err;
+
+	return imx94_enetc_mdio_phyaddr_config(priv, np, phy_mask);
+}
+
+static int imx94_switch_mdio_phyaddr_config(struct netc_blk_ctrl *priv,
+					    struct device_node *np,
+					    int port_id, u32 phy_mask)
+{
+	int addr;
+
+	/* The switch has 3 external ports at most */
+	if (port_id > 2)
+		return 0;
+
+	addr = netc_get_phy_addr(np);
+	if (addr < 0) {
+		if (addr == -ENODEV)
+			return 0;
+
+		return addr;
+	}
+
+	if (phy_mask & BIT(addr)) {
+		dev_err(&priv->pdev->dev,
+			"Found same PHY address in EMDIO and switch node\n");
+		return -EINVAL;
+	}
+
+	netc_reg_write(priv->ierb, IERB_LBCR(port_id),
+		       LBCR_MDIO_PHYAD_PRTAD(addr));
+
+	return 0;
+}
+
+static int imx94_ierb_switch_init(struct netc_blk_ctrl *priv,
+				  struct device_node *np,
+				  u32 phy_mask)
+{
+	struct device_node *ports;
+	int port_id, err = 0;
+
+	ports = netc_get_switch_ports(np);
+	if (!ports)
+		return -ENODEV;
+
+	for_each_available_child_of_node_scoped(ports, child) {
+		err = of_property_read_u32(child, "reg", &port_id);
+		if (err)
+			goto end;
+
+		err = imx94_switch_mdio_phyaddr_config(priv, child,
+						       port_id, phy_mask);
+		if (err)
+			goto end;
+	}
+
+end:
+	of_node_put(ports);
+
+	return err;
+}
+
 static int imx94_ierb_init(struct platform_device *pdev)
 {
 	struct netc_blk_ctrl *priv = platform_get_drvdata(pdev);
@@ -625,17 +768,18 @@ static int imx94_ierb_init(struct platform_device *pdev)
 
 	for_each_child_of_node_scoped(np, child) {
 		for_each_child_of_node_scoped(child, gchild) {
-			if (!of_device_is_compatible(gchild, "pci1131,e101"))
-				continue;
-
-			err = imx94_enetc_update_tid(priv, gchild);
-			if (err)
-				return err;
-
-			err = imx94_enetc_mdio_phyaddr_config(priv, gchild,
-							      phy_mask);
-			if (err)
-				return err;
+			if (of_device_is_compatible(gchild, "pci1131,e101")) {
+				err = imx94_ierb_enetc_init(priv, gchild,
+							    phy_mask);
+				if (err)
+					return err;
+			} else if (of_device_is_compatible(gchild,
+							   "pci1131,eef2")) {
+				err = imx94_ierb_switch_init(priv, gchild,
+							     phy_mask);
+				if (err)
+					return err;
+			}
 		}
 	}
 
-- 
2.34.1


