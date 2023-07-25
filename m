Return-Path: <netdev+bounces-20834-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59368761804
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 14:07:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D3261C20EA3
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 12:07:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1AC41F198;
	Tue, 25 Jul 2023 12:05:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E44901F168
	for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 12:05:46 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2077.outbound.protection.outlook.com [40.107.93.77])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B85210EF
	for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 05:05:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cr4pycxMqUkqUnHVabni4NedKN1HVPjfVRqA+uTSMwK78buE3Mu95BQ94tcIMq5rPfyJpkU+n9PtF/YOh0xWXh3t7ftgdEt7KENTkOBqMX7y/dMrN9QbeeTuhNu6Kv/CTES9h7TL+nEVafDb3YIGkr4a5mNwDDvTWZYXFBLSWWbYMdr+tEs3X3QmWzxsVD7ORF9IsGEs894T8AkJLvH48dOw/1r10ROgW+cqGeTVi5+taSYEZxUGLGRLxLvwXJTIIDRcIqenzaY8xTwNX7dxoLB5EadhWk3DW9BxPF37hxuboiKRbgXtSwJdnbyxVI+rhLZu2oVbyUG3E4bAWmi7LA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qC3FfL5nXoNyRZvP/TINhhNUkC/REqPYOOJ/jFBe+B8=;
 b=eXof61t92E9DewRFbJLzN6IpKFZmjvGy69qGUuKg0asbXG4Gvo8cIAugauJ0S9cb76vjsgOquWUnlvttUZSWx0Fnf8bSQ6k5zsRTDvy8k90NQmi8DecbQ5MwwJTSZB9zxevkNepIMvxOitH7tMS+qvK7iEEokqt9NyjG/tdXGW/5YkgWN74F5KyhclRSRPC2fPAV2qd0yGJ4s4mNeazOUrdZk/mP1CenPyiWG+1+qOJjGjSeqIDwhi8PwpmWRwAPkC1ADOdefHs5ibXYni62+rEKwU3WqjTRvCOeAtQo/RmBlyphGl7q2+JV9NJyC+dTpKrLhKgtioJp1/+IotehGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=temperror action=none header.from=nvidia.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qC3FfL5nXoNyRZvP/TINhhNUkC/REqPYOOJ/jFBe+B8=;
 b=aC3JV0dHtP+gbkAlwwSXD+yaV11GdvQ93LLa7+YMo6+4Z5tGEtR1VmCXzJhpbnZRU8a/KcyLnt++wL81Y1R62gaU7dhzqd7pQMmpcHZbLG0w54XYasXYN78V3yFeHpvkwOsgZCZb7ZXIGnfj5BFS/37/s9UBBb6sFp7UOqyc/yfVo9ofzr7P3bwWL3tAD8OsxuJotbu+Uvin6IJHdOJgBqyPn7UHLPXUk5Up5sNe3b5DG1j5e8L7Bm8kRjHFffQDD/WcXUrwRivAslQ9AS4te2HWKfVJNP1ndkxU5E5EFVWx2RXXddq7tdqBltrMaCXLD1AZANSDeAxupBTOwZX2vg==
Received: from MW3PR06CA0005.namprd06.prod.outlook.com (2603:10b6:303:2a::10)
 by CYXPR12MB9319.namprd12.prod.outlook.com (2603:10b6:930:e8::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.25; Tue, 25 Jul
 2023 12:05:43 +0000
Received: from CO1NAM11FT038.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:2a:cafe::79) by MW3PR06CA0005.outlook.office365.com
 (2603:10b6:303:2a::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.33 via Frontend
 Transport; Tue, 25 Jul 2023 12:05:43 +0000
X-MS-Exchange-Authentication-Results: spf=temperror (sender IP is
 216.228.117.160) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=temperror action=none header.from=nvidia.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of nvidia.com: DNS Timeout)
Received: from mail.nvidia.com (216.228.117.160) by
 CO1NAM11FT038.mail.protection.outlook.com (10.13.174.231) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6609.28 via Frontend Transport; Tue, 25 Jul 2023 12:05:42 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Tue, 25 Jul 2023
 05:05:29 -0700
Received: from yaviefel.vdiclient.nvidia.com (10.126.231.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Tue, 25 Jul 2023 05:05:26 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>, "Amit
 Cohen" <amcohen@nvidia.com>, <mlxsw@nvidia.com>
Subject: [PATCH net-next 5/5] mlxsw: core_env: Read transceiver module EEPROM in 128 bytes chunks
Date: Tue, 25 Jul 2023 14:04:05 +0200
Message-ID: <99d1618e8cd5acefb2f795dfde1a5b41caa07dcb.1690281940.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1NAM11FT038:EE_|CYXPR12MB9319:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ac3444a-da0e-4cf4-c8da-08db8d077890
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	dsGfvpkx0dz8ObDaIQP49w+010DcH3lUHbsgiWisQVnZ+ROWDpyg4Q2llFpHR/Kl0CPBQYHIsTFfGPE7cD9Hv3fddo0Zd2MIevrJIeeiL5y7DMTeil6/pwXqVx+hLtnLm1CNCAFVTaBRAIuDlsKJyowdvZV54Aw9suuGMzKP6Hu/0J0PU7GLVFqayS1U2PFjwjBM0DsGu6Hkq5mb/C55RoJS4NVezVE6VNvthuTQ6ABgH8nug10Q0IAwsB1/g/vRr2FWKNnqtFxIWz5dz0pUU6MNs4Fn8p2iBhVaw+lO/wlFkjZd72ax/Q673Mu/5OCp9f6OfL0/AGBGoqQP3XdU590uJnsshBwJalfI1fi99auoiFeLrECvZdul6iQdmCfDeSggdeEs83wNnd6XJTDRCItzCQecS0qxj6uSFUJN9NRXcdJPsY9cNfdeojNpP3RtvRi8jkrANu8gZkaK1lSYyJRpHXEggeADmavw63EyQUyV7YnXrMGWXJAWtdSvm27Mh2xluAVYAxrnUqJp/vUoiZ4AmSObcv35z8DbAJhYC8psC86BfwQk2RIrr7yXZITdZ60PxBy1V/q42BdEfz7s8V01rE4alM9/Ys8/3K3GJ2ahBpXyLjRbk+N8YqgECH+T0cf8UNh5rrje9+z1/03Ar4iUf3qvYKXDUrbavhDeHS5YdOEMTySEKFqYk3mu7I18qBpgADh6kkB34UcgOU5H2kWrkFwt3r4QiCWwgZ9RretzUU62XPX4XS30LMX3s4wI
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(396003)(346002)(39860400002)(82310400008)(451199021)(40470700004)(36840700001)(46966006)(70586007)(70206006)(336012)(26005)(6666004)(186003)(7696005)(316002)(4326008)(40480700001)(107886003)(41300700001)(16526019)(5660300002)(54906003)(110136005)(8676002)(8936002)(478600001)(47076005)(2616005)(356005)(426003)(36860700001)(83380400001)(63370400001)(63350400001)(2906002)(40460700003)(7636003)(82740400003)(36756003)(86362001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2023 12:05:42.9161
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ac3444a-da0e-4cf4-c8da-08db8d077890
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1NAM11FT038.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9319
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Ido Schimmel <idosch@nvidia.com>

Old firmware versions could only read up to 48 bytes from a transceiver
module's EEPROM in one go. Newer versions can read up to 128 bytes,
resulting in fewer transactions.

Query support for the new capability during driver initialization and if
supported, read up to 128 bytes in one go.

This is going to be especially useful for upcoming transceiver module
firmware flashing support.

Before:

 # perf stat -e devlink:devlink_hwmsg -- ethtool -m swp11 page 0x1 offset 128 length 128 i2c 0x50
 [...]
  Performance counter stats for 'ethtool -m swp11 page 0x1 offset 128 length 128 i2c 0x50':

                  3      devlink:devlink_hwmsg

After:

 # perf stat -e devlink:devlink_hwmsg -- ethtool -m swp11 page 0x1 offset 128 length 128 i2c 0x50
 [...]
  Performance counter stats for 'ethtool -m swp11 page 0x1 offset 128 length 128 i2c 0x50':

                  1      devlink:devlink_hwmsg

Signed-off-by: Ido Schimmel <idosch@nvidia.com>
Reviewed-by: Petr Machata <petrm@nvidia.com>
Signed-off-by: Petr Machata <petrm@nvidia.com>
---
 .../net/ethernet/mellanox/mlxsw/core_env.c    | 35 +++++++++++++++----
 drivers/net/ethernet/mellanox/mlxsw/reg.h     |  3 +-
 2 files changed, 30 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/core_env.c b/drivers/net/ethernet/mellanox/mlxsw/core_env.c
index 679f7488ba10..d637c0348fa1 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/core_env.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/core_env.c
@@ -32,6 +32,7 @@ struct mlxsw_env {
 	const struct mlxsw_bus_info *bus_info;
 	u8 max_module_count; /* Maximum number of modules per-slot. */
 	u8 num_of_slots; /* Including the main board. */
+	u8 max_eeprom_len; /* Maximum module EEPROM transaction length. */
 	struct mutex line_cards_lock; /* Protects line cards. */
 	struct mlxsw_env_line_card *line_cards[];
 };
@@ -146,6 +147,7 @@ mlxsw_env_query_module_eeprom(struct mlxsw_core *mlxsw_core, u8 slot_index,
 			      int module, u16 offset, u16 size, void *data,
 			      bool qsfp, unsigned int *p_read_size)
 {
+	struct mlxsw_env *mlxsw_env = mlxsw_core_env(mlxsw_core);
 	char mcia_pl[MLXSW_REG_MCIA_LEN];
 	char *eeprom_tmp;
 	u16 i2c_addr;
@@ -153,11 +155,7 @@ mlxsw_env_query_module_eeprom(struct mlxsw_core *mlxsw_core, u8 slot_index,
 	int status;
 	int err;
 
-	/* MCIA register accepts buffer size <= 48. Page of size 128 should be
-	 * read by chunks of size 48, 48, 32. Align the size of the last chunk
-	 * to avoid reading after the end of the page.
-	 */
-	size = min_t(u16, size, MLXSW_REG_MCIA_EEPROM_SIZE);
+	size = min_t(u16, size, mlxsw_env->max_eeprom_len);
 
 	if (offset < MLXSW_REG_MCIA_EEPROM_PAGE_LENGTH &&
 	    offset + size > MLXSW_REG_MCIA_EEPROM_PAGE_LENGTH)
@@ -489,7 +487,7 @@ mlxsw_env_get_module_eeprom_by_page(struct mlxsw_core *mlxsw_core,
 		u8 size;
 
 		size = min_t(u8, page->length - bytes_read,
-			     MLXSW_REG_MCIA_EEPROM_SIZE);
+			     mlxsw_env->max_eeprom_len);
 
 		mlxsw_reg_mcia_pack(mcia_pl, slot_index, module, page->page,
 				    device_addr + bytes_read, size,
@@ -1359,6 +1357,26 @@ static struct mlxsw_linecards_event_ops mlxsw_env_event_ops = {
 	.got_inactive = mlxsw_env_got_inactive,
 };
 
+static int mlxsw_env_max_module_eeprom_len_query(struct mlxsw_env *mlxsw_env)
+{
+	char mcam_pl[MLXSW_REG_MCAM_LEN];
+	bool mcia_128b_supported;
+	int err;
+
+	mlxsw_reg_mcam_pack(mcam_pl,
+			    MLXSW_REG_MCAM_FEATURE_GROUP_ENHANCED_FEATURES);
+	err = mlxsw_reg_query(mlxsw_env->core, MLXSW_REG(mcam), mcam_pl);
+	if (err)
+		return err;
+
+	mlxsw_reg_mcam_unpack(mcam_pl, MLXSW_REG_MCAM_MCIA_128B,
+			      &mcia_128b_supported);
+
+	mlxsw_env->max_eeprom_len = mcia_128b_supported ? 128 : 48;
+
+	return 0;
+}
+
 int mlxsw_env_init(struct mlxsw_core *mlxsw_core,
 		   const struct mlxsw_bus_info *bus_info,
 		   struct mlxsw_env **p_env)
@@ -1427,10 +1445,15 @@ int mlxsw_env_init(struct mlxsw_core *mlxsw_core,
 	if (err)
 		goto err_type_set;
 
+	err = mlxsw_env_max_module_eeprom_len_query(env);
+	if (err)
+		goto err_eeprom_len_query;
+
 	env->line_cards[0]->active = true;
 
 	return 0;
 
+err_eeprom_len_query:
 err_type_set:
 	mlxsw_env_module_event_disable(env, 0);
 err_mlxsw_env_module_event_enable:
diff --git a/drivers/net/ethernet/mellanox/mlxsw/reg.h b/drivers/net/ethernet/mellanox/mlxsw/reg.h
index 71d42bcec0cd..d4ffba7473c6 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/reg.h
+++ b/drivers/net/ethernet/mellanox/mlxsw/reg.h
@@ -9699,7 +9699,6 @@ MLXSW_ITEM32(reg, mcia, size, 0x08, 0, 16);
 
 #define MLXSW_REG_MCIA_EEPROM_PAGE_LENGTH	256
 #define MLXSW_REG_MCIA_EEPROM_UP_PAGE_LENGTH	128
-#define MLXSW_REG_MCIA_EEPROM_SIZE		48
 #define MLXSW_REG_MCIA_I2C_ADDR_LOW		0x50
 #define MLXSW_REG_MCIA_I2C_ADDR_HIGH		0x51
 #define MLXSW_REG_MCIA_PAGE0_LO_OFF		0xa0
@@ -9736,7 +9735,7 @@ enum mlxsw_reg_mcia_eeprom_module_info {
  * Bytes to read/write.
  * Access: RW
  */
-MLXSW_ITEM_BUF(reg, mcia, eeprom, 0x10, MLXSW_REG_MCIA_EEPROM_SIZE);
+MLXSW_ITEM_BUF(reg, mcia, eeprom, 0x10, 128);
 
 /* This is used to access the optional upper pages (1-3) in the QSFP+
  * memory map. Page 1 is available on offset 256 through 383, page 2 -
-- 
2.41.0


