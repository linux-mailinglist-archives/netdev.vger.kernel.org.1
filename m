Return-Path: <netdev+bounces-188810-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 092C1AAF005
	for <lists+netdev@lfdr.de>; Thu,  8 May 2025 02:37:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 228B37AA203
	for <lists+netdev@lfdr.de>; Thu,  8 May 2025 00:36:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94848173;
	Thu,  8 May 2025 00:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LScsb3pr"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C05413207;
	Thu,  8 May 2025 00:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746664629; cv=fail; b=s3FD4YimDKBY2fN45O7bB24E4BxjE80rv9dYcfivfh0ujI+TtxWRq7XWTHF/vS/Gu0F3vYqPR3RUzKuk2efDovkHK7V9GgFcenPHir7xaTWd/LdTljCMZqge0qu7p98OYMIKXkELXI255xmqSXWm2Uq/e4Zocu1y2NmkkQ6Q1T4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746664629; c=relaxed/simple;
	bh=ySt/m1GvNfEjg5ss2WG86bs5zC3yGEY5mZn5XbhkX7E=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=YtxCEKIhBkfGtCDSDK1sNs0zMJWOw5Loth552mf3JteIpYBAdz0idcCsw6hyE4jPuk/wraEf8dOmybwmOA8oiMC0UMLqItBVvmjvqam9nHsyfiSKwrhQnGfFIablfMyB+s7ypt+JrukCA+Xow29GjXGyjEvGd9VL4bdAtQUmfaU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LScsb3pr; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746664628; x=1778200628;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=ySt/m1GvNfEjg5ss2WG86bs5zC3yGEY5mZn5XbhkX7E=;
  b=LScsb3prp2gU9IvocnJeOQmrINx8tryu54xAc1VQtiMAuWNYsDDeqKNR
   +dNK8orYtqELwqSPiJtorkLRdb2ncmAYtGUJYhVTfSna+TOGDfp3DPhea
   QkLfkCrTObrMC7WZwKgys4NfqQzn0OVOwmsRy1YafLYt4ANXNBAUC35zL
   fnKMK3WuzMukgifJ+hRLRQSDyyljXcoui2ThGq0QuZyvNP7nXdxlymOuA
   IE6Ku3CfF38xyTheOKDbJauikxpb/pfySxImm2NeZZj1is4WcpZthkfu0
   lXpe3goWFg2ezaZ5q6m/zMAIR417Y57rtTPgQNtzUFMWtUC7hXUkTU9r4
   g==;
X-CSE-ConnectionGUID: wJ0fJJkbTi6JmP5lpFh6Yg==
X-CSE-MsgGUID: 7DB+ySDLSiO/Qe6uPF7aFw==
X-IronPort-AV: E=McAfee;i="6700,10204,11426"; a="48133275"
X-IronPort-AV: E=Sophos;i="6.15,270,1739865600"; 
   d="scan'208";a="48133275"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2025 17:37:07 -0700
X-CSE-ConnectionGUID: ZaISAYkxQzmgLuZtS03sig==
X-CSE-MsgGUID: Gs6wxRedTLK+J9S7Iqic7Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,270,1739865600"; 
   d="scan'208";a="137123420"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2025 17:37:06 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 7 May 2025 17:37:06 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 7 May 2025 17:37:06 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 7 May 2025 17:37:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jN7gRAKF+412i4aINP+H/dDFOP3xuNyM4yOEhOu8JJxRNHa7Nq1iKqpLlTMpk0W/RKtxOcl5eonYA8cZ4GzlMgw/9CH0jnihnb5yKSQlmjgbqnOD5bv0DvwkOHXl9uwcwZJvgUEC/loW+oyQ4gk7PIuNnZ3BwPi/Fo4nDjs0ET5tF4nClAMjSj7/bZ4GwXvKHroNV2cMoXxVDKQ3+wVUII4XWqQs49OmH33BXR+8n2f7pGIt5MWGXVlSBDAThDcY9ZbNa9U+2KBLOXyTxFWECLUMjNmSqiMyFxj8Vzo2+xKKbl+pvayz04Mj23J6RI5TZdAyj6EoCwIWqqrmMplZkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NqdWNW5SshkEwRBtjn6DfXciD3vV8NX/171FiVXMM8s=;
 b=oNZGqgy1carC8QykUOEqPiCLC8u9OUVpfiAEk6X5OPgXUj98ERwC59LIiKlErsmuX/Ehin/IMYkGXMM6RA13DWjK5ZI94Zj5pFoNQAAFZOctHw9wgwieEvexOi4E1mGI7mDkZbrh4unXklm/q3KgQ0kjO90hwzI8O9MgXH6gqBIZ+SnahfCQVwJVyohK6i7QxWRbaygo5dSZbG+OCYTOwAWANDcbkQYUa+zdDYUOOqQmYI4DnGUnJKBZFOk8Oa7u6W3RnjBID0hb55lVpEBryey0jQFeGornxgWeG3Zr/P68afCdodpUz/XVjR5PeUtrVa+Gq0KyptxLRW8zS5wJYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB8794.namprd11.prod.outlook.com (2603:10b6:806:46a::5)
 by CO1PR11MB4946.namprd11.prod.outlook.com (2603:10b6:303:9e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.26; Thu, 8 May
 2025 00:36:31 +0000
Received: from SA1PR11MB8794.namprd11.prod.outlook.com
 ([fe80::a3d4:9d67:2f5d:6720]) by SA1PR11MB8794.namprd11.prod.outlook.com
 ([fe80::a3d4:9d67:2f5d:6720%5]) with mapi id 15.20.8722.020; Thu, 8 May 2025
 00:36:31 +0000
Date: Wed, 7 May 2025 17:36:27 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: <alejandro.lucero-palau@amd.com>
CC: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>, Alejandro Lucero <alucerop@amd.com>, Ben Cheatham
	<benjamin.cheatham@amd.com>, Fan Ni <fan.ni@samsung.com>, Jonathan Cameron
	<Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v14 03/22] cxl: move pci generic code
Message-ID: <aBv8iyReoXruSaA7@aschofie-mobl2.lan>
References: <20250417212926.1343268-1-alejandro.lucero-palau@amd.com>
 <20250417212926.1343268-4-alejandro.lucero-palau@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250417212926.1343268-4-alejandro.lucero-palau@amd.com>
X-ClientProxiedBy: MW4PR04CA0381.namprd04.prod.outlook.com
 (2603:10b6:303:81::26) To SA1PR11MB8794.namprd11.prod.outlook.com
 (2603:10b6:806:46a::5)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB8794:EE_|CO1PR11MB4946:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d7ac28f-bdeb-4cce-2968-08dd8dc86088
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?iA2pSbCiq3NO0V1hfydCv05ZOLKhkQ9mtq7y04A2aENATa2j+6VG3VqDfd8+?=
 =?us-ascii?Q?RvbzF3/F39O9WlQgP0pVkdDaYRdc1L3Ft7YdHEOKB1zKq0Hr4SwPcxH8dxx1?=
 =?us-ascii?Q?pcDH1Sslmtqfr3gbOQLxhgscI7OyH8ESYAz7NGBlj/AZNW3+o2QdTkb2Vd4C?=
 =?us-ascii?Q?6HJ9OtIF6HSeynAR3yLhn4kHLcYWaVval3E2dPOJbT5OSaHGziiRxADRkHQQ?=
 =?us-ascii?Q?zD3BrncUGkCJwcg8Ef3NubE+FegnCp/HR7GOq0U0T96ZraacyiMAVEtFm0WW?=
 =?us-ascii?Q?Whlvjiy0pFi3YRJ7v60A+ldSNRFDP4wVavxPtLFLhFUORHmfXvNT2AOctl6F?=
 =?us-ascii?Q?w5TXTCUVcYUOagGZXX8f+/G7gYScJjlRODjpbYhKnHuYCFqe/mUMmFU3G4ps?=
 =?us-ascii?Q?965ZhzY7/XSgBFpkG/Pb7dDdaUz2BlAi8ynx1ciL6Ftf+ojx9bdqrjTXJMc9?=
 =?us-ascii?Q?V+yF9s8jKvnwNBIXh3ZcX6Bjv9M6kWMgc2eu/N2S3BZBri+1HPZZyywflHhO?=
 =?us-ascii?Q?JlcGIFTUR8i/RlfSrNA5IKw9gZRq4mqOxnuyxPanZlsfrrZly9Pn8R1BFHdD?=
 =?us-ascii?Q?lRl3fPubuszZkKrI5IFO7GOClHivn/KL9r9ZktLyLqzAi9jWH3CeFsN10jr1?=
 =?us-ascii?Q?bIwTLp7xxjmD/ZXU1RuJbTBp5kV+wdvXz9iHZk18ACb7lz5lqcjBW0AxlyM9?=
 =?us-ascii?Q?P3bgTPU/mWZCd2RSdhxXk6Lj6z3iODxZVm+O+7G6pnS93gwiamG6Jla/MxJH?=
 =?us-ascii?Q?2FtdtDv6J/80w11lWU79nr5UTC9nqq3Mlej2yLD0a3LY4mRUIr8Wn36JXvOm?=
 =?us-ascii?Q?kkjArvpfcyo+yKoQuRCBIdr2snpSf6Mm59Vt+Us40hMjL/8gPPlg6YkjTBwF?=
 =?us-ascii?Q?SOxPfUlLkN4tn1njDXdzltExY7GRZP/sy0OLFX2SuWLRSED53SyYOL3nd4Dm?=
 =?us-ascii?Q?WpPBeEelN5xZfmx4iCIO1nrPgKhO5/rrjHlh6oW8X+Ijz4wL4PrFde0fmpQJ?=
 =?us-ascii?Q?qER9W0+wFbiac+7evosgzRqy0PZ73NBDpqWB9LXMoyJa1+xx33ZyqjdK2r3h?=
 =?us-ascii?Q?/rH6/ZNKUe/f020+UGxWSEaZInY54fXXuSLDosZySCh/4ALXxavCc02tiwaA?=
 =?us-ascii?Q?JI5pUquQZVvWHsPvYp1ZFPJPvGmgTvkDQCLutXBJZuE9uK29TrexWATDxkTX?=
 =?us-ascii?Q?YwFwlXvV3wU16rFq86f2HXRgR0GTL4pv1FbxmndGtGAM0nkwZW7gJZvhnVDT?=
 =?us-ascii?Q?kUMqaWtR7dBPd8xUI8CwykwbGv/F+3enT4eKyVvMKDT2hzvaH4fuwH3y5/+u?=
 =?us-ascii?Q?FqKCSAC7b3HgdGriMuM9/5eV2PRSSfBmpvkzEyasLjqdwjoUqd/HNonlibZZ?=
 =?us-ascii?Q?fXLCSzHwKre5Q/2vWVc7Bq6xYLrWcMw5Ozn7iC3/x4eZTr+8jCAfmh1OpcQM?=
 =?us-ascii?Q?A/3hYdTn/Go=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB8794.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0a8v+h/EDw0QfH2ixJlkWidRETiRQtS5VtYSO3n8P/AnNqSWXG7NZjMnLB5e?=
 =?us-ascii?Q?3bGoinIMKMVaYZjQVJHrF99fpZBCFuZLKhoMDgtX9KajXh+0/Ysov0NVkz4i?=
 =?us-ascii?Q?uLbbD9SZRJcUp+xb7TNML3xebbwQvwz4tncPt4HfXs42OgIjB4Bja0XTP+xk?=
 =?us-ascii?Q?dwtxNh5d/b0z90qZQyDYDuUgpP1D9Xs75pvMTVybLFAWJZYxB9qIuWJV/k6f?=
 =?us-ascii?Q?rCg0/laxwHlLEOStlzi520kcgUoyteVbJnPVEyv/iod1tmot30Sr067MzzWw?=
 =?us-ascii?Q?zA6dd13YulyOwtYQJB1LSlSFTH1yMnrF8CJAwagOn7+BEFebbf8TKoLoAoOT?=
 =?us-ascii?Q?3zAi6ARCbf0+31jRXY5PfD1/2qA6ZwZXFkB/VoU2V9d8lO7qbmhzpWCv1Rh8?=
 =?us-ascii?Q?UF4p/1d8rZxR2rrMvPxUTtAS1qPjVpZArbYtoNG6TBXf1y4Zel4/VEieeOd9?=
 =?us-ascii?Q?Hr8rXgrGOMkR5P/Y/XcfYtJp8EOjj6aD/FJUzlW2XnhuFMe6RpI5YyrQGlUe?=
 =?us-ascii?Q?P3G4JjS5WfKzYBSTt53dUwSutJxKnEY7vBFf5xcF8Cfir6M6Z/PDOerS9A9N?=
 =?us-ascii?Q?rDsGdRnVe8NDJ8AOkDBHpcXYOqc5EklsJDUn1/leVmbVYuM8Kk2JQMYqiTeB?=
 =?us-ascii?Q?2k5n61CmKmkjFNvJ2paqB9wl4shYJ713VSL98VcdVO0F8LbaP71hfC3DN5Em?=
 =?us-ascii?Q?ditWfyRhTMQA+kK8dkSRU/xfrM3bhzsizCCsGQQ7joi5ovWbdiIqp0QyUyrU?=
 =?us-ascii?Q?jqZeSwSm8xyLh84vMKElXvzSXX3s/jVuuNKrVUXfxD0XM66ChunfJiAczw38?=
 =?us-ascii?Q?Ded5u2zIQaDHo8jK8ZKzzgt/YHQQfkGreJlfGY/oRh5zUa0Ck742251fyPfF?=
 =?us-ascii?Q?FOgETUMoMZbB101foTg+DWsSH6UGi94ngfgsKLlVm2szl2XOc6fAhWCTyn84?=
 =?us-ascii?Q?i5WXx9ENp4JZw+qgUuNsRSQo818hGKgrsd2K6z7p9kGlApl8hnSSzvciXUu0?=
 =?us-ascii?Q?EDtLZXlu0y7E+5C/qrlItbsZy7XzSZ/4hTHRPI5cJUVgn3FUQzb0vs+4xqCM?=
 =?us-ascii?Q?BELccqgMe4QTfWbiMd7nZoXz0e8d5SL9rV+18H3CZK7zFlLcCfRK/Ch5jHre?=
 =?us-ascii?Q?qnf32El6zyMTnjE1fpVfXwii9A1EAVAkNyk/Ul4eiapRkwa7D9Z4vuzUljq+?=
 =?us-ascii?Q?J2nAbbqGsjq02Vw56hLt26gIQwK16MmG8rOcHxo5G0ri98VrIJJ9zXML4Cat?=
 =?us-ascii?Q?V0CODE02OImH9NqrbusjFCThT9cxRs1ZjKMtzP+FQw2QfrXEobl8fRcdzotJ?=
 =?us-ascii?Q?qIF2vPMr9T6M2siVrv2+nbQlBW9pbHwwwzx6sEw9G+lYKyBA4soUZOneAdAX?=
 =?us-ascii?Q?fJXyO5jWdiHky13Lh+OXRJUKHTvuZaVndxUm4sscMfClgZps+lUbrCp2l2FB?=
 =?us-ascii?Q?EVqxNHaW+ykTribXnfRamskyeUMB6dYe+dDNVaVo26NyL9O05yXn4TIE7koy?=
 =?us-ascii?Q?qVouP/JvuJnmiY0Xf0FCZIMivHmu9ENklLLCbylveaTvRPIY3OQjIJKGTXif?=
 =?us-ascii?Q?7H6IYzqubVXc1yN37KTVivdHKPrSimBfubWQ7kKwRlZ41F2OJ2bnAGC+9Nx8?=
 =?us-ascii?Q?bw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d7ac28f-bdeb-4cce-2968-08dd8dc86088
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB8794.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2025 00:36:31.0643
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9rE6gdg1shcDnteCpZw2mPXqmmOHUAGyTJwc1hpZBv0bWEfyXEruIDovXmBCfvuBLkE+XT176IfVeXqUbm2goew5+WozFUwKqhASH/42TFk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4946
X-OriginatorOrg: intel.com

On Thu, Apr 17, 2025 at 10:29:06PM +0100, alejandro.lucero-palau@amd.com wrote:
> From: Alejandro Lucero <alucerop@amd.com>
> 
> Inside cxl/core/pci.c there are helpers for CXL PCIe initialization
> meanwhile cxl/pci.c implements the functionality for a Type3 device
> initialization.
> 
> Move helper functions from cxl/pci.c to cxl/core/pci.c in order to be
> exported and shared with CXL Type2 device initialization.
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>
> Reviewed-by: Fan Ni <fan.ni@samsung.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  drivers/cxl/core/core.h       |  2 +
>  drivers/cxl/core/pci.c        | 62 +++++++++++++++++++++++++++++++
>  drivers/cxl/core/regs.c       |  1 -
>  drivers/cxl/cxl.h             |  2 -
>  drivers/cxl/cxlpci.h          |  2 +
>  drivers/cxl/pci.c             | 70 -----------------------------------
>  include/cxl/pci.h             | 13 +++++++
>  tools/testing/cxl/Kbuild      |  1 -
>  tools/testing/cxl/test/mock.c | 17 ---------

The commit log doesn't mention these cxl/test changes.
Why are these done?


> index af2594e4f35d..3c6a071fbbe3 100644
> --- a/tools/testing/cxl/test/mock.c
> +++ b/tools/testing/cxl/test/mock.c
> @@ -268,23 +268,6 @@ struct cxl_dport *__wrap_devm_cxl_add_rch_dport(struct cxl_port *port,
>  }
>  EXPORT_SYMBOL_NS_GPL(__wrap_devm_cxl_add_rch_dport, "CXL");
>  
> -resource_size_t __wrap_cxl_rcd_component_reg_phys(struct device *dev,
> -						  struct cxl_dport *dport)
> -{
> -	int index;
> -	resource_size_t component_reg_phys;
> -	struct cxl_mock_ops *ops = get_cxl_mock_ops(&index);
> -
> -	if (ops && ops->is_mock_port(dev))
> -		component_reg_phys = CXL_RESOURCE_NONE;
> -	else
> -		component_reg_phys = cxl_rcd_component_reg_phys(dev, dport);
> -	put_cxl_mock_ops(index);
> -
> -	return component_reg_phys;
> -}
> -EXPORT_SYMBOL_NS_GPL(__wrap_cxl_rcd_component_reg_phys, "CXL");
> -
>  void __wrap_cxl_endpoint_parse_cdat(struct cxl_port *port)
>  {
>  	int index;
> -- 
> 2.34.1
> 
> 

