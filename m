Return-Path: <netdev+bounces-174242-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FB5EA5DF71
	for <lists+netdev@lfdr.de>; Wed, 12 Mar 2025 15:50:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4EAD1700AC
	for <lists+netdev@lfdr.de>; Wed, 12 Mar 2025 14:50:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B819723E35B;
	Wed, 12 Mar 2025 14:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CIf8qs/U"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C84131E3DFC;
	Wed, 12 Mar 2025 14:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741791003; cv=fail; b=UxutAA+P0xwtgcHgBUssv5t8o2ToDvO35+plPOv+hDZlUp/t8WnzSUyvD0UVc4KRbj0dCDhr6JWWD7RYWZehI7RYxrROfLsQxfVyBR5ERDahpqKskzyhcalgPoZW5JhAjp/yd9YVX6gZYUoNVqwMxWqAGO6vOo1bXCxS2RTz8Fc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741791003; c=relaxed/simple;
	bh=4okS6M7vizUMp/IKoQ0XofVc0IBAesrmTtoDhk87coA=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=VdQ6iTmg2S69nol1bi+xomU2x0N+Ck2lUWh43upZ6c5Y3n8W9WxAAs2xdV9G6nKuJzUPQ4ErbkF9kcAOtXm+xSfSkE5OWfy14U0zS/SDee+U+XxFrkTwjnUex04MlK6kwnGxLoyWD6TxA3hnOhfhViYz8lkyQuychdR+cHN0G14=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CIf8qs/U; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741791002; x=1773327002;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=4okS6M7vizUMp/IKoQ0XofVc0IBAesrmTtoDhk87coA=;
  b=CIf8qs/UIIlpZ8/tdFj6T0IBxNaNyX8FFFO1miKzGamn2rhxdx3n+zou
   bGnBN+JuTx+VWNECVW4ia8hCtWDsmg6YgzjPL9AHGYBoocOrRpNzMIDbb
   jdIt8GyPhYz2y1dkTIAmSmQNLN8DOleJ63aL6ReZ1FuBXeh7aIg9Wuo4a
   7DYLYV/naz7JJJSYzQuK2j4VztWRwhwXb1EE2m8GEfMt+XQ+kjhultv2M
   X/0DL8cLxdF++ETtBhpsHfItD24INMdaJwkk53dJ9OxBnvxPCxlNl4Zsk
   SfBsnmVNnSABl4RhS296dnREDho2EsH/J/0Pyhhkqz9uGqPfNzpS9xhqt
   Q==;
X-CSE-ConnectionGUID: gBHDAm58Q+63sNot71meGQ==
X-CSE-MsgGUID: HnFhX8VcTUCV7EZGo3czOg==
X-IronPort-AV: E=McAfee;i="6700,10204,11371"; a="60418710"
X-IronPort-AV: E=Sophos;i="6.14,242,1736841600"; 
   d="scan'208";a="60418710"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2025 07:49:59 -0700
X-CSE-ConnectionGUID: pwFOG6wmSP2WHPeMgotBEg==
X-CSE-MsgGUID: JEHgzMDqRkqXpiaciBnyxA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,242,1736841600"; 
   d="scan'208";a="120613781"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Mar 2025 07:49:56 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Wed, 12 Mar 2025 07:49:55 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Wed, 12 Mar 2025 07:49:55 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.49) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 12 Mar 2025 07:49:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rKFJzCDqfgHsxqnssq7KY0SPgkQ5cuHdVkYxI4XZDonVvqcfB53T4JE3C7BKPqKuUiT4NdAWref7LyHdjHv/3LQEfjlyr/zs4RNtxVFvsjK+JLp+9kL38M1gqWpuXQ3/WAPcyOaiKORg/YZThvjxXl/5AN9hRPHyD7u4vq5gqTdPxzkyw/EK4Z3SOmmDGzDZHXzmUQJ2BMlGG+z1jwKQasnaXtd8ZudB8fdJFPjKX6i9ZKyoGD5Svj8OpD79yUAPui1MRV2d91huPSNlaHWMdvH9VnDnpI/aeGVBB9V7iX28IGxDuIG33aNcb6XSM1kXduQmaTkvPGfNrPYxGTbYpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R6J9xCDA5zlYAd07JjjjVQwstPiM9b6zArVf2B1/cwc=;
 b=PPslMHD2Rrah+LGzIYppo2+zikur2EA9ZKGyXLolAIKurUycJW5KJpcnuKCC2kKAkUOamJDZT+Ih5OsbWXVUr9qJqhoKj15Cv9j7EX9t9BJDtMUXApgSlz8esaEo0BTpnyuacWN4n5kF7MxNtzj5nOYzn+9kOF6EMXcy+zJZF74rIZUspVPfYlFzyC0YY2PC5UfrdWsm5A/jNp6UGIum3g7ask9uACldhoMUfITvY6CBB37QSUxocgSYcDWlTONvfw8VRIr2Rv6FeCKAC2H2Yh3z6kXW0AZbbWcJOQyGHYC+sph9ExUXhRn7uhxuB9E6cDndDT8b5K7/wiW78NOHPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8665.namprd11.prod.outlook.com (2603:10b6:8:1b8::6) by
 DM4PR11MB5971.namprd11.prod.outlook.com (2603:10b6:8:5e::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8511.28; Wed, 12 Mar 2025 14:49:25 +0000
Received: from DS0PR11MB8665.namprd11.prod.outlook.com
 ([fe80::8e7e:4f8:f7e4:3955]) by DS0PR11MB8665.namprd11.prod.outlook.com
 ([fe80::8e7e:4f8:f7e4:3955%4]) with mapi id 15.20.8511.026; Wed, 12 Mar 2025
 14:49:25 +0000
Date: Wed, 12 Mar 2025 15:49:14 +0100
From: Michal Kubiak <michal.kubiak@intel.com>
To: Chen-Yu Tsai <wens@kernel.org>
CC: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Heiko Stuebner
	<heiko@sntech.de>, Chen-Yu Tsai <wens@csie.org>, Kunihiko Hayashi
	<hayashi.kunihiko@socionext.com>, <netdev@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<linux-rockchip@lists.infradead.org>
Subject: Re: [PATCH netdev v2] net: stmmac: dwmac-rk: Provide FIFO sizes for
 DWMAC 1000
Message-ID: <Z9Ge6rLHynH1ATjz@localhost.localdomain>
References: <20250312124206.2108476-1-wens@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250312124206.2108476-1-wens@kernel.org>
X-ClientProxiedBy: ZR0P278CA0064.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:21::15) To DS0PR11MB8665.namprd11.prod.outlook.com
 (2603:10b6:8:1b8::6)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8665:EE_|DM4PR11MB5971:EE_
X-MS-Office365-Filtering-Correlation-Id: 55adab79-f574-4b13-1f4c-08dd61751574
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Fd/QPl31tQVHvzRvw3t5tzmN9h78ynDJl95anW2qsQEWYNkPEr/YZENSEwdU?=
 =?us-ascii?Q?1p4ttC+KlouPM+Ucj2mtF/ZCtHlmhsLMQ4+tuSk4OGz9BW0R4PngLrHq/ZoC?=
 =?us-ascii?Q?tIes5sw9GRSC7U8mWSAfCSTi2OApahix2PhpSc73QiJrYNj8onVwp8tD9aPh?=
 =?us-ascii?Q?9c0+YN2jRg5JoHQFqigp124HoSixbMf55jc2NpDIMl7D2CFPtZ0OiKdO7GyY?=
 =?us-ascii?Q?Cz2gl3ZXNY6WamewtsI44s10XEs+stobPVG3Z3cswmLGBd7FjP4Je+238Rv8?=
 =?us-ascii?Q?2X5XIq6dv5F7Wyk6kTUKtGBIehyGF2wHGJWzY+86MOsLQoCWXFouPCXzsV9F?=
 =?us-ascii?Q?s31GcRz7tbG1K5uYPDq0iSjNvz8Y9zkF8r3uqDw+1GCdFLGB87MTbjht/q2U?=
 =?us-ascii?Q?XpBE1io7BYnr8Y9KphxU1lrKJGdr6icFL1MOtTIfm884LY5Sh67g4TJ4HBYk?=
 =?us-ascii?Q?KyGWmowz5QcDLrnlCVLSHVKLSpu3r9jOQKnt3zYTrRXxUw61AAM0cEZ1Sw/H?=
 =?us-ascii?Q?HFJLw90oKYoVilHCQNoEXI8by3MJrfl0jktJjB61trcu7SSa1TcaV2KSz2sQ?=
 =?us-ascii?Q?2X7EzA5GylEglJ4cb+zmMMJqBBNISHfxyBB2LV3dKFRHRFyi1aZGquigD+Yn?=
 =?us-ascii?Q?FmIsqKyo0++FCdlvl3DokmoEPe92dmFUeoMzo2xZ7IsKUQFojRg6c61Wrm8K?=
 =?us-ascii?Q?Med4IUOhW59ZWUewSdUXKRiXlCFGdgtBgSgqoIjfyFMXylPCtouGGEzrTod6?=
 =?us-ascii?Q?G8I+80J2pSCqIxWyW7xsxRrmoHUHyqC1UpRtpezRq1u+a5Kk9Ev1QeG7o/D4?=
 =?us-ascii?Q?eotcxN4WStWMY586CnqfZNybgkqr29G+9+GGHXuoPEU1Rly9cRZfXBuP5sfB?=
 =?us-ascii?Q?Tx40W1A8hmIJhBBHO4kDitiEY3HKu0nuryyUETCHcYBZOKwmZS6OX06uJtyE?=
 =?us-ascii?Q?CUm0bUFZhqtRCym0Kyv9USi6+MsD5kp/lfAQebfcM4pGXvxgWveH/2m/qeYj?=
 =?us-ascii?Q?Onl7IAo+nLUa4Hj1iZUp3nlSgsJLpPp1CGz3ZHXnakySXV57k8qwolhntXy1?=
 =?us-ascii?Q?RSUvRD3dJLlexefSocXwlgA5ZI3In55Ascr2rEMBB1wO5VRh5zS++XrLN7bd?=
 =?us-ascii?Q?QQANvD7qmQXE936YEbJXuyM6SiVCTLZmY1RCAcKNtticHglfhh9grsvSzyog?=
 =?us-ascii?Q?Tcbs5tS8qPMxM9eo/BaNDjmyFPi2x78TiL45iy652Gc7X56uChTv6OHHV5Xk?=
 =?us-ascii?Q?rH8CZfq31OmuxGjNsEyLzovUdzXXlZqAPdNaoXlUIqFVtXJmWVdio7mbWfHw?=
 =?us-ascii?Q?8tdLwdryzuIajogWWFpsU3F4Dek0uc4Bqpmmf2sMWjDhxuq3cT6/nN6Hrdj8?=
 =?us-ascii?Q?dZ/j7ArUGV0Lx/cSSR3K3cdvP8CW?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8665.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4wYphT3gEbbbDiuoPCCgnv7XErZ8uCCEYZF07R38cKpMY2FTwXE71Ph0w4Dc?=
 =?us-ascii?Q?zOgWX8tOgoCYCPlyzAyGxjSWX8++rruBJLGZODFcARx5b7tqLOfV9CvaE1Kh?=
 =?us-ascii?Q?BDN2WT+bKP5G+HGJD6LwfZlGeAGwjmKUBsJgVnBzunW8+nFnhvIjepRuAVqs?=
 =?us-ascii?Q?Mj+l+fhISjb5WTtGFo+c3sNu4P4cGmXvBUF3GzEFh6BxY/ws2bsndRlHnSxP?=
 =?us-ascii?Q?zqneW/RKMO7Fa0ft1dGlGK5xSACC+VnjE1OPYe7LTewX0ArUeVY7mC7hMawO?=
 =?us-ascii?Q?QnvbwLZrNsibdLYNLh5wDyqEyDnQRkL0mUpG03WYpwwiEVJgeu7PYYgFMagQ?=
 =?us-ascii?Q?5/LAnYzr7P8MyhwyjJxwLRdQ+cZK4NSRlcUmFNKRHutI1hMk/P96Mpo5jPqZ?=
 =?us-ascii?Q?0gXMhBvT9zbwZyMGxbxt6+AL1pffOC+i+EVEAwcVOdW6apGg4Ar3K5wn2ndN?=
 =?us-ascii?Q?rr0BiyVQh/v5yYj9W1vYAAm1iTwVMZEULrze3eqIfLMlk9ocnfwaHRWQIjSw?=
 =?us-ascii?Q?rl4PxO/X6SeFOK6eh8Z9gVW75zqY8+KXGY1uoZwLl+X7AIO6+ucI93/ECskF?=
 =?us-ascii?Q?KuRpygh6X801sC2d9MwiMdaW/cWK93d4v5KRDzbWagl0K6LcxKR6ij6D9sTi?=
 =?us-ascii?Q?3G+vDas6b49gWIF84GxPb4bSpWqS+Lb1o5vqbXWTq4x5P65tIABtHFp3KNdE?=
 =?us-ascii?Q?cm/ZZ6dUXG3NiLsWbRP1NgXw98Z1A3VGxUhzIZBW8/a79W8eGp6ygx2JSOrH?=
 =?us-ascii?Q?1kkKuOc3R+A7RuNwJu4KotP1twXBO53RG6nd/6aS3aYN8L6SzOGyw67LMALo?=
 =?us-ascii?Q?yrEiAnOCCfNXKLzb2H9CsvjWw2PCSHIDHhNtpYRzTZiWwEhgVZ2uub5ML+bn?=
 =?us-ascii?Q?0Rn11RwnR4bKg8txpFhA/rGzAR7gvdAt0k2xuca38sr5EaNFXEKiIZIoDtSd?=
 =?us-ascii?Q?kRmzxdrRhy+8NT9Ajxg1mrPsaH8mrzYjGtJuME/LERD6zjGoLx/JTLj1bbdn?=
 =?us-ascii?Q?2WE13eSVQu0yThIF8Tdq+WZf1AGAZ9IX+DdaO2s8h6FEIoLXsXd4hG7OxxUq?=
 =?us-ascii?Q?lhhjQqswxdTTQEAKGeACnlct3eUAVvT128mKjpoAUDQg90kYbnAG36qoYFE/?=
 =?us-ascii?Q?ItYS7t7oILXlnVzfNOuTo4mqwX0PON3JBBwUfdOBBPm6gmBhqttJtJjadIH+?=
 =?us-ascii?Q?PawzXMoK952imHkI8q8s7aXSMEzk0Zgk/eeUDxd+fzQHBc3nPedQdZa8cW/X?=
 =?us-ascii?Q?ehZ6i9+EXj+0xoRey6JKtaYKzsnXPmTvRwdfBPXC7cGvhFiV01rkmF2xkxXC?=
 =?us-ascii?Q?B3/twjdCYgoB6ThF1TK+q7Yh6CIKsnjEqNaXFDska970mbPdPldTZUtQtdwC?=
 =?us-ascii?Q?j+qfA+PahElSl3Nz+e0mBzLy72E0qFiBhRLrOCHLdAAkfjYdPDW/qc4l4+JY?=
 =?us-ascii?Q?2ZIFfZFien3B4VueoUPvnRXBit0eU/Ne/Cr1yvEirDjWgfu4WlHOkcy/ZaBp?=
 =?us-ascii?Q?OnzAWP3vViYU8WMtII/9Wb35ezLojvT9Ix6jWNKgojPyKkUiFkqefpxomDJ4?=
 =?us-ascii?Q?nDsqFkkkWPVj4ZJpgEKes4UjLy86LTBKXlrGL7WgaSwj29+75uf3y5pNQYuy?=
 =?us-ascii?Q?BA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 55adab79-f574-4b13-1f4c-08dd61751574
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8665.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2025 14:49:25.7022
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hblDYDJID8WkGqRTVg5avCXoQoFMUDyL8RkChPqE25k8MC80gsd7P2MdmEAgaVR4JqWZV8e4eCRVaeGdPbx4/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5971
X-OriginatorOrg: intel.com

On Wed, Mar 12, 2025 at 08:42:06PM +0800, Chen-Yu Tsai wrote:
> From: Chen-Yu Tsai <wens@csie.org>
> 
> The DWMAC 1000 DMA capabilities register does not provide actual
> FIFO sizes, nor does the driver really care. If they are not
> provided via some other means, the driver will work fine, only
> disallowing changing the MTU setting.
> 
> Provide the FIFO sizes through the driver's platform data to enable
> MTU changes. The FIFO sizes are confirmed to be the same across RK3288,
> RK3328, RK3399 and PX30, based on their respective manuals. It is
> likely that Rockchip synthesized their DWMAC 1000 with the same
> parameters on all their chips that have it.
> 
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> ---
> Changes since v1:
> - Removed references to breakage from commit message as it is already fixed
> - Removed Cc stable and Fixes tags
> - Rebased onto latest -next

The tag of the patch should clearly describe the destination tree. It
can be either "net" or "net-next". "netdev" is not a proper tag.
Assuming you removed the "Fixes" tag, you probably want to send the
patch to "net-next".

Thanks,
Michal


