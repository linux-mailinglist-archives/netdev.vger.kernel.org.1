Return-Path: <netdev+bounces-284900-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EOvrBBNc+2nEaAMAu9opvQ
	(envelope-from <netdev+bounces-284900-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 17:19:47 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DC984DD0E4
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 17:19:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 99AC330814A1
	for <lists+netdev@lfdr.de>; Wed,  6 May 2026 15:16:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F43248C8DF;
	Wed,  6 May 2026 15:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="I3SMcWY0"
X-Original-To: netdev@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013060.outbound.protection.outlook.com [40.107.159.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6A2D48C8CD;
	Wed,  6 May 2026 15:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778080581; cv=fail; b=ZreJux6twOl6lTnI/ZdOL/lm9PVuC6N1wtnWmzkM3XnZpEbBIwC9zcddivDji1mn4ZeYGEvrO48mVAIxOvnBjQ6Az1TQvS25v0Z+M02ZHK/FU2JtOmSwI/5oBaWXzCYtTmBdFnTOQr1uAeoRbQpxWxKVubtXV0gk8u5fACSTLko=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778080581; c=relaxed/simple;
	bh=yboYupGe8xf1UzJqqsMfPY3dUHudVbLakn54yePGZn8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=H4gCHTNmLhJpYpVWD1wrBBBazPIzoPxOxuoNZ6u6G4pS8qfssjXThZt5jzfhIg1Dpf9zs63k8zabnk7I8t1pSSyKSo95ysZjTFpBqJJCFF/OoRdEja20xqeTvwFY/85U8AlSRnvCyW9eS1K9N1XZVzwsIyfJPCJu/DUJzOulzbY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=I3SMcWY0; arc=fail smtp.client-ip=40.107.159.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XYBU4ORH6F5YadTqQbjCpNEoh9ot+iVCAsl/XSWoWu3SDacQ5HSvVAv4e37WbW0eoEvKv+J4d7wb1lMYxY2loLkM82vdcXfvDSTEdbpaUlcAmDKgidWMiFxgwr6lZXbtCaDWYKkIqnJvATtGrbLOcDmM9bwz15mSOF1Yslwn8Sbo9TJdYcG9GuYVXO4mRmLBPG9GVJl3EQegrOVOTUstAt7dy5OATdAPZw69YkuLkXzMPO4V50Bi+vRWt2mxCdIhniaw6BdzWCGrJWUAoaX5jP/qkU2dK0LmxNC8nwB1y4PIDvK+6lnIv9TY+PwFxYYT3mMK9ABvjBdQ4qrPU8KGBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7wfJNp7ioaKB+zQd0XL1Ul3vR22F7wHVsZxTLFKsFaQ=;
 b=tFBqZmPHuGpD0iX6+aZ857xEbi2ah6ttzNfuzLAynOfGeeFNG5KkCYnqvB6J+kaTyI0OXqdV5LIg7Szv1PQFXYHVnXv2yowvy1lVtwcOZxdrZxjT6bGifF28lPufpgttS5iOhzZZA8zbSMn1etRyjKdSa5mdgW2KoW91DyESBYwcn6vkQAqP41+LlnMAEeYxxbZak1758wLbBhQW9tmhPp5m/RNRS53MpzAgqL3f7WQaosfX8VIy1UU4LawXPDMO6NuWYa+pCG5ADAQ2G3aO5kRShnu8N3DOWemd8F+2Vpi6PfrrupHvPG7w96M+LBS7+aSbOeXuL2p/ErGcjfoyhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7wfJNp7ioaKB+zQd0XL1Ul3vR22F7wHVsZxTLFKsFaQ=;
 b=I3SMcWY0+16gU6MTK0I3wAskBdOHsOT+eUe1UB/VFmHHeh+Pm2I6rj5vml5sut8OdO6suRcW28IWevSFWWzsUcw6Vk8NrRpo2ABA7xO+gPrlnttfVkRvsrHFR10+Ih/iX+6AF3SiVgn/CfRtWwAiZxsUcI5fkMc884gjwb3XO4rYtN2HDbJmgSk7ciqJnWP9lJhLDIVrE4vjsQEY42jvukamxQZ0E60uryBH0K4COvSd3Kbk2KCbGK1eArkeMByg8yliOqLrcYm/K734LmLWvVBoPufizveCRU97EnqKqOWulAQaSh4OlbE9POq5ZArMICPhGTTKT04AWvUuT/ODKg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI0PR04MB11503.eurprd04.prod.outlook.com
 (2603:10a6:800:2c7::16) by PA1PR04MB10626.eurprd04.prod.outlook.com
 (2603:10a6:102:48e::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Wed, 6 May
 2026 15:16:03 +0000
Received: from VI0PR04MB11503.eurprd04.prod.outlook.com
 ([fe80::cbe9:4c03:71b6:359f]) by VI0PR04MB11503.eurprd04.prod.outlook.com
 ([fe80::cbe9:4c03:71b6:359f%6]) with mapi id 15.20.9870.023; Wed, 6 May 2026
 15:16:03 +0000
From: Ioana Ciornei <ioana.ciornei@nxp.com>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH net-next 03/13] dpaa2-switch: change dpaa2_switch_port_set_fdb() function prototype
Date: Wed,  6 May 2026 18:15:30 +0300
Message-Id: <20260506151540.1242997-4-ioana.ciornei@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260506151540.1242997-1-ioana.ciornei@nxp.com>
References: <20260506151540.1242997-1-ioana.ciornei@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P191CA0018.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d9::14) To VI0PR04MB11503.eurprd04.prod.outlook.com
 (2603:10a6:800:2c7::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR04MB11503:EE_|PA1PR04MB10626:EE_
X-MS-Office365-Filtering-Correlation-Id: ed8a1e23-a840-4bb9-95a4-08deab826346
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|19092799006|1800799024|366016|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	4E4deXTR29v/R1CzbsNFKuIKR566zzURt0d35n1ZpvdyYQ9+MwWUmtu6JWrB7zID6oXyZmgLn2ImD4RwE6tL+fuQWrac+uMECd26p9Lhby3AspMekc1Rw5DELmGabyWwpjqJOP7y2cW3qhtC7cneQ0L5lOyI8pmJGxcF0n43uL2i4z52IUMZiGqEFLOo0hw4UhifJGhaGUdoiYVckPGhwb355ZSClky4D0W45Pequ3fNYWSD/fqbVz4V7JYRbv9NL0E9qfDtYpvJoHSHU6Z3Ay/yruLma0OoGVIEha7PaRrXJwjzVru1TuesDoP6/OzJua1uhzKtDMuZMCTeOYywrCRhnM89D9IPLisipjwwppYqBD+H2E6JHDNqLaJkcPQ5b0bSUosIHQBfGBc2KRUKyCI7fahDDwNwYNvV46fgGsGzoql/1POgIodPINBfuW9XpmpBC6LGSBBtNGwcP1Tjz3R6fgQ7pt5q1ASoQpYFOfHIH2W9uWPfIRpuut+kI8xqf3AamIBPor6O/plAAkdFtGDjMSjaSbwPNSnnISPhv9NK+4JKwJ+1n/mRWDBd2r9JNVklnkauv/ELMAi1d4P4hD3Cg5s9PV7gitoKBzc9r7JL91f9ndykU0mqEBHtFBSXXhvnmVqkXmdq5L2M8O0vR41W1HsV8QXwj4dO67Q+W4qvHMXon7BU4diUkYy/g0w2
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR04MB11503.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(19092799006)(1800799024)(366016)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?IQXJj9YU6hAMBa+L3XD5nfxf8kCfYRt1KTSGsF1MSQvrJW3Pz1Kohb1PQUIX?=
 =?us-ascii?Q?ZBE+dwlnGd+voI2p0/4bFn9omPu8t5sU4v4TU+KALtF33id2ubipXeJG6o63?=
 =?us-ascii?Q?qisZfKxHsKthNMl5eV58KFAPknPghdBCxCMxwJdrObiZUcYuO3/Hia2QZ2EU?=
 =?us-ascii?Q?jhK9+u08KfeLGOtvME3Ju4bs5gZaeIndbDMhoL9O38JMKJkocLwY0zFveOjB?=
 =?us-ascii?Q?h3C/5hKo6nN9cw2JhSrLnTrWktwCfnmrr4wr64+NoDBR9dzSYuZ89vOae8Z4?=
 =?us-ascii?Q?wDeAEdU42KUUnSm2G8fTUcMm+TgTkiGUXm7ampbqh2fijsedzTTlSpKkIUzu?=
 =?us-ascii?Q?KHAq5vi3Kgl/sqt1os9MfyfKkZsVVLztMaJUUntw0of4OTegmJiYBdGy35Ik?=
 =?us-ascii?Q?EoU4wQzBc/6vSxfaCK7svx9lpnBSxfN5fbFW13AfoufaCoLxm9ik716GTZ8R?=
 =?us-ascii?Q?RPNwT09WRzILJ1iJ68NEz1BnTNGBCAwCTmVACYCDGTmNhwXQk7JawEpxCvuZ?=
 =?us-ascii?Q?WDYgXRQrSXllozrLRo7egH+SwToYS9hfJ8aCmGL5nx5TDqX1+BqF6DpGZYiF?=
 =?us-ascii?Q?48XYZdQUNuXShzs9D0B2RRWeOkr4mle3pEb9nH9GXieq1+LNq2b7IuB5dG1w?=
 =?us-ascii?Q?NmNojPzTAC+ylS4MDY1QzO+cvVpuOtt4rScjnVtfZNurQiGfa/Z3iQwyCDxR?=
 =?us-ascii?Q?p3Y9srSyahrKy/bvwW3MR413rW8tExviQ0qi8KhWrb7Mbf1S+zaNGZyL0+u3?=
 =?us-ascii?Q?PNryuO3oAwiltxzwun0tY5nTt9GGjTMczyroEXkKhDweymHZdNS637iaLgN/?=
 =?us-ascii?Q?ytyFH4FJiIFWFofG+K9cpq1r3YldTNOwAe5rHUt7Z39QETLAsWkGziRRaZ9G?=
 =?us-ascii?Q?5cfcpm7kOyl4HGfQrBaANSPtQRhWrEUdLv0CfrwTwiwNbC63n28sdSiJq8O5?=
 =?us-ascii?Q?oo154EcDMBLTHfOlSg/0gfSejeOaly29FyOmK/LHks/HiEd2G5wMDPbY7HZI?=
 =?us-ascii?Q?wTzsFYlfoDjjAhAUl9eIur3Fnw6OLdYaGDwH9Y5Gc8RcBCzgS7e2PQlZ0H7s?=
 =?us-ascii?Q?LzCGL35BuMZp8QC6M3w4gWUdtop0TJQ/rcH1M7sr3dWePZ+WTvSfI10N6q2V?=
 =?us-ascii?Q?mjFmQGnrnVAZ5f/uh6yk+/ZSqK7V66mScipQ9H3lUaedkD+OmtRYI8W3Q0mR?=
 =?us-ascii?Q?GwSwyclPifloQrchL8g2qI3sEHIaRhyYfnyGh5g26HKiu8G9A8/EsNJ32cDX?=
 =?us-ascii?Q?llNCIZKihP5ftWefPbfcLymXy5hbAbxga+sEKQi+SunLFnCyGRu2bn/odHnk?=
 =?us-ascii?Q?p4aB4vdZw7//JwL9e+BTI8mF6bwf2HczLnYRJHqJYGeRpbzr4dO389WeToeB?=
 =?us-ascii?Q?Dnv8/Gose17RFq9QiUnC7+aX0+K6hkajoFv6lzgisxaWAb+AxSMnho7aatL6?=
 =?us-ascii?Q?m64olpPQF4lTmue+mpVC0Z0Z84qz9ReHC9zTCyacB1rQhzdF9f1LvLyIUxId?=
 =?us-ascii?Q?o+zlaQF3ovKmdogB+7PbX5VFYO7fOyWVQQcbCFz3sF7jlH4STtRMCep8SsXt?=
 =?us-ascii?Q?aio7LWnPIYL1WnZWFhN78gtT+faekV9OjZtcbfsY3HJMXTWDxmMrtaADwokt?=
 =?us-ascii?Q?bG5KNIm0H3yGiQp2uh1eVeigsP2hFe2cky7d4IYNlzpu1oBRgZziQjVMSkG0?=
 =?us-ascii?Q?miNN2okAwjPvjND+3u+9kGS4RMfNCBO+VYLvrDjoYUbkMzUgOK2nwaISvr2Q?=
 =?us-ascii?Q?woShQPk1PA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed8a1e23-a840-4bb9-95a4-08deab826346
X-MS-Exchange-CrossTenant-AuthSource: VI0PR04MB11503.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2026 15:16:03.3918
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y/Ro83ccqvCJUyxqGlioR5JZHLNyaIbWdHl9AowHubkniMCEStLuM65pn+XB0PIITcdz9d+Tv+s6AGg8bIm2ww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10626
X-Rspamd-Queue-Id: 7DC984DD0E4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
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
	TAGGED_FROM(0.00)[bounces-284900-lists,netdev=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[ioana.ciornei@nxp.com,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[nxp.com:+];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_NONE(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,nxp.com:dkim,nxp.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

Since there dpaa2_switch_port_set_fdb() never fails and its return value
was never checked, change its prototype to return void.

Also, instead of determining if the DPAA2 port is joining or leaving an
upper based on the value of the 'bridge_dev' parameter, add the
'linking' parameter to explicitly specify the action. This will enable
us to pass the upper device that we are joining/leaving in all possible
cases. This will get used in the next patches to determine what kind of
device the upper is: a bridge or a bond.

Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
---
 .../ethernet/freescale/dpaa2/dpaa2-switch.c   | 33 +++++++++----------
 1 file changed, 15 insertions(+), 18 deletions(-)

diff --git a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
index 6367873401c0..f1b4c24b8a47 100644
--- a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
+++ b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
@@ -62,18 +62,17 @@ dpaa2_switch_lag_get_unused(struct ethsw_core *ethsw)
 	return NULL;
 }
 
-static u16 dpaa2_switch_port_set_fdb(struct ethsw_port_priv *port_priv,
-				     struct net_device *bridge_dev)
+static void dpaa2_switch_port_set_fdb(struct ethsw_port_priv *port_priv,
+				      struct net_device *upper_dev,
+				      bool linking)
 {
 	struct ethsw_port_priv *other_port_priv = NULL;
 	struct dpaa2_switch_fdb *fdb;
 	struct net_device *other_dev;
 	struct list_head *iter;
 
-	/* If we leave a bridge (bridge_dev is NULL), find an unused
-	 * FDB and use that.
-	 */
-	if (!bridge_dev) {
+	/* If we leave a bridge, find an unused FDB and use that. */
+	if (!linking) {
 		fdb = dpaa2_switch_fdb_get_unused(port_priv->ethsw_data);
 
 		/* If there is no unused FDB, we must be the last port that
@@ -83,13 +82,13 @@ static u16 dpaa2_switch_port_set_fdb(struct ethsw_port_priv *port_priv,
 
 		if (!fdb) {
 			port_priv->fdb->bridge_dev = NULL;
-			return 0;
+			return;
 		}
 
 		port_priv->fdb = fdb;
 		port_priv->fdb->in_use = true;
 		port_priv->fdb->bridge_dev = NULL;
-		return 0;
+		return;
 	}
 
 	/* The below call to netdev_for_each_lower_dev() demands the RTNL lock
@@ -101,7 +100,7 @@ static u16 dpaa2_switch_port_set_fdb(struct ethsw_port_priv *port_priv,
 	/* If part of a bridge, use the FDB of the first dpaa2 switch interface
 	 * to be present in that bridge
 	 */
-	netdev_for_each_lower_dev(bridge_dev, other_dev, iter) {
+	netdev_for_each_lower_dev(upper_dev, other_dev, iter) {
 		if (!dpaa2_switch_port_dev_check(other_dev))
 			continue;
 
@@ -127,9 +126,7 @@ static u16 dpaa2_switch_port_set_fdb(struct ethsw_port_priv *port_priv,
 	}
 
 	/* Keep track of the new upper bridge device */
-	port_priv->fdb->bridge_dev = bridge_dev;
-
-	return 0;
+	port_priv->fdb->bridge_dev = upper_dev;
 }
 
 static void dpaa2_switch_fdb_get_flood_cfg(struct ethsw_core *ethsw, u16 fdb_id,
@@ -2040,7 +2037,7 @@ static int dpaa2_switch_port_bridge_join(struct net_device *netdev,
 	if (err)
 		return err;
 
-	dpaa2_switch_port_set_fdb(port_priv, upper_dev);
+	dpaa2_switch_port_set_fdb(port_priv, upper_dev, true);
 
 	/* Inherit the initial bridge port learning state */
 	learn_ena = br_port_flag_is_set(netdev, BR_LEARNING);
@@ -2066,7 +2063,7 @@ static int dpaa2_switch_port_bridge_join(struct net_device *netdev,
 
 err_switchdev_offload:
 err_egress_flood:
-	dpaa2_switch_port_set_fdb(port_priv, NULL);
+	dpaa2_switch_port_set_fdb(port_priv, upper_dev, false);
 	return err;
 }
 
@@ -2113,7 +2110,7 @@ static int dpaa2_switch_port_bridge_leave(struct net_device *netdev)
 	if (err)
 		netdev_err(netdev, "Unable to clear RX VLANs from old FDB table, err (%d)\n", err);
 
-	dpaa2_switch_port_set_fdb(port_priv, NULL);
+	dpaa2_switch_port_set_fdb(port_priv, port_priv->fdb->bridge_dev, false);
 
 	/* Restore all RX VLANs into the new FDB table that we just joined */
 	err = vlan_for_each(netdev, dpaa2_switch_port_restore_rxvlan, netdev);
@@ -2381,7 +2378,7 @@ static int dpaa2_switch_port_bond_join(struct net_device *netdev,
 	u8 lag_id;
 
 	/* Setup the egress flood policy (broadcast, unknown unicast) */
-	dpaa2_switch_port_set_fdb(port_priv, bond_dev);
+	dpaa2_switch_port_set_fdb(port_priv, bond_dev, true);
 	err = dpaa2_switch_fdb_set_egress_flood(ethsw, port_priv->fdb->fdb_id);
 	if (err)
 		goto err_egress_flood;
@@ -2416,7 +2413,7 @@ static int dpaa2_switch_port_bond_join(struct net_device *netdev,
 	port_priv->lag = NULL;
 	dpaa2_switch_set_lag_cfg(bond_dev, lag_id, ethsw);
 err_egress_flood:
-	dpaa2_switch_port_set_fdb(port_priv, NULL);
+	dpaa2_switch_port_set_fdb(port_priv, bond_dev, false);
 	return err;
 }
 
@@ -2435,7 +2432,7 @@ static int dpaa2_switch_port_bond_leave(struct net_device *netdev,
 		return err;
 
 	/* Setup the FDB for this port which is now standalone */
-	dpaa2_switch_port_set_fdb(port_priv, NULL);
+	dpaa2_switch_port_set_fdb(port_priv, bond_dev, false);
 
 	/* Setup the egress flood policy (broadcast, unknown unicast).
 	 * When the port is not under a bond, only the CTRL interface is part
-- 
2.25.1


