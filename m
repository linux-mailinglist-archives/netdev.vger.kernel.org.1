Return-Path: <netdev+bounces-242544-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id ABD58C91E87
	for <lists+netdev@lfdr.de>; Fri, 28 Nov 2025 12:58:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BB4C44E4B57
	for <lists+netdev@lfdr.de>; Fri, 28 Nov 2025 11:58:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE59732E149;
	Fri, 28 Nov 2025 11:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="C1vmRzFw"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED19C32D7C8;
	Fri, 28 Nov 2025 11:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764330970; cv=fail; b=M2GZuD94jIYTLbsorRVLoglxW9l6gep/Ub6TRsFGOjKEnhKostTdppK/H4O8tv4zEX7zWIQMrR42sUSsHRl5raM2HFqL4Woma+9xn5Mbv7LF3SivvlRzgjjryXFlNdgyHBf1APk0oX7yEmUXABZxleoE0a5h3rTwn5OZJ9xP0Rc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764330970; c=relaxed/simple;
	bh=GR004Lt7rpyObnQPwxFUJZ5ldHZ09e3vXFPO/zlXokI=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=hIyI2JNtICcSdH09oJs6uEz+1fu1CUglVSZD8LqBC47bGyC0MeDPuI6hRKiW6lUYdN4zvcLAYIPTOu+XD4jU0g8L/PlcMg8Cs4nUbSvi4j9Mtkykt6t7E70oq95yA95Sny2zQNbuftuKmWikZchwxFKlc43Lj7M6tFv1TPIpNOk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=C1vmRzFw; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764330969; x=1795866969;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=GR004Lt7rpyObnQPwxFUJZ5ldHZ09e3vXFPO/zlXokI=;
  b=C1vmRzFwKVxcyw3JTaf9aEglDayBLkDAeimsi0WxxdB+AZ6IlwHL4ppK
   hfzVSpalfpkWztF4kWFTh7ihrMhPmmK5xLiFVTS8DN4Sur8UjPCIoxb6i
   9n/LK+n09Di4TfTSSgmXOJGHnnkfvdCtwnozW9VdG8DDYsgoHOcsyAJvP
   zzrhPzwrhY31wtQva88r9EzBl9LZBrFfPib9YYb3hy6izJhj2Vt8F47O5
   5pLq5JRK9oegp7urFK9WR3ZLiqc+0rTIVcQI15eytJInh5PGxqLEt2YgA
   pK6gsCy7EKW+F1f+bKolZotg1sTw26/7J76ZUFe99DNJZalXKVW0ztAKS
   w==;
X-CSE-ConnectionGUID: Hi25+CAISbaRagisHOi09g==
X-CSE-MsgGUID: 7yYTPSVhRji1kWKLq8+KcA==
X-IronPort-AV: E=McAfee;i="6800,10657,11626"; a="66437545"
X-IronPort-AV: E=Sophos;i="6.20,232,1758610800"; 
   d="scan'208";a="66437545"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2025 03:56:07 -0800
X-CSE-ConnectionGUID: vvYPpQViSLq3ImJACm7/Hg==
X-CSE-MsgGUID: VDKU8e7mRX6Hlbo/0jkHAQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,232,1758610800"; 
   d="scan'208";a="197786718"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2025 03:56:07 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Fri, 28 Nov 2025 03:56:06 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Fri, 28 Nov 2025 03:56:06 -0800
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.38) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Fri, 28 Nov 2025 03:56:06 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r0zs+W4rSVc/UUrqworfWwEkDAzVYrL073aXrjFve3vdyo4BMKD4RyKi85zjrUSx0rx++7uLI98/1CETJfn9Ih+vwtDgwQa8VLcfXy08nYrzDJ6Y+mctOGrF0UotOTKoy2h1oEhdKc/fW+DYlfOi8M9IwHacjrxIeHOaxt9rXhn4qSy+Smoe6Nu1PSn/c9SvnIcQfKNqZ+o5i6ZCWF/EClDez9MC+JWSy/p7V8W0LS0RTD4R2ZjhkL4aAe1PnomwAIOCF+EBNiAQ/b0ZGXksO2DSeHf74oGInyhnyg6engFVjkggqG+/u+oOj0dKLxvXs4WY4DsRYymNnmbQA0bylw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4ig7IWV53Hk71np0+AAnVCvqbRfO+ftFtv+0AyWL5Q4=;
 b=s8BdwPEf4R1VLqtQFFyCCjPLDZ749XE/MZb1Vq1NsevmmWusEBhwMsuk5wOEdd60cO+j5pwnxgoyNtZ4wANK6ljpqczTeQ31cH2sOYhRjPV6mJeW+8zF1dSjWZ5BbmzjSaBv7SZKNTLjWw0twND/zxbtGbpShLiAnJRinMI03s7nUC5sA0sMtMNSRzyQBKHh2prm5/wC65wEaegnhUhAl2eGOtPfjX9QHgZLbVivMUmM9pzrCrimckJlH2j1PhiVxCnNbVYYBQKOOwssxPhSHLAPclcLBp7NyhPMPnR/v8S8o+EpglJ+l+INqudBVEK3Ne1/sBf5oe5u2J2suQQGug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CYYPR11MB8308.namprd11.prod.outlook.com (2603:10b6:930:b9::19)
 by DS0PR11MB7482.namprd11.prod.outlook.com (2603:10b6:8:14a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Fri, 28 Nov
 2025 11:56:04 +0000
Received: from CYYPR11MB8308.namprd11.prod.outlook.com
 ([fe80::68e1:d6c5:d11d:4858]) by CYYPR11MB8308.namprd11.prod.outlook.com
 ([fe80::68e1:d6c5:d11d:4858%7]) with mapi id 15.20.9366.012; Fri, 28 Nov 2025
 11:56:04 +0000
Message-ID: <32fd9c75-e133-4f53-b839-101a579fd79f@intel.com>
Date: Fri, 28 Nov 2025 12:55:58 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-next v2 4/8] ice: allow overriding lan_en, lb_en in
 switch
To: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "michal.swiatkowski@linux.intel.com"
	<michal.swiatkowski@linux.intel.com>
References: <20251125083456.28822-1-jakub.slepecki@intel.com>
 <20251125083456.28822-5-jakub.slepecki@intel.com>
 <IA3PR11MB8986E6C10E42C5DD6DC717B9E5D1A@IA3PR11MB8986.namprd11.prod.outlook.com>
Content-Language: en-US
From: Jakub Slepecki <jakub.slepecki@intel.com>
Organization: Intel Technology Poland sp. z o.o. - ul. Slowackiego 173, 80-298
 Gdansk - KRS 101882 - NIP 957-07-52-316
In-Reply-To: <IA3PR11MB8986E6C10E42C5DD6DC717B9E5D1A@IA3PR11MB8986.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR0102CA0034.eurprd01.prod.exchangelabs.com
 (2603:10a6:802::47) To CYYPR11MB8308.namprd11.prod.outlook.com
 (2603:10b6:930:b9::19)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYYPR11MB8308:EE_|DS0PR11MB7482:EE_
X-MS-Office365-Filtering-Correlation-Id: e6d69e35-5473-4fe9-e16e-08de2e751b87
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?T3dncmc3bE1yRnlhVkFOcG5zM3R6MzgvUXBkelNUZG9icUM5ZlpJN09mV2tN?=
 =?utf-8?B?akNhMTE1d3ZxZk04QkF2dUFNTzFnaDRCZmJGSlZWa2hDWjFob21lWWJiY0tZ?=
 =?utf-8?B?TGMxbUdQblhRbGtnNzM4b1ZiRUZuN1pZUXZ2LzhBdFZLV2UxOU1aWnlRTkNt?=
 =?utf-8?B?RW5TNGZXNHJVcjA3TXVod2s3ZTc3OEZRZVZaaU5SVXVRYWtieW5HRkZHRWtK?=
 =?utf-8?B?NzFTcC9WYWVMb3FncFlEOXkrNGtCdWcwR0UrMWRpODVLMjhudEE5R0pEelZM?=
 =?utf-8?B?U1AyOVBpdm5mZ1hEKzBoTGtnWDRZTVE3T0tCZnd6cEZiY3RsbzcraGExR1pS?=
 =?utf-8?B?SzR2Q1Z5SGF5TkNVNWh4N2lCMTZ2Rjk5Vms5Ty9pNFJ5c2xEWmViN3grTTZv?=
 =?utf-8?B?V05BT015ZGEyVXBVRUxIWWY2MmlSejhoUWhyUkIzR3AwY2h5dkhjenhQc0dv?=
 =?utf-8?B?MzRBdjAwdTIxTHVYNjB5RzJVMGE0OFJQSWFoTloyMXViVjhTOUF1WVl1c3VB?=
 =?utf-8?B?bXlXeXRFNERUQzVCcmxnSWtYQ3MyZDhCWU83aUNhTmhMYkNPbGZrcnp4MmRV?=
 =?utf-8?B?NHo3WDdWYWFlWjVKR3lyU1JQRll2bjd1c2lRRmF3SHU0VVhuaGhBQ1p0M1l2?=
 =?utf-8?B?aWZiSFFVMFZPeUR5NzRJU2NjN0Q2STcxR0NaN2xGMkNublNaZ25PUUFCVUJk?=
 =?utf-8?B?UEN4UE11ZUpMN3I0K0ZhNmM1Rmc1eGlVSHhxYWx0anBrRFRodnA1NFdZZVJ0?=
 =?utf-8?B?Q0VBaGZ3Q0wyQjJRZmpCMmd1UDVzWk5UWUo1U0xJNG1QanhDYTNVZTQ4WDIy?=
 =?utf-8?B?dW94a2tGeGtQaDRnRm0vUlJDaiszZUtJdE1YMGdqTEUrZEZpc01hWnk3U2F2?=
 =?utf-8?B?OGJrc2xjcVNrOFJsanZZRjkzdWZpa1JaRDU0YUc1a0xDaHFWcWtLRFJLQ3pN?=
 =?utf-8?B?ekdtQU1pZDNlV2xHQmtuTkU1NW4vdU1lNngrTzNsLzFqbjVFQlowNlBwMVhp?=
 =?utf-8?B?WXl4VE9GenZPeHdEOXE1a0V0Smpqc3N5L3BHWTlnUEJVdklCbENlNkxEeFla?=
 =?utf-8?B?bGtOMit5OGRDUjVrZXhXNE0wcHQ0aVlzb080cCtMT0ptUWZsUHJrV25VU2VK?=
 =?utf-8?B?NDBCMTV0ZHpRTk1ITU9LU2tNa2dGRTBUdTZ5WW9yeEJwcnRoaW4vcDVRL2JV?=
 =?utf-8?B?RlhPMjZYdDdCT1F0SkJoVTg2cGRsQTN2eE9PTmlheWdhNytZT24rb0EzM1Ri?=
 =?utf-8?B?TncrVFlwcEhBS0FzVkN4UnpPU0ZmdDhKaE9iZjRjR1ZZSmZyTlMrVUVQRDhR?=
 =?utf-8?B?QzF0em9oWTYzTDg2ZGNzZkZUVVU2Q2dFdjRKZHo3bTVFU0w2dUhwZ3dBbkt1?=
 =?utf-8?B?TkRLdjdNUnU2VzFjL0dod0xubUN3RkVXNWNHRHpZa0NhNXcxV0ZmS2gzTXhw?=
 =?utf-8?B?Z0YyUXRXR0ZRMzEwSnRHOXlMbTB6WXV0eG9yODB2bS9Ca09PVU83M0haajJ3?=
 =?utf-8?B?WlVpclFtc3ZDVEpoVkNyS1FkeE96NmRiVkFpN2w3cjNGVXVFWitjTWdoczZw?=
 =?utf-8?B?YTEyazU3bWl4YTA4eWVXTlBWdHVZeGYwMGdzVjZSNC9kK0JiN21CSE5SS2M1?=
 =?utf-8?B?RFZ5SXRTZHlxd0lYcmhOVEVnNkFhRGlIWlVRUEFqUUxFY0VXQ2tjb0Fxd0Vj?=
 =?utf-8?B?UDBjV0hXVTlueWRvbFVnVWdJNkJGK3RpTWFsME5RSmVHS3A3RVNLUFN1dndi?=
 =?utf-8?B?ZlpVdmdwS2I0azZOQmJaQU5zVjRaZjNGZk9janhKSU00Wk5OdVZ5dm8xVFQz?=
 =?utf-8?B?TDdESktNcmNPTjNxT3FhZWtCaWdYYml6cVA4YnQ3ekN4bkllMnF0MTZwOGdV?=
 =?utf-8?B?WGRhVVB5aktSY25xVkFZa1ZtVktjdmRCclJsUk5wSlRBempYTnV3enVmeVZp?=
 =?utf-8?Q?km1WB+zxZ5J2jM70UCy+v7XLfgDpUztA?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR11MB8308.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RUVNTUhjejNzOGRqMGEzYmY3MW54NFR3Z3VTdDY0SEVaYmFjeDhBYXl6bVRK?=
 =?utf-8?B?VzhHc0hoNnZwalAzckJaYkFXZS83Qlp3ZW9jRzRCMlprcEZHdHkrK3lQVzIr?=
 =?utf-8?B?bE5jKzZZL1krVWQ4U2h2bzhpRGd0d3BsSVowaU9wWmNsaUY0K1NGY2QyS3Zh?=
 =?utf-8?B?b2YzV216azcvRHpxUnd4MkN2NC81YXEzZXVyT3hwZEVTMXVrL3hrSVIrV2po?=
 =?utf-8?B?b2RnUDdTc1RqbmNqYkhyVDYwZ0V0V3MzOTZnVzlScndQNXJGZGxSY0U1d1N1?=
 =?utf-8?B?YWRUUnAzZGw0T0VHTUVoVDN1NkNIeVByZUJCRjZpSlozcG5jVnowOTJMcU05?=
 =?utf-8?B?QVRzakVEVkE1bzc4QnZYSytSQzhmUWZweTQ1NjYyRmpXOENadVNGenVHU2pE?=
 =?utf-8?B?Z3VoUzFOdGR2alpJbElCQVZTWXlPbm9VTFdNZ0xiRWRJRk9FZVZVeGZubzc4?=
 =?utf-8?B?U2taenYzcXhqdnVLTWZWdjRHMHJiQXB2RTBmYkVtbk9lUmtmbUpQMnpMQnB5?=
 =?utf-8?B?WnZZTWE2aGhoSStBYmJPYlp3UTVLd0FaSlljWW1Sem9KQTVHeC9mK3ZZdDQ5?=
 =?utf-8?B?VnAwdkIwaWZIS3FDdUJCT3FEWGZFTGlkazNHYS9BMS9ENG4rcWJhMWg1S1Fl?=
 =?utf-8?B?cHpjZzZMSVRtR0JzK3RqbXRQcFczUGxMVlY1TXhtcmxHWks4WW0zd0Y5dVRW?=
 =?utf-8?B?K2hUQVdnVWZpam9ZRUx4MTlVYmxJMXNWZ2hTSG9IeVF3S21GNUJaSnlQWlUr?=
 =?utf-8?B?MFhFYXVWTGJqRUNyc2t1VUM5emtJUlp6emgxRFlKcWNGRlEzendXdnJSYUM4?=
 =?utf-8?B?OGtNTzVHL0JORFFvWE9ZbjJDTzVzekhnY2NKOFdFaEx5Z2x4U2pRZzlNclgw?=
 =?utf-8?B?WG95NnpoZDg3MDJFVzA0M3UxaWhTeFFRcEpjTVlsSnd6M0JyQ0ZzL29zVU5X?=
 =?utf-8?B?aTYwRUlyWVRwY1VLSSszVU9KMytaWTRxaHViTldLQVIvWTdkSk50NTg3bUJO?=
 =?utf-8?B?YmFQVW01Q1BGUGV6WTNBcnpZMWN5VzBVZ0tQc0h4a0IvaHlWY3d5NmNUUU1L?=
 =?utf-8?B?ZWJ0cmFYY210ZHFzQXh0c3ZkanVXZTMwWVVjNG82aDF1RG81bHY4R3BIeXBV?=
 =?utf-8?B?K3pWTUIzRjQxTjlQSzJFb2tTOHFZd3NqYXBueDY5L00rVGdEYjdyVi84a3lp?=
 =?utf-8?B?ek5WZnF1SFQzamdEd0xsKzNsSFU4YnNsbkpLVW1BRzg2dWhqckVjV0lMZzFz?=
 =?utf-8?B?OHN1VlVDY3JRck54VTFUbmVrNFpuZ1hialBZS3V3dmNKTm9ob3cxSlBTMFdJ?=
 =?utf-8?B?bFRHQURINjBTa0c5RVRXZG41SnRraSsvTW91NE1UOGJPbmFGVnVZVVhITE81?=
 =?utf-8?B?YVRiVlBoTW5VbG41NExCeU5aLzBjK0ZCVW1oYUdXaVIxN1MwU1hFZkJhNGMr?=
 =?utf-8?B?UFN6OTVoQ0VHbENKT3RYRHRDWG90OFFQblhnSk04M1NFN2xwejAvZmFocUVx?=
 =?utf-8?B?RkxyQlBVQkorYm9paWkxenJWblJOakMxZEF6QmpXclFZdVVTS2haQWtwVDhK?=
 =?utf-8?B?SWJ1WmJWQnVyWjZhNGxhV1k1eW9FVlk3ajhJTTJYQ0U1NWY2YktScHQ1Ky9S?=
 =?utf-8?B?ODlFRVJMUll5ZzZxWnNiMmtGanlSMitlbUtjbU0rdlM3MnBsWHVCSmJ1dEN0?=
 =?utf-8?B?eUdDb0NXUk9GbW9WM1ZBQ1czenpDRGtTc1dybGpWVVNVbjFQSDlFbjBIMENX?=
 =?utf-8?B?bnZ0Z1VoSkZoQVlFalhGUEdFUkQ0eENVNWdId2lxYWxKSHZuckNMY0IzQkJs?=
 =?utf-8?B?dWZKNzVjMm0wM2dzUFlEcnVLZU54Y1NTck1jSXltTVJRL1RmdUJmRDZVTjlV?=
 =?utf-8?B?RG1ZTHd6ZHg3REkrS1d0bytDeWJ5cFlNa1kvSFY3dFg3NFdIMkd1cXVGVUha?=
 =?utf-8?B?QStkM2FoWmpsUDRGWUs3TldLcnhjTG00YitvY3RjdGc3Q2tSY1BmbnI0akw1?=
 =?utf-8?B?R3ErdmZGWTNCZlc3SHNaQk5uZnFnTk5LZ0R6ZmtrTHpsWklQYjBGblFIMG9T?=
 =?utf-8?B?cEgrNllwM3QyelRHN1JDNS96UWlBTUFNUUROUG0vZmtJcEJtS1Y0YkJ5SjVa?=
 =?utf-8?B?dE42QTZOZndWWEVHdDZNZkRhYUV6UUdWWUFjTVJCVDFQS0JOSHJaYlJuRTZy?=
 =?utf-8?B?M0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e6d69e35-5473-4fe9-e16e-08de2e751b87
X-MS-Exchange-CrossTenant-AuthSource: CYYPR11MB8308.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2025 11:56:04.3427
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vhx+dwPDelEqEtDcREnuLLr3t+hkg5bKo/EKh6YHKiiyMruBr6M1zIXW9EBXBPjmFzS1dJA2XZ1cKgn1idNKweQLn/GtHyuSuse1Xh6rzIM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7482
X-OriginatorOrg: intel.com

On 2025-11-25 9:59, Loktionov, Aleksandr wrote:
>>   	if (fi->flag & ICE_FLTR_TX_ONLY)
>> -		fi->lan_en = false;
>> +		lan_en = false;
>> +	if (!FIELD_GET(ICE_FLTR_INFO_LB_LAN_FORCE_M, fi->lb_en))
>> +		FIELD_MODIFY(ICE_FLTR_INFO_LB_LAN_VALUE_M, &fi->lb_en, lb_en);
>> +	if (!FIELD_GET(ICE_FLTR_INFO_LB_LAN_FORCE_M, fi->lan_en))
>> +		FIELD_MODIFY(ICE_FLTR_INFO_LB_LAN_VALUE_M, &fi->lan_en, lan_en);
> fi->lb_en and fi->lan_en are declared as bool in struct ice_fltr_info,
> but you are now treating them as bitfields using FIELD_GET and
> FIELD_MODIFY.

I don't see what you mean here.  Both members are u8 without a bit-field
declaration.  Or do you mean they are used as bool or maybe the _en
suffix?

> I realize it could be something like:
> struct ice_fltr_info {
>      ...
>      u8 lb_lan_flags; /* bitfield: value + force */
>      ...
> };

What I see from this sample is that you want me to: pack them, change
their name, and change their description.  Is this correct?

I fully agree about the description.  It's my mistake I left it as-is.
I'll update it according to the overall changes.

I don't think packing them is worth it.  The memory gain is negligible
and the cost is primarily in readability and consistency: we've always
had two fields for these with clear responsibility for each, names
match with datasheet (both "lan en" and "lb en" will hit Table 7-12.),
and packing them would require twice as many constants.

Would the clarification in the description be enough to address your
concerns?  Something like (please ignore bad line breaks):

struct ice_fltr_info {
	...
	/* Rule creation will populate VALUE bit of these members based on switch
	 * type if their FORCE bit is not set.
	 */
	u8 lb_en;	/* VALUE bit: packet can be looped back */
	u8 lan_en;	/* VALUE bit: packet can be forwarded to uplink */
};

> #define ICE_FLTR_INFO_LB_LAN_VALUE_M    BIT(0)
> #define ICE_FLTR_INFO_LB_LAN_FORCE_M    BIT(1)
> #define ICE_FLTR_INFO_LB_LAN_FORCE_ENABLED \
>      (FIELD_PREP_CONST(ICE_FLTR_INFO_LB_LAN_VALUE_M, 1) | \
>       FIELD_PREP_CONST(ICE_FLTR_INFO_LB_LAN_FORCE_M, 1))
> #define ICE_FLTR_INFO_LB_LAN_FORCE_DISABLED \
>      (FIELD_PREP_CONST(ICE_FLTR_INFO_LB_LAN_FORCE_M, 1))

Does this mean you want me to use {1,0} instead of {true,false}?

In ice_fill_sw_info() I'd prefer to keep them as boolean because they are
semantically correct: we're calculating defaults and then we apply them if
specific values are not forced elsewhere.  Maybe a comment or docs change
would be more in place?  In ICE_FLTR_INFO_LB_LAN_FORCE_{ENABLED,DISABLED},
I used boolean to stay consistent with the ice_fill_sw_info().

But it's not a strong preference.  If it's preferable, I'll change it
to {1,0} across the patch.

Thanks!

