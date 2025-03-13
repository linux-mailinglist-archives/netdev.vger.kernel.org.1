Return-Path: <netdev+bounces-174519-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 49763A5F12C
	for <lists+netdev@lfdr.de>; Thu, 13 Mar 2025 11:44:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2FC877A9F87
	for <lists+netdev@lfdr.de>; Thu, 13 Mar 2025 10:43:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECA581FBC87;
	Thu, 13 Mar 2025 10:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KY5yLNt3"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E20EE1EEA59
	for <netdev@vger.kernel.org>; Thu, 13 Mar 2025 10:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741862641; cv=fail; b=meWPPFeR1gDC6WnoFRF3r62Edn3jyi9ErO5B+RYepd1P14CKC77EDY2NZ5T4tJXPVkRsKedeSWKVtHhL5ZjDANdxhhxH1OFw0LyEpBMF56K6+mNctT8up4lcQLBDSkpTO+IjeQTmeNVVqOryBA14WKhgsmrMno01oHIPMB9gZv0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741862641; c=relaxed/simple;
	bh=htWLvfrnvZr+5Er9cLdPIwiT78UYFvXyfZcmO4rYbCs=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=TUcYph9+adtqlhNgnNeHyN+paRvzfzHwSi9Y7pDNUs7mnFO8s07myJJe4SMmBniwHDU1boqqYtfyLtni+ttZwU5cRl1f/OvF9eCqXrsdnQp8+sI3RtykYdehxfcpJb1t8mU6JX4MLdSUaEKTV9Ipvyhy5qurykRqp5CjJ0ippHA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KY5yLNt3; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741862640; x=1773398640;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=htWLvfrnvZr+5Er9cLdPIwiT78UYFvXyfZcmO4rYbCs=;
  b=KY5yLNt38872UwN2SQZNPwWtuxLryD7WU77tIMFy3G5UEgHjMNfZKtm3
   Yo3PhkS4UNE9g+v/Xghe2Z3TNB6LL1LHKe4mcTKdv1v/FxnZ4EouC+l5F
   MjIsS9aHcnVQHb1mSM9FvxqppTnNOq/yIgRzxzqhibUA4XQKTuPGD5LwQ
   uZ0p08ugNtPW9d5cB5ELUDJLA5A1KuNO7iCWMCpCwKOOYiUjDNFviGFD0
   TYkywYd0u6rVE2BZS860W7FjQA1MLcd0ErGgpTk6HLxU58ajbOUOxnORp
   Zg7N2ldcxQgaya4+ERle9deMy5aLWWDN++n+I20TtgLE4rk1M0w3lQGAn
   Q==;
X-CSE-ConnectionGUID: Sb6qh7ORRCKora9b897s3w==
X-CSE-MsgGUID: TkGJucxZTkyqZ3Aau9apaw==
X-IronPort-AV: E=McAfee;i="6700,10204,11371"; a="60513704"
X-IronPort-AV: E=Sophos;i="6.14,244,1736841600"; 
   d="scan'208";a="60513704"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2025 03:43:59 -0700
X-CSE-ConnectionGUID: BFaimkNkTu+1ZfbgkY3huw==
X-CSE-MsgGUID: uYdk3QT5TE2ZQAuf6qU7eQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,244,1736841600"; 
   d="scan'208";a="125987680"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Mar 2025 03:43:59 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 13 Mar 2025 03:43:58 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 13 Mar 2025 03:43:58 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.47) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 13 Mar 2025 03:43:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FFSbm6MXNagkF76FVa8BAlSKdB52pgnlZ5eS/Xakz11FpFXGlV74G8Hu2d6Ggf0m1/yuIBdW0P6gLhbrgJJQhKj6Je5HKsC4jyogSsI7FUz07ZS9LivkW2qyeY9qjQRuWdhyDSdMb+FllORMBtOwL29RQtTPa8+AvTrDR4i4E7X9BzzJkrYb0jJ3yReeFm1YjEmgnxCsMrbFsQ4CWfwqXlIZ6wccQt29mz0xZUtVTBc7wq3GlteXcO5aLd5CUmRlFuiwfBqxIoPYSNaLb/mOuT7cmTZrVg5snBxum4Tk7Mutq4P/Gk2qdpKnATlaK0acCDKVa3qnBZhjnjeWl/luYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yqSOlRfYW9c3hRlV3OVsghMN0a3nMvA0acA8TeBZ6CA=;
 b=UVS8tClTDms6DRpAymIXeCfAlMuxSKwyFUCHVKDYR8ExxxW4VmuTHNwuhuCUW5HKnFQeDyWNGAjhfSfkFSUI5qhKGVKO2P/kKOYl+791MbATUHogMcryVSwVCrGf+YiGO8ES0USjyO1Uh1khyM2SNgs3jw5ZFL3khboaoD6D+iO27k5qEWaiPrUVcJIZuTumez8FRUss8YhTh/wgYjQ6bDZh9ghX6pQcQdci1cYqpiRHAOobS+h9uRvrQbn3vt/mQfq3eTTAMo2uEPtxuo+RPfN6anurkjktRIiGZMSArojKs1obUacrB3BCgAL4gB1o12ehGyO6zo94gAtbDCqEIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8665.namprd11.prod.outlook.com (2603:10b6:8:1b8::6) by
 SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.28; Thu, 13 Mar
 2025 10:43:21 +0000
Received: from DS0PR11MB8665.namprd11.prod.outlook.com
 ([fe80::8e7e:4f8:f7e4:3955]) by DS0PR11MB8665.namprd11.prod.outlook.com
 ([fe80::8e7e:4f8:f7e4:3955%4]) with mapi id 15.20.8534.027; Thu, 13 Mar 2025
 10:43:21 +0000
Date: Thu, 13 Mar 2025 11:43:10 +0100
From: Michal Kubiak <michal.kubiak@intel.com>
To: Lorenzo Bianconi <lorenzo@kernel.org>
CC: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>,
	<netdev@vger.kernel.org>
Subject: Re: [PATCH net-next] net: airoha: Validate egress gdm port in
 airoha_ppe_foe_entry_prepare()
Message-ID: <Z9K2vujs6+yhiXXh@localhost.localdomain>
References: <20250312-airoha-flowtable-null-ptr-fix-v1-1-6363fab884d0@kernel.org>
 <Z9Ga7gx1u3JsOemE@localhost.localdomain>
 <Z9GgHZxkSqFCkwMg@lore-desk>
 <Z9GtKwAuEx+7HKjR@localhost.localdomain>
 <Z9G01zGCpbw1YHNs@lore-desk>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Z9G01zGCpbw1YHNs@lore-desk>
X-ClientProxiedBy: MI1P293CA0003.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:2::19) To DS0PR11MB8665.namprd11.prod.outlook.com
 (2603:10b6:8:1b8::6)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8665:EE_|SJ2PR11MB7573:EE_
X-MS-Office365-Filtering-Correlation-Id: 88bdd555-ae21-43f1-cf53-08dd621bdf82
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?yBj5PUIuB8nRn9aPsdRRaV65zfO+E6YiXuB2eSUkLIaryEHHD7XzKS/kN8uE?=
 =?us-ascii?Q?nXqNXCliF3EERCVsiCP8/AjjhMbgWv/Df4Kr7FECW97Axl/fsz5AjNaX2Zls?=
 =?us-ascii?Q?pQTgWRxzwmUjPaRn9YQqYTuPBVNngbcpRMF82677ZP7zfidBHcfDVmlUgg50?=
 =?us-ascii?Q?Zaxr94TYIiijqloaUCPnCGTMPOTA9nZQA4SwmIBHE7TPjv5CGH28H2bS4Q9w?=
 =?us-ascii?Q?C3lPsfZ7jgSnXKwn31ZV+mu0XTKMozLymUBDmu9NGo2d2l4miCHexMAnS/Dq?=
 =?us-ascii?Q?MR97Y12mRF5cd4Pu/ozw+0Wy/n75VPZHSRtJ1WT+00++pjH5AK5c0BA7Yo5g?=
 =?us-ascii?Q?zQHnWhp823KZos3kbJQaf8WY1RzrA1FJsKTegp7t87+TJ/sTYCSByCnXsZ3i?=
 =?us-ascii?Q?eE4/0tEtcWfSoJNCBerq1Z9+/wuW65l6NlYDo+FrQdb9Xv52ZS7K+hi98hMq?=
 =?us-ascii?Q?8aLMbt0g6URzlQYY9IwVi0NDdR/GBY1wreH8JItv8rf9xI8jueTycbhM8aPk?=
 =?us-ascii?Q?XXsKp6suknFat3HzerlO4FSh9pTm+VdmRZilIYUcf+PYoae65OEZLT0I9X3p?=
 =?us-ascii?Q?13ZBD/9GBSPu3hNSgCxBtkxzeorb4a+bc41FR721unlSn5FUw8cRJwVRcewH?=
 =?us-ascii?Q?Otvtf0h3g146C3AkfCMyj2hunnVHVEL14NGjUklNs6isFdeHFeIyAE+VhNGe?=
 =?us-ascii?Q?GzVd5X9uCQqT1wZgEc3m5/jn+NBype++ckmNb7hrVdTeRI0nWLIUC6uD2GPi?=
 =?us-ascii?Q?ApBxFIOp4UdGIT67uhVvuQvCkLfJYFbxObls45g8Dywz485/hgM0JUZHQ+h+?=
 =?us-ascii?Q?WjWu9WznOvP4XxsTgAIm7gy9J44gl/9O/gOYO1U/W6iMLWJT5O1nG2uREekW?=
 =?us-ascii?Q?aimEAinD6aWdPfF9jqlHUU5zLnie+bIXbdb5Zyeo/DHWGjWFaczNj1TKVg7w?=
 =?us-ascii?Q?XEHlhkJbUtAnQFrnQdiB+8X1mLNHVPtuUxsh3N6yWDNdaFBkeJHhngsDc7ee?=
 =?us-ascii?Q?Ep+S0FYs+GJ+r7OJGriMz+kKSXCTGtJuc33bEmhV7pX++5qP3HDSbClG92/w?=
 =?us-ascii?Q?5pQhPkl1kbA+9jdKhm1d2coXTinlNK5KhvBQGQDi7yBIIrt8JMWppaThXHA8?=
 =?us-ascii?Q?XIHaCLZ4K/4nbL0j4tLF7vNDVWp2Riy8gvCVyoNsJWfk5rvVmxyPitYU4/15?=
 =?us-ascii?Q?6IrbORvdzYXBP5VonsjUSyGkzWkun1GYOOFoXMiRHCP0uW08ZooBU2VFFjG+?=
 =?us-ascii?Q?csHr/8YNFqhlt5/YfVZuUBBZc4eSlxmsQtWm88A1DLLGC0oJEXv8chMlzQqJ?=
 =?us-ascii?Q?Bh6rWvzifTALM0gGoNHJIFNAIneqyieotNnzKuhYnn0ye+opkX7nmsDOIF3r?=
 =?us-ascii?Q?0+Sww19CTe3qeBmXmjAQ7kzerYJc?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8665.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SKMLIgz1Pb1pZ6y84F0U8VRPGZ0EfvYwn2fz47uxiBEalFFqP1DHqVB4MWtO?=
 =?us-ascii?Q?8qGJrVpTJoK71cy3jbOq4KiEi2aBCE7dIdrjMabkGVJayCRAOq5+nM6DO0HQ?=
 =?us-ascii?Q?Hs06ugodKa2qBInrOhHHTphWZT5z0tuyc+iHZQiCulBMGZluRXcsBn6gZlxR?=
 =?us-ascii?Q?eEXkkQxi0g7A58I5wUJr/9nmDXhw77iB5GqkmuPemS9zwGz3q7F3t6KRPaPN?=
 =?us-ascii?Q?TA/ufzUEvY1+1Tuj9Llic+WPhnjW97xquKS/Y+250e9qKl3SpNXaIMvEuLWh?=
 =?us-ascii?Q?l0sGT1+wr15Cfvl7gB/JIqOBwsyAkGduNGR0pSiV1FIZKdnR+azuICDitCfD?=
 =?us-ascii?Q?CsIjm1aTDPQME1pswsQzVTbP02XFVVH77fRy0HWc2heTqi+k3B0zlUP+f7oP?=
 =?us-ascii?Q?zxCM9Bo8YASfdRg8w5f5BDKpkSXwgZ88FB6D4B3Ew1mjp0mrBxtTMoo11Hq1?=
 =?us-ascii?Q?PTM78Reyj1HyG2Pd8WwzxTuTOZ9+khw/B6F9tci+oJFr4pMoLz7wRLhs96gG?=
 =?us-ascii?Q?WTtcMKAHB229MOySFeQJ1Q9X35vxVcmUp1TV2XvICxLX3iBij9YJ6ewhs34P?=
 =?us-ascii?Q?1z9ZG6139+W+cZEkLBwAyZBfNTRYDACcaZrHcTpT5E1aKOZgwfkSnjnQxUV5?=
 =?us-ascii?Q?rPA8g+XzBMzrDqWXotucfs4rDjVOvIYt4yTqekHEhk4GmINMsgGraLbTx5dg?=
 =?us-ascii?Q?g4ny5dNwzwnN050GaXrx3/mRBZfdg56T61I22hFJ9iY9SZa184baNU/N8gE2?=
 =?us-ascii?Q?DZpWpz+hLX68OOMbSnyODPD1PEztOWnh1LpBoNInm+98R5HYj7iv8RDnhhfG?=
 =?us-ascii?Q?EOYsNf8rn6UNrltJ0b28fvz3P6SDNzEOmEa8WBHLAbqFphK7tZaRr+ngJApl?=
 =?us-ascii?Q?ArBSLUcZTcl5lCHA5xKhscA+z+G79BsyYX7z6XrdjtJRIuD/J3fkDGANkw+6?=
 =?us-ascii?Q?oPbP4bcVfKqeC2LMTGluOjytTaqMenoXRmM5j+hwxLpUQOX7muIES3Mq8t2A?=
 =?us-ascii?Q?vucqpuSF5mf8m8/l215Qpn2LLGcn0GvNrenyQdKm43osdzvJuM1+Yax4k0NB?=
 =?us-ascii?Q?/uxbJVljFQELecblgVyFFm3+QpaOENebi2nTrSNtEGeubMJ900x8labXFOcP?=
 =?us-ascii?Q?L7q7qav0kwoCCov9yW2oyUXZ6chZ7RbT2z/yS+foHoSViG52AflV/gS+BOCD?=
 =?us-ascii?Q?4GtRGOjrIAZFhMnxSzvt90bXuKaFI5hNN9cc/Y0rZHFTEsZqfQqqhhn8NPH5?=
 =?us-ascii?Q?0/Y/kdmntL4VgE59qxa5A7oSuLuRhR1DcSWf+nSdHB5wOkdxQFxZMUDGBVYK?=
 =?us-ascii?Q?TG8LP544VHYi4NBtar0MV/tuzboHCIlcq0vbm1xEnqoMbuL5J59KMF9MGdPs?=
 =?us-ascii?Q?bHrmDfYUg5jqGf5u3KDiMVkDR8hsdbcCoFKOssqw1RKHqhmwwEMbJwVLC44Q?=
 =?us-ascii?Q?8J431B+w9nR1J8kLcIWh5NS6TUgwVIzNkKbyByMTiWI+c53UcL83UbrT1tQC?=
 =?us-ascii?Q?CUUvGlg+g9qd/Yn/PipwRPbkXdanrjJMaRIw69DLIj3KSwp4u+I5FR7wNjMv?=
 =?us-ascii?Q?8g2NmGBhAzptHreWTZuVfpiLftK44r8jNz+PVyXR0/LHHttCbsavoIkBRtP0?=
 =?us-ascii?Q?4g=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 88bdd555-ae21-43f1-cf53-08dd621bdf82
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8665.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2025 10:43:21.1372
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q6uvf0WQR+k8QjGXDnRHWB5+oOI+4VCPet0+pQ9hPB4erIEuzjfANLOm+Haog9SpIFOB0cUv8PhGiUWpnzL3Xg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7573
X-OriginatorOrg: intel.com

On Wed, Mar 12, 2025 at 05:22:47PM +0100, Lorenzo Bianconi wrote:
> > On Wed, Mar 12, 2025 at 03:54:21PM +0100, Lorenzo Bianconi wrote:
> > > > On Wed, Mar 12, 2025 at 12:31:46PM +0100, Lorenzo Bianconi wrote:
> > > > > The system occasionally crashes dereferencing a NULL pointer when it is
> > > > > forwarding constant, high load bidirectional traffic.

[...]

> > 
> > > 
> > > > 
> > > > > +		if (!eth->ports[i])
> > > > > +			continue;
> > > > 
> > > > Isn't this NULL check redundant?
> > > > In the second check you compare the table element to a real pointer.
> > > 
> > > Can netdev_priv() be NULL? If not, I guess we can remove this check.
> > 
> > I guess it shouldn't be NULL since "devm_alloc_etherdev_mqs()" was
> > called, but I'm not 100% sure if there are any special cases for the "airoha"
> > driver. Maybe in such cases it would be better to check for the netdev_priv?
> > Anyway, such checks seem a bit too defensive to me.
> 
> the dev pointer can be allocated even outside of airoha_eth driver.
> This pointer is provided by the flowtable.
> I guess we can drop the NULL pointer check above, and do something like:
> 
> 	if (port && eth->ports[i] == port)
> 		return 0;
> 
> what do you think?
> 
> Regards,
> Lorenzo
> 

I think if there's a risk that 'port' can be NULL, it looks like a
reasonable solution and I'm OK with that.

Thanks,
Michal


