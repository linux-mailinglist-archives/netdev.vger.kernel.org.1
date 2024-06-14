Return-Path: <netdev+bounces-103442-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A969D90809B
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 03:26:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41DB1285556
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 01:26:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7B421822C3;
	Fri, 14 Jun 2024 01:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PL+MwR+p"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0251D3211
	for <netdev@vger.kernel.org>; Fri, 14 Jun 2024 01:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718328399; cv=fail; b=LsK3wtuTjeFH+kiYq9y+k2fIxuiIF231/+czrtN/noMsc7oU3abyGnbZ4+LaGLMNvtpZX2x3G23qzuUtY2echyTyDbky1AYSw8ft7DO3rfS1z1OGQYT8wGqVaxIcgJpwDF0OlTsZU1y7+NY3+MLfxNWp2scdk5A7lhVuiy5+iug=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718328399; c=relaxed/simple;
	bh=z7nDCRLcPpTpKagDLAaihU/+zdAZS3Y3lUkGHVGA6LE=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ZKy7pCsbkWseTrXl2DGPiz9EIlUjM5Ar/YZV0YLFnIf5Yc9xk7xeZlQpuLBszTzVOibDxLj8eo8uQQqAueBE309psg0Oo896LBnsK0jDhrwLd72HAxii79D+yCqJILI+aOVsAgZNOo7+vmTfiwYgLsipq+AjT6Mh5vwcAV9U1/w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PL+MwR+p; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718328398; x=1749864398;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=z7nDCRLcPpTpKagDLAaihU/+zdAZS3Y3lUkGHVGA6LE=;
  b=PL+MwR+pSr/eUG0m3kH5fJBCi8wETp0Q8OFKl2LYdHEyYSASw6QQXY20
   TFfTNWFrmXT+lT9GLkPwGqoxaeAy79osm3sLB9k0TvKQygYw2yFk+fOVX
   FiiNraz4apf4/cLnm6knSZeCJv3K36YHoyu97DAj4sue/kwYN+FPbFaX4
   1XFzcux5bH+z6p+Jhx6uZoPDq2xuJrk0U0ICViilU9BuYLjC+eH8RMSc0
   +kDzKs6ofg+DoGpLxJqeVCmh+xi5tC6nowtZBwkUavCxJAwpQYPHplFrN
   9bUmZTl0juVQwGlN8pPXuEftH2kiFYiwjbPykieiTgMc3EYhEQhw5l+N6
   A==;
X-CSE-ConnectionGUID: SwbTaaiJS42LNs9CS8gJvA==
X-CSE-MsgGUID: AunBgm8/QuyJ3V/mxf7Q4g==
X-IronPort-AV: E=McAfee;i="6700,10204,11102"; a="15323531"
X-IronPort-AV: E=Sophos;i="6.08,236,1712646000"; 
   d="scan'208";a="15323531"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2024 18:26:37 -0700
X-CSE-ConnectionGUID: rvImu8qMTCSkDThWSmLTVQ==
X-CSE-MsgGUID: ApCTJfRHRFSSLoPAbmwiSQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,236,1712646000"; 
   d="scan'208";a="40836942"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Jun 2024 18:26:37 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 13 Jun 2024 18:26:37 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 13 Jun 2024 18:26:36 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 13 Jun 2024 18:26:36 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.41) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 13 Jun 2024 18:26:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y0oiVKse9sMfoy4/4I8s0yxP77pY7arCIDgGQd+jlayFQLmlcfi6NVeR3HDTHpKo6p2zq8+aqUvmUX3fIHdKa7/wy1TJEanQGOnickd44Xf9BHYAuOYraqII5Z/EQn1CVny36Y42PN5+X95bcboNkfRCk/APXyTbhh8i55V4Rp632IQ1ECbDPUrl1wIC5PSolEOYiAxInNyZVlvwReyokKfWhaGJ7/jDIcEG1YR4AnP13BOXlgtHVm2FG0C+T6gLbByP/BATqrupWb1eLqgNr1OWK9x8lSmizcBrU7pwDIHAMqIsNVcykjbGatAJ+C8FpQeZYVgrMnuVReCUAh67WQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BePJi+1MHvFK8YiIdiv+6nU6kp4VaQTUq+MBBvDwRME=;
 b=gXzAUmKmAGpJrcAatWNp59DHK0BidVuTvpBmrYjLd4c0dtoM4gGxFqmsnF1DLSVg3iYLa2U1YJO9+Miuvm2RIX9JgZJZ/K6V5cUyE5SLJrvY/XfDhXC2jpr3xHmlHwE1JpcHrATBj2OBYqzzTbq8IVJZdrJVU2TV8qfKc5w2NXVnU2G+lWkUfdNXBR7C9o+aPIJSTY0+txbVhjiSQ6YQZq446KF3aB3G1tAiUc5NmqnKCd7J6o3A/69FLfgm9zTsWjpKCQ/34RvC9KV52R1AZq//x3PXlc2z12CRXWAwDFneHoXED1fog2D3y+tuQdHvXJ58VuHGdBhJ5SAP+HYtKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
 by SA2PR11MB5193.namprd11.prod.outlook.com (2603:10b6:806:fa::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.24; Fri, 14 Jun
 2024 01:26:35 +0000
Received: from MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6]) by MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6%6]) with mapi id 15.20.7677.019; Fri, 14 Jun 2024
 01:26:35 +0000
Message-ID: <4c5be7f3-7ab4-411a-a285-9ddeedcaf6b3@intel.com>
Date: Fri, 14 Jun 2024 03:26:29 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 4/8] ionic: add work item for missed-doorbell
 check
To: "Nelson, Shannon" <shannon.nelson@amd.com>, Jakub Kicinski
	<kuba@kernel.org>
CC: <netdev@vger.kernel.org>, <davem@davemloft.net>, <edumazet@google.com>,
	<pabeni@redhat.com>, <brett.creeley@amd.com>, <drivers@pensando.io>
References: <20240610230706.34883-1-shannon.nelson@amd.com>
 <20240610230706.34883-5-shannon.nelson@amd.com>
 <20240612181900.4d9d18d0@kernel.org>
 <1533a043-56ef-4846-b61f-837312a90b3e@amd.com>
Content-Language: en-US
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
In-Reply-To: <1533a043-56ef-4846-b61f-837312a90b3e@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MI0P293CA0013.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:44::18) To MN6PR11MB8102.namprd11.prod.outlook.com
 (2603:10b6:208:46d::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8102:EE_|SA2PR11MB5193:EE_
X-MS-Office365-Filtering-Correlation-Id: fc7200ba-1b55-4a6e-1b4a-08dc8c11079a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230035|1800799019|366011|376009;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ejRmelZJdHlIbWJGV0YzbXJUamFkcUdzSkc2aWRKVnhtTWdZeUF2WDVxazVy?=
 =?utf-8?B?aTY3V3VwbXJWbGxoUFFSZDUwamJuWEQzM0EzcEFoRy9qNUI1eXE5Sk1FMHJR?=
 =?utf-8?B?ZXM2aHVYTkkyL0oySndpTnpLUm9Xa2x5OHR0ZjBJZFNMTWtrYisyOEMwbUpY?=
 =?utf-8?B?TmQwd2ZCaXpzclFRM0szbmN5Y1AxVzErWFg1aFo2bEhDcWxnT1FIT3BwS0lm?=
 =?utf-8?B?S3d1TURrdkhkOTZiaC9oTmZWaGdXUUFwcnhQbytWNE52OXBTVWpYbURwK2di?=
 =?utf-8?B?VGR5a0ZERGM5L0sxNkJuWUNUV2RMZmtINEZTRzdQT0Zmb3JlWHUrRDVFcjR6?=
 =?utf-8?B?cUQvWVZFYlpyZ001YUFOcmtzcThJT2x1SDE0eUVEK01aNHpJWWsveEZNRGM3?=
 =?utf-8?B?Q3VOZ1BJWm1jc2Z4dHhoTXhhV0JGN2lwZXZoYStoZkJlaUlHbHVBQmxJcktZ?=
 =?utf-8?B?aFpuT0dnd1ZkRFpqOTgzUWdVaEtBNCtIQ3hCOTMwMHZnQ3RSMFBteTducTIr?=
 =?utf-8?B?WjhadUJrTmdPM1RYRHhSbVFydGhtdVI4Vmc0V21WbDVhaUxaMng3UUNtV1Ev?=
 =?utf-8?B?dnNZZkl4NVlWRDJTZlFSVnBKTnJrU3dFcndreWZTQ2xZRTBITDFKZW5UczE4?=
 =?utf-8?B?RlMrMnZJYXJKQXF5TDhpd1MyWkdBZEswZzF0L2dwZ3ZNK05meUlYbW0vZzNi?=
 =?utf-8?B?VnRkakJGTFRkZHZLaHlnaUZ5aFJnU0g2bDhDalhmdnFkVWZNcVdIRno4M2lm?=
 =?utf-8?B?VWtscCtzWXpxUitMTFBtQWw3M3QyRmhmME95cVRZWUpMcXozZjY0bmdGTm10?=
 =?utf-8?B?dEVSUHR5ZVFSNWhCRGxhRUN1R1RZSVl0cTU1RDg1ZjBQVzZWVFpoR3NVcTFY?=
 =?utf-8?B?OE9CZksvdlcybEQrZlFHeDM2V0RqMHdFQVJ5eWlBZHNlME1xRVNrQTZwWnhQ?=
 =?utf-8?B?MWU1enJPYWh1NTBrTXFodDA5R3J1cFdKUVVpZnk5aHl5RGJoQ0ZyZG9kRmZE?=
 =?utf-8?B?YW9RczY1a2dkWGNGVjBQbDhSS29nQkg5RE4vRXJyc0lLem9mcmUwWnNraS8w?=
 =?utf-8?B?bGtBZ3R0T1VsQUk3WngxdnQvYVVQNHgwWHF2VmQraldCdFJIVllncmZwcnpE?=
 =?utf-8?B?ZjNKNzVSS3pVbys4RWZ1SkJpN1FaQ0NycjhEUVhSdndRUjR0MksyU0JZTFJB?=
 =?utf-8?B?TFIwcnpqNkZiUkQyZDQwZGdrbkxKUlFvck5Pc2gwTkk0UmlZY2JId2FOTDg1?=
 =?utf-8?B?Mk10NUEwaTN2Z2l0Q1RKdW5obUxJaHhzeVppdStaWWVhQWU1VXA1ZWFKTTF1?=
 =?utf-8?B?WXNlUFErVE8xWW1Td0tBd0JTSzBzNUJzYlgwK3g1czZRZHhEN0lsNWtDdW1C?=
 =?utf-8?B?L2NxWFBndGlaSXJkZEhsVldlZnpxZWhlRUQ2Sk5UZFZLY25jelppay9YWkgz?=
 =?utf-8?B?WjdRdlIyYlh1YzlZM3FQR1lydmRiY0ZqQzI1Q1dmYjN3MlljMmhhSUQ2aUdx?=
 =?utf-8?B?Wk90V2p5Q2FXNTJWcTBpT1Z4aCsvRlFtZXhFUjZsQ3VOMTJyeUoyMmlzNFU2?=
 =?utf-8?B?dFpnL0tKUk8zK2FySEhhMkhRczdrYnc2TDJ6K3VDTk9TS1h1czVyNjhBaDFx?=
 =?utf-8?B?L2h2eGJ1VHUxb1gxR1d4NU1PeXVXZVJlY0tSUTRRd1RmTVhUNUIzeFRiM2V3?=
 =?utf-8?B?VFFzSlpuc3dzTEpCZThZcXVWcTJ4dU9kdTFzeDlzTnIyTWNMSXFJeUUvR0pJ?=
 =?utf-8?Q?lpPzDotuUN3yXFgmNuGPiNSANhVidtW75WqRkFZ?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230035)(1800799019)(366011)(376009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V2kwb3JMaEgyaXFhUWR3bTJJRmNJdGNJR1YrK1c2SGhzR0w3NU8zWGlpN1di?=
 =?utf-8?B?NHlUMmszOGR2bldiWFpUM3FkYkNCSWVPM0FaMWJGQlM2UVRkN3ZOVnJRdHRi?=
 =?utf-8?B?dWNCVFVsMlNiaVRNRHhzMWYvUmpoaFl1YkRjWVRpYmdoY0RNVUdMUzNwT213?=
 =?utf-8?B?WVJRZlRrU0NCYmJzSkIrMUJncko4QTNhZ2RLTk1OMFA0Y2J2Y3lWbFVYVVRz?=
 =?utf-8?B?U2pmMDdLUE16bXo3aUhnR0JpNUdaV3Fkai9FR210cTJ4TkoxOXBxeUszYjdk?=
 =?utf-8?B?RDlvZmlkMzU0NjZtOFZYRngrTnhvbktyYjB3WEtCZkk5OVJ5azBveXhBQWtK?=
 =?utf-8?B?TXk4Q1E0SkJ5c1hoSmhDcjhHNHV1bm9zWTZxWmRGQk9kdjJSSGhXSVkrVjVv?=
 =?utf-8?B?d3ZuUTZCZUtYL1d0MGh4Zm5vMmxwc25aZVI3RTM0RVZnTVRwUkZGTm44UllC?=
 =?utf-8?B?Zlg2MStuZ05wSXBZaUYwZXp2WmJQSmpRNGJlWWRIaG80Z0R3MmFncUFvWThM?=
 =?utf-8?B?aGROdWdZTVkvT2c3eUN5Rm4zc2p2Y0xWa2h4MWt3emdIai83Z25rYjg3QXJ1?=
 =?utf-8?B?TFk0TTFJTlZlOCtmbUljcWpPYVNWcG42Z3ZkR2d5eERVQVVlWFRVZlNiOEJj?=
 =?utf-8?B?QW1KWjA3YkdwMjZvaHVrOGhVS3pISTJXa1pKUUtLMy9lWEQ3bEhhNmRDSDJR?=
 =?utf-8?B?OGUzbW5JYjFzYlpOcTNiL2lzRzhtajQwSko2VkN2SHpIajVMUVJub3BOZ2JG?=
 =?utf-8?B?Zy9Na2N3UGtGR3hKcHZ6TXhWTlZQM3ZWOW9iajZvTkR1cDJjays5WmlpQW1Y?=
 =?utf-8?B?SmswR1hDTXZqa3QyS0FGbVpkc2czR0dQWSsvRXJkNm5SbmQ1U1NRNFJueXZV?=
 =?utf-8?B?cXlGTGZmYVNnK1JUOEwyMEtWc1U4ZDdBRUxYUjVIOWw4dmphWXpkNFRLSWlC?=
 =?utf-8?B?ZzdlVU51SUxQdnBoUndxZ2xHRFcvb2JTVjVUMlNIQUREME9LT3RqMC9pVGl5?=
 =?utf-8?B?VGRLUVgyaGlhR2wvaWRZVlYxc0FUejFTKzBDdk1tVHo3dVVrQy9wNUFqSzFh?=
 =?utf-8?B?MmFwUjJlUitPNW8xOWdUUDJQRDU0Nzl0M09Cby9UNklsOEpjL3kxOUtqcFhn?=
 =?utf-8?B?SEd6TW9xYzV1bFozQktkMC84QnpVKzF5L1p3blBLd05MYTNDSUV2UU9GS09v?=
 =?utf-8?B?emJxOFBybHcxdjNjRTByY0w4NHI5Q0FqaExRd09mVmZEalRqb2RvY2xlbzlC?=
 =?utf-8?B?ZWhTVS9Yakd3NDZzenJYMWpFR003a2YrNHg0dG4zRnNLSC8zRDltNlhZTmUx?=
 =?utf-8?B?cUloSHBpeGtvRWZBRHJNcFFRcTRTZFFoNVBCcW5MbUJERDhCU3J2M2RHd1Fy?=
 =?utf-8?B?RysxV3hRb3JaZUh3aGN3cVgwSmxKYXlMT0NTaFNHRHVQaEMwRVZERzNBV2Z6?=
 =?utf-8?B?YWVWMTBaeFBDY2Fid3A0ODZsV3k1MWlKRVhyb0JEZ3diYlZtMWQxWEIzNUhD?=
 =?utf-8?B?RGc3MG1rQmhQekMyQ0Mzb2M1VW8zK0RWN3BWN2t0MVRsU2I4V3RXRWZJZzdV?=
 =?utf-8?B?WVJDNEFFdjRKdTFIbldSVDVtSnpkWCtZdjEvNXNnNmFLWitxVVJaRUxNbzBG?=
 =?utf-8?B?aCtWZWMrYWE4N0NlbUxnOU5aVSthRHgzMUJsTHN6YXN2dVBkTFJGa0xIclRY?=
 =?utf-8?B?ZkV0WVFkb01LdXlmTm8rVHlpUDJvWnZrTEUvQ3lxVExHVXJSZm4yUU1yU0Vp?=
 =?utf-8?B?d3d3cHJ3ZVljQjNCN3dwanJ5a3VzVjZGc1gwQ3dIbnNkL0V1bFhOY1NKZkVh?=
 =?utf-8?B?eE00VHJRRVZlVWl4cko4dGtHekFvbFExTVoxVUlXTS94Wm5tbms3R254a25L?=
 =?utf-8?B?cUQyM2YyeGJqSzZpQ0pOK2dBTWtzaWp3cG1oYWpYZ3BqT2VDNjQ1MWloMTFx?=
 =?utf-8?B?Vk9yOWZSM1o5U3BuZTBEVmJrSFpTNTNkMmVvM3doaGdwVElDTGNpdjlJaDR1?=
 =?utf-8?B?T0FJVFN6bFJldDVweDAvWXRYNzkvK1FBSVd6bVMyU1RCanJUUzVvc3RwQnZp?=
 =?utf-8?B?QWZ6SXhpU3IzL0tnVDNXc0drUms5UHE4RWRPSm1MWUpEbnVJZUI4cWpZeFhD?=
 =?utf-8?B?YnhZUkFBM3dWMlhialNYeU0xZm9yeThIMWl5OEZGOG1wc2RBYlp6TUdjVjBF?=
 =?utf-8?Q?mLllCv5EOcpec2w8g22+djM=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: fc7200ba-1b55-4a6e-1b4a-08dc8c11079a
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2024 01:26:35.0494
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SgxnIGxK81+cJfQMHtyrh960DnXLFO2tGTeuGBtr0DOhw5E6tPU3BOKDoPEptN82fUoiLcjeyKBMkXBi1+kDexaxXvB04mUBObPc9dd21Go=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5193
X-OriginatorOrg: intel.com

On 6/13/24 22:38, Nelson, Shannon wrote:
> 
> 
> On 6/12/2024 6:19 PM, Jakub Kicinski wrote:
>> Caution: This message originated from an External Source. Use proper 
>> caution when opening attachments, clicking links, or responding.
>>
>>
>> On Mon, 10 Jun 2024 16:07:02 -0700 Shannon Nelson wrote:
>>> +static void ionic_napi_schedule_do_softirq(struct napi_struct *napi)
>>> +{
>>> +     if (napi_schedule_prep(napi)) {
>>> +             local_bh_disable();
>>> +             __napi_schedule(napi);
>>> +             local_bh_enable();
>>
>> No need to open code napi_schedule()
>>
>>          local_bh_disable();
>>          napi_schedule(napi);
>>          local_bh_enable();
>>
>> is a fairly well-established pattern
> 
> Sure, we can do that.
> 
>>
>>> +     }
>>> +}
>>
>>> +static void ionic_doorbell_check_dwork(struct work_struct *work)
>>> +{
>>> +     struct ionic *ionic = container_of(work, struct ionic,
>>> +                                        doorbell_check_dwork.work);
>>> +     struct ionic_lif *lif = ionic->lif;
>>> +
>>> +     if (test_bit(IONIC_LIF_F_FW_STOPPING, lif->state) ||
>>> +         test_bit(IONIC_LIF_F_FW_RESET, lif->state))
>>> +             return;
>>> +
>>> +     mutex_lock(&lif->queue_lock);
>>
>> This will deadlock under very inopportune circumstances, no?
>>
>> The best way of implementing periodic checks using a workqueue is to
>> only cancel it sync from the .remove callback, before you free the
>> netdev. Otherwise cancel it non-sync or don't cancel at all, and once
>> it takes the lock double check the device is still actually running.
> 
> Hmmm... we'll dig a little more on this.
> 
> Thanks,
> sln

We had a very similar error (with stopping a VF, IIRC); it's easiest to
repro on RT kernels


