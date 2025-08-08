Return-Path: <netdev+bounces-212168-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C9DBB1E8AA
	for <lists+netdev@lfdr.de>; Fri,  8 Aug 2025 14:54:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72B20A01A6B
	for <lists+netdev@lfdr.de>; Fri,  8 Aug 2025 12:54:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5230727A460;
	Fri,  8 Aug 2025 12:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="n/yl3neE"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6737227A448
	for <netdev@vger.kernel.org>; Fri,  8 Aug 2025 12:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754657646; cv=fail; b=bgneFszLEaMK/bE/pK6i/597PPWfdubu9rDUIFaVYgZl7FHYUDKBYz8Wav0BzLPm/47M9SnoB0JstuIPl7Z/ObMzUXO/J2VF4kdtEOAHqz2EEdENTV2el4n7KDuOPuJ1Hkf9o3b15RKaaQxKncrxeDSKz4RNzsrF1dQsQas0ab0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754657646; c=relaxed/simple;
	bh=Bf7hWTOlxFGR1ngqxh9sgb6liP2nTzcr+r6rQxqC4Vo=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ajNMQ86RFkcSTYqpa7c0YhQNoVmH4KqJbMAUHiRrPUZFeXwVac/yzc4X5m53oYGvWcfG926emAHAUp5VVhkzdFoYnEST3is17uWRlwZfO5pFiGq+J8/SJaq1Y1EFK7jZBvEeDx4bEFgLOXH8MsT34kIHvdVFCcXFFtbw4Sw5h/Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=n/yl3neE; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754657644; x=1786193644;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=Bf7hWTOlxFGR1ngqxh9sgb6liP2nTzcr+r6rQxqC4Vo=;
  b=n/yl3neEZPGRqBz+5ijQ72vLBLusYPrXDSVaN4/bX6xhkWnZuR+lMmgm
   3ztwsj1hp2FT/gytyN0u7DOCBQPhRQgXK2B9IJqdiC8CJcfqKVsHyqy8k
   yPGYYblzM0uVLefnLOFWxnBmQNCD2s1Vq331ZfBRfexl60O3b7b8wW2HN
   gAIB9opXiee3iB9CO6zJcr/gwn7XaDIQ/KrkwYwaqeNVJ8cDZqde5qKS8
   OIhM4ktXUUP4WENb4lA7Ys6LXznQ4JN/HWIU9haGQU4CmvyuQRJ9q0zU+
   DCAMTdS6pPcOzrFXZpLG9SJwMQ5FqljAA+rwFtmQCHfds++6UljXFz2S8
   A==;
X-CSE-ConnectionGUID: B2/Xod4gRa2xGnT562RKvA==
X-CSE-MsgGUID: tHx3XYIARU62XkjvIhZvIA==
X-IronPort-AV: E=McAfee;i="6800,10657,11515"; a="57085241"
X-IronPort-AV: E=Sophos;i="6.17,274,1747724400"; 
   d="scan'208";a="57085241"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2025 05:54:03 -0700
X-CSE-ConnectionGUID: LEYXx0iES26OE31Y4zFdiA==
X-CSE-MsgGUID: 7ZRR4Q6sTrKEgQKppKBzAA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,274,1747724400"; 
   d="scan'208";a="164979038"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2025 05:54:04 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Fri, 8 Aug 2025 05:54:03 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Fri, 8 Aug 2025 05:54:03 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (40.107.94.57) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Fri, 8 Aug 2025 05:54:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kzxg26dvXiZfuVVBVUCmX1OEmCRG7tsQBfoipuC1M5ue9KyO3ryvq+RErmfKsvNPv0D2B5nHigWi0bAmRCngTCVoUbw+dUIV3QIddifjnsCI25KYQ7HNpNwAcL+dIqJFVyUzMslQBeU/6T1VOms8nd0eyC/D/nD9y8U5vRUXITbgY4a30wQMM4QaQ8AReIbFKeM5WT0QFzfAGUYqLYBJu4Y1DhIOsAOTEzK1cnYaieiUBGQRtwc8TjA/vRCcW39kCHoVjmcye8LJ/7WIw2MznBKEsQxUaG8i7DwcBOYSpylaIsas+yb7zYEY2mKIxRyNdOxyUiNcFxiD8jLsepOgBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E0A3jco6H1SjSROQlf7H9khfrvrKfKzOV+IU3yWljXw=;
 b=PfH2UknQ+QoElNU5rpRLbMgrMx2XJPehxOulMA6ybhYzuzyKCSYkYvWqBUm2fotiJDI4TPZPdvrL0AT+2i76smJikeFZA0842jAaKQXuJEquNnKqtmJ/6E8l8rvtlu+RQh0D+IueKfcuSPRFmFHBxYo0eAsJn92CXoUmA19HHDRcldG3eACJVlzBGo6Xylx2e6qaB3qm0UbAk8mkJ2zcjWoqmE1mvAYIZ2QVVtGYqgLTx402VkAV4Td19yMWH1IdWZRVWcdhsIdzQ1kHSrd4ZuiZ6Evz7MYrdOWEpwzbUVFoDLzP7znOq2OeW8Xu+rDhlm9cxNHCcLQKLWaYV9ycpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8665.namprd11.prod.outlook.com (2603:10b6:8:1b8::6) by
 PH0PR11MB7493.namprd11.prod.outlook.com (2603:10b6:510:284::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.14; Fri, 8 Aug
 2025 12:54:01 +0000
Received: from DS0PR11MB8665.namprd11.prod.outlook.com
 ([fe80::8e7e:4f8:f7e4:3955]) by DS0PR11MB8665.namprd11.prod.outlook.com
 ([fe80::8e7e:4f8:f7e4:3955%3]) with mapi id 15.20.9009.017; Fri, 8 Aug 2025
 12:54:00 +0000
Date: Fri, 8 Aug 2025 14:53:46 +0200
From: Michal Kubiak <michal.kubiak@intel.com>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
CC: Jacob Keller <jacob.e.keller@intel.com>,
	<intel-wired-lan@lists.osuosl.org>, <maciej.fijalkowski@intel.com>,
	<larysa.zaremba@intel.com>, <netdev@vger.kernel.org>,
	<przemyslaw.kitszel@intel.com>, <anthony.l.nguyen@intel.com>
Subject: Re: [Intel-wired-lan] [PATCH iwl-next 0/3] ice: convert Rx path to
 Page Pool
Message-ID: <aJXzWqYi7H1h-jEE@localhost.localdomain>
References: <20250704161859.871152-1-michal.kubiak@intel.com>
 <7bbc6b88-760a-4158-bb65-8058393a731d@intel.com>
 <5a48f9b2-9a7f-4887-919c-cd99d8468c44@intel.com>
 <90721496-8458-4c57-9d1c-2f2bb4f4325f@intel.com>
 <4bac1eca-007c-4df2-9b35-d9ce5b787410@intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4bac1eca-007c-4df2-9b35-d9ce5b787410@intel.com>
X-ClientProxiedBy: DB8PR04CA0004.eurprd04.prod.outlook.com
 (2603:10a6:10:110::14) To DS0PR11MB8665.namprd11.prod.outlook.com
 (2603:10b6:8:1b8::6)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8665:EE_|PH0PR11MB7493:EE_
X-MS-Office365-Filtering-Correlation-Id: fcc7b6f7-e1c6-4d2a-d522-08ddd67aa55a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SFFGM1VIVHJ4RFFGN0h3NEhkbWgyS1BueHZQSjBUR0ZCcUpyaGU4MW83N3Rn?=
 =?utf-8?B?VVdDZUpMNzM0clNaRUpEdTVSUU9uTXJuU1ZQM1FUTVdOSlBHcExNVlBOdEVa?=
 =?utf-8?B?R0l2S2VaUXo1NUdTWFh4cUN2N2hmRjNuZ0lyMkFIMWF5UzZ1OXRIaWlvQ3VW?=
 =?utf-8?B?Z1gyZkhFc3U5UXlqMVJuVDJEdnI4QnduY0RXS1RFRjlzYzNKUE13Q2FCRzl1?=
 =?utf-8?B?L295azVQUEVWby9SbHcvM1dEQkRDb1hFZzlEMklQbWdUKzk2ckk3WXlmR203?=
 =?utf-8?B?QTRZTjdzUVRBUUZKWU45VHlaNmNOL3dwdER0OTFmbUorUmtGY3NrRXJHMlRx?=
 =?utf-8?B?U0hrRlBaTWZXeHJzRVNGMXdrVVpxYTZtTGdsZ1h3cU11eUM2UW12bzVHWTI3?=
 =?utf-8?B?bFNrWU5HcGpKUm9UREQ0ZFE1ckZ6Q1BuT3VwV3E1M3hkalVieFFYU3pCSVVK?=
 =?utf-8?B?V2wvUmUzUzFjRjRmcnYvcnMzZngwYW5LTEl5emFlZk5xcWxickNtcWRWSzk2?=
 =?utf-8?B?UThGU3NQY1pDZ3pGU0dHUUZXK3ZVNG9JUWVxOUlXalNpSlhPZ2xRWmFFK09t?=
 =?utf-8?B?a0sxS2hXVmloeW9YTmRSMlQzMXBBV3V3ZHJTQzNpaDVaTTV0YXVaUTBnd1lB?=
 =?utf-8?B?UmQ5Y1VkMDVzTG5VUkFEZUdBWXdvYldQbXlxblFLeCtsMnJKdFJzNFhSNFlE?=
 =?utf-8?B?RU1Db1d2SGk3OXkzR2tlSXJZYzl5VEo1K2RzM1RQOWt2bEdPblVIRTNFOWNj?=
 =?utf-8?B?ZU04c0krUkdXaU1DRW1yMnVnUW93ZG9aMEYraTY0U0NWOEJRbC8vZThrKzVW?=
 =?utf-8?B?Z1ZDZFA3Mk4zc2R1QS9iQUVDR3BWTXUxaFhlRHFsTVFNZ0tuWklDajNnUU1t?=
 =?utf-8?B?V0VDTCthR1pWdEpZQjJTakJvdjhOWUNaaHc3eEh6ckxpRko3NFhQdFZQdEoz?=
 =?utf-8?B?NGgxbFE2VnhKTzJ1TjFXYjBSR1FCSC83ZFJPeGYyNU9pUEJBOTJCMDFqbGh5?=
 =?utf-8?B?VW9ZVDBiKzd0VzE2RzgxSXcyY3NmWDR2RkhuQWVvMWlzV3ZzSTY2WE4rRko4?=
 =?utf-8?B?elN5N3FLajZZMGhGZWM3YkFVYkRObnRsWVZoWlAvK2J4WG5lQ0ZvNWRLMi9U?=
 =?utf-8?B?VUVNNVY0OVJOalRncWpCczFxK29jTEEzb3c1eVVkT1pLMHN4c1R5MUU3Nzhi?=
 =?utf-8?B?b2UvMFByY1U4RzlhUVU2S2FpOXR3U3ZkMStsU0t6NUgxdWlrVlk5ajBGa2d1?=
 =?utf-8?B?VzhQREZFZDkzRWlBSzhzOVh0ZHFkM1Y1MU9abU42VHBzRk0rc2xndU1YRGFl?=
 =?utf-8?B?NFc2UHJRNE1GYVhZQ21pN3JaSmprVnk1WXBScWtNYVFaZTlrYmdBQk1OK1JL?=
 =?utf-8?B?Y3FUQ0Nna2p6WGJtWDZxblJtNlNLT3I2UzJ5elo1STRaWTMvZW55eDlOY3Jp?=
 =?utf-8?B?ZHY3bEZrSU1NQ0dCU3BJVC9QMzVKNnpDZnlQczI3V1hKNkhYUC9YRGsyaWx4?=
 =?utf-8?B?NTcvL3Z5cXhlMmMzRG5uQ3R5Qmk3a0hGcUhLMHpla3JCbE5vY3Ntdk9KSW9R?=
 =?utf-8?B?WHRXOUlaWEpSbmtrNVdCaGRIMlBoUXM3TWs4L0ZqWUtUd2lNVFM4Mk9MTWZB?=
 =?utf-8?B?L2M0Z3VYcEh5SFJVak9YazJDSEtJUm83U2ZUKzhLeStwd0tOcTY5ZnJpUUhn?=
 =?utf-8?B?OHFkN1lyQ1EvTmtiL0dzMm5wbDQ2T0ZkamU5NXg2RkVENGJyaGZ3ODV3U05q?=
 =?utf-8?B?M29ZYlo1Q2RCMTVMa202NjkySkpsT01TaHVGb1JmTzBoV2RKMUcrMEhyelhC?=
 =?utf-8?B?Y2RGd0s4c1NRTEVtaFFzNlNUQnVwWjJ4NVA1T1Z1eEpMWEZXOGFvUjZoM016?=
 =?utf-8?B?VFBnb1NzUGlwQ1IzSlg3RVFJUjVubHJEbldNdzNBYVpDbW9mWVpiZTV4anhv?=
 =?utf-8?Q?FXGjEzgGULw=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8665.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZUdpR3RvRDlEd0ZEU0ZYN2ZJS29nVm9jVkRYWjdRQm1NZm4zWWhiMUp1Uzlo?=
 =?utf-8?B?VlBjaG1EcWZQRUJ3MHcwVXc3OUVYZWo5M1hReml1ZFZhN1VhQzFKb3Q0Q1VB?=
 =?utf-8?B?Rm9MTjI2QkN4bnh6NDI2cC9xQVpoem16RExaZkR1dUcyY0ZqdHN2M3VzTlJH?=
 =?utf-8?B?aVdZSmViKzRvbWc1aVdFek9UV28xTTViQzM3NXRnNzQ3Mkd4N0cxZ1ZCK0Z2?=
 =?utf-8?B?a3NENWsxeVIwKzBtQTVCNCtocUF3Vkg3OTJ0WXp6aEQ5SlIyVSt4U2R2cFgy?=
 =?utf-8?B?ZERROXJrK1B6ejlNWE5IV0d1bkp3Zmx4Mll5M1VDbTFXeDd2RWRmSFJIY0pV?=
 =?utf-8?B?emhrOXBUVksvWXFwc2FyTGFZa09LdWNPMlJYMEhsenUxelp0QmNmUHdMSzYy?=
 =?utf-8?B?eklDcDY1U2Ywa3hxR0JxNGtNTnlndXFpNFJnWU11NnF2a3NKT1I0aWJxTEdq?=
 =?utf-8?B?S1puSVdpSDdySjVjdW1iMGV4UWJ4T3BQOUxSMC9WSlYvMFBGL3NQU3JuWFBk?=
 =?utf-8?B?YURHVFRNdTF1N2Q5T0RjL0dFaFJ6OTFld0FWcnE2RXV2ajI4TVE3SHVGMStl?=
 =?utf-8?B?QnJ5ZWkyNEdkeno1RFoxS2JBNkpVMkMyTTdYOVJhdkc0OElIWVoyQVkrUFVo?=
 =?utf-8?B?VTg5OVNRZ0pBSmR0a2dIblZoSU95UUplTG9tQ1VoaDdoaFlrTWV0R2FpbHFr?=
 =?utf-8?B?T3ZIVzdUZU8zbkxKclFKaEFQdnpGSlg0RnVZcTFCcHdxbllJQ29zNTYxcGxp?=
 =?utf-8?B?WWZtUTQ2UUJDcTUwRWp1RnVEU3BsWUhEbDg1d3p3VnFMVWtWd3VMdU9pSlhN?=
 =?utf-8?B?OENJendxZjIvOWNKdG8zbUdndTJCRUFjSGhZRnlaWUJZTk1BWWtOS2V5U2RH?=
 =?utf-8?B?R2R1N041cmNTMHNod2tkNVlPa3NCRXZ0Sk1EdjNZbi9wN0xuWVA3T0psWDA0?=
 =?utf-8?B?ZCtaWVd6bzRQV3h4SjdodUo1Vy92cVg1dDVadnBDdVFnYzl6NGNmRityWlMx?=
 =?utf-8?B?R2I3TCszc3lJM2dhVEZqRVk3OU9KVEF2RHR4VXY2WmJjYkhCZWJESTBBMDd0?=
 =?utf-8?B?NERoQ0hCamc5NmZvQ1hiVmNQT1pNdTlWQTZFQzhSdzdJUU4vQnJBWnFab0VC?=
 =?utf-8?B?ancxUk4yYnNYaXR4YW9ldVArbHlNOWhvTnNMQjNxYTFrcXU2ZThqY0dkZE5v?=
 =?utf-8?B?TitRQ3dXVVg5RUN2T0tKVzRJTmhWWjlwOTQ5a0FEeExMOWFtQmIvZ29qSlJE?=
 =?utf-8?B?VHljMFdyNGlpWU9qT3p6ci8zYmRna3pMRU1rZjhVdGRWSFJqc0g2bHZERHBQ?=
 =?utf-8?B?SzZ0WnVWNDEyR05PZ01PVzZ1aHg1Mm9ISGtiV3kzNFpIT2MyendQT0pLdU9n?=
 =?utf-8?B?bUdBNzd4NC93SHdjdnRMVmh2U2hraTl4elRjeE9NazB6VUE3NXZmbXplaVc5?=
 =?utf-8?B?aHd0TTV2OWNUNUsxSC9laXVRaFF4TnBST3B1TzdGZGlxVUtrYlZBQ2hGM2pW?=
 =?utf-8?B?Z1pScHBiWFd0czhUaThKVld4RWJPbkl6VUFiR2RkVi8rQkVYVU8yTWg4Mk92?=
 =?utf-8?B?Qlh5dGtvcUFnVTMvS08zZjN5bXZxcTFBSUZNTUk5Y3FoRWQ0R0xOMThOVDdK?=
 =?utf-8?B?OStzenllL1VlTVVUazdWSzJVYURUb1dOMTFxUncyL2UxSkVFaUVSVFRGNzRy?=
 =?utf-8?B?dTdDOVVGZHlERHlDdkRoRjZtZDljZ2hCSVlIamNTSWZqelZQSTMva0dOb0lF?=
 =?utf-8?B?UWM5dzdjMlhrU3pEVFd1THdMVXZ2amNjQ28xb3F5ckkvenZHT21NbXFDeW00?=
 =?utf-8?B?RVpFZllOQWEzS0VSbUJEbkpiYk40MHM3Q1ZQVTVUVWJXTWYrSmFmeDlCcW1K?=
 =?utf-8?B?SUw3ckk3b1VRNGlQNWpzRlN4czI5ZS9NNlRVV3RNaVF5TEkzNE81RXJJRUdI?=
 =?utf-8?B?MEVGU0tTempnZnZseGw3djA1RzVXa2ZLZzZKVktLSXpid3JwMUZ6dTJsVXJq?=
 =?utf-8?B?eEk1NXVtUmozYXQxZmx6eTlpL2JmNWtOSGZIVGNaK29pcWJFdmxZRVZzcFhD?=
 =?utf-8?B?YW9EYlRRTjBZc1pIczV6MThtTkNmMWh6VEVESktEV2dTNkxVWmZCbmhCOUx0?=
 =?utf-8?B?QStzWW83QjNxelJ4QWo0UTJ0Vy9WR1c0MWNISTgwbStZRHpuSktGR0FtbnhS?=
 =?utf-8?B?Q0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: fcc7b6f7-e1c6-4d2a-d522-08ddd67aa55a
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8665.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2025 12:54:00.8084
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y5+19/CjWA3bUygFqERWgX0lkbvWQ6lSykekxJd1gyHHZIfrNAdr/dvojJn6w3H42PcwoB4qFd7Mw8dJ9Cchrw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7493
X-OriginatorOrg: intel.com

On Mon, Jul 14, 2025 at 04:35:26PM +0200, Alexander Lobakin wrote:
> From: Jacob Keller <jacob.e.keller@intel.com>
> Date: Thu, 10 Jul 2025 15:43:20 -0700
> 
> > 
> > 
> > On 7/7/2025 4:36 PM, Jacob Keller wrote:
> 
> [...]
> 
> > I got this to work with the following diff:
> > 
> > diff --git i/drivers/net/ethernet/intel/ice/ice_txrx.h
> > w/drivers/net/ethernet/intel/ice/ice_txrx.h
> > index 42e74925b9df..6b72608a20ab 100644
> > --- i/drivers/net/ethernet/intel/ice/ice_txrx.h
> > +++ w/drivers/net/ethernet/intel/ice/ice_txrx.h
> > @@ -342,7 +342,6 @@ struct ice_rx_ring {
> >         struct ice_tx_ring *xdp_ring;
> >         struct ice_rx_ring *next;       /* pointer to next ring in
> > q_vector */
> >         struct xsk_buff_pool *xsk_pool;
> > -       u32 nr_frags;
> >         u16 rx_buf_len;
> >         dma_addr_t dma;                 /* physical address of ring */
> >         u8 dcb_tc;                      /* Traffic class of ring */
> > diff --git i/drivers/net/ethernet/intel/ice/ice_txrx.c
> > w/drivers/net/ethernet/intel/ice/ice_txrx.c
> > index 062291dac99c..403b5c54fd2a 100644
> > --- i/drivers/net/ethernet/intel/ice/ice_txrx.c
> > +++ w/drivers/net/ethernet/intel/ice/ice_txrx.c
> > @@ -831,8 +831,7 @@ static int ice_clean_rx_irq(struct ice_rx_ring
> > *rx_ring, int budget)
> > 
> >                 /* retrieve a buffer from the ring */
> >                 rx_buf = &rx_ring->rx_fqes[ntc];
> > -               if (!libeth_xdp_process_buff(xdp, rx_buf, size))
> > -                       break;
> > +               libeth_xdp_process_buff(xdp, rx_buf, size);
> > 
> >                 if (++ntc == cnt)
> >                         ntc = 0;
> > @@ -852,25 +851,18 @@ static int ice_clean_rx_irq(struct ice_rx_ring
> > *rx_ring, int budget)
> > 
> >                 xdp->data = NULL;
> >                 rx_ring->first_desc = ntc;
> > -               rx_ring->nr_frags = 0;
> >                 continue;
> >  construct_skb:
> >                 skb = xdp_build_skb_from_buff(&xdp->base);
> > +               xdp->data = NULL;
> > +               rx_ring->first_desc = ntc;
> > 
> >                 /* exit if we failed to retrieve a buffer */
> >                 if (!skb) {
> > -                       rx_ring->ring_stats->rx_stats.alloc_page_failed++;
> > -                       xdp_verdict = ICE_XDP_CONSUMED;
> > -                       xdp->data = NULL;
> > -                       rx_ring->first_desc = ntc;
> > -                       rx_ring->nr_frags = 0;
> > +                       rx_ring->ring_stats->rx_stats.alloc_buf_failed++;
> >                         break;
> >                 }
> > 
> > -               xdp->data = NULL;
> > -               rx_ring->first_desc = ntc;
> > -               rx_ring->nr_frags = 0;
> > -
> >                 stat_err_bits = BIT(ICE_RX_FLEX_DESC_STATUS0_RXE_S);
> >                 if (unlikely(ice_test_staterr(rx_desc->wb.status_error0,
> >                                               stat_err_bits))) {
> 
> More or less. I'm taking over this series since Michał's on a vacation,
> I'll double check everything (against iavf and idpf as well).
> 
> Anyway, thanks for the fix.
> 
> > 
> > 
> > --->8---
> > 
> > The essential change is to not break if libeth_xdp_process_buff returns
> > false, since we still need to move the ring forward in this case, and
> > the usual reason it returns false is the zero-length descriptor we
> > sometimes get when using larger MTUs.
> > 
> > I also dropped some of the updates and re-ordered how we assign
> > xdp->data, and fixed the bug with the ring stats using alloc_page_failed
> > instead of alloc_buf_failed like we should have. I think this could be
> > further improved or cleaned up, but might be better to wait until the
> > full usage of the XDP helpers.
> > 
> > Regardless, we need something like this to fix the issues with larger MTU.
> 
> Thanks,
> Olek


Dear Jake and Olek,

Thanks for your support, detailed testing and fixes!

I successfully reproduced the crash during stress testing the series
using:
 - MTU == 9k,
 - iperf3 (for UDP traffic),
 - heavy HTTP workload running 20 threads and 100000 connections.

After applying the fixes for v2, I observed no issues.

Thanks,
Michal


