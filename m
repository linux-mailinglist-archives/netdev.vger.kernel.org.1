Return-Path: <netdev+bounces-58326-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90A39815E2B
	for <lists+netdev@lfdr.de>; Sun, 17 Dec 2023 09:33:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9DACA1C209B5
	for <lists+netdev@lfdr.de>; Sun, 17 Dec 2023 08:33:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CE861FD7;
	Sun, 17 Dec 2023 08:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YczvAJ7J"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2062.outbound.protection.outlook.com [40.107.94.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01E9E1FC2
	for <netdev@vger.kernel.org>; Sun, 17 Dec 2023 08:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VprUjP4oIIYiUwcJE2C4A7Xox6mz/B8yvYjCk/tJXiz3uf8197X9mXb4bMdw43IqfqEYak2mZ/XKPgWDc82Tv2g3q4TH7tjPfCLALbI8ldFpu+o9yreNq7roKaxPq0ysMp7/3fXFJ8t6LjdLotfK2ng4NSWH7CZdtj2udGki2qT8lawpTeBo6K4wMOSTeemMKOm5REl5LLmFNUPJwSJG8/avSvKlLlhoZxM52EQdZUGxYQtooL32MAqg3kARmEhosKs/H7Kjd1LhQTFGguZcjgAwgrZFwhU7PR43ZassnL9pOC9vM2ve1QDPIF1mKf1w3hjItwJUI54flSRE2F4tsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CycJQmkk13I716wOanrG6aFfWJEuI4+YbOGWpwh6Uvg=;
 b=bofSpmbKrPnp2qhoL+2AQnKrWEFmOoA0KdNEw6VH2wEkG88Bju1hvtWaeZmgwt3lwCQEpmB2JfEiBSlc6XQ3K3X6/vizzoDJ2vks5gi/rYeWOVZL54gmuw8brxQ5tTBb1ttHOy8azfRMUy5hAtmKlU02tyNS7Sk/ay7EIbCT4PIUJS66YS66wtJwhfK6QYPT1Vb1LbvlNu7FLvc2GGnjr6m8FpQKybG2Iowj1qeW4PHH59TJryS4eYPEP6HXpndyT4U1UJZUDRVUBt7tgtogl8dgHjEZSwx4NvByKVYE1pLmN6dnPIpxt2QglNdb0K9jmaxStqFWKdJoW5Ecii0+QA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CycJQmkk13I716wOanrG6aFfWJEuI4+YbOGWpwh6Uvg=;
 b=YczvAJ7JkI/CmpQg/uOpLbxMrinWM0oklerjI+zcSeW/+o7JamRAIuWv2gYdMYqL2ra7Ccq9npPFLyE1fJqp7Waf3eSp3waY4rw/WvbK1ClURBsiTaEkERwPvNnhIWxbO0aqDSETsIsIN9RvnEqHGQW/yfIPavRV5lbYxAMHE2DmjzmeXJN6FZUqsop8y2TWP9KNs6oU8DXvd6acgAWH+kNsP2UUoEsQKIbBAXbKi3Wfe7b1xOJ6I8me3dzf4d1JvJw5Q8qTupqmK/vZXGk8a/27D1jP8SHrffgI91QAgBAua4/2kChqvq2aKT9+Sh3QD7ppBYPu3dKgAoM91UGZ0A==
Received: from DS7PR03CA0058.namprd03.prod.outlook.com (2603:10b6:5:3b5::33)
 by SA1PR12MB6773.namprd12.prod.outlook.com (2603:10b6:806:258::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.36; Sun, 17 Dec
 2023 08:33:33 +0000
Received: from DS3PEPF000099DE.namprd04.prod.outlook.com
 (2603:10b6:5:3b5:cafe::d9) by DS7PR03CA0058.outlook.office365.com
 (2603:10b6:5:3b5::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.36 via Frontend
 Transport; Sun, 17 Dec 2023 08:33:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS3PEPF000099DE.mail.protection.outlook.com (10.167.17.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7113.14 via Frontend Transport; Sun, 17 Dec 2023 08:33:33 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Sun, 17 Dec
 2023 00:33:27 -0800
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.231.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Sun, 17 Dec 2023 00:33:24 -0800
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>, <bridge@lists.linux-foundation.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <roopa@nvidia.com>, <razor@blackwall.org>,
	<petrm@nvidia.com>, Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH net-next 3/9] net: Add MDB bulk deletion device operation
Date: Sun, 17 Dec 2023 10:32:38 +0200
Message-ID: <20231217083244.4076193-4-idosch@nvidia.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231217083244.4076193-1-idosch@nvidia.com>
References: <20231217083244.4076193-1-idosch@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DE:EE_|SA1PR12MB6773:EE_
X-MS-Office365-Filtering-Correlation-Id: 22533f4d-1117-4179-a2a3-08dbfedadb05
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	wDF8NssXhe4zd6JZEAPVHlI/pnYFg+6zlLQyNvq5gU31QlcIM5YflkVmvU6rz5Hu2p91yRNuXnZ1LaBvq1FY0/wCrXcEGlYglQ636j2f7+Gr6BETAjYfRQyW02XA1H4XUEZmxdSba2uOGhOmtE63d1oy00YHAmkp3DjGxUi1Tph83RlyekM79YIIfjzCd4RCPyLDKZavTgpBkSi12oYok1dl1GWvZY96BEqGFx56aQc1jG/MUfqzCw10+o9CmQVXYw9+z1qGcKKS4uqmAqXcU+45Mi583vp8Oig6jM572HhlxeXVDKSTVsQMzCYszghmpN2kacpv5XK64to1GxEE5F1UOJQnnqNpfNLOdGY6dwE9SyYBw+dWBLZBibjuc8ItZr691NoNyn+nU1D64qf5iJypZyW/S11R/IE04NcrrO4jGU7jArJx8gMmXYfsovViZ6tE0K6YOUEimin0+dfQev/9HhGBN9bfT1bnEvREkLhP1OSAw139sUCkKMNrzLBABs4uWaVD+n2SQSdu/PcRhV2HuozxB40kfyAM0HFXYOba8nYp55Jfv1ohgMZIa3pqigSiSv9f3cU1Im6RiUNi5opEjkrRX+aw2DgXA1g5aeW1Zu6bqfEQRgcUXUrCXZ9Y6MrtlajCcQaoEeTIXDfsfuDM9t8bPTXTMxfGqXJX0+HeHPQsIFK7OXo57C+dVd1vSXfN25xp1Wt8QazKrddF8y8ZEzVyVoilWqfKMDBHI4462/WcQ2DI+zebu3QbinUS
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(396003)(346002)(376002)(136003)(39860400002)(230922051799003)(82310400011)(186009)(64100799003)(451199024)(1800799012)(40470700004)(36840700001)(46966006)(40460700003)(82740400003)(36860700001)(83380400001)(478600001)(356005)(47076005)(7636003)(86362001)(41300700001)(8936002)(8676002)(4326008)(70206006)(2616005)(70586007)(110136005)(316002)(54906003)(36756003)(1076003)(336012)(426003)(5660300002)(26005)(16526019)(2906002)(107886003)(6666004)(40480700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2023 08:33:33.2556
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 22533f4d-1117-4179-a2a3-08dbfedadb05
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099DE.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6773

Add MDB net device operation that will be invoked by rtnetlink code in
response to received 'RTM_DELMDB' messages with the 'NLM_F_BULK' flag
set. Subsequent patches will implement the operation in the bridge and
VXLAN drivers.

Signed-off-by: Ido Schimmel <idosch@nvidia.com>
Reviewed-by: Petr Machata <petrm@nvidia.com>
---
 include/linux/netdevice.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 1b935ee341b4..75c7725e5e4f 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -1329,6 +1329,9 @@ struct netdev_net_notifier {
  * int (*ndo_mdb_del)(struct net_device *dev, struct nlattr *tb[],
  *		      struct netlink_ext_ack *extack);
  *	Deletes the MDB entry from dev.
+ * int (*ndo_mdb_del_bulk)(struct net_device *dev, struct nlattr *tb[],
+ *			   struct netlink_ext_ack *extack);
+ *	Bulk deletes MDB entries from dev.
  * int (*ndo_mdb_dump)(struct net_device *dev, struct sk_buff *skb,
  *		       struct netlink_callback *cb);
  *	Dumps MDB entries from dev. The first argument (marker) in the netlink
@@ -1611,6 +1614,9 @@ struct net_device_ops {
 	int			(*ndo_mdb_del)(struct net_device *dev,
 					       struct nlattr *tb[],
 					       struct netlink_ext_ack *extack);
+	int			(*ndo_mdb_del_bulk)(struct net_device *dev,
+						    struct nlattr *tb[],
+						    struct netlink_ext_ack *extack);
 	int			(*ndo_mdb_dump)(struct net_device *dev,
 						struct sk_buff *skb,
 						struct netlink_callback *cb);
-- 
2.40.1


