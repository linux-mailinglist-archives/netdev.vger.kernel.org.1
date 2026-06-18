Return-Path: <netdev+bounces-300375-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id bocUDZa6M2oxFgYAu9opvQ
	(envelope-from <netdev+bounces-300375-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 11:29:58 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DF5069EE16
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 11:29:57 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=nxp.com header.s=selector1 header.b=jZIyleJG;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300375-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-300375-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=nxp.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E704C30FFE9F
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 09:28:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FA143D7D6A;
	Thu, 18 Jun 2026 09:28:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010051.outbound.protection.outlook.com [52.101.69.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19D5D3C5DBA;
	Thu, 18 Jun 2026 09:28:23 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781774904; cv=fail; b=Gcyfmi5/yHltWvjtfkfF9fOtTYNZBVviU4o794FCJYJbrE7YfaR7k6P3u1YdAwzCKZ86k5rKwZRJ+MV/IB1zCtnC3x8U8+7EBiysO19kN/+W37Wv0nAmIAfYrlQ0R40uw63Y5Bq89MJ2h3wb8B2tb57b7CqTjAC3MtCREWBXTqg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781774904; c=relaxed/simple;
	bh=IGp29YY8DMKk9+lYrtJ6eb4eP8JpC+LcbFmg///3isI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MevyyGDHdx/IfcWx+SlvTgIfA/QQvwEgATy8t4kc5DeUwrbg6cIEs6DVBM89pa0VOPaadAUjZtBc58+N50YwGoyUvEkYquVKDNL+6xRoHrFUbCHWMLbcVj7JWbh5aa03jGxmn9ev8WELxqc7IF+HRZquGn5zsr9JRCjwL2Nw8/c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=jZIyleJG; arc=fail smtp.client-ip=52.101.69.51
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OCKaqaVfsR2g0HIJoNsqg4gntTDqDCsXvHdpDJbASfBxMtbI3uzswpZ2qK++hhIKGfoVW8M0ZmuEsR6Kqq6Yfm8GquzwDfVMuZP7yBCB+fTfqG/XckL3/yZQZMmEdrBp3mCwhSxfAzxNLIA6JgbXr4Gwb/axf2Rf/sDG85+waO89DemAtmvRAfjk72wGymBrFhFvwV/utVIliGenMZagN7q3wkNgMTmQMUHqNFXBlvwurfK1u+E/8i2sc20IUeE4/qTTWYZpIWZSzm7YMLqTY+ysgvNdX2mUwtxBLKBACKBdcZ1bc9+yBOCikybXkl+D5pLGDVh4sUxVmrRHU7AGCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YUSVO65/yDnxmHsTriariW9OSqfmrKETxAuaWdZ6J2w=;
 b=VnjukSy5tYu4VVqSqXUGMxftAaOTV8A0Ik6xQlJgzgZbh/qvJVD2jlN7qZIpqcp/c5VDeDdqanpwYDYewTnApsojIWeChHvHsR5JeQxho0izcWBW2UZGm5+RG8aQfjWHQXKhJY6Q105ilI1FPYy1TjSvCit9k3Ym1ekWpWpdDGhSgoV9Ig5H5g8zPz1SHISBSWz3upUvwc5wYB4eZsKYC1mIOJ5FxA+QagWT2JNEuYpCJfCLPicT/sq0bY7jMlE40DUDGDERTuv/iG1faWIk0MN8kNCcE6xqNFqvYpYUSXlyxyM2LSbAZ0Xn0r4UBmJ1mmuuGQSepCxtHkeDImS+BA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YUSVO65/yDnxmHsTriariW9OSqfmrKETxAuaWdZ6J2w=;
 b=jZIyleJG+SfX/OpHRVbIXJFvUUqPjvcEvWvKkDewpVuOWqxTp4e3N2X0AE+geULgdmJ5a1oxkpNjkXu7HOAnfqe2cTMN2yGjGkkBAGZO7TKXKCuKNgFORCi+uuLI/KttvXeCkdWHqwLcx82A/90oXj82fL7vvBjPbrniqCPc5lG75v37Z1UdfDBPKWgytIMtHgNOQfGpfvRpHdaaRGZce3fPcG34W6e4AxUFLavS8uRnbhxtMz17WHMLCbBhv/spf5BwNXAhvLbMnrDN7eBl5soGtWenO7r2VpNQQ7SBUTnaDUkRkJYqbWTrVNxknGU0NwPrfOSrJcGxtqCgCfEDPQ==
Received: from GVXPR04MB12290.eurprd04.prod.outlook.com
 (2603:10a6:150:319::13) by AM9PR04MB8163.eurprd04.prod.outlook.com
 (2603:10a6:20b:3e8::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Thu, 18 Jun
 2026 09:28:21 +0000
Received: from GVXPR04MB12290.eurprd04.prod.outlook.com
 ([fe80::1739:3404:2175:33dd]) by GVXPR04MB12290.eurprd04.prod.outlook.com
 ([fe80::1739:3404:2175:33dd%6]) with mapi id 15.21.0113.015; Thu, 18 Jun 2026
 09:28:20 +0000
From: Ioana Ciornei <ioana.ciornei@nxp.com>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org
Cc: f.fainelli@gmail.com,
	vladimir.oltean@nxp.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v2 1/2] dpaa2-switch: do not accept VLAN uppers while bridged
Date: Thu, 18 Jun 2026 12:28:12 +0300
Message-Id: <20260618092813.432535-2-ioana.ciornei@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260618092813.432535-1-ioana.ciornei@nxp.com>
References: <20260618092813.432535-1-ioana.ciornei@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P189CA0006.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d7::10) To GVXPR04MB12290.eurprd04.prod.outlook.com
 (2603:10a6:150:319::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR04MB12290:EE_|AM9PR04MB8163:EE_
X-MS-Office365-Filtering-Correlation-Id: a213d66c-649a-4bf5-b1b9-08decd1bf00b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|19092799006|366016|376014|23010399003|22082099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	spisIBgto8RHqB/tWjw/TUYyXpP9gTKY8vBKWCBcVeYEIpZI8SrBCARAyWJcahgnS78cRnwO8W2044dun1gsrEAMPqnqFu/oL8okZFntQ2JyuwR0qZ1pkYq2aR6iruvc5mqWBI1lfMze9/yXNzv5NwQnz7iMViAOV6HxEKGaSTDpcvj+MqcqDH+3c6+fD9IDzs+33rw7q3L4nXOHUno/2WFtWwqaXtZ9TTKtBRDn5/IXZMYkITwWZv7Blgn/IuYtlM79yQhvzomIXflq/ABKP9z5qzI1vJlmCrrBc7kauEyv2hSCeV4NHgNHXk6L6v/FxOrH8Rr5CuuUQXK/823WiwS/E9a29dJd0JcjSNgC2BlWH2Tvql5yIUIfdnY/3Vz6oWhx2HTwVtU6QCM3jOLm6rKcK5BzjrPTRHl1rVEE/VhFaI0wL7QdtbYyJxosjyub8FDX3EddwwFZ/MAVzFsbyGAjnDCCWK1mDUZ4fBotRTgmEN6ZRakNipQFhmh2HnVXTJNJoUvohpe6z4ad7hva76m8QfuwmqeNkZSEcZAVZu8ddj42NO/z9zB6SddA69cs3t5SErI4LYfSlTV3d6L+qTgHiIS3HNqJqanb8U7cMwW718X+7q6woZ9VZFFFqRJuDf52ewMMqh0DMSA/5U5c5PZD4LjXlmyVgJ77Gy6TzyaBbVUUua1I8qumvuCQqM38
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GVXPR04MB12290.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(366016)(376014)(23010399003)(22082099003)(18002099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kcD77W34eVcLHxRvCNjywnfzFccR2NCDTYReYVMKua2fT42Z7Z+LCLpuRYMV?=
 =?us-ascii?Q?GoSJIW2RTmZk+/9+sj8ihlJs9n4ziIqQBdmSheBVfnkSis7tujttMFyKpP46?=
 =?us-ascii?Q?4CuL3k6iP/trq+k5VkL2fex1ekTC3YM+OwvWRNSpsKNABNsnViH+zxMmBpOk?=
 =?us-ascii?Q?AwKe9kGMe9yUlTwTGUlhLaD27ZQLxE9x6T3FuJAImIVrTajaK72yPNrLzQrI?=
 =?us-ascii?Q?qdDVp0zL0bKaNA9EoK02s9F8P1pN1qWRsgiECdhdoZ30p10MD5qO7E/V3WgY?=
 =?us-ascii?Q?j20O3Qp4KawCo0uYmMDu+FueDnEA3T8tf9cTgRuPDZwL+9h0Z/w92A/NXBPW?=
 =?us-ascii?Q?BOuoAokFgjS8xArc007v5TGIczWzWJi+DDuKzfHMwiWsE0mBdnERIO/ltv1y?=
 =?us-ascii?Q?WAI5xPpczmRWFHxBdyFpV/In85TLrOCR8qB+FFjdvZxepkTzSOXXrZuWdCwH?=
 =?us-ascii?Q?broUhvq8/90MUKr3Te2J5roMNZ+JtXLIa2UHwzk6Jr0AKqlUwBb8Q/TClG0p?=
 =?us-ascii?Q?4H9oHioG/2SYrAZupuRz4dGCIRUwzXl/rr392ac0Yy3xzWh6aHgYIF6z3E35?=
 =?us-ascii?Q?EfM3zh2f4bZZ5EbgAkqZ/XdjlOlx3y5Enjjw+B8cSZmKDEeQ6B5v4iDFl4lQ?=
 =?us-ascii?Q?pY0ILwwjiHrWZzKGKl0Yu434JBVksD8MNupzvkxTtfeUTXNM7VYjqlIcRoK4?=
 =?us-ascii?Q?XPRpcJAfK5erU6M00kN1jicinhG3vwi5A9Yz9e5GAUeNporrW56ZfyQ3OmZO?=
 =?us-ascii?Q?9n7sfRAFM9ElcSoLe0jlXdPy8BK7UXKWS3FvZ3GkpE3IPsiPQXtqZE8/IQuy?=
 =?us-ascii?Q?gd7NX7CQvYS65V9BjhskIDrsh1+P06QE3b2vafwkygodQNz4FGM2N68uyHCD?=
 =?us-ascii?Q?E9+zYzW3TujA082rBxMAEz/95xYTUslB5wd1gjwnayeMl9kZUgV+jDUBQj3i?=
 =?us-ascii?Q?qSh/V6iQva8U1TtOrUYGXiHsjy1My1oEzT2xSK3kxRiOqpa6isCLI5raxJy0?=
 =?us-ascii?Q?JixInt6U/yxbKDDzOAPVs+jJoqvFTlDm/ttFbzDn1JKixUxQL6iJbjRhXR2r?=
 =?us-ascii?Q?ppWZdSzgYutzKeLZkgD/UzTkzbkACKiofsplfrqRlfvvH0njkaIe3MemwPil?=
 =?us-ascii?Q?1c0Iv393MNFXu9h88T3IVnRoKsJwrE/HcqtmV0x5XgdDhe53LUK9wDXsQiGo?=
 =?us-ascii?Q?fz4UJlFIyHFfKKWTTOLmfgLNOInQyOWwDP/hkf+FRL4JUat1S4QSY9etVaBv?=
 =?us-ascii?Q?iGowaeY0Me2djbNM01TQ4Rm2q+zT8RUnQNkeUkR5DqEyUZRzrZAIo8Zk8r4y?=
 =?us-ascii?Q?Y6anUCgiioqajzrvb0G84tQp/r9I4R2uUXHEhGprbA1MX9wLq+KEMJ/vK7Pb?=
 =?us-ascii?Q?C24g4zdkdSW33wpM8w0yYtNS7qFb/uvRcRYdIyO1jvoBs5NBQBkPConvetwl?=
 =?us-ascii?Q?TU8Hi3oRiPH/p6ZGxerY0AaugN6w9TLNvP0j8Jo21vBlXbvg3VlgsuLq55Uf?=
 =?us-ascii?Q?Xj0g8q4FNIIdFmbmI/eT/glgzW/X1Cx7SfsowlTNEtCo8SxPQuVC71PhSVDg?=
 =?us-ascii?Q?ad3UHgt6h5It5YaKQ/89wlRZi8h0Wt//VgL6b7DC5Yvmlaue/RhXkXTimRmV?=
 =?us-ascii?Q?b3riRe68YPn3Xky+Ne7C95o8r71NdNy0B36Jl2pcSS4YRMXDPfoUfOv9JFM6?=
 =?us-ascii?Q?lkf7o+fkJt/M4RP4PSG9s7eQL2u+2XPPBLDCwyhMpPaG9qS7gEzVr5IRMaFa?=
 =?us-ascii?Q?zC3FZ4uIIg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a213d66c-649a-4bf5-b1b9-08decd1bf00b
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB12290.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2026 09:28:20.9220
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4j6pZHmVlMExP8ig1IxI498w0VGhBJDh+sueU6nEQXP/BoYUgz5AB3rV6QlMFLe1Evqc6+31gdPokgDUa+53IA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8163
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-300375-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,nxp.com,vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:f.fainelli@gmail.com,m:vladimir.oltean@nxp.com,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,m:ffainelli@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[ioana.ciornei@nxp.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[nxp.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ioana.ciornei@nxp.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,nxp.com:dkim,nxp.com:email,nxp.com:mid,nxp.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9DF5069EE16

The dpaa2-switch driver does not support VLAN uppers while its ports are
bridged. This scenario tried to be prevented by rejecting a bridge join
while VLAN uppers exist but the reverse order was still possible.

This patches adds a check so that the dpaa2-switch also does not accept
VLAN uppers while bridged.

Fixes: f48298d3fbfa ("staging: dpaa2-switch: move the driver out of staging")
Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
---
Changes in v2:
- patch is new

 drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
index 45f276c2c3ec..83ccefdac59f 100644
--- a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
+++ b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
@@ -2233,6 +2233,7 @@ dpaa2_switch_prechangeupper_sanity_checks(struct net_device *netdev,
 static int dpaa2_switch_port_prechangeupper(struct net_device *netdev,
 					    struct netdev_notifier_changeupper_info *info)
 {
+	struct ethsw_port_priv *port_priv;
 	struct netlink_ext_ack *extack;
 	struct net_device *upper_dev;
 	int err;
@@ -2251,6 +2252,13 @@ static int dpaa2_switch_port_prechangeupper(struct net_device *netdev,
 
 		if (!info->linking)
 			dpaa2_switch_port_pre_bridge_leave(netdev);
+	} else if (is_vlan_dev(upper_dev)) {
+		port_priv = netdev_priv(netdev);
+		if (port_priv->fdb->bridge_dev) {
+			NL_SET_ERR_MSG_MOD(extack,
+					   "Cannot accept VLAN uppers while bridged");
+			return -EOPNOTSUPP;
+		}
 	}
 
 	return 0;
-- 
2.25.1


