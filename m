Return-Path: <netdev+bounces-214476-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 35C02B29CDB
	for <lists+netdev@lfdr.de>; Mon, 18 Aug 2025 10:56:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F10D83ABC33
	for <lists+netdev@lfdr.de>; Mon, 18 Aug 2025 08:56:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58929275AE2;
	Mon, 18 Aug 2025 08:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="c00kMY03"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 021371DF75C
	for <netdev@vger.kernel.org>; Mon, 18 Aug 2025 08:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755507370; cv=fail; b=jgAdsNYNCamhLvjjb5STtgPULu5IdjIv10pMSy6z5LLxkVXCmLNMgLWzJFZB6YCc1JdGM6rLl9x0U7mP1NqWui+PieZoGVT9aV60L7ZBZnMYys2P/E+1JDtmUnCUt8VhdOFLIsWYSqsaamJAn8tIliowAqDf1rCD7F1tYdKn9Rs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755507370; c=relaxed/simple;
	bh=gshKKWxSVRuM2/723vwoZqGO9pPVDAi/YX64Yvm7hQw=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=XFW6J3Jt9JMQeQBtOAYoZsFrSpUpNurGyn3yx9JIXM1ZRKhrRV2YK0g8uVZlnhEwWz9TnNY7d+XnsjvCrlA/OWbSRxcdS/9pbyPcd80QvX3MiKjvGrTEecGmYApkmg18O92rGtr+M9Xn83kJTWOB1T7f3vtyJnk/aree2KgQxW4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=c00kMY03; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755507368; x=1787043368;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=gshKKWxSVRuM2/723vwoZqGO9pPVDAi/YX64Yvm7hQw=;
  b=c00kMY03YUjk6+cFd2bZpONwvNR0O57IX9vOemcZJiJSXqNsTEH1yhjx
   tIwhgtpwax3z4HfZAgSCPVXx2ySTriOHvbsbNkdN1jLDi1J8UWnnYpV1M
   5YgAZz9tYTgdFh8klb8LjoRtokd1oTnngLMZWE3K0tnjkLE/bZpSSR7vG
   E09gl2iGYBiYI5RXlFsAyLhKoswcHFqsAb4ikZZV/2WxTS9zx5WNnwrmu
   FhkCy09UYHE7G7/4ad0uGINKZ1ywblIkbzfMF+azU8mDoLrPcUws6cin+
   3cL1FVol5ZRceGK9JJuiZs15X4aIzmS1lwfJ1RwAjjghZ309RhKRRQqNZ
   g==;
X-CSE-ConnectionGUID: NJiDR21PSPictGNxDt4Pmw==
X-CSE-MsgGUID: M3yB7DIxQSW49km9J8pgnA==
X-IronPort-AV: E=McAfee;i="6800,10657,11524"; a="57582919"
X-IronPort-AV: E=Sophos;i="6.17,293,1747724400"; 
   d="scan'208";a="57582919"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2025 01:56:07 -0700
X-CSE-ConnectionGUID: AhE+l6cRS6eHaOfqfdEUGA==
X-CSE-MsgGUID: svHZwpgiTNe3bqr6GYA69w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,293,1747724400"; 
   d="scan'208";a="167875859"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2025 01:56:07 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 18 Aug 2025 01:56:06 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Mon, 18 Aug 2025 01:56:06 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (40.107.243.64)
 by edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 18 Aug 2025 01:56:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=grClYr1BI/fVrW7GkPtJQWMtJRpM3yx85Le5soR+BYV5vxpgtb7Mkk1dQ6ny4wL0W6Edp+I6Y3iEXu3aegW+uEdZY1EMk4jer+bCd7QJYab5z8DjZccTIjiPeYNZJmmByg8evAY4OmxnMeBAvqtKePYTOgAvCMvw7mC4gD+Apqrdf6DybR4FT7iML/EIk61sRDLclYi96S1YlmFhk7QgXrbLOq7YX+nV52iPj4WrnJFGS29PDaKQeHYv9+xDW8kBNecl3vQPQuXACzM2oFiLEavUDHQFRgeQl0QmlwiqQpMLvad1CvqfJtnSOpcH/5S7wPhBxv3EYsxxCtT9yYlFbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+mWPZVU3dbKhnhpLcRyggfZJgk4se/l/g+FSB4pipr0=;
 b=LUPRcsVHJ5gBmunYY0llW7CySufD746vWmxuxIQK8Pb9bn5Kg6as9T2/UFpUiKe6klQVB1DW0gW/4uksRjzwectNP5C0ZQNJCaVHUBbCfCG1vDIgQYGKZafMyPVwJw294auPmO/BRoAqWEmyuJL9/0q6KL1QA0rJv1FD8712VIs4XK1W69nfsk0u5Rv9FILHjSx7OKv6dR4p+0xg9DVsxPU0RD12jEAcBtWNlhNvQZ2HSwR3ZihAsG28iPb//05/gb6/Re64cNjwmp3uMLunc9TKAI59riAwLpPXxJEjWjNzPgtdBJEtobOlHVD6Y/uzk40C1e28nI1FB9pWyXbt6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
 by DS0PR11MB8020.namprd11.prod.outlook.com (2603:10b6:8:114::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Mon, 18 Aug
 2025 08:56:04 +0000
Received: from MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6]) by MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6%6]) with mapi id 15.20.9031.021; Mon, 18 Aug 2025
 08:56:03 +0000
Message-ID: <2b711a6e-23ff-4859-b572-fdcab8c4a824@intel.com>
Date: Mon, 18 Aug 2025 10:55:58 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/5] bnxt_en: Refactor bnxt_get_regs()
To: Michael Chan <michael.chan@broadcom.com>, Shruti Parab
	<shruti.parab@broadcom.com>
CC: <netdev@vger.kernel.org>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <pavan.chebbi@broadcom.com>,
	<andrew.gospodarek@broadcom.com>, <davem@davemloft.net>
References: <20250818004940.5663-1-michael.chan@broadcom.com>
 <20250818004940.5663-3-michael.chan@broadcom.com>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Language: en-US
In-Reply-To: <20250818004940.5663-3-michael.chan@broadcom.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DB3PR06CA0022.eurprd06.prod.outlook.com (2603:10a6:8:1::35)
 To MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8102:EE_|DS0PR11MB8020:EE_
X-MS-Office365-Filtering-Correlation-Id: 682a2175-a906-419a-564f-08ddde350fb2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bGdOS29paktCcEVBUFNLbjVWalMra05VdktGUERvbGl5YjVhT0kzamw5OXVz?=
 =?utf-8?B?Ynk5UVVpRTRZY0lYUGNXODZXNk1KbUNORDNjM3VLSldybjRueGNaV3FTUzBW?=
 =?utf-8?B?NnE4anQyemNxZEZVYkRnY1UvZ0pxOStqbk1mRDV5Z0tqSlRWdWlCK0tvRlRQ?=
 =?utf-8?B?SWdXWklxZVdUZzZSRmRjdGUzbDBCOXZ0aXQ4ZmdOQ2RZLzExbERSUTFwMzNQ?=
 =?utf-8?B?VU81UjA4OW15Y2UvY1VVbDQya2dmY1JZTTN0VTF1VXVIV1E4M3pSQUUrREpQ?=
 =?utf-8?B?cnpuRGlVZ3gxR1hJOWhPWWdKOHVHNWNvWW1xRlRiUWVUemRSeVJHYmpITzV4?=
 =?utf-8?B?ejFFeWEyemtheHhCRFlYN0hlcGZ1WmdNWVJQY0xSSzdpVGUxU0dBT0pJVysr?=
 =?utf-8?B?d1pFUjlMOEE4aGlZWjN6YVVRNThrTkJocWIxS1RtOEI1S1dKeDhVOXFmREpK?=
 =?utf-8?B?NG44SjlzanllNVE3MTEwR1RjRjhEbGxLb0VSQU1IekVLS0xybTgvaDg3cW1h?=
 =?utf-8?B?NkhXZHRtTmhSajRXbUtWbzZhMDJ2RVovSDRUdFZxbkZYYkErVEg0Si8xQzFE?=
 =?utf-8?B?aGs4QjhWMlIrSS9ZMnk5dFhxZGwwUXUwN3FNN2JlQm1LTGtlcEpFTm5CQXlv?=
 =?utf-8?B?RXI1T1RGRWRxeXBWMVA0VmY2R2Q2RUw1cEVvN2JOdVdUcUVtYkdPVklHL3NT?=
 =?utf-8?B?bEFucmpOaGkyRmlQREJ4T012a01WT0RNaDVYUldncWg0NnVUMkpHL2k3MVUy?=
 =?utf-8?B?eVcweXZ3V0RZMzNIMTVuVWlqdzRMcnVjQVAwUXZ6NE9jR1g2d2c0cGtkNUhE?=
 =?utf-8?B?TUFRdEhYczBSeldWY29SdFVwcGtTRzY3QlFYQUFWck5NRG95TFIwSXRiRFFn?=
 =?utf-8?B?ajhtbHRvYVdPNEpJTlA3blVRUGxpWU0zQ2xYVlRuVEx6VCt5U2tjSVRqZXNu?=
 =?utf-8?B?bnB1R1dRUUpnNzBXUDA0TkI1L0dyajlFMDcyMm8yeE5JT01SNFR0MjExakMx?=
 =?utf-8?B?UGt4ckNjWUpvZi9pUXJWaW9mNjlmV2k1ajJWTTY5NVZXNTUzUi9QQ0hFQ2pi?=
 =?utf-8?B?WlB5WXRhVFBMNm80aXd2d1JRbnE2TW5pdjZwdldOY0tJOXF3ZmlnN0Fyc0t3?=
 =?utf-8?B?SmJUandyblkwUWhVb2QyVE54Yy96MVdFcGFWbUZyeWVtNVAxZEFwWmhOWmkv?=
 =?utf-8?B?Vk9tcVliaHdFQk53S0N0RUtUd3pTeVpnamtFTmNrYmhMTmhaSHFBRjRVS0VF?=
 =?utf-8?B?THlwMVN5TzN0ajlCNkVCZzNBelBDMVdHL1U0R081WGJ3d3JmUklWNGFSVUdW?=
 =?utf-8?B?d3ErQVRvZCtmOXFYUThNNCtOOEh5ODZFTUM0M25HbklZb1VCQUZwNVh1R1VV?=
 =?utf-8?B?NTQwazhYVHBSTTZKdStrTDJIMUVyZVdLK1ZKTEtvQkcyYVVTMjRJMWViQkJQ?=
 =?utf-8?B?bTluekk4UXJYa0t1eVlmZW5BQ0NZa3oza0NIbFFnSzBoVUhOS1gwTXF3eVZ1?=
 =?utf-8?B?WGY2c09Ib2ltaloxSmZuZmRsZUN6czREaHM2c0dseGVtSlpQb3FGWEJRa1ln?=
 =?utf-8?B?bmMyNzZIMmVYSEJTeXdNUko4NEVSVUFNeFQyZWZwZWZNMVRxUmRzZ2h0R1ZK?=
 =?utf-8?B?Y0pCMkJDSUwraHFVMXdsR0tyeFZDWTlnZUsrMXU3aENGSXNzMTA2WWxRVENj?=
 =?utf-8?B?K1BHZ3dCUVVYNE4vTHhEVGlEZUJYb1FDeUdUeWg0L0ZEVGhBbnZpU0sxL0tJ?=
 =?utf-8?B?MDZ1dFZsU1o3ckpvWEs4MG5wSDMySTBFdzBYeXlqdTdaWWJmV1JMMk1MYlBR?=
 =?utf-8?B?NTBhMUJ1Wkhxb3VwdzlYYk9nUHpoTDg4TXVqWDh2UjFua1FKV001TW04dGFD?=
 =?utf-8?B?eUVBYW9GTWtSWEFsbmw1bFhRbU5WMkQ5YkJrM3pBTUtra082VmE5REhvMlk2?=
 =?utf-8?Q?di/dtjfFrUg=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cEY5RUJtd1ZjZVIrOTdaK2pEKzJPdjZQMUFHN0JCU0NvY1pYUVUvbG5TR25Y?=
 =?utf-8?B?UEFVK0JNSWNCczB4ZHAzNXpGeXZMYUs4MnlIdTRGdXFMa0UwQTdHNXNwOFV6?=
 =?utf-8?B?NFVocFhTU1cyRk5UdUtrMmU0ckJuSE5va1dtVmFuU2dFOVJhd2I3dTBaS25w?=
 =?utf-8?B?bDErdjd1M1BBQ295Z0g0TzhBRlNDdGdyallMYS9pZU9JT3Rwakg0ZjZpN3pu?=
 =?utf-8?B?aGV2RUNocmNsV21GSDRqeHNvVVNLc2lXOXFkMDIwMzhmL1NDeENncDZUblU0?=
 =?utf-8?B?ZlpVejZNc1BFNnU5SU9ZZHFibHcybC84SE9wOFpoZVhCV0xFRStuUkZtbUZq?=
 =?utf-8?B?L1NoTHNVbXBOb2lqQ1BvTXdLaVBQbWNwQkRtK0tIVTF5Uy9VQW5kK0VVMnlk?=
 =?utf-8?B?WlVBQ1Q4czFtUzlJenlvNlIzclZqV0ZXeWVaNnhmd0J5ak1Yd1dCTWx2OWhw?=
 =?utf-8?B?NjB5emN1NTVuY095OWZrVE9MOXNXaklNS2VtQmt5SUs2aGNBcjVHeUVNQURZ?=
 =?utf-8?B?MmZzUmlEcTVkczY0c0NVdVp3ZFBzc3hoQW1uMHMxN1JpOUlJVzJaNkhpaVVx?=
 =?utf-8?B?Z0xRa1MwaWZXc1BocWdaSUMyYXl4aElXMDZQVzVOaTFnb0hZaWNSamZob0h0?=
 =?utf-8?B?emJrK1U1dTFrWTZWNFNpdGpoUmpZQWNZV2tHQkFQN2tpRmpjS2hpYisrQ20z?=
 =?utf-8?B?QTVNdEd0UE1NbS93UUVnS0FjSmF5MzhIWm02TndHWU4zY3VCUWV4VElNZ0lG?=
 =?utf-8?B?cFB2ejhvVUd0dXZMLzJBalJjSHJ3QUlLUlRRTDVtbnVNWTZycnc4d2MvbDF5?=
 =?utf-8?B?bzZZelg5NkZpMkxzY200OVlrbWl3YWNCdzZlc0pSWTNzOWRvM3FNYWQ5eWtH?=
 =?utf-8?B?emFUdURXczhGd2QyYnRpYnRjc3pIb082MDE1Y0p3SkR0ODVJVWpQVG1VRG0z?=
 =?utf-8?B?SS81VmpoNjBSR0RXdlVGNXF4dzVCajNEZVZwVEw4Z1lSaVNjWnNDcTNtT3h3?=
 =?utf-8?B?RzJpcHlYRGRpRUQvWFdOaGJ5YWFkdEtGU0c2WTBzMzUyWlAydnEyeDZoRnBL?=
 =?utf-8?B?SzFCY3JsSDhnR1YvbkhBbWs3YkhXRFVoWUpEMFhzNkdMcTk2ajZKMTdBbzRz?=
 =?utf-8?B?V3RwRk1CMHJ6T1FiVDVKRkl4N0lTRStUa0Vha2FiR2tRYmFwVXJnZ0lQdnFX?=
 =?utf-8?B?K0dBcTc5bFBtdnVGK3VwRmN1N05qMXR4UkQ2cTl5eFBVWE9zaHZZRVV6MjRT?=
 =?utf-8?B?cUtkOTVsbVVDeVFoZWR3dFhQcnJyV0dleEE4UE1wdHFIWnlaVEF3WFpNZFp3?=
 =?utf-8?B?N2E2dG1iUjRUK1Byand5bUFTZDdYV011TWNzK0oyLzFDUXZyRUtONU5mLzVi?=
 =?utf-8?B?TGFJYnhSRmZEWnQxV1p4QnhrSzlCV1hHYUhDUllJbWFUYlQwTmVUZGVXMXpB?=
 =?utf-8?B?a2dWNHk2NXQxQ2cvaWs0YTRLVVhHNkUrL2NWZjhlSWVtbTNUdlhycG5OOE9m?=
 =?utf-8?B?cDBabTZURW9STUNNY2lraWFiQ3kyVjc0YllMY0daa1FEalpzTnpScTZaTldT?=
 =?utf-8?B?YVcwMDkvYzQycVFuenhWaXpFb1NBMDd5b1MzSGJMdDE1ZjdqWjQ1UWE4cG5M?=
 =?utf-8?B?a0gxTFdXK3h0L1N4d0g4OUMxOEx3U2ZPU1dJK2IzTjFpY05yS01KeXdOdGk5?=
 =?utf-8?B?M24zeCtzaFZDSncyZ01rOUFQSy9UQmRVaVcxVUVqR3RWa0tuWlpwWUgxcmJR?=
 =?utf-8?B?bXpZSkpNZWVQaXh5K1Fsd2JLQWNQTi9acTIxTjVXK29ncnVqd0kwZGNRZkdK?=
 =?utf-8?B?S3JoZ1RqTGxDTVNlUHh1RlJsckkzMjYxWTU0VEFkc2lDeE9GbFU2b3VVY05m?=
 =?utf-8?B?RzI0SDM5UWFhR0c2Nm53NUVKSERpWEhVRGxjc3dTSThBSjJFZ2ltM2hMayto?=
 =?utf-8?B?bDVoQ3MydGt2TXovNnZra1AxWG95dEJFTnFYRWhLa2w2bzJrYlhINmhZRlF0?=
 =?utf-8?B?czNRRGRUOEMrUnB0ekZKM2I5aktKUkJEbkwycFhhUDBsdVkyUi84a0ZISHFV?=
 =?utf-8?B?OWY4NVdKOU9kK29pTlFiQTJzM0NlTDRTTnZSWWFCV3RGcHZ2NU5INkdJQkpT?=
 =?utf-8?B?c1hyNDBBL0ZRMDVKZHlCNGhiRlNJd2VwM0NKR2JtMTEyeTUzVW5zNFBqY1pz?=
 =?utf-8?Q?a2lpMuBqx5dSkPwD67rcYqs=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 682a2175-a906-419a-564f-08ddde350fb2
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2025 08:56:03.8199
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h00lSytkNETPIzjbSIZE3h6A+Q78m7juxG6p/5AxEY/k6mdcYhtgVfUqo/SA3TfXMTZblCqnPbgvQGPTKfjIBx/bs31D3oWAeYw/nu/iekY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8020
X-OriginatorOrg: intel.com

On 8/18/25 02:49, Michael Chan wrote:
> From: Shruti Parab <shruti.parab@broadcom.com>
> 
> Separate the code that sends the FW message to retrieve pcie stats into
> a new helper function.  This will be useful when adding the support for
> the larger struct pcie_ctx_hw_stats_v2.
> 
> Signed-off-by: Shruti Parab <shruti.parab@broadcom.com>
> Signed-off-by: Michael Chan <michael.chan@broadcom.com>
> ---
>   .../net/ethernet/broadcom/bnxt/bnxt_ethtool.c | 43 +++++++++++--------
>   1 file changed, 25 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
> index 68a4ee9f69b1..2eb7c09a116f 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
> @@ -2074,6 +2074,25 @@ static int bnxt_get_regs_len(struct net_device *dev)
>   	return reg_len;
>   }
>   
> +static void *
> +__bnxt_hwrm_pcie_qstats(struct bnxt *bp, struct hwrm_pcie_qstats_input *req)
> +{
> +	struct pcie_ctx_hw_stats_v2 *hw_pcie_stats;
> +	dma_addr_t hw_pcie_stats_addr;
> +	int rc;
> +
> +	hw_pcie_stats = hwrm_req_dma_slice(bp, req, sizeof(*hw_pcie_stats),
> +					   &hw_pcie_stats_addr);
> +	if (!hw_pcie_stats)

looks like hwrm_req_drop() is missing
If that was intentionall, I would expect commit message to explain the
imbalance of old and new code for "refactor".

> +		return NULL;
> +
> +	req->pcie_stat_size = cpu_to_le16(sizeof(*hw_pcie_stats));
> +	req->pcie_stat_host_addr = cpu_to_le64(hw_pcie_stats_addr);
> +	rc = hwrm_req_send(bp, req);
> +
> +	return rc ? NULL : hw_pcie_stats;
> +}
> +
>   #define BNXT_PCIE_32B_ENTRY(start, end)			\
>   	 { offsetof(struct pcie_ctx_hw_stats, start),	\
>   	   offsetof(struct pcie_ctx_hw_stats, end) }
> @@ -2088,11 +2107,9 @@ static const struct {
>   static void bnxt_get_regs(struct net_device *dev, struct ethtool_regs *regs,
>   			  void *_p)
>   {
> -	struct pcie_ctx_hw_stats *hw_pcie_stats;
>   	struct hwrm_pcie_qstats_input *req;
>   	struct bnxt *bp = netdev_priv(dev);
> -	dma_addr_t hw_pcie_stats_addr;
> -	int rc;
> +	u8 *src;
>   
>   	regs->version = 0;
>   	if (!(bp->fw_dbg_cap & DBG_QCAPS_RESP_FLAGS_REG_ACCESS_RESTRICTED))
> @@ -2104,24 +2121,14 @@ static void bnxt_get_regs(struct net_device *dev, struct ethtool_regs *regs,
>   	if (hwrm_req_init(bp, req, HWRM_PCIE_QSTATS))
>   		return;
>   
> -	hw_pcie_stats = hwrm_req_dma_slice(bp, req, sizeof(*hw_pcie_stats),
> -					   &hw_pcie_stats_addr);
> -	if (!hw_pcie_stats) {
> -		hwrm_req_drop(bp, req);
> -		return;
> -	}
> -
> -	regs->version = 1;
> -	hwrm_req_hold(bp, req); /* hold on to slice */
> -	req->pcie_stat_size = cpu_to_le16(sizeof(*hw_pcie_stats));
> -	req->pcie_stat_host_addr = cpu_to_le64(hw_pcie_stats_addr);
> -	rc = hwrm_req_send(bp, req);
> -	if (!rc) {
> +	hwrm_req_hold(bp, req);
> +	src = __bnxt_hwrm_pcie_qstats(bp, req);
> +	if (src) {
>   		u8 *dst = (u8 *)(_p + BNXT_PXP_REG_LEN);
> -		u8 *src = (u8 *)hw_pcie_stats;
>   		int i, j;
>   
> -		for (i = 0, j = 0; i < sizeof(*hw_pcie_stats); ) {
> +		regs->version = 1;
> +		for (i = 0, j = 0; i < sizeof(struct pcie_ctx_hw_stats); ) {
>   			if (i >= bnxt_pcie_32b_entries[j].start &&
>   			    i <= bnxt_pcie_32b_entries[j].end) {
>   				u32 *dst32 = (u32 *)(dst + i);


