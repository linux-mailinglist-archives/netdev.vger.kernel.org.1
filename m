Return-Path: <netdev+bounces-304545-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id UbWqIzC2R2qhdwAAu9opvQ
	(envelope-from <netdev+bounces-304545-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 15:16:32 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DCC4702C0A
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 15:16:30 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b="kLR/9mzb";
	dmarc=pass (policy=none) header.from=intel.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304545-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-304545-lists+netdev=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4C074300F7BA
	for <lists+netdev@lfdr.de>; Fri,  3 Jul 2026 13:07:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C5963CC9E8;
	Fri,  3 Jul 2026 13:07:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA2102D1907;
	Fri,  3 Jul 2026 13:07:47 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783084069; cv=fail; b=u5bSuBgKgkZlhqdeyUxYT3sNJsRJlqtxjXLvjFxZpUOMdF+8yPMhl7yRTyp35i22+r5BHNXI4Nmqr/cAJ3oSfHUwZNxDJcGb3CDxjE7d5WvszscTouAwM4YbbDhxLw2VSpLsU49/ABtleuzzoKVeh3znPOFcesXuvRiFl60KCf4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783084069; c=relaxed/simple;
	bh=Ct+A6C04VwI+7bg0cRzT/SXD5XJWgkJ0BvJM2A3ad2A=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=h5WiM+o8/lImpq9yeOHVnqg9JuOx7bHx+Pjcr0qrVlxfE2gOxz8roLK7IM4ul4pw2U/PNBqhsTuB8zGWrb/Uqq1nsqF7Zy2ZdzJGCXOlJdkly8JxbhHjgipDomGGodAQbpmUuAvtL69k6ZBtgr/wd0oLfUAWneZYDAyEugIOoNk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kLR/9mzb; arc=fail smtp.client-ip=198.175.65.18
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783084068; x=1814620068;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Ct+A6C04VwI+7bg0cRzT/SXD5XJWgkJ0BvJM2A3ad2A=;
  b=kLR/9mzbAH6qPLOFBO5ZiZ506ZyMiPRNxe0a+PFN2BM8hwnuTZLI1P9i
   jLIRlufJ6HvQAu+KOjYAr6oWzrd+/CDbpe5pTPN0ALKyQxdL+IoVy4U+v
   oF21NtOCWGt2sZM7Es3Lq8Im34Q2KG1ohoKQFzJfkAwhqNRiSswSGPzVc
   ZHsIrngCB9CUhfBNqei/+QiRDUajrWwnT+PmuVlFxzBiAqxkk+Dz+uiWT
   PYzsIUi8J9yhZvH3MHy4oHlbJoy1GxaL09xL9m665mzgGfllbXKzDhdgb
   8qke6E/EK/TRBKlHCTWvIftsldDID/0j7R6fyZBa3ebCBR/8UP3X3byDH
   w==;
X-CSE-ConnectionGUID: Av3WxerbTUeRSkczzqvqMQ==
X-CSE-MsgGUID: elOLsdGIQ1yMjWZU1P9k0Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11835"; a="83930920"
X-IronPort-AV: E=Sophos;i="6.25,145,1779174000"; 
   d="scan'208";a="83930920"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2026 06:07:48 -0700
X-CSE-ConnectionGUID: drH9F4Q8TnyBF7Qdprinyg==
X-CSE-MsgGUID: fd+U1CX9SI6EwRz4KMiVDw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,145,1779174000"; 
   d="scan'208";a="249755286"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2026 06:07:47 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Fri, 3 Jul 2026 06:07:46 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Fri, 3 Jul 2026 06:07:46 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.23) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Fri, 3 Jul 2026 06:07:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tmv3MPdAq/rgwmwB0TqBmKf3mn0o0OEoGVnSEGAFHFjnOP0NXmWlCUdHUxE2Hf92bLB0g9l2uyIk9yf7EZjMcJbj5pVaw1dnX//aopvL154w+GbYQKhreFRDD4jEB0KEhGoNk93qdc4sGI7K132YKDB64XLjcO7219EhMVAYxEusOkrFZizTiCbZfYH+2Yr4rCYDVU1geU0CGzIw6KzTSX1kc2X2N+YEru2VBv6qB0qqoaS/M0XGT1xKGACqNyZpzrslUpAW43z5SqznaRhBArjdGxdVGHhZ7u8thBLZ7FDqIh/6j1FunjCmhnnBDqrZZ1LXyQ13cWgt92UQMEAChg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ct+A6C04VwI+7bg0cRzT/SXD5XJWgkJ0BvJM2A3ad2A=;
 b=dIHIl9TrK5coFjIY2qCiVXv7zx9V1ObFf3oXaATCIYqT7DaUbNEAHebZt07tN9AH5w3rFBLafh8ulFFefj5YZ+9GMLQ+7TY39ixVVk3KBP7poZOXuUnAP+cU7dIk2Ffen+ziZMOqo/7otvq4vcB6YX+ix1X0S2TDv007wPi+kvkRZDViupdJRCBVmWqXsje6D5PNKm8n/60iWH07A04QrmrIAPpY3a1sqWwja6v4I3nG/fS8sYH8Mh4hkFdamKAy6hJccB41WlZ6na3xdmWdsX2lF+1gh8tDEKkGe+KZMPCisqrRv92Y6bVgSn5RwKecbcwOhdISkjlUChEFKg6sog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5902.namprd11.prod.outlook.com (2603:10b6:510:14d::19)
 by PH8PR11MB7119.namprd11.prod.outlook.com (2603:10b6:510:215::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Fri, 3 Jul 2026
 13:07:36 +0000
Received: from PH0PR11MB5902.namprd11.prod.outlook.com
 ([fe80::f95a:602a:34d3:5d37]) by PH0PR11MB5902.namprd11.prod.outlook.com
 ([fe80::f95a:602a:34d3:5d37%5]) with mapi id 15.21.0181.009; Fri, 3 Jul 2026
 13:07:36 +0000
From: "Jagielski, Jedrzej" <jedrzej.jagielski@intel.com>
To: Luke Howard <lukeh@padl.com>, Andrew Lunn <andrew@lunn.ch>, "Vladimir
 Oltean" <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Russell King
	<linux@armlinux.org.uk>, Richard Cochran <richardcochran@gmail.com>, "Florian
 Fainelli" <f.fainelli@gmail.com>
CC: Cedric Jehasse <cedric.jehasse@gmail.com>, Max Holtmann <mh@rme-audio.de>,
	Max Hunter <max@huntershome.org>, "Tyrrell, Kieran" <kieran@sienda.com>, Ryan
 Wilkins <Ryan.Wilkins@telosalliance.com>, Mattias Forsblad
	<mattias.forsblad@gmail.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH net-next 04/17] net: dsa: mv88e6xxx: Add RMU
 enable/disable for select switches.
Thread-Topic: [PATCH net-next 04/17] net: dsa: mv88e6xxx: Add RMU
 enable/disable for select switches.
Thread-Index: AQHdCsCqplYW6d3mjkO0eBRFPWdhY7ZbxBUw
Date: Fri, 3 Jul 2026 13:07:36 +0000
Message-ID: <PH0PR11MB5902450E6326A99FA9CC1C32F0F42@PH0PR11MB5902.namprd11.prod.outlook.com>
References: <20260703-net-next-mv88e6xxx-rmu-v1-0-991a27d78bca@padl.com>
 <20260703-net-next-mv88e6xxx-rmu-v1-4-991a27d78bca@padl.com>
In-Reply-To: <20260703-net-next-mv88e6xxx-rmu-v1-4-991a27d78bca@padl.com>
Accept-Language: pl-PL, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5902:EE_|PH8PR11MB7119:EE_
x-ms-office365-filtering-correlation-id: b478f028-f7a3-452f-a591-08ded9040ddb
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|23010399003|376014|7416014|366016|1800799024|22082099003|18002099003|921020|38070700021|4143699003|56012099006|11063799006;
x-microsoft-antispam-message-info: KVTwSR3IefeaHYtv/85LcvkaR4MOw/GYtL2YT3g7Aio/LjLQEs7mnmM1GUVJYDNZB8fUygcOfe8/tWT9I4shAW+YGjUaUOqZStn5lrzKaYUYjsaNxK6aFLs171IcvMgI2pAYOl/IlGLeIcd5R7XXTBsSz07oer+3qQTBEfcU2uqcCXXOAp19QjLcSlfXYEzLlYW3sgHkHDFmvJO/b9atJzOJekmZc05djzvgKczEVtNnDYZ3llvIpaP8ggrZsMF7B1hzXFiJzfZsmOWHz0XCYNlUqDlrTByWSB2ur7ZSKgKR8URbCw/VoZHuLS1p/+oCEHkx0/OlaXH6V8bikNZwZ22OigqRaOwJt5jl/BO0wwFqFZoEQxYqKFCF3e32rA81ykiqJlXbYekNz1eP4i+SAiUxgA7f+njZKzGyysosa35dsEJXAJlwD9vgKG5jLNk/VRsPsRe/7G9qwJovxDptJM3kQYS7jS1O0m2w1YAD1s274sQbmlzmmqlRrGNbN7ZOn38PcQYX0Soao3iaiUfo5wezwQJIwO1ICqidcab183SwBV+2rA3YZGkJhUhRd8gjb07DhRa1D222gL/QDxstye+SYtP+QieWE75UQNri4rUIzfXdLjOjCP0aNJMj4RzTD9ZFgXVtD/y3EMvVBH0dTDB6Sguy4LhSOux/rd8SAUQnyvgPId6f1VETf+7VUVQ1PJcwxWCFkFFXTVkZ9AZVprSFTZrlr0Te20o7osmmJtSMLfYSj4Bz3YFQs8w1RLBU
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5902.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(366016)(1800799024)(22082099003)(18002099003)(921020)(38070700021)(4143699003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Vjk4YmlrVmxHQ3YxZk5yWkVPTjByY3FuSlBUZnIrWHhERGdNQXN1aWFMbm9t?=
 =?utf-8?B?MU1jdlpqNVRQanhjd05pRkpEck9abEdoZTZueGp1L3JsMWVWMGtucHVTamd1?=
 =?utf-8?B?eFhZUnhZTnhpKzBGclZiSEdmVDNDK0pUOUdvZFdkb1ZLMWdsc1F0UWx1RlhE?=
 =?utf-8?B?TnppZ2dIZFBLa2F1NW1PYmpWdG0wSGgzajA2MUNHUEhvNzJ4eUxDMTl5T1hY?=
 =?utf-8?B?eG01bWQyVTVGSXdDUzl1RGJWQmZndjZzQndZRVZVTUFITFNGQUxRV0szdFN4?=
 =?utf-8?B?ZHF2SnV4L1JYNlFqZSt4dHJUWHdZWTVwVURBNEgrZUNvMTNMY09wWVhGa2dE?=
 =?utf-8?B?eW1Xb3hrNmNEdUdvdytVREM0eTNPSU5BUC9UU1gvOTJpMmw3dkhUeit2Nm1u?=
 =?utf-8?B?NGpnb3JKbTRCY3VlNVB4ZmN1NzhXRkFBTHhseCtCTUpUY3E5NHcrV2NTMWFs?=
 =?utf-8?B?ajdXVnpGaEtZZ3E3eHFBSlY0bkhTeHd0TXdBbXFuc21SVTZ1VW5yTzJkeEY4?=
 =?utf-8?B?eUp1cW1ma0tDQ3E2TDQxelFTVm9HMDMwR2U0VGFzamZLWjJiU1kxejR2SFhH?=
 =?utf-8?B?a0JGa3A4NjJSTVcxZ2ttNFlrMWFNVTk1Ukd1YUFGazBWbk5VekRQVElFRVdQ?=
 =?utf-8?B?K0E4QUZSTVhNSTlqcStuT3h0ZWNkUFozU2RaTXpIUmdzV1M4RURoQlVWTVVa?=
 =?utf-8?B?RUhRUlRWSDhnY3k2UmNjbWJxb05lWnlXQllMaXVpTnBsYVEySjhJa2FKb2lr?=
 =?utf-8?B?TlR4bVRWYjlzZW9yRzNtUlVmZDNpZ3ZPc01sWThFVWVVWjZoWG12eHREWUF4?=
 =?utf-8?B?WEVvQXU2aldjYXNvWExRd2Y0cEFhWGF1MURnMVBHei9pRWlnNXdGZUxHUGUw?=
 =?utf-8?B?ZE9yUzNIM3E1MUJQZHlBSW1BYlplbXRRMU4rM0twZmJtZDZsWE94a1JheGJQ?=
 =?utf-8?B?TWhLa3E2UnRuaFdJMzRLSUpob1pRa3hDQVpnYUdtblNDaGV5SmZsRWR5VFNj?=
 =?utf-8?B?c3dMZHErUjhtNjE0SHN6MWF4a3loaTlNcUJOUlFPZi9BUy94MDdySjRZLytB?=
 =?utf-8?B?VjNQdlBrTGx5cmFPRng1NGZoeVNiNURINGRsVWh5U1g3U0dUdWRBUU44Z1RN?=
 =?utf-8?B?aHcyVDZpQmJ0WVdETE5IcVFidTBPRCtQS0lWcysrWTlHLzNrWEtUYmVMekNr?=
 =?utf-8?B?Y3VDZlNJMWJ5ZFZrYzdOWHVZd0tmdUN4QUU0aGRJaWJ5NU9VaTdDR3J5b2xI?=
 =?utf-8?B?S0ZzdHAwSkxZZ05JUi9ITkx2R3dHeU1TZm1NOGdoOXlyTnV5Y2Y1YmpYR04y?=
 =?utf-8?B?Z0lLM3FndzhlOWdlcmdGSXQza1VObkI3aDdZeE1CYW50bVJVYklITVFaNWx2?=
 =?utf-8?B?SlVFejI5SC9ZelhnUVZjRDdzeWRWMTFUTUtWei9UcHBJWlErRGZjaVgrRU5m?=
 =?utf-8?B?Ti9oQUJmMG4rZlBGZmdSRDJ0amkwRWJ4YVY2Rk9HaE9Xc0Z2TEg2cURUTkNI?=
 =?utf-8?B?b2V0S3hkM1VHLzFidXVENmxQbGhGNVZZQkU2L1RBTUhJdC9Tam9LMWFvYzNT?=
 =?utf-8?B?bC9DVFJKanZPL3psdGhGWTU1QVMrNVdyZTQ5WXZhVlJINUJLa25nS1NDMUx3?=
 =?utf-8?B?TGdBVWxSN2VoN0dVeUpUTDVVVzRXcWcyZlExM0NucktsUFh1UUhBdTdsR0g3?=
 =?utf-8?B?SURXRFBtOGZQS0dZOUJ6U1dlNlZFZndFSXY1VmRyODNkRCtjSlJuN1VHdTQ1?=
 =?utf-8?B?L1RHTmpqejJIcEplMWlnb3Zna0doTGtaeVU1QjMrYTc5RWR6ZERNZGthRkFX?=
 =?utf-8?B?d0xYVVFrcVdlZ1hFb0VmNitXNzlZemd4S1BPWWlOYmUzaXlIMXVubytNWi9q?=
 =?utf-8?B?aUtXc25aYmV2Y0p1eWhlbC9BSnRHSmxaSHNhRUZONDVnYSs4Y29sWDBCVnYz?=
 =?utf-8?B?ZFpUUmJYS3FBTG9iVnhWSkhxU0Fka1pwQ2dDamxzcWJ3WXFRNThKUDFFOWwv?=
 =?utf-8?B?cVZ4NmpDRFlJUmpwdHRwMnovVGZ2Z0pSeStIK2d5Y1FrTExFMkVMMXJNNE9a?=
 =?utf-8?B?MmhPRnhTVkNGMEdjK3ZSUGdLRUtRNXZsSTRYNlNMTkNmM3NLbzhNVjR0dmFi?=
 =?utf-8?B?c0hVTWlvSFdycGxNd0k4eDJ4b0NSZ0VEeWF3aytBSXZzUXQyUVMvbUVOSUhC?=
 =?utf-8?B?V3FMOGtGQjhCRGd3ZUlvdlVWNTl3dFQvamZFN29ScnBHQ3BLOWpibGw4VnYw?=
 =?utf-8?B?YjVqaGtCU2tFSFNmRVQzbHJYZHN2OHp3bm04Q2p2aThqT1FhM2JGRmRlZ1FG?=
 =?utf-8?B?VUN5RVhscW43OS84QnNoYXQwWnpMUVVZS2xaOTNEMUZ2dXdLcjJQZz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: cA6yAkGsifTO/VCTU76D8TSOBcwQVLh1+EOQwNlCPK/2hXQBDKkbNHPcdQ4K8XbX/hO8/v4Kn3OQKoNVVZEY1V2WiWmrT7Z3rhgyvS7sU8bbXp8R0VnDJUEpfCFCHFqbwaeTZWlxTOdpQ24SRxb55Nmxv8T7xr4iQTJcwtQmdmg0KOgbsvZgcbTR92oW6ko+H+9h2DyWF1efPJ91ndWf9Y9njxTuXDkgk/NhI+xIts2F371VcWG2GaRsXr+4oq9M9+l7kjcp4Rlg581RP57u4MsjgjXryb49WxF7lNysmajy2tkmd/e5xrrYlel3KL1NAnwudfJCHttJE5eL/IcbSg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5902.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b478f028-f7a3-452f-a591-08ded9040ddb
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jul 2026 13:07:36.8228
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YGKAW6SdWRinsAW+8z7HgVEbaxrzxxl83jSYwo8YcBH+aFn9ov6L5MxRDdq8q9ppMveBjJPhU3eaGvpNUf3nRZ73zeW+AE/r+bZ7gUFCIdU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB7119
X-OriginatorOrg: intel.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.56 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-304545-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[19];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:lukeh@padl.com,m:andrew@lunn.ch,m:olteanv@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:linux@armlinux.org.uk,m:richardcochran@gmail.com,m:f.fainelli@gmail.com,m:cedric.jehasse@gmail.com,m:mh@rme-audio.de,m:max@huntershome.org,m:kieran@sienda.com,m:Ryan.Wilkins@telosalliance.com,m:mattias.forsblad@gmail.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:ffainelli@gmail.com,m:cedricjehasse@gmail.com,m:mattiasforsblad@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[jedrzej.jagielski@intel.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[padl.com,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,armlinux.org.uk];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,lunn.ch:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,padl.com:email,intel.com:from_mime,intel.com:dkim,PH0PR11MB5902.namprd11.prod.outlook.com:mid];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jedrzej.jagielski@intel.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[gmail.com,rme-audio.de,huntershome.org,sienda.com,telosalliance.com,vger.kernel.org];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9DCC4702C0A

RnJvbTogTHVrZSBIb3dhcmQgPGx1a2VoQHBhZGwuY29tPiANClNlbnQ6IEZyaWRheSwgSnVseSAz
LCAyMDI2IDk6NDcgQU0NCg0KPkZyb206IE1hdHRpYXMgRm9yc2JsYWQgPG1hdHRpYXMuZm9yc2Js
YWRAZ21haWwuY29tPg0KPg0KPkFkZCBSTVUgZW5hYmxlIGFuZCBkaXNhYmxlIGZ1bmN0aW9uYWxp
dHkgZm9yIHNvbWUgTWFydmVsbCBTT0hPDQo+c3dpdGNoZXMuDQo+DQo+UmV2aWV3ZWQtYnk6IEFu
ZHJldyBMdW5uIDxhbmRyZXdAbHVubi5jaD4NCj5SZXZpZXdlZC1ieTogRmxvcmlhbiBGYWluZWxs
aSA8Zi5mYWluZWxsaUBnbWFpbC5jb20+DQo+U2lnbmVkLW9mZi1ieTogTWF0dGlhcyBGb3JzYmxh
ZCA8bWF0dGlhcy5mb3JzYmxhZEBnbWFpbC5jb20+DQo+U2lnbmVkLW9mZi1ieTogQW5kcmV3IEx1
bm4gPGFuZHJld0BsdW5uLmNoPg0KPi0tLQ0KDQp5b3UgdGFnIHNob3VsZCBiZSB0aGUgbGFzdCBv
bmUNCg0KPitpbnQgbXY4OGU2MDg1X2cxX3JtdV9lbmFibGUoc3RydWN0IG12ODhlNnh4eF9jaGlw
ICpjaGlwLCBpbnQgcG9ydCkNCj4rew0KPisJaW50IHZhbCA9IE1WODhFNjM1Ml9HMV9DVEwyX1JN
VV9NT0RFX0RJU0FCTEVEOw0KDQp1bmNsZWFyIGZvciBtZSB3aHkgdG8gaW5pdCBpdCBpZiBhbGwg
YWxsb3dlZCBzY2VuYXJpb3MgcHV0IHNvbWUgdmFsdWVzIGludG8gdmFsPw0KaGVyZSBhbmQgZm9y
IGZvbGxvd2luZw0KDQoNCj4rDQo+Kwlzd2l0Y2ggKHBvcnQpIHsNCj4rCWNhc2UgOToNCj4rCQl2
YWwgPSBNVjg4RTYwODVfRzFfQ1RMMl9STV9FTkFCTEU7DQo+KwkJYnJlYWs7DQo+KwljYXNlIDEw
Og0KPisJCXZhbCA9IE1WODhFNjA4NV9HMV9DVEwyX1JNX0VOQUJMRSB8IE1WODhFNjA4NV9HMV9D
VEwyX1AxMFJNOw0KPisJCWJyZWFrOw0KPisJZGVmYXVsdDoNCj4rCQlyZXR1cm4gLUVPUE5PVFNV
UFA7DQo+Kwl9DQo+Kw0KPisJcmV0dXJuIG12ODhlNnh4eF9nMV9jdGwyX21hc2soY2hpcCwgTVY4
OEU2MDg1X0cxX0NUTDJfUDEwUk0gfA0KPisJCQkJICAgICAgTVY4OEU2MDg1X0cxX0NUTDJfUk1f
RU5BQkxFLCB2YWwpOw0KPit9DQo=

