Return-Path: <netdev+bounces-170886-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BEB4EA4A6CC
	for <lists+netdev@lfdr.de>; Sat,  1 Mar 2025 01:00:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C76FE178539
	for <lists+netdev@lfdr.de>; Sat,  1 Mar 2025 00:00:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18A371DC9B8;
	Sat,  1 Mar 2025 00:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QbXlkm3N"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D59D23F388
	for <netdev@vger.kernel.org>; Sat,  1 Mar 2025 00:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740787230; cv=fail; b=ek64ozvXEkbCuhKqdEV7vyeh7xyLQVYgGdAkI0LeUlSjxXHmSAw5jwzS7M6wm3rIDfHvDRv53nRQSsU3PRpAmVW2NAWk0+Re2F2J5cacRAdMViR1e8dHriqEldmW+Lx06EdwRmYGqPql/liUwkgdhePk2Lxn8Anllm2WRRf/P8I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740787230; c=relaxed/simple;
	bh=vvPZnrwTGu//Gm4rBOj18FkwbVpJMHtbJhTcz226ULo=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=I/HC3TT4LJKGVienBiNOCeND8I6m20bmkQ9A3MmXqusrbAVufBia0C/I4iUI92aM3Khszo2QdZ8Km24YeCpjB4gJWAfcmjM5a400ofSYLu0rz1OZlj7koH/YT++NuAltxMXZ5s4eDMaTIioG6K6KMAEL505tLncH84Z5i3AHpx0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QbXlkm3N; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740787227; x=1772323227;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=vvPZnrwTGu//Gm4rBOj18FkwbVpJMHtbJhTcz226ULo=;
  b=QbXlkm3NfI/dCorzB6fzsqC4BYIg260GvAk01I7HcZXImCQrJBblBykB
   xql4vK+WTrEyaz4e20bD8EEfuw3EE/h6oyYSO+oSC+ExuBulmc/EKit5O
   W4gz1CFotG6rmxxHDQ8+l/wLjTRIZ6UXXTrNpDLuTJzY/TfgYcnC0GORs
   DBkVE0DTLLDZQD5UP/VIsXbEcMOdRjDlVbw482SryGQB/X2EclgLz2eej
   quDWPkc3g1PiK6BzdVDNfFI6PB9k4zezayxt2Qwct3g3QgetaaXO0Icdo
   LvU6stxOANYV1aH91bXhi1rqcF9dX+Nbk7fiVR8PSwtnd56VKx6XMG+7+
   w==;
X-CSE-ConnectionGUID: Hgvdfy1/TmuC413V2eq2Qw==
X-CSE-MsgGUID: DG8rOjz+R3qItMoo/bQJcw==
X-IronPort-AV: E=McAfee;i="6700,10204,11359"; a="67101325"
X-IronPort-AV: E=Sophos;i="6.13,323,1732608000"; 
   d="scan'208";a="67101325"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2025 16:00:26 -0800
X-CSE-ConnectionGUID: Tu/dRywvQ5uqZcj+rczsDg==
X-CSE-MsgGUID: DLrihzSBQDaUEbstkKxBtA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="154649057"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2025 16:00:26 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.14; Fri, 28 Feb 2025 16:00:24 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Fri, 28 Feb 2025 16:00:24 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.40) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 28 Feb 2025 16:00:24 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yA2pUZCa6fcAEYnBN1CKUrhBZ/9YPAASzT3RLyPBLoKFxlI6PZV64VJ1spFPa8I81VyAeFt0avqn8VOM+qUNQTLticTUoOqZ/GHYgW0fUHy5fB78+9nSggiKsaegIrPnWJhkgaOff+QBFbCMgo3Gn1WBDEbLBiN1rz8gouACM2ujEQ1flxZZnIN6vRSUaehnVRlHQI0f8rFzUEmvV2j7tr8rGqY4HiT+3/51Ttczlyb+KL5HSX/MeXJhyDQBOnQyfyDQM9IDaJ4vE6m5UrHxx6Yu7NvT6mUYLXKY/ajwiU+JbuiUE/IfSNimpNiK8kzSeTdV7QToX6RpwH01CTxUaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z2ODRdzWPMTCZYp/XpRJg1dOqpce/olNEvT2RtX1+ys=;
 b=tXdFU6Of07v2Sm2frqPaiwax/uZCQKptV6ybo5ACCyiWU0/z6ho1l9uazZG8ryNIcpcIQM2t7QwhCOYF4mZhW33ovfp+wNmUwg5j7ZrtoBw9ZYo8g8XPbHWNwDUVbuMWOZG/uMYaXHbTqL9JzyfvAvNGRqqNciKWFrKTCtDAPo4sQmpkZ+lrc2ImOupsDxXsGpt7wd3LHOCCqOWmP/9wSL6c4xRb3DRqI4d5A0AjoUQuwC6zgflLNxJ3iW+xEfO7aSiiqXjmIRZW/JHGsggPDnLafurTj6TUigCnVrlffHUHiosVx0Mh90W3xbrlxJzVcVsqsKr1ILVawlAF+tQA4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB7420.namprd11.prod.outlook.com (2603:10b6:806:328::20)
 by PH0PR11MB5207.namprd11.prod.outlook.com (2603:10b6:510:32::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.25; Fri, 28 Feb
 2025 23:59:55 +0000
Received: from SN7PR11MB7420.namprd11.prod.outlook.com
 ([fe80::b8ba:be35:3903:118f]) by SN7PR11MB7420.namprd11.prod.outlook.com
 ([fe80::b8ba:be35:3903:118f%5]) with mapi id 15.20.8489.021; Fri, 28 Feb 2025
 23:59:55 +0000
Message-ID: <f186dc24-8cc5-427c-868a-1162e75dd3e8@intel.com>
Date: Fri, 28 Feb 2025 16:59:47 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] idpf: synchronize pending IRQs after disable
To: Jakub Kicinski <kuba@kernel.org>, Tony Nguyen <anthony.l.nguyen@intel.com>
CC: <davem@davemloft.net>, <pabeni@redhat.com>, <edumazet@google.com>,
	<andrew+netdev@lunn.ch>, <netdev@vger.kernel.org>, <willemb@google.com>,
	Madhu Chittim <madhu.chittim@intel.com>, Simon Horman <horms@kernel.org>,
	Samuel Salin <Samuel.salin@intel.com>
References: <20250227211610.1154503-1-anthony.l.nguyen@intel.com>
 <20250228144051.4c3064b0@kernel.org>
Content-Language: en-US
From: Ahmed Zaki <ahmed.zaki@intel.com>
In-Reply-To: <20250228144051.4c3064b0@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4P223CA0029.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:303:80::34) To SN7PR11MB7420.namprd11.prod.outlook.com
 (2603:10b6:806:328::20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB7420:EE_|PH0PR11MB5207:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e976503-4a7a-4807-364b-08dd5853ff98
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SldQM3VrcXN3NUhuaThWdlBHTXBSRHUzVU5YVGdjMENCUGkraHVyZ25OWk9l?=
 =?utf-8?B?MkVrUFpEdXIvYjAyNHhSOUJwNVVoZjJzQ3FiV05MWkkrZExzNUNHNHpUNFMx?=
 =?utf-8?B?NG1wRmRLUmxDaTlPZ0ptVEtpQnMyZHlGT25FN3crMDgybEhDWGJBL2IrTHVY?=
 =?utf-8?B?YWpFZ2UzRHFwNmhlOVM4WTVHTC9iZWRFVDlIUEROdklQeGF0VVpBVHRlQTV2?=
 =?utf-8?B?aVVhR0x5enR3cXpQaEJNQTZ4dTNSaXFEbzlwUzlydkM4NEN6WVBuOXFsRUJI?=
 =?utf-8?B?UUhLekd5UDhyS01TaDQwWG41WUdxbk1zeGRHV09qZFpFQTkvNzZWNW4vQzVu?=
 =?utf-8?B?di9NVUR3KzlpL3VpeW9XdWhmY3FLVjRNOE93UlI0QWJQRU1qMlAvcnBaU051?=
 =?utf-8?B?UlU1REZPVk1QaFplc2g0c2JXUmg5YkRJZUNXb200bE5pVVZPQThLWHBnYWRV?=
 =?utf-8?B?ZGtiRkdjSkdxN292Nk9UNVgrRWw2SGUwUUloSi9oMnZZZHlCQnc5bUxoWGIv?=
 =?utf-8?B?OUZ4UFB5WURIMzZZUWtvOGZPS0RiOHFaVDNnWFVXVUZxdkZUQ09kRUVxK25y?=
 =?utf-8?B?VUdWK05BUmRjbE4zRnpIQjluYWNrd24rWnYwNXBXQlJaNVhJNkpXWnRtVTZY?=
 =?utf-8?B?QkZISldsWmt3dmkveXU2Y0R5SmJhZUZ1VU54M1MrZzR0UU9vUWVHMk54UTBx?=
 =?utf-8?B?NXMwOTVrNWNQd0J5c0wrMjVlWUZFTXlYMEk2NTNqUVlrMFczTFdSMmtCVUln?=
 =?utf-8?B?azhWNFZyMlpFWWZodlNNMXZPQW0zMEVyVFdaY3FJalNpQmRxR2k5SDNjQmF6?=
 =?utf-8?B?QTlNKzJQVXk2SXA0WTZyWUUvU0M3Q2YvWkJ4QUVsNmtqNm9ndGRBaUhabEZa?=
 =?utf-8?B?ZjlGZUI2a1ZFbjdNYi84KzEzRFR6MFcvMUdSeGpLRXUyS2dtVjk5MXI1Lzg1?=
 =?utf-8?B?V0xhUGdqbS8yZmw0TXRiTHNZMTYxMjlCb3JCV1VlM001R1JNa2R2bDZCaVpa?=
 =?utf-8?B?Sm1vYk4yU3RjTTZHamVHM2dwbVEvcnRiOXNMTVcxN2krdG5hWkxyQjRvVDBm?=
 =?utf-8?B?YVFWQllJV2NoRXBqTktDQkRkc0Y1ZVpNSko3cWxHNnN5a1VUS05yQVJNNHZk?=
 =?utf-8?B?NWNqU0h2ZEpySGdDSHlHMVZGSjAycVNzRGRlZlhBU1RVazZrK0NvaUZ0aVNJ?=
 =?utf-8?B?Y0dGa2xKNTNBcnpyYlEyOXFXNS9UMVpJZCsvSUtSZGpRRzVES1Q3NUJCUDRY?=
 =?utf-8?B?NkNRR25WOFMraEJncWdaSGQ0N0hxVkxQZzkwcUM4Sm5EeE5BdkxJWUdnN2Zj?=
 =?utf-8?B?eU13VjQzTXNKZGlPK3BJRDllTDlmYVYrTk1TaVdjVElVcXp1WGV6NlJPZmVG?=
 =?utf-8?B?anhPaXA3QVY5Qnl0UHJjcXhuU1d1S3ZEbklzaDFBYUh6Sk5FYTZ6ajdzeXN2?=
 =?utf-8?B?RTB1UGhTSG4wTFhZZ2FKMlRPeDNYSFJmZlI2VGJYdVRRN0hKZGRmS3Fxdkgw?=
 =?utf-8?B?MGdFdVhML1c3Zy8xUEpMWUwxc25mY3RKYVRPV1lQcWdoekQ4YUJXdHNmVHVp?=
 =?utf-8?B?c1E5bUo0aGhnOXlzN0dRcGZlT2VwRXBWMVIyQ1dzTGVIOUZjN0ROcFdIeC9q?=
 =?utf-8?B?MEp6Tk1SRUFUUXZ4a3FtK0NUVVhxVkNJSERyeHNSZDlpbFFuaytiMFVOSE9P?=
 =?utf-8?B?U1B3R1BiS0h4YUxMd3I2MnE5ZkVSYzFhSU5aS3dSY0NyWUsrZFVEaWYyUEhU?=
 =?utf-8?B?V2ZHd29KZlhKVUcrOEV5d2dnMUlxdWE0a1FlK3N4U1NDNzhIbmdRZnprNUdU?=
 =?utf-8?B?SGY4amhLQTRyRDhSSnlEK3BEbHRQTFYvRXYxUjlYdWV6MDZUYlJOeEwwWE5B?=
 =?utf-8?Q?Jd78gYq0rRaja?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB7420.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ckQxam84YTBKbkhQK1dNa1ZJcFd0cFRiUlBhS3VCVUNQWXJMaFhmWFFUZzRm?=
 =?utf-8?B?aU5jcW44SGtvTWFIUk1vQnFIeUZkbHpzZWxaRTNaMEMwekxLR29FQTBhWVl2?=
 =?utf-8?B?NXhtaktyQXBWMVI1dHVxRjN0M05QK1pCejJTRVc0Nm11YjI4aHVBdTlwMFNv?=
 =?utf-8?B?NmxZd0M3d0dEVVRnS21HcGFjUk5wMEkvSjRXNCtsU0p5a1A4SXgvdDFEN2Vo?=
 =?utf-8?B?WG5PQnJtTW52YVk1c0M2c2ZWSm5DeEdId3F0ODY3K0czTkFOSDFiQlRrWmti?=
 =?utf-8?B?MWltc1BSTkxDRFozWXNvOENJY2hPYWVkSWk0cFVzdmk1elBKTVJ0bUN3Vmta?=
 =?utf-8?B?QXRRWFl6Yk1hNlFGREh4Tm5XNSsvbllDckNqeVJqK1RWeUhOanM2ZS96b0dS?=
 =?utf-8?B?c0JrQ3o4UEtlaU5TN3Vad1FnSDVNVjY1Zmt5K1BpSjJTZEoxRURQWTV1bm9F?=
 =?utf-8?B?SFcxeThlb1E5SzJxYjh4RGkyYmpodDJtVjd2TytXbHdtS2o5WWt5SC84RXB1?=
 =?utf-8?B?Vk0rc01NMktyVXlOditNUk1qdDJtYXdsbVpNOVRUUnJpYzFkUmNKdjdYL200?=
 =?utf-8?B?OEFkaUR2bG8vQ0pzQldtSnFkaGJ0S1NGY0tpSHA1c0NvNU1wNGwybzJKWmJK?=
 =?utf-8?B?TGI1ZUMvVWJNN0loWXhaMzZZbE9pV1NVbHovZzhVbDhTblZGVFFxeGpJb09I?=
 =?utf-8?B?MG12cTdDUTNPSEZYeUQ3YTZKNGJpZUh4eG5NWmxiWDQzdm9CNmkzV3Z2a0JQ?=
 =?utf-8?B?aFEyVDJMbXMrY2VmZXhJZFl1Zk5PVjU0eTdDdWp6UFlmTFNDVnY3Sy9FSyt4?=
 =?utf-8?B?emJjM1lkQWJrdU1jRENCYUdYMlI2cm5HZzBEQjNPRFdFbHhBNUVPMXgzSSs3?=
 =?utf-8?B?Tjk0T2FKZFBwa1ptYi8zLzZBZHpxSm5KNVl2ZXVXcVFPNHVSWCtUZHdlQVpD?=
 =?utf-8?B?RzFnUGdGYzlTS20xa21FZXljQmRBc0g0UVFGOHV4Q1FJYjRIa0V5RlJWZGYy?=
 =?utf-8?B?czR6TXovbGM3UDlXT0VKV0lXdnczWjZjWDdFQnlMVE9hUVdlbmF4WWJmR280?=
 =?utf-8?B?Sm1ueUhjY3dDNmlNSG9PWUtqMGxDRkJCSlV2VVE4UjFqU2hYT1dSaG91eGFY?=
 =?utf-8?B?RzRMMnlEakdlcDNaZzE2ZGZtNXpWWFZGYzM4cVhVaWlRWGN0WE9ENG5JbXdq?=
 =?utf-8?B?enpOdWl6Nmc3NGEvcW12TmkrZUNVcHNJeitFSnZSMGovZkpVUUVDRUFtbFp1?=
 =?utf-8?B?ODdLU1hSdVVMOHJ4ZDF5NUFySzE1cG9jMit2ZVkwSkc2MVVwNi9qTHlaZnBu?=
 =?utf-8?B?OU44S0xqWjVSWGQ1OUVEaHh5SU9yYlVaWnhBK2pLVmduUHlxN0tmdCtKVzEv?=
 =?utf-8?B?UWhBM2lBQSs2ZGNZSG9Uc2p2K2JPZi9ib001T1U1bldHRGZTNzdPcGRnYnkx?=
 =?utf-8?B?OVBmNEw5YjNjVnlJMUl0UnMwYy9IS1RJeVdUcEptWVJYblljL1VObmgrcHdN?=
 =?utf-8?B?VzNmSTFNV0NSRERqZ00xUEpaTjRjelZMTG4wNVlnVUNmTlZ1L01CTmp2a2hM?=
 =?utf-8?B?N000MDlFVzM3dG1BU3hMQUFPbFBHeWxVeFl1ODl5NmwxZEwrU3U5dnpuK2Za?=
 =?utf-8?B?MzhSRzFKNFZNK0xzY1dkM2NidFNKaE5vS1NtRE5rTVFGMDRmMElmQTk4R3dy?=
 =?utf-8?B?K0hmZ2JxVkFOWFJUMHg4aDM4YmR1cFQ0b2dTaTVUdXVqZm5sQkl5U3JJZVpw?=
 =?utf-8?B?ajA2Y2ZBVm9oZ1l0a2UrUUtzRzJQNEh1OTRZenMvcC9ESXg3b1V6NUdnSzBT?=
 =?utf-8?B?T2ZBT21JKzJ5MjBTMEQycnU0b2FWZ1hFTkp3Q05uakp3bEJPdGt0NG54amdm?=
 =?utf-8?B?UkFCMmpucXdiMHBiQ3duNWFCcklFOC85TDZ0TTF1cDgzV3RHYjVzZlEwRDB4?=
 =?utf-8?B?c3hZRVdTTnZuOC9LRmt1NWwxQ3JCeUlFWnRjaHhVUnF5bmg1UWc4bG0waFJp?=
 =?utf-8?B?UW40STcyc0Z4ZlJ2c09NbDQvMkJSTHlNd0g4M1JmZGh3ZEovMkpKWmc1ZWZ6?=
 =?utf-8?B?cmg0anZJODVqSW1iQkpYQUlqNlpTd0J4NXBSZWI3K0t6R3VuZGU5NTJackMr?=
 =?utf-8?Q?xyOFzXzcLictkyGs3djwyqye5?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e976503-4a7a-4807-364b-08dd5853ff98
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7420.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2025 23:59:55.2123
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WAO9Ct6EowGhLjX1iLYCaD+dy1s5C5UjZ5N25ECc6sqFBDpxPGx//PZdHdE0+rajxKRtf5xHg+2w/08kYAapfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5207
X-OriginatorOrg: intel.com



On 2025-02-28 3:40 p.m., Jakub Kicinski wrote:
> On Thu, 27 Feb 2025 13:16:09 -0800 Tony Nguyen wrote:
>> IDPF deinits all interrupts in idpf_vport_intr_deinit() by first disabling
>> the interrupt registers in idpf_vport_intr_dis_irq_all(), then later on frees
>> the irqs in idpf_vport_intr_rel_irq().
>>
>> Prevent any races by waiting for pending IRQ handler after it is disabled.
>> This will ensure the IRQ is cleanly freed afterwards.
> 
> You need to explain what is racing with what. Most drivers are fine
> with just ordering the teardown carefully. What is racing with the IRQ,
> and why can idpf_vport_intr_dis_irq_all() not be moved after that thing
> is disabled.

Most drivers call synchronize_irq() in the same order as this patch, for ex:
bnxt_disable_int_sync()
iavf_irq_disable()
ice_vsi_dis_irq()


The order is:
1 - disable IRQ registers
2 - synchronize_irq()     <-- currently missed in IDPF
3 - delete napis
4 - free IRQs

May be "races" is the wrong word, I will try to re-word.

