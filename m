Return-Path: <netdev+bounces-18957-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 67CFD7593AB
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 13:02:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F1D31C20EE7
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 11:02:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAD41125DB;
	Wed, 19 Jul 2023 11:02:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF9FE125C8
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 11:02:21 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2079.outbound.protection.outlook.com [40.107.244.79])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44A91186
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 04:02:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JuKYlN6TJneneBLRBlmjueHjT3m9qKnYW4Gh5Z+YVM6R53oPaMUjZ7RI4Zm7jW/6sSni1JrtmGR7amtt29vLYHubxRja9r7ENRZrJPJe6ALMkZ9Iwh5pArefoT5eC+yoq5snUA2ebJehpVU3i/zC0V7mIK34bIaIhN3Su10Lryfuj+nrHOyODcjbRsx2bAU6EpI6F/gpH88iL1OgKh9QRU4+lObKJenPPaZyoHPNlmswX23ydGfr5g4qKB6ceAmHEf2/izkbEuPvWhsWklHJIPagW08RhklXYbfNl85oVxOiU49QHqvB5l9nV7oeDAN2JN+SsSjqVp+EHbAbep23kQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D1gyKFFp7ks8gh/utde57OTWL5Is0cFKvp/lBS9d6TI=;
 b=eD7fmGYxjSzO9dqxa6FwJSY6PR+GsRgqaAgxr9z07iB+EBL4+TLB1QLnltNV8Li8YNADkH2k7/6Z+YnuK9WgjVaxDW2BdZbzoxyo/oJQQtYZI22RkNluWy0Gtp19y3DQlOEsws/NOvIihXKFCnBcy/0VLWeI53CDfZ2Ku5Ss9k41utcHAsz/eZeH84NXbwKeQwrdhkMHrmkMh9bCP4Pp3qw6tSyGXksX+TNZqJBKlCNa0itZl16khcM4JMX3l1uynSwZ+nq6dW23H5LGQNrrBB4MLtDg+cgFPJBmggnT+0rnl+xJa5ZlYUxYBA5eLhWUQgS/habLy6FXyyd4F7IQBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D1gyKFFp7ks8gh/utde57OTWL5Is0cFKvp/lBS9d6TI=;
 b=LVtXCGx0uUj3huOlJ+U56/rROPGYkqUZ99jPeQvfJP9B4c6tT3cyU3o79xqnV22KNETIJDqAuBtr93U2jLN5Tmiu5BhIPyqxad1S8dz74uHzQkWj6XJ+JyzDIsIgwR/0VuHPSSTphISkrn5N4nYrZ7aovozeEsopghVb8zPFyxA7kaz7rscNmTv8P8f2CwNOlvYtE+EUKfkAUt42VIdFu7TF5S50fh4E0spyarNaeB4DB2LXCMEsKOYYqyXmHktp3jfRAx1F23/GmFikdtHVn5pCNLWctMAXY6zCf3+qjreKLsZDSqAotgTvelXwYVDgGHtymKuXzMA62qVysHbQUw==
Received: from BN9P221CA0030.NAMP221.PROD.OUTLOOK.COM (2603:10b6:408:10a::29)
 by SJ2PR12MB7961.namprd12.prod.outlook.com (2603:10b6:a03:4c0::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.33; Wed, 19 Jul
 2023 11:02:17 +0000
Received: from BN8NAM11FT015.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:10a:cafe::7b) by BN9P221CA0030.outlook.office365.com
 (2603:10b6:408:10a::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.24 via Frontend
 Transport; Wed, 19 Jul 2023 11:02:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN8NAM11FT015.mail.protection.outlook.com (10.13.176.90) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6588.34 via Frontend Transport; Wed, 19 Jul 2023 11:02:16 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Wed, 19 Jul 2023
 04:02:03 -0700
Received: from localhost.localdomain (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Wed, 19 Jul
 2023 04:01:59 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>,
	Danielle Ratson <danieller@nvidia.com>, <mlxsw@nvidia.com>, Jiri Pirko
	<jiri@resnulli.us>, Ivan Vecera <ivecera@redhat.com>, Roopa Prabhu
	<roopa@nvidia.com>, Nikolay Aleksandrov <razor@blackwall.org>,
	<bridge@lists.linux-foundation.org>
Subject: [PATCH net-next 02/17] net: switchdev: Add a helper to replay objects on a bridge port
Date: Wed, 19 Jul 2023 13:01:17 +0200
Message-ID: <3145c726aa2290b82841a51590554e97f3c099b6.1689763088.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1689763088.git.petrm@nvidia.com>
References: <cover.1689763088.git.petrm@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT015:EE_|SJ2PR12MB7961:EE_
X-MS-Office365-Filtering-Correlation-Id: 08b81c1f-a2e1-48df-4b2b-08db88479d6a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	5j+pmV63227lSeg/guqbZGV+YVwap7MBZvvqhuJ39rtOEyXfrSay6hyvkD315++1lpp6Ppwd+jBVdsg7gkPWQugvI9tpTEj9RxOkaLH5uSxJQMienQ6h1+zj8LPDDodC+TqLyGNjOHwTr/pzlfggOLiIpoB/uxC5J8YvkbjGwaSfcOPJ+LwSYyXR9sGLf3v54zg4+IS9pSNRPqOHbqzt7uYFRJraV447FdhzN+8wHNsaAtu6Rkecv7qvR0KhJetNNZl7ggeT4am3zqQpVh66dO45PFLe3DFcpWTYfOSOG/8xINFhLDT19bHX84lIz7OEov3AjoRXTnbShZIqMIMDUKcuEbckKSkdxTWgxs38dYdMOSSnLCxMJeBT7Ej/nQpzNxDZLeRJ037IY0tJzQs77rQ+y5Eogtu0vqDnh0fGNOtHNJ5LCkxPZO3Z7Oiq1DE6eiyatzrNv9NdlkzEMDiqHm3t2NsFLrClGcdf74hzIX6T6Qn0G12dFn16KuZdS9SZXXWbaVjP/CkCu7ezj5BZ9qx4LuJPA1afm/V4RmjQCnm3qsP8iQq4ub+dPZLK2xNeOh8PmB2sSMKTQsm1E1dlkG4Z0adBxO8oN0jjTSLhYtO+q4PJN4k7ofQggwRMBD6hOTGLnFEKUP5xDAAYikkWn1kYV9Pf0L52Tk/G3WDOG2nzHQBvrB/NcWYTD+NXX0PWCPm3gRdzJezDXTqMA7D3yOgBOU5i7wYbvSIUGHBcr3KJlOXjSqVPaqK2jI6vZuDe
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(346002)(376002)(39860400002)(451199021)(82310400008)(36840700001)(46966006)(40470700004)(478600001)(6666004)(54906003)(110136005)(426003)(36860700001)(336012)(356005)(2616005)(83380400001)(47076005)(40460700003)(86362001)(36756003)(40480700001)(2906002)(186003)(26005)(16526019)(7636003)(70586007)(82740400003)(41300700001)(70206006)(8936002)(8676002)(4326008)(5660300002)(316002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2023 11:02:16.6070
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 08b81c1f-a2e1-48df-4b2b-08db88479d6a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN8NAM11FT015.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7961
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

When a front panel joins a bridge via another netdevice (typically a LAG),
the driver needs to learn about the objects configured on the bridge port.
When the bridge port is offloaded by the driver for the first time, this
can be achieved by passing a notifier to switchdev_bridge_port_offload().
The notifier is then invoked for the individual objects (such as VLANs)
configured on the bridge, and can look for the interesting ones.

Calling switchdev_bridge_port_offload() when the second port joins the
bridge lower is unnecessary, but the replay is still needed. To that end,
add a new function, switchdev_bridge_port_replay(), which does only the
replay part of the _offload() function in exactly the same way as that
function.

Cc: Jiri Pirko <jiri@resnulli.us>
Cc: Ivan Vecera <ivecera@redhat.com>
Cc: Roopa Prabhu <roopa@nvidia.com>
Cc: Nikolay Aleksandrov <razor@blackwall.org>
Cc: bridge@lists.linux-foundation.org
Signed-off-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Danielle Ratson <danieller@nvidia.com>
---
 include/net/switchdev.h   |  6 ++++++
 net/bridge/br.c           |  8 ++++++++
 net/bridge/br_private.h   | 16 ++++++++++++++++
 net/bridge/br_switchdev.c |  9 +++++++++
 net/switchdev/switchdev.c | 25 +++++++++++++++++++++++++
 5 files changed, 64 insertions(+)

diff --git a/include/net/switchdev.h b/include/net/switchdev.h
index ca0312b78294..4d324e2a2eef 100644
--- a/include/net/switchdev.h
+++ b/include/net/switchdev.h
@@ -231,6 +231,7 @@ enum switchdev_notifier_type {
 
 	SWITCHDEV_BRPORT_OFFLOADED,
 	SWITCHDEV_BRPORT_UNOFFLOADED,
+	SWITCHDEV_BRPORT_REPLAY,
 };
 
 struct switchdev_notifier_info {
@@ -299,6 +300,11 @@ void switchdev_bridge_port_unoffload(struct net_device *brport_dev,
 				     const void *ctx,
 				     struct notifier_block *atomic_nb,
 				     struct notifier_block *blocking_nb);
+int switchdev_bridge_port_replay(struct net_device *brport_dev,
+				 struct net_device *dev, const void *ctx,
+				 struct notifier_block *atomic_nb,
+				 struct notifier_block *blocking_nb,
+				 struct netlink_ext_ack *extack);
 
 void switchdev_deferred_process(void);
 int switchdev_port_attr_set(struct net_device *dev,
diff --git a/net/bridge/br.c b/net/bridge/br.c
index 4f5098d33a46..a6e94ceb7c9a 100644
--- a/net/bridge/br.c
+++ b/net/bridge/br.c
@@ -234,6 +234,14 @@ static int br_switchdev_blocking_event(struct notifier_block *nb,
 		br_switchdev_port_unoffload(p, b->ctx, b->atomic_nb,
 					    b->blocking_nb);
 		break;
+	case SWITCHDEV_BRPORT_REPLAY:
+		brport_info = ptr;
+		b = &brport_info->brport;
+
+		err = br_switchdev_port_replay(p, b->dev, b->ctx, b->atomic_nb,
+					       b->blocking_nb, extack);
+		err = notifier_from_errno(err);
+		break;
 	}
 
 out:
diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
index a63b32c1638e..a69774131535 100644
--- a/net/bridge/br_private.h
+++ b/net/bridge/br_private.h
@@ -2115,6 +2115,12 @@ void br_switchdev_port_unoffload(struct net_bridge_port *p, const void *ctx,
 				 struct notifier_block *atomic_nb,
 				 struct notifier_block *blocking_nb);
 
+int br_switchdev_port_replay(struct net_bridge_port *p,
+			     struct net_device *dev, const void *ctx,
+			     struct notifier_block *atomic_nb,
+			     struct notifier_block *blocking_nb,
+			     struct netlink_ext_ack *extack);
+
 bool br_switchdev_frame_uses_tx_fwd_offload(struct sk_buff *skb);
 
 void br_switchdev_frame_set_offload_fwd_mark(struct sk_buff *skb);
@@ -2165,6 +2171,16 @@ br_switchdev_port_unoffload(struct net_bridge_port *p, const void *ctx,
 {
 }
 
+static inline int
+br_switchdev_port_replay(struct net_bridge_port *p,
+			 struct net_device *dev, const void *ctx,
+			 struct notifier_block *atomic_nb,
+			 struct notifier_block *blocking_nb,
+			 struct netlink_ext_ack *extack)
+{
+	return -EOPNOTSUPP;
+}
+
 static inline bool br_switchdev_frame_uses_tx_fwd_offload(struct sk_buff *skb)
 {
 	return false;
diff --git a/net/bridge/br_switchdev.c b/net/bridge/br_switchdev.c
index e92e0338afee..ee84e783e1df 100644
--- a/net/bridge/br_switchdev.c
+++ b/net/bridge/br_switchdev.c
@@ -829,3 +829,12 @@ void br_switchdev_port_unoffload(struct net_bridge_port *p, const void *ctx,
 
 	nbp_switchdev_del(p);
 }
+
+int br_switchdev_port_replay(struct net_bridge_port *p,
+			     struct net_device *dev, const void *ctx,
+			     struct notifier_block *atomic_nb,
+			     struct notifier_block *blocking_nb,
+			     struct netlink_ext_ack *extack)
+{
+	return nbp_switchdev_sync_objs(p, ctx, atomic_nb, blocking_nb, extack);
+}
diff --git a/net/switchdev/switchdev.c b/net/switchdev/switchdev.c
index 8cc42aea19c7..5b045284849e 100644
--- a/net/switchdev/switchdev.c
+++ b/net/switchdev/switchdev.c
@@ -862,3 +862,28 @@ void switchdev_bridge_port_unoffload(struct net_device *brport_dev,
 					  NULL);
 }
 EXPORT_SYMBOL_GPL(switchdev_bridge_port_unoffload);
+
+int switchdev_bridge_port_replay(struct net_device *brport_dev,
+				 struct net_device *dev, const void *ctx,
+				 struct notifier_block *atomic_nb,
+				 struct notifier_block *blocking_nb,
+				 struct netlink_ext_ack *extack)
+{
+	struct switchdev_notifier_brport_info brport_info = {
+		.brport = {
+			.dev = dev,
+			.ctx = ctx,
+			.atomic_nb = atomic_nb,
+			.blocking_nb = blocking_nb,
+		},
+	};
+	int err;
+
+	ASSERT_RTNL();
+
+	err = call_switchdev_blocking_notifiers(SWITCHDEV_BRPORT_REPLAY,
+						brport_dev, &brport_info.info,
+						extack);
+	return notifier_to_errno(err);
+}
+EXPORT_SYMBOL_GPL(switchdev_bridge_port_replay);
-- 
2.40.1


