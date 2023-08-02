Return-Path: <netdev+bounces-23552-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7615076C798
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 09:55:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 303BB281D10
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 07:55:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3C795692;
	Wed,  2 Aug 2023 07:53:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D364263AF
	for <netdev@vger.kernel.org>; Wed,  2 Aug 2023 07:53:08 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2083.outbound.protection.outlook.com [40.107.220.83])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5247D10C7
	for <netdev@vger.kernel.org>; Wed,  2 Aug 2023 00:52:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NPErPjbwRXto8NeDQ3gFEhYbLJ4hxXG2a07J54qRJuGvV00ByZ1wvJjSMARc1r/eSc1/oqovreQBpIE0uzv3HtbayxBNQybfVdHe7uNlSH6DGZjDic+ysorCr3HyCNohXR32yUrccuYrdFr5uIGGNlVjrzPJxHeGv9ua0OkfMe0UgM1xp9YAujnrVIdpPGfPoxllDH2R7sMW9Onnr0EF/CRMaWPpkqHOx2/TW5516BOdP18BmxR5fCU3bJICPeN4SwDa80sdTweR4KZgTzpMBGpv0/X07gA5KLdKpbIPHi5K+6AwoKnVPtZRyWxAOxJwwVRxrG47ADoJyEA6wzBofw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FMj/epV3tCNjfYQ8wYwqVCOsGSb+mKS/0AyZduT/v+A=;
 b=ZUMY6oCmD1aB9t3sLsTwjDZ5I09Ak/8IYQ76VnfelsIbZv3BXuzlpJmtkI3VjK4qN2SdfAEZygp/gyLQF5nCzQNr2J0n4AIQPSnyWqN+ZPQI8sgORmb1OOxvcs+IWVM/tFFUMz6WqdldwjPOrRdV6z4GQ8vG8doTiEOV2H4okfQnfyBtZzgXOVOmxtHPWOg9ksrKtmF/P4haL+o0Muu3XCJKyUqx1CCE+CyuOBQJ+2vFYGcufMqSJ+nhjldfPT6G0oVMgct/dX7+LXd8eHHEQnoLSaB5Wp1c8oOucpf7/pni+b97rSBCv78jlcrSJBQh4+qpgpk+jEcM0N1oDRZGqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FMj/epV3tCNjfYQ8wYwqVCOsGSb+mKS/0AyZduT/v+A=;
 b=T+oGXmrOu8ZTK3I0qToCacgwxUsQB4VwVbcg3IZuZY1nhV4Wy33DEp4pxlFKoH6EcYD3lqKca9WHmpNTvYWTyAFd5uA80YZj2MjxJm3Jts+7K+GbOE6sm0Q9dqKRwbiFD0KdHhiTGyQ2u0qsRhUEflindrxdkYmqg6KPEerPnN3XD8s6HzMYXxHvO4JwsE+jU3gCB0aakU8JI/PkY6ktS+YchzVyLbVXOMj59Q6J6JL8ci1hicR3Mcx+rhvaKe56HNtruABTVus5snF7gxu+JhbZZ+Yqr4JVskntn6n8fjKWcL1eXmtyvn0ZtqmAsAkaP9ZiSSk5NYjZh/MpvwA92g==
Received: from MW4P220CA0013.NAMP220.PROD.OUTLOOK.COM (2603:10b6:303:115::18)
 by PH0PR12MB8150.namprd12.prod.outlook.com (2603:10b6:510:293::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.45; Wed, 2 Aug
 2023 07:52:50 +0000
Received: from MWH0EPF000971E6.namprd02.prod.outlook.com
 (2603:10b6:303:115:cafe::aa) by MW4P220CA0013.outlook.office365.com
 (2603:10b6:303:115::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.19 via Frontend
 Transport; Wed, 2 Aug 2023 07:52:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MWH0EPF000971E6.mail.protection.outlook.com (10.167.243.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6631.25 via Frontend Transport; Wed, 2 Aug 2023 07:52:50 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Wed, 2 Aug 2023
 00:52:38 -0700
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Wed, 2 Aug 2023 00:52:35 -0700
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <petrm@nvidia.com>, <razor@blackwall.org>,
	<mirsad.todorovac@alu.unizg.hr>, Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH net 07/17] selftests: forwarding: ethtool: Skip when using veth pairs
Date: Wed, 2 Aug 2023 10:51:08 +0300
Message-ID: <20230802075118.409395-8-idosch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E6:EE_|PH0PR12MB8150:EE_
X-MS-Office365-Filtering-Correlation-Id: 88007b1a-82ab-4cad-3b60-08db932d7824
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	r77hUhV2DRH2ZHYmX6anCnrCFnT81tn3N3Z023PwHCQ09HesNgPvIB6yHql16z7ayuKF9gseVfOcIH6fRnMEo7R7XsXFroSVKq4r2WNOpeQ8pSXsZkPYzhNTKUdlJ1H2SJv7Kpvm8LIZNQbvIUYnUbkvJMFJxYq/cAXqq1QK7GbcIgTjfb3ZAXkbFSpcli47DJTKWCQZMqSaiaoOEzA7L2o7rXDfJcuRAMnGJ+Jg1izU5IbpevkjkncvO//zARNKhJjCqUMFt+wpgTxkTukccgAhrH06//Mq9CsAcWbBIsIAl340d7mQCtG0FxW2mApX7yh18c9sC2PxNHjZwen1atShuMSYijfhAMB9jLYVOnMZmhuKJd+MATLqUeeIg0dtvmFMq0I/TYEKh+XKeq0FhDX27sp6AbBWuFPP53LRq1fdXqbRJi15q30+of8tckhdK/+SO36oyTDmYlL9zc075FxEkRsIMu2keCs5dUOPhXz1CyMAQ9ToQbHzLIyWKmNXsF6cnbTlLIGUnXW2vfIL/iJ7+1mvy9rB74svTtvgMLbGHA/evCscKDs+oyP7u0HRa4S0RPuPOBrWOU4KWXOGjGT46Ch8jrfeM7e0VvWiy/JH8YgAmberME241S8xkYlqVpCZnw1ovnKwnsCiZYw7l7oG0tEBXTafwwB9i45YSJX7WxHCGdkP2mk2pBof0j4VmYnyGDRhqOZzzfvs+AIejbSp+LNVGn2nAdPwA97kTJIdtZnvTAQsF2JgY2QcohE85+kBGImNx2dAZH2qxUBZwg==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(346002)(396003)(39860400002)(82310400008)(451199021)(36840700001)(40470700004)(46966006)(40460700003)(2906002)(70586007)(6916009)(70206006)(4326008)(6666004)(86362001)(966005)(83380400001)(478600001)(36756003)(426003)(336012)(186003)(16526019)(7636003)(356005)(82740400003)(107886003)(26005)(1076003)(2616005)(36860700001)(40480700001)(54906003)(47076005)(41300700001)(8936002)(8676002)(5660300002)(316002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2023 07:52:50.0571
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 88007b1a-82ab-4cad-3b60-08db932d7824
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000971E6.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8150
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Auto-negotiation cannot be tested with veth pairs, resulting in
failures:

 # ./ethtool.sh
 TEST: force of same speed autoneg off                               [FAIL]
         error in configuration. swp1 speed Not autoneg off
 [...]

Fix by skipping the test when used with veth pairs.

Fixes: 64916b57c0b1 ("selftests: forwarding: Add speed and auto-negotiation test")
Reported-by: Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
Closes: https://lore.kernel.org/netdev/adc5e40d-d040-a65e-eb26-edf47dac5b02@alu.unizg.hr/
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
Reviewed-by: Petr Machata <petrm@nvidia.com>
Tested-by: Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
---
 tools/testing/selftests/net/forwarding/ethtool.sh | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/net/forwarding/ethtool.sh b/tools/testing/selftests/net/forwarding/ethtool.sh
index dbb9fcf759e0..aa2eafb7b243 100755
--- a/tools/testing/selftests/net/forwarding/ethtool.sh
+++ b/tools/testing/selftests/net/forwarding/ethtool.sh
@@ -286,6 +286,8 @@ different_speeds_autoneg_on()
 	ethtool -s $h1 autoneg on
 }
 
+skip_on_veth
+
 trap cleanup EXIT
 
 setup_prepare
-- 
2.40.1


