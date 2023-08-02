Return-Path: <netdev+bounces-23559-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94D6576C7AB
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 09:57:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49137281D2E
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 07:57:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D16F06FD8;
	Wed,  2 Aug 2023 07:53:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0392539F
	for <netdev@vger.kernel.org>; Wed,  2 Aug 2023 07:53:18 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2062.outbound.protection.outlook.com [40.107.101.62])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C3EC213F
	for <netdev@vger.kernel.org>; Wed,  2 Aug 2023 00:53:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NIfvFDW8tjWX0004Ui7LwsnY93mRCFH6kKfDedQYNVbYsXLjgYqXUah79qAcxICsyBqnj7OtNDKgq+5ktpXsNB3Y8hfanzUpNJgbrX9OaheN8QrjMIzOwHzNyuGu1wSmoi1d0BBxThIwCpWPFplW7EbYf7XpLRIpIaewGoLenrHREiTB+qUCejRbz24u4EGGYFMBTnz0FeCea+ha9/DctRJ491t59LmFhGKeMjTENNGJU+r1j6aYUlKqkSz6wtbCBTl7nIpDrELXxhGDMjjBjlj1VbELct49lpvIHQkziRkMw3T7plWcmxYMBNIrQdJP0JP02dQ+0QNEnjARpWNTQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Um/fADwQBmuOmmzS8/Tpu2zAh9/Wb9BF1IdjvIAIGaU=;
 b=iq3fvho7Zh61TCpd8UfAjNbg91uizFvR3lVQoLqf2eZyRlU5bT0GNoD85zvNBu5f+eKmkLA/JlPyZyE4JPWAKe77T9o/HVWs/uiypWEdb4HPPFwA6HOjfoNJdihd8g/RwNeFZcp3bx3Bts4CX/yLebG5AxAbWj2EcHkhGI6HCnB5o9nsrwzuFZOATkLT3s5nR6+Boa2lAHdDCXE7JlUszY1XGfTPqnyR5hPWz8qaht7hqQ2kZ/ioFSZMjF1KsOPgzk5T/sdwcp/yo/Wtk8NzorrDWG9MzejTh8VoBcE6whPxYRHlASMR8Xck5xhsnzSWdpJFG39fv7bRisHiiz2LWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Um/fADwQBmuOmmzS8/Tpu2zAh9/Wb9BF1IdjvIAIGaU=;
 b=TUcsBWLVCImDYdNFews2hmDXLvwyqoVxaWYfdaf74YcwgDsSaj6cMU+gAUJ2QC/7xsHdPK/7JL4Qp8LFWrIbBhWw3Z29SIbii6v1h6ucJlYiIaHgybRvf8OWHdGUlfc/Hcdy0sypi5Va0yrmagPIYADyhZzcuzis314Eafv54rLepZmX3uROU1aHXTdaOo14UziMaM0DWjOboc0ZOxSAiIWXJ0JgMdlSRRDyRPPyTqT0gbUheV/NPteRquyF3QUecUaXsdAcda2cbkdLiMO3GGcFlqyFDlw5GXWZuCrC5WUTxAYctW+ScjCgTng/7BD875uLMmhB0oA+Jwvw0Xd7IQ==
Received: from DM6PR07CA0076.namprd07.prod.outlook.com (2603:10b6:5:337::9) by
 IA1PR12MB7496.namprd12.prod.outlook.com (2603:10b6:208:418::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.44; Wed, 2 Aug
 2023 07:53:14 +0000
Received: from CY4PEPF0000EE30.namprd05.prod.outlook.com
 (2603:10b6:5:337:cafe::72) by DM6PR07CA0076.outlook.office365.com
 (2603:10b6:5:337::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.44 via Frontend
 Transport; Wed, 2 Aug 2023 07:53:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000EE30.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6652.19 via Frontend Transport; Wed, 2 Aug 2023 07:53:14 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Wed, 2 Aug 2023
 00:53:02 -0700
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Wed, 2 Aug 2023 00:52:59 -0700
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <petrm@nvidia.com>, <razor@blackwall.org>,
	<mirsad.todorovac@alu.unizg.hr>, Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH net 15/17] selftests: forwarding: bridge_mdb: Fix failing test with old libnet
Date: Wed, 2 Aug 2023 10:51:16 +0300
Message-ID: <20230802075118.409395-16-idosch@nvidia.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230802075118.409395-1-idosch@nvidia.com>
References: <20230802075118.409395-1-idosch@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE30:EE_|IA1PR12MB7496:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ff6f53e-24a7-4e24-cb4e-08db932d8695
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	apJdkFf9tVcZEQ6BujGAkJmFTxTdo4uAF0LGdl/TYP4YYdSoUnypPHdR7iWs5/IKoKCRsoZpLCtSQza8pxF4R3zBG0mqiCNLUaBKWPY0E/pj7fbgK1eGDHL2Xb8AGTZ4okpVUzCP5hl2drvKMygWZ0UCOlwNYNVmMelQ/6QFUyS19Ja/CsTojcTYjixK5M3BOokWdCC7MZL7t92hsHgvzpdyIBFigS7+55Y4YyVHR59HIc23rv0CwvVOjmeIR2YXg/LOC4mfx1r2brsZO3HxM7ysbH7OwCsgqXZYsUnbzFiduc/9JJVXgU0thywEizEfou7XIkPDmxfsEQLqGAW8DivB0ishNZp6ag4Paujma6jsEuTKV9Kj62EoWVrwqtdeznbJCw80JTcqe8OG7LVitTIV1cc6P+O1nVmfbq8CrmgduIjZDFaPSigskh+2KZmvk+NLhUf/+O+E0t/Tnih5xdzdkWVfQekWJe/qYqMEpReCdnep/enFoD/t46Px5UWRR5tRSCGzPoljI2A8/ClTmxUEYKvfaiwb9tQw++U1ONuUvH55XZUzuu9Q/uhgvutlkF9Psop7kibnlyAaAbbfEDgIHw8sr9SMRPJBGUaeVnbrCAYawBCHt+EMLMp1BTN5WuuiZrpAzzq62JfqNssTdk0x5vfLIuuqK9BxfUvkRfwzCU7gkcpm72yrlIfkXk8f6mck1hTrjZNRUfxU0AnoWIuqw/6aWYyvGipJmWd5GRefBm07iMYYG4pk14iKl+mwFc3A31eaG0PMSbdXCy5hJ3WZSELk1WHn5E2ZP4QlLoQ=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(346002)(136003)(39860400002)(451199021)(82310400008)(40470700004)(46966006)(36840700001)(36860700001)(1076003)(5660300002)(70586007)(70206006)(966005)(4326008)(6916009)(7636003)(107886003)(40480700001)(356005)(40460700003)(54906003)(82740400003)(478600001)(426003)(66574015)(2616005)(2906002)(8936002)(8676002)(41300700001)(36756003)(316002)(336012)(186003)(16526019)(47076005)(86362001)(6666004)(26005)(83380400001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2023 07:53:14.2426
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ff6f53e-24a7-4e24-cb4e-08db932d8695
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE30.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7496
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
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

Fixes: b6d00da08610 ("selftests: forwarding: Add bridge MDB test")
Reported-by: Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
Closes: https://lore.kernel.org/netdev/adc5e40d-d040-a65e-eb26-edf47dac5b02@alu.unizg.hr/
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
Tested-by: Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
---
 .../selftests/net/forwarding/bridge_mdb.sh    | 46 ++++++++++---------
 1 file changed, 24 insertions(+), 22 deletions(-)

diff --git a/tools/testing/selftests/net/forwarding/bridge_mdb.sh b/tools/testing/selftests/net/forwarding/bridge_mdb.sh
index 6f830b5f03c9..4853b8e4f8d3 100755
--- a/tools/testing/selftests/net/forwarding/bridge_mdb.sh
+++ b/tools/testing/selftests/net/forwarding/bridge_mdb.sh
@@ -850,6 +850,7 @@ cfg_test()
 __fwd_test_host_ip()
 {
 	local grp=$1; shift
+	local dmac=$1; shift
 	local src=$1; shift
 	local mode=$1; shift
 	local name
@@ -872,27 +873,27 @@ __fwd_test_host_ip()
 	# Packet should only be flooded to multicast router ports when there is
 	# no matching MDB entry. The bridge is not configured as a multicast
 	# router port.
-	$MZ $mode $h1.10 -c 1 -p 128 -A $src -B $grp -t udp -q
+	$MZ $mode $h1.10 -a own -b $dmac -c 1 -p 128 -A $src -B $grp -t udp -q
 	tc_check_packets "dev br0 ingress" 1 0
 	check_err $? "Packet locally received after flood"
 
 	# Install a regular port group entry and expect the packet to not be
 	# locally received.
 	bridge mdb add dev br0 port $swp2 grp $grp temp vid 10
-	$MZ $mode $h1.10 -c 1 -p 128 -A $src -B $grp -t udp -q
+	$MZ $mode $h1.10 -a own -b $dmac -c 1 -p 128 -A $src -B $grp -t udp -q
 	tc_check_packets "dev br0 ingress" 1 0
 	check_err $? "Packet locally received after installing a regular entry"
 
 	# Add a host entry and expect the packet to be locally received.
 	bridge mdb add dev br0 port br0 grp $grp temp vid 10
-	$MZ $mode $h1.10 -c 1 -p 128 -A $src -B $grp -t udp -q
+	$MZ $mode $h1.10 -a own -b $dmac -c 1 -p 128 -A $src -B $grp -t udp -q
 	tc_check_packets "dev br0 ingress" 1 1
 	check_err $? "Packet not locally received after adding a host entry"
 
 	# Remove the host entry and expect the packet to not be locally
 	# received.
 	bridge mdb del dev br0 port br0 grp $grp vid 10
-	$MZ $mode $h1.10 -c 1 -p 128 -A $src -B $grp -t udp -q
+	$MZ $mode $h1.10 -a own -b $dmac -c 1 -p 128 -A $src -B $grp -t udp -q
 	tc_check_packets "dev br0 ingress" 1 1
 	check_err $? "Packet locally received after removing a host entry"
 
@@ -905,8 +906,8 @@ __fwd_test_host_ip()
 
 fwd_test_host_ip()
 {
-	__fwd_test_host_ip "239.1.1.1" "192.0.2.1" "-4"
-	__fwd_test_host_ip "ff0e::1" "2001:db8:1::1" "-6"
+	__fwd_test_host_ip "239.1.1.1" "01:00:5e:01:01:01" "192.0.2.1" "-4"
+	__fwd_test_host_ip "ff0e::1" "33:33:00:00:00:01" "2001:db8:1::1" "-6"
 }
 
 fwd_test_host_l2()
@@ -966,6 +967,7 @@ fwd_test_host()
 __fwd_test_port_ip()
 {
 	local grp=$1; shift
+	local dmac=$1; shift
 	local valid_src=$1; shift
 	local invalid_src=$1; shift
 	local mode=$1; shift
@@ -999,43 +1001,43 @@ __fwd_test_port_ip()
 		vlan_ethtype $eth_type vlan_id 10 dst_ip $grp \
 		src_ip $invalid_src action drop
 
-	$MZ $mode $h1.10 -c 1 -p 128 -A $valid_src -B $grp -t udp -q
+	$MZ $mode $h1.10 -a own -b $dmac -c 1 -p 128 -A $valid_src -B $grp -t udp -q
 	tc_check_packets "dev $h2 ingress" 1 0
 	check_err $? "Packet from valid source received on H2 before adding entry"
 
-	$MZ $mode $h1.10 -c 1 -p 128 -A $invalid_src -B $grp -t udp -q
+	$MZ $mode $h1.10 -a own -b $dmac -c 1 -p 128 -A $invalid_src -B $grp -t udp -q
 	tc_check_packets "dev $h2 ingress" 2 0
 	check_err $? "Packet from invalid source received on H2 before adding entry"
 
 	bridge mdb add dev br0 port $swp2 grp $grp vid 10 \
 		filter_mode $filter_mode source_list $src_list
 
-	$MZ $mode $h1.10 -c 1 -p 128 -A $valid_src -B $grp -t udp -q
+	$MZ $mode $h1.10 -a own -b $dmac -c 1 -p 128 -A $valid_src -B $grp -t udp -q
 	tc_check_packets "dev $h2 ingress" 1 1
 	check_err $? "Packet from valid source not received on H2 after adding entry"
 
-	$MZ $mode $h1.10 -c 1 -p 128 -A $invalid_src -B $grp -t udp -q
+	$MZ $mode $h1.10 -a own -b $dmac -c 1 -p 128 -A $invalid_src -B $grp -t udp -q
 	tc_check_packets "dev $h2 ingress" 2 0
 	check_err $? "Packet from invalid source received on H2 after adding entry"
 
 	bridge mdb replace dev br0 port $swp2 grp $grp vid 10 \
 		filter_mode exclude
 
-	$MZ $mode $h1.10 -c 1 -p 128 -A $valid_src -B $grp -t udp -q
+	$MZ $mode $h1.10 -a own -b $dmac -c 1 -p 128 -A $valid_src -B $grp -t udp -q
 	tc_check_packets "dev $h2 ingress" 1 2
 	check_err $? "Packet from valid source not received on H2 after allowing all sources"
 
-	$MZ $mode $h1.10 -c 1 -p 128 -A $invalid_src -B $grp -t udp -q
+	$MZ $mode $h1.10 -a own -b $dmac -c 1 -p 128 -A $invalid_src -B $grp -t udp -q
 	tc_check_packets "dev $h2 ingress" 2 1
 	check_err $? "Packet from invalid source not received on H2 after allowing all sources"
 
 	bridge mdb del dev br0 port $swp2 grp $grp vid 10
 
-	$MZ $mode $h1.10 -c 1 -p 128 -A $valid_src -B $grp -t udp -q
+	$MZ $mode $h1.10 -a own -b $dmac -c 1 -p 128 -A $valid_src -B $grp -t udp -q
 	tc_check_packets "dev $h2 ingress" 1 2
 	check_err $? "Packet from valid source received on H2 after deleting entry"
 
-	$MZ $mode $h1.10 -c 1 -p 128 -A $invalid_src -B $grp -t udp -q
+	$MZ $mode $h1.10 -a own -b $dmac -c 1 -p 128 -A $invalid_src -B $grp -t udp -q
 	tc_check_packets "dev $h2 ingress" 2 1
 	check_err $? "Packet from invalid source received on H2 after deleting entry"
 
@@ -1047,11 +1049,11 @@ __fwd_test_port_ip()
 
 fwd_test_port_ip()
 {
-	__fwd_test_port_ip "239.1.1.1" "192.0.2.1" "192.0.2.2" "-4" "exclude"
-	__fwd_test_port_ip "ff0e::1" "2001:db8:1::1" "2001:db8:1::2" "-6" \
+	__fwd_test_port_ip "239.1.1.1" "01:00:5e:01:01:01" "192.0.2.1" "192.0.2.2" "-4" "exclude"
+	__fwd_test_port_ip "ff0e::1" "33:33:00:00:00:01" "2001:db8:1::1" "2001:db8:1::2" "-6" \
 		"exclude"
-	__fwd_test_port_ip "239.1.1.1" "192.0.2.1" "192.0.2.2" "-4" "include"
-	__fwd_test_port_ip "ff0e::1" "2001:db8:1::1" "2001:db8:1::2" "-6" \
+	__fwd_test_port_ip "239.1.1.1" "01:00:5e:01:01:01" "192.0.2.1" "192.0.2.2" "-4" "include"
+	__fwd_test_port_ip "ff0e::1" "33:33:00:00:00:01" "2001:db8:1::1" "2001:db8:1::2" "-6" \
 		"include"
 }
 
@@ -1127,7 +1129,7 @@ ctrl_igmpv3_is_in_test()
 		filter_mode include source_list 192.0.2.1
 
 	# IS_IN ( 192.0.2.2 )
-	$MZ $h1.10 -c 1 -A 192.0.2.1 -B 239.1.1.1 \
+	$MZ $h1.10 -c 1 -a own -b 01:00:5e:01:01:01 -A 192.0.2.1 -B 239.1.1.1 \
 		-t ip proto=2,p=$(igmpv3_is_in_get 239.1.1.1 192.0.2.2) -q
 
 	bridge -d mdb show dev br0 vid 10 | grep 239.1.1.1 | grep -q 192.0.2.2
@@ -1140,7 +1142,7 @@ ctrl_igmpv3_is_in_test()
 		filter_mode include source_list 192.0.2.1
 
 	# IS_IN ( 192.0.2.2 )
-	$MZ $h1.10 -c 1 -A 192.0.2.1 -B 239.1.1.1 \
+	$MZ $h1.10 -a own -b 01:00:5e:01:01:01 -c 1 -A 192.0.2.1 -B 239.1.1.1 \
 		-t ip proto=2,p=$(igmpv3_is_in_get 239.1.1.1 192.0.2.2) -q
 
 	bridge -d mdb show dev br0 vid 10 | grep 239.1.1.1 | grep -v "src" | \
@@ -1167,7 +1169,7 @@ ctrl_mldv2_is_in_test()
 
 	# IS_IN ( 2001:db8:1::2 )
 	local p=$(mldv2_is_in_get fe80::1 ff0e::1 2001:db8:1::2)
-	$MZ -6 $h1.10 -c 1 -A fe80::1 -B ff0e::1 \
+	$MZ -6 $h1.10 -a own -b 33:33:00:00:00:01 -c 1 -A fe80::1 -B ff0e::1 \
 		-t ip hop=1,next=0,p="$p" -q
 
 	bridge -d mdb show dev br0 vid 10 | grep ff0e::1 | \
@@ -1181,7 +1183,7 @@ ctrl_mldv2_is_in_test()
 		filter_mode include source_list 2001:db8:1::1
 
 	# IS_IN ( 2001:db8:1::2 )
-	$MZ -6 $h1.10 -c 1 -A fe80::1 -B ff0e::1 \
+	$MZ -6 $h1.10 -a own -b 33:33:00:00:00:01 -c 1 -A fe80::1 -B ff0e::1 \
 		-t ip hop=1,next=0,p="$p" -q
 
 	bridge -d mdb show dev br0 vid 10 | grep ff0e::1 | grep -v "src" | \
-- 
2.40.1


