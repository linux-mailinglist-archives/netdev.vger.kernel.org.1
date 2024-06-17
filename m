Return-Path: <netdev+bounces-103918-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5763A90A520
	for <lists+netdev@lfdr.de>; Mon, 17 Jun 2024 08:17:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 332021C26348
	for <lists+netdev@lfdr.de>; Mon, 17 Jun 2024 06:17:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 682F918755F;
	Mon, 17 Jun 2024 06:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="F2Y9yvSR"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9A62187358
	for <netdev@vger.kernel.org>; Mon, 17 Jun 2024 06:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718604769; cv=fail; b=QM9tEd4/Zi9/jw+Tv2NUvt53eP4AQ7TCZchOSu1PVUC8ff71TE0wNoOmgXZf+GttOgKmgXMLRAn6fYBpVHzexVVJmdP4nkQU3ZPffjZwR/LVKsKpY7YBLtt3XbfvPa+OPorD0yOSt67K8nJDTdEWFHVWG3v0T5Qs9w6Ia74j1Uo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718604769; c=relaxed/simple;
	bh=u/qWkdoqMvQzRCI42ZtUl16h95oMgj7E/Kt0ytaAsjI=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=cxmsr1YAE4bWPI97gqH1TAgOuHfSFQjOt82Sc7ftaLwBhyjI2VXNpJk+hq7kNMfgmAHbEDFN1A5U90+zWy+hVBAilJsUcW311w3b1HKKc+fSQ4NKtfWUuSK64R1OWhPWOQLZGiLHZi2U9k4S5Ke958yRNfEoei6fNvmolbo6PYQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=F2Y9yvSR; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718604768; x=1750140768;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=u/qWkdoqMvQzRCI42ZtUl16h95oMgj7E/Kt0ytaAsjI=;
  b=F2Y9yvSRZDkCIaCsKOCYiG5ekVikwr+f98J7AVIJehSaI4Vx1x/a7aGo
   UJGIdJbZc2OTifzBZ0c8N8G4ntNHGhGS6S+F2Bjl8rmBaVqyzZv7/dX/k
   gTrebm9uQIM5wF3a2/Y77IecfJVcHMPXzSry59J6D12lg+sSc0bFDVrLc
   f5nopdlIHRfY9ZllT0CPbDjjqsJiZ2ylETFm1wieEss4DTiwzooV4Zuny
   IJ//W2/0/JD/ucnR4xlwm9oLSshgBzVVdS8m+GNJg9TDRHw5ikXsbvTFV
   HljQbcAerh4gWf9qCQGzXuoigH+9KnEhT8hIguTOhH1SwfrfqxHcD5QYz
   A==;
X-CSE-ConnectionGUID: YmfTAf9LTGKIxGLRTtJV2A==
X-CSE-MsgGUID: m4cmzyZuRLKTyeBCsPo/OQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11105"; a="19275111"
X-IronPort-AV: E=Sophos;i="6.08,244,1712646000"; 
   d="scan'208";a="19275111"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2024 23:12:47 -0700
X-CSE-ConnectionGUID: 4EIQYrQXSrG+395nd/bntw==
X-CSE-MsgGUID: 5drlR5BiTgOivbxIxNTw1g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,244,1712646000"; 
   d="scan'208";a="41231406"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 16 Jun 2024 23:12:47 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 16 Jun 2024 23:12:46 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Sun, 16 Jun 2024 23:12:46 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sun, 16 Jun 2024 23:12:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jNlFKEm5U1EBIEPXi33Cpk094+AVMd7kVUeXLeSk0zz223bd5nUP5THxsRDhSQhMUmHyo3KOOmIZ9+nj4Ih3K6mxo6UdZZnEjwFOQsvA9UPRGElUbfjUTk/lHqTUKPyGdrLnjw5JxuhTXahIGepS5u9HjKveep3VFOH4x8eAi3DvfGPp/mduxLpq4UTSIpWi+oJpA5GT3smtvzNYp25cI4M9lE0nzIvLxXAAGSnGeaCs9Rz5o7STALS4o9Spw9xkVQlhKVoi8voN2797oz27exN4i9bRASydpl1kse+isxmNRODUtjnNgp65ip/CT0ZTHbgUsucFu714U7HIriGzpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=psY9uzJO7gh2heoVxd3doPk8WatVUX08NrFWuWvlA0w=;
 b=cyER6lERyAFMnNA7gAWMOeA4W9LnGIhDUApC17p+BiHoEEURqvmqQs64ggglyqC7wgqBLqyVB43U/UroQ7d09q2ilx2cIEhUQL/nNPRRJyDHxuwrqOnBWiCOXFovt2xgye5KeSczkwJJqHBTD3gY/z2aQaH4jGKA2dp+tvtGKM1MSm4Gahcj+9JcdDjjZH7u8YN3irRyhGg9KZdYdMP3mOHf0F9XOlHneq87q6dy50b32Rt64D6/f4YW3m3xm/2zHfiPqkr7iFRLjRNg0gBe6AHdW6wSccjT/noMi/LRBbA6gdl4gSg5aomoc4PDMchDRpUUuAjEFuHzB+bSBEVjGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by DM6PR11MB4739.namprd11.prod.outlook.com (2603:10b6:5:2a0::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Mon, 17 Jun
 2024 06:12:44 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%2]) with mapi id 15.20.7677.030; Mon, 17 Jun 2024
 06:12:44 +0000
Date: Mon, 17 Jun 2024 14:12:27 +0800
From: Oliver Sang <oliver.sang@intel.com>
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, Linux Memory Management List
	<linux-mm@kvack.org>, <netdev@vger.kernel.org>, <oliver.sang@intel.com>
Subject: Re: [linux-next:master] [rtnetlink] 8c6540cb2d:
 hwsim.mesh_sae_failure.fail
Message-ID: <Zm/TyyfZqtSI911M@xsang-OptiPlex-9020>
References: <202406141644.c05809af-oliver.sang@intel.com>
 <ea30d016-a163-4a0e-81c7-46d6645440aa@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ea30d016-a163-4a0e-81c7-46d6645440aa@I-love.SAKURA.ne.jp>
X-ClientProxiedBy: SG2PR02CA0103.apcprd02.prod.outlook.com
 (2603:1096:4:92::19) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|DM6PR11MB4739:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a33a22f-ffa4-487b-2825-08dc8e948081
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|366013|1800799021|376011;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?6dl/3wpCwBqXwgwni8/TlykdXCZNf50peJjPnDv0XcBnEstFWMOhK1eFGABu?=
 =?us-ascii?Q?SKZN1e2Ei+u3YLNuX1T27wNYbK06YW4CQGw/8DshXEI6vXE7IbA5rDQCbvV7?=
 =?us-ascii?Q?AKejUVVLnKcsE0EbMVaK1IhHXZRXCPibuJwulKoAfLh9EUtTxGBydAfF53Lo?=
 =?us-ascii?Q?rvbrom35KWzfJ3q6SXgrWyMxhD5ZydFlN8oLBnlAmwasgNqpuHYnE3Bbpohk?=
 =?us-ascii?Q?zXFQMTz1Yzv6LVERLAEZ/IeXuBCuWMhW3iwfCk/0FI8X+x+McgbSTBwEB2X/?=
 =?us-ascii?Q?NXDir0c/hogG1DZLsBnzquJRxNQFNXPiYhvVYVcCXYS9umKZYocuGgJy2A+N?=
 =?us-ascii?Q?LA//DwSLFmzCZv0qIV8+GsgxRUGmjCF4l3JwelLCN3/F+BDv7sJp4cttqY4x?=
 =?us-ascii?Q?VWQzAOHdWCeJntnEZ1N2/svKDh1dLyY+KlfI4lPaH6m1By72VTxqWl/vldt4?=
 =?us-ascii?Q?bhwfW21/wxBx61OdMhcBEXcgrr29hWhkZ2NpZ4fd1ot+kd41D4LKfM2XU2wj?=
 =?us-ascii?Q?1rx+V85hj3jZHj0R6lXZLoQ4yM463LN8mB0bUKoQrFuKAgocSWVSyi7IoNsV?=
 =?us-ascii?Q?hXYQrF3mFIFFxhgAL/gjryUastICIiWGL+yVWSaBeNXpp3wWc3YUXb3y14gF?=
 =?us-ascii?Q?3TLIdNt2n27QXTft2yhIbJSGMIB6fEAHfj+jNSpMbzHH7n08s1fX9QDfEm2m?=
 =?us-ascii?Q?oCavVN6FKrkJYKg6wyhwgBYCWbM42xQDtY2XjxGtwUMpTDJ2NvWFecvsNrDl?=
 =?us-ascii?Q?0mng/UQc7Rty35m8OA6UwOtUpBOUlc7K1N1+VpBnXgYF2tJlFgHTIXBpV6sG?=
 =?us-ascii?Q?rXdD/Wwm99/kLcY/JnJtb0dllDGDHf4Q8Hk3ww3zsdJC7c4+lPQ50jBXotQP?=
 =?us-ascii?Q?pMUt/JXiM8D9rS2cBe4qXn7TeFyN0ia7+Y8P5LNvWMlktqzzLDMuFcnr7Axj?=
 =?us-ascii?Q?CYrsjdTZ8jkpTQFF9MvMQzmDnqdOJFKp75IgR4l7IBAEpl0FcOGiADpltoIV?=
 =?us-ascii?Q?dwiQsfTwkkykhxx/S5t6ms21+E8FGHRfQur/haAvqIgLXFYxNLePAg42EGd+?=
 =?us-ascii?Q?zhefEl/1aqBkriDuVkBUcXjKgI7V302sJxg+uCdEgI31HHSZE68WDhXkR/vZ?=
 =?us-ascii?Q?YLhfrdW3wSZ/GojtJaMORHLWKgY2pCwQkkpPH1TZgZ84atIzlQ+EwmHRrA8G?=
 =?us-ascii?Q?5cY628R4ScltqTg922NRn+yDeE4JfFqNOdbgYTmGOlOzCJY8/Q1Ul7e49hvK?=
 =?us-ascii?Q?ChCWaZNvz0NgpzX1Tq0B?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(366013)(1800799021)(376011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jRgReXFiCrQ1Su2qCUPaITL4FBO1LTQAvBLKqypHLqzF42ssLVVPP38wjEVR?=
 =?us-ascii?Q?F9ahZg0M/H3A63iHJSN48FN7oDe4jyYeKqkhooUUidxgWalceuiNHR1Wm2fU?=
 =?us-ascii?Q?+r9NATGkuJJ/o5irAr0EEM+Vw3MQW2A58NNz0PKH7dJb6sq9mitGvV/iT5nc?=
 =?us-ascii?Q?67Ac37mOQZyFqUUG7+Cuy2LjdhFxP+uQx4hvz/HETYrooGB42izezHyO2gY9?=
 =?us-ascii?Q?oP8AAPclM2hKYaOnUeRJ/k8+6X6+ProRb47FKaGAvM9q0ZSzIkblDAqKoawH?=
 =?us-ascii?Q?bSQAOhlDE9rCB/hqjsouR74Fg+V/Qs+ddE3SfvjEUYl4CGsRotocNdtAQYTU?=
 =?us-ascii?Q?gJyBW52+3xCguNYI1zE5Tn4ahnTOCI7o72zYt/nysxIFXUGq8W/1ejk1qtnk?=
 =?us-ascii?Q?vkQ5REB9Lj7HuyWyzEpTtlvv8dzXDlaEQEf0lLPMW0eV1TU+Y0HZv31RpDgB?=
 =?us-ascii?Q?7RJwdVnXX0KH928/Wh27Yq11RvkeobCyq7+osTeqrtwzsCpE56ZFZKKqYTqk?=
 =?us-ascii?Q?PowiYueJH187RTnnDIp4uX15hsGpq82Ub4F7apNGWiL+w6Mj5XeoFYIU2xId?=
 =?us-ascii?Q?eHv6Ms0/Uw7v1IW8+Q9KOxcYMk27eRmvo+eHKVacJDsBmNyblM17uNDlpWRz?=
 =?us-ascii?Q?39zmFYtupvv2/XWNHK/Ffej9apm3VZUsMqW2hyZElcXwUimA0JRsafehH6i0?=
 =?us-ascii?Q?VUBsZtqYphbQ7VithMRyZy9UG5ekLLvoQXkBJiKb8/qfEIObkHxVsVxOCOe6?=
 =?us-ascii?Q?rLMOeBZ34uEad4dCRUyabx7vvWDtxLkWjB8NSJkoiS+elE+7VYZgAyyARe6K?=
 =?us-ascii?Q?yE2hY+2dZU2+GShAi0xq3L4gbSNxLILsYTZkmVj6SfTgO3OvQoEfFRBe4/9w?=
 =?us-ascii?Q?wq2eSbg6i5SnvODPvTrhIAqHJcq7DE68wVG3p9cRXrEXmCLDysmFbDWUn5bH?=
 =?us-ascii?Q?DLgzr8C51zcc2Xf3bZWeX6vRgYrsutPCmqFs4ZxIduvwLGGY4Zh2d8DL6PwT?=
 =?us-ascii?Q?oPBD80zjKXZz4ycwXsSIraCH8xwyFWVmRy8NIjmFOflK+UL5F3CMvuRPCmLa?=
 =?us-ascii?Q?H7fgqrF5BBAqotqqy/C5BPH6WpbBa9fdMj3ujy0eCN53tR1IS1vZU1T1Pbia?=
 =?us-ascii?Q?ac3N40IK93A914CAiRTYzg52oPyDrc4DO5r/c6aa2prRoCKpoyceUaog6mVB?=
 =?us-ascii?Q?jHCnXdvO16M+oIjX2uuKqBQbRl43ATJwyOE0dUYRynzN1SnkQBUaWkRWm8lI?=
 =?us-ascii?Q?h8b9NKaWBgV7RU27baoZaSoUZXw1ikTFWojYdvlYOFmk/5ZA7AdhXXEmysMi?=
 =?us-ascii?Q?DweWv+emM6wjS/ouvfbhBTOycPBZDTEj14xqMMH3gdqvco4GrWjHG+Y8EHIv?=
 =?us-ascii?Q?5Ko60wL/We7OxQQzXCQvHfNDu8lCyYGZ0UbvFQBzIqC2kbznWXtkcJJ2C1bI?=
 =?us-ascii?Q?TmXlK9t2PgVyNqSI2ijtsf2xsj7Ir0zIgUoE6B8f3ho4PeelSqgn4xYw9bgB?=
 =?us-ascii?Q?B6eOJxzP0VhhOQGxs9kAPKS8iTVCXOGghjGx38zfVe2iK3bvWaqKHGKhtp5Z?=
 =?us-ascii?Q?uR1j0LkcA4Iiwdigu/tnKtFyDLbV0tmewSWC7kHg7qAlSoFnekZTK/rdz6RX?=
 =?us-ascii?Q?Cw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a33a22f-ffa4-487b-2825-08dc8e948081
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2024 06:12:44.5018
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FnTX+b8zhiyp1MdsiV99MMe/eD7cPdvr32IWmT25gGHRFCdu68Ojbf5xxuqjKz7qEnyTnZxAnryK72Yh9X37/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4739
X-OriginatorOrg: intel.com

hi, Tetsuo Handa,

On Fri, Jun 14, 2024 at 06:34:13PM +0900, Tetsuo Handa wrote:
> On 2024/06/14 17:48, kernel test robot wrote:
> > kernel test robot noticed "hwsim.mesh_sae_failure.fail" on:
> > 
> > commit: 8c6540cb2d020c59b6f7013a2e8a13832906eee0 ("rtnetlink: print rtnl_mutex holder/waiter for debug purpose")
> > https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master
> > 
> > [test failed on linux-next/master 6906a84c482f098d31486df8dc98cead21cce2d0]
> > 
> > in testcase: hwsim
> > version: hwsim-x86_64-07c9f183e-1_20240402
> > with following parameters:
> > 
> > 	test: mesh_sae_failure
> > 
> 
> That patch adds debug printk(). But dmesg.xz does not include printk() messages from
> that patch nor any oops-like messages. What went wrong?
> 

sorr that we don't have enough knowledge to connect the issue with code change.
we just rebuild kernels for this commit and its parent, confirmed they are still
built with the config we shared in the link in our original report, then rerun
the tests, found still clean on parent, but reproduciable on this commit.

this is just FYI what we observed in our tests. if you want to look at this
further and you have a debug patch, we could do more tests with it. Thanks

9dcaf7df2635eb1c 8c6540cb2d020c59b6f7013a2e8
---------------- ---------------------------
       fail:runs  %reproduction    fail:runs
           |             |             |
           :15          87%          15:15    hwsim.mesh_sae_failure.fail


