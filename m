Return-Path: <netdev+bounces-269464-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MAavGswJvGkArgIAu9opvQ
	(envelope-from <netdev+bounces-269464-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 15:35:56 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A1C442CCF06
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 15:35:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 69F503064602
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 14:24:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E47937472F;
	Thu, 19 Mar 2026 14:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="cQuq3/sd"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013056.outbound.protection.outlook.com [52.101.72.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D6F1372B53;
	Thu, 19 Mar 2026 14:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773930250; cv=fail; b=KT2K7431CSSYxXcbDOHGr5hg5/WdzCFlWjz3Nnolw6FSYvFGya6Hyq1IccZTFhykp7VF+rrcvGgadaOb9nhH4DPvBfVPTOna2dTto2+E6KbOZyKmzDJYNCOx8hgl3cQ9aio8TbJ9ZR1+3naN8wHwTdEsrOTtjh8CxWRgrnLQJhg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773930250; c=relaxed/simple;
	bh=sBUz+JI6hNrcLC957sS9HeAMKhFO7TFLxYGDYPnujq0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TODcT+B1Z1wezKKWgnZdXXFl9KHZUurY+a32tD0Z6puNi/1bYZFlBNLgwE6LNHQCnXtGwMTSWV2HYMt6sWh8gH/05tNWxatSeqY70fJVgb8hGxJjZURDa6fsu5RC9AL6Tw8Xh3tTP2i3ydhxlohe0uLFhc2NCpwzytPn/WxAX4Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=cQuq3/sd; arc=fail smtp.client-ip=52.101.72.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZkzBPgLwe+rWwo2bWoq1AiP0RVnSNXDLEH/OobrRyC84gvTMCp8ZFsP3kbKPtyDcf+kgRmfnwEY+tZIvl/28CVMbVuiFFSrP0uuApSImfr3oCD7BdCGkLoElLeOcNIX7khiln+sRcMwBAwq3Vf1gtG9fWJ7wMyltX/zGuPRbdWqMZZVRiIDAhdSYlZBzIf+nbevlGbkUIZPlnN5VAoRmgDbDKHnWqS9bi1FtGoYkKF9tpOKe1FVLSVryihiktWn6bauyJW5D4rf61rxEvs5sJtC3+VS9RfP7ETM8XRjyhpx61nOShH39yl0zb0TW850CCiAIKvUxl6LUYKkyLF7TbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s/17G6TJyOUZh3RPg4n2nDSh9frc4CA7KYxIfAQ9UnQ=;
 b=iWWd+MR10SQyggvXZwI7ViLVCQowqbLXcwls/R31G4VhcpDFx3gdiqDz5g0D+ffr86o5/8lL+z3tHUhi0MNi8MjssfeYlkd2Mesqa7WGVrFz6We4u7K+6Goo+VQKIyg5ssDfRFcJf/EX4ap6LaDAQYhtq66ZuAlxD/pUtVvrBz9RaVjzQ2DhtKzKubEDYZz8kzlGTekSXKVGZkrkbIcez6QaT44MZwDZaJE7N3qf+PDJlNqOmPQgbmzsZFzSdZWvVX2skmXorYpvNBY4YH4IVIILpIdzns//i+mYK8wLXzl1xE9BT0ftAeIEBpdgdYG8ZCmANYFlfsx+0ixE5jKLUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s/17G6TJyOUZh3RPg4n2nDSh9frc4CA7KYxIfAQ9UnQ=;
 b=cQuq3/sdbhigz1+KHDj5NIFpTkWKco06j/TXVzIjaBBugiFdkwlYbGXdurdJWiMVIyqvsRMK0ohR6HlznDpTvIJzxVkzx2/F64lkz+eByWctKoiYJt1DYEB0VJiL2oC65qg3EdGtsLKnTD/waAqJ8OhUD+nxmbp6xnX6IwyBrflEo2Ki15CnDMS07/710FfzwObURDCHJThE++nONchPpgrF+qEA0ju65Gm9CN3DWRGHJH8u9nWAJyDFdzA5/pwyAN7V8+po/vKWj4VEjfa0LkgjvCnB/K31FOmgweYUjUqyH818O0xr5TRHjlPAT8c9PKByL/fySJT010o/zkXvtg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8253.eurprd04.prod.outlook.com (2603:10a6:102:1bf::7)
 by PR3PR04MB7449.eurprd04.prod.outlook.com (2603:10a6:102:86::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Thu, 19 Mar
 2026 14:23:55 +0000
Received: from PAXPR04MB8253.eurprd04.prod.outlook.com
 ([fe80::2b4e:8130:4419:d633]) by PAXPR04MB8253.eurprd04.prod.outlook.com
 ([fe80::2b4e:8130:4419:d633%3]) with mapi id 15.20.9723.018; Thu, 19 Mar 2026
 14:24:01 +0000
From: Ioana Ciornei <ioana.ciornei@nxp.com>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v4 3/3] net: dpaa2-mac: export standard statistics
Date: Thu, 19 Mar 2026 16:23:46 +0200
Message-Id: <20260319142346.2483232-4-ioana.ciornei@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260319142346.2483232-1-ioana.ciornei@nxp.com>
References: <20260319142346.2483232-1-ioana.ciornei@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM8P191CA0017.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:21a::22) To PAXPR04MB8253.eurprd04.prod.outlook.com
 (2603:10a6:102:1bf::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8253:EE_|PR3PR04MB7449:EE_
X-MS-Office365-Filtering-Correlation-Id: a77502e3-f71d-42e5-3ae6-08de85c32abf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|1800799024|376014|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	wchwyKJX7C9d09DEW7iGBe5Eob7HIB7MmsuL3CxvYT6UXQeY4Wi9R711+mT5kVIGpc7lqMkQ+JYSF75x+leJERQY5QeqFj8SndpBB4WJb8x/rn5ZoHyGe+KdvZj5I4/pHCliHw6l/G5BuLDmrehuLnePNxAu4JS7iiPx0ewQwfrW9nk1WwUKxKTctW4TgVVw38gIuwAT77NL1F4fQKXgpBrd2Kj4Mb0MoHNT52V9QaXSr5vX3qBTuid3k/ZH/ADRpQ5KGeZ6cIycMtEi6vWxQFLdZNM3QCVYG4xFaLlc6vb7gQ5QxxpQu2RtNd3aTsf7CoL/vqnldamu8anJmQWRzwRxxhLLq60+UY380A81rf5tRUYJ+T4o+buXaP0S/WbLkyhGilPFz4MUMQfZjSxEZgCTfPkNxh5GevUroJDpqFy7MRppFpWJHpUrbZw1v11YrdjwZ2sziVEAwp+xdoEvJ7pO1UfKstzLb6qseiob0wmNxI+HqZLvPGTenyHLVXaFG3T3zs9TCy9TWoDJz++c4a/F7R6yqDnuaJMovKIs3mh/eWTqJTHRGvm3PZuMe/2LdAvl4ZXojLX2Wto6BampX88Qo8Zz2V/luF4k4P7QdQpVPY9CPJDxhsX2rePIXW96P76B8cM6o3AZ7FantPv4jgq7R17kZ/5TNC89yCztK+i+ChJhrJjrylO2+xKFkP0k7AdwWF+IueAir3tJnLopK7MGgHqtLpBpO8v9TKcPa3I=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8253.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(1800799024)(376014)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?W52Ksb+SJlZl5NSrsh+u0d+4rVLIlpx2zGDIYjVFphnEUnhh3QHrD2F9ne3y?=
 =?us-ascii?Q?CWPLvdWvDby5a082O+tjR00LnbPQXRUsDAYy0bER5j8Pj2qNqo0J+/FSV7BE?=
 =?us-ascii?Q?RtD7xn27TWvc+D/ASxYzMLb6ezMM8FjQY4Va5Ii/2wGmN5IdBwjZUyF17BXY?=
 =?us-ascii?Q?iSR0matczzzDYtuBD73PaWPjfRtdPlyNnqzbMxfg5t5WNW9YaQgTCS78vHl+?=
 =?us-ascii?Q?acvvLc9vcrlc6ADZxbS6olqWJkhZuBv890P3IRapX9DVYRRrt6HhG/lBlFNS?=
 =?us-ascii?Q?vYHtvVVw72G1QtvvjFYmVSxlkFqTjlCO2LQhb3eE/WlipUU2dN1cWV9s/YCj?=
 =?us-ascii?Q?brcsk+Txk1OGadpM74ctn0yxD6t1DJl4LPnAvbT/Df3D/hhNvmZd9pkiL2Bi?=
 =?us-ascii?Q?pQzO74fSAkQ+oyXmq+y3wmW4tJgWB/qTgL5PzqkEur/yflR9tDOI2DY0Z3b9?=
 =?us-ascii?Q?dh3cwSLzNIhu5tdH3oaHn8c3foQ6+/Hqshx3kIAwKC5EOSSo/M+/UOlcY2Hn?=
 =?us-ascii?Q?RA5nTN+4td/3KLlwLN9JFTTrI02QVAGjRB0NeAmQ6t5twXpHQMF8mZwN7cLk?=
 =?us-ascii?Q?PeyX19cIufSU2togWbfo2MrQFwn3A+GjbF8k8jucIKx2G0rgGJ87ARbuRjv3?=
 =?us-ascii?Q?nZG3vED0FhzWl8s6IwIK04aG6O0y5ug4P6fg5l+/GoDqNk1WRSrPHbk5EeZD?=
 =?us-ascii?Q?N1Uel0IyF9FK5P6JQcucxuvx05CFyL/5bQqtkmQX6GvAp8GoMzHOi87gnima?=
 =?us-ascii?Q?/ZRW7WQ0vppGWByU0AWgtn87kcX5wJfz9ouP0J9du57p9RS2x1hF7R2/7ZIW?=
 =?us-ascii?Q?Q/6YSOZk8BYWP/qHEb5DoFtFOKIVcW1Y8WJcBzuj/gsX9CX0g4f0ZQCq75Ba?=
 =?us-ascii?Q?VL+qbazDSpZuIiOemutsn86KaKNFlIex1ps3DRp3BWhNfEkAWkk1AqnW41C6?=
 =?us-ascii?Q?VF/QORpEsnLBEk9xXkSfTok168Aj42hxVIvQrV+qn2XoalUyYCvSCUv0bI1r?=
 =?us-ascii?Q?e2LJ9AF7SFGbMmJhyGoTzwGdhHQml5wxfavj/0K6uGu8gpUSpMmA6PDvP42W?=
 =?us-ascii?Q?jf5ZeU/2I1mXpz3N6EdoFaRSWmq/r8ANKvP2OS5X8kDjVEB2zTjzDICKx1Km?=
 =?us-ascii?Q?4g7sWNdiCLbcOh+q3WqFV33TzOVKeNV/I2IJzjBMBfrF0cC1BzXhbUsDewJA?=
 =?us-ascii?Q?xOIwc+KQne1CTrXZZFJcBGV4j3OkPjQcMsa15L9OJ0vKg9ucb4P7QU+h4Yct?=
 =?us-ascii?Q?Ske8lck/GdiQg37KrpezfI/me0yelzoAdTJk4GeHt/RucDaRYKIUY76yeOLb?=
 =?us-ascii?Q?IlAurq9EIVmwTx1ZsyGPmWnEL4C3e17JChOEwe+HzjfDgmiIbd82kT53VVja?=
 =?us-ascii?Q?s5CdzuTITR6188+DgzrkeNYu9rRGiJ5hQoVAWM1NXd3v6qmBZN88V+8t2GcC?=
 =?us-ascii?Q?SH8Ylnz9rp3VwDuZHFYGWyMiG6R22k5fpm9rtQpl/k5dAjKqc28wHF8JN4Nx?=
 =?us-ascii?Q?PL5MGEGPjJ1R9ngKV5S1ccQumAPmY15NiG9JlkZyp6J930SG/ea4dFACSt70?=
 =?us-ascii?Q?a7kHcSw8tTrg02d7BZNT8lGQLWX1Z4WDG6ue6dVTPhsAzRRT0KvQFYOxWhCk?=
 =?us-ascii?Q?sa0Hw8M76KKGk7+gnwfi6jMRi77vetwsWk8574v2yhxM2Vrydzc5wE7HOFeq?=
 =?us-ascii?Q?UMWr2Yq1X0mJBN9I5jqpnVCCsZAgd8h4OQ7W5W8a5rEbaYlptYTitGIiejL3?=
 =?us-ascii?Q?t6KdYSfHiA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a77502e3-f71d-42e5-3ae6-08de85c32abf
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8253.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2026 14:24:01.6599
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lcGivsnesRDw/7GLOiKz/tfpnS4FHPDCooi6A3MPVu60NnM+6qQujNuT8Hcsw4Uhy8X4c8Az/0yL5vpXFXcu0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7449
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-269464-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ioana.ciornei@nxp.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-0.969];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,nxp.com:dkim,nxp.com:email,nxp.com:mid]
X-Rspamd-Queue-Id: A1C442CCF06
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Take advantage of all the newly added MAC counters available through the
MC API and export them through the standard statistics structures -
rmon, eth-ctrl, eth-mac and pause.

A new version based feature is added into dpaa2-mac -
DPAA2_MAC_FEATURE_STANDARD_STATS - and based on the two memory zones
needed for gathering the MAC counters are setup for each statistics
group.

The dpmac_counter structure is extended with a new field - size_t offset
- which is being used to instruct the dpaa2_mac_transfer_stats()
function where exactly to store a counter value inside the standard
statistics structure.

The newly added support is used both in the dpaa2-eth driver as well as
the dpaa2-switch one.

Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
---
Changes in v4:
- add dma_sync_single_for_device before calling the MC API
Changes in v3:
- reduce the number of lines that have more than 80 chars
Changes in v2:
- none

 .../ethernet/freescale/dpaa2/dpaa2-ethtool.c  |  61 ++++-
 .../net/ethernet/freescale/dpaa2/dpaa2-mac.c  | 214 ++++++++++++++++++
 .../net/ethernet/freescale/dpaa2/dpaa2-mac.h  |  17 ++
 .../freescale/dpaa2/dpaa2-switch-ethtool.c    |  48 +++-
 4 files changed, 338 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/freescale/dpaa2/dpaa2-ethtool.c b/drivers/net/ethernet/freescale/dpaa2/dpaa2-ethtool.c
index baab4f1c908d..59f5c778df38 100644
--- a/drivers/net/ethernet/freescale/dpaa2/dpaa2-ethtool.c
+++ b/drivers/net/ethernet/freescale/dpaa2/dpaa2-ethtool.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
 /* Copyright 2014-2016 Freescale Semiconductor Inc.
- * Copyright 2016-2022 NXP
+ * Copyright 2016-2022, 2024-2026 NXP
  */
 
 #include <linux/net_tstamp.h>
@@ -938,6 +938,61 @@ static void dpaa2_eth_get_channels(struct net_device *net_dev,
 				   channels->other_count;
 }
 
+static void
+dpaa2_eth_get_rmon_stats(struct net_device *net_dev,
+			 struct ethtool_rmon_stats *rmon_stats,
+			 const struct ethtool_rmon_hist_range **ranges)
+{
+	struct dpaa2_eth_priv *priv = netdev_priv(net_dev);
+
+	mutex_lock(&priv->mac_lock);
+
+	if (dpaa2_eth_has_mac(priv))
+		dpaa2_mac_get_rmon_stats(priv->mac, rmon_stats, ranges);
+
+	mutex_unlock(&priv->mac_lock);
+}
+
+static void dpaa2_eth_get_pause_stats(struct net_device *net_dev,
+				      struct ethtool_pause_stats *pause_stats)
+{
+	struct dpaa2_eth_priv *priv = netdev_priv(net_dev);
+
+	mutex_lock(&priv->mac_lock);
+
+	if (dpaa2_eth_has_mac(priv))
+		dpaa2_mac_get_pause_stats(priv->mac, pause_stats);
+
+	mutex_unlock(&priv->mac_lock);
+}
+
+static void dpaa2_eth_get_ctrl_stats(struct net_device *net_dev,
+				     struct ethtool_eth_ctrl_stats *ctrl_stats)
+{
+	struct dpaa2_eth_priv *priv = netdev_priv(net_dev);
+
+	mutex_lock(&priv->mac_lock);
+
+	if (dpaa2_eth_has_mac(priv))
+		dpaa2_mac_get_ctrl_stats(priv->mac, ctrl_stats);
+
+	mutex_unlock(&priv->mac_lock);
+}
+
+static void
+dpaa2_eth_get_eth_mac_stats(struct net_device *net_dev,
+			    struct ethtool_eth_mac_stats *eth_mac_stats)
+{
+	struct dpaa2_eth_priv *priv = netdev_priv(net_dev);
+
+	mutex_lock(&priv->mac_lock);
+
+	if (dpaa2_eth_has_mac(priv))
+		dpaa2_mac_get_eth_mac_stats(priv->mac, eth_mac_stats);
+
+	mutex_unlock(&priv->mac_lock);
+}
+
 const struct ethtool_ops dpaa2_ethtool_ops = {
 	.supported_coalesce_params = ETHTOOL_COALESCE_RX_USECS |
 				     ETHTOOL_COALESCE_USE_ADAPTIVE_RX,
@@ -962,4 +1017,8 @@ const struct ethtool_ops dpaa2_ethtool_ops = {
 	.get_coalesce = dpaa2_eth_get_coalesce,
 	.set_coalesce = dpaa2_eth_set_coalesce,
 	.get_channels = dpaa2_eth_get_channels,
+	.get_rmon_stats = dpaa2_eth_get_rmon_stats,
+	.get_pause_stats = dpaa2_eth_get_pause_stats,
+	.get_eth_ctrl_stats = dpaa2_eth_get_ctrl_stats,
+	.get_eth_mac_stats = dpaa2_eth_get_eth_mac_stats,
 };
diff --git a/drivers/net/ethernet/freescale/dpaa2/dpaa2-mac.c b/drivers/net/ethernet/freescale/dpaa2/dpaa2-mac.c
index 5a7fda6a2012..63947507b86e 100644
--- a/drivers/net/ethernet/freescale/dpaa2/dpaa2-mac.c
+++ b/drivers/net/ethernet/freescale/dpaa2/dpaa2-mac.c
@@ -18,20 +18,43 @@
 #define DPMAC_STATS_BUNDLE_VER_MAJOR		4
 #define DPMAC_STATS_BUNDLE_VER_MINOR		10
 
+#define DPMAC_STANDARD_STATS_VER_MAJOR		4
+#define DPMAC_STANDARD_STATS_VER_MINOR		11
+
 #define DPAA2_MAC_FEATURE_PROTOCOL_CHANGE	BIT(0)
 #define DPAA2_MAC_FEATURE_STATS_BUNDLE		BIT(1)
+#define DPAA2_MAC_FEATURE_STANDARD_STATS	BIT(2)
 
 struct dpmac_counter {
 	enum dpmac_counter_id id;
+	size_t offset;
 	const char *name;
 };
 
+#define DPMAC_COUNTER(counter_id, struct_name, struct_offset)	\
+	{							\
+		.id = counter_id,				\
+		.offset = offsetof(struct_name, struct_offset),	\
+	}
+
 #define DPMAC_UNSTRUCTURED_COUNTER(counter_id, counter_name)	\
 	{							\
 		.id = counter_id,				\
 		.name = counter_name,				\
 	}
 
+#define DPMAC_RMON_COUNTER(counter_id, struct_offset)		\
+	DPMAC_COUNTER(counter_id, struct ethtool_rmon_stats, struct_offset)
+
+#define DPMAC_PAUSE_COUNTER(counter_id, struct_offset)		\
+	DPMAC_COUNTER(counter_id, struct ethtool_pause_stats, struct_offset)
+
+#define DPMAC_CTRL_COUNTER(counter_id, struct_offset)		\
+	DPMAC_COUNTER(counter_id, struct ethtool_eth_ctrl_stats, struct_offset)
+
+#define DPMAC_MAC_COUNTER(counter_id, struct_offset)		\
+	DPMAC_COUNTER(counter_id, struct ethtool_eth_mac_stats, struct_offset)
+
 static const struct dpmac_counter dpaa2_mac_ethtool_stats[] = {
 	DPMAC_UNSTRUCTURED_COUNTER(DPMAC_CNT_ING_ALL_FRAME,  "[mac] rx all frames"),
 	DPMAC_UNSTRUCTURED_COUNTER(DPMAC_CNT_ING_GOOD_FRAME,  "[mac] rx frames ok"),
@@ -65,6 +88,60 @@ static const struct dpmac_counter dpaa2_mac_ethtool_stats[] = {
 
 #define DPAA2_MAC_NUM_ETHTOOL_STATS	ARRAY_SIZE(dpaa2_mac_ethtool_stats)
 
+static const struct dpmac_counter dpaa2_mac_rmon_stats[] = {
+	DPMAC_RMON_COUNTER(DPMAC_CNT_ING_FRAME_64, hist[0]),
+	DPMAC_RMON_COUNTER(DPMAC_CNT_ING_FRAME_127, hist[1]),
+	DPMAC_RMON_COUNTER(DPMAC_CNT_ING_FRAME_255, hist[2]),
+	DPMAC_RMON_COUNTER(DPMAC_CNT_ING_FRAME_511, hist[3]),
+	DPMAC_RMON_COUNTER(DPMAC_CNT_ING_FRAME_1023, hist[4]),
+	DPMAC_RMON_COUNTER(DPMAC_CNT_ING_FRAME_1518, hist[5]),
+	DPMAC_RMON_COUNTER(DPMAC_CNT_ING_FRAME_1519_MAX, hist[6]),
+	DPMAC_RMON_COUNTER(DPMAC_CNT_EGR_FRAME_64, hist_tx[0]),
+	DPMAC_RMON_COUNTER(DPMAC_CNT_EGR_FRAME_127, hist_tx[1]),
+	DPMAC_RMON_COUNTER(DPMAC_CNT_EGR_FRAME_255, hist_tx[2]),
+	DPMAC_RMON_COUNTER(DPMAC_CNT_EGR_FRAME_511, hist_tx[3]),
+	DPMAC_RMON_COUNTER(DPMAC_CNT_EGR_FRAME_1023, hist_tx[4]),
+	DPMAC_RMON_COUNTER(DPMAC_CNT_EGR_FRAME_1518, hist_tx[5]),
+	DPMAC_RMON_COUNTER(DPMAC_CNT_EGR_FRAME_1519_MAX, hist_tx[6]),
+	DPMAC_RMON_COUNTER(DPMAC_CNT_EGR_UNDERSIZED, undersize_pkts),
+	DPMAC_RMON_COUNTER(DPMAC_CNT_ING_OVERSIZED, oversize_pkts),
+	DPMAC_RMON_COUNTER(DPMAC_CNT_ING_FRAG, fragments),
+	DPMAC_RMON_COUNTER(DPMAC_CNT_ING_JABBER, jabbers),
+};
+
+#define DPAA2_MAC_NUM_RMON_STATS	ARRAY_SIZE(dpaa2_mac_rmon_stats)
+
+static const struct dpmac_counter dpaa2_mac_pause_stats[] = {
+	DPMAC_PAUSE_COUNTER(DPMAC_CNT_ING_VALID_PAUSE_FRAME, rx_pause_frames),
+	DPMAC_PAUSE_COUNTER(DPMAC_CNT_EGR_VALID_PAUSE_FRAME, tx_pause_frames),
+};
+
+#define DPAA2_MAC_NUM_PAUSE_STATS	ARRAY_SIZE(dpaa2_mac_pause_stats)
+
+static const struct dpmac_counter dpaa2_mac_eth_ctrl_stats[] = {
+	DPMAC_CTRL_COUNTER(DPMAC_CNT_ING_CONTROL_FRAME, MACControlFramesReceived),
+	DPMAC_CTRL_COUNTER(DPMAC_CNT_EGR_CONTROL_FRAME, MACControlFramesTransmitted),
+};
+
+#define DPAA2_MAC_NUM_ETH_CTRL_STATS	ARRAY_SIZE(dpaa2_mac_eth_ctrl_stats)
+
+static const struct dpmac_counter dpaa2_mac_eth_mac_stats[] = {
+	DPMAC_MAC_COUNTER(DPMAC_CNT_EGR_GOOD_FRAME, FramesTransmittedOK),
+	DPMAC_MAC_COUNTER(DPMAC_CNT_ING_GOOD_FRAME, FramesReceivedOK),
+	DPMAC_MAC_COUNTER(DPMAC_CNT_ING_FCS_ERR, FrameCheckSequenceErrors),
+	DPMAC_MAC_COUNTER(DPMAC_CNT_ING_ALIGN_ERR, AlignmentErrors),
+	DPMAC_MAC_COUNTER(DPMAC_CNT_EGR_ALL_BYTE, OctetsTransmittedOK),
+	DPMAC_MAC_COUNTER(DPMAC_CNT_EGR_ERR_FRAME, FramesLostDueToIntMACXmitError),
+	DPMAC_MAC_COUNTER(DPMAC_CNT_ING_ALL_BYTE, OctetsReceivedOK),
+	DPMAC_MAC_COUNTER(DPMAC_CNT_ING_FRAME_DISCARD_NOT_TRUNC, FramesLostDueToIntMACRcvError),
+	DPMAC_MAC_COUNTER(DPMAC_CNT_EGR_MCAST_FRAME, MulticastFramesXmittedOK),
+	DPMAC_MAC_COUNTER(DPMAC_CNT_EGR_BCAST_FRAME, BroadcastFramesXmittedOK),
+	DPMAC_MAC_COUNTER(DPMAC_CNT_ING_MCAST_FRAME, MulticastFramesReceivedOK),
+	DPMAC_MAC_COUNTER(DPMAC_CNT_ING_BCAST_FRAME, BroadcastFramesReceivedOK),
+};
+
+#define DPAA2_MAC_NUM_ETH_MAC_STATS	ARRAY_SIZE(dpaa2_mac_eth_mac_stats)
+
 static void dpaa2_mac_setup_stats(struct dpaa2_mac *mac,
 				  struct dpaa2_mac_stats *stats,
 				  size_t num_stats,
@@ -147,6 +224,10 @@ static void dpaa2_mac_detect_features(struct dpaa2_mac *mac)
 	if (dpaa2_mac_cmp_ver(mac, DPMAC_STATS_BUNDLE_VER_MAJOR,
 			      DPMAC_STATS_BUNDLE_VER_MINOR) >= 0)
 		mac->features |= DPAA2_MAC_FEATURE_STATS_BUNDLE;
+
+	if (dpaa2_mac_cmp_ver(mac, DPMAC_STANDARD_STATS_VER_MAJOR,
+			      DPMAC_STANDARD_STATS_VER_MINOR) >= 0)
+		mac->features |= DPAA2_MAC_FEATURE_STANDARD_STATS;
 }
 
 static int phy_mode(enum dpmac_eth_if eth_if, phy_interface_t *if_mode)
@@ -624,6 +705,24 @@ int dpaa2_mac_open(struct dpaa2_mac *mac)
 				      DPAA2_MAC_NUM_ETHTOOL_STATS,
 				      dpaa2_mac_ethtool_stats);
 
+	if (mac->features & DPAA2_MAC_FEATURE_STANDARD_STATS) {
+		dpaa2_mac_setup_stats(mac, &mac->rmon_stats,
+				      DPAA2_MAC_NUM_RMON_STATS,
+				      dpaa2_mac_rmon_stats);
+
+		dpaa2_mac_setup_stats(mac, &mac->pause_stats,
+				      DPAA2_MAC_NUM_PAUSE_STATS,
+				      dpaa2_mac_pause_stats);
+
+		dpaa2_mac_setup_stats(mac, &mac->eth_ctrl_stats,
+				      DPAA2_MAC_NUM_ETH_CTRL_STATS,
+				      dpaa2_mac_eth_ctrl_stats);
+
+		dpaa2_mac_setup_stats(mac, &mac->eth_mac_stats,
+				      DPAA2_MAC_NUM_ETH_MAC_STATS,
+				      dpaa2_mac_eth_mac_stats);
+	}
+
 	return 0;
 
 err_close_dpmac:
@@ -639,11 +738,126 @@ void dpaa2_mac_close(struct dpaa2_mac *mac)
 		dpaa2_mac_clear_stats(mac, &mac->ethtool_stats,
 				      DPAA2_MAC_NUM_ETHTOOL_STATS);
 
+	if (mac->features & DPAA2_MAC_FEATURE_STANDARD_STATS) {
+		dpaa2_mac_clear_stats(mac, &mac->rmon_stats,
+				      DPAA2_MAC_NUM_RMON_STATS);
+		dpaa2_mac_clear_stats(mac, &mac->pause_stats,
+				      DPAA2_MAC_NUM_PAUSE_STATS);
+		dpaa2_mac_clear_stats(mac, &mac->eth_ctrl_stats,
+				      DPAA2_MAC_NUM_ETH_CTRL_STATS);
+		dpaa2_mac_clear_stats(mac, &mac->eth_mac_stats,
+				      DPAA2_MAC_NUM_ETH_MAC_STATS);
+	}
+
 	dpmac_close(mac->mc_io, 0, dpmac_dev->mc_handle);
 	if (mac->fw_node)
 		fwnode_handle_put(mac->fw_node);
 }
 
+static void dpaa2_mac_transfer_stats(const struct dpmac_counter *counters,
+				     size_t num_counters, void *s,
+				     __le64 *cnt_values)
+{
+	for (size_t i = 0; i < num_counters; i++) {
+		u64 *p = s + counters[i].offset;
+
+		*p = le64_to_cpu(cnt_values[i]);
+	}
+}
+
+static const struct ethtool_rmon_hist_range dpaa2_mac_rmon_ranges[] = {
+	{   64,   64 },
+	{   65,  127 },
+	{  128,  255 },
+	{  256,  511 },
+	{  512, 1023 },
+	{ 1024, 1518 },
+	{ 1519, DPAA2_ETH_MFL },
+	{},
+};
+
+static void dpaa2_mac_get_standard_stats(struct dpaa2_mac *mac,
+					 struct dpaa2_mac_stats *stats,
+					 size_t num_cnt,
+					 const struct dpmac_counter *counters,
+					 void *s)
+{
+	struct device *dev = mac->net_dev->dev.parent;
+	struct fsl_mc_device *dpmac_dev = mac->mc_dev;
+	size_t values_size = num_cnt * sizeof(u64);
+	int err;
+
+	if (!(mac->features & DPAA2_MAC_FEATURE_STANDARD_STATS))
+		return;
+
+	if (!stats->idx_dma_mem || !stats->values_dma_mem)
+		return;
+
+	dma_sync_single_for_device(dev, stats->values_iova, values_size,
+				   DMA_FROM_DEVICE);
+
+	err = dpmac_get_statistics(mac->mc_io, 0, dpmac_dev->mc_handle,
+				   stats->idx_iova, stats->values_iova,
+				   num_cnt);
+	if (err) {
+		netdev_err(mac->net_dev, "%s: dpmac_get_statistics() = %d\n",
+			   __func__, err);
+		return;
+	}
+
+	dma_sync_single_for_cpu(dev, stats->values_iova, values_size,
+				DMA_FROM_DEVICE);
+
+	dpaa2_mac_transfer_stats(counters, num_cnt, s, stats->values_dma_mem);
+}
+
+void dpaa2_mac_get_rmon_stats(struct dpaa2_mac *mac,
+			      struct ethtool_rmon_stats *s,
+			      const struct ethtool_rmon_hist_range **ranges)
+{
+	if (s->src != ETHTOOL_MAC_STATS_SRC_AGGREGATE)
+		return;
+
+	dpaa2_mac_get_standard_stats(mac, &mac->rmon_stats,
+				     DPAA2_MAC_NUM_RMON_STATS,
+				     dpaa2_mac_rmon_stats, s);
+
+	*ranges = dpaa2_mac_rmon_ranges;
+}
+
+void dpaa2_mac_get_pause_stats(struct dpaa2_mac *mac,
+			       struct ethtool_pause_stats *s)
+{
+	if (s->src != ETHTOOL_MAC_STATS_SRC_AGGREGATE)
+		return;
+
+	dpaa2_mac_get_standard_stats(mac, &mac->pause_stats,
+				     DPAA2_MAC_NUM_PAUSE_STATS,
+				     dpaa2_mac_pause_stats, s);
+}
+
+void dpaa2_mac_get_ctrl_stats(struct dpaa2_mac *mac,
+			      struct ethtool_eth_ctrl_stats *s)
+{
+	if (s->src != ETHTOOL_MAC_STATS_SRC_AGGREGATE)
+		return;
+
+	dpaa2_mac_get_standard_stats(mac, &mac->eth_ctrl_stats,
+				     DPAA2_MAC_NUM_ETH_CTRL_STATS,
+				     dpaa2_mac_eth_ctrl_stats, s);
+}
+
+void dpaa2_mac_get_eth_mac_stats(struct dpaa2_mac *mac,
+				 struct ethtool_eth_mac_stats *s)
+{
+	if (s->src != ETHTOOL_MAC_STATS_SRC_AGGREGATE)
+		return;
+
+	dpaa2_mac_get_standard_stats(mac, &mac->eth_mac_stats,
+				     DPAA2_MAC_NUM_ETH_MAC_STATS,
+				     dpaa2_mac_eth_mac_stats, s);
+}
+
 int dpaa2_mac_get_sset_count(void)
 {
 	return DPAA2_MAC_NUM_ETHTOOL_STATS;
diff --git a/drivers/net/ethernet/freescale/dpaa2/dpaa2-mac.h b/drivers/net/ethernet/freescale/dpaa2/dpaa2-mac.h
index 6f4981627961..98c725f609e9 100644
--- a/drivers/net/ethernet/freescale/dpaa2/dpaa2-mac.h
+++ b/drivers/net/ethernet/freescale/dpaa2/dpaa2-mac.h
@@ -36,6 +36,10 @@ struct dpaa2_mac {
 	struct phy *serdes_phy;
 
 	struct dpaa2_mac_stats ethtool_stats;
+	struct dpaa2_mac_stats rmon_stats;
+	struct dpaa2_mac_stats pause_stats;
+	struct dpaa2_mac_stats eth_ctrl_stats;
+	struct dpaa2_mac_stats eth_mac_stats;
 };
 
 static inline bool dpaa2_mac_is_type_phy(struct dpaa2_mac *mac)
@@ -61,6 +65,19 @@ void dpaa2_mac_get_strings(u8 **data);
 
 void dpaa2_mac_get_ethtool_stats(struct dpaa2_mac *mac, u64 *data);
 
+void dpaa2_mac_get_rmon_stats(struct dpaa2_mac *mac,
+			      struct ethtool_rmon_stats *s,
+			      const struct ethtool_rmon_hist_range **ranges);
+
+void dpaa2_mac_get_pause_stats(struct dpaa2_mac *mac,
+			       struct ethtool_pause_stats *s);
+
+void dpaa2_mac_get_ctrl_stats(struct dpaa2_mac *mac,
+			      struct ethtool_eth_ctrl_stats *s);
+
+void dpaa2_mac_get_eth_mac_stats(struct dpaa2_mac *mac,
+				 struct ethtool_eth_mac_stats *s);
+
 void dpaa2_mac_start(struct dpaa2_mac *mac);
 
 void dpaa2_mac_stop(struct dpaa2_mac *mac);
diff --git a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch-ethtool.c b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch-ethtool.c
index a888f6e6e9b0..f5d9321c7ef9 100644
--- a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch-ethtool.c
+++ b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch-ethtool.c
@@ -3,7 +3,7 @@
  * DPAA2 Ethernet Switch ethtool support
  *
  * Copyright 2014-2016 Freescale Semiconductor Inc.
- * Copyright 2017-2018 NXP
+ * Copyright 2017-2018, 2024-2026 NXP
  *
  */
 
@@ -210,6 +210,49 @@ static void dpaa2_switch_ethtool_get_stats(struct net_device *netdev,
 	mutex_unlock(&port_priv->mac_lock);
 }
 
+static void
+dpaa2_switch_get_rmon_stats(struct net_device *netdev,
+			    struct ethtool_rmon_stats *rmon_stats,
+			    const struct ethtool_rmon_hist_range **ranges)
+{
+	struct ethsw_port_priv *port_priv = netdev_priv(netdev);
+
+	mutex_lock(&port_priv->mac_lock);
+
+	if (dpaa2_switch_port_has_mac(port_priv))
+		dpaa2_mac_get_rmon_stats(port_priv->mac, rmon_stats, ranges);
+
+	mutex_unlock(&port_priv->mac_lock);
+}
+
+static void
+dpaa2_switch_get_ctrl_stats(struct net_device *net_dev,
+			    struct ethtool_eth_ctrl_stats *ctrl_stats)
+{
+	struct ethsw_port_priv *port_priv = netdev_priv(net_dev);
+
+	mutex_lock(&port_priv->mac_lock);
+
+	if (dpaa2_switch_port_has_mac(port_priv))
+		dpaa2_mac_get_ctrl_stats(port_priv->mac, ctrl_stats);
+
+	mutex_unlock(&port_priv->mac_lock);
+}
+
+static void
+dpaa2_switch_get_eth_mac_stats(struct net_device *net_dev,
+			       struct ethtool_eth_mac_stats *eth_mac_stats)
+{
+	struct ethsw_port_priv *port_priv = netdev_priv(net_dev);
+
+	mutex_lock(&port_priv->mac_lock);
+
+	if (dpaa2_switch_port_has_mac(port_priv))
+		dpaa2_mac_get_eth_mac_stats(port_priv->mac, eth_mac_stats);
+
+	mutex_unlock(&port_priv->mac_lock);
+}
+
 const struct ethtool_ops dpaa2_switch_port_ethtool_ops = {
 	.get_drvinfo		= dpaa2_switch_get_drvinfo,
 	.get_link		= ethtool_op_get_link,
@@ -218,4 +261,7 @@ const struct ethtool_ops dpaa2_switch_port_ethtool_ops = {
 	.get_strings		= dpaa2_switch_ethtool_get_strings,
 	.get_ethtool_stats	= dpaa2_switch_ethtool_get_stats,
 	.get_sset_count		= dpaa2_switch_ethtool_get_sset_count,
+	.get_rmon_stats		= dpaa2_switch_get_rmon_stats,
+	.get_eth_ctrl_stats	= dpaa2_switch_get_ctrl_stats,
+	.get_eth_mac_stats	= dpaa2_switch_get_eth_mac_stats,
 };
-- 
2.25.1


