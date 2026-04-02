Return-Path: <netdev+bounces-274479-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qL7PD5pXzmnrmwYAu9opvQ
	(envelope-from <netdev+bounces-274479-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 13:48:42 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A82F53888DF
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 13:48:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7755C304B812
	for <lists+netdev@lfdr.de>; Thu,  2 Apr 2026 11:12:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D6FD3B894B;
	Thu,  2 Apr 2026 11:12:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2123.outbound.protection.partner.outlook.cn [139.219.17.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDBB23845CA;
	Thu,  2 Apr 2026 11:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.123
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775128372; cv=fail; b=gEW++/Tiqb/vh4De3aODF6yLFCMuudI19MbU8e2K8AddNaW+5RP3zyfctOcVW2u8NrQgB5cf7tYTGbS9CXoxohJ5f6pzrxouaGREwSzUF3hd6hulDls5vKTxar+ZxnHwWpJ55gyqw/CgE9Mrjro2iJFmaONdFJopbQoWcYtDiJE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775128372; c=relaxed/simple;
	bh=arARuhVPUBKwtEgKdDMxdbRgy2xuGy/O5T4CkBee3yc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gmggj3CMEmENRgpecQNlEHcXWbDD2iEfZ5w5MCB2CPCD4F0zbEwTsQoX9Y2GGsXdioV4nRFPLeUQVRHd5snHmUID5p1MupsAOoUafSxZ/OqDou+FVKb5hHecA6/rpFXJ/C/fPE5NrcsR1Iq4X0mWsejYJ9xRd2rePsv+fhUQtZM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oE0T3Gk8jjYe/ej4K3MBnCPI85zM/eBJFZIuiVAVSQg4GX/cT7c3IyQxYvJZ4IkxfZgICmIokqg6C0xRmzPKqYzklxkP1GB5cmwDwrj19vW7Pi9qi1WPnG82YayIdYR/OKTAYaRsIjyouJFyR4oCyf5qfu9tbV1vXSZLOs8S/OD6fTp2gEauVYQtjwDrZkAmsRs+jw98bfPEPIfEC4FShqw0JneUwKtaUFZU18fIpGCv9PkgiRQM440MGOTMYAhHxhNX5/m85yRnvm9S7s/EXj6coB4LCsy1n+N/zgsvn/jrePFaX3E+rZreMg5vTZeYFPF4QF4jbd4X3DrtHvri6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iRW7sP4l6BCS3mEc4bjfFPDbRcBZYpfOnBsLGIDcj5s=;
 b=Oa5vF1V6rsNm71iLYq92FtMiQC064stc+tWx/47napjItmfFpcS3wVwzkG3dR1xeqtOJueRu7eIQeq4TRGAJ0Yd9IK7FXkHaXqu5UIc6vqEJsRmlNbw0ezQ50A6PmdSpjdve+1tX93ZGIJ9nqwoXn5OWjGS5Z18u1+Fgmtgl86xMpmCgDSY14JfUmLHGlmlXWbwxT60P3c8EFbEkJPbRFKscDLA5Dh8Ict5P+L7ns16GoW6DW3jNvu6+5sAec14ThgZXfIKJ9Zm7NyomSea4n8jLnh6JJwwpHwSmg32kP1gvKvaOqI8T5MEZBfRHNAz+8bB4ejJ8J913QQdospjN/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ0PR01MB1208.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:19::5) by ZQ0PR01MB1048.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:d::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.20; Thu, 2 Apr
 2026 10:56:13 +0000
Received: from ZQ0PR01MB1208.CHNPR01.prod.partner.outlook.cn
 ([fe80::63d1:b688:cab7:50cb]) by
 ZQ0PR01MB1208.CHNPR01.prod.partner.outlook.cn ([fe80::63d1:b688:cab7:50cb%7])
 with mapi id 15.20.9769.017; Thu, 2 Apr 2026 10:56:13 +0000
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
Subject: [PATCH v1 15/22] dt-bindings: clock: Add StarFive JHB100 Peripheral-1 clock and reset generator
Date: Thu,  2 Apr 2026 03:55:16 -0700
Message-Id: <20260402105523.447523-16-changhuang.liang@starfivetech.com>
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
X-MS-Office365-Filtering-Correlation-Id: b9c7dfdb-b34b-43f5-c267-08de90a674a5
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|52116014|376014|366016|921020|38350700014|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	0hW11raNvNvQWNsgFKXnSMhKD/+0j54vq9bmZb4JvnW4Cm5tElBfci9kxPd1wVYCMmcxAa5QhS3P4iMWjvPcqPljx99wOWiarPrhCxcw4i/DBhwIILxWQc9dQ+4Zl7c8SYqx1ZiP2WXx/5MTfkAOG4YiDhOIDvKKZDsv4g1DiHBkEPFAdMbQ5dCx7TuMV7nYxUYfBpmBrF19nQxmUceG/O3hmYhgvWXjhRX3F4LfJQsXJaP7H+kG+LNU9VHFZqBpCyW3pOV/cF3MJ9x03zNeh6Uu2+3zfkc4IGf4j0IEN5JRkwxxtE+TgKGFMqYHatpvxGqhtJ1yjexho67Tkg53lcH6DpkB2jO5pCjSQmMJImKOQA/m4hDLTxZfYgIGLiJ9nEttl/Ev+w5eYe5S9wyYgsoieZGPXV6jsxLharV7YTt26q7vZsnMuNqa60j1dBOGEK96mHKNOWvqcnybQfJEtyxYXwv1Vk08pQkLxq8l6U3mY3azFfij9oblnWt4EoQ9ATOt18Ihy63y00xuaMV0qmyEdW4UHEIakXg2PXvCx1LE5QB2AsdY610I94gYRHQ0v9jkgbx4XEk02I8RcuSiZ4nqevhnX+sdoZgGC0CEz7g=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ0PR01MB1208.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(52116014)(376014)(366016)(921020)(38350700014)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4PoLIs67fcUBIJCH86p1wKKYWWw+RJcY1kXfWesT/XOWIALIiB1rXngCPmwN?=
 =?us-ascii?Q?nfTUtu6mT9QdVb/9g55ASBwoMsACW+1chCMycQWnFTNz+4dqi5ncfEOBpop5?=
 =?us-ascii?Q?F7ov7ZucqdJMgc0Fjt7ElA0UhVclBy/ygQ9ogdNGRrjO3oBRXPH3FEuaL7uI?=
 =?us-ascii?Q?5WbcRYarul7S7hnc+1WKtxYLGKqxsDJHW0hRXIWsusPh0Z4qnKuFeQxW/Yd6?=
 =?us-ascii?Q?TdcX/DXrlk6GNoEttz5TDqLON5aKXhsv2I5TzIevANb3vhtdbvBWC6Vz4fXG?=
 =?us-ascii?Q?XqgwOP/aOPRcG/VphndqZ1Ivh9IPq2crp+IBdl0Lz+RZrvaT6wtJnkyvCq+j?=
 =?us-ascii?Q?VWtSJxdJMcST3DLX0f0VIQHdHNitHcI7Nf8GRNun8+caQ2py6S3HYtWyIOFb?=
 =?us-ascii?Q?RELvJGfVCD18W6lXdcxgm6da+GQxVVC175bdwXKl0Z8Fu5aFbXRBf4Bc4SAY?=
 =?us-ascii?Q?L5EdAgBtvRX8Rj96Ak02RxtGVKRUmud/iatmIqShxKYS78WAsp0wUmX6+I7M?=
 =?us-ascii?Q?TIEAsn414/2Ji44VismLNTD+1Wvf274qcmKLJf0JkdVpEyzuaPjDNUlPc4gR?=
 =?us-ascii?Q?rwiNgpOI5CjQyJRUAurXf6N+ONLiwowYzNQjz/0FIn7ndxElg/F1Z4zhNaVq?=
 =?us-ascii?Q?LvlB8QLbQxUWJt8hTWT/3c6WzL3NNka7WMXNeHQC0h1IlXXYYL5DlM+wLoZb?=
 =?us-ascii?Q?A08sZ7ipfs5KQvs8jbWOw0Q0hv8qTbaYuSCGNsbj60h6ZuGRP37XH4xifYUf?=
 =?us-ascii?Q?jZyF5s0kaqS0VpOOrgIlggtgJHusgrhyez272b0Hmcc/LyuGMmT9NrD0Elxq?=
 =?us-ascii?Q?785xkb/lNb6xFqoOo92yWE0ES2GCIRgXr247PVC7VQfwIAFYr2FPXzTtuiS6?=
 =?us-ascii?Q?2lWpKpNfzekoK4qmjLXlBAST2oMrN8fEFX5/2Tc/VOjsuJzjce+ajMlTA/XO?=
 =?us-ascii?Q?Hk8lyupaLkM9JmGBKf8mTkwwnzq3apVHFCsnM1qSUG1785x2wztX0OJNkxZI?=
 =?us-ascii?Q?U9nEpcnwV9iWRxA1ThuHaAFkXwxP12bF+EIE1QOuHjTjIcWaZWtys1lH0etU?=
 =?us-ascii?Q?BP7HKhTwXZ+jqW6qi5zLFt05jQibrlh0H9wfrEyM7lplSztxeFMg/mnYpj7f?=
 =?us-ascii?Q?oYBqWrHamW1pEtP4csxr/yAMR2dW4b2CISsqBmanxrbZrd3tb+oSMmj1IuLC?=
 =?us-ascii?Q?e13eFZKMr+kJOSYRY1xg6g4xr6gVK7VW4bcIiH+FtDDFHeyHmiqSU7sCmk4d?=
 =?us-ascii?Q?1WxGgX7ng7YRNSwx9DpAlbOlUfZWjzQGwexK/vI0AgImCQB2htLs6kW5PD2X?=
 =?us-ascii?Q?Obgay8UEhQ63KQoNrfmqvIErhxANf3t01VhH8t7boLfdO0mFrn1hxYGjcbW9?=
 =?us-ascii?Q?pTzUYHbsnAqjhcQYaTbF9h+T+3+Iwj3Gkf0gBF2WbXOeuHoWPHAzZ8kp/cO/?=
 =?us-ascii?Q?42ZTsWOgUOa0WiRpe+8km0ZFhoV0ulhWhHmxhcx7NY/KdIS/c6tjMcBybcAJ?=
 =?us-ascii?Q?yv/y/wwcQ0wlHfedLYP/PhFrqyyMc8fkoHC/VontBZ30rZNa+GJIKq+1yEcx?=
 =?us-ascii?Q?GABn0if4nDikq1pkalS7kWuaj2W2dFKDblB+XKTxqj6lIup+K6CNMw1bxZKo?=
 =?us-ascii?Q?ig4OX/sgU9CDDP8Htdl0ZmoBJFNr77nWiq4L9GT8PHmFS2meWTrQHT69VNH7?=
 =?us-ascii?Q?iFunIEBNmuGo8/FROnSyIW8nC5VOkVnmes3tfAY4wlGnOdokyLbDFNBjDBVg?=
 =?us-ascii?Q?0bu+Fx++5S9HrZKdNlvaWjwWAZKXfqmOZ5z64y3u6B9x3jB5k8L9?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9c7dfdb-b34b-43f5-c267-08de90a674a5
X-MS-Exchange-CrossTenant-AuthSource: ZQ0PR01MB1208.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2026 10:56:13.0560
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6O2B7PuemfYpTRZlrcF+10k1S66F1nnoE9tGUpga3q8l/9iMcGA3YUROYijUdqvcecl4EOIpz+d5heYIrtl3+3HvZe2A2ZTIhEV8/fB5IrsQ2BGomtjKIf/kuzGnDoMa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ0PR01MB1048
X-Spamd-Result: default: False [5.04 / 15.00];
	DMARC_POLICY_QUARANTINE(1.50)[starfivetech.com : SPF not aligned (relaxed), No valid DKIM,quarantine];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[baylibre.com,kernel.org,dabbelt.com,eecs.berkeley.edu,ghiti.fr,pengutronix.de,esmil.dk,gmail.com];
	GREYLIST(0.00)[pass,body];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-274479-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[24];
	FROM_HAS_DN(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.633];
	FROM_NEQ_ENVFROM(0.00)[changhuang.liang@starfivetech.com,netdev@vger.kernel.org];
	TAGGED_RCPT(0.00)[netdev,dt];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[starfivetech.com:email,starfivetech.com:mid,devicetree.org:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,11b40000:email]
X-Rspamd-Queue-Id: A82F53888DF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add bindings for the Peripheral-1 clock and reset generator (PER1CRG)
on the JHB100 RISC-V SoC by StarFive Ltd.

Signed-off-by: Changhuang Liang <changhuang.liang@starfivetech.com>
---
 .../clock/starfive,jhb100-per1crg.yaml        | 70 +++++++++++++++++++
 .../dt-bindings/clock/starfive,jhb100-crg.h   | 60 ++++++++++++++++
 .../dt-bindings/reset/starfive,jhb100-crg.h   | 20 ++++++
 3 files changed, 150 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/starfive,jhb100-per1crg.yaml

diff --git a/Documentation/devicetree/bindings/clock/starfive,jhb100-per1crg.yaml b/Documentation/devicetree/bindings/clock/starfive,jhb100-per1crg.yaml
new file mode 100644
index 000000000000..517c6dd2b19f
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/starfive,jhb100-per1crg.yaml
@@ -0,0 +1,70 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/starfive,jhb100-per1crg.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: StarFive JHB100 Peripheral-1 Clock and Reset Generator
+
+maintainers:
+  - Changhuang Liang <changhuang.liang@starfivetech.com>
+
+properties:
+  compatible:
+    const: starfive,jhb100-per1crg
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    items:
+      - description: PLL7
+      - description: Peripheral-1 600MHz
+      - description: Peripheral-1 800MHz
+      - description: Peripheral-1 200MHz
+      - description: Peripheral-1 143MHz
+
+  clock-names:
+    items:
+      - const: pll7
+      - const: per1_600
+      - const: per1_800
+      - const: per1_200
+      - const: per1_143
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
+    clock-controller@11b40000 {
+      compatible = "starfive,jhb100-per1crg";
+      reg = <0x11b40000 0x1000>;
+      clocks = <&pll7>,
+               <&sys0crg 68>,
+               <&sys0crg 69>,
+               <&sys2crg 19>,
+               <&sys2crg 22>;
+      clock-names = "pll7", "per1_600",
+                    "per1_800", "per1_200",
+                    "per1_143";
+      #clock-cells = <1>;
+      #reset-cells = <1>;
+    };
diff --git a/include/dt-bindings/clock/starfive,jhb100-crg.h b/include/dt-bindings/clock/starfive,jhb100-crg.h
index 104f302b7103..95345d104585 100644
--- a/include/dt-bindings/clock/starfive,jhb100-crg.h
+++ b/include/dt-bindings/clock/starfive,jhb100-crg.h
@@ -387,4 +387,64 @@
 #define JHB100_PER0CLK_MAIN_ICG_EN_SENSORS_DMAC		339
 #define JHB100_PER0CLK_MAIN_ICG_EN_TRNG			340
 
+/* PER1CRG clocks */
+#define JHB100_PER1CLK_100				0
+#define JHB100_PER1CLK_1				1
+#define JHB100_PER1CLK_200_DIVN0			2
+#define JHB100_PER1CLK_200_DIVN1			3
+#define JHB100_PER1CLK_200_DIVN2			4
+#define JHB100_PER1CLK_200_DIVN3			5
+#define JHB100_PER1CLK_200_CCLK_DIV			6
+
+#define JHB100_PER1CLK_SGPIO0_PCLK			15
+#define JHB100_PER1CLK_SGPIO0_DCLK			16
+#define JHB100_PER1CLK_SGPIO1_PCLK			17
+#define JHB100_PER1CLK_SGPIO1_DCLK			18
+
+#define JHB100_PER1CLK_EMMC0_BCLK			22
+
+#define JHB100_PER1CLK_EMMC0_CCLK			25
+
+#define JHB100_PER1CLK_DMAC1_1CH_CORE			29
+
+#define JHB100_PER1CLK_DMAC1_1CH_ACLK			31
+
+#define JHB100_PER1CLK_DMAC2_1CH_CORE			33
+
+#define JHB100_PER1CLK_DMAC2_1CH_ACLK			35
+
+#define JHB100_PER1CLK_DMAC3_1CH_CORE			37
+
+#define JHB100_PER1CLK_DMAC3_1CH_ACLK			39
+
+#define JHB100_PER1CLK_DMAC0_2CH_CORE			41
+
+#define JHB100_PER1CLK_DMAC0_2CH_ACLK			43
+
+#define JHB100_PER1CLK_UFS_REF				45
+#define JHB100_PER1CLK_UFS_300				46
+#define JHB100_PER1CLK_UFS_150				47
+#define JHB100_PER1CLK_UFS_400				48
+#define JHB100_PER1CLK_UFS_75				49
+#define JHB100_PER1CLK_UFS_37_5				50
+#define JHB100_PER1CLK_UFS_7_5				51
+#define JHB100_PER1CLK_UFS_1_875			52
+#define JHB100_PER1CLK_UFS_7_143			53
+#define JHB100_PER1CLK_UFS_3_5715			54
+
+#define JHB100_PER1CLK_MAIN_ICG_EN_SFC0			63
+#define JHB100_PER1CLK_MAIN_ICG_EN_SFC1			64
+#define JHB100_PER1CLK_MAIN_ICG_EN_SFC2			65
+#define JHB100_PER1CLK_MAIN_ICG_EN_SPI0			66
+#define JHB100_PER1CLK_MAIN_ICG_EN_SGPIO0		67
+#define JHB100_PER1CLK_MAIN_ICG_EN_SGPIO1		68
+#define JHB100_PER1CLK_MAIN_ICG_EN_SENSORS_PERIPH1	69
+#define JHB100_PER1CLK_MAIN_ICG_EN_EMMC0		70
+#define JHB100_PER1CLK_MAIN_ICG_EN_DMAC_SFC0		71
+#define JHB100_PER1CLK_MAIN_ICG_EN_DMAC_SFC1		72
+#define JHB100_PER1CLK_MAIN_ICG_EN_DMAC_SFC2		73
+#define JHB100_PER1CLK_MAIN_ICG_EN_DMAC_SPI0		74
+#define JHB100_PER1CLK_MAIN_ICG_EN_RAS			75
+#define JHB100_PER1CLK_MAIN_ICG_EN_UFS			76
+
 #endif /* __DT_BINDINGS_CLOCK_STARFIVE_JHB100_H__ */
diff --git a/include/dt-bindings/reset/starfive,jhb100-crg.h b/include/dt-bindings/reset/starfive,jhb100-crg.h
index bb5238cb02f6..57977d5b4018 100644
--- a/include/dt-bindings/reset/starfive,jhb100-crg.h
+++ b/include/dt-bindings/reset/starfive,jhb100-crg.h
@@ -143,4 +143,24 @@
 #define JHB100_PER0RST_GPIO_IOMUX_PRESETN				74
 #define JHB100_PER0RST_UART_MUX_REG_WRAP				75
 
+/* PER1CRG resets */
+#define JHB100_PER1RST_IOMUX_PRESETN					0
+#define JHB100_PER1RST_SYSCON_PRESETN					1
+#define JHB100_PER1RST_MAIN_RSTN_SFC0					2
+#define JHB100_PER1RST_MAIN_RSTN_SFC1					3
+#define JHB100_PER1RST_MAIN_RSTN_SFC2					4
+#define JHB100_PER1RST_MAIN_RSTN_SPI0					5
+#define JHB100_PER1RST_MAIN_RSTN_PERIPH1_SENSORS			6
+#define JHB100_PER1RST_MAIN_RSTN_SGPIO0					7
+#define JHB100_PER1RST_MAIN_RSTN_SGPIO1					8
+#define JHB100_PER1RST_MAIN_RSTN_EMMC0					9
+
+#define JHB100_PER1RST_MAIN_RSTN_UFS					11
+#define JHB100_PER1RST_MAIN_RSTN_UFS_PHY				12
+#define JHB100_PER1RST_MAIN_RSTN_DMAC_SFC0				13
+#define JHB100_PER1RST_MAIN_RSTN_DMAC_SFC1				14
+#define JHB100_PER1RST_MAIN_RSTN_DMAC_SFC2				15
+#define JHB100_PER1RST_MAIN_RSTN_DMAC_SPI0				16
+#define JHB100_PER1RST_MAIN_RSTN_PERIPH1_RAS				17
+
 #endif /* __DT_BINDINGS_RESET_STARFIVE_JHB100_CRG_H__ */
-- 
2.25.1


