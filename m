Return-Path: <netdev+bounces-153082-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5FE79F6BC1
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 18:01:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F13C77A39D3
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 17:01:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02E641547D5;
	Wed, 18 Dec 2024 17:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Tlqzo/JA"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 683F31FA257;
	Wed, 18 Dec 2024 17:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734541209; cv=fail; b=bbbs0schfjBKZkhg1a0DTcqJpDuO1btwsqY/Nl5s4DHWZ0TZ/hzNVxlp4Biky5nWkmI0PIHI37MVNbe7lwpJNZIap99YX4EbW8ihQifvrQKLOmtCJP8MI+M7BcXgDJtpy2nhLuJ3U9inRzxAKtd4IldigcHz29BDSE3LsFYPBy4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734541209; c=relaxed/simple;
	bh=CvmJt6BZWwRtE5mCBgDWdIRwBLpTbukBYYDZta7dEPk=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ShBBcvfbj/14zYZQAULohP66Zr5ncXLVZVE9RBgGEKpal2vz5x6wLs7garu5qyMAWu5zs22bI6AHEbcy9Ywz0lCxv7v4tFxCpEnI4tkHmaiipruPgwpLbselzcPQ7oP1mm7d/bWiXOOyN4djOdE3TvmgtYGk0XkTZ11vGvyM1UI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Tlqzo/JA; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734541209; x=1766077209;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=CvmJt6BZWwRtE5mCBgDWdIRwBLpTbukBYYDZta7dEPk=;
  b=Tlqzo/JAGETAOtZwylYiGOLxTKzsbTVRXLpZLYI9IE5NXbgsxL3Qf8xl
   hqisxkqn4v58i++yS6uFH/ZCoYEq64DPj7wQxIijC3oRKeGVPjDWY131q
   4oe+w19UYril6x607vG/cyIDO0Orlj3aWm/3Okpku0jbrKhgxNt0Ac2Om
   REbr6FJ+16EPDjsvBHw3xtvAN5kW6NfhZao+pGu6dwyjiptYplzNprvve
   1OKmTe2ZZfnVEDIPYui1BaXR9J5E8clozMa7GdOWGjHG5+4Q0myxy9uL+
   r0+Xzxn9Aqr4CZzdCkJpjCwlJqPGnqb+5OxWQ/Oav9qDpv7zMCNLmaz1/
   w==;
X-CSE-ConnectionGUID: nQvz/mftTyKREjuuDjd6nQ==
X-CSE-MsgGUID: AnezO6DJTfioexJduFXo3g==
X-IronPort-AV: E=McAfee;i="6700,10204,11290"; a="38808185"
X-IronPort-AV: E=Sophos;i="6.12,245,1728975600"; 
   d="scan'208";a="38808185"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2024 09:00:08 -0800
X-CSE-ConnectionGUID: PD3/jQQJSYydX1ABOrGb7g==
X-CSE-MsgGUID: k0yEzSNaRG2TmaJxysVO0Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="102064106"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 18 Dec 2024 09:00:06 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Wed, 18 Dec 2024 09:00:05 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Wed, 18 Dec 2024 09:00:05 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.177)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 18 Dec 2024 09:00:05 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bte20Tm264HLwwiyJQfxHCy9W7ZrA9kyXAWZGp4xjl6BiUQ0t0blNOE6rkQRRlQrdsD7LAmz7e13GPFpC8UAnQ3Xfruhkj2mZh1EhvN5kxc3yLMzDvBNnoM/xF0cckQGmXblFRMBvkxQeugBT4QXV9sxoOJPsTGDYaYfeGSoqtJ7OZozAQ85uFKmgu1nL6tjha1xYgBbNbLyjMXGfOCW1BBlwUerQ2u3rdrfbLCN6dbziE6UN5yCsLED58a33I9MSs8pNN7FYtULnQ4uJo/VdgSGkOdN65NyXCfhvZDIFEinNDLleSmlp4NM5qfGAsogezs2lGAQDwCKl35H9sowdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qAV/FBBiGwF2AnVJInOXobKUv+b/Df5o1FC5ePnk+Mg=;
 b=Vh1K7JlasMJFhO693w807VyritluDY1x12cMsGZzp+Jj5D3N0tUYEMcO+25anO0rH/8BRUuLNDsA5ldXslVNp8vpa5m8lTSCBExllBN0MxfoYfAshldmq5/YR5z9OMuZgioxjRvD/iz0HdXm41j1kzegoLnauHKhILPn9b4h7pelnUpNWw7R8+EUMxWOe6lFZzGnWm6/U+XilKeyXeCV7AkvMyj7rI0AAlqByVz4jlGFgcpr9kJyr1CxU9XTNBNgU6uks+uNoU0LUDqN6+Pyhz76s1HMCM8gxYcHjluB8Mn0fub1sR3WWEkMkst4xXcJqiHSRx8jo2IzhiTqQDPDzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB7540.namprd11.prod.outlook.com (2603:10b6:806:340::7)
 by MW3PR11MB4556.namprd11.prod.outlook.com (2603:10b6:303:5b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.13; Wed, 18 Dec
 2024 17:00:02 +0000
Received: from SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::399f:ff7c:adb2:8d29]) by SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::399f:ff7c:adb2:8d29%5]) with mapi id 15.20.8272.005; Wed, 18 Dec 2024
 17:00:02 +0000
Date: Wed, 18 Dec 2024 17:59:51 +0100
From: Larysa Zaremba <larysa.zaremba@intel.com>
To: MD Danish Anwar <danishanwar@ti.com>
CC: <aleksander.lobakin@intel.com>, <lukma@denx.de>, <m-malladi@ti.com>,
	<diogo.ivo@siemens.com>, <rdunlap@infradead.org>, <schnelle@linux.ibm.com>,
	<vladimir.oltean@nxp.com>, <horms@kernel.org>, <rogerq@kernel.org>,
	<pabeni@redhat.com>, <kuba@kernel.org>, <edumazet@google.com>,
	<davem@davemloft.net>, <andrew+netdev@lunn.ch>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>, <srk@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>
Subject: Re: [PATCH net-next 1/4] net: ti: Kconfig: Select HSR for ICSSG
 Driver
Message-ID: <Z2L/hwH5pgBV9pSB@lzaremba-mobl.ger.corp.intel.com>
References: <20241216100044.577489-1-danishanwar@ti.com>
 <20241216100044.577489-2-danishanwar@ti.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241216100044.577489-2-danishanwar@ti.com>
X-ClientProxiedBy: VE1PR08CA0032.eurprd08.prod.outlook.com
 (2603:10a6:803:104::45) To SN7PR11MB7540.namprd11.prod.outlook.com
 (2603:10b6:806:340::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB7540:EE_|MW3PR11MB4556:EE_
X-MS-Office365-Filtering-Correlation-Id: c5b1aa23-e23d-406e-40bc-08dd1f85698b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?TxwvCOwdNc0yuqCmmgjyWcQSiLsCUpolTpgQWv7d2cTW7g4snje+UuIKDtvN?=
 =?us-ascii?Q?c3C14cgokVKew1+8BO8SeM6BxCKr6zUZyzKWwW+qNfQIbAcieiWlqS345TzK?=
 =?us-ascii?Q?1nYSAQrIsB9nfU94v2vk4jXhyyitxgcU0W0SX8DK7dU8jNsP1ntW20SVb8ez?=
 =?us-ascii?Q?Q4BvI/BiBmaIJz/UmVLHNCWBFuQaJdVTJnq8ohtoVwFS05sBGbkJjr6HpsoG?=
 =?us-ascii?Q?kmQg5h2Zj1G5tJvyAzQq+toMx/guszOHMsuqqtsI8mZWQ4kN25SI+C9zUXw4?=
 =?us-ascii?Q?0ciagOc1QstSzYAuNnpQzARxadkgbyqjzxyH94vdf+NouE8cI02zIHt0ul11?=
 =?us-ascii?Q?CbJ35tmJrWahRUjKi1XDsViMDolpxu2YoB6AyyibKdCTYTfOYYHU1ZRwb9n6?=
 =?us-ascii?Q?1+0QN+4kOrDJRu3KZfdyVXZxNsiCkesVIitG7SSTnr2lUwQDFnBqpbQjnxIP?=
 =?us-ascii?Q?1kHpnOziLUN0sV6X1Jvh9SeH+lEZ3Tj+HjcqpJ3LhZBvV2ji6jb3kaECqqRx?=
 =?us-ascii?Q?xFpgNT22N9uudkVxtmMbmlBIWmJ4FF0HChaLe0tWSe31pquHnWF7aTQmIMAf?=
 =?us-ascii?Q?9ABIcIQqmoZO4W7vud3PIz9oIb6MkbNYkX+Qt40jhzjB8emBEUexGCPgXxcA?=
 =?us-ascii?Q?Z0qWM88V1LV/aj0MeF0wzH/2yRiR2c5qLnzRPrJqfUtYy/8wy2+yDvPnspXJ?=
 =?us-ascii?Q?hsIF6+f2J11NzDetVQASnaBGXGgCmkfIz25yIYfjmh/OUemqSUD1hvciSJzY?=
 =?us-ascii?Q?14Eq9shlxjPpHPsOGGEgLQGlgf0/mbOS/QnChcVHhRCfzVpBW1o405u1hkY0?=
 =?us-ascii?Q?9+sDc1G+s1ir3btQ800BTsgDyP/xhIUWLw60FNofAFsQVrqSaO/JWr86Xx2X?=
 =?us-ascii?Q?SQ0e4CMymbJTW6sMLOBA/ZSn3jOHHm9XuVTq7W10N4vMRMz2vYLNwLgwfymA?=
 =?us-ascii?Q?N5jUl0mMCMXcFJ3PKlu3Nw9uaZfUg5Q2uDMDHMwW9egcz8LZFGgkXvfgif5h?=
 =?us-ascii?Q?26MomOOG5l/Ea/hMZ9wOFAoiFNpdXBhv1J7R0wMUHnzWXbWaDJwq2SS73q5T?=
 =?us-ascii?Q?GzHvZUC+gaHVOR+BKYXXC/GkL15Ds0Q4wQjZzoz33MXHbbsXBUx2igQwgk1n?=
 =?us-ascii?Q?nav2l3VCfXU9gsdO9FbDTq3WJjDoS9+NaD9nMYSAOSC3LMykmIaufEOKVkCQ?=
 =?us-ascii?Q?ZAYK5d+bSX4F7b6q5FMiepDG2Pj8SK0s12ZGe3/NiMBq4hLdWmCOWjRVl3ZO?=
 =?us-ascii?Q?pRFzIb9+OxhrPzQY1//uAHVMIam/6ihFZZbEe8q9FTWFDkTBzEUxHoW4sVgd?=
 =?us-ascii?Q?wb6o7H+NPYj+8J+MrOobmfaynyKrUosz9MMs3eArDJ2R6bLTyNN5hmEbH+3K?=
 =?us-ascii?Q?U4BT0nq7FVe72E/bcpBnE0B4RZDr?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB7540.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wFHjdZ3FPngi8z3ScnyRovFnxUhg4nrpoE0lshFB0HtLst6GKmhIIskja9j3?=
 =?us-ascii?Q?pEix++1vobb1Rwc7zdGn15+R4sTCNA0ptidQLi/G9CO5nCnBW/hmeXIdZRnd?=
 =?us-ascii?Q?n8xmK0Xu6Ebehqrj8t1oE3mJGMM6PKPRBGqvITesx3CpzWfXkmhenT2EBUZR?=
 =?us-ascii?Q?8GU9L6+GXT5OKmH+Y/JGY4Z6Vdsl4tmfzDa7udL+amDsYG+mFDYJph+H4xcL?=
 =?us-ascii?Q?60U0Qi/zAF1oP8pguLKJxcESQzE+XY0a1Cv75nJEerG8Pj1LncHMPykVUZk4?=
 =?us-ascii?Q?W7FaXti6DlEH773I1JMqBEHr07txqnDWx3NcQQH6pgY1HkTqv1n7SK6YnkKt?=
 =?us-ascii?Q?3bDk8dwbvOl/Ysxd3bLCIXxZEYm2ug1iJ2kN3K1Ch2MTTEhk2Y+NzSVfruJz?=
 =?us-ascii?Q?btumKkNPrrMmInVcp8wZvHUShDz+AZ+8ho8Mi6JR3AqS99HDRZ1WaRZw/ItW?=
 =?us-ascii?Q?0WLKD7W/uba7oUFpJpM/i6NPiI/aECuEvqzMKsbwmzb0XJ8H8OtFuoD+UJui?=
 =?us-ascii?Q?WS/81x3r4abi9+uv2DKASwNnmsHZ/N6uJwjTaLTsX7KTBLZW9ujd5Yu0XSYS?=
 =?us-ascii?Q?ujG3DO/sM1mAHnup2RJRPYDEIpCJS/pIGuUf7oHAmbs5c7KXoucM7Ajo1Hs8?=
 =?us-ascii?Q?MiWlWlF0ZNjnDMCIK2Z7ej5rfkwlQ98EAyzGotBk40EaUeTAL1L0Bj61rk4B?=
 =?us-ascii?Q?RY8i9C1cGDYa/XNwVEe75sCR4Fb+/fB6VVMwcyL/m8qdY55uyvdYk3eKgq/S?=
 =?us-ascii?Q?GeQdLLTRIiik8uLHJC1G5vbKpErV8bg5MlSk7RKeCr11XT34IIaxOBFk/Pa+?=
 =?us-ascii?Q?Yq2llVS+GcClWSCu4OiEwnVd16+ZBjxfla2T2zmzR+Rcgzar2kj4lz1IYEkO?=
 =?us-ascii?Q?4IRRDN/vqLmrvQvN3r4Spt3erzsFdyzDCjr4rQt2oF/AWt/TGloXAyh5Kdec?=
 =?us-ascii?Q?WZji/jPNZ2P+CrsIJ6CP9PL/B1HtV+4si0x1YyAozts7odC3+paIPBBrmrzA?=
 =?us-ascii?Q?pIx/5lveBEOYcAIBeiXHLnCDDL36EK0DEMQdaa8OvNkAUmBWtkVbGaETKSv6?=
 =?us-ascii?Q?AVW9coQliyg/elA+uFh+XpNGNcbgv75SQdhQc7Dp1Wv78WXI3KmNMyqvmh/w?=
 =?us-ascii?Q?TOoAc+R8xK7yjSdN36gbE0cAs6ZERoF0HJCOwE2KAtssamK7ETYxdx6vGpck?=
 =?us-ascii?Q?4jEYvg4FUL7t8lm8KTNzKQrWbilqW1F5SrVF9u2wBURGi7xqhlvCpEyphdHD?=
 =?us-ascii?Q?TLp9pkh70Zt0aTY9xz3JqDt1uOpowdTc1LqQrv2DRnr3BUHJYrIUAVZJuIzx?=
 =?us-ascii?Q?15IiKAH9f7gTjYSw/oawa7JTjwTYMO8mmXQHVDXlR9igQLOszkOlLqDM2SZS?=
 =?us-ascii?Q?ChL3h2q2zQhsqFzS0akPow5FGdCZeU8c2gRQ07uYD7guwrgeBUdRKQv+EI3x?=
 =?us-ascii?Q?w1HgM8c7qzA86cdmAULl+8R3f5p8wdXj3PJnp6lZjKvAdribzjzLPSYp8UDn?=
 =?us-ascii?Q?feY0ISQLIElcUqnpikIbbcUHbMN5DGzTjsNeJMdPKfj3GZYspMsUX2JxwJ0x?=
 =?us-ascii?Q?aC1JjE8h9I8eBYekrqXh8aKc0aNF8F7Cqzd7wa9I0EMNDFLU7wuK9bWnVbBo?=
 =?us-ascii?Q?IA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c5b1aa23-e23d-406e-40bc-08dd1f85698b
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7540.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2024 17:00:01.9449
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SDw1HY7V+mkep2kEZwz/UWWagoo75UXlAhEpxK0/l9RbB4NeC934F1P/B973x4/jy43FlrEARDAiZ9tR1LKWg6qclNFZwwKdHWanbRzHOMc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4556
X-OriginatorOrg: intel.com

On Mon, Dec 16, 2024 at 03:30:41PM +0530, MD Danish Anwar wrote:
> HSR offloading is supported by ICSSG driver. Select the symbol HSR for
> TI_ICSSG_PRUETH. Also select NET_SWITCHDEV instead of depending on it to
> remove recursive dependency.
>

2 things:
1) The explanation from the cover should have been included in the commit 
   message.
2) Why not `depends on HSR`?
 
> Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
> ---
>  drivers/net/ethernet/ti/Kconfig | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/ti/Kconfig b/drivers/net/ethernet/ti/Kconfig
> index 0d5a862cd78a..ad366abfa746 100644
> --- a/drivers/net/ethernet/ti/Kconfig
> +++ b/drivers/net/ethernet/ti/Kconfig
> @@ -187,8 +187,9 @@ config TI_ICSSG_PRUETH
>  	select PHYLIB
>  	select TI_ICSS_IEP
>  	select TI_K3_CPPI_DESC_POOL
> +	select NET_SWITCHDEV
> +	select HSR
>  	depends on PRU_REMOTEPROC
> -	depends on NET_SWITCHDEV
>  	depends on ARCH_K3 && OF && TI_K3_UDMA_GLUE_LAYER
>  	depends on PTP_1588_CLOCK_OPTIONAL
>  	help
> -- 
> 2.34.1
> 
> 

