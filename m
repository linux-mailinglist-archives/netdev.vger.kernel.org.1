Return-Path: <netdev+bounces-50050-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71C7B7F481E
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 14:49:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 95CB81C2084C
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 13:49:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3440D2032F;
	Wed, 22 Nov 2023 13:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="N3LIr9Xc"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2067.outbound.protection.outlook.com [40.107.237.67])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E2BD109
	for <netdev@vger.kernel.org>; Wed, 22 Nov 2023 05:48:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lNA8UZG+e5nhv3mm9IedP/yqHJ94dyKCBongmb2BXOJYvsHzxP1q7B5UBdGhHnHRlpzdanA4RTzL8t6nkL9cAlNeGIO6NMsBkD2OLMnCFAJBezzxTyuOE70sjx3hVSheqYanmbQqITLN0M926+uu6HtloabMap2YBxtcyscamw3hzjymqtnM4zyPMpabk/5t8Mt/TfIZuimzvjyTtcg9Z4VJp/IM/y54VXs/AFrM4gai8/P4KXlxIJdbIbghew7OFi03vbaMloQRPsYQOJLAvBWitxUo3q7Z13XhuSh+mWkELvrv3egwg4tFq47A8IR205YjakSkhFYIssbvbeS52A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DBWhjRMWENmzbh8QLanUB2GQj5WfzKlPq9b/jB1l1QU=;
 b=cYpoK1NG+/c/Gm40KHTbZ3aKnWC/sAOXjyruaeBlTtUSI6PaYTRAMzNFe526ClY226jIlL5TgJ4C4yHHHBZVbE5FhgbmGxV305TgRQ1Xu5wENcz4AcF+BAV3oB6MHCUquLI5Vt8T9+9C+wOsZ615qyddn8StTGZL4nkkGAuy0kClcYMs9RoyfbaKPEUh58BZCbx4Cc5Gwks3XvY7BX5zBKth5BR4CjZQMjoOVliB1/liNTje9DhoLT9343Ll0zWUZdjKRvMn1dm3wbv4uUVvk8EGgbnY7i6tbVufwGRbDGXCwWXWbtQyCwbaRaBK6XaJJNXalj7bRA9JjZ9xvB8A5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DBWhjRMWENmzbh8QLanUB2GQj5WfzKlPq9b/jB1l1QU=;
 b=N3LIr9XceE88cFpjc2Ops7wIbyrKtgEPffQ33VC1tyyxvyxtmrGKVF1fGIkirjgbRgBnntnpl55QmMtaT+FUXwWyDxCBDMh9htFpkAns5McgHv6pllxOQ4inEeJTRWuqEafwH2PsgKMuZPtLf5gQJfOh5/Dn4u1M+L+mpYm4qVs25z/NcG+ueU0s0wY8YmzF4d8bVaOZNQYpJX+2N+1G/Q4sCy1e6WFa7XGsYH0K511//FgbZO0oFBQZQ8OTvWcpuaSyhdxQlddX2FfPrplF/ZeeFOtWzIgBlaNfGsUc9Q8i7fyffZPBfdxRKXcHhxDZyy0VThEF21Qi7AkloInzNA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com (2603:10b6:a03:45e::8)
 by PH0PR12MB7932.namprd12.prod.outlook.com (2603:10b6:510:280::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.18; Wed, 22 Nov
 2023 13:48:55 +0000
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::eb39:938e:7503:c21e]) by SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::eb39:938e:7503:c21e%3]) with mapi id 15.20.7002.028; Wed, 22 Nov 2023
 13:48:55 +0000
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
Cc: aaptel@nvidia.com,
	aurelien.aptel@gmail.com,
	smalin@nvidia.com,
	malin1024@gmail.com,
	ogerlitz@nvidia.com,
	yorayz@nvidia.com,
	borisp@nvidia.com,
	galshalom@nvidia.com,
	mgurtovoy@nvidia.com,
	viro@zeniv.linux.org.uk
Subject: [PATCH v20 03/20] iov_iter: skip copy if src == dst for direct data placement
Date: Wed, 22 Nov 2023 13:48:16 +0000
Message-Id: <20231122134833.20825-4-aaptel@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231122134833.20825-1-aaptel@nvidia.com>
References: <20231122134833.20825-1-aaptel@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0499.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1ab::18) To SJ1PR12MB6075.namprd12.prod.outlook.com
 (2603:10b6:a03:45e::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6075:EE_|PH0PR12MB7932:EE_
X-MS-Office365-Filtering-Correlation-Id: 48721d7a-89bc-44ac-c67f-08dbeb61c522
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	M2l4NhMLut1RlrTBdMKqg9J9agwELWuue/veS5RcpsQpwV5Fv+AHgLRH+3vhFNftbb/xXT+eF3+DPTx6Bx4qBtYQpGzT4eOgfnP0a5RuJWjGXOYe5Bg50rKYi8Pxea0Yo43o4vne+HVBNQ3XobW1bHFz+Y72z0a5OdpXoBuvseBlIgGoQ3CkoQeWraFy+ezDSNfy8N7l2vhFWuTrajJliMTaT8uBCfsbO/ejPEmMhC9HAtqKcC00Fd7W3fhLO9ei1Buwl7RS9+5dnR90wxddVi/UuGWRHmaVJAF8yBM1ojowC+GIFdgP/ln7AfcsQlTRBXs4liO2XvVuTemI7E6JXbaqXzuOQdLVmK3WdPNQ58IJuNtxSL6h5BNPKH4E87+HZ6lO7+Rlc11vXIkpf0iVscjxHU8PL3Qt37sYvkx1Fyc2l/Yy7x8imYxmHPIp+KH7L/opMNFenK90/DLGFfK0WqBIa1qWcoIIJIRuThGWRWXKzJqX/pT+2DniBAXiNOOM1ZQpwEQVFSH8USyNEWFWW2Vn9Ey6izgciFiPZ7LDeluKxNVD1SB5T4ZDi4ZTPWSJ
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR12MB6075.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(39860400002)(396003)(376002)(366004)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(2906002)(5660300002)(4326008)(86362001)(8676002)(38100700002)(8936002)(7416002)(41300700001)(36756003)(6512007)(2616005)(1076003)(26005)(6666004)(6506007)(83380400001)(478600001)(66556008)(66946007)(66476007)(316002)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9PQNjKH4cT8/A9rwOpkWp3Y+Fxvf7zPGmZFYf7PCjYTGZsb3ljC/pFuGAqk5?=
 =?us-ascii?Q?Nvq6/RcvJERUhWVtUUHvYpO7i4DT/IDieunqnKJ19U19hV3VeEkHdTQXsRgH?=
 =?us-ascii?Q?l/kp5+Z4huq5x2ZQrLq3ZtOm7Jc99Rrts5Y0SEszzSL4znWGvxiKmIqdxLnY?=
 =?us-ascii?Q?nJUtGsQ/GaJfvhoT6V1IvEzTkO4j8mrZU98PJEZQ68pUftvrV3prKrZYC/ng?=
 =?us-ascii?Q?1CvuTVIPNzT6/O/fCYTepjGrxHuTHTvBKbo6s66XTZggQW1491LHYXnlIE4P?=
 =?us-ascii?Q?WlaC1Hu0UUWjcB0gucok4ppnSCQGm506rPkXtOA3YUnQtAAK6siEuYSU5Io0?=
 =?us-ascii?Q?q2b+zYSdLGJCntBmiMsF6x10eiQTP+mrVArbYPfACd/HDcVk17B84vjW41gz?=
 =?us-ascii?Q?odJqrEItPM79EWtIM+0BmV8pVvbmb83OPRunwfw0qtxpKuIcRQ884kw8zlz2?=
 =?us-ascii?Q?gXgtNvg/bJV3qjVzJF06JZpR0w4muwCW7Zt/sw9bKEB6nqUFTmzA/d/TO89B?=
 =?us-ascii?Q?L9OzPyHujMAT3Pf2/SwZwCIgYbrabODoUJOCjrVp9rUbDS4keDAOZoDCjDv4?=
 =?us-ascii?Q?PELpdxxO4v9Ftj8nIb2kkymkV66vp2BoTwHG83wAHJcwCwVrpJM4VuHebyRC?=
 =?us-ascii?Q?qzu90ubYcEu+v3GqxyBr0t4xlgksY6X7Tr7WaGeespVs7p77GJOWHJNguily?=
 =?us-ascii?Q?nYMKUOqMAXVwHQNPb6KmBxGkmWviVAQu7TVSB0RrKt8w8apdZ4ysrKYFbf1o?=
 =?us-ascii?Q?HYfAxhissONLCj8rSXDd7EQAIix91sJHfYES94tDxaiun37hVh+K2+/P3BHB?=
 =?us-ascii?Q?Ejb0K4M/Ab9svny8tyTKgfXp3ngJnUDkhnPgM4BFCKnLEhs78lISnvGOC4VB?=
 =?us-ascii?Q?YaMvj2mok6aCjKtLzVA8zYkTzpv7P2aqoKX55gc/LlyE48SeBHj+96FL7LDe?=
 =?us-ascii?Q?pL3K0lVibqJZVvdP2x1YZwRfWWt+gO0g4kEEFttjws084CsK+KHnb13zQ6uX?=
 =?us-ascii?Q?2v+I609KwjqgC2CMUw4CTvlGQpfABM71J5iLBonlgSjQjjFpPV0SbGD1TvMB?=
 =?us-ascii?Q?nopNeq9/EwaJjjgqDnaCBOQ/16GZtoaiqfXheb8PbKgSh+su/tIaa2uo+nBY?=
 =?us-ascii?Q?IBm6c+vAqReFd48nCsTdU+eBmw4bTRpnO1iH69cnk5DnX0vIfJ+L/IkHUYan?=
 =?us-ascii?Q?PnbjQrOEWCGF4LhUQznrTPWpUaKSbAETxpsplI1f4OElOdmQOeJSGXec2M0N?=
 =?us-ascii?Q?IjzBYv9+HARlUTthC9yL3lBHDPTC2kkPVrSjh76L0z6FoXF+yZdZJ3ib5e9m?=
 =?us-ascii?Q?Po16snwih+C6bEjgJYfOSQS55fw5sP44CxE82nu7iqMp1LMutED+1yF1Sdmu?=
 =?us-ascii?Q?BCk7v+uSM470/wy5CohrgU8/Admhq6GcPFYJy8AHhuJMcytjxCogMxm0sUH5?=
 =?us-ascii?Q?DjmulvCStnVWGXqD82A5NvfIN0E06wYRENFH+OqnwBGf5MVNbskqJeA2EvVi?=
 =?us-ascii?Q?5EzExGNwQSFte9M6WuQEoPTl4Bh1DYsHt7tCsnJFQ63FIwGXSNPnMqURSHmF?=
 =?us-ascii?Q?JMj9p0OHZz700vgIfODpfDCY4UA7bzrg1XW0Lcdg?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48721d7a-89bc-44ac-c67f-08dbeb61c522
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2023 13:48:55.6097
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UBq2YIwdCEL6N9x0DhEkWr3xCFS8FXZJbOZZdmZk2MJ7o2YXAw27dvV9q7QZDYlC3HyoYrbIrR33c1hNWZobUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7932

From: Ben Ben-Ishay <benishay@nvidia.com>

When using direct data placement (DDP) the NIC could write the payload
directly into the destination buffer and constructs SKBs such that
they point to this data. To skip copies when SKB data already resides
in the destination buffer we check if (src == dst), and skip the copy
when it's true.

Signed-off-by: Ben Ben-Ishay <benishay@nvidia.com>
Signed-off-by: Boris Pismenny <borisp@nvidia.com>
Signed-off-by: Or Gerlitz <ogerlitz@nvidia.com>
Signed-off-by: Yoray Zack <yorayz@nvidia.com>
Signed-off-by: Shai Malin <smalin@nvidia.com>
Signed-off-by: Aurelien Aptel <aaptel@nvidia.com>
Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
---
 lib/iov_iter.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index de7d11cf4c63..72049621aaa1 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -62,7 +62,14 @@ static __always_inline
 size_t memcpy_to_iter(void *iter_to, size_t progress,
 		      size_t len, void *from, void *priv2)
 {
-	memcpy(iter_to, from + progress, len);
+	/*
+	 * When using direct data placement (DDP) the hardware writes
+	 * data directly to the destination buffer, and constructs
+	 * IOVs such that they point to this data.
+	 * Thus, when the src == dst we skip the memcpy.
+	 */
+	if (iter_to != from + progress)
+		memcpy(iter_to, from + progress, len);
 	return 0;
 }
 
-- 
2.34.1


