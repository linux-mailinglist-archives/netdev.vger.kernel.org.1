Return-Path: <netdev+bounces-17651-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A45575282F
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 18:18:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8EDD2816AD
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 16:18:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA7191F185;
	Thu, 13 Jul 2023 16:16:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E311200B3
	for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 16:16:43 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D96CE74
	for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 09:16:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z48KuYe2Xx6TkOqp9QvZikjK4ZRiefSgR0C1q4+KqgolaOdlu+376/alqNaH1hdf+22GcHgxddFrcODXYitfsnZs0lYufHkpqLmKFWlQ3z9kkQCaN68AHXxdVrJj6otV8RnxSOYzvu08VqDTMpemfKzSAIKmWqIMcIqR2XU1hEA7XIlUf4IJkoopryGqFnaRrXtE5seXtxDnyXUarxGPoEk0ihE0U4Cv0IEBVt2MH5yzcQbp8TVUaY+8eoAniQcNqFazrcbHIrzUnz9n1gUsHPOmcLWfC2hbxdjuGiD7z6RlMjIcfWzggFXaNc69ioUO6y1JuQ4V2B4mCQY23L20hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YaCotTk8gwfSagn6Ra8QljXjfukokuWeAT7akFMmZJU=;
 b=kn+baUZYy/2jAwFz8vsNGaR+ZS73GvFnwAIQHLj5PzCePwpgXJfKKD0vb/Pe9HvzBq7xF+Ks54dxt9byD1k8tmFGetp8X7WqwsjAwiOOvjBCYyaXl/7ocgRwRZDg6GAybk/mpSpNCmoCYH470Fs/NMuSLpYcezEoX1vpdAt7RF2OetuRN6aZbiEURxOl3QCpuQBe9f8pam41A5I3x2+99CBgBBOo4dArTvi9EV9ledC6aBq9vrXsp4hsb+VKZgkKS/IRvw+DzxEu67nXj4vxW2qa+ruh2R+0SJ1HHRSuhB205M7eqCjGH2bEr9xupUx9+Cj0C3F7j2+QfuRqskXnaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YaCotTk8gwfSagn6Ra8QljXjfukokuWeAT7akFMmZJU=;
 b=FfGB/lZf2GNKbOVfecYL8N5NGMPQWDzLFMphP7oYA6s8nEojXz5aTohDKgxj3rIJuQUlFV6pgW9oNb0UNWqIAruI3Jeq/LrHUtm25rtBymMvTOnQvBnI2YFig7gmS+44rnSoGxhIqWxN6SQyOzWZI9iaGc3Os3aKG0q7/25De8lU1zJR1MzbMBOaACG3s13bFUjaVI3KrxfyADlGCAioguQ8DzNDuw18olvKwsMm22KEBJJtSl9rXPbhxlKvORI/Fe2m21UpdjhNNQ7yvL63BHoyebcRzwrXcm8buMFiPlPwnnj1bUlZFqfY3Ste16cVe0dsplSrhBsP2RhJkr4IIA==
Received: from BN9PR03CA0303.namprd03.prod.outlook.com (2603:10b6:408:112::8)
 by DM6PR12MB4861.namprd12.prod.outlook.com (2603:10b6:5:1bd::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.24; Thu, 13 Jul
 2023 16:16:36 +0000
Received: from BN8NAM11FT021.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:112:cafe::1d) by BN9PR03CA0303.outlook.office365.com
 (2603:10b6:408:112::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.25 via Frontend
 Transport; Thu, 13 Jul 2023 16:16:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN8NAM11FT021.mail.protection.outlook.com (10.13.177.114) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6588.24 via Frontend Transport; Thu, 13 Jul 2023 16:16:36 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Thu, 13 Jul 2023
 09:16:20 -0700
Received: from localhost.localdomain (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Thu, 13 Jul
 2023 09:16:17 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>,
	Danielle Ratson <danieller@nvidia.com>, <mlxsw@nvidia.com>
Subject: [PATCH net-next 07/11] selftests: forwarding: lib: Add ping6_, ping_test_fails()
Date: Thu, 13 Jul 2023 18:15:30 +0200
Message-ID: <f2e8eb0892de2ed6387b66f1671b990b4080967a.1689262695.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN8NAM11FT021:EE_|DM6PR12MB4861:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b392982-12c7-4a45-b630-08db83bc8827
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	tcFMszLbyiG8YVtJ2ibBTo3CeM9Vdy5hcCud13waCz0mXgdNDpnAPx/lNUSrgalXpl8HdCjdg4ogGGoLfc6F6YxSELPuhyriMt8YhCVRsrSlZQdIuOQfCWlPB6/3KHy1h6EG+E0yyJcFmQdZCH3CbjkT/Ev2TxIMZvZaGrSXPtjLcjTBNuiXooKBrMKCZ1c50O698DAQEj/leZbvqpclMHSddsTIbmX9QVx3Wc1dvGTlcY2RhQkTJ0DLgFd8iyo4tU3Jj7MYa5j/VPqv/GYr0VpLe1D7KwTldX1J6IAX0Ibjrk6UWz12zwMQ6Dkt19Cvg4G/PPMd0eKe7N2C0x2hl2QgjyYH8uBELnf3YVp1ic3Y6+W682PaXEjd0REXthKrnuFMSZl5bjE5rZRsr8lYzhm2F5QKkp19iTgZVmCCOediNvLCaTF9wlevoQ2GwwkGSb+mouqDgi8TOwIymoHOOfP2PPS2CKmIpppeVpnY+knBp+q8IBY3du54lMc5FqtE+7faDK4rPJWhJ3EDW5fg6+IPEAH1342JLm06r6/ze52Njs0x2yWAw/sXnUBaQZGsXVxdjeXpC/c3WGef/W67zti7ilUY6ZfnFQDCLm5jmcHjWiRewZKuGkXI912JFaLtepy5//cf+prDWgMfOFgUPNG+xy6YepQA9MtZ86HNyz8sdccza67tuz70rBhRHvY4ydrUQb3uxPHnmxf5S1WhCbB5JeWJ6Z5M/gstHFgcHqVPT47QquKphQnJ6MQLtfDc
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(136003)(396003)(39860400002)(451199021)(36840700001)(40470700004)(46966006)(110136005)(54906003)(41300700001)(40480700001)(107886003)(4326008)(70586007)(70206006)(478600001)(4744005)(5660300002)(2906002)(8676002)(8936002)(316002)(6666004)(40460700003)(82740400003)(356005)(86362001)(26005)(16526019)(186003)(336012)(36860700001)(47076005)(7636003)(82310400005)(426003)(2616005)(36756003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2023 16:16:36.2420
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b392982-12c7-4a45-b630-08db83bc8827
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN8NAM11FT021.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4861
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Add two helpers to run a ping test that succeeds when the pings themselves
fail.

Signed-off-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Danielle Ratson <danieller@nvidia.com>
---
 tools/testing/selftests/net/forwarding/lib.sh | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/tools/testing/selftests/net/forwarding/lib.sh b/tools/testing/selftests/net/forwarding/lib.sh
index 9ddb68dd6a08..71f7c0c49677 100755
--- a/tools/testing/selftests/net/forwarding/lib.sh
+++ b/tools/testing/selftests/net/forwarding/lib.sh
@@ -1215,6 +1215,15 @@ ping_test()
 	log_test "ping$3"
 }
 
+ping_test_fails()
+{
+	RET=0
+
+	ping_do $1 $2
+	check_fail $?
+	log_test "ping fails$3"
+}
+
 ping6_do()
 {
 	local if_name=$1
@@ -1237,6 +1246,15 @@ ping6_test()
 	log_test "ping6$3"
 }
 
+ping6_test_fails()
+{
+	RET=0
+
+	ping6_do $1 $2
+	check_fail $?
+	log_test "ping6 fails$3"
+}
+
 learning_test()
 {
 	local bridge=$1
-- 
2.40.1


