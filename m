Return-Path: <netdev+bounces-292455-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gKBrI8FgF2p+DAgAu9opvQ
	(envelope-from <netdev+bounces-292455-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 23:23:13 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DFE605EA640
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 23:23:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 29C933014664
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 21:21:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F8BB3B1EF2;
	Wed, 27 May 2026 21:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZZZI4N/C"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52D0A399018
	for <netdev@vger.kernel.org>; Wed, 27 May 2026 21:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779916906; cv=fail; b=l9tkDMKXepzH7ZbJpDsEnDhTMpErJPJm1s0OhfT6rb6nZpeQQIZ3O2upRAjDWm/r/ZWl0qbc3bczfDtxflxVCjk49UczXGp64NSfjSbK1ey8it2Fpxc8mXgb0X/IfvV0TTPouBeqBuYFo37j6n1cb8DzX4mixb1dWuKQa235CcU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779916906; c=relaxed/simple;
	bh=L6/XArdEP46FqS/d8EU8PruE5Sthkde/OulHO4UuSLI=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Tr/B9+kz6YZlHS2RvTX3pxNXWgG7/SsQZYgTyCYIJSYlHlByhOsTIv9fZRSVWn9Et/z0QSfcgxVPzD12MgNJ5neGDRdWdCEsddHGbjRkEIrmL+R0SGutLn+j6j49kf8QWNZUnH5pCvgVO4RA5CT1YpUTe9otWvDrOlsi/RZSO/g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZZZI4N/C; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779916904; x=1811452904;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=L6/XArdEP46FqS/d8EU8PruE5Sthkde/OulHO4UuSLI=;
  b=ZZZI4N/CBD8n2q+lb7Wukev+cR2Y3f6RLYGTYONqrfmXyThqinSphtHZ
   7tbCkRCB89dVPeCCuZFGzpGzFxITeoQRc54GfYmNMAc+NqQmCjIAXasYB
   Gz6/DPy6iOSeKDCf0Xv+391QnKZzSCfXsHcmK41ZnZdWh9JHmFg+yGqov
   hGcfvW1Aj0xhknyq6zHhVxbICLTet3fL3MP0mxWm3RZXHY4pJBfVq7rHf
   MHMTI7BuEyxgoXFL7wXYZtrgWmb89eRWfT63Qwi9oWXtez8DX96Bm4n4C
   26CMPtKWz1LuHie7ThZ+yFskA5XwhfvrOcUxkptmJGSMXVv3uzJ7J6xLk
   Q==;
X-CSE-ConnectionGUID: S0uN9HLEQc+wRlY0FOzXpw==
X-CSE-MsgGUID: yeTBRHGfQXOf3g7c/f0QTw==
X-IronPort-AV: E=McAfee;i="6800,10657,11799"; a="92234949"
X-IronPort-AV: E=Sophos;i="6.24,172,1774335600"; 
   d="scan'208";a="92234949"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2026 14:21:43 -0700
X-CSE-ConnectionGUID: fyH8nQ62ReKHiGxzn8xexg==
X-CSE-MsgGUID: oVPFwgZfSCGoDFOpi18CGg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,172,1774335600"; 
   d="scan'208";a="246383710"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2026 14:21:44 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 27 May 2026 14:21:43 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 27 May 2026 14:21:43 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.44)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 27 May 2026 14:21:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v2sGHS26aOXaVj7vql+gdLkbnxoSANCEAC/VzseEeSJm5y7i5BSuzn72Shg++ues2rtZ4cEatJ9Ktk8xCMxvIhitNwCMM3tStBXYNGjpiNnJJRkN+3n99ojJjEzlJQ7MPYxUljvhcRVtzJJqmgO/OPAqqrcIoqAZKdW+1t+Z492jKgflKFtFhZxRa6x4btwUT7oqeOcuaa6XZmcccFIlUBtytxsAkyIlvYlN59RKWaUkZx289ouq8ooniOoH+3c+y7Anqfy4wetjPSfj21290vlpgBn88bHhJZ4ChRgfkwOGh2R+6YusV32cyquOV8KNrSbuDUvUZ8OvoNPE3AssdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZnposLJs4aQ2gib4QLsNWoEPabmSlA1xg3AwY/A9zzE=;
 b=Sr+G1Srk2v42fYmoumLs33k9D85pcDSS/nGI/7+E4nN/UKGy9Z9Ykbq94jXzqMg7yYfHXP4jw96uytSawMsKfMBwsw27TtI9M8GgnFiW29FDWo9DTss+ibm4pOwewMHYH0Tdeob8qBGwt2+qJAvuWyfkh/T4vgbAJG0knYujctDnYlZoF7TYP5nqpzh0520QwSntcWJ5au6Cnk9rbojqcZndbSA77e8gWoZ8lmI/CYYMYcobRq+s646f15I8M3DDTkP3Cz2ub8ehg/FDlgVlUwO75qMZK53GrZjcwXmQFiLwSVHDF2dteQTpc4DZNfQdtEYPMLhtB4Vv6pPCBHZu7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8230.namprd11.prod.outlook.com (2603:10b6:8:158::21)
 by SJ0PR11MB4928.namprd11.prod.outlook.com (2603:10b6:a03:2d2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.13; Wed, 27 May
 2026 21:21:40 +0000
Received: from DS0PR11MB8230.namprd11.prod.outlook.com
 ([fe80::2592:f5a9:a751:be40]) by DS0PR11MB8230.namprd11.prod.outlook.com
 ([fe80::2592:f5a9:a751:be40%3]) with mapi id 15.21.0048.019; Wed, 27 May 2026
 21:21:40 +0000
Message-ID: <c6f6311d-6d14-445b-b5cf-e92ad8c17b27@intel.com>
Date: Wed, 27 May 2026 14:21:38 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-net] ice: fall back to SBQ when LL PHY timer interface
 times out
To: Przemyslaw Korba <przemyslaw.korba@intel.com>,
	<intel-wired-lan@lists.osuosl.org>
CC: <netdev@vger.kernel.org>, <przemyslaw.kitszel@intel.com>,
	<aleksandr.loktionov@intel.com>, <arkadiusz.kubalewski@intel.com>
References: <20260511095830.1095984-1-przemyslaw.korba@intel.com>
Content-Language: en-US
From: Tony Nguyen <anthony.l.nguyen@intel.com>
In-Reply-To: <20260511095830.1095984-1-przemyslaw.korba@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0255.namprd03.prod.outlook.com
 (2603:10b6:303:b4::20) To DS0PR11MB8230.namprd11.prod.outlook.com
 (2603:10b6:8:158::21)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8230:EE_|SJ0PR11MB4928:EE_
X-MS-Office365-Filtering-Correlation-Id: a174f0df-0e14-4f67-ba6a-08debc35f194
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|11063799006|56012099006|18002099003|22082099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info: WcNjEEAUD4iuWaPProsWtn/Tk5dC29tzpKHmdMhM8ppOqOa6lbbLNml8euzJ6tZrs5dU6Wj3Rmoq5JuerncEhD8z4lBpaFHSPyEoHfPNUwtA0a3drV6QqGyxrip5/aMfU/M9FiHR6z9F07mCbj7pGWvcTtSg7s2r3InyFKK4RZZIl27ncBrtogVrMX5pww6zPO2+V7WqZ+dTN/hShDHxNBmByA6TJJPFug56cpfX1hGnX8U6tmro7IGJ3llyrsmFYH+RvOejniNgCp7CaUEEbVJujwWGtxtuViMyS1nlh+PivMrmoKno+H3aGkkqB6RP6Ek4g63h0nezusd32zaRzVcAugrUUaTj/wNJEKKvuwLeLawJI4axiQy4ii4d8fdS27duVPmpFM0aDX15/lkrPVnyq/nuTagssHYe7Fo4VEiSUdzItrTgjdV74n6iqL0PP2IxWyHpof/sTHkqHCqLaZWmF7qgFF8dnkKrseAekgutTraILgaigwxDmgDqb6Kylo1T0USEQbWtap8lpp+xdzKEoHUl2kKek37F5QzfDegaHuzWCwsmZh+Dbl6V5xutm774zFHate4M8m7NcZOSWLH4nRP/ep4hYnZrIya0uy7w+GlWWXV3Pkxu4uplCNa/8EnzdDMYpM1FNLLduMi9OweYjHtzVdWqhxxo125V3rmw1ePvkjIgoFfgEcAczdVS
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8230.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(11063799006)(56012099006)(18002099003)(22082099003)(6133799003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TjN2ejZrVktLOG0wNWV5MFFsejlTaXhaLzl3c2czcWtBVElyeEVFa3ErY0lJ?=
 =?utf-8?B?eTVuRTY5OTl0T1FvMU9PSGpUSnlIUWk4YmV0dFRwQ041VUdRTUJQOFpyckwy?=
 =?utf-8?B?VUlIQzZ5N1VlSDBpVDNSeExmOEtSRVVIS0Ntak12NHVjWkc4K250blJoM21O?=
 =?utf-8?B?U0ZuVzFMdG5JNE00bE5IczJQWEsvaUFlVnAzM29EdkZxbTdxcFh2K3pDcDlm?=
 =?utf-8?B?YVpudWpZOFAzaElvUElZTXF5UEE1SE5zVDFOOVZRb1ZNcWcvclVzYS95dGRS?=
 =?utf-8?B?bzhGQjRmWTh6RjR1cWd5eEQ3TWdqekc1OEtKY0NHblNqQkVkZ0ZEQnpuRVVj?=
 =?utf-8?B?NHJzWnNObDBLSzBNcWh5anV2ZmJUMGpyR1BFVkMvbFRZMUFDOWVtVXg2K0Ja?=
 =?utf-8?B?ODhsV2laMDMwU3hWc0lJYUlqYXhZMFp6aDlIZWtoWmpPWHcvRWlNcHJjNUZp?=
 =?utf-8?B?di9DK00rdS9UM0Ixb2hkdUFaU3llWGloanlsUVFLTDBBV1g2ZDhSWkVCNkcx?=
 =?utf-8?B?TW5lbEJ3SDJRalpFSW02RHVLNDFQSzlWRzAxQTNnYWFyL0xiMHoreTRnbldq?=
 =?utf-8?B?MEJ4NnFyM1o5b1E0dmVMWW9sckJic1NUVzVzQUplbExaZS9lTGNjQnQ4UFhP?=
 =?utf-8?B?MW13WkRPT0J1OFM5VzJ0NFVxYlIvcmk2TDMvL2plcVd2R3UxdEpxZlA2VzNl?=
 =?utf-8?B?bEVWc3JzWU1QT2o5K29QV1U3QmlGeTJDeGZPUHdvTHV3NUd3VDBrN01sSVpW?=
 =?utf-8?B?cVhaK21KQTZ0M1ZqampLZTNIMUlJS1NnNERZWVE3TEpUYnVJSk8zR0FnSCtp?=
 =?utf-8?B?UHJ0MERBMUUwY1o4M0RZRVIvcXN3ZFIzR1BhdmZPTEt1OVM4WjRaSWlWNjVK?=
 =?utf-8?B?Nk0reTR1NnVia0dLK1FDTmlWVDFSN3lEekZTeDhaM0luK2dHeDlKcjlZeUkw?=
 =?utf-8?B?S3h3RnRPeTk5bmQyUEx1REdYV04zYjhmT014RXkrWXVteHlKUHhhY05EaUJY?=
 =?utf-8?B?MFE1VUpNYkpMS3dwTGpTbGhFdmFOV3dMQzJobWZ6UUsvNmExdnBTVWN6MGhj?=
 =?utf-8?B?ZkM3VkREQUNaVUFrYVNmN0F5RnUvSXQ0TlEzK1hQd2Mxd3NMbEd2YlN0VXow?=
 =?utf-8?B?RmVvYTJ4MmFldUxaT2lvMGpHR0Q0RWJjZHEwTHRkMG5GWjc5eTNsbGo0NWV1?=
 =?utf-8?B?OWhzWE5iNzdHTUF6Y2ptcitvS09ZeW14MFdJc2NrMVl5WjhHeXdRZjFLanJF?=
 =?utf-8?B?K3hVMG8xQXlGdGZWWlNzVXRkdmUwR09LYzVHd2RoN3YvUVEvaFpRWDVTV3pN?=
 =?utf-8?B?bWsrRHdGN3hTVDRRTnZZWHhFZUVIbEdpV2oybUxOZ0NMTUNyS0NKMCt4NWlp?=
 =?utf-8?B?UjBjQ1NlWnRBaUh2S0ttRXc1eHg4alZZbDF5WWo2aFU1dW9JelU2T2Y2cmgy?=
 =?utf-8?B?cGIyYnZqVHVPQjJXOFBHMFpqYlZlakNQaWY5Y2IrOWpnT2NQQjZibFArbVRl?=
 =?utf-8?B?SUpYTSt4QUxuNkJMajN6Y0JpdEtRTGVrb21UVVNaaFVqSUV1Y3hvQzBkV0ZT?=
 =?utf-8?B?QVU2TWV5VThtVDNHdWdSSnp5S2JTTjgvL3RaVG9QL3M5WXdCd2M0ZzFNaXJM?=
 =?utf-8?B?elFvdFlXdlkyOEJHYU5hWEF5UytPVUFyTzRPU01DdDJQZGxaRHhHMFZLQ0ov?=
 =?utf-8?B?UXcvdSt5TWVYZWdBMVFHUk1od25Rbll4dVJ6SFJHMEpTV1JxcTZ6VkNWUHlP?=
 =?utf-8?B?N3kxL0lpT3RXZytmVFMvVFAzNmYyd1FTc2JySUpOdFlONkpXb25vSlNFNDZ4?=
 =?utf-8?B?UkNmL1lvL3hXVXhsYlBIWDFjK2xPQVFpaWZ2aGlUZUVLZlk3eHdUaE94NzQw?=
 =?utf-8?B?RThNbDlMekhlSTZORStBc2JHMHVEdWpkRVU3TzUrOThaZVQvZTVYRU1rZXR6?=
 =?utf-8?B?WHNIU3FxWmU4enRYMzc1TlQxYUlVYTM3bDJxMFBUQ1M2eTQvaWJndVlPUFc4?=
 =?utf-8?B?bzVIendKQXJjSTRoQUFwZXIxTTUyQmtBMlcvbS9uYzZMYllyaTNjTUNKQ2hk?=
 =?utf-8?B?clBFR3hCcWl1VzN4b2YwemVVK28veFhaTXNGeElUYy81d28wbTUyeU5QSzVj?=
 =?utf-8?B?RXlOdWlqVnhFMG1SNEVFZzBLV1dpd0dZTklnaGpvV0JRZUNjTHMxNzhHUGZB?=
 =?utf-8?B?S0JPMDBkbHl2ZzN3dFFMaXVsMEtDSFI5UmZNa0pkaWcrWEJIYW41N0J4dXhI?=
 =?utf-8?B?aTh6WHlzSzRnb2lnU0xKWkVYNkZBN1NLTng0NlBlME9Ga3FPVlM0WHBERy9U?=
 =?utf-8?B?RitPYmJCNzFFOTFLNWN0VXRNcm1NZmhsYmRsRXFNcE9FOWVyTVpkSnVzTGxR?=
 =?utf-8?Q?nE1pADEF/sXRMwp0=3D?=
X-Exchange-RoutingPolicyChecked: GsfhKHM8z49ibI6ZLazDbkMvS0YgcBWUEDYwHm96n1MA8YLK+muV3YLGcb5zT5oPAZgbIZbcCaC1jcfQoUDoGsP+m7+NegmKJwQNL1sAKtRhMUUEcpluLGQ9jdWW7tOA9vFpe6spz/lgvz7KmskjDth8FKRwotnINGq/vcxuUvIxHaVvcLkm1zyVzZYcXs5659/m/z4vXPaiW3TN64iJSVSt+LWv2+hma1Ua105ImgpIK1Ew18wste3MUTXN67AW306IJ9P9DBeUn4UYD9yatKI7sFA/3S9df85NqKYXexA4Bl6lTJl9Q1EeNrHXo5LfnelymjSOzXmNpJA+25xbrQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: a174f0df-0e14-4f67-ba6a-08debc35f194
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8230.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2026 21:21:40.7283
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B06OKYayN7YEjKWYlGNGUdTf30CwyMkcZMJJxst2meQAAg+rS57xhhMAHHNjc8RKmNWSs1FRAD2a4ri2xAgWwFJ5if+ZhWYwXvmN0AWtppE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4928
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-292455-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_NEQ_ENVFROM(0.00)[anthony.l.nguyen@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: DFE605EA640
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 5/11/2026 2:58 AM, Przemyslaw Korba wrote:
> The low-latency (LL) PHY timer interface relies on a tight, atomic poll
> of the PF_SB_ATQBAL register with a 2ms timeout. After an NVM update /
> EMPR, FW may need significantly longer than 2ms to start responding to
> ATQBAL commands. The first PHY adjust or incval write issued by
> ice_ptp_rebuild_owner() fails with -ETIMEDOUT.
> 
> Fix this by falling back to the existing SBQ-based PHY register write
> path when LL times out. This makes sure PTP is initialized when FW takes
> longer than expected to come back online.
> 
> Steps to reproduce:
> ./nvmupdate64e -if devlink -f
> Update E810 card with nvmupdate64e, and observe dmesg errors:
>    Failed to write PHC increment value, status -110
>    PTP reset failed, error: -110 (-ETIMEDOUT)
> 
> Fixes: ef9a64c07294 ("ice: implement low latency PHY timer updates")
> Signed-off-by: Przemyslaw Korba <przemyslaw.korba@intel.com>
> ---
>   drivers/net/ethernet/intel/ice/ice_ptp_hw.c | 40 +++++++++++----------
>   1 file changed, 22 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
> index 2c18e16fe053..9cd323bd9739 100644
> --- a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
> +++ b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
> @@ -4771,15 +4771,12 @@ static int ice_ptp_prep_phy_adj_ll_e810(struct ice_hw *hw, s32 adj)
>   				       !FIELD_GET(REG_LL_PROXY_H_EXEC, val),
>   				       10, REG_LL_PROXY_H_TIMEOUT_US, false, hw,
>   				       REG_LL_PROXY_H);
> -	if (err) {
> -		ice_debug(hw, ICE_DBG_PTP, "Failed to prepare PHY timer adjustment using low latency interface\n");
> -		spin_unlock_irq(&params->atqbal_wq.lock);
> -		return err;
> -	}
> -
>   	spin_unlock_irq(&params->atqbal_wq.lock);
>   
> -	return 0;
> +	if (err)
> +		ice_debug(hw, ICE_DBG_PTP, "Failed to prepare PHY timer adjustment using low latency interface\n");
> +
> +	return err;

 From Sashiko:

If read_poll_timeout_atomic() times out, the REG_LL_PROXY_H_EXEC bit 
remains set, meaning the command is still pending in the firmware queue.

Since the commit message notes the firmware may just be delayed rather 
than failed, will the firmware eventually process this pending command 
and overwrite the shadow registers?

If the delayed firmware execution completes after the SBQ fallback has 
already applied the update, could this regression cause silent PTP clock 
corruption on a subsequent synchronization?

> @@ -4890,8 +4889,13 @@ static int ice_ptp_prep_phy_incval_e810(struct ice_hw *hw, u64 incval)
>   	u8 tmr_idx;
>   	int err;
>   
> -	if (hw->dev_caps.ts_dev_info.ll_phy_tmr_update)
> -		return ice_ptp_prep_phy_incval_ll_e810(hw, incval);
> +	if (hw->dev_caps.ts_dev_info.ll_phy_tmr_update) {
> +		err = ice_ptp_prep_phy_incval_ll_e810(hw, incval);
> +		if (!err)
> +			return 0;

Looking at ice_ptp_prep_phy_adj_ll_e810(), it can return -ERESTARTSYS if 
the wait_event_interruptible_locked_irq() is interrupted by a signal.

Does this unconditional fallback catch the -ERESTARTSYS return value and
inadvertently continue with the blocking SBQ path, rather than 
propagating the signal interruption to userspace?

Should this fallback only be triggered when err is -ETIMEDOUT?

> +		ice_debug(hw, ICE_DBG_PTP, "LL incval failed (%d), falling back to SBQ\n",
> +			  err);
> +	}
>   
>   	tmr_idx = hw->func_caps.ts_func_info.tmr_index_owned;
>   	low = lower_32_bits(incval);
> 
> base-commit: 80b47e88f7ead00b0795e9f2833f1d0cafe11d90


