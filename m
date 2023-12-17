Return-Path: <netdev+bounces-58324-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83642815E29
	for <lists+netdev@lfdr.de>; Sun, 17 Dec 2023 09:33:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 334DD282F3A
	for <lists+netdev@lfdr.de>; Sun, 17 Dec 2023 08:33:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F3F11874;
	Sun, 17 Dec 2023 08:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jGMynj4k"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2049.outbound.protection.outlook.com [40.107.92.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB8BF1C20
	for <netdev@vger.kernel.org>; Sun, 17 Dec 2023 08:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=epNo9uL+JOsx/tsFzn1MMoDddmwjgndrcKvDN5rr8l5lJyn+FXpaPi3aGtWA1tJh7ugC4Hxj1fkm9SHsuubbTfBxlqaxXUwQx2ymsP1beXGZotdXpEtcv4UIoWVd410TLRCOru6/SE8FZW+nGXxsn202L13z4SpQ4ARO7BMVQNJsgPSsuYqFDZ1RYRHI8MXQdMpdaUl4GKWmuGqAbvhxBcqAZqQZ9OETZGc548q1cHzcMmYVnB8eMFoi73RgyYB66Z/41BDxYHnYuu3HzaaL4NHpnaff3cHADFHQ5t3VZBBo9jM0PYsp5sniJCWCu7yfdeH072aYlj7voaW6FmTcbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QWMmYgRiye9sR2sz3THdXCaeNEc+9lS6Q3IhGB7cAYE=;
 b=Z4T82Z/XYM6lvUDnrFeb8/BF4nQlL7MAdLSO5mZMnWYv4XAfOEshB2htgC/460UcpANjcSRNgGS5CUxdT58PuS7ZFMR6qOsqO6vPJGv6ViVWlF3zYdLu2ULBUcDStqNx+PlqO0FO2IvBqU3L4yFULTH+aJdiMglxjNGerY40KdmXa+zGjbF/Ucza/DUzpoJEN++wLU4yPEpPvBuXd+0yZohyksmoq6mzaB1BrQ0FSKK+Bfa0hd5m/7XttPSdliH6q4n8koPraitMW38KwNc6LCbqt6/+wwN50ApG9uP58dHxz9L93QtodPMzMlWEu2hNraLRAUug4ozocNC0GjntBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QWMmYgRiye9sR2sz3THdXCaeNEc+9lS6Q3IhGB7cAYE=;
 b=jGMynj4k98rSfNda0NJmGoJzUW3SiWb6F9OzMjkNjExE82+zImIXX0HARxIU+bxszOOSi5yGyJ6dk+u5xnlb722vsXPQQe3Spd+aZYw9/bBOneV155QuSMetyZFjJ3DYRID+2OdaMoP+v+MmOQdXZBys45kL9ffo0Z2FKo+seXh51NWO8S1EMjF3QwHovUHABNhk4eBS295njW/SzvwWULOO5ijfwS9AH2qdvMm5P1ohyg3N60FakP4c8n3hTv9Qw1Pm+nWohF9kBcN0OigQaYFmxkTiJRIGbTNaHgV9oQBB7sWGRngAhdBRr1S3UCaJ8ss+0wUHb5PTD5i//BozCw==
Received: from CH0PR03CA0055.namprd03.prod.outlook.com (2603:10b6:610:b3::30)
 by SA3PR12MB9178.namprd12.prod.outlook.com (2603:10b6:806:396::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.36; Sun, 17 Dec
 2023 08:33:29 +0000
Received: from DS3PEPF000099DF.namprd04.prod.outlook.com
 (2603:10b6:610:b3:cafe::a3) by CH0PR03CA0055.outlook.office365.com
 (2603:10b6:610:b3::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.36 via Frontend
 Transport; Sun, 17 Dec 2023 08:33:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS3PEPF000099DF.mail.protection.outlook.com (10.167.17.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7113.14 via Frontend Transport; Sun, 17 Dec 2023 08:33:28 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Sun, 17 Dec
 2023 00:33:21 -0800
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.231.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Sun, 17 Dec 2023 00:33:18 -0800
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>, <bridge@lists.linux-foundation.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <roopa@nvidia.com>, <razor@blackwall.org>,
	<petrm@nvidia.com>, Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH net-next 1/9] bridge: add MDB state mask uAPI attribute
Date: Sun, 17 Dec 2023 10:32:36 +0200
Message-ID: <20231217083244.4076193-2-idosch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DF:EE_|SA3PR12MB9178:EE_
X-MS-Office365-Filtering-Correlation-Id: fefe37ba-bfc5-403c-f42a-08dbfedad862
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	GOWZvo5mG1VD+m9MjDpbpyNS1nDXF44B5QzIit3RwMbrfTEcCQcDam8IUSEr7QD9So0dFvuRVwgstuiFVEjyic4dCvxMJ4IAwF8CL3SyojlKcyu2TAAvsk1lny6341JgOx0iEvFDl8svJIQCnJAgv3psiJZevFYrzyaz1QRJlvJs+vr5UTOVSg+/+TL+kXfY+4oHPPl4yS2tUqSeMji8iyz/9p1PCxdPVWqVRrdV5PXnnPQMjyDb3DLKscHfeEhF7eH0qvYAN70ha1nZ7IrRF13CqZoMl+aeHhPwrcs2Hb8S0s0E+NtUm4dh6LHQqlJ4LulvlgEsFZoLIz2Llr6/RYKbVvSofA/PnxmvdaGOPnDtrYRQsJKDELPOyTAT7ohDT37sP1n/x0j6L7tZjv7Rr3fxGWj2M6WgmohoA7I0ReaiUHx/1huTkidAZ5rM47kBlOOq+dP8zo653QZOaiFnNmd4uc0uuHQmiuFoJipgOeXdGnXGzYgpQGbU5OQrOyQjIcYA0XEoay6jC8oZWmFWIMOvLsyhnemgMOiyyKwpE0mXJvd2nr1NxvMeEkxbuZ0IegWMvQsEr8xbLy9TUvwScZyLEoOmrXQqpLSjen/s3YhFk+ym99Flgavzqk/MDRtJ3+NXBN9lOU0RQSVhCBmpyEfHpwZeTh4jg9ua0NEBNTZPlCaDVi09vGPAaA3Y1fTC9pNZb4QGUOZZlt3DDHlYv8+12r/NHS+neQ3sLnXeC7/WUp2kV9gRnrQDZJ4pNoNr
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(376002)(39860400002)(136003)(346002)(396003)(230922051799003)(1800799012)(451199024)(82310400011)(64100799003)(186009)(46966006)(40470700004)(36840700001)(40480700001)(40460700003)(426003)(336012)(16526019)(26005)(2906002)(4744005)(107886003)(1076003)(6666004)(2616005)(70206006)(70586007)(4326008)(110136005)(82740400003)(316002)(36756003)(54906003)(5660300002)(83380400001)(36860700001)(41300700001)(8676002)(8936002)(478600001)(356005)(86362001)(47076005)(7636003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2023 08:33:28.8340
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fefe37ba-bfc5-403c-f42a-08dbfedad862
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099DF.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9178

Currently, the 'state' field in 'struct br_port_msg' can be set to 1 if
the MDB entry is permanent or 0 if it is temporary. Additional states
might be added in the future.

In a similar fashion to 'NDA_NDM_STATE_MASK', add an MDB state mask uAPI
attribute that will allow the upcoming bulk deletion API to bulk delete
MDB entries with a certain state or any state.

Signed-off-by: Ido Schimmel <idosch@nvidia.com>
Reviewed-by: Petr Machata <petrm@nvidia.com>
---
 include/uapi/linux/if_bridge.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/uapi/linux/if_bridge.h b/include/uapi/linux/if_bridge.h
index 2e23f99dc0f1..a5b743a2f775 100644
--- a/include/uapi/linux/if_bridge.h
+++ b/include/uapi/linux/if_bridge.h
@@ -757,6 +757,7 @@ enum {
 	MDBE_ATTR_VNI,
 	MDBE_ATTR_IFINDEX,
 	MDBE_ATTR_SRC_VNI,
+	MDBE_ATTR_STATE_MASK,
 	__MDBE_ATTR_MAX,
 };
 #define MDBE_ATTR_MAX (__MDBE_ATTR_MAX - 1)
-- 
2.40.1


