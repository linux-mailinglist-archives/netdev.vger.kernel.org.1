Return-Path: <netdev+bounces-109710-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28325929AEA
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 04:39:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2BE52811C3
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 02:39:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D407184F;
	Mon,  8 Jul 2024 02:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="NGm+HgNa";
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="OYLopw9V"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FAF32FB6;
	Mon,  8 Jul 2024 02:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.154.123
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720406367; cv=fail; b=BEKjQYd5APJ4Z/60NCdT1wxIw8tBvWmQqKAgZuBNT2MnYoG+OeRK14Zb+tnMFUF21Lf0/T6GPSmbTcgz1xbmJzONmqumsdAVETE2eav239oDrIgRaJu1b2iuszSbzVgUgvcTsrB+A9NBb1easWWBl1pchbPIOExVqqjnEM9AxKk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720406367; c=relaxed/simple;
	bh=4xGUPV7GEAMOedV8/Nj72mHappMKEjkT1JIQz7YanwY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mIb5d+nPJWNXm6920M83aC/UIWJjAViuGpSgPwGBxGctr4TVBqet2E2Vbv5h9XHVpOKAao04sgRKdR003qFhuQXtCPxsSNIDEvusMLb6LNPxz8ZZDzXKbdW/bDzdMM5ttYOVUeKh62C6NjgNAoJtqmAX6SDDmJ9LNW1HVyKLqq8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=fail smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=NGm+HgNa; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=OYLopw9V; arc=fail smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1720406364; x=1751942364;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=4xGUPV7GEAMOedV8/Nj72mHappMKEjkT1JIQz7YanwY=;
  b=NGm+HgNahMzJrDv9S0fkvfsyYYVfY/lGnNWHwTOpldNFflYnRAqxyEWQ
   PSjTM+Nz65JDvVX3jOgSw0tUCfcxzBOFz/0XMUfOD0HU+DoOKDlrXoWOP
   ErRXty78Y/hGwKEsLESOnjb3GJHrBex55SOjH+FTCvVQPR98qKuvqEDMD
   Pv3p69fD8fv0u9dm+Cze8OGSeFBMY/UXElzeJLrbaNXg9geTaa0pHhk9M
   f9FuodmpYn9bx704MIesmGgeEVdOYM+PAjKoE2My7oa/te6CKafLDxKwY
   PKjiPcS+0wqMbygUkZtzJFy9wIOiyx+2MHHQSHC+F5S3GZpMBvRhYXOVl
   Q==;
X-CSE-ConnectionGUID: papseuJdSLGWmZ2xkZ4CVA==
X-CSE-MsgGUID: JybR8ayhSJiwas10W41XmA==
X-IronPort-AV: E=Sophos;i="6.09,191,1716274800"; 
   d="scan'208";a="28907353"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 07 Jul 2024 19:39:17 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 7 Jul 2024 19:39:14 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (10.10.215.250)
 by email.microchip.com (10.10.87.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Sun, 7 Jul 2024 19:39:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f3Rq4RRFdKSzeAYyX4Ofo2Ajh3Oac929bFR1MHOKRFVkeVk68V5ZMkqtUVRpAe+evYvl2R4PLCr/MWDiN7Sl6FDno6Tvc4LGusJxXafbfVnsQIVP0ollkHCX+ll2KypfHxlGGZycYrv8zlQ8B43uLS9upLOo6bWcYDPL9tOWR292QtJwOu01x6FFvqvogr89kHmg3pqwVgAp5zbq7CqyqwkUt7HQUAVu8jZ++Jz6YKCZi0Q2Na3w1hq3LYAjMVCxFMItZMghAeI+cNTqdTyXMv44C4Bx8QoaTEBMUYyf5F9agHoeQfSXMnkoKV+gCWVrRlts0gnznI+5wBrSgoVHpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4xGUPV7GEAMOedV8/Nj72mHappMKEjkT1JIQz7YanwY=;
 b=ZbgPGZkLHQGKZAWRGShSn38cMsdb/KymlMGNY2KXYqm8lGg1tFrCjkql7lTYnTED6oaMuQcU3jPEsOeq24Wi+LPYqZyioxY0atdFrrMDw6pZlM32mqfKXFkcDXNNZ/r5imHI5twRDjirG1vO45PT9rFoteSySo+LC2jwUETwFgL+eoQpIbST96IVclIzblpR2+gEU3Rf7Fp4dkY8eFGqJm5/sFA9adS/vkOpux1jzFqbW9YKFkh+oXfs758d3um8yUW66hstb2gvsg6dmg8mnx3IpshHnWZThQPf7dVVVOaLB4hTWX/+qFZcmJ34xWa9fHyxodKDs3NR/8+87qdCBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4xGUPV7GEAMOedV8/Nj72mHappMKEjkT1JIQz7YanwY=;
 b=OYLopw9V+XdJAcfYSLHl99xkGtlqH5ZxOGR+87CsKfYv2h5cu+q/1JLCGYOBCoPBCu1vsiQB0r7rXR/6otgT+a9mcrX2DetjLZlgp6XkYpU4uQ2or5fzyfzghnnKZhpWPQZmBV3m7Hh2TkoLlvsW8Jw6ARW4O14GmW2Y7yKl/mkrHvvBDPMvrdbKD/ITDNiSDR4FDd9zy6saBJLxHw9WgAIpOdTG3UGa9Zfsb6KcLzAaNCXoYfdnqYUGD2zhuLJpsym8w8FVlbU4e2nXHRGSqWr+dUN/LWxNoMH54XMBTonBV7oS2HGsNLSsYllnl367XUqhqB5uT+45MEecKgh59g==
Received: from PH7PR11MB8033.namprd11.prod.outlook.com (2603:10b6:510:246::12)
 by SJ0PR11MB5070.namprd11.prod.outlook.com (2603:10b6:a03:2d5::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Mon, 8 Jul
 2024 02:39:11 +0000
Received: from PH7PR11MB8033.namprd11.prod.outlook.com
 ([fe80::22a1:16dd:eea9:330c]) by PH7PR11MB8033.namprd11.prod.outlook.com
 ([fe80::22a1:16dd:eea9:330c%3]) with mapi id 15.20.7741.027; Mon, 8 Jul 2024
 02:39:10 +0000
From: <Arun.Ramadoss@microchip.com>
To: <andrew@lunn.ch>, <davem@davemloft.net>, <hkallweit1@gmail.com>,
	<Yuiko.Oshino@microchip.com>, <linux@armlinux.org.uk>,
	<Woojung.Huh@microchip.com>, <pabeni@redhat.com>, <o.rempel@pengutronix.de>,
	<edumazet@google.com>, <f.fainelli@gmail.com>, <kuba@kernel.org>
CC: <michal.kubiak@intel.com>, <kernel@pengutronix.de>,
	<linux-kernel@vger.kernel.org>, <florian.fainelli@broadcom.com>,
	<UNGLinuxDriver@microchip.com>, <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next v3 1/1] net: phy: microchip: lan937x: add support
 for 100BaseTX PHY
Thread-Topic: [PATCH net-next v3 1/1] net: phy: microchip: lan937x: add
 support for 100BaseTX PHY
Thread-Index: AQHaz7ssUC+0Ja5ozEiX7ldBCqFm1bHsIS8A
Date: Mon, 8 Jul 2024 02:39:10 +0000
Message-ID: <db160aa766271f2cb21927a6c2a1948ac2fdc7ca.camel@microchip.com>
References: <20240706154201.1456098-1-o.rempel@pengutronix.de>
In-Reply-To: <20240706154201.1456098-1-o.rempel@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.36.5-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB8033:EE_|SJ0PR11MB5070:EE_
x-ms-office365-filtering-correlation-id: 045e8b4e-08f5-4416-417d-08dc9ef7257a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700018|921020;
x-microsoft-antispam-message-info: =?utf-8?B?SmhiZEg1aTQxTlVDcDBQN2pGdnNOc2IxcnBWM3o1Sjg1NTRkNE1rNE94c2Zx?=
 =?utf-8?B?MGR0OTZzRHY4MDZpbzVvRTZWdVIwQ1RkZzNRTk9rNHczbFpGSVBORGZuRUxp?=
 =?utf-8?B?b0dIZlAvY0N3d0NlSUZDejlsTVBiZzhIdU9YdXd0RHkzRkZuSFV4MDVkTnZB?=
 =?utf-8?B?N1ZaRkE2eWtzV1Eya1VIRi9pY0hDZDIvMGo1VWxDbzFjUE0vSmtwS0ZXL0p5?=
 =?utf-8?B?cnBFQksxaHQ4d2hzeVBCR2ZZelVjYWg5TlRTcWNNbXhvWGNmczVncW9hUXhE?=
 =?utf-8?B?Unl2YTRwNUlvVksrQmFBTFdGSGNnNC93VER2UjNmS3pPTmkvMHRmZDRYQmlO?=
 =?utf-8?B?Ky9xeWxBT0Z2bkRwb2hsSkxINUZWV0lmMjRhWHR3L3UycTNUNjBpN0FSYSs1?=
 =?utf-8?B?VGlna2dVM090MUE2VVNQcys0N2NHdmkwdVdmK3VQYlhSbUFHbUE0cExqVk54?=
 =?utf-8?B?WFczN1JEMisxMmxwN0tyb0lRRk8yMlczckdoTU1FclNlU1BwZkNRaHk0aGNs?=
 =?utf-8?B?clUyN1FLRG1xYVFkOTdPMzZreWNsQTduQnFpS2Fma21DWHM0MWdMSjkyQXJs?=
 =?utf-8?B?RnU4aStrZzFPUmFMWkYxLytuT1psam5vbTNna2RsdmYzVElOVGlCOXcwRDF0?=
 =?utf-8?B?dXB2Z05vMy8wdmtUdWlOZ1I2RmlZMjhlSWJZNTNwN01OS0dXQ2MvYzloRVB3?=
 =?utf-8?B?NUpMeHpOOXhvamdWWVZXdHdPRHFlSHh2eFRUbmtrUURwSjZVV1pVdlhmN0xi?=
 =?utf-8?B?UWFGT0dXOGprb1A5dnZEMG1CTGhreDhlNVA5R2V0RVFzdnZkUEJvaXlhc3RI?=
 =?utf-8?B?T1VST05lT2lwVjFraFJaMXBFcTk2YTVEY3YybmFLdmFZRkg2SXQyZHlWQUI4?=
 =?utf-8?B?TkoyQXY1bk9UYy93bzJTNWdvNENxWlZ3Sjg4VSs5QTNjZnYyRnpUczdha0Z1?=
 =?utf-8?B?aUxXOENXTFB5aHZ2UFVNZHUxNTRiR1pTMVJFUDZWT2hDU2daM0g4bWZzencw?=
 =?utf-8?B?WFY4NTRxclF3OFd3VHpycG1VWFJ5QWtLb3AyREd6NVBHUS8zZXBGWHZlNEsx?=
 =?utf-8?B?OXkxbGo0ZC8wRHROOW1ES1k5S0JjY0pBc0JHdWRSUGJmRUU5MmVad0NBUzlS?=
 =?utf-8?B?WjFheUxZbjBHUnFmZVIzM3FaSDlZUmZIclZzREIvbTVwQTBDNVhtL1RCU0gx?=
 =?utf-8?B?UUJXSkRpZ0dqNlNHWTBXSDREM29GYzJ5Z1VRUVRRWnM4YzFPMmJIV2g0aXI1?=
 =?utf-8?B?SitPejBhRDZNNkoySmNYcTZvQ3BpRmdyM0FlTjBxMHlaUm9nNmhYRVVkdXho?=
 =?utf-8?B?MkZka0pHc2poU0pNYTYrdGZQQXZ1eW05L29Gck9XTG1WODVXNjMrcGZFTnVz?=
 =?utf-8?B?enhDcVJzRWFid3cxZm5FR0g0dGJYL1MveTBTVG5MUm44R3NkdEl0WWo1ZHA2?=
 =?utf-8?B?TlhtbDRTRmdaN0h4OVQvK0FtaGxBMG02NW10Q09wakR6NWwwdU81TEFXVWhH?=
 =?utf-8?B?Q2pPREdNMWVwbFo0dnR4YURhVnFMa1BTTFZVN2l0WnJrNjBCbjZoazdVQ0pv?=
 =?utf-8?B?UWdobVA1ZTlwV3cyZHZtcjNMYm13L1gwdTAxVGpQYWFXN1FBNW1pRktJRmUz?=
 =?utf-8?B?WnliTkxIM25TSnJPblB3WkJ6WE0rb0EzcFl0S2NORUNHVGpHVWtTellUQm51?=
 =?utf-8?B?MWsxcVE5NmVuS0kyV1QwOVNzZjMyQWszeHJnWWl1ZXF0cXljZC90NTlxL3V1?=
 =?utf-8?B?QWR1YllxUzZiUDV4OCs4UkR3UkVKUUlPNDRvcUltYzBoM3pKVCtIM0tjZUxF?=
 =?utf-8?B?VkhVNlpodzlUbGVqNW9CbFJxMkY5TC9NOVg2NDlzMmREcHp2MmRzUE54S0hW?=
 =?utf-8?B?L214OTJnQ0ZDNyt4cHVOcmowNTJ1UVFkWC9acGZrc0c4OHJwdEMvUG9JcVl5?=
 =?utf-8?Q?ee9vv5jHtn8=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB8033.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700018)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?czhVR1JKajZ3RFFrYjB2aUp0ZGo3TDNIb3Bpalc4OGphcmZWWXhUeUN5amlo?=
 =?utf-8?B?M0tQYkZmUkhBcks4NmkyRGM5eUVhckcrSEFIYWpvL3FXZkYydktaUUVVbmJZ?=
 =?utf-8?B?Uk96QThFQVgxNkVLLy9sQWNuWEZxT0dPRGJPeituSDhnKzRPKzlvRlp3cm9n?=
 =?utf-8?B?TC9uNlhVaFc1Q1owVVl5SWdhNkxZcGJ3WHNWUS9meUdFdXgwejVTRUxHQ2Jy?=
 =?utf-8?B?emhJdWY2TDBOWUo1QkNmdy9KYWQ3eCtMZmZNdjRubXNyZ1J0V3VDanhyeGJL?=
 =?utf-8?B?RkkxYm44enNGTE5NUXNLYkQweU1wQ0x1ZjNhNXpQdmVoMElHRm9kSFhtTk1B?=
 =?utf-8?B?OW5mZkxQMldkSHB5WEk4QWZwRmRWZ3JoVkxmVVlTNXpLQUdKczF5M1RhVzdT?=
 =?utf-8?B?WWxrdkNwS0dnMG1lUkkrNnIvT2NwZ1RtMkNKVEM1NHY4bVBHSGlPZjhkRTdn?=
 =?utf-8?B?T01EdVVDaWhJVW5uOVdwZFZDZUhyYWV1UzJiNk03RGk1S1gvK1NXUzJ1TUtx?=
 =?utf-8?B?UTZGR3ZydUI0NzRJUHE3MUZxSitGU2lrbnVNSGpXcXBuSlRyVHBERkFIbjds?=
 =?utf-8?B?VUU1NWFNVlJWR1I5aDgvc3dWUS9kSkNzVFBMNnd5bmdHVzZULzhINjFPaE1J?=
 =?utf-8?B?QWxQQmFsSFpUZWpqbVFxN09xYkMxd2I4bTJNd3lQQVk4UklxdnlPSUZmSURa?=
 =?utf-8?B?Ry9sdGtsRVZyTzRCL0lla2NQUHNiQk5wT1F2dDFxbXdTNWVFaHQrbWZJVmtC?=
 =?utf-8?B?R3J1QW1uc1RrZlYxWXRiUUhTZ2Naa3pxSEhHMUQxQWlRYVQ1NTZkTERBMUN2?=
 =?utf-8?B?Tm9yZ3JNZWdUanRpemhTWnFOWXVVVVg1N2ZGNDRZTWJQRmpPQU1ibXJBNzd3?=
 =?utf-8?B?TmVrMkNweDVGWGoxbEFxUzh0dWtaUXdFNWkrNHZsa0h3OGNKTXZPRjhlOVZh?=
 =?utf-8?B?STk5QU0xSVJXanVJc1g2YVkwOEswU0VjVlpoUGtNRW1QYUVZbjRTdDVuZmhX?=
 =?utf-8?B?dTZvaE9NWUhyWDB0SjlnTTNWMno0T25nSnVQelppSWhMWHV0S05wRGJMbXhQ?=
 =?utf-8?B?VVU3bGs0d25rUWIyTThpMERKZVIyeVR4TzVuOVR6SDAyWUVGOEhKNzQ5d0hG?=
 =?utf-8?B?QzVuSG51aTl5bnVlblplWDBsSUxzRi9xOHFINzZXbmloYjNWNWxmYzRHZ2lI?=
 =?utf-8?B?OEQveEFCZUU1MTN0Vzd1VHZzOXBHTVZnTC80TVFoeW9vSktKNlQ3VWpudDZr?=
 =?utf-8?B?Tzl2eE42S01wbTRtWFM2TEo1b0JlR0p5c2wycGV2YlVrZHd0THpleHh2NTAr?=
 =?utf-8?B?VWhPb1VqNG45eVFBL1VXcTltcE1hejBFY29veGx2d1EwZkRURy9iT2hHQnlF?=
 =?utf-8?B?Mm5FcnJ6Q0tMZmZtZmFlWWJEdWU4aTZDeUNtakROczEwbmxtMkE4Q0l6a1pU?=
 =?utf-8?B?WG5oVXQ0T1JIaXEwUjJHMEpPTHRQV1VIZG53bTVoMlRnOFJLdDhDRzZEaE1N?=
 =?utf-8?B?bHU5aUoreHFjZXcrNjh2a2J0S1FzUmJpTmRqd21vcU5WcytYbzBuLzgzcmJt?=
 =?utf-8?B?OTVLZkJFMHhUK3BaWWJCelRjZENrbWY1UUNZZFBrb3p2QTNpakJkbWhOTTVP?=
 =?utf-8?B?VE5QRXhKS1RLdDdrMFM1SG9JdG83c2NqSjJDSmppYXVpaGpzK0JYVmQyS2J4?=
 =?utf-8?B?NDVIcnp1M1NuNTFtYmZYZHc3SW5PU1hIR0NxTjlpVlg2V29FYkxtY3VRSFNS?=
 =?utf-8?B?dEZRaWtiUHd0dFJYQ2dSSTRRWGt0VThhUDd3OWF0bHQyb2N4MzNiUnU5NVhO?=
 =?utf-8?B?L0xMWllPOXJTbzN5c1hnVGxqSFZrYmY3alJIRVJ0RVpkemdkaFoxSU5KT2Jl?=
 =?utf-8?B?Qi9HUnlFSklFcDk1YmFmMlNFdG45c2VqaUZ5NDZic3RrYXFxUyt6K2dERjZB?=
 =?utf-8?B?SU9vMjhUZWtuSDNTMkVWQmFWenVkd2N6MG9ubDE4VWhJdnBTd2o2ZG93b2lY?=
 =?utf-8?B?cHZWTnZWajJyRXZ2NHFvd1ZBUnZoakk2K1I4N1N4Y3IwclM0WmY1UWMzdWda?=
 =?utf-8?B?Rnl3aDB6NWR3MkZhTjJmK1p2SVpVcWVXMUtmbVZBZVI0Qnk5cG5wMUJKN0ZO?=
 =?utf-8?B?OTE4Z2twdFYyR2JFMStySTRZeEF5b0R1SlFYdkhjME1YMmVEbmx3NTE4Y3gy?=
 =?utf-8?B?MHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E57C819D4AFE474A9D7ED92E8039375C@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB8033.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 045e8b4e-08f5-4416-417d-08dc9ef7257a
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2024 02:39:10.2041
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xaisBRXe9mfgvwzbwiX4dUGBg35MAU9fH5BD3HxnnjikJ0fWIbajNIH4ofqr+gn/6soSsucQ4NfLPym1ldXu5ko9F8+fD+H3Y04P9b8UbMY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5070

T24gU2F0LCAyMDI0LTA3LTA2IGF0IDE3OjQyICswMjAwLCBPbGVrc2lqIFJlbXBlbCB3cm90ZToN
Cj4gRVhURVJOQUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRz
IHVubGVzcyB5b3UNCj4ga25vdyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiBBZGQgc3VwcG9y
dCBvZiAxMDBCYXNlVFggUEhZIGJ1aWxkIGluIHRvIExBTjkzNzEgYW5kIExBTjkzNzINCj4gc3dp
dGNoZXMuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBPbGVrc2lqIFJlbXBlbCA8by5yZW1wZWxAcGVu
Z3V0cm9uaXguZGU+DQo+IFJldmlld2VkLWJ5OiBGbG9yaWFuIEZhaW5lbGxpIDxmbG9yaWFuLmZh
aW5lbGxpQGJyb2FkY29tLmNvbT4NCj4gUmV2aWV3ZWQtYnk6IE1pY2hhbCBLdWJpYWsgPG1pY2hh
bC5rdWJpYWtAaW50ZWwuY29tPg0KDQpBY2tlZC1ieTogQXJ1biBSYW1hZG9zcyA8YXJ1bi5yYW1h
ZG9zc0BtaWNyb2NoaXAuY29tPg0KDQo=

