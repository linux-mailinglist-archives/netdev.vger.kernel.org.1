Return-Path: <netdev+bounces-23556-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19ECF76C7A3
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 09:56:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D17A1C21187
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 07:56:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AE736AB0;
	Wed,  2 Aug 2023 07:53:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 286145255
	for <netdev@vger.kernel.org>; Wed,  2 Aug 2023 07:53:12 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on20601.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe5a::601])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD4053C23
	for <netdev@vger.kernel.org>; Wed,  2 Aug 2023 00:53:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AOGQ/ho3Z/wNuLFYmXsstnLTorrYL4DvMjQRAejYXZm4iqTkc1ob2SDjc8YU8nxsT5PHQtbEIgtfL3kYqgVS9rJ2pPzREEetBZe7ixsNaIc2/y0RVyLwpkXextm/c+vcYpfK6SVdNVEr++J7eA/Xz/z5X/fONfUPl711BsQNvXK/DkVn6aQHdxSO+9xsJO2rIuFmr+jIUN6+sMc7J+x4eozMV+eyf3gnm6eQx8C6f5iM7+CSnKSUl6OwLJIn5jvyGmxXdrR2cfkBjlXRiHacEkr22tew6xVRZJ29Ph+c9o3aqrukA/3BMCos8qXRRCUSnrKmLcAlJ0zAzBCIbcKi9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ofDTqJ1O9BxqHiVUbA/OF3A4nySad5YAD+FpSUHT7Yk=;
 b=NkkSSEVJSahk2thIrLJ5bBxLfBQJ544rsAyVzFxH++/90kf31TK7luOnr99KgwzD8YytweeqxW4YK2vby4mvf+xpdGNldTVSycwyLrukKvaAB72CarvM3WF6oQ1GmIjx/eOwjdoZ5E+pwPwFq1hm26HT6j1zIdDI0nDL1jJM/Ikz0jUe2yibntdKuT09FKzbkrM6PP8qAfML+NmbQp5dki57gNJvvF/G1wQqid1vZSBuDT46/mLx86EljcoqBGScksZhrqMy4U+CxOjhsxCOfydWsIvVBLsJHuKuxlXIsCU/RRxWSdL6ocjxAlpUOATgRDMa8skBZPhLJUOyaHv62g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ofDTqJ1O9BxqHiVUbA/OF3A4nySad5YAD+FpSUHT7Yk=;
 b=GkkfkpHItkjkDm1k1nVQ6P7IjH02dDDUoEeGNYVDZSx5QDMGaY/nk+wguLC7a2ysBegv8OVzMT/ahozD5pMwtt+3QbZMdt2BGBpWtwAUnCcBKN2cns2BTNUgwll8zf6DfB/f6hGC6do3foTBczqgDSUUPnp93L0uNfFzDwEWbqnt0m7nTUI5rcifs7tayDdYO+/ZLD2k7UsV4WLAkQ37dAu5th2Ro/Io/BVWX1gJCiyVVEV7jveLAm1FUUsQ9g/HanmgYqlqAI66jpougAmUOKjEank8R3q0+wvNpJ5U7irFDTsh0lValPZFrJUk4ZprgzhT94wJkevbDm4vFYKe7w==
Received: from CY5PR19CA0124.namprd19.prod.outlook.com (2603:10b6:930:64::21)
 by LV2PR12MB6014.namprd12.prod.outlook.com (2603:10b6:408:170::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.45; Wed, 2 Aug
 2023 07:53:06 +0000
Received: from CY4PEPF0000EE31.namprd05.prod.outlook.com
 (2603:10b6:930:64:cafe::ae) by CY5PR19CA0124.outlook.office365.com
 (2603:10b6:930:64::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.19 via Frontend
 Transport; Wed, 2 Aug 2023 07:53:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000EE31.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6652.19 via Frontend Transport; Wed, 2 Aug 2023 07:53:05 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Wed, 2 Aug 2023
 00:52:50 -0700
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Wed, 2 Aug 2023 00:52:47 -0700
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <petrm@nvidia.com>, <razor@blackwall.org>,
	<mirsad.todorovac@alu.unizg.hr>, Ido Schimmel <idosch@nvidia.com>,
	<dcaratti@redhat.com>
Subject: [PATCH net 11/17] selftests: forwarding: tc_actions: Use ncat instead of nc
Date: Wed, 2 Aug 2023 10:51:12 +0300
Message-ID: <20230802075118.409395-12-idosch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE31:EE_|LV2PR12MB6014:EE_
X-MS-Office365-Filtering-Correlation-Id: dd7138b1-2757-4c88-5d0f-08db932d814e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	8fyo1J4rTbtljIVG9MbTarFss5AmHA25w1qzhImAwUY2dvq5/Fsn6EdI3OXJ3GZrVn8FrU3zFScEoG+SPbmKkbW48Q+qPLkVG2eXznQY4UmL44Zv/F3bPJChSJbacSWJL5mUqvIYbdF7iBKuYwD04sCe/DqpjphtD6b/otGNrqtNpFtqGLQc4gL5HEOOisnvsqUdhLRvZGcm9D7LqJ4mOrkJ0FLjlg98+Cgx10lMH9WuJ6pqecnPmXyMqgoPFiF9e/Bx/qqWBuCM4swOUX/oO6rfbpt+ZMWiSCNyU/a1GQPtOCEdntuCXwvYxEX7LLc2pmq7XcFMl/MJuvjkqZEmTh2hMflEi+ZwpmwEe+pQoWJVfTtWxQq/8nZHhpd6QzUWK1nRDy/q3//5FPe+gRgniJdZPhpyyDOYZKAK3RLGy5skBzK2XooEXzi1g921Il1VZx1+iOppmaS4SVn49YEWlFhK9I44sJtSwtxRSRK3sIeYaqs9VrhMte7wZmBqQxmcf4pLW0QqvBuE8RnhL0OCgyCL/hIPg0FOgeX2acsi2ruXTc0h3Zz1Qy7G0zmgrWGkhU8FtIsRo0adhFrF9RQuHDYy69cVDTkgvfPuyeV/+/afCmqlVhMih+xuB7Det4VXF0A5KLTRyenP78yyMGm4xiag1yAjzrze6cOmnHCp6ClRALmCZVp/BYQPtRNRXtGPRGrseUc78BKN2b2wEMG5qmSvw11CuCxBgZdlAUKqo8Equdhp7VFHDeS6xopJP6ya68lthDdVMxIVyUINFz8xQjmrXp13OjAv2iV3f7jBzNo=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(136003)(376002)(39860400002)(82310400008)(451199021)(36840700001)(46966006)(40470700004)(5660300002)(83380400001)(36756003)(16526019)(47076005)(426003)(8676002)(8936002)(36860700001)(54906003)(966005)(2616005)(2906002)(70586007)(6666004)(70206006)(478600001)(82740400003)(4326008)(6916009)(356005)(7636003)(86362001)(40480700001)(316002)(186003)(336012)(1076003)(40460700003)(26005)(41300700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2023 07:53:05.3858
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dd7138b1-2757-4c88-5d0f-08db932d814e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE31.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB6014
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

The test relies on 'nc' being the netcat version from the nmap project.
While this seems to be the case on Fedora, it is not the case on Ubuntu,
resulting in failures such as [1].

Fix by explicitly using the 'ncat' utility from the nmap project and the
skip the test in case it is not installed.

[1]
 # timeout set to 0
 # selftests: net/forwarding: tc_actions.sh
 # TEST: gact drop and ok (skip_hw)                                    [ OK ]
 # TEST: mirred egress flower redirect (skip_hw)                       [ OK ]
 # TEST: mirred egress flower mirror (skip_hw)                         [ OK ]
 # TEST: mirred egress matchall mirror (skip_hw)                       [ OK ]
 # TEST: mirred_egress_to_ingress (skip_hw)                            [ OK ]
 # nc: invalid option -- '-'
 # usage: nc [-46CDdFhklNnrStUuvZz] [-I length] [-i interval] [-M ttl]
 #         [-m minttl] [-O length] [-P proxy_username] [-p source_port]
 #         [-q seconds] [-s sourceaddr] [-T keyword] [-V rtable] [-W recvlimit]
 #         [-w timeout] [-X proxy_protocol] [-x proxy_address[:port]]
 #         [destination] [port]
 # nc: invalid option -- '-'
 # usage: nc [-46CDdFhklNnrStUuvZz] [-I length] [-i interval] [-M ttl]
 #         [-m minttl] [-O length] [-P proxy_username] [-p source_port]
 #         [-q seconds] [-s sourceaddr] [-T keyword] [-V rtable] [-W recvlimit]
 #         [-w timeout] [-X proxy_protocol] [-x proxy_address[:port]]
 #         [destination] [port]
 # TEST: mirred_egress_to_ingress_tcp (skip_hw)                        [FAIL]
 #       server output check failed
 # INFO: Could not test offloaded functionality
 not ok 80 selftests: net/forwarding: tc_actions.sh # exit=1

Fixes: ca22da2fbd69 ("act_mirred: use the backlog for nested calls to mirred ingress")
Reported-by: Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
Closes: https://lore.kernel.org/netdev/adc5e40d-d040-a65e-eb26-edf47dac5b02@alu.unizg.hr/
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
Reviewed-by: Petr Machata <petrm@nvidia.com>
Tested-by: Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
---
Cc: dcaratti@redhat.com
---
 tools/testing/selftests/net/forwarding/tc_actions.sh | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/forwarding/tc_actions.sh b/tools/testing/selftests/net/forwarding/tc_actions.sh
index a96cff8e7219..b0f5e55d2d0b 100755
--- a/tools/testing/selftests/net/forwarding/tc_actions.sh
+++ b/tools/testing/selftests/net/forwarding/tc_actions.sh
@@ -9,6 +9,8 @@ NUM_NETIFS=4
 source tc_common.sh
 source lib.sh
 
+require_command ncat
+
 tcflags="skip_hw"
 
 h1_create()
@@ -220,9 +222,9 @@ mirred_egress_to_ingress_tcp_test()
 		ip_proto icmp \
 			action drop
 
-	ip vrf exec v$h1 nc --recv-only -w10 -l -p 12345 -o $mirred_e2i_tf2  &
+	ip vrf exec v$h1 ncat --recv-only -w10 -l -p 12345 -o $mirred_e2i_tf2 &
 	local rpid=$!
-	ip vrf exec v$h1 nc -w1 --send-only 192.0.2.2 12345 <$mirred_e2i_tf1
+	ip vrf exec v$h1 ncat -w1 --send-only 192.0.2.2 12345 <$mirred_e2i_tf1
 	wait -n $rpid
 	cmp -s $mirred_e2i_tf1 $mirred_e2i_tf2
 	check_err $? "server output check failed"
-- 
2.40.1


