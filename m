Return-Path: <netdev+bounces-17655-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13FF5752834
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 18:20:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3505C1C213B5
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 16:20:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B370C20FBF;
	Thu, 13 Jul 2023 16:16:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7D01214E5
	for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 16:16:51 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2046.outbound.protection.outlook.com [40.107.93.46])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1BADE74
	for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 09:16:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ez4f+HKscqdrV8G/mwEsdEgDXfNUhDY//6CYCxef9BS8JjNwSv0TGb+Hnj+H6oS1OxNNh88ujWzHdaBmYr6Wh1c4B0qJoJBoaoKJU6VxwNtJOyBSCBMjkcSaxryYpW4y9toS+DVzljqR0Fk6VnhbBe4U7MbHh2TBk50ew97RPjfm00KGqBuAMxE2h7E3XjeNEyE6L4wMfyO0MPpaIzHOfEUsT077WPddUegLSm8H9xcxMvg/Z3jvvkRTbxUNl1mpsn5Of08TjdbKrEOKBs/zBcFPNEh02Njz9v96JdFMhMXUjoNXasU7F+xpXIq6RUxT6oZ3nyucZR1YO9tvztQS9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JpsxeVUZJD7ZmdoXNQeM3FWfmN7nxl5GS/S0dwccZoI=;
 b=C3autwiF/leRriG4K7O+KtBCPG1f42xksCmRBACv1fD/82CsEA+zbnKYBdPD+xWXHG5bqxxpvukfLftkYFDVOGsE9PSxAplgIWuBFbYvmhzgNF3QLhtgQkpw/aR2xQDCNzOV1SK0WI+EJcK6mdAklfktn/lP4ear/Zqwm+wj5t3/b7pl139PXHCiPJl+ICjxSlr4V+JphlCSlhsoSevNwiaAXFrw7ShwOqiSsL/n1+xliVaZ4qb71JoWTZvwhiT3/5/wjS+gbtIKAkF6tHZfM3lg8en/pZEkyzhsYvxUk1TpBUp0qMBZx9zBA9/m6huq50WqQmoUFlKJCpGdgyZ8Ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JpsxeVUZJD7ZmdoXNQeM3FWfmN7nxl5GS/S0dwccZoI=;
 b=ZGDdD/yNnyMKa1s4d1IMHq6c0+9mkb48O+X0kX/7TFx5s3fp2aUxr2vOGu7LSy34N9avgOlo1t9k5Qf9/7tveCzPB4EacZQyB1jUgZQWv6UPuuWg++gTsqX9fR+T7RlJkJJi/MNPp8LwBXAdj4Ym2jbUIy7GZImgzAPf7Xxt0pmkRBhFYjHbH3LDH9lTEHHxQgoyja0c+EiQrNKh4XaZs1oV7+72ImgIbgoO2rOrYNW5vVEhiKB1efjWEs9b5LbMtwg8Al/qUiEKtN2sDYaUvxrfL5Iea8hw9o9DUEaicYL2T5jrbs6f5HyBwK/VVUwYsUpv8CokagkYnP0g6lWgNg==
Received: from BN1PR14CA0027.namprd14.prod.outlook.com (2603:10b6:408:e3::32)
 by BL1PR12MB5093.namprd12.prod.outlook.com (2603:10b6:208:309::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.26; Thu, 13 Jul
 2023 16:16:46 +0000
Received: from BN8NAM11FT003.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e3:cafe::1f) by BN1PR14CA0027.outlook.office365.com
 (2603:10b6:408:e3::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.25 via Frontend
 Transport; Thu, 13 Jul 2023 16:16:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN8NAM11FT003.mail.protection.outlook.com (10.13.177.90) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6588.26 via Frontend Transport; Thu, 13 Jul 2023 16:16:45 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Thu, 13 Jul 2023
 09:16:30 -0700
Received: from localhost.localdomain (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Thu, 13 Jul
 2023 09:16:28 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>,
	Danielle Ratson <danieller@nvidia.com>, <mlxsw@nvidia.com>
Subject: [PATCH net-next 11/11] selftests: router_bridge_pvid_vlan_upper: Add a new selftest
Date: Thu, 13 Jul 2023 18:15:34 +0200
Message-ID: <327c5d7d4ed57cad92cf40d4869a20bb0cd99f2f.1689262695.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1689262695.git.petrm@nvidia.com>
References: <cover.1689262695.git.petrm@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT003:EE_|BL1PR12MB5093:EE_
X-MS-Office365-Filtering-Correlation-Id: 32a3560d-82d2-4dc8-8a78-08db83bc8df3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ImSQ28hoIfOmefBo6DZFovOytld0tA0pUtXdOBZ7sqjPzE1CuDoJNGSmmb60M+Me0I+ScdhjiZwaHjBtEsqEzw6p0eOgfhXIqpUiP2563t8BtyDPFi8yFAnvVasdu5NQZFj74L8JwlQW9+VO72DXwW6BXru/J+LJYwhdFTAedG7ew1XagRT4R8ewdF4coEUDHu3yLdxV5humGm8pDoPxQYmyvQ83bTMI5DVkrFMXbo0tgIhgg5P2Q4n5kLLhco06vCtiCVOK1U6znl1wui2k3ieq10iMP4Od8hF2KS1XWZqjrc5XpTme94Qozn77YGID1BLjLpmdb3Lxde2eS0wk1iNRDdCtLDZmQTYN3cVPvcxcrehefeqXRVrz3U/do72hYwWVpDK6/Tj9GXo1iXosNIhXktjbTTM82AuKIlNPb/FdaYLZpoo6AHuw9p9VSy12kSIiOm4BShPmUWKSUedELBgefWRzSpaxmAxbC02K4h7WfTORPwFAteCXqn6CP7U18cNjGdhZkia+pQeaqeSTaJd4Ux4xHRSaK+mWU1mHPLxXeWu/tl6jQGigLh3dfSn9vjmGrWRBWkjAOmjBCVxS4HV0tvOPV5gGekEHmeamgufujWaJVPz95AxvwtFwInqScncvzW02lLL2MOJFn2j73LBAzfH0lWrSEM5CLdmKB2Zo/mQNnTYC9K6TLGwDYET5UU1gHW/o2/I0yXhayYYCvGWF0vYI0lvDY5a2XUGIygs=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(376002)(136003)(346002)(451199021)(40470700004)(46966006)(36840700001)(40460700003)(6666004)(36860700001)(83380400001)(47076005)(186003)(16526019)(336012)(66574015)(426003)(2616005)(36756003)(82310400005)(7636003)(86362001)(356005)(82740400003)(26005)(40480700001)(107886003)(70586007)(70206006)(4326008)(54906003)(110136005)(41300700001)(5660300002)(316002)(8676002)(8936002)(2906002)(478600001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2023 16:16:45.9820
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 32a3560d-82d2-4dc8-8a78-08db83bc8df3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN8NAM11FT003.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5093
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

This tests whether addition and deletion of a VLAN upper that coincides
with the current PVID setting throws off forwarding.

This selftests is specifically geared towards offloading drivers. In
particular, mlxsw used to fail this selftest, and an earlier patch in this
patchset fixes the issue. However, there's nothing HW-specific in the test
itself (it absolutely is supposed to pass on SW datapath), and therefore it
is put into the generic forwarding directory.

Signed-off-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Danielle Ratson <danieller@nvidia.com>
---
 .../testing/selftests/net/forwarding/Makefile |   1 +
 .../router_bridge_pvid_vlan_upper.sh          | 155 ++++++++++++++++++
 2 files changed, 156 insertions(+)
 create mode 100755 tools/testing/selftests/net/forwarding/router_bridge_pvid_vlan_upper.sh

diff --git a/tools/testing/selftests/net/forwarding/Makefile b/tools/testing/selftests/net/forwarding/Makefile
index 1a21990d0864..2d8bb72762a4 100644
--- a/tools/testing/selftests/net/forwarding/Makefile
+++ b/tools/testing/selftests/net/forwarding/Makefile
@@ -65,6 +65,7 @@ TEST_PROGS = bridge_igmp.sh \
 	q_in_vni.sh \
 	router_bridge.sh \
 	router_bridge_vlan.sh \
+	router_bridge_pvid_vlan_upper.sh \
 	router_bridge_vlan_upper_pvid.sh \
 	router_broadcast.sh \
 	router_mpath_nh_res.sh \
diff --git a/tools/testing/selftests/net/forwarding/router_bridge_pvid_vlan_upper.sh b/tools/testing/selftests/net/forwarding/router_bridge_pvid_vlan_upper.sh
new file mode 100755
index 000000000000..76e4941fef73
--- /dev/null
+++ b/tools/testing/selftests/net/forwarding/router_bridge_pvid_vlan_upper.sh
@@ -0,0 +1,155 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+# +----------------------------+
+# |                   H1 (vrf) |
+# |   + $h1.10                 |                      +----------------------+
+# |   | 192.0.2.1/28           |                      |             H2 (vrf) |
+# |   | 2001:db8:1::1/64       |                      |  + $h2               |
+# |   |                        |                      |  | 192.0.2.130/28    |
+# |   + $h1                    |                      |  | 2001:db8:2::2/64  |
+# +---|------------------------+                      +--|-------------------+
+#     |                                                  |
+# +---|--------------------------------------------------|-------------------+
+# |   |                            router (main VRF)     |                   |
+# | +-|----------------------------------+               + $swp2             |
+# | | + $swp1      BR1 (802.1q, pvid=10) |                 192.0.2.129/28    |
+# | |              192.0.2.2/28          |                 2001:db8:2::1/64  |
+# | |              2001:db8:1::2/64      |                                   |
+# | +------------------------------------+                                   |
+# +--------------------------------------------------------------------------+
+
+ALL_TESTS="
+	ping_ipv4
+	ping_ipv6
+	shuffle_pvid
+	ping_ipv4
+	ping_ipv6
+"
+NUM_NETIFS=4
+source lib.sh
+
+h1_create()
+{
+	simple_if_init $h1
+	vlan_create $h1 10 v$h1 192.0.2.1/28 2001:db8:1::1/64
+	ip -4 route add 192.0.2.128/28 vrf v$h1 nexthop via 192.0.2.2
+	ip -6 route add 2001:db8:2::/64 vrf v$h1 nexthop via 2001:db8:1::2
+}
+
+h1_destroy()
+{
+	ip -6 route del 2001:db8:2::/64 vrf v$h1
+	ip -4 route del 192.0.2.128/28 vrf v$h1
+	vlan_destroy $h1 10
+	simple_if_fini $h1
+}
+
+h2_create()
+{
+	simple_if_init $h2 192.0.2.130/28 2001:db8:2::2/64
+	ip -4 route add 192.0.2.0/28 vrf v$h2 nexthop via 192.0.2.129
+	ip -6 route add 2001:db8:1::/64 vrf v$h2 nexthop via 2001:db8:2::1
+}
+
+h2_destroy()
+{
+	ip -6 route del 2001:db8:1::/64 vrf v$h2
+	ip -4 route del 192.0.2.0/28 vrf v$h2
+	simple_if_fini $h2 192.0.2.130/28 2001:db8:2::2/64
+}
+
+router_create()
+{
+	ip link add name br1 address $(mac_get $swp1) \
+		type bridge vlan_filtering 1 vlan_default_pvid 0
+	ip link set dev br1 up
+	__addr_add_del br1 add 192.0.2.2/28 2001:db8:1::2/64
+
+	ip link set dev $swp1 master br1
+	ip link set dev $swp1 up
+
+	ip link set dev $swp2 up
+	__addr_add_del $swp2 add 192.0.2.129/28 2001:db8:2::1/64
+
+	bridge vlan add dev br1 vid 10 pvid untagged self
+	bridge vlan add dev $swp1 vid 10
+}
+
+router_destroy()
+{
+	bridge vlan del dev $swp1 vid 10
+	bridge vlan del dev br1 vid 10 self
+
+	__addr_add_del $swp2 del 192.0.2.129/28 2001:db8:2::1/64
+	ip link set dev $swp2 down
+
+	ip link set dev $swp1 down
+	ip link set dev $swp1 nomaster
+
+	__addr_add_del br1 del 192.0.2.2/28 2001:db8:1::2/64
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
+shuffle_pvid()
+{
+	log_info "Add and remove VLAN upper for PVID VLAN"
+
+	# Adding and removing a VLAN upper for the PVID VLAN shouldn't change
+	# anything. The address is arbitrary, just to make sure it will be an L3
+	# netdevice.
+	vlan_create br1 10 "" 192.0.2.33/28
+	sleep 1
+	vlan_destroy br1 10
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
+	ping_test $h1 192.0.2.130
+}
+
+ping_ipv6()
+{
+	ping6_test $h1 2001:db8:2::2
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
2.40.1


