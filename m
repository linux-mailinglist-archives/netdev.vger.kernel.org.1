Return-Path: <netdev+bounces-103309-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 97A4D9077E3
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 18:10:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 103D1B20F4F
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 16:10:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E565B12E1D9;
	Thu, 13 Jun 2024 16:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aibniqXa"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00C14A23
	for <netdev@vger.kernel.org>; Thu, 13 Jun 2024 16:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718295001; cv=fail; b=SMEOBvldUs18/rxQjPB1jqERM0wWmA0dDFW2UPgtCQEpKi+Uihj43XDYCbT2j35Giy9PPDp2UZDj3FLYAQBW1fS0I78hwIrkntgsVqwOYXF9qRSe2ILtjpMzntLtCEHvbv1oozZNgfRVc7M7gkAp78TDD1S7RAWBeGOYVYWFulE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718295001; c=relaxed/simple;
	bh=eYEtdmyt4cM08LD7u/LciVWIblOm8kdAdl2RT1Z8BZM=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=JGxmEUNXpDXmlcNyGZiBW2+afKu6UuEcI0BM430bNQrg2s2gdV2oen2OwS4TCcPK0/rzyWywGKUuFKtrKjsjYNIgSFqTimUpGpsmChO0jxvzpWjIl0nMZoEZ8618BMXdTUggNLVgIqxEnOvjuFhOrjNW2u30szWpPb6oLsni6So=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aibniqXa; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718295001; x=1749831001;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=eYEtdmyt4cM08LD7u/LciVWIblOm8kdAdl2RT1Z8BZM=;
  b=aibniqXamyb5tekwW1WZJoHCnnDUL9zdYBpONijgi3PmXKb5wIn+Vpot
   cSHoFYNNOZEE2kTB4w1ynJ9x9wxq75K37jAPn2AUdSjAKTVIKzskw/7C9
   UB3+jL9Oj+0OuHlTTtr+xs4JU43wcW0k/i4+uZb1ghNs5TWCtgYtsaRKi
   CNbMOr9dSvaWBRYqFCt7Ux0yUINCP28vUlhTxX3LlCHAz8bAY1j2mrqh+
   OSfBdRFsHDjx8PQFNEdLmSMQn2ldHO3ugbv/SKlwS29EN2/0KXMD6MGO9
   Si88A9A1latq0rd/zw/Z0fUNDU61bEwzFUQ84AELNHZxsiYVBSPK+s0oj
   w==;
X-CSE-ConnectionGUID: Lw527h1rSQexfg0BP+1Lbg==
X-CSE-MsgGUID: NpHt5ntxTQeJjqq1Ufmr1A==
X-IronPort-AV: E=McAfee;i="6700,10204,11102"; a="14963445"
X-IronPort-AV: E=Sophos;i="6.08,235,1712646000"; 
   d="scan'208";a="14963445"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2024 09:08:51 -0700
X-CSE-ConnectionGUID: YBUMp33qQUORLPDt7c+03w==
X-CSE-MsgGUID: cEG+bo3OSaefNrqxscjSoA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,235,1712646000"; 
   d="scan'208";a="44627515"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Jun 2024 09:08:50 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 13 Jun 2024 09:08:37 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 13 Jun 2024 09:08:10 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 13 Jun 2024 09:08:10 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.46) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 13 Jun 2024 09:08:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UrKG9nBFFm846fIWWkMfAni19dYeEHY8pkBtIDDrcL37ToFxvmw3bcS/UokfPsJPYwAcw237D3bc+kEfZ+JZ1pcotSus0pZfFvTu0/mZjsJr2BpgC6kmztZcLxpDZTs0GA/tcEbhQL8iD8HilJ48N7DfM9GGYb5LRGg8ZRBSYVqpoU9lM+/rhiq8K7uje4ifvO4j1R6oN/2dWPSrBMIF/3HIxuX3Sv+DxGlS9VD/sd7Y0NresUMfPPxwkxEJVuWpOKwC+Ks76kYxw2ztlhNVXfi3Vavc34xveo3EE64nzfpuid/C2Qxa1t4nQBQXu2MD4LLAujx9eGWwnO4Usxu7TA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vPmzYaDSKqwF3i5xi89eNFZonCP1mwiIIRpThFk+0ns=;
 b=Nyng4KJBzgCj1RHAFusiEO6/rvktEQxXMUvy0F+gExR3reEG1DpG9we40z0Vr8oihEbEVucxknS9e7LJuOhkDP0F6Vg2RAfKPDotgK7a32p3lZLPnaxlOeLDMoBBMrVyiG6uFBgYk+jbvxK1mxLv+eOdAtA7rawIwE/XZC7kF2J4k/ZchqxImAcFEYZqbldhnUwrJT8FL8n6zuQEf2Kox+qiOIOOEw2Xd9iouq0KQfxYezN0mEZVRnUOzF9+QNgw9pmddATt5an0gEDipjgDiKbIyeU94yBzaAZ5wb2dzOpVx743jcsdg0KD7wuGhtibacahicWZgSSNyvgZvwwypg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 SA2PR11MB4972.namprd11.prod.outlook.com (2603:10b6:806:fb::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7677.22; Thu, 13 Jun 2024 16:08:00 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca%7]) with mapi id 15.20.7633.037; Thu, 13 Jun 2024
 16:08:00 +0000
Date: Thu, 13 Jun 2024 18:07:53 +0200
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
CC: <intel-wired-lan@lists.osuosl.org>, <larysa.zaremba@intel.com>,
	<netdev@vger.kernel.org>, <michal.kubiak@intel.com>,
	<anthony.l.nguyen@intel.com>, <jacob.e.keller@intel.com>, Chandan Kumar Rout
	<chandanx.rout@intel.com>, <magnus.karlsson@intel.com>, Shannon Nelson
	<shannon.nelson@amd.com>
Subject: Re: [Intel-wired-lan] [PATCH v3 iwl-net 1/8] ice: respect netif
 readiness in AF_XDP ZC related ndo's
Message-ID: <ZmsZWfn1ev6KWo3r@boxer>
References: <20240604132155.3573752-1-maciej.fijalkowski@intel.com>
 <20240604132155.3573752-2-maciej.fijalkowski@intel.com>
 <6f616608-7a56-43d6-9dc9-ea67c2b47030@intel.com>
 <ZmhdZwzIStFpghZK@boxer>
 <8a835d02-d65f-42be-b4dd-309e9e04d7f0@intel.com>
 <f453bcc8-8528-432d-b90e-35db9d4b0fe9@intel.com>
 <ZmsVfbDTyZty2/Xh@boxer>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZmsVfbDTyZty2/Xh@boxer>
X-ClientProxiedBy: MI0P293CA0010.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:44::12) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|SA2PR11MB4972:EE_
X-MS-Office365-Filtering-Correlation-Id: ddcb7c57-001d-4486-5c35-08dc8bc2ff7c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230035|376009|1800799019|366011;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?AuWtz1zGXkrQD2Oaaw3DzTz+2aFbKb9Gvb990f6fuoBNplmZE2ZHsqOMNFII?=
 =?us-ascii?Q?2jveyB5BFLuZbrNdbSsLOO7S3sunJIqxviLwrUWgi+Y9sT0zJjXFQ+JT9Yh+?=
 =?us-ascii?Q?d6OkDBo2dgyl+BUvVPGtoeoaM5hoiB/6alJKXvqBfquv5DKxkKHuHHKVMeMF?=
 =?us-ascii?Q?TmmeJlDwYfDN4whOyhpgsDzUVWPP8HHpf3Er5xlNFKIcnCtyasVs941F82WU?=
 =?us-ascii?Q?zoOYqt+m1sG7gkEof/XtJf1ZjBF5TDQnmpK79n2sK+NQ7cHSyfFMF7bKsK5Y?=
 =?us-ascii?Q?tW8b3sW3qgXn/LkdXNb9gmQz/d7tIwgFFN91CHyb8m/A9hDcvdkEAN8C0Mxt?=
 =?us-ascii?Q?RigIZK0fgDzxuvFVJCTcHgLvAn2Bfk5bo6Q98QMf8bVAL5AClRrRfooIB/0y?=
 =?us-ascii?Q?tHpL08xN7rOVw7FXi0tOl2NrQ6PZJF8xjua45awn0XuttgovreGjXsBgo1u6?=
 =?us-ascii?Q?IDhTU6AOvvJoHJOf16tYwCI9pVpaJ1yX2rbi+YHK2X/B6+mPVg0aAk1kRwid?=
 =?us-ascii?Q?VQ/HEaBtu5sMucZec1Fel4PA7rSaaJu3Me3k+abuatENopdvME+Kp6lbT9Y7?=
 =?us-ascii?Q?u7jDa1eXyNg0C7vk5aC4LALjFs7x3jihbh6jf8PZyilbfG1mCOj72S6jgKAA?=
 =?us-ascii?Q?tJBQBLX5gVzZCXxrfE5g2KrEoa6+4AQIGzlb3ORnGFJ4bX86J32CopjDMK44?=
 =?us-ascii?Q?4Fv1Ni0tjSqLyTkJlV9ukKHjG0HZNiAewyzUuBLjvWu0/QLoTo8+hzRz//fx?=
 =?us-ascii?Q?/0X0Vn9S9Q0vtl+EG5/8wWYl1QezNDkQrumFidxrRcAq0HEHnYODmDOQx47Z?=
 =?us-ascii?Q?RBB26Nct1H7FB/XilS8dYsyOSkfYN/FmfSaQ2HtafppmKINX9PIiPopsGbQm?=
 =?us-ascii?Q?dDh44kLoCsC7+x+ENjVWN4KwUUYIST/mNSLMekQJYOneQDBneFarx2vBdBut?=
 =?us-ascii?Q?G8P6p+xRLmsrZ6n+2Njt1f4+Eo1wGfyLRrnXhaZT25ePT3/Eseob5+1K90TW?=
 =?us-ascii?Q?1AVv1HkQ8V3Q7Vz0NYLJeeM7dck6lxEH3qgt31mYWj40q1RLwAAYYrOh+bI2?=
 =?us-ascii?Q?EQSFWGCfDXfNvtz1nUVkR2ElXfGNdfiJdgrOgg8IFrWNGZjWupMdhv4kBfgs?=
 =?us-ascii?Q?nvcyCtyV69CD87nPggD4DewXmnld63ECX2sOezzaSFt18ovSnN9JLHolgiP7?=
 =?us-ascii?Q?41xzHcb3s5BivnpcHhw6sVLhnk4VsHvhkLGc2xI8pr1tV1IFmxJJmCEY8kgL?=
 =?us-ascii?Q?pV8cxSjynMDfB+ZUAWIQ8yXL9zDRJCnJzmRoBfnG8A=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230035)(376009)(1800799019)(366011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vxY3CpeErqWkiDsyZPbgF8MmvnP1QZmn6KTtsrwhohb3i+vR2ayuPkbRmhZR?=
 =?us-ascii?Q?pbFEgkywu7bhMne83bvaaPLytgkI0z0xYBmNEXYbXVIKzuVq54YU+QXUDfIh?=
 =?us-ascii?Q?9EeQSq0NySLJhvjyIwvVVcdbiikFcGGTMEI57LJYZhUBAwySFo4to6Yha0kh?=
 =?us-ascii?Q?X4fZtLhWmaqVFqmmDxbNToQr3k5eOSFU8M0Mrrh/kloMTp4BrH/1hRDF4KSw?=
 =?us-ascii?Q?eMohPi8j/teXttfaboq25w1gJWuZgblQ8BPa+IHGIn8Mab/iH9hGVB59YBr+?=
 =?us-ascii?Q?bgEBnAf/c9h+ZKZgFBqO3+EDeUK4lPtIB8GK9BNiItEP9su97T8Va7CYRiCl?=
 =?us-ascii?Q?VvV2ULLlUuQSmpLR+c0OdtJxwkOv1vb0PZMcpDvPascZpzKGzjuLD3S1vkme?=
 =?us-ascii?Q?I+XtdQvVeU954v5yEOCKtVBa1VTSJKvgknAxDIoDRmuwTxbqZEpJmRFGvrln?=
 =?us-ascii?Q?SFiGUlinNfbJNKIfy0xCvCwyBuSxwDbDsOeVt5Aktnth4X52CQDsvgSMB6eR?=
 =?us-ascii?Q?HTX+H+eI02DAK1iSXTxC6ly0YE31FRRZ/Ofy5uO262LKKb2YHFr5GXvX49c9?=
 =?us-ascii?Q?u4uYGcoYCeVl3S1B7IRi5lKgF804NtmkJ75KYxspdmgBpPV8Z2Ax/hTHYmPx?=
 =?us-ascii?Q?dCqwfmWPpVTiJqJuOwPwCAbwO27tTaQkfKOlk861NqgSh0yqm4k8JRI6aTqa?=
 =?us-ascii?Q?gC8BE3N6brXdRYWCZUSg5exQvjfHsIGqffgaVkpNj36A/Jx74PuGGGTY/Ukl?=
 =?us-ascii?Q?Lrf8H9ksRGLsTRhHK4pO8yI9gRdhwqkGYRRQOkgb9CX3rPfyK95dZf7NbIjY?=
 =?us-ascii?Q?wGB9TOnkfZsAxZjMK2ei+/TU1iyinSwkP/LNezglXJPK8oWQG1b1kTS+zxnv?=
 =?us-ascii?Q?P10DUOmhO/eqNhtcUGBJ3aAXcuLcIJLKLh/PdeEHS988aqyrok81OfCg91tN?=
 =?us-ascii?Q?jrsvL71e79Wg7bIj4GeA0DY+EyHGxE6S5/xl+9dgam2nTVQGmlqcYefS/QUO?=
 =?us-ascii?Q?vnqgoCSBaK+T4w7Igi7ytUaskE9CAHP3MiOd0MnzMzkcLZBKbvyWwOwdoRNq?=
 =?us-ascii?Q?VTil+/GemeMNOjgKH5C0socpbbqhXQh31JYFlcdNZLFB9zB1UvCIvdHghnPw?=
 =?us-ascii?Q?HGl0NK6M1Iilq/3EiBNKhYeVI7DVrGcUADfssDu0Al4rvrt52f0EhZAkCX5G?=
 =?us-ascii?Q?kkzb2gCsSQT7dc0o0qqiJkPVSStLUdAJXo/9sSe56nbD0JEiX0cuq7wk21jC?=
 =?us-ascii?Q?4mtQf8kmAErvQKQVMbzr7jheG3EU/1stLnSg//Y1B9H9jA8PEsHauMYiTuqu?=
 =?us-ascii?Q?caQx3sD6LzGCsvhwgSX1tMmETKYEeFiOa2/u1JXFEPXu4HOmrNkRuL4U1P7p?=
 =?us-ascii?Q?23sj7EOyytTbgdmyLb8eUbaRITZsW4Mo06jMXh8ff/l5S7Ys41eY8UIdyo+r?=
 =?us-ascii?Q?7akOYVcHe4aopy0aLp7zMVKJ9ivhkwLsW5ludVXlMd4h8q11+cnGLGr4ZYve?=
 =?us-ascii?Q?FJvxPdmM/OLvY49vxbw+IlHw6UcJmWX6vULg64mcXNZ0NADUAtliddfjMWnM?=
 =?us-ascii?Q?R0taGCticLAVB3heOj6FM5LbcwHjfXAvXUSMIMKScP9JzwC7JcbHTPg7snSp?=
 =?us-ascii?Q?xw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ddcb7c57-001d-4486-5c35-08dc8bc2ff7c
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2024 16:08:00.7281
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YqVyCQhMnRowdgfqlu8Re3BITXT3IDyzZ8r2Sm8GU2K90SPglpOxqNytDotyzoRYZxRq/UtefdCEBs37Oeu4uhzShVfH6w8L7mSSpzZe46c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4972
X-OriginatorOrg: intel.com

On Thu, Jun 13, 2024 at 05:51:25PM +0200, Maciej Fijalkowski wrote:
> On Wed, Jun 12, 2024 at 11:15:31AM +0200, Alexander Lobakin wrote:
> > From: Alexander Lobakin <aleksander.lobakin@intel.com>
> > Date: Wed, 12 Jun 2024 11:09:10 +0200
> > 
> > > From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> > > Date: Tue, 11 Jun 2024 16:21:27 +0200
> > 
> > [...]
> > 
> > >>>> diff --git a/drivers/net/ethernet/intel/ice/ice_xsk.c b/drivers/net/ethernet/intel/ice/ice_xsk.c
> > >>>> index 2015f66b0cf9..1bd4b054dd80 100644
> > >>>> --- a/drivers/net/ethernet/intel/ice/ice_xsk.c
> > >>>> +++ b/drivers/net/ethernet/intel/ice/ice_xsk.c
> > >>>> @@ -1048,6 +1048,10 @@ bool ice_xmit_zc(struct ice_tx_ring *xdp_ring)
> > >>>>  
> > >>>>  	ice_clean_xdp_irq_zc(xdp_ring);
> > >>>>  
> > >>>> +	if (!netif_carrier_ok(xdp_ring->vsi->netdev) ||
> > >>>> +	    !netif_running(xdp_ring->vsi->netdev))
> > 
> > Oh BTW, I noticed some time ago that netif_running() is less precise
> > than checking for %IFF_UP.
> > For example, in this piece (main netdev ifup function)[0],
> > netif_running() will start returning true *before* driver's .ndo_open()
> > is called, but %IFF_UP will be set only after .ndo_open() is done (with
> > no issues).
> 
> I see, thanks for bringing this up! I'd like to try this out. Tony sorry
> for the noise, but it seems I'll go with v4 and will decorate the
> mentioned statements with unlikely().
> 
> > That means, I'd check for %IFF_UP honestly (maybe even before checking
> > the carrier).
> 
> I wonder whether it is the ultimate check and two existing ones (that we
> are adding in this patch) could be dropped?

In netdev closing path [1], __LINK_STATE_START is cleared before IFF_UP.
What we were initially experiencing when netif_running() check wasn't in
place was that xsk was producing a bunch of Tx descs when device was being
brought down. So let me keep what we have here and add IFF_UP check on
top. Better be safe than sorry as the bug we were dealing with was pretty
nasty.

> 
> > 
> > [0] https://elixir.bootlin.com/linux/v6.10-rc3/source/net/core/dev.c#L1466

[1]: https://elixir.bootlin.com/linux/v6.10-rc3/source/net/core/dev.c#L1532

> > 
> > Thanks,
> > Olek

