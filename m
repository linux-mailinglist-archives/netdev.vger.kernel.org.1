Return-Path: <netdev+bounces-25294-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF646773B25
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 17:44:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 884FB28142B
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 15:44:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90F2613FEB;
	Tue,  8 Aug 2023 15:42:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8356A13FE0
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 15:42:11 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on20601.outbound.protection.outlook.com [IPv6:2a01:111:f400:7eae::601])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7F7944B7
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 08:41:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YQ3PynHgrjpat+ts5ncKdACnf/czteGeR5J+8zFNXwN3cgE5lAIsg3FSCnrG+4LT5pBA9NqAralnCKSGAFRe2uVoJl5t4CwdVh3zhq0v2UDW38+VQJW1g8QNPuea8L/IOjnmXHy/nbsFq3Z2jS7uiaWMojLYjPv2RxlGT678IgZyfEf1Iy0TETrtWd4uRNQGxwUouu1NcGaBFtEbM5BuyGgD/ZYRlRkTjSbpNR4pDtWO1cnEmsJxGMHer5q9JLYBVea0wLwDDjRnOFrzIDD1qYySyQghwK6sD5Dql7WOJtJNjxCi1d8cT4ZR5IXQKHSW4Qk6zXWmCuIlju7/haqt+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rfREWyNO25yJIz7rr+cssbXOGkP9Is5EGsMxq9XjX5c=;
 b=N/lm6+nl/ViCz79im9Za2AZCLLk9DbpIbZUhf2QPsaDvUtYGm+vT+2OTn1u3gdTmqnYzOm4vec/4cXP2fLWwZV+DKTeyTK/Tf8X0WyvIsjp1Qin2ytMqS30pHX/bT7s2XgYgWEMW1L/0aAYlOUSzlahotkgl9ZrEi3Iit3KzXsLEDFPpEn+vs1IyAJCMWGyVwZB2e8KU2siX/o64kaEOvjiYRXVlXDlrehouRWTaz30Key/4fpKjv3RiX2xKL9SoQ0Zb+8AtwmdVoH30rFjs8EfnLGUS1JmbsXTsBCrI0cmNa3vJMeZb/IFWicsBq+xKRh9RnPMgPLoESyr21txoyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rfREWyNO25yJIz7rr+cssbXOGkP9Is5EGsMxq9XjX5c=;
 b=b4bH/VObuy5l82bZM0PfeQQtnT9AQMui7Qtr0+yC0lGNPyQKf8BPTiZzlzbmK27ChXVEhNkSxKCGHEQv853495ZjocphLuh1MCcTpBwAJS//j2MRTHPkDR84MbXWHHGvf261o3S/PyJlhDI8uqkTYVzSoN5//uV7uxgzJ0b7cYUahkc1jcvO4olgNnyUdrpfvrHROGsPGs5EpmE6H9TERPiy/BhpnqJIERnl66lBQkZNWcm9J4LOWXu/A3pW07o8UkAIH+L2E2s/NPDNK0+MTjiKWQruveMF1qhpvtCt3KERC+vGbsHN/0soqQnVcUjCXnMAzqpiApHNEaKRZ0FdOQ==
Received: from MW4PR04CA0326.namprd04.prod.outlook.com (2603:10b6:303:82::31)
 by MW4PR12MB6826.namprd12.prod.outlook.com (2603:10b6:303:20c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.26; Tue, 8 Aug
 2023 14:16:19 +0000
Received: from MWH0EPF000989E9.namprd02.prod.outlook.com
 (2603:10b6:303:82:cafe::97) by MW4PR04CA0326.outlook.office365.com
 (2603:10b6:303:82::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.27 via Frontend
 Transport; Tue, 8 Aug 2023 14:16:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MWH0EPF000989E9.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6652.19 via Frontend Transport; Tue, 8 Aug 2023 14:16:19 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Tue, 8 Aug 2023
 07:16:06 -0700
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Tue, 8 Aug 2023 07:16:04 -0700
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <petrm@nvidia.com>, <razor@blackwall.org>,
	<mirsad.todorovac@alu.unizg.hr>, Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH net v2 12/17] selftests: forwarding: tc_flower: Relax success criterion
Date: Tue, 8 Aug 2023 17:14:58 +0300
Message-ID: <20230808141503.4060661-13-idosch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E9:EE_|MW4PR12MB6826:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e3ce77c-94a6-4c7c-333a-08db981a0944
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	zk4c1d15oIQdTI9jZn+WGajlz/8SyisSpBcIDi38+eSN7Q4g+0Ymk0FcGLYy8XKGzujx7AZZLloukQbCummT8jhikR+H00+1ZFZkjk7ZZNQx9vUZrNQpH3ilifImOqfEPyfnuPCmdMomplTdS0jqMFbWWvipjq78oB9eykIPCr6JGvIx9nGnJ66d3FjhJi9LBPV7o0qjk9BCbf5ENxb42NPY074kZEzIfZdLeUDtmI1nvEx3+uhQFwZR8L/57QZigzh5rmmQm3jXH9WOijqVVrUDUFlWibk6ZtaJ5DCzmkGKrdgUSFZp3Qvryuv49DisaB0yp9QmrD8lhTBstZemdMmBOznBiIUqlEC7hbt+380347ZE2M9ntHQuYjJA5hzOOQO5uyh4YjfMBo4CU0SysdaiFC4KhgqHe1Bv7mYhV8+tQoWZ+atiHf8K3J0XqclkJp2ZEQ2DEbpdcNYXoA+wBUvu1KWLRc6+GoiRxq1+1iIem7AHWXf+DWtBS6/8sxXvj8gsiCXyRoQ77Tym7j2USjoqeS+ARGLzxAKMhHsT7eE3MIQ5fQyFM3Ug9y8gRT/ziqwtJmnGA44GLIo6sPYt711AW0LWzG8glLCysiy3rIDkykIQVdMcQeUrPs6EID9cXm6sN3W0dBPaAB2eLG91UW4lonrzszkbcHEGjFzv3ojG+R+Z6QSFPu+RZZ35nZdOeKpHVVBlVtCIL4Kg2FJHdZdoTN8MLaVY7LT5u2LiaHEROS6NLnRZTHoRj1fcah65rxGpgvV2gP1stG/fnoE+ERtC7F92ec7wZlO7SjyzRpg=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(136003)(39860400002)(396003)(451199021)(82310400008)(1800799003)(186006)(36840700001)(46966006)(40470700004)(40480700001)(40460700003)(2616005)(336012)(6666004)(86362001)(478600001)(966005)(82740400003)(7636003)(26005)(36756003)(107886003)(1076003)(356005)(316002)(5660300002)(8936002)(6916009)(4326008)(2906002)(8676002)(70206006)(16526019)(41300700001)(54906003)(70586007)(83380400001)(47076005)(36860700001)(426003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2023 14:16:19.3687
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e3ce77c-94a6-4c7c-333a-08db981a0944
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000989E9.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6826
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

The test checks that filters that match on source or destination MAC
were only hit once. A host can send more than one packet with a given
source or destination MAC, resulting in failures.

Fix by relaxing the success criterion and instead check that the filters
were not hit zero times. Using tc_check_at_least_x_packets() is also an
option, but it is not available in older kernels.

Fixes: 07e5c75184a1 ("selftests: forwarding: Introduce tc flower matching tests")
Reported-by: Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
Closes: https://lore.kernel.org/netdev/adc5e40d-d040-a65e-eb26-edf47dac5b02@alu.unizg.hr/
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
Reviewed-by: Petr Machata <petrm@nvidia.com>
Tested-by: Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
---
 tools/testing/selftests/net/forwarding/tc_flower.sh | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/net/forwarding/tc_flower.sh b/tools/testing/selftests/net/forwarding/tc_flower.sh
index 683711f41aa9..b1daad19b01e 100755
--- a/tools/testing/selftests/net/forwarding/tc_flower.sh
+++ b/tools/testing/selftests/net/forwarding/tc_flower.sh
@@ -52,8 +52,8 @@ match_dst_mac_test()
 	tc_check_packets "dev $h2 ingress" 101 1
 	check_fail $? "Matched on a wrong filter"
 
-	tc_check_packets "dev $h2 ingress" 102 1
-	check_err $? "Did not match on correct filter"
+	tc_check_packets "dev $h2 ingress" 102 0
+	check_fail $? "Did not match on correct filter"
 
 	tc filter del dev $h2 ingress protocol ip pref 1 handle 101 flower
 	tc filter del dev $h2 ingress protocol ip pref 2 handle 102 flower
@@ -78,8 +78,8 @@ match_src_mac_test()
 	tc_check_packets "dev $h2 ingress" 101 1
 	check_fail $? "Matched on a wrong filter"
 
-	tc_check_packets "dev $h2 ingress" 102 1
-	check_err $? "Did not match on correct filter"
+	tc_check_packets "dev $h2 ingress" 102 0
+	check_fail $? "Did not match on correct filter"
 
 	tc filter del dev $h2 ingress protocol ip pref 1 handle 101 flower
 	tc filter del dev $h2 ingress protocol ip pref 2 handle 102 flower
-- 
2.40.1


