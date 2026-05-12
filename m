Return-Path: <netdev+bounces-287157-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AD04MOg2A2pM1wEAu9opvQ
	(envelope-from <netdev+bounces-287157-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 16:19:20 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 452F3522377
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 16:19:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E899432AA37F
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 13:19:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EBF83ADBB4;
	Tue, 12 May 2026 13:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ASkuKXHQ"
X-Original-To: netdev@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013005.outbound.protection.outlook.com [40.107.162.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94C973ABDAB;
	Tue, 12 May 2026 13:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778591787; cv=fail; b=jA4pBlt/nh+0C8bntUTgeXFCSLUYiMwrUCq0XzY7bndlmk3UUDVnnZ4y3xz+X8H2WAiqVWtaNU4FjSuU5x29GQJ41h9crcSa7nQyZwqR3g7NV7ABNbATXSGiyASm5fB0PB7ZbfGL0Lo3d9zkDiIc92BW6DOE0BuOaKLYOgERXTw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778591787; c=relaxed/simple;
	bh=HnMhN5tiga9DPhat9pCSujPfprBslF5dTIRDp/wvKtE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CCLlCxufDSCIam+MmyayavjI5oY1IAfsDISkJjAayfgkXeXFJ8mu8ViNbPzfH45DeLi9YKmlB4Ik0DFyqE0VSHEDUiRjGh80zD8qIBUgpj2plNponRIgSSyWr/fGw7+yJfJEm+GYg1cf6bw51nZVp/T+zxJmF5fwss8BjuZSUx0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ASkuKXHQ; arc=fail smtp.client-ip=40.107.162.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DOV1pQGR1nFHF/h/P7J+QN6PjN5oMUSoKSjJ1UHsQenj6+2cTYtDw7D5RT94WLuuZmtK//U/MpWxDmpsFOZCyLJZ9frHblAdmY7DMbwccYdDPUr9OvX9Pk7p+4+LPBNkDR/e6JoN+ks+TzkyYt7g9KuxSdnsdf9VqKVzu4luc10ztZj4TjIrqy9gDzygia0Z+/QAPSrTIloQYDvogBOLUmdHPVK9HO2WaI8CgOwe9titDJLInWcCdMsJXJMqAeXkUwPoIzS4NPa62YsGhji3jVpeQTWLlLYOpQDd+MVKCusqo6XG3GBUFhG6lXJi+vQ96F2J6oWqHTd5C7Cf5M43WQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0s9SdsKHey0zFKSE0LkNO2fawt4kGSIfwSDgv8o0mTQ=;
 b=QM5h2ZbrPiC5PxujSypKvw/5thh+MLMaLdVC3kwjgs0XCJpjE+Zu25G76dVmZ3mYpHuWr35ihDrHyHiY0acUFt7DTwZ6Vx0jdWAhnqFoHkbKnH2621wHAvwlu88GsIrifcYmZhmOvS+EwbLsvV2byUZhF9z+q2luWbJ/eck0jO2ej1TBTqK+emffIhgvBXEkwGzWh9kILhwYxUhXXW3QPLGtSmbyat4CXsGgdfuWhGFlstDjlRZIs9GZl4jcSxpWRYYb4dakMvoipfdZ7aA1UiSl3EtkJ2AQW9tKTnNCNi8y5EyzM8vMFDPL3hIxAUhdHGQK6X8utShGWXeKfIMc3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0s9SdsKHey0zFKSE0LkNO2fawt4kGSIfwSDgv8o0mTQ=;
 b=ASkuKXHQ7KCWOSS5aeM0n2vDuFCcHhQTUPCY6NSqxjAy1T7knTOo04joUr1skz2KyeVlGzQxL+CYhabc3AykGg3FMfCGa/dtHsMiu3ZYjBtHXcviGQzLDIpgFmS1qFuvhCCr6p0H9u0iwtQ+U25O51vSLiPAQCBgF1qwaRJ6BFRk3Q3zfwz65hIa8r9TfFNTHnyUQJFslYThCkumUd2taP8d3G30u//819hDDB1j6PVg/VA0rvBWtQYrnK4ru9N4exIpBoXjDEaexNYjaPzouRf5AJoVxQm2jCIyZRZ8eoFhKI8NiEo8kf47JDDhaUWt7wtVJD9E55xb+YnQPqC78g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA1PR04MB11508.eurprd04.prod.outlook.com
 (2603:10a6:102:4e0::21) by DBBPR04MB7530.eurprd04.prod.outlook.com
 (2603:10a6:10:1f5::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Tue, 12 May
 2026 13:16:22 +0000
Received: from PA1PR04MB11508.eurprd04.prod.outlook.com
 ([fe80::ca15:d140:3af1:77b3]) by PA1PR04MB11508.eurprd04.prod.outlook.com
 ([fe80::ca15:d140:3af1:77b3%5]) with mapi id 15.20.9891.021; Tue, 12 May 2026
 13:16:22 +0000
From: Ioana Ciornei <ioana.ciornei@nxp.com>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 06/13] dpaa2-switch: create a separate dpaa2_switch_port_fdb_event() function
Date: Tue, 12 May 2026 16:15:47 +0300
Message-Id: <20260512131554.952971-7-ioana.ciornei@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260512131554.952971-1-ioana.ciornei@nxp.com>
References: <20260512131554.952971-1-ioana.ciornei@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR02CA0189.eurprd02.prod.outlook.com
 (2603:10a6:20b:28e::26) To PA1PR04MB11508.eurprd04.prod.outlook.com
 (2603:10a6:102:4e0::21)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA1PR04MB11508:EE_|DBBPR04MB7530:EE_
X-MS-Office365-Filtering-Correlation-Id: bfb6f5f6-7b7f-467c-6171-08deb028a954
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|376014|1800799024|22082099003|18002099003|56012099003|11063799003;
X-Microsoft-Antispam-Message-Info:
	9vunKWt3pIMV64tHf/HrAir3+IL9DlqN6lqDtF8SDtN0UNUVWT7L+9I+SoETZDFjO5kbPK4KqdZDLbEdoz93mPDtL1p5Eg/PErXXiDTHBMHZ50qi8Tg2B2vCp13rLDeCmlqKKuolgL69K2M1d5Ejq3OBJTN5zmNPNORDgRBUYoow5sbAbyPqAXAgHkJ4cFWCO3w2BMXvL82/gaPxA9D9BtD2UPy3/cnaUdLeno9G6zSc0vTZF0w03Xwy9vJUbQOIIoEEaXxBRly2vupJw8450edB9GW0fY31AuMiHzNrOeRV3MuhPc5vr5kQVZe4DT8FGQxUPqoTb61uDE/0opENn1t3GS7dr7QB0zxZ4kGgqXCobqvX1DRxTvhheuIibLwJvmac/MNwoVCX9m6+6X4ZSnIvBZDtXNO7m8nBz8AD/Sj3FhlT6X9LWA7s8hIhHngaCFU9gcG3H2cAxunVVJmzQWkLprpgTUIa5OrWlSBdsey42peGI4VIZ253nn41BWmqs7PV2WLXAvKMYndC3Agf6FhJxe2nLTntY2ntrF2UF/35kRiLR3/FqU8CVYaijqXv2JdcKZVM7Uhm8LHyu0HPoDlaY1km5bYDepk/4vI/5KPSBgwN8DaFSmlVzJFvLLZqeWvz4pPaIRZrox/XNPeJ0LLJMjhIn3h+5Z/wNz+TN9JyDmlMYEMArEaCSt8H6Y+u
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA1PR04MB11508.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(376014)(1800799024)(22082099003)(18002099003)(56012099003)(11063799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?OjPfJAFbLriNjXi04xw1Okl4anFmLuFDYB2y6SxvUXMP9oXQ/NLqzvb/my8D?=
 =?us-ascii?Q?HfF8ndbfAvE222liplls8/st+ssJmXyDp8YAwS8yaZrlvTTWLGYTPgn9nwyo?=
 =?us-ascii?Q?dSvYsMBcEXyOImFvOO00SuWnsz+ljcBpTYpyBdVcnw/Z0eA4fkkI++r7H9WD?=
 =?us-ascii?Q?4sEXPHRLuVKxZ5utLhK1uB4lP0YtR4C7TuKXzXWF00dPo+UbwCIGsUVfLV9P?=
 =?us-ascii?Q?NON1VmkLluJWB5V63XAyx5Y/yV7bZWv/Mz8wbibc+690bLg+FZ2RjB995OuD?=
 =?us-ascii?Q?qC6ZZ1HPYAWOKkdtKUCboLNAAv9TleZ0idPc4GcYcugAcQ+QKWPTHLUvM25j?=
 =?us-ascii?Q?pDsD5TFiPBv1C+WHP4HfsEDUzhoVkh8D7IoSzSIcdCRahu7adPPE15Cz8wYC?=
 =?us-ascii?Q?vzVTuALbunZMHtRLh/bKt3TwfJQRGpjoxT8WhAAfNOTLSxE85rrgsc2kJz1S?=
 =?us-ascii?Q?WYTuUhTxDcVvYukwgH6RfjBWYOOzzgN53AY5bofThLUlYsFeo3WAaQJBQ5Xs?=
 =?us-ascii?Q?6PS8s373cI/J++q8NBkWGuQxKLLdnpJX/NX/VihRnE3JUq3heC1z0h43ne3j?=
 =?us-ascii?Q?siM64erHczREzqzjFKGpPukh9IrSbhinPmMl3bsYrWV/lkcZoEbDECzLwOy5?=
 =?us-ascii?Q?x9BAVhgAX15crjGo+FlHWC89Aa2mSifH9uFwamwT9qhocIz7p0ywepZnR728?=
 =?us-ascii?Q?NYiEFNTeNs5usEAzag29GtOFumFIVpT08spMq4Co4HkpYMPQ6Dy9lFFbfEvq?=
 =?us-ascii?Q?g+ltks6q2ZobkumnJ0K7dIrYSidH+bo7ksjN1r+nQ3jR8Uz+54Ry/NHv/W5N?=
 =?us-ascii?Q?ofYE0o+dofsz648uLATJKu9+tmO/7GnxUKnIsJIW/35n9Sw+mz3nKW9qKCQH?=
 =?us-ascii?Q?A9oWwYWsdbI8+pxWDrL6QrK07JsgDUkmMqxgMlkuTxM8Ffouh3woYNtHATiC?=
 =?us-ascii?Q?BxGgOqJKdEIVnuZ8B3aZpRCZ2Rkvvpy/JqxvfWarMeuRI4c3bcysQeVOfNL2?=
 =?us-ascii?Q?pYxg7fefD3jEfNG2dv5U8yWzEBucn3nMu7/ruKU4IBLT9VrTvBnySECOi1WP?=
 =?us-ascii?Q?HKyRkvzZ1ycHUIbLJ/JSvBt9OZaohiI++kO1Ds58deYzIjO1niR/E0iAgsmG?=
 =?us-ascii?Q?hnTh/+wv3U9Slq5M0VC6Xls9Woc0ClXVENMGvIM1ucoHYfmJnE+NMcCzmh9k?=
 =?us-ascii?Q?TfUVxHMuhbnRyUc7LIRF0FFrHuddIIIu11SoZ4plPYVFHWcb/iP4VINWA7i1?=
 =?us-ascii?Q?f0keDqO4sjlqJEDaNJsQbKfwphufZMc8/m90A3u0snCfo9KdN0Z8cg527XUy?=
 =?us-ascii?Q?Rb5ICOt8crK8HcegZXChObdkWHsuU0zCcoNpbpC/JSUQPJnRQfVwhFewneCO?=
 =?us-ascii?Q?Fpj61zgg3HofYPHBRlFRRQjolllSY/55svU/2AIBsfRS2Odi/x8LuE4CVPNi?=
 =?us-ascii?Q?NHK0dd1UO/UyDQEwkKNL9yr5BiNS8ehhdJszsJZrZkwNd64o9Dfh/mLkuxxP?=
 =?us-ascii?Q?/F9E+GRCv3f/fdgeGSI+O251g0cawoKkKZ9aSwCdCXL/vyLQHFrov2PG6UbN?=
 =?us-ascii?Q?vjUEOmfiiYRbiGDTWsmSQe9cSr8kBnAV09nbCLtu8gCtcK0nsul8JnpVtkL4?=
 =?us-ascii?Q?+w2PSFjMvanatfo3KrgdrgM+f5leGLYE0zPmgDe0AsulvZsWIkHrawWP2lgL?=
 =?us-ascii?Q?VBtfogizeugKM7MY3uDJJMWTgyhI7sVWB06uDR1v/dIPCHaJih3bBVtKIPkl?=
 =?us-ascii?Q?YQi2DHrwWA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bfb6f5f6-7b7f-467c-6171-08deb028a954
X-MS-Exchange-CrossTenant-AuthSource: PA1PR04MB11508.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2026 13:16:22.7599
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b5Ropc0iRW39ajJb8xj5kVdvi4hkfl0sTsj07Yfzg/KiCdoW0MVmelaCGdD7zST1MX2X9Hk+Un2uKmcXQMs8ow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7530
X-Rspamd-Queue-Id: 452F3522377
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	TAGGED_FROM(0.00)[bounces-287157-lists,netdev=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[ioana.ciornei@nxp.com,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[nxp.com:+];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_NONE(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,nxp.com:mid,nxp.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Create a separate dpaa2_switch_port_fdb_event() function that will only
handle the FDB related events. With this change, the
dpaa2_switch_port_event() notifier handler can be written in a way that
it's easier to follow.

Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
---
Changes in v2:
- none
---
 .../ethernet/freescale/dpaa2/dpaa2-switch.c   | 25 ++++++++++++++-----
 1 file changed, 19 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
index aa6a6731dafa..2d03d7420d0c 100644
--- a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
+++ b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
@@ -2809,9 +2809,8 @@ static void dpaa2_switch_event_work(struct work_struct *work)
 	dev_put(dev);
 }
 
-/* Called under rcu_read_lock() */
-static int dpaa2_switch_port_event(struct notifier_block *nb,
-				   unsigned long event, void *ptr)
+static int dpaa2_switch_port_fdb_event(struct notifier_block *nb,
+				       unsigned long event, void *ptr)
 {
 	struct net_device *dev = switchdev_notifier_info_to_dev(ptr);
 	struct ethsw_port_priv *port_priv = netdev_priv(dev);
@@ -2819,9 +2818,6 @@ static int dpaa2_switch_port_event(struct notifier_block *nb,
 	struct switchdev_notifier_fdb_info *fdb_info = ptr;
 	struct ethsw_core *ethsw = port_priv->ethsw_data;
 
-	if (event == SWITCHDEV_PORT_ATTR_SET)
-		return dpaa2_switch_port_attr_set_event(dev, ptr);
-
 	if (!dpaa2_switch_port_dev_check(dev))
 		return NOTIFY_DONE;
 
@@ -2862,6 +2858,23 @@ static int dpaa2_switch_port_event(struct notifier_block *nb,
 	return NOTIFY_BAD;
 }
 
+/* Called under rcu_read_lock() */
+static int dpaa2_switch_port_event(struct notifier_block *nb,
+				   unsigned long event, void *ptr)
+{
+	struct net_device *dev = switchdev_notifier_info_to_dev(ptr);
+
+	switch (event) {
+	case SWITCHDEV_PORT_ATTR_SET:
+		return dpaa2_switch_port_attr_set_event(dev, ptr);
+	case SWITCHDEV_FDB_ADD_TO_DEVICE:
+	case SWITCHDEV_FDB_DEL_TO_DEVICE:
+		return dpaa2_switch_port_fdb_event(nb, event, ptr);
+	default:
+		return NOTIFY_DONE;
+	}
+}
+
 static int dpaa2_switch_port_obj_event(unsigned long event,
 				       struct net_device *netdev,
 				       struct switchdev_notifier_port_obj_info *port_obj_info)
-- 
2.25.1


