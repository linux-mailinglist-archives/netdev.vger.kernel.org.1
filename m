Return-Path: <netdev+bounces-43862-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 346CF7D506C
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 14:56:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E1041C20DE4
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 12:56:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90F3B27EC8;
	Tue, 24 Oct 2023 12:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="PK8vqkU4"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E120C8EA
	for <netdev@vger.kernel.org>; Tue, 24 Oct 2023 12:56:13 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2049.outbound.protection.outlook.com [40.107.243.49])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF0ACD68
	for <netdev@vger.kernel.org>; Tue, 24 Oct 2023 05:56:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nfZTlE2ROSACXTybzbQRC2UAnrdxPoTtPO5oyBmmTdan9+Vc8Ja0svurT+cTVbpqKy3Zu1EZ5axHfH2kPu2K4Qj7KvqS4Vlqklz3+a4g9uvbpR8naHtEeYHvybugILN9n5UbpDT+nSAxTTPWf4NtBdv6c2sjKMXvMjAewkmHa6bDV5tnGzW8s2YSzoTsEopCzsaArZYhEyW2sj/COSTrj6bl6oeu+vGsU+bt1xbc4gKvePVi9oAgwF3dcUJeetWnEtMerTcpwSr2rpxLhHIviYdMtAZaNJ1JTBuRQ89Vd4O97z51p8mqstsxSpQRciCwImKnOI6eu0UW589Vk5k/GA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pa3K+d+tGObk4y9Zv/bhOSlIarCrDmSWoYqxxmm8F3I=;
 b=cFO/5T8CGHmVPcTwgFtG04AuetAsbu12Y1p0DS6C+Vg7NeNFrVTXqXYqSn4kex3creYsMIpHKBTbjicilypfPtrlDkHu8H4MCcTh/8OnxDY8lwDg7yiNMU7823XTrQ3ipSohwShO+PDo5/f9Q9C/TgF13Y0EmmsRiY+RoKjGuvoFH6Z9hBVvZ5oFxe/4lgaKhDDJKjSEd6naK5d+1t4/VkQGUH5ZXwOka83vWRAnqS0VcPgJPSvp70Mq/RtQTMME7cWnfkcM4OVugYqPzyQVFJuixI9aJfKwi2AK/r6lTSsxTK+AzBNUk2DxL+R1P+cPTwKqi01nV9l8aYVKhYvwCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pa3K+d+tGObk4y9Zv/bhOSlIarCrDmSWoYqxxmm8F3I=;
 b=PK8vqkU4KnguzaSArIgv7z8LWt9uEAFmy76NSO9F3C3BwYzYte2tCbsT7UUkW/ODAox5+2g36p21MTgABj330qj+F7AdE5jc3UEhMEMwhmwO4ygZOnpPZzfuL6nyx/gttcQ971rRg2Sav5iSLi/uB/GMQuS2WC0oSle4A3OzlO0VJ9JF7T35ejSut0i3ZiUW7GpocnGlY+squ//P29q6n7f0i9CoNMRy8Z9JqSFyVKk7teHq3bRIovPFiwUfcG3ep1eefiwWj+298PiV2nULUWdU7UmHVghjBguEcxayvUdUWhNaCkgwcdhmDu6u/4ehuWWUo+bq82v+qqQVRtaziQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com (2603:10b6:a03:45e::8)
 by PH8PR12MB7256.namprd12.prod.outlook.com (2603:10b6:510:223::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.26; Tue, 24 Oct
 2023 12:56:10 +0000
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::42b4:7f1:b049:39b2]) by SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::42b4:7f1:b049:39b2%6]) with mapi id 15.20.6907.030; Tue, 24 Oct 2023
 12:56:10 +0000
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
Subject: [PATCH v17 14/20] net/mlx5e: TCP flow steering for nvme-tcp acceleration
Date: Tue, 24 Oct 2023 12:54:39 +0000
Message-Id: <20231024125445.2632-15-aaptel@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231024125445.2632-1-aaptel@nvidia.com>
References: <20231024125445.2632-1-aaptel@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0275.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:195::10) To SJ1PR12MB6075.namprd12.prod.outlook.com
 (2603:10b6:a03:45e::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6075:EE_|PH8PR12MB7256:EE_
X-MS-Office365-Filtering-Correlation-Id: c8b6168a-6ef9-436f-d1fa-08dbd4909829
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	8lr+Qx+q2FlaOJ6DQlSR7hoBjKu9n3Bqk0OcJH8/9TrIE6OSTgGZ1XksqNXtHs8dbNfRzQ40O76mN/Q0ZHBcwqkjT7bupfR1++jzshTUojcgYmdsaZDyTKRp4oFevzbqctmig5q4NfCP7/UIsbSwyZCfL3EYbPDNzD+IuTj9eTiFt8KlM+XucRiAoK6y9857Errk60Ls93bHPT2ZdLK0rn7Hi9t5fIvoaREoS0W8oyW/gDtT+WxQxPox6bvql4CbWseV96HqX4MrHykCI/XIir8GPJfemugctCMDK9F0jNTVoeR3Oj0JYvS0YEu6HZKDYTwy3WJFpbPE6JatnPKJ5Sp5Kp7kHP91NX4zQvhNn5zIMtgpjkHMXnY5yCn2TZT8HS5XP/j341MWGPPutFiFcceurGTppBbu3R+0VZiIKmktehmbJlp2oBhf0/aQGz99lMiYbAjaxu+3DL43VJ8J4WSyidNSNO+IcHe66ahUFYEsauV3qTdw/U2Whns5Ihw46MLGrMtG/Rdtw0nyrI4YMUhOBS73EGyukcwugJghP9TSftdWhJVDiSKno/nRWS/c
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR12MB6075.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(346002)(366004)(39860400002)(136003)(230922051799003)(64100799003)(1800799009)(186009)(451199024)(26005)(36756003)(66946007)(316002)(66556008)(66476007)(86362001)(38100700002)(83380400001)(1076003)(6506007)(107886003)(2616005)(6512007)(6666004)(8936002)(2906002)(478600001)(6486002)(8676002)(41300700001)(7416002)(5660300002)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ao4Ds4uTPp+LlKSCRbJ2N44vput7YbgR7LHrM4CbUH9WUbh/a8TATZf+Ipqo?=
 =?us-ascii?Q?MNAqwylRj6MFYEwZ9UynN9WjrRKPO+lDnHQwXzJn3CHmDeYiS9dOt0kxPrcw?=
 =?us-ascii?Q?ZkYsGPzI6yJZe2HucDiJNGiEzt2KdFzdnRHcmuVX1+tAg3EA8DvQztF0VNuM?=
 =?us-ascii?Q?MNO4izTKULOWrH8x0DJKPVAr166gkXezmJ7thVwfaxMx4WaTZ1HnVfO4DBXy?=
 =?us-ascii?Q?86PsR1+m5lGpzrEBSVuqSIeSv15rQYSvSvVu9CtDSfvjfu3H+ePJ7KTuG4bb?=
 =?us-ascii?Q?4sGLarVXb12nTIvSvsCcw+aHRrOFQnCQAvTy5D9cC0CPwuLdsdFTdMBoIxtM?=
 =?us-ascii?Q?OdYkki8FVmEcLO/rJ8rqySPUmo39+/FS72jR3Za2C4Krv8e994w5tk/U4Nuq?=
 =?us-ascii?Q?hXXj/7mwygRb5vJiWMPebVD80TPjL5WHhh2DJ54Z8GuAiGW76/ktLN+s1KVI?=
 =?us-ascii?Q?wCRJoRv0AdQD37gcvsN9bgVa+8wj57/0Q7dkbt5Z8UDzTvry70yV87uGZAIo?=
 =?us-ascii?Q?VF3cAKBCqYWJrwDc5KSl1/fYQAf0KFVqXfAmE3epua1VCTEkYi+ujASM8gGG?=
 =?us-ascii?Q?kdNU8UMheNEAeKzUjxeEZ7k9yN1dqIXFKLGP6zUFFlY05oOb6AbaDqw6lYhb?=
 =?us-ascii?Q?WDEQm40p3vpprRYT1TQZyn46PavUvl8hx7XVHe0hM+MX6jpGHnbydSsqriEA?=
 =?us-ascii?Q?9EBeQNEo8S0vqphN/40EA/qz302EU58TbVvPKT+nKae/L9W9czQe9PZGfSr0?=
 =?us-ascii?Q?zdhJZiZyTbO50b/8SEjHZnblo3VOOf1Knk1JzSSHpIjJrKVBjGqFuclLgzx/?=
 =?us-ascii?Q?24IzV7HnqCerI052rJeFVGpXwBKQhwge37oZwD2hLJL69xHnPxsq+nTq/pdt?=
 =?us-ascii?Q?/puJh6Es6e3DjsQY/uljFDY6W7WOxl6Voa1vJbXo8cvvgkr2QwCcoO23iA4G?=
 =?us-ascii?Q?4BlEvNayb6bbY4mQMgE4VbaeplZTynXjyBWegSTm5b1d89zLvFSoavQE1HKu?=
 =?us-ascii?Q?Euny+OScmCySSsJPxpRjVL5+Z5ppz0sjMIoqzphii+gMbQNny01i2nubx3Bc?=
 =?us-ascii?Q?Xhp+ZdGam3JBTE4Ye/1g5ERF4QhdyAPsTHV/VCTL6/EZgUITAz48Punt4Tiw?=
 =?us-ascii?Q?RIt9kg/5FHU3wcWoS9XknvVE/IAae4ov4PczLha/4PU7tejE66srxd2SZCbY?=
 =?us-ascii?Q?RuGpln6CM7CtQD2v4cViWdUjxb+WHs32Hqr+0FtJuqAxNlnOC4RLidiwgT/4?=
 =?us-ascii?Q?eXpkSqCHMjPWHtR2RYaKNj8bWKHmX5gZCqimyt2bKKXhCeDLAkGFEV2gm/hZ?=
 =?us-ascii?Q?K/bp254J0RR3haOxi5GAWnxLPpT6awgrNNRQwMP49Xc/UkFqf1syzGm7ireg?=
 =?us-ascii?Q?oMnnfI+GV8e21WX6KkSnET0i2IQ2736AS2l7OpG8zWRA3Ze1x3s3e//pDz8z?=
 =?us-ascii?Q?EKTbLx+H36H0SsJAIetUvb4OFyCQ66AqnsZq+K6iR5FIg7F9w29MauSYgIjs?=
 =?us-ascii?Q?lr3333KyUpqCJdmyhHyT1Q9x5YKqaYHRyByLD6y4VGNmdtFv2hPSu+CGWKy6?=
 =?us-ascii?Q?tKBTnKHxmqoTwp0qRNCuAIPd6oNyC2HKN1/Zijsu?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8b6168a-6ef9-436f-d1fa-08dbd4909829
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2023 12:56:09.9095
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DjUKebVLwpUkaQHEDTW/2PIEoV9lpMJJENxKHWSe1AX5hnnJS94IitwCdsqv4S92o3UZYt9zVUrGVeOGD/v69A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7256

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


