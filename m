Return-Path: <netdev+bounces-150408-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 97E7A9EA269
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 00:06:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 47A281882534
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 23:06:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A670219E804;
	Mon,  9 Dec 2024 23:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dBhgn/DT"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9D5D19D092
	for <netdev@vger.kernel.org>; Mon,  9 Dec 2024 23:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733785560; cv=fail; b=dCKjnia3acys+QlZiI3oep0+74JRh4ZfS9eW02PtY1HSF9z5n+5g4QhgT0Zef4H+vQcKz9Xg5qc2/KSbXXEr1RG8JVsac8tLXLjPsTIp1zxYbiAsrdp1/O9jPN5yJChOUXoWmM9r3kaO0LuC4JNdmi2dMC+KH9YInlgVJj0C5lM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733785560; c=relaxed/simple;
	bh=J+RpT2DsN7cPh0FFha5OuSIhVRVaxsTk/q7gWLWtwIA=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Ap6VHdic1S86UvA2kXOgX8yx9fYGCvaSg+affci6/yMdmox2vHhV1KLaYutm4GnSb5R5MigRS691jGBIuMfXX+JwLII3JzoVmBHtdoS6jgeksy8AV9Vso8K7oCUU1oe4CFQIsvd69yhTDD4vW9VVi/UUE6TMNGbUhdj5J3rOT3c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dBhgn/DT; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733785559; x=1765321559;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=J+RpT2DsN7cPh0FFha5OuSIhVRVaxsTk/q7gWLWtwIA=;
  b=dBhgn/DTNYAETfBjsc3k4mmV/KNFirC1th1bQK4QKMXIUvoyOVEMmUW4
   3I0apjHNk9UKc5t5SwF+FCq4HPIh33ln0sw8LSS5iYZCzTY4jKpqhfEUH
   9SQ8sD/kPBb20lXBHQzkbyIyWxhVAmi2JLxHNYzDR+hvEttJKh+Xvb6AU
   wztxIURfNEADAgmVwCuiIsTjB6JLWEb0f3mWA7FA1LdjnCA9+kRmcCsP3
   123OVyx+UxWznuAEIdpPNukfDNbd76PTyQ4MQrbz2dUU7c9I+ayNjJIoP
   1071/EcmlRrO+5XcUuGHIAotuh6r9mRpoNII6lbe5hA8WbYewX/EoyvvV
   A==;
X-CSE-ConnectionGUID: CIHJEX5rSrGc59+tmuMSFQ==
X-CSE-MsgGUID: EYtCUYd4SQmQmXMK0hfc7A==
X-IronPort-AV: E=McAfee;i="6700,10204,11281"; a="56588089"
X-IronPort-AV: E=Sophos;i="6.12,220,1728975600"; 
   d="scan'208";a="56588089"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2024 15:05:58 -0800
X-CSE-ConnectionGUID: V2yrV/mNTjyRRi8sfHrsmg==
X-CSE-MsgGUID: qrJDbooWSLyyDMmELLFkGw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,220,1728975600"; 
   d="scan'208";a="95083602"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Dec 2024 15:05:58 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 9 Dec 2024 15:05:57 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 9 Dec 2024 15:05:57 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 9 Dec 2024 15:05:57 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XLQrFwkOCTm/5JUjpCtsez0sa25/pR4HQalhMPmEk/DeYxVKL0VIMYC8QBDrtlzpwVdWWNq2oY900gF/xICTM/ykRh5+DBiKLM46QMaVJsHchwFPJ4PIqOQ9eqfPFeHFDP8aUf28rJ0tidWak8dxX6ir26b2TdKVXTMrPnAgJFJ+Ds/Bi+FtUUsHoa2HwxR8QzDhJdFd7UvEn5p+gne6D4HbPTWmrLqCqEYHa9lBo0MtGFlqcPP2+5qzRPN+6x9DpCyEveoevlOcO8GAS6Luo+Wa+O/1SYflct2YmAqcgi56f9JQw7QZzii/QdEBeFSMJmfb3rHhe2tNO0Hd4O1QbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xZGnjXUP5JNGtkOcovxPipmRGMOsI2lZ9nN45jxaicw=;
 b=CAmNtzNHtxa+NdSu8JJBBFL0QYubh0vJGaG4RqYeNMnefsYCEs6fMkCcvB6lv6x/zrLhmNQLDqlHnPfxsAPxAJ1pANdh2UHGV8sakd1uqCJcA2t8XRAOOpIySZ+rER/vP+FoGJm4xHPYpnVBcsqyHYJ0xyUzlzvwk1pmNzR7tUUAZvbZ/7lOSA6rORA766P/8OTElD8D38C4oKo8JQGm5ibqxD1ssVldWfsyPv1X8gz+O4gjEEz3V3Ef6TEhcHOqX+ZirRsFgaLhYEaghqO96LtPh5J+E8QcBqZGGn/ciKplbkVWTme30Q6G0CcHnyAY6mE5nbAA84clAWW8KrYAhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by CYYPR11MB8331.namprd11.prod.outlook.com (2603:10b6:930:bd::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.17; Mon, 9 Dec
 2024 23:05:55 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%4]) with mapi id 15.20.8230.016; Mon, 9 Dec 2024
 23:05:55 +0000
Message-ID: <89f34386-1d18-423f-a105-228eb3d9c345@intel.com>
Date: Mon, 9 Dec 2024 15:05:54 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v9 03/10] lib: packing: add pack_fields() and
 unpack_fields()
To: Jakub Kicinski <kuba@kernel.org>, Vladimir Oltean
	<vladimir.oltean@nxp.com>
CC: Vladimir Oltean <vladimir.oltean@nxp.com>, Andrew Morton
	<akpm@linux-foundation.org>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
	<pabeni@redhat.com>, Tony Nguyen <anthony.l.nguyen@intel.com>, "Przemek
 Kitszel" <przemyslaw.kitszel@intel.com>, Masahiro Yamada
	<masahiroy@kernel.org>, netdev <netdev@vger.kernel.org>
References: <20241204-packing-pack-fields-and-ice-implementation-v9-0-81c8f2bd7323@intel.com>
 <20241204-packing-pack-fields-and-ice-implementation-v9-3-81c8f2bd7323@intel.com>
 <20241209141838.5470c4a4@kernel.org>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20241209141838.5470c4a4@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0246.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::11) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|CYYPR11MB8331:EE_
X-MS-Office365-Filtering-Correlation-Id: e5b2bef0-2db6-45c2-7c15-08dd18a60939
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aUdrUzZnM0xmOGk0b2dkazJxUHNrVGx3STJiTHF1WGdwcU1qcUIvZWgvd3NN?=
 =?utf-8?B?dnF2Umc2ejlidGlWWStnZG1OeGQrK0ZjZDFYcy9FM2FrenAzZlgxMW5pSUoy?=
 =?utf-8?B?bjBFS2JJaS9QQnVJNVp5ZitOb2Y4TzdOMUQvRzVCVHcySzJrS1VYdld4UWRh?=
 =?utf-8?B?U1ZFc1B5d3NxWVFVTVVCKy9OTW95ZWdNSk5oT2dOL1EwRkkyWC9aYSt1VTQ0?=
 =?utf-8?B?Q2dCeDZoSm1LdVoybGNsN0RJL2dzSWJVc0tNc1RGWWRFZ00zSGNnR1hqMG5a?=
 =?utf-8?B?UFRwdDNDalc2QVltN3dxSzI4ejRmME1kYU4zU25xSmszbkRMZUMrQTJrcjUy?=
 =?utf-8?B?ZjlzUVNJbmpwTEZ0dGpGQWdWbWJzZCt0amtkcnpKSkd5Zmc0Y2V1QWVmeHIz?=
 =?utf-8?B?YUUzSFIrdGJucE91VVM3SDdIU1g4OXN2TUY2TmczWitpd1oyU0NJRTErTW4y?=
 =?utf-8?B?MERxZlhGWEs5QlJvbC8rSVFrKzZaeHMvS2lyVjF4RTBXQ0d1azgzT21Ybm1n?=
 =?utf-8?B?clBON2JzUGRvc2lnYWpJRE5sUGRNMmx1aHMzeDZCd3ZrSlRKd1VoR29vM3Qr?=
 =?utf-8?B?dkNzRUM2dFF4emJzWk5kUHdOMytYZk9nMVd3Mmg2eWJ1S3draGh3RXVZZ05B?=
 =?utf-8?B?b1hkUEYyZFNVaFJvUlJUQ2NmVXVOTVhKOUhSZTRXUHA3d3dPWjIyeHdTZ3Yy?=
 =?utf-8?B?OWNsNlZZdU1XSi9iMXBLS09BSEtQSVRmWEJMN1JwODhmY0xQZWh5UDJLMkRH?=
 =?utf-8?B?WDNPYXd4MkFtdXc4ejg0TFJSbStUODVIbnZsMUc1UFpDak15VkVNVVJoMmlX?=
 =?utf-8?B?ckp0UmhWQ1FmcmMrNXA3T29rbkFnMittMDM5QVRab1dFcTR5WDlFYWRqTEtl?=
 =?utf-8?B?N2dtcW9NNUFJalZreWJ0QUIvbEtLRUZPd2dQSFJnQnhNOU5ST1ZhaG1PNkdR?=
 =?utf-8?B?UGszU21Dc2hEZ2dzekdnMnhuUDd4aEEyN0RBODJFS1BOTjR3ZlY3MytYM2g1?=
 =?utf-8?B?VUp1ZjdrcE1rVWREVS8xd3ZTaEI2M0xNMTlkRlBGQXRQalpSb2pLZ1pzRWdt?=
 =?utf-8?B?RDcxc2lIRVcvcnFISUtCT3p6QzFMaHFPRThSeUt2UXJSSWd6aFVENGhZWkQw?=
 =?utf-8?B?WVh2MkpxSUhIRElMRi9RUzBNMExnR3IxdWdoZ1lZMi9JK09CV002WGZFa3Bk?=
 =?utf-8?B?bkEyKzhQZlJGcmtJTEdDbDdlTUhEU2lIckJuTG5UTnlVSVlHMzd1akpKNk9r?=
 =?utf-8?B?YWt6aE9yQUt0Y0NvdmxaQWtsQnNlWkFibE1VWE42S2p0WVovSC9OWXlBRXI2?=
 =?utf-8?B?RmtSL2FweUN6L2xSVzBEcHRXR2ZmVGRVSnBkcGxwcWE4amV5YWUvMVBKL1ZB?=
 =?utf-8?B?Z0xUS21ZaFcxQmJkeFZDN1cwaHd3bUpMQmNlZkN6K29hVGVudUdiWC8rbnRv?=
 =?utf-8?B?SG02U1VnbER0d2VVb2g2UHhCNklIN1MxMWlHR24wSWljS2ZYRzVDbUU1Zzl1?=
 =?utf-8?B?MC9NODYzZmNjdzdTYWhpajJmeVBxc0Npd2lqbjFMQ3dqTUk4aENsUHF3Wm0x?=
 =?utf-8?B?N3cwTWE1akdmNVdpMkZHMDlTUnMvbzYxVW53ajM0M2NLbHdVZEppZlNIdEkz?=
 =?utf-8?B?U3RJQjJHNWRDWHdTYWRCMnRTakx5Ym5Cb1U5ZmhzajZwM3U0Y0Y4bkp4bmtY?=
 =?utf-8?B?RnRFVkJod0xnbU1vRFdyMDhBRHVWWWMwR0h5SVNNZStiZmx2a3JUbW5HT3M1?=
 =?utf-8?B?WHRJN1RLU1RGU2pYK0E1UStSek9WSXJnT3hpdXpPU1l6ak1tZU5idVdnSzMv?=
 =?utf-8?B?TFNWWnJsR0VuOE1TOUx4QT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NUVqYkkzZXcxZjQ4ZjlWejdJSUY4a2V4bVhvdUlqZWttWkhXdDF3T2N6S2Mr?=
 =?utf-8?B?cmo3QUpQRXdJRTRyemU5ZzdOaTZ3ZHZhRGRjcGhaQlBwMGVDWUxOelVENnRE?=
 =?utf-8?B?ZVhYc2dKVXBRaGhIWHVFb3RoVmRLa1hHTnMvTVhybDdFQnBDcnc4Yk9mODgv?=
 =?utf-8?B?b3JzdkpHOXhTdlBkZTAxUTN6cVJiWGdaKzNjN1N5cWszWkxjREFKcDlHOE0x?=
 =?utf-8?B?SVhPVVJBV3N4VjFQN2hReVhITFptZnBuQkxwaGF3eFU0NVI3T3ZVQjhFdVc4?=
 =?utf-8?B?QnRDQ25WekNGREU0R3R2TmlTZEVac0lENTNXd09vbXBFaE11VXhSUGdieDFR?=
 =?utf-8?B?UFIyZitKNWNyRGo2aGNNbjNKa0IxMjRKSkNLeGtxUlBQdEk5Tk00a2ptVXQ2?=
 =?utf-8?B?cXpKVmQ4SHQ1US91bFh0NGoyZkp1K0dobDVnRm5zQ2ZBazZtblBVaXZEL0o1?=
 =?utf-8?B?Z2FNQUw1aUJtL1E0bEROSDF1eUdXVUJzQjBKaytPckRwR2dFZEZZWElWcmZn?=
 =?utf-8?B?eDhKTjFDaisyVmtLRFhrZjhKdysrWGVwb084R24wMUV2MXRGVTlJamFmZDBi?=
 =?utf-8?B?K2lyRHc2ek12c3phV0g4QVZPKzlxeUdITVdDVWsycStQR0NkS0d4YjJwWTR1?=
 =?utf-8?B?cGhmM0xveTRVWUp5NVY5OUYrVmQyZUkwNVJnNzFnWVpaZ0RqT3RNOGRZMkZv?=
 =?utf-8?B?eGd2T0V4Ly82Rkt3YkNJS3p1UXF5WVh6aUFndmFJYldoYUE1dytaWDdHZ1Uw?=
 =?utf-8?B?elQxdnpTa2V2NS93dkZabjBJdCtUb3VHOGtqZkZGZnFaUWdZY2xVd0NDMmds?=
 =?utf-8?B?ZzBhOXRwNXUvaWR4Zzk2Zm1Va1lmamIvSFNLY3lnL2VpbUJYalRlWGlJWHRB?=
 =?utf-8?B?ZlBqbjNSQlhNTlErWmNIT1VOalhYdTI4aksvdS9MbnFTWWZFVU5ldDdoMEJq?=
 =?utf-8?B?ci9hYy9kL0FNU1JwVzkwMjAyMjJnSFpmbVBQR0RBN3d2QWtZK2g1ZGFjOXJZ?=
 =?utf-8?B?Zk9iUnhuQXpxdlNGUzBTdTZqR3h5ZUhnTG5McjBMOE4zc05WSGJ5SDVqSU4x?=
 =?utf-8?B?RDE2OGREOWd0RFdjUmI1TEJvTXZvMVRKZmwyUXh3eVNsWm9Va1NQS3EyYXRE?=
 =?utf-8?B?T3NlclRveXVtMWd3VGJyUkNybE9aYzhLa2N5eG96S0ZNajNha1pzZjNwOGpu?=
 =?utf-8?B?L3V0cGI2Vk1YMi9xaFYvejRLQ0NjSHlFZDVlKzdPMXUvSTNzVnF3ODcyaWFt?=
 =?utf-8?B?VWNsSHlTenpJQkpRSUFUSTh3eWZjQ1dwTDZMdFVvMWdVY2lneXlHK2V0RVlT?=
 =?utf-8?B?TGVQMDlBcktlZFl5L1RDdHJ1SjYzNHJFanltbk9xK2pTTi9FYXRkTm1yV29N?=
 =?utf-8?B?YVkzRzNYb0tLVkxwSUZHUVRvRk5ZKzMzcWhvNk9oL285b1B0QXFFb1NiUGxL?=
 =?utf-8?B?NnVlYmt0ZVlOZmZhdEl5T21vQVZXT1EwbmVkbmVLVG1vUEpLTzBsSGRkSVNh?=
 =?utf-8?B?UjUvWEw1KzFXQ1JpemFNRUhhaHlFblAvTGRtRlAvOWY5TzhkTlE5UHhUU2RC?=
 =?utf-8?B?U205R0xuWW9NcU1JSGRGcm9WZmc0VTVmNVh3RTJWWVpFNjFNN1dyR1NMcXpW?=
 =?utf-8?B?VE9jNUY5T3kybG9xVmpOUW1jRzlEd3dJeEROMzc1dTJmNWNPbjZ0ODR0WVli?=
 =?utf-8?B?OVNIS0dzRllCeWtCR2lKdjVubXlrR25DR21vMXJlTkF0Vm16bHg1ZUROY1lm?=
 =?utf-8?B?VkRDaE5RNTBLUkF1MlRzMnllcDNuMFFIVWdjOGkvMHpzRnFZVml1NjdKcGlD?=
 =?utf-8?B?Qi9nZHdmNWU4U1VhVFZaTmplM0hhb0RodGFvYzV4Nmc2UXA3WHNpZ1ZaY3VT?=
 =?utf-8?B?V3Z6OXRzSUJac2FaVHVza3ZvRVNMOGNoQklwR0NHZkRhY2VtY0MzRUlIZ1Jo?=
 =?utf-8?B?SzU1cWJ0S25vYy96WXlWWGlxSEUvRWpQTVR3QXREN09QeENjTDZLQjZaWDZp?=
 =?utf-8?B?aE9nRStJcXhiN0F0QlVjRE5IU29iMW44ZHFDMlRNRWpHZnNsaTBmaGU0L2Ft?=
 =?utf-8?B?YlV3RFJlVXZQaDBMd2JSZlZHZ2lrbVdJeVJ4UUh4ZmtiTXlsRXZsb3ZwMmlI?=
 =?utf-8?B?YkJLNGV0eTBLSmZwTFQzZFlBaWdEOUZiZXp4RXdXNnE0TVp1TVdETElkcUEx?=
 =?utf-8?B?WHc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e5b2bef0-2db6-45c2-7c15-08dd18a60939
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2024 23:05:55.6267
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gBrYNAMpSbeVZW5KN/LHyca7Y7bw7UiYCb4n9LJNLSf36lfUGveldc/lMOYLqQQWov/DiNayzhtiQRgL2GpV6LPgyBvrX8OyRi1Y7Fg9poU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR11MB8331
X-OriginatorOrg: intel.com



On 12/9/2024 2:18 PM, Jakub Kicinski wrote:
> On Wed, 04 Dec 2024 17:22:49 -0800 Jacob Keller wrote:
>> +PHONY += scripts_gen_packed_field_checks
>> +scripts_gen_packed_field_checks: scripts_basic
>> +	$(Q)$(MAKE) $(build)=scripts scripts/gen_packed_field_checks
> 
> You need to add this binary to .gitignore, one more round :(
> The rest LGTM
> 

At least its an easy enough fix.

>> +/* Small packed field. Use with bit offsets < 256, buffers < 32B and
>> + * unpacked structures < 256B.
>> + */
>> +struct packed_field_s {
>> +	GEN_PACKED_FIELD_MEMBERS(u8);
>> +};
>> +
>> +/* Medium packed field. Use with bit offsets < 65536, buffers < 8KB and
>> + * unpacked structures < 64KB.
>> + */
>> +struct packed_field_m {
>> +	GEN_PACKED_FIELD_MEMBERS(u16);
>> +};
> 
> Random thought - would it be more intuitive to use the same size
> suffixes as readX() / writeX()? b = byte, w = u16, l = u32, q = 64? 
> If you're immediate reaction isn't "of course!" -- ignore me.

Its fine with me, but Vladimir was the one to change them from numbers
(packed_field_8 to packed_field_s and packed_field_16 to packed_field_m).

@Vladimir, thoughts on using the byte/word suffixes over "small/medium"?

I'll work on preparing v10 with the git ignore fix, but will wait a bit
before sending to get feedback here.

Thanks,
Jake

