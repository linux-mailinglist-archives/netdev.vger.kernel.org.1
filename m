Return-Path: <netdev+bounces-159525-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73FE0A15B0B
	for <lists+netdev@lfdr.de>; Sat, 18 Jan 2025 03:28:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6F8A17A40AA
	for <lists+netdev@lfdr.de>; Sat, 18 Jan 2025 02:28:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0242E39FD9;
	Sat, 18 Jan 2025 02:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="g9Pw5qJA"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE8C123CE;
	Sat, 18 Jan 2025 02:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737167286; cv=fail; b=lpRz8g4ewqSU6X9UBK3bTOy3kEcDht2p4QKUYiYzNPitzCzr6m+sOpsDJR75GjznSqHM1WlGkvRnayoJf83DxRnAmc/9QltgqzMHldfP1u7xwaUVkEeUn178XetfbTGCnF5ga8sNFuZa+uKzcYucDMmLr7j5Yn+oknuUHgwQzKk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737167286; c=relaxed/simple;
	bh=OSqM/bfLcIDfNOzdMeC/uZXFXxRnloeGIwTFi91YnIM=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ggC9jmRWJbdddiiXFAXz69uEI6k4HwWF962Lxr3Hu68H0sCPY8gZFqs3pT8GiCQDsx8Z75OD7BMwQRA0/e1xomq5U8sslZVueeOf355RmBgbLn1ylkySPwuUeMZAaGki60/JuoHYlzjE5JahBkUf2N8jg51/JI5U1KghKxZ6bO4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=g9Pw5qJA; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737167284; x=1768703284;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=OSqM/bfLcIDfNOzdMeC/uZXFXxRnloeGIwTFi91YnIM=;
  b=g9Pw5qJARjGCfSHcmFHoHqfQLN0STfQ4efB3ikwHXb78pBIYkeMBLMEj
   rR/md/QZiZnJ4S7hdUam0akKyJXxkx9IL+MN7XD+pqk7LTlRHIGwg9kGE
   nO0WMI8mWTC8PixXK4BBQrkFAXDohva80D1Q7AACEHUOpdThV+ArWLavw
   qUtp8qHirN5G4UIeEbKZSWvfNCdidF7Ozh4icn78rH1n3Jb82SrBNd+LW
   S9YrYvPYMZsy9vxFCBQ2dQ1sJCiLbrJZEbel474Ju6HbeoWoAKf50YNIl
   m9UegIC1pBzy1nxee5GXHBQCcz6WaBw4TZhijfHWX4DcmR2bhRv2ZyG47
   A==;
X-CSE-ConnectionGUID: gdKhm4LeRfi1HipYwT/UoQ==
X-CSE-MsgGUID: qSAeVVKyR7qlKOlrKP/4Bw==
X-IronPort-AV: E=McAfee;i="6700,10204,11318"; a="25213417"
X-IronPort-AV: E=Sophos;i="6.13,213,1732608000"; 
   d="scan'208";a="25213417"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2025 18:28:04 -0800
X-CSE-ConnectionGUID: taKsj65WT5yQob1J7Sin0w==
X-CSE-MsgGUID: j73klAEzTBaBvsk17gutiA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,213,1732608000"; 
   d="scan'208";a="106009732"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 17 Jan 2025 18:28:04 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Fri, 17 Jan 2025 18:28:03 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Fri, 17 Jan 2025 18:28:03 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 17 Jan 2025 18:28:03 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uK7t2sfa88iaS9cE/rhVn7PqSi1JZ0Ezrwwkoc3o5JB8IRI0AtpA47qsWIGbXR/UkIMSNiH5qWjhzd2PEDncsSgitjILkcpTnLm8grvzyzoAZD+F/BXSyeFBj1UIOrSOPGQFDabxZx7v5VB/4UbLoUV7rU9USOBxE9MXrlS6/3GpJQcIuf435qznLu6/VvWeaFimp8+R9k4/I3uP6EbpOfe3q3GfZ7IxWLaAVF9tEJ9IGOfsTx6qaiSoKpTuAMVY/H4yKw/yNrIAxksf5ob/+K0fjoR50LWTtliFqReEjNcrLKlzOP9f5SOrtReIs7DwraRxb3fZM8B2pzqmk5jVjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cst3qnkTF8LrRKbtibtisPBvMr4lT+6elzpSq/+e+Ic=;
 b=Y46672vsgFtQfibOD22pYWWC8YIqzuZ4tx7hzHXatFRI9ZkN8zBTpBjJtK8wiemkfADW5SJvr9dc//szUGieDwy85wF6+u+bfSDxXl/5lnonPoMd1sIZiDnzrNHAhm/29E9lJ9mn+z86Rw+as/xpbq0ljUBfnb7v2mdgtU9sBL/vnXcWRXn84e94iQ+5wqdMLOdVQ+6x696QZ/ml0SSVoRxoh7MlgQse1Uvl7ZnTcJZHKs3gsBkKxgIHJ5vRr9F3w/YLIBAHqZujL++2BnQfpvbKIegEkplEKL7y9mvN2s5gSxtDs7wdm9MFHX0isjjJIsDV5oElVsKcQXuVmXtEvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SN7PR11MB7639.namprd11.prod.outlook.com (2603:10b6:806:32a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.18; Sat, 18 Jan
 2025 02:28:00 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%5]) with mapi id 15.20.8356.014; Sat, 18 Jan 2025
 02:28:00 +0000
Date: Fri, 17 Jan 2025 18:27:57 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: <alejandro.lucero-palau@amd.com>, <linux-cxl@vger.kernel.org>,
	<netdev@vger.kernel.org>, <dan.j.williams@intel.com>, <edward.cree@amd.com>,
	<davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: Re: [PATCH v9 13/27] cxl: prepare memdev creation for type2
Message-ID: <678b11ada467d_20fa2949b@dwillia2-xfh.jf.intel.com.notmuch>
References: <20241230214445.27602-1-alejandro.lucero-palau@amd.com>
 <20241230214445.27602-14-alejandro.lucero-palau@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241230214445.27602-14-alejandro.lucero-palau@amd.com>
X-ClientProxiedBy: MW4PR03CA0019.namprd03.prod.outlook.com
 (2603:10b6:303:8f::24) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SN7PR11MB7639:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a1f4c44-5f16-4032-e5aa-08dd3767ba46
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|921020;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Q1c+lE6Bi06WGdfQsoUOzOaItkyotiDb/RubIkmVZECX6nxQJ5zNF54Vi2Wq?=
 =?us-ascii?Q?I8FcW9UoEYZP0HRAs2yTDbebXCqjQE3Yf6CApdmYy2YvICI6o1tjoenwRL1q?=
 =?us-ascii?Q?MsZz6Z/98hkWW4dtdFOPKgD5GQ/laxHwMDnhVO9qCmrX9nNUHfHIUSix0yXo?=
 =?us-ascii?Q?/7gueK0NpM+dXu8+xJKuj74/BTWH3GglZUNgJAv46I9EL2PaKGpcKkGSX4ZY?=
 =?us-ascii?Q?/x+FITYiZveUDMUXAOvXcET5JlKwhQWY3ByFjh6s1fA0aKyFn+Tudb1PtB7j?=
 =?us-ascii?Q?6k21ykngMwIkpt90U9g/aBH6sRE0Qh3kt39TkpTdfnqit2nM+LFe/lGoijwT?=
 =?us-ascii?Q?0YjDXUaQYGq0yNDSQpwxoVKTA46QGg4SiaPzoSHCod9nEzejwNyWZ0kOC7PL?=
 =?us-ascii?Q?Tfulcg3q4gjcfebhNFfYBHf6pKLxqhM0MM+miSUn2yM8iPtpTdWgN/LGe3IQ?=
 =?us-ascii?Q?n6n/30wPdERd0EypEYBzPym5LYwoO8srXm+ESf2Q/XeFw5pACakbXatfahul?=
 =?us-ascii?Q?f3cvEeWG610n0nCN+ZDD0+jGoKZFEm74Jd4L135kswHSBqyo9iNgc2N2Zy/p?=
 =?us-ascii?Q?3y6mqCrE/6urdLos2DdPFvUtwpGjin58dx2qAbk8B3QWSfJICB9UC9vwQZ44?=
 =?us-ascii?Q?unbZwTEJVDunBFn16YynxoHgrxb9MaLH8dYDTkwk9/dMTteDeBzizGTJ4RbD?=
 =?us-ascii?Q?iOXiqIOoPoUCFpDdnEOOakgfsP1pSMpjtBafUTlT15p2nI1/soeo+5/f5U/S?=
 =?us-ascii?Q?+tiZDNTo3BA4WDh+fI0ZWB5iF6mxAguOeLzBoDb8uFKg9gFoIyxodE2U6U22?=
 =?us-ascii?Q?dDg/iR04G8rh8Kei9IH7DfWO5Uo0uLTvVuMuona35jjEX5P/XFrCiSru/jtx?=
 =?us-ascii?Q?c5kzCBmaU0b4g2ePUzbssm9+1zILn9SAt4G7kQy6AvVG3xvgFyE+OopVi2jv?=
 =?us-ascii?Q?ZI2T3b4w1IcxA/hbHTCRLYhwgpgfK2pMEeKYESbLrG843JB7nmJ/efr/7YWr?=
 =?us-ascii?Q?2bDGd0ZHpiTr4o3KiMLRKmCuEBgzvk4/PU5LWia97Pv8BiPHGWQvJc34Muma?=
 =?us-ascii?Q?6mncuTUM9AuelF/wW6KGOoXKQ4oftANl/UTnXXJibj0qATFQ37eqWDnF3Q/a?=
 =?us-ascii?Q?vKHf/edF83OualDHAm4IPosieXRJiFf8Dsb5AXxzRFfBb0hWPR8JQPEyRnb2?=
 =?us-ascii?Q?1aGagvrOKUoNxIzDjfnxn1AQ8ya2k5lqh+WBV1G0GY2dunRjyNaFoGF2nGRU?=
 =?us-ascii?Q?S8WR+Kg/PTtRbbYm/I/IYk2AANqNHZkCnqgpcrxzwJCKTQ/7mU5ZDOiHOaAZ?=
 =?us-ascii?Q?ncAbE9NuRGrImRJh2mlSF61yWr35Q4+hfENSa1pKwALOcMpfYoRm5FoyV39T?=
 =?us-ascii?Q?mpgKnUfcPuy5NBtPwAGcR5thTWBtpYGawtots83yZpvt5EZ+4GG0oAudNShX?=
 =?us-ascii?Q?7YwkFQMW4CE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1T5MEPlprEh7/B7QNjWjW8IeKl01EQ83DkmJq9de4V/M8tuNHV/PJJGOKpB9?=
 =?us-ascii?Q?Z7vtM5FT17B/HeSivkvUJoZ03+zA4E6yKZput4ui0jGjsWMusBMxWpiuK32C?=
 =?us-ascii?Q?7MXf55wFB2EPqh35zyN2ANXaYo5WmR9QOzPP8yxW/ZUxa614wJTcy6WaP3C2?=
 =?us-ascii?Q?ebTUsVZ5hthf4F7XZZXVfyJx8cO/tPgerJtA6gBL3sxT5v/zE5f5amnoYbln?=
 =?us-ascii?Q?gd4utMZ5zaFUvWwc623izumwxmKLY2eOuZP305i2Mbwl2eV8f9H7QvaNYfFj?=
 =?us-ascii?Q?VD8yo5YvyJi78/RrB7pCtN8VA4QHUNKa+147CAmFS33sbNDvXSqLpRl3pWI+?=
 =?us-ascii?Q?oylKJY5ZglopP0twDWgXGEsToTmYlpJ23PvUpbunb97z1tYI9OZSFz5/9Nts?=
 =?us-ascii?Q?NkPZYaBLLm7PM7kkTkqen4JADqYFxGL/VKlwiRsau0Y4+EqcPiuTN8ksWnIt?=
 =?us-ascii?Q?x5I14zJ0UGyUNCrDrDpv/pTSjX2a0EX62TlnRwsz1iQbKGF7oMp7QdniF1lw?=
 =?us-ascii?Q?YV2vStZHstOwa+9MFdtDdR0WvdOynPeEIgwFtZsDrJoUlBoNavtc/bMeG6W4?=
 =?us-ascii?Q?L6tsZYicqjBtw1oXDd21SgHDnGRxcHrlw9g1uTElmGJgz0ii3HZ+ua0DSbgI?=
 =?us-ascii?Q?ZJslDpghM6Ekjfk7ZXdDjDAg8RGR5SBp0VpI8/XBFHvIroNDHHtrtV32/9E5?=
 =?us-ascii?Q?9RE+21Gu6SGyjW1xQo/9OIg+nV1+dPanzehXZ+Lxg/swO+DmeCaOe/yydrLx?=
 =?us-ascii?Q?CWDh2r1Ez3IW1Spo1WRTlViSifNVtUEWnBgYEi7ua8wCwJ+ordiyeAO27pMB?=
 =?us-ascii?Q?SkcKvzxuUGEsigMeyoUj7UvKnPfqUqCW3ehACoP1qU4iX/N3L+Hhkurj59Gk?=
 =?us-ascii?Q?EUNFlpPmapRlgV/uD+WePKXIstf31Ku9YVAUrfLa7t94H9QyWshreYqWwvna?=
 =?us-ascii?Q?m3gmz3umejN+1umO56J7pg6ow3XbXzjjgzgmuPNyjrFvnA8UWEEc9WNQgfSl?=
 =?us-ascii?Q?WOUfzQdw/3EOY91rbH3YqPFY6x2S3334o7u/xyqkqGAqsEeMN++GjYVd9Ehg?=
 =?us-ascii?Q?NIcQ5S2Vw9A/fVF3sgv7KyemoW78crz/KThPJA9vn++BMYCBStb9gg2dPGM3?=
 =?us-ascii?Q?eVms7iTbz3bIgcaHYTs8Bu6aJO1uaRBOS+YxdskTt7Qm0tyzYUTXdWv1Vd/t?=
 =?us-ascii?Q?F4xXvMRICKgO/JPCKl41FQcx3vRkmIZ2tTWS26E8cAO6U4hPVz2z7HHkG4D5?=
 =?us-ascii?Q?IKUe5JpcDDXz+zGHEqJ9I5Wpj3+v0CmmfiGxas2jeqJyhWaScfdTEpFo0mlZ?=
 =?us-ascii?Q?m6ka93kmnSRkX1pwljC16EAy0Hl8YIUlAxg0Fqvs8UezPzo6JlSW906qKPVd?=
 =?us-ascii?Q?adHxLAQaYmVXU4/wWXqpnteteyQxmRztl9UjxsWY5bQB9VZS9Kr9gvfgc4LH?=
 =?us-ascii?Q?b9cph6FTRo14WPLdOK2InXUHq+ZBObI2ULl7UJaxptCAud2JTKPcCZ3+HLBF?=
 =?us-ascii?Q?rndFBNg6iuBoB3hFJIkRLBoDFR0Vt9HcpXSnLtPRyNzFHN4ws8zWv/ZVW4C+?=
 =?us-ascii?Q?1q75sTAWNywmeJv3+VVMKvSed2WXtCx0I48zOyhUQARQ67j84YeBhCmTu3NM?=
 =?us-ascii?Q?Bg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a1f4c44-5f16-4032-e5aa-08dd3767ba46
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2025 02:28:00.4112
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jCDukuTY8f1fA6h7aCifmFEt4CTwasPcOFkY5/e9IxKxhoZQuavSwCDH6SeQy9C8Wfk1daXmaaTPy2HP83rzT+s+dYMz4GgTuoPuhp7lfT8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7639
X-OriginatorOrg: intel.com

alejandro.lucero-palau@ wrote:
> From: Alejandro Lucero <alucerop@amd.com>
> 
> Current cxl core is relying on a CXL_DEVTYPE_CLASSMEM type device when
> creating a memdev leading to problems when obtaining cxl_memdev_state
> references from a CXL_DEVTYPE_DEVMEM type. This last device type is
> managed by a specific vendor driver and does not need same sysfs files
> since not userspace intervention is expected.
> 
> Create a new cxl_mem device type with no attributes for Type2.
> 
> Avoid debugfs files relying on existence of cxl_memdev_state.
> 
> Make devm_cxl_add_memdev accesible from a accel driver.
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> ---
>  drivers/cxl/core/cdat.c   |  3 +++
>  drivers/cxl/core/memdev.c | 14 ++++++++++++--
>  drivers/cxl/core/region.c |  3 ++-
>  drivers/cxl/cxlmem.h      |  2 --
>  drivers/cxl/mem.c         | 25 +++++++++++++++++++------
>  include/cxl/cxl.h         |  2 ++
>  6 files changed, 38 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/cxl/core/cdat.c b/drivers/cxl/core/cdat.c
> index 8153f8d83a16..c57bc83e79ee 100644
> --- a/drivers/cxl/core/cdat.c
> +++ b/drivers/cxl/core/cdat.c
> @@ -577,6 +577,9 @@ static struct cxl_dpa_perf *cxled_get_dpa_perf(struct cxl_endpoint_decoder *cxle
>  	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlmd->cxlds);
>  	struct cxl_dpa_perf *perf;
>  
> +	if (!mds)
> +		return ERR_PTR(-EINVAL);
> +

The references to @mds in cxled_get_dpa_perf() are gone
after the DPA partition changes.

If an accelerator has a CDAT it will get qos_class information for free.
If it does not have a CDAT then I wonder how it is telling the BIOS the
memory type for its CXL.mem?

>  	switch (mode) {
>  	case CXL_DECODER_RAM:
>  		perf = &mds->ram_perf;
> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
> index 836db4a462b3..f91feca586dd 100644
> --- a/drivers/cxl/core/memdev.c
> +++ b/drivers/cxl/core/memdev.c
> @@ -547,9 +547,16 @@ static const struct device_type cxl_memdev_type = {
>  	.groups = cxl_memdev_attribute_groups,
>  };
>  
> +static const struct device_type cxl_accel_memdev_type = {
> +	.name = "cxl_accel_memdev",
> +	.release = cxl_memdev_release,
> +	.devnode = cxl_memdev_devnode,
> +};
> +
>  bool is_cxl_memdev(const struct device *dev)
>  {
> -	return dev->type == &cxl_memdev_type;
> +	return (dev->type == &cxl_memdev_type ||
> +		dev->type == &cxl_accel_memdev_type);

At this point the game is over in terms of future code that trips over
the assumption that all "is_cxl_memdev() == true" devices are created
equal.

>  }
>  EXPORT_SYMBOL_NS_GPL(is_cxl_memdev, "CXL");
>  
> @@ -660,7 +667,10 @@ static struct cxl_memdev *cxl_memdev_alloc(struct cxl_dev_state *cxlds,
>  	dev->parent = cxlds->dev;
>  	dev->bus = &cxl_bus_type;
>  	dev->devt = MKDEV(cxl_mem_major, cxlmd->id);
> -	dev->type = &cxl_memdev_type;
> +	if (cxlds->type == CXL_DEVTYPE_DEVMEM)
> +		dev->type = &cxl_accel_memdev_type;
> +	else
> +		dev->type = &cxl_memdev_type;
>  	device_set_pm_not_required(dev);
>  	INIT_WORK(&cxlmd->detach_work, detach_memdev);
>  
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index d77899650798..967132b49832 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -1948,7 +1948,8 @@ static int cxl_region_attach(struct cxl_region *cxlr,
>  		return -EINVAL;
>  	}
>  
> -	cxl_region_perf_data_calculate(cxlr, cxled);
> +	if (cxlr->type == CXL_DECODER_HOSTONLYMEM)
> +		cxl_region_perf_data_calculate(cxlr, cxled);

Per-above no need to worry about @mds reference in this path.

>  	if (test_bit(CXL_REGION_F_AUTO, &cxlr->flags)) {
>  		int i;
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index 4c1c53c29544..360d3728f492 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -87,8 +87,6 @@ static inline bool is_cxl_endpoint(struct cxl_port *port)
>  	return is_cxl_memdev(port->uport_dev);
>  }
>  
> -struct cxl_memdev *devm_cxl_add_memdev(struct device *host,
> -				       struct cxl_dev_state *cxlds);
>  int devm_cxl_sanitize_setup_notifier(struct device *host,
>  				     struct cxl_memdev *cxlmd);
>  struct cxl_memdev_state;
> diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
> index 2f03a4d5606e..93106a43990b 100644
> --- a/drivers/cxl/mem.c
> +++ b/drivers/cxl/mem.c
> @@ -130,12 +130,18 @@ static int cxl_mem_probe(struct device *dev)
>  	dentry = cxl_debugfs_create_dir(dev_name(dev));
>  	debugfs_create_devm_seqfile(dev, "dpamem", dentry, cxl_mem_dpa_show);
>  
> -	if (test_bit(CXL_POISON_ENABLED_INJECT, mds->poison.enabled_cmds))
> -		debugfs_create_file("inject_poison", 0200, dentry, cxlmd,
> -				    &cxl_poison_inject_fops);
> -	if (test_bit(CXL_POISON_ENABLED_CLEAR, mds->poison.enabled_cmds))
> -		debugfs_create_file("clear_poison", 0200, dentry, cxlmd,
> -				    &cxl_poison_clear_fops);
> +	/*
> +	 * Avoid poison debugfs files for Type2 devices as they rely on
> +	 * cxl_memdev_state.
> +	 */
> +	if (mds) {
> +		if (test_bit(CXL_POISON_ENABLED_INJECT, mds->poison.enabled_cmds))
> +			debugfs_create_file("inject_poison", 0200, dentry, cxlmd,
> +					    &cxl_poison_inject_fops);
> +		if (test_bit(CXL_POISON_ENABLED_CLEAR, mds->poison.enabled_cmds))
> +			debugfs_create_file("clear_poison", 0200, dentry, cxlmd,
> +					    &cxl_poison_clear_fops);
> +	}
>  
>  	rc = devm_add_action_or_reset(dev, remove_debugfs, dentry);
>  	if (rc)
> @@ -219,6 +225,13 @@ static umode_t cxl_mem_visible(struct kobject *kobj, struct attribute *a, int n)
>  	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
>  	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlmd->cxlds);
>  
> +	/*
> +	 * Avoid poison sysfs files for Type2 devices as they rely on
> +	 * cxl_memdev_state.
> +	 */
> +	if (!mds)
> +		return 0;

It turns out that nothing in the poison handling path requires 'struct
cxl_memdev_state'. So rather than key this rejection off of @mds ==
NULL, I would prefer to find a way to make this optional relative to
data read from 'struct cxl_mailbox', or 'struct cxl_dev_state'.
Conceptually there is nothing stopping a CXL accelertor from supporting
poison management commands on its mailbox, it's just unlikely.

