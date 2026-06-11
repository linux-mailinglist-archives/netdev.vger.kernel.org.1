Return-Path: <netdev+bounces-298192-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id y96QCI3dKmqOyQMAu9opvQ
	(envelope-from <netdev+bounces-298192-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 18:08:45 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6605167351D
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 18:08:44 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=gb9yQpzN;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298192-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-298192-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B0686347002F
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 16:04:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EAB8403B06;
	Thu, 11 Jun 2026 16:04:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010057.outbound.protection.outlook.com [52.101.85.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F319402435;
	Thu, 11 Jun 2026 16:04:31 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781193873; cv=fail; b=tiD9VLnpVUuHggU+DsaLVM+8TkdZmZQHFxkq4AndNT1h9+Dx14RDUkEOqt1wNZEDtBKhDRjv4QCubVYypzxnMEhemdot8PhrOOHHJM1W1eLyhYwEVFmYkMlc3sD7bsRKsrirpIyf4jF1vMUFHS14jYE96bZVbTzaBZCzh3h7mqI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781193873; c=relaxed/simple;
	bh=qSWGtxWBjDOYD+4eo31jwwtBfZRkL9x//W5Qg08lyAM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=TEWE3/YhY2aCZ7hopjhx9lpkwikOSTvkj4AauZ4bP7DzFnZPD4uXH6fvkK32vbXPQ50ru1H5Upi+ApF+pztlA8R1V+wH2m4Za6QYlkoXuu+whbGw+28mJGLIWuuHAUzy7Y8i0bGztq5rvVaSCJXntIyxCdp/YLIgfjbXqTGL4hw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=gb9yQpzN; arc=fail smtp.client-ip=52.101.85.57
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=crPdlhgULSNnsx1qhqaz2piAPllOlx3vuH+pgp9YodJ5cekz/LvV2vYnGQTf3se/XA8ei4apItNmgOeyhsGKJUf9LbbLYYK+e+60wTJP5T+dMPo1OBAro+S6tUiYXeZt7tPjmpYKpR/d2yf6tCgY+BV5usmA+5kxqzGdr+wfrJ39uqaQMpKlmdalqSOx47Vte+/4h5xn6edtfwgfnWiHVKdoX+FmhJOf0zAFBXuWfsL2z2+SIYfhu/6Zq9nOj3Jgvg1AVuiD5c3Z+xRY6p3cu3WiqAxIWIOUZTMUFTxo0uWiW0Md1r02fqvuMFthF0pwdwsoUhF5H4nXo74GsV1DLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cZJVNujgelR+RCgk52sdThfyjW6r5M90sUiO+HylEZ4=;
 b=vjsLVWyBH7eEKhTvdGqfeEEAkeKpkUejNXSOC/1NVZ7lFbamoFcL6NPVIMyv35ZHYuge5/d6K+J//VRVNlYJ4Dufh1kkUXXbBO75CMnVIalQ9NJK9EXnsdCc0+fywUDn0OnUdTxW/A92TuEy/m+W2YmsZ9w/N10eytiD7+9tNjmqnxqxViMU1SamG06ZiOVVRC+mXNHHUXWxHBqYJdn6oc0HjIgOM/fEvYBNn76Sj8AiNeW/URkRP+TXCQkKz9SpTsu+EIcEWbIeh8y79cH3mXNNGG/z6Ge5bNuzYtVJAVJKzZnriPs7ImLotRtGfQ0jJUtYhAhrll43F8hW5Al8mQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=lunn.ch smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cZJVNujgelR+RCgk52sdThfyjW6r5M90sUiO+HylEZ4=;
 b=gb9yQpzN4ptWjby/DBAHFwFOUO6mshUVWzrDOFdl5oMIV0iM1TWIXLdyZN746Pg46Bv/r0DF5CciqZaQl8mZiBrue6eIMiarpB4yiXfiwWdyDanhM2+SR6/DGWDvCnjnfv/37WzIIUMNYK5ymFLv/i6NiaXgs0K7mdxBsoPoPL3g2ZK91Arlif65+HXjvAczkqpIzZTlN6IRbWKiVWA4vVT/63lV0AJnHP/odpA0Rt+q8iippBxFUsiwsNNNZqSbC1OpNwb9quOiDy388mLzyS9OwlesjLPZB9lx6EMnxh3PQ6AIMcaDh8vj53xgmvMpLkJj3DQbagmV8fJUXswXzQ==
Received: from CH0PR03CA0355.namprd03.prod.outlook.com (2603:10b6:610:11a::12)
 by CY8PR12MB7490.namprd12.prod.outlook.com (2603:10b6:930:91::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.18; Thu, 11 Jun
 2026 16:04:28 +0000
Received: from CH3PEPF0000000A.namprd04.prod.outlook.com
 (2603:10b6:610:11a:cafe::a5) by CH0PR03CA0355.outlook.office365.com
 (2603:10b6:610:11a::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.14 via Frontend Transport; Thu,
 11 Jun 2026 16:04:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH3PEPF0000000A.mail.protection.outlook.com (10.167.244.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Thu, 11 Jun 2026 16:04:28 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 11 Jun
 2026 09:04:07 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 11 Jun
 2026 09:04:07 -0700
Received: from f43.com (10.127.8.9) by mail.nvidia.com (10.129.68.6) with
 Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Thu, 11 Jun
 2026 09:04:03 -0700
From: Dragos Tatulea <dtatulea@nvidia.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Shuah Khan
	<shuah@kernel.org>, David Wei <dw@davidwei.uk>, Jens Axboe <axboe@kernel.dk>
CC: <dtatulea@nvidia.com>, Cosmin Ratiu <cratiu@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH net] selftests: iou-zcrx: defer listen() until after zcrx setup
Date: Thu, 11 Jun 2026 19:03:41 +0300
Message-ID: <20260611160341.3697227-2-dtatulea@nvidia.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000A:EE_|CY8PR12MB7490:EE_
X-MS-Office365-Filtering-Correlation-Id: d12e2eb9-8a21-4a61-6be7-08dec7d31db7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|376014|82310400026|36860700016|7416014|6133799003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	PFR1+QX0K57uP8wO5qJm/CiuUSgqqEcDUfMDHIDUfSzv4Y7AwO/6/qLVhpJJIdUWki8IxL0MXBCj2WY7J4aOiJtP0AtaS3t6k3KfUSMwhtC7E3DEZwz43OF+nxmuhxv+NkIzbhnt43P5uLOMRNCACi7YpJbKmbwa9jrceMCtP+8arDmAqMIzIYpBcRX9eZVj1bgb9ZKj2rtVyGpxd2VXoJEgHlhXlP38FIaBwuWH27OiwKNFxAauBTaksXtzL0suwz/jSQvyb+813SB2rlg3ZCBVfVPtGlCFdA7YtHu4RlZvhoX27OPrPcDdfUqUjZoPQS+YzPOfvM7vH8z2Gm349AUK0LpGa+q++QuDsO3KzyVR2zs1dIBru8srBxWVVgQ3uIomVn41uI4gq4z4VryDpbV8pGIa+9uQ+5uncbxL8213a4Ujm6EiU+OX6IR2vW/jT3L/3HA2anhpg2rbOVJfarNCQbAb7VjFD7MvM5/TPH9M6gYENT4hHT/ZiqVuOzXpgTji7TbzAstgNhWautxUsr6ri0hLRWbCEHr1HyC1mibCT0xlKdkcc7kqEY6wx3ihGAjjAtgxpSJ6Z419hs/OXg1cjmlSRLh521R2xbtzbD66XOTxcGPClVM23J1eWRTGLTM4mhjDBN4grPfGj/L3YXcArl0InjdynV0eqUpFP2ypptf4hfOY9CMhk8kAC0rtH9Di+nM7bckCrh2m5lVQaPTUoKpewIQkT0y/OQiMll8=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(82310400026)(36860700016)(7416014)(6133799003)(18002099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	VnyJPD+RqfiTdMMlAtE1xwzVUytnyQT/8HA+iA33QwYEIdoCHh/0sjVoH5Pp8+lZwuXwoY1ottPUIDpMulDnUTF9BX2ZPqn1oB95CyiI6Z9hC4RAuNY3bDItMkyoWu6kFAQH7iEkp0Fwdz/kifZzhI01ZQdu9VdnKhiPOTUtNz3TlwNmp74Makzk0Nl4ZaCOX+wXmAXziJ4pzyWT8WBkcXX3Z4eel5ObVL/3v2Qs/NEzZQ3gKcMB8cNJ5QDwdzHNarGA6J8t1fkDU3t6JaGeQzc7na20bNIUK9lCWxJk0qDX9NI/o5A9oQ224P0NEBdarvz+l8JJKHHv5mwHCT8KxynK8BT7yVF4N84Kkh13cvPVI5wO/z3+Paf8EUnFJMI5MoqNdBWkfyJvyiJzNzxCZKSANqcKAYfexBD8dRC544q6s1aRiBXn8KtTAV1bVn9E
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2026 16:04:28.2236
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d12e2eb9-8a21-4a61-6be7-08dec7d31db7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF0000000A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7490
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.16 / 15.00];
	WHITELIST_DMARC(-7.00)[nvidia.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-298192-lists,netdev=lfdr.de];
	FORGED_SENDER(0.00)[dtatulea@nvidia.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:shuah@kernel.org,m:dw@davidwei.uk,m:axboe@kernel.dk,m:dtatulea@nvidia.com,m:cratiu@nvidia.com,m:netdev@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dtatulea@nvidia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,nvidia.com:mid,nvidia.com:from_mime,Nvidia.com:dkim,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6605167351D

The server binds the queues for zero-copy after listen(). If the client
does a connect() during this time it can fail with EHOSTUNREACH on
a cold system. This was encountered with the mlx5 driver where binding
the .ndo_queue_start() is a slow operation during which no packets
can be exchanged.

This change moves listen() after queue binding, when the test server is
fully operational.

Fixes: 71082faa2c64 ("io_uring/zcrx: add selftest")
Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
---
 tools/testing/selftests/drivers/net/hw/iou-zcrx.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/hw/iou-zcrx.c b/tools/testing/selftests/drivers/net/hw/iou-zcrx.c
index 240d13dbc54e..f6a8fc5fac24 100644
--- a/tools/testing/selftests/drivers/net/hw/iou-zcrx.c
+++ b/tools/testing/selftests/drivers/net/hw/iou-zcrx.c
@@ -351,9 +351,6 @@ static void run_server(void)
 	if (ret < 0)
 		error(1, 0, "bind()");
 
-	if (listen(fd, 1024) < 0)
-		error(1, 0, "listen()");
-
 	flags |= IORING_SETUP_COOP_TASKRUN;
 	flags |= IORING_SETUP_SINGLE_ISSUER;
 	flags |= IORING_SETUP_DEFER_TASKRUN;
@@ -366,6 +363,9 @@ static void run_server(void)
 	if (cfg_dry_run)
 		return;
 
+	if (listen(fd, 1024) < 0)
+		error(1, 0, "listen()");
+
 	add_accept(&ring, fd);
 
 	tstop = gettimeofday_ms() + 5000;
-- 
2.54.0


