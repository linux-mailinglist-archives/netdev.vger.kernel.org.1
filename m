Return-Path: <netdev+bounces-174756-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A58CA6035D
	for <lists+netdev@lfdr.de>; Thu, 13 Mar 2025 22:22:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F3AF16AB40
	for <lists+netdev@lfdr.de>; Thu, 13 Mar 2025 21:22:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CE391F4C91;
	Thu, 13 Mar 2025 21:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Msz8lBoU"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD798126C1E
	for <netdev@vger.kernel.org>; Thu, 13 Mar 2025 21:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741900960; cv=fail; b=SzfnnlkJk0HnYRFwXotyApPy0VrRXv+jCIczyVLNqpPjlGcxUaI6BFUYCQRFZlKtBQoweZsaaNYH/kNXLFT8byGqFI7RPZPVL/utxhUMMfadkaZwpcGI9IrnoPZmU3FPhfYAtkmdSbjcy54iX5JcX0v/JWbCAoecWsMJjPtaTWI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741900960; c=relaxed/simple;
	bh=s7AscanZRJxZ6nRCMqIlLw6V/kf2G4+ntP+iXB+JOnk=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=WGjyar+tPji//oZgiNZOPSp06Ws+eGDEQvcc8gEgtKwWNq5nUoubfjCOKWeDtfGsvArRBYWNlCOwN5ejuSbSGqyZLcUHxbGBJSI6VHDB6IxmYdGxs3f+bjXCyA91ysUZMK61S+Dv64jqI9MTy5AZhCe9gcNhAaxlZE5ddqr3itk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Msz8lBoU; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741900959; x=1773436959;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=s7AscanZRJxZ6nRCMqIlLw6V/kf2G4+ntP+iXB+JOnk=;
  b=Msz8lBoU7v2ShMavbQLFSj+RN0DTNJ9IbVUzm8TVVd1SrPjfLyUcg9F9
   ov/TdTM53K72azDVeK/In1WbM/hawdoozUZ/KIxbyhb9Pj59NwEcK/kum
   ZrXDPPQbkInSOdRKG5sOCzdDuTQjXV3edvmBeiWD0EkAKhHFgaGqcAQAT
   tBOgQbORVFd8iQgmf68ZzQXuAKNtRiE5IHwCsSKk9QROKfU3y0NAh/7iy
   EzYFxuJImwK/6VNstHjwR3kIDZkH3V0Hcg1KDVWRhZg/KMIGliCs5A0dV
   c7vjVyYm3KX2sdcvEoP2jWzJ+71/++TyuQ8Eg3OJ6Dtnptq/COu0ZAoFR
   g==;
X-CSE-ConnectionGUID: dDUABBN6RpWmpusxniBXWA==
X-CSE-MsgGUID: Hy04wOwvQtOe4YRkFxHaMA==
X-IronPort-AV: E=McAfee;i="6700,10204,11372"; a="42947982"
X-IronPort-AV: E=Sophos;i="6.14,245,1736841600"; 
   d="scan'208";a="42947982"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2025 14:22:39 -0700
X-CSE-ConnectionGUID: qaGS5YF0QiWcSfgsbMvHPA==
X-CSE-MsgGUID: auX38UyrTsWvJJKp1pPmyQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,245,1736841600"; 
   d="scan'208";a="121579865"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2025 14:22:37 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 13 Mar 2025 14:22:37 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 13 Mar 2025 14:22:37 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.174)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 13 Mar 2025 14:22:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V89n5CZvtMpm+mMQ/sGPXHlflgkrNq1HybjFG8frcEjOfGCwC5ENX+KW9F4OJYmU569aHOJC++2BUkkMcPQQbyvEHCuTWBqHxP+Krmu8drWkykzi5tT9VxSQYayIoPR4NBEsMGi/tafZwvVZDjnHWlj+VqB1IobeZRkIc5da8VtBXi5gE5r+aXhmJRzmQGqxsg2pcDpqgpAvtgNbY8gXjpm1rQ8ojR3u2/rZ0UeUi5an11DVUUZLNunO3a5crOAdWmNF6WzdHhZIAHSwoLXG6E2rKk1mugTTuQq3Y/ZlRlN0iTY6X73REGB4842b60obLXg6hRcv8flmTDH1jvEVfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+likSBgpnQUnMxH1wu/I5/NeyIq1or+s2AChdT3j288=;
 b=h9MhS4UCiG0FS0RRKW9XsKpa212OisA0KunOb2/oSTFwYRaalSSPijySKpAL7eUZOwEsPQiMqwKWQC4X+FXiyaRMRgId2KbscaSn/H2bI8+DWxQcwf/4NdHoe246WJ/DVn4oPXe+AeuNAHmxcRzP99hsxNO5MFjfgrGMhncSGJ1D7mS1gjufPmaJ3lNXUBbzQ0hWzGLtq589D+UQSgulVly67OYOGz/5ee0hVMAOmzRuJQxtKAkQNfBYHzfoVXEdzqeycWY5H+d7En8DID0EdvRrkdolmbf+XEdqpjYdBNxbba+MfNPlWjSZACCakMwTHYMlKOZNbNbYKudJNITI3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by BL3PR11MB6339.namprd11.prod.outlook.com (2603:10b6:208:3b3::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Thu, 13 Mar
 2025 21:22:33 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%4]) with mapi id 15.20.8511.026; Thu, 13 Mar 2025
 21:22:33 +0000
Message-ID: <f79bb045-1c2a-4a2e-8ed2-ff4ff4f9c814@intel.com>
Date: Thu, 13 Mar 2025 14:22:24 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] r8169: switch away from deprecated
 pcim_iomap_table
To: Heiner Kallweit <hkallweit1@gmail.com>, Realtek linux nic maintainers
	<nic_swsd@realtek.com>, Andrew Lunn <andrew+netdev@lunn.ch>, Paolo Abeni
	<pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>, David Miller
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Simon Horman
	<horms@kernel.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <a36b4cf3-c792-40fa-8164-5dc9d5f14dd0@gmail.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <a36b4cf3-c792-40fa-8164-5dc9d5f14dd0@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0345.namprd04.prod.outlook.com
 (2603:10b6:303:8a::20) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|BL3PR11MB6339:EE_
X-MS-Office365-Filtering-Correlation-Id: da1b4a6a-b2d8-4933-036e-08dd62752b13
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TXF5cU9VNjRvVnBTK055c21PRXQ3SnF0SHE1VEVzRDlCWUNrZTA3b2JMdVVv?=
 =?utf-8?B?VXNtb0EzYU1XYjl0M3NYMG5tQTBCYXhCV2NhNkVTSzNKSHF4OE03Y2h4ODBI?=
 =?utf-8?B?ZE1MUU9BcU9ZTkVMbVhxUEd3VDArdE5RbDU5R3JYYXErcDNkTUYyQ3VMZklH?=
 =?utf-8?B?ZmVheHFGZnh4RWRDemxUU0VSdTd6MG51Y1VLWGFpWGx0aURPREphK2lFeWU5?=
 =?utf-8?B?K3U1NXhOMHVjeklWbmRvSXFDRnJFUVZDbTZERFp4dVZYWjlDck5KM0loeWx0?=
 =?utf-8?B?K3NaYm9kQVVhL3NHY2NFQVZ2eERnbERvdVB5WnJ3eGhSNjk4aVpMcHhuNWhX?=
 =?utf-8?B?MFRKNmJFdTRzWVRFQXM4ZVNVOFNLaTNjM2NGSEVIdHJTWUVZeW9NVDhpbUpa?=
 =?utf-8?B?OWEreUNWZytoUlRna3FwTzhIWFBOQVppRGo4ZjdGc2d1STJGaDRkY2poZ3Ur?=
 =?utf-8?B?ZHVHdllaRm1iOXgvejVha2FUU3hNaHViZlJiNkpDeUpTUll3MmVOMXB6Q3pH?=
 =?utf-8?B?eXdPdmNua2d6WCt6dVN0VnlrVlpDcjB4Rk1tMHI4TUFiOURwVWZMcGNlb1pQ?=
 =?utf-8?B?cjFRNGRmb00wUVR6WUt1REpqRnU5dDE2c3VEekxDSC91VVpVbGxsdWcraVVm?=
 =?utf-8?B?bThHemdtVkUvd1F1RUNRRnEzTS9ZeGI2d3JYRG8reTJzSU10MVRlRktYbjRK?=
 =?utf-8?B?Ny93L1JPeW04d2dUSlN6TVVqV3c2UG15V2gzRERlSnVqc29tcjA4Qm8xNkcy?=
 =?utf-8?B?R2dDYzBhRWlFTDkxYmUvbDZldnNZNWNuRE1uYzdDUTZyNCs2TGN1NWpKSnhs?=
 =?utf-8?B?YnlzaDcyMGk2dWZDcVBDSDFKUC9ZSkJ2SVRsdHpGQTB3cmZXNktMeXRvaklC?=
 =?utf-8?B?OG8rZEo4eXQ4VkFxRitPN0VtMzhIWWJCZHJpcDQrbmdKTC81MjZ4L1pVSTlQ?=
 =?utf-8?B?MVdSV0tyZ1NBTlp5aVV4VVczdlhUNmg5cFVwME9vT3UzOWliOTZma3JoWnRk?=
 =?utf-8?B?TE1VOFlPTnQzMWhNVW1SOW5qOUx2U0pBTUJPU2x0NTBLZUw5UTh1ZnIvdlNs?=
 =?utf-8?B?akdZOUxUUTJOMHZDbkNHeTcyVnhqUVJyMFZWcTFaR3VpOE9hcElteTZBck1j?=
 =?utf-8?B?aEM0MEdxTmxEY2ExcWNHbVMzSy8rRWY3STlEWTYxWFBYeEZEcENpS2dIdStS?=
 =?utf-8?B?R2xWSVhnWng5b0ZMWTdZQTRCcm1icE9ORC9Hc2VlRU5ERHJPUzdkcmYrRHMz?=
 =?utf-8?B?OVlaWVVVQzdUMTVEeGM2aGcwTUNlVERGSGdvTGgyTW5yWmdMN0pQSy9Uc040?=
 =?utf-8?B?dmg0TFErUGpVNEdKRWNNV20wUzUyLysxdnpGUndlYTJ1ZXNSR25CeFlCaWE4?=
 =?utf-8?B?WVE2Tll5TEpvZE9KK2NJSHhSRERHMU9DeTZZaFJlcGp4REMyTjZDb3dnZ0JL?=
 =?utf-8?B?VjduWEtBNWpzWUxtL0QwaEVoSWZFR1hLYzRFWW9sTllMbVZiN21MVUllQndi?=
 =?utf-8?B?MVVROWZTWlRjUXRuMGl1czNraHNTM2hOdjI4V216VmFRTjZMRlRtODVSWlFa?=
 =?utf-8?B?UnpCMzZNSHVjUGVEK1FDcndNTytzUElZOEJuSDJ0Y2dTUzhxdUxMY1Vkd0tO?=
 =?utf-8?B?UnJGampxN2NoWHk3QVgzSW9STGxRbUhGYXRKMUZGSkt2YTBybzFETklqZG1x?=
 =?utf-8?B?T3VVVi9palhpUkNBU0FBazRvZUFsRXU0M0ZORzdRcVREcC9GV21qSlBjOUZz?=
 =?utf-8?B?S1REeTR4b2tiNEduQmRvS0VSVnhiY21vUFlLOFB4VHFjWGdncmhBd0UwUlZN?=
 =?utf-8?B?cG9aUzRPV2wvN0gzc0Yvc3Z3MkFYWXlmWXJjV1RnSWpkWmRoT241Rk13bEJN?=
 =?utf-8?Q?hjTJLlhsEkjZj?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bHpOZHRrSVY5Q014ZGFKeTlXSUo4MHc4UWVaaWVjZHp0OEk1WFk4SC8yM2NP?=
 =?utf-8?B?RGhhMkpNT1JjcDBhWkx1dmRCa3l4aWZvTGh5bHpackxKemhROWJObGR1SU95?=
 =?utf-8?B?ZnovSnVVVkNTdnRkaGFFOTZQV1l1bElERDlDT0JQK3N1blZiVDFCcVpoeEdF?=
 =?utf-8?B?cmVya2dNVFNGa2VTbU42VitZMFpBdnZDYk5VdFduZEFxcGFCREViUmZCb0ZK?=
 =?utf-8?B?UFM3ZVZVNXdGSU5Zamx2WVB4VnAwc0Y5Tnd6c3lidnlOWGljWXNWaWJTZFIv?=
 =?utf-8?B?QndPNEpCMnBaV1J2RXZiQkpHZVIvb2cveDVzUFBGQW4vcEp4RUU1SXl1U2d1?=
 =?utf-8?B?eldMOVlFWmVWVit4WnRWRTFPQWtKTTFKSGdVM29zT1ZNRGJZNXNrbUZZSU00?=
 =?utf-8?B?WktEWVR2enB4QWwrMy9nNWZEZjQ0aEI1d1hkeUtnakZnU1Z5a1pHek9lZHRl?=
 =?utf-8?B?UVBSdEVoRkNZZnh2MGNhTWlMZWdCUUFjS3JxZEJjSzhKV1ZWdkl0NDRzMFlp?=
 =?utf-8?B?Q1RrdThZSEJPcXFmdTc2OW5VUnVod3htK2d4eDByZmxzQnUvVHNOYVVGL3Zz?=
 =?utf-8?B?Q3YrVVZnU1l6YWphL2lsOUJBcGg2R3NrOG9LMVZ2VEY0Sy9sNDhtZ09hMm1S?=
 =?utf-8?B?VkxOcHZVWXE3QmVwK3gxRlNkTW9CZGl2a2RMa1Boa1Y5d0ZDOS9LdmRSTzBB?=
 =?utf-8?B?K1orNnpIcU1vcEhjUUVQZUxVVmtLSUY1Z0tWNWsvZVRpbmhESGp3cm8xcXZp?=
 =?utf-8?B?cEU1Q1hTbk1KRUtPNStGOENGc0lwQkI2b2txZTR6SUMram1ZNy9DNFI5N0c4?=
 =?utf-8?B?ZUtuT3RSY3YzdEExUTRWcEp3WVFpdGhXcURvWG9vckFNL1JFaVFyOUtVU2pi?=
 =?utf-8?B?YnJLZ2hiQnNmdGUwWmt6ai80aGxORmxhV3M3U01PVHZOZTFDNEszTGo2bWY5?=
 =?utf-8?B?ZXdQSTFZTUZlYjJYVzdFSTNsUTM1alczbktoT1g1NUdCWHo2ZjFaL21DTHhM?=
 =?utf-8?B?S1lRS2dLL0xNVk10ZllRdmRPM2xocnFFeHl0UFJUcVZiUzRtdEsvR2lVYjZK?=
 =?utf-8?B?QzE0UldjUEUwbkFzcWVBL2RHTjk0VndZci8yL0FEeHA3NitURFVJKzlQV2c4?=
 =?utf-8?B?RDhHOFpSVitzOEU0cVpYd3BEOVRsYUZSN3J5ZHA1WkxPK0k5RDkwbkVaa0ZB?=
 =?utf-8?B?bFhFdmZIMjI1d3NBcTdOOEcvbGxkVWluMFViWll1bUovS0N6cXRSWUFkU2Ex?=
 =?utf-8?B?RWo0cm0wZi94VFgvMmhXU3NZdytnWFFnMDN0bGtxUlA5YVBkUWc1VlRsTFRr?=
 =?utf-8?B?d3QwczZJVHMvWmlKNUZ1cURFR2ZjRHVCWTR0VFU2R3BXTlNvb2g1QTV1NGVv?=
 =?utf-8?B?bmhNSENOUmFwQy9seEZDWUtiS2t6RFk5bHZOQTlYRHBjSTYwRTgzUnI0TE9F?=
 =?utf-8?B?N3ovOWx3NHBvbDdSU0tMaE4zRnBVRjhBanQvSFkxZHh0aEtOTE0xaVRDVFdh?=
 =?utf-8?B?ZFRGdVJKaHpLa2gwUVNEbDRhbGxEWTdqQVdOSEphWFBxN3BFRVZZR3ZMQmI1?=
 =?utf-8?B?YTV5TTV3U1hCWk05S0dZMEZYNEY5TVAwTGNLLzZNVzlhTEV1d1dvYVdhOFlE?=
 =?utf-8?B?SFFPRm5HTEtSaGVqMW40WHBncXdSNmU0c0lMdFRzdVA5ZFdDT1BGN3BnNyts?=
 =?utf-8?B?eFBzc2dNc3Q2clBGdFFURDhPZ2lGdnlROHJDOEx0S3VqV2JJWTdjVEhIWDIy?=
 =?utf-8?B?VVZNWkFoT1BMeXNxNUJlRXhibW9SRGJZZmNOc3NGU3AzbkhjWTd4N2kvdUNM?=
 =?utf-8?B?R0FPazRMWnVaMU40d2J3NUw4VE5rT3VjNmQrdk94ZkZUUUlwbCtaV2ZQUnVZ?=
 =?utf-8?B?SFlWaVhHNmp4eEZjdEdrdzN3RFQzMFh6emltZGZ5K21pcTQva3J6L3RaK0gr?=
 =?utf-8?B?L2JQVzVaV290Tkp5eG1pTGFYVTMzeS95Z3dwMVJZdUxtd1ExVDFIYXVBUUs0?=
 =?utf-8?B?Q0ZYSVlSRVM4dlQ5OWhyRlZxd3NUdm1Ua2RrM29ma3Q2TWNrbkRJZ1VWZ1kz?=
 =?utf-8?B?OVh1N2E3OGxuQTRxYU5jNnAzZ3V5TlJ0QUloODZ0c0NPUUY3M1RSRkk2RE5a?=
 =?utf-8?B?Mm5wZVhDWVFSUEg2UEg1UVRWWXVrNFBhWC9YbkxJeHRZcnBLUUVTTTlDczF6?=
 =?utf-8?B?OEE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: da1b4a6a-b2d8-4933-036e-08dd62752b13
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2025 21:22:33.6339
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OI3SzLzU6in6EMK5gN+iIl+jBvnoZuQv0A014btp0KMV06THeAJtalcGMSnCXXXLtTCrLgp3p835URQfr1qmJPlRxrFFzogtiyCslA9kKlM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6339
X-OriginatorOrg: intel.com



On 3/12/2025 12:21 PM, Heiner Kallweit wrote:
> Avoid using deprecated pcim_iomap_table by switching to
> pcim_iomap_region.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> ---
>  drivers/net/ethernet/realtek/r8169_main.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
> index b18daeeda..53e541ddb 100644
> --- a/drivers/net/ethernet/realtek/r8169_main.c
> +++ b/drivers/net/ethernet/realtek/r8169_main.c
> @@ -5447,11 +5447,10 @@ static int rtl_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
>  	if (region < 0)
>  		return dev_err_probe(&pdev->dev, -ENODEV, "no MMIO resource found\n");
>  
> -	rc = pcim_iomap_regions(pdev, BIT(region), KBUILD_MODNAME);
> -	if (rc < 0)
> -		return dev_err_probe(&pdev->dev, rc, "cannot remap MMIO, aborting\n");
> -
> -	tp->mmio_addr = pcim_iomap_table(pdev)[region];
> +	tp->mmio_addr = pcim_iomap_region(pdev, region, KBUILD_MODNAME);
> +	if (IS_ERR(tp->mmio_addr))
> +		return dev_err_probe(&pdev->dev, PTR_ERR(tp->mmio_addr),
> +				     "cannot remap MMIO, aborting\n");
>  
>  	txconfig = RTL_R32(tp, TxConfig);
>  	if (txconfig == ~0U)

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

