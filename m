Return-Path: <netdev+bounces-16896-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 41C3D74F5F8
	for <lists+netdev@lfdr.de>; Tue, 11 Jul 2023 18:45:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 640071C20A63
	for <lists+netdev@lfdr.de>; Tue, 11 Jul 2023 16:45:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EBCD1DDC3;
	Tue, 11 Jul 2023 16:45:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C61F1DDC2
	for <netdev@vger.kernel.org>; Tue, 11 Jul 2023 16:45:29 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2084.outbound.protection.outlook.com [40.107.212.84])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48D941739
	for <netdev@vger.kernel.org>; Tue, 11 Jul 2023 09:45:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KSLaKNKirbvgP3mAZo623uwLSx+vovCHhl6ypwJ26k0ujpqqqELe8AL9HDHL7IqwyfZ1jMZUBJCqmOZBs10eL1BiUzJtDOzChWtb9JIZOoCf2s2ijwOC+uao0UYZq4WPqqCXBQu13ntPpzIw0Efwb8ryJk9wmryXKQA5V//vFzD+vST0SUQAdKOY4tTjitD6WC8qE4Vz20X4yiYeCt0uKiwfSax5a9wdf7z5LzmiwFDkoLosYmQ+nujy7aHx+yq0Sp+1pSnsoZERjux+J3o9Q2c5Fgwj8WaMr8A92EYsxTjia0myk7lmg/L0tkz0h1o0iF//7WuTNKfBNSuhrxyoqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EJmQ0cZRqowf7BBTeJlaa4X0lIuHWib0QjBw6WSXFII=;
 b=OOmu9cIHSSKq08vuuhzrUr6F5IVp63QZT9C1MgeDnGb9zz9eRrPCJGKz9HM+t+AC1GDq0ctxPyYdx+Bx4LtWwg8NMuvVenm8quXwxv34FhJvW6zm0P2jRp3tQIdvIbKAzOkyeWZMPyku+5mOtikCkWVfGIRyf8D8R0bAuPt3kG/O+Y1TNLsfXbDRHDMFkEwQLzM/PH9RUvn8CKzL+jkDwUkbLp9Slr0qEppmtxG02Bv7GPE76mjiySzmbP3vlRS3QgU4CSCaKKf4TWIOleTKWJGqKydm+gSGpqNBj6tJcNlZcAgCtFfIIN/oh+c5lvdP5354XQI7glFa4Qj5oVzk8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EJmQ0cZRqowf7BBTeJlaa4X0lIuHWib0QjBw6WSXFII=;
 b=f1z3+iI2S2qpzwxhyk70/a7aMQleA14V5kwaE7rHBY88VMAdCx0MDtflZrAoY5CMNrSgr/asUUgI6bE3su4plsMChKKN25FqCoWP3C4BqMcsT4Uw3wa/7i+zbiMEtEIoQktovdTSg5d8mhsJ7mrNyUaivYaKO4ZhsIpZisUlrKIU3CbaajogHioMLbBYbBfNEbrPy/3u3LH5gOpEmI3iv4xuB30dRUPE6WXybVTRPYPAmiVOXNEF9I9EyekK/8pinBhIV3Ep4Z6q4AP2r3jBzfdb/qqJParo2Owcgbhqf6YqPBdw5KKWIT1uVjE7mYUCosv5JE9iWF8BPbMMa/zSlQ==
Received: from MW4PR04CA0031.namprd04.prod.outlook.com (2603:10b6:303:6a::6)
 by SN7PR12MB7129.namprd12.prod.outlook.com (2603:10b6:806:2a1::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.20; Tue, 11 Jul
 2023 16:44:40 +0000
Received: from CO1NAM11FT052.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:6a:cafe::e3) by MW4PR04CA0031.outlook.office365.com
 (2603:10b6:303:6a::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.33 via Frontend
 Transport; Tue, 11 Jul 2023 16:44:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1NAM11FT052.mail.protection.outlook.com (10.13.174.225) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6588.20 via Frontend Transport; Tue, 11 Jul 2023 16:44:39 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Tue, 11 Jul 2023
 09:44:28 -0700
Received: from localhost.localdomain (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Tue, 11 Jul
 2023 09:44:25 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>,
	<mlxsw@nvidia.com>
Subject: [PATCH net-next 01/10] mlxsw: reg: Add Policy-Engine Port Range Register
Date: Tue, 11 Jul 2023 18:43:54 +0200
Message-ID: <d1a1f53d758f7452cf5abfe006b23496076ec3e6.1689092769.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1NAM11FT052:EE_|SN7PR12MB7129:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f8830b8-d0d4-4725-bbae-08db822e1ec8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	eGhsIM+WbE15UG2PtIHRlsuOLdSCH60+m5wWDaW6bUc3s+uGfJiYSkjKSOF4Qg1tTS41P1nnzIyCPjMB054w8WvSLw3xQhurmPtmbj+PWv1NP54vEsVIA60/bbXju/2w+X0SbijVTZ1d0EJnF1suDvkrnp7IrTpzWBTNqnVGrv4BjSjgeETNBPHrfo/vt5Uuv/wOKkBQ/hiw1Wg1X5fSpDFTUBjffLWdAxr9Nzp8Xdcac6r4G9CUdn74lO8u3SIqIx1pkfzeg1HeD26yHS12YMYIxOriqRvP3/ZpJPtLipLujD+wp7ehC/CvjIpDNbhhI3IbIwe/59jvBORdUnJyOW6J7OyTqs6lDTmzeL2XAxArbiU5hJPknN2HxojdUjKMXKFiYvnUjRXJuQwFvG3J4jQHs6oQuPoI/YC1GqJl7A4QQ3z1/iUnULfjooBg2WOXxLyZcoAE2gLcbjsfg2P/ZdUynCMReFCfNixKq/iOraUl5uIeLq7XRjw3SFOrCVbI5FIW4hHNgRcwVMSZFh8gAnFUjVwkOvZmqZcBt1zpgmfpEgBkO1aC5FcLoJxUIFBtgniF+s2ywSb+3H5taS1RTGBN9ji/cvfEvNG4bftCDJ1/W1r/gzX8d3oTVBQF6wBMgt+qAN9xl24khNJkY3YOKKVRHaRkA6P+J/yTvFcc+ZQvPn5hHpg0YQ52x0iswAtpuHSRKacv00XKpuHuU6oCrPL81kQHyfPwR9Kue2S/XUc=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(376002)(346002)(136003)(451199021)(40470700004)(36840700001)(46966006)(6666004)(5660300002)(40480700001)(40460700003)(8936002)(8676002)(70586007)(70206006)(41300700001)(82310400005)(356005)(316002)(4326008)(478600001)(7636003)(54906003)(110136005)(36756003)(2616005)(47076005)(36860700001)(82740400003)(186003)(26005)(83380400001)(2906002)(336012)(426003)(86362001)(107886003)(16526019);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2023 16:44:39.8697
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f8830b8-d0d4-4725-bbae-08db822e1ec8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1NAM11FT052.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7129
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Ido Schimmel <idosch@nvidia.com>

Add the Policy-Engine Port Range Register that is used for configuring
port range identification.

Signed-off-by: Ido Schimmel <idosch@nvidia.com>
Reviewed-by: Petr Machata <petrm@nvidia.com>
Signed-off-by: Petr Machata <petrm@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlxsw/reg.h | 73 +++++++++++++++++++++++
 1 file changed, 73 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/reg.h b/drivers/net/ethernet/mellanox/mlxsw/reg.h
index 17160e867bef..0802ef964d78 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/reg.h
+++ b/drivers/net/ethernet/mellanox/mlxsw/reg.h
@@ -2790,6 +2790,78 @@ static inline void mlxsw_reg_ptar_unpack(char *payload, char *tcam_region_info)
 	mlxsw_reg_ptar_tcam_region_info_memcpy_from(payload, tcam_region_info);
 }
 
+/* PPRR - Policy-Engine Port Range Register
+ * ----------------------------------------
+ * This register is used for configuring port range identification.
+ */
+#define MLXSW_REG_PPRR_ID 0x3008
+#define MLXSW_REG_PPRR_LEN 0x14
+
+MLXSW_REG_DEFINE(pprr, MLXSW_REG_PPRR_ID, MLXSW_REG_PPRR_LEN);
+
+/* reg_pprr_ipv4
+ * Apply port range register to IPv4 packets.
+ * Access: RW
+ */
+MLXSW_ITEM32(reg, pprr, ipv4, 0x00, 31, 1);
+
+/* reg_pprr_ipv6
+ * Apply port range register to IPv6 packets.
+ * Access: RW
+ */
+MLXSW_ITEM32(reg, pprr, ipv6, 0x00, 30, 1);
+
+/* reg_pprr_src
+ * Apply port range register to source L4 ports.
+ * Access: RW
+ */
+MLXSW_ITEM32(reg, pprr, src, 0x00, 29, 1);
+
+/* reg_pprr_dst
+ * Apply port range register to destination L4 ports.
+ * Access: RW
+ */
+MLXSW_ITEM32(reg, pprr, dst, 0x00, 28, 1);
+
+/* reg_pprr_tcp
+ * Apply port range register to TCP packets.
+ * Access: RW
+ */
+MLXSW_ITEM32(reg, pprr, tcp, 0x00, 27, 1);
+
+/* reg_pprr_udp
+ * Apply port range register to UDP packets.
+ * Access: RW
+ */
+MLXSW_ITEM32(reg, pprr, udp, 0x00, 26, 1);
+
+/* reg_pprr_register_index
+ * Index of Port Range Register being accessed.
+ * Range is 0..cap_max_acl_l4_port_range-1.
+ * Access: Index
+ */
+MLXSW_ITEM32(reg, pprr, register_index, 0x00, 0, 8);
+
+/* reg_prrr_port_range_min
+ * Minimum port range for comparison.
+ * Match is defined as:
+ * port_range_min <= packet_port <= port_range_max.
+ * Access: RW
+ */
+MLXSW_ITEM32(reg, pprr, port_range_min, 0x04, 16, 16);
+
+/* reg_prrr_port_range_max
+ * Maximum port range for comparison.
+ * Access: RW
+ */
+MLXSW_ITEM32(reg, pprr, port_range_max, 0x04, 0, 16);
+
+static inline void mlxsw_reg_pprr_pack(char *payload, u8 register_index)
+{
+	MLXSW_REG_ZERO(pprr, payload);
+	mlxsw_reg_pprr_register_index_set(payload, register_index);
+}
+
 /* PPBS - Policy-Engine Policy Based Switching Register
  * ----------------------------------------------------
  * This register retrieves and sets Policy Based Switching Table entries.
@@ -12810,6 +12882,7 @@ static const struct mlxsw_reg_info *mlxsw_reg_infos[] = {
 	MLXSW_REG(pacl),
 	MLXSW_REG(pagt),
 	MLXSW_REG(ptar),
+	MLXSW_REG(pprr),
 	MLXSW_REG(ppbs),
 	MLXSW_REG(prcr),
 	MLXSW_REG(pefa),
-- 
2.40.1


