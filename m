Return-Path: <netdev+bounces-118243-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C95395104F
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 01:10:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 153581C20B26
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 23:10:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECADB1AB53B;
	Tue, 13 Aug 2024 23:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="exZEpi9H";
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="RVej9Oc8"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78CB436B11;
	Tue, 13 Aug 2024 23:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.153.233
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723590622; cv=fail; b=qtjUb1wR6xeHIDAQ1hnIL8gDXgMnhXGWC9xBcVvjydZtoNo+pOTkTeKmjven4UVHBgN/iuXdpHz8e90PG9P2Ysy/wk3KRKoQ2avcDdsEkAul7pbWLmsI1E4n7/bwvDkRPWRaUTDLX6ig90CSBrw9bSC9pbhz/AwAVR2UV0Z5it8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723590622; c=relaxed/simple;
	bh=/ybTkzDs65i+P8B9xfhs1bIvcFwSaPCkVyKjBWHWmFg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Q+HFkJVMp5EVasw8SYgbA7HJXmAyOCuyW31FV73ukI64FdNZwFF66ZtK0vfINqVXqEB+Bet16SvfYl1M3Y2r3lJSJxwvccdcHhlbGOr4pcUomO4E+y2bG7Y3MEO1td5CmtW1vylCbVjVvAapwQpddfIl1keh+OQLJsUI3g30rmI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=exZEpi9H; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=RVej9Oc8; arc=fail smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1723590620; x=1755126620;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=/ybTkzDs65i+P8B9xfhs1bIvcFwSaPCkVyKjBWHWmFg=;
  b=exZEpi9HdnhgxMj1IGwswwC2gTN6cVR1a2eMr6Iw2ucYB2pGYOe/18Gr
   fJG5h9PJl98G9IpBnoJehhzQySl05iOhXQPW65VSm0RuOE6ksFA+kn+KY
   DZHIbqXMJ6HRmTatqAE/byy0oS56EwIy59T5pk69XFxwq2qMImkiMy9qn
   rzmmRkKAYReWnVeeyHGT8vvXTGkRTKjNcmCoWyTjhWeVEs/HVqAJOR712
   WpVYRbQ86++2ZCESJ5GvqUZrFNJkdbXq+u6GbSmn2HIgXIoxQZQW2/jxA
   SPofUJIljB16fvqpsQoFjMyQ5cDES0Q10CrURt/sd3FeyEIr8KixAgzuy
   w==;
X-CSE-ConnectionGUID: /XlGtsu+QbaO84z3DYO+fw==
X-CSE-MsgGUID: iK/8qdttSbWAQRk5iUKqRQ==
X-IronPort-AV: E=Sophos;i="6.09,287,1716274800"; 
   d="scan'208";a="261372822"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 13 Aug 2024 16:10:19 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 13 Aug 2024 16:09:51 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (10.10.215.250)
 by email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 13 Aug 2024 16:09:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KlmHfE3TmFh0Bn3NVFDfJ5FZrxVS1xtiLJEqSpf0AMuLlqiihlrk5Y7QMco/2tuD6vPkJoXI//crVll8myxh9B8BZ9HrSWbuTbc3ZPrWeevs6DSH8CnDnqyXZMvu6RrE1bzQPIu18buX2tKosv+YRaAue2u0YYEfnqtvAApY6UpaBom90sa2pULAnplYL03h0RfTYSd0CoPd8JkgwSIjYPnbKKrbL6ibJV7cxGWWh69o9bWNrnSal94HeMJ9Iue6yurEYIVtgn+UhLOXf0MqwF64IjM85wfVz1LekgsXiWM4bnl3g3AQaQ6s5Mopus73lNtLHf8xCMwX9lBYNnVB+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/ybTkzDs65i+P8B9xfhs1bIvcFwSaPCkVyKjBWHWmFg=;
 b=wN3S0etBfpGsu8Ru/WvX+Dc8pxNC4KZ+wrGYDD/Zwmy22QUx12+RJiyWikYXuYOgYD1+29hYTHhscEddttB4ARQyaRwyXs6N1xKq9p4nvllrB4V4YHwc/tRQ6m/aBZBQgloN26zbEZdXQ8bL1xrZ4n/Jm0EziLt0UJymGh98xJcaeFgxOe/HBnl9a51kY/BGRp5OoXDpPK2Y1nC5J6laeg+WQd4ifrFfv0F2+9d2fyrQnoQqKAgNZ2grGkDmlB9BC+B7mcLxL/1Sp9kK60qwId5MVmNotZewnK4hTE1tEqTUP1TY2FOaocWnjkV5jyAumh9No+we7wGvwLvZTS1i2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/ybTkzDs65i+P8B9xfhs1bIvcFwSaPCkVyKjBWHWmFg=;
 b=RVej9Oc8rwNDWHjdyLS324VHe94l3+uHJtNj+oEYaJti64KIlwE9bilyytBbUpw0K08EQRy4sYohtNiMjg4yIfZostxG1LjA6mRXzgjDlITX0j2AO1rqR5IvbU4STWJ+X+F7Kicq8wtagvpDCYO2Al7FNkuSJ2X/vJK1ENiYYf2JUhPbtcDh0jQGqBUJFX/3b6Qsk1dl99Kdc4g3i3ndbzGQF3Y96zkLYrD0Kzobhi5kctQw3mCfQKM0Fl+0/xA15He/5oQbSelfcqG9hMXijiBCdVqS4ZWBBMloxuZuhzxVk/JlhvSFO2peHPnwaSvOwac4lqhXmzG0CEPuiqeAgQ==
Received: from BYAPR11MB3558.namprd11.prod.outlook.com (2603:10b6:a03:b3::11)
 by PH0PR11MB7447.namprd11.prod.outlook.com (2603:10b6:510:28b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.31; Tue, 13 Aug
 2024 23:09:48 +0000
Received: from BYAPR11MB3558.namprd11.prod.outlook.com
 ([fe80::c03a:b12:f801:d3f6]) by BYAPR11MB3558.namprd11.prod.outlook.com
 ([fe80::c03a:b12:f801:d3f6%7]) with mapi id 15.20.7828.023; Tue, 13 Aug 2024
 23:09:48 +0000
From: <Tristram.Ha@microchip.com>
To: <krzk@kernel.org>, <krzk+dt@kernel.org>
CC: <davem@davemloft.net>, <conor+dt@kernel.org>, <edumazet@google.com>,
	<robh@kernel.org>, <olteanv@gmail.com>, <f.fainelli@gmail.com>,
	<andrew@lunn.ch>, <devicetree@vger.kernel.org>,
	<UNGLinuxDriver@microchip.com>, <Woojung.Huh@microchip.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <marex@denx.de>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH net-next 1/4] dt-bindings: net: dsa: microchip: add SGMII
 port support to KSZ9477 switch
Thread-Topic: [PATCH net-next 1/4] dt-bindings: net: dsa: microchip: add SGMII
 port support to KSZ9477 switch
Thread-Index: AQHa6rVb6R5b4khOr0216lt4AbdkW7IgYQ8AgAV0fnA=
Date: Tue, 13 Aug 2024 23:09:48 +0000
Message-ID: <BYAPR11MB355819407FDCD6E1E601BB33EC862@BYAPR11MB3558.namprd11.prod.outlook.com>
References: <20240809233840.59953-1-Tristram.Ha@microchip.com>
 <20240809233840.59953-2-Tristram.Ha@microchip.com>
 <6f28c65f-c91f-4210-934f-7479c9a6f719@kernel.org>
In-Reply-To: <6f28c65f-c91f-4210-934f-7479c9a6f719@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR11MB3558:EE_|PH0PR11MB7447:EE_
x-ms-office365-filtering-correlation-id: 26410a5e-6c34-49b3-2856-08dcbbed077c
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3558.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?VEZyeVFQZG5UVWgyY1E0SUlrNXZNOGp1YTJ2TzRvdkc5UXBnM1BZWWh2Mk9m?=
 =?utf-8?B?djJwbWFpMHpoWDRpYlE3S2IrNXdUa3pzMUs1UGdlN0JCQ0pMcmwwNFh0dHhQ?=
 =?utf-8?B?MjBreFcyK3UzUDdaTldtUGpVL0lROXpCNFZ0bzZYUHMwK1l1TVEvb2NYd0Fz?=
 =?utf-8?B?cDlsMVhzZk1OVG1DM21YeDFScmhNVzlqY0VUYURKQmYvVE84MlF1NzE0NFE2?=
 =?utf-8?B?MlQ0M0xyZmpvbEJ1WDJLQmk0M0hnNHJjY0tpYlFTMWhEUDFXUFdLRDRVUGFT?=
 =?utf-8?B?SVZKUzM2aUVTZGNnUGJOdUwvdkNFaHlWdERxZnJ6cklQVFVLTzhUS0VQMW1v?=
 =?utf-8?B?RXBjZThiSFpPUEdtUm5SYklZYmNOcnhVeWg0M2FSdkhjc1VZeFpESGNuZ2NL?=
 =?utf-8?B?TXk0NFVkSUJ0dm5nN2lzWTFWM0FIZFRkdHMvWm5zMG8xNU9lOXBTZWc0S09v?=
 =?utf-8?B?bWk2WFpyYkZldWdEQzJOTGI3ajNWUjBrR0NHWWg5dWFqQm8zbTIrMFV0QzRm?=
 =?utf-8?B?TjY3Ly9DNnlDYWNSbWMwTExxeXFkbTI2NjFLZkFsUnUzZUVPWWt6SnRhNWwx?=
 =?utf-8?B?Q25nNlpFd0EzcnZpSHltN2dqNE5YVzlHcmZCY1pIWE5QTS9kdjZCT2NDYnVo?=
 =?utf-8?B?b1luZUcwWXhkNlRrc1dwSjNMRk50SHJVaXpsRzZwNk5iYUNBaWFZaUFBYTdv?=
 =?utf-8?B?WjhiSkYvd3A0N2NzQWZVT0RYUktKMVJKNytzM1Y4Y0dJQk5jR0I5V3cwUVJz?=
 =?utf-8?B?VXVFcHMvRTVWV0w4R0JaUHRzd3AyNWNEcWltTUIxVzh0bzkxTEZTL3NSNnpR?=
 =?utf-8?B?VG9oVTVpYm5aYXplTFVCQzI5VHU4T2MraEFKeHpWNXF6aHA4ZUU4RUljOXBU?=
 =?utf-8?B?cDZkQTA1bnJrbjZ2aWdqbTBRSzdnamFMYk12ZzZxOCtRa3UxTGx3ZEc5MjBi?=
 =?utf-8?B?Vi9XQ2pqSFJEOHR5RGRWQzJVcjBaSktqYVdXT0hmdWhjRENQcXpDOW1GMFhM?=
 =?utf-8?B?ek9RTU8rTHp3c1pIVldDeFdPUjRaTUw0NXhSRnpmczJQVmFXa3NEZTVReUJN?=
 =?utf-8?B?OXREQVMzeXl4bWVHamtDZWJYVWUrK0s2QmFsK3hVMTJGZTRCR2xDOEkxUU1P?=
 =?utf-8?B?Y1BERnRubHJxdEE0aHBNSTdBTE14Y2w2eGVrYm5aakxkYmlQN1JPRlJGeW05?=
 =?utf-8?B?dnFDZXR3VGdXNy94ZDIzOVpTMlNTMTBpR29DMllBOXFWOURxZHdYMlFva3gw?=
 =?utf-8?B?SmlZTWhBRGMwSmlvSlhRL2Nzbmk1K0J4M3JhdkFMM0Zpc1haRjBScmpXb0xN?=
 =?utf-8?B?V2RwbkZoZ0FXVktYU3ZhSVRIeGIyVnBKQ1REWWJtSHhTdlp1OThESnRRaHE0?=
 =?utf-8?B?NVpqTWNVQ3ZZYThGS2JMelY4eGh2UWVaN29lVWpDbGhpNWVRMC8wd29FU2RS?=
 =?utf-8?B?cHp6RXhocFE1ajFGSkNYTUtrZFpKbGVWcThNdFBWa0k3eDNzUFhpdFpFazhI?=
 =?utf-8?B?bGdPSFhuWjJnREtqOFhTVHNqeEVwN2oydmVLNDBzRFQ0a0wwOTh4QTFNSVlU?=
 =?utf-8?B?dHRJU0dSY1UzR3J2dGs4SDdxaktkVGsvWVZQaXN5Q2VJRzRZbGMzcHZNcjlG?=
 =?utf-8?B?V3czSzYzNk0weTVkbmZGOW9tTzZQdkE5U1VzcERsOFBXRXJHTWJpOWZaU1hO?=
 =?utf-8?B?VzRMalNYbHRQeGFIMTN3Sk9vRWp0dlRUWEw4Z2xWbFpnSTFXK3FFWTFyQnZu?=
 =?utf-8?B?Q2pPN2RwR1czaktQblBrNytmUVNlYkdRZWlIRFk2YUJUelJ6K2dUQmh3SEJi?=
 =?utf-8?B?QU5HVVMwVnd0NDNMZmtiOTJhU29PRzdKYVMxalB4YUNEUzlIc0pZRTRnOThW?=
 =?utf-8?B?UlRpZ0p4RjBxTkR4WlNUVEhjOHVQcyt3a3NyNjRwVzN6OVE9PQ==?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WFNwNjZVanJlcStXbEFHcHY2d1NRYjJLajZobkk0cmFiR1NXZVhjMUk5cVVS?=
 =?utf-8?B?a2VxUUpUa0llZWZxa1Fzd3QvdWdDeFphT1FRd0NSZlArdEtNSkZEZmFhclNm?=
 =?utf-8?B?anJzeDVaSCtmQkFMelBDNTIwdWF6Y1ZqVEphSVIzZW43VVVDUkpwUzhra0Zi?=
 =?utf-8?B?bVBiZ25wOFNWWHUvYmM2UU13Zjc3bTRJT3ArVXI1TU9oeWdoVWNsYXFFZ1Fy?=
 =?utf-8?B?TjNiS242dlpDc3V0ZFRHckZiblltS0JPRUMzWUloa1pIZmdUdGRyUmxaOUJE?=
 =?utf-8?B?eUh3aC9udU9UZWp5WXJXam5ZUXYyMVB5eTZFVmJhRXZRRU1LT3ZRTVZLdFpS?=
 =?utf-8?B?TWg0cktGUkxBK1VrZ1l0TXp1b3dxV3VLemd4aG01UE1LS1Z2VjY2OHlJK0FC?=
 =?utf-8?B?MXlwd0srQXdSNnNNWHlJd2t6UldxbmNIN1MyRFFIMENWYmFRM09kWWI0ZzJG?=
 =?utf-8?B?NEJTSkJDTWxNWk9UcktJbnRoamYwekFCZWd0Z3VidVVDdXc0TXZLNXMwK3o3?=
 =?utf-8?B?Y0NpeVA3Z2p2U3ppOXRxeTh6S3VuMU81Qlc5bWZPTmxCa3pIUXdCKzByamJy?=
 =?utf-8?B?c2M0Mmx1QXdVV1hETUNTbXFjRXc5cE05ZkR2YjFaZytOQWNRVlExNFE3QnpE?=
 =?utf-8?B?dXlVZ0l4bzlkdGJqWm9SbUpTMCt6dW1jVUpaQmptR1lTbGRSUUlKc1VxdXpP?=
 =?utf-8?B?SExyZ0NuclZod3c4Zm5GVEd1djVzQWpKL0RveExKOVQxZjh1UWIzU3BZNUhj?=
 =?utf-8?B?VzYrQkh2TWV1cUovSFNoRDVBbFljNjVsNWh0WXFWcjJwSGJiQWs4TmdkR291?=
 =?utf-8?B?TFMwcFVQemt3ekVXNkxSOVd4aVI3a0F1bCtNcTBzaFdwWEtxZGpXbDJvSXEw?=
 =?utf-8?B?em8xRCtmSHVPb0tEbUpDVURuZm9Obk5XSzdROHNqekFPV0YrV0hBS1gwc3FY?=
 =?utf-8?B?Q3AwQStMaVNUQStJUzhLRGN5NmIvOS92eVIwUDBFbUlTblNuR21iR2NNeVFm?=
 =?utf-8?B?WkpKZERHWjFSQms5WHRIUDBzamRFcy9TcXFoYjg2UmFnUk9aOGhLZ2JNeDZ0?=
 =?utf-8?B?ZWtXd2FwUWdxeTFUVnY4eXp6TGZocS9uMFRlbjAvdG5OeHJmTUg4Y2luTWhz?=
 =?utf-8?B?T0Q5bEd5N1FEdFpWTmJQYnRwQnZ2QnQ0OHJ4UlpaalZ4WEk0YnRGK2RQWGgx?=
 =?utf-8?B?U20vd1FlWEs4OThPYUNGNjNZNldGcnpsZXBuR1hXYTVjVWNhOVZ4d0RsQWRV?=
 =?utf-8?B?Q29nalNyaFdoMDJXYW93ZzkzVC9MK20yeUFjVlJ6dzVteFE0ZmJaMGdXUU9I?=
 =?utf-8?B?TFc0RXJXVklGTWZUZDh1Z2tyQzBxUkFOWHZQbldIWE1Hb2lzYlJBWE1zT0ov?=
 =?utf-8?B?WFd6ZmVXeDVuRkRFamJhRkpkb0poOWZ3enBiQy93b0hCbU5XaFVERTlIOUYy?=
 =?utf-8?B?NmI3MmlndWlyMTFMTDdhTGx5UzdkQXcrOC9SQVFCV1g4Z1hXb3owblFUVVRV?=
 =?utf-8?B?OTlrMlRDNlpDamdwQmpXMzJrMjRRWG8rY0RBVi9YUmkvaXd1d005cFZhanl1?=
 =?utf-8?B?SHhKN00yTmYvbVRyaktkMGcyQnc1ZUJwZW5QalRpUnptSU9xV0lUd0d6Yjh3?=
 =?utf-8?B?eG8xTVRsRmNaYTNtd0lnajZyczlkQ0xxak5NU1hlcHUvNmxSS2JBVUpkL3pD?=
 =?utf-8?B?RXVBb0x0eXFxU1VDUjdBOWFJdUhmTzFCQTFDVWtxQ0k2Q3Y4M3hDZlAyUi9u?=
 =?utf-8?B?djdhL0FjVmhEOElkdnViWkc1cU1oY0o0SUVnVk9pbW5JVkd6ZjUrK0JUeHlH?=
 =?utf-8?B?aktPR0dYSHBwanUzTE1XTGNCNGZIdjZnbERlL2cxeHMwMnZ5eTA1a2t1MG94?=
 =?utf-8?B?WjJaTTJqY0dwWlUrRzRhSXlJcEkyb1VMb2JsNnRFV0NzZ0t2dzJpdHNKYnBv?=
 =?utf-8?B?UFpUWkg1Zk1XV1FpMVlmVGkzRDBtZEpHbnRnU2pzVUV4dUd3VmM1c3V2aVhT?=
 =?utf-8?B?WWYxc1FGc2FmVm5jN3pscWxPZzdobUpEdjlBSGV6MEhraVEzNktYUG44ZUtr?=
 =?utf-8?B?ZmJoTHRBSnBjQ3ZtZDY5L1FTRHRDUUNTaFZ2djRKMEs3RXJaVFgvZnJpUXJK?=
 =?utf-8?Q?cjL7YkdMZ9zbnRIW9HZ6JDWds?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3558.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26410a5e-6c34-49b3-2856-08dcbbed077c
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Aug 2024 23:09:48.6759
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TPY8PKJ3wJtCCn2a6OIvnpo4hA85hTwsHXZeyhZT8jv+gXPYVOVbXr1ghMuTpTAB9MMLiMUa++xWmf28oFnUumQmsyrvVZIs1L1uZBiaTkE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7447

PiBPbiAxMC8wOC8yMDI0IDAxOjM4LCBUcmlzdHJhbS5IYUBtaWNyb2NoaXAuY29tIHdyb3RlOg0K
PiA+IEZyb206IFRyaXN0cmFtIEhhIDx0cmlzdHJhbS5oYUBtaWNyb2NoaXAuY29tPg0KPiA+DQo+
ID4gVGhlIFNHTUlJIG1vZHVsZSBvZiBLU1o5NDc3IHN3aXRjaCBjYW4gYmUgc2V0dXAgaW4gMyB3
YXlzOiAwIGZvciBkaXJlY3QNCj4gPiBjb25uZWN0LCAxIGZvciAxMDAwQmFzZVQgU0ZQLCBhbmQg
MiBmb3IgMTAvMTAwLzEwMDAgU0ZQLg0KPiANCj4gQmluZGluZyBzaG91bGQgc2F5IGl0LCBub3Qg
Y29tbWl0IG1zZy4gQnV0IGFyZW4ndCB5b3UgZHVwbGljYXRpbmcNCj4gc29tZXRoaW5nIGxpa2Ug
cGh5LWNvbm5lY3Rpb24tdHlwZT8NCg0KVGhlIHNnbWlpLW1vZGUgcGFyYW1ldGVyIGlzIGp1c3Qg
dXNlZCBpbnRlcm5hbGx5LiAgSSBhbSBub3Qgc3VyZSB1c2luZw0KcGh5LWNvbm5lY3Rpb24tdHlw
ZSBvciBwaHktbW9kZSBpcyBhcHByb3ByaWF0ZS4NCg0KPiA+IEBAIC0xMzcsNiArMTQ0LDcgQEAg
ZXhhbXBsZXM6DQo+ID4gICAgICAgICAgICAgIGNvbXBhdGlibGUgPSAibWljcm9jaGlwLGtzejk0
NzciOw0KPiA+ICAgICAgICAgICAgICByZWcgPSA8MD47DQo+ID4gICAgICAgICAgICAgIHJlc2V0
LWdwaW9zID0gPCZncGlvNSAwIEdQSU9fQUNUSVZFX0xPVz47DQo+ID4gKyAgICAgICAgICAgIHNn
bWlpLW1vZGUgPSA8MT47DQo+IA0KPiBJdCBkb2VzIG5vdCBsb29rIGxpa2UgeW91IHRlc3RlZCB0
aGUgYmluZGluZ3MsIGF0IGxlYXN0IGFmdGVyIHF1aWNrDQo+IGxvb2suIFBsZWFzZSBydW4gYG1h
a2UgZHRfYmluZGluZ19jaGVja2AgKHNlZQ0KPiBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmlu
ZGluZ3Mvd3JpdGluZy1zY2hlbWEucnN0IGZvciBpbnN0cnVjdGlvbnMpLg0KPiBNYXliZSB5b3Ug
bmVlZCB0byB1cGRhdGUgeW91ciBkdHNjaGVtYSBhbmQgeWFtbGxpbnQuDQoNClNvcnJ5LCBJIG1p
c3NlZCB0aGUgZXhhbXBsZSBwYXJ0Lg0KDQo=

