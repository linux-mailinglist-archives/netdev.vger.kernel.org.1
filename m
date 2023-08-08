Return-Path: <netdev+bounces-25284-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A60B8773B06
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 17:37:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B65482818A6
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 15:37:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBA5312B8F;
	Tue,  8 Aug 2023 15:37:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9BAB134A2
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 15:37:48 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 771FE134
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 08:36:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YKUGLJshPp1Qkf4MYprnVOcL5lFBxcKKpqbjngF/ra8Pleh5H4jSTNdwc9qFsz6CSmcbIvGB34akEYPlExNnT60+3sX5N77fFA1ZnToF8gSbvczbcVKxrM6KYXu5+L3vD0o+NuLns/TBLCBUXEBAEYoQUOO31neCy9/s1LK0mYvkBeh4lvnvlwU2fW0EfbmfY9P/uQTHZuK9FuPUpqbKk7mnTFlwW8BcP2TjL8Q8euh2cNg+ZFYgXP3NFMHE2kPUFI0OeLeUeahywWntSwrADiQdlzha4T/Q73Rvpd3dVlKR3VI35+edQvHKp2n7uYw+VAFnTsFG+MPDh1EUaU3BJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=20hcQEs4AJlQ4qu3E3eqcfVdprQsTfkFNjrOMc95ENQ=;
 b=GHF4I9PPTOpLkFK0A1k3gyHDIRwyl1gAObX442Goa0yLb7DcTA9a9it7idZwXW0WlztCT/KTHYBrh0Es4uJwzdGypCViek8Yf+GsRexMxfI7lPDYmt5+UpKpZlRZo4Gkqc4r7Mj1kFU6mnD8nN0Q/ebhBq36UMVT/RbIyBKujuGiUzuv3CoZAxUlMc31atNAaG2D9AExt06/o2RCb5d8TLVGv21ZZJjPm9jT9Kqi9WriJPJmKvwunDW5stVPxYeHLvCzoEoGkUk73I/qFGNW6n/9h8kVhdtz3oH+F7lnrnOtcvhjpKaCPnupLag+jn8NfHd8E2iw+s7mnlrjKTK4PQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=20hcQEs4AJlQ4qu3E3eqcfVdprQsTfkFNjrOMc95ENQ=;
 b=IfumICqK01wjjj4o1TYyOVKb3Bb42qG3uzqblX+SX6WUJr8i+ejTKp1E13hrvpdD3Z1pSXhrc2rDUR+KKsgeq+l2CR0yB8rAW29h4b/gZjV1ZJCakYSx32M4Zc4JDHqps/QZvJLv61fQwZ/f/XKzjxEhWyYs3F/vpct7drwXOSfhhILI/FS8Ewauh3+eCdPFVpzicQGMCr7Yzsp4pND+8tSxGCygepGkGsI8zYsn0YKX7oYZdVoESaofYqmZ9CD+ZKMnDnvUyTjlEHaSULHjryYzNGA83qvl9VeiJvYVzafJcMkeT1RmEtYjJ44VM2GK53TOQE+WYFQ5OxdULa8KKg==
Received: from MW4PR04CA0058.namprd04.prod.outlook.com (2603:10b6:303:6a::33)
 by CH2PR12MB4875.namprd12.prod.outlook.com (2603:10b6:610:35::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.27; Tue, 8 Aug
 2023 14:16:10 +0000
Received: from CO1PEPF000044FD.namprd21.prod.outlook.com
 (2603:10b6:303:6a:cafe::8b) by MW4PR04CA0058.outlook.office365.com
 (2603:10b6:303:6a::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.27 via Frontend
 Transport; Tue, 8 Aug 2023 14:16:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1PEPF000044FD.mail.protection.outlook.com (10.167.241.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6699.0 via Frontend Transport; Tue, 8 Aug 2023 14:16:10 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Tue, 8 Aug 2023
 07:15:58 -0700
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Tue, 8 Aug 2023 07:15:55 -0700
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <petrm@nvidia.com>, <razor@blackwall.org>,
	<mirsad.todorovac@alu.unizg.hr>, Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH net v2 09/17] selftests: forwarding: hw_stats_l3_gre: Skip when using veth pairs
Date: Tue, 8 Aug 2023 17:14:55 +0300
Message-ID: <20230808141503.4060661-10-idosch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FD:EE_|CH2PR12MB4875:EE_
X-MS-Office365-Filtering-Correlation-Id: 712b4cd7-2477-434b-68cd-08db981a0407
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Vnr3LlfO84NR9TyI18HoKhbiXyQIA5jT2awgL8FYHZyG3Z8yEhfACO6blMa64hjbyg6WbQzx6SE+7qc5+5/xlDdXL2FCT1VJ8yfeDdA/U2ijABvudMB11/7D4f5UeaXMpQ773ltuVW77IGkrqMNr2MZkBi65Q6XZlSag4B9PTJinQnO3EHirmQlothBmDelU0p3O8ZTJNmGD5nVaNbUpd1ipc40taDVkEOsvkrCHQqGBb/GgYyceFYIMeP1vYN6+U8bmLe2ctqPc9RflXe3teR4lnHfTXsBWNp1jD1UroqnXcxuZ19zhOyryxTH1g0e09upigw6ZzB5B3zRNzxjzcfgwQEJ/VBan3mWLlIqQxyP52AF9GMwHSTqqtUHN2j0NxUO0wh9g5AaAtg1ZzsKEznIkcOvx1Oo1qmXPjpARCRTpqvMRrpywCfkSB0dELmwkPR0CJv+R6mMjXHHcE4KHKa2xIiYajl0WG9j6EylQHxLk+HkciHD90uQ4ELlkTwJMErf1/QhdT+as8orfWMkrPXsTZG9GjIczKRkltutPTTD51+bF7cFJ5SagBiCJFQLVF51FRbQM8Kem9Li5jIeUv6MtqRWvvJYHRnuOXlVLa5yDY4D/DhqQki2sWrg63v4Bkv3utmxuGfhv/yR1i6y5wwwuXULZnSRfCDAnI86qKSVB1mdWagF95PK2H2AOH+if7QbUxuKCxcOW2NoHgANDQVulo5VnARco2GUQYtt+DVU7WpQThIX0GnmoXGm6H1+olRR/IJesz2Q1gVqiPjzcpdPPCByTAXQn6lxsH09MnNw=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(39860400002)(376002)(346002)(82310400008)(1800799003)(451199021)(186006)(36840700001)(40470700004)(46966006)(47076005)(83380400001)(426003)(36860700001)(316002)(40480700001)(70586007)(41300700001)(6916009)(70206006)(4326008)(1076003)(5660300002)(8936002)(8676002)(26005)(966005)(54906003)(478600001)(107886003)(86362001)(2616005)(40460700003)(36756003)(356005)(7636003)(16526019)(336012)(2906002)(82740400003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2023 14:16:10.6285
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 712b4cd7-2477-434b-68cd-08db981a0407
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044FD.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4875
X-Spam-Status: No, score=0.8 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
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


