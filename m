Return-Path: <netdev+bounces-187160-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 06B2CAA55FD
	for <lists+netdev@lfdr.de>; Wed, 30 Apr 2025 22:47:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3ACE8189B6AB
	for <lists+netdev@lfdr.de>; Wed, 30 Apr 2025 20:47:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF5BE21507C;
	Wed, 30 Apr 2025 20:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hSGMDL6C"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC2371E285A
	for <netdev@vger.kernel.org>; Wed, 30 Apr 2025 20:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746046022; cv=fail; b=ozlcqE0sltdQ4+FFPxB1/fShUFar2YcEQhj4yb6RbWdCdYvtOVPHsJLPFk7Z/nwygOPIShX+YlLeTIrgrzV5lP8gX0hR7XzIXuU9+mn8muQ5Jgljx79LCT8hs47DMz22Jugb/SUhaR9F8juQb11vwde3dXu9c+TzIgFxGnig0iA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746046022; c=relaxed/simple;
	bh=75yELGGBy478ffATtGVcOBW/TPrmYNSIVdgMdzq1fVs=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=nwxrHJWKfAG1OCugpjXYcRQeE3eJomCxBI4fQYhvm/jVwPJJM7oH915WtrH2yGVAD4IGvw209Xcbhmhej1DcluUsj4rMqG8hovO4kvGVeA4TCL5CK+20DSqw00zDm9whqnyKMvfDfsqjWYBai1XgCs1oMMgPBqiWgkvBpscLNIQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hSGMDL6C; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746046021; x=1777582021;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=75yELGGBy478ffATtGVcOBW/TPrmYNSIVdgMdzq1fVs=;
  b=hSGMDL6CxrGKHiqC7e/CK7Q+onNhkPXIoWz2cXAZYZjNoxKClGjThTGp
   8b3M9sJOS+mxw5uy1TghanAnSljVGpGYMCZVMSv11J7snu0u7oFQCTuGP
   9pXsGXth55Dbxum7uZIzKdiHYMeKpbCK3WyQpfloa4CwgNzW58cu17Prn
   xAWMtS3n/YbkvRE3/4Vil6JOHdbdYXVf8lJPOmnmfpD9oVUvcmzweoBLF
   YsWL8wXYozI90cJ7C2gVVraQgZ+I5k4vpxq0hPwb0PsygUQnNxIQ3AaKk
   P1e9jdXvfnBII/WymFofBe/vt2ZjOSOYbndeSWtSUObPVdSLxW9h5DWpO
   g==;
X-CSE-ConnectionGUID: gkj/NTpgQJGiVxFmR2xe4Q==
X-CSE-MsgGUID: bsOfzpGJSrip9h+bUzM7CA==
X-IronPort-AV: E=McAfee;i="6700,10204,11419"; a="47862549"
X-IronPort-AV: E=Sophos;i="6.15,252,1739865600"; 
   d="scan'208";a="47862549"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2025 13:47:01 -0700
X-CSE-ConnectionGUID: AppTnMbPRJSld1rpz3/Mig==
X-CSE-MsgGUID: /8leIoOXRCCSLBtq0oSggg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,252,1739865600"; 
   d="scan'208";a="139195260"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2025 13:47:01 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 30 Apr 2025 13:46:59 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 30 Apr 2025 13:46:59 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.170)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 30 Apr 2025 13:46:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q/fXKxDlIHQo4dzI/WoE/Rfp0fk5TBx8cJImdPf3NUFPsLma29Ns1hOzzITN+o3WiuQ5pI1wp+u0l0rdcN/0+NTyVZ1DlM/dl0iej7qgA+WPEiZiPzPxdhNzFg813XlUHv33pRQMSLDLl4M6tP+2cdNYXexUiD7umiR7++0eu6SXs/eXusNJurypVqhczxqhE5k8SvUZ7v85WUy984g0kBVOj1IEWaCHRhoppvwWQBRiwgiKgQg8uTQRVyjGM+W6idyWEraJGfU308TMPn/v5lN/SqqxdqGGck7NIMHKy8ZRDVFRpZLybtaS9fMmHtLtArUIUgjPpfO+yEaZ2OikvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4UYj/qsoC3jnsOeIJqFWcJT3wt2pIL1qXsW8ExSXIao=;
 b=uo4p86xmEVd/D4xNUADMMjKXooSFn24fHZi/f9ru0ANEr0dm2SghibUzQfcwkqG0CMnJeAig7EWM3X+WN7fxAQS4SHWzhlpR9QYegw6A6Xz9Mq4akMeAB3nhG1IKj7ahMGx9SHbKi8V+sjCF/4yuUmy/e9J0v96sQj6QbmhbwDUbFcyJTo52x7HlKuvzU7lLS9ut8zhEkZ3tdetyuj2h4I0hMTvSkjTL0+Xg8ucDZ2wrjBBW1Mg9H7zdgFfkGuKANp3iw6WXyOjy5QAZbEl6qVSBkcgtf32m/4apd9Tg0JYQbc9jtVebO/7WW6xn/XVqVZDZWmuTxO2e+4DUCYtcsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by DS0PR11MB8161.namprd11.prod.outlook.com (2603:10b6:8:164::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.34; Wed, 30 Apr
 2025 20:46:55 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%5]) with mapi id 15.20.8699.019; Wed, 30 Apr 2025
 20:46:55 +0000
Message-ID: <9bd2332c-72fc-4d75-b498-87f4662824d4@intel.com>
Date: Wed, 30 Apr 2025 13:46:54 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] liquidio: check other_oct before dereferencing
To: "Alexey V. Vissarionov" <gremlin@altlinux.org>, Andrew Lunn
	<andrew+netdev@lunn.ch>
CC: "David S. Miller" <davem@davemloft.net>, Derek Chickles
	<derek.chickles@cavium.com>, "Dr. David Alan Gilbert" <linux@treblig.org>,
	Eric Dumazet <edumazet@google.com>, Felix Manlunas
	<felix.manlunas@cavium.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>, <lvc-project@linuxtesting.org>
References: <20250429210000.GB1820@altlinux.org>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20250429210000.GB1820@altlinux.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0006.namprd03.prod.outlook.com
 (2603:10b6:303:8f::11) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|DS0PR11MB8161:EE_
X-MS-Office365-Filtering-Correlation-Id: 1dffe9be-f414-448b-3cbd-08dd882824bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cSt4MjdNM0J6VWFDV2JJZlFnak51RkxDdHFOVk12d3M5SFNTYXBhYWhlUDRj?=
 =?utf-8?B?TmU2Ulp3WmI5cFRNU3lQYitud213ZFl3alBrc2NsMjU3L0kzL2YrVlVPTXBE?=
 =?utf-8?B?MjZLRzNDNVVFWXZyRXQrVHFBdVNvRTY5eFNVTlV2cS9UOWNUNVVPSFZJbmlM?=
 =?utf-8?B?SlhVYUpROW9pNEJhTFF5bU9pemtKRjdDOWdua3lnR1RZMno5Y1JXQUxlNXd4?=
 =?utf-8?B?M0Q5NU80Z0xWbGdxVk90Mk1KWVVtb2hiTmhpV0MvN09FbEkyallrUHNYRENk?=
 =?utf-8?B?am1TR1NYb2U2ajRnV25jTm5FSGZoa1RoM05iZ0p2SHJyamZ0Z1h0c2NCakdh?=
 =?utf-8?B?MUVsQUVPdnRsMHpCTitnYjVxaFZmajFVK2lEbzd2RGcxR2VXbzFyT1paL1Zp?=
 =?utf-8?B?VVVEb09zRDBlb255UUVRQ2FnS3dJSFMrRjVjdkdra2luTE42UmZXRDJPc3VM?=
 =?utf-8?B?d3g1c3ZmUEhCWFNLRURUQkU1QVQwQXd3TVRqVGxRTFBLZDZpYzNtVGZGSWRD?=
 =?utf-8?B?K0hGdFNHczdVZlNMYzhtRUUzSW9IeEVzMjBKME85T2FhMmtvVnNnaHVxbXQy?=
 =?utf-8?B?eFNzRWpaaHFDaExVMWF0NzhVZW5Od1kzZXhCU1g4UWVCNStaTmg1YjFIa3c0?=
 =?utf-8?B?dzh3RnRwYThTMGdLOU12NVZOZzkyWlJlOTliSk9nN09BRHRUWHFYTmpDRkJa?=
 =?utf-8?B?d3FwcGViL2s2N0hNTGlXVENRcHAvOENKN0lWSnVGVnhSYzdaM2lzdzQxOXBt?=
 =?utf-8?B?MjRxYXgvdW9OY2ZWR0pKMHltUmZHQ3gydUwwalA5RWZvY2J2bHk0QXhzTnBD?=
 =?utf-8?B?WHRRQy9vN1lsTk5LOWpMZEY0MTdLaG5ncHZZUHZvdVJNb2c1eElndXRTRTRE?=
 =?utf-8?B?aVFaSVZabnJFTTg4RFA5U25pV3dPVGZDd0xOeGtrSm8yRWZQR2g2R2t4cmRF?=
 =?utf-8?B?QUg4VnA1WFBLbzlwUFpBNG5IMk9jSCt1YTl4akNRUGswUUM5cDRaamF5UFlr?=
 =?utf-8?B?b3hZb3N5SlhTeFN1ZHZjODM5dm9CK0Jxa2tNZ21FeFhuYnNoVHZiMGlpYjd2?=
 =?utf-8?B?THJRdlhUeVQ2NWc1WXV4UUh3cktzSnFiMXhQMUhjVjBWaStqT1RTcWtTWDBj?=
 =?utf-8?B?dkNlVEJCdzZxKzhybXlhQjJnTmNFWWJxTkpzK3J3cWpneGIrc0VlMis0UEU0?=
 =?utf-8?B?MlgrMFVZeUplOU5Iekl3MG5WUHFpNkZRcGRZRkZCMGdkbXl1bVFWSG1UNzNk?=
 =?utf-8?B?cWRwVkNnZEdiaFRZRUdsa3RnQzNWbGdTRWJ5NFpwYmtkbWk1UWZjRkZZNWFl?=
 =?utf-8?B?ajJHZXgwWENNcGU5OFVENVRmT1dLaFJGdHRmcks0T2RMOWgzNFRrOUNUNmVn?=
 =?utf-8?B?c1dMcHVzMWdGOHJzRWhFaHg0NTdRTWs2TUZpMkc5NUlDRU5hV1dFY1Z5ZXdU?=
 =?utf-8?B?NzhTaHJKQ3NJNk5DalRqbytsVWN1MWVIMXV0UGhsODNuMm5CTTMvcUkwUnVs?=
 =?utf-8?B?Ym0zMHJpckI0RlBESVFhNjZnamRYOFlET3RDWXZqaWJPclpkZTl6RVk2dmpX?=
 =?utf-8?B?Q1liMXJGSm1FYk9zdldnSWxrMmJ1OXlnRDRXWWU0dzgyK0pneFNkNldlc0lt?=
 =?utf-8?B?REt2c0IzaS9hT24zd2RIYTFoeS9VaCt0RlFLNXRwbnEzUG45MnY3ZmFDOHJP?=
 =?utf-8?B?Y1lYd0krTzc5SGlLcktLYk9zdkt1T1lQMXBmRmtQNEZldFV6czZkN2pGNmhT?=
 =?utf-8?B?YWxYaWE4TzNJL3JTdi9JUHpha1o2NXJwb0k5d0RZM1J3NWdTWUtNQ21wQXVm?=
 =?utf-8?B?UmY1Z0traXFZR01EZG9KdHV3d3ZGeFBqb1dBek0rb00yY0RjenFjQUk1d0Y1?=
 =?utf-8?B?cGpYM01TK1pqYkhhaVhIcmJZRW5xUDZZT3VqYWdlb0RReFdQTDl0aDhrampt?=
 =?utf-8?Q?SaMp82XUOs8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T0N6OWpwbHVyQi82WjBySTdjNjNFRXNyNDRnay9ZRGJwbGVjWlArTUNLb3lq?=
 =?utf-8?B?TFNSK24wT0hWdWx5bWFsRVZvb0xOR3F3TnQ1eWxSYjczZ3hCeThqd2VLemts?=
 =?utf-8?B?SktkKzgxMDhyV1YrMWFmUzI4NWNYYnF6TnlMbDljQjE2bUpxSmZtQlk5OHIy?=
 =?utf-8?B?SmFJRkFCcGp3eUlXQU5sU2ZqK2xSNThpQk93OU94QXVLc1FadE5aYmhnd1Uv?=
 =?utf-8?B?U3RubVdRNThCNmNsVXc0MXhoS0Jnc3g0Yy9WTzlQUlVCbFdJcmdhNWJqdWRk?=
 =?utf-8?B?SzNkVmhrbnRLT0NsMm9FbmpEbVRRcStNL2RHckl2bkszOTFxR0FnbzZrbDZN?=
 =?utf-8?B?MVl6UDN3eXh5SVRuSGUyMDdUYjl2TVV6OEZlUUhieUNWeEdDUW04dE04ZU9Q?=
 =?utf-8?B?dW9kR0RNK1dQOFg2RXNNZTgrV0dPeVBPUnlkeXhJVWdUVUltVXZGR0Y3TTZ6?=
 =?utf-8?B?Y0JhODVteFRSMHhaZHRNblY0b3B4UFB4QURrTjVsSmNYWTd5N1d5bk1qSWNn?=
 =?utf-8?B?RzhheDFGaTFKNEVXcXVPdmtFakdEQ3ZRTjVoRnFRbmRURmhkdGRBclZQb3Nh?=
 =?utf-8?B?bHNhNHdtSDhoV0JXQ2NoMUEycUhsRDFvZ3RnRW5jcFdYb3QwaForbnpxZFRl?=
 =?utf-8?B?b0pmakpIRktoaTl3UWIwK1dSVjdDMGNJYXpoZ1RuNkZzZ05tc1VWeC9qMEpi?=
 =?utf-8?B?anA1aFF2TDhiOUJRZ3pwb0hvZWpoSzJqNmUwdVdCRkdaRERpcmMxTmMrbW5V?=
 =?utf-8?B?SlJJNmRTM2REY2dtRW4rRjJvdjBwNEYweWlDVVFDWUxpcWF3cHVISzVvejRz?=
 =?utf-8?B?YXhJZWtsWG55a3M3aUsyMCt5YTNkY3NnbkM1WDhVNGhNNUM4Z1pSQ2dQKzlt?=
 =?utf-8?B?a09UcWdJaTMvOWNhQmFoakh4aHBqRC9SRnV5R0tsemdRd3B6eDlrMThVWk11?=
 =?utf-8?B?Z3FEZmxEcjhidTJHTTZZRHBmWGtnOXBhQmpwUHYvdk9qTHBZM2pUYmRJYkxU?=
 =?utf-8?B?RmdpVEFxYTN6Zi9sNHZHbW1TVy8xMkhzMmZYNC9OSDh1bGsxZGxlcCs3Mmlk?=
 =?utf-8?B?djBDSVhWRit3Rk0vcHFHblR3UlRTNTRTVjQ1Q1pTQjloVWxHU21BNXptNmpj?=
 =?utf-8?B?bjRQc2tZcEtObFM5clAwMXFkd3ZtVnV6V3NWL3l3d2x1U0dWVlBzR0VOU3pZ?=
 =?utf-8?B?cWhTWTRjd2l1MEp6SlA2c2lZbjROaFRvdDl0eVA2M3VCMXdtUnFRMUp1aVlU?=
 =?utf-8?B?bVRpNnMyRmZObVRiRkVCWnhYSDJSQ3pYa04rTDhpZ2E0YkNlcHhCZHN6Y3BF?=
 =?utf-8?B?UTZ1a2dsbjI2Q3hJWXpwWitvc1FNODlpYWFQVXRSVkRHVytSRk1hV3JNRC9H?=
 =?utf-8?B?TnZ0Nms5Tjl4bmFCeHo3WFV1VFdEdnJsajJ2RlRjOGZiTVpKT0tiNHNBYVJl?=
 =?utf-8?B?cnRTcUxBczBtamJKS1RWaUlneUFLTU1ORGcvS3QyUE1CTVlzeVJwUWFqUnFS?=
 =?utf-8?B?YjZ4N0JpajZQZ1QyVUM2eUpWTVBWSlFRNEpCbWwrZEUrZXpUTzU3OGNXYkF1?=
 =?utf-8?B?Tk5HMlFtOEpPcXo1bUFHYWNyQ05GL3dXNDBubnJ5ZWZuaTNDdEhjRmlWWlhj?=
 =?utf-8?B?Z0NaaGd1eW1DUU5MNGY5dTc5SEd4YkswRjQ5aHZmVnM5bjRWd0RleDIvUW9u?=
 =?utf-8?B?dGluRUp4Q2xvQ1MrWmdrT2RndThyVEZNcHV5U0JXbW9XM0J0L1pUQXdCWlhq?=
 =?utf-8?B?MGIzdDVXdWphVFhDZ2dsNUpIVlAzOHplSWQ4ZWVROWxnTTFJNnJxUTdDZkU2?=
 =?utf-8?B?dnh3UE5tdVdzc3hBZUZzYWdEcm9Ieis2aGRrdkw0RmQyaWFzSzcwaVh4NFB5?=
 =?utf-8?B?dnpTUW5ZZjFWNTNGNkY1M0hwL2EySGNibUN5Wk9FeDNJSmk0QlRSRGlxVktX?=
 =?utf-8?B?RCtXV1plbnkyMWNhdDFUVUVOdnY2bU13SHB2cnZCdzZvcDJRRVBWU0poeEhU?=
 =?utf-8?B?aG9aTThFc1Z6QmNyR2lGM1R1WVpKWFFUOHFSaElqcTBySVJzM296UTd6MElP?=
 =?utf-8?B?SnhvTGZJT1FUZFZ5cGFqSEJLZVVKalRwZVBoUG1WLzBCeUQzT3pQNms0Zkgw?=
 =?utf-8?B?TkFQQXVwRUpzbXdxcitjem90RURRTjEva1h1NWJtVDNBOW1CWDhFeGRCSHlt?=
 =?utf-8?B?aFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1dffe9be-f414-448b-3cbd-08dd882824bc
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2025 20:46:55.3887
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7js1NVDtvGbcAGs7A8MuboAe3cLV6FoJ+BTlMuOdA+wX7lV5CPzadj+k/c7JBMG7PY1PxzFITMKu2o9uLv8YeArJrpW+jASSgwq6XAf6t/4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8161
X-OriginatorOrg: intel.com



On 4/29/2025 2:00 PM, Alexey V. Vissarionov wrote:
> get_other_octeon_device() may return NULL; avoid dereferencing the
> other_oct pointer in that case.
> 
> Found by ALT Linux Team (altlinux.org) and Linux Verification Center
> (linuxtesting.org).
> 
> Fixes: bb54be589c7a ("liquidio: fix Octeon core watchdog timeout false alarm")
> Signed-off-by: Alexey V. Vissarionov <gremlin@altlinux.org>
> ---
>  drivers/net/ethernet/cavium/liquidio/lio_main.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/ethernet/cavium/liquidio/lio_main.c b/drivers/net/ethernet/cavium/liquidio/lio_main.c
> index 1d79f6eaa41f6cbf..7b255126289b9fcd 100644
> --- a/drivers/net/ethernet/cavium/liquidio/lio_main.c
> +++ b/drivers/net/ethernet/cavium/liquidio/lio_main.c
> @@ -796,10 +796,11 @@ static int liquidio_watchdog(void *param)
>  
>  #ifdef CONFIG_MODULE_UNLOAD
>  		vfs_mask1 = READ_ONCE(oct->sriov_info.vf_drv_loaded_mask);
> -		vfs_mask2 = READ_ONCE(other_oct->sriov_info.vf_drv_loaded_mask);
> -
> -		vfs_referencing_pf  = hweight64(vfs_mask1);
> -		vfs_referencing_pf += hweight64(vfs_mask2);
> +		vfs_referencing_pf = hweight64(vfs_mask1);
> +		if (other_oct) {
> +			vfs_mask2 = READ_ONCE(other_oct->sriov_info.vf_drv_loaded_mask);
> +			vfs_referencing_pf += hweight64(vfs_mask2);
> +		}

Obviously crashing when other_oct is NULL is bad..

But is it ok to proceed when it is NULL? Is leaving out the counts ok? I
guess I don't really understand what other_oct actually represents here.

