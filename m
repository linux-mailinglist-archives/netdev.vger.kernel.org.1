Return-Path: <netdev+bounces-171111-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DB321A4B8FA
	for <lists+netdev@lfdr.de>; Mon,  3 Mar 2025 09:18:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C6896188CDC1
	for <lists+netdev@lfdr.de>; Mon,  3 Mar 2025 08:18:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9D631EB190;
	Mon,  3 Mar 2025 08:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FsFURfrv"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 685D77083C
	for <netdev@vger.kernel.org>; Mon,  3 Mar 2025 08:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740989887; cv=fail; b=QadTzu3fWTslFuJparZxTNJSd1Rmb784gcUBRfuIY6Ddb63Bgz1QMU8ZjaBgJ6/gRERPhAe8qXGao7gD+5yt86GwjgLsL4mb15DZ8TJszgRjKq3qculk7LAVtenvl+PGbO4uOsPTnX/tcQTOXBVRVzdDKMUvvHgvxTWhuIuH7zw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740989887; c=relaxed/simple;
	bh=zXxe6wsE1Yjl9kw+xQWK0v4NdX7mV2+sAPVD8PqCZxo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=YhduKvhIOoA44upqHfe8gjHaLHjpgjGmGBkZsUCkx97NmZMeCfwgHKfrETBkgvrwE2T458ZaD2DCXhZ616WdzrR/b3BV8nt6cb/r626B+zKT2Vy3lujoiFwDM6O/6sEjwLuG59+PiQPnZL4WD7izf9jy36SRxBkUSICTRRz3ZSM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FsFURfrv; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740989885; x=1772525885;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=zXxe6wsE1Yjl9kw+xQWK0v4NdX7mV2+sAPVD8PqCZxo=;
  b=FsFURfrvzdsACyt6aRMxx5Tzd+s2q53ZT0+tVMeCLx411x7FfGVPeKn+
   xWKWRBG+Vslkt6a16+BOvfq5NH9Spwt9HxAEf2VaFGLMerfii8MYrEtgM
   RmNXbkDmSoXSpAPMCMHcSuzdIoXhL4KBy6j2lA/8gBweyLTZ5RYom2+AF
   vLcRWd06XMIztikZ55cBaAl5sfhhEdtd3WOSUEZg++LvhzPM7omUCP9X1
   wXLnP6us7C6HoyZdfY7HkfFwLDLXF76GH18oihlZJXQO6JwOE805r2guw
   JOzpKY+JPXqPcwB3pT/531KKuL+z+CKzJ+qbAu5VGR1fHUheAK7UhQXd0
   g==;
X-CSE-ConnectionGUID: smmN59ntR36v0JLg99pqIA==
X-CSE-MsgGUID: jF5P9m4HRk+n0f82YpKauQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11361"; a="45783001"
X-IronPort-AV: E=Sophos;i="6.13,329,1732608000"; 
   d="scan'208";a="45783001"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2025 00:18:04 -0800
X-CSE-ConnectionGUID: RgSRhz2JSf6gnf3S6g1fiQ==
X-CSE-MsgGUID: m0n70bAtRNiWlLyYt+G/EA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,329,1732608000"; 
   d="scan'208";a="117682209"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 03 Mar 2025 00:18:04 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 3 Mar 2025 00:18:04 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Mon, 3 Mar 2025 00:18:04 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.171)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 3 Mar 2025 00:18:03 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nl00NUy/sU5DZup5sjeYDu35QhID0TEnmFSIObbYOlIGQru2SoVYk8Vg3sgKaSoELo00rsSK5p7xlso7LB3o9x0KQIqBl+y+FUVERtBhVpjOa/w6dtwjblwyGKYH9JRumhKT9kjfaviYvZJJUuFRkhXLqVydycBZq2kfGDk0UE3JC/35TYlz4KXlyI8e3x3atB5vSVWYMZqtSVKl+fscGPFsSLsJfyzIVqu87z9Wjlp0xA6AxkuM+FGymYB8n5Bm9ENUwL84iikKnMJ+n5DM/ulca/Q84NB2VrmRPJJ9pGTbt8JWnDTDfVcKNjiDFN1QZf0/vRDAg48C0BlhO9/VkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5fOygqvYiu21vn08rccqKNYckibmbygzJFSCZ+s/URo=;
 b=jsYFLOcWInmxfHMY1x60O0d64ErQ+r4NGFZKjCp0cE1A8ClJr+TSuW0PnU/pusCiN/ziORyT8FBx+Qf8PkaJfgT0f3IVZtT88Y8bJWOPEuhZcbKdpJeufhDpxEDhnHvb0Q5Fhe8aPcOguLcaZNocFeoyRu3oyiXAbz5MRJq+Nx+QdDAe0z7uEU4++FW5H5f7d+Y/GaeVuaKfzDqkX3eb9cFLluG985lM2TNgwLvIsVloMpoQSzsbbHlhOBYjUqWNa2r3Kbi2xibjEqbj9PzCcMPOrKtnqLT7U+GFr5h62qsC0nfrCnKTPH81b5lFZVS7Yi0XjHyEwZY9nkNn304Maw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH8PR11MB7965.namprd11.prod.outlook.com (2603:10b6:510:25c::13)
 by SJ0PR11MB8295.namprd11.prod.outlook.com (2603:10b6:a03:479::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.25; Mon, 3 Mar
 2025 08:17:59 +0000
Received: from PH8PR11MB7965.namprd11.prod.outlook.com
 ([fe80::ad6c:cf56:3c3d:4739]) by PH8PR11MB7965.namprd11.prod.outlook.com
 ([fe80::ad6c:cf56:3c3d:4739%4]) with mapi id 15.20.8489.025; Mon, 3 Mar 2025
 08:17:59 +0000
From: "R, Bharath" <bharath.r@intel.com>
To: "Jagielski, Jedrzej" <jedrzej.jagielski@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "horms@kernel.org" <horms@kernel.org>,
	"jiri@nvidia.com" <jiri@nvidia.com>, "Jagielski, Jedrzej"
	<jedrzej.jagielski@intel.com>, "Polchlopek, Mateusz"
	<mateusz.polchlopek@intel.com>, "Mrozowicz, SlawomirX"
	<slawomirx.mrozowicz@intel.com>, "Kwapulinski, Piotr"
	<piotr.kwapulinski@intel.com>, "Wegrzyn, Stefan" <stefan.wegrzyn@intel.com>
Subject: RE: [Intel-wired-lan] [PATCH iwl-next v5 12/15] ixgbe: add support
 for devlink reload
Thread-Topic: [Intel-wired-lan] [PATCH iwl-next v5 12/15] ixgbe: add support
 for devlink reload
Thread-Index: AQHbhFkUZVFfkzEfVU+kZXbP4Qd6AbNhIFGQ
Date: Mon, 3 Mar 2025 08:17:59 +0000
Message-ID: <PH8PR11MB7965BB85815FAFBFADE1C076F7C92@PH8PR11MB7965.namprd11.prod.outlook.com>
References: <20250221115116.169158-1-jedrzej.jagielski@intel.com>
 <20250221115116.169158-13-jedrzej.jagielski@intel.com>
In-Reply-To: <20250221115116.169158-13-jedrzej.jagielski@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH8PR11MB7965:EE_|SJ0PR11MB8295:EE_
x-ms-office365-filtering-correlation-id: c6d0d4a0-3ad5-4067-ceb7-08dd5a2be8c2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018|7053199007;
x-microsoft-antispam-message-info: =?us-ascii?Q?+q3SG5Zt3g5aGi/1vQQ10BcoGBoCv9BrtFI7rXQlzjKBKshNOEp1UGidyhfb?=
 =?us-ascii?Q?TBPLNlBrfF1b/FvZ+OYs+iJAFqE5SlHpwGne+X5HK2D38NMlaVWpl59JpC4v?=
 =?us-ascii?Q?Zf6I0P0WRZlB6Z10VkxFayQirgx3B/sEiNzbdv4dgo0Y0LjCxSb003Os3ywI?=
 =?us-ascii?Q?Njyp1qlHCEGLpKejnrN38wvgZS7IcvxIQ3fexV40ciDJE4k4auTLNAIwoDhO?=
 =?us-ascii?Q?38cdEbvQmPcrz/8tliPj0kCLHTyBzXGjRvw5A8E182BZZACO0QaAhVnARXxK?=
 =?us-ascii?Q?4NhT+IOdWMVVi/2CFiyPlt4Y70jOMGFdJl/ok8h1TR3Yb8aL72IT5f6fzODB?=
 =?us-ascii?Q?HaRgDX0faJ1IwJm42tWBPQQO4O4J5sI65/j4SBScmDIHMAgrkou5xjB+2QUP?=
 =?us-ascii?Q?lY/S/s8OImDQH8j6rBN+Bp8AchOGEEVBUtQnOrlhOgIF2ewgtzHN6cGgVnp8?=
 =?us-ascii?Q?Q9NM2Ah5Fl/kNt0D262JhMfAa2TrvGtMWvq9EZv6Ikzy81xt6dLaIftDKWf6?=
 =?us-ascii?Q?wbUA78MnTgoE7wsHmO1DM/N/19e9hnCQhdrwkXdoW6k4TsHXg89ZlqADYgtk?=
 =?us-ascii?Q?ARUEZcQckl3dOiaBW22R53K/my8BW2EuzTK3CSahziTvx4A13sScMg6kfv++?=
 =?us-ascii?Q?iVIhthDq0kYf/7dDIlOQd1nXIDkXI99iYZCoGGaLvZw37HeLl+MZy/mL/7/D?=
 =?us-ascii?Q?xUP/ycHLU/v4yCy64of+R9wuPN3OOcKwEPN6dZL0Kv74V+3+3iTbpnHborjV?=
 =?us-ascii?Q?cY4vwA4w3x+tCwWKwMhk5Pb1WSEFkw/j/I4m9paVl8YZLYqhqwpfLnRk8zYU?=
 =?us-ascii?Q?hZxaLxZ/E4SfH4PoUsWyWIsLUu2Sy2yKAr9ypL+76kYRggLsWtPUJoITrVzd?=
 =?us-ascii?Q?+S8px3fa2bPWd5FR06F65yHlhWUq3sB2RCuCcS4+o5pw1JIyNEOCox9Uo3BF?=
 =?us-ascii?Q?NkSiLqP2X8DfKYa0ij6B/A7nYNvZ+vVnEClLmmoXoTLlOOKaco0+1cBH7Hk9?=
 =?us-ascii?Q?x7VZlTlK2qJQ+3yTCwBHPY+6we85ufig5fK7lj56ttbMy8KyX+7HjLBSb/Wc?=
 =?us-ascii?Q?GAewRn0I5qImHNxdr4lmVL1Mqn29VcH9vXroGJ2iYBjBCKmGJk23WDy4vRI+?=
 =?us-ascii?Q?YfH18MxFINFZ3qNztMKe/4MiTxcyIwz89sRJoUt5sgAwVmt8Qq6UNykQ7Jdp?=
 =?us-ascii?Q?JC0LAH/jLeq3JISxj9No97OmIcXsmj1dBCWmpsVKO7c44fkOeknEzHIrtZMH?=
 =?us-ascii?Q?9iAm6vK7h6PKA3Wwo3m69YlSFtDLYF3/Rt7UlfHAoZpGnGIXxZeIDxk65F2n?=
 =?us-ascii?Q?xY70intLi/hvrNCcR7Thnn6prOU1xMXWdDgPeOiPL4JktGBaVuKoZznHBsbo?=
 =?us-ascii?Q?W2YGi6LlmKgwCLDv/1A05ERBXzMFs8Q/Sp8kauKNzqeBsdPTqbxqu0IotcTN?=
 =?us-ascii?Q?V7JZ70r7x9InU2CyfPnr3app84yIdOM5?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB7965.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018)(7053199007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?nDVhb9mRlHETJBx/jOvVCccGziFZ4f2xoXGLKn/mdREIpNIlreSCnItDCpRR?=
 =?us-ascii?Q?HZXcs4sPB66uPRIO2hiibxjTi2HrUlRk+u9bCIPFhO6Vkam0eM1Xq+8P3O+V?=
 =?us-ascii?Q?oHzgfjsCJrik9PLVOZdkiZG0Acpa6aUWNzi3sSKtajHeeZCBhSdkxJUqos6k?=
 =?us-ascii?Q?p86LeiJLD1s5v5VVrK0TmmRXbXA3+fexR0DQgcCuzIBCmm5HdsuA3UUZVxH4?=
 =?us-ascii?Q?98XIntxo5ZkJ4YUQodMC5SpoB/+m6NlFqJX541mToq6nyE9wD9fP7xFSVlAi?=
 =?us-ascii?Q?9uYEgC3NSQQhLSf+EpW+jvcFN7BJVRUyAglTeZj+YyoZ/TTl8mZ4yivJlUf8?=
 =?us-ascii?Q?etOWGHLpWwYe//cLKUoqWMEpaCiGc1aa1DWKeWJtnW9xyTewYIxHtiQ76KO9?=
 =?us-ascii?Q?oj3eZkRBcTHJ1eufyHyzE4ZwAV+8o6KZrWOqNm9tzo86ptboVgFuvDIm2AP2?=
 =?us-ascii?Q?p0ClZfUlGQ9vJFlBgWrEXoCTqg7M1TCjSY7V7intBKqQUssO7si23gCvrstp?=
 =?us-ascii?Q?cQdpvP7Xqbf2FoyzfzBaY+DCJlSailBtvF9PWg7maSL5Rxt2+Lu/cUdlSy3a?=
 =?us-ascii?Q?gu6sFaBu7bLJ3cCt7gBzKyQsG2lcTLNK2965aU8yGHhN30XUgSDWRBddLcLU?=
 =?us-ascii?Q?UJ31ZglcDIPjD2jAN04vWrvLxlO7JSwlw7Pc6sSvuR9yUSGhC3sE3175i9GG?=
 =?us-ascii?Q?6ej0AAiTSE4Ic5AfVbhututGsh+lZOuOLYGd6x26H288dBZDGwJajJjJEISZ?=
 =?us-ascii?Q?H2rreNGvE/5bj9cPP9AjxtwmwaK6Gs6MTOmrlNzZ+EEb3EvOpGlk/NjrUTkJ?=
 =?us-ascii?Q?q5/sv76PgcVMML3Jk4E7Jg3Bw2MdIxT4erJAYBahllLFx9s2oP71EyXheXO5?=
 =?us-ascii?Q?uJwQwznjOqVAGonYhtR9jPtq0j3HRe9d9adT0Nz2xh70bbKFNEImno5JxMRZ?=
 =?us-ascii?Q?z1LCis+0lbZ+NecIlBtnJI+UqWYDZzy6rXBG7P31J2rn0KTBIdpoatKyhZ4T?=
 =?us-ascii?Q?JybbBfqZoTP8Hb4g1r2aZSXx8j7j8eUrXnPG/MURI6mFaWPFIbo9wG/CbINT?=
 =?us-ascii?Q?tkRQYamfq7Ds9EozAz5SjTUPnDLW4v2o21I0YWX5OgSgbvk/g4QiurU8yKX8?=
 =?us-ascii?Q?5ShGsR8+69isEcUoz9T703uVjvdPuQA4UoPEEQbBv7pKh/tqM0fnjy8o9Th2?=
 =?us-ascii?Q?TvMjX+NxMIEeOLFrxN93Axupde9BV6Q185P+nozLZiDq9CeBDtTw95UNZamO?=
 =?us-ascii?Q?dPYfV7P9cPBPX9srBq4vRkJp7ypFIBhBVpC/6UpZd3TnXrhDfHZjtlZ5kPsf?=
 =?us-ascii?Q?usIZoYUDixDm4TtqmHYR2FOwcOvkPE5AMReF5churjIEL/AKueHahFh7MXiS?=
 =?us-ascii?Q?Xs5wKGbe+kbDSPPuHXaspbqrMr16dUS9cb8Z04rq0UNYVFbVlHdp903nw4p6?=
 =?us-ascii?Q?YpkaSSA7cRceVXZ9lj8QavCCzkn1cg2iHDBqpm8g87ivOtv+4561h6RsnEZY?=
 =?us-ascii?Q?/r7bHbHNxkxAm9HJ/fgwkJMqUanErhrI5aZB5e4QtS1D7ns8nBBoO89qKHDV?=
 =?us-ascii?Q?xB17SPwJI0QNwIw+vus27vIKnKnAJQe2UbAmxJff?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB7965.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6d0d4a0-3ad5-4067-ceb7-08dd5a2be8c2
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2025 08:17:59.1273
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Di3DotgQ9qvxZbWvteB4WAT4v4FK1mBGdJ07nOktaUbR9I6g9RBkkMB/C0ZzAc4sjG32eF6rbjG6YQ0T8PggGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB8295
X-OriginatorOrg: intel.com

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Jedrzej Jagielski
> Sent: Friday, February 21, 2025 5:21 PM
> To: intel-wired-lan@lists.osuosl.org
> Cc: Nguyen, Anthony L <anthony.l.nguyen@intel.com>;
> netdev@vger.kernel.org; horms@kernel.org; jiri@nvidia.com; Jagielski, Jed=
rzej
> <jedrzej.jagielski@intel.com>; Polchlopek, Mateusz
> <mateusz.polchlopek@intel.com>; Mrozowicz, SlawomirX
> <slawomirx.mrozowicz@intel.com>; Kwapulinski, Piotr
> <piotr.kwapulinski@intel.com>; Wegrzyn, Stefan <stefan.wegrzyn@intel.com>
> Subject: [Intel-wired-lan] [PATCH iwl-next v5 12/15] ixgbe: add support f=
or
> devlink reload
>=20
> The E610 adapters contain an embedded chip with firmware which can be
> updated using devlink flash. The firmware which runs on this chip is refe=
rred
> to as the Embedded Management Processor firmware (EMP firmware).
>=20
> Activating the new firmware image currently requires that the system be
> rebooted. This is not ideal as rebooting the system can cause unwanted
> downtime.
>=20
> The EMP firmware itself can be reloaded by issuing a special update to th=
e
> device called an Embedded Management Processor reset (EMP reset). This
> reset causes the device to reset and reload the EMP firmware.
>=20
> Implement support for devlink reload with the "fw_activate" flag. This al=
lows
> user space to request the firmware be activated immediately.
>=20
> Reviewed-by: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
> Co-developed-by: Slawomir Mrozowicz <slawomirx.mrozowicz@intel.com>
> Signed-off-by: Slawomir Mrozowicz <slawomirx.mrozowicz@intel.com>
> Co-developed-by: Piotr Kwapulinski <piotr.kwapulinski@intel.com>
> Signed-off-by: Piotr Kwapulinski <piotr.kwapulinski@intel.com>
> Co-developed-by: Stefan Wegrzyn <stefan.wegrzyn@intel.com>
> Signed-off-by: Stefan Wegrzyn <stefan.wegrzyn@intel.com>
> Signed-off-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
> ---
>  Documentation/networking/devlink/ixgbe.rst    |  15 +++
>  .../ethernet/intel/ixgbe/devlink/devlink.c    | 112 ++++++++++++++++++
>  drivers/net/ethernet/intel/ixgbe/ixgbe.h      |   4 +
>  drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c |  18 +++
>  drivers/net/ethernet/intel/ixgbe/ixgbe_e610.h |   1 +
>  .../net/ethernet/intel/ixgbe/ixgbe_ethtool.c  |  12 ++
>  .../ethernet/intel/ixgbe/ixgbe_fw_update.c    |  37 +++++-
>  drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |   5 +-
>  8 files changed, 197 insertions(+), 7 deletions(-)
>=20

Tested-by: Bharath R <bharath.r@intel.com>

