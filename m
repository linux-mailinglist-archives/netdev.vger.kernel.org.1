Return-Path: <netdev+bounces-302588-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id XDSfEU1ZQmrM5AkAu9opvQ
	(envelope-from <netdev+bounces-302588-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 13:38:53 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A83D96D9858
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 13:38:52 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=kMTLH+fz;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302588-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-302588-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 83CF2304000A
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 11:27:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1B433B8948;
	Mon, 29 Jun 2026 11:27:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75A502AD16
	for <netdev@vger.kernel.org>; Mon, 29 Jun 2026 11:27:39 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782732460; cv=fail; b=SaWtEnShAJRtEzxoOjOJYFERvE1G4Jdcr1EgqV31362233PKe7WnqIZbqgUufNCSjtnNKcR7sK0iX+mWqQoZ5tdru4P1Zp97BU69gZSlt+WHLgCc39LxRwcwgE59WfUyRBIV2UW+T9Kk9GgOThC0uIK42QT3ozGtL4RjjsJMHcU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782732460; c=relaxed/simple;
	bh=8zR5Mcbka9YqXOvZeOnR31lphTkVSC4zzbETOzMnuZI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gX0JXA26NYjgcMKVTwrsRU8HjkoKdwfrERL7YramWcyUxmTqJBsbz/RzYp1mmul6qWLK7IwW6dC0+FnWlkXGs4omxLPF1Pa/s/WnKXVO7/BPowO44NTSyG7UECi7gM/cRuoBxytJQYbTtkiKwzEx+zKzFAA9nLg9ZOeoegxFUls=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kMTLH+fz; arc=fail smtp.client-ip=198.175.65.14
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782732459; x=1814268459;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=8zR5Mcbka9YqXOvZeOnR31lphTkVSC4zzbETOzMnuZI=;
  b=kMTLH+fzP8Jx+Ji9Rjq/UNDqik4wljRx7i152PuMWvQuEu7lwsLryuI6
   0cNTaSRsT/Jr798RRLKG44Bi7efpNfWsQ86bD3em+Ll47Tc2Oz3AzEm3A
   CkDUDCw3q/I/A3knshMeQXZQB9YCKWtdmc4Qb5kPCXw3XV7MGsyWuEAMY
   lKqIazi6X2cwBX5pSbNiI8m9I0zm2G11VkavV2+Gdh7aNTWbCLcHki0oj
   CHIltzQRF7TIHgj0vug1UdgS77V3V9VvO1+kgj1dXVowKC4LRw5g1/Bsr
   GtFJo3RRkQySidHot1Qadi9ziS5ZjGqaj3y0zFmPxu3tmm7/WE9w5rIpY
   w==;
X-CSE-ConnectionGUID: Dni6fEXPTdKUeedjN/Xfew==
X-CSE-MsgGUID: CmZ3Pq+BTomkhvecbcrY8g==
X-IronPort-AV: E=McAfee;i="6800,10657,11831"; a="87325913"
X-IronPort-AV: E=Sophos;i="6.24,231,1774335600"; 
   d="scan'208";a="87325913"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2026 04:25:21 -0700
X-CSE-ConnectionGUID: ZKM4GjDsT1WKl0TJE/1bmw==
X-CSE-MsgGUID: SaJVFQzFQOyvpay9215cwg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,231,1774335600"; 
   d="scan'208";a="250866458"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2026 04:25:21 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 29 Jun 2026 04:25:20 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Mon, 29 Jun 2026 04:25:20 -0700
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.37) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 29 Jun 2026 04:25:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tBrBdxL+EZ8gBO6RI2dJAd0GYNrk6HvL2RcSbOu+WGCHui70C43ihvS6t+L/JuuxdV8vMhCcHR6087WfQO0uNRUR1Iro1cpLKxcvYheH4KSmU04VU9XrI/AG8L04HpOBnNGhAGUL3qg5tVl4VuXjHaxn0UEO+pxJjy71FY6nS67sHZmh981wn6L4dJslQsjbJVjj1XNzRS0IFgakU8yOGq1eKbY7g4TDFa2CFmkckqnDgxvT34aU8AKA+UNFLw1bR76COPSD9wpXVRNE0rRVBxh5Fkxy7/g4yvQQJAwbHzYg85HX23XBYh+DaTIGGezcb+OAjYXsK8rpUZ4rUOXwhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8zR5Mcbka9YqXOvZeOnR31lphTkVSC4zzbETOzMnuZI=;
 b=GhctUEflel/P302Nzz4YeyRhzYoBG/XDAFlQnZFvkFvT/WfGDSF6Zd8FLDcr8nLZmMo5tCTaR45yXsRiG2Z1RghX8nd6xImYOabygP4IyQBamdXhwAAmcs0F1KN4eaQiRtA8dkdLNcMD+yYnTmrhFnMjbi73b+mXKig+EYTWEVakU0DaPaTpTi3aoTWa/pNWmDJLoLtlRXneE7StBQjjDzrP1mBPVQllmB7kvH2ChlYD4ETOzpoaEqL40je89es1EAKMixeercjoQqV91CzL4o89s7yn35zPUuyNx95HBmSsDQsxu3o4QnKtN23fJQf3/uLhwC4oJgskenLGeaQMng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SN7PR11MB6900.namprd11.prod.outlook.com (2603:10b6:806:2a8::7)
 by SAVPR11MB9575.namprd11.prod.outlook.com (2603:10b6:806:4e6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.17; Mon, 29 Jun
 2026 11:25:17 +0000
Received: from SN7PR11MB6900.namprd11.prod.outlook.com
 ([fe80::65da:530d:6803:83e0]) by SN7PR11MB6900.namprd11.prod.outlook.com
 ([fe80::65da:530d:6803:83e0%4]) with mapi id 15.21.0159.018; Mon, 29 Jun 2026
 11:25:17 +0000
From: "D H, Siddaraju" <siddaraju.dh@intel.com>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>, Andrew Lunn
	<andrew@lunn.ch>, Michal Kubecek <mkubecek@suse.cz>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Das, Shubham"
	<shubham.das@intel.com>, "Chintalapalle, Balaji"
	<balaji.chintalapalle@intel.com>, "Srinivasan, Vijay"
	<vijay.srinivasan@intel.com>, "Lindberg, Magnus"
	<magnus.k.lindberg@ericsson.com>, Niklas Damberg
	<niklas.damberg@ericsson.com>, "Wirandi, Jonas" <jonas.wirandi@ericsson.com>,
	Siddaraju DH <siddarajudh@gmail.com>
Subject: RE: the confusing 10000base_CR. Shouldn't it be 10000_SFI_DA?
Thread-Topic: the confusing 10000base_CR. Shouldn't it be 10000_SFI_DA?
Thread-Index: Ad0FbzNABPoQ31JxTh+QV3XDba1IJQACWbSAAAchFbAAAMJTgAAAOH5gAIQ6zYAAAe+HAA==
Date: Mon, 29 Jun 2026 11:25:17 +0000
Message-ID: <SN7PR11MB6900D73E1714AA8AE05BA7BF9AE82@SN7PR11MB6900.namprd11.prod.outlook.com>
References: <MW4PR11MB6912A234CAAAFD25EAC7C8909AEB2@MW4PR11MB6912.namprd11.prod.outlook.com>
 <2994edfc-0894-49c9-abac-6daea5e12075@lunn.ch>
 <MW4PR11MB6912BE7FEDE5C509B6C5D5DF9AEB2@MW4PR11MB6912.namprd11.prod.outlook.com>
 <2baa5a77-3305-4ed9-b56d-ba27cecc1911@lunn.ch>
 <MW4PR11MB6912BABFEED268D38B4BC2BB9AEB2@MW4PR11MB6912.namprd11.prod.outlook.com>
 <1b3975a8-788a-4b81-94ec-3ab5708b251b@bootlin.com>
In-Reply-To: <1b3975a8-788a-4b81-94ec-3ab5708b251b@bootlin.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR11MB6900:EE_|SAVPR11MB9575:EE_
x-ms-office365-filtering-correlation-id: 5bc763b6-cea0-4c6d-938a-08ded5d11907
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|18002099003|22082099003|3023799007|38070700021|4143699003|11063799006|56012099006;
x-microsoft-antispam-message-info: Dk60KrGBUE22xtfAH9B4ZrKiZ7vgUgzGcPJ4Cry1BDvNzzrRwUvSpk8CR90BvNaZDeyR5zyo4xxoJjXx8Cd0wxkhE8ZAkIrJUw7aD9dxxzhkFAbAw1uV0gpskYEo1dcBEqOarjw+JtMytIE9TwMZN7ZjnzBbLFwHN/xzC8FxSQSpo1APEyvpIQk9c1FIAbn1DKeqWmzZvRxnhsZpabCjyUVMpqYbMMhi9PuUr+yHiF9lX9mSbh8gBYWthGsIDiphfIxd13sWt06nni+h6m7eiIg4P0KLulNT+nQFnHfP0xwAATOQkoN2W8N/27LyxrktZkOStJhDpQz+6zg6+LdDdWDGUUW4rhFFJBx6EEctGcusszFa5zOYpd7ExGmP3vmzXDNDkByEMNGxILEpUOw6QuvrIJkI086Bwcuj8NjcAp3zBIxVfY4d5ZRtLoSN0Jk+dznnw6bEz9Mep/k0Jzb9jmNOahUu6achQpkVPuFOxr4pnmNBfKklsRFGuilSyvRFl0k2xBeqPoH856//a9BxLkvVf5hLQbA3w89ah/3S68tNFoME1erb/kKA2J1dqYPkmWcsanoIBsg0Q7RK5FmkouLOdcQbMgfKeo+77puBWCHXARm/fJlenSr08aubr4krP683gqv7mcF1EFU1DJI0vtomCFtE1Wo7VsamSzNMW9KxUzUahPBXJIH6mqRnfo0hcRbbr4v2DozuGrBtrLNc52KKIsr71KnzQVNKAGI4bx8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB6900.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(18002099003)(22082099003)(3023799007)(38070700021)(4143699003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YjF3SE9Lb0VlUkpvN2QrbnMwVUpqYlRNdjV0NGcwZzByc3U2dENZRVk2dllm?=
 =?utf-8?B?b3BTbi9FYStJZ0xYdmVXelJHclV4UHJzL1pvcllwTFU5aGtSZG1DQTZqRkt4?=
 =?utf-8?B?MDdyYWpjTE1obWNtOHlCbUhFZ1JsZEZrQTAvZElVTmxISy9yRFBoVXFWT2FO?=
 =?utf-8?B?aW9ObzZpeklJc3dqRmZYMG8yb0tjeHpkUG5BWjRzclJXVXBQb1U2NzV1dUxR?=
 =?utf-8?B?MUdhR0M5Ny9xVWRjWHk5akNuUVNicm93MmZnc1R0aXZvSXBjaXVPS29BTHZS?=
 =?utf-8?B?bUVPRlZQTDZDQ3hTTHk2L3Fma3c0T2d6eERDQm0wRjMrTFNpaVJ6ekZhU2dH?=
 =?utf-8?B?c0NTREUwVmk1WXdEM2phbzVhV05NNkIwbkVWZlFWUG9UN0JIT3g1Z2hsaWd5?=
 =?utf-8?B?UzdOaGk0MnUzYW5tOGRXSm5NNmZKS21YZVBZdWcwckg0UmhYL2RKNzlsTW1p?=
 =?utf-8?B?SVJ2NzdKQzVHWG05ZWErakZ4TXpkUHJDeHpFakN2K09Rci9oUjh5L1lRVWp6?=
 =?utf-8?B?bFRnUndIWnBWMGE3eU1jbEdwSm1ndlk1WTFtb0xqRzJFcldUN1BrVFhHZ1FY?=
 =?utf-8?B?YVUyUWtWR2t1bm1VbkNPRlEwSDV2ZDRsajVFM01ScHZIMFR5eU95S2YvbkZo?=
 =?utf-8?B?NExTVG8rL3NQdkN6NlhsK0R3U1JqVW1ZeVlMRjNWRUhMQ1FYMVBLTjRpL1Jz?=
 =?utf-8?B?c2VrTExPWndKQ01ua3N5a2J1U280RXR2c1FNSVA4MGxVRDZhQy9UVm1kTkN6?=
 =?utf-8?B?Y3FwUS9mOUl3UzYyRlZlckg0M3dyNXc2azBYWHFFbUtYcENWVGJyWXFWT3FZ?=
 =?utf-8?B?K1RnOVRVWkZHOCsyYXVMT3ZvUm9JU3M0ZGRLdDdGdzIxbG5EbnNRSGx1SzIr?=
 =?utf-8?B?MW5DU1MwSXVKUVBteTVCY01ra2hwMXhKd2lMYW1kTVJ6aS9IMm4xdHhXeDl1?=
 =?utf-8?B?Vk95LzZ6NlpLOVpZam1YaVp4ZDl5dlRodmROTGdnOG5HL1NEZlcrWTlZelVV?=
 =?utf-8?B?VFlKT0JnNllpb1BOZDlPeFZhSzJOSXhKUENWWElRWlhzUzBoUFg2TitiUW5M?=
 =?utf-8?B?azBpREdaaXFGSUxpeUl2ME5Xckh4U3c5ZDNhTkh1dURFRjY4bG1veG9qaCti?=
 =?utf-8?B?UVhvcHVjRWcxU0Y1dDZzU0p1a2EvZkNocWpKNEpMRytBdUlmRzJEcEVQWUdS?=
 =?utf-8?B?L2M3R0FLOFgrNVdIR1JJVUNqUnJabVBxa1V1YTZMMExLK0RQdHRiRzJlS25t?=
 =?utf-8?B?b2ZudlpCSXc0UDZxSXp2SzU0SEZFSEZBMzFtbm1mQUxZTnFwMHlVOTErSkt2?=
 =?utf-8?B?ZUY1VmRUaDBoNldMQWVoMFkxQXcyUGVKaU1oZGV1NHBJLzFNenVFSGF3c1hF?=
 =?utf-8?B?K1JCTFZZb2J5d2FtY1huL20vbmZoRVNTcDgrYTVCYkNqN1QxcTEvU2l4WGVZ?=
 =?utf-8?B?WDR5dXp5ajc4UHBiZzNPYVJPNzB2U3lCam9ReE1KdVdEaFhkZnYwVFJxZVk4?=
 =?utf-8?B?OHUvMUdVZkQyS2lhSXJIS0tVcVg4UDNxTkVvR21kMUdtWnpNWStiWkZKL1dr?=
 =?utf-8?B?MSswZ1NWSmZkUHRhUFZ4b0RLa1Yza1RYREpENXhMdkpIbnh4SlRNVWNkQlJt?=
 =?utf-8?B?c1dmNGIrTzlXQXl4ZnNCR20wamxzazBqZ2lXT01qbmFNa0s4Vk12blp6OXdw?=
 =?utf-8?B?bUptY2tnNmc2Y2RlZVJmUUJWcktEcWRkbFNROFNxYnpvMmN5NnF3NThGYmJk?=
 =?utf-8?B?cGJmc3ZzRDJWczM5NEtsZStsRU1SQVI4SUl4MjRyN25PKyt6d29Jd3R0WTF0?=
 =?utf-8?B?VENGSE12NGFrS1FwL0ZLMmpyajdjMHJrVGlPaW9ja2xlNlVqNXMzVVJOTVZO?=
 =?utf-8?B?MnluU1BkbEo3QnZZUFArR0RFbnJ3NS9QK2ZlOWJGL2xSRkFObG1Ib0QzcEJ3?=
 =?utf-8?B?SGZpbGZ3R2NPNng1dHVocFlTczZrRURyRXRSdUwxbXA5RjdBdk45RUNBSUlm?=
 =?utf-8?B?SjNXdUROV1JtZXdLbk5qalZHcC9ZbnFRd3djSk8yNUtPU2FzTjlxZTI2Ui9J?=
 =?utf-8?B?SE0xN2dZK0V0dTJWbVBPejVUZEFXV3I2d0hkMlJ0ejFHZ0t5ZmNNWFZORmZZ?=
 =?utf-8?B?aWdRcjZwdThmc1hQOXlzK1RlYlNEZWxqa2RpQmJOdTV0bUdUOGMrMnVDMGNV?=
 =?utf-8?B?MVZzVzRZdW1wU3FMN3VibFR0U1BNSXR6TFZUN2x4Z1BNRFlNZ25Td2JwdDV2?=
 =?utf-8?B?dlNqOGFzR1c2ZGhPWXdIWTNpMG05OXRqdUI1UUxPUnhuK0QzT1B1eFFUNXA2?=
 =?utf-8?Q?uL8fecRyc/RzyzFwQo?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: sSGdCL3sU3CP3lQ3kBhsU3ZaBIcT6v8ozswukrMFs4mGE3Tq8/e2eP1R8MhniCk0c6T7XcjuQoNJb8KF9Sym6//CFLJu44uSQEUhh49W9pkTosEgtD9ykz/zFycaTCp9yGkFN5kFGeRNenWiKMvs4xvmNFHigNLGJdPs+c4F/teRI2GLl4iU6+otN0A6sW7jwf4p2YxxxRUNJ/Ia+8oiSLoBQy3fSQtoaB5oRdai9/fEYEBc7AW0VmPlfD7CAL6LrRV9rxx80kM5CyF2YRRfPsooWsScKP633+FWkuTmhV4bWkc7L7H/sUxy/zVkCi2bfUAiFhRJnpjMvsXUijHaZw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB6900.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bc763b6-cea0-4c6d-938a-08ded5d11907
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jun 2026 11:25:17.7664
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: j4jJ5r2vi5PQ2uO5h0gORllOzCgFII4vPxoAgEwzamSr6Cnq9iuNO1A+8mUIglYTku/X+8JlWsmzEeSAfyaI5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SAVPR11MB9575
X-OriginatorOrg: intel.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.06 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	SUBJECT_ENDS_QUESTION(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER(0.00)[siddaraju.dh@intel.com,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-302588-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:maxime.chevallier@bootlin.com,m:andrew@lunn.ch,m:mkubecek@suse.cz,m:netdev@vger.kernel.org,m:shubham.das@intel.com,m:balaji.chintalapalle@intel.com,m:vijay.srinivasan@intel.com,m:magnus.k.lindberg@ericsson.com,m:niklas.damberg@ericsson.com,m:jonas.wirandi@ericsson.com,m:siddarajudh@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,intel.com:dkim,intel.com:from_mime];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[siddaraju.dh@intel.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,intel.com,ericsson.com,gmail.com];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A83D96D9858

T24gNi8yOS8yNiwgTWF4aW1lIENoZXZhbGxpZXIgd3JvdGU6DQo+DQo+IE9uIDYvMjYvMjYgMjE6
MTksIEQgSCwgU2lkZGFyYWp1IHdyb3RlOg0KPiANCj4gPiBXaGF0IGFib3V0DQo+ID4gIm9wdGlv
bi0oYik6IGNyZWF0ZSBhIG5ldyBlbnVtIEVUSFRPT0xfTElOS19NT0RFXzEwR19TRklfREFfRnVs
bF9CSVQiPw0KPiA+ICAgSWRlYSBpcyBqdXN0IHRvIGNyZWF0ZSBhIG5ldyBlbnVtLCB3aXRoIHNh
bWUgZW51bSB2YWx1ZSBvZiAxMDAwMGJhc2VDUi4NCj4gPiAgIFRoaXMgd2lsbCBOT1QgY29uc3Vt
ZSBhIGJpdCBwb3NpdGlvbiBpbiAiZXRodG9vbF9saW5rX21vZGVfYml0X2luZGljZXMiLg0KPiA+
ICAgSXQganVzdCBoZWxwcyB0aG9zZSB0ZWNoLXNhdnZ5IHBlb3BsZSwgd2hvIGRvZXMgbm90IGFj
Y2VwdCAxMDAwMGJhc2VDUg0KPiA+ICAgYW5kIHByZWZlciAxMDAwMHNmaURBIGZvciBiZWluZyBl
eHBsaWNpdC4NCj4gDQo+IFRoZSB0aGluZyBpcyB0aGF0IGV2ZW4gd2l0aCBhIG5ldyBlbnVtIHZh
bHVlLCB0aGF0IHdvbid0IGJyaW5nIG11Y2ggdG8gdGhlDQo+IHRhYmxlLiBJdCB3b3VsZCBsaWtl
bHkgYmUgYmV0dGVyIHRvIGhhdmUgYSBjb21tZW50IG5lYXIgdGhlIDEwMDAwYmFzZUNSDQo+IGRl
ZmluaXRpb24gZXhwbGFpbmluZyB0aGUgU0ZGIGVxdWl2YWxlbmN5Lg0KPiANCj4gPiANCj4gPiBB
dCB3b3JzdCBjYXNlLCBob3BlIHdlIGFncmVlIGZvcg0KPiA+ICJvcHRpb24tKGMpOiBldGh0b29s
LjggbWFuIHBhZ2UgaGVscCBzdHJpbmdzIHRvIGluZGljYXRlIDEwR19TRklfREEiDQo+ID4gICBT
b21ldGhpbmcgbGlrZQ0KPiA+ICAgICAiMTAwMDBiYXNlQ1IgKDEwR19TRklfREEgICAgU0ZGLTg0
MzEgU0ZQKyBEQSkNCj4gPiAgIHVuZGVyICJhZHZlcnRpc2UiIG1hc2sgdmFsdWVzLg0KPiANCj4g
SW4gdGhhdCBjYXNlLCBsZXQncyBhZGQgTWljaGFsIGluIHRoZSBsb29wIGFzIHRoZSBldGh0b29s
IG1haW50YWluZXIuDQo+IEV2ZW4gdGhlbiBpdCdzIG5vdCBzdHJhaWdodGZvcndhcmQgYXMgc29t
ZSB0b29saW5nIHJlbGllcyBvbiB0aGUgSlNPTg0KPiBvdXRwdXQgZnJvbSBldGh0b29sLCBzbyBf
aWZfIHdlIGNoYW5nZSB0aGUgb3V0cHV0IGZvciB0aGF0IG1vZGUsIGl0IHNob3VsZA0KPiBvbmx5
IGJlIGluIHRoZSBub24tanNvbiBvdXRwdXQuDQo+IA0KPiBNeSBwZXJzb25hbCBvcGluaW9uIHdv
dWxkIGJlIHRoYXQgYWRkaW5nIGEgY29tbWVudCBpbiB0aGUgZW51bSBkZWZpbml0aW9uDQo+IG5l
YXIgMTAwMDBiYXNlQ1IgaXMgZW5vdWdoIDovDQoNCldpbGwgd2FpdCBmb3IgQE1pY2hhbCBLdWJl
Y2VrJ3MgcmVzcG9uc2UgYWJvdXQgdGhlIG1hbnVhbCBwYWdlIHVwZGF0ZQ0KYW5kIGFzIHNlY29u
ZCBwb3NzaWJpbGl0eTogb3B0aW9ucyB0byB1cGRhdGUgZXRodG9vbCBoZWxwIHN0cmluZy4NCg0K
SU1ITywgeWVzIHRoZSBjb21tZW50IGluIGV0aHRvb2wuaCBlbnVtIGRlZmluaXRpb24gaXMgZ29v
ZA0KYXMgaXQgaGVscHMgZGV2ZWxvcGVycyB3aG8gdXNlIGV0aHRvb2wuaCBkaXJlY3RseSBidXQg
ZnJvbQ0KZXRodG9vbCBhcHAgVVNFUiBwb2ludC1vZi12aWV3LCB0aGUgbWFudWFsIHBhZ2UgaXMg
dGhlDQpmaXJzdCBpbXByZXNzaW9uIGFuZCBldGh0b29sIC0taGVscCBpcyBzZWNvbmQuIFRoZSBl
ZmZvcnQgaGVyZSBpcw0KdG8gaGVscCB0aGUgdXNlciB3aXRoIGEgY2xhcmlmaWNhdGlvbiwgdG8g
YXZvaWQgdGhlIGNsZWFyIGNvbmZ1c2lvbg0Kd2l0aCB0aGUgd3JvbmcgbmFtaW5nIG9mIDEwMDAw
YmFzZUNSIGZvciBhbGwgdGhlIG1ham9yIDQgcmVhc29ucw0KbGlzdGVkIGluIHRoZSBmaXJzdCBl
bWFpbCBvZiB0aGlzIHRocmVhZC4gV2l0aCB0aGF0IHNhaWQsIGhvcGUgdGhhdA0Kc29tZW9uZSB3
aWxsIGFsc28gc3VwcG9ydCB0aGUgbWFudWFsIHBhZ2UgdXBkYXRlIGJlY2F1c2UNCndlIHRoaW5r
IGl0IGlzIHVzZWZ1bC4NCg0KLSBUaGFuayB5b3UsDQpTaWRkYXJhanUgRCBIDQo=

