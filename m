Return-Path: <netdev+bounces-287341-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kBaBBUyuA2ru8wEAu9opvQ
	(envelope-from <netdev+bounces-287341-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 00:48:44 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B7E7552B18F
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 00:48:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 944D13105E07
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 22:45:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A9AD3A75A2;
	Tue, 12 May 2026 22:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Lgl/kdWs"
X-Original-To: netdev@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010063.outbound.protection.outlook.com [52.101.46.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3DC13A6409
	for <netdev@vger.kernel.org>; Tue, 12 May 2026 22:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778625890; cv=fail; b=Wp6xx4lNuZqtbCitM0Of6wEKK1daiSFTkCQqgM7DtUpsfICq4CJsqgAZ2XF9ZLDymwsT/ygqs2iNZS6WvLYNgkFoT8fMfBLm5n3WEnaPsELzm/Q8NVFL41d8lhIo0X/25MqvACS4oNSzL4cSdvavK7EGrKQBFCVg+frrTFXUoN0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778625890; c=relaxed/simple;
	bh=cOA7BTSvLvc31Io8stlo8/90NwAzqSvd4WOYLhLQcZc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ls9e3uBCyF/HkWU0/3/SPEyW1SH3zW1DvUvP1PQOuxNbr64CpFJAg7laRPVwT19FMJh8qDpMpJL7jR+9MRt56Lx6hO2tqmiYCaHCr7JfBJfHkVhamHWiQkWSh1t2BwL3FcftP12k9MNJaPT6tFP4pBGZafMW1Pc/8c4MPWwoIwY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Lgl/kdWs; arc=fail smtp.client-ip=52.101.46.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VevKcBcaeHquYY23JutnddcDWhqcpAA2vCsCOv4EUtHcJ7gwfTv8hF4wLA2Yq5kqMarK7LEz0IYuiOek95P+mxT5cn+DqVIgUkZaVGAOAAK5sagxncC0CF2ElFiWcHBCXQH0saEO1HmQN9n4rivucJSqvqrZWVs5uRvrOpqgj+VGsLq6cl5BBjm5W/OiP9CACOl10RsvY+uIemx+1gxfmEq8YNU3epPQ8z/jrz0P+EN/g4xYOORDG2lMbCrDtc9ketSWnldxTe77EipKO/QjKtuxehLguTF8bcIwDyrgYURfptFrj4DcnT4zwq6E9yZX1/LBa8Nwbed2mhKAuZoNOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VuhAWE2gnHgJ/rxdxCdtTD9Z0w6W6r9W9dNbuPm7lc4=;
 b=Nfe/39GzuQp+NFZ+kym4L7BENRU12o+oX2bTBiLCIJueLhKWXPZBUFJ5YKU9OVoriIv/8vDGdQP8n/ikpdXtN3XlV88qFbSPTKTGewthZO2PSfkbe4v5ukGLs09fw1n0/C/Wi9aXyAFBS5Gr4j+BorhDIX+5edXYzqzrvlkv61WHWYyDEk8T+mPD7Hi6WinZl1lglWbH0T9lC1QeF1XEy1acOtNm9okus7MT1y17QsEfvjXim2AZP8qpD/WjE5+3qspXJX7dtBQH1pLuUM83X84L9k/5k5ZjXwphYKwLeOf+JKJJBZMSDLtFN8kkeTqet0Y3++DMh24VILaalI3+gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VuhAWE2gnHgJ/rxdxCdtTD9Z0w6W6r9W9dNbuPm7lc4=;
 b=Lgl/kdWswtkU+lhdWWGDBL4GfaFZR8m1cOu0C1K17AH+1cpeH/3tj2Lm5uoKmt1jpWjMCgOuvJYkkdIAgUhVu/tyEiC97pK/biBOm7ZnYQHH2h7+TvElg3O8iY7c7D6+cSSynpS6wQkSPfWVNH1e5cX12MZ3nr8MSNPHJ6BkM0o=
Received: from CH2PR17CA0023.namprd17.prod.outlook.com (2603:10b6:610:53::33)
 by DM4PR12MB7624.namprd12.prod.outlook.com (2603:10b6:8:107::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Tue, 12 May
 2026 22:44:44 +0000
Received: from CH2PEPF00000099.namprd02.prod.outlook.com
 (2603:10b6:610:53:cafe::ae) by CH2PR17CA0023.outlook.office365.com
 (2603:10b6:610:53::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9913.11 via Frontend Transport; Tue,
 12 May 2026 22:44:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF00000099.mail.protection.outlook.com (10.167.244.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.13 via Frontend Transport; Tue, 12 May 2026 22:44:44 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 12 May
 2026 17:44:43 -0500
From: Eric Joyner <eric.joyner@amd.com>
To: <netdev@vger.kernel.org>
CC: Brett Creeley <brett.creeley@amd.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Eric Joyner <eric.joyner@amd.com>
Subject: [PATCH net-next v3 5/5] ionic: Add .get_fec_stats ethtool handler
Date: Tue, 12 May 2026 15:44:21 -0700
Message-ID: <20260512224421.25236-6-eric.joyner@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20260512224421.25236-1-eric.joyner@amd.com>
References: <20260512224421.25236-1-eric.joyner@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF00000099:EE_|DM4PR12MB7624:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f62547a-88b7-4f91-f2c5-08deb0780ff6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|1800799024|82310400026|376014|11063799003|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	XxHxB6MYJizVVFNGSuLoV/TLtXRnR+kqfIhDea5D6mufCF8ioFlegFiycmGp5Q+gI4hCDzSDHMW2JhxLlY3VOuP/XjSNL1HVans8cHCYDpKHscXtlTpyTAJGUBXadzCVKo3mj9VVFQDsOJFPJOV9j/EtpLf2apPxji87cVtoXXA3pmpJ0kn5MKDjYv6mM3CMPDuvhsdHkKIZgKStL1mVJQJn7CuT4WFYok5b5fldqodxXcoNgGL8qMJamU6BM3PIGxSoqmkFYXSDvTa4CoZzsDzzFae+BLBhN/NECki2Zzoyn1xLXjGdFayrEfVepxtq7omW8GigbS9FAVhNyZ9cjNJ5IvqRNJ4FQj7HH94KNyuwoKQMxAYyC33EcKD8EEQ08q/pcmfx4XRqqmFD5yGuGKQYJ7TaJEW2On4ajdZa+B5DSr7Gn5sQYHTlTtmEaPSxvRrLu/iR1QrhS9dfiG2g4WKlnOsB9jbDTuIW2XIi3NkwrCbqKn4SxgBgDaRzeGemMJsR/HO43wVoRSci4jVtMI+N8iUdE86KGzQkdlPTw4SvR13F4EMvuNoAk+3y10hmo/8oNhbrVgviNgneWSPNwWaLsRMcTQ92FuL6ZyCKzV2ptmT7MRV/9Qa9QtTrm6uz9pWjTJhs+61R9DjX/A7OuI6KoYLSvwP9TnnWL0Pp1Inhq2B8W9vAC7mp0tBbgqT3T+E+DiBS2a+/IyuGWlSZSZt0TYMhY4du1S0/ZXeEyk4=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(82310400026)(376014)(11063799003)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	zkp22mbjTrRm4rEXfMTQg6k97C25+qUpG7n0nLirGUE3S+sDYqdZmMnHABtynjuozB3XvFQqzFen/lu0B1vTuBbL4borJWzLHfJDs3jNcM10O9BRAGf5WebaCJK8DTVYHtApqabcoCavCxOrUsMf54IBoF2Nug84VZeIvaXzrNnXTiHLaCNmw3sTqwQWmvuG9b7LrWMoRIdMNYqLnoTarvDYnrJWUsFlGi5URoEQeq+RXbg2cPnD8fse0zvbIbKFgpkNUW/niZqonSfq70HPWcpYC22WDJ3hNlTBn3StYetl//orRFrmAoWCPrit34E1p7weyfaroLrsWq69NHyJDsT1XTI5P9FG2qAhAGP5DpHD0YRkfh12Tc38QwwpjBPRqyEQnCsGFL34QQ6boUotHi95TEfwmdJR7p80FQBz+7EYBdnPYaykcSLRludcu9ek
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2026 22:44:44.3060
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f62547a-88b7-4f91-f2c5-08deb0780ff6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000099.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7624
X-Rspamd-Queue-Id: B7E7552B18F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-287341-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,amd.com:email,amd.com:mid,amd.com:dkim];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[eric.joyner@amd.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[amd.com:+];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

Several FEC error statistics being collected can be reported in a
dedicated ethtool callback for FEC errors, so implement the handler that
does so. This includes 802.3ck FEC histogram data that some newer
hardware collects.

Assisted-by: Claude:claude-4.6-sonnet
Signed-off-by: Eric Joyner <eric.joyner@amd.com>
---
 .../ethernet/pensando/ionic/ionic_ethtool.c   | 52 +++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/drivers/net/ethernet/pensando/ionic/ionic_ethtool.c b/drivers/net/ethernet/pensando/ionic/ionic_ethtool.c
index cc2b294910f6..54b00ce2467c 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_ethtool.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_ethtool.c
@@ -425,6 +425,57 @@ static int ionic_get_fecparam(struct net_device *netdev,
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
+		hist->values[i].sum =
+			le64_to_cpu(extra_stats->fec_codeword_error_bin[i]);
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
@@ -1161,6 +1212,7 @@ static const struct ethtool_ops ionic_ethtool_ops = {
 	.get_module_eeprom_by_page	= ionic_get_module_eeprom_by_page,
 	.get_pauseparam		= ionic_get_pauseparam,
 	.set_pauseparam		= ionic_set_pauseparam,
+	.get_fec_stats		= ionic_get_fec_stats,
 	.get_fecparam		= ionic_get_fecparam,
 	.set_fecparam		= ionic_set_fecparam,
 	.get_ts_info		= ionic_get_ts_info,
-- 
2.17.1


