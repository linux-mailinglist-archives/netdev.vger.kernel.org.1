Return-Path: <netdev+bounces-39720-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02A277C42FE
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 23:52:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA8D4281B59
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 21:52:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDCCC3E493;
	Tue, 10 Oct 2023 21:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="x0X2w3QY"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECF866119
	for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 21:52:47 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2048.outbound.protection.outlook.com [40.107.94.48])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1B1A91
	for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 14:52:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RDvB8atorI7TrS9vlLFmqGboeKybF6AAhrjZM0FvWBew0agAUiKCmt4bNIJFqnlOPapU1R09Ujlf4ht0hMjk1qKQWQhmDj7HrW59Ib/KaNTGxvdfMbo9n3Atk9iwhEcUPeiHUqtNGnmFrCZW9DHBWrexXJO8rTzqTTaqf6wOUqAi6SOXXPBo7vdxKXTppwLwQ9Y5Szy5+ThKSttScnq+l7+0CwGEpvxa/anzTNhQYdEJ4ercVO8X3J+OV2EC56q0A+uaM/h+HsMd+gTKBwnJYVLucsEkDCWKBDX7jiN0sTbqJGnToANkV/mer5a39FMmQ+DDFEce/iAVMHvYPSMBIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5XLz44Laf6AcLp9LvLGCVcLwwq3l0PLlQTaIn2uywlA=;
 b=ISkIK5TRZnSQcS7BRl1R79KlPdqWQjDRck5+7DQUzeBzlZqvNjFRoR1bF1OlhcMIsXzzLobG6svq9JtigT6RKi+RZMCIy6lDTgbFXwAGSGrufH+SVXePagr5/q39Gs03L+QZKmSd9n5C5JWivDRnOK7fnTK4kc8MqM3VXEKf6yRgM+5XENIXwbZHE+MV7BxrbNOlDnGCqY5MmiE5WHroyiR35flhM1+/f8528F/DvH2mDZkkuJQU84dsE1rhpkuE+M07B7VAAT4PLaTMe6ysXZGw/a8+HdNggQeNrlwDs0BiaUt105GE8sWoMeNtj3EIeqWa13iBftBjOdNCCpFR8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=davemloft.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5XLz44Laf6AcLp9LvLGCVcLwwq3l0PLlQTaIn2uywlA=;
 b=x0X2w3QY9c238Z4qHdB1XMr0qoENRSwUnIrwcbaI7OtrXRdRqdJW/d6KBlxWI0gRC9q6Cj8QFjodhWWmrcPRyMWp90CU0B2Zqq0R5nxzR2HVQhjCUljgT8rG3cOF/0VcFWyUQxRTaDGXQ3UeEJDIdQCKJNlyK+laviNjbSHSp3U=
Received: from SA9PR10CA0013.namprd10.prod.outlook.com (2603:10b6:806:a7::18)
 by CY5PR12MB6322.namprd12.prod.outlook.com (2603:10b6:930:21::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.36; Tue, 10 Oct
 2023 21:52:43 +0000
Received: from SA2PEPF000015C6.namprd03.prod.outlook.com
 (2603:10b6:806:a7:cafe::d) by SA9PR10CA0013.outlook.office365.com
 (2603:10b6:806:a7::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38 via Frontend
 Transport; Tue, 10 Oct 2023 21:52:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015C6.mail.protection.outlook.com (10.167.241.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.22 via Frontend Transport; Tue, 10 Oct 2023 21:52:43 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 10 Oct
 2023 16:52:42 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 10 Oct
 2023 16:52:42 -0500
Received: from xcbecree41x.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27 via Frontend
 Transport; Tue, 10 Oct 2023 16:52:41 -0500
From: <edward.cree@amd.com>
To: <linux-net-drivers@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<edumazet@google.com>, <pabeni@redhat.com>
CC: Edward Cree <ecree.xilinx@gmail.com>, <netdev@vger.kernel.org>,
	<habetsm.xilinx@gmail.com>
Subject: [PATCH net-next 0/2] sfc: support conntrack NAT offload
Date: Tue, 10 Oct 2023 22:51:58 +0100
Message-ID: <cover.1696974554.git.ecree.xilinx@gmail.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C6:EE_|CY5PR12MB6322:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ca60824-4fb4-45df-7979-08dbc9db3b3e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	TZbKAirv4JbdkpVsyOeqYEqdpigoozS8YPAFo3tfRlEVbc+MokGWRBJ3lRT7yd971pdPe/o2hMtH7y+/62962pPs/paHqj22Xx3eRdWEqAGW+kipCE7NWvwCJED8cN+3RRWHrGO1lbXtRSBYh+F2zVe1TlVWiEb82uVcnx20K/11/L0+kWQ4XBlbSCqsp6OmxALfXZDfaALAh6QSlzZnZoxAhynB/pHRljznkb5LxDndmx12Xiq4AOahvCHhjOUKp5X/tzvCAhoPP4gj87/UPScATXAP0EhcVG9JT2I15v9UoUOVNbxAisGmlg+bRnU9n1hBnGTNqqOnTnY+DgJyHkynZ0M7Tir0ER/HoAPC6KlgswYlJWyQp51pRsdnqZxcIqJJnwKaiUBpAOBYWSpJ+qvwiV13eSgmN9OYSwmx/WhGXRxPuHKhAIo70qAwiVOoJ35byivEy86r7Nj0N+Mcc8gHNnbwk/9jZOkXPbkRrgzvZmT045T4eTErECfsb3eg16bZYuo0K1BcTc4RrDskQ8kKVP8RJtdTkAC/pf6mTyPvHCuWrUINUOgfC5hAOOvpU5VT8HbwG1ES3pJvWsIO93Jg24auP1ZZaBukk4LerhZkYAAexiFN/rRV6YvkfRkzBK0uURMANf7L04w/en+4pkI86yEF3jO2lGzPCvk3tIXCDO6MA1IA2H5/dFI0ZdRPEoebnnUhf3HmXQ7V9neion7De3pD/zK/yvqfGJ2lYGs9h6RUAfoCgbjEm68NTT/Zl/ssMw8Foz3CgrwIZg7aiw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(39860400002)(396003)(136003)(376002)(230922051799003)(82310400011)(186009)(64100799003)(1800799009)(451199024)(36840700001)(40470700004)(46966006)(426003)(26005)(81166007)(336012)(47076005)(5660300002)(8676002)(36860700001)(8936002)(4744005)(6666004)(2906002)(478600001)(4326008)(2876002)(316002)(70206006)(54906003)(70586007)(110136005)(41300700001)(55446002)(40460700003)(356005)(86362001)(82740400003)(36756003)(40480700001)(83380400001)(9686003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2023 21:52:43.1403
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ca60824-4fb4-45df-7979-08dbc9db3b3e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF000015C6.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6322
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Edward Cree <ecree.xilinx@gmail.com>

The EF100 MAE supports performing NAT (and NPT) on packets which match in
 the conntrack table.  This series adds that capability to the driver.

Edward Cree (2):
  sfc: parse mangle actions (NAT) in conntrack entries
  sfc: support offloading ct(nat) action in RHS rules

 drivers/net/ethernet/sfc/mae.c          |  3 +-
 drivers/net/ethernet/sfc/tc.c           |  8 +++
 drivers/net/ethernet/sfc/tc.h           |  2 +
 drivers/net/ethernet/sfc/tc_conntrack.c | 91 ++++++++++++++++++++++++-
 4 files changed, 101 insertions(+), 3 deletions(-)


