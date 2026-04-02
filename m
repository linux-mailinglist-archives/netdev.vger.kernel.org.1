Return-Path: <netdev+bounces-274493-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EI+VB3lZzmkxnAYAu9opvQ
	(envelope-from <netdev+bounces-274493-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 13:56:41 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 76E50388A76
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 13:56:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9AB0430CEBDA
	for <lists+netdev@lfdr.de>; Thu,  2 Apr 2026 11:29:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6FCF3BADAD;
	Thu,  2 Apr 2026 11:29:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2105.outbound.protection.partner.outlook.cn [139.219.146.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 173CB39EF28;
	Thu,  2 Apr 2026 11:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.105
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775129390; cv=fail; b=uin2GeguabUAKb3Ld/xiZnnq8kD4iEC0CGxSQkaCiUezVYSaIh/788sh/HWZ1w9uTADdD65yrQYTEXuMLhAWwqZHSaORi9FWUae8ts+SLYQ82/gI9uoos7r/93noYg9OO16zWpHkeHeas69XLaBTxFgl03EhDuBOoFgV8O3b9wo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775129390; c=relaxed/simple;
	bh=/qmedbzTky67P2DCvwZl4RLwHNRF7Mp4xT9YXSilbzM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BoklDcrn0Iot7WzcjR5bW3VS2l+5D3gRzMqVzJHbzQLfTx7P4IoKUNPvLRR7iogzM9PiIcI0cjZ0L7N1JgCGfTRtOHxgpyWqnYHS8qYARd0NVfeO23M4Z1UMlkK2Ks2S+GAznRPEhYobnvDy4EM5wP1pWjW7Zqaih8NO8s10KEI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GpgyMZKhKmyQn0V1+RJyV8Qio7QqZk1xYy/dV0TUTy0QP8lX6qYxoSynOAw95AhTaUp+T1dUo0KttSYL7feFtnN9Tg6BPGV/WgBsjhkzVQF0iRBUA2xCgp8IgcA0X6Y/PTgmeGt9HVd3zAll0glDwAd3DpVPRUKLG5B6knpbNCPxKOXAWBa24T5j/sFT2XXSB/4w5pSntLGtg9oRD5rgMi/e045PytExpNwHewdKYtpc1mR0OoA7asY6AtI0hUA+9242O+VigRXwJwM0ei+eiLRATlm12OiqDTQHHTOisYYBudclSI+KZSp5Fr+hot3tH8W/eLk+BqIQpRgOifGSxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ldJnOt8Pray8903U8AAHb6dWZCq/yam0DJ/QQEdohz8=;
 b=IVHBMS7JgXvBbt0woqo03oIJpzBFiGGtFp9A8OyLdXaZ/L+Qnrhnm/+l3XJyaTE27RPp/N9rEZUySqnnUjrhUgWhaYaLSW/b851KD/clggjtBFXsy4V8zFFhZdu98OcK7IndAY3Gna0K08hwPXrnhbTvVi3tTm/61mI5y5w7RJnhpeo/EMAhC+N8min3wunvZwYJxDxUmRD4uTN3ya4d1/hxZr1UFt2brjQBJWHHeGr6Y2LVm+yEUCeQo5f7H6GVr2FvUM0aov9OydQM3g/ZBw3aR8NeuwKo9TtrhzZ0NZ3PXg+XvmhpcfgforshmD1qd94CrI/qzUbHPUBw0RenRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ0PR01MB1208.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:19::5) by ZQ0PR01MB1096.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:c::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.20; Thu, 2 Apr
 2026 10:55:45 +0000
Received: from ZQ0PR01MB1208.CHNPR01.prod.partner.outlook.cn
 ([fe80::63d1:b688:cab7:50cb]) by
 ZQ0PR01MB1208.CHNPR01.prod.partner.outlook.cn ([fe80::63d1:b688:cab7:50cb%7])
 with mapi id 15.20.9769.017; Thu, 2 Apr 2026 10:55:45 +0000
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
Subject: [PATCH v1 03/22] clk: starfive: Rename file name "jh71x0" to "common"
Date: Thu,  2 Apr 2026 03:55:04 -0700
Message-Id: <20260402105523.447523-4-changhuang.liang@starfivetech.com>
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
X-MS-Office365-Filtering-Correlation-Id: 493a86cb-bf94-4b3e-ab3e-08de90a663df
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|52116014|376014|366016|921020|38350700014|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	SDzIP9k1lHm2mlfKZhctU3ZPVXCOtmhBjgOkCE5YLBRYhHmUHkjFa9+RQ8rtsVjLmMXoC0BZ1FUZqI2/IzUCeG7R5fpRZJzki1HFRYpGWu24qdxd1oW491c3GIerFl4weFOkyGu2unLN6k617oKBr6iNJ+f8CH9T5w0fqJ8KMN7IWVeqiahBe9ZHkXpVqhKx0yVDK+F5EhSi1rQEGFKgFM9gm9ciN5SixHIEstFgDSSidRmg7//VywTob/3MSWTJ17wX8NGPA5ICuFHtE/pobN3Gom+5UjCmYB0FYNgmlnLaQyqODKAkOg3VRhLWgzAoCFdN9/L3FqNsCmZ2vvjwOL5VW/49PfwrAaB82fyEJXTEbQkQ83IEdg2K4LCZaHr1XtAm5VXuvgC6RX5yG4qIg6Dkv4MWr/8ZrES2OmYNyDHVF1jfqFwFnDUhbkdepMbI/pW4dULiDjH2Tyxs/CO7BHsLlfvscVqSPPdPIXDN46n5SWHPip5kz3BOz5FlnCZqMrTSZbXTCOOt7EEntw0ADsupGGosNRKGokya359WyhbE4BXJ3Ox43SQVdLh4IPC7g7ISNFuXyqpSrvjaLFlJL9W288jCxsBTVwsFgnLiZxw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ0PR01MB1208.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(52116014)(376014)(366016)(921020)(38350700014)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+c/hYeUNeb5Y4oyOuOuT2Y1FpL0z4SoNMLMf/jhBuUhpzvEiaXRsVEW+Z+0n?=
 =?us-ascii?Q?MRmvJWgFIAmgqTMZKGRfiwQ7tl4t2649ID75oaeIGrMIEla+OA8KRTyVsgsS?=
 =?us-ascii?Q?cgocMU+bTTw4C3zEZUPuGHGgjGzRbZrnNz4mGKeVOOf+ekHOa3JmDCeoWTj9?=
 =?us-ascii?Q?sGm859OgjR/O/X4f6gM/zBukRa/nsBGva8+9y0nOC+dSlfAbWteZAo5kkagb?=
 =?us-ascii?Q?acUP20h1d1nH7jUt9d8my6fKNCFy6F/zQFhHfRD19JvWHs4Qu5qgusg9RAHf?=
 =?us-ascii?Q?w9TfXC22oZKsYykpjUF1ZRkhW3bM0W4QsFCJ089J/hLntaDPF7nJbBQ+ZQoa?=
 =?us-ascii?Q?ahlwXz5084HUQdenX7Imc67M9H6K6DZU28ReeE/lrWgKiIuywvSxlFBJ7XGD?=
 =?us-ascii?Q?I5FaxDyVyIVSYtRl0Xr9/pfii+CMW++UMzVypbtLbT7IK2RE5CH2id4+ucIF?=
 =?us-ascii?Q?TCWvAK3sIVljxVmskHDNPepewSThpHFOGqdOj+tshDjqgmJ8QajJn/sJLfwU?=
 =?us-ascii?Q?ISq2oIk1h50PC7uBHSX9O67S28yMtg6rxvOw9+dOT9HQMbsC+Ykd0fJP0QhA?=
 =?us-ascii?Q?juW+6T7S9dV4rXinLpfWkEJhIpchbBJQ+0s46zlpqrZqWPbTOEpZrE8zrM4r?=
 =?us-ascii?Q?zjwvTSNlbW9+vvO7jviwCETg9s75ZDkK6Xw4Bn/jH7IlZzCNe6xA3vCNCzOY?=
 =?us-ascii?Q?IvQk9j74Y4VVlg1p82AEChiaJZIatdIGITL+ritd8MS19VS7+pBxN9bd/5qV?=
 =?us-ascii?Q?l9PwjKTycHiuwohMzs1uWCyppZMO825SQP1HUZmu+0KH9C/TK5yXVVmlKAhy?=
 =?us-ascii?Q?erGZLMe0pxOXYZ3Ur5JDwXglP3HFA3VUpVtqsWSoyYuf0Yh8hr78DfI38mpt?=
 =?us-ascii?Q?hEiQg4dRVJ6QOeDVUdeOy4NhfgVunt5J08/QAFNCA/B6Eo1lobq1r43g+Xo2?=
 =?us-ascii?Q?ctV6Et6FlsXDYuLiZcYXU4Mr8fYYTkm7+SdyY3gaVpJsU4unge6i1W8c8ZmI?=
 =?us-ascii?Q?ws4nJEzTQpPq48dUGGjViGkTSnkIGr3GTMEjdp6dyUfzjZo9hbIsaQLVEZh6?=
 =?us-ascii?Q?lnyL2A+QPLl+iZ6LAB7WhJG2/ezAT5NwiMOewGMXizaUxHhXhUBvK7fXpKrN?=
 =?us-ascii?Q?hu0MUkz1XC5Udh1LqjuMFv26ciEeZer5spPaIax/73TwFZvye1wGjUYt3iXv?=
 =?us-ascii?Q?UfxZdD/aoE5bD9FdAL2z+78AbQGa7R2tz7fh7iOM+RPmmFJonUbMEvrG5ETn?=
 =?us-ascii?Q?pnUSKywrUWITjA8RcnoqZ9fDuo1++nCNnNoOZlSDIb/Uxw8Zkw1iGUmx1tdp?=
 =?us-ascii?Q?HsvDSZ2M7mymLlmsJEYjZnmXkOZGAsKSbIphIx79ORRKzaFOrNFFyeKlI9gW?=
 =?us-ascii?Q?68OssGV3X2VFJuGyYQvNxaTGfIIrKMeHr293LqVj2h+2HQSsXaqVPrT8g643?=
 =?us-ascii?Q?HE1zUviuZvhhdG/xlUBDvLcg0/4VqXWMvkVLlgFcRdJMdkakLiUBTQhRRdOV?=
 =?us-ascii?Q?GcI1asELPp4X++d5ikvHH1nxcDcT2CG1ir+8Qdfaas+Fqanpp9tKiOgO2PdO?=
 =?us-ascii?Q?QRKJas/6+Yi6moKCFOtjMjT+Mv54igt9yR7gpKTd65IigXx3C0soaW4h6Rny?=
 =?us-ascii?Q?vuyoFHkEwHegla1/U9cI9yvNBs7v41QskhYTLdMw3bM1CClCmrwMYALkQtUR?=
 =?us-ascii?Q?Q+pveSvRrBb43rD+Ujs0hk039cZgrQWvkCllTpWKpTR+6NPdcp2ck2mfRH5s?=
 =?us-ascii?Q?TB5xNc2VN9IP9Yw6LG6Hbo37jk9T1AWO3Vq+ixJCEg2KQlu/e9Hh?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 493a86cb-bf94-4b3e-ab3e-08de90a663df
X-MS-Exchange-CrossTenant-AuthSource: ZQ0PR01MB1208.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2026 10:55:44.9580
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9oNn33z7B/3L89oZRGd3H1pjkYlk8FJkMqEvIRLvW0qVmN706zcp+QcbzREyQua3F+RBOC5vsULhsqnglUx026/+WE4Xd1ptDs7lmYn82VE1LkpTulvA8NEB87+6eHFt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ0PR01MB1096
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
	GREYLIST(0.00)[pass,body];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-274493-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[24];
	FROM_HAS_DN(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.915];
	FROM_NEQ_ENVFROM(0.00)[changhuang.liang@starfivetech.com,netdev@vger.kernel.org];
	TAGGED_RCPT(0.00)[netdev,dt];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,starfivetech.com:email,starfivetech.com:mid,canonical.com:email]
X-Rspamd-Queue-Id: 76E50388A76
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Sia Jee Heng <jeeheng.sia@starfivetech.com>

StarFive JHB100 shares a similar clock and reset design with JH7110.
To facilitate the reuse of the file and its functionalities, files
containing the "jh71x0" naming convention are renamed to use the
"common" wording.

Signed-off-by: Sia Jee Heng <jeeheng.sia@starfivetech.com>
Reviewed-by: Ley Foon Tan <leyfoon.tan@starfivetech.com>
Reviewed-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>
Signed-off-by: Changhuang Liang <changhuang.liang@starfivetech.com>
---
 drivers/clk/starfive/Kconfig                              | 8 ++++----
 drivers/clk/starfive/Makefile                             | 2 +-
 .../{clk-starfive-jh71x0.c => clk-starfive-common.c}      | 4 ++--
 .../{clk-starfive-jh71x0.h => clk-starfive-common.h}      | 4 ++--
 drivers/clk/starfive/clk-starfive-jh7100-audio.c          | 2 +-
 drivers/clk/starfive/clk-starfive-jh7100.c                | 2 +-
 drivers/clk/starfive/clk-starfive-jh7110.h                | 2 +-
 7 files changed, 12 insertions(+), 12 deletions(-)
 rename drivers/clk/starfive/{clk-starfive-jh71x0.c => clk-starfive-common.c} (99%)
 rename drivers/clk/starfive/{clk-starfive-jh71x0.h => clk-starfive-common.h} (98%)

diff --git a/drivers/clk/starfive/Kconfig b/drivers/clk/starfive/Kconfig
index bd29358ffeec..ff8eace36e64 100644
--- a/drivers/clk/starfive/Kconfig
+++ b/drivers/clk/starfive/Kconfig
@@ -1,12 +1,12 @@
 # SPDX-License-Identifier: GPL-2.0
 
-config CLK_STARFIVE_JH71X0
+config CLK_STARFIVE_COMMON
 	bool
 
 config CLK_STARFIVE_JH7100
 	bool "StarFive JH7100 clock support"
 	depends on ARCH_STARFIVE || COMPILE_TEST
-	select CLK_STARFIVE_JH71X0
+	select CLK_STARFIVE_COMMON
 	default ARCH_STARFIVE
 	help
 	  Say yes here to support the clock controller on the StarFive JH7100
@@ -15,7 +15,7 @@ config CLK_STARFIVE_JH7100
 config CLK_STARFIVE_JH7100_AUDIO
 	tristate "StarFive JH7100 audio clock support"
 	depends on CLK_STARFIVE_JH7100
-	select CLK_STARFIVE_JH71X0
+	select CLK_STARFIVE_COMMON
 	default m if ARCH_STARFIVE
 	help
 	  Say Y or M here to support the audio clocks on the StarFive JH7100
@@ -33,7 +33,7 @@ config CLK_STARFIVE_JH7110_SYS
 	bool "StarFive JH7110 system clock support"
 	depends on ARCH_STARFIVE || COMPILE_TEST
 	select AUXILIARY_BUS
-	select CLK_STARFIVE_JH71X0
+	select CLK_STARFIVE_COMMON
 	select RESET_STARFIVE_JH7110 if RESET_CONTROLLER
 	select CLK_STARFIVE_JH7110_PLL
 	default ARCH_STARFIVE
diff --git a/drivers/clk/starfive/Makefile b/drivers/clk/starfive/Makefile
index 199ac0f37a2f..012f7ee83f8e 100644
--- a/drivers/clk/starfive/Makefile
+++ b/drivers/clk/starfive/Makefile
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
-obj-$(CONFIG_CLK_STARFIVE_JH71X0)	+= clk-starfive-jh71x0.o
+obj-$(CONFIG_CLK_STARFIVE_COMMON)	+= clk-starfive-common.o
 
 obj-$(CONFIG_CLK_STARFIVE_JH7100)	+= clk-starfive-jh7100.o
 obj-$(CONFIG_CLK_STARFIVE_JH7100_AUDIO)	+= clk-starfive-jh7100-audio.o
diff --git a/drivers/clk/starfive/clk-starfive-jh71x0.c b/drivers/clk/starfive/clk-starfive-common.c
similarity index 99%
rename from drivers/clk/starfive/clk-starfive-jh71x0.c
rename to drivers/clk/starfive/clk-starfive-common.c
index 80e9157347eb..4aecb65e9fd7 100644
--- a/drivers/clk/starfive/clk-starfive-jh71x0.c
+++ b/drivers/clk/starfive/clk-starfive-common.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * StarFive JH71X0 Clock Generator Driver
+ * StarFive Clock Generator Driver
  *
  * Copyright (C) 2021-2022 Emil Renner Berthing <kernel@esmil.dk>
  */
@@ -10,7 +10,7 @@
 #include <linux/device.h>
 #include <linux/io.h>
 
-#include "clk-starfive-jh71x0.h"
+#include "clk-starfive-common.h"
 
 static struct jh71x0_clk *jh71x0_clk_from(struct clk_hw *hw)
 {
diff --git a/drivers/clk/starfive/clk-starfive-jh71x0.h b/drivers/clk/starfive/clk-starfive-common.h
similarity index 98%
rename from drivers/clk/starfive/clk-starfive-jh71x0.h
rename to drivers/clk/starfive/clk-starfive-common.h
index 9d5dec1d5cd1..f634c62c196a 100644
--- a/drivers/clk/starfive/clk-starfive-jh71x0.h
+++ b/drivers/clk/starfive/clk-starfive-common.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-#ifndef __CLK_STARFIVE_JH71X0_H
-#define __CLK_STARFIVE_JH71X0_H
+#ifndef __CLK_STARFIVE_COMMON_H
+#define __CLK_STARFIVE_COMMON_H
 
 #include <linux/bits.h>
 #include <linux/clk-provider.h>
diff --git a/drivers/clk/starfive/clk-starfive-jh7100-audio.c b/drivers/clk/starfive/clk-starfive-jh7100-audio.c
index 7de23f6749aa..4505d309f664 100644
--- a/drivers/clk/starfive/clk-starfive-jh7100-audio.c
+++ b/drivers/clk/starfive/clk-starfive-jh7100-audio.c
@@ -15,7 +15,7 @@
 
 #include <dt-bindings/clock/starfive-jh7100-audio.h>
 
-#include "clk-starfive-jh71x0.h"
+#include "clk-starfive-common.h"
 
 /* external clocks */
 #define JH7100_AUDCLK_AUDIO_SRC			(JH7100_AUDCLK_END + 0)
diff --git a/drivers/clk/starfive/clk-starfive-jh7100.c b/drivers/clk/starfive/clk-starfive-jh7100.c
index 03f6f26a15d8..bf82190b9c57 100644
--- a/drivers/clk/starfive/clk-starfive-jh7100.c
+++ b/drivers/clk/starfive/clk-starfive-jh7100.c
@@ -15,7 +15,7 @@
 
 #include <dt-bindings/clock/starfive-jh7100.h>
 
-#include "clk-starfive-jh71x0.h"
+#include "clk-starfive-common.h"
 
 /* external clocks */
 #define JH7100_CLK_OSC_SYS		(JH7100_CLK_END + 0)
diff --git a/drivers/clk/starfive/clk-starfive-jh7110.h b/drivers/clk/starfive/clk-starfive-jh7110.h
index 0659adae4d76..6b1bdf860f00 100644
--- a/drivers/clk/starfive/clk-starfive-jh7110.h
+++ b/drivers/clk/starfive/clk-starfive-jh7110.h
@@ -2,7 +2,7 @@
 #ifndef __CLK_STARFIVE_JH7110_H
 #define __CLK_STARFIVE_JH7110_H
 
-#include "clk-starfive-jh71x0.h"
+#include "clk-starfive-common.h"
 
 /* top clocks of ISP/VOUT domain from JH7110 SYSCRG */
 struct jh7110_top_sysclk {
-- 
2.25.1


