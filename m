Return-Path: <netdev+bounces-35887-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EDE37AB7C4
	for <lists+netdev@lfdr.de>; Fri, 22 Sep 2023 19:36:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 0D6522823CD
	for <lists+netdev@lfdr.de>; Fri, 22 Sep 2023 17:36:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4754243695;
	Fri, 22 Sep 2023 17:36:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F372E27709
	for <netdev@vger.kernel.org>; Fri, 22 Sep 2023 17:36:45 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2050.outbound.protection.outlook.com [40.107.244.50])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC2FE99
	for <netdev@vger.kernel.org>; Fri, 22 Sep 2023 10:36:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GoHroSlPfc6gOBX1Xu0+M5HMNsyV/dPrD3B2F63OuWo51ZkPrBzB0Sa+4D0DzGNru7U9mvrQkNRQmlBQW3V8znLE5uvKkecPJQwSbXKpih7YSGE5+JWSIuXbdmHF5mh8lOVnS0DgPEBeEMtM/9aGi7zudLEcaaDph3nx3zwmDmuJxLJ+KbwxsBFFZn619ekcAglNBr4+wFIHRS+C7Th43m9KqXGeAOX7KUbFlHaje12hTKvWpwL3Tqsa3V6uRNiqwRi5MKcMRQhBxup50BvGzu9USHLh6pP8kRYWdhZHAwsm1gDbfpaJomNBI/o+qHm3haTZsoGkJJilVyJ+KnKFxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rbhoxe3OJr34treS7r5gN2Y9H4xUNFedSiFk50rIDYU=;
 b=Uan7gmSMr0kf7E/npXgzL4S6VoJ36P8VzQcl+J23xjfNLiqP4aMmauHgK4ONApzXuhvWvwtfUT9j3Q28GPrSVTGPk65q0MQiBwBhImMGIAYAWRYwAuY0pNrxVrruiv6G34QBkHhs5sWBEpYTiHgfDc9ckSSn4EQiOgXPFvUX3Bl+cZ1KDg8gYrBHM4b4WwirKOaP1oCUEefYgw6I4hvlea0ERbctpbeKF1pijtnnpVnuvs9AdxISEg+bG+y8v+yUx3Bn2a+3NACd8J/NonKugvqqsfZQydCZd3Mictlrh2YM185HZLD+0isJ4uPvn7RXBEDWn8SCBC1ySI/NIjH6YQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rbhoxe3OJr34treS7r5gN2Y9H4xUNFedSiFk50rIDYU=;
 b=qbkwWy1SxQbYK/pwHWIx250NlpsOXZLvyz2tPpbBOGxGReZS4t7F++hdjeQHIFRgN7O6KqTHuzTtElpFLcAh8clp4QZ3qbL/DyGU8fGwGZnjDbfXAc9zQuEOzhuoMXXbL9LH184KqMrUiMJDae4vyTPbHGHDGCJDojfKbnxqAgwPlR5IhhDv3HbnmgcmgG6bsJYIgYBLV//YSpI2g2KDlqgg/UEyFOozU1HrUUavWhAv9uluMqbuKcq6O+FkB1Yy3B4jBEGCjr1+AyxheYeJ6xwzSKoF4nUDiUSRCNkiTTg6g7zzDIJ8WDYJUelm6czZZQwTP8oLr/WsYYqmJy+/vQ==
Received: from BN8PR03CA0036.namprd03.prod.outlook.com (2603:10b6:408:94::49)
 by SA3PR12MB9158.namprd12.prod.outlook.com (2603:10b6:806:380::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.20; Fri, 22 Sep
 2023 17:36:42 +0000
Received: from SA2PEPF0000150B.namprd04.prod.outlook.com
 (2603:10b6:408:94:cafe::8) by BN8PR03CA0036.outlook.office365.com
 (2603:10b6:408:94::49) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.32 via Frontend
 Transport; Fri, 22 Sep 2023 17:36:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SA2PEPF0000150B.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.14 via Frontend Transport; Fri, 22 Sep 2023 17:36:42 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Fri, 22 Sep
 2023 10:36:30 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Fri, 22 Sep 2023 10:36:29 -0700
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.986.41 via Frontend
 Transport; Fri, 22 Sep 2023 10:36:28 -0700
From: Asmaa Mnebhi <asmaa@nvidia.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <olteanv@gmail.com>
CC: Asmaa Mnebhi <asmaa@nvidia.com>, <netdev@vger.kernel.org>,
	<davthompson@nvidia.com>
Subject: [PATCH v3 0/3] mlxbf_gige: Fix several bugs
Date: Fri, 22 Sep 2023 13:36:23 -0400
Message-ID: <20230922173626.23790-1-asmaa@nvidia.com>
X-Mailer: git-send-email 2.30.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF0000150B:EE_|SA3PR12MB9158:EE_
X-MS-Office365-Filtering-Correlation-Id: b4f94a97-99a9-4227-c06d-08dbbb927be5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	NWvHX9/ciDauP3OvctQXwpM7G0ehHR0Um0UlFE3VNg1lDzVMlBiDInlaPsEt+XY6jO76NejTC+Ljgg5WytC3APJm9sDA7cvDBvMaKgwDf6Dc2OK90gDynRNt8FY5X+bK0huDyVAQNP2aajc7Ja8KqXfnplQCCTkm7wifSG4C42e0Ly2wes1zj/W1jlRZ9wcbFQkEWtkmmXKZFiGdlJ14cEt0YNwLLJcc/uVXKoCQCbc0TqRsYqwcCNIjlFkzK44S6r0WTT7iONUszW4Tpk5LidevZBOY9oQYvS2nfbzu7gy270uj2nww0D73uuTbk8GqHWey/aGbIpl8Uj4YOXlCdlZut4FaCohTjwahoAB0z3eM0r3z8jaOTWwWN2vTBiCtdAPtxSUIVKiqFcOYvUvgB+KmsKGtJEwKHoh+MJZnxSJ7mTGZsMd+pvUbr6zc2xpsbcfKRQxRGaSAewFGxDfgXtNxpyQTJ2DcaoZEpHdcBuSgkAUonIEZ3UxToMCvHwGgHuGE4GY6WTAszoZMNJSr81Hf+3V1QXPJlnvWi5R1Zzt4piG1sstGg9AFG/RQh9tED2ogNlKLwGK9zEZBA+FuGaiStAziDB2PCOt933NILdwg8OUoDQHm7KpOWAXI/NvjAV4Rt1lY4vR+7yHZSsN09AoT/qF5yQDSTmbwMX7aVnWIJF3GBhNrjL6YnCIcvFU3LYpadANFW7TMqqcPUkaTZ4kO7z4COOH82WgAniitb819uS7hj0rxQly1ke6pUmGcgveWELh4Qh5/lDx+85rRhw==
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(136003)(376002)(39860400002)(346002)(396003)(82310400011)(1800799009)(230921699003)(451199024)(186009)(46966006)(40470700004)(36840700001)(7636003)(7696005)(6666004)(110136005)(478600001)(83380400001)(26005)(426003)(1076003)(4744005)(336012)(107886003)(2906002)(41300700001)(70206006)(8676002)(70586007)(40480700001)(4326008)(5660300002)(8936002)(82740400003)(54906003)(316002)(36756003)(40460700003)(36860700001)(86362001)(47076005)(2616005)(356005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2023 17:36:42.0081
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b4f94a97-99a9-4227-c06d-08dbbb927be5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF0000150B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9158
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Fix several bugs in the mlxbf_gige driver:
1) panic at shutdown
2) no ip assigned although link is up
3) clogged port due to RX pause frames

Asmaa Mnebhi (3):
  mlxbf_gige: Fix kernel panic at shutdown
  mlxbf_gige: Fix intermittent no ip issue
  mlxbf_gige: Enable the GigE port in mlxbf_gige_open

 .../mellanox/mlxbf_gige/mlxbf_gige_main.c     | 47 +++++++++----------
 .../mellanox/mlxbf_gige/mlxbf_gige_rx.c       |  9 ++--
 2 files changed, 28 insertions(+), 28 deletions(-)

-- 
2.30.1


