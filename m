Return-Path: <netdev+bounces-134324-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AD088998CB8
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 18:04:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 283201F22DDD
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 16:04:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DEFC1CDA14;
	Thu, 10 Oct 2024 16:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JrvLl0h9"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C3311CCEE3
	for <netdev@vger.kernel.org>; Thu, 10 Oct 2024 16:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728576217; cv=fail; b=U4stV4YXdoqrVdqmkLEniIBT1rLA0uHEhvWKC0iPUvyEdHfUKKhFe2Qqnmd+4xqh4+ATamkHv6/qmBWpT7pdzJoW8PyPfGnZKvZGIw7S9vRRtTp9YkCj231MsqgPHCYAQPIDxweAmyOl0kIVg7NOor+BUOE5CEE9wWmlavP2xLY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728576217; c=relaxed/simple;
	bh=pBxBr2YEJJo8YG+Oz+hEbmloE/I+K4OAUhLfWUxjFu8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=SZvdcjzPwZ4LZkc3OqdhFWjfwNbFUZ0pyqqNF3rUNZLS2WT6IxzHX+5YWtmeCfcA3dxOABuT7ew18c5CDHm8aEpNW0scL2aawMePquly0TNk5/q3l95OScNj4P0tji+PaMy5o8PycADOhwVX8Xn9oAqafK/seEjDxHEl/rH/Y2Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JrvLl0h9; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728576216; x=1760112216;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=pBxBr2YEJJo8YG+Oz+hEbmloE/I+K4OAUhLfWUxjFu8=;
  b=JrvLl0h9qW4DQU4d4+rojIwrqorIZFEIU7FVuazWQYdVWSItUeIG8z39
   y60yfUs+jvl5f9HCN4nWE71GUsiSe0OASnau8hhTVYO/XPhvbPxSlrhlN
   ZPg7ye9e0ia3L7n//2hXohjJ9P7Z+kW/yvZQhPcKxGuZGy3Fb8XqErf6T
   9BSsMMKLPjC+AywrOzGAx63n6YTHZWkHh1w71YyHhwj4KaEAcwzQehvqO
   9o15PoiDdnvqrlxubM6mLS0k9Hc7PM30Y2tExjM/NBHHY3nAdCMAZxqb7
   tCuZwyMUZsZQB1GCwXm0lk+Sv88xnzdaVBX/qK5rKzcfuJRcKg42puvW/
   A==;
X-CSE-ConnectionGUID: 918uNnaJT4yIcxHz5QQkEA==
X-CSE-MsgGUID: zzhwNyHkQV6S+j8SwRF8RA==
X-IronPort-AV: E=McAfee;i="6700,10204,11220"; a="50488327"
X-IronPort-AV: E=Sophos;i="6.11,193,1725346800"; 
   d="scan'208";a="50488327"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2024 09:03:01 -0700
X-CSE-ConnectionGUID: chcll6BLSUWg1/thinAh+w==
X-CSE-MsgGUID: r5nIKVxBRzO5HUdvbk64rQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,193,1725346800"; 
   d="scan'208";a="76646353"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 10 Oct 2024 09:03:00 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 10 Oct 2024 09:02:59 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 10 Oct 2024 09:02:59 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 10 Oct 2024 09:02:59 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.44) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 10 Oct 2024 09:02:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OkoKGmOORKIkPKsAJnq1e6/HxIIKc3cmXd9CfXoFHBkIGh3lHsbnuPQYSownSr5lwVrFBihpsX99q2WdOMGql2/mbkL/chDbr8rU0Qd11ewdKiHu8b6pdcKnD9tUWFaoNqT+UCcXbr0jgE3/R6KJSRmZgdrXjdzMDQ/U/cYTrhWNrnBVDjqaQzJxh6Z+5ckPikMbh4jyBt4q68A/2XFNMXLERSLUv7y4ZhySTxX+eYWeFLVGGL3GimjSc6gVV0Qx8WqxPwwMo6gHwTBIIevaYkVEDM3ERcnEqag91jYP3ep03ApDkH+8aSMM/c6fNrTJI5R08EA6Oyszf7Kw+bbKTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XPcHX5iZVLD4/2hcVTJjLhLkK/Pnq3VjFaJ+mBmmjFY=;
 b=vJqLa3ClR0hAprfNboMVJ2zJwVtOJhVu2RDmlmMKWQUrZugdFN+lhZrzkHojKSBoxgNpksAi3KCjSvQfFWgAArljzuR4Vpt9AaF1TfXbV5soltD+dw9RYJ7KKcS6LnJglk0m/lj/XoczpwW61/RkcedTmW1rlFXVVKyKO6wWVqY5KQsyokilQZv5qbJPdIZQhDPPcnDoHTqeria/SiGbBA67jqIBFbVKt06/NgqQg08/RYMZkI3wHn4Z+tzL77C9wVWYVcaHGGvAGtcjiOSDlDOklURQ+IC7vsfDDDUJQj5Hb0pmCA6vhWMXVJsXq37gbnXufevimUNfi5mYbgydoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB4657.namprd11.prod.outlook.com (2603:10b6:5:2a6::7) by
 MN0PR11MB6110.namprd11.prod.outlook.com (2603:10b6:208:3ce::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.18; Thu, 10 Oct
 2024 16:02:56 +0000
Received: from DM6PR11MB4657.namprd11.prod.outlook.com
 ([fe80::1d5f:5927:4b71:853a]) by DM6PR11MB4657.namprd11.prod.outlook.com
 ([fe80::1d5f:5927:4b71:853a%4]) with mapi id 15.20.8048.017; Thu, 10 Oct 2024
 16:02:56 +0000
From: "Kubalewski, Arkadiusz" <arkadiusz.kubalewski@intel.com>
To: Jiri Pirko <jiri@resnulli.us>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"donald.hunter@gmail.com" <donald.hunter@gmail.com>,
	"vadim.fedorenko@linux.dev" <vadim.fedorenko@linux.dev>, "saeedm@nvidia.com"
	<saeedm@nvidia.com>, "leon@kernel.org" <leon@kernel.org>, "tariqt@nvidia.com"
	<tariqt@nvidia.com>
Subject: RE: [PATCH net-next 1/2] dpll: add clock quality level attribute and
 op
Thread-Topic: [PATCH net-next 1/2] dpll: add clock quality level attribute and
 op
Thread-Index: AQHbGkZvGPkGlPu6Y0mXskgCaB/USrJ+WQiQgAAbU4CAAUdtYIAAIOqAgAAWBWCAABxWgIAACf6A
Date: Thu, 10 Oct 2024 16:02:56 +0000
Message-ID: <DM6PR11MB4657140103B9C33B3899041E9B782@DM6PR11MB4657.namprd11.prod.outlook.com>
References: <20241009122547.296829-1-jiri@resnulli.us>
 <20241009122547.296829-2-jiri@resnulli.us>
 <DM6PR11MB46571C9CAA9CBE56D6A5FCFD9B7F2@DM6PR11MB4657.namprd11.prod.outlook.com>
 <ZwaN7XZpS6tEnTdB@nanopsycho.orion>
 <DM6PR11MB465772532AB0F85E9EB6E1719B782@DM6PR11MB4657.namprd11.prod.outlook.com>
 <Zwe8M7KZHOLGzUXa@nanopsycho.orion>
 <DM6PR11MB4657E57046E4263E2ADBAED29B782@DM6PR11MB4657.namprd11.prod.outlook.com>
 <ZwfmcTxYyNzMYbV6@nanopsycho.orion>
In-Reply-To: <ZwfmcTxYyNzMYbV6@nanopsycho.orion>
Accept-Language: pl-PL, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB4657:EE_|MN0PR11MB6110:EE_
x-ms-office365-filtering-correlation-id: ea80ffea-ea3d-41d6-48da-08dce9450126
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|7416014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?B4XwmGnAQpt2Mc4u08YXetS0hNF1UW2Ljv778mrjQ0OX1F8M9XQLEVoc/0Mo?=
 =?us-ascii?Q?vDjKncwBGBZoJHj8Yzej8Du1VpIeaOGPe4iwSixXlvXhU+3mrnKfp4NpS3j0?=
 =?us-ascii?Q?Ac+JX5B53vTL9SvY3vp+90NTeRKGQRLF7B3TAguN94H2zvoGzBC2ZJI8Vc2U?=
 =?us-ascii?Q?ezHg5iknpI1CjT5kzgG+4VC0C2lqFREJaLd1rjw3GUA0qHTitCgS84CJFhdh?=
 =?us-ascii?Q?RXdndMlBJEbe7Qd+Tz7CBLKIpbvUG3rjeA+wUP2GrPfBOFSOgIpQZ7p137Ej?=
 =?us-ascii?Q?pfxaynqHeJSLSAvsvwfGkWIJewZG8HSEsUlb51Y5hUVnd2J7TO/V7f3rtMkK?=
 =?us-ascii?Q?bMnoCOCjbf2RGzJk1j6Ser2EIh/b8oJuc03G/v7P4dAdSCOlzEb/hs7uTvk9?=
 =?us-ascii?Q?hUZbX/z6wJZV5ZWmmxBtrvjZHXGUH87Ji4aN8VE6n6xMYVQMxX3V2H/W+ZDr?=
 =?us-ascii?Q?fv8PHGl9j7qcHHIPf6DVmzRt4NIvZMipOR+aK7tfvlOREIQG1u2bGqVhFKBf?=
 =?us-ascii?Q?bOWeXokAp6KYQ7eC7Oex3rIqa1w7V1PMoqL6IAfXDpepw2qHgKNIbnjb6i2E?=
 =?us-ascii?Q?G/dfWjwwnWHi1R8juZ9Cv7peejEk6TQJrZlEUSJ7910QFn8tPhG9lpPT0UAV?=
 =?us-ascii?Q?8icsvY3w/x5H9KqJSJy8W0yyEej4R4w6I7kM+vljSxFQnvnMYYv1PnAHJFAW?=
 =?us-ascii?Q?6vUh3JnIMIgChJG7cR/jVgT4Y2N9ryP29RfUFOd5lz263U4hM6FwS4nD5fIU?=
 =?us-ascii?Q?lLmfs8sKOD8GETVi+DgRUd989Iah9BxL9FHyEAZAI7DlGwuPzyPXGstj1f8G?=
 =?us-ascii?Q?SltMYYmmJNsPraurHSt9LSLZsRBur5/vPyGC4CPZC0uD6dwpOwb1EGB9p+xt?=
 =?us-ascii?Q?e6HjqMbLidnnqFhH7Oli7HZ1YFwxGW9GF9pZD9Q2E5IcozeRHUhcf/Mo/20o?=
 =?us-ascii?Q?r2mpOd7fdOsHYBMolWnN6ocHhdklOq3W7DXLDOlPt9cGOfirrdNzrQylz5mk?=
 =?us-ascii?Q?9iA/lYwCnIXs74bvlglTSk0coqXgSQ0WdODyVHsVYP6S/T17FR2GtCTru26F?=
 =?us-ascii?Q?6rVKPvaopHsyaoZGyVbuN34MW7CUJiVZNfdbf1y+CCpC3ptTYgA/rBvH9SfU?=
 =?us-ascii?Q?9S0y/ICbnvseLTysRAbDFEFmPgO45uQW15FSpOv0ToGPbuSKE3Lv4uupKl9m?=
 =?us-ascii?Q?1NZ7JJw3nZzH9Pf6wnJwObaWrrPoHoMkVZL0iMmh5gYSPAQPLH4r3X3oVO7Q?=
 =?us-ascii?Q?ysYj/6AgEYaMAAYbOB0INBXxe2RA3m2aFwSvAkcr3VYOlGXRkPvZZm1D+XcZ?=
 =?us-ascii?Q?y+2Ol0FjWtWAXdLb21TwNtDge75ikwVIwumlO9Y53DZ6vw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4657.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?dpcr54kvadopQwUT5ZittViAeuQUWl1Q3EbAONFLxuzgMqYreRuU0GkcCXFN?=
 =?us-ascii?Q?fzO8tqg77ityZ1q6d2fhB8zfbDZEtFuLFti/WpKRdN9bd0rANJmhN40LyLtL?=
 =?us-ascii?Q?ph2bolWhUIK3PKnR5uJUz//Yo5Nbay3AX10zJ5eviIymB07qfD1r6Vv+IXtO?=
 =?us-ascii?Q?qN1eZvc+ks21yehGy01aE8aLtsqXTcoJB5rGszKRgUcbYyshkbkZiEGCMX11?=
 =?us-ascii?Q?3FEKEF6042Wn61akg+eNweKHwMv0hI1wMqxyCi2pgXoRFJUcaSaXgzN9Zin4?=
 =?us-ascii?Q?6pXvb79L7aK8IYg39bk44K1rPBRtCz6b0c1Px80zugIlFY9DdcDpBXh7vg9h?=
 =?us-ascii?Q?3R3NAEwM0BOTPeP9S5Jzyh/MpgawU+0XIBacPR5zTwP4r4tLsRSDNY4kPZAe?=
 =?us-ascii?Q?HTEIVi+3vy+4/0h0itVbLABzhS6hRtDjBxp0H8XxggH+18RibenOFQ60UBa1?=
 =?us-ascii?Q?XSiDX2e2dKL4jJ5G3brQWyQsa0crFP2tw7w1LeBWeYD9nzUerLI9R5zNbTCg?=
 =?us-ascii?Q?5bI5jQjiM8J1iRDUInmkEKoutk8aunRhxQd3nlmyl3HaSWXzTjlYA8SthHEl?=
 =?us-ascii?Q?aEyqFTGXcOMX8VJaeJruJjjBjS+2sdYv05BCGe37xSkjhEk5wq1S+n6uth9h?=
 =?us-ascii?Q?q2TpsHR4hPeNET/yGK80H5R252h5ZYrVaGXsMJ3yrCjxoBK/SIVwhIiozJEI?=
 =?us-ascii?Q?mUO/1nfWzPHFyeoJo3Rkhf6yCtGo0nA92Tn/nOkt7Vul2DXcZn6cEjSDXNOr?=
 =?us-ascii?Q?Zb8ZPmImLwoRXzT85BUnz+t4ynPNO55YhLT7UbHEbdTWOLHelRCwwJ+kj3nO?=
 =?us-ascii?Q?ooj7KXl7JxMztLPC+/J5PdbJcVH9fRPfQ3GFla3EA1/9PFTDKtZPAASAE6aJ?=
 =?us-ascii?Q?RBXfdnGbGGDMVjqCZN+k5ZXYqXVqqTt0II62S0TT8u/Pz79tTf/C6U/GsCzX?=
 =?us-ascii?Q?HZ3Wv+aznfwlnvOuefcBHDd+GQbtE1g/l7+5iFvdUwCYdNjhPZ2TAsVHNjzg?=
 =?us-ascii?Q?41oipbEYHyZmDihOs8E2aSjMnAlm3NlLQ/Jq+MEp48P3B4Xzlrm7IK53NvSI?=
 =?us-ascii?Q?sfIZqvs1fEHPITFfpNPVb8NCBUlXKimofhnHJiMx9k9nF93Sbxs/lxUSMWHM?=
 =?us-ascii?Q?4bPzbjnLosJCsd+sb7uk5UK1chA/yxwUQSRahLbrkkEpD0+03sAdw9YK7viE?=
 =?us-ascii?Q?Y1ELA3ijrreiWnA3J9eoNrZuOz2L6sE9e7JfIjC2ezEup6E75488NsUh0KHU?=
 =?us-ascii?Q?LJekpf3zzMuYTQtD5jDsE4dibCAJEYTaXkX6OjC7wvZqR1BTNvXDT5VsVR66?=
 =?us-ascii?Q?6NEyXvvRinjXSu1sP0MaxcxUa3m+wFP8afVh6FdJWY8X43jHKTll5WGAfKYD?=
 =?us-ascii?Q?z5nf/6GicS7BW/o4X5Jm/c5De8EFTodPywulvKrEYoikdWoFr+u5zMcEOQRW?=
 =?us-ascii?Q?Fp5ooKR03zFcIPHIqbnLbAP5TEtU5s9f9edJUKpvNNswevSUcpmWcpyclYO4?=
 =?us-ascii?Q?ZYxp7xXO6BX7Qzd2TPP8eIX1Hz0NyoEe9Il7NzxD3nhslL9upJLTbItQn82u?=
 =?us-ascii?Q?m6mU+4yhH0/5ZIcE3CDwlKtmqbb4t2KjevLsDLmwi7MX4pc1Tjw0i38uGIHR?=
 =?us-ascii?Q?MQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB4657.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea80ffea-ea3d-41d6-48da-08dce9450126
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Oct 2024 16:02:56.0479
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3Hz9stkbQmUYyukAtrZ8uTX42j0BesNK3m2K10J1SkSpM4OhCvHRzTVmPQgDc5wwdTNBXwUBHX/9CyvIlqDzBdIu8KVs7ZF3/LNpn7pJ0HA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6110
X-OriginatorOrg: intel.com

>From: Jiri Pirko <jiri@resnulli.us>
>Sent: Thursday, October 10, 2024 4:37 PM
>
>Thu, Oct 10, 2024 at 03:48:02PM CEST, arkadiusz.kubalewski@intel.com wrote=
:
>>>From: Jiri Pirko <jiri@resnulli.us>
>>>Sent: Thursday, October 10, 2024 1:36 PM
>>>
>>>Thu, Oct 10, 2024 at 11:53:30AM CEST, arkadiusz.kubalewski@intel.com wro=
te:
>>>>>From: Jiri Pirko <jiri@resnulli.us>
>>>>>Sent: Wednesday, October 9, 2024 4:07 PM
>>>>>
>>>>>Wed, Oct 09, 2024 at 03:38:38PM CEST, arkadiusz.kubalewski@intel.com
>>>>>wrote:
>>>>>>>From: Jiri Pirko <jiri@resnulli.us>
>>>>>>>Sent: Wednesday, October 9, 2024 2:26 PM
>>>>>>>
>>>>>>>In order to allow driver expose quality level of the clock it is
>>>>>>>running, introduce a new netlink attr with enum to carry it to the
>>>>>>>userspace. Also, introduce an op the dpll netlink code calls into th=
e
>>>>>>>driver to obtain the value.
>>>>>>>
>>>>>>>Signed-off-by: Jiri Pirko <jiri@nvidia.com>
>>>>>>>---
>>>>>>> Documentation/netlink/specs/dpll.yaml | 28 ++++++++++++++++++++++++=
+++
>>>>>>> drivers/dpll/dpll_netlink.c           | 22 +++++++++++++++++++++
>>>>>>> include/linux/dpll.h                  |  4 ++++
>>>>>>> include/uapi/linux/dpll.h             | 21 ++++++++++++++++++++
>>>>>>> 4 files changed, 75 insertions(+)
>>>>>>>
>>>>>>>diff --git a/Documentation/netlink/specs/dpll.yaml
>>>>>>>b/Documentation/netlink/specs/dpll.yaml
>>>>>>>index f2894ca35de8..77a8e9ddb254 100644
>>>>>>>--- a/Documentation/netlink/specs/dpll.yaml
>>>>>>>+++ b/Documentation/netlink/specs/dpll.yaml
>>>>>>>@@ -85,6 +85,30 @@ definitions:
>>>>>>>           This may happen for example if dpll device was previously
>>>>>>>           locked on an input pin of type PIN_TYPE_SYNCE_ETH_PORT.
>>>>>>>     render-max: true
>>>>>>>+  -
>>>>>>>+    type: enum
>>>>>>>+    name: clock-quality-level
>>>>>>>+    doc: |
>>>>>>>+      level of quality of a clock device.
>>>>>>
>>>>>>Hi Jiri,
>>>>>>
>>>>>>Thanks for your work on this!
>>>>>>
>>>>>>I do like the idea, but this part is a bit tricky.
>>>>>>
>>>>>>I assume it is all about clock/quality levels as mentioned in ITU-T
>>>>>>spec "Table 11-7" of REC-G.8264?
>>>>>
>>>>>For now, yes. That is the usecase I have currently. But, if anyone wil=
l
>>>>>have
>>>>>a
>>>>>need to introduce any sort of different quality, I don't see why not.
>>>>>
>>>>>>
>>>>>>Then what about table 11-8?
>>>>>
>>>>>The names do not overlap. So if anyone need to add those, he is free t=
o do
>>>>>it.
>>>>>
>>>>
>>>>Not true, some names do overlap: ePRC/eEEC/ePRTC/PRTC.
>>>>As you already pointed below :)
>>>
>>>Yep, sure.
>>>
>>>>
>>>>>
>>>>>>
>>>>>>And in general about option 2(3?) networks?
>>>>>>
>>>>>>AFAIR there are 3 (I don't think 3rd is relevant? But still defined I=
n
>>>>>>REC-G.781, also REC-G.781 doesn't provide clock types at all, just
>>>>>>Quality Levels).
>>>>>>
>>>>>>Assuming 2(3?) network options shall be available, either user can
>>>>>>select the one which is shown, or driver just provides all (if can,
>>>>>>one/none otherwise)?
>>>>>>
>>>>>>If we don't want to give the user control and just let the driver to
>>>>>>either provide this or not, my suggestion would be to name the
>>>>>>attribute appropriately: "clock-quality-level-o1" to make clear
>>>>>>provided attribute belongs to option 1 network.
>>>>>
>>>>>I was thinking about that but there are 2 groups of names in both
>>>>>tables:
>>>>>1) different quality levels and names. Then "o1/2" in the name is not
>>>>>   really needed, as the name itself is the differentiator.
>>>>>2) same quality leves in both options. Those are:
>>>>>   PRTC
>>>>>   ePRTC
>>>>>   eEEC
>>>>>   ePRC
>>>>>   And for thesee, using "o1/2" prefix would lead to have 2 enum value=
s
>>>>>   for exactly the same quality level.
>>>>>
>>>>
>>>>Those names overlap but corresponding SSM is different depending on
>>>>the network option, providing one of those without network option will
>>>>confuse users.
>>>
>>>The ssm code is different, but that is irrelevant in context of this
>>>UAPI. Clock quality levels are the same, that's what matters, isn't it?
>>>
>>
>>This is relevant to user if the clock provides both.
>>I.e., given clock meets requirements for both Option1:PRC and
>>Option2:PRS.
>>How would you provide both of those to the user?
>
>Currently, the attr is single value. So you imply that there is usecase
>to report multiple clock quality at a single time?
>

Yes, correct. The userspace would decide which one to use.

>Even with that. "PRC" and "PRS" names are enough to differenciate.
>option prefix is redundant.
>

I do not ask for option prefix in the enum names, but specify somehow
the option you do provide, and ability easily expand the uapi to provide
both at the same time.. Backend can wait for someone to actually
implement the option2, but we don't want to change uapi later, right?

>
>>
>>The patch implements only option1 but the attribute shall
>>be named adequately. So the user doesn't have to look for it
>>or guessing around.
>>After all it is not just DPLL_A_CLOCK_QUALITY_LEVEL.
>>It is either DPLL_A_CLOCK_QUALITY_LEVEL_OPTION1=3DX or a tuple:
>>DPLL_A_CLOCK_QUALITY_LEVEL=3DX + DPLL_A_CLOCK_QUALITY_OPTION=3D1.
>
>Why exactly do you need to expose "option"? What's the usecase?
>

The use case is to simply provide accurate information.
With proposed changes the user will not know if provided class of
ePRC is option 1 or 2.

>
>>mlx code in 2/2 indicates this is option 1.
>>Why uapi shall be silent about it?
>
>Why is that needed? Also, uapi should provide some sort of abstraction.
>"option1/2" is very ITU/SyncE specific. The idea is to be able to reuse
>"quality-level" attr for non-synce usecases.
>

Well, actually great point, makes most sense to me.
Then the design shall be some kind of list of tuples?

Like:
--dump get-device
{
  'clock-id': 4658613174691233804,
  'id':1,
  'type':eec,
  ...

  'clock_spec':
  [
    {
      "type": itu-option1,
      "quality-level": eprc
    },
    {
      "type": itu-option2,
      "quality-level": eprc
    },
    ...
  ]
  ...
}

With assumption that for now only one "type" of itu-option1, but with
ability to easily expand the uapi.

The "quality-level" is already defined, and seems fine to me.

Does it make sense?

Thank you!
Arkadiusz

>
>>
>>Thank you!
>>Arkadiusz
>>
>>>
>>>>
>>>>For me one enum list for clock types/quality sounds good.
>>>>
>>>>>But, talking about prefixes, perhaps I can put "ITU" as a prefix to
>>>>>indicate
>>>>>this is ITU standartized clock quality leaving option for some other c=
lock
>>>>>quality namespace to appear?
>>>>>
>>>>>[..]
>>>>
>>>>Sure, also makes sense.
>>>>
>>>>But I still believe the attribute name shall also contain the info that
>>>>it conveys an option1 clock type. As the device can meet both
>>>>specifications
>>>>at once, we need to make sure user knows that.
>>>
>>>As I described, I don't see any reason why. Just adds unnecessary
>>>redundancy to uapi.
>>>
>>>
>>>>
>>>>Thank you!
>>>>Arkadiusz

