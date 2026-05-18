Return-Path: <netdev+bounces-288836-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +KXWDeaCCmqv2AQAu9opvQ
	(envelope-from <netdev+bounces-288836-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 05:09:26 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AB53956552E
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 05:09:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3F4FE3059E2E
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 03:04:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9EB026B973;
	Mon, 18 May 2026 03:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="WUFo9wRc"
X-Original-To: netdev@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013042.outbound.protection.outlook.com [52.101.83.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8573637E2F7;
	Mon, 18 May 2026 03:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779073429; cv=fail; b=MXJYXmCxbuJf9ybpZzaxdPEEdTn2t/KRxNM///DEKhwufXUOavKTR+LUwN2H6NG3QjUErNTMylH2VKqvjYeDj175cMc7aSr8AQs9s8NPDyXdx3PWYbFSL350YUU7E//mxgVB/6PZ80hDEbl6rMq9VJDzzrJzi/sOdvZZBCQdwrM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779073429; c=relaxed/simple;
	bh=G7iiO69QxtV4BJMo6xS2hTP3K55zFMfhw2FCeF4gL2U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Yg+ZvLVmH+NgXTHTmnLarzwvGijyHe3h3iB2gPU8NKQPZ5J6ChOlx+JiMkHAocORuFKWxqxbAN8zKy6yQiqTNKlPVT8bLCL7V95X1IQjqlps/e5FH8GF4Cx3Mnaz4B1lS3qo7K6eA9TaYZx8IOc4VTEwe+UoIth/tYCZFFctTl8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=WUFo9wRc; arc=fail smtp.client-ip=52.101.83.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GHUw84BYOXkexmIbc4f347BKV2tIljjuyBcTPOyfw4HLSEE1PjBCer9bPYO+UsRY+BEhKZVgFhElaJu7lIXhcSQN/bUMBjEo1R/16OhfsF4gG60C/BxN4/0f1hm7l31ffxn9iD4PegZuJ5njGzwAGJDhO5fFF/i+Q977O1KjSbeySjrqeyh6LK+zou7N9I8Qs8fH13Jo/OwHmgjxWx7a7MZKx92vtpqD3HH/ZUl7Ig+5X/3eHtf9j/P2GYRvX87omI2RcO6xBOe7yQW7zYLA+ef0+I5t3WaikHkVmFJ2J/mhUQv42tSrSnLUEIrPlm+dB4Xtwe+p8Tlu1su9Ncvs1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wT+18sSbF/UwxHwetvQGHKNFQyZRTTe4VmdC/kIudBc=;
 b=LgtQOgntzhdjfMYJRoxKinXkOqANORfvy8fuvn6KLdeOPMSvjXeioLisgPG94pQ9JTAk+h9FzwZFpxG8Kl4B/vejivhqNw4sKP3Sq2frPGQxNp7e80S8ePgk/kF8EyoWds27IK+vOxOMTd11yWB1eh7MTO/4qp7FqGCCPFVxWxgAN0sVFgMcbp4MIz2PcrtQQ19lgDCPK3U3DCQ9/hbbx3aDv0IbLfcY0uz3uuppo9qUG61cw+amnQ0fOeUSbTtk+jYiUwpyF55KfeN+/Lqy6AcVyjd6UNxXqK9WYBve98CltGtOpfrUhZCcWDks0hg2zV2Owa20AbFsSn/jcLHIBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wT+18sSbF/UwxHwetvQGHKNFQyZRTTe4VmdC/kIudBc=;
 b=WUFo9wRcyuANiu4WlSFEe5ouzoXo0tDxP+syPcOhfPC/e7hH2ppLbDnHSJzngVeBzsGIEsZmaZZPIQ3NMXBHA+rgRaCYUxz4/ydGeMGhdMIQc41i/ueZrjcj8ie+aEOuK8I04VgQy03yfYkGPRzvlNfkgE+KwDJtxsF4STDsNLTL3g4IEvh4kX9HXpEF4N64sqrGxqmF9U7HD8GuPgwtPLGhPGbH2Ea1BN/noCfd98PrHD3T2alihJ1m+Gjbk0pLVDXBUZT+x+bc/JT1K/sND3NjOeUOFSHyd3nQBayR1ne4xcXSP10jU/+J7loOyj9tVmzPqijt2Yo0x4epUMCwww==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DBBPR04MB7500.eurprd04.prod.outlook.com (2603:10a6:10:1f4::16)
 by PA3PR04MB11180.eurprd04.prod.outlook.com (2603:10a6:102:4b2::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.21; Mon, 18 May
 2026 03:03:36 +0000
Received: from DBBPR04MB7500.eurprd04.prod.outlook.com
 ([fe80::c291:543b:4bde:cee7]) by DBBPR04MB7500.eurprd04.prod.outlook.com
 ([fe80::c291:543b:4bde:cee7%6]) with mapi id 15.20.9913.009; Mon, 18 May 2026
 03:03:36 +0000
From: Wei Fang <wei.fang@nxp.com>
To: claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: imx@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	catalin.horghidan@nxp.com
Subject: [PATCH v2 net 9/9] net: enetc: avoid VF->PF mailbox timeout during SR-IOV teardown
Date: Mon, 18 May 2026 11:05:35 +0800
Message-Id: <20260518030535.1057228-10-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260518030535.1057228-1-wei.fang@nxp.com>
References: <20260518030535.1057228-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0037.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::13) To DBBPR04MB7500.eurprd04.prod.outlook.com
 (2603:10a6:10:1f4::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR04MB7500:EE_|PA3PR04MB11180:EE_
X-MS-Office365-Filtering-Correlation-Id: 52cc67fb-f83f-4166-f8d3-08deb48a0dd1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|19092799006|52116014|366016|1800799024|38350700014|22082099003|56012099003|18002099003|11063799003;
X-Microsoft-Antispam-Message-Info:
	8WhV7TOOee/d8yfIArF9PWUG3z7Y7ho2lOUzancihK1ulqXbzHn7sziTT5FsHw/GbdTvAhuMXeK8Lg+ROU+n/5rYJeBb/ugJFGZCYbRmdT9vNKhG8TvVO3KVgVrjs9HrSSDIyFJpqGqbI/ru14ss4iw29xYbrYbV9EGS0Kg211zhalsabpVmD/yJa/3SsHKpwd2BTQMt+E6Crq1/YYm4n0w8E9GOt7+EWCQInlQGo4Nc7cqSgt5faPG+uwDh3wOEBdQOA2JXok/2F52YE4w8Kxp0vyzfjbYFe0mVSYL1fKYodDVXzm2ihAWskRMoAQmvYaH1g+sbefykjjZKawBvRl8xvoZKbiNkioaSD7nlZrooew2Dl67KU9xYgQ4CYPeET8kVQAx/tncreOiaAuhhFvJxiUyPD7wqHPTxiWay3p5Mx5bopTymxW2SOFue1aynYU2oDQMr8yRVMO9IUBzZZehosHKvkQ455cuOsxIU/4dYkrrOksHN62KlIomEi0Bb3OENl4favFgPY3lyQszY4bitjhe8ODvc/xPi1H3rMhTOTAYFRMUZ6JnPmChAKRb75B2sveFVSXpsVzpx9hqawPwP8z8k6y3inzHffH6HvDxd+F3mrjc1JzDkFzyUh0JonpnLRBofVjcbJliCUPWVZM1eQmA6eF+p6myu1RhdBaqC/HfYfFEXn+83g6XlPMiNwfYkJddsoQT0+nusCC0CHzdZTo5TKz92T6hzaRq9j2bzxdw8YPb56MyBT7stzUh0
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR04MB7500.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(19092799006)(52116014)(366016)(1800799024)(38350700014)(22082099003)(56012099003)(18002099003)(11063799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4CURt4TOTkLuL3jVwEqo/nHd5OsQRDjXZSyLM4Rosk0lApJXLlkBvLuKa8fx?=
 =?us-ascii?Q?fnEE7jNdwABFEDhsRTH/2mmiO+2l6Viq8nctqDuNTD2Z52+bdfm2O1YYxPV2?=
 =?us-ascii?Q?zU/ugiMB6L+ila/SBCuMtoZy6wduWx5Nmy8NGnA+3uxPcFFeX7rE+ZGPGUmM?=
 =?us-ascii?Q?l/JJ4FRIsJVMDo2jyXNl0wdQ2NS5Gtp47B58aAMXcQ8dEHPBmyEJ+nVvIS1t?=
 =?us-ascii?Q?K4TgpfaWQtMXynWdwgEYOiKNCXURHK8EnjfqzEx1TT3KzJT1hF7OjBF8a30x?=
 =?us-ascii?Q?fV9M78xlT7v6QNhJBJmwjAqWdjmhPf4rp5zvZazuUdWPrEDF0+iq0GDkk7yt?=
 =?us-ascii?Q?t21QxY6NvjpI3eL3lb8LmuCRLeoKumJAI9cEniCwRVEcRYaJFK5RNRBIy71s?=
 =?us-ascii?Q?REHGXkgWrqkD4ivoznfyG5YyAeCLu0wU4V/3lPvyLFGx8L4kssLf+9WMW3kt?=
 =?us-ascii?Q?i98UDBW9J+xrNX4/8M4cxkcWprjfoOkSQD3xbHHaQbAwy+USu4Uu30hQnAzH?=
 =?us-ascii?Q?lL8zVGaq4VtnnZL8g+CroYgQTTN/hNBq5XC79cRCOZBPVm8nBSxb1d4H/SBE?=
 =?us-ascii?Q?HOgoB1LVifme7IBsj+Y5909xK6esqhXOj2GkQASFXTYdf6Vwm8Ex14nehrvh?=
 =?us-ascii?Q?DeC2VseX1JedfqZB04KIeGHMIc9IK/lqB43mSUVQ4G1NeJMDGbkuzuEVzoTW?=
 =?us-ascii?Q?6mKyHDhvhyveSvJGJkhNqgVv52OeSYE3Unb5z1fEPgEbYSZdjoFfbf80S9Vf?=
 =?us-ascii?Q?03SzsqincvcfRCWq6CMlRPOFMk7dfm/M6zovSoaUGV4OT7Iez6rFp1tYzx+Z?=
 =?us-ascii?Q?6dXRogHD6ASO6paTmdOcueveftmwIliZgBmAoR8l2aZydyWKhdz5nnbbSyw9?=
 =?us-ascii?Q?Vy1AgbJ47N+lYp194qSVGVO+JimrPoVGml7bkwxwTn4FMTX3q5YiD6h/RBxM?=
 =?us-ascii?Q?1sH1o7TLrc2lImPEJeCwVT/EsV2vYhF3NYhv/fVvjKv4CDpzx97p7LWoNXKR?=
 =?us-ascii?Q?4yzGVV0p0FypzkvDlRLGgHlFM7z2JyJqrqqlAkg1FdaRMCJcVaHJeYQ1ZZ5W?=
 =?us-ascii?Q?dACJfPLHcWkXRsGVyrk320mzYOEek+LqaIT1kZkLnDOxEy51M1AS3PpT0oPy?=
 =?us-ascii?Q?VlVei5YnE4LvMxXLY4Yy3Y2lVgx5nRmUq3MWXPygpBitP2y0hcg77f896J2h?=
 =?us-ascii?Q?YfTejpCPxYqU/j391DVI7d4FTRgBjl5XrZpubXxYV72ssQMm1qYkwFkJ35x+?=
 =?us-ascii?Q?sKME9SvBCULco5PU/eoiWqjtQsuX4Pwho+GqjNQc2xt+u6cjpTflMuTURBbo?=
 =?us-ascii?Q?lYN4pisvPj2arJYVYpsy+lczbqX3Z+jduW+aURA9BMYW9oo2Zl5GYgB6p4r0?=
 =?us-ascii?Q?Hl3fVy9GIXypyG5ytealjBwsfIMBBhYycNuBHBEF5jISSSLsuKdthOagswpt?=
 =?us-ascii?Q?V/MPjhxgaH0+qD5bzCPd9WTPzVlSEc5cb1Drw7yC4tQORY5HYE6DUgvFsrJN?=
 =?us-ascii?Q?RU8P7zZKFVp6jwyApPuzNUAxPWZzOUfOUWpXvd0+qWsFxWYaN+aHB/FOLnCS?=
 =?us-ascii?Q?R0c90dPE+369eY40MlC9wo+VIsyEpWOTVmej4ITiyIK6isEBruDUYPWXuUG+?=
 =?us-ascii?Q?W9rNrQt/3nXk4EsXQCaYWUue8emJYmHgHRscxhX4w8MNebCB1xBMiJ9mtWgj?=
 =?us-ascii?Q?rxOEfcWWGv2Ou4TEa9AzsDDEoEGv0A8tGuCcTIFw/5iNV8fTMLqURCRQMrRg?=
 =?us-ascii?Q?Iq27NCrq+Q=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52cc67fb-f83f-4166-f8d3-08deb48a0dd1
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7500.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2026 03:03:36.4937
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /719+SZx3RUjH31LlxnV+txkxbbnRrmN08X5xc06Z3mTI9OR2gistabUIc4aW756rv/G6+JatTuffycbAu7X9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA3PR04MB11180
X-Rspamd-Queue-Id: AB53956552E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-288836-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_TWELVE(0.00)[12];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wei.fang@nxp.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,nxp.com:mid,nxp.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

During SR-IOV teardown, enetc_msg_psi_free() disables the MR interrupt
before pci_disable_sriov() removes the VFs. If a VF sends a mailbox
message during this window, the PF cannot receive it, causing the VF to
timeout waiting for a reply.

Since the timeout occurs during SR-IOV teardown when the VF is about to
be removed anyway, it has no functional impact on operation. However,
more messages will be added in the future, some visible error logs may
confuse users. So fix it by calling pci_disable_sriov() first to remove
all VFs, then safely clean up the mailbox resources. This eliminates the
race window where VFs could send messages to an unresponsive PF.

Fixes: beb74ac878c8 ("enetc: Add vf to pf messaging support")
Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/ethernet/freescale/enetc/enetc_pf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf.c b/drivers/net/ethernet/freescale/enetc/enetc_pf.c
index 8e11a023d516..3206b3daa1a0 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_pf.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_pf.c
@@ -563,9 +563,9 @@ static int enetc_sriov_configure(struct pci_dev *pdev, int num_vfs)
 	int err;
 
 	if (!num_vfs) {
+		pci_disable_sriov(pdev);
 		enetc_msg_psi_free(pf);
 		pf->num_vfs = 0;
-		pci_disable_sriov(pdev);
 	} else {
 		pf->num_vfs = num_vfs;
 
-- 
2.34.1


