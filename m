Return-Path: <netdev+bounces-274476-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sKOuG8pQzmmjmgYAu9opvQ
	(envelope-from <netdev+bounces-274476-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 13:19:38 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E1BE438838F
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 13:19:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8765F3069D4F
	for <lists+netdev@lfdr.de>; Thu,  2 Apr 2026 11:12:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 415F23BD637;
	Thu,  2 Apr 2026 11:12:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2136.outbound.protection.partner.outlook.cn [139.219.17.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FE703845CA;
	Thu,  2 Apr 2026 11:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.136
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775128330; cv=fail; b=IlZo3Q21ybyQu+ayXSiJ0pkXIZCv4LlHGtCpiPc3P4/3rrkKLgyhhODLEYO+fOJIXc2wHff2akomptu7KuZZbOjRErKSiOh43ck9oKRajIDsARsryqJGLj5khGH/UNZcMIS16PD7bYDZqjVXmY5fTrjIwk0DInx7bBR5u0mLlBs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775128330; c=relaxed/simple;
	bh=yJFRtHwq+K6V9al0YS+EvPl54XjJ3BCIb85pNITtS/U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BWJK2nVKj05j2MrH3pEtBzzYN5jIcf20liyBL5FpLn+8n/eWdsRVE5C7jatKraXFmJbIv1EhWKj7cnX3BgcsgrC92DEh8EZWMx+kMn0mRxsoRKxx7G0ONSZ1k/K5QStikWfY7q//X9vP34AF/nXATTv6tVtVnoQVv23wj33feCY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kWyWDnhE4hqZAiqkXKCumZ51wa+P3+cMtP7aV3Rcje7Wo/isIGwRgfMNgo1LBO7zjvEkmfkeJfKk2hcVhFWbMbuV4Cl8hx6eDFoRROePu34lrPjdafpFycuhxc1ztqZnyVY4By8AAGsibk4dEd6Jpq1bpomurNDKOL5YL1m1mqGmbyXIhDRe8aZFHLCcV5q/85hEtFYpyiVjLhhVdlYkNCUdWLAI8cqCTmtXT+9pPsOpr9GDxlV9NhtitSpKVryNeFFjiWcIeztx5Y/XYbHR3ZAUYmvEA1+ZAdhkffJfRssRoniPRho59DEloAlf1gu+B9UB8AwHMVLVxXwhbPaXiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nhb2ToBYdZVOk7ykp1VY+d8mhrwEsnaANJvd16wVlCY=;
 b=AedkC1m2sjv7VUBZV27kcgqZrX9n/FZRiKKMeVKBVCDSSL6ck89ACyYLAmg1tQiil94jBflNszj4IzfK+0iduDBVvwnBE4aMHEDrV+N0sWAHIVtZ2YFijaksim/c1gQ1zHr7NKVIT/5V5l7VESUjvw3FMAL/Mnj1tic6hvzicdfTFcI5zo8/S/qw99RDHJtIPFc5nZMrJ7IFWAyv/V82bJLOy5HIpx0xXk3l11TIdKAOfNaHXlmkwnBaPw9SC2xndB7RZIxCjkPTvB8ytIR0gynTv1BodplW4PpB1I+hsy/P7/U/cEcb+E/DUqz1IiV4fwTgYT3DXCeuNixu08UvVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ0PR01MB1208.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:19::5) by ZQ0PR01MB1048.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:d::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.20; Thu, 2 Apr
 2026 10:56:04 +0000
Received: from ZQ0PR01MB1208.CHNPR01.prod.partner.outlook.cn
 ([fe80::63d1:b688:cab7:50cb]) by
 ZQ0PR01MB1208.CHNPR01.prod.partner.outlook.cn ([fe80::63d1:b688:cab7:50cb%7])
 with mapi id 15.20.9769.017; Thu, 2 Apr 2026 10:56:04 +0000
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
Subject: [PATCH v1 10/22] clk: starfive: Add JHB100 System-2 clock generator driver
Date: Thu,  2 Apr 2026 03:55:11 -0700
Message-Id: <20260402105523.447523-11-changhuang.liang@starfivetech.com>
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
X-MS-TrafficTypeDiagnostic: ZQ0PR01MB1208:EE_|ZQ0PR01MB1048:EE_
X-MS-Office365-Filtering-Correlation-Id: 11daab28-cc04-476c-22dc-08de90a66e82
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|52116014|376014|366016|921020|38350700014|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	AOGgY3Fbd/FrarifsJ/mzyf105roHZmREF3H+/o0tCgAohdhjBWBEuSjpwV7lugi3ntr0ygMTEaLMy8UU98BKTFnoWctX7R8n93c6Mo5e9+XCBuwaOp5PXuOEih0NV2K7N6eOBf4l0m/Ly6C0/oM9XGfww3EzRGw+oz/4XWoqJRnQwzJdFSWz/J5/6bjnIR34NKZFGPtYd3WbJ5Gljm9jzri0UB5qBKCV5Kk9IJ5Z5RJawrI+iALWeP9DStGCVcangQJdqAVMycBMxuS+Js4TEfSwJl+XNzI7iWM6jvrsTYUxrSrYzrL5taNOQ8I0nP2cE7BjnjXkAo6dqp5Ypt7u+e8bQ+ka+Oz4wgoeLD96ID34XNGjr8c0jl1l3I9294hihS4ufl9hjSfxWx02pSAwSxBd83GMHgAsFVcXrr/AZVLQ6Fq6VLci2pldb9Pz0I9WUR3esOLtaMogP3N5dhX1PH9PPXDFwSIPizy+SfBpCv9FuV8mvdek4I5rvKyvYANHSAn20UO8K3iLru4fqPjmBbTMhT3+yAR5cDpS6IOHbaJMtlb3v7WgiO7czdESOeXhEuBqgQwDmzez5DfPkvNIYJzg3rryu3SpKLcGItZAYw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ0PR01MB1208.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(52116014)(376014)(366016)(921020)(38350700014)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5gmfWsjXcYJMVdD5Dsb62bq5fvfOQxYqeyVPX32MogsPVb+fVtfPCAaW2Fyw?=
 =?us-ascii?Q?zvC0FWgfdfLw5b0S/p3lKFOC+X5SyRAscJALcZtUeRUs402dOwwq9mzCrVf+?=
 =?us-ascii?Q?9ZNpYbi1NGXNgP5lwGUFAQYDHpLHkhPwGx3eRQR5e1GbUWqjtow+XYmYv+8M?=
 =?us-ascii?Q?K9QxMCdBDDU8ycXfVbpwMuN3JrvKm2HuV5GpAnPd3a+EnJxn6ztkvvjYHo78?=
 =?us-ascii?Q?LyY/K7gYo8d8YwJR3tc3+e2BQjtpJLXaa3lrT5k1MBQIdsqFXnf4AMkuocfE?=
 =?us-ascii?Q?+XeyQYgFe5uvNfszXpoYH9pXtVtmKzHXRCIQegxsOlotMTpQ1jGYJ08U5HjA?=
 =?us-ascii?Q?6ZRSQLmZn8JbmQ2X8Khcnz3KRu/E3Y+n9PhO1+A8fHiUZKiqYCG0/a/wFqyx?=
 =?us-ascii?Q?JazJX8Bt3E6TjnIJgS9ZOQxI6+R73EXqY9j0SlbPO+lGXvaxbvMSbTPtqe2S?=
 =?us-ascii?Q?076F3rIYtuuh9Fj/VYoIfBbsx0apMLIY82f5X7qyD2otcZrQYws9uHfDgl3O?=
 =?us-ascii?Q?8eHN9D1y8c2mVhnBAKlf9EQWC0gRc6C7I00RnlJq2ijT1q/2lyXVSRpkkciX?=
 =?us-ascii?Q?j1XSs7rTSFgA72eAhThB4HM4yezNtz7WtCjzgMXnVhjm9unQN+YpaoaSdFr/?=
 =?us-ascii?Q?ca1MVgC8x1kDcLD7yKj9+eova22bGvpB1BVhY+nME2unrNMFIXYUKZK68bBY?=
 =?us-ascii?Q?9pXX0/hpb4M6xl/acX7zt/FG7/9qr5xJSZbLgrpjyBYBzbeJfXZBp0grUMqz?=
 =?us-ascii?Q?Ylg9qotfUni2ieNLX8sy433tRXxckVMDxXrxXoRWjJpHoU3JBWVfRxfRHAOD?=
 =?us-ascii?Q?vVrPYYAP7UeS1jedke6AqXnRgOdpX+S0AVEBWm6z5KLhizrcUh+vwaRCxlXS?=
 =?us-ascii?Q?VcNRv+M49rVjwv9+UGJk0he7DF+clnqvlRaaDgFRv3+VYCaLKvB9YbL8APoy?=
 =?us-ascii?Q?x2/bNQCtqpDISgkHTpCzUHc2B8mKOHBJPTh/VjTi1/hjRxq+8enTiIpkTllZ?=
 =?us-ascii?Q?u/T5bOxZFtz96clzvxsboK6gu+tmBf/42Q/sNikuPGSfSffjbZDqprTvOJQg?=
 =?us-ascii?Q?gyetKjkMhWO+AoaHmgE6KcbjETRryk3PApYxATtan1QCxfm83Ul6XMOThYma?=
 =?us-ascii?Q?PBQZMRN+jaCyYkxzLYE2yhuv2QYf+KQ5JTptS9h41STPCamWSzVDWgRX7OyF?=
 =?us-ascii?Q?GJmUs4fPlQbDlALovxO8z/vblektui+6MaRhLncqtE6rzITDmaeM3A2z+3RR?=
 =?us-ascii?Q?KXkA7fZsY3BglZG7oNbcyNqzm5Ki0KqZ5IAlyjF7iNESqoZTAZmV8iQLRy5e?=
 =?us-ascii?Q?cv54rtBUw5T3iHjKZJbEk7Og2WLPembrOKmmQ78zKe0fXvyFfQwYRFkeVgM2?=
 =?us-ascii?Q?6J5SDGYgcrVFlVdJ7vOfx3k3Jx6CMcOyzj2bUMs0KYsxJ519NdIjsVCP7uIY?=
 =?us-ascii?Q?GPyOA0camfM1kpPe3MLmA4Ax5UYoLBKEFpi5oabE/h8mB4FES6ua5G0zvPix?=
 =?us-ascii?Q?z1zqNqHSXMte8EXCKJVoae0UrxZvtqyh5B9LFeu0Jq3jqcVq/kskgIm8AV9V?=
 =?us-ascii?Q?2QnfN1FLPfgkEaHM0LQhklGcN2vApekcSS7Npqc1utWav8BazG8QE7KBgNDd?=
 =?us-ascii?Q?JNu6LLB9FByZnbHrXFEbHk3mXkmiqv4pjYuTufAKLzU+Tzg5+WtI1vaSv9mU?=
 =?us-ascii?Q?aHhOLBUTWpybWS+3EY5GquH28prg/pLDJti9v+NRNEjd0a4oAYR2/l00Yw6A?=
 =?us-ascii?Q?UpqoWq7QlvWZy6hPZKnebUakbFteRXuMPp9vOdB6Xf1IRLJC0zQ9?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11daab28-cc04-476c-22dc-08de90a66e82
X-MS-Exchange-CrossTenant-AuthSource: ZQ0PR01MB1208.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2026 10:56:04.3664
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: alk6HCva5Yfays9DjGvvCef1ewTs1wXooMLMCoaR7QTc3l4rEtmfZlH6OpbTYsz4E6BJyKMIVEPeFULY13kezvaCenXKzbdtpzbp2UKDCPKqHgxBygCVCrOZaxf4U8V3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ0PR01MB1048
X-Spamd-Result: default: False [5.04 / 15.00];
	DMARC_POLICY_QUARANTINE(1.50)[starfivetech.com : SPF not aligned (relaxed), No valid DKIM,quarantine];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-274476-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[baylibre.com,kernel.org,dabbelt.com,eecs.berkeley.edu,ghiti.fr,pengutronix.de,esmil.dk,gmail.com];
	GREYLIST(0.00)[pass,body];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.912];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev,dt];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[changhuang.liang@starfivetech.com,netdev@vger.kernel.org]
X-Rspamd-Queue-Id: E1BE438838F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add support for JHB100 System-2 clock generator (SYS2CRG).

Signed-off-by: Changhuang Liang <changhuang.liang@starfivetech.com>
---
 drivers/clk/starfive/Kconfig                  |   8 +
 drivers/clk/starfive/Makefile                 |   1 +
 .../clk/starfive/clk-starfive-jhb100-sys2.c   | 178 ++++++++++++++++++
 3 files changed, 187 insertions(+)
 create mode 100644 drivers/clk/starfive/clk-starfive-jhb100-sys2.c

diff --git a/drivers/clk/starfive/Kconfig b/drivers/clk/starfive/Kconfig
index b6042bcb5992..729bdfce7b8a 100644
--- a/drivers/clk/starfive/Kconfig
+++ b/drivers/clk/starfive/Kconfig
@@ -91,3 +91,11 @@ config CLK_STARFIVE_JHB100_SYS1
 	help
 	  Say yes here to support the system-1 clock controller on the
 	  StarFive JHB100 SoC.
+
+config CLK_STARFIVE_JHB100_SYS2
+	bool "StarFive JHB100 system-2 clock support"
+	depends on CLK_STARFIVE_JHB100_SYS0
+	default ARCH_STARFIVE
+	help
+	  Say yes here to support the system-2 clock controller on the
+	  StarFive JHB100 SoC.
diff --git a/drivers/clk/starfive/Makefile b/drivers/clk/starfive/Makefile
index b3571e2f0555..90b6390296bd 100644
--- a/drivers/clk/starfive/Makefile
+++ b/drivers/clk/starfive/Makefile
@@ -13,3 +13,4 @@ obj-$(CONFIG_CLK_STARFIVE_JH7110_VOUT)	+= clk-starfive-jh7110-vout.o
 
 obj-$(CONFIG_CLK_STARFIVE_JHB100_SYS0)		+= clk-starfive-jhb100-sys0.o
 obj-$(CONFIG_CLK_STARFIVE_JHB100_SYS1)		+= clk-starfive-jhb100-sys1.o
+obj-$(CONFIG_CLK_STARFIVE_JHB100_SYS2)		+= clk-starfive-jhb100-sys2.o
diff --git a/drivers/clk/starfive/clk-starfive-jhb100-sys2.c b/drivers/clk/starfive/clk-starfive-jhb100-sys2.c
new file mode 100644
index 000000000000..5111f139a1c3
--- /dev/null
+++ b/drivers/clk/starfive/clk-starfive-jhb100-sys2.c
@@ -0,0 +1,178 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * StarFive JHB100 System-2 Clock Driver
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
+#define JHB100_SYS2CLK_NUM_CLKS			(JHB100_SYS2CLK_MAIN_ICG_EN_JTAG1 + 1)
+
+/* external clocks */
+#define JHB100_SYS2CLK_OSC			(JHB100_SYS2CLK_NUM_CLKS + 0)
+#define JHB100_SYS2CLK_PLL1			(JHB100_SYS2CLK_NUM_CLKS + 1)
+#define JHB100_SYS2CLK_GPU0_600			(JHB100_SYS2CLK_NUM_CLKS + 2)
+#define JHB100_SYS2CLK_GPU1_600			(JHB100_SYS2CLK_NUM_CLKS + 3)
+
+static const struct starfive_clk_data jhb100_sys2crg_clk_data[] __initconst = {
+	/* jtag mst*/
+	STARFIVE__DIV(JHB100_SYS2CLK_JTAGM0_200, "jtagm0_200", 6,
+		      JHB100_SYS2CLK_PLL1),
+	STARFIVE__DIV(JHB100_SYS2CLK_JTAGM1_200, "jtagm1_200", 6,
+		      JHB100_SYS2CLK_PLL1),
+	STARFIVE__DIV(JHB100_SYS2CLK_JTAGM0_100, "jtagm0_100", 12,
+		      JHB100_SYS2CLK_PLL1),
+	STARFIVE__DIV(JHB100_SYS2CLK_JTAGM1_100, "jtagm1_100", 12,
+		      JHB100_SYS2CLK_PLL1),
+	STARFIVE__DIV(JHB100_SYS2CLK_JTAGM0_ATPG_TCLOCK, "jtagm0_atpg_tclock", 2,
+		      JHB100_SYS2CLK_JTAGM0_100),
+	STARFIVE__DIV(JHB100_SYS2CLK_JTAGM1_ATPG_TCLOCK, "jtagm1_atpg_tclock", 2,
+		      JHB100_SYS2CLK_JTAGM1_100),
+	STARFIVE_GATE(JHB100_SYS2CLK_JTAG0_MST_WRAP_HCLK, "jtag0_mst_wrap_hclk",
+		      CLK_IGNORE_UNUSED, JHB100_SYS2CLK_JTAGM0_200),
+	STARFIVE_GATE(JHB100_SYS2CLK_JTAG0_MST_WRAP_CLK_JTAG, "jtag0_mst_wrap_clk_jtag",
+		      CLK_IGNORE_UNUSED, JHB100_SYS2CLK_JTAGM0_200),
+	STARFIVE_GATE(JHB100_SYS2CLK_JTAG0_MST_WRAP_APB_PCLK, "jtag0_mst_wrap_apb_pclk",
+		      CLK_IGNORE_UNUSED, JHB100_SYS2CLK_JTAGM0_100),
+	STARFIVE_GATE(JHB100_SYS2CLK_JTAG0_MST_WRAP_ATPG_TCLOCK, "jtag0_mst_wrap_atpg_tclock",
+		      CLK_IGNORE_UNUSED, JHB100_SYS2CLK_JTAGM0_100),
+	STARFIVE_GATE(JHB100_SYS2CLK_JTAG1_MST_WRAP_HCLK, "jtag1_mst_wrap_hclk",
+		      CLK_IGNORE_UNUSED, JHB100_SYS2CLK_JTAGM1_200),
+	STARFIVE_GATE(JHB100_SYS2CLK_JTAG1_MST_WRAP_CLK_JTAG, "jtag1_mst_wrap_clk_jtag",
+		      CLK_IGNORE_UNUSED, JHB100_SYS2CLK_JTAGM1_200),
+	STARFIVE_GATE(JHB100_SYS2CLK_JTAG1_MST_WRAP_APB_PCLK, "jtag1_mst_wrap_apb_pclk",
+		      CLK_IGNORE_UNUSED, JHB100_SYS2CLK_JTAGM1_100),
+	STARFIVE_GATE(JHB100_SYS2CLK_JTAG1_MST_WRAP_ATPG_TCLOCK, "jtag1_mst_wrap_atpg_tclock",
+		      CLK_IGNORE_UNUSED, JHB100_SYS2CLK_JTAGM1_100),
+	/* hostusbcmn */
+	STARFIVE__DIV(JHB100_SYS2CLK_HOSTUSB_100, "hostusb_100", 12,
+		      JHB100_SYS2CLK_PLL1),
+	STARFIVE__DIV(JHB100_SYS2CLK_HOSTUSBCMN_500, "hostusbcmn_500", 4,
+		      JHB100_SYS2CLK_PLL1),
+	/* bmcperiph1 */
+	STARFIVE__DIV(JHB100_SYS2CLK_BMCPER1_200, "bmcper1_200", 6,
+		      JHB100_SYS2CLK_PLL1),
+	STARFIVE__DIV(JHB100_SYS2CLK_BMCPER1_250, "bmcper1_250", 5,
+		      JHB100_SYS2CLK_PLL1),
+	STARFIVE__DIV(JHB100_SYS2CLK_BMCPER1_143_DFT, "bmcper1_143_dft", 8,
+		      JHB100_SYS2CLK_PLL1),
+	STARFIVE_GATE(JHB100_SYS2CLK_BMCPER1_143, "bmcper1_143", CLK_IS_CRITICAL,
+		      JHB100_SYS2CLK_BMCPER1_143_DFT),
+	/* bmcperiph0 */
+	STARFIVE__DIV(JHB100_SYS2CLK_BMCPER0_200, "bmcper0_200", 6,
+		      JHB100_SYS2CLK_PLL1),
+	/* gpu0 */
+	STARFIVE__DIV(JHB100_SYS2CLK_GPU0_100, "gpu0_100", 12,
+		      JHB100_SYS2CLK_PLL1),
+	STARFIVE_GATE(JHB100_SYS2CLK_GPU0_BUS_CLK, "gpu0_bus_clk", CLK_IS_CRITICAL,
+		      JHB100_SYS2CLK_GPU0_600),
+	STARFIVE_GATE(JHB100_SYS2CLK_GPU0_APB_CLK, "gpu0_apb_clk", CLK_IS_CRITICAL,
+		      JHB100_SYS2CLK_GPU0_100),
+	STARFIVE_GATE(JHB100_SYS2CLK_GPU0_OSC_CLK, "gpu0_osc_clk", CLK_IS_CRITICAL,
+		      JHB100_SYS2CLK_OSC),
+	/* gpu1 */
+	STARFIVE__DIV(JHB100_SYS2CLK_GPU1_100, "gpu1_100", 12,
+		      JHB100_SYS2CLK_PLL1),
+	STARFIVE_GATE(JHB100_SYS2CLK_GPU1_BUS_CLK, "gpu1_bus_clk", CLK_IS_CRITICAL,
+		      JHB100_SYS2CLK_GPU1_600),
+	STARFIVE_GATE(JHB100_SYS2CLK_GPU1_APB_CLK, "gpu1_apb_clk", CLK_IS_CRITICAL,
+		      JHB100_SYS2CLK_GPU1_100),
+	STARFIVE_GATE(JHB100_SYS2CLK_GPU1_OSC_CLK, "gpu1_osc_clk", CLK_IS_CRITICAL,
+		      JHB100_SYS2CLK_OSC),
+	/* main icg */
+	STARFIVE_GATE(JHB100_SYS2CLK_MAIN_ICG_EN_JTAG0, "main_icg_en_jtag0", 0,
+		      JHB100_SYS2CLK_JTAGM0_200),
+	STARFIVE_GATE(JHB100_SYS2CLK_MAIN_ICG_EN_JTAG1, "main_icg_en_jtag1", 0,
+		      JHB100_SYS2CLK_JTAGM1_200),
+};
+
+static int __init jhb100_sys2crg_probe(struct platform_device *pdev)
+{
+	struct starfive_clk_priv *priv;
+	unsigned int idx;
+	int ret;
+
+	priv = devm_kzalloc(&pdev->dev,
+			    struct_size(priv, reg, JHB100_SYS2CLK_NUM_CLKS),
+			    GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	spin_lock_init(&priv->rmw_lock);
+	priv->num_reg = JHB100_SYS2CLK_NUM_CLKS;
+	priv->dev = &pdev->dev;
+	priv->base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(priv->base))
+		return PTR_ERR(priv->base);
+
+	for (idx = 0; idx < JHB100_SYS2CLK_NUM_CLKS; idx++) {
+		u32 max = jhb100_sys2crg_clk_data[idx].max;
+		struct clk_parent_data parents[4] = {};
+		struct clk_init_data init = {
+			.name = jhb100_sys2crg_clk_data[idx].name,
+			.ops = starfive_clk_ops(max),
+			.parent_data = parents,
+			.num_parents =
+				((max & STARFIVE_CLK_MUX_MASK) >> STARFIVE_CLK_MUX_SHIFT) + 1,
+			.flags = jhb100_sys2crg_clk_data[idx].flags,
+		};
+		struct starfive_clk *clk = &priv->reg[idx];
+		unsigned int i;
+
+		if (!init.name)
+			continue;
+
+		for (i = 0; i < init.num_parents; i++) {
+			unsigned int pidx = jhb100_sys2crg_clk_data[idx].parents[i];
+
+			if (pidx < JHB100_SYS2CLK_NUM_CLKS)
+				parents[i].hw = &priv->reg[pidx].hw;
+			else if (pidx == JHB100_SYS2CLK_OSC)
+				parents[i].fw_name = "osc";
+			else if (pidx == JHB100_SYS2CLK_PLL1)
+				parents[i].fw_name = "pll1";
+			else if (pidx == JHB100_SYS2CLK_GPU0_600)
+				parents[i].fw_name = "sys2_gpu0_600";
+			else
+				parents[i].fw_name = "sys2_gpu1_600";
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
+	return jhb100_reset_controller_register(priv, "r-sys2", 0);
+}
+
+static const struct of_device_id jhb100_sys2crg_match[] = {
+	{ .compatible = "starfive,jhb100-sys2crg" },
+	{ /* sentinel */ }
+};
+
+static struct platform_driver jhb100_sys2crg_driver = {
+	.driver = {
+		.name = "clk-starfive-jhb100-sys2",
+		.of_match_table = jhb100_sys2crg_match,
+		.suppress_bind_attrs = true,
+	},
+};
+builtin_platform_driver_probe(jhb100_sys2crg_driver, jhb100_sys2crg_probe);
-- 
2.25.1


