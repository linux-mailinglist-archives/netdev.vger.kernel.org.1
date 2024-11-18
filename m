Return-Path: <netdev+bounces-145804-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 139EB9D0F6B
	for <lists+netdev@lfdr.de>; Mon, 18 Nov 2024 12:16:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF9991F226D8
	for <lists+netdev@lfdr.de>; Mon, 18 Nov 2024 11:16:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A04D9198A39;
	Mon, 18 Nov 2024 11:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dfaGrnFd"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 799B8197A92;
	Mon, 18 Nov 2024 11:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731928558; cv=fail; b=qnzL6nGG5tmb0emNJy+eLwB8rE8yJ3GFESot3VrFIZUXqnySqVnFdrUJMBQD+rwkCbns7MJcUYyG0+rOTcHg1N1vt+JbvOEAWo42Wa+UstLv4TCO26C6ISHRNS4madM0wOsvyzd2OhJrmgSx1hawrk2wUf2z6hgfunnO0DzB9cQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731928558; c=relaxed/simple;
	bh=FtWmxDPxHT5fiqQM4YUSGcS5TuqvIFumR6P0w2v9uvg=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=O/9NCUkOS9kQuKg4rrpXW8o2+15qR0546cPOMYfPTN4sBkkkXsLXf+L9+Aj0hxVMLPtMYcXQsScIcSXF4/jLR5rIt2BcNbr5lGBPi7UkAFMPk0iOM+BVxFlhF13rqaMqYEa0oIAUD9nhF8+3ywLVb5y/VNG5zQ0cnhW/Pffdr1U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dfaGrnFd; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731928557; x=1763464557;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=FtWmxDPxHT5fiqQM4YUSGcS5TuqvIFumR6P0w2v9uvg=;
  b=dfaGrnFdheLfYyBMD6A+zZ9v9lMvXif8U4UCX0JWT8wl/EB65Xxe9xhh
   sHFX+0xbzFMhbxrJh62mjQwwK+XOTj0oa15QRSqqQkRMKJipxEBM05wfu
   dUy5ptu4Cdkt2qTTot8GInG7X/57uT1ZliF/e2xZBKBrGMI2Bajy+WMrF
   WaynZMYBZ7PYl3wQTQOBRJ81Ni6u4qnfo91AlbovlQ0CGohlstujtUvMH
   vzyMC0W5gGrrGYXU2DMHhXJGNay7D99gQfFIoP2F1t1gk1NcLHv9LI42j
   OO2Mng4lbz3jxDwZAmFtujIZSw+cwHLW6tDE9dJDZtdwfsqWzyd8QJZ8Y
   w==;
X-CSE-ConnectionGUID: EP717krvS5KDISe0hRHsaQ==
X-CSE-MsgGUID: /VVJteByQe+QHpxZ4qUu3g==
X-IronPort-AV: E=McAfee;i="6700,10204,11259"; a="43266239"
X-IronPort-AV: E=Sophos;i="6.12,163,1728975600"; 
   d="scan'208";a="43266239"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2024 03:15:56 -0800
X-CSE-ConnectionGUID: /+qPDHxcR5yRBRlU1+3SiQ==
X-CSE-MsgGUID: ROv2onekSe+3TEd/iFYa0Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,163,1728975600"; 
   d="scan'208";a="120048775"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 18 Nov 2024 03:15:55 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 18 Nov 2024 03:15:55 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 18 Nov 2024 03:15:55 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.47) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 18 Nov 2024 03:15:55 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o2Qw3MFfRALVWKMwiTaLLSjF5B4FGF8uqQ7y1xDDoCrjgL1b4shFr6CU55axlH/vxl/s/2Uw9eURP9ld0nkPxf5xX0IihcAjRc1l3mg7riUFojCO/vO2z5ANcBZ0JNNgLmERQ2tIhzAcoqeRZNezMYACiI68qBOuwDl3896zg3nGgLK8+UmCr8PUBnWcuA6pzbqfcPgWJ/GC99Z54giBj2Eb1suUMJHbSSxgpNkcgtnQmIyt5BFpCkE1ERq9ud8qdP4J4BxSzWFfsXYZdK50xrijXxrOffIqG5duq2258abPX8ig0J5VJchE3dwjSP4D5LVQkmzkQHb7/M9/vzrAZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4hFoQ/fCujjkSKNDLgE9JiJS3+4mPGQv8fF+zFTQaFs=;
 b=vTwdtTlWdqcqcHxrQSj4c/FNaGiiL4yOiCOOAN+pgtoarJlPKookbgNl1JKfT7ZHxf0HfxYKOkGktRcLR2x25LjZYERhbaE7e4dV94PKWjRZCB5uu+vYyiXPfxwpbChc0PyGAgoK0fsHlgakfiPkAriuePIvPkun+8vymUnTjKGSQRBh+z3wYozqssuZu4DC5LrTW9oOJsoIDs4H/fBCiMsm5HJS6yiXShIwNCW83Q9PN1pA5DnWAY9OyJ7iLBWaAjAAsWhLJ+ERrXY2t6mGtyYB84rWcUmelTYWWv4x9YQtIpgsRmTRw67o6dVbtrO2QTNaVI6334dA9qw+9wfpqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8665.namprd11.prod.outlook.com (2603:10b6:8:1b8::6) by
 LV2PR11MB6071.namprd11.prod.outlook.com (2603:10b6:408:178::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.19; Mon, 18 Nov
 2024 11:15:53 +0000
Received: from DS0PR11MB8665.namprd11.prod.outlook.com
 ([fe80::8e7e:4f8:f7e4:3955]) by DS0PR11MB8665.namprd11.prod.outlook.com
 ([fe80::8e7e:4f8:f7e4:3955%7]) with mapi id 15.20.8158.019; Mon, 18 Nov 2024
 11:15:53 +0000
Date: Mon, 18 Nov 2024 12:15:40 +0100
From: Michal Kubiak <michal.kubiak@intel.com>
To: Justin Lai <justinlai0215@realtek.com>
CC: <kuba@kernel.org>, <davem@davemloft.net>, <edumazet@google.com>,
	<pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>, <horms@kernel.org>, <pkshih@realtek.com>,
	<larry.chiu@realtek.com>
Subject: Re: [PATCH net v3 4/4] rtase: Add defines for hardware version id
Message-ID: <Zzsh3AjTAnQoKKTl@localhost.localdomain>
References: <20241118040828.454861-1-justinlai0215@realtek.com>
 <20241118040828.454861-5-justinlai0215@realtek.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241118040828.454861-5-justinlai0215@realtek.com>
X-ClientProxiedBy: DUZPR01CA0009.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:3c3::16) To DS0PR11MB8665.namprd11.prod.outlook.com
 (2603:10b6:8:1b8::6)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8665:EE_|LV2PR11MB6071:EE_
X-MS-Office365-Filtering-Correlation-Id: 70b7ec4e-3292-45bb-7a05-08dd07c25d73
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?smGdIKcii/ys+DXxc9iLI19DewaTv7+Yntjug4HQcGDyJSkfaXd5fVe2HDdQ?=
 =?us-ascii?Q?ve3UBzSlJypuS+UWMb+cIioepGoLXFk/8G3R/YIc6nLXMFaolbinzpgeiEDo?=
 =?us-ascii?Q?wKM4afjTpZrTUGioVzJHIyOOxUqqU5amkkr/btBePp/ru8i4D5yH0OS0dqic?=
 =?us-ascii?Q?bRIsxXHG+Hgo3qx8m0p8+PTeLyrb56dIogsOrNbcDSL8+b+RdnLeAm4cV+vb?=
 =?us-ascii?Q?H0WW+anJHFPM0I0zcR9F5+rSGXfuUCrUsDm3a1+P5C+t/wubEumJCxt5nSdG?=
 =?us-ascii?Q?ZLEW5W1oC6R8Z4i7BODCxmPHzifO982i1kMApCO73wmIaQ/6f1u/TmJK4tKW?=
 =?us-ascii?Q?LP7kpbHMu+hdvzynx7mfNxFYGQ/y0thoFn57XO1yPFamwB69hb3DMdRQHOtc?=
 =?us-ascii?Q?GezRpZUVyUEW2r4tj0YL/RJJFUUFN4IHduF1J6SAQnOEl+eZVvwFn2T8oysC?=
 =?us-ascii?Q?kEEu/osJrbeELSuxSRSOnK84tYocLMBbtZ6s+cS9HgSd6oTS/DAmN8ruUp2f?=
 =?us-ascii?Q?SffI6AR6vxy9TIZ3vEFgV2ucsM7J9mPOXFAD5w/eAnEehQVIuIIB4nygSMIH?=
 =?us-ascii?Q?mae4SrWEz6EYl1jSIZVxkxKo3MXfW3C0npaz01qb07xu81UtJJ1wZAp1CeWa?=
 =?us-ascii?Q?K4uwsoF9/9mraStdhOb6D0tCkXPZQshN1lbL4RoAk7pd9Rlff8yBoy/zPipL?=
 =?us-ascii?Q?ojs7l+12vv0TCVBT0GAYrkaqIWfQ/7rGGxY3BfB7pZtyGIm4c6hpna2b8P3P?=
 =?us-ascii?Q?pbTpzUR4iDskVYJ2n1Ixb2NcfHfFgV4Wf+FlnVbxLcr+eHjOHft7HjXoc2ow?=
 =?us-ascii?Q?bOdFjeifiKL3nJEZPv/s0JgebqtMf+uxjGGOCbPY24axDrH2ls0DPvr0Z7rD?=
 =?us-ascii?Q?ZPP6Xv6AH3rb7nBXSky+Vf+RIfDBIvvXrcqRPOw78EvGgMTRhBz/6f57tOkz?=
 =?us-ascii?Q?la5mTvVKgCmlIRLIH1A2EtlZwmuTQWTPzzqRQsAfbgV+Aq0AcsIKXRih46x4?=
 =?us-ascii?Q?joxySkwrsgvTwnfjsNUBV1jKh9QB8t1Lx+7U7A6zz3JygcRsBx8QvynO+AZo?=
 =?us-ascii?Q?ZHsyWSkm1PLvMoeqRSKHgfmNwWbP3w8PoStbyd/PJ7HXdOp+nWq7PwCIsZ1+?=
 =?us-ascii?Q?E1SAg6r7U8B5JqHBIVFSHJ5FWkepob2IQuFrvEX01of3uN6XR/+UDr1lJCiW?=
 =?us-ascii?Q?NJhamuZsaMjYpmdTNLevs2QggCRrmDD88ti25vRmYs1aHmdtHTqTUsKe0uGh?=
 =?us-ascii?Q?7RpypkSorQZQlqohXH5DYgLTF1kkUqUrCnRzTCz7EAaCdjP6g4tc2Sopm8Vs?=
 =?us-ascii?Q?wR4WJOapVCBWlqP+GygIX3Ri?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8665.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?W4kqjUSJCPapGzuwOaronO+y8TJRZ6oqukWDm8u65/qZTJzj7pz0p4gYhSQT?=
 =?us-ascii?Q?J//VPK+7TSswKKwUQ9+rHOBL74x2F7JF2Ws0g4RJxxOtEnqSKBf+t2utwRas?=
 =?us-ascii?Q?vavQhxqod/SlDQCizmLp9CyegIizaJmiUwYr10iPGJDe8UUc1J/RUMS4jl2L?=
 =?us-ascii?Q?uns+3dBTSXG06cpCYgYNqtpWSADHyejU8hPOfr8wrCCe2N6cOnvCKbxgRK/m?=
 =?us-ascii?Q?G/rzCmCRskw9Pu2Kf4LQX2/NFW5uuPCSluujsoBiA2kLj6U5pjdNmHq8MyBb?=
 =?us-ascii?Q?Er4F2TL7+dIaY2oQE02YF+xz+5YGIxCvJP6Kg63yVbszibuRUmmqdF3Xb97U?=
 =?us-ascii?Q?BP2ldvi40+u+ERcVMdm458RZqFzQgD/H9ChIdgsBme15jQ/zq8hvz6i0KWu9?=
 =?us-ascii?Q?PQdz+6nDjLMzgu700dCknrikEcFU04WgCMNRxbAYxCvNzQhJ3sBNGakCLgbp?=
 =?us-ascii?Q?LxeLoBmNuPv5+aNfsZIOxGnHXUrx2CTXXpDZdjVvXt9V4TcTqJ4pe5i4dSOF?=
 =?us-ascii?Q?l7kTtg48VVj2z7O/rX+PnkkGNyp2ch+1gnTidQ3UfJsP3Xo4Qpzp8foIxiPX?=
 =?us-ascii?Q?GFKzw2TZX15L30vxOzMkgFxqbBKzMORf7j/tcR5uTDoV4AKsBoED8ENSsXzN?=
 =?us-ascii?Q?ukTDtWW1gfBjDExgFdcu15ACA4abmV4J50SsPITv6N4AbuQRDNr09HfMgZz5?=
 =?us-ascii?Q?20J6lbTDKPqQZk2lMCF1MqTwjWwpSD5vnN0uLSyZljt3J8ilEYCnFyQZMdiz?=
 =?us-ascii?Q?6QPuHeuU6TojtwzByEb4BNKbR40+8nv4EUryjnIQu9kq34MMohvwz47NFYGe?=
 =?us-ascii?Q?TRO+CO1kC5xhukn3FX8NEI80iY0UsZHCEyhnyhJ9bPkfjlTLoM2DRKyGM8kr?=
 =?us-ascii?Q?EcdOw3h48cZsftUsur1Mv1yE5dVe+mEaTQzhu581+ZklbpdQDnvjLYDpV6Sw?=
 =?us-ascii?Q?WeWcqILDj6Qp940BFVb7nOWbgoie9DHyVZYnCRb6rH94SnyjmImI1n0l2w1o?=
 =?us-ascii?Q?OiKBwJLhvqT6ipKPrfk+SfBSM66atnHvalMjE1Fdm5PvTaMo1OvrKFctNANm?=
 =?us-ascii?Q?91W9kmzCz7eXIM8ailjmgMlUsUn3YwWjAkoqQpCplQx6HHWk67uiYLoYeLdu?=
 =?us-ascii?Q?rUEIvlTw6Vr5AyXJvng40w4jUlfe8BgHF4n7A6gTOoZVLYL/u2isBJ8LwYZT?=
 =?us-ascii?Q?JOHrnLeyFpCdUUUuuomvR9Y1bZSlh05QZpi2Pb/QffGSMhX75Y+anL3i9v2V?=
 =?us-ascii?Q?yYemXIt1ePL1l/rm4Wkrg5hQCB7Isy/qd2ZxF9t5Ht35K3TyUBBEV8Xbj1e1?=
 =?us-ascii?Q?Zt3At13KB2v+0y38zaY8neG8z+4zx0jlZRMZUOzH0HvImTIzC79YdN3aMdQ0?=
 =?us-ascii?Q?V3O94+j+BX3KRf7A2wKFukbYQE0MDSgif3u6+3pMlRZDsg6v31r98xGNDlFo?=
 =?us-ascii?Q?cxdJVPItQpsHZSiciJ3EXEiCjyKrS5NqgAxxyL01SUhI+DiP4KmEfDUSdUpn?=
 =?us-ascii?Q?Wax+cQI7aVvETTRSlX4LowFM2fwi2NfCRjSQ8GI2ny3pKZkJV9MVHmVbqFnj?=
 =?us-ascii?Q?vtQrek/2+mfem5F4Tig4/6mE8fomceDjPHHVW+Ci9zLas1pQYi38Pd7NNYiV?=
 =?us-ascii?Q?Aw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 70b7ec4e-3292-45bb-7a05-08dd07c25d73
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8665.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2024 11:15:53.1095
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IVVU5rkxP1LSUNtQxoA9aEAIvBM2Q9GZC13WMX7WolgJhGLfGHwLCW9tSXUao+OiwCI57mRoCjnEhtY3vvhzhA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR11MB6071
X-OriginatorOrg: intel.com

On Mon, Nov 18, 2024 at 12:08:28PM +0800, Justin Lai wrote:
> Add defines for hardware version id.
> 
> Signed-off-by: Justin Lai <justinlai0215@realtek.com>
> ---
>  drivers/net/ethernet/realtek/rtase/rtase.h      |  5 ++++-
>  drivers/net/ethernet/realtek/rtase/rtase_main.c | 12 ++++++------
>  2 files changed, 10 insertions(+), 7 deletions(-)
> 

The patch is addressed to the "net" tree, but "Fixes" tag is missing.
Also, the patch does not look like a bugfix it's rather an improvement
of coding style with no functional changes. That's why I doubt it should go
to the "net" tree.

Thanks,
Michal

