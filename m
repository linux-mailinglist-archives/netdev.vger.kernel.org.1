Return-Path: <netdev+bounces-26837-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 738BC7792A4
	for <lists+netdev@lfdr.de>; Fri, 11 Aug 2023 17:15:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2BD61281099
	for <lists+netdev@lfdr.de>; Fri, 11 Aug 2023 15:15:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06C1C2AB2F;
	Fri, 11 Aug 2023 15:15:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE17863B6
	for <netdev@vger.kernel.org>; Fri, 11 Aug 2023 15:15:12 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2065.outbound.protection.outlook.com [40.107.96.65])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A89130DB
	for <netdev@vger.kernel.org>; Fri, 11 Aug 2023 08:15:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eFZqngYk3ARET/CEe75tShE1oY9oredb2QC7Pmvk441GSbknqBwvYIXAJd7Z0U+YXeDBaiTxyFFqJu8jCC3PEbEYkwwj6SsYV/QonYCV8X9L1U/M4/fXkCwc+/4u6rwE74RIEQ47pjgzAh0yEg+gYIa50vHqYGstwwcmfPqlxqAh/n55cLi9fFKjv9yKlDIRUJR1e+Qu26M6ijKEOjAl2d9Uhd4+hFm47Hgz6Gw516XS0o2HZVBSB/Gr5iPtvh9q49sdBU2XBK01PlenHjaEs7ibHWTc+Ou90DPrDW/FehWUX1U1pHxWgaCw++A6rtgGKKNGN/OXfrAjFxZ5p3idGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=78KCfbVL25g1YzM4LukslY3PnyzpBy+2ExDWaUmr5nM=;
 b=WJVKLsivWsNhkSuuOosmnHBErL1SklHTi4Py7xfI/WKdFKiGDM3200PGbNTrzy+nmjdKp150T4AF6+lANeS53AhSrySz7g95dZWLNBT1ozh4ee93z7oc3EhyTp3pRg3k0iQf4Xg8kN2fLYlvFrM/fRTTVE9tbqhMNIGqzZ+Q7cCeayaQWtBhs2UrFvnxxNu89q/gsYeZe9j76bOoabx3qys0U0fyC/wqRAyFJT+0RrkZT8LGen0/9BKd+TySt5OEZMxN6AD18TxvpIR2y4zXD2VI4fdrfdbbkAiBxynjwPJVyyrBsSoBRhAH64SOzpAeu9/1Emzl2v0ximrfh1qZmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=78KCfbVL25g1YzM4LukslY3PnyzpBy+2ExDWaUmr5nM=;
 b=XwmqpD9x+R3hGzxZAKGaH/u4EkRhj8XGCZ87qzlLvan4NqHQGhSXKBOsOF5jY4XKCIMs6kFEyJxFVkdXSLrUUTkHhwvpanPzXJ8ti7g2O7Nsq5Vlahqsr1GvT6Kgv5x7oXTsInKOER/2u1aYxnf/PikK5pLHFqeUY9BGLSfFh7w8Unoo8qsbaAPOmyR98r5pJ6GqXOsfqVtq1nknK67VZf7UKMB5G+J0Jjp9z3LVcNR4ClxEh/7wq6FLn8ox5Si70SP/UHNSMeIF1q0yyh5kzvoFAWkViYStZ+HpereDYZ/bQbiEjs+j4ogDMaUnEisugLE1wt7iLT8abPBgsBlN9w==
Received: from MW4PR04CA0261.namprd04.prod.outlook.com (2603:10b6:303:88::26)
 by PH0PR12MB7009.namprd12.prod.outlook.com (2603:10b6:510:21c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30; Fri, 11 Aug
 2023 15:15:04 +0000
Received: from CO1PEPF000042AD.namprd03.prod.outlook.com
 (2603:10b6:303:88:cafe::a9) by MW4PR04CA0261.outlook.office365.com
 (2603:10b6:303:88::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.31 via Frontend
 Transport; Fri, 11 Aug 2023 15:15:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1PEPF000042AD.mail.protection.outlook.com (10.167.243.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6652.20 via Frontend Transport; Fri, 11 Aug 2023 15:15:04 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Fri, 11 Aug 2023
 08:14:42 -0700
Received: from localhost.localdomain (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Fri, 11 Aug
 2023 08:14:39 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>,
	<mlxsw@nvidia.com>, "Hans J . Schultz" <netdev@kapio-technology.com>
Subject: [PATCH net-next 4/4] selftests: forwarding: Add test case for traffic redirection from a locked port
Date: Fri, 11 Aug 2023 17:13:58 +0200
Message-ID: <27cc1c994a7388f8d53a0cdf8352db29c0f88d45.1691764353.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1691764353.git.petrm@nvidia.com>
References: <cover.1691764353.git.petrm@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.37]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AD:EE_|PH0PR12MB7009:EE_
X-MS-Office365-Filtering-Correlation-Id: 8cb9e5c6-e19c-48c5-5d11-08db9a7dbd7e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	8ekJ8zMd84IsGstcdx8WEhESuQ/fx2TVUpOPGjlMdisbf93lO/mHV8FfgqhivfAGARZRrTXdNmuJC+428ug3cMtTpvRxzY1ubCEYfj0ym6ZQj/sCsQjfGYd0kCBHkqxmB8rVPhAjqUxLRW+nHQIZK84A4rirJ7FgvsXBL6TmOqn3Qe86Xd7Q4Pr8JSg3V/gpm4m0uFdLDaDXActfmA0Ji/x/Xz3DlRYj0zdfAUqikVtay4T/91VQiWFdHIQP13+YdwGccYpGPHfrAre5Hgjty9aVTbauSXsvk9tQp/HyL+cV0wmPrj/CJ3XUwxxtwlrW75HO/fBT4UklX1TB5Afp7df8IVdk9eDXUXYcCMrLUVmGCJbUOATOIl44oRI94ZsXNitDTXhIN7fleI0ZjEfMCi2tsoglFQqAZ+n/6bRtEgowP4ZQz3/Nu5gmSg1crBg3Pi0aS3SPsfcRxDrNZvGPNFAYyss3aG50zQEZJ8SlMkVHkUrw4Cx41FKLhDHlvyDbFvkNmo+BHKcrveK8QDb6JukFW5j2uRDzwzafRNRuSFL9L5KaXtEbpTZf0WeICEdctWbcNCMGOuounblmO/17CQ7u5FaRF34iuU5keCSk7sGohax5vTeSVb90CV2SAtLQpwZLJGHm1/k977cm8EMNY3BRnNUBtWUZ0k+1ac+XuoXTyGOinVjE9D+VeA7oOT1x/VXxX0vkfgr/5POIXNBM81yAVbtbnnBF017M/EsOmx9Vaa+Et7P0PT8SefeuqsXD
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(396003)(346002)(39860400002)(186006)(1800799006)(451199021)(82310400008)(46966006)(40470700004)(36840700001)(26005)(5660300002)(8936002)(16526019)(41300700001)(8676002)(336012)(6666004)(86362001)(7636003)(356005)(36860700001)(36756003)(2616005)(426003)(47076005)(478600001)(70206006)(110136005)(54906003)(2906002)(316002)(70586007)(4326008)(40460700003)(40480700001)(83380400001)(82740400003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2023 15:15:04.2884
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cb9e5c6-e19c-48c5-5d11-08db9a7dbd7e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000042AD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7009
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Ido Schimmel <idosch@nvidia.com>

Check that traffic can be redirected from a locked bridge port and that
it does not create locked FDB entries.

Cc: Hans J. Schultz <netdev@kapio-technology.com>
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
Reviewed-by: Petr Machata <petrm@nvidia.com>
Signed-off-by: Petr Machata <petrm@nvidia.com>
---
 .../net/forwarding/bridge_locked_port.sh      | 36 +++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/tools/testing/selftests/net/forwarding/bridge_locked_port.sh b/tools/testing/selftests/net/forwarding/bridge_locked_port.sh
index dc92d32464f6..9af9f6964808 100755
--- a/tools/testing/selftests/net/forwarding/bridge_locked_port.sh
+++ b/tools/testing/selftests/net/forwarding/bridge_locked_port.sh
@@ -9,6 +9,7 @@ ALL_TESTS="
 	locked_port_mab_roam
 	locked_port_mab_config
 	locked_port_mab_flush
+	locked_port_mab_redirect
 "
 
 NUM_NETIFS=4
@@ -319,6 +320,41 @@ locked_port_mab_flush()
 	log_test "Locked port MAB FDB flush"
 }
 
+# Check that traffic can be redirected from a locked bridge port and that it
+# does not create locked FDB entries.
+locked_port_mab_redirect()
+{
+	RET=0
+	check_port_mab_support || return 0
+
+	bridge link set dev $swp1 learning on locked on mab on
+	tc qdisc add dev $swp1 clsact
+	tc filter add dev $swp1 ingress protocol all pref 1 handle 101 flower \
+		action mirred egress redirect dev $swp2
+
+	ping_do $h1 192.0.2.2
+	check_err $? "Ping did not work with redirection"
+
+	bridge fdb get `mac_get $h1` br br0 vlan 1 2> /dev/null | \
+		grep "dev $swp1" | grep -q "locked"
+	check_fail $? "Locked entry created for redirected traffic"
+
+	tc filter del dev $swp1 ingress protocol all pref 1 handle 101 flower
+
+	ping_do $h1 192.0.2.2
+	check_fail $? "Ping worked without redirection"
+
+	bridge fdb get `mac_get $h1` br br0 vlan 1 2> /dev/null | \
+		grep "dev $swp1" | grep -q "locked"
+	check_err $? "Locked entry not created after deleting filter"
+
+	bridge fdb del `mac_get $h1` vlan 1 dev $swp1 master
+	tc qdisc del dev $swp1 clsact
+	bridge link set dev $swp1 learning off locked off mab off
+
+	log_test "Locked port MAB redirect"
+}
+
 trap cleanup EXIT
 
 setup_prepare
-- 
2.41.0


