Return-Path: <netdev+bounces-31047-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 621DB78B11D
	for <lists+netdev@lfdr.de>; Mon, 28 Aug 2023 14:55:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 125A1280E01
	for <lists+netdev@lfdr.de>; Mon, 28 Aug 2023 12:55:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B442E125BB;
	Mon, 28 Aug 2023 12:55:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0574125B3
	for <netdev@vger.kernel.org>; Mon, 28 Aug 2023 12:55:13 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2087.outbound.protection.outlook.com [40.107.223.87])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F0ED107
	for <netdev@vger.kernel.org>; Mon, 28 Aug 2023 05:55:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fz2eUILWjqNgtHcuW1Mr4rGOR8Wnaiuy3pZaz801iDCAx9fUnO4B7AN3k3taeIDRRehMv1RUTmhYp6wN0YXgSWrJxt/OQLvb55xhIqqkHsfVS8qMGSLS+/Bm9IwG8WPNCajC8VuFO0rOE6ByW2Rra/TATqxtcKleqbNsJGxbLC9k1YWiXLaGLfQryNzNvhknEYbQA54Wps/OBB6x9PXzxu1FjnnY0tQP1fd3P84LCInpL0uDbQkevlRBxSTjadfte4ToYgkL1+30QDoAZNk6v9LG13pzCjQ1c4KSxsGGDYEzUq6IkJo8o3PaevTRtS+8IA1xAUnn6szr16ggQu4Z5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5i0qKdA+twPxA5wYzhMHG1jWWnlub5MBFKtkL8GYCto=;
 b=EFDLDWxG/mpaXnHAR1+8pzqtkN4kRN+8RU7GiUG0lyfkhEYalF07UeqHmshylcsiWjOFP0QaHIKxs+TYXrMMcuB1EzH7Y2JaTMwi4/423/UWoLhZc97UwfUbUy9pHahEnvelWHasWCliI4V6CmY00/pRU27mQqJnMNoEya8AaNvyyyVm+zo5+mGelqqFrk7uF75JSSkfH5b1Ggi+KZMTG1Dc1xQhGNObra3lhE3OJy3cWiLbwwh+72fcyjBrIIvzxTqhiosi+9Zmg4BiQJhRx4NzvoOHq+zOWVULKc0OqDLGlaHWxclYO/5BYQMeaPTb1ogXPTXcv2LuFovCY2SkuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5i0qKdA+twPxA5wYzhMHG1jWWnlub5MBFKtkL8GYCto=;
 b=tXjvFap3eGnYRipaki5AX0gofen2wSfFwADxqs9yprrrnLD8UhN7pImn4SnOwRlEpE5+WKATsC7FK0w7SdQFw+GeHFTV5Qss0qlNbTb4clQGTqMlNMK567lGCjRS75Q+mD64IpEHZcgBXC3SF9O8O16IUznwcd49faeWygb3GUL25q3+dGkkJrX6m6N6yQikelogkZIgdwYnrlQ6WHw5F9H18GE+Br1OSebmWRH7xNmb2KTXZP99b1/ZiW9o0G+Aeu5Fo8Mc9+fXW6SjeI2D61Umt/ugFEkdC/za3ozfsETU8iGArGlLhwwMZ1I8BMRUpwsIDyZaQeVaWFA7jpMhCw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB6288.namprd12.prod.outlook.com (2603:10b6:8:93::7) by
 SN7PR12MB7451.namprd12.prod.outlook.com (2603:10b6:806:29b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.26; Mon, 28 Aug
 2023 12:55:10 +0000
Received: from DS7PR12MB6288.namprd12.prod.outlook.com
 ([fe80::2666:236b:2886:d78b]) by DS7PR12MB6288.namprd12.prod.outlook.com
 ([fe80::2666:236b:2886:d78b%7]) with mapi id 15.20.6699.034; Mon, 28 Aug 2023
 12:55:10 +0000
Message-ID: <6b6a21e4-8ade-9da3-2219-1ca2faa24b51@nvidia.com>
Date: Mon, 28 Aug 2023 15:55:02 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH net-next 1/2] net: Fix skb consume leak in
 sch_handle_egress
From: Gal Pressman <gal@nvidia.com>
To: Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org
Cc: davem@davemloft.net, pabeni@redhat.com, kuba@kernel.org,
 martin.lau@linux.dev
References: <20230825134946.31083-1-daniel@iogearbox.net>
 <14c3f6ad-b264-b6f8-19a0-5bc8ad83f13f@nvidia.com>
Content-Language: en-US
In-Reply-To: <14c3f6ad-b264-b6f8-19a0-5bc8ad83f13f@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR08CA0235.eurprd08.prod.outlook.com
 (2603:10a6:802:15::44) To DS7PR12MB6288.namprd12.prod.outlook.com
 (2603:10b6:8:93::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6288:EE_|SN7PR12MB7451:EE_
X-MS-Office365-Filtering-Correlation-Id: b698df18-56a4-4c26-28fc-08dba7c60309
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	jDSjrrVdwvlHU11GbLjsXVXavKvVceBHy9Nj6/zk7KW0pIbqd3w4gYQkQ4emQM2lVKP0vkrjycVbk46M+LoWVqpHoAtQk2cubTwuSJTcPCJSvref0y8Qx5np4fPjyI+ppw2xi1DIIgFj2twtpOiUaocO8O8u9N0y1jqohGQLC2B+Mo0dBgVIp0pIruwCv7bLyxFOt/4pZEWI2p4Oaq+PwbRMGuOYJYQdODDS/eAdf96Cn46Q+aPsc1E3YOY9hO5y/ggJsZ9JAQBc2vpehcQFUBYOAXBgV/pkpuGLkHTsmufOhNi1aCDI4KbNsagjwHK+FX55FahqezZ9/AvwskgoVyNd374vtus3Y0SOF0m0wAmvVOiQcosod/Se7yvJkca0skoW8RkXWQjS2yqfc5C2F4QJdmB8T8xAPPNj3NdyTIPE7lYpRt7flEBgRrsEykKMcuH8TbO47Oxsva/yiyDQ/nLiM5wPHeSOxVou7YV8QF0+DL75RrhX+LuS4PzddHdVdgppnw4GRhqqfB85dOAZuZOTdDt3D5pmZ4U0KVNk9FtVON/tJkelCzk3UV9/+80dGpI3hL3BVIDkLduG/iaHP/DsrYs5QxONgb84UcYNSQ0dEf6lopMU5HUmlUS8EcN5TsK3vBbXwwIv4n2JYRiTOBIOdUP9DiTY9v525FqJEWdUK+qdCx+4q9RAA4NxO7YkGUMXVtq9/BIeg6NpFQEa7HiVzNWjV2mrsiWjJL2nNgU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6288.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(376002)(39860400002)(136003)(346002)(1800799009)(186009)(451199024)(2616005)(6486002)(53546011)(6506007)(316002)(8676002)(8936002)(4326008)(66556008)(66476007)(66946007)(6512007)(41300700001)(966005)(5660300002)(26005)(6666004)(478600001)(31686004)(83380400001)(2906002)(86362001)(31696002)(36756003)(38100700002)(45980500001)(43740500002)(505234007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WDhpVXE3VGJ3S3RzMEJpcnBrS00xOWhaY1RVUDJ5b1JDamJOdDROTzNSVVpi?=
 =?utf-8?B?eGRaOGNKUmZ5Uyt6MUZ0TXBNelZJTkRpeC82YlFiY216VHBEQ1lwSGVWbmRC?=
 =?utf-8?B?MDZCWENxWUxXaDUwZmZrdkx4RmtPMVY0ZnJvYW12RFB4QkE3b3lFMmQ1K210?=
 =?utf-8?B?Tmg5YjJlZTRRRzdNOWN2bytnTGpMNGZiZkFxK1RaUy9nL3crakVCb3JQQXpD?=
 =?utf-8?B?anVwbFk5ekFYSG1BWVhWSkZTT0I2dk85V3VtaVJieTN1L2VNZXRsN2VVb2ox?=
 =?utf-8?B?M21vYldMVEgvUUorM0FSc0NCTzhqNjVGOHdwOTNqcUJNR0JZcllZVkRzenV3?=
 =?utf-8?B?Vmg2djBoSWFSY2lkb2pNR2lEaWFTUUlQa0lLVzZoeXUxRnVqcnlpbnBRYkFl?=
 =?utf-8?B?M0JyQWdzajRRTENWTWFKODZuckR6cHI0c1ArSEd1NUMzSEhkQlYvcXcyUmxP?=
 =?utf-8?B?MFdISHRpanY5WGp1dXhiaCtVWUQ5cGlOTE0vVUxBVlR5T09KNDVJdmVCUlJW?=
 =?utf-8?B?SUpta3lYOVBYS296ekF1WWRCRWRWdVNteGdHWUNzb3ZGVkR6Ym5KdDZRNW9D?=
 =?utf-8?B?YXdkQzgzRjhTODN5Mlc4dGp4dDAyUFE3SkhKaVFSK3RJZGtGVlBnSkhZZTlj?=
 =?utf-8?B?a3VIN3g0aS9KcTc0Nk53S21CS0xCZDJwRmxCa3g0eGlLTzR2dEFGdzNMNWlk?=
 =?utf-8?B?bDdUeHRFckVUbFFMamUrN0luQm9SU1lhMVlxM2dDZkd3b2g2cWNCcC9FdFcy?=
 =?utf-8?B?Zk5iMUV5Ly9hYWRFTzBzMzFYSEppbmR2UVVOWVVITHJhRFpRcWt6cThiQmhC?=
 =?utf-8?B?K3BDVDZJKzU3bE5IMkcvSVUvb1Y3SmpOL0FkOHY5a2s5Z1ZlY0pEMlZVZnJI?=
 =?utf-8?B?dDE5c0U0U3IwcEkxSVZvRnFidWZQYW1uWDFBS0RQZ0xOWjBmeXQ1eFFKNHZy?=
 =?utf-8?B?SlJPS0JrbThibkNJd0YzNUFjc1ZzODZhOWozTkJsUmYzV3dKUEY3QXJNMVdF?=
 =?utf-8?B?MklDci82YlpMYWZkeDM2M1JFNnlEcFp2bTRaLzZRR2hiTVBEUGVybllJb2wr?=
 =?utf-8?B?MGg2TzNyc1V5ekpPNUJMbGF4Z1BiMkYySERzd0VoOWhuM2pPMTVsRUVzS1Bs?=
 =?utf-8?B?YUxxcktPbU15Z3AvM0NIOW4vMDVaSFc4N0YrTW56M3orTXpUZnVUMU9ySVcr?=
 =?utf-8?B?OExVQ2ZLNnhLdEN0U0lpbWREbFdwUHlrdzAyUXpuN3Jqc282bWNEOTZvWERV?=
 =?utf-8?B?dHVzSTkzdkN3Y2l3dWhsOEtoSVJncGl2UU9VR0RaclB0blRLbmRBT3FxU3Vx?=
 =?utf-8?B?dFhyMWY1L3BWL1ZaTkI1ZW5Ubnk1OFl4Q09FaHJ5dkFSeGtUZks1VHNWY3lo?=
 =?utf-8?B?Q1MxN2tWT1hSQW92N1U4NDR0RmxOOTVvS01tRENBSTUzc1dsVnEySjdLdUNZ?=
 =?utf-8?B?d1hlY3hURk01MUZoZzBPL2JIYTZDRXVxRlNjb0hhdGwzeWxZS0FLaENzdGhM?=
 =?utf-8?B?Zm9oNXhlTEYwa3E2STNNT0srWnN4Q2xQQW5DMHBTaVBmamI3bGoxRjMva0Ex?=
 =?utf-8?B?UFVGMzB3K2ZWRkZjdU8vTDZTNVRXWlZPZGlIUXdNblNlTUpuWUNxMWljbENP?=
 =?utf-8?B?RTBWbk5lOUpFc2x5M2hWcU9WdjQ3MzZHQ0pIME1LT3ZrVGxpazlNcU4xQ3pV?=
 =?utf-8?B?SldXclBqV2dTamlyZnk4SjF6UVFidmJWeFRUc2ZIMlNEK3NyckZhdWdBQkd2?=
 =?utf-8?B?UGRkUi9QVXV6MVRFejdXY1RJODRlNWtiTE9xL2JCOUcyTHljeFJCM3Rad3cx?=
 =?utf-8?B?bHF3THhhb09zK2tzb3g0WlZHaGJBVngzbHNRNUlrenN5THVXZXRXVkZ0Qnhp?=
 =?utf-8?B?aFRBTndFazhabUcwMlg2YXUydVQrRDJLVnBOb2JVdlNwbVBrUmFoRldKWW5F?=
 =?utf-8?B?YVlZVlQ4bEk4SS91WEdFOFNwc0RUYkFWS1JyVXVXT2FxZ0ZWV1JPQXIvMkJL?=
 =?utf-8?B?a0pNaGVnOWVRQUQ1QVlEakRZWEhFaWxLdnFaOTNkcDdzL21DOUV6QjNabTJG?=
 =?utf-8?B?VEQwM0ZoMHJXNU1XckRRWDZBQk5kcnl4RDdnTmFEcXRNak4reURPQmg3SFp6?=
 =?utf-8?Q?fxex3vD9/jaIvXclnGTfEuISI?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b698df18-56a4-4c26-28fc-08dba7c60309
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6288.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2023 12:55:10.2193
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QMGxLJ0wJpeZCIqcxdaVqX1dPzo9JsNSeJY5TDjIoyDQlInpA1he+xNwuCaNn4H+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7451
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
	SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 27/08/2023 16:55, Gal Pressman wrote:
> On 25/08/2023 16:49, Daniel Borkmann wrote:
>> Fix a memory leak for the tc egress path with TC_ACT_{STOLEN,QUEUED,TRAP}:
>>
>>   [...]
>>   unreferenced object 0xffff88818bcb4f00 (size 232):
>>   comm "softirq", pid 0, jiffies 4299085078 (age 134.028s)
>>   hex dump (first 32 bytes):
>>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>>     00 80 70 61 81 88 ff ff 00 41 31 14 81 88 ff ff  ..pa.....A1.....
>>   backtrace:
>>     [<ffffffff9991b938>] kmem_cache_alloc_node+0x268/0x400
>>     [<ffffffff9b3d9231>] __alloc_skb+0x211/0x2c0
>>     [<ffffffff9b3f0c7e>] alloc_skb_with_frags+0xbe/0x6b0
>>     [<ffffffff9b3bf9a9>] sock_alloc_send_pskb+0x6a9/0x870
>>     [<ffffffff9b6b3f00>] __ip_append_data+0x14d0/0x3bf0
>>     [<ffffffff9b6ba24e>] ip_append_data+0xee/0x190
>>     [<ffffffff9b7e1496>] icmp_push_reply+0xa6/0x470
>>     [<ffffffff9b7e4030>] icmp_reply+0x900/0xa00
>>     [<ffffffff9b7e42e3>] icmp_echo.part.0+0x1a3/0x230
>>     [<ffffffff9b7e444d>] icmp_echo+0xcd/0x190
>>     [<ffffffff9b7e9566>] icmp_rcv+0x806/0xe10
>>     [<ffffffff9b699bd1>] ip_protocol_deliver_rcu+0x351/0x3d0
>>     [<ffffffff9b699f14>] ip_local_deliver_finish+0x2b4/0x450
>>     [<ffffffff9b69a234>] ip_local_deliver+0x174/0x1f0
>>     [<ffffffff9b69a4b2>] ip_sublist_rcv_finish+0x1f2/0x420
>>     [<ffffffff9b69ab56>] ip_sublist_rcv+0x466/0x920
>>   [...]
>>
>> I was able to reproduce this via:
>>
>>   ip link add dev dummy0 type dummy
>>   ip link set dev dummy0 up
>>   tc qdisc add dev eth0 clsact
>>   tc filter add dev eth0 egress protocol ip prio 1 u32 match ip protocol 1 0xff action mirred egress redirect dev dummy0
>>   ping 1.1.1.1
>>   <stolen>
>>
>> After the fix, there are no kmemleak reports with the reproducer. This is
>> in line with what is also done on the ingress side, and from debugging the
>> skb_unref(skb) on dummy xmit and sch_handle_egress() side, it is visible
>> that these are two different skbs with both skb_unref(skb) as true. The two
>> seen skbs are due to mirred doing a skb_clone() internally as use_reinsert
>> is false in tcf_mirred_act() for egress. This was initially reported by Gal.
>>
>> Fixes: e420bed02507 ("bpf: Add fd-based tcx multi-prog infra with link support")
>> Reported-by: Gal Pressman <gal@nvidia.com>
>> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
>> Link: https://lore.kernel.org/bpf/bdfc2640-8f65-5b56-4472-db8e2b161aab@nvidia.com
> 
> I suspect that this series causes our regression to timeout due to some
> stuck tests :\.
> I'm not 100% sure yet though, verifying..

Seems like everything is passing now, hope it was a false alarm, will
report back if anything breaks.

