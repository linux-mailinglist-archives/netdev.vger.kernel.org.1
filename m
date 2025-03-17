Return-Path: <netdev+bounces-175323-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F4BFA65190
	for <lists+netdev@lfdr.de>; Mon, 17 Mar 2025 14:45:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2FD52188B718
	for <lists+netdev@lfdr.de>; Mon, 17 Mar 2025 13:45:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4569223ED62;
	Mon, 17 Mar 2025 13:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FDDxYZri"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4EA823F277
	for <netdev@vger.kernel.org>; Mon, 17 Mar 2025 13:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742219116; cv=fail; b=Mv7SCJi7x4mrLloyAWz5fX5oSAhDY7B/MYcpSyzgHkyW6l1NXawzPu+oHfJbrCtBXY8bMQV8NNrHMI2OtjZxG35mkPjEbxyXnKxoFNsrg8xCTrzv/Puh8rwjpuw7o/5DaBma5CFXoKPCYSrrb+S4uRu39bSt0stRj2WNneN3uaA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742219116; c=relaxed/simple;
	bh=y4ALdwSeXY+ASJyrMsRtAmN9THFOlAAR1rDPRyiZ9C8=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=LkaAwjR4aAQ9eldUt7v9+K3bpNN1Exio7AZn+nuWnJlI9j2S6OZzNg1Lby647j8f+wWvsn7IY+xC3e+BEq4Y3USYOPdkUgkzA8c4k0qauN9G7d3TZeZrEJBz6XGB1RsfHIzzacFt8uvYS8eLuxjThCp40OzIqgmCOt3/1rlZtQ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FDDxYZri; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742219114; x=1773755114;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=y4ALdwSeXY+ASJyrMsRtAmN9THFOlAAR1rDPRyiZ9C8=;
  b=FDDxYZri7IDj1iR2TuEOyY3TKHo+b6pTUaYrRz0phtRc2uLYCcQRJ792
   usspenPN/uAdmUdaJJfVl3oxAo6ceBenXQBunV77erMTyojuU7ihev0cU
   lsR0K+L1KVZQOS0dwjTjB0tNnXuE5SROCi6lji9ZRafSlhjOi+lFcovs7
   Eyu5Bj+hbNungGfLeIO/6+l01SSSfJqj1JBZz/x7cYrJdE32qkYndb51D
   u0dAIl6/73kQKHXJW3fSB5EBiYjLyVALzjHtT2mab3XMjwdypAQmfP+PV
   gz9fP0XnpRy4s7gaJ20C2qvwk8FuVUtC/r1zZ3h6oUbCDL6LDaz1p8Afa
   A==;
X-CSE-ConnectionGUID: O8qVh+E4TCK56KM0UobY+g==
X-CSE-MsgGUID: cdDH594qTVCtpGeon2IIBw==
X-IronPort-AV: E=McAfee;i="6700,10204,11376"; a="54685602"
X-IronPort-AV: E=Sophos;i="6.14,254,1736841600"; 
   d="scan'208";a="54685602"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2025 06:45:13 -0700
X-CSE-ConnectionGUID: Lawd/a27Q3K2M/WYmJymbQ==
X-CSE-MsgGUID: mVsEU9b4ReKOCfSPYv+ZIA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,254,1736841600"; 
   d="scan'208";a="121669563"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 17 Mar 2025 06:45:13 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 17 Mar 2025 06:45:12 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Mon, 17 Mar 2025 06:45:12 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.177)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 17 Mar 2025 06:45:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t/iqtd+Vkk23rxuBpJseX5W5/plMQl07HeOzRBXlRuDiKoWLUNwmXMqDStgdDpcNTEFZb/CgDX2/LJfYosdvuuzkpCDlTV9B2HkWxexr388MthozvdWC1knT9KcWp6jbJ0E40ideORk7N/saJu0whPLWZGZ1jddU/56xNjV3jgYnMOEXZJ3e9soYNZfK96xC2BctD3VpSWU7VMrdzX+KPpsmwdzXgw5R75RqzjLJULUueRmsrfiD28mg8wyA8GnE29Avq2AkUdX0tmSlTjmwW49sojumyOfxwBY36rVOQGdk5carfWo/B4nVMdf0MMDvtBDRR1OEJWQZ1Fv9J2CH7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k5wY7lEueijh2E9v/T8G3CdkSnvONV45bGG+pEO9QEw=;
 b=h/lOKkRHJgIP2z+lYwbp51R822rYBp5c54l3Y50aw4tSmP56Dc6zcFgECuQ1hf0p2FSrxqlIurxBQHTEwyK40fvZBsIQYgRMQkoG0VhPGlXarYkDMNP1is52Z69GYRFwaSfBbx8Yl+91yrqMVq54T7Ke1eyvP9IRDxN8cd2MK4Dfv14Jt7Baa4/dAzuU33qwUeWJAFIrzopFxT0V/yUsXd076YCx7Q5yMyAJGF8i3p7sHGB1vb2wqOLjeygWgSe5m6HVDtqqry5XaoFm+klUNwyco1D7Mnfc3L9dPRuh2pUs6bkFpuJSDYmDBT0cQhQxotXi5tw665hfQsJxESNlsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by CY8PR11MB7060.namprd11.prod.outlook.com (2603:10b6:930:50::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Mon, 17 Mar
 2025 13:45:05 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%4]) with mapi id 15.20.8534.031; Mon, 17 Mar 2025
 13:45:05 +0000
Date: Mon, 17 Mar 2025 21:44:54 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Eric Dumazet <edumazet@google.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <netdev@vger.kernel.org>,
	"David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Neal Cardwell <ncardwell@google.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>, Jason Xing <kernelxing@tencent.com>,
	Simon Horman <horms@kernel.org>, <eric.dumazet@gmail.com>, Eric Dumazet
	<edumazet@google.com>, <oliver.sang@intel.com>
Subject: Re: [PATCH net-next 1/2] inet: change lport contribution to
 inet_ehashfn() and inet6_ehashfn()
Message-ID: <202503171623.f2e16b60-lkp@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250305034550.879255-2-edumazet@google.com>
X-ClientProxiedBy: SG2PR06CA0181.apcprd06.prod.outlook.com (2603:1096:4:1::13)
 To LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|CY8PR11MB7060:EE_
X-MS-Office365-Filtering-Correlation-Id: ed3963d4-ab27-4767-b933-08dd6559ec63
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?1Aypezwicx3x59l8CueeCi/3PUMGeX8mocrCsiW3++Kz44yjhnCoQmDmFk?=
 =?iso-8859-1?Q?hPTQccUDhRmSvwUGc9tTEERCwiWrWEnPXY2eCobyKmgsil8A2wB6FgRJJ/?=
 =?iso-8859-1?Q?QMNb5z4VccP7sWpHuBuT3ama6NA3Kp1Pnlj/bMpTIH+i9Z6zTKuZlMl0GS?=
 =?iso-8859-1?Q?jSzsDo1eTzFo/h5H6q72d/7eIY84hmdHwEnwJcRDCarbQutpHf0DxrU8DF?=
 =?iso-8859-1?Q?lxO6/l+oibyPJcUfEKLZoIOy2zDWkXJBxnjHrSpc1tUUPF5l+5Vfpv4nCz?=
 =?iso-8859-1?Q?j962jPyLkunRAZpxcHjyForEkVjX2lJlDP+YOg4QYkTEAi/rrtwx8QmhRJ?=
 =?iso-8859-1?Q?y+qDjnjGVQogAgAOBahseOlkPaJRbtEx3S0diLdgKvzCv/wed2haESiE6j?=
 =?iso-8859-1?Q?0LFuBLjvf151QbmoX1Zmrd3pE4CGu8VU/vjEGxN+WpBfchCnpKtRCiSVT8?=
 =?iso-8859-1?Q?DhMDNYkcje4ZoSTGXZV4/delMYzVqxxoizYvzceiEBK7mEU7kNpKs4hMwx?=
 =?iso-8859-1?Q?Z2CZWhyU9nHSc/7FjBbbCHd3yEbIhiM5s3X/rIhhgSmEAxBKWbji3B0SI2?=
 =?iso-8859-1?Q?6aAHrrQm9brbVqYtrEQcu+7w031rCm4eW9m5pOnReOlz/8Olz7AaPpXefA?=
 =?iso-8859-1?Q?2KEbk4yYRr7kJM3/2jn6C05lC8RKHJSeYOCbxWH3Yohr1jQbRnSX71nNXI?=
 =?iso-8859-1?Q?p/HrYalG4c8/8IAOdLEmw9aSOzaGFNKHwLvQpfFqkFMlLVbe/GtDDLtrds?=
 =?iso-8859-1?Q?d5VlewNEFtmx+9wTbk9n4FhR0zcIQYQf0AV69W6fxV+wJ03v3nOZ1UsReL?=
 =?iso-8859-1?Q?0J2FxuScELutkWsBUMfco5LaIk22ATlp9qGrZhm8npTPyo/ZIKoIrK0RWp?=
 =?iso-8859-1?Q?AL9Gc6yxZuT0RTAATtw9HlYf7nLVs1p7nqXizfn0QKv3jTm6ZWtDhc/F73?=
 =?iso-8859-1?Q?v2Qt/K6IiLemxSQNjKw26yEE8oIvR5Zb/Fo/u4iIyiDSAlNp2VtDm/Ri4a?=
 =?iso-8859-1?Q?7JtSpLUYCM9849HeA1+OLP4EL29LeULphVWnc4WDpcGZrcg9++oJjnwLFY?=
 =?iso-8859-1?Q?agduvJju7TjC70yzodDamPwIcE9WJrvpsCGH6JRklpRVaW1F/jgxzHP7My?=
 =?iso-8859-1?Q?qwabrB/UxqjYOB+X24Zbjai5XqngvhLQSQZU6XGklJ2g9e9pGUl7SIQ8mL?=
 =?iso-8859-1?Q?qZjs4oog4qZJJC8EXaz7evm1l4zlo7W0X0HR6TWtzTWNzYk1dkuVrtZSPb?=
 =?iso-8859-1?Q?X0rIg0vRKZ03kfDVE5HpXQ0hW6h3/oTz6U4Can87QKDnz+9aRDnucboddB?=
 =?iso-8859-1?Q?OLne18s4F0Iy7l8kV5n7J49ortw7OxiaBLdRU82qf9VTSFdUL/sIM9dyIQ?=
 =?iso-8859-1?Q?Nk17bt6/xLFS7B/RDXGuqmq6fnikPIUA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?LzyxMFfoFhmhNRMMrNtRiug7qpUSstmm0JEk9EVsrPEn14t19FGq1im8i7?=
 =?iso-8859-1?Q?dW8QNIewv+2FFpkt6/4MUKIfOI1TeQsFOnyrL3AQ726onMtXmvwyOilUum?=
 =?iso-8859-1?Q?ebPR8okLXp2qauChNRQIYiwdTADCGynA34eG9Yw36uOxucmCEGnGTYdoIN?=
 =?iso-8859-1?Q?ZzYsaWO7AnCXlHfBLm31yaj4yJjFyi9RvG/c6z52aJIzdAZpapQFC/ecDU?=
 =?iso-8859-1?Q?ROSMkFk0b6QQ2oJ0mLEUWiTFPlIv+qh4bVQ4Gx0CWcp01zusXNza8w/arH?=
 =?iso-8859-1?Q?jV6LHsOTWiGO8FQXpzHsAii+i0sXd8aLSYQNtb7NqEHY6EgNN7i7ChZYDG?=
 =?iso-8859-1?Q?5VwPGO4KhnGk/6NT/JRtvyTBltGwZXJkVyE0/lOqdAHExo4vnMQKO4BbGW?=
 =?iso-8859-1?Q?XLlq/xgwnp6bJ70vP/2QX/rPtEldgAAsRX4hfOWY/Aok1wBQ2eWvg35RY3?=
 =?iso-8859-1?Q?063THLKewoJVh3+ldc+WurbrBsZOhdHdjlifximH9ZyGgk0fJUEfmSfWer?=
 =?iso-8859-1?Q?iamEOuu4y/LViVkFGbZNUS51mxwweJXWlPqyu9uQ7ijCIp3C0bWWt/epUR?=
 =?iso-8859-1?Q?fO6tlt/WKv8f1I2oNaBGOYpdurpSZbcL+TUEPQs7cEF7lGnSKd8WYA8R67?=
 =?iso-8859-1?Q?F467gIELdlnGr0q/dj6C/rnHFgWfDhqu/MtUhAAlu/UK0QDpSQR7+iDp02?=
 =?iso-8859-1?Q?n/hWEkd4p+xKiJg3NECqgb/tVFmUw2FZ14W0f8qqV6xufz9xNFDnMPLQ9H?=
 =?iso-8859-1?Q?sFzYxS5Bp4hz+Nofr0d7pqTY6U4pj0vFebz3Jqi+zNsSO5UZEPceS0OH9T?=
 =?iso-8859-1?Q?R29FTC62Qq+TcIUpheSIAgwMRBDCTyyWFFYo4nlHOgquSoVEXfweq53PUU?=
 =?iso-8859-1?Q?/sGWwVEkBRi0q2gfPvgkGOmgn1HfcUK0iWXemDzGExE6PuYOaOGYnDju1N?=
 =?iso-8859-1?Q?y56QxgaQA35QPx9hszdkEDXpEv3lpNIlhkykGxdW3JaypdWT8y/LeKzV4r?=
 =?iso-8859-1?Q?gCNDWZXnHEGcMbdvIM3M7xYGM8jjKT+UicktIr/Bmq5GPq4F7XKE96n8MN?=
 =?iso-8859-1?Q?NWE57Uxhm0r6wnJDH+XqflwO12jcm7L1kctkmUzd0uIsZzzb8Fsiy8klq3?=
 =?iso-8859-1?Q?PKXxhBusOKstryb421B+6KDZrPgozhlZdEZLDcN0or33FQUewkK3DjC52R?=
 =?iso-8859-1?Q?/k/+xS0lBGgrRUyJ+LNDN/gr0xIaZNo9ESP3lgZJSlPvzs+sMOepaa8jJT?=
 =?iso-8859-1?Q?tCtVFVgZuJUc+kbkLZuzOFew575S51KbUJpxBk6emC01r2IOdPkEnBSenf?=
 =?iso-8859-1?Q?YX0W1tCUJrR1EkjjPgy4OgHkL4FCwsJeMMC3DJSuOHIHrIPOjq6CL/Fovn?=
 =?iso-8859-1?Q?xP+UhjwTjf/hkU58jabVZs88HyjXiBEriIP0xull4xBB7r5gLZxUst2YUR?=
 =?iso-8859-1?Q?FFPC+4z3Fs/3VizmHGxio/HFYYBGjgcqFnFDtRkD+ZNgshhy1aShBTfHRE?=
 =?iso-8859-1?Q?rIgeM3t0QhPj35QEvXdkorljckPowbFp+uoDUnOQF61bMYTgicSpQxyLR4?=
 =?iso-8859-1?Q?OJG18FKRcfUqhSy2tks3EW0ny0KQn1MOBjfdtuZEEmNqMsKwMFynls7Kfx?=
 =?iso-8859-1?Q?iSe7kfAM+hCQhtZFBPsFJBhyOzbEUbNkrD14bx/a9a4vEtmvuzjjvjng?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ed3963d4-ab27-4767-b933-08dd6559ec63
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2025 13:45:05.1372
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sc06F+9vdz9RQJJVz+QW3sqWh0mxXEjDx3NIYzcdWUAFfZ98DAlJKIbkJsCWCH5c5K0wELqQ1Ij/35MlfXxrnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7060
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed a 26.0% improvement of stress-ng.sockmany.ops_per_sec on:


commit: 265acc444f8a96246e9d42b54b6931d078034218 ("[PATCH net-next 1/2] inet: change lport contribution to inet_ehashfn() and inet6_ehashfn()")
url: https://github.com/intel-lab-lkp/linux/commits/Eric-Dumazet/inet-change-lport-contribution-to-inet_ehashfn-and-inet6_ehashfn/20250305-114734
base: https://git.kernel.org/cgit/linux/kernel/git/davem/net-next.git f252f23ab657cd224cb8334ba69966396f3f629b
patch link: https://lore.kernel.org/all/20250305034550.879255-2-edumazet@google.com/
patch subject: [PATCH net-next 1/2] inet: change lport contribution to inet_ehashfn() and inet6_ehashfn()

testcase: stress-ng
config: x86_64-rhel-9.4
compiler: gcc-12
test machine: 64 threads 2 sockets Intel(R) Xeon(R) Gold 6346 CPU @ 3.10GHz (Ice Lake) with 256G memory
parameters:

	nr_threads: 100%
	testtime: 60s
	test: sockmany
	cpufreq_governor: performance


In addition to that, the commit also has significant impact on the following tests:

+------------------+---------------------------------------------------------------------------------------------+
| testcase: change | stress-ng: stress-ng.sockmany.ops_per_sec 4.4% improvement                                  |
| test machine     | 224 threads 2 sockets Intel(R) Xeon(R) Platinum 8480CTDX (Sapphire Rapids) with 256G memory |
| test parameters  | cpufreq_governor=performance                                                                |
|                  | nr_threads=100%                                                                             |
|                  | test=sockmany                                                                               |
|                  | testtime=60s                                                                                |
+------------------+---------------------------------------------------------------------------------------------+




Details are as below:
-------------------------------------------------------------------------------------------------->


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20250317/202503171623.f2e16b60-lkp@intel.com

=========================================================================================
compiler/cpufreq_governor/kconfig/nr_threads/rootfs/tbox_group/test/testcase/testtime:
  gcc-12/performance/x86_64-rhel-9.4/100%/debian-12-x86_64-20240206.cgz/lkp-icl-2sp8/sockmany/stress-ng/60s

commit: 
  f252f23ab6 ("net: Prevent use after free in netif_napi_set_irq_locked()")
  265acc444f ("inet: change lport contribution to inet_ehashfn() and inet6_ehashfn()")

f252f23ab657cd22 265acc444f8a96246e9d42b54b6 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
      0.60 ±  6%      +0.2        0.75 ±  6%  mpstat.cpu.all.soft%
    376850 ±  9%     +15.7%     436068 ±  9%  numa-numastat.node0.local_node
    376612 ±  9%     +15.8%     435968 ±  9%  numa-vmstat.node0.numa_local
     54708           +22.0%      66753 ±  2%  vmstat.system.cs
      2308         +1167.7%      29267 ± 26%  perf-c2c.HITM.local
      2499         +1078.3%      29447 ± 26%  perf-c2c.HITM.total
      1413 ±  8%     -13.8%       1218 ±  4%  sched_debug.cfs_rq:/.runnable_avg.max
     28302           +21.2%      34303 ±  2%  sched_debug.cpu.nr_switches.avg
     39625 ±  6%     +63.4%      64761 ±  6%  sched_debug.cpu.nr_switches.max
      4170 ±  9%    +126.1%       9429 ±  8%  sched_debug.cpu.nr_switches.stddev
   1606932           +25.9%    2023746 ±  3%  stress-ng.sockmany.ops
     26687           +26.0%      33624 ±  3%  stress-ng.sockmany.ops_per_sec
   1561801           +28.1%    2000939 ±  3%  stress-ng.time.involuntary_context_switches
   1731525           +22.3%    2118259 ±  2%  stress-ng.time.voluntary_context_switches
     84783            +2.6%      86953        proc-vmstat.nr_shmem
      5339 ±  6%     -26.4%       3931 ± 16%  proc-vmstat.numa_hint_faults_local
    878479            +6.8%     937819        proc-vmstat.numa_hit
    812262            +7.3%     871615        proc-vmstat.numa_local
   2550690           +12.5%    2870404        proc-vmstat.pgalloc_normal
   2407108           +13.2%    2724922        proc-vmstat.pgfree
     21.96           -17.2%      18.18 ±  2%  perf-stat.i.MPKI
 7.517e+09           +18.8%  8.933e+09        perf-stat.i.branch-instructions
      2.70            -0.7        1.96        perf-stat.i.branch-miss-rate%
  2.03e+08           -13.1%  1.765e+08        perf-stat.i.branch-misses
     60.22            -2.3       57.89 ±  2%  perf-stat.i.cache-miss-rate%
 1.472e+09            +4.7%  1.542e+09        perf-stat.i.cache-references
     56669           +22.3%      69301 ±  2%  perf-stat.i.context-switches
      5.56           -18.4%       4.53 ±  2%  perf-stat.i.cpi
  4.24e+10           +19.2%  5.054e+10        perf-stat.i.instructions
      0.20           +20.1%       0.24 ±  4%  perf-stat.i.ipc
      0.49           +21.0%       0.60 ±  8%  perf-stat.i.metric.K/sec
     21.03           -15.1%      17.85        perf-stat.overall.MPKI
      2.70            -0.7        1.98        perf-stat.overall.branch-miss-rate%
     60.56            -2.1       58.49        perf-stat.overall.cache-miss-rate%
      5.34           -16.6%       4.45        perf-stat.overall.cpi
    253.77            -1.7%     249.50        perf-stat.overall.cycles-between-cache-misses
      0.19           +19.9%       0.22        perf-stat.overall.ipc
 7.395e+09           +18.9%  8.789e+09        perf-stat.ps.branch-instructions
 1.997e+08           -13.0%  1.737e+08        perf-stat.ps.branch-misses
 1.448e+09            +4.7%  1.517e+09        perf-stat.ps.cache-references
     55820           +22.2%      68204 ±  2%  perf-stat.ps.context-switches
 4.172e+10           +19.2%  4.972e+10        perf-stat.ps.instructions
 2.556e+12           +20.2%  3.072e+12 ±  2%  perf-stat.total.instructions
      0.35 ±  9%     -14.9%       0.29 ±  6%  perf-sched.sch_delay.avg.ms.__cond_resched.__inet_hash_connect.tcp_v4_connect.__inet_stream_connect.inet_stream_connect
      0.06 ±  7%     -20.5%       0.04 ±  4%  perf-sched.sch_delay.avg.ms.__cond_resched.__release_sock.release_sock.__inet_stream_connect.inet_stream_connect
      0.16 ±218%    +798.3%       1.44 ± 40%  perf-sched.sch_delay.avg.ms.__cond_resched.kmem_cache_alloc_noprof.alloc_empty_file.alloc_file_pseudo.sock_alloc_file
      0.25 ±152%    +291.3%       0.99 ± 45%  perf-sched.sch_delay.avg.ms.__cond_resched.kmem_cache_alloc_noprof.security_inode_alloc.inode_init_always_gfp.alloc_inode
      0.11 ±166%    +568.2%       0.75 ± 45%  perf-sched.sch_delay.avg.ms.__cond_resched.lock_sock_nested.inet_stream_connect.__sys_connect.__x64_sys_connect
      0.84 ± 14%     +39.2%       1.17 ±  9%  perf-sched.sch_delay.avg.ms.__cond_resched.stop_one_cpu.sched_exec.bprm_execve.part
      0.11 ± 22%    +108.5%       0.23 ± 12%  perf-sched.sch_delay.avg.ms.schedule_timeout.wait_woken.sk_wait_data.tcp_recvmsg_locked
      0.08 ± 59%     -60.0%       0.03 ±  4%  perf-sched.sch_delay.max.ms.__cond_resched.__release_sock.release_sock.tcp_sendmsg.__sys_sendto
      0.16 ±218%   +1286.4%       2.22 ± 25%  perf-sched.sch_delay.max.ms.__cond_resched.kmem_cache_alloc_noprof.alloc_empty_file.alloc_file_pseudo.sock_alloc_file
      0.13 ±153%    +910.1%       1.27 ± 34%  perf-sched.sch_delay.max.ms.__cond_resched.lock_sock_nested.inet_stream_connect.__sys_connect.__x64_sys_connect
      9.23           -12.5%       8.08        perf-sched.total_wait_and_delay.average.ms
    139892           +15.3%     161338        perf-sched.total_wait_and_delay.count.ms
      9.18           -12.5%       8.03        perf-sched.total_wait_time.average.ms
      0.70 ±  8%     -14.5%       0.60 ±  6%  perf-sched.wait_and_delay.avg.ms.__cond_resched.__inet_hash_connect.tcp_v4_connect.__inet_stream_connect.inet_stream_connect
      0.11 ±  8%     -20.1%       0.09 ±  4%  perf-sched.wait_and_delay.avg.ms.__cond_resched.__release_sock.release_sock.__inet_stream_connect.inet_stream_connect
    429.48 ± 44%     +63.6%     702.60 ± 11%  perf-sched.wait_and_delay.avg.ms.devkmsg_read.vfs_read.ksys_read.do_syscall_64
      4.97           -14.0%       4.28        perf-sched.wait_and_delay.avg.ms.schedule_timeout.inet_csk_accept.inet_accept.do_accept
      0.23 ± 21%    +104.2%       0.46 ± 12%  perf-sched.wait_and_delay.avg.ms.schedule_timeout.wait_woken.sk_wait_data.tcp_recvmsg_locked
     48576 ±  5%     +36.3%      66215 ±  2%  perf-sched.wait_and_delay.count.__cond_resched.__release_sock.release_sock.__inet_stream_connect.inet_stream_connect
     81.83            +9.8%      89.83 ±  2%  perf-sched.wait_and_delay.count.schedule_hrtimeout_range.do_poll.constprop.0.do_sys_poll
     64098           +16.3%      74560        perf-sched.wait_and_delay.count.schedule_timeout.inet_csk_accept.inet_accept.do_accept
     15531 ± 17%     -46.2%       8355 ±  6%  perf-sched.wait_and_delay.count.schedule_timeout.wait_woken.sk_wait_data.tcp_recvmsg_locked
      0.36 ±  8%     -14.2%       0.31 ±  6%  perf-sched.wait_time.avg.ms.__cond_resched.__inet_hash_connect.tcp_v4_connect.__inet_stream_connect.inet_stream_connect
      0.06 ±  7%     -20.2%       0.04 ±  4%  perf-sched.wait_time.avg.ms.__cond_resched.__release_sock.release_sock.__inet_stream_connect.inet_stream_connect
      0.04 ±178%     -94.4%       0.00 ±130%  perf-sched.wait_time.avg.ms.__cond_resched.down_write_killable.exec_mmap.begin_new_exec.load_elf_binary
      0.16 ±218%    +798.5%       1.44 ± 40%  perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc_noprof.alloc_empty_file.alloc_file_pseudo.sock_alloc_file
      0.11 ±166%    +568.6%       0.75 ± 45%  perf-sched.wait_time.avg.ms.__cond_resched.lock_sock_nested.inet_stream_connect.__sys_connect.__x64_sys_connect
    427.69 ± 45%     +63.1%     697.48 ± 10%  perf-sched.wait_time.avg.ms.devkmsg_read.vfs_read.ksys_read.do_syscall_64
      4.95           -14.0%       4.26        perf-sched.wait_time.avg.ms.schedule_timeout.inet_csk_accept.inet_accept.do_accept
      0.12 ± 20%     +99.9%       0.23 ± 12%  perf-sched.wait_time.avg.ms.schedule_timeout.wait_woken.sk_wait_data.tcp_recvmsg_locked
      0.16 ±218%   +1286.4%       2.22 ± 25%  perf-sched.wait_time.max.ms.__cond_resched.kmem_cache_alloc_noprof.alloc_empty_file.alloc_file_pseudo.sock_alloc_file
      0.13 ±153%    +911.4%       1.27 ± 34%  perf-sched.wait_time.max.ms.__cond_resched.lock_sock_nested.inet_stream_connect.__sys_connect.__x64_sys_connect


***************************************************************************************************
lkp-spr-r02: 224 threads 2 sockets Intel(R) Xeon(R) Platinum 8480CTDX (Sapphire Rapids) with 256G memory
=========================================================================================
compiler/cpufreq_governor/kconfig/nr_threads/rootfs/tbox_group/test/testcase/testtime:
  gcc-12/performance/x86_64-rhel-9.4/100%/debian-12-x86_64-20240206.cgz/lkp-spr-r02/sockmany/stress-ng/60s

commit: 
  f252f23ab6 ("net: Prevent use after free in netif_napi_set_irq_locked()")
  265acc444f ("inet: change lport contribution to inet_ehashfn() and inet6_ehashfn()")

f252f23ab657cd22 265acc444f8a96246e9d42b54b6 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
    205766            +3.2%     212279        vmstat.system.cs
    309724 ±  5%     +63.6%     506684 ±  9%  sched_debug.cfs_rq:/.avg_vruntime.stddev
    309724 ±  5%     +63.6%     506684 ±  9%  sched_debug.cfs_rq:/.min_vruntime.stddev
   1307371 ±  8%     -14.5%    1117523 ±  7%  sched_debug.cpu.avg_idle.max
   4333131            +4.4%    4525951        stress-ng.sockmany.ops
     71816            +4.4%      74988        stress-ng.sockmany.ops_per_sec
   7639150            +3.6%    7910527        stress-ng.time.voluntary_context_switches
    693603           -18.6%     564616 ±  3%  perf-c2c.DRAM.local
    611374           -16.8%     508688 ±  2%  perf-c2c.DRAM.remote
     19509          +994.2%     213470 ±  7%  perf-c2c.HITM.local
     20252          +957.6%     214187 ±  7%  perf-c2c.HITM.total
    204521            +3.1%     210765        proc-vmstat.nr_shmem
    938137            +2.9%     965493        proc-vmstat.nr_slab_reclaimable
   3102658            +3.0%    3196837        proc-vmstat.nr_slab_unreclaimable
   2113801            +1.8%    2151131        proc-vmstat.numa_hit
   1881174            +2.0%    1919223        proc-vmstat.numa_local
   6186586            +3.6%    6406837        proc-vmstat.pgalloc_normal
      0.76 ± 46%     -83.0%       0.13 ±144%  perf-sched.sch_delay.avg.ms.__cond_resched.mutex_lock.perf_poll.do_poll.constprop
      0.02 ±  2%      -6.3%       0.02 ±  2%  perf-sched.sch_delay.avg.ms.schedule_timeout.inet_csk_accept.inet_accept.do_accept
     15.43           -12.6%      13.48        perf-sched.total_wait_and_delay.average.ms
    234971           +15.6%     271684        perf-sched.total_wait_and_delay.count.ms
     15.37           -12.6%      13.43        perf-sched.total_wait_time.average.ms
    140.18 ±  5%     -37.2%      88.02 ± 11%  perf-sched.wait_and_delay.avg.ms.schedule_hrtimeout_range.do_poll.constprop.0.do_sys_poll
     10.17           -14.1%       8.74        perf-sched.wait_and_delay.avg.ms.schedule_timeout.inet_csk_accept.inet_accept.do_accept
      4.02          -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
    104089           +16.4%     121193        perf-sched.wait_and_delay.count.__cond_resched.__release_sock.release_sock.__inet_stream_connect.inet_stream_connect
     88.17 ±  6%     +68.1%     148.17 ± 13%  perf-sched.wait_and_delay.count.schedule_hrtimeout_range.do_poll.constprop.0.do_sys_poll
    108724           +16.8%     127034        perf-sched.wait_and_delay.count.schedule_timeout.inet_csk_accept.inet_accept.do_accept
      1232          -100.0%       0.00        perf-sched.wait_and_delay.count.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
      4592 ± 12%     +26.1%       5792 ± 14%  perf-sched.wait_and_delay.count.schedule_timeout.wait_woken.sk_wait_data.tcp_recvmsg_locked
     11.29 ± 68%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
      9.99           -13.3%       8.66        perf-sched.wait_time.avg.ms.__cond_resched.__release_sock.release_sock.tcp_sendmsg.__sys_sendto
    139.53 ±  6%     -37.2%      87.60 ± 11%  perf-sched.wait_time.avg.ms.schedule_hrtimeout_range.do_poll.constprop.0.do_sys_poll
     10.15           -14.1%       8.72        perf-sched.wait_time.avg.ms.schedule_timeout.inet_csk_accept.inet_accept.do_accept
     41.10           -17.2%      34.03        perf-stat.i.MPKI
 1.424e+10           +14.6%  1.631e+10        perf-stat.i.branch-instructions
      2.28            -0.1        2.17        perf-stat.i.branch-miss-rate%
 3.193e+08            +9.4%  3.492e+08        perf-stat.i.branch-misses
     77.01            -9.5       67.48        perf-stat.i.cache-miss-rate%
 2.981e+09            -5.1%   2.83e+09        perf-stat.i.cache-misses
 3.806e+09            +8.4%  4.127e+09        perf-stat.i.cache-references
    217129            +3.2%     224056        perf-stat.i.context-switches
      8.68           -12.7%       7.58        perf-stat.i.cpi
    242.24            +4.0%     251.97        perf-stat.i.cycles-between-cache-misses
 7.608e+10           +14.1%  8.679e+10        perf-stat.i.instructions
      0.13           +13.3%       0.15        perf-stat.i.ipc
     39.15           -16.8%      32.58        perf-stat.overall.MPKI
      2.24            -0.1        2.14        perf-stat.overall.branch-miss-rate%
     78.30            -9.7       68.56        perf-stat.overall.cache-miss-rate%
      8.35           -12.4%       7.31        perf-stat.overall.cpi
    213.17            +5.3%     224.53        perf-stat.overall.cycles-between-cache-misses
      0.12           +14.1%       0.14        perf-stat.overall.ipc
 1.401e+10           +14.6%  1.604e+10        perf-stat.ps.branch-instructions
 3.139e+08            +9.4%  3.434e+08        perf-stat.ps.branch-misses
 2.931e+09            -5.1%  2.782e+09        perf-stat.ps.cache-misses
 3.743e+09            +8.4%  4.058e+09        perf-stat.ps.cache-references
    213541            +3.3%     220574        perf-stat.ps.context-switches
 7.485e+10           +14.1%  8.539e+10        perf-stat.ps.instructions
 4.597e+12           +13.9%  5.235e+12        perf-stat.total.instructions





Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


