Return-Path: <netdev+bounces-22872-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BBE24769B1A
	for <lists+netdev@lfdr.de>; Mon, 31 Jul 2023 17:48:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C3D4D1C2096E
	for <lists+netdev@lfdr.de>; Mon, 31 Jul 2023 15:48:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9F7F18C3A;
	Mon, 31 Jul 2023 15:48:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B74AD19BA5
	for <netdev@vger.kernel.org>; Mon, 31 Jul 2023 15:48:00 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2059.outbound.protection.outlook.com [40.107.237.59])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 426E610D
	for <netdev@vger.kernel.org>; Mon, 31 Jul 2023 08:47:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gdxgOQMl272tfG1ZsK73ySgZUPm9eEf8A3gKzUP0CCBZRouXK2Kxwa+toB6ryqEjox0K2INsPDsJiF7nwTwiQWEPmnGjxNVsV3hUvrjbSieD7xWGUFkDjTkIjbIozOmzP1o8RJGXFJxPQzZ9YC92Ymf7HOtYo/HBkHwSKgR7qYzHcYicLuERe3KUote24v+dLWXzcuGMdkFTDM28lFpW3Yx0Sr+6GgcS4C4dCOrRAXMHxHC0h5wUQ6GUsenaduXaJbjSyGtyozU1bdZh6WGwBCfXRk5VrV+XCxPnHLvdJFgHBCo7wqUXro70mH9ExvOEmkFN1Sae1swtXKjjlvQVrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EDPpoBOTnnN9FCfzF+av/nPeh8MiumtcRqcncIGsc1M=;
 b=B15PsheHndV/GOwFjpb8sf10qAU5C+9GhDTDtBYiwawc+dKVTFUxLjUvfWb79TbVDjndGLPctbIk9LV9l6dYLO3KSELBaBcMiCAeCrJIZbG7jpQ5sK6oIcKkviE1yBtMa1sktWwf45wnXgbBB4Uyb8RGXbDGFQ1UHp9IHi1SQpbPaueqFwCC0nO3+jhL73J0Dodwwk32TAbMTctIqOZGdyR/yYw3LOnZiBQO/Ap+371MLo3CKcljcuLyESRrG9VeN6/cVhgr5qCmU/5Dkja1XjOCgzQPAdBFsvFDVOzOLu50pzNT4ZnFF1l6QAPwrSCyIrWT9Mrv/CSn4aMbiz5GQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EDPpoBOTnnN9FCfzF+av/nPeh8MiumtcRqcncIGsc1M=;
 b=kmyCQqts9d1+4nl9SLOgLJIATy1vljaVv+ieFt0YPfL7j0IN/2Pfe3jW3Rj1AHAgDWTspAxsafl7vH94aCm8bCSXxNkBZILfDUq7opxPeRleuGd3BDWehP3Y+UpJ4jMboBx3Zy3OWizKUp2t4uCp2x9Mdq7FoL3NTnZp3MIF7OUQjaCMQadP/6kBBjharTLjqfTbHCVVvYEnojii8LJp6FatBX1bY1L7qAo5HVhJ414+q8cUsHzTjZ7MDrogTKVvGP4dlnnBHs0iJLWf3oHGxRnX8Iwr5cxBi3H7EMkd2AP5tp8MZeWIeKaum0uefmuYE9pggJGxTehOyv9B/NmFMw==
Received: from MW4PR03CA0219.namprd03.prod.outlook.com (2603:10b6:303:b9::14)
 by LV8PR12MB9136.namprd12.prod.outlook.com (2603:10b6:408:18e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.43; Mon, 31 Jul
 2023 15:47:57 +0000
Received: from CO1NAM11FT051.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b9:cafe::69) by MW4PR03CA0219.outlook.office365.com
 (2603:10b6:303:b9::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.43 via Frontend
 Transport; Mon, 31 Jul 2023 15:47:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1NAM11FT051.mail.protection.outlook.com (10.13.174.114) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6631.44 via Frontend Transport; Mon, 31 Jul 2023 15:47:54 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Mon, 31 Jul 2023
 08:47:46 -0700
Received: from yaviefel.vdiclient.nvidia.com (10.126.231.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Mon, 31 Jul 2023 08:47:43 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>,
	Danielle Ratson <danieller@nvidia.com>, <mlxsw@nvidia.com>
Subject: [PATCH net-next 1/8] selftests: router_bridge: Add remastering tests
Date: Mon, 31 Jul 2023 17:47:15 +0200
Message-ID: <fb0ca021be3647d157ff8b8dd65990130ff3329d.1690815746.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1690815746.git.petrm@nvidia.com>
References: <cover.1690815746.git.petrm@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT051:EE_|LV8PR12MB9136:EE_
X-MS-Office365-Filtering-Correlation-Id: 840dfabf-d548-42db-f0ad-08db91dd8185
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	4r3P6cg/igqliRFKO9WQ3aPJTOp/lNP22/32Qci/gfK6ywa4xwMdYp7pvIHjjLn19ppCNI5coEwewfPqlBXAAMPB6ha2ozszJM7ATF+EjOi2xeK7omaGsvjOFyvfNsNJQwK9oWIzbh2MlvnoVwQq3s5wohl2h1Flq6Dv2cVU7DrnRLJ2New3Hkf+S9KgAQf4ompqhcu6GJTSdeHS6somvetlHhqhSB/j3fozjLUyrF6yk7LTII0OQzBprONzdXs97Mz2BuwcsHHiBZ/jvTOXXX+2KN9Q0fGRUJDK9fFcQjMra91VQIotFGRIS5BVHEt0mIv+qPymt8Zn/62sNQtpJxbCfbeY9qS44+UZz30su9XkjaVViE7blCEN3Wq2Cmb/YtbMxnCqG4MSsBM6UNgA88eAkmzo6/raeE4D6Zzd1jq5zsPJlZziI8G7D0VVJtBmT87e6efy+6DuF9cN8WY8DwZkMIpd+BeLwcDVwxstXvTJ5QzPvxKyWCU2Efzno7pAw47zgua9ZnNzdaPdjj+a1u/QXhxGK66LmFYFH0gLyx/y9GmrMaglbN3zIcx9LSXahchwYi+6q/fUxITCcGe7I9elzAidMtaY0vu+mj21+747ifrlKHV9ZqerGSQkH2UX+a8y8lmDpGxnaCCj7xVxOKvvlQ6w80gxFp8bwFHduc6+Ed7k1bXtlXwjOp1jg3StA6bUXBGrHFmrgtqqr326dZOU6RWPUlG4jx4teK6X9OncipYnlCiLsWUsDpo8wYSB
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(396003)(136003)(39860400002)(451199021)(82310400008)(46966006)(40470700004)(36840700001)(86362001)(8676002)(8936002)(316002)(4326008)(5660300002)(41300700001)(356005)(54906003)(7636003)(70206006)(70586007)(82740400003)(110136005)(478600001)(2906002)(6666004)(36756003)(47076005)(36860700001)(7696005)(107886003)(26005)(83380400001)(426003)(66574015)(186003)(336012)(16526019)(40460700003)(40480700001)(2616005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2023 15:47:54.8958
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 840dfabf-d548-42db-f0ad-08db91dd8185
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1NAM11FT051.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9136
X-Spam-Status: No, score=0.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Add two tests to deslave a port from and reenslave to a bridge. This should
retain the ability of the system to forward traffic, but on an offloading
driver that is sensitive to ordering of operations, it might not.

The first test does this configuration in a way that relies on
vlan_default_pvid to assign the PVID. The second test disables that
autoconfiguration and configures PVID by hand in a separate step.

Signed-off-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Danielle Ratson <danieller@nvidia.com>
---
 .../selftests/net/forwarding/router_bridge.sh | 26 +++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/tools/testing/selftests/net/forwarding/router_bridge.sh b/tools/testing/selftests/net/forwarding/router_bridge.sh
index 4f33db04699d..0182eb2abfa6 100755
--- a/tools/testing/selftests/net/forwarding/router_bridge.sh
+++ b/tools/testing/selftests/net/forwarding/router_bridge.sh
@@ -20,6 +20,9 @@
 # +---------------------------------------------------------------------------+
 
 ALL_TESTS="
+	ping_ipv4
+	ping_ipv6
+	config_remaster
 	ping_ipv4
 	ping_ipv6
 	config_remove_pvid
@@ -28,6 +31,9 @@ ALL_TESTS="
 	config_add_pvid
 	ping_ipv4
 	ping_ipv6
+	config_late_pvid
+	ping_ipv4
+	ping_ipv6
 "
 NUM_NETIFS=4
 source lib.sh
@@ -86,6 +92,15 @@ router_destroy()
 	ip link del dev br1
 }
 
+config_remaster()
+{
+	log_info "Remaster bridge slave"
+
+	ip link set dev $swp1 nomaster
+	sleep 2
+	ip link set dev $swp1 master br1
+}
+
 config_remove_pvid()
 {
 	log_info "Remove PVID from the bridge"
@@ -102,6 +117,17 @@ config_add_pvid()
 	sleep 2
 }
 
+config_late_pvid()
+{
+	log_info "Add bridge PVID after enslaving port"
+
+	ip link set dev $swp1 nomaster
+	ip link set dev br1 type bridge vlan_default_pvid 0
+	sleep 2
+	ip link set dev $swp1 master br1
+	ip link set dev br1 type bridge vlan_default_pvid 1
+}
+
 setup_prepare()
 {
 	h1=${NETIFS[p1]}
-- 
2.41.0


