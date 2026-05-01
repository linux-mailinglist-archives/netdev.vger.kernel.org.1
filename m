Return-Path: <netdev+bounces-283079-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uECZJywb9GnZ+QEAu9opvQ
	(envelope-from <netdev+bounces-283079-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 01 May 2026 05:17:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 181D34A9E58
	for <lists+netdev@lfdr.de>; Fri, 01 May 2026 05:17:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4DD51302297E
	for <lists+netdev@lfdr.de>; Fri,  1 May 2026 03:16:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3B592FFF8F;
	Fri,  1 May 2026 03:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="OUH2IpFE"
X-Original-To: netdev@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012005.outbound.protection.outlook.com [40.93.195.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80492199949
	for <netdev@vger.kernel.org>; Fri,  1 May 2026 03:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777605391; cv=fail; b=TQtuHZwnxCN9wBaXs1WgWE0LNgYX6gNZNfnZJjUS7z4zDtUNa8ZCx8yiJFqApyKIIiO1M/wybb2th/f8XRpFpnuj+uD/GFYChACB2plRW3hZLZFsdKkNVzjxcbBkKzXnIvl11RTftUeIiMQC8Vdam8ToT5PmRYdFdCmZ3R+Vfl4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777605391; c=relaxed/simple;
	bh=w0yCSrbRFnPYjydaiYzfbq44rEAHM15kxBUqziXV6wU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bGdGNwR0Mom5Z0JqQjGmT8qnaM38KJ8UrGT04vbIU/ArmAz0IqL5BnU01XkbYOLQd3eHcrYAPXMLb3x3p7z8oeRH39wU9EXkmNq/1dyLU2y/+JvUgnS7oTS07G7H2wjQJoSFkvGeOzP84MvIMsZEDppr9rnuRmnohFijTWtsVLw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=OUH2IpFE; arc=fail smtp.client-ip=40.93.195.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FTlilH5gxbqythorrUTvWyywibWWHzFme4FO90Po6FABCpr5QzM440cLlErC7vJ09nN7MQUesCKdBhzw4Ir3Ek2+U3lIm+xncE5uS6vToiddFL++iKLrY10zL0XbSyiczV8b6Izz5QXC9hXH4Hk8HZWzGZgJrZREvsB6WufM9INDUqirZoS6R9Z+mEmc6+Skg0Saoww5kOKv5qh8nB8mjksRmJE0AufrS2ZUt948+xDP5dQTYRhijGxtseK2Jl4YK802OGkd8qvcXcH9kpwMTMl1f99kqK1BppNAlBCL23xilyomMGbEPIDLChGSlLJixo2XLiWMOMsmZDyaR0PXGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0qTRoPQFrzQx469rNxcoCg8kxJ9qF9qQgtsJmrAXiAw=;
 b=cxnM5P8iHULUTlSQkQVyMwe7v2VOW5eLbkdfU3YwjICDwRHjFVqJYegVTzdps3CJeXTOEYw+sf/VAF8RGqFbE8mest3pwvF9cCqGYbE1L3UTzm61QvXnoCOAoYAc45gIMB+wRLkunwk3F4wSmbLgtwLnvTCgfFCZ5iH6VPqIy1a0+CUmgQOI1sC1l+YGlxu/qOaXn3BFdh+REcq/jITA9TmhyDvaV5g6NW0cMLCJ1Ea/tVIq5tUq+k8drq7vEsrS2vDnaGhowtLhPKONKalPY2ooKE2Pq5b5rX121vcOz8xPwdpowQPKcb49dAZTDeSlaKHSY2gmXy03dKThpbZcNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0qTRoPQFrzQx469rNxcoCg8kxJ9qF9qQgtsJmrAXiAw=;
 b=OUH2IpFE4BYWysKELAVEweuYRTEGXqeUSg5YBZ6NdT01CFHGVGic1eUwapNrsUFhiNBvgs1BgpMy+CmK74RNZSxljNGnh4nSMvk/QDybocN5cLvE5fDRm/PftmXbq8qW/xe1eKTRj+zta0dn7tzIHrCnLtY+wWnoKis4CrWTFXA=
Received: from SN7P222CA0015.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:124::29)
 by DM4PR12MB5723.namprd12.prod.outlook.com (2603:10b6:8:5e::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9870.22; Fri, 1 May 2026 03:16:25 +0000
Received: from SN1PEPF000397AE.namprd05.prod.outlook.com
 (2603:10b6:806:124:cafe::f9) by SN7P222CA0015.outlook.office365.com
 (2603:10b6:806:124::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9870.21 via Frontend Transport; Fri,
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
 2026 22:16:24 -0500
From: Eric Joyner <eric.joyner@amd.com>
To: <netdev@vger.kernel.org>
CC: Brett Creeley <brett.creeley@amd.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Eric Joyner <eric.joyner@amd.com>
Subject: [PATCH net-next 3/5] ionic: Update ionic_if.h with new extra port stats structure
Date: Thu, 30 Apr 2026 20:15:53 -0700
Message-ID: <20260501031555.43259-4-eric.joyner@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000397AE:EE_|DM4PR12MB5723:EE_
X-MS-Office365-Filtering-Correlation-Id: a1b90020-f232-4a2f-5a5d-08dea7300753
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700016|1800799024|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	yIp/k2C9e2cLWSEvS1LHevSCv6R/jEry6V8bqXwIm5M7n+5uYmNKOXKShB0xMvoMKIBYt+pfh69tG/pY897l7VuL8LJ9kafmUt8tfSX+hqUjflgWRQijCvWv3gLXlFgAy7cV+wPHRGtJ0c0OKF1HZpwUmJOZGLMkd3FrceEO/7oNG0kwvIRhXjrTWcWZ/mKookNs7shcFWtkdzD7CAmkNS7X3PkyARsWpANiKHcUSOwm4BGCnnK0wK1eZ9rHMGQxPnlNb2J60d8FFDcJqJ0i3h1VgEDVilN8xLa0sbWLECtZtQZnkT1/pSxkN4U/sFgTY8/isPux1JuVOEhgKBUEu9d2E84hSVv8E6YsVKrjjsTY8qVFwK5iHlqT+OSu62cz2wrsjzMkiRoYtThjk04QJAbJVEXqZMqNk71gK3WGMyptZUrx4nMLYOon5MISc6QJ/oGRlEMF8bqprMhh2PAeWi2a3Tbh1Z8sSksRHnAp3dzZ9/84NZ4ZBIJ7sHuXBKKdFnuvN5L8nnTPONr8ojEI2QVWEbV8tt8bg3Cspvq15SRUlk3GwcFM5tMmtReEzVhxbq6VInsebC5pQ1hp0WZ5kHLeNr7xzS3FYziqDidLbYGCXu5o9j2yzUumPEQu/qL4HoQMlGTwUnrku/yWViztwv7LQkx7TW41LsYoUbVDNV4cO9b2n3hOqKYIAPod/QM7G/iwaglmAxyAvGBNcBiNHdxIaG+Maq6gz9jbuHfLFlU=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700016)(1800799024)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	RcnI2bpy/MpwnsulzAJ782q/3GU6MgOcCisaJVs/vLAb+fysW0PgrAR2G35JFMXuThlFweYOcDoXbiwUX4GmMB6+T4sXnRxBXtdUhqvtI2fVsad+dCreQNjLR+iDW5JaDzgDzzsPhSBu2R2X9bCT3GYA84MwQBm0V30nE3nN4RqVY5x19Zci78l2+aZf+1KR/6BeCUkq5kOICtaBx1xg7sdhshMVWH/HyJF1mB6BQdw/a6ilmL/KeDxKr5P+g7PSM3ZzUvyXoh6VQQ1SMPjCVwEupMlhLnmYGKiqY0bekwy4ey2BR6GStOSFbOj+nJTGjK9zD+L8CiQkaaDZovg9e/LYBgHKm1KYeQa2+zINepvIT5OeKRxqoO4rhNP4Oy2K1scOTmG1Db42H/cSaBTEHqVn0cO9J1Tc96oQjH9VezFuBn0ZNcXv4gBuaiWhxl1e
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2026 03:16:25.5757
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a1b90020-f232-4a2f-5a5d-08dea7300753
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397AE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5723
X-Rspamd-Queue-Id: 181D34A9E58
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
	TAGGED_FROM(0.00)[bounces-283079-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:email,amd.com:dkim,amd.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[eric.joyner@amd.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[amd.com:+];
	NEURAL_HAM(-0.00)[-0.989];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]

A new structure to report additional statistics from the firmware has
been added to struct ionic_port_info. It currently only contains FEC
related statistics, but new statistics collected by the firmware for
the port would go in it.

Signed-off-by: Eric Joyner <eric.joyner@amd.com>
---
 drivers/net/ethernet/pensando/ionic/ionic_if.h | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/pensando/ionic/ionic_if.h b/drivers/net/ethernet/pensando/ionic/ionic_if.h
index 23d6e2b4791e..52bcc9b11f6c 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_if.h
+++ b/drivers/net/ethernet/pensando/ionic/ionic_if.h
@@ -2855,6 +2855,14 @@ struct ionic_mgmt_port_stats {
 	__le64 frames_tx_pause;
 };
 
+struct ionic_port_extra_stats {
+	__le64 rsfec_correctable_blocks;
+	__le64 rsfec_uncorrectable_blocks;
+	__le64 fec_corrected_bits_total;
+	__le64 rx_bits_phy;
+	__le64 fec_codeword_error_bin[16];
+};
+
 enum ionic_pb_buffer_drop_stats {
 	IONIC_BUFFER_INTRINSIC_DROP = 0,
 	IONIC_BUFFER_DISCARDED,
@@ -2951,6 +2959,7 @@ union ionic_port_identity {
  * @sprom_page17:    Extended Transceiver sprom, page 17
  * @rsvd:            reserved byte(s)
  * @pb_stats:        uplink pb drop stats
+ * @extra_stats:     Extra port statistics data
  */
 struct ionic_port_info {
 	union ionic_port_config config;
@@ -2968,9 +2977,7 @@ struct ionic_port_info {
 		};
 	};
 	u8     rsvd[376];
-
-	/* pb_stats must start at 2k offset */
-	struct ionic_port_pb_stats  pb_stats;
+	struct ionic_port_extra_stats extra_stats;
 };
 
 /*
-- 
2.17.1


