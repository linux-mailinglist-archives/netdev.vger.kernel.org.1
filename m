Return-Path: <netdev+bounces-297474-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id aOTMBG0DKWpeOwMAu9opvQ
	(envelope-from <netdev+bounces-297474-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 08:25:49 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FCDA66637F
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 08:25:48 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=amd.com header.s=selector1 header.b=f2s4spfU;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297474-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-297474-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=amd.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0D2FC31AC30D
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 06:19:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26A6D372EFA;
	Wed, 10 Jun 2026 06:19:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010052.outbound.protection.outlook.com [40.93.198.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8F8937269C
	for <netdev@vger.kernel.org>; Wed, 10 Jun 2026 06:18:59 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781072341; cv=fail; b=uqo3+vwOYItDiPjx0ZMeKAJN3V5LvtfUP1VFbD9D6qpbKURro1eeIq3FyxJCrlemj8eOPph3Fi/+/V3+p/R8tjTNmt9lizQQNaHmnMD5+jKGFpw1NdleX4XfnZQ0FszagA8TTlcOi7ou7apJGZfPJ5bLynBHH8D2fMoQgfeqWZw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781072341; c=relaxed/simple;
	bh=QBquUKAC2wVTWxWsZpopImm3bARkBv7WW49lj8/xYzg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f6ZerhJ4gH5B8/p1mYDyncoDbYLiJ/HbfESAWnZa79MwZi7TDXyltmDjJKUJxJTI/pDRZj21C85Vb4DkaDkKt2k5Zr6llQ8V1CMiLUdElkA0nKPRvvco8+05FMpInvrNzIsYuS2ta+3LF+COmN2EUytfG2UiBx4W5kWd2UWDFME=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=f2s4spfU; arc=fail smtp.client-ip=40.93.198.52
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oyTFbYD9KMDmtetIsop5VRQLRtw3tyDEHYzl+3CN7HxmwDp3d4taItL46UAPGK4h1iegNo0C6tHQRVIKtXOaD9uKRXL18J39fvO27HhIjs8dTtCcHiOKHIaLMijQRMhxwgKOZwT7sybuv2IoT4/x7gTuM1fWV1VJCIb1C/WFQDWmH0GZNzMD1c80tvQNGew5kyzNigWopERNesxmdILcKhE7nbxnPxCBM6OUURpznMvRuff38D/Mb4KxeQa2R5ovPn4aL4pDe3y00/AEVoPD17caRgMjANBxxEOQ4rUPDbkFvE/Q0u3Nzs5Ivxa8MDCMHVvksxC37I5ynl/vstpplg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pVG4QlH/I5Yd10NSuiE4dvtFGaI/Et8f6TjPjL0w+fQ=;
 b=ZCc4tc4rvkL5fBjqBSi+qTjQjjbfJd1H6A4bSoaOpFeqsRlckptn6wLFBxlFQWI/iE8yYdSdqQSrN5I6lLdfuv/fyom+n2Uur10rFSb2vpxKDWTgcldz+5VlUOc88bUhVQ1nbvBR2ivZpTF1DXq2pPykbPk/99+InvX8KXxkzwIuR706CZYue0LOLmeJVw2CB0dPdrCZQNeMuRCmWMHgQxb4JTHVz0XpIFbcujdfHrSgTYznO13uoqcXL0RCR6ZUwEblpY0tQwtkYdANVf+ww4Sdy8nuf+Oo4VUwW1amhEJ1XkzV+sk6/A/OPZf7+wlGj7VCkm0n/+e3LplduqMFjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pVG4QlH/I5Yd10NSuiE4dvtFGaI/Et8f6TjPjL0w+fQ=;
 b=f2s4spfUz2crJgQAv42cxMwa1SgfQwfqkUUzQCmPTaPopyayLVQx0CIvf3UVX7BUD4AxwVhP7qHxXn4p3ZywpR3b2xTueHzkZKt0I7a5UEp6lALADYiHq2ElF32DgLopuolYuT9DZlGcsOjKtMjoqAasDBq3kJ/zWnCegyqci5U=
Received: from MN2PR14CA0021.namprd14.prod.outlook.com (2603:10b6:208:23e::26)
 by BN7PPFB3F5C406F.namprd12.prod.outlook.com (2603:10b6:40f:fc02::6e0) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.13; Wed, 10 Jun
 2026 06:18:56 +0000
Received: from MN1PEPF0000ECD7.namprd02.prod.outlook.com
 (2603:10b6:208:23e:cafe::5) by MN2PR14CA0021.outlook.office365.com
 (2603:10b6:208:23e::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.13 via Frontend Transport; Wed, 10
 Jun 2026 06:18:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MN1PEPF0000ECD7.mail.protection.outlook.com (10.167.242.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Wed, 10 Jun 2026 06:18:55 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 10 Jun
 2026 01:18:53 -0500
From: Eric Joyner <eric.joyner@amd.com>
To: <netdev@vger.kernel.org>
CC: Brett Creeley <brett.creeley@amd.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Jacob Keller <jacob.e.keller@intel.com>, Eric Joyner
	<eric.joyner@amd.com>
Subject: [PATCH net-next v4 5/5] ionic: Add .get_fec_stats ethtool handler
Date: Tue, 9 Jun 2026 23:18:30 -0700
Message-ID: <20260610061830.51037-6-eric.joyner@amd.com>
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD7:EE_|BN7PPFB3F5C406F:EE_
X-MS-Office365-Filtering-Correlation-Id: 933dbcf3-5bac-46a2-1430-08dec6b826c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|82310400026|36860700016|376014|1800799024|56012099006|3023799007|11063799006|22082099003|6133799003|18002099003;
X-Microsoft-Antispam-Message-Info:
	1Nrs8cB4R5Lags4apxZDNyFIu0WRjwRWa1hnJ3Zg7/y+qce7Pz8KX/BxnRAeMUNQL1kFGhCmpiBgm5di8KPwEJez+JfhbgNizgLsVDERlx1tepAx7yPh4QLoN1SHyyeTSVbFl+qHvPtk1UnihcyR8Iv0p919dQHSysCStoC83dy546eMZgTYEuifullPmNh16Brg0/0Kzc7NmxT/lH7h+qk0whKQPi9snKRxvUbt0u1ZAgighvymPwlcfhR/bQcRgcw1sh7dkW3l1vhlY5S6GVGa3+mbk7OP0GzIJ7SaZZYYGh+FzokOm9on2UNEGgj6HYWunVYxUdj3OpMHqvoPHIHkRr+ORgkY1VhjnEsrKTD5m5FTbn7fQdtA2JAAaeeFjybt1sboN9++iHS6/R1jOVLTvDer8+51En1qScKtIBXLLPHyaQvaIYwjQzEVGlK3HiZwQAZ+LeNtcI79+aGwsIlHT4Nq5VhUK84u//rWHKjqlNJdDxeYQm7uhczyZiYGhohwvDJmIk5fTKIKNnK4pHi/0e23owae5pGluzO5FivuEmPXFH1bG37vfHeUAePiGkes6o5qNpLMHWbGUsB6bhOnWsJr9X+9Lf3ku/5q0NYgBQke9P/W7tVmnndfqKTJridrL0GXtUfZniWD/btR1T1M6xYi+N/PunD7BqeRFKzvz9U33VkTdcz6kU8kPe1O4JFCBuivU1iWx/LWfXrEtrSez9rE3khMKrOfdPmknmI=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(82310400026)(36860700016)(376014)(1800799024)(56012099006)(3023799007)(11063799006)(22082099003)(6133799003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	2eL6vDAdbuwHFJX/I2Q+XqvkfL+WZznQT+RgCEqt5zAcdbFJkY/K79lV3foVq0TjIjkx2i5J+nrw8HlUdxuINHjy35ixp/xYPWO2QCL5BKKKtxbMd8kaJARJGJN0yy0GjMWNxq4PO/U3fLXvsMXh+UOBN1uFbRk+B0IjGgBhyQcSn/mW9OGlLG62M/H8/h/LTKU61yJXRrYPMkuQCwHDF8661O5Z0YpbfWnbCDe4RElvqocieCr6MFyDMDpWA9/lW48M4MvEWm4IUqTcI8eE0MNx8aY9uM/3sCYVWz8xRGZn+3bUT2v/inokD8vsZjB+Tn0ASu8LYRDIxBvx3jvtzrSsgdtGvvvqlMTfSbUStICwniZPGKCOhxgsTh6+ARF49GVIX2zVFr5loFELa8aY9b50VYXok5Z8mG8nsqMsGQtB5Fz/E2UyluWWwRhmPbYN
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2026 06:18:55.9664
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 933dbcf3-5bac-46a2-1430-08dec6b826c8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000ECD7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPFB3F5C406F
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[eric.joyner@amd.com,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-297474-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:brett.creeley@amd.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:jacob.e.keller@intel.com,m:eric.joyner@amd.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[eric.joyner@amd.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[amd.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,amd.com:dkim,amd.com:email,amd.com:mid,amd.com:from_mime];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7FCDA66637F

Reports FEC statistics totals and an 802.3ck FEC histogram. Per-lane
counts currently aren't supported.

The reporting of these statistics is gated by DEV_CAP_EXTRA_STATS and
checks for IONIC_STAT_INVALID, since only the newest devices support
reporting all of these stats. Older devices can only report some of the
statistics or not at all, and so the output will properly exclude those
unsupported statistics.

Assisted-by: Claude:claude-4.6-sonnet
Signed-off-by: Eric Joyner <eric.joyner@amd.com>
---
 .../ethernet/pensando/ionic/ionic_ethtool.c   | 72 +++++++++++++++++++
 1 file changed, 72 insertions(+)

diff --git a/drivers/net/ethernet/pensando/ionic/ionic_ethtool.c b/drivers/net/ethernet/pensando/ionic/ionic_ethtool.c
index 6069fa460913..41bb27669907 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_ethtool.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_ethtool.c
@@ -425,6 +425,77 @@ static int ionic_get_fecparam(struct net_device *netdev,
 	return 0;
 }
 
+static const struct ethtool_fec_hist_range ionic_fec_ranges[] = {
+	{ 0, 0},
+	{ 1, 1},
+	{ 2, 2},
+	{ 3, 3},
+	{ 4, 4},
+	{ 5, 5},
+	{ 6, 6},
+	{ 7, 7},
+	{ 8, 8},
+	{ 9, 9},
+	{ 10, 10},
+	{ 11, 11},
+	{ 12, 12},
+	{ 13, 13},
+	{ 14, 14},
+	{ 15, 15},
+	{ 0, 0},
+};
+
+#define IONIC_FEC_STAT(dst, src)			\
+	do {						\
+		if ((src) != IONIC_STAT_INVALID)	\
+			(dst) = le64_to_cpu((src));	\
+	} while (0)
+
+static void
+ionic_fill_fec_hist(const struct ionic_port_extra_stats *port_extra_stats,
+		    struct ethtool_fec_hist *hist)
+{
+	__le64 fec_cw_err_bin;
+	int i;
+
+	if (port_extra_stats->fec_codeword_error_bin[0] == IONIC_STAT_INVALID)
+		return;
+
+	hist->ranges = ionic_fec_ranges;
+	/* All bins in ranges must be set */
+	for (i = 0; i < ARRAY_SIZE(ionic_fec_ranges) - 1; i++) {
+		fec_cw_err_bin = port_extra_stats->fec_codeword_error_bin[i];
+
+		if (fec_cw_err_bin != IONIC_STAT_INVALID)
+			hist->values[i].sum = le64_to_cpu(fec_cw_err_bin);
+		else
+			hist->values[i].sum = 0;
+	}
+}
+
+static void ionic_get_fec_stats(struct net_device *netdev,
+				struct ethtool_fec_stats *fec_stats,
+				struct ethtool_fec_hist *hist)
+{
+	struct ionic_port_extra_stats *port_extra_stats;
+	struct ionic_lif *lif = netdev_priv(netdev);
+
+	if (!(lif->ionic->ident.dev.capabilities &
+	      cpu_to_le64(IONIC_DEV_CAP_EXTRA_STATS)))
+		return;
+
+	port_extra_stats = &lif->ionic->idev.port_info->extra_stats;
+
+	IONIC_FEC_STAT(fec_stats->corrected_blocks.total,
+		       port_extra_stats->rsfec_correctable_blocks);
+	IONIC_FEC_STAT(fec_stats->uncorrectable_blocks.total,
+		       port_extra_stats->rsfec_uncorrectable_blocks);
+	IONIC_FEC_STAT(fec_stats->corrected_bits.total,
+		       port_extra_stats->fec_corrected_bits_total);
+
+	ionic_fill_fec_hist(port_extra_stats, hist);
+}
+
 static int ionic_set_fecparam(struct net_device *netdev,
 			      struct ethtool_fecparam *fec)
 {
@@ -1161,6 +1232,7 @@ static const struct ethtool_ops ionic_ethtool_ops = {
 	.get_module_eeprom_by_page	= ionic_get_module_eeprom_by_page,
 	.get_pauseparam		= ionic_get_pauseparam,
 	.set_pauseparam		= ionic_set_pauseparam,
+	.get_fec_stats		= ionic_get_fec_stats,
 	.get_fecparam		= ionic_get_fecparam,
 	.set_fecparam		= ionic_set_fecparam,
 	.get_ts_info		= ionic_get_ts_info,
-- 
2.17.1


