Return-Path: <netdev+bounces-274470-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QHecKS5QzmmjmgYAu9opvQ
	(envelope-from <netdev+bounces-274470-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 13:17:02 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 05290388340
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 13:17:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4DB2E3007E16
	for <lists+netdev@lfdr.de>; Thu,  2 Apr 2026 11:10:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CE2639E19C;
	Thu,  2 Apr 2026 11:10:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2119.outbound.protection.partner.outlook.cn [139.219.17.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8BBF31283E;
	Thu,  2 Apr 2026 11:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.119
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775128210; cv=fail; b=gpyTHcxIRSEex4zzdT2FOOhEz7vVLCZtMYP5+lHTIFfnJhyW0muGTXbBenjKYxjXRiPozzEDVADkbZgJV9d1dQsRpfsufapqMr6pNXupR72C9PHBILCgnYnoJviF9lh2cQ9L4Z12roe9wXdTYM3iFVy5wfyum5ZvHX6ocEXooYI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775128210; c=relaxed/simple;
	bh=rFuT2zhr26c9cj9Ivbo278KvB0wFWcP1j3atuAjYY84=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gaQReXT6C9XUnPjHOc88ZlsZK++q2s8Qzx7OLYmLNGrPPs/JmqdJQEvL+ensJfVI5ZRVxLxFJWyzujEgKY+FU+zDXhhehykHZpWyAhlb9DCADZMSjs2C/TWsU1HLa2lEDqQZpXegQxP8GZW7bC8enJYLKH+V1pJZaTNmKc+AMeU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ax4J84EG52gb3vC5Bb8XlVyqNPEs/3CLPK/UQ0L0iurVdaoCz3ga47oJfGVtA1CGh9nJ0SN9u6I5vX36T3QbdxmxLx58oFKExX1hSnV5yoqLcxdVQEVabDnl41S0hU46hdo6QWFs0CjbL3PiR7cjwSTMhVRGscK/3TBntSr9Jorm0XSScTRywwqE36Rg6n+Nz/gBqWii10PD20uRjh2Hrb+1ZfqY882Z1WEtYrfic3Rpu6sPlhtB/e8KQOvvB6fAYOpl4sEMcvKZECkcnJrpXCADmVcEFX90FYOyQl7SmI/xpRsHBSa3lRpaDSI8+8Ab+kX5inClaO5g/CfGMKlL9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DKYhONsjjCPjvcgI9a6Eumr+0laaJvIfwRXxF+oP7TI=;
 b=SdbyUd1OiXiPdXyehG53Pl7zDBvOWDh+ij03aqr31NmW2k8+841vIU5+9oAOwQzhNdf4siQDXcDZ6lNrpsziaxjpaILkaIOXxqJ4ES4aslYi5bOrAcI0sKGJ2IBbSfzewNjEkyp2mP3gkqqgVQrtVzbKbvIQuuB/vv847Ebt43fItewxzNlNF2XAZqKSw53HweMwNbX5xGsVWVoIWNud5Jwa5tkceqngJR75eKK3Wnh3/H/F1HnXSmTj7ZZtiUWQ2rySP7Sz2FD+pF+OYbFaH66gn4pFKLr0SxxP0w4ri/wdHWS0ivsICRzcWUNAs0qhZ22bxPTv840a4pZ2/ME1TQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ0PR01MB1208.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:19::5) by ZQ0PR01MB0951.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:e::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.19; Thu, 2 Apr
 2026 10:55:42 +0000
Received: from ZQ0PR01MB1208.CHNPR01.prod.partner.outlook.cn
 ([fe80::63d1:b688:cab7:50cb]) by
 ZQ0PR01MB1208.CHNPR01.prod.partner.outlook.cn ([fe80::63d1:b688:cab7:50cb%7])
 with mapi id 15.20.9769.017; Thu, 2 Apr 2026 10:55:42 +0000
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
Subject: [PATCH v1 01/22] reset: starfive: Rename file name "jh71x0" to "common"
Date: Thu,  2 Apr 2026 03:55:02 -0700
Message-Id: <20260402105523.447523-2-changhuang.liang@starfivetech.com>
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
X-MS-TrafficTypeDiagnostic: ZQ0PR01MB1208:EE_|ZQ0PR01MB0951:EE_
X-MS-Office365-Filtering-Correlation-Id: c281e2a0-6a27-4031-5abe-08de90a6610a
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|7416014|38350700014|921020|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	ik//7JKFLVRoVbCoKCTRqpempKBgM3FTza5uSV669JvNLAaIuogloz3ybl1qvc8LK+Qx9GCEQv5Ksi22PCAcCh4B52fsmwBsVNhGBzZ8Onmgd5wUtYYtZiOkGQbd7FyY/6ucVboNxcjeZG21O2nD83uEpOeXXg0wWK3Yeg1qNfBROkEmt0mzBZHag07Q547CIXHztiW/AeM0SjCJqB29561d1OpBRzPcJfnzHIQJlNORK1CNSQAlLCFbnaCRdY/tfybm78D+FRNHai+ws3gvmpa3S+bkK7+O1IlrEuGEG+iYdxZ35916CCWWVtw1RnPq1sNI8lV44Fq6+7p/dUI1SO6xFVjfOq5zhuI4qVDjK40ujWGaZoaLrNUhOlnjj+VkvhFfPBWgQrmHm8/RpOiYW0zBBs1ogtnohIHw/iq2LSoX/JUr83Z/4JgbAmjorS73UL6cZuvXaieQPekCqH4ntWB22t5EL+p56BR7BgqFShuPfBMo63LgFfd6kQiwC/kq9q8ZSmHMefW6reLQ+12OvVhwf4cmcFe4/AqNK2hCqpHIJRWybmVPgcYuWKUFeU1V8DCjJDBmM5sGsL1pNg1AXUhFYi7EspmMvxYVTWe7oEM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ0PR01MB1208.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(7416014)(38350700014)(921020)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?m1z14quj0Qw+Ss0Ab/L+4TnOa4Wp6yXNCz42+BNLNDYoljKoG7hHb+Q1Dt1+?=
 =?us-ascii?Q?nkrBwbULCHSY5r3gqFc2TswR7EFMnjATHFU8hnHk2vc0/eLV1roFYnp7Crp7?=
 =?us-ascii?Q?+5jX251O2ErsvkFZ2h0UjoZCX/P/hxE8RZYLPaxKdeQ7IKBfh+DFU3jfHXIm?=
 =?us-ascii?Q?ogxXLl9B7khdFpNrCQXnfu2ZQ8sPSyeMyeRafsKBhlKENGMOMTjr+eayc8Mt?=
 =?us-ascii?Q?dBZaPVpHpct9x2RUHHFR1lYQDT4MiWAFZo655ezo1j+yqWRcmjFoxY8eoC1m?=
 =?us-ascii?Q?FKLtMNqpVTKRiJbTgJlICrnsJI61N99CxTOrXdGLAxHZ4dFcXL8ZgcJ5RShi?=
 =?us-ascii?Q?HwEpdhK+Us9s6yEPaK9IlfXZQ8N5mOC7+3mQE7EFsS9R8J3gg8Eu2zSQe2jV?=
 =?us-ascii?Q?FQJR801VEWNuHCdB7xbI1+QXSFBYQDAtkTDqKHieC5SjNzxC4kq1teXRITI7?=
 =?us-ascii?Q?ry4F4k+/nFFoGPGE+egECwvP0kQxqr7nN89v8Vp60Pp119aOyICYSdSBp0hR?=
 =?us-ascii?Q?GgbwClSrfoCIebWSeK3dm8mwQh7KpxrJKAo9Bs+0CYks4IbDrRLnzx0zhj7+?=
 =?us-ascii?Q?iPWKnGd7HXxcidS2RcZJp4OOTuPOYdc+2ZoyxoAGFOHM5O6HU2XiMSj17R2S?=
 =?us-ascii?Q?vHYklKnjRY4rFrLiEy0LOTkA9xvN6++pY68lkDh9VSU06g9Oy8lrVcgsyhIr?=
 =?us-ascii?Q?3RTXLiHHcrvKED7E4coI++7Jn/rXPVUuen243geHVbsanxGhVrQSGTels+8e?=
 =?us-ascii?Q?XCWWgvVblBqVYTF0ee9IVv/saIxTLvowIPD4/U8mHcwEz6Q9fK2Ig5qsmXwP?=
 =?us-ascii?Q?iJVoD3YPhL8cnd7KMlpGtZYfLLwvYN0yYPQ/pPcK3gk6orddG9/a2JvV/7xz?=
 =?us-ascii?Q?zjBAVUeCxZ9P7/a/eFtseAssF0l3Y/vIdnACpNbeAljIHOwGvls7NcHCYeim?=
 =?us-ascii?Q?J2Z8tijkEhsFPuKxIloCyuMJOZm+EQQ6beBHIbyTmJ60H6eHH4bCva4wJbod?=
 =?us-ascii?Q?hWPkBjjG8/q1haK0qqaR1xX8cKm8++hl0IPIIHKnlX+J1SFLMyZ6wOcx/eGT?=
 =?us-ascii?Q?7EsvTyO1Whn4MnB662HL3XafgiYUxUfNilTUAyHIdD5zaQjuU6R4FH+qz8YL?=
 =?us-ascii?Q?keCuRrZisrFhDIBUM5wF/rjjnfrXhs/0/dEqujodITwcz5ruaxpDcXyPMEEe?=
 =?us-ascii?Q?dNROp+jqoAlHtYILt5nGS6PkIZ3AdYdn9/zDIlOEAOEEPTDN8sFnQrEOT3x+?=
 =?us-ascii?Q?fipWmTpJFSR93ZRDL4Q2cgqklUPxMTtV3YOKQcIwdrHB5UL7Ko8Hhtuc5Gow?=
 =?us-ascii?Q?CGR+aBsp4qV1BwwHb5/H8Xk7tt2bdl+xiF6wiw4LEjFB2KGxXG7JWfxADfKA?=
 =?us-ascii?Q?hWxmZxsQIQO3CPzm4tg0eCTpxlC/4H7ANVyMdBMoRtqqf5q6+RIhiOFlMh7f?=
 =?us-ascii?Q?fHWx3utYOPkD9/+QBy8crACFcgTzvbhKrkGFPuQ8hY5obKeuaWmJg+6a1QWm?=
 =?us-ascii?Q?hc3tlMA2fCYV6hKsyyisn4zdD4jz6BYHMidwHNmieOKJhjTQCsd1lMrtjI0b?=
 =?us-ascii?Q?e2zeKS4G3TUVvwjTqMCUpu2BC4VV+1XtNTN1joRg//uF2HdffJ7CR04xPi7x?=
 =?us-ascii?Q?BuA3hJEkPUy/D1ThHQvzd3wSkZ1HnRWuWYV783DuTlrLhHiQdNhfZBeY00LT?=
 =?us-ascii?Q?jja2n15PH7AqRzFB48pU9/r2acgyzrKzjKxvC/czOWzyQfAnPnqLJK9wtQcA?=
 =?us-ascii?Q?USvAxKflTJHXdOdNljkW5Rid3CdK9pJ9PjeOBaSPJdMcsGUli+97?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c281e2a0-6a27-4031-5abe-08de90a6610a
X-MS-Exchange-CrossTenant-AuthSource: ZQ0PR01MB1208.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2026 10:55:41.9779
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uoRMG7knW43ye/eT36mC6IB2tCVqFw8NcLXAyZR5S+OtO2oja4gH+3AFHyNrQHNaM2FVLAgW08snwQiqGrILsdXd2tlaSVXGoZJLXe/G3aaIj+xdbLtd9YvPF+48EgDA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ0PR01MB0951
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
	TAGGED_FROM(0.00)[bounces-274470-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[24];
	FROM_NEQ_ENVFROM(0.00)[changhuang.liang@starfivetech.com,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.914];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[canonical.com:email,starfivetech.com:email,starfivetech.com:mid,esmil.dk:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 05290388340
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
 drivers/clk/starfive/clk-starfive-jh7110-sys.c              | 2 +-
 drivers/reset/starfive/Kconfig                              | 6 +++---
 drivers/reset/starfive/Makefile                             | 2 +-
 .../{reset-starfive-jh71x0.c => reset-starfive-common.c}    | 4 ++--
 .../{reset-starfive-jh71x0.h => reset-starfive-common.h}    | 6 +++---
 drivers/reset/starfive/reset-starfive-jh7100.c              | 2 +-
 drivers/reset/starfive/reset-starfive-jh7110.c              | 4 ++--
 .../{reset-starfive-jh71x0.h => reset-starfive-common.h}    | 4 ++--
 8 files changed, 15 insertions(+), 15 deletions(-)
 rename drivers/reset/starfive/{reset-starfive-jh71x0.c => reset-starfive-common.c} (97%)
 rename drivers/reset/starfive/{reset-starfive-jh71x0.h => reset-starfive-common.h} (75%)
 rename include/soc/starfive/{reset-starfive-jh71x0.h => reset-starfive-common.h} (81%)

diff --git a/drivers/clk/starfive/clk-starfive-jh7110-sys.c b/drivers/clk/starfive/clk-starfive-jh7110-sys.c
index 03c17cd2032f..edf4c45e6ff0 100644
--- a/drivers/clk/starfive/clk-starfive-jh7110-sys.c
+++ b/drivers/clk/starfive/clk-starfive-jh7110-sys.c
@@ -14,7 +14,7 @@
 #include <linux/platform_device.h>
 #include <linux/slab.h>
 
-#include <soc/starfive/reset-starfive-jh71x0.h>
+#include <soc/starfive/reset-starfive-common.h>
 
 #include <dt-bindings/clock/starfive,jh7110-crg.h>
 
diff --git a/drivers/reset/starfive/Kconfig b/drivers/reset/starfive/Kconfig
index d832339f61bc..29fbcf1a7d83 100644
--- a/drivers/reset/starfive/Kconfig
+++ b/drivers/reset/starfive/Kconfig
@@ -1,12 +1,12 @@
 # SPDX-License-Identifier: GPL-2.0-only
 
-config RESET_STARFIVE_JH71X0
+config RESET_STARFIVE_COMMON
 	bool
 
 config RESET_STARFIVE_JH7100
 	bool "StarFive JH7100 Reset Driver"
 	depends on ARCH_STARFIVE || COMPILE_TEST
-	select RESET_STARFIVE_JH71X0
+	select RESET_STARFIVE_COMMON
 	default ARCH_STARFIVE
 	help
 	  This enables the reset controller driver for the StarFive JH7100 SoC.
@@ -15,7 +15,7 @@ config RESET_STARFIVE_JH7110
 	bool "StarFive JH7110 Reset Driver"
 	depends on CLK_STARFIVE_JH7110_SYS
 	select AUXILIARY_BUS
-	select RESET_STARFIVE_JH71X0
+	select RESET_STARFIVE_COMMON
 	default ARCH_STARFIVE
 	help
 	  This enables the reset controller driver for the StarFive JH7110 SoC.
diff --git a/drivers/reset/starfive/Makefile b/drivers/reset/starfive/Makefile
index 7a44b66fb9d5..582e4c160bd4 100644
--- a/drivers/reset/starfive/Makefile
+++ b/drivers/reset/starfive/Makefile
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
-obj-$(CONFIG_RESET_STARFIVE_JH71X0)		+= reset-starfive-jh71x0.o
+obj-$(CONFIG_RESET_STARFIVE_COMMON)		+= reset-starfive-common.o
 
 obj-$(CONFIG_RESET_STARFIVE_JH7100)		+= reset-starfive-jh7100.o
 obj-$(CONFIG_RESET_STARFIVE_JH7110)		+= reset-starfive-jh7110.o
diff --git a/drivers/reset/starfive/reset-starfive-jh71x0.c b/drivers/reset/starfive/reset-starfive-common.c
similarity index 97%
rename from drivers/reset/starfive/reset-starfive-jh71x0.c
rename to drivers/reset/starfive/reset-starfive-common.c
index 29ce3486752f..d615c4a68cc0 100644
--- a/drivers/reset/starfive/reset-starfive-jh71x0.c
+++ b/drivers/reset/starfive/reset-starfive-common.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 /*
- * Reset driver for the StarFive JH71X0 SoCs
+ * Reset driver for the StarFive SoCs
  *
  * Copyright (C) 2021 Emil Renner Berthing <kernel@esmil.dk>
  */
@@ -12,7 +12,7 @@
 #include <linux/reset-controller.h>
 #include <linux/spinlock.h>
 
-#include "reset-starfive-jh71x0.h"
+#include "reset-starfive-common.h"
 
 struct jh71x0_reset {
 	struct reset_controller_dev rcdev;
diff --git a/drivers/reset/starfive/reset-starfive-jh71x0.h b/drivers/reset/starfive/reset-starfive-common.h
similarity index 75%
rename from drivers/reset/starfive/reset-starfive-jh71x0.h
rename to drivers/reset/starfive/reset-starfive-common.h
index db7d39a87f87..266acc4b2caf 100644
--- a/drivers/reset/starfive/reset-starfive-jh71x0.h
+++ b/drivers/reset/starfive/reset-starfive-common.h
@@ -3,12 +3,12 @@
  * Copyright (C) 2021 Emil Renner Berthing <kernel@esmil.dk>
  */
 
-#ifndef __RESET_STARFIVE_JH71X0_H
-#define __RESET_STARFIVE_JH71X0_H
+#ifndef __RESET_STARFIVE_COMMON_H
+#define __RESET_STARFIVE_COMMON_H
 
 int reset_starfive_jh71x0_register(struct device *dev, struct device_node *of_node,
 				   void __iomem *assert, void __iomem *status,
 				   const u32 *asserted, unsigned int nr_resets,
 				   struct module *owner);
 
-#endif /* __RESET_STARFIVE_JH71X0_H */
+#endif /* __RESET_STARFIVE_COMMON_H */
diff --git a/drivers/reset/starfive/reset-starfive-jh7100.c b/drivers/reset/starfive/reset-starfive-jh7100.c
index 2a56f7fd4ba7..546dea2e5811 100644
--- a/drivers/reset/starfive/reset-starfive-jh7100.c
+++ b/drivers/reset/starfive/reset-starfive-jh7100.c
@@ -8,7 +8,7 @@
 #include <linux/mod_devicetable.h>
 #include <linux/platform_device.h>
 
-#include "reset-starfive-jh71x0.h"
+#include "reset-starfive-common.h"
 
 #include <dt-bindings/reset/starfive-jh7100.h>
 
diff --git a/drivers/reset/starfive/reset-starfive-jh7110.c b/drivers/reset/starfive/reset-starfive-jh7110.c
index 29a43f0f2ad6..87dba01491ae 100644
--- a/drivers/reset/starfive/reset-starfive-jh7110.c
+++ b/drivers/reset/starfive/reset-starfive-jh7110.c
@@ -7,9 +7,9 @@
 
 #include <linux/auxiliary_bus.h>
 
-#include <soc/starfive/reset-starfive-jh71x0.h>
+#include <soc/starfive/reset-starfive-common.h>
 
-#include "reset-starfive-jh71x0.h"
+#include "reset-starfive-common.h"
 
 #include <dt-bindings/reset/starfive,jh7110-crg.h>
 
diff --git a/include/soc/starfive/reset-starfive-jh71x0.h b/include/soc/starfive/reset-starfive-common.h
similarity index 81%
rename from include/soc/starfive/reset-starfive-jh71x0.h
rename to include/soc/starfive/reset-starfive-common.h
index 47b486ececc5..56d8f413cf18 100644
--- a/include/soc/starfive/reset-starfive-jh71x0.h
+++ b/include/soc/starfive/reset-starfive-common.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-#ifndef __SOC_STARFIVE_RESET_JH71X0_H
-#define __SOC_STARFIVE_RESET_JH71X0_H
+#ifndef __SOC_STARFIVE_RESET_COMMON_H
+#define __SOC_STARFIVE_RESET_COMMON_H
 
 #include <linux/auxiliary_bus.h>
 #include <linux/compiler_types.h>
-- 
2.25.1


