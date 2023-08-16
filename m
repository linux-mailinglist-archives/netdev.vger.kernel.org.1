Return-Path: <netdev+bounces-27853-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CC33E77D746
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 02:56:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 852542816F7
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 00:56:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D1EF7E0;
	Wed, 16 Aug 2023 00:51:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FF53392
	for <netdev@vger.kernel.org>; Wed, 16 Aug 2023 00:51:06 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2053.outbound.protection.outlook.com [40.107.212.53])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE8352112
	for <netdev@vger.kernel.org>; Tue, 15 Aug 2023 17:51:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nxx6+yIJC3OURbO4uwaUpcsNOMlf2IVYiw2tXNBBR8GwAubs2d3VEzJPNk0EUKPQD+wkbohsbpD59f+6YeTF45UdNrmMRCwp7HLfZR8W0HZIWfJUX9Dfl02QSV6gIAosk4npKSEj00jKim5615LAyBsSobl+QTJGE/BilxKYxMCKBXqL8ZapL1dcEboXSJtD3aVMPzQOYfzaHLfWSbsp2Vobj7HS+IYG1Ls45+ouH/VG2f3iddDCzEZCrhtHvCYoXUOwKGFeD8zvWkilUp3YqrTSqJJcJrrwoo53eUxK/4homIDJSpQYu1dvzJyOt+5j37DFG6f2TPkxoR+mljMNqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G3O5r5aHKSFYNB1dhAUzdoQPfKERB8NM6JlAw29wudQ=;
 b=n3xBl31LIDencnbCDubWdwE/S2QPqpBzlBFlMOVjMz5PNyjBA7bhX7A+73UfaHqwYQLU793squ4hKSgAz91O/BMsrse0g8+fdyxpeQp4Q+jeuwBjLInI8tBq0CzuaCwa7R14d7cv4VjYNpEpF7NBGcgm10SQCsEpghEfPsrRqoYZIjny78Y+wmYdGTYcBOfiWawoqzR0FOo60Ahcu1EyKWRiQdXLGsYWCTkRujWYFg3wUvjN6d/qUr2MnMvLBTQjRriZl8GN80SW9QP/vtefdH7qnhUJ4PeJR2JYy75ryR1uspP96/1Q5LCpLFdwFZV118BRNnm2zGX2mMEPN3G9zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G3O5r5aHKSFYNB1dhAUzdoQPfKERB8NM6JlAw29wudQ=;
 b=b7ZFrb3rwpdF4z4cIETeYPpvcLA1TMBdmh5eyGOVwjdlZVZbrjw9BotR2t2QnULqOo3aNogWIS9GjmKWJirAcbyRynH69tUgKgXMW0P8GPsOgtedj5qRD2VNHirfmTrnDPZnIduScCVGeaTFGyqRUbmjuI+hpBemU/OpibEFynHSWXTlbeJ8s5AiNggS9ppU+Ea4J4T9Fa2PIppPwN7lX5MJoVgqG0EL0iR/mCoxAzqNqILotHevJQp1/5IK/bkC+E+o+nbjObX6bVUNV4Kxbq4ReKALXRTfvDAimIahtmw4aABmCbbx+6M8tbEoBAdOFS9nBgdVzah8+LZHP8zHXg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB5040.namprd12.prod.outlook.com (2603:10b6:5:38b::19)
 by SA1PR12MB5637.namprd12.prod.outlook.com (2603:10b6:806:228::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Wed, 16 Aug
 2023 00:51:01 +0000
Received: from DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::4bf4:b77b:2985:1344]) by DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::4bf4:b77b:2985:1344%4]) with mapi id 15.20.6678.025; Wed, 16 Aug 2023
 00:51:01 +0000
Message-ID: <565babd4-957e-9906-2fae-3b6ae3aa5c9f@nvidia.com>
Date: Wed, 16 Aug 2023 03:50:51 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v12 07/26] nvme-tcp: Add DDP offload control path
Content-Language: en-US
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>,
 Sagi Grimberg <sagi@grimberg.me>, Aurelien Aptel <aaptel@nvidia.com>,
 Shai Malin <smalin@nvidia.com>
Cc: "davem@davemloft.net" <davem@davemloft.net>,
 Boris Pismenny <borisp@nvidia.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "kuba@kernel.org" <kuba@kernel.org>,
 "aurelien.aptel@gmail.com" <aurelien.aptel@gmail.com>,
 "hch@lst.de" <hch@lst.de>, "axboe@fb.com" <axboe@fb.com>,
 "malin1024@gmail.com" <malin1024@gmail.com>, Or Gerlitz
 <ogerlitz@nvidia.com>, Yoray Zack <yorayz@nvidia.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Gal Shalom <galshalom@nvidia.com>, "kbusch@kernel.org" <kbusch@kernel.org>
References: <20230712161513.134860-1-aaptel@nvidia.com>
 <20230712161513.134860-8-aaptel@nvidia.com>
 <8a4ccb05-b9c5-fd45-69cb-c531fd017941@nvidia.com>
 <2ae6c96b-2b05-583e-55bd-2d20133b9b37@grimberg.me>
 <d439964b-1544-f37a-6ab4-ec1fb4cd0d9d@nvidia.com>
From: Max Gurtovoy <mgurtovoy@nvidia.com>
In-Reply-To: <d439964b-1544-f37a-6ab4-ec1fb4cd0d9d@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0228.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b2::12) To DM4PR12MB5040.namprd12.prod.outlook.com
 (2603:10b6:5:38b::19)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5040:EE_|SA1PR12MB5637:EE_
X-MS-Office365-Filtering-Correlation-Id: ba5e9640-e5ac-4c91-3f21-08db9df2dc96
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	emOEO4RP+tSDFZvdinHD+4Snn1/33P+CXmMhzlDAQUn5n/itxIHvHOasMpHOETgD6seCGOW49cMsTpnOXk5cyQGVy251Wmdyb4BUzQYrV2pze0kcMxSUMIpyfXOMW3eNBhHOfWGIdvxOfGOIVVOJVtt8h4Vfpe068NiyIs+TwvqrlWHZZFjXL76WBBuL4WILrpopQGGk567dMWEYvTr+H283qAVZpt2aWmbTSkiacZZunrN0xweKGyhtMBu4YMt3/+vx748jWEGnuu8dJpE7G2jiA00i6pNdvR56bRRFeniaVcRkpucS5yQ+OEYbRkeSYN3BZdgcngcJ+RWyYkm52TSO6WE2ibV/F/p78gCG45eXygZ36B78QwdBH430C9pPEfU0r8Oj11djHpRtbXTBZQCpVvwhjpZUT/Y1ATCU06Wd1TLrd109kXtO1/oF8XyUhfzkLGrX0p8E9+3wmvHfDmbWEQvWzJ4CsydZHcO3y9c5d8Rp7PmryFTgrKR7kGwqzPSm4XGAQYzepSOkOnGk8SQcGYsS2slnphFXRm3+EaOhl6v2rDN+btCryf1Ff1LZPLY6rGuSNYTllhporVj6sHBNkhO5+kkFdT5bp+E16bEW/r3EAD9TdAl2IjqBMAXs6FuIBemuHFoGzCiQ5LdOGA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5040.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(346002)(39860400002)(136003)(396003)(451199024)(186009)(1800799009)(478600001)(86362001)(6486002)(2616005)(36756003)(31686004)(31696002)(6506007)(66476007)(5660300002)(66556008)(66946007)(6636002)(316002)(41300700001)(53546011)(26005)(6666004)(38100700002)(110136005)(83380400001)(54906003)(4326008)(2906002)(7416002)(8936002)(8676002)(6512007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?K1krSkt6aUlWQXFFRWxHNktwcW5RYVVqK0xyNWVPRmxVQlFxWEJWVWtTenBi?=
 =?utf-8?B?d0FWUFdQdG02Y1llM1NsY1VVaHZtUUxrQ0l2V1VEY0NnQllMYzBzSW05T3NE?=
 =?utf-8?B?TDI3a0ZCTHpUa0ozNnBaUkhOYUhCdDlLVkNuem8xbGFyT1BlV2ZtOWxCU3Y5?=
 =?utf-8?B?U1lMTWRYQUxzRzdmSVJlQjNMNXZlaW82d3VRNEV5Y1k4VlEyakhESDZFMENX?=
 =?utf-8?B?dkF2RW1nazBTb25jK1dBem85TW02TGtkcS9sbEozejJjVFFROEdvKzFxaXdv?=
 =?utf-8?B?cURTQkN4VkM0NXFuWVNlcHkyZmtUQ3VVRXVzdkV3RjN4OFhPZlBJcDRuanQv?=
 =?utf-8?B?NE8reGxndjl2WDFvLytyd0h2WDNKTTlpVXRsYzNuT2x4ZmRlMDBJdEFnTGl4?=
 =?utf-8?B?NC9vdUZOL3huNndUa0V5b25qTWU1Mmh6V0FEUTJvbkJReEhuS2djeTNtTkhR?=
 =?utf-8?B?eW1iZmJPblFJbnkwcjVFTmpRdktiaW1pYVR4WTNyOHJMSXZyY0srdkpITytl?=
 =?utf-8?B?cU8wbzNMcjlVWGdwRTJneTQ2RUhTdWFPN0xYcHZNVTBxTUxITU16bzl3TkZp?=
 =?utf-8?B?WnVUUXAwUUh3RG40ZEM5RG1DeVU3SHpUSmN4cHdlRUZ3eS9HMlJmNjVGbUVo?=
 =?utf-8?B?d09IUWwxYTNIWUZITVhDZ3VKNGM0ejJyRTc1TTBvNW8xL2lmYUc0bWRoaTV0?=
 =?utf-8?B?NjI2NC9lRGRUa1RSMGwzeVYvOTBCR3NGTkpTaUtMcE9ocVJYZjNOWk1pM0dI?=
 =?utf-8?B?VmloRURMUTJydHNoamJJWFhCYmxmU1VVZW9RcmNkb3JrU2wwU3k2bWNSUzNN?=
 =?utf-8?B?Qy9zNENzWnlsQzYxTDYxREEyaEdYS1BqVWhaaFBRS2RGaWZaeGx0c1FOYkhT?=
 =?utf-8?B?ZzFGYWZpZ1k0WVhlODJEMjFrZDJ1Y2MrMjc3ZUUwSzUwOU8zWGRaUFFhQkNS?=
 =?utf-8?B?cFpFUFdqUnV6eFJzc1N1UG5CNGV2SWh0bkRRL2NxQ3lWMThYVzdYZ2pOVEph?=
 =?utf-8?B?MG5xN1I5UE93bmdINEpWTUVnZ0hYZFFTZDhqdmFRaEF1TEswTzR6QWw2cWpY?=
 =?utf-8?B?eDhPOUxyeTA1Qi9GdlVyWW8xaXhqWjNVUW1XamZpdXFrUmZxOFNWbDA3VnM1?=
 =?utf-8?B?UFNySGRWZHdqNE5YaVduTnBVeXd3WnhENnVnVWVJYTdtS1RwR3piYzNsQUxC?=
 =?utf-8?B?NTRrWGQ5dDllVEFidkpsMVBsUUxwNjhhckFIeGJ4cjRDMHRsc2hiTzk5NENL?=
 =?utf-8?B?RlJXVDg5elg5N2ozajNqTEVGbHRUbXRXeEZTWUlOQWVXamJGTXBwQ1RIMER1?=
 =?utf-8?B?MkhlZk1saEFicVdPanlEMVdVZk0zOE5ZdUIwRDB0MmpPSDNzd1FkWmFjeWUr?=
 =?utf-8?B?UVZTV1JqUkRvSkVUMEt2Sk9Rd2IxS3puK2xYMEd4U1k5Y0VIQXE2QnI2eFJl?=
 =?utf-8?B?RXJPS1Vxam1CK1p5NEp2RHBoeFpxcDQvcURTOTFtUHRsU212TXZodEcrWUd5?=
 =?utf-8?B?K0lHYlZFeGlhSEJjNjc0TzFBdDRuWXBTZlRYcmNrVU52S3R4eDE4R1gzVEZX?=
 =?utf-8?B?ZnJIc0VJK0Z3Ui9SbDBpQ2k0K25WWEpaU2w2bEN4dHErdTlyanNENkdWRnJU?=
 =?utf-8?B?NjJkZkEzZzAzSUxGRlVqdnlYL3BPa2EwNnYvSTc1MFJ4c2N6NG1yN3BjOUdp?=
 =?utf-8?B?Mzh2UGlwcTEreGk5Wmh3bDZyMDNUU1lNNVFsTWVYUjNyUGdLYjZkRGFtcUxY?=
 =?utf-8?B?Q2E4ZmRiem9sOW5uRGVvYnFjTjByWjd3anZzMmZaRkZKSk5oMHE0RDQvMWpq?=
 =?utf-8?B?VzBZVE43cnZySVhkNm53KzFsZmR0aTMyYUQrclRDRmI1cG5DUEVCVTFDZXE4?=
 =?utf-8?B?WGFPUUZrWEovTzZiYTg0NTJsZVRjWmRkcXVQVWFvaDFORWdTK2d4OTIvbEtT?=
 =?utf-8?B?N0R3V0IxcnRYZHVqc3BLaGZLckF3aVNZKzJpcm1xL21Xb0JyM2dvU1M3NDRK?=
 =?utf-8?B?YXZIRFNVT3dxN2NMYy9ieUl5VFhpODhrd0k5eWJvRTc2R3FSV3RPSy9JMTIz?=
 =?utf-8?B?T2hxVUdHNmVnc0hKZTd0R015RitZK1JVcVAxbjc4SERGMFlUTXNRc2dSNERW?=
 =?utf-8?Q?yxY1j7jS6C1REa+YcN+RxiFzx?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba5e9640-e5ac-4c91-3f21-08db9df2dc96
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5040.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2023 00:51:01.4441
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S9qIumdrRf/W4w1yysaY5gIZTA1STih2WVfefc1jOacf8RdcxzV58nc9dp01+Xdrs9klrHFLrgoFtUWZhter9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB5637
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
	SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Sagi,

On 11/08/2023 8:28, Chaitanya Kulkarni wrote:
> On 8/9/2023 12:39 AM, Sagi Grimberg wrote:
>>
>>
>> On 8/1/23 05:25, Chaitanya Kulkarni wrote:
>>> On 7/12/23 09:14, Aurelien Aptel wrote:
>>>> From: Boris Pismenny <borisp@nvidia.com>
>>>>
>>>> This commit introduces direct data placement offload to NVME
>>>> TCP. There is a context per queue, which is established after the
>>>> handshake using the sk_add/del NDOs.
>>>>
>>>> Additionally, a resynchronization routine is used to assist
>>>> hardware recovery from TCP OOO, and continue the offload.
>>>> Resynchronization operates as follows:
>>>>
>>>> 1. TCP OOO causes the NIC HW to stop the offload
>>>>
>>>> 2. NIC HW identifies a PDU header at some TCP sequence number,
>>>> and asks NVMe-TCP to confirm it.
>>>> This request is delivered from the NIC driver to NVMe-TCP by first
>>>> finding the socket for the packet that triggered the request, and
>>>> then finding the nvme_tcp_queue that is used by this routine.
>>>> Finally, the request is recorded in the nvme_tcp_queue.
>>>>
>>>> 3. When NVMe-TCP observes the requested TCP sequence, it will compare
>>>> it with the PDU header TCP sequence, and report the result to the
>>>> NIC driver (resync), which will update the HW, and resume offload
>>>> when all is successful.
>>>>
>>>> Some HW implementation such as ConnectX-7 assume linear CCID (0...N-1
>>>> for queue of size N) where the linux nvme driver uses part of the 16
>>>> bit CCID for generation counter. To address that, we use the existing
>>>> quirk in the nvme layer when the HW driver advertises if the device is
>>>> not supports the full 16 bit CCID range.
>>>>
>>>> Furthermore, we let the offloading driver advertise what is the max hw
>>>> sectors/segments via ulp_ddp_limits.
>>>>
>>>> A follow-up patch introduces the data-path changes required for this
>>>> offload.
>>>>
>>>> Socket operations need a netdev reference. This reference is
>>>> dropped on NETDEV_GOING_DOWN events to allow the device to go down in
>>>> a follow-up patch.
>>>>
>>>> Signed-off-by: Boris Pismenny <borisp@nvidia.com>
>>>> Signed-off-by: Ben Ben-Ishay <benishay@nvidia.com>
>>>> Signed-off-by: Or Gerlitz <ogerlitz@nvidia.com>
>>>> Signed-off-by: Yoray Zack <yorayz@nvidia.com>
>>>> Signed-off-by: Shai Malin <smalin@nvidia.com>
>>>> Signed-off-by: Aurelien Aptel <aaptel@nvidia.com>
>>>> Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
>>>> ---
>>>
>>> For NVMe related code :-
>>>
>>> Offload feature is configurable and maybe not be turned on in the absence
>>> of the H/W. In order to keep the nvme/host/tcp.c file small to only
>>> handle
>>> core related functionality, I wonder if we should to move tcp-offload
>>> code
>>> into it's own file say nvme/host/tcp-offload.c ?
>>
>> Maybe. it wouldn't be tcp_offload.c but rather tcp_ddp.c because its not
>> offloading the tcp stack but rather doing direct data placement.
>>
> 
> fine ...
> 
>> If we are going to do that it will pollute nvme.h or add a common
>> header file, which is something I'd like to avoid if possible.

Would you like us to try doing so and see how will it look like ?
I actually think that it will be easier to maintain if we split it to 
tcp_ddp.c (+ optional adding of tcp.h under driver/nvme/host...)

> 
> my comment was mainly based on how we separated the core code from
> configurable features, and wondering any decision we make for host will
> also apply for the target ddp code in future, but you prefer to keep it
> as it is let's not bloat header ...
> 
> -ck
> 
> 
> 

