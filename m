Return-Path: <netdev+bounces-23545-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F32F76C77C
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 09:53:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 56B531C21229
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 07:53:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB3775255;
	Wed,  2 Aug 2023 07:52:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99605539E
	for <netdev@vger.kernel.org>; Wed,  2 Aug 2023 07:52:53 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2078.outbound.protection.outlook.com [40.107.223.78])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 215DF3592
	for <netdev@vger.kernel.org>; Wed,  2 Aug 2023 00:52:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=epJC7sDK9nL1+DCSjwxl9emGBZ4zaAIB/MG+/5ZZ3DFt36oqjHO0KQdtSJyw21vcWWhwLAzJ1/OUQ6YdP2mM04bdXHKtjA9AEfDrzFtuiDJWGlVOgoJ39mH6ota1oSBbIqJz/aGrezqbKbGXXpocPLvPS9pp+d8gdwRuGF2AeZsMlaU4NY9SYT/ogx4B6lkJRTojTDcn/BIqY1waUBZ2Xx3NHy69P64V48sSKgpBX0wTAhz8hEqKr4mGMxJNXeh1qidjLx2IUEWSEIjZZjSvxkwDR0HQKD/G+KURF8zN3VE4GXuKOmZ7U5s097cnAIMW3bHXGwRv3C2Lba6ztUBotQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xZmsyxattMjLt/Gppiqx7yvwYdKp47rC94asz9Wwv0Y=;
 b=NgRKt+pbKp2RIS61sZiNNsexmqMFb1+qjb7nlbiBExA42yLg4ZxACVWXDlXhRBY/M+8OXBMB1DcY0HUWMRwvAIrt5T9YsttBDqC3qRvBK8Xe0FepsSqRGFiRdWKNXeUOlXlGLxbQ2yP2rbToSG6nJrlWRrz5kVLszkHP4Y3khM24Co7EqgMZv1TigTYKPJVXbLLQyuXH/O9K4Uo7d0qXCKTtMpOGx8tdX3MNIcVH6F81QRx6q7xXs6vaywWdKSufGMocrfw34MG90/qONZG3nU2T04V5408NETKTUETNsK0oQcDGCuxHELqFgttLI8R5W1dAUlkW9J5f/wkJJWtg0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xZmsyxattMjLt/Gppiqx7yvwYdKp47rC94asz9Wwv0Y=;
 b=mawWK62doUGnwILYeQWCbJqla4U7N10/EW22VN7gCR45NxwNjFNEB4ifea6a7fpN9bewV4bGRLaLu6D9IMEPSH8NOMC0gLxU5ucO4z0jWIpvpkyMcqVq/cKssQHiegTxTIm374UAf+5gKbTyu6EbAhIm4fxDfIF15ObH4yXxYKp6on2ZHhcmVs+vJfDcE/2m4QzIiZ6ZydLXKlD8qFVAqYP78Io2ZdDGq5tkRKRr6nL1rcep9pDnvqKWgL0wn1ibRxNvvG7tlHEZafrPHrH6PjXqP5oO3i7EGx4k6HGvwnd/o4uwG3R0uLyg6xEEJB4YDG7O2szBk5tke+qOYhdK+Q==
Received: from BY3PR05CA0012.namprd05.prod.outlook.com (2603:10b6:a03:254::17)
 by DS0PR12MB6607.namprd12.prod.outlook.com (2603:10b6:8:d1::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.45; Wed, 2 Aug
 2023 07:52:36 +0000
Received: from MWH0EPF000971E2.namprd02.prod.outlook.com
 (2603:10b6:a03:254:cafe::e2) by BY3PR05CA0012.outlook.office365.com
 (2603:10b6:a03:254::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.18 via Frontend
 Transport; Wed, 2 Aug 2023 07:52:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MWH0EPF000971E2.mail.protection.outlook.com (10.167.243.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6631.25 via Frontend Transport; Wed, 2 Aug 2023 07:52:35 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Wed, 2 Aug 2023
 00:52:23 -0700
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Wed, 2 Aug 2023 00:52:21 -0700
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <petrm@nvidia.com>, <razor@blackwall.org>,
	<mirsad.todorovac@alu.unizg.hr>, Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH net 02/17] selftests: forwarding: Switch off timeout
Date: Wed, 2 Aug 2023 10:51:03 +0300
Message-ID: <20230802075118.409395-3-idosch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E2:EE_|DS0PR12MB6607:EE_
X-MS-Office365-Filtering-Correlation-Id: da76e8dc-3cc7-4571-302e-08db932d6fbd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	iF80wxx0crEpSVzrGKGjDG0SNeZg7legJa0q0gb+u3RVMWWIn2e/9j6rC5g3ra42JTk4RZLMtykDiAVy62buFa8YZWys+6WvaiVjaLYaiyrFXGzZ72h1XahwKhx4cf7owQ/gPeLcx1PKju/Vv4LqV/uUZIHMh0zqzyewvKa32FZnN4lIZTJqn+HLEe0Q6AWz6LU0Ct5wtcnAtKlOdwLjk4lCtgbDNb9guJDVohDvNYh8ri1QC4mRC+y5Mn1i/tNav5oADGm0b1NhVDf75UKylC5qLKu1itg7gpcGX+UzGbipdqZqwvhE0vxXk0vR5rJ2zl6cER/A0YJBll8n3VmkIFGsQnzr3deXHu1/O3FXEb0qtQdAdnH5ztm2Q6iGf8A1/4CR7qveR/XX1rwTJ1yhA3OxVrl6GiReI95pR+klvMghxQt1O8kY17S5f6JDt/hKAZh0l+ow06BMzhglQCsSMAErHc/a6YR2xXEl6sTC2dak/4JqaRaCfEEbm4f0Egi5PnHzk66TPaXL/1/UgI65sXvaglFw87JqNK9P6Y9KAukaQ+OISZS4ZgS/22rTxYDmhPCmLXbPsZrZ2zbP7wa6ulKCakinQbSC4w/rT2kYEkazRRRwG5BtQnii09DxdommOuUDVugLX2hXAFaa5L6rBfCHBZg8WuBUTl0VdDtp1/3ShlUI5lFghyJxENg29qCTxAPthyfrVUqEIOLig5CD4XbVCwml6drKGOxMlLbYpMJGDg0AaANxFNUhx6jIyVLgySlYxPpY92hxVWo23hUNS7gz36YZGSkWX9maP0I+w2k=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(346002)(39860400002)(376002)(82310400008)(451199021)(46966006)(36840700001)(40470700004)(6916009)(4326008)(40460700003)(70586007)(70206006)(2906002)(426003)(2616005)(82740400003)(356005)(7636003)(16526019)(336012)(186003)(1076003)(26005)(83380400001)(47076005)(36860700001)(54906003)(40480700001)(86362001)(107886003)(36756003)(478600001)(966005)(6666004)(41300700001)(8936002)(8676002)(5660300002)(316002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2023 07:52:35.9756
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: da76e8dc-3cc7-4571-302e-08db932d6fbd
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000971E2.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6607
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

The default timeout for selftests is 45 seconds, but it is not enough
for forwarding selftests which can takes minutes to finish depending on
the number of tests cases:

 # make -C tools/testing/selftests TARGETS=net/forwarding run_tests
 TAP version 13
 1..102
 # timeout set to 45
 # selftests: net/forwarding: bridge_igmp.sh
 # TEST: IGMPv2 report 239.10.10.10                                    [ OK ]
 # TEST: IGMPv2 leave 239.10.10.10                                     [ OK ]
 # TEST: IGMPv3 report 239.10.10.10 is_include                         [ OK ]
 # TEST: IGMPv3 report 239.10.10.10 include -> allow                   [ OK ]
 #
 not ok 1 selftests: net/forwarding: bridge_igmp.sh # TIMEOUT 45 seconds

Fix by switching off the timeout and setting it to 0. A similar change
was done for BPF selftests in commit 6fc5916cc256 ("selftests: bpf:
Switch off timeout").

Fixes: 81573b18f26d ("selftests/net/forwarding: add Makefile to install tests")
Reported-by: Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
Closes: https://lore.kernel.org/netdev/8d149f8c-818e-d141-a0ce-a6bae606bc22@alu.unizg.hr/
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
Reviewed-by: Petr Machata <petrm@nvidia.com>
Tested-by: Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
---
 tools/testing/selftests/net/forwarding/settings | 1 +
 1 file changed, 1 insertion(+)
 create mode 100644 tools/testing/selftests/net/forwarding/settings

diff --git a/tools/testing/selftests/net/forwarding/settings b/tools/testing/selftests/net/forwarding/settings
new file mode 100644
index 000000000000..e7b9417537fb
--- /dev/null
+++ b/tools/testing/selftests/net/forwarding/settings
@@ -0,0 +1 @@
+timeout=0
-- 
2.40.1


