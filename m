Return-Path: <netdev+bounces-287158-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eNMABPQ2A2pK1wEAu9opvQ
	(envelope-from <netdev+bounces-287158-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 16:19:32 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 73C7D522397
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 16:19:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 92157312F21E
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 13:19:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D56A83AEB5E;
	Tue, 12 May 2026 13:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="l1LA84Hj"
X-Original-To: netdev@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013005.outbound.protection.outlook.com [40.107.162.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5923A3AEB24;
	Tue, 12 May 2026 13:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778591788; cv=fail; b=MrH+v1meJO75gl5qo9wIVCF0rns4I2l3ZYsTTNLCi1KXwHVCNHdI+M1eJZi4JVNXhggCn393wP+FkZQE1evWZn3PzQ3ulNy2y46ABRY2HuM9VkybHVFB73TELyLgeCJiVmiJ7OyZy2TpNOGkpDaFEEb7d0wRx+5p3TN42owBHQ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778591788; c=relaxed/simple;
	bh=PtQqsrY5sTptxgxW9X3DStO5m68TbWI1Tv6Dh+ltJuQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tnvKVbTzKf7JXL1YXxvntxzDCCYGMHYvDgETr/EwjWfyP6j/I34va+yKFYsoPfqOuklmJj6N6t4G/N7tfDR0yF42zJ2r9DNAXW0dKfUXTozTxVoZG2MP2kxig1Ezi++ZxvjlG1WFkk576e8nwvTAmYVWdQScXANpEwshIIlu/W4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=l1LA84Hj; arc=fail smtp.client-ip=40.107.162.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Iy3YDJkIJJJfRNBD0pNrcx9dEQoJAxrYA+kRTtiA71l3mnm/akIidwoawpzKDBMftyF22Wx0jfdh1C0JRpYWiiRUhN3PEO9yxBbXbm78VjNHDEZZYq7FafxVhi+U4vI75m7sJac59DglrKN07BygIbKpTQ6L6qIHLY8ElqCy7tKbuWTAJ8hOqwXczgdZU9rsH/X5G6B+wYsDUX0o2xdA1tCO8Dqva1LOt2TAxNwGdgazrx8h4CUD/GhxVwoGjSm/K/nOMiTfwCF8WMDKMFxerSvNT4NTir3+3KowrZRQa/B8EzzQvd1QqjocYcIslV1VBS3CQjyIAVVbX5z/+jwbnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nt+PjcpzP/41VDM6QxtikswpkiQoKHwb4CLff7ibpFY=;
 b=upVMq1pTiDckSLHfXHECwlhK+Y+yNOCSrEBfs4E2qoQyvONaZ2rdjhEaczYSAqjTZmahuDor7i9RaiM8OspW9l7ItCXz2tVkzU1oSdmBLQotvDk3tC8ezG4+G6r9DCjo6MeigPKbMuS047yDsTzB/oTunY4zo9qIO2xXjaV4RPz0EIc4a3DSEMS1aXzo9PY3076dEgToDQPBOPSAVd6o1qN6Fvd2mffCOyp5ikY2vWH+MCxvxJ3dM7P6zqZPmp3MRxpnTTOAkALQ9jOmfWRcb/buUQQ88hYB9/aMMBUBlB3KFw4nSIoGbETg2SbvV16RMJ+TgiFjaxczX6iDzI3wrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nt+PjcpzP/41VDM6QxtikswpkiQoKHwb4CLff7ibpFY=;
 b=l1LA84Hj219J16wPoZbE9AIxcgRz6PCYeqTFs2GEmCfMq7ywq/xFOvaL8ncZE5ngCKr7YodwwFXSKO/9QaA3iVB1/QLSC0Vn+/FhoBbTnEgiObYZEpJ4hdE2pGhuavSc5GIiJtV762NPoXi1ggRKiTzi7VIlBEx39EJw+5ZrregWZPJnAmSUT1QBnNIDnkco+1Qh8EbzA+3mrDiGvfs/N2VPK96bb29qXmQhubMW+eIZ/Y8MgthV67sW1bLXe4zVex6dG4UXZAgGHUY02maoaQitB2PW9jiOljt5tiztFu36d0BrEWo/8lTiEoB5n0H3urALhhRF/LNFCVjdQjrqoQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA1PR04MB11508.eurprd04.prod.outlook.com
 (2603:10a6:102:4e0::21) by DBBPR04MB7530.eurprd04.prod.outlook.com
 (2603:10a6:10:1f5::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Tue, 12 May
 2026 13:16:25 +0000
Received: from PA1PR04MB11508.eurprd04.prod.outlook.com
 ([fe80::ca15:d140:3af1:77b3]) by PA1PR04MB11508.eurprd04.prod.outlook.com
 ([fe80::ca15:d140:3af1:77b3%5]) with mapi id 15.20.9891.021; Tue, 12 May 2026
 13:16:25 +0000
From: Ioana Ciornei <ioana.ciornei@nxp.com>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 07/13] dpaa2-switch: check early if an FDB entry should be added
Date: Tue, 12 May 2026 16:15:48 +0300
Message-Id: <20260512131554.952971-8-ioana.ciornei@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260512131554.952971-1-ioana.ciornei@nxp.com>
References: <20260512131554.952971-1-ioana.ciornei@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P191CA0041.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:657::14) To PA1PR04MB11508.eurprd04.prod.outlook.com
 (2603:10a6:102:4e0::21)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA1PR04MB11508:EE_|DBBPR04MB7530:EE_
X-MS-Office365-Filtering-Correlation-Id: 49e47224-c127-4a34-622c-08deb028ab33
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|376014|1800799024|22082099003|18002099003|56012099003|11063799003;
X-Microsoft-Antispam-Message-Info:
	3BhvW7HkxgiDWcqW6bQGSMMjULC+MgxW/J3KCtCpN62dedX8rEz+nOoY9fbnoEESYuIO7Xm0g5J1uSDRpAZjR9QABfk+0/KVbyejJ2hA8tok/W/dAUJH4XzF7ArSrGKvLfPLxhFHUomk9UlsfrEaxtCzY2JKRagCNk9dSBL3Kla9nB69+9dRrxVf0Gg08dLUlzENPDZEBuRM7XzEYd/45Fpgo1ORxErDK3ws467TcwgWyhq1Fkur8IP95vGiRhi4KoMKNwh4+EnlBZ+7+VogCF/xFD3n1Sn1wo9Gk1UwOsr5llHUxi89fbP/vflneXLQi+nTltQ89J+9MCs2mA1qkWU2x3nqygzorBgfcJlt5C+oa8UszLQdNTLGPtUzzszKUyf2cgoC3wqyNzVUsBwuBp603FM/mIl2DyTXtLPUywK93tRrYhMbSWdwpThyvcNLPyOKwuQqzczaOLvvkJDd+wCJlH6eClLgOv8sinpv4CjmeGEwJYvKXSSvcCfGtl+YEIquXExkuR4TEmakoRnijgVMl9i/i9tzDfkbbnkLgMJt8Hp2Kb/+crzdZzLU1hDHmzHoXRw5oLHhY/a/ih5WkxjA42FXem4/tiFx4ljm/HCLd7JL0Dw+KfN5jgYypE+PD5h+WPQvBIPZKCxVYzT/XkCexClPP5EDFx4rkOWJwMjyfLqvPTDYEBS/6A2n/hqa
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA1PR04MB11508.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(376014)(1800799024)(22082099003)(18002099003)(56012099003)(11063799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DcQ/LOCaw9WnK7WlAGlQt63Uu4x37E+3oLWfSTNTp3Dk2RRiigqSAKzJq4Zh?=
 =?us-ascii?Q?Fx8UyViNWD0AtxsOLptgBPTAjJMwJ98VTQ4uHi5NtCABuXsIu7L+F7teV5rQ?=
 =?us-ascii?Q?STW1sfpL1o/hE1LcCpns50XkiyYnRzmAPNAdCp66hUvf/JdaAiQfZbxIXuxL?=
 =?us-ascii?Q?Lb4bi1xCqkR30rqc0pgkN1SNA6n2I47Qk9WkBf24i6LC4drEXGqPyAWN42tv?=
 =?us-ascii?Q?7PH58yvRXbFXWe87Zn/WesfW1yMLwk56L8dsybvX8sjrlV1XrOWjPSAtNOyA?=
 =?us-ascii?Q?utM+thqFoKWnU0/onkILhX/Qs+wnVEbEuVUxej0gjYjIJNknUffnrTIk1nIj?=
 =?us-ascii?Q?lSvlqGrxFqLiBdhUyIK8qawFB2K6x3C2O5t5nmMTWPVUmuZnRGXBYlRhSS4o?=
 =?us-ascii?Q?iqGOQ7oyYaO36seDleSQLS34UevrxUXrdAWtBu1SGHIk7l3Q0pmQklk8Udb3?=
 =?us-ascii?Q?X4dcosnULaTEQM1h7g36fmiNkg+Vu1NKxB4EABSxbhHNNnCZAEdmRlK5nyiy?=
 =?us-ascii?Q?FwgKI8+RxuXtVFDSR70J1uULa5q7YrF1K94ChYF2TzYUSCUiqfAAfFdUtN5K?=
 =?us-ascii?Q?XhU7iCEy41F2vigC3OnZGfAinS/5r7EUBSrOcpInWAD0loJMi7ZGrCjtch1Y?=
 =?us-ascii?Q?Vw0lLKdMek8lH26LQ9rarp7U7lTMQilrFIs3RUcpK2ffm2f0TifoScpeLx3G?=
 =?us-ascii?Q?qtG0aLoC8j1EuFqyHYvoYH75Lx/GSga3bMjXteN5vIFHSqUeHxmzxUQc1B4D?=
 =?us-ascii?Q?JAqSLZwlNeW8dVGwKkrdk46h4IyruO6JWBdUDPMg/ySnFNXjJH9PDg43cCSm?=
 =?us-ascii?Q?+rzOockX11B6MtIjZZSuolu4WR6JazrH7ZQsmizkTYgla6YgbFwXRRACAaVh?=
 =?us-ascii?Q?1dYvT+LPvkS6g7VXoPrLm9Pok9pJUXD4kvvx8eZr5jRlL2WuU7amrveXPHEH?=
 =?us-ascii?Q?oDaoOZZ+ONutkB81vM62wDDdKDFmRE7WjZ+6ZV/hFNAhRk7h94uw5LcVy8CM?=
 =?us-ascii?Q?0/yagEVy9Hj0Wj7+EpDV53MaLPQl79QVnTp4VGTLiYIlSyeT0rzBlmzYJxVL?=
 =?us-ascii?Q?y4L2R6P64Bxk1rXKOjFuimfJF7zwJztaJ0jVxvc9JwvtEelR8mJpWumQWDGD?=
 =?us-ascii?Q?evOq4l4LZO6mbhsmivswtP11TSrIFQVNfEc5ZuDX59CA3/Hx5r9ujQEQHqfD?=
 =?us-ascii?Q?JeWX+fjMeuvXzms1NdCzZcvV0Qm5NzrMZVqsMbNyong0yDygpYX4QArKi+V+?=
 =?us-ascii?Q?zpps74NnaUSn57NDN5ScipvEQstkppcJXP38V/h3rZvBpiQgnoe7HjBKXHMk?=
 =?us-ascii?Q?GIwsmynWrfFRO1BBepOQHczuBn8ARlqv+zPEX9z9i6E8h1WFetO7vpSgaU2g?=
 =?us-ascii?Q?E8hV+LfNwp6zHWqayot/6Mh8GezqmIi/WtDecjCHodkhDA9chkNSzlm300JI?=
 =?us-ascii?Q?EZtgjKHTUcnPwOQkJNjIdqvD14fNySlO6SMp5dmJUiqyeQf7jWddCuI6fCbK?=
 =?us-ascii?Q?ZqqFyZG88lcWHmhKaxg+MNgJP7YSbS4Tp4jDBOsr/mhcaHxti2TjJsgB3pqA?=
 =?us-ascii?Q?ari9602RBFgvS3F+G6OJXUYxQtvIqnUZrw8TyN15d/3LwFisN8QGbYWvq7Vs?=
 =?us-ascii?Q?JZqu3VTQYiOZv/Q2xY3NoU4Q8kZM8pkPb4whuRzbt9kaTlKm/4GNzpTN116P?=
 =?us-ascii?Q?TRbQZlgkjJFOPLwuSj3syl6y/tL3BN2LEQUpxvKiOxEAz5CtOvWc6sJ8aczw?=
 =?us-ascii?Q?Ymwrl83g1w=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49e47224-c127-4a34-622c-08deb028ab33
X-MS-Exchange-CrossTenant-AuthSource: PA1PR04MB11508.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2026 13:16:25.2216
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3/OjwiYvKozoYM5PwFydKEXwvVUoCl/nsfQoSiuFjOhrR1PFCRHK0SxRLts7XyTd7xtDLCoIEOW24kWvoYsW3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7530
X-Rspamd-Queue-Id: 73C7D522397
X-Rspamd-Server: lfdr
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
	RCPT_COUNT_SEVEN(0.00)[7];
	TAGGED_FROM(0.00)[bounces-287158-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,nxp.com:mid,nxp.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Instead of waiting until the last moment to check if an FDB entry should
be added to HW, move the check earlier (before even scheduling the work
item) so that we don't just waste time.

Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
---
Changes in v2:
- none
---
 drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
index 2d03d7420d0c..f910a07095be 100644
--- a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
+++ b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
@@ -2779,8 +2779,6 @@ static void dpaa2_switch_event_work(struct work_struct *work)
 
 	switch (switchdev_work->event) {
 	case SWITCHDEV_FDB_ADD_TO_DEVICE:
-		if (!fdb_info->added_by_user || fdb_info->is_local)
-			break;
 		if (is_unicast_ether_addr(fdb_info->addr))
 			err = dpaa2_switch_port_fdb_add_uc(netdev_priv(dev),
 							   fdb_info->addr);
@@ -2794,8 +2792,6 @@ static void dpaa2_switch_event_work(struct work_struct *work)
 					 &fdb_info->info, NULL);
 		break;
 	case SWITCHDEV_FDB_DEL_TO_DEVICE:
-		if (!fdb_info->added_by_user || fdb_info->is_local)
-			break;
 		if (is_unicast_ether_addr(fdb_info->addr))
 			dpaa2_switch_port_fdb_del_uc(netdev_priv(dev), fdb_info->addr);
 		else
@@ -2821,6 +2817,9 @@ static int dpaa2_switch_port_fdb_event(struct notifier_block *nb,
 	if (!dpaa2_switch_port_dev_check(dev))
 		return NOTIFY_DONE;
 
+	if (!fdb_info->added_by_user || fdb_info->is_local)
+		return NOTIFY_DONE;
+
 	switchdev_work = kzalloc_obj(*switchdev_work, GFP_ATOMIC);
 	if (!switchdev_work)
 		return NOTIFY_BAD;
-- 
2.25.1


