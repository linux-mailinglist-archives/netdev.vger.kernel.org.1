Return-Path: <netdev+bounces-181307-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16C7DA845AF
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 16:08:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6B1D8A8412
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 14:05:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5ADC28A401;
	Thu, 10 Apr 2025 14:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="n6bfXpkY"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3D70285402;
	Thu, 10 Apr 2025 14:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744293918; cv=fail; b=JFxIGP1rtlcs33qGNx/qS1S6q0LZdKTk3obAeCij4AiXu+4SDfYEjQBml8nrP4VGt8NCIMVUyFUnta325bSs8qA4zdR1JWPk8gGAAwW8lwedA36WZ5vEPJrlmF5bES0Lg3LONCZUqQrpw+2uz3uXThwu1e/EdbTpeuRxVoc11IQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744293918; c=relaxed/simple;
	bh=VWLyxtno+kkRplpGVfHeI9MnhjXSxHSKa6O1dwxYAug=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=oD+KUjkFdnF8WDKMKqh6/+PEo6zz2wumTty6xc1VvolRP2zwYXe00lRTS6LUmDXGf/Ye6dUTzgTJVKR5hbVTSIglZjWogxxPcUrY+6pxAA7HULWggeWxOGxu7XbCrKNP14Wb2PJ5CeTE22s3Jk14fFWBoVVPd7Enr6yJGqWYKYI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=n6bfXpkY; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744293917; x=1775829917;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=VWLyxtno+kkRplpGVfHeI9MnhjXSxHSKa6O1dwxYAug=;
  b=n6bfXpkYUG74eiBoJGRRxgmSt3JyV9B12dCjrmyWHrLuqRBinQRiBC5O
   533bagwSSxINVl3L84mIcR4q0Xj4WwJZpCId0QQ0OjlPVILQjmCvIJXJs
   VqvWWglGr1vVXWUX6+R560zJPAmN1PNuEK90H7teuERx8T/EcH97812En
   OaKPZvhVMv9/caKiL6kVKJiu5RqvNAoNNFVzA5K0x+BAzvXYZ10nUCwvt
   FIQcsdY7rcQeTmr1HcAvBq170SB4qUFT83eoKenczuQZpSFgyCotVd1jO
   aKNpNYFNDfu7R7ctqZaP9IZKKy7zCaTaqyEj04DXeUgrSzH4eZUOvdMNN
   Q==;
X-CSE-ConnectionGUID: 2201B9qoRlGFOynhAWDYbQ==
X-CSE-MsgGUID: Bt0E355/RO6skmhGCvaZZw==
X-IronPort-AV: E=McAfee;i="6700,10204,11400"; a="56453017"
X-IronPort-AV: E=Sophos;i="6.15,202,1739865600"; 
   d="scan'208";a="56453017"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2025 07:05:13 -0700
X-CSE-ConnectionGUID: PPDbzH4WS2qw2PFREn3gmQ==
X-CSE-MsgGUID: nUe/CgKATCqYBacsua/jiQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,202,1739865600"; 
   d="scan'208";a="134030600"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2025 07:05:12 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 10 Apr 2025 07:05:12 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 10 Apr 2025 07:05:12 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.46) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 10 Apr 2025 07:05:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VYTUPmBTBZiuPpojiFBw0Rh+DnBVZ36yP0Ajd5dkBnxMuBzJ+/ZHWUljJJ9y1RYdaTp7Au8+3c4lCreoEC/3wbjbjhg5U8Wjfg+UZBZjnnN2F7SkmHcgg5BX9QMZBxrURNkDORVyyKLF8ByMgzcdbNZxs7DtUq/GbuecWJxJ93zspaj0d6pe9aM8uLM1zJyvTitaLjJcs9gLtr4KVyc1Wc9IbBzNcDUjKIe+LHhfjblw1JawIUVUG1AuFjOo98SI2ogkAfsQUNFmx/M0pUXpNsBwoR1mkOtvj9BLv5APl7NpueGn+o+KQDQLiWwO49Re+dwPigxnPVKBT16lGDQDfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1W4O6qaRAO8VFdvxqqP4B50f3vJZi6LhTf++BTFweBE=;
 b=h4VgV+ExaO4QwCqUSAojVxKNdyoD/mU/CXUAXMGcHZbIjzQH4s0x8LAgwayDpXSnoHNcOWpuvCxxdkpvB8ug552FIKOd1R42WBgar4dZ4ymHGzap64eZOO/Wp/28X3yj5OXNBY5NAqRaYxgaSNjSsHXZqaSDe7cle5Nwerys/kN2fgFv0D3UNWXl6Qgv6nX+GW9PLVKilIQfpricvEPRpWKGkfT6HwcPJjeLtCalaJsf5tOcJjXT0EN13bKTKYBB3BYJS6vhmEdtdHVkBZuo3xFzTYGrwtjX/BWMSB92Tz8KiWOXeBRv18hDQfOhn5h1+GvuZqCZe1h9292+zv5zwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by DS0PR11MB7286.namprd11.prod.outlook.com (2603:10b6:8:13c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.22; Thu, 10 Apr
 2025 14:04:25 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808%5]) with mapi id 15.20.8632.017; Thu, 10 Apr 2025
 14:04:24 +0000
Message-ID: <7bf3d0e4-1c76-4170-a417-51c9286385a9@intel.com>
Date: Thu, 10 Apr 2025 16:04:14 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-next 05/14] libeth: add control queue support
To: Leon Romanovsky <leon@kernel.org>
CC: Larysa Zaremba <larysa.zaremba@intel.com>,
	<intel-wired-lan@lists.osuosl.org>, Tony Nguyen <anthony.l.nguyen@intel.com>,
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Simon
 Horman" <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Przemek Kitszel
	<przemyslaw.kitszel@intel.com>, Jiri Pirko <jiri@resnulli.us>, "Tatyana
 Nikolova" <tatyana.e.nikolova@intel.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, Michael Ellerman <mpe@ellerman.id.au>, Maciej
 Fijalkowski <maciej.fijalkowski@intel.com>, Lee Trager <lee@trager.us>,
	"Madhavan Srinivasan" <maddy@linux.ibm.com>, Sridhar Samudrala
	<sridhar.samudrala@intel.com>, Jacob Keller <jacob.e.keller@intel.com>,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>, Mateusz Polchlopek
	<mateusz.polchlopek@intel.com>, Ahmed Zaki <ahmed.zaki@intel.com>,
	<netdev@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, "Karlsson, Magnus"
	<magnus.karlsson@intel.com>, Emil Tantilov <emil.s.tantilov@intel.com>,
	"Madhu Chittim" <madhu.chittim@intel.com>, Josh Hay <joshua.a.hay@intel.com>,
	"Milena Olech" <milena.olech@intel.com>, <pavan.kumar.linga@intel.com>,
	"Singhai, Anjali" <anjali.singhai@intel.com>, Phani R Burra
	<phani.r.burra@intel.com>
References: <20250408124816.11584-1-larysa.zaremba@intel.com>
 <20250408124816.11584-6-larysa.zaremba@intel.com>
 <20250410082137.GO199604@unreal>
 <Z_ehEXmlEBREQWQM@soc-5CG4396X81.clients.intel.com>
 <20250410112349.GP199604@unreal>
 <Z_fAdLJ4quuP2lip@soc-5CG4396X81.clients.intel.com>
 <20250410132706.GR199604@unreal>
 <7e3f2eb8-b668-4ac5-8b49-43eebff2b3e0@intel.com>
 <20250410135843.GV199604@unreal>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <20250410135843.GV199604@unreal>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ZR2P278CA0034.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:47::15) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|DS0PR11MB7286:EE_
X-MS-Office365-Filtering-Correlation-Id: b443020a-2638-4bdf-8d16-08dd78389905
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RTNnVDBXSCt6eXFOU3JXNW15VU5sRWV3K1EweVpSWi9peFVnQlNPYzdYZko5?=
 =?utf-8?B?c0FEaWhLS25JbkdnZytBM01uNmZXK2FwWG1MTDd4UWZyaTh2WVdxcyszQ0hQ?=
 =?utf-8?B?OG9kOC9pK0t1a096NzJSRmsyRmg0b0ZqT1ZoVlRNVU45ZDJqeTRHQ2crZmZY?=
 =?utf-8?B?MU45dHFUMk9xelhTcUZTSVQ5WmIwWEdmcmxXbitycFdZdW9VYWs5dXFENUtN?=
 =?utf-8?B?aGxGU3dkanNtazFaT2NUdTJlNmZYK0RRbkVNcWVxT0MxMFhRQUJRdTh3T3hF?=
 =?utf-8?B?Rzd2TWx1aUZHY0RHK05GcVhzcVg4UVZOK25wWkpEL3g1em84U2JCOVlvVDRx?=
 =?utf-8?B?UitFbFNxRG55WTR2VXlzY1lkZE9EWWI1Uk8rVXIyd0lscTVES3VaOHZReFA4?=
 =?utf-8?B?bGtCNElZcHp0QVQrbE5VVTcySi9Yc2cyMFpraVJXS2VDcnpsbkN5Y1FHakVZ?=
 =?utf-8?B?QlU0ZmswZVNyd0VXTVB2ZVRDaFR2c3dralRGRVRiYldmQTdFZm5PYVZsaGkw?=
 =?utf-8?B?aW01R3pEUWgvMFc0c280alMzNktCZnRhT1A1d0FZMktER3A0S21ibS9PaTho?=
 =?utf-8?B?Y2VQK3QzS3JaNUJINWZmanMwWmRYbmZhaGFtTFVIZTFHTDhHZnVyeTkzTFhT?=
 =?utf-8?B?QS8rZ2liY210SmpUa1RIT3BTbm9aWktqRU9LcDVGWDdnSjMzMk1CSHJBWW50?=
 =?utf-8?B?aHoyQnV1cnAwK2o0OGxSUkQ1dmE1aXpmQkJlaDNCQ2VZWUFUTWI4M29WbU92?=
 =?utf-8?B?ekZwNFR5NEZPSG1ZVEFTVUIvbHJIVUtoR2VyVkdEUmxjd2dNYVZ6SEJJdU9S?=
 =?utf-8?B?aEQ0d1Z6NUdUMnE2M1hIRWRmTXgyVnRoZmVJZngyc1k5M3ZWQmNBbnN4NmVx?=
 =?utf-8?B?MGxTSEE4Skhha3BFeldHYUdSSE0yMWVhbHJZRXRTYUZMYXhnNjBWN0lZT2FM?=
 =?utf-8?B?eHpocFhOSFB0M05ZTTBlL3BTVm1DSkFkL2JGMkZqd1paOVdhQ09KSExEaXZ3?=
 =?utf-8?B?UExYTWJjdmhrQ1VHZU1rQXc2aVRIbnI5eTAwRzg3eGlGKzV2WHNwb2JrQktl?=
 =?utf-8?B?blpPQVV0VjI1T2VObTZ6ZC85eGVXdGJmTnN3clhqTThZbG1iU3ErWEo3bEYv?=
 =?utf-8?B?Q3RLVGJPbWNpRjVXWWxGMnpJY1ppYnJyanZmYjAvZ2RzNEJkMjd0dVZaR21w?=
 =?utf-8?B?UWxJUGxwdkM4VzlnQXU1ZGV3NEhyNG1Ma3Bqa3N5V3dnQ3J5TXhLaTlETmlq?=
 =?utf-8?B?MkgyNzhLRld2b0RZMmw3M0dreXlpLzRLVmVzWmttbTFRNnFRQTNEeWxMK242?=
 =?utf-8?B?b2VnSC92YS9hakRjSFFWNjJmbERmZ2N4YkUxTEd6M1p3WFBOK1RjYUJNdTcr?=
 =?utf-8?B?OHA1RUhVMWxHMnh3emRZN0ZWM2FJK1ZhNUdpT2ljVGdYdXdjdjJvRkhGdW9r?=
 =?utf-8?B?OW1CM0JsN1J2N004bXNmTUdPOEYzLzBOTEZrOEZhWmRwTk9CcmVHVzVZcW05?=
 =?utf-8?B?S1pPRHhRMzFSNlNGVzdhSElub2hwUlZabHlTR3VCS29LR1h2dGpmdHR4UmQr?=
 =?utf-8?B?UnFqWlFRc2UzY3FiR2tQQ1M4Rit4dUxzOTR4V3NLMmNySkovNlNKcHZWbEYv?=
 =?utf-8?B?aERUbFJsSm9wNnBoaWVBR0YyVlU0S3E2Nm9mT0o2WHdBdmRtTmN6STBRR3hX?=
 =?utf-8?B?dmlLdWhCL01DV2JvUEJVMFlmZU9qQ1JyNHdHb0xkRUF1R3JSNUZscUFsVkk0?=
 =?utf-8?B?MGpNSlRJbmlOSEFQOTEvaDVvRGZtcUhsempMakVmUVpaRWIwSkg0d3g4dmpT?=
 =?utf-8?Q?FNi3CpLzlQpRn5RT49xw5+Ysj/2nwd7pHq/EQ=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WHlTd0ZLc2tUdXdMV0xOWEFGSk9KNlF1OWlkc3l2MU8wM21tUGNnTFRVT0RY?=
 =?utf-8?B?TnhjaGpEbSt6NlRIODZIMlRIc2RmUk9xaVllWW9lbWhLbjVwQ21HMVRhRWpO?=
 =?utf-8?B?NW9GbFV3SGJ1SUxkWXVzSjhkRFJzcEZPQVNFWnVDZ2lnY1FhR3pzeDZUWnla?=
 =?utf-8?B?WjE1T2JNSWpvaEV4alBsUVhBKzRvTCs2U3g3cDNZdldQMHpaZUZZZk8rV3Vx?=
 =?utf-8?B?T2czalN6ZmZNN0NzWXlmREVMZGd3NzY1dEE2Yll0VStiRC9qVTczYzl1alZi?=
 =?utf-8?B?Y2tHMnV2WWZFa2xyMjFkTmJ4S005eWcwczlYRFhhM1YxQlREY1RXZ2hmWUE5?=
 =?utf-8?B?UGlMVVoxUjNsQnBmMTR2ZUV6WXhLZThNS0JVL2l1bC9lTk5aTEVZVmxiUGRE?=
 =?utf-8?B?V1YrYXlLL3FTQ1dPYWM1Z2paZU1OdXo1VHNBOW9kV3J1TGQxbGU5N2ZRSXhv?=
 =?utf-8?B?NUg0Wkd1amduVVdVQ2ZkcldoWDZvaVoxNkFRUDV1TWxGY3l0VmE1dE9qM25K?=
 =?utf-8?B?QU9iK1R5NGlRWkxuOFc0RGxtcDJLSDhvY2htc0RJTmtyMzBhR3BTaWExYUhC?=
 =?utf-8?B?amtKeHVaVEFiREgyWTNFTExYK1g5OVZsdHlmMUJrd1JvQ0ZkTlBVWTk5YUJH?=
 =?utf-8?B?QWxRcHk3RFlWa2JCeGo0czJsOGxqb2lWYnhiY1pHNGRIbENiek04dUhWRkdj?=
 =?utf-8?B?TWJGYSsxVEtvSmF4YTBDVDl5OUU0Q3hFSFlET3IwWElCQkdXdFp4aEdYWWtB?=
 =?utf-8?B?dS9YZk5OWDdoQWdDWkpYby9waUZKd1QvWE9VQ2xsYkpXOE84UTlaS0JRS0Rq?=
 =?utf-8?B?aUVDQnFDS0xFK1pPdmJhN3FGQ2hxRWNHZS9RZHpZK0hDZGZQUHhrcXlZVHh5?=
 =?utf-8?B?anU1RlB3U0FERlVqc3Zwb3RtSWo0eVVjVG5IZGZ6N2tVN3F1c3FGMWRKRTRm?=
 =?utf-8?B?MG5mRGxzeEpJd1VseXZNc09VdWh1SU4ySzJVRkE4QnlVNUdGTVNwd3FHbUZv?=
 =?utf-8?B?TWpJYktXTHpuZktUMG5maXpLbjNMS1kvWlZKMGY1Z3cyK3VITkhpM0xJMUJt?=
 =?utf-8?B?cUNDd3pvUzJrLzhVeENHQTE0b05kekhVMmc3NXVTWWNsOSt0MFVGVXBKVHNj?=
 =?utf-8?B?UXpkYTFOWUdZV1g4TTBpa05YSGdPUG9EQVVNUi9uQWsyUXJJVXl2ZHNySUQ2?=
 =?utf-8?B?eHY1U2YrUWdsY2k0SkptUHlDM01kZjNrQnJrTTFIc2dpSTEvZFh4cjBxVTJn?=
 =?utf-8?B?Z0hma3A2L21CMkRVako1NE5XeEJ2NjBYSVJYSE0weEcyRnVMcmU2SGxJaFJ2?=
 =?utf-8?B?czdGVFJTcm5UcVpiTy9XTjM5UTlNODVCdThBeXk2ZDhHcDdmVFlzaDZGVW0r?=
 =?utf-8?B?NHIreC82R3l5VUtFMERKN1pRZklMbHpDQ2JOdmNlNGRHOTJ2MTJWQUxHTU1S?=
 =?utf-8?B?QVlpUFdkUzBtNUxxWVhKUFlWNm1Eb2ZTVnNOM29XTldSTEVINGxCU3J5d0RJ?=
 =?utf-8?B?QVQ0d2M0ZzVMMXJmS1ZjU09Zd1NOT2w1WFRvWjE1bHZyUFZZSmdxL1RmZmtl?=
 =?utf-8?B?Q051aUlFNGZqalRueFQrSzBoZThRUnNEczlFNnpTbFBXVVovTU5kQmFGczJz?=
 =?utf-8?B?WkVlTjhhRUdxS1dwSlhQQ01lSHJXNEpZd0w3Q3pZUnZHWkkrYjN0OTNiUDF2?=
 =?utf-8?B?QnhFdXhqY2FiQm10REg1UDNGREJNaW1PVTlpMkxxMUM3OURja2hFN3BTOGhV?=
 =?utf-8?B?SU53M21XdXVqZFg4MG83S09NQ0wreGk0VDk3YTIvc3RaOU5wUXdPbUlPMlkw?=
 =?utf-8?B?VFpvaVJFZEVGZTV3KzB4YkV3NzdTRjYyNERaalQrRk5PVXF2dTlFc2VBbEth?=
 =?utf-8?B?S2YvdWUxT3RsckZsdnRUTFRsOGpTRkdsQXI5cys2Z3JmajZsNVZzZ1ZlL1FZ?=
 =?utf-8?B?UlU4djF1bnl4QU9wZFVKL2dDTEtIYmpkWDdBMUdnUlVYSmRBOW5DMlpZaWV2?=
 =?utf-8?B?Z24zdnEyNzg3d1FKRFFCL3JJR0o2RGZ4NmlwNnZJN2dOSjNndTIwa0ErN3dC?=
 =?utf-8?B?SHlWdXB2Q2JaaVhOcXJld1JKcWVGNkhTUWp0RDRwQURsQVJQdStjMXBKM214?=
 =?utf-8?B?S2xZdkcrVFp0cGROVU9XNFdMelhybkpZQmdGdzdnUGxiSjhMZTIrVHRTM2VW?=
 =?utf-8?B?UUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b443020a-2638-4bdf-8d16-08dd78389905
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2025 14:04:24.0601
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zGiwxQrgnwcA7RSAjYrSEbWfOYHwyZdolxxQHqjEJSdt3M9csIiiAM4dNK1zU63gGte1vLUm8ppW+Cem2RK1vBRrD8Rr+Dl0p/rHxN1opcU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7286
X-OriginatorOrg: intel.com

From: Leon Romanovsky <leon@kernel.org>
Date: Thu, 10 Apr 2025 16:58:43 +0300

> On Thu, Apr 10, 2025 at 03:33:40PM +0200, Alexander Lobakin wrote:
>> From: Leon Romanovsky <leon@kernel.org>
>> Date: Thu, 10 Apr 2025 16:27:06 +0300
>>
>>> On Thu, Apr 10, 2025 at 02:58:28PM +0200, Larysa Zaremba wrote:
>>>> On Thu, Apr 10, 2025 at 02:23:49PM +0300, Leon Romanovsky wrote:
>>>>> On Thu, Apr 10, 2025 at 12:44:33PM +0200, Larysa Zaremba wrote:
>>>>>> On Thu, Apr 10, 2025 at 11:21:37AM +0300, Leon Romanovsky wrote:
>>>>>>> On Tue, Apr 08, 2025 at 02:47:51PM +0200, Larysa Zaremba wrote:
>>>>>>>> From: Phani R Burra <phani.r.burra@intel.com>
>>>>>>>>
>>>>>>>> Libeth will now support control queue setup and configuration APIs.
>>>>>>>> These are mainly used for mailbox communication between drivers and
>>>>>>>> control plane.
>>>>>>>>
>>>>>>>> Make use of the page pool support for managing controlq buffers.
>>>>>>>
>>>>>>> <...>
>>>>>>>
>>>>>>>>  libeth-y			:= rx.o
>>>>>>>>  
>>>>>>>> +obj-$(CONFIG_LIBETH_CP)		+= libeth_cp.o
>>>>>>>> +
>>>>>>>> +libeth_cp-y			:= controlq.o
>>>>>>>
>>>>>>> So why did you create separate module for it?
>>>>>>> Now you have pci -> libeth -> libeth_cp -> ixd, with the potential races between ixd and libeth, am I right?
>>>>>>>
>>>>>>
>>>>>> I am not sure what kind of races do you mean, all libeth modules themselves are 
>>>>>> stateless and will stay this way [0], all used data is owned by drivers.
>>>>>
>>>>> Somehow such separation doesn't truly work. There are multiple syzkaller
>>>>> reports per-cycle where module A tries to access module C, which already
>>>>> doesn't exist because it was proxied through module B.
>>>>
>>>> Are there similar reports for libeth and libie modules when iavf is enabled?
>>>
>>> To get such report, syzkaller should run on physical iavf, it looks like it doesn't.
>>> Did I miss it here?
>>> https://syzkaller.appspot.com/upstream/s/net
>>>
>>>> It is basically the same hierarchy. (iavf uses both libeth and libie, libie 
>>>> depends on libeth).
>>>>
>>>> I am just trying to understand, is this a regular situation or did I just mess 
>>>> smth up?
>>>
>>> My review comment was general one. It is almost impossible to review
>>> this newly proposed architecture split for correctness.
>>>
>>>>
>>>>>
>>>>>>
>>>>>> As for the module separation, I think there is no harm in keeping it modular. 
>>>>>
>>>>> Syzkaller reports disagree with you. 
>>>>>
>>>>
>>>> Could you please share them?
>>>
>>> It is not an easy question to answer, because all these reports are complaining
>>> about some wrong locking order or NULL-pointer access. You will never know if
>>> it is because of programming or design error.
>>>
>>> As an approximate example, see commits a27c6f46dcec ("RDMA/bnxt_re: Fix an issue in bnxt_re_async_notifier")
>>> and f0df225d12fc ("RDMA/bnxt_re: Add sanity checks on rdev validity").
>>> At the first glance, they look unrelated to our discussion, however
>>> they can serve as an example or races between deinit/disable paths in
>>> parent module vs. child.
>>
>> Unrelated. At first, you were talking about module dependencies, now
>> you're talking about struct device etc dependencies, which is a
>> completely different thing.
>>
>> As already said, libeth is stateless, so the latter one can't happen.
>> The former one is impossible at all. As long as at least 1 child module
>> is loaded, you can't unload the parent. And load/unload is serialized,
>> see module core code.
> 
> It is not only module load/unload. It is bind/unbind, devlink operations
> e.t.c, everything that can cause to reload driver in module C.

You still mix module deps vs struct device/driver deps.

Atomic modules are not anyhow tied to the latter, esp. given that the
whole libeth is stateless and is just a bunch of helpers.

Thanks,
Olek

