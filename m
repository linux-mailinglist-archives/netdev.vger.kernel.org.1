Return-Path: <netdev+bounces-195103-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D379ACDF97
	for <lists+netdev@lfdr.de>; Wed,  4 Jun 2025 15:50:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F4FE170FEB
	for <lists+netdev@lfdr.de>; Wed,  4 Jun 2025 13:50:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F187828EA65;
	Wed,  4 Jun 2025 13:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="g2gQ8nri"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F45024B26;
	Wed,  4 Jun 2025 13:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749045034; cv=fail; b=IBm69PPZvlGaRVfOB681dAoUv8jpW24ZcS/cxu2PS2KMiM+Qa9zN5Y4z2aGY0gAimMQdEIgdb51ZyTCXaJj7LMfG0klh7H853V0SW1+NpjTGkx/buHq7OCyc1UVAuXrgo36wvgxXUEDx0ShbUy6F/WOWk5mrIf04RJVuUnhxcn4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749045034; c=relaxed/simple;
	bh=HlGoa8UiiMMuS4hacK/b1e917LJkP5kv6nZ1F2WQQGo=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=t6fumkPs7cLqGLGAWruEMizqonbiWByvdlvTw0vOsKx4vjpzsPExHxp5XJ/thrpjBr9LvPmUY1+kfQkyqwZfS1VDxBOVoV/wZH4Oio5zE35NdfekB2fZog9RjhnzyAae5wH6rZOQ4TddJAGvblQjX977XVvyQPLGCWZxWQMMEPE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=g2gQ8nri; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749045033; x=1780581033;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=HlGoa8UiiMMuS4hacK/b1e917LJkP5kv6nZ1F2WQQGo=;
  b=g2gQ8nri5N5yVrrex1c2/Twc+Kte+lGXw2fSvZmfZ6Q5IHetW2xQPHOR
   gbSFmG/KK/t0LG/z7jeqiM/dVmKLrlc4P+uZ9Va81pgUQ0z0IDaYYF8Uv
   jjP3PLHsqGFbioyQxwC0dzOI8wn1Om5+pmg8lUV3zXAI8UYOZ4QTGlIPi
   /U118kEEYqHvmmvnJ3TH8NiQfTfneSKQig8bFrZDVhHAnIUiCohFUDJEP
   jCvLrviljtsLfzwDKZNEF3ee9U30vSGfCEEgTJJ9douM2AyeAW4XomItE
   QE9TBUPDVwvtMKOj1IWyufxOKls/HQ2T/wboygdfDVwMb94B7gD7GPX1V
   w==;
X-CSE-ConnectionGUID: C05J5l7VTfO9e5UJo8+jcA==
X-CSE-MsgGUID: WvTgE89wTNaPTE5YFUtStw==
X-IronPort-AV: E=McAfee;i="6800,10657,11454"; a="68676491"
X-IronPort-AV: E=Sophos;i="6.16,209,1744095600"; 
   d="scan'208";a="68676491"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2025 06:50:31 -0700
X-CSE-ConnectionGUID: upHiWPWNTPSPYOLRPGxMoA==
X-CSE-MsgGUID: dCHObAR3TFm0jE5P8vkjOg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,209,1744095600"; 
   d="scan'208";a="146139915"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2025 06:50:29 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 4 Jun 2025 06:50:28 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Wed, 4 Jun 2025 06:50:28 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (40.107.220.88)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Wed, 4 Jun 2025 06:50:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eIUfMd5Vj61WSB0/i0E6fJ7CEVp9xZydZRWZktM5kB6FkFQFQvGExgYSb6SldnrRVdXKOIltz22Hefxa3CfkveLPo2OJiX+cFPI8k/pRCLCM4I5NDAxQ9rNrrMP/nI/CUVmoc7TPZH+eo+wQ9vVmOQcLqUVnJEbEviMEFyE5uV35/3F7KYTGtcj4Q13R/GAE1k/NdMNPeKKAEcxT1pGmIKhto6dJh7866rhTcmFG0uD34UX9VRlIWQVk95/b+mAyJdcRH0MMHsJmKWrHbF67YZrwpY1czbWqlXCqWPSKD55hfKBUMJz8J5XbBFjwYu5nRrviHRSb5y/4sK2Vek/abA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6l11bKcK07BQX5qd26p3yfcf5fk1ASLgTTjNETnDSK8=;
 b=pCTFH016QNiJkUP6PCp0KckO4bn2Lp1/pDG0W7DLdRB2ODkmjghE3rnokwJx0T+Yk+Apz9JQeF8eor2vtmcmwos4UyuOkqav7etECChNoXJAU95R+5z6NT+TO5VCg/J0EIz2XCVwsLEMwoaJiWDCFcKFlsRA4nUCApOKO/cs9OvphHfcbRfC41biBDrnRW5s8Yx2+gHuGLNQjFLqBVXib/IusKARKjheB37411h/yWL0zLTwnPtvdfdAoFO00m/esvg4wJjN1JRY7cqFnMKg4OAy06+GJoFQtsmmgKQ/kMaIzE9wbdpY8h8lBCGbc/7/+AFNEmMrJjHaCALLkSro1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 CY8PR11MB7172.namprd11.prod.outlook.com (2603:10b6:930:93::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8769.29; Wed, 4 Jun 2025 13:50:26 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca%4]) with mapi id 15.20.8769.022; Wed, 4 Jun 2025
 13:50:26 +0000
Date: Wed, 4 Jun 2025 15:50:15 +0200
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Eryk Kubanski <e.kubanski@partner.samsung.com>
CC: Stanislav Fomichev <stfomichev@gmail.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "bjorn@kernel.org" <bjorn@kernel.org>,
	"magnus.karlsson@intel.com" <magnus.karlsson@intel.com>,
	"jonathan.lemon@gmail.com" <jonathan.lemon@gmail.com>
Subject: Re: Re: Re: [PATCH bpf v2] xsk: Fix out of order segment free in
 __xsk_generic_xmit()
Message-ID: <aEBPF5wkOqYIUhOl@boxer>
References: <aD3LNcG0qHHwPbiw@boxer>
 <aDnX3FVPZ3AIZDGg@mini-arch>
 <20250530103456.53564-1-e.kubanski@partner.samsung.com>
 <20250602092754eucms1p1b99e467d1483531491c5b43b23495e14@eucms1p1>
 <aD3DM4elo_Xt82LE@mini-arch>
 <CGME20250530103506eucas1p1e4091678f4157b928ddfa6f6534a0009@eucms1p2>
 <20250602161857eucms1p2fb159a3058fd7bf2b668282529226830@eucms1p2>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250602161857eucms1p2fb159a3058fd7bf2b668282529226830@eucms1p2>
X-ClientProxiedBy: DUZPR01CA0343.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b8::23) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|CY8PR11MB7172:EE_
X-MS-Office365-Filtering-Correlation-Id: dd927878-b591-4ca5-e116-08dda36ec280
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Il7xdBZly1WjqV4vjeZIsRUSZoVgnOHPrAMUYhK9qH0upHktM3jGN6DSPXYk?=
 =?us-ascii?Q?dd0sf/aV0nNb39OTN2/90inDbzAG4F0DarJLJiScP0YY5et1D3k1f7zxwbX0?=
 =?us-ascii?Q?wjC1dQNTkUjAbz9es1IB/rBkLyhZDvhxy4GRmLK1da2f3n1LaH1wjoKuP0j1?=
 =?us-ascii?Q?hF2ydbE9ZYyARY+6AoaHQoH7AFHxvnbwsD1u1/oa4GyHbgz1qLx/ZytrCR4X?=
 =?us-ascii?Q?fZXrBvcK76t21FzYtwypDZUzVd2PNVSxUv3Rm1hwDct6ihvNV1tHnH4PMvsI?=
 =?us-ascii?Q?QlBin8Y07IrfDGzqO8/XXzMKTFb+OJoowwqUXJ26OELY8nyzQD6XjlXmTn8+?=
 =?us-ascii?Q?cW4DBsLNw/9Fr9iUdKVj8WvdGQ5Zr1A/iV3O0UMXcjsV0w3XCRc58NDF9ha2?=
 =?us-ascii?Q?QUK/xS6lprOxwvtK3uxrB5Dr+4A69sI2hz0U8/OjBllhxVIe1sgWl4cvHG3t?=
 =?us-ascii?Q?H+L5ePI5L+DggGGrYhGhi5qBtsJHv1DDKAr8k/l1TF+9S6qQxnqXaHnmo5Zs?=
 =?us-ascii?Q?9YC2qvaWDkd43Et/DFHqNiTulI75fWV3+nlYIx+lPRvdsr52kj4RLedzL0jo?=
 =?us-ascii?Q?SiT8xrqlw/TGHtbqtzDPKWWQgT7bY5q68Ka6kDkAt+xgoUKSXfwpofv0iqZ4?=
 =?us-ascii?Q?qZhaJ1SLTh5mlBrg8E/yMIRBF3ri0e7J4S7U6aELm34SqJULX/T63ZwevfH/?=
 =?us-ascii?Q?oDrRntgNsrwUR2A3YA9So6+tOxazmVGDvTp5wpEmQKYbnLCS0paTDYjZ3T+e?=
 =?us-ascii?Q?FoC83XjjsDRM6QB6b59uwfLvtpe/gpWoPBKmhKNdzn6+AEXIBzLDWR8lL2pG?=
 =?us-ascii?Q?H4p+o0RVKCPV6gzyZS/2jusszDXpB4EpbgYVJHUVK2PJy811xK0Izfc+LmQS?=
 =?us-ascii?Q?gxx5zrpEaHfIYLuCA9zJf3O10E5/pq7/8pq3XwwqpYtrmjM59zSGUYeOrL6L?=
 =?us-ascii?Q?Hq7IoSp2n8Iz681bq1qHkxQPJ4NEJHCXMpn+ozGovdzei5vrPizM7hkCVJP7?=
 =?us-ascii?Q?KE0BYlNNgu84n5Al/CzCU7UWVV2k0gD/FWVyQv7TmCgMIV6TCzmKmMaE+rpY?=
 =?us-ascii?Q?NjBchU3RvtnMRH6ZKcSIslVK5x09i6HFht482j0d55oVB1N9GSj3Of3sAAs4?=
 =?us-ascii?Q?0SDclUdGF7J6et2Mc8IUfhj96sCRMj0KnvZnX8/AF2lIZf++13c/QdlfTn3h?=
 =?us-ascii?Q?dXwsz1h15HA+jjJOV0fXsq0pPzJ5v1gjphImgUw2gvUvwY/ZctEZ1EnwMTdZ?=
 =?us-ascii?Q?mMTJrPSm4lsRrFZnJB5uvGhkLvxc/OYVZ92nnNRXQj7g1qC5ppPBfrQE8dVV?=
 =?us-ascii?Q?/483AdMa/7plQGIMih5mWmuxd2U53Z9N+BF8aC32VCX5islSL9fdf0Q9yGnp?=
 =?us-ascii?Q?3eM0psdvaI8M8cRZNCZISWJ0NF90HdwQh9VKL4crpQ+ieFYmhX4Zi3Qx0n48?=
 =?us-ascii?Q?VTX2C0iUpJA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zcSamHsX1AhU+bvdz7iGx00QC0/4rO1Op3jgzDEvRDw1fmM9fW9RnfzxxXlA?=
 =?us-ascii?Q?IyWyzq/UyjqgASBr06tkH/Sa8LMsgXpSFdOjIc10DJQ0bfxlmU4BlM5fS0gD?=
 =?us-ascii?Q?U99weQrODqI0RAsYh5pkKOIiPOFfQqMW7KGWIgNmhlM5Js1HA3EBAu247F4Z?=
 =?us-ascii?Q?dPY2/yNeiD4ut+FwiC+RVkb4Y3IVi7hVKW2EZWcl0ZMEEIP8eEDK8IAPysBT?=
 =?us-ascii?Q?vzNk0/vBKBpptuiQ0UmpLe/i4T5fqEgjDFh5ghYxFJ7pnnZm1zZ82Fr78UzQ?=
 =?us-ascii?Q?41oE2UNdPFzqvP76MdE43n5uLKEFjdk1qnXqftyNCsFD/wOxOe5yuYmfZ2jS?=
 =?us-ascii?Q?vEwr6yIcVj9S77wRGjcBN5ZY3YhAvLwMHRVvOuw3ZWTTcwd9nO809L2xN9X+?=
 =?us-ascii?Q?02kT5KCkQGeZvi/EAzFz4IMxQfbrNUDBRdbStgThb+9yOYdCJRlDrVIuiQfV?=
 =?us-ascii?Q?jHYcMln/RXUA5l/tZpzjLqq0xD9XAkYaaNgexLa9955gU2PP9ddn02oX4dvS?=
 =?us-ascii?Q?QKKy16WXjzErGNV8246jndrbGwgMGJHodxg/+feAw0rvTbhYNKRvRIRQm7Y5?=
 =?us-ascii?Q?OJDv3H3EpmjyqHn2/oJPIXdIczX+8FBNDvj7U8XuV5XlKnq6dq17ifwl4rtD?=
 =?us-ascii?Q?OO0sg8+ah29ImzGNT/oqOWEBCb1K9fbUPkgV0klVQ3Qool+b95CNB//su4nX?=
 =?us-ascii?Q?59jfLA+snvS+hkOszWcADP+iXhOL7Ss2iXaEcmQiAD3y+2ZdhdKTDvXN6kqj?=
 =?us-ascii?Q?JuTYDkwO1boeTtAH0nRvWLhwdhyRpfU0nfX6iSg1kNax/irHVTzJI1AhG9xI?=
 =?us-ascii?Q?/KvOEjfPNGJhpm5qY+O8On/A7TEFf0txvdhVKZByTWLf9sT7xr09QnjqPO+w?=
 =?us-ascii?Q?z76CoOrTCjoDEzA6INkACYmFNhUEXSXM0gqOHHEl/6CrCSM+T6N6im2oBnUs?=
 =?us-ascii?Q?DZ6mNYS18Le1UyOtNfVDAp2ZFing12X7H91Cp8mUumIFyGl/BS8bYc72qc5l?=
 =?us-ascii?Q?fmmKkBS20WAKaWTitzE5x+Wd3U/nJePXj5oIT0vg2P3+37gcSWXTntroJkUL?=
 =?us-ascii?Q?bCjvQ2hjU+hUdZNXOG7wbwDp6rAo35Wzq6goNVE7sIBMgdKAGmeQhv0Rs+ri?=
 =?us-ascii?Q?ZcOJqQD8E5OzUjm+gvwixRGh+SIrQ6wztCpzHUGAYQjS4hHWt5SGhdz4KiU1?=
 =?us-ascii?Q?H2EMsy37HVvkeqFrCNhJ8n1r8knJxt02Xp9ErT7lPzbvvUeJcx5n1Cp0/g2x?=
 =?us-ascii?Q?mJD/FPrVFusepoana0jSVtrGvmZV6ZWcAHQUEgoOn1vwXwpdqvEZzJDkOJ+x?=
 =?us-ascii?Q?EGe6Jp2bmcWgmyA4nXjJpCCQHesbaS5oItPqqC+BXUeb3qgeUCFv/L2vcRNa?=
 =?us-ascii?Q?Q5lCQ5hGS4TBhJsoB6oTZWCOhXNrcguNhjRDHDOOdge8eJLabdVMQh4WtF2R?=
 =?us-ascii?Q?U1kpiAXJ0uFh3jvVMU2n8ROL9TM2BcElOTvbBk0Puqu8yXT/3Ht93F2QJocx?=
 =?us-ascii?Q?ia1yanjMTFo3W6adhmNWy4zH2vespA8kUie0ssUk+87J9efxR08IdN/Ezu5T?=
 =?us-ascii?Q?3p3hHNLc3vHHDURadVB1mbXlGhycDHDk1TKBYp0JXFQQDVY7oL+2y1/krwH7?=
 =?us-ascii?Q?3A=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: dd927878-b591-4ca5-e116-08dda36ec280
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2025 13:50:26.3214
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i/LGz3b3fzMqYSy+AngzZK62Jwk/B4UhoqWCNVM9ySCIehlrjMCKeuKZVmKEuvhrjhm6ydrv6GkhnVPNrEJhutXgDDdf2omLcdVAXGkhBAw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7172
X-OriginatorOrg: intel.com

On Mon, Jun 02, 2025 at 06:18:57PM +0200, Eryk Kubanski wrote:
> > Eryk, can you tell us a bit more about HW you're using? The problem you
> > described simply can not happen for HW with in-order completions. You
> > can't complete descriptor from slot 5 without going through completion of
> > slot 3. So our assumption is you're using HW with out-of-order
> > completions, correct?
> 
> Maciej this isn't reproduced on any hardware.
> I found this bug while working on generic AF_XDP.
> 
> We're using MACVLAN deployment where, two or more
> sockets share single MACVLAN device queue.
> It doesn't even need to go out of host...
> 
> SKB doesn't even need to complete in this case
> to observe this bug. It's enough if earlier writer
> just fails after descriptor write. This case is
> writen in my diagram Notes 5).

Thanks for shedding a bit more light on it. In the future it would be nice
if you would be able to come up with a reproducer of a bug that others
could use on their side. Plus the overview of your deployment from the
beginning would also help with people understanding the issue :)

> 
> Are you sure that __dev_direct_xmit will keep
> the packets on the same thread? What's about
> NAPI, XPS, IRQs, etc?
> 
> If sendmsg() is issued by two threads, you don't
> know which one will complete faster. You can still
> have out-of-order completion in relation to
> descrpitor CQ write.
> 
> This isn't problem with out-of-order HW completion,
> but the problem with out-of-order completion in relation
> to sendmsg() call and descriptor write.
> 
> But this doesn't even need to be sent, as I
> explained above, situation where one of threads
> fails is more than enough to catch that bug.
> 
> > If that is the case then we have to think about possible solutions which
> > probably won't be straight-forward. As Stan said current fix is a no-go.
> 
> Okay what is your idea? In my opinion the only
> thing I can do is to just push the descriptors
> before or after __dev_direct_xmit() and keep
> these descriptors in some stack array.
> However this won't be compatible with behaviour
> of DRV deployed AF_XDP. Descriptors will be returned
> right after copy to SKB instead of after SKB is sent.
> If this is fine for you, It's fine for me.
> 
> Otherwise this need to be tied to SKB lifetime,
> but how?

I'm looking into it, bottom line is that we discussed it with Magnus and
agree that issue you're reporting needs to be addressed.

I'll get back to you to discuss potential way of attacking it.

Thanks!

