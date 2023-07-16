Return-Path: <netdev+bounces-18096-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A310A754D87
	for <lists+netdev@lfdr.de>; Sun, 16 Jul 2023 08:53:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ACC532815B5
	for <lists+netdev@lfdr.de>; Sun, 16 Jul 2023 06:53:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FB931FCA;
	Sun, 16 Jul 2023 06:53:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81905EA4
	for <netdev@vger.kernel.org>; Sun, 16 Jul 2023 06:53:49 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 263C5189
	for <netdev@vger.kernel.org>; Sat, 15 Jul 2023 23:53:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MSi2tnfbTTcHAzgTJIAYpwMZEgAHeojXDiWHE6OVtr/byPD/Y4tewKX8olv5lMFjUTIr3RhWj5i/RduUjP1PPvyE3GSUi58o3Rsox7NXsgGE1xw2cyjGF0M9CwmKCJ3Y7L3GGkwzuy9HXCYS8LMI0am2dpoE3cMkTrsLFSQj4+x12CM7NURfIBgDwVIC+1udRs/D5cS9W3JMwzyA94HrKacCdlsMvYPHgELKrn2sA9WFOBY0I3dT7tVHBEe1tBTZKQkEIwA9CmpCpJDdNT5amK7xX0QP6DOQc8VeiX4cR5hG1xVPKoSjBpDjEOk0/ixf4zWcXImT+KVjDYvRl6xtfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hdqV0TB6U0pD3Ft1yVamE691ITcuw8HWfY1Ylz02SC4=;
 b=K3laFwg6/zUfA7jjkcS41j2n5MLN/RJx668NdSpBfZOVHl+Q8bNqNTq2Z39uDOzlL2GMIakMU7tCSSkk33e9cfY2ze6o5gbWkDboyTLDNAILsRPKBBTe8RVeQUcOvCRv7IPpOsxOLiksKR5K2yyq1K67873ifKHngLAnDBMqgjONtSrfaSwBTW57JCnQFWJGue/RYAEBHh6t1oFc8UfC9I0D9Z2VyM8kpxaJZpsHAQvwgeYrlqARhAqAo9T8RubEbaLbCCawoOnzJrRRk0upXxs8DJihdXwG2oKOuB5ICS1aC3xqDQC3MP0G8Z19Ivv7ZjpF5gER6xhE2VsX1Ww0kQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hdqV0TB6U0pD3Ft1yVamE691ITcuw8HWfY1Ylz02SC4=;
 b=o07M5TYxGBytQUcpViYm5bABgNYHpa3rzSPdgOZEA4j4st8z96Wo3gb4mYLuITP2odxS5DylzeyJrqqGXQy28b0f4w82NoLEROQFdXL4Tmmnu1QDOrvHCZRu//W+wPD/X083I4qECOq5fnLmVXtlid/ewZCFN07NF9Jo/mvetTQ96WmVtRTfpR2csnqDPX/bCQctt7LjjySPema6XE7G4D/mxQJCU7t+LztzOSDBuy4aloq8KkYLWt3lP4xWpc4iAn3ZkjsyJ7LqRCDQwrALFmd1rC35Q+eA5SpGbiGqVaaJ1vL0rFlsItPZGuNvLj5MWgyuGe11PFx24SoTyBJJ3Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB6288.namprd12.prod.outlook.com (2603:10b6:8:93::7) by
 PH8PR12MB7208.namprd12.prod.outlook.com (2603:10b6:510:224::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6588.28; Sun, 16 Jul 2023 06:53:46 +0000
Received: from DS7PR12MB6288.namprd12.prod.outlook.com
 ([fe80::55cf:c134:4296:5ec1]) by DS7PR12MB6288.namprd12.prod.outlook.com
 ([fe80::55cf:c134:4296:5ec1%4]) with mapi id 15.20.6588.031; Sun, 16 Jul 2023
 06:53:45 +0000
Message-ID: <5e18f58d-fe50-73a9-3c64-d67e36b78257@nvidia.com>
Date: Sun, 16 Jul 2023 09:53:36 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH net-next] rtnetlink: Move nesting cancellation rollback to
 proper function
To: Simon Horman <simon.horman@corigine.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski
 <kuba@kernel.org>, netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
 Eric Dumazet <edumazet@google.com>
References: <20230713141652.2288309-1-gal@nvidia.com>
 <ZLJwu6obpQ01ellQ@corigine.com>
Content-Language: en-US
From: Gal Pressman <gal@nvidia.com>
In-Reply-To: <ZLJwu6obpQ01ellQ@corigine.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FRYP281CA0005.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::15)
 To DS7PR12MB6288.namprd12.prod.outlook.com (2603:10b6:8:93::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6288:EE_|PH8PR12MB7208:EE_
X-MS-Office365-Filtering-Correlation-Id: 60731143-5810-4f36-f8f7-08db85c965b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	KMpbil+b8ibfIjwmdqe5gdiU5v94BuPXh2uPGYSmaNZPjj9xuqDbdl5/85Gaz6zSwS2cdyqH9/EycGRlOGU0NMUGPUtzkCnYr0qHO9sWkbZt9qXu4zD3WOJDIkTEA8TEzPBD54RHEKQiVAsB0ohdFQAbuAbfH+/dt2irqzbB+1HNkWsGxfpxmtl7wc7Kdvqvejg95rntD8rky+KbDuo9m5YabhS2vG/tr/3Gynr9WzHBIQ6xEScoV58Tk8xeeT6CeJH/MENhxkiz9MZ/LwyLzr+UPWDDQHLl+RlUIhwCbP4lvYdWUQR/tWnFdjqpbhxxDpBvPlr/iTY/V6BEfZfINeBnshOgDzjPi4B3TaNsnp5mcuzid9YnFpmfTFopYRF1YK8gsaDxbahekxBadNulDk6YQSUEAxugkjvinS2SevlJcLeZA23D055UCZrYi3VhspIJqs7Yc3iA8Fi7uL5tDszzBHi4U+Nba4RaIHcDIlIlA5Le6fUBVAvQrzxQ9hE9ECj+k1oJZ4LiTjJsUxA+8evdvmbyAE0tzsTdLb6BOjKdSnIMIMLNjbRdYKjOzqA5zsB8lvJ/vVDbder+vVF/HpvVRyKI2FFZg9VteN2/qyYsO0sujYHjq0PMWplfcfWB2ggdU+aP2/s26fYCSkpaMw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6288.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(346002)(376002)(136003)(396003)(39860400002)(451199021)(31686004)(53546011)(26005)(6506007)(38100700002)(31696002)(54906003)(478600001)(5660300002)(8676002)(8936002)(66946007)(66476007)(4326008)(66556008)(6916009)(6486002)(6512007)(6666004)(86362001)(316002)(41300700001)(2616005)(186003)(36756003)(2906002)(83380400001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YkpSc2Y1Q2EybWVOeU5aZllEazVPS2d6V2lEdVFFc1VVcTFzQ3IyKzNCMk5I?=
 =?utf-8?B?VmpaZThvbFgvZjBCSFFnM1FrSmFEN3lZMXhXL0swL2pmZHJMbUFiT2RUZjhZ?=
 =?utf-8?B?ZzFVaWYyc0VldndyTzRkZDBjQ09uNSs2eENFZGhaNXJNNFJkcTVHTS9uemlD?=
 =?utf-8?B?cjViUmtPMGlOaG84WXdqbUd6bDMzNjg3MU9SN05FK0E4dlFLdXlYWXl1RVBE?=
 =?utf-8?B?SWVMWUhBVkRGRHpnZzFPeTUvWTNKTitKWHdlT00xTG8wZGlKLzA3OTdpZFdR?=
 =?utf-8?B?VEVneDRuY0p5Q25kaEtOWUNTcDJKdktRaWZnbXRpSWpGRlFDZmRKUGpNVjZ1?=
 =?utf-8?B?OU1TeXl0QmpaTUlpTm5FRjE1K214cHE5K0RCQmdUYndjamVYZDg0dkw1K01X?=
 =?utf-8?B?QlA1Sk1qbEdFcGZXSEhjczNzb1ZwSGRjbmowWXR6NDVqeDVCZVpuajg2cVVw?=
 =?utf-8?B?VWtXQVQzdnJjbGJVVVh6elhBYU5OaDRiNUJObWNud3FJRFNmNDJrM2MvMEdS?=
 =?utf-8?B?M3oxVGNkM2J6RVVuelVwVFVEeWUveklxRGM5SWVBbkxEQ1FnOWVTc3ZXdWRQ?=
 =?utf-8?B?SUdSdiszTDhQVFhERGpzMmN5OG9aUExRK1MvSllPOVBHQWlQRXZBQml1cHBp?=
 =?utf-8?B?YnJYalZTR1d5NHRobmFvNFRjNXpZNWVITmFxdGVnZWxRRjkzSlZqaGo0VjY0?=
 =?utf-8?B?dnJreWRkait4bUhWS25MWGF5eTR1M2pEMFVRMlhHOU4vbGptOVRORC9uKzdo?=
 =?utf-8?B?VTY4NGJCbXY4N0libzk3M0RRSFhNcUFLYVdjdUVWblEyOG5sbEZYVTVWRUdp?=
 =?utf-8?B?UWQvaGt6THJnL1FrcTNRSjF0Y3Rkak94N3hsVVBxZVQ3ZG1CSFNtdlYyWEI5?=
 =?utf-8?B?K29yd2hRQUpZQXBEWlZudGlCSXNza0VHdHhvcHdSaFY0OTUycEdHb1NNUy96?=
 =?utf-8?B?WHY4bFN2Y3U1MSsxTzZGaWU4b09LWEtsdWFyNmJHUE1QR3RyRUljYTZkcm1k?=
 =?utf-8?B?NWR6bmtTaS9mSFB1UXJ5clJmSytUSzg5a3Q2NmFlMlFvTE9VWW8wT3pDeStj?=
 =?utf-8?B?Wm1pTHNVQ0pFT3lhdTBCYkx1RWNIZGhoTjdqNUxaYnBKSmRIUi8xVldEc3k4?=
 =?utf-8?B?cndqaXVXRVI2UEJ1V2xvNEdQZ3RjNXREQmgxcFZERSsvOVVCQXJiRXNRdnRK?=
 =?utf-8?B?NkJ2M3puT1ZXbDJ1c2wzRS95WTZ4V2lrQnF6aGxNT0pYOGJBRTFOdGNFUlJq?=
 =?utf-8?B?ZjV0ckdtMGs2dllWQ2Vxc1RsUWxQRDFmWXFuR1Y5OFVGMFV3c1VMUEsyWUhK?=
 =?utf-8?B?TlM5SE5SUysvN3doSDhLVEd4bkdVeGpVaFExSkVDVXZLbDZET0lScUQrYVRV?=
 =?utf-8?B?ZGMraUJSWHUvaVB5eUZNYUZFSEtvOEtXWXFveUtlRy9SYXRRSUx1bWZyWHZi?=
 =?utf-8?B?KzJXaDdoYzdhUGQ2QTE0UEtqLzBFOVBHcTl5NGwxelc1bTRJbVdZS3JEaytI?=
 =?utf-8?B?OVU2cFczOXU5NDA4eXd4Wmk2UjltbTM3UFNNTjdKRXZ5NXdTTDhKRXFTN3pQ?=
 =?utf-8?B?YmkwMndqNmRtcG1Ic0lNYndtQ3dCMUpyNTA0eHFmVkEvZ0FOajFvdTVxT3RQ?=
 =?utf-8?B?ZFgydi8rcDUyZHlaQkFZczBXU0ZPZHVkV1F6Y0hBQzVXOFhWWkRsUHRwRnli?=
 =?utf-8?B?ODZDTUFLd1BUbTVvNG1vRW96ODRXeXlzdWZmWEo5QjRVM0hlNGFPMi9Ya1Vi?=
 =?utf-8?B?R3NOZ0ZoTkNDRkp1Rk9ySnRxU2o4WkNnVGlzNGIvWHQrUWxheFVvUHJVL2dN?=
 =?utf-8?B?dUFZR2F0TkVwSVUrOGlvLzN1SHFWb0R4TkhZVVdEbktEKzlYbHRGdDdqU1Vl?=
 =?utf-8?B?ZzhFM1pjUkFyWm5xWkpVT2NmcDJyRzYxSTRGUU96Sks2cy9tZWN3bDlUNnpK?=
 =?utf-8?B?WjRjRmd6dy9FQnc2dFdwOElHRXNFeVVPNVhXa0xlS3hRUTFmbFdjMldLd0Vj?=
 =?utf-8?B?b0I1SHZDc041cHgwcFBvT3FFYUhkWVBVN1Uxd0swVWF3cWM5cUx3YVZ3OUlB?=
 =?utf-8?B?SWU2Z2pwQXFnM0p1ak5JT0FwQVhUOUl1djVER29wVFc0Qm9mdW9vMjMySGUx?=
 =?utf-8?Q?A1NjSScmGXguPPe0u/KT9cQrh?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60731143-5810-4f36-f8f7-08db85c965b1
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6288.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2023 06:53:44.6782
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UqSCG/1zcRvmE8oy4wpQLYGOUW4UWj8vW1HokYB1tqEXmOqGZTLH6/FiuGDaVxmq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7208
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
	SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 15/07/2023 13:11, Simon Horman wrote:
> On Thu, Jul 13, 2023 at 05:16:52PM +0300, Gal Pressman wrote:
>> Make rtnl_fill_vf() cancel the vfinfo attribute on error instead of the
>> inner rtnl_fill_vfinfo(), as it is the function that starts it.
>>
>> Signed-off-by: Gal Pressman <gal@nvidia.com>
>> ---
>>  net/core/rtnetlink.c | 8 ++++----
>>  1 file changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
>> index 3ad4e030846d..ed9b41ab9afc 100644
>> --- a/net/core/rtnetlink.c
>> +++ b/net/core/rtnetlink.c
>> @@ -1343,7 +1343,7 @@ static noinline_for_stack int rtnl_fill_vfinfo(struct sk_buff *skb,
>>  	vf_trust.setting = ivi.trusted;
>>  	vf = nla_nest_start_noflag(skb, IFLA_VF_INFO);
>>  	if (!vf)
>> -		goto nla_put_vfinfo_failure;
>> +		return -EMSGSIZE;
>>  	if (nla_put(skb, IFLA_VF_MAC, sizeof(vf_mac), &vf_mac) ||
>>  	    nla_put(skb, IFLA_VF_BROADCAST, sizeof(vf_broadcast), &vf_broadcast) ||
>>  	    nla_put(skb, IFLA_VF_VLAN, sizeof(vf_vlan), &vf_vlan) ||
>> @@ -1414,8 +1414,6 @@ static noinline_for_stack int rtnl_fill_vfinfo(struct sk_buff *skb,
>>  
>>  nla_put_vf_failure:
>>  	nla_nest_cancel(skb, vf);
>> -nla_put_vfinfo_failure:
>> -	nla_nest_cancel(skb, vfinfo);
> 
> It seems that the vfinfo parameter of rtnl_fill_vfinfo() is now unused.
> Can it be removed?

Good catch, will do, thanks.

