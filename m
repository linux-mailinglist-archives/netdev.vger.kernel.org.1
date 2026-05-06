Return-Path: <netdev+bounces-284902-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kF9gBStc+2mUaAMAu9opvQ
	(envelope-from <netdev+bounces-284902-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 17:20:11 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 86B314DD10B
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 17:20:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 12C043089F0D
	for <lists+netdev@lfdr.de>; Wed,  6 May 2026 15:17:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 512F24921B8;
	Wed,  6 May 2026 15:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="faJGd+Bx"
X-Original-To: netdev@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013060.outbound.protection.outlook.com [40.107.159.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2423048BD33;
	Wed,  6 May 2026 15:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778080585; cv=fail; b=OYWr243c46UQVdk471pU0QofkDOerJsZfGCWl2zPBtGmljjYULXkXyRBCixeIzBIUHmNKseUIB5licieNYh9K7BUXosWBR6+2UXDzrfWl9wEiGscpZjo8dSMunsyqQHmHV1qPkLTEAdO5ahvh+awR05PwBDeNGEU1gy43hX08lg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778080585; c=relaxed/simple;
	bh=ietSQh028RaWQ9FfkxxTjA6KQuV8UE8Z0xEQc3Ceowc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mKRNJ7wxsW2nSJJ2974esZ5zpjtc2DJH5LDrE4rxkYrKXLXE+K7YhI2h9u0QfOgoWTRiBKxSXqHUMySRFjye/qUHr+kd3RGnsEBn07KRnjvxcpuhcfrckHwkNp71Cev2wUlrhimeFQbzHGGQYe0WetnWdZzRXbM9b8lDKxYiWQY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=faJGd+Bx; arc=fail smtp.client-ip=40.107.159.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oECh6N+kzQhEWzVScy+Kj4Xrx3ZPeicawkVXKkZlpB1dbNJnaUr0X4BIS6GNEMbPCV4mollltWYshtLqChyINA/XjKZZ5U7YrW1T0bzbaqk4OkYZTuWLS+1fA8jVM01KprW+B5I/rEFomM6MIUdAFlLdkkkkz9VVGWHedJWqx1nJNWvuCYvswOa5A9JKziHzGm0YzXPuxLBgZ/nlrmiuUh/nHJKR2deS7V4mH+WxO4eY5V+vxTVx4SjvDhA2ZdrLUEtV+ekLW8g9hzafbZ/w4gah8/sVcBZDjlUusrSIQggm8WbQqgtN3u/xQgWUlDJ5SRvjyjS/8Dz47Y+Kc3d+xQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MZnDEbj1aZwmv0NwreTJMtamO+q+cyuuP4YxRPuMIKI=;
 b=L/sUtfNtLeu6Gmc4Bvw9/SDRFVWP27D4jSA2aHT7m6Mvlmg0Zz1iDn1vKYNDbH3Mfbcgpik+zMVpu7koy2P975PGwEEqR2CFweA0M+AqvogQv0oU0YxZJDP4bbYuACuzOQuVcIgO3iDvTSDEuTP9mfnD/m4wPhYY77XDcLrMbuiB8R35/4FPUEAZ38C/MUUN1WkSk0KM+PKyjcWSfeThKSVkYlcsLCpQFmeyASD4WN9cujHTLsq1syRkN7GvSkfgzAjXW/mfvfv5XDnsyS5nQS6k4x9YTHV3FHq5cfDCL2yhrBrDzPqaEYf8pbmIYcGZxAYGlvakfgCppIdsCSxBlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MZnDEbj1aZwmv0NwreTJMtamO+q+cyuuP4YxRPuMIKI=;
 b=faJGd+Bxe84oCL183Qdp8+np9sNScNbflJfmI0ma0Y29a/1dXc+SLpzY7m3VOj/80tu2wLVa4x4kFct3ZIytJ8hx5U0dLoic+NE6IcRy1K9UA+TuLpVKrAk9EvQII7+CKpiZsQ4bKn3LjF4EZATbbPVBRn7YtQCcBCVy53tKrRCQiGCbvGO72ja0EqYFq6+6GpNkzrLVBgk8zvLpj+Pzk2J5ABa757PJhnh9kqBeT7m8q5ygjZRPo6Jxl6LONZAYhEjp8IZLxjGmkXZmLzavm51rX3NSEFcEgFJT5+0jW4Xel25LVWfBa9qu4zy3GxSJbKU4X1xrGFXihikm3SkXWA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI0PR04MB11503.eurprd04.prod.outlook.com
 (2603:10a6:800:2c7::16) by PA1PR04MB10626.eurprd04.prod.outlook.com
 (2603:10a6:102:48e::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Wed, 6 May
 2026 15:16:06 +0000
Received: from VI0PR04MB11503.eurprd04.prod.outlook.com
 ([fe80::cbe9:4c03:71b6:359f]) by VI0PR04MB11503.eurprd04.prod.outlook.com
 ([fe80::cbe9:4c03:71b6:359f%6]) with mapi id 15.20.9870.023; Wed, 6 May 2026
 15:16:05 +0000
From: Ioana Ciornei <ioana.ciornei@nxp.com>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH net-next 04/13] dpaa2-switch: extend dpaa2_switch_port_set_fdb() to cover bond scenarios
Date: Wed,  6 May 2026 18:15:31 +0300
Message-Id: <20260506151540.1242997-5-ioana.ciornei@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260506151540.1242997-1-ioana.ciornei@nxp.com>
References: <20260506151540.1242997-1-ioana.ciornei@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P191CA0019.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d9::9) To VI0PR04MB11503.eurprd04.prod.outlook.com
 (2603:10a6:800:2c7::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR04MB11503:EE_|PA1PR04MB10626:EE_
X-MS-Office365-Filtering-Correlation-Id: 12257611-0591-43c7-a12e-08deab8264c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|19092799006|1800799024|366016|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	oIedjltU6sA2GFEwiSPBwLvq+n8WhFbVsFgyLTpczyJLXcNN5W5CdrS9JK5V4NYk2/cXSSDzmYUnq//oEPYSVvDrvDfn5Bqp0wfwFrTWdJV9orqxiabbXguv1cY13CxCkwd3lcXB1bUfKlVhmQr1zWu7PF+Ex4j2ByZpzpZB8ez+W9wzGFOwsZOtt4WB27SDoCSnZa5mg7xiYrPptf9xNGI5h8VQbXVfB57Aa9Hm49lrWY/lZqd9dG9Vkkkem5F8nfIzAMP1aDdMsSuCIhINRuopa04n1tHSUgeMERqvJhgcwfW1KOpu+Tm4Kz3wRV8LUuwTJsBpqCRBCrZtL8flmUC9nMVsN8lX7hC0YBhFsIPexIqzL44MEF0QVrcykT0Ojz6Tzh+wPnX3IxS9sN+wbzxqAGX+QPDJYW5nrwmnvf28N90PPO8fCcKImoe3cpFHQNMq8oySYxneJoB+b6AlpsHWmwCd/Wdm7r0hytnM3RDTN0Humb5L6Yr5Fj6ZFET39e4cpnC1aMt5m0ISM2fnzVRLUOAJRcvmmZd7SvK6Vnfm1P1kndRKePUSQ+FyjLgl/Ui3jywuJt+/ZIq9T2EUIE1AbEkSh0G2FIWSt+3b9amX5H+NKt+Zw+2dtASqDZDJHhkfzrQhEYxr+S+LSpcYcs/4bpFs+hdFqzXyyeAjqvKYoiAL7qZXhfzrfCT835xO
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR04MB11503.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(19092799006)(1800799024)(366016)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BjQ2/5/zP/nlYPsRi/att620QqX0N8X1wEHwpA615ZEw9fU1Yc40zoHLNC5D?=
 =?us-ascii?Q?PIWwH2aAYwM0dsZRdT5sN5uA4L4cXgFcYG67NQQJUk+9FRYEjGXjuw3bxulV?=
 =?us-ascii?Q?vkM9znjy1yM2ZEGKRcaqk1Ogw9gHE6uJm8ATzD2WpStilFbmXiiyURKnYt/Y?=
 =?us-ascii?Q?j2TkMgP/unNVbZqnQD/9zwNrE1djzVXSG5jdHvPASM91kmyBg2MHRCBvqQjw?=
 =?us-ascii?Q?Nw8YSuE1Ri5Q+NgiL9UGI1t8jWBZnrzR6AlsVoCtCxhiAGQm7YhxJsdtkiaT?=
 =?us-ascii?Q?ZsSWdWhZroEWjQqwiQ47IgpA03M4bo+QgHfepXY8mTc7YJemFsDMBTFdURwX?=
 =?us-ascii?Q?rHYfR8pU3BQmgX6ueL2tep9ixXYxBLq6rOmiBHVaLVsUPc4EjYLr+9A1DtOt?=
 =?us-ascii?Q?lK1fr5OuJ5aNnKH/qV2q+QdlEer+6aRfhzrtH5CH/omjwywsSTLqGDQfuVX3?=
 =?us-ascii?Q?rGYF4ZZfPopJ4o0eKXhAwjADLW5EvdwRtLsu/dmDMcTJWGQK0T8FH+SEOkLX?=
 =?us-ascii?Q?mF1GYpxK7tNXUlXvioAkLvhfg5nyezX5DPrB76pCHEsKSF4QmVXuBlRBHXCw?=
 =?us-ascii?Q?5DE4MVA2vUwTZyG9FU3NKwjrcKZtdP6IqW0ipaJmPXaSPrZtLJyBMS3NzR6+?=
 =?us-ascii?Q?Qj3fSMJBcgWcliONAFsPSvYfIwvwx+jfq4Eu9REU+k42ysrhtyErk4qAU4ZZ?=
 =?us-ascii?Q?b0yvQHIErUV0GNhN5nyQu8Hso3Wk4EYjCOzgPr8w8hZnnYHbhGSmC3MMR80q?=
 =?us-ascii?Q?X9Jk4h0jB/neUDo+Zt6vLHpHiUFDq87ILl1V0rFejcxv9t3xjAhwB/40QAiX?=
 =?us-ascii?Q?vV6hgwjd8qouNJde94Aahg4vn/FOQjc15ZV29QQO43B/XbHSUHQoGjGxibPI?=
 =?us-ascii?Q?/2Fy/B2ds7IS2XEpDs6tTlFfwMzFBV04jP5KofJhWCQ0BqCa7JQB50niiSpv?=
 =?us-ascii?Q?NQA1luKR6YbOz+pFOKVlXHWWiM3YrEcKjJhQz4baC5bmyJDnR37lKfxwsTD/?=
 =?us-ascii?Q?9mk0gQFJyTdZbBT8UNcLJR+VRBHwa7agKVsrCSmrESjGhfZ/d4g1j0GQeNFU?=
 =?us-ascii?Q?dwxTTy01o+HnYQy35kmxgzZ7jhK+Ow3DJxF8hT3lulxyl+/xJSn/yq6XKI92?=
 =?us-ascii?Q?ufopt2Re35llnUWvw1nncoBthUk4dLlyAzgyDXdPDDle8GAHif0Fw6fF41vX?=
 =?us-ascii?Q?R6Ikqdioe9GgOwGYcMNYkCPI8rmI7vCFf2PbuzbnsRDNfS4OHLs80b5G1S0H?=
 =?us-ascii?Q?9TdydCw1FMO6qMDZm1fHrgjFyJH6KxFnx3lk+V8ekiy9FagbSv2szBheDEJk?=
 =?us-ascii?Q?m3LimRRtoF6eUBCYzw4SozHR7NZxxMFKO0JCKYwBJCjE0OvU88fZA04xtTmc?=
 =?us-ascii?Q?e//Z5dLIohYF8HSvI2Do/DxyrvqQOs/6ZqvtT92VbzUOD+JyW+lAh4+xqPfq?=
 =?us-ascii?Q?fmcifVPzMy2QVXc0aewTI/+EhoBmAal+gCWGZ3AxlEJ1QAU0CsTf1XTX79Kd?=
 =?us-ascii?Q?km9QATRKLLCO0yQn4dLJOvSrM/UhiAt3JV22zbAQl4H1mMpELuYIisoq0ltj?=
 =?us-ascii?Q?4shDt0yTWWx1OumqM0wICx7CKjv1Xkj50bVpqV2Gc3F++yukf/qaXQHkGSXW?=
 =?us-ascii?Q?Lrt3plUoiW2HPuLREfnZ2IkRE4yVtcJSgWOQA7tVqF4qrOoIvOBsP/nwzlt4?=
 =?us-ascii?Q?KW0wVVnQkbeeXUdJGWw0qMFrfpcDTjNtl0htktxgfY3oog8P9kJ4TvOUl6Pu?=
 =?us-ascii?Q?EnyiVAwfbw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12257611-0591-43c7-a12e-08deab8264c5
X-MS-Exchange-CrossTenant-AuthSource: VI0PR04MB11503.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2026 15:16:05.9242
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rUypms4HXTIiXx02C+sqdYdtLYapqna3hUTW/ulbL99lyTHseNx7Xr1UO3uc3ZXsPxEYX4Um6CvsB/FUu7PZdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10626
X-Rspamd-Queue-Id: 86B314DD10B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	TAGGED_FROM(0.00)[bounces-284902-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,nxp.com:dkim,nxp.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

The dpaa2_switch_port_set_fdb() function is responsible with determining
what FDB should be used by a port as a consequence of changing its upper
device. This patch extends the function to also cover the circumstances
in which a DPAA2 switch port offloads a bond device.

This will allow us, for example, to setup the same FDB on all DPAA2
switch ports which are under the same bridge, even though not directly
but rather through an upper bond device which is bridged. How the
function does this is by first determining a DPAA2 port is already under
the same bridge and if so, choosing its FDB. To cover the entire
hierarchy in depth, we add an extra walk through all the lowers of a
bridged bond device.

When leaving an upper device, the DPAA2 switch port must find a new FDB
to use. If before it just searched for an unused FDB to go along with
its new standalone status, now it first checks if the port is still part
of a LAG and then uses the FDB of any port that already left the same
bridge.

Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
---
 .../ethernet/freescale/dpaa2/dpaa2-switch.c   | 102 +++++++++++++-----
 1 file changed, 78 insertions(+), 24 deletions(-)

diff --git a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
index f1b4c24b8a47..9d3a0aef1568 100644
--- a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
+++ b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
@@ -66,28 +66,59 @@ static void dpaa2_switch_port_set_fdb(struct ethsw_port_priv *port_priv,
 				      struct net_device *upper_dev,
 				      bool linking)
 {
+	struct ethsw_core *ethsw = port_priv->ethsw_data;
 	struct ethsw_port_priv *other_port_priv = NULL;
-	struct dpaa2_switch_fdb *fdb;
-	struct net_device *other_dev;
-	struct list_head *iter;
+	struct net_device *other_dev, *other_dev2;
+	u16 fdb_id_old = port_priv->fdb->fdb_id;
+	struct dpaa2_switch_fdb *fdb = NULL;
+	struct list_head *iter, *iter2;
+	int i;
 
-	/* If we leave a bridge, find an unused FDB and use that. */
+	/* If we leave a an upper device, be it a bond or a bridge, find an
+	 * unused FDB and use that.
+	 */
 	if (!linking) {
-		fdb = dpaa2_switch_fdb_get_unused(port_priv->ethsw_data);
-
-		/* If there is no unused FDB, we must be the last port that
-		 * leaves the last bridge, all the others are standalone. We
-		 * can just keep the FDB that we already have.
+		/* This port leaves a bridge, but it's still under a bond.
+		 * Search for the first port under the same bond which already
+		 * left the bridge.
 		 */
+		if (netif_is_bridge_master(upper_dev) && port_priv->lag) {
+			for (i = 0; i < ethsw->sw_attr.num_ifs; i++) {
+				other_port_priv = ethsw->ports[i];
+				if (!other_port_priv)
+					continue;
+
+				if (other_port_priv == port_priv)
+					continue;
+
+				/* Found a port which is under the same bond
+				 * device but already left the bridge. Use
+				 * this port's FDB.
+				 */
+				if (other_port_priv->lag == port_priv->lag &&
+				    other_port_priv->fdb->fdb_id != fdb_id_old) {
+					fdb = other_port_priv->fdb;
+					break;
+				}
+			}
+		}
 
-		if (!fdb) {
-			port_priv->fdb->bridge_dev = NULL;
-			return;
+		/* Try to get hold of an unused FDB to use */
+		if (!fdb)
+			fdb = dpaa2_switch_fdb_get_unused(port_priv->ethsw_data);
+
+		if (fdb) {
+			port_priv->fdb = fdb;
+			port_priv->fdb->in_use = true;
 		}
 
-		port_priv->fdb = fdb;
-		port_priv->fdb->in_use = true;
-		port_priv->fdb->bridge_dev = NULL;
+		if (netif_is_bridge_master(upper_dev))
+			port_priv->fdb->bridge_dev = NULL;
+
+		/* In case all FDBs are already in use, we must be the last
+		 * port that becomes standalone. We can just keep the FDB that
+		 * we already have. Nothing more to do in this case.
+		 */
 		return;
 	}
 
@@ -97,18 +128,40 @@ static void dpaa2_switch_port_set_fdb(struct ethsw_port_priv *port_priv,
 	 */
 	ASSERT_RTNL();
 
-	/* If part of a bridge, use the FDB of the first dpaa2 switch interface
-	 * to be present in that bridge
+	/* In case we are joining an upper device, be it a bridge device or a
+	 * bond device, we will use the FDB of the first DPAA2 switch interface
+	 * that is already present under the same upper device.  For this to
+	 * happen we have to extend our search so that we can find any DPAA2
+	 * interface that is a lower of a bond bridged port
 	 */
+	other_port_priv = NULL;
 	netdev_for_each_lower_dev(upper_dev, other_dev, iter) {
-		if (!dpaa2_switch_port_dev_check(other_dev))
-			continue;
+		if (netif_is_lag_master(other_dev)) {
+			/* Search through all the lowers of the bridged lag */
+			netdev_for_each_lower_dev(other_dev, other_dev2, iter2) {
+				if (!dpaa2_switch_port_dev_check(other_dev2))
+					continue;
+				if (other_dev2 == port_priv->netdev)
+					continue;
+
+				/* Skip the port if it's the same upper */
+				other_port_priv = netdev_priv(other_dev2);
+				if (other_port_priv->lag == port_priv->lag) {
+					other_port_priv = NULL;
+					continue;
+				}
+				break;
+			}
 
-		if (other_dev == port_priv->netdev)
-			continue;
+			if (other_port_priv)
+				break;
+		} else if (dpaa2_switch_port_dev_check(other_dev)) {
+			if (other_dev == port_priv->netdev)
+				continue;
 
-		other_port_priv = netdev_priv(other_dev);
-		break;
+			other_port_priv = netdev_priv(other_dev);
+			break;
+		}
 	}
 
 	/* The current port is about to change its FDB to the one used by the
@@ -126,7 +179,8 @@ static void dpaa2_switch_port_set_fdb(struct ethsw_port_priv *port_priv,
 	}
 
 	/* Keep track of the new upper bridge device */
-	port_priv->fdb->bridge_dev = upper_dev;
+	if (netif_is_bridge_master(upper_dev))
+		port_priv->fdb->bridge_dev = upper_dev;
 }
 
 static void dpaa2_switch_fdb_get_flood_cfg(struct ethsw_core *ethsw, u16 fdb_id,
-- 
2.25.1


