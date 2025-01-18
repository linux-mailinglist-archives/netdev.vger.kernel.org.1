Return-Path: <netdev+bounces-159514-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A5505A15AE9
	for <lists+netdev@lfdr.de>; Sat, 18 Jan 2025 02:43:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EDA27188C06A
	for <lists+netdev@lfdr.de>; Sat, 18 Jan 2025 01:43:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A44D022339;
	Sat, 18 Jan 2025 01:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gSpJVnwL"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9338EED7;
	Sat, 18 Jan 2025 01:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737164599; cv=fail; b=orcpwMiGihr9xbOzc6a2/6JelJ+WoWLOpsNQeW8NtIz5AMSPiUhHxsVAeUOcdPNqZ/Dy1+Vlcxf2zyRAN2BWF+vzqjBCRH1DMmupMyapaHsISKGWJyQUoTBEteg82JGO4qRDdUh9JJmv6mzT+ynwtwvWZvdEtxWUWrml2ZF9Uwc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737164599; c=relaxed/simple;
	bh=TuLUwyRu+BLrRF33hwXu+iCX0c3Y6DgPeVeJq11jd8g=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=pDCFcNqiA0sW1L45UHIBiSsTBwSKTVy5aGO0Uee2sOHvytIlSE/HM5m3NDJQ6AbYHs6/6hoOjCUcEn0Dbgi0OaS8c4d5Z6u495MWWKbp5TnjcA6D0yTZIu1Kvz85s+1psP3rk+dAbjiRgjKPVmZn4fK8cH+X0FkEg6xFFBsJ980=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gSpJVnwL; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737164598; x=1768700598;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=TuLUwyRu+BLrRF33hwXu+iCX0c3Y6DgPeVeJq11jd8g=;
  b=gSpJVnwLu6JbejhreHX8j7Ua8PVQVOgvmcm3bFGlBA2qHmF0wAffEJaX
   7VFWbzvfNRKNVHi0ow3CKrcCqPlRn2uzgRrnFIY0NnWbMolpBO+I0HbI9
   S7OPcp8iLtCfQEn6MRIgK8CJgHKCCgWnLkSdC89pEuvt6VbdxyL/XchCT
   Q9g8XzJOUdWxnsC7QD3VK9G8MciV99pSNCFlVbGEq4UNz2zUrk1RzgSaW
   qN0GOaGfcuZKtUD2ZYT6KZtpLyyHFySxBtaX4iYMIY5xvXMR6aNhkrcRi
   C1vHS1IbfDG6IO6tyihSaZ2tYyBpW2iVWAafubgTnfeyf2194fGjjtEAe
   g==;
X-CSE-ConnectionGUID: kbpw70NxRSmMmDc/CLlWjQ==
X-CSE-MsgGUID: BgNI9HEqT8mwVCn8eK8RAA==
X-IronPort-AV: E=McAfee;i="6700,10204,11318"; a="37773912"
X-IronPort-AV: E=Sophos;i="6.13,213,1732608000"; 
   d="scan'208";a="37773912"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2025 17:43:15 -0800
X-CSE-ConnectionGUID: tfbkAzV2S9y4Kqy8Z2drCQ==
X-CSE-MsgGUID: fFn10Fe/Sm+5cdPRyGOlmg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="111070929"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 17 Jan 2025 17:43:15 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Fri, 17 Jan 2025 17:43:14 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Fri, 17 Jan 2025 17:43:14 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 17 Jan 2025 17:43:14 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s4WX3a+gifsutPQgv7AJ1NJ2OMDZqj4c+ohmBCVhqDPUIjUasrrK4ohNMv2xef2NhYUurFtfOUyP1LnYQI6crrS6iOnOHlNLfwbA0WfpOqn0A6KK8lYaQS/fJW7awOS+IUhDgWPeCkqK0dD+YkOWyds/vogfGEdNlz8RpoEhhlKZxrcCdFWCf7hNTFJabsuKFUBw5p7pG4A9KxgTp1i/EcDhmRN1wcLw36/EPIT/IQX/Eg7o4QQrMqFejHRBzJQI77Iie3/nLMV0c77xgG0y0KidvEyy7KD8rFQbu3aLLFuepRSrp8pKY1smTz8tOaGmAVngunvbnBvFDs4/orRLMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z9FXcMMgi24ZxXRFSmZ6fjxMO1wMuPcYiMGXaeLWznU=;
 b=n1DgpsgVAmMCJmonTktw01lJWSCV3nIR3qraaHcxnEngzanJx7JgQ7OYLZJYDK7udElfjpnzT3FbNKZ9ASH9Yf/AzEtplQaFvJ4zd7KnhjQByFZ55FzLxTZLWnlO+lFjDCv2a1Bw+k/Sst56FdUJ8TIPPhmzdHzCEngubnxpVQrXCeP6IBU6ScuTMqSXbFW+JYMSVj8hub8nE67OYW7y8rHE5W4RTWYfU3HKr2t8iRfRtCMteyQOpm/DFHh4I5wjDV++lwXwpmNMbbzFbo2mWCePDekSfyFTxOC7soVAdFupMq7C3Mi17QEcvK5/Pj10tI5JZRkV4TZ874zOzLhd0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by MW6PR11MB8437.namprd11.prod.outlook.com (2603:10b6:303:249::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.14; Sat, 18 Jan
 2025 01:43:12 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%5]) with mapi id 15.20.8356.014; Sat, 18 Jan 2025
 01:43:12 +0000
Date: Fri, 17 Jan 2025 17:43:09 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: <alejandro.lucero-palau@amd.com>, <linux-cxl@vger.kernel.org>,
	<netdev@vger.kernel.org>, <dan.j.williams@intel.com>, <edward.cree@amd.com>,
	<davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: Re: [PATCH v9 05/27] cxl: move pci generic code
Message-ID: <678b072dc57c9_20fa29472@dwillia2-xfh.jf.intel.com.notmuch>
References: <20241230214445.27602-1-alejandro.lucero-palau@amd.com>
 <20241230214445.27602-6-alejandro.lucero-palau@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241230214445.27602-6-alejandro.lucero-palau@amd.com>
X-ClientProxiedBy: MW4PR02CA0029.namprd02.prod.outlook.com
 (2603:10b6:303:16d::34) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|MW6PR11MB8437:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b45d808-9f68-4deb-4815-08dd37617809
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|921020;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?tvOhNR4+I2e1fpaGktHzj/yWbKeuJapNnVGk276IU9FPNgU2YpAbzc1a8TqP?=
 =?us-ascii?Q?ZUjbdVQ6D+v1OWpGbXc7ymNJeZSTVoPqq61cPdDjfSwmT/DuU1Ti0FL8iXgO?=
 =?us-ascii?Q?QIo+oOpwsjSn/6r/kROYmKSAqUNqPGSnvfwhhAj0cfNIltzRWqGOZS8sFIYM?=
 =?us-ascii?Q?kh4aN7CPWC1TQwytiMV0HiXctATZMv4yk+8uUYTBJVI5pYbQBqAQUOmqPQg9?=
 =?us-ascii?Q?GcKYCP3jNsEyktP1wf0vLXpe1GZLrM3doHo5MzdOddijiqo+BuR5dz1h3cxY?=
 =?us-ascii?Q?tbGxNiDwy92wnndVAtw+Vx+SLP7YngwsXq/143d0aMgdFCc6SYneQiDcC1Sz?=
 =?us-ascii?Q?iURi3r9L18Ll4sA6o3Ub+YKFPaocRZno+XLqst7ZX8HVGAvOLXpR+y52zJjx?=
 =?us-ascii?Q?1j8Z0zKfGnjhfEGjYA5sQOTiBJUJh/+EC589HK8deWZoxAY4/M0DiTO3QbHG?=
 =?us-ascii?Q?oeWzehrrEs3WMCUxRayJwuB7GGkQuzuhukSOpONCcuDcr4ZEdQzlC2Q1/cuc?=
 =?us-ascii?Q?qj9r2YW2456iMHg2oQ3FTA8KvWan9xIc5Mc/waWzbUFfYcB8/zYsL5hxV1Sl?=
 =?us-ascii?Q?gjsd6nh+6/fD3Rk8TDswmqoJ8mznktcdlsCqhjgyRUGcrpAnKhM3o9HJWcfG?=
 =?us-ascii?Q?qPGXxO4k2PplM/PuNFVC0MJwWtD46MQhYHui72x+nsrl7laVKCxhAC5oSzr7?=
 =?us-ascii?Q?CyCiLyDzrYD4JnoCw2yPUr+bLS+Hh8dLUJrQc7tU3KTPqkZwEtMnKMCdi8ye?=
 =?us-ascii?Q?hOZSg3l3TWprICUbiOaNZ5+r1ToeGTS6LBj61jb1rQckdc9OPhKsFA2Sa0Zv?=
 =?us-ascii?Q?T5ptx5FwdZocUwreqHlfg2STmiJbQp6jbFjva3rxRIkwxPGIKtQmhy/9cAP2?=
 =?us-ascii?Q?q3FM1fs+CZU/iYGOdTyyUcKB/5md2/dnSCIXSUQjFIEUirUOQDpbKw5Ts4J1?=
 =?us-ascii?Q?uqkgsgUwPSpEx9w90M2P0AFVeBuExg28uBYmRrSg+SGCP74DKZExWwUbG1B4?=
 =?us-ascii?Q?9A1oDNowxZnuih0FL133tVLtxnwdRFFGjx1M3jo4DV5esxjFwyX/hlqFATAV?=
 =?us-ascii?Q?kSXNEbazRAUVE7jHTrBPDf6MEy7HTdCyA82LBf/CbovIzAbf4GdRsO3dFcqz?=
 =?us-ascii?Q?Ef6E5MdGTuL1XoLPU84Z6tjjPOaP2ixWZB2p/nl8JalPis7JYwkdy9GkZZso?=
 =?us-ascii?Q?QLxA0hJXHRmPAqpsymc+0OzIqT9/exyERQ8z6vZFcetmNpSwxhoTBISPfVB9?=
 =?us-ascii?Q?uPuQ40mpMW4/3t4f3d6zlKQ/yKRvTCqGyeOw4HRtsRjCs23CQ3o6VyzotVlA?=
 =?us-ascii?Q?5MUphVlpvtYmnROBFXsf6GGn0nPvKeTn8TJwnx1d9LtCLGYcJEgKsodgdCKh?=
 =?us-ascii?Q?2Ef8ydcnkVSMPT4CTvO2kYl7B8IF?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?laP1LevdOu3qD3HoQ1lVKt96f69ttX5sWUhPGNOg2Yt3950lE1hMfd9qX6f8?=
 =?us-ascii?Q?g2wfo5VzYCuWobMsfC9Aa7IjQzqWJmFhkT/QBXBWKehHLPCvuzIREyrA1gwa?=
 =?us-ascii?Q?jy1D6laSaMynfpQWG+PjH1tQgndZD8DwBb04eMQQaZS9Jt3BPpELDrE5uuTh?=
 =?us-ascii?Q?EotQf6mQmRAKpcpBNCGd1D1dWuMr8eqI7OlyZjSXxTsRMAug36G1WGeJx3Rd?=
 =?us-ascii?Q?NeZMJSxufzSgC9muI6cu0qb2d0t9mY3uRActmWFZnWa5NVRuTXeFlVFjG7mF?=
 =?us-ascii?Q?DAP+A6Xq8boPRn2FlkCuEvzGjzpPPzHNbBxnV0xYj4kDVOT3FlWOKDlSwE1a?=
 =?us-ascii?Q?/Lcb2oVaGpxxqVsG6aCTgKeGOUYnrw3fV1+BpRIMx5jb6G3b9O4eLrT42KIL?=
 =?us-ascii?Q?T4W5CSC6VHRZNBkI5GRZ52depS9tEChUneA38qHoWOOf2z/EDLzWDi8p9rP5?=
 =?us-ascii?Q?RXWf0+AVDPQS0skpYxNySc/4YCIrSzuveUr/Tl2COzOsIt+Dwot4FHl07hj8?=
 =?us-ascii?Q?QYP+zoO3476/h9d/LXEe0VTSUHOgDs1NMdbQUMDgqK7nyzGD9QRsbRGALBYZ?=
 =?us-ascii?Q?WkEnkqX0gwfsj4teqOcGfWjUYa8ojC/gmrBqsnmLqIqBnxawfKQHER6TfswB?=
 =?us-ascii?Q?RQ6egyYRGMVXy09FZ9i+ckJgO/8dq4zfjctdH8tlwaNn2+snEP7yPiZGlSd2?=
 =?us-ascii?Q?ZovZ64D5WoBO03WUqj6KCsq+tHJMJfKDOJyoxGBB5TfiVNUWQMT+IYV4uRgE?=
 =?us-ascii?Q?RfC87C6qrrMYUSJ3wXrqg8acGOO1IOAP4Cx7Fv4cB9fVaQXRIw/RZwPy5eKK?=
 =?us-ascii?Q?c7SXV5T90y1dS9Df39NPiWOA471vHkLVMxEKrATARutVb/3rig7Qkt69HFKD?=
 =?us-ascii?Q?uUIE4o+B+aHNMKiWSyOwkbZDmukkRWUJz6IVeQ5Pq7Fd/+j/qR2U8LqzWItD?=
 =?us-ascii?Q?CxqHnye3xAc3SayyuOnanAcpcxyJMrkPLr9teRs7xOdgoxsC69O/vUgC+qG1?=
 =?us-ascii?Q?TyFjASoUBdkbs/bsBRaSIYNTeCHS9QNcpAq1iw/1n/gvaz/OY9Da64vgP3r6?=
 =?us-ascii?Q?JY3i+mjiKcUSbQztEE8Hyi5yItpQKlmiiE4fKLSiVNaNExnm6BSZtU0kLNSq?=
 =?us-ascii?Q?5Md/5yYMB4GqbZTLzkEJa6QXJIZxI8Xr84971RGZDTJTuky/Ll04cw0LeLAm?=
 =?us-ascii?Q?rXkRDrC2z7XW+HFlj9Itu1dCjZ1QQAOWsbU+GEL+RGYjY2UQGR5ZAumF668M?=
 =?us-ascii?Q?oeXyq5Lc7OCsnLR8cKCo7MmVbvFQc4OtwdPgJGZl4yHU/x3lpVHhCz+JJOuW?=
 =?us-ascii?Q?okfhDaL2oDFsplI1YAa8ikUcuYmSf3qHt9KxPCOArJoLx9jgziSb3uS3quHJ?=
 =?us-ascii?Q?Zz66y8LmWQGNRp1byggyHdF1TR5ZZe1iUDl4ofmLHLE07wsDTlzJ4+pipDCt?=
 =?us-ascii?Q?OtSAScYbw/dtHcxbvS4ITxxQlZ9t62X9DIR31mc4oYyrXTn2XNaQZzJuN3rB?=
 =?us-ascii?Q?eaisJuHzaTTHL3TzTMZAx8XD1PVWE7HnrH8ULdZs0xBBvXS0gsflffJ+CG87?=
 =?us-ascii?Q?Zgbnqyvg6C1xX9yqnbsw5HbzpFQNQNzeK0ITyc6OHledT3nhPLVgHLguqwa3?=
 =?us-ascii?Q?Kg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b45d808-9f68-4deb-4815-08dd37617809
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2025 01:43:12.2933
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kuayXGDN/Y4ec5bznT4Z1J2GCwTYrg/425sbAaY65FPuXERVCaTbm9V4h8QrZipFpRl44Z7pHStH4Oxci/8dMFsgYmk8EtPbBWYg0dg+JQs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR11MB8437
X-OriginatorOrg: intel.com

alejandro.lucero-palau@ wrote:
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
> ---
>  drivers/cxl/core/pci.c | 73 ++++++++++++++++++++++++++++++++++++++++++
>  drivers/cxl/cxlpci.h   |  3 ++
>  drivers/cxl/pci.c      | 71 ----------------------------------------
>  3 files changed, 76 insertions(+), 71 deletions(-)
> 
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index 57318cdc368a..5821d582c520 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -1034,6 +1034,79 @@ bool cxl_endpoint_decoder_reset_detected(struct cxl_port *port)
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_endpoint_decoder_reset_detected, "CXL");
>  
> +/*
> + * Assume that any RCIEP that emits the CXL memory expander class code
> + * is an RCD
> + */
> +bool is_cxl_restricted(struct pci_dev *pdev)
> +{
> +	return pci_pcie_type(pdev) == PCI_EXP_TYPE_RC_END;
> +}
> +EXPORT_SYMBOL_NS_GPL(is_cxl_restricted, "CXL");

ok, so v9 is missing my v8 comments:

http://lore.kernel.org/677e0af67788e_2aff429448@dwillia2-xfh.jf.intel.com.notmuch

