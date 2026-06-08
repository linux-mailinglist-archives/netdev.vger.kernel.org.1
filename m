Return-Path: <netdev+bounces-296601-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id twITMKzRJmpKlAIAu9opvQ
	(envelope-from <netdev+bounces-296601-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 16:29:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 504646572F5
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 16:29:00 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=prodrive-technologies.com header.s=selector1 header.b="LJCmch/q";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296601-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-296601-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=prodrive-technologies.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EB644309696A
	for <lists+netdev@lfdr.de>; Mon,  8 Jun 2026 14:17:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0719D3CC7EC;
	Mon,  8 Jun 2026 14:17:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11023142.outbound.protection.outlook.com [40.107.159.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08DD42989B0;
	Mon,  8 Jun 2026 14:17:16 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780928240; cv=fail; b=VY9ubwebutV5JIvLP4A/wM1REB4uNGXShlluHLU2+NghbzqSFdqUPd7J/4UzFA/7tz8L3lnfC1VqynIvyzP30tq5R23Suydxe5UAvRBrLY+GSjitU3m6VlGK+ZckuCCPAHZqIvdJd8c2MAa2zfYuPmX4mPCDhbhL20XQck/yEwg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780928240; c=relaxed/simple;
	bh=Gwc0hNLVECmKuq3Myywx0jxrk+fvDdHFLRvMvUumV5c=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=YhQmsIql9m6Zsj4zTIcbiSyNweyj68FmblonDYfc4UegUecEaGP9vn2Onltcf8FkywolBsoLk7egZoLjFaMlajutlCs/IycZP4T1qm9JjCJfmtUyrpyq/9PDeEpQAlaXi4I8zF5s4CwDUVABnkKngS6gR8sfg3OlP/mmW7r4zfE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=prodrive-technologies.com; spf=pass smtp.mailfrom=prodrive-technologies.com; dkim=pass (1024-bit key) header.d=prodrive-technologies.com header.i=@prodrive-technologies.com header.b=LJCmch/q; arc=fail smtp.client-ip=40.107.159.142
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Pa0ELqyF6yY7gDLijCAxYGkmSllQBPujeywbVLzkmJ+xQi1t2PKD1Z8QFrmPlhu0ZOdyGJ8WZlb4/RJX2lt5vezg6EUbblwrF+qKHwN06Mk76yrWoLbcHZFjxjv9LXVQ9awAjitDK5OJXF0BYRw8/F9Uae5+qgGhZ5kKZr30OBFhnIhii7RvuKqZH7cQ8nUpfiCr0ZvAG9AOL1yBWnjzuhMXKdkY3HhO/bgDtxrKzopMUYAxAAccsii7+qOjPqh2lQYvt/nqiewLtZtDnxaKYli/PZ9Sj2aGLuf5LvdVyiWJL+iAA0wGQjcFt9EmVqqpzPJWZlxzQHBawvABau04UQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4svb6InT9SGE5bH4ztP3H+T9VjoV6gVs706Y6pC1Ej4=;
 b=yYNGGRfxOKDKEhp9b1lVJHRmYEOs83W9r5Tt1cwuc7ACYVFikj5nbo5EyEYuxcdZcdLt7L4ghWt3ZQRJhbMPjo5Z66dRZ7rsPxuBqwTdvmJ7li43V0bfUsn83L5iqHeNKb7BN9DUROHwZN2Gcga2cCqGl7s/HBUz9noqJBFSbE4roCxdublWr1vRsBHH4xZY/eflxfaLsG20gMQZlJiBCynAssxZaBzjNNNahSvz1s5W0RgfKDOHriXXciAiy3iUGoa7feZPBbG7QUkWwzcEdGZf9aXbx0dcKmZMYwAReTBI9EUJTb3U3pFI3thKZtToWT5e58yx/n0QFJt4Mvu0JQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 212.61.153.67) smtp.rcpttodomain=gmail.com
 smtp.mailfrom=prodrive-technologies.com; dmarc=pass (p=reject sp=reject
 pct=100) action=none header.from=prodrive-technologies.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=prodrive-technologies.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4svb6InT9SGE5bH4ztP3H+T9VjoV6gVs706Y6pC1Ej4=;
 b=LJCmch/q40eWVuEgfda0C4ryoCxlX2fA6GvS1+UqY3UHLV57Wp9oeTEZUbeiu+jwnDypXY5Vt/4j3IH4mZvtrVxp09clRkKwSGB08U0HacUNKZtajYTGPD+Z3Vy9fiKQhteR/sGvxPmtXhykbtSKkym0I/uKilh/Znw/V/2CHV0=
Received: from AS4P189CA0031.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:5dd::11)
 by AS4PR02MB8054.eurprd02.prod.outlook.com (2603:10a6:20b:4e2::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.12; Mon, 8 Jun 2026
 14:17:09 +0000
Received: from AMS0EPF00000195.eurprd05.prod.outlook.com
 (2603:10a6:20b:5dd:cafe::84) by AS4P189CA0031.outlook.office365.com
 (2603:10a6:20b:5dd::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.12 via Frontend Transport; Mon, 8
 Jun 2026 14:17:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 212.61.153.67)
 smtp.mailfrom=prodrive-technologies.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=prodrive-technologies.com;
Received-SPF: Pass (protection.outlook.com: domain of
 prodrive-technologies.com designates 212.61.153.67 as permitted sender)
 receiver=protection.outlook.com; client-ip=212.61.153.67;
 helo=webmail.prodrive.nl; pr=C
Received: from webmail.prodrive.nl (212.61.153.67) by
 AMS0EPF00000195.mail.protection.outlook.com (10.167.16.215) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Mon, 8 Jun 2026 14:17:09 +0000
Received: from EXCOP01.bk.prodrive.nl (10.1.0.22) by EXCOP02.bk.prodrive.nl
 (10.1.0.91) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 8 Jun
 2026 16:17:08 +0200
Received: from lnxdevrm02.prodrive.nl (10.1.1.121) by EXCOP01.bk.prodrive.nl
 (10.1.0.22) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Mon, 8 Jun 2026 16:17:08 +0200
From: Martijn de Gouw <martijn.de.gouw@prodrive-technologies.com>
To: Vladimir Oltean <olteanv@gmail.com>, Andrew Lunn <andrew@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
CC: Martijn de Gouw <martijn.de.gouw@prodrive-technologies.com>,
	<linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>
Subject: [PATCH] net: dsa: sja1105: Add rev-rmii support sja1110 devices
Date: Mon, 8 Jun 2026 16:16:51 +0200
Message-ID: <20260608141654.2003932-1-martijn.de.gouw@prodrive-technologies.com>
X-Mailer: git-send-email 2.39.2
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
X-MS-TrafficTypeDiagnostic: AMS0EPF00000195:EE_|AS4PR02MB8054:EE_
X-MS-Office365-Filtering-Correlation-Id: b8957ff8-6fe0-42b2-715f-08dec568a058
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|36860700016|18002099003|3023799007|56012099006|5023799004;
X-Microsoft-Antispam-Message-Info:
	haF6hx7fTm7JOU4K8YKjR6h4jCoipjmPrG7HhSArkEIqKLy1lzRVqhsiCLGTtWAiAw043h+u3N9m8Tepebiyc3fwrM1Lsf6eKnYe+49TuDM4js84CcSC/b+GYnEV0ArHexPr2+CLzbsnB8cFvHX9CzQt4YtIQSLGDbMelmMIN6ZCLLuueujvrSOHvi7K5hp0Q9iXrKSgtNZHiT5zmy9wmC/nDS9rHt1PDn9/rJixbO/Jm9h7XKCGqW4WcuaLBqidkkKTaRqGXhWSG+XTCzcWOhF1qz5ogcbdP+2GFlSmo8PIyej0diohGiLYYjMNT62m7Y/LbffVw1gBdvs9Wr0Vvt/1YvwGtLBFuaRHmCYrIkAl4nXsIfuUINXthXnQmKfJ0Qx4N9S4t9pdfy/j+SsRBBAFRxHYsqSp7drYVuegNU1Cn3DRb5DMNDY2sKjBZIwXsOjU03sEO3pSSslugiCsh+pFPJBnPHtOrSn30WifYR0mwhU419eIGpLRklL5oW0DljaW/DzOKo9G3fkrPUebAYyfxdX5j7bwnrkl48UOjJL4FMpqovBgo2RxA/F7c2rmC54iFCy9B7zi8l2UR/AOcQM5OL/iCSw6HqrgHC7w6tlfp4oXTmpc5AuRMJKnCnR8+wsYPiLwHYHOeP6m56kWpKDhg+5ou1X/RR2GI1xSCZn++kj9eOJcE3F2sN2sfYI8ob9Yn+1YM8u3BXX6SoB+0Gcl7wjanx+lyuMQyC3zPbE=
X-Forefront-Antispam-Report:
	CIP:212.61.153.67;CTRY:NL;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:webmail.prodrive.nl;PTR:mail.prodrive-technologies.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(36860700016)(18002099003)(3023799007)(56012099006)(5023799004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	xoFmYJou2mk+rgCMaRgLe9sfsfBNVjQW++lZkqqodCgPNAf+Re0FXEGt7+L67ariY61EHWaB8BZfWncn1uZPzyCAxlIOFCg2OD5jPySvxwdz3fLDAZaoGyjVljC7wftW75UtQBck9Uqc9JxB0A/PevRT7JlsIe7ofAjwninxp1zns1vwEJrOKLZdu5SoW9aC4LVKPFx4yLaXVv+SIU479Cd8rZRu7Ze6H7blKCJN+SgWZDOAPW3hDUNSzOJH98gOa0FiV3smYHbhPxO2Inwh8IquWJtvcUlaQpDHxjjVtBzNvzKTKlSqLoL0ijA27Vj12DJVRuaFb0aoI5mfeMrqvpMRJDE7gew60JkN5g8kbmTp6Mjpo/tCP2utgXBPoT4zfsw99L/dnUsr4yVGFdI5ygTt8Cc8MpRQ4Uxn/3wzkFlWepWjHIrhqBe2dJgX4UKk
X-OriginatorOrg: prodrive-technologies.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2026 14:17:09.0064
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b8957ff8-6fe0-42b2-715f-08dec568a058
X-MS-Exchange-CrossTenant-Id: 612607c9-5af7-4e7f-8976-faf1ae77be60
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=612607c9-5af7-4e7f-8976-faf1ae77be60;Ip=[212.61.153.67];Helo=[webmail.prodrive.nl]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF00000195.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR02MB8054
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[prodrive-technologies.com,reject];
	R_DKIM_ALLOW(-0.20)[prodrive-technologies.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-296601-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[martijn.de.gouw@prodrive-technologies.com,netdev@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com];
	FORGED_RECIPIENTS(0.00)[m:olteanv@gmail.com,m:andrew@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:martijn.de.gouw@prodrive-technologies.com,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[martijn.de.gouw@prodrive-technologies.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[prodrive-technologies.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,prodrive-technologies.com:dkim,prodrive-technologies.com:email,prodrive-technologies.com:mid,prodrive-technologies.com:from_mime];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 504646572F5

When a rmii port is used in phy-mode (rev-rmii), the ref_clk is an input on
the rx clk pin. Configure both the rx and tx clock source to use the
rx_clk as external clock source input.

Signed-off-by: Martijn de Gouw <martijn.de.gouw@prodrive-technologies.com>
---
 drivers/net/dsa/sja1105/sja1105.h          |   1 +
 drivers/net/dsa/sja1105/sja1105_clocking.c | 197 +++++++++++++++++++++
 drivers/net/dsa/sja1105/sja1105_spi.c      |   8 +-
 3 files changed, 204 insertions(+), 2 deletions(-)

diff --git a/drivers/net/dsa/sja1105/sja1105.h b/drivers/net/dsa/sja1105/sja1105.h
index dceb96ae9c83d..012632533cb68 100644
--- a/drivers/net/dsa/sja1105/sja1105.h
+++ b/drivers/net/dsa/sja1105/sja1105.h
@@ -368,6 +368,7 @@ int sja1105pqrs_setup_rgmii_delay(const void *ctx, int port);
 int sja1110_setup_rgmii_delay(const void *ctx, int port);
 int sja1105_clocking_setup_port(struct sja1105_private *priv, int port);
 int sja1105_clocking_setup(struct sja1105_private *priv);
+int sja1110_clocking_setup(struct sja1105_private *priv);
 int sja1110_disable_microcontroller(struct sja1105_private *priv);
 
 /* From sja1105_ethtool.c */
diff --git a/drivers/net/dsa/sja1105/sja1105_clocking.c b/drivers/net/dsa/sja1105/sja1105_clocking.c
index 08a3e7b962541..826bfd01e0b71 100644
--- a/drivers/net/dsa/sja1105/sja1105_clocking.c
+++ b/drivers/net/dsa/sja1105/sja1105_clocking.c
@@ -6,6 +6,7 @@
 #include "sja1105.h"
 
 #define SJA1105_SIZE_CGU_CMD	4
+#define SJA1105_SIZE_ACU_CMD	4
 #define SJA1110_BASE_MCSS_CLK	SJA1110_CGU_ADDR(0x70)
 #define SJA1110_BASE_TIMER_CLK	SJA1110_CGU_ADDR(0x74)
 
@@ -36,6 +37,29 @@ struct sja1105_cfg_pad_mii_id {
 	u64 txc_pd;
 };
 
+struct sja1110_pin_cfg_mii_tx {
+	u64 d32_ods;
+	u64 d32_pupd;
+	u64 d10_ods;
+	u64 d10_pupd;
+	u64 ctrl_ods;
+	u64 ctrl_pupd;
+	u64 clk_pol;
+	u64 clk_src;
+	u64 clk_ods;
+	u64 clk_pupd;
+};
+
+struct sja1110_pin_cfg_mii_rx {
+	u64 d32_pupd;
+	u64 d10_pupd;
+	u64 ctrl_pupd;
+	u64 clk_pol;
+	u64 clk_src;
+	u64 clk_ods;
+	u64 clk_pupd;
+};
+
 /* UM10944 Table 82.
  * IDIV_0_C to IDIV_4_C control registers
  * (addr. 10000Bh to 10000Fh)
@@ -820,6 +844,179 @@ int sja1105_clocking_setup(struct sja1105_private *priv)
 	return 0;
 }
 
+static void
+sja1110_acu_pin_cfg_mii_tx_packing(void *buf, struct sja1110_pin_cfg_mii_tx *cmd,
+				   enum packing_op op)
+{
+	const int size = 4;
+
+	sja1105_packing(buf, &cmd->d32_ods,   28, 27, size, op);
+	sja1105_packing(buf, &cmd->d32_pupd,  25, 24, size, op);
+	sja1105_packing(buf, &cmd->d10_ods,   20, 19, size, op);
+	sja1105_packing(buf, &cmd->d10_pupd,  17, 16, size, op);
+	sja1105_packing(buf, &cmd->ctrl_ods,  12, 11, size, op);
+	sja1105_packing(buf, &cmd->ctrl_pupd,  9,  8, size, op);
+	sja1105_packing(buf, &cmd->clk_pol,    7,  7, size, op);
+	sja1105_packing(buf, &cmd->clk_src,    6,  5, size, op);
+	sja1105_packing(buf, &cmd->clk_ods,    4,  3, size, op);
+	sja1105_packing(buf, &cmd->clk_pupd,   1,  0, size, op);
+}
+
+static int sja1110_acu_rmii_ext_tx_clk_config(struct sja1105_private *priv,
+					      int port)
+{
+	const struct sja1105_regs *regs = priv->info->regs;
+	struct sja1110_pin_cfg_mii_tx pin_cfg_mii_tx = {0};
+	u8 packed_buf[SJA1105_SIZE_ACU_CMD] = {0};
+
+	if (regs->pad_mii_tx[port] == SJA1105_RSV_ADDR)
+		return 0;
+
+	/* Payload */
+	pin_cfg_mii_tx.d32_ods   = 2; /* TXD[3:2] output stage drive-strength: */
+				      /*   FAST Medium noise / Fast speed (default) */
+	pin_cfg_mii_tx.d32_pupd  = 2; /* TXD[3:2] pull-up/-down: */
+				      /*   PLAIN Pull-up/-down disabled (default) */
+	pin_cfg_mii_tx.d10_ods   = 2; /* TXD[1:0] output stage drive-strength: */
+				      /*   FAST Medium noise / Fast speed (default) */
+	pin_cfg_mii_tx.d10_pupd  = 2; /* TXD[1:0] pull-up/-down: */
+				      /*   PLAIN Pull-up/-down disabled (default) */
+	pin_cfg_mii_tx.ctrl_ods  = 2; /* TX_EN / TX_ER output stage drive-strength: */
+				      /*   FAST Medium noise / Fast speed (default) */
+	pin_cfg_mii_tx.ctrl_pupd = 2; /* TX_EN / TX_ER (weak) pull-up/-down: */
+				      /*   PLAIN Pull-up/-down disabled (default) */
+	pin_cfg_mii_tx.clk_pol   = 0; /* TX_CLK output polarity: */
+				      /*   NORMAL Not inverted (default) */
+	pin_cfg_mii_tx.clk_src   = 3; /* TX_CLK source: */
+				      /*   RXC RX_CLK used */
+	pin_cfg_mii_tx.clk_ods   = 2; /* TX_CLK output stage drive-strength: */
+				      /*   FAST Medium noise / Fast speed (default) */
+	pin_cfg_mii_tx.clk_pupd  = 2; /* TX_CLK (weak) pull-up/-down: */
+				      /*   PLAIN Pull-up/-down disabled (default) */
+	sja1110_acu_pin_cfg_mii_tx_packing(packed_buf, &pin_cfg_mii_tx, PACK);
+
+	return sja1105_xfer_buf(priv, SPI_WRITE, regs->pad_mii_tx[port],
+				packed_buf, SJA1105_SIZE_ACU_CMD);
+}
+
+static void
+sja1110_acu_pin_cfg_mii_rx_packing(void *buf, struct sja1110_pin_cfg_mii_rx *cmd,
+				   enum packing_op op)
+{
+	const int size = 4;
+
+	sja1105_packing(buf, &cmd->d32_pupd,  25, 24, size, op);
+	sja1105_packing(buf, &cmd->d10_pupd,  17, 16, size, op);
+	sja1105_packing(buf, &cmd->ctrl_pupd,  9,  8, size, op);
+	sja1105_packing(buf, &cmd->clk_pol,    7,  7, size, op);
+	sja1105_packing(buf, &cmd->clk_src,    6,  5, size, op);
+	sja1105_packing(buf, &cmd->clk_ods,    4,  3, size, op);
+	sja1105_packing(buf, &cmd->clk_pupd,   1,  0, size, op);
+}
+
+static int sja1110_acu_rmii_ext_rx_clk_config(struct sja1105_private *priv,
+					      int port)
+{
+	const struct sja1105_regs *regs = priv->info->regs;
+	struct sja1110_pin_cfg_mii_rx pin_cfg_mii_rx = {0};
+	u8 packed_buf[SJA1105_SIZE_ACU_CMD] = {0};
+
+	if (regs->pad_mii_rx[port] == SJA1105_RSV_ADDR)
+		return 0;
+
+	/* Payload */
+	pin_cfg_mii_rx.d32_pupd  = 2; /* RXD[3:2] pull-up/-down: */
+				      /*   PLAIN Pull-up/-down disabled (default) */
+	pin_cfg_mii_rx.d10_pupd  = 2; /* RXD[1:0] pull-up/-down: */
+				      /*   PLAIN Pull-up/-down disabled (default) */
+	pin_cfg_mii_rx.ctrl_pupd = 2; /* RX_DV / RX_ER pull-up/-down: */
+				      /*   PLAIN Pull-up/-down disabled (default) */
+	pin_cfg_mii_rx.clk_pol   = 0; /* RX_CLK output polarity: */
+				      /*   NORMAL Not inverted (default) */
+	pin_cfg_mii_rx.clk_src   = 1; /* RX_CLK source: */
+				      /*   EXTERNAL Clock sourced from external*/
+	pin_cfg_mii_rx.clk_ods   = 2; /* RX_CLK output stage drive-strength: */
+				      /*   FAST Medium noise / Fast speed (default) */
+	pin_cfg_mii_rx.clk_pupd  = 2; /* RX_CLK pull-up/-down: */
+				      /*   PLAIN Pull-up/-down disabled (default) */
+	sja1110_acu_pin_cfg_mii_rx_packing(packed_buf, &pin_cfg_mii_rx, PACK);
+
+	return sja1105_xfer_buf(priv, SPI_WRITE, regs->pad_mii_rx[port],
+				packed_buf, SJA1105_SIZE_ACU_CMD);
+}
+
+static int sja1110_rmii_clocking_setup(struct sja1105_private *priv, int port,
+				       sja1105_mii_role_t role)
+{
+	struct device *dev = priv->ds->dev;
+	int rc;
+
+	dev_dbg(dev, "Configuring RMII-%s clocking\n",
+		(role == XMII_MAC) ? "MAC" : "PHY");
+	if (role == XMII_PHY) {
+		rc = sja1110_acu_rmii_ext_tx_clk_config(priv, port);
+		if (rc)
+			return rc;
+
+		rc = sja1110_acu_rmii_ext_rx_clk_config(priv, port);
+		if (rc)
+			return rc;
+	}
+
+	return 0;
+}
+
+int sja1110_clocking_setup_port(struct sja1105_private *priv, int port)
+{
+	struct sja1105_xmii_params_entry *mii;
+	struct device *dev = priv->ds->dev;
+	sja1105_phy_interface_t phy_mode;
+	sja1105_mii_role_t role;
+	int rc;
+
+	mii = priv->static_config.tables[BLK_IDX_XMII_PARAMS].entries;
+
+	/* RGMII etc */
+	phy_mode = mii->xmii_mode[port];
+	/* MAC or PHY, for applicable types (not RGMII) */
+	role = mii->phy_mac[port];
+
+	switch (phy_mode) {
+	case XMII_MODE_RMII:
+		rc = sja1110_rmii_clocking_setup(priv, port, role);
+		break;
+	case XMII_MODE_MII:
+	case XMII_MODE_RGMII:
+	case XMII_MODE_SGMII:
+		/* Nothing to do in the CGU/ACU for MII/RGMII/SGMII */
+		rc = 0;
+		break;
+	default:
+		dev_err(dev, "Invalid interface mode specified: %d\n",
+			phy_mode);
+		return -EINVAL;
+	}
+	if (rc) {
+		dev_err(dev, "Clocking setup for port %d failed: %d\n",
+			port, rc);
+	}
+
+	return rc;
+}
+
+int sja1110_clocking_setup(struct sja1105_private *priv)
+{
+	struct dsa_switch *ds = priv->ds;
+	int port, rc;
+
+	for (port = 0; port < ds->num_ports; port++) {
+		rc = sja1110_clocking_setup_port(priv, port);
+		if (rc < 0)
+			return rc;
+	}
+	return 0;
+}
+
 static void
 sja1110_cgu_outclk_packing(void *buf, struct sja1110_cgu_outclk *outclk,
 			   enum packing_op op)
diff --git a/drivers/net/dsa/sja1105/sja1105_spi.c b/drivers/net/dsa/sja1105/sja1105_spi.c
index 834b5c1b4db0c..fcc675a269edb 100644
--- a/drivers/net/dsa/sja1105/sja1105_spi.c
+++ b/drivers/net/dsa/sja1105/sja1105_spi.c
@@ -495,13 +495,13 @@ static const struct sja1105_regs sja1110_regs = {
 	 * configure in the CGU/ACU for them.
 	 */
 	.pad_mii_tx = {SJA1105_RSV_ADDR, SJA1105_RSV_ADDR,
-		       SJA1105_RSV_ADDR, SJA1105_RSV_ADDR,
+		       SJA1110_ACU_ADDR(0x10), SJA1110_ACU_ADDR(0x20),
 		       SJA1105_RSV_ADDR, SJA1105_RSV_ADDR,
 		       SJA1105_RSV_ADDR, SJA1105_RSV_ADDR,
 		       SJA1105_RSV_ADDR, SJA1105_RSV_ADDR,
 		       SJA1105_RSV_ADDR},
 	.pad_mii_rx = {SJA1105_RSV_ADDR, SJA1105_RSV_ADDR,
-		       SJA1105_RSV_ADDR, SJA1105_RSV_ADDR,
+		       SJA1110_ACU_ADDR(0x14), SJA1110_ACU_ADDR(0x24),
 		       SJA1105_RSV_ADDR, SJA1105_RSV_ADDR,
 		       SJA1105_RSV_ADDR, SJA1105_RSV_ADDR,
 		       SJA1105_RSV_ADDR, SJA1105_RSV_ADDR,
@@ -794,6 +794,7 @@ const struct sja1105_info sja1110a_info = {
 	.ptp_cmd_packing	= sja1105pqrs_ptp_cmd_packing,
 	.rxtstamp		= sja1110_rxtstamp,
 	.txtstamp		= sja1110_txtstamp,
+	.clocking_setup		= sja1110_clocking_setup,
 	.disable_microcontroller = sja1110_disable_microcontroller,
 	.pcs_mdio_read_c45	= sja1110_pcs_mdio_read_c45,
 	.pcs_mdio_write_c45	= sja1110_pcs_mdio_write_c45,
@@ -845,6 +846,7 @@ const struct sja1105_info sja1110b_info = {
 	.ptp_cmd_packing	= sja1105pqrs_ptp_cmd_packing,
 	.rxtstamp		= sja1110_rxtstamp,
 	.txtstamp		= sja1110_txtstamp,
+	.clocking_setup		= sja1110_clocking_setup,
 	.disable_microcontroller = sja1110_disable_microcontroller,
 	.pcs_mdio_read_c45	= sja1110_pcs_mdio_read_c45,
 	.pcs_mdio_write_c45	= sja1110_pcs_mdio_write_c45,
@@ -896,6 +898,7 @@ const struct sja1105_info sja1110c_info = {
 	.ptp_cmd_packing	= sja1105pqrs_ptp_cmd_packing,
 	.rxtstamp		= sja1110_rxtstamp,
 	.txtstamp		= sja1110_txtstamp,
+	.clocking_setup		= sja1110_clocking_setup,
 	.disable_microcontroller = sja1110_disable_microcontroller,
 	.pcs_mdio_read_c45	= sja1110_pcs_mdio_read_c45,
 	.pcs_mdio_write_c45	= sja1110_pcs_mdio_write_c45,
@@ -947,6 +950,7 @@ const struct sja1105_info sja1110d_info = {
 	.ptp_cmd_packing	= sja1105pqrs_ptp_cmd_packing,
 	.rxtstamp		= sja1110_rxtstamp,
 	.txtstamp		= sja1110_txtstamp,
+	.clocking_setup		= sja1110_clocking_setup,
 	.disable_microcontroller = sja1110_disable_microcontroller,
 	.pcs_mdio_read_c45	= sja1110_pcs_mdio_read_c45,
 	.pcs_mdio_write_c45	= sja1110_pcs_mdio_write_c45,
-- 
2.39.2


