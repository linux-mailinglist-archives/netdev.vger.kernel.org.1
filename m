Return-Path: <netdev+bounces-110077-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 13B8E92AE7D
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 05:15:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BDED6283226
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 03:15:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BC3543ABD;
	Tue,  9 Jul 2024 03:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="ekeKvITV";
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="Zmf5ZM2c"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A110C43AB4
	for <netdev@vger.kernel.org>; Tue,  9 Jul 2024 03:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.154.123
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720494896; cv=fail; b=ga5BPEhRLOJKgTCZRVjsLpQBOe+hQXbY5LmkrrK0OMqQzkRiAqi19jcu04xb5sT4Gz4D0iToUI/Lz5hYhJq83OstbQWupngJXGYZevqF2XWvt1VW6eRGD5wSMhzKuiBLpyWWnUbIgd83wgkikGsBdyU30cBfLNErINJcAgSJvHM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720494896; c=relaxed/simple;
	bh=SZqZQYEZ97ewAqXBi1+8q+7crUUhFXkHjVTE0HykaZw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Ul39e/9DKYr59jmW5PlWxQ2Cu+u0uoAq8Aqb9Mob92HjRU/bXkQ0ORdx/TyD3pw2jdtWEuO6+K8ic7UN2kwIPK40Kf/QIfuyMR56bClkiVGDAU5pmRVvfCfPfLBXVdbMiNUtm6xugyLNHZKorOSNuRrZHKVzDFXaGOG8tR0EB5I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=ekeKvITV; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=Zmf5ZM2c; arc=fail smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1720494893; x=1752030893;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=SZqZQYEZ97ewAqXBi1+8q+7crUUhFXkHjVTE0HykaZw=;
  b=ekeKvITVQJUXNzWRXjcq+0eCcqQChCu92uzEi3j3x/MrCGIwI+F4ldLt
   mm2v4CdrHjy9ssETdiBrlHS3DH9DTBI14Iu7WlSwhK0RnybF2VrOoNeeW
   DVDW04S2EwgVofsnJbTxCE0QaG4+frrlEDRhwFsbk6BnhIxnrLMjPL6pI
   OrpeMGY0EGIrkXGWPoBJYaGSCXuoMMktOwgnJ4tlp5KDWtagThv0CfwWQ
   4NyKePvVPEFqRkKpgG3fXh0uhDN4EK/xHEmtscygzY0OPLzDOn3UO5cab
   PQd7ACfLvqIM9lmAYgiH9uNFLhsJ6lcQKcw60vvXYiwA7eNYcK2yDr0HP
   w==;
X-CSE-ConnectionGUID: FAeKqkR3RxqA1L/8Q76X8g==
X-CSE-MsgGUID: 47OI9Ce6QTCMCwzBGpitjg==
X-IronPort-AV: E=Sophos;i="6.09,193,1716274800"; 
   d="scan'208";a="196386765"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 08 Jul 2024 20:14:46 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 8 Jul 2024 20:14:42 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (10.10.215.250)
 by email.microchip.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 8 Jul 2024 20:14:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HKv+KE2ZFyQGyXtuSXTLXoLSzwaiQP7P9ogTD4QbOteawbIhGrPQ+l3YIZBOvGU8/dwe4jkW8NIZE1ogsOfIGXuMF9WBC/i/1rCF/L2knSp8Dj/nY8FP8FPUK4XjG/4Gm4ff9AQM/wNigKf3+r9Hbk0zWWxhLGrFR2tBUopmJNNUi2rrN8wrDclmzxPdaOdUzFXs22PRFrMdlCV4UBdbB7/+W3NPUe3mJ8LSunJVsAzT706qBIKtVRs3xk63rHWznYZANWY/YmVIrNCWvohvfgoNk/r5WsnT7DObvIsM37b85jPhbcpSAEo9reAPuWr6sR8r0oAA9vsigKoRVmmJdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SZqZQYEZ97ewAqXBi1+8q+7crUUhFXkHjVTE0HykaZw=;
 b=NC669MtGGjyjF+upsBYUMs5xrrU1ob1SFm4r8tbaYMwFdZ3zNDKw4eLbIDzwSVQOlfpwd1Y1LmzmPNRT3YZ6wIj+3Jm8SoLkEWAUvUdBmVFnzuHUTjvWB+PqvRK8rtAEygdLM97GTf55FBk7NByiAYyVO7jgCzMPUjzFzt2LBUrGcP33ZcW8AatGgXDX8nS39TLIGVXj4YiEm7hENKO48KkOFVOE+qTakheZnCf5rO4K7PLqHx0wtFY96OdN0/MUZIN+a2r4sl5xPfTAtaC9fNR/IRjsCKjzc2H7RBnkMWR4h6biwjJdVPGErNAu9tRKDxh3r6isKFw7gYkNdKPedQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SZqZQYEZ97ewAqXBi1+8q+7crUUhFXkHjVTE0HykaZw=;
 b=Zmf5ZM2cmlyYbxvY/HqZKvASTtQfq70b7l0PO6ZqWf2pKdqir5csElcjWrsd8jxNwrl0giXF7o4mTZgUWifi3wJr3EK6PDTCBVr9gkqD7h1BedBMMHmjeRJeV9RBDH83dWgh6XsW1J2zwR1XDh/i23t8GaGwuhO6qZK25pj9JFmXpcPtji8S23qpmiglzFWf2CXlkF03LB3lXZI8lXG7ErXi2tvaUoXLHmptu4NiV4L7n/AXAXrxTvoZILFNJ1JZBV0zH/q62iSOVpdp3RWMzY6NIsTNJVL2DAXVUzfrI7HsbuiELHaJ12LYqrD8eG7HOg/aU+RzOD6aKqBWKAF/lQ==
Received: from PH7PR11MB8033.namprd11.prod.outlook.com (2603:10b6:510:246::12)
 by DM4PR11MB7304.namprd11.prod.outlook.com (2603:10b6:8:107::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.36; Tue, 9 Jul
 2024 03:14:39 +0000
Received: from PH7PR11MB8033.namprd11.prod.outlook.com
 ([fe80::22a1:16dd:eea9:330c]) by PH7PR11MB8033.namprd11.prod.outlook.com
 ([fe80::22a1:16dd:eea9:330c%3]) with mapi id 15.20.7741.027; Tue, 9 Jul 2024
 03:14:39 +0000
From: <Arun.Ramadoss@microchip.com>
To: <enguerrand.de-ribaucourt@savoirfairelinux.com>, <netdev@vger.kernel.org>
CC: <Tristram.Ha@microchip.com>, <andrew@lunn.ch>, <linux@armlinux.org.uk>,
	<hkallweit1@gmail.com>, <Woojung.Huh@microchip.com>, <kuba@kernel.org>,
	<horms@kernel.org>, <UNGLinuxDriver@microchip.com>
Subject: Re: [PATCH net-next] net: dsa: microchip: ksz9477: split half-duplex
 monitoring function
Thread-Topic: [PATCH net-next] net: dsa: microchip: ksz9477: split half-duplex
 monitoring function
Thread-Index: AQHa0RPYVk0jYujbrU2v9xc+rg1/YLHtursA
Date: Tue, 9 Jul 2024 03:14:39 +0000
Message-ID: <ffec02336023660b69441336e248a57b7027e9a4.camel@microchip.com>
References: <20240708084934.131175-1-enguerrand.de-ribaucourt@savoirfairelinux.com>
In-Reply-To: <20240708084934.131175-1-enguerrand.de-ribaucourt@savoirfairelinux.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.36.5-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB8033:EE_|DM4PR11MB7304:EE_
x-ms-office365-filtering-correlation-id: 2b25167c-03e3-46bb-19db-08dc9fc544e9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?N1RNOCtodWd2NHlHQUNSVzhoMkFaSmJkVkR5TEJ2V2VVS2FacnBGeWdjVHp4?=
 =?utf-8?B?MGZNTWcxeENRSFAvV3RhVnpaTlFDY0wvaGw5anJmNVZadlZrL3drS0d6N3FR?=
 =?utf-8?B?UE03RnI0Q1NyNitPVDhBZU1LRmZneGNZRFM1SzhJUjVNcGNGLzdPRkUya0dF?=
 =?utf-8?B?cWprQ3k5NEdMWS9lbW9IcHFxcGYraG5rVVFheDZadFk5RDRNa3RnMWZiUVZp?=
 =?utf-8?B?ZUk3d1QrdWR5YjhkbTJwTFhpVmthUWRSVHE1aThpQWNTWlgwNjlEUjlwMnNy?=
 =?utf-8?B?dURPSnNoWi9DZ2ZzQmIvbFFwekppTmNNdGhsa2IvK01QKy9ETGJBNkxKQ2RJ?=
 =?utf-8?B?TU5KV212bU82MnBHQkk2SGtLcjBxOWJldzRPYTR3UDdFcXBpQWY1dFhOSVJm?=
 =?utf-8?B?cHBKR0xEaWZEbUprU2ZRUmV2SUhGZzAvb0xYTk93UDFHNnpGVlNtUGZHeExi?=
 =?utf-8?B?SEdvUnBjKys1WldYenZCV2hEL1lEeVVsYmd0dFJsbDZNRWk5MUpFV1E4OHkx?=
 =?utf-8?B?UW1odVFUWXBlaFZUbG90SlFhMHdkRVpsTzI0V3U2aVFLNDh5SDJPOU0zWTFP?=
 =?utf-8?B?TDF4dWxQbEhyQ1hVdTJQVVNFR3VIdUI2OUpodjhCSGNWQjlCTHRvRlB6T2Nu?=
 =?utf-8?B?VU5VTHNIVnZ2dlo2OUd5LzRlWUsvZHVTTzBORkZqTWE0N2FRVnVjUVFHdVYx?=
 =?utf-8?B?MlFmeUhqNk9WZXZ3NkFaVVRPbkpIczFBZXBiQUl2UXBZRGM0UWM3NmFVK1pw?=
 =?utf-8?B?bW1oeCtlZTdROUNiOG5ZTU5YNlB3UndycFZqOWp0SlJRUWl3Vkc1OXpHd1Fp?=
 =?utf-8?B?TVd3Mkp4VXlKdnozTGs2WEViRHpPa3NaamhBY1VKbm55RTVvU3Z0SVlUS2dJ?=
 =?utf-8?B?dUE1RWpJdEVIbjJoRnowZ1NKYWdqcGFwRFljS1ZnMjRBZi9hbnFsVThGaXhO?=
 =?utf-8?B?YU1KTEpmT3NHcXU4R3dxTitiVmpxcnU0UUJJV1Q5WGdoT2V0Vk1QUGNPQXpK?=
 =?utf-8?B?R3BWWW82YVl1TVM1ZnZZNytKRWRQUTBDMldEL2sxb3d1OGlHQllqQ3RBTkEz?=
 =?utf-8?B?YXc3bWN2MTFkSzZFTWRueU1ia3QzWlloS2p1T00wY002dkJqUStMZzhHbC8x?=
 =?utf-8?B?YUNrcGdLbE91ajJvRDN0Uk04amEvVDNaQ2ZDWWllSUZUZ0xSZ09UMEJlMGpF?=
 =?utf-8?B?aC9ZS1NobXNpZmVyNk44NU1FbnAwMXFtZXpBclczamlJaWFUbzN5QkZvQk9y?=
 =?utf-8?B?WHJzT2NoREdWeUhhMWl6WWFDalRsRVpmaW1waDcrRHhiNlBINE1ZRFl0UXhq?=
 =?utf-8?B?Y1FBZTRiUEtPZHhYSXNyUWFFSlhtcHJoTEFRNjE1SWF0YldoT1hUWC9kbGg0?=
 =?utf-8?B?RmNJNVBFTU5zMHNUR1ZEOW1KZ3hDdUJpWE5iSW1JRWJYUU56RTF4VGdoMnBM?=
 =?utf-8?B?MUZYM3JpWjVmL0VZSnZTa2xKR3pGR1lNVHlWRGl0TEtXWjdDUjRrNFlGRFJq?=
 =?utf-8?B?N1FMSVNkY1VFZ2xIMXVrbHQyQkFJRDVOeHkrTHU1RTdvdHBkTjA2Q3Eyd1c0?=
 =?utf-8?B?OUNFRDNPTFZpbUZhNDIzUFFyVTYvcmJmOWZJRnZCK21KaitMSWpFRHlqMHFh?=
 =?utf-8?B?VmhlWTBQV0FBYmk3dm9jdUZiQ28wT3VRTWJTMVlwQm1uaFlRZ21CVURSZlU1?=
 =?utf-8?B?bDNGV1plSW1hWFR5ZEFib0IxSnFCNTBuZVpGZS9sYng2OXVvN1ZFY1gzbFZm?=
 =?utf-8?B?NEVvcjFpSkhkeDMyK3o1eEtZbThTRjJxZ3kxTGRVU1NOUjZXazBDNm5Da1Vq?=
 =?utf-8?B?YnU0TGpqTHhSR0FxVTI2eHduUjR6OE9id2VqbDhkOTU5Z1ptbWdKM2g1SWc1?=
 =?utf-8?B?eVFmZnUvek84bXpkdXNCM2tWalFxSFIyV01kMWhOcHNBc3c9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB8033.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OWdjTGVhVW93bDl6VExEdU5UeW9PdXBZdGxLTXpGVUR4dGpEY1dCQzROeWJY?=
 =?utf-8?B?MVV5cmVHc1p5VThmWGNFczRmUGxXLzQxRlFReHlUdGdQWks1ek1JRm5LaGpR?=
 =?utf-8?B?Q2NKN0ppYURxd1VvY3BMbjZRMFJFMWRzMVZlTytXcTJGMk53WkhtOXo4K2l2?=
 =?utf-8?B?a01TeU5Bak5Fd0ZzVVBnNXAxK3NBamorOGdRZk5NNlFEK01ybzRzN1NaVW5V?=
 =?utf-8?B?K0pMUVdBcndIZFoxeFVBZmdpY05MbGUrS0phUW84L3E4RkoweDNUU0hXY094?=
 =?utf-8?B?ZGU2RkNGa2ZTNjNwZk5BR05RRnZFT25Ucnc4bFZ4R1Y4SVZVTTZhSkR3dytk?=
 =?utf-8?B?YUovSVF1Zzh1SDcxc01QaHVRU1lXdkFJY01aaXk0b1ZMQ0RZRHBzMHArdG4v?=
 =?utf-8?B?bFVYK1JRRGdNU3ZpSTR2V0VlWVFCSjloRGg1dEtHdkdFWVVmTWUwU09jYXh1?=
 =?utf-8?B?bU5KSEpDZGl5WG1UaDRDWkxES2F0cUJuTFIxQ213dXNiYXVXQ1JKaFFtWmRp?=
 =?utf-8?B?UW1paVBBTnRXRWh6UkhHTk0yeWRyVDNuVmRlR0U5YTFNRGdLTmJkNnFKSllj?=
 =?utf-8?B?U0dFZ0VPV1pSVTl4MW9tZXEydngzRVdHVEtwYURRbDBLd3h1bTNQa2JBZ0p2?=
 =?utf-8?B?djc3T3hPc1FqM0JzemxWeVcwWDNPZUE1WkRHckhaZkZOamgvQjdsMElrbTM5?=
 =?utf-8?B?S1lnN09kRXlYTFdQMXZxdUhhUkF3eUpDVENmQ3lHdlNaeTl0MExWcThRdlZw?=
 =?utf-8?B?U1J2a2NXa1ZCbEZidndvUTI5dDBYUjJqZFZleWVCY2FDc1BjTzFaZVJhZ1ZH?=
 =?utf-8?B?S2ROeXdQQmZmaFBXTXdVUSsvWSszNEI2ZThkWUF4MDZPaXhRajZjcllGTU9y?=
 =?utf-8?B?NGNteS9VWmhTN2xOTGZ1MTUwNFdwVU0xRmtKckRyMjJGL2tSYXVpSVBXbzM0?=
 =?utf-8?B?NmlVWkZJTVFDUVpuTVBuVFNUbks5b2JrRzlwampIVFplWU56L2JvUzFhcktH?=
 =?utf-8?B?TzkzMStMb1NnYUt3cFozWHgwOHlVa1dEMUFReE5TU3Y3a25SY04wQnhnc2VV?=
 =?utf-8?B?aUpDV2ZqUVowazg5MFptZ3o4QjE5cHVrc3E0TUZFQXRwWnZ1ZzNPdC9XUjdJ?=
 =?utf-8?B?ZXBlRXVGTjE4KzJFRWtHSzhrZFNwYitCc3Rqam1qSVUrTHF3Z3pRS2RjMUwr?=
 =?utf-8?B?VnJDOWIrRlpYVG0vNlByMHVXRlkrUE1BMVRBK3ZMaXI5SC9PZ2Z2VllEcHI1?=
 =?utf-8?B?SkYvY0FickxjT2poU2h1cWVlL1plVmNQRy83MmtXSmM5OHN3aTF3cEx0Nm5u?=
 =?utf-8?B?dmRWTCt3M3BPRXBBVkd3czZzVHZJZlFPN095ek9zVHFnd1VMd0RhcUswYm9E?=
 =?utf-8?B?MERDTm1aekZ1d1RyMHQralZZNVlXL2pLM004VzVzM1NzN1dYV1hTa0UzRUcr?=
 =?utf-8?B?ZEFpaUJ6dmZxdzJ3V1phaWZWRUlnOEl0ZU1vTUMwelBtam9DRTdyUDRxemo2?=
 =?utf-8?B?bCtVdXdra3h5TjkvUTNvVGUxQVc1OE5rVjdFSStBSTFFRnpLdDRhY05kMnVF?=
 =?utf-8?B?WnVvbkhKc1didG94eDJuMWtsdW9nL2krUCtHZTI4dnU0N2gxb2NuL21CbVJn?=
 =?utf-8?B?bndtV2ZCYWNrUzFWdU1ndXMydVVDS0Y5OGRSZGpMK1kxSVFpN0hlS1FKdmR0?=
 =?utf-8?B?SmpUZ1JraFA1YjVGVHF0dTA0d3FIajMvVFVOdmY4REdiTlhhdWdOQ0FpcFJ2?=
 =?utf-8?B?YUVnZXBxNmxraXhPd2dNaWlCcmdwc0N5R2dqUkNZSjRIdVp1RFRwSWhJb05E?=
 =?utf-8?B?c3VzQVVuTlpHVDFmemVuOURkM0JNS3N0NHlML2ZPMlJtNXpxQkdVK2RyeTRp?=
 =?utf-8?B?Q0ttN1U5dks2Z3V2Rlg3NlBJMHF0d1FWNThkQ2Vwa3k3cVQxa3h4WXdnbkVk?=
 =?utf-8?B?UW5yUTdRc0ZwMDY4REFWWkNXbjdueEZSMEsyaWpmT1hGcHJ4b3cyZm9hdGlh?=
 =?utf-8?B?MUNhZ05zK0hUZGVGRHBpcHlTNkpKZDFBd1JFMUR5UFNvNkd0eUhzZ2tXSkxl?=
 =?utf-8?B?VDZmaGpsM2QydWhLeXUvMnRFVWl5ZVRydjNiMmZKY0ZaaDJtRVZwa080WERD?=
 =?utf-8?B?UzgxUmU1L2hZOVRmcXFBZm1Wb2J5QlI4YXF1eVVPNzUvZTArT1crUGFNWWVX?=
 =?utf-8?B?bEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <61EA38DF93FFC747A099D1796F0B2DE9@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB8033.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b25167c-03e3-46bb-19db-08dc9fc544e9
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jul 2024 03:14:39.2700
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0tXa+R5WV1kgV3d4lk1lWObQgmhE0EY5E0n5N3wNvCAz3eTAeec4PTZUa625/Q/jGVKoq+S87JZkTeOyDAoXRlKjGaNHJc9RPG195Oy+u48=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB7304

T24gTW9uLCAyMDI0LTA3LTA4IGF0IDEwOjQ5ICswMjAwLCBFbmd1ZXJyYW5kIGRlIFJpYmF1Y291
cnQgd3JvdGU6DQo+IEVYVEVSTkFMIEVNQUlMOiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBh
dHRhY2htZW50cyB1bmxlc3MgeW91DQo+IGtub3cgdGhlIGNvbnRlbnQgaXMgc2FmZQ0KPiANCj4g
SW4gb3JkZXIgdG8gcmVzcGVjdCB0aGUgODAgY29sdW1ucyBsaW1pdCwgc3BsaXQgdGhlIGhhbGYt
ZHVwbGV4DQo+IG1vbml0b3JpbmcgZnVuY3Rpb24gaW4gdHdvLg0KPiANCj4gVGhpcyBpcyBqdXN0
IGEgc3R5bGluZyBjaGFuZ2UsIG5vIGZ1bmN0aW9uYWwgY2hhbmdlLg0KPiANCj4gRml4ZXM6IGJm
MWJmZjExZTQ5NyAoIm5ldDogZHNhOiBtaWNyb2NoaXA6IG1vbml0b3IgcG90ZW50aWFsIGZhdWx0
cw0KPiBpbiBoYWxmLWR1cGxleCBtb2RlIikNCg0KTm8gbmVlZCBmaXhlcyB0YWcgZm9yIHRhcmdl
dHRpbmcgbmV0LW5leHQgdHJlZS4gDQoNCj4gU2lnbmVkLW9mZi1ieTogRW5ndWVycmFuZCBkZSBS
aWJhdWNvdXJ0IDwNCj4gZW5ndWVycmFuZC5kZS1yaWJhdWNvdXJ0QHNhdm9pcmZhaXJlbGludXgu
Y29tPg0KPiAtLS0NCj4gIGRyaXZlcnMvbmV0L2RzYS9taWNyb2NoaXAva3N6OTQ3Ny5jIHwgODcg
KysrKysrKysrKysrKysrKystLS0tLS0tLQ0KPiAtLS0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgNTAg
aW5zZXJ0aW9ucygrKSwgMzcgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9uZXQvZHNhL21pY3JvY2hpcC9rc3o5NDc3LmMNCj4gYi9kcml2ZXJzL25ldC9kc2EvbWljcm9j
aGlwL2tzejk0NzcuYw0KPiBpbmRleCA0MjVlMjBkYWYxZTkuLjE3ZjZkZWIzYzU5OCAxMDA2NDQN
Cj4gLS0tIGEvZHJpdmVycy9uZXQvZHNhL21pY3JvY2hpcC9rc3o5NDc3LmMNCj4gKysrIGIvZHJp
dmVycy9uZXQvZHNhL21pY3JvY2hpcC9rc3o5NDc3LmMNCj4gQEAgLTQyNyw1NCArNDI3LDY3IEBA
IHZvaWQga3N6OTQ3N19mcmVlemVfbWliKHN0cnVjdCBrc3pfZGV2aWNlICpkZXYsDQo+IGludCBw
b3J0LCBib29sIGZyZWV6ZSkNCj4gICAgICAgICBtdXRleF91bmxvY2soJnAtPm1pYi5jbnRfbXV0
ZXgpOw0KPiAgfQ0KPiANCj4gLWludCBrc3o5NDc3X2VycmF0YV9tb25pdG9yKHN0cnVjdCBrc3pf
ZGV2aWNlICpkZXYsIGludCBwb3J0LA0KPiAtICAgICAgICAgICAgICAgICAgICAgICAgICB1NjQg
dHhfbGF0ZV9jb2wpDQo+ICtzdGF0aWMgaW50IGtzejk0NzdfaGFsZl9kdXBsZXhfbW9uaXRvcihz
dHJ1Y3Qga3N6X2RldmljZSAqZGV2LCBpbnQNCj4gcG9ydCwNCj4gKyAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgdTY0IHR4X2xhdGVfY29sKQ0KPiAgew0KPiANCj4gKyAgICAg
ICANCj4gLSAgICAgICAgICAgICAgIGlmIChzdGF0dXMgJiBTV19WTEFOX0VOQUJMRSkgew0KPiAt
ICAgICAgICAgICAgICAgICAgICAgICByZXQgPSBrc3pfcHJlYWQxNihkZXYsIHBvcnQsDQo+IFJF
R19QT1JUX1FNX1RYX0NOVF8wX180LCAmcHFtKTsNCj4gLSAgICAgICAgICAgICAgICAgICAgICAg
aWYgKHJldCkNCj4gLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICByZXR1cm4gcmV0Ow0K
PiAtICAgICAgICAgICAgICAgICAgICAgICByZXQgPSBrc3pfcmVhZDMyKGRldiwgUkVHX1BNQVZC
QywgJnBtYXZiYyk7DQo+IC0gICAgICAgICAgICAgICAgICAgICAgIGlmIChyZXQpDQo+IC0gICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgcmV0dXJuIHJldDsNCj4gLSAgICAgICAgICAgICAg
ICAgICAgICAgaWYgKChGSUVMRF9HRVQoUE1BVkJDX01BU0ssIHBtYXZiYykgPD0NCj4gUE1BVkJD
X01JTikgfHwNCj4gLSAgICAgICAgICAgICAgICAgICAgICAgICAgIChGSUVMRF9HRVQoUE9SVF9R
TV9UWF9DTlRfTSwgcHFtKSA+PQ0KPiBQT1JUX1FNX1RYX0NOVF9NQVgpKSB7DQo+IC0gICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgLyogVHJhbnNtaXNzaW9uIGhhbHQgd2l0aCBIYWxmLUR1
cGxleCANCj4gYW5kIFZMQU4gKi8NCj4gLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBk
ZXZfY3JpdF9vbmNlKGRldi0+ZGV2LA0KPiAtICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgInJlc291cmNlcyBvdXQgb2YNCj4gbGltaXRzLCB0cmFuc21pc3Npb24g
bWF5IGJlIGhhbHRlZFxuIik7DQo+IC0gICAgICAgICAgICAgICAgICAgICAgIH0NCj4gKyAgICAg
ICAgICAgICAgIHJldCA9IGtzel9yZWFkMzIoZGV2LCBSRUdfUE1BVkJDLCAmcG1hdmJjKTsNCj4g
KyAgICAgICAgICAgICAgIGlmIChyZXQpDQo+ICsgICAgICAgICAgICAgICAgICAgICAgIHJldHVy
biByZXQ7DQoNClRvIGluY3JlYXNlIHJlYWRhYmlsaXR5LCBoYXZlIGEgbGluZSBicmVhayBiZXR3
ZWVuIGNvZGUgYmxvY2tzIGxpa2UNCmFmdGVyIHJldHVybiBzdGF0ZW1lbnRzLiANCg0KPiArICAg
ICAgICAgICAgICAgaWYgKChGSUVMRF9HRVQoUE1BVkJDX01BU0ssIHBtYXZiYykgPD0gUE1BVkJD
X01JTikgfHwNCj4gKyAgICAgICAgICAgICAgICAgICAoRklFTERfR0VUKFBPUlRfUU1fVFhfQ05U
X00sIHBxbSkgPj0NCj4gUE9SVF9RTV9UWF9DTlRfTUFYKSkgew0KPiArICAgICAgICAgICAgICAg
ICAgICAgICAvKiBUcmFuc21pc3Npb24gaGFsdCB3aXRoIEhhbGYtRHVwbGV4IGFuZA0KPiBWTEFO
ICovDQo+ICsgICAgICAgICAgICAgICAgICAgICAgIGRldl9jcml0X29uY2UoZGV2LT5kZXYsDQo+
ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgInJlc291cmNlcyBvdXQgb2Yg
bGltaXRzLA0KPiB0cmFuc21pc3Npb24gbWF5IGJlIGhhbHRlZFxuIik7DQo+ICAgICAgICAgICAg
ICAgICB9DQo+ICAgICAgICAgfQ0KPiArDQo+ICsgICAgICAgcmV0dXJuIHJldDsNCj4gK30NCj4g
Kw0KPiAraW50IGtzejk0NzdfZXJyYXRhX21vbml0b3Ioc3RydWN0IGtzel9kZXZpY2UgKmRldiwg
aW50IHBvcnQsDQo+ICsgICAgICAgICAgICAgICAgICAgICAgICAgIHU2NCB0eF9sYXRlX2NvbCkN
Cj4gK3sNCj4gKyAgICAgICB1OCBzdGF0dXM7DQo+ICsgICAgICAgaW50IHJldDsNCj4gKw0KPiAr
ICAgICAgIHJldCA9IGtzel9wcmVhZDgoZGV2LCBwb3J0LCBSRUdfUE9SVF9TVEFUVVNfMCwgJnN0
YXR1cyk7DQo+ICsgICAgICAgaWYgKHJldCkNCj4gKyAgICAgICAgICAgICAgIHJldHVybiByZXQ7
DQoNCkxpbmUgYnJlYWsNCg0KPiArICAgICAgIGlmICghKEZJRUxEX0dFVChQT1JUX0lOVEZfU1BF
RURfTUFTSywgc3RhdHVzKQ0KPiArICAgICAgICAgICAgID09IFBPUlRfSU5URl9TUEVFRF9OT05F
KSAmJg0KPiArICAgICAgICAgICAhKHN0YXR1cyAmIFBPUlRfSU5URl9GVUxMX0RVUExFWCkpIHsN
Cj4gKyAgICAgICAgICAgICAgIHJldCA9IGtzejk0NzdfaGFsZl9kdXBsZXhfbW9uaXRvcihkZXYs
IHBvcnQsDQo+IHR4X2xhdGVfY29sKTsNCj4gKyAgICAgICB9DQo+ICAgICAgICAgcmV0dXJuIHJl
dDsNCj4gIH0NCj4gDQo+IC0tDQo+IDIuMzQuMQ0KPiANCg==

