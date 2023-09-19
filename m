Return-Path: <netdev+bounces-35031-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB22A7A6858
	for <lists+netdev@lfdr.de>; Tue, 19 Sep 2023 17:51:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5AF71281372
	for <lists+netdev@lfdr.de>; Tue, 19 Sep 2023 15:51:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CA1E37CBD;
	Tue, 19 Sep 2023 15:50:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D01B0374F4
	for <netdev@vger.kernel.org>; Tue, 19 Sep 2023 15:50:35 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2063.outbound.protection.outlook.com [40.107.220.63])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42FCABC
	for <netdev@vger.kernel.org>; Tue, 19 Sep 2023 08:43:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HXudYjpmzUv3kV93y00rDuFBUW8FJhsS3oD4sFOL3O0ni4fkXHAQX29yGDFFbvvucQlEeP6XSpu2sSbdcfy6bbfZ5H27hPsv86MYWIrRjXuePV3YdhNvGSjOC3gUVUtUNbENv3Os5Bti10x+iONof2aCcY5ETAeqSzePiV9gpLiZll6wgkmDkZ0+ZiiNAU8f0JrFF8nW4gS/quvEslPTkqC/lrJTXUdBd139kvnqfC+laEHJcbzaX8PcIzM0UXRCZGVXzycvqD13VdRj1azYCMztu/i5qNbs6W5RY7u3gDHVbOx/5xRuR/ULWQsb8ppeGTvr5IZyOkDv9opIBKP2Cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S8iMiWtQnFoitouHF85byRbv1CInCc417V8InCvW73Q=;
 b=V+b7WRCwjyKUg/E3+NxgBYNtCIOZ8D0XQYMfHycDft0OASxaAXRMj+RAeVdPKB3783YU1QACi/HJ20lzzETem01OeAeZHgO9MMB4cbsS8H7g4BpAJ8Ize2L+A2jSS7ZRkA+MZ3O10f0pgHMfewz6RNW1BZ5Irw7kFCOX93cVL+T9ewwQDx8Nhve/p5Fwla9E2urKsiGgMuyfz6nRHNh2pkL97NoSSTLdZb5XrXVUfu6SciVDJEKdCLlxkP/i3o2HHoFpak7GMb56HJsTCqxf/H7LHDtYR1WsWIkZqT8ArF2tOHsBfbSagQMzr3GOJTJNFjIQX+YKkQXg95KlSYVQGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S8iMiWtQnFoitouHF85byRbv1CInCc417V8InCvW73Q=;
 b=m7cv/hGKhD8C06R2GKBQZ91yITurqO24M8PYXU1sM0wj6TcOFMJghtCuOIcclR6alcYcaI9vZQwfj3rwRioF+0lCxkqe2sXnhL6SDlcFYn4IzHUzUdQcsTZ7rX0GgwyWiXj6t8UtNq3ab3yWdppRaWziRA+VsZXnaH28JtFM/0yL69Gvv41G4e2YrDjkKWCfI0CEabiQ1lWj+Ykz2V+d3RHY5B2FD1E5fEI46IBEYZFr+ne3uMLVFm2C6e6TR7dH7oT5xIl9aSqCydXEJjihfnvdQQNt6bkAQ0ZMi+1FMOb/xyFoCNrr7k/HvLxX95ZB1NoKbhEYscFXC9+ykTBLng==
Received: from MN2PR20CA0057.namprd20.prod.outlook.com (2603:10b6:208:235::26)
 by LV2PR12MB5800.namprd12.prod.outlook.com (2603:10b6:408:178::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.23; Tue, 19 Sep
 2023 15:43:30 +0000
Received: from BL02EPF0001A0F9.namprd03.prod.outlook.com
 (2603:10b6:208:235:cafe::1) by MN2PR20CA0057.outlook.office365.com
 (2603:10b6:208:235::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.27 via Frontend
 Transport; Tue, 19 Sep 2023 15:43:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL02EPF0001A0F9.mail.protection.outlook.com (10.167.242.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6792.19 via Frontend Transport; Tue, 19 Sep 2023 15:43:29 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 19 Sep
 2023 08:43:18 -0700
Received: from yaviefel.vdiclient.nvidia.com (10.126.231.35) by
 rnnvmail202.nvidia.com (10.129.68.7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Tue, 19 Sep 2023 08:43:15 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>, "Amit
 Cohen" <amcohen@nvidia.com>, <mlxsw@nvidia.com>
Subject: [PATCH net-next v2 0/3] mlxsw: Improve blocks selection for IPv6 multicast forwarding
Date: Tue, 19 Sep 2023 17:42:53 +0200
Message-ID: <cover.1695137616.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.41.0
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
 rnnvmail202.nvidia.com (10.129.68.7)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0F9:EE_|LV2PR12MB5800:EE_
X-MS-Office365-Filtering-Correlation-Id: 29b1fc63-bf06-45cc-1be8-08dbb9272c58
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	f276zc6AwiYliMz0Vv5jf6eL6HfJrpKYp5yplFHfcPe3k+nC80NdohQMTdOBhCqLE0bBTEYdTvOj9922NQzMSsRPnPxObuSB9hnh3/YtPY68wvn4i1gdXeM58IQOmGqz+xDmrvn3triRwPdrr1i8n11aXrMLIzt1aCwmB4Wd372OANPy0uf78FJyqRdpxaEHr1jIrTiIazK9gi8BqCZUv0GHMo/OQlEQJLXZxewdW2Cv6mjQ5ITU0ABlD+rswLKHPOkxQznl1r6YDj7lGC1ukVXczV8EI0yd7CLR8oSlBwqO/yRDeUwS6+On3aMIXqeEFFNk+/rxnR+BI2H18Zeq/r71XzlK2fgMk1b4dj8EleH2Gymgtj4vgjsnqE4u5aXKr/9yxyPdiASgQvmWJX9fsFiEcxqx1Zs4NDVRLFRjSxqRQ+JCE+BUxBXpxOHJVAeaMbTdVRFGQJHDUGzUbnhDCfkDvTyujlY96Gb8G2mvFOwzG/nfMK4q9U95i43p2DpUvdefwMof0mof2EkGJCh7A+ydnHZ2R14t+uk654n+XTjsapacC9qphuXC1EVk35Wbt0Yq2NSYuIOJkYq498oh8azsia7CMH+1a1kbdgqOv+6I0/hed8TJQXHsnu2DOkhNSZ27bw4vL97ejYA+kw5frmbSU9pJEHmaVWbB17krX8XFYLbrZv/93jZQigpztYqcMIN6A6UiPSOUBksvgITkOM3HzrTo6Wghuwnv3ZGw/8Ua7TSFKwo8oy21YnKFKdgS
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(396003)(376002)(39860400002)(346002)(136003)(1800799009)(82310400011)(186009)(451199024)(40470700004)(36840700001)(46966006)(40480700001)(36756003)(86362001)(40460700003)(70206006)(54906003)(478600001)(70586007)(356005)(82740400003)(41300700001)(316002)(8936002)(8676002)(7636003)(2906002)(7696005)(16526019)(47076005)(2616005)(336012)(426003)(83380400001)(6666004)(107886003)(26005)(110136005)(4326008)(36860700001)(5660300002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2023 15:43:29.9860
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 29b1fc63-bf06-45cc-1be8-08dbb9272c58
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A0F9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5800
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Amit Cohen writes:

The driver configures two ACL regions during initialization, these regions
are used for IPv4 and IPv6 multicast forwarding. Entries residing in these
two regions match on the {SIP, DIP, VRID} key elements.

Currently for IPv6 region, 9 key blocks are used. This can be improved by
reducing the amount key blocks needed for the IPv6 region to 8. It is
possible to use key blocks that mix subsets of the VRID element with
subsets of the DIP element.

To make this happen, we have to take in account the algorithm that chooses
which key blocks will be used. It is lazy and not the optimal one as it is
a complex task. It searches the block that contains the most elements that
are required, chooses it, removes the elements that appear in the chosen
block and starts again searching the block that contains the most elements.

To optimize the nubmber of the blocks for IPv6 multicast forwarding, handle
the following:

1. Add support for key blocks that mix subsets of the VRID element with
subsets of the DIP element.

2. Prevent the algorithm from chosing another blocks for VRID.
Currently, we have the block 'ipv4_4' which contains 2 sub-elements of
VRID. With the existing algorithm, this block might be chosen, then 8
blocks must be chosen for SIP and DIP and we will get 9 blocks to match on
{SIP, DIP, VRID}. Therefore, replace this block with a new block 'ipv4_5'
that contains 1 element for VRID, this will not be chosen for IPv6 as VRID
element will be broken to several sub-elements. In this way we can get 8
blocks for IPv6 multicast forwarding.

This improvement was tested and indeed 8 blocks are used instead of 9.

v2:
- Resending without changes.

Amit Cohen (3):
  mlxsw: Add 'ipv4_5' flex key
  mlxsw: spectrum_acl_flex_keys: Add 'ipv4_5b' flex key
  mlxsw: Edit IPv6 key blocks to use one less block for multicast
    forwarding

 .../mellanox/mlxsw/core_acl_flex_keys.c       |  6 ++++--
 .../mellanox/mlxsw/core_acl_flex_keys.h       |  6 ++++--
 .../mellanox/mlxsw/spectrum2_mr_tcam.c        | 20 +++++++++++--------
 .../mellanox/mlxsw/spectrum_acl_flex_keys.c   | 18 +++++++++--------
 4 files changed, 30 insertions(+), 20 deletions(-)

-- 
2.41.0


