Return-Path: <netdev+bounces-25311-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9171C773B77
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 17:51:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B39B21C209D5
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 15:51:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1118713ADC;
	Tue,  8 Aug 2023 15:43:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0561DEAC3
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 15:43:12 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2063.outbound.protection.outlook.com [40.107.94.63])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 734EA4EFB
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 08:42:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IRKyOVr+FDc1+XMqk23kyoI6rVKz5LnVeV469I2ixxvJaXA35DNOucnmb1+8iYdFGnWJIIUpb+HZd50Dtv+DJtBgkXgsz/CvlsIlpACrO2f7d8dj4TU192+g3/zv4t4bvZ5jQWM2yQ3OcQaSvrn9bqYW4qEfa2g6R7ybYiQLg9Rv5vKN2wZdXUBgYA1SuKLuB2m5f6CUtRKn9lnpTLUPHEHqv5vvRxiWAiBiXYd0DFDb5xxjIA4Hz4zBTTqpgsVWaaVguSBdXutfiM5l7iMnREdeDReAO1emcNQOKaiwA2ABWUKpcRkQPyFvyY6s/o+6cydx6dOZdYxpHaraQ6hGLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ngJVhMn4j8gD477mZeIdwa31aWjGrj9eLAyZz1J49to=;
 b=NvfKzmmztQC338Y/3CJFrDcLK81h5kRqhYj135oICgzysCoH/lh8GDtqwln5hKswH0Ri0LOo4OA/95L3kOolTouUEbY+upd4ahCm6IaKNE37gQjXVRc+TzNkZBa/FewLQromwKLyfAwL1EfZTiJu2fXX0aaAD+yH9X3T0MufIrNb1jao7dTtQmXWSatPs77PyLVy96Y8X0dqN0g99J5p4lxu8Q1z6Yqu6BNebfpB/OHG9g36ZP7pGoiWpUJ39548VjWnN/Rtt2wMKPJl1EsrWhjQzPeD0wIn+QfseTuq5MvG5SoUhEMOFGl0yvLpcKGrCptdrjOqpaz3cBuItwe80w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ngJVhMn4j8gD477mZeIdwa31aWjGrj9eLAyZz1J49to=;
 b=K6Osi2SMOzsQPhSFSnZfWg+I0UFatFsHAKhlndPVzFgwqOTGgCE0ymPccxW0b65vuGrk0+4ariSbAgiDOL0EHTJzLyUmOJYsbCfz25z7MgxcUolztWqL4dX6Y5UPU0/6M3qDnIgOEM2T1GZTla2FpTnqcmBKrHaRfRoN3GnZnX/T4dGQR5hjO14iz7FEnEFC4ARKJ52kxhgHvsBegMiT1Obt/VJW6IKJS60Xn49UyQQ3Cs09r82qGISPpETys4tZ7b+5ynZ5USmU0v79/OuT/NaAwDS+39rQK4hkSYLmN/F5PMghca0Vup+3oP0aDJpXn4hVTBTDANhf0Rei4zc5Bg==
Received: from PH0PR07CA0096.namprd07.prod.outlook.com (2603:10b6:510:4::11)
 by DS7PR12MB6120.namprd12.prod.outlook.com (2603:10b6:8:98::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6652.27; Tue, 8 Aug 2023 13:18:55 +0000
Received: from SN1PEPF0002529F.namprd05.prod.outlook.com
 (2603:10b6:510:4:cafe::68) by PH0PR07CA0096.outlook.office365.com
 (2603:10b6:510:4::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.27 via Frontend
 Transport; Tue, 8 Aug 2023 13:18:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF0002529F.mail.protection.outlook.com (10.167.242.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6652.19 via Frontend Transport; Tue, 8 Aug 2023 13:18:55 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Tue, 8 Aug 2023
 06:18:46 -0700
Received: from localhost.localdomain (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Tue, 8 Aug 2023
 06:18:44 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>,
	Danielle Ratson <danieller@nvidia.com>, <mlxsw@nvidia.com>
Subject: [PATCH net-next 2/2] selftests: mlxsw: router_bridge_lag: Add a new selftest
Date: Tue, 8 Aug 2023 15:18:16 +0200
Message-ID: <373a7754daa4dac32759a45095f47b08a2a869c8.1691498735.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1691498735.git.petrm@nvidia.com>
References: <cover.1691498735.git.petrm@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002529F:EE_|DS7PR12MB6120:EE_
X-MS-Office365-Filtering-Correlation-Id: b43c4e65-ae85-4cb7-45ef-08db98120484
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	f1/CWQE4vZqN2EjX05CXJakTKLYvzT/FskdDbnhjEqnrb/8qnVvx9OrxHSrft64oRrTUfSh9NjJTOju8iJsqOmjubzyZbCs0obeMftmYy6esMTBcCqhHVRiS2O9Okpv5TctkK6ilHmPbvFTbslrmlJ5Y25AqXB10qT64HnG0VjSzHydrJ0Z7Ipo40V3G8nTl1wb29lkISdHwehu2gvkqBP6DHqFaynheDfWaZWl+GPUrtbrS64arrqi0AqcLCMmdYWnaNwY28ZiCo9iKSGvMigSugM2dpRDiiZu+Xt7KimPUic+dZLeAciahRFJRnvobT+HfWMdDHrSkzY277IRCIV5CetfUtoCLYedkJ0enRvFdxPhR5ZUb6OGl64wUxBUcZ5ofLC8TWpEuA63Uv1W4Z5sF8yig+kaZWikk+0lkNIRRAxDpTZtUwn8XHPBsEzulVmGb6Es0MhRXtynb5V9bQ1FnTJFpH1P9tvB/PmUp55wbH65oNEEztcmhqFKR/fCx9n1iO+mCzTN1PpujreCtP/n7/omfk/h0k5zsjvPmO+zO6OWh74AHcw0Omr81bJ/6qKx7oHiEZwZS0iQ0qyzK1/oEu/aZXN5++LmWLPPuJQkUsDbUbGUMXp3crO0dVFE2and3GQI8hc7m/RTP8YXzgXRIagsDbr5pLXhkzto7l5Ab12cyPpkuOXJxE0B7zfSwu73SFE8DfCDBLYjOulgTYdoCWBMKKb77OJ/dSqDnQ/T+0u9PP2qCH0DqA0ZQIcNM
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(136003)(346002)(376002)(186006)(1800799003)(82310400008)(451199021)(36840700001)(46966006)(40470700004)(5660300002)(36860700001)(40480700001)(16526019)(8676002)(47076005)(336012)(83380400001)(478600001)(2616005)(2906002)(66574015)(426003)(8936002)(26005)(82740400003)(107886003)(40460700003)(41300700001)(7636003)(356005)(110136005)(54906003)(6666004)(316002)(4326008)(36756003)(86362001)(70586007)(70206006);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2023 13:18:55.4261
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b43c4e65-ae85-4cb7-45ef-08db98120484
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002529F.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6120
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Add a selftest to verify enslavement to a LAG with upper after fresh
devlink reload.

Signed-off-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Danielle Ratson <danieller@nvidia.com>
---
 .../drivers/net/mlxsw/router_bridge_lag.sh    | 50 +++++++++++++++++++
 1 file changed, 50 insertions(+)
 create mode 100755 tools/testing/selftests/drivers/net/mlxsw/router_bridge_lag.sh

diff --git a/tools/testing/selftests/drivers/net/mlxsw/router_bridge_lag.sh b/tools/testing/selftests/drivers/net/mlxsw/router_bridge_lag.sh
new file mode 100755
index 000000000000..6ce317cfaf9b
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/mlxsw/router_bridge_lag.sh
@@ -0,0 +1,50 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+# Test enslavement to LAG with a clean slate.
+# See $lib_dir/router_bridge_lag.sh for further details.
+
+ALL_TESTS="
+	config_devlink_reload
+	config_enslave_h1
+	config_enslave_h2
+	config_enslave_h3
+	config_enslave_h4
+	config_enslave_swp1
+	config_enslave_swp2
+	config_enslave_swp3
+	config_enslave_swp4
+	config_wait
+	ping_ipv4
+	ping_ipv6
+"
+
+config_devlink_reload()
+{
+	log_info "Devlink reload"
+	devlink_reload
+}
+
+config_enslave_h1()
+{
+	config_enslave $h1 lag1
+}
+
+config_enslave_h2()
+{
+	config_enslave $h2 lag4
+}
+
+config_enslave_h3()
+{
+	config_enslave $h3 lag4
+}
+
+config_enslave_h4()
+{
+	config_enslave $h4 lag1
+}
+
+lib_dir=$(dirname $0)/../../../net/forwarding
+EXTRA_SOURCE="source $lib_dir/devlink_lib.sh"
+source $lib_dir/router_bridge_lag.sh
-- 
2.41.0


