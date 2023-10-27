Return-Path: <netdev+bounces-44752-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 823667D982C
	for <lists+netdev@lfdr.de>; Fri, 27 Oct 2023 14:31:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D71B28241C
	for <lists+netdev@lfdr.de>; Fri, 27 Oct 2023 12:31:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 262942C86D;
	Fri, 27 Oct 2023 12:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="SmNTDj38"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62D041A739
	for <netdev@vger.kernel.org>; Fri, 27 Oct 2023 12:29:10 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2078.outbound.protection.outlook.com [40.107.94.78])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 284131A1
	for <netdev@vger.kernel.org>; Fri, 27 Oct 2023 05:29:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F6ZqW5PeUN9203oTp5F3TUezk03QWws2EoWnUaAOXgi3YKi/5MY0a17flVszRU/0juNqMDlM+5KI/8lfW9Tg9VVRXgYwpRQdx7CL1OicC5HGm41w8t6Pa+meYnoUTpWmioVO0R3GgRChUQcgYNWWAPxLjpjicAeP/2cqs382Diboy82JCzSCD9RlEDCOyxqFi4rRfKAjq5DlZ+j/+B6q/H8DWWlSv0WNGrNqXMIWHCb+A0cfBt3uOgxIFpmH285pL5igOPjdD7hn599gJXkfvLnLe58Z1wwG57AapLAFCva1Tk9dfIkA9s7L7CgZMHWYonPonZL3OC2IbVgT7FaSnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pa3K+d+tGObk4y9Zv/bhOSlIarCrDmSWoYqxxmm8F3I=;
 b=PqORaSnqcbDb5+lI+atJlwNzxfufmtRhAmmBKfd4lwekFlYulZGnlrg7hueMNhKj3SKrBz04f/3+6s+ctZhi9u/kVNuS88Q6YzWI/VlyHgTYezKogmA5CKGu8d1CBRFDcXZb0H1lsr0AMCI0fKimLBTKVbCnvfwU5b/FArYoGSXaqRSZZgVngzADIrQDzTPhJ0oijxcIiSHNJBH+XotgXgjz5Dy58sOlm04/eh1omsZUCdavS7k/LQCwat/iw00piGm5kVb47e8WeVMhH6T2PPzJL1UdtYCDvxosydeHw9/4xKtF56B3crjbaIei5Du9Pr/8hO7SdJ/OMh/6FtJq2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pa3K+d+tGObk4y9Zv/bhOSlIarCrDmSWoYqxxmm8F3I=;
 b=SmNTDj386wYTP0qaO/5LLg90znvSdJtjUj/hsYlsjPYc1Lneto45mAv+BOMoXenvl3byHpVMFSmDc1oq3eSD9NYRfpmHBFNhqX8F+NgbtQVmiyWguXVi1jY9ls/EhEj9Q9h6ntIKgIxZYNrd+GtNPA592dhYfF1iDfEOWN/7zxcB2FNNRi7x0GQ7JG36/SnC06pDA4GXsIiMr5oU1elkuyl65TBJndMKnuu45jVzecbrMnla3quKWcu+isj4eesomRpqbqLoXD88CZpS1fkOzAMLvYDxm2EPvZ/I6Jf5/V7o7jGNCPsmoSATiYkJF/lsK/aJa2fKj5aCK6avfGhT+w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com (2603:10b6:a03:45e::8)
 by SN7PR12MB7131.namprd12.prod.outlook.com (2603:10b6:806:2a3::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.26; Fri, 27 Oct
 2023 12:29:06 +0000
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::42b4:7f1:b049:39b2]) by SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::42b4:7f1:b049:39b2%7]) with mapi id 15.20.6933.024; Fri, 27 Oct 2023
 12:29:06 +0000
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
Subject: [PATCH v18 14/20] net/mlx5e: TCP flow steering for nvme-tcp acceleration
Date: Fri, 27 Oct 2023 12:27:49 +0000
Message-Id: <20231027122755.205334-15-aaptel@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231027122755.205334-1-aaptel@nvidia.com>
References: <20231027122755.205334-1-aaptel@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0251.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:350::19) To SJ1PR12MB6075.namprd12.prod.outlook.com
 (2603:10b6:a03:45e::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6075:EE_|SN7PR12MB7131:EE_
X-MS-Office365-Filtering-Correlation-Id: 27145b14-2ea8-4428-b4a4-08dbd6e84ff0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	KzVe/yoP3+WJj/MZJ+CKB/4R5eJyyQ3jx6959Hacx39BYQAstWMhtkWc4mnND0K3dtM1YJP+RsB7bf17bZ1Pia/ONM9SZKuaomAFOJhTAG7efIzdJS2a99gpx1xxyj850+KkROk74+1SCQTryrZq67gtz1koRIMv96xkg9NQiU0F39fZtoT9Dbg2geucI6jI9VDYibo+thNW+GpJ+8987EQ9spG14lzVXe0LcsIBuuQN6U3tiVyQaYT2z+Sk8hFC9CGDwuz3IWBjKP8KykvBNCz1/ztEgQ49CVO2nPzyOCNTA3XtqqpIc8DIqYksELIcGn0THGQffYg8+DCFyDWAYD72Au1cBh68kFhr4zpCGQT2dttxo/YTX7hJQ2beKhax+GmODwj7rnW0rx2oet6eZKVr4KGmjPCaXUyoESfKo4yKijT+mJ9cN6jSP3OOtuZtHLqJd4Sl9JX+dFvpmTnjkuJ0iCrWaGSuVPm4VjfMo2O4DLL+q8xQJyXOE8q2xNv/+CbdxEhyeVoSzTCJ1tUmAA5Sn40LIH1xsD4ILrVRpjkezbUZ4hxr4K4J66eDCm3A
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR12MB6075.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(346002)(136003)(366004)(39860400002)(230922051799003)(451199024)(186009)(64100799003)(1800799009)(7416002)(8676002)(66946007)(66476007)(316002)(6486002)(66556008)(6666004)(107886003)(8936002)(2906002)(478600001)(6506007)(5660300002)(83380400001)(1076003)(38100700002)(2616005)(6512007)(86362001)(36756003)(41300700001)(4326008)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?03TSB2U/wmztYKCHtd1PLVz8evxHqJqTz+cZMqN0s7SAd2+eiXkkYNMC9cVD?=
 =?us-ascii?Q?1VIRs/6WFtnjvEwBvOTIZMhOnNOQgr5e54T58ptnWpaZtnKHR4VkgwyJcBrb?=
 =?us-ascii?Q?GLut+zAuv+UT/jcJgPtxBg03CTIuFxQbK9Acy0fFaVqtZSp83KRBsOpWNaqt?=
 =?us-ascii?Q?Y5e93SwXLMEWDWd05E6ZyfphrUYxL6ffD7cYh2A3nepW5D6r+XXRv6BcvNgu?=
 =?us-ascii?Q?2hwxlq5FiwdyyFhhu+6GtHpN5uencYSfgYVY50+D1MjFUSXl2WBMIbxDD9p8?=
 =?us-ascii?Q?ZYioCzImDvRPpy9JOCLG254MIEvgOCOwfqG6z4XmZ3dUWh1wSLF8C6UD4FoQ?=
 =?us-ascii?Q?X4B7agw+Gg6ymm3/yH6L0d1ZByOuFBlck4HWAi8MAEDC7GF54mQkpg8MNJem?=
 =?us-ascii?Q?zMGqAR3nDmuLLcmX7zV2iK8lSy9myGWYEll/tDcUHwX2X6W0nflmw0JHDMVK?=
 =?us-ascii?Q?APNnM+QDgQxqss8xCADSwXR9EJpTH8tTfwcmTC83uA8jsw7WCUjVeEzm+SnR?=
 =?us-ascii?Q?nf2U+tXmY8dH5Z5F23Ul7V6V/q9VJEa+17kpiyfBc4gBonwhBL7XAeJQ/34q?=
 =?us-ascii?Q?mzYLLH6jKid5S84Mymcsfeq3jvxQvfe6Gp5SBS9dQ0P8MLhb9W0f+xOWqwQP?=
 =?us-ascii?Q?ncwVLPetY4szvIk8WusPbUZ4GBUUrjfoI763AIbXE5ZfHAow2Gs216U5k2Xh?=
 =?us-ascii?Q?9zBkQx399YlBgNLCxsLkw1wWnmqxcg7S8sGaMlaf4/U/+dmx6KgWtgFdmWe7?=
 =?us-ascii?Q?/YMn+m0K3YltK50CqrFemt3bFd3ePpi0jcBHHfzHCMciT6Xky+Lq/Z/ugiEd?=
 =?us-ascii?Q?nsA88H1cQGEI5emRLuKNDp/ND8aittwRy+bA/ueSBNz+Wcnaf1Fe5cdWJvit?=
 =?us-ascii?Q?i8JO+K8kZ5fVEQMwT/+wWTZWbRNUP2h0yyQRX0H/Tz/oawvVBS5YVV138JwV?=
 =?us-ascii?Q?8qt553ZeWuFg+arL6mxnca7fH6xs7jF6ORxByTeJUyAD4cfBFYJ41RDcdBvL?=
 =?us-ascii?Q?TtJ3y0JHsmUgjXiRMYv0r3cN8W41pDtWLUIZFUwWa5UESHkl83DYx+EBMT58?=
 =?us-ascii?Q?gYnsEupqaC/0LpQrWjVzvuGkR7SNBRi3GJJ9pMBMqAIjb5xtKBaw6hcO8s+l?=
 =?us-ascii?Q?FD4AUfDe4F0oBvfd7k0mrZdJyj16n6/mM916lCgd9uxgCy3tXsSWzNK4OtWQ?=
 =?us-ascii?Q?D7TLPMR1+JUyV65Pxh0/v29WZsQkhxGRaRsdOIwGtkHbdSZODBLeEPXI7CDQ?=
 =?us-ascii?Q?IsxFi8AYUyGffORiMsYJqq/nCVuG5ZcDOISA28bRPJ363/q/5eczRvsU3hG/?=
 =?us-ascii?Q?/lbayM+ThmBFAFoFjOYoiKIVn/c3ZU5+0MuQYNKPlkP7y5GB1Zm4L122KKgr?=
 =?us-ascii?Q?EJA3SH2PUvY0yHujEdGjac1P7uzRF2ka5dn8h+l6OEDtwEKRf4+p/4hSfLaN?=
 =?us-ascii?Q?AKs+YApY7jJVSi/F/yF34wT62b05wo/oqgLZNCZ9gBMVzi9Lr6zEHsdTYhTC?=
 =?us-ascii?Q?YIdpVmpvPhuZj+Ikc+NRUllzttW1LSBT/mdpFsufV77LIEpnnWBZi3RE2lme?=
 =?us-ascii?Q?E1y4ySJQHXZdqNxI1WGqalFz+asIWCK8pi3Q0mzu?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27145b14-2ea8-4428-b4a4-08dbd6e84ff0
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2023 12:29:06.7867
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P89la0ApnLMvWnhxWAvDspyXoRli4viILOu6JhkOzh6btnhEOWYX8cjQFUW4koqJAzSCNcamLtUxTOehP0X3Yg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7131

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


