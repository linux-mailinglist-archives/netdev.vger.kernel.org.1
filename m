Return-Path: <netdev+bounces-25332-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DE73773BEC
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 17:58:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB18D280EDC
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 15:58:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 343DE14268;
	Tue,  8 Aug 2023 15:46:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22CD7ECD
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 15:46:50 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2078.outbound.protection.outlook.com [40.107.220.78])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2530072A8
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 08:46:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P668yqYbuRUkyvWHy0W8ugfmJn3IHsVpPyrVu6jnu0eTZ+VXyhLXc+N5QEDoGmmgGTKVyOujyAmG1l67NzdwEq+PatzVxLRHAPiptTSPp51kRiHqBRuij9vteAgtrhUzHnrbjwxDVIYZ7CEpPY6soljp7Wb4DkqrH6vibg0YrHn7NS5gU4KfJyM1BTY0nWh5ZTxQ6hVLIip3E9pXjxVKBEHVwxHpwQ8gG7Gzc1+DhPuIaKAE9iqMKJ81aFYtfQ1hyRuztqGxfPDSmx3T8HcFe4kf1EKMhcNr7p9IbrSM7ydwp3UAQlYMhSbR0l0o2Ke8/IWP1Udi12WZsZ1mmBOdnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JAEhkbp83WFkGtREdB7j6AnK+4gGDtOFvE1DbgH4bTc=;
 b=jmtYIE7x1Z5xFHzbiCggL+iMGOXq+e4cRZh3S1jFQnSYrJbRmFW+EG3vYhRfXRKS4HFyTT43lCm+CsZWa9KkEgLEDGc28OpImwq45DsHrY/c6BMUGO5A0c1AxsAXH6ZW72vOgSkFH6aqlSJMsq2tz2ZEIVmBMx+nZdz0Y2Ks1a7B2xjZ63qVRrGtGuaOyDCd9EIBvx8PaUS93pL3mGoo/uj9xWo8aAsD62Uv8AeKkKOyipTQWMZ0JMCx78UG19iSDXYaqEQ5OwK/oah4meWdMQtgYYyXgbGOisN2MRL9YdcyMzo699yzn9eAHVjOoJCWTuQAeGH/AF4Wsle6FIv9FQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JAEhkbp83WFkGtREdB7j6AnK+4gGDtOFvE1DbgH4bTc=;
 b=aElLOQMamHZzCDVBlVbEthf/bvrObDjt3xXUYiYB9gDTfTgBLdR1o7IkY4V88hdEo4Qz6ZPW9hzjSK08LeuXei03LBFd9u6z7N6Dc2lpPdB2l57P7YiJItveNfOWKYZJd1An38ykCz/iXt3sfJDHe/vbtGT3Xu8+ANcWE9ISNy4A7GtlVQbIhHF2PjYpKwavs+4vMAr6RXKFUaYswbcnbLocGyBJCOIF+oZv0TSqBiR/+K5MTikHOwOt7wr8sieYZRz771KHyvtW9Tt22Wg2hkVZaii429G11cEx/fPlnU0x9Zczdm4PZDOdB2aosHsNsdtXWGeOG1FzHe2w2PP9TA==
Received: from MW3PR06CA0029.namprd06.prod.outlook.com (2603:10b6:303:2a::34)
 by CH3PR12MB8458.namprd12.prod.outlook.com (2603:10b6:610:155::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.27; Tue, 8 Aug
 2023 14:15:47 +0000
Received: from CO1PEPF000044F7.namprd21.prod.outlook.com
 (2603:10b6:303:2a:cafe::7d) by MW3PR06CA0029.outlook.office365.com
 (2603:10b6:303:2a::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.27 via Frontend
 Transport; Tue, 8 Aug 2023 14:15:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1PEPF000044F7.mail.protection.outlook.com (10.167.241.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6699.0 via Frontend Transport; Tue, 8 Aug 2023 14:15:46 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Tue, 8 Aug 2023
 07:15:32 -0700
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Tue, 8 Aug 2023 07:15:29 -0700
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <petrm@nvidia.com>, <razor@blackwall.org>,
	<mirsad.todorovac@alu.unizg.hr>, Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH net v2 00/17] selftests: forwarding: Various fixes
Date: Tue, 8 Aug 2023 17:14:46 +0300
Message-ID: <20230808141503.4060661-1-idosch@nvidia.com>
X-Mailer: git-send-email 2.40.1
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F7:EE_|CH3PR12MB8458:EE_
X-MS-Office365-Filtering-Correlation-Id: 01fb8bf1-8869-420d-197b-08db9819f5dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	HNrrfkDT1xhVMg5Q7rJZiOph0ffrjrCyh9Xz6FGIhp7ZUh+MP/FHGUmrG4HEB2aoPGBQxhUEHhj8ZhaK4bNJxTqSKY9IqG469WM8FdujiIvlJio5/Z6XnJa1zrAMACYh10MGNmn818pux2wn33tN3g+xCNgewycrKpvWbd7UtcMBXE7CUkB+vRrOC6s4HNvMzZHGuuGg6Qor5pFp+KVLCbW8SUDyj/39od2eIgfwPoJAixPCGI5U4EjHbpe14+oMo5yQDcq65uUB8iytjUygCWIR1Q6uf3cDaqbi5+91lYW17sFbRHtfDbcQ4iyDm83N3NE0uOu2oGPSVHHV+v/QXD/xzbfYbv6cZ+UncRwYp6On7mnYD6qDx5P6xMs8Rb03E386xw0yEmrndkwZSJUoGCf7x3Lfo0WgmcZf7kDaRrzrE26reWhzuVuXEv3+FRVRKfxlRz3c4d9nWMCOqhJyZjUc3dQI8voOv/QBO1gnTTVFBneWGIsb2/+Ya4nXanRDOEF5S0eQ2F5IC6jfe5kRPFTtF8GCsXHohisZRQ5MGXlIbu0gW6phTWcd5jITqFVOvMIUyzCVZQpqfFsjvLERhifdesBZFJJMsoLIQjbOBU5ZVyCNzAdmcKOhbMS7E6V016VmXhvuHs5yNyeqLg9jtYxUV/rcsHmmjCTiJpIDRKecwHbmQtv1noEbIDWya6JKrCEv+8YIa0IJY1ToVK37X74N1k17+hYss8gFzgeuXiw=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(376002)(39860400002)(136003)(451199021)(82310400008)(186006)(1800799003)(46966006)(36840700001)(40470700004)(8676002)(8936002)(5660300002)(4326008)(41300700001)(426003)(316002)(47076005)(83380400001)(40480700001)(86362001)(40460700003)(36860700001)(2906002)(6916009)(336012)(6666004)(2616005)(1076003)(107886003)(26005)(36756003)(16526019)(70586007)(70206006)(7636003)(356005)(478600001)(82740400003)(54906003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2023 14:15:46.8475
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 01fb8bf1-8869-420d-197b-08db9819f5dd
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044F7.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8458
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Fix various problems with forwarding selftests. See individual patches
for problem description and solution.

v2:
* Patch #10: Probe for MAC Merge support.

Ido Schimmel (17):
  selftests: forwarding: Skip test when no interfaces are specified
  selftests: forwarding: Switch off timeout
  selftests: forwarding: bridge_mdb: Check iproute2 version
  selftests: forwarding: bridge_mdb_max: Check iproute2 version
  selftests: forwarding: Set default IPv6 traceroute utility
  selftests: forwarding: Add a helper to skip test when using veth pairs
  selftests: forwarding: ethtool: Skip when using veth pairs
  selftests: forwarding: ethtool_extended_state: Skip when using veth
    pairs
  selftests: forwarding: hw_stats_l3_gre: Skip when using veth pairs
  selftests: forwarding: ethtool_mm: Skip when MAC Merge is not
    supported
  selftests: forwarding: tc_actions: Use ncat instead of nc
  selftests: forwarding: tc_flower: Relax success criterion
  selftests: forwarding: tc_tunnel_key: Make filters more specific
  selftests: forwarding: tc_flower_l2_miss: Fix failing test with old
    libnet
  selftests: forwarding: bridge_mdb: Fix failing test with old libnet
  selftests: forwarding: bridge_mdb_max: Fix failing test with old
    libnet
  selftests: forwarding: bridge_mdb: Make test more robust

 .../selftests/net/forwarding/bridge_mdb.sh    | 59 +++++++++++--------
 .../net/forwarding/bridge_mdb_max.sh          | 19 ++++--
 .../selftests/net/forwarding/ethtool.sh       |  2 +
 .../net/forwarding/ethtool_extended_state.sh  |  2 +
 .../selftests/net/forwarding/ethtool_mm.sh    | 18 ++++--
 .../net/forwarding/hw_stats_l3_gre.sh         |  2 +
 .../net/forwarding/ip6_forward_instats_vrf.sh |  2 +
 tools/testing/selftests/net/forwarding/lib.sh | 17 ++++++
 .../testing/selftests/net/forwarding/settings |  1 +
 .../selftests/net/forwarding/tc_actions.sh    |  6 +-
 .../selftests/net/forwarding/tc_flower.sh     |  8 +--
 .../net/forwarding/tc_flower_l2_miss.sh       | 13 ++--
 .../selftests/net/forwarding/tc_tunnel_key.sh |  9 ++-
 13 files changed, 109 insertions(+), 49 deletions(-)
 create mode 100644 tools/testing/selftests/net/forwarding/settings

-- 
2.40.1


