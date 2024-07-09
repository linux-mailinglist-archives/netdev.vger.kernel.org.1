Return-Path: <netdev+bounces-110403-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C4F6F92C306
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 20:02:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4731E1F23CD1
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 18:02:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FE016BFB0;
	Tue,  9 Jul 2024 18:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="Ykx7cDM2";
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="MTkOno1d"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82DBE1B86FE;
	Tue,  9 Jul 2024 18:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.153.233
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720548156; cv=fail; b=f8mxUj9/V4wKeCLzFm0AEeUyb0C2/N9dqQg+2uGwFoNQQrr6sAPeNGrENzKneEaSsEMqN9KYwG+qTn9UCQTMb/gvdAtmh5ZU9jv/IR5FPF2PUYQlbJ3DrF+OhbhtJ9JZ77/SjjDsxUqAPhu1b5Ex8lM4N5G58WXnhLTXVdQiJtg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720548156; c=relaxed/simple;
	bh=b6Ti2II4k6x/Yq7u81QSedV5Rlj9UTjZ0gtjB1JBJn4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=I79a/yhyA2At3UddLaoVpaR7wls8+8McNgBj2SFAtbpIk1O8GEvJgLsZubJjsEXislM5lxtE5wZ6nePQePeDNzSiErm22gU6t5dCY1TUI9qnIR2mnOyZknjiPd1MvJtrFVpuGVMwoeYnXDwQmaxw7cDQGQm+V9dCS6EPhA9R3Zc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=Ykx7cDM2; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=MTkOno1d; arc=fail smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1720548153; x=1752084153;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=b6Ti2II4k6x/Yq7u81QSedV5Rlj9UTjZ0gtjB1JBJn4=;
  b=Ykx7cDM2y22xAZ11+eiXOY+sF8ZEuHY7By2YTbVHbyJaOGoYuQ+X5JLb
   nsNxoR/IftVeRNRo30zn9B5FHmDRAZK5zXJ6JrA0k8ZUnSNd5MBL3t5iA
   pz/rrWd8NhxANZMy8lTRE0faT/GP98K9+W5v8bPRCAYCy9PpeB5aBTqxf
   MSqHna7KmiC6oRJLNzBVyUhsBsAy6k2H+1wEXDZtqkMg74rCP968OlHeo
   9QcZ1Vim3grAVXLng5S7DMPwco33f4CMh3m2dadc/s4S3ZLF2QMieYeq9
   DTQNpRlzdZXH2YY4NC7vTI3EUxib47J3TLeJ5r58DP79l0/oQK2qxrrAB
   w==;
X-CSE-ConnectionGUID: UguOIc8ISwWnCuWcJTR0zw==
X-CSE-MsgGUID: L/PP5HijQQGqXK/nqca1Ng==
X-IronPort-AV: E=Sophos;i="6.09,195,1716274800"; 
   d="scan'208";a="31676834"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 09 Jul 2024 11:02:32 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 9 Jul 2024 11:02:25 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (10.10.215.250)
 by email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 9 Jul 2024 11:02:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aRqKTnOAtK7lr8uIl0fJN+XIG+Elk0G9DMnfXrY2VMcvyIb77z6mlRvUV97T7vI8VCYJhwVXMUprl3ridW/dbH6R2bakvJjN/bDnX0+UUkSdxx9rp/RtBQsnetT0AMLoLmAjgFXPc9HTFq0xBTZA81vB8FJXq0AuqG6TDd1dNdRMQ8p9Ic5tb/eosl1d4kjzV9VWcHjy/NEQj3hPciQ/vSXZ0SHVzoIqYKTSLzvqQK85QL0ArHqS8QzCROA3it21a/0oQeJN6JKV2df+vMZh4Oat93t78lGuOPPjJceDEEeUxwgbjpJh5e5JWbkxGvsckTkE73krldOAq/u0XUrr5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b6Ti2II4k6x/Yq7u81QSedV5Rlj9UTjZ0gtjB1JBJn4=;
 b=bDRvGRCt7hOLZV5QC+zRkeX9sfgh6eWt/0YfyNR53Qzil4zkV7T2Q/IuYX+7sY59NEowA/e3E9JBV6uf87VSr4Q0U8PRbD4HwjMeDWWL0U7dAgYOGidy2BDyBL1ET2NZrjD9xkWdUqruKLovFoYgeRLMECGaorerHCb5VGS07bcxuPK7Iq3sTFKMLc8Auo377qHBYgWLtRmbQI1wQAPodx6tXtDGYAYV2Hee+c99HF9wWRt4dm/nvJ/Y4ezJ1Nh+ZuptSCCLTZy5sg8sRPifxfD+z5QVjFFWCXRIGF/z/eby8sMiLTPd4fz/9fVPKy8opSn8oRFpnYDIhyWw/8mnmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b6Ti2II4k6x/Yq7u81QSedV5Rlj9UTjZ0gtjB1JBJn4=;
 b=MTkOno1dIzeFqt8Al98naccLmc0q75bmV0LT0WQkhR19WcmVQXjTFmKQnk/qXAcI5XQHtTtpV6gTzGRe4RDG6nsnX8cMyNxK+OL4Viwbf+6fxf+f1uzkE7HiHjqL3DbHizyh6Py6xl3Y1LANNb3v4ud5rJe65CuIfnbkuFA/bmong5Zb10yuzkXu5EZ5Wpqh4N1bWxTSW7sQ+GQWc42pUSNw2NZ73YS+3gHnB86x8knCMjFXHdeMsg2/0qfQJC4QUNJnsKRfHMnO8qKY9F+TZ+S4ygpfkVSY0zTrEehtheLO/1LcuL9ui1QGmyPW3c1gcrtFw+TFX8xyGbB6mxJI0A==
Received: from BL0PR11MB2913.namprd11.prod.outlook.com (2603:10b6:208:79::29)
 by PH0PR11MB5094.namprd11.prod.outlook.com (2603:10b6:510:3f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.36; Tue, 9 Jul
 2024 18:02:21 +0000
Received: from BL0PR11MB2913.namprd11.prod.outlook.com
 ([fe80::3bc1:80d8:bfa5:e742]) by BL0PR11MB2913.namprd11.prod.outlook.com
 ([fe80::3bc1:80d8:bfa5:e742%3]) with mapi id 15.20.7698.025; Tue, 9 Jul 2024
 18:02:20 +0000
From: <Woojung.Huh@microchip.com>
To: <o.rempel@pengutronix.de>
CC: <mkubecek@suse.cz>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <jiri@resnulli.us>,
	<vladimir.oltean@nxp.com>, <andrew@lunn.ch>, <Arun.Ramadoss@microchip.com>,
	<kernel@pengutronix.de>, <netdev@vger.kernel.org>,
	<UNGLinuxDriver@microchip.com>, <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH net v2 1/1] ethtool: netlink: do not return SQI value if
 link is down
Thread-Topic: [PATCH net v2 1/1] ethtool: netlink: do not return SQI value if
 link is down
Thread-Index: AQHaz2hPBJHkRhkuYUSe5weabIoP1LHtB1JQgADhPwCAAMsOAA==
Date: Tue, 9 Jul 2024 18:02:20 +0000
Message-ID: <BL0PR11MB29132C0293B487EBEAFF4532E7DB2@BL0PR11MB2913.namprd11.prod.outlook.com>
References: <20240706054900.1288111-1-o.rempel@pengutronix.de>
 <BL0PR11MB29139867F521F90347B6904EE7DA2@BL0PR11MB2913.namprd11.prod.outlook.com>
 <ZozPSl6opHYYdO-A@pengutronix.de>
In-Reply-To: <ZozPSl6opHYYdO-A@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL0PR11MB2913:EE_|PH0PR11MB5094:EE_
x-ms-office365-filtering-correlation-id: 022b83a7-f826-42d3-c61a-08dca0414725
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?TTBERWZqZmtBMlRiS0xMa0I1dHZhclFaS3VEMllDRVl1WkpMWVlQMXZ1VGty?=
 =?utf-8?B?c3JpUzFEYnNZY2E1YzB3bGZ3TFdzMGQzRTVTM0Vqek02cFhGcU4rV0RqbzRm?=
 =?utf-8?B?bTNzLzNWbEp6R3hpb3VzYmw5b290bkZ3UWVpQnErd3owUEUxVUpjZXNnY0sy?=
 =?utf-8?B?d0FrVHY3cXN5WUJYVFNUZ1ZGSmFpSU5ESlIwUW5UckpzZzdFNGFBUW9rMk5J?=
 =?utf-8?B?SXdkWVovRGhhUDc1ZXZzVjJCQVlaMmFMVmJvNG1NK05DQm9XcXVqYUhHeXJt?=
 =?utf-8?B?VWo4VkFYOWk1TWtUanpwSlpPRStoVlZ3VFV3OHVETVFSaEVNMnhPTHdrcWt3?=
 =?utf-8?B?UXlDRk9TVHV6YU5pTkR5TDBxN29PdS9zQnRMeDV5UmJic3JESXBXWUM1L2tT?=
 =?utf-8?B?Y2xldGprYnVqdWk5Y2hJK1RRTTVFTjViK1dXSHNOUVBwdXFJWUZ3aUZ2dDVw?=
 =?utf-8?B?VFdrVjAyQVZQcTdTbzA2dFltNzR3OXluY2xZSyszM0g2TDBNZVZ6QXFUanpD?=
 =?utf-8?B?KzJrZmlrdTdZWUU0TVpGdTVBT2o2NXowM2RXQm54UnBRRjB0UmtPeHY2NHJI?=
 =?utf-8?B?WWYxU2sybmhkSlJoa25ZQzhnUFF6Zk5pQU56QjB6V1JPNnE0MFRiMm4wbVhi?=
 =?utf-8?B?VjE0OVE5N2p2Um80L1MyQTFGVnIxNUlucDhoOExsMTRWZmZIN1BuYVY2Z3B0?=
 =?utf-8?B?dlo0azBpODRxWXU4RjQzbTd0OVhwZi9HNDliU1hVbnZaZFkxRHV3NVJ0bTQw?=
 =?utf-8?B?TEEyRFE4b0psR3ZVSE13ZkFiNDJPRVNSQW5WMGxGUk5rVWxvSTVSVXBMTzZ5?=
 =?utf-8?B?Z0pBTXJxK2hacHdoRnU3WGkyZU1OMFRuVUpEZ255Z0FsZlV3Wnk5bHc3L2hx?=
 =?utf-8?B?aWk5U2RuVWtnODJoaWVMeUw4MFJleG9LTXRTWDR4SWlNbkNSdVU4bE5HbEM1?=
 =?utf-8?B?VFFoVEFvK3BwL0JPL0pSYVRvOXZnSlRRNFhrS2VYb211TDJpL3BYSTdWMTZ1?=
 =?utf-8?B?dUhzNGEzRzNXTUNXaW9jVzRkWksxRGtvNlowSWphdFd2YndISzNnNE50REFh?=
 =?utf-8?B?dGdKeXhlQldmeFR3NDk3Y1RGWWdya3hDWUcxV0dUdG92RTZXbXQraUNwNGVG?=
 =?utf-8?B?Rk1LeEgwNHUrNEdrNFd1N3E3ZG5KN2JyNjNocGhaaHc4R1F3dzUvYWo2UFlO?=
 =?utf-8?B?L255Qy90Q1JJcVRCZ2UxWnVSUk1pcUtwbnIwc2FMMzY3emZDWHl0S1FCRlVM?=
 =?utf-8?B?UGQ0dWNBNmRLVXpYQTJ1S2J6eTVVUlZ0eXVOSjZhY2swRGV1MnRtQ0VPbmtt?=
 =?utf-8?B?aHJaU3BreFlkaXJCNFFHbkZ3eWJDYU84UFBVeVRxcE9MTEVUeXdxVGhObytL?=
 =?utf-8?B?cDhlYUExNDFiTjlXSDZ0SStoWU5lZDJmVVFlR0d4RU9icnA2WGkvZUVCYk92?=
 =?utf-8?B?S2hKMDRIU3Y3RUNIS1J1dnR2cFJuT3lITFNQeEh4T2dBeDZWU0lYN3VET3VE?=
 =?utf-8?B?OXZQNHEvWTd2MzdhNWdFRG8vMWpDRURDOHJXUnlHWERrNjRwWi9PM0Evd05U?=
 =?utf-8?B?VDRIcFAyVlBTZFRpZW8rZHhVdkVDeURxcU9BQ3JtaXdlaEI3Z3o2MUZPUnFU?=
 =?utf-8?B?bmJ5NXV4aGhEc2t4L3hYZWxmU05oWCtjNUhXNHB3RWhzbXVHMFNPaG96d1ND?=
 =?utf-8?B?LzhteVFhUmRmM3pudkFqbmhnRnhLRXZ3cktGVDMrWHNRaHpMSnpmVklsaFh2?=
 =?utf-8?B?NElMRTF0NG9WeFlUQjVGTkJYVmVDZmxtWXViN2c4UnlNL21IWnBMeVJQaE5v?=
 =?utf-8?B?dm1uOW1qdFJkTHlKL25mMVRIbkFrVTNWWWtJa1A3VUI3N1JQWFhVNkI5bkVP?=
 =?utf-8?B?a1YrR29mMFhLTFFkN2k5RStuSXZMN2VBbVMvYWZMR1BQOVE9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR11MB2913.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TmFWQXlYcWxkQVhBaWNvNys1MDYzcjhGdDQwaE1neUdIYTc2WDMxZU5yOGxh?=
 =?utf-8?B?b0NqNThrS1B5N3NSbm13Y3dJeWNnR2VUazV4bXJ6Um9oeThhVSsydkJtMU5I?=
 =?utf-8?B?NWJ5UjJhZzhSdVBBd2NjSUw5S0I0WU01a3h1SG54NnNldGxXNDlleXVCeDBW?=
 =?utf-8?B?ZVBnMzE5b0J2bjZDdGJpanRnaTVKanJWc3hNSUFScVBPYnFvZ3ZUSGhXejVB?=
 =?utf-8?B?dUZoQ28wRVZYaUtUNDgzTGRHNUhzQmhYVWdEd3I2SkxVbTBsZlh3aGZ2UVJ4?=
 =?utf-8?B?Mk5LeFNZdzBUL0hHd2tnd1Rpd0RvVHhpVjVhbWdjb202bm56ZWJRSnIzUEE5?=
 =?utf-8?B?TjRWOFpkNTZRT0g2allJQkpKemR1Nis0ajFDVE85MVRoVjB0UjYwTmppYTNF?=
 =?utf-8?B?a2hlREdjQnhYYXAxV0NmNHpDa01nczAxcXNDOWxCWDlGVndrTlBWMSt6MDFj?=
 =?utf-8?B?cE52alhKZDd6bXRvTVdrZWFiNGl4aGRGanVhU29OQS9EOGxaNjFiTXpkYSsr?=
 =?utf-8?B?TzJjWWlKVldBSTdoZFhGWnkycXZZZVJadmlRY0JmY2tzZnZPWmdrd2hjRjN2?=
 =?utf-8?B?d2dacjdqZ2VDbWt4MmVGNjhPU3VKS1owMnpubHVIUkFGdUVRSkloNUtzdWdm?=
 =?utf-8?B?d3RPQ3huUFA3YTBUSnVLVC9yblp3RXNTQm9JWE9xTUI4TjJqM0xaQ0sxYzJ6?=
 =?utf-8?B?bVM2dVdKcEhRQkZKelBmQVpQTjhuM3p4QkRWcmtDVWxpdzd1QTRsaUJueGcr?=
 =?utf-8?B?TVFvMkRYVHdtZ0NjQmtLTHQwYmlCN081Q0JaaTYrTnRuWlYvSS91aUJqVWUx?=
 =?utf-8?B?OEJrUCs1NDIxOERJRS96UlE3THEvVjcweHNQc2R6NDNCclZET2lwQU9jMHo1?=
 =?utf-8?B?b0wzUGlmaC9TckJNeGFHM0ZFZnZlK1Z5M1RmeDZVNWlwQ3dHTEpBSkYzQ0kw?=
 =?utf-8?B?QnhsRWZHR2ZKUFR2VWVwZGovYTJReVZoQitGL0JCb0tMenBCanYzRFRtcHQ2?=
 =?utf-8?B?cmNNMEU4MTdtSUx0NVdwOTQ1Z3ZzcHdWTWhRcWEzV3RMdDFmWFIxKzdBaTEr?=
 =?utf-8?B?b2g5TmRsaEE3bmZXZUtmaGhDamdjNFpPZzY3WGRnSDI4bS9NOWVzRCtlUEZF?=
 =?utf-8?B?RjNOQ3pRNldCU1F0VzYyMUI5N0tGMVEwYmJhT0JORVFlTmJYdDBvKzFsRXpw?=
 =?utf-8?B?TlY5OUtucFlYQnpaVi9acjNLWmNTbXp0MG8xVTJFRU81MXRmaGxTNkRlR1d4?=
 =?utf-8?B?bmNkMXVQRjZ2RllTdDM0em5qc2VaNk1BWTRLN1N5cHFjVDJvYmdjZzdHTm9P?=
 =?utf-8?B?YmU2OVpieXBYbVlSOUpqcXBpSTlkaXVjck9UQnoxa2lyVkRZb1BWa0pOQ25r?=
 =?utf-8?B?c3M3b3grMm5UTGs2TlpKcThUbFBENmZITUJtc3E4MGZDWEFZRTVlUjBEV0ly?=
 =?utf-8?B?TWo4ck1FWXhvYXZzZE01Y0xTUVg2MVB0bjF0NHNiaWZxZTdlVTJPd3hCMnZB?=
 =?utf-8?B?MEt3RzVsejU1YlUycWd0ZDdxS0liQjBOdW5xeUtaQUlSQjVmREtnMkdWdVcy?=
 =?utf-8?B?MVY2VEpYSHZkdURjOFUxLzVlNVhFd3dXZmU5TlZ2SjJBZnBlWG9MOVpOcTcr?=
 =?utf-8?B?dVI3MmFWV05XNHJsNnlUTnQrQzVSSnhXU0xaWVdlNUo3UVZlaytnVlI0UVgx?=
 =?utf-8?B?eVlUYkIwbEVhbUhBZThHYkZzR04rOHd3eDU1MVpndEc1akxGMUQ0bUt0d0Fx?=
 =?utf-8?B?TkVUc0FGUDdhcUJnRnQxNzBxTWJRbUg5c2ExZURpNUxvL0R2bmlXMDVtMzlC?=
 =?utf-8?B?SFJPYnFiUCtqOGZhWlR5TDNrVTgvVGR5VnlqNi9RODZUaE5UU1k0ekxtK1p1?=
 =?utf-8?B?cmsyeFgrMCtLeUVlZ1lNTUxHcFZROStybUdZRHM3bjBMTzRJd3h6cnAzK3p5?=
 =?utf-8?B?MExiU2ZmTmEvUTJFNUN3MkVjWWVoNWc3aitDblVBeTd3R2dCdllTcUdEUXdr?=
 =?utf-8?B?TlJpSFR1SkdEWDdPdFo4N2tWNTk3aUFtSDQ5WFhGUkNOa05UenpvRjYzcFRS?=
 =?utf-8?B?UnovL0hNSmZ0RXA4TVlUSFdCUWJDelVtZDBLZ1N0am9CM2hJdGcyVWY0ZUZN?=
 =?utf-8?Q?OrJWj3UANnc7Icki6wFkWBxhc?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR11MB2913.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 022b83a7-f826-42d3-c61a-08dca0414725
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jul 2024 18:02:20.6117
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: r8ly3AfToGrWNCVH776m/PcCpbXvbs9V4C+fDWH0rEm7X9mu8rqyD3yrKKv6RdsCV9ghSbTtdMCJndzy5hBHeDmDW4rmAC01eg/tdXqqxSY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5094

SGkgT2xla3NpaiwNCg0KPiA+ID4gZGlmZiAtLWdpdCBhL25ldC9ldGh0b29sL2xpbmtzdGF0ZS5j
IGIvbmV0L2V0aHRvb2wvbGlua3N0YXRlLmMNCj4gPiA+IGluZGV4IGIyZGUyMTA4YjM1NmEuLjRl
ZmQzMjdiYTVkOTIgMTAwNjQ0DQo+ID4gPiAtLS0gYS9uZXQvZXRodG9vbC9saW5rc3RhdGUuYw0K
PiA+ID4gKysrIGIvbmV0L2V0aHRvb2wvbGlua3N0YXRlLmMNCj4gPiA+IEBAIC0zNyw2ICszNyw4
IEBAIHN0YXRpYyBpbnQgbGlua3N0YXRlX2dldF9zcWkoc3RydWN0IG5ldF9kZXZpY2UgKmRldikN
Cj4gPiA+ICAgICAgICAgbXV0ZXhfbG9jaygmcGh5ZGV2LT5sb2NrKTsNCj4gPiA+ICAgICAgICAg
aWYgKCFwaHlkZXYtPmRydiB8fCAhcGh5ZGV2LT5kcnYtPmdldF9zcWkpDQo+ID4gPiAgICAgICAg
ICAgICAgICAgcmV0ID0gLUVPUE5PVFNVUFA7DQo+ID4gPiArICAgICAgIGVsc2UgaWYgKCFwaHlk
ZXYtPmxpbmspDQo+ID4gPiArICAgICAgICAgICAgICAgcmV0ID0gLUVORVRET1dOOw0KPiA+ID4g
ICAgICAgICBlbHNlDQo+ID4gPiAgICAgICAgICAgICAgICAgcmV0ID0gcGh5ZGV2LT5kcnYtPmdl
dF9zcWkocGh5ZGV2KTsNCj4gPiA+ICAgICAgICAgbXV0ZXhfdW5sb2NrKCZwaHlkZXYtPmxvY2sp
Ow0KPiA+ID4gQEAgLTU1LDYgKzU3LDggQEAgc3RhdGljIGludCBsaW5rc3RhdGVfZ2V0X3NxaV9t
YXgoc3RydWN0IG5ldF9kZXZpY2UNCj4gKmRldikNCj4gPiA+ICAgICAgICAgbXV0ZXhfbG9jaygm
cGh5ZGV2LT5sb2NrKTsNCj4gPiA+ICAgICAgICAgaWYgKCFwaHlkZXYtPmRydiB8fCAhcGh5ZGV2
LT5kcnYtPmdldF9zcWlfbWF4KQ0KPiA+ID4gICAgICAgICAgICAgICAgIHJldCA9IC1FT1BOT1RT
VVBQOw0KPiA+ID4gKyAgICAgICBlbHNlIGlmICghcGh5ZGV2LT5saW5rKQ0KPiA+ID4gKyAgICAg
ICAgICAgICAgIHJldCA9IC1FTkVURE9XTjsNCj4gPiA+ICAgICAgICAgZWxzZQ0KPiA+ID4gICAg
ICAgICAgICAgICAgIHJldCA9IHBoeWRldi0+ZHJ2LT5nZXRfc3FpX21heChwaHlkZXYpOw0KPiA+
ID4gICAgICAgICBtdXRleF91bmxvY2soJnBoeWRldi0+bG9jayk7DQo+ID4gPiBAQCAtNjIsNiAr
NjYsMTYgQEAgc3RhdGljIGludCBsaW5rc3RhdGVfZ2V0X3NxaV9tYXgoc3RydWN0IG5ldF9kZXZp
Y2UNCj4gKmRldikNCj4gPiA+ICAgICAgICAgcmV0dXJuIHJldDsNCj4gPiA+ICB9Ow0KPiA+ID4N
Cj4gPiA+ICtzdGF0aWMgYm9vbCBsaW5rc3RhdGVfc3FpX2NyaXRpY2FsX2Vycm9yKGludCBzcWkp
DQo+ID4gPiArew0KPiA+ID4gKyAgICAgICByZXR1cm4gc3FpIDwgMCAmJiBzcWkgIT0gLUVPUE5P
VFNVUFAgJiYgc3FpICE9IC1FTkVURE9XTjsNCj4gPiA+ICt9DQo+ID4gPiArDQo+ID4gPiArc3Rh
dGljIGJvb2wgbGlua3N0YXRlX3NxaV92YWxpZChzdHJ1Y3QgbGlua3N0YXRlX3JlcGx5X2RhdGEg
KmRhdGEpDQo+ID4gPiArew0KPiA+ID4gKyAgICAgICByZXR1cm4gZGF0YS0+c3FpID49IDAgJiYg
ZGF0YS0+c3FpX21heCA+PSAwOw0KPiA+DQo+ID4gSWYgUEhZIGRyaXZlciBoYXMgZ2V0X3NxaSwg
YnV0IG5vdCBnZXRfc3FpX21heCwgdGhlbiBkYXRhLT5zcWkgY291bGQgaGF2ZQ0KPiA+IGEgdmFs
aWQgdmFsdWUsIGJ1dCBkYXRhLT5zcWlfbWF4IHdpbGwgaGF2ZSAtRU9QTk9UU1VQUC4NCj4gPiBJ
biB0aGlzIGNhc2UsIGxpbmtzdGF0ZV9zcWlfdmFsaWQoKSB3aWxsIHJldHVybiBGQUxTRSBhbmQg
bm90IGdldHRpbmcNCj4gPiBTUUkgdmFsdWUgYXQgYWxsLg0KPiANCj4gU1FJIHdpdGhvdXQgbWF4
IHdpbGwgbm90IGFibGUgdG8gZGVzY3JpYmUgcXVhbGl0eSBvZiB0aGUgbGluaywgaXQgaXMNCj4g
anVzdCB2YWx1ZSBzYXlpbmcgbm90aGluZyB0byB0aGUgdXNlci4NCj4gDQoNCkhvbmVzdGx5LCBJ
J20gbm90IDEwMCUgY29uZmlkZW50IHRoYXQgbWF4IGlzIHJlYWxseSBuZWVkZWQgYmVjYXVzZQ0K
U1FJIHJhbmdlIHNoYWxsIGJlIDAgKHdvcnN0KSBhbmQgNyAoYmVzdCkgcGVyIE9wZW5BbGxpYW5j
ZSBzcGVjaWZpY2F0aW9uLg0KT24gdGhlIG90aGVyIHNpZGUsIHNvbWUgZGV2aWNlcyBjb3VsZCBu
b3QgZ28gdXAgdG8gNyBhbmQgbGltaXQgYnkgbWF4Lg0KU28sIGFncmVlIHRoYXQgYm90aCBBUElz
IGFyZSBuZWVkZWQgaGVyZS4NCg0KPiA+IElmIGJvdGggQVBJcyBhcmUgcmVxdWlyZWQsIHRoZW4g
d2UgY291bGQgYWRkIGFub3RoZXIgY29uZGl0aW9uIG9mDQo+ID4gZGF0YS0+c3FpIDw9IGRhdGEt
PnNxaV9tYXggaW4gbGlua3N0YXRlX3NxaV92YWxpZCgpDQo+IA0KPiBBY2suIEkgd2FzIHRoaW5r
aW5nIGFib3V0IGl0LCBidXQgd2FzIG5vdCBzdXJlIGlmIGl0IGlzIGEgZ29vZCBpZGVhLiBUaGlz
DQo+IHdpbGwgc2lsZW50bHkgZmlsZXIgb3VyIGEgYmFnLiBQYXNzaW5nIGEgYmFnZ3kgdmFsdWUg
dG8gdGhlIHVzZXJzIHNwYWNlDQo+IGlzIG5vdCBnb29kIHRvby4gSSdsbCBmaXguDQo+IA0KDQpU
aGFua3MuIFdpbGwgcmVwbHkgaW4gdjMuDQoNCj4gPiBBbmQsIGJlc2lkZSB0aGlzLCBjYWxsaW5n
IGxpbmtzdGF0ZV9nZXRfc3FpIGFuZCBsaW5rc3RhdGVfZ2V0X3NxaV9tYXgNCj4gPiBjb3VsZCBi
ZSBtb3ZlZCB1bmRlciAiaWYgKGRldi0+ZmxhZ3MgJiBJRkZfVVApIiB3aXRoIHNldHRpbmcgZGVm
YXVsdA0KPiA+IHZhbHVlIHRvIGRhdGEtPnNxaSAmIGRhdGEtPnNxaV9tYXguDQo+IA0KPiBJRkZf
VVAgaXMgYWRtaW5pc3RyYXRpdmUgdXAgc3RhdGUsIGl0IGlzIG5vdCB0aGUgbGluay9MMSB1cC4g
c3FpX21heCBhbmQNCj4gc3FpIHNob3VsZCBiZSBpbml0aWFsaXplZCBhbnl3YXksIG90aGVyd2lz
ZSB3ZSB3aWxsIHNob3cgMC8wIGlmDQo+IGludGVyZmFjZSBpcyBpbiBhZG1pbiBkb3duLg0KDQpU
aGFua3MgZm9yIGNvcnJlY3RpbmcgbWUuDQoNCldvb2p1bmcNCg==

