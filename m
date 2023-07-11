Return-Path: <netdev+bounces-16901-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D457574F600
	for <lists+netdev@lfdr.de>; Tue, 11 Jul 2023 18:47:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E6292816B4
	for <lists+netdev@lfdr.de>; Tue, 11 Jul 2023 16:47:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3C4B1DDFD;
	Tue, 11 Jul 2023 16:45:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C13741DDC2
	for <netdev@vger.kernel.org>; Tue, 11 Jul 2023 16:45:47 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2087.outbound.protection.outlook.com [40.107.243.87])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DB49270B
	for <netdev@vger.kernel.org>; Tue, 11 Jul 2023 09:45:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cFdWhIvEfDoD2e8o+l/XmhEkBpG8Ql1ijeq07265dhdv8SCZAxj/8dXDOkcYX62OiB+t4LR8MVqKgae1ncP0G7GKt4IOnUczm5fzh8ngHWqnxqdibvlpJZcKO4SwruxkGxQRS3QV9ImVRAUF7ejcZm74d+FH+aVUvyPWNsEGce/EG0S3+H449TowqQKo55cfx8eYA8qMmc0M76zpCSz+Wz2lwBgny1Pcny42ILdzhMmVP+mrAhzMY4hw0m6jKUfrHwF5f8AnvnduRmymDdbSapW0Q33VcEGU93nkWrm9ihUSgUz5q8yfVS6cMYzYrDG1Tei47KTi/8RHGBrCmktDvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FL6ZZcLQ70GrHoXl6hQ7O25Wo8YLZ2FfaPrF7Mg2F/E=;
 b=eL6Qj5vc9PcrQYouQzW2vMnZgd5RAkUsGmqkcSLbZTSF/6asEndUQqieqyH9Y4EWMNex3wD18u/keJq/S93UapCqOprcU8RPhgezH1imoUi5nSkRC5uO8y+gc4tV9yZ8IlZrsb+7VJmNGi9ecQGhi952TpaTumZpgbr9TD+mm/USQStmeE7cfSje1rTRjMUHZtrSAUwOd1FpF+zNTxHnrjd9I+0GPIqBVkQ3Af/o3O/CLYL6dfGiKfr+2OJ2nCiEsOAqA7Kbh44qj7ZY+K1AVs0dNLy1FF9nGFd3oVvfgV9T8PW1BaF/RhhWYlfarkm9ZSp4TRwJN9uOqhiYXU6Amg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FL6ZZcLQ70GrHoXl6hQ7O25Wo8YLZ2FfaPrF7Mg2F/E=;
 b=d5uSAsSWtd1XmXTg2fhZPI8YO5J8n0ylV0ac4wymt+frXyrP87W6mN98wsnZAv207Ev3MUB769EahLZQCUMVdWB3hJTqAoOVDd+uGp9iFBNZzSqSHzaesoeaD/zXvzRXlIWSNOEMhNU5jVXix4AZq6fOA16FM5PokcrrqkuYUN7txIqNqVhgT0AG3tAxONyp8i1YmgvWtr48tg+ePWDHfXN9hV4lSpx2fFWYz0TLc935ZPGsnIh4ycPymEAnDf+ab51Okgw6bAeIacNS5iBvN/B0ZJFKVSHuAgMS+9deBgazKRqsrImKElJqSc3yW2kmCcPplkiQ4GdKytJ5uWlUWg==
Received: from MWH0EPF00056D09.namprd21.prod.outlook.com
 (2603:10b6:30f:fff2:0:1:0:9) by DS0PR12MB8294.namprd12.prod.outlook.com
 (2603:10b6:8:f4::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.31; Tue, 11 Jul
 2023 16:44:51 +0000
Received: from CO1NAM11FT055.eop-nam11.prod.protection.outlook.com
 (2a01:111:f400:7eab::205) by MWH0EPF00056D09.outlook.office365.com
 (2603:1036:d20::b) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.13 via Frontend
 Transport; Tue, 11 Jul 2023 16:44:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1NAM11FT055.mail.protection.outlook.com (10.13.175.129) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6588.20 via Frontend Transport; Tue, 11 Jul 2023 16:44:46 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Tue, 11 Jul 2023
 09:44:38 -0700
Received: from localhost.localdomain (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Tue, 11 Jul
 2023 09:44:35 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>,
	<mlxsw@nvidia.com>
Subject: [PATCH net-next 05/10] mlxsw: spectrum_acl: Add port range key element
Date: Tue, 11 Jul 2023 18:43:58 +0200
Message-ID: <f0423f6ee9e36c6b0a426bc9995f42223c48f2db.1689092769.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1NAM11FT055:EE_|DS0PR12MB8294:EE_
X-MS-Office365-Filtering-Correlation-Id: 490b8cd4-382d-4769-5dfc-08db822e22dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ErWY0W46mky1RguDSn35UTMVdborhNPy01iNoLI4XTw77Z346TyjGEFK2C/nkMMdtfXzaJND4sWh7MZOfmeJ8s+Bvp9eADjdtlPzzDqT2KZP8kwGFVU5mJurk8ICH1laB6tEAoonFkiBc9FSpi8wXlYAKHrZqtmNlY1idtT6SC4hhTdc/fUrinXHeBsxyaZ7LMFJKEOLTyG0iZSAOCQX158M3ifTwewLQkDDehc8orqCoY6Da50KlXAtL1cgpCUjcbAyOaLTLQzDkI9YNPEfRBiH4nG0ZOcsB+dl1KSWs56btJx26M4+3ClIJaSros4VU7kQ+f+g+bxU8STH/LVHR4LfAK8pBuofSi8vzTolHgkUw8HyLIBXx6084yQ70CvgJFnV3ct884c95dWz1m0l4jNaMdheKCbBXFXic1zpYJAtheHhmeIBlgfQC5cNBKqe38G5b2B7zg+LyM1P32FvJILtGIscb9nkYJSJHo94ZfYcsRSEj3TBSRMToz3qSPofUuVfrfSX+cPdLQ+doh5siTibxOl1+V6bWIGOs31u+ZhEiri0HHmFRMDAPCaNGq0U4rf7KWiixpH7Y4mgywPWc85iE9sMG7cNQ8yR7PyWcdAIpvYyV5f0dVw6r05SQ61/L0B7/YDWEGDmvXAK4TQ92qNJdzQqracrgxnU5XCmiQRoKZTUU/AowWvzoi4hS9QU3jwa/UHIPB037jVGhBWhQ1+FzHM44+I2lXxslkWsZAPECSMtOKQt0Lmm4TKZX1Hg
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(376002)(136003)(39860400002)(396003)(346002)(451199021)(36840700001)(40470700004)(46966006)(8676002)(8936002)(36860700001)(5660300002)(47076005)(2616005)(83380400001)(66574015)(16526019)(186003)(107886003)(26005)(86362001)(41300700001)(6666004)(82310400005)(336012)(426003)(316002)(356005)(7636003)(36756003)(2906002)(40460700003)(70586007)(70206006)(82740400003)(40480700001)(4326008)(110136005)(54906003)(478600001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2023 16:44:46.7093
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 490b8cd4-382d-4769-5dfc-08db822e22dc
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1NAM11FT055.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8294
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Ido Schimmel <idosch@nvidia.com>

Add the port range key element to supported key blocks so that it could
be used to match on the output of the port range registers. Each bit in
the element can be used to match on the output of the port range
register with the corresponding index.

Signed-off-by: Ido Schimmel <idosch@nvidia.com>
Reviewed-by: Petr Machata <petrm@nvidia.com>
Signed-off-by: Petr Machata <petrm@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlxsw/core_acl_flex_keys.c     | 1 +
 drivers/net/ethernet/mellanox/mlxsw/core_acl_flex_keys.h     | 1 +
 drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_flex_keys.c | 3 +++
 3 files changed, 5 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/core_acl_flex_keys.c b/drivers/net/ethernet/mellanox/mlxsw/core_acl_flex_keys.c
index f0b2963ebac3..7870327d921b 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/core_acl_flex_keys.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/core_acl_flex_keys.c
@@ -43,6 +43,7 @@ static const struct mlxsw_afk_element_info mlxsw_afk_element_infos[] = {
 	MLXSW_AFK_ELEMENT_INFO_BUF(DST_IP_32_63, 0x38, 4),
 	MLXSW_AFK_ELEMENT_INFO_BUF(DST_IP_0_31, 0x3C, 4),
 	MLXSW_AFK_ELEMENT_INFO_U32(FDB_MISS, 0x40, 0, 1),
+	MLXSW_AFK_ELEMENT_INFO_U32(L4_PORT_RANGE, 0x40, 1, 16),
 };
 
 struct mlxsw_afk {
diff --git a/drivers/net/ethernet/mellanox/mlxsw/core_acl_flex_keys.h b/drivers/net/ethernet/mellanox/mlxsw/core_acl_flex_keys.h
index 65a4abadc7db..2eac7582c31a 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/core_acl_flex_keys.h
+++ b/drivers/net/ethernet/mellanox/mlxsw/core_acl_flex_keys.h
@@ -36,6 +36,7 @@ enum mlxsw_afk_element {
 	MLXSW_AFK_ELEMENT_VIRT_ROUTER_MSB,
 	MLXSW_AFK_ELEMENT_VIRT_ROUTER_LSB,
 	MLXSW_AFK_ELEMENT_FDB_MISS,
+	MLXSW_AFK_ELEMENT_L4_PORT_RANGE,
 	MLXSW_AFK_ELEMENT_MAX,
 };
 
diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_flex_keys.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_flex_keys.c
index 4dea39f2b304..b7f58605b6c7 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_flex_keys.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_flex_keys.c
@@ -31,12 +31,14 @@ static struct mlxsw_afk_element_inst mlxsw_sp_afk_element_info_l2_smac_ex[] = {
 
 static struct mlxsw_afk_element_inst mlxsw_sp_afk_element_info_ipv4_sip[] = {
 	MLXSW_AFK_ELEMENT_INST_BUF(SRC_IP_0_31, 0x00, 4),
+	MLXSW_AFK_ELEMENT_INST_U32(L4_PORT_RANGE, 0x04, 16, 16),
 	MLXSW_AFK_ELEMENT_INST_U32(IP_PROTO, 0x08, 0, 8),
 	MLXSW_AFK_ELEMENT_INST_U32(SRC_SYS_PORT, 0x0C, 0, 16),
 };
 
 static struct mlxsw_afk_element_inst mlxsw_sp_afk_element_info_ipv4_dip[] = {
 	MLXSW_AFK_ELEMENT_INST_BUF(DST_IP_0_31, 0x00, 4),
+	MLXSW_AFK_ELEMENT_INST_U32(L4_PORT_RANGE, 0x04, 16, 16),
 	MLXSW_AFK_ELEMENT_INST_U32(IP_PROTO, 0x08, 0, 8),
 	MLXSW_AFK_ELEMENT_INST_U32(SRC_SYS_PORT, 0x0C, 0, 16),
 };
@@ -205,6 +207,7 @@ static struct mlxsw_afk_element_inst mlxsw_sp_afk_element_info_l4_0[] = {
 
 static struct mlxsw_afk_element_inst mlxsw_sp_afk_element_info_l4_2[] = {
 	MLXSW_AFK_ELEMENT_INST_U32(TCP_FLAGS, 0x04, 16, 9), /* TCP_CONTROL + TCP_ECN */
+	MLXSW_AFK_ELEMENT_INST_U32(L4_PORT_RANGE, 0x04, 0, 16),
 };
 
 static const struct mlxsw_afk_block mlxsw_sp2_afk_blocks[] = {
-- 
2.40.1


