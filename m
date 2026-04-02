Return-Path: <netdev+bounces-274551-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KKT9MExxzmkhnwYAu9opvQ
	(envelope-from <netdev+bounces-274551-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 15:38:20 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 725D8389DC8
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 15:38:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4B1B0314660C
	for <lists+netdev@lfdr.de>; Thu,  2 Apr 2026 13:31:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA7AA2ECE9B;
	Thu,  2 Apr 2026 13:31:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2119.outbound.protection.partner.outlook.cn [139.219.146.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1E731482E8;
	Thu,  2 Apr 2026 13:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.119
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775136664; cv=fail; b=MyFaqX4AESZGN6wbNOCTjIv9V0o2dZe0vTZd/tXdSdrglP9R2jDv9+Eq1HB/D5KsF5UnwSSxQI9PzZjKmJt1wxZI5XkJBODb12M0Qqn9j+9lttNvb4bkbit73iVB1VDLcqxz98tX0hfBeX1z95P//l3QP82zVqTVoBA7xrF6UU4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775136664; c=relaxed/simple;
	bh=8zJ0RnKrA1PPupO3N9yXQirItlI7djxSgsvNpfltmGU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qE7y5lZynn2jcoW2p9FYMniIDQ9dU9kG/aL9C5vlZtgHQ5xg3ccJmb5DextXa/MDj118MTt4cdrzZcn/JU5Xq2DI5BoWQ12EFvp+/3nlDELq9pbE+6iULXX7idEVEgB/VP0uM9dY8LFKDk7RmfqTnC9sMV8zpj0QhSzPzi9t1v4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PNtg1Uy3WNu1IPIUQuw+Qo/sRtH2ajh9t4EbF6K+4/26/CMnfvno4HnxJXuYwitnneRBiySzLJYnrURH/sUIdONlYnkyAFLVjQ1FYu2KxzDz+YwOP2Eq6uo5kwxAgGuiwZ2Nkf2S/0j4I3j9FQi7MPtqVhcCyURqyUAEotyL3CZgzI/2beoboakK6ovOSmJzTejJwc2MMo4/lNLw5WrN3FlSyHpA108c6hd7D5dWOGCote7NaiE852dc4F9mWvzln24YJ3CEg5lrNiaRJDffL93KMEX/DZXGyAHZppND7xeYmMxJxumDB+Bx8i8z2G/GO+LBubkd8yMiJX3c7eBB3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TbGDvV1DEueI5PIi4sScH6J/etUCw+F/q+btASnfeIk=;
 b=XJ1HeMpglknM8FJ0OAJLInRf8ZxE8m/g8nWcT3aCkJ/P0Eymv6E/ln910Wul/JDDMuKk9ggIrFgRtwjibfM43HK8DEIx+OC6ARF6VxhkUkr11EersZbohCKwPb7wq/EiTJBA0FpaEVyWIN9nymMiMCu00nQbapZi86zCLF47JLWB95bF7/MnBvwBOuUZpC/H4L09OqMbDmWjk+ZM7tcs4+GGu2JuMaRazXii3uK/r2pXPLHiKisrDzqcl51C9MJn8xrs5XTm+UgOqRNLgv5JsdkY09gkeCDe9TLKeLb4AOkNXePecciFaUv3BByJfNoRFOQxFH4BkJ01BB6eSs9TeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ0PR01MB1208.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:19::5) by ZQ0PR01MB1096.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:c::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.20; Thu, 2 Apr
 2026 10:55:55 +0000
Received: from ZQ0PR01MB1208.CHNPR01.prod.partner.outlook.cn
 ([fe80::63d1:b688:cab7:50cb]) by
 ZQ0PR01MB1208.CHNPR01.prod.partner.outlook.cn ([fe80::63d1:b688:cab7:50cb%7])
 with mapi id 15.20.9769.017; Thu, 2 Apr 2026 10:55:55 +0000
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
Subject: [PATCH v1 07/22] dt-bindings: clock: Add StarFive JHB100 System-1 clock and reset generator
Date: Thu,  2 Apr 2026 03:55:08 -0700
Message-Id: <20260402105523.447523-8-changhuang.liang@starfivetech.com>
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
X-MS-Office365-Filtering-Correlation-Id: dd9ac590-572b-45f4-cb2f-08de90a66a5c
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|52116014|376014|366016|921020|38350700014|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	+Y+8VJkXQbmwroVwdJsCCHqFX3LR5OegEZrcjiwy/FJ+x+UyFVx1aIxglv1/v1YHsr6AgczuDi/3GrbE4kV60ZGKaWZv5uMwQqkXwUCY9r35Qldp12B2/pT2i/eatb5iEhVh3jVwOj5ixCJm57XXPigZDFvfhoye9rviy45SXGxGfhlPpMNb6dVMX02FI6WdKTQA9fZDr4B2IT3fL9Y5RCX8tOUWzuAIB9MW7dpEyceGfuetbRifoHbywKdfW3qoN7zT9awaKS23mMkYTUcout8VIN/U2QJO9941fjJ0NjfbTicVsgH57+K8zKQKWuBdBFIdloZO3oEze2dGMlWyRFQhBWEisF7WnLRXJGHzl0qjv39307PJ5xOeYkaeMX8w0vdWdc/dvO2jrhjZP11znqNtJNtygnceN8VMC3ZRMIKcTejEuuBinRe5s9ibAd/M/QdSE7NzNhhRdn9kBtwvEwgAChN1aWYaNoBYvj/c3u3e1iYvqC28FDapHH058keMpEebxugRljIFx03IEuxN4bsnlcCnMbg6LuzQenw3bR+bTISavZgZwusL/01n8xIuGSAZQA1TfQ2n9zp4CDPqcuf/3Mugy7+hMQ6eyhHDcmk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ0PR01MB1208.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(52116014)(376014)(366016)(921020)(38350700014)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?sgRhSE4HIo+uqlOh6NgzmSmnirUg7KpBsv3juPlz1fVGqdtiuxaJCcFEIrf+?=
 =?us-ascii?Q?eBv3RqZ/c7KZtDf9f61/pMwLr3BLZJTc1qtkqH9W8hsjA8rd6AQvCga3Ydm6?=
 =?us-ascii?Q?vVsS7Bg2aJhA7Z9Pwd08oYz9uh8AlGjls2e+vCl2W+tF9a9Tix0pEfscDCmZ?=
 =?us-ascii?Q?Uzq56XRDyOFn+IGhwCZEd1gbKVlU6ODugRcYyTeiXgvvOkxtnmxQEZLWoCW/?=
 =?us-ascii?Q?4jBWl6krXqflryj054ROuDfwMm8MAdv4eBzE4j4M5h4Gm1O2weto8iXOM+nh?=
 =?us-ascii?Q?jh2K1gPWiTGBmbLSVMzEc6/6gwMC3mhizfsx2lg0epfrSvARhxV5W+MCgGY+?=
 =?us-ascii?Q?yhXWMHKxbZTEvTJTz3dR0/f0AQZttWOyq6xEeWOaQUhMkJWxQh25FilAvw42?=
 =?us-ascii?Q?u81JP/sI0I2si4fDSir8b/iFm4MTk+wDe8/ExSKqjdj3qRAHUj+CjbhCAC75?=
 =?us-ascii?Q?brFQnfPm5MmdHivDPRwufkEhfLBiIj5il6/NJ1jOyy6gWcSu0WP4gmQgFyae?=
 =?us-ascii?Q?RE8G65EdI/35XmzgpwQ8iHnStOUUKykub7foltOpvqL0OhfLCtpVObQacO0H?=
 =?us-ascii?Q?YvtXO5I6Xd5DBFuB7AGpzx12LI6xYZ/QXwjTVQvxuR/EWpRwBXjfwHllxPTa?=
 =?us-ascii?Q?TeNxOwwp/16qI6X1YlreKkbrbFMJfIbMSnCmiPA45AgWTAONr8jxRgQWsM9J?=
 =?us-ascii?Q?dDesMc+HhSo9QpMIqKW9OEx8cLMnhU8bAGXgO9nvv8NVOgRUotomeE63o8PG?=
 =?us-ascii?Q?LWFkHZ+tvfepkODZtUpUNrosJsZ/d+dbxTAY5hPgyA+IrrNxAA7KD8RwFVgB?=
 =?us-ascii?Q?QHK/Gm3emZElqn2GvKgyue/LCVuAmuSE9TE49ugLSrLyy+N5xWlgS6MRzoK9?=
 =?us-ascii?Q?ut0w7lfU+GP1eI2NACN5ypAhCVKNPRy8gmaWqVItIFgeewR3u0eM6NM27IBI?=
 =?us-ascii?Q?6VTuYdJADRWI7V4FI7nXPjZOHiQiIO1ou1gbU2E1RZ3MhOLLDhI+MCgEk3V/?=
 =?us-ascii?Q?o/6Sr2k8Ekeuzn8zjOT+eC0gN8s7eiisrf/o6R5+HtFUn6ikegZpN+1H6iCx?=
 =?us-ascii?Q?jU5vz+FgUkYXRGsaRQxv8MwQZ1eVKUeBYNKrx3YMJNsRpAdi7rvMZnvZsEZJ?=
 =?us-ascii?Q?Abw6hjDrWO8fvgJtzkbV3DpWUsOejdr3dZf6ZdMO/hJZgFu0owYbWQqqObKm?=
 =?us-ascii?Q?+AvfApYIBprrYdzKnGvOF9j+dpk35jHailJ9X/TULp5Ct+LJKLaTbcWftmA4?=
 =?us-ascii?Q?cdaCexpClWw9KskdIQcqE673tLmETzXRGrjztGWZ6CJBc8jvOySTwnKjU5z0?=
 =?us-ascii?Q?9/A2nQNbHO1aVhLizqODeTEd2uOr1FMMl+EGZFAa2ZblGA5eclQjgBMZC/C5?=
 =?us-ascii?Q?VnC9fsoOk4+lhR+OopDm7ywzaZd7MSPzlCcxYMMqQss1Q8vuNDbtKVebapVF?=
 =?us-ascii?Q?nZyZupgvOSSnvCfpVYoG6SpBaTeRSR/oJXR6hO7CN8kFTZ5e6Cygy2zfO9Q8?=
 =?us-ascii?Q?zIN3nNOrGOW67l9+85K9WQ/4BL/lGaDE42CCJyMXM9Z8bip1pBTlYYndXpCo?=
 =?us-ascii?Q?MTFuSJIl1u40sq+cj0uc8dC90pjtUzvRsz9VZ2QHlUgRt8KoC6/p6gvtIUKE?=
 =?us-ascii?Q?3EiTATJZNJt087Ch4RzBGGoxXJrhv4om9mzOKn81fNE7anrDVK7FmTE5sU9e?=
 =?us-ascii?Q?K2PriPM3ewYxX+HBpoEWTdq40nhwFZOPkSTIMBC9JAJycalVVGHwSDa91UFs?=
 =?us-ascii?Q?ISNn4nT/rMaU7xNfzfxlB9fNXHexYHU4ayzCnhE4I8/xyuun39NF?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd9ac590-572b-45f4-cb2f-08de90a66a5c
X-MS-Exchange-CrossTenant-AuthSource: ZQ0PR01MB1208.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2026 10:55:55.8037
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fbJssAb9ZV1BQSKkP/jI2IF1NnJ/TgntpcxZ+vRf3wA38WUUGCTz8WwCAo6iWOu5C48GNQXJl7suG7WZkZtwG1nNn+VG00RusXrtIMH1y89brRDrZJ2MVOBtfyKchCTf
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
	TAGGED_FROM(0.00)[bounces-274551-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[24];
	FROM_HAS_DN(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.626];
	FROM_NEQ_ENVFROM(0.00)[changhuang.liang@starfivetech.com,netdev@vger.kernel.org];
	TAGGED_RCPT(0.00)[netdev,dt];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[0.198.108.224:email,devicetree.org:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 725D8389DC8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add bindings for the System-1 clocks and reset generator (SYS1CRG) on
JHB100 SoC.

Signed-off-by: Changhuang Liang <changhuang.liang@starfivetech.com>
---
 .../clock/starfive,jhb100-sys1crg.yaml        | 71 +++++++++++++++++++
 .../dt-bindings/clock/starfive,jhb100-crg.h   | 20 ++++++
 .../dt-bindings/reset/starfive,jhb100-crg.h   | 13 ++++
 3 files changed, 104 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/starfive,jhb100-sys1crg.yaml

diff --git a/Documentation/devicetree/bindings/clock/starfive,jhb100-sys1crg.yaml b/Documentation/devicetree/bindings/clock/starfive,jhb100-sys1crg.yaml
new file mode 100644
index 000000000000..0cfeb8400b58
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/starfive,jhb100-sys1crg.yaml
@@ -0,0 +1,71 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/starfive,jhb100-sys1crg.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: StarFive JHB100 System-1 Clock and Reset Generator
+
+maintainers:
+  - Changhuang Liang <changhuang.liang@starfivetech.com>
+
+properties:
+  compatible:
+    const: starfive,jhb100-sys1crg
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    items:
+      - description: Main Oscillator (25 MHz)
+      - description: PLL0
+      - description: PLL1
+      - description: PLL2
+      - description: PLL4
+      - description: PLL5
+      - description: System-1 NPU 600MHz
+
+  clock-names:
+    items:
+      - const: osc
+      - const: pll0
+      - const: pll1
+      - const: pll2
+      - const: pll4
+      - const: pll5
+      - const: sys1_npu_600
+
+  '#clock-cells':
+    const: 1
+    description:
+      See <dt-bindings/clock/starfive,jhb100-crg.h> for valid indices.
+
+  '#reset-cells':
+    const: 1
+    description:
+      See <dt-bindings/reset/starfive-jhb100-crg.h> for valid indices.
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+  - '#clock-cells'
+  - '#reset-cells'
+
+additionalProperties: false
+
+examples:
+  - |
+    clock-controller@13004000 {
+      compatible = "starfive,jhb100-sys1crg";
+      reg = <0x13004000 0x4000>;
+      clocks = <&osc>, <&pll0>, <&pll1>,
+               <&syspll 0>, <&syspll 2>,
+               <&syspll 3>, <&sys0crg 61>;
+      clock-names = "osc", "pll0", "pll1", "pll2",
+                    "pll4", "pll5", "sys1_npu_600";
+      #clock-cells = <1>;
+      #reset-cells = <1>;
+    };
diff --git a/include/dt-bindings/clock/starfive,jhb100-crg.h b/include/dt-bindings/clock/starfive,jhb100-crg.h
index b257cd104a10..510a5c6fa89a 100644
--- a/include/dt-bindings/clock/starfive,jhb100-crg.h
+++ b/include/dt-bindings/clock/starfive,jhb100-crg.h
@@ -53,4 +53,24 @@
 #define JHB100_SYS0CLK_GPU0_600				73
 #define JHB100_SYS0CLK_GPU1_600				74
 
+/* SYS1CRG clocks */
+#define JHB100_SYS1CLK_APB_MAIN_SYS1			0
+#define JHB100_SYS1CLK_APB_SENSOR_ICG_BUF		1
+
+#define JHB100_SYS1CLK_GPIO_ESPI1_66			5
+
+#define JHB100_SYS1CLK_HOSTSS1_100			7
+#define JHB100_SYS1CLK_HOSTSS1_PHY_SCAN_1000_ICG_BUF	8
+#define JHB100_SYS1CLK_NPU_200				9
+#define JHB100_SYS1CLK_NPU_CORE_DIV			10
+#define JHB100_SYS1CLK_DOM_NPU_CORE_CLK			11
+#define JHB100_SYS1CLK_DOM_NPU_BUS_CLK			12
+#define JHB100_SYS1CLK_DOM_NPU_INIT_CLK			13
+#define JHB100_SYS1CLK_DOM_NPU_OSC_CLK			14
+#define JHB100_SYS1CLK_VOUT_100				15
+#define JHB100_SYS1CLK_VOUT_PIX0			16
+#define JHB100_SYS1CLK_VOUT_PIX1			17
+#define JHB100_SYS1CLK_BMCPER3_100			18
+#define JHB100_SYS1CLK_BMCPER3_125			19
+
 #endif /* __DT_BINDINGS_CLOCK_STARFIVE_JHB100_H__ */
diff --git a/include/dt-bindings/reset/starfive,jhb100-crg.h b/include/dt-bindings/reset/starfive,jhb100-crg.h
index 71affdcdf733..9a0ab64abafa 100644
--- a/include/dt-bindings/reset/starfive,jhb100-crg.h
+++ b/include/dt-bindings/reset/starfive,jhb100-crg.h
@@ -27,4 +27,17 @@
 #define JHB100_SYS0RST_BMCUSB_RSTN_BUS					23
 #define JHB100_SYS0RST_BMCUSB_RSTN_CRG					24
 
+/* SYS1CRG resets */
+#define JHB100_SYS1RST_SYS1_IOMUX_PRESETN				1
+
+#define JHB100_SYS1RST_MAIN_RSTN_CHIPTOP_SENSOR				5
+
+#define JHB100_SYS1RST_VOUT_RSTN_HOST0					8
+#define JHB100_SYS1RST_VOUT_RSTN_HOST1					9
+#define JHB100_SYS1RST_HOSTSS1_RSTN_BUS_ESPI				10
+#define JHB100_SYS1RST_HOSTSS1_RSTN_BUS_PCIE				11
+#define JHB100_SYS1RST_HOSTSS1_RSTN_CRG					12
+#define JHB100_SYS1RST_BMCPERIPH3_RSTN_CRG				13
+#define JHB100_SYS1RST_BMCPERIPH3_RSTN_BUS				14
+
 #endif /* __DT_BINDINGS_RESET_STARFIVE_JHB100_CRG_H__ */
-- 
2.25.1


