Return-Path: <netdev+bounces-28466-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDC8877F837
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 16:00:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C300F1C20BE5
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 14:00:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0DDB14AB3;
	Thu, 17 Aug 2023 13:59:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF80514A8B
	for <netdev@vger.kernel.org>; Thu, 17 Aug 2023 13:59:22 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2046.outbound.protection.outlook.com [40.107.244.46])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D1432D62
	for <netdev@vger.kernel.org>; Thu, 17 Aug 2023 06:59:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I08EoVJtXoeAxFQJwdvBWKXqnYqdDes9ehtwhqekeBGkIJcttlX5OtRLVu8skB6nZTi4LHmzwPmCTXmZtng9AmJgtm+W6WSKaAdsQDACi9Flxgs1FaRZag6aYB36d0+xqPyxWcKdD6Uy4Qd+YuDYBNDeIqoCOaCXkahxJQthsQPAbkJ/+OnV6421EpUUhMqDpcLaRMy2aUcZDQIOIlJuuEtk715TCdbn6qrdBjl4/P48h9Ekic5MMAWCgoTX0p/1hBF4vL11xDY+3lQPvP5uPg8PKlnlLz2Oufz1jvOt/xffibv3FJu1a1qC/fkwbgfmqoz2JtvS0PhQGU/S4onv+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QgbbIdZNBeaLPfwecBTD2NS8bXJB9/V32f9CNBvXgE8=;
 b=Xq74DuowCB1HSdNGb3/Qz+p7rtnuglwOd8Lyv7z+J1E1r6+bIxe0Z6h7EVidCmfnoy1mEo5RjTtycFQGzfJF2PXW6/Nl6Hb+b35J+HcasyyB0phDx8kFr/5pE+cFrrgeFY9Y46PXeUk/rV+HFcj8mK1FzCvr/JkushDIJ0ZcGXeamU1P1wwT2TrcMOxS1zGvpshpsG9D6yObJY3sObSO+tiD7PrnmNAItQaqyHC4Z/23WfEhMrB4ZMprmdfJty4qK5Qp6ldH9RDtciIk7PYrwNev4W/RxNvXZ31vmeHpNphcgdmVG6McGCift1HqTk9vwB+AvmIln/Su6SDesLCmlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QgbbIdZNBeaLPfwecBTD2NS8bXJB9/V32f9CNBvXgE8=;
 b=VLuhOzxcElhzUamNy7hn4KmiyXbsdSDzDmYPVAaIi52LfMeb4976Zi8CEqZ+c+FKwBNq5ASAVrvk/uR4MkdNL2K3nD/0OE+goZEBWWc17YZl9ymDqSGTR4grheoK/oN18rlPSXSMlkOdwARLeBk+xgqzUmiuFJsxMyeOgGcfutHTLBqn58v6kXM2fvEXrbZZNwJm6JT4+SShucqMX+aVPQWoPl2NkjC8BaTNXYGohymsq9heiE2EeV29szhtMj+3nBOsqOrSNafHbBDPOb6mdvi2EQzqWNhXRzqcTV8PmfkSMru/LdyCy7oePx4SsnLrItcw6jc0lE0twRpZxWSwWQ==
Received: from MW4P220CA0019.NAMP220.PROD.OUTLOOK.COM (2603:10b6:303:115::24)
 by DS7PR12MB8201.namprd12.prod.outlook.com (2603:10b6:8:ef::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.31; Thu, 17 Aug
 2023 13:59:19 +0000
Received: from MWH0EPF000971E9.namprd02.prod.outlook.com
 (2603:10b6:303:115:cafe::25) by MW4P220CA0019.outlook.office365.com
 (2603:10b6:303:115::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.17 via Frontend
 Transport; Thu, 17 Aug 2023 13:59:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MWH0EPF000971E9.mail.protection.outlook.com (10.167.243.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6699.14 via Frontend Transport; Thu, 17 Aug 2023 13:59:19 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Thu, 17 Aug 2023
 06:59:08 -0700
Received: from localhost.localdomain (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Thu, 17 Aug
 2023 06:59:06 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>, "Amit
 Cohen" <amcohen@nvidia.com>, Danielle Ratson <danieller@nvidia.com>,
	<mlxsw@nvidia.com>
Subject: [PATCH net 2/4] mlxsw: reg: Fix SSPR register layout
Date: Thu, 17 Aug 2023 15:58:23 +0200
Message-ID: <9b909a3033c8d3d6f67f237306bef4411c5e6ae4.1692268427.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1692268427.git.petrm@nvidia.com>
References: <cover.1692268427.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E9:EE_|DS7PR12MB8201:EE_
X-MS-Office365-Filtering-Correlation-Id: d6e1b1ae-43ab-494a-3180-08db9f2a26e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	xRmGzReHdN2XUXUyysTqyxOiRKuazKioAcYtAOl7DeXP8jobtG4/dqY8Kpyorbx9vFuY0hxg2eD+NQ8evfnNDAYh+41eQV982MPAxY+t4H6uSOAOraV+suxF0enR7ghnpYbO2B4lrZ2mM9P859oZvTJV7tiLL0k6UPffD94TvP06n2gQFjU89Vm9OFG0CJhDZLiHM1zuUjd2GbDi5BUip/Kg3+TnF3k5HYl2jXQyeEuvGJ88XWx+TpZegs8WONPw3yHjkZaF5U37h82jprWMjS88I7iS+FVrihiueZjcMfYVC4zyyCrwAoE1JI0bYuqD2NDoJrHWzHHq3gIoEdaQxac3lqehDLL0xmGJWTBVO6ILPFFWdZeItJhkNUykMciEVAAKf6Cp2q8LJFjP+MzI7wCUdRZlgCCAuHeTVqtwNUBDOCn6H+REAiVkLTMH+uZw/CFgqryv4i43SWWz+8FbzMol9TZx7fZ5D5nucwLcBhsqeINH5PPIkTwEHIWTW84+FWu15gxjFiw+BU8D2aXh7Rq4HpROdby+O/UWHXEOWBGKxvngDHisnoRT6uD4rVlkNN/fIL619PVGAKJ1bDZ3M7IMC435xc9aBTYjWFk0z+2E8HR5JCNPqtHk2ioGnhs77TKThatCqQuXjyQANT9SRtyuwXMPUsUAUbxNGuJM1I0ySuqO6UJn8VKpazcppgxXIJlRYLDZgklTscLYgKH10to3k/UaLKJ5AyhQUI712CTjb7vyFHC/LNUoKH7Wxufg
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(396003)(39860400002)(136003)(346002)(376002)(1800799009)(451199024)(82310400011)(186009)(40470700004)(36840700001)(46966006)(40480700001)(83380400001)(40460700003)(54906003)(70206006)(70586007)(316002)(478600001)(110136005)(356005)(82740400003)(7636003)(2906002)(41300700001)(8936002)(8676002)(4326008)(5660300002)(36860700001)(426003)(47076005)(6666004)(107886003)(26005)(336012)(16526019)(2616005)(86362001)(36756003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2023 13:59:19.1764
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d6e1b1ae-43ab-494a-3180-08db9f2a26e2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000971E9.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8201
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Ido Schimmel <idosch@nvidia.com>

The two most significant bits of the "local_port" field in the SSPR
register are always cleared since they are overwritten by the deprecated
and overlapping "sub_port" field.

On systems with more than 255 local ports (e.g., Spectrum-4), this
results in the firmware maintaining invalid mappings between system port
and local port. Specifically, two different systems ports (0x1 and
0x101) point to the same local port (0x1), which eventually leads to
firmware errors.

Fix by removing the deprecated "sub_port" field.

Fixes: fd24b29a1b74 ("mlxsw: reg: Align existing registers to use extended local_port field")
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
Signed-off-by: Petr Machata <petrm@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlxsw/reg.h | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/reg.h b/drivers/net/ethernet/mellanox/mlxsw/reg.h
index 4b90ae44b476..ae556ddd7624 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/reg.h
+++ b/drivers/net/ethernet/mellanox/mlxsw/reg.h
@@ -97,14 +97,6 @@ MLXSW_ITEM32(reg, sspr, m, 0x00, 31, 1);
  */
 MLXSW_ITEM32_LP(reg, sspr, 0x00, 16, 0x00, 12);
 
-/* reg_sspr_sub_port
- * Virtual port within the physical port.
- * Should be set to 0 when virtual ports are not enabled on the port.
- *
- * Access: RW
- */
-MLXSW_ITEM32(reg, sspr, sub_port, 0x00, 8, 8);
-
 /* reg_sspr_system_port
  * Unique identifier within the stacking domain that represents all the ports
  * that are available in the system (external ports).
@@ -120,7 +112,6 @@ static inline void mlxsw_reg_sspr_pack(char *payload, u16 local_port)
 	MLXSW_REG_ZERO(sspr, payload);
 	mlxsw_reg_sspr_m_set(payload, 1);
 	mlxsw_reg_sspr_local_port_set(payload, local_port);
-	mlxsw_reg_sspr_sub_port_set(payload, 0);
 	mlxsw_reg_sspr_system_port_set(payload, local_port);
 }
 
-- 
2.41.0


