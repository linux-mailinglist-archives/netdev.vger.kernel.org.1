Return-Path: <netdev+bounces-261847-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MD/2F2ehoWnEvAQAu9opvQ
	(envelope-from <netdev+bounces-261847-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 14:51:35 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B5DF51B7E81
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 14:51:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0FA093010BB4
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 13:51:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7507426B2D2;
	Fri, 27 Feb 2026 13:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lFq5Khwy"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20665368947;
	Fri, 27 Feb 2026 13:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772200267; cv=fail; b=n0lcmb3pFrBZT6mztl3P+BuuPaCA5OrBCMQFE6w72oRanpmpeYuFdobfOfNkKsRPH9autaQpH1KwrQryBWocarAed36YqtVrnpidw7swj8rbKbdvu8igovZQbTOAQdAIDXnS9UPyLch0YxIKHrKXO5mypvZ4tsBPYpD1Iqm7QOk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772200267; c=relaxed/simple;
	bh=MGljKQLwNCGHLr5WXEbQTVjENPygOMpQ9wEVzjaGnEk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=sQOOuo61sRkLbKD4vnabIbvDyRx6UXwvRizDKB0W2IwearJz/oG8x38v6CGJSsoFgv0fBFdLLYjMOpj06B0qFnXuP6iC63DM0MN9rY+SHayAOOWjftmCaovepmSIMxUEZNpNkOqbZirbdKNphM6Kmxu4TrgUh1UpC5q5uBwyGIE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lFq5Khwy; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772200266; x=1803736266;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=MGljKQLwNCGHLr5WXEbQTVjENPygOMpQ9wEVzjaGnEk=;
  b=lFq5Khwys9zij2xFuuxkDl7LOIcLHMw/AAjK6A5Ew+iKCKkNLh8trS7c
   xFwGXpD+8PDiheh2jZEffmghETBSaW1G2jgZUTQ/a6qEpO/89bhyYn6z2
   FrHHo30yW7SOyAFLpzpmcCU+64GcUON/Fho/BnpPaeTRRIqNnfLHfm5Lq
   oSwPILFO6bxwDv2I3mFX3oQq9VH4KRE/N5jQJ9wUg/F25hbxeCWkcNUXv
   N0ywF3Xw7zI+KRErS+is0w7F9JzLivwJI7zr8JiSA3Uifgk3FSnStlaoK
   MgDb/TqcsjX5/jo16MIst7zDjuUmh/hKVUJJVnh+iAqmaBpay1dMgA4L1
   w==;
X-CSE-ConnectionGUID: ZiNVmZw5TraxPwz+7o7YcA==
X-CSE-MsgGUID: 4IuXgvsNQ+aWguKiV67f5g==
X-IronPort-AV: E=McAfee;i="6800,10657,11714"; a="90684573"
X-IronPort-AV: E=Sophos;i="6.21,314,1763452800"; 
   d="scan'208";a="90684573"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2026 05:51:05 -0800
X-CSE-ConnectionGUID: Asacu89OTfqbRlzXXMd32w==
X-CSE-MsgGUID: 7YEoBZWISpOhsKMsbtEQkg==
X-ExtLoop1: 1
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2026 05:51:05 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 27 Feb 2026 05:51:05 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 27 Feb 2026 05:51:05 -0800
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.60) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 27 Feb 2026 05:51:04 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=geY1oxDFUeAIjrfha70b3YjKgzQEue4mY0Jsnh/ue4qgwZQ2HboZ/7WfxesyQ0pc3F8MpIttGO63LvmrY0qguHjF+dEyQZux7F9vQrYcQjvN/zmvLsgXMMZcPguiILJ6sX7CDr5IY0xpyvleJyCcnJwY8aqEAiH1Mung+5gpRVzSXtgG1sI0Rg8RQJl/sysI6qHWrH0oP1aNe8dMaosfTsKhJfRgrQDQBVzMAKty4qQQkosLELcq/MFnErn8gYZoTN2PPYGon5TMpNqnYnOu0ImYWLY3L5hQzcP/ikUDpmRphipyVKpJ2SOK2P5UpfSeJI6dGQpKaXx/1lN+t9BA+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MGljKQLwNCGHLr5WXEbQTVjENPygOMpQ9wEVzjaGnEk=;
 b=XGuz9w+naQPNVhywYzGoLMrI7UTS31YirjWMrTGdw8TIGRixOnmke/5RDIN/mRPI/qQYD5HHGuIYYVBeJulp7wY9aGYiIREUOmZzswgKchImunmBClcqVcjWn+mOujNAYMR3gfv6b01pE+/5nJusltj1sgEu5mRrO/17yzuQ9iO2gkl+WBd7k40GAwQraeucnnNqle04kjMEmB2uKo5EWKNY/1OvVU1SmTFmt8sWnQyKYSULG06auPP7TQUclZVxeWSs/b0yjriHHMjKQ3Jv4MzWUHommDi6qqPWaqhpG8fwiyRfqqOPp4rtXKs/1P5NjWo5jcTB3RBx5xLqdRZN3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8985.namprd11.prod.outlook.com (2603:10b6:208:575::17)
 by CH3PR11MB7321.namprd11.prod.outlook.com (2603:10b6:610:150::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.16; Fri, 27 Feb
 2026 13:51:01 +0000
Received: from IA3PR11MB8985.namprd11.prod.outlook.com
 ([fe80::355c:96ca:a45:dd5d]) by IA3PR11MB8985.namprd11.prod.outlook.com
 ([fe80::355c:96ca:a45:dd5d%5]) with mapi id 15.20.9632.010; Fri, 27 Feb 2026
 13:51:00 +0000
From: "Romanowski, Rafal" <rafal.romanowski@intel.com>
To: "Slepecki, Jakub" <jakub.slepecki@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "michal.swiatkowski@linux.intel.com"
	<michal.swiatkowski@linux.intel.com>, "Slepecki, Jakub"
	<jakub.slepecki@intel.com>, "Loktionov, Aleksandr"
	<aleksandr.loktionov@intel.com>
Subject: RE: [Intel-wired-lan] [PATCH iwl-next v4 0/7] ice: in VEB, prevent
 "cross-vlan" traffic
Thread-Topic: [Intel-wired-lan] [PATCH iwl-next v4 0/7] ice: in VEB, prevent
 "cross-vlan" traffic
Thread-Index: AQHcle0zacp4niNaXUSkVgBEYs2+1bWWtDUQ
Date: Fri, 27 Feb 2026 13:51:00 +0000
Message-ID: <IA3PR11MB8985050DB8947781F2E2B1C08F73A@IA3PR11MB8985.namprd11.prod.outlook.com>
References: <20260204154418.1285309-1-jakub.slepecki@intel.com>
In-Reply-To: <20260204154418.1285309-1-jakub.slepecki@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8985:EE_|CH3PR11MB7321:EE_
x-ms-office365-filtering-correlation-id: 65362bc2-583b-4a45-c5b6-08de76073dd2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700021|13003099007|7053199007;
x-microsoft-antispam-message-info: zSCX63WyqrnJMp/pQyhO5lTDoHBKLPwk5fEQxGTIU7ctoExW9Axwm59DxJ9EggpN4XSQw4SE6BvbpNn936YAiKE3zX7hl0l8IpTX43xBQbHJrU5u8XwKhBPf9m6KmavNas2eau0YhCGfIr9gRUfFzyhXRkRw+HaK3WZ7Nwv56IHk/ITy6/jjap85wIdVPJwofCBm+0BlV1uqirfJD3b6tpWEX79QyNNnLg68wcmKBR6aKKJ8pyW0w3L1OAS+GbPt/H2TrPFDHFbrAGFgCPp0dXYI7fFsA7Ib6DRuR8dZRCyyxEWUIkjSFztlocW21NwKoQFoh2Ywntf2bSxDt3RGwZXY1IDsbFbs+laedyfJRTeqLSuvyR5COy4wCineADDjoHZosSIQQMjOkv+Rrr88O/Jffukjs08CyEmrYHasuoRP7WG49QuD9rl2cVihUXShfXR36+jmVo738C6N7BjKi1Tf84cw13Bkh8iDOflIOBhPZNbfl265ntna1HY0yij0G39F7N8qjUJGjKUwBi9N6GoHWuGdNb3Z2+cIiZGCCDnZHhkrPFJzQ3FIXoDyv/63Qjaxx5c3XNxgPlcMtpzJmemoU4awRv3a6Y9HNPy9zdo0see9VlKbiKebH714PEkZpKPJFIGG2Alzu6h1odQX1hTpwLRXGsk+OH9j9sbQayyiSv3dBk5U5wXrWeGPofLaBlIFiMTP/X5RNLRDJY8U55/7MuPB1b5yD2CtA7wpcqYCqOrx7fwKN8A97AXeRjQrY8JzjHmrvvTM6E/G3pgj910bsAoCR/3hTuUWdjcSc5gSCSCPSyZ69XslPgIDk5J0
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8985.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700021)(13003099007)(7053199007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Y0lwWnJRRjUzYTV5WDJZWjNGSlRNclhKa1JpMDBoU0xLUFlJcUlQVjBtVkRa?=
 =?utf-8?B?SkN5KzByS0lmMXpQRnJLTVFJOE1BY0ozWkZQUjRLYi9pcWd6eUxsYzdqTzdB?=
 =?utf-8?B?Nlcxejludlp2WURrdERlK2F6N1A1QnNNUVhycWFNekZpQ0F4REIxMU9TMWhF?=
 =?utf-8?B?NnhNLzJLcXBjaVRlSHlJbGdXTXRGcklVNi9DR2dBRkdzeUhBVFUrWVVxUXk0?=
 =?utf-8?B?bXRLR1E1bStabjZMWGF0SDYvUFhTdnNwRHVUN043bEJUSUJTMDN3Sk01NjB5?=
 =?utf-8?B?VmJXYXRFemdBNTJOdTNTd1JYQkd6WlJjcyttaXFGa3dWQWc3UlRWbWZPZWFa?=
 =?utf-8?B?R0ZxSG9BcDU1QnZUcDVXK0tpU04zUlZkVytNODlZSnN6Skd3bzFrZ1gxL0JK?=
 =?utf-8?B?b0JyUXY0MVB4cDhlUzk3UEtCYXJDd3JFbDNNb1JLUTBCNFE3TGhJNm1jQkVF?=
 =?utf-8?B?eTFrMms5aXBDOEpxV3RUVXMvUytNbnNFeWhHOTkrNzE2UjBOSHRLbXoxVms4?=
 =?utf-8?B?ZnJ4eDg4d1FQV3ZqSk05b1FRdUkzd0s5VFNzTUtrRnJEQjBzdTVhT0NLYWw0?=
 =?utf-8?B?MjdDaDFpOFlvYm9VUFNxWk1PSGxQTUNrVTdla0szVUZvNW0vdHBBTTB5eFQ4?=
 =?utf-8?B?OW1tN28yNytMMytNVUY5SE1IazcwZmRuWVpEbWU3RHRJVTJMNGNTK2lEN3Np?=
 =?utf-8?B?ZGxXdVFYdkU1WFpVSm43anRlNzlsSDFGVEQ0ZWcrTTcra1FLWmtQelViUVho?=
 =?utf-8?B?and6Tm0wQ0NQRmVXVG5ua2MzVFNMdnlCVDFEMWtCRUlyQ1NtZkJxbHF1NEJH?=
 =?utf-8?B?NnBpaElDSWJLQlN1aGlRdDNhYWtuUG5QN3BFQnBaakxTekk4UEMxQkpQUzRK?=
 =?utf-8?B?d2J5ZEtVb1dTak1lNzNnOHUyNEYwNitlcml5SjlqTU5VUHJ2ZkRacjBVWFhZ?=
 =?utf-8?B?UEdENnJOV1NlUmpZWXJTTE91alNXR0pHMGFVcW1vTzc0OUNIM0xRd0YxRVdQ?=
 =?utf-8?B?M3lCcEZyQ3hZc3JoR2Q4ZStCc2VwbzVOa3FZTDBRcHdORTNibk1hc2lVYm1r?=
 =?utf-8?B?Z096S0c0dEh2bzZBdXdGQUFhWW5OYWJ6eGI5cFVrYURwdWNobDNaNG5RSktE?=
 =?utf-8?B?czJibUlEaVZhZGl2STc1aHpWaW1nVFI5WEdoOW9TTHJZdHN6SHdwaFVhREZ3?=
 =?utf-8?B?R1NwaGlDWTBzTUczN09HcUxsUy9XaVUzYW0wWDhwdUxQc1lpL1hSTEVHdnRx?=
 =?utf-8?B?dmdWdTNTOWp3K1RSUGM5ck5ERXVwT09BM3d2cHZnajBVZFU3TnZNYkJ5bVlD?=
 =?utf-8?B?R1laR0tQV21BOTh4UmZpZ3dtY3RBaGowMDg5Z20xT3FoYk1QNTBWTmJ6RTAv?=
 =?utf-8?B?NldoQ0xsSUpSYWV3WE1KalZNSXNMZWlCRFR6cTFaTG5TTGVoQUFGSVJqa0p6?=
 =?utf-8?B?a0J3NVMyc3dUYjZ1aEdJWVFrRmtYNDRpeEkyQ2hHdlh2RDY4MEd4YU9DZkpi?=
 =?utf-8?B?TXpBSzd2RGZiWUxjWlY2WEFtRHpqMWE4NFJRWnM3dDV2M0VZTU1OMXVWQi9F?=
 =?utf-8?B?aXZsK0ovOHc0aS9yMWhDZ2l4Q2x3UzNDR0dXbjkwdGFicGI0ajM4Y09WNjd1?=
 =?utf-8?B?d1BoMFQvcU95elErbGp5Y0JtSCtGS0xmcUJ4RnRPTWlORFJEZmZJK3hYdEdL?=
 =?utf-8?B?ZXlzUXVhcUZSYktEdFZFU2dDTUdaSUJJVlJEd2xHS2kyT3h2em1ySmdxR21U?=
 =?utf-8?B?dE1yR241WVBaUEJaVTRxWnl0L2VTVzFhNm9qNEwxeXdsQit3YVFGMFppVWQ0?=
 =?utf-8?B?ZVFEN3VHeXVzNjFqNHp5YUtLWVJ1VjlMM3lBN0xoZU5PbEcwR3V2MFpzOUlO?=
 =?utf-8?B?Ty8weWQ1YXNZNDNpd2N6V0VGL2JQd3B4U2dQTVo3dDViaXpaL1A1MHdGTTE3?=
 =?utf-8?B?N1FUY0hRck54ZVNaM3UwVzZWQklQMTB5ZEZtSzlGbnZMVitxeEVwY1pJbzVq?=
 =?utf-8?B?WHFDTHNtR2dCd2lXZi9obEo3SVBSdGpHSFcxS1Z0R2dUcXRmdlkzUy9hNnZG?=
 =?utf-8?B?MWswc2N2eVJPSTRRRlo0cUkzM1IwYkc3d2dnS2l5NmFZSnJ6NklhMTg5R2hn?=
 =?utf-8?B?dnZmTnpydDRLV3gxcUM5TkFwWG94SEJ0S2ZLWklhU0Y0R21JWmh5cWVuenRw?=
 =?utf-8?B?VmFyTER6Z0t4ZEJ0em56WkpnakxEVjhFMjh2aXJXbmo1dGEyNHJZY0dzZDNG?=
 =?utf-8?B?Y0w3YWFPZlhTdFB6eXR3REZ1QWdycStUZzVxQ2RUSjgyU1pkZDRabEh4aWNk?=
 =?utf-8?B?UElmai9SamNTblNlSHQrZXhSR1BlcWNlaHRaZGNJL1U0QnpTOGhZQT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8985.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65362bc2-583b-4a45-c5b6-08de76073dd2
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2026 13:51:00.6605
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2RnIzITymnvxTMcenL7BMlsjreX5eij6Lg+/ehcsEAFXSP8da1TiqDb0s/F5hTkdInq8YQGf2hIsJi9po9FvlY5jOMGFS6LM6sn465IPZlQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7321
X-OriginatorOrg: intel.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.94 / 15.00];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-261847-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,osuosl.org:email,IA3PR11MB8985.namprd11.prod.outlook.com:mid];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rafal.romanowski@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: B5DF51B7E81
X-Rspamd-Action: no action

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBJbnRlbC13aXJlZC1sYW4gPGlu
dGVsLXdpcmVkLWxhbi1ib3VuY2VzQG9zdW9zbC5vcmc+IE9uIEJlaGFsZiBPZiBKYWt1Yg0KPiBT
bGVwZWNraQ0KPiBTZW50OiBXZWRuZXNkYXksIEZlYnJ1YXJ5IDQsIDIwMjYgMTY6NDQNCj4gVG86
IGludGVsLXdpcmVkLWxhbkBsaXN0cy5vc3Vvc2wub3JnDQo+IENjOiBsaW51eC1rZXJuZWxAdmdl
ci5rZXJuZWwub3JnOyBuZXRkZXZAdmdlci5rZXJuZWwub3JnOyBLaXRzemVsLCBQcnplbXlzbGF3
DQo+IDxwcnplbXlzbGF3LmtpdHN6ZWxAaW50ZWwuY29tPjsgTmd1eWVuLCBBbnRob255IEwNCj4g
PGFudGhvbnkubC5uZ3V5ZW5AaW50ZWwuY29tPjsgbWljaGFsLnN3aWF0a293c2tpQGxpbnV4Lmlu
dGVsLmNvbTsgU2xlcGVja2ksDQo+IEpha3ViIDxqYWt1Yi5zbGVwZWNraUBpbnRlbC5jb20+OyBM
b2t0aW9ub3YsIEFsZWtzYW5kcg0KPiA8YWxla3NhbmRyLmxva3Rpb25vdkBpbnRlbC5jb20+DQo+
IFN1YmplY3Q6IFtJbnRlbC13aXJlZC1sYW5dIFtQQVRDSCBpd2wtbmV4dCB2NCAwLzddIGljZTog
aW4gVkVCLCBwcmV2ZW50ICJjcm9zcy0NCj4gdmxhbiIgdHJhZmZpYw0KPiANCj4gQ3VycmVudGx5
LCBwYWNrZXRzIHRoYXQgbWF0Y2ggTUFDIGFkZHJlc3Mgb2YgYSBWRiB3aWxsIGJlIHNlbnQgdG8g
bG9vcGJhY2sgZXZlbg0KPiBpZiB0aGV5IHdvdWxkIGNyb3NzIFZMQU4gYm91bmRhcmllcy4gIEVm
ZmVjdGl2ZWx5LCB0aGlzIGRyb3BzIHRoZW0uDQo+IEluIHRoaXMgcGF0Y2ggc2VyaWVzLCB3ZSBh
aW0gdG8gYWRkcmVzcyB0aGlzIGJlaGF2aW91ciBieSBhZGRpbmcgTUFDLFZMQU4gdG8NCj4gY29t
cGxlbWVudCB3aGF0IE1BQy1vbmx5IGZpbHRlcnMgZG8gdG8gc2VsZWN0IHBhY2tldHMgZm9yIGxv
b3BiYWNrLg0KPiANCj4gVG8gcmVwcm9kdWNlIHRoZSBpc3N1ZSBoYXZlIGFuIEU4MTAgKCRwZmEp
IGNvbm5lY3RlZCB0byBhbm90aGVyIGFkYXB0ZXIgKCRwZmIpLA0KPiB0aGVuOg0KPiANCj4gICAg
ICMgZWNobyAyID4vc3lzL2NsYXNzL25ldC8kcGZhL2RldmljZS9zcmlvdl9udW12ZnMNCj4gICAg
ICMgaXAgbCBzZXQgJHBmYSB2ZiAwIHZsYW4gNA0KPiAgICAgIyBpcCBsIHNldCAkcGZhIHZmIDEg
dmxhbiA3DQo+ICAgICAjIGlwIGwgc2V0ICRwZmFfdmYwIG5ldG5zICRwZmFfdmYwX25ldG5zIHVw
DQo+ICAgICAjIGlwIGwgc2V0ICRwZmFfdmYxIG5ldG5zICRwZmFfdmYxX25ldG5zIHVwDQo+ICAg
ICAjIGlwIG5ldG5zIGV4ZWMgJHBmYV92ZjBfbmV0bnMgaXAgYSBhZGQgMTAuMC4wLjEvMjQgZGV2
ICRwZmFfdmYwDQo+ICAgICAjIGlwIG5ldG5zIGV4ZWMgJHBmYV92ZjFfbmV0bnMgaXAgYSBhZGQg
MTAuMC4wLjIvMjQgZGV2ICRwZmFfdmYxDQo+IA0KPiBBbmQgZm9yIHRoZSAkcGZiOg0KPiANCj4g
ICAgICMgZWNobyAyID4vc3lzL2NsYXNzL25ldC8kcGZiL2RldmljZS9zcmlvdl9udW12ZnMNCj4g
ICAgICMgaXAgbCBzZXQgJHBmYiB2ZiAwIHRydXN0IG9uIHNwb29mIG9mZiB2bGFuIDQNCj4gICAg
ICMgaXAgbCBzZXQgJHBmYiB2ZiAxIHRydXN0IG9uIHNwb29mIG9mZiB2bGFuIDcNCj4gICAgICMg
aXAgbCBhZGQgJGJyIHR5cGUgYnJpZGdlDQo+ICAgICAjIGlwIGwgc2V0ICRwZmJfdmYwIG1hc3Rl
ciAkYnIgdXANCj4gICAgICMgaXAgbCBzZXQgJHBmYl92ZjEgbWFzdGVyICRiciB1cA0KPiAgICAg
IyBpcCBsIHNldCAkYnIgdXANCj4gDQo+IFdlIGV4cGVjdCAkcGZhX3ZmMCB0byBiZSBhYmxlIHRv
IHJlYWNoICRwZmFfdmYxIHRocm91Z2ggdGhlICRiciBvbiB0aGUgbGluaw0KPiBwYXJ0bmVyLiAg
SW5zdGVhZCwgQVJQIGlzIHVuYWJsZSB0byByZXNvbHZlIDEwLjAuMC4yLzI0Lg0KPiBBUlAgcmVx
dWVzdCBpcyBmaW5lIGJlY2F1c2UgaXQncyBicm9hZGNhc3RkIGFuZCBib3VuY2VzIG9mZiAkYnIs
IGJ1dCBBUlAgcmVwbHkgaXMNCj4gc3R1Y2sgaW4gdGhlIGludGVybmFsIHN3aXRjaCBiZWNhdXNl
IHRoZSBkZXN0aW5hdGlvbiBNQUMgbWF0Y2hlcyAkcGZhX3ZmMCBhbmQNCj4gZmlsdGVyIHJlc3Ry
aWN0cyBpdCB0byB0aGUgbG9vcGJhY2suDQo+IA0KPiBJbiB0ZXN0aW5nIEkgdXNlZDogaXAgdXRp
bGl0eSwgaXByb3V0ZTItNi4xLjAsIGxpYmJwZiAxLjMuMA0KPiANCj4gQ2hhbmdlcyBpbiB2NDoN
Cj4gICAtIFJlbW92ZWQgImljZTogZG8gbm90IGNoZWNrIGZvciB6ZXJvIG1hYyB3aGVuIGNyZWF0
aW5nIG1hYyBmaWx0ZXJzIg0KPiAgICAgcGF0Y2guDQo+IA0KPiBDaGFuZ2VzIGluIHYzOg0KPiAg
IC0gSW1wcm92ZSBzdHJ1Y3R1cmUgb2YgcmVwcm9kdWN0aW9uIGRlc2NyaXB0aW9uIGluIGNvdmVy
IGxldHRlci4NCj4gICAtIExCX0xBTiBtYXNrcyBhbmQgdmFsdWVzIG5vIGxvbmdlciByZWx5IG9u
IGJvb2xlYW4gcHJvbW90aW9uLg0KPiAgIC0gaWNlX2ZpbGxfc3dfaW5mbygpIGRlYWxzIHdpdGgg
dTggdGhlIGVudGlyZSB0aW1lIGluc3RlYWQgb2YgYnVpbGRpbmcNCj4gICAgIGJ1aWxkaW5nIGxi
X2VuIGFuZCBsYW5fZW4gdmFsdWVzIGF0IHRoZSBlbmQgZnJvbSBib29sZWFucy4NCj4gICAtIFJl
ZmVyIHRvIHJlcHJvZHVjdGlvbiBpbiBjb3ZlciBsZXR0ZXIgaW4gY3VycmVudCA0LzcuDQo+ICAg
LSBGaXhlZCBzb21lIHNsaXAtdXBzICJ0aGlzIHBhdGNoIiBhbmQgInRoaXMgY29tbWl0IiBpbiBj
b21taXQNCj4gICAgIG1lc3NhZ2VzIGFjcm9zcyB0aGUgc2VyaWVzLiAgSSBkaWQgbm90IGNvbnNp
ZGVyIHRoaXMgY2hhbmdlIGZvcg0KPiAgICAgcmV2aWV3ZWQtYnkgZHJvcC4NCj4gDQo+IENoYW5n
ZXMgaW4gdjI6DQo+ICAgLSBVc2UgRklFTERfR0VUIGV0IGFsLiB3aGVuIGhhbmRsaW5nIGZpLmxi
X2VuIGFuZCBmaS5sYW5fZW4uDQo+ICAgLSBSZW5hbWUgL0xCX0xBTi8gcy9fTUFTSy9fTS8gYmVj
YXVzZSBvbmUgb2YgdXNlcyB3b3VsZCBuZWVkIHRvIGJyZWFrDQo+ICAgICBsaW5lLg0KPiAgIC0g
Q2xvc2Ugb3BlbiBwYXJlbnRoZXNpcyBpbiBpY2VfdnNpX3VwZGF0ZV9icmlkZ2VfbW9kZSgpIGRl
c2NyaXB0aW9uLg0KPiAgIC0gRXhwbGFpbiByZXR1cm5zIGluIGljZV92c2lfdXBkYXRlX2JyaWRn
ZV9tb2RlKCkuDQo+IA0KPiB2MzogaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvaW50ZWwtd2lyZWQt
bGFuLzIwMjYwMTIwMTAzNDQwLjg5MjMyNi0xLQ0KPiBqYWt1Yi5zbGVwZWNraUBpbnRlbC5jb20v
VC8NCj4gdjI6IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2ludGVsLXdpcmVkLWxhbi8yMDI1MTEy
NTA4MzQ1Ni4yODgyMi0xLQ0KPiBqYWt1Yi5zbGVwZWNraUBpbnRlbC5jb20vVC8NCj4gdjE6IGh0
dHBzOi8vbG9yZS5rZXJuZWwub3JnL2ludGVsLXdpcmVkLWxhbi8yMDI1MTEyMDE2MjgxMy4zNzk0
Mi0xLQ0KPiBqYWt1Yi5zbGVwZWNraUBpbnRlbC5jb20vVC8NCj4gDQo+IEpha3ViIFNsZXBlY2tp
ICg2KToNCj4gICBpY2U6IGluIGR2bSwgdXNlIG91dGVyIFZMQU4gaW4gTUFDLFZMQU4gbG9va3Vw
DQo+ICAgaWNlOiBhbGxvdyBjcmVhdGluZyBtYWMsdmxhbiBmaWx0ZXJzIGFsb25nIG1hYyBmaWx0
ZXJzDQo+ICAgaWNlOiBhbGxvdyBvdmVycmlkaW5nIGxhbl9lbiwgbGJfZW4gaW4gc3dpdGNoDQo+
ICAgaWNlOiB1cGRhdGUgbWFjLHZsYW4gcnVsZXMgd2hlbiB0b2dnbGluZyBiZXR3ZWVuIFZFQiBh
bmQgVkVQQQ0KPiAgIGljZTogYWRkIGZ1bmN0aW9ucyB0byBxdWVyeSBmb3IgdnNpJ3MgcHZpZHMN
Cj4gICBpY2U6IGluIFZFQiwgcHJldmVudCAiY3Jvc3MtdmxhbiIgdHJhZmZpYyBmcm9tIGhpdHRp
bmcgbG9vcGJhY2sNCj4gDQo+IE1pY2hhbCBTd2lhdGtvd3NraSAoMSk6DQo+ICAgaWNlOiBhZGQg
bWFjIHZsYW4gdG8gZmlsdGVyIEFQSQ0KPiANCj4gIGRyaXZlcnMvbmV0L2V0aGVybmV0L2ludGVs
L2ljZS9pY2VfZmx0ci5jICAgICAgfCAgMTA0ICsrKysrKysrKysrKysrLQ0KPiAgZHJpdmVycy9u
ZXQvZXRoZXJuZXQvaW50ZWwvaWNlL2ljZV9mbHRyLmggICAgICB8ICAgMTAgKw0KPiAgZHJpdmVy
cy9uZXQvZXRoZXJuZXQvaW50ZWwvaWNlL2ljZV9saWIuYyAgICAgICB8ICAgNTYgKysrKysrKysN
Cj4gIGRyaXZlcnMvbmV0L2V0aGVybmV0L2ludGVsL2ljZS9pY2VfbGliLmggICAgICAgfCAgICAy
DQo+ICBkcml2ZXJzL25ldC9ldGhlcm5ldC9pbnRlbC9pY2UvaWNlX21haW4uYyAgICAgIHwgICA1
NiArKysrKystLQ0KPiAgZHJpdmVycy9uZXQvZXRoZXJuZXQvaW50ZWwvaWNlL2ljZV9zd2l0Y2gu
YyAgICB8ICAgODMgKysrKysrKystLS0NCj4gIGRyaXZlcnMvbmV0L2V0aGVybmV0L2ludGVsL2lj
ZS9pY2Vfc3dpdGNoLmggICAgfCAgIDI0ICsrLQ0KPiAgZHJpdmVycy9uZXQvZXRoZXJuZXQvaW50
ZWwvaWNlL2ljZV92Zl9saWIuYyAgICB8ICAgIDggLQ0KPiAgZHJpdmVycy9uZXQvZXRoZXJuZXQv
aW50ZWwvaWNlL2ljZV92bGFuX21vZGUuYyB8ICAgMTIgKw0KPiAgOSBmaWxlcyBjaGFuZ2VkLCAz
MDYgaW5zZXJ0aW9ucygrKSwgNDkgZGVsZXRpb25zKC0pDQo+IA0KPiAtLQ0KPiAyLjQzLjANCg0K
VGVzdGVkLWJ5OiBSYWZhbCBSb21hbm93c2tpIDxyYWZhbC5yb21hbm93c2tpQGludGVsLmNvbT4N
Cg0K

