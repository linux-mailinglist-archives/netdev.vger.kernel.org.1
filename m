Return-Path: <netdev+bounces-23383-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2519C76BC21
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 20:18:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4384B1C20FFB
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 18:18:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99405235B7;
	Tue,  1 Aug 2023 18:18:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ED3623589
	for <netdev@vger.kernel.org>; Tue,  1 Aug 2023 18:18:20 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2061.outbound.protection.outlook.com [40.107.94.61])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C7192130
	for <netdev@vger.kernel.org>; Tue,  1 Aug 2023 11:18:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dCG9lVs22neabJNt6xQhyV5HNtnTaXgbsKCusnZo3OGUpEZHFJ0P7ALEfzdIbuUdDJuGGXGFmBGa5Dh1vHMyccoHYH4XWIhf5y0GzehqV+6Qt82PFJ9BSmIwWVF9cj8XoTDwmh5JWKtWYM+p9W0GsYMHDfsozGYs4aXyPpt4rVfjqxCNFJ2rta/nHeFTaLlGIRGcvMMwBjNosdaRuvmXU2cJr48bweT4gZqRClypo8iTTzL8UKiUfBBtWp+IH0gG9GyOXjFz3FTMFiNQLhdgP4gEeuPBsI5evaN4JomJj3BssTrKO7V+93NEsTsklniIs+bx0EklmI8rYSCu0H0tAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wVT4XixpGbENnejU7ky6YdR+0+AsXE2vczb8ebTe3rI=;
 b=MalMm9U9QY/AgB9zXsc/1wHqdf25nwFh88uzCkYzaTNOq+iDwIOPpp2xW2+O8s0qgUVcfgbJ5kJ98Xe51vjy14BRjpuE6SUePeDa05SJZtEpHcNesLx6FYYilKscM0UOm+6AzjmlT4DK+dC6fgy80PNGjRhcXS1JbusZojWvEs0EmKNIL5/0AnKHPauxrRqitmqR3cmq+mmSUn2OhwOrUE2CzaJ7EUZlg0AtG0L68Ujewn7Z7agCiT31H6jQbt949c9pkzoHgNR95qEvbyl14v6tlVCS+eG/2pbnALkhD7JiTD2weizn9cFtBXaFtY9fGGiq97MAj/E4yav1WFj9QQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wVT4XixpGbENnejU7ky6YdR+0+AsXE2vczb8ebTe3rI=;
 b=iQdHz5YQlJ1UhHsEcwW1kBb+60/6+juQ0DWE+lonciLj1cfJz9iBjVSZsbZ7G5Rm1rTxp9dEBHIfHmHaNkH7N6L7ei8EMKXQrZ/hjFfEJFEMbXo8PjbtFa+bYX+fakeVZrmpULi6kpmclM6/LHSgi+kCaY0kcWMd2ewstzpcw/Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH0PR12MB7982.namprd12.prod.outlook.com (2603:10b6:510:28d::5)
 by DM6PR12MB4106.namprd12.prod.outlook.com (2603:10b6:5:221::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.44; Tue, 1 Aug
 2023 18:18:15 +0000
Received: from PH0PR12MB7982.namprd12.prod.outlook.com
 ([fe80::6872:1500:b609:f9cf]) by PH0PR12MB7982.namprd12.prod.outlook.com
 ([fe80::6872:1500:b609:f9cf%5]) with mapi id 15.20.6631.043; Tue, 1 Aug 2023
 18:18:14 +0000
Message-ID: <178679d2-938f-3d7d-f03c-2c0210288099@amd.com>
Date: Tue, 1 Aug 2023 11:18:12 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH net v2 2/2] igc: Modify the tx-usecs coalesce setting
Content-Language: en-US
To: Tony Nguyen <anthony.l.nguyen@intel.com>, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, edumazet@google.com,
 netdev@vger.kernel.org
Cc: Muhammad Husaini Zulkifli <muhammad.husaini.zulkifli@intel.com>,
 sasha.neftin@intel.com, Naama Meir <naamax.meir@linux.intel.com>,
 Simon Horman <horms@kernel.org>
References: <20230801172742.3625719-1-anthony.l.nguyen@intel.com>
 <20230801172742.3625719-3-anthony.l.nguyen@intel.com>
From: Brett Creeley <bcreeley@amd.com>
In-Reply-To: <20230801172742.3625719-3-anthony.l.nguyen@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0032.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::7) To PH0PR12MB7982.namprd12.prod.outlook.com
 (2603:10b6:510:28d::5)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB7982:EE_|DM6PR12MB4106:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c058274-f7a2-4eb3-1403-08db92bbac17
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	OnS7xQIhuG6qOuReDu5r1vu7IYOX+VvWKODAv1zjVeNoe1lB9aj3m6w5aPUPbhjzVEjncpNW5s78py6fFfix5yJDXe4G4XU9j9StnFj9rH1eI7nALl+87TijiJhs8dUNOZuQl+8ym/gkVonPOOvf8IB5RdMBZ49Z223lKpHGzlfkleQOxk3G44VouUkY4sks+w90dMNCZ2INTspl58MLzjNJ9cDN3VNQJBjhFWEkZoJI4sr4SQPP8ohnpi4WFpSGXYmVfCLH2Po3t8ufEWggVePZcMlE4npg9ktzEbe4z0chm1rJ2QXBaFSE4TUKCV9coT1HjjyQ4u2amXHBDtbjeXIIrkNlC9nMEQt7qZz1RbEBnrHcuOqjjwahx/lACxCqOmjjv7eGZApf829fLNRNuHYJDA65k1AxDf3Z8DVUBZgDnkCpfuZlF8/+Jnkdjig0LstT99xTyLhGhcf7DumGOcKDM7NUemm0INCoZCdF4AXcPKb8BWEq0OORIq79S9Dx+jjgzHuxdsxEaHyWihy2k4kjAAOL6rjeQO3uBqqKmFz5fE101qY//Nyp/aTGbGCqRGNO2jz5MKcFllpNffV10zxwcY7c+hBAEv9+/cUM13wb7W/l0ZmQHaTFxfNVhs41ceyLodls31eoWaBZUrG4MA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7982.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(366004)(39860400002)(376002)(396003)(136003)(451199021)(8676002)(8936002)(31696002)(38100700002)(26005)(41300700001)(2616005)(83380400001)(2906002)(36756003)(6506007)(53546011)(186003)(5660300002)(4326008)(66556008)(66476007)(66946007)(6512007)(7416002)(31686004)(54906003)(478600001)(6486002)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YkJYUVI1YkJOWlE1VFV0eXhkTTI3VndDSnRpZ0JhL0hzNU9Wb0lnV3hnL0N3?=
 =?utf-8?B?eUZQUmZtSUlGODlCRGdkUHpUa0ZvZWlhY2R6VjhtZ3Vha2hCanFmdzd4T2NU?=
 =?utf-8?B?UUtMWnFENGk0c1poZFlJWlBTbDVvNUtHRmFwSXBselEwV3RMMkpiMlRPcHhr?=
 =?utf-8?B?NEgxT05FelNhVjU0TzgyanlMK2Mza2ZOT1oxNzVPQzlLbTQ0T2xFaHc1ak5p?=
 =?utf-8?B?U1Fsa0RGQzc4YnN4VWNCclh0Qk54VkN4OFpKanRBTlFoOHArbWlyWENPRU42?=
 =?utf-8?B?eVBZRHE1M0o5M3AreHR4emIxVm56VGEzUVVGMlY4Q252SXpudGFDRFdPQWdB?=
 =?utf-8?B?NVJnMXlsczYvbk5CSzZYeWlNZW50N2dpdTIvcHZmeUpFc0xTeVVaWEdQN2wr?=
 =?utf-8?B?dTVxaHlDWitPMWJQZVpCcUlFTTF1MlFOK3B1Z1RodmJRdFFuTnNFemhScFlr?=
 =?utf-8?B?QVVSZFMvak04MUNPdlJ3d3VlV2I2VTB6dEpwL2gvWHlXVXFjYmdlYy9uZkdR?=
 =?utf-8?B?MmVsRllRUjB5T2JWY1hDMjQ5eWxJY1NDcW9QcXJPbndSd2x3QzBYcGpqTnRk?=
 =?utf-8?B?R2ZMWkxqbms4TEVtenNiTUIyVXBXdlBhY0hyM0g2NWh1UDhZcUpub0o3Z29z?=
 =?utf-8?B?UFhFVTMzdW5NWEZZUGVLRzhiVE53anIzNlFsRGRWN1VJc01kZ3gveFFNd3M2?=
 =?utf-8?B?dWVBNVgxRGtYK00wb1pleGdGWFNtQm5uQ0J2YXJIaUs4bmd6dzlPYTNuVURI?=
 =?utf-8?B?ejhyZUl4WnZsZGVmTE1LZUNqVUhXeHcwTktOdWlvSW1TNWpSZjRTM3lvTVZp?=
 =?utf-8?B?UzBRdnlkUjRjSzFuYmdocVJtQ2VlSFJwTHB5ekwwRzZFcDZaWnE2NGdNY1Zi?=
 =?utf-8?B?ajNqUkdrRFF1RVhMQWU0aldWQlZyQTV1eVRDYzAxZXA3eWZuTHc1NXF6ZW43?=
 =?utf-8?B?ckhsQm0vZ1lQMk8yTjVxQmZ0YnQwWTBUUWVwTHpmN0pibFFwR3Z3TFhWS3lP?=
 =?utf-8?B?UWlNQk1EbXRiV3M0eDJscDQrV3NGd0FGRmdzcjF2UWJmN3B3QWcxTzVhVEZp?=
 =?utf-8?B?VHlkdXVxRk9hY1B3ZFgrTHZ2eG1UY0F2UjNHWEVaRU8wRVQ4M2YxSjB0bjlO?=
 =?utf-8?B?TlhjZTFLMExzbmxzU05yZndzbFNBR2J3YkFwdUZ4YWNldnpRTW9aU2YxL0hE?=
 =?utf-8?B?M3l0SXNmRkxabEFOUDE4ZktpcDIzMmJ5MDJxakxodEJOanhUdUJaSXpxQnVK?=
 =?utf-8?B?M0RlalNCc0lWelNNWjZDVG92MEpYYm13TnlGNGh3OGdpZU1WUURwTHcyRGlk?=
 =?utf-8?B?WFFtTDJLSk9iWGF5QjFucmpBVDNweWFsMEpGNVdFTFJkZmcvZDByTTZwbXFl?=
 =?utf-8?B?YTVFMy9qUlZPMWtzSVNLMVNLNTlPM1M2cXQrd0lwYWF0M1gyTGRIZVJTNVNL?=
 =?utf-8?B?NkduQlE1UmJOeTlwT1RnYmlFWVQ1RC85bGNpVVhZVVhHTTN0WVNXZ0RZU0hK?=
 =?utf-8?B?VlhnOUtEQzhkUCtKY085cnpVdVRMS1FidFlESTMxZjVHUnlTaVRXM1cwYjRo?=
 =?utf-8?B?SmFjYXNyYVZsY1JnSU43cWNTbmQrVWtJYk5DVlRpYlpuQXdUYnYxM3hwUkpK?=
 =?utf-8?B?ZTgrV2lnM3BWRHZlV3QxVkx3RVdsUTJ2SitWL0E4UlZ3Vk11TDhYcTFMTVp1?=
 =?utf-8?B?QWdpdnp5SFh2QVpyV2N2aVlrTG1TS1RqaUhBR3QwcVJDTVpIMnpoakIyNlpq?=
 =?utf-8?B?dVlHRXZmVXBGelNUbDJqSmcrWlYxOTRiTEZFRmIwc3J2bGIyS2FHK1JweEht?=
 =?utf-8?B?R3Nsa205MFltWU9IUHg0U3dDZHdNTEFjeFB2SGJiVytxWVFqUHJhTTJjaHVX?=
 =?utf-8?B?b09NSUpFL1NFNzMvdkcrYytmNk5UcHpQbWgwU0RkSkxkVE9qeFpPOVRObTJu?=
 =?utf-8?B?c2lGcUZCWGRYckRaNmNqRWNYWmE5cUFobnFzUjRpcGhpWWZFVEVKNkRtbkNu?=
 =?utf-8?B?UU1LbjlIL0pCdU1HNDFKNFp2SGxheGZBVFpMcVZteG9SZWNsc1VEU2h0ZllZ?=
 =?utf-8?B?bUMreFcyclJEMUxFenhsRVFpLy9oWmZDcGQ0aTRscHVxb0VndTFnY2ExSFZr?=
 =?utf-8?Q?owF4uy2ja6LH2APgbSepuDCBg?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c058274-f7a2-4eb3-1403-08db92bbac17
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7982.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2023 18:18:14.7935
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JOIwLlma2Ffdci2IExY89CdsKsVjlvFOykQAolyrqtoRHQXfNYLgl26hfNZdXxE8CDU9pHZ3PJtUHxMvV4S0KQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4106
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 8/1/2023 10:27 AM, Tony Nguyen wrote:
> Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
> 
> 
> From: Muhammad Husaini Zulkifli <muhammad.husaini.zulkifli@intel.com>
> 
> This patch enables users to modify the tx-usecs parameter.
> The rx-usecs value will adhere to the same value as tx-usecs
> if the queue pair setting is enabled.
> 
> How to test:
> User can set the coalesce value using ethtool command.
> 
> Example command:
> Set: ethtool -C <interface>
> 
> Previous output:
> 
> root@P12DYHUSAINI:~# ethtool -C enp170s0 tx-usecs 10
> netlink error: Invalid argument
> 
> New output:
> 
> root@P12DYHUSAINI:~# ethtool -C enp170s0 tx-usecs 10
> rx-usecs: 10
> rx-frames: n/a
> rx-usecs-irq: n/a
> rx-frames-irq: n/a
> 
> tx-usecs: 10
> tx-frames: n/a
> tx-usecs-irq: n/a
> tx-frames-irq: n/a
> 
> Fixes: 8c5ad0dae93c ("igc: Add ethtool support")
> Signed-off-by: Muhammad Husaini Zulkifli <muhammad.husaini.zulkifli@intel.com>
> Tested-by: Naama Meir <naamax.meir@linux.intel.com>
> Reviewed-by: Simon Horman <horms@kernel.org>
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---
>   drivers/net/ethernet/intel/igc/igc_ethtool.c | 49 +++++++++++++++-----
>   1 file changed, 37 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/igc/igc_ethtool.c b/drivers/net/ethernet/intel/igc/igc_ethtool.c
> index 62d925b26f2c..ed67d9061452 100644
> --- a/drivers/net/ethernet/intel/igc/igc_ethtool.c
> +++ b/drivers/net/ethernet/intel/igc/igc_ethtool.c
> @@ -914,19 +914,44 @@ static int igc_ethtool_set_coalesce(struct net_device *netdev,
>                          adapter->flags &= ~IGC_FLAG_DMAC;
>          }
> 
> -       /* convert to rate of irq's per second */
> -       if (ec->rx_coalesce_usecs && ec->rx_coalesce_usecs <= 3)
> -               adapter->rx_itr_setting = ec->rx_coalesce_usecs;
> -       else
> -               adapter->rx_itr_setting = ec->rx_coalesce_usecs << 2;
> +       if (adapter->flags & IGC_FLAG_QUEUE_PAIRS) {
> +               u32 old_tx_itr, old_rx_itr;
> +
> +               /* This is to get back the original value before byte shifting */
> +               old_tx_itr = (adapter->tx_itr_setting <= 3) ?
> +                             adapter->tx_itr_setting : adapter->tx_itr_setting >> 2;
> +
> +               old_rx_itr = (adapter->rx_itr_setting <= 3) ?
> +                             adapter->rx_itr_setting : adapter->rx_itr_setting >> 2;
> +
> +               if (old_tx_itr != ec->tx_coalesce_usecs) {
> +                       if (ec->tx_coalesce_usecs && ec->tx_coalesce_usecs <= 3)
> +                               adapter->tx_itr_setting = ec->tx_coalesce_usecs;
> +                       else
> +                               adapter->tx_itr_setting = ec->tx_coalesce_usecs << 2;

It seems like this if/else flow is duplicated multiple times throughout 
this patch. Maybe it would be useful to introduce a helper function so 
you can just do the following:

adapter->tx_itr_setting =
	igc_ethtool_coalesce_to_itr_setting(ec->tx_coalesce);

> +
> +                       adapter->rx_itr_setting = adapter->tx_itr_setting;
> +               } else if (old_rx_itr != ec->rx_coalesce_usecs) {
> +                       if (ec->rx_coalesce_usecs && ec->rx_coalesce_usecs <= 3)
> +                               adapter->rx_itr_setting = ec->rx_coalesce_usecs;
> +                       else
> +                               adapter->rx_itr_setting = ec->rx_coalesce_usecs << 2;

Seems like the helper function could work for both tx/rx:

adapter->rx_itr_setting =
	igc_ethtool_coalsece_to_itr_setting(ec->rx_coalesce);
> +
> +                       adapter->tx_itr_setting = adapter->rx_itr_setting;
> +               }
> +       } else {
> +               /* convert to rate of irq's per second */
> +               if (ec->rx_coalesce_usecs && ec->rx_coalesce_usecs <= 3)
> +                       adapter->rx_itr_setting = ec->rx_coalesce_usecs;
> +               else
> +                       adapter->rx_itr_setting = ec->rx_coalesce_usecs << 2;

adapter->rx_itr_setting =
	igc_ethtool_coalsece_to_itr_setting(ec->rx_coalesce);

> 
> -       /* convert to rate of irq's per second */
> -       if (adapter->flags & IGC_FLAG_QUEUE_PAIRS)
> -               adapter->tx_itr_setting = adapter->rx_itr_setting;
> -       else if (ec->tx_coalesce_usecs && ec->tx_coalesce_usecs <= 3)
> -               adapter->tx_itr_setting = ec->tx_coalesce_usecs;
> -       else
> -               adapter->tx_itr_setting = ec->tx_coalesce_usecs << 2;
> +               /* convert to rate of irq's per second */
> +               if (ec->tx_coalesce_usecs && ec->tx_coalesce_usecs <= 3)
> +                       adapter->tx_itr_setting = ec->tx_coalesce_usecs;
> +               else
> +                       adapter->tx_itr_setting = ec->tx_coalesce_usecs << 2;

adapter->tx_itr_setting =
	igc_ethtool_coalesce_to_itr_setting(ec->tx_coalesce);


> +       }
> 
>          for (i = 0; i < adapter->num_q_vectors; i++) {
>                  struct igc_q_vector *q_vector = adapter->q_vector[i];
> --
> 2.38.1
> 
> 

