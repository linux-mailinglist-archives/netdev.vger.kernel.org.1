Return-Path: <netdev+bounces-283080-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wHsqDTwb9GnZ+QEAu9opvQ
	(envelope-from <netdev+bounces-283080-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 01 May 2026 05:17:16 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F9BC4A9E5F
	for <lists+netdev@lfdr.de>; Fri, 01 May 2026 05:17:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8BEA730277D2
	for <lists+netdev@lfdr.de>; Fri,  1 May 2026 03:16:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 690BB1E1E16;
	Fri,  1 May 2026 03:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="r9n2R7gO"
X-Original-To: netdev@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011038.outbound.protection.outlook.com [52.101.52.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC17C301472
	for <netdev@vger.kernel.org>; Fri,  1 May 2026 03:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777605393; cv=fail; b=JpygVdsLvbhWALydCP+O8M2qGw/Lo1t/XWmS2pX85uogfnr0bA14dg1XA7RiI+3y/xCkTDlFkjJJ3VBUw+BysgaqzW3BHveNHXjGIpluL/hcnqYlXgvj60oNNBBdkTQWOUTHWRazMqVuB/Sh/jTt3umkxGGzSmjqPX7NPGGx4HI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777605393; c=relaxed/simple;
	bh=G8GnAhEwCoq6eum8r2OZ5LbkMhSldt25buP3EhXmD30=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NK/u4Za8+zSHvS+nRMO869lVk6C/xuIka/Q7wRwWPskB2BhPefbpQKauzwv6r2coHVAEHGGtteIAT2EI7+qC1XaENF69viLltNmz39waveTd85S6qOFZ8V/Q63mzJSKjaz7UmFNtuLB8OEfIx1HOrkvgNDI+cKf3jglj3/4Vfgg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=r9n2R7gO; arc=fail smtp.client-ip=52.101.52.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z9IkLRRnPRNDuu1sS0YOsFJImxzizbO/6PmUbMsHM1/RVozUtHkhzeX30lwsvixcINlI/7ODgW1uw1EGiKmqpR7pbNzmcyGghxJM7U2Sq8MohXznb/SCrVjjCSg/8WC7v15lrmYZ4F/ClDRdyvwHBOrBrJvqYI6Tc/dJdeoFiDaR+ENkpEo/eUN/8Fjhw6IrQAD+KjuLnquFUR0j3gSVQpSL1ixNxZbUdRWuTbOsXkvl1KCuTee9gHIBkiio4+7iIcagcTOHSD/clbNweE8AxHNjeXs5/x51CBAGMy/H4Vm6o0iTxUsDk361Bfrtc6sxGgU8f9ZFDdrVwoFz/FiMFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Uqz5cwx3zq94R9F7+FMtN0m3NzXJvwJ70gy37qvJ6Pc=;
 b=I0n4mh/bNt9eDnQOxJCdKmw7qqnXZVrhQfWYZumRD+zyNSfVINmNRfOYaWqt1/nYQOBCMhnGBPcwD3HW6kW7sw4J3r3DHO0XgxuNeDGzvUfBSi39AC439idXZ6nVDKMFTpwKE282gsGqhF7rh0EDcS4LcK3DLrRVZ7Q/uG94Hcjv2OF4G11hRGkR3WP3vnZTY4oGdMgFUSxDsmW+N8U1R5u+9RTpp+98/ozgiNxrAce22QGIz+NdRpOwjboBQ3+KDjSv0Lc2hVUPDsH72q9IpgTD84ZAqax7LUpKgPbxKu0SmfgxszHQAGOHTwgE8+VRn88Bs3V+1utTy3rUwX4oBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Uqz5cwx3zq94R9F7+FMtN0m3NzXJvwJ70gy37qvJ6Pc=;
 b=r9n2R7gOmImEEH8HCG8HgCEQr7Y4k3PdZJfY4i24syoHdmbGg7qvYpOShM9c9xoySi4xrCqRp/STgZNdVl5NBMRQ12WFtaBNvNgoCtfLYvcphEAxz21g1KEUWWA7b2z79ewuEN2S61c5Z5Wy943cJLXYmCxR0xgB1FD4BMt65Jw=
Received: from SN7P222CA0022.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:124::7)
 by SA1PR12MB9514.namprd12.prod.outlook.com (2603:10b6:806:458::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.15; Fri, 1 May
 2026 03:16:25 +0000
Received: from SN1PEPF000397AE.namprd05.prod.outlook.com
 (2603:10b6:806:124:cafe::a4) by SN7P222CA0022.outlook.office365.com
 (2603:10b6:806:124::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.30 via Frontend Transport; Fri,
 1 May 2026 03:16:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF000397AE.mail.protection.outlook.com (10.167.248.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.9 via Frontend Transport; Fri, 1 May 2026 03:16:25 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 30 Apr
 2026 22:16:23 -0500
From: Eric Joyner <eric.joyner@amd.com>
To: <netdev@vger.kernel.org>
CC: Brett Creeley <brett.creeley@amd.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Eric Joyner <eric.joyner@amd.com>
Subject: [PATCH net-next 2/5] ionic: Report "link_down_events_phy" in ethtool statistics
Date: Thu, 30 Apr 2026 20:15:52 -0700
Message-ID: <20260501031555.43259-3-eric.joyner@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20260501031555.43259-1-eric.joyner@amd.com>
References: <20260501031555.43259-1-eric.joyner@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397AE:EE_|SA1PR12MB9514:EE_
X-MS-Office365-Filtering-Correlation-Id: ac98363c-635d-4649-9c31-08dea7300718
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700016|82310400026|1800799024|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	BMFI/AsFuQrjXt+m79uPp0tcFnx0piJi3XzQYvfd61+3w1XcRmyDiozOrnIAzkEbFdNtE41bjZzc9asdyTsid9ob7k0zojdsIsRMSVdsBom0dmo/0msEmN85MVT7jMnoR5IjH5CSjL4awvDgfNBqlgY/DpOhgAdoTV8U+678gV9TI25wlBIcT1BUofGSCPnJHNy3auQxrloe08VKfVgQFRFV2k/gwLR7/9neI0IjiZvMMPJt5V6tMFp33V0ZdtIgQVxMDgrHTtOK4xGFsUt9prkB4fcg0cbRBVzSss93bd7RfV2amhm9duonJ8/AJrkycP52fGvWYWkAxbXh/KJcNBwRmMBQFPJeo7TAo3RkK2pvpyWcBOxXLLuRy+/LMMSTnLtU3sfMmzq2HpBDuuZqsIokQb0WsjzKloWCPUQqLNcbnUuw8dXaZG8CcMSXaS3CxyriypZpq8SxOPIvNG81EJWsIKM12IcWH6xg6+R8l7BbPBMJSwu3N8yyISUDDaXo6tJJjd5tcy55xSwpGCVPQsgFYDj5WcKB9n8jhva5qqfpvmg7fqsNtPd2VoK5x7EyBf+FsAp0GJC75NM9eTyrc0UAAt2wwJWwF9OA6xmkV5kClijJAcKjWsVzEB0T/I2Eqvop9OVqV+AJdCeiOLrWWMl8xFqK76i2r+ono9teP1mW66sSB8UQ8rfXS7MxnJi0Qz8JEjx3LHuZ4ebRp2WijI/71AsoMy/w36Q4gkb7SDI=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700016)(82310400026)(1800799024)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	YLk4zonnakIv0dA6IyMacRwfS38IjEolnuAGb54xqSnQAEeFt98XJZadl6qrbmklxn8I+T1O2wfIgNy2awcsYnzDS+tjgwm5M6mpaYDcp8W4jaGWizbX5ybgZEHmCceVsakOk++qmvqH3sgq6V0D4oHPZqmJAjgHbDQp94evH0HTrR5pjNC0+5fAXe4Uy0ktyY7OGmfPQc99xiEcCphHf0FEKfbfnRbKALq6hKDqSKMp6aw3KkIjDb5X38AG7o2+nSXvoXwqYzU5QWPOaRoPDkTY/nzPZU1R1PjIWNmmnEszEZlKj0aNenokjazXJiwbNq+TAaBGwdwEfMtPgegeUuZ/BsxG/n4+CR8+OzQ8wLY2pW4mQkRgVbu6Fbo8c++Cn/m9Vs1f1XB9oEfMO9yTKyJBoe8i9L1M3aA/sAiVh/VTWK+TzytQFyxE61vqwViw
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2026 03:16:25.1875
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ac98363c-635d-4649-9c31-08dea7300718
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397AE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9514
X-Rspamd-Queue-Id: 8F9BC4A9E5F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-283080-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:email,amd.com:dkim,amd.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[eric.joyner@amd.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[amd.com:+];
	NEURAL_HAM(-0.00)[-0.992];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]

The number of times that link has gone down at the port level is tracked
by the firmware and sent to the driver via regular DMA writes to an
instance of struct ionic_port_status in the driver's memory.

This statistic was never reported, but it is useful for diagnostics, so
add it to the "ethtool -S` stats output, grouped with the other
port-level stats that are contained in struct ionic_port_stats.

Assisted-by: Claude:claude-4.6-sonnet
Signed-off-by: Eric Joyner <eric.joyner@amd.com>
---
 drivers/net/ethernet/pensando/ionic/ionic_stats.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/pensando/ionic/ionic_stats.c b/drivers/net/ethernet/pensando/ionic/ionic_stats.c
index 0107599a9dd4..8f39f687a39f 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_stats.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_stats.c
@@ -167,6 +167,7 @@ static const struct ionic_stat_desc ionic_rx_stats_desc[] = {
 #define IONIC_NUM_PORT_STATS ARRAY_SIZE(ionic_port_stats_desc)
 #define IONIC_NUM_TX_STATS ARRAY_SIZE(ionic_tx_stats_desc)
 #define IONIC_NUM_RX_STATS ARRAY_SIZE(ionic_rx_stats_desc)
+#define IONIC_NUM_EXTRA_PORT_STATS	1
 
 #define MAX_Q(lif)   ((lif)->netdev->real_num_tx_queues)
 
@@ -243,7 +244,7 @@ static u64 ionic_sw_stats_get_count(struct ionic_lif *lif)
 		rx_queues += 1;
 
 	total += IONIC_NUM_LIF_STATS;
-	total += IONIC_NUM_PORT_STATS;
+	total += IONIC_NUM_PORT_STATS + IONIC_NUM_EXTRA_PORT_STATS;
 
 	total += tx_queues * IONIC_NUM_TX_STATS;
 	total += rx_queues * IONIC_NUM_RX_STATS;
@@ -280,6 +281,7 @@ static void ionic_sw_stats_get_strings(struct ionic_lif *lif, u8 **buf)
 
 	for (i = 0; i < IONIC_NUM_PORT_STATS; i++)
 		ethtool_puts(buf, ionic_port_stats_desc[i].name);
+	ethtool_puts(buf, "link_down_events_phy");
 
 	for (q_num = 0; q_num < MAX_Q(lif); q_num++)
 		ionic_sw_stats_get_tx_strings(lif, buf, q_num);
@@ -341,6 +343,8 @@ static void ionic_sw_stats_get_values(struct ionic_lif *lif, u64 **buf)
 					     &ionic_port_stats_desc[i]);
 		(*buf)++;
 	}
+	**buf = le16_to_cpu(lif->ionic->idev.port_info->status.link_down_count);
+	(*buf)++;
 
 	for (q_num = 0; q_num < MAX_Q(lif); q_num++)
 		ionic_sw_stats_get_txq_values(lif, buf, q_num);
-- 
2.17.1


