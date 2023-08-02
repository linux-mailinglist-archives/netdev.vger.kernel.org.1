Return-Path: <netdev+bounces-23558-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC9C676C7A9
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 09:57:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF21B1C21213
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 07:57:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43DC36FCE;
	Wed,  2 Aug 2023 07:53:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 314D26FCD
	for <netdev@vger.kernel.org>; Wed,  2 Aug 2023 07:53:16 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2051.outbound.protection.outlook.com [40.107.96.51])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9AC23C26
	for <netdev@vger.kernel.org>; Wed,  2 Aug 2023 00:53:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q/YBLiwlQwUQEdAzT82EVbh3UIxusJq1gGaHiERqDRl2X23+Rg6Brey1/IjqYcNBkCpiySjPvVFfO1MKiCtJPPXrzcpJKzqJ43Q8aMfgrXp+Njjr05Jv59Gn8cNyGvRrWxPkB7tvzvijJsD1CSj5A6hQT0RqDFwhlcalM//hfckB36O9lp5X67Hcye4emJH4VFD391T63DV9mv8mX5itAA8zkYytIYBr96bFlTHpkCeiNkSqysWvpGviCeZw5VunPvRBBBOW496mh3qLWJS7OJKEh8osqKTQyslmml4v6xhpKBqbAPw1p/7m3GNan7w0HGI0MHhFeh7DU+2CwKdZNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q9wct6EEFEb7A4xLSHyl5ScXjsMYTfimhvIG3q9vHrY=;
 b=XvuX6C3bj01+GH+iMthOWTqCp/FCkxrMtHbvnhPYlczpTYUMq4fSdhvJi9dKZXSkGkOcDVckn1XDBf7pumrMMlZC/CZ4YY9l5AQcQ2wvGwRtQV5H9jSsiLv3n5MR8gvqXxVRjZAS+1HtPtkAOKbWrc9EoyKWlRBjhyS71MXrWSAe7X/blQGl7zquY7xFBI6ufZm9yhbtHnNZgnEJ/AamUChMkm8rxucr8yx04CEy7LLu9MqCJ2bubJMiV6/BL0zaL1ifrVytMzcXXvKEfQLn0ZkRGejpcD7lq5APqR1rtHmW1oxnv6QMNySHtmhK4OR5LdD6aQtHWjhK7F4lg7oS3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q9wct6EEFEb7A4xLSHyl5ScXjsMYTfimhvIG3q9vHrY=;
 b=lygWFl4jxols1XVlWImk+eBUO3O4JfUTDN1KhBQGObpPhKT5IIcvNSY3n3uJuv2aZeHyEga0daYYFaYun1u3DEdUunOhfAqAH8RlDorc/xk/9KotyiPbvjqC5xdDtw7gYubnQo07+7EMSOR23l0Dt9xhS7iO/TJbvbURoyEyyJ327w0o55RMbKI4zks9a4gM7T1O7F46OSuTrF+/M8I99WOD4apXcV90GNw5MH5oSnIZGiqRqXB+pMpu5vkhwv9+G+g6+Z9DiTidA/fk/N3IysvxGiJ64StHGvYAtExcxi8qRwdx8+3MV91krOGJIZw3bAi0XSFnTx4wH0NA79VhtA==
Received: from CY5PR04CA0019.namprd04.prod.outlook.com (2603:10b6:930:1e::22)
 by IA1PR12MB6481.namprd12.prod.outlook.com (2603:10b6:208:3aa::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.45; Wed, 2 Aug
 2023 07:53:12 +0000
Received: from CY4PEPF0000EE32.namprd05.prod.outlook.com
 (2603:10b6:930:1e:cafe::a8) by CY5PR04CA0019.outlook.office365.com
 (2603:10b6:930:1e::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.19 via Frontend
 Transport; Wed, 2 Aug 2023 07:53:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000EE32.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6652.19 via Frontend Transport; Wed, 2 Aug 2023 07:53:11 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Wed, 2 Aug 2023
 00:52:59 -0700
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Wed, 2 Aug 2023 00:52:56 -0700
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <petrm@nvidia.com>, <razor@blackwall.org>,
	<mirsad.todorovac@alu.unizg.hr>, Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH net 14/17] selftests: forwarding: tc_flower_l2_miss: Fix failing test with old libnet
Date: Wed, 2 Aug 2023 10:51:15 +0300
Message-ID: <20230802075118.409395-15-idosch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE32:EE_|IA1PR12MB6481:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f72d8c7-f47b-4cb7-6b7f-08db932d8524
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	fH8w76Qb58h0OK0aqwSMay8ddXJORjOxm7cb6UAqSebsCvS9BlLD1/9R6o7bxDY/sE6Md2A4i3RZWZILwzZpGuLb1QbtQMn0YvD8Rpx5QC58UtYQMDP3N0opYjH0+PlbQo47DNIWsfRUHB6UDaIa6bO4XUkIdoEbMCCf58/LuXrpeSlGAvXbtsxCiX8Wt0SLhj2fxQJ/6VKANdmI/vt4rJdjRe9D0ZLN2oDs3Tk0JTfiB+KmCkBgwLFFLphwlE5lgNsd/GH726xFAV17ch2OPsRTOtOx83U+UT6qIcfEztl+Nr+Zjud2mMC5eymBI8Z3Nd7R6w0QFgwu3la3GI2zG6V+D4XTY1lnS7HGh/+hBjH5AbdCle4p5YfYxxNNjTPvGOxjo5pdLMoCwwXmGM+RG5vMme2VB+Oh5BxbSUwynAg+dv/m9IyNRbeVACnBvLvnxQ7ZeLJ/fHrUS52yPQEAZCWRQiH340fVassQhZAyXtTUhWtmLXNa/ev6ocoFISiS9FOdy3EKlUv3jInuJVJsYI31gE3aZtP5538lH9HGj7pwxl1Wk0IB1gODcp0J5hs3WGc/JaOz3GAmJ8oZR7qzCaLlj0funRrCLt7UibhBzWeteFG5/XiaUpXJl5U+BSje6JCn32l6C9QmOPl+ZRhCRMB34WTgVB+KqRi36kaPkDKZlHF8VgRLUhB3gJwL6TqiXr4UVrRs6/eurePuRmqbzIbHrM0eCTPsuXWXlGW2wflZlM7LFQ4vH6KwlgBfEUuUSttnkbIAi8IOJMBJ3pgAzVN7hyNRNvmMtG6IfLkWPkU=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(136003)(396003)(346002)(451199021)(82310400008)(46966006)(36840700001)(40470700004)(40480700001)(336012)(186003)(16526019)(40460700003)(2616005)(36756003)(966005)(316002)(86362001)(7636003)(478600001)(54906003)(70586007)(70206006)(6666004)(4326008)(6916009)(82740400003)(356005)(26005)(1076003)(41300700001)(107886003)(8936002)(8676002)(426003)(47076005)(83380400001)(36860700001)(5660300002)(2906002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2023 07:53:11.8218
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f72d8c7-f47b-4cb7-6b7f-08db932d8524
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE32.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6481
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


