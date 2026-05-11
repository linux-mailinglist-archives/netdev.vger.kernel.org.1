Return-Path: <netdev+bounces-286701-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sBSxGwHxAWpfmgEAu9opvQ
	(envelope-from <netdev+bounces-286701-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 17:08:49 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CA244510E04
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 17:08:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3C4F830C1785
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 15:01:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DE1D2D5408;
	Mon, 11 May 2026 15:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="UVOWFBxA"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013028.outbound.protection.outlook.com [52.101.72.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B07FC2BEFEB;
	Mon, 11 May 2026 15:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778511648; cv=fail; b=p6EbFeBWM2QYXqVPd+OA34dIoT8PqEyItqfb6+y8Hq/VWOpTk7/cWGFHcG2heA7WO3zL7NqFw0IaIIqlJ1EJhHJXdqXdWODR1f6ENdkHZxySWunlf6h0O3jI359Z6uahXpESlNICb1ltcphFAfOzYwrX1sVJai3jLy9m7/3XsTs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778511648; c=relaxed/simple;
	bh=fxoasg4a0HnGbGsSA0+IG8VmK3GU1obXXXFjDfYE2D4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Cv2qWYxMveMPc4gvrdgL99pYDfXQ635VuvV2Aie6G9faM7QM78C3eqkTSKXDaLOpWBlNauOnQOchIiGXL6eUSWzgVoKCg804bXl2NFEBfmiUboowOQJ3Bu2HTKhTjBSjqdeKuZXZFhQLcOupEtbKCd7aSfYE0W7O0aV12GKp9CQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=UVOWFBxA; arc=fail smtp.client-ip=52.101.72.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GcDEfsNjOCYUCo0GYObYj52mu9d6m9yY/A6WN7kO9d1OrBlj48HjZDWUulfLrkIr120OfAaL/ETZy7tkPWzQT1ikbWQxjN3ZyjBUN9HfGdN6xNSYB2ofzKOTcRunSmFmA1KuNL/zbGvzx6RnnJlmd31ufWgahddv+hHv2PRUUsXFcarXrK3aao3hTTQTdOOWqDZS4a0+zifgPXAy2wEdNtIQ4qMft9TaKepOqw4HBGOQXSP9lWlgP+fNTEDc0cusJE9heKyBu5YMI9NAsh+aDkOuQkfX9Azn9IXHB7FTyJ4lChQP+ry2nSdcHxq3xn/sF/Lsq3paYfGuLQhjBMdkJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cERAfxlhJ7ayrncDmYGRCh3+eiBHlX91FXTC41i6nnI=;
 b=pRUm6SwWgZDR6hzX36XY4/Jojs+PwK5NlAw0wdSZy92jrXcUQ88jeuBRgol6WXjOmCJ77kexWlZNpxN9BvxbYP+6hC1zzN8q7jgC7gDwWfaTFsJSYMNfyUcUf4weuSGWlZ4l31uciSx4e+CZ+gGcaJL1Ca7MUWqeqcpMzEJ7W+Ax2klN+rHFJIKCHsf3BXb3tXOFQQsLZsegOnHGwAfU0KW3qZimtYgTj66GdeGKUI/PE6wYCLjF/+upovgkQMvlQIyi0SOoNu2M35D6TTkg7Ov9uBLUB7yop1Ys7RXoFUEqNlj22eK7WCZ5egTGZWYhfcOQlYJnn/WJJNJFL3jTqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cERAfxlhJ7ayrncDmYGRCh3+eiBHlX91FXTC41i6nnI=;
 b=UVOWFBxA2rqCTk1XT2dPiEx462iLVmTJv8o41OQaguzRdQRbHnLx4adg8YFYjVt//MkXNKqCjEdtJ8XiIiaieD2SumtIgAOrxyBMaElwhOS7r0ju7Nly3jPNb87isTDAikr0br1TIX/ie5rbMrjBIQBw45Ta49rDvjxIRM8dalOxj4sU1WmEtar4j89lrZ8uBfmAolj3cmtYwnPq/PGdnIJtd2k/Aa/+RTyk1Om+85MigC4BDK38dUqQcF4WcG6axQNdyqdBY9bkpp0kdEzJ3YV5AC2U0jG2bX2aZwbIv6wbadLp2nUc7sPgwfpI5ACQl8e7q21Pfotf3Z+JAYujTQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by GVXPR04MB9976.eurprd04.prod.outlook.com (2603:10a6:150:117::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.23; Mon, 11 May
 2026 15:00:40 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4%4]) with mapi id 15.20.9870.023; Mon, 11 May 2026
 15:00:40 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: linux-phy@lists.infradead.org
Cc: netdev@vger.kernel.org,
	Ioana Ciornei <ioana.ciornei@nxp.com>,
	Vinod Koul <vkoul@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Josua Mayer <josua@solid-run.com>,
	linux-kernel@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org
Subject: [PATCH phy-next 2/5] dt-bindings: phy: lynx-28g: add constraint on LX2162A lane indices
Date: Mon, 11 May 2026 18:00:20 +0300
Message-Id: <20260511150023.1903577-3-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260511150023.1903577-1-vladimir.oltean@nxp.com>
References: <20260511150023.1903577-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM4PR0302CA0012.eurprd03.prod.outlook.com
 (2603:10a6:205:2::25) To AM9PR04MB8585.eurprd04.prod.outlook.com
 (2603:10a6:20b:438::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8585:EE_|GVXPR04MB9976:EE_
X-MS-Office365-Filtering-Correlation-Id: bc84274a-68df-42a4-19ec-08deaf6e1049
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|7416014|376014|1800799024|366016|11063799003|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	6JfNjHPRuIP8yP5+g+VN5JKcQzsbQCpJo1PsCBTf4yoHkRS2t9zJHrBd2HVphrdqbnaNOpxBsbOw2/qDEWVOUVtSpKrz1hkDt3vDabvjkHRJLoH2ochvtjPJgMe6PZljWkqfQZV0B8hgLpPRsl7bF0g+fvsVETqSmZ1sSWYu1L1tSCmHVIR8D3yrOJpz6/S2clzV+0YvjPkTqmWXHiHaYD7naZpfzisUB7nIETItu9fdgaCDA3VK1+3XpwGLWvd/a7i8e0hqh5KevD3b9XQWVyQUh5g5hDJIlxGPRnZZt/lC2aCBH+SPDpbD273Wd9SwJFqshS1Jl7pkVCph5W535jf1G8EmPXVxn36p0i+88FrP4s351Wd5bI6ud8z2euZQzpv+aVFdYAFEclW250U22vgSL/VWz6q8SRhIXHS9ekm8udhAUfRJ00uGnE7xTqytdZV+sPVNzWKRPHcckdvzZVJDx2ODy/3p1liGL5A8vdX8h7HjSx3wMAsshSebfZsdiJig41il5N5uC4Gg/CEC5x2Ft/xfc3n23u7esaobo5wgPuLta4PKdVmjkYCYr5C+mlo0jjh8NiE5NrTlR/x3dobQALN5J3KANDRzLbYpSS09zIPAMpfn2sIMYVWEqklZmT6rST1VMbg9S1QFEzwd8NAbHrebqew9vSby1l576aIGFEMGXD+G2zQykCdgQ1K5
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(7416014)(376014)(1800799024)(366016)(11063799003)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YkQhC85EHlpHpzn+2LE/j06HBJL2bPlEjF5yxss+UpTiu1uVMeiyQOXtTEXZ?=
 =?us-ascii?Q?2MOn5UwQKYgVbTyaMm3iHoptcLmCfDB3vWA6sr0p56g06b+2v0ruj+B9JBp8?=
 =?us-ascii?Q?PBL657pDNocKxey+Dj6MAg7PsFcE/ETgn37ESFre5DydLZYsY1SMaGt/FlzA?=
 =?us-ascii?Q?RkDZtsJo6XGaI+3yxCSgXqDp3kYPgP2PcA6S1LuIoNrqOp2uR4AgqZPPLEwO?=
 =?us-ascii?Q?f4pTU1PRoY1+D0RLX65cNf0ieUnR1zI9e/pXjfz4pXYtDuM8emt7pF61ga5h?=
 =?us-ascii?Q?3rbd3apk7Spwr1AA5S1bhpE3MnfCDd/tYWt4GuAz0nfhtVseg9yfD2JcVN5a?=
 =?us-ascii?Q?3th+YI8E3+ivwB0eCxOrDjMn0tn2JOtZuXzYnbUWVm6yJGV8TKfRh/VETEPk?=
 =?us-ascii?Q?lNVbK8GsQwbClEC9Hcl92NXoK7tvnbgpT399orYrXF+CoX8jh+1efD8R1Ntp?=
 =?us-ascii?Q?hQhi4HvNvp1fXpy5w8RzV93MUgGOZ6anoe2dy36+yYYxhFlEZthfF9UGhf7k?=
 =?us-ascii?Q?HuMONBMt2DZ/1e6Vkd6l3JfKpsShqqlL04CgXBl8w672ZqaYK7fvsRsFUlw6?=
 =?us-ascii?Q?LUu0HjajB94yxHl9sBbW49c3PA3SRmN+8KwYyk4wv1CRSQou0aEO0C19COkZ?=
 =?us-ascii?Q?m8g/mZ1t9+Cq3nngIvGke59nftPpdeSl1qGBFjharhr7fwJrMyY8yCFjKOCX?=
 =?us-ascii?Q?Hx3q3QiBVYr5M3gFxQvITuX4WmU792rewkOJoDPoNtGRcCH7k6kTvc///+/O?=
 =?us-ascii?Q?JMNLFD/nXmOGyPE5nGiKpJ+x4gOx3PF8CJ6fG5OBfd4tKrjrP7K76l1u456t?=
 =?us-ascii?Q?YsH3C+oAJhKHpLhYRJ/QnvUscv8wB9vpGL4kTzt9UF4vigG3sybDHUmOquad?=
 =?us-ascii?Q?lNpqvLNuYhwGIcX1OyoKfqVarXq/4g24PsLL29KkCyv/W4HG2n6EWFRWKPUp?=
 =?us-ascii?Q?r4QUbwte3wQJiiqmqBZfwf4yhUPm9LKpOStYbzmZldm0AyQg8NwDDyk7xgQP?=
 =?us-ascii?Q?tRnXVUzjo+BTLNzVLo2x7VrUgEGyvU8bK7prcTuLTl4IKX29AFAAoOizveu8?=
 =?us-ascii?Q?rO9Ja66I4Gt6NHCelmmkq5FXPfJ0xMQHtnKOH5kSMwVqUasCIfPykLNa4U4m?=
 =?us-ascii?Q?j2xrCZitr3Qv50WUlcWqP+bcYF08UnfuHiQbm8C6F/p2XT9YrOuhxmYUD3z8?=
 =?us-ascii?Q?K6KYkRKwZ5A8OCD9JNkZLM6MBPCdiC0LCjQzBfbyM5UYZ7V7BN11yCxLBx5I?=
 =?us-ascii?Q?H8eGX8i21CtKKJhr595pbgYVfx602h9eM0nBXKzy1GqaMv7+nIHd0eTeJCNb?=
 =?us-ascii?Q?wOOVe/f+OpgUcKwIsOxIRSoKSLhUUiM/BpRqNuHQGRn1BzXIg4r0kVyw0wqp?=
 =?us-ascii?Q?TBz2xehPAB8xYLxKatU2ZFvAEnrLecnh3rtC3nIFT5hN0qMnjPtvffJbEVS9?=
 =?us-ascii?Q?kyiROzzILY+HfIK6b9kkN0g1+YRCiiqWDzLpmrAJdRPPkQVGWgAjBxrkdKWv?=
 =?us-ascii?Q?XqkbhJ9FXdTVKV3pZIR6QUjlx9jq/C9x9wjKEjJNofdlCjNVX8qxZEgSbNUM?=
 =?us-ascii?Q?h9rRTb8TmXNVx5vY6hHbivyV5KaphwCWWhzP22Wf0lSinhwsnPo3mui69UVH?=
 =?us-ascii?Q?nbJlqaqFkYvJR0x7rWGYS4B0IJsg5KemNKtnwQzA9kfBfPamsxEjyKaTdwK2?=
 =?us-ascii?Q?08uYFsOpric6va5KmH2h86xtLDX6c2PH5Do4CrS6zKRqH11wy7O8kWcKUDqN?=
 =?us-ascii?Q?r5AS4b73Aw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc84274a-68df-42a4-19ec-08deaf6e1049
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2026 15:00:38.9156
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FNWuYsZOQvrPtZAfWZsQ/M/Xx/N3zLRKmy43RDuDhzrvGHwskKMMqpjWmjLjja3pTQkOu3GIEe+/gXMAvsc25Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB9976
X-Rspamd-Queue-Id: CA244510E04
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-286701-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vladimir.oltean@nxp.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-0.989];
	TAGGED_RCPT(0.00)[netdev,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nxp.com:email,nxp.com:mid,nxp.com:dkim]
X-Rspamd-Action: no action

The SerDes 1 of LX2162A has fewer lanes than all other instances, and
strangely, their indices are not 0-3, but 4-7.

This is a best-effort constraint, since we can only impose it when using
per-SoC compatible string and per-lane OF nodes.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
Cc: Rob Herring <robh@kernel.org>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc: Conor Dooley <conor+dt@kernel.org>
Cc: devicetree@vger.kernel.org

Patch previously submitted at:
https://lore.kernel.org/linux-phy/20260114152111.625350-4-vladimir.oltean@nxp.com/

Changes:
- remove redundant patternProperties: "^phy@[0-7]$": true from the
  match; having it makes no difference
- clarify that the constraint is best effort
---
 .../devicetree/bindings/phy/fsl,lynx-28g.yaml     | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/Documentation/devicetree/bindings/phy/fsl,lynx-28g.yaml b/Documentation/devicetree/bindings/phy/fsl,lynx-28g.yaml
index 8375bca810cc..d73591315d4b 100644
--- a/Documentation/devicetree/bindings/phy/fsl,lynx-28g.yaml
+++ b/Documentation/devicetree/bindings/phy/fsl,lynx-28g.yaml
@@ -78,6 +78,21 @@ required:
   - reg
   - "#phy-cells"
 
+allOf:
+  # LX2162A SerDes 1 has fewer lanes than the others
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: fsl,lx2162a-serdes1
+    then:
+      patternProperties:
+        "^phy@[0-7]$":
+          properties:
+            reg:
+              minimum: 4
+              maximum: 7
+
 additionalProperties: false
 
 examples:
-- 
2.34.1


