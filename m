Return-Path: <netdev+bounces-292786-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WJm7B9J+GGpBkggAu9opvQ
	(envelope-from <netdev+bounces-292786-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 19:43:46 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C71F5F5D17
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 19:43:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 05F1031321F4
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 17:37:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C170408037;
	Thu, 28 May 2026 17:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="cPJ570G5"
X-Original-To: netdev@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011063.outbound.protection.outlook.com [52.101.70.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12C53409601;
	Thu, 28 May 2026 17:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779989715; cv=fail; b=J2E+CXslNjsiGjzEbax88Ze9fIcYPIlQG5YFFOu2DpZCvoazgXlLTiLxrM8EL3lxjn0k3N98SXyGmO/VaHs0inmEmFt1ApTZm0iLDtp0XjjlxaaNSPebcxX6J+naHeUR8VLmsZn1Exlmkxu2iQ+jBjOeOJ5AhhZIOyp8Rs+kLQI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779989715; c=relaxed/simple;
	bh=OuYqXY315S+hhjebqTUmJzt/pnjC+rxfUCgwMQGZET4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=n61c7xs+RMifNY11huqdV6pIaT65uNWpB0nDH49tq4IVvJOiAjOR6uovnTY0sHd/5EAHh1dXeF3SOP+Z32pvVhTn8VfB8U9wI7G9QTneqdD46UGC4oM+RChJ8kl9yIgIS3TwthVJqvW5rfLWy8X/v1u0OFC1pC2wQOwB7zEaaZY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=cPJ570G5; arc=fail smtp.client-ip=52.101.70.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jZnNmdwFlisgYCKhoDlcQSJrAQPxF7YFsIVmQT2kC/PDILxRhw+iH1+e0n6Y7jsrS3TpTccu/j9QYiwr2r+0f7B292aLWUZQAGbWALhl5Ai8gcGlB4Itmye1dLq3hKYe+4vzMKxnp7RbMX/eROgHcJu6QpHtAIAiwdB0cKhfmKvo81ArgTjzSYjjw0P5fFFl0pzhgws6IxG2vj9pPdusf2oTjVTnTgo/Ct0YfRXX9G1QCM8kQzW2uzwVJlPv4GgVLnvgsnqLB7z3MdkSm/WY6HJwV+6BQ8r1ARtIut1jVGB9BqY/lvzCXIy26vhLsXqTTyqkzmuQMQ8aR74I5zutdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KX4mBlrLwgXJvp+5bZOux9FanhHr5OYANhiOPm6SEEg=;
 b=xk/7kPkG7OjEG34hYTA1Usp8JyyUEOxhL8i1QD1MrbVGbAmA8XI5qJ0vGL3qvhFx+irktZ8QJQwan0pOVZzMOcefgsJqgs0y4HUdly0s8GGf03ZarRP0gkEOzGKyw8n1pisKdczmUKFtqAtmJo0GsnIHSkUl9GQPW2sdZdrgHhZnqDku7OkiXJ91/UjesMgEOgsPfILGk5tX+IYihPT9behaCf18S58oxcWM6RBxHB6siploegSdQ/Oa6fQN89yc3XPgIjMbr8ZbSLylPZhXkEtXUNVJyMuGFU9Xigl2ot4ULPx3bDo2Sxxl8Jh5+fMGvaXKvF5TO7oUj/ALYIReIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KX4mBlrLwgXJvp+5bZOux9FanhHr5OYANhiOPm6SEEg=;
 b=cPJ570G56obpERJpN11dUhPQE8Su1BXNLi4m9gstkpV9dXkn6tXkuqmfmEqGu+vs8uNQwKj3BScM4EjL7vpUVaFFwbVCvHDThXEdgirjzUDQj1JTMuSFkN5Mbw0/vaMDE7HK899KQ10tB4XUe0TiWW0NhX/cSAWF5ETUqVSsLA3xu2ODCn68G1EJyCooJc2g5Uw/OkCuTlbQcGjvcHhIbNUPZnhYK+pnve/Pp5OuE0PForbUSoI9eBb4xmAcayOT1i/XDAF8iXGBayrcAQIScqaaHDwjQguiB8qGFLkBszxz+IUao2AY2p9bVp4nQ7dqwIjPRzbDJ3/UqTypYKo30A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GVXPR04MB12290.eurprd04.prod.outlook.com
 (2603:10a6:150:319::13) by DU0PR04MB9657.eurprd04.prod.outlook.com
 (2603:10a6:10:31c::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.13; Thu, 28 May
 2026 17:35:09 +0000
Received: from GVXPR04MB12290.eurprd04.prod.outlook.com
 ([fe80::1739:3404:2175:33dd]) by GVXPR04MB12290.eurprd04.prod.outlook.com
 ([fe80::1739:3404:2175:33dd%6]) with mapi id 15.21.0071.011; Thu, 28 May 2026
 17:35:09 +0000
From: Ioana Ciornei <ioana.ciornei@nxp.com>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH net-next 3/5] dpaa2-switch: remove duplicated check for the maximum number of VLANs
Date: Thu, 28 May 2026 20:34:50 +0300
Message-Id: <20260528173452.1953102-4-ioana.ciornei@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260528173452.1953102-1-ioana.ciornei@nxp.com>
References: <20260528173452.1953102-1-ioana.ciornei@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0195.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ca::20) To GVXPR04MB12290.eurprd04.prod.outlook.com
 (2603:10a6:150:319::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR04MB12290:EE_|DU0PR04MB9657:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a9ca22d-a7ee-4fc3-a91c-08debcdf76c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|1800799024|366016|376014|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	rDEOT3ngo95vILM5j10lTZ1Z/cM1/5gqr2U/SioXE0cX+xS2ZSZADZkIWjdCloafNWvVkri+r3aYZtiCWeInnasDEeyA69cGJjKnNSCoOXNbP5M3aR78nMNnBasEbrY6zs2Ixf/T8+dp8s2/yLbuAY0RtnpETjuHZppo0yQpsVC7s/m3kXpBdbgjW5VFnZPtNwq1uRcaZD5M0UuDxAEon39xY+cK/9/xmKhL5SSXjtklZQZ6HRs/EtX5LYs0D5VUwb8fYbKPE3mRk0MNrfmWJ3gvLX+sItlBeDO/dyMd+SvbnqSCn76k26CMWXIoT7AiGnKnwZLXbGEKuMzJT7zY2+6hdjIUyJhkBtLqyVxO01lTTh+mg6jM5VMXTtU+0cmJ3lVo1pLbXO3mB3c85sR1TRF5zGHCPEeo0bqyjzessGVBLQeTCSyu6LFY10lv3wdvh9Spi+R1/rl5JSi8P9VmW2ryRnxc8W/5zOkKduSxqcnPXt4yrSnGWC272mZFMQeDPHNSsB8PZ0FbSo5h06b9dC+44ph1IRq+ysw1JIg7xA5x3BlqGM9xLcZzGmGMgThhdHiOZ/AoRlLjfO9/f+oX76We6uelRQTuY0QUQOSbayIcPrLP3M1Nc/U9Mc+jr+zIwsbC1PuAgglnkhsRJ3zu+Xor4dj9NKqclyhEk3Fu5NkSppxfxfR6WPOPV4NrUfsi
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GVXPR04MB12290.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(366016)(376014)(11063799006)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1RnBmpAnlhidTZNXWX51lYnjw9bB2fYDkOilw/Y9hU2H5EvZIjM8pFpp4uN7?=
 =?us-ascii?Q?lqI6FUZx+fXGLBYWL1IK8vArf2/fjiC7g7MYN6FZSlmpkRj6qm47Z+agqVcK?=
 =?us-ascii?Q?kI3ZDeNR4A3Dv9EmWuJrKCV9q9Z6XBIGIot5rH49tea1O4+avBEz0vdtOOeS?=
 =?us-ascii?Q?YomdmN3fZyvCpcFbtQhGi9f9fzQbfEcG+7HYN3e6P3wxXZTteauugDvQgVw1?=
 =?us-ascii?Q?2MjUwYu4E4/+JozNqUyqQAN/lSzt+PeRH53Tg62UqIX36ULssKjeCIdsmufN?=
 =?us-ascii?Q?yziRuQUEaHEVAfMFdzx2Bgfra1BMR+GNjb90fImc8lH32Ym2gRwe9hWNB/7C?=
 =?us-ascii?Q?e8YT44cXjocFiGNJNY1kktjyNNGwGlN1aNey0L9TYcdUmF/Y2CZzUayVPvh1?=
 =?us-ascii?Q?5sI6JwZs1wHBJyGGUQOPaUd7PmQNoNqtAdplSmd+NpKz8U5m8a5Phij0YIT/?=
 =?us-ascii?Q?yhiheuAmcR6gf1GrXxCt57MGnYc1L+009F2emXvQTxSi7o3rKOHqBJlhiNmh?=
 =?us-ascii?Q?T0a7r0O8giEt1BgZb/4au9iGjtLaCLjn/vGpWkQUBAmxKvdWtHVQuZUcIYIX?=
 =?us-ascii?Q?VYvYOgO2Tuz/QrYv8ek6kgDiXqTiIgsKfLnTdLoCVvw9/ZYg8n2tfN1qsug2?=
 =?us-ascii?Q?vcCDfJ0Vig0R0jvhB6nt+4yICblli3SQy9lJFd18u3BH80MIGVnOAi43Laq6?=
 =?us-ascii?Q?L7bBi1dY1UdJc3Zl0DKKmSBsNpGV8T2ZToDqDErnt+gWn5D1jbtN/tAukqYW?=
 =?us-ascii?Q?vFGZLFiRbamv8dSNQ8YDYSdHb0meTPyuXSJeaSieB61xYOqcC7Osn/367wko?=
 =?us-ascii?Q?WoUiz4jBx06eRW9y+rhURbAIvEmaT+qDIa3M0VEO0XdKglIgkAYFWOG4yXll?=
 =?us-ascii?Q?kFpkC+acSQcjsKrW3gqm/kI1FjRpe7qgc9lktP31AvQ+JDLYSK6bUAe3GnvE?=
 =?us-ascii?Q?ypYHlx+KyNyxwTylMQmZuvKmAh4sEjKanMASBvf3kg6lWuxU6Kx6v7uF0268?=
 =?us-ascii?Q?HjrjEdSgpRVnNhigsq2wAtHRKQPt2kDM/FgJozFqUS09UiUne5S1+hQ3g1tp?=
 =?us-ascii?Q?mP27BW6FCRZ9vP5AdFhS7+p6eQJMMVA+o4dgA6ckc9W1iiUy8ys1ljZU7Ujs?=
 =?us-ascii?Q?SNza+PjBkWy2Mbi8ttmq8ZGsKxZNXySiaB301QwDVr+QxOymI4bvNzQaNygi?=
 =?us-ascii?Q?qYm6YFkYEBUpEEQDLGxpups3uGCyxYRMI3QgoG15g1xWyY5HwzxXRciIoipu?=
 =?us-ascii?Q?a5GWK1RhQns09rkMcQ/YBakooV7BV9LlhKp6gtbtBkWSpaumj4AHNg1yRIy0?=
 =?us-ascii?Q?Dh/hbvJUR86ZVGW1IMCa7+21PVkGqgvpv7PnBqn/DZrGjGOR2QlgdWUqJAZq?=
 =?us-ascii?Q?41M1PC4Rn2zm/8V2shOyqqvlahxI+eRxCOdSLgcDv1qrP6o+RLJJeZ/1/zRy?=
 =?us-ascii?Q?WWewQ2B2gwOTNI6BSpx+TTunSA9zIG+8xm7Trb+UUwAEjGPwMNNrJQSFj7ax?=
 =?us-ascii?Q?/9XiFtelpLZgZWA9cLKxFwrpzak3iLWn5Ii9lvFHJcUguX385WF2TBqNY5UA?=
 =?us-ascii?Q?JX+nWCwuhjzb++Co7ocO4z4xXnx1wgGlDeOPXNViiC5aMVeRe747uFogZv4l?=
 =?us-ascii?Q?5meYfCxib+ZTZLlwN+k9ZX/d0pniuALmIAn50wmT/L1k6PjIMZrc0jHM+Yow?=
 =?us-ascii?Q?Iipqn/BNpro7YiR4sz2OTRn39viV5qzQLYsQy7WdMjnXfLz6N8hsfBTofAD+?=
 =?us-ascii?Q?Nv5tBA97Bg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a9ca22d-a7ee-4fc3-a91c-08debcdf76c2
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB12290.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2026 17:35:09.0122
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V/bcXf2nOe34gKCg6O/pF2vJd5t8Leqvw5kGXcdzDDvbQTO8nR8t0epy8HHZ1j/EIGvlWjqNQHKV+DB4Z9HAaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9657
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	TAGGED_FROM(0.00)[bounces-292786-lists,netdev=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[ioana.ciornei@nxp.com,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[nxp.com:+];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_NONE(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,nxp.com:email,nxp.com:mid,nxp.com:dkim]
X-Rspamd-Queue-Id: 8C71F5F5D17
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The check for the maximum number of VLANs is exactly duplicated twice in
the dpaa2_switch_port_vlans_add() function. Remove one of the instances
so that we do not have dead code.

Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
---
 drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
index 53a32b21b959..4022635171b5 100644
--- a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
+++ b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
@@ -1811,16 +1811,6 @@ int dpaa2_switch_port_vlans_add(struct net_device *netdev,
 		return -EEXIST;
 	}
 
-	/* Check if there is space for a new VLAN */
-	err = dpsw_get_attributes(ethsw->mc_io, 0, ethsw->dpsw_handle,
-				  &ethsw->sw_attr);
-	if (err) {
-		netdev_err(netdev, "dpsw_get_attributes err %d\n", err);
-		return err;
-	}
-	if (attr->max_vlans - attr->num_vlans < 1)
-		return -ENOSPC;
-
 	/* Check if there is space for a new VLAN */
 	err = dpsw_get_attributes(ethsw->mc_io, 0, ethsw->dpsw_handle,
 				  &ethsw->sw_attr);
-- 
2.25.1


