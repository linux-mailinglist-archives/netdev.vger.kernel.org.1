Return-Path: <netdev+bounces-297475-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 9TBaKpADKWpmOwMAu9opvQ
	(envelope-from <netdev+bounces-297475-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 08:26:24 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0001A666398
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 08:26:23 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=amd.com header.s=selector1 header.b=wrnXIyiR;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297475-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-297475-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=amd.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 67D9531C3DF9
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 06:19:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AAC5370D54;
	Wed, 10 Jun 2026 06:19:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011045.outbound.protection.outlook.com [40.93.194.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71049370AD3
	for <netdev@vger.kernel.org>; Wed, 10 Jun 2026 06:19:01 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781072345; cv=fail; b=L8GlEH1z2i6SlOkcLOhJDksB32OYJb0VG41NPVGKhsZ26eyQ96KzvG43cK+QZ7M6+7vrxwr8DG0v5yZnAkqVx905YVsDJ0nxcfByeIaxt4L+y/xUphgYxS1Bipv3J98n6ug/Ij1DgAtZDQArY7+XUSia8O2Rrw44qzSIO3LM3ew=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781072345; c=relaxed/simple;
	bh=pDU/OuetOTiPedD/Y5wZo2f44ph7elnb9uvF2t6u4rw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=huHmy1X0tB2GQLn/IXGZTup+rOc4zp+2ofG3NXBR8Gu3qmZMviPFsoDk4sgv93fFCxagJz4S9JH+NTwdaaq4JYURR8IGf3bAfwmujqJkA+ZJogT5CNTJ8lFERyGnX74B94g0/6LqEeeIcJF35yq/fOp1/1/R/UlgIrlE1/Cl8Ik=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=wrnXIyiR; arc=fail smtp.client-ip=40.93.194.45
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ii49a4z2C6XFhvsZD+5s+TsrZ1cOTbSIztbsb+p+yGLk3OfUQ7+9yf6DpBGGUm6PVijtRHBb+KvYNuRji2g+X72ZuQQ98X9pkX3XDwdlkP32icl/MepsiudUMPDfGi9oSd1N7A0EyJkRKFe+eHuoi/TglCwjavTPfap8Lz0TE9YA4yO9l3UalVvhaXLl4ZHjJXxDG35fmc5tOCljjhyiIfLOrfl59RtkOots7RAsTd7TRMHxK09+nvcnddqbFfPMxlXnKcjbekbLCZsRNrgSq27OXacPFm197DncRUm0EERKQDsF1vyTCOy1I/ggZZ1ZnModunlixAII9iet321wYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hQ4+NXPgdco61nPRxCPptI8SxIEoz4WgsESuOHXO9UY=;
 b=Zq/Y3FueRftpxV0QdfIq8JJxf+6pqWfhxfNFFpiju6VfCUpEFEKjO6KGPJGsQZIfbMr/NS/xDe/5dGZ7qAmGBXEV7xJUwJ3sE95iu4SXsiH3oooIqGJRoVm8qNbdte4b9h4Jrd6wgdcQd/BrEVaLMrfmfaA3xZl5DTHs3ahOh+s828IF/RMt/4mtasCSUpkpQe4joPXQZ0aoyIZMHE+MaE3ZPbYJu1z6hrze7FkVovTljYHSUVnUPyn84UtrzSuZ0IwlDj8jEZRT54b97hZDa1UkFDv6ZiCIkrDWT7c/XaX2f0YqIBOqjeMBMeUGvdajtZXVy5QfQzbTo4FA9ZEQvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hQ4+NXPgdco61nPRxCPptI8SxIEoz4WgsESuOHXO9UY=;
 b=wrnXIyiRiX2aq1SxBMcapExZ8w71KFe+W2q+r3Xkb/CZxLWeLRMR2NjdJPyTbbmMkiLt+MUGHoOlyoa6sxdEdlhhFn6XrXOZ8k90oCjAuWtAz8zh017G2qHiPF77RWh9iYtT++kf0wp2ipbhwgl7R2kokkxeeQJhfB8kkOq/6UE=
Received: from MN2PR14CA0016.namprd14.prod.outlook.com (2603:10b6:208:23e::21)
 by DM4PR12MB6301.namprd12.prod.outlook.com (2603:10b6:8:a5::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.13; Wed, 10 Jun
 2026 06:18:54 +0000
Received: from MN1PEPF0000ECD7.namprd02.prod.outlook.com
 (2603:10b6:208:23e:cafe::d) by MN2PR14CA0016.outlook.office365.com
 (2603:10b6:208:23e::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.14 via Frontend Transport; Wed, 10
 Jun 2026 06:18:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MN1PEPF0000ECD7.mail.protection.outlook.com (10.167.242.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Wed, 10 Jun 2026 06:18:54 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 10 Jun
 2026 01:18:52 -0500
From: Eric Joyner <eric.joyner@amd.com>
To: <netdev@vger.kernel.org>
CC: Brett Creeley <brett.creeley@amd.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Jacob Keller <jacob.e.keller@intel.com>, Eric Joyner
	<eric.joyner@amd.com>
Subject: [PATCH net-next v4 3/5] ionic: Report "rx_bits_phy" stat to ethtool
Date: Tue, 9 Jun 2026 23:18:28 -0700
Message-ID: <20260610061830.51037-4-eric.joyner@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20260610061830.51037-1-eric.joyner@amd.com>
References: <20260610061830.51037-1-eric.joyner@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD7:EE_|DM4PR12MB6301:EE_
X-MS-Office365-Filtering-Correlation-Id: 391e3d69-c143-4288-bff8-08dec6b825d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|36860700016|376014|82310400026|1800799024|11063799006|56012099006|18002099003|6133799003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	2kLYYoQ1jhdTWnU2dbIY4e27NcpJS50ukfXfWOFeh0ebMteN0ZzuXaLtiMgAMSqjX9N0YT08sOYdD0i9cXu6D1V4PYN0jvKV1Hrem+ia2BY2oFqPAWk1H4vRgRTmG2t/UgucY1ugxIT1lvxEf0sIDH6oIttJBge0yfxgoKbc1RV0x4+RL+wBNRSCo99q1dkSC5rv1Oah29IWjTDjN7s8W+8XABM85DCq/JzVxjaORSQjGeSoDPDjPE/f+zqRV1AXLlA/3OwHHcJbj8GH6ajnoidgRsBhxcIAonV7XwroqCLV/PnveMEypLZl1X/DdC6o7OOGqJvi6NREo46e4k71F5+hUjpZE+4h7n6+qNEiT4rzb5NajvqP+JjBg8qZ62Rleft4jQD0H01xn5JxEg6LMbIDlrzFbOgPzH7m2ps2s8jaAz8Euzp3n13+4FLBP5Pvi6d09eBuNlEsteUFuZNoxkuva1nTg5GrcmnbITLNYxRPr2TPr3nGjp9AQsgdivIoBQjskGXY5hX78YhUJ+Qer/PPvJuPq9XKan32bdD57cvptB4AP3k4Tl182Nh4m6WoFNEu/s+fcWCObUPx+uSef/b363Lw432K+m6oWTIgrxUBj+gDX/Y39Lln7zOa8v1YsdRIDk2hUpzai8QdYmd5c106/cCwhy849h9Gnz4nLi3lJMPq3oQHMUZsXeW+Vv/vtzxSP7REZCn/mNs2NIWarUxp6m7jlc0/HlJnLDEIbRg=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(36860700016)(376014)(82310400026)(1800799024)(11063799006)(56012099006)(18002099003)(6133799003)(22082099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	kqGb/zTl4/Kc9aahwD7kd0EziPiXwMmzx7YAuDb/r44iI9cLeuVfnMEL2gZ/E1xthR4VT4pCrF0oINInLZ8YNqLujaCsqELruE2xHtG+LYwW6qbBWyz3/eUtUC/5OUGRNjYVX3p/rfvQUMqLNYSNBsudi9Zd4Ge0/MwGMMwY9wZLgBEUYgiodiEuU4kQITAKr1VQLjZyA5j4exTkWlum8UEqI5u+pHmVu3kJQsAeYfEuoOPuVfeU96MaFy3yfc2UL/sbXCQqanj0/uKdXDAmxU7nz4xmDcopR9a9F0cUOBw/w/b1kJBDcm3s+7jVYyUJHsqmljB6dcoSd7NtjgJBbF2hozLMlp05bBymAlCwWB4pU+CbnGPnidrFvAvzWYi5zr0W2jXMixmfaVoEz+FlVQn6sLewmPl4VFs3iGEkdGp6tqOR4NcPCVz/eBRjqIF7
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2026 06:18:54.3599
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 391e3d69-c143-4288-bff8-08dec6b825d2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000ECD7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6301
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[eric.joyner@amd.com,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-297475-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:brett.creeley@amd.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:jacob.e.keller@intel.com,m:eric.joyner@amd.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[eric.joyner@amd.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[amd.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,amd.com:dkim,amd.com:email,amd.com:mid,amd.com:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0001A666398

This stat contains the number of total bits that the PHY has received;
it's useful for BER calculations. Add it to the ethtool stats output.

However, since this is one of the new "extra port stats", it's reported
in a different manner than the existing port stats and only
conditionally added to the ethtool stats output list: both the
DEV_CAP_EXTRA_STATS capability must be supported by the firmware, and
the firmware must set the value of the statistic to something other than
IONIC_STAT_INVALID.

To help support this scheme, the extra port stats region is initialized to
0xff's/IONIC_STAT_INVALID by the driver, to ensure the statistics that
the driver knows about but the firmware does not are still invalid
to the driver.

Signed-off-by: Eric Joyner <eric.joyner@amd.com>
---
 .../net/ethernet/pensando/ionic/ionic_dev.h   |  1 +
 .../net/ethernet/pensando/ionic/ionic_main.c  |  6 ++
 .../net/ethernet/pensando/ionic/ionic_stats.c | 58 ++++++++++++++++++-
 3 files changed, 64 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/pensando/ionic/ionic_dev.h b/drivers/net/ethernet/pensando/ionic/ionic_dev.h
index 35566f97eaea..5f677bcbaf02 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_dev.h
+++ b/drivers/net/ethernet/pensando/ionic/ionic_dev.h
@@ -184,6 +184,7 @@ struct ionic_dev {
 	u32 port_info_sz;
 	struct ionic_port_info *port_info;
 	dma_addr_t port_info_pa;
+	struct ionic_port_extra_stats port_extra_stats_cache;
 
 	struct ionic_devinfo dev_info;
 };
diff --git a/drivers/net/ethernet/pensando/ionic/ionic_main.c b/drivers/net/ethernet/pensando/ionic/ionic_main.c
index 3c5200e2fdb7..306d9d160e17 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_main.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_main.c
@@ -731,6 +731,12 @@ int ionic_port_init(struct ionic *ionic)
 			return -ENOMEM;
 	}
 
+	/* If the driver knows about more "extra stats" than the firmware,
+	 * make sure these stats are marked as invalid.
+	 */
+	memset(&idev->port_info->extra_stats, 0xff,
+	       sizeof(idev->port_info->extra_stats));
+
 	sz = min(sizeof(ident->port.config), sizeof(idev->dev_cmd_regs->data));
 
 	mutex_lock(&ionic->dev_cmd_lock);
diff --git a/drivers/net/ethernet/pensando/ionic/ionic_stats.c b/drivers/net/ethernet/pensando/ionic/ionic_stats.c
index 0107599a9dd4..e81190cc9d2f 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_stats.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_stats.c
@@ -167,6 +167,7 @@ static const struct ionic_stat_desc ionic_rx_stats_desc[] = {
 #define IONIC_NUM_PORT_STATS ARRAY_SIZE(ionic_port_stats_desc)
 #define IONIC_NUM_TX_STATS ARRAY_SIZE(ionic_tx_stats_desc)
 #define IONIC_NUM_RX_STATS ARRAY_SIZE(ionic_rx_stats_desc)
+#define IONIC_NUM_EXTRA_PORT_STATS	1
 
 #define MAX_Q(lif)   ((lif)->netdev->real_num_tx_queues)
 
@@ -232,6 +233,26 @@ static void ionic_get_lif_stats(struct ionic_lif *lif,
 	stats->hw_tx_aborted_errors = ns.tx_aborted_errors;
 }
 
+static u32 ionic_extra_port_stats_get_count(struct ionic_lif *lif)
+{
+	struct ionic_dev *idev = &lif->ionic->idev;
+	struct ionic_port_extra_stats *pes_cache;
+	u32 count = 0;
+
+	if (!(lif->ionic->ident.dev.capabilities &
+	      cpu_to_le64(IONIC_DEV_CAP_EXTRA_STATS)))
+		return count;
+
+	/* Cache copy for subsequent ethtool calls */
+	pes_cache = &idev->port_extra_stats_cache;
+	*pes_cache = idev->port_info->extra_stats;
+
+	if (pes_cache->rx_bits_phy != IONIC_STAT_INVALID)
+		count++;
+
+	return count;
+}
+
 static u64 ionic_sw_stats_get_count(struct ionic_lif *lif)
 {
 	u64 total = 0, tx_queues = MAX_Q(lif), rx_queues = MAX_Q(lif);
@@ -243,7 +264,7 @@ static u64 ionic_sw_stats_get_count(struct ionic_lif *lif)
 		rx_queues += 1;
 
 	total += IONIC_NUM_LIF_STATS;
-	total += IONIC_NUM_PORT_STATS;
+	total += IONIC_NUM_PORT_STATS + ionic_extra_port_stats_get_count(lif);
 
 	total += tx_queues * IONIC_NUM_TX_STATS;
 	total += rx_queues * IONIC_NUM_RX_STATS;
@@ -271,6 +292,20 @@ static void ionic_sw_stats_get_rx_strings(struct ionic_lif *lif, u8 **buf,
 				ionic_rx_stats_desc[i].name);
 }
 
+static void ionic_extra_port_stats_get_strings(struct ionic_lif *lif, u8 **buf)
+{
+	struct ionic_port_extra_stats *pes_cache;
+
+	if (!(lif->ionic->ident.dev.capabilities &
+	    cpu_to_le64(IONIC_DEV_CAP_EXTRA_STATS)))
+		return;
+
+	pes_cache = &lif->ionic->idev.port_extra_stats_cache;
+
+	if (pes_cache->rx_bits_phy != IONIC_STAT_INVALID)
+		ethtool_puts(buf, "rx_bits_phy");
+}
+
 static void ionic_sw_stats_get_strings(struct ionic_lif *lif, u8 **buf)
 {
 	int i, q_num;
@@ -280,6 +315,7 @@ static void ionic_sw_stats_get_strings(struct ionic_lif *lif, u8 **buf)
 
 	for (i = 0; i < IONIC_NUM_PORT_STATS; i++)
 		ethtool_puts(buf, ionic_port_stats_desc[i].name);
+	ionic_extra_port_stats_get_strings(lif, buf);
 
 	for (q_num = 0; q_num < MAX_Q(lif); q_num++)
 		ionic_sw_stats_get_tx_strings(lif, buf, q_num);
@@ -322,6 +358,25 @@ static void ionic_sw_stats_get_rxq_values(struct ionic_lif *lif, u64 **buf,
 	}
 }
 
+static void ionic_extra_port_stats_get_values(struct ionic_lif *lif, u64 **buf)
+{
+	struct ionic_port_extra_stats *pes_cache;
+
+	if (!(lif->ionic->ident.dev.capabilities &
+	      cpu_to_le64(IONIC_DEV_CAP_EXTRA_STATS)))
+		return;
+
+	/* The number of statistics added to @buf here must equal
+	 * ionic_extra_port_stats_get_count().
+	 */
+	pes_cache = &lif->ionic->idev.port_extra_stats_cache;
+
+	if (pes_cache->rx_bits_phy != IONIC_STAT_INVALID) {
+		**buf = le64_to_cpu(pes_cache->rx_bits_phy);
+		(*buf)++;
+	}
+}
+
 static void ionic_sw_stats_get_values(struct ionic_lif *lif, u64 **buf)
 {
 	struct ionic_port_stats *port_stats;
@@ -341,6 +396,7 @@ static void ionic_sw_stats_get_values(struct ionic_lif *lif, u64 **buf)
 					     &ionic_port_stats_desc[i]);
 		(*buf)++;
 	}
+	ionic_extra_port_stats_get_values(lif, buf);
 
 	for (q_num = 0; q_num < MAX_Q(lif); q_num++)
 		ionic_sw_stats_get_txq_values(lif, buf, q_num);
-- 
2.17.1


