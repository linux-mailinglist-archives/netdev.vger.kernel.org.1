Return-Path: <netdev+bounces-35869-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF1D37AB71B
	for <lists+netdev@lfdr.de>; Fri, 22 Sep 2023 19:19:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id ADC652823F0
	for <lists+netdev@lfdr.de>; Fri, 22 Sep 2023 17:19:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58CCF42C0A;
	Fri, 22 Sep 2023 17:19:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B39FE41E4F
	for <netdev@vger.kernel.org>; Fri, 22 Sep 2023 17:19:16 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2069.outbound.protection.outlook.com [40.107.237.69])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5F2C192
	for <netdev@vger.kernel.org>; Fri, 22 Sep 2023 10:19:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ciE1s62QhwQyR2JSViltqJekUEHehCEjQlge6r0S5B4PLcjt15czLgY2KhpX5Y+8QpPHYF6Nt0M+XpBFfoj0zKjmvVFiE7zB88i5gLb/+d7Y4y5v/LcNw4kVOQwF6jIcMElfEwsAE7T0lrKEDFCPz1n/zmitHurAP9xjP/+ieRyBqHAW/2VHNfmh8wgrzyFVlzWTreaCm/0wbnNTldehHu+1KU9JZqFc+HnYyGr5NQR7rdFsHU+MMZrmpoj+bRnpN7M3juZuGeZu9w7HO6dBjxc9my1NZASzjIzxs7opBeSUl2998eKwLB/JtTFLeRKJUuBhJepEuf4g1/Ont2Hptg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OPwqfz061KchZG5jCGjb22O+TqkX1LxVSNllRI/KkvQ=;
 b=byGWZ2AuEzHZ9yRmE4W9uTuZAEsWgsG62gPl7/q7IF1RLebVg5jHzwaCnhDuqOEHEm//L8QMlOJ2EAHddS8A0USVmnhxPt9eDiTHFuKK85OLYY2L6lkbmkcImwUGrhEt6wDnbaq0B35jZgNToLKII3DRPOeATun5FeQLRHiAcXcFtzqxATBOZnbbguWy2mBvret1w/C+WHk17egkXi5Ommw4hzU5Lak33GBZZBrQub7aoBiHvNyxR61i1+NQIdAUC0wfSu/8rekYNqjp2fHfN3bu6gycLzarDXnyjToj5ffqKPv1mECSPhJUx3y8l3vsiHHbPpkATCkdjpM7JfE1vQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OPwqfz061KchZG5jCGjb22O+TqkX1LxVSNllRI/KkvQ=;
 b=YXYe0QZCDXcLUXiQIDjMLxXfd7h2KpS9LcMz6B0+4qGvz0H0EnZGJX/wCGsixyUV+4tDWpfHnv13CnYJFrGRvE1sM5S3pzEuJLuvC24ysGfhopBIf8+vsruV3k6zmDQa4vnG8t9faJLCh2rHNhNZFrf/cTeknB928ubgn64vxbURiVZ1DgutCfsICDX8aVAqFyypCARwAyFFl57zyWzqLGvtBqY9h4GXdNlyqYASd1YZjOVhXtgsvGWNfkTPda9elr6rMXiDR9hco69PtJ50Ly/syn+lEO+9BS4ah+dgnTdLHZnB6x4IVLOCYJ4O88BPYOagszspNSw5RuTwrV/aDg==
Received: from MW4PR03CA0016.namprd03.prod.outlook.com (2603:10b6:303:8f::21)
 by CY8PR12MB7490.namprd12.prod.outlook.com (2603:10b6:930:91::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.20; Fri, 22 Sep
 2023 17:19:14 +0000
Received: from MWH0EPF000971E7.namprd02.prod.outlook.com
 (2603:10b6:303:8f:cafe::c9) by MW4PR03CA0016.outlook.office365.com
 (2603:10b6:303:8f::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.32 via Frontend
 Transport; Fri, 22 Sep 2023 17:19:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MWH0EPF000971E7.mail.protection.outlook.com (10.167.243.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.14 via Frontend Transport; Fri, 22 Sep 2023 17:19:13 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Fri, 22 Sep
 2023 10:19:00 -0700
Received: from yaviefel.vdiclient.nvidia.com (10.126.231.35) by
 rnnvmail202.nvidia.com (10.129.68.7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Fri, 22 Sep 2023 10:18:58 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>, "Vadim
 Pasternak" <vadimp@nvidia.com>, <mlxsw@nvidia.com>
Subject: [PATCH net-next 3/3] mlxsw: i2c: Utilize standard macros for dividing buffer into chunks
Date: Fri, 22 Sep 2023 19:18:38 +0200
Message-ID: <2a8f7484a7e5974279f2fd64eb4ad8a40da89c61.1695396848.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1695396848.git.petrm@nvidia.com>
References: <cover.1695396848.git.petrm@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail202.nvidia.com (10.129.68.7)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E7:EE_|CY8PR12MB7490:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a1f5f33-4d0b-472a-1491-08dbbb900b16
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	VTreyiUZWIf0TR+6+RsSTG1H0QTfj0o3QQXFF7CD0cPK2/JJVV4bXVYz/Ws+kaZk7jQhS4yHi/bvG6vUFm92/qQbJZgAt19zmI6L2DNT3HJaJWg8v8YBb2Y/3F62Wfi595hIOEXpVLrYF1n6eJ6Z/Z3OKYbaSoDa3mC3Hm5aoZZmf0hHl131wn1v8xbFPJX01LSQlUWoCAP0HR1vH+hPFoZ4riss8Noc0qFdNc4v5bNEMfqPTjou0AE42v9va/nkyhFPigulcZ4uliNdVXMqWhJjsQxNNz0oK8bUXzG9zxOEZkLKQJ/pIX7Y8YuG41mBddlywtLhNMOFruHl8CeHcCC5Yy2FBiBgqygNaKpxC4xfXLcxu/1JbkFYAi4u3RcLQoR4iFK4stSXGXGpQOcS+582YzyUq3BvRONZ6awN1qBJthYHBe5uGtF44ljXrzvTOtHpy8KdvHqAR6C5YXJ+ZWSxwy9SFGQE2lrU2/rQYrUtfMs1HO1qblrlfwMWVNmueyfjrYKpq+AA7Eri7X6VuVtyfIHEfNYluPGYAAlz3aymuw6ieDkZt/uPof4a1mtH4lAObQwztLBa00qyG3d3ZFGevlJhD/PP9IuQiPn+WxZJS5FuJxADBdqnKeEGm2RsG2w4JoBm+fsYB45NprdxzyuxugJsNLBnZbcMBHVbPQk5quHlIHZOgcj4yKbo7s5RMzZg4C9FiJDgE4HnyaNQNQF/ZrbcaAlOTgDjFaFKET2+Hfr300OJyvN05if9BCNyek+1jJm2XwWSfwfvOx5LbA==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(376002)(396003)(136003)(346002)(39860400002)(1800799009)(230921699003)(186009)(82310400011)(451199024)(40470700004)(46966006)(36840700001)(70586007)(41300700001)(40480700001)(86362001)(5660300002)(8676002)(40460700003)(2906002)(4326008)(8936002)(6666004)(82740400003)(7696005)(426003)(16526019)(7636003)(478600001)(356005)(336012)(47076005)(36756003)(36860700001)(26005)(54906003)(110136005)(70206006)(316002)(2616005)(107886003)(83380400001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2023 17:19:13.7332
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a1f5f33-4d0b-472a-1491-08dbbb900b16
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000971E7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7490
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Vadim Pasternak <vadimp@nvidia.com>

Use standard macro DIV_ROUND_UP() to determine the number of chunks
required for a given buffer.

Signed-off-by: Vadim Pasternak <vadimp@nvidia.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Signed-off-by: Petr Machata <petrm@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlxsw/i2c.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/i2c.c b/drivers/net/ethernet/mellanox/mlxsw/i2c.c
index d23f293e285c..1e150ce1c73a 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/i2c.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/i2c.c
@@ -424,9 +424,7 @@ mlxsw_i2c_cmd(struct device *dev, u16 opcode, u32 in_mod, size_t in_mbox_size,
 
 	if (in_mbox) {
 		reg_size = mlxsw_i2c_get_reg_size(in_mbox);
-		num = reg_size / mlxsw_i2c->block_size;
-		if (reg_size % mlxsw_i2c->block_size)
-			num++;
+		num = DIV_ROUND_UP(reg_size, mlxsw_i2c->block_size);
 
 		if (mutex_lock_interruptible(&mlxsw_i2c->cmd.lock) < 0) {
 			dev_err(&client->dev, "Could not acquire lock");
-- 
2.41.0


