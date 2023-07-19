Return-Path: <netdev+bounces-18956-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A6AA7593AA
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 13:02:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9A2A2815F0
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 11:02:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9665012B78;
	Wed, 19 Jul 2023 11:02:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 892958830
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 11:02:18 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BD7718D
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 04:02:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VwxjEL+O3k2cIO7T9fbOaa/Lo+g2zyChw9pKLhSY5OMz+L7KSi2AgwavCEUjwI5ZFuRi7bNzwilJeDha5IBCTxCvL6fllkrZLNuxHP077hCStg7ooVhJLd7YE6rfSqrn6rmqb86Rw88aJAxf3fPbbxxnFjwf7RdmoYCnEQlaQiay9Q2OMFsNQVT8VeGm6dwgj/QMX0Fvzjvqs32xx2Vo7kpvfqzalAqwPTwy1EYU5tgyqHZpvLBJPXxh0lhEQMehAy4XOC1b8k8djPIB7yj1S65Ns7A9CFRGMQGX1uI+6v0tYYmj4jcfbqXcFFejr5gwOEwA13Hh//Kvk3+Wom93IA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nDjQ80FxKDBMZsQI1GulWLm/sHgS9qG0CVg2VFDT9Uw=;
 b=W3jrCcR1FdOVpEOULO+RFfhHlv2vd7TCPZ0PzuL5P++ZnyFg5VC8RGK+tpLjHArXYkWjeG0Xio6dKcmdiMsP6cV7rqZROIMGK1hrBytvYoM3SRVf8QOesT1xYAmxhaZKgpm+qIHTo2prnJsnqr5zoU4kU9W7JRRHhK1pWNM9IH8hb8BTHJEAyjHjW/OYdsSSqGaHCU2O14aGSFkFm//tzbI2+3aor9SVc/DEqckXbPzcaCo0VofUHv2VxqzQb+rKZ8Q7xcHwWi7Ciu50hVH0FMVM8BWwaQ3D2ETxdsY8WBjNc9RTRdzOurTFXdYJd1ypkt2ExD5aVNoJnMRvT7LMWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nDjQ80FxKDBMZsQI1GulWLm/sHgS9qG0CVg2VFDT9Uw=;
 b=Qefg1adAKoLOow2GJjS4SycoHYC4KDWKZzw3WjYK36stW62oZoUvOGByTklRa5YBilT/j7x+tjWErxJXQn3QpIpsI3oryW4Q8zRnDWpgYgzoESeNX7dUhE331jjWoMmDFrvUXQiyULtc98sGxQ0X2EcFsCFs/T/LGdn3n0k8KmSPK6wxk3p5noMLdEuf9KICgh1mINWzRdmkbSYvmyiRJT3rfOt75O84ET6jWEHouYBi0mjJIoxocxcRpWG2Rc+aDur6TiWk8awS9rTMXdq136+PYXEUh3ptobcg4UDsb1VShndpMGyyFVNQd1jaVbfQw633XXgGdgHQA+QAi4CGFA==
Received: from BN9PR03CA0668.namprd03.prod.outlook.com (2603:10b6:408:10e::13)
 by DM8PR12MB5429.namprd12.prod.outlook.com (2603:10b6:8:29::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.33; Wed, 19 Jul
 2023 11:02:15 +0000
Received: from BN8NAM11FT091.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:10e:cafe::61) by BN9PR03CA0668.outlook.office365.com
 (2603:10b6:408:10e::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.33 via Frontend
 Transport; Wed, 19 Jul 2023 11:02:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN8NAM11FT091.mail.protection.outlook.com (10.13.176.134) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6588.34 via Frontend Transport; Wed, 19 Jul 2023 11:02:14 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Wed, 19 Jul 2023
 04:02:00 -0700
Received: from localhost.localdomain (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Wed, 19 Jul
 2023 04:01:56 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>,
	Danielle Ratson <danieller@nvidia.com>, <mlxsw@nvidia.com>, Jiri Pirko
	<jiri@resnulli.us>, Ivan Vecera <ivecera@redhat.com>, Roopa Prabhu
	<roopa@nvidia.com>, Nikolay Aleksandrov <razor@blackwall.org>,
	<bridge@lists.linux-foundation.org>
Subject: [PATCH net-next 01/17] net: bridge: br_switchdev: Tolerate -EOPNOTSUPP when replaying MDB
Date: Wed, 19 Jul 2023 13:01:16 +0200
Message-ID: <009406289387d9d34b76085fa858b8cd4d287851.1689763088.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN8NAM11FT091:EE_|DM8PR12MB5429:EE_
X-MS-Office365-Filtering-Correlation-Id: bc44ff63-d99e-4d81-91f8-08db88479c37
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	BfWghTBCbM1hIzMNATIi3XqD5KxDex2zxAiyWY3Xq+PXPlUufs3u6IGYjPdU8UnR0uvruYi0L6njym7Kq/v1Qy792HNm8izNSf+5kyUCdgWUQK2JQmZnqr8HNWwfoDwwxCei4+tkz+rp5nK/FewTDiwIYc1X6hY0OudMDCWTQWLZPBLMF1JMoCPqXLVPl5EEsi30/V+JWmLXqX6KVzY5ywsjHnvdAzmwLbVEfDdLHWi/+RPdxRSSbVx3vOiX7kTpNjEzlDDWlRSAI5qvftFjbtsg5GlR4+lnT0PLXptPUSknFN+lydpqtX6ZH5ADfdIm8N3QYwbl1mtqdsLXKVAlcRRNnj8D11fVyEeAYjkkVZ3h7HRFRM6TbQKzD6upGvZFroGvq9qXYmjnw2duJRedRIbWlDR2qZvGXAHZk4dtMefuHNftz+CplBWyZMbDmb01bLBi14HLXbDT0eut/ZTbbrC1563hjyECyMfEKklkIASw8IiPKgJjvM+eA8edZ/muo8kgP2Mx1DQluvhaq7nBPllVUhrzDhY5q8FdT72Tdr5HNwZgMPeW886j5R1Fucwo+Nj2FEK1COwGg8ABnh6vq9gUpaRsOPtD/jfu/qkzO2Zz1zbcTA5PBv7pFfIsWQQcoWC5Lb0ywCJy06sg4O4b/EjLXDONasGeGPY+xcjYrgur4oGPMCOJ2GwfALm/sgyfrhAzmgSXXTQEiqmIOAnEsfdhcNFp8dJtJUotgkOiXMBn+Ozc16J/2vPqlBg2EgLS
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(39860400002)(376002)(396003)(82310400008)(451199021)(46966006)(36840700001)(40470700004)(316002)(41300700001)(4326008)(5660300002)(8676002)(8936002)(426003)(2616005)(36860700001)(83380400001)(47076005)(82740400003)(86362001)(356005)(7636003)(40480700001)(186003)(70586007)(70206006)(26005)(336012)(36756003)(16526019)(110136005)(54906003)(40460700003)(478600001)(6666004)(2906002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2023 11:02:14.5969
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bc44ff63-d99e-4d81-91f8-08db88479c37
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN8NAM11FT091.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5429
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

There are two kinds of MDB entries to be replayed: port MDB entries, and
host MDB entries. They are both replayed by br_switchdev_mdb_replay(). If
the driver supports one kind, but lacks the other, the first -EOPNOTSUPP
returned terminates the whole replay, including any further still-supported
objects in the list.

For this to cause issues, there must be MDB entries for both the host and
the port being replayed. In that case, if the driver bails out from
handling the host entry, the port entries are never replayed. However, the
replay is currently only done when a switchdev port joins a bridge. There
would be no port memberships at that point. Thus despite being erroneous,
the code does not cause observable bugs.

This is not an issue with other object kinds either, because there, each
function replays one object kind. If a driver does not support that kind,
it makes sense to bail out early. -EOPNOTSUPP is then ignored in
nbp_switchdev_sync_objs().

For MDB, suppress the -EOPNOTSUPP error code in br_switchdev_mdb_replay()
already, so that the whole list gets replayed.

The reason we need this patch is that a future patch will introduce a
replay that should be used when a front-panel port netdevice is enslaved to
a bridge lower, in particular a LAG. The LAG netdevice can already have
both host and port MDB entries. The port entries need to be replayed so
that they are offloaded on the port that joins the LAG.

Cc: Jiri Pirko <jiri@resnulli.us>
Cc: Ivan Vecera <ivecera@redhat.com>
Cc: Roopa Prabhu <roopa@nvidia.com>
Cc: Nikolay Aleksandrov <razor@blackwall.org>
Cc: bridge@lists.linux-foundation.org
Signed-off-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Danielle Ratson <danieller@nvidia.com>
---
 net/bridge/br_switchdev.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/net/bridge/br_switchdev.c b/net/bridge/br_switchdev.c
index ba95c4d74a60..e92e0338afee 100644
--- a/net/bridge/br_switchdev.c
+++ b/net/bridge/br_switchdev.c
@@ -727,6 +727,8 @@ br_switchdev_mdb_replay(struct net_device *br_dev, struct net_device *dev,
 		err = br_switchdev_mdb_replay_one(nb, dev,
 						  SWITCHDEV_OBJ_PORT_MDB(obj),
 						  action, ctx, extack);
+		if (err == -EOPNOTSUPP)
+			err = 0;
 		if (err)
 			goto out_free_mdb;
 	}
@@ -759,8 +761,10 @@ static int nbp_switchdev_sync_objs(struct net_bridge_port *p, const void *ctx,
 
 	err = br_switchdev_mdb_replay(br_dev, dev, ctx, true, blocking_nb,
 				      extack);
-	if (err && err != -EOPNOTSUPP)
+	if (err) {
+		/* -EOPNOTSUPP not propagated from MDB replay. */
 		return err;
+	}
 
 	err = br_switchdev_fdb_replay(br_dev, ctx, true, atomic_nb);
 	if (err && err != -EOPNOTSUPP)
-- 
2.40.1


