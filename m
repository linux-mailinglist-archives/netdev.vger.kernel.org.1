Return-Path: <netdev+bounces-30377-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 53B6A7870B2
	for <lists+netdev@lfdr.de>; Thu, 24 Aug 2023 15:45:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C2A72815C9
	for <lists+netdev@lfdr.de>; Thu, 24 Aug 2023 13:45:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4D14CA6E;
	Thu, 24 Aug 2023 13:45:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90599100C8
	for <netdev@vger.kernel.org>; Thu, 24 Aug 2023 13:45:27 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2043.outbound.protection.outlook.com [40.107.223.43])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DAB11FF0
	for <netdev@vger.kernel.org>; Thu, 24 Aug 2023 06:44:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MXGsSPwPuBSk4H48Aj7BL2LmfLR1m9vsQ54IAzN7eVacpe6A2O3nJpt2ChI73GBoPaVswBViGrKF3eA1WzLPNZd5YcOwL3TKNwfKhE1KE4frjCfzXmP8mK0X8MdGvaJIM9piedwriLaMAok9MGQIm+jE0VlWHM7hFHgG5Lf9QGgnyZKeJqfCzOcTqcsFHPOqF5LcouUTbDuwlWZH56FEeQCtfJ0jTeo8JTYPkxzT3dYPEb187jMt6RMduJtQvRYqef03DFuMOk7l1ufBlfmOiyY/957kVoF9HLNLgyNE5Vo6UYdr3lDlMvdHl+21tBFHLRmpwcm4uaq3OvjAJbSJnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HhYlZlyf3hnpo5fJo7F/pYl9dtzTUvEvzlKv8peR2yM=;
 b=aAnZlfWenJLU1S1EZmmTCdg19T5hsltlNS636b+AIVeybKnFW63zrCnX1wSPUBE10aSMOAY+BWrMBgtukbXBAzwPisWLf725tVAnSaM6Y3uXGWq7ltGNQud1ntJtHNSFoZGbpC34/XYFvZfIGF4VQO39zHhvja34g7U8keLcWHuY1y8tVXQtDP7Gys2NLc5ULIsNEUSRYNcdcO5gvukHWaasN9MlRV095QgkCvmg6R6gSmVyZ/uKlGnD5oPtlsQFk9XT5qHrdc16Kx33U+zuVZvH92KYqkNJqI3isPPRhC5DPSMhmkbYB9DhatuTg9sxpopPBmMknzVsNB3/iUyg3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HhYlZlyf3hnpo5fJo7F/pYl9dtzTUvEvzlKv8peR2yM=;
 b=mMMpI/rOVZk8y4CqA+xdpJDY1H2giE2zEnvJu0TIcTDN4xVb9sOPVnpRb0bv/A5ooWuo5AV4zVa2NJaq3B8YWGj8dQzZYKxPHbJzLdzBWiEMoW7yPkte1Y7jRnNFePOXWPyt0z1TtNf8L7GJrhCf4s4T4C/2vMoQV2lFRBgowuXkUd0L3jsbK0WIXoAGoBgVYfuyXDKEoPBW8XaSm/rmfjOEbnpnLFyjCkmAR7L254MZTavtsKFxgaX+GC3L6CirUrv75/pK5pP+mpZ8tNEt5SjLjSGgNy7TB3VunFf01x/Mk1tiJbDtZinu3YJQJsDWHI+8HVzXuVLsaEhJv2sZoA==
Received: from CY5PR13CA0015.namprd13.prod.outlook.com (2603:10b6:930::24) by
 IA0PR12MB8837.namprd12.prod.outlook.com (2603:10b6:208:491::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27; Thu, 24 Aug
 2023 13:43:53 +0000
Received: from CY4PEPF0000E9CE.namprd03.prod.outlook.com
 (2603:10b6:930:0:cafe::8) by CY5PR13CA0015.outlook.office365.com
 (2603:10b6:930::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.14 via Frontend
 Transport; Thu, 24 Aug 2023 13:43:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000E9CE.mail.protection.outlook.com (10.167.241.141) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6699.15 via Frontend Transport; Thu, 24 Aug 2023 13:43:53 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Thu, 24 Aug 2023
 06:43:44 -0700
Received: from yaviefel.vdiclient.nvidia.com (10.126.231.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Thu, 24 Aug 2023 06:43:40 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>, "Jiri
 Pirko" <jiri@resnulli.us>, Vadim Pasternak <vadimp@nvidia.com>,
	<mlxsw@nvidia.com>
Subject: [PATCH net 0/3] mlxsw: Assorted fixes
Date: Thu, 24 Aug 2023 15:43:07 +0200
Message-ID: <cover.1692882702.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.126.231.37]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9CE:EE_|IA0PR12MB8837:EE_
X-MS-Office365-Filtering-Correlation-Id: 286c037e-6cf9-4faf-c5e5-08dba4a827ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	yGwBU53Wv7iWnAb6Pqi9Mjd/s+bWKvdNd0wu8L4Occp6qcLvO4JVPQfRIaVIy6hneymwVt1lBbQ7yQDzvhr4GV133xOpuOA7yFoSeJKT7yO4vybCDPsAz2iVZ3cyJCVSCRaC2njsINsfbAAImvx97E/COsHm7PXbC1o9s5HPDX5sM4hdoYqebMfcbX4seUHPDHO6qypNifr7fKXqgvbgjQ2nwLb1K9SHbho7a/JLcW0E/1TagP026lI09i5RgR3WFJkMb8/yOK+S0U1OjYlsN/6dCWAHtCs5tTZ8qUGbBGS2Xz+UgEGccAxPu2ded6QzBWYAhZXDUs4s0C4I29e+zukfUUG1zC6JkClrWGs95KtyPNl4xU3Uus9yicJmqFg3FC1ZwbvesyWYLd6Qd/v+PzfzpecCeGesVqvr0vnslaTSN17KmEh8tvla/9fFYtazonIG4aprzWIJfG23iRFU2LFydo/ZBDMHQXvyriM/Ua9AkAYsiJhgOXTs69/JQOmgQ1/e2aEt5UZJBUF4slpj3FXKnYIbBITGwKgycW3Yhh2YwbWq1CjEcq0n5IldVszEKEVjRQrVVOzv4uwmxeauQwL3ehvcO9LiSzaM8l0hTGLRN3FQykoFt12S/9HjTjTPQWSspivCZssx0Z2Xb2eLva+mC5p2/iUkvwHMvx0iaidKW7Q51ze/+Ca+/AyLTkS5xb3CvHF25QVWqU293VqRc/X+pm0xOyeGXmRHA/V58W/TmyTKgSaR6u3WX39BgiUw
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(136003)(376002)(396003)(39860400002)(346002)(1800799009)(451199024)(82310400011)(186009)(40470700004)(46966006)(36840700001)(86362001)(82740400003)(356005)(7636003)(36756003)(40460700003)(7696005)(6666004)(478600001)(5660300002)(70586007)(54906003)(316002)(70206006)(2906002)(4326008)(110136005)(8676002)(8936002)(40480700001)(26005)(16526019)(426003)(336012)(83380400001)(36860700001)(47076005)(4744005)(41300700001)(107886003)(2616005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2023 13:43:53.2915
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 286c037e-6cf9-4faf-c5e5-08dba4a827ee
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9CE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8837
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

This patchset contains several fixes for the mlxsw driver.

Patch #1 - Fixes buffer size in I2C mailbox buffer.
Patch #2 - Sets limitation of chunk size in I2C transaction.
Patch #3 - Fixes module label names based on MTCAP sensor counter

Vadim Pasternak (3):
  mlxsw: i2c: Fix chunk size setting in output mailbox buffer
  mlxsw: i2c: Limit single transaction buffer size
  mlxsw: core_hwmon: Adjust module label names based on MTCAP sensor
    counter

 drivers/net/ethernet/mellanox/mlxsw/core_hwmon.c | 3 ++-
 drivers/net/ethernet/mellanox/mlxsw/i2c.c        | 5 +++--
 2 files changed, 5 insertions(+), 3 deletions(-)

-- 
2.41.0


