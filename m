Return-Path: <netdev+bounces-307555-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id J7gdOcJ7Vmrw6wAAu9opvQ
	(envelope-from <netdev+bounces-307555-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 20:11:14 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DDE5757C01
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 20:11:14 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=amd.com header.s=selector1 header.b=4vLwxnzN;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307555-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-307555-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=amd.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id BC2ED3010F70
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 18:10:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E93A3CBE6D;
	Tue, 14 Jul 2026 18:10:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010008.outbound.protection.outlook.com [40.93.198.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B6B23CAA55
	for <netdev@vger.kernel.org>; Tue, 14 Jul 2026 18:10:43 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784052644; cv=fail; b=H4EQnvEkMc/4AfKrSFam84oc+QNSq44E2laco9bchWijNgnfphw+vpwjSZuTPIVlwPefJWxTbypv5MOZ/xK4Mg3XZ2exj5ua+/v4MlUyQ85q317hc6HZAa/mOK5KzpoafTZNhKc0muWLBdOyNhGA5HEB5Zl1DL5oI23GBQVmbgc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784052644; c=relaxed/simple;
	bh=ptHj9H9SL0BDTsenqCTl1ApesExIrbdQYQYtoOwwqg8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZSrcpAJSJt8eSgFc3VH+GzmzjPch/V3NHi9I0tDjrQlymMOxlSanFIxTQWKpvff+fuDhFr6eLWYjV7O0+reIVI+cDS/RDzkMc0nl2FCrhiHZbCLAi8C+3uN7dYzQuQSxNhnKZjQZibEHYHKmJVniwdHTcARItQammNK2mK+OVeY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=4vLwxnzN; arc=fail smtp.client-ip=40.93.198.8
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fsgjKawyfPQe2oT9M0KhU3wFJ2HwBDi6aKH0HWvlMUW3ehMczWR+Bhc4BlGtqJCUST5FJ36LwMg5TLkv8Uf8LRBgCLA+8Ad3iQklC4T89H075GEO1oZ1qNP1i1U/SJ3J3xfyOQYx8ygyCr5WJGQnoilH/dotbv9Xc9FZfTCyKVsCQyHuJt1gZQs0UsNmtNQyv9YsKbo74u+RxwkrQHOeGJVZWBNuiSfUUE+nr0KETaw/0Ph7Yw++iPClTRYHQ4MHaQ7B3n5HhPyXR+EfEHmmGYSFgtCWcmPAHrM+eCmQmtJw2NjPhkkHbAnduUltV+hFpEj+oIJpHBLTWLl2cPsbTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hW92L4UNVXt6qkZr7d5A/gNr282nkX/uZWSR6kdeKmw=;
 b=oD84E8EoP0OJrm4v1OPXsgoGaS9G2qIAQ33TxnYeDh2LgmUFrJT6+5dQERpzYwDq1FqN40w2IGHhV+2Lt0Ib4HgKK3MCRlCa8lPo9G9xlSBvQwVX/rPcllKve+pV7TWKPT4g7mIEl3GX1JzTqrErPREhh1yFCYus++Z619R0ywPgDdUcTx1QzcS6DeJ+R4IaCpdDyENPa2YLV6ruyYwrPHQQu/LHNDemYl0gns5abLeOD40BW4HabH8wwX/pxyTnBL2A4GnUv0lrSjxVOo6JjjllKOSWs9m3NBcX6VREaTl6irAyhh8Ylho+r5veGDczjsPzkxTNvwDCG2l7um3N2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hW92L4UNVXt6qkZr7d5A/gNr282nkX/uZWSR6kdeKmw=;
 b=4vLwxnzN7c3GyzykYxEjSe/RDaP10XNWlpxbR32XBUldLXlVRLzUZ5qJ5FuIhlZu3M84+VUVXs1zESHadszWUeoA8RGCAR3OBc1vhPmhlAur4PVaD9yrv82/OqrTtKR6nkDqS6ZVtiW449m20U+UHdaPo10SUjXFoVv1BzYvLgU=
Received: from MN2PR11CA0029.namprd11.prod.outlook.com (2603:10b6:208:23b::34)
 by SJ0PR12MB6782.namprd12.prod.outlook.com (2603:10b6:a03:44d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.19; Tue, 14 Jul
 2026 18:10:37 +0000
Received: from BN2PEPF00004FBF.namprd04.prod.outlook.com
 (2603:10b6:208:23b:cafe::2b) by MN2PR11CA0029.outlook.office365.com
 (2603:10b6:208:23b::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.9 via Frontend Transport; Tue, 14
 Jul 2026 18:10:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN2PEPF00004FBF.mail.protection.outlook.com (10.167.243.185) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.9 via Frontend Transport; Tue, 14 Jul 2026 18:10:35 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 14 Jul
 2026 13:10:32 -0500
Received: from amd.rund-run.pensando.io (10.180.168.240) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 14 Jul
 2026 11:03:17 -0700
From: "Nikhil P. Rao" <nikhil.rao@amd.com>
To: <netdev@vger.kernel.org>
CC: <kuba@kernel.org>, <brett.creeley@amd.com>, <eric.joyner@amd.com>,
	<andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<pabeni@redhat.com>, "Nikhil P. Rao" <nikhil.rao@amd.com>
Subject: [PATCH net v3 1/2] pds_core: fix deadlock between reset thread and remove
Date: Tue, 14 Jul 2026 18:02:22 +0000
Message-ID: <20260714180223.1642792-2-nikhil.rao@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBF:EE_|SJ0PR12MB6782:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b327131-f3de-4783-5dc2-08dee1d333c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|23010399003|36860700016|22082099003|18002099003|13003099007|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	xvt9sslvqM12mxhugbqM5ZOYDsGdNU/B1/JNDtyY7qkR861Pp6bZn9ZOBl0ieRHZTzI28HtxjrABx0C89FWQ+M4esh5mPKU9+QG/l/Qx8wMuDgRpP05ea2iJ/RRXuYV/ZR1QkqQnj5QzEMYPLfvR6shuBFgl5+71Cjm+GlczKSgQWDit1eWK2XRmDWIomw1ZakKPdQOlhW/+foAPipULsDNJLxCJj1fEjZo+RzmQYVUeCyZCIOLAE2+ZZul6aayqW+5cDpVqkhFerY0TE/VJeIxaZJuQXjT/mOEIkZfUltGWUxb35K/HVGh50lY8GMr8vzk/+P5xrLxnsGwvNHERPiL1K5xHc0bKr8R+l0pe0WmBMVh1ilmdWVBeGeLcrNA9FnTIFYbkaLznIUQYP3F6OUh3Tfgw9T/E/tkhkIzKqiCjiwdMcXHj38OFBzrB9/FJvPyV5Mz8jgzFbX0dlv/29s1E79J4S3NwN/ijWD13Mi2IjNG/Obrel72cS4ZOOeK15Mo1VGNwyqxTcsWz9K5GUexqCRgGpiUJSkllyfFTtdcEqlsnRWgFs+LWOgrpFikGPxgG4ZMGONL4M2HYS9eP3gevm2VCZIukUfv7XB97jXD+8vgBUWxhHZo7R2Re81d4apvGqmeilFxG32vhPW8sbWeKS2Q2FZwFnV9RT1sI93W66cjEia8JnWn6cI731+9AnDJr6FGrpoeqB6kvQ0K78A==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(23010399003)(36860700016)(22082099003)(18002099003)(13003099007)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	ioBwlRzssoQUqjIPI+HoDQCpLXSRVfx2Ro07OcNI1hX7MrkRzwJEhob0Gm0vqOG7CUNoiVQgfmRP8219uCi28fyD6FwMVtYrCHYbQ2GS38vNukd8Jh/8hUZEdIbf+Ysh5FDNkUP6pcxYUhD+DlED5sLBMuJEyxjrQsOuXUz9U9I6S95Lifa32M07Xv8s1+vEJS1quE4m7FrFFGCCtCdqJNQEk/oHhs/Sm5gY5OVWhGyqal7Y8oSkZ4XwtKhIDpe6XqfBNGofnanhQSJHGyh+bMQg1qe02l/xJ0roxr5uQ03Z/C+rhdfv0okMmKPSAVlGV8dpKNjqE/Z7kF3sZ0xLvr9Tgtu9xdE32yeam+xVobw3qMtpfxtp20RP01WTLTS6rhEEzRqTvMt/tssYZx5y2ZwKLLvQJLU+5+M9/cky+YFVQRifKnfKAMLsz2c1zLb7
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2026 18:10:35.5872
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b327131-f3de-4783-5dc2-08dee1d333c8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF00004FBF.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6782
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[nikhil.rao@amd.com,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-307555-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:kuba@kernel.org,m:brett.creeley@amd.com,m:eric.joyner@amd.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:nikhil.rao@amd.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nikhil.rao@amd.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[amd.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vger.kernel.org:from_smtp];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0DDE5757C01

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
Reported-by: sashiko-bot <sashiko-bot@kernel.org>
Closes: https://patchwork.kernel.org/comment/27002369/
Signed-off-by: Nikhil P. Rao <nikhil.rao@amd.com>
Reviewed-by: Harshitha Ramamurthy <hramamurthy@google.com>
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


