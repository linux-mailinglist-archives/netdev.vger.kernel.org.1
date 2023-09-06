Return-Path: <netdev+bounces-32242-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62657793B55
	for <lists+netdev@lfdr.de>; Wed,  6 Sep 2023 13:32:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B00A1C20A23
	for <lists+netdev@lfdr.de>; Wed,  6 Sep 2023 11:32:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05BC36AB6;
	Wed,  6 Sep 2023 11:32:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7274ED6
	for <netdev@vger.kernel.org>; Wed,  6 Sep 2023 11:32:06 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2060b.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e88::60b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD61C199C
	for <netdev@vger.kernel.org>; Wed,  6 Sep 2023 04:31:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DPdzxzOqMxwDFisDaZPSi5UJCTyD3jnmCSEcdYPrtZM81/c+resYHmyRYXUdXv9TRi6P0auEPABSKhg9M4wI3+H149luBwUvcfgSjnB7tRCdvGmX3sfYlNtoISCpHCbU79gKk++BBUK7RorGEx/yFaDFYnuXIh1gYG4i62OEfjufCRZML0iVyLmj3L7rWdTzASLTxZmVkUQk94No/onJ7qaLAlVz2m44IecMrwMnRwM4ivFXimY1iP3ow//bmITlwQ3l5UDQn+2KuGeqxUvmMMmmCdFoPpSo9TUbbs53Yjt/ia2e3HMxjsev1oSoYJfC7+ErsPMN9iFqYlmVgiP0nQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PeinKB0TeGtV0ahzDu4uK0d8mEaxgFkxZOtX6H1OhQg=;
 b=TkuC3pFfNiHmyjpQieZRZkHM/hs4VIYlio17ZfPnAu/4t3pr1IGdQNw+x6DjUWTz1d+pRg1XXBPCii2l0bacS1dlG/eANZFcjC8HaPngwjYy5RMeoukmdChKWt7dtPqMGeD4Sox9pupZLxtPnaMlSEiotASVpSbIWmdRotITHwDcOyHULmmqSz+x3IqwkVbz6dgYPo2n3ZRPXw5DTNdUqjXBakNWE7Aq/fEFGKN8Zwc4/qs+TFXCRA0dT4F+Jj21ggY8tMGph64hmJQ7OWWutJKIN8JjGj34SCgQB3jPfG8l8WIFzv4CS579YjLvFC0WUDpWZE69N4mk+939mngJng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PeinKB0TeGtV0ahzDu4uK0d8mEaxgFkxZOtX6H1OhQg=;
 b=shClDQ2cD4N/Qx71wekzTWyw5uBILfCLqU4I/GyZQoaamW+NqrPk6ol6Lq3YUg88BrN2O5W5fyvuPuTIFjC32N+CVVyxIz82oB78jjFHvRjG2JCi7J0QT59yyT8dB+oFKI3t9sG2nAu/ZuMr+3zc2ZKTTRYpp5qBJDPosLNDMTedVZHEQn4Xm8Raojnzrl7vtbiXxwz9loXAQ06YozA1+i5TalbF4T3ruZnir45zWHPnAK336AWwmhJWpMNGr9JnalKpF752nH6oLsO+mXfXS9+FXSoVPNFotZ7v0qnu0rrHWo7fZf+99tPjDgkUXAI9aqZZjqm4XsgdN7vF7+IUdQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com (2603:10b6:a03:45e::8)
 by MN0PR12MB6222.namprd12.prod.outlook.com (2603:10b6:208:3c2::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.33; Wed, 6 Sep
 2023 11:30:52 +0000
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::968e:999a:9134:766b]) by SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::968e:999a:9134:766b%7]) with mapi id 15.20.6745.030; Wed, 6 Sep 2023
 11:30:52 +0000
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
Cc: Ben Ben-Ishay <benishay@nvidia.com>,
	aaptel@nvidia.com,
	aurelien.aptel@gmail.com,
	smalin@nvidia.com,
	malin1024@gmail.com,
	ogerlitz@nvidia.com,
	yorayz@nvidia.com,
	borisp@nvidia.com,
	galshalom@nvidia.com,
	mgurtovoy@nvidia.com
Subject: [PATCH v14 03/20] iov_iter: skip copy if src == dst for direct data placement
Date: Wed,  6 Sep 2023 11:30:01 +0000
Message-Id: <20230906113018.2856-4-aaptel@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230906113018.2856-1-aaptel@nvidia.com>
References: <20230906113018.2856-1-aaptel@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0105.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9c::17) To SJ1PR12MB6075.namprd12.prod.outlook.com
 (2603:10b6:a03:45e::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6075:EE_|MN0PR12MB6222:EE_
X-MS-Office365-Filtering-Correlation-Id: 52139b24-b63d-4fa5-3bc6-08dbaeccb9e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	+W0IgOg8Soll8YXvUACjIz99WXgeG3cKvjhjmjGXC7DPObVLICJqwbkeh+pjH58lWuLr7P7t6kR3CuL5+0MZ1y9wmkAM2/Tutu2ZkukpwQDnsSfhGYT1nn+YrMzYilqtcuV38ZUVSyVHxJMN6NNjDKsgV0/LsDcVMHVje0CLN4O4IRjLV22MFNJc868O3MORVfa04+ZMzqcOievEaVeyBGC783idtpBhxncuzkhr4in2fJZbGNd8aMZ9EUCmR2btfTAiJR9QOu2bisBkzkre+YZtaEhDii80get9uUmx/xfDoeSEvnj3Y5OnTU7l05ROHWVBEZr4L0L3XVM21qWOkMrd0yaHa/xAB2Hd7zAFW4fDezA+hkAZZl127fE9hJkwwNZiAGqfN7aqtqSC3lMnqD/vLSnctHzTnkgPVHcmMSxoO7UfWREYEkhALZ6GDxYO90kZr+jk2GDsYLljkIhEJIW43Xi6jdgwmhim1qFZ3gDNQDJeD8zYG8zxwQBlAiOVBZM9iJ/GA0rMV/jdytrNPuGGhpEq5PZldP2k1nwnt95KkLXHPBwt6qJSEYL67MAJ
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR12MB6075.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(396003)(39860400002)(366004)(346002)(451199024)(1800799009)(186009)(2616005)(1076003)(8936002)(66556008)(316002)(8676002)(66946007)(107886003)(66476007)(4326008)(6486002)(6506007)(6512007)(41300700001)(478600001)(7416002)(26005)(83380400001)(5660300002)(6666004)(2906002)(86362001)(36756003)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?o8ybXAJJrxf2nImV88l8Qpxl/2MFtaFt59rhx7BQqFpYAUvfGwWyHOipRS/3?=
 =?us-ascii?Q?ovqIQ7Vl022xsIx/xQ4CbIDjCH+QhEz3aob3OMeF6tq1ygzBN6jXyc4wAkWV?=
 =?us-ascii?Q?iHD+KUPBHoeiUSq8bnH3rhRKTdkoQlmJw6jZvrUDh+QmIdbEiWtQU9Cvg4sp?=
 =?us-ascii?Q?tfrY50v0dKhOVo7or0L+6UHCFPmjWN0or7+6zOMEE0V653sXZennHMN18evv?=
 =?us-ascii?Q?Q2AjG6MHtJbRDvlbqNNf4e6V3RT6JGfBn0iU5L6WIkY69DbINNoLQ0KgYVyL?=
 =?us-ascii?Q?LQ+YhJNFv1ZZj4hDv6m6WNRJvSCC6F3fRTqhKadCZAySdM468Mtxtdvhyla0?=
 =?us-ascii?Q?wfc0y16AZD1BIBKteU5CINFmcsdObg+YGZEdpAt/fFCMvJor/ZXJSS2G2gyH?=
 =?us-ascii?Q?uqPFbqdbi4N4ZYo4yc6yFatzhsxpNJ7gNmIjGq+qlwJU3KVNaEAofcoGClou?=
 =?us-ascii?Q?JCr9e2t3lc0h5SPQdEQcbdRQ06YSjG6wOcCZdQilSBOGyPGyqmT/NVVemI07?=
 =?us-ascii?Q?u0UhCa2jvAqwiDT2STdJcRYGjVbD674rjehtxUz6mD2cBtomnGMMq8ymeFf8?=
 =?us-ascii?Q?EW6/I0dGOCowLopVnss6FITwltQI4/gWO+P5J++CvHWAfkIm9bsd8Xy74s33?=
 =?us-ascii?Q?aBOe5KAMMbs1TlU+JhSa1TTMvQ8DqH7XgjVE/9eL73+mh5hgXm4XDXHdGIWb?=
 =?us-ascii?Q?t96cyHgjbpcj8wHjOPo6Mc6BuPL5ZAqdjLvB6n/h/iYg6iVABtkrwG2gKY6z?=
 =?us-ascii?Q?+rUpCPJ+FRnLGHb+Jf5kEqOD+xWMJAUb2o5fdXJOKEBuUZAibQNHwAFe+Bxx?=
 =?us-ascii?Q?ddWvZkEmdlpXzotU9ooHjXF1zSflJmv8cqfAigFHjvKTj8Gg6ALGbcGEdBB7?=
 =?us-ascii?Q?3x9SNpPiKL0xzZTHvfN/TLLZ2HwKJ4um6aK4Qrrt0N0fvd0Ufw3hOqfZnbR1?=
 =?us-ascii?Q?0YyPwgPZO1y0sI+pZiSBimQ524zVUZI2tA0Z2jADmzBBw865YBpvl3Y4nf5W?=
 =?us-ascii?Q?GB/v+QI55sviZzZRkeB6/T74HzTEbbxicymP+F6jRmpAuHfGBAzVZ2HuIU17?=
 =?us-ascii?Q?nUgxU5SsgA5wJKmY6knvX4K2+zlGdOGnSAwaGD8QGitmR0olPK4UirsunVFQ?=
 =?us-ascii?Q?cACbi/uuFA9UoPnz1Dd6iT5jtqOuMs5l7ZF4dnSOKOnNo0d2cX1oGoeOD+pA?=
 =?us-ascii?Q?JSbEjoxkw9XC9IM847dDosfRuiH6t1hnq1n1D2eazacL9mzYx8dpxinKr7ED?=
 =?us-ascii?Q?e3aeBlMIyxjzgecSJZGh8Sfjy7SU1oXAD1Fk+HJHP9210JpuvdK8RbF1wF6b?=
 =?us-ascii?Q?6d9GxU4NILv+eWoCuKgt92aJUH+RnhZ/OUq/Yy+guIqIHJGGe9Qf9Lizdj6K?=
 =?us-ascii?Q?Yid5oxin6i9YdFjUCAkqiTjMXm1G5KOHQNeW8Q4Vot/qK8ijnDBjoJGt6E8P?=
 =?us-ascii?Q?qy6grwoPRPmNWUCc97ZSXbH21rDpvGEcTikV8tIKLBWhQ3bHjDtiU5M/Q6kQ?=
 =?us-ascii?Q?th1Jl6vV8qTDc8ubJgm9PT8g7CenfrwaIF3eysC8wknRn85OE4g2UC6sdyw7?=
 =?us-ascii?Q?eNT+keQYImxgNmftx4+Dm+hQK7hN2ogD4UwOn2of?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52139b24-b63d-4fa5-3bc6-08dbaeccb9e0
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2023 11:30:52.0495
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wdJyqNuMlcrVjZ3A5lpRRUZFo519BMlL2qsZeKpor4Rph0SZJySrpsp57kBGWLYUD7trddhyN3E6Am1mGAo4EQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6222
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

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
 lib/iov_iter.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index 424737045b97..5d9c8c196a39 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -313,9 +313,15 @@ size_t _copy_to_iter(const void *addr, size_t bytes, struct iov_iter *i)
 		return 0;
 	if (user_backed_iter(i))
 		might_fault();
+	/*
+	 * When using direct data placement (DDP) the hardware writes
+	 * data directly to the destination buffer, and constructs
+	 * IOVs such that they point to this data.
+	 * Thus, when the src == dst we skip the memcpy.
+	 */
 	iterate_and_advance(i, bytes, base, len, off,
 		copyout(base, addr + off, len),
-		memcpy(base, addr + off, len)
+		(base != addr + off) && memcpy(base, addr + off, len)
 	)
 
 	return bytes;
-- 
2.34.1


