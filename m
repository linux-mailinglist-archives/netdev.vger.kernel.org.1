Return-Path: <netdev+bounces-299272-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id JQTVB+wUL2r97gQAu9opvQ
	(envelope-from <netdev+bounces-299272-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 14 Jun 2026 22:54:04 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 70FD668238D
	for <lists+netdev@lfdr.de>; Sun, 14 Jun 2026 22:54:03 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=amd.com header.s=selector1 header.b=czganMZc;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299272-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-299272-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=amd.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 12793300B118
	for <lists+netdev@lfdr.de>; Sun, 14 Jun 2026 20:53:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33DD03290D1;
	Sun, 14 Jun 2026 20:53:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011011.outbound.protection.outlook.com [52.101.52.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D59123033D6
	for <netdev@vger.kernel.org>; Sun, 14 Jun 2026 20:53:30 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781470412; cv=fail; b=jFV10CqbBl5KNKQw6uR3xQ/3NKHRp8rcq3l5n7bj4xgfnCXhwIn6IcDdYRboJQQsekQ2ih0VHlwCovfMTyGJjQ0CtoY/mB5s3Q3bB2637lRRnNs7zeM66PoiJM+F5T800ztAOq5ipJt9bkWaLRwh3H59XGCa9ID1DPrBPN6hYwY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781470412; c=relaxed/simple;
	bh=lhARjXRu1aetvYk+IcXLXWnyg3fyZ86eSsDvevbGiOo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hMpLVuLDvIm1xcadSGKlfEirQG1XRWIk8oLf+i5vILqc+Qicc/mKx5cB01MG6DVFxvhuYYp9evreQhS9KgGdQKfA8DSkqodehJR9vhxqftbpOfSi+gY059EmkTUicctNn7k9Yz3pCP2yvAdeHCi/YbBlGp0FaM0lZCuQBl0F6To=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=czganMZc; arc=fail smtp.client-ip=52.101.52.11
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gTslvy9nAAvNM29QfkVWg9HnbLMxPQ6CqweylwIZjAD4JIWWUaEqKI/TWEZE2hSz4FulvBtz60WZ2KmQ7RLHOqObdBMkkiEcsR0Da1ORrqMCY2BqYTMN34udWfoTYhGt9wlJCcALOwveEDJmdPkA3NuRkw3ZJH01d9tBke2gXl1w8qPjnsn8WuTagvKL1KAtk26/K4V8NKF1JViz3xasu8KZkvPBmDX4n0mgdXmsrmJgSO7LnzJyxGGiZyjLrCkS5I4Sl94x0gbMtshD1SYJOIHeJjfrDeP3HoF7ry3yqs437K/jGmlrbrpiN4jMLdQ0ayI0ssm7TuqRQkiyfqEEtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BkvWXpIS0mq+qE4VNVfukAwZdPtGHRLAJV8+2ePyzF0=;
 b=LoAqmiECZEe8ZGvokYTfzYa4VarP1ll+XLIXCZipwEg2NzYDOHr+FKSYFsmX10sO1bas3yrCYw9GXGssflo3ykNCORYcFwMQhxknY4lzoNGQ8it/TP67WW7P7+sF6emeYjubnZYSeOc/LXFH/Mbf3SjdMRPyYjun2DqvCDntafxjS+UoKt+SsG7ICxrhgRpR9yxfp9Etdm/UGZjxNrw04V77m6ghXtfMCaKgDFt6/Zmq0+OWthh0M4VfxTggmqD0P3iZagWMRCoDWlzH3Vw8RqbJAdhPzn7A89DY9q1s5lZ8t8G26Pm8nZ4ghJTCU27UfyBT6cGUtsFoFS7M5NY70w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BkvWXpIS0mq+qE4VNVfukAwZdPtGHRLAJV8+2ePyzF0=;
 b=czganMZcXk5/cT6w8q6DJkSdPG2N0h8+xj1SF1XGR+WQOZk1DUOHByImU9FfBurj49drFrP1mw4XSeCMdi3586VSnzRMlK2iUIZs3X44yYEVg1BovNfjvIeiC7+BzbpLwn2/D7n71UFfrMg0yITEoocCML9lt8b6t/vouVUPAnQ=
Received: from SJ0PR05CA0085.namprd05.prod.outlook.com (2603:10b6:a03:332::30)
 by CH3PR12MB7714.namprd12.prod.outlook.com (2603:10b6:610:14e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Sun, 14 Jun
 2026 20:53:25 +0000
Received: from CO1PEPF000066ED.namprd05.prod.outlook.com
 (2603:10b6:a03:332:cafe::71) by SJ0PR05CA0085.outlook.office365.com
 (2603:10b6:a03:332::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.11 via Frontend Transport; Sun,
 14 Jun 2026 20:53:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF000066ED.mail.protection.outlook.com (10.167.249.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.8 via Frontend Transport; Sun, 14 Jun 2026 20:53:25 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Sun, 14 Jun
 2026 15:53:23 -0500
From: Eric Joyner <eric.joyner@amd.com>
To: <netdev@vger.kernel.org>
CC: Brett Creeley <brett.creeley@amd.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Eric Joyner <eric.joyner@amd.com>, "Nikhil P . Rao"
	<nikhil.rao@amd.com>, Simon Horman <horms@kernel.org>
Subject: [PATCH net-next v5 1/5] ionic: Fix check in ionic_get_link_ext_stats
Date: Sun, 14 Jun 2026 13:52:59 -0700
Message-ID: <20260614205303.48088-2-eric.joyner@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20260614205303.48088-1-eric.joyner@amd.com>
References: <20260614205303.48088-1-eric.joyner@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000066ED:EE_|CH3PR12MB7714:EE_
X-MS-Office365-Filtering-Correlation-Id: 74173321-481b-4f4f-a560-08deca56fa7d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|82310400026|1800799024|23010399003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	g3kPErly4DL0Xu+plUQCTDTe2Av9vFGjfFTbArSHArTUf3u+ScOc6VCJR8LUZfI+M4tO0VcuG3IJBX3AQSfEeqrox+ZxabO6HXyLZF/SA8GhtxrR0CWawZEXyNNhZxUYQX47eQhoZ0UrrbdPiW3HUsgvQtlcbLs6XWotARVboYcnlXwVuhihEqYEu+UOUtUqp+CQCmdf0KceIN6CfIbDBimfR6ogbUWxiwF6rHAey/gvBD6Lil8+X5n3VWmN7V+Alm40VACEeyMHVfTALQmAkjeTAmyP1F5Fe0DM1QpMxBfibKHts0tHCeU517fE7FQX5x9dWPnb6EZMt8p7BChhnKtGeTwDFz3tCrwVuE6Fwp42Io4XOn0/91cLpmOSUZCX9p95FUhVb2hbNtkQIGDMHW7jE/89rJl1ZOqISULK9t9XMTAbDRVN1ZXaCs/x5kkzgtkKP/PARGaqNXDvBoyYZvfHsbF98zMCZPtGH1Y59rWSBJsGr+xkXo5ew7xmx+SdF5hqQbYz8apZS/svyPFRx7o/9At8v4/7igoL3Z+kBye/zVU6Vq0kAT8UmGWaaMbC2De0NET5eV2ezZkisCDBNJGv8IMIawJJycLHXyNFr1JvAXR9+qr0/F1ZX9E23HIj/ccxjCjupKL6d21i8iD4cYj6gsM8hI0MSC3zefgcXaq1T5a4rsWZK7+Yc8n/L+4fbXLzNUopzBdL61uMCmx6UPO0lGE8cUXqZijHmo0arOc=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(376014)(82310400026)(1800799024)(23010399003)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	ggk5FQqJq57ZFGE2OZPQxROT+rAcQlH0e2EWv0IVp/hcWaRNc6qjAER0SehbCAQdMa65Z+fYUCfxxtSXfDsYt84gktFfPt7o2I7Gvazg+gZeyu/2+jPBeC5SnM7k9Pvhw3NPpJRvsW3paiaPItLiIeZYCh8gy7kWYQ6+wt15Rqg37Cxo4onHjrdTuM+JDoXxVDa+vCvVe8erytRVD+ku8nNyot1JGapLxfu/qFpXzoTEf8NW+kfhFtDgraHEq3TF5zQ8KYJNmT2ZkKkFbBeyMFhEJZOxqEnbGgi3zV6nhBEN6P6dt8fwkyS/uUbxJBEuzycZqMIkib//hJzN8r+IBUMX9c7x6fypHLVBJOReV4Erd6FD/nPkhjSUCxZWQV9Jf3gWluR2QbbJhagqCSsRh0iVMOm7CxhAg/dmepqUFUiR4zfk03+nU5HudMwPVGC1
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2026 20:53:25.0377
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 74173321-481b-4f4f-a560-08deca56fa7d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000066ED.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7714
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
	FORGED_SENDER(0.00)[eric.joyner@amd.com,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-299272-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:brett.creeley@amd.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:eric.joyner@amd.com,m:nikhil.rao@amd.com,m:horms@kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[eric.joyner@amd.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[amd.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,amd.com:dkim,amd.com:email,amd.com:mid,amd.com:from_mime];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 70FD668238D

From: Brett Creeley <brett.creeley@amd.com>

The current check will fail if SR-IOV is not initialized for the
physical function; this is because is_physfn is 0 if sriov_init() isn't
run or fails. Change the check that prevents getting the link down count
to use is_virtfn instead so that VFs don't get this functionality, which
was the original intent.

Fixes: 132b4ebfa090 ("ionic: add support for ethtool extended stat link_down_count")
Signed-off-by: Brett Creeley <brett.creeley@amd.com>
Signed-off-by: Eric Joyner <eric.joyner@amd.com>
---
 drivers/net/ethernet/pensando/ionic/ionic_ethtool.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/pensando/ionic/ionic_ethtool.c b/drivers/net/ethernet/pensando/ionic/ionic_ethtool.c
index 78a802eb159f..6069fa460913 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_ethtool.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_ethtool.c
@@ -116,8 +116,15 @@ static void ionic_get_link_ext_stats(struct net_device *netdev,
 {
 	struct ionic_lif *lif = netdev_priv(netdev);
 
-	if (lif->ionic->pdev->is_physfn)
-		stats->link_down_events = lif->link_down_count;
+	if (lif->ionic->pdev->is_virtfn)
+		return;
+
+	if (!lif->ionic->idev.port_info) {
+		netdev_err_once(netdev, "port_info not initialized\n");
+		return;
+	}
+
+	stats->link_down_events = lif->link_down_count;
 }
 
 static int ionic_get_link_ksettings(struct net_device *netdev,
-- 
2.17.1


