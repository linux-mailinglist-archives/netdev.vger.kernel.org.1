Return-Path: <netdev+bounces-293761-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sEiKJw2GHWrAbQkAu9opvQ
	(envelope-from <netdev+bounces-293761-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 15:15:57 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 789F061FDF6
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 15:15:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3025130063AF
	for <lists+netdev@lfdr.de>; Mon,  1 Jun 2026 13:15:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9F2637FF41;
	Mon,  1 Jun 2026 13:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BF0BvM5S"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8F5A378D7F;
	Mon,  1 Jun 2026 13:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780319705; cv=fail; b=KhA2OZzSw/C4nrgXRQqYxLtWRGOVHdAzK+mwUiuAvvibzHzcbOz+YTXXOdmGB6R3GYnThfxfvsqoRSv9IGWHZ7yoE5V0bbdf67nU+MMm4AqQCuSieAiueltU1QhmRZ3vLDy2lXpTecbrAYSUR5Aqp5YsX9y2ewPeDBmxzPKatts=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780319705; c=relaxed/simple;
	bh=A99HkwgBsxb/b5y9qePNuahF44T6G2gOZLzQOdTaamA=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=VHWxcyzp/MwUpYZjqUJlKXvQmOOfqpV2DJC6qCPVTinzxzB/2nj+xp+eUCYNMaCZX5/sL3gO60VCSrJVpmxYgeZjSE8BmEvFWHMm6Eto7PYZUCCrPuJZ5Ak+2q7ICCFxfexCvwbr9iS2cLI/ziCCtNFGy+cJ9rfYJ2ZOxCJAtdA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BF0BvM5S; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780319703; x=1811855703;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=A99HkwgBsxb/b5y9qePNuahF44T6G2gOZLzQOdTaamA=;
  b=BF0BvM5SF3qKnRnh8Ao95c9sAuh3x3s4XtTMX7Gi1dOoJmrFnPyITVjV
   h9wF+DRlqFNw4UY9JuQeTpTUXfYf+ePxc/ROGLD7TAHUAty5pw0pSOxVn
   ogQugqOWiG1pmFIqtZU1fs2Ky/ry5v+yrMmqGp4BP0lXcWO4NWE+P5HTN
   xNNZUkmKsptv2L3g0heOGt+vmAmxPs1JbtI78dw8bY+Rcv0aT3/KWO7bN
   jKh0tIdt8f+xZROPfKVEagLoVyC9IACd5yi4d647ODkQJcl2PqRGmt29Z
   Drv9wrbo0QfhFB9ERPBuv58NO8lYdRyMSGuY/Hn0OtCnoLqNPXkE2z8Xr
   Q==;
X-CSE-ConnectionGUID: ROpjdQRPTEa09OtH5zFaIQ==
X-CSE-MsgGUID: YJte+G/QTECpDRkCJKWD+Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11803"; a="81135848"
X-IronPort-AV: E=Sophos;i="6.24,181,1774335600"; 
   d="scan'208";a="81135848"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2026 06:15:03 -0700
X-CSE-ConnectionGUID: vJdzJKPwTISZ68CPebb1Fg==
X-CSE-MsgGUID: 0GiPcOVLRwe7xzIVpW9Gdg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,181,1774335600"; 
   d="scan'208";a="243670347"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2026 06:15:03 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 1 Jun 2026 06:15:02 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 1 Jun 2026 06:15:02 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.69) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 1 Jun 2026 06:15:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FRL9Um3y6aW9I0C4Vf9P93P41nOZEhZSHArXI7pYp8C8jJE/kYKA3Pmb8UIrwylpNgVzEH1ea1Sk3B/0NFEM0Cg3zdZIdCpIZX86TFaRopGzQvhOcKSx3LYrUy2QZXPA++RgJKM8Q7IlbCv25Hm2lNyzaaaJJ883MEEc7v/dQq8gWFM9xHJIn3h6tZp0tVy8SEwYALPKpbVNWiryfisHEunT4fRNTvgHsXSkrnu3o7nnQV44wRhMEI+GFtUuN7YD+B204MmaO6bgzvPnHV28s2GYNiqvkzQZGsN6hWdOCqaksqJ/AHeVmCimtWw6Zmtrol/hqPmdU2rJasbB7ZHDqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K0XgRrqDBui2/fsA74AWFtxhNSSGbiqhnb9mHjNmSC0=;
 b=F6yAufGAne4V/7Mm9EzfCf9YYMRo7c1Lz4k74kqotznKE0Z1OHPYoqdlJlXZsQ2fwy9nryS/S+CbiJNO4ZqYR1D6JYKbOhM/lD5K83yPY38LGSnmjXgQhpO6SwYrHkGv+16YmPP0kP0gNEbAVqLYBsS5eMo+hV7vZG/KPfLB8lnipcZ6hNsfuEPbljKrsvxfcvFBfbBF8MR4ABddwqrp2z3EEooenCgIzQVKZNugFB3BTN8kZUlOHnpYDvtjLCsaeYX2K+6slSJVN019A3llFZ//qFz94OCqU+MC3ZHR8UDvfSqpAhXQw+DY/+3hG3Oc10NvG7a/QreI//PZOdHWsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by CH3PR11MB8188.namprd11.prod.outlook.com (2603:10b6:610:15e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.16; Mon, 1 Jun 2026
 13:14:56 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::6aa:411d:4bfa:619c]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::6aa:411d:4bfa:619c%5]) with mapi id 15.21.0071.014; Mon, 1 Jun 2026
 13:14:56 +0000
Message-ID: <f4b96c08-c6f7-422f-aceb-aa48fa2bfef6@intel.com>
Date: Mon, 1 Jun 2026 15:14:50 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rtase: Avoid sleeping in get_stats64()
To: Justin Lai <justinlai0215@realtek.com>
CC: <kuba@kernel.org>, <davem@davemloft.net>, <edumazet@google.com>,
	<pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>, <horms@kernel.org>, <pkshih@realtek.com>,
	<larry.chiu@realtek.com>
References: <20260601062447.64027-1-justinlai0215@realtek.com>
Content-Language: en-US
From: Alexander Lobakin <aleksander.lobakin@intel.com>
In-Reply-To: <20260601062447.64027-1-justinlai0215@realtek.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZPR01CA0028.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:46b::7) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|CH3PR11MB8188:EE_
X-MS-Office365-Filtering-Correlation-Id: da08f169-e6c8-49df-13a7-08debfdfc64a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016|6133799003|18002099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: 3dAAhzP0zLLnffKwjSvNbDYD6cQxvW0QMyD4ItjwC9b/+aAaLPrHnqmc7L5GE7VVRXPDjwI5tpuF1tatycfKyw9GR4D+THipX439hPy1kIpEf87T+0HkLA9B5gdZ+Y0tz5r9F0vtmpVIiZsDdX7K2LJRdl5nJ4hd/Dutr6iwWP+hw4Mr9+/W8FKDIIgGhJbx/LWlzyYzhHr/bk2t4c9ajbL/Y+iyVc+A2RQUEO6tfpoBJJMO2swI/YHrE0frRNCI7GJN/oFzvq8u+VCN+mhn49kIuJvZUooQGc6NLG684DjiChxcZPCLtKKPXh3/n+hZsHfoS/Aculn/4PqzeJoRhbDt85JFpeZE88cQVwObfwjO7/yUxlv0xI4EGfOdEQdLIpDYdT4Wrp3CeS/czBVZjsmmA9xZ5zOrACvRgqE+ijhLK7JN8XpNXfqmkUslx1WSXi4fJo64vbst8F7RR4MVPOV/7St9CKIdCvrsb+15wRa3C9xJy86mQD3nLfhiK08CuyfPBRas88ij7qY1HsCWjGA0im2CQNDo/GbpCsZp0MOqhAqkjIdFmZ9G8MEYnKe4anPLgHhzyTIcJqfzqy9DDV1pX/XZ0N+nJEzrOxjjEWxtGOKKs+8cGzbCqnw9SZmf+nhjXFC/nTFCP8KUMRm5/9o5DQeTwHii/3Miu/XnChHfDAKDLQStpYXmwnnIjj4qwFVuQtrF1rPXus8tEi8s+A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(6133799003)(18002099003)(22082099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NHBYZXVBQm55SytMUlpWeFZlaVpkTXdqSXdlN0xCMFBDVzBwRTh1MTNJSUR1?=
 =?utf-8?B?c2FFVXh3aFNhdCtBZ0dhdGpFZlBucUdGVjRmTjB3TUwreWxFR3MwRTdmVndJ?=
 =?utf-8?B?ZWZKM0p5SisvYUNscTBMc3c2QXdjNk53cFBLVWczVkM3S3VrS3c5N21YWWxP?=
 =?utf-8?B?OEU3ekQ1NG50YVkxazA5aE0rUUZWNm1WQ0NzbDY0ZlhjelV4b0JaOHNhdEp4?=
 =?utf-8?B?UmdZbkwzT0JuazJ0RmdqNDZnenhzZDVNUTdRdmdLb0h5NzdRMWo1Q1NJUmRZ?=
 =?utf-8?B?ZFQ3c2IxamdmcVNhYzZDOHFodHk2R1BVNUtrRFJKREVkR0R3dkRYUGNkamFs?=
 =?utf-8?B?ajdNR2RoRy9QaFI4RDUyVjY0S1BRcld4RE91cklwcERvbCt2MjgydTM3cmw3?=
 =?utf-8?B?MGZ1NHFRUnJ4WDI1Y1d1TjdlKzFJOEpFbmRPaG5vYWhVZVVONHpDQTVXQkdT?=
 =?utf-8?B?SVB6b05hT0Y0SHpVbWVGYzV4T2lJdHlKQldrYVEzVWlrS0l0eXhSb00wUlZa?=
 =?utf-8?B?RFFRNUxTci91SG9TVHNseVJ2cjNvRzl4Yit3ZEovTnZtTDRTdzNnL29KSFBS?=
 =?utf-8?B?U3VyWVFZMWVOMzdMZy9OeTZLOXpZMk9pcGVlWFZEdlljQnMzNDJiM1Azd25u?=
 =?utf-8?B?Wk45VDRobG9BQzZVNmNJZnVwWXJRZTBkY3RYODhRbHMyR3g3QmxNNmQvRS8v?=
 =?utf-8?B?RXRqWWhkZFRZV3BucmxzZlZpSTBiNGpkU2VuZ0pLQU92ZUFmK0pmRVpiMGJr?=
 =?utf-8?B?THV6dzNTVkhUeTYxTUloYU01RWFFNFpZWmR0Zm5tcmNsT0tPL01aN1FmVEdK?=
 =?utf-8?B?S25OYlMzUlNSM1EreVFRaTcxdlRCZ2RCYUpqdEFOZTlKVUJibXdKam1ZZjRk?=
 =?utf-8?B?b281QnIxM0x2QlpJWUw5WWhYU1p2MjhsYXlMSWJxTnhTYmFXYXdGUGlNUm9G?=
 =?utf-8?B?bG0vN3BhbU96VjFJeXEydnpSYk9xWVQ4cWpvTktERHBFT1dwcWl2TjUxZjlv?=
 =?utf-8?B?L1VXWDBYbkZRTFhITVhkcktGOTIyaUtHaFVlb29KbUpjWnFTbERPYjRvRU44?=
 =?utf-8?B?NjVXNEZ0cWNLTk03eGM4YXJsR1RheDBVNkRKRmJNQ0RSbDBRSnd0dzRpZ1Zv?=
 =?utf-8?B?aDJrUXozL2d2TlpnSmNaT1IvRzBJUWR1L0JESlZxVGNrTi9Ca2QvOXVPS2JE?=
 =?utf-8?B?R0NLMitRN2poUWF2QWRoN0Zlb21xNXozcngyQ3V1NEFYYm4yVGFkTzNkYld5?=
 =?utf-8?B?V3FLMm5aQ0JTL2doKzBScWdpam5hbHJWblI2N081bjc1V2d4a2g5czRIS0JO?=
 =?utf-8?B?T1NHQjQyT2lHNkhGZEt5b3IxbjFtSG9yK0tGekVpcmNtMm5zeTRxeXBDbU1R?=
 =?utf-8?B?TUJ6RmNxZVZDcE1kd3FkWVRHd0MvVWhsQnhMdjhLR3BxaDFta3dER2JtZXZ1?=
 =?utf-8?B?YnBXVVRDdlY0U2F3U0VWNWtaeEpDdUw3dCtaSE9hS0E3QzQ1TndTNkxxKzcy?=
 =?utf-8?B?ZEQ4WkNFbzY3TS8zaVBYS0llOXZGQ1Z2MVpRWnBXQ0U2ejdLOUxuZEh2N0sw?=
 =?utf-8?B?YUN5ZWN5RE5XUFVTV0xJcHRBc0IyUnFMSjR3WFFqbVBmTG5hV0ZNbWlTVnJp?=
 =?utf-8?B?WlQxVkx5TWtBV1VEVEk5azJidk0ybzN4ekI2UFAwZjY1SFBUcWlncnY5Tlha?=
 =?utf-8?B?UkdCOXZYckVrZ1RQRjdkWURxS0kyd1laY0g4RnEzajJTeUtnVDE0UTZWVUJ5?=
 =?utf-8?B?c0UvSUFlMHowSUQzRmRvNG9RY3Nua1hmOXcwQWtkU0RZTmZpcU1pekN2OXZm?=
 =?utf-8?B?dnA2bUt1OHZwNmJUblY1Y2NjdHhNZmw2a3pQMHZ3cWRUU0pjODFHVWNoTHpx?=
 =?utf-8?B?MmZBZkJ6ajQySmdBSDcwRENVWjZmd2QvbjFXQXdCKzFVSlplcE9WSmdXWlYr?=
 =?utf-8?B?b20wRTlaNHBLM0xTc3JWcU5OMTdENGpxNDJDcis2N2swTTZNaHhHcTljaWtS?=
 =?utf-8?B?czBsblorSlZEZmgxSTY2dEVXT3FremdjTFF2cDRlakFUTUFWVXdWTyt3OCta?=
 =?utf-8?B?MXdPSWw2a2k5NVRwT1kwMmV4WmVUQzB0b1ZZUjN6OThKc1pXZ1pwb20yLzNJ?=
 =?utf-8?B?Ym9mVHcrRGlIVjRNaVMvd21EYUVrb1FhNHdKOHd4ZnZOdDV0Slc4ZUpqZEtU?=
 =?utf-8?B?VE10b1VMQkFWQlNPWGl1QS9zaDhBTTdDU0t5Vmxza0JBK0U0L2xiSDI1Y0JW?=
 =?utf-8?B?R20zcmdvZXUzZllDSmpvS1NzKzYrbTBieDNkLytzYktUbnQ3VE8wS3pRSjFO?=
 =?utf-8?B?d0pZV3lDbm0ydnNVOURmMzFjbEpJVFhVL1RKa1N5bUFhM0E0SFNJdVRab3Rn?=
 =?utf-8?Q?HANwcm796HiGP7KI=3D?=
X-Exchange-RoutingPolicyChecked: FK3yKd+d6AkULWs83RmvDu/FEM/D+lqrHtbwtF1h7z0iH2i6qdGslpJISE1PXPtmcKdpgdE5rurESU4PF8IeuuKk/hGKY2Dz/NueCKIbu6hwezR+p8VeltNhheR8d+uqzfs/U05PYE6bdEQZc8aJj7RYJRpbXkl2g+60r4FgHxW5SLVAQc2adFkPG9CjIC5+lUv46k3Tf7VXUDS2ZYFPn7sVZBgA+2kCTGnrTKebJKkrHyYGjZcG7h7tcp/8FAzQuc4Fseb1/SNvWewkjoPHJtqX6O90ZebNolfg9Rs9Bpgvdt/fYzD1yxqrtDX8kpOcRxtsHipfOEOH4tz9MRs+Eg==
X-MS-Exchange-CrossTenant-Network-Message-Id: da08f169-e6c8-49df-13a7-08debfdfc64a
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2026 13:14:56.1237
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X4F+BAIJmNAgK80x+Msd0ap6/6h5ZMX+f+isOUpScypCYQl/mA1Le4ThkIDaSq23R8jhgvTj4xPANWla7BPFpT2t9DV0DpCivgskstwShc0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8188
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-293761-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,intel.com:mid,intel.com:dkim,realtek.com:email];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aleksander.lobakin@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 789F061FDF6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Justin Lai <justinlai0215@realtek.com>
Date: Mon, 1 Jun 2026 14:24:47 +0800

> The .ndo_get_stats64 callback must not sleep because it can be
> called when reading /proc/net/dev.
> 
> rtase_get_stats64() calls rtase_dump_tally_counter(), which polls
> the tally counter dump bit with read_poll_timeout(). This may
> sleep while waiting for the hardware counter dump to complete.
> 
> Use read_poll_timeout_atomic() instead to avoid sleeping in the
> get_stats64() path.
> 
> Signed-off-by: Justin Lai <justinlai0215@realtek.com>

Looks legit.

One question: for how long can this poll for in real life scenarios? Up
to ~1 ms is okay-ish for atomic, but if longer, then you'd better to
split it into shorter polls and reschedule() time to time.

Thanks,
Olek

