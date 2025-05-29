Return-Path: <netdev+bounces-194142-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 48103AC7725
	for <lists+netdev@lfdr.de>; Thu, 29 May 2025 06:28:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A95641C02669
	for <lists+netdev@lfdr.de>; Thu, 29 May 2025 04:28:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A38282517A5;
	Thu, 29 May 2025 04:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="d6cs5HN1"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D209F2512EE
	for <netdev@vger.kernel.org>; Thu, 29 May 2025 04:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748492890; cv=fail; b=F3l+KvGpvY6Y+qzhiHXNHgfT4MYXtLjKmF7vcenW08jk/czAN4YH5i+g1TNJUrmsB0fVia9D3FgLJO7RnKiqAM/N4TNRJSBxI3mFqAzaRlXHYsokmrZ52ezxjym6hlI3GWyh7fJeNeNq6WHAhgGMUoB944aPEBLTigc7ep6/i+U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748492890; c=relaxed/simple;
	bh=Ep00ImpEsDQYTglKw1BQo5JyPb3WbgFmCUAizqh7I30=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=nKO2VqJhVoctTcHqmf0JmmR/f/ihG/u51OJgc5wURzD8VQeavngv7bcgZtnZedzxy1XUo/m1wswZnJ/I2ymrQD3p/3BmAfTJibS6aqGmgdtAsrTjpe68YI/xZHX0Qa44c7i4Jocx39KAjG/ErgBMhvEd2hyJ6pF5rNZHhl2uNsk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=d6cs5HN1; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748492889; x=1780028889;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Ep00ImpEsDQYTglKw1BQo5JyPb3WbgFmCUAizqh7I30=;
  b=d6cs5HN1yDKS4eKmGSA7MWzxuKIvIe/2kuqE677KtjteXWpn8N3P02Cs
   WaQ5HVc3XfLqMWxnVnSW4UwhcSvcpJX1EZ1HfDReIKvRHW+wSs14UVxAK
   r4rCDtBl94gadF04ytoxj7NpaQWWW7QhPBjkKXzu5lzPXAsd6BOWgTZKb
   4jQ3HItytry3wKJOeR7mdAX4t/R0zSf8CizakblAlltX3PFhpAgugOUXr
   NEVEdVnL9ntJH4cIGTJYl8nyIq+rHadVNPeJMAGOOjPIl5muVAztneKzi
   fdiUvOrVcqdVM3KETqJX35supMdoA9jCkIymYvMrv2xkJNwL5yB5WN8FK
   A==;
X-CSE-ConnectionGUID: 0/QGcyCQTaK8J+2FkmCS9w==
X-CSE-MsgGUID: cyATyDsDRT6dQtlTPubTBw==
X-IronPort-AV: E=McAfee;i="6700,10204,11447"; a="49786871"
X-IronPort-AV: E=Sophos;i="6.15,322,1739865600"; 
   d="scan'208";a="49786871"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2025 21:28:08 -0700
X-CSE-ConnectionGUID: lN9lPO2ESn67iI53StvdDQ==
X-CSE-MsgGUID: 2WBpffj9SjOs6fp6IABAMA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,322,1739865600"; 
   d="scan'208";a="144078036"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2025 21:28:08 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 28 May 2025 21:28:07 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Wed, 28 May 2025 21:28:07 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (40.107.94.64) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Wed, 28 May 2025 21:28:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j8Pzd+ayUcCEtDl4B9h9760XjOP3+Dsir/bgqPcdbAogOK8J4w7jPOny86bw0bXqmLchpvqi8HSvalCGPGPuxdy4reLSadwsd9GRRZb7KZo0OBxS6Xe+vfFv5/Nf2PfaiKYnC8yfhqHvCiRhhRgn4RU3erS5tNfYGRZgJnj97xq5Iq0ybFMkephbx8IxlV/kmE+SfYvMyzaXkREcCMT/MsKdAMKWytkZJnYG/X5i0tsS2ISm33rSmyPLshpezWirLTAHWJgvwYMCaKFMZC9DxsARwGcrbwEiIJFfZvwbCFUxLXNoPzCG856OixieuOWcXc1vCDhVnn25fNl8seFK8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l7N15GkZ3RFZHactWadw6Ttx5vq1Jut7yKOqoDCYaQg=;
 b=FjCeF2BAebAvEMd2nLyg/5BW/yWqXMyXU91rHvyzt+VasEEMFdOT8zP1CEY8ODjllXfW3snVH6aMIgr6i8R3ImsTwTE6MGzSAIVKm9HEA//0oqjhyQy3PsMaUuHTlT0ifzrwdx0AOiAdrDLQnuXnBNfqqjg//9KJD4SC9bYvw58V5hpD/brIl25yQch3urF0KmngNPiRe/If/okqYA8izluXIWHuqyt7gmR3thIzPYkWVmBXtSLLqFPHlXmRSM/6LZ90ZMEuzYx+ZdqfM5LMci5A8P98zLuu8PABbeKCARMXmnTbd0Hy68+QDtvJP5g+XXzbWXE80OKtufGk5Wv8tQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB5674.namprd11.prod.outlook.com (2603:10b6:510:ec::10)
 by SA1PR11MB8524.namprd11.prod.outlook.com (2603:10b6:806:3a9::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.26; Thu, 29 May
 2025 04:28:05 +0000
Received: from PH0PR11MB5674.namprd11.prod.outlook.com
 ([fe80::77d3:dfb2:3bd:e02a]) by PH0PR11MB5674.namprd11.prod.outlook.com
 ([fe80::77d3:dfb2:3bd:e02a%4]) with mapi id 15.20.8769.029; Thu, 29 May 2025
 04:28:05 +0000
Date: Thu, 29 May 2025 12:27:57 +0800
From: Philip Li <philip.li@intel.com>
To: Bui Quang Minh <minhquangbui99@gmail.com>
CC: Jakub Kicinski <kuba@kernel.org>, kernel test robot
	<oliver.sang@intel.com>, <oe-lkp@lists.linux.dev>, <lkp@intel.com>, "Michael
 S. Tsirkin" <mst@redhat.com>, <netdev@vger.kernel.org>
Subject: Re: [linux-next:master] [selftests] 59dd07db92:
 kernel-selftests.drivers/net.queues.py.fail
Message-ID: <aDfiTYmW1mHBEjg6@rli9-mobl>
References: <202505281004.6c3d0188-lkp@intel.com>
 <0bcbab9b-79c7-4396-8eb4-4ca3ebe274bc@gmail.com>
 <20250528175811.5ff14ab0@kernel.org>
 <bf24709c-41a0-4975-98cd-651181d33b75@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <bf24709c-41a0-4975-98cd-651181d33b75@gmail.com>
X-ClientProxiedBy: SG2PR04CA0171.apcprd04.prod.outlook.com (2603:1096:4::33)
 To PH0PR11MB5674.namprd11.prod.outlook.com (2603:10b6:510:ec::10)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB5674:EE_|SA1PR11MB8524:EE_
X-MS-Office365-Filtering-Correlation-Id: 22750b1e-d9b6-4eab-af44-08dd9e6934f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?MS/k1faxc3zVNsYs+dItEWL4HBGi+JszKKVxqDNzB/lQGHIXYb4jO42hVHhW?=
 =?us-ascii?Q?wlB2t4oyqqSAxyynGhF00sG4rpxadaXi3BdqiPhiO7+fz2YQfhvLQKA5Sm1i?=
 =?us-ascii?Q?fP6ExFmmkXB7bPSv6FxTRxox/mpDlLuJzSqe3Xtx5/44hpW56FiwlnmKX/hk?=
 =?us-ascii?Q?Jdzy6L2QLpWpODTsjPzO61yluPtCbryiUGOYK06uvZ9IZt7X7sdY3z04TaxP?=
 =?us-ascii?Q?vFTZcY7Fl804hIptK6czDF/DGEuFw63rnrfr75y/ALLVDBT7uv3EEqWHeHWW?=
 =?us-ascii?Q?zjb9bj1RcRsbUXTFDn44syHuViwmxVpDYDyZaU54WRpHIEvlVMxwoyj4JKyB?=
 =?us-ascii?Q?bkN9YE5qBd7YqjnaqcDh7ms5JXP0Fve4ipSh2/JKp5vnFYU3X+EFKZGbsq/8?=
 =?us-ascii?Q?YEofFXOnhDBAZN0AElj5ZZFzFfMvNVkV0k6Uo9L6OlUsuFOBasBbTBD2i8ku?=
 =?us-ascii?Q?ShReDhMfE/ew152o+kG4JLZa+xbF40toeud/sy/HFi+bfteZVEpOuh4VE82O?=
 =?us-ascii?Q?Ns0viaXZBcuqKVhkPSBIsHs0NIHH60tnZNuj4JmOviOMu8gJtkrCdMaloWaH?=
 =?us-ascii?Q?qLydbPatOcuskAPxOg9ePtnSXTy46iQg2l55alp52Njd3asRrTZy7ATVnCnO?=
 =?us-ascii?Q?xTbtCKudd04j/kmg4QRIQR7whMKLNigLu03oSF2azl93KrDqigLxaXUyDFxK?=
 =?us-ascii?Q?uLs8i2e/L9gog+d20JSAxsxxQ3RMB9zKrC89lJAKrFStciOC19l2sf6ygeJy?=
 =?us-ascii?Q?tAl/WqPMLFnNsV0L7EjZBbJLzLURZHS0VZDxVf/ZcmGYUFdWv10rfo7yPXVP?=
 =?us-ascii?Q?9ssMKyQr6hWj/93MB36pBkddxvBavWGLyRKwQD3iQ4wB5PRgkjzbDSNZ44pv?=
 =?us-ascii?Q?XH0qj55ocImEc0Q7375P6SQiZ+9+e6c3HEJym+ZzkbN06KKgGxEG3srxZNjo?=
 =?us-ascii?Q?hg85sKmPh+l1wl82x/iGgMI+JIHOTnCYdvoUPgQ2pTgv/y0hKaxagfUp5c8w?=
 =?us-ascii?Q?KpY8imqJJixRuYdL6yWF5hv7ocT7dWG65hdjHQle8Bu5bz/9S8U85ermjWwV?=
 =?us-ascii?Q?zvx3TV8xGwr0JR3qnorgtgnjK/9D+0MuuKCBuQ0eJ8CTPWnmabL3iPwZ+DT7?=
 =?us-ascii?Q?VXZ5rnmbrIw/crcfnBl4xver1qWspj55t137SKbJXnMtHCmsJj2Y1fFBD94E?=
 =?us-ascii?Q?IEbDP82UQHUSloC5Bp2MCJg4V9v3U1HySYwWUcTAPqZk7zkZlUnyqgt5g8V/?=
 =?us-ascii?Q?dl1K3p9MFfk8XsMpCSUZTjA2PVIO+MltXx5Hqtaxf6q22orBHLQjaTf560wJ?=
 =?us-ascii?Q?gQ1yhSgpEiovhSsYpIpKHCSFxbpGPjeDwXTbrpvfeQPBFxocVuMQuIYeNoql?=
 =?us-ascii?Q?Jv0qb4j38knjoCi91fiVkh4503oF?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5674.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fC37UlTtpDRYcU2mVrV0i/NprBrOS9qTj4YYiA0hspfQN9i7rhR+Du953vVO?=
 =?us-ascii?Q?Xvy3tTDCdjrN5YpE6x48FaVVOZVQFcUuT/o6lSrJpQAopB3Fo5EKhGnppSAW?=
 =?us-ascii?Q?jzfvMAI+hNBSeZHhuQ+kIGFzHHf0+EVceNSoSH3VE4YKHxYQ4QGVpjE6xv1v?=
 =?us-ascii?Q?gLQH6ZmgCS6pR9Mf/bHTdHiIZFIDRQQmgpHZbzRR+B39CV7+FWvZx/sV9afy?=
 =?us-ascii?Q?oLVvSHyg9QF7UIXvb18xg1Pu74L7TzsRccwmlDU42PU1Gnl6fmA7qnys14Ks?=
 =?us-ascii?Q?xOCfrDJ/6cSjlTF4dueDhTMAkrsulD5akJKzZRHgwws/nNEfccZgpWE9aBz6?=
 =?us-ascii?Q?JkNmo6AgTle2Hinjxh/P5BRaxT5kmxrUrpvpJsHDOywR2ApCL+R+ahp9PR/U?=
 =?us-ascii?Q?aN9wYywu7GE4nM6aHWAwI09IQt/62JgoUse06OkYnIfCjGPkN05SFzDJU2Pp?=
 =?us-ascii?Q?CQo6yJK07I7+meGXojEeDmi7AXI77OYgN3R0nSazEqEyODQGWivYWi2IUq81?=
 =?us-ascii?Q?i2bwkPEpGJjNgdWJ0RWHgobawf8Tf+TjgbIK4g3xIspqkNlZA8Fl4P3RjfZ5?=
 =?us-ascii?Q?+lta8yYFzYMYekKYh0Ti7VzKZTvCknVOkAtLgCx1u03UTW5baNK4UvbL2qce?=
 =?us-ascii?Q?JYmBz7SJtXsCsYPl3Rys4GPtzMgOuRuE4TjLOKdb1aX8XEXQNoCe45WGenHc?=
 =?us-ascii?Q?5CUl3U04gDdxpk6EzrtzlS579y323n+wa3L2+jDNPeWFoOqUB1F589dcDllE?=
 =?us-ascii?Q?W4QQzotRUwFZXxTaHjS08XIoPuzIX9z1MOKrPAjFwO7yqUNQicDGnY5igv0V?=
 =?us-ascii?Q?/4CCD7znpnLR7WxJvY2a8Y7H9SsHI+y1DyAHHSnbZuIED2KVACiW6e6a5oXp?=
 =?us-ascii?Q?xlLl6N2qHy3i+dJr3HIS9YuBw/ZhCa9rUaI4qgai6A2iYUel/1kV3qw4aXbH?=
 =?us-ascii?Q?6wBsJ9B+VPti5fAd3IAnkRyYmimjke77ALpgNsegH9gargArlO5fSIVEQsVq?=
 =?us-ascii?Q?6KdwuBjVKpVlJstL7b5nIOSorb45tdX9QMndnjIwiwoRTahAEZqTuQj0S/2m?=
 =?us-ascii?Q?tu8RXpdas6f+Z3Tumlfm1WAGmb3QLFWF1L5pE4SY/LWBE7LqxhJEB95WHjoD?=
 =?us-ascii?Q?C1YhDodaZT0EIvj3KGd6+ZLFQXTmY05dYiv9+mwm4bdZMGv8Engc3+3qb57v?=
 =?us-ascii?Q?M49+rD811XyD/E7Nqzo+EiMuqbsU52CHeEcKQK3ZReQsPAviKLAkm8k67hRM?=
 =?us-ascii?Q?Y10tnKM0GkiN+/7JfYCrG0TD5s1LeelSGNXj5gdBx8kKfqv/iqTLKOXjiOGR?=
 =?us-ascii?Q?SaOD/ZFp0fzOzy87iA2L9rPP64IqBRn1a8ehIy2QSH01Z62P7yzKoR0eN6xP?=
 =?us-ascii?Q?KpjMA1A49hcJ8EorwYZ+MbLk0VwV/jylExc9l+FA9UP26cEfkGy4oNf9pfHh?=
 =?us-ascii?Q?jBDYjCgsKnWsJV6KPgav3dfcCLp3oyzwSCH/8hvhEIeX/7umcdgvbEfPyYpD?=
 =?us-ascii?Q?PbIv7pH0EGAlrMjao4i96vfH9838GDYyo/Ldk4u6Szqhtn4+DkZbbnEoyU4o?=
 =?us-ascii?Q?ksByQ95bXbY1DovuAPbVUkaY64ODA3FwChY588RU?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 22750b1e-d9b6-4eab-af44-08dd9e6934f0
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5674.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2025 04:28:05.6386
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m+X9tZtWUCL/Wkq1ihxoDZtVMdrLyMdmF+cQcD6t0s80Cw4GfrP46bQyndJL5a0SUSmJV1zf/ME1+R18uBTkSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8524
X-OriginatorOrg: intel.com

On Thu, May 29, 2025 at 11:06:17AM +0700, Bui Quang Minh wrote:
> On 5/29/25 07:58, Jakub Kicinski wrote:
> > On Wed, 28 May 2025 15:43:17 +0700 Bui Quang Minh wrote:
> > > > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > > > the same patch/commit), kindly add following tags
> > > > | Reported-by: kernel test robot <oliver.sang@intel.com>
> > > > | Closes: https://lore.kernel.org/oe-lkp/202505281004.6c3d0188-lkp@intel.com
> > > > 
> > > > 
> > > > 
> > > > # timeout set to 300
> > > > # selftests: drivers/net: queues.py
> > > > # TAP version 13
> > > > # 1..4
> > > > # ok 1 queues.get_queues
> > > > # ok 2 queues.addremove_queues
> > > > # ok 3 queues.check_down
> > > > # # Exception| Traceback (most recent call last):
> > > > # # Exception|   File "/usr/src/perf_selftests-x86_64-rhel-9.4-kselftests-59dd07db92c166ca3947d2a1bf548d57b7f03316/tools/testing/selftests/net/lib/py/ksft.py", line 223, in ksft_run
> > > > # # Exception|     case(*args)
> > > > # # Exception|   File "/usr/src/perf_selftests-x86_64-rhel-9.4-kselftests-59dd07db92c166ca3947d2a1bf548d57b7f03316/tools/testing/selftests/drivers/net/./queues.py", line 33, in check_xsk
> > > > # # Exception|     raise KsftFailEx('unable to create AF_XDP socket')
> > > > # # Exception| net.lib.py.ksft.KsftFailEx: unable to create AF_XDP socket
> > > > # not ok 4 queues.check_xsk
> > > > # # Totals: pass:3 fail:1 xfail:0 xpass:0 skip:0 error:0
> > > > not ok 7 selftests: drivers/net: queues.py # exit=1
> > > > 
> > > > 
> > > > 
> > > > The kernel config and materials to reproduce are available at:
> > > > https://download.01.org/0day-ci/archive/20250528/202505281004.6c3d0188-lkp@intel.com
> > > Looking at the log file, it seems like the xdp_helper in net/lib is not
> > > compiled so calling this helper from the test fails. There is similar
> > > failures where xdp_dummy.bpf.o in net/lib is not compiled either.
> > > 
> > > Error opening object
> > > /usr/src/perf_selftests-x86_64-rhel-9.4-kselftests-59dd07db92c166ca3947d2a1bf548d57b7f03316/tools/testing/selftests/net/lib/xdp_dummy.bpf.o:
> > > No such file or directory
> > > 
> > > I'm still not sure what the root cause is. On my machine, these files
> > > are compiled correctly.
> > Same here. The get built and installed correctly for me.
> > Oliver Sang, how does LKP build the selftests? I've looked at the
> > artifacts and your repo for 10min, I can't find it.
> > The net/lib has a slightly special way of getting included, maybe
> > something goes wrong with that.
> 
> I understand why now. Normally, this command is used to run test
> pwd: tools/testing/selftests
> make TARGETS="drivers/net" run_tests
> 
> The LKP instead runs this
> make quicktest=1 run_tests -C drivers/net
> 
> So the Makefile in tools/testing/selftests is not triggered and net/lib is
> not included either.

hi Jakub and Quang Minh, sorry for the false positive report. And thanks for
helping root cause the issue in LKP side. We will fix the bot asap to avoid
missing the required dependencies during the kselftest.

Thanks

> 
> Thanks,
> Quang Minh.
> 
> 
> 

