Return-Path: <netdev+bounces-283081-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GB5dNUIb9GnZ+QEAu9opvQ
	(envelope-from <netdev+bounces-283081-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 01 May 2026 05:17:22 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7784C4A9E66
	for <lists+netdev@lfdr.de>; Fri, 01 May 2026 05:17:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2037F3029744
	for <lists+netdev@lfdr.de>; Fri,  1 May 2026 03:16:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F315F2E2840;
	Fri,  1 May 2026 03:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="W4dFnDgV"
X-Original-To: netdev@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010053.outbound.protection.outlook.com [40.93.198.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 868622E6CCD
	for <netdev@vger.kernel.org>; Fri,  1 May 2026 03:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777605393; cv=fail; b=qKRzDaLWeon0mKjluJHbbvgJv5zL3s9MMDoWmj/Ng+Xl3EZN794mrI5+IFOhstD3QtdtoDo8XL6Z4HY3vSe7RS0zPGHtYeX48Q1MOBNpUSDS9o37RiL7iwcElRgtkINzFbqLV90NQF8mLBXEZSFE1PuPF4EJKiE/IvWp+AJiKRs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777605393; c=relaxed/simple;
	bh=u+SxT8IxKTlMcmEDBvNxC2Hpd3C3vEbxvnKvz95X1gY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HLr2VHKQBPaep2Ox9lPnSZO3l2GYGHbcbwuSgeZxhrKKVRn8XDEL2uVz2dFHGYfCLaop0yv3xqgy7yKsWg+J+TS+wV4m4sckbV+DvYZBtD0gdUWodkjyIu9fYtvXrRX9JSS8XuwXIJm2ocmaxfk1Ptho7G3vsJbSo0a5+vPqj+Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=W4dFnDgV; arc=fail smtp.client-ip=40.93.198.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RnJmcEWgtPxcnbFD8v+dQ5ddlUXwhcGPE5ciF8BDtbFpZJIDtpBCGykEB3BJdxWNDU3nvFJuPCKMs5ehlUsBCn/gYLNc0heqhmZ6dxZB1sLL2GeKGV+nZt5H/YVWIvTzqDvFQBoHbENJ1MuEpLr1dJB/2Qurb/ZMGw5hbqWourPZSf1eUBgDcZcYwnO4BahUmwxIW8uQ6fa1fbNDlYDWkoUw94EJtcX4nuA2eNhGpY3hMiqsx2/TnONFbhZZ8iAX2ZWfAyjSnSouSNIIDnWfr0JKFIBw9ZMvgoqy8fMKsXjxkJW0YVQS+JUPtkPXl6GvVSmt/YrZ92um/A11Q/NPXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sBoz/R0gpEIi6gnQ0dhpSLhcRn6WixDt5w/un0gkk9g=;
 b=svkv/ZTlmkEmSUwpBRdf+T0COtRyGIJ0r7QKcJDz1HEKPsa8OWKV+w6APcALkKA50nlGIv0+xXmbE5mPKoMe5WsYMbbYqjZWdHMvxXTaCnoven6fn2WqBcZW2eQj7zzxAfHvz+RsYRJO6K8cXt8pKJDH1OWuyqt5/HCRHi7FSq0u+9ylLx6imIc/BOwVtFLX7jyctoMyBBj8YJAs7fJKbyzrZxxPSwDRiTXqEPK2cI0HFe5zb6sR9Ko/aCVtJD7cjrVcdqdNHd04CBeMhkxWAwP6mlwPBnwG9Dppo95/nLQ8PSDWwpSRsbmcpd9A0k+stvdXXuSqS82c1h86lxdM/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sBoz/R0gpEIi6gnQ0dhpSLhcRn6WixDt5w/un0gkk9g=;
 b=W4dFnDgVqXXyqm5mn94IXE6KMJtJF3nAOLMgEhnCbXbm1xz94ps18JCgspWNCF14oTG1AUuQafl8zACWU7GSE8uNDhj2wiwWj4/klWWJRMJQ5OzZMrnsrQseD8VvYr/vvLRQhybjEPuSJx4eQYJsqUJyefovSKUQZOyNPjxp10w=
Received: from SN7P220CA0027.NAMP220.PROD.OUTLOOK.COM (2603:10b6:806:123::32)
 by IA0PR12MB8695.namprd12.prod.outlook.com (2603:10b6:208:485::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.16; Fri, 1 May
 2026 03:16:28 +0000
Received: from SN1PEPF000397AF.namprd05.prod.outlook.com
 (2603:10b6:806:123:cafe::a9) by SN7P220CA0027.outlook.office365.com
 (2603:10b6:806:123::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.30 via Frontend Transport; Fri,
 1 May 2026 03:16:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF000397AF.mail.protection.outlook.com (10.167.248.53) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.9 via Frontend Transport; Fri, 1 May 2026 03:16:28 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 30 Apr
 2026 22:16:27 -0500
From: Eric Joyner <eric.joyner@amd.com>
To: <netdev@vger.kernel.org>
CC: Brett Creeley <brett.creeley@amd.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Eric Joyner <eric.joyner@amd.com>
Subject: [PATCH net-next 5/5] ionic: Add .get_fec_stats ethtool handler
Date: Thu, 30 Apr 2026 20:15:55 -0700
Message-ID: <20260501031555.43259-6-eric.joyner@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000397AF:EE_|IA0PR12MB8695:EE_
X-MS-Office365-Filtering-Correlation-Id: b6594468-1c64-4506-07a0-08dea7300905
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700016|376014|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	DkkpZ39uksplH336hQaI47VsFzyaa9bRhzx5EEA/FG8QC3g2vMDLVU70d0EjspSjcHCCA5Knsklu2RH+NYYkI9GFedCz5YgJ/YkyCZ5wwxecLWAzDIz7ISi3xmrZDXQs/kP4jb+Dv9bbmifgG1fAeApRMdLT3hz/NDaxjyvoNSglrqTN6ga790MyQXxBKH9RqW5r5cKMRBQJ4BdKR2icnzLNRs0qzHUCmK1A5OoW2HpCi1rsnb5gC7Kk5kx8+eVvoZvSvBciGUjeoJ9mX6p+r+d0PN7A/qrNbSsxDVWPeLzp6foCnu7sAtrkzWyYHyDx4Uzb7lOwPEHE8vo5rZbxJd8I+fp6ba1S9WuqKX0uR5ZxEQBJ6BjJezhfYoSf3GK3txawyS3yN7eFrDHEj08INTtil5KU4cJrfamgFT7NB9BgbQ+gu7D6j6qKHxLWCkCJbuXqpvG4lda0Sjl+wbDcrWFhyni93qvCPTn4eUdRcLUVslS4mcKfXIO5ikAgyMrEr/yMGoWFzrpeqdn02H83XJoR0aYQY9WuxvyeexfEMmPqTc/JxiiHkK9GfQuur6XhgW4Gbj3Kcg56DlL/T2txonV9XgQo2ShbmTFq1s3GnZLhl/zcD9qykVbyzSiRqIu9pAlM853Nd07snN4lYXFXLw6dUQug7IaFQeDRYNxAxMHUfVFTcmDhrbZmYmuOgh7XaSuTHL8bFvtXUHjBJpD193akNTxLh+R/oM7qTlKP6kw=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700016)(376014)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	cpWVMMB61xHeRPjIfD7IagPX9VIpbcmO6YJzc4mAcpH5LKBPUna7sZf82n51eIpQobPogX5W8lZtO/thmWmNdvNt9oLXlvNL/IjaIuIXtr9SIfCA8H3DrmNb/F4h4J8BYWDIMQt2lRoYnBsJdlSmJ3x7Y9iyjGSwyOq552G2J2MrZfsTKpMmqgoXZHyI0l9TcfNR5CQ04r6qXDCXxXbY7x6vUktN6ZsxWLxSURtWyrlhBH/k27f8G7Me87W3z2Et8D1N+dtmSZwf1VLwgeYOfaM7ziFu2+5MSkA+1wjnfnYLcfCljJpxFyYbjR/QKRVM2/6lBoa49naP5ek9zMmYl44hIrDU/+v+tAzpUeZm7sesmBJ76KztVSwxIMqOAXqmteuVlFfa030kiqd8pkU70HGyTeKN5hrJGQornWzIwEAyrnx+ch63epKtVqm5cDIz
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2026 03:16:28.4408
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b6594468-1c64-4506-07a0-08dea7300905
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397AF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8695
X-Rspamd-Queue-Id: 7784C4A9E66
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-283081-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:email,amd.com:dkim,amd.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[eric.joyner@amd.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[amd.com:+];
	NEURAL_HAM(-0.00)[-0.991];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]

Several FEC error statistics being collected can be reported in a
dedicated ethtool callback for FEC errors, so implement the handler that
does so. This includes 802.3ck FEC histogram data that some newer
hardware collects.

Assisted-by: Claude:claude-4.6-sonnet
Signed-off-by: Eric Joyner <eric.joyner@amd.com>
---
 .../ethernet/pensando/ionic/ionic_ethtool.c   | 51 +++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/drivers/net/ethernet/pensando/ionic/ionic_ethtool.c b/drivers/net/ethernet/pensando/ionic/ionic_ethtool.c
index 78a802eb159f..fe1f753b6115 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_ethtool.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_ethtool.c
@@ -418,6 +418,56 @@ static int ionic_get_fecparam(struct net_device *netdev,
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
+static void
+ionic_fill_fec_hist(const struct ionic_port_extra_stats *extra_stats,
+		    struct ethtool_fec_hist *hist)
+{
+	int i;
+
+	hist->ranges = ionic_fec_ranges;
+	for (i = 0; i < ETHTOOL_FEC_HIST_MAX - 1; i++)
+		hist->values[i].sum = extra_stats->fec_codeword_error_bin[i];
+}
+
+static void ionic_get_fec_stats(struct net_device *netdev,
+				struct ethtool_fec_stats *fec_stats,
+				struct ethtool_fec_hist *hist)
+{
+	struct ionic_port_extra_stats *extra_stats;
+	struct ionic_lif *lif = netdev_priv(netdev);
+
+	extra_stats = &lif->ionic->idev.port_info->extra_stats;
+
+	fec_stats->corrected_blocks.total =
+		le64_to_cpu(extra_stats->rsfec_correctable_blocks);
+	fec_stats->uncorrectable_blocks.total =
+		le64_to_cpu(extra_stats->rsfec_uncorrectable_blocks);
+	fec_stats->corrected_bits.total =
+		le64_to_cpu(extra_stats->fec_corrected_bits_total);
+
+	ionic_fill_fec_hist(extra_stats, hist);
+}
+
 static int ionic_set_fecparam(struct net_device *netdev,
 			      struct ethtool_fecparam *fec)
 {
@@ -1154,6 +1204,7 @@ static const struct ethtool_ops ionic_ethtool_ops = {
 	.get_module_eeprom_by_page	= ionic_get_module_eeprom_by_page,
 	.get_pauseparam		= ionic_get_pauseparam,
 	.set_pauseparam		= ionic_set_pauseparam,
+	.get_fec_stats		= ionic_get_fec_stats,
 	.get_fecparam		= ionic_get_fecparam,
 	.set_fecparam		= ionic_set_fecparam,
 	.get_ts_info		= ionic_get_ts_info,
-- 
2.17.1


