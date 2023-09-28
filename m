Return-Path: <netdev+bounces-36869-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 315177B209C
	for <lists+netdev@lfdr.de>; Thu, 28 Sep 2023 17:11:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id D6570282E3E
	for <lists+netdev@lfdr.de>; Thu, 28 Sep 2023 15:11:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A08CE4CFDB;
	Thu, 28 Sep 2023 15:11:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB3274CFCB
	for <netdev@vger.kernel.org>; Thu, 28 Sep 2023 15:11:42 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2047.outbound.protection.outlook.com [40.107.100.47])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD2A7195
	for <netdev@vger.kernel.org>; Thu, 28 Sep 2023 08:11:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kdn9/A6WQ2bWrRD4nhhF5VOY7h1CTFWIfZ/4DZrvVCVEIEQmg9R0pkgAHYMHuEKyIx0+UjVgqapiZEp46Z5JhSYDh7CMg8TvPhCokyPkHE4Lc9gde2kUHxGjwcO88wpEprhiC+kxdjNaZwvDF+P1IAhdOqO4sLUi/vGf33yixDECd53yYdIf9XE36TA/Qtfd0GrVVwBQT3Yo+4Y5+VmKpdir0phTi8qvQWPCMLTkhabFMjI6mkCuNNd7lJUQBmBYWZCEResE5Ju4tR/B/X7dFc8NqRMp0i79mggTp5QQivQ/gK6AaAWPhuYzMqvcrQYHqQRdACUsF5dfDskjqtqhvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pa3K+d+tGObk4y9Zv/bhOSlIarCrDmSWoYqxxmm8F3I=;
 b=duDai/qVl+ErMjCUcstTZ4hACZESydPOK9hdCsCH1NwWPn2GWjj2fxWkD7uz7ncijoqiNRZr4/2WRyAD2S90xdYeoBJik7ztm523QrLcD9J374JchrJAxLlOGArD/932TNgfxZJR22y9oG7mg3JYwfBgz/A/bp8TGCbkQhvWFLxL4xmxtX4H3DfdUzYGPOWXZVpIqa7+O1opYYXEOQ5Q0vd2UxQtWORryK+VTRPlbynwIj/6Si/wLmjpXGSEuFVk3w3NBAOVYTmx0ZUx+f7jEai2XigTjL/ggQ0CvbVEHS+seqhNU20drTDbmp7TUMCA+Tnvq65039SedlN2guCHVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pa3K+d+tGObk4y9Zv/bhOSlIarCrDmSWoYqxxmm8F3I=;
 b=jMbnM/+WZUBdEUmdOE7TyoVLhooyOa3ca3DwWMHH15Gz25IFBRfOBJ2TEIwwzE2vt6Uuuqy/ODtgaxnkS1sEsB5TFRhI1pUOdRnQo+Y1Wv5sl5r2u+BaO2ICxEdtHsPTZTFAZH/Zlu1ALmIkKnVVh9gT88SAvDlEtZIw6XYTgIqhoZDKOolHJcWztBIVjfBDIdCF0a54erOIZwHUUW7pxhcb7rkpI9tjTQXRjocQVHX68LAL5Wd5Xc9MIeDrbxLvTT1KeKi3Q4icrSnUvVNl3nROtrr5NZg/TKialUZZCHnEPJ6PLckv+tU5gZS7GNtsAd9Q+OUKwffU0l1c8hLn9g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com (2603:10b6:a03:45e::8)
 by SJ0PR12MB8616.namprd12.prod.outlook.com (2603:10b6:a03:485::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.27; Thu, 28 Sep
 2023 15:11:36 +0000
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::54a7:525f:1e2a:85b1]) by SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::54a7:525f:1e2a:85b1%4]) with mapi id 15.20.6838.016; Thu, 28 Sep 2023
 15:11:36 +0000
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
Subject: [PATCH v16 14/20] net/mlx5e: TCP flow steering for nvme-tcp acceleration
Date: Thu, 28 Sep 2023 15:09:48 +0000
Message-Id: <20230928150954.1684-15-aaptel@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230928150954.1684-1-aaptel@nvidia.com>
References: <20230928150954.1684-1-aaptel@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0053.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4a::6) To SJ1PR12MB6075.namprd12.prod.outlook.com
 (2603:10b6:a03:45e::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6075:EE_|SJ0PR12MB8616:EE_
X-MS-Office365-Filtering-Correlation-Id: 71eda78d-d312-4377-1e3b-08dbc0353512
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	VldNr8AVMaApOzaEgjCMfj3KdTqSjg6a6mA/7cGBJ/I/eFTaqyBUYO1aCKCCUC8GAooVoVptYL75hwUUIyCNYTKPbUpxQ9JNNlAKjR86+nJIeVKcFqVKMxJX+QhB8DL4pywkLP72f4E2oGO4NXooFpSLL89i2IFA/GC0HE/avwsIBeP6HeYLQpf0872tHYvUibyvhhlGQWdQeiTn0VESx+JaA7rQ1VMrNAb0CqgQeChpRiYvvfk3DWykSaJqs9XCXUIqZ+wuK1a4DcnPaqIOoZwVPB6sxv5RxkgnuzLlSG5GR/kMS9y+Img5oKPokO+cxFI1UXQQrUBacWdijna/kLSsRGl+4pFQ0g4Nja4ujxGQDl07K/YIzBKQU4gYRI5mqv+5Sy7pEPbVGtM/uShSWhNIfsyRgAJupY285ftzBvExqMOY9ctY/707+c3tItcbfNFFbHB91wAD8qmvJSu0KCD9WNSihHTEET1Q0Ga0wz9jEQ50ci0zhJAg0ziJd5wOtWpaUl9QACpdkClEkFGdCV9jLcV1gfCqYvWdybM53QzCdQbikzeRRXBXcgomzAL1
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR12MB6075.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(39860400002)(346002)(136003)(366004)(230922051799003)(64100799003)(451199024)(1800799009)(186009)(478600001)(36756003)(6506007)(6666004)(66946007)(38100700002)(86362001)(107886003)(1076003)(7416002)(316002)(83380400001)(41300700001)(6486002)(2906002)(2616005)(6512007)(66556008)(5660300002)(66476007)(4326008)(8936002)(26005)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Kie9gZTg2ysa7AevkVpjheB5upuD157yw1pHwoYJj39ePWVmEVKIcJSBsued?=
 =?us-ascii?Q?Wgi2Ck/8OLa15tWKL5MvggrYxkP0yddtH/TYfs6D+mq6n6OOC1nMa8AxEtGz?=
 =?us-ascii?Q?mHsJ0dyAXfq6FlgzgeczlWd26jLCHiP2o9/U6876UidTco+yDA2LGhMBtp+J?=
 =?us-ascii?Q?QgmfAYqQFl+KcP1KBBRZasdIHXpQHJzJ9bd3HMmmnrmIaW0E/a3utoJdK7vG?=
 =?us-ascii?Q?y2scdu/tRU606kExBP49GmlaMuvyz5ZhY4DlmaW9NKJQTrufLKheEV4S6kDi?=
 =?us-ascii?Q?0XRUIvh8CgTdHU2JDSPc217fX1Hm4yyfkECxStRBhhQi+aKH4QaxRZTy+rx5?=
 =?us-ascii?Q?H9IUa5MBpqMDI0LiBvTjkGqbKfVEFTQSui8UJod+UAO1JxWDb6/HVzDIzIqx?=
 =?us-ascii?Q?JWBIzM/mL2FTka9ChTE0CwI2RFgPWKyt/ADc9I9BktHvXc1w8GPbgfWTQOJv?=
 =?us-ascii?Q?L1ohmHHTYZhRz+Fbwy+oMEqpHPToHHuz+5ZaBkMG9Pc2Wnqpb4RJgUt992a8?=
 =?us-ascii?Q?qiEvBFvP3bpM2EnGOpQOEjNLj0TQoAE1OMQwVgOa9hEyJL3fHb16RPXewlIo?=
 =?us-ascii?Q?7g20hfBXNyPp3/uhWY+Ginu1ukrj64EKKrsoGixnEV71mXFfGcDF1U3EaYa7?=
 =?us-ascii?Q?RbR5FtlVfWR+l3/JnuGQ6eGE/wFtT44rLpB6BD7UyjwDUK98pxkJkSDQVyj2?=
 =?us-ascii?Q?eMuG8w+cn+IvX/t6PeawjKNaDFibBqYDUsvF667sKbvtZsF1iGXXhHRPsEOE?=
 =?us-ascii?Q?M9jY+6MhsTMJIACVumb/jZFsKruRJtgBxRY24QSW9MgT0qcTcJ4fmwfuk/eJ?=
 =?us-ascii?Q?dpRURLkU/1zqKfC3m6bNJMqoQRKQo1OAOg5dhIsgAiAJ5SJ3J+6ldqo5cl1k?=
 =?us-ascii?Q?WvdqyHjTz5RkzhD6cKUX7AFRHa2Cdchxr+BPJaXLCp9uZ82Y6w/6sLu0yw1I?=
 =?us-ascii?Q?iN1zVbL7xVe8Oc4QziL2Y7pwOcqLVCx2a58u705ptKCAf43mBxSz8Mx7ydST?=
 =?us-ascii?Q?Fg+aSZ9PSTd7UbESC+gf77KdjCUG3uHoBkc9GTccxybGLVp6DMM7G4luIim2?=
 =?us-ascii?Q?R1PKQDuFaquBjGNoUDBUP4OQID2g3XnbEom1Gw6Sh1QQ/3Oi49hr4Ay0iveU?=
 =?us-ascii?Q?FfoO3853dB/aRnesqIJWxsn8fobiFqq4SMRm3QR3l++VrXUECAaMhyYkak5d?=
 =?us-ascii?Q?eT8wFaZrkZIMW1fGY/vycgV6t8mzwRB0ETnvTqBC++6HHpq3/ZJ4daZdRU0W?=
 =?us-ascii?Q?JxrTze6rVJiKwJcxc1kFTJ1/RiXLaHuOOD59t8Z32rsd6Sx8pCniMC78tbme?=
 =?us-ascii?Q?xW2Y9OnFX7o6fLTmgDHFKTtqzBUAzvgFzZg7FiMKJ2dl9yOK348ckKg5Qni3?=
 =?us-ascii?Q?sDboedtzsERjDsNqrwH7qxJhL03bm9Tjyf64VnCU21iStW4z9JgxuSe5ghO+?=
 =?us-ascii?Q?ylMzmZaJXRCQK+a6WNEPzkyLu5hithQ1mra+GEWubq2peJfZSh5qXwceI2AV?=
 =?us-ascii?Q?0+FmaBNuKcRuVzOO3ldEE2OG20oFNuz1+a93Rw/yHhXf7gFmQCNpTuVupmq3?=
 =?us-ascii?Q?fuHneppYbJQJjKiYnScMUny3jbIlm+kiV7aH8QMd?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71eda78d-d312-4377-1e3b-08dbc0353512
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2023 15:11:36.0606
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: azjzgapucc/aatsKZVCs+zRTQZNrY4k4PPFtYogyU4aWUYf4fXg3rbj3yjCTnsEx/riKczQCImANQSUt8brIsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8616
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

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


