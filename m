Return-Path: <netdev+bounces-283082-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wBlAE0Yb9GnZ+QEAu9opvQ
	(envelope-from <netdev+bounces-283082-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 01 May 2026 05:17:26 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A43A04A9E6D
	for <lists+netdev@lfdr.de>; Fri, 01 May 2026 05:17:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3F8B2302A2ED
	for <lists+netdev@lfdr.de>; Fri,  1 May 2026 03:16:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08D8B2FC876;
	Fri,  1 May 2026 03:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="j93T+eIR"
X-Original-To: netdev@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013029.outbound.protection.outlook.com [40.93.201.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8842B304BA3
	for <netdev@vger.kernel.org>; Fri,  1 May 2026 03:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777605393; cv=fail; b=XcrOprPnQuHSaO64KDAmKEtmLAB6GYUkGhas7mQHg3CckbmJ1EojlZqW3QYGk0CYbSQo/FzizJHDU4Nz29kNUfSMnraQFg4MtgCyc28DJH0ruAVBMGaon21ysF9TAM0PcCOjaBwez1d75vgiTskJjywg0ucXwXC5H9183ue2x0A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777605393; c=relaxed/simple;
	bh=qq1WyJIuHfdsJlLK28AODSikGRE128Kw4jZzL3i9OJc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UqHhGKbCWXreXIHDCBLYPl9pYCP6svAAFdbmVnWt2PxhTUmjAW2Pu0vM5hOQer860RZ12yny4hF4TlWfDJPz3p3tO0ybtIA/A8ima/34yLAk61tY0PCbZO8vcwp1pV7Y7xEnAnIHR7FMOmvj7GJwHVpwdtuJJJdOXhhSnW8s1FU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=j93T+eIR; arc=fail smtp.client-ip=40.93.201.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ehUCjdKEKQ6q4mSjVo8WI5DCEB/sN3SJUugSXZfRoewJmCdUnp2cGTL+IcsrFqnW6ogGUDCBdSGEboqRfxHWFM3vG5WEm5FHmc8/VHxT8W6SuAuEy+isiKvaT5dhTaplPVg0sysVW8Gcnx9h+RGWkD5fqnrskMwJeABBehQJ1sQe6LHGq1wX8GMLirVH3uuv0e4Sd6vzIdQGgsq8GCp5mwDhP0pI0Od4KTaIv84SM25h6AFc91ZCXJ7k9bqkQ4TGLWXRtfXmU3M0QO1H06h90BmgApWkI4ki0H/gRzwkJdCJzackvSJWeKp6i8CT8H5KeUs7VSQzOadmdc2q3Mc9ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=It04TawMMKbjAl6ew6XBl5rwJIuVqnMJRXTAx8mchEY=;
 b=rDC3EN80t/TfNpDJddPKjapaOKXPfMEe71EjUfIvPWO26B4kgxhuz5ykbjIGLkuKCQMmG0GDaaMijsM7SDSq2Lx1WPLLDdPGp0GgDqEhxMp69fpLR/1nD6WopHYazBMdnvuCq52bt2JggpzqlptyoYbBE3HffEJNqQR3JcWjNNQEcT1mCK3FrM7uCZPlt+ZpAAmCbEo6qLI7/lBUzPRNF7NAwmjmDFs9NwREj+vjjoBAbg/WmBz4XeJaCthNYZkneCdueVBHHVYa1IOFjZQrjPX7QJMRgqUKoJBdQCXghhCOdSHlg3zRQS0U7wNGyYTb0x7waQouX+nvVKflDrPzDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=It04TawMMKbjAl6ew6XBl5rwJIuVqnMJRXTAx8mchEY=;
 b=j93T+eIRJuQq9E9+eKCgZ7NWgphiJQ+0ps2ENsLITVoTXXbAWhRCc4Gbc1DeCBQ0DXJZnIvfQezLFBfgY0typBEq82Faa7VKx/0cKxiJ9DOcYfAzJDkW7106icEd/VFz6bWXQWNB69ywMN78a+Dq1f3ds7AlhM8Ocmb/VcxSCIo=
Received: from SN7P220CA0016.NAMP220.PROD.OUTLOOK.COM (2603:10b6:806:123::21)
 by LV3PR12MB9236.namprd12.prod.outlook.com (2603:10b6:408:1a5::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.21; Fri, 1 May
 2026 03:16:27 +0000
Received: from SN1PEPF000397AF.namprd05.prod.outlook.com
 (2603:10b6:806:123:cafe::70) by SN7P220CA0016.outlook.office365.com
 (2603:10b6:806:123::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.30 via Frontend Transport; Fri,
 1 May 2026 03:16:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF000397AF.mail.protection.outlook.com (10.167.248.53) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.9 via Frontend Transport; Fri, 1 May 2026 03:16:26 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 30 Apr
 2026 22:16:25 -0500
From: Eric Joyner <eric.joyner@amd.com>
To: <netdev@vger.kernel.org>
CC: Brett Creeley <brett.creeley@amd.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Eric Joyner <eric.joyner@amd.com>
Subject: [PATCH net-next 4/5] ionic: Report rx_bits_phy stat to ethtool
Date: Thu, 30 Apr 2026 20:15:54 -0700
Message-ID: <20260501031555.43259-5-eric.joyner@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000397AF:EE_|LV3PR12MB9236:EE_
X-MS-Office365-Filtering-Correlation-Id: e39a7b59-c5f0-48ae-7622-08dea730081f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|82310400026|36860700016|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	lCRKDYjZqqzdIFPLA3c7IKhrgN0p1sMn1mOjJuz00xtWs2Bl6kZTsWHOHrRWvjfnvDZeq6v3z8rAHLr2nVVWhLYKpgdzqrsi2J3Mnz6tDnLVV/eZH1FRzYccfGRmeNcHPLj4VbqGECc5JYyxM8hIqix3nqirWOi9cU4IVBsDf+s9EdPatqWrROR8NuYkhK6DYUs2pCjlwT8JjnfvmYlri3uxe+NnFxH5YDADdHX86fCSDdTyyZ2EsaYlJBH/UfYeqmErhDn+5mVq8uBp2+o9oBaYgtHNRZGf2jQn6PiAYoWxTPUh6/j+NI5kg/zwPJDXYOieofe6QE5PGbbFWAKd+zzzDCn8lOxEegHW217fggoyQjVuA+8qlGz+OEoJYhqcxzlxNf+tMT4y1yomLtgN3ezuc+PYe88XyBk+ijliRS/e2RLoRDtQsQ6D6K2+9IeKl8otnslamLUmkQT6LVj+SezMR48I3GXbnFDl0eY6kg6zbWYYlZ6Nmrcaau4BXcNquoyNzFpdMw2p03v3u6Xycczcj/JlT1ZOFbD7/jIvsHVs/M6EFZycy4+gd78Pbahp6VoltFjdGp7/8QS7MTz4pRvoyGCx8cVMRTvBz/o4ZuK1m7eXpLW3AbGiaOUxBVvlzSMm8LLrjiz0a5hwzYzxHoNFhhMc0EppvnjHMHjq+o+ZkrXKXUgrEqK9Nhq/VguOHblpmkYd9fJUsb/rJG2+wy04FbOSBFTR8d1/cFBaOE0=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(36860700016)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	e6tVylXd+6yi0pxjsxDRxWyp7u9dH+k5NAE0LZCZ3XoCaofkZziwGpaDsvZcfI5UCz9rDmJ50vHq4hJsCVwcRoSOXgZe2GtjOF07CtRo+hgwfyN5D0al8bJhSPSazu/VyTDp5ee/3JY8jhR//NgvnqYGorgXgvY4YlLZcZ3czvcxcaKiMqHHPhIEek1/Yg8jOE6IDdQq+/hHCUHBWFju+sMDj6g9dd8uGhxczI4N6YSNx1qgSY6F0rhv+UzoIuqYpabmLRjKhCNA+9XFxsQuX62FjdCYo+3bJTnsvf7XUryVzJmjwMi6JrkeMvwFhNTYrgqqnAyKxg0uG9Yly6U7JxRFJvA1Vos1naZlIWJKb4G5o/V4KHXDaAR/A1bN7M5X0MmK0qjalXV2cktAto+i+YyIdj925TGDiqThb0UbzmfqLwU+wUgKlsIkSH/Wpa1p
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2026 03:16:26.9129
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e39a7b59-c5f0-48ae-7622-08dea730081f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397AF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9236
X-Rspamd-Queue-Id: A43A04A9E6D
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
	TAGGED_FROM(0.00)[bounces-283082-lists,netdev=lfdr.de];
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

This stat contains the number of total bits that the PHY has received;
it's useful for BER calculations. Add it to the ethtool stats output.

Signed-off-by: Eric Joyner <eric.joyner@amd.com>
---
 .../net/ethernet/pensando/ionic/ionic_stats.c  | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/pensando/ionic/ionic_stats.c b/drivers/net/ethernet/pensando/ionic/ionic_stats.c
index 8f39f687a39f..f64f52083301 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_stats.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_stats.c
@@ -167,7 +167,7 @@ static const struct ionic_stat_desc ionic_rx_stats_desc[] = {
 #define IONIC_NUM_PORT_STATS ARRAY_SIZE(ionic_port_stats_desc)
 #define IONIC_NUM_TX_STATS ARRAY_SIZE(ionic_tx_stats_desc)
 #define IONIC_NUM_RX_STATS ARRAY_SIZE(ionic_rx_stats_desc)
-#define IONIC_NUM_EXTRA_PORT_STATS	1
+#define IONIC_NUM_EXTRA_PORT_STATS	2
 
 #define MAX_Q(lif)   ((lif)->netdev->real_num_tx_queues)
 
@@ -281,7 +281,9 @@ static void ionic_sw_stats_get_strings(struct ionic_lif *lif, u8 **buf)
 
 	for (i = 0; i < IONIC_NUM_PORT_STATS; i++)
 		ethtool_puts(buf, ionic_port_stats_desc[i].name);
+	/* extra port stats */
 	ethtool_puts(buf, "link_down_events_phy");
+	ethtool_puts(buf, "rx_bits_phy");
 
 	for (q_num = 0; q_num < MAX_Q(lif); q_num++)
 		ionic_sw_stats_get_tx_strings(lif, buf, q_num);
@@ -324,6 +326,17 @@ static void ionic_sw_stats_get_rxq_values(struct ionic_lif *lif, u64 **buf,
 	}
 }
 
+static void ionic_extra_port_stats_get_values(struct ionic_lif *lif, u64 **buf)
+{
+	struct ionic_port_info *port_info = lif->ionic->idev.port_info;
+
+	/* The # of stats added here == IONIC_NUM_EXTRA_PORT_STATS */
+	**buf = le16_to_cpu(port_info->status.link_down_count);
+	(*buf)++;
+	**buf = le64_to_cpu(port_info->extra_stats.rx_bits_phy);
+	(*buf)++;
+}
+
 static void ionic_sw_stats_get_values(struct ionic_lif *lif, u64 **buf)
 {
 	struct ionic_port_stats *port_stats;
@@ -343,8 +356,7 @@ static void ionic_sw_stats_get_values(struct ionic_lif *lif, u64 **buf)
 					     &ionic_port_stats_desc[i]);
 		(*buf)++;
 	}
-	**buf = le16_to_cpu(lif->ionic->idev.port_info->status.link_down_count);
-	(*buf)++;
+	ionic_extra_port_stats_get_values(lif, buf);
 
 	for (q_num = 0; q_num < MAX_Q(lif); q_num++)
 		ionic_sw_stats_get_txq_values(lif, buf, q_num);
-- 
2.17.1


