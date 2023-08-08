Return-Path: <netdev+bounces-25298-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AA85773B36
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 17:45:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B27A2280F6B
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 15:45:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8991414000;
	Tue,  8 Aug 2023 15:42:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DD94134D6
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 15:42:20 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2061c.outbound.protection.outlook.com [IPv6:2a01:111:f400:7eaa::61c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D11F34237
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 08:41:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iZj8m+n+K1yCS4oC/uDhv9UtnvjrMYzwH/CWIzHg1vIwptfPfbuuJ1+7SUw5xUM//kaTf4i3XnP5kwpRqYdMV5odTeKzep585xh+jc5CS3OsGz2ZBJ8P+Wl1AChKRC85OcWqvJBefWHjCFVKdeWgUkDKzhTwklQXX/M3+IhNc6NCIcGlb/1LfE/Z3QYoVT8rLHTWWLJzXhzILSG9+k9r10nmsVmY33o3y0IY2RmhoCCu2sSrltjL8ElGqTFwh13JkJxxy5lZj6huYtbYkEJ914h8vAp4/vXC07QBNedteK3H67x4iVjoJNR0eUINAC8jjdd78NTCfKjgHmG4HUlQug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q9wct6EEFEb7A4xLSHyl5ScXjsMYTfimhvIG3q9vHrY=;
 b=i0y2gtCv+h4vbx9gHi4P+8WIXZyWfI1Ul+tdmO+p+sUcXXmykeiRzAHP0I4KTAWsxbYhwfwRMSeYbPkBHc27RLoqloM//XQ9UYWotTIffigqjs9ghKhMM+Is88yxixE5IDNBtJ+G5suu7mHtUUEt1seWggILx3UpB2F/F+le9wGXT78wiu93OxFdNZifU8BXTdYYHcm53KFe+rhBRoKXYZwRLnq0EVyozIg9FbZWw+JkLNlaQBNNCL3ZfORKibeBce2B/uDEsN5vS79g6HVanp0o/sxCiQDnrMBPQa+1KuzvB9dRF1D/YzuYeCOvSJT4AX+fl2IHwpHZ5hVE4K26CA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q9wct6EEFEb7A4xLSHyl5ScXjsMYTfimhvIG3q9vHrY=;
 b=Lf46Wa3iXDRTJHlKU9brdaruQfWrsxt7YAYz5muOpF8Kgz3nx3purUDs4ri2u+anjke4W9jkpiJnjEeE8sfDLsds2+PIIgo2hiE5RExYKQnR2zzu5YB3WknhTYWn3+FSZVmrTpWZyl+o4TJm2IUI1mRPMLKV8SjwZ+dkmz8YpadOtt/jeZI469hiU/YKHFlmTN1wK4uM8fbi6cUsRrfrNKifjNZilHjCStxihlID30DBPxDYA79EqpcuYN/hhgEYQDNXmWtAfUYo8/+I7sOvyOcX8SI09lytFDfV66Nr/37bgLhb/Cvpq7tuQ0GaQHBROIBE56iaX34D58j+v0rhVw==
Received: from MW4PR04CA0339.namprd04.prod.outlook.com (2603:10b6:303:8a::14)
 by BL1PR12MB5803.namprd12.prod.outlook.com (2603:10b6:208:393::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.27; Tue, 8 Aug
 2023 14:16:26 +0000
Received: from MWH0EPF000989E8.namprd02.prod.outlook.com
 (2603:10b6:303:8a:cafe::1c) by MW4PR04CA0339.outlook.office365.com
 (2603:10b6:303:8a::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.27 via Frontend
 Transport; Tue, 8 Aug 2023 14:16:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MWH0EPF000989E8.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6652.19 via Frontend Transport; Tue, 8 Aug 2023 14:16:25 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Tue, 8 Aug 2023
 07:16:13 -0700
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Tue, 8 Aug 2023 07:16:10 -0700
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <petrm@nvidia.com>, <razor@blackwall.org>,
	<mirsad.todorovac@alu.unizg.hr>, Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH net v2 14/17] selftests: forwarding: tc_flower_l2_miss: Fix failing test with old libnet
Date: Tue, 8 Aug 2023 17:15:00 +0300
Message-ID: <20230808141503.4060661-15-idosch@nvidia.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230808141503.4060661-1-idosch@nvidia.com>
References: <20230808141503.4060661-1-idosch@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E8:EE_|BL1PR12MB5803:EE_
X-MS-Office365-Filtering-Correlation-Id: b84927d7-6613-4a13-5aef-08db981a0ceb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	qEa4usc8tTyICHoT0rV1Ip9cLVGwmkyp5zTdLJQdQKx/lOdLxtyFI9DOoDi4WSkBVgM+TSGgpGSzVH1o/E4qK38zeydPVPP30EkZrw48uP2THCPZEyja8iADOQsh1/2LrUvgWkBAqTs1ALbWYblwjKrXp7izotQvYJUCEJzeAiBK4tyk5cCrZklzJHwoUtojtUeQ7kLNcbr991RZFj44H4AzyQgI8Wl6DbF2rUpJ3BhuBf9zVhh/X+Rng+IwA8oIdYd7SEpNIpl2BdNHwsEkbzxe6tNp+jF89Qa5opsTch7ClJtZY9zEvtkFR9fIFZ+HjKcwHMoXcZrG/sCW0HXq1PD5aTCDl8cr0t/qXuD5y4sxVlU86+KJYO3n/c2QHPMoUhzoD35CWrapLppBB1P+r/aoQEjTkG32UvCaapNbFTlFoKTSKwgat7iOoIR8K5NHGGkO12uM+X+/51jX3xX1Kn1HiE1IVrrnd/8P0dtiPzqxxKv7ZNuxdYO5CmzgwJ/B0mPlgkZwilpERGkM6yjHB/KPP66aMZ0G7ZmHoA8Es16DxwXeYQW7hQPro8UEXSdKdRPUEvnP2CgNlKBiLjIdiUyu2Xi+OeEgcBb9ycc/uO/hxFLfTJMG7F2p2lYayQzXunCfxX3M9q2620aS29Xb2b/cwnQU5XMkmp3mvHS5vN+K8LkjraA6IyUz+TdVaypRhky3HZS9neVhLwnViD/fVlVBnscrpgcdtfbGl2wDe9jnHCKdqhaW8cjBImIon1l5a0RXtRgCmCxLh03ORtbbCyup/ytLN8gsnSHi88NTtFw=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(39860400002)(346002)(136003)(451199021)(82310400008)(1800799003)(186006)(36840700001)(46966006)(40470700004)(40460700003)(82740400003)(336012)(86362001)(1076003)(26005)(83380400001)(16526019)(47076005)(2616005)(426003)(107886003)(356005)(36860700001)(7636003)(2906002)(478600001)(966005)(6666004)(54906003)(36756003)(40480700001)(70586007)(70206006)(5660300002)(8676002)(8936002)(41300700001)(4326008)(316002)(6916009);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2023 14:16:25.4817
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b84927d7-6613-4a13-5aef-08db981a0ceb
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000989E8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5803
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

As explained in commit 8bcfb4ae4d97 ("selftests: forwarding: Fix failing
tests with old libnet"), old versions of libnet (used by mausezahn) do
not use the "SO_BINDTODEVICE" socket option. For IP unicast packets,
this can be solved by prefixing mausezahn invocations with "ip vrf
exec". However, IP multicast packets do not perform routing and simply
egress the bound device, which does not exist in this case.

Fix by specifying the source and destination MAC of the packet which
will cause mausezahn to use a packet socket instead of an IP socket.

Fixes: 8c33266ae26a ("selftests: forwarding: Add layer 2 miss test cases")
Reported-by: Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
Closes: https://lore.kernel.org/netdev/adc5e40d-d040-a65e-eb26-edf47dac5b02@alu.unizg.hr/
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
Tested-by: Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
---
 .../selftests/net/forwarding/tc_flower_l2_miss.sh   | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/net/forwarding/tc_flower_l2_miss.sh b/tools/testing/selftests/net/forwarding/tc_flower_l2_miss.sh
index e22c2d28b6eb..20a7cb7222b8 100755
--- a/tools/testing/selftests/net/forwarding/tc_flower_l2_miss.sh
+++ b/tools/testing/selftests/net/forwarding/tc_flower_l2_miss.sh
@@ -127,6 +127,7 @@ test_l2_miss_multicast_common()
 	local proto=$1; shift
 	local sip=$1; shift
 	local dip=$1; shift
+	local dmac=$1; shift
 	local mode=$1; shift
 	local name=$1; shift
 
@@ -142,7 +143,7 @@ test_l2_miss_multicast_common()
 	   action pass
 
 	# Before adding MDB entry.
-	$MZ $mode $h1 -t ip -A $sip -B $dip -c 1 -p 100 -q
+	$MZ $mode $h1 -a own -b $dmac -t ip -A $sip -B $dip -c 1 -p 100 -q
 
 	tc_check_packets "dev $swp2 egress" 101 1
 	check_err $? "Unregistered multicast filter was not hit before adding MDB entry"
@@ -153,7 +154,7 @@ test_l2_miss_multicast_common()
 	# Adding MDB entry.
 	bridge mdb replace dev br1 port $swp2 grp $dip permanent
 
-	$MZ $mode $h1 -t ip -A $sip -B $dip -c 1 -p 100 -q
+	$MZ $mode $h1 -a own -b $dmac -t ip -A $sip -B $dip -c 1 -p 100 -q
 
 	tc_check_packets "dev $swp2 egress" 101 1
 	check_err $? "Unregistered multicast filter was hit after adding MDB entry"
@@ -164,7 +165,7 @@ test_l2_miss_multicast_common()
 	# Deleting MDB entry.
 	bridge mdb del dev br1 port $swp2 grp $dip
 
-	$MZ $mode $h1 -t ip -A $sip -B $dip -c 1 -p 100 -q
+	$MZ $mode $h1 -a own -b $dmac -t ip -A $sip -B $dip -c 1 -p 100 -q
 
 	tc_check_packets "dev $swp2 egress" 101 2
 	check_err $? "Unregistered multicast filter was not hit after deleting MDB entry"
@@ -183,10 +184,11 @@ test_l2_miss_multicast_ipv4()
 	local proto="ipv4"
 	local sip=192.0.2.1
 	local dip=239.1.1.1
+	local dmac=01:00:5e:01:01:01
 	local mode="-4"
 	local name="IPv4"
 
-	test_l2_miss_multicast_common $proto $sip $dip $mode $name
+	test_l2_miss_multicast_common $proto $sip $dip $dmac $mode $name
 }
 
 test_l2_miss_multicast_ipv6()
@@ -194,10 +196,11 @@ test_l2_miss_multicast_ipv6()
 	local proto="ipv6"
 	local sip=2001:db8:1::1
 	local dip=ff0e::1
+	local dmac=33:33:00:00:00:01
 	local mode="-6"
 	local name="IPv6"
 
-	test_l2_miss_multicast_common $proto $sip $dip $mode $name
+	test_l2_miss_multicast_common $proto $sip $dip $dmac $mode $name
 }
 
 test_l2_miss_multicast()
-- 
2.40.1


