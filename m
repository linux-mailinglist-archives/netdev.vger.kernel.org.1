Return-Path: <netdev+bounces-23550-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E9BCE76C78D
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 09:54:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1896A1C21213
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 07:54:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AA375392;
	Wed,  2 Aug 2023 07:53:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48D0B5677
	for <netdev@vger.kernel.org>; Wed,  2 Aug 2023 07:53:07 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2049.outbound.protection.outlook.com [40.107.223.49])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 707B93ABF
	for <netdev@vger.kernel.org>; Wed,  2 Aug 2023 00:52:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZjzSOChzQuPYQOlRfv4Ueq6OJmfxVMJr7cR4QG40Wp1kWgP62bOPJzyCMMpct/EuPpWM345X5bfrdbsR0CbRjpJVkWK6RjUcnxYmxKk7LRKKZOl6Ydhp8gH5y9gSfa2UeLUEtS8zx3nY1EWxmmtk4zRk/hf94qiCZ/I7RSa9hrJI1/ROewp9K03LQiFdZrRQBDDEpzSaLQhOiSJgLdWQyZAlEpsCqiMR+6MxXN2SB3AUj3WqrKLM93xiSA23LrncKr2HFAZ+pXFilkZBxcViI03S55Sy+1JVN0wrTkVYnQjTFBfK+G2+SfzoZWn5jgaNVCTocSlFzoHtoUAyFU1fKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gBBW/2jnpCdTZuwapZKaTHWc/uOD79xYDSWGRWCJ5Ys=;
 b=m/Co2v6fjON7gyf+VRgojz2/owftjhaSDkX00QHHeCVescdR5aDVzYv3SlaE95bd8Fx7XZJYT2OE6R+gKPc5InGcIB6VaBsZgvjSz+eRvEVybc4KG80ys7Ul2kN0imqEyDpvkf3boHcKCbxTgdN3gKjIy75dWVgrRxa0FVlSPS+qXHqhZUNwrzCFgf5ETDGwheHChE00VO2I96Ilm8IiLcOAHV67nqXGr9YSeKm9YgNBhB7c1Wf8JT9RUXdTP2aIPVcol1bdR078Zwqldev+1BjyLg9a4PB2KHka1ZeEVtEEREkaonEaPXMugLJG0qlS6WUSNfVKf/CdA+EBKAtdzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gBBW/2jnpCdTZuwapZKaTHWc/uOD79xYDSWGRWCJ5Ys=;
 b=eRLomG0JL7nPaZaT8JxYmMiQkKDpxZWMvpBNX68XX/OCQrw2AiTAk7yt4e47gT1UmNkHA7oqogccv+Z3INTbjJJvc9SB5vRogEnrBjupa76apDWUiekMalEMTQl7bEtzyWkZ53h6Utsmwo/CV5otgK6686HB4s4ZC7u4NmtL5i9K84uB08QbZmHEvPyLbHpxQl+LczuJsN/oOH4dZELRR4NtyJlW8Yq2ZhYk2FjJE9ukW2hBt9vtybGLMs9swah8BsP7fFHxYfxiOaehPtw7uQT5OlBNNnV9EYPxtLo9kk8tv3fBvpGjRxQaZI6ZbRa0mfhRv94ZyfBIEVwkElk6iw==
Received: from CY5PR04CA0021.namprd04.prod.outlook.com (2603:10b6:930:1e::12)
 by MN0PR12MB5978.namprd12.prod.outlook.com (2603:10b6:208:37d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.45; Wed, 2 Aug
 2023 07:52:53 +0000
Received: from CY4PEPF0000EE32.namprd05.prod.outlook.com
 (2603:10b6:930:1e:cafe::7) by CY5PR04CA0021.outlook.office365.com
 (2603:10b6:930:1e::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.44 via Frontend
 Transport; Wed, 2 Aug 2023 07:52:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000EE32.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6652.19 via Frontend Transport; Wed, 2 Aug 2023 07:52:52 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Wed, 2 Aug 2023
 00:52:35 -0700
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Wed, 2 Aug 2023 00:52:33 -0700
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <petrm@nvidia.com>, <razor@blackwall.org>,
	<mirsad.todorovac@alu.unizg.hr>, Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH net 06/17] selftests: forwarding: Add a helper to skip test when using veth pairs
Date: Wed, 2 Aug 2023 10:51:07 +0300
Message-ID: <20230802075118.409395-7-idosch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE32:EE_|MN0PR12MB5978:EE_
X-MS-Office365-Filtering-Correlation-Id: 77d1ab47-bb70-4a92-1981-08db932d79ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	C/W0+MWwEWdZgy/Ayxk/dVYAK3G3Ukuf9UGlPUGpmsbyxwkmNCNu9BHZRZfVwUCTXnXP4kv3r9R+XsfmpH2sfpfoAbv1JIXqEk8E5zA95+Sirs9eKNTg2peXl/lW/juL+ZrnJ4lJdrVNA0WoruHP4SuUe+A+KjYi/y9to7ptu0ligHL/ULsFC7JuHPv7yyRXieSIld7SOmGk039TTqdLwvEwUqYz805vr+1hGtCEEH/w7mpnz4AR0iWFeHu8b6HkLHsHvPn6QUkQxS2MLOz6U6oa8+uReN4Lp7E39sYJD7+p+eIKNxgUwhhHHTzHj3JPYeB16u8xSAhYVgM3DcynSVYBywr2OqpnLpo3YUgOGIsQ5MxT448My0M1BQaLobSKZhZMIdyP6SW6VpNom+rccTPxeDYzQbwQNYcPeerQW33P/8vi6zVrroKi8zioOErqBuP9ZUKMq40r96LH8CAFEDsfxEWB3LFFYjTuuzFq7vYEqDG81Y3JYQ07zBrXCkmbZAa3rqUXCvyCAyyCNNvcBvUwn/jK0pPAfCvotvn61KYeBQjtMYAN2MigQVE6FBnGQf9JRsDbc1DinI8kY54jJYE+tYzfkNYK1HDS0CXRpsMHanbFdSfqSYsv1btIvSsbpVD371ZUVyXMpFY6u2pljDOwVNPUjArgsqy2QiuGtxoRoHFMrdVWyKfiv9snDbvkIHwQixWIMzSFoU07QgQ+ooPY9SRlHB6Qfwk2aRHx6ZcDOq2nj7Bhzjs31V+uBhPT
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(136003)(396003)(346002)(451199021)(82310400008)(46966006)(36840700001)(40470700004)(40480700001)(336012)(186003)(16526019)(40460700003)(2616005)(36756003)(316002)(86362001)(7636003)(478600001)(54906003)(70586007)(70206006)(6666004)(4326008)(6916009)(82740400003)(356005)(26005)(1076003)(41300700001)(107886003)(8936002)(8676002)(426003)(47076005)(83380400001)(36860700001)(5660300002)(2906002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2023 07:52:52.5718
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 77d1ab47-bb70-4a92-1981-08db932d79ab
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE32.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5978
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

A handful of tests require physical loopbacks to be used instead of veth
pairs. Add a helper that these tests will invoke in order to be skipped
when executed with veth pairs.

Fixes: 64916b57c0b1 ("selftests: forwarding: Add speed and auto-negotiation test")
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
Reviewed-by: Petr Machata <petrm@nvidia.com>
Tested-by: Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
---
 tools/testing/selftests/net/forwarding/lib.sh | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/tools/testing/selftests/net/forwarding/lib.sh b/tools/testing/selftests/net/forwarding/lib.sh
index 40a8c1541b7f..f69015bf2dea 100755
--- a/tools/testing/selftests/net/forwarding/lib.sh
+++ b/tools/testing/selftests/net/forwarding/lib.sh
@@ -164,6 +164,17 @@ check_port_mab_support()
 	fi
 }
 
+skip_on_veth()
+{
+	local kind=$(ip -j -d link show dev ${NETIFS[p1]} |
+		jq -r '.[].linkinfo.info_kind')
+
+	if [[ $kind == veth ]]; then
+		echo "SKIP: Test cannot be run with veth pairs"
+		exit $ksft_skip
+	fi
+}
+
 if [[ "$(id -u)" -ne 0 ]]; then
 	echo "SKIP: need root privileges"
 	exit $ksft_skip
-- 
2.40.1


