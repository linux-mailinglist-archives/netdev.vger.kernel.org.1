Return-Path: <netdev+bounces-31999-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5271792054
	for <lists+netdev@lfdr.de>; Tue,  5 Sep 2023 07:00:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30635281006
	for <lists+netdev@lfdr.de>; Tue,  5 Sep 2023 05:00:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F1FF657;
	Tue,  5 Sep 2023 05:00:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39B987E3
	for <netdev@vger.kernel.org>; Tue,  5 Sep 2023 05:00:14 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2049.outbound.protection.outlook.com [40.107.101.49])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F91F8E;
	Mon,  4 Sep 2023 22:00:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QGE4hp05udQKasuNqPuyACZNXrqfqKDXj1CUP72HWGGA35cdJv05tCs1u0irs3P34O7qIm/KVrd5YYZX+XZEz/VvEsTzlcpiLqY6QAz1XJ2ooAk2owtT8C8VVE1Brpkr92OKMqou9k3AL0nCc8VFRLnBddblaEz3nsofqYD+gYrk9ioFiYXRncv0Af7qBVkWRbujCtojQ0SZNlmM6sWb1CLQvt0QpAzdXyDBPRW6nbBm3mWVQCUZG5awpugrkraxQ8zW4AbZYDjPHYgX9MZVm8yVBqjeh0+x2hcHVyVXFVxMeSylMYZDsRLAatgZQfT2FKjOnUbF/xwBMrZ91xyXPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fBUrtZp1dUSQ0gLbEJuHgjlJfkzQejYmULTWO1xZ//c=;
 b=DkRTEcaDIMPj/0jiSIIiIxIO6O2PH6S4yGTwWZglp+v+klLbrlsVgcWBtqVabIGfwQjF9nnf4YnWwbtt0UZtUvauVBHgQzJWfSkUrGZ8gg2GTdWNDuFsp+WIFHnzKP5w3Tb0ean5Z0I93vYLCMmYo5p0TSsgdW32UGJvxnTM3iHg8yNAGDZvlK2AL/Kvv5n6p9HZS7YmSbN1z+Z7QQdgiNS0PIRcHc+KhsiHhwua8+EXqA8UvUqgViVSt4ex40s/edwBMitIbr9fRF+b2bTA3PcQNRMnJgKjVLUuZqi4TO//yYyFPl1AGAHs/G5Ry1jRlFGYOh0sRwc1NWQoVJcMGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fBUrtZp1dUSQ0gLbEJuHgjlJfkzQejYmULTWO1xZ//c=;
 b=EJL9pV4d5ULVltc589zZ2LD339eNoMzI33UnHZN10DryiFBCd1cjj0YoRsUL92RIAEuUmwRlu1H9NmQDv4isQkg7YHWjlVNM4CeMN2y3i32egxFdeU+/XoOOBYmVp3qRiKn5w74ibNKVbLdonczF9BOrJST8Zd+5x0aP28tbLSA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6583.namprd12.prod.outlook.com (2603:10b6:8:d1::12) by
 SA0PR12MB4445.namprd12.prod.outlook.com (2603:10b6:806:95::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6745.33; Tue, 5 Sep 2023 05:00:11 +0000
Received: from DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::5c9:9a26:e051:ddd2]) by DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::5c9:9a26:e051:ddd2%7]) with mapi id 15.20.6745.030; Tue, 5 Sep 2023
 05:00:09 +0000
Message-ID: <1fd3d0a7-e738-40dd-a9b2-37e2adacc01c@amd.com>
Date: Mon, 4 Sep 2023 22:00:06 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] docs: netdev: update the netdev infra URLs
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 corbet@lwn.net, workflows@vger.kernel.org, linux-doc@vger.kernel.org,
 intel-wired-lan@lists.osuosl.org
References: <20230901211718.739139-1-kuba@kernel.org>
Content-Language: en-US
From: "Nelson, Shannon" <shannon.nelson@amd.com>
In-Reply-To: <20230901211718.739139-1-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR17CA0058.namprd17.prod.outlook.com
 (2603:10b6:a03:167::35) To DS0PR12MB6583.namprd12.prod.outlook.com
 (2603:10b6:8:d1::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6583:EE_|SA0PR12MB4445:EE_
X-MS-Office365-Filtering-Correlation-Id: 6fbd3cc6-8b68-4103-f98b-08dbadccfa88
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	6oVo7pJwoghpDBz5dLUhimDWs9eoGCElw44F5M2lzGsmq8VKzZYUp6ytNzS2vrEMnZyI8NLwllN7NYakwoF4vpRTzInBtcRskhmfAuMEko/wu0kZTsu34zGGG867dWVopu5muFPEt8bykU/OOiwxbtsnlPAyfB8yjBzwWL/7kwL5apv4Ti6jhhA7h2iJEc8vz6ZVB1Np8aPsJMkCEXG02DHVJaUAdSC5IZfbRaP8nM/9DxmSt32ZVsJNupw/2ruVOi6jTOhrBvQrfVdYNMG/V/ak7A6MzmtOv9eoAyqcgDfMVY8NRCtH8aPs23SOVbdrNODurKP8h+1M9mhfKXWx162DJZ2Q/jynBJVeTLjfAEytxt7stUvO2P42jfb1ECiwdNCa+qu/nIVDTT1GqpD6eZ3vtnVfuLLrjH1YgNp2Y6TEURMDb6etTbLDTgMC0V1UmgQChU5gNFd7qrjvN+NSPFX5HSJH4Llz2xbvAEgoF2YP2aAizkJsMhTE4grGM8SyCu9wACmnHSE97hkot/eegZYQ8zs7fvBCg199PmSoS4zcDtDkpQ0ZTbWAARP1gzqCHwunc/8APBoEYr0DAARgSN+s/kk9nIgWTl6uj07ZMSX8FmWz5UMos0eukt0Te0I6
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6583.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(346002)(376002)(396003)(39860400002)(1800799009)(186009)(451199024)(2906002)(38100700002)(36756003)(86362001)(31696002)(6506007)(6512007)(41300700001)(53546011)(6486002)(316002)(66476007)(66556008)(66946007)(2616005)(4326008)(8676002)(8936002)(478600001)(966005)(6666004)(31686004)(83380400001)(5660300002)(26005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Qkkrd2FnUzJRS1Njc2RrbFdBd0FWalJDdUQxcEV4QU1SM0M3R0NLRGxIOVA2?=
 =?utf-8?B?NkNYTTVJNi9BR0lOOGF2UExUWXNjY2dFNlpZUVlscnR2ZVI0NTZxeVBKS3Rt?=
 =?utf-8?B?ZWYrdzJZYjBOZEY0N3dSY3BPVHh3VmQxT1RBMGxtRXY0MjBKME1WekJwNzRo?=
 =?utf-8?B?WFVMS0Jyd1c0SGZWRGVZR2dNN1ZWZHc0OTFZdkNRZXRWbWpsTjdYbmd3SzZY?=
 =?utf-8?B?Zll3TjlKeVpLSWhNQ1N6bEw5S2V2ZkRsc0dXUnZTSGU5bDcwMkVIeDRJdmNF?=
 =?utf-8?B?RVFlaUFXWWlxL1JRZmx0czhTa2dQejhpOWNXQzNLUnFSNTJWTlo1ZSt1ZmV5?=
 =?utf-8?B?cnBEWXhUN2wxbjlyakluQ1J0QUVuSXhITzRpYXJNclBNY3h5eDZlM2FWblEv?=
 =?utf-8?B?czZSdlZRUWM5Ui9CN1JWWldYTGxON2N1Z1dDZ1NRdEdaVDJMNTh5RTYwSUNm?=
 =?utf-8?B?aHV0d2c3cFp1UEF5bld6aWFXdUhvOW03OWpYSElHbWo5czVwdlFUWFVzbkR1?=
 =?utf-8?B?RkV5UmN1QitDNUVFYjhNQnBhN3pKNUwxS3JsdnVXdFlVekFHc2ZuTnVjY3JR?=
 =?utf-8?B?Q2pUKzQ0T3hLZy9nWTJFMXFwVGM1VFJ0cmh3akNKT3dTUjNlWkw1Sm96UFNM?=
 =?utf-8?B?NGEyZ0w0dUZSdlJDK3M4M1RLeUZoMmxEeUdQaXNVN09RSXdmV3RabUF3Vjkw?=
 =?utf-8?B?cXpMV3F3SVlMTWVTQUFTK21odkZlRFMySDlZZFRZQVFLa0VMd3Z3TCs5R1Jw?=
 =?utf-8?B?T1kwUnhuOXdob3Ztcks0UmQ5ZWxDM1Z5eEpLUy9CVmptMzF2cGYzS3BFNDZw?=
 =?utf-8?B?KytscXpQMHM0WUdqb0x4MTc1RlFUWGZ1Y0xvc24vZVNobzJuelZtNWY0SXpz?=
 =?utf-8?B?dWh5WEllQWZLcjljRlFHbGtpcVhMenhMMHNWb3FVYWlpalBwaWVjdUI3TTd6?=
 =?utf-8?B?M2JNWUhlMmZHSWVJS1I4K0tMUjdCa1VzZjh1UnZOTVNXUzNCVVUvTTNXcUJQ?=
 =?utf-8?B?MUZjQVpja0xYbEwyT0l2cCtPeWE2NHB4K0x5Z2d6K0lHc1IrM3Rya3lyRFla?=
 =?utf-8?B?UWFCZEpJNm9hZlhJTWQ1aW9ObS90ZmN6ODhhYzM1WmZ2V0tUeE9RQ01IRlkx?=
 =?utf-8?B?Z2NCLzAyNjNtdU5uR29uQTdibmNNYXNESVZYc0RTYjFlT1RlSThYQzJlY1Mr?=
 =?utf-8?B?NEVGWU9EVEVCMEtRekZIWWNwQ2kzYVp1V2FLaWtBMFFkVmlIdGdXT1hsM0w4?=
 =?utf-8?B?eHhFVWROUWRDb3B6NkYrOHBabEtCQjdMYjdRV2xRbktPSmhkeHVDZUlSa25S?=
 =?utf-8?B?VXlFckF2Z1JOa3BINHlTaWJpck11alliTC9zSnh1ZktkTU1VTFVFbFYvZDll?=
 =?utf-8?B?LzdDdEkrMWJIeHdxMzYzRGZVL3lGRHJIdFQyUlVTSlN4MW9aK3lKWlVOWEsr?=
 =?utf-8?B?dk9naWhQazdlNnF4U2JERWREWG9CdE0vTVpNQXBIbmdpTkoxTkxVekxTL0VX?=
 =?utf-8?B?Z1IzL3g4bU50R0p1Ly9SZDRmdHd5SndxTW90enBpaCtVQ3RzRU95VUM0cEt0?=
 =?utf-8?B?Q29ZeDhNWDRRVzl3MHlvNGJCZ0FFelZmM1lNQ0VLZW9ScUtTSE5FNjYwbW42?=
 =?utf-8?B?aEZOdFF0bHZ5dUZiUE9nTFVWZVdvY2VPRmh2NDhBQkxmVUJVRGN6V3dSZW5B?=
 =?utf-8?B?amY0eFd2WWZhejREZHE4Z0RSUnJEcHJrQWpGbmdidUtyU3h1QlRGYkloMm9V?=
 =?utf-8?B?cHNLenpSV1lwNzVwS2lkV0pFZnFQRVJVN0FXS2gwYXkwT01RQmdTdGdyZjVH?=
 =?utf-8?B?cjVRNnVWaVlvWG9tcnRGeUxpZEMyQmJ5T3k3MFBMUG1WQzZnZ2pOS2ZzUnhF?=
 =?utf-8?B?SWUrbmJEYmJpbjJUN2UxL0l5eWFBaVdRQ0lLQ01pemRsYXRMVmVtY1VqTTUv?=
 =?utf-8?B?RFFtTmtEaFk3aW9WcVdVSE1sL1BPUHZSSHl2ZFNrajAzbm91SGgycHMwSzYv?=
 =?utf-8?B?VlBxemRaaEpJdHIxdE1sMlNNWTdLWHFEMlpCUVcycTh3QmZYM0JTNUxrbnZx?=
 =?utf-8?B?VzJKT3ZSWk9JOFhyQk5keWxTOW1zc3dBbzZtZXl4dmlLdGtUSlpHRitEeER1?=
 =?utf-8?Q?adrfkOVap3V0H6CQCnRJMmEPJ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fbd3cc6-8b68-4103-f98b-08dbadccfa88
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6583.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2023 05:00:09.3664
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O148ZyF0hZJ1YeimIkZphuTYOMEa2w2ku+iNCGO/+CCYUA8Gqt6ERvL16+m9O3zPEQavmlvJsyqOe6rlXvF+Cw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4445
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 9/1/2023 2:17 PM, Jakub Kicinski wrote:
> 
> Some corporate proxies block our current NIPA URLs because
> they use a free / shady DNS domain. As suggested by Jesse
> we got a new DNS entry from Konstantin - netdev.bots.linux.dev,
> use it.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> CC: corbet@lwn.net
> CC: workflows@vger.kernel.org
> CC: linux-doc@vger.kernel.org
> 
> CC: intel-wired-lan@lists.osuosl.org
> 
> Please LMK if the old URLs pop up somewhere, I may have missed
> some place. The old patchwork checks will continue to use the
> old address but new ones should link via netdev.bots...
> ---
>   Documentation/process/maintainer-netdev.rst | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/process/maintainer-netdev.rst b/Documentation/process/maintainer-netdev.rst
> index db1b81cfba9b..09dcf6377c27 100644
> --- a/Documentation/process/maintainer-netdev.rst
> +++ b/Documentation/process/maintainer-netdev.rst
> @@ -98,7 +98,7 @@ If you aren't subscribed to netdev and/or are simply unsure if
>   repository link above for any new networking-related commits.  You may
>   also check the following website for the current status:
> 
> -  https://patchwork.hopto.org/net-next.html
> +  https://netdev.bots.linux.dev/net-next.html
> 
>   The ``net`` tree continues to collect fixes for the vX.Y content, and is
>   fed back to Linus at regular (~weekly) intervals.  Meaning that the
> @@ -185,7 +185,7 @@ must match the MAINTAINERS entry) and a handful of senior reviewers.
> 
>   Bot records its activity here:
> 
> -  https://patchwork.hopto.org/pw-bot.html
> +  https://netdev.bots.linux.dev/pw-bot.html
> 
>   Review timelines
>   ~~~~~~~~~~~~~~~~
> --
> 2.41.0

Yes, thank you, this works much better through my masters' filters, both 
here and through the patchwork links to the test result details.

Reviewed by: Shannon Nelson <shannon.nelson@amd.com>


