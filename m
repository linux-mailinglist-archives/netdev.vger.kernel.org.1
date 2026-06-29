Return-Path: <netdev+bounces-302845-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Qqp3AKL5QmoILAoAu9opvQ
	(envelope-from <netdev+bounces-302845-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 01:02:58 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E5666DF21E
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 01:02:57 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=amd.com header.s=selector1 header.b=YOe4gUpY;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302845-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-302845-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=amd.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BB67130315F9
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 23:02:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 040AE3BB109;
	Mon, 29 Jun 2026 23:02:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013005.outbound.protection.outlook.com [40.107.201.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B1CD2FD1B3
	for <netdev@vger.kernel.org>; Mon, 29 Jun 2026 23:02:36 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782774157; cv=fail; b=hjSceiEZYg3FaMaiANsjCVB9SqXO5k1qNkgP6k6KphxdPCWSh3Wx+jkK4HJwUhUvlYtnePDBupSutaDQr8xSXwsCOR17orV8RIroMi1wH0saXc2we0drReC0tKWpzJDX8o1XY8YZLO5pcd2JZz2H+DWpBHzMfnMVId9JtmmH2DQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782774157; c=relaxed/simple;
	bh=X9c8G4p6e94RW4p/vQD97JCqx3D8HTDARSAQmvAb7Dk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N/dNvX6/IrB5bFbcpJU0lV5tsQ25TrvAzR/WiB5tON10BQU0nYwLrCv6n2Kn1PZyqe9VKwSRyEHEUAXCcNz26wa3Yrzg//g6USmqVsQBZxN4ghtMnHX/KowS3g8T0zZbNXWKBm3yioAtGQgc0LyTsnKEOsYnyAH+n4Gf5arVg7I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=YOe4gUpY; arc=fail smtp.client-ip=40.107.201.5
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OfC2cQ04yBTPG0Vt6kfOEHq2Jh3ptvGUHstNbeNWwO2SxsbBadzCkkWTAXeHvbBlnSbnxEvCewhZ428pQa+UOYUfcW8gnKwVPu1RCUZyYXDsePQkdbHfUpw4pkjxgaStw3k6mdfqPPWUitde8e09B3aQeyqdBcsYSfjfcwGQJVBuM1reUurMtPvVGuJPLdAf/Ai8kmpFPovFIirk45Z4zP29c32M6NSRnmwt1Kv0NXZDfz21IMnAciamoqcxbzI6z7e2AD6LdGDoksW7jkl6C4J+z6HS94fpyols8XTbf1qGF4VsMJrjl1fHsFQWi9Z0i7vmiQVeiBrScLTdVj8j7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0PsYkjcx8jQYBxmBMKict45NRlxtOoZEpxLm0P1VbsU=;
 b=Y7O/fWWmqoDaN84GG4pGUxJFpLp9TMLZ+H4BAuvBtKRrvAFehixOX/xdQRjdHRSTJH76pjF/vUKbnGVqd5uEEOXgo0KyjLKZMZBh2nofVnRXkkHtodhdpjFcWol/6/fcLikiz9ERiWo0PjeTqqsXCwDrnvm79LzHlbIupFBsuDMmqXRo8S6o09Dw+T5LjLRMMSSyoJ/CLQURwgftcwYTywlg8eDaBifRoUCCCFkx8K0C16CctpolOfYC6+VPpsFyaQ0iJINZKw9/3N+ipUoUAw6hB+PY9K1zMueQIJ/FY76djga4I8GBBSlqi98Hkorvg5Mv0KroS5S5nc15ZOW4cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0PsYkjcx8jQYBxmBMKict45NRlxtOoZEpxLm0P1VbsU=;
 b=YOe4gUpYSwbKVGMf4rd3G3LT3A4K9Ld3RfWx+xQEurecOBBuo+hzcVWuD4VFV6onhY0N2E4KtDwyog/bLWRxzNYT+rXyzBEqL85noqWydoR3FfccXBakR2ugSPwpdu/8sWTCqipUWR6GUfD/Hg+sPO4PhfO4ckaC4bMpZ3GF94A=
Received: from BY3PR04CA0021.namprd04.prod.outlook.com (2603:10b6:a03:217::26)
 by CH3PR12MB8933.namprd12.prod.outlook.com (2603:10b6:610:17a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Mon, 29 Jun
 2026 23:02:33 +0000
Received: from BY1PEPF0001AE1C.namprd04.prod.outlook.com
 (2603:10b6:a03:217:cafe::9b) by BY3PR04CA0021.outlook.office365.com
 (2603:10b6:a03:217::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.19 via Frontend Transport; Mon,
 29 Jun 2026 23:02:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BY1PEPF0001AE1C.mail.protection.outlook.com (10.167.242.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Mon, 29 Jun 2026 23:02:32 +0000
Received: from amd.rund-run.pensando.io (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 29 Jun
 2026 18:02:31 -0500
From: "Nikhil P. Rao" <nikhil.rao@amd.com>
To: <netdev@vger.kernel.org>
CC: <kuba@kernel.org>, <brett.creeley@amd.com>, <eric.joyner@amd.com>,
	<andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<pabeni@redhat.com>, <jacob.e.keller@intel.com>, Vamsi Atluri
	<Vamsi.Atluri@amd.com>
Subject: [PATCH net-next v6 6/6] pds_core: add debugfs support for host backed memory
Date: Mon, 29 Jun 2026 23:02:00 +0000
Message-ID: <20260629230200.82092-7-nikhil.rao@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260629230200.82092-1-nikhil.rao@amd.com>
References: <20260629230200.82092-1-nikhil.rao@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF0001AE1C:EE_|CH3PR12MB8933:EE_
X-MS-Office365-Filtering-Correlation-Id: b3b0f529-5004-42be-0014-08ded63280c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700016|1800799024|23010399003|6133799003|22082099003|11063799006|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info:
	48fnMv/XvvUrJAbiAcFQZCWDS08ABpmcrxHTve+01N3YKA6MBwfFygN/85u8sqHyoNnl5tgD3SblKJ5cvdbVUOMBRD7Hqd5rBKJ0BLRtel8qdsh72gvetomfJgqKdcLUYvk2s2u2vEjT/BevujS8ciYKrDnNF7QyP1aiklj/6+Hr+HrVail4iJbCK6faoWpAW/rxLyLA0a29IG94baef/LABHD9idxLBukhFCvD4iS2CrSC5TkM4rbwA3sg4y5Y77TBs917Ug2RBICXJvwUCB8MHYSx3lSngoV9RAyM8xscnpWa48kF7TbrdonTvnSbFTCjGM8ei1q66AuiLBjDcas3siAfxlxJA3Wzhn8SDo5ItsRKpx2bOA1jWPw0TtC3MvG1JmRWhWGi99ppiKckqMxFXdn2YjRGXVtgiaPTuLSu6uu/n5OdKA5zJx0E7O5KH+Sr8AV/YJQGvSwdkO261BY+tM5sLhWpkt6f1A1Lb5Kehw4fWdmmKAQZOgtAmV9iqKxtNQVUP2Rvx26+mVrcNg7DbeNA032+jvc5m5KJjG5VP8aySm83/Z1tJiN9DyGgZp7yeNvCJmgxEZyPFpDfkJ4AYs6Rhc+MoqvX9aFgqPdl3arXWITq8EGQHiBPue1Q0dGnCrEddPM4qhaeIl3/cweMQY1JmnnWYlwOHDD2cQhxEQmtSLYG7lRQWKA85AwKF26wJshnYYAoznz+pRxA8Ig==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700016)(1800799024)(23010399003)(6133799003)(22082099003)(11063799006)(56012099006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Rhi9Cqt5JVUEeu+ZpobsmoyWt6L+wcDG8supJsos84nY45BiDZ9pMZl3kZQkJbDAIcurqrGiyyRGMO3WVdyv6lmUw76amnNR91KaptFFP9GnyhP19jE192I500k60Jow6lbIpZRi6BHcBKheUKUDqAhm99/KST+ejC3TAHXh+lt57dpnGK5Q/c+94h1bWkbiUQ8Tu8kszFw0XPVQJwlLWrLr0SAB3ITMhMkNDzjqd28xMAmpyt6O2IVjVuQUUV7mH2daqNK+nf0vZ0bu9jrIcw5j+Ed5zMxcLupYPg9x9kgl1IfNpge4x39vk9qQOYRooFkXcsxQG/DwMRyAorft1eaP5TK0DxkYflJndAeRdy6djYTUylL4cGCpuyR/7Y0d8fy5OFSBQbggigFOXIEPquPQeIe06j9McUbWDJyeu3hM/BJt7UkWcP7U1dwY6Ius
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2026 23:02:32.9413
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b3b0f529-5004-42be-0014-08ded63280c4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BY1PEPF0001AE1C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8933
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[nikhil.rao@amd.com,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-302845-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:kuba@kernel.org,m:brett.creeley@amd.com,m:eric.joyner@amd.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:jacob.e.keller@intel.com,m:Vamsi.Atluri@amd.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nikhil.rao@amd.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[amd.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5E5666DF21E

From: Vamsi Atluri <Vamsi.Atluri@amd.com>

Add debugfs file to display host memory allocations including tag,
size, order, and physical address for each memory request.

Signed-off-by: Vamsi Atluri <Vamsi.Atluri@amd.com>
---
 drivers/net/ethernet/amd/pds_core/core.c    |  2 +
 drivers/net/ethernet/amd/pds_core/core.h    |  1 +
 drivers/net/ethernet/amd/pds_core/debugfs.c | 45 +++++++++++++++++++++
 3 files changed, 48 insertions(+)

diff --git a/drivers/net/ethernet/amd/pds_core/core.c b/drivers/net/ethernet/amd/pds_core/core.c
index be8d802ca921..dbeda801648c 100644
--- a/drivers/net/ethernet/amd/pds_core/core.c
+++ b/drivers/net/ethernet/amd/pds_core/core.c
@@ -491,6 +491,7 @@ void pdsc_teardown(struct pdsc *pdsc, bool removing)
 		pdsc->viftype_status = NULL;
 	}
 
+	pdsc_debugfs_del_host_mem(pdsc);
 	pdsc_host_mem_free(pdsc);
 	pdsc_dev_uninit(pdsc);
 
@@ -502,6 +503,7 @@ int pdsc_start(struct pdsc *pdsc)
 	pds_core_intr_mask(&pdsc->intr_ctrl[pdsc->adminqcq.intx],
 			   PDS_CORE_INTR_MASK_CLEAR);
 	pdsc_host_mem_add(pdsc);
+	pdsc_debugfs_add_host_mem(pdsc);
 
 	return 0;
 }
diff --git a/drivers/net/ethernet/amd/pds_core/core.h b/drivers/net/ethernet/amd/pds_core/core.h
index 085f2e988aa0..791756a50870 100644
--- a/drivers/net/ethernet/amd/pds_core/core.h
+++ b/drivers/net/ethernet/amd/pds_core/core.h
@@ -306,6 +306,7 @@ void pdsc_debugfs_add_irqs(struct pdsc *pdsc);
 void pdsc_debugfs_add_qcq(struct pdsc *pdsc, struct pdsc_qcq *qcq);
 void pdsc_debugfs_del_qcq(struct pdsc_qcq *qcq);
 void pdsc_debugfs_add_host_mem(struct pdsc *pdsc);
+void pdsc_debugfs_del_host_mem(struct pdsc *pdsc);
 
 int pdsc_err_to_errno(enum pds_core_status_code code);
 bool pdsc_is_fw_running(struct pdsc *pdsc);
diff --git a/drivers/net/ethernet/amd/pds_core/debugfs.c b/drivers/net/ethernet/amd/pds_core/debugfs.c
index 810a0cd9bcac..ef0a1b7d159b 100644
--- a/drivers/net/ethernet/amd/pds_core/debugfs.c
+++ b/drivers/net/ethernet/amd/pds_core/debugfs.c
@@ -178,3 +178,48 @@ void pdsc_debugfs_del_qcq(struct pdsc_qcq *qcq)
 	debugfs_remove_recursive(qcq->dentry);
 	qcq->dentry = NULL;
 }
+
+static int host_mem_show(struct seq_file *seq, void *v)
+{
+	struct pdsc *pdsc = seq->private;
+	struct pdsc_host_mem *hm;
+	int i;
+
+	if (!pdsc->host_mem_reqs || pdsc->num_host_mem_reqs == 0) {
+		seq_puts(seq, "No host memory allocated\n");
+		return 0;
+	}
+
+	seq_printf(seq, "Host memory requests: %u\n\n",
+		   pdsc->num_host_mem_reqs);
+	seq_puts(seq, "Tag    Size         Order  PA\n");
+	seq_puts(seq, "---    ----         -----  --\n");
+
+	for (i = 0; i < pdsc->num_host_mem_reqs; i++) {
+		hm = &pdsc->host_mem_reqs[i];
+
+		if (!hm->pg)
+			continue;
+
+		seq_printf(seq, "%-6u %-12u %-6u %pad\n",
+			   hm->tag, hm->size, hm->order, &hm->pa);
+	}
+
+	return 0;
+}
+DEFINE_SHOW_ATTRIBUTE(host_mem);
+
+void pdsc_debugfs_add_host_mem(struct pdsc *pdsc)
+{
+	if (!(pdsc->dev_ident.capabilities &
+	     cpu_to_le64(PDS_CORE_DEV_CAP_HOST_MEM)))
+		return;
+
+	debugfs_create_file("host_mem", 0400, pdsc->dentry,
+			    pdsc, &host_mem_fops);
+}
+
+void pdsc_debugfs_del_host_mem(struct pdsc *pdsc)
+{
+	debugfs_lookup_and_remove("host_mem", pdsc->dentry);
+}
-- 
2.43.0


