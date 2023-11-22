Return-Path: <netdev+bounces-50061-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A871A7F482E
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 14:50:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB2991C20B21
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 13:49:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4CE13C09B;
	Wed, 22 Nov 2023 13:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Noeb5Alg"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2059.outbound.protection.outlook.com [40.107.243.59])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01FA5D72
	for <netdev@vger.kernel.org>; Wed, 22 Nov 2023 05:49:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mKI+zvvrnU0rJh7i0pkVWPR6BoB/3TaqktjqpMmbvDEuJKQwVAMxkckeZAz/4t9K/aqs7Jf5BlfqN2aXrIf+WOV0UopmLdZ0u1oc3IyP/Olab3AItls91qcqa+pxceyyoLl2hCf+38R9S8l1Zj8maKKq/FxKOga7DCBTxCMGG9y8dxNJ0RcQ4LTLmQ6nA0PS5QgHnuME7TsMKOrRZ+wNVVfYHPhZeChmM9Azu9f6Fs7ZqeYA2i2s5+Mr+wRzAFA/idPFm/MVzqH75asmThTxCEVyKGIIBi4EuZRhnwIdHECUkx3NQAKvh6KmZzi2oszOgUqqqvi1L3BvtOD3haBUJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pa3K+d+tGObk4y9Zv/bhOSlIarCrDmSWoYqxxmm8F3I=;
 b=cBlpaBUHZXkyaQQF1uPMcsv8H7tYbqWToLx7F/lsvYjSQrk59LozNjrAP1J2mzcELoh7/JxO0etdm8jqlM/3YBym0CXxVSKOOL+ffqZZr2UFF4u72RB2K23hsaja+c5r5iyuOZQDYQExEhCA3YTBv88altmPCD3xE4Pexfsj0riIVTirP/bE8VHIpPaRHYBiG1KiDrCJjnqP2Sj4hYyNuipS4UDjvs39oMiLuO7xG14uxbEbrJ+/pKwSXzz5Za4o+mKZQca8uBHtsMGQ2fViNV5uCy4YvSMT2L6pwMPV4pEj0TJGSbZpYutM+hW/w9p45/gMOo9LTvwtipZkahX60Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pa3K+d+tGObk4y9Zv/bhOSlIarCrDmSWoYqxxmm8F3I=;
 b=Noeb5AlgLEyzu6wPH0p44MqtVK7yyaN08YYiETyAXdh8oVCNdhlQ8ldQTsl24XJc26hkcwJHPzE78cTlzrbPkUz7z9zWyCePF68dxhyxVddk607W2d+GiZApT41zLe99AfiRS92P55Klm4YP9j7julJnHb32EMelCI7dCashHvnpRZKMuzP/IZdsKhOLgPS9RTYjRnGZ/6YPc3o97cj1Pz1B5rQfHl/RUTKBtt7cobnC31APX0l00MDFg9pEcwN/XdxA135964venHQF1CQFAxvaxXqAA1XptFI1HSfbvvmkRrF+tASxfEX7Y2HzHBXgBazE3Uv9sQQ3ATYWdYxj5Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com (2603:10b6:a03:45e::8)
 by LV2PR12MB5800.namprd12.prod.outlook.com (2603:10b6:408:178::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.18; Wed, 22 Nov
 2023 13:49:48 +0000
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::eb39:938e:7503:c21e]) by SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::eb39:938e:7503:c21e%3]) with mapi id 15.20.7002.028; Wed, 22 Nov 2023
 13:49:48 +0000
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
Subject: [PATCH v20 14/20] net/mlx5e: TCP flow steering for nvme-tcp acceleration
Date: Wed, 22 Nov 2023 13:48:27 +0000
Message-Id: <20231122134833.20825-15-aaptel@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231122134833.20825-1-aaptel@nvidia.com>
References: <20231122134833.20825-1-aaptel@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0095.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9b::17) To SJ1PR12MB6075.namprd12.prod.outlook.com
 (2603:10b6:a03:45e::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6075:EE_|LV2PR12MB5800:EE_
X-MS-Office365-Filtering-Correlation-Id: b0df1a28-aeb4-40c9-804a-08dbeb61e472
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	wrcyKMpZNDGerjCVNdD7hSJuGBjpdhEaI2L91odKzm/J7Haa4RFh/0x0so7e2WKuJJNJJFXVNVmQ9Uvunvj3Q9CNqFsmYFiMWqwyY8LXWVqZjY1ipnr/ZsiU605IvqGidlCRI8STJGoxTlLpKzPulUxYhudkqMc5nRXIrp+/ebItqVLHy7895QXeynjk/JqndKx/bIWmXEX6u0+CWVP/tTGhfxwU7JUXU46IP1Txv4ehSBYo3npdZs3RPPYm7Sl+GQH80965F6xbvbvQWxz0fgK0cqlCobk9O45sTBWOkdJlqktpl+H5wJXSo1G6soGpc130YKbslrizOCSXlcaosrYrER+0EzzwTpIBq/5tevmcUdB5XHvOkDtk9lh5RU6y1DYgxhhtOmif/n7Lp/p4QfUtPZ20dG1rN6DsIfqn6bwio7tpCtnnh6H740UDQNqOOAtPd23cRUkXQyWHtcKTqiRf/+y4oW4W4q/WCR6iST4eSxaB9dX234/BFI5f6Q4+pce2KAb618/Qjlq4SmDgwI5CzZzR6/hnYnUdGwiruDlXQqBZi7vQ5uzDYVfeKC64
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR12MB6075.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(396003)(136003)(376002)(39860400002)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(66556008)(66476007)(66946007)(2616005)(38100700002)(36756003)(86362001)(26005)(83380400001)(1076003)(6506007)(6512007)(107886003)(6666004)(7416002)(6486002)(478600001)(2906002)(316002)(5660300002)(8676002)(8936002)(4326008)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wuZQbpgAHKuH+VEtJVBgZJ96Zy/qA8ThOpuVCTfoY2JHyh19NVS4gjUkkDZn?=
 =?us-ascii?Q?zRHFvQMBUBNG3fHhJkng3AbKtb0dK4lzYstPVR/OEWReAt7YRc86HrjUVgm5?=
 =?us-ascii?Q?VMISycmVVPIevqLS9qu31hX7vw7sVpspkq4VUkkACk9Br+XmRFFzym0l7iLx?=
 =?us-ascii?Q?uGEXDAmKbLR0QoHjtkW5kcPpD3W9ibx3Dmkai/XoLjBBUoB83WLyzsEDOxZg?=
 =?us-ascii?Q?hXmg6uOBQnLeBcxTnxMTKx2g5yUbCK511+0iIyxGE38IJ+Dtb6lnSNbtTy+Y?=
 =?us-ascii?Q?76WUgBWLXRiJ5kKO99oUD0TFnormsdw2QrqDMbuSrdy7/7QSmxCInnERFs+k?=
 =?us-ascii?Q?FG9uOV4mIhYZevV/nxdJy/ZDb41oGFKO/PtsH0S2NKklpYjQK9NDKOpAmb2D?=
 =?us-ascii?Q?7I6S3/DJcrsuYpTJrfwhJljIV5pEBHaBegiZ/qjcWWuurB177dRsJFzWhXDc?=
 =?us-ascii?Q?JuDmopbYbfclqruABn0oALVfLaBc8dma8K+uvm9IC5K6db1RdhVPDhJrQ5CI?=
 =?us-ascii?Q?7yeDpsTm/f6Rx7X11fs4V8KEY7r4osqiGeTBzT16OhRwZjlcmnCqNc9119Eb?=
 =?us-ascii?Q?1+N+LzVGnlpTqkJg0lc0LYSmF41jjA5wWOLYPcsHdCiLtegDttVPZbYcefFb?=
 =?us-ascii?Q?phVzQN0hp147zvOeVvSU+Ki7Vo6w8Qq3nx7ayBo0LS0xlfrMMvzZ6v+PpVzf?=
 =?us-ascii?Q?39Mdawgv+Ai2jpkjUllH4u2/IN9pDyLvr7BOdotgod73vGRDM5da7bH5D0jG?=
 =?us-ascii?Q?Y3Mu/e0SQa2YIkuWy6S/vJ4D5gAooyDRo4/9RFuKEVX0agy3WHGBreEwePHv?=
 =?us-ascii?Q?RAUEDLd0Gf+/Lx7/TxpZeKyr5AKvksgPAfdSm0F+EXdkIy9cTS42kktH6sxi?=
 =?us-ascii?Q?oQttfj7sAmHjnZ7CmtahwE7Cr9EECim/Z9b/FCf4Ag3Uv5H0J0T168dtc73a?=
 =?us-ascii?Q?xPvjrLsPJ5FI5GKWxomiUET1ogJvmKNCxRrd3H46CTzjp3j/B6Uy3YHUZxmh?=
 =?us-ascii?Q?N3dvuynU3f47QqQ8y+SNTc+iQg969vZawK355fxGkJhuxB52ZlCl6jfEBTv9?=
 =?us-ascii?Q?CNrhc8vgSPOFYqAjULUL2BxXd5PaFLdVlj6Pl9NiZj1Qj0EjqBbuPrqJ76MU?=
 =?us-ascii?Q?DAYzQ8BJA/Ggb0ffvvpDrAQiKH4Zpo37sxd+xLYCE0o6JneSTXSg/C1Tzoe0?=
 =?us-ascii?Q?gOciyBlrJ6/ZpqfNiATNP0B/8v5HbKLKnvIdiLjNwj3tT7SkQBeW2D6n7y7G?=
 =?us-ascii?Q?OIe5NOvLxfhZ9VWWmZtk93gJzsPSj7kAEiuZmqt/bxKuG71WOFJjgyWulSTQ?=
 =?us-ascii?Q?5n5k3lO9cUFWSmKiYovfX9uymjLiKiPeEMNZfPgBwc5kmRVKCIbpSF9jKbB1?=
 =?us-ascii?Q?pRhFXLEi9Uk/RxrUPzOv7N4MUDCflP1nEaQflpN0xFCWHGLilpPdjHnNuCUX?=
 =?us-ascii?Q?l3yn+VzOKlsEqXw8wRY2TIXG8JO1n/ftIE4jeyJ5hAX9u4gChak9ZgOQ0TZa?=
 =?us-ascii?Q?HwdCnr4F/Dc8ckl7+xA/as7XuwNAqh3XNFOCGjYuK2W4h+963Ta3VSH3fTXO?=
 =?us-ascii?Q?0D+l1KVnMZ2xUEpZmOu1Z/IBNKOqJms5fmbEibt6?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0df1a28-aeb4-40c9-804a-08dbeb61e472
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2023 13:49:48.1723
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lUBXeTsaktVbpng03BE8J4yH9/TKfmjgNchRdOJ4bihBrvA4sg0rRmcT2rPOwOPOefQKXAYRdZD6z2Ewzv2aHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5800

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


