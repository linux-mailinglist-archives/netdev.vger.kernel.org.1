Return-Path: <netdev+bounces-156157-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C024A05292
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 06:22:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 798211887BC5
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 05:22:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B9951990AE;
	Wed,  8 Jan 2025 05:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nboOtz8W"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 230E570838;
	Wed,  8 Jan 2025 05:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736313743; cv=fail; b=P7waObvB7odReoDL6v4IK5VS0XVHK2g3V/aihBp3bTkzV98ePjtw8zuFMFA/1kyf0mMfjSn+PyKNmtTBiLjEZmvRBkfttY0+pPxH/svBcFOZHiQGSdaoicqRkxFvxLsQhmX3O1Nf2x+H4TEIO0u0llQfpmf+RF6BFo6Oz3+ELsA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736313743; c=relaxed/simple;
	bh=bRuhc0r3YmnsqEnv3WJGxMkTO0kkKfu7jcwAd0cIdgc=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=lXRg4pqKFytC4a0VkEowXv2Ka2A7LYFA2IAP9d37wLPBZNOisWq6o6QhRTdKGGivGSZWPbDKLQnTf1yGeIwEPTA0PIDOLrRACmib3h+5ILEMS6xKIsbscQQUnttLFHUzKOte23GTTY9EjSS3T3e1fOPz68JJHCowXpQBAOWuHEg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nboOtz8W; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736313741; x=1767849741;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=bRuhc0r3YmnsqEnv3WJGxMkTO0kkKfu7jcwAd0cIdgc=;
  b=nboOtz8WjRb75qY3TX0bZ0QIpXp1erbD2o+Hvai7YsUB+kiUFdzB4NOh
   7T9X8lhiBQsTJ4B95NUuYhtl5AnhckfNv6/8+SXVVN3kWDFe8PPkzMfuw
   TLWgq7te7M94ja0KplWbVDnfHbDB6YHHNMsxGtF76kE/2VqcGbdrYEi8F
   ptD9BbuFogGxj5X85pI7n5WQKqjUCSlPUKaOVc8dfrQi5n5UXXX6ZivsG
   NF2os5zTy+/8zGUg84DdlBAiZssaMsIHCqCQh751XxquRpF/3GoN37gR2
   WAcvMb9TwuX7I1IQNQSq35rICOWSsoH7mWh0nkiKMEVCtGWPXFMzYs0C9
   g==;
X-CSE-ConnectionGUID: toE6b3zVRcCy+/GMbTu+Ug==
X-CSE-MsgGUID: pBwNQqSZQrWbb0VJchEP8w==
X-IronPort-AV: E=McAfee;i="6700,10204,11308"; a="35757039"
X-IronPort-AV: E=Sophos;i="6.12,297,1728975600"; 
   d="scan'208";a="35757039"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2025 21:20:10 -0800
X-CSE-ConnectionGUID: XJSppMChRgqk12qjcspU7g==
X-CSE-MsgGUID: VjkW/xbFSeaOywAmVclxig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,297,1728975600"; 
   d="scan'208";a="102799894"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 07 Jan 2025 21:20:09 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 7 Jan 2025 21:20:08 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Tue, 7 Jan 2025 21:20:08 -0800
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.40) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 7 Jan 2025 21:20:08 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xheVDKYu1v3KUhrBUSEjhpZtBqz96953Xm2S0DtoRAqmKLnjXDz1W9etcql6NOA6VSAOtU60FoNvH60PQewVir58Nul+F5eq+NdbSzpdxlNN+gD6JF2BGrOyxaekDid2nm8el+P8Ffj6Oa9sKAD1Rohfr2vw1rmL69HukUoREnJLdKh7poYA2TgjFfej/1r/3oER2vyZCMOGb3e+GyW+nZWgnYIgVPcidLwYdtTy0W0Hipii6wkWFSIA39AQ7muroFP4mV5zrX26S9C5k+Fazv9+JczlrNVCMDzT4ez1cTG5GWZQa6HMRSs7W5TwCaPMVk7/u4+VZbNtoB/vgXznAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pyWHMMtqvtuYrez7YuHjMSQ+ZWVVR0hoH/pt2rewlkE=;
 b=UwXjlvmZ3iGzatuKTUSZU2uxBF9rQ9I4qhj+SdfJ+S+CzHZjKI5kCPRGlH6mI97vUogEzpq1LHdKNxPqEgeSyOfeepsJdUWG5Prwv8pPKPSZB536znfbvVHwJQ8nvVERs2m8xuae6FlLzhJaAbpSUPXyOzVpvdnEBS6EeY2fW6D2lBwXBR9mxEKBDQZXrqX6NE0HJ9eOWnitUMJ4r3jiptyNJbl3CsWQOKE47mC6wz8tzp4C+j6haJRyQWP0kYVeZaIS7SIWprzstiu220AuuezdnBz4lsN/571W0PBdk+VTZcRV59ayCHM1rDivhcC6+peo84FfunntqeYC/r9YrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DS7PR11MB5992.namprd11.prod.outlook.com (2603:10b6:8:73::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.11; Wed, 8 Jan
 2025 05:19:53 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.8314.015; Wed, 8 Jan 2025
 05:19:52 +0000
Date: Tue, 7 Jan 2025 21:19:50 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: <alejandro.lucero-palau@amd.com>, <linux-cxl@vger.kernel.org>,
	<netdev@vger.kernel.org>, <dan.j.williams@intel.com>,
	<martin.habets@xilinx.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: Re: [PATCH v8 05/27] cxl: move pci generic code
Message-ID: <677e0af67788e_2aff429448@dwillia2-xfh.jf.intel.com.notmuch>
References: <20241216161042.42108-1-alejandro.lucero-palau@amd.com>
 <20241216161042.42108-6-alejandro.lucero-palau@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241216161042.42108-6-alejandro.lucero-palau@amd.com>
X-ClientProxiedBy: MW4P223CA0008.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:303:80::13) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DS7PR11MB5992:EE_
X-MS-Office365-Filtering-Correlation-Id: 195713d3-e230-4927-3475-08dd2fa414e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024|921020;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?TruXBIgDRdcc34aUinnvFAbsSmiLsrEeDBGp14lxq3kpTAdMCx202hKQAiHI?=
 =?us-ascii?Q?TOkUCO6MLBDwryRp5MO/OQDAyaC+1fe7aYZdcU8vR8RTgJksmnwQ7RslJG+M?=
 =?us-ascii?Q?TlZhXuf6Iv+fY2/JIKKfyGK4qUD02dYBFPw2nrr7bzUyzFVJCKKDfeSXH0Ur?=
 =?us-ascii?Q?iafN643/Dn2T9g5R8dG9EF6Xa4oQzSw6wGOT9W2wfz/gzaeQADZ52ssaNc8f?=
 =?us-ascii?Q?GpxJHV4WJncPXMyY71uZFEViAQzmEl70DPCxaGSO7b+meolJBbOvJ+su55/5?=
 =?us-ascii?Q?77WBipsJrlGUbCdkmYYdoXObP3kWU4QeO3DNYduzlp9+YGOhAOLnL+AZ7+FB?=
 =?us-ascii?Q?NjD0f/ynZeu4efBgWz58TTfAIn6LzE/+OVZtskyso/anIe6Cs+RjOUEToWbW?=
 =?us-ascii?Q?mbN0YjbNr725+AC7mZNizyV13Q2Ww0DML2K0+2N7hA9xjv3pnsiTQR+7qCCd?=
 =?us-ascii?Q?PmtGU3PlQXEyMBxjyGYi7SR+dbd3SaQFzqcjpgfkS5+47ZJgtsUdS5/ndIYa?=
 =?us-ascii?Q?Bk7+QUBo2Tz3k7/biSkX8JkuXUeU0m8QdAFSDnoJ/JQ6kcoyeYpGxcbVil3k?=
 =?us-ascii?Q?lSJ/urxr6ch5hQpuLG2KX1OvETf1bPdRIA2Id1bKxxEFZCwicwNShPWePUc8?=
 =?us-ascii?Q?OCTISA6ZAwacCCpISpyyXRQcBxe7cNMSWp/DYOtIz9vGnv2qddFcJVc5QPkP?=
 =?us-ascii?Q?MeLqQoGRNZPUvhmp5SeyefmRlc1VzKYErv5fgPcWeUSY8kk26whYDLGVEBf5?=
 =?us-ascii?Q?5ILTnp8J3qaDfS+xyq0aka6xSlbKRv2Gn51FgIAFSTqr/JTU/fraIDYWSAT7?=
 =?us-ascii?Q?sjOmidqDUh33HAOGJ2WJIuFRzTcmSnD4HRghNFqiUT/XiMRGojeA0VIoGY0+?=
 =?us-ascii?Q?4ZYIpMT7UTk5hjD9hLCXuFpOid8YH8HmEIGYOv8cCRc5vQCauQbnIej3uwBu?=
 =?us-ascii?Q?Rqq/SClimsBpnjUrI3VA2JOEd54RuZ/+2+q/gpwn5jmYtTgu2tQbMXFY2t1u?=
 =?us-ascii?Q?oPB5Xk6Wuw+xexbES2vz5jyUO7NIvFuMG33DKeZ2F3oyVnA4TWo+mhVazUJZ?=
 =?us-ascii?Q?LSvRt8cb59yhh72ezP5or7TpSmQ44m2lU1YvoWOiuQwTNPI2YPbbHSyxZbwM?=
 =?us-ascii?Q?nEjQC8NC3Hbc2AUIfgC5zgNIDyKwsBY+Ehf13ZZTdPCJ9nQrJ8OLfNbjLx2U?=
 =?us-ascii?Q?7HJF0i6yvwlMv5AppajjE9FAW+C23QzNYAifLqXFneZYmgdwAhfXDz6mVSVa?=
 =?us-ascii?Q?WZo8vjObMdhAPLL2z2h6PDnfUZ6QVslsAgR5LfljIIhKEbdjojtC4ICoCKOt?=
 =?us-ascii?Q?v93EDkDSvsTJ60zaDRpKxMBGX8IiKBRecSaU+tIIKwzL/Plwnkxfkw2siXNY?=
 =?us-ascii?Q?tZpdHTBy33poCXlLe+ZKW/91SxBNWJQ8uQKiq/3o0Q68EZsRjcMpiV5M/tnj?=
 =?us-ascii?Q?bXKZP6VhwqY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ml3WXLoxc+KXKcN1sxgROPjAXJ5UmMMPV/URfqenBDq8RCrfPGfKsqe7b/Xn?=
 =?us-ascii?Q?+oqpStdLnYygy32WffUTAJHCaxKMjdSOSCqn/HvvxE9YV9+4wprPKUfZNLue?=
 =?us-ascii?Q?TWqv/elBd4fmu6XoBt/nX8vfbsYMywoUFxit9B1XHCY+BKA2rlLE5i2IkA3k?=
 =?us-ascii?Q?Y3QxvT9O28XnU9JikgPF21J2rqXJdrEuv3kfZbsCYt+4qR/NCta/mf2v+Hbl?=
 =?us-ascii?Q?EV5e91Cafuip25GNrsloao0Hi+G4wn6DGUfkYQtrDjkeY1J+RCmnnUQPXymD?=
 =?us-ascii?Q?WtJ+9yftzI0hBK5a5080KTUdA/zlD4Aqhrn74Yf4sGgHt3eGlyiEwFNrlkv3?=
 =?us-ascii?Q?CyQRohxNgio1DvmLOa0Qaxkjhkn3WUxICAdgnS2O57vJxQ7qYg5dSzZMY3jC?=
 =?us-ascii?Q?hCIecCIUzce/Mqd0gxPhX7OGZtTcJEvYismcxeWWB1vl/OFP4+hnDW/uTG36?=
 =?us-ascii?Q?gaeakFuC0Qw1Wqo7JpcBaWHKqSWvulUU8Dz3bUaIEWa9ukEWrC2PRBo6AbGG?=
 =?us-ascii?Q?abbtasu/Cj5TctLqoWK/QNxR4jiDFeleNLJ1gxgTPkm4gcqj0BljjdmBjdAk?=
 =?us-ascii?Q?B5dkZiqQU1YM47LA5iD2xzqQvVmEC+5vRVVZL6AywS2g3NvrUhXpUPWaNSP5?=
 =?us-ascii?Q?tQudlRP/KiHuU/GPYD0uwS+GhiGWRS/DjgDOjQOjMdJqjlKjMHZxmqwfZ87a?=
 =?us-ascii?Q?ON/Kx5aBg19Q4WLoC4zG7TmljbP9oyouvVLHh3rcO5CA4u6OX06SaiY8/oq1?=
 =?us-ascii?Q?u02ukjOZL1v+NYzSPr1TRa5ObvnRjml0LPCga5ldrTD+fWthKcphWXQgfqrP?=
 =?us-ascii?Q?fb5hO16d89NqSTS8OrVe+8pukvvFGFmU/rbjKWN3Br8jFjGOxdhR9F2WKTX7?=
 =?us-ascii?Q?Fzo0DFM02Yg90D5/F/5vSXJZ86nVx54tD/dRdiwElA4CDj5+aWI1zfZd9n4q?=
 =?us-ascii?Q?Ogzc2/8zv6zoqdYSOMdg+lhwy35MZokj3bXzGmGLXR4NQUoAva0336ulYoAB?=
 =?us-ascii?Q?YrrmHd5aYSVgsOqmfkKPGcQv4GUtuWvrfN7zn/oF2QV8sL2k4dLDcHZVttMP?=
 =?us-ascii?Q?4VSVGLNsHhWcYRdQVCrpuqUtVkR740KOFB5ndD2r866goJkiQ2oukS2d2g3R?=
 =?us-ascii?Q?wj2XxpDSeL1R9yOyUTlxdLk+QA7YavUtV+kGOfSiolhfC9hXbLA97MN/QtrB?=
 =?us-ascii?Q?0SCFgumX+w4+uObtO9oAzRjnNu2R8toON4pfK5HXkl27h9UCAVTFjvDr1H/u?=
 =?us-ascii?Q?bN22ZCJqNTt8in2JUY6h4dCYAyOu3qiZ1s6PqIEmJ3MxVusCGTkQGQEhfgPZ?=
 =?us-ascii?Q?rKVB75JY0Kbuj30J7jIJS9nW69dFUPPeerTLlqe2wb2qQBZ1FYN3Vl/kVRhy?=
 =?us-ascii?Q?6e9Xk+LG7ilxP+I3u5GFaen5ZKcGZgCs6GlL//n1hoQC4BRA3ogno/VkIiNg?=
 =?us-ascii?Q?7UrXDyOSrKGTOnNcA8pvQcvxrKW5LRMTqZ2UZFysjBYQfTvEEWnuJfndEDmr?=
 =?us-ascii?Q?/l/zt1k4HrxCr9rr7l6Hq69Zh3pnO4lfZZaNb0urZjXPk3zC+M19y7t6xpWn?=
 =?us-ascii?Q?8aPYoJx+17GKeW9+d2OgUDyFVvxMUsw2BiEEiH22DI4WQZU6LBYLUSS9I2NC?=
 =?us-ascii?Q?CA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 195713d3-e230-4927-3475-08dd2fa414e4
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2025 05:19:52.9291
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WnYIR0n9MwOnLxzVMOoDKyU/I+zX+ZWjCVzU1mKZw8apWCF68KfpHKd0Sea+OUJfyF9qsujSSETdqkInOj5P1uG4x0Y/HcPTpIB9bOvd6Nc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB5992
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

This is the patch that causes the cxl-test build error...

> ---
>  drivers/cxl/core/pci.c | 62 ++++++++++++++++++++++++++++++++++++
>  drivers/cxl/cxlpci.h   |  3 ++
>  drivers/cxl/pci.c      | 71 ------------------------------------------
>  3 files changed, 65 insertions(+), 71 deletions(-)
> 
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index bc098b2ce55d..3cca3ae438cd 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -1034,6 +1034,68 @@ bool cxl_endpoint_decoder_reset_detected(struct cxl_port *port)
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
> +
> +static int cxl_rcrb_get_comp_regs(struct pci_dev *pdev,
> +				  struct cxl_register_map *map)
> +{
> +	struct cxl_port *port;
> +	struct cxl_dport *dport;
> +	resource_size_t component_reg_phys;
> +
> +	*map = (struct cxl_register_map) {
> +		.host = &pdev->dev,
> +		.resource = CXL_RESOURCE_NONE,
> +	};
> +
> +	port = cxl_pci_find_port(pdev, &dport);
> +	if (!port)
> +		return -EPROBE_DEFER;
> +
> +	component_reg_phys = cxl_rcd_component_reg_phys(&pdev->dev, dport);

...and it is in part due to failing to notice that
cxl_rcd_component_reg_phys() no longer needs to be exported once
cxl_pci_setup_regs() move to the core. Please make sure there are not
other occurrences of EXPORT_SYMBOL() cleanups that can be done in this
series.

Again, as I do not want to inflict cxl-test and --wrap= debugging on
folks, here is an incremental fixup/cleanup below.

Note how I fixed up the is_cxl_restricted() comment to make it relevant
for the accelerator case. Please don't leave stale comments around when
moving code.

Also note renaming the header guard to something more appropriate for
include/cxl/pci.h. That should be folded back to patch1.

-- 8< --
diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
index 800466f96a68..3b33470b8cbc 100644
--- a/drivers/cxl/core/core.h
+++ b/drivers/cxl/core/core.h
@@ -107,6 +107,8 @@ enum cxl_poison_trace_type {
 	CXL_POISON_TRACE_CLEAR,
 };
 
+resource_size_t cxl_rcd_component_reg_phys(struct device *dev,
+					   struct cxl_dport *dport);
 long cxl_pci_get_latency(struct pci_dev *pdev);
 int cxl_pci_get_bandwidth(struct pci_dev *pdev, struct access_coordinate *c);
 int cxl_update_hmat_access_coordinates(int nid, struct cxl_region *cxlr,
diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index aaea29bff0f1..afa3bd872dc0 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -1034,16 +1034,6 @@ bool cxl_endpoint_decoder_reset_detected(struct cxl_port *port)
 }
 EXPORT_SYMBOL_NS_GPL(cxl_endpoint_decoder_reset_detected, "CXL");
 
-/*
- * Assume that any RCIEP that emits the CXL memory expander class code
- * is an RCD
- */
-bool is_cxl_restricted(struct pci_dev *pdev)
-{
-	return pci_pcie_type(pdev) == PCI_EXP_TYPE_RC_END;
-}
-EXPORT_SYMBOL_NS_GPL(is_cxl_restricted, "CXL");
-
 static int cxl_rcrb_get_comp_regs(struct pci_dev *pdev,
 				  struct cxl_register_map *map,
 				  struct cxl_dport *dport)
diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
index 6432a784f08b..0a218385c480 100644
--- a/drivers/cxl/core/regs.c
+++ b/drivers/cxl/core/regs.c
@@ -633,4 +633,3 @@ resource_size_t cxl_rcd_component_reg_phys(struct device *dev,
 		return CXL_RESOURCE_NONE;
 	return __rcrb_to_component(dev, &dport->rcrb, CXL_RCRB_UPSTREAM);
 }
-EXPORT_SYMBOL_NS_GPL(cxl_rcd_component_reg_phys, "CXL");
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 22e787748d79..8f241d87127a 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -311,8 +311,6 @@ int cxl_find_regblock(struct pci_dev *pdev, enum cxl_regloc_type type,
 		      struct cxl_register_map *map);
 int cxl_setup_regs(struct cxl_register_map *map, unsigned long *caps);
 struct cxl_dport;
-resource_size_t cxl_rcd_component_reg_phys(struct device *dev,
-					   struct cxl_dport *dport);
 int cxl_dport_map_rcd_linkcap(struct pci_dev *pdev, struct cxl_dport *dport);
 
 #define CXL_RESOURCE_NONE ((resource_size_t) -1)
diff --git a/include/cxl/pci.h b/include/cxl/pci.h
index ad63560caa2c..efed17bc9274 100644
--- a/include/cxl/pci.h
+++ b/include/cxl/pci.h
@@ -1,8 +1,21 @@
 /* SPDX-License-Identifier: GPL-2.0-only */
 /* Copyright(c) 2020 Intel Corporation. All rights reserved. */
 
-#ifndef __CXL_ACCEL_PCI_H
-#define __CXL_ACCEL_PCI_H
+#ifndef __LINUX_CXL_PCI_H__
+#define __LINUX_CXL_PCI_H__
+
+#include <linux/pci.h>
+
+/*
+ * Assume that the caller has already validated that @pdev has CXL
+ * capabilities, any RCIEp with CXL capabilities is treated as a
+ * Restricted CXL Device (RCD) and finds upstream port and endpoint
+ * registers in a Root Complex Register Block (RCRB)
+ */
+static inline bool is_cxl_restricted(struct pci_dev *pdev)
+{
+	return pci_pcie_type(pdev) == PCI_EXP_TYPE_RC_END;
+}
 
 /* CXL 2.0 8.1.3: PCIe DVSEC for CXL Device */
 #define CXL_DVSEC_PCIE_DEVICE					0
diff --git a/tools/testing/cxl/Kbuild b/tools/testing/cxl/Kbuild
index b1256fee3567..e20d0e767574 100644
--- a/tools/testing/cxl/Kbuild
+++ b/tools/testing/cxl/Kbuild
@@ -12,7 +12,6 @@ ldflags-y += --wrap=cxl_await_media_ready
 ldflags-y += --wrap=cxl_hdm_decode_init
 ldflags-y += --wrap=cxl_dvsec_rr_decode
 ldflags-y += --wrap=devm_cxl_add_rch_dport
-ldflags-y += --wrap=cxl_rcd_component_reg_phys
 ldflags-y += --wrap=cxl_endpoint_parse_cdat
 ldflags-y += --wrap=cxl_dport_init_ras_reporting
 
diff --git a/tools/testing/cxl/test/mock.c b/tools/testing/cxl/test/mock.c
index 450c7566c33f..af7a5ae09ef8 100644
--- a/tools/testing/cxl/test/mock.c
+++ b/tools/testing/cxl/test/mock.c
@@ -268,23 +268,6 @@ struct cxl_dport *__wrap_devm_cxl_add_rch_dport(struct cxl_port *port,
 }
 EXPORT_SYMBOL_NS_GPL(__wrap_devm_cxl_add_rch_dport, "CXL");
 
-resource_size_t __wrap_cxl_rcd_component_reg_phys(struct device *dev,
-						  struct cxl_dport *dport)
-{
-	int index;
-	resource_size_t component_reg_phys;
-	struct cxl_mock_ops *ops = get_cxl_mock_ops(&index);
-
-	if (ops && ops->is_mock_port(dev))
-		component_reg_phys = CXL_RESOURCE_NONE;
-	else
-		component_reg_phys = cxl_rcd_component_reg_phys(dev, dport);
-	put_cxl_mock_ops(index);
-
-	return component_reg_phys;
-}
-EXPORT_SYMBOL_NS_GPL(__wrap_cxl_rcd_component_reg_phys, "CXL");
-
 void __wrap_cxl_endpoint_parse_cdat(struct cxl_port *port)
 {
 	int index;

