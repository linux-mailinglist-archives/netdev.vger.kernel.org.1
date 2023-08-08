Return-Path: <netdev+bounces-25297-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F333773B33
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 17:45:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E150B281420
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 15:45:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A371D14003;
	Tue,  8 Aug 2023 15:42:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 932A214000
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 15:42:18 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2060b.outbound.protection.outlook.com [IPv6:2a01:111:f400:7eab::60b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B57C4468F
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 08:41:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZCju19wXMraIgT0VaqWdKzML/hQ1x9+vfgAeaP3ZekYzeH6YHlGHyUKLCRq4nRWSyaK9LobM4F76uGiSpDJPbSQ95ZTsd44ynDI/nSUvi0y7rtKqB2T6UFJXUmKemG3n7IGx8Q48Q3BbAj18kWsXUrVWRSzWI8yYm7UZHZxPCT/j66WNWjlt5ftMt8DN6PwrRtigMuet/QLsx7keG0ad9pQBNd5GAlLbNRA/o3ezDQxVTkY8/jyP90IgB8LzgfW2Ciwyz8nwJQASFevON4x+D5fB4pqFj4EZiIfnNyXe0sjL27vYYNyWRk2UyPQRr/GwC5oqYfbxKzNp8r2ancTF6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ofDTqJ1O9BxqHiVUbA/OF3A4nySad5YAD+FpSUHT7Yk=;
 b=SCm8yH9+WpDHfOD4ewGEtbaUnM4v9YNV7zBDEQCgrljaVx+87s76tu5FuzNibTQ0ZMqU+99jLcw6kkPpiZ0cwwZd1n+930gaREBzphi4JtEsk/Y4k1N/0zaQ9FKRutwKy5qlPjfKjzRmj3aqKFFYT4vCFT+7H47wWD7LDlJ8XVWHzfVGA5H4yVjakRt+wKQVMGaIDSypze/+Lx6DOPTx03AMjgehINQmV4G2FUzkyGwFF4cZE9vlNTQWj1KluFVivcYFKoLyYVkw6Y1FjHvv1OCjyBky90VqK6lWgcWkkkS/5Bm/Th9Bs5XuaY/mNalprUO/J51U8IDhy7SLnrbwOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ofDTqJ1O9BxqHiVUbA/OF3A4nySad5YAD+FpSUHT7Yk=;
 b=NsqF13FbMjrb0MX3si5Wc+49++RnlRGxRuJy181tTUK3ERTeYhEmH0yOhykpnWQQBwyR1n0/ziM6RL4LSdbg1SyBK7Udosb4kN39q5oUvZflMx7EV82uaeeqPLwlmyCarPGIhI4Dq6tEZdobnli8FuxPZI7JPF3an06OG6gDDCQjQZaT0zlXwAgQ5qKs5yt7AtZOQc2NwR7WTDrxvE+qwFehvBKyMYgIw40v6qqn8ooC1qU2rV95xZEQg0IQMsIitRRpT8uBq+JSHhpDrGgA1fi4Tn4aLHvIFrKfnSBlhhOABdIA+A879c4w0w6wWaU5WHOlcKNfxi8xdIcVj/pQow==
Received: from MW4PR04CA0304.namprd04.prod.outlook.com (2603:10b6:303:82::9)
 by MN2PR12MB4336.namprd12.prod.outlook.com (2603:10b6:208:1df::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.26; Tue, 8 Aug
 2023 14:16:18 +0000
Received: from MWH0EPF000989E9.namprd02.prod.outlook.com
 (2603:10b6:303:82:cafe::fd) by MW4PR04CA0304.outlook.office365.com
 (2603:10b6:303:82::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.27 via Frontend
 Transport; Tue, 8 Aug 2023 14:16:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MWH0EPF000989E9.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6652.19 via Frontend Transport; Tue, 8 Aug 2023 14:16:17 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Tue, 8 Aug 2023
 07:16:04 -0700
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Tue, 8 Aug 2023 07:16:01 -0700
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <petrm@nvidia.com>, <razor@blackwall.org>,
	<mirsad.todorovac@alu.unizg.hr>, Ido Schimmel <idosch@nvidia.com>,
	<dcaratti@redhat.com>
Subject: [PATCH net v2 11/17] selftests: forwarding: tc_actions: Use ncat instead of nc
Date: Tue, 8 Aug 2023 17:14:57 +0300
Message-ID: <20230808141503.4060661-12-idosch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E9:EE_|MN2PR12MB4336:EE_
X-MS-Office365-Filtering-Correlation-Id: cca713a7-0cda-49a3-2ce4-08db981a081a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	pJcPDPFapPO9FTMnQmRSc6pbcXzotgvqkTsTO0al+JcjyUvSGd8Gt5kWA/tpVR5HRrvlTkdn2V4Vu4q5hsAbKb1qFLBm/f6McVTSPpUE9cSY5TT787YbrUR/nJBKJoe3Jo2UkgvK4x33gVIX6vKNRn0ksPdtrFTZe9roYpkaNazbU4mdR5IJnsD1g7MsHQ2Ej0JpsXLgjRZ0uMRF4DcuFDG3GiY5sgxxtai0UGIc5QRGrMj+FpINoWeknd0UUPH0QwOjw6gxEQkQyn6UdVtKE5DeDqDwUbpY++JUerM7yIbi561x3TK3DagsEWSs5ImiR9I9dhPMCk1EfI1vJD1h/7YoZRYFZQ8G4+eg1VbRVg9lUXuirhEreMpHC94VZVSfiDi4M6FXEm566L1HnErQf7BJvd1vwoA9NckP3Bkopn6gOZA6DcGVG+V+bqnuLk+4AZe5MFR4dI/mO8BJeGycDASYmfSPShvCyvBRvV4yDv5+EvPP6Uu9XEyJ1ic0X/wnW3lz3jSnNMR4l+bp/13yDXU86px84PRO23/EItLXQ7Mhg/EpYAXfETPAwydKL3CLmGKFPUPLFx6PtV/nmjndqJ5ekD66HPTLzECEq6nn5up9Uk4vIMCAY/i0ASkLJJp0i8lFZIJF8EZVVLobna4mJUox2O7EP2lcvqf2vAzbE7kZK1BsTke1rzWDhSsZcZVMliFJ78RYJYh633K3slu4bnFYIUlpdblg4cri/OeSo94loBYjkiBj46OleMJJ/bXXVNfyTuS9mzo+7vlOdJ0jNaixscPNGdT+426P6qiDkxk=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(346002)(376002)(136003)(186006)(82310400008)(1800799003)(451199021)(46966006)(36840700001)(40470700004)(6666004)(83380400001)(426003)(47076005)(36860700001)(2616005)(40460700003)(7636003)(40480700001)(54906003)(4326008)(6916009)(8936002)(316002)(8676002)(336012)(5660300002)(70206006)(70586007)(16526019)(966005)(478600001)(82740400003)(86362001)(356005)(2906002)(41300700001)(36756003)(26005)(1076003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2023 14:16:17.3999
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cca713a7-0cda-49a3-2ce4-08db981a081a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000989E9.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4336
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.6
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


