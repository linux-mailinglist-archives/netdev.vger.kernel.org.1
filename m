Return-Path: <netdev+bounces-30376-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DA637870B1
	for <lists+netdev@lfdr.de>; Thu, 24 Aug 2023 15:45:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01E1C2815D8
	for <lists+netdev@lfdr.de>; Thu, 24 Aug 2023 13:45:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBBB7CA6E;
	Thu, 24 Aug 2023 13:45:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB98128906
	for <netdev@vger.kernel.org>; Thu, 24 Aug 2023 13:45:16 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2061b.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe5b::61b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 891091BE3
	for <netdev@vger.kernel.org>; Thu, 24 Aug 2023 06:44:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M6FZ9F20haPvV9b6EPYtM0pA7IIugdJ82c7MJAJ45k7xDHojxHfHhETfgumRUDWslrNn9p7A6+NZ9Y4HcdZqJ0w1wdTMF7Qs9cGrpqrIVthERQYDy84Xrkj+9u6/Z5dmDQoD1P0+OQCdgs5l7suv6epBODefDys5mJqBOy8w3Vhi+Clp2v+4RTwg982+zNugMoL2Fpe3xkxuN0YYAoVZj1/6FYL85DA3eTBtzocA18UtS7+BcV4Bk3dhdybTmMg5Z6EFkq6FjAycZHWD+tTlnwRQUQA9U3UMW5WJ43lAH8OAMYFVrTDgf5ofpOZ5B92fXexNl5jj71jz00I/9Efvdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1hCHhwmeadIafNIh+CSRRndX8DHSSZ5oMspAXh7i5OU=;
 b=l0CJAVNttDBkiErnUA7WDqjDaAoUzY1j+vmifi7Aag3l15f/0OCsh8FvmhWlmEKTr4f++TdKyRYnFGwm9l80fGcMu1OvxyvKRqyN9+PUEvtIk2GLvN1KrEjrDa7cYMtBrKyeellN1KobskUUokgWFz9N2gvIS00WgswGXtz9fNcMbQGjhx4Q+ranrwEDUbI8ssJI9edFzIFyOz3yJGqSxfg6nPg8F9+TderqdZG1gAuKI4oda4d1VvHAUUlIffpjO6MQot8zVUR8JM28qSPoZncddi8gsmXycS31/zyyV/g0GLR51tl4MKjpQeHZqb2zDmn15d84jfMVlzF3M70jGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1hCHhwmeadIafNIh+CSRRndX8DHSSZ5oMspAXh7i5OU=;
 b=WrsEq8Fe+aTTU/lIkR+5Jf+BXEEx0bl8K7Os6qhAU2sp4iyGzvMTA5B24gINdsrAWIhYX5wlzhPV+Z7RTzeHfdwKiQMl6V/pRTKgf1jnyxC2y3Qcr4AwCyXkRu59jEoRkfPjemfRPRV3wBrQ98OZKrwFrRdVMfSeJ7nv70UffjcdsBL/s/RhwcAlukFnVvzuPIobzdZcueiwNbJaFeBTOxNaqxcoGAgTZrhVe558SRDVHigP42OkSOWRZcSiGmnQIp8Pz+umngzWQnYoWXNGaxKPkCdShckf75aqR8gI+ZrHkazc1WeEqgD6+9LhFbjsKlhtTL8LFpjJbKQpCF57yA==
Received: from CY5PR15CA0059.namprd15.prod.outlook.com (2603:10b6:930:1b::28)
 by MW6PR12MB9000.namprd12.prod.outlook.com (2603:10b6:303:24b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27; Thu, 24 Aug
 2023 13:44:10 +0000
Received: from CY4PEPF0000E9CD.namprd03.prod.outlook.com
 (2603:10b6:930:1b:cafe::f4) by CY5PR15CA0059.outlook.office365.com
 (2603:10b6:930:1b::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27 via Frontend
 Transport; Thu, 24 Aug 2023 13:44:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000E9CD.mail.protection.outlook.com (10.167.241.140) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6699.15 via Frontend Transport; Thu, 24 Aug 2023 13:44:09 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Thu, 24 Aug 2023
 06:43:57 -0700
Received: from yaviefel.vdiclient.nvidia.com (10.126.231.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Thu, 24 Aug 2023 06:43:53 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>, "Jiri
 Pirko" <jiri@resnulli.us>, Vadim Pasternak <vadimp@nvidia.com>,
	<mlxsw@nvidia.com>
Subject: [PATCH net 3/3] mlxsw: core_hwmon: Adjust module label names based on MTCAP sensor counter
Date: Thu, 24 Aug 2023 15:43:10 +0200
Message-ID: <dbbe1713c4a23a06a297b8790eccf757f68d5d62.1692882703.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1692882702.git.petrm@nvidia.com>
References: <cover.1692882702.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9CD:EE_|MW6PR12MB9000:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a69f8ad-2582-42fa-1a06-08dba4a831b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	9C11GX0HdUCy/VAXIiREWU0F69Ku1kwCsbpxI+FNY8wXIWS8Zo+zANmVeh9KPy6ZutAbJdg3EH7RQ49gPgIbn+QOT7woo+VBVFA37rj9unwu8vtKa7SSFmo3H49G2lX2g2Wd//4F7aDyqr7PzpNXOKtAK1fpHjQ5sNh0oq8ndWz4Y/vICoX6zPNNnKqAgIh0Z6KZn4WmLMHogLVY0iJvMSlS6RJ36z+5N722HEf67CTGYe0vkYhztGLm2ttNUSo2j4Zvcl2UOTKQIEPFtJJyN4RZu+1Dvbye/Qe6NvNUQQCx2Ce6Qj7tdNsWoXjShA6f6J4NW4AlVG5SRWLJSMAD1hxS2bPFkeQuMlmm2Mc56dcSquJ1PtiSk9EYzknT0hemHcKEfJaIJnIvMuPyhTIoPEX0sRoStmhrQqu2cbhUgJF7DTGadf6CrYvFy94g0+StAn2G55aP2JMqrNfMsoOyc7a8mLVnb5eNH0DUl2HEuKECwIezYw11J6EulWq2QCtcxART1MKbVb/4MkLKLcyqR1tfmgx5KkSrhxoWR5UaHv40IWXWuPl/6bBQhbx/pMIu+0AaOTZ/Jl0PJ5W8KrxUPE1ZxPJDdsicVrCv3GmR5QCIOlErRcsO4QgcmuaUpjml/TrM3RA0Rl3H98VzgWhFoRNosQnKLLbWLsIHo5GW8z5CKEo6Emkw5lBT+WTMvfqX/hFcG8EnnVC2IVceVCW8dzhTllISJTE4bRa79yNdmY7FFNbwdWbl1u572grJkRA+
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(396003)(39860400002)(346002)(136003)(376002)(1800799009)(451199024)(82310400011)(186009)(36840700001)(40470700004)(46966006)(86362001)(356005)(82740400003)(7636003)(36756003)(40460700003)(7696005)(6666004)(478600001)(5660300002)(316002)(70586007)(54906003)(2906002)(70206006)(8676002)(110136005)(4326008)(8936002)(40480700001)(26005)(16526019)(426003)(336012)(83380400001)(36860700001)(47076005)(41300700001)(2616005)(107886003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2023 13:44:09.6580
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a69f8ad-2582-42fa-1a06-08dba4a831b0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9CD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB9000
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Vadim Pasternak <vadimp@nvidia.com>

Transceiver module temperature sensors are indexed after ASIC and
platform sensors. The current label printing method does not take this
into account and simply prints the index of the transceiver module
sensor.

On new systems that have platform sensors this results in incorrect
(shifted) transceiver module labels being printed:

$ sensors
[...]
front panel 002:  +37.0°C  (crit = +70.0°C, emerg = +75.0°C)
front panel 003:  +47.0°C  (crit = +70.0°C, emerg = +75.0°C)
[...]

Fix by taking the sensor count into account. After the fix:

$ sensors
[...]
front panel 001:  +37.0°C  (crit = +70.0°C, emerg = +75.0°C)
front panel 002:  +47.0°C  (crit = +70.0°C, emerg = +75.0°C)
[...]

Fixes: a53779de6a0e ("mlxsw: core: Add QSFP module temperature label attribute to hwmon")
Signed-off-by: Vadim Pasternak <vadimp@nvidia.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Signed-off-by: Petr Machata <petrm@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlxsw/core_hwmon.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/core_hwmon.c b/drivers/net/ethernet/mellanox/mlxsw/core_hwmon.c
index 70735068cf29..0fd290d776ff 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/core_hwmon.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/core_hwmon.c
@@ -405,7 +405,8 @@ mlxsw_hwmon_module_temp_label_show(struct device *dev,
 			container_of(attr, struct mlxsw_hwmon_attr, dev_attr);
 
 	return sprintf(buf, "front panel %03u\n",
-		       mlxsw_hwmon_attr->type_index);
+		       mlxsw_hwmon_attr->type_index + 1 -
+		       mlxsw_hwmon_attr->mlxsw_hwmon_dev->sensor_count);
 }
 
 static ssize_t
-- 
2.41.0


