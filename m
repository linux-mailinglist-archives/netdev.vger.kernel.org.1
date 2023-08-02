Return-Path: <netdev+bounces-23554-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DC2576C79B
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 09:55:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5EFF41C21216
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 07:55:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E8BF63D7;
	Wed,  2 Aug 2023 07:53:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 890ED63CD
	for <netdev@vger.kernel.org>; Wed,  2 Aug 2023 07:53:10 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2082.outbound.protection.outlook.com [40.107.220.82])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D10FA3C13
	for <netdev@vger.kernel.org>; Wed,  2 Aug 2023 00:53:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ju+xatSFgU2n7P7XYFVMhnhlopQgjkaKKdt/iy+BacLUVz6SWcKHcStkQwEgQixiTcm5DVlAK9wAlIjEb6+NdyvNCQwpyqKycBa6LVbeMPH265V52rCgNBMdRZHLcwA1baF6P/nkgwRv8SzDiHDI9gf1up8sAMtyzOCaW6SmVNxEek4e7iAxesFJQe5bJCnCHQ7smUK6F5tgBYgOVhwWvNAve98dXllPTk8CPNaViSn0eNGjaivY2vWL6MPZw2Bb1Fd1oHPjQXfSg5gh7UCSvzuap8dpxbq9JWNCD/HXkPahkJqO3Rh5+7HMC2CCkzdkw+3HR2ndZobbFz/mLqTT2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=20hcQEs4AJlQ4qu3E3eqcfVdprQsTfkFNjrOMc95ENQ=;
 b=OUepYOK2tAVxbYeunDybmbMUNm61/O7S/UCTdQ/OBARtE+JmSzy7fvTGhLoQ2bGjHaJ4gRkUbH6DCjk+CPmXBZhopJH49gSSumsWZQz7jqfqGjJoi7Vk6kH6Mn6WuRTbX6SVetxFBkCQw/KVrmflNdjVEVLDsUuZ9lnSHw3j9ndtTXAx1tOp3PFnp7qhJmDzdqF7I5iJ0RpR6wklYtQkf0cAvtRquXZsL1oJiR9iIzhiNKjMG3zvmbC81FYk0R3lOMRtbwUdI7Bu+RjvqpmLWcVrE+3fYhjlhISQvt/bnzGwWhRdSkWr1HzyidSzaw0iISoiZYACgqCdHh6WG3tb5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=20hcQEs4AJlQ4qu3E3eqcfVdprQsTfkFNjrOMc95ENQ=;
 b=sZ1ACtzpfk8rZ0nKdrK5arxNJ1E8DIjDiOQ83kTqbmpdXYB76N7wF4Q2VvmK9hVYQYCDDauXoKFUEC50FEC5mAFW3frfXK3+q8gfh1UPlR9IYLDV8fLxp1Mmv5sQJTxMjCi/JuT7hU7AvbYYD84qxssIMkBgAyvH8XeqOO0OprvHK+PSOdgLy5GorfFydXGavIfhSlO8th5ZYgMxmo0csQ2YWrtxYCld0+LgBmTLcSHuDOU60KpbKj5gBEfI73CC2rOAXyNI6wNKKrrrJ2+bugMeNArvpXNwTKaSF07x8AzTDE7gtKuwspPz6nAzoqKhkplu/8j3K7LxgC6eziRcmg==
Received: from CY5PR04CA0001.namprd04.prod.outlook.com (2603:10b6:930:1e::6)
 by SA3PR12MB9157.namprd12.prod.outlook.com (2603:10b6:806:39a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.45; Wed, 2 Aug
 2023 07:53:01 +0000
Received: from CY4PEPF0000EE32.namprd05.prod.outlook.com
 (2603:10b6:930:1e:cafe::48) by CY5PR04CA0001.outlook.office365.com
 (2603:10b6:930:1e::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.45 via Frontend
 Transport; Wed, 2 Aug 2023 07:53:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000EE32.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6652.19 via Frontend Transport; Wed, 2 Aug 2023 07:53:01 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Wed, 2 Aug 2023
 00:52:44 -0700
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Wed, 2 Aug 2023 00:52:41 -0700
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <petrm@nvidia.com>, <razor@blackwall.org>,
	<mirsad.todorovac@alu.unizg.hr>, Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH net 09/17] selftests: forwarding: hw_stats_l3_gre: Skip when using veth pairs
Date: Wed, 2 Aug 2023 10:51:10 +0300
Message-ID: <20230802075118.409395-10-idosch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE32:EE_|SA3PR12MB9157:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b1dd130-b767-4a4a-9fd1-08db932d7f03
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	2k4xpJSbKpp6GCf1taSTkpE6nKDEtxMVi+GBd2cGudbqeYsmgbhyy7wgdGa2eyo/Fhwh1/qpfyQ70qR5EuZqr3TREc4GGofwHjxoGIL7vJ13tk4iMmDXI5id2WmUXA/NSGhBVIDGcbx2cHsaB+pRD+Jk6AH6i/3JYh4IWSbi+52C/ZxSewf6qbR30RoiPrnKQUNJcB6iNvRyA3Onirmv4b2pgt0BWh0bERZroDqQkOsimKDxspmmLBGKKpIYEL06cLLyQ0BsSBBwuhOibfn0gK9SyJ1h5nAmyLX2IjBQ+IxmM/U6HB1NK1E9Dym6Yy3LmJq9E585dpjB5HK4TgVTU5Iq6/ohLDxs6xsfh+wsDM9Z0Rsf5kV5uHOT76t3sGQyBbfed8hXfYAGQKLbZ6PTsQCqGsrnzapHluRVqZ8G2Rjh140sdTzf3Hf14G5MajaF7MGXaFFGILwSJZnLCqNr8+a8Hq+wZDXyDIMt+ghRcsDa+CeErosFbKvphePhioLKiPW7WjlGLIos3GXzny0mvMwkdK5dadxyoaaL4K2tlPmDaXL91zaC5DqSatcyBIM6Xa1FoGe2OGKCIXxHvSyENswEqorcqPWDXVX/VuJJ9OCVj0GXuHAd11kopUaeKFq6Kh/ifrgiExZAQppMG5988G4UdagLCHPDZKw/GstBE/5LWC+VXf9rBmYGUVHiIBytHV9Y1xwJ9pBbVYlGJR42RKQ3P4f32TA4QaePJKi1z7j02+KtHje4MseucnSkdJeUC+f+hGulHWmeRS65H2NkXWUAhoPrsdjnou2frR0A6UI=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(346002)(39860400002)(376002)(82310400008)(451199021)(46966006)(36840700001)(40470700004)(6916009)(4326008)(40460700003)(70586007)(70206006)(2906002)(426003)(2616005)(82740400003)(356005)(7636003)(16526019)(336012)(186003)(1076003)(26005)(83380400001)(47076005)(36860700001)(54906003)(40480700001)(86362001)(107886003)(36756003)(478600001)(966005)(6666004)(41300700001)(8936002)(8676002)(5660300002)(316002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2023 07:53:01.5406
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b1dd130-b767-4a4a-9fd1-08db932d7f03
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE32.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9157
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Layer 3 hardware stats cannot be used when the underlying interfaces are
veth pairs, resulting in failures:

 # ./hw_stats_l3_gre.sh
 TEST: ping gre flat                                                 [ OK ]
 TEST: Test rx packets:                                              [FAIL]
         Traffic not reflected in the counter: 0 -> 0
 TEST: Test tx packets:                                              [FAIL]
         Traffic not reflected in the counter: 0 -> 0

Fix by skipping the test when used with veth pairs.

Fixes: 813f97a26860 ("selftests: forwarding: Add a tunnel-based test for L3 HW stats")
Reported-by: Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
Closes: https://lore.kernel.org/netdev/adc5e40d-d040-a65e-eb26-edf47dac5b02@alu.unizg.hr/
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
Reviewed-by: Petr Machata <petrm@nvidia.com>
Tested-by: Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
---
 tools/testing/selftests/net/forwarding/hw_stats_l3_gre.sh | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/net/forwarding/hw_stats_l3_gre.sh b/tools/testing/selftests/net/forwarding/hw_stats_l3_gre.sh
index eb9ec4a68f84..7594bbb49029 100755
--- a/tools/testing/selftests/net/forwarding/hw_stats_l3_gre.sh
+++ b/tools/testing/selftests/net/forwarding/hw_stats_l3_gre.sh
@@ -99,6 +99,8 @@ test_stats_rx()
 	test_stats g2a rx
 }
 
+skip_on_veth
+
 trap cleanup EXIT
 
 setup_prepare
-- 
2.40.1


