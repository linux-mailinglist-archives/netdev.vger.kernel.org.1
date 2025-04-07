Return-Path: <netdev+bounces-179541-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E01B7A7D8F6
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 11:05:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 99FB818864B7
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 09:04:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02CA022E412;
	Mon,  7 Apr 2025 09:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FdPTfug7"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1502B22AE75;
	Mon,  7 Apr 2025 09:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744016643; cv=fail; b=IIsd6kwtUA84aGI+6XCvqN+g+J8wOhUeoJ8ysrpUxAC02F+nfe9B7wYuG7YowdDvVrwmkdj4vJVxfGwYEPBTNFDHy/s35s4D+j0uGgHAuZOrFYwehdiGTcISD5JGGElh60FCD0talGFNI2a+EmeuCxkIzHrcbOjlbbCGjQV/pss=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744016643; c=relaxed/simple;
	bh=w3xWzw2Jw3aWFHcFeVSFAo35fONqGlKtGZ1t+ZWonJw=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=m5IMMfisxKUDiiK2L2aF0LUGe/iG7cz8Z6LwxEg9z2kH8UwTzNxOOC1460r/O5B3X3pr1xSdQlOlAE/yONr7lpgakCDTslH53vGGIeVhyKG/w+u1RhjDuZzvGoYw2FOll7A/Cp9xxP6GrDX9H22omVHQkcHZvHnMDTxLXWFmVvY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FdPTfug7; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744016642; x=1775552642;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=w3xWzw2Jw3aWFHcFeVSFAo35fONqGlKtGZ1t+ZWonJw=;
  b=FdPTfug75g8XK1id+EBk7mGyrIUtUmQ8Mzf8VD9qz6O/58W/rOao+Tjj
   h/Kc3dXuhXySb06cGx/Bldt2Tp5NMHyGySckcYJfPOh3Zw+LZ4+DchKIg
   xI7pHzqSvQ3/bMCRjoKzsY2j3+BUg+zjGY6pzJEuE47JcZXWF4+l1eD/T
   za3OwoRaJzELUz4tK/PR5F7LwRuoEjZxmLHEKDUY7ddv7AEejb/QxgX/M
   2M0puB5Mfjew8Kqh36t91Va8CNypu9OBEvQSIH37qgE/xqs4uF8AS72qP
   Kg7EEizKNUVbhqIBKcpSItRv1vGn85YwHhYHhAO64QaVILB1W83u1BXYt
   Q==;
X-CSE-ConnectionGUID: EmPTgRIyT0i86Pu80/s0Iw==
X-CSE-MsgGUID: VISpw9m8SPyAc1/X/uNCcQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11396"; a="62787937"
X-IronPort-AV: E=Sophos;i="6.15,193,1739865600"; 
   d="scan'208";a="62787937"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2025 02:03:59 -0700
X-CSE-ConnectionGUID: l+NfOQyrRK6qqaIppyT99Q==
X-CSE-MsgGUID: mb2gw7FKScCtmMiv6zUSRQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,193,1739865600"; 
   d="scan'208";a="132036392"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2025 02:03:56 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 7 Apr 2025 02:03:54 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Mon, 7 Apr 2025 02:03:54 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.173)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 7 Apr 2025 02:03:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f8I74rx3NgDWCVwCCp1KJiUmFVhfSGZcotmZRCUx3I7K3niHmvJJA0MbPmS/xEl63hMGXdr1XEB6+YL+7BIr8lvP7giq3NzrvlFVfQOk8UveEbkF6RQm9zeDgiA5MVDGokeloyI4vMRXG/PNR8KjT5nlOBCqcO1rpLZbq8uiymBHcxfRgGMeNsxRsZ+LZXZYaX2jZ4DkAO17aIwlHe5suvdwP/Qv/2AsQ7qG7QT+3uzDecu0dTjfuqksJ6YUTXY86igRDFeAoPs7ZldnC2PEJevXQtk9rnEML0c4yJfHC69XYWNPx2h0Shpbv/BIC6yBqXKaEvDf+Yg6dSwG8WSWPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wyRDmFMYxv5hDoYkarGFbr3gzP9KlfSOUeAchEqBB+o=;
 b=m2dQ/25Mx+KccowBOiV5o0sx2azf84I1h2HFXZBrkCSg+XBy0sbxabYQCXdAqNRVbO30RITn8/AQH4dhPPJBh3U1VWTYd/3us3rBo6bxiJc9kbL84N69NoiKLEfpVf4IsduPEkTHuBFRvly8tZfklnqfXIySElqDAxW8O/Io++VNHTP18wnXqkEkGgqLQN/Ax+/W/RRMLQlNnRFlz98F0p+BszthKT2OIf4jxeRBASOYbRuOZOk1u+cK5LkqEfbSi9zQoWw26BMT6YwDJxy6nX08I5VJCGzuJjMZxhu7VwJotbfnQoJkSiAzygRzBNw65sLMhels8TeBFRPemXORMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
 by SJ2PR11MB8450.namprd11.prod.outlook.com (2603:10b6:a03:578::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.34; Mon, 7 Apr
 2025 09:03:38 +0000
Received: from MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6]) by MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6%5]) with mapi id 15.20.8606.033; Mon, 7 Apr 2025
 09:03:38 +0000
Message-ID: <fdb5d23c-8c39-4f73-a89d-32257dac389b@intel.com>
Date: Mon, 7 Apr 2025 11:03:31 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: objtool warning in ice_free_prof_mask
To: Oleksandr Natalenko <oleksandr@natalenko.name>,
	<linux-kernel@vger.kernel.org>
CC: <netdev@vger.kernel.org>, <intel-wired-lan@lists.osuosl.org>, Paolo Abeni
	<pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>, Eric Dumazet
	<edumazet@google.com>, "David S. Miller" <davem@davemloft.net>, Andrew Lunn
	<andrew+netdev@lunn.ch>, Tony Nguyen <anthony.l.nguyen@intel.com>, "Peter
 Zijlstra" <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>
References: <4970551.GXAFRqVoOG@natalenko.name>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Language: en-US
In-Reply-To: <4970551.GXAFRqVoOG@natalenko.name>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR03CA0053.eurprd03.prod.outlook.com
 (2603:10a6:803:50::24) To MN6PR11MB8102.namprd11.prod.outlook.com
 (2603:10b6:208:46d::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8102:EE_|SJ2PR11MB8450:EE_
X-MS-Office365-Filtering-Correlation-Id: 041aa121-4976-474d-360b-08dd75b315c0
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?d05GVkgxeVFKZGUydWdyalJBYTN5aW4vOTJjcjNucllJcnA1RElYOUh6UmVY?=
 =?utf-8?B?emdSN2U2TEpoZ2YwbVNZcHNmWlZUQkYzMEJrVHNjNEFkWXRpQ2hhMm1IS256?=
 =?utf-8?B?TlVlRXhYSmtrdzlhanpYMHNETmZJdzFDSURmbkVUUVVLM2JscStYOU9QeDcx?=
 =?utf-8?B?S3hkRXNJOWlTOFBFa2JOREp2VDEvck1wME9PeXo1RmFIOEMyMW4wNWxqZUov?=
 =?utf-8?B?dGtUSXUyN08xUTRteW12VUtOS2hOcTcrNWt1VXRoRTMzZXgxZVViTGNhdERY?=
 =?utf-8?B?MEtRejlIcDYyVHVhb1JDNWl2Qy82WjlnR01lUGtGQU5ETzJyVWFIUWVxL0lM?=
 =?utf-8?B?Sm55QmVwRmxvREV6RC9zU2pCeUd3MlNGZ05kUlJkY2tDdFMxOFFDVkltQXNF?=
 =?utf-8?B?Wm1VY3lrcEUzVVRqMWFPdkhIOW5YNERnbG5jRFd2NlN1cjJFUVFRdThLMVNG?=
 =?utf-8?B?dS9BYmV6MUVmcHY0dTFQNXFRSUc4QzMvQXlKbi9MZnNBZkwzSFYrdUF5UFpO?=
 =?utf-8?B?NVVsZ3J4Z3ZxbjNmTktheE44Q3V5d29Lek1DajdqZ2ZQOFg1NXpHUURCUWZs?=
 =?utf-8?B?YnBzM1hGME5Ydm9YaGI3a3J0bjl1VGQrbnlxSHBCUlh2REwvOUp3VG94Wkoy?=
 =?utf-8?B?OUJ1cE5TS0pqYktQS3FoQ1FWblQvWW9qWmFKR1ZnZ3pJM2ZWWStScGdDcnJR?=
 =?utf-8?B?ckRUYmJHMU9Eb21XTUJQN3lFWGVoK2dibmJSc0xGSTVKNEVzaVNWN3hTUnBy?=
 =?utf-8?B?enhWQWdCU0syYzc5b2JZMERoRTJDNFFEWHB4dTM1WHF0Rld1QjB6ejFLaXkr?=
 =?utf-8?B?czl6c1A3ZlY1dnMySG0ybjNUT2dJVDNVY0hvdElCM2FQTkFrRzF5ZFZoaG9F?=
 =?utf-8?B?Mk84bUNMWDg3TlFGdndWczByWXd2MkQ5TG1uYlhUQzJidVk5SlpZcEFPc2Zx?=
 =?utf-8?B?dEZUWDdINGRaTXR4cStUVWdwY04zaDNwcmtnZU5XN2ZBc0JxbWw3OFV3bklq?=
 =?utf-8?B?RjZFOGMxQk15ODRIYTVnOXJaMGhiUTlEUFk2MWtyRGg0dzBBbWpVN0NEQWdG?=
 =?utf-8?B?eFppcUR5K0Rld1FCQ3VLajFJRTU4L1JEVjB1UnBaZFZiTll1UDYrZ2RxeVkz?=
 =?utf-8?B?MElUeStiK0E3dW5PTE1rMkcyL1NBU3VrVzB5TFVxL1RHakRzdjVEMmVQZVR3?=
 =?utf-8?B?MVpJRFJyY2dvUWdTbGlFR0tFZ01QL2Flc2U4ekgrZFcvbkdDRENzWEZiVGI3?=
 =?utf-8?B?M2Urc0p4dmJMSkIvSGt6Qlc4bXAyUVNENVBnWm5rcVgzY284ZnRnb1RDSUNi?=
 =?utf-8?B?VWNVbFdCdWpRUlplSGZqVHoxeDNEK0dzRVJNL0hEWDdmdXRSMU5yT3lxMHl3?=
 =?utf-8?B?RGVPWWhTSjlKQ2VKN1MzQmQ2WDdkWGZFYU9ZOGpkWlkwZi8zTStqYU9Rczdt?=
 =?utf-8?B?bHpLcnZ6UWFMcno4WUEvU1E1WkZObHh6bExweDU2U3pzYldiT1dCMG9HUXRK?=
 =?utf-8?B?OTdlOVFGWjBjbUZNNlp3YmVTcVg5bk9OTDJSRW94TVQrcW5pTFF3YW5oblM1?=
 =?utf-8?B?aTM3L0l4ZG16RTB4OFhyZFFua0FtSXJqblkwYy9MeDlpQUdJVXkvdVJyNThN?=
 =?utf-8?B?UVlPSVNJOWRFUmJ4NjBXeWJqVGdGcWp6ZVFGa2RmKytVVGI3YTB4TDA5UTA5?=
 =?utf-8?B?QzVkVDZIOVdTamNtdkhhUTVkTkZjeWxaeUxoNEtCSDVZcCtQc2pjSFlkcjZL?=
 =?utf-8?B?SG1yZlpmNUp5ZXVMMDVjaWVrS1pIRDB4YUJZbGU1Q0Y0ZFlLT0YyWk5kYTV0?=
 =?utf-8?B?aEt2Q1hIOXlxTE0zK2QwRnlUMlh6NGdGbHE2VFZPaUJ4R3FZUnJyelFDaUUr?=
 =?utf-8?B?V0E4TTExN2RHQ3R3QmluSkVTODdDTjU2NEFkeE8yOVRUb3RydFJTeWVrK25G?=
 =?utf-8?Q?5KIzkkGTNvc=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WlgvTWdZVjZqb2lwZ0paVHk4WXBHMFBjdnFFbDdZTXdwTGFPWjR0Q3dKM2Rk?=
 =?utf-8?B?QTZhY1dHdlI5S2Y5VmJ5R0lRUk5YbW53RVJ0TFpIZUJ3NkVpbmVSUGdubitB?=
 =?utf-8?B?Uys5R08wUmg5a1czZFpxbVlzR2FoMWxjSzhjRnhGQWJDVWlQcG5vK25hU2hv?=
 =?utf-8?B?OTYvekhuRkI0WHFwRVBpU25ObWtueU9WS1ZSSzZ1OHJoTDA2TEtuNkY4NzE0?=
 =?utf-8?B?a0lZelVndFdhajRFYzVrZ3hrQ0VYUDFhc0hsM3ExQlh5dmE0L0J2aE1JYk9W?=
 =?utf-8?B?SXdTcUpPa3hzMVNJbFVjaWsvb20xekRJVnhvMUR4NGZ0RU9SQTZDUFd0b0Nn?=
 =?utf-8?B?c0FzZVFEMVNEeG9qd01XYjI0VlVxb0F4bEZERFo4UzdiZUtEZHdZMEZlek9a?=
 =?utf-8?B?cUhuZkNKYWFwMUJSWXRZTFV6Tm9yUkE1R25GOXhGWG5Rd2tKKzhlVXV6U2ho?=
 =?utf-8?B?U0hxdEhWME9VRTRveTRYdG9yVFd3eTByOVlucG1mK1MyM3ovQkZ5MFdMcjBO?=
 =?utf-8?B?am8xVFlUellBcloxR1VSRjA4dWl6Qk1CY0Zsc3hObTRLbzlwVVJNRmpMTVlu?=
 =?utf-8?B?Sk1LdWw2YjRYUUVQWml6U1dGdTJZckdJd2ljcmQ1WWw2SFVtMzNSNU1ZdS9r?=
 =?utf-8?B?SkkyRW5XQVp2TGFyTFNxYytZMlRCSnZNOGhndG9seTRYYnkvNVl6NUw0ZmM4?=
 =?utf-8?B?SGtzcWFDM2RrRy9qemd2OG5rTlVCcTl0TVloUTB3TlpyVjIvRkJHMDFTancy?=
 =?utf-8?B?dHNIMmhld0F5TmFOR3BvR0FDSThCMTQ5Qk9DOGJyS2o5eWZyaUhKU0RIbE5P?=
 =?utf-8?B?QWFRelVPTEkwUXNXRWM4Y3Rya1NZZVZsZC9OTjFSVWZuN1RPWHJKb2d1WDJG?=
 =?utf-8?B?azlkbzhuemozREh2QlFjZjJzUGRFcERTMDRidUdCajNYbDE2N0I0MW0wNllQ?=
 =?utf-8?B?T0dBRzVLS0JkWENBT0NWYmpVUW40T3E5Zm5JUmRwMVkzNVNEQmlVdXpjdjJ1?=
 =?utf-8?B?NGthMjhEdUdzZ3dkSXpqdTBSNlNxWk5SZlpTTWU4UjRBNDNmYktuRXBxKzNh?=
 =?utf-8?B?YXBJd1hsZXVnNWhMRDRKdGpHeHlGUHR0S2d5b3FYRjdlOElvL0N2TXB3UnVa?=
 =?utf-8?B?YUR6akt3Mi9UM1h5d3lJOGdVbEV6MXAxNFBTQWtTRzVVeGtEeldTUzdzNmlZ?=
 =?utf-8?B?TXZLaEZKUXpoRmg1OGErUEFxRUJFNi9TVWt6RmRCVnFZQmMrS1ZyWm0rWFJN?=
 =?utf-8?B?SHJ1QjRsbERLY2hLbUIyaXA1M2J1TCtrbVZMUGZnT2NlLy84VTE3Rk42UHE4?=
 =?utf-8?B?eDcwc1lCSFRmdTJ1RmNTTHp0ZGYrekxtckNmUGkvbUV0YXpxV2N6TmVmRWpy?=
 =?utf-8?B?RC83RTdRTEhEeUFoM1hRd0xMaXNZVDBNamdWcjFzMkUrQ0E0T0lIZVhKTVFz?=
 =?utf-8?B?U1pNOUdPRXZvZXdxTDFmQmd5SGdVMVFHYWdLWG1NWEFNamdqQ0xUblZjZmlC?=
 =?utf-8?B?c1F4ekRlWThKVzB4OFRTSjJvdmFyVnFWY1NkbTRURFdLZlQ5STFLSXhhRjRG?=
 =?utf-8?B?SktoY1pWa2FZeWh5U3B5TlpVZlNybEhGbUJrTHhMUnhIcWw3b3gyeXViSk9F?=
 =?utf-8?B?UXhJRmtPcm95blNlZURxRFR5NkZhbldCdWxVNUhWa3pOTVIwcEN0NTI2dmJP?=
 =?utf-8?B?V3ROQzc0cjVqNkkzT2MwVTllaTh1bE0xYzAzQTRlTGZBYVZsNElWbmZwRERk?=
 =?utf-8?B?SjhoRjVJcDlnVE45bHlyTGR6OWtkVHZ6R1V0eUlPTGI0UVRJbjRJUHh1enho?=
 =?utf-8?B?MGVha252Z2o0R1dpSEZsQTJoamJZUndhajBPMmwxLzV1RGhaN0pvYVBCbjRs?=
 =?utf-8?B?aGVmSW91ZmgxaE95Zkczc0JTN3E2aVM0YzY0c1BtYmJQRkNLWDdhcjJ0VWRi?=
 =?utf-8?B?V3ZnUTI2MmNGeVZ6SG5ia2l5aExwVUc2ZG4vMVlGVGt0dEFOZ3J5TTM2NTJK?=
 =?utf-8?B?QUdMWnRMaFlVeEFSaC8wa29zK1pPQTd4akRnYnNBRjhvTjN0VWNwclBUV3Yv?=
 =?utf-8?B?MktBU2VIYVVTRUk4NjBidUlFM0NvSmc3U0tNdnJLQzhCNExwOWpVWjQ1U3pK?=
 =?utf-8?B?cFc4SVpvMDdPUHlUT0dSRUNDSEtWSjF6Vzl4V2JzNnRYZjA5cWFOL3gzSS95?=
 =?utf-8?B?NWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 041aa121-4976-474d-360b-08dd75b315c0
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2025 09:03:38.3065
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ckBWCFkDIebZGvJJ6H4VtRUCsZ9CD8uWZ320d5xrueG0xiznpdWMEvJRQiQkExu2Kbh05oEQMyUPuBwrU94PFvEk+ufDqVfLmLpg0JutA60=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8450
X-OriginatorOrg: intel.com

On 4/7/25 08:20, Oleksandr Natalenko wrote:
> Hello.
> 
> With v6.15-rc1, CONFIG_OBJTOOL_WERROR=y and gcc 14.2.1 the following happens:

have you COMPILE_TEST'ed whole kernel and this is the only (new) error?

> 
> ```
> drivers/net/ethernet/intel/ice/ice.o: error: objtool: ice_free_prof_mask.isra.0() falls through to next function ice_free_flow_profs.cold()
> drivers/net/ethernet/intel/ice/ice.o: error: objtool: ice_free_prof_mask.isra.0.cold() is missing an ELF size annotation
> ```
> 
> If I mark ice_write_prof_mask_reg() as noinline, this warning disappears.
> 
> Any idea what's going wrong?

sorry, no idea

> 
> Thank you.
> 


