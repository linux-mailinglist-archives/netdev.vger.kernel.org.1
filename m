Return-Path: <netdev+bounces-305978-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 8IfKNWKxTmobSgIAu9opvQ
	(envelope-from <netdev+bounces-305978-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 22:21:54 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DC9372A2B0
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 22:21:54 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=OZYSWiWG;
	dmarc=pass (policy=none) header.from=intel.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305978-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-305978-lists+netdev=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E73E330065FC
	for <lists+netdev@lfdr.de>; Wed,  8 Jul 2026 20:21:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BDC336DA0F;
	Wed,  8 Jul 2026 20:21:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 716F22DF126
	for <netdev@vger.kernel.org>; Wed,  8 Jul 2026 20:21:50 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783542112; cv=fail; b=MMNXmcKOIIxki1s+qHSlZ432pLHlXF6FdxGAXXvEWdhNWs8AAimJT20avVcUlYHIYzUBXiBEzjGGcMfcyWQNQGq0cG3mbQgE3Owd8Q10vqrta5XuTZ0x8EG43u8o4fagYjJXM6Y+5KEVKKmauDOJKNvQH5v5RhOIY+4ngzdBHx4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783542112; c=relaxed/simple;
	bh=Aw4uZV0kqi8CpLj15q3Q8hzebH0HLiMHALcD5vrUQig=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=LrXVUIVr6S8n35Xub0XENjhgqTW+eyeUk+8gFaZlAvmJxx4sNaT1INvNXbNmD3zHFhw3hi8BVLSDf1ydj7IYyz6rovx0JlSKqq8s5oyxdZlSQxT968k4pnGuhd+zmvNmWUBVKOHn9R/fa6QPfiTPFDFZG4xqP+/h15e00YxZII0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OZYSWiWG; arc=fail smtp.client-ip=192.198.163.7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783542111; x=1815078111;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Aw4uZV0kqi8CpLj15q3Q8hzebH0HLiMHALcD5vrUQig=;
  b=OZYSWiWGq5gOCWiGhSFQVCFWP1Kwi604H4XOenJ/tRDB/Yo1hZKXxtlD
   7QWppdXUsIbWxNtIcQrCGLfmd3+N3ggbc/mHrA5N/SjuHBJLGEoFds6GJ
   u7gAAt8LuK6y0bdsLNkLRtwlTKOkUH6MLkeuXdcU4CTPoyiTezcCZ4QBW
   QPaLxHQklvrMqkSjJJ3eqIT8EwyqAC7i1op/g5/AEI843TwZ3yzwPiUPI
   zSFtZJJM2tKTfowwvPP4o13B7jRSTU7m3kSdtqxa8pClAvyU6UOsfbNaG
   zb6364pMdHEMPpiL4NT7TOfFblP5M+vOQolYn+frQCgerg7eZoZA7ChKI
   w==;
X-CSE-ConnectionGUID: ayhioZqcQA6FS/ESZrRtjQ==
X-CSE-MsgGUID: wrtqQM8LTFaQ7MX0j2/lGw==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="109763660"
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; 
   d="scan'208";a="109763660"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2026 13:21:49 -0700
X-CSE-ConnectionGUID: 8vGqCcg7QgSZRHU7YD+vaA==
X-CSE-MsgGUID: B9J7Ya6TTbetMEji1SWooA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; 
   d="scan'208";a="256303529"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2026 13:21:47 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Wed, 8 Jul 2026 13:21:46 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Wed, 8 Jul 2026 13:21:46 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.49) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Wed, 8 Jul 2026 13:21:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DzX/PoPhP57pgubSNsGjuAkdwJRIoi/nZkDR32NDudDMuu4yP7gex/iyDcmoN4aAiv4ZmDS7OaOwm4kbopxtsAAWOEHwzMkAQpNO70Ec42svU3NNa6+4nhWaPwHCyDdU8kBotHQXlcmFiMH3zzC1IKlP6/b59BI7V7aibnI7DHBGSQRO3tvO2YdVheWurA63ENl7Q9Jx5qoccErlsP4qCWAjE4Vc9p/Y25zplc1In5jcq4DiTVLp4m6r05cbzG1nOMCcoXTvWoqlx0ZWwIHf0/WcPwPTrDhs+dyiX0ArDtmVXe7m8JSpogPeKk5GSUAv6h29j+ex4081GjKDxWCPPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c3PXap9HuBPIJjbxR+2qF+i123YR1+aDjpmPLjUucu4=;
 b=SAjUVXaxdanv9GrWidxocA9PRSesud7+ZtvbIbMJGVSCEBl2Gm9rjPePULOgZ87UFkCtvTst66a9e9Y1af6CKYvIxUFo+JvepeBlM8D3lZYHNQ6gsYufPgnJ41zJfqoT2MgAqZZo0ZAxFeeKkaK7Dgpi25cVlDDwbq80m6wNTLHG5ikuSaGezqMsXpaXHWlHth4TgfQbRlKZpnVKBplRz3FBL/Ic/VWwsln9Jl40uUjGisxVVvhmaV9Ml13lSb0WAQPGCUYaFP1hUlnQ7hRaLC+qA9QCAJcgWFHOJsyUSkjtyt2m1ya53Gsy5/XmnvOn0CITbCL3Mj5D8IW0rX2LTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CO1PR11MB5073.namprd11.prod.outlook.com (2603:10b6:303:92::23)
 by SA1PR11MB5876.namprd11.prod.outlook.com (2603:10b6:806:22a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.9; Wed, 8 Jul 2026
 20:21:43 +0000
Received: from CO1PR11MB5073.namprd11.prod.outlook.com
 ([fe80::a153:939c:df8c:f4fe]) by CO1PR11MB5073.namprd11.prod.outlook.com
 ([fe80::a153:939c:df8c:f4fe%4]) with mapi id 15.21.0181.014; Wed, 8 Jul 2026
 20:21:42 +0000
Date: Wed, 8 Jul 2026 16:21:34 -0400
From: Rodrigo Vivi <rodrigo.vivi@intel.com>
To: "Tauro, Riana" <riana.tauro@intel.com>
CC: <intel-xe@lists.freedesktop.org>, <aravind.iddamsetty@linux.intel.com>,
	<kuba@kernel.org>, <anshuman.gupta@intel.com>,
	<joonas.lahtinen@linux.intel.com>, <simona.vetter@ffwll.ch>,
	<airlied@gmail.com>, <pratik.bari@intel.com>,
	<joshua.santosh.ranjan@intel.com>, <ashwin.kumar.kulkarni@intel.com>,
	<shubham.kumar@intel.com>, <ravi.kishore.koppuravuri@intel.com>,
	<raag.jadav@intel.com>, <maarten.lankhorst@linux.intel.com>,
	<mallesh.koujalagi@intel.com>, <soham.purkait@intel.com>, Zack McKevitt
	<zachary.mckevitt@oss.qualcomm.com>, Lijo Lazar <lijo.lazar@amd.com>,
	"Hawking Zhang" <Hawking.Zhang@amd.com>, "David S. Miller"
	<davem@davemloft.net>, "Paolo Abeni" <pabeni@redhat.com>, Eric Dumazet
	<edumazet@google.com>, <dri-devel@lists.freedesktop.org>,
	<netdev@vger.kernel.org>
Subject: Re: [PATCH v4 1/3] drm/drm_ras: Add drm_ras netlink error event
Message-ID: <ak6xThf9qeB0wqgK@intel.com>
References: <20260701094409.129131-5-riana.tauro@intel.com>
 <20260701094409.129131-6-riana.tauro@intel.com>
 <202f6d3a-c29b-491b-979f-1d8223f59108@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <202f6d3a-c29b-491b-979f-1d8223f59108@intel.com>
X-ClientProxiedBy: SJ0PR03CA0217.namprd03.prod.outlook.com
 (2603:10b6:a03:39f::12) To CO1PR11MB5073.namprd11.prod.outlook.com
 (2603:10b6:303:92::23)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5073:EE_|SA1PR11MB5876:EE_
X-MS-Office365-Filtering-Correlation-Id: 64997f39-6e25-498e-3c3b-08dedd2e862a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|23010399003|366016|1800799024|376014|18002099003|3023799007|6133799003|22082099003|56012099006|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info: VElXQUyVZ7eMAmQ9WkOhAYv6hdguDN6G5YJYQm8ysodlpUQjwDKiyKjY5O6hbdHZ9/e8Mx4gA0ntuqU7rbTfV4GYJcNRGJr5+XBmKMt+bUKXYttt7WA6SOGEj1x9XgHXA9Z4EZ0Fm8A8FXGpBo1+dG9gn3mTqbxDldEHkZOYA0e4pEkddJIqFY7IMPgpWRERYsMBAtzdT3sRNoo4HZKn8IYPuMq5FMMkTX+VWjxmdOt2l3LysUSr1T72vHlH1qcTkIX1uYppB1ZublDg3wzd3jb5hLFZSmbXqMnR4VZqqQS8RugAy8mfEtGJjjq9Qex+0H4Sc37YXUUn86SlK4vskBHzTouDDDBQsyhZ7VagvYkqB4CG0+7k8HQyfz5T0mdJjO6vZC7pCtiMo+KOY6zDxjseXyv2gtVd88kC7KKfdcOCALI6cso2bGCF50LPkVkApAR3dMBBJjU+gCCW52lAHc8zEdCwVzcg4hfvmHHB96QzjyceW90I0YlL+sWXxfcPS0NAkd0+KWfB42cHPRIWQNaR+vjJfZ75dGpYVU3SJt5Xlk3s81gQNkPDCmbFNSIZeocuLkJlWcMT4yFM/VSQLzD2yy7bNpEQh7A0lZBOug2ER5qYGpqKpc4xBUFEDH5ORhcSMYKg70gdNJl3ildGMBMnX/J3D4tZVKrUPPZ8W74=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5073.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(23010399003)(366016)(1800799024)(376014)(18002099003)(3023799007)(6133799003)(22082099003)(56012099006)(4143699003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PlC6Q98rdOXwUa39WnwB/OmZ6Ba4Fz2Why3MztV12Vu2/7GWAW69VCWsXIOy?=
 =?us-ascii?Q?MOwWUjdaKKQrzCMvlqb4JRFtToMenSgugaPHoMILt1192B0Wnu5aNk9czUr7?=
 =?us-ascii?Q?AdyVULOyllfe8DNaS7d8c38cFJBAExlEwdFDYrWW1HKDzLAe0q66HBpAVKS2?=
 =?us-ascii?Q?mS6L5+izLX9TLXLM/uOAX4z+iCkt49q9YDgYlgHy8EJXiKs2/AAUcixBeumd?=
 =?us-ascii?Q?xJstlPgTfHdtNfPicFqa6OcUDagQcdQpJ0tyWzlkVK9GGY+DcYVEZm0hZLgK?=
 =?us-ascii?Q?s5j8eBPAx/WHrdE5pNwnNNk5I+lWqe9WGRAZErGEruTo0vZnssAhzQAUnfWQ?=
 =?us-ascii?Q?DyFz4XVF6k84ptqiZE/BYvVbENYChPHsu6zYRxFfC050+0TwlD0iurE7xE/Z?=
 =?us-ascii?Q?ZBfQCtDj2YDuybmLMGwZj8yNKoSq/Wsh1ReUS6HxX/JpgQTtkLFvciHCU6wT?=
 =?us-ascii?Q?1LWYzOjgVyCZjizW1/s7JlH9EVl4MI5WX1tdyDkzQSy43s6c+VifcHkhkUhg?=
 =?us-ascii?Q?bM7UIGu86B2he23KohB6UalK3S4ICuIbTlR9Sh3RBm1ElzNeJNVkMd/mwX5B?=
 =?us-ascii?Q?AuKSo9E1ulvvyDcw6akx0DyYRKpHhlSNYvUmxfOFX+XAlkHjcX23dSTZK7YO?=
 =?us-ascii?Q?Q3thBfu9S5QUAz43bjMJYsx8/K2SKn/UJGH8kUmZNGzxYejiWL1uI6Do/pyD?=
 =?us-ascii?Q?qyGnxqgzt4NGGs03mAXxqx2YKXYyByU+laIcTus1eM46FGT96oylil3SXFXl?=
 =?us-ascii?Q?7oQn5lRJgeoKNGpMQ/+LuiCsIVLc8dEI1k6mf4jZTnYrRLvxfR8JtEzMM9bC?=
 =?us-ascii?Q?dd728/IralPlqGmFSoiDRUrOofCyRPRvG3v+EX8fyM2fsIvGa6FZkSYDg1Zx?=
 =?us-ascii?Q?LF3l+ktP/cAHc8Zr9nmwnEQwLhqVJAYFIJzBZbAQ8SpsFnE9+8U/Hpi+PkwR?=
 =?us-ascii?Q?B0udQk7tasb1z2B75ZrQ+W5tYHBO7Z1EGctFS1PnlfUOyORDQ0BLHa4NYa9p?=
 =?us-ascii?Q?Es7u7/+987e77ZhLFTvO03m1xJVwkYj/GDvUfNZsTaCgnHWAZp2+UBht6YrV?=
 =?us-ascii?Q?RuHqPHOpYcE9fmfzdzwRjiG4BAhoBP3yrnHJDzRBO6sarvhr0nj1zkeCwQuv?=
 =?us-ascii?Q?m77hgR196FEXwoLUZU7zkB+SdaQ43FpfFFhIialUTV8DLM8wjthy8ghSEAEh?=
 =?us-ascii?Q?9thUUM4bqFIqTwh/fg5xvkYg7oF3agWzsFomNsntFsuK5IDIJ8ey2HaZupWi?=
 =?us-ascii?Q?zzv40MZ6ZpRza1kWUdtLBNBHVV7uxzvh4zd+07iFduxO6aktZYlk7rNkn4eO?=
 =?us-ascii?Q?NkO6cs6B97wPvUsIZb4dKpgIdlPbDIeXr68BzOY70ZePQKjKWCbgA3hRyIUl?=
 =?us-ascii?Q?hfFYQA2DbrdaSTVzCft0QKkOTyAkTBEMWlxib8Kpqly1s9Vo2R/8rQPLhfQ8?=
 =?us-ascii?Q?sHjHiSB9p9Pa9cq+IOUC2D1BY66VCSFpKFx5RAI4YQy/nZOiEOcKsXZ5AGlD?=
 =?us-ascii?Q?y0V5kNdM8walDiOJn4ZJo0CR1rU6Dhfzz6wRBq0EIRa36+Ls6oAIaOa6bA+S?=
 =?us-ascii?Q?+rj3mWg48OuR3PaZJI/mOgB3HXR4tRf0/n0V4IZ/7bax9VkCRIzQ1Wb2Byye?=
 =?us-ascii?Q?x95vsSuRd4dEpmnaN/dFBnNDTda72ZXdm2nH0dcRA46gYkNbPHt3iILuEwTC?=
 =?us-ascii?Q?9HeCUmL+kslhQCBM76Z5W1qHYBCq6Zbgy3rbAaKd1k40DldtIQTCsfrJ1wCm?=
 =?us-ascii?Q?cpVkMNUcNQ=3D=3D?=
X-Exchange-RoutingPolicyChecked: UDI16nPEdIi2UwzDXKr/aPxNi/vC5q9Zk9Y8yAKqC7yF6QdKhATeXYkp7UtoIKisT9FCyzANv1ZXgbEaFVwFCL01sfzL7x/RQBGGXsIt3qrBBzPozlDD7NGMV2J2WNyiebmGSE+KWJqTB4OW4XiJgf+JxsBTWIkA8VCAokVTDmOeTfykj0H+DwKWdZp7uXk44yKNWrrfjM9sTpmVZVCUz2WJKhmdcgKLWydAzcn/pQExg2g43k2slJGTXjsd4/a9IVrWpmW+VBsTPBTSWXGGNqONouw2ljhosp+c3yPcbgIeg3F3KRGW0Pdk8REzKgH4+pPe2/m+UEa/DEHv9CboWg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 64997f39-6e25-498e-3c3b-08dedd2e862a
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5073.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2026 20:21:42.4390
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n2F8b9a7vW6WN3HwwrivyPaKTfU0rYGmWCXon/O96NFM1R/N0/RcD73Z8ibXbO3O1Gy9hVUjZCnayNp0PjLVZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB5876
X-OriginatorOrg: intel.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[25];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-305978-lists,netdev=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:riana.tauro@intel.com,m:intel-xe@lists.freedesktop.org,m:aravind.iddamsetty@linux.intel.com,m:kuba@kernel.org,m:anshuman.gupta@intel.com,m:joonas.lahtinen@linux.intel.com,m:simona.vetter@ffwll.ch,m:airlied@gmail.com,m:pratik.bari@intel.com,m:joshua.santosh.ranjan@intel.com,m:ashwin.kumar.kulkarni@intel.com,m:shubham.kumar@intel.com,m:ravi.kishore.koppuravuri@intel.com,m:raag.jadav@intel.com,m:maarten.lankhorst@linux.intel.com,m:mallesh.koujalagi@intel.com,m:soham.purkait@intel.com,m:zachary.mckevitt@oss.qualcomm.com,m:lijo.lazar@amd.com,m:Hawking.Zhang@amd.com,m:davem@davemloft.net,m:pabeni@redhat.com,m:edumazet@google.com,m:dri-devel@lists.freedesktop.org,m:netdev@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[rodrigo.vivi@intel.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[lists.freedesktop.org,linux.intel.com,kernel.org,intel.com,ffwll.ch,gmail.com,oss.qualcomm.com,amd.com,davemloft.net,redhat.com,google.com,vger.kernel.org];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,qualcomm.com:email,amd.com:email];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rodrigo.vivi@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7DC9372A2B0

On Tue, Jul 07, 2026 at 12:02:11PM +0530, Tauro, Riana wrote:
> Hi Rodrigo/Jakub/Aravind
> 
> Please let me know if you have any feedback for this patch or can you please
> ack this if it looks good to you.

I looks good to me, but could you please double check the sashiko's comments?

Patch 3 still needs review I believe, then we get Jakub and drm maintainers acks
to get this through drm-xe-next.

Thanks,
Rodrigo.

> 
> Thanks
> Riana
> 
> On 01-07-2026 15:14, Riana Tauro wrote:
> > Define a new netlink event 'error-event' and a new multicast group
> > 'error-report' in drm_ras. Each event contains device name, node and
> > error information to identify the error triggering the event.
> > 
> > Add drm_ras_nl_error_event() to trigger an event from the driver.
> > Userspace must subscribe to 'error-report' to receive 'error-event'
> > notifications.
> > 
> > Usage:
> > 
> > $ sudo ynl --family drm_ras --subscribe error-report
> > 
> > Cc: Jakub Kicinski <kuba@kernel.org>
> > Cc: Zack McKevitt <zachary.mckevitt@oss.qualcomm.com>
> > Cc: Lijo Lazar <lijo.lazar@amd.com>
> > Cc: Hawking Zhang <Hawking.Zhang@amd.com>
> > Cc: David S. Miller <davem@davemloft.net>
> > Cc: Paolo Abeni <pabeni@redhat.com>
> > Cc: Eric Dumazet <edumazet@google.com>
> > Signed-off-by: Riana Tauro <riana.tauro@intel.com>
> > Reviewed-by: Raag Jadav <raag.jadav@intel.com>
> > ---
> > v2: remove redundant initialization
> >      remove unnecessary space
> >      use ynl in commit message and doc (Raag)
> >      simplify doc for error-event attrs
> > 
> > v3: rename error-notify to error-report
> >      Replace notify with report across the file (Raag)
> > ---
> >   Documentation/gpu/drm-ras.rst            | 21 ++++++
> >   Documentation/netlink/specs/drm_ras.yaml | 48 +++++++++++++
> >   drivers/gpu/drm/drm_ras.c                | 87 ++++++++++++++++++++++++
> >   drivers/gpu/drm/drm_ras_nl.c             |  6 ++
> >   drivers/gpu/drm/drm_ras_nl.h             |  4 ++
> >   include/drm/drm_ras.h                    |  5 ++
> >   include/uapi/drm/drm_ras.h               | 15 ++++
> >   7 files changed, 186 insertions(+)
> > 
> > diff --git a/Documentation/gpu/drm-ras.rst b/Documentation/gpu/drm-ras.rst
> > index 83c21853b74b..406e4c49bac1 100644
> > --- a/Documentation/gpu/drm-ras.rst
> > +++ b/Documentation/gpu/drm-ras.rst
> > @@ -56,6 +56,7 @@ User space tools can:
> >     ``node-id`` and ``error-id`` as parameters.
> >   * Clear specific error counters with the ``clear-error-counter`` command, using both
> >     ``node-id`` and ``error-id`` as parameters.
> > +* Subscribe to the ``error-report`` multicast group to receive ``error-event``.
> >   YAML-based Interface
> >   --------------------
> > @@ -111,3 +112,23 @@ Example: Clear an error counter for a given node
> >       sudo ynl --family drm_ras --do clear-error-counter --json '{"node-id":0, "error-id":1}'
> >       None
> > +
> > +Example: Subscribe to ``error-report`` multicast group
> > +
> > +.. code-block:: bash
> > +
> > +    sudo ynl --family drm_ras --output-json --subscribe error-report
> > +
> > +.. code-block:: json
> > +
> > +    {
> > +        "name": "error-event",
> > +        "msg": {
> > +            "device-name": "0000:03:00.0",
> > +            "node-id": 1,
> > +            "node-name": "uncorrectable-errors",
> > +            "error-id": 1,
> > +            "error-name": "error_name1",
> > +            "error-value": 1
> > +        }
> > +    }
> > diff --git a/Documentation/netlink/specs/drm_ras.yaml b/Documentation/netlink/specs/drm_ras.yaml
> > index e113056f8c01..8aed3d4515e5 100644
> > --- a/Documentation/netlink/specs/drm_ras.yaml
> > +++ b/Documentation/netlink/specs/drm_ras.yaml
> > @@ -69,6 +69,33 @@ attribute-sets:
> >           name: error-value
> >           type: u32
> >           doc: Current value of the requested error counter.
> > +  -
> > +    name: error-event-attrs
> > +    attributes:
> > +      -
> > +        name: device-name
> > +        type: string
> > +        doc: Device (PCI BDF, UUID) that reported the error.
> > +      -
> > +        name: node-id
> > +        type: u32
> > +        doc: ID of the node that reported the error.
> > +      -
> > +        name: node-name
> > +        type: string
> > +        doc: Name of the node that reported the error.
> > +      -
> > +        name: error-id
> > +        type: u32
> > +        doc: ID of the error counter.
> > +      -
> > +        name: error-name
> > +        type: string
> > +        doc: Name of the error.
> > +      -
> > +        name: error-value
> > +        type: u32
> > +        doc: Current value of the error counter.
> >   operations:
> >     list:
> > @@ -124,3 +151,24 @@ operations:
> >         do:
> >           request:
> >             attributes: *id-attrs
> > +    -
> > +      name: error-event
> > +      doc: >-
> > +           Report an error event to userspace.
> > +           The event includes the device, node and error information
> > +           of the error that triggered the event.
> > +      attribute-set: error-event-attrs
> > +      mcgrp: error-report
> > +      event:
> > +        attributes:
> > +          - device-name
> > +          - node-id
> > +          - node-name
> > +          - error-id
> > +          - error-name
> > +          - error-value
> > +
> > +mcast-groups:
> > +  list:
> > +    -
> > +      name: error-report
> > diff --git a/drivers/gpu/drm/drm_ras.c b/drivers/gpu/drm/drm_ras.c
> > index d6eab29a1394..77f912a4d101 100644
> > --- a/drivers/gpu/drm/drm_ras.c
> > +++ b/drivers/gpu/drm/drm_ras.c
> > @@ -41,6 +41,11 @@
> >    *    Userspace must provide Node ID, Error ID.
> >    *    Clears specific error counter of a node if supported.
> >    *
> > + * 4. ERROR_REPORT: Subscribe to this multicast group to receive error events
> > + *
> > + * 5. ERROR_EVENT: Report an error event to userspace. The event contains device, node
> > + *    and error information that triggered the event.
> > + *
> >    * Node registration:
> >    *
> >    * - drm_ras_node_register(): Registers a new node and assigns
> > @@ -186,6 +191,34 @@ static int msg_reply_value(struct sk_buff *msg, u32 error_id,
> >   			   value);
> >   }
> > +static int msg_put_error_event_attrs(struct sk_buff *msg, struct drm_ras_node *node,
> > +				     u32 error_id, const char *error_name, u32 value)
> > +{
> > +	int ret;
> > +
> > +	ret = nla_put_string(msg, DRM_RAS_A_ERROR_EVENT_ATTRS_DEVICE_NAME, node->device_name);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret = nla_put_u32(msg, DRM_RAS_A_ERROR_EVENT_ATTRS_NODE_ID, node->id);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret = nla_put_string(msg, DRM_RAS_A_ERROR_EVENT_ATTRS_NODE_NAME, node->node_name);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret = nla_put_u32(msg, DRM_RAS_A_ERROR_EVENT_ATTRS_ERROR_ID, error_id);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret = nla_put_string(msg, DRM_RAS_A_ERROR_EVENT_ATTRS_ERROR_NAME, error_name);
> > +	if (ret)
> > +		return ret;
> > +
> > +	return nla_put_u32(msg, DRM_RAS_A_ERROR_EVENT_ATTRS_ERROR_VALUE, value);
> > +}
> > +
> >   static int doit_reply_value(struct genl_info *info, u32 node_id,
> >   			    u32 error_id)
> >   {
> > @@ -222,6 +255,60 @@ static int doit_reply_value(struct genl_info *info, u32 node_id,
> >   	return genlmsg_reply(msg, info);
> >   }
> > +/**
> > + * drm_ras_nl_error_event() - Report an error event
> > + * @node: Node structure
> > + * @error_id: ID of the error
> > + * @error_name: Name of the error
> > + * @value: Value associated with the error
> > + * @flags: GFP flags for memory allocation
> > + *
> > + * Report an error-event to userspace using the error-report multicast group.
> > + *
> > + * Return: 0 on success, or negative errno on failure.
> > + */
> > +int drm_ras_nl_error_event(struct drm_ras_node *node, u32 error_id, const char *error_name,
> > +			   u32 value, gfp_t flags)
> > +{
> > +	struct genl_info info;
> > +	struct sk_buff *msg;
> > +	struct nlattr *hdr;
> > +	int ret;
> > +
> > +	if (!error_name)
> > +		return -EINVAL;
> > +
> > +	if (!genl_has_listeners(&drm_ras_nl_family, &init_net, DRM_RAS_NLGRP_ERROR_REPORT))
> > +		return 0;
> > +
> > +	genl_info_init_ntf(&info, &drm_ras_nl_family, DRM_RAS_CMD_ERROR_EVENT);
> > +
> > +	msg = genlmsg_new(NLMSG_GOODSIZE, flags);
> > +	if (!msg)
> > +		return -ENOMEM;
> > +
> > +	hdr = genlmsg_iput(msg, &info);
> > +	if (!hdr) {
> > +		ret = -EMSGSIZE;
> > +		goto free_msg;
> > +	}
> > +
> > +	ret = msg_put_error_event_attrs(msg, node, error_id, error_name, value);
> > +	if (ret)
> > +		goto cancel_msg;
> > +
> > +	genlmsg_end(msg, hdr);
> > +	genlmsg_multicast(&drm_ras_nl_family, msg, 0, DRM_RAS_NLGRP_ERROR_REPORT, flags);
> > +	return 0;
> > +
> > +cancel_msg:
> > +	genlmsg_cancel(msg, hdr);
> > +free_msg:
> > +	nlmsg_free(msg);
> > +	return ret;
> > +}
> > +EXPORT_SYMBOL(drm_ras_nl_error_event);
> > +
> >   /**
> >    * drm_ras_nl_get_error_counter_dumpit() - Dump all Error Counters
> >    * @skb: Netlink message buffer
> > diff --git a/drivers/gpu/drm/drm_ras_nl.c b/drivers/gpu/drm/drm_ras_nl.c
> > index dea1c1b2494e..9d3123cc9f9c 100644
> > --- a/drivers/gpu/drm/drm_ras_nl.c
> > +++ b/drivers/gpu/drm/drm_ras_nl.c
> > @@ -58,6 +58,10 @@ static const struct genl_split_ops drm_ras_nl_ops[] = {
> >   	},
> >   };
> > +static const struct genl_multicast_group drm_ras_nl_mcgrps[] = {
> > +	[DRM_RAS_NLGRP_ERROR_REPORT] = { "error-report", },
> > +};
> > +
> >   struct genl_family drm_ras_nl_family __ro_after_init = {
> >   	.name		= DRM_RAS_FAMILY_NAME,
> >   	.version	= DRM_RAS_FAMILY_VERSION,
> > @@ -66,4 +70,6 @@ struct genl_family drm_ras_nl_family __ro_after_init = {
> >   	.module		= THIS_MODULE,
> >   	.split_ops	= drm_ras_nl_ops,
> >   	.n_split_ops	= ARRAY_SIZE(drm_ras_nl_ops),
> > +	.mcgrps		= drm_ras_nl_mcgrps,
> > +	.n_mcgrps	= ARRAY_SIZE(drm_ras_nl_mcgrps),
> >   };
> > diff --git a/drivers/gpu/drm/drm_ras_nl.h b/drivers/gpu/drm/drm_ras_nl.h
> > index a398643572a5..03ec275aca92 100644
> > --- a/drivers/gpu/drm/drm_ras_nl.h
> > +++ b/drivers/gpu/drm/drm_ras_nl.h
> > @@ -21,6 +21,10 @@ int drm_ras_nl_get_error_counter_dumpit(struct sk_buff *skb,
> >   int drm_ras_nl_clear_error_counter_doit(struct sk_buff *skb,
> >   					struct genl_info *info);
> > +enum {
> > +	DRM_RAS_NLGRP_ERROR_REPORT,
> > +};
> > +
> >   extern struct genl_family drm_ras_nl_family;
> >   #endif /* _LINUX_DRM_RAS_GEN_H */
> > diff --git a/include/drm/drm_ras.h b/include/drm/drm_ras.h
> > index 0beede3ddc4e..8abfb7d2077b 100644
> > --- a/include/drm/drm_ras.h
> > +++ b/include/drm/drm_ras.h
> > @@ -80,9 +80,14 @@ struct drm_device;
> >   #if IS_ENABLED(CONFIG_DRM_RAS)
> >   int drm_ras_node_register(struct drm_ras_node *node);
> >   void drm_ras_node_unregister(struct drm_ras_node *node);
> > +int drm_ras_nl_error_event(struct drm_ras_node *node, u32 error_id, const char *error_name,
> > +			   u32 value, gfp_t flags);
> >   #else
> >   static inline int drm_ras_node_register(struct drm_ras_node *node) { return 0; }
> >   static inline void drm_ras_node_unregister(struct drm_ras_node *node) { }
> > +static inline int drm_ras_nl_error_event(struct drm_ras_node *node, u32 error_id,
> > +					 const char *error_name, u32 value, gfp_t flags)
> > +{ return 0; }
> >   #endif
> >   #endif
> > diff --git a/include/uapi/drm/drm_ras.h b/include/uapi/drm/drm_ras.h
> > index 218a3ee86805..eab8231aa87c 100644
> > --- a/include/uapi/drm/drm_ras.h
> > +++ b/include/uapi/drm/drm_ras.h
> > @@ -38,13 +38,28 @@ enum {
> >   	DRM_RAS_A_ERROR_COUNTER_ATTRS_MAX = (__DRM_RAS_A_ERROR_COUNTER_ATTRS_MAX - 1)
> >   };
> > +enum {
> > +	DRM_RAS_A_ERROR_EVENT_ATTRS_DEVICE_NAME = 1,
> > +	DRM_RAS_A_ERROR_EVENT_ATTRS_NODE_ID,
> > +	DRM_RAS_A_ERROR_EVENT_ATTRS_NODE_NAME,
> > +	DRM_RAS_A_ERROR_EVENT_ATTRS_ERROR_ID,
> > +	DRM_RAS_A_ERROR_EVENT_ATTRS_ERROR_NAME,
> > +	DRM_RAS_A_ERROR_EVENT_ATTRS_ERROR_VALUE,
> > +
> > +	__DRM_RAS_A_ERROR_EVENT_ATTRS_MAX,
> > +	DRM_RAS_A_ERROR_EVENT_ATTRS_MAX = (__DRM_RAS_A_ERROR_EVENT_ATTRS_MAX - 1)
> > +};
> > +
> >   enum {
> >   	DRM_RAS_CMD_LIST_NODES = 1,
> >   	DRM_RAS_CMD_GET_ERROR_COUNTER,
> >   	DRM_RAS_CMD_CLEAR_ERROR_COUNTER,
> > +	DRM_RAS_CMD_ERROR_EVENT,
> >   	__DRM_RAS_CMD_MAX,
> >   	DRM_RAS_CMD_MAX = (__DRM_RAS_CMD_MAX - 1)
> >   };
> > +#define DRM_RAS_MCGRP_ERROR_REPORT	"error-report"
> > +
> >   #endif /* _UAPI_LINUX_DRM_RAS_H */

