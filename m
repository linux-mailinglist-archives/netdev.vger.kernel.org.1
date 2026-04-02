Return-Path: <netdev+bounces-274520-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GB3xC95hzmmXnQYAu9opvQ
	(envelope-from <netdev+bounces-274520-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 14:32:30 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 837E2389174
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 14:32:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3797A30763EA
	for <lists+netdev@lfdr.de>; Thu,  2 Apr 2026 12:30:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 883753C3430;
	Thu,  2 Apr 2026 12:30:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2091.outbound.protection.partner.outlook.cn [139.219.17.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59EF63DEFF4;
	Thu,  2 Apr 2026 12:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.91
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775133029; cv=fail; b=cFi8+0CRcOqQ7GocGDXb1Qawflo3LgvjdHBqVwN3vD6UQqIEjGnGdZorbioC5MiUvCBpxpzyhJatsbNyUsDv8ketNuT17xeuuUQRfFIG2WMTxa2jQBvBV3xA1ve9lFc2grv0g87rmt1h+vo/uZBPkyJt1UJbD7ZPhfnbR+JYfKw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775133029; c=relaxed/simple;
	bh=PFJ8kSh11aMoJ99Cy7CLgfLjPAUyZReEWJ/35T1tzHk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OO2wCOoWn6xFHL0SNal4Aq9kjVLgpS6WGtXEaH2njxF7wBHhMvkOvXwyrwGfFos9c2pxSwAeEQ9w3pldOKnJsJEbWDGh/SPebLEM5qEQrywZxwUkXBIGh5zMHZgozqH/347beEBIW2EpoNenm6B4Fh1PrBWH364ZVI8eU+Vq5mc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vv1vStT8UNvHqy/BpfkwQ8r9jcNQF9gKma+FQzGb2zzRZf2uIa4J4fOXwQnz7/AjbI+pjVfouDRDyR+Kg83Fd6ivAF2EKwLR3SUJWZ30TFZEx5PH4uguVBb9SMDkRY0QgAN1KHc6zr400NTISkoD+lhnPgx+Qa5nXg3ME1rGTh5mU5oAezBiPwtU5K5A0BXJ82VSMbIz+uNMlCJhDBpgJYhODcsVnNqweorsRDIJfnRS4rXTmzLQK9tC1ebjC3SwuYvv63Oz1v9P0GaHw2s7S25OT0ewRXI1uRnSyTCysoICe0zAiRvMg7wQlUiXJI6W6vJxAgPQxcRMMiqaWz2FEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EehSox8a4KpB5i5ZyBz1uFGRGkrAlccEnPllqpFiejI=;
 b=b/q8uO0go2fMTToVOjtB2zUbRxiBdKz57qs5JrgNA7wYFHOQaPI4Wz5a3V8hSmV/eDB3Ehen7SEAiKy2XBayoqTHr2tfZQrK4qE/TYsdDkX8nthJ/iT56SerQZ30FXR/OTsLD68cotJrbLRLMXXFampYrcu4KYNtWvAs3NGyPcmKAPwAzbAz6YK4cBRwPGqONbA7f5kamSOSriVSEMRPB+K58ajdd6QFr8KhSz9CIH1dk8aQNfGOPp2b4iS/ug6jbjiKQC5hQ70mKqssE7OK0Znt/AxDHATbJlMCNXeb8hozsSoFIrOc7hbPpdyYHVZeIUEipOWQFfuM23SRj71J9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ0PR01MB1208.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:19::5) by ZQ0PR01MB1048.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:d::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.20; Thu, 2 Apr
 2026 10:56:16 +0000
Received: from ZQ0PR01MB1208.CHNPR01.prod.partner.outlook.cn
 ([fe80::63d1:b688:cab7:50cb]) by
 ZQ0PR01MB1208.CHNPR01.prod.partner.outlook.cn ([fe80::63d1:b688:cab7:50cb%7])
 with mapi id 15.20.9769.017; Thu, 2 Apr 2026 10:56:16 +0000
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
Subject: [PATCH v1 17/22] dt-bindings: clock: Add StarFive JHB100 Peripheral-2 clock and reset generator
Date: Thu,  2 Apr 2026 03:55:18 -0700
Message-Id: <20260402105523.447523-18-changhuang.liang@starfivetech.com>
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
X-MS-Office365-Filtering-Correlation-Id: 8e5000cc-7f36-457d-7df3-08de90a6765f
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|52116014|376014|366016|921020|38350700014|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	yh5f3pE9BYsGhNs5LMI4Y9rRkus52333ncW+VcGKY5mSLBuzM1Y7D0dzhTaT7sauSMSsqF7MYj+MPiUqp5PWDhEZ0mfyZ5xJu6MAuoT3085LD4WIsabQMbc4CdBIW1HAl9pTt2tN39Dpg1XTVRXH7XlxE+yZel+HJIiQrt7xtZgHwS5ELfDKJcZ6GZH419uLG7pUqTk+74oVXuOnJFVZxI7VSJgYdaYEqHrE/z7vDHdFS9YrdlsocUobad3DROzRWs0/dT0qppIkPKC2au9OBuDMPxclFwkTuDDJ8OW8u/04WL1QFaGzAFl8oTMy9CUqzxqWupLU21gDPOIZKxTk2KokFiShOMaRdLp3cKe/QbGgF5kkZfWvVivKaYwhLZjGnD0ei3+dGBGkIzrULPqnfLqKgL0otL7+iJWYDIQmfPaTR/Zopc3zETDcmsbFmv0zsW/Soyp3BZSk+lO+ZDs6MEMzH1BqPOQHz7P4PMtbaurf7qXbGAf9gh72fg+sMjyapt8hfN6fOeVibrkTmlUnsdLzYIh0TMb4qpjeKRkZOH6lhly4IxdOZZu7kFlJ5ATeb0j3nPWZ3rSQvzMT1S+ScDLUqf90I2PrOmrIb00b+50=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ0PR01MB1208.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(52116014)(376014)(366016)(921020)(38350700014)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?z+gfqZ8hfEQ4K1WbipDMtW2PqyrjmE8pjx6eA46oyFt7zZjiJQLDpsv/3i7T?=
 =?us-ascii?Q?COB7EphG0IGWJ4aUvRHba4WWxzOI+dgzTTQSqqUTCjgXeq6XbEpOKMawYS/E?=
 =?us-ascii?Q?X0AQm/etwOPYJlqh+xvLWzeKcE1djMfgKL5oWSEOOc+ej/xuiQkoM1K3AZ+n?=
 =?us-ascii?Q?D23jb6ThTJ5XwL8rcY3KAOx0OstM+FFeyrZIq3mMNeKHEpmEyWAG4OP7SA32?=
 =?us-ascii?Q?O1eZFVv55fKP7k1AyZARpka8tthOhp249j778JGlzr0WLBY6moiOTsONJSca?=
 =?us-ascii?Q?3eTcl/eDf/gK4W2xwArJVJKi2l47F8kWkGUWf0x+1U5H70Mu0qkz4KqsSh6p?=
 =?us-ascii?Q?P7NfDYf49xTFo0q2eXpfvgq8+3qTIQ1SZo4yObLpsrxezLVxPybamnlfvh6C?=
 =?us-ascii?Q?hfkA2va9OkqjfHqHu5fe5II98Gkl/GaX8wSxM+2pdaqqVG25/tHRCieH7bfy?=
 =?us-ascii?Q?V9A255KrRtSkntEmTOS5EKF3meQRQWxkZQmEF8LxyKv0wMC0myjnBQ8Ct37l?=
 =?us-ascii?Q?jXJhdm+RLK48MNvlgFviepAsWsnAVXU/UhTOTfDHA7A+CAP2dQFR/euGryFV?=
 =?us-ascii?Q?EMYxpeCFVaJc4x97n98iiL1M3/g3sgaRuvRF+gu+1eXnjSI2Gb5h2dcXta9f?=
 =?us-ascii?Q?Y97r5iFJ6cWOddPTausMLgGwySKyPSK2OpHch3xcWseAGvlhnol09AGjZZpt?=
 =?us-ascii?Q?hLY9gKgdLVB5eDt6dSEI/6HAUNTtXnd8hyKXOu60x8RpaukGxxdTy3nwDCvy?=
 =?us-ascii?Q?iISAmDlzyCEOCt1mNMbNro4KeTt6SbvW4VC27nLuwEl3RuFMg2SpeXAnDDAZ?=
 =?us-ascii?Q?lm78k9mgcDJNLSBb7o4BryHazS4/p6ArNL72dVghpfkL9pkIZB1ZVn4rBf9/?=
 =?us-ascii?Q?sAoG51G1F7/s3dWaz8Wl4Izkqqsu4m4G0h4hZQam55nA3pUBJU55DJdhb94K?=
 =?us-ascii?Q?2zq8xz1KdZCc/4/UmKyUPbm7RUZVaKn2i5kZz1qfuvxVsM6Qb0CRhH0Sg8NP?=
 =?us-ascii?Q?hUCKGsZV9/3NM3+a86d2NQTNcCC7Gx+eND/M+go7xmJXQGVmsgYQ8ZSKJ/gB?=
 =?us-ascii?Q?AMKc/uSSODdO3iL8dRnqZSaAOVvpddEA+Y8sriRth1/w/0dXS2CmrN90lbUP?=
 =?us-ascii?Q?WQmVwkdDpBMnPyaMaGdkDsZB+JOEXEPOhdRp6Mz2tIrxcW+wrmlh95uI1gPC?=
 =?us-ascii?Q?qPP/wR7nqBiE/WjG6/VmRJiK046ahQgxGa74mNl5y2yrGDYccqoEC1XTw5Dc?=
 =?us-ascii?Q?yAraV4rU/Yx4NqIzQKLi24muyERTl6pZbWG85n5390v1fWPrJL22IO2Shxr9?=
 =?us-ascii?Q?11lG38F1cViV9Pm8ddc2SmP9U2SeW7hZ7zU3JiMGefOkaHoarkoPgfIDjJ9F?=
 =?us-ascii?Q?/4QvWS0QvtWVhA9xujL+tBceVYyhfNaF79uLLHIUwV55CCviDvzGEIaTR2iq?=
 =?us-ascii?Q?Po8W9fFBnU+BnErYBmHh6BzubOOtECHuzj5YfhNmNab8K6AAGJLzNR7hhnEZ?=
 =?us-ascii?Q?c3bWdTp6RbRwTpS3e+XEf0xZoAdHuKSbxDMKQI0szcrf7t2KKReVtMhD9Lf9?=
 =?us-ascii?Q?HwcEQiPmB/nZtFv5BsQ+NyX8ykOwzNKW2Pcd//zm0nLhWRZYSbRKVGXYH/x1?=
 =?us-ascii?Q?P+sQQS0tfpHqXCBdbNkg6bEfhGcjtrmB2pHv1UvV15EiTbMFWCiFame3/3LM?=
 =?us-ascii?Q?81qRllACvFj6fkaSgXr9Fu210X/Mv9yClLfi0D77d8inEKeVmim3Xy9j02CU?=
 =?us-ascii?Q?2tO1KSou7N6Xxnv1HV++NMYpbERC9nQJhLL1kLe7VE8lE4Njy/Zg?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e5000cc-7f36-457d-7df3-08de90a6765f
X-MS-Exchange-CrossTenant-AuthSource: ZQ0PR01MB1208.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2026 10:56:15.9519
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KK+ffBJnsryjEGLX2fdx8tOALWsdBlzATK5+NV4cqOubS0NoU7keAzhDqFwwddWQBAprbJVz/xSiT11XZAPKPvCVigwraCq1zwL/oP7G+ujpiCTv1IPqG5NY4gsuExj2
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
	FREEMAIL_TO(0.00)[baylibre.com,kernel.org,dabbelt.com,eecs.berkeley.edu,ghiti.fr,pengutronix.de,esmil.dk,gmail.com];
	GREYLIST(0.00)[pass,meta];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-274520-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[24];
	FROM_HAS_DN(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.621];
	FROM_NEQ_ENVFROM(0.00)[changhuang.liang@starfivetech.com,netdev@vger.kernel.org];
	TAGGED_RCPT(0.00)[netdev,dt];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[devicetree.org:url,starfivetech.com:email,starfivetech.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,11bc0000:email]
X-Rspamd-Queue-Id: 837E2389174
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add bindings for the Peripheral-2 clock and reset generator (PER2CRG)
on the JHB100 RISC-V SoC by StarFive Ltd.

Signed-off-by: Changhuang Liang <changhuang.liang@starfivetech.com>
---
 .../clock/starfive,jhb100-per2crg.yaml        | 79 +++++++++++++++++++
 .../dt-bindings/clock/starfive,jhb100-crg.h   | 57 +++++++++++++
 .../dt-bindings/reset/starfive,jhb100-crg.h   | 18 +++++
 3 files changed, 154 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/starfive,jhb100-per2crg.yaml

diff --git a/Documentation/devicetree/bindings/clock/starfive,jhb100-per2crg.yaml b/Documentation/devicetree/bindings/clock/starfive,jhb100-per2crg.yaml
new file mode 100644
index 000000000000..04b2fa97011a
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/starfive,jhb100-per2crg.yaml
@@ -0,0 +1,79 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/starfive,jhb100-per2crg.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: StarFive JHB100 Peripheral-2 Clock and Reset Generator
+
+maintainers:
+  - Changhuang Liang <changhuang.liang@starfivetech.com>
+
+properties:
+  compatible:
+    const: starfive,jhb100-per2crg
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    items:
+      - description: Peripheral-2 600MHz
+      - description: Peripheral-2 400MHz
+      - description: Peripheral-2 125MHz
+      - description: Peripheral-2 GMAC2 RGMII RX
+      - description: Peripheral-2 GMAC2 RMII Reference
+      - description: Peripheral-2 GMAC3 SGMII TX
+      - description: Peripheral-2 GMAC3 SGMII RX
+      - description: Main Oscillator (25 MHz)
+
+  clock-names:
+    items:
+      - const: per2_600
+      - const: per2_400
+      - const: per2_125
+      - const: per2_gmac2_rgmii_rx
+      - const: per2_gmac2_rmii_ref
+      - const: per2_gmac3_sgmii_tx
+      - const: per2_gmac3_sgmii_rx
+      - const: osc
+
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
+    clock-controller@11bc0000 {
+      compatible = "starfive,jhb100-per2crg";
+      reg = <0x11bc0000 0x1000>;
+      clocks = <&sys0crg 52>, <&sys0crg 54>, <&sys0crg 55>,
+               <&per2_gmac2_rgmii_rx>, <&per2_gmac2_rmii_ref>,
+               <&per2_gmac3_sgmii_tx>, <&per2_gmac3_sgmii_rx>,
+               <&osc>;
+      clock-names = "per2_600", "per2_400", "per2_125",
+                    "per2_gmac2_rgmii_rx",
+                    "per2_gmac2_rmii_ref",
+                    "per2_gmac3_sgmii_tx",
+                    "per2_gmac3_sgmii_rx",
+                    "osc";
+      #clock-cells = <1>;
+      #reset-cells = <1>;
+    };
diff --git a/include/dt-bindings/clock/starfive,jhb100-crg.h b/include/dt-bindings/clock/starfive,jhb100-crg.h
index 95345d104585..2ab505437118 100644
--- a/include/dt-bindings/clock/starfive,jhb100-crg.h
+++ b/include/dt-bindings/clock/starfive,jhb100-crg.h
@@ -447,4 +447,61 @@
 #define JHB100_PER1CLK_MAIN_ICG_EN_RAS			75
 #define JHB100_PER1CLK_MAIN_ICG_EN_UFS			76
 
+/* PER2CRG clocks */
+#define JHB100_PER2CLK_300				0
+#define JHB100_PER2CLK_100				1
+#define JHB100_PER2CLK_50				2
+#define JHB100_PER2CLK_GMAC2_RMII_50			3
+#define JHB100_PER2CLK_CAN0_CORE_DIV			4
+#define JHB100_PER2CLK_CAN1_CORE_DIV			5
+#define JHB100_PER2CLK_CAN0_TIMER			6
+#define JHB100_PER2CLK_CAN1_TIMER			7
+
+#define JHB100_PER2CLK_RTC_CORE_DIV			11
+#define JHB100_PER2CLK_GMAC2_RMII_MUX_DLY		12
+#define JHB100_PER2CLK_GMAC2_RMII_DIV			13
+
+#define JHB100_PER2CLK_GMAC2_RGMII_125_MUX		15
+#define JHB100_PER2CLK_GMAC2_RGMII_DIV			16
+#define JHB100_PER2CLK_GMAC2_TX_MUX			17
+#define JHB100_PER2CLK_GMAC2_TX_180_BUF			18
+#define JHB100_PER2CLK_GMAC2_RX_MUX_DLY			19
+#define JHB100_PER2CLK_GMAC2_RX_180_BUF			20
+#define JHB100_PER2CLK_GMAC2_TXCK_MUX_DLY		21
+#define JHB100_PER2CLK_GMAC3_TX_125_MUX			22
+#define JHB100_PER2CLK_GMAC3_RX_125_MUX			23
+#define JHB100_PER2CLK_GMAC3_TX_DIV			24
+#define JHB100_PER2CLK_GMAC3_RX_DIV			25
+#define JHB100_PER2CLK_SENSORS_PERIPH2			26
+
+#define JHB100_PER2CLK_FAN_TACH_PCLK			33
+
+#define JHB100_PER2CLK_ETHER0_RMIIANDRGMII_TX_I		44
+#define JHB100_PER2CLK_ETHER0_RMIIANDRGMII_RX_I		45
+#define JHB100_PER2CLK_ETHER0_RMIIANDRGMII_TX_180_I	46
+#define JHB100_PER2CLK_ETHER0_RMIIANDRGMII_RX_180_I	47
+#define JHB100_PER2CLK_ETHER0_RMIIANDRGMII_PTP_REF_I	48
+#define JHB100_PER2CLK_ETHER0_RMIIANDRGMII_RMII_I	49
+#define JHB100_PER2CLK_ETHER0_RMIIANDRGMII_CSR_I	50
+#define JHB100_PER2CLK_ETHER0_RMIIANDRGMII_ACLK_I	51
+#define JHB100_PER2CLK_RMIIANDRGMII_IOMUX_GMAC2_TXCK	52
+#define JHB100_PER2CLK_ETHER1_SGMII_TX_I		53
+#define JHB100_PER2CLK_ETHER1_SGMII_RX_I		54
+#define JHB100_PER2CLK_ETHER1_SGMII_TX_125_I		55
+#define JHB100_PER2CLK_ETHER1_SGMII_RX_125_I		56
+#define JHB100_PER2CLK_ETHER1_SGMII_PTP_REF_I		57
+#define JHB100_PER2CLK_ETHER1_SGMII_CSR_I		58
+#define JHB100_PER2CLK_ETHER1_SGMII_ACLK_I		59
+#define JHB100_PER2CLK_ETHER1_SGMII_PHY_PCLK_I		60
+#define JHB100_PER2CLK_ETHER1_SGMII_REF_25_I		61
+#define JHB100_PER2CLK_MAIN_ICG_EN_CAN0			62
+#define JHB100_PER2CLK_MAIN_ICG_EN_CAN1			63
+
+#define JHB100_PER2CLK_MAIN_ICG_EN_DMAC_8CH		65
+#define JHB100_PER2CLK_MAIN_ICG_EN_RTC_SCAN		66
+#define JHB100_PER2CLK_MAIN_ICG_EN_ADC0			67
+#define JHB100_PER2CLK_MAIN_ICG_EN_ADC1			68
+#define JHB100_PER2CLK_MAIN_ICG_EN_GMAC2		69
+#define JHB100_PER2CLK_MAIN_ICG_EN_GMAC3		70
+
 #endif /* __DT_BINDINGS_CLOCK_STARFIVE_JHB100_H__ */
diff --git a/include/dt-bindings/reset/starfive,jhb100-crg.h b/include/dt-bindings/reset/starfive,jhb100-crg.h
index 57977d5b4018..102af1042903 100644
--- a/include/dt-bindings/reset/starfive,jhb100-crg.h
+++ b/include/dt-bindings/reset/starfive,jhb100-crg.h
@@ -163,4 +163,22 @@
 #define JHB100_PER1RST_MAIN_RSTN_DMAC_SPI0				16
 #define JHB100_PER1RST_MAIN_RSTN_PERIPH1_RAS				17
 
+/* PER2CRG resets */
+#define JHB100_PER2RST_IOMUX_PRESETN					0
+#define JHB100_PER2RST_POK_IOMUX_PRESETN				1
+#define JHB100_PER2RST_SYSREG_RSTN					2
+#define JHB100_PER2RST_MAIN_RSTN_CAN0					3
+#define JHB100_PER2RST_MAIN_RSTN_CAN1					4
+#define JHB100_PER2RST_FAN_TACH_PRESETN					5
+
+#define JHB100_PER2RST_MAIN_RSTN_GMAC2					7
+#define JHB100_PER2RST_MAIN_RSTN_GMAC3					8
+#define JHB100_PER2RST_MAIN_RSTN_DMAC_8CH				9
+#define JHB100_PER2RST_MAIN_RSTN_RTC					10
+#define JHB100_PER2RST_ADC0_PRESETN					11
+#define JHB100_PER2RST_ADC0_IOMUX_PRESETN				12
+#define JHB100_PER2RST_ADC1_PRESETN					13
+#define JHB100_PER2RST_ADC1_IOMUX_PRESETN				14
+#define JHB100_PER2RST_MAIN_RSTN_PERIPH2_SENSORS			15
+
 #endif /* __DT_BINDINGS_RESET_STARFIVE_JHB100_CRG_H__ */
-- 
2.25.1


