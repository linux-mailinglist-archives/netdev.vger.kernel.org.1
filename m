Return-Path: <netdev+bounces-295381-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id LvS5G1G/IWoCNAEAu9opvQ
	(envelope-from <netdev+bounces-295381-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 20:09:21 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B7C8564283C
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 20:09:20 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=SHOUYfvK;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295381-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-295381-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5CDD330125F9
	for <lists+netdev@lfdr.de>; Thu,  4 Jun 2026 18:08:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C0B93B4EBF;
	Thu,  4 Jun 2026 18:08:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB98E2D594F;
	Thu,  4 Jun 2026 18:08:19 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780596502; cv=fail; b=gI/gYm7/SwiJKXToQZpcuuCw2GIxELHK/CuQW7xetoRwnkQzJbRtmXsby0cRLsJutPQ5/Rc0R1vT1yYiaOmHOj9KWsQKDjQI6gpQodi738Og2beXAhoj6OHROZYZ4Tr0SZmIFNQFNW8W7/MillCNrQv4Rp/AFFoPCtySpxHTbRQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780596502; c=relaxed/simple;
	bh=egSbhK7UmUGsOfOtt0NQgGk8Y8XPDWlS/mAZdwryfMg=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=tzbEd9jQZVBYld4itM05uoI9ZALUJF1GlYJXvDG9iYB7jpTtW4Hq8m7W5zgyyOd4sUT6j5nzPNzjQIWRvrS4BdIz+ccvpNj4Ild02eCa4C+2WWrmqrCyAmsp+0kTo01h7eAGbH/74h0giQZuFeTqB22ghru7JTM/Sa5T++a1qJ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SHOUYfvK; arc=fail smtp.client-ip=198.175.65.17
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780596499; x=1812132499;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=egSbhK7UmUGsOfOtt0NQgGk8Y8XPDWlS/mAZdwryfMg=;
  b=SHOUYfvKnQRBdv4QdR1RvFc6qouBU/Tok33ep6FwrFfL6PFUE6fcmbeQ
   /Co88yhiPVnHs4rGfT7dvSdZ1AiXPQOzujKpAUmGYskZjW16gjVK+9dt+
   Xvu6wk7pC2LvdwMeHfdrMtn4rzIYxxXh2MtPWeI2w5gdOaxMz5+91UEsm
   0UUoiL5EUSwMjwoErjh4IvMkPqsjutm4iyCiAMr+7eKJU/lam9DROjmmM
   G9clYvHYFeECUfYDKroT1LdL8zu2J+duBz7iK7jpuYQ4zsw3j5bT+IS64
   GUkrOjZouCoK22yWBA7oRc7AEmvDs0Sq9W+bTSBM0OrUIXhqADVWXN1Vb
   A==;
X-CSE-ConnectionGUID: BnCkphkoTN2VyQfrWEp+4Q==
X-CSE-MsgGUID: U1YoBJj3QgSzJZsxbKu1FQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11807"; a="81429272"
X-IronPort-AV: E=Sophos;i="6.24,187,1774335600"; 
   d="scan'208";a="81429272"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2026 11:08:19 -0700
X-CSE-ConnectionGUID: eSgr81ApS96nRGJpohpKVA==
X-CSE-MsgGUID: EvYs6uGtRfKA7WeuNMDleg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,187,1774335600"; 
   d="scan'208";a="268301899"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2026 11:08:19 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 4 Jun 2026 11:08:18 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 4 Jun 2026 11:08:18 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.68)
 by edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 4 Jun 2026 11:08:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tlKOpWVaoHyW+ve+CpiH4VQWLVcjhXbpfJtLjXPutrsmHrzg4cuHkjCN/8pIifEEaQLGWa4iPEl1Nd9lt7eAbNRM+P1797ac2G4R4MKbktkixbGz585Lz0dL2F0LWFr7nqqhisIk0E532LOlLBLYXzBzC0EXuNOeEMLhlv+umeI5aWZPu/zJaY0WQbb8f/J+Gk8Ao7tvdO67mmS5G2eEZ69KNcd1/tU85PU0Hdu85xsnADvtTrHiMwl0shu1giGv9mM6j8xhyhxexAagPI9R1Dog/tJLBLV+GDnOl165bjKV/QX9HFxFJ4jn278ahgfbxO+dvz6b2kdREagdv8VgzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UaCLrGv0VSd4HwiK4EH3A82tEY7j+pWFlNtoaruGgwk=;
 b=gWIXl+ayccUR7X/iExsQs2Csy6tl8ZAXPB7uG5TIo11yp//45fgckchIk75p8rBciaEy0vqyWVjXMbLAav1QrjK9i8ExwYzWgXBOhG6bJKJEPjh9VeAMVcquqknAL/OegIUsdyoO1xxwP76KfQcOkZLiu9jQRm3/UfyFuamTobikKc/MUsD/VGj1lZonp8OPn+7WmiJ79WI9+kDNFZNGyoSD3DsVx9PpHVNPCZa7TQUEUzd2I6qjvoBs/hu5CieutnLnaF7pjs9/SOJmFjafbeD3KER6lw4lEElGfnDGu+eP/cHN11WDN2ECUfC6xQrF5QhHLI0WtU53cy/RHgNRVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB7381.namprd11.prod.outlook.com (2603:10b6:8:134::14)
 by MW4PR11MB5910.namprd11.prod.outlook.com (2603:10b6:303:189::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Thu, 4 Jun 2026
 18:08:15 +0000
Received: from DS0PR11MB7381.namprd11.prod.outlook.com
 ([fe80::4c39:dfe6:d6dc:6f58]) by DS0PR11MB7381.namprd11.prod.outlook.com
 ([fe80::4c39:dfe6:d6dc:6f58%5]) with mapi id 15.21.0092.007; Thu, 4 Jun 2026
 18:08:15 +0000
Message-ID: <88479c4d-ab66-4709-9932-bc557d5fec8e@intel.com>
Date: Thu, 4 Jun 2026 11:08:12 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: ibm: emac: Fix use-after-free during device
 removal
To: Rosen Penev <rosenp@gmail.com>, <netdev@vger.kernel.org>
CC: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, open list
	<linux-kernel@vger.kernel.org>
References: <20260603221217.55592-1-rosenp@gmail.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20260603221217.55592-1-rosenp@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4P220CA0010.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:303:115::15) To DS0PR11MB7381.namprd11.prod.outlook.com
 (2603:10b6:8:134::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7381:EE_|MW4PR11MB5910:EE_
X-MS-Office365-Filtering-Correlation-Id: 8cd80793-4e31-4ef1-4718-08dec2643f5d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|56012099006|11063799006|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: 5tRlYVM7jwTIDGnUklt8H3A5yt8sX4E+6P0cPfsUArDGJTKTZreygiCJiz8JGZPH1xkastHFekTRevylB71te9546TQTk+pGWwwg9gm8fR3xGkbmjOowC3e2s3KHB27N8zd/wci+ijQd5vD0bcjzQbNMDYkUlJac5SEblb87Ow8+5kPLWhNVr8vPxlBerLHnS3uEac8MeFFx6twQu5KGavC3yLdZOjMkAlLRceeCHGgVvgBnuduEmumNhooFPKXZykuAkT+ooEpt7LOXxiw5LmRNwiIcjESKZDnJnTGvbFXzPSkQAPoFy/Zg+kGx0zB51ArhYa/n6ofL6stBzkxRmpsJEw6hCKAd5gpr81+cSvy60bi3qDZwYZmUxB3bAtqCLDuFWRZhdv0+AryUxZPd34SVR2j4aj1vZwkWfhMxIOHACHgvWx88++r6bMXBfc6WEn0iJF/2ARNjZ2xqG1FyiFthVseQDSU+I0/Z4+FvXsPrA0YBwin9HBIO8F1Lnk9TM07Va3SEEPyN8LE4aOwt1VvSH9Sa4iGQzuOHY0Hv+JsmXabfsCeUfhF5bmtTZVt7H/xvi0VYIbaKeIRtPm8WPFwQ3rVe9y7xKzO0sj7eVo0nASeQrMRN1dZtPSmFEV63WkV9l6Kz5X+NBn9Kk0r92i9AtmaoCUmXOw8NpujNXIuBk7mt8wuhD6GD4qcqsgo5
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7381.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(56012099006)(11063799006)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R2VSRVl6SGpQOWRjVy9DeVI1SFJiNVpJQ25wUjRsNWtIYWdTM0gxT08vcVRL?=
 =?utf-8?B?Z2VxMDJDcGNsRXNNS3NnTHpQaVFPMFJBQml2dUE5T2pRMXlJZ3U5ZTRkd3Aw?=
 =?utf-8?B?ZXZseUlvRm5BajZZSjZBSGdUN2hGSDNZRlpHMTJFUGVUV2s0K3Jha3AvUDJY?=
 =?utf-8?B?MkFjOUpaSUtXcXY2ZTkxTitXd0N2UWFlbTAyQ21uRk9YcjNmR0QyaFdyOVZR?=
 =?utf-8?B?K0dIdkQzcElETThJQWprQ21WdnZPU3lMeXpqN0U4bWhiUTJYaVk2Qk5HL1hF?=
 =?utf-8?B?ejRxa1d0MlZTYWowYmU1MUEwOXBRUlFOeXJaWS81dFU1QmxGWk9YOHFXOE40?=
 =?utf-8?B?WE9NU2NuNk9NSDJ2RnpIVGVjTW1wdnYvVVIxbmlsR3lQazJSYzhmRzBZc1JN?=
 =?utf-8?B?VGcvUVFnTzIySkdVb2lzenZ4M014TGU5SHRIcXFCTWFSZ1pqM0JjUEt1eGhE?=
 =?utf-8?B?dEthYjJqaWNoT1BGQldkbTlLZkNydzZMMkFoSGplcmxwYnlkeFQ3U2o2R211?=
 =?utf-8?B?ViszK0hlUjIrN0VHWEd3TmtoczVzTHVCOERucko2MFo5VUJHeGFraHp3ckJZ?=
 =?utf-8?B?TUw3V25pR3lMTFd3bGd4S3FPNmNwTmxIWDVwVmJFaElZL1JNQWJ1amZROGUv?=
 =?utf-8?B?ak50Um1VaVV4ZEFRa2VBT0kya0p3NG1Ja2VMc1JiY2YxMWpNTzkyMncrVGdx?=
 =?utf-8?B?K3IyN0NFN1hhbHZwZHRsUTN6ZTJGc2RnUG5Kc09BcnJ6aFVqR3ZNaGhlRGds?=
 =?utf-8?B?VGFqS3RwTUJ4Ly9mbGVUdWVncC9ZS0xYUUFBVk1nV01vdTR2UWlvQ3dyUWpC?=
 =?utf-8?B?NnpLaVpRcUtyc1VRUFBBdkVnZThKVjJNYjlGOHlNdGJ1Q2FiblM4V1QvTGNE?=
 =?utf-8?B?L2VUSEZtWUYxNkl2eXVVSTRIUFlxZ3lHRnJrSXlaNTQvRzFHTHdyUy82aEs0?=
 =?utf-8?B?L25RWWRsZUorSFVjUENaeSs5aWc5VWw0blZjMGJseDZUYmVVTUVJdk0xZ1pH?=
 =?utf-8?B?TkdtVzVjRElQWVFXcG9lZ3Zra1VHR0VKZ3d4OHg2WFJ6cHBYK3luVXhqcDMx?=
 =?utf-8?B?RmxKck1Kb0kyNW9zQVFBMWZCdThPTTRld01Walg0bk1kaUFqd3dlRnpVY2Ew?=
 =?utf-8?B?Vlhzc2thMjB0Y05uVTdCeCtSd1psVU15OVFTVm1sVjFHczYvQ1B5TXp6SlZt?=
 =?utf-8?B?SE4wcTYvaFJUTC8vb0gvYjkwM0tJdStCc0JHdGNWcVJCT1d3ZnJnNXgxMnps?=
 =?utf-8?B?MTVhRjJWQVhJVEc0RzgxTGRWd21mV0Z2VTBqdnpjanNWc0xkTi9zVTdwV1hh?=
 =?utf-8?B?bW1ONDVPSGd1VXZUVGNycjBBdGVzNXQxWk1PQVRERzlXbEVYUmtFbVI2RHA5?=
 =?utf-8?B?bHJ5WGoyM1I2cFBMRlo4bkF3L1JxQmlONkhrb2djOGJud2tNejR2bEUzeE9I?=
 =?utf-8?B?azJkSlFzeGJOazRaZnRXWWtxYUp4MnVQc1Q2VDFPTEgvWGtzQVNVa3dZQmFR?=
 =?utf-8?B?ZUpyQ1pKUkFYVWx4c0R1enlkdG9MRklERVM4eWJEcUpZTTIvYThJY0hZczdr?=
 =?utf-8?B?OWVXQ29VaGNYKytTMHZuZzJvMDlsZ1VVOXNOeCtSeXZQTVNwbkFIeEVURDQ3?=
 =?utf-8?B?Tm5MdGRQdVhEd05rRXQyRjZEQmVaclNwRjZyZjZKQzJ2d2Ivc2t1MDJielZq?=
 =?utf-8?B?ZFJySXJnQXVUd09kRVR6ZkRjTlpRbWR4dFZrdmVmc1VudjIzWkZCVmlienFy?=
 =?utf-8?B?NW4xL1NudzJIV05ZTmo2eHlVa1pWaUhMcTRKeTVPL3UrWTMvMGgvUVh5OXpK?=
 =?utf-8?B?bmJlZnhSQU5yMS9hT3pqN3N0WWU0dU1KVWNsT2g1Wi9ydzRCMDlvSFNJTjVv?=
 =?utf-8?B?bDk0bHZFWTFzYm9teHBKbW5EcENmc2x1NUdxSXYwdjBYZ3FSY0ZtaTlyWmJE?=
 =?utf-8?B?aUx1RnhvT2lkRy9saW8wRlBqd3VBR2s4bDZYVVNPdTBEb1RDRHlDbHNJS0xl?=
 =?utf-8?B?d1ZpLzRZMWxPTnRQZndMRjBxM21JRG9UZThJSGdpVmlnSktvWFIwOEJwTTlQ?=
 =?utf-8?B?dVRhMDVoL2VYak9MbW1NZkI5NXBRNnJrT1FJTnY1NkZqT0dNb0VNbWFrZTIv?=
 =?utf-8?B?Wmw0WnNaN0FKUXY2aWROeXNLSjF3ajVsSHoxeUgzOXBwOWpxaW5kengyVWQ5?=
 =?utf-8?B?MHVtUXJCSTAzL1E2RDBCQThyZDhCd0U2ZEdMU3hIajZiYTV2Ym1mdHMrVklH?=
 =?utf-8?B?cFAwcjBXeWxnRzF4aGY5NEJ4NWpLVlhkNE5aN1JVTzFKTkRYWldLVjczT3hU?=
 =?utf-8?B?NHNlTG1XcnduaGdVenp2YVk2OS9aa0daaGJBK3NsbXRUU2xFdHZ6Q09ibWgx?=
 =?utf-8?Q?q2nxpAlyHp6Zi/18=3D?=
X-Exchange-RoutingPolicyChecked: OjaHxfXHxaRZlfAnXUFKUvfj1gVGqMwhfKYaerxrUUwFMc1PLRTJ0/vBp4R+e3FdO/8N6UGTqwDvCzHI9IaO8zxw97ddyrkAsOTxJWrHQBJ98uQt+bobTjnCnvlge3tZOA+FVreR6KTpyvT8JKJQW3VWs+1tQrkfcXYU46/Z/Ytngvy6lm6wBc4daB/6UUEKYT/lxwqn1jDnsVjv+TEeCoZodNlVw3yNHJjiZF+CZN/igh2fWXoziBxQ6dghQKZ6Xh6BruPc2N5Ybc/UF4a0i8y7VTfQIJ7OhEwaJWBcowPAF/ZDlGPbhFkgixCCPJ8t3jrzEyocXbszTkNB3Bjpyw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cd80793-4e31-4ef1-4718-08dec2643f5d
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7381.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2026 18:08:15.0155
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CyBatDZ2G+gB8NLjlCWe22fjFCM22U8CJqLVkcOPXdMAdTd5/uvKqWGyuG7bE2qql2U7yNoWA1dBnRGiChdmJdwFS0Juv/sO2SjuDcDEODI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB5910
X-OriginatorOrg: intel.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-295381-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:rosenp@gmail.com,m:netdev@vger.kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	FORGED_SENDER(0.00)[jacob.e.keller@intel.com,netdev@vger.kernel.org];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:mid,intel.com:dkim,intel.com:from_mime,intel.com:email];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jacob.e.keller@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B7C8564283C

On 6/3/2026 3:12 PM, Rosen Penev wrote:
> The driver was using devm_register_netdev() which causes unregister_netdev()
> to be deferred until the devres cleanup phase, which runs after emac_remove()
> returns. This creates a use-after-free window where:
> 
> 1. emac_remove() is called, which tears down hardware (cancels work, detaches
>    modules, unregisters from MAL)
> 2. emac_remove() returns
> 3. devres cleanup runs and finally calls unregister_netdev()
> 
> During step 3, the network stack might still process packets, triggering
> emac_irq(), emac_poll(), or other handlers that access now-freed hardware
> resources (dev->emacp, dev->mal, etc.).
> 
> Fix this by replacing devm_register_netdev() with manual register_netdev()
> and calling unregister_netdev() at the beginning of emac_remove(), before
> any hardware teardown. This ensures the network device is fully stopped and
> unregistered before hardware resources are released.
> 
> The change is safe because:
> - dev->ndev is assigned very early in probe (before any error paths that
>   could bypass emac_remove)
> - platform_set_drvdata() is only called after successful registration, so
>   emac_remove() only runs for fully registered devices
> - unregister_netdev() is idempotent and safe to call on any registered device
> 
> Fixes: a4dd8535a527 ("net: ibm: emac: use devm for register_netdev")
> Assisted-by: opencode:big-pickle
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> ---
>  drivers/net/ethernet/ibm/emac/core.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/ibm/emac/core.c b/drivers/net/ethernet/ibm/emac/core.c
> index d9bbcfbcf60e..00a36c839d82 100644
> --- a/drivers/net/ethernet/ibm/emac/core.c
> +++ b/drivers/net/ethernet/ibm/emac/core.c
> @@ -3151,7 +3151,7 @@ static int emac_probe(struct platform_device *ofdev)
> 
>  	netif_carrier_off(ndev);
> 
> -	err = devm_register_netdev(&ofdev->dev, ndev);
> +	err = register_netdev(ndev);
>  	if (err) {

Right. The way devm_register_netdev *would* be safe is if everything
that depends on the netdev being registered also be a devm action (since
the devm cleanup actions get executed in reverse order).

Since a bunch of stuff that the netdev depends on is cleaned up normally
in emac_probe, things break.

Makes sense.

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

>  		printk(KERN_ERR "%pOF: failed to register net device (%d)!\n",
>  		       np, err);
> @@ -3204,6 +3204,13 @@ static void emac_remove(struct platform_device *ofdev)
> 
>  	DBG(dev, "remove" NL);
> 
> +	/* Unregister network device before tearing down hardware
> +	 * to prevent use-after-free during deferred cleanup. This ensures
> +	 * the network stack stops all operations before hardware resources
> +	 * are released.
> +	 */
> +	unregister_netdev(dev->ndev);
> +
>  	cancel_work_sync(&dev->reset_work);
> 
>  	if (emac_has_feature(dev, EMAC_FTR_HAS_TAH))
> --
> 2.54.0
> 
> 


