Return-Path: <netdev+bounces-42274-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0461C7CE050
	for <lists+netdev@lfdr.de>; Wed, 18 Oct 2023 16:46:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 866AA1F22F10
	for <lists+netdev@lfdr.de>; Wed, 18 Oct 2023 14:46:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92E571E503;
	Wed, 18 Oct 2023 14:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Gk8htHfo"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC6B815AD8
	for <netdev@vger.kernel.org>; Wed, 18 Oct 2023 14:46:15 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2062.outbound.protection.outlook.com [40.107.223.62])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71BBA95
	for <netdev@vger.kernel.org>; Wed, 18 Oct 2023 07:46:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gSnn/qapt3vaz+WsuzDzJ2Sth5Ct9kvXOg4983e4Vg8h1SXr5MWb7gIA7v2vEeX9TeD+fRUxSDMPIxTQGPG8RbXg9d9rWK2ACOtDleXvUf3mcUiIixN60sAHMPv731srGjIr7TeX6pUVcagHKjL8/VvfyKiTDO5kJeesIt++Iuz6ZvLpV2tAsupatLrnJd16p8hDI44R5ReybEgJqLVLKdhnfDTUHQ4n+tS3B2DdDJN1X5cfTvj6p+RYC7HSBOg9IhIV6peaVz31kw7WaKgZoBQFEwq8N58XYdBo23yfZVgxTTa4+LefbzO6dmmptr/rdJQkw3ikpqOginncizK+yQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PEAXZPblnjU/Jyz0qkeRwZyWEuwH6BR5Hq1X+zLmtI4=;
 b=WqlRSQgG8+JofmU7HFVkabmpD+7aG9KLfTSsMc52M5ceDG+N9efiJqeds9ChFKNrK5MFP9zo7N+CmYu38SOiNwW6jE2pknviPmyKinv2OopLdyZ7PpV/Fdvs5W1XiRx9hVw1CoAv5wtAaDO/V0sAN5DIcU6sPupA+0HWdC3a/KiGzdXloOLwxktlRnEQDw+Rr/yDLEtX4DAw+QMiUpfQVkqd/qcl8Td+FEc89wDayilo/RI/h1RhUbrfD3aBV9/BlUEDRzAHDiy7Bx4+JG+A8jZ+gpW5jF61xSwLnafa4zyCZR9TAr/4P/9hLI3p7Hs9qiaNqPKZIcBjhmI+I28JMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PEAXZPblnjU/Jyz0qkeRwZyWEuwH6BR5Hq1X+zLmtI4=;
 b=Gk8htHfoupH/cIjfuMakIHbwZm4t1sDmKyHjJXJvbTLfM9W1D2a0NGEr9RwBsP5WcCQlmJv/EBtQNCqrCwqBJ64/fMAchpC3vBZbLKyaINVeqxZmvueZ6Ov7axv8Ry/jwXHUwXKxoI3RMmy+9Rp3uYByVB4oEfjNHkUQCZyVyMA=
Received: from MW4PR03CA0142.namprd03.prod.outlook.com (2603:10b6:303:8c::27)
 by CH0PR12MB5059.namprd12.prod.outlook.com (2603:10b6:610:e2::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.23; Wed, 18 Oct
 2023 14:46:12 +0000
Received: from CO1PEPF000044F7.namprd21.prod.outlook.com
 (2603:10b6:303:8c:cafe::1d) by MW4PR03CA0142.outlook.office365.com
 (2603:10b6:303:8c::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.21 via Frontend
 Transport; Wed, 18 Oct 2023 14:46:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F7.mail.protection.outlook.com (10.167.241.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6933.4 via Frontend Transport; Wed, 18 Oct 2023 14:46:12 +0000
Received: from jatayu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 18 Oct
 2023 09:46:09 -0500
From: Raju Rangoju <Raju.Rangoju@amd.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <Shyam-sundar.S-k@amd.com>, Raju Rangoju
	<Raju.Rangoju@amd.com>
Subject: [PATCH net-next 0/2] amd-xgbe: add support for AMD Crater
Date: Wed, 18 Oct 2023 20:14:48 +0530
Message-ID: <20231018144450.2061125-1-Raju.Rangoju@amd.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F7:EE_|CH0PR12MB5059:EE_
X-MS-Office365-Filtering-Correlation-Id: ad346c11-bfd6-4550-29e5-08dbcfe8f931
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	xonIR0hDDWn0RfhBeLMw2tlyq8m4rt+J44kAz7yQnmiXqPOsg1Iglfsoa9e4K/I7y4C8wfRL9lheB4UMa1DNFmO5Co62NQD3cKl46NOt09XTzxqhFSyq1T6YkHBaYXjp6MaXT62DB2GaLpY4lwiSvrtzhNVLTxbJaeDsxFQc0rLkEA8KY1k/0uTh87ROSOhTc7AT6jhEDnHDTXQbILHbXQ2F7naaVJR2H9HbyNhJ4ahtcozL+pwHYoRQR/V0mFNEOSOLkG03oXCMQ/ykI0m9ohVmgxWudZtFPTEXnNphba47yIyUcn9NvmIkMIHgI8curd0xgvYSLpvty8z12AMGETxjxjyRLpb4h2lzhlLfpCWwsGYRwVjzbBPFVljDdZwQXXQmn9RdvvYbpmElwqhc2soZHGadaAyvsmjpMGpCFtNFpETmQ7ZkIvYyn9Eo0acyFLjgf6dexVm0PIXwQgLv+bsDBUR0pPlzac96O6tgMLOMZpZ+fH5GaM0cWTUuFE3/6xavYSAEfQiE5vqnUDB972mqF7XnlerU+7IolAwq9w1JWnLKLqmZ9Buzp+W3DXU1UxcLrR2g36ns4wccBR35o5pjFLKRBqClScTNcWw9oDNAOjS8HxhGOghLkQ0BPbyhc1dXthj0MR38XrY2QoF7F3PfelLasmmZNtVgCQpf+NCIXOKDr2MuKM4jQBBeWB6PaO6n6PirrErE8O+FdWhVaJecOcaae9rLy4tM/LZbJRQJ7U389gVVvgqKwYlGJWmVCpTBe+oq/19AJJ+5WpSKPQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(376002)(396003)(39860400002)(136003)(230922051799003)(1800799009)(64100799003)(451199024)(82310400011)(186009)(36840700001)(40470700004)(46966006)(40480700001)(70206006)(70586007)(6916009)(54906003)(316002)(478600001)(6666004)(2906002)(5660300002)(86362001)(36756003)(4744005)(8936002)(4326008)(8676002)(41300700001)(2616005)(81166007)(1076003)(83380400001)(82740400003)(336012)(426003)(36860700001)(16526019)(356005)(47076005)(26005)(40460700003)(7696005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2023 14:46:12.1761
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ad346c11-bfd6-4550-29e5-08dbcfe8f931
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044F7.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5059
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Add support for a new AMD Ethernet device called "Crater". It has a new
PCI ID, add this to the current list of supported devices in the
amd-xgbe devices.Also, the BAR1 addresses cannot be used to access the
PCS registers on Crater platform, use the indirect addressing via SMN
instead.

Raju Rangoju (2):
  amd-xgbe: add support for new pci device id 0x1641
  amd-xgbe: Add support for AMD Crater ethernet device

 drivers/net/ethernet/amd/xgbe/xgbe-common.h |  5 +++
 drivers/net/ethernet/amd/xgbe/xgbe-dev.c    | 33 +++++++++++++++++---
 drivers/net/ethernet/amd/xgbe/xgbe-pci.c    | 34 ++++++++++++++++-----
 drivers/net/ethernet/amd/xgbe/xgbe.h        |  6 ++++
 4 files changed, 65 insertions(+), 13 deletions(-)

-- 
2.25.1


