Return-Path: <netdev-owner@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2D0E7417D0
	for <lists+netdev@lfdr.de>; Wed, 28 Jun 2023 20:11:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230497AbjF1SLJ (ORCPT <rfc822;lists+netdev@lfdr.de>);
        Wed, 28 Jun 2023 14:11:09 -0400
Received: from mga14.intel.com ([192.55.52.115]:25289 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231363AbjF1SLH (ORCPT <rfc822;netdev@vger.kernel.org>);
        Wed, 28 Jun 2023 14:11:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687975867; x=1719511867;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=uynNdL6n/UrUToDhQi6dnnAYOLgXNiubUPWbXi1UXJM=;
  b=krZhsrrNed5xAXqMNWjV4GWxY17AqAnzhyE+v//8EbrmfDL8gwbxeHue
   DtkZbN07Q2D13fnKiICp+Y6FA5f2QHqlsqK+GfhII1qyLJOVFI3Oeagfi
   3Rd2IEdhVeAaQX3wkfMjD3IkhEddXRIG1tqq446hQiAkHuQz+vssbaDMF
   au6x5hKfP8Q3RvCQ+PO8m1unDNlqjwIe/0EiB7ZUlhCUiXNGmPrpi1sMY
   nrCarTvq9o25tuysL/di+ukplHp3d6muprPGLdaYLoGQjsHNZ53HRxpIu
   e7NHSn2lEguRat5CmBnvsLUgVqAP80MrbSiiBgTfdEhJRd++K/hVFDfDO
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10755"; a="361965307"
X-IronPort-AV: E=Sophos;i="6.01,166,1684825200"; 
   d="scan'208";a="361965307"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2023 11:11:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10755"; a="861623326"
X-IronPort-AV: E=Sophos;i="6.01,166,1684825200"; 
   d="scan'208";a="861623326"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga001.fm.intel.com with ESMTP; 28 Jun 2023 11:11:06 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 28 Jun 2023 11:11:06 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 28 Jun 2023 11:11:06 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.175)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 28 Jun 2023 11:11:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XgoQE6CBRplAU6yYX95X5Xv52P3k79IbcEzsIRKQcgF21dS+Xg/W/8wyQlf/TdGP6f2s6cKJLtDKPFOznvWJv1vX8Pb12mHWmTaQfSML0DSZUwt35hn+IFrlP1QQPIi5vy+6x7XSsbKXqCccA4zCWmpOteTLt3kTArGvqv6UxeEPpn04n1360G1xCiaaJdEWsEPlH0rtI9CsTswd6XyUW+zBKSCCNWspOvIn40kcai6+yYbATz57KH1Km99CHDVs8CUGz9FIhFWAV1YI9uux4DQqGRqnVkIVvNWWkGPqFKXwEa2gxLNOPxyEjP+dkq7BHniISMVcGy2CvkOq9HeLhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Iv34j+1BYTToQMu8wLV0NqhdxQdUXYa111KinNCIzo8=;
 b=He6tAcVuO5g/m13PtkBnzZvyPk/Hdyc1npAuLjZ25qIevHpntJhDn/djiTi860G2DQBXlfn1MYH4JG+xGbOB+1hLgmJ8+ryWhrGGJMtzOduOPZn5574qSM4xP+KIYFupk8SWgBZw2Hb+tShVqTovuBGe2cWf+Ldks53coaelWQCYWxRi4NEI9fpgdUo2Li+0hJMJGEsNTeeBFfRPAO0DWsOp/LP79KjMPLqscussgy3w887DKulOLs16apXDGENYMxLNi1iDU8LICR/JimGcoPomS8/isHVvUsd5yd3DpE0fQFxKw5lai+tCXMm4BorEjo4XyKgU1yjURxCkh8XQrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by IA1PR11MB7854.namprd11.prod.outlook.com (2603:10b6:208:3f6::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Wed, 28 Jun
 2023 18:11:02 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::4e5a:e4d6:5676:b0ab]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::4e5a:e4d6:5676:b0ab%5]) with mapi id 15.20.6521.026; Wed, 28 Jun 2023
 18:11:02 +0000
Message-ID: <4fb8c5a2-cae0-0885-76a9-5b4489291872@intel.com>
Date:   Wed, 28 Jun 2023 11:10:59 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH net] sfc: support for devlink port requires MAE access
Content-Language: en-US
To:     Martin Habets <habetsm.xilinx@gmail.com>, <davem@davemloft.net>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>
CC:     <netdev@vger.kernel.org>, <ecree.xilinx@gmail.com>,
        <linux-net-drivers@amd.com>
References: <168795553996.2797.7851805610285857967.stgit@palantir17.mph.net>
From:   Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <168795553996.2797.7851805610285857967.stgit@palantir17.mph.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW3PR05CA0014.namprd05.prod.outlook.com
 (2603:10b6:303:2b::19) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|IA1PR11MB7854:EE_
X-MS-Office365-Filtering-Correlation-Id: 312329d8-f789-41a7-5e17-08db78030833
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kLLDb0T4BLSTmsHr3jIGHGF/Qf6fyVlzLRw2clmAzgUo1lr6a8O3+Ga+MG/ABNAUXESRZBvGCSTtv7ingQ2nU4egEet7PkBq3zBBzTPO+ATJ/nPwhAB3a5yYJjQVxW8Fib4I6OOEs3BHd8bCJdv4XHC+jj0QQj7JCS4O/Okrzd2GY2NEAABp2siUQYQaILXSwHN7Fe5+oG79DYg37vseTMfh4Ip30mQdwoAYqcW3l6v/PrMK8DeUtDP6nveRhZ/GsAwlYWdRLQ2t8sLRpmR2FnlZMFO2WTp8Mg6Fna8H43DCIWmTGhxT7m/NJ41I6lFEbOe3p/rqv1/wX7aHrcvro+jUVqJKifNET9wvLWdk8tPwFkqAoh5AfcdehFKANylGHcHAuf6SV7niVCFzlmzehe3KXtf/2SiqkjkbMnvHgfRcP1CCXmlz7GC97P48Z1J7EFzIiZ0rb82rTBrJUImENgHn8t1h0jpJa3GMTPpXG2FZzVBFnd50JVUc84719I7Rbw45Jp46Y121DPh5s9DmFAVVovmOZveWRLTDeGIuC0I070UaM14gHlRmh6Mmib0eXEYI9vFnUWMYdqZGqeNRgTPmw63eImMI37IUGmQQfd5H+a6ffQwwQijbAzlC47gpIQDFmi8y5TrlTBEVxdeQaw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(346002)(396003)(39860400002)(376002)(366004)(451199021)(26005)(66556008)(66476007)(6506007)(36756003)(6666004)(478600001)(2616005)(186003)(2906002)(53546011)(6486002)(5660300002)(66946007)(82960400001)(31696002)(38100700002)(86362001)(316002)(8676002)(8936002)(41300700001)(4326008)(31686004)(6512007)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y0dISXRsVVlraGlkellzTks5Q2dDUTlwYnJBakdRcHBRQkhnNFVTV1BrWW40?=
 =?utf-8?B?dTEvQURQVGw5eHlEc0hrUzI1SzZKS2pmUFY5dHhOWDVOdndDaDhLNDRqa3JV?=
 =?utf-8?B?L0RORldIcDUrNnF1YUVDMytjV3FyVkcyTFp5YUs2UU83V01CbllwUjJpOGtv?=
 =?utf-8?B?YkZXZnVZckFVMmswRnZaQThEemc3ZVVQdUM2WStvR1pPM0tzdXZ3dzdUdFlC?=
 =?utf-8?B?WER1elZQd0kzWFJUQ0NaNUpLTC8yaG9taTV6VlBkWmFTeVBEeVdmV0RHbUhk?=
 =?utf-8?B?T3JXK0ZZSng5NE93KzNNcTV5T2NJNUJPZWhVYllLME1WTWUyRHZ1ZDZRRzRy?=
 =?utf-8?B?WWFqdVFTSE9uWDVBQ3ZuSlV4dUxQelBJSHhqREVkeUVZK20vWkVYdm1XQVgz?=
 =?utf-8?B?MGNqMnNoVDZRYTdPbFFxTjNwNU40enNPZlVSNGxSNEs2VTRieWxaNXpJdmMy?=
 =?utf-8?B?VWg5N0xJckpUTUg0aDZXTWRhN3M4clhWQ3BhL3NJSnJ2bHlqeFBUYmVKbGFk?=
 =?utf-8?B?WkFlUDRmLy9veGN0MVZzUU5RYnlBUk50UlZRYlhFSGVZZjZvdDRTNXFjMFdS?=
 =?utf-8?B?dWR4elNIdXhKYTZQVnlJNk9tZXh3ZFlLOVFRT0l1R2l4Y1NoSkVOOFVFRmFk?=
 =?utf-8?B?VE0vM24zalY2aU91dnJ3aHhlSnVSUWo1WjhwUXUycmZyMVUvSDkxbnNuaTM1?=
 =?utf-8?B?a3dFLytkSlUvM0xvU1V0eEhoUTNtNERaellKUklSQ0k5WWJ3OWN6RXpHUGZa?=
 =?utf-8?B?L2NOSWpMZGtZVThNZFNOVHp1Z21BTHlMRm9pK01rcFk2NFBNNDhqNlpQOVRK?=
 =?utf-8?B?aHVzeUhGL0tDUnpZS2RCWmJWSXZ2KzJtTHJsckFuZ0Z3ZHg4QnJ2YXFXTGhL?=
 =?utf-8?B?am5FU3lEdUQ5NnRzcy91NjFCZTFJVFBwb2NscjlhSVBMaWk5N25MU0pZaXVq?=
 =?utf-8?B?N3dlNTNobU80L0JoRDhBSE1pcloyVWtXVnI5eFhaTUE0OEFDNDhSYVB0dDZY?=
 =?utf-8?B?QzQ5eU10ZFVKUHRWSTN5UGpWalNoOHpIN3ZKQ3A2T2F6SHNiZ0E5VXlwRklP?=
 =?utf-8?B?OWIwOEYxeU40dkFzM1RTajY3bTUxQUhGVEY1TDk3cGJqQkJ0QjRmL0laVUc3?=
 =?utf-8?B?SDVFTURCZWZOZ2hXaVBwbXVRUEdXaTZEUTF3YnZzcTFPNlcwaXlrZndnMUFT?=
 =?utf-8?B?QU1BejNXeWM4Y2VwOUU4SXd5aGc1VG8yWjZrRnpaUkRLK29TUkxOSFRoelNM?=
 =?utf-8?B?azJPSXFtbXZnUkdvUXNhL3VJdC9Na2o5UlNuWlpjUmhJMURPbmZ4ajk0cWhm?=
 =?utf-8?B?ekZuSUpML2RKL1p6empNMTV0NUdMQ2N0Q3pzTkhONEJ5OXJQRnV5YklUYlky?=
 =?utf-8?B?UFFFbTQ2blk2eHd2SUE5WUs3YWZza3hDVUYyVlhFeDFpM1lycmZWcXB1SlJI?=
 =?utf-8?B?WTRHM0R5UW5iUDRaeE4zOWdTM3dqWnlmR3NwclIvTUdHTWpqWkdBRFdLdjFX?=
 =?utf-8?B?dzlSbkIxT1RRaGJ0bnRCOGxTTUxTRXZWWjd3NkdZZ1NaYlFaT3hNMElCRmMz?=
 =?utf-8?B?enE3eFY3Qnd3ZTFzYkNTYVZ5anR4TEU0Q0E2Y0hpWHVoditpcjltVVUrUFk2?=
 =?utf-8?B?V0ZUakMzcDJ3eG5oUGcvaXRSTlo1OGFmZjdGSVRScTM3S3ZFdTBpQ284cmtw?=
 =?utf-8?B?T0ZJYU1STWdybTJFTnlyamwreFFFYjMrNXBXR0VOVTQ1YVNtQlg5Z3Q3TUhC?=
 =?utf-8?B?M2oza0s0NWZOWFNDS0JkcmlqVmhSbE5zQ0htMitrcXNOUzdpY0JpRGtsS2cz?=
 =?utf-8?B?cWJyblZ1YVoyZytFVUpCQzJzT3JOOTNaWTFJQWVxdVcyY215L0N1ekNNZTBG?=
 =?utf-8?B?MTVRUXBHNS91OXVqVmREeW8ydmRkZmtwbjJtY0RoSVNoQkZrUmF4QmdwT3lR?=
 =?utf-8?B?Rmk3WHFpOXF5M3lIcXZ0cUozbnRRR08vSkJVUmFYWkluOUZ0WVkzMFVxTjd2?=
 =?utf-8?B?aE1rYy9OMlNwQnYxTU9IcEwrdktkUTJoVWJvTDE4NzBkL0hBbmJoTldINTBM?=
 =?utf-8?B?TGx0UzNTd2ZDODdMdmpIZ0ZsOXFaa3psZlpHMTQ5Zk5xWkRRVTFCMDZwVUs3?=
 =?utf-8?B?dUdiNER0SWRpcS9jVm9IL0swZGRvQ0NqRElBNS9NYVNyR2VrVVNjOExRVXN0?=
 =?utf-8?B?aFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 312329d8-f789-41a7-5e17-08db78030833
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2023 18:11:02.2471
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MeXtI+GQ4n8Ifl6E/t6iJFwPsKYFKtF6x9AjXNMRRLJ7gryB5J/YPMvfyE/HFz/ejoktXlnfWZquxZVwdhX1qGwITgG/QpNshS+ubuIPGBA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7854
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <netdev.vger.kernel.org>
X-Mailing-List: netdev@vger.kernel.org



On 6/28/2023 5:32 AM, Martin Habets wrote:
> On systems without MAE permission efx->mae is not initialised,
> and trying to lookup an mport results in a NULL pointer
> dereference.
> 
> Fixes: 25414b2a64ae ("sfc: add devlink port support for ef100")
> Signed-off-by: Martin Habets <habetsm.xilinx@gmail.com>
> ---
>  drivers/net/ethernet/sfc/efx_devlink.c |    3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/net/ethernet/sfc/efx_devlink.c b/drivers/net/ethernet/sfc/efx_devlink.c
> index ef9971cbb695..0384b134e124 100644
> --- a/drivers/net/ethernet/sfc/efx_devlink.c
> +++ b/drivers/net/ethernet/sfc/efx_devlink.c
> @@ -622,6 +622,9 @@ static struct devlink_port *ef100_set_devlink_port(struct efx_nic *efx, u32 idx)
>  	u32 id;
>  	int rc;
>  
> +	if (!efx->mae)
> +		return NULL;
> +

And returning NULL here indicates that no devlink port was created, and
matches the rest of the function.

Makes sense.

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

>  	if (efx_mae_lookup_mport(efx, idx, &id)) {
>  		/* This should not happen. */
>  		if (idx == MAE_MPORT_DESC_VF_IDX_NULL)
> 
> 
