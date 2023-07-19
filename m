Return-Path: <netdev+bounces-18960-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 558697593B0
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 13:03:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 86B8A1C20F54
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 11:03:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49747134B4;
	Wed, 19 Jul 2023 11:02:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34A7DC8EF
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 11:02:34 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2060.outbound.protection.outlook.com [40.107.95.60])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F7C0E4C
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 04:02:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q96J3MLbo+B3MlrYSom6o3ZwOKy2Wa/f2lAcF8Ou5YVUGOcp0GVoRQpXEu/U3Kv9hEg5s2t4ZfzJUYGWJEHEpSJKo0kDJxfNVhV0Xcs5YkNQx57nTnVzMqn106qGd067cn+NAp0B++areE+b+niDUuuTcRaPnU+8YoDC4awl2fYHYhEoDY7iym8okMI5bzmjfeyVIWE0rjqb4GftV/LAG5NPcjCB1M+wgG5nD016nXTxHf7C3RAOsMv3cPY28on+WApUkmmCYgjXrUFL+mPSqjnuFU9UTbfeFH/Bj48exXa8dX1/f/iehAI3WbP4xy/rnA8utb8CvFUCC0oCFonI9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+hXMsv2EU40EniQIDerpxIcD8XQKcwRsTa9MH6irV7g=;
 b=aTdz3bZiyZIZS6DBi7eojWKxQ6HE/34y72rxW0ULt4D4Cpf7vaEyOWJuHFpLSosEnrswkDr51Rc7l+F0/Yr6+aeYWX6R7LHctlMCln5ZSmkXB9lM7fIGYkjVRm9XfI2/B/P1zyas74vN+kAAolm4WAUM8VNTv6P4cCm89CiimLNvXjctz0/ain5m/bqtSW8nW3EPcgqjf9i+nVlrw3qjKTB5eBwwBy0o8FUKNcREXOoQedSrl1tGFN77dxTbzaywFD2f7/YK6Pg+CuRcqYLgoG0HE6p649YWdYF9lSXY/ce8iralf/mHcUqU92i0GMCsD1yFmJpvssW8Bs/8nudiNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+hXMsv2EU40EniQIDerpxIcD8XQKcwRsTa9MH6irV7g=;
 b=hwnD2E9NXxyVbj6Hr/WuvcPaRgZ+X7JLygxse+6RJC+mMX/7RRD1lMzpVKMfhG6zuj/j6LSspm84Qf/3QAUFZTa/wiE03oIbC9PB8+XPIU6B17z6IsV/wVHD5ZpQvsQHuTBirEXLt4fubiMTQUnsrEG4KHvGZlcf7WhYNhyIq/uWX9OoAODMoMRu5uKaayg8Ep4GUtOsQUMHWMLNBmb4fLNcHt0pkK4iWITb+0YjfaLY7Xd8I+xbeAzsHFru5E893bTo8X17Zq8IDM9IU+/oVLdp+BJ144JlEtdrsTDiFq5nkTVb0pL4EiY0Ey0PrirqjERqAWnI+fkdxmr4FU6VjA==
Received: from BN0PR04CA0075.namprd04.prod.outlook.com (2603:10b6:408:ea::20)
 by SJ1PR12MB6362.namprd12.prod.outlook.com (2603:10b6:a03:454::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.27; Wed, 19 Jul
 2023 11:02:28 +0000
Received: from BN8NAM11FT037.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ea:cafe::5f) by BN0PR04CA0075.outlook.office365.com
 (2603:10b6:408:ea::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.24 via Frontend
 Transport; Wed, 19 Jul 2023 11:02:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN8NAM11FT037.mail.protection.outlook.com (10.13.177.182) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6588.34 via Frontend Transport; Wed, 19 Jul 2023 11:02:27 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Wed, 19 Jul 2023
 04:02:11 -0700
Received: from localhost.localdomain (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Wed, 19 Jul
 2023 04:02:09 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>,
	Danielle Ratson <danieller@nvidia.com>, <mlxsw@nvidia.com>
Subject: [PATCH net-next 05/17] mlxsw: spectrum_router: Extract a helper to schedule neighbour work
Date: Wed, 19 Jul 2023 13:01:20 +0200
Message-ID: <a0281586f4694a72f44b399c8dae184a79e936af.1689763088.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN8NAM11FT037:EE_|SJ1PR12MB6362:EE_
X-MS-Office365-Filtering-Correlation-Id: cc820d44-237d-46fe-7ec6-08db8847a3d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ppyPRlf35q6lSmj7OEZ7Z6oQfHu8ykD3UwXvj3iBg+WYvYwEXBNAHncqJ+gj0EW+kd6hSLCksqYxA6Uu/4AN0l3UVWiIEyP9ehp0bZC8bAaPd+5cQCZbHR+rF/UgSipdqWYID9W7o8sA9lufngMN1yKk+1gWSD+t5GO8ci37tAjzIPdXq+vkgbGPXsgIeBZh0UPV8l/A+25hgYo7I0Yze4caavkzL18wcXNyxM2Bq+4QDDlPskLM9jRf96GUVmaXtEHc1aX/DARx/whZ2WtAkRu2WiWF/jxWDAxUfZa/LXGWEWWt7a+T7hJp9lclv/BKD6IX9mNB9/Vh5Vmv2SqhWpWr2M8LZrGNaR9sclVrEOYcWa3Suy+N9jC1B+ufK2782qcMf5cD+M2yzKNrAE6KQezX0SR/Mx5vQAehV7xaJSwQxZJc7GBF+lzS/Yndt5OnVVcQfhMQEdSvQD3J+d4UfE3C1AJK6IfTIom9RFYooO2iTHIhDDWJJMMggyCq6E8ouNREDXiVH3il6U2cPwBAbFeMr/7crG8XsBCocvuHTH69dfbAGz20QWz9IdywM9lyafv4l/mmVPfcEG8TnaJuMBGmeQk9kugj6ix++MsBaskAnK8WvraaqG3zEd+aucee+yANuJz7G3Z4RL/rZiWjWwRcisMbFAZrfuSkAcZFQAncQwqv+whDRda17G7Ro538pygsmGBcYvBco5p78kn1tLn+G1ZD3ed3Rud2IsCIq5MxM2a9ewqg40QteTVkyS+V3gVPyRHjLDC/2uJgIpgeTg==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(396003)(136003)(376002)(82310400008)(451199021)(46966006)(40470700004)(36840700001)(8676002)(66574015)(6666004)(54906003)(478600001)(110136005)(47076005)(36756003)(83380400001)(426003)(40460700003)(86362001)(2616005)(40480700001)(316002)(70586007)(70206006)(186003)(336012)(107886003)(26005)(82740400003)(16526019)(356005)(41300700001)(7636003)(5660300002)(2906002)(36860700001)(8936002)(4326008)(309714004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2023 11:02:27.3497
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cc820d44-237d-46fe-7ec6-08db8847a3d1
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN8NAM11FT037.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6362
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

This will come in handy for neighbour replay.

Signed-off-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Danielle Ratson <danieller@nvidia.com>
---
 .../ethernet/mellanox/mlxsw/spectrum_router.c | 25 ++++++++++++-------
 1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c
index 6b1b142c95db..18e059e94079 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c
@@ -2872,6 +2872,21 @@ static bool mlxsw_sp_dev_lower_is_port(struct net_device *dev)
 	return !!mlxsw_sp_port;
 }
 
+static int mlxsw_sp_router_schedule_neigh_work(struct mlxsw_sp_router *router,
+					       struct neighbour *n)
+{
+	struct net *net;
+
+	net = neigh_parms_net(n->parms);
+
+	/* Take a reference to ensure the neighbour won't be destructed until we
+	 * drop the reference in delayed work.
+	 */
+	neigh_clone(n);
+	return mlxsw_sp_router_schedule_work(net, router, n,
+					     mlxsw_sp_router_neigh_event_work);
+}
+
 static int mlxsw_sp_router_netevent_event(struct notifier_block *nb,
 					  unsigned long event, void *ptr)
 {
@@ -2879,7 +2894,6 @@ static int mlxsw_sp_router_netevent_event(struct notifier_block *nb,
 	unsigned long interval;
 	struct neigh_parms *p;
 	struct neighbour *n;
-	struct net *net;
 
 	router = container_of(nb, struct mlxsw_sp_router, netevent_nb);
 
@@ -2903,7 +2917,6 @@ static int mlxsw_sp_router_netevent_event(struct notifier_block *nb,
 		break;
 	case NETEVENT_NEIGH_UPDATE:
 		n = ptr;
-		net = neigh_parms_net(n->parms);
 
 		if (n->tbl->family != AF_INET && n->tbl->family != AF_INET6)
 			return NOTIFY_DONE;
@@ -2911,13 +2924,7 @@ static int mlxsw_sp_router_netevent_event(struct notifier_block *nb,
 		if (!mlxsw_sp_dev_lower_is_port(n->dev))
 			return NOTIFY_DONE;
 
-		/* Take a reference to ensure the neighbour won't be
-		 * destructed until we drop the reference in delayed
-		 * work.
-		 */
-		neigh_clone(n);
-		return mlxsw_sp_router_schedule_work(net, router, n,
-				mlxsw_sp_router_neigh_event_work);
+		return mlxsw_sp_router_schedule_neigh_work(router, n);
 
 	case NETEVENT_IPV4_MPATH_HASH_UPDATE:
 	case NETEVENT_IPV6_MPATH_HASH_UPDATE:
-- 
2.40.1


