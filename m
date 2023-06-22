Return-Path: <netdev+bounces-13021-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB679739E51
	for <lists+netdev@lfdr.de>; Thu, 22 Jun 2023 12:20:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C61CA1C210A7
	for <lists+netdev@lfdr.de>; Thu, 22 Jun 2023 10:19:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF01E174FA;
	Thu, 22 Jun 2023 10:19:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC6FF3AA8D
	for <netdev@vger.kernel.org>; Thu, 22 Jun 2023 10:19:57 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on20609.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e89::609])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 694A6DD
	for <netdev@vger.kernel.org>; Thu, 22 Jun 2023 03:19:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PT6S4Di5Psl/byPmsoMYq9gCXG+F/EYJB9cVavgUME5rLaLTw0SD0poG7xnngsDru6JV5dQGDPNPlMWISMiyIG3FuJjy2Nl7trvX6oaonbOf97evSHYlHQf74ff1sh91eA/41VmBbBi/Nx1SrNY6mBE/9ke8Xxp65zrcP+YmgZjO5sYTTccrZhi1ip6F1V0tmIrbg43vSZ+d2Yb7Iov+bEjJ9vGfmASh4oP/tGH+GUKGE6luSIRtObi8K9blYpsWxyCnhlGv04e02ntMIDAu4MjWZ+I0+WSUHPQl2hisaTsJrawtISCMLqNFWAGe7pd7vE2jE9dSp7qn76z2lPqODg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ql7QHXyvScLJAKnpNd5i3eCiwxfL41IbMEj9w/kxFZw=;
 b=EzRz+x1J0A2Y7cZKGP+YV+84woGCVMR37hUXRDDLALk6SgMmlDLHZb1jdPXy5NwzI4UlrnUHpBNh+2yPSVQtAXSRKJQu5dHT4qBx57AdEziNqg5YFO6CZ+OLVHGYzNaJCKkFmULQNJKYnPphzpfJqYV7vm3XLM99iteanKVGat/g+XC5MYnEfsby30ailNDUPhNtEVQw6oE3Rds18TymgEvcmkpZI/DvXUGm4ucGiTNTiPYAanVOvjFlplEqVpPEdd3igtIt8XyMGxldu9q1iNL5j8b2KdZDiBj1dwbnOTCffqVapnszg0JrbY5zLhglqVkN9DZbpHsJohMiqFTRNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=davemloft.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ql7QHXyvScLJAKnpNd5i3eCiwxfL41IbMEj9w/kxFZw=;
 b=xi1JQkTt0+cvhFzgcFsGus+3Ly9zq5wtQBkzRkGZYM1r1L369Ygpc+lAsJ4ijhtHkdbnEx2mID5Onp04UXmVm/uCO0ANqbkG/wQjaEFZe1Rj1ckegtLrGduDoqK9f/JFNJMHyDz5HqhRwPryB98aavo3OBSwBFjU7Kf2pMizF1E=
Received: from MW4PR03CA0209.namprd03.prod.outlook.com (2603:10b6:303:b8::34)
 by CH3PR12MB8545.namprd12.prod.outlook.com (2603:10b6:610:163::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Thu, 22 Jun
 2023 10:19:51 +0000
Received: from CO1PEPF000044F7.namprd21.prod.outlook.com
 (2603:10b6:303:b8:cafe::8c) by MW4PR03CA0209.outlook.office365.com
 (2603:10b6:303:b8::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24 via Frontend
 Transport; Thu, 22 Jun 2023 10:19:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F7.mail.protection.outlook.com (10.167.241.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6544.4 via Frontend Transport; Thu, 22 Jun 2023 10:19:51 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Thu, 22 Jun
 2023 05:19:50 -0500
Received: from xcbecree41x.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23 via Frontend
 Transport; Thu, 22 Jun 2023 05:19:49 -0500
From: <edward.cree@amd.com>
To: <linux-net-drivers@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<edumazet@google.com>, <pabeni@redhat.com>
CC: <arnd@arndb.de>, Edward Cree <ecree.xilinx@gmail.com>,
	<netdev@vger.kernel.org>, <habetsm.xilinx@gmail.com>
Subject: [PATCH net-next 0/3] sfc: fix unaligned access in loopback selftests
Date: Thu, 22 Jun 2023 11:18:55 +0100
Message-ID: <cover.1687427930.git.ecree.xilinx@gmail.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F7:EE_|CH3PR12MB8545:EE_
X-MS-Office365-Filtering-Correlation-Id: f8f7e645-ec57-42bd-e5db-08db730a3702
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	eNhNFatfdgsMMoB3CM+Nd4depYlO+B4AAdfdoPjWMdZJXt6PESI1E/GkiRy9ubErw2DcBovTYT4X54xjijYJ/Fn6Wm/bqkhom+OdHRepatFAv94uI6yAHhcI1lOHD9lp/cBR33gXpHaxw7GSN3D0VVN7R3TCIXSymGWf3fO03UFfmMCtjOVpPiXe1YxHynfxR+/OhLHcdB2lw1URs4p7GXULquQTfB3h8GCVIMlMCw9EfVRELn+mLr2DFyiQxWfQB1hELoC/Xiv/tqa7bRAoiKkC1eGSD4R2t1MYAR61JEBf5jILq5o3mn4zR8KWrsJW0ouHxIfb0SHuZ8DLoJovRMP9rQ1c3WDZATMIK+jaA6C0eFDwHL9pbwYRhrbEwFNbTQG5UAxX6hh89VuL4vnco7vfZ0u1zcbPM1L44kcHgRrK24mwljqgPNog3XvFlpY+Dg7Ff2IZYEruOTOkpp4SwtSh27DeJbJ5TNaVugNSKV+ZyfHk4MCIrte1qpEc09ncCU1JT1cOxVjzEWFGmJ49bKK6zBvQInLcZx32646ZvV9+Ho6KdI0730sjxI740ftvcEOgDE80jNVtvQTv+TgbD034+XpA7bxOkahXw7dNLX2JvKM9Add9t0oDRXzkqjYiVGpD8i79dC6ktOeFZ/tvZHyAxIIRU2JGDkKkijZVsHwbRVDxobBMW25kJgXIH+goiYhChwQOp9POxyd3IBcqdP3b5aifevdX37cxe5dvZIACMv94KtpifNwCK/V5iw30wfDAmz+n6cJC0T2TNio/fQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(376002)(39860400002)(346002)(396003)(136003)(451199021)(40470700004)(46966006)(36840700001)(40460700003)(186003)(9686003)(26005)(47076005)(36860700001)(8676002)(336012)(83380400001)(426003)(5660300002)(41300700001)(8936002)(70206006)(70586007)(316002)(4744005)(2876002)(2906002)(6666004)(478600001)(40480700001)(4326008)(110136005)(54906003)(86362001)(55446002)(36756003)(82740400003)(356005)(82310400005)(81166007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2023 10:19:51.0517
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f8f7e645-ec57-42bd-e5db-08db730a3702
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044F7.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8545
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,SPF_HELO_PASS,
	SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Edward Cree <ecree.xilinx@gmail.com>

Arnd reported that the sfc drivers each define a packed loopback_payload
 structure with an ethernet header followed by an IP header, whereas the
 kernel definition of iphdr specifies that this is 4-byte aligned,
 causing a W=1 warning.
Fix this in each case by adding two bytes of leading padding to the
 struct, taking care that these are not sent on the wire.
Tested on EF10; build-tested on Siena and Falcon.

Edward Cree (3):
  sfc: use padding to fix alignment in loopback test
  sfc: siena: use padding to fix alignment in loopback test
  sfc: falcon: use padding to fix alignment in loopback test

 drivers/net/ethernet/sfc/falcon/selftest.c | 45 +++++++++++++---------
 drivers/net/ethernet/sfc/selftest.c        | 45 +++++++++++++---------
 drivers/net/ethernet/sfc/siena/selftest.c  | 45 +++++++++++++---------
 3 files changed, 81 insertions(+), 54 deletions(-)


