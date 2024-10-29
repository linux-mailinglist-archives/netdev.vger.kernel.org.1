Return-Path: <netdev+bounces-140143-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CECC9B558D
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 23:09:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C1A2283E66
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 22:09:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 182B3209F4B;
	Tue, 29 Oct 2024 22:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZTc6gOGk"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9624F205E2E;
	Tue, 29 Oct 2024 22:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730239771; cv=fail; b=h4qLPmyq7UKF7taQi2EbzkLAbQ9ONnhcACmbVxaEYnv3rzmklNLqjRfNUfw7mYAuL3TN3qiEaj2fDxx6VF7rGS+2QuPtnwjsCyPNluGi7wCggwQpoxkinjsI3g3T5hAyLddfeRFaebRNKh4IIdPKrLQErGWOl7jemVxWn/xu+9M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730239771; c=relaxed/simple;
	bh=JoAp9cuqRVrNuTusnTPZKgFOD6MLJzhCOavkMm3xe5E=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=m9Ry5xsvRQ4t/Ci5eoDY/KVryO1+cuDAWAvHSWvAwyLkaWZsDC/yBlDYZXHN+LH4rvwR9wP6qoh9ojB4+CzQUdMwimCam5Qba1fE/GysAxmxO2g06RXZs1USLvYIAl1joxnLKkw3vpnG5JZFt14YhIEtga9GFQ6SUU8sGMa4zAE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZTc6gOGk; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730239769; x=1761775769;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=JoAp9cuqRVrNuTusnTPZKgFOD6MLJzhCOavkMm3xe5E=;
  b=ZTc6gOGkfGuO5WZYl4YlAqkyaK2ScDEpOx7jGPanobLYIb7Lymv4pm4O
   xpH+n6PbOU4+0+8iylthkdotC4PaKDwI1SHZ7Iv39QAjEF9oxEaHnnUPz
   qyss9mMmdLxZhAvuIeoNK8bobvzTuFg7bhD+V04cSm7X8TUnFcf6SjIzy
   zDcnZoDjdJcU0qhB4e6lqoaz8/ojIVz+PevQUu5MlRpHfuKDLEHqrEO5g
   O8+toB8ToKczWkaWG6y8/O/zmx1roxnh9p8+rgxwLFY3BiFcEcB9+RV4w
   ZWKPwRPwrClEza9f5n6zo4KSQ6FcG/3KvQ8+gtjSpfjyUcbZFqv+rtKq+
   A==;
X-CSE-ConnectionGUID: lS973fyDQx6NpcsFUhaeLg==
X-CSE-MsgGUID: aMP7WzwbQBu/0DIi4eoVNg==
X-IronPort-AV: E=McAfee;i="6700,10204,11240"; a="32760876"
X-IronPort-AV: E=Sophos;i="6.11,243,1725346800"; 
   d="scan'208";a="32760876"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2024 15:09:26 -0700
X-CSE-ConnectionGUID: J8Ji638ARaqCe4Bf5q0Deg==
X-CSE-MsgGUID: Z6L6J0AaTo6LpwQVvqZ/qA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,243,1725346800"; 
   d="scan'208";a="82525087"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 29 Oct 2024 15:09:26 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 29 Oct 2024 15:09:24 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 29 Oct 2024 15:09:24 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.176)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 29 Oct 2024 15:09:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cgZoIDz4+Euixvu02rE9oDegRIBhtvPc8bEY4KCu7b7KQ15LqhJ7Feg66LnWUnYDKnN7LggstVx7OEDWqxsrA10ceU6Lojdke+XwN4p+YfBQZUtZO7+kNmXlgXEe4gnM87UVNm8HU3LQ1aZ3/ZV08HL/AzFVPdfqffAANSxQ0jm+XGWTSZbdE4lAtQCibL1JUHa7W/f3qAYSNnZYjeaChtqr8VaFUmp5plqN+AjtqFGdk4k9UnuxTFz0v3Pn9jLSmD32qsSdTIAbcZuvWK/UesLk+dAIE59x7ys+EeLqaoNNRH7tjSyLv5f7lEndpDTzkdS/IK7xHvA+/8wPLu24fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wFiMlpjYgOd8KTrsu+E47mYd6eQkldkQoELEsWEJseg=;
 b=ZkvyZVs63E8jdLuS5oMMdAcfqrmaVoyDQWO2TGG8wcezlJIBixyi/fSRfD5wfMdE1kw3nCsVcO49V1P4Jax4iyur4CFtK4v/41/0klWXTTyz4+ESCcIN4MiXw2FKT2jilQAYjcYcoVIW4djrsgvwnvLKoojpp72kLCf6cavy55geMDp0GJJwEl/FJS5rgZhTwLGolqW4sfhn1wKUpAi5Ivpxvho5rNtN1ZMG15aPLIXOLwoHH3DEkRB3msrPlGgZsSnwTbJRwLKcwcWXwhs4DYiafv/36/duBG1BstwQG2ExDwDKF2wH+M4PX5n3DC7p6+IACVQasIeeA8mmgNMbwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by SN7PR11MB6653.namprd11.prod.outlook.com (2603:10b6:806:26f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.27; Tue, 29 Oct
 2024 22:09:21 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%4]) with mapi id 15.20.8093.027; Tue, 29 Oct 2024
 22:09:21 +0000
Message-ID: <8e1a742c-380c-4faf-a6c2-3fa67689c57e@intel.com>
Date: Tue, 29 Oct 2024 15:09:18 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 6/9] ice: use <linux/packing.h> for Tx and Rx
 queue context data
To: Daniel Machon <daniel.machon@microchip.com>
CC: Vladimir Oltean <olteanv@gmail.com>, Andrew Morton
	<akpm@linux-foundation.org>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Tony Nguyen
	<anthony.l.nguyen@intel.com>, Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Masahiro Yamada <masahiroy@kernel.org>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>
References: <20241025-packing-pack-fields-and-ice-implementation-v2-0-734776c88e40@intel.com>
 <20241025-packing-pack-fields-and-ice-implementation-v2-6-734776c88e40@intel.com>
 <20241029145011.4obrgprcaksworlq@DEN-DL-M70577>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20241029145011.4obrgprcaksworlq@DEN-DL-M70577>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0009.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::14) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|SN7PR11MB6653:EE_
X-MS-Office365-Filtering-Correlation-Id: e0668b90-6b4a-478a-0ef6-08dcf866573c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bEx1SlBFMy9UaGgzU01vTnhSVEpuV1c3U3BOdjdISWNBVFpzdE0zeCtzNjNE?=
 =?utf-8?B?WXhjTjRBRnc0NXlyOHY2RFFqakdwM1hDWS9tTWRDZktRbDFMNVJhZGxFeE1S?=
 =?utf-8?B?VUNrZFFRWE9JZUlIWmZnQkZMMUwvTXBiR3BWcm5ibTVaUUZwQjAvTlI1bTJn?=
 =?utf-8?B?cEUyR2lVM0JwK2RuNyttT0tEK1VqU2FNTkMvbjl5NlBpcTcvUXl5enpnL05i?=
 =?utf-8?B?cnFrS3lncyt1K2ZTT3c0dHVqd1RsalRyUGVqanA0NWZiUVp5TkpZVnpuOTZw?=
 =?utf-8?B?MVh3b0NKQmw4cndUM1VOWGFLRjl6OGpuNFltYVQyeUw4WGVEN3k2ckNLUUpL?=
 =?utf-8?B?YS9COEFML2t3Wi90RlhiaWlha2MxSzBnZjZzWENUdk1MR09kWXFWSitWZ2RE?=
 =?utf-8?B?bDVLQmdoellnZU5JQUlLZ3lEd2RLYm4zczlYY253TkorVG5TUUg1RzZqdUtl?=
 =?utf-8?B?K2dmVHNITThYWFErZmFaUjdLSU9FUWx3VCt5cHd5U0JqVk03bXpCZGFCWDdq?=
 =?utf-8?B?bWtqNDFlbllMQnVRM1pmMGpOTnQwamxBUHpXemtONzc3SmhqQ1o4THBXZmVR?=
 =?utf-8?B?MG8wUGplQ1BzL3ZVZzJrRjNaOUNqeitTMmszM2dPMDFFdmhaUUFyUFpMOUtI?=
 =?utf-8?B?SXpQSEFESzVtR0J3d0U3cnlSYUc2NVFKMHZGVlZOLzdBRUxPbmJnZnd3MHhG?=
 =?utf-8?B?NnM5L0R6K3diQUtZVCtBZW9Fem11MXhVREVZSEdocjdRb1ZqaE5mQW95eC9N?=
 =?utf-8?B?U2oxR3ZSemFZMW13bjhLNTFrVmU1RUtRZmdoZlNpRXlFWEZKREFnU3k4MGVl?=
 =?utf-8?B?NjVsR0RuVW1UZzBTNnRjMjlETy9OV0gzTHRBUGtzYnlUVkhoeFpnWEZhVCtt?=
 =?utf-8?B?RkQwTVk1akx1eURHajdLdUFXYVNIQjJxVnU5MlFib1VzT0JVRDB2d21OTnoy?=
 =?utf-8?B?eXRrY2dwVk9qWjM1U1ExVnNUV1FDYjcrYlR5VlF6NnpMSytKNnp6YkdGYld1?=
 =?utf-8?B?alNQZmhFeVl5dUtlVzNSWWhuK0o5VWozeElvTk1HWmlmMmliZGhncldjdGR1?=
 =?utf-8?B?SFIyQ01TRXVWOW1FdSsxd0pvcVZnWnYvSGNXTGVLWGN1SDBQSEloT3d1eFor?=
 =?utf-8?B?dFM4R0xUY0pEV0JOV3crb3BsYjB5N1pVcVpJZ2pvOGY1MHlYSDlkejI0S3Ba?=
 =?utf-8?B?TFZMOWJOWG5Wd0E3bWtQSWhIVVg2Z2dxc3R5YVRBUnZ0Q0NrUDVKdlJPeGk1?=
 =?utf-8?B?cHFkd0I0S2N1dWtyc0R5YnIzM0VlUzZjODd0K1k2amJJemJsVDU1VytGcTVq?=
 =?utf-8?B?NGdGZThzeXhxN1RTNFhpZEQ5c0RFZTA1dVU4YVJaYU0rRlB4UElFT3JPaDQv?=
 =?utf-8?B?d1p0YWFNMHBLVDk4SmRNdDQ1TFlXMit1Tk5sNFRUMEg0L1FLUGlEaUVUNFhi?=
 =?utf-8?B?ZnlPY2xXcUgrNGIvbW1qb0pFU2pDcWxSOWxldGMwY2lvWVJwNkV0WW5RbUpS?=
 =?utf-8?B?U3RWbGt2UFhkTmNpMXZrcEtrcElZNHc0blJPc01YTVZWcjB3SCtvVURnWXZx?=
 =?utf-8?B?QU9CMmFtN1UyRXo0ckNxbTZKenBlUmVNM1MwenpmeXUzaXhwdlNIcXhvUlBs?=
 =?utf-8?B?YkdoREVCTXVLcEpiTXgzaFJsamhCK3hjVDJ1QnZ2eHRWUDQrbUpUa2RHTFMv?=
 =?utf-8?B?U0FWa0orbHF5dWYzQ0lGN2xaUjZFMkV1SU9EcG8xMVIzQmRET3ZuNHhlMTNN?=
 =?utf-8?Q?Q1EFrxg+B09qZeA1Fk6Jz/ZIFTSuvkVQM19q6H4?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MHg2N3JISFlRNDdEaTNYaklVTE45Q2ZLUk5BanJsMisxQkxmY0Z3QjZyakNk?=
 =?utf-8?B?ajFYSDgvbUhmemxEU3d2cmU2NmFWTkVKZVpuV0tsVGxiK3ZGTVlxWjhuQ1VM?=
 =?utf-8?B?aE9kSFQzTkF0b3FsYWk2TGdLekQ5L3dLRFg1TFhFaE80TjBvMTMvOTBpcU1J?=
 =?utf-8?B?N0pOUWdSYVlZSHZtZGtTUEw5a1NSY0doZ2FScXZwRTl3NDBEUEppcHdoaGxv?=
 =?utf-8?B?Ylc3ZGF4UHUzSzZPcEF3VGUybWg2akR2SXpVVFZFU0VxalJmMWxSbDk4cFRl?=
 =?utf-8?B?S3RoUzZJU05SZm1NR3dKaHlTV09xNjRoMkxJTnN6RHMrSUpUODR0akZicnFW?=
 =?utf-8?B?VDgzV2xVY1c5MDRuekZHZUJDOFZUOStBK3FrazBZZVB4cGRpcHJLQlEzbzFv?=
 =?utf-8?B?TzdhODNMRjFZTHBvUE14b0NjUnJ4UEdnb3cwRUtSMi83K2VLRjBvVzR5cTBi?=
 =?utf-8?B?WHVNbE9WaTBwZFVnMi9BMGxNaDJTWlFMUysvWVZ2cGVRbFZrVEpDTDlzZTJK?=
 =?utf-8?B?dlVjLzhJRCttT3Bwb1N2WEtpY1k2VWtxYy9mQ2Rjc1ZSakp1OEh6VTJZNVA4?=
 =?utf-8?B?RU1rT0VYWWRqMWl6anVaZm85RThjalNmTkJrRjlnczZQOEViNk5QL1FzR3hE?=
 =?utf-8?B?c05KOVNxSTA1ZnJJYUNBbEhLNDFYTm1nYUpmaGJRWEEwbERDZC9OSHBENmEy?=
 =?utf-8?B?aWowK2JWWVdZK0ljTzVpYjBWaitCMmVtWXkxelJsL0hnNDlyYUt3c29ndkNG?=
 =?utf-8?B?K0VlcmJRcmxEZDZGc3V2OTMxVWtJaDZURm01UFE0ZjFwMmtpbTU1ZE4vTkhs?=
 =?utf-8?B?MEdYL0JUdU9NZGY3MEpJUUdDbTNDVElsOVJWeC9tL0RHamVDbmtJREhlWWdi?=
 =?utf-8?B?YVR6QWpzaXAvNWQrVlltOXdpbnpIdnBiRWNuRTlMQlFWMnBMMTVyeEJLNVhG?=
 =?utf-8?B?Szg4NUtTOGZGNGhSQkhSR3lTR2lRZUhpVHYzc3ArdWN3U1hGNEhPVDBUMmtr?=
 =?utf-8?B?VFFqSGEreGxRWUk2a3BjT25NY254eGdob2JrNnU2TWthSnU1OXA2Zk9qWUgv?=
 =?utf-8?B?OFcxMVBwa0ZvZW5JU1cvY3dqNjRuUDg1a3JyMExuRXlhL0xhWVlXSzBEMkd4?=
 =?utf-8?B?aUYzUjRXVTIrWHgvZVNxVnBLenNIT21IZ2ZLOVFNWkxzRFhZWlZKTFk2Uzhy?=
 =?utf-8?B?cWFlR290V1I5RnVRd0E0YmtQVEo1dXRJUDVZQm52eHA5VTVtOFVJMDNKbmNj?=
 =?utf-8?B?ajVqWm9IUzk4MUcrOWNMUk1XdTl0aDMvbUpoNjdLbGVyNGdOdzN2d3BweWVV?=
 =?utf-8?B?bS9wdklYVG1TL2cvbzJhKzlPVkZsMkU0bWpVVTJiSXFZMjMvZTJLVzRvWXpt?=
 =?utf-8?B?UkNscTZUaitKQUlDNGJEaEIrdG1jRk14UENMY29Pa3NXNHBRR0puSDhKTlRl?=
 =?utf-8?B?aGJic2VDTEJHVVhRemFpRGdEQmYrM05jVHFxQkNvd2cxdEg4TnlBK0RiUVRW?=
 =?utf-8?B?dEF0bWZHblRVUXlPTHhmL3M4eU1mMXFDcGN5Njk3amFYUHBDaVVSTDhhT1FT?=
 =?utf-8?B?VXdsUGZKcm9wQ1BtUW96czBFWFBJOEltV2NMSXppOVF6YWZTVHVWMTFhRHpN?=
 =?utf-8?B?Tjl3b3V2NXdodzgwNnpNZzYzUGxkNTVncnFlOEJIL0k2bXVyVmVRUlJlVmhS?=
 =?utf-8?B?enBPK3VCeExyNS9FOEg4T2NYd2t3c3BtWVpMYm9ZUFJQRERRajFpVVJxQ2Zp?=
 =?utf-8?B?dk5YczY4dHRPWExFNlBoR3pjcTlib2Q0bkFyc0xKb203U2JUMmZDYUxmWmw3?=
 =?utf-8?B?WGlOeVh1aFZqZU5ZZFVvNkVVNGZOTnJDZUE4T0twTk43Z3V1a1MrVFF6eDkw?=
 =?utf-8?B?U0RWWVNra0g4bVRtUHpQMGdUMDhUV3BGalpWYTVkeHp6OVd0eTJJdWd0RVpY?=
 =?utf-8?B?UTF3SkxCT3VqNGxrUnl0alUxYjl4QkJCVWhnQnV5ZFpyWlNLRXE1TzA0d0hz?=
 =?utf-8?B?clNJRi9XclZFNmIvT0FFeE9VKyswTGZxTkJiZzN4WWZQQnNyN1hNSXNld2Mr?=
 =?utf-8?B?d1J6eVo5NVNpeGVySE00aDNDblNwUnRDL1ZMNjd0cmxVL3Zrd0hPOTJaV05J?=
 =?utf-8?B?QUhHZEVaNVRFVWR1SGhybTM2U1ZxdzBQNm8yS29CUTA0M0haTE1IWmhTSk4r?=
 =?utf-8?B?clE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e0668b90-6b4a-478a-0ef6-08dcf866573c
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2024 22:09:21.5519
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2ZNcPcS6io4CL0rWoshIyfhyQbkfKC/4lOY3a6/jY9JkZHhvGBbJ1ASSDIM7/5ZHhrk6fe0lgpkUd8ke6b/W9JkNgqI+jrtWOQpbjzhgNeM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6653
X-OriginatorOrg: intel.com



On 10/29/2024 7:50 AM, Daniel Machon wrote:
> Hi Jacob,

>> +/**
>> + * ice_pack_rxq_ctx - Pack Rx queue context into a HW buffer
>> + * @ctx: the Rx queue context to pack
>> + * @buf: the HW buffer to pack into
>> + *
>> + * Pack the Rx queue context from the CPU-friendly unpacked buffer into its
>> + * bit-packed HW layout.
>> + */
>> +static void ice_pack_rxq_ctx(const struct ice_rlan_ctx *ctx,
>> +                            ice_rxq_ctx_buf_t *buf)
>> +{
>> +       CHECK_PACKED_FIELDS_20(ice_rlan_ctx_fields, ICE_RXQ_CTX_SZ);
>> +       BUILD_BUG_ON(sizeof(*buf) != ICE_RXQ_CTX_SZ);
>> +
>> +       pack_fields(buf, sizeof(*buf), ctx, ice_rlan_ctx_fields,
>> +                   QUIRK_LITTLE_ENDIAN | QUIRK_LSW32_IS_FIRST);
>> +}
>> +
> 
> FWIW, I noticed that smatch bails out checking all the CHECK_PACKED_FIELDS_*
> variants >= 20, with the warning:
> 
> ice_common.c:1486 ice_pack_txq_ctx() parse error: OOM: 3000148Kb sm_state_count = 413556
> ice_common.c:1486 ice_pack_txq_ctx() warn: Function too hairy.  No more merges.
> ice_common.c:1486 ice_pack_txq_ctx() parse error: Function too hairy.  Giving up. 43 second
> 

We might need to wrap these checks to become no-ops when running under
such a checker. It looks like the parser doesn't like the size of the
macros?

> Maybe this can just be ignored .. not sure :-)
> 

I would prefer if we found a way to at least silence it, rather than
straight up ignore it.

I am not that familiar with smatch. Let me see if there's an obvious way
we can handle this.

>> +/**
>> + * ice_pack_txq_ctx - Pack Tx queue context into a HW buffer
>> + * @ctx: the Tx queue context to pack
>> + * @buf: the HW buffer to pack into
>> + *
>> + * Pack the Tx queue context from the CPU-friendly unpacked buffer into its
>> + * bit-packed HW layout.
>> + */
>> +void ice_pack_txq_ctx(const struct ice_tlan_ctx *ctx, ice_txq_ctx_buf_t *buf)
>> +{
>> +       CHECK_PACKED_FIELDS_27(ice_tlan_ctx_fields, ICE_TXQ_CTX_SZ);
>> +       BUILD_BUG_ON(sizeof(*buf) != ICE_TXQ_CTX_SZ);
>> +
>> +       pack_fields(buf, sizeof(*buf), ctx, ice_tlan_ctx_fields,
>> +                   QUIRK_LITTLE_ENDIAN | QUIRK_LSW32_IS_FIRST);
>> +}
>> +
> 
> Same here with the 27 variant.
>

Yea, same problem of course. The generated checks are too large to be
parsed by smatch.


<snip removed code>
> 
> Some nice cleanup!
> 

Yea. I got motivated with this because I was looking at introducing the
inverse 'unpacking' variants for supporting VF live migration, and
realized how ugly the existing code was and how much worse adding yet
more code to unpack would be.

> 
> /Daniel

Thanks for the careful review!

