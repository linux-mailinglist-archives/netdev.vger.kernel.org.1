Return-Path: <netdev+bounces-62909-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81B0B829C29
	for <lists+netdev@lfdr.de>; Wed, 10 Jan 2024 15:13:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1662228776E
	for <lists+netdev@lfdr.de>; Wed, 10 Jan 2024 14:13:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85DE04B5D7;
	Wed, 10 Jan 2024 14:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="HaIqZOBF"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2059.outbound.protection.outlook.com [40.107.220.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEA284B5DA
	for <netdev@vger.kernel.org>; Wed, 10 Jan 2024 14:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DZaNrRhrdNtiSGGfRKUDmt+0R1BfWl9e+lPsgW4Syka6cbmstKb3EgiSLZXCbGkxHmicQJ2UkM5nHWwl6aIcV12X/AVIuPnw0bRIEXEe2cvZ+br7CEvaEKo+dV6Y1yeS3DPN2oKS/1leKcWfPJukQEABw6SVLxARUUvABv1WKu58QL0gvRpZpyqk6lOoYbF/k65XpwFvCrcnc2Rj8il7Ca7vZoDjn9x0aG+5R5wL8HU0jlhv0pqKJyLh48FHkraCQ1E+0NG4tVQvEVYr2EVFGtWdJrLJjyAnqXsWcuextYEHRgLC2A2hsn40/h5neN0SMBoddTLo6SMTbPT8brO/Qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XXkKTYm6AqpYbKJcE+6//NAotlcro/DCWV7mUZSSVoI=;
 b=KFKmjfFqRMp5LVCgf8FWdzOFqTC5nPUKCdUHBrcHgDeZaUBiPCp3Voh89Tcr15Ez9wkCCLiLhk9tNa61m0SsIx4qjciS3oKhLqurz7SYFdHILjRgV7+pzZOU+TM2kccJQp+RWCz0CmaTuuqcv9ZoETNDkJPp8rKaVzBYPbC9TC7CyX37ts1/Q//lthI5tMu5UKFFW8/IERS3njnzJuHRU6Gyeh5P0L4QDFu72hCl7ck2kbD+kuCQjgL5cpMy7aDZf6EZoItKeOVjq71bwDKBfENWYFLWT/1EDUkv2aTKonHV+9/H2NSH9fAG2D8jc93hMyqxi03nah14T02sEZHzPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XXkKTYm6AqpYbKJcE+6//NAotlcro/DCWV7mUZSSVoI=;
 b=HaIqZOBFlHmBEy9xLMnkz+1s4jvSaGEVWr6IzNp/IVDGWPEbYNXwAz66ui4mofXrr2V59KonQ2W7cFUXhcgrIgfa1Ls3wcD07okPKhUtRnFQkAf/NqUJ2Wp0xbRGFuk+A+YjiY0vE2z6IIlDzqHgpXgwvr+JJnszwPXP8aHXJjwNMpLDUigkbfeCzusE2T6MmAsJ4Z2UnElC3nu7DpKx4fuQKDWLgkLFUnpIkVvr9so3WcZ2NxpMXD2LDYuMn3dW6FeIQKC99vQwnKS5P/cAj4hbMXCbaV7fD05J+m8H82I9A6atVAIS1SFlGBEq26fpwzvw6LZssjUngAcciUeRSA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB6288.namprd12.prod.outlook.com (2603:10b6:8:93::7) by
 DM6PR12MB4283.namprd12.prod.outlook.com (2603:10b6:5:211::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7159.24; Wed, 10 Jan 2024 14:09:58 +0000
Received: from DS7PR12MB6288.namprd12.prod.outlook.com
 ([fe80::1442:8457:183b:d231]) by DS7PR12MB6288.namprd12.prod.outlook.com
 ([fe80::1442:8457:183b:d231%5]) with mapi id 15.20.7159.020; Wed, 10 Jan 2024
 14:09:58 +0000
Message-ID: <9d29e624-fc02-44cd-9a92-01f813e66eed@nvidia.com>
Date: Wed, 10 Jan 2024 16:09:52 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next 10/15] net/mlx5e: Let channels be SD-aware
To: Jakub Kicinski <kuba@kernel.org>
Cc: Saeed Mahameed <saeed@kernel.org>, "David S. Miller"
 <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>,
 Eric Dumazet <edumazet@google.com>, Saeed Mahameed <saeedm@nvidia.com>,
 netdev@vger.kernel.org, Tariq Toukan <tariqt@nvidia.com>
References: <20231221005721.186607-1-saeed@kernel.org>
 <20231221005721.186607-11-saeed@kernel.org>
 <20240104145041.67475695@kernel.org>
 <effce034-6bc5-4e98-9b21-c80e8d56f705@nvidia.com>
 <20240108190811.3ad5d259@kernel.org>
 <d0ce07a6-2ca7-4604-84a8-550b1c87f602@nvidia.com>
 <20240109080036.65634705@kernel.org>
Content-Language: en-US
From: Gal Pressman <gal@nvidia.com>
In-Reply-To: <20240109080036.65634705@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0073.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:190::6) To DS7PR12MB6288.namprd12.prod.outlook.com
 (2603:10b6:8:93::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6288:EE_|DM6PR12MB4283:EE_
X-MS-Office365-Filtering-Correlation-Id: caafdad0-1fa7-46ea-076a-08dc11e5d3de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	hnecadP8tPGSygq03BleSU1pzUe2TmTRILe0Nij1wfq+d8LosIYkMEilW73nOrAwyAmGDl4RRaOBff0kvmIK+88wSrPh+t8pcMKrHMKdWZPTl/xdlUUpDDnx7mfOyAFjU4DCS4A1JYcW3iFxgvI/50eVTveEQXutF8IzVbN1B5TOHVVCJzVqfEdSIgOtT9jL1Rb694x5TZROA7oe4uQCuuZb084ijpN99ynGIcKBlM/d3FPwpXLArvjNTYAYda+TiFj+Yj5ykvd926e84hcPA+FTjceMxXaKkgH1xezckyDyVygwZU0pJqoxKD+UtOWy6LoF4Ph3mtIW8V1RxE4g2o8sYMgA6Q7qXBAxUk7vGiQrQJITi3cTYs1xXHipttbN/MdCpLlTjTMix6F7KzATEagFlk/lIMsPmuuyuX3FsrUlUAhbEfkI2E1dQW1nED7XEMO9WaU0AgN8vmU2ItRHbf5Qycp5oyBMHH/CGvoR/P8yGVX2EWzfkeaF2oYwY8OcLBFH1wo7rDD9DgaZIcudGE5D3OKtC198RoUlGfiivi7q1AvQ8WasIXjvgDvd/PlID+KFu7tQQw4I7zPetzAm7xlFW+JK4WJ18NTHlE+2EwQzUHLaf7HAHrhSVl4fjQs/bO27L0SzupWWkM6hEaz+Aw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6288.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(376002)(136003)(366004)(39860400002)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(478600001)(5660300002)(6666004)(6486002)(31696002)(107886003)(6512007)(86362001)(6506007)(2616005)(53546011)(8676002)(66556008)(66476007)(316002)(41300700001)(8936002)(66946007)(54906003)(36756003)(6916009)(38100700002)(83380400001)(26005)(4326008)(31686004)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bFZUbnN6eG1GR0s0L3VxVVRvTHJZbE11cWZyOVNXMm5pdzhxWGo2TElDaldR?=
 =?utf-8?B?WVBEWFNXOGZIcUh1akpPOXJyWTFORjVRZUtGNTNHYlRGaEFNUlhsZ0ExY3ls?=
 =?utf-8?B?eThUK1FDM1p2dCtWTklKL2VNT3FZdFUrR0dOdHUzTEk0R202L1VlWmNmTENo?=
 =?utf-8?B?amZNWnZTdGlWYzVwUmlDNjlJL3N5bkNSWXVLc3V6NDlvNGZkVTBuN3d6VU5F?=
 =?utf-8?B?Y1pGWkxRQjlpMmV5WG5MR2d2eFNtbjVuUEFaVUtPSEg0YmYzMnJqZHFFTUlM?=
 =?utf-8?B?K1ZhbmJlRWlsbFJhclgwUitueG9NcjB1UnNKTXF1WGVFQTk0VHB5bXBBeWl6?=
 =?utf-8?B?MWNaeEtLVDNtVG9UWnBLanUzdkx3VWNIWGZDWFFGVm40OXk0YU5DVXgzejIw?=
 =?utf-8?B?M2xlc2NwZlN3VjAxRnVucmY3T0RjWExLbGpCbWxuMjk5M054YXFCM2ZjNDVH?=
 =?utf-8?B?WGdzSkNLdEZiMWlneE9TcG1XZHN0VlRpRk1tY2oxK2I4V1h3VjJxd3JqMmNx?=
 =?utf-8?B?MlFLSVV1NTQwT0dZWThJTWVqdTliODVYUm83ekQ3cUFCZVJ6TUh3WUs0dnZ2?=
 =?utf-8?B?WFEydUVQajAwbjdhSHMyQkV5bU5qSXJBbnpQTTRzUXBEVS9LU3hpWDNsekc0?=
 =?utf-8?B?RkZxZW5nMlJSaDAvMnNVcnJOV1dIV09pSnVQWHJPMmVPTWhJbmJzVHc2dncr?=
 =?utf-8?B?cUEzVExlUUwzemg0akZDa0pBa0JFL01JQ1lvWkIvaXk2OGd5cGJ1Zkc3MHBq?=
 =?utf-8?B?cDl2ZXJtU2ZSUDRSTk1CdFpEeHFYSEROMDVqOUIyTmxkekNFb3pENDBrVU4v?=
 =?utf-8?B?VjBUVENrTjVKMk5WbTlzTThOTlV5TFJvcHBvT1VWKzNpTXlNQi9JMFdpdnpK?=
 =?utf-8?B?dVVFeFpISUpkdGF4OE5YdUNhUUU2RHQ5WnFNblg1Mm4rQkltSWpsaFhYQzJu?=
 =?utf-8?B?Q3pDYnRwdStpYjBsbnFpTUF0ZW1uVEJQWGxyTEFnbWRibHpWNUxZeWMwYXBw?=
 =?utf-8?B?RnJqcUN4SlRPalQwNDZkeENkMTRDYUR6Znh2aURUK01aZG1SZEM3WDJNQTRV?=
 =?utf-8?B?OXV3ajJQWjZXTVhYQ2RnQ1MxaEVqWkVNeHlNVS9BWTRpUm1WN1cvOFFzYWJO?=
 =?utf-8?B?UXNsMTc3SXJnbC9vRXhnVjNsbVR2V01TT1dUODN0am55OXNDQk5nUjBGQmN6?=
 =?utf-8?B?eEFYV1k0V0xUMG1DZmozMXF2aVFYTjM4N3Nob0V1akZDQUlXWEM5b2dRdGpM?=
 =?utf-8?B?Q0tiZHZ3cVVKUVo3ZDZ1Z3ZNamdOQnFlVGY2ZW0yNzhBWWM0RG05eDZtekVj?=
 =?utf-8?B?aUpMN0VMRFRyR29McGZ0bXYxN0NRc0lyK0hjNFh1SUFIempwQlRyTmlOOEEy?=
 =?utf-8?B?V1M3aUhhekp0Q1BWMDVqMk9ZOEd5NmZ2ZVpSZTRDQS9lRVNrODh2T3BhQVcv?=
 =?utf-8?B?QnZNM2Y2ZDd4TENncVJkT0wyYzhyYmFLTG1ZQzlMSko0MDVycU1TdTNZV25O?=
 =?utf-8?B?bGtzb3VCMmI3UW9nUmpac2Q4RTVoakRnL0RqQVZYdlltbEN0bHI0TjFRRUgv?=
 =?utf-8?B?TnRnc0FGRVRaV2ppZ29aT2FFSlNmd3l1YkV3MXZTV1IzZiszeGFWNUNIMjVE?=
 =?utf-8?B?TU0zNW9oMnRydFFpV2ZwR3BqdUZUNzA1SGRjNlFnTGlzditPYlBIOTFWTFNa?=
 =?utf-8?B?TlJQcHJQS0cxa2pqRThUNE5BT0E2Z3lPK3F1OFI1ak1VeDRCWUphdUcyRWFj?=
 =?utf-8?B?V1gxWW5wUC80cGFFQ2V1ckVycWUvbFdDcjJtcFFyenZGbm40RU94N2x2U21H?=
 =?utf-8?B?OHIvczRXQWxvZXhFRm5XbHkxcXNCdGFKTDMzRGYrUVBQVk41bmlEdDlsc0lN?=
 =?utf-8?B?MXJZQ0RFRWFyT3o1NzhoYXJNL2gxZmQvQzVPQW1xUldvSzdYNXF0SjRZT2Fr?=
 =?utf-8?B?elJQMkttekJUTUFVaXlKL1Z1Y1lIb2U3NEVodEFNSE9vU3QvVkxNdnJxZmJr?=
 =?utf-8?B?a3FmR1VaM2xLZDgrQ2FscHFZOENKQmFDUStzRnJnZ1JNdWs5bUJRN0FHU1Jx?=
 =?utf-8?B?RWdQb1NQbkxFM2RjRmFJL09kNUlDR1lJc3lUL0pkUFNKZ05Ic0EwSnArKzMw?=
 =?utf-8?Q?IJuXSM52LzjqV9VyjFYT5RuKI?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: caafdad0-1fa7-46ea-076a-08dc11e5d3de
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6288.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2024 14:09:58.1990
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4GfjkgP3iyQgc108bHlvnJCW1M+IzmHbJzDE86Bmcmhe+lwEoMIvs1G9P8nzOCmP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4283

On 09/01/2024 18:00, Jakub Kicinski wrote:
> On Tue, 9 Jan 2024 16:15:50 +0200 Gal Pressman wrote:
>>>> I'm confused, how are RX queues related to XPS?  
>>>
>>> Separate sentence, perhaps I should be more verbose..  
>>
>> Sorry, yes, your understanding is correct.
>> If a packet is received on RQ 0 then it is from PF 0, RQ 1 came from PF
>> 1, etc. Though this is all from the same wire/port.
>>
>> You can enable arfs for example, which will make sure that packets that
>> are destined to a certain CPU will be received by the PF that is closer
>> to it.
> 
> Got it.
> 
>>>> XPS shouldn't be affected, we just make sure that whatever queue XPS
>>>> chose will go out through the "right" PF.  
>>>
>>> But you said "correct" to queue 0 going to PF 0 and queue 1 to PF 1.
>>> The queue IDs in my question refer to the queue mapping form the stacks
>>> perspective. If user wants to send everything to queue 0 will it use
>>> both PFs?  
>>
>> If all traffic is transmitted through queue 0, it will go out from PF 0
>> (the PF that is closer to CPU 0 numa).
> 
> Okay, but earlier you said: "whatever queue XPS chose will go out
> through the "right" PF." - which I read as PF will be chosen based
> on CPU locality regardless of XPS logic.
> 
> If queue 0 => PF 0, then user has to set up XPS to make CPUs from NUMA
> node which has PF 0 use even number queues, and PF 1 to use odd number
> queues. Correct?

I think it is based on the default xps configuration, but I don't want
to get the details wrong, checking with Tariq and will reply (he's OOO).

>>>> So for example, XPS will choose a queue according to the CPU, and the
>>>> driver will make sure that packets transmitted from this SQ are going
>>>> out through the PF closer to that NUMA.  
>>>
>>> Sounds like queue 0 is duplicated in both PFs, then?  
>>
>> Depends on how you look at it, each PF has X queues, the netdev has 2X
>> queues.
> 
> I'm asking how it looks from the user perspective, to be clear.

From the user's perspective there is a single netdev, the PFs separation
is internal to the driver and transparent to the user.
The user configures the number of queues, and the driver splits them
between the PF.

Same for other features, the user configures the netdev like any other
netdev, it is up to the driver to make sure that the netdev model is
working.

> From above I gather than the answer is no - queue 0 maps directly 
> to PF 0 / queue 0, nothing on PF 1 will ever see traffic of queue 0.

Right, traffic received on RQ 0 is traffic that was processed by PF 0.
RQ 1 is in fact (PF 1, RQ 0).

>>>> Can you share a link please?  
>>>
>>> commit a90d56049acc45802f67cd7d4c058ac45b1bc26f  
>>
>> Thanks, will take a look.
>>
>>>> All the logic is internal to the driver, so I expect it to be fine, but
>>>> I'd like to double check.
>>>
>>> Herm, "internal to the driver" is a bit of a landmine. It will be fine
>>> for iperf testing but real users will want to configure the NIC.
>>
>> What kind of configuration are you thinking of?
> 
> Well, I was hoping you'd do the legwork and show how user configuration
> logic has to be augmented for all relevant stack features to work with
> multi-PF devices. I can list the APIs that come to mind while writing
> this email, but that won't be exhaustive :(

We have been working on this feature for a long time, we did think of
the different configurations and potential issues, and backed that up
with our testing.

TLS for example is explicitly blocked in this series for such netdevices
as we identified it as problematic.

There is always potential that we missed things, that's why I was
genuinely curious to hear if you had anything specific in mind.

