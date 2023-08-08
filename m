Return-Path: <netdev+bounces-25361-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EE57773CA7
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 18:08:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 317A0280F6D
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 16:08:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 737A515498;
	Tue,  8 Aug 2023 15:51:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6315C1DA41
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 15:51:51 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on20609.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e83::609])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 388C011F51
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 08:51:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HewCpxpwETGpt6QjDkdDBSOOI8ua3FXGai9QzZCWLDXwGtfsUcHlYECK7LBJpbUIJMJ4o4bo9k5XsZciFgXOADkHntbFfZLfsV9zi5vBsXyFiucdUrYwJmlPoRtvD0F2jEwl75mZStMNzngmme4Qds8eXdvS6rdRUth8tDNPSTkP62aZqkp7EuAp129hvOMaO4ocDnFUw63kuZ/KdSIqe9GrT5LER67k4PxH3FzFUd4pBlhz+b9beY/3EUIXEg/oeGSrBN+S+EewLhltJNaw2V2IlAkUP/8My83rntnu64DixPM7bKQ8b3+FePVSqK4V999Ge9yKp6QHgmjDIpzbJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c5VSGfQzzvIHXUxRW8fX6w4ZzYug/8aaDjiXpzlBbBE=;
 b=MnH6SwnabtxpqO+Te71uXY7qyHD7te88aMx8yn9DRbqJNYJ6FBN/SaP9N8YHTqK67MtS+SZ0xKI4sljb9F4fmKomOazV4D7lFo6LCt+SsXLMpqBDMuE/SF2Oz/DtvEY94zrZGSwHIjCYM+f6jhg8MC2zSzuCoYckjT20Q8RcX6RVtpUX+34kMwLm+GrkQhaDpadcVsGUqf8BSW099lmqesk2JvQePDaETP/KtOhgj+eA3j0U0/oNCCxUdxQxPSM+OhUH5DnzwWr+n+p2Kszd/S9ZvLS91eMTf3sfpnxMgx+FQoqoP4cBH2HWBrT9aBf810RFiJb/1/Yo7gbnMrBQDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c5VSGfQzzvIHXUxRW8fX6w4ZzYug/8aaDjiXpzlBbBE=;
 b=upv7l3RZAHv18P7zY+el3Ea93JyL2D8JcA4TaMSIU5gYj76282ZLoxTj0DAf4qlpT0AVz09QT1vBEVPMRtQFL6PQJPHnGFs2qA7CYJnWtVPN8TOI415C1L4VV/rb9bHBHOjv7YbLRSreYDCyPq4FFIhZBZWkKW5rFYf9s9gE8eBpM/8Vovu96E3vK5bTYWzyrosnsXKtYzHYrl8zRe68tDUPK1kQp1O3qLHyhbq4owTOSmUxllEzJqe/Kck690deJV04Z30czSFYrPMm0WthT2cIUAcxqzLWbKc9OxN2/cH+V4QPMuRCmySPcq65NCOgz50FGWs/ODdp7pJYIlDAEQ==
Received: from CYZPR02CA0017.namprd02.prod.outlook.com (2603:10b6:930:a1::22)
 by IA0PR12MB8205.namprd12.prod.outlook.com (2603:10b6:208:400::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.26; Tue, 8 Aug
 2023 13:37:53 +0000
Received: from CY4PEPF0000E9D4.namprd03.prod.outlook.com
 (2603:10b6:930:a1:cafe::4a) by CYZPR02CA0017.outlook.office365.com
 (2603:10b6:930:a1::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.27 via Frontend
 Transport; Tue, 8 Aug 2023 13:37:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000E9D4.mail.protection.outlook.com (10.167.241.147) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6652.19 via Frontend Transport; Tue, 8 Aug 2023 13:37:52 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Tue, 8 Aug 2023
 06:37:46 -0700
Received: from nps-server-23.mtl.labs.mlnx (10.126.231.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Tue, 8 Aug 2023 06:37:44 -0700
From: Shay Drory <shayd@nvidia.com>
To: <netdev@vger.kernel.org>, <pabeni@redhat.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <edumazet@google.com>
CC: Shay Drory <shayd@nvidia.com>, Jiri Pirko <jiri@nvidia.com>
Subject: [PATCH net] devlink: Delay health recover notification until devlink registered
Date: Tue, 8 Aug 2023 16:37:20 +0300
Message-ID: <20230808133720.1402826-1-shayd@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D4:EE_|IA0PR12MB8205:EE_
X-MS-Office365-Filtering-Correlation-Id: e33f771e-2d62-4a3a-ea58-08db9814aa7b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	o3n2qC5oujEzGPcOSlZdcyiY9Ohqo7jVr7yu5Xvt9H6DnBi/oBzE0bQaAdtL0PH9ALb1gHMIRfEiMNGgk9awdIUbh8yC33+dNF+/g2XS6MZFkEuhFBBDES2et5A23BD4C+zRBKyb70cTVj9hTXkVOcuH1BRVNWDQJQWCkIen5Xpus+2xka21S2sa/IznJ3SbJkNwrXawaaEFolyciBf5abU+gxX6j3Y6Qk19Ro9adRwvznyRHqcC++6TedK3HMZviOSt/U5Hd+PV2ghPiSGVy9gXi7yXe0qcLzR+QawXfvIJxhSnYsOuut0cjN9NIuo9fnHDeHegDhxtglRX4CWccHCFM/V025coA5EWGiUecaD2zdDxbBco6hgIbo796iRA/JKB6Y0chUdoNZfqDLeUvGJBLcO+2yvWeVSRzPAlOK23rHnqMZG/BG0FOiG3oD3vF9H8CpdCAIFh7MdIrHdkBGs6YQL3pQa0ysi1EIVx3UwJ0BosGFM6ePX0iHs99+pfRTtbTB+6KQ9/eYWJohfEiPB5QVtuuNIwZSQEsT5ZuuqZxKPndjGTUz/RO4jsu/UkumcyZhvSZoo/deVH5+g/411v0k70D/wx0V+GYhaLj3wysX7y5O8DgV2YZt96L1iA1JeZIx1U1zHTojv9THLBfg00aiHbwsapzOZsaFETrq4Qo59/jGxCT/g1ON3NXdSATDXZu5s8DHzb7apRVY8qOGZZ5hDxyAZrzl3v9+8SnI54qPbGbyN6/M7dAV4oE2VA
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(136003)(376002)(346002)(451199021)(186006)(1800799003)(82310400008)(46966006)(36840700001)(40470700004)(40480700001)(336012)(16526019)(2616005)(40460700003)(36756003)(4326008)(316002)(7636003)(356005)(478600001)(54906003)(70206006)(70586007)(86362001)(6666004)(110136005)(82740400003)(1076003)(26005)(107886003)(426003)(15650500001)(8676002)(8936002)(41300700001)(47076005)(36860700001)(2906002)(83380400001)(5660300002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2023 13:37:52.9135
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e33f771e-2d62-4a3a-ea58-08db9814aa7b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8205
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Currently, invoking health recover before devlink_register() triggers
a WARN_ON. However, it is possible for a device to have health errors
during its probing flow, before the device driver will call to
devlink_register(). e.g.: it is valid to invoke health recover before
devlink_register().

Hence, apply delay notification mechanism to health reporters.

Fixes: cf530217408e ("devlink: Notify users when objects are accessible")
Signed-off-by: Shay Drory <shayd@nvidia.com>
Reviewed-by: Jiri Pirko <jiri@nvidia.com>
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


