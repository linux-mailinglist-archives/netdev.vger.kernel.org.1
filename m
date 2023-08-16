Return-Path: <netdev+bounces-27835-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AD87D77D70D
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 02:24:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31A73280216
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 00:24:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4F36198;
	Wed, 16 Aug 2023 00:24:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1EA018E
	for <netdev@vger.kernel.org>; Wed, 16 Aug 2023 00:24:38 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on20603.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e88::603])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B9EE26B7
	for <netdev@vger.kernel.org>; Tue, 15 Aug 2023 17:24:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SRhI+jBAmJBcwOYl5vM7eGOzVj9ZLdj/7lN87WjhZq78W1yz/pfc3tEO2YBXGJPt3zAcZI6BHqwFDWq6KvbAWCuMI3Fxtgo6Jwg7nXJ5whb85p2x/dYRgzXAQ8ZDTrd950uo5ZrbXqLeL289lMQvrXkwGRXDqFZhf4TI6/0Bf/yl2B1vxOM/BFl1/MuU3xjKDe4twr9gfhJYJ4UMPnBvv0g/5WgjckpnvUD9KRC2fRMREX1HlzY49NBdbCDtIMf5PgzLrviUx6IE63tWPSg0Ccu67Jm/f9bFPwWgsyGxqpnit19Atq7in4HCMZKnYOzjajXyv7+8JPmgX1h+Fq6sWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GD7mIGmVYzChJtKQNqE5WJaX1q++tc2yKFzohdoRasg=;
 b=PvijlNFGP7HWixM7g4Lrv0YiIcFXjSFVR4f5X4vuLkqXPqVsyPqU3wCJfTx/wtWSqEr2w+K+Cpa3CqeC5nsr2g1tokXaaCJ4iytDuGISHaSElwmAe8kRM2A6CbRht7+VHO02F+q2lxMb8Ob36WDnQelxExic09mc31hAPxZwYp/NSNvj5tUcLLP3TFj9rBrKUT7mxcpbtJCA7wXGJnpxkcrNfKfAxDqs6vTchQskpkxaFM4DCu2MBbYq5yhP9liEBNevsh1BWdgTUgR51zRx3g1pa991PEHCLTVQRnguXgH50LeSmJljp6UfBY5Pr2/GsoCxAChLafWVH+POEaRYxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GD7mIGmVYzChJtKQNqE5WJaX1q++tc2yKFzohdoRasg=;
 b=EVumDkYHr8Brx1tcZmHH2gQWf6WwAZFVHPuNWwHy30ecNADy7E80iU7F0cs5bB/u98JJprbIb3sYJ/YhBM6NFN+L7G3gnC72eXYlaYdetF+YhWf+ht1LTxvHRoN/QJkek4KyV4NbWMvaZ2UsV08O6iGtceApk3bFXOCaZPPIvrTRnjKFyokr9aCVCHjWvNFlT483NhPx4TiJNWh33kyhpKzQ8H64/GpZ1hswgBNzXX4lqrKrlVdtd2AmWc10KnaA+v9Y5EAXUucDf1QGWD2GF2NkZtnVG7J8p1nIWUjNiY9zYwGVz+kwqF4ygRfCgocIzZbHRP6Vavv+Xvyb9kpTJg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB5040.namprd12.prod.outlook.com (2603:10b6:5:38b::19)
 by IA0PR12MB8088.namprd12.prod.outlook.com (2603:10b6:208:409::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Wed, 16 Aug
 2023 00:24:26 +0000
Received: from DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::4bf4:b77b:2985:1344]) by DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::4bf4:b77b:2985:1344%4]) with mapi id 15.20.6678.025; Wed, 16 Aug 2023
 00:24:25 +0000
Message-ID: <ef2068aa-0732-820e-fbb4-299021ca54df@nvidia.com>
Date: Wed, 16 Aug 2023 03:24:14 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v12 05/26] iov_iter: skip copy if src == dst for direct
 data placement
To: Aurelien Aptel <aaptel@nvidia.com>, linux-nvme@lists.infradead.org,
 netdev@vger.kernel.org, sagi@grimberg.me, hch@lst.de, kbusch@kernel.org,
 axboe@fb.com, chaitanyak@nvidia.com, davem@davemloft.net, kuba@kernel.org
Cc: Ben Ben-Ishay <benishay@nvidia.com>, aurelien.aptel@gmail.com,
 smalin@nvidia.com, malin1024@gmail.com, ogerlitz@nvidia.com,
 yorayz@nvidia.com, borisp@nvidia.com, galshalom@nvidia.com
References: <20230712161513.134860-1-aaptel@nvidia.com>
 <20230712161513.134860-6-aaptel@nvidia.com>
Content-Language: en-US
From: Max Gurtovoy <mgurtovoy@nvidia.com>
In-Reply-To: <20230712161513.134860-6-aaptel@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR06CA0179.eurprd06.prod.outlook.com
 (2603:10a6:803:c8::36) To DM4PR12MB5040.namprd12.prod.outlook.com
 (2603:10b6:5:38b::19)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5040:EE_|IA0PR12MB8088:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f14b2a4-45eb-45ae-b3fe-08db9def2582
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	WgsXX8LA9PG2n/CeT9kDP0HuxcTmWTCSbEY5gGQHaGEZy4uY09BEBRSsht6oTS1dppabnfugLphCrjvkxEBk5vcnzRLAdHZ+mDcAidNfWw4XuEvQNJr0x/ZJtnSjTZw8bCQEZ2hB9rgZJz066UwXnwH4geOWWCq7fXbTX3vd8thh7Ok6KaIQ9XApWqUwtDwGCdb+eirr4FuITdJAwAUKVgkets+Xb9LUHpuNUo1jXSiY+kQTXSEcxA7W04YW/i/J+rFIrhC53HU7lVgY4JEicPhMmY6iBidXr5+fnmj7NHC8O5CpeeAL7xPKzXwRMqx8qFUbuVtlweq0ZJGg5MYyiwqwh1JR28xrh0A21JEV0WXEZPIQdmJ6KgEHs+GsNBYHVOw/5OfPriQRsUXE2D6AOLeWJw2vYSnI/GBl5VpM7I4kbQ9PlNNvvCopWJQYFlTXmAgNexVM4JIS/YpHWO6MQ5LYiy3jB+ab9+yF0Yzm9LPLQw03sx68pAiepA+HC1HuzlKcBjKcsLx1tGfIaoy4BT2Hu69Q3BQK9hLwjp1NTHb1HmeI6cIFTbpN6sz7TnLx4SBSDAY+3W/gSIWp+tBOUG2Lvv0+kEoIWlqge9PHwSQRvug1pLX3PNSpQ/4p5SMAWjK05z9gjfY2WOT+N3GKmlzgXisaIJpU4C0izy+yz4w=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5040.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(346002)(39860400002)(136003)(376002)(451199024)(186009)(1800799009)(6512007)(26005)(66556008)(2616005)(31686004)(66946007)(41300700001)(66476007)(4326008)(316002)(83380400001)(8936002)(8676002)(5660300002)(31696002)(6486002)(36756003)(38100700002)(2906002)(6666004)(7416002)(86362001)(478600001)(921005)(53546011)(6506007)(107886003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WHBaOGluQ0FpOVFTbXFLY0JuZVR3MjdtY0w3TTFxcHBMVlE3UHNyWW1xdHlm?=
 =?utf-8?B?bHhMRkQrcFFlQytTLzUrSjB0MGRuOWNEdG5NcFZwQU40aERDMytnS2VUQmdk?=
 =?utf-8?B?aHFlM0lkNFhlb1ZrMDBlUjlhMlJmdElZaWxBdGg0ZlNtOGpuK0c2OFBoVnNu?=
 =?utf-8?B?M2pqU2YyMnB3ejZlYlFyS0NvekpZRHZ3bEoxZVcxZDZYWkN2ZGtwY2JLK2Rq?=
 =?utf-8?B?b2JjMjdiSmdYRUtJa2lFckVORURuTit1RWZUaDhsaUNQMnZBTVU0cnRCOG9F?=
 =?utf-8?B?cGg2SmpKVERhanJzQVBZS28xMDM4YWpzbnRlWTJ4YVRibCs2bmJiL09mdEpQ?=
 =?utf-8?B?aFNXM0llMkw1V0JVSXcwSFpLYU5td05hMkpKTHNsc3ZCQUs3QVVtSW90L2pI?=
 =?utf-8?B?S3AwdWtIY0dLZEdnYTJQWjNKQmNtZzIzZDBOYWpXSTlaUERDcXlmOFFwV1Rt?=
 =?utf-8?B?cWlXdDZIL1l4YkRtTVVnNnZ2cVlPdEtQRU5BbUxqN09Tb3RVencrTEtZOWww?=
 =?utf-8?B?MTE5Q3MzRkU4WkRTcFN0YUpVSVR1UEcyQzVGSDNKRzV3NTNZL2xia0JaQUp5?=
 =?utf-8?B?UzExRHJDNWV1d0ltaGlmV3hXTWpjay94enhnNVZueGh5dERhY0tYSzJPdit4?=
 =?utf-8?B?OGhZK3JXR3JJd1FvVHd2anJScGgxTVhyUVV4R1pRZGwyNUN6dWRGQ0pjWjNJ?=
 =?utf-8?B?d2xCZnRvUzdOTUdkaloxTE51c0dUVjgreU0yemtDQTNEY0Rtb0VkKzg2dmts?=
 =?utf-8?B?a3FWSHk5OTU4VlpwRnlMYWRwREtoZTZZYk5kTFlkV1JINmdIMjE3NXNPRVNK?=
 =?utf-8?B?NHYwNWF3REUrd1dlWkxCLzJRZnNHMTNVZDJmWHc1V3R1VnN0WDRkZkRHVGp2?=
 =?utf-8?B?ck5vQUZPb0tDOGc5bXVWd2tiY0ZHN1A0c0ZyUDd5YUdNQXNpa2dvaDk3cTZu?=
 =?utf-8?B?VGI2Q04yMWFZUThwQ2UzWjcwZjFNUVJ3NmV6ZEs2QnpQeHFlL1Q5Rlo4akIv?=
 =?utf-8?B?R0xhRGNodDZnQ2hCVkJoU3pld3pDc3ZDbDAvNENDdWxRQ2p1cWFiWmRCQjBM?=
 =?utf-8?B?M09QUk1FTy8wcUIrcExzYUU3SFlOU0lkZTJjT0ZSdXg4bVVUTzNNR0h3c1o0?=
 =?utf-8?B?MHU3MlZGNmMwN29BVTQxdWFsOUZiK0hxeXJSbVQvTGNlWEJWcDZ6OWVmWE1S?=
 =?utf-8?B?WXdhMDBlSldLUVJLeUQ2Rmk0WjNNanNqQjdjUDAwQXlLL1JVd085eThGdVBZ?=
 =?utf-8?B?M3QzNnQwWjVrdTd3UDV1STV2QzNkdStrVU9LbWRUU2Y3OFVsYmtaNWhxN3Q0?=
 =?utf-8?B?cWZxV3d6Nno3cmRXRkZ3dDVrcFJqaktPQWlFcDAyMDAvL2lGTXpac3NQajVM?=
 =?utf-8?B?NUZyb0FXT3pEeUFJdzlCY2RmL09MNy9xV2Z5Rm5SQ2oxdGQ0c05iRlVIQUtP?=
 =?utf-8?B?Kzh4YWFDZFpURDVUS0Y2TjhwcXJqenFxZ09mTTBhYWxSWkVUdlZkbnZIVm93?=
 =?utf-8?B?aVJJM08rUmp1WE1aR1I5V1VNRnIxN3BqT3M0UnNyYjY3Umg0TUtMWml1NW05?=
 =?utf-8?B?VVYyRTJYVUZudytJV0M3dFdWd0xLa0xFaDJKdks0anFkYXl3bXpvMlRyL0pq?=
 =?utf-8?B?U2RjSWt6UkUwSGNmbkp1dTNicXFCUEM4aVlhUlpONFpqdkxLSElpZUZhd3VD?=
 =?utf-8?B?S0F0S1N5RlF1SFA0MXRka0Q1THo3dnd6RVpUK0JRVDA2Uk9nekdhcThwVHU4?=
 =?utf-8?B?bWlEQ2JVT2VQbVpkR2JDT0twalRiNDJld0RWemQ3SEViWEZ6OERhQkcrN2Vj?=
 =?utf-8?B?NmJodzMzSStVZmQ1aFFJM245TFc1eVpobnpMSkpXOTI5cE4xemlnZWY3U2FF?=
 =?utf-8?B?Z0xDQ241VjdyTHdnTGVFQlJDOHVQM1JEOWFaMXh0Kzd1d1FUbFF4bFAxd3J4?=
 =?utf-8?B?V29sMEJNeVhsVldSZ1pmdjRVbDR4R3djSFJMOUhtbXk1VEtZa2VQMG4rWm9M?=
 =?utf-8?B?R2FUd0RGWkVUU2pzZ3pud0YyVUgwZkJreW1MRGVZV2pSalJWZU5wM3RsMlFZ?=
 =?utf-8?B?aGZCWlFMeUpyQ3pEejk2b0NtcjllOWJyQWcxWVRHeGNjMzhxczJKV2JEam9u?=
 =?utf-8?Q?kO87ApxUfCzEGtvqvKlwSAAMX?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f14b2a4-45eb-45ae-b3fe-08db9def2582
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5040.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2023 00:24:25.8506
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dN8Y6Xn0IB8MZKI/jl2XBG++pT3JG8Pt9aldseJDtbEhnrV2sPdi6iyBUJ4sTy7Ybe/QtygFM9CpFiARNVat+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8088
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 12/07/2023 19:14, Aurelien Aptel wrote:
> From: Ben Ben-Ishay <benishay@nvidia.com>
> 
> When using direct data placement (DDP) the NIC could write the payload
> directly into the destination buffer and constructs SKBs such that
> they point to this data. To skip copies when SKB data already resides
> in the destination buffer we check if (src == dst), and skip the copy
> when it's true.
> 
> Signed-off-by: Ben Ben-Ishay <benishay@nvidia.com>
> Signed-off-by: Boris Pismenny <borisp@nvidia.com>
> Signed-off-by: Or Gerlitz <ogerlitz@nvidia.com>
> Signed-off-by: Yoray Zack <yorayz@nvidia.com>
> Signed-off-by: Shai Malin <smalin@nvidia.com>
> Signed-off-by: Aurelien Aptel <aaptel@nvidia.com>
> Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
> ---
>   lib/iov_iter.c | 8 +++++++-
>   1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/lib/iov_iter.c b/lib/iov_iter.c
> index b667b1e2f688..1c9b10e1e1c8 100644
> --- a/lib/iov_iter.c
> +++ b/lib/iov_iter.c
> @@ -313,9 +313,15 @@ size_t _copy_to_iter(const void *addr, size_t bytes, struct iov_iter *i)
>   		return 0;
>   	if (user_backed_iter(i))
>   		might_fault();
> +	/*
> +	 * When using direct data placement (DDP) the hardware writes
> +	 * data directly to the destination buffer, and constructs
> +	 * IOVs such that they point to this data.
> +	 * Thus, when the src == dst we skip the memcpy.
> +	 */
>   	iterate_and_advance(i, bytes, base, len, off,
>   		copyout(base, addr + off, len),
> -		memcpy(base, addr + off, len)
> +		(base != addr + off) && memcpy(base, addr + off, len)
>   	)
>   
>   	return bytes;

Looks good,

Reviewed-by: Max Gurtovoy <mgurtovoy@nvidia.com>

