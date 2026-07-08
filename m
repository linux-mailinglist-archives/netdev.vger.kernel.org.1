Return-Path: <netdev+bounces-305996-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id vDXpI9W/TmrATQIAu9opvQ
	(envelope-from <netdev+bounces-305996-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 23:23:33 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E8A5E72A80D
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 23:23:32 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=amd.com header.s=selector1 header.b=UeAQHCc8;
	dmarc=pass (policy=quarantine) header.from=amd.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305996-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-305996-lists+netdev=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 001F0300F15E
	for <lists+netdev@lfdr.de>; Wed,  8 Jul 2026 21:23:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 450043F1AC8;
	Wed,  8 Jul 2026 21:23:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011010.outbound.protection.outlook.com [52.101.57.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE3993CF047
	for <netdev@vger.kernel.org>; Wed,  8 Jul 2026 21:23:29 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783545811; cv=fail; b=kmTcC0mpNf5bmBuaasjXj4U7oAuKM1abybiH7r5Gy1mrXVrSwiqSfiqeF16RgjuDfpvE3JeQRjua2VqgrVEio/gAL4CUVvuzapMGDFb6LOduibvgr0I6wYgDGoywsTXOzzyFvyv5guADkxrnFo/1GmzD46JBNcldNnbmS4+jCx4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783545811; c=relaxed/simple;
	bh=sypCW1enPSKw4hXYleE24Hm5uDen/SQ66oGTi1l+2i8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=khNbpFf03BhGdQCYsftKsm+NGz5A2JBJJNcyUdqiIAK5Omn1//uZrUyZ8C3y4kDfclfn8jDdBKn3N9Flyu5aKk6X8GOPl3wW6mWs6DDcGk11j/Q3Nq/M/n/O97ORrOkInrYZr9h/ErmNyqRiQT80mPFTD8gk6SuTKAFIEh0Qw+0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=UeAQHCc8; arc=fail smtp.client-ip=52.101.57.10
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QU5HmtPuvsimeaOw8O/IfG1tjhHny66hEzmzjpkjJ0X7iJ2mNQ3dTn8bm6yks+8y85GTFt5Yh7JzIoFIzSknE1/hMG7eE+Q9zXUsr9JieZZ2111XufV8cxIC4IBlhZEdlT1s18fqpH35t5BuqAJDbsTq1OuiZAlXLYjcbm+fUCObamBGllzyuIdYY6F848zKw53cUiojeMZeapcYFYQNjFjhaVGXmhUEX8h4uNqqCVivREPUV0QYsJ2YKEF8BTDqSDC2z/OOvEr8D6jNeQPLjeZYoW0uKh6OAo853bAleOCC/tWCF1N97dKttleogVcU/CJA4z+n+YhZcVWKqMIN8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EC/YOvm5+54jIbSVBX1GTTYulo5sXGOI+WtB6jnq73E=;
 b=A3x3PZI8f4U/rjvmJkeGRmaZBhjf8Zv7W7TLBUjZmJEEMmqkNdA1POpKkTxKz5qV3OWRZIdX/8sqd5+55iUugwU1uPxxiQKlNoK1R2/lvmbBTiNaVHxnHYXsqcHiX8Yuy48/WzjGailU/WJfiHM5e0MrWh1r/7Id0W8LpQJKRL6rg3jkSWUsW8j0AH2p5uw0UTSARG4RNR9EpTc1sdI2KbxNctbeMHLt0vLeAfMjDlF1SZmjPra/Iwx5P4CBaarZfpZWznVmfdp4/o+PM0JccUYXpPMongWZi+VQz9zJ5BDDonm0uUDAZXcagwdJXfwCjdKWMZx063CVUKAMngY4XQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EC/YOvm5+54jIbSVBX1GTTYulo5sXGOI+WtB6jnq73E=;
 b=UeAQHCc84Tr/+lDs/ceVU52tl2i3pYbkjjpZy8nkIbVZDAG+sypj1cAH1PirxcD/slWzqtCrEmcdYRHxoMJPzeh7ielG/JJwnsJ8lt4xflew8wPsDK6OHF+p8dd17V/Sxdyq+pl7rSH8dLwQlgFDxJWx8bk8pTenw6OteXaJdP4=
Received: from CH0PR04CA0083.namprd04.prod.outlook.com (2603:10b6:610:74::28)
 by DS3PR12MB999241.namprd12.prod.outlook.com (2603:10b6:8:38e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Wed, 8 Jul 2026
 21:23:26 +0000
Received: from CH2PEPF0000013F.namprd02.prod.outlook.com
 (2603:10b6:610:74:cafe::73) by CH0PR04CA0083.outlook.office365.com
 (2603:10b6:610:74::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.10 via Frontend Transport; Wed, 8
 Jul 2026 21:23:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF0000013F.mail.protection.outlook.com (10.167.244.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Wed, 8 Jul 2026 21:23:25 +0000
Received: from amd.rund-run.pensando.io (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 8 Jul
 2026 16:23:24 -0500
From: "Nikhil P. Rao" <nikhil.rao@amd.com>
To: <netdev@vger.kernel.org>
CC: <kuba@kernel.org>, <brett.creeley@amd.com>, <eric.joyner@amd.com>,
	<andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<pabeni@redhat.com>, <jacob.e.keller@intel.com>, "Nikhil P. Rao"
	<nikhil.rao@amd.com>, Vamsi Atluri <Vamsi.Atluri@amd.com>
Subject: [PATCH 6/6] pds_core: add debugfs support for host backed memory
Date: Wed, 8 Jul 2026 21:22:22 +0000
Message-ID: <20260708212222.296202-7-nikhil.rao@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260708212222.296202-1-nikhil.rao@amd.com>
References: <20260708212222.296202-1-nikhil.rao@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013F:EE_|DS3PR12MB999241:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f2595a4-bfc2-4fe7-7da0-08dedd372571
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|23010399003|36860700016|22082099003|56012099006|6133799003|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info:
	CE4DM3C6eq3vnGS1bEP90PWkL1zh4GHFUzm/QtsZ2Jeq5/bT2bquZULasZFKDb7CxwLBIncAQJBesewH0Jszwh5OcGRwCvohOLTusjK6bPqWErgkl1MWOv3wheP7kEevprUJJVf9j7gLnTR7X8gcQmQhy6Ehi1YtVH1k5gTpknxbHppOM9ngRUeXd4mrZAedpkqTeBXCm865AiujHzrjeA0AiR0/S1v0a7bAh/1oOfSKO29nVjudcRKM34iQIVFv2lVu9qgD+OdiFFpU6+7Wnya5UhL1oDOjFKVND7HLsrTpqTev9iQVOeCn1oeqemCqohPHAUOTMwdEpcS0TZlo2hFPu8CVwZfJFXJkIsstVFgMEg8+HulaYTB5xrgQVVogttG4X9YM6qe6JqZXx8JVjtM93N/6AtpepDhTi0HQaPObNQp01PZK1LIyUI5zHYftt8MkXxfVpbAAcXMYA1xV3v+hDISuZbEQvozXLwcFSUP3OP95c39y/bdneJclJPwVirz9N1Ow76T5AZUM7S6G08gNctOGZCZpA1+kFBH9xgeZ2UwBkljs3gVcmKLA4QBQ293H2wxwVc7t9PEuFuz0UJH3BeBcAaJdZ5tA5gqPWcMZOOEb0ybf7xEBkwxxdZ2Hsmx8+d0C7k2uM9GlsW0YVJVnr+1gNOOOHj22Laru3LIrMUaBMO57Ed47xC1moHgJwTuyQ4HK6i0A89z++Ckt4A==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(23010399003)(36860700016)(22082099003)(56012099006)(6133799003)(11063799006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	r8oSWhwFNIqcIAbty4rG9RB4X8ZSnLzf1O/pcDF9hMbiYKaATVcdpS3N2mdANDPLnEMRWBegr43Cjs5VxNSnt50lJ5Pc5jMludsC/cnxtEQow8Cn4UfRmrWe7X9TMsTS3IN5Fc9zAQqamj+2vrXiFstNAojEveYENXyqeIblQVWLfagvaF65xPFJCt1bAl7ovC6aTl/qUkZALozTtawtvBwBJZKXq5gLtwO+V8viQxIoQFbh6nGVdyVkL4iULe4xMYlrFhPzWwJbo+qvLUgc/F1g+TxNo/gzYBSXziZ1ABjRvRy5Evxb2DHRrPnrRN6AGw3W5AKpePJF2zHlSkLzsnI7NB8kOT8i1ZBT3U7Vi9OsMSg1XiQDrt9a6VJTY2myCvTYzpxcfxKVGhZt5NIte86s71JPYXhfpiUybVmQ2arkVxNkTLYwGGWZ7dKYXrK8
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2026 21:23:25.3776
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f2595a4-bfc2-4fe7-7da0-08dedd372571
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000013F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS3PR12MB999241
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[nikhil.rao@amd.com,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-305996-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:kuba@kernel.org,m:brett.creeley@amd.com,m:eric.joyner@amd.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:jacob.e.keller@intel.com,m:nikhil.rao@amd.com,m:Vamsi.Atluri@amd.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nikhil.rao@amd.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[amd.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,amd.com:from_mime,amd.com:email,amd.com:mid,amd.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E8A5E72A80D

Add debugfs entry to dump host backed memory allocations for debug
purposes.

Assisted-by: Claude:claude-opus-4.6
Signed-off-by: Vamsi Atluri <Vamsi.Atluri@amd.com>
Signed-off-by: Nikhil P. Rao <nikhil.rao@amd.com>
---
 drivers/net/ethernet/amd/pds_core/core.c    |  2 +
 drivers/net/ethernet/amd/pds_core/core.h    |  1 +
 drivers/net/ethernet/amd/pds_core/debugfs.c | 45 +++++++++++++++++++++
 3 files changed, 48 insertions(+)

diff --git a/drivers/net/ethernet/amd/pds_core/core.c b/drivers/net/ethernet/amd/pds_core/core.c
index 356a69c895b6..d4857bf4860d 100644
--- a/drivers/net/ethernet/amd/pds_core/core.c
+++ b/drivers/net/ethernet/amd/pds_core/core.c
@@ -500,6 +500,7 @@ void pdsc_teardown(struct pdsc *pdsc, bool removing)
 		pdsc->viftype_status = NULL;
 	}
 
+	pdsc_debugfs_del_host_mem(pdsc);
 	pdsc_host_mem_free(pdsc);
 	pdsc_dev_uninit(pdsc);
 
@@ -511,6 +512,7 @@ int pdsc_start(struct pdsc *pdsc)
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


