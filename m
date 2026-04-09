Return-Path: <netdev+bounces-276922-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UGBZKE9812mXOggAu9opvQ
	(envelope-from <netdev+bounces-276922-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 12:15:43 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C34D3C90DC
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 12:15:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A8376308BA00
	for <lists+netdev@lfdr.de>; Thu,  9 Apr 2026 10:11:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA7AB3BE62A;
	Thu,  9 Apr 2026 10:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cgpCnRQt"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D22CB3AA4E6;
	Thu,  9 Apr 2026 10:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775729469; cv=fail; b=KmaNsm9doaqPfBYjZecvp1eWSKICYE933H57a/0/ALaxEUCaHuW/dRhAlUaWceRRG2yTJa7h+RaANDLpFzwwSp6yOOZlKpcD+kpXxBsduPJ+4Ro5ki233skpUOgnlALF1vlaAnx0bbvD8FBEM2CdfWWaSq+LelB6IPm34o2QKu8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775729469; c=relaxed/simple;
	bh=XcC2keLsKUYhzfZlng6iqydsoSb5jTZlZkXD9ttYpSE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=O6JqJsvUypKCzOmrNu8MFZTltWwkHl6HRGUxvObtjhfjSoA7N+4aXOI9onwn9mZMX5yBHTU3CciodSORQ2+ddm39qUYb647o7rvW5qJZOHsRrFpyZcBUtHBedoxx7pyeeVirI3sQ9s1li28vs3cOVX2+Nox6Z/efz1RMWoiSYCY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cgpCnRQt; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775729464; x=1807265464;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=XcC2keLsKUYhzfZlng6iqydsoSb5jTZlZkXD9ttYpSE=;
  b=cgpCnRQtpI2UAtdQfC88sXUjUuEf5Yqfb/MwIySWoIi/rPOYQ97quHA5
   KMczYHb6bHJPaJwVRdTrsneIVxITYQY+XPcOWknhhpyiQXmpnPLsMLCjx
   MiconStzsh9J/QUxgTxnCW4yFS6VSFDmX3u9qKhJyhTjJiwuDRqcxvCH5
   kQU0V15liqAitd6PXOhfo9gsNCpawA5ABY1m0INDuXh3aMqD3rU+vp4pJ
   xykDRiz0xoYNrUWqzg7LLXVFd1dzJE2FmJGO0DPokfMINghf9bj+Xq5i5
   ES74d0XdqSOunMv8+4ygTKeWGQoOktpO41+SiC1Casn6MWeozajBAPoRq
   w==;
X-CSE-ConnectionGUID: KkvHtHkDSNCH1cMK17LzbQ==
X-CSE-MsgGUID: 2bWWsdnMT1ua8GNcBLJbYg==
X-IronPort-AV: E=McAfee;i="6800,10657,11753"; a="76609596"
X-IronPort-AV: E=Sophos;i="6.23,169,1770624000"; 
   d="scan'208";a="76609596"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2026 03:11:02 -0700
X-CSE-ConnectionGUID: kTPQRaw3SNuPyGnawVS4Cw==
X-CSE-MsgGUID: lbuCyI2kQ1y47sonRdueYg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,169,1770624000"; 
   d="scan'208";a="227873346"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2026 03:11:02 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 9 Apr 2026 03:11:01 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 9 Apr 2026 03:11:01 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.14) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 9 Apr 2026 03:11:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eg+Tu/Phorvzh9iK53ZxVC50MCkDayIR08EPfA9RFgqGj8aLRMLm5VzxKaEH6WkgfJ2ya7OklwkTq48TFL3ANi2nhJDJSFcVEdnwTg9tpxGZ+hV7qECBDDEateuvK6n+jlmz7ZVu+I59q9xzrJXzNDpkCfo9eEOgMuu5++2FwS+w+AyxWuIcdgy/vVTd3dbIku1ou+bOzSjSVmAoB4pmv2m+gXbwBlkr5IKXBER6sSaiIlt+cS79/O98Z2ug20wVd+vJvVkT8ZNrKJt7ESx3WHyH3aXhNUH8sHUvgFXunqEO5CIBULo07unbApy5Rx7d7X4+xJL8wm9F0JzbraTvZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nkM84itjCTcSvGyShkANyp7CZoLQuOA65aqdwgreYEg=;
 b=QeRlMLbbh8rN8293w/tPwT/bSgmBWuhkOznsqlEY0At98gvrNIT6JBM8YHA4r/f7HYTQENIlDTPt0DCigjr8DxSprk+kw+Zubd/NQfju0qH5f8xlls/OpKS3Q2QJsAroIbBG82OoX+uOKfXtqAKP2tkVnnSTmByNQjWjUMA+h9gkGeYbRc6LiPpKQZ01z5vNuRfbf7soYgSP2g5Khz4Ti49ix7zwc7Kxda8TPVmxRGZP3HkQDfGlaMqIGZoc09X1YQ6lV+N6uql2XAblmtEnySyQELkNLAJs9xrfh4VvLrZA4YIjVK8jE8+ny3wcLvbydNOJBbH/3mgp2KzCpcX2Vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8985.namprd11.prod.outlook.com (2603:10b6:208:575::17)
 by DM4PR11MB7184.namprd11.prod.outlook.com (2603:10b6:8:110::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.16; Thu, 9 Apr
 2026 10:10:52 +0000
Received: from IA3PR11MB8985.namprd11.prod.outlook.com
 ([fe80::355c:96ca:a45:dd5d]) by IA3PR11MB8985.namprd11.prod.outlook.com
 ([fe80::355c:96ca:a45:dd5d%5]) with mapi id 15.20.9745.012; Thu, 9 Apr 2026
 10:10:52 +0000
From: "Romanowski, Rafal" <rafal.romanowski@intel.com>
To: "Oros, Petr" <poros@redhat.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
CC: "Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>, Eric Dumazet
	<edumazet@google.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, "Nguyen,
 Anthony L" <anthony.l.nguyen@intel.com>, "intel-wired-lan@lists.osuosl.org"
	<intel-wired-lan@lists.osuosl.org>, "Keller, Jacob E"
	<jacob.e.keller@intel.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>
Subject: RE: [Intel-wired-lan] [PATCH iwl-next 2/4] iavf: stop removing VLAN
 filters from PF on interface down
Thread-Topic: [Intel-wired-lan] [PATCH iwl-next 2/4] iavf: stop removing VLAN
 filters from PF on interface down
Thread-Index: AQHctTGm49vYOdbmEEaDmGBzKodBArXWp9EA
Date: Thu, 9 Apr 2026 10:10:52 +0000
Message-ID: <IA3PR11MB898542C2014F85737321AB948F582@IA3PR11MB8985.namprd11.prod.outlook.com>
References: <20260316104209.1285962-1-poros@redhat.com>
 <20260316104209.1285962-3-poros@redhat.com>
In-Reply-To: <20260316104209.1285962-3-poros@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8985:EE_|DM4PR11MB7184:EE_
x-ms-office365-filtering-correlation-id: 666a17a3-32cf-4797-3942-08de962047e6
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700021|22082099003|56012099003|18002099003;
x-microsoft-antispam-message-info: 2XKLjdxwwGkpi03AxatkoyD1HTzrgpMD8r8q5uyXMAklqnyAmCGSalP88sP4CybpYiKWjnf7OEV8levGg6tw5geczhZ+hbCHWMDwj6eZ4vsjrliaRRZa+dSPq+iTmmoA6CEKXlih0qWm0tvTzDYjkIzZkO+5xpcln2etFkAuVlyyKEElkdTfKiqgKx447QBABVGZHXFDvB22QGLXVJjTjzE4/hzOlwbMILDQleGSFyH3FZCoGiN87HoHkY1pSWWzbYzpU/Tm+F2iXEe83rJmFOOX1pB6xm8G8F+wMqBLaTzuXrcDhj5y+Msc7Ih4ImD2qq28GOkJoJXW9vWOlUfgHHckGIfUoIjpaXarYykXX2y1qL+7h/QsG+Z7yLz47iTC8+CgMXLAxl1lRMUxPlBgKWOuo7iUdHRImiUlWxCA7+S7xLS87kA6rzNTfHGQJUf5/GeYfdQ5w4iC4Wn1SJnqBcdu++m9IbsKotsDHSBhBjcdzN87SmqRuNpqMDz4iizB3bdDpoCnrvklBEhNfTZCV8T3AI6klCVWAbTd72OjIoqXGh55ymJ1dU/wugSwV5Q/5kMElDSVWR3g0TSXQuBNFtb+rHsb68oY2K8bBFTPmk5Jcw0Mb/krMeio25dC1Ruse4AmOP/4C1JGcN/h7h0P0okY3/PCcesosquYX3+KFlYFPgKOngzO7aE9EcyURfelCcvpjmTYiKLuPxu9Ez2GZprO6fFNHbFMT0cEnj1bKR+7PPItcM8pvDaraTJKV2tclmON/6JEL7TVYkeEr2kl+3rG33r8m5fFDdvigm3lRQI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8985.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700021)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?7o6c2KwpQKgxUgC6P5IulgUHTkcP6edH5BvVB+KmqvQIhebHjfM5X9HFop5t?=
 =?us-ascii?Q?j1G122+uCzM1bvIQmjb/525tcj1vmc+WKomNtTfLZkHNSEGc0eg91GDL0cAd?=
 =?us-ascii?Q?FWjGGRY75jq5suA2FZ/H5YyWZNxWu/LpOvu+ObjTswnTWygsFpLpVj/sN6ff?=
 =?us-ascii?Q?MqoLmb+SnG/N31Hy6Ax8+18UIUHJqP74KOprrR9afV8VwJN6hp18k2S9zG0w?=
 =?us-ascii?Q?yj+TK0kRk615Oznwb6Wo+axURrbNwcUd4c328t/NdaxK8gJXO8pNXAkqeFir?=
 =?us-ascii?Q?DOU2G0fVgklH889VlNcNDoy+YEnMCPGjRY4/L7K0THk5IrszYmWYRqZCXQpj?=
 =?us-ascii?Q?75Hdu7rA4dzTtQ/6m9V9tX6yjVz1uqp23ZEKsfzsiBIEfJ/NtyDwAryG1FqN?=
 =?us-ascii?Q?wd4YtBLMpN/JG/n9Q3m2MLVEUBzSfTnu8MVvrDt9E1qtcbUU2KTXxeGQb3rv?=
 =?us-ascii?Q?X5P3xWwmzfno5CV0svRGS+e4EibjPgdGbY7UZX9y1nuPkhxNgteZnrqj7UM+?=
 =?us-ascii?Q?hA1PZj8iBfWdwCQkAPoLOwo6BASJSFCSvnAYYTHmAfdcFF+Rn93BP9uWpwr5?=
 =?us-ascii?Q?PKpKGPpGTDwg18DtXmbQPsnVTtDPLzrReQpzpnkY5N1/QS4AmBteqYZSKPwI?=
 =?us-ascii?Q?Er3Q/KZ8s49HYxadKOhCOtyIjh8Zzr4boXrD8hYSpWC9CdZY7Vc6zxXCMKaq?=
 =?us-ascii?Q?rWjSyZ9W3lU9nwOAUQ2IPGkhswBRvUXHN1LJ2vWipgZORdw4CDc85f1tDT3W?=
 =?us-ascii?Q?UOmqenELsRSMvJzi5Q1/JdhpIEEKrSmwkSpLtG7XAOtsMUFmEbHAU6MgtsN5?=
 =?us-ascii?Q?6WVQXtDSYOilxvT+lI1DUhOld+MVUeFuGDAeLdHmqoLagNVQlKDJ68vOoecc?=
 =?us-ascii?Q?s+/RFQj6ppUbFx2K6nToXDgc+/Jb8DFoR7IhShLPrjH3bMITVTF0ZUpqJu2u?=
 =?us-ascii?Q?nC2fEFc+7yWitG1MHLMsTl6EK6Fx+iCMaSoydnXJ3Y7jn0NrefojcpfZXafQ?=
 =?us-ascii?Q?dxW15kUFKDkn/ZYRRaINy4GFxEQZ5wMj9f3Sby2YGkVYh6aakyY7I8JX98M7?=
 =?us-ascii?Q?6llCxqYm3AkNdgfiwMTLMJTFEB6zPKE0Cr55yXsTmYC39gel9Bnc0VLTW/Ye?=
 =?us-ascii?Q?RhqwbJXn0JAD3BSfjkKP6lkQBgE/t+1m+//On41d3CcKpZXm3y6XVcyXCu+O?=
 =?us-ascii?Q?BKoUOd6ImfeVj/7cHuRkoeOjdkUXUHc7jEZSrfMpIQ2fhVx59uosBL6x9AvO?=
 =?us-ascii?Q?kBnxv+hFKvQSh298GRdBrbAE1cdVUFiHYUKhW5WxD63vDzbOc00WDxSGBQSk?=
 =?us-ascii?Q?Gug+Gqny8b5kJudbn2LQ8dBbHkXvxJ4PmCyFVYeic16355aUu33AUY7dJlJw?=
 =?us-ascii?Q?wjUcwvoJH4pvysn8XqG8YPHaB10gnffBcKOBv3Up9TYYHPRdRMLaGaK6HfO6?=
 =?us-ascii?Q?RM1iuRmLfxFJpvscTOQ+wDaUmHTP+EDCLZcNdcmWGWMThhAkoVS3vz+uL5kU?=
 =?us-ascii?Q?zR+voDbsQCpYBFn2p7IZyBnp62yySUQK/wzvLliM3fqfh66QnXC5GW4PycIy?=
 =?us-ascii?Q?lG3Sqsxy9J9NnD8UwNxtFJe9biyL81cojmcZZ+7kcfaOUB44n4vh7iRkHqzc?=
 =?us-ascii?Q?oQ6vZ6b5VCPASyOF035j6lU45g3Sub1JPMTpRPoys3DMyUVmPcg2BcEqHDj8?=
 =?us-ascii?Q?FRfMRAuYPb70OEjDNSGd7t/AY/qu+PZqDATlxDWOhsBrej3xPI4MaCTADniL?=
 =?us-ascii?Q?ScXoNi1Qqw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: soQ7+IS3jQt7t/+xyoxuMG9tE3LbY6QlqxVrgKKUf688MlbRVI2jlW2RDbieTYp73XkUq80BQiLi6VEwvEowbGqCeU6hZACDVnPKc0VUxEYXPTN/ZiJm7sYKuaFn50YtDWtGdx8eje6HWNQAl3G3dm9EXQs4BvGPMNhYYp9oCo7357zHA000Q+wLlXgxyhAVKE5wEhioIRTM4HxfzxixkZcnXZixNOdZIjEBQ/AAQ54cpvi6mJDnP8MjeNBr2ftJqdFzQI8n78OZoe+40K6wm6n+fCnHK5rstKRyqaothlZTl/UFJlgl92KJAIdhh2mf+YuvZP22x/qmhtnXECHNzg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8985.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 666a17a3-32cf-4797-3942-08de962047e6
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2026 10:10:52.2195
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hYc/hYx6NeVpx3b8wFTfR+kVbMDqNxv0wTVxbXYK42YgT+wS6zCtC/NUKph69gAn+4de9o8q+EMjEsbP+GQ6AgxTz4SirHxVQjXIy/sJGJ8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB7184
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-276922-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[davemloft.net:email,IA3PR11MB8985.namprd11.prod.outlook.com:mid,intel.com:dkim,intel.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,lunn.ch:email,osuosl.org:email];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rafal.romanowski@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 1C34D3C90DC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of P=
etr
> Oros
> Sent: Monday, March 16, 2026 11:42 AM
> To: netdev@vger.kernel.org
> Cc: Kitszel, Przemyslaw <przemyslaw.kitszel@intel.com>; Eric Dumazet
> <edumazet@google.com>; linux-kernel@vger.kernel.org; Andrew Lunn
> <andrew+netdev@lunn.ch>; Nguyen, Anthony L <anthony.l.nguyen@intel.com>;
> intel-wired-lan@lists.osuosl.org; Keller, Jacob E <jacob.e.keller@intel.c=
om>;
> Jakub Kicinski <kuba@kernel.org>; Paolo Abeni <pabeni@redhat.com>; David =
S.
> Miller <davem@davemloft.net>
> Subject: [Intel-wired-lan] [PATCH iwl-next 2/4] iavf: stop removing VLAN =
filters
> from PF on interface down
>=20
> When a VF goes down, the driver currently sends DEL_VLAN to the PF for ev=
ery
> VLAN filter (ACTIVE -> DISABLE -> send DEL -> INACTIVE), then re-adds the=
m all
> on UP (INACTIVE -> ADD -> send ADD -> ADDING -> ACTIVE). This round-trip =
is
> unnecessary because:
>=20
>  1. The PF disables the VF's queues via VIRTCHNL_OP_DISABLE_QUEUES,
>     which already prevents all RX/TX traffic regardless of VLAN filter
>     state.
>=20
>  2. The VLAN filters remaining in PF HW while the VF is down is
>     harmless - packets matching those filters have nowhere to go with
>     queues disabled.
>=20
>  3. The DEL+ADD cycle during down/up creates race windows where the
>     VLAN filter list is incomplete. With spoofcheck enabled, the PF
>     enables TX VLAN filtering on the first non-zero VLAN add, blocking
>     traffic for any VLANs not yet re-added.
>=20
> Remove the entire DISABLE/INACTIVE state machinery:
>  - Remove IAVF_VLAN_DISABLE and IAVF_VLAN_INACTIVE enum values
>  - Remove iavf_restore_filters() and its call from iavf_open()
>  - Remove VLAN filter handling from iavf_clear_mac_vlan_filters(),
>    rename it to iavf_clear_mac_filters()
>  - Remove DEL_VLAN_FILTER scheduling from iavf_down()
>  - Remove all DISABLE/INACTIVE handling from iavf_del_vlans()
>=20
> VLAN filters now stay ACTIVE across down/up cycles. Only explicit user re=
moval
> (ndo_vlan_rx_kill_vid) or PF/VF reset triggers VLAN filter deletion/re-ad=
dition.
>=20
> Signed-off-by: Petr Oros <poros@redhat.com>
> ---
>  drivers/net/ethernet/intel/iavf/iavf.h        |  6 +--
>  drivers/net/ethernet/intel/iavf/iavf_main.c   | 39 ++-----------------
>  .../net/ethernet/intel/iavf/iavf_virtchnl.c   | 33 +++-------------
>  3 files changed, 12 insertions(+), 66 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/intel/iavf/iavf.h
> b/drivers/net/ethernet/intel/iavf/iavf.h
> index 8e6db72828ae14..1ad00690622c8e 100644
> --- a/drivers/net/ethernet/intel/iavf/iavf.h
> +++ b/drivers/net/ethernet/intel/iavf/iavf.h
> @@ -159,10 +159,8 @@ enum iavf_vlan_state_t {

Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>


