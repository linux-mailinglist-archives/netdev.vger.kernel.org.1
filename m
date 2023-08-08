Return-Path: <netdev+bounces-25336-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CE958773C0F
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 17:59:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0AF7B1C20F28
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 15:59:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13A8E171D5;
	Tue,  8 Aug 2023 15:47:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0198D14278
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 15:47:00 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2042.outbound.protection.outlook.com [40.107.220.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DBAF7D83
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 08:46:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X29VUzxwTPPE4KuBGRzgOSSIwQa25GCAHoH+irvrp+jKjRnOBzVLg+DH+Jypj6aB+ZjOxzaeJb0sifwsqIT6dBBZbeLNRN5xfOG67lrPKKSGyAgFGqg7JqyxTWo9ZFQWFUxbmAiwTakkg1M6+iE0H0incq2Zr+5OWjFHwpr6ljn6hrUdNJ9t9WZP7AhrRIXYRgl+k98C0nQWt67eu8YSYVp1qnGyLbMqBB9zmYsy+QnAJIJsqTL+6m0R0HPnIZvAwle2/kP6sZTjZH8a36+htRzwRGynwSMjv7ZHc+v3xTDpxyrj/ArZC9VvsOJQnr/OQv/J/8WgQxK6+dq6ho3lRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FMj/epV3tCNjfYQ8wYwqVCOsGSb+mKS/0AyZduT/v+A=;
 b=A+fmVcEyXg767VmHNNAGOEh5quNtDtPEws4g8hQ6hHFtivKd3euLqpcKHjeQToTJpoE9lwn3s0QFahIzufcualPqdJQr9uFTWSw0uDgV/mZ7f80EvZvRbS8cejh2fD/ZQ3Wf/6br22Hm7zOGp8Y83kgOXgLMWh5aVgl9MiKiUcvWuiWStbD46f5gDR75jJ6JUcwFYptM3G2b7EdHFkAeuuPuNWAk2iI8eb6KN/ZocxMmxLpFijf5Fgh4zptqNoqSnTHX1QQpBGr2za9y2YzYI2/SvWgY/iB4uB8drlz59C3+fXmo0cOPJs/JS8pyQf93qgulzZwIqAbZCNPrTa1F2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FMj/epV3tCNjfYQ8wYwqVCOsGSb+mKS/0AyZduT/v+A=;
 b=PYUm+sJCBKvDR72OqTSzcbqL3go+m5C09mrWyVGzcHXX91p9kz+hODr0QgLaWOxA45OiPEJ5qHkNAEKVDedTdnUzdkrx08FYw3VsoCJ4tXk18XyFLQOaBuWI5HSwAGbGMCuQ/8y38yQlOhjZjpq6/3dUQNwHcPN1JHAoKBNdOEq477qUzLMsFfpa+IMpZlX2dlxcm1TNbYZZHTSsktbrzhZoOjfc2+qgOIglrl/59mORao5eDGamqFjM+7aL4O9rv2HBtbtx037O/uftxOz9GJ9UjWVdNhtXSyPIu31P+TUXtN7afxhCJN8no1uyBJm0Hv757uOjj5L7BaXyQh0tSw==
Received: from MW4PR04CA0343.namprd04.prod.outlook.com (2603:10b6:303:8a::18)
 by PH7PR12MB8777.namprd12.prod.outlook.com (2603:10b6:510:26b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.26; Tue, 8 Aug
 2023 14:16:07 +0000
Received: from MWH0EPF000989E8.namprd02.prod.outlook.com
 (2603:10b6:303:8a:cafe::87) by MW4PR04CA0343.outlook.office365.com
 (2603:10b6:303:8a::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.27 via Frontend
 Transport; Tue, 8 Aug 2023 14:16:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MWH0EPF000989E8.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6652.19 via Frontend Transport; Tue, 8 Aug 2023 14:16:06 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Tue, 8 Aug 2023
 07:15:52 -0700
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Tue, 8 Aug 2023 07:15:49 -0700
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <petrm@nvidia.com>, <razor@blackwall.org>,
	<mirsad.todorovac@alu.unizg.hr>, Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH net v2 07/17] selftests: forwarding: ethtool: Skip when using veth pairs
Date: Tue, 8 Aug 2023 17:14:53 +0300
Message-ID: <20230808141503.4060661-8-idosch@nvidia.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230808141503.4060661-1-idosch@nvidia.com>
References: <20230808141503.4060661-1-idosch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E8:EE_|PH7PR12MB8777:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f670f96-d107-4785-43b5-08db981a01ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	C6HtctMaBIv07VJEcwS8twXjs12p5TuFa4Gtz8sbCEyUPZyZnaIuyqJhVkarMTpSyS0nzjpxIcToHxn2eQjU20GNvqYVw4w7AIh3nJybYL9MYZVY5SgWGrP2+Ir4g+wlgMRN7gj5kaX9AMvpOB3xLWb7YFJPS81gzz28z8x6pJ8l27VtP39ufRM+rj8A6BgHX40GdroYMaOL9BGojClI3nzIJtNjxMdp2AdktkbS2OZLdqRZuvX2Kz5AYQkXCc/6PGr/YoPtkU0WDOg9YkiX2nyuad1R8FxXNNq0lUEtoqXtzk4c49qKjcJZooETMSx4iBX4Rj+C9yUnAvYdBkG4tltIm+fcAIggJ4ZYDwCPiwxl2RZFDUwWvBLHTUZxzTD9qZKUCUjzZwjn42SVBmLOv//d8tD1rNi6z+eiugdRfo3G5jaC+6OREkd5VrMdhzhqqlBIUA+rK2RT4Bb1jqe5dKwet7Tzm3jvuCZg/cJYe9Qi92lM9cFQa7SbOKaHQPGO/KZ+gbNAB7npmfodBQzXo/5TRmJc3+5NeREYPKjNgVZToR00hasIQVse/dVqWqe2aaiQuyWXzoX75ldOP91QIt9y74tphZE2t4bLln3utXu+PNuOM9/u4+ZxEzBHz3xx25q9v60olcNMV7kbW+XMkM5GGAYGv6lBJNwNJVRyCpK1w4kRH8WpAjCEoiNtiwjeqfKrrMGqu6k2Z46oY73KQdtFeYjlRhWz4WJlRrbzZL7vrkmOqHTSzzcg06quIs55R3GPRs9VL52udlRCDVgzgg==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(136003)(39860400002)(396003)(1800799003)(186006)(82310400008)(451199021)(46966006)(36840700001)(40470700004)(426003)(26005)(1076003)(107886003)(83380400001)(2906002)(5660300002)(8676002)(36860700001)(8936002)(47076005)(41300700001)(16526019)(40460700003)(2616005)(40480700001)(336012)(6916009)(86362001)(356005)(7636003)(54906003)(316002)(82740400003)(6666004)(70586007)(70206006)(478600001)(966005)(4326008)(36756003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2023 14:16:06.6692
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f670f96-d107-4785-43b5-08db981a01ab
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000989E8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8777
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Auto-negotiation cannot be tested with veth pairs, resulting in
failures:

 # ./ethtool.sh
 TEST: force of same speed autoneg off                               [FAIL]
         error in configuration. swp1 speed Not autoneg off
 [...]

Fix by skipping the test when used with veth pairs.

Fixes: 64916b57c0b1 ("selftests: forwarding: Add speed and auto-negotiation test")
Reported-by: Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
Closes: https://lore.kernel.org/netdev/adc5e40d-d040-a65e-eb26-edf47dac5b02@alu.unizg.hr/
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
Reviewed-by: Petr Machata <petrm@nvidia.com>
Tested-by: Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
---
 tools/testing/selftests/net/forwarding/ethtool.sh | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/net/forwarding/ethtool.sh b/tools/testing/selftests/net/forwarding/ethtool.sh
index dbb9fcf759e0..aa2eafb7b243 100755
--- a/tools/testing/selftests/net/forwarding/ethtool.sh
+++ b/tools/testing/selftests/net/forwarding/ethtool.sh
@@ -286,6 +286,8 @@ different_speeds_autoneg_on()
 	ethtool -s $h1 autoneg on
 }
 
+skip_on_veth
+
 trap cleanup EXIT
 
 setup_prepare
-- 
2.40.1


