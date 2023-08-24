Return-Path: <netdev+bounces-30443-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 29DA878751D
	for <lists+netdev@lfdr.de>; Thu, 24 Aug 2023 18:20:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F9AA1C20E7D
	for <lists+netdev@lfdr.de>; Thu, 24 Aug 2023 16:20:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 333CB154B7;
	Thu, 24 Aug 2023 16:19:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F23F15485
	for <netdev@vger.kernel.org>; Thu, 24 Aug 2023 16:19:30 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DA3D1FF3
	for <netdev@vger.kernel.org>; Thu, 24 Aug 2023 09:19:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ly6gV94oDpaSZFGxdcbw2/siAW8XhtBAb0G0/IXG5vI4G0CSxZLpiOkGf6xp2s7K5Lwqtn5oSwKKmqn4dlZxCZWVAm5G8VTEkyEIkEDgK4ZUb6XnkODWAGFSnMwYND3Uzl8JUCthpetGsVleoPsZUMHLiGrlQiIMCmXsxmB3yCeCW5KLTD2t4VLho+tHp7bfDBdHHk+y3dRuYpOymaO3Q2jN1cP+mhQhwaWeV6jvukbOXAR3Ubkv99rn0IwF3LINiWVYkkAmtFif3XJ0pOeQJMPPuLvLyOGPO3b4GYYPR7Y+D+9yzfnzk6MiOCON4/ER0ZLmFrisS9gRUsmegAo5lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pF7QeyHgSguPuFDdLu5jA1+ZBZUVNedh4SdayyKO0Ss=;
 b=gICHxD/KBXzDsxsnfBDyjPcVHXZXd/tBLEE41iGcwUrdm7ZdAUXU5m6B6AiLsAJSNDJJhsfxEgrUWEBRED/WIYNJBzr1Ibr+5zcJbfIw86nR1YLC7ZBeGKUj3m7Ymfwu+SFFoGiWOgezeU4OMJSWX8NxiHQflte56B6DONUve13kV7TiCHvAGJ7/Oo1dRV1WPzecxmYqjPG4Au4OZdi5FnwHVW4Mbo0ZyMbzfSanOuDBQunNNBBdMt7jsSZJvNwQpXJVyUaDksDhteDzbgxk3OLKwUqOABy2DJzPV92VuAzTfPP3sZKZ9bXNFWZ5khOYYkP0nj5UmzLV0YlYI84rPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=davemloft.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pF7QeyHgSguPuFDdLu5jA1+ZBZUVNedh4SdayyKO0Ss=;
 b=Xa8xLn9hmv/qJw3ux9YrjfkmD8u5jKAbWV0KGwFkxvOEuQ33NmO9wCgQDJoHVUdTYR8dw/tK0GsSIB89MOZl07Vs63Jv2hcY6+O+kCAO2KtlmNfJZTOGNrLvkj1zJM7RHStP791LRKa/YgnAfi2BPh1JOroe1oJ2S6CJwLNMWZU=
Received: from SA9PR13CA0047.namprd13.prod.outlook.com (2603:10b6:806:22::22)
 by MW3PR12MB4571.namprd12.prod.outlook.com (2603:10b6:303:5c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27; Thu, 24 Aug
 2023 16:18:22 +0000
Received: from SN1PEPF0002529F.namprd05.prod.outlook.com
 (2603:10b6:806:22:cafe::8) by SA9PR13CA0047.outlook.office365.com
 (2603:10b6:806:22::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6723.17 via Frontend
 Transport; Thu, 24 Aug 2023 16:18:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002529F.mail.protection.outlook.com (10.167.242.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.15 via Frontend Transport; Thu, 24 Aug 2023 16:18:22 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 24 Aug
 2023 11:18:20 -0500
From: Shannon Nelson <shannon.nelson@amd.com>
To: <shannon.nelson@amd.com>, <brett.creeley@amd.com>, <davem@davemloft.net>,
	<netdev@vger.kernel.org>, <kuba@kernel.org>
CC: <drivers@pensando.io>
Subject: [PATCH net 0/5] pds_core: error handling fixes
Date: Thu, 24 Aug 2023 09:17:49 -0700
Message-ID: <20230824161754.34264-1-shannon.nelson@amd.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002529F:EE_|MW3PR12MB4571:EE_
X-MS-Office365-Filtering-Correlation-Id: 2dc43e5f-f335-4913-fa07-08dba4bdbc9e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	27UrQOZuXcfXC3phq8Wxd9A8QEGzSZ0mgyWMnrrgMZ0ql4xmN9kEFrBJSCH7cmhA1Iz8DF/Do/6h04FY7MuSlJLPcWnJnOpxC5uqBGhl2UfSI+deN9awmHLRn8ZIAksGkLJYX4hm6jwmj6DnhgIheBdwQMCVJpDPv7k3gCk/aoQHiDRbEvsVYp8gyVSPRdzqst0WBg5JKXwbkZhM18YkhSA401qmpVcI1W36gvUwbMq5VVQLdi6uTH4tEHDRtO/T2X1m2P/D5kXNmhsLM7bDZxUPAChBQraX+ZqvpyxPNbLuiMxsn51ZbEuLUfBbSYOf3hcMUpaDOHYyJjdvqNjl4izSNa5FL81TCxMe5+yarYlAvWel9c6y9x6cRk0ia2V2XgMIXIGic4KV2cyOUKVx8vlhDw9Rfr1+841n/ypVH5IZ2sTEyhfkmYgg4z4aI6cF2J+ndmRuPR8H3s+lQcBx0Zkc0aznMI169iqnuhRB8nUUcrD0V4b3DpkwigjQBA2mD7LLOYGcu79RTqXt2nvD+fFFoZOzBtH8pbHi6d2KmI8DflJd6FBstV/SwOuHqs9KZldAMprn89A1e1bM9Oc5P00sQWnO/O//xPFkStPh6fFqpZcA6EOW5Fw/1TrnnxzNwIgl9Em48Jule9BJmDqVqUgIAiDX5BU3Ebq+E/mvF1u1n49trBuxR/BxZYcT48hUNXczhmnId1m4Qjye8muqXFaTzE+j2qReWgQR4vj5az1XhOq9T5OauSLPFoMxQQ0fGqiPgwOeDVYOJSWv7Td7uQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(39860400002)(396003)(136003)(346002)(186009)(1800799009)(82310400011)(451199024)(40470700004)(36840700001)(46966006)(1076003)(40460700003)(2616005)(5660300002)(8936002)(4326008)(8676002)(336012)(426003)(47076005)(36756003)(4744005)(83380400001)(44832011)(36860700001)(26005)(16526019)(40480700001)(82740400003)(356005)(6666004)(81166007)(70206006)(70586007)(316002)(110136005)(478600001)(41300700001)(2906002)(86362001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2023 16:18:22.1179
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2dc43e5f-f335-4913-fa07-08dba4bdbc9e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002529F.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4571
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Some fixes for better handling of broken states.

Shannon Nelson (5):
  pds_core: protect devlink callbacks from fw_down state
  pds_core: no health reporter in VF
  pds_core: no reset command for VF
  pds_core: check for work queue before use
  pds_core: pass opcode to devcmd_wait

 drivers/net/ethernet/amd/pds_core/core.c    | 11 +++++++----
 drivers/net/ethernet/amd/pds_core/dev.c     |  9 +++------
 drivers/net/ethernet/amd/pds_core/devlink.c |  3 +++
 3 files changed, 13 insertions(+), 10 deletions(-)

-- 
2.17.1


