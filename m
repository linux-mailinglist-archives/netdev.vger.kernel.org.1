Return-Path: <netdev+bounces-29664-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 381827844FE
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 17:06:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 131E01C20A71
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 15:06:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBCE71D2F5;
	Tue, 22 Aug 2023 15:05:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF3A879D0
	for <netdev@vger.kernel.org>; Tue, 22 Aug 2023 15:05:20 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2075.outbound.protection.outlook.com [40.107.243.75])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 948E0CC7
	for <netdev@vger.kernel.org>; Tue, 22 Aug 2023 08:05:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SrgkLRbPDFkjvphXQ756C3Y78E2yf7FNkuliTFZkVILKOLcZfBLkG7/psjhY/CxeFBp1CFtoEuzJWqkNzEZ9sHbhwUIcrdqzzYEXeGiHD4yyBlw5ZL+RKRLnCyZa5v3KKR8orq93oD6ERnJ8Ntd7ZJGBvZv7l1Qc6b7AAPECYHqCoIgddNbEZRYZ+OarJALc++WgkYxyyyolmkwOR5ECxc/kVWEhQ4CcV5iIkoN8tfUQIDHkwPsOoDXNpdjC0vlE85v0rBESaMbpQwYZdsZ3YATUSssATNFW2qfi/p57Sx/OJMFlZgh4xAV6Xp6sm+c+G+KRU4hSaxdINrVUDSFs+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6t1p58Xpf8Y9RiKI2/rVWEgBeA/a6ZSFAI6MWqzpnPQ=;
 b=oJfv8iv1/mXyZitdaokAwpmXqqgXdRa71xwLYKcd+ecK0Dltalvu1EkqW1amTXJwaqynYdfLLr78MF43kGZHizdlFlOt8f99+5pC+2k/QJySYYoevbGFFff/5xNL8ySU7BT+uj10wt3n5GS1NU781tXdnqi5H0XnAZQYHvQCZkMa9EYXs60mtUyBMm79f1HKL+ULp8LHcB7JIzvnCUsvuibWEZZ/9sE3vHjeHLznIcPTS01hETRQL2bsvKPa+HbnjjCYKTGiEj21p4vIaAEvTSLu2Ir5Eiai5gDzjP8lrj8xuKVMHdDRIopohU0y3/FPkSgtkp0pFhxt+k8geDxDDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6t1p58Xpf8Y9RiKI2/rVWEgBeA/a6ZSFAI6MWqzpnPQ=;
 b=JwfzTurvzuHUBGEyQ9QOSa6WHF/DXOoVv3eAwT7DlJGI9wjpe2xMMS/azSBEK8MGTlTS41ZDhPysi9ErRzg2Hwj0TZ2zxGwR78CpikPyG19iAJDCJlxITBXRZ6Wdqb2ejMXGqxkwyiErb7B03h7fdC+IIcrL50d2pkjge9qmeQAshEBdCrQMuJi/qe2xFSZjpd1r5DwdzjlCdk1w/EjcJIUI9aOlPn+Q6gZuDQYyBw4659dafwGE6Gqg4A/j0119QlatYPFxlnsF9ZIb2H7kV/UDw6nOucb8l0xva8L0atNxU6BR9rUqs3EiFNw9lWA9aCcPOBDQHfW7vvEpRmVRGw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com (2603:10b6:a03:45e::8)
 by BY5PR12MB4322.namprd12.prod.outlook.com (2603:10b6:a03:20a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Tue, 22 Aug
 2023 15:05:17 +0000
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::968e:999a:9134:766b]) by SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::968e:999a:9134:766b%7]) with mapi id 15.20.6699.020; Tue, 22 Aug 2023
 15:05:16 +0000
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
Subject: [PATCH v13 05/24] iov_iter: skip copy if src == dst for direct data placement
Date: Tue, 22 Aug 2023 15:04:06 +0000
Message-Id: <20230822150425.3390-6-aaptel@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230822150425.3390-1-aaptel@nvidia.com>
References: <20230822150425.3390-1-aaptel@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0192.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ab::11) To SJ1PR12MB6075.namprd12.prod.outlook.com
 (2603:10b6:a03:45e::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6075:EE_|BY5PR12MB4322:EE_
X-MS-Office365-Filtering-Correlation-Id: 9775ccc0-92ec-4a08-42c0-08dba32131c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	T6ZHj9vdDPJenNdM8tk5vcCo8+ziMPCFdAHdqT54uYvbtfQlMwovA0P7aLBlDQ1l54YPe6a33gL/dDGUi0cv4cUcVIUJrGkmCnZdW2pjF4iMv3ugTPKeyc564EiY7IGpu0b+AZiEY7mlK6Tv47xzF5fsTslCZyXTx1kGMn0dW0kzIcKQJO4uzRkPIMj0kQJeNbM4FsJ3AG4gAkNxUN6SEcESNz2PCpK+26Hyqfqffrtrua69AVqyRU7lZ1vBfzjRF0g/V97WkpoUf46nliescaMYDLqzQeZHE/6hGKvZEow2fOcPjTqESBsJWvsyvZOlhpJy4EN4HRtmSIOp1fAsJIZeZ2ggOONQikwQTLquWkMf/84TkcgU68imPFQQliuO5gRNJa3kb55zqN/XCp347f1NJZP/4QVZ5nP4iekPvWIY6aPZlrvTohQt1ZQDkbLGL6sjFFcMyf8Eps77bzvXRYcriPMw4gXY0Bm4am+eZmLM433uj+W4YSOAFG0jueMfckjc2zbsf40mSBs5E1igVA8jbRy09EyBoeYmlongqEaCW/s2dNhqACAm2ZbGctCX
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR12MB6075.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(396003)(366004)(39860400002)(346002)(186009)(1800799009)(451199024)(66556008)(66476007)(6512007)(316002)(2616005)(8676002)(8936002)(4326008)(107886003)(41300700001)(36756003)(1076003)(478600001)(6666004)(66946007)(38100700002)(6506007)(6486002)(83380400001)(2906002)(7416002)(5660300002)(86362001)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3k/Yu1sqU+il552wDIHzRSXBE8vlZHWjTodRnyGl/M3jmGfndTtKGkwLYTwA?=
 =?us-ascii?Q?5Hzzcx1Ir03h/6SiJVVwq8rjD9+zRU0oHZYrC0oCUYTea8eHsuvDaPixcqff?=
 =?us-ascii?Q?o8v4Mxoa6GN9Ua2v3XF7sEn/VH/nNhLf4TpPoCVRNkqlS4Z5ao+/UMtWLjZ8?=
 =?us-ascii?Q?T9oFDk3wykvM6BAJ4U7E1dJ58y592djjaRwtNcTT0HXyb0C2ytaFfmL04k8B?=
 =?us-ascii?Q?1IWNU56dnFvUloCD4fO0kd8YxP9Pp1QP7EX/kvTEvuImDtUCico8QF9eeccv?=
 =?us-ascii?Q?Xn6QEODRBUyqNeapFmh741+xjzYszEKbA90ZsG9xqISW3fDD/9A25B6Bj+f/?=
 =?us-ascii?Q?LUcWMNHqKtAf/8Hdsco89Y9dKk/Ns1vBGysqwrvQNA4fH6+rh8AH8UNKsnhw?=
 =?us-ascii?Q?9xQ5rw98JiP/WdjVpFP6gtS9SUyJEWwZJ2g799yQeoZhDe4ydCsNqCy7xpPV?=
 =?us-ascii?Q?8Uo7oK3xTb1KMkJQc7UWsUmOK59N0Kp7KvhgOQTCsx4wkPi+xlDUr2NI+G9j?=
 =?us-ascii?Q?UTw9vGYrzamR7z/RYlxyN43Pt9mL7XrdWxAkNXMVJgFsDp6IgnWOuN2lxJoh?=
 =?us-ascii?Q?5qypBMNIDFHuhrOfg+dXdi/HQS9jTJz5BP2FZapgDupAT0squkY1/lCSIAg1?=
 =?us-ascii?Q?2purtoihMIl8XLOMgnVOy0ZXIs5XMIsWRDR0YBhWx6eqkscmJKA16OHQj177?=
 =?us-ascii?Q?Bhj4dlqEFaDMh6LV3J5TbVb9m6+1jnhZXe+MMjZVj+cImEVUNibtG7I0v0Ls?=
 =?us-ascii?Q?x8agLpWEkIdOmWuMuFd+K3AT93vHa287pzHZkNMm3GfcnYKRTL98XNIGoxkP?=
 =?us-ascii?Q?hMpJsYU7D6Nz0TISATg+DzHQrmomSDee2jLQHxPNEwvri1fWwWw3h168i54A?=
 =?us-ascii?Q?WOSKpn6hq+V+0wORhxdQHaui6Vg67c0Oftbx5V/es86s30vBrNuSRwSsOepv?=
 =?us-ascii?Q?2JMvxkgjvLQOUyYBzczMwIOoOfBu1IJlo5y/a8q9bnx3J2X8pBVbGvFUQpAw?=
 =?us-ascii?Q?NGxArjsU1umcIvPE2CDWLo6ZSYqJ6vPlkz4lx2hpLAR7OuvWvvPY0lgm7+5k?=
 =?us-ascii?Q?LBXX1eEOirDaIQ4/uIqkpBZPksEKcdNjwQEkBNNtRlBlKwQ6Qg63VqNw13uO?=
 =?us-ascii?Q?3fXqiiKKFsDW8H/6LMWjwyruWUcKNOEaIIOvdv4z1IS5bQOQ9rZJc4ligzb1?=
 =?us-ascii?Q?af3VDs2hZIyXbp6g28VDSgUCgUE7uyQPydtCebI8HIBcxA39jTeevChasNyH?=
 =?us-ascii?Q?Sf8gwi+kEyKXL9mdamcBxJZtMhIghuCupe1gembIdedbaZzCDpkn2LSC3CQY?=
 =?us-ascii?Q?tZR5BQ+FT20NYAnL/GvvisglKrkuwpQwpkhxIerUIEJp9zbWabvns4W2uW8r?=
 =?us-ascii?Q?dVOFbZ3mo6KZov6y/WaRMdqEspJ9zqz0gu8ih7ithMRIMvHhOJaxcY1QFgjO?=
 =?us-ascii?Q?XUIzlY3w7erh/jEWZky02sNMRnHmbEg677eAOmG+UYZHR9PsT8NrZTRY0PYx?=
 =?us-ascii?Q?4ri1LV2zzqAxkFMjMs0glq7klow7PPDhsRzbZeBagjbSO5QMKzk3BbzW81C/?=
 =?us-ascii?Q?fXytw/PMxmOpTNGF1BlSi91EnDq1xwMD7zdLxQ1c?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9775ccc0-92ec-4a08-42c0-08dba32131c4
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2023 15:05:16.8313
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5wIELCvmOKrCvL/dN4w2hJTECgr6bVtb34UxbeGVx1rIreCV8LGoCy9nZq7BixYAlE87lO/oaPGScMdkxNH4PA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4322
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
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
index e4dc809d1075..f01ee0e28295 100644
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


