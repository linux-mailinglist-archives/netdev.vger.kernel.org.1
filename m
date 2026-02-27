Return-Path: <netdev+bounces-261772-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yK30CFteoWmksQQAu9opvQ
	(envelope-from <netdev+bounces-261772-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 10:05:31 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 964DE1B4E71
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 10:05:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 082B330FF3F9
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 09:03:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8878836C5B6;
	Fri, 27 Feb 2026 09:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="knm8rbUE"
X-Original-To: netdev@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010046.outbound.protection.outlook.com [40.93.198.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A58038E10A
	for <netdev@vger.kernel.org>; Fri, 27 Feb 2026 09:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772182995; cv=fail; b=Sv2aun0/Twt8yqNgiQh7T9RCUYkFJAUg/KhmZOqVlFJrvPCSl7tTTBIeFHRdoM09RCP2DLai3RDlPKkH3QL5bnVs269zr9aJ3mTJc/DvbwXcykrvvUZyvZ5rg2nl3FP5GmymsV7wUWILUmWhDuZTXPwIOcK1o9Brv411HD2AvWo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772182995; c=relaxed/simple;
	bh=L8qyzUgwBwhaVk/LZXFCvgQ0rRqjicle6DA4/T2yqB8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u040d1SKWpFAf2if9R90gKlnQ2W8TFTObENk3m6uOPRx/ihfBgCbC54Vg64hj4a6hKwbyFmAJR/M5odiVVKArM4czI9aQssQ6IattrxUuXOo4PMOVdyjnaVI9Fnh4FnsUGvESmqku73udAAcgLBoZYtBUmlYroytoscqXd4FheQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=knm8rbUE; arc=fail smtp.client-ip=40.93.198.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=roWeNIuYIY2CyeFGYlGKYeEQ4GkXJHzgYcnJrqrTMkDs/aO3lZyOZrGpSXJWOABWZhleBKnhTluUU5HqYD313NGxUner1oGR/QzPtkPxBJBcscGl2SI1P6SiYHFUkZfR5ecMiDhZcE5oV32JA4CfDiQKmLzk7Jv106iM+v0glKAhvYkjGD//uEKF4k6uZHn0QDrL/oXcgnMlcCJhFvofzL5XGcK7j96C/zR/BnAsl1zEIshUV8i3xaZm8y5XziYl4VIngVkk4nBDp8X7XPnFjB2BZVeFkSLiI8U/sEkkvxqxxCr4RAnGUB08Kx66Qx7FMg2HN0GoYUME0AQsV+G/Wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zQfSVVer/MgCEVHoZPltlgNpaany9jh97RNfQCzN86c=;
 b=NyWeo8tCeOZ0xb+TrIFOOlccJIAjATIXxSwcMEeaIvrL6n3u2o7OsAawOiP+NU7zDDzlCQeqK8yT7IdKWioTisEcNdqDs3iJycNML1vTxErU0+NHxIq9VIdvqhd9NF3Bb17n+ikhq+NvOMXCs2UEwtbhoBekR1qDZBUFhLlvRuUUc7lIn8KtX1xzy9beiLJmjJdY+ssFZIv2892eZs4h0x7VDWBjD2UBqeHve7tF7Afqb9T1d4wrzKiAuGd4K243dtXm+VsemQhcvD6YdGJ9W2j/emp3/6+uLnDG7536sAd0MytxgRiuIbKlHiIQfB4kdhT5aslYU3BocpnhfJwmZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zQfSVVer/MgCEVHoZPltlgNpaany9jh97RNfQCzN86c=;
 b=knm8rbUESKiTheCCpuqh9w6vUXSuVsOzIKzZxmvJz+5CMZNhnK28dixOoGQwoWiN58ryowtiBzMj/3kxIqETH8AFFuVuQ/T/1BDmiA6HneNpcVJ7dExNwDsQ3qhwvl2IC4yJsOgCDQoLwipEXqUrN7IWFZ6TUTkpnwn6DfjvKQqnbvuPrDujSzA2wW/BWiJT4JdWZpeRHeOJnVpkCu50YVgrEI5IA5mztkck6ww6C0tMYPiiDu4WFV376/dD4QlL3u5fzuAIPf+Lr3fyec5ZcqKXIvYQZ/o9QEG6GDs9Zwcljk92gmc2YtAPK/KnUacjmRiv/V1/4t4TML5M/7HLcQ==
Received: from BL1PR13CA0304.namprd13.prod.outlook.com (2603:10b6:208:2c1::9)
 by DS0PR12MB8318.namprd12.prod.outlook.com (2603:10b6:8:f6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.14; Fri, 27 Feb
 2026 09:03:07 +0000
Received: from BL6PEPF00020E60.namprd04.prod.outlook.com
 (2603:10b6:208:2c1:cafe::82) by BL1PR13CA0304.outlook.office365.com
 (2603:10b6:208:2c1::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.22 via Frontend Transport; Fri,
 27 Feb 2026 09:03:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF00020E60.mail.protection.outlook.com (10.167.249.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9654.16 via Frontend Transport; Fri, 27 Feb 2026 09:03:07 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 27 Feb
 2026 01:02:54 -0800
Received: from c-237-113-240-247.mtl.labs.mlnx (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Fri, 27 Feb 2026 01:02:51 -0800
From: Cosmin Ratiu <cratiu@nvidia.com>
To: <netdev@vger.kernel.org>
CC: Sabrina Dubroca <sd@queasysnail.net>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Cosmin
 Ratiu" <cratiu@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>
Subject: [PATCH net-next v2 2/3] selftests: Add macsec offload VLAN tests
Date: Fri, 27 Feb 2026 11:02:26 +0200
Message-ID: <20260227090227.1552512-3-cratiu@nvidia.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260227090227.1552512-1-cratiu@nvidia.com>
References: <20260227090227.1552512-1-cratiu@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E60:EE_|DS0PR12MB8318:EE_
X-MS-Office365-Filtering-Correlation-Id: 5374178c-3e81-40db-0943-08de75df0645
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	+YKAvwUnYrzxZtvpT3sO3wUL/tSzolQ6N1tvRzNpPbM4M0b/rvRTZNUWBqQDaoCbrDwOmax+YCeuxQPuaYbsZRg0BveA/t9JAgyy7kPxSRZlmQHBeNG98EGtL6H0phkB19fnFq2QBdqEb9bxkBuQIDJwpYm3HEgedsAphyao6UpbhfL1S+GwBx4nt9smilWhZWGz9tAJyLBbqhUrkVY1AaGlfcdEaxxYJ5kxRIthMPRkuQnTA37Stgs0PXW73X2e/hrpenFpGZzm3fFqsmNwnshMEX9AR4/EftbToLQs79XnYlp/PQOi9NaXtkPjp2zc2QKRaJo0SCMEww3K7GOB5CLrQ22hl76eXRrgK+0BTraiZev+REwI0oHnGbI2Xtr8WmMdmmhcyezoBA/rbRYON+MgcGR4w+pqywqhOgNY7j6O00RDKd87YJlJnBaUkIfyvN/tLUg34du+E+zdI5Hd6lsnbar3Sis6cSPQ2D1t66Zw5Bbwd194hNOR4mWcH8UX+On09bVNBddCflTwOHPBZfUzeQYqvcOUxWntClRYxr8R8VlqRw/X77OGPc8OW53QRO2f4daWZ6pt298FXUQLj5N5Nl8Ex7DRJO5RrGcD0Oxjdd/ZHdtTkcupMIAD5+dg20w5FqwnFWD0IlUYvRHNh+1nW6XNr3YuzBaSVPURo8z2jwadRZ6FyrowZFzXIhR8VPUSHi7UHsi5iBnUiHeRMm4C1Ad18zCpPTNLYkesN2HfFP3277o0A4M/bKuobUlwxR2qBA1lmRbKVg+OI0RGinLIDrB2xFtt/M1b2jtzdEda8SumJbM8OL7pOsXg64g0F/P7V3mWH3xc5XZHJlGSzw==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	J8+IUPh5onME2D4StMvFUKS01JwR4oV3emfUV47BF5yGBI0H9UQHUDfo/JghvFu9a3BovmeZfQD36nYDQjmPqd8JIruGpWb8qPF0HwqgDKHn64N6lzmDRqCQ/XrERqThqX3e+5dYJKlxKTC/T25PJTIvY7fX3qSQ7zH6iyJFVIbZbBbAeKzNhzT//Xr/7HJBhbLg2bBP9T+aF3yfJdWwwWxG23iledOby2A/ODXWEb3o066IswEnzRerdVCBFvEZae1dKDQOB6DpPHPprzCnjXo8pAdhN+IiAzopPD1ENTM++C6G7xe6iWtw3R2kdeTiQ2EYxHAr0z51u9KJshqQgwa93vBO14u50k9dcW3LzJdB75AI2sylqGWxUzhabkBy/kBLQHLc0t6GrFseeiWtz/uB+A9Qh8dPNqv/M+Wjlb6FyIeGiBxlofcakK5nRIsH
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2026 09:03:07.4703
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5374178c-3e81-40db-0943-08de75df0645
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00020E60.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8318
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-261772-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,Nvidia.com:dkim,nvidia.com:mid,nvidia.com:email];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cratiu@nvidia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-0.995];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: 964DE1B4E71
X-Rspamd-Action: no action

Add macsec offload VLAN tests using the netsim VLAN support just added.
In case that VLAN support is missing (e.g. when running these tests on
older kernels), the VLAN tests are simply skipped.

Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
---
 .../drivers/net/netdevsim/ethtool-common.sh   |  5 +-
 .../drivers/net/netdevsim/macsec-offload.sh   | 59 +++++++++++++++++++
 2 files changed, 62 insertions(+), 2 deletions(-)

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


