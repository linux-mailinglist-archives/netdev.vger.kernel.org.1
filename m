Return-Path: <netdev+bounces-116787-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0249A94BBE8
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 13:04:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D2622823F5
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 11:04:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D77515444E;
	Thu,  8 Aug 2024 11:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iPFWI56z"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B190E18A950
	for <netdev@vger.kernel.org>; Thu,  8 Aug 2024 11:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723115071; cv=fail; b=MLJIeOoaEsNrkIhZZke0YREJ+TfQrj5dtZGBMgCgdJqV2IxlovuIFZ0GzoBLJD4X7FefbzdyEoFvdFZtnRsa+GxPCE7X5lUeE/aQ5VHewi3+JI9BaFSJfh0cpckLTZhNfMk4eJEwcbPDG2VSdqbW3laJLkx1lC9u43XMPG2UCJ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723115071; c=relaxed/simple;
	bh=oD6xXik43LLrzGwz79CL7XcDa9KLyMBy2g5HtMhIZws=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Em0Kclf4qmm8PLUPaQRuTZfeCvInmsHa/7BHoK8udyGBAjwJLk0WZZWMLunR8o6YEXn3rFVeB6m5FPsw7sh/xIgom+Ks1wbqunGQwwGlG0fSIdAfXixBcPyAf4eXgB5cemmsdlp4gvrwNiIs2bq/ivN6XZqMvmJBVNhs0BBoMI4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iPFWI56z; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723115069; x=1754651069;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=oD6xXik43LLrzGwz79CL7XcDa9KLyMBy2g5HtMhIZws=;
  b=iPFWI56zU+JLaggJHRNMe+RYvIOYxZ18PAAG0b+oOGHJDcwVk6OTzB43
   OnucPiXs785OwRw357xwADZNvZL/PxZL3mbx09YIvEXx17JPT4G+Gsa0e
   ciZc0Y37OdPcypxr0rYcLtDzj8JVnrfuORTuImsBH9lVK5w7vrMD1dcoo
   6cyCnECZZTjOTkhJK3Vn7OVJCKk1Q3E7oiXZ0H92Rl134N1KTbvhLZd11
   fxQhABqzoWYAsOrLV712uQ3Ukb7hx82rmsPWAreLfnqyfUWtoaw4raY+E
   E5YfvPasSkJ75PjSLrYP5UmenAiHSVSXOuZt7m8VjESY+0lp33U0ecbCt
   Q==;
X-CSE-ConnectionGUID: VkXzWrr4QPONcMbc2xK7kg==
X-CSE-MsgGUID: Nef5XVzvRVycZeiGw0N3Fg==
X-IronPort-AV: E=McAfee;i="6700,10204,11157"; a="21352615"
X-IronPort-AV: E=Sophos;i="6.09,272,1716274800"; 
   d="scan'208";a="21352615"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2024 04:04:24 -0700
X-CSE-ConnectionGUID: ipU250YfS6CODmHD08MWtg==
X-CSE-MsgGUID: B6eAKrmoT1a1bZV1ywylug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,272,1716274800"; 
   d="scan'208";a="56863909"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Aug 2024 04:04:23 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 8 Aug 2024 04:04:23 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 8 Aug 2024 04:04:23 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 8 Aug 2024 04:04:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q7Y9Sa0guEEY9TnnsnJLsgkeaHJckJU4hEDhgIWi73t2fqlOXdeDArFdamktC7AZxS/gMQypIIatSMWYhzfraQdQ99Oydj4tvFXzbKhIBPGBlehF050EU3jBxTO0yUdHfOx8cIirlBPS5QxI1AFO0r8caKm0tC0Dc3O3bvXrBB8smNwMD7i0NtEF+rQa6QTyGLCiza3paiMganjeocZPOVJCMHXKro1uLIEmHE3PFt+9gjsA8+vmQBh6nz1q65h0+i07ecXRILLrcRRILZLNMcfifHlHwvayoGtXIPilGwGTRqAZLb1xQQPzAPRI+0JdbYq0cTpsNiGNHO421Fby1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QUTaOiwScs4QDtUh8RhsoKLfPLZ8pxkoQdprCnGdx+s=;
 b=ielat+L5A8fK0xb8hbDGbG3UymJdMGOZb3f2siCfdZKMzvCpDZCpcvo5MILTLDC5ZMZTlNFx8yqxNvTzsufuyhIeFLoGCCoLXCe6kx3fNKueJEMI2saaWjXsM80G8zqWf3qspkOhEiRKQ5jQAU2xccRbIF2il25+0DpvCifcTMbbzoeC2Lpz25rq/ijY7mE6H54Mu744YZh+IbIuUc1ayLahtv4XSxeTqOqS/wg+4ITuGsu//XSmLdjqBnKESZKoz7dkErmrnpwSzqp80b85jyL/qOy1maKSYQ9zEqvgeTZ4VpScpZx0oMfB0WGWG037H5Qan5qyg8KFsU8AQTtOMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL1PR11MB5399.namprd11.prod.outlook.com (2603:10b6:208:318::12)
 by DS0PR11MB6375.namprd11.prod.outlook.com (2603:10b6:8:c9::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.26; Thu, 8 Aug
 2024 11:04:20 +0000
Received: from BL1PR11MB5399.namprd11.prod.outlook.com
 ([fe80::b8f1:4502:e77d:e2dc]) by BL1PR11MB5399.namprd11.prod.outlook.com
 ([fe80::b8f1:4502:e77d:e2dc%7]) with mapi id 15.20.7828.030; Thu, 8 Aug 2024
 11:04:20 +0000
Message-ID: <481ef288-f11e-4f89-933b-94bc723ea2eb@intel.com>
Date: Thu, 8 Aug 2024 13:04:14 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v8 02/14] ice: support Rx
 timestamp on flex descriptor
To: Alexander Lobakin <aleksander.lobakin@intel.com>
CC: <intel-wired-lan@lists.osuosl.org>, <netdev@vger.kernel.org>, Simei Su
	<simei.su@intel.com>, Wojciech Drewek <wojciech.drewek@intel.com>, "Simon
 Horman" <horms@kernel.org>
References: <20240730091509.18846-1-mateusz.polchlopek@intel.com>
 <20240730091509.18846-3-mateusz.polchlopek@intel.com>
 <12a5b7d3-bfc0-4885-a6b3-229ff3f513d9@intel.com>
Content-Language: pl
From: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
Organization: Intel
In-Reply-To: <12a5b7d3-bfc0-4885-a6b3-229ff3f513d9@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA2P291CA0034.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1f::7) To BL1PR11MB5399.namprd11.prod.outlook.com
 (2603:10b6:208:318::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR11MB5399:EE_|DS0PR11MB6375:EE_
X-MS-Office365-Filtering-Correlation-Id: 39469e6f-1d95-4d0b-b4ae-08dcb799da8d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZHNqT1VuR2p4VnNpa1ZqRW82NkZxY3J3RDJNdllpK2RsVVZJd3ZPZGJDZzZ2?=
 =?utf-8?B?bEtOR2RKMXRlMUhhTDNydHZEMmxmRGYrRXRaSFJtOHZpVnl6b3FnaC9wVUxX?=
 =?utf-8?B?a0tyeklsUnlZbjdBWE5IaE80RS9FTkZQUms2eCtPbjQ1VjFrbzNiaDJmNGhk?=
 =?utf-8?B?K0d2dmxXbW9oSmtiMzlscVRXRnlydkd0WEdXMFBZdkRvdHhYQTgxeWxROXQz?=
 =?utf-8?B?cStkK2dxRk5zZmlvblZ1cnhVV1pqd1N3UExnTGhRZTFBQmhZWWFGWVdpWmg4?=
 =?utf-8?B?a3ZGZmNYand6ZUtJMW81bHBXTStnZ2hTL1hoRFY4aWhQUEJ6UDdJNmUrS0pQ?=
 =?utf-8?B?cmpoRk5DRktGL04vdjBtQzRrbkl5aVIrc3dUVUVtRUl6c1BzWEVHczQ3eE00?=
 =?utf-8?B?M0IxRXphR2NTWlpvSDRjZkRzeXY5Y2VUeDNlNFFLelc5dE9sT3dpQ3ZPRm1Y?=
 =?utf-8?B?aVB5K0U5Z2R5U1dMalRtOUc1UU4vQmxEenlhWEJvM0RJR05uVkt0VWFSQUIz?=
 =?utf-8?B?dHdqSTNkeGlWbEdXTDZZSnZRRmRvNDQyTEYxU2tJNmpsN0RrM21pRnpuN3Zv?=
 =?utf-8?B?L2RPN2dVSGNjMkpRNmo5UnlNVStnQUg0ZEtQMC9SNnJhbUdla0x2dzI3c2w3?=
 =?utf-8?B?TENESlhhanZBdFRzeHhtb2ppdU11cWF2QkhCNlJtcHFZTklOUU5kbWFhUzdw?=
 =?utf-8?B?bEVtTHExeVNDNGppWkZ1WWxrNVFCcnNWUDV4MzF3R21MRW9RTldIM28rc2Q3?=
 =?utf-8?B?eFJ6TS84RVh1Z1NsNkZDYnQ0MzdOalJXVE5sY0pFbEhYVzJCTVJXOHdDbEZO?=
 =?utf-8?B?clJUQkVDekNldmRsUDczUU5nbFhpYXk5d3Q5WVpyeDdvRkd0bWk4enRaZ1BN?=
 =?utf-8?B?ZmxPRllBWXFaeTRZTHZoUEhzMVg1ZENyem1udGorSkdkS1N5bUtzTFVSSWlh?=
 =?utf-8?B?U2t6bFNhNzcyRkc3K3lDYXl2M3F3enZUNnhGZk80YzZTYVpydlJ2QjBUcGxL?=
 =?utf-8?B?SmNMY0lkQkdCd0FYTXdoOFpsUjdQbk11VGlrdVcvL3BzQ09SaTAvbXZFUTlF?=
 =?utf-8?B?MmhGcWR0OHZHdk5sQlJIeUhXK01zVlZoKzJKNHg3Umh6YXBhV0pSQnprNmRS?=
 =?utf-8?B?SUtjVFducHQzT0s5MkNPdTJyeUNvUVN5MERVcDZONlNUQWRHRTErV3pKVnN1?=
 =?utf-8?B?djdqdkFyazJia0ZlbnZCN3E2QnpTbG15ckN1Q2pRdFlxRjN5V01UUU1HWVdY?=
 =?utf-8?B?Y0pTTE8wLzEwd1RXOWNQY0VqL1VzbmxCU0ZpTGc2WDh3bmR2MnhHVmhaZ0E0?=
 =?utf-8?B?dlk0ZUY1Rnp2Rkh2WS9ITEQwYVlEdTZnVmNLMHpBWGQ4amlud1NJZGhqRFVR?=
 =?utf-8?B?RTdhbmVNWVo2cENzZTVyRGhHUDgvV2tYam9WZThuWUZvNVZzb0k1b3hCZURT?=
 =?utf-8?B?TjI5YWlpck9YU0VtNzNoZG5TczB2T3ZSOGhlYlYyaTYrdkJYMXpDQnJBZHk1?=
 =?utf-8?B?bnNwWVFZZUNrQ0RCSlZUeEJqMkUyeEMvSksxa2UyRXJUSWNaUHIwaVBqdk4z?=
 =?utf-8?B?ck9MUEl1YVBFQTh2STVlMW56cGZub0dpQVd1TkZBTFdSWExDVWpHZURDR005?=
 =?utf-8?B?RmszUWU0d2t1M1lWb1VxRk0rSW5NWXRQUkJTcG4zTnR3UFV2b1V0cUxjbHd1?=
 =?utf-8?B?ZzN2WUhPUldoYU1CM3hxazkwa2xRL0hkZjZtZHB4T3l1ZUd4UnRyQUlHTkhn?=
 =?utf-8?B?R2l0c29OR0JhZXZBMzJvMDZ0Tk1MOWhYd211cmJIUFJYYkhBb1lRamN0Njlx?=
 =?utf-8?B?eklQYUtJRXdZb2hxME9uUT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5399.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NjRRUW8zdFlGK2NtS3JmeHU4RWhRRER2NEhLOHhHNmxhdEVzZUg3ZmNtMU1R?=
 =?utf-8?B?cUpWQVAwQWxQckxhMktkLzBwZ1Vlc1pGTDhONVV1WWphZFhHd2kxOUgxYlBC?=
 =?utf-8?B?K3ZUbUdqazFES05DbmRXZGFNK3VPeFRUYk9UeFJlSDRIbkUvK0krZkRGZUFG?=
 =?utf-8?B?ZDZFdkdSL2orWmVzeWRiVHRDQXdlYWNqZEZaUmQ1a3poOXdOVWRoK1FoY2Fx?=
 =?utf-8?B?SW5RcEF6Ry9yMEl0RTV0U3VIMjErTHlvSGhtMU15cGdvYVREbytxN2RZVUF5?=
 =?utf-8?B?QkF6R0pxMEloT3lMWTlOY1c1bjA5VEhxUGtLTjZ5OEh1Yk9Kd2ErV282TnBN?=
 =?utf-8?B?TW0xcWt0S0xBL0tLVER1NlJYaUp3bi93YXJJWEVCSWc0Wmtyalc5cWNoSUxj?=
 =?utf-8?B?Q2hXUVlLOTBtQldDNi9abVZ5bjlOM0RlRTFYNzN1Wk9wakFlSmJTN0h3YkJy?=
 =?utf-8?B?VEtEcWU2OGdXSHRHbTBqZE1XQXhiRzNlMGdYSG8wV3AyemxJbzhmRjNaV09J?=
 =?utf-8?B?d3dya00vejUzWnFyNjRDWHZvWk8waEhaZHVWYmtMcFdLbDZtNm9XZ0cxL3lp?=
 =?utf-8?B?WFdNV2JQUHZQQ3RWbjNLQW9UOHM3OFVZMmd4c2F6ZzhQUVRCZVhNS0ZCZEhH?=
 =?utf-8?B?dndTSWw5ZUc0UGozRkZjQ2ZJM0pyM2tZTzN3bmdnb1pra21IZzNaaWwxVS94?=
 =?utf-8?B?TURuYkJibmNwSWhIdDlhc1ZvLzQxeGFlME92M0JkN0JMWjhJcHpKQlRrUkdF?=
 =?utf-8?B?QWlMck8vMUlvZ09OVTJENUxreStaMzZ3UXlWU2ZGSnUwVTVJZ1BtVWgwRmNv?=
 =?utf-8?B?YzNXcG5Rc2p0dzdST2ZaQU1VMjVWZDcwMVlOZnFGSE1XVitpWFdocWNhcGkw?=
 =?utf-8?B?Mk5zSlhyMlo1bnZyOWRaV0krU3ZrM1Noa0p4bGd1QTlmR0MzY01iczdMSC9n?=
 =?utf-8?B?WlVSTEcvMXkrODNpVXhVa2FiczJhNGNWV05sLzJvdG9ucHpPc1lRa3lzYUZM?=
 =?utf-8?B?SEVIMXZ0ck5vbXp0Y2NOQVpqS0xCYnNkWXhYQm5ZSEhHeHhUM2JuUGdYaEtK?=
 =?utf-8?B?dGg2ajNnQUFaQVBhZjdSN2hldDR2RXBIelRXLzcxMThuS1ozRlVVZGplYnY5?=
 =?utf-8?B?T01jU3AvV3pDQUdzRDBGTjQ5blFOaVRuS0l4M2poZzUrN0d0b1BKZEtrY1Bh?=
 =?utf-8?B?dDBzcmxSQ3daOW1vZGNvZHJjMnl1QWlDRmhaRU9UVEtpUDJWallsRGRZeVlJ?=
 =?utf-8?B?MTVyOVBONWd5WnNqRjJ1d0x3a1Uxa2VISkRTLzVuSi8xNVRmNEdhbndYclBo?=
 =?utf-8?B?ZFZOQlFxTFRqeE5YdVgvbVBha2xSUGFVM1diZ1RQVFJaS1B4WDNzcDRxVmdU?=
 =?utf-8?B?aXRERHlDSnFWSW9TTERNUldXY1ZlZTM0Unc0aWRaNVhKTGxXNkhiajZiMW43?=
 =?utf-8?B?Z2JxMzh1TGxFOTA2UzFweFpFM3RFc1Y1YnY5TEtsRUcrQ3R6bGo2NEc3akRn?=
 =?utf-8?B?Wkl0cGpnT29ISE41ZmZWYmFVcFhMY29BZVFnWng1MkFTRmlZS2k4Qko0Smhr?=
 =?utf-8?B?Zm9RWldQY1lLYktuSHZMbHJpTU85TWlrNE8wV2cvWHV5RUY5QkpvblZvYkdK?=
 =?utf-8?B?b0hFMWhuOWpiYVB4WEVVa0tPd1lWaHhzdE5sdHFlVzRFMC9aK2tkaE5PUkI4?=
 =?utf-8?B?emF2UVJMQy9sdzBraHZhRDIvWWdLR045MTRlZnkyZ3VGMHQ1L1BrYVlOQS82?=
 =?utf-8?B?K2grTUNxUWwreThBV2ZHYWNZNnlDT0JjM3ZncFdhbU1MeVBWWHJKejdBdXlP?=
 =?utf-8?B?SXJJVm5ZaXZ1MnZDUHVHVnNaYkY4L0hLMytvem1hZTROYlc5SjBxbmQ1OWpk?=
 =?utf-8?B?VnhRQ09mQTh6d1pwQXowSnVuR3ExL1A0bm8vMlpnR0wvTWNDcnBRaTQ3a0Ex?=
 =?utf-8?B?UjlaS3FmNWJSc2FwQlgyZkdtc2ovMno1V2xhS0hDcldMNUp4QnhTNWRGd2hu?=
 =?utf-8?B?K2ovb0Rvd2wvWVEyR3lWdGl4R25ncDNaaVppcDdxWElsN3g4RzJucmc2akhH?=
 =?utf-8?B?dVB4aGgwUGhFOFMxaFVWeERac3RyL3pYZnVGSnhKa3hRbnFxWU15OEJlUEdz?=
 =?utf-8?B?Q2xsbGxERHJ3YUZIRWYxWmdLY1VoQ0NTMHRxM3dYVittdWdaSE9sK1VxWExE?=
 =?utf-8?B?YkE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 39469e6f-1d95-4d0b-b4ae-08dcb799da8d
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5399.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2024 11:04:20.6606
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: haYukS0wLSpyObINl/JEEk1atm2tC4qY/1fvHAZU6UW0sP8zlqzdQgY9d+lKMSsQrwRFX1PKefcMs96fTJTah7quCmKNnVQCwR0Vf+lYH+0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6375
X-OriginatorOrg: intel.com



On 7/30/2024 2:54 PM, Alexander Lobakin wrote:
> From: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
> Date: Tue, 30 Jul 2024 05:14:57 -0400
> 
>> From: Simei Su <simei.su@intel.com>
>>
>> To support Rx timestamp offload, VIRTCHNL_OP_1588_PTP_CAPS is sent by
>> the VF to request PTP capability and responded by the PF what capability
>> is enabled for that VF.
> 
> [...]
> 
>> diff --git a/drivers/net/ethernet/intel/ice/ice_vf_lib.h b/drivers/net/ethernet/intel/ice/ice_vf_lib.h
>> index be4266899690..fdc63fae1803 100644
>> --- a/drivers/net/ethernet/intel/ice/ice_vf_lib.h
>> +++ b/drivers/net/ethernet/intel/ice/ice_vf_lib.h
>> @@ -136,6 +136,8 @@ struct ice_vf {
>>   	const struct ice_virtchnl_ops *virtchnl_ops;
>>   	const struct ice_vf_ops *vf_ops;
>>   
>> +	struct virtchnl_ptp_caps ptp_caps;
> 
> This struct is of 48 bytes length, but only first 4 of them are used
> (the `caps` field). Couldn't we just add `u32 ptp_caps` here?
> 
>> +
>>   	/* devlink port data */
>>   	struct devlink_port devlink_port;
>>   
>> diff --git a/drivers/net/ethernet/intel/ice/ice_virtchnl.c b/drivers/net/ethernet/intel/ice/ice_virtchnl.c
>> index 82ad4c6ff4d7..4f5e36c063e2 100644
>> --- a/drivers/net/ethernet/intel/ice/ice_virtchnl.c
>> +++ b/drivers/net/ethernet/intel/ice/ice_virtchnl.c
>> @@ -495,6 +495,9 @@ static int ice_vc_get_vf_res_msg(struct ice_vf *vf, u8 *msg)
>>   	if (vf->driver_caps & VIRTCHNL_VF_OFFLOAD_USO)
>>   		vfres->vf_cap_flags |= VIRTCHNL_VF_OFFLOAD_USO;
>>   
>> +	if (vf->driver_caps & VIRTCHNL_VF_CAP_PTP)
>> +		vfres->vf_cap_flags |= VIRTCHNL_VF_CAP_PTP;
>> +
>>   	vfres->num_vsis = 1;
>>   	/* Tx and Rx queue are equal for VF */
>>   	vfres->num_queue_pairs = vsi->num_txq;
>> @@ -1783,9 +1786,17 @@ static int ice_vc_cfg_qs_msg(struct ice_vf *vf, u8 *msg)
>>   				rxdid = ICE_RXDID_LEGACY_1;
>>   			}
>>   
>> -			ice_write_qrxflxp_cntxt(&vsi->back->hw,
>> -						vsi->rxq_map[q_idx],
>> -						rxdid, 0x03, false);
>> +			if (vf->driver_caps &
>> +			    VIRTCHNL_VF_OFFLOAD_RX_FLEX_DESC &&
>> +			    vf->driver_caps & VIRTCHNL_VF_CAP_PTP &&
>> +			    qpi->rxq.flags & VIRTCHNL_PTP_RX_TSTAMP)
> 
> A separate set of parenthesis () around each bitop (& | etc).
> E.g.
> 
> 	if ((vf->driver_caps & FLEX_DESC) &&
> 	    (vf->driver_caps & ...))
> 
>> +				ice_write_qrxflxp_cntxt(&vsi->back->hw,
>> +							vsi->rxq_map[q_idx],
>> +							rxdid, 0x03, true);
>> +			else
>> +				ice_write_qrxflxp_cntxt(&vsi->back->hw,
>> +							vsi->rxq_map[q_idx],
>> +							rxdid, 0x03, false);
> 
> Looks a bit suboptimal to double the same call with the only difference
> in one argument.
> 
> 			bool ptp = (vf->driver_caps & FLEX_DESC) ...
> 
> 			ice_write_qrxflxp_cntxt(hw, map, rxdid, 0x03,
> 						ptp);
> 
> Also, this 0x03... I'd #define it somewhere 'cause for example right now
> I have no idea what this is about.
> 
> 
>>   		}
>>   	}
>>   
>> @@ -3788,6 +3799,65 @@ static int ice_vc_dis_vlan_insertion_v2_msg(struct ice_vf *vf, u8 *msg)
>>   				     v_ret, NULL, 0);
>>   }
>>   
>> +static int ice_vc_get_ptp_cap(struct ice_vf *vf, u8 *msg)
> 
> @msg can be const.
> Also, I'd make it `const void *` or maybe even `const struct
> virtchnl_ptp_caps *` right away.
> 

I am afraid that I can not do that in the scope of this series. This
touches virtchnl messages and seems to be bigger code refactor. I think
in the future we can think about redefining it but not in this series

>> +{
>> +	enum virtchnl_status_code v_ret = VIRTCHNL_STATUS_SUCCESS;
>> +	u32 msg_caps;
>> +	int ret;
>> +
>> +	/* VF is not in active state */
>> +	if (!test_bit(ICE_VF_STATE_ACTIVE, vf->vf_states)) {
>> +		v_ret = VIRTCHNL_STATUS_ERR_PARAM;
>> +		goto err;
>> +	}
> 
> Alternatively, you can do it that way:
> 
> 	enum ... v_ret = ERR_PARAM;
> 
> 	if (!test_bit(ACTIVE, vf_states))
> 		goto err;
> 
> 	v_ret = SUCCESS;
> 
>> +
>> +	msg_caps = ((struct virtchnl_ptp_caps *)msg)->caps;
>> +
>> +	/* Any VF asking for RX timestamping and reading PHC will get that */
>> +	if (msg_caps & (VIRTCHNL_1588_PTP_CAP_RX_TSTAMP |
>> +	    VIRTCHNL_1588_PTP_CAP_READ_PHC))
> 
> Bad identation, READ_PHC must match the parenthesis it's enclosed to,
> i.e. the second pair, not the first/outer one.
> 
>> +		vf->ptp_caps.caps = VIRTCHNL_1588_PTP_CAP_RX_TSTAMP |
>> +				    VIRTCHNL_1588_PTP_CAP_READ_PHC;
> 
> Also, hmm, can't that be
> 
> 	u32 caps = VIRTCHNL_1588_PTP_CAP_RX_TSTAMP |
> 		   VIRTCHNL_1588_PTP_CAP_READ_PHC;
> 
> 	if (msg_caps & caps)
> 		vf->ptp_caps = caps;
> 
> ?
> 
>> +
>> +err:
>> +	/* send the response back to the VF */
>> +	ret = ice_vc_send_msg_to_vf(vf, VIRTCHNL_OP_1588_PTP_GET_CAPS, v_ret,
>> +				    (u8 *)&vf->ptp_caps,
>> +				    sizeof(struct virtchnl_ptp_caps));
>> +	return ret;
> 
> 1. return ice_vc_send ... directly.
> 2. Try to declare abstract message buffers as `void *`, not `u8 *`. u8
>     is rather for cases when you need to actually read some bytes from
>     the buffer.
> 
>> +}
>> +
>> +static int ice_vc_get_phc_time(struct ice_vf *vf)
>> +{
>> +	enum virtchnl_status_code v_ret = VIRTCHNL_STATUS_SUCCESS;
>> +	struct virtchnl_phc_time *phc_time = NULL;
>> +	struct ice_pf *pf = vf->pf;
>> +	int len = 0;
>> +	int ret;
>> +
>> +	if (!test_bit(ICE_VF_STATE_ACTIVE, vf->vf_states)) {
>> +		v_ret = VIRTCHNL_STATUS_ERR_PARAM;
>> +		goto err;
>> +	}
> 
> Same here regarding @v_ret.
> 
>> +
>> +	len = sizeof(struct virtchnl_phc_time);
>> +	phc_time = kzalloc(len, GFP_KERNEL);
> 
> 1. __free(kfree) for @phc_time, so that the function will auto-free it
>     and you won't need to call kfree() later.
> 2. Since @len is trivial, just open-code it here:
> 
> 	phc_time = kzalloc(sizeof(*phc_time), GFP_KERNEL);
> 
> then later
> 
>> +	if (!phc_time) {
>> +		v_ret = VIRTCHNL_STATUS_ERR_NO_MEMORY;
>> +		len = 0;
>> +		goto err;
>> +	}
> 
> 	u32 len = 0;
> 
> 	if (!phc_time) {
> 		v_ret = NO_MEMORY;
> 		goto err;
> 	}
> 
> 	len = sizeof(*phc);
> 
>> +
>> +	phc_time->time = ice_ptp_read_src_clk_reg(pf, NULL);
>> +
>> +err:
>> +	/* send the response back to the VF */
>> +	ret = ice_vc_send_msg_to_vf(vf, VIRTCHNL_OP_1588_PTP_GET_TIME,
>> +				    v_ret, (u8 *)phc_time, len);
> 
> (same regarding u8 vs void)
> 
>> +	kfree(phc_time);
>> +	return ret;
> 
> Since kfree() won't be needed, just plain return ice_vc_...
> 
> [...]
> 
>> diff --git a/drivers/net/ethernet/intel/ice/ice_virtchnl_allowlist.c b/drivers/net/ethernet/intel/ice/ice_virtchnl_allowlist.c
>> index d796dbd2a440..7a442a53f4cc 100644
>> --- a/drivers/net/ethernet/intel/ice/ice_virtchnl_allowlist.c
>> +++ b/drivers/net/ethernet/intel/ice/ice_virtchnl_allowlist.c
>> @@ -84,6 +84,11 @@ static const u32 fdir_pf_allowlist_opcodes[] = {
>>   	VIRTCHNL_OP_ADD_FDIR_FILTER, VIRTCHNL_OP_DEL_FDIR_FILTER,
>>   };
>>   
>> +/* VIRTCHNL_VF_CAP_PTP */
>> +static const u32 ptp_allowlist_opcodes[] = {
>> +	VIRTCHNL_OP_1588_PTP_GET_CAPS, VIRTCHNL_OP_1588_PTP_GET_TIME,
>> +};
> 
> I'd make it 1 def per line, not two in the same line.
> 
> [...]
> 
>> diff --git a/include/linux/avf/virtchnl.h b/include/linux/avf/virtchnl.h
>> index 5edfb01fa064..c4e7ac19be7c 100644
>> --- a/include/linux/avf/virtchnl.h
>> +++ b/include/linux/avf/virtchnl.h
>> @@ -304,6 +304,18 @@ struct virtchnl_txq_info {
>>   
>>   VIRTCHNL_CHECK_STRUCT_LEN(24, virtchnl_txq_info);
>>   
>> +/* virtchnl_rxq_info_flags
>> + *
>> + * Definition of bits in the flags field of the virtchnl_rxq_info structure.
>> + */
>> +enum virtchnl_rxq_info_flags {
>> +	/* If the VIRTCHNL_PTP_RX_TSTAMP bit of the flag field is set, this is
>> +	 * a request to enable Rx timestamp. Other flag bits are currently
>> +	 * reserved and they may be extended in the future.
>> +	 */
> 
> Make a proper kdoc from the first sentence and leave the second to the
> end of the kdoc.
> 
> /* virtchnl_rxq_info_flags - definition of bits ...
>   *
>   * @VIRTCHNL_PTP_RX_TSTAMP: request to enable Rx timestamping
>   *
>   * Other flag bits are currently reserved and ...
>   */
> enum ...
> 
>> +	VIRTCHNL_PTP_RX_TSTAMP = BIT(0),
>> +};
>> +
>>   /* VIRTCHNL_OP_CONFIG_RX_QUEUE
>>    * VF sends this message to set up parameters for one RX queue.
>>    * External data buffer contains one instance of virtchnl_rxq_info.
>> @@ -327,7 +339,8 @@ struct virtchnl_rxq_info {
>>   	u32 max_pkt_size;
>>   	u8 crc_disable;
>>   	u8 rxdid;
>> -	u8 pad1[2];
>> +	u8 flags; /* see virtchnl_rxq_info_flags */
> 
> Or
> 	enum virtchnl_rxq_info_flags flags:8;
> 
> -- will do the same thing, but with strict type.
> 
>> +	u8 pad1;
>>   	u64 dma_ring_addr;
>>   
>>   	/* see enum virtchnl_rx_hsplit; deprecated with AVF 1.0 */
> 
> Thanks,
> Olek

