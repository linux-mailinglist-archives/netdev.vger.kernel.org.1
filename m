Return-Path: <netdev+bounces-277150-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QP7XEbIf2GlaYAgAu9opvQ
	(envelope-from <netdev+bounces-277150-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 23:52:50 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B44D73D008E
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 23:52:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A0C513006B3A
	for <lists+netdev@lfdr.de>; Thu,  9 Apr 2026 21:52:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E019357A20;
	Thu,  9 Apr 2026 21:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="KoPaUuG1"
X-Original-To: netdev@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010034.outbound.protection.outlook.com [52.101.84.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDDA030F54B;
	Thu,  9 Apr 2026 21:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775771566; cv=fail; b=BmSOVnK6ZaxgvYPCJiOpwqPfafBrtCSeotakal77Slt3x0N7KGe1TKHocQ5L1HbavwOtn9lTut2BMVUXsfAFpJyMlf/xNO8uH+1yVnQDQcgobfxBstVhYMAzCKuWfWddRkS27rKKzY6VAIHG9Bm15FU5Cb7VVfUQz/9B4wB45Xs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775771566; c=relaxed/simple;
	bh=9/im1Svy5H/w/RyChWap7A5Np25Bip2lGKzRcYll9hw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=mvjsz7ahkk3Bodu1kfrGmO3ZcoZQC7AUyfmID6Q8qXMcQR48n/XCuqsIoWjLWpdDj5MZ15qoNMB6AqS/5zKBRQ67mXrv0+1t/8tShcBKRJj6LujFCftuQTcTrpcwQcP71M0y3xIYMgo3SwC3oYmWaUMLWIemC9axzt357UtKZ04=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=KoPaUuG1; arc=fail smtp.client-ip=52.101.84.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Urs0b9lHn2SSMw/Wrr33bBRF8PtP2DD3ZftxAR8ONWwYM3qtnjX4pKDC86kocmMKHZtuScKB9C90yOtUb0PlJWyKSjqBHRgf/cHsEXQ2Qn1KFIWaI6A+hXuo8OSpeN0MGyt0JwFg7O33rMnxICDPhy6qgqG8o7ux4NIol0i40BGARb+uuVJ3F1Cn+GCHQ6Dms4tW2GxVAGIRH981SdRRPgm0p6ld7cJ3XVmXa5du/Pf6AnbfRrh90bq5T2MN9pD/3RO3I/SXTPw8wfXQ9l8FkOSoX/9R43SvlFU0kBUz7Ds4KgJQAd6RE342vw9A9G0brr6zDk6u8piD4pXQ+it9qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7kAj7slkvePYTD93asw0UnvnHbPShfyClmqFIv/KyE0=;
 b=w1i8NEzT2VEwR8M70aJL/GDssGnpS0kcRC0v3KjCTUcNejmnDrKN4ywiUMd7BZNYJmwLJ3Q9W1VdU4XupF6AQX/2tc0vwif8aBaSbGHPKlEWpumiswSJkIr1mx/q+RekbiP+TL0V8CWwXsYwwOkoMam2mWJ4sXh80Tp3grc3Wzvk1lNJ/cJgSic3yv7tpgAB4LlG3xfJrFak3+/RkyV9uorHs+/xkV1wu4J1qiAqJN2JMGyvXWT5bRKxLGVP4VWHD+0F9YhBMyt6WmDZrgaIv7hKn40iU26x5wn/BYOVOJEySGGo7uIn0dyDUwaB+FkZBpV5yV7HFVujAPE2RLRKTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7kAj7slkvePYTD93asw0UnvnHbPShfyClmqFIv/KyE0=;
 b=KoPaUuG17Tt+0gb0H3SFiVSP56MoOk4cPqJSIa3HUGXzU1Xwqba7t3KiodvF+/pROF4rc5VTVTwrSLBZ4UlplozabL9edi/X8OQOcHzZridfrkGPRcIrQaCWrEn0ySs9YltnRTcS8u4LAnmACKwCLK5V/po4ZU2Z9D/lnFCvwdWwQfhwCH2qaRHnrVmwLynwigc+Zwp4QFh5Xo+xolo2mi3RO/trzV10NgKdtoHrLKRNIFTRtV/0gOcx7ArUV3RgyVjDOXpzuWsqcfBu3HEpG+lscsf8HBbtJALrZcpx9V+M9sODvuL1gmnVKIB5aZB032WpXnqi0Q+eN04/MCkq3g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by GV1PR04MB10425.eurprd04.prod.outlook.com (2603:10a6:150:1d3::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Thu, 9 Apr
 2026 21:52:40 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4%4]) with mapi id 15.20.9769.017; Thu, 9 Apr 2026
 21:52:40 +0000
Date: Fri, 10 Apr 2026 00:52:37 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Daniel Golle <daniel@makrotopia.org>
Cc: Frank Wunderlich <linux@fw-web.de>,
	"Chester A. Unal" <chester.a.unal@arinc9.com>,
	Felix Fietkau <nbd@nbd.name>, Alexander Couzens <lynxis@fe80.eu>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Frank Wunderlich <frank-w@public-files.de>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [RFC net PATCH v1] net: pcs: pcs-mtk-lynxi: fix bpi-r3 serdes
 configuration
Message-ID: <20260409215237.deqjdkezmzdvr6yt@skbuf>
References: <20260409133344.129620-1-linux@fw-web.de>
 <20260409164942.wbmwtkpd5d5zibyy@skbuf>
 <adgSXDUn-oL6V_TK@makrotopia.org>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <adgSXDUn-oL6V_TK@makrotopia.org>
X-ClientProxiedBy: VI6PEPF00000208.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:808:1::8c7) To AM9PR04MB8585.eurprd04.prod.outlook.com
 (2603:10a6:20b:438::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8585:EE_|GV1PR04MB10425:EE_
X-MS-Office365-Filtering-Correlation-Id: 0038df1d-a57f-4631-3b59-08de96825264
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|19092799006|10070799003|376014|7416014|366016|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	VIWRCE27wdl6/ZX4KEdBWFlCDHwWRXZBeIp8Xzrtje4ykwrSFHptL/wbkZfYz2vHu7oW7WveWXDJ6AdulYpeD8O20WDFwuUfphMIGeiqxT2ckXuUvMwPFEJPXED+d9W74q3ZQyNEbxUPXeWX4VnXr1facgQSYnSwAjru82D8VvELmb0ihbDXC6j5dH6bsRIGx9fYS3nWUtwx1A1/h7VhCh+0Ht4RYTc61ZmnWHfaVA35DpG4R8JxA0Ebix3dnlv7RStnLMIOznP+EWSD4dGBqNhShGBjpw2TCe5e1elXZ24C/oBM7QW+dMWMupYbV/ipaQKVla5u4/xZz8klJpt9/Ux81ZkfP8IDpO9LY1ryIEopRsfCGJZ9eJ5+As71/B2j8cNFXya0qnB35n2nfQd3473YYb0CSeA3VliIO54BZSd3uCTKjsbbHwKVgWfvttcq99Ysg66cq1hVAivvLwJL4HuK/1a+2BTD4fbU7iUzGVez34HZNgB4Oxb+wbLQ4axwx6xDf6l16cs6JvRSjNE2ooHs/in6XmVYpuNL0cVzulxVMnIz8UfOwcM69elB39RbKiVQvNFKQD1xNGhPphsUHm2LGCwYZbA5ckYAr3IrFQTquF5JAXmqaC7STeQ41Fujtu267OpcLeOJWhgY72EgGDaZTORTqNuNek00/AXA2zLL91l7fHJMK8NnCpASfgft
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(10070799003)(376014)(7416014)(366016)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?b2rHlGaV00LCMlQx7h8QYErWGBGVYdWNaHcME++CyF2B3FEkWJucaCqsn3?=
 =?iso-8859-1?Q?Dy75+uVhhGqLIsot1rcX1bLVVEQfCC1eRaec2N4QnmL0x2XnNxy6qGcEfr?=
 =?iso-8859-1?Q?IJA38Wk2RY8WrUcCIqH4N0L1P1gJdPGJuosQvVw4j6jXKJXwu0uMkY9rYT?=
 =?iso-8859-1?Q?h/oUCHiSGA0yNWTUn4U4OdvfaSHP4pHy+2INQxIA70VyWXI5P9XFJLP7jO?=
 =?iso-8859-1?Q?HcOsHWOvdgonR4XDYaDgD0lNzsulu3hyk2cbru8nL6qB7GvvMJWqnRj8+H?=
 =?iso-8859-1?Q?QphDpVRiM2v5lOe9iUplGY3pHjNeZV9vuVWGdfIEVtix+JvQhRNuJOfZZL?=
 =?iso-8859-1?Q?9RRzxW6rbJunOZGx598GbGVE7ugeh+IUbPH8wWWkPdVxF16h/t2Auq/xBK?=
 =?iso-8859-1?Q?V5+FdUvD8zMgFa4bKB6APZt2XWVYug94TK2NCxycFhEAQ8+zu6AFcAii1u?=
 =?iso-8859-1?Q?/2OWp/+GDW15Vg1f1wyvWaPnK3er6WjhJUq3sX8mdPx8poq6gqIloqv0nt?=
 =?iso-8859-1?Q?7CV+b5Nmk7Y/yuSp5ATCZe4ItYGaTKidT+3MAb4m57h/NTFa9fW5jSbObv?=
 =?iso-8859-1?Q?QTY7MoXkCvjuqyUhsNnX/478c5s/TJq0aoaL4WBvnFZ6eZqmcTZDEOS3Zi?=
 =?iso-8859-1?Q?/f/gQE8UU1HFi19dcN5q1JHZgHzXWS2U17Rqqdhx9Kj671QC9/whGYdgFx?=
 =?iso-8859-1?Q?SPico8h0kJb6AKztE4qI1+ozHoH4lstKtcEqQk12fyQQ2DJNVMh6uBGNBK?=
 =?iso-8859-1?Q?4fyvV8paFhyJN0IEKiarmylqMjLyVZZQ+hSFTcpYUHt8JikS7ynqy417tV?=
 =?iso-8859-1?Q?5E4LOM/r0fg5+/aFu02GM1j6togL+K8pRp2D/Y4eQsmhUVAkEPpBd0GFhj?=
 =?iso-8859-1?Q?phc1zW0A74uryvQ1WVFseyfnduWJoRGBSzMpmZbHwwyyyNTP9DINMTHORc?=
 =?iso-8859-1?Q?smgvY97XoAc/Z2jqBuRChobsjITtWiUBelO1A3YHDAQACsvYo3TFdyd1EH?=
 =?iso-8859-1?Q?XzoKQBKQD0EDUA5TdXQZOs4oaFY1c5/52zbV3fyeQuddCkeopeb7QA++Uo?=
 =?iso-8859-1?Q?ECUoVEbIJZIqlRgc/nCmLja99iRfAx2SsFjimVbnMBRHMioIDc5Fs1R0Np?=
 =?iso-8859-1?Q?0n87hxlTPuEBB6pBPrrmEaeOhKDnyjD9wYiOgbZV/ABbONK/GXKrjxnxRu?=
 =?iso-8859-1?Q?VnGTP6Dn7sbHaa6CycWdd765vRoAlCxwm8kyvdgQ7XnLiTJ72AeTCxwCz8?=
 =?iso-8859-1?Q?4EjQ9Hq8rYpDA+hODQVEy6ZXX9gCDs3xEAV2siVW3WU+i/KO8eBcMHtyOH?=
 =?iso-8859-1?Q?qVXj5t4tAk9MGyxlbjM46KanIblJmYGl8xJQ0Zn0fHcG0hGNPQCWgrCe3a?=
 =?iso-8859-1?Q?ztIKrvbHJiX3JPAlMzXo+Z6aKCnZY04eGYqY1baWbaUNW/xjOt4bOgb3rH?=
 =?iso-8859-1?Q?qXTMOF8ifK61/ZyvSdCshI9loBJCKuqArgcAIKYF1+vpcHngP/YrW1RMpr?=
 =?iso-8859-1?Q?go9XbZAcFMjLzSrHJqUKyGoShOPqha30XdZJkQrP5gM13XQuJ4fZfkTItT?=
 =?iso-8859-1?Q?VvgYgK1lT0KCXVcr/q2LUy9C0DQ6zKBZ3VG9wGkg83wNbCPr992eIB9GEE?=
 =?iso-8859-1?Q?LHsqlM+3YDm6GJCZBDV4X+OmiLDy45rRIdpVFwruZCVevUVtVpu1gMHPWO?=
 =?iso-8859-1?Q?x8GHHVEAncwDycp54XG+zWc1BKm1h2vyo99c4ACjWkJrI1qb/UshK9KRhn?=
 =?iso-8859-1?Q?MOribfrpH92A1rSJi7CgIQxG2RCWfjKIFZxip8S2APs/bA75Yn3FdGOv74?=
 =?iso-8859-1?Q?TGruDR2Ng0+z4z9dM0V9dFTrDGADU7fjF2/xphjBtDg0AjgEqu3PvDuzqC?=
 =?iso-8859-1?Q?Bo?=
X-MS-Exchange-AntiSpam-MessageData-1: pJgjH8CrOSr1NTlcy5k573iIJ1O6H5V96Ls=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0038df1d-a57f-4631-3b59-08de96825264
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2026 21:52:40.7595
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mKpYfXzCJDqlIIfUyQt8XGYX3yd5DuR/lfG2S0fElkpKvJ9prZeyGDKoKpLXFVomvaG4txvHQxVlZxjh8K3gnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10425
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-277150-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	FREEMAIL_CC(0.00)[fw-web.de,arinc9.com,nbd.name,fe80.eu,lunn.ch,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,collabora.com,public-files.de,vger.kernel.org,lists.infradead.org];
	DKIM_TRACE(0.00)[nxp.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vladimir.oltean@nxp.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B44D73D008E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Apr 09, 2026 at 09:55:56PM +0100, Daniel Golle wrote:
> On Thu, Apr 09, 2026 at 07:49:42PM +0300, Vladimir Oltean wrote:
> > I notice Arınc, listed by ./scripts/get_maintainer.pl drivers/net/dsa/mt7530.c,
> > and Felix, listed by ./scripts/get_maintainer.pl drivers/net/ethernet/mediatek/mtk_eth_soc.c,
> > are not on CC. Maybe they have more info.
> > 
> > Only the switch port has a chance of having a non-zero default polarity
> > setting? (coming from the efuse, if I understood this discussion properly)
> > https://lore.kernel.org/netdev/C59EED96-3973-4074-A4D8-C264949D447E@linux.dev/
> > The GMAC doesn't?
> 
> Yes, vendor SDK uses DT mediatek,pnswap{,-rx,-tx} properties only for the
> SoC GMACs. For MT7531 there are **no** strap pins deciding the SerDes
> polarity, and also no software-way to override the defaults in the vendor
> SDK.
> 
> However, the MT7531 datasheet quite clearly states:
> Register 000050EC QPHY_WRAP_CTRL -- QPHY wrapper control
> Reset value: 0x00000501
> 
> BIT 1 RX_BIT_POLARITY -- RX bit polarity control
>  1'b0: normal
>  1'b1: inverted
> 
> BIT 0 TX_BIT_POLARITY -- TX bit polarity control (TX default inversed in MT7531)
>  1'b0: normal
>  1'b1: inverted
> 
> Hence the best would be to just assume the documented default in the driver
> as well.
> 
> A quick register dump using the BPi-R3 confirms that this applies to *both*
> SerDes PCS on MT7531A (port 5 and port 6) equally, both read 0x00000501
> after reset.

OK. Excepting the DSA driver for MT7531 from polarity configuration
based on lack of a fwnode for the PCS should be fine (for now, to
address the regression).

