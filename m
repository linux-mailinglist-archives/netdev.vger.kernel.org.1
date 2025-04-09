Return-Path: <netdev+bounces-180956-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 93DE7A833C7
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 23:59:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 664711B62C43
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 21:59:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 419C6214815;
	Wed,  9 Apr 2025 21:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mgLJfIiL"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B0EE1E7C1C
	for <netdev@vger.kernel.org>; Wed,  9 Apr 2025 21:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744235943; cv=fail; b=nWsiXyRt6prh8E6jHriI6FpYtdVBYL1QWZhfJKVhilrV8cj5UGDnyOQmcnYwTCplmEcF0ckz1Y7v9p4fgZPcLBJqHOLCA2DheUlA4I1xYJcUiULJ+eqXw6o6kxnycqOVwDX8u9npL1rHttbrgsTbWmExo2Z95NTebfa9apvP4WE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744235943; c=relaxed/simple;
	bh=+g8WWmeXyMQVBirTmIH53+p+X9GKuwMjpY0s2ZAjUdQ=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=HbSaKzXHlOQiC+1MQYwZElkDr7uCuYl1AugIBMtMDrd9CYwur71YdX1eOz3JVzn3MzmZV42oI/5VZvtQkKUJCtEjxsC2Mrex3qx/8FLhPNpfn2U2x//2RxQcgvOWmu/1nlxq1bj+OhS3wLU7XDCsNHWCb0aCFRN25vwb4GCjR5I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mgLJfIiL; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744235941; x=1775771941;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=+g8WWmeXyMQVBirTmIH53+p+X9GKuwMjpY0s2ZAjUdQ=;
  b=mgLJfIiL+gHduBE+MK0o6UaF6mFD2GB2bmtbPX/jj11tUCmv5+aMEsCb
   07S55Xtx25XxKPwDOCCL1cqY3uZH10C65CmzsDAcgYygJkDrQO0FGXRMW
   bdy9c4m6xfeflPTEmM7dLGdXxQRN2HY+aVUV28/mwYXExYGiXDmxQQUXc
   3cJcnJ6jhs3EvqnbghKPwIrY9QcV1rVRt7GD3gnep7OefenMPU9KLXC7G
   A6bPMPbRbWDSu0Cr965eP0zZuYKbT9OtmoUq+RQLuZbPzXor5P5INJsiG
   rXLBjcxRh2QCzrWuM/8RoQo/7ExLetJ2xAiMrdRCxY/Mn05oAqu1zqRGN
   w==;
X-CSE-ConnectionGUID: Mr1XCWHERjybO5BF7HnBOw==
X-CSE-MsgGUID: R+g9atdsT8+tmvvlvowDHA==
X-IronPort-AV: E=McAfee;i="6700,10204,11399"; a="44977596"
X-IronPort-AV: E=Sophos;i="6.15,201,1739865600"; 
   d="scan'208";a="44977596"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2025 14:59:00 -0700
X-CSE-ConnectionGUID: ukh0ve9rQt+28YLJ3VaMpg==
X-CSE-MsgGUID: 0ajJOnGIQFSnhTEHnaLq7A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,201,1739865600"; 
   d="scan'208";a="128689296"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2025 14:59:00 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 9 Apr 2025 14:59:00 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 9 Apr 2025 14:59:00 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 9 Apr 2025 14:58:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KjCJlK9Ud7+ZW5VITK+usCZwgXW4xt8qQa9ZcJShxs+5JRrWuokYJoDQG1LTjXcV4yrdcwX/2g1hCid52osHyd0SrkPfZqcGwmz6vrWzTFt90pCXNn74VwJYAxt2IZycDgUzCK6IeseHL9eQZ1cdL3Xo7S6nGErRubiOc3N/pkEG5b9bDGLvReK0WgMgeXHtrtpq+9Np75A2rmBNRjitZkOf3Q9rDa+QODChRcemI4+ASTwTZjJCd6UZIwS+KBoxSolpbG4wbqOUiNpftCnaQWva2BT75l6pkrIb4DpnCaAFruE7dkIw1V30uSpKj6u4C77p+TwWYiKmxkzsfqAxvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DGPwVmToYm/9JfsP939ZbXP0TLHZ1edX+0VlnfnDNPE=;
 b=YPdavQC/LPkvVJ4Hil5Y9+QxhW3Kf3HriHoUnoU1UGghYOvB1Sm7z++5JJB9cfNtmgX3eTbALBJPsr4nTA3x/Ia3kF/97bZhainBaXs6+rXtWKBc/i+OfD0jBI4sWmo6aFTu5gKGARDPJbdm785bhZCLPz/rf1b1xcMRedSl3V0Sc2e+011CdKW1K2ffZ+sZEPIN2yFTZvmQXJmYAiYHSA+qVv7+dShdJXJ84lHa/QxKafEqqRucxCDDAPXgzBZ/ogfcCtbWCTkuHInVflA2KC28MhpFBvWU2yYbLzvQSEO1pLq4qwePufR3miYEmKVBy/B0I/OLylUrH7/3og4IxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by DM6PR11MB4546.namprd11.prod.outlook.com (2603:10b6:5:2a7::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.33; Wed, 9 Apr
 2025 21:58:56 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%4]) with mapi id 15.20.8632.017; Wed, 9 Apr 2025
 21:58:55 +0000
Message-ID: <2da3c572-cda8-4879-b67f-b8ff44ddec8c@intel.com>
Date: Wed, 9 Apr 2025 14:58:54 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 10/13] tools: ynl-gen: consider dump ops without
 a do "type-consistent"
To: Jakub Kicinski <kuba@kernel.org>, Donald Hunter <donald.hunter@gmail.com>
CC: <davem@davemloft.net>, <netdev@vger.kernel.org>, <edumazet@google.com>,
	<pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>,
	<yuyanghuang@google.com>, <sdf@fomichev.me>, <gnault@redhat.com>,
	<nicolas.dichtel@6wind.com>, <petrm@nvidia.com>
References: <20250409000400.492371-1-kuba@kernel.org>
 <20250409000400.492371-11-kuba@kernel.org> <m27c3t33yu.fsf@gmail.com>
 <20250409065236.4f6426cc@kernel.org>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20250409065236.4f6426cc@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0181.namprd04.prod.outlook.com
 (2603:10b6:303:86::6) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|DM6PR11MB4546:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b95f055-5b4c-4cdc-1932-08dd77b1b93a
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UWNxbmROK3NaeC9iMFIzR1NNYzlPQ2tBL24ybVFUSkhNQWVuSlEvbHlhTHJW?=
 =?utf-8?B?OUtmYkxmUU9BM0FhUU1yRE5SNFJuQjJtTUZKUUVXbzhTYzU5YlB2WVhDU251?=
 =?utf-8?B?aFYrWFJEZWpMTis4bzVyN3pKOVJ0QXZ4M3JSSDg5cGovZWp4WHlac3lZem5T?=
 =?utf-8?B?RGhqeC9KUmFGUE5aVU8vRmo3RVdKclZFaFpublNPdDFTYllubjBKTWVQbE13?=
 =?utf-8?B?SFpKa2VnanZDOFZXZG9OT0tkV0hCVzNFdnhUS3ZjbXpkd3A3ZTJCM1FnWTln?=
 =?utf-8?B?aGpueFE4ZHlJcnhCVHNlWmZJc0NJVlFxOFFadVMxd2tnOU9RMnViNE5la1A5?=
 =?utf-8?B?RDNFbGJwa2hNRnZjVDJDNnI4VzJOMHRoM3laVjhwNVAvazVpakZIWThBL0d3?=
 =?utf-8?B?OWRibjhqUUxmaFFpckJlc29JWFRCbW55S0h2cm9mS3pZYzhtWU04YTllVXVE?=
 =?utf-8?B?MExNeXBLY1JmTlZLQ0JESG1kYjEyTWpqS2l1VmJ1ZUpHcHNBYWhJdDJSWDJY?=
 =?utf-8?B?UFo4Mk9KUWF4bWFFaVZ5b3ZyUStiTkVNeWpPejFyK1VrYUpneWJseVZXWVdF?=
 =?utf-8?B?L3B6ZUNOMFZhUFhIRzZualpkdXRpQ1NtNUl6QWZaSUhQRk4zWFpWQUlJeWp6?=
 =?utf-8?B?dENGZmxOUG5aeXRzUUY5YkVxNVFuTk9Rdi9kYXF6YW9WL3BmalJ0TTVxU2tS?=
 =?utf-8?B?UUhoK1pGZ3JpYTlMNFVtMG1KQVNYd3VFcTYwOWFNSzJNT2VFaCtNTlM3b0xC?=
 =?utf-8?B?eXVXMUtuZHhJUDF3SlZlekhod0cyTDJCZmFFRFRyYjF0NUt5Y1pqMEpneHU2?=
 =?utf-8?B?aUZhbUJ2MTh3ZGRNd3NyMWR2NVVlRDBDRzRpdmFnY2JKMlJ2ODBkbC9ueCtB?=
 =?utf-8?B?aVZtL0hyTG1IVEQwMzEzdVgyZms2d0k2TXEwU0s2d2x5MHdHVEhRS3NqMDh3?=
 =?utf-8?B?eGVEc0ExNzFaNmxzME5TU3ZRM1RLemtvTDhxdjBPTGs3Ynh5WTA4MUZFZmd2?=
 =?utf-8?B?YXlpUkJhQmlqVE5kK25sZWRWVEJmdG0rMTFTL1o0TlpwaStjb0E1SnZyYzZw?=
 =?utf-8?B?SGVxbWdXRGhKRlJCZWdDdWVPRExVRzFnQXM4dmNCR0JRVkt1anJVU0xMUjg0?=
 =?utf-8?B?UjFuWEZWdDhMc21FdTVjUFZRVXFadEJxNnhkeHA4ajV2M2hmVWVTWUR3YWpG?=
 =?utf-8?B?d3o3SjRsUzhjb2grcDk1SXRmZzQ2c1hhVlFDRXpGV2RpZXlOVVUyZHNlUTFm?=
 =?utf-8?B?b1JJK0xQWnFmMUNwZjlHR2xPVUUrcWd2MWJiamRGOXhuMlRmam5TS2xMekFq?=
 =?utf-8?B?ajdEM1M2L2VVQTFPcjdWVjA1TFUrSm0yZVdONFRDcHZBL3VrK2pQSXBBL3BH?=
 =?utf-8?B?Q2FrM21iRE0zVnVYU2M5OWVNSXp4VjVMTnlGb0g0QlEzM1F4M3JkNHFvdFg3?=
 =?utf-8?B?NUoxaDRyWklLVkVsQlRSWmtoMFU4UjdHUnNSMmIweUxab01ESzVnUE8wVEFt?=
 =?utf-8?B?ZVIxdVlSY3owZzUvS2lyUXo2cVhuWklLTnFuNFdwcHFKWG1Zd1h2WlNIR0tp?=
 =?utf-8?B?UmcyaVZDeDV4aGUxbzgrYzQxWjY4dm5wWlBPc1ZzODlTMkNnRURwZHM4c2NH?=
 =?utf-8?B?dEFxREs5dUpDZUZEVkFFOEdSaC9YSFpWVG9YNWJGeWMzdURqa2hsZXBUUVJO?=
 =?utf-8?B?TkV1RnU2N05oUUl5Q0VLaXJ5aktuN0diQ0Z1SUhLNlBvS29LSERIUDZ6Y05Y?=
 =?utf-8?B?MEEzd0pzTG83cGFIRE5KZFJCQkdTMC93eHhuZWFkYWtWRThhTlJGMjhwdXRZ?=
 =?utf-8?B?ajFqSjRHNjJOa3YvWEkyYUtDMHhOL2pra0xSTVRUb1dxQk9FamF1UDdkSTB5?=
 =?utf-8?B?Y0NRTUphRmZYZmRmdlFvVU9uMmd5U2V4U29XSkpSejk0SGVYTm91SU5uT09W?=
 =?utf-8?Q?UaxLSXzOGII=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d0t0QjVNeDFvUUxja0VzK2hiUkJxc2pwYU9JMlV4YnlqQ3l2RjVEcWVidWlF?=
 =?utf-8?B?cC9NZGlXRDI1ZmRZUExOZitMUkxpeWhzL2xyOTF4RFRTa2ZrTllJY1JodGQw?=
 =?utf-8?B?VUVHTllnQlpya2p1SXJxMkZpMWxpS082SC9wczdEUEV1dEtRdzB2dmJTSDVK?=
 =?utf-8?B?cTQ4UzVEUFVabDZUejVGQlY3TVVFMW9VS1RPdGNpT04xcVZNU1ZJZ01DbFla?=
 =?utf-8?B?VFV3R2MvNmpzMU9zejFGc3BvcllmK1JXbERQTENXOW9SNFBDVHRuSjBZTVgx?=
 =?utf-8?B?QnRGdWpZbTlHd0VTKzUwQWtVOGtQNWN6ZWEzR3ZxMnhVaS8rR08yT1NUT29N?=
 =?utf-8?B?b0pTaHh3YXRnemtiSFZpc2p4eDhQRFhDMy82blB4ak0yVWExWXExMElySVV6?=
 =?utf-8?B?NS9KS0w4aXlCaXR5SHNmMmd1SUJYTnJoVkpOZUp3d00rbUMwUS9jVEJSSmc0?=
 =?utf-8?B?ZTJKUDg2MjE3L2tvY3E4K2d0REI1blNkUE1XdDBFUWZON29IZ29yNDhBKzll?=
 =?utf-8?B?bjV1R0Z6RTh1MVd1M08ySWI4K3Q1UGNZOHROOGRUMVdmeGsxRiswY0ZIUk1m?=
 =?utf-8?B?alpjUnRWSUFSZ09vS21pNHpxU2F5R1RJWHUzd244bnZrNlhSSGt5YWhlNWxm?=
 =?utf-8?B?TUJ3eDVHdC9NdDIrSGY0U1daZlRDNHRpNTFJcDlhb2hMQlRKdGREMHlrdWh3?=
 =?utf-8?B?SDdMNUowK1Qxc2MvMnZhMXl1MllzM1ZKbzlzY3hnalVXVUFKUnJtU3o5ek5P?=
 =?utf-8?B?SDlHTEswVHBWa1QwbjA2VDBKdElVZ21ockpTRGNUbGxUcE5CMlBCc1BFTVI0?=
 =?utf-8?B?SDBXU3Jhb3BSNmVXOUZpMFdYVWVQT3d3a0FvYmJLV2RIYWVIclpOMXhET051?=
 =?utf-8?B?d1pieXZpZjNwSm9VQjluNWQ2clpsNUhzSGdhS0N0b0dtbWRIazF0Z2lFOURw?=
 =?utf-8?B?Q2N4QW14dVc5NmU2WDVOLzJFQ3RNbytyOG9RM0RaZUEyT3Y3OUhFZWtwU1Vn?=
 =?utf-8?B?L3hCUDYxSXRERGdOQSsyaDRzWWVMMW05NlY1aDZiWWhQOGZhaFNBcHQ2MUNC?=
 =?utf-8?B?SmQybnRaT1VyWTVXTGNZZWRJR1J1cGNEcERaUW16VXVpR1JRMGxFQmFScDZM?=
 =?utf-8?B?SE1HdjlyQ091OTN0TVlCSldiNCtPa29ONkVYWHJXMnpEQ1NkQ0FZcm5QalZL?=
 =?utf-8?B?SndJeGJSQ3lYNEpmcU1KQVhBS0xta2VMdnNLYlV0eDBmR1c2cUhPQ0I2R2FZ?=
 =?utf-8?B?SlV1cWNMS012R01UeFBkUCtacGhKLy9NanR4L0NUSWo5VVF1bERiRFNPbm83?=
 =?utf-8?B?WHN3a3cxbzZlMnNxOUpxK0hxYW1Wa2pQSERmNGhjMkxzYVExU1NKNVFNeVJZ?=
 =?utf-8?B?bzFzZ2FRTG9USzNSMll4OUNCOVZZL2JQMUFkekxvRGNuY2ZWM3lTR2hPRkJh?=
 =?utf-8?B?ZkVVRmhiZGtnUXVRRk1GOERLTzlKeTlzYjg0SjJPNHE3bEMyVVo3YjVwMVl2?=
 =?utf-8?B?bjhXNUtjQWFTNTJMQng4TkgxUHc1Y2s1RkVXdDlMUUhKcHV1YldDWHBGbDFy?=
 =?utf-8?B?Zkd3dnczS2pmWm9WMnZ2OS90eVhkN3pybzBEUDBINVl3UHB6TzZZMEcxTTZM?=
 =?utf-8?B?cklDRC9yeXRVSDFYSzBBd0tuRnlrMjJaS1BjUVpIZXBXOS8rcy85RTNsTzVx?=
 =?utf-8?B?TnFUbTVTQ3AvMVFUQzdjUGRydTdQT2ZnTzlLazU4dnIrRzVEd1M0NjRIeUJT?=
 =?utf-8?B?cXo0bXZkNkQ2UVppQkpFNHBFdlVDbFRocmlCZFM5b0QzT0lHWTJPL0VwMFBM?=
 =?utf-8?B?SkVMbnFYSHNtMTd3Z1FnRThqWFJCbldmVHNrcTJxOFlYNXA1R3dlVU02NHlH?=
 =?utf-8?B?RGlHMUpmYklHc2p0NmV1enBvSFlaajRkd2VYOGoxTUgzZ0FDdStkU0wyN3do?=
 =?utf-8?B?NkZTYzRmSkFQQjBJM1pHeURyMGtvdm93SVI1U1ZxblQ2UFFnRUdQZWllY2Rt?=
 =?utf-8?B?MGtKb3ZXTDNMVEU5MlpVaGYxbVJObVlGb1NUbWMxaXBwL3pucUtOdHhrT0VT?=
 =?utf-8?B?ZVB0OHZUQkFwMTRxd1VwZEdLVzJVQzBvTWVyZ0gxcHFscUd6K3d5SHpXc1dv?=
 =?utf-8?B?Nm9uekFPMy9IbFlHTkROTGJPRW5NNEFFZlpvblZZeUs4LzFFdjVhU1RySERE?=
 =?utf-8?B?TlE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b95f055-5b4c-4cdc-1932-08dd77b1b93a
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2025 21:58:55.8472
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U0fcMxMUo33HZTcM0Tv4TYp4kRrIHyQ2Ezv12Dh4XiU/8A2UrgibCg4RaiTBs68nd20Ec8MVjYV6sdlRoJxOkhPxug8Fz0odFqCcLGyY0Rs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4546
X-OriginatorOrg: intel.com



On 4/9/2025 6:52 AM, Jakub Kicinski wrote:
> On Wed, 09 Apr 2025 13:38:01 +0100 Donald Hunter wrote:
>>>          # 'do' and 'dump' response parsing is identical
>>>          self.type_consistent = True
>>> +        self.type_onside = False  
>>
>> I'm not understanding what type_onside is meant to mean.
> 
> Damn, I have fallen into the IDE auto-completion trap.
> It was supposed to say "oneside".
> Not that the solution is super clean either way :(

Lol.. I saw this and read it as "type_oneside" myself.. didn't even
notice the typo.

