Return-Path: <netdev+bounces-298063-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id tZCgK72HKmpcrwMAu9opvQ
	(envelope-from <netdev+bounces-298063-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 12:02:37 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BF6E5670A82
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 12:02:36 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=L9yhHHyB;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298063-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-298063-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0E184303CC54
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 10:02:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A50173CA4AD;
	Thu, 11 Jun 2026 10:02:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 042A33CB2DA;
	Thu, 11 Jun 2026 10:02:04 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781172127; cv=fail; b=qiAQIKVZgmGp++tytQx723yqbtLTmAzeM1yOC4N1yipu4mF4YZhTo+GU1EzHEfrg7wsKiA2fy0AzTGPKnD/myjTfESBEan0C7YzwhdBjbrHp/rXw65f9sK2wAq7BTRCalrSxQvZWtpHt/vYdBFJQprnrdmiJmWJ1hkvLtr60a6E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781172127; c=relaxed/simple;
	bh=JJapscJ0Ylf8i+TSVjy4g8hJ4p3+eVNzbAFHOpU1dzI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gWQs3/IGQjZpSgPWmkaQgdNmHXf6EP2ZpVLfaVg/DRnQb/jiGHZ89PN4jQ0DUxNULESQZi/F1Phe8pJUq4rhWjcj5VMqJgQwvlg94ciGGXAcFaIumiNT7zEhjxhKPnaQq/ZRPbzVHP6sdk7m8y4hXAEY8fC9UnaKQfGwdf+/Ito=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=L9yhHHyB; arc=fail smtp.client-ip=198.175.65.17
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781172126; x=1812708126;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=JJapscJ0Ylf8i+TSVjy4g8hJ4p3+eVNzbAFHOpU1dzI=;
  b=L9yhHHyB6gYYxEizt6lHozvDkE0QqWdHk35i7a8YzJ77FEFlLAFkGNqV
   +woXv1JWT2CayWk4nJjtCzd+sti2i1Y7qZwIqRXp4CApjRoX0wO+gHQ4c
   LqOQ29Xm6H6R6z54GfBMET9w9RmjAKZo26mP+roOtfgei3gFpqIFtubie
   IfjhT4AKcQ3Eqfarc78g9xGPDr/PeSnBS26pd/oilB5qE2sXsHT7OK1P7
   HoDCC3bW42eNnYOkJ7OHM2qj4bW67Lyl9saZxvMjwlPq+rw/adJku51RN
   W81P9uCndr2mOcGPoWUmWMTvIdwR5bevS8/0ZNV/Rs2cnsVQT2Fu6PDZg
   A==;
X-CSE-ConnectionGUID: pf2SCfd/SGyBbI+k6oKMmg==
X-CSE-MsgGUID: 4kLdCYBoQAqc1tNZyiEAHw==
X-IronPort-AV: E=McAfee;i="6800,10657,11813"; a="81986386"
X-IronPort-AV: E=Sophos;i="6.24,198,1774335600"; 
   d="scan'208";a="81986386"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2026 03:02:05 -0700
X-CSE-ConnectionGUID: dE7udHqsQx224E/negNftg==
X-CSE-MsgGUID: fkogibYwR8C6Z5kvBCnrzA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,198,1774335600"; 
   d="scan'208";a="246513796"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2026 03:02:04 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 11 Jun 2026 03:02:02 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 11 Jun 2026 03:02:02 -0700
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.8) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 11 Jun 2026 03:01:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cSnR8OMr7lND90cx3VELXumZxbk3nfPr3uS9Z22E1mdthWI3jbi6GUuQ2O2G3fA7LOG/JetdqyRopXWoFso0Mjq4eAfV0FltnL0x3lbY0qIzNmR+j7tj1UTDfFio2EhxkndJY9T5wDEgokmKtikDehGNyK7dXTSIECNkAEev5G1wR7j4I9YnK5WBo2/i10I6ws8eYcM0UxIZy5931RBrrWQP93AV0CXrOpHG9dPaItQ4IQ4sdKKYZPhn8f6NSg/Yi/bc2jAuiGTzgKgKLfKRy/ofT8ujHgT10OgO4HWq5qms7O1vBcykS7uPtNrfHZW36oIcfk9wwdbhQxyOohukGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JJapscJ0Ylf8i+TSVjy4g8hJ4p3+eVNzbAFHOpU1dzI=;
 b=qbRYL8y11hfn5AGyzmW1tvsTBC5N7qzB2L7Q0IKrbCVOGCwcR3RRcJDDklEbvHnMW43mZUQAXS32T+NzNCaV7Q489XusPaCVE80nnn4hkgFyOBjH88HXI0sQeRYSvmJGUhNkWYgn8/BH/0JUayZnak5fCcSYTsp29aqCNi6Xdoo83qe28mldfy5zsbCnSVvbPxXBXOOpKxvbDnkjJ9RkV0hU839i4HrXjbj/HuAJb9A+WUXNUSfq2oIXakAs+UUj/mLUrdevPxtWiOErK4gSld/l2NZAJy2IfUZaaFush9Y7cabfoIpmZpkPVIu2I+7MTJt9coYribCY5l2nTmQxSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB6219.namprd11.prod.outlook.com (2603:10b6:208:3e9::15)
 by CY5PR11MB6137.namprd11.prod.outlook.com (2603:10b6:930:2b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.13; Thu, 11 Jun
 2026 10:01:21 +0000
Received: from IA1PR11MB6219.namprd11.prod.outlook.com
 ([fe80::a2b9:8e8:c48b:ea31]) by IA1PR11MB6219.namprd11.prod.outlook.com
 ([fe80::a2b9:8e8:c48b:ea31%5]) with mapi id 15.21.0092.011; Thu, 11 Jun 2026
 10:01:21 +0000
From: "Nitka, Grzegorz" <grzegorz.nitka@intel.com>
To: Paolo Abeni <pabeni@redhat.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>, "Oros,
 Petr" <poros@redhat.com>, "richardcochran@gmail.com"
	<richardcochran@gmail.com>, "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "Prathosh.Satish@microchip.com"
	<Prathosh.Satish@microchip.com>, "Vecera, Ivan" <ivecera@redhat.com>,
	"jiri@resnulli.us" <jiri@resnulli.us>, "Kubalewski, Arkadiusz"
	<arkadiusz.kubalewski@intel.com>, "vadim.fedorenko@linux.dev"
	<vadim.fedorenko@linux.dev>, "donald.hunter@gmail.com"
	<donald.hunter@gmail.com>, "horms@kernel.org" <horms@kernel.org>,
	"kuba@kernel.org" <kuba@kernel.org>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>
Subject: RE: [PATCH v14 net-next 03/13] dpll: fix stale iteration in
 dpll_pin_on_pin_unregister()
Thread-Topic: [PATCH v14 net-next 03/13] dpll: fix stale iteration in
 dpll_pin_on_pin_unregister()
Thread-Index: AQHc9qxzOSWGh7NPvUubHfjHiXtPNrY5EVeAgAAM3xA=
Date: Thu, 11 Jun 2026 10:01:21 +0000
Message-ID: <IA1PR11MB6219E71E2581AE3A4C91F870921B2@IA1PR11MB6219.namprd11.prod.outlook.com>
References: <20260607183045.1213735-1-grzegorz.nitka@intel.com>
 <20260607183045.1213735-4-grzegorz.nitka@intel.com>
 <5ad977af-9bbb-4376-b0a6-2b1867223145@redhat.com>
In-Reply-To: <5ad977af-9bbb-4376-b0a6-2b1867223145@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB6219:EE_|CY5PR11MB6137:EE_
x-ms-office365-filtering-correlation-id: ff7569f9-5378-4000-4bb2-08dec7a06380
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024|23010399003|4143699003|6133799003|11063799006|56012099006|5023799004|22082099003|38070700021|18002099003;
x-microsoft-antispam-message-info: hwonu4b6xaLEZqbXPQf4cimJdMRyX44heO3ju/gSUt+d68fwKBVvy7PDEmxzVpPgRzpYGGL7z3ivAplcnqq5pccv3G9CWitGYnm00x8QPRfFsTqEf84wD/THeRTk0JgMdZWuuRisT9MwqRjYcuvgXDFWgsUirUid7xYYi13jrepWOaLH7OgwJ4EOcGFUndIZN1P5cDdNCxS+2N2/n/3QfCh+PtJ+e+SrmXcXlTFr6nffQDjTjTvShqI5BBy2jxZMNgIgyyOcmpMDs19Q+24ItDHrQhQnmfsWXOBo8k0H9zhsebuLK/TTjaumLyFAlJHHOvO0uFbI4pL3Mo6sW1k668i8d8EaJGpExbza80Fn2r9T5CuNBdnU34d6w9PzlO7Dn/qXC1DxfpvXGYbv6vDqJkzZ2h6NgBgs2j1SKSp6hIO1H2jOKcRj/hr1k1l+p5ywLtFEMweGmBrRpD8bra3FXuBy6OzFE7xl9aU1csYC4p7khcaqbraFRcoyHSmwsbHOAanoHfnq7+uo0LX6dDU7XM+eHV1tsWw/ZYA7276pweI2qqfAm82yV+f/y1RBW9tdFtjZdsbOumxIDxgT1RGQUaj4TT+x4hPhzO+3MSKMqVTJIYDFWdYpYmL6wfHvCeXMdNBLegBgi8+UFmMRFwVpCNEBAmquka2HGriMWgT5bjm8UWlsO4SuR+y1W5pUMM8seP39dSpYr2pcMBcnAlPaCg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6219.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(23010399003)(4143699003)(6133799003)(11063799006)(56012099006)(5023799004)(22082099003)(38070700021)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Uk5iNy9EUFZ6c09nejBNQnhLVFlEUDBhOXlnVHFCWVhuZWFncXVvdHpaVWtr?=
 =?utf-8?B?YXpTaVlUSHZuZThBeG5XZW5zZExaQmxaYldiall2eElkWEdNNmZPaVlxQWY3?=
 =?utf-8?B?eDBXZU1venFhVncydEZxWXl0b2VTL0NGbC83STRnSXI3elkzU0VVV0FtTFFv?=
 =?utf-8?B?TEwvTk8wckxDeEdHVXZqdUErdmp5aEhoSTJ2TmhaSTBnUjRiQkZZWTE2aFNl?=
 =?utf-8?B?ZUswMFB2a2o3K0pKUW9CSU5MdUMxeXREMGo5bktETTByTGFETnFMUkYwMkVx?=
 =?utf-8?B?TkcrRld0b1BvblA0RitONGlNT3FNbjZmZ0VobXk4Mmk1UnlrOVBDaWExeGl3?=
 =?utf-8?B?T2RRaFppYXRXYlM4bVpZcDZNbVhkNFBqdGIrN1NFV3IrYnpaWWNTNTJnUXpH?=
 =?utf-8?B?aDdjYXNxajBqMXJsbFNyVTFXZnVWTUF2QzZqaVM3YTNMM0t3bHl2cDhuU0pH?=
 =?utf-8?B?R01SWGZ6WWdQQnVuWC8yQTZTd3JreG9Ga24wa1plMmtZS1FDdzU4eWFaY1JZ?=
 =?utf-8?B?cW1oN0NveUpIaU11MUJhQXd3NlJSajV6SU1OaUpKcFZYVDQvdGNVSHBCKzRU?=
 =?utf-8?B?TXU0Vk5FeW4xU3BmNEVBM1RkVGoxZ2EydFZwMGE0SC9xeGNNNWwzc1FoR05B?=
 =?utf-8?B?RHZFc0NRSXFlVWM3U2djQVBMdkJKekhlOUNoVi92Q3FYUUNEQ1RvcWNSaFBM?=
 =?utf-8?B?a1Y1Q3dxZkpFL1VvMW1YNmhQY3dZQk5tYlFIQ2QzakNTNVNNTlVMRURuTnRa?=
 =?utf-8?B?M1k1bjZpQTRDcWdQR0p4dUVrWE83empGM2o3bXJuYUN6aWhYcVVjSk5iUlRZ?=
 =?utf-8?B?TEIwZXpJb3lneGw0TnI5aFZjVXpiWUtUNVczK0lKckpUNDFpVDVsYURPTE1j?=
 =?utf-8?B?UXR4NVNmV1BZazlaeTAvTUVldjNEY2FuSUlreTAzSEUyVW1sSUhZbjhlQjhY?=
 =?utf-8?B?SzFzNWJseVphbUVWT3h5YS91MTVKOUEyMmdYKzFOcjlrZ1hSMFY0VUdCeGUy?=
 =?utf-8?B?NzQrbTU2OEhDMFBUWjlJU3ZoemhqbVZLc3lla2poMDk4OVZsTVVhdjZZb1Rp?=
 =?utf-8?B?bVJMS2RzM1F2RHd4L0FHNG5MRTBwYVIxSjFPeHVSNmhQeUsva3NBR2lJbElv?=
 =?utf-8?B?aEpxUU5qVmxTWVpsR1B0NktYVXhXMkR0K1Q5V0VJdC9xd0owRzdEVjBTY3Qv?=
 =?utf-8?B?ZnVCZHRZcStnZi9xU0daRSsraUE2VXlIckRJc1FHN2tXNERtbDI4ZWlTQnh4?=
 =?utf-8?B?NjBTRmIyeG9LQWk3aHNNWTZFenhzaHhGWU0xdDJWNllmZVU2SlpzVnI5eDJK?=
 =?utf-8?B?TE1OUzdCWDdOSHExa3BnSE1KZThVb1lqbmVueXRncmRILzluaDJzdWpkODVq?=
 =?utf-8?B?QmxLWDE5YzFyVE9pRW40d3lnaVA2WkpjcnZLb3FhbXcrS1hxOStnb0MxZ3Jl?=
 =?utf-8?B?VlVpZTFuNXFjeGNNUUswb3pobjdmeDh6c1BwcldvWVYvTm9vd2djQVZWRGRK?=
 =?utf-8?B?VmtJeHk2djZpa1lsNldkN0FUUUJ0MjFDZi8zUkpyNDQxanh6bERpZGczb1Mw?=
 =?utf-8?B?SXJtc2xCWTF1VCtjQ3ZKZTJlNlJRMkIrNFQyRW83UUpZRWFYMmNYdWlFM2lK?=
 =?utf-8?B?UXAzdFhldjUwcWdFWEJsY1F2N1pra0tkTHg4bnNJK3MvMWZMdGZGSXdxSzNT?=
 =?utf-8?B?M2h5UnExNVRCQWg2Z3J1SVRmRldLZ3M0TjRaa2RDcFdObFRlQ09ndGVjTjlp?=
 =?utf-8?B?UkVOSDE2RVJrNFpVYnA1QXlkU2FVcVpaODdkaEhKdWdMZi80V0xpQlcwVERJ?=
 =?utf-8?B?UndMMncrc1Q2SnpBL0lqSE0zcW91UmRURHNGeWs1NkdKRWJvemdpZWQwL2Nq?=
 =?utf-8?B?OG9lak9Kd3VZVC9Vcjkrd3p1WU1VRjNlampzdllIK010MzhadUZPcnNkZWUr?=
 =?utf-8?B?RGcxUHhabTd3MEUwNWM2eS9qTmw2SFJXV0NXaVdYVHFEWllaWk1mbEZpSkJR?=
 =?utf-8?B?eUNxTjNOMnpiVEE1TW80dDB2WVhaVW1pRnZza1VPQXJGQWZXaXRQcEpqN1ht?=
 =?utf-8?B?UjlFaWRIalMycXJmSzJGUjZEMy90WVVuVXg4YkZnakRieGI5VjRBbE4wVG41?=
 =?utf-8?B?YjZmNmJMWlp4T3FRV1QrNmdGN0V2SExvSDdsZDFxTmJ6YWJqcHZqTmx0b2Fl?=
 =?utf-8?B?dWQ1c1JYWjVuNGZ3bzNRWm9GQmJ6Y2ptV01TQllGSC9jSytxNEdkK2l3TjJ2?=
 =?utf-8?B?SndoK3ZlVk9uVXpRTXRQRG9yaVQ2TWdieTZUVEgxTHJrRnJEREJyNjRkSUkw?=
 =?utf-8?B?TzgwczJRTE5mN3dYTXc1TFQ0SGlrYVU3Wnc3bVZOUVVTL0dDZXlMQT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: Uba5bEu3wXIz0HZIg5E+va1l2Fp2xy7il/S8T1TTZLgu++4yg8SSftIPs5gVvm6ouAJ6LNCGlx3qaihzZcSd50RWWpEdVpD+m3wr6Ro6/tiZyuFeNLh4LV5/x6rL/AzNX5MzYcSo7Pk0TI9HWI6rI3Q8v+VcCVkYphKRm5zVvHqVft3AcghbhnnEkgAwb42kiWSleD51p/DmAaihvs2GQuPH1tKro7vfzetw6gcKBmRzYEtsdfY7ZyGvDt1rwnurtz93T8NYJVy2PudyWF9gLnW7nVYb1Feb64CedCa06cRBuMJxddAcHRmQCL3WiXUD3TmSjMuCrxAigc+lm29nhw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6219.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff7569f9-5378-4000-4bb2-08dec7a06380
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jun 2026 10:01:21.1178
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vBBNSlPocyYAM0Gx7EM7PMgVCNuWUSW4cUUTt22tttkOiHyINZSOsRYax4r1Xb3ju9DrUY7YISupa49OmbEmEybKGwOajGrsOebryg8EFJg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6137
X-OriginatorOrg: intel.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.56 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-298063-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[19];
	FORGED_SENDER(0.00)[grzegorz.nitka@intel.com,netdev@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:intel-wired-lan@lists.osuosl.org,m:poros@redhat.com,m:richardcochran@gmail.com,m:andrew+netdev@lunn.ch,m:przemyslaw.kitszel@intel.com,m:anthony.l.nguyen@intel.com,m:Prathosh.Satish@microchip.com,m:ivecera@redhat.com,m:jiri@resnulli.us,m:arkadiusz.kubalewski@intel.com,m:vadim.fedorenko@linux.dev,m:donald.hunter@gmail.com,m:horms@kernel.org,m:kuba@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:andrew@lunn.ch,m:donaldhunter@gmail.com,s:lists@lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[grzegorz.nitka@intel.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.osuosl.org,redhat.com,gmail.com,lunn.ch,intel.com,microchip.com,resnulli.us,linux.dev,kernel.org,davemloft.net,google.com];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BF6E5670A82

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUGFvbG8gQWJlbmkgPHBh
YmVuaUByZWRoYXQuY29tPg0KPiBTZW50OiBUaHVyc2RheSwgSnVuZSAxMSwgMjAyNiAxMDo1MCBB
TQ0KPiBUbzogTml0a2EsIEdyemVnb3J6IDxncnplZ29yei5uaXRrYUBpbnRlbC5jb20+OyBuZXRk
ZXZAdmdlci5rZXJuZWwub3JnDQo+IENjOiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBp
bnRlbC13aXJlZC1sYW5AbGlzdHMub3N1b3NsLm9yZzsgT3JvcywgUGV0cg0KPiA8cG9yb3NAcmVk
aGF0LmNvbT47IHJpY2hhcmRjb2NocmFuQGdtYWlsLmNvbTsNCj4gYW5kcmV3K25ldGRldkBsdW5u
LmNoOyBLaXRzemVsLCBQcnplbXlzbGF3DQo+IDxwcnplbXlzbGF3LmtpdHN6ZWxAaW50ZWwuY29t
PjsgTmd1eWVuLCBBbnRob255IEwNCj4gPGFudGhvbnkubC5uZ3V5ZW5AaW50ZWwuY29tPjsgUHJh
dGhvc2guU2F0aXNoQG1pY3JvY2hpcC5jb207IFZlY2VyYSwNCj4gSXZhbiA8aXZlY2VyYUByZWRo
YXQuY29tPjsgamlyaUByZXNudWxsaS51czsgS3ViYWxld3NraSwgQXJrYWRpdXN6DQo+IDxhcmth
ZGl1c3oua3ViYWxld3NraUBpbnRlbC5jb20+OyB2YWRpbS5mZWRvcmVua29AbGludXguZGV2Ow0K
PiBkb25hbGQuaHVudGVyQGdtYWlsLmNvbTsgaG9ybXNAa2VybmVsLm9yZzsga3ViYUBrZXJuZWwu
b3JnOw0KPiBkYXZlbUBkYXZlbWxvZnQubmV0OyBlZHVtYXpldEBnb29nbGUuY29tDQo+IFN1Ympl
Y3Q6IFJlOiBbUEFUQ0ggdjE0IG5ldC1uZXh0IDAzLzEzXSBkcGxsOiBmaXggc3RhbGUgaXRlcmF0
aW9uIGluDQo+IGRwbGxfcGluX29uX3Bpbl91bnJlZ2lzdGVyKCkNCj4gDQo+IE9uIDYvNy8yNiA4
OjMwIFBNLCBHcnplZ29yeiBOaXRrYSB3cm90ZToNCj4gPiBOZWl0aGVyIHBhcmVudC0+ZHBsbF9y
ZWZzIG5vciBwaW4tPmRwbGxfcmVmcyBvbiBpdHMgb3duIGlzIGEgY29ycmVjdA0KPiA+IGl0ZXJh
dGlvbiB0YXJnZXQgYXQgdW5yZWdpc3RlciB0aW1lOg0KPiA+DQo+ID4gICAtIHBpbi0+ZHBsbF9y
ZWZzIGluY2x1ZGVzIERQTExzIHRoZSBjaGlsZCB3YXMgcmVnaXN0ZXJlZCBhZ2FpbnN0DQo+ID4g
ICAgIHZpYSBhIGRpZmZlcmVudCBwYXJlbnQgb3IgZGlyZWN0bHk7IGJsaW5kIHVucmVnaXN0ZXIg
V0FSTnMgb24NCj4gPiAgICAgdGhlIGNvb2tpZSBtaXNzIGluIGRwbGxfeGFfcmVmX3Bpbl9kZWwo
KS4NCj4gPiAgIC0gcGFyZW50LT5kcGxsX3JlZnMgcmVmbGVjdHMgdGhlIHBhcmVudCdzIGN1cnJl
bnQgYXR0YWNobWVudHMsIG5vdA0KPiA+ICAgICB0aG9zZSBhdCBjaGlsZC1yZWdpc3RlciB0aW1l
LiBBbm90aGVyIGRyaXZlciBtYXkgaGF2ZSAodW4pcmVnJ2QNCj4gPiAgICAgdGhlIHBhcmVudCBh
Z2FpbnN0IGFkZGl0aW9uYWwgRFBMTHMgaW4gdGhlIG1lYW50aW1lLCBzbyB3ZSBtaXNzDQo+ID4g
ICAgIHJlZ2lzdHJhdGlvbnMgdGhhdCBleGlzdCBhbmQgdmlzaXQgRFBMTHMgdGhhdCBoYXZlIG5v
bmUuDQo+ID4NCj4gPiBXYWxrIHBpbi0+ZHBsbF9yZWZzIGFuZCB1c2UgZHBsbF9waW5fcmVnaXN0
cmF0aW9uX2ZpbmQoKSB0byBmaWx0ZXINCj4gPiB0byBlbnRyaWVzIHdob3NlIGNvb2tpZSBpcyB0
aGlzIHBhcmVudC4gU3ltbWV0cmljIHdpdGgNCj4gPiBkcGxsX3Bpbl9vbl9waW5fcmVnaXN0ZXIo
KSwgY29ycmVjdCB1bmRlciBhbnkgc3Vic2VxdWVudCBjaGFuZ2UgdG8NCj4gPiBwYXJlbnQtPmRw
bGxfcmVmcy4NCj4gPg0KPiA+IEZpeGVzOiA5NDMxMDYzYWQzMjMgKCJkcGxsOiBjb3JlOiBBZGQg
RFBMTCBmcmFtZXdvcmsgYmFzZSBmdW5jdGlvbnMiKQ0KPiA+IFNpZ25lZC1vZmYtYnk6IEdyemVn
b3J6IE5pdGthIDxncnplZ29yei5uaXRrYUBpbnRlbC5jb20+DQo+IA0KPiBUaGUgY3VycmVudCBn
dWlkYW5jZSBpcyB0byBhdm9pZCB0aGUgRml4ZXMgdGFnIGZvciBuZXQtbmV4dCBwYXRjaGVzLA0K
PiB3aGVuIHN1Y2ggdGFnIHJlZmVycyB0byBjb2RlIGFscmVhZHkgaW50byBMaW51cydzIHRyZWUu
DQo+IA0KPiBJZiBpdCdzIGEgcmVhbCB1c2VyLXZpc2libGUgaXNzdWUsIHRoZSBwYXRjaCBzaG91
bGQgdGFyZ2V0IG5ldC4NCj4gT3RoZXJ3aXNlIGlmIHRoZSBpbnRlbmRlZCB0YXJnZXQgaXMgcmVh
bGx5IG5ldC1uZXh0LCBubyBmaXhlcyB0YWcgcGxlYXNlLg0KPiANCj4gVW5yZWxhdGVkIGltcG9y
dGFudCBub2RlOiBzYXNoaWtvIChnZW1pbmkpIHN0aWxsIGhhcyBzb21lIGNvbW1lbnRzLCBzb21l
DQo+IG9mIHRoZW0gbG9va3MgbmV3IGFuZCByZWxldmFudCB0byBtZSBpLmUuIHRoZSBwb3NzaWJs
ZSBkaXZpZGUgYnkgemVybw0KPiBidWcgaW4gcGF0Y2ggMTEsIHNlZToNCj4gDQo+IGh0dHBzOi8v
c2FzaGlrby5kZXYvIy9wYXRjaHNldC8yMDI2MDYwNzE4MzA0NS4xMjEzNzM1LTEtDQo+IGdyemVn
b3J6Lm5pdGthJTQwaW50ZWwuY29tDQo+IA0KPiAvUA0KDQpIaSBQYW9sbw0KDQpUaGFua3MgZm9y
IHlvdXIgZmVlZGJhY2suDQpSZWdhcmRpbmcgcGF0Y2hlcyB3aXRoICdGaXhlcycgdGFnIC4uLg0K
QWN0dWFsbHkgcGF0Y2hlcyBmcm9tIDMgdG8gNyBpbiB0aGlzIHNlcmllcyBhcmUgaW5kZWVkIGZp
eCBwYXRjaGVzIGZvciB0aGUgZXhpc3RpbmcgY29kZS4NCkl0IHdhcyByZXBvcnRlZCBieSBTYXNo
aWtvIGVhcmxpZXIgZm9yIHRoaXMgc2VyaWVzIGFzIHByZS1leGlzdGluZyBpc3N1ZXMuDQpLdWJh
IHN1Z2dlc3RlZCwgYXQgbGVhc3QgdGhpcyBpcyBob3cgSSB1bmRlcnN0b29kIGl0LCB0byBpbmNs
dWRlIGl0IGluIHRoZSBzZXJpZXMgdG8gc2VlDQphIGNsZWFuIEFJIHNjYW4uIA0KU28gcGxlYXNl
IGFkdmlzZSBvbiB0aGUgbmV4dCBzdGVwcyAuLi4NClNob3VsZCBJIHNpbXBseSByZW1vdmUgJ0Zp
eGVzJyB0YWcgZnJvbSB0aGUgY29tbWl0cyBhbmQga2VlcCB0aG9zZSBwYXRjaGVzIGluIHRoZSBz
ZXJpZXM/DQpPciAuLi4gIHRvIHJlbW92ZSB0aGVtIGZyb20gdGhlIHNlcmllcyBhbmQgcmUtc2Vu
ZCBhcyByZWd1bGFyIGZpeCBwYXRjaGVzIG9uICduZXQnPw0KDQpSZWdhcmRpbmcgdGhlIGxhdGVz
dCBTYWhpa28gY29tbWVudHMgLi4gdGhpcyBzcGVjaWZpYyBvbmUgYWJvdXQgZGl2aWRlLWJ5LXpl
cm8gcGFuaWMNCmlzIGZhbHNlLXBvc2l0aXZlLiBJdCB3YXMgZml4ZWQgd2l0aCB0aGUgbGF0ZXN0
IHJldmlzaW9uLg0KSSdsbCByZXNwb25kIGluIGEgc2VwYXJhdGUgbWVzc2FnZSB3aXRoIG15IHZp
ZXcgb24gdGhlIG90aGVyIGhpZ2ggb25lcy4NCg0KUmVnYXJkcw0KDQpHcnplZ29yeg0K

