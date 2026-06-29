Return-Path: <netdev+bounces-302824-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id W/OKHODPQmqWDAoAu9opvQ
	(envelope-from <netdev+bounces-302824-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 22:04:48 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ECE46DE8C0
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 22:04:48 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=amd.com header.s=selector1 header.b=PNtN1iSl;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302824-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-302824-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=amd.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 60318301A297
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 20:04:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DF9C3438A1;
	Mon, 29 Jun 2026 20:04:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011033.outbound.protection.outlook.com [40.93.194.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7ABA34104B
	for <netdev@vger.kernel.org>; Mon, 29 Jun 2026 20:04:25 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782763467; cv=fail; b=j7Htg8xbl5v735Ndk28IR5ltlLNFO911+/zziiUTEpzjd9sZOvfKpAg0690QzWw4B8/X2KnCDCSMqdS54tas/xhSVOQebw5sZaH9rcTI1xv5D+Ns4W9FK/8i4Sssp17gTr5KBGoJNpvQhIhnjzcM0ick4pei8OliSoxd0CkTs58=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782763467; c=relaxed/simple;
	bh=Qkz6v5SiANY0eAgIFcDacRPI0pFgoJbWbYmEeMJPYEI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=grhOnM0z2bcLM1hlq2ssv4Tvdus3Dt55Yl+kt5Zi2hqFJAaVFa5ZtzKO0UNfeGKO2SB7G+cmCI5nk9XpaEJ6uxf4CsTKUty4X06DNl19SSXHoPKrHShjvZTVMaAee0JCPdHhD+lduO8o7Wl8xdICPiRQ+cVa6tnlNSC7aTcWlns=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=PNtN1iSl; arc=fail smtp.client-ip=40.93.194.33
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xd+dDBhYVRFgCXRnE7ue11BTSdZrUgdmP7wtwVjCqO5A61JvMfuz6vSTNBg3evS9oH72I65p3vRD9eFtg1mH8ye44HaqaadBzUIXA6yjauzOtfs7XkluUArZ3ZzgVR5pMo1XrQtDzADHZL4gYha8DV8s0nHNyOb556Vl5fchKIWlNVQ9hVPbs10Dg1wGUN5cE4vhCI6VTl+DYxeydwg7Ar9uBdZngJ8UIUOsuL+K7vhydLQzdkwlBO8RhnsK69ErTwMt2Vo9xt/RDPUYanWOTdQlXctbuVK1sw7NSAnl9y5mR17GWUTmdK1OR0TZHpGkCHjlXZFwYxNLk1+5cMSNZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k5QfjpN70LL8yddgCMlVAHx1/jutDglpO+BMJHps57o=;
 b=mOifWgRaOtUpU//x0ZGLcaK4s0YGDSdnAnK1dC8FnqwBmeTHj7daDIlNqdR7l64YvqKhKkbn8p/l6BMX4G7lEp2IbukeKe69dB/AKnYTGgFy1VlD/DuPi9Y8ZDmCiPSa2/IKraPd/AhwMNjzwsT5wqlYwHkruLFcdYgB8yu+IeivugrjaDi8ONNNDNkNGZ8/UrplssT5qTrOGWQEHBn2t31QN5SoaDTuSM5JCViOFBP9xsZaImR7yo9JYfyau1psFTq8upB51y7bX+Yz0cnexuODWADYgehTxyZ2nXlYNBTuGYoA6SeepMug3kvJd276fiG/yc/98/RpIOQwxQxc/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k5QfjpN70LL8yddgCMlVAHx1/jutDglpO+BMJHps57o=;
 b=PNtN1iSlBY6kw6UK6wQfw9F8F0z4nr5DC+2QwVTB1Qg2EYfoV4alsFqwmF6nhMWLui49H18ktWtIAT4B0v/3ucK3rqvtuUCVTv3cgqlvKWYoTyhG47Nj9a4Z3HFZkM1GxTiXyX9p3ejhVvT7llImpT22rremVoXqcAIkquFKDbw=
Received: from PH8PR05CA0006.namprd05.prod.outlook.com (2603:10b6:510:2cc::6)
 by IA1PR12MB7686.namprd12.prod.outlook.com (2603:10b6:208:422::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Mon, 29 Jun
 2026 20:04:19 +0000
Received: from SA2PEPF000015C8.namprd03.prod.outlook.com
 (2603:10b6:510:2cc:cafe::5) by PH8PR05CA0006.outlook.office365.com
 (2603:10b6:510:2cc::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.8 via Frontend Transport; Mon, 29
 Jun 2026 20:04:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF000015C8.mail.protection.outlook.com (10.167.241.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Mon, 29 Jun 2026 20:04:18 +0000
Received: from amd.rund-run.pensando.io (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 29 Jun
 2026 15:04:17 -0500
From: "Nikhil P. Rao" <nikhil.rao@amd.com>
To: <netdev@vger.kernel.org>
CC: <kuba@kernel.org>, <brett.creeley@amd.com>, <eric.joyner@amd.com>,
	<andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<pabeni@redhat.com>, "Nikhil P. Rao" <nikhil.rao@amd.com>
Subject: [PATCH net v2 1/2] pds_core: fix deadlock between reset thread and remove
Date: Mon, 29 Jun 2026 20:03:57 +0000
Message-ID: <20260629200358.2626129-2-nikhil.rao@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260629200358.2626129-1-nikhil.rao@amd.com>
References: <20260629200358.2626129-1-nikhil.rao@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C8:EE_|IA1PR12MB7686:EE_
X-MS-Office365-Filtering-Correlation-Id: 633b8486-553f-4cd2-20b6-08ded6199a4b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|23010399003|376014|82310400026|1800799024|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	zZ5enzGnLcRKDrZiR5HILJ3rpVVbP9S/Gy4iowaRLUR2TS7exh0mfiOjdDuZDgAfilGdxtf4+7QpnpzL2um+3YRi4/pdI5stQQSHH54mj+yT6hhAepaMHm8KecUSmKdFe+PH0ThTYlrnClqggTCPrq99N8n/2/Y9RIvOskgx0Y5aReN/aB2UdUKmleZNrE1ZcmhV2uY/fuwH5BU2fVhiviwzrH1PCtcNxboxcBORs3cHfSmuRKfUzoQFIjy7R0im+MgzmH9jaE1zvqFehJsQKd7bvt1LSh8WaIcwrutJHUWzBhaSpDYDd3IWR0IqMvihYooxLXpQGeR7tZt30DRwdI+hqtGMRUXL2WEG0rEUE9jse3tZEA3s/z8nUk8YXBs1bXcjIw0eoMHXUZmex3xgjvi7I3EUijnsbM7XHURvLQlfyZ4POrD5e19MPX7inREzZjmpJe+jaJgif7c1J+pX3w7TkyvcLwgBqYMfUdBLj744V+0cYHNTrwWeCtLjdLE3wl51C9uUS8V/IXYMf06pBncc1rhYnF2hNq81l+lrWuclz14PuILoW7/xnqBf1M2G+rzl8Bq9UMQewG3R82uW4fxdXDdSeYle85kBNSHhv1of9Q4HAnUDwpC8ydjmC348C01yFoVPsa3C/r+G+C8rDNgu+uKst3PZ9c7BpGpR6g56KS59sllUTJ0bktyEodAxfGSqdVYpPCZEExRcOaxuKg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(23010399003)(376014)(82310400026)(1800799024)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	cBx0cE3hQHTLtqIZD2GKY9YdgFwpmkApmNU17fsHU31uh7mOGCO8h/h6bQNo5rxzxePsRXd3kMBai1/Zpd96ugEnM8D5KGR1pHbYrQlysyBVMboOz7JS3JB+ALZp0HeBHIPMHv+UQQX8W3aWNuITU2lN3OPA0fZpc90J/rWEC0qtookktnYvCBz/R+sMqzil+cYb+QHj5NONziET4MB6w1jMpeOyv8RRzoeIG4pKoUkVh3lHkPiUy7VYUuIkbDMaH5+moGekW17AM1vcNw5vYBNT/tE5IJu8iwnM9cWAQ8VAWoT/RT25fIuYnb1ZDR4TPmLeDtxdYAVcEpQAfgYvdumeLhLrzdTab8OL0DNa80jhldgVnZjYSEwb/48Na299IyGYwWafFOIFQsLdZTiQnHEreuJxt78hRwdlIxW+ISkL5lqIkKWhjMT4/uLJMRKn
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2026 20:04:18.3958
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 633b8486-553f-4cd2-20b6-08ded6199a4b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF000015C8.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7686
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
	TAGGED_FROM(0.00)[bounces-302824-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:kuba@kernel.org,m:brett.creeley@amd.com,m:eric.joyner@amd.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:nikhil.rao@amd.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nikhil.rao@amd.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[amd.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,amd.com:dkim,amd.com:email,amd.com:mid,amd.com:from_mime,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1ECE46DE8C0

pci_reset_function() acquires device_lock before performing the reset.
pdsc_remove() is called by the PCI core with device_lock already held.
If pdsc_pci_reset_thread() is running when pdsc_remove() is called,
destroy_workqueue() will block waiting for the work to complete, while
the work is blocked waiting for device_lock - deadlock.

Use pci_try_reset_function() which uses pci_dev_trylock() internally.
This acquires both the device lock and the PCI config access lock
without blocking - if either lock is contended, it returns -EAGAIN
immediately. This avoids the deadlock while also ensuring proper
config space access serialization during the reset.

The pci_dev_get/put calls are also removed as they were unnecessary -
the driver-owned workqueue is destroyed in pdsc_remove(), guaranteeing
the work completes before remove returns. The PCI core holds its
reference to pci_dev throughout the entire unbind sequence.

Fixes: 81665adf25d2 ("pds_core: Fix pdsc_check_pci_health function to use work thread")
Reported-by: Sashiko AI Review <sashiko-bot@kernel.org>
Signed-off-by: Nikhil P. Rao <nikhil.rao@amd.com>
---
 drivers/net/ethernet/amd/pds_core/core.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/amd/pds_core/core.c b/drivers/net/ethernet/amd/pds_core/core.c
index 38a2446571af..1074a022a52f 100644
--- a/drivers/net/ethernet/amd/pds_core/core.c
+++ b/drivers/net/ethernet/amd/pds_core/core.c
@@ -606,9 +606,10 @@ void pdsc_pci_reset_thread(struct work_struct *work)
 	struct pdsc *pdsc = container_of(work, struct pdsc, pci_reset_work);
 	struct pci_dev *pdev = pdsc->pdev;
 
-	pci_dev_get(pdev);
-	pci_reset_function(pdev);
-	pci_dev_put(pdev);
+	/* Use try variant to avoid deadlock with pdsc_remove().
+	 * If lock is contended, the watchdog timer will retry.
+	 */
+	pci_try_reset_function(pdev);
 }
 
 static void pdsc_check_pci_health(struct pdsc *pdsc)
-- 
2.43.0


