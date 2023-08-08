Return-Path: <netdev+bounces-25334-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 12013773C01
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 17:59:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BAACC28138B
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 15:59:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A80E1171CB;
	Tue,  8 Aug 2023 15:46:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BA861401F
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 15:46:58 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2070.outbound.protection.outlook.com [40.107.223.70])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1F777ABC
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 08:46:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WR8z52t3u2A/1qruWlPbxFrWj3Q9SODaoWmu02E3CxKptF54Q39v6ocF5U0X1InzwkjwbEWSh8XIkmaZBznyRxAS7i55ziRSupP8FNqCW0Nqel7YWJHUkAmjdeOKgbGAM+kkfuZ6beXTYr/6yjbFAJyjPwa2DOcHKI1nFrGbiNq238GtLIik296mZnwmzAHsajeonuir9UZldU411SZewNypjNwA75/ahoYfJc/DGTU/tRR3VvkxA9bkdDikGDM8kIVkrG+AK6pGz9RJmx/ci3zpAI4xf8tKh1zLN1iK8uh9FmpS+g4UyR11HAkRIq9iGkoerT29dp95gDOHZpXvbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gwgRqpdSL/ICEN4nx078sfEVZjEKcVeEXYdn9IGtlZ4=;
 b=GT1sTPkXybnDBqLUANUDvEAKc7suLPErAAmc7oo/qtkepQV0JHopgSLjt27skmPtaRajLOLbivvOmMLWEhUQPPPq4oeWKDljW4IxVhnJ4VdH3ac8/5nCtYPxx0B9LyeJrP6AZVDQChFubv4O8QjxZ6BCHJNzKRkpnqj7PR8GXfWieXnAo69q0M583jq1ShamTTDVUXzm3v7wUBuuXS/BRsJAmId1RsRRmGHGbZlljK1tXx+So8Pi260OOtyvazz8qX0dSekDItdnuOzzTUOHXDarcS5y5gCoDoSdcy9OEjJtXOEClMFrheIEAM8fM3m9udKFb44PRdte3iKvWdssnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gwgRqpdSL/ICEN4nx078sfEVZjEKcVeEXYdn9IGtlZ4=;
 b=EVj4vO9ZMI9XdzdhFof9H8OTnkcIYlQNV9/TpjV6qf4CsF5LvUYVZJLDIeC4dNNC3bMdmeuS9YZc5qGwDYnd/5n3cI9ZluoWSMs2OqJe7EESeLRehiUOJl2BzRsM1xJzxr2qv9ijv3ZFI9gImI/nhPVyfNyiQCCT6wTrD8m8vzJ9zLy6uTs3QbNMZNWC7IZbpMezHW830ArboFXmhkmvm/4+R5uwQf1EI0RUs7ZNhHP6FbP6IZ0f6H3ZefhW4SuRJCJaM/a5DNe6y05/xnNoKVlL05rhg1QWncxSC6qnDb46G6LgYlz5paJy4PBejdyk73YLQSVKtq3PsmS3RGB/Zw==
Received: from MW4PR04CA0043.namprd04.prod.outlook.com (2603:10b6:303:6a::18)
 by LV2PR12MB5823.namprd12.prod.outlook.com (2603:10b6:408:178::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.27; Tue, 8 Aug
 2023 14:15:52 +0000
Received: from CO1PEPF000044FD.namprd21.prod.outlook.com
 (2603:10b6:303:6a:cafe::69) by MW4PR04CA0043.outlook.office365.com
 (2603:10b6:303:6a::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.27 via Frontend
 Transport; Tue, 8 Aug 2023 14:15:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1PEPF000044FD.mail.protection.outlook.com (10.167.241.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6699.0 via Frontend Transport; Tue, 8 Aug 2023 14:15:51 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Tue, 8 Aug 2023
 07:15:35 -0700
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Tue, 8 Aug 2023 07:15:32 -0700
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <petrm@nvidia.com>, <razor@blackwall.org>,
	<mirsad.todorovac@alu.unizg.hr>, Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH net v2 01/17] selftests: forwarding: Skip test when no interfaces are specified
Date: Tue, 8 Aug 2023 17:14:47 +0300
Message-ID: <20230808141503.4060661-2-idosch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FD:EE_|LV2PR12MB5823:EE_
X-MS-Office365-Filtering-Correlation-Id: 3bab1bd0-d334-400e-24f4-08db9819f8c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	wy2RvXNA9kz08/Ysu5TuquVpRT/XRov6jkooCEOscLQX2CQyQ8Tehl2UdB3O/Lgb2ZweaL1K/e/DdxAhs1XUByhEpSSrp/hg2ndJKcnPkJQuzVOOJK+gj2SoqAJ4KP/xQWVBLXnZehkY68pJGs8J88WQXQll6+uQMpxIgsd5oD7Ghwt1ehIMcpFxNkFDJgqgIF1qoX0LCLClpHfMwJwZSAOzuc7pStjzksnhGmyv0P0YBKk/hW+71pufS9HN1GGhl7owW5rZy5yCRQmVLw095dtUrjlLa8+UpXgiStmeOvcgaUEj+cjp6Faenje/w//IUvPoTgRUUZQpHArvpom7h2m17Oqnj6pOUXjkTAlXrzw6hMrFbDzk4y59TFTDsT5yIX4iOmR/YaL3a3ScTw8+E7I0k4KW2T7gGQnorFp/yykM7hmoPql5eYbwHjT+RBqFjkd1LaPTpRRww6rYJZVl1h1qwzYbe1PrvvcjjmvTWuvNToJXrpkSp776jMSB2KhqEb33mwy+mdTPO4/oSSXTHPaRrmusq6qg1U9pKDUoV22MrYgo/idVEzjj3DFys1ZBe83bP8mp2EXYuKLTXZdT7YDT6Q6NNpeS+MWkb8Hgsf+ml4NW9roOnJoqJbeQ2jQBudt6ASv1YvRildXPHFLjrCoc9c9yeZm5lbovDi2kupODF9yoU/ZUYB2rJOCpwG6U7Kd+wyhe3FOZWYyXUCNKJiAyvuDHRsQ54Hnrt1y4CR4+5f+BfPalrtmfN3lA0Jq2lPzimEAc3WLTv9yV7jwTnw==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(39860400002)(376002)(396003)(1800799003)(451199021)(186006)(82310400008)(40470700004)(46966006)(36840700001)(2906002)(83380400001)(47076005)(316002)(82740400003)(2616005)(6666004)(41300700001)(336012)(16526019)(36860700001)(86362001)(426003)(40460700003)(107886003)(5660300002)(26005)(1076003)(8936002)(40480700001)(8676002)(54906003)(966005)(70586007)(70206006)(7636003)(36756003)(356005)(6916009)(478600001)(4326008);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2023 14:15:51.6128
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bab1bd0-d334-400e-24f4-08db9819f8c0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044FD.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5823
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

As explained in [1], the forwarding selftests are meant to be run with
either physical loopbacks or veth pairs. The interfaces are expected to
be specified in a user-provided forwarding.config file or as command
line arguments. By default, this file is not present and the tests fail:

 # make -C tools/testing/selftests TARGETS=net/forwarding run_tests
 [...]
 TAP version 13
 1..102
 # timeout set to 45
 # selftests: net/forwarding: bridge_igmp.sh
 # Command line is not complete. Try option "help"
 # Failed to create netif
 not ok 1 selftests: net/forwarding: bridge_igmp.sh # exit=1
 [...]

Fix by skipping a test if interfaces are not provided either via the
configuration file or command line arguments.

 # make -C tools/testing/selftests TARGETS=net/forwarding run_tests
 [...]
 TAP version 13
 1..102
 # timeout set to 45
 # selftests: net/forwarding: bridge_igmp.sh
 # SKIP: Cannot create interface. Name not specified
 ok 1 selftests: net/forwarding: bridge_igmp.sh # SKIP

[1] tools/testing/selftests/net/forwarding/README

Fixes: 81573b18f26d ("selftests/net/forwarding: add Makefile to install tests")
Reported-by: Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
Closes: https://lore.kernel.org/netdev/856d454e-f83c-20cf-e166-6dc06cbc1543@alu.unizg.hr/
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
Reviewed-by: Petr Machata <petrm@nvidia.com>
Tested-by: Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
---
 tools/testing/selftests/net/forwarding/lib.sh | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/testing/selftests/net/forwarding/lib.sh b/tools/testing/selftests/net/forwarding/lib.sh
index 9ddb68dd6a08..975fc5168c63 100755
--- a/tools/testing/selftests/net/forwarding/lib.sh
+++ b/tools/testing/selftests/net/forwarding/lib.sh
@@ -225,6 +225,11 @@ create_netif_veth()
 	for ((i = 1; i <= NUM_NETIFS; ++i)); do
 		local j=$((i+1))
 
+		if [ -z ${NETIFS[p$i]} ]; then
+			echo "SKIP: Cannot create interface. Name not specified"
+			exit $ksft_skip
+		fi
+
 		ip link show dev ${NETIFS[p$i]} &> /dev/null
 		if [[ $? -ne 0 ]]; then
 			ip link add ${NETIFS[p$i]} type veth \
-- 
2.40.1


