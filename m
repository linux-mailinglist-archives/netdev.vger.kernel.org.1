Return-Path: <netdev+bounces-21973-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 60730765826
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 18:00:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 79A4B1C2102D
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 16:00:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1621B18023;
	Thu, 27 Jul 2023 16:00:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF0721FA8
	for <netdev@vger.kernel.org>; Thu, 27 Jul 2023 16:00:11 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2067.outbound.protection.outlook.com [40.107.223.67])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D3DDBC
	for <netdev@vger.kernel.org>; Thu, 27 Jul 2023 09:00:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GF7p4YgdMPjSYB30U+6tHphnHPYJuQwObHZp1Iei6TUnNVnW60op5BCj8u5492Ms+jiZjOUULVQh/ueWoYy/aGbcP4tNiRTYChjP0T1cCHNp6qPGRRJe9KiZT6THr8ac7dtOANODaFfxsyDf2ukRj8SUr+mkKJ2R+w5aABFJVnX1kOYfaFxmSTqRDbqJu4E4YukzxcprSFjHcXoc3an0we+465wUz55mgYyCOj11fDRgbN8QB9YPdvuQcLwEaS3ShWf8mfLd7rQW1oqGVyXh78xCGBSbePifwbSkVWDCHKkGTCBKFhJW1DXYReNVFgvHyLTu+158WTg0jiEFmgDbEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A0q1qnidWqSOmLZRBC6pt9jjgZCxww7pOO6gWk+Ekfs=;
 b=e8VGH6KzoRe4flB1FHbHiKQX1eB4cpKU21hMCWjEK0euE0uxLsdBUnyE63/qSqk5T6OmACX7/1KPieKT53a/oiJlov6s+uKgEUplvD/lntZSqnUgc1wY8uaXMY4040pxjnMKhx4s9Ol54OPTvbziDXbjDhQG7GW+kFlhoAWK0LKfbXXyy3Z/Ys0y6o+XnKHeQe323U1+ChnnYukuXcpTBVDmqXxO+x8tJpUgEF0mhjd9D5obY6PAgUAe9O9uVg3NEs/uNIjqe+0Gww7mo6enn40UMz6g/m+4VtGzxpqx/hlvEZIXBrJNTe63zx3E/OtjsLLOZ7weg+O7JCXt9Oh1ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A0q1qnidWqSOmLZRBC6pt9jjgZCxww7pOO6gWk+Ekfs=;
 b=D4tVfuMjteOQq+pozAwUkuIQKnXynbrqpqIvpbSrGKXEV5pU9Z7V/8Ayj2Udsr385utx75Nu2EIyMayqrZ7/lPg1vM82W2PgmsDBaqfLwjuOFTmNwcHkdGv4mOeSKNLO/0AyJ9TGTcWTz+obM7TO3nEzUsQCJgbp5pARs0X5AFCyh1uYg+PH3OcHxLBGiEmWiaIbLlBjwl3hLBe6u0qndVRNkwenjlbOmYgDc3wqYlMqC3WR5BIgRlxpd1KBYWGVtRAllhfHD3dlHtm1uzfgwtL/NYPwsBoP5Ma6IEaSeLFHoHxUdE15XFJuOMjQu/Gq3ytUWHeFh7HUWnGNmrXgHQ==
Received: from BN9PR03CA0541.namprd03.prod.outlook.com (2603:10b6:408:138::6)
 by BL1PR12MB5270.namprd12.prod.outlook.com (2603:10b6:208:31e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Thu, 27 Jul
 2023 16:00:08 +0000
Received: from BN8NAM11FT020.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:138:cafe::44) by BN9PR03CA0541.outlook.office365.com
 (2603:10b6:408:138::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29 via Frontend
 Transport; Thu, 27 Jul 2023 16:00:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN8NAM11FT020.mail.protection.outlook.com (10.13.176.223) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6631.29 via Frontend Transport; Thu, 27 Jul 2023 16:00:07 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Thu, 27 Jul 2023
 08:59:59 -0700
Received: from yaviefel.vdiclient.nvidia.com (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Thu, 27 Jul 2023 08:59:57 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>,
	<mlxsw@nvidia.com>
Subject: [PATCH net-next 0/7] mlxsw: Avoid non-tracker helpers when holding and putting netdevices
Date: Thu, 27 Jul 2023 17:59:18 +0200
Message-ID: <cover.1690471774.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.41.0
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
X-MS-TrafficTypeDiagnostic: BN8NAM11FT020:EE_|BL1PR12MB5270:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ad23384-85e3-42cf-d9e1-08db8eba8c8b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	CmplNfAwlTeYy9UwqiomOBBCUndelzV/SWkVmM3LV/pwEc8bzqd9QtBUOxjim167ybMD2/9gO1llBEirCM+oJ7COUXCP07E76FF7T9+8P2Bxq9Zc8QLYeEvo/j9bIlaV7bH2rTolLwI+zogb/uy3I0nG18ohYO3O6ADj8KT2nNRBDntkmSCOhlx4aSLD+euFeumoEbDoUVQ2vWlkxSuv6l2TmcPOpC2gnQ1YIEChQYyXLpuPtNsU3LKfHqS/tDZC6rMUMrvAwmhC+LQP3HC8rR0qWlz3nigPOTJbM8RPNmo1iV7uGo9S2metMUJ1Dd0B4sl5iJ1LUrYeTr0E8NMWmvalafsTZgEQxO37Hzs67QgTnbeNteL3huI6DMjVfUHQaJH5ty5c5S2C9IBvqpJbP3GDOOupNbY6pl4wrHpC3CMk1GHiXzsRgEDtQB6/07AiGrV9qVv13okIdFIrtsKU5nzQdgf/lgWk/g5hyviJT46esGxADdPn3rc4lOs/f0NO6FU/KXN/seq/ME4JTR8UqPT/KlAiCHTIWgKFkZBRu2rwqXdkGR59AYxUosvEZZTBnAdXyXfoUaSWmLtt1M2Dr0a9xkU7EVksdbUHl4XgXFIZd0Q8s92CPS5Pjc/AI2NLm8ufUxyWYMTIjfn6QHV/Us6A2lAWTwFrcfnApsfrK7Gse7yVEsKPEbsvQYlcw0CZyr+8ZuonjUMqEVii+rg7JpkG0CdO3MFRDl0pTZEefp4gf7laN+9yTGGPGeTG/aAxxJRYcKugWV5B8HXt4VQyeS9SiL7RpkgTDsmn0fCNbCw=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(346002)(136003)(39860400002)(451199021)(82310400008)(46966006)(40470700004)(36840700001)(6666004)(7696005)(356005)(478600001)(82740400003)(47076005)(83380400001)(26005)(966005)(107886003)(4326008)(7636003)(110136005)(54906003)(70206006)(70586007)(66574015)(186003)(16526019)(2616005)(336012)(36860700001)(426003)(8676002)(8936002)(40460700003)(5660300002)(2906002)(316002)(41300700001)(86362001)(40480700001)(36756003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2023 16:00:07.4062
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ad23384-85e3-42cf-d9e1-08db8eba8c8b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN8NAM11FT020.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5270
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Using the tracking helpers, netdev_hold() and netdev_put(), makes it easier
to debug netdevice refcount imbalances when CONFIG_NET_DEV_REFCNT_TRACKER
is enabled. For example, the following traceback shows the callpath to the
point of an outstanding hold that was never put:

    unregister_netdevice: waiting for swp3 to become free. Usage count = 6
    ref_tracker: eth%d@ffff888123c9a580 has 1/5 users at
	mlxsw_sp_switchdev_event+0x6bd/0xcc0 [mlxsw_spectrum]
	notifier_call_chain+0xbf/0x3b0
	atomic_notifier_call_chain+0x78/0x200
	br_switchdev_fdb_notify+0x25f/0x2c0 [bridge]
	fdb_notify+0x16a/0x1a0 [bridge]
	[...]

In this patchset, get rid of all non-ref-tracking helpers in mlxsw.

- Patch #1 drops two functions that are not used anymore, but contain
  dev_hold() / dev_put() calls.

- Patch #2 avoids taking a reference in one function which is called
  under RTNL.

- The remaining patches convert individual hold/put sites one by one
  from trackerless to tracker-enabled.

Suggested-by: Paolo Abeni <pabeni@redhat.com>
Link: https://lore.kernel.org/netdev/4c056da27c19d95ffeaba5acf1427ecadfc3f94c.camel@redhat.com/

Petr Machata (7):
  mlxsw: spectrum: Drop unused functions
    mlxsw_sp_port_lower_dev_hold/_put()
  mlxsw: spectrum_nve: Do not take reference when looking up netdevice
  mlxsw: spectrum_switchdev: Use tracker helpers to hold & put
    netdevices
  mlxsw: spectrum_router: FIB: Use tracker helpers to hold & put
    netdevices
  mlxsw: spectrum_router: hw_stats: Use tracker helpers to hold & put
    netdevices
  mlxsw: spectrum_router: RIF: Use tracker helpers to hold & put
    netdevices
  mlxsw: spectrum_router: IPv6 events: Use tracker helpers to hold & put
    netdevices

 .../net/ethernet/mellanox/mlxsw/spectrum.c    | 17 -------------
 .../net/ethernet/mellanox/mlxsw/spectrum.h    |  2 --
 .../ethernet/mellanox/mlxsw/spectrum_nve.c    |  7 +++---
 .../ethernet/mellanox/mlxsw/spectrum_router.c | 25 +++++++++++--------
 .../mellanox/mlxsw/spectrum_switchdev.c       |  9 ++++---
 5 files changed, 24 insertions(+), 36 deletions(-)

-- 
2.41.0


