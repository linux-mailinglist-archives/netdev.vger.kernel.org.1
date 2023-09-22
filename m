Return-Path: <netdev+bounces-35867-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C93B87AB719
	for <lists+netdev@lfdr.de>; Fri, 22 Sep 2023 19:19:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by am.mirrors.kernel.org (Postfix) with ESMTP id 640971F23184
	for <lists+netdev@lfdr.de>; Fri, 22 Sep 2023 17:19:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A8D042BF0;
	Fri, 22 Sep 2023 17:19:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FEF841E47
	for <netdev@vger.kernel.org>; Fri, 22 Sep 2023 17:19:10 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2076.outbound.protection.outlook.com [40.107.94.76])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C1B2F1
	for <netdev@vger.kernel.org>; Fri, 22 Sep 2023 10:19:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YGGa5BD+sgMV3m3sVoeJiUOFogKn5yFq0y3nWjYm3ZvDzHQGUf8jR+8xl9RjeC9XJHUNmWGe9BQ4XWWEuTLT4/cjh1fMvcJfSJFhgM3R/TZRvvmf4kDKmnlvZq9ngzuOX5k74Jw0fSHaSpkynJ9kUtnU8LVNm23YxNXzeIFeYHj/DtSd0Gm3GQhXwbhwcMBbI5vcsHjRI1yMiSxv2kZkTiBCn2NJeUOhFVr/zfKTHOAmYJi4Cojx6YlZt9EDT8G+UXbXPtZ90NCukMpqT0BG/6VC+sDF1C3q0QbkDc+W2h+z2G3QHC87ZlCR4eiO/QWY21zKlK3e+m4ctGC6McYsmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WHhFbCuoCKIKtdEhK1xGQALMhADlLG1eqdNsm12KHB8=;
 b=nQ/hb0EQQPre+/jAtZ5jgJeggr+ndq3CAKKBzFqwe1fzNUJ8Kq72v09EfAUuJoS0JRA+NvXbo0jZclR+8OLmvQCVhqVLrOv7u8E6/YZRBjQ+c4rtN8U4r2CONDqFjS5f54oyukc8ZGDjCYYmO9hV4MhV+21N6VD0oBK3pM7JwaAKcmYVAJAVwjqgpTREx6N/pdmFv4VMsiC3TDXhrZG3cuCCXwN+e/AikBVfReGeNveBHvHUgMzy2VNH+TVUf4pacEBHe/EyWJ3Xw7S9bywz6FPkpcKFd2yJ1XMO42enB6YlPa0b7j81LUgiTOJAPsxRPtfWgWZQXmzXLSaWB5y7Cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WHhFbCuoCKIKtdEhK1xGQALMhADlLG1eqdNsm12KHB8=;
 b=qQTM9kDNoXZkOV7DdoHTtmDSqQlmqpIMhvKInR9/ATM5eM6ISp20GzJhfwhYHNcihY6HqfYWyXZWS3jZ3eo8qZHWFUKjIJtmNdJysH5BlGH/CrNKgi1H0C3X518UUfWbkShgapBAAsVowdwYmKoVCX5qvMFi2/tJ7QRmj8rRKfCiNCLwEvLv9psrxfy7PmDlM0zX0hReHzbkzrPIBUVFk86ks6C6TWNt/Qe4Pbi7RDBhKwAEVa+xVkvGBu938LGYo27h81XhKwjwuLDnKznhNgMyaDotj4DNrEASIANu98cxQLxUJVjPr8VQw/wNkpkh0OMxhAVwxB+kexIV6x0UDw==
Received: from MW4PR03CA0007.namprd03.prod.outlook.com (2603:10b6:303:8f::12)
 by CYYPR12MB9015.namprd12.prod.outlook.com (2603:10b6:930:c8::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.20; Fri, 22 Sep
 2023 17:19:07 +0000
Received: from MWH0EPF000971E7.namprd02.prod.outlook.com
 (2603:10b6:303:8f:cafe::3b) by MW4PR03CA0007.outlook.office365.com
 (2603:10b6:303:8f::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.34 via Frontend
 Transport; Fri, 22 Sep 2023 17:19:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MWH0EPF000971E7.mail.protection.outlook.com (10.167.243.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.14 via Frontend Transport; Fri, 22 Sep 2023 17:19:07 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Fri, 22 Sep
 2023 10:18:55 -0700
Received: from yaviefel.vdiclient.nvidia.com (10.126.231.35) by
 rnnvmail202.nvidia.com (10.129.68.7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Fri, 22 Sep 2023 10:18:52 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>, "Vadim
 Pasternak" <vadimp@nvidia.com>, <mlxsw@nvidia.com>
Subject: [PATCH net-next 1/3] mlxsw: reg: Limit MTBR register payload to a single data record
Date: Fri, 22 Sep 2023 19:18:36 +0200
Message-ID: <58bff93e616a002c7f72c687916964286591604c.1695396848.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1695396848.git.petrm@nvidia.com>
References: <cover.1695396848.git.petrm@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail202.nvidia.com (10.129.68.7)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E7:EE_|CYYPR12MB9015:EE_
X-MS-Office365-Filtering-Correlation-Id: e27b0e97-d774-4678-19c8-08dbbb90072f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	zCy3bxvchMhYKrMQtcPkU2u+pGIb1RM1WzneCvOEm5QSv7X7ByWElzSoUi29llz/Nd/Ng/yaNWGvSli5bX0KbK/QmsIRIZwhXvH9fQVsWEx6SlHEnJjYkovQvGpeC59FUA7U/ZxckMvP7kzg6puqer+mNiKShPkW7TMgs9136GNb9Z0ABRRKOAf4wUEqg8SPDkGAuKfBVZQVVWkllZ2vCGYCuS26CD/I6bCBs4FfRsviMMd3YvKpf9ma5kSXqjAt8kn/Qhqbtq/3lYLfxKVJdITfIvP4hYfq8+LuJIl/PVPQgPx6CCXgVIpfWgVhMnapyAackUVKQH9GpqZCcWeBdVfOuEid21XzrNZZxVvlOJH1zJ8DSfwRDX18BBp8U/zzTwg/GUM85KzSUrIop+vdmx84nbcmsm6w07uPFbq+pdFlrnDI0dEfgDYSGwaQvStpUShpOqmvdSF8JRZL+tY++iyqjm2SjF4lvmEXKqRS3bgQXS3CFOBQcLKkWOS85/w3LXnd1I0vGKFBbCn0DSxxzX7PluuFeSR+cL76/Np+H0+RGQ/mQpO9auBvkyu5n8WkmVgUYXTlJJJnDRunSjz+VxPoBS3TNLY0KSA7A0pqEJDzcd+ADpgzTxN1lqFzOfUChqyU7wXnRec/ip6OJPi6s0dUsF2BmvX2jIGihzmPB8JdgSRxZQMNAjpWPBsPAklfXOeSCN/EFnK9jZwPjSwWQHI8JuAkDcD5CYKIeNfL511QIREK6F81Uu3NURLfwSL3nbbqXb/rkKu4gbsbQ7tYrA==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(136003)(39860400002)(396003)(376002)(346002)(230921699003)(82310400011)(1800799009)(451199024)(186009)(46966006)(36840700001)(40470700004)(16526019)(107886003)(83380400001)(70206006)(70586007)(316002)(7696005)(6666004)(36756003)(26005)(7636003)(336012)(356005)(2616005)(426003)(478600001)(47076005)(40460700003)(110136005)(2906002)(5660300002)(82740400003)(40480700001)(54906003)(8676002)(8936002)(4326008)(86362001)(41300700001)(36860700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2023 17:19:07.1706
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e27b0e97-d774-4678-19c8-08dbbb90072f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000971E7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB9015
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Vadim Pasternak <vadimp@nvidia.com>

The MTBR register is used to read temperatures from multiple sensors in
one transaction, but the driver only reads from a single sensor in each
transaction.

Rrestrict the payload size of the MTBR register to prevent the
transmission of redundant data to the firmware.

Signed-off-by: Vadim Pasternak <vadimp@nvidia.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Signed-off-by: Petr Machata <petrm@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlxsw/core_env.c   | 2 +-
 drivers/net/ethernet/mellanox/mlxsw/core_hwmon.c | 2 +-
 drivers/net/ethernet/mellanox/mlxsw/reg.h        | 6 +++---
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/core_env.c b/drivers/net/ethernet/mellanox/mlxsw/core_env.c
index d637c0348fa1..7286f0deb5f9 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/core_env.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/core_env.c
@@ -775,7 +775,7 @@ static int mlxsw_env_module_has_temp_sensor(struct mlxsw_core *mlxsw_core,
 	int err;
 
 	mlxsw_reg_mtbr_pack(mtbr_pl, slot_index,
-			    MLXSW_REG_MTBR_BASE_MODULE_INDEX + module, 1);
+			    MLXSW_REG_MTBR_BASE_MODULE_INDEX + module);
 	err = mlxsw_reg_query(mlxsw_core, MLXSW_REG(mtbr), mtbr_pl);
 	if (err)
 		return err;
diff --git a/drivers/net/ethernet/mellanox/mlxsw/core_hwmon.c b/drivers/net/ethernet/mellanox/mlxsw/core_hwmon.c
index 0fd290d776ff..9c12e1feb643 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/core_hwmon.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/core_hwmon.c
@@ -293,7 +293,7 @@ static ssize_t mlxsw_hwmon_module_temp_fault_show(struct device *dev,
 
 	module = mlxsw_hwmon_attr->type_index - mlxsw_hwmon_dev->sensor_count;
 	mlxsw_reg_mtbr_pack(mtbr_pl, mlxsw_hwmon_dev->slot_index,
-			    MLXSW_REG_MTBR_BASE_MODULE_INDEX + module, 1);
+			    MLXSW_REG_MTBR_BASE_MODULE_INDEX + module);
 	err = mlxsw_reg_query(mlxsw_hwmon->core, MLXSW_REG(mtbr), mtbr_pl);
 	if (err) {
 		dev_err(dev, "Failed to query module temperature sensor\n");
diff --git a/drivers/net/ethernet/mellanox/mlxsw/reg.h b/drivers/net/ethernet/mellanox/mlxsw/reg.h
index ae556ddd7624..9970921ceef3 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/reg.h
+++ b/drivers/net/ethernet/mellanox/mlxsw/reg.h
@@ -9551,7 +9551,7 @@ MLXSW_ITEM_BIT_ARRAY(reg, mtwe, sensor_warning, 0x0, 0x10, 1);
 #define MLXSW_REG_MTBR_ID 0x900F
 #define MLXSW_REG_MTBR_BASE_LEN 0x10 /* base length, without records */
 #define MLXSW_REG_MTBR_REC_LEN 0x04 /* record length */
-#define MLXSW_REG_MTBR_REC_MAX_COUNT 47 /* firmware limitation */
+#define MLXSW_REG_MTBR_REC_MAX_COUNT 1
 #define MLXSW_REG_MTBR_LEN (MLXSW_REG_MTBR_BASE_LEN +	\
 			    MLXSW_REG_MTBR_REC_LEN *	\
 			    MLXSW_REG_MTBR_REC_MAX_COUNT)
@@ -9597,12 +9597,12 @@ MLXSW_ITEM32_INDEXED(reg, mtbr, rec_temp, MLXSW_REG_MTBR_BASE_LEN, 0, 16,
 		     MLXSW_REG_MTBR_REC_LEN, 0x00, false);
 
 static inline void mlxsw_reg_mtbr_pack(char *payload, u8 slot_index,
-				       u16 base_sensor_index, u8 num_rec)
+				       u16 base_sensor_index)
 {
 	MLXSW_REG_ZERO(mtbr, payload);
 	mlxsw_reg_mtbr_slot_index_set(payload, slot_index);
 	mlxsw_reg_mtbr_base_sensor_index_set(payload, base_sensor_index);
-	mlxsw_reg_mtbr_num_rec_set(payload, num_rec);
+	mlxsw_reg_mtbr_num_rec_set(payload, 1);
 }
 
 /* Error codes from temperatute reading */
-- 
2.41.0


