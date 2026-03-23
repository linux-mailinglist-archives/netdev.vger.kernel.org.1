Return-Path: <netdev+bounces-270495-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +DFHLyApwWmbRAQAu9opvQ
	(envelope-from <netdev+bounces-270495-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 12:50:56 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 64C722F1753
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 12:50:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BE9CD300B472
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 11:50:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD84739B970;
	Mon, 23 Mar 2026 11:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="bWrWnuO1"
X-Original-To: netdev@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013008.outbound.protection.outlook.com [40.107.159.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A969C39B483;
	Mon, 23 Mar 2026 11:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774266650; cv=fail; b=PhHO5YH+2D4XFctZ3CRxSFOaNQ/qKvMqM3IB2A17RiHfiAtulbUpZDJfoKg+pNGJZrSxvAZqUZXBDvBsB3ilnFePE+D3xuy4QUNS+fs/v8SdVDD4O/HhhzKO7lZMGWOovskYf9aR+JDlOVwPX+LqqYbqSZ8ezA6auvcWpVQhV1s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774266650; c=relaxed/simple;
	bh=JwmWHNUG0ejIN6E47tmBB3mqKzj99+7YraQoHuOGUZA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TKR3LG0PcdRzJBIW3yPdB4cByjONUZib4gfNxNxwWrzPWw/GextYnupt8Z0UcjcZajGLeSwT3BEW7JMNvNOHsO60dKc+iOBpcSxz8AX4yEF2IGr4rZCwuI4CQt+rqY79akpfVzR36vQ6cY8n28/h5oFJjc6lqQnlWwMynSbbFWI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=bWrWnuO1; arc=fail smtp.client-ip=40.107.159.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oU2YvY4Mv7QCw9BPIBOI7WycjzL7Z1w8TgvHy1HDR0kWhlfgScxwu/YEcol7sjMfjnfg2e3gH54WJEJwhCEAjiwWh3zJqgzASt8WVb++OiL1fglcC3wT7z+tsxK2ZSTtEBuUcb9Tx2IYtSzuxyec/a44sSX+3WqSiU+2VfEpQ0YlMKA2TsVOFk0mZDQEempYv76AGn//eqKsizpmf0Q8zLYa5QFoZcrhKhtj/6fusg1YEP+ubgzPIh23ml4vjZc2m+Jz6QfXNEuZteWPb/pHulSJYMILHaw4I4v/pNBvuzt2pGhzK8HSCs57dw0hAqnNADkOmrKC217MKSJGjicHdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yxzdS8AH8XMFJFm93Zb8qnceoBpqQcQEr6N7cPpA7mI=;
 b=PF/4c3F4hp9cRkrg938TiG0omFsX3F8wOCW5UfNL72vsiB+wUBA+SZTLO0jhosnka9bUuDPJA3wXGLDe4KZr9iq9oYRbajGAwgQiSaRVV+wPbie8u951HcklmNqsx7x0xOPaZi5YSadqLwbuaHdGRaqn3xw2kPiVC3Ma4YeHSn6i8iLaimBWi+r35+oJGYWzt8gEVhRonu2S/11QPwKpt78pdepCEGQlpqyv1JZjIZU6aL398c2VJ1vYzMSi38Ma77duJ0DP5NSkcPPfWcSK4K9RPy2gqRb1KJMwRk9rVw5NpalfW83w3ovb1AvNKijuKfD2SsPxF5PafDGkr1hr8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yxzdS8AH8XMFJFm93Zb8qnceoBpqQcQEr6N7cPpA7mI=;
 b=bWrWnuO1k1kQmXyzAFhdq+/tvEj9IgPh8gI7yVZtTWruKERzH/zTcr7KlniWNVNMT0i+p6zH9HuVQyg8QVLFat7+kD7LOc8MHSpkNu4P1qzFCFESJQYzrkv4Lw3a6TS1959SkhepHcryAkvb9APgRN04GDoSqgYKhLeQRQ6/H6MqAkpkd/PdVQkHzWVFtWMYEFuntZwBRU6gON8bn767HBfuaSQJUpWxxdxQKhu4UbPS/ikFd+pwK03PvZeJ4wiS4xpYUDVbrOipq8ki09sMyZqOuDKFPKQSPIyPHp7izsKPaYZaze0YOlfX1rao7aiWCjxcoQguEBoBYhKkKEPt4g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8253.eurprd04.prod.outlook.com (2603:10a6:102:1bf::7)
 by AS5PR04MB9924.eurprd04.prod.outlook.com (2603:10a6:20b:67e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.25; Mon, 23 Mar
 2026 11:50:40 +0000
Received: from PAXPR04MB8253.eurprd04.prod.outlook.com
 ([fe80::2b4e:8130:4419:d633]) by PAXPR04MB8253.eurprd04.prod.outlook.com
 ([fe80::2b4e:8130:4419:d633%3]) with mapi id 15.20.9723.022; Mon, 23 Mar 2026
 11:50:45 +0000
From: Ioana Ciornei <ioana.ciornei@nxp.com>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v5 1/3] net: dpaa2-mac: extend APIs related to statistics
Date: Mon, 23 Mar 2026 13:50:37 +0200
Message-Id: <20260323115039.3932600-2-ioana.ciornei@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260323115039.3932600-1-ioana.ciornei@nxp.com>
References: <20260323115039.3932600-1-ioana.ciornei@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4PR10CA0006.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:5dc::6) To PAXPR04MB8253.eurprd04.prod.outlook.com
 (2603:10a6:102:1bf::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8253:EE_|AS5PR04MB9924:EE_
X-MS-Office365-Filtering-Correlation-Id: e2ecbeb9-9eca-4c52-b7b8-08de88d26aca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|19092799006|376014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	CM1CspttlFgsDC5aquuedpJaf4qfrk3V5WR3dEYoPsjEBVFxXtBSGhT5eaVl9/j8vTiB9nOrie6kUvMMpZhmCLL/+80dmByxWYGLLZQeMsfFN1NueJfI1JDT1NtXOm47l3XFuXjpVofVzRm2cobu+nQRzQrVTODYuYoXHnlRDdulYHfHSkc/2jqY91F2b9x094W4WeBpYE58Jn50TzhSq2LqouLaw8GJuUwGT1RrgVFs278YYaH+MMt6RYWslu0wdQ+HVaPyn8+nxlS8qmUZPwKo8P1P0PnuL5Stnovsch49xamzAa1+hXODmGxFvmkiWNGgEi/FasNIydfjbNBHiv20xcPOKz8N8OfANt0P1aRWi6YeraS5alNRyzF0R0hFLUWFD+omkm1W/Q8belezyjkFdNZv4w0y086yyhPXvgnIrpV4tL37Ma+IW/7d6pA9ZYoFFWYfdsS9M2Ho1YTqd6mVUDQyR8G6+uxQ4s0tuMW9kWpikmT3AK38W0IoFkdmoQCeRaMTcYm84TBEOq1Oy45H6gkiSHJeLxb3/f+7zwAdHN0j013WFwZgHlxXRAstnpP8o2KEp2HcwhAPLw5GXpw9rZkKiokE2vZHw9t8Ph1PWCuBgmbzwCfI4J8vUY9jAK2Q8VMxdrUYZjejM3WnCrV1f+w6L2Ns2DbgIEEagldFrWNHEVkocerbCb2FGlND0h/SHg+OF4eCtPEMFKoTooadCQWr7jYz05lHH9ToVT4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8253.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(376014)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5aPhI293LcPXR9rarfJS2w+FUt7ZRvI1IpGubUD8ryTi6vE/cFzVRzurk5Io?=
 =?us-ascii?Q?HBlEDCh/Ul7FqtikInNZu+ibsQmHt3ixYD5PHA1nQmZWVgNsDzmceypF8Nim?=
 =?us-ascii?Q?h8GA+ObuLzcKSL2FcuoW/XmciOrUXapKL9cVaDe2LEe8CyD+BcsRZcckRHf6?=
 =?us-ascii?Q?YmWdXJEy4kQa8nNTmz9VxOE7pVqCYvEUKnyU6Ruh9f99xctOgAV3SqVF7D5e?=
 =?us-ascii?Q?kTJD1jilndAq2KlWKN7OCTOR/XRZz267zvp/km6kMFncErSA8ocZDjusQf/U?=
 =?us-ascii?Q?cQS6cxs8j4YfuvJCmfFqFGGdQxflM000UGP65q7NUgn5PIv6d5H35MqhF6F1?=
 =?us-ascii?Q?gf7TBJEIFd60YGeemxez+jCUEsXJIADtnuY3i6y1Qm/RC3OwJ/vFhKl1Ui+0?=
 =?us-ascii?Q?rtmuZeXWs+e3JqLY6LpkvVQZuc4thmn+ePm62rC75N+gcj27Wvi2tI4gCmsO?=
 =?us-ascii?Q?t6y7hmlbcwLXsmq8Tdm3CN8+Kz/49vCGQPKk8j7RWRkNdI5xMrdlP8wbA9oz?=
 =?us-ascii?Q?3tY8JpxUtRKQv0u1gNF+WxHkNf5Qh++sRW5DISmBetSLI0slB2LpHZkxdoNQ?=
 =?us-ascii?Q?F7alKCohV89B/48AKvbQITwo8N0g+kSlPzN/X3fbZOsFfWrvREdERne/Uy+o?=
 =?us-ascii?Q?S+GzIYiseFehpn0A/Hos8/4JMvV+OoDTJ2d9kHLeUKDtUsXLSk5jqxtVG09a?=
 =?us-ascii?Q?pJZ3l4x7zTojgAB3XanVvrhIPpz37saFxeBcBO+z+0HxwZxlBqzFnmK3HYaR?=
 =?us-ascii?Q?rlwQ/nv3Kffr4MPv3bxz0KpD8PO5COMJohTzZu4SWTcKRy/vU8ek0Zk9Xgw9?=
 =?us-ascii?Q?iJMuc7Pq52iDk9LGa9EfoWwRUkRbLrAI2B6hlNO1TR9t1r2HnGB255uML6hH?=
 =?us-ascii?Q?AOXDHrRSfqhdAKepQ7altQc1Vto0liUNDYvH3et+9otPzmyxLfYgBliY/Q3t?=
 =?us-ascii?Q?6i/nt1psu3Ls+Im66hLHYR0jQRuTs/2EDsXztyLgtxgbAGQdiXZc9ln1iVsp?=
 =?us-ascii?Q?QGNXaLVy8BJdBBmtkv5bjxY2oW0W1u5+Nw7NHSIDETbNv5okOiRAtES5TvK2?=
 =?us-ascii?Q?N0Mf03LS6NmxOCjAUH3+80JXBEHaNg/S3kZBgRt2rf3ZCgtyglqTTuiE8+yn?=
 =?us-ascii?Q?XN1HdA/1sT7sWJQz8i/cxGHH5CH+pj637sip8+5dQbHo/mwleNQhIZ5+w2Ks?=
 =?us-ascii?Q?TECi5XkrrmWmd8Ffi6cAi3UBweJiV+RmyDKcQ5m/gf2ob3a+cZqyBZpF/cmK?=
 =?us-ascii?Q?XxM4/yywtlM3LZBXWvIRQf4B7we6PNgvTkoMEJ72zg92bgxEBmJUdAyv6Qz7?=
 =?us-ascii?Q?au7qJ72XXtXJP+VVqk+QQgZR4+5dt0YLPT+UewOHoHsx/SvvzbPb0FxF5v6N?=
 =?us-ascii?Q?sWoZgxNhvyFgYdljeZafuAk3Kq/Li6FcfUi57jNfzjACfjZGnbihWKLHKOa/?=
 =?us-ascii?Q?fMKX8sCtqalTy8tzAboSChbUcGl03KLCyCjVBdlmjaPmmfiK1IgRfPj69M15?=
 =?us-ascii?Q?Vo6I8RbZDXKdB6sy1Sb1BYyVhtSEmWorxCmZKXcgVxfKpENwr0rxgUg62V9R?=
 =?us-ascii?Q?uTLzqOXU1Vg5RHwGRp5LE6bqjPdCXo0kHrJOf9S2AIjuO9ZTPizEOovKH2To?=
 =?us-ascii?Q?WPHvbZEtExGPPigyl76neukfTnlpte9PZFKukWxCISXicq3pzI3kiVpnLm9m?=
 =?us-ascii?Q?4oO9Njn/G6TjKPrLzL78WYNkmnnNKegUktp8MWL0LwnI9qkA9CDfb7MtIcai?=
 =?us-ascii?Q?Rqh0gxYVaQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2ecbeb9-9eca-4c52-b7b8-08de88d26aca
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8253.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2026 11:50:45.1667
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D0th9LAzDIl9rwgzrg1TeK9k6BpaI0VWkbsO3hCq0EmkBS1BJOp82lM69sO8PoDdEI4Xwb+8D1BuyH+N87W8aw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB9924
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-270495-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ioana.ciornei@nxp.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,nxp.com:dkim,nxp.com:email,nxp.com:mid]
X-Rspamd-Queue-Id: 64C722F1753
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Extend the dpmac_counter_id enum with the newly added counters which can
be interrogated through the MC firmware. Also add the
dpmac_get_statistics() API which can be used to retrieve multiple MAC
counters through a single firmware command.

Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
---
Changes in v5:
- none
Changes in v4:
- none
Changes in v3:
- limit the documentation entries to 80 chars
Changes in v2:
- none

 .../net/ethernet/freescale/dpaa2/dpmac-cmd.h  | 11 ++-
 drivers/net/ethernet/freescale/dpaa2/dpmac.c  | 31 +++++-
 drivers/net/ethernet/freescale/dpaa2/dpmac.h  | 94 ++++++++++++++++++-
 3 files changed, 132 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/freescale/dpaa2/dpmac-cmd.h b/drivers/net/ethernet/freescale/dpaa2/dpmac-cmd.h
index e9ac2ecef3be..a864a99a0f75 100644
--- a/drivers/net/ethernet/freescale/dpaa2/dpmac-cmd.h
+++ b/drivers/net/ethernet/freescale/dpaa2/dpmac-cmd.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause) */
 /* Copyright 2013-2016 Freescale Semiconductor Inc.
- * Copyright 2019 NXP
+ * Copyright 2019, 2024-2026 NXP
  */
 #ifndef _FSL_DPMAC_CMD_H
 #define _FSL_DPMAC_CMD_H
@@ -28,6 +28,8 @@
 
 #define DPMAC_CMDID_SET_PROTOCOL	DPMAC_CMD(0x0c7)
 
+#define DPMAC_CMDID_GET_STATISTICS	DPMAC_CMD(0x0c8)
+
 /* Macros for accessing command fields smaller than 1byte */
 #define DPMAC_MASK(field)        \
 	GENMASK(DPMAC_##field##_SHIFT + DPMAC_##field##_SIZE - 1, \
@@ -82,4 +84,11 @@ struct dpmac_rsp_get_api_version {
 struct dpmac_cmd_set_protocol {
 	u8 eth_if;
 };
+
+struct dpmac_cmd_get_statistics {
+	__le64 iova_cnt;
+	__le64 iova_values;
+	__le32 num_cnt;
+};
+
 #endif /* _FSL_DPMAC_CMD_H */
diff --git a/drivers/net/ethernet/freescale/dpaa2/dpmac.c b/drivers/net/ethernet/freescale/dpaa2/dpmac.c
index f440a4c3b70c..efb9864d051f 100644
--- a/drivers/net/ethernet/freescale/dpaa2/dpmac.c
+++ b/drivers/net/ethernet/freescale/dpaa2/dpmac.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
 /* Copyright 2013-2016 Freescale Semiconductor Inc.
- * Copyright 2019 NXP
+ * Copyright 2019, 2024-2026 NXP
  */
 #include <linux/fsl/mc.h>
 #include "dpmac.h"
@@ -235,3 +235,32 @@ int dpmac_set_protocol(struct fsl_mc_io *mc_io, u32 cmd_flags, u16 token,
 
 	return mc_send_command(mc_io, &cmd);
 }
+
+/**
+ * dpmac_get_statistics() - Get MAC statistics
+ * @mc_io:       Pointer to opaque I/O object
+ * @cmd_flags:   Command flags; one or more of 'MC_CMD_FLAG_'
+ * @token:       Token of DPMAC object
+ * @iova_cnt:    IOVA containing the requested MAC counters formatted as an
+ *               array of __le32 representing the dpmac_counter_id.
+ * @iova_values: IOVA containing the values for all the requested counters
+ *               formatted as an array of __le64.
+ * @num_cnt:     Number of counters requested
+ *
+ * Return:       '0' on Success; Error code otherwise.
+ */
+int dpmac_get_statistics(struct fsl_mc_io *mc_io, u32 cmd_flags, u16 token,
+			 u64 iova_cnt, u64 iova_values, u32 num_cnt)
+{
+	struct dpmac_cmd_get_statistics *cmd_params;
+	struct fsl_mc_command cmd = { 0 };
+
+	cmd.header = mc_encode_cmd_header(DPMAC_CMDID_GET_STATISTICS,
+					  cmd_flags, token);
+	cmd_params = (struct dpmac_cmd_get_statistics *)cmd.params;
+	cmd_params->iova_cnt = cpu_to_le64(iova_cnt);
+	cmd_params->iova_values = cpu_to_le64(iova_values);
+	cmd_params->num_cnt = cpu_to_le32(num_cnt);
+
+	return mc_send_command(mc_io, &cmd);
+}
diff --git a/drivers/net/ethernet/freescale/dpaa2/dpmac.h b/drivers/net/ethernet/freescale/dpaa2/dpmac.h
index 17488819ef68..b5276168b869 100644
--- a/drivers/net/ethernet/freescale/dpaa2/dpmac.h
+++ b/drivers/net/ethernet/freescale/dpaa2/dpmac.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause) */
 /* Copyright 2013-2016 Freescale Semiconductor Inc.
- * Copyright 2019 NXP
+ * Copyright 2019, 2024-2026 NXP
  */
 #ifndef __FSL_DPMAC_H
 #define __FSL_DPMAC_H
@@ -170,6 +170,58 @@ int dpmac_set_link_state(struct fsl_mc_io *mc_io,
  *			      pause frames.
  * @DPMAC_CNT_EGR_GOOD_FRAME: counts frames transmitted without error, including
  *			      pause frames.
+ * @DPMAC_CNT_EGR_FRAME_64: counts transmitted 64-bytes frames, good or bad.
+ * @DPMAC_CNT_EGR_FRAME_127: counts transmitted 65 to 127-bytes frames, good or
+ *			     bad.
+ * @DPMAC_CNT_EGR_FRAME_255: counts transmitted 128 to 255-bytes frames, good
+ *			     or bad.
+ * @DPMAC_CNT_EGR_FRAME_511: counts transmitted 256 to 511-bytes frames, good
+ *			     or bad.
+ * @DPMAC_CNT_EGR_FRAME_1023: counts transmitted 512 to 1023-bytes frames, good
+ *			      or bad.
+ * @DPMAC_CNT_EGR_FRAME_1518: counts transmitted 1024 to 1518-bytes frames,
+ *			      good or bad.
+ * @DPMAC_CNT_EGR_FRAME_1519_MAX: counts transmitted 1519-bytes frames and
+ *				  larger (up to max frame length specified),
+ *				  good or bad.
+ * @DPMAC_CNT_ING_ALL_BYTE: counts bytes received in both good and bad packets
+ * @DPMAC_CNT_ING_FCS_ERR: counts frames received with a CRC-32 error but the
+ *			   frame is otherwise of correct length
+ * @DPMAC_CNT_ING_VLAN_FRAME: counts the received VLAN tagged frames which are
+ *			      valid.
+ * @DPMAC_CNT_ING_UNDERSIZED: counts received frames which were less than 64
+ *			      bytes long and with a good CRC.
+ * @DPMAC_CNT_ING_CONTROL_FRAME: counts received control frames (type 0x8808)
+ *				 but not pause frames.
+ * @DPMAC_CNT_ING_FRAME_DISCARD_NOT_TRUNC: counts the fully dropped frames (not
+ *					   truncated) due to internal errors of
+ *					   the MAC client. Occurs when a
+ *					   receive FIFO overflows.
+ * @DPMAC_CNT_EGR_ALL_BYTE: counts transmitted bytes in both good and bad
+ *			    packets.
+ * @DPMAC_CNT_EGR_FCS_ERR: counts trasmitted frames with a CRC-32 error except
+ *			   for underflows.
+ * @DPMAC_CNT_EGR_VLAN_FRAME: counts the transmitted VLAN tagged frames which
+ *			      are valid.
+ * @DPMAC_CNT_EGR_ALL_FRAME: counts all trasmitted frames, good or bad.
+ * @DPMAC_CNT_EGR_CONTROL_FRAME: counts transmitted control frames (type
+ *				 0x8808) but not pause frames.
+ * @DPMAC_CNT_ING_PFC0: number of PFC frames received for class 0.
+ * @DPMAC_CNT_ING_PFC1: number of PFC frames received for class 1.
+ * @DPMAC_CNT_ING_PFC2: number of PFC frames received for class 2.
+ * @DPMAC_CNT_ING_PFC3: number of PFC frames received for class 3.
+ * @DPMAC_CNT_ING_PFC4: number of PFC frames received for class 4.
+ * @DPMAC_CNT_ING_PFC5: number of PFC frames received for class 5.
+ * @DPMAC_CNT_ING_PFC6: number of PFC frames received for class 6.
+ * @DPMAC_CNT_ING_PFC7: number of PFC frames received for class 7.
+ * @DPMAC_CNT_EGR_PFC0: number of PFC frames transmitted for class 0.
+ * @DPMAC_CNT_EGR_PFC1: number of PFC frames transmitted for class 1.
+ * @DPMAC_CNT_EGR_PFC2: number of PFC frames transmitted for class 2.
+ * @DPMAC_CNT_EGR_PFC3: number of PFC frames transmitted for class 3.
+ * @DPMAC_CNT_EGR_PFC4: number of PFC frames transmitted for class 4.
+ * @DPMAC_CNT_EGR_PFC5: number of PFC frames transmitted for class 5.
+ * @DPMAC_CNT_EGR_PFC6: number of PFC frames transmitted for class 6.
+ * @DPMAC_CNT_EGR_PFC7: number of PFC frames transmitted for class 7.
  */
 enum dpmac_counter_id {
 	DPMAC_CNT_ING_FRAME_64,
@@ -199,7 +251,41 @@ enum dpmac_counter_id {
 	DPMAC_CNT_EGR_UCAST_FRAME,
 	DPMAC_CNT_EGR_ERR_FRAME,
 	DPMAC_CNT_ING_GOOD_FRAME,
-	DPMAC_CNT_EGR_GOOD_FRAME
+	DPMAC_CNT_EGR_GOOD_FRAME,
+	DPMAC_CNT_EGR_FRAME_64,
+	DPMAC_CNT_EGR_FRAME_127,
+	DPMAC_CNT_EGR_FRAME_255,
+	DPMAC_CNT_EGR_FRAME_511,
+	DPMAC_CNT_EGR_FRAME_1023,
+	DPMAC_CNT_EGR_FRAME_1518,
+	DPMAC_CNT_EGR_FRAME_1519_MAX,
+	DPMAC_CNT_ING_ALL_BYTE,
+	DPMAC_CNT_ING_FCS_ERR,
+	DPMAC_CNT_ING_VLAN_FRAME,
+	DPMAC_CNT_ING_UNDERSIZED,
+	DPMAC_CNT_ING_CONTROL_FRAME,
+	DPMAC_CNT_ING_FRAME_DISCARD_NOT_TRUNC,
+	DPMAC_CNT_EGR_ALL_BYTE,
+	DPMAC_CNT_EGR_FCS_ERR,
+	DPMAC_CNT_EGR_VLAN_FRAME,
+	DPMAC_CNT_EGR_ALL_FRAME,
+	DPMAC_CNT_EGR_CONTROL_FRAME,
+	DPMAC_CNT_ING_PFC0,
+	DPMAC_CNT_ING_PFC1,
+	DPMAC_CNT_ING_PFC2,
+	DPMAC_CNT_ING_PFC3,
+	DPMAC_CNT_ING_PFC4,
+	DPMAC_CNT_ING_PFC5,
+	DPMAC_CNT_ING_PFC6,
+	DPMAC_CNT_ING_PFC7,
+	DPMAC_CNT_EGR_PFC0,
+	DPMAC_CNT_EGR_PFC1,
+	DPMAC_CNT_EGR_PFC2,
+	DPMAC_CNT_EGR_PFC3,
+	DPMAC_CNT_EGR_PFC4,
+	DPMAC_CNT_EGR_PFC5,
+	DPMAC_CNT_EGR_PFC6,
+	DPMAC_CNT_EGR_PFC7,
 };
 
 int dpmac_get_counter(struct fsl_mc_io *mc_io, u32 cmd_flags, u16 token,
@@ -210,4 +296,8 @@ int dpmac_get_api_version(struct fsl_mc_io *mc_io, u32 cmd_flags,
 
 int dpmac_set_protocol(struct fsl_mc_io *mc_io, u32 cmd_flags, u16 token,
 		       enum dpmac_eth_if protocol);
+
+int dpmac_get_statistics(struct fsl_mc_io *mc_io, u32 cmd_flags, u16 token,
+			 u64 iova_cnt, u64 iova_values, u32 num_cnt);
+
 #endif /* __FSL_DPMAC_H */
-- 
2.25.1


