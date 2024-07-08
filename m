Return-Path: <netdev+bounces-109814-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F28C7929FED
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 12:12:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F4EE1F23BDF
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 10:12:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ED6E7581A;
	Mon,  8 Jul 2024 10:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RdepLVEw"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72E632B9D4;
	Mon,  8 Jul 2024 10:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720433565; cv=fail; b=mVVfCVg2MJgtMpoWsVGsuuDiPk2awjPIuszM+2O4EYRoqSGcIvr/IpOEViKYXejNXdDSk5fgfz93l1hkrnus58s1vKk9k1YPC8b+/kiUj8C1kL4+yzxjcSzE1ZL4BhtNm1EdPUBP10XMidGxKTCGMiktygY13SjOvf+dRxXxcrs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720433565; c=relaxed/simple;
	bh=EW0pqYX9FW/gYyMtzIuTe9POz5qsddeONHiZV+L9QAk=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=mGRain4IjaNkiH9IQKQQNMS49NyaEjjX2wbltAzd5eo5gxeuAgYBx+40R+1woYGF6BIc96Z5DWw/F6nZxC2mt/gZX8MLOhdAV8OxYDcpYxZczS+CcdLaEjAZgTnAP9+YWyTNpH2cbzDvrVxTKqOSwoIygIy7E6Lf3N+c+fXbuRI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RdepLVEw; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720433563; x=1751969563;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=EW0pqYX9FW/gYyMtzIuTe9POz5qsddeONHiZV+L9QAk=;
  b=RdepLVEwXrsNx9LWYvXZ/b13ovqpiN3eRsiJyvnv85cUC9Oa9hbHDRXf
   qbYOOYUSzBN9sbfSLOyQsgZ6poKbWsqTSBH6WArLgIDQmJisQlyaT5Fzi
   SgindB7uvOykresIy5+zhACdjTYbj2chj57BQb2fJ6u02OxPqmTgfpgst
   66JND+2ITtZQKvgsBMsn6p4H6aes9wEY+5T78BzIGrbp1PTcG+9qMDLOj
   iUFnOSL1PGyl/3UczERrYQtlSJylx+uEy1lOUeuaza0dn2gScwIbRqhrg
   knA5mHVu/Ded9ISgmjenjeJa6aEeOpZjTu3E55WOgsdUjYEgodfmYBusp
   Q==;
X-CSE-ConnectionGUID: k153Q/GWRZOb+m6P9W0vlA==
X-CSE-MsgGUID: pPLm1ksGTi21//w+zzINug==
X-IronPort-AV: E=McAfee;i="6700,10204,11126"; a="17832584"
X-IronPort-AV: E=Sophos;i="6.09,191,1716274800"; 
   d="scan'208";a="17832584"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2024 03:12:43 -0700
X-CSE-ConnectionGUID: VvvBXTyeRHqaWc/Gcr/nlA==
X-CSE-MsgGUID: u1IHN3zdS+2ooVIRMeu5Eg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,191,1716274800"; 
   d="scan'208";a="47231072"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Jul 2024 03:12:42 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 8 Jul 2024 03:12:41 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 8 Jul 2024 03:12:41 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 8 Jul 2024 03:12:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hMV7OI8Gba1aF1aCT4no/hvPMC4tSvN3OJibrECgodNjkBAFqIDwNFxvOPuDWOTzdjjsrSST3mahu+sSyirvYJHYK4/BhB7KBIxuzgYNKzWzXpXHtHxrjcmz9lVptg3x0Ca2MeQSW+mAfzxYrNcj2p4+kHruRlqkqdIHBXd+vUxDdR9RkCOyhTt4l6Nq5livzPiLBDKxlG/8qGVR1vSAc7aKyZ2An1vizPtR+K8LgtfhD3qGRrcmBjdToOujLL6gWXU1E5AOmJv3zAFHfG9xKC9gtP31SFcRPLbfqEfCwaglsF8ZLoeYBQZFs/Ivyca3bM9Kilq7ZOzUEE2qFSCQMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CCnIJC20vt5tRpPL2bOZn8A41V31jOWRnGHrKxAGakU=;
 b=amnYppLDT+tU6BDvO4bifd10ZVjrxk0ePq3sW0bzUPRdfbWzYk28H0+jRY+v5XA4n7AtF0xSmPnOReonS8Y9k/GHyiaEMjeoEC6SiU8vZSRnHuXOnHBlsqJrM2EVilj/c5W9yKXFJjEVFgZk93K+vRe4ogiyK4Lsp4flZELbrB6onwe24O+GiW4guD7+fwnSz6r9pnuhqGhW5yNecVBq+bDY2f+zZm+Enm4J2jdm1VbUQaRuwh1FtIhzZM9qZtefKPyGdmkmZ7kfmT2cdQ1zVtsm2PH6RnwLnpagmCAZcmqi0cg2Iv/YkO+ZXtPaixe5cVy/Xz76BWiY48CGaoEBkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
 by CY8PR11MB7134.namprd11.prod.outlook.com (2603:10b6:930:62::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Mon, 8 Jul
 2024 10:12:38 +0000
Received: from MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6]) by MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6%7]) with mapi id 15.20.7741.033; Mon, 8 Jul 2024
 10:12:38 +0000
Message-ID: <c71e8bc5-8702-47d1-9d01-84f8c57b32a2@intel.com>
Date: Mon, 8 Jul 2024 12:12:32 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2] ice: Adjust over allocation of memory in
 ice_sched_add_root_node() and ice_sched_add_node()
To: Aleksandr Mishin <amishin@t-argos.ru>
CC: Jesse Brandeburg <jesse.brandeburg@intel.com>, Tony Nguyen
	<anthony.l.nguyen@intel.com>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <intel-wired-lan@lists.osuosl.org>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<lvc-project@linuxtesting.org>, Simon Horman <horms@kernel.org>
References: <20240706140518.9214-1-amishin@t-argos.ru>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Language: en-US
In-Reply-To: <20240706140518.9214-1-amishin@t-argos.ru>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MI2P293CA0006.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:45::18) To MN6PR11MB8102.namprd11.prod.outlook.com
 (2603:10b6:208:46d::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8102:EE_|CY8PR11MB7134:EE_
X-MS-Office365-Filtering-Correlation-Id: 7765cec8-54d1-49a6-55c4-08dc9f367f02
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?a09qbm1DU3laS1luUWREM1V0T1RHRDJvQlR1S3h3Q0NwS1J1UVpEVEd2QkJn?=
 =?utf-8?B?Y003OUExTVNFRFk4MHhlSm9lN2Rad0FwMTRNZ1pKeFZtYWtSNUpzYy9qNHRP?=
 =?utf-8?B?QnI5Zm43T21IZHBTdXFiakpvcmY2TDRRWnlsMzduWVVwQ3RGR2NtVy9TRHVK?=
 =?utf-8?B?Z2ZkKzFaa3k5YUdxeTBueGpFVGZOWTQ0VzVkKzIyODF0QjYvbGF2QkpXWWt5?=
 =?utf-8?B?OUw5Ni9RbC9YQXgxVXM5cklkLzNVSmI2aEZBNmdpM2h4VGM1bG1xWldibzdU?=
 =?utf-8?B?aEdJdGQwZ1JPWmFDcUY4dUpRQU1xdDRWZkxqVy9zZUpJSEhxb3dNcVdUUE9K?=
 =?utf-8?B?TWZ0ZzVYSFVaWmNoVVNxWTZKZUhSTnJqbitXS2duTnFnZ3J2bGRoOFp6cVNN?=
 =?utf-8?B?YUpCQi93UG9qcC90b01YeGh2dXhRTmxwTk1QMjN3cnVjOTdHSmR4ZTZ2dloz?=
 =?utf-8?B?N2JJdzFxYThtV2J1OUpCUnIvR1RWS2JWZkxNWkpnNXNOTnJwSXl3UkUzbjAz?=
 =?utf-8?B?OUprbmZ1aXgzTW0xMzZ3MzVienBSZk84T0FIYnloM0NmYTZQYy9uc3NXSzAv?=
 =?utf-8?B?b1h2VU1ra2dOOUpNL2VYSDJDUm9XUXZFWmtuOUk0Z1BUa1F4TWw1RllDNUZr?=
 =?utf-8?B?SGhRaHBVL3d4K01OMXhhVGZlVTAxb2lzWmpBaWhZYU9KL2VmOFhQVW9ocnVF?=
 =?utf-8?B?ZEhuQ2V4d1czVXR5ZTR2TXJGUk1sd1QwRnlNclRreDZtejZwSHE4Ly95aVhZ?=
 =?utf-8?B?V1VSMEl3Z09IRmlhaHFVQXRObmlQOTd5RUREd0R1VUtYb3p4RTU2MkRhR2NM?=
 =?utf-8?B?Z2lHQTQyM0xxamlKVUplKzRxa3JDcFI3d3JZdzdxampKdHY3NjRrS01oWXhx?=
 =?utf-8?B?U0Z3dkU1dys3R1hFT1hBUkFLekdESzMxbGtnL1IxcXRMZFo2WGRCNDV1WmZB?=
 =?utf-8?B?bjQ3Sk02bVFqb1pCV203a0ZpakFkVU5CalpCdk42WmYxRnNSdldpY2tJSTlw?=
 =?utf-8?B?R3M2VEY0bWtwcVQzcTZ6RXZSV0ZtZEhUQmExT0pYSnBMR3kweXNNODA3Ynln?=
 =?utf-8?B?TWJiUGpTWDZiYW9wMlJnMFhlcnQ1ampmSUExanJsbjUxdFV5K1l2NGJ2QW1Z?=
 =?utf-8?B?aEY0OS9teDMrUGFPS3Bhdng3NmhaNThDNXg3Q2taNkd3U2ljK3h3NFpneU5K?=
 =?utf-8?B?dndXS0lyYWxySDk3eHZxUkNhYU1OUktGV3Y5VEJiVlVmRTQ5WmRhNmpCYnZk?=
 =?utf-8?B?Vi9XVThrbXE0azZsdzBMajdLZ0M0Vnl1d3RhVXVvdVN6THc0VjRMU0xYQ0Er?=
 =?utf-8?B?bDhDVjk4WkZPVmpzNGlmS09Ia0U3TkNONFQwZnlzeWdPdndOQmdTWm0xTjls?=
 =?utf-8?B?T3NNL0lpODhqN0c1N2xKWThWUmxxWVVmTC9OUjJlSWwzSDhtc2ZJdExtdVBG?=
 =?utf-8?B?Sys2ZkRRZW13NldBOU1DWXNDU0JHM21XdDRxWkU3d2x0bVJ0djBCcnZGTDJm?=
 =?utf-8?B?ZWFyVGxJZU1vUll3YmZ3Z01jbWVjamdlT3MwTVhJd2psTVhscGY5L2lYUG1y?=
 =?utf-8?B?NnpmQjdDclI5ZVVLM3F3elNXMit5YXNxMHIvTWJOZk5IOGRvd1hkaEI1VkpN?=
 =?utf-8?B?aEtNQ05qTFJSREs3OUc5Z0FIYzMvNUZmT3VRRk1SdWRwV3NCd1AwSWNIWHpB?=
 =?utf-8?B?YlJ1cTNMNFE3RnlHaFczMzQrVFFJR1R2Uks5Q2xoRC9PaEZJLzhCZjIxdHp4?=
 =?utf-8?Q?Y4iSI1jda2UnjOryx2KPs2MUDi/UAVbiHC1CDso?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?djNhRmhpM0V1UVpwR1RHdGZQRFdONEovMkhRdW95TGpEY3Vna2FnZi9Eb1Zy?=
 =?utf-8?B?L2F4WmdNUzdTNkNWY0dCeGtWRVBtYS9tT2g2VnpjODZYK3A2bXBQSTN5N2Vn?=
 =?utf-8?B?UWJqUGZkNTQ4a1dzYWlhVkRVeElJRkZrUVQzaWZVVFk5V1dMaVI1aEt4aE96?=
 =?utf-8?B?alE3NnNpR05UVXA4UWV4bzNLREJySFJXUzFBWFpydUh5dlZWQTNkWEswQSs5?=
 =?utf-8?B?ckc3em1SYTRqTjVxTzJIeENHVzNYUU5IMng5QktkUjdqNEZHbzhiMkYyY0pa?=
 =?utf-8?B?M0E1Wmh4aUtPMXB6R1FCUlNSbEZHdm1vRlhsanhxWkR5Qm4ydUlORy9ZL3pv?=
 =?utf-8?B?L0ovbjg0NHYwRGJGRGJZc3llcE5mU3V1NXhqV09Pb2xuMjliZWFvS0dZVjhw?=
 =?utf-8?B?U05aQzhSZGh3QkV4RmdNaS9uMDZVaENReDV6dU5hMjBVN2gxeGxBN3lmMjlR?=
 =?utf-8?B?VkVWdXVzRVljVXNlMXBFa0xFeWFwNmZRWnYvNVhvR1pBbDR5Zm1XK0JESDYw?=
 =?utf-8?B?TmpuM0s5elNPRWRHdkVpa0VnQW96Rzlnbkk3Qll5YkplNjkrNlBzaUk1Zngw?=
 =?utf-8?B?V1RGeXF3emszM05Qb2l2SzR2VTcyWDRCa3JsNVZaZGV2bThYUGlrQVc2WTlq?=
 =?utf-8?B?dVMyYXVBZFlzcGdZNVRZYm5OS3B4Z2lzR2grQWdkVkNmbFloaGtGV1d2UWto?=
 =?utf-8?B?TmlUSjNiMW1PUmZhWHg5VTNvYlVsc3cvc1NDZUt1cVNyanBLOGZhVUEwTk40?=
 =?utf-8?B?V1VsLzJaMlMzZU5LQzZ4RWtFaW9aaVBudFAvWEpnZ2IxQjU5QTFPMm81MnVW?=
 =?utf-8?B?dG0wcFBFYmc2eWphcVZhaEZhNE9MajJBMUtwd0liMnJScUlzMWJjT2ZLOS9k?=
 =?utf-8?B?NTlGeEFZYjZpTGN4bDMycUZJV1czVEdKRmpEWmo2UGIzc1R2OWVkVjUraXpF?=
 =?utf-8?B?aHZJSXM1NUJGcVNHa2k2YmFlU3hxNk9jdjB0b2d0d3dnU0hBaGlKcHltM3ZZ?=
 =?utf-8?B?TTlMa2hDSitEQ1FucERlemZvRysrZVV3Kzl4SmVmMFBzT25ac2RFWEV6QU1S?=
 =?utf-8?B?NGlZVnB4bE4vWmNmWnhuSVpwdmYwT3RUcjQ0QXVqTjRTcXR6UXNHSGY0R1FV?=
 =?utf-8?B?eHA5eE1LRTFLSGdVN09IUzF0akxNSlowM2o5eFdFcFpzNVhMZ3l5YytXZ0hP?=
 =?utf-8?B?d3RWak9Md1FRa1hka09IM1VvYjdtTmxka3p3Y1BLcmpyS1krR28xbytqK093?=
 =?utf-8?B?K1N3S2s5UzFXVmpzMERSRnd1Rzh6SS91bDN6OWxseXVVbHRFRmVoZU5FQ3JC?=
 =?utf-8?B?cUhWbkdKY2YxSTR1WW5CUm5QRFg0aEtpS1BuMTNFY252TlhOY1gzcDBvRmQv?=
 =?utf-8?B?NHhScHhTOFA2cHdwZVpiOTV2Qmg5d2sxcDFKQXhEeWpnaWFGa3pxRFhkanNY?=
 =?utf-8?B?MDBsN29iRGlXVXRQVmoxdFJ4SFpoVUczeXNOajFyRkNMQ0wxclZuVWtOdC9t?=
 =?utf-8?B?NTNZejVhdFpiRnZqb3NVa2JyODY2eUgyN3htOEhhZy81Q21aMnBEQWpFd28v?=
 =?utf-8?B?dXVoUmlmeDd6aStwT1lKdkJjM3F6TnFCdlhQTjQ5WUdScUZud1o2TFpwQ3Rt?=
 =?utf-8?B?RmtuN3V5MjRhc3VlcHVyVk0yWVZ0T3IrR2JhTEtJa2Z6MUIwNW5kQ0hRSjRS?=
 =?utf-8?B?QTh3ak9LSXNMd2kvVUc2K2diRThIbEVFV3RRTTFISDlDMFRYRUtLUEkwb1l1?=
 =?utf-8?B?N2JZbHliZExkRjkyU0VGdW9SQVJFS0pKb1RGL1BtY2JHNzBZQ3Vuako0aU9p?=
 =?utf-8?B?a3hPWWpDbVh0SmpGMkt3RXFKYmluQ1RUeEcrMVhxNlJPaTc1eXpWYzNOUlJF?=
 =?utf-8?B?TjAzZGt3UjBZVmNTQjcvellNbU9mSm1Wa1BKZEZjVG5oQ1RQSWpvdnJORUky?=
 =?utf-8?B?OEVUbnc0dEpsVFh2VGYwNWNkc1E5R1pZRXIrUnk1VFFJZ3h0QnpYWUI5V09O?=
 =?utf-8?B?RXR6MWlmdUcvN2JEMXM1OFl0aDNLVmtiRExwYU1JM2pBVHRHRGV0bUtyUnAv?=
 =?utf-8?B?SjdTUG1XN0ZSb1dEbWVJUng4Z1kzS05Dejl4R2RFOWl3VjFXNk5OaklZVFpx?=
 =?utf-8?B?c0FWRFBERFc5RjhvUWtuT1ZKZEgzYXVoaFFmOFczN1YzbHBlWkxGakVMTUpi?=
 =?utf-8?B?bFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7765cec8-54d1-49a6-55c4-08dc9f367f02
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2024 10:12:38.8460
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: quzMAfqDCezlv66nKbfB8mSvWZJa4tYMrefFWFUtxPR4TFmSjHPCTZZNsOS4HU4SpbsBUcnIoehlbjJhPwJcx2QR93L+KO8YyoQgwr3k/44=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7134
X-OriginatorOrg: intel.com

On 7/6/24 16:05, Aleksandr Mishin wrote:
> In ice_sched_add_root_node() and ice_sched_add_node() there are calls to
> devm_kcalloc() in order to allocate memory for array of pointers to
> 'ice_sched_node' structure. But in this calls there are 'sizeof(*root)'
> instead of 'sizeof(root)' and 'sizeof(*node)' instead of 'sizeof(node)'.
> So memory is allocated for structures instead pointers. This lead to
> significant over allocation of memory.
> 
> Adjust over allocation of memory by correcting devm_kcalloc() parameters.

Last three sentences are not correct.
Better commit message would be also more concise.

> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Suggested-by: Simon Horman <horms@kernel.org>
> Signed-off-by: Aleksandr Mishin <amishin@t-argos.ru>
> ---
> v2:
>    - Update comment, remove 'Fixes' tag and change the tree from 'net' to
>      'net-next' as suggested by Simon
> 	(https://lore.kernel.org/all/20240706095258.GB1481495@kernel.org/)
> v1: https://lore.kernel.org/all/20240705163620.12429-1-amishin@t-argos.ru/
> 
>   drivers/net/ethernet/intel/ice/ice_sched.c | 6 ++----
>   1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_sched.c b/drivers/net/ethernet/intel/ice/ice_sched.c
> index ecf8f5d60292..d8b6054f3436 100644
> --- a/drivers/net/ethernet/intel/ice/ice_sched.c
> +++ b/drivers/net/ethernet/intel/ice/ice_sched.c
> @@ -28,9 +28,8 @@ ice_sched_add_root_node(struct ice_port_info *pi,
>   	if (!root)
>   		return -ENOMEM;
>   
> -	/* coverity[suspicious_sizeof] */

good to clear that, thanks

>   	root->children = devm_kcalloc(ice_hw_to_dev(hw), hw->max_children[0],
> -				      sizeof(*root), GFP_KERNEL);
> +				      sizeof(root), GFP_KERNEL);

Your change makes code to use the correct type as sizeof() argument,
however, I would like to also make it the correct entity, so:
sizeof(*root->children) // == sizeof(root->children[0])

For the reference
  562│ struct ice_sched_node {
...
  565│         struct ice_sched_node **children;


>   	if (!root->children) {
>   		devm_kfree(ice_hw_to_dev(hw), root);
>   		return -ENOMEM;
> @@ -186,10 +185,9 @@ ice_sched_add_node(struct ice_port_info *pi, u8 layer,
>   	if (!node)
>   		return -ENOMEM;
>   	if (hw->max_children[layer]) {
> -		/* coverity[suspicious_sizeof] */
>   		node->children = devm_kcalloc(ice_hw_to_dev(hw),
>   					      hw->max_children[layer],
> -					      sizeof(*node), GFP_KERNEL);
> +					      sizeof(node), GFP_KERNEL);

ditto

>   		if (!node->children) {
>   			devm_kfree(ice_hw_to_dev(hw), node);
>   			return -ENOMEM;


