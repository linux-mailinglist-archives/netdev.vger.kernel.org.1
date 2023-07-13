Return-Path: <netdev+bounces-17682-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C55B7752AF3
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 21:30:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B15D11C21435
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 19:30:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 267F2200AF;
	Thu, 13 Jul 2023 19:30:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E7931F938
	for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 19:30:10 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2041.outbound.protection.outlook.com [40.107.94.41])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 174D42D7D
	for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 12:30:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fmzEZvAlbyOr9bQZPDrsSlghzMhJ0BMtFtkRGUNKNmgYP03k5UpkKcQdVs4/vfx/8wv9m+p0d90FUAWD151lzwCBQozKwZlu3lPE+L7xcokWIZDtYA94rOe1m5oDlhQEIDJMwns3v0cAzCmxLoQDnjDllJ01yNiJ/wUYtPMzvcCvTeetsXRJJaTRQokZQdX6H2D49l2UcoEv0ZKMTUEzvosI4+I27nyZ9famnNeXa99qhvNiqN0zYDhyskjPxI0KyHF1nLYoKsIRpSfE0AdtDwL5TYRyR006IBiCOW3z521wlafFkfo78+I5yLTdA3qARGomkflQkQi0agsSxiPz9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J1LUvmYZNHbbFvTECQLdP4IK0iaKlGV513FeiI5rqeA=;
 b=PF4x3msuZojQfVEvu0ahEr+355eGTAj6yAPC+qbzcCXKY+rSFoiUvCN1crECW+rJt7sYdHjUNcBLpMxwRPRYei5EaSThvOWE06peDGHNuyTXzKyxzOntKeUME+jZbHcs0/I2xPcGt1sISsYatFIw5UZsKKDf1h96p9r6twAhTjgsNIoxNZziZdMDz7+9a/PsH9wvcFzvYaO0aQxfK/LPBOUDnleAU3p+WQBcTsvfLdLAWXZ7Y2pP9Pq70UY8WCCtzjF76QcVvTZqIsowX/Z6oJHGLQlPIpvEoYyRI8CLxxZBLP402fTIEoSmnL6Unhp9CgzBz9iqq3nFDfa4IcF4Ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J1LUvmYZNHbbFvTECQLdP4IK0iaKlGV513FeiI5rqeA=;
 b=PgAOYeQpQRUn0fUPOe0svqyt+vI4ZcNF+shZRzrM8Ift8YstKNjre6vzkzahpNUYa0ogI2V24e4DzURr8rrFJ38+BR6CIOTDsv5cpYxnavxT2v8iScmdYp/y0O/wLq3keN/C92c8SrzjLH6it0Q1rktX3y8wOdaTkc2X0E3Wcjk=
Received: from BN8PR16CA0032.namprd16.prod.outlook.com (2603:10b6:408:4c::45)
 by CH3PR12MB8933.namprd12.prod.outlook.com (2603:10b6:610:17a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.26; Thu, 13 Jul
 2023 19:29:57 +0000
Received: from BN8NAM11FT076.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:4c:cafe::7e) by BN8PR16CA0032.outlook.office365.com
 (2603:10b6:408:4c::45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.24 via Frontend
 Transport; Thu, 13 Jul 2023 19:29:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT076.mail.protection.outlook.com (10.13.176.174) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6588.26 via Frontend Transport; Thu, 13 Jul 2023 19:29:56 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Thu, 13 Jul
 2023 14:29:55 -0500
From: Shannon Nelson <shannon.nelson@amd.com>
To: <netdev@vger.kernel.org>, <davem@davemloft.net>, <kuba@kernel.org>,
	<idosch@idosch.org>
CC: <brett.creeley@amd.com>, <drivers@pensando.io>, Shannon Nelson
	<shannon.nelson@amd.com>
Subject: [PATCH v2 net-next 0/5] ionic: add FLR support
Date: Thu, 13 Jul 2023 12:29:31 -0700
Message-ID: <20230713192936.45152-1-shannon.nelson@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN8NAM11FT076:EE_|CH3PR12MB8933:EE_
X-MS-Office365-Filtering-Correlation-Id: 066100e9-abe8-4317-04e0-08db83d78a94
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	LTfb0Fa7tiuWU+78v0HTDsfzqGoFj99TlqMuAc5mqrLiNmBVprPsJQe0QY0YMF8opUVsnFysfD7FpWahBlp/6iiQR+00l6ni57Gd2ydjk/Exbr6OQSyqzqavODk1DFyN5jo3uV7sZEgxHSW4tur6VPySCKCbcjOvTUBJl0Ch8AY/cQcuTY/5BAYNYPTmVCUATaALJrKGWu6Irla06FiPoUFtsTHwTjeSNDNI8xPaViWJcpd7F3h9lyHPaH5vwPHhR5exJXTWmCKwNRooXArppFtQktIbY6Ze9wK6DCBlKH6xmNPDFm56r00Ei8vQZEx0d3C7DL5cJP++UqUqRCdd6e/NmooNNVk3fY+LrqmSTsUegRHhDUuiVNXD2x9ciZpJHbFGWn//KiUw9EPZOTfrmNK4WlxKSG/hi6mQc+D7/l2TYNx4AvxMxyDQOuTAWdlKlnM/O+C+woxfWJfphFdzZeDrmSZXT9OrajmLrpE8CAz3cWzssYrRAfPF3lx5R1cirUV4TI2/Yf+s7WOX7cuh6I4+k4ounCj0aEpS02jdiT/Hw/k7DNa/yTzBq5/d7M3tXd5OLq3ckrzQcngiHqhzOyPQ/qVYkRmhrkbzhII/AZt69HrdWLq/qETeK4cVRGx477Noe3CB7aolNhJqnTWUXSdcLp8bU5AnhfAU2IYjqztHRTrO1r45YTrz1ALjcB0n0xaA1wEp6ueg4bdc6xau4jF+OME580l4Ku3zxqNctKfGAWYVQHvUJSzRWd0+dCDODnSRNgAzB72V/k3glmSO7Q==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(346002)(376002)(39860400002)(451199021)(40470700004)(46966006)(36840700001)(36860700001)(36756003)(82310400005)(86362001)(40480700001)(40460700003)(81166007)(82740400003)(356005)(478600001)(110136005)(6666004)(41300700001)(8676002)(54906003)(44832011)(5660300002)(2906002)(4326008)(316002)(70206006)(70586007)(8936002)(2616005)(4744005)(47076005)(336012)(426003)(26005)(1076003)(186003)(16526019)(83380400001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2023 19:29:56.8752
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 066100e9-abe8-4317-04e0-08db83d78a94
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN8NAM11FT076.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8933
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Add support for handing and recovering from a PCI FLR event.
This patchset first moves some code around to make it usable
from multiple paths, then adds the PCI error handler callbacks
for reset_prepare and reset_done.

Example test:
    echo 1 > /sys/bus/pci/devices/0000:2a:00.0/reset

v2:
 - removed redundant pci_save/restore_state() calls

Shannon Nelson (5):
  ionic: remove dead device fail path
  ionic: extract common bits from ionic_remove
  ionic: extract common bits from ionic_probe
  ionic: pull out common bits from fw_up
  ionic: add FLR recovery support

 .../ethernet/pensando/ionic/ionic_bus_pci.c   | 167 ++++++++++++------
 .../net/ethernet/pensando/ionic/ionic_lif.c   |  72 +++++---
 .../net/ethernet/pensando/ionic/ionic_lif.h   |   5 +
 3 files changed, 165 insertions(+), 79 deletions(-)

-- 
2.17.1


