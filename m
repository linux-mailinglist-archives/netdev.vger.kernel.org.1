Return-Path: <netdev+bounces-112528-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ADA2939C32
	for <lists+netdev@lfdr.de>; Tue, 23 Jul 2024 10:03:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD8771C21E79
	for <lists+netdev@lfdr.de>; Tue, 23 Jul 2024 08:03:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 332EB14B061;
	Tue, 23 Jul 2024 08:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jX1WeaMo"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96B341C695
	for <netdev@vger.kernel.org>; Tue, 23 Jul 2024 08:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721721825; cv=fail; b=TV9qkty1e62bmNnFStR5fDtfvBIfWZUO8qqIbDqDcFWChsFJ0r/J+0JW7p5kTeRXdTNRDLSogJnaNWWTAZWBxauzUDPBOylIPkKAaeiXSIhRV3E7LwR3SfwJBBb5cEE4wwy9Xp9IkF+jKtfeDwH33im1wvgRnmW9X5Jkip0zM6Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721721825; c=relaxed/simple;
	bh=U3Zt+xVkMOdsnb3ei2TftrB4ZOHU7HwlO3/mnk1qRBQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=u7hDjvyjmU4LlcyVhUh4MXgNJlKxU8vcYUpcZJHUrjemFGQgBU+XQAT1LqwNfL6PC60ZgR4tFXszFXkVHmZVMl3Jo1SjiB89W96JoIu4eD69JZrg9YH/AJ4Z7leLy4cGnu9S65wABAM9FFxVrlOK19lPzYhIcl+ufiLF1gUWPUs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jX1WeaMo; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721721823; x=1753257823;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=U3Zt+xVkMOdsnb3ei2TftrB4ZOHU7HwlO3/mnk1qRBQ=;
  b=jX1WeaMoY8vdfi4GgU4ya+m81cxdUKQtw7k6KU8CSPT0uf0boBIYabkT
   Qbu80tbzGPGK5RHfljwklWEKb8c1S87o1rfZVayskLl6TQnskoIVWZTa7
   pIukGiXKIu/qCWHrGD6Gy6TBvyFGs9dVS9ca5woP846IFRQ/8nCc2LdDe
   YD6mx24grcZBjyT+A/aQQhx3Xx0FX+/Pzv1/6yZcSBHGgh9z90i06hGeg
   KIZAnA0hXRT5Hxn6GAQfv74QTKzjsuWuyfJGjLCOR3AtwCGp1XpkspyWW
   FQgXQgNqvkPD8TNQnQWYeocyuRLLbo5HrYL3Kx8Vt5DqmJhdZGsITLd/Y
   g==;
X-CSE-ConnectionGUID: N1mVPVLZQyCjsYfeDqh6pg==
X-CSE-MsgGUID: LwBd1/hfTgaOT0frR7MHWA==
X-IronPort-AV: E=McAfee;i="6700,10204,11141"; a="19462962"
X-IronPort-AV: E=Sophos;i="6.09,230,1716274800"; 
   d="scan'208";a="19462962"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2024 01:03:35 -0700
X-CSE-ConnectionGUID: eVVfI9XqSfe9asoQSDph+Q==
X-CSE-MsgGUID: +scaLCKPSJeBboqQTJ07Eg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,230,1716274800"; 
   d="scan'208";a="56456860"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 Jul 2024 01:03:34 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 23 Jul 2024 01:03:34 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 23 Jul 2024 01:03:34 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 23 Jul 2024 01:03:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XYBj0PUpdz37DkDOeupOT2p5WUZg3scch3M5F0y4UlZ3BZiuBMmbhvOXyAeSVmK6FQclVuDhohnSS5MScRCqjmmYbGSugD6hCR3rszQ+BmSa0PMAMc0kmQyC9rAPjaCMYcFjWh6Qx6oeY9YIuKWPGIUvNaGMAYKSXc8MCJ4apnSKOJsVoekI4rjDdj7xfqxPv2KFDQURjJwE7d3AJTOhZ2C23dryp7njl5Z04fyHbHV4mJRT7Ci9JuxC3u1/9UOt+iIdpsxQx7r/+8ti/HJ4SS5L1MnjAKfSPZsHSgTUTt+IbksySArNRR1MHQBnA/jFPcGGyZEyFqgCV6xv9jgNHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OBA9y6UmBzyhGSe7ptpnno+zOrMTf0Xd5N/7mxD+hIc=;
 b=eQ/0cE9WtswsmqSLxbL6L4jra38Y0DYg28//hgsv9EO18r0VSVdU5Uci6uxW3V06Qoc+ZxqZSv2uXZ8i7aY/vUOVMmfpiBS75vCvlBnd62WSR+n7G7ChiguvmRbL11cJaLzYay20/FXEG/fed3hE6weGQZOkl+YIuKEDHToFjSe7xQX4wjm3EHczLlyrGdGgaAOVkgWAykQlONPwaNmcsH6NNLiefCYvxeT1YLYvDeYcfatytFVdkUrHtZKkRF/r2wjZvyrtd1JKFVJvCR3sDkZXEXrm8QWn5aHCDX9ZmR4LahqI8lprvPuwELWY0yL7O5snlNu9um0/xIdFgUzeYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB5865.namprd11.prod.outlook.com (2603:10b6:a03:428::13)
 by DS0PR11MB6471.namprd11.prod.outlook.com (2603:10b6:8:c1::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.20; Tue, 23 Jul
 2024 08:03:30 +0000
Received: from SJ0PR11MB5865.namprd11.prod.outlook.com
 ([fe80::b615:4475:b6d7:8bc5]) by SJ0PR11MB5865.namprd11.prod.outlook.com
 ([fe80::b615:4475:b6d7:8bc5%5]) with mapi id 15.20.7784.016; Tue, 23 Jul 2024
 08:03:30 +0000
From: "Romanowski, Rafal" <rafal.romanowski@intel.com>
To: "Zaki, Ahmed" <ahmed.zaki@intel.com>, "intel-wired-lan@lists.osuosl.org"
	<intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Zaki, Ahmed"
	<ahmed.zaki@intel.com>, Marcin Szycik <marcin.szycik@linux.intel.com>,
	"Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, "Keller, Jacob E"
	<jacob.e.keller@intel.com>, "Guo, Junfeng" <junfeng.guo@intel.com>
Subject: RE: [Intel-wired-lan] [PATCH iwl-next v2 09/13] virtchnl: support raw
 packet in protocol header
Thread-Topic: [Intel-wired-lan] [PATCH iwl-next v2 09/13] virtchnl: support
 raw packet in protocol header
Thread-Index: AQHasGgRSebwTcMvq0uv4NBNpKU3SrIETLgQ
Date: Tue, 23 Jul 2024 08:03:30 +0000
Message-ID: <SJ0PR11MB5865A70E58D269A8B9A950A38FA92@SJ0PR11MB5865.namprd11.prod.outlook.com>
References: <20240527185810.3077299-1-ahmed.zaki@intel.com>
 <20240527185810.3077299-10-ahmed.zaki@intel.com>
In-Reply-To: <20240527185810.3077299-10-ahmed.zaki@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB5865:EE_|DS0PR11MB6471:EE_
x-ms-office365-filtering-correlation-id: 55f1776b-eb57-4d4d-9235-08dcaaedf0da
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?KF1dpaYoQvrMqQX+bMdO+RplGuFmwtDTZRyeLeENUzqI+1s01wpM26mrE2KA?=
 =?us-ascii?Q?t3+3W+mZtO8KbXpC5EUQz5t/syo1NWlrY4hIt3sagD6IwgdW4+m6sSKT6tkH?=
 =?us-ascii?Q?EYsjgaBWhrx721f/w7HllOfhyREZG1/zGm25mbtV7aQMGnG5hctfteK0PJbD?=
 =?us-ascii?Q?cfZvrwcCzAS2hJORl25Vpi09SfZ3Pxn3gtIZiznuikSYJDW16fZIgQyClxK6?=
 =?us-ascii?Q?Gw4y4FfrnzDazQzmExWknL8MzpfdmViIc1BD+vYW0ycqif9d/eR8u4QPt5sz?=
 =?us-ascii?Q?nbDoawLUj58GdqLwgpSI8Zo1egzMi/fL2SdFB2DRAlgxx31lyIc7Qh8FQqj9?=
 =?us-ascii?Q?4QIqLFjx/I4khiUGP1v2RitYRrFRBshwwC+vqwIzDEj36A5vNftdNHXpJkNt?=
 =?us-ascii?Q?vKWlXn86KqJL4Bk26eR0/e6Uj7gAFu8ugJ+r0rTGZnSx6yUzOQMSkhI6oUyC?=
 =?us-ascii?Q?RD0d5zbx5GQjGNI3HQRx0tZ7bTU4bEN2EPvtK/xmuOeFreFGSwxhRvUrm540?=
 =?us-ascii?Q?x5er9w/DUVuxWJVjT17uPQT+I7bDfDGJiHnT9BLDtfNiiReRCLMP4q2IVuMS?=
 =?us-ascii?Q?Fx2VSaH/ve+C4MWGlrAFI3l/qUwHVYQJ7yeT5vy2i3gJWOM/URwMVcSd2V+r?=
 =?us-ascii?Q?DwcRwIcPHHUfUy3xOdokuraYA+nKcvv+tgWrSdMo+Q61ThjVUiidJeNU6jwm?=
 =?us-ascii?Q?d3oxttuDPu03YUIN4ulHy9XXVv4bMnf01LjowcVNUsLAONN2ZIMJGAt5Rq2X?=
 =?us-ascii?Q?kM8FNakVoKL5clOUlGlGEHw/7GFWFeqYv6hlBnjES9V0l25EwHkeEF8DlZkG?=
 =?us-ascii?Q?KCPc9knHmeUzOgNZE1CaA0bFQ6n2TKQuJS1H/hjtobGN6PHCMCuK38x6N+iD?=
 =?us-ascii?Q?x5DDBmInPdCPpXtcrLYLw5LKIQy/p5gPf1TZu9fLOCnB8Oh+Ios6pU1u2DBP?=
 =?us-ascii?Q?1UihbbXGMBvvOFx+jDFvIHsUPQv9Q2iUTTHJSK7fApIQqOhYu8w4Q9/UBAUO?=
 =?us-ascii?Q?iaG6QOEVNxfDx5u5fOGn5MUVGknN14ZOaRla66ZTRpOcEBwUrYJG7NLJMFDb?=
 =?us-ascii?Q?Yn21+Ou9j8nZmSnDwoegUcQlpGsBdzWCBpho04scpQ3zwBTIvSYZmz/XYF95?=
 =?us-ascii?Q?yyjOAeSSxNtfqdPo//kTFH6KZDBnK0EuycpBhmRwwu8UDslid3qqgiQmmoLk?=
 =?us-ascii?Q?4Kza7fbJQtEwRO0rwptlIXuaV6rkiN3cI/H23Uagkn81nnzJeWFp1KVWF+R1?=
 =?us-ascii?Q?Js4Mwt5SZ3xshrxhMnSZv0HnfWJ17/XLWWh9aIbde/QNQbR9lTGaPcA8jq8C?=
 =?us-ascii?Q?PpZQQRek5XYffkloj68g23VjcwjumxpDdOqAxhwTUygXPG3xFocQb+7wJZIp?=
 =?us-ascii?Q?+2hM9u7uE0ur2Mw8TKMyPeNjoDqmgJohlJe7Nm5w3iNQ9DZlOg=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5865.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?geWDNWBIKHBvptB2llu6xrm8VlPqTA0XU0Rwom1m3Mg7rOmCVjCNj2Wu4zwo?=
 =?us-ascii?Q?Szm1gD+y5vR1mrCw7qrczrqEE2UaR97QAbSM/ekFL2jXfZPN6OFfxrmuAaaX?=
 =?us-ascii?Q?gfMjPcwoXcEwPgWED8URxoL7bCz2QPC4FivJMiXnA7AM5s/28VXMIsreUr8C?=
 =?us-ascii?Q?29oGYM2MpctBq02sqozz7BKT6ALdlqvTQHGLjp+LHwBFmpp2nWCovi1PP2kt?=
 =?us-ascii?Q?/JTLDwJAuKmal5jCNKvpRxZawiNYp5wH1/bItRM1QnTIOKp6q8lpU2FRKtnx?=
 =?us-ascii?Q?BpQlMXJgJN8Mc6KSLEc1s18DFMT3OgeLu7uym1Mb/y1gqW5WKRN9tOLJZdIQ?=
 =?us-ascii?Q?M5bPoPgugz16rCtBPXOxhzY0dJUD0MkVUIWmjhOVWvf5ICiy4ajFKyiljzvs?=
 =?us-ascii?Q?4K4c0qewkPIwHv415c4Wy7xVVHmXCHSEGW6ICEK7jgN29yIHL46rhHMVM4yB?=
 =?us-ascii?Q?5nUPDaAuLTsFLcQ6AK5k/a/XOp3RdfOM4eYf2es+9ZXF93e/U//9yGB+ejZS?=
 =?us-ascii?Q?JFPHlgMwmdL4kvc+9uqNdJTV7opM8/RmqQDvOvoNnOwTnuqdj31rlRKrZaWR?=
 =?us-ascii?Q?Xp7pO0aKbVWjYg7ONuS94WZLJrn7OumFnkeyialUDSY5AoEQUsSVoSf3PjHk?=
 =?us-ascii?Q?4jmS1nIjejpZN/isoMPeA+si1fFASGeAMHA9qvqlOoTuQkDFXYcLqLE2XTQE?=
 =?us-ascii?Q?mSuFtbGVrmR1UA13odigNq3J5M75s6YNMVFRaLpcUYhADmyKga7fzQ/vBXrC?=
 =?us-ascii?Q?cT/ZU7K2LRm9iLbYjugEKJvwPKJX+2Vmw3o14Ud9N/nOYkdMMg0TiQcfpR4N?=
 =?us-ascii?Q?3rjljqwrzOQVzAe3oGbtvqYpDj/IFn9QX9dFrqUf8mEtnbPHtcf6STbtSFDQ?=
 =?us-ascii?Q?m5fXt81gfO6MzE2LPLq9996hpUfLfc4uR6asoudsQWxxiSG8CAK9v7apW8hL?=
 =?us-ascii?Q?pIvkLKtcXcFMath5kqXTeRDY8Nnu400r4T3I5l438mUqb0KrQ62mWMAt0dvp?=
 =?us-ascii?Q?vm4y7ynwx3VraQPE/Uc7pTViz7D6aGE8NmfCBcIZUQeVvHQkBwJ+fUnNeQij?=
 =?us-ascii?Q?3EpznjQB4wlnRo4x8m4sL8OQ5CYDjDOe5gDDovqrimHnOfPmnQoK0W0eR5UY?=
 =?us-ascii?Q?Bys06VTh1SHq+fIo/R4xi/zU1QoTvZqoIqJniFRlAqeSDrSVw8UJoqExKSwv?=
 =?us-ascii?Q?FV0waVm/w+G09YsW8sy6qIYcZoiQWBu0dImQwf9Gq42cKfi9FcaMYI7Ae0rE?=
 =?us-ascii?Q?/DP2z7kt2RVrUlsk+Ug5a6+17gCWhoahea7ZEiGWUfZ8ZLkrZTKYKPkTfZ3Q?=
 =?us-ascii?Q?4N1hmRIPmr05iTb5AbbBIu58zF32vTtLro+EVAyMLLsZvI+kg0dU7UeFpi3h?=
 =?us-ascii?Q?xfMzuoYL1bCRZ5Ku7BrOqi0UswV6NYzkorwhPYxi0gHAZAncsFNGIII7WO0e?=
 =?us-ascii?Q?BEfMpg80eAlykpU0N5F7UIRCPwQ1VT4tUpxZ2pM34VduucXNyJ9ZQMY55vhJ?=
 =?us-ascii?Q?vDqpgQoOL4xg/Q0JYLhpxwyB1K0fnomdt8uzgkUv9BXiGMfkQDfh+ftdmFeA?=
 =?us-ascii?Q?M/SyxAJ3FxcDd1K/AU2mIA3R1ndPtdtIMvdna8X8EfXcWisZcJ6Dlbv9Qjom?=
 =?us-ascii?Q?ag=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5865.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55f1776b-eb57-4d4d-9235-08dcaaedf0da
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jul 2024 08:03:30.4082
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: J690JVbObHY5f20CoU2xOQR/6yLKkQ/7QKWXHzR1WKDUm4eqRU+OYQVMs8vEWQ4XuT8k6sFgMVtrzRRlOhdC/dmBXdV6ACH5pgba0oMioN4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6471
X-OriginatorOrg: intel.com

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Ahmed Zaki
> Sent: Monday, May 27, 2024 8:58 PM
> To: intel-wired-lan@lists.osuosl.org
> Cc: netdev@vger.kernel.org; Zaki, Ahmed <ahmed.zaki@intel.com>; Marcin
> Szycik <marcin.szycik@linux.intel.com>; Nguyen, Anthony L
> <anthony.l.nguyen@intel.com>; Keller, Jacob E <jacob.e.keller@intel.com>;=
 Guo,
> Junfeng <junfeng.guo@intel.com>
> Subject: [Intel-wired-lan] [PATCH iwl-next v2 09/13] virtchnl: support ra=
w packet
> in protocol header
>=20
> From: Junfeng Guo <junfeng.guo@intel.com>
>=20
> The patch extends existing virtchnl_proto_hdrs structure to allow VF to p=
ass a
> pair of buffers as packet data and mask that describe a match pattern of =
a filter
> rule. Then the kernel PF driver is requested to parse the pair of buffer =
and figure
> out low level hardware metadata (ptype, profile, field vector.. ) to prog=
ram the
> expected FDIR or RSS rules.
>=20
> Reviewed-by: Marcin Szycik <marcin.szycik@linux.intel.com>
> Signed-off-by: Qi Zhang <qi.z.zhang@intel.com>
> Signed-off-by: Junfeng Guo <junfeng.guo@intel.com>
> Signed-off-by: Ahmed Zaki <ahmed.zaki@intel.com>
> ---
>  include/linux/avf/virtchnl.h | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
>=20
> diff --git a/include/linux/avf/virtchnl.h b/include/linux/avf/virtchnl.h =
index
> 8e177b67e82f..4f78a65e33dc 100644
> --- a/include/linux/avf/virtchnl.h
> +++ b/include/linux/avf/virtchnl.h
> @@ -1121,6 +1121,7 @@ enum virtchnl_vfr_states {  };
>=20
>  #define VIRTCHNL_MAX_NUM_PROTO_HDRS	32
> +#define VIRTCHNL_MAX_SIZE_RAW_PACKET	1024
>  #define PROTO_HDR_SHIFT			5
>  #define PROTO_HDR_FIELD_START(proto_hdr_type) ((proto_hdr_type) <<
> PROTO_HDR_SHIFT)  #define PROTO_HDR_FIELD_MASK ((1UL <<
> PROTO_HDR_SHIFT) - 1) @@ -1266,13 +1267,22 @@ struct virtchnl_proto_hdrs =
{
>  	u8 pad[3];
>  	/**
>  	 * specify where protocol header start from.
> +	 * must be 0 when sending a raw packet request.
>  	 * 0 - from the outer layer
>  	 * 1 - from the first inner layer
>  	 * 2 - from the second inner layer
>  	 * ....
>  	 **/
>  	int count; /* the proto layers must <
> VIRTCHNL_MAX_NUM_PROTO_HDRS */
> -	struct virtchnl_proto_hdr
> proto_hdr[VIRTCHNL_MAX_NUM_PROTO_HDRS];
> +	union {
> +		struct virtchnl_proto_hdr
> +			proto_hdr[VIRTCHNL_MAX_NUM_PROTO_HDRS];
> +		struct {
> +			u16 pkt_len;
> +			u8 spec[VIRTCHNL_MAX_SIZE_RAW_PACKET];
> +			u8 mask[VIRTCHNL_MAX_SIZE_RAW_PACKET];
> +		} raw;
> +	};
>  };
>=20
>  VIRTCHNL_CHECK_STRUCT_LEN(2312, virtchnl_proto_hdrs);
> --
> 2.43.0


Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>



