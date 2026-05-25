Return-Path: <netdev+bounces-291276-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WInPEmsdFGqnJwcAu9opvQ
	(envelope-from <netdev+bounces-291276-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 11:59:07 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CC8AD5C8DFD
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 11:59:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 96D7F3003ED6
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 09:54:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 398F8361DD9;
	Mon, 25 May 2026 09:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dfifmFUO"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04C94328B62
	for <netdev@vger.kernel.org>; Mon, 25 May 2026 09:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779702849; cv=fail; b=tR2E/n0buW/cDFj42FeSOjlbnCa+jZ2FMzDLOxpsSr6aBWc6bg+zCr4DFVU8gcBym88DF3GAlzZXwDEAPKBXb0kkXFDn/S7p1uL+U24zWw7IRqhFIzryDv0SpKQRyIUY3qboRUiChwb1NsCEjjUfZVzVaUgQy2QVF0pftJyViWE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779702849; c=relaxed/simple;
	bh=jPf4dz2IF8hrODnas4JL+cvz8yS7RuVDRLHEc+luoeY=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=t40as8hw8n5TkGODjDzTpdu95HddIF4bbfOUaZNSsx3o+oU4Iv8hBtg75Eewq0CudLXkh4UkQyWaZJYUJW2TYNIfT5HXUT7cFkOpPHcWfGzJw3J24uxOPYqG3ItvViJeeGvrit7hjm70rg8PZ89QqN1/oNR9Ua05AU55me/NJdo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dfifmFUO; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779702846; x=1811238846;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=jPf4dz2IF8hrODnas4JL+cvz8yS7RuVDRLHEc+luoeY=;
  b=dfifmFUOlkXxe7nujLUCoL1hfnHKLIrQrTBZdH4FcvTdO8Z6+s/CHvdV
   mZ7niFJAWMehTxvxNH2sLweGj8nDh6jo0p1bzUy4PUOiiqpenSAqJEMyo
   hxLy/bwIhZBxGL2cxxnkmiFk+C5IXSbGbUaeKDiIPfVBhhkLLHHWiiUOU
   VtWCDJxx5TIE8saShEf+pv3wZoDgngDSmBuglwWJhWs1pfVp7NKkQm2Ep
   TCU6XNZEAOs1/VzWYqfyqU4nbx2bUhqF0UbUIv5gL6JXhIXlN/7em+JcA
   8BoLBNs0jplAoeRtK5jCD854fFlAT2VuC5sC2SqSBwtpMAQ6hvzjzDJkP
   Q==;
X-CSE-ConnectionGUID: HdiKSCkRTR2ZOuINJtGi4g==
X-CSE-MsgGUID: 0A1UWJuHR8yT+hkniCGpbw==
X-IronPort-AV: E=McAfee;i="6800,10657,11796"; a="80707469"
X-IronPort-AV: E=Sophos;i="6.24,167,1774335600"; 
   d="scan'208";a="80707469"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2026 02:54:04 -0700
X-CSE-ConnectionGUID: lafF2Oe3Q9WsrIim3Ti4oQ==
X-CSE-MsgGUID: c48NVVvBSxOG40uEIiKtQg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,167,1774335600"; 
   d="scan'208";a="240525473"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2026 02:54:04 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 25 May 2026 02:54:03 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 25 May 2026 02:54:03 -0700
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.37) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 25 May 2026 02:54:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=deVZiCr0jv9zDWLxmro7BJF9mgS1OgwLMquClbAHVb7SIvCgUc3UPna89Iw3VTWM9c/gNU+3FFta9U7d9FDiDSbw0+WH8EeYS/1g3wWtvyQHjQCJ/h4AcC+7uyyBbUk03a60CLoL6LyKiEklodtLMxJblkgxHU3ZI7BYoWyU+g26RKLMkwnReWzRYAaUSpFT5GA7My16shn3n/ox6Qa+zCc8esVPXxZQ1AQ91UeOsZo7+Dld1My7muq+zbWrdAZRDats/8jXlZ/t4l5HqXz3O2BSfGPGlXWjGyhu6QeksAJ+N/BFuNapsrEhsb+Ep1EnZcuxHpiuYNB7zXIBWsn1WQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6pISUlE5eSV3z48SSMio5nQxoRMUDMMSd7maMAb1a1E=;
 b=fJvS5ZVs+yrSCblxlHIANvqMfHI79aTrECz4Ui15jjVwBI4qyxhTRTLWomKM+AyQsZXFsb135PR0YBcWAi/vBF5WK05qiTkZXaeQz4TV0NUdgfktzhS+AHo840iBpY9Ewk8ZIkJNfRaxmPIT5pQ7wGTNM6K07YDcOvRRsAWtkml1BRNDC09KUIuiVdwdd2fVJfgFUVno80ttEFVmUfFfAhv4LGaq/07Pbvew7lT5hmjsVi2a0Gpqn0Qp3crIhZ4nb+8UbqDRnZm+YMf+4Hu5H6zQrHUJRS4ufewRoyh2woArhNkBD4suHpoXxtMu46k/mepVTAXA4FSXOQPzqbGnqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7958.namprd11.prod.outlook.com (2603:10b6:8:f9::19) by
 SA3PR11MB7656.namprd11.prod.outlook.com (2603:10b6:806:320::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.19; Mon, 25 May 2026 09:53:58 +0000
Received: from DS0PR11MB7958.namprd11.prod.outlook.com
 ([fe80::8cb2:cffc:b684:9a99]) by DS0PR11MB7958.namprd11.prod.outlook.com
 ([fe80::8cb2:cffc:b684:9a99%6]) with mapi id 15.21.0048.019; Mon, 25 May 2026
 09:53:58 +0000
Message-ID: <b1c3c79d-f114-4283-b8fc-1fbcfe85576c@intel.com>
Date: Mon, 25 May 2026 15:23:50 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] drm/ras: Cancel and free message on get counter
 failure
To: Raag Jadav <raag.jadav@intel.com>, <intel-xe@lists.freedesktop.org>,
	<dri-devel@lists.freedesktop.org>, <netdev@vger.kernel.org>
CC: <rodrigo.vivi@intel.com>, <dev@lankhorst.se>, <airlied@gmail.com>,
	<simona@ffwll.ch>, <kuba@kernel.org>
References: <20260523050212.557292-1-raag.jadav@intel.com>
 <20260523050212.557292-2-raag.jadav@intel.com>
Content-Language: en-US
From: "Tauro, Riana" <riana.tauro@intel.com>
In-Reply-To: <20260523050212.557292-2-raag.jadav@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5PR01CA0218.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1f3::13) To DS0PR11MB7958.namprd11.prod.outlook.com
 (2603:10b6:8:f9::19)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7958:EE_|SA3PR11MB7656:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c90e8e4-f67a-4f25-99be-08deba438a44
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|22082099003|56012099003|18002099003|6133799003|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info: AVi+VWLfKP7TdszybdjiFyQaWjodi9f2uUUyADKDFs2rs1bXoeRlnflLU/hNgPADnfl67Y6AlDKnX1K6AEKV4Nw15wKswjit0C3wfd/nNbx9F6B9d+wXIpe3xuRIf53GU2Crxye++U8QMVMiF7IjdhwZuvO472N/Fd4ZnxgrR9870gpSOGOE4uGIXkRNwJKBeE567aUkYJQ7T+FwhsmbSKmo/QQ+dbhnDY5Gl1v1B9dnvgmLVLNO5SMk+CxtjVJC1g53EmU4M2d3gWcsWcUlsFJfNKIS/7YeXM5j/6Xo5Mocti7YYJWk/tpOxJMhlu1kYgj39vfgt820zvWiFChFFRN6jA4nHaCLiMtxBCEe/7Jv67JIe6vutYwWNeNOjORTDEqDLJuWWWprnD/33Lpub8CUuR3aQak49zBwm6Cy2a/WqwEAUL0XOzIqq9U0tcdEWlQfayW/e0mHB+MYmE9A17RaCezFY7u763ylc20KRmxsRAhmXJDMZ74+um4+PcrqgbzR75FSLwkBGDvNQ/5a5wOsYTq5GImibW8myw88OgZ54rq7tswrVqekvOshn1pptfGNkTn0TRFH1nwLpoD+pp6zJ+vkkXOzufmaf124u6yHBzWYGnkxAKa6fZG2GqDcxgCSpaQ21iH3jZScGZYgZqfa3xxjIEhAD/szQoyuI6VuhSSveO1dAuPHmjK7tuiE
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7958.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(22082099003)(56012099003)(18002099003)(6133799003)(11063799006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dGtmZjNnUWM1eWlVYUFpWDRtTnllT2ZIakJOQ3J2VkhKV1o5T2EyVkdQREhx?=
 =?utf-8?B?SFBDWEp5ZWtyNWxFaU53RVE1ZEEwTXpMSzBLbS9TMG0zd24rRXFGOTkwK3dx?=
 =?utf-8?B?SFB5UFBPc0cwcS80Vno5N0NZSWpYVzBqUjZab2w0a0xXenBiT1ppWm9nWTl6?=
 =?utf-8?B?dlhaaXRJbThHYjJtblNZZ29JRDFrU2xZaEdBT2tKcWZ4NGZnamlLRks0TEgx?=
 =?utf-8?B?NWxuREtvbkZpRk9MV3NWRXR0TEdaNjlPRi9ZNDNoVDIxOURadGRHZGdJcEpl?=
 =?utf-8?B?a2p0OERtaXRNY2tUQ2RsTWFtT09Icnk1Z0RqaXFBSjV2MS9kWnJOb3dGQ2E5?=
 =?utf-8?B?MUszdC81UDlRMlR4MEVMVkV2aUM0Sys5K1hJeXVyanVsQllGaHp1bUJ0dWJR?=
 =?utf-8?B?b215K1Q3OEtHUFU5R0ZaREtnU1UzQ2xrQSt6UVIxOUlrdHhEMUdSeUpCNDFO?=
 =?utf-8?B?MENjOUxMUWkrSG5GYVQxTmdHYlEveDZUMFRqMTJUV2llb244WVFHekgzRUNB?=
 =?utf-8?B?TDhmMVduekl3WjlRMUdaWXcxbTlOWDZ2WWVRT3NYb1NlSEFXbUZSWVZycnkw?=
 =?utf-8?B?ZlVWU016S0YzQVBJM3lPM05IY2RBOUhtK0xrZ01oSWtNVlBxYkNmS1l1YzZi?=
 =?utf-8?B?dExtVVlDQnpSc1JBb2g1OWdSdFlFL2t4cDc0OS96ZXBTRE5ETGo0NERDamZ1?=
 =?utf-8?B?MVZncDZTZVlvMWRxNVdEbytidm5Vblc4RFg0MFFkNXI0amptdm9XeDl1RUxX?=
 =?utf-8?B?S2FaZUR1Vkc0Z3N3anppNmVraHR5YTdmYWUzVUtUdFJPUjQwVDkrSGNpR2g3?=
 =?utf-8?B?OE5DL0xDcE9nVkErZnJVSlloQVBFWU1xV04rZnRvUDN2elc4WGtWYXUrTjNh?=
 =?utf-8?B?WVhZbnRMa0U5TS9mTHdtUEpTd2RrUi9TUUFha3JoL01UZ0xpU1BwU25jRXJX?=
 =?utf-8?B?REVKYUp2NmdlVjB4N0h0R3VvSy9Ua0tGcVBsSHQ0TlpPdVBsQzZyQStsYWxS?=
 =?utf-8?B?b3hNYnFxVVhNeTc3QmxiZjIyOGdud1dmYXp2REpJSzc5eUNKRm5FbzI0Qktt?=
 =?utf-8?B?WS84WFZRVnVZWHFQSyt3WDNkcHZORmRFbjhEbGhzbVZuSkh6VlFzbzZaS2lq?=
 =?utf-8?B?cnhpZGJBUWNzYmdXVXkzQ2NtWkg2bWJlYnlhS1h5c2xQQ1RrSXA2L0Y2ZzRy?=
 =?utf-8?B?aDRuNjNBbW1YeUNlazB1TFRpSUs4V0JkQ2NJb0FWbnFIbkdPWE1zSzZBMTND?=
 =?utf-8?B?UjJlYnZpQzB4NkF1Qlc5dDVST1FsSFcrc2hHVXNOYWhadFlud3h5dEI2dG5H?=
 =?utf-8?B?OHZLK090SkFLcUNFc2V1aE00S05sWHZXRkdBdlBCQTIyaTFuZHpuVFIvS1Ni?=
 =?utf-8?B?b1RDbm9aV0haTk0xUmU5TEVqUHRHVTNiQS9WdlF1YUE0N3dIOEsxRFRmTCtX?=
 =?utf-8?B?TjBVZ09XM3RPTXI2bUg3aHBMYVpqcVlXNUR0ZTQwVUtiQWsyUjlpeCtEVGkv?=
 =?utf-8?B?aHdLcE9ObHVyUzhtWEVTeDhzSlJoUkRpZ2xqOHRKbVJyVE5oWmF0REZOSnhl?=
 =?utf-8?B?ZzNlNmlBSWQxNG1yQWFwTVNNTkpLK3JISVROYUJJTXp4ajlERzhpQm9oNDln?=
 =?utf-8?B?a3UzVXllcGRGL3RSQlpBbWUxUTNoRlJHZnVXSlM3MkVYTFd0SVRPSHBMb1Jw?=
 =?utf-8?B?RTF1Y3ZYNFpsckhieFU1Mnhuc0trMDUzT01LVFltVmQ0L2RRaXhxdUY3MW5W?=
 =?utf-8?B?alVkTk1wZmRvSklISFRlanRqNW1CQ2wvS2ZLRTduODAxYy9ldWlZSFhac1Vz?=
 =?utf-8?B?RjlweVZJbUkvUXpyK056SElocHd2cmxqNUkweENOWEdjRm00ZDRJSElCMmlC?=
 =?utf-8?B?Q3JpUGRDenNBWjZ5MEdZWEI2NWRyaHIwTGZqNUMyM25ZVm5CYTlHMk51VWlp?=
 =?utf-8?B?SU0yb1ZYS0M4UnlPWktJRWdocTNSYm55QitVTlEwdGk0NGFuL0ZRN2N3NFc5?=
 =?utf-8?B?OG5aVnZXZ29XWEZxUTFaKzZ0UjVUUWY3WnMyNnVGN3ZRMEl3NWhvZFNEdVc3?=
 =?utf-8?B?ZklTTUlrdlJWeEY2K1BqUjdZNkVuaStITGs0YjFLOXY0L1U5dW1lb0pOTkp6?=
 =?utf-8?B?MFZKeWRSTllsaXhhT1piQnlOYWVPc3daeVRlR0l3K3VYQk9KYjhEOVFWa2Np?=
 =?utf-8?B?YkpWbVJ0RloyUE9PN21jMk9HMXRsOHhPYmExRnArTzJIdlhrVUk3TEpFbmJq?=
 =?utf-8?B?MDU5TzlPRVJhckxjSk5CYithc05VVXgwTmVjSTh5VXNsaUJvTTlmaEJtYkQ3?=
 =?utf-8?B?Q3BvVUp5RWhKcUxaWm9LMU9rdFQ4L1p6MnVUR0EyYXdtdC82VnRQZz09?=
X-Exchange-RoutingPolicyChecked: sdPDGp4ykpDYfi9LyNuGI32rI8cTPUALAosv7Qkry05TcgGQ5nDbOCvwhOqQcMCxZGTQYYcQCzI+yzTfIu/4ReklASPbT/gdb0aQNP2QTtubwO3tbDl4GC3DBKTW7knHzbwgMdicopCUaNRB889FcFRA1rkfOOdiZHp1dsPoTSO1mYmwPRXmDA6TIdms7bim9az8SKgMmDJW6u9cfC1mmmdF5EmDRrUqW2mh87uz4azz1i6xsaDL/mfywl+NXLu0RNe+Q+yiYgTZHevCeX05HacqXX5F24qTt4wkzfwhC27jSm6Eqr9qs12u05JbZZR57l5SrJwEGvdiwCbGi4u3Bg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c90e8e4-f67a-4f25-99be-08deba438a44
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7958.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2026 09:53:58.1754
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OHVemxBWDvl18gWooZIDpW2dTZBbDcnOCk1qnHwmLarzlSQkKRXS0HFrIq6LcY7ebXLK0TG1ujpX2LmdYpV8SA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7656
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[intel.com,lankhorst.se,gmail.com,ffwll.ch,kernel.org];
	TAGGED_FROM(0.00)[bounces-291276-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[riana.tauro@intel.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: CC8AD5C8DFD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On 5/23/2026 10:30 AM, Raag Jadav wrote:
> doit_reply_value() directly returns on get counter failure, which results
> in stale sk_buff and genetlink header that aren't cleaned up. Fix it and
> while at it, consolidate error handling using goto.
>
> Fixes: c36218dc49f5 ("drm/ras: Introduce the DRM RAS infrastructure over generic netlink")
> Signed-off-by: Raag Jadav <raag.jadav@intel.com>

Reviewed-by: Riana Tauro <riana.tauro@intel.com>

> ---
> v2: Use goto (Riana)
> ---
>   drivers/gpu/drm/drm_ras.c | 19 +++++++++++--------
>   1 file changed, 11 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/gpu/drm/drm_ras.c b/drivers/gpu/drm/drm_ras.c
> index d6eab29a1394..467a169026fc 100644
> --- a/drivers/gpu/drm/drm_ras.c
> +++ b/drivers/gpu/drm/drm_ras.c
> @@ -201,25 +201,28 @@ static int doit_reply_value(struct genl_info *info, u32 node_id,
>   
>   	hdr = genlmsg_iput(msg, info);
>   	if (!hdr) {
> -		nlmsg_free(msg);
> -		return -EMSGSIZE;
> +		ret = -EMSGSIZE;
> +		goto free_msg;
>   	}
>   
>   	ret = get_node_error_counter(node_id, error_id,
>   				     &error_name, &value);
>   	if (ret)
> -		return ret;
> +		goto cancel_msg;
>   
>   	ret = msg_reply_value(msg, error_id, error_name, value);
> -	if (ret) {
> -		genlmsg_cancel(msg, hdr);
> -		nlmsg_free(msg);
> -		return ret;
> -	}
> +	if (ret)
> +		goto cancel_msg;
>   
>   	genlmsg_end(msg, hdr);
>   
>   	return genlmsg_reply(msg, info);
> +
> +cancel_msg:
> +	genlmsg_cancel(msg, hdr);
> +free_msg:
> +	nlmsg_free(msg);
> +	return ret;
>   }
>   
>   /**

