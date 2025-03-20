Return-Path: <netdev+bounces-176542-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 028C5A6ABBA
	for <lists+netdev@lfdr.de>; Thu, 20 Mar 2025 18:11:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BDE35485552
	for <lists+netdev@lfdr.de>; Thu, 20 Mar 2025 17:11:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 950F9222596;
	Thu, 20 Mar 2025 17:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="J5F7QqLk"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72A3922155C
	for <netdev@vger.kernel.org>; Thu, 20 Mar 2025 17:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742490707; cv=fail; b=h2yLcPFtahBcTgA0y/MV3C197PQ11MarGLJkjNMdZpCkHXLQO55cK+xkqFooR1q+CauL6R8eZ4k2ArGyCS1HtuC5f5iuOTwrp1khKmi0phGstaVMDNWVhdVGajgzN2Zq4LNY6F+C1yTdpYPH+5cKY+/MC3FyUplb9jdjyYxNH9I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742490707; c=relaxed/simple;
	bh=Qj9ZdnGfODgvWc44SK7DoUYowk/0eCMBIdOqFxNKE2c=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=DdD51mVFr4mQI3d8fJkyovjRtiaTiPoWspaE5diX+X1V/YpkMQV8RnAWTRzY2sNXfNPc9lkPQro8f+4F+IrOaY8hCoUFFhoknle1C6vQlfSk5A0Fg6h57eLT73qbXo3atyHrl7/LkFdrobEDAbSYS43CyvR1NqBdTjQrXPYcNhs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=J5F7QqLk; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742490706; x=1774026706;
  h=message-id:date:subject:to:references:from:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=Qj9ZdnGfODgvWc44SK7DoUYowk/0eCMBIdOqFxNKE2c=;
  b=J5F7QqLkHgK+6q8qmf8Cw81xJuj5cqR6TGVYMF1rRp5GHRjhYzgreDwE
   c/GErK3Vu7Tw6ByZSpVhxhIlVQSAQMw5KOVDPzAl8Uus6cRQOHk53Fe0Y
   pvhZ/dBSaogJrGj1rFMSN9buRjU0ZgeApx3y9UNKj3JYEwfwfqmYERill
   GjhFHHOvXdEqJMYPLzErtbVHt4eG9MlLSNYbzNiqIm7FDK4vq8TEW9CZE
   BX0m91YI51Z6Cg9/RUqGHC3caNYD1HW64PBMiy1csDYeP+lNZUE3yUb3D
   OIraee2/t2r9oKYhcOF1uIlFuGsbcjoUp7IHUgGynJVTHabZszuRDx5AZ
   A==;
X-CSE-ConnectionGUID: 3w3SnW/5Q6uGfedA58VHGA==
X-CSE-MsgGUID: t0tkAyfjRzSF/RXChEk9Mw==
X-IronPort-AV: E=McAfee;i="6700,10204,11379"; a="43851404"
X-IronPort-AV: E=Sophos;i="6.14,262,1736841600"; 
   d="scan'208";a="43851404"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2025 10:11:46 -0700
X-CSE-ConnectionGUID: l1h3C6/pQq60zxxXykztQw==
X-CSE-MsgGUID: KGSndeiMRgS1axcXrnKgbw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,262,1736841600"; 
   d="scan'208";a="154053295"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2025 10:11:45 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 20 Mar 2025 10:11:44 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 20 Mar 2025 10:11:44 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.47) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 20 Mar 2025 10:11:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZlzGWM68j1DGVTnAff37Jpbbaj6gGOlXF8vdjr/bJC3wwACWktEWgR8NBblzt158QME5irs3eC5bi0I87yEJOwThH6BA+XujFxgz5FU/S6H5n7YTJVAWI+FiE6R4DGV47bcyu/vCQifUKxsqkEFGpx5PdVIz9o/JSSrRDp3EOcsHSeKj0AFjvK+W4d6ZgKcvTklHdp6qy6ujR6yo/y7AYbdLqjz+mQbrEaeceQeg3S4yiypSdNoeNfBC9l/lgtlPRrMuQfG/H+wvMM64N5Wk5dkC2mR6Rbmav1muSvzk7QhMHlAKqqaY/F9ega/p9zZv7gWDkjlWI+XWdp0n/uzH/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k3SKU06oDADd1sqkClY9MWXBlzc0ahTJVWVIIxC/bXo=;
 b=jU6EsJDUvN37n0Ed/rYDc1zsIvDFSkNZ9BrxjS9ih+dDQskGL4+2N7Vbr39E7k2YFTBXeWUi9vLlJoZ9393XfcY+rj1vA3JKOXDZHzxqe6XW5tlLS/du3FqqYDlLnRfuKbFZDS4g3UzD01SBYUNuuCh8rJfb9kReD8VJG0rcZTgQgiQDIgYvXt/dmkCW6TFiKK6otY7068+c8T2qetUb75zytNncjGiRfJbCJFpeDlSfqJuQJWVasiXmhX2xrvBSApFtZMH58BVBdITO/R+YbqJIT9BxBm+K7YSHR8dwBrzbZUhMaCvD63QvaqIVFeRTfWsu7qfRiixlrKFdgmAHeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by CY5PR11MB6344.namprd11.prod.outlook.com (2603:10b6:930:3b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Thu, 20 Mar
 2025 17:11:38 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%4]) with mapi id 15.20.8534.034; Thu, 20 Mar 2025
 17:11:37 +0000
Message-ID: <8f128d86-a39c-4699-800a-67084671e853@intel.com>
Date: Thu, 20 Mar 2025 10:11:35 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: bnxt_en: Incorrect tx timestamp report
To: Kamil Zaripov <zaripov-kamil@avride.ai>, <netdev@vger.kernel.org>
References: <DE1DD9A1-3BB2-4AFB-AE3B-9389D3054875@avride.ai>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <DE1DD9A1-3BB2-4AFB-AE3B-9389D3054875@avride.ai>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0174.namprd03.prod.outlook.com
 (2603:10b6:303:8d::29) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|CY5PR11MB6344:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a437417-f72f-4dc1-1dec-08dd67d24634
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ekxUaHJKZ1hkL0gzZW5YZG5UUVlCd0lkL1FuQ1dwSWtXVHQ1My9hMHZjZEdJ?=
 =?utf-8?B?aHM5T0h4OEEzNFM1QndPdHg4UzFwS2NXSnovRkdoU2lDcENqVVVTTmFZUEpP?=
 =?utf-8?B?SEIzN1k1QzFFSERWMVJHdTZVZ3BsaytjRVI4WGw1Z1hqeGVMUXF1bXNLNXNa?=
 =?utf-8?B?V3RXREd2THZyQ3hkYmVENzVubGJzVC9LR0Fua25EeVBJeWd6cG1Nakg4U1Z5?=
 =?utf-8?B?aXJWempLb0V5WnVHK2RxZVFFSjFJMGgxVEJDeklDOEw4cFB2VGdybTV1Tm81?=
 =?utf-8?B?ME5yb3R1TjUwSkdZWlhCek9rWlM4VEMvRDRSUVNrcVpkSjJXL21EQ0hnUmhK?=
 =?utf-8?B?emdHOE5yM3pMMGJHY0tRVlV1VGJ6U3o2S0tkNzdVNGxhMkFEMDNhMWhjYUdT?=
 =?utf-8?B?Z3dKNGNmeDVHa0JlU1RaeEJ3YStLRE00aHVteEN0VVBCdFpRa3Bmc01vd0NS?=
 =?utf-8?B?OHRxK2ZxaW9sRXUzSWs2VE1tbTZUSDZ4SHgyWVlLdXJmMnMvS2ZQdGJ5aURO?=
 =?utf-8?B?ZDdhTW5oQ2VjenF1UWpnM0hUZS9aTVluRFREY0ZWRjlpc0haVC9XQ1FUR2d1?=
 =?utf-8?B?UlFIcy9yc2t5RnJXOGFrZEtCSGh2K1NUL2liYkFmOWM5YTlXTkFNRkFDUGNX?=
 =?utf-8?B?bEZrbjlWdTNUdzA0R3RZdTlVZllBekUzN2V3K0FRNkdsckQ5WFdHaHEvUlJF?=
 =?utf-8?B?emVQUGJhTEg2MUNDUklWcFo4WG1lTkwvMDJhRXorNmZSRnFTWFBnYjdIUUh6?=
 =?utf-8?B?NVEzM3U5SkNaSzdGcld6TS9NeXlUNHprbkhzdTJHUXRwYWF1SVZnRzB2OVND?=
 =?utf-8?B?cVJWL1FPR1NFU2pFaGtwRDEvdlpFbDVMT2lIUDZ6MkFFekE1VDl5UllZd2Fr?=
 =?utf-8?B?VTB6Nm43aDdpbUZYYnNrUktKeFFDVFBXUUFIK1NiaklHRzBxMUoyOEZRcjZF?=
 =?utf-8?B?RDJNbDB0MVNvbWhCZFpXOERGbHRDVWV6eENNZ0xkZXdhRkpHQ3BoUFhrZ1BG?=
 =?utf-8?B?aGFka2VpcjNOWWN6enBnWXZ1Q2lwRzBxVFNBQUpDMDVLK3FXaXdFa0Ewam83?=
 =?utf-8?B?K2RlbDZiMks5YStybnF0R29zQStacnlmM1ZSZU1IVjM5MlF0RWdMdU9rcENQ?=
 =?utf-8?B?Vk5Nb0Jmb2ZudUUvZWlrdmt6ZG9hZUw4Smc3am1xVk1qczBnc1JUdzVLb3VG?=
 =?utf-8?B?ZlBqT0dvNmRMcENxbFJBazdTNi9CTUtIZGFrcEVEUThjSFNKY3RicGFTY3V3?=
 =?utf-8?B?TkZ2bURyUG15bmZ3Nkc3L1RkL0d3eVNaUzROY05ONEdVRGVETHpJWTBKb3BN?=
 =?utf-8?B?MHdSdmxCbXZobWVmS2tPV20zaXdnY1owMXNscW8rYTFzZkVGUktYYmVoeXBL?=
 =?utf-8?B?amcrNUhuWml5V2JUdVhrSmptb2FSUlU2SVJJSFVrMVJPZDhvd25mSGNOMjI2?=
 =?utf-8?B?ZDZ6dGQvdUFTdGtxSWtEY2J1RjJmZC9ucnV5VjR0NGpqY3V6a3JwR2pQZmti?=
 =?utf-8?B?V2ovOXVMNEVqNXFVYThhcXhMMEFaRzBMSFpYNkxzazhZQUdsM0pDMDluMzRQ?=
 =?utf-8?B?SDEwRk9pOEVpS0dKbG10NnRoRCtCdk5pdHpPK0ZBZHJtZnBTSzBPUFlWK095?=
 =?utf-8?B?NkZmU1dvSk9xMVVHL1hTRDltem4zanA0QURDVTR5YlFpaDU1YVcvOVRJaXIy?=
 =?utf-8?B?cVV1S1h6NFlwQU9wQkpSTTNKMzBrUWZZLzU0Qm5PL2tTRHNlR0tVN1FMZ3Bm?=
 =?utf-8?B?NzlWbTV3ZitTbGlKaThSSTloMEg3MzZqZWxOR203Ky9pSmlCRDZUZzhFWi9V?=
 =?utf-8?B?OW9qZGlOaW95Unc3STBJeHc1di9XTVN2SlVaOG9qeE1Mb3RIRW9SUHlUaURh?=
 =?utf-8?Q?vfWo/nRutSW0C?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OXNLbnFiM2l1akNTWVVvYW1jTnU2aUF2bSt1NmY0ZGE0ck9YQWdFem45NFNV?=
 =?utf-8?B?cFNSa3pNWG9PRnExNmUvV0Q1ZEk1czFiZG4xcDlEVWpVVkY3YXd1K3J2TU5L?=
 =?utf-8?B?cmgxdlhGNFVNU2tXYzNrOTcxVXIzb2JHYVcxeURRdDM4Sk51b3NuNFZOZXl6?=
 =?utf-8?B?MUJjRTNNRTVBa2wvd2lqbkxBMW1jRlpEWE1ybHdsSVc1cjI5YkdDSXhSWHBH?=
 =?utf-8?B?NDVlRERraWFuTkMwam82azM3VVphM2RrRllqOCtmRC9DY21xNStHbHhFKys5?=
 =?utf-8?B?NnNMY0s1QmJoZW1laHpoaTZ2RU5WMHJTUnNMNTBMcFpuUTZmWnFUckpYNW4w?=
 =?utf-8?B?Mnl3Q3ljMGpSdDFwb0ZuN01UR0xncjByRkFaYjBnZXVpUmFQLzN5SzgvVlVz?=
 =?utf-8?B?NUE2M3NRS2pLQnhmNVF3MUZMNFJkYUNUaU81TkUzYVFqcXhvSXlrSS8yNkFh?=
 =?utf-8?B?QjBZaDJBaml5TDJhaXJoY0JHZ29IbmgrbFB2Y3lJU2xLdGUwdGw0OHNhQjdx?=
 =?utf-8?B?UE5FNDhlV2hnZnZIaWlxRXVsVGpZQ3dZSEFPMG5KNTRxZ1Y0bjIreTRqUFh1?=
 =?utf-8?B?cmJWN05ZaGRzRDNlS1cxK1g1a1ZDemRNazRCQ0Qza0l6NU1ZYjB0MXBKcjJo?=
 =?utf-8?B?K3BxOW4weXhTRDJjTWZzdC9aUXdoOVBkWWJqTnBLTzZjZTJVOVNsa25QczdO?=
 =?utf-8?B?ZDNUbG83RHkxZmh3VUxFUWlacTU2dWh2TUlRY25aWXkxUlJRZnIxQ2JjU3gw?=
 =?utf-8?B?aEpBTHJuV0FMeFE4dVNWd05YQ01CMkkwa25sbTNDbzhxVTZaMEYycUE0UE5N?=
 =?utf-8?B?QURRRHppSms3S3kvK2NFT3BjdlMrWEZzRnJyc3ZmUGpkVjFPRkI1Y0VlT2x0?=
 =?utf-8?B?N1pCaHk5STZUd21lS21DSUpzUis2b2x4M1cvYWJMd3Rzaml1R0Z6SVVJQVl4?=
 =?utf-8?B?MGx5SnJDVlNNd1VTUUxndjZSc21jcjZuYkl5NUkwaGt2aWl3aEhJelc2b0JQ?=
 =?utf-8?B?OEc4ZFpkcSsxNThiNnNBUEd5dGFFYjU1c1NCYWs4cUVUVk13RW4vaG8yWFQw?=
 =?utf-8?B?OVJlVHNzcTJKSk9BdnNsaWM2Tk1wencrNDBmU3hpdVllbkNXTXU4NU5ka0Ju?=
 =?utf-8?B?cGMwdDE2N0kzQVVMNzAyZXhCUytDVnhFYVgvMm42YXl5UUF0MUtoMlhXVDZ2?=
 =?utf-8?B?aFlhS3l1R0F3MFhuOGwvVStVR0xSK1FQNzg1eUVWUzk5WklJcSt2ZEJrQS9s?=
 =?utf-8?B?ekppWUdnTEo0NnNXNEQrTzlENS9VWDUrS1creTd5eGY0Y09kOURBT3RCR1ly?=
 =?utf-8?B?TFU5TzZTV205TmpFcHZPTmRHTjErNHp6OXphbkhmQWNlTTdNK2w4VW1kMzBD?=
 =?utf-8?B?dTJXak5CNjV6MEQ2OVdicEdKSW90bmFNYTNCSnliSHRMVkVSdUozcUxGQW0v?=
 =?utf-8?B?all0ZkNKSXhkYjB2SytBemI4K2JoQkc4QTNraEZSMDBDVVFGTmdqMFVUc3N2?=
 =?utf-8?B?akZtWm5JaVdZakJpcDVCd05SdXhCcWY0RTNWU0dCN2xzZXJBNWdDbWh1bjB0?=
 =?utf-8?B?aGhiRkJnQXBLdjVyR29oWTZlbW9vdGswL25qQ2p6bUhGMUhyV2lXT2JRNkpo?=
 =?utf-8?B?S3h0ZmJMdklON0hRdzlIRW9SS0t0YklEQjlnL2xCSlNsZ2NxQ05DdzhuQnNl?=
 =?utf-8?B?akRxbHFjVGVYZmxDT2lxemFBdWlZY1BieVlVMFhIWXQ1NEVXbGZhZEN1NGhS?=
 =?utf-8?B?c0JJbnpHc1JkN2ZyUkd1VS94b0FEcXltazNoZjhVdG0wZi8yNDBzaGwwbzBq?=
 =?utf-8?B?VGQzWFJCa0pNTklYWStPZUpKdFN5UXpoSng4RHo5d0hpUURxUCtmdTB0a2Yy?=
 =?utf-8?B?STRQTWt1azQ2aFhhMTBDcTRmVmZibFY2TXRTZldJeStFQS83RktjeTg1eWMr?=
 =?utf-8?B?bmZlOUhVOE9LTnVtbHB4VVFudmZLRFlld1o4TnVQWWNNR3M5K2oydHN6a3hI?=
 =?utf-8?B?bjZDT1NKbi9FQ2k2QXhPK3Q2cTA4N1h6SE9maFV6QVFpWVR3clhwUEV6ZHhF?=
 =?utf-8?B?Ylhyd1JJN3lJYVVtUjZoN2RaRVQ3dUVvM2IzNFYxMU9SdWdaZ3JOZW1qQXpM?=
 =?utf-8?B?SW5zSVVEeG9OMFBtTjlRMTFERGIwenZlYWhOVUlndjFIcTJPTklnVnBIV3RT?=
 =?utf-8?B?OXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a437417-f72f-4dc1-1dec-08dd67d24634
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2025 17:11:37.8635
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wr08Cgkb10onVMXwlFwyKQpQavjjnrGyhc+oCSrORAJY0ZyJYmOi9ERYMF+tM57XVwMr/tqEB52AvIrsSdPKD1Cm+Jss0ojyvFH1UvAUBFs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6344
X-OriginatorOrg: intel.com



On 3/20/2025 7:35 AM, Kamil Zaripov wrote:
> 1. Would it be beneficial to modify the bnxt_en driver to create only a single PHC Linux device for network cards that physically have only one PHC?
> 

That depends. If it has only one underlying clock, but each PF has its
own register space, it may functionally be independent clocks in
practice. I don't know the bnxt_en driver or hardware well enough to
know if that is the case.

If it really is one clock with one set of registers to control it, then
it should only expose one PHC. This may be tricky depending on the
driver design. (See ice as an example where we've had a lot of
challenges in this space because of the multiple PFs)

