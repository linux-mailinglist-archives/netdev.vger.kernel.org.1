Return-Path: <netdev+bounces-295430-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id oq+JK9nzIWqLQwEAu9opvQ
	(envelope-from <netdev+bounces-295430-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 23:53:29 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 11004643B61
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 23:53:29 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=ALBTqMIL;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295430-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-295430-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EA1B6300766A
	for <lists+netdev@lfdr.de>; Thu,  4 Jun 2026 21:53:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5736F3BBFDB;
	Thu,  4 Jun 2026 21:53:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FD413BBFB6
	for <netdev@vger.kernel.org>; Thu,  4 Jun 2026 21:53:25 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780610007; cv=fail; b=ZhcWuV2oYHjsDFQCZA1cvivXZn0U7dXO2td+kcXNW2gFYGCHjMnIrHbDwOxgjHqvJlSR96w83snorp40OoYgQgMNgkxdKGxGUKXqNT82qnIimM9LBzQw97L8JW3/ERLfL1xmvLvqVr1Uy/S4F8nToMnBklpQoSNHhtZbM0IYyDE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780610007; c=relaxed/simple;
	bh=Tq2/H+X3HEfkOQ/TqkDv59X6OOR/j6eBrtttJxOqWV8=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=fmK1U6quWFs/PbZyZzQU4Ge8hsa0KnKtIScLCB04naVCyIdY2c7DEckjcN5gpvL6lGFxASvUtq0mvxuLWc66DkBcWvWuebp2Jku7y4JLWoR82H4M6BvB5xf34l3cYbUc64rACrXimEGf/mw2lvUt0If3yuRHJ6zvZ0nYWeFuLZY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ALBTqMIL; arc=fail smtp.client-ip=198.175.65.16
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780610006; x=1812146006;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Tq2/H+X3HEfkOQ/TqkDv59X6OOR/j6eBrtttJxOqWV8=;
  b=ALBTqMILUTluaqcM4K1S7L11T6c0UDorBnAlsHwvjn67h1594PjT9R+b
   MhjWPu4oHpuMakKJP2v74CKqVL/L1nVZtiimbd20iNMHXRC0q7bFwxhHK
   adbbYyavwGKOk/3CmuF/uaftdvgRqzN5nLMtmECvPlqzEpggmxkXVVp7r
   9E8zTcfpX5hnz2+6Y7D1RLeMgKjne3RNw4e1EYUBxUKZ7k/tNqIpxo54Y
   FFvHHKasv9TVo+fUFFF+9o+mgNUCgzJgOOJpwdZEzIuFNXCKpQXNINurC
   Zp7WAflZfqSwM3BcZSV2Wlid5GEJiKeD0s+rcuWltBld99NgOcFeRQIO1
   w==;
X-CSE-ConnectionGUID: 8udhmHB4SkGWI2j4/si+Rw==
X-CSE-MsgGUID: QYAe/DVbSQ22WrkPH8h42g==
X-IronPort-AV: E=McAfee;i="6800,10657,11807"; a="81630016"
X-IronPort-AV: E=Sophos;i="6.24,187,1774335600"; 
   d="scan'208";a="81630016"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2026 14:53:25 -0700
X-CSE-ConnectionGUID: eLsHfOXJSqeDM9V2unB7KA==
X-CSE-MsgGUID: eqbwN0GKSUyUerGMpRZZhw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,187,1774335600"; 
   d="scan'208";a="248595536"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2026 14:53:24 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 4 Jun 2026 14:53:24 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 4 Jun 2026 14:53:24 -0700
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.5) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 4 Jun 2026 14:53:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vs5rxfcDharRKBVP7B21E3Q8MN4HrwJLjJM4wAqj4oGRWmiFWc2O2ooegVEJAgbIcPssZ7Ct9/60baQ9NfRX+PqfIvKoElga8jj0vQ8cklicN76VyQ4m0Cy898+ajUZZ2DMeHCQsi7SfHFajU+CM+5wDQ1FTnuO28DafuEOVWLvDyayPKia4GiBw3f0QBbM17dAbPbQ5ZvNoE6WbcothB7AncIrN84T841qhAflpQVvOPMdZaXHzw5gRzQci8Ofg8WzGTQdtu/UykDnQnkrDe3M7usB3V7s+RAsZ4EGO9SWUuAkIgK/ZDb2V79+wddDUT9eN1+kcn67bgzfpq1yA7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8GtN70m0Oj0pD4JTToQIvuiFGgJBAktvwCLDasA0jLk=;
 b=fla2OBuEFLHChfX/yle83tFRUPn5V4oroVFDn3NSQU2sp55NEj6/3YI8QgFfsjKLxgmJX1hmB2p/h3Zh8fmGsb3C+7Pt+AqwtVg1wEVOoYCQR496qI3+CJE1fli3DDeCslu15cGPSnB6F0vElSAxaSOVZFfEyG7F3+yJ+CBTkJaZZ8z7Ix/O4nSykErBo4erMR83XUthlfKNytS7zdvfspkVOExzIJ/MULc1Z6W3DbQQF3IZvCOLJCHV9Yc1G3Dt1a6GW6GsptRiKymzMXKSOEuvOUwjjpojk9zpLDEhLBXbirPWoB8veeOtJgyXwgeu5x8Cku9Hh/U9rdVoqwDq2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB7381.namprd11.prod.outlook.com (2603:10b6:8:134::14)
 by SN7PR11MB6996.namprd11.prod.outlook.com (2603:10b6:806:2af::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Thu, 4 Jun 2026
 21:53:13 +0000
Received: from DS0PR11MB7381.namprd11.prod.outlook.com
 ([fe80::4c39:dfe6:d6dc:6f58]) by DS0PR11MB7381.namprd11.prod.outlook.com
 ([fe80::4c39:dfe6:d6dc:6f58%5]) with mapi id 15.21.0092.007; Thu, 4 Jun 2026
 21:53:13 +0000
Message-ID: <27c767d6-cf5f-42f0-99f4-e7ff030e5214@intel.com>
Date: Thu, 4 Jun 2026 14:53:11 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 1/2] net: airoha: Fix use-after-free in metadata dst
 teardown
To: Lorenzo Bianconi <lorenzo@kernel.org>
CC: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Felix Fietkau
	<nbd@nbd.name>, Matthias Brugger <matthias.bgg@gmail.com>, "AngeloGioacchino
 Del Regno" <angelogioacchino.delregno@collabora.com>, Florian Westphal
	<fw@strlen.de>, <linux-arm-kernel@lists.infradead.org>,
	<linux-mediatek@lists.infradead.org>, <netdev@vger.kernel.org>
References: <20260602-airoha-mtk-metadata-uaf-fix-v1-0-3aaa99d83351@kernel.org>
 <20260602-airoha-mtk-metadata-uaf-fix-v1-1-3aaa99d83351@kernel.org>
 <21810a20-abe6-4490-969c-cfd62c4c082a@intel.com>
 <aiHsxFrleJfpLeuA@lore-rh-laptop>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <aiHsxFrleJfpLeuA@lore-rh-laptop>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0340.namprd04.prod.outlook.com
 (2603:10b6:303:8a::15) To DS0PR11MB7381.namprd11.prod.outlook.com
 (2603:10b6:8:134::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7381:EE_|SN7PR11MB6996:EE_
X-MS-Office365-Filtering-Correlation-Id: ea99218e-be1c-4f6b-caeb-08dec283ad4b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014|18002099003|22082099003|4143699003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: kdbqAesKj0Yntyx8JnuNqKYULWJ9KFgzalUXZ2Tne2rDb8uTbRiPCaFEtE5kp1mNn9/OHbkb4eINLoWkw/Rygm4kEA8JtpndI8ggw68sgYGXcg6IwsAMSnhFOJspcCblbyhAadmPaEy49o0KXnU/BFn2Y+xXvTgKPN5qQOmo+lAI2cgOmGdvVfC5LNdxgHlhWa9jbnENabAe10w2cv35GOif61arnqPBYDTFL6Ghx5xVIJRiuE5HpeL3IdiNUhVQwcv1vbM2OzW7ASz08Bbc4V/M6ITEFiG8cKFfzb7i3ByHERzOXCcU6utsqm8SwqDYkfSKVVorY5jGL5pTtbABAcaB2GI2kbSq4uOj3TIwgkrgn7anmamkRP3GdcyxumiK0rnArx5BiPYazltYgBedNmgv2690TUO0xAvlhFXTwS9m9cPiFoUjgVfopw4nFrSOPyqqmUwPGT3387c7/3t0KZwcfb4kCJfq2QIC8mgjJ4e2Svl/PAmby97UMUnm9TDKMs3VL3/MYoJTHpzGH3Y/capp6w8CIAnv7sb1KN31vDWQzilvSVY1rNTSOIoWnr0+C5EiFwG0WVN34pgwGDoPthZKHWQU7qSah2Z9daSby1iL777iYLfkn2+ADojmSRICS5wUEqN2OLcd55kXm8GskZwgQN40Tbg73Hs0mL3pN6fxtbXKQ1aINSFYi/Rrz5mS
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7381.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(18002099003)(22082099003)(4143699003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MHF2NlpLUzFwS2E4U2loN3FFQ0srZ24zWGRxS29pdWVlQnBqcnBacjRSZXk1?=
 =?utf-8?B?RUxJQks2c08rWHQzZ0swaDloZHpLRU44ODBVV0duZndHMVQ3dm5pbnhHRHRq?=
 =?utf-8?B?dFhWRmxHTUE1LzFXQkJoZHNReFZVemxZYUEvQ1UyOXdHY2hwcjcwcDdQSWpv?=
 =?utf-8?B?blBlb0dGOVMrWElHaVZhZkRRZTI2dXZkMkI4eEFDZmJxTy9DSUpXanBhVjh2?=
 =?utf-8?B?UnNxcEE2T29sLy9zQlB6NjBLWUxML0JqcWxOQTVGNENhMGZWNmxCUE5VTnl4?=
 =?utf-8?B?d1g0RTNnVGtnQzdtbnRXTUJ2MVVvQjh1QUM3VmtScG5VTW1aMmlMN0FtRTZL?=
 =?utf-8?B?a3hiaUNGcjU0R3RiV3RFaW8zQ3NMYWd3RGFvNVdKWUVrQUpoOFRBcnZKcjJI?=
 =?utf-8?B?d05mSWFPblNRbUZKbDNNNmxIK2UzekhBanFPUzVWWDlxamc2VE9ldWZ3MndR?=
 =?utf-8?B?QVVYZkxwNGRpaERkU2F4QUI3czNweEhFWXk2ZEZrbk5hOFIyeWlXU3JsREYv?=
 =?utf-8?B?TVJqRnVJK3Fjb3BZeUd3eVMvWHN4L2hJL1YvRHdRYityQ3NoZFRISGQ1SlFY?=
 =?utf-8?B?S0JIdzhlV05Qb052akhQL1BaRXQ5OXpvMUtXS0J5dUhjczdCc0lLRmJJSEhU?=
 =?utf-8?B?OFBtenhiVktHdllJaE5Ub2pSd3h1RXN3dHpPdEFVYkFkSk83VktmbWp4eEpL?=
 =?utf-8?B?VC9SbFRQbkxzeUZzWFZQcVlpemc1UVNNbGVjckJsbHJqTkJHK2QrdVB4dHBh?=
 =?utf-8?B?NkJWOVdHVlkycEErSHNhYmEwZ2NPeW41aVYrVFJqM2tKMW4xaUVrbjZGVE1D?=
 =?utf-8?B?cDYrMFhoMy94SnhpeUE4cUhKSTlFYVAxZHphNXFnLzlKZEdVRktyRVQ4TC80?=
 =?utf-8?B?c2JhcEluUXczSTBibXBDVWZnZ2RSMUF3Z3Uyd0taUmEvbysxUHlUYjA5Q1Fy?=
 =?utf-8?B?Wjg4UUZwYS8vQ1gxMU4zclNuQkpRV3lKbG5DVHpVVHUzRVNjL3hJWDFVZTFy?=
 =?utf-8?B?dDI4M3ByZ3hSRVNac2ZENmZYVXFmaTVqdFRUdGI4b01laUUxSHZxd1R2V1ZU?=
 =?utf-8?B?RWw2Z1VvMlpPZXNxVGhBNy9PTWNnN1VNQk1Wd0ZOcjArenRFazFuQ3FRTnJX?=
 =?utf-8?B?blJ2V3kzWVRXRitmaEhaQ3Q0T2Vpd3ZvS212UC80aHJybThlbVNCbE9kVTVy?=
 =?utf-8?B?cFFvK3dWd2xNOGZRa0hYRHRZTTlWYWtmSnNFeXQ1cm44L2RoQ2djWGpPRzhB?=
 =?utf-8?B?MjhLa1BYUmkrdndiS1dwZmIwUnI2a1FmNEVDY2FlQlhFWjdMMVB4OS9yZlVz?=
 =?utf-8?B?K1IydVNRdXFUV1gxNTBZS0JvTkh2MlpsbW1FZE9aRVQxcHZzWGNkakRBTCtm?=
 =?utf-8?B?MzVBZUxpUUd4ODlXNGJEUjU4dk5BeUtPai9KeWp3TmlKb29GZmJ6M3diNzNG?=
 =?utf-8?B?NDl6MjYrWXF2c1VNN2poQzlSQ0ZMZkVpandjMnY0UnJSNUxwclU5YmNBcnhQ?=
 =?utf-8?B?UTllY1NoNnpXVHFSVnlMdUMrYnhPUHNWT1ZMZ1FTcG9HZC9CazRZdFVERWVL?=
 =?utf-8?B?eEcvMDFJSjBqNXV6eGV3QmFhY1NHYWVHMnJyWkRDalM4S095N0N5bEU0VW9Z?=
 =?utf-8?B?MVF0SzRxN1RJYUxHZFZaMVhKOE4zVjYrcll5OXM0aFFiUFNTeTJIUURJUnp3?=
 =?utf-8?B?cHBya2dEVG53VmdLYzRWYnFDK1p1MWYvSXY4ZUJ1a0FRUVBlMFpkSldkWkJl?=
 =?utf-8?B?OTM1dlFtbGVHYXkwZjdtSW4zUDlqa2VWRjhWeUZGeDJHTUZGZzUvYkpZWjkw?=
 =?utf-8?B?ZUo4YjVXdFA2UTNZY0wvNGhQdjR6ZURFRU16d2lKY0dUeEpQYmZ5cThnblJj?=
 =?utf-8?B?OXZOYytUVEtFaWJPMWtXNThGcmxObi9BbUM0UTExVjljR282bndLQ1NEYUla?=
 =?utf-8?B?dW50SmxNUG1ERDRaV0VlWVBKTnpLaGd2MFdNalhyYkdCNXdTR0hFMjFySVRp?=
 =?utf-8?B?NEVmN0Fxcktua0FhdGh2NDVYRWxqWm5FTmE5TVFlWG43eVlCdkFaR3RYTzdq?=
 =?utf-8?B?aWowb0tPUENLWkhkTEY5bWY0M1A4WXZjOFZKZUtLMldvNTdJV0poSERSTWp4?=
 =?utf-8?B?ekhIYnN5Qng1Q2ZudHVRTnk5d3B3bFczbzIzYi9mVFBteHpVUzh2N0pZeWRM?=
 =?utf-8?B?NExLTHJ0eE1jb0FZanBmam8waHBNdlE1VDdnclRHR0JSTlIvaHlmbUlDT3o1?=
 =?utf-8?B?Q1lWQU1lVU9jM2IvWTNxbzRxcno5Kzk2endCOUh4aGpmaDZIZGZPU1JXUHE2?=
 =?utf-8?B?bE51M2lCUmhacW1PRWlhYkJaTmN4NzYvK1czbVh3RnkvZS9OWTBWenBONmIv?=
 =?utf-8?Q?88d7Ditj2Ptzb2N8=3D?=
X-Exchange-RoutingPolicyChecked: erj4Or62b/j7PpuIjhgsiUdBT8WrXhi91B1qcYNnoAAd0JaAvuZ/UaOOyPxyhF9hO7sZZ3WiqPUajw+jBX8dGOGp9A9EojQxHFL0fIhVIPP+CwFnlywNoPBlCG6+GJtT35jioD7EetiN1MTfv53vvf+xgXjhR2OHHTxROLJz+r626WvKhtF42eDaiEgndjxqqI1LKQUz/7XlgIZxrVgFr8fkh9qNlLI4kLOyzxHl1Ry7LQehU+Arz0fxLfYLDIE8S6eOW6FPhoiuhFoffomzYuADLLVnrdnqtL5cGwub+lze9wBhukWp4A103ZMDPz7o7C2iphUojkRmBDVBM8hBQg==
X-MS-Exchange-CrossTenant-Network-Message-Id: ea99218e-be1c-4f6b-caeb-08dec283ad4b
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7381.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2026 21:53:13.8270
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: euwbhbxsz0z19Hb8PYOMezOHZhn2HHQc0tkwMgLF1DbRGesnKHw0LXk0iJf+ilzPrdZTG9HjOJnYwCBjAwqSOUGRvn69huR9AVBErRPy7e0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6996
X-OriginatorOrg: intel.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-295430-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[jacob.e.keller@intel.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_RECIPIENTS(0.00)[m:lorenzo@kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:nbd@nbd.name,m:matthias.bgg@gmail.com,m:angelogioacchino.delregno@collabora.com,m:fw@strlen.de,m:linux-arm-kernel@lists.infradead.org,m:linux-mediatek@lists.infradead.org,m:netdev@vger.kernel.org,m:andrew@lunn.ch,m:matthiasbgg@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jacob.e.keller@intel.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,nbd.name,gmail.com,collabora.com,strlen.de,lists.infradead.org,vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 11004643B61

On 6/4/2026 2:23 PM, Lorenzo Bianconi wrote:
>> On 6/2/2026 2:21 AM, Lorenzo Bianconi wrote:
>>> airoha_metadata_dst_free() runs metadata_dst_free() which frees the
>>> metadata_dst with kfree() immediately, bypassing the RCU grace period.
>>> In the RX path, skb_dst_set_noref() sets a non-refcounted pointer from
>>> the skb to the metadata_dst. This function requires RCU read-side
>>> protection and the dst must remain valid until all RCU readers complete.
>>> Since metadata_dst_free() calls kfree() directly, an use-after-free can
>>> occur if any skb still holds a noref pointer to the dst when the driver
>>> tears it down.
>>> Replace metadata_dst_free() with dst_release() which properly goes
>>> through the refcount path: when the refcount drops to zero, it schedules
>>> the actual free via call_rcu_hurry(), ensuring all RCU readers have
>>> completed before the memory is freed.
>>>
>>> Fixes: af3cf757d5c9 ("net: airoha: Move DSA tag in DMA descriptor")
>>> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
>>> ---
>>>  drivers/net/ethernet/airoha/airoha_eth.c | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ethernet/airoha/airoha_eth.c
>>> index cecd66251dba..eab6a98d62b9 100644
>>> --- a/drivers/net/ethernet/airoha/airoha_eth.c
>>> +++ b/drivers/net/ethernet/airoha/airoha_eth.c
>>> @@ -2936,7 +2936,7 @@ static void airoha_metadata_dst_free(struct airoha_gdm_port *port)
>>>  		if (!port->dsa_meta[i])
>>>  			continue;
>>>  
>>> -		metadata_dst_free(port->dsa_meta[i]);
>>> +		dst_release(&port->dsa_meta[i]->dst);
>>>  	}
>>>  }
>>>  
>>>
>>
>> the port->dsa_meta is allocated using metadata_dst_alloc().. how is it
>> safe to use dst_release here? Seems like we should be calling dst_alloc
>> instead of metadata_dst_alloc in order to use dst_release??
> 
> We need to allocate the metadata_dst using metadata_dst_alloc() since
> md_dst->u.port_info.port_id is consumed in dsa_switch_rcv() to get the
> switch conduit port.
> I guess it is fine to free metadata_dst running dst_release() since dst_init()
> sets DST_METADATA flag and so dst_destroy() runs metadata_dst_free() after the
> RCU grace period.
> 

Ok. So when would any flow need to call metadata_dst_free()? I guess
some path might happen to know that its already past RCU grace period
for all accesses or something...

I guess mostly my brain would be less confused if we had
metadata_dst_free() call dst_destroy or have a metadata_dst_release() or
something to make the two sides of the naming match... but I guess thats
really just noise on top of the API, since it doesn't really add any value.

Thanks for the explanation and helping un-confuse me at least a little!
>>
>> metadata_dst_alloc does call __metadata_dst_init which calls dst_init..
>>
>> I guess the start of the metadata_dst structure is also the same address
>> as the internal dst_entry struct...
>>
>> But dst_destroy does a whole lot more than metadata_dst_release so I
>> don't feel confident in this actually being a drop-in replacement... It
>> calls netdev_put, it calls the dst->ops->destroy, it releases child
>> refs.. Or for metadata dst entries is that all basically a no-op??
> 
> __metadata_dst_init() calls dst_init() with dev = NULL so netdev_put() is a
> no-op. Same for dst->ops is dst_blackhole_ops and and dst_blackhole_ops has no
> destroy callback.
> 

Ok. So basically its correct, it just looks odd because the code is
re-used by several other flows.

>>
>> I feel like I'm missing something here.. The driver also calls
>> metadata_dst_free in the remove path and that wasn't changed by this
>> patch either.
> 
> can you please explain what you mean here? we do not run metadata_dst_free()
> anymore.
> 

I might have been mistaken. I did a search for metadata_dst_free() in
the driver and I think I confused the airoha_metadata_dst_free() call
site while scanning the code.

All of that said, thanks for a quick response and now that I understand
it makes sense:

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

Regards,
Jake

