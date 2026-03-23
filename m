Return-Path: <netdev+bounces-270497-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mMX7N3QpwWmbRAQAu9opvQ
	(envelope-from <netdev+bounces-270497-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 12:52:20 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D94052F1777
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 12:52:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0D3D730152D4
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 11:51:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EEF939A07D;
	Mon, 23 Mar 2026 11:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Wmz1qQx6"
X-Original-To: netdev@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013008.outbound.protection.outlook.com [40.107.159.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56A1F39B951;
	Mon, 23 Mar 2026 11:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774266657; cv=fail; b=UohI6ujrEZ/KW5I965y7HvS+r9UUvU23iXRC26juwi7n9oqsSSC5nHu5a0tVD0igAy0ZmoF6Vm4rfoMg9cMz9ilWhsR8kwqjpNzrmARuPZN9u7D7EUEYWngJTvIvkVU/b2BqFXUjLIEIy9z1wwrz5ICS7YcCzrla45HqnbTgVg4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774266657; c=relaxed/simple;
	bh=pvp6QbB3ELf0mIMfDx0Bq0CFtUB5yi9WgcRprjFCfxM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=APvqpBuybd2yaZWi3KPdgGPXwW+8Lch+cNu8ZYYjQvmaDoGs39x5XuqEELSOhLgtEZ7PU2HFFLS/nx49rulay80jqzPeISLV3AXOnpMEn6Nj5bYKCQN7VDSyyfiWp9UYOuikb3m8WkqBoEHuxmr7N48eU7E2QvR4nDFY7sKHeG4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Wmz1qQx6; arc=fail smtp.client-ip=40.107.159.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l45efW74fOBIzyQq4OQ3aUWYCM6Z2HncoylKcc9zbqAHXlPC8Q+ASCuwjsioYljInjiX074pj7GwL0LxnAHLz5/qTDHtS2L7Ew/ABQ9eiYSDVCEddc26z1/0nEv2zjcRpl8ww0n1hRDGZmWxoNl7Ti9f4Hf83kH1ikgxYFqyW+RJNQhQqgvrr9U3LRDslhEjVxMMdX4TkyxCV/38HLUqftrtDhEU1yMtRu+8U86RsGavqiMqRLSd0lGyfxNHj36a8nQHSNsCcLlBGtK8XEVKfdB66Yb4eRO8Ri27Hlc2cs6y9xnnWVyFnIeAk/15d3rnNqTfWQ8C/LwjSaMMF8ta7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/dPGme3Ar7tIWGonVbCdHZIrtCY6l19//dF9AhZj3p8=;
 b=umAcvVn986wVKRSfmSO8sFnGI1cPVvYJSNqQk4vnT+uMHSHWvEbo1Jbdb3F1Ph/tN4iec0QRPbXZVJin6GAy7jQ9xC8OK97YBwuQ1MTnVHyi4gfclKu3ObQmgvItl3IePcLm+take9Cy2TgvcUI+saPzDzCowuInsQ9wnclUdGPjtJn06UjzFKAdUHIjKzgExw6IEd9dVfIsm7ZarFruZDwidk8w6oNshhhZOo8/YBxvfGDuxN/TZBtaypSgm59bQb1+wxzCOZ8u8lffWFe4dMER3xhYjIWvaJyQPwla8GJZYlVR22QCGJ7MTNWeOm0+A5xzO2QazR7OzjtZ3FZiHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/dPGme3Ar7tIWGonVbCdHZIrtCY6l19//dF9AhZj3p8=;
 b=Wmz1qQx6Oj5kXT9PZ79DhX5HJLR45GeJS22z1hTTSI0AbevA/o2Ryv/BKo9Lby5+pd75u1/Up2Mk5kh6fKUwbsz9AfrFpc1BOHBZeVL1yM6IDZ48e8c1FIVli+4ZolMGt1WgeyyjEvHVDJ2Pva00xfZmA226ihE/W3dWRWuWUnq8BZPg5P6MfRWGKu58kyAKPhv4D97lTNV2JkzQnXxRa9A5f2d4UTfnZTAIUZPvGn1b8R4Gur/710L1Hc85X23m/wFbKUHGf16GGDx7maP5T9LWraT15lmEYmwRaiTi+YAhTkHGYirf0Gueg9eSvnE9Y7oqfVOtdRU6mQAZx0zsMQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8253.eurprd04.prod.outlook.com (2603:10a6:102:1bf::7)
 by AS5PR04MB9924.eurprd04.prod.outlook.com (2603:10a6:20b:67e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.25; Mon, 23 Mar
 2026 11:50:45 +0000
Received: from PAXPR04MB8253.eurprd04.prod.outlook.com
 ([fe80::2b4e:8130:4419:d633]) by PAXPR04MB8253.eurprd04.prod.outlook.com
 ([fe80::2b4e:8130:4419:d633%3]) with mapi id 15.20.9723.022; Mon, 23 Mar 2026
 11:50:50 +0000
From: Ioana Ciornei <ioana.ciornei@nxp.com>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v5 3/3] net: dpaa2-mac: export standard statistics
Date: Mon, 23 Mar 2026 13:50:39 +0200
Message-Id: <20260323115039.3932600-4-ioana.ciornei@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260323115039.3932600-1-ioana.ciornei@nxp.com>
References: <20260323115039.3932600-1-ioana.ciornei@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4PR10CA0009.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:5dc::12) To PAXPR04MB8253.eurprd04.prod.outlook.com
 (2603:10a6:102:1bf::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8253:EE_|AS5PR04MB9924:EE_
X-MS-Office365-Filtering-Correlation-Id: 2351bf2b-1105-4388-4a45-08de88d26e0d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|19092799006|376014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	ofkYqgzbA4oRmUu2giZ9HNi4senPfoakTc9JrlXWgp//RLoVPyf397KXOqy8F3IQYXTYv4vyjwmIzzT1ovZjf3ED5EfNJbtoWZ2W14Etx51CbZ4G0iAhyBGm0KJDeC8zDrjL9yei+UploSnSlgKXaQeGbkWzCnFm0qM9kiHmI3G7K0VYjRm80LLmBEJ5msGy+bxAVOcJi7EIRmYL/Eb50LghgWzIxbbHSo+x5JaYcS0ns4CvqYIVP+XFmbG7Kg4ZTcSKymcgzdcMpBtjFJ0wrBvXC7OSiFjWKJ0MMscc6KY0UZdRGzfQxqlRO2Cdoq74RC7TKYEbQ27c8g1Cw7JB3nF2zX8z1snZnckOm1qvP2Fntop7F7zzROMPYope1Mdt90KpjubKBj1fcWKFklrIIhrcNJeSU3abBuARBH16cHtXjvhzz0mbaJhiG8BYomrDf+eKZeo9GrLQIjryL12AJi7+IMwqyaAV2mTXWkmejl4J5Y/RPMxguPleoRlA4o4/NY6mzDGTrKQTlztYzUzef48JEmcBV/9+Fx7AVePDVYrlJ7xpfeBpEexDBYRfw2+2ogCoAAG7hS2HBVMT/FJ/ppOpTEGrlOjrp1CU5A+tbizuotfAks99599Bq/VBam9ferTmQY3DOi0nHecrAn3TmA8HDXHght4EdC2KPBETmlQVYMR9s4Lew7S8xOXs3prdeQfFG6+vR+mUwLbuWuaFKFwY4v8MtdSWY9e9SHvSoHM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8253.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(376014)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?EMITXIeIkY6l0h4jjqRcoTT8U2m8a2CWn5vPol4DE3H70K0GBgaL5Lu/iJNf?=
 =?us-ascii?Q?78RKmyiKqtgweKw+kpicmByZdVXevd3IP+QJ+ezFvxM9/waOfwA1z5KLbWY+?=
 =?us-ascii?Q?RTVctaW6B3usR1rMGf/3IBLV1QMP0vGCbSqm012HBMtLizUCj/V2Xf9kKnbG?=
 =?us-ascii?Q?n0WLfn4Tjb77Qi0rKKpnK1V+WYgUAt6RS7H6DfAK3ZzzViOJB7Jf8nCa0Mzg?=
 =?us-ascii?Q?bj/514t3xqx73ZPQKGKhLTjKubfFVZkZ+RpxgqCq915YKu6WcuKtK8FFeLwG?=
 =?us-ascii?Q?IoapRhcyybQEUxvHCyuKdb2Ba+Lpg8rZke27Mhj+Jr6K1knsx/qAZFXlS9zw?=
 =?us-ascii?Q?TEhPHChqz0fdoCxRnEyXX5KcvfosRjjP7FL9SRffYMvBP3adlWtmY///zMuz?=
 =?us-ascii?Q?RDL216bbbWNUF0OUvibZHKQ+horo8x1xQdxJ3+WK7aaOhjby/sCIl2Baokjy?=
 =?us-ascii?Q?LybWZonky1KjDqcMadhFcQ1j4LDYBlaItKo6hX+vmsXoYjjGJ+XceANMcXxL?=
 =?us-ascii?Q?iGZsw7y9sui+Ap1CNYfvNPBAssLcl1SFpktv4SQugmIDskXr6UdIZz8f05eE?=
 =?us-ascii?Q?8dDA/RZokHLPg98UuMpQrk/DqmWdtjsiY7kssowmVP6Xqc7eR89Mh7lswSnx?=
 =?us-ascii?Q?FdYaJgKbm/WDXiu2ORBHhpDR8v4xZaQ7sQTQBGkGfE4tDfXsf6JiGKMjp9BB?=
 =?us-ascii?Q?vFZy0Xi/507V7SIKnyIdI0JAKMwBwGD/dQ3RZYF9QCUhZlVPDS9+CMRXI2lS?=
 =?us-ascii?Q?RrcjGv38MDRMxU30/wZB+T+MZKI3zHzNkbPmuRmmKmUdnYT81uIFjNb6I/XH?=
 =?us-ascii?Q?eiz4sPrP5QAmQbv6vWnsjaBQ8rason2qh5/29YchjM3SnBizgXGqEKBxL+ET?=
 =?us-ascii?Q?3jpJxO1hERsKOmu2oVkHDZs/pXY1JyJLWAqns2iyfdelcJDMvwMGcN7ffLoZ?=
 =?us-ascii?Q?nyAwWy8yKuM9xTgBAcqMMjF+uWUL5P1KCnFucCAsMnWdwqTwXCn+YrHVMpIx?=
 =?us-ascii?Q?F+AbQQkU7NcFTZ9MUPYdbs3W+mQ4qdZHbiVWa2oZfaBCDfvA8L8B/WCOl1ja?=
 =?us-ascii?Q?ZvwwbxaYUzFR7lPLjxbxBfeUy9s/Xvxw2NMV4fkPUGTZ75BrZlvLTM8BJFoR?=
 =?us-ascii?Q?qf7hlUsT+Eosv6n9Zs26edg8Xlq51b+TnI2c3i6e6Dx2f2hp3fRJBdpeo48E?=
 =?us-ascii?Q?BhSRtf57IjFobNm9pKKme8a+h/HO13dG54vizbisXMfQ500/Ouu2+ln2EcQu?=
 =?us-ascii?Q?JlU3FA07YFSLclhOPfxChZWGTJGZN595OMQMnk2pXB6EbHESXpC5wcpE9Je7?=
 =?us-ascii?Q?wnfqm4fMhyLWl60bgzy9RHJhQ1TLdLA8imIdATRvRfXsZ1Ll7SzWDhmQqLKu?=
 =?us-ascii?Q?zRqLP26dOlIBSTuloWybNq4wsdwvDyVNmNIfFHdnuWgI0v+mNHChtu+pwO6H?=
 =?us-ascii?Q?oy4Ko0h76pb2KfV/62/Mxks4UrLpH55XxLh9oHh9FPxSCrMLAFDBLFcHUqXH?=
 =?us-ascii?Q?kB5YXPnA4SicIDbUSpAz5TWesJCD4gj3dwbjOJ1EL2c2sz9MZipmnAO2ViRL?=
 =?us-ascii?Q?AOdEs+YGrECE6lny2N1BBKcHZ6ji5M+7aPV7NjL7BkXpIddJzYb9r+WEOQAZ?=
 =?us-ascii?Q?FWQ6/ocqWTc9bdQYitzBjHMgfEFqbuhaWE6TAV1yrz13W3i2ncqXOx4VSNKm?=
 =?us-ascii?Q?oe9v4cvIW8kODboGmD6Sww28bMzZxWQgKbnuU5L05ug5HuGvrgCGyf+V/KJB?=
 =?us-ascii?Q?hImjB4qOSQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2351bf2b-1105-4388-4a45-08de88d26e0d
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8253.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2026 11:50:50.5836
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kmTC8LNt74DciOhaFWSO7JrX/9RNu5eMmHckEe7tY5uTMYbjx2Ojh3PAF7H7eWh8+4p0WlhHqkfhAFsQNsd9OA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB9924
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
	TAGGED_FROM(0.00)[bounces-270497-lists,netdev=lfdr.de];
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
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:dkim,nxp.com:email,nxp.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D94052F1777
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
Changes in v5:
- use DPMAC_CNT_ING_UNDERSIZED for the rmon etherStatsUndersizePkts
  counter
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
index 5a7fda6a2012..ad812ebf3139 100644
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
+	DPMAC_RMON_COUNTER(DPMAC_CNT_ING_UNDERSIZED, undersize_pkts),
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


