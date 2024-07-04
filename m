Return-Path: <netdev+bounces-109190-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D12F927492
	for <lists+netdev@lfdr.de>; Thu,  4 Jul 2024 13:09:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC8F11F224CE
	for <lists+netdev@lfdr.de>; Thu,  4 Jul 2024 11:09:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ED2A1ABC36;
	Thu,  4 Jul 2024 11:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bCRDkI7d"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EBA21AB513;
	Thu,  4 Jul 2024 11:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720091370; cv=fail; b=IahNm8L36VuT2gM3//foO/U2ueSzKaQN/2VU9sxr6lbjlfEsEAzMaNaxPHW07OX7NV0llW81USeeOwMxT4KppYBT5Y3v7aA2X1iYSDvyBtYdTU6PldvBwOnhszdZxF1Umr6ttdPio8dozjkKVs0vIKbVR+uF9NLoLNDpDyh+hPY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720091370; c=relaxed/simple;
	bh=xFlcXSQRLzYQueQGzIC4URJ+mHKe7b+sLTbVHlvLibI=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=QI0yxDDmauux4PVJ1hEivaf9PL3wzYIz7uu//usHIwKA1YfFbfKw5D+oaUJDO7ktV3rR+TauAAY83BxQjzRhZIsOWuDqkXPu04OvFotTE0WJEEe0bldkMHE8FxHcUOYsG0H6gvb3U81KU1EFuVUdqueNLLYb5V0IZQFDLcqR8MQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bCRDkI7d; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720091369; x=1751627369;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=xFlcXSQRLzYQueQGzIC4URJ+mHKe7b+sLTbVHlvLibI=;
  b=bCRDkI7dpbpi1u4CHQ3qpokUnSZHhLTF3GZYTlvYfvDstHEZEhuGUpaI
   ukbD0rcnmnqE1RGr3ve9J9IW9YyvGfdTRRG5j1LBeJ+VluTQVhcW5PUAy
   lLcUmJfSn3DPwfyiRuYrkQZfO9NDIIY0I2ze6PvGYqQwVya5VdOKN89tX
   dbydevg63ffkEk5WzYaBW/DEXmAq4USmRug1P1cuzf3qv5kyr6ma1xxT5
   nYikh+t4uvQpcLvekT6+eOmQK8D1w+FG/hWdKX4YEwdyuTlT4Jwx6KsOu
   BaC7//nRszj69YMREI1xRCQX0/kkqqXMtY/JUIJmFQ770CM4k5AwdTPyw
   w==;
X-CSE-ConnectionGUID: vTjtoZU5QdSgkQZN0yDcjw==
X-CSE-MsgGUID: CZnwtbinQsqE5eZScFsecQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11122"; a="34906639"
X-IronPort-AV: E=Sophos;i="6.09,183,1716274800"; 
   d="scan'208";a="34906639"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2024 04:09:28 -0700
X-CSE-ConnectionGUID: qHhFrFs4QQ2apFjubh2zGw==
X-CSE-MsgGUID: jE78b+seTrKAq59JkDqBvQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,183,1716274800"; 
   d="scan'208";a="51153662"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Jul 2024 04:09:28 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 4 Jul 2024 04:09:27 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 4 Jul 2024 04:09:26 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 4 Jul 2024 04:09:26 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.41) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 4 Jul 2024 04:09:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V5y6sivjLTeJM0TsZsFZ6eFNVdX9X9vAqfkZxxEJSdxUDC5V8gJogjJT+sc+GLjaGlewEfWni8fcyPp+muJFL0/x1vwbeS/N9vwTrDXUroRPTXEUV4ky/vuYL6bgJLEyxg+EUk8RYHvnDUX/rlw9L7r8wFjN2ipKR5TBr0NeS3OqNalnYlX2bhrifhLp1TTnHh9qC6kTc7STEet4WBIpvD15Vzzxet7derYsrHr0SL2lPeoCuDH0t/9jFcbcJxLqpqP9Q7r9NqksPSC8wp4pLoelbEnkP6wBryAEz1Ap3ezktAV01ivpavpC1QkBDpMKnTZgVDg1yl9m23jWkJxr5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kvRShMxu8ENYQKvuGD1ARbRIh16vBuw9N7RnsKu6f9o=;
 b=R+DRE21ctRkXYQob2kQDrsM9PkU6IrYWCVjJvzcCrfmr6UtxuzA65ZyyuRJ+VNWVzvFw6RGbKdQaZnqLJpGPZexUigUDibU0SDzZG3gsZy3ZuqRGaZTZc81TceO4NPIsEoCbv6OUWM6YZ89V/Q/RHwuwlbFF54r9xyvU8s+kVjgrti2q+rVo41D/VFwmxu39d49icGrkVvoHvywYipwse1T00LZTwCngXq5oidbjIHW6MT0Nik3wS6mRMh3SI1M5LAR62df3sbIURc6VLlAkvsLAAGhxvJ7b8JDryZ82XcMTSVGPdPgvF4Y2hj6xiV+QN5URF/TuZE4IkBpY4YDV1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB5782.namprd11.prod.outlook.com (2603:10b6:510:147::11)
 by MW3PR11MB4522.namprd11.prod.outlook.com (2603:10b6:303:2d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.32; Thu, 4 Jul
 2024 11:09:19 +0000
Received: from PH0PR11MB5782.namprd11.prod.outlook.com
 ([fe80::9696:a886:f70a:4e01]) by PH0PR11MB5782.namprd11.prod.outlook.com
 ([fe80::9696:a886:f70a:4e01%7]) with mapi id 15.20.7741.027; Thu, 4 Jul 2024
 11:09:19 +0000
Date: Thu, 4 Jul 2024 13:09:04 +0200
From: Michal Kubiak <michal.kubiak@intel.com>
To: Daniel Golle <daniel@makrotopia.org>
CC: John Crispin <john@phrozen.org>, Felix Fietkau <nbd@nbd.name>, Sean Wang
	<sean.wang@mediatek.com>, Mark Lee <Mark-MC.Lee@mediatek.com>, "Lorenzo
 Bianconi" <lorenzo@kernel.org>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>, Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Russell
 King <linux@armlinux.org.uk>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-mediatek@lists.infradead.org>
Subject: Re: [PATCH net-next] net: ethernet: mtk_eth_soc: implement
 .{get,set}_pauseparam ethtool ops
Message-ID: <ZoaC0C/pek+6/mRc@localhost.localdomain>
References: <e3ece47323444631d6cb479f32af0dfd6d145be0.1720088047.git.daniel@makrotopia.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <e3ece47323444631d6cb479f32af0dfd6d145be0.1720088047.git.daniel@makrotopia.org>
X-ClientProxiedBy: MI1P293CA0003.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:2::19) To PH0PR11MB5782.namprd11.prod.outlook.com
 (2603:10b6:510:147::11)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB5782:EE_|MW3PR11MB4522:EE_
X-MS-Office365-Filtering-Correlation-Id: e8747339-3142-4969-87fa-08dc9c19c044
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?LrG4HK/7bQqQir4aJbxATSLBCTkx6Tm8AGHVaB4LHvGBayZAqXbxlqxlsRbU?=
 =?us-ascii?Q?T1uZ9dpru9bnhIYH5UAuSyE+vOI9q6yyL9ml6Nwn/pxsScaY6y29UE+FNCS3?=
 =?us-ascii?Q?MdTCzuzBVnbXMpKKxRf+LdSkm6FWiLumLuisIcLVlG471qCQhF4/atqrKlTT?=
 =?us-ascii?Q?8tJ8RHH0nvbLvNktLmW0UoEqs0nKaS063iE+nmcU3IBed+SlI71Rom5IhrlF?=
 =?us-ascii?Q?ZXNU94Lq5tQGyr32y8cZ8BPIc+YDwBVP1s953yXRM6ovPEy2x+XAaCLRgvio?=
 =?us-ascii?Q?NvRSBuXkMBsVo74JZ7G4tGMs/4RCEHx9aQvOoB7FthjCwc7wU7/5E5/c1RPv?=
 =?us-ascii?Q?ydvph6GvE2VwWAtdewTWRH3emBUXiKho0MviUbhIpEw1CWbn4MKkY+3d0yre?=
 =?us-ascii?Q?e12UJ6LRcOp5jirtoUf+mS/S1mCvtESrcu5CiTI/SXBeksmcmWEbni1JV8Vz?=
 =?us-ascii?Q?kZW4Vx92xKNPZub5hRJaGsGOnZLFMLX1CGWnq4euibLt9QSHj/uBaDKHNeNt?=
 =?us-ascii?Q?uab7EqXnI9Z/cPOd/StJC6wNczw8hO8Bj4poIw0w4Y+hZDEv72TOJhjA5QeY?=
 =?us-ascii?Q?++QZocMOnMx1ymoDC64k0lCl0K5L+r2UlBacfpvhD3EQngrjKf2lVJSYy+z7?=
 =?us-ascii?Q?8ixt/+eniFQGjWNw7XtNThwJBLjf3lUyo8mwdEvcBd5ScJY2NG7scddoDJlG?=
 =?us-ascii?Q?AXmv6PCn+lfzk82nsrQU1rNorRu5h0HBGx7/K+4SRdjO0zrnQOhZKeN4Wqpa?=
 =?us-ascii?Q?fHACtco/+jON2Uah2C2nF2X4qQzkjoBZd5mQTBTtvrP/L3skCG0SBjBCRggY?=
 =?us-ascii?Q?ozud9DM2D0FE/UtuYiLYR8UWPp4j2QEmhMljYpF5jPg0hFhhyyKF3gnR3X/l?=
 =?us-ascii?Q?e/hFckAPliL08TouwpRcoyzlOOM+VLY7F5+ysQoH3jB6iQaxFIJAmbI1c6ex?=
 =?us-ascii?Q?zSxRtKwAWK0ieg3Za01zQHM/d4LkWQ3ZDSeBzVZZYKvov8mgIkfAtEb4RcZE?=
 =?us-ascii?Q?VZt1fQgTrp64QU5SGPkXQ/GGwmChsIvNfM9c2/0f33Te6EyQFUF5GzN5pe/D?=
 =?us-ascii?Q?cYPmL86I/365QHCubylr822YyVNRUpKMjB1CUCFoxQbTSo6vkVu28TZDlNyc?=
 =?us-ascii?Q?W8TsqEKgGpXUR3fTzc9gU83sbbRKZta1jOuiCjLLwpaf4bEFGlOOLI6NGhgO?=
 =?us-ascii?Q?47+XNzyx2LnlsREffKkPqXYlwQGybf10Ix7VupT30STf2nhBnV2qe0vxPBHs?=
 =?us-ascii?Q?RRAJ7eMRg/u/TDB4SYLqJImKps3U3jQJk9hoNpJn7/XIx43BTlCbeiI15pnC?=
 =?us-ascii?Q?c7eN1JYMuuSFs/VEQuvgMWy9grSb3KSCtq0sNmAj33hmjg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5782.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ozV7ZBjA1XnPY6BgZmWrwhqfISVLR83HmlFDkX2806iOlyuy8Q0WrPv/VDSU?=
 =?us-ascii?Q?8uJT6URzVo/QsKm+gzKZ4dFkSzheM5jDPtgEWzWBzOj7ZqqNz+Pl4ULydzpx?=
 =?us-ascii?Q?+ZpdGUEwieqeXSPCmF9w1LJhg7JdxZo2Fv+MyKFWdoPB4agz1cFfs2b17tec?=
 =?us-ascii?Q?3kENs+GMyb5JgIG7ofkvTRwrLQCO6Sv0ctOt8XN32A3l/KZVl83mG2wPXlkP?=
 =?us-ascii?Q?b9hwyVVt38CZ2kArUWVSH95hb/Sa+mKDfNyMipDd7lawulnSJT1bmg0NyVSC?=
 =?us-ascii?Q?Sriy/xRm/G6vZJtu69z77njQCztqRpgix9Dmo4AnwQglcYeVfD3RWAR1JPrN?=
 =?us-ascii?Q?umXzo/+iQVtY7wWPfGV4Vk9MTIE8YF4zLdz0pRi6kYnrIL2yZpbkAxu9uAm4?=
 =?us-ascii?Q?tPPoPx7YC+j7TCCyeNzdXftsA2NtzMiDOkW2TSiE015pxFTgBttZz8ZsrR1w?=
 =?us-ascii?Q?R64VXU+mgdaNJA1iUKsudMz6mXt/AW6Xx4V8UPDEo77v5vujkvvxRNLywsYm?=
 =?us-ascii?Q?bRAhhhvRx+l80PGPVgzsPiPbINVkHJLjQuBIEbLnYYYQOLYSwmzTiM2kLJxK?=
 =?us-ascii?Q?Twc4HYXN8VL7vLqZjy7L4Swn79KVbf6wQKNNLeN4uZzC1tG0ribz5/VbeTgv?=
 =?us-ascii?Q?6Jx/7bvTv5gUY9nw7ObOBmlGlWHG5a6BKYisFwlX17KibglU7fg8iCuHLYA5?=
 =?us-ascii?Q?pGODX2Kv1PZazyL2Fm8eFOhGLHXQ0HcK0NCsIRHULjT4la4Bzr9xsww6CGVh?=
 =?us-ascii?Q?dpEsOa4YhWcEFE1fyUX0aR05ahUWn0SUd2KNLFCr0En+pEYTckUHXlTFpJSu?=
 =?us-ascii?Q?1tI49u9/6HjwfIt8PUC9qMDU61dCRcKGxz1AFgah5pCa8cuIMS6fAM//nhMm?=
 =?us-ascii?Q?/+mc7AU2uVfz72sbdoZeQJWdj1m47nfOYq+WLyIwGc7/2wEQcQP4uRRA7w0w?=
 =?us-ascii?Q?kWmbuBr6HuOqJjOBDrbUk057D0UPCHleUfxZTYFm9sY/LooIK9ddbrlkjQvu?=
 =?us-ascii?Q?VA+B3PIEjUkxW027MOjNaqTOzXHQBuaEgwky5iJLtV6pwz/QNXS3+M5KwoEf?=
 =?us-ascii?Q?mtMqDGGIQzXyH9k7tuyLNf16g1DhLTbjcuXra4UNvFeRf27/s84hHrQ09Rmh?=
 =?us-ascii?Q?/bTkRszgUsQ9dLypYYkTSyYBVCz86HpGwxQBgD+4PRKE4dUf61ufrJz+vpcv?=
 =?us-ascii?Q?1tQaRanOeDSpRZImVv88v/rs+hUqJxBL7qMTvM/AW0U32yqn0Z11stshO4LN?=
 =?us-ascii?Q?YVgiQT50hNRmrBTs/F7M51PRQIMkfcWW5EQoGH/hh2mK9JgOG85Dsp74/F/D?=
 =?us-ascii?Q?ZH53p2gP5xpw981uVL8tt8rh0qP7QnI9RIz/1X541Lf6+kLSHlnvixbTTCO6?=
 =?us-ascii?Q?mGApg9xoSqqXylxkzYAojNaVbB9CxCauOQQloWMBIDlKapUfGV8YrCEK/j9P?=
 =?us-ascii?Q?GfyCo6ImtwjAUqHZ24/wGObja3PSDfUVU4vL42AblEz16wkLgB1x0jvqigdi?=
 =?us-ascii?Q?AKZQv3GAU5p425dzWXxtf+GrwXD5Aeeikdusl9QGwZGJwhnlHh/NkBSpECtv?=
 =?us-ascii?Q?egIMf8nvKemhoXy+KFRqA+eqF9tj0AbNrPeI0G4iFqT9af2SJ38aW0C7ps/v?=
 =?us-ascii?Q?1w=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e8747339-3142-4969-87fa-08dc9c19c044
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5782.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2024 11:09:19.4504
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MffnwU6iYwkfhwEHJI5V+5UybW4qT/USWEG3a61PJr/4exWC2xnD8NwLlC1PFp9z9VlchaLfho13fUENW6ACgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4522
X-OriginatorOrg: intel.com

On Thu, Jul 04, 2024 at 11:14:55AM +0100, Daniel Golle wrote:
> Implement operations to get and set flow-control link parameters.
> Both is done by simply calling phylink_ethtool_{get,set}_pauseparam().
> Fix whitespace in mtk_ethtool_ops while at it.
> 
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> ---
>  drivers/net/ethernet/mediatek/mtk_eth_soc.c | 18 +++++++++++++++++-
>  1 file changed, 17 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc.c b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
> index 13d78d9b3197..fbf5f566fdc5 100644
> --- a/drivers/net/ethernet/mediatek/mtk_eth_soc.c
> +++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
> @@ -4464,6 +4464,20 @@ static int mtk_set_rxnfc(struct net_device *dev, struct ethtool_rxnfc *cmd)
>  	return ret;
>  }
>  
> +static void mtk_get_pauseparam(struct net_device *dev, struct ethtool_pauseparam *pause)
> +{
> +	struct mtk_mac *mac = netdev_priv(dev);
> +
> +	phylink_ethtool_get_pauseparam(mac->phylink, pause);
> +}
> +
> +static int mtk_set_pauseparam(struct net_device *dev, struct ethtool_pauseparam *pause)
> +{
> +	struct mtk_mac *mac = netdev_priv(dev);
> +
> +	return phylink_ethtool_set_pauseparam(mac->phylink, pause);
> +}
> +
>  static u16 mtk_select_queue(struct net_device *dev, struct sk_buff *skb,
>  			    struct net_device *sb_dev)
>  {
> @@ -4492,8 +4506,10 @@ static const struct ethtool_ops mtk_ethtool_ops = {
>  	.get_strings		= mtk_get_strings,
>  	.get_sset_count		= mtk_get_sset_count,
>  	.get_ethtool_stats	= mtk_get_ethtool_stats,
> +	.get_pauseparam		= mtk_get_pauseparam,
> +	.set_pauseparam		= mtk_set_pauseparam,
>  	.get_rxnfc		= mtk_get_rxnfc,
> -	.set_rxnfc              = mtk_set_rxnfc,
> +	.set_rxnfc		= mtk_set_rxnfc,
>  };
>  
>  static const struct net_device_ops mtk_netdev_ops = {
> -- 
> 2.45.2
> 

The patch looks correct.

Thanks,
Reviewed-by: Michal Kubiak <michal.kubiak@intel.com>

