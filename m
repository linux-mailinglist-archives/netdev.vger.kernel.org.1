Return-Path: <netdev+bounces-299720-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id qkiwHsC2MGohWgUAu9opvQ
	(envelope-from <netdev+bounces-299720-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 04:36:48 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E257A68B81B
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 04:36:47 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=amd.com header.s=selector1 header.b=oIb8oL4p;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299720-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-299720-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=amd.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D7A3630268A3
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 02:36:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2B8E3C13FB;
	Tue, 16 Jun 2026 02:36:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012026.outbound.protection.outlook.com [40.93.195.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33BF83BD246
	for <netdev@vger.kernel.org>; Tue, 16 Jun 2026 02:36:25 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781577386; cv=fail; b=dF+di8BbSGlRBuFh03lubHUNplQcIFoFvgIyFmghZjHULGKppLwlpcHJt6rysr3++3jIJTJHoG5qkO/mJW+06J10PhkJ3DJIOcueGlCtlftoi4cfQ6qQeeEwp+n24plzaDvQJScyBpEpdfdYPt40942k/gAlOQ7WrvRHinPeKNQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781577386; c=relaxed/simple;
	bh=rfAOxP/63Lmj4dqleoEYOytf2gdnr1BtLWG8DkM1Hzg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lqv5szM0e+gvDRET2qIoVObOTXl7qEWimFcvBGlCw4ivsAO7hSM4HhoLneH8CQaFGVyg+eFWCzhQJ7QH26JZJmEVxxEndy1SIO+ZvIu4iLjQ/n+cEImF4G7ZovhSx+fLB2TH//rkomN3twK0aOPu55WXryrWGhhuFeXN524wkV0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=oIb8oL4p; arc=fail smtp.client-ip=40.93.195.26
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HP7TEkgFMOHZau54Zh4RMfbS71KF3btNrNING6xBWUUima5UMsZ9+Zto13ytefUG/avDZqnPRPqUYCWO7ISPk54SmQ/nxRXvO7vfg0AjAhqIO39HHDhmSHmxH9Qs0fCFPYVPxkzVT16XNTgGFmgaStNUyvUhV8KilsZPsKjlEN5+OTMe8JwwjFSBP+4r3ctuGqFtDS9H0YVfnMt44eu3ib9ets+BQq8IMadx7s/kW5QCUubpovnjhAGmB/caG+nxOp4GA0zu2KUmzPEuLtIoEIeXfR6S6xmnLwD97TwgF0K8lXfpDO1VDh5xc18/OrpvCE79yJZ0Yi7Q7yAZZsNeUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N5t4VRzlO8lDnqlMg/d6wVkamHw0p/eLGhhE6joHols=;
 b=HZ/co2YLvtQ3WA1orEtaneS3k8Yg6cmkByeXYS756nfu8zJhCswCiEdefq3IxwS2+hB4D5hYNZ40aleLaio3HrKr9se91nhM6g69IknSYiMMN9LeEZaK4/2WeYRnhrkZTcIH9fQ88QpfNp2qdeMEl93QyQYwPY3aexAWohMBqoUg9lx1LRNZ/5irp9vWa086IyqeFv+2oPByQobnkDThPk6RRwDzluSfQobK+YTSnwIRjifoJryMmS+fHbC95BFxC5jMelVTAmohd6d+YBeTkhSaGLvoup70ukMarWl2lK0eNhmYchzYpGqxm5xDhgeTxCGAAttcsMLMIMuF3/dWIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N5t4VRzlO8lDnqlMg/d6wVkamHw0p/eLGhhE6joHols=;
 b=oIb8oL4poSEzBUYytfHnv+2+eYDS3ta/tTq1spppTxUshq4/322HCzlkZLkKW7KKXvT3jl2EG1tDrH6Zx2PIrwRzjC2lcYXuSoyymTNdqhwKqdva+BuTE5Iotf4CEL534SX2DbrCj+U/eDgH8QtzukPOchgqSf5/nEi4C+0mI/U=
Received: from SJ0PR03CA0151.namprd03.prod.outlook.com (2603:10b6:a03:338::6)
 by DS4PR12MB9660.namprd12.prod.outlook.com (2603:10b6:8:281::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Tue, 16 Jun
 2026 02:36:21 +0000
Received: from SJ1PEPF00001CE4.namprd03.prod.outlook.com
 (2603:10b6:a03:338:cafe::3b) by SJ0PR03CA0151.outlook.office365.com
 (2603:10b6:a03:338::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.18 via Frontend Transport; Tue,
 16 Jun 2026 02:36:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00001CE4.mail.protection.outlook.com (10.167.242.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.8 via Frontend Transport; Tue, 16 Jun 2026 02:36:21 +0000
Received: from amd.rund-run.pensando.io (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 15 Jun
 2026 21:36:20 -0500
From: "Nikhil P. Rao" <nikhil.rao@amd.com>
To: <netdev@vger.kernel.org>
CC: <kuba@kernel.org>, <brett.creeley@amd.com>, <eric.joyner@amd.com>,
	<andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<pabeni@redhat.com>, <jacob.e.keller@intel.com>, Vamsi Atluri
	<Vamsi.Atluri@amd.com>
Subject: [PATCH net-next v5 6/6] pds_core: add debugfs support for host backed memory
Date: Tue, 16 Jun 2026 02:35:54 +0000
Message-ID: <20260616023554.258764-7-nikhil.rao@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260616023554.258764-1-nikhil.rao@amd.com>
References: <20260616023554.258764-1-nikhil.rao@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE4:EE_|DS4PR12MB9660:EE_
X-MS-Office365-Filtering-Correlation-Id: aa6c793b-9693-46d2-ee49-08decb500d54
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|82310400026|23010399003|1800799024|56012099006|11063799006|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	gRHIu3lLsMfxEWev5QRZyTfjYj+rXkBy7d/s8mBxnMMLRNeMuAvvKFwl9phH3ikRs/hW19aEkxs70oI+X5TznMMKYcykgtgT+MDiIU2AN0epthDocCUjCRUPcSQZgaTaNGIAHVCV2Y3ztnn8zs0qIjPv0JyrfYv8T5RthMXlR2/upWUvUIv9q+6eq6o4uOuYRSVTZv2zDfpVYVMeoa3lFFMamoC/WFfT4gnS3kcNzESlr/csbSbCQnJOA/3PS1ehES5396qgnYuHqcdAMPAcni7/6AFNkl4nGWclU6oZKxhHUaNBXKI3S7g6tRa9pRnpGjYKzld3V+NzjTJtPPj+WKxHHdIYB2yIhjl8qkOmBktjSEpyfTqAAzKV2zZe6sjjTTXjdqmiUD1TdfpXo86VuoydzY12J4sN+i5chzGZ4GwYQv9NuPCMxZJLOGHmQrFfD31msvhfVjPs9EXrOSf3M6B3RyyLsvAkvkrK7axr0pHM1MPyGF6f3eoBC5iyRsoZla+tgb7s/7RstlUDnVIiuuzc5PUJWr14W/KRVrIOgsRlkc3frtdNl6rfEcEYqB6VCYNu7gbOkT14tYm3gBevch+erOSEnLoUZ5SapiNaZN0b6TnEcfqJPP+lDHJPEAQYZxeexM6Mz7X0Eg4Zkp1i6duV++1RqMhZZ5CO4//SlN3d1yd8D3A9noxorBmkWWJ9JkbmucfPWTzAl8Zjlax8D8wcqa9yRatIEyuTHSxHhLs=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(376014)(82310400026)(23010399003)(1800799024)(56012099006)(11063799006)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	MtNAJyugBpG1LLIa7Dh9DrKwIV26zPW9fUvqisPeqDnopsXHvIWHiDDLcZKMF2bEM6Lt5pZgb0IdXtGmTtMQOwa9splZBMtIhqeloAxVlyRnXbpy53ivjh+NxWeRtdPaU2fgGZmzjnZo+ZVDxQJehX8zYcKu0KouZnkN/fs+s1gBzVqtCToXQ+FVVCc327HaxrC7DjERaRiLxAvn2m+T+XV1NaTBQB8fSclObvWAaG1zQZcn+QadzfbXz7DZuOXdbNfcbgnXJ9PE4n9iHM9VrD4pBF+ObW4qVk/d9hnY72ZVndvMAf70U1zKz0Z5XWNGB5EmnC5MljNbqo9wDpnQIxrFtOpkMTH/zz2tQH5ActelwE2PfSJeKgxDPmXVg52UFiJjWM5jUzfECrlaW9dguTu57HLBNQ1qT6FqRfIvoR/m4IGalJvqpAi+Yt2WQ5/F
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2026 02:36:21.3327
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aa6c793b-9693-46d2-ee49-08decb500d54
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9660
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[nikhil.rao@amd.com,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-299720-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:kuba@kernel.org,m:brett.creeley@amd.com,m:eric.joyner@amd.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:jacob.e.keller@intel.com,m:Vamsi.Atluri@amd.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nikhil.rao@amd.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[amd.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E257A68B81B

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
index 511482713d15..926f34c10e3a 100644
--- a/drivers/net/ethernet/amd/pds_core/core.c
+++ b/drivers/net/ethernet/amd/pds_core/core.c
@@ -487,6 +487,7 @@ void pdsc_teardown(struct pdsc *pdsc, bool removing)
 		pdsc->viftype_status = NULL;
 	}
 
+	pdsc_debugfs_del_host_mem(pdsc);
 	pdsc_host_mem_free(pdsc);
 	pdsc_dev_uninit(pdsc);
 
@@ -498,6 +499,7 @@ int pdsc_start(struct pdsc *pdsc)
 	pds_core_intr_mask(&pdsc->intr_ctrl[pdsc->adminqcq.intx],
 			   PDS_CORE_INTR_MASK_CLEAR);
 	pdsc_host_mem_add(pdsc);
+	pdsc_debugfs_add_host_mem(pdsc);
 
 	return 0;
 }
diff --git a/drivers/net/ethernet/amd/pds_core/core.h b/drivers/net/ethernet/amd/pds_core/core.h
index 1f80219edc6a..50c11af6c6c6 100644
--- a/drivers/net/ethernet/amd/pds_core/core.h
+++ b/drivers/net/ethernet/amd/pds_core/core.h
@@ -304,6 +304,7 @@ void pdsc_debugfs_add_irqs(struct pdsc *pdsc);
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


