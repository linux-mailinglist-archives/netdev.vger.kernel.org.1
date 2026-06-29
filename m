Return-Path: <netdev+bounces-302587-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 2WeAKx1ZQmq95AkAu9opvQ
	(envelope-from <netdev+bounces-302587-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 13:38:05 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 05ABA6D9841
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 13:38:05 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=nxp.com header.s=selector1 header.b=YEo1EGmV;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302587-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-302587-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=nxp.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 17223309228A
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 11:25:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A243403AFE;
	Mon, 29 Jun 2026 11:23:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010005.outbound.protection.outlook.com [52.101.69.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E50F7403AE2;
	Mon, 29 Jun 2026 11:23:55 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782732237; cv=fail; b=LWrwT0gzrf4nQZJMG04aPL1FDWfCdP87KMFQPqU8vJRjAf4AH0Xe9BwXl+wQyX6i4vM1MYA4ezn3n41g56H41UmW0QDjBa2eGjZH3mDysndravgV4WtlwSRJNOvf+/fKYxPUxVgSNY5zz3mDlTxC6ZADm52Cg2rlZY7uoQinPHw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782732237; c=relaxed/simple;
	bh=cvZaByU2tHdwEil88ToXDeuWZ0O3Tep8uXc9AcBLyTM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=M4C70tj9JSbtQNDiemMZ0Io06JjFcl+Bth/997h4MnD290KHV3o9eYwJNKHJCJvuvwPKxIlUFFHQqP41stXV/GphLE8V1afAMF6gf6PNcbQmVJOIL8VUt640YfOqY4X7mVga28hy/Av8wb8oiijjhxIgF1uSiv1uptXfkyXDVq0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=YEo1EGmV; arc=fail smtp.client-ip=52.101.69.5
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TEuSyT/avy1aW4DXDKXg5KU0afXF/qS56eN/3mGBcXjTHqptSBTwHMtL/pfr2dEKFt8HkffN1xYzRpNTl+e34pX5JDI2yqqMEcY3etAKlOMo8JSYKq3Ztkb4Ig4YFr8ekAAPl02yLv/KLW7cSNll1N2UYNDEGT8f4xwNbr37M1rSet6UOi301CL09vlBwY9O9A7KnjNGVG9BzrlK8OfQresHZvxpBb+VToLj6FbYZnAMYVzhu1T2dq45d1SMH4VsNNFjy/P4TNCFJUpynREtDFixCFahFMshh5bJG9fcFR93+D++U60NBYw8spKpMWWFUVgUnBoN1tjq7LZ5zVcsbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vBmD0NpRhDx6ijuk+o70FsUdMjDbgiIi4msFAUj9DF4=;
 b=wXVq1miRPCuIZY/ockmuABi7i3Bh2H7p+IRizuJYuOg19efNvvKAMwsDvtMGHI7E0561WKgViV1ULfi0SdFOzLhStYG9rHr9JT6SPilXK/+sg/1kG2xj6EohDGQJ/MM9uYPzm4FKO461tWh66HjtsXesKKQ3ebVd7JqqV6jdKW0qZq3DtLIOdp1637iVHRJG9YehjVqlPHlcR3jGBuMA1TP+/PzQf/D9b1XpNimwcg9lhn5jqSrdh7uhcdkVe9kjnOIGArlXj9tZ4ihyRDYk5z4tC2dwGMxXTBQt+wpJtFTodIyLtyEp39pssyYXDmO0rKE+4jVp0aMeTmVzPhkcFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vBmD0NpRhDx6ijuk+o70FsUdMjDbgiIi4msFAUj9DF4=;
 b=YEo1EGmVBAJLyODsOpUXCi3VEEJUZLJBAihIW5tGuOpzlVLOotyTCsQgw0Tbns1Z5wlWlEh60VjQSxfwjX4UrLmK+s2g2aGeIiGL2w4JZMzCvdySvAT+7GWuPPfNsyQmiNkP+wjj8neAF5b5RWnLGOYoLY8tbrcaP0Pg1/K5nWM2N+y92vX9okeMDwUbo9US+C9fwmOdlKJaEpyMetIIZ5xIQLGehtODHVpEPWhrY7FV4nkh5V+flxKWI/ElxDC6HpiZypSIh9At9VevROEKh7Bs4Rfosafdpw2qLXYao6ESsd5JMQA0fRxNIguIburtzBNbZvSegVQRjGwcsi+2Hg==
Received: from VI0PR04MB12302.eurprd04.prod.outlook.com (2603:10a6:800:31c::9)
 by AS8PR04MB8563.eurprd04.prod.outlook.com (2603:10a6:20b:422::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Mon, 29 Jun
 2026 11:23:52 +0000
Received: from VI0PR04MB12302.eurprd04.prod.outlook.com
 ([fe80::d68d:e9b6:88fa:9b5b]) by VI0PR04MB12302.eurprd04.prod.outlook.com
 ([fe80::d68d:e9b6:88fa:9b5b%4]) with mapi id 15.21.0159.018; Mon, 29 Jun 2026
 11:23:52 +0000
From: Ioana Ciornei <ioana.ciornei@nxp.com>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH net-next v4 13/13] dpaa2-switch: add support for imprecise source port
Date: Mon, 29 Jun 2026 14:23:09 +0300
Message-Id: <20260629112309.154328-14-ioana.ciornei@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260629112309.154328-1-ioana.ciornei@nxp.com>
References: <20260629112309.154328-1-ioana.ciornei@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P190CA0061.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:656::22) To VI0PR04MB12302.eurprd04.prod.outlook.com
 (2603:10a6:800:31c::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR04MB12302:EE_|AS8PR04MB8563:EE_
X-MS-Office365-Filtering-Correlation-Id: 290eee77-ef10-4854-491c-08ded5d0e640
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|376014|19092799006|1800799024|18002099003|22082099003|11063799006|3023799007|56012099006;
X-Microsoft-Antispam-Message-Info:
	PECYS26beKdjxX1on05cdHZ7xSGz2LUG7jibZkMSy+7AmV89R6hq0uTg27q/IbO6boxeb4WSlDZNyuzaanjhewUiZ4EcNa0Zy8DkZsy4hGrIMWKsMK9ZW1aHmCvl8+J949TQMHbydDGnC5YMfKZFWJzTQZ03Me02ouX4mCupSbXpCXRwk9FHRe/I47/CkQU0EI7wjw2xw61fC1EW5P1iQS12a3uc2hvRF99CfzFCJSuv7l8SzUlGcUIT35orjGqQ1edq3en1bU3EgpCM+e4IM2Jm0cTjwPmS9OIGXZZdCWjFlDmRlza5x/yDyw6RyZbZmhssNweQGEZqWjWkCH0uKPCw2XyfyNtth9GHc4N8jg/IJxBBPfHlhNTUNiL6EaHSJzCgIBc07BlpWcno2jInIGytvsqGOYtkF5CBLMEna8UnCGdKS3/Ii8Ga2TX03kUwDDBnMiS/ZQcQeOBVrAuOXhvLdBSWgEZXBz6utM9Fma2bQKaAL6TSVFGzR5QraI10dbZaOpcE/5OitXkFYw9yZFOQtb8PRC/qf02tnapvkC6OBhQSyfn28mmryM4GmumMO/G7wQAUS+sQ8DI5Tl/D5ZaQqfInm0WEHTnT8ckXugluoc8HivIvjAES/xJRQx3W+fIFnLhuN1cuVeHCtl1Hzsk40cdiZPCZd3f+Y0SuoTo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR04MB12302.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(19092799006)(1800799024)(18002099003)(22082099003)(11063799006)(3023799007)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zG9WCJ2rZ0sYVKp1Ryzb0liKbEAgxt9CqZjsIcgonSY+DwuJ76405J0tQ/L9?=
 =?us-ascii?Q?8G4N96Gz9+osEdmR8VctQ4d3fl2nSxRRojG8figO5y0sB6d5yr+Js/pu6Ivy?=
 =?us-ascii?Q?fAMGpD0cwVKd009oJZEV0o6tjXnTXeuqQO9Gd7gHDG9lK9mW+xnzW+7IbQfQ?=
 =?us-ascii?Q?VBrk6SKC4KQx0reMKceujIw4vS5N8HXTNKLjlTiKtEd96cZHpwaXwH73WlnE?=
 =?us-ascii?Q?e4ClZK/6xaPlP3qQntRyffGH/2fJfTMGNRavC+cKifaJTeMpSk4g4qGPxF+u?=
 =?us-ascii?Q?xq1oyg47DoXuJSc9+TXmy5PIBC+zZSsjCRbcdqHzAUBE5CWRfetFEe1IFP3y?=
 =?us-ascii?Q?3RzcuMyTzwU3O+6X12uA3lakOh/TOlCvbmGGqxmpOVP68AABIdIutPqNhHZT?=
 =?us-ascii?Q?yUWpck5p5x+/GVOIu4GL9QsEFyYPrDvkSXE5h1F4CDfyK1Y+OR7pT9nd0lOc?=
 =?us-ascii?Q?HfTkE01WNZx1sF1EgSCuiJ9aIrPctn2JVx9yAlKLknCkNYPG9hKG/7BiZR9A?=
 =?us-ascii?Q?f97NpL/ieOXhLOa0bC0ehXGU2L8kTXP0QG/FStjgcYUl0Bbtt9ENhO2iPr+d?=
 =?us-ascii?Q?N1Qvw9CjQUENVSJYZMpKw2zEKM8C5k8TjUO0u6espRMERqqqZCKWCJS66h7K?=
 =?us-ascii?Q?TmNu5zCkNrkonraZnpDoWiByNzRZbSnSpaetOTA58pwPSTMI0b+hSmvaI0JK?=
 =?us-ascii?Q?iiEW6BBeEiMfLEmerQQxGy3vXc0IHYYt9q8NESZ+L/n9p/PEH9/DuCFuSKEI?=
 =?us-ascii?Q?1PNJVd1VprOfXud34x5mI6X3Hd4GM2Ptmqwg1XxKgzMuVmtvH8soQjtJzWdN?=
 =?us-ascii?Q?WHtWL5YuEesg8iyPuOcdO6MPTjLW2Z9/lqMgVilCnuxGutnKElhvYY/MvTxW?=
 =?us-ascii?Q?Gj8aeKAp3SPsBvlLePF2xx5yL2EIU8hFcm/IeqeQHVFEeW7Sn25C3+SiPN6e?=
 =?us-ascii?Q?xuijdevWkt0r6z/eQ0+pdon7L4cpiCYG9NrnhFatQyZ1Li408oTSpZwnOCHB?=
 =?us-ascii?Q?bWEa2kaAz0Ezw8I9RTmIwV4pK1GA5TFVD3NXMrRcc9ESPaZv+6FWUapVtCSc?=
 =?us-ascii?Q?Ps2yzIY2YrS5fKbSuYsWaevKOtRoWxRvQvahiqKjQrOI49fveFIz3KGefAQg?=
 =?us-ascii?Q?II8fdIX5UIB6Uq7tFdTB/HG3uSz2kNwgdloqm2eAWW9kfeBweprsLTW7vrCz?=
 =?us-ascii?Q?wHOXR1FDFC3G9rK3G2QIIbjC4STgyLiG9aM1tfFVVcPex1PHyG73SpMrjgQL?=
 =?us-ascii?Q?FbtB6RWQBfyq+HqDDR9qVHmJfjCtzxWZEKQ5WZUoe7PeWrMPsMIcfbl3faJ3?=
 =?us-ascii?Q?/rMZdQUfroEIkkZw6zqCrn1b0K+GH8749oRW6DabU96zW/E0aR373GHXpv5J?=
 =?us-ascii?Q?WCMjkl3N/oq9Nrs8qh6+oOGJBUbzPvAjiVkgK8Ig3hjbJdFJgDF1Bn+XWfPD?=
 =?us-ascii?Q?POF+Am+1Ag9MXFH3XeWO95u27tfdJ8mbJIqudTOn2bxh85zl1jtFdrJrIXMI?=
 =?us-ascii?Q?SPW0QzChsxxWPCczQxrv5qkMqEJV88OCAF8U5LlG0NbebOAX6vtiNS7XeN0w?=
 =?us-ascii?Q?qx/tWCmllssf14iwGQ8f0c/hMEcu1h2VCTAResQhuvP39q1nV+3QncF56jtG?=
 =?us-ascii?Q?r0hw1HODOM86ZNnDZuwVFHJEUGQXlltL82hWJjutRu8r9Bm3663zSom5ndox?=
 =?us-ascii?Q?NK1PNUr55HeN//q5oN68MKOj0IF35M3fFig0mPrVJeyMzXu+gKSAJwV+v4GH?=
 =?us-ascii?Q?c6iSpB1/Ow=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 290eee77-ef10-4854-491c-08ded5d0e640
X-MS-Exchange-CrossTenant-AuthSource: VI0PR04MB12302.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2026 11:23:52.7527
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ltturnsivjeh4Ob4LKMAxGHpFpziPgl8nvQMkH5+umzTq2W7oeRRXDhWG+62xL60KGWWc+X8AbIRH6Nc0OJEzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8563
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-302587-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[ioana.ciornei@nxp.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
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
	RCPT_COUNT_SEVEN(0.00)[7];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,nxp.com:dkim,nxp.com:email,nxp.com:mid,nxp.com:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 05ABA6D9841

Switch ports configured as part of a LAG group are not able to provide
a precise source port for all packets which reach the control interface.

The only frames which will have a precise source port are those that are
explicitly trapped, for example STP and LCAP frames. For any other
frames (for example, those which are flooded) we can only know the
ingress LAG group.

Take into account the DPAA2_ETHSW_FLC_IMPRECISE_IF_ID bit and based on
its value target the bond device or the specific source netdevice.

Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
---
Changes in v4:
- None
- Note that I did not address sashiko's feedback related to the
rcu_read_lock() dropped before netif_receive_skb() since even under
PREEMPT_RT NAPI is under rcu protection, rcu_read_lock() being called
from local_bh_disable().

Changes in v3:
- None

Changes in v2:
- Fix 32bit build by using BIT_ULL
- Take a reference to port_priv->lag instead of reading it multiple
times.
---
 .../net/ethernet/freescale/dpaa2/dpaa2-switch.c   | 15 +++++++++++++--
 .../net/ethernet/freescale/dpaa2/dpaa2-switch.h   |  3 +++
 2 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
index b94d83f5ef06..8320b26c3f72 100644
--- a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
+++ b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
@@ -3120,19 +3120,22 @@ static void dpaa2_switch_rx(struct dpaa2_switch_fq *fq,
 	dma_addr_t addr = dpaa2_fd_get_addr(fd);
 	struct ethsw_core *ethsw = fq->ethsw;
 	struct ethsw_port_priv *port_priv;
+	struct dpaa2_switch_lag *lag;
 	struct net_device *netdev;
 	struct vlan_ethhdr *hdr;
 	struct sk_buff *skb;
 	u16 vlan_tci, vid;
 	int if_id, err;
 	void *vaddr;
+	u64 flc;
 
 	vaddr = dpaa2_iova_to_virt(ethsw->iommu_domain, addr);
 	dma_unmap_page(ethsw->dev, addr, DPAA2_SWITCH_RX_BUF_SIZE,
 		       DMA_FROM_DEVICE);
 
 	/* get switch ingress interface ID */
-	if_id = upper_32_bits(dpaa2_fd_get_flc(fd)) & 0x0000FFFF;
+	flc = dpaa2_fd_get_flc(fd);
+	if_id = DPAA2_ETHSW_FLC_IF_ID(flc);
 	if (if_id >= ethsw->sw_attr.num_ifs) {
 		dev_err(ethsw->dev, "Frame received from unknown interface!\n");
 		goto err_free_fd;
@@ -3171,12 +3174,20 @@ static void dpaa2_switch_rx(struct dpaa2_switch_fq *fq,
 		}
 	}
 
-	skb->dev = netdev;
+	rcu_read_lock();
+
+	lag = rcu_dereference(port_priv->lag);
+	if (DPAA2_ETHSW_FLC_IMPRECISE_IF_ID(flc) && lag)
+		skb->dev = lag->bond_dev;
+	else
+		skb->dev = netdev;
 	skb->protocol = eth_type_trans(skb, skb->dev);
 
 	/* Setup the offload_fwd_mark only if the port is under a bridge */
 	skb->offload_fwd_mark = !!(port_priv->fdb->bridge_dev);
 
+	rcu_read_unlock();
+
 	netif_receive_skb(skb);
 
 	return;
diff --git a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.h b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.h
index e8bc1469cbf7..63b702b0000c 100644
--- a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.h
+++ b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.h
@@ -87,6 +87,9 @@
 
 #define DPAA2_ETHSW_PORT_ACL_CMD_BUF_SIZE	256
 
+#define DPAA2_ETHSW_FLC_IF_ID(flc)		(((flc) >> 32) & GENMASK(15, 0))
+#define DPAA2_ETHSW_FLC_IMPRECISE_IF_ID(flc)	((flc) & BIT_ULL(63))
+
 extern const struct ethtool_ops dpaa2_switch_port_ethtool_ops;
 
 struct ethsw_core;
-- 
2.25.1


