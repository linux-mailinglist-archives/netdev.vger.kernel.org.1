Return-Path: <netdev+bounces-206406-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7301AB030A8
	for <lists+netdev@lfdr.de>; Sun, 13 Jul 2025 12:41:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B6711899E1B
	for <lists+netdev@lfdr.de>; Sun, 13 Jul 2025 10:42:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FC83225A59;
	Sun, 13 Jul 2025 10:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BVlgHIqJ"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53CF215B0EF;
	Sun, 13 Jul 2025 10:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752403314; cv=fail; b=GnFiXqWuaEyAGXtAUo47SkjaGeh2s1+4byI/Q64BtkgWaRo1Y32LGCcbsUohBfPV1jEY3ih83PAx9zpMol8npqcG5M82NTOhjEefk/zZlsyUhunX/pd27YOzjb1mUDls9NqY8tLAtd/amMxqM12rWTQcnk5GJJSgVbvkCmlRC48=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752403314; c=relaxed/simple;
	bh=IgcIYg29d54hSbXq8CXK0O9stEDWbX0uh608UUfBZfY=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=e4Q8YnQabmcjrzqZWu287kbZEVvbMB2TqLZYVPGrbfPvi+VtR17VdAGR26wv2eJtHQzuY0dqPqKSdmAeec7VNxBn8yNfTDdMZdffY2GPbDfK7pNacF0VTZHC1pNTr239Brc317iyd1EPAVZNtQ/p1ttv0im6E8If8yOCHZrs1aI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BVlgHIqJ; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752403312; x=1783939312;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=IgcIYg29d54hSbXq8CXK0O9stEDWbX0uh608UUfBZfY=;
  b=BVlgHIqJM5jyBHfBfhfD4L+FjNlRT05WWRGIMSr+biYBvwFL6qox9j23
   yMncmnIa26Aht11sTeYoBWhm+PUScY3Rj1qqsM3zZm7soUOqBvTCWbwDP
   /DpClvT+ialKpUmwrzdldWrPMiJ1ik1THu4n9mOk3deEdd7QSmtwFtdJy
   slqyxGnungpmWxi+dWpwRW0rkZo1eGc1ozd4J+TnNfWtcTrt8dyP1PE83
   xrwf2ciivDLiyKeaLUN+kgz7J10s+GcDCU4BH4MweFk/S5t4SM427UyZt
   /G2Qy+44VXOjeScUKUOWwDEh8v6e+eEJVxVxpwfhdh7HiOC2TyEfnBI32
   w==;
X-CSE-ConnectionGUID: lpDZS2yJT060DrNjxoz4vQ==
X-CSE-MsgGUID: b0W0Wsb8Sbad6xQTUJ4ToA==
X-IronPort-AV: E=McAfee;i="6800,10657,11491"; a="54708641"
X-IronPort-AV: E=Sophos;i="6.16,308,1744095600"; 
   d="scan'208";a="54708641"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2025 03:41:51 -0700
X-CSE-ConnectionGUID: bxZ6+pYMRnS3WlN9mpamcA==
X-CSE-MsgGUID: 7Z/2VZ8WQCGxWz8bDNx3iQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,308,1744095600"; 
   d="scan'208";a="161041344"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2025 03:41:52 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Sun, 13 Jul 2025 03:41:50 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Sun, 13 Jul 2025 03:41:50 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (40.107.243.48)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Sun, 13 Jul 2025 03:41:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ISsuYUkA652osFBwJVhssO8AF4DkVSobuvh9VJcA5TEnY1DFp1tDC2eMuTuUbviIGky4LeZoxtpsatgH2GhBTIu8Qyg4T5Ys9xdjMwLDd26C0yim5SRY+kO7W+Zz9+C5d5qklbXB8Lts9bWL2nF8Pix1oFb8o7YjQ7NRUPfdrqdN/5L41TPjcw8GbA29FBmsesglOk8YcYVACK/fS+w6CwgfewZIajY7Qo4Vid1jxt+PfcM3spBr251TKBULnnbO9W90IELu2KEiBzYr6ebTasv+5KopSns48W+4WDVKFUbU4D9CkRWufIuy3CPyzitDTF22MeXsvSbgOL3i6TrFgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tWSjs6SmmdXQhPSGTqwjlLCPvWQ6PYnq1DKPFgFzrY0=;
 b=OZXcFC27V6jOvz4i7UOFGgfGH2hRUBxl7pVzWJVqlIrHaMe0B6rCn6B/ML7+ZvDXsGGhr+dyah8HqwE4PLnmy/mSwkdcW9Gf80OmwGol0nq1W0D24/1576wuj/G71QRbGtorfyBp1PPiEzHgqHB9bzNwFXTfCi0KNedZF/xc7b0cpB+cJ6B1kjGvQP2akpUbyRSsi8Wl8JpbRbj4mLgsGrfut93c4ll0/bQ69Vcd4Ps6jB+iq+tgwYKVw1O5KiAKNDu705jk/z97moO68TAkNHMXeBjCE66l6HxXP0K3QnyRdSEt/eslZduu4CU6KsWElP2v9mZi+ZgnqoSQNqREsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF814058951.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::36) by PH3PPF37A184CA6.namprd11.prod.outlook.com
 (2603:10b6:518:1::d15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.26; Sun, 13 Jul
 2025 10:41:46 +0000
Received: from DS4PPF814058951.namprd11.prod.outlook.com
 ([fe80::a82d:bc86:12ef:3983]) by DS4PPF814058951.namprd11.prod.outlook.com
 ([fe80::a82d:bc86:12ef:3983%7]) with mapi id 15.20.8857.026; Sun, 13 Jul 2025
 10:41:46 +0000
Message-ID: <b2e31ba0-07f8-4e27-ac74-ea5d636dc999@intel.com>
Date: Sun, 13 Jul 2025 13:41:39 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH v2] e1000e: Populate entire
 system_counterval_t in get_time_fn() callback
To: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>, Simon Horman
	<horms@kernel.org>, =?UTF-8?Q?Markus_Bl=C3=B6chl?= <markus@blochl.de>
CC: "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, Richard Cochran <richardcochran@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>, Lakshmi Sowjanya D
	<lakshmi.sowjanya.d@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Bloechl,
 Markus" <markus.bloechl@ipetronik.com>, John Stultz <jstultz@google.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20250709-e1000e_crossts-v2-1-2aae94384c59@blochl.de>
 <20250710102516.GP721198@horms.kernel.org>
 <IA3PR11MB8986B554A8E1383F3D94DD58E548A@IA3PR11MB8986.namprd11.prod.outlook.com>
Content-Language: en-US
From: "Lifshits, Vitaly" <vitaly.lifshits@intel.com>
In-Reply-To: <IA3PR11MB8986B554A8E1383F3D94DD58E548A@IA3PR11MB8986.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TL2P290CA0005.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:2::15) To DS4PPF814058951.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::36)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF814058951:EE_|PH3PPF37A184CA6:EE_
X-MS-Office365-Filtering-Correlation-Id: 61d2bc01-9098-497b-12dd-08ddc1f9dd3c
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OVZEdzNpRU1qdEJDRERUVFhyQ3hTeFdHMDl5VGxMQUtvN2Zac25ET1dCWEV3?=
 =?utf-8?B?R1c0OWhRbGI1L2lMbFhUdnVJUFUvL3N4SG9IUnJRUFVocnhMNUU4Q1kwRjI3?=
 =?utf-8?B?Q0tyY1hqWFh5cGtQNFRReXd5VENseHllY3U4UW5DTEo2S3pPbStSNG9QaFh4?=
 =?utf-8?B?cnN2eXR2Um5SRmpLQldiTXRZMm1VK3ZyaFBsdjU3QXBFUUZUQksvS3YybE1B?=
 =?utf-8?B?TlkxV2RlOEFFREpZUTZPSDhHWFBHcEtqQXYxWjgvTnVxeUdyZDNmZUdEbnpV?=
 =?utf-8?B?YlViaXg2VWh0eUpjaUtpV1JFZHNQL2FTUnkrUDJvNUFmY0VkMldQdzh1QWsr?=
 =?utf-8?B?TUUwbVJDSmNHOG81c2Q0YVAxK3BQc2FQdjlvZ3l1OFpIYnI5SndBUExzTUNU?=
 =?utf-8?B?RXlVRk0xZWM0U1JSbUFWQXFhR0lrUm8vSlRKZHVMcVlDc21saW1ZTlllWGZX?=
 =?utf-8?B?NG9NOGN3WTJwOW9yVEtvU3pyUUp3SmY0M09ZSWVHeUJWUW95Z1ZaUElpSHVr?=
 =?utf-8?B?Ri91Y1VYSTNXMCtlQVE1Mkl3TWsrS0lYYTJCaFFha0NnL0N1U0RjaWFWbUpJ?=
 =?utf-8?B?SisxSCtIT0dRVlVueHViaXFTazR2eTNraDZpYjdyQXl0L0o3dVNTZ01XUjdE?=
 =?utf-8?B?cXMyNGNCemZBeXV1aVlSZHd0U1oycldGaEJ1a1ZGWkRqWC82eXhaVVc4cEo1?=
 =?utf-8?B?QmR4dndtd3pZZTBSWHlOWEpoUVZoVzQvdTg0QmpsVzA0Z2g3MW9XdTc3M2k5?=
 =?utf-8?B?UnRyZEtiOUFaMFVJb3FFMUN6b3EzZUZDMUVDZHk1dEFkbXlBQ3Zwd2ZOL3lZ?=
 =?utf-8?B?aks5UDNxdEdwby80VWs2dmdFcTRSbzhpSEVDSVgxVy9wT1pxRS9xS3gwTVdR?=
 =?utf-8?B?VEd2UTRNSG9Iby9VaVZnKzNXU3I3c2dDZ2VrY1V5R2k2QlNEMEtuVWVubG9i?=
 =?utf-8?B?R0FTYktvVTRrOGZvMEFnSk1LOFFOaVZFZmlaWHYrS0J3azhxY2FDUjNBeHZH?=
 =?utf-8?B?T0QzdFlOcWR0aDBTeldUVzFrS1VaN2Ixb1BQTlVCbFdtQkgwZkFZUUFqdkxv?=
 =?utf-8?B?QU9nQ1JLUis3TVA0Mm90cXQ2YkhhSFB3ekhVOVdTQW9WeXM5amVqUUtkUUlj?=
 =?utf-8?B?dHZqUG5DNFdKaHVuSndJUkJ1MTJRQTY5akFLUDhwQUgwclM4dXpLNVFNK0Vq?=
 =?utf-8?B?aG5Zd3JMQThlaS9pUUg2ek1NUnhhR2VteVh4ZEx4TTRQZHViRGE3WlR1RENE?=
 =?utf-8?B?aDZtR1ByamFSYWZjbmV1QXRPUXVxcTdvZzZzdkpJQlV4dmJLN29rSmJ0M2ht?=
 =?utf-8?B?MVZmVG9DdjZXZmdIMzBXZUZ2aGx6Z3AxbS9UQzgxelNQN0I1dTJtTnlOZ0Rj?=
 =?utf-8?B?UFg3Z1BKWFcxNndVOERsUWVUQTVGOFJrcGRpSGZtVGU3UHlCNWJKWW02ZXI0?=
 =?utf-8?B?b05mVG9pR0NlS200dDdMalRNSkFIQVRuWk10N2ZacjVJaU1DZndlNDA1aFFP?=
 =?utf-8?B?VExiRFhKQ3BhZFRkZEpHRklVTDRycnBmUkMvNTAzaE1pUHpaUkhDY1FtZnhm?=
 =?utf-8?B?VDNDQTJvaFdjMXg3anpVV3pSZXNrNi8ycStlMjcxcjRneCs0ek9qOHR1d0pP?=
 =?utf-8?B?RmNHVllWc2RiN0p3MzRRN2lvbFBlcHhPOVdvVm1pOWNTcUNPUHoxdmxnc3Jp?=
 =?utf-8?B?SjFVVFBwZkdRdU0wYzMzQ3RNWDlhd3dZbEUxanVYbGxFV3NjdU9jRGZueGZi?=
 =?utf-8?B?MzgrRjRQMkhUOEpWcXlRNm5BYVFnZ2VuVjJocytWNGdzK3ljOHNSME9BY1pn?=
 =?utf-8?B?S1pvQUdJMlRvaVFYNUdiUkc3WmFMV3RSbktUUDhpeklWZnovdFc2ZEFiM3JF?=
 =?utf-8?Q?Uzm3+ys71CQ/P?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF814058951.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bzkwRkFsQm56bElHbmYyUzlzM25YTytub0Q2djNPVG9zYXc3dFp6R3pjN1NJ?=
 =?utf-8?B?VGlBVU0vYVhReEJRbTN4ckpvcll3ZWIrMXRKU2t5eUczMTQydVZQb0ZuWkVV?=
 =?utf-8?B?dzR5NnUzSXhQejNWWlFRcjg0ZlFFKzkranQwSmJXZytmSnhVblpERGt2Z25L?=
 =?utf-8?B?Z3BSSEJ3bFd5WG5FcTNOV0Y4VnI4TmlQVWIrVUppZjlUc1ppUEduc3BDbmpP?=
 =?utf-8?B?TjJNeTFaaHpmeEt3dmd0cGVSOUFnVC96NHBsWW5ybFJZY2NyWHJWaEttOWI2?=
 =?utf-8?B?QXhpVTBiYjZPSHlMNm8ra2hPRjNpd3dyQzcrMndMWHFZWTAxalhvcG5XK2dt?=
 =?utf-8?B?ckc4eEt4eGViRmtQSDlFbkRaa1NYU2N1c3h0ZERMcTNHd2lGcVlITU1hc1p2?=
 =?utf-8?B?UnJ2K1lKbU9Qa1lBZjNXbkpkMnBoaXVkWjFjR1RjenRvbUtYem5xaU9Qa0FT?=
 =?utf-8?B?ajZLR21Xa3paMmVJZUxRbDg1eEFmUEJ2dGd4OFFubjVqUzhjblJTc0pPTGdL?=
 =?utf-8?B?TkwxR2RvY2RkdFdjK0hjN2hOMGViK093TTd3d3lhMndIUzBBWkorZWM3Rzgr?=
 =?utf-8?B?dmZyT29weS9TTFdRWk1RQy8wZ25sem5oSytKdzN2RlZGZzN6V0doYzIyeFdP?=
 =?utf-8?B?cHJ4R1k4U05jMEZvRDUydEdKVjdLYTNBQ25hak41ZEN5b0FPR3Rqa0V1aTVK?=
 =?utf-8?B?NElYK1VWZ1BsbWdJUFJmZHV1aW1iRUFoYllnUkVnc2pVYkZ1N20zM1Jsdjdz?=
 =?utf-8?B?YW83UVNoNGNob0Z3eHBkZCtsVk1YOU5KZXZTVHdpeGdORUpLaXZsdDB5V25m?=
 =?utf-8?B?WFNNb1hNYzZ0OCtSK1FSUWtNMkNGOUY3UXMzb1hobzV6Z3ZlaElqUis2TW9l?=
 =?utf-8?B?OWpBMzZaaHpFdkk5YlVyb2ZLdHBhQXU0N2s2d3ByeEZzZHlvMUFCaVRYaXVL?=
 =?utf-8?B?M1NWaVZtOGFYS2JHcXlMWHJpQ3ljbUFPZDBpSjRxeEorNXdaV0ExZ3lUVFhw?=
 =?utf-8?B?UUpaa0sxTE9CUUJ1by90dzczK0tIT1JvYjZYcGR4QlM1UEIxZFliMWpjTnNM?=
 =?utf-8?B?bk9SK2FseXROeXZNa0xHWEFLUXZaZTZDRDVLNEROUldUejBBN0hKTTJ1QlBh?=
 =?utf-8?B?aSt4cERzKzR2ZWp1VFFHb0JuMUxzZlc5d080b1NudXlWWERQY3R6Q2Q3U0NB?=
 =?utf-8?B?aWxxYlM0Q1NsUiswWTk2cFlxaXNPUkFrOG9aRExVWHVGZGk2bUxYV0RiQ0M2?=
 =?utf-8?B?b09IUkk2ZkJjM28xQUo4STRFS1VZa0o0bkdpWC9jNlNzZ0VUa0JXNzdXY2ZG?=
 =?utf-8?B?cWI5SUJYZ1FlVEpRVkVIQkQ2VGhPckhyQVhFZXhWS3Q3Smk3b3k2bHRhS2U3?=
 =?utf-8?B?SnZ6cUdmRkVuZi9VOStiNEN0blo2Q2M1Qi9SM3BrQ0xFai8yaVRDOVVjalVw?=
 =?utf-8?B?THY3SUh6NExwQnRES0J0VFFKZVZ2a25lZVgvbzJaOGJPYlU4eVV1NC9aT0RG?=
 =?utf-8?B?cFFwalg3ZVNFbGNHaXFVb0RXOUtyNWF4cnNGM0djMUdTelYyNXJ4SGszV0Np?=
 =?utf-8?B?NlkySENRK0xHNlpTSjRzKzlsajA0Ynl4NSsrS0l6N3NqYnVPODBsVUVuSE5w?=
 =?utf-8?B?blh6WnNRM3AyYmZUaldBcy9QdjMvQm93RGZFdmF5YjdqNnFEOVY1NlVRQzc3?=
 =?utf-8?B?TXNRUnZzSkIvM1FMYlN5ZG41R2JZb3RabUFEbnUrVDdFWmR6TUZoTGxVaHNr?=
 =?utf-8?B?bkllWHlZZ2RiOFBqUzhpQkpMZmRTT0kzZnM3M3B4Vks5Qm1iVlI0WXpZYXcv?=
 =?utf-8?B?bDh4MmFVT3dESGRrNkJGK1Zka05sWXBWaWg2V3REZmw1WVd3clh6UmZucFdu?=
 =?utf-8?B?dElOeXB3L2J0VmZPWWNZaGFSSzZzZFd2R08xRUcvTXBqb3ZlaXYrcWQxREUr?=
 =?utf-8?B?Sm1pbEVqK014NnA2OElObDBZdzVxbktrSVcrQjlJU0t5TDNUTnN1VmwwQlF1?=
 =?utf-8?B?VHA3Wmk0Y29qS3hWVDdENzZ3NFJFRThrRjl3OFVjdlROa0FtZms4Qms0WGw4?=
 =?utf-8?B?Mmp2cDN6MkxBUlNqa3dZZzJDR2lrYkx2S014WmVqWjhPY3dYTGNBNTRrUDlK?=
 =?utf-8?B?RFUzQ2dWSmk5WFZqN3g5NG9UMnFGdkxjek1tTzVKYTlrZlNGbTJiUGhNWExM?=
 =?utf-8?B?aXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 61d2bc01-9098-497b-12dd-08ddc1f9dd3c
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF814058951.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2025 10:41:46.3969
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 10yWTDNuK/CiCCMlyBIGV460YZeWQdxMBPWIrnttMMSJ+XU7tRiMtSlo2UheCUnMWYkWOJ5+AankAzCB0TiOxzZdGXHSjzsvkvOvoBIKpJs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPF37A184CA6
X-OriginatorOrg: intel.com

On 7/10/2025 1:33 PM, Loktionov, Aleksandr wrote:
> 
> 
>> -----Original Message-----
>> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf
>> Of Simon Horman
>> Sent: Thursday, July 10, 2025 12:25 PM
>> To: Markus Blöchl <markus@blochl.de>
>> Cc: Nguyen, Anthony L <anthony.l.nguyen@intel.com>; Kitszel,
>> Przemyslaw <przemyslaw.kitszel@intel.com>; Richard Cochran
>> <richardcochran@gmail.com>; Thomas Gleixner <tglx@linutronix.de>;
>> Lakshmi Sowjanya D <lakshmi.sowjanya.d@intel.com>; Andrew Lunn
>> <andrew+netdev@lunn.ch>; David S. Miller <davem@davemloft.net>; Eric
>> Dumazet <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>; Paolo
>> Abeni <pabeni@redhat.com>; Bloechl, Markus
>> <markus.bloechl@ipetronik.com>; John Stultz <jstultz@google.com>;
>> intel-wired-lan@lists.osuosl.org; netdev@vger.kernel.org; linux-
>> kernel@vger.kernel.org
>> Subject: Re: [Intel-wired-lan] [PATCH v2] e1000e: Populate entire
>> system_counterval_t in get_time_fn() callback
>>
>> On Wed, Jul 09, 2025 at 07:28:07PM +0200, Markus Blöchl wrote:
>>> get_time_fn() callback implementations are expected to fill out the
>>> entire system_counterval_t struct as it may be initially
>> uninitialized.
>>>
>>> This broke with the removal of convert_art_to_tsc() helper functions
>>> which left use_nsecs uninitialized.
>>>
>>> Assign the entire struct again.
>>>
>>> Fixes: bd48b50be50a ("e1000e: Replace convert_art_to_tsc()")
>>> Cc: stable@vger.kernel.org
>>> Signed-off-by: Markus Blöchl <markus@blochl.de>
>>> ---
>>> Notes:
>>>      Related-To:
>>>
>> <https://lore.kernel.org/lkml/txyrr26hxe3xpq3ebqb5ewkgvhvp7xalotaouwlu
>>> djtjifnah2@7tmgczln4aoo/>
>>>
>>> Changes in v2:
>>> - Add Lakshmi in Cc:
>>> - Add Signed-off-by: trailer which was lost in b4 workflow
>>> - Link to v1:
>>> https://lore.kernel.org/r/20250709-e1000e_crossts-v1-1-
>> f8a80c792e4f@bl
>>> ochl.de
>>
>> Reviewed-by: Simon Horman <horms@kernel.org>
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

Reviewed-by: Vitaly Lifshits <vitaly.lifshits@intel.com>

