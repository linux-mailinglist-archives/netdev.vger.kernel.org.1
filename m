Return-Path: <netdev+bounces-267099-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wFLPBHDNsmmPPwAAu9opvQ
	(envelope-from <netdev+bounces-267099-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 15:28:00 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B70D227357D
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 15:27:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2752730CEAEB
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 14:23:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56E7537188E;
	Thu, 12 Mar 2026 14:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="mfzTbfrf"
X-Original-To: netdev@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012026.outbound.protection.outlook.com [52.101.66.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49CAC36C9F4;
	Thu, 12 Mar 2026 14:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773325404; cv=fail; b=sSmw0dfy6XVeMMZ7rOK+j4wfIIhrx0r5Oe6QGC8okMTSfB1wEqkSDr+ABZkYBs/P9e5+5ASM1YxaIrFiXk8uz54nzlJyZ6hDBYwcNoh/phXJyVMVMWSATpaPubzqkweHnMyXNYmQpnoD+EiT6eaxJ/ziNFCbfx6DOF7U7W9ynB8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773325404; c=relaxed/simple;
	bh=vF83PytqkYlk2lAukpM97rHmOiAhDI6k1G8P2J4+pe8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=b1PWU1nwthJFfoFAQu1dJqisY0bsHRy7psoxqsLzoxQeTvACYOdwrwGj9eX5IF3S7wF+/NffdftrEtatXh8tsqaLd43U3G4l20Mo/g2JTLZGt/iZEFmkywl3RM9tS5e/XcY3Rqp7JAqlufP69oRhj6bgRLnML9r4asRZQGX665k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=mfzTbfrf; arc=fail smtp.client-ip=52.101.66.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DyUGL0sa9R12tyTadINr9EY5o8F6YFDHXAlGioD4SesTDxOUVqkPZyJWTc3fuP5gNPtQBZNMYUl+m9zi0FyDhdAIQKEb0ukGmhsiCNq7iNIltQH6F2XYFetPue3ZR8zGg2mTNTnhY3FJ6EKBy1zCegcMVovf2v1/RR6vj7S3S4BEdkGy9HNSxyKXmKjzAZPYiEZFMilwyu7/7pGAAB8XYh6+D2hgXf4heSMgwQsxLCMcgO5K7vMnOnaZ7sNmznS1+DzVYjM/uUNi9D28c8KBZzCgNHtVu3aTZUI/wIVgfkYugt6Kn1wCGSMoOcVqIuGfTXk9aL2owDYdIGcC5teYtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XQ/uTjge2gwt6ObfhoqKCW/6SLE2X2XthpwLyIZm2wQ=;
 b=WN48U0n0rLZoalddHxd73p2DRt/htj8+WSOzXVEr/VbplR5DIv2U496ToXEdLh0BuR2F1MzTWCdyrG0UcdM1PGzTRKwYcOY6E+ALiVjBG7VNTKuFQ1zSPfvS6XbXtE8w2BX4kovRA0nJ0VqqSZUWFPhdyZkwGUJHbtZe2pLy4phSAVQRm9l/PTht/k/DFDCRbmgit7VQwhKA1ANODJamCUHfn7HFcrerAJv+Tny0R3JcIsaeIjAfujkWoHE2LWP51+za+vX/ykzihMaXLMot3QI/dqw0t862KYHu16lG9aC8NBSetF75jN56DYdIvKSNjrEK+lK/Q1UeTZv62/K6Lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XQ/uTjge2gwt6ObfhoqKCW/6SLE2X2XthpwLyIZm2wQ=;
 b=mfzTbfrfG7yni9+V3SJy2eL/Y+wMxHU6CCxnbfeGUZgPP8x3Mw/vR0pq1k8J+6i36Az3khrYEzuXZhbx4Yfee4vF+9F6FI0ta5FaMGxfm2aCFCM8ZCRfGyIxM/hJWJeAQuqGRGlMuoZVuAhsYq3gt0IXsNUVgUf3dNcHciuTqDlnqCWVDDwebkGzWRkNOBYviMpSMm3wq/tSnkdRxBUiXpo2UoFQLDXEYvxK2B+lJ1Qx6SVn7zB/+1nuOmCsV0rNrenn1TE51PrZhdI4iN43eECPANvk5KqbE02puDP9oXuusoVI515aNJr45XqWScOMc/XrT8gpnyH0dteRyA7DQA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8253.eurprd04.prod.outlook.com (2603:10a6:102:1bf::7)
 by GV4PR04MB11773.eurprd04.prod.outlook.com (2603:10a6:150:2d9::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.12; Thu, 12 Mar
 2026 14:23:16 +0000
Received: from PAXPR04MB8253.eurprd04.prod.outlook.com
 ([fe80::2b4e:8130:4419:d633]) by PAXPR04MB8253.eurprd04.prod.outlook.com
 ([fe80::2b4e:8130:4419:d633%3]) with mapi id 15.20.9700.010; Thu, 12 Mar 2026
 14:23:16 +0000
From: Ioana Ciornei <ioana.ciornei@nxp.com>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	Simon Horman <horms@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net-next v2 3/3] net: dpaa2-mac: export standard statistics
Date: Thu, 12 Mar 2026 16:22:49 +0200
Message-Id: <20260312142249.297192-4-ioana.ciornei@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260312142249.297192-1-ioana.ciornei@nxp.com>
References: <20260312142249.297192-1-ioana.ciornei@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P191CA0030.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d9::16) To PAXPR04MB8253.eurprd04.prod.outlook.com
 (2603:10a6:102:1bf::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8253:EE_|GV4PR04MB11773:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e5d4b94-238c-436e-984e-08de8042e686
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|19092799006|1800799024|376014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	0a4A0WEQi/E+LJapPeVPCBo60HsaawupVau8gNdnVPSpSES2WDEhmsFL+h+d5yf/w9HIp/kee52Eg4kADFOm1d9f/aPFNQ1QGRXv4H9iPgg/tlASXHeyBf1t/CCRvoY7VU3ec2kIwHvF3ProAMBraCfpXgWJOqY2GqO1FZiVvyTNx5Cna7QCL8OejEfCQa/BWGXuWFfS3KfPelSgp2+eGEfs0AD6QPruT0kUY0ufEi7lmTfoUc/pGbGJV89Usz06ql2r7qO0NPgkuT97fTTtL9gXZMfRO1wKgpTqdvKRwvwj78abhPS7/Lm3mVKvc632RJPjBOX1c/ArMCBfNlPyqmmQs3Ump2EopA2aVptCO+bHMUEEw/OFhVd79oe4c4RTiMXwi7/gQBt6OB4auuxlwaiguuu++RUv5zNIpspbXSUSFuSnPHJhH5JG2YMcdmH8bbiV2MB35DW9iK91V9lhgd6pjt9uSlGRWbWv3mJNNvWmYoqclJe02XNzpEz85oLPIyt2clFe4gbGudAx6E9mNdjVvhb+j2pVClc9iQm/KBobBcAqCjtjVqxkdwWOO9lrsHxe6rcfLJZBU0235cI2kkpcHJLqrepTY4QlHR6LsGdxbYVNG8ss6vSG53fckKqoNMoydRyqXczatb64MBzE35Gf1z8KWvzcazAAzzRCUAVIkFfQu77kzpt5Bf/zc+W52aM2uiHgptcR3x7USfHZhkDBE6HjOtRyv8GLpUvx8S0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8253.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(19092799006)(1800799024)(376014)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?S6YGAnvZ+7YJljWJWwx3FMo5ATd9GdBKGtLLqCWW6zyERJgf6LaiZeJxpT/U?=
 =?us-ascii?Q?C9aRo7tvnNNPyUK9p6FDvMTaneJfnL1PYQfj0ERTLxWcXFIDxbJfVgyPrmfT?=
 =?us-ascii?Q?6BI27+jo2A7To8IaBQGBK6GLufs+/4uE+O0noIV6PONDG/2IHRMtBJlNIjCo?=
 =?us-ascii?Q?dJTI9nPgMzHUg8j1jldprkzYUrnDdbph7i6cRqPV3kc3O2Bzj1DulTon3zpc?=
 =?us-ascii?Q?3zk30UbiPp9Y0KwWMBMRR6H7+ydtuNbKFUWC8efkbNs9FlzOOoa4xVrIkW5G?=
 =?us-ascii?Q?dQTYveo57xeAwg3nE94GIGWkbEe5yr061hvFJ82To2gVSXHKxRCHtJruJeAu?=
 =?us-ascii?Q?zqp4pf5U12fe/BMEIvoVdI2ohf2lNBdp35ap9f2HxN2rLkCmm4zcZXI8brcS?=
 =?us-ascii?Q?FdxJFQxSKjn4UCOpdiZerp4m+xgMK85T8IVIQ7ckfQGxzAagT9ijzgt6e+Us?=
 =?us-ascii?Q?RhoZthRxEXkXRarenl024uhZBJKWWr0ydfK3Ojb8dtToW/kWX89fwjt9LDVr?=
 =?us-ascii?Q?zC9zlAukct66fwEL8Q3klcaWB0tIgczy6+QvdEU1nX0HhBC1IHwu35+DD98p?=
 =?us-ascii?Q?O4NYkD/vQI1jVd/0RKRPj/Dl0JhtrL/jXiqgXjZK+BLHlk3tF8RfEonE9c8R?=
 =?us-ascii?Q?RvaH/mAFLG4hLPk6WUAq6qey0RzO7bApUxtBTDjUyjsE2EhuGGRqF63NiLs3?=
 =?us-ascii?Q?pcAsbFyJYHLbzg7mgX8vArvHAo6Z9xT3z5vbgB7QAbOLmu9j+T2sTxKSvFM1?=
 =?us-ascii?Q?IU1vQIjPzHi/UlBIMLXR7UO+UWaVWbMZ67YpXK+RtrERO/qrFaPdRKR/Th9n?=
 =?us-ascii?Q?gfuAA+E8zK+egXMU//3StIr19OmsQg8i5jRAR3b5VBbV0WQI+vlceEvPWWuZ?=
 =?us-ascii?Q?Jl1CFbuJJmna7V4lLZmvt7OFwA6kp0gEdjDfihtRtGA+ocAETECZvI33qgRE?=
 =?us-ascii?Q?cUYWKixpATVrMyqX69mbP/d04dr06kp2UUvCk2b94/I4rpNrrdaQTE8wqaHo?=
 =?us-ascii?Q?m9XdZ2C4vGBpdzLB+YaW8wmwrfNatgrXvDJbb6nJ1ETl706yTgCwWA4+eE6f?=
 =?us-ascii?Q?9KshO8Figg+sCuKsJWdIaMcVYyTuQQhadrdM2/6myD+3x+qga1la7p26meeX?=
 =?us-ascii?Q?0nKhstCHePCSTvfaoF3TAjLLlK/7VAtJ8PMinPUUCukKuc0CAhe+SUZMqudJ?=
 =?us-ascii?Q?7KY9DSvpEUhNel8dDLt5gngsT5ci98azA2hmvcCTQUJlk8P3CgMbyXgRi6Xb?=
 =?us-ascii?Q?+Qm9kc1MzsCs9mTsKXCZO3ZE4f1pqFNE127AbLQ7U/UUIdJ3JNAZds5P6TKj?=
 =?us-ascii?Q?ZD2HfwT8r6dZGJE/JTwsjEtZzeKjeoiisJ1Qz29LcFNIj8lRoXzjPUpK5XuO?=
 =?us-ascii?Q?pIIYroYEshDETE1WFzJMzBDHRLoem1KTCrzMIsFQB3+dz7HXgyAXvT5BuvEG?=
 =?us-ascii?Q?DbaiqNY2Xu5bEt6qqVP2ioHB5c5BBg7CfL7jZlmK65XBNTfjmnfmNtAwWUHi?=
 =?us-ascii?Q?JOpfzxSfrsJgu1n2nDeOJWr50Z+Qi/F4ysOz9UhldMsitvKNs3btCwonO+OP?=
 =?us-ascii?Q?cqjuLO1S3/u6bcWZt7f5RsRB2LAcZMKLOyGjQLU+KmMWe+AtPUp//Vlm+pJs?=
 =?us-ascii?Q?rX76iRDLgvRZaIzraM+e7MnokmiNFv1YVQqTrmkH0us787U7tFCX4KmezcoP?=
 =?us-ascii?Q?fmdpt9ivzOfgYKL1L5sCT8zJ4XfnMAXWVXLuZfpLaJ2mE7P/enz0ol3lNEtl?=
 =?us-ascii?Q?P8xpDnczxw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e5d4b94-238c-436e-984e-08de8042e686
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8253.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2026 14:23:16.7208
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Fu218U9pfFNLX/ZEN+l8/V61Xlpn1t0u6OLaMYGYesLA2A1Ix6qsJL7MjqWefzT2KIXIVj0YzzeZPmDH6sdxPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV4PR04MB11773
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
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-267099-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ioana.ciornei@nxp.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:dkim,nxp.com:email,nxp.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B70D227357D
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
Changes in v2:
- none

 .../ethernet/freescale/dpaa2/dpaa2-ethtool.c  |  59 +++++-
 .../net/ethernet/freescale/dpaa2/dpaa2-mac.c  | 192 ++++++++++++++++++
 .../net/ethernet/freescale/dpaa2/dpaa2-mac.h  |  13 ++
 .../freescale/dpaa2/dpaa2-switch-ethtool.c    |  45 +++-
 4 files changed, 307 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/freescale/dpaa2/dpaa2-ethtool.c b/drivers/net/ethernet/freescale/dpaa2/dpaa2-ethtool.c
index baab4f1c908d..6f3b15a404fb 100644
--- a/drivers/net/ethernet/freescale/dpaa2/dpaa2-ethtool.c
+++ b/drivers/net/ethernet/freescale/dpaa2/dpaa2-ethtool.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
 /* Copyright 2014-2016 Freescale Semiconductor Inc.
- * Copyright 2016-2022 NXP
+ * Copyright 2016-2022, 2024-2026 NXP
  */
 
 #include <linux/net_tstamp.h>
@@ -938,6 +938,59 @@ static void dpaa2_eth_get_channels(struct net_device *net_dev,
 				   channels->other_count;
 }
 
+static void dpaa2_eth_get_rmon_stats(struct net_device *net_dev,
+				     struct ethtool_rmon_stats *rmon_stats,
+				     const struct ethtool_rmon_hist_range **ranges)
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
+static void dpaa2_eth_get_eth_mac_stats(struct net_device *net_dev,
+					struct ethtool_eth_mac_stats *eth_mac_stats)
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
@@ -962,4 +1015,8 @@ const struct ethtool_ops dpaa2_ethtool_ops = {
 	.get_coalesce = dpaa2_eth_get_coalesce,
 	.set_coalesce = dpaa2_eth_set_coalesce,
 	.get_channels = dpaa2_eth_get_channels,
+	.get_rmon_stats = dpaa2_eth_get_rmon_stats,
+	.get_pause_stats = dpaa2_eth_get_pause_stats,
+	.get_eth_ctrl_stats = dpaa2_eth_get_ctrl_stats,
+	.get_eth_mac_stats = dpaa2_eth_get_eth_mac_stats,
 };
diff --git a/drivers/net/ethernet/freescale/dpaa2/dpaa2-mac.c b/drivers/net/ethernet/freescale/dpaa2/dpaa2-mac.c
index 6e34a77f2757..b6530a8c3755 100644
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
+#define DPAA2_MAC_NUM_ETH_MAC_STATS		ARRAY_SIZE(dpaa2_mac_eth_mac_stats)
+
 static void dpaa2_mac_setup_stats(struct dpaa2_mac *mac, struct dpaa2_mac_stats *stats,
 				  size_t num_stats, const struct dpmac_counter *counters)
 {
@@ -150,6 +227,10 @@ static void dpaa2_mac_detect_features(struct dpaa2_mac *mac)
 	if (dpaa2_mac_cmp_ver(mac, DPMAC_STATS_BUNDLE_VER_MAJOR,
 			      DPMAC_STATS_BUNDLE_VER_MINOR) >= 0)
 		mac->features |= DPAA2_MAC_FEATURE_STATS_BUNDLE;
+
+	if (dpaa2_mac_cmp_ver(mac, DPMAC_STANDARD_STATS_VER_MAJOR,
+			      DPMAC_STANDARD_STATS_VER_MINOR) >= 0)
+		mac->features |= DPAA2_MAC_FEATURE_STANDARD_STATS;
 }
 
 static int phy_mode(enum dpmac_eth_if eth_if, phy_interface_t *if_mode)
@@ -626,6 +707,20 @@ int dpaa2_mac_open(struct dpaa2_mac *mac)
 		dpaa2_mac_setup_stats(mac, &mac->ethtool_stats,
 				      DPAA2_MAC_NUM_ETHTOOL_STATS, dpaa2_mac_ethtool_stats);
 
+	if (mac->features & DPAA2_MAC_FEATURE_STANDARD_STATS) {
+		dpaa2_mac_setup_stats(mac, &mac->rmon_stats,
+				      DPAA2_MAC_NUM_RMON_STATS, dpaa2_mac_rmon_stats);
+
+		dpaa2_mac_setup_stats(mac, &mac->pause_stats,
+				      DPAA2_MAC_NUM_PAUSE_STATS, dpaa2_mac_pause_stats);
+
+		dpaa2_mac_setup_stats(mac, &mac->eth_ctrl_stats,
+				      DPAA2_MAC_NUM_ETH_CTRL_STATS, dpaa2_mac_eth_ctrl_stats);
+
+		dpaa2_mac_setup_stats(mac, &mac->eth_mac_stats,
+				      DPAA2_MAC_NUM_ETH_MAC_STATS, dpaa2_mac_eth_mac_stats);
+	}
+
 	return 0;
 
 err_close_dpmac:
@@ -640,11 +735,108 @@ void dpaa2_mac_close(struct dpaa2_mac *mac)
 	if (mac->features & DPAA2_MAC_FEATURE_STATS_BUNDLE)
 		dpaa2_mac_clear_stats(mac, &mac->ethtool_stats, DPAA2_MAC_NUM_ETHTOOL_STATS);
 
+	if (mac->features & DPAA2_MAC_FEATURE_STANDARD_STATS) {
+		dpaa2_mac_clear_stats(mac, &mac->rmon_stats, DPAA2_MAC_NUM_RMON_STATS);
+		dpaa2_mac_clear_stats(mac, &mac->pause_stats, DPAA2_MAC_NUM_PAUSE_STATS);
+		dpaa2_mac_clear_stats(mac, &mac->eth_ctrl_stats, DPAA2_MAC_NUM_ETH_CTRL_STATS);
+		dpaa2_mac_clear_stats(mac, &mac->eth_mac_stats, DPAA2_MAC_NUM_ETH_MAC_STATS);
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
+static void dpaa2_mac_get_standard_stats(struct dpaa2_mac *mac, struct dpaa2_mac_stats *stats,
+					 size_t num_cnt, const struct dpmac_counter *counters,
+					 void *s)
+{
+	struct device *dev = mac->net_dev->dev.parent;
+	struct fsl_mc_device *dpmac_dev = mac->mc_dev;
+	int err;
+
+	if (!(mac->features & DPAA2_MAC_FEATURE_STANDARD_STATS))
+		return;
+
+	if (!stats->idx_dma_mem || !stats->values_dma_mem)
+		return;
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
+	dma_sync_single_for_cpu(dev, stats->values_iova, num_cnt * sizeof(u64),
+				DMA_FROM_DEVICE);
+
+	dpaa2_mac_transfer_stats(counters, num_cnt, s, stats->values_dma_mem);
+}
+
+void dpaa2_mac_get_rmon_stats(struct dpaa2_mac *mac, struct ethtool_rmon_stats *s,
+			      const struct ethtool_rmon_hist_range **ranges)
+{
+	if (s->src != ETHTOOL_MAC_STATS_SRC_AGGREGATE)
+		return;
+
+	dpaa2_mac_get_standard_stats(mac, &mac->rmon_stats, DPAA2_MAC_NUM_RMON_STATS,
+				     dpaa2_mac_rmon_stats, s);
+
+	*ranges = dpaa2_mac_rmon_ranges;
+}
+
+void dpaa2_mac_get_pause_stats(struct dpaa2_mac *mac, struct ethtool_pause_stats *s)
+{
+	if (s->src != ETHTOOL_MAC_STATS_SRC_AGGREGATE)
+		return;
+
+	dpaa2_mac_get_standard_stats(mac, &mac->pause_stats, DPAA2_MAC_NUM_PAUSE_STATS,
+				     dpaa2_mac_pause_stats, s);
+}
+
+void dpaa2_mac_get_ctrl_stats(struct dpaa2_mac *mac, struct ethtool_eth_ctrl_stats *s)
+{
+	if (s->src != ETHTOOL_MAC_STATS_SRC_AGGREGATE)
+		return;
+
+	dpaa2_mac_get_standard_stats(mac, &mac->eth_ctrl_stats, DPAA2_MAC_NUM_ETH_CTRL_STATS,
+				     dpaa2_mac_eth_ctrl_stats, s);
+}
+
+void dpaa2_mac_get_eth_mac_stats(struct dpaa2_mac *mac, struct ethtool_eth_mac_stats *s)
+{
+	if (s->src != ETHTOOL_MAC_STATS_SRC_AGGREGATE)
+		return;
+
+	dpaa2_mac_get_standard_stats(mac, &mac->eth_mac_stats, DPAA2_MAC_NUM_ETH_MAC_STATS,
+				     dpaa2_mac_eth_mac_stats, s);
+}
+
 int dpaa2_mac_get_sset_count(void)
 {
 	return DPAA2_MAC_NUM_ETHTOOL_STATS;
diff --git a/drivers/net/ethernet/freescale/dpaa2/dpaa2-mac.h b/drivers/net/ethernet/freescale/dpaa2/dpaa2-mac.h
index 6f4981627961..069d67501da0 100644
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
@@ -61,6 +65,15 @@ void dpaa2_mac_get_strings(u8 **data);
 
 void dpaa2_mac_get_ethtool_stats(struct dpaa2_mac *mac, u64 *data);
 
+void dpaa2_mac_get_rmon_stats(struct dpaa2_mac *mac, struct ethtool_rmon_stats *s,
+			      const struct ethtool_rmon_hist_range **ranges);
+
+void dpaa2_mac_get_pause_stats(struct dpaa2_mac *mac, struct ethtool_pause_stats *s);
+
+void dpaa2_mac_get_ctrl_stats(struct dpaa2_mac *mac, struct ethtool_eth_ctrl_stats *s);
+
+void dpaa2_mac_get_eth_mac_stats(struct dpaa2_mac *mac, struct ethtool_eth_mac_stats *s);
+
 void dpaa2_mac_start(struct dpaa2_mac *mac);
 
 void dpaa2_mac_stop(struct dpaa2_mac *mac);
diff --git a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch-ethtool.c b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch-ethtool.c
index a888f6e6e9b0..3203873fae85 100644
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
 
@@ -210,6 +210,46 @@ static void dpaa2_switch_ethtool_get_stats(struct net_device *netdev,
 	mutex_unlock(&port_priv->mac_lock);
 }
 
+static void dpaa2_switch_get_rmon_stats(struct net_device *netdev,
+					struct ethtool_rmon_stats *rmon_stats,
+					const struct ethtool_rmon_hist_range **ranges)
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
+static void dpaa2_switch_get_ctrl_stats(struct net_device *net_dev,
+					struct ethtool_eth_ctrl_stats *ctrl_stats)
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
+static void dpaa2_switch_get_eth_mac_stats(struct net_device *net_dev,
+					   struct ethtool_eth_mac_stats *eth_mac_stats)
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
@@ -218,4 +258,7 @@ const struct ethtool_ops dpaa2_switch_port_ethtool_ops = {
 	.get_strings		= dpaa2_switch_ethtool_get_strings,
 	.get_ethtool_stats	= dpaa2_switch_ethtool_get_stats,
 	.get_sset_count		= dpaa2_switch_ethtool_get_sset_count,
+	.get_rmon_stats		= dpaa2_switch_get_rmon_stats,
+	.get_eth_ctrl_stats	= dpaa2_switch_get_ctrl_stats,
+	.get_eth_mac_stats	= dpaa2_switch_get_eth_mac_stats,
 };
-- 
2.25.1


