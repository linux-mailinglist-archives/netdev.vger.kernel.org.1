Return-Path: <netdev+bounces-274475-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IPGSM0xSzmmjmgYAu9opvQ
	(envelope-from <netdev+bounces-274475-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 13:26:04 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 91088388499
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 13:26:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CC3923014618
	for <lists+netdev@lfdr.de>; Thu,  2 Apr 2026 11:12:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 528C13BE16F;
	Thu,  2 Apr 2026 11:12:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2126.outbound.protection.partner.outlook.cn [139.219.17.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 831B935E95A;
	Thu,  2 Apr 2026 11:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.126
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775128325; cv=fail; b=UqHfNEzY7Wf2j/jjDpZtO2S3L4a//tF2SO3431GMAd6cnGaREW4rBnRrXfXKQv5HrYNh2JkYkLfAWNfSzp5UVQIadCg1MsV5PVY+ChwZ8FHYiCV0VbxsZnhiwsI1wpCVLAfAvzR7ck6k62f04ot2nFiTvP708guB1/cF6/LAN/s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775128325; c=relaxed/simple;
	bh=mPPvdk4MXMbbzaV1vMEtDxOyCQH+P7JX/iYGb5GSjBU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=coeztMWf5BTTltHIuUNrrVXbYh7X2o87Jn77ujr5UMlCbJQ7axOUz4/PdqblphZxitSd4a6/yksEZNc3+vC2i3UdtMe08ELcP2DJwIbvcbsyK69hVaogTrU8RCIM4uPEfFCajFcB0BrtmWtKPniRE+IWPANfVdLhQLKLlXCYBig=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.126
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hKRIvodLm7MgblSgyQPoy81wmUmIK2wXXEvX10ez+1zlUoxjtqNgcHMbP0+hmiikygpRlwZ1nIybo0U4o5H6/HTIi7/A1c4rFew0sFg9/mGLLxHGz0qfjRe5UmavQ2MOzGpNMJGVNIb+pn1ayNygS09MbGPlbPPdOHy1RfPXJMb8CEYVBRbwZNmC4NXKvD1FjrQXdW0n6YExMkpgtUunLZnbdvq0R5ZZ/ysFBpzm8eIGv0+825V1xYbn7uSMwcJ68dDe2tgPS3zSzJn9swW7YkJGiYeD0gVdWimDlrsD1D5kQvbOBCBEUslLv2z2hmxAj97o7+8+j7wWqYQlnJfGsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZsGsxV/w7Fgx9XqfFGZEoSDxwiP2eaq5CFxLCDDdwzI=;
 b=EqmHRoggtjSjMOQ2TekWyC3o5A/q0GSLNKoaeWdjcfy4/PRRg577YAuHJbZebocRzRYyjZAjmB6rz/dVtc8cHXhXMgtVDkWlgk3Y0lYedGKo6XF5KW4ZXJd38VGHhG91Eql/Qq90p4sVOb0VVxxgn5O8fe0s9chGFDWrc1Ohy6nKUJdOHcSu/exHVORjyj7F6B17Sore/JNJQOMhKgXLIy3rVu9Bp7bZKXABOT0mGHUbMVwudJTqaAAeuFEqn9m2vCEcbhVQWX6JrewWv0Bx/9uRULZxBQebyivZPM3TXFoKlOQnwNQ8jTo7XbP3kUE7gCnWBJCQoUe7uUUbzJrgnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ0PR01MB1208.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:19::5) by ZQ0PR01MB1048.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:d::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.20; Thu, 2 Apr
 2026 10:56:07 +0000
Received: from ZQ0PR01MB1208.CHNPR01.prod.partner.outlook.cn
 ([fe80::63d1:b688:cab7:50cb]) by
 ZQ0PR01MB1208.CHNPR01.prod.partner.outlook.cn ([fe80::63d1:b688:cab7:50cb%7])
 with mapi id 15.20.9769.017; Thu, 2 Apr 2026 10:56:07 +0000
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
Subject: [PATCH v1 12/22] clk: starfive: Introduce inverter and divider
Date: Thu,  2 Apr 2026 03:55:13 -0700
Message-Id: <20260402105523.447523-13-changhuang.liang@starfivetech.com>
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
X-MS-Office365-Filtering-Correlation-Id: 2c48a104-c745-441e-2c70-08de90a67129
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|52116014|376014|366016|921020|38350700014|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	sCTLQhow/pkVqZh+v/iEh3LFn+sBTmbkeo8KktOi6c1rMKGCUm6Z7NT7vYbDKmHU7NpYvE6CcjutsNJRPD5F8lWM7S0v4IhC/ESQG8r1w11sPOkbP4+Qz52BLZeXAl4LyGUwHKn/hn3kblbb/DqCvI0BJ4VEzbNQjMiNYEBuv8yZM4vo7tXryxaHyFxQ29STlyupgv26Ze3uOBRW1z1ieMxa4fX3MutikfuxmK/TT61XTZMXZi62A2h4uVGy8ALUTbE/cN9vHevGa7nDNA6G+dOdglEnP03zXxATx2KqArJ/C++RWuxZRLabo/sZZfsWqPkDHkngK2VUXJvd837hLAOO4sLaaJcLaABtJbDd6pgktUDhA0BNsEKZsXtS75s9pdkvq+ljFKGGsom5hcjvumRNrfijhaaxOGHnWwQ4AifE6ujxG+lpLjdHTyh+ethq5bJIlb4ps3qII6b8gcUebMWgrijc7E0AVAbX3ODZfdM25N01eJ64QAjBmZm1kAbbMZeVdblAvA3UHm9XtNScpMCo0mhIZDMQVp/VBsS7kJwlBmbT3ms1uYaXvkgIyVGknZy8XXfxH/1HJBmeVvB+h4aM8S3j96Niop+jEs+Rs1I=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ0PR01MB1208.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(52116014)(376014)(366016)(921020)(38350700014)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?N1cV/2ALdFlnkB3N4ybnPPQl81j3rch7bSmRNW4jouf8dcSExMipb/9Qxtfv?=
 =?us-ascii?Q?KlCR8gBnYERbTcLq9X4vtCqI3D+yf33iPbcaZzpMgk69ykwAqAfiGb5/pcZJ?=
 =?us-ascii?Q?PkAtBquNYpP4fxuYxXvdUGVjZ9X3gT2sPxMv13TlpwTNG0hjPkkOE6unK8lo?=
 =?us-ascii?Q?GYlfwUYpgo1ASGrGwukxGvS9uRaZDGtzbQkKlZ7bljVIYLkUMv7brTWdNHaP?=
 =?us-ascii?Q?eb4k1dnsu1AS4nnm4iRVVDm5yEDnpgUDTXu+WZLwlWs3f5o+X2IN1ly6Yi/h?=
 =?us-ascii?Q?BC7JMHs8BZOHnn8XnN/inT4R6ZKo3+MyPYN7kt1diCkpwFvUmHxIE23F83Y7?=
 =?us-ascii?Q?F4Bhz1OiaVH7J04OLpMvz0vUCeRYxvCl4MusPWkx+y8Lf8ky3DP0fhe1AjZ7?=
 =?us-ascii?Q?P4GasdSPLI2riphZ0Fw5rFQE++/uUs1sntQ+m0lE3TFWEweVks60Lv0gXukA?=
 =?us-ascii?Q?W2x7R68jrZ51l7Fw1K1YTqTjC0OGClCjGwwNNNZPayKg7wPbiqTf/5IaT8Lo?=
 =?us-ascii?Q?PDTkd60ddh7etwtwckx6OqdrWy3FSD/PDczV2dp/AJ7nPNSWhK0DJkaGHvZI?=
 =?us-ascii?Q?N8Y3FUIaaKBPnVXUNDKiEqgXswzyMtkGliMXtI++9XpWUYNAbRWDwxu52ajp?=
 =?us-ascii?Q?SXBtaZUh9euYpTKBzkyUvUnGhPSKSP4/LcPqWpGvpYUXPCCUplbE6nP3zN+J?=
 =?us-ascii?Q?4+5DggRGDm6WSm/cUI4ok4ZmsuhIbzTdmi1XZEQtJ+AaqG4IXtIMlsxaVrc9?=
 =?us-ascii?Q?l3U19WN8R7eUX6kG4Adn0xEOgOA759yXcXdhgsGJj3xB1krVUIaxXGg+hVxO?=
 =?us-ascii?Q?sJ58TXKWBVWUIWBfWF42W+62hV70wANiC7XSsebRZijAICT9DfxSyt9izocZ?=
 =?us-ascii?Q?37n8b9Uln1LLnJft3PRtRRQSZjj8yix2jljFD4O3heMwrWy7T6oy37oCPvVl?=
 =?us-ascii?Q?pzER0nRX0FthmQB9eiizHkwcStB61xRbA6o3CAblUnVRjiN4Sy1/WmiTkQ2n?=
 =?us-ascii?Q?pwUkb7PWYyz+z9uRsIiJK/HzJ3tSWzKAZlD0OCIh+D481RQDvFubqAyEhCy0?=
 =?us-ascii?Q?ORu6zD8Gb4869CiHdgsMgjCah21GBl/XpDMReJCFmHn9gN5BaQ9d59//n7Yu?=
 =?us-ascii?Q?u4Cic8tZmIhL0X27avFNPwHWYvLNmT/7NRf7jBKta2VfNublUZfEUSTQZ5/G?=
 =?us-ascii?Q?HYt4S05Ei7TcGAay8J2FaiHzA6rw8BEcJvb03uUvsPeOF7DRxk6D9mPoqDff?=
 =?us-ascii?Q?a13geo+DXw/Zt68Rr1yJE8j6sY35TbJE656Mz0LC4z6DvXUJKUzTiYXAOKRW?=
 =?us-ascii?Q?b6p5/1YQPfoIL6L4Rt/1t4Ukvtw9KJnTpjv24klajybKiKD5miz9DkZStGmw?=
 =?us-ascii?Q?ylPmVElHQKfvso/8P3tihvjjhkZHp6kHb+SYR6dK1czn+JLhSN4eu+UGSaVW?=
 =?us-ascii?Q?Ih4fmcvjsBgeLK4Vn2LmzV1Sper1t/IJBqHMIhpmbxbPmy+NsXkaYhewF+qb?=
 =?us-ascii?Q?uBR3su3dWz6k6jJKw2y7SG/mrmkgUk51aPT0VkoasAow5H9roxiUngKDODfx?=
 =?us-ascii?Q?PY8cY9w9AiztUdND0ADTFfPplCv4turOGwxcWjJELb8+n1Kl7HubdfVPCI49?=
 =?us-ascii?Q?wfDZwIAhoN2/LPeydfAhhxKds4Bxq/wgnveU5UyKNM+FXsKccz05LB9rwozW?=
 =?us-ascii?Q?+X6OPdiU+/hKr6BDGLZPYtAIuRhRvNrH27/xqbkGOnBffOSAygTOJk4tGCE8?=
 =?us-ascii?Q?RSCKtJRwtBMlTcl6KaIWj11OGzM4RfQ6g7dVYQi7a0dLJgygPZvG?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c48a104-c745-441e-2c70-08de90a67129
X-MS-Exchange-CrossTenant-AuthSource: ZQ0PR01MB1208.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2026 10:56:07.2062
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8Zss8ALPv8PjHiM+cPK183sw7Kcr1ErbrbGPvSS5UhnnyAzqOWNklhe+uvYSoPe4Z0/qqTNDw7X//KR7A6GLu6qH3wqaF4VZLkSz/VjBIXGSEM1y8uXLYvFcp6StYYEU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ0PR01MB1048
X-Spamd-Result: default: False [5.04 / 15.00];
	DMARC_POLICY_QUARANTINE(1.50)[starfivetech.com : SPF not aligned (relaxed), No valid DKIM,quarantine];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[baylibre.com,kernel.org,dabbelt.com,eecs.berkeley.edu,ghiti.fr,pengutronix.de,esmil.dk,gmail.com];
	GREYLIST(0.00)[pass,body];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-274475-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[24];
	FROM_HAS_DN(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.909];
	FROM_NEQ_ENVFROM(0.00)[changhuang.liang@starfivetech.com,netdev@vger.kernel.org];
	TAGGED_RCPT(0.00)[netdev,dt];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[starfivetech.com:email,starfivetech.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 91088388499
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Introduce inverter and divider for starfive clocks.

Signed-off-by: Changhuang Liang <changhuang.liang@starfivetech.com>
---
 drivers/clk/starfive/clk-starfive-common.c | 12 ++++++++++++
 drivers/clk/starfive/clk-starfive-common.h |  8 ++++++++
 2 files changed, 20 insertions(+)

diff --git a/drivers/clk/starfive/clk-starfive-common.c b/drivers/clk/starfive/clk-starfive-common.c
index 9c0eb7a50d1e..d84b326c9aed 100644
--- a/drivers/clk/starfive/clk-starfive-common.c
+++ b/drivers/clk/starfive/clk-starfive-common.c
@@ -298,6 +298,15 @@ static const struct clk_ops starfive_clk_inv_ops = {
 	.debug_init = starfive_clk_debug_init,
 };
 
+static const struct clk_ops starfive_clk_idiv_ops = {
+	.get_phase = starfive_clk_get_phase,
+	.set_phase = starfive_clk_set_phase,
+	.recalc_rate = starfive_clk_recalc_rate,
+	.determine_rate = starfive_clk_determine_rate,
+	.set_rate = starfive_clk_set_rate,
+	.debug_init = starfive_clk_debug_init,
+};
+
 const struct clk_ops *starfive_clk_ops(u32 max)
 {
 	if (max & STARFIVE_CLK_DIV_MASK) {
@@ -308,6 +317,9 @@ const struct clk_ops *starfive_clk_ops(u32 max)
 		}
 		if (max & STARFIVE_CLK_ENABLE)
 			return &starfive_clk_gdiv_ops;
+		else if (max & STARFIVE_CLK_INVERT)
+			return &starfive_clk_idiv_ops;
+
 		if (max == STARFIVE_CLK_FRAC_MAX)
 			return &starfive_clk_fdiv_ops;
 		return &starfive_clk_div_ops;
diff --git a/drivers/clk/starfive/clk-starfive-common.h b/drivers/clk/starfive/clk-starfive-common.h
index a03824e9e75f..fd9bf6f20152 100644
--- a/drivers/clk/starfive/clk-starfive-common.h
+++ b/drivers/clk/starfive/clk-starfive-common.h
@@ -103,6 +103,14 @@ struct starfive_clk_data {
 	.parents = { [0] = _parent },						\
 }
 
+#define STARFIVE_IDIV(_idx, _name, _flags, _max, _parent)			\
+[_idx] = {									\
+	.name = _name,								\
+	.flags = _flags,							\
+	.max = STARFIVE_CLK_INVERT | (_max),					\
+	.parents = { [0] = _parent },						\
+}
+
 struct starfive_clk {
 	struct clk_hw hw;
 	unsigned int idx;
-- 
2.25.1


