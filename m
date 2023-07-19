Return-Path: <netdev+bounces-18958-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B24067593AC
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 13:03:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F6522816E0
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 11:03:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 287EA125DD;
	Wed, 19 Jul 2023 11:02:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 173BB12B91
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 11:02:25 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2063.outbound.protection.outlook.com [40.107.243.63])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACA3B18D
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 04:02:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YDijI8eYVZULHzEQy4v1Ceh9GbvzLZrlE+x2LaIH8CaaB568XjQqLzKW07v8VwxFXbUwggVJxcRojiCCf9CWh2q8ymY8fnbWQfa2KVk5NvFOeIJndRu1lL898qMFoB2qYfqCTZ8DrtjW6hBd1vvjGz3x9KZds/116oopMaOprIu3fe63TUXMlSKQ1bCYBHAaYOvkbOFz97lWNYh3a4nDI4WzMM3cVbz9TmZjk7fE6RnMlsopueP622FUYYeOKO0RbL2HnasNT037/39pVifg67Tze/zj3erbVd8pbdUU0I7rsAZn8zR/keazkPWSYwQlRUb1YYUpRfwTxva9QJ4hqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JVRK6/WFVJyg2ATW/obbYzbtr6e4fIzSd1Z8srULDLs=;
 b=XgP//C7yH7EZiCORyAd1W4ZB1wVPFzG6F/opBLiVUG5oyCasb0C62SG+APFfjMWhI5JG8HT1HzftxH7w6E8Vn2vrT0Hloj+Bg/Ul+xQe5hmsDCkVik2mm4NG81QcwzcJUd4jO2m6n90g1xpTDCkRz6YtvcWHIMExvwPBk2tvEHZLo1ibAAY7pkLWRkGhWIHyw+N+gZ34zOgADlPWEm+NUUln7CYIxpqc8LNOC5p8RHfWSBqGFX4AIbGKr3qVgfMeDqds4lT9DLwPA/er0ShiAXGa7akI678OqP82EdXVB5vS23zs+/pXMpgQYzg9G4fBuxBnCqLgiqaHAj2jakFBNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JVRK6/WFVJyg2ATW/obbYzbtr6e4fIzSd1Z8srULDLs=;
 b=SQSKLgOGhzVamUfU3h6e9U4kp1ZTLJAqVmpocqUkp7jr5zZJUHUYWeTTeg+kmbEzOQMik9aQRO0CfYfym+UHORvtOPK5ps8CV5v+Tglyr+W8+iou8R+O05f3AkLki8eKjcpDnuZYdwd68bhHrBwOVkqM9CqkOPPqJ8w8Q++yYF5vtJ73v+R1MGAeG5kAfpkeohaJ5Bdp+xaEv171BAWztXS/nG405ZzQJ1UIFv0xFBqGc32RbcXA81twn7hPlIJ6wjnmMmRbXp/qri8/9wqps0vOV/4Fo3k+51QeVIMHFsYxS+joZDa3PbYC9eAdrSmZHC5TyJSS4C0kT+dt5c1MHg==
Received: from BN0PR02CA0042.namprd02.prod.outlook.com (2603:10b6:408:e5::17)
 by SA3PR12MB7782.namprd12.prod.outlook.com (2603:10b6:806:31c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.24; Wed, 19 Jul
 2023 11:02:21 +0000
Received: from BN8NAM11FT029.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e5:cafe::d0) by BN0PR02CA0042.outlook.office365.com
 (2603:10b6:408:e5::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.24 via Frontend
 Transport; Wed, 19 Jul 2023 11:02:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN8NAM11FT029.mail.protection.outlook.com (10.13.177.68) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6588.35 via Frontend Transport; Wed, 19 Jul 2023 11:02:21 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Wed, 19 Jul 2023
 04:02:06 -0700
Received: from localhost.localdomain (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Wed, 19 Jul
 2023 04:02:03 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>,
	Danielle Ratson <danieller@nvidia.com>, <mlxsw@nvidia.com>
Subject: [PATCH net-next 03/17] selftests: mlxsw: rtnetlink: Drop obsolete tests
Date: Wed, 19 Jul 2023 13:01:18 +0200
Message-ID: <4d096f90f48cd8466156876ed18f9c8cdd4ece97.1689763088.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1689763088.git.petrm@nvidia.com>
References: <cover.1689763088.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN8NAM11FT029:EE_|SA3PR12MB7782:EE_
X-MS-Office365-Filtering-Correlation-Id: 360e1c36-f5c2-490b-2a2a-08db8847a038
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	DEfRI8MF2hgYqcGxp0Ifxjl8s2qdB2dNz9+BLT7dBikoIM7l9cXmy+tzT2EaOY5/9R5nmRq/ErCjeC1pM5OK5jYNBTRuFbO4tgrkCitR2lP33Op0of+U4crNs6G0z6xDTcM/z1OwS3Y+f9G/1hvOjdB7Hr2rzMCrgaXlJCLIZlCV5FKfTvXpb/mqcstzeIg/VQDAeHgZAD4/+6MNF9vUuioKv5l95ExrV1q/nRjBXnusQrhfvNzazeZ+AzsLbHf7vnDRcQY+6gjoqJKhNaFcwMImuqGWMZx9zpgTCVeS/b3A6upZ2/nhqbtuUSNKrPi/wcq+MB5itC29DhfGOOXSSY2kPDeK/gkHSeePXEm++d9cNemZKl+jlwQ7C4dQ6oIcrblSpGVxjN3bHTY6PNDV40pKEfzMs9DaVYNfj+c4NI3bQkx1Oijc/0gLCgKrICsY1C2iAN2lE1WIGxy3tH2mL0HhrhgunDh48JlJVdLLcNCNJMFVC++oDEtebqBAP/PkfGcI7yqzJCpQDUOQ1HbqfzpgG2Rtr7z45XisjGftwycstHgto1ivGQ0ikHjCeI6xCoKidiHOld++Z1fwD3HTJZUhwkQ1W2eRbKBJN43FZO7z6owA8leiz/ZyLHgKVlE2MspCXyqoS0iTdLd1DCjl3vW27S0MscF7kyR/0Dj7NYy3qI94FOiAP8NTJfWcMqKrtQXiaL3Hg7jIKFsRkNjpPTe5grlIbwlFpTG5rhiEN04=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(136003)(39860400002)(396003)(451199021)(82310400008)(46966006)(40470700004)(36840700001)(36860700001)(70206006)(40460700003)(6666004)(107886003)(2906002)(356005)(7636003)(316002)(8676002)(8936002)(4326008)(36756003)(5660300002)(82740400003)(47076005)(16526019)(70586007)(426003)(2616005)(186003)(40480700001)(336012)(26005)(41300700001)(86362001)(478600001)(83380400001)(54906003)(110136005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2023 11:02:21.3116
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 360e1c36-f5c2-490b-2a2a-08db8847a038
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN8NAM11FT029.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7782
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Support for enslaving ports to LAGs with uppers will be added in the
following patches. Selftests to make sure it actually does the right thing
are ready and will be sent as a follow-up.

Similarly, ordering of MACVLAN creation and RIF creation will be relaxed
and it will be permitted to create a MACVLAN first.

Thus these two tests are obsolete. Drop them.

Signed-off-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Danielle Ratson <danieller@nvidia.com>
---
 .../selftests/drivers/net/mlxsw/rtnetlink.sh  | 31 -------------------
 1 file changed, 31 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/mlxsw/rtnetlink.sh b/tools/testing/selftests/drivers/net/mlxsw/rtnetlink.sh
index 5e89657857c7..893a693ad805 100755
--- a/tools/testing/selftests/drivers/net/mlxsw/rtnetlink.sh
+++ b/tools/testing/selftests/drivers/net/mlxsw/rtnetlink.sh
@@ -16,7 +16,6 @@ ALL_TESTS="
 	bridge_deletion_test
 	bridge_vlan_flags_test
 	vlan_1_test
-	lag_bridge_upper_test
 	duplicate_vlans_test
 	vlan_rif_refcount_test
 	subport_rif_refcount_test
@@ -211,33 +210,6 @@ vlan_1_test()
 	ip link del dev $swp1.1
 }
 
-lag_bridge_upper_test()
-{
-	# Test that ports cannot be enslaved to LAG devices that have uppers
-	# and that failure is handled gracefully. See commit b3529af6bb0d
-	# ("spectrum: Reference count VLAN entries") for more details
-	RET=0
-
-	ip link add name bond1 type bond mode 802.3ad
-
-	ip link add name br0 type bridge vlan_filtering 1
-	ip link set dev bond1 master br0
-
-	ip link set dev $swp1 down
-	ip link set dev $swp1 master bond1 &> /dev/null
-	check_fail $? "managed to enslave port to lag when should not"
-
-	# This might generate a trace, if we did not handle the failure
-	# correctly
-	ip -6 address add 2001:db8:1::1/64 dev $swp1
-	ip -6 address del 2001:db8:1::1/64 dev $swp1
-
-	log_test "lag with bridge upper"
-
-	ip link del dev br0
-	ip link del dev bond1
-}
-
 duplicate_vlans_test()
 {
 	# Test that on a given port a VLAN is only used once. Either as VLAN
@@ -510,9 +482,6 @@ vlan_interface_uppers_test()
 	ip link set dev $swp1 master br0
 
 	ip link add link br0 name br0.10 type vlan id 10
-	ip link add link br0.10 name macvlan0 \
-		type macvlan mode private &> /dev/null
-	check_fail $? "managed to create a macvlan when should not"
 
 	ip -6 address add 2001:db8:1::1/64 dev br0.10
 	ip link add link br0.10 name macvlan0 type macvlan mode private
-- 
2.40.1


