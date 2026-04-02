Return-Path: <netdev+bounces-274522-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iBhlMUpizmmXnQYAu9opvQ
	(envelope-from <netdev+bounces-274522-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 14:34:18 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 415C43891A2
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 14:34:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D29EE30265A8
	for <lists+netdev@lfdr.de>; Thu,  2 Apr 2026 12:31:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81BE53E1218;
	Thu,  2 Apr 2026 12:31:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2132.outbound.protection.partner.outlook.cn [139.219.17.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F66033F8C5;
	Thu,  2 Apr 2026 12:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.132
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775133090; cv=fail; b=hJz4MCd5HmEJft3fM6aTjCEwGwIzYPlq+HoXtZgPOBM86qAuvkbMCFwruqT9PZcKpdiwp+m4X4jcesNf/qX/ax2Qcu2ZC2puxWHeVSogUb+h6xQvYoiGLbW1VYgpgD0WtdOUBUFT0bb7u9OtA39YUiU3IwDeBj6kSQdSsBJHgA4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775133090; c=relaxed/simple;
	bh=QMzxFXUi1J+nLfLxAcl39EkGDpLAhsUPAt0s/gfObLE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Lony6YoedIauYFFi4NJD+0rTZ+i0pKydO5OKyX0M/J/2tUJg3gNOxto2qJpobRhKfulsBTqvHMMNYopQlH0+zzfR4Y1TnAaACu960UYmW9csQiTQi9co7q5JZsEy5S3m688cRdqPojgVIj5rsLzMUqOVTahOezokMkPWbWQy+6A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B0/BSRMGhKn439SGPWLMf3RsYfQR55vpXSa6TUpTADwV8Dvh1b8I9w/J6Z9bCt/qnWCrD7xKdHc1v8WxiR1JR2D9qIK+zqN63WH5bsRFuURTHd3/4+jLjyol65d1KDF8IHYkxMIivd1u4T6WfFuLqTMaNIFCdR2QCAaFWTYiAo2T+V84L3NVB56Xbe1MqbHc3YrK63a5qO/yQdObgK7CyOG0WtH6td+afNbVjf3TTwiIA1WqfpX+QclMKXfR/i2FcOULRBgOsubsN1f9GTWHG57Hv/xkBMMhhtZFHK3WYBV5hvVcd5QeBqQr3xL86Nw3b1jFnb83P9XXcl3Kx6jUOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4HdYm0jM3htBiHXVScReuxV9bfVpzvNgKq4U92jFf4g=;
 b=kY1LEd1BYHPU34oRc3UcCJSdjJHWTUU6WrggOYHku0LNy9AR6LCccIbWKldBqCCF7sUWXjUt9mivwZ0ofMuDqBlUZp5ZU3Z9E8y3uSXhVaBx8iCa1MIaMB6rRx8rV6k1cc1gUtHnNi1ZKyqjMjERoL0bT5nZoZ8Z/QNP2977LeqkDol5ygD63RkwlPsi8neGCPDc0Eh3CSiDkEQ7YgCDic/I11O11jZc2cclqcwSNFe+EfOR/tBa5YILqYHYPEMOBSA/r9h5AkwfE8F+zRk3wK3s8DgSJvd6pfu87CUqdWtkeOdYCfkDD+i0ls51gVyGMBvGrg0Gx4vNNBtPpeTV/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ0PR01MB1208.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:19::5) by ZQ0PR01MB1096.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:c::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.20; Thu, 2 Apr
 2026 10:55:57 +0000
Received: from ZQ0PR01MB1208.CHNPR01.prod.partner.outlook.cn
 ([fe80::63d1:b688:cab7:50cb]) by
 ZQ0PR01MB1208.CHNPR01.prod.partner.outlook.cn ([fe80::63d1:b688:cab7:50cb%7])
 with mapi id 15.20.9769.017; Thu, 2 Apr 2026 10:55:57 +0000
From: Changhuang Liang <changhuang.liang@starfivetech.com>
To: Michael Turquette <mturquette@baylibre.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Stephen Boyd <sboyd@kernel.org>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Emil Renner Berthing <kernel@esmil.dk>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A . R . Silva" <gustavoars@kernel.org>,
	Richard Cochran <richardcochran@gmail.com>
Cc: linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-hardening@vger.kernel.org,
	netdev@vger.kernel.org,
	Sia Jee Heng <jeeheng.sia@starfivetech.com>,
	Hal Feng <hal.feng@starfivetech.com>,
	Ley Foon Tan <leyfoon.tan@starfivetech.com>,
	Changhuang Liang <changhuang.liang@starfivetech.com>
Subject: [PATCH v1 08/22] clk: starfive: Add JHB100 System-1 clock generator driver
Date: Thu,  2 Apr 2026 03:55:09 -0700
Message-Id: <20260402105523.447523-9-changhuang.liang@starfivetech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260402105523.447523-1-changhuang.liang@starfivetech.com>
References: <20260402105523.447523-1-changhuang.liang@starfivetech.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZQ0PR01CA0028.CHNPR01.prod.partner.outlook.cn (10.2.0.210)
 To ZQ0PR01MB1208.CHNPR01.prod.partner.outlook.cn (10.2.3.165)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZQ0PR01MB1208:EE_|ZQ0PR01MB1096:EE_
X-MS-Office365-Filtering-Correlation-Id: 81107047-b343-4131-909e-08de90a66b41
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|52116014|376014|366016|921020|38350700014|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	nqGEQHkEmVvgTgCAC5Ilxi/5mfrsb+uo+QJviFdkcEVCCqlAA1/h1QaN5RAK/ULqP5ZOoOn0kZksj+sSeJdxGtQw2R3g6nLc+jxZheWeRukbAMJTgX/wiZzAqh8kPQsOkNU/TTyBuf5nqCfssua+Vqw0XcxR7pAPeU81J6UEbi7cv03N7oXGD6eu382epgfyGPaE/XUBJiwNXnnVyVUYHJ2ZNfub2ZxX/f+XzjA/k5JOBTYFwdHLUeG7YuPDR/yOv/8p/STUHE6QNjR35HrOsoYn7l304l4G4YBIhY1SiL2EfWVNUYs6lB/AgkIAkH1ktGSA2jP4rqTAxm9BU/fMStl59Ud6eO5lRQJ3+FKeolYugLgQyZJKU6nndEi3QomdIMbVXVKPpvkswl6qcwXaACWwVP3vQgBmcv7ndYeIbmMxLjXsbJHOmPW/P2WCUZXECuQjOcgqj0n2vuFyQZ6IJvK5Lo8ESawd7fyHUT4JP1KlfYijBcStHM9y0/ZeBZf9zAnF2Jq1QcnnIzq8/Z2/Kv3M+usNlOIBmPPf+xP14rLEShqfjcEQURKvwDVCOPbB8Bvsf5rVUWh+Y5cJliZILWIu4/y7c9tX3RBfsNu3H8o=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ0PR01MB1208.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(52116014)(376014)(366016)(921020)(38350700014)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?MqIvz6qGqmQWDBoc1aqZqxw193gG4hDpiFUmfaZZ3dEuVpHcPbgozDPnfzCo?=
 =?us-ascii?Q?xovfHBtNDZYcuH5ZTfeHusy+tkC8Ewk2/mC83sjnLRkYoz/VnNJSoifVJxv3?=
 =?us-ascii?Q?NBBgzCcJR+9x/ANjXPvhloIIXUtFrhCV9KQk7D7D0x/IVMgiTZJGzxX3sCXz?=
 =?us-ascii?Q?4MBhmJgaiS0yrFhzBqew1f5vAMY+Phx3uicM3UYyuFEIBLm08dQdV4wfX8kO?=
 =?us-ascii?Q?A2y+iYN0Tt4BwdQ+e71Ynmo7dTb6Y0xJbtlRRif2358zCf3ZdsUFDXUiqDUx?=
 =?us-ascii?Q?FYVEvs5zJU6357K/o90Ab3zjrKcGOmoYILvltFw4kpzX45jxEOzAXnXD8f+T?=
 =?us-ascii?Q?l+EOQLEMYWMEqQW2E4//M8qV5mRO020lIMHqxDqYWCmQnTH1JSHipeZNJrpY?=
 =?us-ascii?Q?xxXloiSqfUnQQM/v8A3Vga4je2zZF4By2lf/05IOK7txKZDVAihkrF67O6gn?=
 =?us-ascii?Q?SOP/d81iuYeV8SuQMIrgxEWQ60jOGuqpOSfwN5DCC9JP8GU3mI1u7S1w9eVX?=
 =?us-ascii?Q?qFkeUaZoAatBjtkwyvOh8YUXbK+D81M8ozenilJy2ZOmeZiG2T1icNYRut2y?=
 =?us-ascii?Q?9VcV4WIxqBjtmAfTakUEuApn3/QflPvz4tIUnKNwIHuvN8DF+3EwT5GtlCf0?=
 =?us-ascii?Q?A5Lojlpsbaad9s9gVAHT3LVsJ5/fPLw3HpI3PXBKmmArL+SOs9g5v0MAYhTq?=
 =?us-ascii?Q?rNZqiQ5n0bbTk8A90mi9GKGqsqeBt+b6HBaf36ZV5kZO+fehQn44pIeN5Upx?=
 =?us-ascii?Q?nn7l6nzlXpZ1o+xMUYeZnSgYf3RPHrZUwSGe7lgXqqJUCjDW0BGvOd6QEJFq?=
 =?us-ascii?Q?ivjjPVc4ED2DOK+Pd97EU/qVAGyrOpCrQw5A9Wt0dRyfVVJTtvCc281XCxWd?=
 =?us-ascii?Q?GMTXirwvvOcurvK/D1EIDEpBHasJV+dVeVUIygrOsOATmntESo5O97aEcxF9?=
 =?us-ascii?Q?mKDp297LeulmkULyVdE+bAJcpdoedenlKrh4xE4lHKrREuwqWbt6c8F/XSSQ?=
 =?us-ascii?Q?m9geud9Bwt0IM2Ayzz+VnQoPqSpNR0uzmrR8/GzTQfLM+wJDgbbEtbSyhhxi?=
 =?us-ascii?Q?ZzuxbJvtstEI1/D/9ilcHrNlOm+PYow7sUkvgr9FMR+8a16nq0v9dnPIWzu4?=
 =?us-ascii?Q?maw4PNAQcXfTwZ7StkJvPoOA8EG+79L63aC77psFDMHsArvyJ63fDAdJMzxb?=
 =?us-ascii?Q?QMpXflLh9Fl7SZDlSojbtuurxotWFrZOQhJX/yT49aI4P8q5JbkGmSA77Bb3?=
 =?us-ascii?Q?DRSTHJaW5hlIqzrhQpqHPhLW1mNGKWhs9/jjSyXFtkVbeHl9R+Gi2q2u95gx?=
 =?us-ascii?Q?IkfIGUrlsAeCBNsX3lF/27ibr3FNgccylqOEiZnsmN6r7M1ihwGwIuf97w2Z?=
 =?us-ascii?Q?MbSZfNK+LGwC3WIOJyzW1KPfAOaLL/PP+NoWGbtKAYHdzD8pEs8ByptHk1HN?=
 =?us-ascii?Q?1zfyYBFRnSK8HF6018OWKF3fyHCnYte3yjyho2U0lIDqCInOmfiKpEb65PpV?=
 =?us-ascii?Q?/ldiybpPzO883R3ETMXUn0kvIsduR7XMP+ihknatXFYz54q3ZhlYEu4HRjl9?=
 =?us-ascii?Q?5qebi7HLNvQTpAJC4eReeVuELxRhfcVrSQMIOTN2UU2m2oZTL2QIFfjxuWt6?=
 =?us-ascii?Q?108fHA46XsTL2Dri1rC2vv4lrD5NGzu8hQFQYzZwddQkbxA42iq2/TgsgOPo?=
 =?us-ascii?Q?yAvPMgdI9Q7FbpL/tTQzvUpICfqG/NuEaFQO2wles+knG3OdRWLY/tIm4o8G?=
 =?us-ascii?Q?JV4NMebAIP3qSA9+Z4gzWXirGOL0PkWjmg9jQr+MPvMObhsqupWB?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81107047-b343-4131-909e-08de90a66b41
X-MS-Exchange-CrossTenant-AuthSource: ZQ0PR01MB1208.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2026 10:55:57.3261
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GeIFgOOvh9b8gN6FrIqp/vHO2ZYZ9RB4yYjPikDqBpddoe6vslQIYpn8+K8lyc59d9nR9Ty0HB8tJILvayYRiJ29DIXfXYy8sXuz6cd+fFKZApYR5uX3x7qX0Z2uGtcq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ0PR01MB1096
X-Spamd-Result: default: False [5.04 / 15.00];
	DMARC_POLICY_QUARANTINE(1.50)[starfivetech.com : SPF not aligned (relaxed), No valid DKIM,quarantine];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[baylibre.com,kernel.org,dabbelt.com,eecs.berkeley.edu,ghiti.fr,pengutronix.de,esmil.dk,gmail.com];
	GREYLIST(0.00)[pass,meta];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-274522-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[24];
	FROM_NEQ_ENVFROM(0.00)[changhuang.liang@starfivetech.com,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.911];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,starfivetech.com:email,starfivetech.com:mid]
X-Rspamd-Queue-Id: 415C43891A2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add support for JHB100 System-1 clock generator (SYS1CRG).

Signed-off-by: Changhuang Liang <changhuang.liang@starfivetech.com>
---
 drivers/clk/starfive/Kconfig                  |   8 +
 drivers/clk/starfive/Makefile                 |   1 +
 .../clk/starfive/clk-starfive-jhb100-sys1.c   | 157 ++++++++++++++++++
 3 files changed, 166 insertions(+)
 create mode 100644 drivers/clk/starfive/clk-starfive-jhb100-sys1.c

diff --git a/drivers/clk/starfive/Kconfig b/drivers/clk/starfive/Kconfig
index 7926e02ccd7d..b6042bcb5992 100644
--- a/drivers/clk/starfive/Kconfig
+++ b/drivers/clk/starfive/Kconfig
@@ -83,3 +83,11 @@ config CLK_STARFIVE_JHB100_SYS0
 	help
 	  Say yes here to support the system-0 clock controller on the
 	  StarFive JHB100 SoC.
+
+config CLK_STARFIVE_JHB100_SYS1
+	bool "StarFive JHB100 system-1 clock support"
+	depends on CLK_STARFIVE_JHB100_SYS0
+	default ARCH_STARFIVE
+	help
+	  Say yes here to support the system-1 clock controller on the
+	  StarFive JHB100 SoC.
diff --git a/drivers/clk/starfive/Makefile b/drivers/clk/starfive/Makefile
index 2c5e66d1d44e..b3571e2f0555 100644
--- a/drivers/clk/starfive/Makefile
+++ b/drivers/clk/starfive/Makefile
@@ -12,3 +12,4 @@ obj-$(CONFIG_CLK_STARFIVE_JH7110_ISP)	+= clk-starfive-jh7110-isp.o
 obj-$(CONFIG_CLK_STARFIVE_JH7110_VOUT)	+= clk-starfive-jh7110-vout.o
 
 obj-$(CONFIG_CLK_STARFIVE_JHB100_SYS0)		+= clk-starfive-jhb100-sys0.o
+obj-$(CONFIG_CLK_STARFIVE_JHB100_SYS1)		+= clk-starfive-jhb100-sys1.o
diff --git a/drivers/clk/starfive/clk-starfive-jhb100-sys1.c b/drivers/clk/starfive/clk-starfive-jhb100-sys1.c
new file mode 100644
index 000000000000..e98b8bc72960
--- /dev/null
+++ b/drivers/clk/starfive/clk-starfive-jhb100-sys1.c
@@ -0,0 +1,157 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * StarFive JHB100 System-1 Clock Driver
+ *
+ * Copyright (C) 2024 StarFive Technology Co., Ltd.
+ *
+ * Author: Changhuang Liang <changhuang.liang@starfivetech.com>
+ *
+ */
+
+#include <dt-bindings/clock/starfive,jhb100-crg.h>
+#include <linux/clk-provider.h>
+#include <linux/init.h>
+#include <linux/io.h>
+#include <linux/platform_device.h>
+
+#include "clk-starfive-jhb100.h"
+
+#define JHB100_SYS1CLK_NUM_CLKS			(JHB100_SYS1CLK_BMCPER3_125 + 1)
+
+/* external clocks */
+#define JHB100_SYS1CLK_OSC			(JHB100_SYS1CLK_NUM_CLKS + 0)
+#define JHB100_SYS1CLK_PLL0			(JHB100_SYS1CLK_NUM_CLKS + 1)
+#define JHB100_SYS1CLK_PLL1			(JHB100_SYS1CLK_NUM_CLKS + 2)
+#define JHB100_SYS1CLK_PLL2			(JHB100_SYS1CLK_NUM_CLKS + 3)
+#define JHB100_SYS1CLK_PLL4			(JHB100_SYS1CLK_NUM_CLKS + 4)
+#define JHB100_SYS1CLK_PLL5			(JHB100_SYS1CLK_NUM_CLKS + 5)
+#define JHB100_SYS1CLK_NPU_600			(JHB100_SYS1CLK_NUM_CLKS + 6)
+
+static const struct starfive_clk_data jhb100_sys1crg_clk_data[] __initconst = {
+	/* root */
+	STARFIVE__DIV(JHB100_SYS1CLK_APB_MAIN_SYS1, "apb_main_sys1", 12,
+		      JHB100_SYS1CLK_PLL1),
+	/* sensor */
+	STARFIVE_GATE(JHB100_SYS1CLK_APB_SENSOR_ICG_BUF, "apb_sensor_icg_buf",
+		      CLK_IS_CRITICAL, JHB100_SYS1CLK_APB_MAIN_SYS1),
+	/* hostss1 */
+	STARFIVE__DIV(JHB100_SYS1CLK_GPIO_ESPI1_66, "gpio_espi1_66", 14,
+		      JHB100_SYS1CLK_PLL2),
+	STARFIVE__DIV(JHB100_SYS1CLK_HOSTSS1_100, "hostss1_100", 12,
+		      JHB100_SYS1CLK_PLL1),
+	STARFIVE_GATE(JHB100_SYS1CLK_HOSTSS1_PHY_SCAN_1000_ICG_BUF,
+		      "hostss1_phy_scan_1000_icg_buf", CLK_IS_CRITICAL,
+		      JHB100_SYS1CLK_PLL1),
+	/* vout */
+	STARFIVE__DIV(JHB100_SYS1CLK_VOUT_100, "vout_100", 12,
+		      JHB100_SYS1CLK_PLL1),
+	STARFIVE__DIV(JHB100_SYS1CLK_VOUT_PIX0, "vout_pix0", 4,
+		      JHB100_SYS1CLK_PLL4),
+	STARFIVE__DIV(JHB100_SYS1CLK_VOUT_PIX1, "vout_pix1", 4,
+		      JHB100_SYS1CLK_PLL5),
+	/* bmcperiph3 */
+	STARFIVE__DIV(JHB100_SYS1CLK_BMCPER3_100, "bmcper3_100", 12,
+		      JHB100_SYS1CLK_PLL1),
+	STARFIVE__DIV(JHB100_SYS1CLK_BMCPER3_125, "bmcper3_125", 10,
+		      JHB100_SYS1CLK_PLL1),
+	/* npu */
+	STARFIVE__DIV(JHB100_SYS1CLK_NPU_200, "npu_200", 6,
+		      JHB100_SYS1CLK_PLL1),
+	STARFIVE__DIV(JHB100_SYS1CLK_NPU_CORE_DIV, "npu_core_div", 10,
+		      JHB100_SYS1CLK_PLL0),
+	STARFIVE_GATE(JHB100_SYS1CLK_DOM_NPU_CORE_CLK, "dom_npu_core_clk",
+		      CLK_IS_CRITICAL, JHB100_SYS1CLK_NPU_CORE_DIV),
+	STARFIVE_GATE(JHB100_SYS1CLK_DOM_NPU_BUS_CLK, "dom_npu_bus_clk",
+		      CLK_IS_CRITICAL, JHB100_SYS1CLK_NPU_600),
+	STARFIVE_GATE(JHB100_SYS1CLK_DOM_NPU_INIT_CLK, "dom_npu_init_clk",
+		      CLK_IS_CRITICAL, JHB100_SYS1CLK_NPU_200),
+	STARFIVE_GATE(JHB100_SYS1CLK_DOM_NPU_OSC_CLK, "dom_npu_osc_clk",
+		      CLK_IS_CRITICAL, JHB100_SYS1CLK_OSC),
+};
+
+static int __init jhb100_sys1crg_probe(struct platform_device *pdev)
+{
+	struct starfive_clk_priv *priv;
+	unsigned int idx;
+	int ret;
+
+	priv = devm_kzalloc(&pdev->dev,
+			    struct_size(priv, reg, JHB100_SYS1CLK_NUM_CLKS),
+			    GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	spin_lock_init(&priv->rmw_lock);
+	priv->num_reg = JHB100_SYS1CLK_NUM_CLKS;
+	priv->dev = &pdev->dev;
+	priv->base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(priv->base))
+		return PTR_ERR(priv->base);
+
+	for (idx = 0; idx < JHB100_SYS1CLK_NUM_CLKS; idx++) {
+		u32 max = jhb100_sys1crg_clk_data[idx].max;
+		struct clk_parent_data parents[4] = {};
+		struct clk_init_data init = {
+			.name = jhb100_sys1crg_clk_data[idx].name,
+			.ops = starfive_clk_ops(max),
+			.parent_data = parents,
+			.num_parents =
+				((max & STARFIVE_CLK_MUX_MASK) >> STARFIVE_CLK_MUX_SHIFT) + 1,
+			.flags = jhb100_sys1crg_clk_data[idx].flags,
+		};
+		struct starfive_clk *clk = &priv->reg[idx];
+		unsigned int i;
+
+		if (!init.name)
+			continue;
+
+		for (i = 0; i < init.num_parents; i++) {
+			unsigned int pidx = jhb100_sys1crg_clk_data[idx].parents[i];
+
+			if (pidx < JHB100_SYS1CLK_NUM_CLKS)
+				parents[i].hw = &priv->reg[pidx].hw;
+			else if (pidx == JHB100_SYS1CLK_OSC)
+				parents[i].fw_name = "osc";
+			else if (pidx == JHB100_SYS1CLK_PLL0)
+				parents[i].fw_name = "pll0";
+			else if (pidx == JHB100_SYS1CLK_PLL1)
+				parents[i].fw_name = "pll1";
+			else if (pidx == JHB100_SYS1CLK_PLL2)
+				parents[i].fw_name = "pll2";
+			else if (pidx == JHB100_SYS1CLK_PLL4)
+				parents[i].fw_name = "pll4";
+			else if (pidx == JHB100_SYS1CLK_PLL5)
+				parents[i].fw_name = "pll5";
+			else
+				parents[i].fw_name = "sys1_npu_600";
+		}
+
+		clk->hw.init = &init;
+		clk->idx = idx;
+		clk->max_div = max & STARFIVE_CLK_DIV_MASK;
+
+		ret = devm_clk_hw_register(&pdev->dev, &clk->hw);
+		if (ret)
+			return ret;
+	}
+
+	ret = devm_of_clk_add_hw_provider(&pdev->dev, starfive_clk_get, priv);
+	if (ret)
+		return ret;
+
+	return jhb100_reset_controller_register(priv, "r-sys1", 0);
+}
+
+static const struct of_device_id jhb100_sys1crg_match[] = {
+	{ .compatible = "starfive,jhb100-sys1crg" },
+	{ /* sentinel */ }
+};
+
+static struct platform_driver jhb100_sys1crg_driver = {
+	.driver = {
+		.name = "clk-starfive-jhb100-sys1",
+		.of_match_table = jhb100_sys1crg_match,
+		.suppress_bind_attrs = true,
+	},
+};
+builtin_platform_driver_probe(jhb100_sys1crg_driver, jhb100_sys1crg_probe);
-- 
2.25.1


