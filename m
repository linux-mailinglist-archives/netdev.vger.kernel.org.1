Return-Path: <netdev+bounces-16897-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FA1674F5F9
	for <lists+netdev@lfdr.de>; Tue, 11 Jul 2023 18:46:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE00A2818F6
	for <lists+netdev@lfdr.de>; Tue, 11 Jul 2023 16:46:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5078C1DDD6;
	Tue, 11 Jul 2023 16:45:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D48B1DDC2
	for <netdev@vger.kernel.org>; Tue, 11 Jul 2023 16:45:32 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2057.outbound.protection.outlook.com [40.107.243.57])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BD74268D
	for <netdev@vger.kernel.org>; Tue, 11 Jul 2023 09:45:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ogTCh8V08Ki40Rmp3510Gh2OxNOmlUGSNe5sIEfmRBvAqkbctMcQGE4I0HFgPhadwhMpHFh5OfX1tcJ80atUz5eyGcec0NFbMDzg07s+KBapoisp/w1giaEb6pJ7nXbaQcXXUb3xaw8QTaTDuRfOWcx3hbRa5vhs7PaIcli5fd4Qjhho12uWUl37JTuXirXyJT38yhUBpM3HpeS0knhzQtfTDP82XgzDD+iPWPm7+Z4oK3gO1Di15nWJyv0MIjvUjZGLkFQPdnxCnaSsK6C6A2r4emMdTaHGYv75Q8OSFQTVsnhMbnL0l6sejfwrBZdNSj5vdmouBFhD/hvw7pP/vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hPFXC9/IX7EVgsKX5ekXmVZUBL2eR8zNUXq97WkHlak=;
 b=k+xhS+vXHU6LfwKHZpjTadeIUMVOf4eGs/hwBP7fxQoooz3SPO4KYycp0SYeInS6LnKhqPc1dwPwvrcB6EPmG5zx9jXt4N8M4jYXJjHDX3QaPNHiYCDGvNioO1i5xHuKBOj5bwnkZQ0u+QqKvWeiFs7XNBI4wI+gclAhpAGYHkyJc7v52KzrWmeKrmhLuOgKXChIkztuY8dc5fxjSd4Ui6LPApMCbhgCwoohUNLiuMIKGw42e35CPoqb0Yj6v5poRYO1FxyaTKfvYDpVU1516l+idRKS2d98R8o0B2KWHGIpuKKz8uqmjJEMovtaEb9xbgw9mAZzPwQ6JqGOLf99Dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hPFXC9/IX7EVgsKX5ekXmVZUBL2eR8zNUXq97WkHlak=;
 b=eWa72ZoqozjlwhT7daOfAomTfzC/zwjlkyw9kvmC3iFYFExSUppoPSN8J9fSU5YVWWS+ol1yBD6NM6EemwiIuvaN5e1rBn/KjTUenB5EAjoqTxrBs0DZEVmDbjjAzkDwNfvIsZbzSO8qVER6ZjYc13tobMLiQM6RzFMKhdtvfmMPDUiuB2u5H+SsuRojCqBvmt8ttxe81Rs+WQVjgw2c4l161SGU3vtKYMKSF6XdJZiUQeNjvwzL7BKI6DrLHFfePF54tHK3me0PVhUStj+6h7DpaGbCJYRG9HC3okbjvUsNzSdkIv6Wf6nEQXRGH08sPdGMtzsecoktY60vCeSNrg==
Received: from MWH0EPF00056D06.namprd21.prod.outlook.com
 (2603:10b6:30f:fff2:0:1:0:10) by BY5PR12MB4904.namprd12.prod.outlook.com
 (2603:10b6:a03:1d3::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.32; Tue, 11 Jul
 2023 16:44:41 +0000
Received: from CO1NAM11FT055.eop-nam11.prod.protection.outlook.com
 (2a01:111:f400:7eab::204) by MWH0EPF00056D06.outlook.office365.com
 (2603:1036:d20::b) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.6 via Frontend
 Transport; Tue, 11 Jul 2023 16:44:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1NAM11FT055.mail.protection.outlook.com (10.13.175.129) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6588.20 via Frontend Transport; Tue, 11 Jul 2023 16:44:41 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Tue, 11 Jul 2023
 09:44:30 -0700
Received: from localhost.localdomain (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Tue, 11 Jul
 2023 09:44:28 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>,
	<mlxsw@nvidia.com>
Subject: [PATCH net-next 02/10] mlxsw: resource: Add resource identifier for port range registers
Date: Tue, 11 Jul 2023 18:43:55 +0200
Message-ID: <59a8fec353d5ad9fbfb7612e4a7ff61eaedad445.1689092769.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1689092769.git.petrm@nvidia.com>
References: <cover.1689092769.git.petrm@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT055:EE_|BY5PR12MB4904:EE_
X-MS-Office365-Filtering-Correlation-Id: 19456f39-8724-428f-1d2f-08db822e1fa1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	qgvp3yoVZWKcdA7rhaJcvL8fnL2F0No3FNNOfJrxaofjDh9TXP5+Ybvu+KDutShMRejR5fZl8EdR1ayf8MoSFQD7D1DgStOFv8dbPYYI+5cxQMBguh5L9hMyFna/n0nGpYx9n+0wOmum/wD585VVbJJ+947D9rb/kdWojj+snsvVlXPThqpzLvP4V5kpBnwQ/kB50+LZXyQ+N3491rrxJszw8zJtZvXn9qaJeSMyzoiXq9+v7/lF2dH8GPqHYIB1z/UuvvGaCq78DJQZQGAUItroktK99zwDbn9fnHUJUXw3tMSJA2WkitsJQYDDPPpGRING5F6S88hU/UZbPR1tUto2mTH3WJYNjcAKD7VE9pI8qhODcikX5UkV8UqQgsY/71I0haMnDUVw7Fw7bzyYoo8f/ZZxvcRRZLpR9vC90pH6TKIE2ynPupKN6maVqplsA6dCYZUn907r1ED1PVeJxVDw9BGAeMSBPPl8xRGEG4y3acsuqia1lQHsuEJl6/PwYkEeTIWZb+eJtrRUYcquNv8KR3QIgGX+lOuhSiD/N3w8VhgGnjsF6YcYv4JwmRGomZJwLZilagtDk/PrLKSR42cGZUDi6RH4MJzRJUE2xQ1FJdwDgXsQDVHDJaNirc12nZhDmtsqlzQ1TjdNrZrkOG+2lOA2S7KyFu8Lc8akWaARjfmpQbXzL1XZDj8W8C2xyZiQHVAqwFnb3ikDAXQj1iF9ENDbC0K49bQhoBIwCueh7azW9/L7L4BcgzGduIL7
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(376002)(136003)(396003)(39860400002)(346002)(451199021)(40470700004)(46966006)(36840700001)(6666004)(40460700003)(82740400003)(478600001)(110136005)(54906003)(7636003)(356005)(8676002)(5660300002)(36756003)(2906002)(86362001)(8936002)(82310400005)(4326008)(316002)(40480700001)(70206006)(70586007)(41300700001)(107886003)(26005)(36860700001)(336012)(426003)(47076005)(83380400001)(186003)(16526019)(2616005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2023 16:44:41.2878
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 19456f39-8724-428f-1d2f-08db822e1fa1
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1NAM11FT055.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4904
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Ido Schimmel <idosch@nvidia.com>

Add a resource identifier for maximum number of layer 4 port range
register so that it could be later used to query the information from
firmware.

Signed-off-by: Ido Schimmel <idosch@nvidia.com>
Reviewed-by: Petr Machata <petrm@nvidia.com>
Signed-off-by: Petr Machata <petrm@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlxsw/resources.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/resources.h b/drivers/net/ethernet/mellanox/mlxsw/resources.h
index 19ae0d1c74a8..89dd2777ec4d 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/resources.h
+++ b/drivers/net/ethernet/mellanox/mlxsw/resources.h
@@ -39,6 +39,7 @@ enum mlxsw_res_id {
 	MLXSW_RES_ID_ACL_FLEX_KEYS,
 	MLXSW_RES_ID_ACL_MAX_ACTION_PER_RULE,
 	MLXSW_RES_ID_ACL_ACTIONS_PER_SET,
+	MLXSW_RES_ID_ACL_MAX_L4_PORT_RANGE,
 	MLXSW_RES_ID_ACL_MAX_ERPT_BANKS,
 	MLXSW_RES_ID_ACL_MAX_ERPT_BANK_SIZE,
 	MLXSW_RES_ID_ACL_MAX_LARGE_KEY_ID,
@@ -99,6 +100,7 @@ static u16 mlxsw_res_ids[] = {
 	[MLXSW_RES_ID_ACL_FLEX_KEYS] = 0x2910,
 	[MLXSW_RES_ID_ACL_MAX_ACTION_PER_RULE] = 0x2911,
 	[MLXSW_RES_ID_ACL_ACTIONS_PER_SET] = 0x2912,
+	[MLXSW_RES_ID_ACL_MAX_L4_PORT_RANGE] = 0x2920,
 	[MLXSW_RES_ID_ACL_MAX_ERPT_BANKS] = 0x2940,
 	[MLXSW_RES_ID_ACL_MAX_ERPT_BANK_SIZE] = 0x2941,
 	[MLXSW_RES_ID_ACL_MAX_LARGE_KEY_ID] = 0x2942,
-- 
2.40.1


