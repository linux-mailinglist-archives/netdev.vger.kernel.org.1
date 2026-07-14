Return-Path: <netdev+bounces-307598-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id dNzME+ipVmqe/wAAu9opvQ
	(envelope-from <netdev+bounces-307598-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 23:28:08 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id BA928758FCB
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 23:28:07 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=amd.com header.s=selector1 header.b=ums0t175;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307598-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-307598-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=amd.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 93C3D300D92B
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 21:27:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A142B427FB7;
	Tue, 14 Jul 2026 21:27:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012007.outbound.protection.outlook.com [40.93.195.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A7F541A931
	for <netdev@vger.kernel.org>; Tue, 14 Jul 2026 21:27:49 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784064471; cv=fail; b=PdHqzJNyUDUD7Susg72I+2agd0dnGxrQdR72Jxf5YXfbVmRqWvco+09n1sDEJzT3cUo92ZLZ7o6nZUN+2XOYD35XTD5ETlQ8J9HWJBQj7F5pGfYGUv+2t355KEy6thtph5C/loUOzl945zzlb+koOthhIbgS9gi4J1TlTdXwam0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784064471; c=relaxed/simple;
	bh=Kr0ABOsOKMfCD/wra5emIVTbPdFXdfCvegprZ4FProM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=TKTzEXDLP+QAqRwRPx+J3MS15Va6hQaoaRfNHVujUkvRnXk2gPTMXXiZlk+KLaO6YyJ64jtZhct6sX9qudENjjE+EtKJF9QSrQHtqpUk8bi95+7xBHFP1iI49DVge15MfUQvNM7g38EnKwEBXK8N+yBWcz0ESDEytl7bYp+f++Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ums0t175; arc=fail smtp.client-ip=40.93.195.7
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bX4ufPev8TEctdwT+0O1kaTWyTMgVu5pjF+nh/FuM8/sR2yriLE6Rc/iXxUbJ/gW2cQYOnmrCXUDpMsav98oyv4IUrKVdimSE6+zvjQSY/20bfHIQSvhOZK8h8LTFiHhS/6InAWShGzyGQI1rEZXA/YI9qH0uxaN+RaAbJvPKsu/Qh+27m4QfvXXPLooPIiJKmv3R/F3m08NxcOxVnHFLx+knXeVWuc7v4/kqCmG7PwthCzbOUxGM3aaQRSZCfx7xOW+2t7qoW4aMTfVfCYPQ1nWnmoUS60W50zfoaMFfg/TbTSF+JNMSr3ZvDGrUBGxP5gKXrrGqfEiNRLIFdrB3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mCnWck0OCGzua6GjCKljZRNxtKV8W9BDqJ5kkL2Kffg=;
 b=B8Rl4SV00B4vzDH7ZuX6RhfqQZ8skoFGKR3xxSmy8B2b3u1DKcRUEhqS8fpljOKFWPubFfK3DWMcVKWqOIsq2iadUyaHHQsXM5Sq99c09YsTIFOxtMZIsAJWGYsxe6jq0hqBmKa0coQ4gNWf0FmoPwV+Wjtbnvayq8U9OsW0aW5g/RaVY4Dsm5oySpsZUUtgLxmERfkVn9Vz1mLI4cSsrW1IB0QFxfa4aN2fa7lZ3V/orTEDHT61ksa83tONwBIix10jvD2TkbZlijK7LUGd8b284tmNv+KIoTNRrDshXMvTqYxkg5+o9YwIuvbEFSfcZGvvprX64L7OQNgk2hs2RA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mCnWck0OCGzua6GjCKljZRNxtKV8W9BDqJ5kkL2Kffg=;
 b=ums0t175uOO7hGSub0SyJhsQGa1SgixYhrsYnvIy9oD461eK+tXVWNUG6FMBO32k3czxIU07xHD34X5aUNq5CFe3moylFQbFNR/KgrsrUi0kMY4s+d0zhmQpNpzy8j0hnS9sZhCmT1E7P0gNJhN+JMwO512Z/093Kysl01H2hmo=
Received: from CH5PR03CA0004.namprd03.prod.outlook.com (2603:10b6:610:1f1::6)
 by DM4PR12MB6037.namprd12.prod.outlook.com (2603:10b6:8:b0::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.9; Tue, 14 Jul
 2026 21:27:39 +0000
Received: from CH3PEPF0000000D.namprd04.prod.outlook.com
 (2603:10b6:610:1f1:cafe::1a) by CH5PR03CA0004.outlook.office365.com
 (2603:10b6:610:1f1::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.10 via Frontend Transport; Tue,
 14 Jul 2026 21:27:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH3PEPF0000000D.mail.protection.outlook.com (10.167.244.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.9 via Frontend Transport; Tue, 14 Jul 2026 21:27:39 +0000
Received: from amd.rund-run.pensando.io (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 14 Jul
 2026 16:27:38 -0500
From: "Nikhil P. Rao" <nikhil.rao@amd.com>
To: <netdev@vger.kernel.org>
CC: <kuba@kernel.org>, <brett.creeley@amd.com>, <eric.joyner@amd.com>,
	<andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<pabeni@redhat.com>, "Nikhil P. Rao" <nikhil.rao@amd.com>
Subject: [PATCH net] pds_core: check for workqueue allocation failure
Date: Tue, 14 Jul 2026 21:27:13 +0000
Message-ID: <20260714212713.1788438-1-nikhil.rao@amd.com>
X-Mailer: git-send-email 2.43.0
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
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000D:EE_|DM4PR12MB6037:EE_
X-MS-Office365-Filtering-Correlation-Id: 40368249-98be-444a-11a9-08dee1eebb47
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|36860700016|82310400026|376014|13003099007|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	TAf6dORqsFdR5qcxFfCPsl/syBq3TEtJtpamYypXX5NzT5I1+u10RpQupgrBjfKfItgruNsSt17bJtUyFPUp1rpfLSho/HP9+6PodxGhv6eGAIgAUFZ9rbDqJ87AivtwSJM4uy/9yxn3FXGs/4BtqpDldtuLYQtfDkFDNM7dagGKILD5tCGS0zCBaWb7OXdxLlgLzl2xkCCrqWO1tqB6oo5SnXxWSVSrNd8rCNKS7Zm94AJCeeF8AfxE6u6wUuO2DxH5b3aYVPwv6rZh1AYZ2Ub9uEmtwDYvxJiQFlH5pkpqeh1yjNzEe4bLzwqnBHH2sINlkE45AdWJQR54x12B6jNUL4MmVl/Tc3MX/ndo2VamVSIl0pqA+kVrRCuJ++Mu1FVqrz3R3ljOXcysUzxwtA5cmYDbwHwjxx6kidWX6iIvND2x1rJVhCrBE4hO4WP0AZ5faRSt3PfkLjjxwZsX2MdG9VW2Z6mSonIhlgf0GB+Q8Wv6LRfncFEg0NC3B7naXVXmg6OSdk0Qm4NtxaOqSRRH8/EB7EK+IXrxerxxjYNX2RyQYofrTz98rendVpWStMyRFPi4Vn/wMANF1m62tG859meAzDvBpuLRK5PUjDzm1GMx+Tt1YJ+mpmVBdN8k2QAXT1QnMDWfDzJ+SyjjSQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(36860700016)(82310400026)(376014)(13003099007)(18002099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	E0ddvO4zpB56ohh+Jy6S5HBPWQJFZi8y3P1ZOlA55JPPq/euHTFdOLuxu5tg5jxe4U5lXTTLiuSLrQw8NpSikutAkXl1DC/Wg3EP7jYFyZLJlJzfQqEQoQVdddTOc8NDBm7k5oDwc0tKCbqrq0UCWyYpMHpg7UcUrDSrZv9x6UXfCmwz36pAWXBFoFk7OuNaPS9miq8zBkb3D1zUbLPnAJ2WTp3kd6wKrjsR/uNP9cZSt9LBuPYUeY30iPzxm+YfJ3ejBUgocTPmSHdUvZ+t5SPbSf8wYv/H2uMYZktT+z7+YpKTxl9v9pPwTuK/quK3IaGa3sH2lzbzQLWb85tsxIW9QhNTd9zkGqqpvGCUc8mVGE7xVR8q3Ui260pK3BCOHTKgjDjO42jOtuazssg4NUygFXj9PrJenJLmQWB2JcCS9lVp4Qh4Oab4ZMlcq81z
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2026 21:27:39.3104
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 40368249-98be-444a-11a9-08dee1eebb47
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF0000000D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6037
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
	TAGGED_FROM(0.00)[bounces-307598-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:kuba@kernel.org,m:brett.creeley@amd.com,m:eric.joyner@amd.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:nikhil.rao@amd.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nikhil.rao@amd.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[amd.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp,sashiko.dev:url,amd.com:from_mime,amd.com:mid,amd.com:email,amd.com:dkim];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BA928758FCB

pdsc_init_pf() does not check whether create_singlethread_workqueue()
succeeded.

Fail probe on failure. The workqueue is set up before the timer and
mutexes, so its failure path must unwind only the earlier setup.

Fixes: c2dbb0904310 ("pds_core: health timer and workqueue")
Reported-by: sashiko-bot <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/patchset/20260629200358.2626129-1-nikhil.rao%40amd.com?part=2
Signed-off-by: Nikhil P. Rao <nikhil.rao@amd.com>
Reviewed-by: Brett Creeley <brett.creeley@amd.com>
---
 drivers/net/ethernet/amd/pds_core/main.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/amd/pds_core/main.c b/drivers/net/ethernet/amd/pds_core/main.c
index 22db78343eb0..f37e5fefa264 100644
--- a/drivers/net/ethernet/amd/pds_core/main.c
+++ b/drivers/net/ethernet/amd/pds_core/main.c
@@ -238,6 +238,10 @@ static int pdsc_init_pf(struct pdsc *pdsc)
 	/* General workqueue and timer, but don't start timer yet */
 	snprintf(wq_name, sizeof(wq_name), "%s.%d", PDS_CORE_DRV_NAME, pdsc->uid);
 	pdsc->wq = create_singlethread_workqueue(wq_name);
+	if (!pdsc->wq) {
+		err = -ENOMEM;
+		goto err_out_unmap_bars;
+	}
 	INIT_WORK(&pdsc->health_work, pdsc_health_thread);
 	INIT_WORK(&pdsc->pci_reset_work, pdsc_pci_reset_thread);
 	timer_setup(&pdsc->wdtimer, pdsc_wdtimer_cb, 0);
@@ -253,7 +257,7 @@ static int pdsc_init_pf(struct pdsc *pdsc)
 	err = pdsc_setup(pdsc, PDSC_SETUP_INIT);
 	if (err) {
 		mutex_unlock(&pdsc->config_lock);
-		goto err_out_unmap_bars;
+		goto err_out_shutdown_timer;
 	}
 
 	err = pdsc_start(pdsc);
@@ -305,13 +309,14 @@ static int pdsc_init_pf(struct pdsc *pdsc)
 	pdsc_stop(pdsc);
 err_out_teardown:
 	pdsc_teardown(pdsc, PDSC_TEARDOWN_REMOVING);
-err_out_unmap_bars:
+err_out_shutdown_timer:
 	timer_shutdown_sync(&pdsc->wdtimer);
 	if (pdsc->wq)
 		destroy_workqueue(pdsc->wq);
 	mutex_destroy(&pdsc->config_lock);
 	mutex_destroy(&pdsc->devcmd_lock);
 	pci_free_irq_vectors(pdsc->pdev);
+err_out_unmap_bars:
 	pdsc_unmap_bars(pdsc);
 err_out_release_regions:
 	pci_release_regions(pdsc->pdev);
-- 
2.43.0


