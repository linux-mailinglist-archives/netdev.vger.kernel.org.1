Return-Path: <netdev+bounces-303016-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 4xUiBl91Q2okYwoAu9opvQ
	(envelope-from <netdev+bounces-303016-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 09:50:55 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B6B06E164F
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 09:50:54 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=NXP1.onmicrosoft.com header.s=selector1-NXP1-onmicrosoft-com header.b=Q1TGkZp4;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303016-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-303016-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=nxp.com (policy=none);
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A69C3302451A
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 07:48:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C142F3E5A31;
	Tue, 30 Jun 2026 07:48:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013055.outbound.protection.outlook.com [52.101.72.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 103B03E3163;
	Tue, 30 Jun 2026 07:48:48 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782805729; cv=fail; b=Ty/0HZyDEwR6Z9lHI301AiOGCeZy0nJE1n4rBSwiJz2fapilUmdIeODqDOa84ASSwBXKlI7pWGG0la4mdNAupoihvi0+HCTeOfMHTJlBYDVBaswoTGg8H6KsQsg4/Dsddne8m1XvstPdRMYZz7e46YzqD7lqpkZtT5J9xU/pNto=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782805729; c=relaxed/simple;
	bh=Ui0fPZpEKH2pqDQlGtaewPxbsv7L8xlm378do7zLBFc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=eRVrrWfg+BCUR+Im9eGaMPy3f14kjZrm8FgX8aex7bb7Ewznk6Qc/92mxSHcIftt4U54TnaohYThfs0qjny9/nzu27vmXASKluZJt8EZYSm8E1vc8hqXcTJeuyYnhBmKFs8Q2RIWmhRQGY6+6HGuFXx3fkPoesojnSoXdu0UG+E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=Q1TGkZp4; arc=fail smtp.client-ip=52.101.72.55
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jhmuw2g3fprYqB1g7UrdTLIJCS9JzWProYcvmfL2JyGRvKeWMxrwYcBrgKBYc2beKbN6Eofpy39OZaPpnn3grywmKaWkbO04cjkfEWczpeNQssHEFWrf/FtLHyAUuIIgNMvD8JW8YVIy1YMSfnP6DuM3aTYb738WIKoePqBytrRkPnnxPX3QqennTjp3BIxGDUiiZm4naTmX785pcss4wg27z6aUI04vWw0sHI/BIt/H7PBebu5gDvoF7DydGAia0OOfK50JPFhGns9X8MUYP3NWiM5MOxnBpmitXzX9f/xBRKyfiPaKUaXFMauiZ1lDxBN0VFHAqz3QiPP40PdXVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uf7R3hDgk51Q5WBhT1WZQt5pblRb/WvzPKESaRYdXgs=;
 b=pKTMPdlnfVPn61Ap6wljJHnYy6hABkoYjGxPHBxN3HhLlcbc4fgwJrcIjIuhwY+sdzNNxpl7VKIUOF2S33XI24ncDZhHttdmGxD33RlasuLKQLGoei10AIoPctdnNyozKbcelLvLCBR1MTw62Uv/npPayZ/Lw+0ie6d8lArE7EOJsYNhpNUSAGwZptspLxnDJvn47pwO/NPGdnWoxZJjO2rRP6w8ftjiOGmewjh6dkCz+DDg+wU4CvtgQdxGRyV8brWlAqEC6MLfNpgDf5W9oVOJbOGCcb3YCNjHB66Xr6R7wIq5kvnV8BsPjxI10/x05b2t/i08u6SRAwtbf+uJZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uf7R3hDgk51Q5WBhT1WZQt5pblRb/WvzPKESaRYdXgs=;
 b=Q1TGkZp4/4iioSLiGii0C3yyr597KwWdBSNRbRTqQhxNtzEWRjjwY1vPF5M9dg7v9DcJVcx1/h5s8KpyPIwONcjIPCyl1BbgfWl/2C56+GsYY1np0cyoQs4p3H7GGqEOdCAmOdSRKtecW9QrDeRmm5d7cK/25Mpn0O+YeO/O1dKuwxXyIAmuR6oOHMiQyMWQtPnELthDOb7GnXFTdq7gFUikm7jZJWyXHDwtrEnKncDj4Vwyrbxo89h8SsF+5WL+d+yvnzuzvzmho8A6ang81qPIY2dCBUyC05ZAWopBneFgVYcGSBd7HvfNZbT1QsmNv+WvIP3VfYX4yQ6+Ouv3mw==
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com (2603:10a6:800:1b0::22)
 by DU0PR04MB9561.eurprd04.prod.outlook.com (2603:10a6:10:312::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Tue, 30 Jun
 2026 07:48:45 +0000
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74]) by VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74%3]) with mapi id 15.21.0159.018; Tue, 30 Jun 2026
 07:48:45 +0000
From: wei.fang@oss.nxp.com
To: claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux@armlinux.org.uk,
	wei.fang@nxp.com,
	chleroy@kernel.org
Cc: imx@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH net-next 02/14] net: enetc: extract common helpers for MAC hash filter configuration
Date: Tue, 30 Jun 2026 15:20:24 +0800
Message-Id: <20260630072036.382761-3-wei.fang@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260630072036.382761-1-wei.fang@oss.nxp.com>
References: <20260630072036.382761-1-wei.fang@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0206.apcprd04.prod.outlook.com
 (2603:1096:4:187::21) To VE1PR04MB7216.eurprd04.prod.outlook.com
 (2603:10a6:800:1b0::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR04MB7216:EE_|DU0PR04MB9561:EE_
X-MS-Office365-Filtering-Correlation-Id: b970b466-0cda-40b0-f397-08ded67c0335
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|23010399003|19092799006|6133799003|921020|22082099003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	/sgWt6eiBYdHe+JfTYhX0Phi02YJqxNcoNqDaWfw2rK/fSHNI/oRFdfZP7wsQa1Y8gK6R1NRIgSbekUV9QlnA+j0Vgx4h/tNmZuAcmiE1dVPu9uEEVDQqfSYt8b6hxW6V7Hnl6/jCbbWMXJe0n5JEtC5iIFozfw+7fIEaZrE81La1KyIKE/9uLVhASd1CACGlxQeSoN6xO2PvezYt59LSOJs73GZrCZ4Eh0OdPL9ERLH6ARAhmdQXEa3vBIIFpSsFMXm/wW4ew644bGkaNKykGdvzFbka/3dOFoZaYRuipSJYy7BJqkjyvfpyYxHH+B3q/9UVM5OnSW+jTZNeua/VH7c5uPBkM2kBhr+B/f5M6K8edjNmLZTcHLBo3KWy+ZOtQF95aUQcSWEwI/Mm9RAwZA6bJVjtquPmITvUF05nRafxWakQoTiQjZAF2NQzhD+vriIxfcyybGYDsaDn9RshO0zJk98rcbFSB4aPM2n0x8iGD7vLjGB81AlMXQ5bn9dy3KibuWwuNG/cU+4jAkwhYGB/VrqZK/XAyOJ5YcZp+9Grc3dKq2vzv8xD9t4tJ7wI8cVMPY9EX60CZIPgMITL0K//3tocsHhgSSdHBySQ6vtmyvWnfyW2kPFs/FmaEjdUlf0LdYy8lCICv1RAEbnOhkCPsI+j7hHzrCePVnRCOFGooPmwXNxrWZarAWLtTOBZVO0R1dXgej5N9Xo/O3kJw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB7216.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(23010399003)(19092799006)(6133799003)(921020)(22082099003)(18002099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kT819/HobxXWlMSrjx+VKSSBhMTzUdM3+zclJRwwTv6dv0CkvJhOM2JbOGrD?=
 =?us-ascii?Q?+Iybrb+WcrPKLHX+8CGRKGZkwAB4UyIuVJYiBV8IsAsL5d3PZj8lq1XrXrtS?=
 =?us-ascii?Q?v6dDmvYI/9r8uybLf+Qa38HsRBUAt2+IXiJpeuWNJwBpxrdJFgUk54isu1GX?=
 =?us-ascii?Q?hbtdQzNxJmiLwEhsBmjJKRefGxKLBHT0W4eTyTOoEvLUTJ5Gcr8MY9YDvO9U?=
 =?us-ascii?Q?LQtu1rsmMLn1S04ICYSeJVhONOrqET5BqAvoU4bwl+unoj6ksFqiKK7r/6Yt?=
 =?us-ascii?Q?iCbj/6OEXzRMl2i7UHeNI/xTWYe1rwcofFXegsfuj2Ks83k01TcJAPJKQb8m?=
 =?us-ascii?Q?kPoUccScS8tqjt+tXM/y8wIwMDYbMlqCnYB1WL1ImkAmNO1XAEur0ib9DD93?=
 =?us-ascii?Q?SR42DhiaRa1BGN1MhtDIFTfw3BrYegM7SdjHw7hzVI2+CE0/A/WAcdLOgwR8?=
 =?us-ascii?Q?8IJFKJ3byX8zAmHUQvPHNoXJtS37YxTS5CPzq6P0SXvPrY38DgSRlowZls5j?=
 =?us-ascii?Q?njwZ6l/CKIikXyFKChOR1dTivArNNzUY0JYfivkA0SRv/NZNQefOrgWfWTBp?=
 =?us-ascii?Q?olLm17Jxqok0bI6nssMeBnR2Tb9GtOL+5O2CqQsSp2UxTKDzSgr2hwAp8PYQ?=
 =?us-ascii?Q?auwPAYMiANroLjxFke+SXIi2/PnHftTloauEQkKnnTl8taTDk8gysdV+e/Xn?=
 =?us-ascii?Q?EVAUO0Sx6P6M9qbiCLfrSg+WsiCu1tYbEGP3oHXGhGg4q//XVAP3OcZmH0c7?=
 =?us-ascii?Q?0PprjXQPSR6EB5qZRTIRxgf6JR10CqtqNfEavdHXDm313yyn5qq86DQHexoR?=
 =?us-ascii?Q?e+MOlQzdbnalUa5lLmqT7+Pju96IGB17cmGKF4toJ4W0Bbb+BHPNVodc9PsM?=
 =?us-ascii?Q?zSEtGkEQa6QCgFJcKsajd35grmMRBQ/gDokdnlPUTPnuoM9liO3zPPJCRWph?=
 =?us-ascii?Q?3l3Px2f6JswzjhEtQytllS86T7F7xlvhLOnf7xDsFKrTtoG8Vyg35gw+Roex?=
 =?us-ascii?Q?akgiiF2R16VxGa0HT+dBA91p5N2Kk2HZCkBvT7Mqgh7c5lZVNw1z0+oNlK8D?=
 =?us-ascii?Q?HTKU3yLvhBPIUzpn8N0H3U3PXJ2UF/T3VYGVjnORWgqhUXq4CuCbC0h6iNSC?=
 =?us-ascii?Q?uIR+SD2johKrdPxgHR76l2+pnMGlSe1YpbGnFvvUWFUxAFNEp/tNJOlEPE0d?=
 =?us-ascii?Q?SPkloU7kkr1plnIQHv52mS7QhZbMCwaPlEwRAZaFNnIKtG9kZ7yxEtiTkTJB?=
 =?us-ascii?Q?iJRpd0YFYn7yuoFNq+YKUc0uZE+5gmCRY7dnT4f3JW0HvRQVealBSjJ4a02M?=
 =?us-ascii?Q?c57EJm4CQQTLtz5M1CNX+4ywcsZxPRqNUVkPjDnjpT4upI/OXI3Dtek5fn5V?=
 =?us-ascii?Q?Yph6qX2JMwUuHxy665qqeZwtjl50LC/zFFgc5mwnVcFGh9np2NDC8ncOTboA?=
 =?us-ascii?Q?ebd1/ZaTPUQdBkvk7ciFZlxcPc8qdOmlSxIfMDeALWSGlSeTop7FhFY4u8bl?=
 =?us-ascii?Q?evjbL+Esr2TU3y3WHKWLiQQsKOSzGXL8y3HbIwW5rQcd8nH85KIQt9kyok0q?=
 =?us-ascii?Q?/u34Guo+QbQJU4KdQZpEL9dgZCIAMqdc7BRNFnl0wFuu6ssdYMFEBKCSCr1u?=
 =?us-ascii?Q?TVldlgpattM3uTOhQIQeE4+fWRAN0e/smyDYGrP3HPzo1sRj0oF1Tfl3eos/?=
 =?us-ascii?Q?DoyF+4AjOTOmRPw+ES42oBZI9IMVn7IV0TbAcZuPdH6X2FCN5iMj0MvUv5/E?=
 =?us-ascii?Q?9FnesONfslC5LcPauz2C/qp9TadKEslhR6K2t49JOBuV/s4FBMUi?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b970b466-0cda-40b0-f397-08ded67c0335
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB7216.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2026 07:48:45.3967
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k0CxW3bKOsQPhA3TjiaiVkfjLR2yuAedwuiE1nSRDmCBke8o1jvyqd1ePWrt4E6ybkzMaYRiRhbwzIAt2QtaAUIGZZlEfNT2qkcCHWMXBmu0G8MB7sTatUf+Dz3RkAsY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9561
X-Rspamd-Action: no action
X-Spamd-Result: default: False [3.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-303016-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[wei.fang@oss.nxp.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:claudiu.manoil@nxp.com,m:vladimir.oltean@nxp.com,m:xiaoning.wang@nxp.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:linux@armlinux.org.uk,m:wei.fang@nxp.com,m:chleroy@kernel.org,m:imx@lists.linux.dev,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linuxppc-dev@lists.ozlabs.org,m:linux-arm-kernel@lists.infradead.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wei.fang@oss.nxp.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[NXP1.onmicrosoft.com:+];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FROM_NO_DN(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.nxp.com:mid,oss.nxp.com:from_mime,nxp.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,NXP1.onmicrosoft.com:dkim,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6B6B06E164F

From: Wei Fang <wei.fang@nxp.com>

The PSIUMHFR and PSIMMHFR registers in ENETC v4 have the same bit layout
as in ENETC v1. The only difference between the two hardware generations
is the register address offsets.

Since the register functionality is identical, the MAC hash filter
configuration code can be shared between the ENETC v1 and v4 drivers.
Extract two new common helper functions, enetc_set_si_uc_hash_filter()
and enetc_set_si_mc_hash_filter(), into enetc_pf_common.c. These helpers
select the correct register offset based on the hardware revision via
is_enetc_rev1().

Remove v1-specific enetc_clear_mac_ht_flt() and enetc_set_mac_ht_flt()
from enetc_pf.c, and v4-specific enetc4_pf_set_si_uc_hash_filter() and
enetc4_pf_set_si_mc_hash_filter() from enetc4_pf.c, as they are now
superseded by the shared implementations.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 .../net/ethernet/freescale/enetc/enetc4_pf.c  | 43 +++++++---------
 .../net/ethernet/freescale/enetc/enetc_pf.c   | 51 +++++--------------
 .../freescale/enetc/enetc_pf_common.c         | 40 +++++++++++++++
 .../freescale/enetc/enetc_pf_common.h         |  2 +
 4 files changed, 73 insertions(+), 63 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc4_pf.c b/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
index 304ec069654d..48a74db90ed5 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
@@ -75,20 +75,6 @@ static void enetc4_pf_get_si_primary_mac(struct enetc_hw *hw, int si,
 	put_unaligned_le16(lower, addr + 4);
 }
 
-static void enetc4_pf_set_si_uc_hash_filter(struct enetc_hw *hw, int si,
-					    u64 hash)
-{
-	enetc_port_wr(hw, ENETC4_PSIUMHFR0(si), lower_32_bits(hash));
-	enetc_port_wr(hw, ENETC4_PSIUMHFR1(si), upper_32_bits(hash));
-}
-
-static void enetc4_pf_set_si_mc_hash_filter(struct enetc_hw *hw, int si,
-					    u64 hash)
-{
-	enetc_port_wr(hw, ENETC4_PSIMMHFR0(si), lower_32_bits(hash));
-	enetc_port_wr(hw, ENETC4_PSIMMHFR1(si), upper_32_bits(hash));
-}
-
 static void enetc4_pf_set_loopback(struct net_device *ndev, bool en)
 {
 	struct enetc_ndev_priv *priv = netdev_priv(ndev);
@@ -147,11 +133,12 @@ static int enetc4_pf_set_uc_exact_filter(struct enetc_pf *pf)
 	int max_num_mfe = pf->caps.mac_filter_num;
 	struct enetc_mac_filter mac_filter = {};
 	struct net_device *ndev = pf->si->ndev;
-	struct enetc_hw *hw = &pf->si->hw;
 	struct enetc_mac_addr *mac_tbl;
+	struct enetc_si *si = pf->si;
 	struct netdev_hw_addr *ha;
 	int i = 0, err;
 	int mac_cnt;
+	u64 hash;
 
 	netif_addr_lock_bh(ndev);
 
@@ -159,7 +146,7 @@ static int enetc4_pf_set_uc_exact_filter(struct enetc_pf *pf)
 	if (!mac_cnt) {
 		netif_addr_unlock_bh(ndev);
 		/* clear both MAC hash and exact filters */
-		enetc4_pf_set_si_uc_hash_filter(hw, 0, 0);
+		enetc_set_si_uc_hash_filter(si, 0, 0);
 		enetc4_pf_clear_maft_entries(pf);
 
 		return 0;
@@ -186,11 +173,13 @@ static int enetc4_pf_set_uc_exact_filter(struct enetc_pf *pf)
 	/* Set temporary unicast hash filters in case of Rx loss when
 	 * updating MAC address filter table
 	 */
-	enetc4_pf_set_si_uc_hash_filter(hw, 0, *mac_filter.mac_hash_table);
+	bitmap_to_arr64(&hash, mac_filter.mac_hash_table,
+			ENETC_MADDR_HASH_TBL_SZ);
+	enetc_set_si_uc_hash_filter(si, 0, hash);
 	enetc4_pf_clear_maft_entries(pf);
 
 	if (!enetc4_pf_add_maft_entries(pf, mac_tbl, i))
-		enetc4_pf_set_si_uc_hash_filter(hw, 0, 0);
+		enetc_set_si_uc_hash_filter(si, 0, 0);
 
 	kfree(mac_tbl);
 
@@ -206,8 +195,9 @@ static void enetc4_pf_set_mac_hash_filter(struct enetc_pf *pf, int type)
 {
 	struct net_device *ndev = pf->si->ndev;
 	struct enetc_mac_filter *mac_filter;
-	struct enetc_hw *hw = &pf->si->hw;
+	struct enetc_si *si = pf->si;
 	struct netdev_hw_addr *ha;
+	u64 hash;
 
 	netif_addr_lock_bh(ndev);
 	if (type & ENETC_MAC_FILTER_TYPE_UC) {
@@ -216,8 +206,9 @@ static void enetc4_pf_set_mac_hash_filter(struct enetc_pf *pf, int type)
 		netdev_for_each_uc_addr(ha, ndev)
 			enetc_add_mac_addr_ht_filter(mac_filter, ha->addr);
 
-		enetc4_pf_set_si_uc_hash_filter(hw, 0,
-						*mac_filter->mac_hash_table);
+		bitmap_to_arr64(&hash, mac_filter->mac_hash_table,
+				ENETC_MADDR_HASH_TBL_SZ);
+		enetc_set_si_uc_hash_filter(si, 0, hash);
 	}
 
 	if (type & ENETC_MAC_FILTER_TYPE_MC) {
@@ -226,8 +217,9 @@ static void enetc4_pf_set_mac_hash_filter(struct enetc_pf *pf, int type)
 		netdev_for_each_mc_addr(ha, ndev)
 			enetc_add_mac_addr_ht_filter(mac_filter, ha->addr);
 
-		enetc4_pf_set_si_mc_hash_filter(hw, 0,
-						*mac_filter->mac_hash_table);
+		bitmap_to_arr64(&hash, mac_filter->mac_hash_table,
+				ENETC_MADDR_HASH_TBL_SZ);
+		enetc_set_si_mc_hash_filter(si, 0, hash);
 	}
 	netif_addr_unlock_bh(ndev);
 }
@@ -480,7 +472,6 @@ static void enetc4_psi_do_set_rx_mode(struct work_struct *work)
 	struct enetc_si *si = container_of(work, struct enetc_si, rx_mode_task);
 	struct enetc_pf *pf = enetc_si_priv(si);
 	struct net_device *ndev = si->ndev;
-	struct enetc_hw *hw = &si->hw;
 	bool uc_promisc = false;
 	bool mc_promisc = false;
 	int type = 0;
@@ -501,12 +492,12 @@ static void enetc4_psi_do_set_rx_mode(struct work_struct *work)
 	enetc_set_si_mc_promisc(si, 0, mc_promisc);
 
 	if (uc_promisc) {
-		enetc4_pf_set_si_uc_hash_filter(hw, 0, 0);
+		enetc_set_si_uc_hash_filter(si, 0, 0);
 		enetc4_pf_clear_maft_entries(pf);
 	}
 
 	if (mc_promisc)
-		enetc4_pf_set_si_mc_hash_filter(hw, 0, 0);
+		enetc_set_si_mc_hash_filter(si, 0, 0);
 
 	/* Set new MAC filter */
 	enetc4_pf_set_mac_filter(pf, type);
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf.c b/drivers/net/ethernet/freescale/enetc/enetc_pf.c
index a97d2e2dd07b..db2a800a7aaf 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_pf.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_pf.c
@@ -80,37 +80,6 @@ static void enetc_add_mac_addr_em_filter(struct enetc_mac_filter *filter,
 	filter->mac_addr_cnt++;
 }
 
-static void enetc_clear_mac_ht_flt(struct enetc_si *si, int si_idx, int type)
-{
-	bool err = si->errata & ENETC_ERR_UCMCSWP;
-
-	if (type == UC) {
-		enetc_port_wr(&si->hw, ENETC_PSIUMHFR0(si_idx, err), 0);
-		enetc_port_wr(&si->hw, ENETC_PSIUMHFR1(si_idx), 0);
-	} else { /* MC */
-		enetc_port_wr(&si->hw, ENETC_PSIMMHFR0(si_idx, err), 0);
-		enetc_port_wr(&si->hw, ENETC_PSIMMHFR1(si_idx), 0);
-	}
-}
-
-static void enetc_set_mac_ht_flt(struct enetc_si *si, int si_idx, int type,
-				 unsigned long hash)
-{
-	bool err = si->errata & ENETC_ERR_UCMCSWP;
-
-	if (type == UC) {
-		enetc_port_wr(&si->hw, ENETC_PSIUMHFR0(si_idx, err),
-			      lower_32_bits(hash));
-		enetc_port_wr(&si->hw, ENETC_PSIUMHFR1(si_idx),
-			      upper_32_bits(hash));
-	} else { /* MC */
-		enetc_port_wr(&si->hw, ENETC_PSIMMHFR0(si_idx, err),
-			      lower_32_bits(hash));
-		enetc_port_wr(&si->hw, ENETC_PSIMMHFR1(si_idx),
-			      upper_32_bits(hash));
-	}
-}
-
 static void enetc_sync_mac_filters(struct enetc_pf *pf)
 {
 	struct enetc_mac_filter *f = pf->mac_filter;
@@ -122,12 +91,16 @@ static void enetc_sync_mac_filters(struct enetc_pf *pf)
 	for (i = 0; i < MADDR_TYPE; i++, f++) {
 		bool em = (f->mac_addr_cnt == 1) && (i == UC);
 		bool clear = !f->mac_addr_cnt;
+		u64 hash;
 
 		if (clear) {
-			if (i == UC)
+			if (i == UC) {
 				enetc_clear_mac_flt_entry(si, pos);
+				enetc_set_si_uc_hash_filter(si, 0, 0);
+			} else {
+				enetc_set_si_mc_hash_filter(si, 0, 0);
+			}
 
-			enetc_clear_mac_ht_flt(si, 0, i);
 			continue;
 		}
 
@@ -135,7 +108,7 @@ static void enetc_sync_mac_filters(struct enetc_pf *pf)
 		if (em) {
 			int err;
 
-			enetc_clear_mac_ht_flt(si, 0, UC);
+			enetc_set_si_uc_hash_filter(si, 0, 0);
 
 			err = enetc_set_mac_flt_entry(si, pos, f->mac_addr,
 						      BIT(0));
@@ -147,11 +120,15 @@ static void enetc_sync_mac_filters(struct enetc_pf *pf)
 				 err);
 		}
 
+		bitmap_to_arr64(&hash, f->mac_hash_table,
+				ENETC_MADDR_HASH_TBL_SZ);
 		/* hash table filter, clear EM filter for UC entries */
-		if (i == UC)
+		if (i == UC) {
 			enetc_clear_mac_flt_entry(si, pos);
-
-		enetc_set_mac_ht_flt(si, 0, i, *f->mac_hash_table);
+			enetc_set_si_uc_hash_filter(si, 0, hash);
+		} else {
+			enetc_set_si_mc_hash_filter(si, 0, hash);
+		}
 	}
 }
 
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c b/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
index b0c0dc668e34..3597cb81a7cc 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
@@ -131,6 +131,46 @@ void enetc_set_si_mc_promisc(struct enetc_si *si, int si_id, bool promisc)
 }
 EXPORT_SYMBOL_GPL(enetc_set_si_mc_promisc);
 
+void enetc_set_si_uc_hash_filter(struct enetc_si *si, int si_id, u64 hash)
+{
+	int psiumhfr0_off, psiumhfr1_off;
+	struct enetc_hw *hw = &si->hw;
+
+	if (is_enetc_rev1(si)) {
+		bool err = si->errata & ENETC_ERR_UCMCSWP;
+
+		psiumhfr0_off = ENETC_PSIUMHFR0(si_id, err);
+		psiumhfr1_off = ENETC_PSIUMHFR1(si_id);
+	} else {
+		psiumhfr0_off = ENETC4_PSIUMHFR0(si_id);
+		psiumhfr1_off = ENETC4_PSIUMHFR1(si_id);
+	}
+
+	enetc_port_wr(hw, psiumhfr0_off, lower_32_bits(hash));
+	enetc_port_wr(hw, psiumhfr1_off, upper_32_bits(hash));
+}
+EXPORT_SYMBOL_GPL(enetc_set_si_uc_hash_filter);
+
+void enetc_set_si_mc_hash_filter(struct enetc_si *si, int si_id, u64 hash)
+{
+	int psimmhfr0_off, psimmhfr1_off;
+	struct enetc_hw *hw = &si->hw;
+
+	if (is_enetc_rev1(si)) {
+		bool err = si->errata & ENETC_ERR_UCMCSWP;
+
+		psimmhfr0_off = ENETC_PSIMMHFR0(si_id, err);
+		psimmhfr1_off = ENETC_PSIMMHFR1(si_id);
+	} else {
+		psimmhfr0_off = ENETC4_PSIMMHFR0(si_id);
+		psimmhfr1_off = ENETC4_PSIMMHFR1(si_id);
+	}
+
+	enetc_port_wr(hw, psimmhfr0_off, lower_32_bits(hash));
+	enetc_port_wr(hw, psimmhfr1_off, upper_32_bits(hash));
+}
+EXPORT_SYMBOL_GPL(enetc_set_si_mc_hash_filter);
+
 void enetc_pf_netdev_setup(struct enetc_si *si, struct net_device *ndev,
 			   const struct net_device_ops *ndev_ops)
 {
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf_common.h b/drivers/net/ethernet/freescale/enetc/enetc_pf_common.h
index a619fb8fed9c..bf9029b0a017 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_pf_common.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc_pf_common.h
@@ -19,6 +19,8 @@ int enetc_vlan_rx_del_vid(struct net_device *ndev, __be16 prot, u16 vid);
 int enetc_init_sriov_resources(struct enetc_pf *pf);
 void enetc_set_si_uc_promisc(struct enetc_si *si, int si_id, bool promisc);
 void enetc_set_si_mc_promisc(struct enetc_si *si, int si_id, bool promisc);
+void enetc_set_si_uc_hash_filter(struct enetc_si *si, int si_id, u64 hash);
+void enetc_set_si_mc_hash_filter(struct enetc_si *si, int si_id, u64 hash);
 
 static inline u16 enetc_get_ip_revision(struct enetc_hw *hw)
 {
-- 
2.34.1


