Return-Path: <netdev+bounces-174595-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AD6CA5F644
	for <lists+netdev@lfdr.de>; Thu, 13 Mar 2025 14:48:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F38A416B57B
	for <lists+netdev@lfdr.de>; Thu, 13 Mar 2025 13:48:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AED41267B0B;
	Thu, 13 Mar 2025 13:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="If3hZwhh"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9479267AED;
	Thu, 13 Mar 2025 13:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741873703; cv=fail; b=h0xqfyMuJJy/Sj4vqlCJo1tuxrO7QA/tUQ8ekDG2EYqMuyvRGCqAYe+ygwezPt57D6vCKNF4O5gIO14XD9evBurev9GD9/ET5VRJ3gs4Rrq21CG9d1bB7k9ytmepNsK2373FmHrEISZvwrcO/5A0mG94iNnutp240MLpsW9D6Nw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741873703; c=relaxed/simple;
	bh=dXmM0Wtd7HYpQnztnrVdF03tptbx+LbRkcL2GqH25Xw=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Uf+GBBAh7v1q7cIR7sHxTAoFaVH9rGeBOI5wyod2s1eIFQb/XnKxixFmvOGpTryu3TpGfsb28JL9R/fR5D9H9f+6gnaoQB9AVVxWjxsbMaq2rIeTLHYHZblyYpGgLxktU6cEuTPaMnkejh4TaYgV9ksV5ImBIHKX7FlDMDjwYpI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=If3hZwhh; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741873702; x=1773409702;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=dXmM0Wtd7HYpQnztnrVdF03tptbx+LbRkcL2GqH25Xw=;
  b=If3hZwhhRrRPbH3eOOHeAJMQT7+IzygxhHfceK5tElSieEQ9dFTb1oRX
   ogxgmqdLkdwcqs80La4RmCGVCB+7p02D3LgkAlQZbvcyGLAyYRCAjttvR
   7s3s9jJVBsYY57RZpgW3mtXTLzxS1Wr22RT0ZtCdCxhS9RBwNF8qOzLTM
   Ips0G5+OsIQHQKBngMb4YiczbtN3wLkbpG87Qsa36ZvrBSIXM8yicWfy1
   Q7bc1bSn9ZMsPJVcIsbgkYyuUNeQhe2rothsiMPwtkgyAZikKpVgKCb12
   GW0KxnjqGJ8Yc/rqL7hlfOrnvq94pK2r7tHwkf4oparj1AzSgKbvISi4/
   w==;
X-CSE-ConnectionGUID: WFysiRyFSB+thw4LA7l62Q==
X-CSE-MsgGUID: +cV3jOPuRjGSAiMaATeatQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11372"; a="42870511"
X-IronPort-AV: E=Sophos;i="6.14,244,1736841600"; 
   d="scan'208";a="42870511"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2025 06:48:21 -0700
X-CSE-ConnectionGUID: 3DTgxkY7SCehTSiEVNxemw==
X-CSE-MsgGUID: mAE+6PM8T32w2YvwoiHYRg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,244,1736841600"; 
   d="scan'208";a="125132199"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2025 06:48:20 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 13 Mar 2025 06:48:20 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 13 Mar 2025 06:48:20 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.177)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 13 Mar 2025 06:48:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EYuYxrAXzOmho7gI2gMmJN+qy4Em1q8wpkjlzlwgI+1acYsUMJeH1/wVAq9nPfTzZJZijhy5aW2+5FE9RVj7nF/GmYshZvblqOIlKB6tTTh6qCJS2OkPdUE8S5Ci5XHWdYlRXTxcIt83nPOg2Xbr0hwoBRkeV9dXvT6xObNyu0NBOlcy2yQekZ2djX1XTsFk+QSxUr7ZBOWouGvO1wkYQC3ibnel4aagP4UJDsyo9E5RiKSMCI5/bWjnJdPTYnTuVJh4rgh9yLtInBPl2ToxN7ruc79J0bKpRouEMq+Vh4Iv7MiwiNyl/HMkg4PbkUdIB7/d6oYIgE03pfiXI65qHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gHzKaxzOdpSGbw+CAeYN6u5eWbbjY2pk6Mj1VSL8ugU=;
 b=TRVj0SwuTct4vPiQ8tXJPEPtt7sNWVR598Vp4rbCReKmgoIk5ZMyUMwluj2dSbwT/y+FCJVya94Y9kr8Q8BXt5pLZTqghUJ5MuQa1+OX+OOGkR5DLuECDlI3RMENQr10o/o9RhctgZQ9ypJVY0OhOpD65NkbQ/9YJn28ErGsHpvRyy402A3tBo4vkDv3/DtxHoJdpLOAXfYjUVlGPMwrR9iETD12bqkA1mRPO05BBxIej0G3OnfGbJogzaTJda7/RigujicFvDZpGZB+YChPSPHQheWjyg6fg5ZHeYTNa1tZxoTklElE5O0OjPxDy9tgsIqdq+lTcDqcL+s0QfpK4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8665.namprd11.prod.outlook.com (2603:10b6:8:1b8::6) by
 MN0PR11MB6253.namprd11.prod.outlook.com (2603:10b6:208:3c6::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Thu, 13 Mar
 2025 13:48:15 +0000
Received: from DS0PR11MB8665.namprd11.prod.outlook.com
 ([fe80::8e7e:4f8:f7e4:3955]) by DS0PR11MB8665.namprd11.prod.outlook.com
 ([fe80::8e7e:4f8:f7e4:3955%4]) with mapi id 15.20.8534.027; Thu, 13 Mar 2025
 13:48:15 +0000
Date: Thu, 13 Mar 2025 14:48:03 +0100
From: Michal Kubiak <michal.kubiak@intel.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
CC: Steffen Klassert <steffen.klassert@secunet.com>, Herbert Xu
	<herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<kernel-janitors@vger.kernel.org>
Subject: Re: [PATCH net-next] xfrm: Remove unnecessary NULL check in
 xfrm_lookup_with_ifid()
Message-ID: <Z9LiE45pxSXFJM9H@localhost.localdomain>
References: <2eebea1e-5258-4bcb-9127-ca4d7c59e0e2@stanley.mountain>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <2eebea1e-5258-4bcb-9127-ca4d7c59e0e2@stanley.mountain>
X-ClientProxiedBy: MI2P293CA0012.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:45::10) To DS0PR11MB8665.namprd11.prod.outlook.com
 (2603:10b6:8:1b8::6)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8665:EE_|MN0PR11MB6253:EE_
X-MS-Office365-Filtering-Correlation-Id: 318a1f09-1bd5-4fdb-cd1e-08dd6235b40b
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?HtqB9Mefx7K8T/BiLeMp7PX8pb0iKuEhTwXSr1LPVTsKmGiyQRQ86+qnrb5C?=
 =?us-ascii?Q?jvpTyuyb9RVBxgZtD/JNM13Q/VkQdcQx4qLfx+TDTGeX/i7UuTNj8czDtVCO?=
 =?us-ascii?Q?mBTaGdtlM/qRcy0A3YeD3VqRTG/wg6+3khsjSzQhu9dAOfAtBVI2/B9EABZx?=
 =?us-ascii?Q?Ze2sDQXJz8DCsue0C7nj3dYmFo3CA/hKQg8GsX9XVbfWba9/bj2UMnM1qIFs?=
 =?us-ascii?Q?QktuwaxzldW63P2A7JqYH77KCO6kKtR+fkY7ImKlFyjWCP/rFXIdaHRjma1m?=
 =?us-ascii?Q?kXhdRNbw5WalXN0GedebFC+zhYASWuicbbd6Jc677Q3bAtEtv55eCQmxyw7b?=
 =?us-ascii?Q?5aHLg9Y5DsPd+aRvWAjJKnN2EacaQwLV3nSnNDj7a9qIbLpkAEyhfQPIjvcM?=
 =?us-ascii?Q?/GjR8ZqXUcpX/SqDwHLZH9ZLRo2xohWvmupCfMOXvZpZxhjKa/w7DFRDFzpD?=
 =?us-ascii?Q?KDAoWX0S8jyoo5TYc3UmfzCyuvgdG6EQUotSqdypeGlGUxzQHA/6Xovz6Iga?=
 =?us-ascii?Q?ZORVw2s/YEHk/wYf+az2zZw6I9m5L/7c2ZPz63/Xsi3uQuW509bXZeH6iN+U?=
 =?us-ascii?Q?2vJHAxEmjbAnmC6ll538ApSDT0Q0Yilj0Xyq/wzbCXO7KHUwKE05APKze/7c?=
 =?us-ascii?Q?Yk3hEvpqU+hBizL+AkkcFdk2X5Ki6Gq70x1JejcL5QlXsEjbWaoyV/bkx0LV?=
 =?us-ascii?Q?g92iFPY218K6a0zPA85Mh+gOmuoFjEv3+oV9RlKxiCxKsppY70cxtz6i+CZC?=
 =?us-ascii?Q?7/z5JmUM2JrYr+ZkDbjX6RKicIpmePoUv8/CLDBp4U2QTDJRGhJrhuV1lLbn?=
 =?us-ascii?Q?Yqbzr6cVT7k8rkYUsW2R5n2vPYrIiGg2PJ5m8vhuuT2JCIeMg6/m8LGfF9V0?=
 =?us-ascii?Q?7waT98ZTNcs2cpz4KrXNSWuxCNwoexb9C/olnCM9TgC5GYduXPr/BmKqumIx?=
 =?us-ascii?Q?C+YeRdk+UnQ3+uvtdLS5inayxNVAE4gfj3ucYHDDbYkwOiqmZcG64GLmtehW?=
 =?us-ascii?Q?jBT4gpzlg2czDNQYtRVDnWmjBy9XyHZdgYm0Ky/YK1xRKgVBOV8vE70LDklX?=
 =?us-ascii?Q?7mtpuiC+yTEXVOpYAeEdv0S6ZtMDpoXQAq4Zhb8uKPuIkKc7RpyVTqPcXlzv?=
 =?us-ascii?Q?5bhieCnunJCeQzf5X5p1Xg9o4Iax7gXYK3agvTIWJPQUgNckeXr30L6glbLA?=
 =?us-ascii?Q?klhVmX4qghxvwBWFI+6R+mk/5zg8fhsjZfWWR0GqMKHoyFWNlcUpEdkzlXUL?=
 =?us-ascii?Q?prbNthdKgHrGuI/3nM9MGLCgfXsxNJzAx7ZzRoYwcL8a1zwKTPmD1SGcul+u?=
 =?us-ascii?Q?K5rYuTzuSj1YnV9u1zwnZ9KTMVYYKSlmkk+FdaHG55qMVgnMeurx3KTpU5qJ?=
 =?us-ascii?Q?6fAO425/lbiKKdcsiWinJqO29FkY?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8665.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HP1R3H6YIdY0WxQ/HaF7RhO95XGGs6o1ABdn6Pfa27F+n1EYTC3b1Hou0W2Z?=
 =?us-ascii?Q?AFtM/j7gJxLW3CkK5aPUMmAL4tzMD4uN+vY89xFUPus6EPJTWV94HBwqfR/B?=
 =?us-ascii?Q?xCknMms6kLatd3Um9uY/VAcg9yPc3EUDgCfZ6+0KyD/rOfwa59UarjUBEVwE?=
 =?us-ascii?Q?e9DyvehAG8puOg6NDdq+AnsbWCkINXufY7u5YE/CHjE5MtG9BBvh6BGoxC9v?=
 =?us-ascii?Q?O0hqmjxl2g/XjzKi++XEqPEMgUmEIZsDdAuuI5INL7aQ4Ov9hN/BKSJAj+DN?=
 =?us-ascii?Q?j0armad5DhFV8p+BMOm7pvIZLaz4cSUqRhA85GgwsUc2W6UHfb4vQ6jnjVPx?=
 =?us-ascii?Q?2J7mlqn5a4OE8vB7LtHG+Pd0uSp9ROhwXRJVrGFYVJsgIYBsSUT3bjtSR+K1?=
 =?us-ascii?Q?KwCs+GWbbRoDZ7HxGX3TJJC/elrcX2VzioiUrgELD/lVGOnd1RP6eIRaLwia?=
 =?us-ascii?Q?vrUOmXoFOqku2KI6eazWux/d8UNm1h3v3Lpovnq//6tliXMcUhBJWhdA2fRM?=
 =?us-ascii?Q?x6vXIU+RlUjFupN9tBC3CrOZnzsSo4mbI31tzewRPkH/0oI/Uj+7vDntCAbI?=
 =?us-ascii?Q?6KnOJsVBy3y754oOD4uxLT0Y+Ek2kd4m8l3uyLMf9UaaUaC/0PQNsFg3Vpqs?=
 =?us-ascii?Q?g4Si/HasnuMAQvgQYzIgKwfA4SoO5anztzEciVudctOAY3oUhFD0O6S/hi/n?=
 =?us-ascii?Q?wuEKSD1w29n3NXCsk9S5uuq2D6EZo6boXfhnn5c6SSix74jkuprwaZaAR5Ke?=
 =?us-ascii?Q?lQ9eEo9ZKFWSXCuKO47/gsYeOHA018bc893lOHCLClCgXMRn3oxHfPCzAdsS?=
 =?us-ascii?Q?m2OXMxn+ybRQe2wwYqNEAqN2BbOdTpOpSFv4KqSddCswFNdI3x8Qlt6qoGpa?=
 =?us-ascii?Q?JPllmwxp/38BUxdO0ukDyWu0h0Iaea8HDk0wPENE1ygfg6S/SqmEisuIWtZK?=
 =?us-ascii?Q?OEt7+mWVvcvDkgUeQHs41d8HkMWXsI6DkO512aJj7SMsRurN0oYwGEAdUSMs?=
 =?us-ascii?Q?XHFtJAHJPQoVzoozJxVLGg2RLhrGHqYp6pG7+Ya9MP5+HFdbZYOlEqpTtSHZ?=
 =?us-ascii?Q?a3MaVVQ4UipgsC9hcfo56IwQgNd2s6tEahHb5p7lnO+28chXtv6ytxKcIwZo?=
 =?us-ascii?Q?oU/giO2O3wj5iwwT4ek+TSHmxPqt4QGJVePK2xBY4WXkEjK5Zh6HIhiaf5Wi?=
 =?us-ascii?Q?Cj95Y6tWwH/LF8Gj7nUj2RgtYG+ouNjY511lW66/B0Ck54J9Qm2pwdMt9zmY?=
 =?us-ascii?Q?90/NB7lFsqcwA+6AnKKbxRJLhzjzJapTMegNVwTghiKPqccmG2mkwrn/JYo1?=
 =?us-ascii?Q?MuLLbcelh3m7NwB+jW5nDSsdAWXUt0UxVTExWMER4mfCvTKSmUFDpJIacjN6?=
 =?us-ascii?Q?ifO5vgD6QqPCXarYWjrjogIjQWSATlomPV0yMlwxjJFsqjOeMT91epMmYBJ7?=
 =?us-ascii?Q?4niUVT0zus+ks4IEcM3nnpOh/WQIajLx8vga26CUpiD4fXAE56E4CTi3KFkU?=
 =?us-ascii?Q?GRZJCmwIGEzMDz8bqU4cD1LijxRg9Yavmo4Ps+OuNalq9LadRmmVqlBmH3uJ?=
 =?us-ascii?Q?q3m52gGXjD/poj+oTrtZcUxQLYev/dqIGCDH2ZkrqTpX1nzZUwOvGIwPfA2c?=
 =?us-ascii?Q?jA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 318a1f09-1bd5-4fdb-cd1e-08dd6235b40b
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8665.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2025 13:48:15.1177
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zWgsWRpGFn/IVpoaBLGpKC0/l/Hvg1/7L0+MrovFtbK+aXsqDSs61TY86yqmQmynQuqtz9mzu6/DW3DHcfJWfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6253
X-OriginatorOrg: intel.com

On Wed, Mar 12, 2025 at 08:21:13PM +0300, Dan Carpenter wrote:
> This NULL check is unnecessary and can be removed.  It confuses
> Smatch static analysis tool because it makes Smatch think that
> xfrm_lookup_with_ifid() can return a mix of NULL pointers and errors so
> it creates a lot of false positives.  Remove it.
> 
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
> I have wanted to remove this NULL check for a long time.  Someone
> said it could be done safely.  But please, please, review this
> carefully.
> 
>  net/xfrm/xfrm_policy.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/xfrm/xfrm_policy.c b/net/xfrm/xfrm_policy.c
> index 6551e588fe52..30970d40a454 100644
> --- a/net/xfrm/xfrm_policy.c
> +++ b/net/xfrm/xfrm_policy.c
> @@ -3294,7 +3294,7 @@ struct dst_entry *xfrm_lookup_with_ifid(struct net *net,
>  
>  ok:
>  	xfrm_pols_put(pols, drop_pols);
> -	if (dst && dst->xfrm &&
> +	if (dst->xfrm &&
>  	    (dst->xfrm->props.mode == XFRM_MODE_TUNNEL ||
>  	     dst->xfrm->props.mode == XFRM_MODE_IPTFS))
>  		dst->flags |= DST_XFRM_TUNNEL;
> -- 
> 2.47.2
> 
> 


After analyzing the function, I haven't found any flow where 'dst' can be
NULL. So, it seems the NULL-ptr check can be safely removed.

Even after jumping directly to 'no_transform', 'num_xfrms' should be
less than or equal to zero. In the first case we'll go to 'error' and in
the second case 'dst_orig' will be assigned to 'dst'.
The only doubt I have is about 'dst_orig' itself, but the function seems
to assume that the 'dst_orig' parameter is never NULL because it is
dereferenced at the beginning of the function:

	u16 family = dst_orig->ops->family;

So, it shouldn't be a problem in this case.

(Probably some feedback from someone who has an experience with this code
would be more beneficial).


Thanks,
Reviewed-by: Michal Kubiak <michal.kubiak@intel.com>

