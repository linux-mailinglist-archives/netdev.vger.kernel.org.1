Return-Path: <netdev+bounces-59776-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CCC5381C043
	for <lists+netdev@lfdr.de>; Thu, 21 Dec 2023 22:35:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 583EB1F25108
	for <lists+netdev@lfdr.de>; Thu, 21 Dec 2023 21:35:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A05247764D;
	Thu, 21 Dec 2023 21:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ofIQQeZS"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2050.outbound.protection.outlook.com [40.107.237.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2768C77638
	for <netdev@vger.kernel.org>; Thu, 21 Dec 2023 21:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HmOeoZTmT1Xrm8HzeU4UZ2f+EzMFXx1DgilDftHon86d0IClRePqY28XorD8OcVsjW6Ut6S9Gfh2hx0TLLhR6t74NuUEiZt2UJj6Ze4MxrHQ+BwprucT4mq2M60fJbcuoZrHUeWO3d7E/0C5RCYz2EWhn4ZHRQC8azFsAJWbNvNONS+mUodY2tTItrIQ/uyWLssBs0XxhZ3u4DJ5n+rofWv9M07fRrazzdY1cBbkplcxBrJANj5liVYQvCks6ulBFLYR5OPhlLxzDxL1PdL+wilzJPW5V35Wu+czsPbS391JUrtBXHNpB/enNEgCsCpqfPcHo5EngC1vBX/y14ovsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pa3K+d+tGObk4y9Zv/bhOSlIarCrDmSWoYqxxmm8F3I=;
 b=QSlJKWtqu3nVNlF8gl88xZKOP7sI8eQm2zs2n0q1IXsH71SlfMEU3QcEfwD3zsWdevxl2cWBUwelxj0sIDFnmvKlsE7ca7ag7DtHCUsk379VBBA1xPyw0AND6ccsVGQZU3U3t+LEnnBZ1UsR8biZ3BmJ6YkyI/PBoTJoilvjiKaYygtRtTX+seb2u8AASW8J0to9EvEsdd3R5CoiS6DenQkGkRkz+pRZLvNL29zUdEZKo3k0skpVisP9aqf7nk6ZCRgVONMGPJYZtDs/97nUt4Y5IhVnGNdonjrUT82uFRs5N3zwd01HXFxDuBfqI2YuUKRtJ+k5edrO3dpLiIu5NQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pa3K+d+tGObk4y9Zv/bhOSlIarCrDmSWoYqxxmm8F3I=;
 b=ofIQQeZSyPIzMhEeG2hMbrrR/6fwJFWGTmFkxRY4kdjbhiZ3o/rI3bZvO8aUryid9RKWxSmrDMdIlGO210Y8EJRIeMuQQL7JD88d6ekp4naZTvNAnXA3SUelU2JC2IyYBkJH/zZlPrI7cq6fwNmsABexNaQx6JJI094aZpGAd6dyDtt1nFt3m8R48lsiMA9Jn4Y8JKySwDN5OrWUxyWpCi13tof24JVRyb3FOfJQVvcxUAe/2HerBUaclo4TY9ummTgmapvUkGDTpecZOEj6Y66/vmhD3lDvINazTmjXPglJQK0bWuVvnDBoisQgnE/ozKFLPkKd0wYfMPTFpn0JKw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com (2603:10b6:a03:45e::8)
 by MW4PR12MB7481.namprd12.prod.outlook.com (2603:10b6:303:212::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.19; Thu, 21 Dec
 2023 21:35:13 +0000
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::eb39:938e:7503:c21e]) by SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::eb39:938e:7503:c21e%3]) with mapi id 15.20.7113.019; Thu, 21 Dec 2023
 21:35:13 +0000
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
Subject: [PATCH v22 14/20] net/mlx5e: TCP flow steering for nvme-tcp acceleration
Date: Thu, 21 Dec 2023 21:33:52 +0000
Message-Id: <20231221213358.105704-15-aaptel@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231221213358.105704-1-aaptel@nvidia.com>
References: <20231221213358.105704-1-aaptel@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0264.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:194::17) To SJ1PR12MB6075.namprd12.prod.outlook.com
 (2603:10b6:a03:45e::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6075:EE_|MW4PR12MB7481:EE_
X-MS-Office365-Filtering-Correlation-Id: 890e73f4-4c5b-40ed-fa2f-08dc026cb6e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	FCZk/HsMToerOpKAoiDzzkC8jQmZtmR81E0pUZeUwuPGQZxnLn0LUDd1CTYItJhphpIYZug5pRZagUlGJKKIFbFZMoK/kuu2ALf4YOgkdT0P22Z9VZOpggOxkfps4T3sDU4nGejnVsRVoEY/Eom20ytjYaNJc6a0xS+m4SnauSPU/JAct10cp/rnay7qK0WJERfP8pALN7roN4c0YtYX8NRmEN9nV1UdBgJ6AI1qG0lGAAHa2YirZYpzguG1owgmW1efHoVa0RRPRF8HtDwLaALU6FBNb4TbLPrGesLxedX61K9/cXZk2+TvQFbB7EuRAljZi27dVHB96PsF/uMCFN5xNXz1bZ0aNjjXB+qY4mxlB+MnD0RVTu1Pt20KEHPqVXW4noJ4XD52NMImnOsq6E9quyoL19OHbJnsb3075Tl5/QGTCTsY7+Og/JkA6yOVs/2DSbvy+WXYWH7Bm2DqflHJAGvTR3/HnFopjUFOAsKpUWLm9sc8F8RJYnfQVPntOrhy7Mi/pGmHQxa0fUdCF3pWdCc8LxmVO57vtj6f85scWdzLzkOxQaLc20KOU+KShsxMVG+FPXucVLzMJlQqKxZcFuvbuNzitLIJu/mG54U=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR12MB6075.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(396003)(39860400002)(366004)(376002)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(66946007)(8676002)(8936002)(66556008)(478600001)(66476007)(83380400001)(316002)(6666004)(7416002)(4326008)(6506007)(6512007)(6486002)(2906002)(2616005)(107886003)(26005)(1076003)(41300700001)(36756003)(5660300002)(86362001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Keh5Q+6sA+2UVd5bklJjaE7hKs1MngHj9XCqA8MZ6O4FOKbk54UvRDROIngn?=
 =?us-ascii?Q?de06oc4kIA4If0tGohh/N4ndB2xaL/Am0zUQd9IvHmokDO1od1EbyjVdK31b?=
 =?us-ascii?Q?CkEhqMgxFfvSq6X22KasIucAEF9XrP3TJHZKuvAcE5lSQl9Ba9fZrWJ+ZmoC?=
 =?us-ascii?Q?LMjjVw7WayWWGhBuEcZv23HRbiK0uwGPtwuZwjyz2CIzvl1xWoLzgd9JejXj?=
 =?us-ascii?Q?8y3VcWffgq3PaQ6hwq4uNKE/gY9fU2ETMxknQSh5aag5HRGRSlxWEMz1VJwW?=
 =?us-ascii?Q?m8EI383RHyvQRbncrJyG181iHU3Y4p6N7OXkbrngyslWGmX8JK/u5vMJ6g5z?=
 =?us-ascii?Q?gfimYRc+XCAJ+V53k2F8aQ1L6OJwQ0JZojs9u/wpOvOUZRU9Y25O/H2b1sL+?=
 =?us-ascii?Q?pvFQHDR5zFPKfZov8JnEreXJ0/H2dEYng890n9KVe6wdXZqkDMsFA9oe37Cc?=
 =?us-ascii?Q?DCIKd7PNK2slRPN4LsNb86sCdqpVPnOEtrr620KyaR1TkyZjxT4QNcE6O0z+?=
 =?us-ascii?Q?/fKDDezcgtd8WIKl7381xePhZ9XzD2uHbOyY5F4ZzjRRIuBOI3fummHUKcO+?=
 =?us-ascii?Q?3DNXQDnynvkZUSClFKqec9CRWabzxHUfhmuCJANWR912kia4p7Qczokp0OsK?=
 =?us-ascii?Q?7CrnjHcm0IoqMS69prXAwRXVRCgW0SjAUo8LBtUyYtYwOOYJB7+jeFmHRUQW?=
 =?us-ascii?Q?5uh+rZ2al0c/1C7XODaJ/P05PGd4zGpNjjeiyK0MeqNQxJ1MEQLoAkjkq2ce?=
 =?us-ascii?Q?GUiJm+5pDhdgFG13nUgXddI0I+8Kz3h5JA2EaREFNDDosoHGZmdi0H94kYab?=
 =?us-ascii?Q?QKfR6twuGBhl+fYrB8doiwlWpFD6ZRUejjnGlo2X8CyETINs2F/Z6UDMr9GI?=
 =?us-ascii?Q?PLOLkn2QYOOr1Lb9+PkKycjHwrPCPALM207ouWpLNEjIyW7ccvyNzZ1hC3zA?=
 =?us-ascii?Q?H7aaZKQwEyfi0m2icDw56ZnqbJpf6A/kNIoKh5hV8ZxQ8Io1E7mI4eeP0XHu?=
 =?us-ascii?Q?nydsln05v3hCRj0xoczZx/yxR6JMQbWjP2SvKlWfm4dEKE63PMiGN2vFbvki?=
 =?us-ascii?Q?aGWJ9WpuvOW4iY7zSejhv8hxnnzClz5pzEgOl6uJAYZkYiHRwynf+KHLCKnK?=
 =?us-ascii?Q?6Ra3itubD0tDemXpA7MmMAZ1145vmyLCsJkUEGjKYm5e3v2k1Uj18RK4MBwH?=
 =?us-ascii?Q?6mwL2KkJELh948TcaK13rbqbSzjnl03VAP4qVjwqvgxlhEu18zzxgexcgkp+?=
 =?us-ascii?Q?PbAY3P8i0cIl/AbmUDGmmmx2Gi3MRH23qLAcLhuSztmDvzVkeIuIGf71T7cd?=
 =?us-ascii?Q?9ZiNyUUjkGt9i4cpY/dbeAPeDhvRn6FkkHwMROmxL9OCx+cviB45nlbHQYA5?=
 =?us-ascii?Q?S/BR3w8e1oMpJTbJEKgYanY8lVrP8H9eJKZ6m2w6wWMdoly1Eo12MakeWvWL?=
 =?us-ascii?Q?NA0v53kRXE6lLUnSF+ONS83GuSeoTdIHPm8SE3PBlFwBSD4idLilAdM9swCj?=
 =?us-ascii?Q?8sKUdnOq1hi6TsDHLYcyMG7NJCT+l06SDH16q1r+mfx6MwIvO0T8PFNr8zBf?=
 =?us-ascii?Q?fUS7lkhVrkU29D/zz3ZTRzZwQK0f+KlwUZ0viFns?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 890e73f4-4c5b-40ed-fa2f-08dc026cb6e5
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Dec 2023 21:35:12.9348
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N3/EnIZhm/9ZWIWWwbLwlwhCMVcX9BgoBilrwIQPVcfASsooJZMgG8qtdVibWUk4W4ZApT1aFxD40asYlSOwwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7481

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


