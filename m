Return-Path: <netdev+bounces-33144-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E52A479CD13
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 12:05:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 599A3281DA1
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 10:05:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FA7E168D2;
	Tue, 12 Sep 2023 10:01:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BCE718039
	for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 10:01:34 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2087.outbound.protection.outlook.com [40.107.237.87])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 852F0E6A
	for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 03:01:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QwmKKpO9IvbC+Y7K6BryZaVtd9mKDYD60IKEuF9XdE4lTk+xEJV0BgApmVN/FiqSqFFAF//MFyY+SzMh6eWTRvQcLHZPcRG0SdY/K8NR4T4xBU+4xiD7q3ZmNZvrt1OOpsXZhTzO3Bte/ot1N34JS5aAHFxQtnWPPNYRP29J9IZ9DpZ5jibMnxtydFIEaZTuW51Uz8LY/NJSTD/+wVgzKbAm1qnxzexbKPXujwlm0YHCHTgSk2qEHVcRuZjNDCEe1vwZck11PC+vajmTGkt8F52OnDsvwHy2tZBWKuqGcop0fgHD2sxh5gK8lckRFxMdXfcijEsaWKb5YwdW8JhF1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pa3K+d+tGObk4y9Zv/bhOSlIarCrDmSWoYqxxmm8F3I=;
 b=G0d4cqZMyhXgOQCdDGT8goohjFE79ZqCufX3w7E+HMvE0sokeX/UtaittWEccCYuR0ETR/jY60q+p01bmy4EHTKZtnIcMshMQj4NzvsvumQ3PfRY39q4fKQrOr+HeNZstyJSy5KEp/cEIIXp+ClqQG6h7txEtGV6B95JNLCq+tz/+1nLVB91GX3p1k3EuvKsHRnl2nw6YRm0IDqlWqsuoKZmeo6xfDmVRcG/N8IM+ce5qVBSFEhNXMmiqVAUlgNNi8TGVbIE4jTDsCZFTwozq+T7l8RMae8/0U6uL47LkA3YFhY48NfvNJqQuA5e2HNKnRfG2QlW/4wHULs8ideW2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pa3K+d+tGObk4y9Zv/bhOSlIarCrDmSWoYqxxmm8F3I=;
 b=Ocuy771Fqb0tA4GqyZ/whE5Mtq+Wo1pwoEcd7qXFLBQ9ppskHk6jCO9iDS1/UaDKnmfkdQzWtR9t1LSFB/uKU4PZ0/Gljtb3/MU8k4S9RksE40V2Tt/GygjPFFRDXWDzRRX+5eY3/IqxWBjD3EKQaeV3/Wa+QhYPnVM06jc7ic3gDCt8Nmm8K27gm9YUSfUDiR7RuW0ajQj6/i+Mo+tcmjTgMSl9SxIAV1folOXaOymnhwi9LoHObYVOkVkT8TpmcjVIaVJmIxfDasBJsjW0M0EZA9kCQ2sGO/xhXF43SCQ2LCYm3pwAl4zmvArkQhoBymePFpB+lZ0edKb8g8ev2Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB6069.namprd12.prod.outlook.com (2603:10b6:8:9f::13) by
 SJ1PR12MB6265.namprd12.prod.outlook.com (2603:10b6:a03:458::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.31; Tue, 12 Sep
 2023 10:01:31 +0000
Received: from DS7PR12MB6069.namprd12.prod.outlook.com
 ([fe80::8ce3:c3f6:fc3a:addb]) by DS7PR12MB6069.namprd12.prod.outlook.com
 ([fe80::8ce3:c3f6:fc3a:addb%5]) with mapi id 15.20.6768.029; Tue, 12 Sep 2023
 10:01:31 +0000
From: Aurelien Aptel <aaptel@nvidia.com>
To: linux-nvme@lists.infradead.org,
	netdev@vger.kernel.org,
	sagi@grimberg.me,
	hch@lst.de,
	kbusch@kernel.org,
	axboe@fb.com,
	chaitanyak@nvidia.com,
	davem@davemloft.net,
	kuba@kernel.org
Cc: Boris Pismenny <borisp@nvidia.com>,
	aaptel@nvidia.com,
	aurelien.aptel@gmail.com,
	smalin@nvidia.com,
	malin1024@gmail.com,
	ogerlitz@nvidia.com,
	yorayz@nvidia.com,
	galshalom@nvidia.com,
	mgurtovoy@nvidia.com
Subject: [PATCH v15 14/20] net/mlx5e: TCP flow steering for nvme-tcp acceleration
Date: Tue, 12 Sep 2023 09:59:43 +0000
Message-Id: <20230912095949.5474-15-aaptel@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230912095949.5474-1-aaptel@nvidia.com>
References: <20230912095949.5474-1-aaptel@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0117.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9d::7) To DS7PR12MB6069.namprd12.prod.outlook.com
 (2603:10b6:8:9f::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6069:EE_|SJ1PR12MB6265:EE_
X-MS-Office365-Filtering-Correlation-Id: feaf1991-2c13-499a-65bd-08dbb3773d20
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	jBtB5UdBu6aLgb9G456BxL30X7zzldzSH5HF8l9a5+MDS4txZ0974RSiAuGR1ZeWWJ9HXf1kyJ13R5A9rLFLevAUIctcHCtQKhNrkQCm0WIbtMsex0gM6T6OWNRe82Vfgqn00aPRbGowkN8AFlTa0yCuXwawD1fuNw3tdhonim2PzfX8DxK3BTSP2HoLyocblIaEunbdjDDkacNgWMh81Fp8/ZvTMA3PBjzmn1/p8cVnPmQvmcu6Zv5x96upAJNOpjkqSnep2aBYqngMylXRXX7Trgz+ml50VwVdtSZ+p0V5CkLMank0iUT4shXmAbbBNWgDKa2KNzbp4EQ/arHiHdqTmJgbvQf44MpOxL/qJnZpdMj0MPxiow4s7eKsUTlg71IqmEYnwhn+exsdQOA57kgG36c6BLr1QM9b1q/daIobctFKTLLh3L+RgS9QocN6xvAHH98AEVTnaurDr/7O03Or/FVhyL/VPYrWcgaJ/SkXcPF+C56N/WvZFSUsjISpoxjQfnJHoa8ypHQPlRhCRf2c/X/9JIROUfHKwnU2oRloQXuMQJNKUe4LhUV+IjED
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6069.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(366004)(376002)(136003)(396003)(1800799009)(186009)(451199024)(26005)(6666004)(6506007)(6486002)(83380400001)(1076003)(2616005)(107886003)(2906002)(7416002)(66556008)(316002)(66476007)(66946007)(478600001)(4326008)(5660300002)(8676002)(8936002)(36756003)(86362001)(38100700002)(6512007)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jEVwfFEZIMvLahWcZ4RZR1MMacfZpp4JBlQMB+ojntWNRbui5iA7Xx/xwYWk?=
 =?us-ascii?Q?pnxWCbIq5qu8AHuD482AA0zRpARBIDcqkFvNqVz/Uux1PN+C0y4DxKDDn2mo?=
 =?us-ascii?Q?uQjkYmIa34g52SYyoXv6swM2sSQ247Q802lXMspJlMZSrZ1/3624iNCoGpfI?=
 =?us-ascii?Q?WIRSPEmZwWMANkrtmwW33y1/AUTyF0k6iWVlvpImjLeSNqUogCrWUPXSYduO?=
 =?us-ascii?Q?kP7v16OCkjPvF6MpR1CzbkP/VCTs49PC/z5bHE7+zbUIL5HkY9JvVMRne4LO?=
 =?us-ascii?Q?2OGf9DtifiCjyBK/mGE9cEGCYKZPToWtcOjhprb6IQRjY452sNXiRxY37CXO?=
 =?us-ascii?Q?wCx5mj9zOdIwvwn1QBuTEVS5XU7NLfdNiKtjPA+RTCnJKJfXB5HRHmUUClbp?=
 =?us-ascii?Q?ECdUFCaEAdeRP0gFJURTB7pYB/AE6Pd63afK1sZiyze6N8+fZNxlHZuqg+oj?=
 =?us-ascii?Q?kt+3UtLNhVciSwxeebCCdxvXQjcRXkWJ94Rvfg9cGs8tlEWGByOSGfG/IflJ?=
 =?us-ascii?Q?UnwU0aYBQN76Cg5OGCJN85QmW7PpakLKg/MMAaqx/98DSZr8AzLawYa8yh7f?=
 =?us-ascii?Q?S+jfj+B8ctmhU+SU8lAz6FzHktpd3P92hOC+6U9WiAL1xzrLnF5dzq1Pfgp1?=
 =?us-ascii?Q?l1rGE7nNbaYXqk/mcSV7xBwqmHrA18dH5r7BYRmNRzDcopU6kv7Fx6JzrmEi?=
 =?us-ascii?Q?nOLgQRiaWeEkxWIn1yqJG69rtVqD0IO+VOADloBTZgesQpmqHN9jM/3RzJJh?=
 =?us-ascii?Q?SAyQL58dWMkMAx46cXWzfQw5wwueq3xMoHZxsXCFH+4J/FEofRQpzpO1yTYr?=
 =?us-ascii?Q?AQ7RvjYZveSLBax1cNDn1R0riFEdcpkyYSj4djwgoFnMkTeGRTpyWTBBtFqs?=
 =?us-ascii?Q?R2l51zgX+jesoiipnO0IwpFTjYJkPVFHQXUTko08/soFiLhOjt0+Azts67ZY?=
 =?us-ascii?Q?QJkStJqFw97uT/DCrZFxU6BkhYIW/MG5liB8nBgZadaztJ2L3Xoy4tHVeT+5?=
 =?us-ascii?Q?8HDASOGiX4nJRX1LPDUn9XkhxP12aep1ete+jP6BmuiuorkNE3Eg206InN5o?=
 =?us-ascii?Q?M0jDhNvxAeNOjm3itep6CN9VcPFgIvl8QHNqeYJ62DQBWSb+1TER03McU/WQ?=
 =?us-ascii?Q?NdLG3fGjbmJ3DWwg+FD+G9bECQ3JIK5h3R0p7n/RbGlXLaiQ4cn97k2R21H8?=
 =?us-ascii?Q?uOJgi5kUU7INi0z4hvExfjuiLHpx0SzbCA0rHsT9tUerm8sHqrKBOfTxRwbr?=
 =?us-ascii?Q?8+0kZqQeQZ7YcCXoMY+Zfdy/3gK6R6E+IQeyCD5GPIyxLLOrkKu6sJusEf72?=
 =?us-ascii?Q?z8LonauDuajczKkKiOXtfJw8AXRmamNVPezPVOru9vdByTqOGCmucVgPBo13?=
 =?us-ascii?Q?GrRlzDEUwwc76ma6crJGJMcl8Zj7ZvbgfmwtZqUbn76IsQsG4kZlmHf2KSk1?=
 =?us-ascii?Q?RCZwE+qYP1gWWsOBM5lYP3UW9YQmvPaYPm+7UVaIBs3j0a0wubkWANKUYtNm?=
 =?us-ascii?Q?ZpUEF6cm/+xILMxlaP/ampgQsiiQCCkpupaM8+fmadNakBetQ6Gd/YUGV10T?=
 =?us-ascii?Q?cmIt/HQWlH4zDvk2u45NqfejrrjCZFWBIpSpw9jS?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: feaf1991-2c13-499a-65bd-08dbb3773d20
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6069.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2023 10:01:31.3522
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JXQEMKABeNkzyhg5tvgpKmahY79+vymGd2fZYydNf307IrHXPysV5ZuxZ5evZuRxNjOPl5fIoDkH0R3au0SYeQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6265

From: Boris Pismenny <borisp@nvidia.com>

Both nvme-tcp and tls acceleration require tcp flow steering.
Add reference counter to share TCP flow steering structure.

Signed-off-by: Boris Pismenny <borisp@nvidia.com>
Signed-off-by: Ben Ben-Ishay <benishay@nvidia.com>
Signed-off-by: Or Gerlitz <ogerlitz@nvidia.com>
Signed-off-by: Yoray Zack <yorayz@nvidia.com>
Signed-off-by: Aurelien Aptel <aaptel@nvidia.com>
Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../ethernet/mellanox/mlx5/core/en_accel/fs_tcp.c    | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/fs_tcp.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/fs_tcp.c
index c7d191f66ad1..82a9e2a4f58b 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/fs_tcp.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/fs_tcp.c
@@ -14,6 +14,7 @@ enum accel_fs_tcp_type {
 struct mlx5e_accel_fs_tcp {
 	struct mlx5e_flow_table tables[ACCEL_FS_TCP_NUM_TYPES];
 	struct mlx5_flow_handle *default_rules[ACCEL_FS_TCP_NUM_TYPES];
+	refcount_t user_count;
 };
 
 static enum mlx5_traffic_types fs_accel2tt(enum accel_fs_tcp_type i)
@@ -361,6 +362,9 @@ void mlx5e_accel_fs_tcp_destroy(struct mlx5e_flow_steering *fs)
 	if (!accel_tcp)
 		return;
 
+	if (!refcount_dec_and_test(&accel_tcp->user_count))
+		return;
+
 	accel_fs_tcp_disable(fs);
 
 	for (i = 0; i < ACCEL_FS_TCP_NUM_TYPES; i++)
@@ -372,12 +376,17 @@ void mlx5e_accel_fs_tcp_destroy(struct mlx5e_flow_steering *fs)
 
 int mlx5e_accel_fs_tcp_create(struct mlx5e_flow_steering *fs)
 {
-	struct mlx5e_accel_fs_tcp *accel_tcp;
+	struct mlx5e_accel_fs_tcp *accel_tcp = mlx5e_fs_get_accel_tcp(fs);
 	int i, err;
 
 	if (!MLX5_CAP_FLOWTABLE_NIC_RX(mlx5e_fs_get_mdev(fs), ft_field_support.outer_ip_version))
 		return -EOPNOTSUPP;
 
+	if (accel_tcp) {
+		refcount_inc(&accel_tcp->user_count);
+		return 0;
+	}
+
 	accel_tcp = kzalloc(sizeof(*accel_tcp), GFP_KERNEL);
 	if (!accel_tcp)
 		return -ENOMEM;
@@ -393,6 +402,7 @@ int mlx5e_accel_fs_tcp_create(struct mlx5e_flow_steering *fs)
 	if (err)
 		goto err_destroy_tables;
 
+	refcount_set(&accel_tcp->user_count, 1);
 	return 0;
 
 err_destroy_tables:
-- 
2.34.1


