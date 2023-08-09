Return-Path: <netdev+bounces-26044-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 871F6776A1A
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 22:35:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C9EB1C21388
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 20:35:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF3F21BB2F;
	Wed,  9 Aug 2023 20:35:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A27EC2452D
	for <netdev@vger.kernel.org>; Wed,  9 Aug 2023 20:35:46 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2044.outbound.protection.outlook.com [40.107.220.44])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B0902123
	for <netdev@vger.kernel.org>; Wed,  9 Aug 2023 13:35:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jWF3BtNcM/Mn8XX9SASAU2iOOhQdDNCMkG0Pff8JvNhMVii/ycMFRXaesOuKToEsX5sbaYDPb987+ikr5qYZGbPXPfZ5VCD7FOSYtxvHnF4SfyQYraFGA5ycKxOIcZ7fEpzbO634bu6pW2NdzimHyeY4yUjKO1aul+9Sx/qPsprRCH3D91Y6C+U21el7FmP8Eo5S/UwLtUlGrLOZF9hJw5ItsqTToG+iMBx38F37NCF8RKbrWnWrIqkO/p3W9LwmrUN2zU+ayNFe6LgVZgBZy28s1yklU9GcFImMWmSWG6ny+CLrybc4so0u7J2nTOIZguGc0gZfDvBssNs5LYQl1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=feeR6Yaq4xbRV9ARhOFqTuxHVA8B2mBOp+uDYHzRnf0=;
 b=Xdp7lXEF5wVd7c7RSHJVXsQ+DxFb3fV0pABGngmgaR3krPkH1ZzCNvg5ZqjJfEM0sXAnhTs1XWF7WfynqNo9VjYQ5o1t0qT4M5B/sjUHiUKldx332q3xwjkmYRqCTEjPNYMn6CLAxeBjiiHqwVHQflKM0ph/6a7eQZdzaD6gAm9uq0a4X1+WQPOyKeDvLexCBZ9i0l7Hi8HmTehcFu/jS89WEoiSs+Bp15xcqNR8/mZZNHLHzLil7g8oewnPgtE2pBMbhdMOKGeKMcFD4nXCDnpqS1LihFoOXdftSp4un/evgpiAvtAuNbU2R6TN8ORJ8Ubn0jLu0NZGGTl3T+yjkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=feeR6Yaq4xbRV9ARhOFqTuxHVA8B2mBOp+uDYHzRnf0=;
 b=hyJgvctQuXMMxjbaOX5mn9dVZNU6fDih1AtOJqzTLEjhC/qpFhzPateckoFReKv6zIUho2dJ/KK3Qi4IHq0p3b+QOiu6xqJn78HIKYqWWPhcp0s+JAUfWsmEiPADIHp5vBIpIMNLwvZ3feEjeJtWRK8qa8iGiLjpgowdRvvIiOm6KXQ226BTJKbugLhZkfbaEX4e7m5EgPjEiq0DgvyWZoOf4zFdGophAym1ZXF1HVk7SZ8xWcEh0YJ2oeR4upOvy+VYEpeDK9jb1yWWOr8UXdzHYWLeOAmI1eQumUVxHm2HVk765V1IyZVYMPVgSttq2591LHAsPPqMcgQbvWxOqw==
Received: from CY8PR22CA0023.namprd22.prod.outlook.com (2603:10b6:930:45::28)
 by IA0PR12MB7602.namprd12.prod.outlook.com (2603:10b6:208:43a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.28; Wed, 9 Aug
 2023 20:35:43 +0000
Received: from CY4PEPF0000EDD7.namprd03.prod.outlook.com
 (2603:10b6:930:45:cafe::2c) by CY8PR22CA0023.outlook.office365.com
 (2603:10b6:930:45::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.28 via Frontend
 Transport; Wed, 9 Aug 2023 20:35:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000EDD7.mail.protection.outlook.com (10.167.241.211) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6652.19 via Frontend Transport; Wed, 9 Aug 2023 20:35:42 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Wed, 9 Aug 2023
 13:35:34 -0700
Received: from nps-server-23.mtl.labs.mlnx (10.126.231.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Wed, 9 Aug 2023 13:35:31 -0700
From: Shay Drory <shayd@nvidia.com>
To: <netdev@vger.kernel.org>, <pabeni@redhat.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <edumazet@google.com>
CC: Shay Drory <shayd@nvidia.com>, Jiri Pirko <jiri@nvidia.com>
Subject: [PATCH net v2] devlink: Delay health recover notification until devlink registered
Date: Wed, 9 Aug 2023 23:35:21 +0300
Message-ID: <20230809203521.1414444-1-shayd@nvidia.com>
X-Mailer: git-send-email 2.38.1
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
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD7:EE_|IA0PR12MB7602:EE_
X-MS-Office365-Filtering-Correlation-Id: f6c2002f-8e7d-4bf2-f3e1-08db991833b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	k6AaIQi289yN9TgeKOkUzbzrDK2AvIqbrgoUANpjYuaFmoCjDqGBIv8+Ex52Etpg+hadb1g6R+YxLunl4Ydfz+B1DzibIVaPDXkR7XNPRO3dmADRVDuIspcS9Vb3OXEiB39rd3KMmx4rpFphXQTeMiSQdAc7Yld+BYyf/+mIS2KHSkQtS3nV02L9xZamosFUfTt9RoV6JLC2h5UH/UjXG5U0iBdyA3y6/EqQqTc/kPmRFc7lJYbyzckO6bGzHP9v8qslluAksJjX+/P3pN2MLFyBpEdkJF6QgLRbwIJMtPkLW6MfvV70nRSatTuBQXr2GigAWg7vAkHftOWJ1D+5+cSDFmA8lVkufTvWQXaSgTLbEJNZ0380w1b2g7iy7i/TeVyPFOIG88DC4u59rDu+Uxrzeu2nBDhE1/70dFn4T3Zq04mq9B0CuETQBw0PYjR6+lYZ/NcYH3ZYNjdPsVZtdEuLOXYtzHAA7SNbLON2+53huglSf5tDDAXTaCjJEcotWwGXUsoRbw7HCKMyLjN8En4I8LNDirn2/+DqifyI9hf7BN560OCBVQzZIkIZyZYMvdION1HtW06/zHx1h8C6XaxAETepFlIlD9OC5qV2RuD6d4EhVtJLITkzYYGWGTewRXNTf9SszlMWmEEWNOCy2OaKFyHYZ3W9R82iGEIT+32c3a3eh/NVlzq5EblC/VhJwDMo8Lul02HZLlMZTTxaSveKe2TbELMqVlyr7ztBVyQgsNYucrBPo3Hwg6Db5Vpj
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(136003)(376002)(39860400002)(451199021)(1800799006)(82310400008)(186006)(40470700004)(46966006)(36840700001)(26005)(1076003)(336012)(82740400003)(7636003)(16526019)(356005)(107886003)(426003)(2616005)(83380400001)(47076005)(36860700001)(36756003)(2906002)(15650500001)(8676002)(40460700003)(8936002)(478600001)(5660300002)(86362001)(40480700001)(54906003)(110136005)(6666004)(4326008)(70206006)(316002)(70586007)(41300700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2023 20:35:42.7503
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f6c2002f-8e7d-4bf2-f3e1-08db991833b3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EDD7.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7602
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From one side, devl_register() is done last in device initialization
phase, in order to expose devlink to the user only when device is
ready. From second side, it is valid to create health reporters
during device initialization, in order to recover and/or notify the
user.
As a result, a health recover can be invoked before devl_register().
However, invoking health recover before devl_register() triggers a
WARN_ON.

Hence, apply delay notification mechanism to health reporters.

Fixes: cf530217408e ("devlink: Notify users when objects are accessible")
Signed-off-by: Shay Drory <shayd@nvidia.com>
Reviewed-by: Jiri Pirko <jiri@nvidia.com>
---
v1->v2:
 - re-phrased the commit message.
---
 net/devlink/devl_internal.h | 21 +++++++++++++++++++++
 net/devlink/health.c        | 29 +++++++++--------------------
 net/devlink/leftover.c      |  5 +++++
 3 files changed, 35 insertions(+), 20 deletions(-)

diff --git a/net/devlink/devl_internal.h b/net/devlink/devl_internal.h
index 62921b2eb0d3..9269dbe1b047 100644
--- a/net/devlink/devl_internal.h
+++ b/net/devlink/devl_internal.h
@@ -53,6 +53,25 @@ struct devlink {
 	char priv[] __aligned(NETDEV_ALIGN);
 };
 
+struct devlink_health_reporter {
+	struct list_head list;
+	void *priv;
+	const struct devlink_health_reporter_ops *ops;
+	struct devlink *devlink;
+	struct devlink_port *devlink_port;
+	struct devlink_fmsg *dump_fmsg;
+	struct mutex dump_lock; /* lock parallel read/write from dump buffers */
+	u64 graceful_period;
+	bool auto_recover;
+	bool auto_dump;
+	u8 health_state;
+	u64 dump_ts;
+	u64 dump_real_ts;
+	u64 error_count;
+	u64 recovery_count;
+	u64 last_recovery_ts;
+};
+
 extern struct xarray devlinks;
 extern struct genl_family devlink_nl_family;
 
@@ -168,6 +187,8 @@ extern const struct devlink_cmd devl_cmd_selftests_get;
 
 /* Notify */
 void devlink_notify(struct devlink *devlink, enum devlink_command cmd);
+void devlink_recover_notify_check(struct devlink_health_reporter *reporter,
+				  enum devlink_command cmd);
 
 /* Ports */
 int devlink_port_netdevice_event(struct notifier_block *nb,
diff --git a/net/devlink/health.c b/net/devlink/health.c
index 194340a8bb86..b1ceea733926 100644
--- a/net/devlink/health.c
+++ b/net/devlink/health.c
@@ -51,25 +51,6 @@ static void devlink_fmsg_free(struct devlink_fmsg *fmsg)
 	kfree(fmsg);
 }
 
-struct devlink_health_reporter {
-	struct list_head list;
-	void *priv;
-	const struct devlink_health_reporter_ops *ops;
-	struct devlink *devlink;
-	struct devlink_port *devlink_port;
-	struct devlink_fmsg *dump_fmsg;
-	struct mutex dump_lock; /* lock parallel read/write from dump buffers */
-	u64 graceful_period;
-	bool auto_recover;
-	bool auto_dump;
-	u8 health_state;
-	u64 dump_ts;
-	u64 dump_real_ts;
-	u64 error_count;
-	u64 recovery_count;
-	u64 last_recovery_ts;
-};
-
 void *
 devlink_health_reporter_priv(struct devlink_health_reporter *reporter)
 {
@@ -480,7 +461,8 @@ static void devlink_recover_notify(struct devlink_health_reporter *reporter,
 	int err;
 
 	WARN_ON(cmd != DEVLINK_CMD_HEALTH_REPORTER_RECOVER);
-	ASSERT_DEVLINK_REGISTERED(devlink);
+	if (!devl_is_registered(devlink))
+		return;
 
 	msg = nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_KERNEL);
 	if (!msg)
@@ -496,6 +478,13 @@ static void devlink_recover_notify(struct devlink_health_reporter *reporter,
 				0, DEVLINK_MCGRP_CONFIG, GFP_KERNEL);
 }
 
+void devlink_recover_notify_check(struct devlink_health_reporter *reporter,
+				  enum devlink_command cmd)
+{
+	if (reporter->error_count)
+		devlink_recover_notify(reporter, cmd);
+}
+
 void
 devlink_health_reporter_recovery_done(struct devlink_health_reporter *reporter)
 {
diff --git a/net/devlink/leftover.c b/net/devlink/leftover.c
index 1f00f874471f..6d07fd55c75b 100644
--- a/net/devlink/leftover.c
+++ b/net/devlink/leftover.c
@@ -6659,6 +6659,7 @@ void devlink_notify_register(struct devlink *devlink)
 {
 	struct devlink_trap_policer_item *policer_item;
 	struct devlink_trap_group_item *group_item;
+	struct devlink_health_reporter *reporter;
 	struct devlink_param_item *param_item;
 	struct devlink_trap_item *trap_item;
 	struct devlink_port *devlink_port;
@@ -6695,6 +6696,10 @@ void devlink_notify_register(struct devlink *devlink)
 	xa_for_each(&devlink->params, param_id, param_item)
 		devlink_param_notify(devlink, 0, param_item,
 				     DEVLINK_CMD_PARAM_NEW);
+
+	list_for_each_entry(reporter, &devlink->reporter_list, list)
+		devlink_recover_notify_check(reporter,
+					     DEVLINK_CMD_HEALTH_REPORTER_RECOVER);
 }
 
 void devlink_notify_unregister(struct devlink *devlink)
-- 
2.38.1


