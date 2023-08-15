Return-Path: <netdev+bounces-27716-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B79B77CFBF
	for <lists+netdev@lfdr.de>; Tue, 15 Aug 2023 17:58:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6BC9F1C20D3C
	for <lists+netdev@lfdr.de>; Tue, 15 Aug 2023 15:58:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18EB415490;
	Tue, 15 Aug 2023 15:58:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02E4314ABC
	for <netdev@vger.kernel.org>; Tue, 15 Aug 2023 15:58:15 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2073.outbound.protection.outlook.com [40.107.223.73])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 397701BC5
	for <netdev@vger.kernel.org>; Tue, 15 Aug 2023 08:57:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vq48zP7jjOk/jT2Nks7pzOhKBvSvNAtCrzUtMqe6BdfzsiATOFuli+/uvh6NuA8nZntckemw+nT5F3EqKp1l7mfx/ZimXUih4u4wM8W7zIahDvejpKHTpifA+rNyIOS7U0i3SBT1vnHzeh+r6wi/eEt2juzvmBsDKuDauhyuje5rsWsgt5w5UdqSJ28GqzypFx0mLfC5hhWZMH4wtz1TrBY+f+mPN8VYY47ab9X32dL0AO1O3Ik8Mn4QYX04y4PjQVvDpJfEgS5gfB8dX9amUPo9ymWVSsQ/UoADrazqEkv73NBZBI66OmvJ9kEGnNpC1RgdLvoAQtZas0XWvIpNPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4Yw/HXJgKecTuFKJ1jI8K/w62q/Yu0HB+rumV5Cf2TE=;
 b=LaDzWHpdIveHjxLpzuUZMvsmOTyds6wEw7XnYFACdGW1TcO8ZskD8c3pMji3BbOq72vnolNmDV84kF5qS6P+03CSOvUAd+eYNW43feJ8h7e7dW75V0ioiZNmatjNM3jKUy+hd3ohv6LLu5GaTpXmmtQGos1s7giWB9Cqeyb2bmt3ZtAoF9QXIwE2uH91p39q2EY7tiXI/RWQcxdihjiTfNIDiTmNdAGzowUYlm1N1rXFvr5MAw18JlajVse10IpamUSgVFujM6hhCRtBaeZRRlY0b8nHgRe3fQJayGOU3MytF8EZCGs+7iC5QbRVX1RvUCxUAlqEyqL+RSI6hzmIzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=davemloft.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4Yw/HXJgKecTuFKJ1jI8K/w62q/Yu0HB+rumV5Cf2TE=;
 b=Teh3QF7XfSVFOHz237hG/MIyADfBBps35npubxUIOPy3gG8J+x2G0ncoGkPZJflFrKNJJyGYeiUALKs02jxTxzTTpB9vxehUd8Si0DNnRxHOlGvrCX+9zJnyZSeHP9ljsSZLnZ7F7Ba/wwa9scNb4T99QYLI4ygrV0O3cm14Bc4=
Received: from CYXPR03CA0078.namprd03.prod.outlook.com (2603:10b6:930:d3::11)
 by SN7PR12MB8789.namprd12.prod.outlook.com (2603:10b6:806:34b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Tue, 15 Aug
 2023 15:57:57 +0000
Received: from CY4PEPF0000E9D7.namprd05.prod.outlook.com
 (2603:10b6:930:d3:cafe::81) by CYXPR03CA0078.outlook.office365.com
 (2603:10b6:930:d3::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.14 via Frontend
 Transport; Tue, 15 Aug 2023 15:57:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D7.mail.protection.outlook.com (10.167.241.78) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.14 via Frontend Transport; Tue, 15 Aug 2023 15:57:56 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 15 Aug
 2023 10:57:55 -0500
Received: from xcbecree41x.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27 via Frontend
 Transport; Tue, 15 Aug 2023 10:57:54 -0500
From: <edward.cree@amd.com>
To: <linux-net-drivers@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<edumazet@google.com>, <pabeni@redhat.com>
CC: Edward Cree <ecree.xilinx@gmail.com>, <netdev@vger.kernel.org>,
	<habetsm.xilinx@gmail.com>
Subject: [PATCH net 0/2] sfc: TC probe fixes
Date: Tue, 15 Aug 2023 16:57:26 +0100
Message-ID: <cover.1692114888.git.ecree.xilinx@gmail.com>
X-Mailer: git-send-email 2.27.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D7:EE_|SN7PR12MB8789:EE_
X-MS-Office365-Filtering-Correlation-Id: b391405b-8e3e-4fba-fa74-08db9da86457
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	tqdyeGQeXfl2Ubtutl5Rrl2UIEwFwsF84vAeNVNXx2EZHplekvrmachRAfRo5won+rJfr6VzsfWoCvpe93rzuVQ402uV6SoJHYtrkSRSV0HMMHsHv/c7HR4CA8keO0NAJAixnqSIaR2MMOdSqJzL/tIWcEWk0+EM2quVTbkbyDHRK8NsLSffM7eqboa2wHwQv9TCQmRpby2t56LfdPMvhOx4XPm0AHb+HFoTXjjwNVpFH+i9XiFMSutFsGo2uoIymY8tEMPBFJcLhsQj+dUiiBrPCJVXUyVe1iGQvekqI2yWjptmgAYMiT/Trvyp5a9RU8i0CvqE1oDjrFPWKWYlbjWD/jtHbpNq4hSbAPpEdhqfvEVpaaqPqO/cfgbZkkVp7YHV/Etsb0eb2afNYuO5G/3IbbFeJ8IaLeWrMOR8Kjuw26g9UjaRGtaK4j/DRargaoUFIHacfrIq3rDE+C40VDCtpPofoHsNXHa2XvV5LIkaEPRIBvFEOvYAheOdKoLR3mwBEkGGAaZJ++JWPeKVfpPSmQzqioETU7aofUjjnzBVju8kjBxy674VPP6XYD2h36n0XXkCE2N+Fx60VD3vlKmu8uImYszg0XJ6TDuXvE1myE+nOkV5YK37pW9PllCMHyYN2ycHSCV4yWPD+04CuGzHXDLzGat4ep/mXuoBCjXKhU8x3EZS+9fh7YZqEzSUTJp6ZMxKsB0irpJzwg/xC4ixK/9uv3liwh7EmzrvSseVPpzEsAQDFcOrEaJVXfy1owstlXnbZi7tJI9gNxbDQA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(376002)(39860400002)(396003)(346002)(451199024)(1800799009)(186009)(82310400011)(40470700004)(46966006)(36840700001)(40460700003)(4326008)(8676002)(478600001)(2876002)(26005)(316002)(426003)(47076005)(336012)(36756003)(36860700001)(81166007)(82740400003)(356005)(41300700001)(5660300002)(83380400001)(86362001)(2906002)(9686003)(6666004)(110136005)(54906003)(40480700001)(70586007)(8936002)(70206006)(55446002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2023 15:57:56.5673
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b391405b-8e3e-4fba-fa74-08db9da86457
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D7.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8789
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Edward Cree <ecree.xilinx@gmail.com>

Fix a couple of minor infelicities in the error paths of EF100 TC
 offload setup at probe time.  Both found by code inspection.
Patch #1 will produce a conflict when merging net into net-next
 (with 3bf969e88ada ("sfc: add MAE table machinery for conntrack table"));
 the resolution is appended.

Edward Cree (2):
  sfc: don't unregister flow_indr if it was never registered
  sfc: don't fail probe if MAE/TC setup fails

 drivers/net/ethernet/sfc/ef100_nic.c | 2 +-
 drivers/net/ethernet/sfc/tc.c        | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

---

diff --cc drivers/net/ethernet/sfc/tc.c
index fe268b6c1cac,246657222958..000000000000
--- a/drivers/net/ethernet/sfc/tc.c
+++ b/drivers/net/ethernet/sfc/tc.c
@@@ -1657,11 -2087,17 +2087,17 @@@ int efx_init_tc(struct efx_nic *efx
  	rc = efx_tc_configure_fallback_acts_reps(efx);
  	if (rc)
  		return rc;
- 	rc = flow_indr_dev_register(efx_tc_indr_setup_cb, efx);
+ 	rc = efx_mae_get_tables(efx);
  	if (rc)
  		return rc;
 -	efx->tc->up = true;
+ 	rc = flow_indr_dev_register(efx_tc_indr_setup_cb, efx);
+ 	if (rc)
+ 		goto out_free;
 +	efx->tc->up = true;
  	return 0;
+ out_free:
+ 	efx_mae_free_tables(efx);
+ 	return rc;
  }
  
  void efx_fini_tc(struct efx_nic *efx)

