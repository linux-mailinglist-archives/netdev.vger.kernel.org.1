Return-Path: <netdev+bounces-51301-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2362F7FA05B
	for <lists+netdev@lfdr.de>; Mon, 27 Nov 2023 14:10:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D350E28154D
	for <lists+netdev@lfdr.de>; Mon, 27 Nov 2023 13:10:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31D352CCBB;
	Mon, 27 Nov 2023 13:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gpOST3cH"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFA8FC1;
	Mon, 27 Nov 2023 05:10:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701090613; x=1732626613;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=blfYEjkxfep7fadbGGc2jAG66lHAsYExJfHxzzlxyxM=;
  b=gpOST3cHMcbcmzWsNZ6VeN2vdP2zHlLQeMWLMR3s89XNvNG1kHV8f2i+
   WGLTfKfb56uGykan05ZAeYvTalk7KHrMK6n80nJ3M2YZ+Ak5mX0fLglGg
   gVfuGpGwF7vR3wg64JrvtYr94QXosxDExrtu67LOkVjxBYFaiwHQGHKBe
   pEwL1g0h03mZN3b4h5F2PpAa2uOMUEi+Qb2ZWRTKNtzangQuMWYB6OF8E
   NP8mvrY0AX5J6CmEkTPEJ90vHNK1Ww2n3p/VKb+81yE62Np/B4iceJuCw
   lGgbiyODChA+ECbaAhJfQk+xrYqIDjvSGGo3BHTsw8AG7re0uMmUsM6rg
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10906"; a="457030977"
X-IronPort-AV: E=Sophos;i="6.04,230,1695711600"; 
   d="scan'208";a="457030977"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2023 05:10:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,230,1695711600"; 
   d="scan'208";a="16576223"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Nov 2023 05:10:11 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 27 Nov 2023 05:10:10 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Mon, 27 Nov 2023 05:10:10 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Mon, 27 Nov 2023 05:10:10 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hPe4zak9XcZiTiFVI8MgWRtQJGRl3DsCir0pFRMWvtkK7t5kgAEpojp9M1kgt5vsE9dGZakWRGkSpIVRG+yRsuMf5vDWgSl6hs1shIndWffIvWIogklIVclpeXV9FVTbqNZa9iHAnn7JmrQlr4qdcSlyaMzz1K8maplD3sDbDlUrYuzn+8iuCqcPqulq+01HiI50qUZnWvgBCNssE0bYlJFbqxzHOxRyeBAIR3dU/LStfOQh0+CEd2Zc6EiSckvCjbNc+xmL4Cvx1EvOuZXX/4y9D37m+7Yeno+zi5W1jM3Cu5myv/vy9CXhiRQ8nD9tdppDSjU6AgyXZB+JwcoHOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eh6RFEKUDbJPdo5xtk2iOZ8iCy1h4fDWYnWBc+eDnfo=;
 b=Ozlj1Lwc5JDFkM52aTqffk0Vi12VM8OVweKYwYkjFK+vJxAxnzrQHknJFfwVVsclLkV1Q3BunbTpaGwelHa65FhpzqjVUHhWWYvAxEvDdaS/nqZk8lZmrgcJm87mlZfMRPzZ/dcBlhbZvvyXIxKVn8E5MlpZy7Xf+EzpT7byv+8BasA59WRi4e6SP5SdMsHV3mOF3T5rtHlvNKmUhpRPhZJGIjujKeBbNmqTYlJdCVGr/Qvke+3lGnigAduurwTYmWw22XZxvgCpV+5i4MizEcHueLR3GqdYXsqkISFuTXM2SwIOaBq5q1IFh2ZIxCx2I+vWEt9GjOOf47rIPMdinw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW4PR11MB5776.namprd11.prod.outlook.com (2603:10b6:303:183::9)
 by MN0PR11MB6012.namprd11.prod.outlook.com (2603:10b6:208:373::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.29; Mon, 27 Nov
 2023 13:10:08 +0000
Received: from MW4PR11MB5776.namprd11.prod.outlook.com
 ([fe80::49fc:ba56:787e:1fb3]) by MW4PR11MB5776.namprd11.prod.outlook.com
 ([fe80::49fc:ba56:787e:1fb3%7]) with mapi id 15.20.7025.022; Mon, 27 Nov 2023
 13:10:07 +0000
Message-ID: <62a826d4-e0b7-4922-b75c-8ec54de83ef4@intel.com>
Date: Mon, 27 Nov 2023 14:10:01 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] ice: fix error code in ice_eswitch_attach()
Content-Language: en-US
To: Dan Carpenter <dan.carpenter@linaro.org>, Michal Swiatkowski
	<michal.swiatkowski@linux.intel.com>
CC: Jesse Brandeburg <jesse.brandeburg@intel.com>, Tony Nguyen
	<anthony.l.nguyen@intel.com>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Piotr Raczynski <piotr.raczynski@intel.com>,
	<intel-wired-lan@lists.osuosl.org>, <netdev@vger.kernel.org>,
	<kernel-janitors@vger.kernel.org>
References: <e0349ee5-76e6-4ff4-812f-4aa0d3f76ae7@moroto.mountain>
From: Wojciech Drewek <wojciech.drewek@intel.com>
In-Reply-To: <e0349ee5-76e6-4ff4-812f-4aa0d3f76ae7@moroto.mountain>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0446.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c6::12) To MW4PR11MB5776.namprd11.prod.outlook.com
 (2603:10b6:303:183::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR11MB5776:EE_|MN0PR11MB6012:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c4c8124-a7f3-48d4-fbfa-08dbef4a2db2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: F38lC1sebMbYMyyqUj+fyRXmPYAqDrv+EXpGOP5PNDKLfxgfXY5SUyF2VrA0yBa+Lq9rUESGQ5FV8xfUBH2Of61a+i+GL/ffU0858ebTYM67x4bH3uubsCG90eUqr19a/sXwpVG6n6/v9NZF5pPxcGGSfd/bRtBatUr5w4qwhKxZbUvQWpcFCKJzBcMBLLkPmsqkB06zHORjiC9cwQz00DTme/ubvt1WJ8mn1DVYMSfluxeMImJdQXqnI0ltpia2ls9dOzDCSjX4OsNVEVuRzumxaVksxnr53K42YIIBirSFNOESTtBaQiOjWBJpdLaPf+dFm5yUXcmkTMFHOSgYt3q3INpcMC2WH8ymuAMmAg3S1NLRrtzyDPeouJ89jQ/FWSsO533HRpotyTwGP4tzo55zqGHxmQ5O5HXiXgqGktTD+Ui9TuyfRLU7eaJMmRs/cGI7c6nv1kEh+cnmdRAZTyDArTAOtHT5YAOIUjOzE4VJJQ/bi8BZYh6pFXra4wc3ZCCBgMnYUjj5STSwkTItPzKBk4svNtByITAmJeRWGeu+2s3oHjAa6nV7RtrqzTLy6du+AdNQ+O/Kgj7Sn+mioYvBuenkB2Gx15S0WvClwckGD5iNCIVKYS3Myje/jnQE6FOyczHeinKwoPUCvaytkQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB5776.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(366004)(376002)(396003)(39860400002)(230922051799003)(186009)(451199024)(64100799003)(1800799012)(31696002)(86362001)(82960400001)(38100700002)(36756003)(478600001)(6486002)(316002)(54906003)(66946007)(110136005)(66476007)(66556008)(26005)(6506007)(6666004)(2616005)(53546011)(6512007)(5660300002)(44832011)(2906002)(4744005)(4326008)(41300700001)(8936002)(8676002)(31686004)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b1dWSkkxaFo5Qjd5UGNEWm1abVBEOHhFbi9kV25RTmEvK0dhWUlNc2xoTWQy?=
 =?utf-8?B?a0diRHhvOTRGYSs5SkVjVmN2eUd4eEQ0a01XTTJIMXVjRk82dzhvOGFtYkZz?=
 =?utf-8?B?bjZSNXExU1d0RUdMS0hZNitYUFRNVVpnQVV1bXQ2VTVuV3NHWGozY2VOcSto?=
 =?utf-8?B?N0g5YjVnbXhMc1JnUlQwK2VoL2RGY0svL3hjZzB5SUh0N2tUT09BOU9zRXhO?=
 =?utf-8?B?THpzem0vSW14aG1LNEs5MkR3b01QaGRnaFhwbmVqbVVUbHFQSkxBSk5XdkFN?=
 =?utf-8?B?Z2hsNVlLekdpU1dRL0VTS0dXVUFKU0pMNVYxQmRxdmNUNit4UGd2UlA2SDl5?=
 =?utf-8?B?NVEvZ3FDc1JnVHQzYzBWd01pMGM0SlZaaXVCZC9pYmp3Ukl3U1J4K1dyajFH?=
 =?utf-8?B?ZE10aGNnK0dqQmJFcTNVM0docnM3R2U5K2N5cENzYzE5VEJHVHc3ZzVJK3cz?=
 =?utf-8?B?RFpCbHNhcnlobzNpVHlOUXNnMXRNN0xFUFJVUUR2QStDVWxrN2lZMDNLeFhR?=
 =?utf-8?B?Z3RMd1NySm5hOG02U0s3Vzg0L016TUw3M3NZM2p3UW93cHB4MTBETCtpNWpB?=
 =?utf-8?B?b0Y5eDFTeGpUUUtIQU5HRExHcURaSXdyYXZuWGtjRU1SeUlMYmdaQVdsZGkz?=
 =?utf-8?B?dGw2aUxkWE0vVlJCRjBnWlVia1V0UkNYcHNaWGxJb3dVVTNza3hFUXRUb3N1?=
 =?utf-8?B?ZzU3TDVZKzFMM2UzVGRiK0IrcnZWYmJKQVdiWURtRmJoS01nOUwrdHVmd3Vw?=
 =?utf-8?B?OE85ZURGY1RPVWFsbEo5VFFFQ1dmUVgvbldqMnE2U1A2SkE1UTNORHZDZGwy?=
 =?utf-8?B?SFpQTzF0NElZems5WlB6WjVNWU9zcFVuUzJmZEdibVhIWHg0WTRYM2U2bjVT?=
 =?utf-8?B?d01ESlAwaCs5bldRQkg0MktqaWVGWWtpU1l6N0tybW1VZmppNy9JRHJ1WTcz?=
 =?utf-8?B?MFVCVjZSZFdmWHVLSzJUTkozSURnQWVVOTBEc01CYjI1YXprYWx0ZzBpZmpF?=
 =?utf-8?B?bUFiZSsvSlJUN3hkV3JEbXN3QTJoQTdzZU1TUDkyemN2UVdBTTVOeTBTQlpl?=
 =?utf-8?B?M3htM0lTWEZuSW9IcVhaKzlYbnQwZWRldnB2N0FDT2RheUprbFE2N0pnSGpW?=
 =?utf-8?B?K0MrdXMzOWp2NGx3d2dQc2w2UzJoRFgrb3FEMWtnaWp6T1FBY2xTRk4wRXpw?=
 =?utf-8?B?bkwrYkR5RXNxdTgxSlVMeHhVSXhHd1JaSFJHVTk0bXY3eDFqTzlBVm9OSnVW?=
 =?utf-8?B?MlJ5NVZEWjJrMmhEODdUNTFrL2dYUHA2bGp2NW5SczA5bzhNbnQ1VE1BMVVx?=
 =?utf-8?B?aGJVT3Q2Z2hnSEt6U01IUWhyWk9iVVZaRjlYYzhKY1FiQ1pqcUd5WERwUWZp?=
 =?utf-8?B?WDF0cEIrSzRLeDR5bTV0eEZJK2VKYTlEWm9KT2FVMmxubEFzdGJFckZMWUtz?=
 =?utf-8?B?eW5OYTNueW5rVlc4aG9PY29RYVJHYzNLcVM1YkZxQk16eXYyRDBDbldCSHNv?=
 =?utf-8?B?emlKYXM0dCsyVUc3TU5RWDJOZ2Jva3IzbTA5TWdYeGFpZlphM3prQmNWcHVX?=
 =?utf-8?B?cHBQc1ZRWFJQUFdTYlJvVlFDaWdJazlEaW02dXZxQ1EveDliWWhzaXo3UFRD?=
 =?utf-8?B?K1M2WWJMaWYvWkVMWDNTenJqSUxvSGUwOHNnVzBHSG5nM3dONFBnZVZOdkFW?=
 =?utf-8?B?Y2RVbDY1eVVhWTd4cEJRaWR5eTE4ZFJjN1NpQTNTQ1gxKzFvTzRKUG9qbnA2?=
 =?utf-8?B?YldERVI3YzVWM2Z0WHA4Y2lSSWhiN2pZWHIzd3Q3U1ZlTGtRYlhtV05VZVZs?=
 =?utf-8?B?blBYMVphT0JKOTBRWlF6bkRXbXNUOVMxc0hjdmphNzBDd2ppUmxrVk5aNTI2?=
 =?utf-8?B?cm5GbnJHcVltOExaTDZ6elp6T0VGaEtndDAzeGJPMlpVODQwK1UzRjlabkVG?=
 =?utf-8?B?KzFVVGhIT2Z5N0g0dUgrbk8xWnlUZEx3ZXd1NzB2bHlmYi9XbEJ2b2k1cG5l?=
 =?utf-8?B?NENLZDdhRTlFc3p1UXNPYUhqbUNCcWpBMEhkZ2V2UmFyMVVycnJ6cncwZHNp?=
 =?utf-8?B?OVpjMFdHNGRCclQwR2dkWGFmTGxpVXRndG8wbEgyS3Z4MjdEVHVDT3AvTE5H?=
 =?utf-8?B?dVo1SUpUY0tRNkt4N0lzcmZJZFR6UmtTMGxDc29RVFh0SWt0bTZzTUpuek1v?=
 =?utf-8?B?QXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c4c8124-a7f3-48d4-fbfa-08dbef4a2db2
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB5776.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2023 13:10:07.7454
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P2+59ObaT/+C9v8Lqh1JYkG2jXnYgaLM1E7PLYCaqZPJp6xhs1R+QiOrme+PudKdM4aYCFjApRGZc7ufezEuY98c/GhHfNud7VxjpoSIaRc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6012
X-OriginatorOrg: intel.com



On 27.11.2023 13:59, Dan Carpenter wrote:
> Set the "err" variable on this error path.
> 
> Fixes: fff292b47ac1 ("ice: add VF representors one by one")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---

Thanks Dan!
Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>

>  drivers/net/ethernet/intel/ice/ice_eswitch.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_eswitch.c b/drivers/net/ethernet/intel/ice/ice_eswitch.c
> index 3f80e2081e5d..ca118bc37e44 100644
> --- a/drivers/net/ethernet/intel/ice/ice_eswitch.c
> +++ b/drivers/net/ethernet/intel/ice/ice_eswitch.c
> @@ -669,8 +669,10 @@ ice_eswitch_attach(struct ice_pf *pf, struct ice_vf *vf)
>  	ice_eswitch_stop_reprs(pf);
>  
>  	repr = ice_repr_add_vf(vf);
> -	if (IS_ERR(repr))
> +	if (IS_ERR(repr)) {
> +		err = PTR_ERR(repr);
>  		goto err_create_repr;
> +	}
>  
>  	err = ice_eswitch_setup_repr(pf, repr);
>  	if (err)

