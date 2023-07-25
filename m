Return-Path: <netdev+bounces-20831-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D065F761800
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 14:06:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 833DB1C20E1E
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 12:06:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB9CC1F17C;
	Tue, 25 Jul 2023 12:05:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFC4F1F165
	for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 12:05:39 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2049.outbound.protection.outlook.com [40.107.223.49])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28661A3
	for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 05:05:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G+n8XpD7tjluhwhUNZiadyY0priNi6IMdW0PLhq4C5VxcbJVFXwzvKdwjBjcZVrjzlabxdJUKFKsc+Ope3GC109+UpSiACboet2jz8M0RZm/8QdfywYrVuJvEMP6lrpGYEvPyMggxk3yXxHd+2KNAzfSptENcDM22/0+T3/BbCBi+mi4POe9kMBFcGFpeBX5QF1VPaotBK4DOSK3YJmTBKa7eJEDpWl62O/3kx77Cc2iDC6jUuku0Pp90woFQpEe5sIL7JbRXLj3Ha4ZSUWMVmky1SnY4dInK2vVJo4YPPuk48Jks5DdrB+ireuBn60ZFo0ERZOYSeh/N5hwljzNwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=swaoAyLy3ZBwveei3wokr0U389qfygj92xQCudvW52c=;
 b=UIvfzeCHwpP8wzKLs5OLMQeWM4xAk7LEbKTdB15+K6VtTix3xhgOkrK6qRjZyhUgij915HmfVWieyETgjvj601pRRwVGUT5Ks5yJYVloirocavlB3xzg84ujotGPqhJVJWId1qKtJBVaONrrk6RpKklnTY/55Z+fjiF66skfQEJdZVvbC7GwbOKpFnKP7SUuuQI6oB4eQ/RlJldF7gua93Y6/pShTSQFOqb/CFksrZGjFkRBOrGuSKt7gRuekuc6jEWxRlci//anfptvPp35aIuDPSM12i+hURah+fgc5/tGYZyqFQWWdutg00Jczov/IQ+FcQnqbmB+wpZ33cH1Sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=swaoAyLy3ZBwveei3wokr0U389qfygj92xQCudvW52c=;
 b=C8zU94dVGyFYC+qb6vp4FLYt+bYSpOfWpFKw+EpDrOjqoO9HfJqUgLV5GIIT1vuLgN3BLv48897ygLj1+xctGTWLBKkHwaEc+zPpQUJt1ihXzVR8Fckq4AIEVpogrlXZ90kOPZzcFWO2o0f9kFVOOOp49B+oTi5w6xz+KpTJ669clhs55o6j06TxF0qXVQJPUP3cEDgVlReaiZyM34OQJs2bbeZC++8PewDEsQFzLDaMytyro9akSDhzr/qOzUX0kvYko+M4Uwc+D94KIutk0uo+6WfWlkEns5ZJCpcp0N8nZFi/xX54Ed18n6LUVknQd2hyuZtlhe9kzOLBtyvUzQ==
Received: from BN0PR02CA0011.namprd02.prod.outlook.com (2603:10b6:408:e4::16)
 by DS7PR12MB6264.namprd12.prod.outlook.com (2603:10b6:8:94::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.32; Tue, 25 Jul
 2023 12:05:36 +0000
Received: from BN8NAM11FT052.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e4:cafe::de) by BN0PR02CA0011.outlook.office365.com
 (2603:10b6:408:e4::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.33 via Frontend
 Transport; Tue, 25 Jul 2023 12:05:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN8NAM11FT052.mail.protection.outlook.com (10.13.177.210) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6631.29 via Frontend Transport; Tue, 25 Jul 2023 12:05:35 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Tue, 25 Jul 2023
 05:05:20 -0700
Received: from yaviefel.vdiclient.nvidia.com (10.126.231.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Tue, 25 Jul 2023 05:05:16 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>, "Amit
 Cohen" <amcohen@nvidia.com>, <mlxsw@nvidia.com>
Subject: [PATCH net-next 2/5] mlxsw: reg: Add Management Capabilities Mask Register
Date: Tue, 25 Jul 2023 14:04:02 +0200
Message-ID: <1427a3f57ba93db1c5dd4f982bfb31dd5c82356e.1690281940.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1690281940.git.petrm@nvidia.com>
References: <cover.1690281940.git.petrm@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT052:EE_|DS7PR12MB6264:EE_
X-MS-Office365-Filtering-Correlation-Id: 24f3bf33-04bd-45ec-07e2-08db8d077420
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ddCUr/2QR0EaKBhQfZ5LVtQxXIBXy5Kd+FEPFTMRGlC3hCElvQBiOmwCuo3P4QjxP4HdjO8eAzlDLTBQDEp4ufufpO6C3hFbNxo0skZ8AEACISrZG7knsELiD3Ivpd3IVy1UrH7oeLtjsEVx9LER3ED7SRIbqe0XcC6ZXOM4aWAXKSPoj8HsVpx0QocdxTMxt1wNANWChm3yKSU/rnNEHCqqVMMRTZ5NJTCl/Q7sVhJvXVAQDf3AHpEFcqf3jttU9mJ43n4bJJYaJOgVs3pYI8200TvLzX0RhlRYdko/VuuRlIAntbWG9Nv+41u9RL7gHBq/fRphAQO4vLPob+VqLaDvFAdGwP0sbHlRwrP48X5tLPEVGkYeShgIRZu+pYJe3UuAc76dSQ3+p8UN2oNFFjluAdP1nspxPHVo7VDelpV4RSlvPE/AICSmouzvMdyck2nQl6JbIe2QkqKRNKS9NN3tiHACBq+Z8WrpbojAyGratfsNYph/bbSK+n7QYIJ1dV1BWRGZHFti5C0vQLHLXcKnHhcVtNQ4awESevue+AZrcBFxv9xFufVsRxCjnrvXT0uTV6ArP5tSHYRQZuzOfY3j+IQoVBImGj0/aODSo6Pcdu80qNAoLu+EjX7rOtVEts7tH5OuiRG6w81m1q8TlIparME7GuZFyclVcyTBJffZvmsbhf1aGkz25qxPkBidLYR6qlgaTq6fVrlT5uIY2lOf1+Ly3VHCMpt8ZsH5aX7Gy8hus9mCg/qHA33triOv
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(376002)(136003)(39860400002)(451199021)(82310400008)(36840700001)(40470700004)(46966006)(6666004)(40460700003)(2906002)(36860700001)(70586007)(70206006)(4326008)(478600001)(7696005)(83380400001)(86362001)(110136005)(54906003)(426003)(186003)(36756003)(336012)(16526019)(2616005)(82740400003)(356005)(7636003)(26005)(40480700001)(107886003)(5660300002)(41300700001)(8676002)(316002)(47076005)(8936002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2023 12:05:35.3569
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 24f3bf33-04bd-45ec-07e2-08db8d077420
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN8NAM11FT052.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6264
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Amit Cohen <amcohen@nvidia.com>

MCAM register reports the device supported management features. Querying
this register exposes if features are supported with the current
firmware version in the current ASIC. Then, the driver can separate
between different implementations dynamically.

MCAM register supports querying whether the MCIA register supports 128
bytes payloads or only 48 bytes. Add support for the register as
preparation for allowing larger MCIA transactions.

Note that the access to the bits in the field 'mng_feature_cap_mask' is
not same to other mask fields in other registers. In most of the cases
bit #0 is the first one in the last dword, in MCAM register, bits #0-#31
are in the first dword and so on. Declare the mask field using bits
arrays per dword to simplify the access.

Signed-off-by: Amit Cohen <amcohen@nvidia.com>
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
Reviewed-by: Petr Machata <petrm@nvidia.com>
Signed-off-by: Petr Machata <petrm@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlxsw/reg.h | 74 +++++++++++++++++++++++
 1 file changed, 74 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/reg.h b/drivers/net/ethernet/mellanox/mlxsw/reg.h
index 4d1787c1008d..01c7d9909c19 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/reg.h
+++ b/drivers/net/ethernet/mellanox/mlxsw/reg.h
@@ -10572,6 +10572,79 @@ static inline void mlxsw_reg_mcda_pack(char *payload, u32 update_handle,
 		mlxsw_reg_mcda_data_set(payload, i, *(u32 *) &data[i * 4]);
 }
 
+/* MCAM - Management Capabilities Mask Register
+ * --------------------------------------------
+ * Reports the device supported management features.
+ */
+#define MLXSW_REG_MCAM_ID 0x907F
+#define MLXSW_REG_MCAM_LEN 0x48
+
+MLXSW_REG_DEFINE(mcam, MLXSW_REG_MCAM_ID, MLXSW_REG_MCAM_LEN);
+
+enum mlxsw_reg_mcam_feature_group {
+	/* Enhanced features. */
+	MLXSW_REG_MCAM_FEATURE_GROUP_ENHANCED_FEATURES,
+};
+
+/* reg_mcam_feature_group
+ * Feature list mask index.
+ * Access: Index
+ */
+MLXSW_ITEM32(reg, mcam, feature_group, 0x00, 16, 8);
+
+enum mlxsw_reg_mcam_mng_feature_cap_mask_bits {
+	/* If set, MCIA supports 128 bytes payloads. Otherwise, 48 bytes. */
+	MLXSW_REG_MCAM_MCIA_128B = 34,
+};
+
+#define MLXSW_REG_BYTES_PER_DWORD 0x4
+
+/* reg_mcam_mng_feature_cap_mask
+ * Supported port's enhanced features.
+ * Based on feature_group index.
+ * When bit is set, the feature is supported in the device.
+ * Access: RO
+ */
+#define MLXSW_REG_MCAM_MNG_FEATURE_CAP_MASK_DWORD(_dw_num, _offset)	 \
+	MLXSW_ITEM_BIT_ARRAY(reg, mcam, mng_feature_cap_mask_dw##_dw_num, \
+			     _offset, MLXSW_REG_BYTES_PER_DWORD, 1)
+
+/* The access to the bits in the field 'mng_feature_cap_mask' is not same to
+ * other mask fields in other registers. In most of the cases bit #0 is the
+ * first one in the last dword. In MCAM register, the first dword contains bits
+ * #0-#31 and so on, so the access to the bits is simpler using bit array per
+ * dword. Declare each dword of 'mng_feature_cap_mask' field separately.
+ */
+MLXSW_REG_MCAM_MNG_FEATURE_CAP_MASK_DWORD(0, 0x28);
+MLXSW_REG_MCAM_MNG_FEATURE_CAP_MASK_DWORD(1, 0x2C);
+MLXSW_REG_MCAM_MNG_FEATURE_CAP_MASK_DWORD(2, 0x30);
+MLXSW_REG_MCAM_MNG_FEATURE_CAP_MASK_DWORD(3, 0x34);
+
+static inline void
+mlxsw_reg_mcam_pack(char *payload, enum mlxsw_reg_mcam_feature_group feat_group)
+{
+	MLXSW_REG_ZERO(mcam, payload);
+	mlxsw_reg_mcam_feature_group_set(payload, feat_group);
+}
+
+static inline void
+mlxsw_reg_mcam_unpack(char *payload,
+		      enum mlxsw_reg_mcam_mng_feature_cap_mask_bits bit,
+		      bool *p_mng_feature_cap_val)
+{
+	int offset = bit % (MLXSW_REG_BYTES_PER_DWORD * BITS_PER_BYTE);
+	int dword = bit / (MLXSW_REG_BYTES_PER_DWORD * BITS_PER_BYTE);
+	u8 (*getters[])(const char *, u16) = {
+		mlxsw_reg_mcam_mng_feature_cap_mask_dw0_get,
+		mlxsw_reg_mcam_mng_feature_cap_mask_dw1_get,
+		mlxsw_reg_mcam_mng_feature_cap_mask_dw2_get,
+		mlxsw_reg_mcam_mng_feature_cap_mask_dw3_get,
+	};
+
+	if (!WARN_ON_ONCE(dword >= ARRAY_SIZE(getters)))
+		*p_mng_feature_cap_val = getters[dword](payload, offset);
+}
+
 /* MPSC - Monitoring Packet Sampling Configuration Register
  * --------------------------------------------------------
  * MPSC Register is used to configure the Packet Sampling mechanism.
@@ -12968,6 +13041,7 @@ static const struct mlxsw_reg_info *mlxsw_reg_infos[] = {
 	MLXSW_REG(mcqi),
 	MLXSW_REG(mcc),
 	MLXSW_REG(mcda),
+	MLXSW_REG(mcam),
 	MLXSW_REG(mpsc),
 	MLXSW_REG(mgpc),
 	MLXSW_REG(mprs),
-- 
2.41.0


