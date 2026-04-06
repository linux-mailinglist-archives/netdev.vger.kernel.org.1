Return-Path: <netdev+bounces-275745-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oNlgGz0k1GlxrgcAu9opvQ
	(envelope-from <netdev+bounces-275745-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Apr 2026 23:23:09 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 23FE03A784A
	for <lists+netdev@lfdr.de>; Mon, 06 Apr 2026 23:23:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9E2EA302B50F
	for <lists+netdev@lfdr.de>; Mon,  6 Apr 2026 21:22:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D977390980;
	Mon,  6 Apr 2026 21:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="nOPqza9w"
X-Original-To: netdev@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012047.outbound.protection.outlook.com [52.101.66.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A8DE38C433
	for <netdev@vger.kernel.org>; Mon,  6 Apr 2026 21:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775510542; cv=fail; b=vC49+qB4PQP/g9mOqLqW4+aC/YsKUxFBjPR7LanVSHHsxAb8OLT+1PS8P5/7vMWEF/7KuahKZCh/dEvPEKOMX16D+qYD4g5sPj3HaU9Xf/lpkAdWMJFF+s/E//MoIrn6bGBTTtwjqWu80Bm1i2rpGDVIUhdynd7VHVrIZrcF3jA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775510542; c=relaxed/simple;
	bh=6n/tlpepU/gW7fMmTmtdIMrLHbA+lH6ZHuXwBKseyuA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XH6KVdzwqDanUCKecIjQUUlzo1rEIwxio/EzxbRhD9+AmW/rb0TBhVvCsYbH4wzigruvdhVglSZCEX6FKagusJKyiH2NmAC8vrXknfMJ54a2QU/0nOQ5UNaSg1Du2jyyjghTK4vG++/7x1xjyihmuwF4LcK7lSxQBH2fX0lide4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=nOPqza9w; arc=fail smtp.client-ip=52.101.66.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AWINfqKN7EKtrk8nNiVPHHm2+R/EiALC9AXSQazYsHNAZppY0+JAUqNRdIrfLjVwIaUh1jqfg/Ys4zcwBAGHn9oLWb51pALqXOtNaHRN8kXtDPH2cJJ5mYyYB1SoLc7r8d/x2OiB5KC54FyUusGkiJWQCJ9GRIB3UnsESpvRgSSM3O0tS6Y1TwVkZSeBZexu/Axq8P4nxlkRSzufq8J7SD6+LvAFTh3mDK/PruNciyvxkm12GaOgMDL+HWFGOeTYbzlYfjCMIb0KVWmLqe48P2bP9BRj0Gm3hfk8pYrIFtmmIhi03SC3LTSezZnM0ZO4BZWRgxPEXP9WhC1LiDy8Ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6jhYsaQBllsHe8iy6JfZXbPfJ1/+twghE8Nc8mkaFhw=;
 b=Lm4hJktE4yvs5bhquR4yNRmn7UIabdVaz4fRIu+S8/4t3Xb5Y528nspgsyXBJ4dUIGnAbl4DKYNTEMOcZuwuMAFiVnemdOORvoXYtz6UPpVAQElXz26cWdsvdaMJ045hyh3vRtY2dJGN6lCaM/w0AMdmBtEPele6Nk9g6d79HqyDprcutrkF7OrS79XzRx3fLPoWBAyFxMl8rJyDhyK30NEEo05Ec2tyPvs/2250DoRKkgqOGNLcokViOydfjBbUs7xYe58zZwpczVjgNEiAM++HSGyuYbgoRNPcRux5wPmLhzkx4o/8CkhE9+EAF2R1uTZRnDEMjaRqBJ/lG69kQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6jhYsaQBllsHe8iy6JfZXbPfJ1/+twghE8Nc8mkaFhw=;
 b=nOPqza9wc4UicZ9TArLTRT8JngizbPJuMpbVQp5qBBQaHGWEyKnhhCaSixrR2ykHj9yUoSKk1wSdrp/GRzzvMafQwSY25p/UFRv1xV7P9BkGLw1g/tdsDaCDL5TsUs3cidxQlQyRGdSqZpx/Td5LBnzyyzPCvwXOruaMm+CjY4KFMOOQgRVVg4BKUVRsksRc3XXsCGEfordRsjTq+XYBg8OZRXE5yM0H1DVOkKVyNtMsx6n6M5MEX2Sum+5XscMD5jU8fSGvSQz50JCamzLsqIurnNcxuOPxXeq6lD2JPNy3Yw/DrWn5mUMpA5nHnSDmrK8AdhIVXgWV1DsGqXfqRw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by AS1PR04MB9583.eurprd04.prod.outlook.com (2603:10a6:20b:472::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.24; Mon, 6 Apr
 2026 21:22:18 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4%4]) with mapi id 15.20.9769.017; Mon, 6 Apr 2026
 21:22:18 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Andrew Lunn <andrew@lunn.ch>
Subject: [PATCH net-next 4/4] net: dsa: eliminate <linux/dsa/loop.h>
Date: Tue,  7 Apr 2026 00:21:58 +0300
Message-ID: <20260406212158.721806-5-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260406212158.721806-1-vladimir.oltean@nxp.com>
References: <20260406212158.721806-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: WA2P291CA0029.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1f::29) To AM9PR04MB8585.eurprd04.prod.outlook.com
 (2603:10a6:20b:438::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8585:EE_|AS1PR04MB9583:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ae52493-a91c-4faf-09b9-08de942294bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|19092799006|10070799003|366016|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	vebNmIa7sSdEAOuuVBhG9Oa7VqxtXKU/zsmR67OIrWqVR7zWFWc+JHnGjcHCdGyQ0GCj9qQcTwUnhp8u9KkwI+gBkoCxZHae6499iV8IOJtMvpMNPzTmvHvO9+21wTq2RwEuZhxOLB9LdgriYiNlTIppJKtxAsZ9bUiwp6AXPsz9SzO4vnD9WFYuMq4b2dbUtyhDMTndmWBfo+yJHXpZ6t3Ygtulh2cznzTNaDP79hU997e2u5kLxbg2GAe2zYj0B54k7daQDKmY2XZeUNNPfwF9S9mNlD2EIEVGKGeVzAc8f4yv70J0eyKMDzqV6Dh7ZEz2+1QiYJzY3GBILd4k3qrlFCAvEarWufl/w8gZj4nhoC9605BrnyvfezHAtTw/DxKFbKIYPc4q9kzNNBXj8r0PvWyjAy2iFDuFdEj0g/cBE2zQ7EZxkrHhik7yiyMfDj3d96U+tV+8bp1XJiLlftJ+PNvRXUvUB8GAGTWe2rTKbZqNKel3smOV+LpoM2laKpXfCEPJIPmsaA5fQl+7zdQsIr1gz92XLjflJk1Rq9MjtWQGsLHaJwrduKh1Hug//wDqKjtPowPdM4q05ziWWgzwGjT/KlPI4ou2HmOk0Y90JNYIl9nEL48Yeh5IntvfdOvX+VpWNX8fzuEIwq8ENWpG8l8r9oJq75jyri+zwRQU4vPbaHtmI4zgRE6y9Z6zBkBTljQOgoyglcmmDtgJ8dVAQpOHRp/PEeHFZfJHwKo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(19092799006)(10070799003)(366016)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4fJio2QrgKW8t1Kgc7GEkNwWo3sz4wxdzX6OcmIbZe1+FN2VNuEUqfQU0hra?=
 =?us-ascii?Q?YtAaIUwk5qcwizlXzVvia2jjefwY//P+MPCQtgoB437aKYeTbfLgtXS3/dHb?=
 =?us-ascii?Q?DVOonnJ2IEtIOvjd3c4+jgSGIWNghwcetT5aUi1lQp0mqppkPv2Xxf6Ijn4K?=
 =?us-ascii?Q?PJICldcziklGBc7dj6OVRG+sN38NV53SD0cBhLw2r8Z8+mr0sR7JJkK8J71N?=
 =?us-ascii?Q?oOpFWtyIFDDTdrvSyT5Qy+oKXko73AMfPbsOfD72p+PdIBWM5GhdL2ixNmgE?=
 =?us-ascii?Q?8G8YlYghgl9mA1YYD1QI9fGKbAA17HJ8vtVTEQ/Reg8Qv0aXwkndnGilyssE?=
 =?us-ascii?Q?a2UFGCndmZxjQPXOYEPJ3CJjNZGayNGDCS3PbISU1uB2ruVpf+ORw7yHIeXd?=
 =?us-ascii?Q?kz9ZAA5z5H9SbAXrq2Vsl2fyO+QPhronnyaj9HDduUt1X/u/3rGdKpedde8/?=
 =?us-ascii?Q?4RLtfNQj+waQc7+qsEgjLRmGr4ded/s84peoafNrVMn0bRhI3Z3Ioj+nQA7G?=
 =?us-ascii?Q?lOpuYLp/1f9IoUlnbtYU+n+z6u6yKBsKhzXU/VYPm0s/82HZkwJ/ZZJq/tWS?=
 =?us-ascii?Q?24mgtdELSoGCLv9NbK4rKK0RmBOwiDP0tEgeRRuAPsy5jZO7LTWXdN0Fkjeb?=
 =?us-ascii?Q?pgcXl6IKrg5pRQu8jz+AGsHSnCb81I8N6t7ypkiCqjzMyUUSfzz+zIa5c1Z7?=
 =?us-ascii?Q?Alt5le4Tuvs+BwWu9gA11d9/loO5nnbIh3EzbJeMPP/qRpsmGd1oZ+O4slUH?=
 =?us-ascii?Q?7fpZsmukD6FwnRGgapnkbVPerQ22blZLDP5LUyhBQtficGpt65s1h2zEFqih?=
 =?us-ascii?Q?2RudirUx5R+H/Qeh1jTFRNfOV0aJDOkN1Ttx7tbB5zh5kLZY35ReKEeUwVF5?=
 =?us-ascii?Q?OzHWtKaH19N8vEezVYg9c4KVbzJpkvlzPwYxlSxALYYANWEnJxwVIdYyYxU/?=
 =?us-ascii?Q?ydVyxbTd9Mxl139uaoQzKSsvYZhk1gcfvu39HdaiHCUFym5vdjK+YQcTWwtL?=
 =?us-ascii?Q?HPoGBXNrDVCOlE53hbItw2b/uryPCwwsdDu39+asiBji0brxWfOcWDemZwLi?=
 =?us-ascii?Q?eHpYrVH7JibGAFpGPCl7hYOHsT5GucPApLDcG3IUuFCRadVmo8TL+su1Fcs0?=
 =?us-ascii?Q?auVv/GC+I7qjktSGi70P9y/SiN19Pabx2BPS7mSkILDnz10ZHnuF1gZPqFBn?=
 =?us-ascii?Q?7iQqCtcG7N1WDXC/CuINkvw+hzPHcyInowxgFOCWOLhZquwZIpbsmS98zzFB?=
 =?us-ascii?Q?hBkI0M4B8T5KhnVIgTvQhBNulJjAbQdtt8py6C+JY8/tWCsiHeT8IHKwDGue?=
 =?us-ascii?Q?0BBVoZqONMq5/e3cNLc/prPVfNL9LjiF6W8yqgoZDF2eqCQS5ZjjKnZafcu/?=
 =?us-ascii?Q?D+yJVPLTrADIw5ttpAGymy9dE7O0jML30DsAZx3Yv2A5+tiH89O1qSkCrS8s?=
 =?us-ascii?Q?b7ndTKvex3zBqEPOgqvqJBGk+5lxavlPPG55DFJQR3LCnwLdaotYrn5nCD1X?=
 =?us-ascii?Q?XNT3UYjdpn0mSPgzMbKVMh5PliWwVRnCJNGEmxb56390U9nCtauUR8JWRRqf?=
 =?us-ascii?Q?WqqFIvni3S46BNso8MC3o38NBgFqqFzrKq1/BE2Z6wjMj+KxIKP1gjXvYcFp?=
 =?us-ascii?Q?MAz+0prhyp0GjU7LYSb2c+a4M1cmbyl0gsiXTCMBxJBPUzyQSwoEg7cZFLwf?=
 =?us-ascii?Q?wCQJUjAkEMPtEHOlwfgqsSIgAvAj30G/1DR+AfjFN2xqk7T9MWiIc/vFT9Ko?=
 =?us-ascii?Q?VAhT6//3brMssAWfE9k+efUyKLyjUBV/5Dw8ukmThUqqHDY6PVOYcgvnzrHS?=
X-MS-Exchange-AntiSpam-MessageData-1: F/UHowzkcP8YklFc5Ucy3kq/j8kSLW7O0PE=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ae52493-a91c-4faf-09b9-08de942294bb
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2026 21:22:17.9468
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4g3zFhrYFDlDNxU3nQaato0c+Pa0eTYqRH85NLGoFPo0NPS4xEh2iybfacnF7Kd3WYUIvTVEnOza/cRFEUYHjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9583
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-275745-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vladimir.oltean@nxp.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:dkim,nxp.com:email,nxp.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 23FE03A784A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

There is no reason at all to export these data types to the global
include directory.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 drivers/net/dsa/dsa_loop.c | 35 ++++++++++++++++++++++++++++++-
 include/linux/dsa/loop.h   | 42 --------------------------------------
 2 files changed, 34 insertions(+), 43 deletions(-)
 delete mode 100644 include/linux/dsa/loop.h

diff --git a/drivers/net/dsa/dsa_loop.c b/drivers/net/dsa/dsa_loop.c
index b41254b3ac42..7058faf23592 100644
--- a/drivers/net/dsa/dsa_loop.c
+++ b/drivers/net/dsa/dsa_loop.c
@@ -14,13 +14,46 @@
 #include <linux/workqueue.h>
 #include <linux/module.h>
 #include <linux/if_bridge.h>
-#include <linux/dsa/loop.h>
+#include <linux/if_vlan.h>
+#include <linux/types.h>
 #include <net/dsa.h>
 
 #define DSA_LOOP_NUM_PORTS	6
 #define DSA_LOOP_CPU_PORT	(DSA_LOOP_NUM_PORTS - 1)
 #define NUM_FIXED_PHYS		(DSA_LOOP_NUM_PORTS - 2)
 
+struct dsa_loop_vlan {
+	u16 members;
+	u16 untagged;
+};
+
+struct dsa_loop_mib_entry {
+	char name[ETH_GSTRING_LEN];
+	unsigned long val;
+};
+
+enum dsa_loop_mib_counters {
+	DSA_LOOP_PHY_READ_OK,
+	DSA_LOOP_PHY_READ_ERR,
+	DSA_LOOP_PHY_WRITE_OK,
+	DSA_LOOP_PHY_WRITE_ERR,
+	__DSA_LOOP_CNT_MAX,
+};
+
+struct dsa_loop_port {
+	struct dsa_loop_mib_entry mib[__DSA_LOOP_CNT_MAX];
+	u16 pvid;
+	int mtu;
+};
+
+struct dsa_loop_priv {
+	struct mii_bus	*bus;
+	unsigned int	port_base;
+	struct dsa_loop_vlan vlans[VLAN_N_VID];
+	struct net_device *netdev;
+	struct dsa_loop_port ports[DSA_MAX_PORTS];
+};
+
 struct dsa_loop_pdata {
 	/* Must be first, such that dsa_register_switch() can access this
 	 * without gory pointer manipulations
diff --git a/include/linux/dsa/loop.h b/include/linux/dsa/loop.h
deleted file mode 100644
index b8fef35591aa..000000000000
--- a/include/linux/dsa/loop.h
+++ /dev/null
@@ -1,42 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef DSA_LOOP_H
-#define DSA_LOOP_H
-
-#include <linux/if_vlan.h>
-#include <linux/types.h>
-#include <linux/ethtool.h>
-#include <net/dsa.h>
-
-struct dsa_loop_vlan {
-	u16 members;
-	u16 untagged;
-};
-
-struct dsa_loop_mib_entry {
-	char name[ETH_GSTRING_LEN];
-	unsigned long val;
-};
-
-enum dsa_loop_mib_counters {
-	DSA_LOOP_PHY_READ_OK,
-	DSA_LOOP_PHY_READ_ERR,
-	DSA_LOOP_PHY_WRITE_OK,
-	DSA_LOOP_PHY_WRITE_ERR,
-	__DSA_LOOP_CNT_MAX,
-};
-
-struct dsa_loop_port {
-	struct dsa_loop_mib_entry mib[__DSA_LOOP_CNT_MAX];
-	u16 pvid;
-	int mtu;
-};
-
-struct dsa_loop_priv {
-	struct mii_bus	*bus;
-	unsigned int	port_base;
-	struct dsa_loop_vlan vlans[VLAN_N_VID];
-	struct net_device *netdev;
-	struct dsa_loop_port ports[DSA_MAX_PORTS];
-};
-
-#endif /* DSA_LOOP_H */
-- 
2.43.0


