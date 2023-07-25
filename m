Return-Path: <netdev+bounces-20698-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 841AD760B26
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 09:07:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3DFB5281747
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 07:07:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32E688F64;
	Tue, 25 Jul 2023 07:07:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2518C8F45
	for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 07:07:10 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on20713.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe5b::713])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69A75E5
	for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 00:07:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RV4Jio4fqOBW9ro28mSWj1cVoR7Muo4pBRPUKB+8umpJ0+9jz1WvPG1io0X1zw+vxUmS2lSk+gNlUPJ0zN4zthlswN/uggqiKmbtWz7XH0OIF0H7SIFLyvSUnnudImhByP1YKOFtNZmrH3sk2y2VN4mkT/9dCnvUeLy8sP27k2Jek2gpTiOyP9b6TNy8IxOzh1FIlVu4GAZZv+iADEu+qj/AeF28SrLss+SKlNnc61c2WZj3Zq2QoTGdxCswgYwG0ZIkc8d46cj7LGUOWOCyENexIirj3IxDcXkYjUexzxJOy98JJpxyKxnMw3V5CzfOqRf7d2Lj9m6J5wqC6UEyOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XT10Oj1NkkNaor+cN6MeKuyq4zvDl8qbIiEFMDsrd90=;
 b=bNGE8tQ6pzJsQeTY5Fe5ZFNkPruDn63666/L/s6bKNuRl7y7OqC2i3J9QZsO+dKnO3aVdtY5ldfsKac4Zg24efU3TxQZrJuQ1lfLzzx+pmubhkGZBcf5sPx55Fpo4o+jUldfMNFNA5lRpWR6SZHen5nBLsOkUYNctaaa+tfSDQk5Thjc+otLOq8ElrVFzEModEfegIyWM+/XyYl2/Jqv846zfiBQsjkQJm80ieACfmT9xbwQ99iunzUqVggJozp6qL7DqHCcAikI1zirwgib9uCJ40Rcl0x7DejQH4mWO/iQIhIbpF947F7YSbrRIh+hqfdb8PZQSmiO+ILuigWQlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XT10Oj1NkkNaor+cN6MeKuyq4zvDl8qbIiEFMDsrd90=;
 b=eEOrcqA90xmQNUjK941FswLNMmmvO4PqvD8ib7EZoO7ix8WlL6qZwllGQ5bze4VZV85FupRBkXuFJxDRyQg+d7wNLA4Uvp9HBiK2wYi8QE4ZzCEO8J/gzcZYJ5YYXTg1BWu5sVldvVQ3pGcbju1imlBXvLfDzkHqvI3ZkgD7Mmg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from PH0PR13MB4842.namprd13.prod.outlook.com (2603:10b6:510:78::6)
 by DM4PR13MB5906.namprd13.prod.outlook.com (2603:10b6:8:4c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.32; Tue, 25 Jul
 2023 07:05:01 +0000
Received: from PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::fde7:9821:f2d9:101d]) by PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::fde7:9821:f2d9:101d%7]) with mapi id 15.20.6609.032; Tue, 25 Jul 2023
 07:05:01 +0000
Date: Tue, 25 Jul 2023 09:04:54 +0200
From: Simon Horman <simon.horman@corigine.com>
To: Zhengchao Shao <shaozhengchao@huawei.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, kuniyu@amazon.com,
	liuhangbin@gmail.com, jiri@resnulli.us, hkallweit1@gmail.com,
	andy.ren@getcruise.com, weiyongjun1@huawei.com,
	yuehaibing@huawei.com
Subject: Re: [PATCH net-next] net: remove redundant NULL check in
 remove_xps_queue()
Message-ID: <ZL90FnzgLUAPc1Sk@corigine.com>
References: <20230724023735.2751602-1-shaozhengchao@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230724023735.2751602-1-shaozhengchao@huawei.com>
X-ClientProxiedBy: AS4P190CA0029.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d0::19) To PH0PR13MB4842.namprd13.prod.outlook.com
 (2603:10b6:510:78::6)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR13MB4842:EE_|DM4PR13MB5906:EE_
X-MS-Office365-Filtering-Correlation-Id: e328d22a-d93b-4f71-8dc9-08db8cdd76f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Akv/WK5ExJ0I+f+LJbnJ89JEBUp3X2HhMG9tcRso65DF3B/SxSrDxfeWD0Mj60T+s1g6ixTMbifOgQE7lcdfl9h0P/eYUS326QR9oOqumDYcuIT8rDuS+OQEaa24xbhQEUQmioeoGcfIZpaT9T12vNFGVZ9J1Ygaado/JqROswikE7pUv6fIyunGvdwvHd5Lx/dMmvPPtN8yfdwxU4Cq9wH937f201T7hp5RwHoIt15skiXz+6H/pScoCL820pIZG0WS/83fGWYwr1qFpGaIa/fePedpuhmlCG7vjwwK18R3Ceu3x3EGVX/I3XyBFdds8tQ8QbflkVmEZyAn3q7yNd2GXH6yoVl3yrWGB9iTAWe1D3UpdNjyWx346O1M1MwMW6IkA8vokNtepqG6N2faKVEGNkfKhfEnFnQY6ULK3pTa4iNQnl6Z23+wvV6VjjXEm50QgRX4wdMQ3yhygsZnoERsm2BFYTTo1vV70OK+lwBCk3V2YBMDTyvWsrckgAbHGvB7y9wtq1OEoMAJM1w8yhaB/xhE7JSY62z8Z0cErrt9MI3c/xiwPIrV2BU1WFnCCnzuS90bUtjqMsOW97rpj6hx8a4QNSiqMxIPw7WozMo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR13MB4842.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(366004)(136003)(376002)(39840400004)(346002)(451199021)(6666004)(6486002)(6512007)(478600001)(2616005)(186003)(36756003)(6506007)(44832011)(2906002)(41300700001)(66946007)(6916009)(8936002)(4326008)(5660300002)(7416002)(316002)(8676002)(66556008)(66476007)(38100700002)(86362001)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1GyfJgNmiRMAILQonJFcFHD+BkYkpJayAn2il68pa9x6y5pu0VM1zpDcpHQf?=
 =?us-ascii?Q?omvKavZpAge+BLjXQIsiw+OfxtQ62hXbF9gijDRzSxtovAIIm/P4QG8DQYmb?=
 =?us-ascii?Q?wgkWmDY+NTEwHLQ0kASCQsf8gaTx0XNycing5MbJ9sFuGQJpovjM4ZF3svC+?=
 =?us-ascii?Q?NGop0Tz+jKmhUs0dZ5IR2/kLpXCUdr6N8MO9b/87ZbDLq8bq9rkduG3On6mh?=
 =?us-ascii?Q?Uh4wwpSkM5LXsQ6cVw3+E5f276FmtgnzX7IoUQog0pH5328cATAH5efj8+iy?=
 =?us-ascii?Q?J0tMP1HJQyxZPaBjQJBxg6+epDR47m95n2UyQ5tpBvhEm5aqHMc+0R6zhmtl?=
 =?us-ascii?Q?G6nL0BXx0O4MyX6e1h79gFHGU3Lkzv/bedoM98iumKNvaHsWLYJFJxJHtM7I?=
 =?us-ascii?Q?ZwIRBuAvSqabpw1Ux/7Pe3okF0hk1bkAFO6hw7hOi8pc4AjapO67MbwCCRg2?=
 =?us-ascii?Q?dO/PFT5XZCfaHHm7+6opkK7p1qU/x1EoqIo6cai/CwZBWTQmNCOz8mn++2mg?=
 =?us-ascii?Q?Vwyf4cB8etIgjoQ1xfjma6xLIu7LlbMI8Co8EEInCZhgYkKXgNiwF9iAAyJi?=
 =?us-ascii?Q?uIZVuPq2Bs2rkicAAds3vRNam6VDPLX66bM+odp0KvTF51FdkwHkF6ACEyGL?=
 =?us-ascii?Q?ufmICy6OOe2cpcfCYuqEsqp8w7d2R6LelYja2t7SJb0OQyH9ibQChLs+6U8V?=
 =?us-ascii?Q?zLCP3JxNCWogfzFH3V8qQAxQgPWcEsat64Hjwsw1hI0z+hFlITzPbshStaWd?=
 =?us-ascii?Q?PYnYbT/YUMN36SdZ0R8Nx4S4QeMDnCBfTgTzzPn/ZPixShw080o/8eDCaETp?=
 =?us-ascii?Q?47qi3xQoezFF8HL0OckK2bu5y5c6NyKVcEtoyVhfgywDZgZpP3x5I4fpAgqJ?=
 =?us-ascii?Q?XIsNKEtE6XM9Keb1g9A5G/28JZBQHveMoKvWrnBmk0kojhIfc2Ciw5n/M8Lc?=
 =?us-ascii?Q?Px0y0HZBUmOUKRzjjZ8KX5zXqzhtS+KKeH1FbQzBMVkGZduKC33ZFvqEIOK1?=
 =?us-ascii?Q?Ok69zF4LJ5iylas9l+0aqImnv/qaW+WqKZmFSkL1Y0E90eh16kr+J0HPBemk?=
 =?us-ascii?Q?841AHlrk7KUf9fnKH8o6uLbpsLxq6FkIAvLuVYXH8c/fQUNwV6bCwbuSZxfo?=
 =?us-ascii?Q?y4ouAn3Kgam2F/MyNt4pn81hmFGBp9L/HpfGORG6zoj6X51ONzp3PIpoMA8D?=
 =?us-ascii?Q?4lEHfDCHFmotBvGwBqSG95FnkxZUetOs1DrDV5CbU8HaS+R2xo/3TZixPxeM?=
 =?us-ascii?Q?gVDF6qADkAeiffVCjYWtEvN+OSTrMj1+HhGfTc384sng7tzLookAiCKccziP?=
 =?us-ascii?Q?z0gCaG0eZjT6wXdXXCD6qAaFyuT5VwksSNY5vSTJeGOLiQXQub/iMBKGSWMZ?=
 =?us-ascii?Q?aftXWoAJS/OLJ4d52P+BEM579u6zrBZMwZK3qBj+AxC3BCavWXHfgAsiYxUu?=
 =?us-ascii?Q?6wmZmlxgGky26kjSUytya3GEHLk+8UVsXkFhiFe+tSCBQXM3xlZAckbUHTa0?=
 =?us-ascii?Q?1OANe1gVEZhtOiA7UhZQQ22ZUF4i6914FgTE8zMvDw2LsCIG6bu9beD1IDRk?=
 =?us-ascii?Q?EhZSsej+fcDo+KWMDSrPh2fplL9udf1WtDVRtv/+g7XhP/DMn0O1dnCCF5pu?=
 =?us-ascii?Q?aW3p3Px9wqx7wemXN/WnySMXbaQQhqhr+CJnVHXrG/6n42QlhmxzdO5IuGqh?=
 =?us-ascii?Q?ys82zw=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e328d22a-d93b-4f71-8dc9-08db8cdd76f1
X-MS-Exchange-CrossTenant-AuthSource: PH0PR13MB4842.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2023 07:05:01.5762
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /EvOZHbK3XyDv3UZg0wycwk/6gDnBLxrmkK8H6NS6s6ZFTpa1518UIfbS+aGQzk7wevU48PDxlQdQ1WQWteaYOQEOLW/pGkVYEvZ0XOn49s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR13MB5906
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Jul 24, 2023 at 10:37:35AM +0800, Zhengchao Shao wrote:
> There are currently two paths that call remove_xps_queue():
> 1. __netif_set_xps_queue -> remove_xps_queue
> 2. clean_xps_maps -> remove_xps_queue_cpu -> remove_xps_queue
> There is no need to check dev_maps in remove_xps_queue() because
> dev_maps has been checked on these two paths.
> 
> Signed-off-by: Zhengchao Shao <shaozhengchao@huawei.com>

I have verified the reasoning above is correct.
I am, however, slightly less sure that this is a good idea.

> ---
>  net/core/dev.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/net/core/dev.c b/net/core/dev.c
> index f95e0674570f..76a91b849829 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -2384,8 +2384,7 @@ static bool remove_xps_queue(struct xps_dev_maps *dev_maps,
>  	struct xps_map *map = NULL;
>  	int pos;
>  
> -	if (dev_maps)
> -		map = xmap_dereference(dev_maps->attr_map[tci]);
> +	map = xmap_dereference(dev_maps->attr_map[tci]);
>  	if (!map)
>  		return false;
>  
> -- 
> 2.34.1
> 

