Return-Path: <netdev+bounces-13079-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B1B9B73A1DF
	for <lists+netdev@lfdr.de>; Thu, 22 Jun 2023 15:33:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 115D728197E
	for <lists+netdev@lfdr.de>; Thu, 22 Jun 2023 13:33:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E8EB1ED40;
	Thu, 22 Jun 2023 13:33:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AEB01E513
	for <netdev@vger.kernel.org>; Thu, 22 Jun 2023 13:33:38 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2059.outbound.protection.outlook.com [40.107.243.59])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73F8D1996
	for <netdev@vger.kernel.org>; Thu, 22 Jun 2023 06:33:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HMMFbyrv57rjnuxFtjW3xV3XzZSb2UC5ag40szY6N4YjE+d1bZt7UKJ1FIDOjmSTHSqs7vFFs/8AYvl7A8frvZ6tZL9WPUkMQmM3/ntLI5YvOJ+CaS6j15FxJmT6MesHO/how3wHk/FEIKNEOb/ZQcdwNAB9gUkrLUlYfNvLGhUdCR5VrYOp7TlIx0NVwKm6BkavQws/w00/PkyynPEaskBNMSpdLav98E6Nqf68/40442fRUtb2D6+OgC42nHUnejuXOBLsFv2bhio4nQyhO6/+XZPaON4+4oy91xwhnU6jCjUnOgiuRxe7abfOv3HG5SdVrlTeesLSZbvDBqyyow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TVydfxkUduvOAPm5/GIqte67R3oQrnC9jvq8mOUyZRg=;
 b=ELsx7B731EoWjBpm+sj2YR/zF0q3qXmWRTelh+yEcVvYsits51q3+IU2yq5299/pa3KjlQqL4CL9T+RuZJYyKhCZaAaNmqDdHrDA3L+X9C4e7QdewwJ1MvtucTv7RpbkWyqXwUVUwMh81T3QmpGMoQKG2omfN5hR3AurP+1Eb998hZMgCgBu4Mrs9sEMS+2vtO+UYD2XNqG0myO9gSQAuw0eGF+LT0LWfME6ln/qVNFZumruV/xCmxnL6kNoA+xaJ4ZatrI4Zzi/8X1ay8hhClcOUVSE4aUBlYK+9n3mmUkNeEZJP+WMf1c00dZFR94t/mftNqWawlEernl4lDyNuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TVydfxkUduvOAPm5/GIqte67R3oQrnC9jvq8mOUyZRg=;
 b=CuLV+z1NdnxPvX8KmN5HutP7dg9wXEZKuOloCqacd9dbul8feKVsvyCAeLvZYda0GqZYvQ+clKxOwCyfqkwpbZu6J0nxXvMxMgQdRsafSQBxik8egnWv+WY2Jttc+2rfbca5M+49/WFwVGXi9zRwWSdh5IqX/ckhcio+7aQKsU2FXXTJgdLxI+wZkhkI/7/sWO2mM0onpi08061vcP1vQX4eXRy18b+6DzyOmqgiv3MtawucqyVr4CCwxf2F/3xo5R3hmcuGkjhFPDDEObQYcXx+7e5MRB9h1JwNxgCyelfnzJHxeUbEVpQOD2u3Rp6iYqjmV8c7Lyxp8DiqNMbfig==
Received: from DM6PR04CA0012.namprd04.prod.outlook.com (2603:10b6:5:334::17)
 by CH3PR12MB9252.namprd12.prod.outlook.com (2603:10b6:610:1ba::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Thu, 22 Jun
 2023 13:33:35 +0000
Received: from CY4PEPF0000EE3E.namprd03.prod.outlook.com
 (2603:10b6:5:334:cafe::50) by DM6PR04CA0012.outlook.office365.com
 (2603:10b6:5:334::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24 via Frontend
 Transport; Thu, 22 Jun 2023 13:33:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000EE3E.mail.protection.outlook.com (10.167.242.18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6521.19 via Frontend Transport; Thu, 22 Jun 2023 13:33:35 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Thu, 22 Jun 2023
 06:33:28 -0700
Received: from localhost.localdomain (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Thu, 22 Jun
 2023 06:33:26 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>,
	Danielle Ratson <danieller@nvidia.com>, <mlxsw@nvidia.com>
Subject: [PATCH net-next 0/8] mlxsw: Maintain candidate RIFs
Date: Thu, 22 Jun 2023 15:33:01 +0200
Message-ID: <cover.1687438411.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.40.1
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
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3E:EE_|CH3PR12MB9252:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d519eda-0641-499f-b2e4-08db73254766
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	GwcBwOKsE+ImzqscG3uzjk+N7ftAkiKOCNqiwX2pP1LNPLOUhxXwqM7bFuIA3X/hJJJcsOTFZ96pvfo3XW/3SD5ssUbB1ggBXke1FEJwsaFebLBxvv+oAfmb7znX1pGpLN8woGZZGtqmHgui9BJTgdhnOEqqn+nwAslVVANffXKrkNsIyFjzjZA28etFBnxHXbA+oB0fd8Lfh9XtUgp39wZTOyqTqq6eFciw3g+d/jXwcuP2qJ5OR/mVBn5gzLqipPZgwdrVySDqy5IOEnLlZS7+0qH2qDmpV43r9rVA28U1+AfE0sPigL7PY6plhv1nD/M5br6H5oLEhmQlmBBQfajbt4bQZnXw1CUG3nVb0sxzceI8du/GIbYSg0c0m2AttmPPnDjBU9U6r6yCa0v8OJSBirHhkFss5YD13hlvroAQ6hEeuoepPfIr1RP7z3/kxXynzw2p7kX+XnXhUbb3ZaPcXY31ELHySEa2yNiQ4kba8RIwsL+PP2oXHHjcKlATgSQxqVVaeGIvpeGVQoeqAFjZjXzOElFZ9y3VqLyBac9e22Z/AeS1WA8Yh9wuCUMgkYH24ju3mPzNC6fCcvOVoY2P7THEzVJJT/hhwuMoJB9p1tlptUupd6ebyfThirEgWUWRXkeeC13P6lje8am+mR09puu1TmT7ZRBhxbu3UkHVemjlpUfNmxMElDkTVJHskpK/JCd2THAe/Ntze/8KQSK8aaNUacPNptokLMzs3DHv4m5u17DhhKJ8UN0zMaDW
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(136003)(39860400002)(346002)(376002)(396003)(451199021)(40470700004)(36840700001)(46966006)(54906003)(2616005)(86362001)(110136005)(107886003)(40480700001)(478600001)(16526019)(186003)(6666004)(66899021)(41300700001)(70206006)(70586007)(316002)(66574015)(47076005)(83380400001)(26005)(82310400005)(4326008)(426003)(336012)(8936002)(5660300002)(8676002)(36756003)(36860700001)(40460700003)(2906002)(82740400003)(7636003)(356005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2023 13:33:35.0547
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d519eda-0641-499f-b2e4-08db73254766
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE3E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9252
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

The mlxsw driver currently makes the assumption that the user applies
configuration in a bottom-up manner. Thus netdevices need to be added to
the bridge before IP addresses are configured on that bridge or SVI added
on top of it. Enslaving a netdevice to another netdevice that already has
uppers is in fact forbidden by mlxsw for this reason. Despite this safety,
it is rather easy to get into situations where the offloaded configuration
is just plain wrong.

As an example, take a front panel port, configure an IP address: it gets a
RIF. Now enslave the port to the bridge, and the RIF is gone. Remove the
port from the bridge again, but the RIF never comes back. There is a number
of similar situations, where changing the configuration there and back
utterly breaks the offload.

The situation is going to be made better by implementing a range of replays
and post-hoc offloads.

This patch set lays the ground for replay of next hops. The particular
issue that it deals with is that currently, driver-specific bookkeeping for
next hops is hooked off RIF objects, which come and go across the lifetime
of a netdevice. We would rather keep these objects at an entity that
mirrors the lifetime of the netdevice itself. That way they are at hand and
can be offloaded when a RIF is eventually created.

To that end, with this patchset, mlxsw keeps a hash table of CRIFs:
candidate RIFs, persistent handles for netdevices that mlxsw deems
potentially interesting. The lifetime of a CRIF matches that of the
underlying netdevice, and thus a RIF can always assume a CRIF exists. A
CRIF is where next hops are kept, and when RIF is created, these next hops
can be easily offloaded. (Previously only the next hops created after the
RIF was created were offloaded.)

- Patches #1 and #2 are minor adjustments.
- In patches #3 and #4, add CRIF bookkeeping.
- In patch #5, link CRIFs to RIFs such that given a netdevice-backed RIF,
  the corresponding CRIF is easy to look up.
- Patch #6 is a clean-up allowed by the previous patches
- Patches #7 and #8 move next hop tracking to CRIFs

No observable effects are intended as of yet. This will be useful once
there is support for RIF creation for netdevices that become mlxsw uppers,
which will come in following patch sets.

Petr Machata (8):
  mlxsw: spectrum_router: Add extack argument to mlxsw_sp_lb_rif_init()
  mlxsw: spectrum_router: Use mlxsw_sp_ul_rif_get() to get main VRF LB
    RIF
  mlxsw: spectrum_router: Maintain a hash table of CRIFs
  mlxsw: spectrum_router: Maintain CRIF for fallback loopback RIF
  mlxsw: spectrum_router: Link CRIFs to RIFs
  mlxsw: spectrum_router: Use router.lb_crif instead of .lb_rif_index
  mlxsw: spectrum_router: Split nexthop finalization to two stages
  mlxsw: spectrum_router: Track next hops at CRIFs

 .../ethernet/mellanox/mlxsw/spectrum_router.c | 402 ++++++++++++++----
 .../ethernet/mellanox/mlxsw/spectrum_router.h |   3 +-
 2 files changed, 326 insertions(+), 79 deletions(-)

-- 
2.40.1


