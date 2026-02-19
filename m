Return-Path: <netdev+bounces-259404-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AIp3Eg6llmlsiQIAu9opvQ
	(envelope-from <netdev+bounces-259404-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 06:52:14 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E087815C355
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 06:52:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6E34E3031CF5
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 05:49:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE7CC2C3261;
	Thu, 19 Feb 2026 05:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="WwXsBvrX"
X-Original-To: netdev@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010014.outbound.protection.outlook.com [52.101.85.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C7242D1913;
	Thu, 19 Feb 2026 05:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771480196; cv=fail; b=GNVqFKJzZoOPSGALffG+pz1XTH2J4muqIKirpQMO2Ozs/AVP1NL1hdwMS8WJOKpLmdToTs4tHWrev37yO8L6VJqBrBIyHtUUAT2L0lGeyMiuA/ILRUs/zDN7jcyTHYhSZRYyi6kUVlKsmDTQn2X2j1cDw9oYomYIW/DvoFPGId0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771480196; c=relaxed/simple;
	bh=2EWNRGptBH5F+Okk1/erKfQsUDaT2wj+L+K/KmMAix8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t7AI/r7xHVKeSPVLaYWUk8qBOmzMrzPkBoX7oSq9IugdC+82yr5QbEJpiTzCRpawV6INXSxrDPkCurXpE2BUHrYmCVWeiH9R//U/vZCSrR2Rtf9tLYviSWpNXZVUL5JlekH6abmLfXbB6JKrF7ci/B3ZRZIe9bCAY6FIt+qwam0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=WwXsBvrX; arc=fail smtp.client-ip=52.101.85.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dPmJOdgfBQRzpyAZ0HUcvxgCV3hTWahyy7oeUp+dUceIZZ9e4b4sa9Mj3/ks7j9RGW/sqBl8afJKoQl7RKSGdtpkd3845o/TU2nI2VhQPqe6DmmElIeBXcMtPomOd4Tbajm3VSXkDAyISiO0EV/xb0M3WoxEh0jc0kSSsqrfA4D6/8XUr48pVlizgyAio6sDvRDHX3/APadJCOH4OQBCfjSH7yty7pL9jPo9Ql5AE2saV5Ssbd5IyMsRwXOgpMOqu1t5jt5skJZcBorSlIHrl5fdXvjf8jzGB3ijezN6hFQQpVfVRe/msFDMKAcx+hRN+uF9vqVEZ0iEW2hjtNVEiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pe5WxTxlkNiWrnIHsNf9P8eeOEr0ZC+5Wg1arpx7gco=;
 b=Fb+tzm7hCfXjvGxeuw8ute2WW2MRnKGNVltF9yDf7bL+plH3r8WV4wvQ+iY3VpCsKuGfjTopjsdGF1qIf5B4KAhfFmAmEotTbTamIzAnADPzwof+qWVGQBoRhwfR/BpEDUd9Pm8G/i7vThU/JgOt5r0C0HVowTirLEGxJOXJY2sf8N+9X/yRrkWW3VwphEh3B9ZmTGpn2IMBEJ75b3zFIwsSPlposm/EgzU6gs7CEZ4q9VUIFovuSsJm2dM8eJoD13S0dcGdmYhd7wkbfaesm+TjNlT8GtfcwNTyqXr7jnWhV/J3SjJsGOQG1Mlp+xwbtrYRizeqJ2RvAFe8sHuCFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lunn.ch smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pe5WxTxlkNiWrnIHsNf9P8eeOEr0ZC+5Wg1arpx7gco=;
 b=WwXsBvrXnPxL+JWzZ2JfcDa/ahTsfEnkqM47NF367/RJtT0fFtbCnF6QX3LkQoNp6Fi4+rzSji3wkKk4StXEA8OizCYTsJPgv3Ts22wRYRSzJRtC23IXx0cYpmz8yhOdQfxWV+ErwNqc8IaBixQRDLLQmR1XJNQ0LSbsdXvltkc=
Received: from SJ0PR03CA0293.namprd03.prod.outlook.com (2603:10b6:a03:39e::28)
 by DM4PR12MB8452.namprd12.prod.outlook.com (2603:10b6:8:184::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.16; Thu, 19 Feb
 2026 05:49:47 +0000
Received: from SJ5PEPF000001CC.namprd05.prod.outlook.com
 (2603:10b6:a03:39e:cafe::cc) by SJ0PR03CA0293.outlook.office365.com
 (2603:10b6:a03:39e::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.14 via Frontend Transport; Thu,
 19 Feb 2026 05:49:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001CC.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Thu, 19 Feb 2026 05:49:45 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 18 Feb
 2026 23:49:43 -0600
Received: from xhdsneeli40.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 18 Feb 2026 23:49:39 -0600
From: Srinivas Neeli <srinivas.neeli@amd.com>
To: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <michal.simek@amd.com>,
	<robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
	<richardcochran@gmail.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<git@amd.com>, <srinivas.neeli@amd.com>
Subject: [RFC PATCH 4/8] xilinx: tsn: Add Ethernet MAC (EMAC) and MDIO support to the TSN driver
Date: Thu, 19 Feb 2026 11:19:07 +0530
Message-ID: <20260219054911.2017362-5-srinivas.neeli@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260219054911.2017362-1-srinivas.neeli@amd.com>
References: <20260219054911.2017362-1-srinivas.neeli@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CC:EE_|DM4PR12MB8452:EE_
X-MS-Office365-Filtering-Correlation-Id: 24404c16-e599-40dd-89c4-08de6f7aaf76
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|82310400026|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?SfoXHlZcjADEbkQtEfUTvfgo7lZgKy0VkWul9uqk8W6e/CWsms9fzLTcso7P?=
 =?us-ascii?Q?BQ9vkxkTZwyNdpnxFevBNECOLhREuOyH2vVGjjoY/q0bHwqKJFKMfvoIfz4M?=
 =?us-ascii?Q?3C/aIBQyNPA6jnDF/YlcIrBPndifA0dsmMMGZvhDs34ARnNSmyydQP5GXqv6?=
 =?us-ascii?Q?1F+MzW278uUMytu3cmLB7AH2LVXwj+jv2Y0qRkHkmZH43TwmN5icWAXTlBa6?=
 =?us-ascii?Q?oZG0if6DbXIy0f+/fG12tR9A2iyjFj7jXD8eOE374t5HpQT+WAKIJ/kHOYbz?=
 =?us-ascii?Q?uZF86JcUnl9PGnIkt8eENP5uxvjshTrZXjCLGByc2RYZD9ozhwayxRZWCok1?=
 =?us-ascii?Q?gxQm281ijtZHr4BdtmzNHGxUsIQNoXTd4dpHsuCmSOVMi2cwStf+yj8Yj+K7?=
 =?us-ascii?Q?omuPe1mOHfiJfr1Zi2vO8XA0/MMinVVtjzUneZcS0uEX45NZB+qPc0Ee8Y51?=
 =?us-ascii?Q?3DBMCUMAPz7ZAWMJiv7dkBX0rqrseTNVSRvNKsWWuF/koDgOvQkGX1OEklLq?=
 =?us-ascii?Q?hXCtTyvUIkUzHYn56VH9d5dVGHneEx9Hj9DDdm+MIZ8T6KKjNDVaR9LVq+GP?=
 =?us-ascii?Q?wRb7r01INOk+8ZhpOpN53obngtMiU5e1NXGerZmS77mdnaBJhJWsFr9n8Yvr?=
 =?us-ascii?Q?pwsWG2ryrvFTtqoBpbjK+TdCiYGRIr6UgB9lSEX7gE9oO23a8hRbARWRgGbJ?=
 =?us-ascii?Q?IYSL37ceiJ7hG+JfQFDy/A0TNO35BmOUrW223BfVmol0HelgXJS4Jr+1vbNl?=
 =?us-ascii?Q?n3JpQYqA1KmqrhMOx9VLkq5VdKG7TZGGZL6Le4XCDoct6wogMpLRmz4dTeQz?=
 =?us-ascii?Q?gOw5w62pPH68ReHm64V5RTo8vL3xCurXV3egZpYFj824xfQSfpQ4v7fGYI/2?=
 =?us-ascii?Q?cMBi70NNlMe5t1jMFcpslYopw/B3wYeOcgOKotgF7iugdtHf3TRJipU/tSzL?=
 =?us-ascii?Q?GekZQeAwm+crHNAeM+frhkWtY3JoSOKRDja5Xu9vdntrev5UNlkCNH3uiunl?=
 =?us-ascii?Q?1w59wOoMwk923iUDgRHbv/Brgpja0hD2kTQaUXT5wsvBGKKmncKx20igcaxD?=
 =?us-ascii?Q?lWE41illb5lg2EaNhhge9sdjTXcdGt6fLpRs1VabCcMn9g2cd/1vZv76Lo/M?=
 =?us-ascii?Q?OnC5v4ofVWSZj/82z4W/prqQbhExvqiKKp/1r1JqNcpUtiyzdgcl/ehMG96H?=
 =?us-ascii?Q?DdNTrPC9f/ATBy/d1VbDAQaG33/aHRgENlt3K2DVO773kWy/HgEoc+VHE5H6?=
 =?us-ascii?Q?0jB34wdSqknGWhYj3/4afaVii3v78ffO8gsAcjqHxUZ+E2PJcGcRG1VzZOgp?=
 =?us-ascii?Q?v/jp9n5vnpTCqKQcP994itVkmf4/J/Jcy2FPJirhVsADBvqyeYFacbDcoQ5z?=
 =?us-ascii?Q?iDtew4reQird9pouixHLskdulJCzFierYx9hSHlWGbCyep3UY7D2+3vsr0Wp?=
 =?us-ascii?Q?bz4lbCvRXwWQefitVrQSUznisyGHauK0i0YPq/yOjikclN5h9UlFZsRWGqPs?=
 =?us-ascii?Q?Kss8gvU7Mkm6buoxBZHB4LIbvW4KwKQBpsw2y2WRplDMmUebRFGqVn6xHnQ6?=
 =?us-ascii?Q?6p20sR6Jz0VzJtVJSKWLMB2cxpSob2PKy0nR2IDUsjLo9v8jiFzByjXhv3IV?=
 =?us-ascii?Q?R7LVUlwFcoobruUC15bYooGNXKzAmftbqep8wH4oNF6lWfJMIU2lt/CHviv7?=
 =?us-ascii?Q?0/bfzWOtYG53/chsYohGwWr9+Ow=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(82310400026)(36860700013)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	3v5TnSjpRpYYFfYaPagmqFmNbBIBe/1buYgfzoNYgrImYSX/6zDFhG0t92TKgVpgBr/rz/fLzNZzUWTPOT9+4lAUDijmuB8nO9I//Ndm8JuL9RybPatFGNgYe4wGjds7ZDQWy9qfygpDnBo16lo/fyoz2kU6tiu1nZawwWiOCdHVWCHbrsCX424i/C1dII7M9tg49qQlIc6Y7sjY/N/mb7tYrj1yZ2aL56UaaKiHX595zVNDprvNJ3ELmKX7KMyMYAL001nXOez4eH8iUTxOkls0uLxLeh+6L/jQPQO08ys+YiXP1kbdRbGI+aU64p8OKRMb9/E29yE3Cc/QMtfes/RT5zs7TUtCsMdXjkwphX65rhGcpSMrPFRaE5hDV8Y+s3DbVp4VP/oVmnQeD1Dz0tuYjVSYiuDGbZQu9SIRL20smmH+4xI7p/M2NCwxxycq
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2026 05:49:45.2946
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 24404c16-e599-40dd-89c4-08de6f7aaf76
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001CC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8452
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,amd.com,gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-259404-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[srinivas.neeli@amd.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[amd.com:+];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:mid,amd.com:dkim,amd.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev,dt];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: E087815C355
X-Rspamd-Action: no action

Introduce support for the Ethernet MAC (EMAC) and MDIO controller used by
the TSN driver.

This patch adds:
- EMAC initialization, reset handling, and register access helpers
- MAC address configuration support
- MDIO read/write functions for PHY register access
- Basic PHY detection and link status handling
- Error handling and resource cleanup during initialization failures
- Build system updates to compile the new EMAC/MDIO support

Signed-off-by: Srinivas Neeli <srinivas.neeli@amd.com>
---
 drivers/net/ethernet/xilinx/tsn/Makefile      |   2 +-
 drivers/net/ethernet/xilinx/tsn/xilinx_tsn.h  | 124 +++++++
 .../net/ethernet/xilinx/tsn/xilinx_tsn_emac.c | 326 ++++++++++++++++++
 .../net/ethernet/xilinx/tsn/xilinx_tsn_main.c |  19 +-
 .../net/ethernet/xilinx/tsn/xilinx_tsn_mdio.c | 308 +++++++++++++++++
 5 files changed, 774 insertions(+), 5 deletions(-)
 create mode 100644 drivers/net/ethernet/xilinx/tsn/xilinx_tsn_emac.c
 create mode 100644 drivers/net/ethernet/xilinx/tsn/xilinx_tsn_mdio.c

diff --git a/drivers/net/ethernet/xilinx/tsn/Makefile b/drivers/net/ethernet/xilinx/tsn/Makefile
index 099526877948..5eb6dde67061 100644
--- a/drivers/net/ethernet/xilinx/tsn/Makefile
+++ b/drivers/net/ethernet/xilinx/tsn/Makefile
@@ -1,2 +1,2 @@
 obj-$(CONFIG_XILINX_TSN) :=xilinx_tsn.o
-xilinx_tsn-objs := xilinx_tsn_main.o xilinx_tsn_ep.o
+xilinx_tsn-objs := xilinx_tsn_main.o xilinx_tsn_ep.o xilinx_tsn_emac.o xilinx_tsn_mdio.o
diff --git a/drivers/net/ethernet/xilinx/tsn/xilinx_tsn.h b/drivers/net/ethernet/xilinx/tsn/xilinx_tsn.h
index 054f74b97a38..c8435c09ed2c 100644
--- a/drivers/net/ethernet/xilinx/tsn/xilinx_tsn.h
+++ b/drivers/net/ethernet/xilinx/tsn/xilinx_tsn.h
@@ -25,6 +25,7 @@
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/of_dma.h>
+#include <linux/of_mdio.h>
 #include <linux/of_net.h>
 #include <linux/of_platform.h>
 #include <linux/platform_device.h>
@@ -52,6 +53,91 @@
 #define TSN_TUSER_PORT_MAC1		0x1  /* MAC-1 Port */
 #define TSN_TUSER_PORT_MAC2		0x2  /* MAC-2 Port */
 
+/* TSN MAC Registers */
+#define TSN_RAF_OFFSET		0x00000000 /* Reset and Address filter */
+#define TSN_STATS_OFFSET	0x00000200 /* Statistics counters */
+#define TSN_RCW0_OFFSET		0x00000400 /* Rx Configuration Word 0 */
+#define TSN_RCW1_OFFSET		0x00000404 /* Rx Configuration Word 1 */
+#define TSN_TC_OFFSET		0x00000408 /* Tx Configuration */
+#define TSN_FCC_OFFSET		0x0000040C /* Flow Control Configuration */
+#define TSN_EMMC_OFFSET		0x00000410 /* MAC speed configuration */
+#define TSN_PHYC_OFFSET		0x00000414 /* RX Max Frame Configuration */
+#define TSN_ID_OFFSET		0x000004F8 /* Identification register */
+#define TSN_ABILITY_OFFSET	0x000004FC /* Ability Register offset */
+#define TSN_MDIO_MC_OFFSET	0x00000500 /* MDIO Setup */
+#define TSN_MDIO_MCR_OFFSET	0x00000504 /* MDIO Control */
+#define TSN_MDIO_MWD_OFFSET	0x00000508 /* MDIO Write Data */
+#define TSN_MDIO_MRD_OFFSET	0x0000050C /* MDIO Read Data */
+
+/* Bit masks for TSN Ethernet MDIO interface MC register */
+#define TSN_MDIO_MC_MDIOEN		BIT(6)	   /* MII management enable */
+#define TSN_MDIO_MC_CLOCK_DIVIDE_MAX	0x3F	   /* Maximum MDIO divisor */
+
+/* Bit masks for TSN Ethernet MDIO interface MCR register */
+#define TSN_MDIO_MCR_PHYAD_SHIFT	24         /* Phy Address Shift */
+#define TSN_MDIO_MCR_PHYAD_MASK		GENMASK(28, 24) /* Phy Address Mask */
+#define TSN_MDIO_MCR_REGAD_SHIFT	16         /* Reg Address Shift */
+#define TSN_MDIO_MCR_REGAD_MASK		GENMASK(20, 16) /* Reg Address Mask */
+#define TSN_MDIO_MCR_OP_SHIFT		14         /* Operation Code Shift */
+#define TSN_MDIO_MCR_OP_MASK		GENMASK(15, 14) /* Operation Code Mask */
+#define TSN_MDIO_MCR_OP_READ		BIT(15)    /* Op Code Read */
+#define TSN_MDIO_MCR_OP_WRITE		BIT(14)    /* Op Code Write */
+#define TSN_MDIO_MCR_INITIATE		BIT(11)    /* Initiate MDIO transaction */
+#define TSN_MDIO_MCR_READY		BIT(7)     /* MDIO Ready */
+
+/* Bit masks for TSN Ethernet MDIO Write Data Register */
+#define TSN_MDIO_MWD_SHIFT		0          /* Write Data Shift */
+#define TSN_MDIO_MWD_MASK		GENMASK(15, 0) /* Write Data Mask */
+
+/* Bit masks for TSN Ethernet MDIO Read Data Register */
+#define TSN_MDIO_MRD_SHIFT		0          /* Read Data Shift */
+#define TSN_MDIO_MRD_MASK		GENMASK(15, 0) /* Read Data Mask */
+
+/* Bit masks for Ethernet UAW1 register */
+/* Station address bits [47:32]; Station address
+ * bits [31:0] are stored in register UAW0
+ */
+#define TSN_UAW1_UNICASTADDR_MASK	GENMASK(15, 0)
+
+/* Bit masks for TSN Ethernet EMMC register */
+#define TSN_EMMC_LINKSPEED_SHIFT	30	   /* Link speed shift */
+#define TSN_EMMC_LINKSPEED_MASK		GENMASK(31, 30) /* Link speed mask */
+#define TSN_EMMC_LINKSPEED_10		0x0	   /* 10 Mbit */
+#define TSN_EMMC_LINKSPEED_100		BIT(30)    /* 100 Mbit */
+#define TSN_EMMC_LINKSPEED_1000		BIT(31)    /* 1000 Mbit */
+
+#define TSN_MAX_EMAC_NO			2
+
+/*
+ * struct tsn_emac - TSN Ethernet MAC configuration structure
+ * @ndev: Network device associated with this EMAC instance
+ * @common: Pointer to the main TSN private data structure
+ * @phy_node: Device tree node for the connected PHY device
+ * @phy_mode: PHY interface mode (RGMII, SGMII, etc.)
+ * @phy_flags: PHY-specific configuration flags
+ * @regs: Virtual address mapping of EMAC register space
+ * @regs_start: Physical start address of EMAC register space
+ * @mii_bus: MDIO bus controller for PHY management
+ * @last_link: Previous link state for change detection
+ * @mii_clk_div: MDIO clock divider value
+ * @emac_num: EMAC instance number (1 or 2)
+ * @irq: Interrupt number for this EMAC
+ */
+struct tsn_emac {
+	struct net_device *ndev;
+	struct tsn_priv *common;
+	struct device_node *phy_node;
+	phy_interface_t phy_mode;
+	u32 phy_flags;
+	void __iomem *regs;
+	resource_size_t regs_start;
+	struct mii_bus *mii_bus;
+	u32 last_link;
+	u8 mii_clk_div;
+	int emac_num;
+	int irq;
+};
+
 /*
  * struct skbuf_dma_descriptor - skb for each dma descriptor
  * @sgl: Pointer for sglist.
@@ -106,6 +192,7 @@ struct tsn_endpoint {
  * @regs_start: Start address (physical) of mapped region
  * @regs: ioremap()'d base pointer
  * @ep: Pointer to TSN endpoint structure
+ * @emacs: Array of EMAC instances (up to 2)
  * @clks: Bulk clock data for all required clocks
  * @tx_lock: Spinlock protecting TX rings and related TX state
  * @rx_lock: Spinlock protecting RX rings and related RX state
@@ -117,6 +204,7 @@ struct tsn_endpoint {
  * @max_frm_size: Maximum frame size supported
  * @tx_chans: Array of TX DMA channels
  * @rx_chans: Array of RX DMA channels
+ * @num_emacs: Number of EMAC instances
  */
 struct tsn_priv {
 	struct platform_device *pdev;
@@ -125,6 +213,7 @@ struct tsn_priv {
 	resource_size_t regs_start;
 	void __iomem *regs;
 	struct tsn_endpoint *ep;
+	struct tsn_emac *emacs[TSN_MAX_EMAC_NO];
 	struct clk_bulk_data clks[TSN_NUM_CLOCKS];
 	spinlock_t tx_lock;	/* Protects TX ring buffers */
 	spinlock_t rx_lock;	/* Protects RX ring buffers */
@@ -136,6 +225,7 @@ struct tsn_priv {
 	u32 max_frm_size;
 	struct tsn_dma_chan **tx_chans;
 	struct tsn_dma_chan **rx_chans;
+	u32 num_emacs;
 };
 
 /**
@@ -168,6 +258,40 @@ static inline int tsn_ndo_set_mac_address(struct net_device *ndev, void *p)
 netdev_tx_t tsn_start_xmit_dmaengine(struct tsn_priv *common,
 				     struct sk_buff *skb,
 				     struct net_device *ndev);
+
+/**
+ * emac_iow - Memory mapped TSN EMAC register write
+ * @emac: Pointer to TSN EMAC structure
+ * @off: Address offset from the base address of EMAC registers
+ * @val: Value to be written into the EMAC register
+ *
+ * This function writes the desired value into the corresponding TSN
+ * EMAC register.
+ */
+static inline void emac_iow(struct tsn_emac *emac, off_t off, u32 val)
+{
+	iowrite32(val, emac->regs + off);
+}
+
+/**
+ * emac_ior - Memory mapped TSN EMAC register read
+ * @emac: Pointer to TSN EMAC structure
+ * @off: Address offset from the base address of EMAC registers
+ *
+ * This function reads a value from the corresponding TSN EMAC
+ * register.
+ *
+ * Return: Value read from the EMAC register
+ */
+static inline u32 emac_ior(struct tsn_emac *emac, u32 off)
+{
+	return ioread32(emac->regs + off);
+}
+
 int tsn_ep_init(struct platform_device *pdev);
 void tsn_ep_exit(struct platform_device *pdev);
+int tsn_emac_init(struct platform_device *pdev);
+void tsn_emac_exit(struct platform_device *pdev);
+int tsn_mdio_setup(struct tsn_emac *emac, struct device_node *mac_np);
+void tsn_mdio_teardown(struct tsn_emac *emac);
 #endif /* XILINX_TSN_H */
diff --git a/drivers/net/ethernet/xilinx/tsn/xilinx_tsn_emac.c b/drivers/net/ethernet/xilinx/tsn/xilinx_tsn_emac.c
new file mode 100644
index 000000000000..26a533e313a2
--- /dev/null
+++ b/drivers/net/ethernet/xilinx/tsn/xilinx_tsn_emac.c
@@ -0,0 +1,326 @@
+// SPDX-License-Identifier: GPL-2.0
+#include "xilinx_tsn.h"
+
+#define DRIVER_NAME             "xilinx_tsn_emac"
+#define DRIVER_DESCRIPTION      "Xilinx TSN driver"
+#define DRIVER_VERSION          "1.0"
+
+/**
+ * tsn_adjust_link_tsn - Adjust link parameters
+ * @ndev: Pointer to the net_device structure
+ *
+ * This function is called when the PHY link state changes. It configures
+ * the EMAC link speed register based on the current PHY settings and
+ * updates link status information.
+ */
+static void tsn_adjust_link_tsn(struct net_device *ndev)
+{
+	struct tsn_emac *emac = netdev_priv(ndev);
+	struct phy_device *phy = ndev->phydev;
+	u32 emmc_reg;
+
+	if (!phy || emac->last_link == phy->link)
+		return;
+
+	if (phy->link) {
+		emmc_reg = emac_ior(emac, TSN_EMMC_OFFSET);
+		emmc_reg &= ~TSN_EMMC_LINKSPEED_MASK;
+
+		switch (phy->speed) {
+		case SPEED_1000:
+			emmc_reg |= TSN_EMMC_LINKSPEED_1000;
+			break;
+		case SPEED_100:
+			emmc_reg |= TSN_EMMC_LINKSPEED_100;
+			break;
+		default:
+			dev_warn(&ndev->dev, "Unsupported speed: %d\n", phy->speed);
+			break;
+		}
+
+		emac_iow(emac, TSN_EMMC_OFFSET, emmc_reg);
+		dev_info(&ndev->dev, "Link up: %d Mbps, %s duplex\n",
+			 phy->speed, phy->duplex ? "full" : "half");
+	} else {
+		dev_info(&ndev->dev, "Link down\n");
+	}
+
+	emac->last_link = phy->link;
+}
+
+/**
+ * emac_open - Open the network interface
+ * @ndev: Pointer to the net_device structure
+ *
+ * This function is called when the network interface is brought up.
+ * It connects to the PHY device and starts the PHY if available.
+ *
+ * Return: 0 on success, negative error code on failure
+ */
+static int emac_open(struct net_device *ndev)
+{
+	struct tsn_emac *emac = netdev_priv(ndev);
+	struct phy_device *phydev = NULL;
+
+	if (emac->phy_node) {
+		phydev = of_phy_connect(emac->ndev, emac->phy_node,
+					tsn_adjust_link_tsn,
+					emac->phy_flags,
+					emac->phy_mode);
+		if (!phydev)
+			dev_err(emac->common->dev, "of_phy_connect() failed\n");
+		else
+			phy_start(phydev);
+	}
+
+	return 0;
+}
+
+/**
+ * emac_stop - Stop the network interface
+ * @ndev: Pointer to the net_device structure
+ *
+ * This function is called when the network interface is brought down.
+ * It disconnects the PHY device to stop link monitoring.
+ *
+ * Return: 0 on success
+ */
+static int emac_stop(struct net_device *ndev)
+{
+	if (ndev->phydev)
+		phy_disconnect(ndev->phydev);
+
+	return 0;
+}
+
+/**
+ * emac_validate_addr - Validate the MAC address
+ * @ndev: Pointer to the net_device structure
+ *
+ * This function validates the current MAC address of the device.
+ *
+ * Return: 0 if address is valid, negative error code otherwise
+ */
+static int emac_validate_addr(struct net_device *ndev)
+{
+	return eth_validate_addr(ndev);
+}
+
+/**
+ * emac_start_xmit - Transmit packet handler
+ * @skb: Socket buffer containing the packet
+ * @ndev: Pointer to the net_device structure
+ *
+ * This function handles packet transmission for EMAC interfaces.
+ * Currently drops packets and updates statistics as EMAC is not
+ * configured for actual transmission.
+ *
+ * Return: NETDEV_TX_OK always
+ */
+static netdev_tx_t emac_start_xmit(struct sk_buff *skb, struct net_device *ndev)
+{
+	struct tsn_emac *emac = netdev_priv(ndev);
+
+	return tsn_start_xmit_dmaengine(emac->common, skb, ndev);
+}
+
+static const struct net_device_ops emac_netdev_ops = {
+	.ndo_open		= emac_open,
+	.ndo_stop		= emac_stop,
+	.ndo_start_xmit		= emac_start_xmit,
+	.ndo_set_mac_address	= tsn_ndo_set_mac_address,
+	.ndo_validate_addr	= emac_validate_addr,
+};
+
+/**
+ * emac_get_drvinfo - Get various TSN Ethernet driver information.
+ * @ndev:       Pointer to net_device structure
+ * @ed:         Pointer to ethtool_drvinfo structure
+ *
+ * This implements ethtool command for getting the driver information.
+ * Issue "ethtool -i ethX" under linux prompt to execute this function.
+ */
+static void emac_get_drvinfo(struct net_device *ndev,
+			     struct ethtool_drvinfo *ed)
+{
+	strscpy(ed->driver, DRIVER_NAME, sizeof(ed->driver));
+	strscpy(ed->version, DRIVER_VERSION, sizeof(ed->version));
+}
+
+static const struct ethtool_ops emac_ethtool_ops = {
+	.get_drvinfo	= emac_get_drvinfo,
+	.get_link	= ethtool_op_get_link,
+	.get_link_ksettings	= phy_ethtool_get_link_ksettings,
+	.set_link_ksettings	= phy_ethtool_set_link_ksettings,
+};
+
+/**
+ * tsn_emac_init - Initialize TSN EMAC interfaces
+ * @pdev: Platform device pointer
+ *
+ * This function initializes all EMAC interfaces found in the device tree.
+ * For each EMAC, it allocates a network device, maps register regions,
+ * sets up PHY connections, configures MDIO bus, and registers the
+ * network interface with the kernel.
+ *
+ * Return: 0 on success, negative error code on failure
+ */
+int tsn_emac_init(struct platform_device *pdev)
+{
+	struct tsn_priv *common = platform_get_drvdata(pdev);
+	struct device *dev = &pdev->dev;
+	struct device_node *emac_np;
+	int ret, array_idx = 0;
+
+	for_each_child_of_node(dev->of_node, emac_np) {
+		struct net_device *ndev;
+		struct tsn_emac *emac;
+		u8 mac_addr[ETH_ALEN];
+		struct resource res;
+		u32 mac_id = 0;
+
+		if (!of_node_name_eq(emac_np, "ethernet-mac"))
+			continue;
+
+		ret = of_property_read_u32(emac_np, "xlnx,mac-id", &mac_id);
+		if (ret) {
+			dev_err(dev, "Missing mandatory property 'xlnx,mac-id' for EMAC %d\n",
+				array_idx + 1);
+			of_node_put(emac_np);
+			goto err_cleanup_all;
+		}
+
+		ndev = alloc_etherdev(sizeof(*emac));
+		if (!ndev) {
+			ret = -ENOMEM;
+			of_node_put(emac_np);
+			goto err_cleanup_all;
+		}
+
+		ret = of_address_to_resource(emac_np, 0, &res);
+		if (ret) {
+			dev_err_probe(dev, ret, "failed to get emac resource\n");
+			goto err_free_ndev_put_node;
+		}
+
+		emac = netdev_priv(ndev);
+		memset(emac, 0, sizeof(*emac));
+		emac->ndev = ndev;
+		emac->common = common;
+		emac->regs_start = common->regs_start + res.start;
+		emac->regs = common->regs + res.start;
+		emac->emac_num = mac_id;
+		/* basic netdev config */
+		ndev->netdev_ops = &emac_netdev_ops;
+		ndev->ethtool_ops = &emac_ethtool_ops;
+		ndev->min_mtu = ETH_ZLEN - ETH_HLEN;
+		ndev->max_mtu = ETH_DATA_LEN;
+		SET_NETDEV_DEV(ndev, dev);
+
+		/* Retrieve the MAC address */
+		ret = of_get_mac_address(emac_np, mac_addr);
+		if (ret == 0 && is_valid_ether_addr(mac_addr))
+			eth_hw_addr_set(ndev, mac_addr);
+
+		emac->phy_node = of_parse_phandle(emac_np, "phy-handle", 0);
+		if (!emac->phy_node) {
+			dev_err(&pdev->dev, "Failed to get 'phy-handle' from device tree\n");
+
+		} else {
+			ret = tsn_mdio_setup(emac, emac_np);
+			if (ret) {
+				dev_warn(&pdev->dev, "error registering MDIO bus for EMAC %d: %d\n",
+					 mac_id, ret);
+				goto err_put_phy_node;
+			}
+		}
+
+		ret = register_netdev(ndev);
+		if (ret) {
+			dev_err(dev, "Failed to register net device for MAC %d\n", mac_id);
+			goto err_teardown_mdio;
+		}
+
+		common->emacs[array_idx] = emac;
+		array_idx++;
+		common->num_emacs = array_idx;
+		continue;
+
+err_teardown_mdio:
+		if (emac->phy_node)
+			tsn_mdio_teardown(emac);
+err_put_phy_node:
+		if (emac->phy_node)
+			of_node_put(emac->phy_node);
+err_free_ndev_put_node:
+		free_netdev(ndev);
+		of_node_put(emac_np);
+		dev_warn(dev, "EMAC %d initialization failed, rolling back\n", mac_id);
+		goto err_cleanup_all;
+	}
+
+	if (array_idx == 0)
+		return -ENODEV;
+
+	return 0;
+
+err_cleanup_all:
+	/* Cleanup all initialized EMACs in reverse order */
+	while (array_idx > 0) {
+		struct tsn_emac *old = common->emacs[--array_idx];
+
+		if (!old)
+			continue;
+
+		dev_info(dev, "Cleaning up MAC %u (array[%d])\n", old->emac_num, array_idx);
+
+		unregister_netdev(old->ndev);
+
+		if (old->phy_node) {
+			tsn_mdio_teardown(old);
+			of_node_put(old->phy_node);
+		}
+
+		free_netdev(old->ndev);
+		common->emacs[array_idx] = NULL;
+	}
+
+	common->num_emacs = 0;
+
+	return ret;
+}
+
+/**
+ * tsn_emac_exit - Cleanup TSN EMAC interfaces
+ * @pdev: Platform device pointer
+ *
+ * This function performs cleanup for all initialized EMAC interfaces.
+ * It unregisters network devices, tears down MDIO buses, releases
+ * PHY connections, and frees allocated memory for each EMAC instance.
+ */
+void tsn_emac_exit(struct platform_device *pdev)
+{
+	struct tsn_priv *common = platform_get_drvdata(pdev);
+	struct device *dev = &pdev->dev;
+	int i;
+
+	/* Cleanup only the EMACs that were actually initialized */
+	for (i = 0; i < common->num_emacs; i++) {
+		struct tsn_emac *emac = common->emacs[i];
+
+		if (!emac)
+			continue;
+
+		dev_info(dev, "Cleaning up MAC %u (array[%d])\n", emac->emac_num, i);
+
+		unregister_netdev(emac->ndev);
+		if (emac->phy_node) {
+			tsn_mdio_teardown(emac);
+			of_node_put(emac->phy_node);
+		}
+		free_netdev(emac->ndev);
+		common->emacs[i] = NULL;
+	}
+
+	common->num_emacs = 0;
+}
diff --git a/drivers/net/ethernet/xilinx/tsn/xilinx_tsn_main.c b/drivers/net/ethernet/xilinx/tsn/xilinx_tsn_main.c
index 9e674f99d83f..7cb07e330f57 100644
--- a/drivers/net/ethernet/xilinx/tsn/xilinx_tsn_main.c
+++ b/drivers/net/ethernet/xilinx/tsn/xilinx_tsn_main.c
@@ -92,13 +92,14 @@ static void tsn_rx_submit_desc(struct tsn_dma_chan *xchan)
  * @tuser: TUSER metadata word from DMA descriptor
  *
  * Extract Input Port ID from TUSER bits[5:4] and return corresponding netdev.
- * Currently only EP is supported; MAC ports will return NULL until implemented.
+ * Supports EP (endpoint) and MAC1/MAC2 (EMAC) ports.
  *
  * Return: net_device pointer on success, NULL if port not available
  */
 static inline struct net_device *tsn_classify_rx_packet(struct tsn_priv *common, u32 tuser)
 {
 	u32 port_id;
+	int i;
 
 	/* Extract Input Port ID from TUSER bits[5:4] */
 	port_id = FIELD_GET(TSN_TUSER_PORT_ID_MASK, tuser);
@@ -112,9 +113,13 @@ static inline struct net_device *tsn_classify_rx_packet(struct tsn_priv *common,
 
 	case TSN_TUSER_PORT_MAC1:
 	case TSN_TUSER_PORT_MAC2:
-		/* MAC ports not yet implemented */
+		for (i = 0; i < common->num_emacs; i++) {
+			if (common->emacs[i] &&
+			    common->emacs[i]->emac_num == port_id)
+				return common->emacs[i]->ndev;
+		}
 		if (net_ratelimit())
-			dev_warn(common->dev, "RX from MAC port %u not yet supported\n", port_id);
+			dev_warn(common->dev, "RX from MAC port %u not found\n", port_id);
 		return NULL;
 
 	default:
@@ -726,13 +731,18 @@ static int tsn_ip_probe(struct platform_device *pdev)
 		goto free_clk;
 	}
 
-	/* Initialize EP - now safe to register because DMA is ready */
 	ret = tsn_ep_init(pdev);
 	if (ret)
 		goto exit_dma;
 
+	ret = tsn_emac_init(pdev);
+	if (ret)
+		goto exit_ep;
+
 	return 0;
 
+exit_ep:
+	tsn_ep_exit(pdev);
 exit_dma:
 	tsn_exit_dmaengine(pdev);
 free_clk:
@@ -748,6 +758,7 @@ static void tsn_ip_remove(struct platform_device *pdev)
 {
 	struct tsn_priv *common = platform_get_drvdata(pdev);
 
+	tsn_emac_exit(pdev);
 	/* Tear down DMA channels and endpoint */
 	if (common->ep)
 		tsn_ep_exit(pdev);
diff --git a/drivers/net/ethernet/xilinx/tsn/xilinx_tsn_mdio.c b/drivers/net/ethernet/xilinx/tsn/xilinx_tsn_mdio.c
new file mode 100644
index 000000000000..a057378c9d22
--- /dev/null
+++ b/drivers/net/ethernet/xilinx/tsn/xilinx_tsn_mdio.c
@@ -0,0 +1,308 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * TSN MDIO bus driver
+ */
+
+#include "xilinx_tsn.h"
+
+#define MAX_MDIO_FREQ		2500000 /* 2.5 MHz */
+#define DEFAULT_AXI_CLK_FREQ	150000000 /* 150 MHz */
+
+/**
+ * emac_ior_read_mcr - Read MDIO Control Register
+ * @emac: Pointer to TSN EMAC structure
+ *
+ * This function reads the MDIO Control Register (MCR) and is used
+ * as a callback for polling operations.
+ *
+ * Return: Value of MCR register
+ */
+static inline u32 emac_ior_read_mcr(struct tsn_emac *emac)
+{
+	return emac_ior(emac, TSN_MDIO_MCR_OFFSET);
+}
+
+/**
+ * tsn_mdio_wait_until_ready - Wait for MDIO interface to be ready
+ * @emac: Pointer to TSN EMAC structure
+ *
+ * This function polls the MDIO Control Register until the READY bit
+ * is set, indicating the interface is ready for a new transaction.
+ *
+ * Return: 0 on success, -ETIMEDOUT on timeout
+ */
+static int tsn_mdio_wait_until_ready(struct tsn_emac *emac)
+{
+	u32 val;
+
+	return readx_poll_timeout(emac_ior_read_mcr, emac,
+				  val, val & TSN_MDIO_MCR_READY,
+				  1, 20000);
+}
+
+/**
+ * tsn_mdio_mdc_enable - Enable MDIO MDC clock
+ * @emac: Pointer to TSN EMAC structure
+ *
+ * This function enables the MDIO Management Data Clock (MDC) by setting
+ * the appropriate bits in the MDIO Control register. Called prior to
+ * read/write operations.
+ */
+static void tsn_mdio_mdc_enable(struct tsn_emac *emac)
+{
+	emac_iow(emac, TSN_MDIO_MC_OFFSET,
+		 ((u32)emac->mii_clk_div | TSN_MDIO_MC_MDIOEN));
+}
+
+/**
+ * tsn_mdio_mdc_disable - Disable MDIO MDC clock
+ * @emac: Pointer to TSN EMAC structure
+ *
+ * This function disables the MDIO Management Data Clock (MDC) by clearing
+ * the enable bit in the MDIO Control register. Called after read/write
+ * operations to save power.
+ */
+static void tsn_mdio_mdc_disable(struct tsn_emac *emac)
+{
+	u32 mc_reg;
+
+	mc_reg = emac_ior(emac, TSN_MDIO_MC_OFFSET);
+	emac_iow(emac, TSN_MDIO_MC_OFFSET,
+		 (mc_reg & ~TSN_MDIO_MC_MDIOEN));
+}
+
+/**
+ * tsn_mdio_read - MDIO interface read function
+ * @bus:	Pointer to mii bus structure
+ * @phy_id:	Address of the PHY device
+ * @reg:	PHY register to read
+ *
+ * Return:	The register contents on success, -ETIMEDOUT on a timeout
+ *
+ * Reads the contents of the requested register from the requested PHY
+ * address by first writing the details into MCR register. After a while
+ * the register MRD is read to obtain the PHY register content.
+ */
+static int tsn_mdio_read(struct mii_bus *bus, int phy_id, int reg)
+{
+	u32 rc;
+	int ret;
+	struct tsn_emac *emac = bus->priv;
+	struct tsn_priv *common = emac->common;
+
+	scoped_guard(mutex, &common->mdio_lock) {
+		tsn_mdio_mdc_enable(emac);
+
+		ret = tsn_mdio_wait_until_ready(emac);
+		if (ret < 0) {
+			tsn_mdio_mdc_disable(emac);
+			return ret;
+		}
+
+		emac_iow(emac, TSN_MDIO_MCR_OFFSET,
+			 FIELD_PREP(TSN_MDIO_MCR_PHYAD_MASK, phy_id) |
+			 FIELD_PREP(TSN_MDIO_MCR_REGAD_MASK, reg) |
+			 TSN_MDIO_MCR_INITIATE |
+			 TSN_MDIO_MCR_OP_READ);
+
+		ret = tsn_mdio_wait_until_ready(emac);
+		if (ret < 0) {
+			tsn_mdio_mdc_disable(emac);
+			return ret;
+		}
+
+		rc = FIELD_GET(TSN_MDIO_MRD_MASK,
+			       emac_ior(emac, TSN_MDIO_MRD_OFFSET));
+		tsn_mdio_mdc_disable(emac);
+	}
+	dev_dbg(common->dev, "%s (phy_id=%i, reg=%x) == %x\n",
+		__func__, phy_id, reg, rc);
+
+	return rc;
+}
+
+/**
+ * tsn_mdio_write - MDIO interface write function
+ * @bus:	Pointer to mii bus structure
+ * @phy_id:	Address of the PHY device
+ * @reg:	PHY register to write to
+ * @val:	Value to be written into the register
+ *
+ * Return:	0 on success, -ETIMEDOUT on a timeout
+ *
+ * Writes the value to the requested register by first writing the value
+ * into MWD register. The MCR register is then appropriately setup
+ * to finish the write operation.
+ */
+static int tsn_mdio_write(struct mii_bus *bus, int phy_id, int reg,
+			  u16 val)
+{
+	struct tsn_emac *emac = bus->priv;
+	struct tsn_priv *common = emac->common;
+	int ret;
+
+	dev_dbg(common->dev, "%s (phy_id=%i, reg=%x, val=%x)\n",
+		__func__, phy_id, reg, val);
+	scoped_guard(mutex, &common->mdio_lock) {
+		tsn_mdio_mdc_enable(emac);
+
+		ret = tsn_mdio_wait_until_ready(emac);
+		if (ret < 0) {
+			tsn_mdio_mdc_disable(emac);
+			return ret;
+		}
+
+		emac_iow(emac, TSN_MDIO_MWD_OFFSET, (u32)val);
+		emac_iow(emac, TSN_MDIO_MCR_OFFSET,
+			 FIELD_PREP(TSN_MDIO_MCR_PHYAD_MASK, phy_id) |
+			 FIELD_PREP(TSN_MDIO_MCR_REGAD_MASK, reg) |
+			 TSN_MDIO_MCR_INITIATE |
+			 TSN_MDIO_MCR_OP_WRITE);
+
+		ret = tsn_mdio_wait_until_ready(emac);
+		if (ret < 0) {
+			tsn_mdio_mdc_disable(emac);
+			return ret;
+		}
+		tsn_mdio_mdc_disable(emac);
+	}
+	return 0;
+}
+
+/**
+ * tsn_mdio_enable - Configure and enable MDIO controller
+ * @emac: Pointer to TSN EMAC structure
+ *
+ * This function calculates the appropriate clock divisor for MDIO timing
+ * based on the host clock frequency, programs the divisor, and enables
+ * the MDIO controller. It ensures MDIO frequency does not exceed 2.5 MHz.
+ *
+ * Return: 0 on success, negative error code on failure
+ */
+static int tsn_mdio_enable(struct tsn_emac *emac)
+{
+	struct tsn_priv *common = emac->common;
+	u32 axi_clk_freq;
+	u32 clk_div;
+	int i;
+
+	emac->mii_clk_div = 0;
+
+	/* Pick the right clock for MDIO timing */
+	axi_clk_freq = 0;
+	for (i = 0; i < TSN_NUM_CLOCKS; i++) {
+		const char *id = common->clks[i].id;
+
+		if (id && !strcmp(id, "s_axi_aclk") && common->clks[i].clk) {
+			axi_clk_freq = clk_get_rate(common->clks[i].clk);
+			break;
+		}
+	}
+
+	if (!axi_clk_freq) {
+		dev_warn(common->dev,
+			 "Could not get s_axi_aclk, assuming %d Hz\n",
+			 DEFAULT_AXI_CLK_FREQ);
+		axi_clk_freq = DEFAULT_AXI_CLK_FREQ;
+	}
+
+	/* Equation: fMDIO = fHOST / ((1 + clk_div) * 2)
+	 * Must ensure fMDIO <= 2.5 MHz
+	 */
+	clk_div = (axi_clk_freq / (MAX_MDIO_FREQ * 2)) - 1;
+	if (axi_clk_freq % (MAX_MDIO_FREQ * 2))
+		clk_div++;
+
+	emac->mii_clk_div = clk_div;
+
+	dev_dbg(common->dev,
+		"MDIO: host_clk=%u Hz, clk_div=%u\n",
+		axi_clk_freq, clk_div);
+
+	/* Program divisor and enable MDIO controller */
+	dev_info(common->dev,
+		 "MDIO: writing to offset=0x%x, value=0x%lx\n",
+		 TSN_MDIO_MC_OFFSET,
+		 (unsigned long)(emac->mii_clk_div | TSN_MDIO_MC_MDIOEN));
+
+	/* Program divisor and enable MDIO controller */
+	emac_iow(emac, TSN_MDIO_MC_OFFSET,
+		 emac->mii_clk_div | TSN_MDIO_MC_MDIOEN);
+	return tsn_mdio_wait_until_ready(emac);
+}
+
+/**
+ * tsn_mdio_setup - Setup MDIO bus for TSN EMAC
+ * @emac: Pointer to TSN EMAC structure
+ * @mac_np: Device tree node for MAC
+ *
+ * This function initializes the MDIO bus for the TSN EMAC interface.
+ * It allocates an MII bus structure, configures MDIO timing, finds
+ * the MDIO device tree node, and registers the MDIO bus with the kernel.
+ *
+ * Return: 0 on success, negative error code on failure
+ */
+int tsn_mdio_setup(struct tsn_emac *emac, struct device_node *mac_np)
+{
+	struct tsn_priv *common = emac->common;
+	struct device_node *mdio_node;
+	struct mii_bus *bus;
+	int ret;
+
+	bus = mdiobus_alloc();
+	if (!bus)
+		return -ENOMEM;
+
+	snprintf(bus->id, MII_BUS_ID_SIZE, "tsn-mac-%.8llx",
+		 (unsigned long long)emac->regs_start);
+
+	bus->priv = emac;
+	bus->name = "Xilinx TSN Ethernet MDIO";
+	bus->read = tsn_mdio_read;
+	bus->write = tsn_mdio_write;
+	bus->parent = common->dev;
+	emac->mii_bus = bus;
+
+	mdio_node = of_get_child_by_name(mac_np, "mdio");
+	if (!mdio_node) {
+		dev_err(common->dev, "MAC%d: missing 'mdio' child node\n",
+			emac->emac_num);
+		ret = -ENODEV;
+		goto unregister;
+	}
+	ret = tsn_mdio_enable(emac);
+	if (ret < 0)
+		goto unregister;
+	ret = of_mdiobus_register(bus, mdio_node);
+	if (ret) {
+		dev_err(common->dev, "Failed to register MDIO bus for MAC%d\n",
+			emac->emac_num);
+		goto unregister_mdio_enabled;
+	}
+	of_node_put(mdio_node);
+	tsn_mdio_mdc_disable(emac);
+	return 0;
+
+unregister_mdio_enabled:
+	tsn_mdio_mdc_disable(emac);
+unregister:
+	of_node_put(mdio_node);
+	mdiobus_free(bus);
+	emac->mii_bus = NULL;
+	return ret;
+}
+
+/**
+ * tsn_mdio_teardown - Cleanup MDIO bus for TSN EMAC
+ * @emac: Pointer to TSN EMAC structure
+ *
+ * This function performs cleanup operations for the MDIO bus.
+ * It unregisters the MDIO bus from the kernel and frees any
+ * associated memory for the MII bus structure.
+ */
+void tsn_mdio_teardown(struct tsn_emac *emac)
+{
+	mdiobus_unregister(emac->mii_bus);
+	mdiobus_free(emac->mii_bus);
+	emac->mii_bus = NULL;
+}
-- 
2.25.1


