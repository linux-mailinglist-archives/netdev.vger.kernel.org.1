Return-Path: <netdev+bounces-32257-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E500793B85
	for <lists+netdev@lfdr.de>; Wed,  6 Sep 2023 13:37:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 246DD2813EC
	for <lists+netdev@lfdr.de>; Wed,  6 Sep 2023 11:37:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C7F110953;
	Wed,  6 Sep 2023 11:33:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16C4B6126
	for <netdev@vger.kernel.org>; Wed,  6 Sep 2023 11:33:40 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2064.outbound.protection.outlook.com [40.107.93.64])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94D6D19A2
	for <netdev@vger.kernel.org>; Wed,  6 Sep 2023 04:33:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lldkhFC0WizmJlQlO9rUd2S52cAOxxWFTuMX4bmYH+dvHio6B/AOcx0b7yrbhDZ2dDaOJdMeY31CteLf6zXSdnAINnTENxxZyG9g8R7W4draZ6qDBs35uVotAfoGiODQCLmmuPThev+yiNhsz2n8XzTNltL6NS23udpKqtq55KKbHPSBRK64XNwdML4rXHvrMhdjQwNadqDBcljK4FVlO8CgnjgVC++Z+S1t/KDpDv1UnWNL/HPT/yKsFA3gLWTJYqA+iWjd96sLYP7n0XGWq5oh3/HlVoZvDaCNDwd1pGQA4bPxG5PTaW5m19pzRYv3iriPaRleo4YCENctjSPjsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pa3K+d+tGObk4y9Zv/bhOSlIarCrDmSWoYqxxmm8F3I=;
 b=ZCwRjz6kyMo7+zQYdYyz54nk5eo4jxy0o6EWfR9452DuUSaWPANFbxf00BWmJaRGyBM3KDl4AKkT3kpuHYuu9r7cXJEoUYXC9FzgM4tEc/0DdyHEgFvCbWJFHqi5tHnRvcXFd7G/sAsgpMbUdCTeZYwaUVmTJrBGe70yDrMRutVabXveKMFATz0ownfEwXdVuqTtK0B2ddkhYP2874mC/hM7Kc472vHU2Q5rTGzuczTjKoddtEqYlCqfON2pubvpRdpwlD7SohlHC2tHc0TTf1dP4/B9re+aiKocbvaOLO84AzS5p7J3KtcjF7J9Tbp3Lb/wta5G0GRmYuJuIJx0iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pa3K+d+tGObk4y9Zv/bhOSlIarCrDmSWoYqxxmm8F3I=;
 b=HkmiXSRzdG3W1h4wSNMLYLi5Hh6vgQI0nfmT7T4o5p9augKdnmGXjUeVQA7pxIuDukBh+TNpsJq1YThsNJKPBSJ+i2JqhiUwnE5fjWjqWQ4nr69orlyJ2cVIprRQ2Pbq+W4M6MCuyiGzBrmNDht4kM2s3uQheJvKSxG/OgmkCcEZkJFVuHH7N7IV5zbsZuN837aIJuSrT0uAB9S9TPjMD1SNfj9Eog0LRO9tn/EMypMnpI8iPxNU8Vv4clzruRUS3rpGE8OKRIpLB38rX+SQ+62dVRbQVL+FGKxPet1p7mqS8DBoEp/nrIcD/gPQaFzhtmQdr3PzSb+7ptPLQOKQkw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com (2603:10b6:a03:45e::8)
 by DM4PR12MB6325.namprd12.prod.outlook.com (2603:10b6:8:a4::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.34; Wed, 6 Sep
 2023 11:32:05 +0000
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::968e:999a:9134:766b]) by SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::968e:999a:9134:766b%7]) with mapi id 15.20.6745.030; Wed, 6 Sep 2023
 11:32:05 +0000
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
Subject: [PATCH v14 14/20] net/mlx5e: TCP flow steering for nvme-tcp acceleration
Date: Wed,  6 Sep 2023 11:30:12 +0000
Message-Id: <20230906113018.2856-15-aaptel@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230906113018.2856-1-aaptel@nvidia.com>
References: <20230906113018.2856-1-aaptel@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0033.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:14::20) To SJ1PR12MB6075.namprd12.prod.outlook.com
 (2603:10b6:a03:45e::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6075:EE_|DM4PR12MB6325:EE_
X-MS-Office365-Filtering-Correlation-Id: 337caa91-8606-4848-e61d-08dbaecce578
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	/CfK6vwyotoFEp8u/ApOHSLHQn37Btq7dBi3r83iJfS1EkIr9QZax7t1z4xCvKhhudSXJIArVlaYp8cFSo54k8n6Dsx0SvVK8rPsXlEBf7mgJMTRWiQ90O5C1ieEG1F0Qj/i4H3d74ueEnA8TG3QSvh97mA+/BsfIjgYdwklZaAxewnCeqeS1lQRRvOEGOBsykeDkQPhoI1iJGNVpp12NORPPrwfaBy/NhmtDj0u/Aij7WmMd155bKXGGGNHNCvlcHz4l2nciGpwJF/5yCe+Lgy9RxONStiPhPiCjDbQX4eym6o6l4HdcZeR9y1RauKVAkpbsFhWcMSFke6lib9c+vlhMAF5/6uoHowMtquaSgt27MfM1PW8IkPvee6Sw0PnIt1zAKPQvx3CjWIH4aaRKKRkb0m8SS8LUTigyslTXMf6k6HSyniFFP/S8yH6Fql7e6swoUEWrCOEldhkTNZSTuoG46H5YMvSleNjS1sPV5uZDKRBcXu1oo/U1x9QV4QEXTrNeLLLkQT90OA8FuJnISQC++8+m4zkdaL4GfvbAfZ1VnCgopcm2JcFaxG11HEh
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR12MB6075.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(346002)(366004)(376002)(396003)(1800799009)(186009)(451199024)(6486002)(6666004)(6506007)(36756003)(86362001)(38100700002)(107886003)(1076003)(2616005)(2906002)(26005)(6512007)(83380400001)(478600001)(41300700001)(8936002)(8676002)(4326008)(5660300002)(7416002)(316002)(66946007)(66556008)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FKKAeFmNzGGsJVRWEr2762NtF/udF3vlfXSvkFYnUW8Hp8yXGSAuBYdmLTu3?=
 =?us-ascii?Q?+TEvtUjhRmHK3dm0ZgiV0vkl6OInJzEmsowJjRK2YE+UzeSGqjHZKik1KJbv?=
 =?us-ascii?Q?zqyNvxsZVMgNOaoMk9euttaRgnk12KlhoWG40PDULmrhaI/2rF94l6Q8tkIu?=
 =?us-ascii?Q?7Ewk4jYtRhD7LCZXeo8+aypNkpPg/jOrtnwgAWL+s78jyUsiNZE53vZaZLiB?=
 =?us-ascii?Q?myddPg8rXfP/EUuBNUuApf8tbNiQNR+4lDAKff6vUo1djzmxzzBQB5/zFBiK?=
 =?us-ascii?Q?peQZZZ9YaNBR6CTHj8kznstR9m+VmuNYRktwumN6kcXooGMSO0MuAIGMXtB/?=
 =?us-ascii?Q?6rnSQ1CsO2heAIlIKFySQwD84JZwOVHNMLtD/ub93Fd2i0b91KlwbvPg7ZvG?=
 =?us-ascii?Q?UFi2VIDjp87ibloWfZLrg/pia9DIwRkKTecKGNth1YyZsVmTvfxnh7NQe89E?=
 =?us-ascii?Q?CmpFdkK30kOVloTLPlc99uRgeUaaZJ+EHP7yfFeHgrC7L5iQM9Ai9nyR9nfr?=
 =?us-ascii?Q?DiaX5YC1uepgYT2iIDxXNx7M+14Xg0TvOLkvDKn31fKflZvrJV6jhFER2xNf?=
 =?us-ascii?Q?NFK+/vWHXhtJH2ZIT2iBC4wUozbVmFrO3iB/67zwTOqhzG0tg2ucpza72bPW?=
 =?us-ascii?Q?w2kONNLPhcn4hv8oCJ06yz2Rt24PEKZ3+paks8XdNgTw7vnvr+Or+aW+zW+Q?=
 =?us-ascii?Q?7Y/d4x+ki6JZYNZn/fpy8j7kho5JdaUQybSJRqGgdakNcnT+JrpEkPv9Kmnh?=
 =?us-ascii?Q?Hh7kOuKIg5LGrlLIesHGqod52f25rtDo4EW85GiS7mnWISHh3vXp4sjgR+H6?=
 =?us-ascii?Q?1fSZzd5UBLKuGjBmx6MfBY7182sTn/1tHbqNz5a1shXSjJJAol/F16vZpTLB?=
 =?us-ascii?Q?ZdDsBRVFFkRgEEtEQzron4OBWXj9CeU//32phQw1XiXYtnJz0/OBwpWNX9dC?=
 =?us-ascii?Q?y+Iz5xbsx/W5oBHNv/kXXafNJJaukvJ3/3bHWwexWob3yConxxqdSkHosJFF?=
 =?us-ascii?Q?cW0s0K8UL64jkmz6LD+mkJJ67Gf5h5dujNsAraQZQV67H6k6ream6iKP2hnN?=
 =?us-ascii?Q?UTAujrfGtHb+4YvbY5gNuUFwdIaS5OTp74RlWF8V21pMtMQk+em12WwxuXvr?=
 =?us-ascii?Q?Kllfp8i8SOwtR/a7G1mFfgJIwt/deuRw9hEpLUVmDviysIh6eM9XHWm98Ah8?=
 =?us-ascii?Q?XdGL5wSl6MFYIjVAe8Bp9vJ6ieoEL1muOs3MbaC8SDWdn+u3xRSojSaCpxu6?=
 =?us-ascii?Q?62m28EXcRl4j81p1Au8vC4koD9//nudcQD3QR0KMQ4LGaGHAqotmHaA29C8z?=
 =?us-ascii?Q?1LMbn7H80dBzAasouB78g3s9zXv0HgrbsN4/ebdvY/ohI5SEkOiIJ/bHvj+L?=
 =?us-ascii?Q?a9ooenLowF+x2cWA331N+RpHummIf9e+wAVOMP57WzuJz942zAM52UzPkHPS?=
 =?us-ascii?Q?oO8X3VwWsyIDoPmwicyIi4SfW137WBsyP9WFmKwb0dEn3Iblk9tD6AdcL+vG?=
 =?us-ascii?Q?0RMmymYcH2611M8QrIflFXzQZ7xk4uI4uzLc7nGqynQt1ke6f07imiBzIAte?=
 =?us-ascii?Q?sVK6vCt10/E+yOFTbieT7MswyTLPg1xwJX64Q7/t?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 337caa91-8606-4848-e61d-08dbaecce578
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2023 11:32:05.0946
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 44m4CmmuWqcw3DWYa7QUuNb1B6/8QG9mueyV4jqx4aVVSjMZqbCHz/BHwqfRSPspQlBek2ABYH4MfldsfDX+Yg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6325
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


