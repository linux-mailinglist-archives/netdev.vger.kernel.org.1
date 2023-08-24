Return-Path: <netdev+bounces-30379-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 315BF7870BA
	for <lists+netdev@lfdr.de>; Thu, 24 Aug 2023 15:46:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90EBF2815D8
	for <lists+netdev@lfdr.de>; Thu, 24 Aug 2023 13:46:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 988F7111A5;
	Thu, 24 Aug 2023 13:45:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CFA41119C
	for <netdev@vger.kernel.org>; Thu, 24 Aug 2023 13:45:33 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2047.outbound.protection.outlook.com [40.107.244.47])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF9E119BD
	for <netdev@vger.kernel.org>; Thu, 24 Aug 2023 06:45:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FB6idi1zH3tN87ReGGD7nkHsdmpYtpYnhcaQwWlkmoIeGCNnv2NpvvREjuUqUuBrE+mTlX/JQpwIlkFHxfwJhY5mGgv3DVrCJ1EeYeFMrAqKx2nAznKGuLTwgW6njWV7ueCk1NyG6SbPhS6nrbXJH7DHVyqvQdy/9wJEN+pNOnmXgRhni0HU3+tauBOrfvCGX0gsQVW+CUYJs+5i1h4QFetkhhrf8sKTfVBysHlKfFMaCKRydm0JJlLoK3lJb7/ckUoTHYCZRrvPokk8BIBlGUMw09SmqLKO90Qt2yl6jNoBJ4AaN6vZy3LTwh4+5OQ44qKZsyqOx92AM3XwwRlTxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qLjjFyzLjJ5F2l0o/806PHhEJz9dt3ywOHAjvyBmcdk=;
 b=oKb+35Ej8jmn6NV+lBz+ObtQEbqM038EnUKy63gjhK3TGa3im5ClLomrBn33mZE8Erk4R21US/9UOS5AjFgYlPNFF4Ukp1rcP06Xs3d4pre63No0S41Y9z7gJZZLrm2Ia3F+heO8uMwkDMUQpC5IEZl4nkOnVIm7epchG6bB5agbyQN8Sq8xCykoaFoC3HL7MTLFnK/WPNDKx2l7CQToAG4nau4uX5Oqbm/JGEvLk5QBH2hYg/3Hxy2/2dDIMa+RN7R8As/nPhZ0n9RP2yshCiqkL+w7qD5MmfdumsYyZ3Hyddtx8EURLQDGy5F75GBSm54emUu2tDlsmGyWgIwTWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qLjjFyzLjJ5F2l0o/806PHhEJz9dt3ywOHAjvyBmcdk=;
 b=B2HlTJUzs609qeU+8RDxgeSxM8cUZfomz8sm45vPTENF6yT0a3hfiSj2d99oauH9ivNHrlpUVmlqe2lLPxbwhOHcGpaakg/H73THaw6+2ZKla0POG7J806SDjg1J44sJk8usGqqD8SHpOXXwkdWzIoi2XkE8eSQRv5mLzeIIFA19/TKG9YV9ojFbCjB+x1D6Dw2wi9GKWTOC/iihuL+zaMGBZsFWVnYJIlxPsJQ7q+hIhWaYZw4wGRhkZ4Amc5D0bDrLhEYU8juZ2baZvxcymp3htN6u5JRLiwpl3+bct67HoHWmQy4KwPJlzxK7BSl6GhvcN3pVGGVwl4PXL+BMwQ==
Received: from CY5PR13CA0030.namprd13.prod.outlook.com (2603:10b6:930::18) by
 IA0PR12MB8373.namprd12.prod.outlook.com (2603:10b6:208:40d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27; Thu, 24 Aug
 2023 13:43:58 +0000
Received: from CY4PEPF0000E9CE.namprd03.prod.outlook.com
 (2603:10b6:930:0:cafe::c2) by CY5PR13CA0030.outlook.office365.com
 (2603:10b6:930::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.14 via Frontend
 Transport; Thu, 24 Aug 2023 13:43:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000E9CE.mail.protection.outlook.com (10.167.241.141) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6699.15 via Frontend Transport; Thu, 24 Aug 2023 13:43:57 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Thu, 24 Aug 2023
 06:43:49 -0700
Received: from yaviefel.vdiclient.nvidia.com (10.126.231.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Thu, 24 Aug 2023 06:43:44 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>, "Jiri
 Pirko" <jiri@resnulli.us>, Vadim Pasternak <vadimp@nvidia.com>,
	<mlxsw@nvidia.com>
Subject: [PATCH net 1/3] mlxsw: i2c: Fix chunk size setting in output mailbox buffer
Date: Thu, 24 Aug 2023 15:43:08 +0200
Message-ID: <5745ac4931a39021987addbabd38ca9aec0ab4dd.1692882703.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1692882702.git.petrm@nvidia.com>
References: <cover.1692882702.git.petrm@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.37]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9CE:EE_|IA0PR12MB8373:EE_
X-MS-Office365-Filtering-Correlation-Id: 9bca2301-84b5-499f-1bb1-08dba4a82aae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	8FmoqQKDjQ5esvxQ+S/YnhaX8k6xBxBREMjJM+Nw4iCSgzpyRYMeMbuIVY6NLHR1KBkOLw5OK6bpgUEd7FZWsK3wVbGhZJrIhVRRHzUFX4srNEu9J1oBkvYHCEdK224/FULRR98VqaYR9abk1v7VEGYCTcy9pV4d6m6HcFbrm8A/XS//VcF75wRHjY6jbubG/VCy+cgIZ1MXPJCM0bXPeTWgKLeUJsZZk2zITHtEN5oPbp6Ts3IpmoW/NAs4CWziYsntow9C5l+N3gMNWRoRtDoRVSaguoC9zLFfeaRgWnBHKeGZvBsUrVIra66KfuIDz7uUpnZoLHM/7PdKzGaOpQmdq6G0m5AyghqV/Qrvx+NLMhabeBG2Dt45mCrzndpzfuz5QyGYFrEAW7BO++i304UKm+jTozAU5iLC+pgZ+Gcwz2/toRP1GoPVF+CcSqr49WYYpHC5GWfFyzsxUvvzfp2mF3c0h2ZXdbdTBBtI3zbKJ8cW+xRd0jDSi9MH+oiMEyevCHspukT7uBdP53HZNqUF+EwzwHUXKrcAiv3C9dkNQtRdmIKorbRApOCrAW/EoW7XSMjTzUpcgZFnTIVWq4VLGRXDA5o2Fgf7LeOjpTKCLPVd5NJgGArNbPzkfNlemi07FtCgmj0NnejWz1b3PCuMy6Z/5cXTCWT1bbemUAtW3LsmSgoA8Rc+JrYbYx6GBdf7Aywbn24vWYSZIzqvYJgqX0pllJNbWLg3gW1I+9EOFbU9Cr5ofBIY/BLmm4f2
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(346002)(376002)(39860400002)(396003)(136003)(186009)(1800799009)(82310400011)(451199024)(46966006)(40470700004)(36840700001)(40460700003)(2616005)(5660300002)(107886003)(8676002)(8936002)(4326008)(336012)(426003)(47076005)(36756003)(83380400001)(15650500001)(7696005)(36860700001)(26005)(16526019)(40480700001)(82740400003)(356005)(7636003)(6666004)(70206006)(70586007)(54906003)(316002)(110136005)(478600001)(41300700001)(2906002)(86362001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2023 13:43:57.9009
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bca2301-84b5-499f-1bb1-08dba4a82aae
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9CE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8373
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Vadim Pasternak <vadimp@nvidia.com>

The driver reads commands output from the output mailbox. If the size
of the output mailbox is not a multiple of the transaction /
block size, then the driver will not issue enough read transactions
to read the entire output, which can result in driver initialization
errors.

Fix by determining the number of transactions using DIV_ROUND_UP().

Fixes: 3029a693beda ("mlxsw: i2c: Allow flexible setting of I2C transactions size")
Signed-off-by: Vadim Pasternak <vadimp@nvidia.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Signed-off-by: Petr Machata <petrm@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlxsw/i2c.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/i2c.c b/drivers/net/ethernet/mellanox/mlxsw/i2c.c
index 41298835a11e..47af7ef7e4ee 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/i2c.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/i2c.c
@@ -444,7 +444,7 @@ mlxsw_i2c_cmd(struct device *dev, u16 opcode, u32 in_mod, size_t in_mbox_size,
 	} else {
 		/* No input mailbox is case of initialization query command. */
 		reg_size = MLXSW_I2C_MAX_DATA_SIZE;
-		num = reg_size / mlxsw_i2c->block_size;
+		num = DIV_ROUND_UP(reg_size, mlxsw_i2c->block_size);
 
 		if (mutex_lock_interruptible(&mlxsw_i2c->cmd.lock) < 0) {
 			dev_err(&client->dev, "Could not acquire lock");
-- 
2.41.0


