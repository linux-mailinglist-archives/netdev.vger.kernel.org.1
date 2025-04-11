Return-Path: <netdev+bounces-181554-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 742E4A85781
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 11:10:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 458773B708F
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 09:09:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 292121FDE31;
	Fri, 11 Apr 2025 09:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="avzjJddX"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ED2828FFF4;
	Fri, 11 Apr 2025 09:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744362348; cv=fail; b=aQEc3GwgM6X5iJ/WQdEgqBfd/DZLJGrCQKtWz6SLcuKVtv2t92UP11qE6T1yFHao6edzEp2J7mlfPj+xaxK8I6xFk/6ItoVsJRbffRs9ymACJVq1gqOchH3Yr3GHDzVS/bD5ktr2rI8jJRH7WOcOnMpRh6xXFgCl5BaNiVpTkIo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744362348; c=relaxed/simple;
	bh=RbFsGsTQlAg1599B6eECteZi1W1Hsdx5x190vdsdYvg=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=PMLp9B4nQO1VSqcDG1EfyLSeafHRi6U57IeUUCX4WrydymfWsyeJx+zGp67cvUyl9GDFZX7EvUbRhRcF/t/VwyJgmzMMDyYoSR7F7ufgjPZAkslUWH5PNZMLk0HzSmGnZMhsT3wkYq8ZgwJaXCiA5OCQQRULaAZXi/0bQGMR7oo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=avzjJddX; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744362347; x=1775898347;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=RbFsGsTQlAg1599B6eECteZi1W1Hsdx5x190vdsdYvg=;
  b=avzjJddXJ0IwW3Ry/hxDif4D+SbicyuGWOf+1NNsRCUhrgqBpReeWJkR
   O60hREGUrbSAzWlFRIQp4qmDnsGXg+FzxOdo/B2n6tUeQSwHrEpPcMAsQ
   ixQjhVCpKD2EqbT/bPLP1PqYYDtAhuwofrzIbOYjImZcBZ63QygEzpW8M
   AiJpFU/QK9m7Dnyin7B9rpcOeKjnlVUxJx3eC2lRmXtIxMWGjXucXgytY
   zF5K0/j3fnsqGnunMiICC76Pjn9oybb7cR3n0Rzjh+i1l9lPMAaGh/4xY
   0GmC9U6LrIQKOvba+7sG4cYnbBc6mx4Gbe0pHfPTNUzCWHeyy8Hxzey+W
   g==;
X-CSE-ConnectionGUID: G31xeb7eSRGu0aUagA4XyQ==
X-CSE-MsgGUID: Sb7d+DCNRGak1EaMPL7d9Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11400"; a="45999434"
X-IronPort-AV: E=Sophos;i="6.15,203,1739865600"; 
   d="scan'208";a="45999434"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2025 02:05:46 -0700
X-CSE-ConnectionGUID: vnKIN7e5SzqfiFlS/iS8iQ==
X-CSE-MsgGUID: SJua/oaASpGuOmf49rxJiA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,203,1739865600"; 
   d="scan'208";a="134251032"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2025 02:05:46 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Fri, 11 Apr 2025 02:05:45 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Fri, 11 Apr 2025 02:05:45 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.48) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 11 Apr 2025 02:05:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PirpofhO28fk0GpfELnJZyYpnD4tNJessvHy/Los7i8kqOV7B57g481utDDa2px57TPuh1LF2JCmPc6qxyX7ofTUl1csg/paFtPpaCfMSnP6F8udxzBdBf7eOsCMZfcsElURa/a7bAnltcVMq9zMpf97yIeaaSV/j9grjoPG+U5a0f8hhpdDmpH8ANBmjN6+iwneOSFivV421dTyBuDCFYqFNOgrYijrEOv9dPEwlZb0w7cH7HIGkzycDdif5AtLeawrGsnyHg/YTc26sCjNMXRBXhKplAsRFnm7RM8i2ClVHj8sJnY+aD+WRjJse6YpBgfbjl41q0WC0IAp96AEyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QtU3+nDww7EXzNLe2PIrqad6enxtL5WdMp/00jw6HTE=;
 b=awvNnVh1tjP/a6JXGVB/vR9+Q7EfnmCVl95qF+GZmUqCOrPYmdd6yzinFbh1uL/qxxa64AyUsTFvk9+bjjBDujC8v4MLRxJeYa3SxBudkYMy6pVTqOLSlWFbW5Hfc0kG+VB4zHD9WNNWsoHdYo9AMe1CAc9rzwc/J212jduvcQJvaflgIiZ7TLN+8oG9VPdce9In59HuZGBiPZGVKgIeer4SB325hjyRxJS6TDSj17OE9kUPRjhhrhN7tw9qjOnZdFspaH7XT5qvURDYsIzk4EvMyrdE2Uo29rOeUDusRBVX92YyGz3i6cRm0qsBBNYHq8kC5YBDf6KmXrYJBG1B8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB7540.namprd11.prod.outlook.com (2603:10b6:806:340::7)
 by MN2PR11MB4615.namprd11.prod.outlook.com (2603:10b6:208:263::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.27; Fri, 11 Apr
 2025 09:05:14 +0000
Received: from SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::399f:ff7c:adb2:8d29]) by SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::399f:ff7c:adb2:8d29%4]) with mapi id 15.20.8606.029; Fri, 11 Apr 2025
 09:05:14 +0000
Date: Fri, 11 Apr 2025 11:05:02 +0200
From: Larysa Zaremba <larysa.zaremba@intel.com>
To: Raju Rangoju <Raju.Rangoju@amd.com>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <Shyam-sundar.S-k@amd.com>
Subject: Re: [PATCH net-next 2/5] amd-xgbe: reorganize the xgbe_pci_probe()
 code path
Message-ID: <Z_jbPkpeDE0iGjD1@soc-5CG4396X81.clients.intel.com>
References: <20250408182001.4072954-1-Raju.Rangoju@amd.com>
 <20250408182001.4072954-3-Raju.Rangoju@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250408182001.4072954-3-Raju.Rangoju@amd.com>
X-ClientProxiedBy: PR3P250CA0015.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:102:57::20) To SN7PR11MB7540.namprd11.prod.outlook.com
 (2603:10b6:806:340::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB7540:EE_|MN2PR11MB4615:EE_
X-MS-Office365-Filtering-Correlation-Id: dd3fad12-2c3e-477b-9a23-08dd78d7f8d1
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|10070799003|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?R23LMJcadRUVxrb9VSPUZdaIxXepRScgJSecOYFaKN7CbjnnfESC+93JvNtl?=
 =?us-ascii?Q?gpJiKT0JjmA3648r/cN4aDMjYADeJs43nca43x+AUeiprIFs9sHCG+XjG4FY?=
 =?us-ascii?Q?sJhQtpM3M3udObk0nZ4lF7kMQoDIZ6+PGtK6DEg4z06SvXtYhDchj2LLVcrL?=
 =?us-ascii?Q?BpHftm1FqNvvIrZCOKeIrVPkV2lj3qOf4OOOguQf9h4YfbDqvXDB1ulFzTNW?=
 =?us-ascii?Q?hG+mZrjqY+YapFQ7qzGTYL6Np+2Up4Szd+nfL2MWbo/2ZIUTEyxpeFiQ5qOc?=
 =?us-ascii?Q?6aeA03518SkRz6br29MR2uJ6HWenZl+TUd/jKQ9uy7Ka44nBfRXXRmN3kSXS?=
 =?us-ascii?Q?zfJ+N2xioYIptIpXItL7iUOAyMzWGcQaOnIWH55DGXxUdIk5OZ7XKIFcs6ex?=
 =?us-ascii?Q?zvXMBOuJh+bkdk42HOPfgzfL9XBVnWNxmbEPxOb6e5fVWmVQt83L62ijuTLQ?=
 =?us-ascii?Q?7D+ckAaF46IajORePLItyDsmt1rjWAJB4r52u29fFa2DkHFu+lz/8BVx3rM8?=
 =?us-ascii?Q?dWlq49Q2oXFDdlhKeNEy+7v2ibFP532UK6q3FBt91JiSqovMsYn+hj70WCey?=
 =?us-ascii?Q?NYieoOLrau/wbkmqda5YxjAD3E4XpndmuG5w+4LZiACI5im2pD/RrYGzBUo9?=
 =?us-ascii?Q?9p8tCXizWERESUltWYEsNi/IPfzAG2EmcSSrevneRlzFYEzUhQLj4BBvSRdT?=
 =?us-ascii?Q?Yj7MbxgkF4vCiPYwDLK7gvKYDjVzP/9NxKyJ/2tQmo54KiMIDhGYqAy71Y3j?=
 =?us-ascii?Q?M5cTnkXXOx459CqJJclRO8qTLGHAprWC3I8HF/EqSrP/PE+CkP+4vfSYd1a7?=
 =?us-ascii?Q?qxJLoSt3tVTgVwTN6bZbqKBZIMQ+R1ybjVWJPw9pifbH55xh/PWlcHX83Naa?=
 =?us-ascii?Q?/G0QkY5gO9H51+NvQN9ZyHrg4d8IVTknucSYoNEcL2eHrBECgSzUjf/xfucG?=
 =?us-ascii?Q?Dl0GR8rEOt9sfc0/nToVEYpkKplEJ+iMWCsJFX65bCUQLCnC6BQ4L4zfX/Qk?=
 =?us-ascii?Q?5yK9Mds/Ie8wfbgKzY4J/HREZ7R2PiQms5ds7XKkHS2wlpfd5zvvaZPuH0Jc?=
 =?us-ascii?Q?8Kv1GvPoaYVYZJ2bSx2yKVMIq2dr0n/h1d1CsamtuubxcH8h9BZDEabDcrSC?=
 =?us-ascii?Q?YDswQ+a4C0mNuUrw8NFqA/M2mCMWcuKSJxKUGePMt+Q0UToZRSYJ5ebCWt4P?=
 =?us-ascii?Q?JF8JO3qNxq7agLQkGjNZB0WfqOCHNw2sntleR3uFMdwOi9BukkV2WYB8EBNB?=
 =?us-ascii?Q?gUgdR7XzNq6dA4iTTMgFk3kaha+5FlO23magKRIdJ4ZypEhGmO62RNvZHOf7?=
 =?us-ascii?Q?zj3qPyeqVMyJQ3/a6vn5WJtYstrAFNoRVWpQYfdsivnRvIJiSQL2PQgyVMdd?=
 =?us-ascii?Q?MBb3cVKGxOVFEQ1swyg+hycZzN/ljlGSRXhJw4hegr5NpHWW7s9UtYVQ2vLW?=
 =?us-ascii?Q?tAVFQ5l3QXU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB7540.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(10070799003)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UBhdLkKrnZlIlqFfcG+W6IL86uC0TuKKDe0DC5GQigbT+1SGG0T8Z6oTe37E?=
 =?us-ascii?Q?hfx7oEyfH9kYe6b5LkE1RpXarDl39jIeidZc/8mYeqdftbbSpN1yVyiECf4v?=
 =?us-ascii?Q?3GcBhM5skCRaQ6PuhITl0YzD1gTb41WS5BnYJ2G7BjrTlfJxV48S0nZvnz+a?=
 =?us-ascii?Q?4Gq2Fneu+KtnL2mxsH48ca5ax1iGMmfOhPSIw1R8+rA8Yzvk7otdGzSFl/LZ?=
 =?us-ascii?Q?0pi/H07HwOmZm0VItM9flJbYBVzMMg3LQm8LoAo09y3GySWQsnuaT/q1wion?=
 =?us-ascii?Q?fgVE5WReYe/fq+yrBvQejCeEAWSaRfJzxYf036GxX99tKZ6ZS4m0egHViwlp?=
 =?us-ascii?Q?jBA4ei0w/ypFA4erb3ZGy5F/rb2byGRwrmSujvUxALdaOVSPdBtUdfTuiFh+?=
 =?us-ascii?Q?ru0s5/eZfOanI4FsOdGnn4KzRvxEl8lItFG2rmhsoN17baVsvnyOohKzw5Dx?=
 =?us-ascii?Q?/6XX+Wgq+hQsf1ydjczFy9UXvJ4HJAMsIFWlHaZwx0w620eTHjofyHWMKHlE?=
 =?us-ascii?Q?+4U/B9gvLMhSGkPR6U2lWqGTPeEf7ntRg8c5jfBy9ZFOA1Sa+zQd3CAiv6fP?=
 =?us-ascii?Q?Fk7nvNu29smKRS91xnZYUnrQRwS3CLg6+X8HIKbDzx9Hfs0e9saMKe7MyGu3?=
 =?us-ascii?Q?z/jpzPngsOGgjuhzshg/ilf4VWcMeFGqs/AiygBBxA9vyhKKDERxYXG8I7MF?=
 =?us-ascii?Q?wygvRU1c4+ntMcVisHPpQwJp9t8T0XuW4tkahKqDEeqGmYeQqd1ceS6rRZtp?=
 =?us-ascii?Q?rcNF07y/ixGElMCU11vYnLhCElYxajC6IaN030lzVEFEbRYd7/e0ADYvAdm3?=
 =?us-ascii?Q?ySBkykxAxdkcFM8LKZrGIzGjdZ0i0hJCja+g3+56452C8jRSEU1RxZ1VZkir?=
 =?us-ascii?Q?mUkALNFFhV4pwADmFvmUE0/h7Id+FDsKxh8ZR6ErTux4Q2RQgyl47iPTSmoT?=
 =?us-ascii?Q?coOiud+n/JHTFkUTy4wu5sfgdC0oVWwvIP5gIB5ecmbXd3lPxkJO+yVexE6P?=
 =?us-ascii?Q?ouvNVPn29vthYIFqjVdezaIEDNfWwi66X5MM3Gj9gmO635F+N2IDCt5tEvw0?=
 =?us-ascii?Q?SmYLaj2SgKE2m9TQSmEjYr08aNkl5ykjwZzGGB3R9as6a/JBxXYX3f9fLUH4?=
 =?us-ascii?Q?7g+gJ9Bn2qrTMjxg2QBxyyI9OmxOYFxZ9QXGnLRvulbEHjn+8YWgh8wlXWoa?=
 =?us-ascii?Q?U5h9tKbZQerg0qD3SYStQz/CTTuoR+3wERIidbvr0PpbQHs0BvLK2zokPThT?=
 =?us-ascii?Q?yGxApwcXf7fZsXFroIqbtduNnI+N8UFNI7SHvg9i5gsQD6StMbt89btPRekR?=
 =?us-ascii?Q?6Bv0eNUrze7o4J/7JWbeXKCQjlNTxvqoUKw6u3EY/tUVTUVlgVeeLp062P13?=
 =?us-ascii?Q?Jhx0WJCkxlUe3mev5Fy1Lz3rkacA4pdMekymUsmyTUQF7O+n/BWY+fweAxB3?=
 =?us-ascii?Q?/j2sUwYZOooYoGSErv5Z4g4SiRntUWdanJzT55xatvfK9nf8PC/aGfOYZ2y4?=
 =?us-ascii?Q?hFT3YC01zPY56hVDvd6LtVBtkEKtol1R8GVFtuNwI1CjHEOkSEHpLuJ7C54m?=
 =?us-ascii?Q?2bl2jAX3NCGYIyKSZcf4es75cmFZsXQs3ipupQ2mkt/MemdU9sTWUmMhlPWo?=
 =?us-ascii?Q?HWRSZ/Gob0n0IF9u+L6TCaCXr6sqDWGGkADKXJYNWwuDTnaf5C+ed9PR6oQW?=
 =?us-ascii?Q?DZdgkw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: dd3fad12-2c3e-477b-9a23-08dd78d7f8d1
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7540.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2025 09:05:14.7023
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jsfZFVrRNl7QfxBOzyzDU0i62ntkKQPdM6h9ZX2MCpRGjn8lc1abh0MscBal/1j1o2Xah6gjMzqFmPtgExTM7Q/ku+7UEvpc0xduQODYuZk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4615
X-OriginatorOrg: intel.com

On Tue, Apr 08, 2025 at 11:49:58PM +0530, Raju Rangoju wrote:
> Reorganize the xgbe_pci_probe() code path to convert if/else statements
> to switch case to help add future code. This helps code look cleaner.
> 
> Signed-off-by: Raju Rangoju <Raju.Rangoju@amd.com>

Reviewed-by: Larysa Zaremba <larysa.zaremba@intel.com>

> ---
>  drivers/net/ethernet/amd/xgbe/xgbe-pci.c | 35 ++++++++++++++----------
>  drivers/net/ethernet/amd/xgbe/xgbe.h     |  4 +++
>  2 files changed, 25 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-pci.c b/drivers/net/ethernet/amd/xgbe/xgbe-pci.c
> index 3e9f31256dce..d36446e76d0a 100644
> --- a/drivers/net/ethernet/amd/xgbe/xgbe-pci.c
> +++ b/drivers/net/ethernet/amd/xgbe/xgbe-pci.c
> @@ -165,20 +165,27 @@ static int xgbe_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  
>  	/* Set the PCS indirect addressing definition registers */
>  	rdev = pci_get_domain_bus_and_slot(0, 0, PCI_DEVFN(0, 0));
> -	if (rdev &&
> -	    (rdev->vendor == PCI_VENDOR_ID_AMD) && (rdev->device == 0x15d0)) {
> -		pdata->xpcs_window_def_reg = PCS_V2_RV_WINDOW_DEF;
> -		pdata->xpcs_window_sel_reg = PCS_V2_RV_WINDOW_SELECT;
> -	} else if (rdev && (rdev->vendor == PCI_VENDOR_ID_AMD) &&
> -		   (rdev->device == 0x14b5)) {
> -		pdata->xpcs_window_def_reg = PCS_V2_YC_WINDOW_DEF;
> -		pdata->xpcs_window_sel_reg = PCS_V2_YC_WINDOW_SELECT;
> -
> -		/* Yellow Carp devices do not need cdr workaround */
> -		pdata->vdata->an_cdr_workaround = 0;
> -
> -		/* Yellow Carp devices do not need rrc */
> -		pdata->vdata->enable_rrc = 0;
> +	if (rdev && rdev->vendor == PCI_VENDOR_ID_AMD) {
> +		switch (rdev->device) {
> +		case XGBE_RV_PCI_DEVICE_ID:
> +			pdata->xpcs_window_def_reg = PCS_V2_RV_WINDOW_DEF;
> +			pdata->xpcs_window_sel_reg = PCS_V2_RV_WINDOW_SELECT;
> +			break;
> +		case XGBE_YC_PCI_DEVICE_ID:
> +			pdata->xpcs_window_def_reg = PCS_V2_YC_WINDOW_DEF;
> +			pdata->xpcs_window_sel_reg = PCS_V2_YC_WINDOW_SELECT;
> +
> +			/* Yellow Carp devices do not need cdr workaround */
> +			pdata->vdata->an_cdr_workaround = 0;
> +
> +			/* Yellow Carp devices do not need rrc */
> +			pdata->vdata->enable_rrc = 0;
> +			break;
> +		default:
> +			pdata->xpcs_window_def_reg = PCS_V2_WINDOW_DEF;
> +			pdata->xpcs_window_sel_reg = PCS_V2_WINDOW_SELECT;
> +			break;
> +		}
>  	} else {
>  		pdata->xpcs_window_def_reg = PCS_V2_WINDOW_DEF;
>  		pdata->xpcs_window_sel_reg = PCS_V2_WINDOW_SELECT;
> diff --git a/drivers/net/ethernet/amd/xgbe/xgbe.h b/drivers/net/ethernet/amd/xgbe/xgbe.h
> index e5f5104342aa..2e9b3be44ff8 100644
> --- a/drivers/net/ethernet/amd/xgbe/xgbe.h
> +++ b/drivers/net/ethernet/amd/xgbe/xgbe.h
> @@ -238,6 +238,10 @@
>  		    (_src)->link_modes._sname,		\
>  		    __ETHTOOL_LINK_MODE_MASK_NBITS)
>  
> +/* XGBE PCI device id */
> +#define XGBE_RV_PCI_DEVICE_ID	0x15d0
> +#define XGBE_YC_PCI_DEVICE_ID	0x14b5
> +
>  struct xgbe_prv_data;
>  
>  struct xgbe_packet_data {
> -- 
> 2.34.1
> 
> 

