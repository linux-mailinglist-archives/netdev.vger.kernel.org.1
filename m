Return-Path: <netdev+bounces-297444-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id B1NfDqX1KGreOAMAu9opvQ
	(envelope-from <netdev+bounces-297444-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 07:27:01 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 86F2D665F06
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 07:27:00 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=ti.com header.s=selector1 header.b=OYkOCeOh;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297444-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-297444-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=ti.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 990E831300B4
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 05:25:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73F14369D70;
	Wed, 10 Jun 2026 05:25:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011067.outbound.protection.outlook.com [40.107.208.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A40C927B34E;
	Wed, 10 Jun 2026 05:25:27 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781069129; cv=fail; b=bmQqlriK3KdY6yl4HTBB/AuXKyWDcBp2+E9DRvtBBWbIM/NqsdpAD5Y8jCZTdS5Oq+RkwM/8RxuL+Qg53o6MBDo4V+eLmd1681LKYDJg1+MPQTw7kQaOpmUTU73/yxkEiVCk12iDRrC+qjHsUDtL3X1vv8JG9jUxElw6jRURggU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781069129; c=relaxed/simple;
	bh=FitQeiFIUs2h/cZRaRqU6Slk/k6CsFHZj3XI8C8wGUE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DoS72vwxvNXAGKmn10uhJjihUoO10REMEjQX09DVvITzfgfRHgmEWtCum7Ef9x8r7TGn+hTSf/Q99cXJqDUwwFehTywfynEiQ6nBBhm818oNngmvBraM8BkXAf00jGNmlkE0/wcLvq6b/dI2zAWXDeXOHqXzrdNEER96ZJQYU4M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=OYkOCeOh; arc=fail smtp.client-ip=40.107.208.67
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P32+wSBI1ekSo8gGulDU2Rus4S4tPykHWeKMb8kZ6spVh+PFazemXMPePT7M6Q7PqgF0Hw+Txht7A/3Eain/BAs3SbiNtoK2lsg4XevZZhLY32sPK3tfwMZvYMDLM1yPf/eSiVhYEtLScZvtl1MwaCJZzhqHlTK1YqD+k87ltvm0gZHlTkwecutnNOYIfJKvIiyinxQjafZJAAdxLIVqvXw2ueew/3aGQYSUarNhM1Hn70xKs1ln9oGSTyLpgJwTBuIu0tKZcnuHTa5joigCcrJoYFM/vAQaicRv0t/r+sGJrv3COIwC2ZG0d0+gr+OouY95ZtnDYp64inVGOFKUXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zmVku26wEUiIJ60fdfGpy4+oDBOBb3DfqdJA5B05+yk=;
 b=kMMZvMeMU1Q/vqYe5vYD5dfzt5GBAvj2J4h9bR9MBEU8kWjUUMwaTSl7BHu/3fU55EvqOm5jDyMTlcDXxijGfZAzUA0KO9MHRA0Pc9tASDcxJ7jOlyFAjMNys1cBGM2M/Uo8JAitW/nGTftPIB1sXONH+AGrIp7T74rRGTnWqfKvtM0pjLSUhdN+mzXkqpnAIbc98M0xmU4OloT8ISPAErqhuD46+xsC2r8mV+Ah9HDKoBMZKtnIRuFT2HT2Aw+4hbOwL7x8HDtFXhacpT+5r3LxR/Mvtgj1wyNdnBR6PG4J+1wzWmbgG0WQPbHHK4Z8ndy1uEVWyeCW50KAjljqJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=users.sourceforge.net smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zmVku26wEUiIJ60fdfGpy4+oDBOBb3DfqdJA5B05+yk=;
 b=OYkOCeOhTayIfBXK6N08liruw4t5PzLDZxr6PgJXwUfTlMP390s70J/+prQ6/IaPaguCCH0xOAJGjbYUJRlfL7f34gvVTN+ox8/nX8Yd+ivIgPgEi8dxZaDAPyP9SM8T68iKgiX1I5CMekHI4pmjrhps/tsd7qfpq7sdCoJjX7Q=
Received: from DS7PR03CA0295.namprd03.prod.outlook.com (2603:10b6:5:3ad::30)
 by DM6PR10MB4233.namprd10.prod.outlook.com (2603:10b6:5:213::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.15; Wed, 10 Jun
 2026 05:25:24 +0000
Received: from DM2PEPF00003FC9.namprd04.prod.outlook.com
 (2603:10b6:5:3ad:cafe::a7) by DS7PR03CA0295.outlook.office365.com
 (2603:10b6:5:3ad::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.13 via Frontend Transport; Wed, 10
 Jun 2026 05:25:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 DM2PEPF00003FC9.mail.protection.outlook.com (10.167.23.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Wed, 10 Jun 2026 05:25:23 +0000
Received: from DFLE207.ent.ti.com (10.64.6.65) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Wed, 10 Jun
 2026 00:25:22 -0500
Received: from DFLE206.ent.ti.com (10.64.6.64) by DFLE207.ent.ti.com
 (10.64.6.65) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Wed, 10 Jun
 2026 00:25:22 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE206.ent.ti.com
 (10.64.6.64) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Wed, 10 Jun 2026 00:25:22 -0500
Received: from fllv0122.itg.ti.com (fllv0122.itg.ti.com [10.247.120.72])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 65A5PM0o2601815;
	Wed, 10 Jun 2026 00:25:22 -0500
Received: from localhost (ti.dhcp.ti.com [172.24.231.93])
	by fllv0122.itg.ti.com (8.14.7/8.14.7) with ESMTP id 65A5PLcH004458;
	Wed, 10 Jun 2026 00:25:22 -0500
From: Meghana Malladi <m-malladi@ti.com>
To: <elfring@users.sourceforge.net>, <haokexin@gmail.com>,
	<vadim.fedorenko@linux.dev>, <devnexen@gmail.com>, <horms@kernel.org>,
	<jacob.e.keller@intel.com>, <m-malladi@ti.com>, <arnd@arndb.de>,
	<basharath@couthit.com>, <afd@ti.com>, <parvathi@couthit.com>,
	<vladimir.oltean@nxp.com>, <rogerq@kernel.org>, <danishanwar@ti.com>,
	<pabeni@redhat.com>, <kuba@kernel.org>, <edumazet@google.com>,
	<davem@davemloft.net>, <andrew+netdev@lunn.ch>
CC: <linux-arm-kernel@lists.infradead.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <srk@ti.com>, Vignesh Raghavendra
	<vigneshr@ti.com>
Subject: [PATCH net-next v7 2/2] net: ti: icssg-prueth: Add ethtool ops for Frame Preemption MAC Merge
Date: Wed, 10 Jun 2026 10:55:11 +0530
Message-ID: <20260610052511.781752-3-m-malladi@ti.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260610052511.781752-1-m-malladi@ti.com>
References: <20260610052511.781752-1-m-malladi@ti.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM2PEPF00003FC9:EE_|DM6PR10MB4233:EE_
X-MS-Office365-Filtering-Correlation-Id: 24db48fa-640c-4913-30a7-08dec6b0abf9
X-LD-Processed: e5b49634-450b-4709-8abb-1e2b19b982b7,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|1800799024|23010399003|82310400026|7416014|376014|3023799007|18002099003|22082099003|56012099006|6133799003|921020;
X-Microsoft-Antispam-Message-Info:
	DFmq8T2NosVaTeOFDlVUzUfFlzKlQ63+nYgnrFCGFmSd36m0kHPs44krjZlwnscfVeEGxOb9+yWw+mHlMpjyZjzF6OsiRQHDYjlgvBt/MeloKRQIv84dyhQqqF3+EBRSVU14C/Omc8RiP+Q9RxjYv6YIxfbKJ7HvFSWzRVt66HSdKPNyfPj66ruZVmgiHXs7qE0MH5r0Km4g7WhKRWonpvHkCt+toPKrifVZ9fJQR8oJoeoYoCDGOwGceHN+FvA+U3Aqh1nn9mrRNqxwnleQJm4dGCqJ+ZxM2oYtsed+l0T8ya8gnSmLUWsljubR0ZQYsm2HEP1CETVKBBIpAqrswnX7Zk0u9Z6gnXNZPxdunyKosBBgfcmRSHPTeLikxVj4dV5AXTlHT66W9hqS9No03Dsbv5EtSB+iits1Utpi536/uHUVvJ2g92DmHL1zix6URaaHTD4eN/6xC/sGuEgnEalwDqa4JgmgBJ8ohj2fOw4ChU0VpAmdJy8fobFpLXbXufQ2HueGRYsAxuyRgw7W1yOkotZIq91GnswpA6yw+o51XV3s+zyrdFOlOKkHO8DA80yPwClH//OPQiJ3irvsyzirHw7GQEEta1ZgcPg6CQ0vHE27KfUWbtzL5GSlQ8xBkCKfxFBVzwuhhj+YazoOF654y35i9T2a1GZwyf+SITfLDaNHvsiWTgitNMezTN94cqmsJ7rMDiAWNDMmufMbUwBHbGzRg+cHhpTZIxJvG1PGjv3n1L4HbCYTv1NDRh7BsxxOLs+6/e1xg7BKyy5O/g==
X-Forefront-Antispam-Report:
	CIP:198.47.21.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet200.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(23010399003)(82310400026)(7416014)(376014)(3023799007)(18002099003)(22082099003)(56012099006)(6133799003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	TmseQ8/gFWx28YZ23AGlqT6TIekfZWeFHS2m9rbeYhvlD0/M+r+oSnMKSR9Cepc4pFp6plRPGsbXBCRFOWQBa0ZDQf29I/wl8UgruZsvoOPsCEw6AbXTnwkKJsMciQQBLSRezSrPxbSYHpeU6sDqSrUtRiVUTVqFAEZWvy+D2vj3CihrI2zyXXEkUioF9sj0Jnu5ArwM52hWzTq9SvcjRqpLL0u2SSvflyMKtggTCIDJcHA9B1Ij0K5k0Ys8UsVMdKT3iKac4HOmbtXlQfvhXPHizKqy9qARzdl2j1LfWkPOnhWW+jAq0DtdpZJweEM5N4vyeOHFkJBj3UPbZo3AUpFoYJ/DaRMC7UAmvlIyxwy1l+T2z4Cndl7MfKO3ZYzKzHqeEPI52wsT5P/rLPDQ1kRSU0f4/HXZBvJsF9A4fwg5wnPa+e+dqeMDGFhYHmz3
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2026 05:25:23.4019
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 24db48fa-640c-4913-30a7-08dec6b0abf9
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.194];Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DM2PEPF00003FC9.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4233
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[ti.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[ti.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:elfring@users.sourceforge.net,m:haokexin@gmail.com,m:vadim.fedorenko@linux.dev,m:devnexen@gmail.com,m:horms@kernel.org,m:jacob.e.keller@intel.com,m:m-malladi@ti.com,m:arnd@arndb.de,m:basharath@couthit.com,m:afd@ti.com,m:parvathi@couthit.com,m:vladimir.oltean@nxp.com,m:rogerq@kernel.org,m:danishanwar@ti.com,m:pabeni@redhat.com,m:kuba@kernel.org,m:edumazet@google.com,m:davem@davemloft.net,m:andrew+netdev@lunn.ch,m:linux-arm-kernel@lists.infradead.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:srk@ti.com,m:vigneshr@ti.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_TO(0.00)[users.sourceforge.net,gmail.com,linux.dev,kernel.org,intel.com,ti.com,arndb.de,couthit.com,nxp.com,redhat.com,google.com,davemloft.net,lunn.ch];
	FORGED_SENDER(0.00)[m-malladi@ti.com,netdev@vger.kernel.org];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,ti.com:dkim,ti.com:email,ti.com:mid,ti.com:from_mime];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-297444-lists,netdev=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[m-malladi@ti.com,netdev@vger.kernel.org];
	FORGED_SENDER_FORWARDING(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DKIM_TRACE(0.00)[ti.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 86F2D665F06

From: MD Danish Anwar <danishanwar@ti.com>

Add driver support for viewing and changing the MAC Merge sublayer
parameters via ethtool ops: .set_mm(), .get_mm() and .get_mm_stats().

The minimum size of non-final mPacket fragments supported by the
firmware without leading errors is 64 Bytes (including FCS).
Add pa stats registers to check statistics for preemption,
which can be dumped using ethtool ops.

Fix emac_get_stat_by_name() to return u64 instead of int and return
0 on error instead of -EINVAL. This prevents invalid stat lookups
from corrupting output stats with signed error codes cast to u64.

Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
Signed-off-by: Meghana Malladi <m-malladi@ti.com>
---

v7-v6:
- Remove icssg_qos_validate_tx_min_frag_size() and 
  icssg_qos_validate_verify_time() as these checks are already
  handled by ethnl code as suggested by Maxime
- Write tx_min_frag_size to the firmware without
  iet->mac_verify_configure check
- Add emac_update_hardware_stats() inside emac_get_mm_stats()
  to prevent reading stale stats
  Above changes addresses the comments provided by sashiko

 drivers/net/ethernet/ti/icssg/icssg_ethtool.c | 100 ++++++++++++++++++
 drivers/net/ethernet/ti/icssg/icssg_prueth.h  |   7 +-
 drivers/net/ethernet/ti/icssg/icssg_stats.c   |   4 +-
 drivers/net/ethernet/ti/icssg/icssg_stats.h   |   7 +-
 .../net/ethernet/ti/icssg/icssg_switch_map.h  |   5 +
 5 files changed, 116 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/ti/icssg/icssg_ethtool.c b/drivers/net/ethernet/ti/icssg/icssg_ethtool.c
index b715af21d23ac..0620782318ab9 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_ethtool.c
+++ b/drivers/net/ethernet/ti/icssg/icssg_ethtool.c
@@ -294,6 +294,103 @@ static int emac_set_per_queue_coalesce(struct net_device *ndev, u32 queue,
 	return 0;
 }
 
+static int emac_get_mm(struct net_device *ndev, struct ethtool_mm_state *state)
+{
+	struct prueth_emac *emac = netdev_priv(ndev);
+	struct prueth_qos_iet *iet = &emac->qos.iet;
+	enum icssg_ietfpe_verify_states verify_status;
+
+	if (emac->is_sr1)
+		return -EOPNOTSUPP;
+
+	mutex_lock(&iet->fpe_lock);
+	state->tx_enabled = iet->fpe_enabled;
+	state->tx_min_frag_size = iet->tx_min_frag_size;
+	state->verify_enabled = iet->mac_verify_configure;
+	state->verify_time = iet->verify_time_ms;
+	state->tx_active = iet->fpe_active;
+	verify_status = iet->verify_status;
+	mutex_unlock(&iet->fpe_lock);
+
+	state->rx_min_frag_size = ETH_ZLEN;
+	state->pmac_enabled = true;
+
+	switch (verify_status) {
+	case ICSSG_IETFPE_STATE_DISABLED:
+		state->verify_status = ETHTOOL_MM_VERIFY_STATUS_DISABLED;
+		break;
+	case ICSSG_IETFPE_STATE_INITIAL:
+		state->verify_status = ETHTOOL_MM_VERIFY_STATUS_INITIAL;
+		break;
+	case ICSSG_IETFPE_STATE_VERIFYING:
+		state->verify_status = ETHTOOL_MM_VERIFY_STATUS_VERIFYING;
+		break;
+	case ICSSG_IETFPE_STATE_SUCCEEDED:
+		state->verify_status = ETHTOOL_MM_VERIFY_STATUS_SUCCEEDED;
+		break;
+	case ICSSG_IETFPE_STATE_FAILED:
+		state->verify_status = ETHTOOL_MM_VERIFY_STATUS_FAILED;
+		break;
+	default:
+		state->verify_status = ETHTOOL_MM_VERIFY_STATUS_UNKNOWN;
+		break;
+	}
+
+	/* 802.3-2018 clause 30.14.1.6, says that the aMACMergeVerifyTime
+	 * variable has a range between 1 and 128 ms inclusive. Limit to that.
+	 */
+	state->max_verify_time = ETHTOOL_MM_MAX_VERIFY_TIME_MS;
+
+	return 0;
+}
+
+static int emac_set_mm(struct net_device *ndev, struct ethtool_mm_cfg *cfg,
+		       struct netlink_ext_ack *extack)
+{
+	struct prueth_emac *emac = netdev_priv(ndev);
+	struct prueth_qos_iet *iet = &emac->qos.iet;
+	int err;
+
+	if (emac->is_sr1)
+		return -EOPNOTSUPP;
+
+	if (!cfg->pmac_enabled) {
+		NL_SET_ERR_MSG_MOD(extack, "preemptible MAC is always enabled");
+		return -EOPNOTSUPP;
+	}
+
+	mutex_lock(&iet->fpe_lock);
+	iet->verify_time_ms = cfg->verify_time;
+	iet->tx_min_frag_size = cfg->tx_min_frag_size;
+	iet->fpe_enabled = cfg->tx_enabled;
+	iet->mac_verify_configure = cfg->verify_enabled;
+	err = icssg_config_ietfpe(ndev, cfg->tx_enabled);
+	mutex_unlock(&iet->fpe_lock);
+
+	return err;
+}
+
+static void emac_get_mm_stats(struct net_device *ndev,
+			      struct ethtool_mm_stats *s)
+{
+	struct prueth_emac *emac = netdev_priv(ndev);
+
+	if (emac->is_sr1)
+		return;
+
+	if (!emac->prueth->pa_stats)
+		return;
+
+	emac_update_hardware_stats(emac);
+
+	/* MACMergeHoldCount stats is not tracked by the firmware */
+	s->MACMergeFrameAssOkCount = emac_get_stat_by_name(emac, "FW_PREEMPT_ASSEMBLY_OK");
+	s->MACMergeFrameAssErrorCount = emac_get_stat_by_name(emac, "FW_PREEMPT_ASSEMBLY_ERR");
+	s->MACMergeFragCountRx = emac_get_stat_by_name(emac, "FW_PREEMPT_FRAG_CNT_RX");
+	s->MACMergeFragCountTx = emac_get_stat_by_name(emac, "FW_PREEMPT_FRAG_CNT_TX");
+	s->MACMergeFrameSmdErrorCount = emac_get_stat_by_name(emac, "FW_PREEMPT_BAD_FRAG");
+}
+
 const struct ethtool_ops icssg_ethtool_ops = {
 	.get_drvinfo = emac_get_drvinfo,
 	.get_msglevel = emac_get_msglevel,
@@ -317,5 +414,8 @@ const struct ethtool_ops icssg_ethtool_ops = {
 	.set_eee = emac_set_eee,
 	.nway_reset = emac_nway_reset,
 	.get_rmon_stats = emac_get_rmon_stats,
+	.get_mm = emac_get_mm,
+	.set_mm = emac_set_mm,
+	.get_mm_stats = emac_get_mm_stats,
 };
 EXPORT_SYMBOL_GPL(icssg_ethtool_ops);
diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.h b/drivers/net/ethernet/ti/icssg/icssg_prueth.h
index f73b8f5fca956..3dfb2b4368768 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_prueth.h
+++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.h
@@ -45,6 +45,7 @@
 #include "icss_iep.h"
 #include "icssg_switch_map.h"
 #include "icssg_qos.h"
+#include "icssg_stats.h"
 
 #define PRUETH_MAX_MTU		(2000 - ETH_HLEN - ETH_FCS_LEN)
 #define PRUETH_MIN_PKT_SIZE	(VLAN_ETH_ZLEN)
@@ -58,8 +59,8 @@
 
 #define ICSSG_MAX_RFLOWS	8	/* per slice */
 
-#define ICSSG_NUM_PA_STATS	32
-#define ICSSG_NUM_MIIG_STATS	60
+#define ICSSG_NUM_PA_STATS	ARRAY_SIZE(icssg_all_pa_stats)
+#define ICSSG_NUM_MIIG_STATS	ARRAY_SIZE(icssg_all_miig_stats)
 /* Number of ICSSG related stats */
 #define ICSSG_NUM_STATS (ICSSG_NUM_MIIG_STATS + ICSSG_NUM_PA_STATS)
 #define ICSSG_NUM_STANDARD_STATS 31
@@ -460,7 +461,7 @@ int emac_fdb_flow_id_updated(struct prueth_emac *emac);
 
 void icssg_stats_work_handler(struct work_struct *work);
 void emac_update_hardware_stats(struct prueth_emac *emac);
-int emac_get_stat_by_name(struct prueth_emac *emac, char *stat_name);
+u64 emac_get_stat_by_name(struct prueth_emac *emac, char *stat_name);
 
 /* Common functions */
 void prueth_cleanup_rx_chns(struct prueth_emac *emac,
diff --git a/drivers/net/ethernet/ti/icssg/icssg_stats.c b/drivers/net/ethernet/ti/icssg/icssg_stats.c
index 7159baa0155cf..cfdb6f5dc5da1 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_stats.c
+++ b/drivers/net/ethernet/ti/icssg/icssg_stats.c
@@ -74,7 +74,7 @@ void icssg_stats_work_handler(struct work_struct *work)
 }
 EXPORT_SYMBOL_GPL(icssg_stats_work_handler);
 
-int emac_get_stat_by_name(struct prueth_emac *emac, char *stat_name)
+u64 emac_get_stat_by_name(struct prueth_emac *emac, char *stat_name)
 {
 	int i;
 
@@ -91,5 +91,5 @@ int emac_get_stat_by_name(struct prueth_emac *emac, char *stat_name)
 	}
 
 	netdev_err(emac->ndev, "Invalid stats %s\n", stat_name);
-	return -EINVAL;
+	return 0;
 }
diff --git a/drivers/net/ethernet/ti/icssg/icssg_stats.h b/drivers/net/ethernet/ti/icssg/icssg_stats.h
index 5ec0b38e0c67d..8073deac35c3e 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_stats.h
+++ b/drivers/net/ethernet/ti/icssg/icssg_stats.h
@@ -8,8 +8,6 @@
 #ifndef __NET_TI_ICSSG_STATS_H
 #define __NET_TI_ICSSG_STATS_H
 
-#include "icssg_prueth.h"
-
 #define STATS_TIME_LIMIT_1G_MS    25000    /* 25 seconds @ 1G */
 
 struct miig_stats_regs {
@@ -189,6 +187,11 @@ static const struct icssg_pa_stats icssg_all_pa_stats[] = {
 	ICSSG_PA_STATS(FW_INF_DROP_PRIOTAGGED),
 	ICSSG_PA_STATS(FW_INF_DROP_NOTAG),
 	ICSSG_PA_STATS(FW_INF_DROP_NOTMEMBER),
+	ICSSG_PA_STATS(FW_PREEMPT_BAD_FRAG),
+	ICSSG_PA_STATS(FW_PREEMPT_ASSEMBLY_ERR),
+	ICSSG_PA_STATS(FW_PREEMPT_FRAG_CNT_TX),
+	ICSSG_PA_STATS(FW_PREEMPT_ASSEMBLY_OK),
+	ICSSG_PA_STATS(FW_PREEMPT_FRAG_CNT_RX),
 	ICSSG_PA_STATS(FW_RX_EOF_SHORT_FRMERR),
 	ICSSG_PA_STATS(FW_RX_B0_DROP_EARLY_EOF),
 	ICSSG_PA_STATS(FW_TX_JUMBO_FRM_CUTOFF),
diff --git a/drivers/net/ethernet/ti/icssg/icssg_switch_map.h b/drivers/net/ethernet/ti/icssg/icssg_switch_map.h
index 7e053b8af3ece..855fd4ed0b3f6 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_switch_map.h
+++ b/drivers/net/ethernet/ti/icssg/icssg_switch_map.h
@@ -256,6 +256,11 @@
 #define FW_INF_DROP_PRIOTAGGED		0x0148
 #define FW_INF_DROP_NOTAG		0x0150
 #define FW_INF_DROP_NOTMEMBER		0x0158
+#define FW_PREEMPT_BAD_FRAG		0x0160
+#define FW_PREEMPT_ASSEMBLY_ERR		0x0168
+#define FW_PREEMPT_FRAG_CNT_TX		0x0170
+#define FW_PREEMPT_ASSEMBLY_OK		0x0178
+#define FW_PREEMPT_FRAG_CNT_RX		0x0180
 #define FW_RX_EOF_SHORT_FRMERR		0x0188
 #define FW_RX_B0_DROP_EARLY_EOF		0x0190
 #define FW_TX_JUMBO_FRM_CUTOFF		0x0198
-- 
2.43.0


