Return-Path: <netdev+bounces-20832-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9664A761801
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 14:06:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4BD212815CF
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 12:06:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 158411F189;
	Tue, 25 Jul 2023 12:05:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 056F81F184
	for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 12:05:40 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2043.outbound.protection.outlook.com [40.107.93.43])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C93B510D1
	for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 05:05:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QtlU0hjl19Rctgbq4VoxlAYAy5uijRFKfYwmmkv38crvuUNYyvvUX+CkPxtAdayBN8oHNpgUrsH5C/LBIAInuPlaNmZs1fcpFw8I6OtpjTA7azIFNu7uZo+1gbKwT9wfnFX5QO3eYTR/uOCTXu40B1E12r+VEj2o/ZckEOQK+Z4jhXKdzE/Me0XWv67dm/CJAA2rz2WA/ghDDAkBcdueTLhxzj11XYpZsSlYqNPaDoHHrfmiCHN0UxjaNMbyfHPw6Zy+0XPdlh4zGkrxx+63YufZT+L35Hl1AHs+SSxLSsq+smabVfFhqcfAc+bv3Cvnj1s/5+vOJydh+1LhESkHkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BcvmuUD4yWVEpQJyc6WNjVFLEP5cU22GaoninZ3RgPY=;
 b=f+SOwRgS3jMLV/+EmdWJFUXY9LpRQolUYvqtjdheaWsjNbErE5E8pQ1wLtQG1Fp3Hb1vBc41mwBih8wehMesjm4zAIHvN/9Xr30UDm+teHNujfr4abG/cbHNa0iRRncCz0dZ5WAzWn67ML59ADFElHeAxaOIvvGqmpkxhXusribYt0OXlks5g5INiUb6YJoZC1VGtrGc3SLNyuFYFrB4jRJ7aRpY5PU4wcmU8b9Cjbk8G5hGyf/lI3jTdDsZj2wt8S0pZGB7ojAzi2MTCFN2e8/eKNDYQlGuXXmH/Dn1xv6Bg5O/FCuDKr8H4EVbcrBKGG6VQty8px1xXnRqelwEGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BcvmuUD4yWVEpQJyc6WNjVFLEP5cU22GaoninZ3RgPY=;
 b=gArHYMByVs+0kCPN+62ZulVfTa37IBm/pUq/OSgiVTbNAbA4M53wmRKKTo+CksgnYP2W7Gf+Ba7MIgROq/KbfcRnIX793zoNyGTbUrXYGx7HtUBLWSousiIWAbscmADxNoWbAorPmftkuJEEg8cA97i+dxhmao+RYEflE+6B4wdznQs7XyVRNYaLKvoO7L7e9vO6vhYNzAZeKRHB9UFQX4ztCsSk71+j0ZePt1d76dyYFi0wjIH7LTcrCM7o4s5ErQt/MfAOdDc+QvT8fXRDtZrEAZZ4iELG7+FZ2NKnnA/DnsBi5b7YqEz6cH16W15OjwvGcQmbpGOatV8nURNlKA==
Received: from SJ0PR03CA0282.namprd03.prod.outlook.com (2603:10b6:a03:39e::17)
 by PH7PR12MB5998.namprd12.prod.outlook.com (2603:10b6:510:1da::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.33; Tue, 25 Jul
 2023 12:05:36 +0000
Received: from CO1NAM11FT006.eop-nam11.prod.protection.outlook.com
 (2603:10b6:a03:39e:cafe::2d) by SJ0PR03CA0282.outlook.office365.com
 (2603:10b6:a03:39e::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.33 via Frontend
 Transport; Tue, 25 Jul 2023 12:05:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1NAM11FT006.mail.protection.outlook.com (10.13.174.246) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6631.25 via Frontend Transport; Tue, 25 Jul 2023 12:05:36 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Tue, 25 Jul 2023
 05:05:23 -0700
Received: from yaviefel.vdiclient.nvidia.com (10.126.231.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Tue, 25 Jul 2023 05:05:20 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>, "Amit
 Cohen" <amcohen@nvidia.com>, <mlxsw@nvidia.com>
Subject: [PATCH net-next 3/5] mlxsw: reg: Remove unused function argument
Date: Tue, 25 Jul 2023 14:04:03 +0200
Message-ID: <fb5dd22830622ceeda1c2d6431c27fccd0687aca.1690281940.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1NAM11FT006:EE_|PH7PR12MB5998:EE_
X-MS-Office365-Filtering-Correlation-Id: 2624d154-b053-4351-7ec5-08db8d0774af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	0TrQME/FUTbk9msIkv0zXsUXcCWxy7R0ahrAHV47Px3xdK/lQE4t1U4oKGT1L3HDgMA5DqDTNKMeGdP5JSMPoj++DgM4/pA8rGkewbh2sOFEz7FHcPXEydbniIapjB8ikMGv3eHBN15Puhrw5Ovhd6eGP2VgRq2XLipZ2IlvXnbIr4RvItNPimq18RFqyh/gduENIH4qX1OzIHGNCB3i8cuTILZQqg8vkPRJfI0wH6hFmFaFWdXuXxKyATVfWyy/v2+3BCpnBRoCaCG8uRk9pdULe6jmTpMt/O3P/6FkBW4c6xiRIkm42iWmkGX43aLUjH4YNa1BIYCCwvF9EmFJU8shUHml/BeijIW+gxnBQ2kMbFL8FTSRC8aW0DDvZoybXSgrtELPrAaoeKRVMh4yfL+2SGymFY+As7YfVE+DF+9rQFWXX3cTHTWxgTYRiVNNatWz0497nMAvVTqRY8VV3LBm/64xdXaghBeKvIkezNUbpaYiYtl1iOMcNEh78KV7uc3XMo5VFRawuGd5597smTbH3ykuesA6qsHYLFBrCF/ljaqVTjO2MFeVYOASMOte82Rfgob1nGiIRVkC5o2nXt0yzraLPFKemzwpkF+Umg+0ESN4z9GTOwzH8HEMVQgsu/hVyrXAymCP6Bc75CuLYXK5bc9/9tXBR22fwEG1O21ZhLToHUBlp03UnU3W3bB31vUBjwoAwJB8uvRweV3q6/djFdFdhdwdWoYhja2cOiaei6rQFzcD+v5H/MMjHPYf
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(376002)(346002)(39860400002)(82310400008)(451199021)(40470700004)(36840700001)(46966006)(2906002)(54906003)(70206006)(70586007)(426003)(2616005)(47076005)(36756003)(83380400001)(36860700001)(40480700001)(86362001)(356005)(82740400003)(7636003)(478600001)(110136005)(16526019)(7696005)(6666004)(336012)(26005)(186003)(107886003)(40460700003)(41300700001)(5660300002)(316002)(4326008)(8936002)(8676002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2023 12:05:36.4065
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2624d154-b053-4351-7ec5-08db8d0774af
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1NAM11FT006.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5998
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Ido Schimmel <idosch@nvidia.com>

The 'lock' argument is always set to the default value of '0'. Remove it
from the arguments list.

Signed-off-by: Ido Schimmel <idosch@nvidia.com>
Reviewed-by: Petr Machata <petrm@nvidia.com>
Signed-off-by: Petr Machata <petrm@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlxsw/core_env.c | 10 +++++-----
 drivers/net/ethernet/mellanox/mlxsw/reg.h      | 12 +-----------
 2 files changed, 6 insertions(+), 16 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/core_env.c b/drivers/net/ethernet/mellanox/mlxsw/core_env.c
index 0107cbc32fc7..679f7488ba10 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/core_env.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/core_env.c
@@ -111,7 +111,7 @@ mlxsw_env_validate_cable_ident(struct mlxsw_core *core, u8 slot_index, int id,
 	if (err)
 		return err;
 
-	mlxsw_reg_mcia_pack(mcia_pl, slot_index, id, 0,
+	mlxsw_reg_mcia_pack(mcia_pl, slot_index, id,
 			    MLXSW_REG_MCIA_PAGE0_LO_OFF, 0, 1,
 			    MLXSW_REG_MCIA_I2C_ADDR_LOW);
 	err = mlxsw_reg_query(core, MLXSW_REG(mcia), mcia_pl);
@@ -188,7 +188,7 @@ mlxsw_env_query_module_eeprom(struct mlxsw_core *mlxsw_core, u8 slot_index,
 		}
 	}
 
-	mlxsw_reg_mcia_pack(mcia_pl, slot_index, module, 0, page, offset, size,
+	mlxsw_reg_mcia_pack(mcia_pl, slot_index, module, page, offset, size,
 			    i2c_addr);
 
 	err = mlxsw_reg_query(mlxsw_core, MLXSW_REG(mcia), mcia_pl);
@@ -266,12 +266,12 @@ mlxsw_env_module_temp_thresholds_get(struct mlxsw_core *core, u8 slot_index,
 			page = MLXSW_REG_MCIA_TH_PAGE_CMIS_NUM;
 		else
 			page = MLXSW_REG_MCIA_TH_PAGE_NUM;
-		mlxsw_reg_mcia_pack(mcia_pl, slot_index, module, 0, page,
+		mlxsw_reg_mcia_pack(mcia_pl, slot_index, module, page,
 				    MLXSW_REG_MCIA_TH_PAGE_OFF + off,
 				    MLXSW_REG_MCIA_TH_ITEM_SIZE,
 				    MLXSW_REG_MCIA_I2C_ADDR_LOW);
 	} else {
-		mlxsw_reg_mcia_pack(mcia_pl, slot_index, module, 0,
+		mlxsw_reg_mcia_pack(mcia_pl, slot_index, module,
 				    MLXSW_REG_MCIA_PAGE0_LO,
 				    off, MLXSW_REG_MCIA_TH_ITEM_SIZE,
 				    MLXSW_REG_MCIA_I2C_ADDR_HIGH);
@@ -491,7 +491,7 @@ mlxsw_env_get_module_eeprom_by_page(struct mlxsw_core *mlxsw_core,
 		size = min_t(u8, page->length - bytes_read,
 			     MLXSW_REG_MCIA_EEPROM_SIZE);
 
-		mlxsw_reg_mcia_pack(mcia_pl, slot_index, module, 0, page->page,
+		mlxsw_reg_mcia_pack(mcia_pl, slot_index, module, page->page,
 				    device_addr + bytes_read, size,
 				    page->i2c_address);
 		mlxsw_reg_mcia_bank_number_set(mcia_pl, page->bank);
diff --git a/drivers/net/ethernet/mellanox/mlxsw/reg.h b/drivers/net/ethernet/mellanox/mlxsw/reg.h
index 01c7d9909c19..6e2ddd0aae35 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/reg.h
+++ b/drivers/net/ethernet/mellanox/mlxsw/reg.h
@@ -9635,14 +9635,6 @@ static inline void mlxsw_reg_mtbr_temp_unpack(char *payload, int rec_ind,
 
 MLXSW_REG_DEFINE(mcia, MLXSW_REG_MCIA_ID, MLXSW_REG_MCIA_LEN);
 
-/* reg_mcia_l
- * Lock bit. Setting this bit will lock the access to the specific
- * cable. Used for updating a full page in a cable EPROM. Any access
- * other then subsequence writes will fail while the port is locked.
- * Access: RW
- */
-MLXSW_ITEM32(reg, mcia, l, 0x00, 31, 1);
-
 /* reg_mcia_module
  * Module number.
  * Access: Index
@@ -9755,14 +9747,12 @@ MLXSW_ITEM_BUF(reg, mcia, eeprom, 0x10, MLXSW_REG_MCIA_EEPROM_SIZE);
 				MLXSW_REG_MCIA_EEPROM_UP_PAGE_LENGTH + 1)
 
 static inline void mlxsw_reg_mcia_pack(char *payload, u8 slot_index, u8 module,
-				       u8 lock, u8 page_number,
-				       u16 device_addr, u8 size,
+				       u8 page_number, u16 device_addr, u8 size,
 				       u8 i2c_device_addr)
 {
 	MLXSW_REG_ZERO(mcia, payload);
 	mlxsw_reg_mcia_slot_set(payload, slot_index);
 	mlxsw_reg_mcia_module_set(payload, module);
-	mlxsw_reg_mcia_l_set(payload, lock);
 	mlxsw_reg_mcia_page_number_set(payload, page_number);
 	mlxsw_reg_mcia_device_address_set(payload, device_addr);
 	mlxsw_reg_mcia_size_set(payload, size);
-- 
2.41.0


