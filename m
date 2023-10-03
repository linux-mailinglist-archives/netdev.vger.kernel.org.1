Return-Path: <netdev+bounces-37653-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 143DF7B67CD
	for <lists+netdev@lfdr.de>; Tue,  3 Oct 2023 13:26:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id 275761C208C1
	for <lists+netdev@lfdr.de>; Tue,  3 Oct 2023 11:26:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F3B82135A;
	Tue,  3 Oct 2023 11:26:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97BAB1A286
	for <netdev@vger.kernel.org>; Tue,  3 Oct 2023 11:26:08 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2054.outbound.protection.outlook.com [40.107.223.54])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E1B89E
	for <netdev@vger.kernel.org>; Tue,  3 Oct 2023 04:26:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZNK4vNJdA+DXXEJ8D5kKEL7DqiEdMmjkdripUW5rj3rIbu3Yz6Dq0ko1HgUgSQJ62cdgCrIkme3cWGgW5SfAKq4AXVJ8bCq4GuZyxEZBwTvWn3+84+TfZTLFerrRWcSBnF7fE5KJ6Yf8TEdu2MfHZ1Fb4c8Wmhf7USFbQAa1xAHJgS8DH1bhqAE5C9qRH+9FFIkh+p9d9iRvBzAFOFkG6SO4BG/8EzJ6ZElo89+lMBrdegxh2bxvz8CL9CiDV5bqxmTFxtlsfOiWO5HRMnjUdOK8tXZlmvh9EM3VPNckJxNFKo8ILvjHHRBEfE9UP0LEfr5iv0Y6X7nG4Han+qowXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xy0O4OxLNOybDydvgcltP/tYLHf4z/SLgVMRN0Q9jjI=;
 b=UZnGf7r72/bMsQsiKiVQwGsCAtU4/xLnZgwt09+xFEIL5kbxTYi0RaiS6D221+1cHyoICJHKO/6Z6mMniR0M2JP0LgwIj4Nt0pYsZU01cISYqY385D9pwQ5AgF19Thqdocf38L6+PJhFZECyjdMwfgKaevQwu8SmjqlDkGSNhubbW9MJYh5mLT7QsjSWW6aKY6Eq2WGapeadmix7/D+dlkA9u0eYCgdRyLp+h2AasqO5tH6Bd3vKjfM2s+rUajBmy/40GPgzN8BgVRs+dVbCV/CIGmmkc36MdfCXoPcbueGnFAjfPkDzfGveE2xhZUSn72KBz1TL7qWUBQeUPim3NA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xy0O4OxLNOybDydvgcltP/tYLHf4z/SLgVMRN0Q9jjI=;
 b=SNyTO30K1ZJjjqzo7QLETeUg0qeSFYL/CZXR9B+y9yxDMxWIo6UAbb6QUP0BHM3PeXYAOlXyj0zlA/ecQsGlty2zV6aNmUhHg9qHbWeoO8jqbkjZDu3pHVeq5uqU+j1qwIhYPjvBUZCoH7XbcnDmo6hnORvB9uqNyAOxBT2OJbzpBQiFPgsYN9Ss0PI7HW2IB6tovcTOBz2+GU2u3f48g6SGPamonlasMDEq0i5rOY1VXObqr+/k/ULA1D9joDqvydgwD8+QbTm8Sto0oV7wLv51249sdrBz88NkqDRGA7KsIgvcg2cZo6S8w8p6YXKFTou2/Pb7ZITiJBgG8VDNdQ==
Received: from SN4PR0501CA0005.namprd05.prod.outlook.com
 (2603:10b6:803:40::18) by BL1PR12MB5945.namprd12.prod.outlook.com
 (2603:10b6:208:398::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.34; Tue, 3 Oct
 2023 11:26:00 +0000
Received: from SA2PEPF00001508.namprd04.prod.outlook.com
 (2603:10b6:803:40:cafe::6d) by SN4PR0501CA0005.outlook.office365.com
 (2603:10b6:803:40::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.25 via Frontend
 Transport; Tue, 3 Oct 2023 11:26:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SA2PEPF00001508.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.14 via Frontend Transport; Tue, 3 Oct 2023 11:26:00 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 3 Oct 2023
 04:25:46 -0700
Received: from yaviefel.vdiclient.nvidia.com (10.126.231.35) by
 rnnvmail202.nvidia.com (10.129.68.7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Tue, 3 Oct 2023 04:25:43 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>, "Amit
 Cohen" <amcohen@nvidia.com>, <mlxsw@nvidia.com>
Subject: [PATCH net-next 0/5] mlxsw: Control the order of blocks in ACL region
Date: Tue, 3 Oct 2023 13:25:25 +0200
Message-ID: <cover.1696330098.git.petrm@nvidia.com>
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
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail202.nvidia.com (10.129.68.7)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001508:EE_|BL1PR12MB5945:EE_
X-MS-Office365-Filtering-Correlation-Id: c20d189e-1bec-4cb3-97da-08dbc4038532
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	LUz0DaV7nnY3/MpZDhsuN/FFJpKqFnOq12Jp2xp9FJ3lNWcdlQvGGRybc980OpX9KFPupOs2vFsCMXKEX+l7h3J2+bYszAZFs2GmKDrrXrL83w/6vITEothTNqNB8I50V6AQbSWcs1HfGf7SN3SNEu8xUqHF2pZAtpkaMGecDLSaMc73ghRnvl4V2D83fBG+n5wDsBgRq4icdRzHDYQvrJnACpjuO+MxvGlk/m1Jh/95/OZ7xwTw9B5swKpmxa9ozmbVO0jBIu/5VTZYdGCHu+eg5vcpVfaTdFmmujIczcEiz0i9u+dZlKSTu8aGPrZjSk6D+UBkNCyPeaSqOrNgvp9AZMw9qEJ788+/oq+YltEW5Yezb91BDud4zTGfEKz5ICh4pS3gbD6D4tuezHMwsdcmRGwfB489ZkeFhKMa2C+yai5saBd+OowoKxLIwN8mg3SoncD0G5Dm+4Q/c7sLxp5zMMU7eTQNHnzRRLYaj993dnDjjXypsSBi5cwYDw8GzbUYMlj/Apw29anqtP/GSNgHnUBOpAVf6dFcxoxO+A4D7h0EfXQUoB47d6b4aW7rLsCXi2ToyqWSWk2HCcfvHIecUf2oSbJSSRbMIrlkV5FloM84AgkrY/cadZv7BWhx6Mj2I+JRPmpq6GpYK9rXj1iNh6OFO+fxB3dEUa45V5m7GyKxP9nSACcPXFWOYSisGExxTb2JAvTDLpipGzyFMauVcoMUZ8y3rYJd9XOqHt09SdDo6YugWI8og04RxYl/
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(396003)(376002)(136003)(39860400002)(346002)(230922051799003)(451199024)(64100799003)(186009)(82310400011)(1800799009)(40470700004)(46966006)(36840700001)(16526019)(40480700001)(36756003)(2616005)(107886003)(7696005)(6666004)(356005)(7636003)(82740400003)(40460700003)(26005)(426003)(336012)(83380400001)(2906002)(5660300002)(36860700001)(478600001)(41300700001)(316002)(110136005)(54906003)(70586007)(70206006)(4326008)(8676002)(8936002)(47076005)(86362001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2023 11:26:00.0282
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c20d189e-1bec-4cb3-97da-08dbc4038532
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00001508.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5945
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Amit Cohen writes:

For 12 key blocks in the A-TCAM, rules are split into two records, which
constitute two lookups. The two records are linked using a
"large entry key ID".

Due to a Spectrum-4 hardware issue, KVD entries that correspond to key
blocks 0 to 5 of 12 key blocks will be placed in the same KVD pipe if they
only differ in their "large entry key ID", as it is ignored. This results
in a reduced scale, we can insert less than 20k filters and get an error:

    $ tc -b flower.batch
    RTNETLINK answers: Input/output error
    We have an error talking to the kernel

To reduce the probability of this issue, we can place key blocks with
high entropy in blocks 0 to 5. The idea is to place blocks that are often
changed in blocks 0 to 5, for example, key blocks that match on IPv4
addresses or the LSBs of IPv6 addresses. Such placement will reduce the
probability of these blocks to be same.

Mark several blocks with 'high_entropy' flag and place them in blocks 0
to 5. Note that the list of the blocks is just a suggestion, I will verify
it with architects.

Currently, there is a one loop that chooses which blocks should be used
for a given list of elements and fills the blocks - when a block is
chosen, it fills it in the region. To be able to control the order of
the blocks, separate between searching blocks and filling them. Several
pre-changes are required.

Patch set overview:
Patch #1 marks several blocks with 'high_entropy' flag.
Patches #2-#4 prepare the code for filling blocks at the end of the search.
Patch #5 changes the loop to just choose the blocks and fill the blocks at
the end.

Amit Cohen (5):
  mlxsw: Mark high entropy key blocks
  mlxsw: core_acl_flex_keys: Add a bitmap to save which blocks are
    chosen
  mlxsw: core_acl_flex_keys: Save chosen elements per block
  mlxsw: core_acl_flex_keys: Save chosen elements in all blocks per
    search
  mlxsw: core_acl_flex_keys: Fill blocks with high entropy first

 .../mellanox/mlxsw/core_acl_flex_keys.c       | 64 +++++++++++++++++--
 .../mellanox/mlxsw/core_acl_flex_keys.h       |  9 +++
 .../mellanox/mlxsw/spectrum_acl_flex_keys.c   | 12 ++--
 3 files changed, 72 insertions(+), 13 deletions(-)

-- 
2.41.0


