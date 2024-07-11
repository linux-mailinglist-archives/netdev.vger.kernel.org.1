Return-Path: <netdev+bounces-110703-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 16A9F92DD4B
	for <lists+netdev@lfdr.de>; Thu, 11 Jul 2024 02:11:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97CE3281F98
	for <lists+netdev@lfdr.de>; Thu, 11 Jul 2024 00:11:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C3F3372;
	Thu, 11 Jul 2024 00:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nnkUAiK+"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6612A36C
	for <netdev@vger.kernel.org>; Thu, 11 Jul 2024 00:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720656687; cv=fail; b=CwqY9/duFptuPag6FxtI+tT1G1+UXbJli3dOdITOicmH5ry8nbyrl1UIV5GnPe5mBpqhoRK51PSzP5Wk0i8DrqAe7rl4LWv2yqmxV82+0Rd23YJa5dkL3zlb1an/4EG8F15gc3pSlhZ79f97s/TspQv2GN2G7ljPSfAu87jxcnE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720656687; c=relaxed/simple;
	bh=lWOF7VQOMECJOm81iOhmgefs/lvNjp9aB0SWCP4E+5k=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=JwSYpnBlpN14jYPCuELb9wAghtADzKbEuS0621cGqtOFR9N96ndHO1brmMrZ2gX1RXJlXa/RauYWHdhQT0REnJj+McECJL0XTtcmohOOnvrWgyLMXWcz0HUo4kcTuUh5IJIgX6gu3rxB6rog79UI8fX+g/bdszGi0XSNoL7PWmI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nnkUAiK+; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720656686; x=1752192686;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=lWOF7VQOMECJOm81iOhmgefs/lvNjp9aB0SWCP4E+5k=;
  b=nnkUAiK+ho0ELux3t7La146tWqgjWjSZ6iF9dpIbNcB+DmsOIQkf/pcc
   5aCwN2dUMlVzdtHP8nXlLdVnoEYqCDXjpdNTQ9DUIs70dFQXorSW43zY5
   nowksbPVa0FWNtwlYPm6lo9wLAZmXN32+kn/38B0T5htFedG4vLBEWHzt
   AMcyvlHliIQN4yFJT3p4UBWNkdK268BB5sw2xLEB2nZ3JKPcyHEHlbgO0
   jhBZUoSP7S6utAxqTVZuHxdTpU4M8ehWgcYIpEB5LxGdOo8pa+iYIIvVF
   wR5vIm9yerr17UEca7tom2ow04b4jUYU/rJdMxVM/Lgnn3ZQGjcxqvxmI
   A==;
X-CSE-ConnectionGUID: sl3yPKKpRVWKwmNrzoM02Q==
X-CSE-MsgGUID: ec/kYRWFTyOYEaTUOmYuJg==
X-IronPort-AV: E=McAfee;i="6700,10204,11129"; a="35446416"
X-IronPort-AV: E=Sophos;i="6.09,198,1716274800"; 
   d="scan'208";a="35446416"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2024 17:11:25 -0700
X-CSE-ConnectionGUID: Q4Uh0mbuRKOglyBmp3CUxw==
X-CSE-MsgGUID: 66+fisS0T6+mXtTso5pmHQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,198,1716274800"; 
   d="scan'208";a="53326794"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 10 Jul 2024 17:11:25 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 10 Jul 2024 17:11:24 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 10 Jul 2024 17:11:24 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 10 Jul 2024 17:11:24 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 10 Jul 2024 17:11:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H/xJvqzE/45pwY4qVKRVr+TcRny5qhIOjRZ8oyVKeruClqnHmvsA3m4JqApJwppqMdWBCmMeud79u8dQj3DODa5/y9JASbeWoY+PgAHdNfldNvS2KoPzsKsM9BpW7wjFHo/T4nfNY2U6bf9+laOvrNe4gc+2178Lh9WF+RduljGyoApGWaPmFJFR1MobhKE0aT9oLLRTT87MRCzSBlQhPQq+yE9Ee7vVYS6oR9AemyG3s/98HpHy3z5mL9ybtk+O0fxMXcAMVU2NBfKj7/W1UC/dyfE3H9TYQ9lCeRolgmxu4FkUfza9lO9FAEZzX+dh7SNU+rs0NlzIVqGUAbfdPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DZt1UA8Ss3eRetNXaqbY3v1oEF6n1xSPLJI3ltAQ9AE=;
 b=LpX/3O2Nyyh99Qb4O6X/evg7xjdHHL2xRWARmv2kL9CviyEum4OPc+Kx4WP939Q4U2vy87d/ld8QQDWHUVB7ZO7auMiCFvdns1SO6L2XPHJpLIRdZPAln9BEj/qFDCfKqgh3yUV2qOZhtohnKl7/3EFi2ohYdZ5cy3+fvh+pgmUo1gU2H/NrDYaOCoKuOKS7y2ngoZ6MMSGJ10CS2Cjz5GPiXVKH2e1AFnDJEtSE/UZSRJDo06cKNzDdqlGHan4zz3gNcmVAGUHRRgP/ybINSxIp3vt6drx7chJwC/CqDjUao5ZzHMe56aR0eehsKR1TR7IBkOlBCdjI6Cyn99iUzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by PH7PR11MB7025.namprd11.prod.outlook.com (2603:10b6:510:208::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.36; Thu, 11 Jul
 2024 00:11:13 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%3]) with mapi id 15.20.7762.016; Thu, 11 Jul 2024
 00:11:13 +0000
Message-ID: <61c11ce7-aafb-47b7-8bd2-9ce3eced1c81@intel.com>
Date: Wed, 10 Jul 2024 17:11:11 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] i40e: fix: remove needless retries of NVM update
To: Tony Nguyen <anthony.l.nguyen@intel.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<netdev@vger.kernel.org>
CC: Aleksandr Loktionov <aleksandr.loktionov@intel.com>, <horms@kernel.org>,
	<leon@kernel.org>, Kelvin Kang <kelvin.kang@intel.com>, Arkadiusz Kubalewski
	<arkadiusz.kubalewski@intel.com>, Przemek Kitszel
	<przemyslaw.kitszel@intel.com>, Tony Brelinski <tony.brelinski@intel.com>
References: <20240710224455.188502-1-anthony.l.nguyen@intel.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20240710224455.188502-1-anthony.l.nguyen@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0303.namprd04.prod.outlook.com
 (2603:10b6:303:82::8) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|PH7PR11MB7025:EE_
X-MS-Office365-Filtering-Correlation-Id: 761b58c4-7468-4840-b374-08dca13df96a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YU1XVHNUT2xYdndESlUrSUdMWkMwenREOGx6Y1U1RU5RMWZ4ekNIWEFScjFz?=
 =?utf-8?B?RWZ5TDhTcVN3QnBTdkEzL3pHNnUvbDI0M2xZVXpVVStYZFZFb3FLUDJySUZR?=
 =?utf-8?B?RWp3cDVVSkZPM2wybGlpbjYrYUdQazJpR25BNWNPa0xkRzVYa092Z0ZEZ2pv?=
 =?utf-8?B?RHZnVjdCV05YZHNLRUtyMmw1bGdsTk5PYVNMeGRTczJZKys2L2Y5SDZGVEtK?=
 =?utf-8?B?T0N5S3VjdHczelg0NndBY3BtVXVJRmQwNjhJSkVZVVk2S3RBRTVjRFlvcXBS?=
 =?utf-8?B?TzF3ZHBXSDNRaHVRQ2NyaWNubmgvQlZOM2dtWmtycng2emREcUZQMlVIS0k4?=
 =?utf-8?B?K0FtR1VNOVBkUTVxRDlPUFFXeUZ0WUtrM0xXNHR6eE5NMFREY2hNempZeDVq?=
 =?utf-8?B?TlUvNkEyd2t4T2dLdVVMOU5GRlhZMTMyWDc1Ly94VGR3V0pSZ1l6akJkVWRm?=
 =?utf-8?B?RDFEMnVyWWpWeE5CWDdiVTBSQVpwaEpsS0d0TlIwK3h2T1BiM0lFeERFWmZH?=
 =?utf-8?B?Mno2M3dLWStIbktjdHlWY2p2czlBajNsclpsYXN2QS80ekt0cEY0Wmk0TTdi?=
 =?utf-8?B?anRaQmUzYmdxQ1FMWGsyUVVibExLZnJPVWo1KzRobGtYUE5SL3RaOVFvdzU4?=
 =?utf-8?B?dHF3QnJ2SVpNTmh0VVg2WXF5eFQ4TDY2Y2lBT2YxMXFSNk5rRFNWVlhFeS9Z?=
 =?utf-8?B?cHczMUVEdWxkK3VUcUJIQWExTGg1SWlyU1ErVWZKbTlZVzJzeTZyZUF2elNT?=
 =?utf-8?B?Ulc1NVJtRmlXUFBjM0Z6WVF2OW9WbExWZ1VsMHNhNWRMYnkrQnh1MXBXUS9C?=
 =?utf-8?B?S2taMC9CQ3ZjSDQ0ZS9ZM0dZL291TWFMU3lRbm1aTUg5Qyt5eWRjTFVldmFB?=
 =?utf-8?B?ckJ5ZU1nbFlqMGxidmVPNy9PTnNlZ3p6ZjVXYnpxNmFISk1LWHZQeXJXOW1T?=
 =?utf-8?B?LzlJNzBscjd4TGkwTnpQTGpUcG5hbXdBM2JRcDVPRnZOblBPVG5wN05UbUVp?=
 =?utf-8?B?RElvZ2NDRGxTT1FmRy9uNlVyeFRyaHR2dVpRemh5eUsraTJsZUxRUFRoN3Z6?=
 =?utf-8?B?Q2tvS0lGaEhWQWU3Zld0VUFxOXQ0d1VXcmM4cEVETzA5OWo0ckJRdUlGVEZV?=
 =?utf-8?B?REJBczB1NjdDc05FZjZwaTdmZDBITFZMNGlwNjZYRGRHM2FRbE81QldSaGNH?=
 =?utf-8?B?NzhSTUdwdWtUS3F3MkZ0TGsyWUc3ek9lUjZmcHJCajNLblBVT3RIaytHc3Jy?=
 =?utf-8?B?RW1EL3IycTNXNEpyak55M3VJMmx3NWdpaGQ5M1d0bFJ5SlV4dXVqbDh2bHFE?=
 =?utf-8?B?ZU9BTTBoOWZPa3FQa0RoWURwR3VYekNzS0JTcm5GY1Vza2JKN2RnR0VjKzdr?=
 =?utf-8?B?djduNytRYkNCV2ZTZHhJOGQ5Z0d4SEVEa3NhYnBMaGNpeDNVWHZaeWw1Ujhx?=
 =?utf-8?B?ZkVzVm53aSszWWNqWjFtUDdqN0FjV0l5YmlSOXM0dFBXd1ZHdllSR3dFclJj?=
 =?utf-8?B?bmw5MDRxQ2c0QlJxYUZnTG50cjd6VE4vYmRycXFjTkE4TWhTNFVhc1U0SkJh?=
 =?utf-8?B?WXF4eEdGcVcwSzFlZWtEV0hubUJENzJ6SU51OWxxajNzdGJSV0hSZ2w2SFRo?=
 =?utf-8?B?N1IycmZKYUQ1UjBBTjJjWVk2bzVJZGN5VlVRVmhiYVN6R01hTTQzNXV1NFl3?=
 =?utf-8?B?Q1lwQmF6UHAzZHFyWjhwcVRkRlVtZUR2UklzN3piM2dFTXZvcGxqZzc2K3pM?=
 =?utf-8?B?V2R6OVcyQWVNQlZ1NUxIK2Eydm8yM3M1MjBBWk9mWUd4OW9xRGowc0tGTzVv?=
 =?utf-8?B?UnJtSXlZYjRIaHVqZXJuQT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ampwMG91UHJqZkdTRlhzRTV5MGpDdXZDZGJtKzI1eURSWnJrS2Y3NWwxbnRS?=
 =?utf-8?B?QnJVSkFyVzJnUE1YNGdzNmNaN1dOaWcwV25WeWtVOVVLNnhyUGxQdEdzSmFz?=
 =?utf-8?B?T3lOYS9EMWJnY2IwZkVrWUErZWVrb3BRRGdVMDdnRTR2MmdIOEVpdDRLWklR?=
 =?utf-8?B?UXdWbTlGUVhNMDRRK2FxeW55dmNZdk0rSGc1cWo5V3lvTGFNUmhIcFRTaHFi?=
 =?utf-8?B?ZHhsTk8vYjhDekNWVWM3WVBqbWx5dW1VOWw1WHFENDBuMnhBQktmc3k1SkhP?=
 =?utf-8?B?bTcrKzM3OEFiLzY2ZStJT3VtQVkxclE2RTJ3aFdEMEZHSGlYcDdKdU1wNldV?=
 =?utf-8?B?aEYxR3MrUDluWk5ReDByVTNVUlZnbHJ4eTBxVkJYUk1aWHNXRUxFSXZtQ3lG?=
 =?utf-8?B?QTFGcmZpSTAyL3FlNXNQZWlwZlBtSmxQajFPYncwczNuZkNrdE45TnBkSTZh?=
 =?utf-8?B?UndXMXRzd0ovNXRpV2huNnd5ajJVSjQwV0NCaElXRHdLMitFMkJDNU4yNEo5?=
 =?utf-8?B?NVpvYUxPZGZVcm9mU29LL0JvcUtDckREek5QZWt5VENaUGV4bnJ2VVp2dTlX?=
 =?utf-8?B?aGoyMElhemlnZTRrd3Q3djZvUlJPTUlFc054YTVtNHU0aExob3dsWkpuc0Uy?=
 =?utf-8?B?Y21kUjBqWCt4Q2R6ampyanJ3RDkyOWhQQk1TL3lZbTlGSHlMNGVmR2VYOCtG?=
 =?utf-8?B?Q0ZEczllV1p5ZnJVTW5zbkhHQmpveURLWFlEWDlqeDRyQVAxaXFjQW9hTnRI?=
 =?utf-8?B?a2Zta1dGWWszWXpTZzNMVk8vcFRVbzNUUFhFNUZsY0RkZG9qWDRWa3NHK0Jq?=
 =?utf-8?B?QnkyQ2ZuRWlKS2FhQ3JScHp3UEpKaXd2MFVEaFhhc1Z0czlhcGRrbmNrUXd4?=
 =?utf-8?B?bEdrazJkdm1nblF4cGw4SlRxeVB2OVJXNGo1NmptbFhLblZFalpOeFJhUHh4?=
 =?utf-8?B?RnlKSUxySmhlWmVOaC9HV3MxTzFKSTZTcStManc3L3dHWUc1WG5tUEc1RFh1?=
 =?utf-8?B?Tm83amw5Wko0eGJ5NllvOVdUZTE1bTJkMTJBQzFSbDM0djhibTdOa3BDRk5C?=
 =?utf-8?B?dXlNbE44TXk5ZjBtSTFKaUtDdm50MGJUV1BScS8va1lwUXFmMnZvTS9FcEMy?=
 =?utf-8?B?U1kvK0cwalFCT3dNMVJudjRLb1BWOWN0Nm1OUmFqeTZNWU9qYnBwUkc5VEdi?=
 =?utf-8?B?NnZ4Y0Q4MDM1dncwdGtLRmVkTmNvOFZsVVY3RWEwVWVnbGpWSXJJMXVxMFdK?=
 =?utf-8?B?WjdiM2pHOFcvTTl2ODVBbU5tb3ZBRFZOcnN0b2crUFg1cnJjZE1IK0I2ckp0?=
 =?utf-8?B?U2xzaDVwUzUzdS9MUmNmTmdOV1NCdXpUQTVFUHRadWxQL0YrSUtvNFg0RFZB?=
 =?utf-8?B?bjVoeGRhNW5EenBuQmo2bHVUQXlPLzZLYU0xeEhTRG4zTzJGaXB4d2doZk5w?=
 =?utf-8?B?K1dPVVVmZGRjRDRZY1YxUG5acWtxL1EyT0UvQmxYUUR1dzFOSW9ETGRHN1lo?=
 =?utf-8?B?TkNQWnZCTWlXWVJ2YkRNZk8rUUxOZXNVazdOdU5OMUFIbHBNT1l4cXRsUTNF?=
 =?utf-8?B?eHdPb2Y0azJCQW50MkRkTEpTSGtVZkNOL0xBMjlRNGxvOHJLZjB0R3NMZDNu?=
 =?utf-8?B?bHpaYkNxSEFhMHk1SGtEVG96YzFFYTEwZ2NXb2h0aFBRei80Z2FWQTRjbVFt?=
 =?utf-8?B?RjhVaTN6cU5TNk5pbW1Fc21GdnlkMmJyOE4wUmt0NUd4NE9ZOGFWQUYvcDJB?=
 =?utf-8?B?YXJSYndmN0d5SE9EejZuTDdHZDBOZjFIRUFnQ3VVMFBWM25GazlZb3duNWxP?=
 =?utf-8?B?ZXNEclNhQXEyR29hVWoxUVFzczNHL214Z2dyYkREckNRMW5sYUp4b2ZTNm9M?=
 =?utf-8?B?MitrWVloQkYzQkZTekMyanZERzFhUFBLNHlNc0w1NkpCNEdmZVhoWmdHMzFW?=
 =?utf-8?B?SUR4b0dPNnFJNkNRVFo2MWpTMGVwRVg4VGVSeGVoS0toa0llaE1Kc3NZM2h5?=
 =?utf-8?B?MUJPalVlbWZ4b3RLU1BmMDBueTFkbWVZWm9vVmxnMnJ2Q1lQbm91R1JHVU9x?=
 =?utf-8?B?UWFiMk1WMmE2QzdzWmRVdVdPdWRnS0NZVDRUaDA0WTNrc0xFYzMvdUpkZ1Zu?=
 =?utf-8?B?eHZlNURtSS8rU1dKQkpjWTFDRE9teVVuRTBJRGJFeTR6TzZZb1A5cHI5WTlw?=
 =?utf-8?B?RWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 761b58c4-7468-4840-b374-08dca13df96a
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2024 00:11:13.0207
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lLovyX24bHpF0AwYXvnfVl0fAcnLpD8aZuzPvvuN/oJWdPwGS26SvnWPe8VBWxcN7EGe4RrVDDkt8uf7PsaMggPohdSKyj++WJwL9Aacuo8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7025
X-OriginatorOrg: intel.com



On 7/10/2024 3:44 PM, Tony Nguyen wrote:
> From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> 
> Remove wrong EIO to EGAIN conversion and pass all errors as is.
> 
> After commit 230f3d53a547 ("i40e: remove i40e_status"), which should only
> replace F/W specific error codes with Linux kernel generic, all EIO errors
> suddenly started to be converted into EAGAIN which leads nvmupdate to retry
> until it timeouts and sometimes fails after more than 20 minutes in the
> middle of NVM update, so NVM becomes corrupted.
> 
> The bug affects users only at the time when they try to update NVM, and
> only F/W versions that generate errors while nvmupdate. For example, X710DA2
> with 0x8000ECB7 F/W is affected, but there are probably more...
> 
> Command for reproduction is just NVM update:
>  ./nvmupdate64
> 
> In the log instead of:
>  i40e_nvmupd_exec_aq err I40E_ERR_ADMIN_QUEUE_ERROR aq_err I40E_AQ_RC_ENOMEM)
> appears:
>  i40e_nvmupd_exec_aq err -EIO aq_err I40E_AQ_RC_ENOMEM
>  i40e: eeprom check failed (-5), Tx/Rx traffic disabled
> 
> The problematic code did silently convert EIO into EAGAIN which forced
> nvmupdate to ignore EAGAIN error and retry the same operation until timeout.
> That's why NVM update takes 20+ minutes to finish with the fail in the end.
> 
> Fixes: 230f3d53a547 ("i40e: remove i40e_status")
> Co-developed-by: Kelvin Kang <kelvin.kang@intel.com>
> Signed-off-by: Kelvin Kang <kelvin.kang@intel.com>
> Reviewed-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
> Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Tested-by: Tony Brelinski <tony.brelinski@intel.com>
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_adminq.h | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_adminq.h b/drivers/net/ethernet/intel/i40e/i40e_adminq.h
> index ee86d2c53079..55b5bb884d73 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_adminq.h
> +++ b/drivers/net/ethernet/intel/i40e/i40e_adminq.h
> @@ -109,10 +109,6 @@ static inline int i40e_aq_rc_to_posix(int aq_ret, int aq_rc)
>  		-EFBIG,      /* I40E_AQ_RC_EFBIG */
>  	};
>  
> -	/* aq_rc is invalid if AQ timed out */
> -	if (aq_ret == -EIO)
> -		return -EAGAIN;
> -

Makes sense. This hunk originated from commit bf848f328cf5 ("i40e: check
for AQ timeout in aq_rc decode") before the AQ return was converted to a
standard Linux error value. Previously we checked for
I40E_ERR_ADMIN_QUEUE_TIMEOUT, which is more specific. Now all errors
that were -EIO get converted, which could include a significantly higher
number of errors than just ADMIN_QUEUE_TIMEDOUT.

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

>  	if (!((u32)aq_rc < (sizeof(aq_to_posix) / sizeof((aq_to_posix)[0]))))
>  		return -ERANGE;
>  

