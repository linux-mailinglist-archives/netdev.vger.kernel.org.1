Return-Path: <netdev+bounces-30931-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6AD6789FAF
	for <lists+netdev@lfdr.de>; Sun, 27 Aug 2023 15:55:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A169B280F83
	for <lists+netdev@lfdr.de>; Sun, 27 Aug 2023 13:55:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCB2A1094C;
	Sun, 27 Aug 2023 13:55:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B94DB8BF0
	for <netdev@vger.kernel.org>; Sun, 27 Aug 2023 13:55:36 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2079.outbound.protection.outlook.com [40.107.223.79])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5482712D
	for <netdev@vger.kernel.org>; Sun, 27 Aug 2023 06:55:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eJu2VZYRP+q32xYN/Ts1w3vcjg3hhTXlLq3rKR5PvDjo6aJnfNRAJ/oi3L0ilQ6cIxHbLb6dIlAtqda35kAP4mgKxWXQNAnb1VtRpYYU6IFYD77ldhvAe6TUKa9l23J+2McdwapIsj4NZPCJpQAZS06sAgv3TrbJ4/9XNUob8eGVfXhLrSYeuxc1Zmx9CM/Y50Xzyc63WJO1rX6SeF4iLP8YTTyIYafPOD2N6ighp5sZYwBgMxU6VPvZWqhciEBNAKKjpm4hcUmbnzmvsMTYw+US+9ez072fDO6auR044UyGQAbrPmE25ZXGmLQsW8+MAg3jy4CQUp0YDfRNAf3BSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9mQvOsAsYVRpKBz/2JgMHXpU+PSXkrp9w8+146vQE1w=;
 b=aSvyDCb2yOjTQj2pr9DFQ9k3oYbJWgG8Zv2C8AQW8ise0pAsFx+tiMx9pQgxHwq8SiAUR1gsVIEfDM/SB3hjcl0dan922j8gvoVJykXjcg8RWNtsrjqkwLButYWilVtgQbmrn8LdVF/q7OFFm5TIav4jv0S/TjDDMJS7tP+9wsIUcAkUGIyusUM35QcyyZh2/X3TIeaF/4aGG9xVhuFTMuwu9kKio+5WioEvEEAU0RPOYFaYpSHQoV9tz8665bJxdYWlN9lM0veFf9EB+0741PpMNiCTiNtvNPQsEhY/xxuJU/CkE0WueZjihV7e332B60ZxuNuh0bpSIBaD3ycrBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9mQvOsAsYVRpKBz/2JgMHXpU+PSXkrp9w8+146vQE1w=;
 b=LZtEIMX2drJifiDRqcm9IZTozgfPADbC6+mr/9nfDK82YNYV8H8NcAhVukTiaG16SXpVyEv0yDo2zct0Rtk2itX159rEFQPVVkrS/kHIt0rrP7cUFwniOzmaLfwoE6ADxpUwm8IFM3ZTnaFK3GcfXYOCD9BQjdetfbo6IYF5oN9bdG1ERjA/yNAxQyGbQGRkEc3u95s1zNNUcpya7CVWAW1OEXP6OyXz/rZu8FjoZjGi+yjRisIwVStWfwWDUqIt1q4bBNaBWh8zKxrlrcCJzxfIzfP7T74ADVCqYwlHZpGL1EkqGfWZjN/wHmhDhYbuquMcidOzYUWOs1+n8VlBMg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB6288.namprd12.prod.outlook.com (2603:10b6:8:93::7) by
 SJ1PR12MB6052.namprd12.prod.outlook.com (2603:10b6:a03:489::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.34; Sun, 27 Aug
 2023 13:55:19 +0000
Received: from DS7PR12MB6288.namprd12.prod.outlook.com
 ([fe80::2666:236b:2886:d78b]) by DS7PR12MB6288.namprd12.prod.outlook.com
 ([fe80::2666:236b:2886:d78b%7]) with mapi id 15.20.6699.034; Sun, 27 Aug 2023
 13:55:19 +0000
Message-ID: <14c3f6ad-b264-b6f8-19a0-5bc8ad83f13f@nvidia.com>
Date: Sun, 27 Aug 2023 16:55:10 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH net-next 1/2] net: Fix skb consume leak in
 sch_handle_egress
Content-Language: en-US
To: Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org
Cc: davem@davemloft.net, pabeni@redhat.com, kuba@kernel.org,
 martin.lau@linux.dev
References: <20230825134946.31083-1-daniel@iogearbox.net>
From: Gal Pressman <gal@nvidia.com>
In-Reply-To: <20230825134946.31083-1-daniel@iogearbox.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR08CA0261.eurprd08.prod.outlook.com
 (2603:10a6:803:dc::34) To DS7PR12MB6288.namprd12.prod.outlook.com
 (2603:10b6:8:93::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6288:EE_|SJ1PR12MB6052:EE_
X-MS-Office365-Filtering-Correlation-Id: 25744fe9-42f6-4318-3aa8-08dba7053fcb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	gjyxkBQKNzsHPNG9AHA9ODlpUBzySm6SZlOg7rYDt0CuOjtZOPFPVRoObsMaqDAj9zoXehSQdtCUYqq5s0mt9wPR2a8UoU6CQq0rEp27ZcasyyA/cYQMN+/gw7bYFUfjWRw8e4A+GR56nBXAW/h1qZl52O9d1SsAH5HMHJGWP6rXX8pG4yQNPJqc0O9tD55L/NLcKdKtgYK3HGP8appA6avrMzAGrNigdD26qylij8C8onB6y0vrAM7RwP0Ha8+1JVhLXzPZyPOY/7IZji389/j/+n6rvExmOXSQ5YxLFmZTLOHBeCfJ1rgdOCqgDGfqMZxNwxFh4oX1ZToNioKPxH+pjitQwLGkANFwMeTNex907dmCl1dNdazYJ3B0VBiHhEtDdVWKQdpyVVfCC5Ligun1Q1JbBAO+egqxRTVNyzN8z2nZWlyFrZ2eAJhSiamMn/+rYT8QiumpZJ7JOnu48Pjx+3VfwUgbPjUsbBIASU4/2aUwSPufrLqpNJBlD8Y3qAx/TwQ3Z4LQ2davNxx1FqlOvkkYXOUOiGm/xmXYbmBijxToGOweTHXYtrKsQ7oUlYN9mDc3lgtbFhP40Xtfi9kouZz2S2cFpx2vktnLhQoso9wygSkR0NvfsEug2/YWVC0bgt/9cawlWMgDOuaK89KENou3PjvgqDnOGXV2G8MxNZxfZtVeqNlrPndt0TyFsnCRDQ1xaySSCCJFKGc0GjqcTfkStnJxYjPElvAIEtU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6288.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(396003)(346002)(39860400002)(376002)(186009)(451199024)(1800799009)(41300700001)(38100700002)(6666004)(31696002)(86362001)(966005)(478600001)(83380400001)(2616005)(26005)(6512007)(53546011)(6506007)(6486002)(36756003)(316002)(2906002)(66476007)(66946007)(66556008)(5660300002)(8676002)(8936002)(4326008)(31686004)(45980500001)(43740500002)(505234007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NTBhdHVIbnFVV0FEVWJpelIzaURteWE1NVp0S25ZV3FyUnV1eDJYRjBFREhO?=
 =?utf-8?B?RjlwR3JwejVEWitNT1BNT2pRK1R5ZWhXaHgrL2p3NHE1dXBFSnV6WXg5R01N?=
 =?utf-8?B?RWhOdVhCREZmUGxjOUFKazZGMEtXRmtOdmpXK0pHbTRMcEY2ay9pMldDd1Nt?=
 =?utf-8?B?bHJCMHY4ajlCYWViY2drcGUvSE5NK3NRdHRtSDhyb1RFZ3BKRGU1a0hQMjZ0?=
 =?utf-8?B?V0dhMFZxbXYvRndoWHBOV0dwVmk2MnJmU3BzVDd5YmRYVytwZ1MyVlc0Q1VZ?=
 =?utf-8?B?OEFDd2FGMXJrN09SeVZDWDIzRUpkODEvODVWNzd3KzNoK01XWm1MVThjRkE4?=
 =?utf-8?B?UjBMdHByOThwaTlVOW9jcTI2WlZKNzR3d0JVQ3pRRkMvVW1iZkpZZFdWWFQz?=
 =?utf-8?B?ZDlvSE5xc0J4RXJTV2NncnY0bGNkaklVRm55M0JwNWV5azdBbVkvZVZ6SC82?=
 =?utf-8?B?ZXpxUVIrRk95T1dNeHppeFZMSUcvcHJrYzlZRXpLOVhRNSt0cGpYRmwwVUlW?=
 =?utf-8?B?NTlOWTFiOFZLZDk0UWdBN0J2LzdOMXBWWnFPQzJ2d3ZrcUpoVk5wZFVnMlBG?=
 =?utf-8?B?RkJ3SzgrUzFoUzdlT0l6QjVCV240K0FJMXZCdG5EWTZPSmZ6R1FBRzcwTmJ2?=
 =?utf-8?B?NzNiSVZkY0dPeHphbFg3cnR1RzVoTXlCOGxxTEhRZ1lLTFFDTnBWTit5M2Fj?=
 =?utf-8?B?SDVHNHY3dzNKYXhzK2RMUFRpNzdyZ1MxSms2TVN2SXFkY2RCdThRV3ozZVhw?=
 =?utf-8?B?eHNUWHRjWnA5dUY4K0FwWWMyWm5ML1BDeUpRV01PelpRUUJPWW54b1hnZVZX?=
 =?utf-8?B?RXEvMWtiLzBPUnZidmhwdHpNTzhycHJCYm9yNDNoUVBHejBZbmZGTFVnZTZN?=
 =?utf-8?B?S1pWYm9DMGJrcHVLMGx3L3R3eGRUTWVrdHo5NU9PeUdIeSs4cm5XRXgwUU9R?=
 =?utf-8?B?RlExeFhuZTlocXpSZzdhU2tWcGlFV3BKK3ZGa092aUZTOWp6cExCOGlwby9p?=
 =?utf-8?B?bGRPWVp1ZjV5cnZ0cy9LUlBaYnJydUJtY1pPRHcxKzB5WEFUUFRlUzQrTGRP?=
 =?utf-8?B?ZlNJNWhZcnpiTUQwZnE4R016V3pPa3dXSEFuNXQ0RkZzOTJQVWlsVDI5Ty9m?=
 =?utf-8?B?SXdzSkxqNkVTOWErcmY1dlNkakZwck5JeTl2Z3RmWHNXdUpqOHlpTjBPSHJQ?=
 =?utf-8?B?Z0lSUld4aTdvWWpLemsvUkJiS0trRXgrZmtEU2lnanhmMVRuZEx1Rjhxb3Jh?=
 =?utf-8?B?SGVYZzhid3NDZFlRWlVOZTg5ZHVKd0JTbjZpeDhCcWVNVUNrQlBtT0x5c1Fx?=
 =?utf-8?B?WE1YcmhuN3RaVUtJbkk1cUtPZW0wSmtEUkZmRHY0UWZrQWpTOW4ySEJwbXo2?=
 =?utf-8?B?TVJGSkdpNWFGa2tEMVdWT3dJVGdGY293SW16WWMxUVE4YklvZXlZL3J0SGQv?=
 =?utf-8?B?ZzVDa3pjK2NrUUVFWC9NUUthYVVZeUsxN25FQXpXelJTblFNWU1vQWxSTWtL?=
 =?utf-8?B?MDcwbzV5a2RIa1MyckpRcEs4MTJPcVNXUGxLV2V1RnFpMlU3ZG5leWtLU25o?=
 =?utf-8?B?WGlwMW1hT29uZjErYTF6VmV2UExkRjNXb3pYUFFMcGpJS0hyc3B5dVJOMlVW?=
 =?utf-8?B?aXU4bWxCazFyMFRIQitteGN4cjlHM1ZqTG5FL2RPb2xLR2c3NlptUGYwblU3?=
 =?utf-8?B?eE42b1FhMzQrLyt5V254TW1hVTBKdSt6eUZiTTNDOCt2UHplaWk2ZG5lQU5k?=
 =?utf-8?B?WTRHUWRWRk1GUm00cDYzb1U1YTBUTmVmR3o2ZFF4cldmQVNDSFhKWHVNR05l?=
 =?utf-8?B?WE14NFpGTnp4WjFRQWI1NzI5T2ZzeVAzRW95MFFSZ2hzV1ZDbG9hdk1oanVQ?=
 =?utf-8?B?dTdzUmZDdXVCbTB4YklnVHhZUm82ZERySExOcHlVMGZsRkNBZHkzSVo5MWFx?=
 =?utf-8?B?T09KQ09tQWxQWXpPcWtYc3dHOUtwems2cUsvOHlqNGpwZWtIbjZaNzVzQlpY?=
 =?utf-8?B?ZHNXS1BMRktXZWpqMEFSYUtReUxYNTk4aHZwWUU3bmQrYTRxWkJUK2F4K3Jq?=
 =?utf-8?B?dG5SbkI5SFlHNGRRQW0xcUpnODlZeTBzSnZIZGF1aGpHZVZ2T2VKNXQ3ZnR4?=
 =?utf-8?Q?vB4D1CjqcpS0p+B9y93anqrIl?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25744fe9-42f6-4318-3aa8-08dba7053fcb
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6288.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2023 13:55:19.2431
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p7URryK+5wjc8xpE35+EpRWj1+1sotWsBPVZaDYUbb/Kz9Hl4MybTkZ7ZbZtWrMr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6052
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
	SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 25/08/2023 16:49, Daniel Borkmann wrote:
> Fix a memory leak for the tc egress path with TC_ACT_{STOLEN,QUEUED,TRAP}:
> 
>   [...]
>   unreferenced object 0xffff88818bcb4f00 (size 232):
>   comm "softirq", pid 0, jiffies 4299085078 (age 134.028s)
>   hex dump (first 32 bytes):
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>     00 80 70 61 81 88 ff ff 00 41 31 14 81 88 ff ff  ..pa.....A1.....
>   backtrace:
>     [<ffffffff9991b938>] kmem_cache_alloc_node+0x268/0x400
>     [<ffffffff9b3d9231>] __alloc_skb+0x211/0x2c0
>     [<ffffffff9b3f0c7e>] alloc_skb_with_frags+0xbe/0x6b0
>     [<ffffffff9b3bf9a9>] sock_alloc_send_pskb+0x6a9/0x870
>     [<ffffffff9b6b3f00>] __ip_append_data+0x14d0/0x3bf0
>     [<ffffffff9b6ba24e>] ip_append_data+0xee/0x190
>     [<ffffffff9b7e1496>] icmp_push_reply+0xa6/0x470
>     [<ffffffff9b7e4030>] icmp_reply+0x900/0xa00
>     [<ffffffff9b7e42e3>] icmp_echo.part.0+0x1a3/0x230
>     [<ffffffff9b7e444d>] icmp_echo+0xcd/0x190
>     [<ffffffff9b7e9566>] icmp_rcv+0x806/0xe10
>     [<ffffffff9b699bd1>] ip_protocol_deliver_rcu+0x351/0x3d0
>     [<ffffffff9b699f14>] ip_local_deliver_finish+0x2b4/0x450
>     [<ffffffff9b69a234>] ip_local_deliver+0x174/0x1f0
>     [<ffffffff9b69a4b2>] ip_sublist_rcv_finish+0x1f2/0x420
>     [<ffffffff9b69ab56>] ip_sublist_rcv+0x466/0x920
>   [...]
> 
> I was able to reproduce this via:
> 
>   ip link add dev dummy0 type dummy
>   ip link set dev dummy0 up
>   tc qdisc add dev eth0 clsact
>   tc filter add dev eth0 egress protocol ip prio 1 u32 match ip protocol 1 0xff action mirred egress redirect dev dummy0
>   ping 1.1.1.1
>   <stolen>
> 
> After the fix, there are no kmemleak reports with the reproducer. This is
> in line with what is also done on the ingress side, and from debugging the
> skb_unref(skb) on dummy xmit and sch_handle_egress() side, it is visible
> that these are two different skbs with both skb_unref(skb) as true. The two
> seen skbs are due to mirred doing a skb_clone() internally as use_reinsert
> is false in tcf_mirred_act() for egress. This was initially reported by Gal.
> 
> Fixes: e420bed02507 ("bpf: Add fd-based tcx multi-prog infra with link support")
> Reported-by: Gal Pressman <gal@nvidia.com>
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> Link: https://lore.kernel.org/bpf/bdfc2640-8f65-5b56-4472-db8e2b161aab@nvidia.com

I suspect that this series causes our regression to timeout due to some
stuck tests :\.
I'm not 100% sure yet though, verifying..

