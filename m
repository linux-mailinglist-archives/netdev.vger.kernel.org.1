Return-Path: <netdev+bounces-173828-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A4EBA5BE3B
	for <lists+netdev@lfdr.de>; Tue, 11 Mar 2025 11:52:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5BE4F16E292
	for <lists+netdev@lfdr.de>; Tue, 11 Mar 2025 10:52:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A434C2505AE;
	Tue, 11 Mar 2025 10:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XZ9S3mo6"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ABFF2222CA
	for <netdev@vger.kernel.org>; Tue, 11 Mar 2025 10:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741690348; cv=fail; b=ZZS2unTznmwkHgmKfcgAGZU+U95v8pFl3ibBR7QxFVvD/arrsSYHOXxv75MJYqNvKaROiCjkFODN5EzNT2DKJL4Fme64o8BPoP990ulyi2m46rjlxKP1bcDW9d8YY4LKjiqFgDzfy5FYkgSJVkGhk/eq67Hz5Vcppgyo2RCwaOc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741690348; c=relaxed/simple;
	bh=Uv4bQhg3wvtUSgzq5z4ETnQdopX71p2FqRKhLg8uToU=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=hJdE1y0UIuyCJa8VBviCRXn5t7knLXLPpGgmCsoNZxK+t6B4HVvLnJXKtUDnl8EF467LRVOeqsJOLuB8Br78ZG2tKpwG5K2NRiFdyitsZrDoZAfVHsyZ/NlsZn7bt5NWGpJC1xVTEUr2tEsuaFPTYo81h8H5gV22PUDnWRHNFR8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XZ9S3mo6; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741690347; x=1773226347;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Uv4bQhg3wvtUSgzq5z4ETnQdopX71p2FqRKhLg8uToU=;
  b=XZ9S3mo6tsqtolB8Qhet7e+EXBzKImuixj3MLZXSsgQcHYv46XP0DHaU
   PY+1scM8YHYQ9SFrshNEDw5qIhaBbczN7ATZiup9qNAg3f5XSV3bYKjMX
   bYTLfZKHu5ZTtE4na7b0TnOvqV3Y+7irST9KoVy0ZHVX/vWXbj94/sk15
   ufn6suYNyKpD9r35Pr7YmfB96ZmGgSdS1geMqPAFF5vPmNtI/vCEHI5Pa
   ZymIlHC7CsK5C8B7aE8K8j96BkE0KKaDt6XWJLKJMWy9/Fy2CQKdx3M4P
   OBNBTtNpZ+jvy5cut4hp9riV6JWrxes2ngxREWmx0gEeuqRvqb1Rw1/KG
   A==;
X-CSE-ConnectionGUID: UuYeeOykSKuRtrHiH9IlDw==
X-CSE-MsgGUID: rCA9AAPdTEOKEwJUcFXfEQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11369"; a="53715383"
X-IronPort-AV: E=Sophos;i="6.14,238,1736841600"; 
   d="scan'208";a="53715383"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2025 03:52:26 -0700
X-CSE-ConnectionGUID: UxlIhV35R1ikT5IutT29tQ==
X-CSE-MsgGUID: qjzSTVcuQq+5vp+Ub0NDpQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,238,1736841600"; 
   d="scan'208";a="120770643"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2025 03:52:25 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 11 Mar 2025 03:52:24 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 11 Mar 2025 03:52:24 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.47) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 11 Mar 2025 03:52:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oFtO3U6sJpwTt8C0p/jymq2P2XQBmXDTsf5n9QHTJ2S+qFpZRPr2ZrxMbGU56kUOYl/e25dCzRbzl5EE+uiDRadvUzxxHf6cFkCNxGsJShg4kjrHBoTof7foOYPVMK4Hs7gfP+sFeNDmf6fIgu0+JkiMdGa1F+XIlKUF/iPoKS3Hiomhy47TV4qQ5rWru3C9C7ycPillRuBUpqpERloS1MY57W3U2A3RGSLOrRQv+to2PoBqsb8nsgl6gxQzsD5Y2ehE6SRBE7EaGAk/aFuNH2q+vDrxo2G2JhpOMqhxq14H6Nd8vMFTGJ0pHkK+Krdq2gHTX/x8jwkomH52pHo8CA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vKrnnmtMpepfqhQsy7KslifCwFvq9P/JQDbIDAzc4+c=;
 b=FYVWTxs69EkG8qanITC8JGvx9jYtw6hGZdnCLbbeLd8MUgcGf7R6zJMIDxBrKL6Psm9rzlZeJkjU6YULV+CrIEf0GldA+dlGXo/MSAv/nnIcTTaGWnnA1tauHmeG0Zqt/aQP937JrvPHsXoQ6jjrdyhiQadOSAI72oo6MKL3Y5i1WOU7oA1zExjeBUV8Sydow4TMc7NGGvd4w5KC6eHFrwA1H3gEq/rT0UHUR3+D3EL1BIsRGf++hwcQIN6gYweRemb6yaZuN+lETIUwWUfnps6fOinOB6jqwgRnfrhveVX7INCAjHTr7LKGySxgkQkUBiEFIlQePUL3QZJqXJforg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8665.namprd11.prod.outlook.com (2603:10b6:8:1b8::6) by
 PH7PR11MB8600.namprd11.prod.outlook.com (2603:10b6:510:30a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Tue, 11 Mar
 2025 10:51:41 +0000
Received: from DS0PR11MB8665.namprd11.prod.outlook.com
 ([fe80::8e7e:4f8:f7e4:3955]) by DS0PR11MB8665.namprd11.prod.outlook.com
 ([fe80::8e7e:4f8:f7e4:3955%4]) with mapi id 15.20.8511.026; Tue, 11 Mar 2025
 10:51:41 +0000
Date: Tue, 11 Mar 2025 11:51:31 +0100
From: Michal Kubiak <michal.kubiak@intel.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: <davem@davemloft.net>, <netdev@vger.kernel.org>, <edumazet@google.com>,
	<pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>,
	<sdf@fomichev.me>
Subject: Re: [PATCH net-next] netdevsim: 'support' multi-buf XDP
Message-ID: <Z9AVs2laMDqYPp6S@localhost.localdomain>
References: <20250311092820.542148-1-kuba@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250311092820.542148-1-kuba@kernel.org>
X-ClientProxiedBy: MI2P293CA0004.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:45::15) To DS0PR11MB8665.namprd11.prod.outlook.com
 (2603:10b6:8:1b8::6)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8665:EE_|PH7PR11MB8600:EE_
X-MS-Office365-Filtering-Correlation-Id: 14eccac8-03a5-42bc-24a7-08dd608ab503
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Swb8nc+TzABtI8IRZoQpSjE+iG34kXIVvz4ToY5FYZXGDq3GqhNLMGPRHxIn?=
 =?us-ascii?Q?UV6rbcunTcd7sDjM1rBV78ozlgpyD4XPoRvoBkK+tKvgsRrwTu9Qeo97R/SQ?=
 =?us-ascii?Q?FdqJu29CUkuIhzpFdLNE3urVtj+0LHjuKPncTcK3EsrsH8gwgthA42Ck3c8E?=
 =?us-ascii?Q?JGWe2K3/wgSEhk/k5b7I4XGmEIM0PTt+t76IFcuQ32TJ26bUSd0alkmrg+cS?=
 =?us-ascii?Q?SF11ry1Hqme5CYCJJ4+F9h6eSp79qFXxd21k1J1sPmqIfYWTOMX7RBKFoO9/?=
 =?us-ascii?Q?yLpO1wm9SzNUnCHUDhVdG86F8MYtXWn39LkiWaDiAjzMRSYGDkl5QAmv9Lve?=
 =?us-ascii?Q?b51i6647zHEiMSgUJGE4LXrD4/cn3Djp99gW+hPPzhGEka6ujXONM+h3YLiv?=
 =?us-ascii?Q?Ht/2IqAiQWYyKUA/AFXmW66ky6cTmh2uHUq/YxUL6+jPbZ8NydCDW9AA6443?=
 =?us-ascii?Q?pUbd5fMJ6/95gFMkWVNw4iLON1K/Jn6HdG3edLkIMRvyO2aDIUeaNLnCjZDW?=
 =?us-ascii?Q?n6lR/K8J/TeiVxdBFQ/vyhhXswdk0COSGmtQ6KH+lO7HbNTa/k1yq7gPlruT?=
 =?us-ascii?Q?6GH7qTpOIrtG1xM78OlUm6mBO2dllubbi4USjwknNEvljMRhfQv+CwVny+/E?=
 =?us-ascii?Q?73MhGI6ekNCgVFZTabDoMDNX9BP6TqVJgZFR/MULLxkb51uKjW/trdlDXbX5?=
 =?us-ascii?Q?OtPeUuM66/OC9CBH3Hs+bbpkIJVrIsVV7EBuGw7PVwRgmAIe1ImnQYaRbIgM?=
 =?us-ascii?Q?P6DWzALX3AR6MLp4qdZ866fdu9ZAHfnsk1541KL7Dj8VWLHTU9MP55vqe+k1?=
 =?us-ascii?Q?7M03ro1UHBP8M+uro9Kij2WOIJdNQEhdYc8Gbco5yQlgCaXuzNtxmMqwCpjI?=
 =?us-ascii?Q?LGurreMdgB4CMPjFtNJx9Xeg5XwBXEGNfMvAOtQ9jmkNUf3pSIrF1exCKiDp?=
 =?us-ascii?Q?tNQOwCQ4DadZd8GaBLx30i2Q2hw3hXMaZbH1WQx2YJU4ONgj93WnJFDzHLYY?=
 =?us-ascii?Q?F8rIhMebnb0/qEV77gsKaGY+WfNXy0Bcp0Npg+Btk7sDjE5P+F4CKs6Dp/hP?=
 =?us-ascii?Q?SnffOHBzQf+fWO0cy6IeR37lVApNhhTFXMXkOIanTu5v8O4VToACrVNCXA7h?=
 =?us-ascii?Q?eDBREmpCxazmFgBom7ac8NZNk7E+t7Mi6TabDfwXV7tpC6Ok1TET2V0oAd3k?=
 =?us-ascii?Q?nRlormvJTfA/D3iIi4jeBejM2v36fDV6lK60gf0+f9BaUcCdjOEruaZxXS9W?=
 =?us-ascii?Q?PRiW9T6fV8rAp/qI7dg6xlnjT0OPP+nTN9+odmLQgZG0QcsQwbB+vE+yfAVF?=
 =?us-ascii?Q?4PU7bp6fjEFO4vaYrTYTy/tdoWjGyQju44qOAYezcX6DD6MwARChjx7cvDgB?=
 =?us-ascii?Q?bmwjJc/3+EhZWlA6uZjJUQIZE5g7?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8665.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?M3kSbPTRW3mctSYHBArAQeacbNE72FME6ZcaOogH/yYnAymLXtNMlpxDk0S0?=
 =?us-ascii?Q?PBcqN/Q4DCAgX6nXxoq6WW50+xA2UUA55JB95eeja6fLT5lo/YKiIl7MWKmL?=
 =?us-ascii?Q?hz3RxdPat4dVksuLehNIoA53nD1dp2BhwSvrFg570cveJJhcVHusuWMGJoVn?=
 =?us-ascii?Q?DevLSqsPxAUq6KDnboVBcqEKwoLnLUAmKFWlayvD4P3WVjSJN3tCGMAz+hVB?=
 =?us-ascii?Q?PlwDF5prGM82PfbepaC1niM72zVvpPjokbZ9BHS67dilS4qjFmwhhp74KaCu?=
 =?us-ascii?Q?yIKDcfseGf8454oOK/ERBMa3EOxow1tH86Vuo9ClXqd7CD8fsIOx42O6KN/j?=
 =?us-ascii?Q?VWOmRM6PCgb5ABsT4JDwL7aU3EjxPSSdcRn7oOG8Dwg0a2CHUs0Nqfkk0nyu?=
 =?us-ascii?Q?rQEroObdlzHGH3w7Dc6dFjnww1gvpJcxXxwQFT9eoZc64qsMOHpMIL0vCHlI?=
 =?us-ascii?Q?BJmCNY5Snfed1+/f/R/O0nh/JvWHl46497o4xGkWupNq4s5kXK7Licw+C0xK?=
 =?us-ascii?Q?HLJGWgg+IF7faUu7exFX8ACdW5LPRnqlUMnJ32bw3Gs/3YdaZMqmBklpZIEn?=
 =?us-ascii?Q?osdce4pFfYglayIdGi0Vq0lMt9qYeOnPnAHgjhaZrByci8ph43pnC2cgw4Rf?=
 =?us-ascii?Q?su3p92yoBFsVrDOuQgbGI6IPEGCOlQaU2P3P3Acxq1Ozq7pzRkAeSWDh4WwF?=
 =?us-ascii?Q?cLlcT8AjOftmT8rZ8lRNTbVQ/aDHUpAYtANuGcdz0iaKLyyL+9/PFxBghilA?=
 =?us-ascii?Q?zJElT0KXgAMLHtAoBm08QbSeCINF+A/H0J/hK/9FnmZzr1trU8GOajbHqpeo?=
 =?us-ascii?Q?sJZFGHkE44q1FQVMEtdnTrYkJrucExziiEQIkhu5KQCUqYHjt8KLK7ltX/wI?=
 =?us-ascii?Q?DdfywBcl9Me3hRafnQnB2Vkp93XGweIyihR0FF6XWPR8EO+X/Dlr6CZD0Dzy?=
 =?us-ascii?Q?QTf0xIGW6rhRI6mNUI+etQFvj0sAr41qVTwT87zkoTKh9xLoz0SrNLtJmo8C?=
 =?us-ascii?Q?/R8JfG/ths9v9svIPKVqk3ItjRRWgb/YU5mwAeuxaHslf5nJ6uVtS5VdPW6p?=
 =?us-ascii?Q?5dwstlvsWXiePAYJtIbiQ0uQy18J01aSdd8Ca4l9w4/IwgHKsCh/lyFiRfGU?=
 =?us-ascii?Q?LFGjEHVRL9+99+BnFXI2tKdZhWVDpeq/E8EIZpMefiC9NN/Tg1NIfXE7TK0K?=
 =?us-ascii?Q?rhh8s4H+gPw/iG1bqWYdDiNOnZRrc8RMzmzXpxCOnX9FFtb35eco6fyzuTtU?=
 =?us-ascii?Q?L45Q0iSsNMHaPxMSfiMXZbpRy86SfvdrHrKY65NDlj06FmUpLcKxZtp64HvU?=
 =?us-ascii?Q?v3DzrMZDzJvAVe2oI1sO2ZZcCK5SKHXTtfxD5mISloWkGdaOQRVkDci4xWMu?=
 =?us-ascii?Q?47jCgEZAMFI7CIb6NLhw1KwkbxvTPSifQRiR7G+ggCV3ujy9jce6VT8vvsrZ?=
 =?us-ascii?Q?4DMG0WXImoocE16R1sSLtu+eAGkvb75A+TyY6lcnYt9AtyUlo39H2ZZ0sMra?=
 =?us-ascii?Q?To58QHyZJ/1Eij7gxlUK5juiPMfAlovt8IDq2bEXniDkg3iGQpeUsCLmtiqM?=
 =?us-ascii?Q?/zOQDexT4y9qwLBcB3XPmcIW5ROIB/RJSA+dBLPlx2wLDWXwlKJTW7SARf2M?=
 =?us-ascii?Q?eQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 14eccac8-03a5-42bc-24a7-08dd608ab503
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8665.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2025 10:51:41.6141
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 40rIahPzSE+EqCbQveMZ8NIB8Bk6Pf2cC7BBlJ3nu0yT96VDbEJMaY2Q+QRbmQUN1SU+4qK8f+uxs4paCRmmbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8600
X-OriginatorOrg: intel.com

On Tue, Mar 11, 2025 at 10:28:20AM +0100, Jakub Kicinski wrote:
> Don't error out on large MTU if XDP is multi-buf.
> The ping test now tests ping with XDP and high MTU.
> netdevsim doesn't actually run the prog (yet?) so
> it doesn't matter if the prog was multi-buf..
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>  drivers/net/netdevsim/bpf.c    | 3 ++-
>  drivers/net/netdevsim/netdev.c | 3 ++-
>  2 files changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/netdevsim/bpf.c b/drivers/net/netdevsim/bpf.c
> index 608953d4f98d..49537d3c4120 100644
> --- a/drivers/net/netdevsim/bpf.c
> +++ b/drivers/net/netdevsim/bpf.c
> @@ -296,7 +296,8 @@ static int nsim_setup_prog_checks(struct netdevsim *ns, struct netdev_bpf *bpf)
>  		NSIM_EA(bpf->extack, "attempt to load offloaded prog to drv");
>  		return -EINVAL;
>  	}
> -	if (ns->netdev->mtu > NSIM_XDP_MAX_MTU) {
> +	if (bpf->prog && !bpf->prog->aux->xdp_has_frags &&
> +	    ns->netdev->mtu > NSIM_XDP_MAX_MTU) {
>  		NSIM_EA(bpf->extack, "MTU too large w/ XDP enabled");

Would it make sense to extend this error message to indicate that single-buf
XDP is being used? For example: "MTU too large w/ single-buf XDP enabled"?
(Please consider this as a suggestion only.)

>  		return -EINVAL;
>  	}
> diff --git a/drivers/net/netdevsim/netdev.c b/drivers/net/netdevsim/netdev.c
> index d71fd2907cc8..a5e5e064927d 100644
> --- a/drivers/net/netdevsim/netdev.c
> +++ b/drivers/net/netdevsim/netdev.c
> @@ -116,7 +116,8 @@ static int nsim_change_mtu(struct net_device *dev, int new_mtu)
>  {
>  	struct netdevsim *ns = netdev_priv(dev);
>  
> -	if (ns->xdp.prog && new_mtu > NSIM_XDP_MAX_MTU)
> +	if (ns->xdp.prog && !ns->xdp.prog->aux->xdp_has_frags &&
> +	    new_mtu > NSIM_XDP_MAX_MTU)
>  		return -EBUSY;
>  
>  	WRITE_ONCE(dev->mtu, new_mtu);
> -- 
> 2.48.1
> 
> 

Thanks,
Reviewed-by: Michal Kubiak <michal.kubiak@intel.com>


