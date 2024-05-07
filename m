Return-Path: <netdev+bounces-94217-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF6AF8BEA13
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 19:08:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6488528AB51
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 17:08:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD6B814D2A5;
	Tue,  7 May 2024 17:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iQv7dLqQ"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B76713D63B;
	Tue,  7 May 2024 17:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715101704; cv=fail; b=DsoodNdpULo7ysH5fB81jdHJuTgS5QDOfr9iophv2yDQ95y5h6WrJazzfck/UvUAoFtUiWnjrUFTMIdELEZCmx0COCSmrOQ6i5IEybMpg4YTlBlZY+1NejJT3zzs3WyN+GWca1s/Z+IJ+2pPy2F4dDlv3U9qAemKCRxOMcvZFrY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715101704; c=relaxed/simple;
	bh=pif7IB1RyDjQADtuWU/f3pH17jWYI85A+czP09gB/7I=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ADuPK6a4+wmytMnyjFsrAJ8GEZIFmoOo8hUzjWXRRVJhM8GSkgVX+g426ehGX1GcGxRwkmCEj5F1lOOKlDiGamuvcgRqaImQWINBKt/FFeZSElNolbPzzfAI5uWgHlDQMIcSGks+czMW4BiZDofjN/L+TzaL0HiBaR36AQM0E5I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iQv7dLqQ; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715101704; x=1746637704;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=pif7IB1RyDjQADtuWU/f3pH17jWYI85A+czP09gB/7I=;
  b=iQv7dLqQx4NaaGTKDkpJffSB5F82Co/bnx1XWvUXdyLvSQP37NeQPnV5
   3vbvRV8rXVbECHEu/mzoZw3lc4VJcgV4HrJScrL/BIRIp1nlK8erWCiYn
   vU6BndkCQTbEBzw/w/EdDkbdSAqrMlhazSMhZ8nh7Fp3h4Y9wtBeuCxtt
   APNXxMcVoEDwOzYOvD+4A0lBuRVjVfE/OjU/hns8MjlRakxyHJRU+RBMt
   as8Xie0E1o19ALnWGeSUvVlXzGQum7drEjkM/6daVoUef6U763BtfZa4C
   LPtHzrH6LsHcbi+gmLWB5WY+Ux74Yx4wo7yUDkSuQoIbnULbMFcSIGJbL
   g==;
X-CSE-ConnectionGUID: pBKAnNhOT7ysbdV1ZJwVPg==
X-CSE-MsgGUID: URq42jSdRgeBSZB/o323bg==
X-IronPort-AV: E=McAfee;i="6600,9927,11066"; a="33425208"
X-IronPort-AV: E=Sophos;i="6.08,142,1712646000"; 
   d="scan'208";a="33425208"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2024 10:08:18 -0700
X-CSE-ConnectionGUID: gYXUEwEKRvi2LJLCQK42qQ==
X-CSE-MsgGUID: Dxjn447bTFW9sXMPU6m+kQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,142,1712646000"; 
   d="scan'208";a="59758384"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 07 May 2024 10:08:14 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 7 May 2024 10:08:13 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 7 May 2024 10:08:13 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 7 May 2024 10:08:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jeNV2RvNiRgqrhCZDNJgrX2BcVo7mB/UyDvbhXZjNWcdHRvjXaGunU3v6HKEB7Z+804esS/qQxwdG1kdMuUYY2osgbiwOnjl+6cqcIFHKG3/FZ4ZHLVZ4/0+2/zl146rtNZOEOklmX+THqFDxkaQT7+kyWdpX6u2HBImfiRLFC5vY1ijKaFnUULAve5Sv8YFwlhyMO67mageVKApKhBmBvb65gNmvUi0iI1/EZNnQ1aTz94hJ2/4gwUZCbv0otwmCbNj3NkjLNO0XIZhnf5/2EsdN4wm1A7nUJfzDeFMbZPAE5RkNfdfe2x55V3AhMaJRLJK4Bu8FYthJNHeTOhvIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vv5cHFLpWaDDLWsFCGe3MccOzAckEGjprEI3MdfTwrQ=;
 b=dYrKHdUieMweZPl57bgSfEgr3h+ZkgeCiPjXQFM+LHJUlg25FeAy7FhEF8EeXWCAxQkV8r01Phh/NZpW4oC8z524J1BqIf+9zEWcEDOtxdeu3WNAkshayXoAPHjk0jf+rZcgH9py8OtNfoH5L0QAvGc8ooLrOtQQgKCe0E9aJy5OOVxArR3bZvUM7IhkPFZbFwPmkRaCm+LcOBhQMF0KVbxgg2zcDaw4ByW+iLQ5hB9EzW6eTPKRsbbmXX3Ch8OtOufFmI6AtLDj2M8wWW1OOrOlNqMiKun0305CVbL2igQItcMjPwTp/PTa1uILgPsOw2OtVM1SDmzUR85FWBoRvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB7540.namprd11.prod.outlook.com (2603:10b6:806:340::7)
 by DM4PR11MB8092.namprd11.prod.outlook.com (2603:10b6:8:184::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.43; Tue, 7 May
 2024 17:08:09 +0000
Received: from SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::faf8:463a:6c86:5996]) by SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::faf8:463a:6c86:5996%6]) with mapi id 15.20.7544.041; Tue, 7 May 2024
 17:08:09 +0000
Date: Tue, 7 May 2024 19:08:01 +0200
From: Larysa Zaremba <larysa.zaremba@intel.com>
To: Simon Horman <horms@kernel.org>
CC: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Jeroen de Borst <jeroendb@google.com>, "Praveen
 Kaligineedi" <pkaligineedi@google.com>, Shailend Chand <shailend@google.com>,
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers
	<ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, Justin Stitt
	<justinstitt@google.com>, Dan Carpenter <dan.carpenter@linaro.org>, Kees Cook
	<keescook@chromium.org>, <netdev@vger.kernel.org>, <llvm@lists.linux.dev>,
	<linux-hardening@vger.kernel.org>
Subject: Re: [PATCH net-next 0/2] gve: Minor cleanups
Message-ID: <Zjpf8TqVqt8aCsOp@lzaremba-mobl.ger.corp.intel.com>
References: <20240503-gve-comma-v1-0-b50f965694ef@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240503-gve-comma-v1-0-b50f965694ef@kernel.org>
X-ClientProxiedBy: WA2P291CA0027.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1f::18) To SN7PR11MB7540.namprd11.prod.outlook.com
 (2603:10b6:806:340::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB7540:EE_|DM4PR11MB8092:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e2a1e5d-c957-41ee-2c46-08dc6eb844e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|7416005|1800799015;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?jVcZEfTlwpaw83rpa2kraYfJ/xaSVppvMF4u8+Z70Pfj8HXfq1PV350+DEYF?=
 =?us-ascii?Q?CHQ/ZbSu2mab/5CQ9QzbvAf6KB+xurPnDqUx0amMt+ukOgBCyjsy7m2znfmY?=
 =?us-ascii?Q?VXa60z0bxXZjAljZQR4wiXTGCL1UrBq/U/CHh8FK/4FY8S3R5N1SEClYFKaK?=
 =?us-ascii?Q?ItwXNpXGM0fdx2n7uRxJCgk4dfhl93z4R6I6Brd12oaxY3HJ6RucTP/tSSnn?=
 =?us-ascii?Q?U3iqqmbstLqWO+BCDX6Ir9OrYDBWEjmJ6kYzT5Wc4KEuSL+prBoU7cZVAF9e?=
 =?us-ascii?Q?+grollApRZvVfZE4rLoVQVQW7UMeU5mtK4hhnbxb5iy42v/f6r1tb0QQ5Kbz?=
 =?us-ascii?Q?7dmCb+CxH8wp9NdWHLUoTCyPd9X7Xj3ySjNm0NzQF42vo3s6doijt6wgprPe?=
 =?us-ascii?Q?lJuFWic4b1FGFhfO1sOp5VYyZvH1ku2tzCeW00P6QKTiDNoxCnmVdhhVHTeW?=
 =?us-ascii?Q?KI+eYPoBaTrbnmojT3b4QY0gyfJ9w6TAb5Fpmq502Ne+msYme/OY7DFwTiBU?=
 =?us-ascii?Q?Hudn8adfHogzU9a/A1XEbDQY4DEHWUsk1AarJi1Ncleg9u1QtuKvOmWDJb4V?=
 =?us-ascii?Q?n4i9jk8VakdhbkoIb/wSFdF4jyPPJLNAl1eThgPTKyVr4qyNDFvCC2dNDP4/?=
 =?us-ascii?Q?VbVe5MikBtHbDmIRPdpH+i3MZmD4frIGXBdMjggUboSyxD8OVTSq+9hmL9My?=
 =?us-ascii?Q?5r/VMtovfi8ByNgoiXG7UeMi47TWKXoo2T6GtiAT9ySWrACrycj4feLiAtkO?=
 =?us-ascii?Q?N2p7pEfgJHIz44WV7cfIKlpISx8da4YPPDv7EGhihY2RvZZas1cysn4u0dV+?=
 =?us-ascii?Q?/4IpC7a/cLYW4Ryd5jdmPh38oyDNKaHe8KK/IFhbvl8kuRDDTpqq96r1fET4?=
 =?us-ascii?Q?nX6GMI9crkiuRKbr/Jl6xrwbAkp0Y4J6sJNRrvbFXxmdf0kbW2WK+WW+BCjq?=
 =?us-ascii?Q?NPqquO2fCTq2msgEYI8BUSdP2p2x7EQ9NhLmDdVvCT+0Z0xqyaWHl91ls6kk?=
 =?us-ascii?Q?Acz2SLsiNMeerXJkLD4IJi9e/12vWrDuG+bx/1cmwd7oUnLfxP0k0G6QEidO?=
 =?us-ascii?Q?lkR9mWcA8BrhlsBqAPw7qWWeKTSGrB6zu1XCyfYJsPjBPKNW9v8Nq/RcXsGL?=
 =?us-ascii?Q?UqXPtAP6wwFtyZ2dDGXhJyNUs3zgYq0Ax2qoL0oOVjskVuZTXN8LXV+mUcbU?=
 =?us-ascii?Q?N8xOAi9JzcJjtGWjDm00C8yeb5DhUhRQMc4X4DaHL9QHj67xZ0eQHhrHdJt2?=
 =?us-ascii?Q?KyB0x/Yfd2DNSDDCqexiRoA99Yq4Q4ZBxWFYlFjkLw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB7540.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(7416005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JV3ZfM+t/Voe6ufaa7aPgdtXXhmH5SnyuULqgMzT37sTur1gFWB6NlyjMb8h?=
 =?us-ascii?Q?U7/4Q1RbVwSIriFQvEt6SSZddoAy13SbePKzPP1xHVlH9+Df8pd7Evw3XuA5?=
 =?us-ascii?Q?d0oYBJoBC+7ZABPGokBH5bF7e1w0PvfQf/G7/YdZHXkWMSYXtWrFl64GajRd?=
 =?us-ascii?Q?/RQd6PA91T3n2tUWDOs15qQBOEk30JQADj1gLYTJ11ilCd8w72TCgt8hYG4l?=
 =?us-ascii?Q?HIeF2jmcBQRnSgd8OJFsJupFURF3n2mHSDL6cvTayFAdLTlpmQ/XUZ5VfwUq?=
 =?us-ascii?Q?qFfbFXitNJRjHDB4ystrPXAIl3XaOzurJ+rXnllreF3EG5tQwwJsRDlQqPGZ?=
 =?us-ascii?Q?5joR9hfr6JsguRQ3sSOCmHAPYa0jiV41OY5HhKSfRx8IvKbQNxCxOSeyIiau?=
 =?us-ascii?Q?izsGkcdLs9qBmOVwUtYeK1S4wqxY1KlQA9rQF3dIgboDpVuAw7ZwrjTLBsFo?=
 =?us-ascii?Q?UWiRtJjVdAzSpj30nuBRX05m5REEIU67vjfx+wS/88oF+/kSV914P4ahovwN?=
 =?us-ascii?Q?h6vv0U5HrEedfgaGAq7RxJO2LFLTMuCp4u/qu9FrQUWCGoMbh9WzEGtNgsdP?=
 =?us-ascii?Q?M4g46WDtxkhmKCivFHXlCLPUtvahbB3G8SiHZrnCWEgFvNFt4YchDwQtk/bh?=
 =?us-ascii?Q?x4t2SPjQ+SJmAy0i5wb95+2bFR/Xmhxq4JY98WwXi1Ixbv984FP9xXbgkgne?=
 =?us-ascii?Q?KaztzMKw+5jo3ixgDBdihXBhZqMNLX3e+gbm4PbzlaRY5YJhph+vrkAWfePz?=
 =?us-ascii?Q?X1d83tArH7ZsSPj8f8YL6yUEp+mS+gSUlSxWkhHR8WmxcKMsMUDmO30JHwj8?=
 =?us-ascii?Q?lSZU5/qoUZhuQdi8nrtcKWEnIY/5rYrDJ9Rw0CPRFs0WP+XjQoIqcM+PRHrm?=
 =?us-ascii?Q?7MotYwb2XK3ZWbfc5z62skVRV5D3TidSJJscVaOJSfjbEiuvzwX+FrWM7zsD?=
 =?us-ascii?Q?mWlesh99ldBjIFRwm8dJ0viubYuhg0lpltUFrwl5DtB7NsIAPZMvks/v/ekR?=
 =?us-ascii?Q?rJUhrvUJAlTUTYk4D1Q/XG/JDmE6E4Bbrysdrf52kPf3El4nR4AtZemmWa8w?=
 =?us-ascii?Q?/gP2YAl0D0uqtFZjQeV1DwFnL4BATYhTMehY1LjXnf5eCBf7xHWuJQ51ddCm?=
 =?us-ascii?Q?XlBrOr5iOwEBZP6J3P8pB63FGtMHw4uitBwA3RPTOYAwd8ALXBBzG8in3mOp?=
 =?us-ascii?Q?dBoD97HL0dDwM44uK7OknguU5YCLQO5+58X2ZPZZkWtBGPEXf+xiBOJDrlcf?=
 =?us-ascii?Q?K3sGcQ898yQGlA9OEvFKEtx15WnXg+0MtSYULFJjRxafDYbAmgaXiB+pSjUq?=
 =?us-ascii?Q?UgF6Ybe2b2/CzP8z2KJZJDQxQx3aH1hhTaxNqz2aNFYURAxc7jBBbH+0wIPa?=
 =?us-ascii?Q?uNXlijDmQJsTz9OlMIIG/hL4mblqi2LenGEwq8B1fRJloU0lwcJAD1g3959s?=
 =?us-ascii?Q?/iSV2Fe/dt6XyeMHKsQpGa0eGATB9O5Hog7G7xjc7RupPx3tp+44JBmU8dBe?=
 =?us-ascii?Q?myVX5qQqHLhgbqepgARy3SpNGD9L7+xHcCxjam1gBKwKfTkeJYkx2MjceY69?=
 =?us-ascii?Q?sQcFWUJfD8bd/FQT8R7RLQvcQuD05TRotbmrg9v/MKLR0TLL0XRwQ41wsfGT?=
 =?us-ascii?Q?5A=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e2a1e5d-c957-41ee-2c46-08dc6eb844e0
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7540.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2024 17:08:09.0146
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WTN05QlCiG80pLtTYjXpMqR/pCV9nMrXtwc36qg14uSSeZlWDlLimf+8Iwmoy4zF6yJ0//H4zzKkT+YWQvs525l+2kIQFqY0mbyIiAt02Vc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB8092
X-OriginatorOrg: intel.com

On Fri, May 03, 2024 at 09:31:25PM +0100, Simon Horman wrote:
> Hi,
> 
> This short patchset provides two minor cleanups for the gve driver.
> 
> These were found by tooling as mentioned in each patch,
> and otherwise by inspection.
> 
> No change in run time behaviour is intended.
> Each patch is compile tested only.
>

Both patches look fine to me.

Reviewed-by: Larysa Zaremba <larysa.zaremba@intel.com>
 
> ---
> Simon Horman (2):
>       gve: Avoid unnecessary use of comma operator
>       gve: Use ethtool_sprintf/puts() to fill stats strings
> 
>  drivers/net/ethernet/google/gve/gve_adminq.c  |  4 +--
>  drivers/net/ethernet/google/gve/gve_ethtool.c | 42 +++++++++++----------------
>  2 files changed, 19 insertions(+), 27 deletions(-)
> 
> base-commit: 5829614a7b3b2cc9820efb2d29a205c00d748fcf
> 
> 

