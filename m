Return-Path: <netdev+bounces-305746-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id hp73DMskTmoKEAIAu9opvQ
	(envelope-from <netdev+bounces-305746-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 12:22:03 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 84924724360
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 12:22:02 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=gikHoKz+;
	dmarc=pass (policy=none) header.from=intel.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305746-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-305746-lists+netdev=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 65DAC30C4EBC
	for <lists+netdev@lfdr.de>; Wed,  8 Jul 2026 10:14:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9347838B148;
	Wed,  8 Jul 2026 10:14:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0911F37C936
	for <netdev@vger.kernel.org>; Wed,  8 Jul 2026 10:14:49 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783505691; cv=fail; b=bM36/uk3t6tzawv/IK5iLNJCII9JFqH1cbPNNQ1YvMkry2tdxrPaBmqfOZ/FzY/D5HQvce4f0OvUyyh7kv2mllwChQkmdn69Cpi4NtnmLNMKIdMPiucYuMbz/fBZL3nA+F49BhBu7Neid3y3WBYIrkFrss33DmWAYk9QnYnQr+E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783505691; c=relaxed/simple;
	bh=SeGbemg+CjRNBMGXAruX+2bnBWvRf6ZIlgABwM5Pnms=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=hy29+XV4EUa7gJCEULNqcgXS6OOEmKTln27ywfNwswwwT7Tzt0vD3r1Y9HKq9Tq7jHvyA+Jk7rODvP0KEsI+LlChEWbi0K7RypmdlQx6VoxsJzTKYDM4FO7M8ccTKh7ltgmYRAkIszOxFAKaeCL8WTHTpvlJBQrgnT3gvLXXP+E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gikHoKz+; arc=fail smtp.client-ip=198.175.65.9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783505690; x=1815041690;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=SeGbemg+CjRNBMGXAruX+2bnBWvRf6ZIlgABwM5Pnms=;
  b=gikHoKz+6MZ0UN0dQjbYnW8Jg0m3hhpmzvXvtaNYXZlQ3N5uREXu21aJ
   SCDKATa9h0slFmKZMowmmqmapD6KdxIlh+UEGGj5xMjkFhcVWUtnX4+bz
   VX6o/IxK0GSB17tFOGO+W2DZpR1zOJ9XmDqhsqIHbc0OFs2Runf7ancCN
   Km0WqApeqdxGFwunxhyoO0AeRjVolqLMM0IbgFH4R1yRFdvGS7PavYmJ3
   jdBDq4BkRS9aTPUMTiUUsGq8OTjlPoNhOSJNrbGYBTSGCMumtnRbMSC9Y
   +cVvqjMFPk8+IoSb0FWAFjg2bCzQWtUk5ycdA2gqqUpJmtkAvLn+kjKrh
   g==;
X-CSE-ConnectionGUID: fnw3ieDGTEqvVlQuh8w0rQ==
X-CSE-MsgGUID: KIP8iGJcTGqmY8aQfM/8Ww==
X-IronPort-AV: E=McAfee;i="6800,10657,11840"; a="106960703"
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; 
   d="scan'208";a="106960703"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2026 03:14:49 -0700
X-CSE-ConnectionGUID: g0+Y+0/oRiK1NoCBZYF5tA==
X-CSE-MsgGUID: DJlpDO4oQH+FhQXLjjPO+g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; 
   d="scan'208";a="251588869"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2026 03:14:49 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Wed, 8 Jul 2026 03:14:47 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Wed, 8 Jul 2026 03:14:47 -0700
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.2) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Wed, 8 Jul 2026 03:14:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N6hxQb6vvogXFwoGU8WRxY2IhFkcXTMV7S5oPPpjQjnqcl307FMP+TXwMqLtBLiZPQuLLfgqfFNx5bqgoriKBMISHU6q0sIcjJ/xjsf+0Y/7VvAldK0yBfRXoakhQX6e6Dy2AM4GciDZpT8VHm/o2LNqfWC56N/TLYRcpnSvNwLCm2wtKtjknYq/8iVQ1q3Yyx49sekjv3KuJpg8UHlDg2zFyupsSFDLbYRCgSsRoBM1xYr6CIk4nu1ONRAvPngUFmwTvBDl8yElWFDxFgSQrUebKJ3wj+wnnZjnweC6gGxeOyFNY2BUO8mURGKIaFH/VXG/2L+szQ5a2yXqn2EF/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N1Yw9iARgP2bHNzahhzYWioPfmY9PtDYiYdtOpmb8Gw=;
 b=bB9lE8hUZy9+tffAJIf59zjuqBN7IabQjux6Cl2z+xirg7vRczAAJ1jQwM9ek8bX13dgS73wvEZZ4KREULlkHhsU7zGHDlhCCrPlJFT1k9VxAmoALLDcIDafLE2noJ+5jMo51NRqbyvO9rFnX3HV+FIbIcu1A4IPKdlROxnPctJSu0czbki4Y7aErUr2CmLBVZgWsTW1tOp8moCmAd1a7+Imt572V+iYyJerhDH02MhPvNggxV8VgXdF/WR+mpDJd+mXhd1xW72IFvREWD1kUYdYKbmjCyjiqGvFKuo3WTmDkOMYLB5KsoyX4kep9xWC9UJOzc+AK8AXHDchPpRtyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM4SPRMB0045.namprd11.prod.outlook.com (2603:10b6:8:6e::21) by
 BY1PR11MB8007.namprd11.prod.outlook.com (2603:10b6:a03:525::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Wed, 8 Jul
 2026 10:14:33 +0000
Received: from DM4SPRMB0045.namprd11.prod.outlook.com
 ([fe80::b630:ca9c:20e1:f485]) by DM4SPRMB0045.namprd11.prod.outlook.com
 ([fe80::b630:ca9c:20e1:f485%6]) with mapi id 15.21.0181.008; Wed, 8 Jul 2026
 10:14:33 +0000
Date: Wed, 8 Jul 2026 12:14:28 +0200
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Paolo Abeni <pabeni@redhat.com>
CC: <intel-wired-lan@lists.osuosl.org>, <netdev@vger.kernel.org>,
	<magnus.karlsson@intel.com>, <kuba@kernel.org>, <horms@kernel.org>,
	<przemyslaw.kitszel@intel.com>, <jacob.e.keller@intel.com>
Subject: Re: [PATCH v5 net 0/7] i40e: re-init and UAF fixes
Message-ID: <ak4jBFmOV0FZjqSw@boxer>
References: <20260701124524.13644-1-maciej.fijalkowski@intel.com>
 <1240f40e-ba1b-4773-bf65-facad8b4fc0c@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1240f40e-ba1b-4773-bf65-facad8b4fc0c@redhat.com>
X-ClientProxiedBy: VIUP296CA0160.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:35d::17) To DM4SPRMB0045.namprd11.prod.outlook.com
 (2603:10b6:8:6e::21)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4SPRMB0045:EE_|BY1PR11MB8007:EE_
X-MS-Office365-Filtering-Correlation-Id: 6084cfa4-5fe5-4ee9-0b3f-08dedcd9b4ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|1800799024|376014|366016|22082099003|18002099003|11063799006|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info: LpZtfz0oUS67bX0TXiGeZ6SHb+7mT0G35zRfuaiD6XmdTxroOhcB74CMdx0QCzI2Qm+Ok4JU1hRN3hIkUTTsGFOmJoIjPNlKAdvQORUyGdZWFcWkIR0erCHg8vvNa/sbd+NgvHk9gExJMKTtjFlfJAsU3IzDEPdF8558h1FCVP0No60KkjX52pH/9thHpISMWwuddY2HEpnRZsqTQVfcSRXWBT/MxeL5rFqQj3RwB7TlQVypHvCoRk1692fMvvpr6tf1usdNDht2aHSTXWW0KzTPcfXHjRYMU4tqHnHNJ8aNzxne2I/cFHPknLvkaEX/a1KRCisNAvERE9N2J07NwByQ/51kxJQNls9v6d8Wc2pMJOiDTqBUOKZpZT5ZFiYaOoxAn5NO65F1W/sN1XUqLmjSEx5VRw1CSWa6uVBMZkUD/WiJLxuLZ8tBIUKzaBGcW1x6rz/7jNdeIhgzEo8thwhdhfQjVMJWrZYCZbVjJ/OFvpqn8UaIoGXRXYxNzq00jpGACeXpo//lQ7NlFhnCBsjzKbu0vqFe520Ntb0One6JMzoGi6Yjo+FfGa3xlthN66dzPBTdoZjKu0okePQx6EGvdBQFmeXHu1OQ14WR8MGzolA3iTL3vQU4/pnS3r1SMbnsDmShXBGXkNF6i6pzUulUDWCgo22TDMa74gub3dg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4SPRMB0045.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(22082099003)(18002099003)(11063799006)(4143699003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5OdNuOTtmAQIWnKTWHjQKmdXRRq8PIXmpU2MivSP2Xzjh6gwjmLiK3YgKj9K?=
 =?us-ascii?Q?PHf2umXVkXitVwgz6gD89snur5zUFuiChQgC9UBhjG9ezpwdqakcFvqahzxv?=
 =?us-ascii?Q?36Z7tlgkE/GFOCXbMcXl/OP8B6dcBwpQ69IzE2uSR7qWFlPCrgBRsOpVW5qc?=
 =?us-ascii?Q?5QHtx5StvdF7pG4KSemaBiRtcjDgVASOWRdF08R8FTWhrQCvCxnFXBb5rKe3?=
 =?us-ascii?Q?lnh8AZsfnJYeBTllv2pCoKuNwmsQmGNmDBZ4rILe40BM3uj241gXn1fCYhD1?=
 =?us-ascii?Q?j0BfqODqzKrVUhEFHhR+rMZQZiFTQuDSeyPdyjq2Xjo1dw662/yeIUFxZbD9?=
 =?us-ascii?Q?SafytD6sv/PoG7DXkEOgvY54zw51RBYV/ur28H0VV+vc5JSBazoFome1ltGJ?=
 =?us-ascii?Q?wJZ64x1Qif67/jBk3Pj58jmutJLbQQ0bAKOEJuFFxgGWVpmhAvkznW6zfIC+?=
 =?us-ascii?Q?VCOCOz7EYdSoFdCBI1oLW442MOW3GbKbqba7wbWywgmaqhxTiwghFFktEPAi?=
 =?us-ascii?Q?8A2Wzu5n+c52Ulp3yMIb4opE8OFjwN78GYdcTD8PpoI+xIglUMPOWJ+5ogyH?=
 =?us-ascii?Q?uKDWMVWvRS5LHJk3E6WU5EaluaKzvC9Ixl6yx4vEIFBB7p2oahK635PhusIE?=
 =?us-ascii?Q?xHRt4jBTETaPMeoDrimbwO/lcOiWU4zOGvLKm2YoMcTfbw36fJZwKSNqdBfl?=
 =?us-ascii?Q?ogQfK2+1q+UWOTOWVDd+WRKJ/APY+jQ6sDPgsVOD9DGw7SJ4dkQg29sWC4JW?=
 =?us-ascii?Q?wsHs2LPGpuVvdum+7Sq32QhTrP4mBI5L8Nr51Umz+knR7KZMSQL00kW1Ggqr?=
 =?us-ascii?Q?l4pTn1aMvaoq0N8dt9hy+FMpl4RmWzb3hFx6HDpCeXCdMGXqWHD1l3rCQhz3?=
 =?us-ascii?Q?kaAlRU1HV3OTV8yRv/zcSgPy4EbkhEdtYw5msKPWC+mFChFywZCrEnowQG+G?=
 =?us-ascii?Q?ABAr6R/5DQhd2gIbmR745Y9pY47eDMJ9P9jypHqfSSUjjl2d0/mNFC8dExHS?=
 =?us-ascii?Q?kaHsyOUjvzFXSln1h/Nl0WHAlPWKnTQXHk/XOJ6I80VnWJRXZl2IEVWdX/fN?=
 =?us-ascii?Q?mtciCMzzgwV/LsDXdD5Ka/1yLgJos5eLoXvTNrcZMN6z+SeiRX9Hc7YwS0Uu?=
 =?us-ascii?Q?U5wrK8V6v6/bbW9Ve1m6dIPg+4syw197kMJhvYG1SBkJku1grA6/Hce3IxMh?=
 =?us-ascii?Q?L+pm54cUup49iR2oexLBdYF/5LuK7DF5Cz2dkZYpc7MJnfI7+DRoFKj2OpGf?=
 =?us-ascii?Q?Bnmh2C1t2FhV/nlVRhl3vadjYAJJBYxd1jahmpLlTHkmSikPKz3neW/ypUmQ?=
 =?us-ascii?Q?tPnZIhXzAiUfmilf9MTgBF7NFaqS1yJXHFHdmyJ3U3uJiIh82dUx63m9COC1?=
 =?us-ascii?Q?Vaw3iHjR4oSLopuH5+CHl227sRCRkFeLlVzHpI1zS28h55Pj/X9ZINkED1xq?=
 =?us-ascii?Q?jBiMTITOuWSbDas6ldGkKNVOGvqNhkaYo8/4fF9Eha0CI/Jq7KdSzfbpvjDJ?=
 =?us-ascii?Q?ZXs8cO8KNnYJai+N+1insrF57Zm8Vk6Dq4ZPxnuRfztVzRp/V7CCn1Ezuh9t?=
 =?us-ascii?Q?zwjRQna7dM++W+EcrhJK7TzL6lSPNVa2VAwgx57SBETWZyEHEZMv2quTfyRX?=
 =?us-ascii?Q?Bxhn/QSOlHc+dfxSIM5ZjolRiF4R2e++SLOGGF5wmlExPC8r4GPRNVita5yO?=
 =?us-ascii?Q?8AOv05eLprDpwYP+ihoeUMYuvSy53hG1ROu70VUwqysr7Vy7C9xq4TAT/gBX?=
 =?us-ascii?Q?RACB//EcUEDyms5j4SrVhpnSChtsPLY=3D?=
X-Exchange-RoutingPolicyChecked: H7/xJgoWK09qw8NnuS6s0MXCKKqNtj2q6NcnXrPyDgobyEWyT2V8lK9/e7MFvsTHingVDMXnQlE3Ot9DrGQZ2yrPpov/0FSEBYRCUg2HIaMDFQauSrx7W7sfdEUM3jog5Qt32cL45gKD1DFYx3gL2pi2rF+VJTGhIschajJAm1ReYnE65i8A87VUPhv9o3Si4Mvxg94BVSRN99S2LS96ehuRIcurlcxHKFRU6GryGHU2AP7QPJaD5IBH1aQNCVKAC+wP4RCQNoFAQl6z4Qnns4xd24vJ0qESfqv4ZNghPEvhcqFfj6erpCQuRxPzyAXCj9CwEefC+VwUCfl9tWNDrQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 6084cfa4-5fe5-4ee9-0b3f-08dedcd9b4ea
X-MS-Exchange-CrossTenant-AuthSource: DM4SPRMB0045.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2026 10:14:33.5289
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SsfUjbQra/ezHD0tYlYTh+/CTtISdHYG+tR/0IaGMvUkgWoaeNC+ONvq0rBVHZBHh8/JO1sUewgLFit/22yINQHDaL83iDSZsVI7goOy4f8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR11MB8007
X-OriginatorOrg: intel.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-305746-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:pabeni@redhat.com,m:intel-wired-lan@lists.osuosl.org,m:netdev@vger.kernel.org,m:magnus.karlsson@intel.com,m:kuba@kernel.org,m:horms@kernel.org,m:przemyslaw.kitszel@intel.com,m:jacob.e.keller@intel.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[maciej.fijalkowski@intel.com,netdev@vger.kernel.org];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:from_mime,intel.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,boxer:mid,vger.kernel.org:from_smtp];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maciej.fijalkowski@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 84924724360

On Wed, Jul 08, 2026 at 10:51:54AM +0200, Paolo Abeni wrote:
> On 7/1/26 2:45 PM, Maciej Fijalkowski wrote:
> > v5:
> > - include three new patches to address last Sashiko review
> >   *
> > - do not release the irq lump in rebuild path in patch 7
> > - clear dangling pointers from rx and xdp rings arrays
> > v4:
> > - add preceding patch that fixes a case when some of re-init allocations
> >   failed and we missed de-registering netdev at failure path
> > - pull out i40e_vsi_setup() changes onto separate patch
> > v3:
> > - address UAF when ring arrays were freed before q_vector's ring
> >   containers (Sashiko, Jacob)
> > - remove bool params from alloc/free array routines (Simon)
> > v2:
> > - NULL vsi->tx_rings in i40e_vsi_alloc_arrays() (Sashiko)
> 
> FTR, I'm not 100% sure about the actual target here: the subj prefix
> point to the net tree, but the to recipient is IWL.
> 
> Since this is not sent by Tony, I assume the real target is IWL and
> tentatively set the series to 'Awaiting upstream'. Note that for 'net'
> inclusion you will need an actual, not empty, cover letter.

Yeah should be iwl-net. I assume excitement of satisfying sashiko (sorta)
took over and i messed up target tree.

It's driver-only set so to follow process it should go via Tony...HOWEVER
I am fed up with these changes and the faster they would be accepted the
better for my mental health. But that's a irrelevant side-note.

> 
> /P
> 

