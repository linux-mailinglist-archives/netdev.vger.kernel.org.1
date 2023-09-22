Return-Path: <netdev+bounces-35866-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 99CCE7AB718
	for <lists+netdev@lfdr.de>; Fri, 22 Sep 2023 19:19:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id A46F41C20A36
	for <lists+netdev@lfdr.de>; Fri, 22 Sep 2023 17:19:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBE4D42BF0;
	Fri, 22 Sep 2023 17:19:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8837D41E47
	for <netdev@vger.kernel.org>; Fri, 22 Sep 2023 17:19:04 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2059.outbound.protection.outlook.com [40.107.96.59])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CB7F83
	for <netdev@vger.kernel.org>; Fri, 22 Sep 2023 10:19:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dhrMzzzK4HWjii9PjMsgnjeHER/6HYIBxSCxgjuJ/YgNshbdkU2LeiTGGYzSbwwHM7I1t5RjEO8RuPNgxnVuJG2PVe+Sv3I8/ViIqoyeSTcOr2ARIBZoXxR9xRRtVCc5URQ5CJe0Bw4AM0P2o2YkAcykaoLvFeioStFEQvQPSf2wcVnnpxuqOG7mfqe+oXO1i8d1B+15C8lFubYPgiCx35RN2vx9W/VFVADLqykW8r21/buw2wLnhbCJ3NV884zzVllkekozOCnph4ZYFGj+wyppg0dnx704ZV7C3Hq3hN56COZmpGGNs0XLI24KIdyt+i6b1xr2guys2K3v6Ak1IA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LtW8G3tnULUcdj2KWrg+gZkdnWLrfIeoAw+uogdjihk=;
 b=gATNFdOTM07LkCGcsjxZsDV7ZRdksfcptEw4AHfYBEJP13wOr7AaemQvaun5Mba1WL1pHwuncsK7TH9u/OAhs80fjg8k+AdZsQX9d3mD6txbrEs/TpP4rwpPTK5+1WDFgm7hyC0x1X5xec25MrES+vGPtrnwOLDG7xDc7uxXO410/f3yos/DEfKcFHw0iLNqFAA8bTewjzR0E9cEvdVWXvMF7VUhc6LZGRYatICR56dVyl98jPh9iVDJimtJLGaqJToUEIVbVrYZouDFbTvS3psoIs8xreKf9+RtYkhesE6qCXQ/tN3m5XACPVw84PNm6xnqi2W2W03GjuoLpAcUNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LtW8G3tnULUcdj2KWrg+gZkdnWLrfIeoAw+uogdjihk=;
 b=OH0BYZzPoHy5meqsBw7zCXKRpChctXFL7rgNPl5MDOwL0dejbA6+5cN4qGJvutoHHh0FPN/a9wFU7KLdXyZvo5MWpebAESU0SprceIzYYIHgc0iTKwohg3CuPzB0J+8AtuJ1fbhVvwPbsquU2GO1yz9hv0nr048xSbnuwstlEykmknxajS4rMvhk7Y5RNvmGUtsivu2+9NDO1BjN9QJcVDfMtsh2Pvi+gbzPAWO56y1ATN+OtTZUeFGnJ3tvFEPI6cqT+nu8v3vxPahONMRr8KCoERWFzPtj4iBhY+0fqcmTO8yRCS/2R1KeP+3qH2DMNag3zk4zxbKiZbmXJrWKzQ==
Received: from MW4PR03CA0003.namprd03.prod.outlook.com (2603:10b6:303:8f::8)
 by IA1PR12MB6259.namprd12.prod.outlook.com (2603:10b6:208:3e5::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.27; Fri, 22 Sep
 2023 17:19:00 +0000
Received: from MWH0EPF000971E7.namprd02.prod.outlook.com
 (2603:10b6:303:8f:cafe::f2) by MW4PR03CA0003.outlook.office365.com
 (2603:10b6:303:8f::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.34 via Frontend
 Transport; Fri, 22 Sep 2023 17:19:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MWH0EPF000971E7.mail.protection.outlook.com (10.167.243.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.14 via Frontend Transport; Fri, 22 Sep 2023 17:18:59 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Fri, 22 Sep
 2023 10:18:52 -0700
Received: from yaviefel.vdiclient.nvidia.com (10.126.231.35) by
 rnnvmail202.nvidia.com (10.129.68.7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Fri, 22 Sep 2023 10:18:50 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>, "Vadim
 Pasternak" <vadimp@nvidia.com>, <mlxsw@nvidia.com>
Subject: [PATCH net-next 0/3] mlxsw: Provide enhancements and new feature
Date: Fri, 22 Sep 2023 19:18:35 +0200
Message-ID: <cover.1695396848.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.41.0
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E7:EE_|IA1PR12MB6259:EE_
X-MS-Office365-Filtering-Correlation-Id: 27cc2946-76fa-40f8-86e6-08dbbb9002ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	GmZhLTxZzLD1v8K7e/ifeYjZny5wJWnJ5+wdjiQEEYErLldJTujbN/sMMtSqaDwIyhTAQXaaTclLFFHntb7pkad2BgCv2DX38ccBb1VzhnMVflhbu2YdEcRojSqqmcN2KLvJTifWJv2waHE4RXApf/1k5tNc8xsV07B5dwfFapFTzSwMCYoI3WsZhAZGbo18PmTIgTTYjwH40Ya36CY3lc+Fh6OkKMXUueLVUdcrZFxGZPUXXAOw7Par2hLKjnOeW2yFO+dR7TMGQGS/UaE2cfdyUDfBGY/H4U2g0SxdzNaRsl/154J35PAkyvGOVshgUfEIhaHzllnBOwLdTjhiCbczv/DK0yuYpwS7rmEBYCraQ78MVmotyFSXtB8ivHEOZXBa1Lq8/m5rOuYG9IWzUIORKBVLI3z1uhRUEW662Ewsx88XCFafYD8UEkELuRla8bcXqiq4dHCR8RNXTurSja1WbqQ421Gcl2+4RY2HelWVclfrHrcWlws0TmBKr779aLPIbGHF8K8d9CwqfOjFlF6tuxgH5Yfa6m2nVKJPSBoIGFnMvelBYWoJBdz3SzAJuzl9Z8p/eo/6OwLJmcMGuzI4CGYwVPBPhWL3uft5OqEWDig+bRVSVwCSmjd0NIGIp5L/6pvpGEiudx9egOlxlCKsuM1j7RVWFeqlQByPcyWwgpZgl1JXY72For1ngBpilnLZUHcSdWtVVVCCu66wcvD+9KEvccA/Q8DRqrEN4lBKpq2cGrhvTr9xdpSk8melffDxsQYtfnpvF2MJw59rFw==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(396003)(136003)(39860400002)(346002)(376002)(230921699003)(82310400011)(1800799009)(186009)(451199024)(46966006)(40470700004)(36840700001)(54906003)(70586007)(36756003)(6666004)(4744005)(86362001)(316002)(110136005)(2906002)(82740400003)(356005)(7636003)(41300700001)(36860700001)(5660300002)(47076005)(70206006)(7696005)(40460700003)(478600001)(4326008)(8936002)(107886003)(83380400001)(8676002)(16526019)(26005)(40480700001)(2616005)(426003)(336012);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2023 17:18:59.8893
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 27cc2946-76fa-40f8-86e6-08dbbb9002ce
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000971E7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6259
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Vadim Pasternak writes:

Patch #1 - Optimize transaction size for efficient retrieval of module
           data.
Patch #3 - Enable thermal zone binding with new cooling device.
Patch #4 - Employ standard macros for dividing buffer into the chunks.

Vadim Pasternak (3):
  mlxsw: reg: Limit MTBR register payload to a single data record
  mlxsw: core: Extend allowed list of external cooling devices for
    thermal zone binding
  mlxsw: i2c: Utilize standard macros for dividing buffer into chunks

 drivers/net/ethernet/mellanox/mlxsw/core_env.c     | 2 +-
 drivers/net/ethernet/mellanox/mlxsw/core_hwmon.c   | 2 +-
 drivers/net/ethernet/mellanox/mlxsw/core_thermal.c | 1 +
 drivers/net/ethernet/mellanox/mlxsw/i2c.c          | 4 +---
 drivers/net/ethernet/mellanox/mlxsw/reg.h          | 6 +++---
 5 files changed, 7 insertions(+), 8 deletions(-)

-- 
2.41.0


