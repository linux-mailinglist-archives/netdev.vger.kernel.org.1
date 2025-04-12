Return-Path: <netdev+bounces-181874-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E304AA86BAA
	for <lists+netdev@lfdr.de>; Sat, 12 Apr 2025 09:48:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1489C19E3F1E
	for <lists+netdev@lfdr.de>; Sat, 12 Apr 2025 07:47:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A950C195985;
	Sat, 12 Apr 2025 07:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HekPRDZX"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73A2622338;
	Sat, 12 Apr 2025 07:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744444002; cv=fail; b=AhE9+LHQOhNonuyFgt1iy6GW/5XgJJCoE3zUKxZerMQCFRguy6XDEmvWtKkJwJcJ8m1eJtjpnMO/4KgOifiljOm9l4wD74X9WM6j3gI6RTj2RAFhnuYUKjEk/PCnK41fbgLZZGFqtn47Kwtm3aFAVEVglFj1roKdRYJwEuxBo5k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744444002; c=relaxed/simple;
	bh=FgWRY1vY/BkfR/ixvlmyhgVWbvP+eRYmuXBUCioAIQM=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=USR/Rh8BeZyQ+WWAElWCKxeRWZJyfOuPXBJgIm5JnHbbzH1AHUCrejt0MWP0pZqyzwlcd8Toxi/i2C5BeNt5IfcDz2NNXRBRneDJogD5GkAZiGsb6k16k9bzTkgl7vwwDtnMi4uIn2aNAwIAf64/XIOl/1IJIc3m/q1ox04+38E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HekPRDZX; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744444000; x=1775980000;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:mime-version;
  bh=FgWRY1vY/BkfR/ixvlmyhgVWbvP+eRYmuXBUCioAIQM=;
  b=HekPRDZXNx8f4O5s8QQZQSr7JkFhTJdaIsXGjIIQsLh4S4o8iFY3qFj1
   1vGVh3nA5bOWr4nLCySgGMwMqYTKzVJ11XajZDLjjUTQc2h89WAazJfiQ
   WazB6TEpX9/o/sond+LPXk6//kzeQWN3piEf8wvU2IUX3D3XI1oNMgIGi
   1pydSjN0A34SlhcNAKIrPhTTUm3tGlIEsdGXZi2ygCxXBXp4lSoBBzwS/
   SavUQQUyixum8rmteMUQFMU7gUNXgYkt90/Rzm84eUclqk8Q6BuV5XxSX
   AYXZRODE8pY2Jy7vyT2B3Gugd+JOYVsu33gJ8IuK8vszPK0WS7axFqxjY
   w==;
X-CSE-ConnectionGUID: QPEcGbZrQnyphatxtnlqLw==
X-CSE-MsgGUID: kLkT12b/Q42lMx4+kEVeNQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11401"; a="57369789"
X-IronPort-AV: E=Sophos;i="6.15,207,1739865600"; 
   d="scan'208";a="57369789"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2025 00:46:40 -0700
X-CSE-ConnectionGUID: W7oO17BcRUioVxrnVacauQ==
X-CSE-MsgGUID: lRAO8zGcT0iQqexWszJTiA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,207,1739865600"; 
   d="scan'208";a="130371828"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2025 00:46:39 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Sat, 12 Apr 2025 00:46:39 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Sat, 12 Apr 2025 00:46:39 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.170)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Sat, 12 Apr 2025 00:46:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uaZbRZ0eczo/ZldZxiyNaK7lf7dSB+d9O+6zScTr891/QRHm1V1OMsh+uOlyHbEJPvpafNP5u2iirTdXilLLjZddT2BIWhVvSHb/IW8lbmWw5jr4W8WRdzW/ADkL+48xZfz3RsO5471veJEncNJSbXv4SdLoKT1t/QPQTWSsx2uEOTx2GSKQ6xs5uY6c+4oHfJsteeiyxv7Rvc0q4W2D1hCFfL3WKBTA7mTpPjTtORqyeCbn54b8dqCiBT9Yame3hGmLL4LeS7u5aiR2MBS7sPS1Zi9BptTjCc9NYRJfRAv4Q1OWMoH5Btk82gOzBdsHWDdOOyEbQFFDyDWm19K0Hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EJpgh2MwRgZifwlNnsm5KuqsmQ8i9TJdJRlrsK6M9Xo=;
 b=R+wS8amfwBEIZtFYHHUpP+OVkkktGptp7ADk0tuRLZrmh0Xaw9+MprhfyQNrskXIIHL5wKzjk6HPuqDPQoazabKPqZt0+kn1HSnvVsCRisPX1JgRh7Xpw6aB1QAuLcp+0QgqSZdyxSbU2zppcO3nthoqskaGe2H9yHWLTyGwGdizjI14emiVvM7NmXnKTg0A6rZJUsyW1WEaAN7k2H1DPL2BpW58uIPD6iSxTJwNTk6/nQOQtmIYZHmFF+uJ4n3OiMLK+zQ3Nipq7XCrH4Gw00cfqfnfIGhaafsGlvBEy+i2YxHqadeTehqldDQLJdaLNxHq3XHZw4aJ1ZBZeg4hIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by PH0PR11MB7424.namprd11.prod.outlook.com (2603:10b6:510:287::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.22; Sat, 12 Apr
 2025 07:46:06 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%4]) with mapi id 15.20.8632.025; Sat, 12 Apr 2025
 07:46:06 +0000
Date: Sat, 12 Apr 2025 15:45:57 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Eric Dumazet <edumazet@google.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Kuniyuki Iwashima <kuniyu@amazon.com>,
	Jason Xing <kerneljasonxing@gmail.com>, <netdev@vger.kernel.org>,
	<oliver.sang@intel.com>
Subject: [linus:master] [inet]  d4438ce68b:  stress-ng.sockmany.ops_per_sec
 40.4% improvement
Message-ID: <202504101443.bc7b7079-lkp@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI1PR02CA0055.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::16) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|PH0PR11MB7424:EE_
X-MS-Office365-Filtering-Correlation-Id: 8191cc05-6a9b-4a9d-85d3-08dd79961539
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?d41ICNTWEvmc35neKGG+lJzk93tzoXJQu0bU1xkkwtPmyqsa0biGYf9jj3?=
 =?iso-8859-1?Q?3/LyHvum6xUw39e8q8MNjVV6f2XYNE/tVGtN9DBj1lxQmZ1mBL5z0SFEpJ?=
 =?iso-8859-1?Q?tnD6VYRVlY1oocW6FMBFcYMl9PEUy0R+bg+TpehEZ7lc70Zmk+V46XGveX?=
 =?iso-8859-1?Q?AKRds9HbhrHv80BKgUodP4ZVvBa6UW3L/92N0HTSm0z2qxeU+A1x3xTiJW?=
 =?iso-8859-1?Q?MiECbNvhigUDljAP9VCOtDDbir0+Tx1TQ6yUzC9rd0j2fQdNJSc72DGYRQ?=
 =?iso-8859-1?Q?FrGlk504RSCA8bBmZW2NXoLqXtWFMcucBZiTFJ1kY76AmTtkAG0vsNBPoY?=
 =?iso-8859-1?Q?qixzs8mVBjdvcljsgL3r5FSW9KgbndvUwGz76+bhuU/3vTUW7L7VG+rSqG?=
 =?iso-8859-1?Q?K64jSPsYtlpo6iy9u2MsVVwoJyd64n8IkeTcCkEvqnz+82zmV4D8YMRyRj?=
 =?iso-8859-1?Q?Nt2viYtQ9QAIqTQ1J0xNXohdjowRyNgwaeKj0adNYQ06vvu8ST4jNPQF8s?=
 =?iso-8859-1?Q?SrmDF9HDaheha22Nh0HMSvHIgfigD7V7kw2GQFGrmoyDmOBRjZEGgrWY3t?=
 =?iso-8859-1?Q?MsivrLlLUUapdWWiHwKCHDGk4KYHZuOovImwV3MV2XraX1TENbP0fqHeOP?=
 =?iso-8859-1?Q?NcqhrxEDNX+SEZ88Vvyu42KYNHpVIWXNMjX4B9SMtoJGt9T2dQT0Frdol/?=
 =?iso-8859-1?Q?kjWyqqsca8mzOJFztSgxEHNLhTm8c9McWlrVflfTsBcfP7EzpgzUls83DJ?=
 =?iso-8859-1?Q?eC+cVJm/RKPCJne2H2tael4gh+ygaYbFXs7onQTP294z27QTeUQ86zaQwh?=
 =?iso-8859-1?Q?YZDi2ZKyks1aXI4eMt4tVYJNrjKXbAZXEJGJlxLKC1zAf0FOFmkP1Z8MLx?=
 =?iso-8859-1?Q?c/QUsa038HrJ96FEm6ks+QxphxK+MH0lk7kocvXENNxUnz6YANsqdsXrti?=
 =?iso-8859-1?Q?A7pd66vvePhrDeyXTXREcz9saeChzMYbkCU0b8fdzARFoEp8nxqvBwbayK?=
 =?iso-8859-1?Q?IeyAQ6w4zSGmN92s/Rpt8UU5w8hEFPDpfRHKGH7fSEuFAZjGMiUtrvnXZT?=
 =?iso-8859-1?Q?OB7hS+JXwAlR/fdI/3jmvsewgCHiN5kQSj0gvTnBn/kFmhU0YJssWLj5Ck?=
 =?iso-8859-1?Q?tmuoyKzUyxtH1T6yG25Asu/bDuJOgksmaZKG94kl88sSKN/XIlZOp4OdUw?=
 =?iso-8859-1?Q?WLeOYJuLnmoSvcfLQ+x3dwWzRFvis053MRKZ4GndZ0gQOFNoE9Xh/d+m2O?=
 =?iso-8859-1?Q?LNerI/Vs1mpOmYHlbrK6zsoZ6VjXHfqfP1c0g97UN0iuv4z08DkK6aUuob?=
 =?iso-8859-1?Q?jMZ7mj7SnNgm/aOElAGejgcEsYxo0KsWUVm8WcG0JWD+1msrFCDwUdWIUU?=
 =?iso-8859-1?Q?MjihPS8eqUyGyNuM20OQBw1IN03QUaQGIqupNvfYXol6yBENBMpyAtrBx/?=
 =?iso-8859-1?Q?Ya3ID07e8vAJAMkF?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?66zZ5njYDVuj/w88qZOGOBuvyZDZbVeD5tHMlMUIJiQ/eH6bu8LGL2Hccu?=
 =?iso-8859-1?Q?TL9oiPY5Jqh+fPAIqsCHYUnw1DjncaLT/N1ABbYKVgvKxRgwOVHALtkYpd?=
 =?iso-8859-1?Q?hPTzRGfgPHl+rJRAngZ44N8+LyXcoaI/5IFjV+Rs5pptcTt1CcrZxpL5da?=
 =?iso-8859-1?Q?oFXzAF1JsgCwkgvBuCLf6FLnUu8n7WnlH42IPJr8UKuiBhlHK+E1bkNYrr?=
 =?iso-8859-1?Q?XlP/61LgUFGSMIEkItX/2lw4Yk+m3K2Lh/GBNThmzRJTyUPBZDclM/VQpu?=
 =?iso-8859-1?Q?4R/I7fbhYbGPKwPww9amE00OESchDGcs0E7hhoumelKhzvwJXdQdnj5PtW?=
 =?iso-8859-1?Q?JLe6Ma2AoME31doD5eJKZ5uKGx5lEex4LnqDC80S48ZIaURsbl3Zs+V5XH?=
 =?iso-8859-1?Q?tqi1nSt+UN3d3H2mRSLL2ne8E9Gf3BgPsPkJcjzGeuNUcJveWQwtX1jBht?=
 =?iso-8859-1?Q?NmSq1phuNcSG65G84Nw63OH+pYgtudeWB2fBSiwrmiZZxdnJc2HyVh72v/?=
 =?iso-8859-1?Q?rkIl/5QFyJTLdHDVHJS0WbUTM2VWLlItFYEw/mxeFl2iqIOtso7TRN0NP6?=
 =?iso-8859-1?Q?2Gv4F3xKreoZZCH3Q9lfSDE3aXI55EHV2FQanab3mWbftwp+PMngTcLoH0?=
 =?iso-8859-1?Q?RcPPonwusYAlZfuOoZ2UuHqAtsjDmCvQPBOu7bdxau7L43e9b/3oVCYoBn?=
 =?iso-8859-1?Q?I8mH/605UIyJM//lssaFQOVH2l1O65+GpBXcjha64X9N2jKwtk1P0+VMbx?=
 =?iso-8859-1?Q?KFc1PDygXsj+zrpznV7K2+6CBQkaCZx14uBQURiHh1rcps4IikaETsrbb1?=
 =?iso-8859-1?Q?TJszS4ve/peiZ96O2gK3Pb+O7LXRJOcm2zmWZg4hLCGEFHYNTrLJT5RUDt?=
 =?iso-8859-1?Q?m2rd0Ef0thvehCHlJAyUfitH8xUjnCbis66SWs/g+QAUiM3NA8E8vU2+PJ?=
 =?iso-8859-1?Q?K9x9fWXHYsFr3FnyuwKBKQPhBungwgw9esPrPfYOgTMDnO8vayEV6P2+fR?=
 =?iso-8859-1?Q?F714VWdJxxNmcf5V6w7U8h8fFWUTxtnZ40+j+dBHnIyREhIDUr0tFoxH1x?=
 =?iso-8859-1?Q?jbt6n/rzG8ZKE3oo37+ecTMl7L9GcOxyOFbrzdX+DeMXR5qQgjapJPPgnp?=
 =?iso-8859-1?Q?fRBnd6xXxugZbHZgX/6Ya/2O1MdDXZe1k7iTV0RbOz+yYfo+QEf2L/e+r0?=
 =?iso-8859-1?Q?qECgXr+sCxk4ui0Ln6Ej2eHYiAepD1YerzTfysBNa5/dstA0T1SkB70KeF?=
 =?iso-8859-1?Q?7R3RYKcLshOw+FUvl7aBMCuyj2pMv9NCuRKC2D1vcDfpxOX6G5fRrmBaC9?=
 =?iso-8859-1?Q?udUKDfnvfkHLSgnbCS3+9qk/yEpVcl9AjJjeZR+w6wXaciyPEAn335zBSR?=
 =?iso-8859-1?Q?eJsceKGgiXFbD09e2qDjNXJgGtnGi26uDxyjtM2+V5tRksIsmHpcXjmZzg?=
 =?iso-8859-1?Q?pmJCHPcSXki+YbvMV1PmvnfUI2LlY+dVVgeApv0K0NRijsbFvDjw+lX2VI?=
 =?iso-8859-1?Q?6t5WzViI3LKpDZpHtVTxd0Gip96UH5aG+r1sDN3ePmlaCPL3DdSE02RIhY?=
 =?iso-8859-1?Q?/TFpsTERjHH7VaGMRIl/dduCL7WzyxiHH4EKSpnuvKoRvIo60wId6U/PaR?=
 =?iso-8859-1?Q?NVFV4aclHnfs+GTGRltp5lAnISJLRv9EvtLe/vO0CJn9x3wxol3Auqjw?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8191cc05-6a9b-4a9d-85d3-08dd79961539
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2025 07:46:06.5812
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +h5bfC6D1RF3SnoKd//IKD3dnJZ773G+fSeq+hey1AIT3h0anLxRdG/DGK9JqsKbm7G7dXyXhCbkIlGfyxDR7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7424
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed a 40.4% improvement of stress-ng.sockmany.ops_per_sec on:


commit: d4438ce68bf145aa1d7ed03ebf3b8ece337e3f64 ("inet: call inet6_ehashfn() once from inet6_hash_connect()")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

testcase: stress-ng
config: x86_64-rhel-9.4
compiler: gcc-12
test machine: 64 threads 2 sockets Intel(R) Xeon(R) Gold 6346 CPU @ 3.10GHz (Ice Lake) with 256G memory
parameters:

	nr_threads: 100%
	testtime: 60s
	test: sockmany
	cpufreq_governor: performance



Details are as below:
-------------------------------------------------------------------------------------------------->


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20250410/202504101443.bc7b7079-lkp@intel.com

=========================================================================================
compiler/cpufreq_governor/kconfig/nr_threads/rootfs/tbox_group/test/testcase/testtime:
  gcc-12/performance/x86_64-rhel-9.4/100%/debian-12-x86_64-20240206.cgz/lkp-icl-2sp8/sockmany/stress-ng/60s

commit: 
  9544d60a26 ("inet: change lport contribution to inet_ehashfn() and inet6_ehashfn()")
  d4438ce68b ("inet: call inet6_ehashfn() once from inet6_hash_connect()")

9544d60a2605d150 d4438ce68bf145aa1d7ed03ebf3 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
     66811 ±  2%     +37.2%      91683 ±  2%  vmstat.system.cs
      2.92 ± 38%      +0.7        3.62 ± 21%  mpstat.cpu.all.idle%
      0.78 ±  6%      +0.3        1.09 ±  2%  mpstat.cpu.all.soft%
     89855 ± 45%     -58.3%      37495 ± 96%  numa-meminfo.node0.Mapped
    181411 ± 29%     +50.9%     273696 ± 11%  numa-meminfo.node1.Shmem
    433609 ±  6%     +25.7%     545181 ±  4%  numa-numastat.node1.local_node
    462621 ±  5%     +24.1%     574183 ±  4%  numa-numastat.node1.numa_hit
    199550 ±  3%     -32.9%     133991 ±  5%  perf-c2c.DRAM.local
    141678 ±  5%     -34.2%      93183 ±  7%  perf-c2c.DRAM.remote
     45462 ± 29%     +50.9%      68581 ± 10%  numa-vmstat.node1.nr_shmem
    462094 ±  5%     +24.1%     573303 ±  4%  numa-vmstat.node1.numa_hit
    433089 ±  6%     +25.7%     544302 ±  4%  numa-vmstat.node1.numa_local
   2029078 ±  2%     +40.4%    2847905 ±  2%  stress-ng.sockmany.ops
     33711 ±  2%     +40.4%      47329 ±  2%  stress-ng.sockmany.ops_per_sec
   2010826 ±  2%     +40.8%    2831055 ±  2%  stress-ng.time.involuntary_context_switches
   2122618 ±  2%     +38.3%    2934839 ±  2%  stress-ng.time.voluntary_context_switches
     87035            +6.7%      92859        proc-vmstat.nr_shmem
    336264            +2.0%     343096        proc-vmstat.nr_slab_reclaimable
    938906           +12.1%    1052474        proc-vmstat.numa_hit
    872687           +13.0%     986265        proc-vmstat.numa_local
   2896245           +19.6%    3464080        proc-vmstat.pgalloc_normal
    305944            +1.9%     311839        proc-vmstat.pgfault
   2751656           +20.4%    3312497        proc-vmstat.pgfree
     26462 ± 10%     -29.0%      18788 ±  9%  sched_debug.cfs_rq:/.avg_vruntime.stddev
     26462 ± 10%     -29.0%      18788 ±  9%  sched_debug.cfs_rq:/.min_vruntime.stddev
      3.49 ± 14%     +28.9%       4.50 ±  9%  sched_debug.cpu.clock.stddev
     34426 ±  2%     +36.3%      46926 ±  2%  sched_debug.cpu.nr_switches.avg
     64283 ±  6%     +28.9%      82835 ±  8%  sched_debug.cpu.nr_switches.max
      9571 ±  9%     +39.4%      13341 ± 10%  sched_debug.cpu.nr_switches.stddev
      4.20 ± 10%     +19.0%       5.00 ± 10%  sched_debug.cpu.nr_uninterruptible.stddev
     18.34           +35.6%      24.87        perf-stat.i.MPKI
 9.043e+09 ±  2%     +28.2%  1.159e+10        perf-stat.i.branch-instructions
      1.91            -0.1        1.82        perf-stat.i.branch-miss-rate%
 1.741e+08           +20.4%  2.095e+08 ±  2%  perf-stat.i.branch-misses
 9.167e+08           +38.9%  1.274e+09        perf-stat.i.cache-misses
 1.555e+09           +38.0%  2.146e+09        perf-stat.i.cache-references
     69950 ±  2%     +37.7%      96349 ±  2%  perf-stat.i.context-switches
    258.20           -26.5%     189.89        perf-stat.i.cycles-between-cache-misses
      0.04 ± 41%     -54.6%       0.02 ± 57%  perf-stat.i.major-faults
      0.60 ±  6%     +83.8%       1.11 ±  5%  perf-stat.i.metric.K/sec
      0.16 ± 78%    +175.0%       0.43 ± 25%  perf-sched.sch_delay.avg.ms.irqentry_exit_to_user_mode.asm_sysvec_reschedule_ipi.[unknown]
      0.01 ±  3%     -17.5%       0.01        perf-sched.sch_delay.avg.ms.schedule_timeout.inet_csk_accept.inet_accept.do_accept
      0.29 ± 14%    +132.4%       0.67 ± 21%  perf-sched.sch_delay.avg.ms.schedule_timeout.wait_woken.sk_wait_data.tcp_recvmsg_locked
     11.50 ± 71%     -76.7%       2.68 ± 69%  perf-sched.sch_delay.max.ms.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown]
      0.05           -15.8%       0.04        perf-sched.total_sch_delay.average.ms
      7.99           -19.3%       6.45 ±  2%  perf-sched.total_wait_and_delay.average.ms
    162716 ±  2%     +25.0%     203451 ±  2%  perf-sched.total_wait_and_delay.count.ms
      7.94           -19.3%       6.41 ±  2%  perf-sched.total_wait_time.average.ms
      0.09 ±  8%     -13.2%       0.08 ±  3%  perf-sched.wait_and_delay.avg.ms.__cond_resched.__release_sock.release_sock.__inet_stream_connect.inet_stream_connect
    149.92 ±  2%     -16.0%     125.93 ±  4%  perf-sched.wait_and_delay.avg.ms.schedule_hrtimeout_range.do_poll.constprop.0.do_sys_poll
      4.23 ±  2%     -21.9%       3.31 ±  2%  perf-sched.wait_and_delay.avg.ms.schedule_timeout.inet_csk_accept.inet_accept.do_accept
      0.58 ± 14%    +131.2%       1.34 ± 20%  perf-sched.wait_and_delay.avg.ms.schedule_timeout.wait_woken.sk_wait_data.tcp_recvmsg_locked
    246.84 ±  8%     +26.7%     312.83 ±  5%  perf-sched.wait_and_delay.avg.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      5361 ±  3%     -13.8%       4621 ±  2%  perf-sched.wait_and_delay.count.__cond_resched.__inet_hash_connect.tcp_v4_connect.__inet_stream_connect.inet_stream_connect
     68917 ±  3%     +36.0%      93723 ±  2%  perf-sched.wait_and_delay.count.__cond_resched.__release_sock.release_sock.__inet_stream_connect.inet_stream_connect
     91.00 ±  3%     +25.1%     113.83 ±  2%  perf-sched.wait_and_delay.count.schedule_hrtimeout_range.do_poll.constprop.0.do_sys_poll
     75346 ±  2%     +28.1%      96486 ±  2%  perf-sched.wait_and_delay.count.schedule_timeout.inet_csk_accept.inet_accept.do_accept
      6441 ± 11%     -56.8%       2780 ± 23%  perf-sched.wait_and_delay.count.schedule_timeout.wait_woken.sk_wait_data.tcp_recvmsg_locked
      2275 ±  9%     -20.0%       1820 ±  6%  perf-sched.wait_and_delay.count.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      1771 ±  6%     -41.4%       1038 ± 55%  perf-sched.wait_and_delay.max.ms.__cond_resched.generic_perform_write.shmem_file_write_iter.vfs_write.ksys_write
      1.62 ± 77%     -65.0%       0.57 ±123%  perf-sched.wait_time.avg.ms.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown]
      0.16 ± 78%    +175.0%       0.43 ± 25%  perf-sched.wait_time.avg.ms.irqentry_exit_to_user_mode.asm_sysvec_reschedule_ipi.[unknown]
    149.66 ±  2%     -16.0%     125.77 ±  4%  perf-sched.wait_time.avg.ms.schedule_hrtimeout_range.do_poll.constprop.0.do_sys_poll
      4.22 ±  2%     -21.9%       3.29 ±  2%  perf-sched.wait_time.avg.ms.schedule_timeout.inet_csk_accept.inet_accept.do_accept
      0.29 ± 14%    +129.7%       0.67 ± 20%  perf-sched.wait_time.avg.ms.schedule_timeout.wait_woken.sk_wait_data.tcp_recvmsg_locked
    246.83 ±  8%     +26.7%     312.83 ±  5%  perf-sched.wait_time.avg.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      1771 ±  6%     -41.4%       1038 ± 55%  perf-sched.wait_time.max.ms.__cond_resched.generic_perform_write.shmem_file_write_iter.vfs_write.ksys_write
     11.50 ± 71%     -78.6%       2.46 ± 76%  perf-sched.wait_time.max.ms.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown]




Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


