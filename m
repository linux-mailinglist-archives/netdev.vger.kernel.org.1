Return-Path: <netdev+bounces-264841-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SMT6FobvqmncYwEAu9opvQ
	(envelope-from <netdev+bounces-264841-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 16:15:18 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C483A22398D
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 16:15:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 092C43073ABA
	for <lists+netdev@lfdr.de>; Fri,  6 Mar 2026 15:11:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86ED03AE1A5;
	Fri,  6 Mar 2026 15:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="WlLpkUHc"
X-Original-To: netdev@vger.kernel.org
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012062.outbound.protection.outlook.com [40.107.200.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AD713A9603
	for <netdev@vger.kernel.org>; Fri,  6 Mar 2026 15:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772809866; cv=fail; b=jhCmCc/inRe8F8hLn3xe+7r7U/khTzYLXsStAC9CzU0pHlxtjOgmQ/q0gKMvlwy+3TPq53SOSUu8v5SZBm0k3mHWxHi9R+VlH6cV47iN+/bLtp/Kz8WxQOziXeM0dPh9EjiE3HB81y/WCq6dF89PaxMia0ld/LVfIoK9B/nBT4I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772809866; c=relaxed/simple;
	bh=bFuelDGMC3W4/2rGcmcWqCKjLE2p6EEjq49LBrMHUSs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Cdkpq0vgt/n0JGRDlnBNbONfJ32+q51cqYt31mMK5b1YDOgNcbm4IIxC9Gupn2Md3ctWz1/CpydN/hCxnDGekyzGI0xbw7eSQJvgOf7uNCGrypCRufGdeLSlAQGZ2IIetio9q7kxYsZ5LvTh93y+xTjqyYsu1UzHw8THGuWyybU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=WlLpkUHc; arc=fail smtp.client-ip=40.107.200.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=erIXQNsT3d3haYh+qwU8mo8TlaOAwBXDDskvLivM0HigGyoCCQxpsbweDP/ej2gya2kn77h6X1adgmI7FwLokEd/2v/X9l9fLs9ZhGd48kVVvoBUzX7XG1RsE2V7gAqBJ1TkGRbNQY4kl/sTaiqAaU+DZ0Wacq3dhkxokDAwp9FkTj6JTdbY1IvNqoqMPn190eCitLVkOSC3QMaf/ePzQG8n+QduVf/1PHzgF6KAXLIzL38eixmc40bPBmLl1pGFI4HoCU79zzZsCFlwOzyGehKBO0hCAI2TZe1Jq+r2AxeuY9FmRIy7nt1J0mIGHI+eyraku6br0/nP7EKAB1iauw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7UgLDQKiBY9gm/lzoCHBJQtz6iqqTbdK7kgJZkWHQL4=;
 b=VLpfXBcKoxyTNVDW65RnQlSY3QfAo6B0kVvFiqpK4CYDwW7xh399O5BZUEhrCe3Sr53YUCDEGDkWs3VLDx7ImUhy/13K+/isD73dSvC+5RnlpRz6d9RfZt6Y/Y/PfanvJ0AZ+uXO5BtW7ynT183rZpFkYPcax503zsH6dhsAyt32j4h209+5lOTvGRpYaTzvnzp+2n72Cig89KVmVEljlSSrSATZVLdQzCRCErBfOQ/1hT+SDgjVP2kjj2N9w0IKETzx+s2a6xh9eDI7WAdsBrRmvhBsqZ72nYQIfrwmey85BMKUWJMauEc1UN4gVwtcQfXOKRU81R4fvqztT+8lFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7UgLDQKiBY9gm/lzoCHBJQtz6iqqTbdK7kgJZkWHQL4=;
 b=WlLpkUHchhaNsAc7rH76xIGM/QTeNc7J297HAJdwLIX0BTr3JmRiqRUvuqrL2achCDoLXq8dqjc0FgivFWEjHuOFbsY2SBN6QsRqdtO1/HBCfWJwvhzwEWnn/5lONsp+x7k9t0E4lorZl8DxRGWPTiBV899byQhGLXlA8QWjiVkK9qhZi1a0YDffcN6tanEEsp8/mxu7Km38eX6lOFQW4sEemUTzMpD8pvWH43cjOdsfaj+Uvzsewythc9w85z6Mu/0JK5ae0xLre9N8ziuL4Wej2AF4AHI6UTNp82sB2gX7zGnt1bylGLs67kbMwpEO03TO0J4d+Z5RUpXw6IcMlA==
Received: from SA1P222CA0084.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:35e::25)
 by IA1PR12MB7686.namprd12.prod.outlook.com (2603:10b6:208:422::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.17; Fri, 6 Mar
 2026 15:10:52 +0000
Received: from SN1PEPF00026369.namprd02.prod.outlook.com
 (2603:10b6:806:35e:cafe::c7) by SA1P222CA0084.outlook.office365.com
 (2603:10b6:806:35e::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.19 via Frontend Transport; Fri,
 6 Mar 2026 15:10:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SN1PEPF00026369.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Fri, 6 Mar 2026 15:10:51 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 6 Mar
 2026 07:10:28 -0800
Received: from c-237-113-240-247.mtl.labs.mlnx (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Fri, 6 Mar 2026 07:10:25 -0800
From: Cosmin Ratiu <cratiu@nvidia.com>
To: <netdev@vger.kernel.org>
CC: Sabrina Dubroca <sd@queasysnail.net>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Cosmin
 Ratiu" <cratiu@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>
Subject: [PATCH net v3 2/3] selftests: Add macsec offload VLAN tests
Date: Fri, 6 Mar 2026 17:10:03 +0200
Message-ID: <20260306151004.2862198-3-cratiu@nvidia.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260306151004.2862198-1-cratiu@nvidia.com>
References: <20260306151004.2862198-1-cratiu@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00026369:EE_|IA1PR12MB7686:EE_
X-MS-Office365-Filtering-Correlation-Id: 401a1890-0866-43e3-f5ea-08de7b928e56
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	nKNTrnK9kB+bcCPO1AG46RLQjzyvIE4g37EWPr2kj5G907rGYmniDM29p/RqQUzIu0sL7aYWoHthlKT6ES/T1a1f/4pxWyKSpvjj6NM2HEAw6xnKBymUikhu/8jgf4GGlda6oqeqzX7G3uVHMMllTSnaWNpWPyIMKaG5tGVsBio2Kgf98lPwEevt7aauR3CHm32XUEI4EUG7740VoEliYn9lVcEqHXK1pTfeZ7MLyYndFt/7RAtLWgI6B9GV6uUxsN6lsD4Q3Em3EACh1+t4SOmtBlPvakWSGMK/rUDApLJ0AHA4xokDNvQV3wQYksCEnUtFhthRKOv7vfB6HJzfF7zWXhxp7IBnT9TRI4f8n6pAUR+TelIo9EC8SxHjUhF8Hz3/QLLzd3Q7Au71Tkz9p1WSqd/6VncxUdLTLm5KA/ZvO6dXKeG3N4mHwHALTRAynus1/RKfKjwiDYwKgAQsRX0zV3GElAcsWiyr3AhzsikyYJvqBDDSP++k46iBvD+ZYj4Fa3mxZ3uA9zfE8CMKWMz8RLY+Ggl0FYln6MrhU1DOzGX6nYmZzvq/RqY2lNQqyIA0WT2ZZoT95Tc+a7HssMmfn2dhaeKycGhfQeL2TM/77ApXXlSRTkhguz/f9Z7zMfHoPRZ6enZWB6/xMmBjqf9xjw/uEOjKZx5tjNSz0PVMsEWStF020mgRwaMC4FsFAXbb6iyhcTdHuPaZ8bYzkRZ4BffOCGwQlosEgvNDuNH9l5pRDOY9PR7HJdeH8sXBn9z3RSFz6JiwMFS6zXz36w==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	kfkr7pfS277V3NLfjtsCEZmaByxWxsPGx3tEXE6PLEoVy+LRiMMrLgwuGW0nD1qRdvcpCphahqnQ3u/iC6XFUtFw96pJqEphE9bRHLkx3JjP9aS9sz2R71x60qcTTLjXKmtwZUVVsPsFU16GiGVpeTGvz/9c4klB2uRoQdNHI4EzYfvgLnUGbN9QNuAP4mzZpz7HxBq6umEFb2x4OmE+BZdJVulOhQtrCeWKdB/2XD7bVH9RBkovuCy4RFX/6rSCqvdgWBiF1Tvzv71JNalePDoSIvQZ1u3IF6ItSnNdqnozpB+iV8JROUW4MSrZuz5HEBrfpsjqR9IkacS3wiMNQdXF2hNlKHs4DKURHBWrzTQ9JzyoK9JsOk0tPfwIj0vQewAOiylmCN7Wh+NUkRg+67sd0mZNFnl2zMpovre3d49sfatTxaIYxe+wAAFHqYT5
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2026 15:10:51.5141
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 401a1890-0866-43e3-f5ea-08de7b928e56
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00026369.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7686
X-Rspamd-Queue-Id: C483A22398D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-264841-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,nvidia.com:mid,nvidia.com:email];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cratiu@nvidia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-0.996];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Action: no action

Add macsec offload VLAN tests using the netsim VLAN support just added.
VLAN support is now required for these tests.

Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
---
 .../selftests/drivers/net/netdevsim/config    |  1 +
 .../drivers/net/netdevsim/ethtool-common.sh   |  5 +-
 .../drivers/net/netdevsim/macsec-offload.sh   | 59 +++++++++++++++++++
 3 files changed, 63 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/netdevsim/config b/tools/testing/selftests/drivers/net/netdevsim/config
index 5117c78ddf0a..4a3922c59c09 100644
--- a/tools/testing/selftests/drivers/net/netdevsim/config
+++ b/tools/testing/selftests/drivers/net/netdevsim/config
@@ -8,4 +8,5 @@ CONFIG_NET_SCH_MULTIQ=y
 CONFIG_NET_SCH_PRIO=y
 CONFIG_PSAMPLE=y
 CONFIG_PTP_1588_CLOCK_MOCK=y
+CONFIG_VLAN_8021Q=y
 CONFIG_VXLAN=m
diff --git a/tools/testing/selftests/drivers/net/netdevsim/ethtool-common.sh b/tools/testing/selftests/drivers/net/netdevsim/ethtool-common.sh
index 80160579e0cc..b80b88240883 100644
--- a/tools/testing/selftests/drivers/net/netdevsim/ethtool-common.sh
+++ b/tools/testing/selftests/drivers/net/netdevsim/ethtool-common.sh
@@ -30,16 +30,17 @@ function check {
 
     if [ $code $cop 0 ]; then
 	((num_errors++))
-	return
+	return 1
     fi
 
     if [ "$str" != "$exp_str"  ]; then
 	echo -e "Expected: '$exp_str', got '$str'"
 	((num_errors++))
-	return
+	return 1
     fi
 
     ((num_passes++))
+    return 0
 }
 
 function make_netdev {
diff --git a/tools/testing/selftests/drivers/net/netdevsim/macsec-offload.sh b/tools/testing/selftests/drivers/net/netdevsim/macsec-offload.sh
index 98033e6667d2..c4af47eec9fa 100755
--- a/tools/testing/selftests/drivers/net/netdevsim/macsec-offload.sh
+++ b/tools/testing/selftests/drivers/net/netdevsim/macsec-offload.sh
@@ -108,6 +108,65 @@ TMP_FEATS_ON_3="$(ethtool -k $MACSEC_NETDEV)"
 check $?
 
 
+ip link del $MACSEC_NETDEV
+
+
+#
+# test VLAN filter propagation through macsec
+#
+
+VLAN_DFS="$NSIM_DEV_DFS/vlan"
+
+check_vid() {
+    local vid=$1
+    local expected=$2
+
+    if grep -q "ctag $vid" "$VLAN_DFS" 2>/dev/null; then
+	present=1
+    else
+	present=0
+    fi
+    [ "$present" -eq "$expected" ]
+}
+
+# Skip VLAN tests if nsim doesn't support VLANs
+if [ -f $VLAN_DFS ]; then
+    ip link add link $NSIM_NETDEV $MACSEC_NETDEV type macsec offload mac
+    check $?
+    ip link add link $MACSEC_NETDEV ${MACSEC_NETDEV}.10 type vlan id 10
+    check $?
+    check_vid 10 1
+    check $? || echo "VID 10 should be on $MACSEC_NETDEV with offload ON"
+
+    ip link add link $NSIM_NETDEV ${MACSEC_NETDEV}2 type macsec port 5
+    check $?
+    ip link add link ${MACSEC_NETDEV}2 ${MACSEC_NETDEV}2.20 type vlan id 20
+    check $?
+    check_vid 20 0
+    check $? || echo "VID 20 should NOT be on $MACSEC_NETDEV2 with offload OFF"
+
+    ip link set ${MACSEC_NETDEV}2 type macsec offload mac
+    check $?
+    check_vid 20 1
+    check $? || echo "VID 20 should appear after offload ON"
+
+    ip link set ${MACSEC_NETDEV}2 type macsec offload off
+    check $?
+    check_vid 20 0
+    check $? || echo "VID 20 should disappear after offload OFF"
+
+    ip link del ${MACSEC_NETDEV}.10
+    check $?
+    check_vid 10 0
+    check $? || echo "VID 10 should be gone after VLAN delete with offload ON"
+
+    ip link del ${MACSEC_NETDEV}2.20
+    ip link del ${MACSEC_NETDEV}2
+    ip link del $MACSEC_NETDEV
+else
+    echo "SKIP: macsec VLAN tests, no netdevsim support."
+fi
+
 if [ $num_errors -eq 0 ]; then
     echo "PASSED all $((num_passes)) checks"
     exit 0
-- 
2.49.0


