Return-Path: <netdev+bounces-101580-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EBF818FF7E5
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 00:58:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D3181C20E60
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 22:58:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCFB813C81C;
	Thu,  6 Jun 2024 22:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="X546Hyv2";
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="6rYLMSof"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 269EFFC02
	for <netdev@vger.kernel.org>; Thu,  6 Jun 2024 22:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.153.233
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717714683; cv=fail; b=iISEZljAqMZ2ZCvVrBJbqr8uLdnQEkfZ0WutUORZ6ByV8KN5qlzDYFO1bd+GasZZR3b8VITsCejlEMhr1gm5fMkUtzISOxCcmMA0cFg9Jo4GnBX1xyUbPt72wxm9AIbb+HYFoPBSHVukxo/nH5S/ypm+5y/lMMP41t5EL8hEE7g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717714683; c=relaxed/simple;
	bh=w2UchG/KOY7bSbAD/HamUrCBQ3Qp0pePlfYlFtKe/kY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=c+KYQ7VGnz42j2m0cWaedPeUxeH+Bzb795CLcGlzvi4/0970WZl5+V8tw9gV5/0NqocPeSk/4RrTguLsnYZi7WKihLGeVyE2O+sM4gEVpZ+mmKZI3zb+MzqeUoiucE9y7hAzJVZYrq22OiFJpeeWUWGx1uJDyvrBOQurUb9qyAw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=X546Hyv2; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=6rYLMSof; arc=fail smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1717714679; x=1749250679;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=w2UchG/KOY7bSbAD/HamUrCBQ3Qp0pePlfYlFtKe/kY=;
  b=X546Hyv2DgEVfW4ZlWOZhhmeYAu5ZfOm/yed58w8AngyHyiLSxbAZCZ6
   kYADE3o0zfHhW3l8vbr+7AESA9bTz1Zn1dsTlof8C1Agj5gZbZ0n6c+Qg
   5UHFew1p+I+RQZCvkkjogqKKQL/n4KT6bp2VdG7yrNHd+5M6Qmeoj4CYm
   2K2K7Btc6ApeBKct2P7t/mPx8bsu4N1kfVteSpPKu/ZX3xrwk00rvlYc2
   JvSfef22dvr3jZOJA2FJSnfFdjFkhRENj2Mz+nwGKae94n94Pcfi7xG+g
   wCqYodI35QUu5iMjEZisCHHgsM4+ay2Gr+FdGqih/zhFwG8jb52iVQzp1
   g==;
X-CSE-ConnectionGUID: uCuBR4teTAWYJFSXARTt+A==
X-CSE-MsgGUID: aVZUb6S1RaStqgT6fcLKgQ==
X-IronPort-AV: E=Sophos;i="6.08,219,1712646000"; 
   d="scan'208";a="27102019"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 06 Jun 2024 15:57:58 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 6 Jun 2024 15:57:17 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (10.10.215.250)
 by email.microchip.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 6 Jun 2024 15:57:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=THc5SeOGVT//tO1WcEs1TD/DZRSRbKN1C4+vFrE80TNZuL4oWFR3ZZpZGxKA++Xhxg1BM5lsQn7801TwnJ5b9145yV3Lqiowd7WQaCk/C55x9yyTd2iKAZyYNjsq3iFiNPloTAjlxyQS2zbo5O+TB98f4f8J3cZ9C99lQQx1xKI6wZYttoi1M1tJDefJbSJy5ZcIaAl2bZ0N3lGeFyN/kBY7VwE8aVnO5KaVxqqkt6SkD0gdmKoVnV7VSuCYMILsY1Le86byadw3ITapsPquVGCEfyBgTw0PpBNZrz9BSu3wWZYYUFJ1P2Ep6l7grLxm0WahTL6TYl05bvt4CxNyaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w2UchG/KOY7bSbAD/HamUrCBQ3Qp0pePlfYlFtKe/kY=;
 b=c84J2PWH2LuvdzqJ6kQiYIB+Zqp8x1xlmnh6JHJppcMslkZRdlvoeBI80Q9O//sGEqGQ/w+Gex5I/kHtJe/4cZ/iaYSxXInmD+0X5GKUaDk9IBr5oso+iq6KOS2DSgpe2lQdh8JOJPNLO/+nzyTphTO5JNQFh9jXyMT5xGBZ0mZ/leG36yKDINcxNEWoWQXcZmQjkTdPOWwnNJ3IZgzY91ehAV9/kSB7mddx9mc9/3ytjpHiCzA4nC3Uw9tJhKnN0nLZY8j3ojIFcKFSEif1UqcyApb5EK3Gmn3xziamlSwueNXxXlMY6z51NX31cJQdz/718sucLw2sIiNSb9scdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w2UchG/KOY7bSbAD/HamUrCBQ3Qp0pePlfYlFtKe/kY=;
 b=6rYLMSofWP3wWdkOAzvSgEVR02SRbdwyL151pTDQXk8TSyhAVYam3fCQ9oalKIOhNvx+yaKLJxsi1pJulzTW5HOSWh0T2Mt3jVr9aauK35EteDaEIpn/j72m6mUInepzG3hQrl1avUeVvpVgwsNEZmygSP91Lcqfz9/d3AROZs1B77lSfYkmUrd8L3B83Xc//PWSmgu2C/bGyAesSCbt67La7HLaVHx7KNKA32A2O13f2oYAfXl+ZoCQqNGB/bi621mLa18/NwqWGZJzOY7mBSvpGs7a6MvodaGgjisn6IHhx16E9bZ1bffMeG3ZCXM6tKLcC90rSQaWcfvWgwnlzg==
Received: from BL0PR11MB2913.namprd11.prod.outlook.com (2603:10b6:208:79::29)
 by DS7PR11MB7692.namprd11.prod.outlook.com (2603:10b6:8:ef::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.34; Thu, 6 Jun
 2024 22:57:10 +0000
Received: from BL0PR11MB2913.namprd11.prod.outlook.com
 ([fe80::3bc1:80d8:bfa5:e742]) by BL0PR11MB2913.namprd11.prod.outlook.com
 ([fe80::3bc1:80d8:bfa5:e742%7]) with mapi id 15.20.7633.021; Thu, 6 Jun 2024
 22:57:10 +0000
From: <Woojung.Huh@microchip.com>
To: <enguerrand.de-ribaucourt@savoirfairelinux.com>
CC: <andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<UNGLinuxDriver@microchip.com>, <horms@kernel.org>,
	<Tristram.Ha@microchip.com>, <Arun.Ramadoss@microchip.com>,
	<netdev@vger.kernel.org>
Subject: RE: [PATCH net v5 1/4] net: phy: micrel: add Microchip KSZ 9897
 Switch PHY support
Thread-Topic: [PATCH net v5 1/4] net: phy: micrel: add Microchip KSZ 9897
 Switch PHY support
Thread-Index: AQHatmECha3DGgOR9Uuf/GUr++OEXrG4D3PQgADJ54CAAoIE8A==
Date: Thu, 6 Jun 2024 22:57:10 +0000
Message-ID: <BL0PR11MB29133CF39DA619F1AAF1DE95E7FA2@BL0PR11MB2913.namprd11.prod.outlook.com>
References: <20240530102436.226189-1-enguerrand.de-ribaucourt@savoirfairelinux.com>
 <20240604092304.314636-2-enguerrand.de-ribaucourt@savoirfairelinux.com>
 <BL0PR11MB2913D8FC28BA3569FDADD4A7E7F82@BL0PR11MB2913.namprd11.prod.outlook.com>
 <19eef958-5222-4663-bd94-5a5fb3d65caf@savoirfairelinux.com>
In-Reply-To: <19eef958-5222-4663-bd94-5a5fb3d65caf@savoirfairelinux.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL0PR11MB2913:EE_|DS7PR11MB7692:EE_
x-ms-office365-filtering-correlation-id: 31dd3e34-4a08-4c90-5c18-08dc867bffa8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|366007|376005|1800799015|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?bmxsQ3BRS3MvQzZ6RkQ1M3BKWjdOeDlZd21scEMveEJzbjJIMURsODN6KzY0?=
 =?utf-8?B?UzVEbmtCWGdtYkI5c1BtdExHN2xlTTB6MW5wRTVYVksxVFBtRDQ3TjVvekpJ?=
 =?utf-8?B?V25mY0NIYW9zczNGMkhIaVJ3RVcyUjh6dlZwZUhQTFc3VXpXYjdqd3Z4V0hk?=
 =?utf-8?B?MTZ3bCtJaWUveW9Ga1VGQjc3TzdUZzFDQnE5RUcxMC9XWW9GNGkvT3lmU3RB?=
 =?utf-8?B?VEs3bDdpTzJDdmgxdnhKNDE3Mlp0SVlha1BRNnRNNWRlSDAyV3cwdEZCYmRL?=
 =?utf-8?B?SlJweWVnQVlJdDNOS0VoNTZaT1lQQVltR1huYU9iVU5YWlh2cDV6dzQyU2JX?=
 =?utf-8?B?Nk1SN3RUL2hHdGlRTTA4OGpoUGxmN2ZUZm5BUjdGQThIbzMrSkxycnlFZWZq?=
 =?utf-8?B?U1pQZDN6NGRxUUVNb1BtcDRLMDVkNGxYc2VKaWhGaWlZYXdaR0NFUFRmUWkw?=
 =?utf-8?B?MS9JYVdQdVVMeDI0YXV6cjZMdzlnbVFDK3dSa0tGWndMUHBCZi95dGR6anVE?=
 =?utf-8?B?MU1idElOVUNxRERzSVdOd2lobkFsY28xbFZtcGdWVDA5V3RuTVJDQ0VxeW00?=
 =?utf-8?B?alRiZ3RUZE9sVmo5WS9LcFQ3K2U5K2ZkaWRMMmpvWUJEL2xaS3NMSU5YZDgy?=
 =?utf-8?B?OUJhemEyOUJKOFA5dk1zaFFIY2FaaEdtR3JzQUJVQ28yWlp1eWRRckcwOURh?=
 =?utf-8?B?QXh0TGZ3cWVJM3YzNVB3NkxpdVFsU0FScEo1OGdkVnJMalEvWWVaWmRRTGxR?=
 =?utf-8?B?VDQ5dUNrdCt2aCtYbWF6SWtxQkdNaU1Qa1Bya3E5NkNHc3VxbWxWbEVld2x3?=
 =?utf-8?B?SnRuK1ZzM3d0QmhLWGlrTHFCK2JhdVhaSktCaG0wOUdkUHFYWUExNnlKQzQ0?=
 =?utf-8?B?ZVNmUzVaQTZiNXB1V3J3QmU4eEJ6WFZNWjZyZEk3bmZwUlQ0MjlQNXhMY0sy?=
 =?utf-8?B?dXdibExRMkZkcm5IVnllMDBFMStEcHNTUGxqZ05mQ0ErWWtKRTVBa09lTDNE?=
 =?utf-8?B?TmlkZThjWmhZME52VjNWaER2WS8wc1dodkVYUjJzbU85a0RobjFoSndDQ1BD?=
 =?utf-8?B?ODQrK2FMRVovRmlsb3ZHcFBFK3prY01kZlgvSXJ1Uk9ISGtNRzFGdFNEMTlC?=
 =?utf-8?B?Qm85OWVjK2JjMURIcGNYMUJONWFVQU8zejdZRUhlbmFmMTFrQ0NlTTRBd241?=
 =?utf-8?B?K2RKSTZMeU51b25tc2IyUjNJOUw2a2w4NFdYbWZsa1E0YmhlNDJyUm5RRnBJ?=
 =?utf-8?B?VnZUWmxFdHo0TDlyU2gyajBDaUV5d3ZLVjdDV2U1M3dJQnlJdlpOeFpBQVRi?=
 =?utf-8?B?WHpSNnFKNzN1MHlwZDV0MEZ4T1pWRUFFUU5WMk5lT1NaL0RadkFiSTE3bjBZ?=
 =?utf-8?B?UEl1bE9Kbm0vQ216clJHcWEvZitFSXoveEJWeDFuQWhDS3AwZVRydVBmQm91?=
 =?utf-8?B?WnUxRS9taVlWeU5CM1FJcExhVHpLU1p6TjRMMk1TMURZL0ZKN1J2N0kxZnhl?=
 =?utf-8?B?ZllGcE1jSSszYUNqUU1USnp1YS9ob1JTcmJvUFJIanN5VEhjTzhqdWd1K0NP?=
 =?utf-8?B?OG1jV1dPT2tHTWpJTUtkVG43K2JGaW1UektuNmJMclZodXlNZ3ZuTGhqVCsr?=
 =?utf-8?B?bzVRSWJjUUhZSmhoaVo4VGZGMEFFSTdIQ2FQZC9QM3cwbEZ2UjNCSXh6MHA0?=
 =?utf-8?B?NWRvSlhsemN4NHdMTFVKMDhLcURDWjlaS0JOT044aGVONUZwcXQvWlFxSHhr?=
 =?utf-8?B?Njk2L0lTRHg3VmZHUzZCZmFvYmJmUzBJUzFXVEpoVVd4dEtzcE9SeGRJSnZl?=
 =?utf-8?B?M2NDcm1yMWtpaDV5Y1NwakgyeHlpam9RTVlndGdybUlLSU11bEZtc091NGNp?=
 =?utf-8?Q?mCDkdZMaCBozs?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR11MB2913.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?M2s4Q2JoZm81amRYdThlQ1VhSlhBL2t1T2VJeVBBYlJaUDhONlhGUGJrMXgv?=
 =?utf-8?B?YjFNL3p4b0xPY1lSdTZuZ1JSUkc0SzdVK1dLY2xkTGw3SVBhVVVBTzlycHRl?=
 =?utf-8?B?YjlnWW1RTnpveVFmSWVSaUVSZzZBMDNQREFRT2V2WE1JWE5yT3RZQWVGMjBq?=
 =?utf-8?B?bVNvRmFFSHkxc1RQK0NJRjRqeTdiYjhpK0NSWjBHSWQyRityNUhLNW9RM01I?=
 =?utf-8?B?UytwS2ZQWk16Qmd5Q1Y1MmFkS0o4MGxQcHhaMjU5SGtuRlpDc0NWS1Z2Rzcr?=
 =?utf-8?B?QWM2S2VzTm5xMEdYUVdMSkNRVXo0ZTQ3OUEzV3c1bk8xQmtnU0UxQTNnalBR?=
 =?utf-8?B?MVZSMkx6Y3VqWmRFSXd6TDZVL2QxckRDaU8vMlNhTmFxcTd4bmVVMkRSYXRk?=
 =?utf-8?B?Z3lEMkZZS1FGc2lXZzVVWmJVdlJIVTBPWTVEZytuNmcxak9FdnNnOVRaWVhP?=
 =?utf-8?B?NjRPVGVlTXZOQytPWlJuU0ZqVXhLSi9sd1hZbkNaSkFrMkljUFcwRVhkejRE?=
 =?utf-8?B?cFE3c01YR2gxRkkvOGFwVzV6UXlHU2grb1V1NHNZNzhEa1kxN1R4cnBzRlVy?=
 =?utf-8?B?Zm9Wcm5iMTBWdCtGUVRZdnVCaXM0SURSVDY1eU95a2h1UTNLNWFGSVZTWVVs?=
 =?utf-8?B?YXYzUEtSY09lQ2FpQkVmVEpyNmxkZEdnRWx3QTlydHpaSFpyUUtnVzhNTHdi?=
 =?utf-8?B?VlRJMXU2SUJBU0tmeHdSNlNHSkpwRG1jSlkxcEd1ZzYvSUs2UkEzY1J3S2tK?=
 =?utf-8?B?bzIxRUI4dTAwYjE1TUt4WER5c08zZ3hzUkc2M2tZWHdQQTVjNzQ4TGpZQ1Qv?=
 =?utf-8?B?Z1R4MVhyNVVJTUhrSTFFZWJCdml1OWd4Q1lOR3NIdWFPNG9YZXVhVi9lbXA2?=
 =?utf-8?B?VlZSNlB1cS9SRkh5RU5tVjRXS05qc0ZGSE40TmtZVzNGaHp5SXZKUlo3NGlG?=
 =?utf-8?B?aCtyRzUxclVXSXBtV01kaGRIRU5TSDlaZXpNQWI4MWpzTjFDakZ2WXd5K3B3?=
 =?utf-8?B?c1g2T0g1TmlNSk8vOUp5NmZpZ1ZudnVKdHVmWU1EdFhjZnIraitYUWdmZGtL?=
 =?utf-8?B?dGYyekdiODhwdktOckcrYVZLZ3NuWXRjaGU1ZzFmaGpVdFR4eFhTVzBTdHdh?=
 =?utf-8?B?QWJ5SkdldndTdHdILzN3MWp5VVdCQVMySExjeXFkTHM1K3VXR0lxVUc1OGw4?=
 =?utf-8?B?cTNkdmkvZ3VlZFNIWTdIVU9iNVBaUkp3eXRQVFo2TUR3ZDZrdzZIWWJGY0tX?=
 =?utf-8?B?YmVOV3kraGJycnIvK0RnNUNabUoyQnpTVEdFZFRzc3ZnMndKaUZRdExqMWtj?=
 =?utf-8?B?S3dERmdzT1BBY0VsblFSUGVXaVJueDkzZk5UWEdBOHlHNkJzSTFPZVo2azJB?=
 =?utf-8?B?dHdSOUdqdjF6VktZaU5aY21mMzlpT3M3cjN2K0djSThPaUI2eE5HZzE0cUt2?=
 =?utf-8?B?ME4xc09vQUdJclFxN0dwc1NIMjBoNURsaUlrUTFiRHZRY2pZL2NwdjlGOTdG?=
 =?utf-8?B?NkNYRDAybEI4VW5Ldi8rb3dHM0cyd2x2K3JjUllwT1BwUCtRZVJ6Q3I2VWo1?=
 =?utf-8?B?em1neThYeHBsdlh6L3NQblNVT0RvRlFNWXY5WmRETmZKS09sYlZtdFU4VW1W?=
 =?utf-8?B?aHZNUzZNNkppS1BaMmIvVExNVG45dkFwRlBlRTQvMXVaekxqMnpxZC91TTNp?=
 =?utf-8?B?MC92MFhiOWVSNVJjdkM4RnRsbExvTkFkc2E0M2pSMVZiWUtmVGYvdTlIWk12?=
 =?utf-8?B?dW9HaVZkcjAvOU9yTE13WXhGQ3lUakJwbVdZV1l2M001ODVMYi9Ub25LekRM?=
 =?utf-8?B?M2hEc2EranJ4cEV0Z1dZNG51ODZZallsT1ZoUldiMWJXaXZyaUl0REdMUVBI?=
 =?utf-8?B?TWJ6cHk0Vm5GUlZGVXprMEkrMXgxV2I4b0grMXJKTU9KeGFQdlV4SGlMc0hR?=
 =?utf-8?B?T3hXVWdwbzV4bkxrSHBBSzRsVEkyZUIzZjRTZGJCL1lHdlRxdUt3c1ZNb2FP?=
 =?utf-8?B?M3Z3TGxaeXJ0RmMzaVpSWUVWYmZvQ1dIQ251WEE4TzYrd3BMOTk3b1RVaEJu?=
 =?utf-8?B?NjFFZDRrZ1NxRy9HVEMzdis1OXhKRTExekUwUjE5V0lQY1hmd2JJeHhUZDgv?=
 =?utf-8?Q?LHMz1o+Wqm/GRBR5NuC3qwPvC?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 31dd3e34-4a08-4c90-5c18-08dc867bffa8
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jun 2024 22:57:10.7957
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7NtMuEDrco3kyaMXay1CX9FyOhcXjjPdrEmdS1Y+XM3msh1E+M1I5E2k6jRSiBqhi0Ayz3gHy0i759cfdBksqwNEjlCK8rHGjNSkSj3p9TI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB7692

SGkgRW5ndWVycmFuZCwNCg0KV2Ugc3RpbGwgY2FuJ3QgcmVwcm9kdWNlIHdoYXQgeW91IG9ic2Vy
dmVkIHdpdGggS1NaOTg5Ny4NCg0KSnVzdCB0byBiZSBzdXJlLCB5b3UgYWNjZXNzZWQgUEhZIHJl
Z2lzdGVyIG9mIFBvcnQgNiB3aGljaCBpcyBHTUFDNi4NCkl0IGlzIGRpcmVjdGx5IGNvbm5lY3Rl
ZCB0byBNQUMgb2YgaS5NWDZVTEwgb3ZlciBSTUlJLg0KSSBndWVzcyB0aGUgUEhZIElEIGFjY2Vz
cyBpcyByZWdpc3RlciAweDYxMDQtMHg2MTA1IG9mIEtTWjk4OTcuDQpBbmQsIHJldHVybiB2YWx1
ZSBvZiBQSFkgSUQgaXMgMHgwMDIyLTB4MTU2MS4NCg0KQ29ycmVjdCB1bmRlcnN0YW5kaW5nPw0K
DQpUaGFua3MuDQpXb29qdW5nDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJv
bTogRW5ndWVycmFuZCBkZSBSaWJhdWNvdXJ0IDxlbmd1ZXJyYW5kLmRlLQ0KPiByaWJhdWNvdXJ0
QHNhdm9pcmZhaXJlbGludXguY29tPg0KPiBTZW50OiBXZWRuZXNkYXksIEp1bmUgNSwgMjAyNCA0
OjM0IEFNDQo+IFRvOiBXb29qdW5nIEh1aCAtIEMyMTY5OSA8V29vanVuZy5IdWhAbWljcm9jaGlw
LmNvbT4NCj4gQ2M6IGFuZHJld0BsdW5uLmNoOyBoa2FsbHdlaXQxQGdtYWlsLmNvbTsgbGludXhA
YXJtbGludXgub3JnLnVrOw0KPiBVTkdMaW51eERyaXZlciA8VU5HTGludXhEcml2ZXJAbWljcm9j
aGlwLmNvbT47IGhvcm1zQGtlcm5lbC5vcmc7IFRyaXN0cmFtIEhhDQo+IC0gQzI0MjY4IDxUcmlz
dHJhbS5IYUBtaWNyb2NoaXAuY29tPjsgQXJ1biBSYW1hZG9zcyAtIEkxNzc2OQ0KPiA8QXJ1bi5S
YW1hZG9zc0BtaWNyb2NoaXAuY29tPjsgbmV0ZGV2QHZnZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0
OiBSZTogW1BBVENIIG5ldCB2NSAxLzRdIG5ldDogcGh5OiBtaWNyZWw6IGFkZCBNaWNyb2NoaXAg
S1NaIDk4OTcNCj4gU3dpdGNoIFBIWSBzdXBwb3J0DQo+IA0KPiBFWFRFUk5BTCBFTUFJTDogRG8g
bm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNzIHlvdSBrbm93IHRoZQ0K
PiBjb250ZW50IGlzIHNhZmUNCj4gDQo+IEhlbGxvLA0KPiANCj4gT24gMDQvMDYvMjAyNCAyMjo0
OSwgV29vanVuZy5IdWhAbWljcm9jaGlwLmNvbSB3cm90ZToNCj4gPiBIaSBFbmd1ZXJyYW5kLA0K
PiA+DQo+ID4gQ2FuIHlvdSBoZWxwIG1lIHRvIHVuZGVyc3RhbmQgeW91ciBzZXR1cD8gSSBjb3Vs
ZCBzZWUgeW91IGFyZSB1c2luZw0KPiA+ICAgLSBIb3N0IENQVSA6IGkuTVg2VUxMDQo+ID4gICAt
IERTQSBTd2l0Y2ggOiBLU1o5ODk3UiAoaHR0cHM6Ly93d3cubWljcm9jaGlwLmNvbS9lbi11cy9w
cm9kdWN0L2tzejk4OTcpDQo+ID4gICAtIEhvc3QtdG8tS1NaIGludGVyZmFjZSA6IFJHTUlJIGZv
ciBkYXRhIHBhdGggJiBTUEkgZm9yIGNvbnRyb2wNCj4gPiBCYXNlZCBvbiB0aGlzLCBDUFUgcG9y
dCBpcyBlaXRoZXIgR01BQzYgb3IgR01BQzcgKEZpZ3VyZSAyLTEgb2YgWzFdKQ0KPiA+DQo+ID4g
SSBoYXZlIHR3byBxdWVzdGlvbnMgZm9yIHlvdS4NCj4gPiAxLiBQSFkgb24gQ1BVIHBvcnQNCj4g
PiAgICAgV2hpY2ggR01BQyAob3IgcG9ydCBudW1iZXIpIGlzIGNvbm5lY3RlZCBiZXR3ZWVuIEhv
c3QgQ1BVIGFuZCBLU1o5ODk3Uj8NCj4gPiAgICAgSWYgQ1BVIHBvcnQgaXMgZWl0aGVyIEdNQUM2
IG9yIEdNQUM3LCBpdCBpcyBqdXN0IGEgTUFDLXRvLU1BQw0KPiBjb25uZWN0aW9uIG92ZXIgUkdN
SUkuDQo+IA0KPiBJJ20gdXNpbmcgcG9ydCBudW1iZXIgNiBhcyB0aGUgQ1BVIHBvcnQgZm9yIEtT
Wjk4OTdSLiBHTUFDNiBpcyBkaXJlY3RseQ0KPiBjb25uZWN0ZWQgdG8gdGhlIE1BQyBvZiBpLk1Y
NlVMTCAoZHJpdmVyIGlzIGkuTVggZmVjKS4gSSdtIHVzaW5nIFJNSUkNCj4gc2luY2UgZ2lnYWJp
dCBpcyBub3Qgc3VwcG9ydGVkIGJ5IHRoZSBpLk1YNlVMTC4NCj4gDQo+ID4gMi4gUEhZIElEDQo+
ID4gICAgIEl0cyBQSFkgSUQgaXMgZGlmZmVyZW50IHdoZW4gY2hlY2tpbmcgZGF0YXNoZWV0IG9m
IEtTWjk4OTcgYW5kIEtTWjgwODEuDQo+ID4gICAgIFBIWSBJRCBvZiBQb3J0IDEtNSBvZiBLU1o5
ODk3IGlzIDB4MDAyMi0weDE2MzEgcGVyIFsxXQ0KPiA+ICAgICBQSFkgSUQgb2YgS1NaODA4MSBp
cyAweDAwMjItMHgwMTU2eCBwZXIgWzJdDQo+IFRoYXQncyB0cnVlIGZvciBwb3J0IDEtNSwgaG93
ZXZlciwgSSBmb3VuZCBvdXQgdGhhdCB0aGUgcGh5X2lkIGVtaXR0ZWQNCj4gYnkgR01BQzYgaXMg
MHgwMDIyMTU2MS4gSXQgaXMgdGhlIHNhbWUgYXMgS1NaODA4MS1yZXZBMyBhY2NvcmRpbmcgdG8g
dGhlDQo+IGRhdGFzaGVldC4gSSBhbHNvIHN0dWRpZWQgYWxsIHJlZ2lzdGVycyBhdCBydW50aW1l
IGZvciBhIHJlbGlhYmxlDQo+IGRpZmZlcmVuY2UgdG8gaW1wbGVtZW50IHNvbWV0aGluZyBsaWtl
IGtzejgwNTFfa3N6ODc5NV9tYXRjaF9waHlfZGV2aWNlDQo+IGJldHdlZW4gR01BQzYgYW5kIEtT
WjgwODEsIGJ1dCBub25lIGFwcGVhcmVkIHRvIG1lLiBGb2xsb3dpbmcNCj4gc3VnZ2VzdGlvbnMg
YnkgQW5kcmV3IEx1bm4sIEkgYWRkZWQgdGhpcyB2aXJ0dWFsIHBoeV9pZCAoMHgwMDIyMTdmZikg
dG8NCj4gaGFyZGNvZGUgaW4gdGhlIGRldmljZXRyZWUuIEknbSBoYXBweSB3aXRoIHRoaXMgc29s
dXRpb24uDQo+ID4NCj4gPiBCZXNpZGUgcGF0Y2gsIHlvdSBjYW4gY3JlYXRlIGEgdGlja2V0IHRv
IE1pY3JvY2hpcCBzaXRlDQo+IChodHRwczovL21pY3JvY2hpcHN1cHBvcnQuZm9yY2UuY29tL3Mv
c3VwcG9ydHNlcnZpY2UpDQo+ID4gaWYgeW91IHRoaW5rIGl0IGlzIGVhc2llciB0byBzb2x2ZSB5
b3VyIHByb2JsZW0uDQo+IEkgY3JlYXRlZCBhIGpvaW5lZCB0aWNrZXQgZm9yIHRyYWNraW5nIChD
YXNlIG51bWJlciAwMTQ1NzI3OSkuDQo+ID4NCj4gDQo+IFRoYW5rIHlvdSB2ZXJ5IG11Y2ggZm9y
IHlvdXIgdGltZSwNCj4gDQo+IEVuZ3VlcnJhbmQgZGUgUmliYXVjb3VydA0KPiANCj4gPiBCZXN0
IHJlZ2FyZHMsDQo+ID4gV29vanVuZw0KPiA+DQo+ID4gWzFdDQo+IGh0dHBzOi8vd3cxLm1pY3Jv
Y2hpcC5jb20vZG93bmxvYWRzL2FlbURvY3VtZW50cy9kb2N1bWVudHMvT1RIL1Byb2R1Y3REb2N1
bWUNCj4gbnRzL0RhdGFTaGVldHMvS1NaOTg5N1ItRGF0YS1TaGVldC1EUzAwMDAyMzMwRC5wZGYN
Cj4gPiBbMl0gaHR0cHM6Ly93d3cubWljcm9jaGlwLmNvbS9lbi11cy9wcm9kdWN0L2tzejgwODEj
ZG9jdW1lbnQtdGFibGUNCj4gPg0KPiA+PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+
PiBGcm9tOiBFbmd1ZXJyYW5kIGRlIFJpYmF1Y291cnQgPGVuZ3VlcnJhbmQuZGUtDQo+ID4+IHJp
YmF1Y291cnRAc2F2b2lyZmFpcmVsaW51eC5jb20+DQo+ID4+IFNlbnQ6IFR1ZXNkYXksIEp1bmUg
NCwgMjAyNCA1OjIzIEFNDQo+ID4+IFRvOiBuZXRkZXZAdmdlci5rZXJuZWwub3JnDQo+ID4+IENj
OiBhbmRyZXdAbHVubi5jaDsgaGthbGx3ZWl0MUBnbWFpbC5jb207IGxpbnV4QGFybWxpbnV4Lm9y
Zy51azsgV29vanVuZw0KPiBIdWgNCj4gPj4gLSBDMjE2OTkgPFdvb2p1bmcuSHVoQG1pY3JvY2hp
cC5jb20+OyBVTkdMaW51eERyaXZlcg0KPiA+PiA8VU5HTGludXhEcml2ZXJAbWljcm9jaGlwLmNv
bT47IGhvcm1zQGtlcm5lbC5vcmc7IFRyaXN0cmFtIEhhIC0gQzI0MjY4DQo+ID4+IDxUcmlzdHJh
bS5IYUBtaWNyb2NoaXAuY29tPjsgQXJ1biBSYW1hZG9zcyAtIEkxNzc2OQ0KPiA+PiA8QXJ1bi5S
YW1hZG9zc0BtaWNyb2NoaXAuY29tPjsgRW5ndWVycmFuZCBkZSBSaWJhdWNvdXJ0IDxlbmd1ZXJy
YW5kLmRlLQ0KPiA+PiByaWJhdWNvdXJ0QHNhdm9pcmZhaXJlbGludXguY29tPg0KPiA+PiBTdWJq
ZWN0OiBbUEFUQ0ggbmV0IHY1IDEvNF0gbmV0OiBwaHk6IG1pY3JlbDogYWRkIE1pY3JvY2hpcCBL
U1ogOTg5Nw0KPiBTd2l0Y2gNCj4gPj4gUEhZIHN1cHBvcnQNCj4gPj4NCj4gPj4gRVhURVJOQUwg
RU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3Ug
a25vdw0KPiB0aGUNCj4gPj4gY29udGVudCBpcyBzYWZlDQo+ID4+DQo+ID4+IFRoZXJlIGlzIGEg
RFNBIGRyaXZlciBmb3IgbWljcm9jaGlwLGtzejk4OTcgd2hpY2ggY2FuIGJlIGNvbnRyb2xsZWQN
Cj4gPj4gdGhyb3VnaCBTUEkgb3IgSTJDLiBUaGlzIHBhdGNoIGFkZHMgc3VwcG9ydCBmb3IgaXQn
cyBDUFUgcG9ydHMgUEhZcyB0bw0KPiA+PiBhbHNvIGFsbG93IG5ldHdvcmsgYWNjZXNzIHRvIHRo
ZSBzd2l0Y2gncyBDUFUgcG9ydC4NCj4gPj4NCj4gPj4gVGhlIENQVSBwb3J0cyBQSFlzIG9mIHRo
ZSBLU1o5ODk3IGFyZSBub3QgZG9jdW1lbnRlZCBpbiB0aGUgZGF0YXNoZWV0Lg0KPiA+PiBUaGV5
IHdlaXJkbHkgdXNlIHRoZSBzYW1lIFBIWSBJRCBhcyB0aGUgS1NaODA4MSwgd2hpY2ggaXMgYSBk
aWZmZXJlbnQNCj4gPj4gUEhZIGFuZCB0aGF0IGRyaXZlciBpc24ndCBjb21wYXRpYmxlIHdpdGgg
S1NaOTg5Ny4gQmVmb3JlIHRoaXMgcGF0Y2gsDQo+ID4+IHRoZSBLU1o4MDgxIGRyaXZlciB3YXMg
dXNlZCBmb3IgdGhlIENQVSBwb3J0cyBvZiB0aGUgS1NaOTg5NyBidXQgdGhlDQo+ID4+IGxpbmsg
d291bGQgbmV2ZXIgY29tZSB1cC4NCj4gPj4NCj4gPj4gQSBuZXcgZHJpdmVyIGZvciB0aGUgS1Na
OTg5NyBpcyBhZGRlZCwgYmFzZWQgb24gdGhlIGNvbXBhdGlibGUgS1NaODdYWC4NCj4gPj4gSSBj
b3VsZCBub3QgdGVzdCBpZiBHaWdhYml0IEV0aGVybmV0IHdvcmtzLCBidXQgdGhlIGxpbmsgY29t
ZXMgdXAgYW5kDQo+ID4+IGNhbiBzdWNjZXNzZnVsbHkgYWxsb3cgcGFja2V0cyB0byBiZSBzZW50
IGFuZCByZWNlaXZlZCB3aXRoIERTQSB0YWdzLg0KPiA+Pg0KPiA+PiBUbyByZXNvbHZlIHRoZSBL
U1o4MDgxL0tTWjk4OTcgcGh5X2lkIGNvbmZsaWN0cywgSSBjb3VsZCBub3QgZmluZCBhbnkNCj4g
Pj4gc3RhYmxlIHJlZ2lzdGVyIHRvIGRpc3Rpbmd1aXNoIHRoZW0uIEluc3RlYWQgb2YgYSBtYXRj
aF9waHlfZGV2aWNlKCkgLA0KPiA+PiBJJ3ZlIGRlY2xhcmVkIGEgdmlydHVhbCBwaHlfaWQgd2l0
aCB0aGUgaGlnaGVzdCB2YWx1ZSBpbiBNaWNyb2NoaXAncyBPVUkNCj4gPj4gcmFuZ2UuDQo+ID4+
DQo+ID4+IEV4YW1wbGUgdXNhZ2UgaW4gdGhlIGRldmljZSB0cmVlOg0KPiA+PiAgICAgICAgICBj
b21wYXRpYmxlID0gImV0aGVybmV0LXBoeS1pZDAwMjIuMTdmZiI7DQo+ID4+DQo+ID4+IEEgZGlz
Y3Vzc2lvbiB0byBmaW5kIGJldHRlciBhbHRlcm5hdGl2ZXMgaGFkIGJlZW4gb3BlbmVkIHdpdGgg
dGhlDQo+ID4+IE1pY3JvY2hpcCB0ZWFtLCB3aXRoIG5vIHJlc3BvbnNlIHlldC4NCj4gPj4NCj4g
Pj4gU2VlIGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2FsbC8yMDIyMDIwNzE3NDUzMi4zNjI3ODEt
MS1lbmd1ZXJyYW5kLmRlLQ0KPiA+PiByaWJhdWNvdXJ0QHNhdm9pcmZhaXJlbGludXguY29tLw0K
PiA+Pg0KPiA+PiBGaXhlczogYjk4N2U5OGU1MGFiICgiZHNhOiBhZGQgRFNBIHN3aXRjaCBkcml2
ZXIgZm9yIE1pY3JvY2hpcCBLU1o5NDc3IikNCj4gPj4gU2lnbmVkLW9mZi1ieTogRW5ndWVycmFu
ZCBkZSBSaWJhdWNvdXJ0IDxlbmd1ZXJyYW5kLmRlLQ0KPiA+PiByaWJhdWNvdXJ0QHNhdm9pcmZh
aXJlbGludXguY29tPg0KPiA+PiAtLS0NCj4gPj4gdjU6DQo+ID4+ICAgLSByZXdyYXAgY29tbWVu
dHMNCj4gPj4gICAtIHJlc3RvcmUgc3VzcGVuZC9yZXN1bWUgZm9yIEtTWjk4OTcNCj4gPj4gdjQ6
IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2FsbC8yMDI0MDUzMTE0MjQzMC42NzgxOTgtMi1lbmd1
ZXJyYW5kLmRlLQ0KPiA+PiByaWJhdWNvdXJ0QHNhdm9pcmZhaXJlbGludXguY29tLw0KPiA+PiAg
IC0gcmViYXNlIG9uIG5ldC9tYWluDQo+ID4+ICAgLSBhZGQgRml4ZXMgdGFnDQo+ID4+ICAgLSB1
c2UgcHNldWRvIHBoeV9pZCBpbnN0ZWFkIG9mIG9mX3RyZWUgc2VhcmNoDQo+ID4+IHYzOiBodHRw
czovL2xvcmUua2VybmVsLm9yZy9hbGwvMjAyNDA1MzAxMDI0MzYuMjI2MTg5LTItZW5ndWVycmFu
ZC5kZS0NCj4gPj4gcmliYXVjb3VydEBzYXZvaXJmYWlyZWxpbnV4LmNvbS8NCj4gPj4gLS0tDQo+
ID4+ICAgZHJpdmVycy9uZXQvcGh5L21pY3JlbC5jICAgfCAxMyArKysrKysrKysrKystDQo+ID4+
ICAgaW5jbHVkZS9saW51eC9taWNyZWxfcGh5LmggfCAgNCArKysrDQo+ID4+ICAgMiBmaWxlcyBj
aGFuZ2VkLCAxNiBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+ID4+DQo+ID4+IGRpZmYg
LS1naXQgYS9kcml2ZXJzL25ldC9waHkvbWljcmVsLmMgYi9kcml2ZXJzL25ldC9waHkvbWljcmVs
LmMNCj4gPj4gaW5kZXggOGMyMGNmOTM3NTMwLi4xMWU1OGZjNjI4ZGYgMTAwNjQ0DQo+ID4+IC0t
LSBhL2RyaXZlcnMvbmV0L3BoeS9taWNyZWwuYw0KPiA+PiArKysgYi9kcml2ZXJzL25ldC9waHkv
bWljcmVsLmMNCj4gPj4gQEAgLTE2LDcgKzE2LDcgQEANCj4gPj4gICAgKiAgICAgICAgICAgICAg
ICAgICAgICAgIGtzejgwODEsIGtzejgwOTEsDQo+ID4+ICAgICogICAgICAgICAgICAgICAgICAg
ICAgICBrc3o4MDYxLA0KPiA+PiAgICAqICAgICAgICAgICAgIFN3aXRjaCA6IGtzejg4NzMsIGtz
ejg4NngNCj4gPj4gLSAqICAgICAgICAgICAgICAgICAgICAgIGtzejk0NzcsIGxhbjg4MDQNCj4g
Pj4gKyAqICAgICAgICAgICAgICAgICAgICAgIGtzejk0NzcsIGtzejk4OTcsIGxhbjg4MDQNCj4g
Pj4gICAgKi8NCj4gPj4NCj4gPj4gICAjaW5jbHVkZSA8bGludXgvYml0ZmllbGQuaD4NCj4gPj4g
QEAgLTU1NDUsNiArNTU0NSwxNiBAQCBzdGF0aWMgc3RydWN0IHBoeV9kcml2ZXIga3NwaHlfZHJp
dmVyW10gPSB7DQo+ID4+ICAgICAgICAgIC5zdXNwZW5kICAgICAgICA9IGdlbnBoeV9zdXNwZW5k
LA0KPiA+PiAgICAgICAgICAucmVzdW1lICAgICAgICAgPSBrc3o5NDc3X3Jlc3VtZSwNCj4gPj4g
ICAgICAgICAgLmdldF9mZWF0dXJlcyAgID0ga3N6OTQ3N19nZXRfZmVhdHVyZXMsDQo+ID4+ICt9
LCB7DQo+ID4+ICsgICAgICAgLnBoeV9pZCAgICAgICAgID0gUEhZX0lEX0tTWjk4OTcsDQo+ID4+
ICsgICAgICAgLnBoeV9pZF9tYXNrICAgID0gTUlDUkVMX1BIWV9JRF9NQVNLLA0KPiA+PiArICAg
ICAgIC5uYW1lICAgICAgICAgICA9ICJNaWNyb2NoaXAgS1NaOTg5NyBTd2l0Y2giLA0KPiA+PiAr
ICAgICAgIC8qIFBIWV9CQVNJQ19GRUFUVVJFUyAqLw0KPiA+PiArICAgICAgIC5jb25maWdfaW5p
dCAgICA9IGtzenBoeV9jb25maWdfaW5pdCwNCj4gPj4gKyAgICAgICAuY29uZmlnX2FuZWcgICAg
PSBrc3o4ODczbWxsX2NvbmZpZ19hbmVnLA0KPiA+PiArICAgICAgIC5yZWFkX3N0YXR1cyAgICA9
IGtzejg4NzNtbGxfcmVhZF9zdGF0dXMsDQo+ID4+ICsgICAgICAgLnN1c3BlbmQgICAgICAgID0g
Z2VucGh5X3N1c3BlbmQsDQo+ID4+ICsgICAgICAgLnJlc3VtZSAgICAgICAgID0gZ2VucGh5X3Jl
c3VtZSwNCj4gPj4gICB9IH07DQo+ID4+DQo+ID4+ICAgbW9kdWxlX3BoeV9kcml2ZXIoa3NwaHlf
ZHJpdmVyKTsNCj4gPj4gQEAgLTU1NzAsNiArNTU4MCw3IEBAIHN0YXRpYyBzdHJ1Y3QgbWRpb19k
ZXZpY2VfaWQgX19tYXliZV91bnVzZWQNCj4gPj4gbWljcmVsX3RibFtdID0gew0KPiA+PiAgICAg
ICAgICB7IFBIWV9JRF9MQU44ODE0LCBNSUNSRUxfUEhZX0lEX01BU0sgfSwNCj4gPj4gICAgICAg
ICAgeyBQSFlfSURfTEFOODgwNCwgTUlDUkVMX1BIWV9JRF9NQVNLIH0sDQo+ID4+ICAgICAgICAg
IHsgUEhZX0lEX0xBTjg4NDEsIE1JQ1JFTF9QSFlfSURfTUFTSyB9LA0KPiA+PiArICAgICAgIHsg
UEhZX0lEX0tTWjk4OTcsIE1JQ1JFTF9QSFlfSURfTUFTSyB9LA0KPiA+PiAgICAgICAgICB7IH0N
Cj4gPj4gICB9Ow0KPiA+Pg0KPiA+PiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9taWNyZWxf
cGh5LmggYi9pbmNsdWRlL2xpbnV4L21pY3JlbF9waHkuaA0KPiA+PiBpbmRleCA1OTFiZjViNWU4
ZGMuLjgxY2MxNmRjMmRkZiAxMDA2NDQNCj4gPj4gLS0tIGEvaW5jbHVkZS9saW51eC9taWNyZWxf
cGh5LmgNCj4gPj4gKysrIGIvaW5jbHVkZS9saW51eC9taWNyZWxfcGh5LmgNCj4gPj4gQEAgLTM5
LDYgKzM5LDEwIEBADQo+ID4+ICAgI2RlZmluZSBQSFlfSURfS1NaODdYWCAgICAgICAgIDB4MDAy
MjE1NTANCj4gPj4NCj4gPj4gICAjZGVmaW5lICAgICAgICBQSFlfSURfS1NaOTQ3NyAgICAgICAg
ICAweDAwMjIxNjMxDQo+ID4+ICsvKiBQc2V1ZG8gSUQgdG8gc3BlY2lmeSBpbiBjb21wYXRpYmxl
IGZpZWxkIG9mIGRldmljZSB0cmVlLg0KPiA+PiArICogT3RoZXJ3aXNlIHRoZSBkZXZpY2UgcmVw
b3J0cyB0aGUgc2FtZSBJRCBhcyBLU1o4MDgxIG9uIENQVSBwb3J0cy4NCj4gPj4gKyAqLw0KPiA+
PiArI2RlZmluZSAgICAgICAgUEhZX0lEX0tTWjk4OTcgICAgICAgICAgMHgwMDIyMTdmZg0KPiA+
Pg0KPiA+PiAgIC8qIHN0cnVjdCBwaHlfZGV2aWNlIGRldl9mbGFncyBkZWZpbml0aW9ucyAqLw0K
PiA+PiAgICNkZWZpbmUgTUlDUkVMX1BIWV81ME1IWl9DTEsgICBCSVQoMCkNCj4gPj4gLS0NCj4g
Pj4gMi4zNC4xDQo+ID4NCg==

