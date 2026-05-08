Return-Path: <netdev+bounces-285655-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0LKfACJ8/WnnegAAu9opvQ
	(envelope-from <netdev+bounces-285655-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 08:01:06 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5293F4F230B
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 08:01:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BEFF230D8E78
	for <lists+netdev@lfdr.de>; Fri,  8 May 2026 05:42:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0684537C926;
	Fri,  8 May 2026 05:39:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2123.outbound.protection.partner.outlook.cn [139.219.146.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20494379987;
	Fri,  8 May 2026 05:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.123
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778218736; cv=fail; b=sm0yKDXrKuofo0i7CmgB3WC2nXYNBOzqFvHQSuj/5PHeroP19nGBw44b2MRprFSuubv0F61ZAhYQ6uoqxApFzeyPW1kPNET8X4Hpx6VGyk7659e0ESA21QydbvOu/aBSWKlQ+hOrQjuFG0QR4JkzIRBRw+DbH+heKxnbgdTE9Ho=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778218736; c=relaxed/simple;
	bh=KIYc0zhi4YJSwb2Sn0AlGu8lIsTR2T959r2ZKUT6xMQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fh0xw4qY/p6IxbnpsOFdlvK5CSM7jwL5cogDjjr6yIRWDdrlp7KRYRUboFVC5hK1Ed13BbNsBgL5sYagLuRGzZO+eUsOMXUPHC7oG+TSFV4qNjYVg9HHsIfFmKg0fKFExXVhFlik5YzeLlsG9WJ1sapBMmwu9a+FI16a67vV5YM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AuFUt2OjKENANcZWBFtF1D1DoMgHVQQhyl+BFqr//wGmSa9+RTjrmlb9RkkBCQePeo8Im2ge8jvH4A+kGI+CcVXtLNUuug0QtVIJ+0jt4VvYqIPqtWwNWiGlZRgJ1Puro8yq5ypxQquMhLROTX1rDxr7SFNmFkuA3E7RhLZQlkUddWB3/1Yo+OfDh25lyZU+AShbOCryxVEjKjYhsPkmbzP+x/JPsTXfWcpzVESn4WP+Wrzdf7sQ7/JkwH0NlfCADM4pPiPr88POiQXgdhQ0CDHj/3By943wzrjU0JYl0cAc9dRkhKuHNxenFHINCDIyVq7IkATDHKXfn8IIc+ut1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5Liv8Jyg7aINRHg6/AEBHIIzmeJ2iHoDDB4GA/xSris=;
 b=K7bjfR9BIxQM8ot+0PoNY+CZiZZpEYwXUWRwb6ofA/Ne/2LeEMwrS0//wVj/XzhzzL7h8NCsXEZoLtGSrLrdridFBK8eXm2eWcEwQhNzqkx0V5w0/hRrE+L1SqSPe5PnEJpiW7JUNVyIRuLYNOuJN63SE+NrTBs8UosapE0bsatKKNTeFcDaSom+cILpF4PXLCCa2FEsWoufRjCBRr18OOKkRqWlJuOUlvHV9t97SN7GNDDIJJ6Zfq3WBE1mQ4S2qyO6JXOVQr0DamOT0ibq5ivG7LNQOvSQm2dY5IiTOb2sicKxKl1vr+htZbCwU5F1gG+8WRNEI3yBsJe3ZeF9pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:17::6) by ZQ4PR01MB1267.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:16::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.18; Fri, 8 May
 2026 05:37:09 +0000
Received: from ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
 ([fe80::e7d4:256c:b066:850d]) by
 ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn ([fe80::e7d4:256c:b066:850d%5])
 with mapi id 15.20.9891.019; Fri, 8 May 2026 05:37:09 +0000
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
Subject: [PATCH v2 16/22] clk: starfive: Add StarFive JHB100 Peripheral-1 clock driver
Date: Thu,  7 May 2026 22:36:26 -0700
Message-Id: <20260508053632.818548-17-changhuang.liang@starfivetech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260508053632.818548-1-changhuang.liang@starfivetech.com>
References: <20260508053632.818548-1-changhuang.liang@starfivetech.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: NT0PR01CA0035.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:c::12) To ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:17::6)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZQ4PR01MB1202:EE_|ZQ4PR01MB1267:EE_
X-MS-Office365-Filtering-Correlation-Id: c0a6f2fe-cf3b-40de-61d8-08deacc3d8fe
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|52116014|376014|56012099003|38350700014|921020|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	IFSdiwnKvWeldvYjM1N/B1lYbssBhrbWY8x+NPYyhUCN2RZw3dH19hVNapTVcgMcG5zoiYhS60FHP1nNjCQyhLJsmSjYgeMOIT/C25ynESYnfZPzT+FQUj/o64y76iplQqtlPCO05dK8DkeYfmCqDQ40CsKOZHzOf+8hX8aK9Jd4/0ipOgiuJsmmRXzE4Te1TtTgQexr3arfHQYzjhRWL0qQZbS1rqCBv9eZh/pO/U8JfzlmgpwqQprqyrg2QKrHSFBpPtxIHJUFbQciZAvnSdkf9sDsvhd7AjaHWW7vEbZM0w23PeHvPm6R/nbsD9V0pF3OPX9ebdAXL9adkZJRo1mEvVk29ELslgCgu9HgTvhmWE+uk279KUa3V70AQZlAK0zuHgTneGEcl3FMw31iXk/oduKO+h7XbLGKTjiTHsT6tU6JR4yE4HXGXld3e0zkBQGPwKQJhuB3KDBf/6MT6QUGZbtpRZ/FvE+4Gh0Awj6iGasS6dVGu/Rdj05FoBYX9pgbEJUYT155RU4J/7EYpYUc0kDacYfZDIJEMDdqPOG9YZkywGeLm4rIdABtBbU1pju5gDMZ4BeKM/OLjis2eQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(52116014)(376014)(56012099003)(38350700014)(921020)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mJzaw5H+HXH6aLgAhkRCE0odopuRFCdfBPwMF3P6HfYetSskoxxdX26GWqYX?=
 =?us-ascii?Q?1fPe8xpk4kvfyv0GkzURg4m+KzGXvIuks3kkcbA9nw0kSBsWQ8iqTu0PltY6?=
 =?us-ascii?Q?yS4IiUkHTC0/GMsDXopiPW0iOnQj0d6oY6G1ois/y7UozzYF+JIpAy4ZxyVF?=
 =?us-ascii?Q?ySGC7zeP2hWubCHbGw9CFQIMGli61fJb3jyIEjORn2TAbaiN9casr0qFbEaQ?=
 =?us-ascii?Q?zTnmmTf8KMj9UyNrRLhd0rOJKJtgd2Lmmg2TqNatlhms6DM9ZRMrakM+oo6D?=
 =?us-ascii?Q?4keiK+ZnYXxHdoT53VrbG+uo0ZDyBLCLGEQ+FEgPAtBdPqtcvdAWSjc3Ud4K?=
 =?us-ascii?Q?X8rFz8gt3Vhkl2c+xN35R2sT/K038OZET72KegpKWaEkq63oQ2SuHRf/RBDq?=
 =?us-ascii?Q?8xKUxaD4ck2LW+CTXvssr+lBLl+A4oFuqIn8AHWBIskPlE3XA0wWByfF41zT?=
 =?us-ascii?Q?mQWtnj+4wSx0XSjT47ydSsxkNyOAIjpO4pxCINCrVlWLanJO3T31p8MmT+5a?=
 =?us-ascii?Q?wulFioVZ+hzYWO5S2qfPr4e3zlTItrL+I6QjhnoS7lfgnUcKSJS2zfiIM6lp?=
 =?us-ascii?Q?AjXJ+XQ9/XZbjs3TcyvPyeeRWx276hH1Jv57EXqW7hQU3IK2zOcxVkl2IcQv?=
 =?us-ascii?Q?wMnhabUU3kCwnUEQaNryjl2Qy/zGbo7PuqdJmvKXLZ8MUepaKXQ8Betxm2SG?=
 =?us-ascii?Q?6GqWY8z9g3LEoy6zWYPWcreIpJRKxkgJDWX6IoKI7QXHl1U1dBKV0jHlAG7A?=
 =?us-ascii?Q?2veIB0GLocdKlbFYKVdfPBtyBKYPgPWIFULCd+9Y/2kg8dFHB+ymLdaU4z55?=
 =?us-ascii?Q?j+nNgvSHwGpGB8qM6UBgbpWuE1wDwhb6xQ4295WuZQdHyyrJ2kOE3crEW1Nw?=
 =?us-ascii?Q?A5UyLe62CFFqM3UaRUKySv/qbdjOe7gDkkURC3Nq1upkMtEJ2SkW3RacAHyZ?=
 =?us-ascii?Q?1R9+9kg+l6ZBJNdUn51iuFYWJ0Sc3yKO30Oz9iQBd/z3T4iXaSyRbqoVHq9B?=
 =?us-ascii?Q?b4ioRQigTDnuz1yZaF+I6B4OOxLSQyTLlO0xjtuzmqQKxp8DBkAy+uOE7n2m?=
 =?us-ascii?Q?BX7Mp27nvls2CqQ61ucpcP1ocGgdnwOHOg0tExowKFF3tvV5vIpuTZ/rhvCe?=
 =?us-ascii?Q?jezO23TAtCMJ+WkTTVZerw+/5YkPIiU0hfmW1z3jjq6fv33cgM3yoYyYAwN+?=
 =?us-ascii?Q?j6ToRpcYkj9Mwm2AHd6kd9dD0ID5jDCsrUi6M1xnze4sOMXx2Mo8BXNSNq7F?=
 =?us-ascii?Q?mN9dna84yKo3xTVdzaFM3g7gaXDaRULyJIeV/d7TxW+jnMcZ6+8UcnO6cdAA?=
 =?us-ascii?Q?mzeLQAyo+NaCYeQil3+2Y6R8IFMDS0vsJxqabVVUHBPLjLrgFoDNGWpTuwF7?=
 =?us-ascii?Q?VjJb2rS+MQ/uiIboVRKiKw5pOdaa6I5C9vFpY0dW3JxE163S8nsTzCUwNJxV?=
 =?us-ascii?Q?xsO5B13anAshjB96y4+6YFJE5ap+NN2NpibwNjXVHkBy9U26qlOvlwD26dLq?=
 =?us-ascii?Q?QcnqRmCqSIfzNveR6d429Q25wX0g8Hg7MzS7CP4nXl0iyL3F1+jUT0EcGZqn?=
 =?us-ascii?Q?Vdb6nPoqRva2wH2gx5Zrn5KNNqrraK69JV33M8mJ1zPTPAVzVZBeYOJdrAbC?=
 =?us-ascii?Q?6jKbKP7oPj1/gmd08Va585sSJS2mM7dkVcZ9Fzn5FajEXWcBxl+Q/pTZpjLq?=
 =?us-ascii?Q?EoRKXgNpdhjQ/7UW4d93u3QUknt1Bruquhj3ymmIc0oyOmfeKLJVc/qIaXZV?=
 =?us-ascii?Q?cS7SytU0Os1nl7m+d/Pq7stE87Ja4rMpDKsFH9v/lDmH6M3zyl/W?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0a6f2fe-cf3b-40de-61d8-08deacc3d8fe
X-MS-Exchange-CrossTenant-AuthSource: ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2026 05:37:09.3257
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IvgHeatfWXvHOuLpklw3AjR24u9QqqMds10YTQSJpanGzJZwM1L6ex3EHrLcBxSivKmP2mxhxrc1o7iNS7GruYvjlQDPUU/c0Oe1it2G+RUC5jAqBwocidf7iBITvmUo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ4PR01MB1267
X-Rspamd-Queue-Id: 5293F4F230B
X-Rspamd-Server: lfdr
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
	FREEMAIL_TO(0.00)[baylibre.com,kernel.org,dabbelt.com,eecs.berkeley.edu,ghiti.fr,pengutronix.de,esmil.dk,gmail.com];
	GREYLIST(0.00)[pass,meta];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-285655-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[24];
	FROM_HAS_DN(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.897];
	FROM_NEQ_ENVFROM(0.00)[changhuang.liang@starfivetech.com,netdev@vger.kernel.org];
	TAGGED_RCPT(0.00)[netdev,dt];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,starfivetech.com:email,starfivetech.com:mid]
X-Rspamd-Action: no action

Add driver for the StarFive JHB100 Peripheral-1 clock controller.

Signed-off-by: Changhuang Liang <changhuang.liang@starfivetech.com>
---
 drivers/clk/starfive/Kconfig                  |   8 +
 drivers/clk/starfive/Makefile                 |   1 +
 .../clk/starfive/clk-starfive-jhb100-per1.c   | 153 ++++++++++++++++++
 3 files changed, 162 insertions(+)
 create mode 100644 drivers/clk/starfive/clk-starfive-jhb100-per1.c

diff --git a/drivers/clk/starfive/Kconfig b/drivers/clk/starfive/Kconfig
index adf97444f460..72cf314c6cfc 100644
--- a/drivers/clk/starfive/Kconfig
+++ b/drivers/clk/starfive/Kconfig
@@ -81,6 +81,14 @@ config CLK_STARFIVE_JHB100_PER0
 	  Say yes here to support the peripheral-0 clock controller
 	  on the StarFive JHB100 SoC.
 
+config CLK_STARFIVE_JHB100_PER1
+	bool "StarFive JHB100 peripheral-1 clock support"
+	depends on CLK_STARFIVE_JHB100_SYS2
+	default ARCH_STARFIVE
+	help
+	  Say yes here to support the peripheral-1 clock controller
+	  on the StarFive JHB100 SoC.
+
 config CLK_STARFIVE_JHB100_SYS0
 	bool "StarFive JHB100 system-0 clock support"
 	depends on ARCH_STARFIVE || COMPILE_TEST
diff --git a/drivers/clk/starfive/Makefile b/drivers/clk/starfive/Makefile
index 2f605d0fd6da..51511086a727 100644
--- a/drivers/clk/starfive/Makefile
+++ b/drivers/clk/starfive/Makefile
@@ -12,6 +12,7 @@ obj-$(CONFIG_CLK_STARFIVE_JH7110_ISP)	+= clk-starfive-jh7110-isp.o
 obj-$(CONFIG_CLK_STARFIVE_JH7110_VOUT)	+= clk-starfive-jh7110-vout.o
 
 obj-$(CONFIG_CLK_STARFIVE_JHB100_PER0)		+= clk-starfive-jhb100-per0.o
+obj-$(CONFIG_CLK_STARFIVE_JHB100_PER1)		+= clk-starfive-jhb100-per1.o
 obj-$(CONFIG_CLK_STARFIVE_JHB100_SYS0)		+= clk-starfive-jhb100-sys0.o
 obj-$(CONFIG_CLK_STARFIVE_JHB100_SYS1)		+= clk-starfive-jhb100-sys1.o
 obj-$(CONFIG_CLK_STARFIVE_JHB100_SYS2)		+= clk-starfive-jhb100-sys2.o
diff --git a/drivers/clk/starfive/clk-starfive-jhb100-per1.c b/drivers/clk/starfive/clk-starfive-jhb100-per1.c
new file mode 100644
index 000000000000..272937555888
--- /dev/null
+++ b/drivers/clk/starfive/clk-starfive-jhb100-per1.c
@@ -0,0 +1,153 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * StarFive JHB100 Peripheral-1 Clock Driver
+ *
+ * Copyright (C) 2024 StarFive Technology Co., Ltd.
+ *
+ * Author: Changhuang Liang <changhuang.liang@starfivetech.com>
+ *
+ */
+
+#include <dt-bindings/clock/starfive,jhb100-crg.h>
+#include <linux/platform_device.h>
+
+#include "clk-starfive-common.h"
+
+#define JHB100_PER1CLK_NUM_CLKS			(JHB100_PER1CLK_MAIN_ICG_EN_UFS + 1)
+
+/* external clocks */
+#define JHB100_PER1CLK_PLL7			(JHB100_PER1CLK_NUM_CLKS + 0)
+#define JHB100_PER1CLK_NCNOC_INIT		(JHB100_PER1CLK_NUM_CLKS + 1)
+#define JHB100_PER1CLK_CFG_800			(JHB100_PER1CLK_NUM_CLKS + 2)
+#define JHB100_PER1CLK_NCNOC_TARG		(JHB100_PER1CLK_NUM_CLKS + 3)
+#define JHB100_PER1CLK_CFG_143			(JHB100_PER1CLK_NUM_CLKS + 4)
+
+char *jhb100_per1_ext_clk[] = {
+	"pll7",
+	"ncnoc_init",
+	"cfg_800",
+	"ncnoc_targ",
+	"cfg_143",
+};
+
+static const struct starfive_clk_data jhb100_per1crg_clk_data[] = {
+	STARFIVE__DIV(JHB100_PER1CLK_100, "per1_100", 8, JHB100_PER1CLK_NCNOC_INIT),
+	STARFIVE__DIV(JHB100_PER1CLK_1, "per1_1", 100, JHB100_PER1CLK_100),
+	STARFIVE__DIV(JHB100_PER1CLK_200_DIVN0, "200_divn0", 256,
+		      JHB100_PER1CLK_CFG_800),
+	STARFIVE__DIV(JHB100_PER1CLK_200_DIVN1, "200_divn1", 256,
+		      JHB100_PER1CLK_CFG_800),
+	STARFIVE__DIV(JHB100_PER1CLK_200_DIVN2, "200_divn2", 256,
+		      JHB100_PER1CLK_CFG_800),
+	STARFIVE__DIV(JHB100_PER1CLK_200_DIVN3, "200_divn3", 256,
+		      JHB100_PER1CLK_CFG_800),
+	STARFIVE__DIV(JHB100_PER1CLK_200_CCLK_DIV, "200_cclk_div", 2046,
+		      JHB100_PER1CLK_NCNOC_TARG),
+	STARFIVE_GATE(JHB100_PER1CLK_SGPIO0_PCLK, "sgpio0_pclk", CLK_IGNORE_UNUSED,
+		      JHB100_PER1CLK_100),
+	STARFIVE_GATE(JHB100_PER1CLK_SGPIO0_DCLK, "sgpio0_dclk", CLK_IGNORE_UNUSED,
+		      JHB100_PER1CLK_100),
+	STARFIVE_GATE(JHB100_PER1CLK_SGPIO1_PCLK, "sgpio1_pclk", CLK_IGNORE_UNUSED,
+		      JHB100_PER1CLK_100),
+	STARFIVE_GATE(JHB100_PER1CLK_SGPIO1_DCLK, "sgpio1_dclk", CLK_IGNORE_UNUSED,
+		      JHB100_PER1CLK_100),
+	STARFIVE_GATE(JHB100_PER1CLK_EMMC0_BCLK, "emmc0_bclk", CLK_IGNORE_UNUSED,
+		      JHB100_PER1CLK_NCNOC_TARG),
+	STARFIVE_GATE(JHB100_PER1CLK_EMMC0_CCLK, "emmc0_cclk", 0,
+		      JHB100_PER1CLK_NCNOC_TARG),
+	STARFIVE_GATE(JHB100_PER1CLK_DMAC1_1CH_CORE, "dmac1_1ch_core", 0,
+		      JHB100_PER1CLK_NCNOC_TARG),
+	STARFIVE_GATE(JHB100_PER1CLK_DMAC1_1CH_ACLK, "dmac1_1ch_aclk", 0,
+		      JHB100_PER1CLK_NCNOC_TARG),
+	STARFIVE_GATE(JHB100_PER1CLK_DMAC2_1CH_CORE, "dmac2_1ch_core", 0,
+		      JHB100_PER1CLK_NCNOC_TARG),
+	STARFIVE_GATE(JHB100_PER1CLK_DMAC2_1CH_ACLK, "dmac2_1ch_aclk", 0,
+		      JHB100_PER1CLK_NCNOC_TARG),
+	STARFIVE_GATE(JHB100_PER1CLK_DMAC3_1CH_CORE, "dmac3_1ch_core", 0,
+		      JHB100_PER1CLK_NCNOC_TARG),
+	STARFIVE_GATE(JHB100_PER1CLK_DMAC3_1CH_ACLK, "dmac3_1ch_aclk", 0,
+		      JHB100_PER1CLK_NCNOC_TARG),
+	STARFIVE_GATE(JHB100_PER1CLK_DMAC0_2CH_CORE, "dmac0_2ch_core", 0,
+		      JHB100_PER1CLK_NCNOC_TARG),
+	STARFIVE_GATE(JHB100_PER1CLK_DMAC0_2CH_ACLK, "dmac0_2ch_aclk", 0,
+		      JHB100_PER1CLK_NCNOC_TARG),
+	STARFIVE__DIV(JHB100_PER1CLK_UFS_REF, "ufs_ref", 75,
+		      JHB100_PER1CLK_PLL7),
+	STARFIVE__DIV(JHB100_PER1CLK_UFS_300, "ufs_300", 2,
+		      JHB100_PER1CLK_NCNOC_INIT),
+	STARFIVE__DIV(JHB100_PER1CLK_UFS_150, "ufs_150", 12,
+		      JHB100_PER1CLK_NCNOC_INIT),
+	STARFIVE__DIV(JHB100_PER1CLK_UFS_400, "ufs_400", 2,
+		      JHB100_PER1CLK_CFG_800),
+	STARFIVE__DIV(JHB100_PER1CLK_UFS_75, "ufs_75", 2,
+		      JHB100_PER1CLK_UFS_150),
+	STARFIVE__DIV(JHB100_PER1CLK_UFS_37_5, "ufs_37_5", 2,
+		      JHB100_PER1CLK_UFS_75),
+	STARFIVE__DIV(JHB100_PER1CLK_UFS_7_5, "ufs_7_5", 10,
+		      JHB100_PER1CLK_UFS_75),
+	STARFIVE__DIV(JHB100_PER1CLK_UFS_1_875, "ufs_1_875", 4,
+		      JHB100_PER1CLK_UFS_7_5),
+	STARFIVE__DIV(JHB100_PER1CLK_UFS_7_143, "ufs_7_143", 20,
+		      JHB100_PER1CLK_CFG_143),
+	STARFIVE__DIV(JHB100_PER1CLK_UFS_3_5715, "ufs_3_5715", 2,
+		      JHB100_PER1CLK_UFS_7_143),
+	STARFIVE_GATE(JHB100_PER1CLK_MAIN_ICG_EN_SFC0, "main_icg_en_sfc0", CLK_IS_CRITICAL,
+		      JHB100_PER1CLK_NCNOC_TARG),
+	STARFIVE_GATE(JHB100_PER1CLK_MAIN_ICG_EN_SFC1, "main_icg_en_sfc1", CLK_IS_CRITICAL,
+		      JHB100_PER1CLK_NCNOC_TARG),
+	STARFIVE_GATE(JHB100_PER1CLK_MAIN_ICG_EN_SFC2, "main_icg_en_sfc2", CLK_IS_CRITICAL,
+		      JHB100_PER1CLK_NCNOC_TARG),
+	STARFIVE_GATE(JHB100_PER1CLK_MAIN_ICG_EN_SPI0, "main_icg_en_spi0", 0,
+		      JHB100_PER1CLK_NCNOC_TARG),
+	STARFIVE_GATE(JHB100_PER1CLK_MAIN_ICG_EN_EMMC0, "main_icg_en_emmc0", 0,
+		      JHB100_PER1CLK_NCNOC_TARG),
+	STARFIVE_GATE(JHB100_PER1CLK_MAIN_ICG_EN_SGPIO0, "main_icg_en_sgpio0", 0,
+		      JHB100_PER1CLK_100),
+	STARFIVE_GATE(JHB100_PER1CLK_MAIN_ICG_EN_SGPIO1, "main_icg_en_sgpio1", 0,
+		      JHB100_PER1CLK_100),
+	STARFIVE_GATE(JHB100_PER1CLK_MAIN_ICG_EN_SENSORS_PERIPH1, "main_icg_en_sensors_periph1", 0,
+		      JHB100_PER1CLK_100),
+	STARFIVE_GATE(JHB100_PER1CLK_MAIN_ICG_EN_DMAC_SFC0, "main_icg_en_dmac_sfc0",
+		      CLK_IS_CRITICAL, JHB100_PER1CLK_NCNOC_TARG),
+	STARFIVE_GATE(JHB100_PER1CLK_MAIN_ICG_EN_DMAC_SFC1, "main_icg_en_dmac_sfc1",
+		      CLK_IS_CRITICAL, JHB100_PER1CLK_NCNOC_TARG),
+	STARFIVE_GATE(JHB100_PER1CLK_MAIN_ICG_EN_DMAC_SFC2, "main_icg_en_dmac_sfc2",
+		      CLK_IS_CRITICAL, JHB100_PER1CLK_NCNOC_TARG),
+	STARFIVE_GATE(JHB100_PER1CLK_MAIN_ICG_EN_DMAC_SPI0, "main_icg_en_dmac_spi0",
+		      CLK_IS_CRITICAL, JHB100_PER1CLK_NCNOC_TARG),
+	STARFIVE_GATE(JHB100_PER1CLK_MAIN_ICG_EN_RAS, "main_icg_en_ras", 0,
+		      JHB100_PER1CLK_100),
+	STARFIVE_GATE(JHB100_PER1CLK_MAIN_ICG_EN_UFS, "main_icg_en_ufs", 0,
+		      JHB100_PER1CLK_100),
+};
+
+const struct jhb100_crg_domain_info jhb100_per1crg_info = {
+	.clk_data	= jhb100_per1crg_clk_data,
+	.num_clk	= ARRAY_SIZE(jhb100_per1crg_clk_data),
+	.ext_clk	= jhb100_per1_ext_clk,
+	.num_ext_clk	= ARRAY_SIZE(jhb100_per1_ext_clk),
+	.rst_name	= "jhb100-r-per1",
+	.power_domain	= false,
+};
+
+static const struct of_device_id jhb100_per1crg_match[] = {
+	{
+		.compatible = "starfive,jhb100-per1crg",
+		.data = &jhb100_per1crg_info,
+	},
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, jhb100_per1crg_match);
+
+static struct platform_driver jhb100_per1crg_driver = {
+	.probe = starfive_crg_probe,
+	.driver = {
+		.name = "clk-starfive-jhb100-per1",
+		.of_match_table = jhb100_per1crg_match,
+	},
+};
+module_platform_driver(jhb100_per1crg_driver);
+
+MODULE_AUTHOR("Changhuang Liang <changhuang.liang@starfivetech.com>");
+MODULE_DESCRIPTION("StarFive JHB100 Peripheral-1 Clock Driver");
+MODULE_LICENSE("GPL");
-- 
2.25.1


