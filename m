Return-Path: <netdev+bounces-188827-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8502CAAF089
	for <lists+netdev@lfdr.de>; Thu,  8 May 2025 03:15:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79D579C6834
	for <lists+netdev@lfdr.de>; Thu,  8 May 2025 01:14:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A26421553AA;
	Thu,  8 May 2025 01:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="B0tOLV1H"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6002F186E2E;
	Thu,  8 May 2025 01:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746666904; cv=fail; b=rwNPRIQH+GOccrivTYjJx8EZojVF79CMo8XWdicRTIPyQrYJyl8xAHg0qS00ldtvjkVWSl1NI/G+GUU/BPSoHiurMkT+2CuMGMdi+mdQ1Y4CFfex8BzhdlWU3gbyMxEfes4lcfWEbxiQhfbCL8sqvuDeqa1XOItx4hRfr7ZXVfA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746666904; c=relaxed/simple;
	bh=EFRdp7N4WpqX7ga/k7Y6/MYc7kCWIQ4zz4dz9btqFsU=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=HwtPxniiVeYfkmKhNpWigX3104gOIObmRJJU4P2xyFEHQWA4yPF9DUoXU7PTTftej+CrbpXskEWzLsM0i4OY1I5DMi0hSN/b3EnF1ImMcPv/SQR/UJOl/uXLOKrCRZ/peAGFsy5OjLEnN+NAQfqwCq3GpsJjYYw0ZnUp39LHWls=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=B0tOLV1H; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746666902; x=1778202902;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=EFRdp7N4WpqX7ga/k7Y6/MYc7kCWIQ4zz4dz9btqFsU=;
  b=B0tOLV1HOffchfEoRz/hmwkQf7ws8stGcnfET9UIMrqpwHjuLRfuYTqk
   Ur83eL2IQOYXQD8uXlk5/ewvig8v1JD4JPU4kkRypEP3+8fM8khWDWu+X
   f18ETXA3Ty0jgSTA50J065ytWeTCyBykRv/j8tUh8CyC1gDvNdMgO+g0k
   Hryi4sv1TnFXzM6Hi3mNHPPKsZNJcTvSo+mxKFoBesSev5usQ9O6JNtep
   C2o7qW8vSBg1Wb1wdcIZEA5Wowio8o+g2qT8uj5aThwwURFnNkNHuNjNd
   ZoBoUJpQV1/7ddR0m5zMl229Xga7LhryqXcBejF4+/BA7JPCcofQ0S9Dd
   A==;
X-CSE-ConnectionGUID: TyPpcsDHRQqZEtq0fLu9PQ==
X-CSE-MsgGUID: XJBleFhwQDKusPXjctCjHw==
X-IronPort-AV: E=McAfee;i="6700,10204,11426"; a="52237255"
X-IronPort-AV: E=Sophos;i="6.15,271,1739865600"; 
   d="scan'208";a="52237255"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2025 18:15:00 -0700
X-CSE-ConnectionGUID: wfx4CZn0TAaZpL9rJZArjg==
X-CSE-MsgGUID: E6Lh32qCQ9O0CjMnpQ1U/g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,271,1739865600"; 
   d="scan'208";a="140174465"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2025 18:14:55 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 7 May 2025 18:14:53 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 7 May 2025 18:14:53 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.45) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 7 May 2025 18:14:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ICKHl06X9lK721dyDnpf/qN7vy6mLLmuGCKkPsrDznFcQCH9QR0yVMHjacxMv8jRFmp3T9fRwj1HN4TaqV/ZKWUSIjJo5oOzj3dalKDmzv2n7b6Rj7BFkG9jAk34uiHyyM6MH6EiwQEYkSe9kcVXSB9JbhKIETlBXGGjBy8fpizG1gqnFHryivTtln/j8MnNJA7NMeV7xhOC9oENuf1OiOgTdMMRbV7iBUjwTuMxFBNyz9+4oCYiyecMcNAXuOjVwanC9I+KxhlIPqAjFAI+LUeb4ghdVls0SSyGyVG8Q4v05zsDQTrZEY53imWD0C5QLPrR6SX4sSPZQ0K0nDVrWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EfUaeA2Xs/ofcQEgY/+TreHaIqv2K2hWsDC7B958TzY=;
 b=Edg/Wr8JGVJRfKkU7dZR8tC3HUWXKmMGnXypSx9MYeat3GaqZyX0+slg6+SOKLYTyeGqWXr/mB/pEmLolQoOJGVWpM7Pfg43U3MFVrZcTA7z/rvQfBwU0t2m/jTuY8hsKW7jPJSLjEuAfe1dq1a78eBjSFZM/vN1tX5ZHbc3PssEsd4JL2nnxoNAngVM/GSJoFCK51RxYkUfBaMbsicmmP+pUi8j7wdXFqV0DTIOAl2uDN2cNRlOn+ybCNmJjS47rqP5ZDLoxF9sqToWtvHy52dUFgpUkumMgHfc6FrdxF4x7KhufiUX3qIwDlAVAKl8RP5arZ7+tLkWrS6eyfnkOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB8794.namprd11.prod.outlook.com (2603:10b6:806:46a::5)
 by PH8PR11MB7992.namprd11.prod.outlook.com (2603:10b6:510:25b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.26; Thu, 8 May
 2025 01:14:01 +0000
Received: from SA1PR11MB8794.namprd11.prod.outlook.com
 ([fe80::a3d4:9d67:2f5d:6720]) by SA1PR11MB8794.namprd11.prod.outlook.com
 ([fe80::a3d4:9d67:2f5d:6720%5]) with mapi id 15.20.8722.020; Thu, 8 May 2025
 01:14:01 +0000
Date: Wed, 7 May 2025 18:13:57 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: <alejandro.lucero-palau@amd.com>
CC: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>, Alejandro Lucero <alucerop@amd.com>, Jonathan Cameron
	<Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v14 11/22] cxl: define a driver interface for HPA free
 space enumeration
Message-ID: <aBwFVdyGIis5fncS@aschofie-mobl2.lan>
References: <20250417212926.1343268-1-alejandro.lucero-palau@amd.com>
 <20250417212926.1343268-12-alejandro.lucero-palau@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250417212926.1343268-12-alejandro.lucero-palau@amd.com>
X-ClientProxiedBy: MW4PR04CA0105.namprd04.prod.outlook.com
 (2603:10b6:303:83::20) To SA1PR11MB8794.namprd11.prod.outlook.com
 (2603:10b6:806:46a::5)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB8794:EE_|PH8PR11MB7992:EE_
X-MS-Office365-Filtering-Correlation-Id: 32c2e819-17aa-4897-d86b-08dd8dcd9de0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?DWAZukra+QtK4YWMk8M5beINA9CFwAT6/ubydVqCt+ZcmhzC0Vtvlhl9z3FF?=
 =?us-ascii?Q?RPM6txm+PmZoFQfbPrEFHQlMIKiTAgZ+EaSXExeRcK90ZX/MZW4qayEetXNr?=
 =?us-ascii?Q?NWxemIXs8gQ3fiHTyfeqjnK9HXjP+jcBk1RmOBzdXsZglpwY9ZVCeHA+FZvg?=
 =?us-ascii?Q?a6RW7LFzCzc0L+AonE0TgS7z6hAUqH+mwaUNmyWOf7+Z8BR4TCx+EAw6zA0I?=
 =?us-ascii?Q?lbpsZmJwpFv9PovflRlwTXCi0mVulsGoYBVZ9piDOQuHQmx/Y58SVVKCUAeS?=
 =?us-ascii?Q?FIXumKBmxZUH5tYtEu0lXH0vjmbUaKdO5l4ejZ1TyH3YEjycb39r4ByWaONe?=
 =?us-ascii?Q?Qh2+IOluCRyXGxhlDM5L7Nxn6WUDeFcc1CWAgq8OLB3BD2sKN6sES1Ep3N96?=
 =?us-ascii?Q?cml0Z8oVmHfQZyUXSi2gX9ehlptgzfuiNUqjSJm3w7YYAMKjeyNCd+b5eI8F?=
 =?us-ascii?Q?YVWwj9lRWM+UFbotNR5nMyRryA9UpikiMyd+KbJ+gy3IjElQtKRe8GhJjnVG?=
 =?us-ascii?Q?SYEu6vLEe7OquAppm4ZvRVtqH1sT7f8dTYPFIxwTKO9H9ooLl3WXj55VASFn?=
 =?us-ascii?Q?lYqxIwV9APUTidIhKuw487XDbP++15L7LV8LYx+OlDqa27WYeECkxwhE7bPM?=
 =?us-ascii?Q?6FO7msSy6XjP0UdhqdDqSZqPV/dfIlwfa2hiZNOUhfh9rn9CDWIjmICHw0Sm?=
 =?us-ascii?Q?ZfFRA/DDeq6Cm9XVeNse8M81Y3S0FVZE33VRVMI1kSkf1ka78BMzGYhm71Dl?=
 =?us-ascii?Q?TJpoCvepTmSRGU9sHeOf4CfhlRmyb7Fn0hBAZ+klQc2qZXa70FazVN0fS5RF?=
 =?us-ascii?Q?3Y9Mnun/K72jZbt8sZ2eHwlIuyfM4R42qjWjq+cX6HBCEuSsH6r5RgaXSeI5?=
 =?us-ascii?Q?FIJfS7v587LHLpnpkZB9Ea5OwhoxytPCqz78/sO/7J1ZLl0YYuC6G9rCSpf9?=
 =?us-ascii?Q?nZHG4HWrLMvpC5IT866vFZXTBZW318bODuq6bsec0xVSde9LEAR+ifmkG27r?=
 =?us-ascii?Q?eXk/vA8fQJbxxItHnsTBVAtcKzE/d3+aRVx6371WYpOhIOmTDyhdXNOz8qJq?=
 =?us-ascii?Q?69jLr5NIiOA353amOesIrs25I8XGQoePyIiP55oWrxT7xoq0EkdvVQgiIZc4?=
 =?us-ascii?Q?3RLvqjNAbqJL3Qdg0z8nb7WBa7rXhqOfFyYfZL7Bf3E13SYWaQtc4Nxv7p9Z?=
 =?us-ascii?Q?0LArxw7PZZpGUSizSGpvafU4Cg0VYasVeGBHlVJGzyLmF6T4xfj5T5qiT46+?=
 =?us-ascii?Q?r2jTWkE2e6nn7Rer6dejnOPdsPW4O0/W8YmwF0qYSwirox1tcnYN0eFheehQ?=
 =?us-ascii?Q?URKWaZwXSDhhr5aNOuJ2o+CzWye3YlmaRLYD9ABmLY/IiFwlfb5yYRFLcxdi?=
 =?us-ascii?Q?j+y0O4VX8azWgNJjjbzWBsEVtqevc8c32XVwr+dc6iQZhnlFdjSvJrsB0XJS?=
 =?us-ascii?Q?ALXK80rkpzs=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB8794.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PmixV1/yopm1/3KDvvcPxUlTE/PTuVrNgLmGGHqbRVwwdrmrBusST6i/8gL4?=
 =?us-ascii?Q?N8Z0PETSvdHZ/4ws3m5u+0dRrLwnT6Kj1qhDyTpPxtfPd1ROoxLzLX6B6NJG?=
 =?us-ascii?Q?xkxdHj2fAgeYpVMRIcbCQS0M/kX3N/4cs9OEh0c5xUaMS8whqrruMC8rAMJ5?=
 =?us-ascii?Q?juvSY+boWk0YflyLoH5J50WKpTpJ9vJoGukNvR6gwiOCO/FJTuLQb36HIXV5?=
 =?us-ascii?Q?JAd8Q7bOmwU390tE83iab7+X/4Echm9xsflIQ69mp/gZCn3tRJuhnXoewtxJ?=
 =?us-ascii?Q?PBQ/jizfC0sedNxI2uiOR/0JfCodHVstdcC5+MRcEcxPZYVfq4X4GiJRjCpq?=
 =?us-ascii?Q?ZP4QUtVD6VQnDmYH7iMFuou7wp9lC6DOuQKZ/7fOoBfrCy90LGH/QGlRI2C1?=
 =?us-ascii?Q?sBXZFSJW2O4KwofK3fpLpx5N6+TixVLe4ZZEVE9SJaFNbggrpElVanpz999y?=
 =?us-ascii?Q?ArcefmeoTB6KWZ73iazZNzl2t5jXjnuffCBu6eZu53+3Q7JzvrXfHwyhk7NL?=
 =?us-ascii?Q?mN3N/595Y0oDk80LiKWUWOPNUuwqc/yj5AKaZO0MGxTr8zdZik/SfJ7/5S7O?=
 =?us-ascii?Q?3nODp7noZ7UJyf7ci/RJmYT5/w08flRPh5cCRzDLH4R3EAnqEgMJ0G8cJqn5?=
 =?us-ascii?Q?eCxVyS6V/rhLrUiRRcYNqIcxdwOQLLixG9KM1tEz41QayruZ1mevHerhfQeq?=
 =?us-ascii?Q?3KWQLCbLSUtZELl7bOO+OGVmvP6P/yH3x4z0Td0EC6dlf5/2iIcZDOLOUq3u?=
 =?us-ascii?Q?6e3Cl8Wg297eqQMcHvwgy9UHGhKN8ZKT/IyH80xxVC9tQXmBtMluQexR8YSd?=
 =?us-ascii?Q?wDBhOuIjDs+9Fh9OS8gxmZs9K4TIuIOgUbZh5J9aeZkTHuGpnTttE5NOzu7c?=
 =?us-ascii?Q?wF8X+IGWkXbdz/z5WgLhaIIn+l3MIgLkIbciXCYAX5GhcdHYdNpKX4u6SRJe?=
 =?us-ascii?Q?DOhK3sW2vXg0VZrfQ+ThXJYwZyiFTfp6NBy7w7JapxXb3b5w3LwgaT6sAEEK?=
 =?us-ascii?Q?vFLfTgjY+NgwriPXv5bryR1H7OZXUvnNiKTsFhW7dwDJYId2/tRbVUPWIAmg?=
 =?us-ascii?Q?/7C9W1Duj4SjJRqFxwQ7qpAyJV4qVsBtVN2SBHoY9kovUt8Tfv80MtC3r8fF?=
 =?us-ascii?Q?TP/oc5jOjQcQdpYllT1MqHu8eMqYlXmTHNO7j0r6ZJejt3T/GdUffuotPC70?=
 =?us-ascii?Q?YjCodthZ4AU9uY1+Eupjsp+Q74Yjp8Q7yUXdhgSx3iO6fHqSg2cvtmhjIUbn?=
 =?us-ascii?Q?DE9Dk5bkGtSkewfiKPVY1AgvMcxCYTMYuVAIRyqarCkbsXmHpPeeCdLxnXOo?=
 =?us-ascii?Q?OJ7kp6Y7mKxy9h7fdx7QfD6ZTQdu261h12mk5FMRVFbqYbWD3bs4cKjPcHQE?=
 =?us-ascii?Q?e87N5lUzxNlzYfC1o2aZXPfQMfpOeh+kmuYtEzOEM61T5+MHr54QJ27xt5pB?=
 =?us-ascii?Q?W0W3bZHSs1mCEshVJJKihL1sUS7D5imroDkBWIiVS9YJxsAsxF2qRVKYaLli?=
 =?us-ascii?Q?O65ebVDra7XVyelUUWOcERbzXZ7MdTNK0oLVxAi0L6CRoBOh6hJRevN0omzQ?=
 =?us-ascii?Q?QA8B7tPsBBfRvB5R3l8HTi36WmFcRGHRSwCsf2WtnEgpLhhHmts0E6Y9F71Z?=
 =?us-ascii?Q?rA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 32c2e819-17aa-4897-d86b-08dd8dcd9de0
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB8794.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2025 01:14:01.5360
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: baEwW3Vg2FnU9HGSkblX/e1hwImMkMmbd6+8tqB+p+OzfNcgARXjyyOy1VdbsrqTVGOWRk3IP00dlr2wPw4wTcFoy8PhKKJrrvvBMxWJReA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB7992
X-OriginatorOrg: intel.com

On Thu, Apr 17, 2025 at 10:29:14PM +0100, alejandro.lucero-palau@amd.com wrote:
> From: Alejandro Lucero <alucerop@amd.com>
> 
> CXL region creation involves allocating capacity from device DPA
> (device-physical-address space) and assigning it to decode a given HPA
> (host-physical-address space). Before determining how much DPA to
> allocate the amount of available HPA must be determined. Also, not all
> HPA is created equal, some specifically targets RAM, some target PMEM,
> some is prepared for device-memory flows like HDM-D and HDM-DB, and some
> is host-only (HDM-H).
> 
> Wrap all of those concerns into an API that retrieves a root decoder
> (platform CXL window) that fits the specified constraints and the
> capacity available for a new region.
> 
> Add a complementary function for releasing the reference to such root
> decoder.

This commit message lacks a why.

It would be useful to state whether or not it makes any functional
changes to the existing cxl driver hpa handling. Seems not.


> 
> Based on https://lore.kernel.org/linux-cxl/168592159290.1948938.13522227102445462976.stgit@dwillia2-xfh.jf.intel.com/
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  drivers/cxl/core/region.c | 164 ++++++++++++++++++++++++++++++++++++++
>  drivers/cxl/cxl.h         |   3 +
>  include/cxl/cxl.h         |  11 +++
>  3 files changed, 178 insertions(+)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 80caaf14d08a..0a9eab4f8e2e 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -695,6 +695,170 @@ static int free_hpa(struct cxl_region *cxlr)
>  	return 0;
>  }
>  
> +struct cxlrd_max_context {
> +	struct device * const *host_bridges;
> +	int interleave_ways;
> +	unsigned long flags;
> +	resource_size_t max_hpa;
> +	struct cxl_root_decoder *cxlrd;
> +};
> +
> +static int find_max_hpa(struct device *dev, void *data)
> +{
> +	struct cxlrd_max_context *ctx = data;
> +	struct cxl_switch_decoder *cxlsd;
> +	struct cxl_root_decoder *cxlrd;
> +	struct resource *res, *prev;
> +	struct cxl_decoder *cxld;
> +	resource_size_t max;
> +	int found = 0;
> +
> +	if (!is_root_decoder(dev))
> +		return 0;
> +
> +	cxlrd = to_cxl_root_decoder(dev);
> +	cxlsd = &cxlrd->cxlsd;
> +	cxld = &cxlsd->cxld;
> +
> +	/*
> +	 * None flags are declared as bitmaps but for the sake of better code
> +	 * used here as such, restricting the bitmap size to those bits used by
> +	 * any Type2 device driver requester.
> +	 */
> +	if (!bitmap_subset(&ctx->flags, &cxld->flags, CXL_DECODER_F_MAX)) {
> +		dev_dbg(dev, "flags not matching: %08lx vs %08lx\n",
> +			cxld->flags, ctx->flags);
> +		return 0;
> +	}
> +
> +	for (int i = 0; i < ctx->interleave_ways; i++) {
> +		for (int j = 0; j < ctx->interleave_ways; j++) {
> +			if (ctx->host_bridges[i] == cxlsd->target[j]->dport_dev) {
> +				found++;
> +				break;
> +			}
> +		}
> +	}
> +
> +	if (found != ctx->interleave_ways) {
> +		dev_dbg(dev, "Not enough host bridges found(%d) for interleave ways requested (%d)\n",
> +			found, ctx->interleave_ways);
> +		return 0;
> +	}
> +
> +	/*
> +	 * Walk the root decoder resource range relying on cxl_region_rwsem to
> +	 * preclude sibling arrival/departure and find the largest free space
> +	 * gap.
> +	 */
> +	lockdep_assert_held_read(&cxl_region_rwsem);
> +	res = cxlrd->res->child;
> +
> +	/* With no resource child the whole parent resource is available */
> +	if (!res)
> +		max = resource_size(cxlrd->res);
> +	else
> +		max = 0;
> +
> +	for (prev = NULL; res; prev = res, res = res->sibling) {
> +		struct resource *next = res->sibling;
> +		resource_size_t free = 0;
> +
> +		/*
> +		 * Sanity check for preventing arithmetic problems below as a
> +		 * resource with size 0 could imply using the end field below
> +		 * when set to unsigned zero - 1 or all f in hex.
> +		 */
> +		if (prev && !resource_size(prev))
> +			continue;
> +
> +		if (!prev && res->start > cxlrd->res->start) {
> +			free = res->start - cxlrd->res->start;
> +			max = max(free, max);
> +		}
> +		if (prev && res->start > prev->end + 1) {
> +			free = res->start - prev->end + 1;
> +			max = max(free, max);
> +		}
> +		if (next && res->end + 1 < next->start) {
> +			free = next->start - res->end + 1;
> +			max = max(free, max);
> +		}
> +		if (!next && res->end + 1 < cxlrd->res->end + 1) {
> +			free = cxlrd->res->end + 1 - res->end + 1;
> +			max = max(free, max);
> +		}
> +	}
> +
> +	dev_dbg(CXLRD_DEV(cxlrd), "found %pa bytes of free space\n", &max);
> +	if (max > ctx->max_hpa) {
> +		if (ctx->cxlrd)
> +			put_device(CXLRD_DEV(ctx->cxlrd));
> +		get_device(CXLRD_DEV(cxlrd));
> +		ctx->cxlrd = cxlrd;
> +		ctx->max_hpa = max;
> +	}
> +	return 0;
> +}
> +
> +/**
> + * cxl_get_hpa_freespace - find a root decoder with free capacity per constraints
> + * @cxlmd: the CXL memory device with an endpoint that is mapped by the returned
> + *	    decoder
> + * @interleave_ways: number of entries in @host_bridges
> + * @flags: CXL_DECODER_F flags for selecting RAM vs PMEM, and Type2 device
> + * @max_avail_contig: output parameter of max contiguous bytes available in the
> + *		      returned decoder
> + *
> + * The return tuple of a 'struct cxl_root_decoder' and 'bytes available given
> + * in (@max_avail_contig))' is a point in time snapshot. If by the time the
> + * caller goes to use this root decoder's capacity the capacity is reduced then
> + * caller needs to loop and retry.
> + *
> + * The returned root decoder has an elevated reference count that needs to be
> + * put with cxl_put_root_decoder(cxlrd).
> + */
> +struct cxl_root_decoder *cxl_get_hpa_freespace(struct cxl_memdev *cxlmd,
> +					       int interleave_ways,
> +					       unsigned long flags,
> +					       resource_size_t *max_avail_contig)
> +{
> +	struct cxl_port *endpoint = cxlmd->endpoint;
> +	struct cxlrd_max_context ctx = {
> +		.host_bridges = &endpoint->host_bridge,
> +		.flags = flags,
> +	};
> +	struct cxl_port *root_port;
> +	struct cxl_root *root __free(put_cxl_root) = find_cxl_root(endpoint);
> +
> +	if (!is_cxl_endpoint(endpoint)) {
> +		dev_dbg(&endpoint->dev, "hpa requestor is not an endpoint\n");
> +		return ERR_PTR(-EINVAL);
> +	}
> +
> +	if (!root) {
> +		dev_dbg(&endpoint->dev, "endpoint can not be related to a root port\n");
> +		return ERR_PTR(-ENXIO);
> +	}
> +
> +	root_port = &root->port;
> +	scoped_guard(rwsem_read, &cxl_region_rwsem)
> +		device_for_each_child(&root_port->dev, &ctx, find_max_hpa);
> +
> +	if (!ctx.cxlrd)
> +		return ERR_PTR(-ENOMEM);
> +
> +	*max_avail_contig = ctx.max_hpa;
> +	return ctx.cxlrd;
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_get_hpa_freespace, "CXL");
> +
> +void cxl_put_root_decoder(struct cxl_root_decoder *cxlrd)
> +{
> +	put_device(CXLRD_DEV(cxlrd));
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_put_root_decoder, "CXL");
> +
>  static ssize_t size_store(struct device *dev, struct device_attribute *attr,
>  			  const char *buf, size_t len)
>  {
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 4523864eebd2..c35620c24c8f 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -672,6 +672,9 @@ struct cxl_root_decoder *to_cxl_root_decoder(struct device *dev);
>  struct cxl_switch_decoder *to_cxl_switch_decoder(struct device *dev);
>  struct cxl_endpoint_decoder *to_cxl_endpoint_decoder(struct device *dev);
>  bool is_root_decoder(struct device *dev);
> +
> +#define CXLRD_DEV(cxlrd) (&(cxlrd)->cxlsd.cxld.dev)
> +
>  bool is_switch_decoder(struct device *dev);
>  bool is_endpoint_decoder(struct device *dev);
>  struct cxl_root_decoder *cxl_root_decoder_alloc(struct cxl_port *port,
> diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
> index 9c0f097ca6be..e9ae7eff2393 100644
> --- a/include/cxl/cxl.h
> +++ b/include/cxl/cxl.h
> @@ -26,6 +26,11 @@ enum cxl_devtype {
>  
>  struct device;
>  
> +#define CXL_DECODER_F_RAM   BIT(0)
> +#define CXL_DECODER_F_PMEM  BIT(1)
> +#define CXL_DECODER_F_TYPE2 BIT(2)
> +#define CXL_DECODER_F_MAX 3
> +
>  /*
>   * Capabilities as defined for:
>   *
> @@ -250,4 +255,10 @@ void cxl_mem_dpa_init(struct cxl_dpa_info *info, u64 volatile_bytes,
>  int cxl_dpa_setup(struct cxl_dev_state *cxlds, const struct cxl_dpa_info *info);
>  struct cxl_memdev *devm_cxl_add_memdev(struct device *host,
>  				       struct cxl_dev_state *cxlmds);
> +struct cxl_port;
> +struct cxl_root_decoder *cxl_get_hpa_freespace(struct cxl_memdev *cxlmd,
> +					       int interleave_ways,
> +					       unsigned long flags,
> +					       resource_size_t *max);
> +void cxl_put_root_decoder(struct cxl_root_decoder *cxlrd);
>  #endif /* __CXL_CXL_H__ */
> -- 
> 2.34.1
> 
> 

