Return-Path: <netdev+bounces-152251-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E39C9F3377
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 15:47:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 502421638B4
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 14:47:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2AA420328;
	Mon, 16 Dec 2024 14:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lHV5by9x"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0506D17FE;
	Mon, 16 Dec 2024 14:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734360432; cv=fail; b=kV/+E7w2NxIFdJCbIpuKDZ47W6TpaotmGlAJLNjOT4JSp2bVgCK2SbVkh9ocvQQKvebcvA9SOuonf7mXkkvphg4p4CLRhZIgwVVo3Y+hSMn4rgRGflMiyZstUuXMDSZrmkOL84kenCbXNrZ/+8yZ654WdgkUsA6jkq/UX09j3I4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734360432; c=relaxed/simple;
	bh=2RoOQGa38Sx+5YTh6xP2mN5ViJ7c83UFU+WcCB82RgU=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=i9m/1bEmKlA05AmoWRLjctIaxtqolE4d82aHIF5RW58pRH51t1+9dPEgZHiRNUtzdyHAp9tEvF9JQku6tSK4lIJCxsyHg/RAXI1x475Re/Ar3UfCSFRbY8Gymk318DpVZG6mGjFtRyIpKto6/WV9HCrX8tRV5Ag04ZjPYX1VwwU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lHV5by9x; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734360430; x=1765896430;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=2RoOQGa38Sx+5YTh6xP2mN5ViJ7c83UFU+WcCB82RgU=;
  b=lHV5by9xPOGKSX4QB61M/g+KDK2XD/4iyH+57fqKFjPmooubGjTItp0Q
   1k3Hjjvf1t5uJZodxIbJHa+x+eOiFNBc2xps0ksuEBcp5Ox7i8hmJbqJh
   IngShXmLBIWS9+KbaUSlbPvNqLnFfsZ/D/OJbCIlPjvxy/6ruqAPj0g7t
   wBzvyMS0DpsRtPsScjP7sixrqNpOTANKBum15/2d/4ZXYhGrw+plsOr8z
   fb03YRFCVV4B4oPHYvfxtMexbBS0uGaDpJQbm5qL6emUYdkIBqotvl4A1
   v3ww3BqgfNUtSvhx9PWzH7v0YDdFVDlO1PRwtsXS1eDD0TJdgQsNc0tb3
   g==;
X-CSE-ConnectionGUID: jeLK7hGdQ268XSK7vNCYiw==
X-CSE-MsgGUID: 01PaYVRdSP6FrMbpA8+hCg==
X-IronPort-AV: E=McAfee;i="6700,10204,11282"; a="38675771"
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="38675771"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2024 06:47:09 -0800
X-CSE-ConnectionGUID: VCeTcl5mS5aoQtXGJOiexQ==
X-CSE-MsgGUID: aD+WFGw/QBeaMvyNZssdlA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,238,1728975600"; 
   d="scan'208";a="97268776"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 16 Dec 2024 06:47:10 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 16 Dec 2024 06:47:09 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Mon, 16 Dec 2024 06:47:09 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.177)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 16 Dec 2024 06:47:09 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kNwHIvEFts1AlSb8A/fp1V+Dq6Js4dRdLMRAz7TprcbEYcbwq96pEbePURKABAXqpyLhypKASVwjRD2hG2KqmK5jQfBrlk1IeO0ZWxdzesyYFYtzl5bbT4w0jTCvhVjrwp1ud9KhzWwVUVMp3Nq6Hy4tPK0w12LiMmAcToTb16qBTp6ondliKJ3FUAbu43oN04bLtubjGIzebOLSAPahFCeco38I0EDFpWHlLMdYn5OS6L4mGdgJJzlZmq17yC7ucrCNsbHmrlEkM6lSQt+49IEIqPM0xhbQglHRv9kydhYkhv93Gvum529T4KNfWRPRT4/aYXCi+g2o7PuJ+PNloA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q0EpOUbaCDzctcYenfgN+4e8JV6NluRM+MD7Qu0pnUU=;
 b=IhGRXQ8DXgtLf4Yf3pwp4GJeL/zyUTMB3LS1kMYyBCgcGmcbIW3ntuw2fhbOWwCb3fKFE80ii2oVD9CWzMTxZQoGRNZY99N9WX+MZr3MeYyHSXGocEV07ZLVjcJpACyMZXXA1cSPvs6EfwFMknUGlqDVDX4RTw62UAOmDX05dDHJ30wXd2A5WZNtJLpGY39eIVc8rcT8LAfXx4SYVh1ffoIYuISmeY2SQBxRYU08XQuN9YMcgLqWGZdkKXAaHTup8OuSti93Pt04bOh4aBQzxtEjcJftCk2V7Pkq4ieo70l0/ELz0kUrlitnK38SEVtk4a+Lpg+bfBqR8zw7eS9QFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB7540.namprd11.prod.outlook.com (2603:10b6:806:340::7)
 by PH0PR11MB4968.namprd11.prod.outlook.com (2603:10b6:510:39::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.22; Mon, 16 Dec
 2024 14:46:53 +0000
Received: from SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::399f:ff7c:adb2:8d29]) by SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::399f:ff7c:adb2:8d29%5]) with mapi id 15.20.8251.015; Mon, 16 Dec 2024
 14:46:53 +0000
Date: Mon, 16 Dec 2024 15:46:42 +0100
From: Larysa Zaremba <larysa.zaremba@intel.com>
To: Shinas Rasheed <srasheed@marvell.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<hgani@marvell.com>, <sedara@marvell.com>, <vimleshk@marvell.com>,
	<thaller@redhat.com>, <wizhao@redhat.com>, <kheib@redhat.com>,
	<konguyen@redhat.com>, <horms@kernel.org>, <einstein.xue@synaxg.com>,
	Veerasenareddy Burru <vburru@marvell.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Abhijit Ayarekar <aayarekar@marvell.com>, "Satananda
 Burla" <sburla@marvell.com>
Subject: Re: [PATCH net v2 1/4] octeon_ep: fix race conditions in
 ndo_get_stats64
Message-ID: <Z2A9UmjW7rnCGiEu@lzaremba-mobl.ger.corp.intel.com>
References: <20241216075842.2394606-1-srasheed@marvell.com>
 <20241216075842.2394606-2-srasheed@marvell.com>
 <Z2A5dHOGhwCQ1KBI@lzaremba-mobl.ger.corp.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Z2A5dHOGhwCQ1KBI@lzaremba-mobl.ger.corp.intel.com>
X-ClientProxiedBy: VI1PR04CA0106.eurprd04.prod.outlook.com
 (2603:10a6:803:64::41) To SN7PR11MB7540.namprd11.prod.outlook.com
 (2603:10b6:806:340::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB7540:EE_|PH0PR11MB4968:EE_
X-MS-Office365-Filtering-Correlation-Id: 749e28b1-b9c7-4d9c-185e-08dd1de07aff
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?JqLkaVRfo6APL73Fk+s4SFQrhTp+sUj8VcO4qEn+EWMZ2dhGxi7qycbpvwMG?=
 =?us-ascii?Q?pwYgqPIOoaYwWnxaQ0HPSRbx575EqTX5iojRQNczR5h6URzqYvZBok9YJiCi?=
 =?us-ascii?Q?sbZdKH1vvrsRlrNMR6tb2uhOLsdYTX9WNa3obRaFvVHQma4aKzwNFd8MpNfq?=
 =?us-ascii?Q?6IigvRINp4sR+gO8dgO+2YVU//LVJysg+a9+0Ll2iuUqGIyHKHObxa+7rFXs?=
 =?us-ascii?Q?XQ54erGhVdgsUfHLg+oNZaRM3N3HRFJgfDu4Z/Iv3uGNzqnwd0aIyCXR4+wn?=
 =?us-ascii?Q?hNHLRSDytgcS3wARyhc2rRInPDS0/tTw9gV/zYqaFdzR2bylFauXbppSTj/3?=
 =?us-ascii?Q?zx0vdPtYAvxFNhjzwEPNSxkmU7nmcdk6P4MHscL6jzEanmyW+77myfGCFAKH?=
 =?us-ascii?Q?t38zjsfHbCluEEjg0jZLSMTLn9r5aJeQrMJq/qjkHmRbFpe0DbVEv6y9BHFt?=
 =?us-ascii?Q?Vbu5Jk/5BRn5RVS5u2TmJkLKQOkcV0qqmyLZRxQkZXBTH9KWiyNQsyQtcRXp?=
 =?us-ascii?Q?avjsluV2km+D7CJ6Y10Dt+W9AavIU68W5pK79aQvVZcL9ndDV8ClggI82JEw?=
 =?us-ascii?Q?bgAGJS1S6NaHnvx5HKpVKKdwzCTjT3a/uzOgaZIsBvx46j95ZRNyAib2i0ek?=
 =?us-ascii?Q?l6VHRfxM8F19bUVRbbSQLlov9clrIUVcr7lQJVm4pqcKcptj4cDl/iosQdmh?=
 =?us-ascii?Q?2EGL3AftqVdS9qKIbEeI4apNUSh+UtKw+b5iiOIvoGQQklFE4q/MLC3vvtRN?=
 =?us-ascii?Q?nTIfVpWHCrtjMOGYtbvJGsapwXJJZUfbA3inDmENQz7ZFvTSyPeuGtmxPCeG?=
 =?us-ascii?Q?01RbP2G0GOZrod6s3Xd6BmQbYm5PwdA/WwpAop1WZcclZKX/UCKEZFsuw/PT?=
 =?us-ascii?Q?cgU/w38m8Vj+mcmVfMJylxV9zjZkfBEyL4xScjHNMkxqHUoG7uhcgWh/ZNVt?=
 =?us-ascii?Q?1+lxDODTovbunM0ejQiEo2qZ/2UJD32sJ9rUJkn8m1tM3zwWGOJMEhZMleHm?=
 =?us-ascii?Q?QMHi3U0Q1PBeq/z16SGHzfgzla3MEakm25OdFSlbSunlZmufDWoLk6dUls4H?=
 =?us-ascii?Q?HZCW86TGpsECHn6ZT6+gn2dyxVsLMoQNIms+e6QqHlYlPddxhyP4qO9Uei6h?=
 =?us-ascii?Q?6SYQniY7hypA0AWJpTHvo7/WKGOolIAhRPu9sSzKDnAqZ/XJlJ49Ji5dqy2O?=
 =?us-ascii?Q?7WtywJvhH6M4v66U+8RbHgj9bD7ziHXW4vNQ/6DMDaXot03+yVz51yb1TGQW?=
 =?us-ascii?Q?5KFc2W/8ecoFo7l1VB1GMB/HDFzI3t8sZlyavs7qGEhcTWd9ruc1ZkBIi5M3?=
 =?us-ascii?Q?hNp7TaQ0K0iLfZhTBdZoJxhCfA5Fv+KlDov44GBsKHOir1ydrGtUqEFkvrRY?=
 =?us-ascii?Q?ZRHQr9tpwZF4xpSzgKoQQ8+EfDdu?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB7540.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?iZUIduKkpIQReuEZhgLI2wuo+idjc88v9NFStHqlz3E7gMyCsVVgiVcchgnh?=
 =?us-ascii?Q?AE16uaNclhYspz3Gvw4ftsNsJECNCTZoWJlrYwL8HbZXsS/At2WTib716Bdy?=
 =?us-ascii?Q?G7LzQhP/5Q7wlELLTXadXoqm/wyLnyt6gQuQiem733ZlNnhSDLjPWktZudnK?=
 =?us-ascii?Q?6fWEEXOMNeMsIWHuvB6gxoae7CWVC9f5nQkECNIw5K+6ITY+NTLFpj3FZeLj?=
 =?us-ascii?Q?MKS0QM/HVmfSw4doNW8omget9q67PkwCQy5gLc4u5Ez1KJepAlf2+nbYaC4/?=
 =?us-ascii?Q?0NH2ejf3/xfFm/n2dMOT149du6eLIQbzF0o75zVdwCkBzQAYsQL7D6NKiwu4?=
 =?us-ascii?Q?gq0h4UTVxxKTaOeVPfSZUP6Kt3fyD1KyS3EISnb+mXP/14Oo6KpOUP0OYMZF?=
 =?us-ascii?Q?B1DXNFQoDg9iBmYa2YoPkmELjkPeEIu78WzpKFri5xsp9MZfHTRWnfn9XH6b?=
 =?us-ascii?Q?RU9WepSDmHihgJC0eryIf4Mok4UddAv5nt+cNFA/+jdB/AReA8ZMtVceeCHq?=
 =?us-ascii?Q?QUDh034DAOCkY8aoU5itG0SWgh4HLNo3jaCmnbmV228Ch4S6KnMMy4ml4uzK?=
 =?us-ascii?Q?sim/76fXHqQQzshoS17zF8aWB+MiXHq3QH7eYX4bRn25NhKiG7HEDmWLp9cY?=
 =?us-ascii?Q?ssIUZXzGpbCnDqyTu1f2UqRe2b7EpL8vWQ+/YZRUFtay2ipXFaElk/hBD91t?=
 =?us-ascii?Q?3eA1V1ibpFWEGe+M1aMdK1nhtCVgmJFz1yXZrYOub5iL2Ddxhmttsi5P4/Pl?=
 =?us-ascii?Q?+UPJ/GlD3lwDNMgFYWXTNx29ttHy3dIF4aWjG32ViGCpBKu1crrRc3gjHKIb?=
 =?us-ascii?Q?ckRidMRM94RfahblqVoG9jXajNB01XrN8X1wTdzmqh460+7t2sO4xnELJaWZ?=
 =?us-ascii?Q?1v/8koT/xgANFuGIplrQL4zqLnjdtiU4OcEcxJg1ps2EgSkNOuizSqj+mvEm?=
 =?us-ascii?Q?Ir4DuWQoC1vkTX++CkHp3Yvzon0/eZd1ATMHPmIkkW267+81gvpwvyaegAan?=
 =?us-ascii?Q?Q7aWogGQBsnKPtqAQd3FqZ4m0rfAG3zGpr0P3vQFUI1dixTlZ0kJMn6o80IG?=
 =?us-ascii?Q?862ESc61dkHSL6Hwgu7sbNEX5X4qItMkSxtpnH1vvncDhxu6Es38amDJBbqz?=
 =?us-ascii?Q?KB3wufBH36acceXReKKC4Rx/Efuuvfn84Xk1XdUDOBMHUutklytjovDBqbAF?=
 =?us-ascii?Q?V5ZJPAcCdh7NE4oEBnNJhZb8f/IroRZmib9lsYdrig8HJClICAkdGu7Woopn?=
 =?us-ascii?Q?0lDvTgV6vU11vhWeyxZoqAVlXC7KUVDAl+tXNa3sKA4dFbX0LEOtW1N+jUTl?=
 =?us-ascii?Q?YOEfIlTwXfTrjYB2XjPML5FFaNLA4We4cCc36M+FgraFas13RljsUxZNAfNS?=
 =?us-ascii?Q?YP/U8dk3yk2fXpn/Isz9eErkBAWykb4AdczNSsZB5fKJnR1mEfAaeYBWTMnT?=
 =?us-ascii?Q?ZCvmxWaFoL3EC75li4BF2yEHPdQoDpRJ3zGBV7GWCBJHfXmGnX7XGyGj3pOB?=
 =?us-ascii?Q?10qfEc4G+fM6dKcVFGaompVbryxutKGiec7zVDoqUJGSa2d+X1H6EgZVQxMi?=
 =?us-ascii?Q?i+6U210Cq5+zJbhw+HVBIepiJcFbqYQrT7J6qzUZviq/CiIK3Xa448vnp9b6?=
 =?us-ascii?Q?3w=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 749e28b1-b9c7-4d9c-185e-08dd1de07aff
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7540.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2024 14:46:53.2681
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V92HQ7+D38C1jqypAhxQLQ7eXCnCOrpLLOyk4cWjJwMRM8hWdirJa0MQs626NFP+U6X8reoRrWTN1q5YMsT6selFoMnnybnoTz8E/etie7E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4968
X-OriginatorOrg: intel.com

On Mon, Dec 16, 2024 at 03:30:12PM +0100, Larysa Zaremba wrote:
> On Sun, Dec 15, 2024 at 11:58:39PM -0800, Shinas Rasheed wrote:
> > ndo_get_stats64() can race with ndo_stop(), which frees input and
> > output queue resources. Call synchronize_net() to avoid such races.
> > 
> > Fixes: 6a610a46bad1 ("octeon_ep: add support for ndo ops")
> > Signed-off-by: Shinas Rasheed <srasheed@marvell.com>
> > ---
> > V2:
> >   - Changed sync mechanism to fix race conditions from using an atomic
> >     set_bit ops to a much simpler synchronize_net()
> > 
> > V1: https://lore.kernel.org/all/20241203072130.2316913-2-srasheed@marvell.com/
> > 
> >  drivers/net/ethernet/marvell/octeon_ep/octep_main.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/drivers/net/ethernet/marvell/octeon_ep/octep_main.c b/drivers/net/ethernet/marvell/octeon_ep/octep_main.c
> > index 549436efc204..941bbaaa67b5 100644
> > --- a/drivers/net/ethernet/marvell/octeon_ep/octep_main.c
> > +++ b/drivers/net/ethernet/marvell/octeon_ep/octep_main.c
> > @@ -757,6 +757,7 @@ static int octep_stop(struct net_device *netdev)
> >  {
> >  	struct octep_device *oct = netdev_priv(netdev);
> >  
> > +	synchronize_net();
> 
> You should have elaborated on the fact that this synchronize_net() is for 
> __LINK_STATE_START flag in the commit message, this is not obvious. Also, is 
> octep_get_stats64() called from RCU-safe context?
>

Now I see that in case !netif_running(), you do not bail out of 
octep_get_stats64() fully (or at all after the second patch). So, could you 
explain, how are you utilizing RCU here?

> >  	netdev_info(netdev, "Stopping the device ...\n");
> >  
> >  	octep_ctrl_net_set_link_status(oct, OCTEP_CTRL_NET_INVALID_VFID, false,
> > -- 
> > 2.25.1
> > 
> > 
> 

