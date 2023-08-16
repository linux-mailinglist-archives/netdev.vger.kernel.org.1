Return-Path: <netdev+bounces-27855-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BFA3077D74F
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 03:05:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99C5F1C20E5B
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 01:05:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 305A6392;
	Wed, 16 Aug 2023 01:05:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24156631
	for <netdev@vger.kernel.org>; Wed, 16 Aug 2023 01:05:49 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2072.outbound.protection.outlook.com [40.107.220.72])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEC511FFB
	for <netdev@vger.kernel.org>; Tue, 15 Aug 2023 18:05:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BnSrJhwrdRL37EtOxP4L3KecmPKl0n8LGRUBgMpImWR2+rdqn9NGBJp8FfXdQZCrANGY2qtvstA0EEqPPIeTC5O24rbzIdHsSNG1kstDF9aYO87+gh0PXzpdHOQDitvEFlJXlcjQEVonDUe6FnhJQ2NSw80QmSm6+MuW3SnsOJD8kiL3qUzBveS/iNtcYc5vlov9rWqigdwoq8pCcfwFPtcVfnC6c7ijrCaG+ExJI/HSOgQAR7yELVTlPVKJTbejD5AsVi86hm+hwUgZNbl+yIu76Rf9nQUaeYdLnd56Rr0sywRYs8oMmcFtUZpz2S8PKPyr7isvZsCshNpqZwwcYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8kEbgg0vSYCyM8P/UsE1qii624+x/9VTK8BLurpfV2c=;
 b=KwX+23Xe02l1DCM0PTDB5z57QV5Dp3Cr44jjp48Sskrjud0VmxmIkbmdl4j96CDegNrapvjsvkiA0zl5McYnuUqRZckXycuSKCdc6Yfl2ajSHNBgs7nEVwv85m/7P9PpjcafqEZx8ZNsgsQ1YStWX4d28H0LAW3rXX0y0T6MsxmhugyIwPv0o/1o1aiAYCOBdX0fiPEYe5TkJB+TJYc2XLdhAmXJk4NjeIGYR4AAaxmMKEEfObX5xGNWP3LffeEIOPBWnimLSm0V+h4mCZCpFB0s2/G4u/vV6Lgc8esBqjcCSvWVixlCCShbzMnnSDKWi8dgiFPfqisZrbcvOP+U7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8kEbgg0vSYCyM8P/UsE1qii624+x/9VTK8BLurpfV2c=;
 b=kxzTBNuIC0saC4P4ijyl+TUf3sVSFYWAg10HSXmZNe5/hfApmA1So8Ew6172w3IioErHOgWucl8h9mMMP/6CZGUKOQBfe5+oJO81TZTDksvqYtbbqglkaB4gX6Fr9uvqaJIlywWPUa3wvQ45KY37XZzBQzzHsRxNid+3lAZIGvulTWN8Ti+uGkvreGBwp5FelASeh0zrQQjJmDIwAUk0Kb8dTgg/2sSWAw61L9b3H0e17/D0AutqDzmpDq5Mo3F57mfL7VRqCG2XrLQlc/ZQZCougaHgYGKuChcQZLVh2a6TPR9Zo+ra/ApU9LyBmK/jW2/kyX4T+K58aiXJP0iYBg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB5040.namprd12.prod.outlook.com (2603:10b6:5:38b::19)
 by SJ0PR12MB5439.namprd12.prod.outlook.com (2603:10b6:a03:3ae::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Wed, 16 Aug
 2023 01:05:44 +0000
Received: from DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::4bf4:b77b:2985:1344]) by DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::4bf4:b77b:2985:1344%4]) with mapi id 15.20.6678.025; Wed, 16 Aug 2023
 01:05:44 +0000
Message-ID: <175b859c-0c64-3a52-5467-32e06d5c20c9@nvidia.com>
Date: Wed, 16 Aug 2023 04:05:33 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v12 11/26] nvme-tcp: Add modparam to control the ULP
 offload enablement
Content-Language: en-US
To: Sagi Grimberg <sagi@grimberg.me>, Aurelien Aptel <aaptel@nvidia.com>,
 linux-nvme@lists.infradead.org, netdev@vger.kernel.org, hch@lst.de,
 kbusch@kernel.org, axboe@fb.com, chaitanyak@nvidia.com, davem@davemloft.net,
 kuba@kernel.org
Cc: aurelien.aptel@gmail.com, smalin@nvidia.com, malin1024@gmail.com,
 ogerlitz@nvidia.com, yorayz@nvidia.com, borisp@nvidia.com,
 galshalom@nvidia.com
References: <20230712161513.134860-1-aaptel@nvidia.com>
 <20230712161513.134860-12-aaptel@nvidia.com>
 <1f68b7ee-b559-177b-650a-a8683fb86768@grimberg.me>
From: Max Gurtovoy <mgurtovoy@nvidia.com>
In-Reply-To: <1f68b7ee-b559-177b-650a-a8683fb86768@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1PR06CA0122.eurprd06.prod.outlook.com
 (2603:10a6:803:a0::15) To DM4PR12MB5040.namprd12.prod.outlook.com
 (2603:10b6:5:38b::19)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5040:EE_|SJ0PR12MB5439:EE_
X-MS-Office365-Filtering-Correlation-Id: cd274994-ce6c-49c2-19dd-08db9df4eaf6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	0YM7BwFFr09+I4qv8LeC4WIZSh221/nP8/kdcABW1ppd9DOqT1okaFLDJ0NQdWDEjZYqZeQE5zOY6sl5zhj70wuvVZ5ubpADdfgZGsfmKLpNqpGexDFhOdelPkKU7MFIwPJj4MRdhjP2hylD1wNZiJ2AV+uuASS+QBu6UPTk2jpLLfYxZPnxeYS4gSFWdYpXEO5z2Yoh95AXS0u21whFs0bfpCdueQAor8hWEGkycoOD1IzphcRuTD23AZnsj4jusJrsn4VfhmOfDRzM9wecPKmkgSe9HukcZawFsNQBU/jHOR6aeqkUvU8uK27mvBYRy4jXn8YSQtLU+VLKiEfh/iHQpe1ZnJHqYmaqr+k8DFNTb0IuukEDsi+499jmz6cap1cvDY4cMBQR5n10aA+bqmm6j2l4qp00WrZ3wiW+7LYZMVnR/k4Y4nLH1a1J5gAeR3ElsSGmuYPYbDngY2pJEzsCK44npQ0z1QnDyOk6AXyvBkRcR7p0vAfUBviH74DZwGhEnsNr005tf+P/Ekx8bZ1Jxumm3w0+0joUCGKLKo8Ua09rp/rq88Wve2EFNUEV7Sal8CV4HKBMjH3iRI4N4CGrZfjNDZvBH8SpPBe5qDkm2GYca+T3B+piaJ5eOnX5hMjso05Vi7hXpmddHLfhIMB6/z1DB0hMwDQ3iSVsL4M=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5040.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(346002)(39860400002)(136003)(396003)(451199024)(186009)(1800799009)(478600001)(86362001)(6486002)(2616005)(36756003)(31686004)(31696002)(921005)(6506007)(66476007)(5660300002)(66556008)(66946007)(316002)(41300700001)(53546011)(26005)(6666004)(38100700002)(110136005)(83380400001)(107886003)(4326008)(2906002)(7416002)(8936002)(8676002)(6512007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SmRpZkhRQm1zeW11UkxTVDVxeVJ2anlFaTdrK2xtSHE1R3JiWXhNT3p3NDZD?=
 =?utf-8?B?b1RFRmh0aGhDQnRHME9qNHIvTEpIdFhwMG8wZ1NoY0NDMEhabTdwUmc4YkNi?=
 =?utf-8?B?Q1lwa3o5N0NpUEtNR1ZCaGxscWdaTUlZZDdMTG5xb3V6ZGtSc254b0J1UFRk?=
 =?utf-8?B?ZTAxQVVoTUU3bTJ2ak1Scm4waWpVb0FtK1ZOK25UMU82K29mZjQ3cnowYVll?=
 =?utf-8?B?MDFKNE8rRTAycVdkdXlXcVRyN1FsN3JmQTFGTkg4cjJvT005OEZyMlhFdWoz?=
 =?utf-8?B?cVI0K2hQenRRdXFaR29vRldyYXZ6b2k5LzdEVVpzc21ZUkhNVXlNYjBQb0Fx?=
 =?utf-8?B?YWhDeUR6bTFHKytaamRHazRiWHExd1Y0dnAray90MEFSQ0U5N1lLNm11SlpK?=
 =?utf-8?B?eDQvSnJ5eU9xcC91NFBmaU1ud3VYeEdlQjhubkZ3ZlBBWXhPb3E0cEgzdFlx?=
 =?utf-8?B?MnBsSDdsOU9teFBQQ1MzYzVjaWNlS0Q5NUFrUHBYVUNLb2piL3lHWk1SS1B5?=
 =?utf-8?B?QngranY4VmVrbHZVWlViRDZMb2gzOHZnVVh3YjdDKy96SHp5bWwwVHRMUWVk?=
 =?utf-8?B?bExqeDg5RlNoQk5TYjA2Wk5WbU8ycFdOVmU1cEcydzZTVGtsMHExdHpiRjdU?=
 =?utf-8?B?Vk5lQmQ3R1RNRGJkMm5pNnc3Z2x5N3dCYjFIWmZmbGpkV2hoNWRSS3ZsOGhn?=
 =?utf-8?B?dkNmQWh4K0VrNTZvK3JYbXRBdlZjSGtjVU5NZUE2OGdsRllQZXJOQWZFd3dX?=
 =?utf-8?B?TnpOaHBxKzBmSFdXSjZiLzN0SGRaYVQyLy8yRERlNlE5MkNyK3l1dHlRUU44?=
 =?utf-8?B?bHRua3BJUkt6YWw5NzVZNUtsNU9CbjJqM0xJU3UzbzhUSk5UWjhWMTdubDZ4?=
 =?utf-8?B?eld6QzY1UFQ0TGM0OWZrUXJWUW41VThqekNhUk9FYklNZEJDSVQ3OHVvY25P?=
 =?utf-8?B?cGxuRzdQTkE1L2JXZlo5ZjB1OHpFcmtKU25lYzZhcEVDa2lpSUpZQ2hHcVZk?=
 =?utf-8?B?bGRXMGpSRlZqZEpmS1VNVExTbmFBZjJJZFFpRTJUVWY3RGZuZ2QzdzZ5bC92?=
 =?utf-8?B?cU5zVEE5OXJCVWpjL3VJOVpSR3FieDFXN2ZIdWs4L0doRVZQYzcydWlScVBa?=
 =?utf-8?B?MjRvdk9MS2NCdGIvNVljQkZzT3VXRlllUjFNdTNtSS95bzI0SjhZLzludWE2?=
 =?utf-8?B?b1o3UDhZVWlPK0wwYk9xK2xaT3JVWDk3d2FHV0VURVVBK3AyQXh2Z3daQjVt?=
 =?utf-8?B?Zk9NdWVtcmdXRUIweU43cDAyN0hUT1F5Z3dyZzdlOWY1TkhGM3huTXR3NWkz?=
 =?utf-8?B?VzJNWkhKRGxUZ0hnT3kzOXI0djhtUHFsSG1EMFpqY0lJREQ5Smd6cEg3eWpv?=
 =?utf-8?B?M2k4MVNWV3JnaDZ3WTBDU2xuODNiTUlLcFhFbEQ2bStrQ1FCeG1JNTl5WCs4?=
 =?utf-8?B?SXcrdDkvMHdBMkRqTlBWZHRnQXgxZkl1ZjR2WDExMUQyWmJnNFEyWE9aVVYx?=
 =?utf-8?B?UjN2eFdGTG9kVkhaWUh1QTloZkQ1Z3NxK0V5R0V3M1Bmbm5rcFNsZ2dKTlFW?=
 =?utf-8?B?MjFpQ3ZHcHZ4TXRZV0Fpd1psZ1U5Rml5b2Z4ekdVNE54VnR3Y1FmZ09mUDZp?=
 =?utf-8?B?Z3YzOVdvTlVOd2tSTjN2RExpalpQNS90MlMxVXpsbHNCRVREZTcwdytsUXA2?=
 =?utf-8?B?Y1VxS0V5ZHZRRnpzL3gveTEzK3lNVDFhSmdOLzc2eU1QMWt4V2tub3hqM3ZY?=
 =?utf-8?B?RVlkNXIyTFlWOFNnU0NHN01mTUZ1NTYzVkVyQ0dLK2VKYnF4YWVWejNRUFFK?=
 =?utf-8?B?SkdEekN1Y1FjcXlpUEU5ZENYWjFSa2k1ZHJGY09rbGI2bTlxWGNmbllXQ3Jt?=
 =?utf-8?B?WkRWV25LZElYMkRKcVk3eVNqMGZxUU9PZ2ZHZmR4dGZHeFFhUWZBb1J4Nmc3?=
 =?utf-8?B?Y3lEcDRFWDVFQ1pEZlBpb3JRbms5ZTJNUkIvNzlYOGtheHdHVFFrNWNOSXFt?=
 =?utf-8?B?YVluZnJNZzRyS3Zqa3hmYmU5bS9Vb0p1VjhvZENFcWRPdEZQYUJuOEo5WGR5?=
 =?utf-8?B?VzUxaHlWOER6UFZxVklkTENZY3oyc3N4cFA1YzZCQlpPQ0RpanJWQXYrZVJD?=
 =?utf-8?Q?FGSG9JhoRo6ec05Wv3uuwCpWf?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd274994-ce6c-49c2-19dd-08db9df4eaf6
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5040.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2023 01:05:44.4878
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LFa51CfA6OAE2im4wfmwW9JBZawpivLQxmRCVuyB8MnfX4JKd8dG+AYQw2WawefOfZllLrOVBAup6pcmJ9qsTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5439
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
	SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 09/08/2023 11:03, Sagi Grimberg wrote:
> 
> 
> On 7/12/23 19:14, Aurelien Aptel wrote:
>> Add ulp_offload module parameter to the nvme-tcp module to control
>> ULP offload at the NVMe-TCP layer.
>>
>> Turn ULP offload off be default, regardless of the NIC driver support.
>>
>> Overall, in order to enable ULP offload:
>> - nvme-tcp ulp_offload modparam must be set to 1
>> - netdev->ulp_ddp_caps.active must have ULP_DDP_C_NVME_TCP and/or
>>    ULP_DDP_C_NVME_TCP_DDGST_RX capabilities flag set.
>>
>> Signed-off-by: Yoray Zack <yorayz@nvidia.com>
>> Signed-off-by: Shai Malin <smalin@nvidia.com>
>> Signed-off-by: Aurelien Aptel <aaptel@nvidia.com>
>> ---
>>   drivers/nvme/host/tcp.c | 12 +++++++++++-
>>   1 file changed, 11 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
>> index e68e5da3df76..e560bdf3a023 100644
>> --- a/drivers/nvme/host/tcp.c
>> +++ b/drivers/nvme/host/tcp.c
>> @@ -49,6 +49,16 @@ MODULE_PARM_DESC(tls_handshake_timeout,
>>            "nvme TLS handshake timeout in seconds (default 10)");
>>   #endif
>> +#ifdef CONFIG_ULP_DDP
>> +/* NVMeTCP direct data placement and data digest offload will not
>> + * happen if this parameter false (default), regardless of what the
>> + * underlying netdev capabilities are.
>> + */
>> +static bool ulp_offload;
>> +module_param(ulp_offload, bool, 0644);
>> +MODULE_PARM_DESC(ulp_offload, "Enable or disable NVMeTCP ULP support");
> 
> the name is strange.
> maybe call it ddp_offload?

Agree. ddp_offload is a better fit.

> and in the description spell it as "direct data placement"
> 
>> +#endif
>> +
>>   #ifdef CONFIG_DEBUG_LOCK_ALLOC
>>   /* lockdep can detect a circular dependency of the form
>>    *   sk_lock -> mmap_lock (page fault) -> fs locks -> sk_lock
>> @@ -350,7 +360,7 @@ static bool nvme_tcp_ddp_query_limits(struct 
>> net_device *netdev,
>>   static inline bool is_netdev_ulp_offload_active(struct net_device 
>> *netdev,
>>                           struct nvme_tcp_queue *queue)
>>   {
>> -    if (!netdev || !queue)
>> +    if (!ulp_offload || !netdev || !queue)
>>           return false;
>>       /* If we cannot query the netdev limitations, do not offload */
> 
> This patch should be folded to the control path. No reason for it to
> stand on its own I think.

Agree.

