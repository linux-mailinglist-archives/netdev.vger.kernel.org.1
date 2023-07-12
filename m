Return-Path: <netdev+bounces-17240-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1F33750E39
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 18:20:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88CC22818E0
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 16:20:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA48A14F88;
	Wed, 12 Jul 2023 16:18:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A419D214F4
	for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 16:18:43 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2056.outbound.protection.outlook.com [40.107.223.56])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA81B3583
	for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 09:18:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jEieajnqrUFg6+zOagL/95rg2uCPQ865joghLdqZOytrK0zakEpJfihNCctAxIQDSWQwS0TtjcmWSsJBuHcmYgRp4A5gn2ZAUr0U714U7/sJdS4bFIincyRyW0m815sRyyk5VSlee++QnApJWcS7W8q0SU684rK8oaEp4E2Jo+bY3qzdplzkdPJOXZawbpQddynjoFghjxNzusKGPCtlwOeiNBEwYtB5fO5bp3PhsElTzCiaWy+tD+3MSvnVQCvpUY0Zm0Bz796FDp04gE7BzZsH7GOzogpgTFANZleoQxrDmiz5+f6hTa/RdKvHzQgnNAmHASBVj0lghxAm22aL2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iZpAyx5UST9GbP4ClZobLoWyP5wUA/2jDvUyhpoQKaQ=;
 b=NGKWFGdyTgqESv/7M558rEx81g0oIuOzrJrWkmZXYpD4Guux6r9YCYaEXXpRvNVx2upZ1g9xQwsWGlQNbrbkic660DqHKqgOHJ+g2v7LdIhzsqAnjmngNmWaAmLoaPvuNNeZL6Kt0fl8Thic6cAsuNCvcMqZvONAkqu7bJaHuiQtFHzMasV8yE6j/4LiLiKDwtgeQGTrtunWuS7B1ZyyFSaF89zHa8Zs5i8KiKomg6z6xfDiQI9TOiV8DoEks8AthZkjGWLuqEP787jD6/uYFw8r79EGXdK6nJbfvSHluzMb12/vHh2Sp2h75k268drc5Di8yMeGSwFgLsmDIDG9Hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iZpAyx5UST9GbP4ClZobLoWyP5wUA/2jDvUyhpoQKaQ=;
 b=CRd68IswBhaqcamWRxvjod4jaJYLqw9QRSkBnmUzmywqZ4yRmuYySRAOGB1MEhLi8T9310pKhGquxyKBEiUHVTLKyJXy+4BUXhk8Y7mG8ROvoVHLoRuVV6j3czi+saFyAqqrLy2F0LiHdyYd9XbWG6QTFWT/wLlFUjndJ+NTIDG69VltCeZMoE+qcn94Gh2s82r7lDYo3UXMVUR00eliRor/qZb5pgWBmejQuhBTcIU83Qvp9EduNz7vLXf8BA3WpNBsXVqQDJuuMgqqvNFgK+QY+T2YgYgZCRixQtoNm7mR7v8zFF92rLGjb4SZVSmznn/S7KG+gt7twQFx7Sr3Zw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com (2603:10b6:a03:45e::8)
 by DM4PR12MB6640.namprd12.prod.outlook.com (2603:10b6:8:8f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.22; Wed, 12 Jul
 2023 16:17:36 +0000
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::3f6a:7977:dcd4:9ad1]) by SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::3f6a:7977:dcd4:9ad1%4]) with mapi id 15.20.6588.017; Wed, 12 Jul 2023
 16:17:36 +0000
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
Cc: Aurelien Aptel <aaptel@nvidia.com>,
	aurelien.aptel@gmail.com,
	smalin@nvidia.com,
	malin1024@gmail.com,
	ogerlitz@nvidia.com,
	yorayz@nvidia.com,
	borisp@nvidia.com,
	galshalom@nvidia.com,
	mgurtovoy@nvidia.com
Subject: [PATCH v12 12/26] nvme-tcp: Only enable offload with TLS if the driver supports it
Date: Wed, 12 Jul 2023 16:14:59 +0000
Message-Id: <20230712161513.134860-13-aaptel@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230712161513.134860-1-aaptel@nvidia.com>
References: <20230712161513.134860-1-aaptel@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0160.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:99::9) To SJ1PR12MB6075.namprd12.prod.outlook.com
 (2603:10b6:a03:45e::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6075:EE_|DM4PR12MB6640:EE_
X-MS-Office365-Filtering-Correlation-Id: 58cac26b-d6cd-4fc9-ffe7-08db82f3816e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	LNUMUgzNbka1t7bZlnA17u4CShMO++B15beM4gFnfEelsTooJmrCWdjJu1yi1OFESkZiAp7aku58ZKXP6gwXOD7RoWpKDGXUS3opU0hMCYaYVvOV2BO/d/BBAIHwe0lsPqlJaDJ1VlCADMp4lTpkW1GfNBfZs3OeMGRH1oI2LGrdzJXa/XwnfES2XYCfU88GvrcYwLvpD0vT6cBg9G3+W4QELbFmaw7RKNO3Gdb3ybeMK1StK92B0W8AeyEGs9m5R9Bssh6DxVUaeoOK1HGOcZR6lJyDM3SZRqmktJnwDaSBkUdBE6ZPJ9bnRJ1Qbp3As4sExbpnFVYDX/4/o7bVDgwl/OL00nEQosUeFsC3IxXdfx1Tq+gygOA8n5e3jy3zRmNvW09aNdf14mwJ/jpYhWyPKg/HH9jJ9esLDFWJHHNnRITHS2tDH4oCdCqZdk7PxnBXhY0c9BTtwejJB1sMU1mCnPJVSv9jf3vw4x/jRmJQh2doFPCkJdUiVGY1zwRfegvrBpQnLhvD3sHUoMFEES6gLtd0yNPzfEm+VFjVGioOzMPz/wSwVXY+2OE14piS
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR12MB6075.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(366004)(396003)(346002)(376002)(451199021)(4326008)(66556008)(66946007)(66476007)(6512007)(38100700002)(107886003)(86362001)(186003)(26005)(6506007)(1076003)(2616005)(83380400001)(36756003)(478600001)(6486002)(6666004)(41300700001)(5660300002)(8676002)(8936002)(4744005)(316002)(2906002)(7416002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?TzaZ/bQ4lz5pQgv1hfF1eg1Tfnv6JCfJN7uDHaN3YF4K9a1YJa/Tkr+E9AQJ?=
 =?us-ascii?Q?jS5Ug1GrJq7MfNV+jxmZswzgcVHx8D2SSn5tOduXc5AinBWNpGaPaZhrVI3l?=
 =?us-ascii?Q?p78MrdIgm7AO8e5ksTFPDVCSxv1WRBNExZ5hdzUHB9PXoE3Xe28N0ZyoQQ0k?=
 =?us-ascii?Q?VT/s6ueBA1kdW1uyWwun0VgFdWNkRtmXyC0BB1X1VExrWgF4UwLXdu+lpKdW?=
 =?us-ascii?Q?uaS7iBKoj8ou4yd3e3huGPrEtcYVbNJDFacfPSYpZ6vOqBieOlOZxF8Aco5a?=
 =?us-ascii?Q?8xzkmAV2s92fS2aNtavvu6vkVQXHCe/A7bdxCkifHVezXiXFxWJ9wGLAj8bq?=
 =?us-ascii?Q?LqJxdy4AwgfS9tuiEc7U8nUqFgDtpcexQBk7B7SGRzSNBvjOUBd76Z1HERH6?=
 =?us-ascii?Q?vcr8up+ZgcAvwxAAk09MOoACY2hpN9XzV5aRIv/RbAfjrXzyiglseldJLm8d?=
 =?us-ascii?Q?DEk01raHNfKEOKW/ggiBmh8oj2rOXBiOeKFUhHM+9nl7FLmWXPne7xje70NY?=
 =?us-ascii?Q?aGnRVaDE4JUJlLddvsL621KCabinBSDmn1pbyPiXZ0YFt5Oxycy0YdLkcrUR?=
 =?us-ascii?Q?fs9g38XdKOdhlrDMIYnF/FqAKNhtHZ4nqdsNv5T6a15GjG0fjZOsRGJ9hG32?=
 =?us-ascii?Q?Hmu0vZP/zFHaAp7E/p6BbQprIopJTuBUgSVJ+YKGcP8g7xj+mrgEWcBiE3rH?=
 =?us-ascii?Q?4AvKFEFye8J7u+HxrWoLgUme6vC1NOZf8V90GGZOAs8peIowiNVPgfifrqqi?=
 =?us-ascii?Q?ISU3zPWC0K0y38kIzjM8AGIu+x2gZrCGfJMpRyoySJ3twNPrBbSs4PGZquru?=
 =?us-ascii?Q?ODjxkeWLEbE4Eb0PUMBJdOqxrgArCivChTnSGxX78j87NNH+zbWieHUn4+RW?=
 =?us-ascii?Q?bGezpu+rUik6tf9xHQpivRwTcekeNfvQnsAH1BdewKxIRh4XXnAokV0rl+81?=
 =?us-ascii?Q?w/dNOxb3SUpXCcWVRmqoOChtP+kw4+WgAjUaWUOxQuAxdQCuD88MELIaR0R4?=
 =?us-ascii?Q?SHfZCx2jV2MRRMgj1jjp5x8gWOQ2OaTddxj7e0sSHiFy5NEi6i2bdrePhRqK?=
 =?us-ascii?Q?tE6eduoS7wwWk/20Ur5r4tqpS5pZO0zDCC13qsOdq51/npP4rPSmKspnjvqO?=
 =?us-ascii?Q?sjkKuiXxVDTrhv7QQlIbqw6N/rsolqg2moleoqFsJ9lk3TTW1YPLhfpXMCho?=
 =?us-ascii?Q?jdNrHDfp3OMuIbSE11zV/gzjzwALTYF4tpuvImViS41fDA4oL4xtRu7n5B3C?=
 =?us-ascii?Q?tLxKRdSGItp/7NbjSA3wmVyfxJ/ShmqRUub/C6vsW/xeGuSMDe04li5mJzmj?=
 =?us-ascii?Q?rCBII7tlv9ZI+15QqGdxO/AnxztUS0SXOqrFQItByCKcpnNPHjaMJMBCPgza?=
 =?us-ascii?Q?aMw5JMs+nifQy+mFoXMBf7BPFqoLLXpBWq1eNyU2PZC6J2yuSLmM8t4qetZP?=
 =?us-ascii?Q?tjE6lGiAmP0VdsrmlSWe+ik9CLWe+vdV67+gKX2oXrzD70+iGIf6uKBUIuTN?=
 =?us-ascii?Q?tkKlU1Sr4DJxHIJwcEfKvswplAm9WnFEvhzE4DvcGHfAzVEY3oIKPaUSY1D/?=
 =?us-ascii?Q?imf2WDyAZPtQFUiTAvzphNERORt5KoaaiLsLnY5j?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58cac26b-d6cd-4fc9-ffe7-08db82f3816e
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2023 16:17:36.5094
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fIRzAH5qW8glofavVbAxRplj1gG1yJLjcqjcpr5l/uTwtO8jEogS96LG+iVHBlZWdFmb5o1jmUsrTKaArKypXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6640
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Check if ULP offload driver supports ULP-over-TLS before enabling the
offload with tls.

Signed-off-by: Aurelien Aptel <aaptel@nvidia.com>
Signed-off-by: Shai Malin <smalin@nvidia.com>
Reviewed-by: Max Gurtovoy <mgurtovoy@nvidia.com>
---
 drivers/nvme/host/tcp.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index e560bdf3a023..afb3dedcbc0c 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -367,6 +367,10 @@ static inline bool is_netdev_ulp_offload_active(struct net_device *netdev,
 	if (!nvme_tcp_ddp_query_limits(netdev, queue))
 		return false;
 
+	/* If we are using TLS and netdev doesn't support it, do not offload */
+	if (queue->ctrl->ctrl.opts->tls && !queue->ddp_limits.tls)
+		return false;
+
 	/* If netdev supports nvme-tcp ddp offload, we can offload */
 	if (test_bit(ULP_DDP_C_NVME_TCP_BIT, netdev->ulp_ddp_caps.active))
 		return true;
-- 
2.34.1


