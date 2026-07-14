Return-Path: <netdev+bounces-307554-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id QmguObR7Vmrl6wAAu9opvQ
	(envelope-from <netdev+bounces-307554-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 20:11:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DD6C0757BF6
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 20:10:59 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=amd.com header.s=selector1 header.b=Xf89kqd8;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307554-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-307554-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=amd.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 021293016AFB
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 18:10:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 152093CDBA5;
	Tue, 14 Jul 2026 18:10:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010008.outbound.protection.outlook.com [52.101.46.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D13F3CAA55
	for <netdev@vger.kernel.org>; Tue, 14 Jul 2026 18:10:40 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784052642; cv=fail; b=A730QQv8lyjDX88lubAy0qDTpeZugYjfxIqejGwu2/kJoGVlkt6prq1QreyqOdQ0ea6gBvBj6zkQe5ae3cPPmKi3/Aq5bwZ9vfpQJJrcLrOk5w2fh5umiecTKG2LB8gvREEiHlCSjsFStaCKBJAfn46B+kqA37ggukLtc+NF2uQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784052642; c=relaxed/simple;
	bh=1DC7PghA7a+Sd22UQKggMEwIzie0Jed523CvGyDL/mk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=b1G1BgmzwvmzHxkTMadj7mHV5r3zUyKRjA+dnpGBC6toFThMV4GHgEYBLvLTf4I/OD5igXp4gJZWY/FndN5B4mBHmRvdoDHvMfBu5Cy9hZk5yvLN9gGQtRQ4fcdtzFt/hYCs5Oiosq6LlqW6qWeT1oFcuji/UqlcM1bJnm5fg58=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Xf89kqd8; arc=fail smtp.client-ip=52.101.46.8
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UTigbjM7abNspOaQcs5pDooqjYaSHpieLCbdEgfB5GB0dyxQR8vPaYTEJvnAyCxDIWE+F4r0EVnVpz+JsD1jhQDAoyfkq9NA4le5g+j1z1ooiZWWxr3VVqGGfGDESUART1SQQhMMmNfqakj9Rq4Sjhw14jRenK2NshyMIdLvaTjSJTfktyHauMpZVHYWIyxrZ7dVG4WWFXxVzigJ4bmx5Rdih2ZJboxXlaAtj7ngjrc1FzP/KB3+NXNeBhpaDJfSjTdwo60PTYdwlnpg+IqPjJyB7SrqvJby9Y51S0G4Hx6CpQ2H4fP/KnP0VlzCitipK0g1ze2TLe1AYj/qllIjWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZSdRS7OJ+gtnJ2iIm6StYsmaNbnQdH6HkGQIDWFz25M=;
 b=aREBkKnN10RuY7AODQsQFdRUC34/w1BajAovbvfrVMBncKYYLJ79PMdFzRLQw/ZStpCrBOtxgrIfe7r4Piub1bZPzkwM3DzrfsdTeJ5xb24qDUtC7Ot4BMIMBEsP6DK4S5cbM/5/1voFyOGuhto2TkLu+QuB6NLfXfXuZ3iDxNRSvqmWYJrZfbI5mzjqfDT5qBSmOYpOPHrDK+rqZKOLwg8cKM9nCDeyFgivXa+QHZJnLStXxI0HOlsfO8p1sIq03m3NgHAgaDG5Py5Tm8s6U1ktbTKtVtgHDxq5eQ7cnJo6J2+SeS/VNNmAoivt81Osilfy7ha6aZxbVrinLG/zUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZSdRS7OJ+gtnJ2iIm6StYsmaNbnQdH6HkGQIDWFz25M=;
 b=Xf89kqd89adkn0P1rtAj4u7qoKJz+7RT9l2zHmEQ2vUH3usVgBOXfAAWJjHfD1w71ZtPOj9E05PxKkbwrYrCih0JXmYbubofbNlWsR74KATvblY4xn4nglxfdfZRDEFrkDZYiKytPosoeyBxaoI1oMkMPaCe3McTSqgVEIlSrWc=
Received: from SJ0PR03CA0189.namprd03.prod.outlook.com (2603:10b6:a03:2ef::14)
 by DS0PR12MB8043.namprd12.prod.outlook.com (2603:10b6:8:14d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.19; Tue, 14 Jul
 2026 18:10:33 +0000
Received: from SJ1PEPF00002326.namprd03.prod.outlook.com
 (2603:10b6:a03:2ef:cafe::83) by SJ0PR03CA0189.outlook.office365.com
 (2603:10b6:a03:2ef::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.19 via Frontend Transport; Tue,
 14 Jul 2026 18:10:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00002326.mail.protection.outlook.com (10.167.242.89) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.9 via Frontend Transport; Tue, 14 Jul 2026 18:10:33 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
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
Subject: [PATCH net v3 0/2] pds_core: fix use-after-free on workqueue during remove
Date: Tue, 14 Jul 2026 18:02:21 +0000
Message-ID: <20260714180223.1642792-1-nikhil.rao@amd.com>
X-Mailer: git-send-email 2.43.0
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002326:EE_|DS0PR12MB8043:EE_
X-MS-Office365-Filtering-Correlation-Id: 6241f826-5b64-4459-9aa9-08dee1d3324e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|23010399003|1800799024|376014|36860700016|11063799006|56012099006|13003099007|18002099003;
X-Microsoft-Antispam-Message-Info:
	Swu/F1zMWHtpGhm5Lc2iGDg8BcLPVFyVS0hojKTC+maok3hNxg4tuRNTqzzfjTie+Oc5h2L+8QR7ayWCuZmp+avBUqtHpnArwwD9oCj0EiHONG+M1zAKbMgVLmrx8uMjAMBYBe/n7wXqVf3bp99HeujHUV80truI73GxCpntFvr0GJp2ij3Ko9NHg04HWma63TmWeEo/MLsCcOXUgfh5M6+U3tPKxFO/mKan/5uyVhtlC2MdRcO4Y8fOvCgno023pF+r4Str+SJABK5nT+0llbeiSffF24owBDaSROslqN3bntVk+dhIbuuQPLVapRP0gaa5GkkEq0uTKh7g7OD+dHw6jR7YGRne3nNrp+vAe5AxJUFZOuUSCdG2Oqtf8/Y/YtCBAcjcb5icvoT4ud5ta//Vr0C6O4IaxsKTpl2gr9wm2GIjDaOr9eeNfaPfI9AXUG2k7xJ4vEh1lZ+T0CO3GjQQ6uY8Olrac05+rt3ZMJY/6H8I/Ok0zuFB4Ic1ncRsdq9e6le02+RMRCq3SLo77FJUmEBge2aKN3sncjNCs9Af7iSeyo9W2xasdtpyOHIKLn5V28zRcocT4O/FPLiY/Sudnqqs3VA1avSA8LKNnWzVTtg616zlHbhuaziC34k0vD6rWCHaoxYnHl3S0q2ZOdMV5hdOqw6bHDx6gpESggNWOJjGbepXp6UN5z9Lc1k2OR3ODha1Y1OojcXAgTTbgQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(23010399003)(1800799024)(376014)(36860700016)(11063799006)(56012099006)(13003099007)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	1tOFDAKugf6SusJbmlcKs/L6EtPwQP9eJCfjO9XHkDukzoFKnaA0FAVYC7+0oFwTu+KEAPr/sLjjCJwtwiw9JWqAa0NK56uK6MyzdIzOzOLLSlgVPNbmrokPPCwjpm1VZBi7K2eEQNbBci6j45iy2M+ymZVPrdDcqpqTZaFKR2Nd2L5daXrMsyQEJvmVU5kZquoyFExiyOHtVlSDQatJX3THuW9/VaBefQYbY8aFNnKdJSryl45WaexkKuAW0YVZv8hIq/y7ZTNFYRN827FA30EeUWj+0WRHg3unU1DBg6lY98qfYZSgUmljejDP20jcnH1Bn2aM2qjicqftu8IUDj3QCzpyshodkd4hHbp2V+RSRg7HGsIIe+VVXg14fRP3piY4g8E/R9c1nQ8UXX5lyWMbqENbKvfUvf3pQYTZd5RxQWGuwJefsZKk9xcZc10e
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2026 18:10:33.0812
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6241f826-5b64-4459-9aa9-08dee1d3324e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002326.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8043
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[nikhil.rao@amd.com,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-307554-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:kuba@kernel.org,m:brett.creeley@amd.com,m:eric.joyner@amd.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:nikhil.rao@amd.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nikhil.rao@amd.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[amd.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DD6C0757BF6

This series fixes a use-after-free on the workqueue during driver remove.

Patch 1 fixes a pre-existing deadlock between the PCI reset worker and
pdsc_remove() that was identified during review of v1.

Patch 2 is the reworked UAF fix that moves destroy_workqueue() after
pdsc_teardown() and adds proper work synchronization.

v3:
- Drop READ_ONCE(qcq->intx) in pdsc_process_adminq(); clear qcq->intx
  after cancel_work_sync() in pdsc_qcq_free() so the work path observes
  a stable value without the barrier (addresses Paolo's v2 comment).
  This removes the adminq.c change entirely.

v2:
- Fix deadlock between pci_reset_thread and remove (new patch 1/2)
  found by sashiko AI review of v1
- Rework UAF fix: move destroy_workqueue() after pdsc_teardown()
  instead of setting wq to NULL (addresses NULL deref found by sashiko)
- Add cancel_work_sync() after free_irq() to drain ISR-queued work
- Reorder adminqcq/notifyqcq freeing to avoid accessing freed notifyqcq

v2: https://lore.kernel.org/netdev/20260629200358.2626129-3-nikhil.rao@amd.com/
v1: https://lore.kernel.org/netdev/20260610025952.196470-1-nikhil.rao@amd.com/

Nikhil P. Rao (2):
  pds_core: fix deadlock between reset thread and remove
  pds_core: fix use-after-free on workqueue during remove

 drivers/net/ethernet/amd/pds_core/core.c | 21 ++++++++++++++-------
 drivers/net/ethernet/amd/pds_core/main.c |  5 +++--
 2 files changed, 17 insertions(+), 9 deletions(-)

--
2.43.0


