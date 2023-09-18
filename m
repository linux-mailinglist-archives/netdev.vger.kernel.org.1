Return-Path: <netdev+bounces-34826-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9326A7A55B1
	for <lists+netdev@lfdr.de>; Tue, 19 Sep 2023 00:22:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BBD5C1C20B08
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 22:22:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3F2631A8B;
	Mon, 18 Sep 2023 22:22:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B3BC450FA
	for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 22:22:01 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2046.outbound.protection.outlook.com [40.107.237.46])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A742C0
	for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 15:22:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EaRvl1s0GV0n66zgvFtyO2qjs2COW5Fs79uMGVlokD7yjhs1OIjqQB1rJJgQplS2+/5K6leQSQT3WTnu+4Kucptr9thu6+CR2DcVbk6OsPCo+KTVSfv/qLYWjSRwSq/Vij7MA+UzcST4anS96X1GrpuzuQlcOvlERjJ1vR8lFSERwRgmOUtOZ2t/uFQacK0c3Nx+fEpU20cE8Vi9Dt7KbJZossV1+nMUzBBJ7rhtgM5pLGXx8qszdTr6Rb0a4dJwhcckJv88aTxfq+9RTue49jG+8uL4fXVT3IJ6aGgJijWKXlZzbQgnI8JOrbIwwB1n3Ri1IOOF3NwfiNuHTaEmGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TudKb2LCzewD03pZlJmMfMGnIWshNaemhsWx2mF7Dwg=;
 b=M/5biEaUcDUEq96FUZU/1Ag3ha+M/WSosgs48jWsxkCGajwnY8L/hpxpBuv8HmuRlwa17ZWZcPUFnLfDsdw+OINMDmFl7H/0NVD6et7sKN4AkhkxseLXDlG165kscPIYotqS0wmj2WpqVHd5S7klPzEXNpmKD58YBPATHqWbQ/HeaYGp7LGkLdbKnKUUGN6E8pID7892ip1aTYuCHonwMetW2mz2mFE1TWEnUXNIg6DbGxl6JvLVf+JKWcBfKiCW47P3DX+1KfU7bj4pjLxSRKg97S/Oor0pSXC1kGbIFOysG+Wt4Mzl8dHQdmhMEruNfdtajPxVjVyV9Qx0uRb44Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TudKb2LCzewD03pZlJmMfMGnIWshNaemhsWx2mF7Dwg=;
 b=IihFU0JhiRl/v7g+0h7sMo0KqOxJQ3s//hFn8vPUhdNVZNTUF+IIGO5nqFPDPsEaSZwUnIHUuBJy7+LH6KCaJNEJvbna8jxm0OB47wn0ePgzGa53ug1/QX22c6Mz3RnvFySOIL485fUJeXB3s2gukVPuSCbrEz7hawuVm+dbd3I=
Received: from MN2PR15CA0016.namprd15.prod.outlook.com (2603:10b6:208:1b4::29)
 by MW3PR12MB4537.namprd12.prod.outlook.com (2603:10b6:303:5b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.27; Mon, 18 Sep
 2023 22:21:56 +0000
Received: from BL6PEPF0001AB57.namprd02.prod.outlook.com
 (2603:10b6:208:1b4:cafe::3b) by MN2PR15CA0016.outlook.office365.com
 (2603:10b6:208:1b4::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.24 via Frontend
 Transport; Mon, 18 Sep 2023 22:21:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB57.mail.protection.outlook.com (10.167.241.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.20 via Frontend Transport; Mon, 18 Sep 2023 22:21:55 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 18 Sep
 2023 17:21:54 -0500
From: Shannon Nelson <shannon.nelson@amd.com>
To: <netdev@vger.kernel.org>, <davem@davemloft.net>, <kuba@kernel.org>,
	<pabeni@redhat.com>
CC: <brett.creeley@amd.com>, <drivers@pensando.io>, Shannon Nelson
	<shannon.nelson@amd.com>
Subject: [PATCH net-next 0/3] ionic: better Tx SG handling
Date: Mon, 18 Sep 2023 15:21:33 -0700
Message-ID: <20230918222136.40251-1-shannon.nelson@amd.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB57:EE_|MW3PR12MB4537:EE_
X-MS-Office365-Filtering-Correlation-Id: 48c778b1-ec2d-43e0-7624-08dbb895aadc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	GZyjNoOeaxQqjjY7yT3WCbzSw301g1zTUBHEYLsjqIJybss/Gb9hGpu9gTvYcQ+Gt0P/iAZ2DGrp04m6Hh60CMUqk7EEi6fEPxMk5EwBzcq1ORb+2Hy5mgvoGsjMho/SE37hQXtTnFNlofgFXIKIP+IqqELTcL07rnHmYc+caHOVdZ5fVN7nu+GEqhZdWXRHjpAJX0m4aXs3aw+0axCZphpVjHRx+8c5FGkR5syLxG1GmWabDsjXvaIZTHfUEvp+bZz03uk+M1Hx1yThKWQF6nXsjxUOw5vtYd10n1ZE6FF05PdswB3moFaEDgrtUWPR2yHiejSYaYORSCMHleCCshPoc0Bc5Sz8RaunbYoxH2XPrToimB7ENWkLkuiNhla5N+GBtCkGcV6Lqd6MHcFVlaQk7nhJUmxjuZ79T7EHYA1+t+yC6/3YdlDEmnjuzK3zH99SdbvOxpxAUbpSH4GqfUdl1JXMa9Femh5v1RZr4Fi7htK/XuSH8bpzvmxqefkOqn/E27GT00d8P1ApO7jwcq8AHUr71vP4XIGCJ0PFSQNEwoqih1rKO93YrLw4u9Zc9NPLPns2UeSvD/9CYH0NxLLH4fTzoN5vZIQFnqqDngqsN+0SpvqSj2d7sL3KD5GrRPwna+2Cr61DqxzGFdUtNggNSYJQzf37cHK5Z7bUwmMBJ0yI7b7qrNT2BXDbtB81cdBqnmtMtX4OTePNYiUzxC3D9Sv03VEzKn0fdB0GOzar7CuJMFlfvkAP3dJ9o0ISQ4hdMMYjGb2m7IFpWrxGEg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(376002)(39860400002)(136003)(396003)(451199024)(1800799009)(82310400011)(186009)(36840700001)(40470700004)(46966006)(36756003)(40480700001)(40460700003)(26005)(426003)(2616005)(1076003)(16526019)(336012)(44832011)(2906002)(4744005)(5660300002)(86362001)(4326008)(8936002)(8676002)(41300700001)(316002)(47076005)(82740400003)(81166007)(356005)(70586007)(36860700001)(70206006)(54906003)(6666004)(110136005)(83380400001)(478600001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2023 22:21:55.8957
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 48c778b1-ec2d-43e0-7624-08dbb895aadc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB57.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4537
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

The primary patch here is to be sure we're not hitting linearize on a Tx
skb when we don't really need to.  The other two are related details.

Shannon Nelson (3):
  ionic: count SGs in packet to minimize linearize
  ionic: add a check for max SGs and SKB frags
  ionic: expand the descriptor bufs array

 .../net/ethernet/pensando/ionic/ionic_dev.h   |  3 +-
 .../net/ethernet/pensando/ionic/ionic_lif.c   | 12 +++
 .../net/ethernet/pensando/ionic/ionic_txrx.c  | 77 ++++++++++++++++---
 3 files changed, 82 insertions(+), 10 deletions(-)

-- 
2.17.1


