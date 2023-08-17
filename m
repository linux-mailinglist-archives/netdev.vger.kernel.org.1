Return-Path: <netdev+bounces-28464-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 307F577F833
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 15:59:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60CF21C21380
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 13:59:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C81914A8B;
	Thu, 17 Aug 2023 13:59:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F9FD1428D
	for <netdev@vger.kernel.org>; Thu, 17 Aug 2023 13:59:18 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2072.outbound.protection.outlook.com [40.107.220.72])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D51B2D5A
	for <netdev@vger.kernel.org>; Thu, 17 Aug 2023 06:59:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PIBJCciP2eaGQSy+AiLDdm2AfFc5m/7SGDn5yN1if7ZEqrCYQDs3A9NoCcVxLZIEUk3UzRJXLcvPGpOjL808g1Tr1bH4jR8Rx645IbLacPSIERHx2xvxAo29jT2kC629h8o1In/cL7DuAU2TcNkm9iA1mzGdZw1LmMX98TV/92EnPvDgfh7bgYkJNXd1pQo6op9RAsjWNc9lGjhZwod0TTAd76Xabvpf6GACz6lOG9TZXvkic+4G5BP8P+jRQ99Vz3HRPnFhb13vRH6gaUCJ/eslULHAIkMXeLLw7G96zg6zcQo+eOsPKKTm1v0Z/gqOIJ0NZIZOC20T7uHpAWCfhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=124aZ+PgR4MiHGR6mcp0Jp3w35nt8rrRMMJnaqQPyH0=;
 b=D26+wYzCKcsFveaR+rLZnhiO+4WQ43HUdweQaJtAsBshF4rcnzlpJtAvJ7/IfE4iZpshA+6z1yi51rtux5e6SP1KasNa9U3+Lgn2l88UjrOsVVlzumBbd7F6GGXQMxzvfM/mJdWbooBv0uC+nb70y767XlxQeQ5dV7+EJVKD5HF5CdVNsmqHrY+ninDy+NyxYiLLF+MIjoi4Gh6wOzYvuHJ8Bv1UqgkIfh6je2hRo7luEfwddR/RREn6N0enEN3K8PPxAsxmvtES07PvAZ4huqMETFKVZHYFPfdD6iI77sHWqccFov4pR53+vco/mJL+ryW4XdAJZ2fzFrDRnrBjlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=124aZ+PgR4MiHGR6mcp0Jp3w35nt8rrRMMJnaqQPyH0=;
 b=ptgzrwPKJeAPeBpyWzUQ64svhXeSh6QTvxBn8sLuAJXSHEX0lLojBZ2dRIxUGSlv6Vbb2IXfaBsywBkwJ58c/YheMkP2146P/EEss7OrI+5SllpVGAiGhacuUcVaPRqcle/Tc+mV1kNjPct3TVs5oKlUdzPQmoLFK25GiqLqoMz/BKZ3g84rYLQpV6OsqHTu8wp/6GNUZz4XFrpybxbxeu8SUMxSdGxjGODTAsxFCMKonAZ2Qb5WhIxy7YtvudXcXqrhfUYT/tkQa3o3Lhw3Nl9wUrm6H4yJm6BQQ6pAKnPyTSpY12x2hVYNtq3Gz9a8a0M+cAnOmTSIgdQOMyPPXg==
Received: from MW4P220CA0006.NAMP220.PROD.OUTLOOK.COM (2603:10b6:303:115::11)
 by CY8PR12MB7364.namprd12.prod.outlook.com (2603:10b6:930:50::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.31; Thu, 17 Aug
 2023 13:59:15 +0000
Received: from MWH0EPF000971E9.namprd02.prod.outlook.com
 (2603:10b6:303:115:cafe::74) by MW4P220CA0006.outlook.office365.com
 (2603:10b6:303:115::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.17 via Frontend
 Transport; Thu, 17 Aug 2023 13:59:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MWH0EPF000971E9.mail.protection.outlook.com (10.167.243.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6699.14 via Frontend Transport; Thu, 17 Aug 2023 13:59:14 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Thu, 17 Aug 2023
 06:59:03 -0700
Received: from localhost.localdomain (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Thu, 17 Aug
 2023 06:59:00 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>, "Amit
 Cohen" <amcohen@nvidia.com>, Danielle Ratson <danieller@nvidia.com>,
	<mlxsw@nvidia.com>
Subject: [PATCH net 0/4] mlxsw: Fixes for Spectrum-4
Date: Thu, 17 Aug 2023 15:58:21 +0200
Message-ID: <cover.1692268427.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.37]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E9:EE_|CY8PR12MB7364:EE_
X-MS-Office365-Filtering-Correlation-Id: faf4978b-fa44-4a95-7b97-08db9f2a2401
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	RObv57QH4vgOzwZ44+tHEIkEL2e8YwOTKexW3CWeAsn2WQU9NuyzZKoFuoMUCPLi9l5zkdQaKPWGaC0ErqN1Y7CrZWUMBF+0TuhgUNOchccuF/0nGorULlXVrvK3Xtc/zAN6aHsfmlrytdBs5Nfcf+pnI1YByWh5ftVOCt0g157vL3zxpmi+j3FuOqvkXqN39aDWB9IETnzWK2Aig7jHtXKu4jAhB10NF3yO8wOw/oCarqQ8YPVWsQn0N8Kfyx40QoyGnMoqfVq8O8qa7iXYlzBEM1OMbBjHbufKLbS+uLbOBPOMaHkuSPA0ooMEE1najxMeHGyYMGmKmIsMzKSpOTH1yKu77YnrlcdBVymztft5h2tzDT/fo8phYPi001uv8BhW3HsmvFArXXMOi8ZF6eyJnCg7AyhSzNgR+LcDfoc350diBDykZYX8JOeP/7oZZeq3mUxGXZ961crEGwKUUi0vaiPFYa430IDhg/BfQz+tu0v6TF3HwKmzaMbxYjpR7pa6emkWLLkr4eeSamJen34Kn0798drqFHxP6wClmYShXpO3uutshSX5kF2c+Uu79W+0NNDd5aPSI7gdcmEBlWT0B1VDgH+71CdQ6PAWR0/DtbVp1KZXjJJKpaS9kYXK25WUKnO7AjsKMjxAV/PqzNHzBcJWLJIkiewh1oXtsexjMZA2F5WN9Oh4DdFvaZ7zCOppGOD1sQdAwv+lCo/95LlnVBaQHBMmGheFLOZQWcXe2yeCXC/ZG3Be71YSYV0D
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(376002)(136003)(346002)(39860400002)(396003)(186009)(451199024)(82310400011)(1800799009)(36840700001)(40470700004)(46966006)(36756003)(86362001)(83380400001)(40460700003)(40480700001)(8936002)(5660300002)(8676002)(4326008)(4744005)(2906002)(41300700001)(26005)(336012)(16526019)(6666004)(2616005)(107886003)(47076005)(66574015)(36860700001)(426003)(478600001)(7636003)(82740400003)(356005)(54906003)(316002)(70206006)(110136005)(70586007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2023 13:59:14.3639
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: faf4978b-fa44-4a95-7b97-08db9f2a2401
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000971E9.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7364
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

This patchset contains an assortment of fixes for mlxsw Spectrum-4 support.

Amit Cohen (1):
  mlxsw: Fix the size of 'VIRT_ROUTER_MSB'

Danielle Ratson (1):
  mlxsw: pci: Set time stamp fields also when its type is MIRROR_UTC

Ido Schimmel (2):
  mlxsw: reg: Fix SSPR register layout
  selftests: mlxsw: Fix test failure on Spectrum-4

 .../ethernet/mellanox/mlxsw/core_acl_flex_keys.c |  4 ++--
 drivers/net/ethernet/mellanox/mlxsw/pci.c        |  8 ++++++--
 drivers/net/ethernet/mellanox/mlxsw/reg.h        |  9 ---------
 .../ethernet/mellanox/mlxsw/spectrum2_mr_tcam.c  |  2 +-
 .../mellanox/mlxsw/spectrum_acl_flex_keys.c      |  4 ++--
 .../selftests/drivers/net/mlxsw/sharedbuffer.sh  | 16 ++++++----------
 6 files changed, 17 insertions(+), 26 deletions(-)

-- 
2.41.0


