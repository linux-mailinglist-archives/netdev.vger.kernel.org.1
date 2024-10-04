Return-Path: <netdev+bounces-132293-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B23D09912E2
	for <lists+netdev@lfdr.de>; Sat,  5 Oct 2024 01:19:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 330AF1F23948
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 23:19:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A12E014D290;
	Fri,  4 Oct 2024 23:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iE0/hlqr"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17E62130ADA
	for <netdev@vger.kernel.org>; Fri,  4 Oct 2024 23:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728083940; cv=fail; b=OTTGin2E8Yzv3hiELTiqCI0wA+znhk+PbCb0co+NvHP+p5LNLwL7B2YgfQldLpuAP6nGtDA9ZK2Mpj/EVgl/TqX79Chj2Mb6EjGS1xVDnHN74/tvMrbT+RSCqQUaQaJ8JfKNGvaf1IwmUuM/Bfu/H9y0LOW3lt0XKTLkq4Pf9SE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728083940; c=relaxed/simple;
	bh=8oUwriSHU5OXM+Rp4BsIdbEPv/XEdG8l1T8ilP79AVg=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=oPJlFXZvNRm6M0Kr+i7/jjswsAUu6n/aq/Ca4SXVyquSUa9FvfTW+nJH8IcwH4qY6mXofv+4LPhzjK9BwzVyvhP5RcwVpWJlDlixHOHIwdgHxP+bgTn0AtCSo/7R0PR45FfLLUXNZYWwfKoM7wI1ub9i+jv4dqdIX9+uojBucGs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iE0/hlqr; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728083939; x=1759619939;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=8oUwriSHU5OXM+Rp4BsIdbEPv/XEdG8l1T8ilP79AVg=;
  b=iE0/hlqr/84a/oxNGQzKEcelGtdIUvkbfqLg3KIeyqdn4xW0jLzf4Rs2
   STtoiEwS67kiMEnGzUuwH16onSmwrKEJulHKb3LEHobkD4rDgLHLnHOIS
   4F1ul38EOd9N4MKC+9HxcH9DQi8XiqPRAdPsNYhpoC5UfTfmF2+4ZyT7Q
   X0U8aum7qDVI6XG9m2DrkYRjsm3P1pi1zEN4s7DqUO048rOzYpLkjtLY6
   SVBNalVxA+03vKOpTWC9kRVIttC6ArB2WmJsksJiwne1Clc+5HOGUUum9
   I2vNx6s+f5f86EjAgsE1JOpTlqJuxifVB5It0fx6Ql9KcSXBqfRSaZRRF
   w==;
X-CSE-ConnectionGUID: zzIxU7BLSxm4twIB5N3Adg==
X-CSE-MsgGUID: 40Onn7OPRaGwM94W49kPKw==
X-IronPort-AV: E=McAfee;i="6700,10204,11215"; a="14940985"
X-IronPort-AV: E=Sophos;i="6.11,178,1725346800"; 
   d="scan'208";a="14940985"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2024 16:18:58 -0700
X-CSE-ConnectionGUID: KM1PD+FCQ6algKtmus4sBA==
X-CSE-MsgGUID: 7EXovB/TSHm58dWrZozjQg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,178,1725346800"; 
   d="scan'208";a="79268292"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Oct 2024 16:18:58 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 4 Oct 2024 16:18:57 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 4 Oct 2024 16:18:56 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 4 Oct 2024 16:18:56 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 4 Oct 2024 16:18:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BkzATUmZXkTwGniRqIRSc5NVI8dupi76H7GgtvhJzWC+XbSQ0Lf8FvtVE8J7/8N42od32T38YFaSeX1Zq7QaPWW2YxqHw0zoG+VcDlcEf1bHdklmSXGUraMYiLRgUpcbcvWXbr951RuzEzUI+mWdwID7sXG60/lMzvoeWjnX55xBL2NWaBGngnqfZWvaFBq6cemZEI3hx+BYMUnJtUXQy+PyK9fNqvVhh6N0yaBWfGwQc1b0UGDTFmVZ9qQj4m5ITQLC1oxqvYpReuF0aAE84UgKvQ9V76ckKTxUSunEliConr0UyterHkLoQVf0xuSzOUnjK/ezUzam59GJVRWEOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9D6Mfsj91Sq4kT6EWzStD/jC7TGfPhKuNEH+q33XEwo=;
 b=pkRFgAdaw7yUJk0q5x5pj4Sb1/5OqrIUVGo4ZKU95hFtmBo1S191ryHtnuqLpATgoDJ1I/LifKTNfOSo+lllm3rzxPNiYcp6IWbuLvyA2diCOCcaEhzhcX3fvdHQyju+EeB/6elm6gR0EYZ/hEjFU4Mf1qhxmlHiFwEw5hjkTIp4jyovasCmf8W+CYaV1svHc6EP3uPbikPLMVMOXZNgExz4fFnInyd/wH4Nj5lyKCYeJO3oGI4IF5K/GF36j5BNMt1aCt9StxkxdNhbBnu7gACbom9XzJEiMYjWLNeLGZsvqNjWflrnLSp0OoV4PyQmV67cG7aDIT5kibXWOE2rLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB5095.namprd11.prod.outlook.com (2603:10b6:510:3b::14)
 by SJ2PR11MB7713.namprd11.prod.outlook.com (2603:10b6:a03:4f6::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.18; Fri, 4 Oct
 2024 23:18:49 +0000
Received: from PH0PR11MB5095.namprd11.prod.outlook.com
 ([fe80::215b:e85e:1973:8189]) by PH0PR11MB5095.namprd11.prod.outlook.com
 ([fe80::215b:e85e:1973:8189%7]) with mapi id 15.20.8026.017; Fri, 4 Oct 2024
 23:18:49 +0000
Message-ID: <6015e3d3-e35b-4e6c-b6cf-3348e8b6d4f6@intel.com>
Date: Fri, 4 Oct 2024 16:18:47 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 3/5] eth: fbnic: add RX packets timestamping
 support
To: Vadim Fedorenko <vadfed@meta.com>, Vadim Fedorenko
	<vadim.fedorenko@linux.dev>, Jakub Kicinski <kuba@kernel.org>, David Ahern
	<dsahern@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "David S. Miller"
	<davem@davemloft.net>, Alexander Duyck <alexanderduyck@fb.com>
CC: <netdev@vger.kernel.org>, Richard Cochran <richardcochran@gmail.com>
References: <20241003123933.2589036-1-vadfed@meta.com>
 <20241003123933.2589036-4-vadfed@meta.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20241003123933.2589036-4-vadfed@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0379.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1::24) To PH0PR11MB5095.namprd11.prod.outlook.com
 (2603:10b6:510:3b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB5095:EE_|SJ2PR11MB7713:EE_
X-MS-Office365-Filtering-Correlation-Id: 117a073c-a028-40dc-cdaf-08dce4cae720
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ajMvV3FYTEFvQTNWblZYcVphRTZqSS9DZW1yM3I4eE45bDdWMWZkU0N0LzF2?=
 =?utf-8?B?QmwxaWtwYkVmbnpqVjVUQ0x3UHNCN0dQOHUzOCtKWUtTSW1mM1ZkNE4waTRB?=
 =?utf-8?B?LytXUjlWS1ZpS1RxK1Y1a1Y0M1NSZUVmQ1FRL1FpQ0pDZUExNFRsWC9QWmov?=
 =?utf-8?B?REgxcFd5dXdqVU9pbEJoTFRZcUYzYklHU3lDZHVzeXE4U3VFamtoTGt4T1Zq?=
 =?utf-8?B?VUZ1RDBvZnZHYlJwQ1hWaGQvemRSNWJTcUVJQ0FQRGdud1AwNTJlUGxHSCtZ?=
 =?utf-8?B?WU1Xc0huOXNmRGJjTGszSythdlQxTGJLT09sMmlCRkhEVitwTWxlUVF6bG9x?=
 =?utf-8?B?Y0Jpbit0NStQTTJHZjBSN2lBeFdQdTAxLzUrNmhMUkJLeHNodENMWll5Ty9y?=
 =?utf-8?B?RUxpcHFyRDRQdDNMODVVc0tFaytGanQzdmoycUVLaEpJek9jRFVGcFphUjR6?=
 =?utf-8?B?REFEUzMyWFdZT2dVV0xkK2FxZFZSMUIyaHVQUll2aXBtRTBpVUdFN3NiQUgr?=
 =?utf-8?B?WS92MUx3dUFrcGgyQUFhdVRwbGlSVGJSUmtnQ2IxalBFRFpPb2E3ek1nazJa?=
 =?utf-8?B?RE9ZY3AyUldHaGhGS0hoeFUxbjM5NVY0NDh0N0hTRXVvaksrVjB0MDQ2Tjli?=
 =?utf-8?B?dkhrSjRjVFU3Y05pVFhKcHpGKzYxQzhJTVlMQWxVRHpldmszVHpuRUhGSnA0?=
 =?utf-8?B?T01JTnVwUmRBMko1OXNXNkdMOVlWZnBLMGUxcmF5YS9uWmFhQnlacUlVNTZj?=
 =?utf-8?B?Q21pQ3paV0h0ZmpnOTlkcS9YQTNIWE5xVzBOTWoycm1qR2d6dHc0alJJTGl2?=
 =?utf-8?B?dUhLdmlvUmI4VWI2NVVVUVRyMXlvODI4WGo5SzdHOFRXdzhYUW4wK2czcjlv?=
 =?utf-8?B?dVdqTXBDTUhQZkhYN3c5eTFLWUJYN2JlTWV4SEtkK09ycmNCU2l3UFZWUXZm?=
 =?utf-8?B?R0xRNEk0bFd6M2FJV2VUYTBFZVZlSkNJSzZZeG9mSTlaSjhzVkVJRzgrYTly?=
 =?utf-8?B?L0hzNzdkdkRLV1RUcDV6ZGZHcGRVazJFYUxTUTR5Z2FHOC9VaFRXajNWM3JO?=
 =?utf-8?B?c0VSamVvUHpZR0E5VWpnb1V3d0E1UHhmaC9iRUh0NFAwcUZ2RnhJVlpOSnBI?=
 =?utf-8?B?Q2ZBT0M0R2hwQ1dJSXRXN1lOeUgyQ1hSRVlxY2pFcXVPMmNVTFVFUTRaU2xr?=
 =?utf-8?B?emxxVVltRTVDYmdreVIwdzJ2L2FFZUdyQk1iWmIzRFI0NjZlNXdNd2toNURu?=
 =?utf-8?B?K3BJZnZKQ1BuQlkyWDZhTWVFNElrY2Q2QXFFQ0FPM2tIZjFubUFNTFFIY2V3?=
 =?utf-8?B?T01BQkJHTHByazd1SXVLZEpEeTZyYUJrZG00OWNPekhBQmc4Qk1qMGQrQUlx?=
 =?utf-8?B?QjFFS3IzWHQ0V0FNMzgyejZyVmJZU1Q4Q2x5YStFNzhCTU9QWTM5aUd3cGxh?=
 =?utf-8?B?M1lhQXFKN1F6WEpKRmE2ZU1OcHpzODB4MGNQM0l0SzZ5aEJsQ2RKdU5IaFM4?=
 =?utf-8?B?bkVObXVUU3RoRFZsYTIyVEdGNldZZE9aUHB0VWl5b0lPOEttd28xNkR1bUJP?=
 =?utf-8?B?SGs3c3BlSDN5eDJpL2RvOHdXSlNwWTRrT1VNMXhIM2ZIR1VHNjBpLzBYeW9n?=
 =?utf-8?B?b3d5ZVJ3b3JwYVhLeDdmM3pHRmRyR0FQaU5FT1ZtcFlHRGR0Y3NBVWl5c3hB?=
 =?utf-8?B?bkZvdU1MdVZHVk9WekczcUlYTzlaQVhRZ3Q0MTRDQzE0L1g0TTBwd3FnPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5095.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OGpJUXBIS0V5Y0gyVUhHOFEyUk00cEw1NlZVYjlvbXFMcU92YWsyTTZyWWZZ?=
 =?utf-8?B?STc0M0x1RUZ5VTVsNDRFN2dXU0R6NVk5dGxmcGhndjIyaHY2RVJ2Q1ZSNDdM?=
 =?utf-8?B?WHhkZTdwa2lsNkNId20zVmU4QzkvNW5xMVltMTRMVnZEMmdGMDRUNnF1NVll?=
 =?utf-8?B?NTFUYkhjeGZhTzBYTldmUEZuTDYwcE01ZmtjVmUyejRsbWh4U0taN0d4akZk?=
 =?utf-8?B?dmFjWVRROEg3anBjRzF5dE5lVE1wc1hVQlpJZ0dpZXRIL2VlbVZjZGRQMTM3?=
 =?utf-8?B?ZjM3YU9tQlg1SkVidlJhVDgzcU5lVThkdUhoKzNmcU9iTXVmTWFwZ1RJdCtW?=
 =?utf-8?B?cmZVVUc2a0tnd1QyZzNuS05lektPeFZCTU9Icm9KODdrdUR0UmRpazV4OTJB?=
 =?utf-8?B?aUhUUWE1Z0pDMnVNVTZ1bzl6QmhnaWhSclBzU2VlR0pIMitNeGtyOHM4SnZD?=
 =?utf-8?B?SFZQKytTd2lZcWQ0eUUyci9aNmNEc1hpeGo2TlpqOXZ4bFNYNG4yNmE4dkNH?=
 =?utf-8?B?NW9GWmY4TXhZeWNZcDVXZFNHWGNrYXhML1crNlNXdm5qS2hlZzJpRWtESW9W?=
 =?utf-8?B?eEsxODlrb2FmRXVyaFpwNlY1ci9IczU4WjdmMWJZU3J1aW56MVk5cUpETEE0?=
 =?utf-8?B?bDUvRXZqUW9mME1wajYweno4WGRMYVBwcVFZOFhNOG1iNVRFbU9JOTl3T1pU?=
 =?utf-8?B?cXpOL3FNakFYSkg3NFJSNW8zQ0V3TmpTUXhhZVNHUy9oR2RXbnFTdENGbjBH?=
 =?utf-8?B?TGxRb2JhYmxERzNHWk1rVjVQdER2RnI4UHE3S3h2UzlyelJRanlNbkovWVFj?=
 =?utf-8?B?MlViYTE4MDZvWGVWSGF4Y2ZNemJZcEF0RWhpT21CUDRFMnpHQW1LSVJlQzZr?=
 =?utf-8?B?RGlSNGVZQW96NjkvNlVMWGpZaUJkNGlPSms0VWhkcm1zS2o0TG9DdWJiSkxz?=
 =?utf-8?B?RGoybmlFakdoM0VUZ1RGVndEUXFRQVgwTUdkSjdrQVM0K1B6Uk96L0F4ckdy?=
 =?utf-8?B?RDJjMWhwYWd5MXd3c1lGY0VaV2E3OVBCZzJUZnJDNFFXZ29lRmZ0N0VVZFNT?=
 =?utf-8?B?emkvd0FSRU9yeUdodDU5cFJEMEsxYVZBRDVQa0oxRTJ6VUZGL2FXUFplMVZZ?=
 =?utf-8?B?ZkhVWDlhczNXZk9uN2hTczRWS2F4eVh0czUrMzFlMmNqU1BGYnJ1SmJHeWRo?=
 =?utf-8?B?U05mdU5ZNEdOV0pabUl3clNtelZEeEdGenNSLzNSdmI3VEJwcEt5Wnl2dDFs?=
 =?utf-8?B?WHg1bi81NmJ0SUErbVI5M0VRZmY1eDB4MURwd0x0SWZOOE0wa0VRV1g1R3A0?=
 =?utf-8?B?WUZlMEphZWFJN0hFaDRtNk81YnBPMFEvaFpvMEt3bitIbG40M2k2Q3A5Q083?=
 =?utf-8?B?RUZwYk1XeXJISWVFLzJJSzVzSmVtSUViM2ZHZDZvaG1QVmI0eWlpZ25uN3pp?=
 =?utf-8?B?bEY3Uk5zZFFvRWJoT0ZkY2gyU2pEWk1GQ3V4R3U0UGVxczFoOStVOFQxN2l0?=
 =?utf-8?B?RmgxcGwrNmhuRkdUK0JOd0l3R1UrdE5IdWIyajJObkw2SERmbDF3VFpKcGZn?=
 =?utf-8?B?RElQcUh5YlZvcUo0VytlWmV4dVQzRlF6dU1JNXE0SUFySXg2WnU2aFdjZFFU?=
 =?utf-8?B?d05zOEd6NUtvYmsyYzV3a3RZdVVPTEo4cURGR0ZMcVJ2a1dBL2xjVklHQ3lW?=
 =?utf-8?B?Y2VlL1NRWThGT1g3ZDhUMWo4ZzdNQnY2RXRNTlV2algwdTNZNS9TWE5lZVlt?=
 =?utf-8?B?cDltMXdCemplOW45Ymh3Tlc2Q29tYmdtU0FIaVNieFJLVDNkOWkwZVZ6M3JC?=
 =?utf-8?B?TmpYR0lneUFsck44MmRzNHdSZEpUbFdMOTFxV2o5MlNPZ1p5RndYdEpIWHlZ?=
 =?utf-8?B?QThnTVpiL3FVdTBrYXNHS0l3TW1maG1hckRTTTh0RjNxUVFVa2xJUXp0THdn?=
 =?utf-8?B?L3JUb1lWR0tXMzlLczh3VHJMUmRPNzdsb0UzUmFaWU8zbHRRTjBwMUNSTmQw?=
 =?utf-8?B?dGhBV3dJZkxqNkdLM2pnMitNeDhFTHoxUXM5Vzk0ZFFTZzFLQ29DOU15ZE04?=
 =?utf-8?B?cFVNUUkwbFBOTDFwcnZlWWw0Z0FOaGF2eDk1TGwzemZKTkp0ODFqYVFlOVFv?=
 =?utf-8?B?RUVRdTdjTVJzRUJ6MHhXL1JoclhXeDFsbW0zZ3lFdmVQeVpLRS9EaStsWVZw?=
 =?utf-8?B?VkE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 117a073c-a028-40dc-cdaf-08dce4cae720
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5095.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2024 23:18:49.2923
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N7go2CxPTM+tWMhDqwvYmyTVLjh5H2JS6RafOg/IVsNz1gmFKljgA+XZv74bRsvcJELN1IVYA7YK08ghRvarln9/xCGlNyE0/pc3wmggRtk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7713
X-OriginatorOrg: intel.com



On 10/3/2024 5:39 AM, Vadim Fedorenko wrote:
> Add callbacks to support timestamping configuration via ethtool.
> Add processing of RX timestamps.
> 
> Signed-off-by: Vadim Fedorenko <vadfed@meta.com>
> ---
> +static int fbnic_hwtstamp_set(struct net_device *netdev,
> +			      struct kernel_hwtstamp_config *config,
> +			      struct netlink_ext_ack *extack)
> +{
> +	struct fbnic_net *fbn = netdev_priv(netdev);
> +	int old_rx_filter;
> +
> +	if (config->source != HWTSTAMP_SOURCE_NETDEV)
> +		return -EOPNOTSUPP;
> +
> +	if (!kernel_hwtstamp_config_changed(config, &fbn->hwtstamp_config))
> +		return 0;
> +
> +	/* Upscale the filters */
> +	switch (config->rx_filter) {
> +	case HWTSTAMP_FILTER_NONE:
> +	case HWTSTAMP_FILTER_ALL:
> +	case HWTSTAMP_FILTER_PTP_V1_L4_EVENT:
> +	case HWTSTAMP_FILTER_PTP_V2_L4_EVENT:
> +	case HWTSTAMP_FILTER_PTP_V2_L2_EVENT:
> +	case HWTSTAMP_FILTER_PTP_V2_EVENT:
> +		break;
> +	case HWTSTAMP_FILTER_NTP_ALL:
> +		config->rx_filter = HWTSTAMP_FILTER_ALL;
> +		break;
> +	case HWTSTAMP_FILTER_PTP_V1_L4_SYNC:
> +	case HWTSTAMP_FILTER_PTP_V1_L4_DELAY_REQ:
> +		config->rx_filter = HWTSTAMP_FILTER_PTP_V1_L4_EVENT;
> +		break;
> +	case HWTSTAMP_FILTER_PTP_V2_L4_SYNC:
> +	case HWTSTAMP_FILTER_PTP_V2_L4_DELAY_REQ:
> +		config->rx_filter = HWTSTAMP_FILTER_PTP_V2_L4_EVENT;
> +		break;
> +	case HWTSTAMP_FILTER_PTP_V2_L2_SYNC:
> +	case HWTSTAMP_FILTER_PTP_V2_L2_DELAY_REQ:
> +		config->rx_filter = HWTSTAMP_FILTER_PTP_V2_L2_EVENT;
> +		break;
> +	case HWTSTAMP_FILTER_PTP_V2_SYNC:
> +	case HWTSTAMP_FILTER_PTP_V2_DELAY_REQ:
> +		config->rx_filter = HWTSTAMP_FILTER_PTP_V2_EVENT;
> +		break;
> +	default:
> +		return -ERANGE;
> +	}
> +
> +	/* Configure */
> +	old_rx_filter = fbn->hwtstamp_config.rx_filter;
> +	memcpy(&fbn->hwtstamp_config, config, sizeof(*config));
> +
> +	if (old_rx_filter != config->rx_filter && netif_running(fbn->netdev)) {
> +		fbnic_rss_reinit(fbn->fbd, fbn);
> +		fbnic_write_rules(fbn->fbd);
> +	}
> +
> +	/* Save / report back filter configuration
> +	 * Note that our filter configuration is inexact. Instead of
> +	 * filtering for a specific UDP port or L2 Ethertype we are
> +	 * filtering in all UDP or all non-IP packets for timestamping. So
> +	 * if anything other than FILTER_ALL is requested we report
> +	 * FILTER_SOME indicating that we will be timestamping a few
> +	 * additional packets.
> +	 */

Is there any benefit to implementing anything other than
HWTSTAMP_FILTER_ALL?

Those are typically considered legacy with the primary reason being to
support hardware which does not support timestamping all frames.

I suppose if you have measurement that supporting them is valuable (i.e.
because of performance impact on timestamping all frames?) it makes
sense to support. But otherwise I'm not sure its worth the extra complexity.

Upgrading the filtering modes to HWTSTAMP_FILTER_ALL is acceptable and
is done by a few drivers.

