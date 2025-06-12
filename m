Return-Path: <netdev+bounces-197121-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2015FAD78E0
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 19:21:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 73055188AE23
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 17:20:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C82A29B792;
	Thu, 12 Jun 2025 17:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GVHrciw9"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9909C2F4334;
	Thu, 12 Jun 2025 17:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749748805; cv=fail; b=LEaUrLUPbY2uJ/q0h6jlnvO5oeO7iq3JYjWBmB2LM1j4q8KyiBiwVsmBJ4/jqAZL1BVFYYYDKZIV3f13dvyVRQ70X6V8pw7B1dac+m0TvE3DDB5aqk/dQjk7NLrI87FBbER0b+RsYJRoeamcy/R7WGrhYfIAwS4eXvGQwcKQ1o0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749748805; c=relaxed/simple;
	bh=MHcIJV25hVa6or+TWL/YmKm/kPH5mSsdHmavC24QhV0=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=jn0/4uMZ+AW25npPqRNz7RMj2jNHJpHCRZaA2DwoWens0bsHuesK0xkjTkc6tSPyhJRdIsEJZWRWBYK2VKQp5CcVo1JLBL1z55QW4ph1VZbZ5Qr4gX8RJ8yfRDroax+x42d9JYmYh5ikpqVhPnLHQV3RO60xh1fl4PAYxZmpzfo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GVHrciw9; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749748804; x=1781284804;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=MHcIJV25hVa6or+TWL/YmKm/kPH5mSsdHmavC24QhV0=;
  b=GVHrciw9W1O7+XElPxQaqLufZpRXpC93c/Yd7o8CKlRsDmxF4vImVB2O
   wqEDPr+0clG9FF1UF7Gda/6pYEkEKMi561K/hIDXVARHmDFaqMeldYw/P
   VlSER9oiLGY2fFLYD1L600qvMJwC37UEM2cVUtd9v7nsDyrJnk9yFVM7t
   E79m67YTPCzePRTf6d9okkAizwO85ia8eymoZcXtVo6zqAPpG1B41le7I
   SR2G7UrLIR1hM9X2nGBtopAAFyMREhPq7jaqanQQWJVJPA5x+HnSum4v5
   S12ncMhoY/JiOeLj15Pg8IqFEXvzxH+ka88d+PRezlFsFCHUeRFI2VV1B
   g==;
X-CSE-ConnectionGUID: al7TtyMLT++55+65l/dlYQ==
X-CSE-MsgGUID: gUcm/Tl9SRCzrNHjZO5bKQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11462"; a="74476163"
X-IronPort-AV: E=Sophos;i="6.16,231,1744095600"; 
   d="scan'208";a="74476163"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2025 10:20:03 -0700
X-CSE-ConnectionGUID: O95SOcJbTtGrNy0zIgvCHQ==
X-CSE-MsgGUID: gnCBPQCsQQmpGTTZh65AGg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,231,1744095600"; 
   d="scan'208";a="178549557"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2025 10:20:02 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 12 Jun 2025 10:20:01 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Thu, 12 Jun 2025 10:20:01 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (40.107.223.49)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 12 Jun 2025 10:20:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JNqbyjJu27HWsJVoZppMTC4Rvu2aLnmMHyr+XLhnW2M4xk2C8+eHLUf9zTXfvZSBLqBdVSh5RjHT9aRVMw28PI8BFb+jp121jqlLOlZgUixarf6ORYmM+2aIuoApJDaxkIk8SmllXfUXikY/7Wejv/TUWRaMvUFIXYuNPyi91BGfqWtRVaYPoa+Hg+aQWX34x6xpLO39+dQM/RnCIBCg2xY3UO/IY4Ath3llTO7YnNa/FhgHH/6hzKJBomLXBvaPL+0cmmshm8F+wnllj9sTTCNboR1h19DO3AY2k6emS02D/ByBuv8WHpsCfF2jBySbfm46ZBmdM1dU5ibtGqTyXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gc7yyxCYp/+l5hF/eIMtB8V7xwpJMB9jTyJ78jApADI=;
 b=aYnQwwxuj4o6cHj9hpJZ0aDQ3dPEIzKYAmjeoweq7F1UYhyRtYNdb4AXsMMFioNEam5xZA+pjmbGXd7Bg2VuQt3tRe/AWsuchiHrvLLV/gshVQS4EDcFfpzbG5miLsbIWBCFVm5CiHhkdqEUp0QTk82IZDXqRfH7BmD1rmxe/E2IYqDJy0uO7uLdzmcNH0wO7OMVS5LB+nt6XoSbH1qLROdtO67jXKPF52lxBoxZbzZfmIYpO92PdvDD8PAHluYtBppHDX8UaZhjLBUufEY6Jgf7Pr5utmjwMLn+1dTzcP4qWUf2QGUmNQxlo9RSF1xqr5ENjQtMELJvX+jO+6o/KQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB5095.namprd11.prod.outlook.com (2603:10b6:510:3b::14)
 by SA1PR11MB8426.namprd11.prod.outlook.com (2603:10b6:806:38d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.19; Thu, 12 Jun
 2025 17:19:59 +0000
Received: from PH0PR11MB5095.namprd11.prod.outlook.com
 ([fe80::215b:e85e:1973:8189]) by PH0PR11MB5095.namprd11.prod.outlook.com
 ([fe80::215b:e85e:1973:8189%6]) with mapi id 15.20.8835.018; Thu, 12 Jun 2025
 17:19:59 +0000
Message-ID: <8b53b5be-82eb-458c-8269-d296bffcef33@intel.com>
Date: Thu, 12 Jun 2025 10:19:57 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] docs: net: clarify sysctl value constraints
To: Abdelrahman Fekry <abdelrahmanfekry375@gmail.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<horms@kernel.org>, <corbet@lwn.net>
CC: <netdev@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <skhan@linuxfoundation.com>,
	<linux-kernel-mentees@lists.linux.dev>
References: <20250612162954.55843-1-abdelrahmanfekry375@gmail.com>
 <20250612162954.55843-3-abdelrahmanfekry375@gmail.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20250612162954.55843-3-abdelrahmanfekry375@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0194.namprd03.prod.outlook.com
 (2603:10b6:303:b8::19) To PH0PR11MB5095.namprd11.prod.outlook.com
 (2603:10b6:510:3b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB5095:EE_|SA1PR11MB8426:EE_
X-MS-Office365-Filtering-Correlation-Id: e1f56814-57dc-4dcc-f9f7-08dda9d55c2a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dldONUMrcUYyd3VKc0xnVmdDeUwzWkpjUlJIbHpvbk5XdEE3cmRnbjY5SXlU?=
 =?utf-8?B?UzN6Ym94SUJtWWdFL2QxTENpMHZkaGxuRG0zWTVBM2JyNy9pbEpYMHh5TlR4?=
 =?utf-8?B?ZjBJckdhVEFOMGNBR2tCUkFlOVQ1UGpBVktCbmN4bFovMEdYZEZ5bEg1WE9R?=
 =?utf-8?B?dnVrY09NejFYcGxFNWs5QlhmUkl6SDB2b2JCRDlRUjdncFFnazhwbS9Jc1Mv?=
 =?utf-8?B?UVdPYktXQ3dMQmZ2OFhlVlRWWmJBbndFQStTNjMwNGJXTVBVVkNQY2x0WEt3?=
 =?utf-8?B?Zk1SMUFEYkQzYlFBWWZFdWlGMmdPUk94YWJ6dm45T2hyTGNuVkcrcmhMdkFF?=
 =?utf-8?B?Nm9TV2JJUXJqTVU0RXpDK3NJWU5qMmswNGlOMkVnOHc3dzJhNUptb3dhczJP?=
 =?utf-8?B?ekYxQ2ZtcUlFendqLzMyR1Y0MjFRU1grSkVKeHRmbEhHZFJMQmNnRFo2ZTlz?=
 =?utf-8?B?WVhsVVF4d0R2OVVOT1kvT1NLaHhwMHh3dGp6bkxxQjNZeEljanNYRTFkNUEy?=
 =?utf-8?B?emszOXRGbXZEbjh3TU9scldaVmhjeWwxN0xqY2ExSU9xT2hNZGJycElOMFBi?=
 =?utf-8?B?OFJ3UWVYZUU5b005bkFwZEpTaStvRURQamR1SFNFZitPZnJtQnMrUlJ4TFhJ?=
 =?utf-8?B?c0lQTWFGMUw5M2tST3I3dW0vdGYzVHAxbDZhUTBRSmFLcSs3SEJjSDZHV2xu?=
 =?utf-8?B?N2J1M0xZTG1rbGdhOGt3ZVJSMTcvcEVxVHczY2JWSjRUaEJQa0EzdW4rM1Z5?=
 =?utf-8?B?N2xSRmhuWE1YdmlQQmtudFlka080OXYzMkU2Smk3OEZMY0ZRWkZvZWVMRWh1?=
 =?utf-8?B?Uml6LzdUaUlkVFpuZ1lLWTJ3cVh3MjhUU052ZzlHdy90dWQ5T1o1SXdTYVcy?=
 =?utf-8?B?K3JxRFhHYVZKVWpjZ0hjV2dVUUFYQmRYS2lhYjJTSTRWZE9SMDdwNVpDSVNV?=
 =?utf-8?B?VmRxSHRtU0hQVEhoTDNXc0ZwL05ObmVEbVNmbVZ1WmdFS1pmWXdzaktndGhp?=
 =?utf-8?B?a2oyc285aW11aE1RMHdkanNSWlJQckQ5Uk1KdUlIRnlZc3pCbit3NGxDUWI3?=
 =?utf-8?B?U0dOb21KMEh4MG8yRG9WWUNnc3VXa3p0VkZpSENyV0hEeUFrTUpWUUxuZnJX?=
 =?utf-8?B?WktIWWN4QThtTjRmcjI1Z3hwRUZtcDZQUlFGK1lSY3lraTZRenMyTm5yLzNF?=
 =?utf-8?B?aWtUREozek1uMkZlZmRBR284S2RDNE9WNDgxU3BPWkh3b0IwMU5kWi96N3By?=
 =?utf-8?B?SEVmMG02UjFKSmY5UHlrZjdRUmV3VVZGbjV1cmtBR0NjRTM1SXRXUG5BRmVT?=
 =?utf-8?B?dXRkb2NGZkt5REhGU2xMTFNSY3hjUUlDNnhxVTcwdHdWb1NSTVZJTTdXeXR0?=
 =?utf-8?B?OWtNOG0zdGdhZWlGT0MvUGh5c3IxSEU1VTN2ZWQ4RG5HSVl2REpmeGl4UEx6?=
 =?utf-8?B?NFZ1c25GSm5pSFFPVU1hOFZTTUptV1ZlYis4MUVFOWZXa2J3NzJVSnlDa1Ev?=
 =?utf-8?B?cUlJV2RwNldOUGx1WUlwOHVOWjM1RnBvUkxhc2hVVDMxSnBhL1phdWs2eHNj?=
 =?utf-8?B?UWxoMVNSR2hGdnlNM1BsYjlHampVK1NHcGFzRXhjL044S3RiNzRyMC9rQXk1?=
 =?utf-8?B?TWZ0dUd2OFRDM09UYUpSQ2hXK0JPQzd1V0JVeFJ3ZlMwWmxoYm4vMlhnQUN1?=
 =?utf-8?B?TkZwZ2pWY3ZndkxFSGwzTHRieEF1SWdoMlB0bThheGx4aTYzNkQxMDA1QXJN?=
 =?utf-8?B?K0FNRmNaVDgzT3NQbHpIaG1CaFlFZVc5MExZMVdldmVVKzNDWE5UZkNZNjlZ?=
 =?utf-8?B?akpneFV5UTZBRERXR1RuVlBJTXU1dlM2MG9HMFBvN2dSRTR6UzJQZUFVVnEx?=
 =?utf-8?B?UHZybmI1WE9sVzhpNVBSZ2hYaXRBK01CNit5dWFyaDlYT3pGdFgzaUdLSVhQ?=
 =?utf-8?Q?hFhS+IzBZxI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5095.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?REUyd2VyMUtFY0Q2UExVeU5ZNVdHQWNHZ2ExQW91L1VjRm8xeWU5ay91ZXNC?=
 =?utf-8?B?WisvWkQ3dFQ4ZTBmcHBIenhENlpmMVBoSldjTTlwTHNjMnlIMktWSVpZMmhQ?=
 =?utf-8?B?L3dIY1paZ2p0S2ZWSTROdzQrMzdpRUQrdVZHSmM5bGJTanFZSkVaa0kwSExD?=
 =?utf-8?B?NHlNeTRJbldNVVkrYVgwemZ1ZG1MOW9nUHlhMUVUZkFXTjc4WlZsWDkxaERW?=
 =?utf-8?B?VTB0cjVTQm9HSzkycy9wYzBRYnpaSUdnR2tFbFBsR09jR3Y1aExyZTkzOGt0?=
 =?utf-8?B?eFVEVmVFTUd6Y0NFcW5USmpTYzl6aUJTT0N0Mnk5RkRvR2h4b1ByRWFrT2Fr?=
 =?utf-8?B?eXM0Z3p1L1BZQld0NnZxOGdvNWdnMmJMZ3VNa1A5VFlIK1h1ZHNYa1ZpZnlE?=
 =?utf-8?B?Rm5zU1JESUd6UW01SVd5ODY1dDlzRHJ0UnFIcFExelczVlNIdENmNEE0RkhG?=
 =?utf-8?B?MmVaZDRnaGs3QlpwUm9SR21TOEl0Mk50ZU5UcVdlY21ZMjlhWDJwTzMzeHRG?=
 =?utf-8?B?cUVsUnhRTENUeDBzakNNMGgzNFRLemdEaDYvV3Jvb0prUW42TWcvTzUra1Fk?=
 =?utf-8?B?UWpEaWRhNUhxbkNaa1RzUndIWEgxVk1MTlBBbW0zNjh0dWFSdk5XWldYWkdF?=
 =?utf-8?B?UzhreDRNQnVSeklJdTFtMHpQa1J4WWNaU3UzbGZ3ZmlMRmYwT1N1L3puMUx4?=
 =?utf-8?B?ZkZUbHd5L1duUkFDVWNwaS85NXZWQll3OFYycWtUK3UwekhoTURFWTg1azJX?=
 =?utf-8?B?MmtXQWJsWUlKTHR4cUVSdWE0amJXWGxCajVCWi9oaXI3alBlUEVPNzRTZEZW?=
 =?utf-8?B?S2lyS2hPNHAvSVhOdG1XL0JUM0RGY2ZPdkpYVEdEalZoejZWM0YybG0rQ3Rp?=
 =?utf-8?B?eFRPMmNGR2wrUGNqdFhZTTZUOTN1N3oxb0N5RUFYNFlrWUZUcm9EcjhSQVJX?=
 =?utf-8?B?eG1kekNmd2I5VHR2RUsycVVoUkZ3bzVYYmFjUkVLSDcwVE96TWRmeEh1cVQ3?=
 =?utf-8?B?Z01XcW9tazlybHRsQ1lQdGtaQ2ZrWXp5ZEFuWUpoYm1BY3N2R1lOK2s4Tm0x?=
 =?utf-8?B?djBWOEQwR1dHUVhPR0dDblhIVXR4dlpvSW9WUHZOczlBang0V011cFZYZkV0?=
 =?utf-8?B?RkllNUlGRkFuVXZmNXczTVRXQnB4eHBDMG5mNCs5d1BGR0hQQ2lZMVVJb0U5?=
 =?utf-8?B?bjdlQmtMTDgwc3FHZXJDTlVJYnYxdVkwb3Y1VEtjZzhDWEx2NjIzeUtQWkJH?=
 =?utf-8?B?Y09oeTl6UityTXlUTEhLNUw1V0NIUFRMYlRkS1k4V0k3NlppOXl5MlNKWVFk?=
 =?utf-8?B?S2dxRlN3TFM3ZU9JdXJacDZ6VXRWVWttT2FsVzFGZVFlbm5sd0xuVGdJTmxT?=
 =?utf-8?B?cHJhR1I5UDhSVWNwRTJjcE5BVmIybGdEVjhRVTF5ZHVuQ2NJMXBuQlhGakFh?=
 =?utf-8?B?ZzF6MEhzOWtsTHlpYUZHWGJQa2syZGhrbzliMmRlWkpXdVYrMjdBK3Yxc3pn?=
 =?utf-8?B?WnZSUWVlekZGVDVOWjVTNjNTNDZ6MGY3WlpPZE5FVnk1Ym1ZYXQ0YWg3c09x?=
 =?utf-8?B?b3NYZS95dUpaOVlTMG9rUytHdllRNEl0QjNwUGE5SDJuU2N6NTJYUklQNjNK?=
 =?utf-8?B?cTByTWVacjNqeEJCeVE0SU52a1c3emRiTTJmK2xYUEJ6NXZYc2dQaWh1WmE2?=
 =?utf-8?B?SGxDUjQ4YWpxVk95a0k1N2tMSXF1R1pKUjM3ZERvZ09lTk4yVVhsL3ZxdlFo?=
 =?utf-8?B?cjRrdEZEM2hqb2VySER6L3VZR2xiUTB1ZDdsZFA3dnF1QlpEUDQ4aXQvNVlY?=
 =?utf-8?B?YncyRE5ZMVpZbGQxc01iVlhNNzVUR0lnWkh1c3JPUkxYcVQ3Z0UyTFB4K3Rl?=
 =?utf-8?B?VHhRRW5CcWVJQ0FXN2xsWW5FODRQMlZnRFMrVmxyM1R6NnhEQ3RwWkxIalMx?=
 =?utf-8?B?OGt5UzVacitiNnI3dGZYb3BlOXUvdzdUR1VkNVhablVoV3Z5WExMeXJtRGM4?=
 =?utf-8?B?ZmFsUHkreGNySm1MZmYrM05JTSttOFp4ZDc4bGJpM05CbFRQNHpocmc1K1dz?=
 =?utf-8?B?eUl5T3BMeFpMM2QwK2FVSUdZdlM5YjVwYmdtQU5KZjN2Q0QxT0FMZ2xJS2t4?=
 =?utf-8?B?YjgwZXpqeFFTOHhyK0RSWHgvV0s4RnVPaEhTZG1LejJGZVBQdGcyL0NGQVRF?=
 =?utf-8?B?c1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e1f56814-57dc-4dcc-f9f7-08dda9d55c2a
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5095.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2025 17:19:59.7914
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3dAMDs0CeeaeqONBcIsiYDxgJ3XASj9Fz2+KP0+uRatJ+/shWkv9dRxdbpDBwL5kidxhKReaXqGd6lbpI2vp3hHvog3g/ZB9LhrFpRb8D2g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8426
X-OriginatorOrg: intel.com



On 6/12/2025 9:29 AM, Abdelrahman Fekry wrote:
> So, i also noticed that some of the parameters represented
> as boolean have no value constrain checks and accept integer
> values due to u8 implementation, so i wrote a note for every
> boolean parameter that have no constrain checks in code. and
> fixed a typo in fmwark instead of fwmark.
> 
> Added notes for 19 confirmed parameters,
> Verified by code inspection and runtime testing.
> 
> Signed-off-by: Abdelrahman Fekry <abdelrahmanfekry375@gmail.com>
> ---
>  Documentation/networking/ip-sysctl.rst | 50 +++++++++++++++++++++++---
>  1 file changed, 45 insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/networking/ip-sysctl.rst b/Documentation/networking/ip-sysctl.rst
> index f7ff8c53f412..99e786915204 100644
> --- a/Documentation/networking/ip-sysctl.rst
> +++ b/Documentation/networking/ip-sysctl.rst
> @@ -68,6 +68,8 @@ ip_forward_use_pmtu - BOOLEAN
>  
>  	- 0 - disabled
>  	- 1 - enabled
> +
> +	note: Accepts integer values (0-255) but only 0/1 have defined behaviour.
>  

Hm. In many cases any non-zero value might be interpreted as "enabled" I
suppose that is simply "undefined behavior"?

