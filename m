Return-Path: <netdev+bounces-146718-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CC1B9D545E
	for <lists+netdev@lfdr.de>; Thu, 21 Nov 2024 21:57:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43E7E280AB7
	for <lists+netdev@lfdr.de>; Thu, 21 Nov 2024 20:57:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ED6D1C8773;
	Thu, 21 Nov 2024 20:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="A4f2Tpm/"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F83C1C304F;
	Thu, 21 Nov 2024 20:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732222670; cv=fail; b=HzrDGIZ2gRDGKGsTvt8ZaF/I1mKI5BIgpkddS1qRcrMkmumYzVCwKh5AmnFhgBrxU/Er1e3A1eFwXkRPraRBNtWtfJVc/vTPv7+mv24UA+ZRUch7t72Y2TWhWHJIRhuIFBMz3Z82Drg49Yv3qLpIDalgXc7KgZW8c9hOA5tOMvo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732222670; c=relaxed/simple;
	bh=DbpV0A+sEZjDMJlWgUF+H7/XBFnLJfKj1NX2OH+He/0=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=dlUoAU6sqybL6nMOaCPVBZrhd9GxOK2oUPqSisPFbNemu3j5i+LZ9dhiD+hEmaPhEb8Ll0RWDN2aNahbgwFEy7U52ZSbQ+Rk4FdHgPhDIcOrta7jllMK0RDqf9taQxah0jjEjYYd3mZUWu4XWr6xYZrwe9U4nO+Hz0lITRRM+wc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=A4f2Tpm/; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732222669; x=1763758669;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=DbpV0A+sEZjDMJlWgUF+H7/XBFnLJfKj1NX2OH+He/0=;
  b=A4f2Tpm/pyROkyLvYsvipDgQwIet1PnP5yZa3VoFMwlfJMwI77/LYEKO
   Bdqm1s+3Uav96QNmy8Vx1LASpgLblHTdq77tj6OcXrV/FHgrQW/HhL1UT
   oSTBV+iEvUMrESZIJf6NpclZDDC7tJNQv1vmFnR602kYYuSV60SP26PBM
   NEt5Ju8qVCqS48IGn31z/+2Gd/avMxeLN5p3RzAWfd8bcUV/FH+wZVdBs
   0VPq+fMCyS7Y8NuhnQwDmeckiKW6H4p9TmItzAnxIKkGx39+fre/gSuk9
   eKoucmKlxTG34dgml2JmJIM4YczLFa09IK8A5N/5qx7dGpb8KXls8Zn0q
   A==;
X-CSE-ConnectionGUID: g2c4EmQhTauRFsBqGmGfiw==
X-CSE-MsgGUID: cqR/IhOMQ6WZiQNpUnW77A==
X-IronPort-AV: E=McAfee;i="6700,10204,11263"; a="32509330"
X-IronPort-AV: E=Sophos;i="6.12,173,1728975600"; 
   d="scan'208";a="32509330"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2024 12:57:31 -0800
X-CSE-ConnectionGUID: 0etOM289QxmLNBo0czPU+A==
X-CSE-MsgGUID: AupZ28UzQ/qOGJIHe++gXQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,173,1728975600"; 
   d="scan'208";a="90010663"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 21 Nov 2024 12:57:29 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 21 Nov 2024 12:57:28 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 21 Nov 2024 12:57:28 -0800
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.47) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 21 Nov 2024 12:57:28 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Adnvz0GDXksvho3vD9GO+XWcZZ9d3v3BvvmsM0CNxxPPgtprUipp0sZo7Hqee8ExbgAlLpqyph/R48KuCh4E/0pyXARpvklgDsLkFprjjRAQZp0SCXUMcbDZZB7l3+OwdXFehZ7xZpIc5hqh6UV3ldoDUgA2Pi6mRjVESdomIalPBu6Cs1rltGUyrVkvLykKXm15/+j/XuSvb/2ilaAISspww6Xj46v1GtlJAYJZTOmDFn9SDtEOUYgIzjNS1iDogXQ+cY/Z9lD2kBCcOmjIsHOedVW/5Raeq2mAzVlhwS9/woy5NVeaGNW/Uzl31zrcnb+SOPph5F/HB9VQUQgctg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/8/2A2E/lowewRnT2mqOL75DRzTs9N6wEwXHqDrOcGg=;
 b=XAAlZguD17QZv2V/2I5dRXukEEEoguqxsEwrgfkhatubUZhf4pVGx4GtriznSKU3+Mqzu6KwZXnbqGprLK9HIyCJf/tzfgSCKtzFP4mAxXSTKt4fx9ca3Z7Bgda9OYGYeH7Gly5x9WvoEC9gMFuAvJXzNNwF0OfqrfheTbabyq3BV1ybyy+xyvd/qAdiB5nF1sFzbdHC2FXftoVJQmL1uxvy6cOih4qM9flvskwQlzzngGaoAtIgeRaP5JoKKQ2qjOtgifNjImtez0NkiPIDMmhusucgui2UF+894+zu4BhQFsm2FreAXbcyoINQ7orZHkQQ8ziMC7aI1oCHv9bGvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by LV8PR11MB8700.namprd11.prod.outlook.com (2603:10b6:408:201::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.23; Thu, 21 Nov
 2024 20:57:18 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%4]) with mapi id 15.20.8158.024; Thu, 21 Nov 2024
 20:57:18 +0000
Message-ID: <32cae443-95d2-408d-9864-b4fed172291b@intel.com>
Date: Thu, 21 Nov 2024 12:57:17 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] netpoll: Use rtnl_dereference() for npinfo pointer
 access
To: Breno Leitao <leitao@debian.org>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Michal Kubiak
	<michal.kubiak@intel.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<kernel-team@meta.com>, Herbert Xu <herbert@gondor.apana.org.au>
References: <20241121-netpoll_rcu_herbet_fix-v1-1-457c5fee9dfd@debian.org>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20241121-netpoll_rcu_herbet_fix-v1-1-457c5fee9dfd@debian.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0270.namprd03.prod.outlook.com
 (2603:10b6:303:b4::35) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|LV8PR11MB8700:EE_
X-MS-Office365-Filtering-Correlation-Id: b9832ce4-559a-4d2c-3db8-08dd0a6f1605
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7416014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cWVyc3A0cEp2MDJZUXI0VEN0MGpBN2VFbW5xam5LSVBJUzIwTERkdEdxUjE3?=
 =?utf-8?B?b2svMGFHdTI5MERIMDJyelVEejBVU3NDRm5kSUtaSXZ6T0xLelJIb0hML3BE?=
 =?utf-8?B?cS8vOTNGUWtFQzBEZzlyZVZGMGtOcFJvS3Z3bVNGQVF3dThCYWxuMWtPWHRp?=
 =?utf-8?B?OEJpM1oxNFRXZzZ4WXpsY0VJVkh4QkU1OUxER2xPcFdjV0tQQ0szdm9rVlE2?=
 =?utf-8?B?ckM0UFZqdjBmYXE2ZWFxaUNrNXNTYTJ0OXZLNFQ1cTAvb0t3RHk4VnFMYU56?=
 =?utf-8?B?Rm8wcW52ZzZxZXQyT1FwblhIYkQ1MEpzN2QzSmFWSTVFSE81eDV1NS9jRStJ?=
 =?utf-8?B?Y29OdXR0ZXl1ejhKdko1a2s1YkJya0QrY2ZHK1NnU2E1amtiY0xMZHJvQk14?=
 =?utf-8?B?ZHBVYUptZGhQd3c4SkFkbUF1TEtRK1RxS1JiSTVXd2lJTW1ObDByMmJPWU9M?=
 =?utf-8?B?YTNycCtKYkxBVTlzbHZydCtQNlM3T3FjZE5ibUxaZ1l5OWl1RDJDUFBYbEhq?=
 =?utf-8?B?RktPNmVEMEp4R0hpaUNnaGVEbENDMFh0RWZiV0tiek9QTzh4Z1UxalNzWDJW?=
 =?utf-8?B?b0hTWW5FenBXZkJCR3Q0TElBUk9VdHVma2FaaFlaT3VteG5CeDBLQldYMDcw?=
 =?utf-8?B?Q2ZnN0RVUjVFeTJ5L1dXTUVRWWliazZJMStzSW5HOGswZUgxUzJHUFdvOXB0?=
 =?utf-8?B?bTEweUdOM1ppT1pzMDNpWUtLeU9QUHVaR3AyQmlqV0xrcThWZGxkb3pQUzJE?=
 =?utf-8?B?czAybjBUajBpMVg0ZXVjaGJrNStsME0waTNpZmtPWWJrTjQ5ZHFZeHM5UWxK?=
 =?utf-8?B?dUtpSXRobXcvZklRbldkV2Q0anZOWWNETzVLQzFnZjJjSWdUSXE2cDFZbnhx?=
 =?utf-8?B?ZTlrSjJYQk9jL3M4ZThvQTc2bklnTS9kZ1crY2ZYcHdlVTRIUGhxNU14S212?=
 =?utf-8?B?R1BFa3NjRURTdXlIVk81VUpOaURmN1pDcDlPNTRUUzE2ZnVxMGZsenlCN0Zi?=
 =?utf-8?B?Rm5qQlcxKzhjamJDSW9YYnp4Mlh6UDBNeTNSYXBZTDFpVFM4WXJteldvQU1P?=
 =?utf-8?B?RkZNYzR5eWladXlveEtGdnNHVWdjclF4ZzdRYWNvSDJnS0RxeHVtUlRwTTE3?=
 =?utf-8?B?R1loeU5NZjhSRGk4REJkNXBSTHc3dURGOGMvSVNKOUtEQW91dkc1dG1adEQ0?=
 =?utf-8?B?K2FkdzBOY1lMeGdKNWFIODNlaGgzdGRJNDBCVm9KRVNiSFBRbUNMK0pGU25u?=
 =?utf-8?B?MmJTcVYwbmllQ1NMaS9aT2d0UXpmY1ZXTUpDUE9CaW03eEJOU3BFeW9pa1Rl?=
 =?utf-8?B?V2o3YURvckM5RlZZZXk3NVJBMCswZXdkNEFVdVZ1TGs2ZGxnWGROT2w2NDJC?=
 =?utf-8?B?bFVGRzVSWVp3cU5uanJWeEdWT0tGYUsyREk3WWtHbHgrZUpJSEh5NGxVVlgw?=
 =?utf-8?B?UHF6M2VMM1hEcmR0S3BOWlJNQ3Q1a2dwZlVhNWo5eDRFeXdFcE9Yd01BcXE0?=
 =?utf-8?B?Vm9qWDN1Z2YwNks3dGwrYUtudHB5bzRERUFia3NIWGkvejJPQk0rOGt3N1h1?=
 =?utf-8?B?OXd1WmpGcVVhNUVJSzdaMWRac2pDZmZvMEVHQ0hXS1hjZ2dsM0FPNEVaVUd4?=
 =?utf-8?B?R2NjdDlJdDZnY3RFeEdhb0tsQjRINUNUaE5JaFl2R014WUJkcW5ZeDFTRGdJ?=
 =?utf-8?B?ZmFCVWk3dGlmaUFJclFOMHBPNE1nL0ExR3dVMGpKUXByV1ZaR2NEdGhKcmxa?=
 =?utf-8?Q?4GlQtXdLY232oWNULHZnjd6lWyKs5P9jISLfzFs?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QmFGU2V3U0xHTkRXTmd6V0I4eWFXbjhJcTZkRmRKTWxqdWF1KzlSempDV05m?=
 =?utf-8?B?WWs0L0JrOWdHOHV5WE9MVUQ3aUxVSlJRVUptK0htb244YWFTSnN3enRhSmRo?=
 =?utf-8?B?ZVhmWXhFN3lDeWhrWkpaeHJBaEJTYjRhd2U0Rkt5OFNHT2xRTnN1NUw2R1lR?=
 =?utf-8?B?M2RCdkMvR1B6SEJ4ekRUem1vUWI2Vi9nckZlOHZkOEZ5ODBOby95TWtORHpk?=
 =?utf-8?B?am03bFl1cHRTWUZ1UnF0VGJEY2xsUTZmNEZVMnNzemlCZW93QXVwdGhpdDgw?=
 =?utf-8?B?MVVIb2V4ckJ5VE1WQTVqSjgyTitRVmZZQmc3aXhrbVRORURqajQ2ZGhKTlVn?=
 =?utf-8?B?SHJzZ1FNOGxjS3grOUNjZXBaSzN4NDRRR1FJZ3R0WVRsYS9oazhzcENYQU9Q?=
 =?utf-8?B?Mk5kR1M1TDF5WVAxVTNvZC9tbHhFL1pRSWpoVEVxY2x2RStjQ2xzOVo2aGtP?=
 =?utf-8?B?dG5GdW5SMDc5Y1hsMnRJYzZMVFB1MTVqM040cDJpMWpVV2JZNFI3TTFZck4r?=
 =?utf-8?B?M3VXOFZOQmdXbW8yU2lvaDg1d3p1MUFmK3huU1pocWJITitYTXdTaEZjWVRU?=
 =?utf-8?B?OGNNWUttbXR5Zk9YOTdyVkczTkpxZWR5amxkdVVyNGJLTitkRXJIQ0Q4UUZ2?=
 =?utf-8?B?RkU0amJsM2FMR0Q5SHJiVFZNSkpNaEtBRkJsUlBNNzJIcmdneXo2UVdwcDZQ?=
 =?utf-8?B?QnlVNWQzUDZtbkFEY0IxaXNSK2RMbXQyQy83SklFd0dDaVVMbEM0VStSa0ZU?=
 =?utf-8?B?V3Y4cTFGNzRoaDRPdndWOGI5WC84bWs2bkZGMjJFcjNIaXhHU1VSdGNNUzVI?=
 =?utf-8?B?RXlUaDdSOHE5djNzTkYwNG5DNkZ1OHJHQkFWaEtBaGhmTy95TEdSWDBYZytG?=
 =?utf-8?B?QSt3K1YzYTB1ckRpRVJDZWc2QWJYZ1ZDRmZkUFpDRFREUHdVNEoyNE4rZzJu?=
 =?utf-8?B?d0VrbGxjRDQyeEVQOXFkbGIxMzZEN3JUYzJXSlR5R3BlUWlsaHlkdFVWMERI?=
 =?utf-8?B?UkxQM3h4ZzI4WUFyRDBkSm0xaS9ZWFhPcFc4QmxnbEpWNXF2OUExUlBJT2hj?=
 =?utf-8?B?UVVaSCtKM3ZJMGtmTk03amZEeHB0Zll5WlBJRmE5ai9Xa2JZRDhpZzF0bGRl?=
 =?utf-8?B?NmlmN3loa1pRWUJOTEhHOXlaaTR3Y3RvSXlyQzFiZnRkeElpdUV6YnlOUU5F?=
 =?utf-8?B?WnFYb0U4bDV6TmJGTEMrR0dQbmZwaDdsL1RNbFl2MXNPM1RTV0lFd2dXUERP?=
 =?utf-8?B?Nk1MOTJkM0ZoK1JXS0VXRDFyT0I4Y0EyeDVZaWFhbnNaM1h0ZVM0TU1INEFt?=
 =?utf-8?B?cWp0ZzA2amJLNm9iTXZ5SEtmY3FPMmQrMURUZEJvTTRBVENLRTFrTE5aWHd5?=
 =?utf-8?B?QVg0MXFac0FsbmJtYlZxQldESUxrWGVsWE8rZk85b1lFMnBhdW5ucVo2cGNV?=
 =?utf-8?B?R0RndW16cTRtWitwdkR2RnR5WE0wNk4rdWNZWHVzMU9aeWhINWFVcVliMFc4?=
 =?utf-8?B?WmVFWXRGMk53MDdDN2Z5cThMd0xUZDJSeU1ncFFxSFRNRFJDUWxPc1pXdWtL?=
 =?utf-8?B?YXZzMkEyMFNHWXU1cEE0L3lYUkp4emh5b2UySzEwTlBUeCtnNDRrSHJLVi9K?=
 =?utf-8?B?NXNhVDA5d1lQMlBoRmx1WEhwUVBUNVFPOWRmWVRTQXlub3oxS0lwTjdDU1dx?=
 =?utf-8?B?Y2FYQmJNR09aQm91UmF1ekZSeHYrRjZJdmdBT0RTSXJmRzFHaE0rT3pxeVZl?=
 =?utf-8?B?dk1HV05uaVpLNUxBZVBiVm53Z2lJamRlaWY3RTRoQTNRdEhDTjlybUthKzAx?=
 =?utf-8?B?d2pKRlJnNmxUK0RMbVhsODM2eHl3bDlRNVJCWk9KR1Mzam1lOW1aUk51c0xk?=
 =?utf-8?B?VnBTdU12bU1yUjMwNTMyaWtnek9nSlBjakROZlZQbXNFSlh6MkJXTmUyTCty?=
 =?utf-8?B?NGNqVEpxNEF1V3pWcmRuQjVRamI2dm1ObDBDdWx6MGRpUVI5b2hKVU9laUpz?=
 =?utf-8?B?ZGFmRDR6NzFSN3ViR0QwRGo2b0FpemdmckhlYWRUTy82R1lRNUlkdzlKenBo?=
 =?utf-8?B?NXZRWm9aUWN4U09aaEdSNFYvZ1FEVUt2SDh4T091OFQ2WjRoVWFhdkV6YVFk?=
 =?utf-8?B?Rkp6UGl0anFERHd0UXNVYmJscnduVWdsUlQwZ2k0ZzNPTWwvNVoyUHZpOGRp?=
 =?utf-8?B?eFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b9832ce4-559a-4d2c-3db8-08dd0a6f1605
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2024 20:57:18.4779
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JGdw+O8um6AzmuLwWBK51YoIaJ4ZtqVKVsnZTcawUrMrj4caSM0gT+NK85UIAS6ajtHlyeBeuuckUM9BzgvsRIQHHsUhqwScRHX17XJTXEQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8700
X-OriginatorOrg: intel.com



On 11/21/2024 6:58 AM, Breno Leitao wrote:
> In the __netpoll_setup() function, when accessing the device's npinfo
> pointer, replace rcu_access_pointer() with rtnl_dereference(). This
> change is more appropriate, as suggested by Herbert Xu.
> 
> The function is called with the RTNL mutex held, and the pointer is
> being dereferenced later, so, dereference earlier and just reuse the
> pointer for the if/else.
> 
> The replacement ensures correct pointer access while maintaining
> the existing locking and RCU semantics of the netpoll subsystem.
> 
> Fixes: c75964e40e69 ("netpoll: Use rtnl_dereference() for npinfo pointer access")
> Suggested-by: Herbert Xu <herbert@gondor.apana.org.au>
> Signed-off-by: Breno Leitao <leitao@debian.org>
> ---
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

