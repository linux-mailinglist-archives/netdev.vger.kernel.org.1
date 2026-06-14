Return-Path: <netdev+bounces-299276-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id PcXRISoVL2oD7wQAu9opvQ
	(envelope-from <netdev+bounces-299276-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 14 Jun 2026 22:55:06 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DFCE36823A3
	for <lists+netdev@lfdr.de>; Sun, 14 Jun 2026 22:55:05 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=amd.com header.s=selector1 header.b=FRGvYKtu;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299276-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-299276-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=amd.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A0E80301983C
	for <lists+netdev@lfdr.de>; Sun, 14 Jun 2026 20:53:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD95C326941;
	Sun, 14 Jun 2026 20:53:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013054.outbound.protection.outlook.com [40.93.201.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5728429C325
	for <netdev@vger.kernel.org>; Sun, 14 Jun 2026 20:53:36 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781470417; cv=fail; b=YG5uBUF8EmD6DZUWPIu32p1hb1ApeGYlrRtsH4qPsQHGSKC1g9jmYMlmRLpibV6f+vJ4PGq7fGQqSjFiq6YxWdyizj+2DJy22SCVaG6B5VOUVRxCEWvb8LsGdP8Dy6pjFmtEOx+4lFyWo6fMiLaTwD9ETD3urHrjDadd6xKott0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781470417; c=relaxed/simple;
	bh=KwZxxeCwb93lE4KAj4eB1vPyakBxs/cV1ihsN24BYqM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SpZbQGV43kLRq0H1l5wYJizQyhkb4bf/2brk06iYW3jeNPnPj34i78BGpy1/3bVEVRnLgeJ8ueFt3LODy557RScmiLDzizExwypRquRKSTHPTPY7jt+DI+P0kbPB8J2VOg3eoHqcDYr5ockXY262RRUKTjTuVFYJBeCZrowd0G4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=FRGvYKtu; arc=fail smtp.client-ip=40.93.201.54
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UI6O/rW0eAM91rcZYAqcasfzA6oIZrLeFqlB7WJLoyGWIlAq+Dpam04FKCI8PXfQ2jozVV9kq9vsQDNhobg806e+oRcNbwtowJ7ydHL/6HqrgXcV0Fd1znActsV7o9hQ8mpOLsxNV+V8oe+ER2BphPijuCXxkwumsFXdL7JbKwyejbUAKe8bJ1UgssiH3MIl8v3cNw72N8FeclM0iWkBsOu8zr3lmrG2E4YuW4ZGDa5QmKqMpu71BZJDae0VKpyILqFv82Qlzk/749NVppRmS+oQWMOYBoBBMGww5G3uXKxSTZ/8tl8c9mp6RGWt/RF/PvlbqcCLN07Ss5CsfRJR7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+6749ngU3QRBe9U0G13x7AkfPDAEPY0HalINt+ES/NE=;
 b=Sec0awGaGRQGLQLTZZNoxOiBt3kXEcm1YClerrOLbKz7WHAcYgME/N4vcm8vgkls+67miYwGIB1ahsxxK/UYzXSb/OcTpHHr1zcQyBEVg8mVzVesLQl6WoAptGP2Fg2M/H+V0KtRRoVH3XGJRCLOJC1dxHqDYxQA73K5c9y3sqGPdc1MgihNINJRHOXh8qBm/5YSDiqY0UxdSodeYuGUCXP5W1qTXUfBp1ga7c6i3JL/qaBc83g7dKFziSxqUQ7yk8hAz6wExlGyImxQQUk1b3zg5TJL6BWAMqlwfwrughOFsWdZz59c0JVUG10X6nd5UszZiEV5gHG5z6UNYWd+oQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+6749ngU3QRBe9U0G13x7AkfPDAEPY0HalINt+ES/NE=;
 b=FRGvYKtu3+KCu14QKEtHObsY7mWOu7nO7EqABizXtyQN3eyL7sS89fTcHK56ASd4dWUEwMrIEXQ5mCL68azrbVdYyTmeDG4YDhaKNm+Y4B9zJB5o4tiYokSvbX6e1uc+mbHBH+x91oK9vnxpU3zER/S0xUSCV2g3NRLU2O7R4WM=
Received: from SJ0PR05CA0074.namprd05.prod.outlook.com (2603:10b6:a03:332::19)
 by LV2PR12MB6013.namprd12.prod.outlook.com (2603:10b6:408:171::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.17; Sun, 14 Jun
 2026 20:53:29 +0000
Received: from CO1PEPF000066ED.namprd05.prod.outlook.com
 (2603:10b6:a03:332:cafe::65) by SJ0PR05CA0074.outlook.office365.com
 (2603:10b6:a03:332::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.10 via Frontend Transport; Sun,
 14 Jun 2026 20:53:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF000066ED.mail.protection.outlook.com (10.167.249.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.8 via Frontend Transport; Sun, 14 Jun 2026 20:53:28 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Sun, 14 Jun
 2026 15:53:27 -0500
From: Eric Joyner <eric.joyner@amd.com>
To: <netdev@vger.kernel.org>
CC: Brett Creeley <brett.creeley@amd.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Eric Joyner <eric.joyner@amd.com>, "Nikhil P . Rao"
	<nikhil.rao@amd.com>, Simon Horman <horms@kernel.org>
Subject: [PATCH net-next v5 5/5] ionic: Add .get_fec_stats ethtool handler
Date: Sun, 14 Jun 2026 13:53:03 -0700
Message-ID: <20260614205303.48088-6-eric.joyner@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20260614205303.48088-1-eric.joyner@amd.com>
References: <20260614205303.48088-1-eric.joyner@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000066ED:EE_|LV2PR12MB6013:EE_
X-MS-Office365-Filtering-Correlation-Id: f53f728b-f9b9-4b0f-aa2b-08deca56fc75
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|23010399003|36860700016|82310400026|11063799006|3023799007|18002099003|22082099003|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info:
	Ahnu8USR1Fhj4JcggnMJ6PCkU3EVaau+cCDbfWuTftEuSpw06f4XSD5RXWcMTTJiKDn6aiJzJchjBTVAKckqmawXNBaYnz1Upgwj2EK4OdG9lh4Due7H6M1b/bZWqrjIQo3eVDDLbmiwq3TQzDT8bNPPdTuN+4XrLRDzLruP8faJUbl1i3BQ+Sk9hlkrjNuMDp9DdfZChU1zcBh1sLebqsDq12ZuMprehToPwR5LslZu+kusnJumlU240+1Jzd4EWn3WYGAUVijgceG2nS36iLWdpHhk+RCOOGinBoMxk83ReCbv1toANVr6vxeqD84kt+EgJsNuWNlxqBswUjKzi1mSUGBCemqCcUFHbijOj/Sskl3TjEORgJz/85iqMeL8KYv4PDeocDsyXLHd0CjVNNAeK8JdbMYYkOHlRQi/w13w7kAKB2uzRMdq71hfqnAJAC9h6BwY02fC7u8loANa30L8Jh49uooxs5sOwoDPUdHwXfDAM093OMDzVovwV4GSxptOyD4L5qR/RevfMr5FDTCTM13X3eyF5HWdo5RavR1Ey4uWRy7tyZ67w30GDVJR/ej3bRL2kxYqn3OZX1UyTyjW2Z2+GvkWTQvNMwt4Xr7EDDp4ZG1VT3clVcFQZSVP15pick2+/0Hy6JKnh1130hYffNKvg6MWp6M7I3glT3wYu5ok4mXP2d427ast7cMOD68QtNsLudqtuIYJq5RjQo5plYljBghFVBSautX3YLQ=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(23010399003)(36860700016)(82310400026)(11063799006)(3023799007)(18002099003)(22082099003)(56012099006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	339M5agjXOdW9bP7fXsTu9ZhdqKydjfCj2wRQbqYnQvAaRj0fUWjtiH0mNXDZ6TnJr4x81iroHjNwomUBcjULw/rTTmpPzA/HK5rWPb+rBo/svWP+d58eOAXTxpwROMAyp7GXttqwkYRXLWA+eab1F6fsxmNrO0LIxA6NOWCzCmeQmsWHQQvNW2BfBPSSHqGKKaP5wmmRp+Xs1SkWlcKZbT2aL6snSWrP7TDbKhro+StlFckK6m4TUynwjTPE0sjIqp6KkJdCwDuA859+uJgtYyPvERZmgzBNtB96GdBmISv5JhNIuDHkE4DMAR6iFx4jnQSx66OHvrCpgPCkPAXRmisvsM76Rj/k+ADe6it2yLhNY/Q8ZTlxpFgziNYXnvvl1G1rEd0/AIY3L1a5AldxoRKuYANHC8S6Pq2Ne/dGIDyjW+lxKV3TXmf7OfPJ8jM
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2026 20:53:28.3409
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f53f728b-f9b9-4b0f-aa2b-08deca56fc75
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000066ED.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB6013
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
	TAGGED_FROM(0.00)[bounces-299276-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:brett.creeley@amd.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:eric.joyner@amd.com,m:nikhil.rao@amd.com,m:horms@kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[eric.joyner@amd.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[amd.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,amd.com:dkim,amd.com:email,amd.com:mid,amd.com:from_mime];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DFCE36823A3

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
 .../ethernet/pensando/ionic/ionic_ethtool.c   | 77 +++++++++++++++++++
 1 file changed, 77 insertions(+)

diff --git a/drivers/net/ethernet/pensando/ionic/ionic_ethtool.c b/drivers/net/ethernet/pensando/ionic/ionic_ethtool.c
index c4ab4b5caa0a..e88e818667c2 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_ethtool.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_ethtool.c
@@ -441,6 +441,82 @@ static int ionic_get_fecparam(struct net_device *netdev,
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
+	if (!lif->ionic->idev.port_info) {
+		netdev_err_once(netdev, "port_info not initialized\n");
+		return;
+	}
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
@@ -1177,6 +1253,7 @@ static const struct ethtool_ops ionic_ethtool_ops = {
 	.get_module_eeprom_by_page	= ionic_get_module_eeprom_by_page,
 	.get_pauseparam		= ionic_get_pauseparam,
 	.set_pauseparam		= ionic_set_pauseparam,
+	.get_fec_stats		= ionic_get_fec_stats,
 	.get_fecparam		= ionic_get_fecparam,
 	.set_fecparam		= ionic_set_fecparam,
 	.get_ts_info		= ionic_get_ts_info,
-- 
2.17.1


