Return-Path: <netdev+bounces-274477-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aDi6BOdQzmmjmgYAu9opvQ
	(envelope-from <netdev+bounces-274477-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 13:20:07 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 620FA38839F
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 13:20:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0E727308A97E
	for <lists+netdev@lfdr.de>; Thu,  2 Apr 2026 11:12:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F1E13BFE2E;
	Thu,  2 Apr 2026 11:12:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2136.outbound.protection.partner.outlook.cn [139.219.17.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 696EE3BE64C;
	Thu,  2 Apr 2026 11:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.136
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775128332; cv=fail; b=TicyODTc6vGICugV94kL8QmIZbaWSCgyvJjr/hTYUJHGhVeONy4Vu8fVCuL0Ln6q4m1Tgpb9lgbgRX7K1QRuVXcUijw4p0Lm0eVOeG043s1dvXwg845bFC3UQP+flgZZgHyNsT74555p0Ka7MXwdG609JpVwpLI8pT+c3zRxeTs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775128332; c=relaxed/simple;
	bh=u6iXGUIzHLxqk1ZLENVJoQUdD3oaVAkgn4qp9jB1cYA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cNMWkaOZ09xXJjxbqp4qe3N1xXI8MfAqhdSI2ufD56qZJqh8HjwtGbIutRqhiQ+2ej/j2P5CLc3Mqk5N8oik9fDq+zOo/aNglalsnjCavXxaihsk3yrXdHbqC90Y3yLkGemH8cmTazEK1UiGCnamI/GkSHuPt6/Kjuk6FNCMcNA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EiYdiAkFU3AOpzCKPk1quoa1K/Xhd6aBsksM5ceiiBhncH/0tCNQlEtEhpZr/vWm3jPngNqPAigDlM7uDxhm10tZL1OigOl1o/2p6J537Dlf9osjX4BGjKkMql0JjGikScNWydcjnKnjgvJewU4Vuvk3aAAfPai5VKOU/wH2uqsr4KkcnEozY/y5oBjgdDvk9v9ehfMQgZ6ogORwYOl0ksz/sggaKJum6web4uOKiHQeoZJPcdVyoqBT56NntnMavfRJ7gDiMICVjLr0ZXDfQ9LSSZ//V+/xiQX/aSA6tX8/S8b5t88V9JWiS05XRbfjSIPcusP65869h6qfgEbvOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BU4eruqZBSF4wUwhAYrDH+JiS/7GwK2cT/70pSo0/xc=;
 b=WF+4r8a1V3QCY6F2r0Vzb0aU4AhUzxdEQyYUiDsGovKNdlfgj1Q9HmRiWC427kpvUZZaHdS6jPmMrusJ9I1iviOpHPAFdL/VPb/vN0hxLNtW2KJKWC2K6J1Y5C2fXlC9JzztLVjmPOpBZlsfEUODnCHw0L4NzLE59klfv+Gd4Coom/bIbhelBMUGbMbM8hs+KzeOqbZ6Ch1JbZmVwbqd0L3U9hqLUIUKY9Ov6eXWNkRruSLJ3zOaN6WL3tjFYYjtZ5kDUnfmgkxkAoqRPlt30o+9//XnqGNqYig5lrKqooaU6e/b22NGw8Q+rhtvLYsYlq9NsPeCnAARSJ5SMXA5bA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ0PR01MB1208.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:19::5) by ZQ0PR01MB1048.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:d::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.20; Thu, 2 Apr
 2026 10:56:09 +0000
Received: from ZQ0PR01MB1208.CHNPR01.prod.partner.outlook.cn
 ([fe80::63d1:b688:cab7:50cb]) by
 ZQ0PR01MB1208.CHNPR01.prod.partner.outlook.cn ([fe80::63d1:b688:cab7:50cb%7])
 with mapi id 15.20.9769.017; Thu, 2 Apr 2026 10:56:09 +0000
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
Subject: [PATCH v1 13/22] clk: starfive: Expand the storage of clock parent index
Date: Thu,  2 Apr 2026 03:55:14 -0700
Message-Id: <20260402105523.447523-14-changhuang.liang@starfivetech.com>
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
X-MS-Office365-Filtering-Correlation-Id: b163252f-c520-46b7-6c45-08de90a67236
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|52116014|376014|366016|921020|38350700014|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	FA0rAy5zPO9QQG8fDU/yMXkIvgEtS1/S5OnRW66tBAnbKj31Ribq5bQvJDPim18idmE0HT/fYejgsobbbZPWr0bQ4f7BhC8GenQQkxL56Ry+HfVjCxTwuCa8wQkZxsvCX4nzRWd7TNsQQ2m5zGyWCUAHrnPq9Il36JMxlRpOyRuGBpXgjIqXlF1mepLKa6haB/lDl8plsbZyJRB4tahLQJ8fC7nEt62YTVPx4uHSckPfivj0MtfMA0PEu1s7LuGmP0ukqmQG4A0C8AJVoVMo6Ne6AbpoDBNMzhOpHd3jnDMCkW337m3xs6Sy4v+LMSv9D9CmE/F4U2pYDxJ4OwQcEsUybVw+Wob5HAZeWX0M0yUMqtAUwBbiljWRvlZbxQpnIfcSs1SsaS1GXAI9SzKcB/2nzxMMGb/EfGaIU2hF4xgKQkuJAYGHtRw8ETJXMw1t6wVRKp+B3NSGVaA2aYlxguLBmBEIMIUPk/sk9XB6pddmTQkDpXeRsNupOY6gg6WEzteuvOOPxBxBH+1m7LSkitsA39jFEdkkJ+Gx5UATysA8iVv3zX82QReSSYCcnWxn2f6XCzKwjyMEXanin/yOCLVBk4MI1RE1cPNEKkd/rPM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ0PR01MB1208.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(52116014)(376014)(366016)(921020)(38350700014)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?G6RwZhR340/k45SOLaDGWGfZqyweZhRUOZ0gMCxu/5ehiCemRHJAY/GInJdl?=
 =?us-ascii?Q?RguqZwYdrVJ4+0ED6+eZ8rWA7a/JbuV+OeHXeJnzmixfxkVWQHROYHyWUXkx?=
 =?us-ascii?Q?m7FoJrK1Y0/OraE/nJITGIV5V6zNasb58uG9vco7C73h6qSsUbtiI3jSNg9j?=
 =?us-ascii?Q?4+0b8OHUb9MJ/xez7l3ep4WHJb+u9InugbUpRxian3WcmH46SuX9Ossjnoqt?=
 =?us-ascii?Q?oPlKyk/zqofX3jN0F1ieZEVBi4jh3sS4BGSzeWG+p1LTW5tA87y8fzWhkNQh?=
 =?us-ascii?Q?g2iXBWCOB/NLQuv6+Igcfutz9v2Pl60xpFO61Id6FabxiGTTILQfL0Mx8hBP?=
 =?us-ascii?Q?diYCQ4Kv5ni4JriwFNI/LcuOA5r8HznDFhN2A6B+rvI01aInqeHjicQJI401?=
 =?us-ascii?Q?pbja59/bKdNilXG1omZunv6QeeNs7SzjkFcIENS5xWO6T0k5jaGn+bB/4WMR?=
 =?us-ascii?Q?UloBi7YSwskasjTI2uGZovosedM5qumDVqxKqodMftlFyce1+YSuikU6rj9M?=
 =?us-ascii?Q?PlNzQO6GWZ0rAGX13k8Tv26AuGIw5TPW9xZgJf65NwH6COER3hJ4KJN+NX9E?=
 =?us-ascii?Q?5Q2/yg+Fz9umRj6W2B2jiv7OfyToNccc65/n9GtKJyEbPHvT9Bm51j+17mlL?=
 =?us-ascii?Q?mF71i8wpBwJ2DAO5djWfNALBkJU2IqyY7R0mwra0kwzqU7p4a0j+j4xAKTW0?=
 =?us-ascii?Q?9r9Pz7TZPgy60R41ZaW/YNgSDjvj5xxELf7AmdW0D94lVOnwj4dXA4t4cdiL?=
 =?us-ascii?Q?V4lOj1a6C9WWpdNW3HDOclld2Wnipz95FSKjjOQHYQGWusSKHg+2S+1a6/4b?=
 =?us-ascii?Q?NhNnIz8YKDv7odrCzpD26fdgcbIpz70SQeCvOpn4WdeIVaxK4n+YMW1q2Q+M?=
 =?us-ascii?Q?1J/+0AmObU30vhqLjxXG11LLIlroRcnJD15SxZlq4SFCS2R4Gxtnl3CBpT5U?=
 =?us-ascii?Q?Z3khYdcGSvfcEN8CPjAs4PPOlFdPC1WGK0QzONr0ao/OErZ96J289KPJi0R1?=
 =?us-ascii?Q?lYasu+6qu+0t47ZhIS2DBdhXkCr45Q1fKHzEUu5OGnBM69YktFRv7E4dFp8P?=
 =?us-ascii?Q?6Q5EKuKfgke5FiepOEZ2EkNIu+H+cntnpblWGTFkLIyU8cEHeWfmQmTeXhOD?=
 =?us-ascii?Q?cWav1CSl6rUGsQdl2elUK60yuM7VqKnI2GAX5hFMbvuE3lbisfWMvP/QEohn?=
 =?us-ascii?Q?WmmAAEW1FbOmZhQ77D1LjPiP6IQ4y62r/L7C8zFaxuYLTzt0q1/7w5uINxOh?=
 =?us-ascii?Q?Dky3WqNNd4URT/I57AcarUFpd7eMxHHi78O7/CycwHFbkYlvF3E/muuU5uge?=
 =?us-ascii?Q?RQlpqrvrE0mG0CTH976fY+QkjGKxCJUW0k9Vr+U7IrFAeTfiyqth9uUrVs2y?=
 =?us-ascii?Q?itmNkgyCOoTdufOp3nUqv+EkOLqVfmAxJEf8ILzkSWjOPgeur9yDXU4nIOdf?=
 =?us-ascii?Q?3y2DGw1L7ILYSVwk5hJm4HH83bPfEU9AUQRjXF5NEj41wMqUKbm6fOZOwje9?=
 =?us-ascii?Q?hFg9DBGPiT7aKQU297jVFnMgMxEtfTxs0WxYZxEzh2fQOYAlvDvg143nYxZn?=
 =?us-ascii?Q?QxIpzWB7Xn52/t9cjYFIpjYDwap9JpTNrb1t7c4hmJpgROfIZdEB7wJ/6EpI?=
 =?us-ascii?Q?uBQux6w9fvRwZki3jTtW7JQ4AElgtvJ4Dtlbdjp1cU+6xCYde9swAVXO+qu+?=
 =?us-ascii?Q?HuA+JtWduW24wbdAX8pVIor6WrY03lnrrWHDx+ac1NdgSQkzAK+FjP6VFxZ2?=
 =?us-ascii?Q?8+OQMfk3hENQuevMBbegfoTv8vm73sitzq00Z1ft8WgzAA8iy9Ch?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b163252f-c520-46b7-6c45-08de90a67236
X-MS-Exchange-CrossTenant-AuthSource: ZQ0PR01MB1208.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2026 10:56:09.0238
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P3NhVsMbKWKsFRjllVMFuhlJxB1+55sVZxC4QOH82UNDuhq+LoJfSTOFcsEhxA7UjEvpMnjTbZf1kEs+35zEBcmS6GvhkFQomG8nPc7r+PXj/u3NUgdRRhAC63H0vMBa
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
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-274477-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[24];
	FREEMAIL_TO(0.00)[baylibre.com,kernel.org,dabbelt.com,eecs.berkeley.edu,ghiti.fr,pengutronix.de,esmil.dk,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	GREYLIST(0.00)[pass,body];
	FROM_NEQ_ENVFROM(0.00)[changhuang.liang@starfivetech.com,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.916];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev,dt];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 620FA38839F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Expand the storage of clock parent index for per0 domain, which parent
index over 255. So change u8 to u16.

Signed-off-by: Changhuang Liang <changhuang.liang@starfivetech.com>
---
 drivers/clk/starfive/clk-starfive-common.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/starfive/clk-starfive-common.h b/drivers/clk/starfive/clk-starfive-common.h
index fd9bf6f20152..8edc6c516451 100644
--- a/drivers/clk/starfive/clk-starfive-common.h
+++ b/drivers/clk/starfive/clk-starfive-common.h
@@ -26,7 +26,7 @@ struct starfive_clk_data {
 	const char *name;
 	unsigned long flags;
 	u32 max;
-	u8 parents[4];
+	u16 parents[4];
 };
 
 #define STARFIVE_GATE(_idx, _name, _flags, _parent)				\
-- 
2.25.1


