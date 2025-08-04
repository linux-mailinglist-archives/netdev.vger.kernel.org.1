Return-Path: <netdev+bounces-211621-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EE371B1A84F
	for <lists+netdev@lfdr.de>; Mon,  4 Aug 2025 19:04:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14F4C16409D
	for <lists+netdev@lfdr.de>; Mon,  4 Aug 2025 17:04:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A48928AB11;
	Mon,  4 Aug 2025 17:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mWQAKbJI"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77E6E26D4EA
	for <netdev@vger.kernel.org>; Mon,  4 Aug 2025 17:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754327064; cv=fail; b=If2btTSfH0U+C5eB1ptH4BaBb6ErzFt5Tcqfdw2W+qWI0POp52JdIJu4fIro1in99wP4uSu2PWHg2d0zGWrMc1YqJLUQnLfgV7bVzvP2AeIBsMnQ2S2S8UIklz7y8OfcPQEjiiPjC3blKadxK8mUVZqKoCAFh99jwwuvh3BR5no=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754327064; c=relaxed/simple;
	bh=ugPX0MiU/VS+WU8c5z+eSJ5o5JwXrGW6t++3YiCD3aU=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qS+L2B9vQvl6CjVBNzRY9TiWKi8p9u2hKCLBHlFruFWyXLaRn0zhLOOJVV5GpTOa7VABgecCJTAR3ggSdhphwZeOVCeV48NVS1g1q7KihEv2tB/CpMktTjzIelveu40m0HrgZfaUK9MSgS4SDQ8pnnzxP/b5gIZlm8DBq4F/IaM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mWQAKbJI; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754327062; x=1785863062;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ugPX0MiU/VS+WU8c5z+eSJ5o5JwXrGW6t++3YiCD3aU=;
  b=mWQAKbJIxZfjnuHV7cptaSgc9HPy41WfZ86j+aAZD2uqQs0PS5td1CEz
   ILbPD7Sp9RF3s41WVUqVIpcfET3sJtnQzmYP9ozwynMJI0Rr2trIfqTAl
   IKAZOFnQ2MvtWwfIy2FlvjcQvMEi+Z3g5N/pMSQLFD0MjLsKw0a+AQS3J
   QZRSfI99kPSQI7Kb/NmSC6iAPoBfbqnAC84t3TqyZ+H+nUOZcdjq2k8dy
   S2DEPBObR5+dalEOakrY3/ocrnP2W3hjpT315Wpi+vO60m/iVlh65WCgG
   FwIP7Pa+HDZIMAK1V/AXGDaJ+5NSnLpQJTrvBh6yrl9m8aMM9VpwpTfoH
   A==;
X-CSE-ConnectionGUID: cgWZ5LjATNqCliaMRwhOKQ==
X-CSE-MsgGUID: gkYzFkr/RqK9PhB5BbxDHg==
X-IronPort-AV: E=McAfee;i="6800,10657,11512"; a="44195859"
X-IronPort-AV: E=Sophos;i="6.17,258,1747724400"; 
   d="scan'208";a="44195859"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2025 10:04:19 -0700
X-CSE-ConnectionGUID: epKeMzvLSOSmmkjHC6l+VQ==
X-CSE-MsgGUID: KFIRG/hwTp6mOmFFU5OkkQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,258,1747724400"; 
   d="scan'208";a="164611172"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2025 10:04:18 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Mon, 4 Aug 2025 10:04:17 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Mon, 4 Aug 2025 10:04:17 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (40.107.223.70)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Mon, 4 Aug 2025 10:04:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N1m06bHf2l6V6NL4b0zsIEghPsfMEzgrdNmq0d8UiWLW9V0lleO2dspRXtOgzebNzXGwdvse/GwOmDgc1RQjOsFYZmKz1EDm7Ed0cAK3ktnPpqdQhVchwMAIKCBL8NuBhZUXoyBZ37Xe35r3XS9A/+8gbNkS3SG4OjEu7oFBXxJz41TLx4vEipvjLWq3//8EOfxI4nZeja1JZr/tjPP0B2jFsGZ/dwVCwnovocJq7fc8Rq8qRncJqaPBEuIzQxdyVJyZHiQUf2LC/13esZ8hYNfdLJ4tDEsep1v0sVImr44XlCcTp/ALa0sD+SeOTLPmo66ZZBtoyE5/wj3qyEul/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q2HjlLu0WtZa+r+PS1dEZma4LYE6fAybjtpnpaFxJzo=;
 b=K30+xXoIoL/vnkk7qGi5uU7P4mbyW3JeIp4ZRrzln8/Vyo63U8ZlF6Ov2EbwtRfWZqBvZW20QBJJCH/9pvWYKucF8A1r/Bn5pRg6U+US1Z/0MB93j1ohrLrpAqfChu5wPPIGnvhOwNqbVx0chKSZMgkSXKvdmQpP3/ppX77NY5lUHvwzQroV3jj9M2xlVivJm6N1RWPtSxIv3/6vhJ+KJcLPtjQhvBvshjhjQdNrlwnkUWijggPXCTMVL45XM2rNwAG0BU/ayIdGsEIBVTlG+HBipTTHag/MtVHlnP17lGQCHUzrl6r8KaeE7ilEO61g3Rj9F6imKFZv3KbrIAmS/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by IA1PR11MB7809.namprd11.prod.outlook.com (2603:10b6:208:3f2::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.20; Mon, 4 Aug
 2025 17:03:45 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808%6]) with mapi id 15.20.8989.018; Mon, 4 Aug 2025
 17:03:45 +0000
Message-ID: <d8a1978b-ca4c-4912-acf8-bcb6c921a7eb@intel.com>
Date: Mon, 4 Aug 2025 19:02:57 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH iwl-net v3 4/6] idpf: replace flow
 scheduling buffer ring with buffer pool
To: Joshua Hay <joshua.a.hay@intel.com>
CC: <intel-wired-lan@lists.osuosl.org>, <netdev@vger.kernel.org>, Luigi Rizzo
	<lrizzo@google.com>, Brian Vazquez <brianvv@google.com>, Madhu Chittim
	<madhu.chittim@intel.com>, Aleksandr Loktionov
	<aleksandr.loktionov@intel.com>
References: <20250725184223.4084821-1-joshua.a.hay@intel.com>
 <20250725184223.4084821-5-joshua.a.hay@intel.com>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <20250725184223.4084821-5-joshua.a.hay@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR0102CA0028.eurprd01.prod.exchangelabs.com
 (2603:10a6:802::41) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|IA1PR11MB7809:EE_
X-MS-Office365-Filtering-Correlation-Id: ac02ccab-b1bd-4029-1cf6-08ddd378df69
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TlJYQnczMmd6OUdhc1RpUXlIcG9oSDRQQjZZM3J2akJwRDEwWE81RjNURlo0?=
 =?utf-8?B?VmFMSGpDOWhJK2pkQTVRck5QZUZuYWZWYWJ1b0QvZml2T3owUXJDak5FZGx6?=
 =?utf-8?B?YWh3YndVbllBVUplYjJOY1ZrRWkydXVYaGQ0akVQdTJlbCtHcTZNWEd6VTZa?=
 =?utf-8?B?aGpPSVpkTCt0NEgrZ3p4dXdWTDlUOW1ZR1A0WHR1OTZGKzdUNlBsRGdSOEpK?=
 =?utf-8?B?dDJxRVNwTXNZUk1mWmFJR0hHcnZYWlBwejN5RVFiLzhweStIYUJPRTIxemt3?=
 =?utf-8?B?WG5adWlncE83eG1TSGN1ODUyWW12SHBndnN1VUNIVW1SUDJEUWh3SzN2Tjhq?=
 =?utf-8?B?V2RVQmpIay9OUVUxTG0wT0ZQbzJFWHRPbURiZWE3TVcvVUdIcWFJdlRmemRw?=
 =?utf-8?B?S0J2aTBzbDQ3NTlwb3ZMc25yc1FLNEVTV29jTlY2WDdnQVUwQVFmRGE2NXAx?=
 =?utf-8?B?b0ZTc1UrczJ6TWQwdU81QjhSSDhFakFxQ0FsZ25MeEZHRisyR3ZIVS91a3Rz?=
 =?utf-8?B?TWwwcFEzcWY0Nk9ZMnM5cVh2SGV2Mlc2Q05EaHFmV0E2WkxFVmZ6dUZ2UDRv?=
 =?utf-8?B?cVVjNndiOFYrZFhKZzZ4NlNsUnJ5T0lTL2MzSWY5cTQzYU5Ha2RzMU1kNlRP?=
 =?utf-8?B?UVBCRVBXY0xsMlBza25BYzFxSHNZdDRuUkpIb0dTQkRiS1hUU2ZXVmE1NVM3?=
 =?utf-8?B?cHlEYmNObW9BOXBZdzRFKy92c01hOFVqVnhra2pWc2lvREpxNkJmcHMxSkNn?=
 =?utf-8?B?bjBacWd6UXdmWkY2OE5WWWpIZnppMVQ1ZWovZUgyRms2Z0Q5eGMyRllTVTdO?=
 =?utf-8?B?OFlUalhyaVQ1UHhHQ0FTMy9OZ25KTitoWE44UVc2RmlXM3k0a3pLVks4ZVlZ?=
 =?utf-8?B?R3JnWUhQQ3Q0ZWhrcEFIMWJqdTkwMjFzSGNDdEE3K3I5K01VU3VyRTMxeHB4?=
 =?utf-8?B?WVZVcStOMmhvL3h3QmlVUWEzTzhzUXZ5Z1paM3lFVVZMd0dLaGZxTVBMa0Yx?=
 =?utf-8?B?TlR1ZDQ3OXJjTklxYmttS2FZU3RGRmx2cnpDYnpDREJrZzFhc2ZVL1pQcHBJ?=
 =?utf-8?B?TFhuU0tkZTlCSEt2OE5zeGpzYTdCc1lQY0tJWE01SjBpVHhSdm5zQlg4emhy?=
 =?utf-8?B?SkROMjhSRDAwV2xnOXVxNFNXK1JGOE5BdzdTSVZ2R2VFU1RxUnUxeG5kMFVk?=
 =?utf-8?B?YzYvYktPYlZuOEE1NTA0UVAvSzJXQ2ZDb3MvMkJGb2VQc00rWEQ5UmJNUG1o?=
 =?utf-8?B?T2tJR2lTandUMGZxN0oyS1NQOUZlZ0o1Q3ZidFlHelhkNEVvWFBrTmI5ekp5?=
 =?utf-8?B?dXBCb0g4L3VFY2gvdTlGREJRek1TUnNLcGR6WGV1YUJDNlE5eVJoMklsMlMx?=
 =?utf-8?B?RUdONkpqSHJib05pK3pEN1U5eWRHeEVvQnlvK2ZONmNFeVFrNThPb3labnps?=
 =?utf-8?B?Y2w0SDhUb1JSd25PWC83VU5mdUxGOEQ3b2h6UVBKK2JIdW96eUdXUUIvL2h2?=
 =?utf-8?B?VlE2WFkvRFN2R2FMaWI3dG9ZdW11N2lhM1RlNllEdWd1QlJ5NlI1SE9qazRk?=
 =?utf-8?B?MFR6TzNHMDhPazdQWlNRYWhiT2wzWWpVUXdIN0NZVGJoNGg1K0Uwa2NVWGpB?=
 =?utf-8?B?SXRHVmdCeXVKVnZKUHRSUU93ajROSVA3eEtldzJnTTBGMkZXbTBCTFZQR0Z1?=
 =?utf-8?B?ejlzeVhDRyt5cEFkMCsvWmFSZjlaT1lrN1BGT1c4SlFXUUVTMGgxREg4a3BK?=
 =?utf-8?B?NlI2R2NBQTUweGpUUkVGbkVMeFpoTnQyc1VndDdMUjJPZVY5K0cwaXZWNmk5?=
 =?utf-8?B?NkRKMWNlVlVDdzJtcC9ERXJCM2MvYTI4eWp5UzZTdlNSSkMrUjdxeGJqekd3?=
 =?utf-8?B?RU5pVGNFRWRacjFBb2VTcXJkY25tV09LN1VNRkxCQnk0OUE9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aXY0MFJibDlWUG9iWVhIaFZCYzVQM1lLMnVpUHJhWDNtaDJXb0tEUmFBODRQ?=
 =?utf-8?B?UGJkMkt4bjF0UDJvMHlsYWpaYVYvRXF6ejgvWDdoczlpQk0wRUdFS2xRRjRt?=
 =?utf-8?B?clBBRzJYcHVGSTluQ1RGakpvOCtMWExscG5CNm1mZ1kxYTBEbUdoNjhvekw2?=
 =?utf-8?B?enBpQzFMenBqRCtuN1NJcnJQc2xIQ0VPaERBRUJ0QzFBZTQ4SGFGUmkveWx2?=
 =?utf-8?B?NDV6M2NWTGlzNGsyTmFlT1QyaHl2bnlLUGduMWtDK281NHRpVzY0UkNBTDgz?=
 =?utf-8?B?RVhHaXRtNU1OaWRiOFl2Q09xbDF4RTBZaVdLUWFEekU3dU9SZXVUcXYrWmY1?=
 =?utf-8?B?SUwzck9IaDNPWHRzaEovRURqK1loQjh3T3N6TFdkZmZnNk9rMlAxN0lKbkpE?=
 =?utf-8?B?eUg3Slk1TGhSVFR3aWY0TForcnUvMnJEL3RhYkxTRXpENVVJSThxNk5WZWRk?=
 =?utf-8?B?MkhOTDZuelhpbFBtUTJuRHBKQUFQQkdNSVNERnRwM3VmWHp2UHVDODNvTm5Z?=
 =?utf-8?B?anR5UEdBenV5WlNwTXQ5Z3R6YytUNWZrVVJ6S2UzSXhDVW5ZYkM4QXdyMUZq?=
 =?utf-8?B?czhRTkJKdG9wLzRxd3QvbUg4eU4wb0tsTWJ5M3J0ejZHTkJSdHd3YVdiOHkr?=
 =?utf-8?B?K3J5Y1QzaVB6ekh0ektlaHZHT1ZyUEJkZ2ltM00ycXVNZWplZjNabktzQm55?=
 =?utf-8?B?YW5zemlPSDk4TmRPTHpwZGNlbVFteC85SGQyclgrazJ3QUU0YVdvQzZVVDMz?=
 =?utf-8?B?MytpUTJMbzJDREtXWkgwRG5jdEN4T1QyK05UM2pLemNOWFI2T0VnYkQ5ZEFV?=
 =?utf-8?B?VUFnMjR6THljbktEQjNiSSs0L2FVU0x0cnNTcGMyRDNFZUNqMGEzbmhtbU1n?=
 =?utf-8?B?eGVFMWtzcHBKc2UxRC8zK2UxNXZDMzBtVnhaSzlYU3JJMlJrV2gwMm1JcVZ3?=
 =?utf-8?B?eUZVenRFMThLRHJLZkUzOGdaajBlQ0gwRlB1WXcrNDBmS2pGRzlpUjNrbW9p?=
 =?utf-8?B?Y0JndTZhREV5KzQ0QzlFbDMzTTlCSWhNYXNLbkc4NlFGWGd3UzZHbC9Jd0tV?=
 =?utf-8?B?bjlmT0IrSWVkeFdQNnpRUXN4MjBtY1pNbzYvWWhYcCthWUFQSXUwWDgycVRw?=
 =?utf-8?B?Z1JWOUd0SmhpdWNkbGxKdGFUdzhKN2FQZW5oSTF6U0g2ME96aWFKY3RDdTNm?=
 =?utf-8?B?VnR4ZjF1aWQ4ek1WZ2lKRFVUQkNYTUFGc3hPSVFSdmdVTFplNzhIWHM1aUFs?=
 =?utf-8?B?aUtMYzdlek9IbUNuU3BBUWJHc1U0NDNrYkJLVFJFcDdjM2R4RVM0WHFkVGJq?=
 =?utf-8?B?TmNZQzJkVmFnNGMrWUNFd2F5ZjA2dzNsUjIxQU4wRms3bzJZNStGYzF2OG4x?=
 =?utf-8?B?SmlEV2RVYjMrN3NIQTdHWEdjeXV6NG5IYk9jYWhxbTlENFkrUzE3VkhyQXpa?=
 =?utf-8?B?WGVWNEhSS1d5eTlxd1FCQ2RDcGZhUXllbjRaTHRFRjk3WTZDYk9vZVljRzlC?=
 =?utf-8?B?eUQ1LzJjcUM1QldZcFZHeTN5OE8yK0k5MDBTKytpYysxM3dMYkkyZWdaS2xL?=
 =?utf-8?B?L1dYaHo2ODZ0MGs2OHg1cy9aMXdNYzM2U0xzRkNZN2QvR2hHTkJxSUIwM1BC?=
 =?utf-8?B?bldIOTJIUmh2YnpLTXBHdGNlTHZzM055NWk2cVNQeUxoSzJaRG1yWHU3TmFH?=
 =?utf-8?B?M3ljWW11VXk2cDZ5Ly9WYzBNTlBkbVlzVSttdWkvNG9Kb3FrV25TOEV1NXJS?=
 =?utf-8?B?ekwwVFRwM3crcTRVK2Rwd3N4YUxGeTdQSEx2S0QxNzV6MlpQUThrYUlXNXZC?=
 =?utf-8?B?bi9hNitEWGVHUzJWclVGbDFPWXJBUjVRWDB2UTRtb0hRQmlRYVhseWR2a3JT?=
 =?utf-8?B?NkFxZlRaVzl5Q1dRcHFJZ3ZFcFQvRFBhdVNuUEFkTytjVEpRbmk3VGNvYkhw?=
 =?utf-8?B?ZlRJRDRiZHZOa0FOT3ovSWhOY2hSR0RJVVVGbmVXNXBqekNETklxZkxjeCtE?=
 =?utf-8?B?NGp0MXJzbkNzOVJvSVRJMFVUZDF2Y3pPd1FpdlptRVNOSXhzQzFvVzRnZHpq?=
 =?utf-8?B?SkF4RjlZaUlTMEZncm9lbk1ub3YwYmp3a2svRWFNT0VDY0J3OWlKL2MrWFF6?=
 =?utf-8?B?d2YxbHYvR3YvRXJCMFJFcnJURDFLd2c4ck5ERERub2JMQmlhdkRnbndnMHpi?=
 =?utf-8?B?eHc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ac02ccab-b1bd-4029-1cf6-08ddd378df69
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2025 17:03:45.7887
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z20273YIy8vM7zLdfN78qSjbl8z5sr2FdsSCYSb04nurS5qhpkm8FNUFi5dWXEAkuVNUxQ+WS4NvNs/HEGoYvnyNrWnSDqvoblZSm5RrYhQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7809
X-OriginatorOrg: intel.com

From: Joshua Hay <joshua.a.hay@intel.com>
Date: Fri, 25 Jul 2025 11:42:21 -0700

> Replace the TxQ buffer ring with one large pool/array of buffers (only
> for flow scheduling). This eliminates the tag generation and makes it
> impossible for a tag to be associated with more than one packet.

[...]

> -static bool idpf_tx_clean_buf_ring(struct idpf_tx_queue *txq, u16 compl_tag,
> -				   struct libeth_sq_napi_stats *cleaned,
> -				   int budget)
> +static bool idpf_tx_clean_bufs(struct idpf_tx_queue *txq, u32 buf_id,
> +			       struct libeth_sq_napi_stats *cleaned,
> +			       int budget)
>  {
> -	u16 idx = compl_tag & txq->compl_tag_bufid_m;
>  	struct idpf_tx_buf *tx_buf = NULL;
>  	struct libeth_cq_pp cp = {
>  		.dev	= txq->dev,
>  		.ss	= cleaned,
>  		.napi	= budget,
>  	};
> -	u16 ntc, orig_idx = idx;
> -
> -	tx_buf = &txq->tx_buf[idx];
> -
> -	if (unlikely(tx_buf->type <= LIBETH_SQE_CTX ||
> -		     idpf_tx_buf_compl_tag(tx_buf) != compl_tag))
> -		return false;
>  
> +	tx_buf = &txq->tx_buf[buf_id];
>  	if (tx_buf->type == LIBETH_SQE_SKB) {
>  		if (skb_shinfo(tx_buf->skb)->tx_flags & SKBTX_IN_PROGRESS)
>  			idpf_tx_read_tstamp(txq, tx_buf->skb);
>  
>  		libeth_tx_complete(tx_buf, &cp);
> +		idpf_post_buf_refill(txq->refillq, buf_id);
>  	}
>  
> -	idpf_tx_clean_buf_ring_bump_ntc(txq, idx, tx_buf);
> +	while (idpf_tx_buf_next(tx_buf) != IDPF_TXBUF_NULL) {
> +		u16 buf_id = idpf_tx_buf_next(tx_buf);

This line adds a new -Wshadow warning. This function has an argument
named 'buf_id' and here you declare a variable with the same name.
While -Wshadow gets enabled only with W=2, it would be nice if you don't
introduce it anyway.
If I understand the code correctly, you can just remove that `u16` since
you don't use the former buf_id at this point anyway.

>  
> -	while (idpf_tx_buf_compl_tag(tx_buf) == compl_tag) {
> +		tx_buf = &txq->tx_buf[buf_id];
>  		libeth_tx_complete(tx_buf, &cp);
> -		idpf_tx_clean_buf_ring_bump_ntc(txq, idx, tx_buf);
> +		idpf_post_buf_refill(txq->refillq, buf_id);
>  	}

Thanks,
Olek

