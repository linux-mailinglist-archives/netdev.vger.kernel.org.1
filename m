Return-Path: <netdev+bounces-290333-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UK47Fs7dDmoVCwYAu9opvQ
	(envelope-from <netdev+bounces-290333-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 12:26:22 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CE965A345F
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 12:26:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2FC033018A0A
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 10:08:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7778137F01C;
	Thu, 21 May 2026 10:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WP+xosli"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 057492798F8;
	Thu, 21 May 2026 10:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779358086; cv=fail; b=gB0Hf+qJ0ddaongbVOY5EYwp8QZIISljLFw1SA5Bp4VfCXYNHHJgqqc7KJiH0tHdVGVt18snuoP6tomtFaqCn5VyK7QdEijlOTfpptQKCsP7L3+qJ9ovM9sYsqn1pT5B8orKhosHtwH2U+NSj4XSV78c/aL7084CA//B7IPjj98=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779358086; c=relaxed/simple;
	bh=pyvmrYKJkztDg0UvQv7FqmiRR/e/+nYaWlmCi7XkO5g=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=X5GLwq7VD3SOl2Piw76SdZ4Nz+R5/Je96AMUE2HwY7KjCR4LDV9SCVr0Dgwt8TaeoZzUymxomNDk8GgEAsXiYrI0llbP7uNbezHRcwigIIrcWhnKN7XeK4oAk9g6mix2W7dad3VxU+TwirUBI3PrqXAln+ISmf1Uaupzcdd0EzQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WP+xosli; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779358084; x=1810894084;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=pyvmrYKJkztDg0UvQv7FqmiRR/e/+nYaWlmCi7XkO5g=;
  b=WP+xosliIu8bG5wiUMINeJzTOqpVcfmU9tDnw3dEQOhAyASPM1+0Fdmt
   Qa0DU7JQPK2JnQhLHGwv9UZBoTFEZxavV8uXBtqgT31p0bPujdhQHqTSu
   Ak5YSqtFIPQt38elfOWBRlu6B+c6JGLccnprJyVASofuuEmsfNL2LtbQI
   sCs1medREf9OxQ9pDvbz9iRvMukSjtLQ3y9QrrMU1lAfMApZST7EbXVwY
   30w62TL1FwMDWV7F6SRcSndBZQOeDlNOsfEH+wB4jbDSespFRHnxry2tO
   wdESfn0g1xxtp5B3OpSCXwMp4G0+QAslg2No04Irylybn22e8Nc0fNZ8+
   g==;
X-CSE-ConnectionGUID: OvukMNi9T6GGmKbr5K6CNQ==
X-CSE-MsgGUID: 6rB0oHQ0Qc+Ne6uBE294xw==
X-IronPort-AV: E=McAfee;i="6800,10657,11792"; a="91665412"
X-IronPort-AV: E=Sophos;i="6.23,246,1770624000"; 
   d="scan'208";a="91665412"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2026 03:08:01 -0700
X-CSE-ConnectionGUID: +Vs6si/ESI2sAc5cxob64Q==
X-CSE-MsgGUID: IDiL8BOPRHO15TtULTMH7g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,246,1770624000"; 
   d="scan'208";a="245473935"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2026 03:08:01 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 21 May 2026 03:08:00 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 21 May 2026 03:08:00 -0700
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.71) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 21 May 2026 03:07:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iCPE5+G1AD4veqVdq811JKGngSzcqI/a0MfBFBbZcb8qumInGsSU+oh+0kM3fVE7xm41ZvPCrfeaY3MRRA2k+cfgdf5Y4exq0Ogo1cWV3aVUKJfHp032a/vlHIHCfds6nX8PzXj7z86bP8XL2JWRnzKxQ+jtoEhCbSkxdW1CCEIscf97PDBfUAzLz8TY4+scG83mcS9hsgGOtxJooOtNE1doTuuHhZB0rQ57BB6UlQiC2lEA6bk/xGCmiq3Hg6UTCWaC70KcfAnGrJmF0OT5IWpIpu3RtIHZyMsiNfeyHgKtCNz76VRZJdC8PXyNvDGqbWtqLvHr/4LbTg9RfHA4qA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=czMNpoqoV83yDccazMCe0MYRZrsMYaIXo3qwplEmnrQ=;
 b=imOEGjEjeNJOXolhTuhk8Sl+0HUadU7Rku7nURamDcOraGVAYvRJNtdjwcPsTn/jbqhzZB7O2tbEezQzECbKKN7/udnhFfBYtPGzJ0UcegaD9PC798rD+ceVUfkSNnkpTJkhP3Nc19oAxrqxZSNkwHLJioWP4iWf7tdU1ubPGVDgQaQTpefCmlIKBj8gMNAbdryYw6UVx2XzJkkv9O9kkrZwZzGyWfa7zph7IAgryxcLdxTHuSCEbdIYaEfhf+rdiFFe4gLOGMFPztWiJ9/Cw95qFhRPiOwht6Xxxoe5xIoqcFa/F3ULGCQZ2ttVuE+kitdTJTfSmsMnlR59K7gSaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB7540.namprd11.prod.outlook.com (2603:10b6:806:340::7)
 by SJ2PR11MB8500.namprd11.prod.outlook.com (2603:10b6:a03:574::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Thu, 21 May
 2026 10:07:51 +0000
Received: from SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::2edd:5c6d:169c:389b]) by SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::2edd:5c6d:169c:389b%6]) with mapi id 15.21.0048.016; Thu, 21 May 2026
 10:07:50 +0000
Date: Thu, 21 May 2026 12:07:39 +0200
From: Larysa Zaremba <larysa.zaremba@intel.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: Tony Nguyen <anthony.l.nguyen@intel.com>, <davem@davemloft.net>,
	<pabeni@redhat.com>, <edumazet@google.com>, <andrew+netdev@lunn.ch>,
	<netdev@vger.kernel.org>, Pavan Kumar Linga <madhu.chittim@intel.com>,
	<przemyslaw.kitszel@intel.com>, <aleksander.lobakin@intel.com>,
	<sridhar.samudrala@intel.com>, <anjali.singhai@intel.com>,
	<michal.swiatkowski@linux.intel.com>, <maciej.fijalkowski@intel.com>,
	<emil.s.tantilov@intel.com>, <joshua.a.hay@intel.com>,
	<jacob.e.keller@intel.com>, <jayaprakash.shanmugam@intel.com>,
	<jiri@resnulli.us>, <horms@kernel.org>, <corbet@lwn.net>,
	<richardcochran@gmail.com>, <linux-doc@vger.kernel.org>, Bharath R
	<bharath.r@intel.com>, Samuel Salin <Samuel.salin@intel.com>
Subject: Re: [PATCH net-next v3 03/14] libeth: allow to create fill queues
 without NAPI
Message-ID: <ag7Za4d6xXIJjg8-@soc-5CG4396X81.clients.intel.com>
References: <20260515224443.2772147-1-anthony.l.nguyen@intel.com>
 <20260515224443.2772147-4-anthony.l.nguyen@intel.com>
 <20260520184922.34c36c74@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260520184922.34c36c74@kernel.org>
X-ClientProxiedBy: VI6PEPF000001FD.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:808:1::910) To SN7PR11MB7540.namprd11.prod.outlook.com
 (2603:10b6:806:340::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB7540:EE_|SJ2PR11MB8500:EE_
X-MS-Office365-Filtering-Correlation-Id: 8de93517-cba9-4cea-2452-08deb720d0ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|10070799003|376014|1800799024|7416014|22082099003|18002099003|56012099003|11063799006|4143699003|6133799003;
X-Microsoft-Antispam-Message-Info: RAOLlXHbUMGKdV+4sgx9nUpjWcrqRW7KcUZo+Iqzr3ku9ecBH9G9UqSe2rVU1LOQ9fGpTBaiPOpLLpxrwNF/FFwzES1TTUNkj6MvgimfOQ8YO1a3ydog1qGU8JUvuFWxXdzfPVJDVXIzZFGBKhP8iS/2l8dd70bBZd12g3mm7/hSl56FHx68TaQO3ZwFAZe192rrLQFvmT8lbfdy0XdsPtxJXTgSAqS+1bgGWq0TdRbLKlvmE1yfIcv6ByEZ60EeNULL0fD8k1FhRWtnJrXo05mDvc6fSGcA2BFzKNRnvvt6s0LCt6Awa90ndYqR2JSVFZG7S1lxcB46gwVh0aJpk2AZN/smc7tGpqsbVCZ6D/nN7RDSCcJ/64Rsg5sd6uJjacG6Erp6+0c/BEilEeY7mmBuGEecKjbxy95PCJYIXLeOKIu+nodt/qyUqL44IrYbJ5oOF+6odaDinz3WWLAf9F2PFt4rcLEL2OociVp1jTT+RJyFJCZA3gtzxlfP/MrvoIJYqZDv1VYUCCTJ5HmxVhU3C3gKo6v9ZPRhV4/veiSqeLpbp03LClDhQ1yxPnOljfLV9YOyNUV8E7wbPeJMQu8pWj1GjVkzvVNEplysjgc8/cck8EtBWxdcw3JZRT/t04FvN24tRmPXSew6yf4qXJLd4TgO9/ddzHuMBDU3zcuXRiiwqfpLyTpamPHhY9ta
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB7540.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(376014)(1800799024)(7416014)(22082099003)(18002099003)(56012099003)(11063799006)(4143699003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?K87lY1urVEvc+lnsLGKkYB+3GIUVi1YJogn6oRlbdC2J3+ayvXYX5Su88gCa?=
 =?us-ascii?Q?hqE68Jf+RpYZf0i2R/LbAf+jcdse6FBfYGCM4o5d6aGR1+BbAqNTrKifYLds?=
 =?us-ascii?Q?s1aLtm32en6BOYFLIol+RJHGHmWEyaRojvbP/xSL5XpGchvfC9DQVSGfCpCN?=
 =?us-ascii?Q?0yyizGtSq/of+uoBugmtIUx5SFV4m1GkLlKvoeGVsCdHtHdtwLhYVccKahgL?=
 =?us-ascii?Q?FIDh9tcdNknycBaN+SXf95CPmipgJ82Nv0g6PUq6yLk6LBNLni8AMwiKOfEk?=
 =?us-ascii?Q?fpqrcPzks9iqPXSZaGdOBEY0DjtBzhUumV9xPiL8aMr4zkvmA9ldrVHVJYxO?=
 =?us-ascii?Q?XAk4WL3ablYir+Pn4i17fCbyFipIEG52EDxEYRSZIw+FcXAeI2+is0rYSIvu?=
 =?us-ascii?Q?gkjefr9goVWqD/7fyKiHkcDoamS20TsAOHKt66RjsmYeqBo9Giw5wA+NzdD5?=
 =?us-ascii?Q?zWRybPl06Qvtgukl3lB/ToePyQgFkd1MeSFngfad9ztFhbzlCdqp22PSs9Dw?=
 =?us-ascii?Q?LvoYv2sFO9Tz+23UzScotz1Pa22G9itQdIJvIXA9IYbJeW6OnTq24CEQZVkc?=
 =?us-ascii?Q?u/LaLhkEhd7hD9ulR6M78vBsQXiG3DdAWS8zsLGSjCVxpYRxnrFQE/WXms1x?=
 =?us-ascii?Q?bXmEJurxSxtF9+obVqx+dukyXcToNGwz1Iw9gmSdORMfzDIcxZdfnGWTpaOJ?=
 =?us-ascii?Q?5E6buTeDhvTAqlE2d8pjxX7VJ0cc1h5oKMRBs1euYekfYI9LPh2/81cH0cQI?=
 =?us-ascii?Q?yC5sQD8zBhX6Tao50RYAMBZ7SNqRcVSDwC7pA+GX7Mh7GkkFvTLJFkkNRcjB?=
 =?us-ascii?Q?UdbGNMpY3lPwfJI4qfR5VEUAePkenzhJ6OX+RqVHsj4KOsT3Dsukw3M4i43V?=
 =?us-ascii?Q?J5e4VxDCCD5y7qfNkwwhhGtnP5HcbVVDrjgY6m6/NDiqO0KHsT4likK8hGLg?=
 =?us-ascii?Q?LAPOiBgtLufVMs/aHN13YyTAxr0tuPbA5faaJfW8v7fwBYT6mWURM/kqmlw8?=
 =?us-ascii?Q?4Mg0HXX7saylDbJsRJ9zq54Wh9bJEar2SrVznYGkkozqGwQjZ4/lBlyr9s9M?=
 =?us-ascii?Q?rUfDTyMrUVEuRG6twwwCDhyIhWd45OAVvc9fETQKTKGwIpjJv2nAbxA8kib7?=
 =?us-ascii?Q?FkxGt+XO+vpzUBLrTGrkYjp9b2EF8ByR4fpAwBh7q6ra6vQZrrbDEok129k+?=
 =?us-ascii?Q?qexxkgU7lA29qrbTx+ekaJJpvILB9DJThOTOx7XbiNt/3R/U5jXNd2a3XyNH?=
 =?us-ascii?Q?2p/AQDrdyzois3b0ZDMt+vYU4dAOzcZIxXAU0nwEixkt12hhZud9raBSRf3+?=
 =?us-ascii?Q?6NoA1VZ28b1VrlCf/gFDLR4ZJpxlgZ1QW/gkzhG+944K6HXgpVCla2/nNBhE?=
 =?us-ascii?Q?ZkZoro/jja73PLoXYld8HDJTM30eddgkkRbhb/WgKUdulFKhQub/QV7Ib1Lb?=
 =?us-ascii?Q?X/btfYT/xgHS90YOMM7miUvKMwTlyE0vGqUFoxNGUFrHpR6tjN/ogJ5Xo0R3?=
 =?us-ascii?Q?6YC/dk9sQ6LLhQ3ve09aDdG0c0r4RyizXEmadOzEqryuaM1y6ZawKLq7M5D5?=
 =?us-ascii?Q?ivZsmLCcXXPUvaKAwUnY44wGBEIWlFOBrZa07qDgzfaZEotJbFEqz2s6EY55?=
 =?us-ascii?Q?YTO552gyo3LGmgG67oCDcy3s1jfrsZNcxm+c9y2Ar9ha46PDZ9qrZwh3bvrc?=
 =?us-ascii?Q?yCw3oqcxQY+mvW7d1+txcEFuiY7lX9r6IsCOhWSTpIa0GXnSApgnV26nJTC5?=
 =?us-ascii?Q?l36tLjS5k/ykQvHDi3+mDPENmLHWe4JdyO9Scw01R9y/dXVAPT38fhh3clKL?=
X-MS-Exchange-AntiSpam-MessageData-1: MnM3bhUgQTfsuvpTwnZtinudfRRY+Usy4nw=
X-Exchange-RoutingPolicyChecked: Gh8qLVGw3BKlrZNZWBSAUerx5B6/t8pWOxtJQnR08kO0TjHfFWmOiEK2NCw/Zu8xjfNe3pC1n8tIpJ6DZVsUJkNTcZdtxDGdSsnf5YsaDffSdSrr8yqaBSveQg/5Kk40Q4sLErlkuKGgPJN23YK70NzlQ8j4EdrBLZf3oVTMbIe1L6O7Np//F/NHDQYqwuS22JRAF6CJ9KoMXRhYAfM3DtMbtd3zTtmIkMZfQfqQuqfhAiUGTZRDod2NIr1yo7UTw/EhsYzcKzA+q2gOguUKqI/+ba2LQh2kZNueq7akngM/ZcY7q/A2GmDSIwVaAndk+EYj+4MgV1hL2q/gTw/xVQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 8de93517-cba9-4cea-2452-08deb720d0ed
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7540.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2026 10:07:50.8341
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IQLuzD+5vNAqYw7J8ft9rvHIFvOQB62S5/Pf3669tQbIiF+hxJ96aB2jFWP6DQBhu6R9ukS+ktjy7I7FNmZZI++wJaILvyKpvA7qYklVm2U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8500
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[25];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-290333-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[intel.com,davemloft.net,redhat.com,google.com,lunn.ch,vger.kernel.org,linux.intel.com,resnulli.us,kernel.org,lwn.net,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,soc-5CG4396X81.clients.intel.com:mid];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[larysa.zaremba@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 2CE965A345F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, May 20, 2026 at 06:49:22PM -0700, Jakub Kicinski wrote:
> On Fri, 15 May 2026 15:44:27 -0700 Tony Nguyen wrote:
> > +int libeth_rx_fq_create(struct libeth_fq *fq, void *napi_dev)
> 
> Why do you have to pass an opaque void pointer?
> Just add another arg for dev.

I agree that having type safety would be nice. But firstly, napi and dev are 
mutually exclusive, and secondly, call sites would look pretty ugly, unless we 
add a macro on top.

> 
>  int libeth_rx_fq_create(struct libeth_fq *fq, struct napi_struct *napi,
> 			 struct device *dev)
>  {
>  	struct page_pool_params pp = {
>  		.flags		= PP_FLAG_DMA_MAP | PP_FLAG_DMA_SYNC_DEV,
>  		.order		= LIBETH_RX_PAGE_ORDER,
>  		.pool_size	= fq->count,
>  		.nid		= fq->nid,
> -		.dev		= napi->dev->dev.parent,
> -		.netdev		= napi->dev,
> +		.dev		= dev ? dev : napi->dev->dev.parent,
> +		.netdev		= napi ? napi->dev : NULL,

