Return-Path: <netdev+bounces-269867-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qPP+HpcWvWnG6QIAu9opvQ
	(envelope-from <netdev+bounces-269867-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 10:42:47 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DC8F22D82E8
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 10:42:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0BF42311C424
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 09:40:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A270D3845C3;
	Fri, 20 Mar 2026 09:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="BBwGJeYw"
X-Original-To: netdev@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010052.outbound.protection.outlook.com [52.101.84.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A52B374749;
	Fri, 20 Mar 2026 09:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773999635; cv=fail; b=N7vQptLiO8KXUt37yTweoijSnaOw+Eh3h0+bapOIohP0yfQipHoqb5HdptzM2L1/NDfxLbNZVd4DOv8AoXKUMEaUe7L/Mn5xEX7xxmecgtG3lZU866OZtKcZq2iZRwrUnRLK82cZrqoc8+PjShpURzbXbCnP0JujNIVtebegf+4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773999635; c=relaxed/simple;
	bh=7hoFGFvElO2x5iN6mOrknEHD6Ol1Ix/6jn6K3eCoMuo=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=LX+ySbY/ieH9hBUA5KqHAlefPJVccJs5O+pHW8s6pFMeVInHXeUmUxAaETWjcwrGu+BLQ2UjdeRHM2I1HzNZ54LrALZB75KhuIu7Xiwv2/faWsYF2ILsuZolvs0djVXBQST78R2LZfRqC2Owy63HPxCfEzoUZLTov63co6LruSY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=BBwGJeYw; arc=fail smtp.client-ip=52.101.84.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AQIdnnkKhYV2WXnRXmJe7b9ufndP8IDUzBxwnqPAkZPLzqWfnh/zSseO1ufMoplBdFKdIfvML7V+BLuI0pE4UupCwdfZmR4eBrUJ7Ix/BQyM91QYtk+wE5rGZCAYiTnouN0kNXfPhUWBe2pBcjR9qAYJWoafr5+f3O4JkITKUxa/IyG/yWGGXh8pU5u79YuzouPpRUID/E55u3v0wZe/HvEswZNiGn4i2IxQHT4qr77FqeLl1IgMWydE7NdSt61Ml2sghDEka8odwKdDVflO48oJPoB3IBFssneNmSOu912fZUiln686GwC2+E3z8lwLqGu3QFzQauSnuNdzUzSXlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l7N672ZSvXNmbFNEFIIihEE3FyIZ56xLZdJs5Zd2zIU=;
 b=MB0nzMtVQyj3o8ife/aDbMzkYmtEur/Lq01JfCxeD3QHIB5ySs4dVPjLeGyBiV8DPc08CH4reP/vhxRReDpLa9DbYSHaZQQSinjxxog7heDoBtIv2TwgQYFu2J2iddH74HiUCzr2wewsKZx4ECZcybvCHcpkhMoE9wdDyPu67mnth6hrkaPJ69OweuQMooKb3haixbc+LFmG7n7hghi5iH8IHNjSXoFR6JKYVxLw2K/vCzU5ZjoePd3MgzU3LYL+ONn7juXASe6oK43em18JijUpbfdT/dmoiSfSNGPdneQ83VjRVF+PW/ErnunIBTM2y9LJka++JvZu9Dnnfm+7RA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l7N672ZSvXNmbFNEFIIihEE3FyIZ56xLZdJs5Zd2zIU=;
 b=BBwGJeYwfraacIypWbBmT/bBLBte6hMW2DJwSZHvh24F7zMPNt+ScmJJZ72uVzMFP43xPrFvabEWAfBk/PQVU4nBLA2FJNVCWWpKSzwSS0BRiTLIjhZB4/X2EjibhBZGr7PW+k92Z1IVMeyrPhe0LukJkw2n4cxuRJXSXp4vVlp4xHIZmnllWZpiIkc/T0xYnJf4U1M1xUYNMnp4XY+KKi8nHahnILQVKQqysVoryJoriY/jDgIGXSowqsXMBTv4oNjugduvZ0tKUrrMwCMVPJ7wHSogjhMOpCAhmVqq33UOS74aBpH5oqPd97IXzc57i8ttW9MjxTerdyUFAirn/A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by AM7PR04MB6870.eurprd04.prod.outlook.com (2603:10a6:20b:107::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.23; Fri, 20 Mar
 2026 09:40:19 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::b476:c19a:24cd:3694]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::b476:c19a:24cd:3694%3]) with mapi id 15.20.9723.022; Fri, 20 Mar 2026
 09:40:20 +0000
From: Wei Fang <wei.fang@nxp.com>
To: claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	mkubecek@suse.cz
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev
Subject: [PATCH v2] net: enetc: fix the output issue of 'ethtool --show-ring'
Date: Fri, 20 Mar 2026 17:42:22 +0800
Message-Id: <20260320094222.706339-1-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA5P287CA0101.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1d4::15) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|AM7PR04MB6870:EE_
X-MS-Office365-Filtering-Correlation-Id: 7fd4768f-87b8-49f8-fb6b-08de8664b366
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|19092799006|376014|38350700014|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	5T8HH1uyb+GOl4pWgg1j9GKkvsVVg8urUBfUn5PZurGohQajmu/ctAFy3EwdPXeZVSEWnDpXqofhUmd2iUzQO/GL0eomkGtqivtffC0Eq9uF5py3+8vTkan/tbaHpqIIXeakgec2pDwiEoulnj6xtwTQCewjOOPPnXdtd/RM9XVWQJz86TAxavQbvqSxrb6BFINmDD4nx4md8OFVaHcet9rMzcB6oLJ2qtJGNNt455QEPxShs02KMcZ+xRnr9MuuysD/or32JvY1SZaTDxrkj172wvKIpDdVvpvURbH/NxXgfNi20LcwHQHD9MV95J9tmeudMriYPoHi1H6Qf4df+5J13HIpwiIyYOI8UkC/Q67sLJQoi4y+oeh/QBcDqyKCBYn1HDh2PHjra7ErKWXvGtLEFkQNHQE+3C0fPuz63Azriw0ACra6fnJVaJbVe1mAicBne8ZsIqRH9G4MQrxkhfznYDk0hza/hsGIaaY28nImMBJM8wS5wpUXW2ICaSSfqe9HiB3bURkStc+aEfpYp98AsB96evIQapDcH5MTwqDvmheR59IZhKOpCtY2UFNDbXAaFZ7DX/zmedA+VKtrTlZzFeh8fWwMBlePbII5chXILjqlaoJa0FnllIJS1XATq5fjnIzXiQVjQoDRPoz44YKtOgKMU/HErCK/TVQR/s7+vgiwTeMdjBnT+c4PWCW2WYbEgKvGW9/ukCmrzkP4TD1b4j1yguD2XDG+601mUhZni4IjJjbfi7Yv+NZiKnD12R4jplUW8uPN/180MrDb9LOLA88DPNoF2nUvvdv5kjw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(19092799006)(376014)(38350700014)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FQdEn0Bz33dL9KCb3zB4uzyUFRx5jXy91uiDvpHwIlVyqFWJ5pKmN522gn5J?=
 =?us-ascii?Q?NG01MRt3R6+f8/Ji0JqezMQ9xvIx0F6bnjNT0sKDwQVIlIXTeefizjpJraOY?=
 =?us-ascii?Q?0bxIzspLvH5cyaEVvlKUq1r8+s1i0sZS62ViALOO4HCG8a2xhvlxAvuOx/Nq?=
 =?us-ascii?Q?QRGZMgvf1RVFq2PVvpRB9bEpqEkTBu9Q/v2xXEHwsovGQGVEWNYg+k5trHMP?=
 =?us-ascii?Q?0m3gLVA6jHpL1icoD7ZWmVHzx2w+lnZwCO6TzYx/dcLtaEUNU/2r3BQLbpie?=
 =?us-ascii?Q?GD/CjCocRJN1iXC9Rrj3ywzCxg0o9lYGZBnlhIkEh3zWIty9zB5OSBcFillc?=
 =?us-ascii?Q?iswADBk4EHeEvLsv+0VVhRNnC6WZQH/tQ3o0lT17D6T+6GqIT6ehXbnB6pVd?=
 =?us-ascii?Q?oudCGWVybt6c3CyWLS56yAc9d6LsjXHDZWcIPc3VZHXAEfHcRtb4qiIHP11q?=
 =?us-ascii?Q?o6dmts9hVok+M8JpTxisj5m/5xkmEQeNlwDjdJTHUlnfcq5JkorshdLD9L0z?=
 =?us-ascii?Q?AqtYE3O2lNt8Dlh4t7YZouMnvdkcQdNgUHlGN5rOxoxlHy3wueP2USuXxqhf?=
 =?us-ascii?Q?nRN8HfqZjADtEEsyTe1Q305/DUlzETI++gNgaQHvWLWRMMWBr0SMwUVV/wjI?=
 =?us-ascii?Q?+KfI4ajsl8LY+/uNzPDXgFAIOS1wBLiPEvqZ8FQjzDd1OjDHHuhItLw5GB+E?=
 =?us-ascii?Q?EMsHhrni3rmNk/Fs3pKQzYUkAI8Q/OF5TttUA3y9EHHn21/44+4rvpDyJC0g?=
 =?us-ascii?Q?4JX+myeuvCSQIZqmhCjPXFlSYgq2a0QrHZ3SgE1vpack37MuGLWeh6H94xXx?=
 =?us-ascii?Q?2pvKkiIUBhybCjP2V80v9mivWQXCM67Wkc1iGo7TDUNwsIyYt2VCknsRNJIT?=
 =?us-ascii?Q?uvS4FilZ/dTLvZz0kd4mBTofLUWFkozCjiqdezA7mkgVM6/tZTWtgVP6wwTc?=
 =?us-ascii?Q?WOmOlPfPz8gTI9iakfgCS0VKFHbNeZtig9gFJ9dwTcEnFf8QHRfCpn+jy94L?=
 =?us-ascii?Q?06ORdNSUjeSxdSmx6EPp7cEd2WyqFVey7wS1ldnGoq2t9mLSBbByBg5kgFVu?=
 =?us-ascii?Q?94FeNf4Ei3VxmU8ld0jkPQCjJDCZq4r3fwXPFrFd1Ut38kVxy8hra1uOP4E4?=
 =?us-ascii?Q?ZNxMcNydYFvrxgY1LTJy8ih9psBGHZvC6MNoSgzoqMM8pLTK3VAxT9MQCZJc?=
 =?us-ascii?Q?QDVfyEAMGp+aoHW5Q1l0Bk9wMBwPudRyPpYkxU6GrSmJVJQwPkc6/HQMbVyy?=
 =?us-ascii?Q?ZHl/ZtUyBgqYfC3W1ZT2rlYg+phPK+bjZQJOgMH5rlTUwpTAG3nRJefQ7Msp?=
 =?us-ascii?Q?aiZveH3QeY8zQjqyfNBHVjtDghe/e0fLMGVKuGiMzERydyYUGeYvi6r6hM7U?=
 =?us-ascii?Q?6UjvCE8ZNRwwSd3Hy+3jShGv6OoFTScukjbK8zZSdwariwhto8jnQzz5C0aa?=
 =?us-ascii?Q?kEmcGu25JLEyKRUbjgp3msS6da0DFNYhhdNQSUF+tj/RtxWqWsC7O9ZvBWHz?=
 =?us-ascii?Q?fSEpnceCy039BUWcPTxb2Zxf+89leJrG3RLjewjZX8+eK8TQtNnEp/MO++ED?=
 =?us-ascii?Q?raA+D4FEY37+/QxZjfTICr/P891jL29EjdkdCoCzYUzcaF8MmFeX6A2D/WPb?=
 =?us-ascii?Q?5+7SSNJevZzzSHi4c6D/47vWb2gnRgMBd92EC4Z9SfxfbQLJFtVzrmAnVowy?=
 =?us-ascii?Q?NbbQpj2Zhi+cNcgrFYD3YzgNF6zJO8HONiumgi+Id7464Nju?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fd4768f-87b8-49f8-fb6b-08de8664b366
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2026 09:40:19.9722
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UymNwuKSUNJ/QVsMkhaTEYwv32+pnSboHdyITLLGcxVsD4xM/DV+qDfKnMlGgQ4pnfL5MaEjx1zRFYw59GZtQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6870
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-269867-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_TWELVE(0.00)[12];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wei.fang@nxp.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-0.971];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nxp.com:dkim,nxp.com:email,nxp.com:mid]
X-Rspamd-Queue-Id: DC8F22D82E8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Currently, enetc_get_ringparam() only provides rx_pending and tx_pending,
but 'ethtool --show-ring' no longer displays these fields. Because the
ringparam retrieval path has moved to the new netlink interface, where
rings_fill_reply() emits the *x_pending only if the *x_max_pending values
are non-zero. So rx_max_pending and tx_max_pending to are added to
enetc_get_ringparam() to fix the issue.

Note that the maximum tx/rx ring size of hardware is 64K, but we haven't
added set_ringparam() to make the ring size configurable. To avoid users
mistakenly believing that the ring size can be increased, so set
the *x_max_pending to priv->*x_bd_count.

Fixes: e4a1717b677c ("ethtool: provide ring sizes with RINGS_GET request")
Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
v2:
Set ring->*x_max_pending to priv->*x_bd_count instead of SZ_64K, this is
also explained in the commit message.
---
 drivers/net/ethernet/freescale/enetc/enetc_ethtool.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc_ethtool.c b/drivers/net/ethernet/freescale/enetc/enetc_ethtool.c
index fed89d4f1e1d..2fe140ddebb2 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_ethtool.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_ethtool.c
@@ -813,6 +813,8 @@ static void enetc_get_ringparam(struct net_device *ndev,
 {
 	struct enetc_ndev_priv *priv = netdev_priv(ndev);
 
+	ring->rx_max_pending = priv->rx_bd_count;
+	ring->tx_max_pending = priv->tx_bd_count;
 	ring->rx_pending = priv->rx_bd_count;
 	ring->tx_pending = priv->tx_bd_count;
 
-- 
2.34.1


