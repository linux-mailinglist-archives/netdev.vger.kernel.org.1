Return-Path: <netdev+bounces-29677-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7FB3784514
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 17:11:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E9AB01C20900
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 15:11:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58C9F1D317;
	Tue, 22 Aug 2023 15:06:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49EDB1D2F3
	for <netdev@vger.kernel.org>; Tue, 22 Aug 2023 15:06:44 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDE37198
	for <netdev@vger.kernel.org>; Tue, 22 Aug 2023 08:06:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A+lL2fT73N+u43I14gH+cOJQ2+J9zjjo2+iaFEdCvJHdHHujbv8rDaQuu7YGnXDxakkWvsupmBWoeDnZsRICdYQaiVBR5JXMmr/DtAuPe9mTFoFMXoKEXHdUfKY8MP0ylqn4BbW7j2olYS+weOE/Lfz4Y8XiQ39z/DQi9JKHJZKukVP+fIa/lEKvHF3idp82OAIEYf0HIBs3aliCbB1RC+KzymA/+FrfPJilaAFAaspGRyXXi+ElnX/UQyAyGAw1iP91oxYFfNbfJn4NPV/h365ouLTNJ+oDltzmeesz4V9bKHfa5CUBpl6oAjCtDD6QlfEbdf+g8gxjqWtkuzHl3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pa3K+d+tGObk4y9Zv/bhOSlIarCrDmSWoYqxxmm8F3I=;
 b=er1elkbXMmpqATE5iwJEJ2U3GGqfor9ZIIbc/6d8xySPkrjZljneoD17iNUnvJm32eeKgcXkTpTRy9gbxXPnu07/NZrmfWNMVzi2kvVWg1ZPDV+BYOokxvfsOFqcYRh8K3aOX9/pFBkKMN8mQoDx2XS8SlseMvpEo/r9qaagVtW7RTKtLlqI+ABf7F5YXRyFNjzMoPjckHlxKXTLHWqPNQEZEHD2+7OI5r6pMIO8Vq/F9eFzJJLXQON+VBMWKDvmXhgjncKB0Q1JMR/qB9dVJ8JG9JVK6ohJoFqbY68xO/NKAdJKHbfzYRBNwvbQD+OhIG3EAZ/OCAqxsOOu+ov/Ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pa3K+d+tGObk4y9Zv/bhOSlIarCrDmSWoYqxxmm8F3I=;
 b=Z7ieHCaB3r/oNGFfjfRuSHyeDKskilZR6h9JfDwj3mhw0/dfbfKslk+lr5kDXpn/WnPb2OcQICqflGIleNHboVUOog+BdXo7Gt8Vxwhh6dcQFBx8WP+K8VP10okuyhVY94o75UQw0QAoi72BOXnokyZu4Hg0IJtZwXGH/K6x0PIJWRL4HVKOKvwK7WLz4bmOJL5abJYeDzPBes5rJ+AC/hJhlgg6WgSYRdWu1hAMI6Pa4ds2IlDvKrsZ2ihDweQCuzxFTI45mXw39R0BOUH8typkItz1ZRpTbcQ9JAz0viCNtGyZu4vbJFzv9xm+9+mZueDpkjniQ5grQKlrRo6QZw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com (2603:10b6:a03:45e::8)
 by PH7PR12MB7353.namprd12.prod.outlook.com (2603:10b6:510:20c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Tue, 22 Aug
 2023 15:06:38 +0000
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::968e:999a:9134:766b]) by SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::968e:999a:9134:766b%7]) with mapi id 15.20.6699.020; Tue, 22 Aug 2023
 15:06:38 +0000
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
Subject: [PATCH v13 18/24] net/mlx5e: TCP flow steering for nvme-tcp acceleration
Date: Tue, 22 Aug 2023 15:04:19 +0000
Message-Id: <20230822150425.3390-19-aaptel@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230822150425.3390-1-aaptel@nvidia.com>
References: <20230822150425.3390-1-aaptel@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0148.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:95::7) To SJ1PR12MB6075.namprd12.prod.outlook.com
 (2603:10b6:a03:45e::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6075:EE_|PH7PR12MB7353:EE_
X-MS-Office365-Filtering-Correlation-Id: f0f54ee1-fb4a-424e-cfae-08dba3216274
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	QdnbHol/FINXYUtfMLqzmub0xQCG2hjixDc84rtLfgCp4b3doqN0+1McI2T+8gCr3frDH6q2dlrhOTVGDUeBF1JpJTa9SVeMW9yuYTFm1Xm07G1J9x6h0+HXnOgVJaS9vN/LZ6geixnIsdZg6WKqFASLcXyFLd/U4+Hsa+RuHkjyr9qD3vZl0GA0dlsXlV3ieBpLm9YAI30gYnLLkY2mLeoRCHh1QKZiCVRRod2cUqDMDkP3tUU7RhDu3ODuUe7NVyj+Shypdx7klq+/jEm2OY2zQaN/38p/kKlPddDmxXOXhNSswWFBa9mJuXX/gdCvvDjCw3e7X5pan5ExDj7nw+jfLu3ECHJHJ07Q1Qo18EYqLhr+qg/LJzulU8pcuNbQ8eo4gdF/S93ixpcDOseXSA7nhgUXUvULBzPdU7am2GpiskMHMjTr8I1p5Fxw6/uCjfrx7GW0Ti0jJnalHKDEOftiw/JRu4r+URpwqBOkxNqSbA1vNF6Snl8mNBIqes1j2RzKzRLL7DC9wIhV7q4Il6i/UltDIyklfgvU/LScTwF0iYRBosxNDpOW6GZPhVV9
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR12MB6075.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(396003)(366004)(39860400002)(346002)(186009)(1800799009)(451199024)(66556008)(66476007)(6512007)(316002)(2616005)(8676002)(8936002)(4326008)(107886003)(41300700001)(36756003)(1076003)(478600001)(6666004)(66946007)(38100700002)(6506007)(6486002)(83380400001)(2906002)(7416002)(5660300002)(86362001)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WX7FHxSaPSBIqtcAZQWUJc/Sf4nedNDSr3DJOjkFACgddY89n/SKpEo2RrRO?=
 =?us-ascii?Q?n/Tlj5F8OoNkKFuNnc1L6rNzS6rUPzr8/n/t3Ah1hgFRPwE289T8lwVj0jlf?=
 =?us-ascii?Q?+vXadw/LtIu8na7ZeZQw0Ugim9v3/0c+AYMFnZjAyoLUGQr8HI4nLm7RxY6G?=
 =?us-ascii?Q?XmA2LPrmhQdwGs13ikpa3gMV51cOobbCwnah4yDVKUcZDaZi5J7c5Mdupo+c?=
 =?us-ascii?Q?3Zby9knjfNGiEyR6rHBcLS49Oq6uKCDrDPXWiTBMY8Ss0+ROimBpSOJ7NbvI?=
 =?us-ascii?Q?yOOXdKIJKtHmpRF1cpOXl4bOkbS1hOBkz0+QTdg9DBuDb2dCq9QoUaNctxUK?=
 =?us-ascii?Q?SXb75Nx9ol7Y4nH3k3gzaun3J5tJhJN7VnkFgxLj+L4E04nQ/cChT0tM2zEV?=
 =?us-ascii?Q?U3GzI02ZmNTFoRl3j3cRFCu6Y2+qizmP6P+PGBCMtIV2n5LhcbxAlUSsx9XU?=
 =?us-ascii?Q?9L3v8iwuaYmrp6FpH2RZNj7W7GE8IlDh9FQ895IOJJLUFMgDbaKtRUuSdwd3?=
 =?us-ascii?Q?ZoY+M16LidtdMRl3xR7MuY7VH+7rf8UjPephD10qQoqpE+sKIVmS8vLM5fty?=
 =?us-ascii?Q?/KalKh8XBZcey2/kjBIOEHPXIowJ6V/DtpNYafc/tWFpEhtCgubl1WqJ1gCC?=
 =?us-ascii?Q?bzn/piSCwkzNptGnS+WAMrKmaLY50X7LsrA/d3mStRNk2r8+2A67mevfo2/2?=
 =?us-ascii?Q?BbDxDuIjkqnzgMgHeWDCP6YBAwWCo8OuP64F7oGZh0adcXNM7Xfwbz3NU2yG?=
 =?us-ascii?Q?qDmgM5gZPlWSC63nSGXu5ccsjR3vr7B9cXYJ91/VLXV1LmOSbE/f814Xa1f9?=
 =?us-ascii?Q?lWYicm3jZvY76CtJv1gQWvMzyMx65eAJ9/40+j7MborSLwxLSOFe9RgMy0aU?=
 =?us-ascii?Q?Hf3TsSXFORmkNpzdTKVL3seYIRAaOLs8njAxKDanZPGDMl1zQrX0LDU28TU9?=
 =?us-ascii?Q?4FO6ejO9SCyeQEaehrnlywzZIKArqgSU9PObY7zy+5jU1s8mSpOm4EjHNE/+?=
 =?us-ascii?Q?nT5LxSONRYT/+rLJZ667UD3WEvUqN6PAXItfHgd7TEU/2tt8Yt0Kl64Uy8Oj?=
 =?us-ascii?Q?LaxVhpykJO+fS2Fj0Wjgdbd6f96h0awzWdIql3/pZ/dqYbIXVedn+TsMmkeM?=
 =?us-ascii?Q?qiUTMfh7OpBiDVc4LbOAA+oEGMywfqeT1CPX4RbVZj9YzGM8eJtDsugwWdgI?=
 =?us-ascii?Q?Ta8BQrytJk1af7Ra+C9d2EK1WXCdOsT6Ba+WYjpOIae1nAVlq3P33+YtUUl/?=
 =?us-ascii?Q?ajNwedTF84VFtxXqXdB1aDXcXFeY3lHOd9J+aA3XufnQoXkcNmIlXwZePvPF?=
 =?us-ascii?Q?gjM48NzcxpVN5+ba9l/8PkkeAYKyU6JL4BXsydMlk9GqmuZsPCifbVvXJc/p?=
 =?us-ascii?Q?ekIZ5Xamy5VmQE2TnFgNjrOYmnyyGYrXyTC2tu5+9YAPQFMHUl1WofasbF2A?=
 =?us-ascii?Q?f/qfcHmjePCjuiY8z55OfCbNRyXnMAi1BIiEJfD8ZlZ1kWLY2bTpZ1RM90tm?=
 =?us-ascii?Q?SQd5LUqaIlH40Tamo3r12YWRSAVAoVIXhwWqpgmo70OX3pTbbUBxlPQ01C42?=
 =?us-ascii?Q?c5WjZjMuSTCXemsfCSKMIKoWuJBSSxDLKsMxAte0?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0f54ee1-fb4a-424e-cfae-08dba3216274
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2023 15:06:38.5778
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rjCcWKcyVjkW+MejkeskjxlEfSbJ9jBBRyrLgzVpDwyJQPgC4UNCuZofIQoOEaL1wf5BH4OTT7jns7IGCB3V6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7353
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
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


