Return-Path: <netdev+bounces-22874-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF231769B25
	for <lists+netdev@lfdr.de>; Mon, 31 Jul 2023 17:48:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B5F81C2096E
	for <lists+netdev@lfdr.de>; Mon, 31 Jul 2023 15:48:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E57FD18C3F;
	Mon, 31 Jul 2023 15:48:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D806B19BA5
	for <netdev@vger.kernel.org>; Mon, 31 Jul 2023 15:48:06 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2084.outbound.protection.outlook.com [40.107.223.84])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95B0EA0
	for <netdev@vger.kernel.org>; Mon, 31 Jul 2023 08:48:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S4RN68VbMgXTgZ+qgbHbOZ3r+rQ3Lx3+G6kWDnsYSjJZ5gzhOxRQXEa7Cyos/jXxqiIvhkAmTF0gf2R1Xl33X4jU2K0Auf8x+K+PCebcZTc8ty/T4S6nvpOM/0PU/heSfygQ0FFI3EDsD1kNNC4JXpiZa1ouNVxVcivr7Jzad21JKWp3GFEtb1jyeNllxASxHsRXQ/U96ZJEUgjlBOdDpDydlpcRN5ee/UTVLz4eL4xvezavgn+KEDW/WZ951tILtjUeUA54Y+TKC4wSw/BzdXaSAuj0DCn5nLZm6uQdTL6B7CcUI2gGl+1koZyxuykBg+bkebWBwHEuS5E9os2v3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U/CbtMqfflpcK9RVV0yw8Vd2mrLsKkTolr9sJRFmIKc=;
 b=c1feNZx/CdxDUJ8dVvwL8BNpcP9yhxq9kMAqdY6ijO0ZUoORzKLS1m3bT1g9ZXJxkeH8VEMF7smUhxkXVtnPBYstA4aINAODdnOmGCHR5wRY6B4CN9pl6Mb9PlKXdNnGqnij46XSxX0PpeXn5BGj1wcRMu24eJ5GEzZ3VDX14WpRI0Rne/om4eLvQ6DA1u+yPloneT00vxTXDA3Mi4tNDZYnfQM7n4POscw4K5qViAQksxfiRVhcTzBh7h0b6RXLSm885i/EiudG9spVAZNzSqcXjf2V5kXkiPj8Kx0WzLumhcDCBKIa+vrtLR32rzJ8e50doOUpL7+LFYDvrRNLlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U/CbtMqfflpcK9RVV0yw8Vd2mrLsKkTolr9sJRFmIKc=;
 b=Vbh12Tjb6HC8vsVpgppY+OSIPSf4dfeX5E9LI8BjmrnoRIC+hIi8QkdtF3q3us4X9t9UqdGJterO5trAwNaFrLa5jkjF0Ms+vUnLoLkBV/++HqamiNiDv2YQXN7xKYerdp833XW2jsmLzn54mO75EjhdX0w41s0LzuSc7K3xNNrIJHhln5wZd07dtcnMguaO5SxfnKuFLvjzOM8FZxc5icdS60f3LIalatXIC7NceILheUtU0n+1j8izp0EIxoWk6lokWM2HVTk3yRcArohlTBUjCJFmhtkynT3ne22bOFJ6kiA3jCTVBwyIFkrSGRCCRFdu9glKNGDg6U+ldUlXRg==
Received: from DM6PR06CA0093.namprd06.prod.outlook.com (2603:10b6:5:336::26)
 by CYYPR12MB8704.namprd12.prod.outlook.com (2603:10b6:930:c2::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Mon, 31 Jul
 2023 15:48:03 +0000
Received: from DM6NAM11FT077.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:336:cafe::85) by DM6PR06CA0093.outlook.office365.com
 (2603:10b6:5:336::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.44 via Frontend
 Transport; Mon, 31 Jul 2023 15:48:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DM6NAM11FT077.mail.protection.outlook.com (10.13.173.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6631.44 via Frontend Transport; Mon, 31 Jul 2023 15:48:03 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Mon, 31 Jul 2023
 08:47:54 -0700
Received: from yaviefel.vdiclient.nvidia.com (10.126.231.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Mon, 31 Jul 2023 08:47:50 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>,
	Danielle Ratson <danieller@nvidia.com>, <mlxsw@nvidia.com>
Subject: [PATCH net-next 3/8] selftests: router_bridge_vlan_upper: Add a new selftest
Date: Mon, 31 Jul 2023 17:47:17 +0200
Message-ID: <8d15c2fbca6dfb54f410e2acd5a385d4b9be3aaf.1690815746.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1690815746.git.petrm@nvidia.com>
References: <cover.1690815746.git.petrm@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT077:EE_|CYYPR12MB8704:EE_
X-MS-Office365-Filtering-Correlation-Id: 7dd4adef-cdca-48e3-97f2-08db91dd8668
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	5SE0Vfs0xaagj25RgHKrb6tY+bLBKcVmSvcpdRgLIdKVaHjdMn8XnxKOSt8/p4jPEtLFheIwg16arsXYCg9b776pTCJbkZjW1tw/VpnYL1z9CIYRwBgHJkZBPvS856Uk3RuJxeFoRPWdGGHbstVCBiIcZawpmckUYcI/o2aAauy0XtNiqVlyXgR9MeEuDs+ynSi7Kw7JCZ26wM9kmNbLVWCqW5xWgiRKxsIdYfdcI/mvdgJlDrtL8xT4KwfFb/fwi7V9A+bNMetHlK7clqUvjhu3cFXkNmMJ48h8dEIu0vi+P/Aeyy4F+LxLYxDFeWeGvZf6nxa1J/bQkFBMr21a/+G16Gii/hHfc9hm23YEub7AG/RybAuAjG5118K+qdPUr5q5U70yAI753xbZPgHlJsgEYhHPEK67M+4NkfZcrWPa5GDSMgbxIXcS6/qDoCuvLqwaLTHUnb8dq2JQpoKAOnXIuxNh0Gd9n/9vhE2M0FuAamLkWckG0uGkowcDgwqVx1KbBSJJg9A2aUNlv5+RnDB72JAtZQsSJLJjSrUejPPPleA9MPEcwNFrUFaFP7hkVw38MHSWlaB76Y2+XBIUV0lvJ/9U6bx8B2JcSmWBR8Yn/zvga1FjzDK2wYSmfB/g2Mgp6SG+e66T4K2C7qppOi6dKW7O2GqPEx2HnsItK/T6AEUVoyopDAmt7cLV6WZoheCwPXZjBbqFa/W5frNEbdFmeN4htCWsJoWssrqxMM5vMVmuSFkj2hjuRAb4olbn
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(396003)(39860400002)(346002)(82310400008)(451199021)(46966006)(36840700001)(40470700004)(2906002)(86362001)(36756003)(40460700003)(40480700001)(66574015)(26005)(36860700001)(336012)(16526019)(83380400001)(4326008)(107886003)(47076005)(186003)(426003)(70206006)(7696005)(356005)(7636003)(54906003)(478600001)(6666004)(82740400003)(316002)(110136005)(8936002)(2616005)(8676002)(70586007)(5660300002)(41300700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2023 15:48:03.0452
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7dd4adef-cdca-48e3-97f2-08db91dd8668
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DM6NAM11FT077.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8704
X-Spam-Status: No, score=0.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Add a selftest that verifies routing through VLAN bridge uppers.

Signed-off-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Danielle Ratson <danieller@nvidia.com>
---
 .../testing/selftests/net/forwarding/Makefile |   1 +
 .../forwarding/router_bridge_vlan_upper.sh    | 169 ++++++++++++++++++
 2 files changed, 170 insertions(+)
 create mode 100755 tools/testing/selftests/net/forwarding/router_bridge_vlan_upper.sh

diff --git a/tools/testing/selftests/net/forwarding/Makefile b/tools/testing/selftests/net/forwarding/Makefile
index 96b6dcefbc65..44a0308d8bc2 100644
--- a/tools/testing/selftests/net/forwarding/Makefile
+++ b/tools/testing/selftests/net/forwarding/Makefile
@@ -66,6 +66,7 @@ TEST_PROGS = bridge_igmp.sh \
 	router_bridge.sh \
 	router_bridge_1d.sh \
 	router_bridge_vlan.sh \
+	router_bridge_vlan_upper.sh \
 	router_bridge_pvid_vlan_upper.sh \
 	router_bridge_vlan_upper_pvid.sh \
 	router_broadcast.sh \
diff --git a/tools/testing/selftests/net/forwarding/router_bridge_vlan_upper.sh b/tools/testing/selftests/net/forwarding/router_bridge_vlan_upper.sh
new file mode 100755
index 000000000000..215309ea1c8c
--- /dev/null
+++ b/tools/testing/selftests/net/forwarding/router_bridge_vlan_upper.sh
@@ -0,0 +1,169 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+# +------------------------+                           +----------------------+
+# | H1 (vrf)               |                           |             H2 (vrf) |
+# |    + $h1.555           |                           |  + $h2.777           |
+# |    | 192.0.2.1/28      |                           |  | 192.0.2.18/28     |
+# |    | 2001:db8:1::1/64  |                           |  | 2001:db8:2::2/64  |
+# |    |                   |                           |  |                   |
+# |    + $h1               |                           |  + $h2               |
+# +----|-------------------+                           +--|-------------------+
+#      |                                                  |
+# +----|--------------------------------------------------|-------------------+
+# | SW |                                                  |                   |
+# | +--|--------------------------------------------------|-----------------+ |
+# | |  + $swp1                   BR1 (802.1q)             + $swp2           | |
+# | |                                                                       | |
+# | +------+------------------------------------------+---------------------+ |
+# |        |                                          |                       |
+# |        + br1.555                                  + br1.777               |
+# |          192.0.2.2/28                               192.0.2.17/28         |
+# |          2001:db8:1::2/64                           2001:db8:2::1/64      |
+# +---------------------------------------------------------------------------+
+
+ALL_TESTS="
+	ping_ipv4
+	ping_ipv6
+	respin_config
+	ping_ipv4
+	ping_ipv6
+"
+NUM_NETIFS=4
+source lib.sh
+
+h1_create()
+{
+	simple_if_init $h1
+	vlan_create $h1 555 v$h1 192.0.2.1/28 2001:db8:1::1/64
+	ip -4 route add 192.0.2.16/28 vrf v$h1 nexthop via 192.0.2.2
+	ip -6 route add 2001:db8:2::/64 vrf v$h1 nexthop via 2001:db8:1::2
+}
+
+h1_destroy()
+{
+	ip -6 route del 2001:db8:2::/64 vrf v$h1
+	ip -4 route del 192.0.2.16/28 vrf v$h1
+	vlan_destroy $h1 555
+	simple_if_fini $h1
+}
+
+h2_create()
+{
+	simple_if_init $h2
+	vlan_create $h2 777 v$h2 192.0.2.18/28 2001:db8:2::2/64
+	ip -4 route add 192.0.2.0/28 vrf v$h2 nexthop via 192.0.2.17
+	ip -6 route add 2001:db8:1::/64 vrf v$h2 nexthop via 2001:db8:2::1
+}
+
+h2_destroy()
+{
+	ip -6 route del 2001:db8:1::/64 vrf v$h2
+	ip -4 route del 192.0.2.0/28 vrf v$h2
+	vlan_destroy $h2 777
+	simple_if_fini $h2
+}
+
+router_create()
+{
+	ip link add name br1 address $(mac_get $swp1) \
+		type bridge vlan_filtering 1
+	ip link set dev br1 up
+
+	ip link set dev $swp1 master br1
+	ip link set dev $swp2 master br1
+	ip link set dev $swp1 up
+	ip link set dev $swp2 up
+
+	bridge vlan add dev br1 vid 555 self
+	bridge vlan add dev br1 vid 777 self
+	bridge vlan add dev $swp1 vid 555
+	bridge vlan add dev $swp2 vid 777
+
+	vlan_create br1 555 "" 192.0.2.2/28 2001:db8:1::2/64
+	vlan_create br1 777 "" 192.0.2.17/28 2001:db8:2::1/64
+}
+
+router_destroy()
+{
+	vlan_destroy br1 777
+	vlan_destroy br1 555
+
+	bridge vlan del dev $swp2 vid 777
+	bridge vlan del dev $swp1 vid 555
+	bridge vlan del dev br1 vid 777 self
+	bridge vlan del dev br1 vid 555 self
+
+	ip link set dev $swp2 down nomaster
+	ip link set dev $swp1 down nomaster
+
+	ip link set dev br1 down
+	ip link del dev br1
+}
+
+setup_prepare()
+{
+	h1=${NETIFS[p1]}
+	swp1=${NETIFS[p2]}
+
+	swp2=${NETIFS[p3]}
+	h2=${NETIFS[p4]}
+
+	vrf_prepare
+
+	h1_create
+	h2_create
+
+	router_create
+
+	forwarding_enable
+}
+
+cleanup()
+{
+	pre_cleanup
+
+	forwarding_restore
+
+	router_destroy
+
+	h2_destroy
+	h1_destroy
+
+	vrf_cleanup
+}
+
+ping_ipv4()
+{
+	ping_test $h1 192.0.2.18
+}
+
+ping_ipv6()
+{
+	ping6_test $h1 2001:db8:2::2
+}
+
+respin_config()
+{
+	log_info "Remaster bridge slave"
+
+	ip link set dev $swp2 nomaster
+	ip link set dev $swp1 nomaster
+
+	sleep 2
+
+	ip link set dev $swp1 master br1
+	ip link set dev $swp2 master br1
+
+	bridge vlan add dev $swp1 vid 555
+	bridge vlan add dev $swp2 vid 777
+}
+
+trap cleanup EXIT
+
+setup_prepare
+setup_wait
+
+tests_run
+
+exit $EXIT_STATUS
-- 
2.41.0


