Return-Path: <netdev+bounces-154069-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BA67A9FB2F8
	for <lists+netdev@lfdr.de>; Mon, 23 Dec 2024 17:38:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 352D11881B75
	for <lists+netdev@lfdr.de>; Mon, 23 Dec 2024 16:38:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD91B1B3952;
	Mon, 23 Dec 2024 16:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AmOtPH6Y"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76F3C1B86CC
	for <netdev@vger.kernel.org>; Mon, 23 Dec 2024 16:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734971614; cv=fail; b=hV/+ZO5CWannf91IymSD899Bw6IL5UXDMgczgbUjWm4xi5uH55LZd7hLMvkC7pLoXXkDjSM7FSPQlzEDqPTMn3AjhXT7TVF5R3pH2eFOb2HptscfEPker+aiVFofm8OI8TTD/MfkJKz/SIlR1Zh3k47nbqou9uyNdhU33B+ncUA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734971614; c=relaxed/simple;
	bh=ItkZE5n9mh+gd5U11HQ+CL31/nMRtm5HiBWLcH7zwc8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fAOBzghtlvMuvbrwCniceOJYD2Y9Km7H/mF/fPZlWeTDIwU/VHUP0WxOjQrpZqy9CSAZ5T3NazVZ4tWNc0f34rWN1wS055F8IINhkT6XUMXgJ8Hk+RgohYZCDcxAnW0d8oAQf+l2xKTekUDV6/ItjvORlnjUkCIzKvYjtCo40Gk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AmOtPH6Y; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734971613; x=1766507613;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ItkZE5n9mh+gd5U11HQ+CL31/nMRtm5HiBWLcH7zwc8=;
  b=AmOtPH6YGqLsSIX5w6XjdLP0ZDn9wcIANEAuhq4gFmpovYTeWWnT2c34
   8PHLu//wJTLeD65+TQy2ct9iQXmFpBdZ7yjs3CHajQN2LsH60HhGyOKwP
   W/gSXPYmrZAviGgc0xo1oINS1moHwCmzjBxQsPT8qmbtc/ethgiBkivNt
   Oox/XJuu11qfm0Uw98zcFt6bcMpVCyCPdhEG5beCfNC4IloAEd20X5p/H
   j75olntf659EJO5Iv6XFvzdspnXNrgRgyzlE8UyEJX2ZNaFbLV9a5hePe
   J6eNyrCM/3NP9+geO5EcphW5zaZhKkh0Bya52HM6K6iG6c6r4ccET6R1N
   w==;
X-CSE-ConnectionGUID: bhsmS6NWSy2njfdn1o3XOg==
X-CSE-MsgGUID: utdePo/2QYC3wYZ1aRmEtQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11295"; a="52970367"
X-IronPort-AV: E=Sophos;i="6.12,257,1728975600"; 
   d="scan'208";a="52970367"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Dec 2024 08:28:23 -0800
X-CSE-ConnectionGUID: QNBmaiCLTHaljYkDVe6P6w==
X-CSE-MsgGUID: PWh8lp71SRe7oDdnrUwhSg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,257,1728975600"; 
   d="scan'208";a="99612762"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 Dec 2024 08:28:22 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 23 Dec 2024 08:28:21 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Mon, 23 Dec 2024 08:28:21 -0800
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.43) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 23 Dec 2024 08:28:21 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f9MKZ6MTVUV2e9ORGYuusQ46N/j6XWEzwhNexnP+gk07q9pDBKdlnq/v23su3ciU6JYzcLzC+6iMoEeEjLjwOVKuOH9xCWUiRI20U/gLMXK978WAcwxrNQk9dN91eZP+BLzlIoQF7f+KJit2mNEs2mWBsmgc8/kO9XEO25o7tFEeWJQR0ftsNOPM7gmGKHo3/fc3tAkv+qYCF7kHHaa4ZSu8ZNBsB+kD/Qkdg+akbw77Q5HmuoX99v45orU/Yrl34UgYJIeYuED7IgcFagoDw9LuC2ts4qV0mB3gGjIxuDAuFJZN+A8x8S5Otx088kI51ABSfCulZZcPjIYxr9PmTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5tBDUhPEHtnl2xLNS7fkUL8o466EiWwwFmM86s3Gf+s=;
 b=wi8GrrJrfyKHMX02Rk2BQDY0QmH8OJsi1CwpXwvAT3Fh62xIDm7bbLZKeOMQfdbECVSahGDB1KJlfWlEwfo0aaJimq4gKWmhUqOFl1oM9XWZfOxGwEOb3SnWInm8VcKE2BwRu9GUdWGaL0YCpdUClRT7sGWLdi4m+VfZ9imdSnEb3s1MbbddEr3bB6TtViioouhNQd2cjR00iaKBkKfOi6ziFn2EVu1Dpgky4KcA7r6EYs7cw/vN52OZORp6/14NRW/en3FPs+x5wHOBdkEpriCd87rIAp7jybBKaq4Zdn6pPvuSPstmXBVMym3SOZaVjNMipP9e02neuLVBAdiYCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB6241.namprd11.prod.outlook.com (2603:10b6:208:3e9::5)
 by PH7PR11MB8502.namprd11.prod.outlook.com (2603:10b6:510:30c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.18; Mon, 23 Dec
 2024 16:28:15 +0000
Received: from IA1PR11MB6241.namprd11.prod.outlook.com
 ([fe80::90b0:6aad:5bb6:b3ae]) by IA1PR11MB6241.namprd11.prod.outlook.com
 ([fe80::90b0:6aad:5bb6:b3ae%6]) with mapi id 15.20.8272.013; Mon, 23 Dec 2024
 16:28:14 +0000
From: "Rinitha, SX" <sx.rinitha@intel.com>
To: "Nadezhdin, Anton" <anton.nadezhdin@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, "richardcochran@gmail.com"
	<richardcochran@gmail.com>, "Keller, Jacob E" <jacob.e.keller@intel.com>,
	"Kolacinski, Karol" <karol.kolacinski@intel.com>, "Olech, Milena"
	<milena.olech@intel.com>, "Nadezhdin, Anton" <anton.nadezhdin@intel.com>
Subject: RE: [Intel-wired-lan] [PATCH iwl-next v2 5/5] ice: implement low
 latency PHY timer updates
Thread-Topic: [Intel-wired-lan] [PATCH iwl-next v2 5/5] ice: implement low
 latency PHY timer updates
Thread-Index: AQHbT5iB+pETLtSus0GmRnUP/J0R4rLuoQHQ
Date: Mon, 23 Dec 2024 16:28:14 +0000
Message-ID: <IA1PR11MB62419E7526353478FD9593778B022@IA1PR11MB6241.namprd11.prod.outlook.com>
References: <20241216145453.333745-1-anton.nadezhdin@intel.com>
 <20241216145453.333745-6-anton.nadezhdin@intel.com>
In-Reply-To: <20241216145453.333745-6-anton.nadezhdin@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB6241:EE_|PH7PR11MB8502:EE_
x-ms-office365-filtering-correlation-id: b73eb781-1172-495f-3f8f-08dd236eccf5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?CBTwb8xThm8jnqgaaFtG5gf6HUXgE+pN7+QSz2U6yI3ESiZSqzyOaA8vBu+b?=
 =?us-ascii?Q?7fF/bzCHP8GOFU4TnFIubqYVy0aGV/Vg2O2NA4ITldAa4t869n/xCVA0xP9E?=
 =?us-ascii?Q?NnmY/ggj3tQ4/I6o6fRippXh2tCV7p9FeTUpgWi2vKe+38iT6zX34Gx0E2KD?=
 =?us-ascii?Q?SouQgEZrmA73CHMggHgkAomU8k/SKvudEIVfX7IQrcxGQh/TTpeZ0rz/1Feb?=
 =?us-ascii?Q?nmxcCUoS1NYv190AtdTUSoKI3FoJcQ5V2gcaB2LhwcgDRmQUz3sDCsJOQwv0?=
 =?us-ascii?Q?BJgdJoogkicU5aF3xXLb8YFU00BmQk1QLPDj6GT1+T78nWLRbIHXgC7AWzvE?=
 =?us-ascii?Q?VuR8/6Cj1g0rZDHmGtlXUEnJeUVI9DJYFdhWYL+/IWd4ysQl3fsvoaFoeUet?=
 =?us-ascii?Q?onZnwMK39mH8KIu4tfZ0zgGRIDpkvJ/dJzs2wC9CgEFd5lLty2kGCvzS7mpr?=
 =?us-ascii?Q?bwZInMd0tkgjFM9GZyzNu3yJtePgPdnAPh+X85xz5lh3wJhAP3sgbzKwcsyU?=
 =?us-ascii?Q?5IF4gZgV0vT/obuAYDPqm7aMUbwfD8ztLwM91nGSoIeRvLyxxcpLufD9bKbu?=
 =?us-ascii?Q?DiAfyNm5AKI5BSQzzeaXBiuBDvHMQI/gpd9RIw/SjM0mU8hQIgJIc8qUyXYy?=
 =?us-ascii?Q?afYDh2kGdZrAnzJPNSWYOEWozKz1Bu3byHiE/gi77YbWAdRhrH2RaVwHBc7m?=
 =?us-ascii?Q?TKecCfqjBMDxV8bHAOTlOiKtXuqAtstNCDbVxDl1MwRI+7XxQ1XQY8uWsRjO?=
 =?us-ascii?Q?mw85eomCD5V0EUJdfk8mZl5QCdqSETwRjN324HfDe67umpLt1C/+5QJbjv1O?=
 =?us-ascii?Q?eHmn2nspBSZ+Ix1H5/XAjQltlCbJgTRl+nqMW41QZnJEHYkT7W3xUpM33KlM?=
 =?us-ascii?Q?dJurVBeHRWVBowtCtwTkYXQ1GJOeE4eGadOM69xZrpkB8+Vjb0kIgZJ46SDw?=
 =?us-ascii?Q?99S9Qa2nSHkRJKxyzRNY7Z+msi2Tn85+n3E64CoZPZzAQUF9LDagpKjjF/C9?=
 =?us-ascii?Q?oG86u4BBAzziDDVF0N0kM2lLR868/A37/hicO7RPot1Dm08Y5b1N62o+9Zci?=
 =?us-ascii?Q?s+q82Gz9R407D8vpj0Pn6szgHjHrxq4helHd8oZDTNyHE62nj3Jizgzj6hlH?=
 =?us-ascii?Q?cMIjw98ziu1Dw6VAFMzfi4IpIje48VRqhqiKwGDRAN8fVnaRnsd5Q+LXvtBB?=
 =?us-ascii?Q?+C0Ocz6bmNCI3MR9p9irHM+5bgTaktP+d/rgnvJOHycFiAtppJXkBDS986/k?=
 =?us-ascii?Q?4BR3mXAQ8BROTfp+JiulRkUWrnE7oNKNwTkxzWMAh6xDRIg6EpqZJIX03gfY?=
 =?us-ascii?Q?JBlIXHkEMIIqmt7nS63947Rh7iTaoG7QKBhWADopGfAYf76vY8plFrE+q4MT?=
 =?us-ascii?Q?jktg/Yn7Zk49q0DXCWxCgLag7rQDbYluxtDAVT8YntDkbcwzAlLATEhyFgu+?=
 =?us-ascii?Q?NILnUZq+zavj+OCS4XwFxFdKzPEQHbNe?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6241.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ZtGAFOXrx50lpRwvQDiT5djeaQT64LJSVkH70vEY9s/AvxsEVLRIpYan9hq2?=
 =?us-ascii?Q?OjK/5G0mz1RXqdxhFHFUri/oXxJpDCEhtaQxv7UYfv0cQKiSPkh+Bmd1js+f?=
 =?us-ascii?Q?jNDVUuChY1tWa1Q6+KvgJ+A8qZXN5ytBQ1mYn5tkFN86B/4UpYQiBYsp0UAi?=
 =?us-ascii?Q?kK3SScJmyqp4hO7QBXL5xXO6tCbEH/3CuwVMSUV1H/4cyNMn12TEcLAXgETE?=
 =?us-ascii?Q?IA7ZnG/s01DOB01jAYcrug4/hGV+8E7LFR79SmefssgEV2jG0WZo3RNEsNlc?=
 =?us-ascii?Q?pVNbDGdOB6o6WcmuktSZMzUANowrPRt94lfA4yon9Xxoe+pH9wwvOaKkfzPC?=
 =?us-ascii?Q?dSmNzFFUnxC/bEC8mZyf9355KTSsXPq2cdHqXvttiS6nThX0xD9YqHFXAO20?=
 =?us-ascii?Q?kY3/xD1Z4IQpHMDnZ0u80o1fLJcP8I2FUqdFU23Ja5iY6TwPn0ZowztDne5b?=
 =?us-ascii?Q?nn0EuWILBENx4Kv/t3eP8i7B1JQs78+dW5pHYtnROVoC9ctp3lct/13YqBny?=
 =?us-ascii?Q?s1TUqZHiNvVGu2H0tJqQ//dNTvzbERDBKqHOXgHORWp6NscNUYhxFZ46u69K?=
 =?us-ascii?Q?Per4A8jVx3Q46a2cK4qXvp4bdg0/GIrWmDJfGiFSMMfD/5mc1cMdxL2++G7Q?=
 =?us-ascii?Q?2r0FRPfwlV1vk3OovgRBDeZloJdJHSgrz/d0JWCPDUblf4dm5mNgKwvfUhx4?=
 =?us-ascii?Q?AlfjLC3Aac1Bd2z+rfQPyDjEaPjGS5kxBOlEbnP2COiWmvaGHu9aejh8xm6H?=
 =?us-ascii?Q?yu2aAtbQNdajgIcO1/2U5gBc5oJ/dYF3Yweejyw1dExn9y6bX4heL6PU8ibn?=
 =?us-ascii?Q?DnjLefFVI0PraeWu6YSwg7EVcQZK8hOcCCGWTweri+egtpgMYm5D11aMkRhE?=
 =?us-ascii?Q?4mkuGHG7v2+XJjfsSPrmzmLlQFi192qhQzhSLpcZ9kk/i3k8bXVDwY9UIV6t?=
 =?us-ascii?Q?3cpyR4OyeeLXqbAZcuXFEQgcuCeLGX8f90OjuXgnpml6/VF3tIJQjLEHcVN5?=
 =?us-ascii?Q?7N8PMTipZNKcqAjifgbWzQw5a3t5/NBF5OUVhen601aK9i1Isrwhk656+naH?=
 =?us-ascii?Q?FmPCsUv8L2qxR+aduxpJWMo64ZUFSwcr2ii6i8lkt5c6Vfe5lUekECRlIYdK?=
 =?us-ascii?Q?WbPAP9quwBKTYo2y44IHsN6NUqZrJD+Eajo4E2mPC8pOzkR/Ztxc+2uL31OU?=
 =?us-ascii?Q?ISULhWZuPfoQ6zZtudI4Zc41MTYW0Z0fJLSqNOj/riSdReb8Akj7cmPsXeEU?=
 =?us-ascii?Q?ygrVcW70EqCJpp6JIdNmc7FSXdS+kClTkSt77tCtV6oJ725MlCcIiTVsebgn?=
 =?us-ascii?Q?JdJ/8Rxhqq8WQxukwWXudAmRtfJF1LmGAw1w1Bkut2ceD4mPRhxJt6QtSBQY?=
 =?us-ascii?Q?DOPaGWJyWrGtw/ymEsx+5vxODRtc89MFeo/Jzf0mNWQb1O0TpYoafVBf1eYZ?=
 =?us-ascii?Q?3FHMFry35ioeLVfe+NSwt3WUKUIL478qOyF93bDjLjXsBGqczP4qxLwW099X?=
 =?us-ascii?Q?boke9hRFkaaHCWbPoRvHwRy1KASuLqWOvBQQxsgSl1Me992fXGpXYLWuO1cR?=
 =?us-ascii?Q?u3vWk4TYhBwnis1QyVJWKTWNSgfhbftNchZSOJL5?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6241.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b73eb781-1172-495f-3f8f-08dd236eccf5
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Dec 2024 16:28:14.7996
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3AMlQLtW/xYqkLZizbY1Hmx74LLPFckAkCdB0mOPk/XttsEnQnJqq+M21haBB4n7guOJWinQSGWshAt1bxj1wA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8502
X-OriginatorOrg: intel.com

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of A=
nton Nadezhdin
> Sent: 16 December 2024 20:24
> To: intel-wired-lan@lists.osuosl.org
> Cc: netdev@vger.kernel.org; Nguyen, Anthony L <anthony.l.nguyen@intel.com=
>; Kitszel, Przemyslaw <przemyslaw.kitszel@intel.com>; richardcochran@gmail=
.com; Keller, Jacob E <jacob.e.keller@intel.com>; Kolacinski, Karol <karol.=
kolacinski@intel.com>; Olech, Milena <milena.olech@intel.com>; Nadezhdin, A=
nton <anton.nadezhdin@intel.com>
> Subject: [Intel-wired-lan] [PATCH iwl-next v2 5/5] ice: implement low lat=
ency PHY timer updates
>
> From: Jacob Keller <jacob.e.keller@intel.com>
>
> Programming the PHY registers in preparation for an increment value chang=
e or a timer adjustment on E810 requires issuing Admin Queue commands for e=
ach PHY register. It has been found that the firmware Admin Queue processin=
g occasionally has delays of tens or rarely up to hundreds of milliseconds.=
 This delay cascades to failures in the PTP applications which depend on th=
ese updates being low latency.
>
> Consider a standard PTP profile with a sync rate of 16 times per second.
> This means there is ~62 milliseconds between sync messages. A complete cy=
cle of the PTP algorithm
>
> 1) Sync message (with Tx timestamp) from source
> 2) Follow-up message from source
> 3) Delay request (with Tx timestamp) from sink
> 4) Delay response (with Rx timestamp of request) from source
> 5) measure instantaneous clock offset
> 6) request time adjustment via CLOCK_ADJTIME systemcall
>
> The Tx timestamps have a default maximum timeout of 10 milliseconds. If w=
e assume that the maximum possible time is used, this leaves us with ~42 mi=
lliseconds of processing time for a complete cycle.
>
> The CLOCK_ADJTIME system call is synchronous and will block until the dri=
ver completes its timer adjustment or frequency change.
>
> If the writes to prepare the PHY timers get hit by a latency spike of 50 =
milliseconds, then the PTP application will be delayed past the point where=
 the next cycle should start. Packets from the next cycle may have already =
arrived and are waiting on the socket.
>
> In particular, LinuxPTP ptp4l may start complaining about missing an anno=
unce message from the source, triggering a fault. In addition, the clockche=
ck logic it uses may trigger. This clockcheck failure occurs because the ti=
mestamp captured by hardware is compared against a reading of CLOCK_MONOTON=
IC. It is assumed that the time when the Rx timestamp is captured and the r=
ead from CLOCK_MONOTONIC are relatively close together.
> This is not the case if there is a significant delay to processing the Rx=
 packet.
>
> Newer firmware supports programming the PHY registers over a low latency =
interface which bypasses the Admin Queue. Instead, software writes to the R=
EG_LL_PROXY_L and REG_LL_PROXY_H registers. Firmware reads these registers =
and then programs the PHY timers.
>
> Implement functions to use this interface when available to program the P=
HY timers instead of using the Admin Queue. This avoids the Admin Queue lat=
ency and ensures that adjustments happen within acceptable latency bounds.
>
> Co-developed-by: Karol Kolacinski <karol.kolacinski@intel.com>
> Signed-off-by: Karol Kolacinski <karol.kolacinski@intel.com>
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> Reviewed-by: Milena Olech <milena.olech@intel.com>
> Signed-off-by: Anton Nadezhdin <anton.nadezhdin@intel.com>
> ---
> drivers/net/ethernet/intel/ice/ice_ptp_hw.c | 105 ++++++++++++++++++++
> drivers/net/ethernet/intel/ice/ice_ptp_hw.h |   4 +
> 2 files changed, 109 insertions(+)
>
Tested-by: Rinitha S <sx.rinitha@intel.com> (A Contingent worker at Intel)

