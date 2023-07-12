Return-Path: <netdev+bounces-17245-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 46020750E4F
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 18:22:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 76E1C1C211E3
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 16:22:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E5A714F69;
	Wed, 12 Jul 2023 16:19:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60F462151A
	for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 16:19:43 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2061.outbound.protection.outlook.com [40.107.95.61])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E7CC3C21
	for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 09:19:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jQJDYLJs57hFPCct1wJ3hOIQZlB19x8mhqw8PQzYYanIkOVBuy9vwX9Fbl9GtfkV0xIiHvdPDHciAP05GFzhQzMS5XBvfMTgpZMiLy5j6MCx46BE+wL3IrNHywpb48Xkf2qg8uO724XU1M+VE5Eb/P7HOo26zqg4aiYP7/ny2Jfrn2yVtr+WTrzyeE2ak+1lKcN1OHYYOMwHjSSFFZUQEuMB7RNYtnPVx/HfvfxC1lgsK9ldEkg8miJ6dFMr96nfeho+d3MxkyP7EAWkeu+lRpblwEzSBLIJrRZ8T1pYXuilZUbTilLIVhx8pUd1WCLkj0RjL2vPUcf0SHPbXImnHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qVyUpJ2GokCKnAbqF6CH9oI9Fe6nIAc6yx6XU42GQ3c=;
 b=bJ8V+aQcoQlFUwWjjBJUxMsdM67m+hKXIbnJYUtLfXFXjkLxzljbqln52oHu4v0OkuMbPlUKO5vjz2cPgfq8tmP+xsYbqtMC4YQaLgZoPxU4USL858OGl4WphNyshgoecD2+l1eBNUWzNi0h9BESkiOq8rh9ra1kVGLubXpz4IB3pXuE0ujaj+w+i+Pd+S6ly8thunOsm6ztTM7Ozy70m9O8mbApL4HrglFgHWP2tV2900DkDzQw0px7XfnM8ADFmBol7XWXRm4IQcIsTlWFYiwBt8At3AAcWtWpaXs0DV6uZtapedLdv8KRlIHIuA9lnPCwDJ4klKs9g5Tf0GKiVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qVyUpJ2GokCKnAbqF6CH9oI9Fe6nIAc6yx6XU42GQ3c=;
 b=FkdnilGRMpjUNk3wRCbdVCBIdVjnh1QSFrzf+ILH9DKFdV3JABCblM1DUiioS17OS7I0ioo2ydIGgC/xRpH0hHWJKhrDcdHtkPJCvpDPQSps92EGQSVYRMoidJRuLS0R4NFIzr1mRoEQMKXqEgUfr0IkFRf/fxliDe1wcdohGYm00tNdZsP62gQTVmOH+6/R9e+Fka/+gHwDR90cUUGinDqvTjxHZH1quGh29oVGkxRPCFysnvqBKw1TlYdKjsaf2lHh0DNxnuNNlusdj6uJyTuRg7oJF77azlCHxugFiaDVtK6XGxXr5F1pECI2hVBokSt9blKSv8QNDyDK3I3/TA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com (2603:10b6:a03:45e::8)
 by PH7PR12MB7212.namprd12.prod.outlook.com (2603:10b6:510:207::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.20; Wed, 12 Jul
 2023 16:18:20 +0000
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::3f6a:7977:dcd4:9ad1]) by SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::3f6a:7977:dcd4:9ad1%4]) with mapi id 15.20.6588.017; Wed, 12 Jul 2023
 16:18:20 +0000
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
Subject: [PATCH v12 20/26] net/mlx5e: TCP flow steering for nvme-tcp acceleration
Date: Wed, 12 Jul 2023 16:15:07 +0000
Message-Id: <20230712161513.134860-21-aaptel@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230712161513.134860-1-aaptel@nvidia.com>
References: <20230712161513.134860-1-aaptel@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FRYP281CA0001.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::11)
 To SJ1PR12MB6075.namprd12.prod.outlook.com (2603:10b6:a03:45e::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6075:EE_|PH7PR12MB7212:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e2dfeed-2c75-4e24-d7a5-08db82f39b83
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	JDHrumV/ckyZlJFi8eGUVZh03ePxXAPHkAYmRja4IlGqEqLAwxhQJmLFYC7MvRMm6V1MnjfSccM7aSOAvgV9x9NKZesMDFbAPabe/oMtdXxOZeNy/wwnTwgVv2DvP4SidRLqnDRm35MkZAFK/VaOrethvGNYme0c7lf6s7Kdv7vnIehyNf0osyuxiJN5BGAgm1ojYYVUEemT8M+fvOiq8WtTdM3d6Axsv3xgfthksXSIrcvPLHAKPOeevRKVcjhi11y1AK11G4k4m2lGOV3Gb3fcsBe9XWFYjbwCaIdoqy/WKRdoiXSnb8tvnYbdr6Db+PoKIxG+4L4uytkVhR//NUqzsZ+2gUcSN5k6r0SoBxwHizLl0vxSR8+NH9YgjA5XwZqx8Q9/X//iAEsNqAoONJUbS8USLFDtY73x2TQ1LMHV9mZXKuFbpazu3Oec/nYO4QgP9HTdbDsGwa6yZ2SvFjWGo1K5x5zsB18jb5Bgovs7HoTQKvi5fg4lCm05Cvkww1p3edb6iQrPK1UC3ce4E8tS3cFJcu/p0fyi8cfol08ztYJM5mfnxPxTdKgVjnYY
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR12MB6075.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(366004)(136003)(346002)(376002)(396003)(451199021)(186003)(2616005)(86362001)(66476007)(66946007)(66556008)(316002)(83380400001)(107886003)(4326008)(6512007)(1076003)(26005)(6506007)(478600001)(2906002)(6486002)(36756003)(6666004)(38100700002)(41300700001)(7416002)(8676002)(8936002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0+boLpCtn9x6/51uQM2mXFdTwAsdG0hvoaUMUjTULT8QuOweunBjeN7HZy9L?=
 =?us-ascii?Q?ZlpfnFUjSjLuSumo+r2rZmpQO/j/jJR8qyCRWoVbrvmS/g8+n1lYsdkXoeYT?=
 =?us-ascii?Q?aE7Gvj+fsNGb2GJXtNCq5z6gdOcllryga4wHe5C2dGLRKWGqDZDySlX4JS5i?=
 =?us-ascii?Q?Phlh+P4KgHT8CQlH6rTM1vGTzvJzEXzbODRqV1AXAVYkb17JRDg/VaUxP5ys?=
 =?us-ascii?Q?N/ZG/I4ZxGD2w+Ue08fhKKgwIIsdgHZ3vOKmya9ajsPWH5VncoI7INZAE8vz?=
 =?us-ascii?Q?aXHSlJ3s0IVwFE84hTrfA1MxOwpq/nzQjkfN6ldO42BikSoHTmVxZt2gNCRm?=
 =?us-ascii?Q?PNIcKkHxgpYalchGBkFP0a+sgdkWN3wZMQkOa1YtMV0alraxz4tThhvtWlGo?=
 =?us-ascii?Q?QyvL+OU+FiXpvaD1vszmFFMhUaUW7Z3GGKggcZ3UvG5ZLnAcW2ILbm+KAM79?=
 =?us-ascii?Q?viHiOTuGjKCKimx+wSmBti+OuWH4aijOUjW1zr+RUOZUxas5j3li3WfYsL2Y?=
 =?us-ascii?Q?Pc8/sRjhu6OWPjz7IdCiQb3B/XsJYK36LjN77hrJiBXDDiMuyfDA2l7e+stA?=
 =?us-ascii?Q?f5snXf4uSbGOkOAGXi/zx55c6BcjtIs25WF3t413X1auE0fOvvpJ3H7ZLR7S?=
 =?us-ascii?Q?WoBs1pKFDIyTXdVbnGBLskTf1lrwlv+NMxMnDcZHz+rgO+laZizkpnBrfRaG?=
 =?us-ascii?Q?9orxif8gIupTEOt7Jpf2xhuly8g+1RpXXkDQNeNnqw/utH6e+xYv7RWofVTD?=
 =?us-ascii?Q?ZbCz4Np4RuWbmMnHPpUJnVQhgK8Asj/kycppXrJMk44Z5p1veX66l+CZ80rl?=
 =?us-ascii?Q?I8ugeHwYQzm9Cn5G6rV7Vj6PmfKZnoLM9cPgEbSGSzuvsT3LriUyWBkbiRmX?=
 =?us-ascii?Q?Z8VyJuN3VWHXR6Bhgo/I2VFJZv8cOmkhTjtrWX+qkDwcSNUcH1j1+os4QwiY?=
 =?us-ascii?Q?1OyWYZTk+B8zqOpPLY88lASQ1a/tK9SPKKlKykULlL/qrhr9ZefYDlBkjLfQ?=
 =?us-ascii?Q?2v+/jr99TYkaO7gPXfh1YNM/ibK71N1eHmgZ2rKL5sURhSb2uAKQJFtLCZV1?=
 =?us-ascii?Q?Qn7Ka0tPUuH3Bj8wWQsRPepZiA/VzcYddmuiu60Wd0PO4M89s1EpCaLlli6H?=
 =?us-ascii?Q?UpNOLZ/qJuIEZ6CTGKBNCs1n96YLQqHpXy9a4ROb29QNszxUHl6YRkHkvzjR?=
 =?us-ascii?Q?k/dTvmlb04fZ9hn97DXNV3ItI8XO94SFyoFSPByTdQWpUzipOfoTLBEwjYey?=
 =?us-ascii?Q?B5vaegdY0FhKmZ+nAiqOdmOaRTqm2ebBw+QKzFxdXUCh/x0VWzGMlX7qgaQB?=
 =?us-ascii?Q?GTMDF/JoZQGmltQzXz6UEEa8pOFhN1PgbyfsXXz42VEO/Uo2nVEdvTzaA9Sg?=
 =?us-ascii?Q?Hiryh3Ww12HUXMM7nVKgv1fwY5altS2xtpnZKa34JsRUkOgR7Upswbtdk8TV?=
 =?us-ascii?Q?6dZlmwElDn3pmjjG7mlBvKNTLVwJeXtv/1NmS0K9toDWqNY+n8DoRN3IWoHG?=
 =?us-ascii?Q?gHHbTGFUAZk2T/qXwz6dGgdtZIk221Dype0kSxa9+rM2pWUkNIKMj4oiqJ50?=
 =?us-ascii?Q?GA3CaUS6kgHI9Y8uJl88Vhbie/3ZpMQvLqj7KTUK?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e2dfeed-2c75-4e24-d7a5-08db82f39b83
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2023 16:18:20.2504
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DkGVZEEefzZCuKaGO7GQ5W14OAVzFhMvBeDsJxh3YlEq/z1gZtGdotqzoPiUfWuFMTm49ws5mBL4sL03VbEJfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7212
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.6
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
index 88a5aed9d678..29152d6e80d2 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/fs_tcp.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/fs_tcp.c
@@ -14,6 +14,7 @@ enum accel_fs_tcp_type {
 struct mlx5e_accel_fs_tcp {
 	struct mlx5e_flow_table tables[ACCEL_FS_TCP_NUM_TYPES];
 	struct mlx5_flow_handle *default_rules[ACCEL_FS_TCP_NUM_TYPES];
+	refcount_t user_count;
 };
 
 static enum mlx5_traffic_types fs_accel2tt(enum accel_fs_tcp_type i)
@@ -360,6 +361,9 @@ void mlx5e_accel_fs_tcp_destroy(struct mlx5e_flow_steering *fs)
 	if (!accel_tcp)
 		return;
 
+	if (!refcount_dec_and_test(&accel_tcp->user_count))
+		return;
+
 	accel_fs_tcp_disable(fs);
 
 	for (i = 0; i < ACCEL_FS_TCP_NUM_TYPES; i++)
@@ -371,12 +375,17 @@ void mlx5e_accel_fs_tcp_destroy(struct mlx5e_flow_steering *fs)
 
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
@@ -392,6 +401,7 @@ int mlx5e_accel_fs_tcp_create(struct mlx5e_flow_steering *fs)
 	if (err)
 		goto err_destroy_tables;
 
+	refcount_set(&accel_tcp->user_count, 1);
 	return 0;
 
 err_destroy_tables:
-- 
2.34.1


