Return-Path: <netdev+bounces-23560-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E5DA76C7AC
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 09:58:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A94BA1C211FE
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 07:58:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 485E753A0;
	Wed,  2 Aug 2023 07:53:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3528E7476
	for <netdev@vger.kernel.org>; Wed,  2 Aug 2023 07:53:21 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on20601.outbound.protection.outlook.com [IPv6:2a01:111:f400:7eae::601])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 123493C26
	for <netdev@vger.kernel.org>; Wed,  2 Aug 2023 00:53:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AG3AbP2ByW20ZBZnnq/3EgKZGMUVpXbXdviIwYbYM9knfEj3lUlRSasdB5hFZsQWB9M3rJUGjiUK859CG1SDEsAoVvqIgSvmF4i1ZQH7PcifQrt8Bx2usFrERX7GSVTJEizU93EY+hr/YIbw3JkbNA0Hd3rDYBG1s13CDtdOVpskoC2kg1B7lrN2tJx1JOzdSqU1jYa0bHKWtnnzJohsefoJ/MvNPewvpJko5oUcGDVItStMMEnYRRKFaLp/I2Y5mibav8QYiAmOEFH7zjnFoGUdNnYeN8/P9u0OC8KFhhYtseoDyG3KOwA4bdASvLNpYN9iOT+pGQFZxVc5sdEsJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ehIchy6ee/mMpqzkQ1NMYacqJj0bAWFZqY+uFIqdo3Y=;
 b=Pj4AoCqQkThSoWeyfMXYO2bizowdUSSiYeKqIDMFFPQ2AdlEV5B29QtARgqtYCTvF7gy0G13V1FMsL0l/YuufrNPaU6FeUCq1c3OTJSYBB9tJMgSzd1P/CZjRvMF8bjFTRsZ6Q3mcY7+aHyqEm3w4U5HaafoYTqvwT1Wub8fsk5e3e1k5Pfdi0mwmyNC89WeduZhnWJS2/a67MjKgjA6LGWzQPfWA98D/b2Eu9fuQePSxwhRns2aecMFIDfxBRwCYKOx2rlLSgmXFaMIBSumWEeeyvlZGOYJw16L3HRRamKaiZvW7OlHYgRoGtvXhBt9b05CD9vAGPGH0rBI8MXH1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ehIchy6ee/mMpqzkQ1NMYacqJj0bAWFZqY+uFIqdo3Y=;
 b=TmKu810K/YbjHDl0HBSTuhyaRPSPJvZaSrKmNhtuvx4LyW5v3HXZACGTfumQxcZ7AerCKNzXVtciltracrjVh0Gmg8la0zHy2cgRmBKFdOstMXS8Y4nSw55pIZ82suG8ysZ2wGrHAdAmZ1xu2cMWLkdH1j8Q57dDU5FcVM3RHeWsJbtkffgz2lmYy9Ukzvl0LOG7WEwKQhRIc+TA2A7bLfh7nqrW20KzRXiZCx8bCWrEI3stmyF/NH+BQFfwlLXMGdgxCdpIEunaZ4GoiO8gZ+UCCv2VapRt3+s5oThW+nJhwXO+ixlyD3jmfB4EMmi9h+4EDelbjsXpHR6Ooj/7QA==
Received: from BY3PR05CA0023.namprd05.prod.outlook.com (2603:10b6:a03:254::28)
 by DM4PR12MB5133.namprd12.prod.outlook.com (2603:10b6:5:390::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.45; Wed, 2 Aug
 2023 07:53:16 +0000
Received: from MWH0EPF000971E9.namprd02.prod.outlook.com
 (2603:10b6:a03:254:cafe::1a) by BY3PR05CA0023.outlook.office365.com
 (2603:10b6:a03:254::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.19 via Frontend
 Transport; Wed, 2 Aug 2023 07:53:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MWH0EPF000971E9.mail.protection.outlook.com (10.167.243.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6652.19 via Frontend Transport; Wed, 2 Aug 2023 07:53:16 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Wed, 2 Aug 2023
 00:53:05 -0700
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Wed, 2 Aug 2023 00:53:02 -0700
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <petrm@nvidia.com>, <razor@blackwall.org>,
	<mirsad.todorovac@alu.unizg.hr>, Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH net 16/17] selftests: forwarding: bridge_mdb_max: Fix failing test with old libnet
Date: Wed, 2 Aug 2023 10:51:17 +0300
Message-ID: <20230802075118.409395-17-idosch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E9:EE_|DM4PR12MB5133:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c03eb57-d9fb-4d9e-59b1-08db932d87e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	U3hTy5fOM/XsX5aBUOnkD8ItPc5+P3WAEv9Qn22On7PnOqyA95PWnytMkj4DkqSZxQK0Irfy5vysS8L58b82de9r1ZCZF2DqT05oOgfWvaYVXNOJrXtK9ziYFRGRsVuvaFx3rcI9ZHA/eRjEVMfWKxDZzs7GCPeaTptOWKrhRdqEu0cgheHLXl6dRUPNsBtib8K1MswjFzo6OfO8Umqm4gffye8ycHP76UWsnQIH06a/5gUOlzj20RESlv0e728iiGvOlEYr4xc2OL32ohKShWnY5jO+HhB3V2eQ7MSV2Jas9Ug9evX1kL4I9CmXxdvg+xTRiS6mGeAUkvULucVspdVgrhs6XKWkYH7JpB/ICzA+DXehw9vnivinAMkiwVdNsvxgqrNbvklkFK9fMsdHf/ymqQvWpzka74c9Kt/XZPT5xHRxh0uyRrkFf02fP0fCgN0rFytnUhfA6Ghx4yzYg2ixm6ZkM2mULu9dTwTWnqfpcv3adrnjmHNJ4n9/gmzkQ3uu+BKA2Qs8/HRAJv/qXZTdVOB7xVLl5TQ5vY9E+RyodNKcxOjLrohbc7+M7Norc9q/gdgLsfloPeIhF2wOz0YCicXRYg0py3kp/pF5egluIdHnlOe8DeJHHXz8drK8uPDo+NdCgotzcUpLnFmveY14VriSZG7DUmYpHiELyVZvttl2BgSB3jpVZHrvLUO1XKNyyTnCI/YasK8QMRPusxi/wLIXKfi4yvyy9ibFI+9lS+ic4CalmRW/RM3Pb58bCUrfJaxgZh0B4s38Eq05LZ1FDEhPh/fbnysO0ZDGJns=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(136003)(39860400002)(376002)(346002)(396003)(82310400008)(451199021)(36840700001)(46966006)(40470700004)(40460700003)(16526019)(426003)(2616005)(336012)(107886003)(1076003)(26005)(186003)(83380400001)(47076005)(36860700001)(316002)(70206006)(70586007)(2906002)(4326008)(6916009)(5660300002)(41300700001)(8676002)(8936002)(6666004)(966005)(54906003)(478600001)(40480700001)(356005)(7636003)(82740400003)(86362001)(36756003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2023 07:53:16.5148
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c03eb57-d9fb-4d9e-59b1-08db932d87e9
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000971E9.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5133
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
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

Fixes: 3446dcd7df05 ("selftests: forwarding: bridge_mdb_max: Add a new selftest")
Reported-by: Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
Closes: https://lore.kernel.org/netdev/adc5e40d-d040-a65e-eb26-edf47dac5b02@alu.unizg.hr/
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
Tested-by: Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
---
 .../selftests/net/forwarding/bridge_mdb_max.sh     | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/net/forwarding/bridge_mdb_max.sh b/tools/testing/selftests/net/forwarding/bridge_mdb_max.sh
index fa762b716288..3da9d93ab36f 100755
--- a/tools/testing/selftests/net/forwarding/bridge_mdb_max.sh
+++ b/tools/testing/selftests/net/forwarding/bridge_mdb_max.sh
@@ -252,7 +252,8 @@ ctl4_entries_add()
 	local IPs=$(seq -f 192.0.2.%g 1 $((n - 1)))
 	local peer=$(locus_dev_peer $locus)
 	local GRP=239.1.1.${grp}
-	$MZ $peer -c 1 -A 192.0.2.1 -B $GRP \
+	local dmac=01:00:5e:01:01:$(printf "%02x" $grp)
+	$MZ $peer -a own -b $dmac -c 1 -A 192.0.2.1 -B $GRP \
 		-t ip proto=2,p=$(igmpv3_is_in_get $GRP $IPs) -q
 	sleep 1
 
@@ -272,7 +273,8 @@ ctl4_entries_del()
 
 	local peer=$(locus_dev_peer $locus)
 	local GRP=239.1.1.${grp}
-	$MZ $peer -c 1 -A 192.0.2.1 -B 224.0.0.2 \
+	local dmac=01:00:5e:00:00:02
+	$MZ $peer -a own -b $dmac -c 1 -A 192.0.2.1 -B 224.0.0.2 \
 		-t ip proto=2,p=$(igmpv2_leave_get $GRP) -q
 	sleep 1
 	! bridge mdb show dev br0 | grep -q $GRP
@@ -289,8 +291,10 @@ ctl6_entries_add()
 	local peer=$(locus_dev_peer $locus)
 	local SIP=fe80::1
 	local GRP=ff0e::${grp}
+	local dmac=33:33:00:00:00:$(printf "%02x" $grp)
 	local p=$(mldv2_is_in_get $SIP $GRP $IPs)
-	$MZ -6 $peer -c 1 -A $SIP -B $GRP -t ip hop=1,next=0,p="$p" -q
+	$MZ -6 $peer -a own -b $dmac -c 1 -A $SIP -B $GRP \
+		-t ip hop=1,next=0,p="$p" -q
 	sleep 1
 
 	local nn=$(bridge mdb show dev br0 | grep $GRP | wc -l)
@@ -310,8 +314,10 @@ ctl6_entries_del()
 	local peer=$(locus_dev_peer $locus)
 	local SIP=fe80::1
 	local GRP=ff0e::${grp}
+	local dmac=33:33:00:00:00:$(printf "%02x" $grp)
 	local p=$(mldv1_done_get $SIP $GRP)
-	$MZ -6 $peer -c 1 -A $SIP -B $GRP -t ip hop=1,next=0,p="$p" -q
+	$MZ -6 $peer -a own -b $dmac -c 1 -A $SIP -B $GRP \
+		-t ip hop=1,next=0,p="$p" -q
 	sleep 1
 	! bridge mdb show dev br0 | grep -q $GRP
 }
-- 
2.40.1


