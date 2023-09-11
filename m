Return-Path: <netdev+bounces-32940-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 276EF79AB42
	for <lists+netdev@lfdr.de>; Mon, 11 Sep 2023 22:42:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4AD42813F3
	for <lists+netdev@lfdr.de>; Mon, 11 Sep 2023 20:42:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 299E25380;
	Mon, 11 Sep 2023 20:42:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12DB23C00
	for <netdev@vger.kernel.org>; Mon, 11 Sep 2023 20:42:01 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2089.outbound.protection.outlook.com [40.107.94.89])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 831F9101
	for <netdev@vger.kernel.org>; Mon, 11 Sep 2023 13:42:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OD9iknJeNhD/A9rXnUHrByH//yxRG+oa1sYeUj/h54tKNpPe54thvGURSrh6BgRSmYcqT4it5pMuRukcYDxnfefWQ91XtqjpaGZV8VT0yUVOCJim+sbUV8uQtVJlVI+Nh+Nydo97u38EqOMHL0Y2qDnvmXQPzXKlmkM/1MbK8wPgYrB7MopNXL173EkYBxp/1bVPtlKZQyHsXcCdUd3IV8/urhsWVPcR4Y0Cp1Y2EoxGb3/8UEyXFyrFtiD+bRkfxMcMqYAgPSNtvJUBp10Yi7m4s26mVvwNEWkUcylh+7O4scQyvZmBFi+mTB3B2+oBvXbcppYDKM1VRw3diiZPXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Thk1SqWZoYc8AURIMieFNqAHp2OgUKgB7vKP9QSiPGg=;
 b=UdkRB37EN7FBJT5uwlzW5DHSuFEatAPMejYqyvbthbnvsnLVXowdV0QvWsAS6N5NGx3y6jZfMGKR7veECFIfgEuljGZSyLCJiGKhHi78YFZ00xXWa1Kv3x79dsxnrp0WR0RMxsIIdXls3DjoTCiLgS5NS42N9gf32xAP17FhZtIu8dGBKOAPoNK0oNgUzf55K00EEYXZSiCK7cudDsAtDrsFlZNjbJSiAP9h76Jd2r4Wg6yybaG2IMRsL8Vj0snmQk9uEJbMA0nJ39lvHdTtZLcmNQ7znF3t6XDClXxOUE4AWtESJPS3UDuRQRemWx0aqX6/0d0IIxTt13xIDdKWEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Thk1SqWZoYc8AURIMieFNqAHp2OgUKgB7vKP9QSiPGg=;
 b=Hi73+Y54wV0scYyntd/DYktY272ej6QBuI4VTzyicTp+1b4RrobqXPzIoPT+O7CNZ56jZ1O/PcgvJjxpj9v/z0Hh1PsLdvNkl6Eknrv2gKKV6heTpMIDMtJp8sAUeIekMPltA2OfOAL9Xj80GiG2h1F961Dt5nNqPCQIcn39fqM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6583.namprd12.prod.outlook.com (2603:10b6:8:d1::12) by
 DS0PR12MB7803.namprd12.prod.outlook.com (2603:10b6:8:144::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6768.31; Mon, 11 Sep 2023 20:41:57 +0000
Received: from DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::5c9:9a26:e051:ddd2]) by DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::5c9:9a26:e051:ddd2%7]) with mapi id 15.20.6745.034; Mon, 11 Sep 2023
 20:41:57 +0000
Message-ID: <fa139383-6522-44ea-8f31-84161d60bde5@amd.com>
Date: Mon, 11 Sep 2023 13:41:54 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2 1/2] i40e: fix potential memory leaks in
 i40e_remove()
Content-Language: en-US
To: Tony Nguyen <anthony.l.nguyen@intel.com>, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, edumazet@google.com,
 netdev@vger.kernel.org
Cc: Andrii Staikov <andrii.staikov@intel.com>,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
 Simon Horman <horms@kernel.org>
References: <20230911202715.147400-1-anthony.l.nguyen@intel.com>
 <20230911202715.147400-2-anthony.l.nguyen@intel.com>
From: "Nelson, Shannon" <shannon.nelson@amd.com>
In-Reply-To: <20230911202715.147400-2-anthony.l.nguyen@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR17CA0052.namprd17.prod.outlook.com
 (2603:10b6:a03:167::29) To DS0PR12MB6583.namprd12.prod.outlook.com
 (2603:10b6:8:d1::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6583:EE_|DS0PR12MB7803:EE_
X-MS-Office365-Filtering-Correlation-Id: 8bd681c7-795a-4d3b-a47d-08dbb3078a92
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	RL0Q+PdAqXrylKZIYazWkJxGvnnM+YJMoxq00tjtKNkeg2kZ+dr5OKIUtTWZnrZC25Vov1LFnJoqts7aX+7F7to+ceOLnOwgWOnZWvy/6wkpIDJne9G8d/aA58U2Gauh4BGhAPxFV6g5Zo8ta1n4IAK8MYdLgJiuuYGN76Juig1cQgpCSQCMDCmu4s7l/E8fReJYWrKmmDHB9gDj2gHeUpNKeo4qw3f6qAYDqN4lrbl6tNWeDJBpaxOfK4Ka3EqEcXU0tW/zX4YCZztZiYrQQQtAzTsP2y2wET9DDZ/Yr5sp976PLRWG1sRGcJYxiZpBfdOuMvy02Bhzxn5vOp6aoPge3EGM2+bg6Jvpn8GzR5InlePbdhE1Wv0g+Yk2bY1aFqcOLR/LpAJdKDNfgUpCwwsEBZkT3tX1dXqLNdZv9jmdK8nATSWcbFOCg0rwlkGD8b/BpJwjfiMt1HrRNCJ6olPUszLwXsbWPX5o/4Enxl7eW1a18qQQTN5/PqtjjFTWTMyLIoK3OVdydx5eGHT51t4GUeHsZOdZDF3QwBLWjrr045JFre7MOldC4BRiB7Kiqnp/t/ruCdUvBkGClFfJkUbSYDIvKIWUMm/9Bc5cVRCkWKWPgoA1oY35yzc2lBMxPO1zPa1kOOrYLlw6hHkx6A==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6583.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(366004)(376002)(39860400002)(136003)(1800799009)(186009)(451199024)(6666004)(6486002)(6506007)(53546011)(6512007)(478600001)(83380400001)(2616005)(2906002)(26005)(66476007)(66946007)(66556008)(54906003)(5660300002)(4326008)(8676002)(8936002)(316002)(36756003)(86362001)(31696002)(38100700002)(31686004)(41300700001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TXQvVHc0R0dOMUdKV1lXdWdoZzVZUUk2VTNPUUlJZVZucnQyUDMxTnk2c2JV?=
 =?utf-8?B?NWk5SWs5VTA5cEgzbmVWY3JmZlFZVGtzdWVDTHZjQzByUVYvaGU2U0RIaWFV?=
 =?utf-8?B?L0ZFVlZiZ3kvYXJGWEZCQ2RsRGhFTXliWGJtcmJnclRqNUpFaUlreklRVzRS?=
 =?utf-8?B?blRKZG1jdHg0SzdqNlIxdklVakM0QTJqd3lqc0xVV1dNTUN6N2JReTI0Zlo0?=
 =?utf-8?B?blIxV01OTm9yMmhtcGVMc3NMOW1seG9zUy9UanRXVTcwaXI3SHZzeUx6OVBO?=
 =?utf-8?B?OU9hTFlsR1h0dGNOMmg1WFZ5NHZhMTlXbk5ENzJOSFVTK0FubGRIZjFPSkZy?=
 =?utf-8?B?ajhqWWdTVXRNWE43RnFxSFVDL3RaTXNhV3RPa0MyU0dHR1JwWjYzSkhnUDFz?=
 =?utf-8?B?U2t0d0xvMzcrbnVXMndDanVteWtiV1VPN3d6Y3A1MERWeWFSQXJVLzEySmpN?=
 =?utf-8?B?UExMb1EvekttMFFxQUFPQ1BYWGFzYVgyV01YclZIYXE2L1RVYWFHSE9WSmtv?=
 =?utf-8?B?N0l6ZHdsNVMyU0c3aDlQUDhEQkxxSWo1SjBZVXRzT2xyalRzOXJYZlRiRlBZ?=
 =?utf-8?B?NmFsVkVVRWxERnZkTWNDeXhXeWdHa0pHOVI2dXYzd3pHOFNzY3ZlU0lqNGpG?=
 =?utf-8?B?VXVoUkZyODdsR2h3NjNFbzlBbFJCa0lzcFVqUWZXdUlzY1FVSjFYbGtsZkFZ?=
 =?utf-8?B?MG5QQlZkNXB3N3h3dlhvNHpwYWtlWGQ1bmtSU3I0NExWZk4zRG1JU2dzTlVV?=
 =?utf-8?B?bTdSdTNEa08yMjB2MVpSQ2V5SHA4dEwvTFdpUzZjRHFaZ0xzcTNTOVZJVFRO?=
 =?utf-8?B?ZWk0ZjdmcFd5eUJnSkc4ZHJEY3NUOGNTYjJhcGpFRkJrN3dvN1llZHZ6N1o0?=
 =?utf-8?B?Mmk0WE1SZmlWZnJZMEEwV0hacW16QzhYZ1dSQldWQnh4bXB3cjNlaGpXYmll?=
 =?utf-8?B?NStWaTJjR2xEalpKRGVlN3RYbnZpSXk0VHdSZjF4RGJ0YjY2MDlZY0IzejZV?=
 =?utf-8?B?Z1JqdURrTndVOGdUbEM1eDFvakdteTM4d3ZUT2gyNUY0LzFwN3BOekhwTXhZ?=
 =?utf-8?B?OWNJaDRZMWVTNjJiTGZRc1JmUGwyeVJEejhkOG9mWll1bHVIT1VQemJDbVYv?=
 =?utf-8?B?L2JEQ0dkSm9VNmtFalpNUGREdU9rVTNQdkRXSTlpZWdtdXNZN2hIRnlna3JN?=
 =?utf-8?B?OWxJb0RTemUrUUFoRjR1Ulc2ZWlZWjZ3R0RKb3FpK0RvV0dQOUFZRUZONW5Y?=
 =?utf-8?B?bmdlb2FmK0hqV0tYaldURVpjeWgwaW5GYkU4dnRvRzJzWFJ6NjdxMFp3SnQ1?=
 =?utf-8?B?cjdwSUl1V2dkbk82OG5HSURFeklxVmdPNjB5U0NNb0dWdi9pSWU5SEJlOG1M?=
 =?utf-8?B?dTM2VG1IdkxQTklhbDlXMUFXMFN4WVpyenMxa2lVN0RJK1ZZQUNwS3B0UWxV?=
 =?utf-8?B?bTdtOFBXZDZub0ZPcm5NZG1rdC8vWkpZK2dVYmtQKy9wcWFBMnc3UUJCc3VM?=
 =?utf-8?B?OTQ5QlkrOVdnRWNDV3FGcEYwclY1Vk14WEl1aWpQWVdWT0JOQm9HZXBmK0tz?=
 =?utf-8?B?SE1QcitlcXVPV2FjcERoVjVNaEVKNGczWWtBU21PS1NaQkxjY3VNb2NsajJU?=
 =?utf-8?B?b2xrOS83WmVhWXJIUDQwS1BhOXhMMTR0REpwSkN6WUVFbDNpdVhaa0tLMHBu?=
 =?utf-8?B?U3E4YTcrbE1TM3NBeXB4SXFFZzlTSWRyK0JybkI1cmI1MmdVbW8xSEtnOWJN?=
 =?utf-8?B?QWpHYXNxdno3SlZOM3JlWUxTM1dDeGFTeGNmZ1NoVzRDZUNGcHlEbFRYU1dm?=
 =?utf-8?B?STRJdC9oaE5HcmlUWWVqSmJ2VlVFdExtancza2phSGZwZllxRHJOK0lyWWh1?=
 =?utf-8?B?V25MN21kb2FTeTdLdnpYVVc2ZGNZajJzT3g1MEw0dHg0VjlGeEhDcnhlT3Rj?=
 =?utf-8?B?ZnNNbEVTNHRvekFOdU5rOVlWOEwwZnhpdGNRay9McGVzSzRyWm50Y1A2enJq?=
 =?utf-8?B?Q0pIeXNuYmVBWkVHT0UzeEkvbEczU3lIcnJHeThzRzlhcjF4VGtJYTlOeDJM?=
 =?utf-8?B?N295MFBvQTYyVzdWOE5PRVltK1dFT3ZQZnljUjdpNS9tUzR0R3FPOTM1ZnA2?=
 =?utf-8?Q?ZTNbPnaT+WUsL1+gy/3/PPlIV?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bd681c7-795a-4d3b-a47d-08dbb3078a92
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6583.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2023 20:41:57.5683
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UL0aPSlwmvG7Qun2fXtSdtFgYFOwpzW5xZqOzB/7C7xdRiVcHsSspcX/iA0VdgZ4O7BTlf+Q0mmEV8CBqhoZiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7803
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 9/11/2023 1:27 PM, Tony Nguyen wrote:
> 
> From: Andrii Staikov <andrii.staikov@intel.com>
> 
> Instead of freeing memory of a single VSI, make sure
> the memory for all VSIs is cleared before releasing VSIs.
> Add releasing of their resources in a loop with the iteration
> number equal to the number of allocated VSIs.
> 
> Fixes: 41c445ff0f48 ("i40e: main driver core")
> Signed-off-by: Andrii Staikov <andrii.staikov@intel.com>
> Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> Reviewed-by: Simon Horman <horms@kernel.org>
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>

Reviewed-by: Shannon Nelson <shannon.nelson@amd.com>

> ---
>   drivers/net/ethernet/intel/i40e/i40e_main.c | 10 +++++++---
>   1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
> index de7fd43dc11c..00ca2b88165c 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_main.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
> @@ -16320,11 +16320,15 @@ static void i40e_remove(struct pci_dev *pdev)
>                          i40e_switch_branch_release(pf->veb[i]);
>          }
> 
> -       /* Now we can shutdown the PF's VSI, just before we kill
> +       /* Now we can shutdown the PF's VSIs, just before we kill
>           * adminq and hmc.
>           */
> -       if (pf->vsi[pf->lan_vsi])
> -               i40e_vsi_release(pf->vsi[pf->lan_vsi]);
> +       for (i = pf->num_alloc_vsi; i--;)
> +               if (pf->vsi[i]) {
> +                       i40e_vsi_close(pf->vsi[i]);
> +                       i40e_vsi_release(pf->vsi[i]);
> +                       pf->vsi[i] = NULL;
> +               }
> 
>          i40e_cloud_filter_exit(pf);
> 
> --
> 2.38.1
> 

