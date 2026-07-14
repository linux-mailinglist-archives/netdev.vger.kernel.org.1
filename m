Return-Path: <netdev+bounces-307553-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Xd5tLap8Vmrn7AAAu9opvQ
	(envelope-from <netdev+bounces-307553-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 20:15:06 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B616757C6A
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 20:15:06 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=amd.com header.s=selector1 header.b=Rv8kAF1i;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307553-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-307553-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=amd.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7E0AF300DDF6
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 18:10:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5180B3CAA55;
	Tue, 14 Jul 2026 18:10:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010050.outbound.protection.outlook.com [40.93.198.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6FDF27707
	for <netdev@vger.kernel.org>; Tue, 14 Jul 2026 18:10:36 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784052638; cv=fail; b=rwx3iShQkZyw3NSywmhnoHuLLc8YuxMXAHYHViZtyAfG/JUwL34RI14ol1lzQPVvfkbP4n09InV53wLYajfTGGkmDF1qCbKh6YPvdmI2uF7QdX3DBCeQrAFLBmSsURTGKTQtvFmgikzdU6712IMnbRCHts38cEuuYKcMgSw7fpw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784052638; c=relaxed/simple;
	bh=v8Cm+IacPtBg83ynlz/pwk45RMVlXY0s8QsqsuunKY4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SqmHXTHxDK76kPqLPxYBSLprO52jUvSeiZ/WvtDsSRhUULouEdFLizLan2SolCd/Pmcgd8Ap9tqneAr+QrpbSc1rh5x1+mxy3PkIQ7aJKYaH50aruL0xzas63UNw9ZEes73fqze+TBxDomudecGsnphNwi68BTYzpE8MP2CYAOg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Rv8kAF1i; arc=fail smtp.client-ip=40.93.198.50
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZkSD0JGRBKTSI6edE9GGWj2wQDlevszPqVngU0l/F2ybWvMRS2ci44T1/ZBj3812jqls2AIJsuEXbctMY5H/6kCmNJAySV2icMQ4uBjU3tVu4dkPTQ2EMRCDmc28gMewLeZIE3YHT5iocqShpBZH1SzYUNejlygao65mRvG0Jp9Tm3QTh557ZjRKqUzVM2xSLyEJ7hAVDE6QCLMzQ6fIUhm5h5u6VBQ8V3iOJKSwNDi12nKedFPZzADL1Es9eQj3Yq0RkWwOAMNwucjdhcDLvVsTNhc6ECx/jzo8Og52vA9cJYTDlSsBJWF9aMFI/qthVs5MNLRpPgMmeLg0oScGHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HqIvGbirhQHo+FlAJjmBTx4Voh0D9QZhpcPcny3Vs6I=;
 b=VNkJr3tV98uiyJTmM26QAs0DWg3wZpQXN1SFtTLfKCiOrfXCU2TkBGO4Acxrlgc5enlRxYQrMkEojL3do3rMAaJ58sMoN8wLY86k9aF51I8INpLdKVRKTRkJ6zB9pjuJDWRXDS0s7uO+c5/RMk9z8W86b7mRkjxvYT6+JKqxIgHWuIwB+mVOwEVObbFCHOCQ718JGb67f2S8VAwhlElgIffg62OAhJNtoG37QSgzPvtUunB2QsZtsw5OxngNKdeTQhva7KN3A32Ii45mag7Xsq9JLOtuNdX8+pz/XyyRP2XFlDMSexlbQ2YBqos9Y03zHWeSdPG+Scq3hS5bbvNn2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HqIvGbirhQHo+FlAJjmBTx4Voh0D9QZhpcPcny3Vs6I=;
 b=Rv8kAF1i+6bjfg4ap0Z8MvgiUBTKLVJWOAgcMNH4oaguwyTG1yxDUPFkBeYy3O1gVVOmk8KvNG1lyaJLntDXB3RL2HYc0CbZ6oNXkGK90h2z61tslRsUQN11yII0wNcSSChHnPhInWfG/wT+iSg9xOpGOnQroXc40/umg8Y23I0=
Received: from SJ0PR13CA0037.namprd13.prod.outlook.com (2603:10b6:a03:2c2::12)
 by DS4PR12MB999099.namprd12.prod.outlook.com (2603:10b6:8:2fd::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.19; Tue, 14 Jul
 2026 18:10:33 +0000
Received: from SJ1PEPF00002323.namprd03.prod.outlook.com
 (2603:10b6:a03:2c2:cafe::59) by SJ0PR13CA0037.outlook.office365.com
 (2603:10b6:a03:2c2::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.10 via Frontend Transport; Tue,
 14 Jul 2026 18:10:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00002323.mail.protection.outlook.com (10.167.242.85) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.9 via Frontend Transport; Tue, 14 Jul 2026 18:10:33 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 14 Jul
 2026 13:10:32 -0500
Received: from amd.rund-run.pensando.io (10.180.168.240) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 14 Jul
 2026 11:03:18 -0700
From: "Nikhil P. Rao" <nikhil.rao@amd.com>
To: <netdev@vger.kernel.org>
CC: <kuba@kernel.org>, <brett.creeley@amd.com>, <eric.joyner@amd.com>,
	<andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<pabeni@redhat.com>, "Nikhil P. Rao" <nikhil.rao@amd.com>
Subject: [PATCH net v3 2/2] pds_core: fix use-after-free on workqueue during remove
Date: Tue, 14 Jul 2026 18:02:23 +0000
Message-ID: <20260714180223.1642792-3-nikhil.rao@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260714180223.1642792-1-nikhil.rao@amd.com>
References: <20260714180223.1642792-1-nikhil.rao@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb09.amd.com
 (10.181.42.218)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002323:EE_|DS4PR12MB999099:EE_
X-MS-Office365-Filtering-Correlation-Id: 070ae054-3b26-4a8f-a960-08dee1d33260
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|23010399003|376014|82310400026|1800799024|13003099007|6133799003|18002099003|22082099003|11063799006|3023799007|56012099006;
X-Microsoft-Antispam-Message-Info:
	ux11s5wHbHvfs+io0wGko9NL2Fpkx3X+v/bqaz7y/D+sS5aOmxpw/CiV6vZQzg6dgnuFuU309Zwkj4VfcHgfyeBnhBYvTu2MV80ews/PuPwMjplcuUn30Nj+9+LInqSZpT8V+rKXsZgEojYG91a22DCFaZyrGg+iVhC8MP6Q+qt1geLzg+UiVPnW/dlw4DdW2OcK3Kj0J1agJjZrzACjL0WXU6+qQ2m8RrM/Sf/aQFDAqr01xpVNkX1pxSqQrGovkVi71qv3GqaTGu5yzLfjEQ3Oto2DAoTZEuJQj7YkKspgjgjVHdXoAaJQAbKRqX2xr5TzAJx2/2dCNhSch03o/uAP0il4OAioGxlnLF4khW46OFXt8XxI2pJ03j52HqtZu7VNTRomhwcdQCTFiO2LmrYh0Ag4WZZL95ZkVH52gYmy69Am9/sBiIXVAQzVgGy+QjPJgoQDlObPPzE9zO4YrnChHbFL+c5ODZeE3pzlCo8VwKl8sbSPHnNUFkqMei6f1CZE5bHZJBoMbwdzloDno62Dh7t3GCK6chZXy1HILgGqSzvy7pa6cCjeF0Uqf5puD9zAxLs/iESFf9OpwekZGeMGyCRm0TNpKXgC+/KypvYl3nlxDxCIzvDpd9Yzw8VirgoU5uV1bR4UnqrYhXoG5NGQesYgP4S8m8x6psPFanprsxsKbfuCLWwp0eUrS638VErJ74K7XBQcTHW1iYPiew==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(23010399003)(376014)(82310400026)(1800799024)(13003099007)(6133799003)(18002099003)(22082099003)(11063799006)(3023799007)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	ksAE5SZLHshl90yJvH5/+1o7hlsaGVV+eTS7Kxj2Oyh2O774UEbqjcgWiRcQv2O7vtOELBdSQ7dj+EgHoVaXmkoTU6MBZOx0zoKXWutn/nbfRzj2fbwP9dpsMc0oL80JMkY6Esa0ea1WKSzhUIoy9h/IMJZW0+zzjxfjXHtrVvwaHlJC3fl7EenA8/UnJyiTry73oTN5at7Lr/KTPy7aXFQTuO0wNmOnyQHlYgUphMB9RIn2A/An2CTMo6CGUFo2ttFnDal0HTxbytJMNO81okKLFLVk/BB+gtk0kQAeqdjfb8GFq925ErA7v8NHk6UitIT5msBTvYAzOn61S4DfdqXeRCGYKqLNYFlwUl2QVWlTNBwQSriKelO7Ul5bhdhea9j61x/SfqQOB7j9W5ZVQEFKu05KTkYdeIvIDyoMKNMpm50NDq4frU4jBAJBhuz/
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2026 18:10:33.1733
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 070ae054-3b26-4a8f-a960-08dee1d33260
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002323.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB999099
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
	FORGED_SENDER(0.00)[nikhil.rao@amd.com,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-307553-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:kuba@kernel.org,m:brett.creeley@amd.com,m:eric.joyner@amd.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:nikhil.rao@amd.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nikhil.rao@amd.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[amd.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,amd.com:from_mime,amd.com:mid,amd.com:email,amd.com:dkim];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3B616757C6A

In pdsc_remove(), the workqueue is destroyed before pdsc_teardown()
is called. This ordering allows two paths to queue work on the
destroyed workqueue:

1. If pdsc_teardown() -> pdsc_devcmd_reset() times out, the error
   path in pdsc_devcmd_locked() queues health_work.

2. A NotifyQ event can trigger the ISR and queue work before free_irq()
   is called in pdsc_teardown().

Fix by moving destroy_workqueue() after pdsc_teardown() so the
workqueue outlives every queuer; destroy_workqueue() then flushes any
work still pending.

Draining the queued work also requires ordering the teardown so the
resources that work touches are freed last:

  - In pdsc_qcq_free(), after freeing the interrupt, cancel_work_sync()
    the queue's work and only then clear qcq->intx, so
    pdsc_process_adminq()'s read of qcq->intx for interrupt-credit
    return cannot race with the clear.

  - Free adminqcq before notifyqcq: the shared adminq ISR is released
    when adminqcq is freed, and the adminq work accesses notifyqcq, so
    both must be stopped before notifyqcq is freed.

Fixes: 01ba61b55b20 ("pds_core: Add adminq processing and commands")
Reported-by: sashiko-bot <sashiko-bot@kernel.org>
Closes: https://patchwork.kernel.org/comment/27002369/
Signed-off-by: Nikhil P. Rao <nikhil.rao@amd.com>
---
 drivers/net/ethernet/amd/pds_core/core.c | 14 ++++++++++----
 drivers/net/ethernet/amd/pds_core/main.c |  5 +++--
 2 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/amd/pds_core/core.c b/drivers/net/ethernet/amd/pds_core/core.c
index 1074a022a52f..e39b2c9beb20 100644
--- a/drivers/net/ethernet/amd/pds_core/core.c
+++ b/drivers/net/ethernet/amd/pds_core/core.c
@@ -110,7 +110,6 @@ static void pdsc_qcq_intr_free(struct pdsc *pdsc, struct pdsc_qcq *qcq)
 		return;
 
 	pdsc_intr_free(pdsc, qcq->intx);
-	qcq->intx = PDS_CORE_INTR_INDEX_NOT_ASSIGNED;
 }
 
 static int pdsc_qcq_intr_alloc(struct pdsc *pdsc, struct pdsc_qcq *qcq)
@@ -145,6 +144,12 @@ void pdsc_qcq_free(struct pdsc *pdsc, struct pdsc_qcq *qcq)
 
 	pdsc_qcq_intr_free(pdsc, qcq);
 
+	/* Drain any work queued by ISR before it was freed above */
+	if (qcq->work.func)
+		cancel_work_sync(&qcq->work);
+
+	qcq->intx = PDS_CORE_INTR_INDEX_NOT_ASSIGNED;
+
 	if (qcq->q_base)
 		dma_free_coherent(dev, qcq->q_size,
 				  qcq->q_base, qcq->q_base_pa);
@@ -304,8 +309,11 @@ int pdsc_qcq_alloc(struct pdsc *pdsc, unsigned int type, unsigned int index,
 
 static void pdsc_core_uninit(struct pdsc *pdsc)
 {
-	pdsc_qcq_free(pdsc, &pdsc->notifyqcq);
+	/* Free adminqcq first: its work accesses notifyqcq, so we must
+	 * disable its IRQ and drain its work before freeing notifyqcq.
+	 */
 	pdsc_qcq_free(pdsc, &pdsc->adminqcq);
+	pdsc_qcq_free(pdsc, &pdsc->notifyqcq);
 
 	if (pdsc->kern_dbpage) {
 		iounmap(pdsc->kern_dbpage);
@@ -479,8 +487,6 @@ void pdsc_teardown(struct pdsc *pdsc, bool removing)
 {
 	if (!pdsc->pdev->is_virtfn)
 		pdsc_devcmd_reset(pdsc);
-	if (pdsc->adminqcq.work.func)
-		cancel_work_sync(&pdsc->adminqcq.work);
 
 	pci_clear_master(pdsc->pdev);
 
diff --git a/drivers/net/ethernet/amd/pds_core/main.c b/drivers/net/ethernet/amd/pds_core/main.c
index 22db78343eb0..638b9c7a509d 100644
--- a/drivers/net/ethernet/amd/pds_core/main.c
+++ b/drivers/net/ethernet/amd/pds_core/main.c
@@ -435,8 +435,6 @@ static void pdsc_remove(struct pci_dev *pdev)
 		pdsc_auxbus_dev_del(pdsc, pdsc, &pdsc->padev);
 
 		timer_shutdown_sync(&pdsc->wdtimer);
-		if (pdsc->wq)
-			destroy_workqueue(pdsc->wq);
 
 		mutex_lock(&pdsc->config_lock);
 		set_bit(PDSC_S_STOPPING_DRIVER, &pdsc->state);
@@ -444,6 +442,9 @@ static void pdsc_remove(struct pci_dev *pdev)
 		pdsc_stop(pdsc);
 		pdsc_teardown(pdsc, PDSC_TEARDOWN_REMOVING);
 		mutex_unlock(&pdsc->config_lock);
+
+		if (pdsc->wq)
+			destroy_workqueue(pdsc->wq);
 		mutex_destroy(&pdsc->config_lock);
 		mutex_destroy(&pdsc->devcmd_lock);
 
-- 
2.43.0


