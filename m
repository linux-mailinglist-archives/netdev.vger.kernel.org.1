Return-Path: <netdev+bounces-186056-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 41E44A9CF13
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 19:02:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 55DE91B60A52
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 17:02:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C80A11DE3C1;
	Fri, 25 Apr 2025 17:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PBQIypod"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05BB71DDC1E
	for <netdev@vger.kernel.org>; Fri, 25 Apr 2025 17:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745600531; cv=fail; b=BOc7MXeEUj9ydEnZBwS2ipfhP+ST2gSe2zVR69GfHPlBTItWcJQdwHrNcVXq2KBWS0lfgmHBG/hnY7fQSBkEdoYPWrZXEooSEULCeTPLxlX3W5uD70pwTMzne+0Jg8oylSQmb+bIu22hju93ec0U99Slhub8W22UB9my40dvsf4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745600531; c=relaxed/simple;
	bh=bBNjH3lPsfuHnUyXTNvyZRKkh4Pb0UiCQKU9UeEKgTo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=CK7xWi0Koynql2fmkP7S2mX4Fyg7mIRc8CsBm+CdVKhYyyaXuAK2eUI124xoC+ozrfojOcVWQKoPCg6DimB7MekdooynnwBHqb9CuaXdRExmflBlOSN1fik7kpq+c+ZFoteg/7WP9tlvKKjihb+A1YDokLu6kaivzzsWbLeUV60=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PBQIypod; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745600530; x=1777136530;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=bBNjH3lPsfuHnUyXTNvyZRKkh4Pb0UiCQKU9UeEKgTo=;
  b=PBQIypodxELgtObseKJHUlDc+xfHAFSmAmBCgfau6Iqjez9/4cachGVi
   BGCpGQK9zZ+D8wbcWPwX1YyWPuYZWHQSg60JtN8yq5XQvOqcQNuGT8py/
   WQJvDg5Zo4vOEYvmN11w3opynHxOUfijxlVVobQ+miiP5aMeSJU+hBkq9
   N5wnO3muKMJz6wOsj/m8gjIYA7V7Pd2vAyeIlFyGtNjDcpthiYnPnGPIa
   uY25VNGh9ouNtsM49jppQo2szeo5V2VoWQmI1S9TJj3r5YeiuSCB+ZXMi
   KkMLpev4O7ddpFuy6dXUn1lc5t34mtVD9YiN6KCl4ozjUhNah4Ug+jrJs
   g==;
X-CSE-ConnectionGUID: 5FqaltjcS/WP7l2GhTck7A==
X-CSE-MsgGUID: 5/62RetORhCBoq0a0bLYjA==
X-IronPort-AV: E=McAfee;i="6700,10204,11414"; a="64688265"
X-IronPort-AV: E=Sophos;i="6.15,238,1739865600"; 
   d="scan'208";a="64688265"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2025 10:02:09 -0700
X-CSE-ConnectionGUID: XDJccsVxQhu587jQfPA5uQ==
X-CSE-MsgGUID: F27d/NPGSx2JwpYRD+6Kbg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,238,1739865600"; 
   d="scan'208";a="133886243"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2025 10:02:09 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Fri, 25 Apr 2025 10:02:08 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Fri, 25 Apr 2025 10:02:08 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.175)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 25 Apr 2025 10:02:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n3s+HOr2tcHezIz6MnHuzhpe99D2fnQ/c8GIo9T6Y88mFV1gTVZ43+FadgTQ4UW5xv/KL2mVZUKpkrPIw0eo62kMzoIdYrcazSaW5hT0h+ZNxTRBa0Oa6nymvD6mfqzriDn0rskSPO5upYk21hKJOlsis/zaPswF6D9EOibesca/GP4AxjHWQ7MO2WGXnrrrvvuC5l3Z8ZEbwRD3yhXg81NM73PdUrodD1eoAWeQynFKf11CdpRd6eMLxkR5LmCq2WJ9JRSyatjANI0lJoWucOreoMIG6OWtZQj4oobbHPOMvkM7XoeUkzdxAApd05zEM0R1nORuWYfUTO0wAapMFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bBNjH3lPsfuHnUyXTNvyZRKkh4Pb0UiCQKU9UeEKgTo=;
 b=GKcWKBN0hMu0/nvXe8BVcVx+lkJ8bSSrPAD8/CYlwGZCVVTz0w02r4uw18d6AqHdqi9Oa7r1T4HsV5eP/fPAbWtbKRe5IGl6mYdg/rWra4CQjiH2Yn5I/YtuY3HhnT5OQrXgLCCdRFDC7tBuzcP0lV3rnw3hbp7IP7BnVacW0QS3zmxcayNz3iHdujWT2KnUoIAoPjQDO6EloPyvzwenrbOsB4XdA05FpJxrCo0yNIa3yIivLZ5+pXh6GbxPWO1Q8p+l4iEk3et4rf+CPo0303/h6LvnWh38DWf/50BDROnvrjet5k7kq3cuMOYrDeKUnr4lD/TR4d/7VDNI6FFC6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6297.namprd11.prod.outlook.com (2603:10b6:a03:458::8)
 by DM3PR11MB8713.namprd11.prod.outlook.com (2603:10b6:0:45::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.27; Fri, 25 Apr
 2025 17:02:05 +0000
Received: from SJ1PR11MB6297.namprd11.prod.outlook.com
 ([fe80::dc50:edbf:3882:abf7]) by SJ1PR11MB6297.namprd11.prod.outlook.com
 ([fe80::dc50:edbf:3882:abf7%3]) with mapi id 15.20.8678.025; Fri, 25 Apr 2025
 17:02:05 +0000
From: "Salin, Samuel" <samuel.salin@intel.com>
To: "Olech, Milena" <milena.olech@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, "Olech, Milena" <milena.olech@intel.com>,
	"Lobakin, Aleksander" <aleksander.lobakin@intel.com>, "Keller, Jacob E"
	<jacob.e.keller@intel.com>, "Tantilov, Emil S" <emil.s.tantilov@intel.com>,
	"Linga, Pavan Kumar" <pavan.kumar.linga@intel.com>
Subject: RE: [Intel-wired-lan] [PATCH v12 iwl-next 09/11] idpf: add Tx
 timestamp capabilities negotiation
Thread-Topic: [Intel-wired-lan] [PATCH v12 iwl-next 09/11] idpf: add Tx
 timestamp capabilities negotiation
Thread-Index: AQHbrsvj4KHqlvVinUqKRYRloGrW7rO0qQBA
Date: Fri, 25 Apr 2025 17:02:05 +0000
Message-ID: <SJ1PR11MB629705CEE42B6C4AA68905B49B842@SJ1PR11MB6297.namprd11.prod.outlook.com>
References: <20250416122142.86176-2-milena.olech@intel.com>
 <20250416122142.86176-24-milena.olech@intel.com>
In-Reply-To: <20250416122142.86176-24-milena.olech@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6297:EE_|DM3PR11MB8713:EE_
x-ms-office365-filtering-correlation-id: 24fa4e36-65fb-4f69-cf01-08dd841ae7f0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018|7053199007;
x-microsoft-antispam-message-info: =?us-ascii?Q?tmipvvF/EdSUud0kT4MHPGVwbN+erntS1wIN5GGujII2w7LOam991PCzZqkD?=
 =?us-ascii?Q?TezZp0Dy62xxBeq9C6tcXcGokTj65IXb7njfKNX68i/zhJBgmU6w4dKgvGZN?=
 =?us-ascii?Q?tYUUo2CKI2lQb62YFlIzzlqZ+h3fRk31YvXHS6cbjCTfUyv5xCMsYn1cEQfR?=
 =?us-ascii?Q?430WTaTiCd67VvpFC0N2HafPYg5uDf0UQgQY4k8P5QaHxCCQeUHmp7fQ97x9?=
 =?us-ascii?Q?u3ER3YlJNPaUIKaQXqyGU6Y3Ze46JDSKTU/nhCBBwgosbIsUAxal3lSLGo8O?=
 =?us-ascii?Q?HnZWqNHH4G8Hp87YxzneCi5PA6b9ukm39LTGW0xfdEYVAnxWP13e5v1IzRcE?=
 =?us-ascii?Q?xyWZTFGg5aOfbdWCUi+hb5t0JW0jVgLsBgB03teIrNUNGpk6ywIPoUAEOz2V?=
 =?us-ascii?Q?hX8cyCqyVLt98oIE07+xBq3jThx2yoy/DUL5itDZxWNz7FLJkAjh4dxEwyaZ?=
 =?us-ascii?Q?bdvrPHP1h/J2/7XCN7DgyZDydkadgCyNp5MnqJQexA70659MmEslKqsEn2FC?=
 =?us-ascii?Q?FOvnCSiXo/hjnf3GkzRFTFX0cZuJNNxIRM5Y2eb5LvyTDYTX5F1O6Cetj58N?=
 =?us-ascii?Q?craD2LW0BWehXakeSFzFTkMeO+5MeiwQxcc6WFQhQ41ci/iJ3qsGt3zxO0+f?=
 =?us-ascii?Q?r0II8bOPgf9ph9LxnSA4ktQpMMOPdXZ2Zt4cRjyKPcLnquC2La7WYnUcWC17?=
 =?us-ascii?Q?ZHPe4StsfReACloHsJUtim4CF9wYWd8W2xhmdQltCX2tTHewffykziyfVi8U?=
 =?us-ascii?Q?wT7pwIumdsM7Df/2vUXy3Gn/E656hkSM5afZKhJSPg+DJXi2nnrDScnj92Yc?=
 =?us-ascii?Q?RjvTkOZhi2RLTiQBwdg6eYZvhEs6ycx62LPEKKah153QUMJV8GT5d4Z96kvV?=
 =?us-ascii?Q?+wN4MR2u92zEmeyd5QelNcGRwyAkfJk0TykcPKNL3YCo5vYxwMnDRRJH0NYo?=
 =?us-ascii?Q?jZBzkKq8CX+1ZEKV70weKLUprpdLqFHxpMRl1gc+wrDE8AR3vbGW6ogM32Pv?=
 =?us-ascii?Q?zDkQ3hqdpYvQTHbdupToqsH5AAVO2QxSooo/yMH6yE47qPaxloqEx8r2sD2d?=
 =?us-ascii?Q?lE02FGoqXMkCdpy0p4Wytv20mbXoPBEn/EhLCKyiIAbzc/Iy8tL8zRlQJLPO?=
 =?us-ascii?Q?sRplibZ++Hldhjn9prdlcXXP0CH7SV+KiCwffAO8AOkujZmMHqNtEr2zfETx?=
 =?us-ascii?Q?Fwwe1OngeM2xtYJ08DPvFjGhcIaT43BK9YcR9YLXYm3L+Fok27vcgXK+VLLI?=
 =?us-ascii?Q?y+Hu5qphAeZsQ+AAE+vV/Ws9f6RSPxGDeKPt0gqzgy9dGifojzdyGbFchwCt?=
 =?us-ascii?Q?BRvmV1hAiUNPuVGAepZfdaSeX+cx8qPCy0eicKGUZCPoP1P0DaSRG701t2Mh?=
 =?us-ascii?Q?WwRMwwU8Li5yaIw8Hv23Dr3t2k0UzbBXwBd1iyq0rJSIy/pUZ7tmQZNQpL7I?=
 =?us-ascii?Q?6PgBk15RV4CtOq75dDkVbFjy+wDSRAJPvlKXI/Rw0IwNoPlkrtcgIQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6297.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018)(7053199007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?BxyRXgyi0MJymajfmqBWh3HrYD1ZQYOsLxYbyrwEB/s3OCLUdHnqC65S2ntL?=
 =?us-ascii?Q?8WSM7PVGOnOLc+oJHgcv02GHJXfBl25kwnn2kFVClXjcSqBLaPbuaMqFRoTd?=
 =?us-ascii?Q?h+zhnOkKRE38D9xNaMLx2zzK+kuNllu/KofpwogKQwEtQemQoSteroDFZ2E9?=
 =?us-ascii?Q?OjBF66YixG/I01vOixSX8zdW9dSJUMQ2rZlPWGRbNt/TUcUOJZEcvvnwHZN3?=
 =?us-ascii?Q?q7GZYltUEPF3Jz9pfZs2MxNl2MFIcfZXJ3wHUDbQSyEOXB2+7HzR2NQ2eOu8?=
 =?us-ascii?Q?Q5QwPOjKiISuOeQon2G4aKhmWFjXU2+seYW4zvNXpDBbTAyA4Ya4BvjemBOJ?=
 =?us-ascii?Q?cJYPE5zb0UDJEG8PiYC7xhcB+WaJKzrbxYXZB5F6OtWzwLgsk/TM+fzfeygV?=
 =?us-ascii?Q?hr1W5Y+OXfKPSEE+5fZSGnldw9UqoFVrUWFCPKdQznK9ltwLDmFJEvElM/9c?=
 =?us-ascii?Q?8loAdqUS3m0oeo867e3Er6xALagdb8MZ6hJc9r1Ye8POw66ko58BtPJhd+u6?=
 =?us-ascii?Q?+tf5PEGj/cnuLMGFQ3YbfbuXqcpma2ZQiSO+/wj338QlAnL+7AKztGU5cqSr?=
 =?us-ascii?Q?8Ye/hsCQ2pdiIBfqdLN+PXmdveQdl0luV5I3E0t+NigEtFmiJ5qn1BSMv7gF?=
 =?us-ascii?Q?g5Ia4dKUXU83AYuSWutB/psTFN0TQRWfGsWVDbLUz8b2aZbSNulx1YRHlVWf?=
 =?us-ascii?Q?z11JsikA87n+LMOdSzkkTWFWln0P3UIXumkYsJhJgYjenVQ66iAwE1PEn4Xm?=
 =?us-ascii?Q?fmCPaSP+errxZxY0poyMc0CMUlH7JeAI3IDHcXiR+lS+e0dzT7HxpjjN58bC?=
 =?us-ascii?Q?ByXheqsWUu/SMG83TItweABnGP/vddko/c+J1s5yONetCcGFZaVo9I8sJTVB?=
 =?us-ascii?Q?R8SYfSyj55b7xvBd32IJ+fCAxofV8bz8uFZcvsOtPmCf1BaBlc+rd6LeVPcX?=
 =?us-ascii?Q?82D6pO9LgGhiseURIUXW6NKeg9dF2YLu2Gg1I+q8xOcQ5K5NUYH8kyzlU3GI?=
 =?us-ascii?Q?vXzCcanNamhwmb82HVJdC8kJ2dVq6YtOzQ7Sp7a2hRpYq1l60SyRsoSZn/gm?=
 =?us-ascii?Q?joK7ko0IokWZ3cFX95HJ0K7QWYBqr4V5vNu4T4+GHH+mxSbDUkWSz3DuwDno?=
 =?us-ascii?Q?305Cxbzxl1Dea5eTkA+qLPbZ9rWy2ZHxStyXbzYUq7dmp7zCsROQuHRGaeJf?=
 =?us-ascii?Q?Zvjnf1KrH8fgsj8tJHi0dD0Le9f7EigONg2RxVchwNPKH8Xak6y1WEjLdMSz?=
 =?us-ascii?Q?uJZaaYjDVve01hU21AJbiTdqfMH7nWTKWmQsPA0SYkhS+OOgubO7L7BvF8Ez?=
 =?us-ascii?Q?iapg54izihplIkLGUeSMOmwNqzic5eQ1CPpMAXsJLJh6wz40dLYC3jy30nrP?=
 =?us-ascii?Q?qBnqq5+6dScgb/TKcHR212xK/fYHCs4rqfHUTEmSgGatDa6C/znNN1wwl9Qf?=
 =?us-ascii?Q?IcxSFMmo+3G4mwR8PI9VQ6NCG4DZV5ECSz1OeLcbmbTqxKPvdATb/UkaQM3K?=
 =?us-ascii?Q?qQTMO7aXqoIebIhr4tr4OoMM9/rWHQAoMLdB7jA1eRPJJs+mO5QBGh5Q+gC7?=
 =?us-ascii?Q?cTnQuaNBMRdCU9c5xwHF67K+Saz7pOCBZZ4xOR/b?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6297.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24fa4e36-65fb-4f69-cf01-08dd841ae7f0
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Apr 2025 17:02:05.1406
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +jasXomixblArGbCZzH/GwtNuIXORlQJ3m7RyrwHa/+l+wxVsuB/JrT9O+hupyjeCSumsG6xAWCFCG7su6h4tA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR11MB8713
X-OriginatorOrg: intel.com



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Milena Olech
> Sent: Wednesday, April 16, 2025 5:19 AM
> To: intel-wired-lan@lists.osuosl.org
> Cc: netdev@vger.kernel.org; Nguyen, Anthony L
> <anthony.l.nguyen@intel.com>; Kitszel, Przemyslaw
> <przemyslaw.kitszel@intel.com>; Olech, Milena <milena.olech@intel.com>;
> Lobakin, Aleksander <aleksander.lobakin@intel.com>; Keller, Jacob E
> <jacob.e.keller@intel.com>; Tantilov, Emil S <emil.s.tantilov@intel.com>;=
 Linga,
> Pavan Kumar <pavan.kumar.linga@intel.com>
> Subject: [Intel-wired-lan] [PATCH v12 iwl-next 09/11] idpf: add Tx timest=
amp
> capabilities negotiation
>=20
> Tx timestamp capabilities are negotiated for the uplink Vport.
> Driver receives information about the number of available Tx timestamp
> latches, the size of Tx timestamp value and the set of indexes used for T=
x
> timestamping.
>=20
> Add function to get the Tx timestamp capabilities and parse the uplink vp=
ort
> flag.
>=20
> Reviewed-by: Alexander Lobakin <aleksander.lobakin@intel.com>
> Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
> Co-developed-by: Emil Tantilov <emil.s.tantilov@intel.com>
> Signed-off-by: Emil Tantilov <emil.s.tantilov@intel.com>
> Co-developed-by: Pavan Kumar Linga <pavan.kumar.linga@intel.com>
> Signed-off-by: Pavan Kumar Linga <pavan.kumar.linga@intel.com>
> Signed-off-by: Milena Olech <milena.olech@intel.com>
> ---
> 2.43.5

Tested-by: Samuel Salin <Samuel.salin@intel.com>


