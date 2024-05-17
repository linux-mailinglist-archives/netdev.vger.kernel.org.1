Return-Path: <netdev+bounces-96905-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70C328C8267
	for <lists+netdev@lfdr.de>; Fri, 17 May 2024 10:08:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CC7BAB21625
	for <lists+netdev@lfdr.de>; Fri, 17 May 2024 08:08:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1718C18C05;
	Fri, 17 May 2024 08:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="Ih8tTVGl";
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="ubPggiqD"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BAE718EAF;
	Fri, 17 May 2024 08:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.153.233
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715933315; cv=fail; b=GBp2uW4ieSSgl5hlll6Fvp3gY/rbW+SKEsBMudQscdFx7zbLzTiSx73xAH/A1akFdXGaDanDhCG6zEwfq+R5if00xZ8zRi0cFjHuu5scRqCLd7MeP9OFjGijWh3iQ1gC1RB4FCQ3eh6KgJsAYKRRi2ZmRwNYKtESa/pEtmQKlYc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715933315; c=relaxed/simple;
	bh=BgmgfUFDj/XaIRlDWNlSXtgIO/hSK87/431iTKLtiQw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=uzcweGwoP2fBNnvu9I/e1+fdAmdk9KW6VkNhfwHN5sKGDf30pMqzttG34krJMiZXbduQWXwY0vXJaEcvFr501zuQJvb1tgdfDD4FIiYrXEUjXZ8+0x/uaEeSBaQ4qoNZQx4cm3nIAbp+OClqpnOdFZntsRnlhjayM6+yHHUP5Rw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=Ih8tTVGl; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=ubPggiqD; arc=fail smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1715933312; x=1747469312;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=BgmgfUFDj/XaIRlDWNlSXtgIO/hSK87/431iTKLtiQw=;
  b=Ih8tTVGlSYTNTNLIKg0J7JYYF7dUluqc0ZydvDMTlVR0fHGx2p8zOJkN
   7mhmH2/QdHdlb+NC/Xbiu6Y3lSC7W9pbuQfL9fdliTUx2Wk3ZGPprkBc0
   vZBGO4Mj0JydOao8mbNILgZUm1S/uO5TxAl15VeTZXEvyegGS8eqqmWxD
   2DhYtBRSS3dckq+XZkwptK3XpVBQDMdGd+OKbrRo34FbaloDxyY2jkYOm
   LsOdwLdWZiSzQjiZfR4+7eT/0rqy1odViawpypNU0KnvYm3G9et6f6BTv
   ODly+iXrvdWXIYu9VLOeaxSozyoConcZAqZB7UjiT5NB+LzMSSnlAU149
   g==;
X-CSE-ConnectionGUID: 9tCEIv3BQM2Q0WSATIOGcQ==
X-CSE-MsgGUID: 9c5A2f0iTiSAi0KjHyvYEw==
X-IronPort-AV: E=Sophos;i="6.08,167,1712646000"; 
   d="scan'208";a="27315248"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 17 May 2024 01:08:29 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 17 May 2024 01:08:01 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (10.10.215.250)
 by email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 17 May 2024 01:08:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OOUeXi2A8Vnu6Ooo43jS7lXs+xJe29am7XXJ230jvjjzx05RlNtC2e9MvXu92P11uXWjFLONEK8ewTyS8hhRY6VWRuKxwlGYI3i5FEhUfysQAWTy21/UvcXPt0xGkTINDPWWVp9oqJSMlw6EgYR9V7zuuJUpLuIW3rJgcY55SissCXaKhQMNkPmcY9YdHem/cbha0z6ZOyGF/BeE63uYSJ/G8pY4+Jw/vip7tgS6z7W+3bLeV6uNbBt7/qLZV790hdtYMtxoOSiqP0Y8MTLTP3aH8jbtdHPxttxj6GAgVQt8+tJsshopIH2CF4gmgpF/PcpFSYzmCM+BMGo6QZ3+xA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BgmgfUFDj/XaIRlDWNlSXtgIO/hSK87/431iTKLtiQw=;
 b=UyngkOuPp4lCePXm5aOrspqURVWvpEHy61qPps2SmzK8yIhSs4WEP+YEemm0TiFfz+l7Mt6sN5XdogL32x/Obop6ihvr3ApY+jX8Fld0KBgMHkXROTHsU9XzRJvg1jNLNOsc2n7vVICrPzknLfho8A5/grYrck6x/9PXr8wOwnVrWPKvVUx2A/QxdRUuD6Q3oWX+YWsiJakaz5FUxMFT4ck4U8Fh6+g6urmRY8NVhGQPQUckfQNalGCc4KK5HYwtdsHt3LRhb3pnvm4ai/XOKpR+00fIXr66NaL/vkgC60a5fBYh5jH7rfcdH9x6dAso++BjM++z2uoV852KPTnVcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BgmgfUFDj/XaIRlDWNlSXtgIO/hSK87/431iTKLtiQw=;
 b=ubPggiqDc9PB0Fiz+g7qdOylHguQpMQDLUlcoBrAs0hiP2zDzJ61hn5BOcrjqO8RGHxHXj/BjRoLQNnuNtsdg7u543WddVyeOgfSn1XjXTV6Sc+xJkQhQc8FcJc9HAJ57YmTYKD//3vtDVsibgrVxpLMXomV9994WeLciAlKqtoM4wek5DYqIPoHHMnaLhQMpopmCl1i47dulGAQsOtJYS4CGTByuo8rXb5btM8hlGE/VBOjW8LTCKrJmOVHLWEBuQcGy2SLljJwg3DPJPI+O+/RqZb2NIIefDku3Zv7APKenoagORGIyvldj4IDgqtCKsSa/NC/fOz64HVpMG654Q==
Received: from PH7PR11MB8033.namprd11.prod.outlook.com (2603:10b6:510:246::12)
 by LV3PR11MB8506.namprd11.prod.outlook.com (2603:10b6:408:1bb::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.28; Fri, 17 May
 2024 08:07:58 +0000
Received: from PH7PR11MB8033.namprd11.prod.outlook.com
 ([fe80::22a1:16dd:eea9:330c]) by PH7PR11MB8033.namprd11.prod.outlook.com
 ([fe80::22a1:16dd:eea9:330c%2]) with mapi id 15.20.7587.026; Fri, 17 May 2024
 08:07:57 +0000
From: <Arun.Ramadoss@microchip.com>
To: <andrew@lunn.ch>, <olteanv@gmail.com>, <davem@davemloft.net>,
	<Woojung.Huh@microchip.com>, <pabeni@redhat.com>, <o.rempel@pengutronix.de>,
	<edumazet@google.com>, <f.fainelli@gmail.com>, <kuba@kernel.org>
CC: <kernel@pengutronix.de>, <dsahern@kernel.org>, <san@skov.dk>,
	<willemb@google.com>, <linux-kernel@vger.kernel.org>, <hkelam@marvell.com>,
	<netdev@vger.kernel.org>, <horms@kernel.org>, <UNGLinuxDriver@microchip.com>
Subject: Re: [PATCH net v2 1/1] net: dsa: microchip: Correct initialization
 order for KSZ88x3 ports
Thread-Topic: [PATCH net v2 1/1] net: dsa: microchip: Correct initialization
 order for KSZ88x3 ports
Thread-Index: AQHaqBde0TMWcbsjoEuU1w/IM01XVbGbEu+A
Date: Fri, 17 May 2024 08:07:57 +0000
Message-ID: <719921337ad06cbaecd6cbb9f8c810a80030488f.camel@microchip.com>
References: <20240517050121.2174412-1-o.rempel@pengutronix.de>
In-Reply-To: <20240517050121.2174412-1-o.rempel@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.36.5-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB8033:EE_|LV3PR11MB8506:EE_
x-ms-office365-filtering-correlation-id: da55b63e-d4de-4f0a-e7e5-08dc76487650
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|376005|366007|7416005|1800799015|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?QlFMblR3L3F4c2RqUTd2VTFiSURrL1lkeHFUNmtaRFZ2d3pCN1V0RGJ1SXZv?=
 =?utf-8?B?YnBqLzdDaFdIWEszUUp2SndkRmgyQjNPVERzaTlMVFV1ZTR2alM0RmhyQThR?=
 =?utf-8?B?d2JPZG90bVdHMU84aEJvM21jSEdDQUZVeWpZM3g4cVF2cmxpenFCbDZmUHpP?=
 =?utf-8?B?SUJtSUJ4UEd2VGVMWUNlYTMyeVFOclUvYnNTdHZORThsZ1loeXU0eXdLTWVt?=
 =?utf-8?B?a0g5Tkg1QzMyRHRjbk1LbmxXUmE4UFNKbWpqUVNuOUVJZUh2OVhEd2pxRDA1?=
 =?utf-8?B?R0FEM3Z4eVFMN0EwNVZ1M0V5L1kySGs5U05tdEhzQjhQaFcxODNaZmgzZkkz?=
 =?utf-8?B?ODBFVFQ1RTJJdVRPQTBBazFkNytlaXZXTlFuMnpDbm0wUXJyeGY3MVBhdkVT?=
 =?utf-8?B?RE5HVWpTcndic3FJSkVSQ3Baci9hcVBFR1lZYm8xOVQwZS9tNVk5OHV2aTVE?=
 =?utf-8?B?VU1YWFpOd1VEM1pCMzZPTzB4dTRJQS9FQjkwc2pVVnVCQXhZc2lqTFU0YW40?=
 =?utf-8?B?OFF3RzgraGg2aktxNm9OZ3VHTnM1R2NYYk5GMjV3alU5MGFFaVZRYm8yMXBy?=
 =?utf-8?B?Zmd6c2NkTnp2QTdiSUttNlpTbGNJSzFYN3BJU05vOFg4eVIzeE5YNlN0WjZN?=
 =?utf-8?B?YWZLc1ozTDJjYUxZdzFZWWNqRTdqbVVnTUJWemlZTlNRK3MzcUl4TnVlMkZ5?=
 =?utf-8?B?QlBsbXZtZVMwaE9YaWp1QSsraFJPUVVIMWpEalV4bUNBc1IzTHdHMHBRcGg3?=
 =?utf-8?B?Tm43Z2RlcDRxQkoxV3p2Y3FKbCtvelZJcDNFdUJ6SFRkdGRPNXFXRWkxSVo1?=
 =?utf-8?B?eEVFa3lrclBSc3pUbVVMQkxxaU12a09lMFRGVnJCRmxROVNLc01kNVlZYTZw?=
 =?utf-8?B?N0hOcGtvQldZSzNET2sydTZEUVhWSnJ2bnpHSWZvMDVTWGp6dXB2dHFNN1Jn?=
 =?utf-8?B?WTZaQ3pmT3d4MFcyRzgrV3crKzFjRUFhOG1zNHl6MVNOc0NBL3A3WCtyQlZr?=
 =?utf-8?B?OGJoKzJDem1IVTVwSFpLYWJZUWJKU3BpSXJYWFV3TWhDUUJEaUxNL2JIcDl5?=
 =?utf-8?B?YkF5N09aZVdSTUFaMzVDYzdGYlY0Y2g3aW5HZlJjTkU1UDVMcG5jZERsSGZt?=
 =?utf-8?B?T0l6c2F6OWR5QWlwWGNhUE9hYW14SFZkMDkxeHlTMXJHV2xZYVdWRDVzblRW?=
 =?utf-8?B?RVltVUZ6ak1KVXhUV094bkZXNkE2YStaWVBTQ3VaZ0ZJSXd4K3lyMFg2QklP?=
 =?utf-8?B?MHdtY1NvYVQrVG5Ba09LYS84Ump1Wk1jMXBRVlBucHd1ajgvRzVpZVc2Q2lW?=
 =?utf-8?B?VW5wVkdTd0xGZmVQcldFRmJ0YWhJSkx2Yzk3UUtnTWV4MTZJVXFWMUx3Smwx?=
 =?utf-8?B?OU9oa3dzeHRpWjk1bmJ3UlE0Rkgwa1JZSGl2ZlF2MXEyZHpUdzZxQ1ZNVEQ4?=
 =?utf-8?B?NFgxK2FuM0VFTUFRdWp5QmVwKzlIdGdOWkdhais1cDVwSEd3YnVQZVhXVUsz?=
 =?utf-8?B?WlBSVHIyU1cxVDVNQnVac1plM3hmaVlxdXd1NWpiUGRpcE1JOWtCYTBMTnBV?=
 =?utf-8?B?aHB1RzJjRFIxUm5ZZmpqa2x2cnVkM3VPU3o0R0lDdzVzeUtIYXFKNUdOWjhJ?=
 =?utf-8?B?em5EUzZYdHl6MHdVaDcvUFFFSVd1dWtlOFNYRnBsbS9HL1prYjJNRHBIVUFB?=
 =?utf-8?B?RFZzSkY3ampoQW1YeGc5ODRveDM1UGZlVWJQbTBEdFlYZTRhdFRicXJUN3lq?=
 =?utf-8?B?elZ1ZnBGZ3pJVG1kcnVUTjBjR3E5Y25aNjUxd0JMVlZwMTdnZ0tYMkQzN3Bk?=
 =?utf-8?B?OXpTWVBiNElWYUtYQ3dQdz09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB8033.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(7416005)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TjhmSiszaE56Y3NBWFMvRG5INUZicUxPdjRvb2ZuVk9vUkxDUW9wRWxSdUdt?=
 =?utf-8?B?RzJ1aDh1Tk84Wk8wRCtQSHBuYVZ3a1RQdFJsV0VWTDRpTEY1YTBYaHRvOW5L?=
 =?utf-8?B?TjJPajFSV3RyMEFMc2JlQWRKV295cXNwMTlCdjlqY0JGMVFhdm5EQXZOYWpm?=
 =?utf-8?B?cm1VVXVvRVlPNTJkZWF1WXZjMlRDUk4yNk82b09URjREYnJmRkRiS3dCNXBX?=
 =?utf-8?B?R2tTYkpMYkVLV1Qrakl1ZmdrMEJ5dk9nTHV0WFFQTS9lY0xsRXRlRDRCMlR5?=
 =?utf-8?B?Q2I3amN5enlGSXE3ZWFnemc0aGFkeDF5a045MzFZbVU4NTJLZHhIQVBDVzZ5?=
 =?utf-8?B?NjRzb1JDVGs3Q0dCS1V6UmNWcy9NbEFDeWkrREp1V1Y4d1RucThXczRyTWpY?=
 =?utf-8?B?Qk10aEtWanIxV3hUR1VhSXk4dlJBajFHSGZ6MEcyZW4vYlFLNGpxTmpNYksy?=
 =?utf-8?B?Ym1tWEJMbUs4cm9WeGgremVGaXc2cHJkOUJ2MElmTFlWcnZKek8xdjRDeTY3?=
 =?utf-8?B?Qk8zWFUzWlFRNSs0SVpKUGgvdExrazVFMTN3WlZxWWVISUhTUU05ZzMrdWNl?=
 =?utf-8?B?Mjlvamhia1ZOQng2alIzQWk2cHpLb0xCVTRpck9IM3BFZk5IYjA3REpYVXA0?=
 =?utf-8?B?VFlmYlhxYmVZeDBjSy9aakhOZkcrd2g4ZkpNTHg3VlhvWldKTHpmbkVabUxK?=
 =?utf-8?B?eWRxRS9oOGVrMHMxbTZycTJMaENZT2c2enk1d3E5YzBZWUlRSkY1UlJvYWRE?=
 =?utf-8?B?d3d4YjJCUmFYSFE1SkFKamNEYUhhTSs0akg3MFV4Y2JCUXovandLL2sweWhx?=
 =?utf-8?B?ZE5jbHgvODZPMG1tb2toVWFZQkFPdkxWVjQ5TmRacm1JK1lkYmpqVWJPN25Y?=
 =?utf-8?B?ZTZlTHIwU2JoWEJybzk3ZUtId2xiNk5OVHUxVDhhc0I5dFZWMnREemZFYjFS?=
 =?utf-8?B?WTdsQ3ZwZEo0MitKdGlHdHVLK2ZZaXk2d05QOStoNlJ0ZnVKRHZWSk1qK25M?=
 =?utf-8?B?WHkybWZQQTAzY2lqR3ZHWlZsSVlrQSs4RXAxbnpGRXk0dUxNU3VENHdXRy9r?=
 =?utf-8?B?MFh2Z1AvdE9aWC9vVWhKNWJqa2RaeThqWDlrVUJidDU2RTV5VDhrMTkxNFJl?=
 =?utf-8?B?Zlh1Z1QyRy80b210NmViS0l3S1ZUQ2JsaHNRZmhteVRkN3hXaVhiS2lnM0tv?=
 =?utf-8?B?ajRIZjB6SG9KVU9uZGNLbyszU29qL1NSVzJFc3A4V09Yc1ZQeUJHTFVOcFpy?=
 =?utf-8?B?ak9sblU5TFlFc1dzWXIxdjBoa2gwSVNoTTlMUTlhZUZUUkJiOEF5cXZzOXpi?=
 =?utf-8?B?NTdoK0NwcFo1bEtpZnBWWCtOanRQdytrRitpNTRidndkaUJoSWQ2c3UxZ1dl?=
 =?utf-8?B?M1U3bmZDbVJrQUJuM1kvYW5HeTJMODErdFVDR3NSa2ZZS0Zvc2Q5QXdKV0l6?=
 =?utf-8?B?MUFqTGlKWFdUUG1jWkdRMW5RcWl1M3hGN2lvMzBtZzhKblQ4ZDJJOEJxQmVJ?=
 =?utf-8?B?WFQ4cC9MV0VPVUY0T2FMNVVUNVpiQUZhWlJzTkZ5T2poY2M3QzF3TGhrZUtG?=
 =?utf-8?B?RTVCRWV3MklqcXE5Ry9SL3dSa3VYVGZRYTRLeEx0b0kyNDBGUkJYcXdWSFZW?=
 =?utf-8?B?ejMyK2hvT1c3UkhwelBVU2ZFY2hYTXBMV2JNTGlpL1o1eGk2VWRVaHhLQUgz?=
 =?utf-8?B?Slo5V0JtQi9sV2ZSVkQ5NlM0SnNLM0w5dHBPZ3Z0ODdQVjBoVUIzQ0ZGVTRk?=
 =?utf-8?B?U01paEgxZnphdFFCNUxGNkJieHRQSnR5NFZzTlFUR24yaDZFSXZSbitnUFFO?=
 =?utf-8?B?N0hNYVJuaTVCN1BEVUQ5ZjBwY0lrQXRNZ3NBclRRemRXM2dibkdLc0w0Ym9Q?=
 =?utf-8?B?VVpRbnVJN2NabkFMVjZRdHVrTVc0SVM1U0ZCb1YxTklwaVpxUm1EZFJ1bHRF?=
 =?utf-8?B?eU15dVFEYmJINW9yRWRwVCtERWhpemVZVWh5ZGFYZFFTUlFWV3VYMjBpTXpy?=
 =?utf-8?B?WVM5emNUaGJrc2Q4VnhEYVozby9acS9iYzkvSmNYa3BkaHFmT0Z6QmF1UjF1?=
 =?utf-8?B?RlB1emcybEhCbmdkZ25URlN2RklWZHo5MFhnd1h6eFk3TTZUWE1lUFpQQUxm?=
 =?utf-8?B?bmpVMU1JdUVnak5laXRIWkJ4bHZ0T0dob2lvbzR1Sm9lblBKSlFqSzZhSjlZ?=
 =?utf-8?B?eUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <397210EB8C04554BAB6BE6E08865CED8@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB8033.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da55b63e-d4de-4f0a-e7e5-08dc76487650
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 May 2024 08:07:57.3999
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yRT5mouWRw4bmr5XT0rt7rtvdvxD57RhlBKRdnc9aSPdVwkorjPCC2Pnjf4vPT59qbU4KKi//c7B7WYj2JseBJvWmHe067KEEubLWjtwM2w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR11MB8506

T24gRnJpLCAyMDI0LTA1LTE3IGF0IDA3OjAxICswMjAwLCBPbGVrc2lqIFJlbXBlbCB3cm90ZToN
Cj4gRVhURVJOQUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRz
IHVubGVzcyB5b3UNCj4ga25vdyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiBBZGp1c3QgdGhl
IGluaXRpYWxpemF0aW9uIHNlcXVlbmNlIG9mIEtTWjg4eDMgc3dpdGNoZXMgdG8gZW5hYmxlDQo+
IDgwMi4xcCBwcmlvcml0eSBjb250cm9sIG9uIFBvcnQgMiBiZWZvcmUgY29uZmlndXJpbmcgUG9y
dCAxLiBUaGlzDQo+IGNoYW5nZSBlbnN1cmVzIHRoZSBhcHB0cnVzdCBmdW5jdGlvbmFsaXR5IG9u
IFBvcnQgMSBvcGVyYXRlcw0KPiBjb3JyZWN0bHksIGFzIGl0IGRlcGVuZHMgb24gdGhlIHByaW9y
aXR5IHNldHRpbmdzIG9mIFBvcnQgMi4gVGhlDQo+IHByaW9yIGluaXRpYWxpemF0aW9uIHNlcXVl
bmNlIGluY29ycmVjdGx5IGNvbmZpZ3VyZWQgUG9ydCAxIGZpcnN0LA0KPiB3aGljaCBjb3VsZCBs
ZWFkIHRvIGZ1bmN0aW9uYWwgZGlzY3JlcGFuY2llcy4NCj4gDQo+IEZpeGVzOiBhMWVhNTc3MTBj
OWQgKCJuZXQ6IGRzYTogbWljcm9jaGlwOiBkY2I6IGFkZCBzcGVjaWFsIGhhbmRsaW5nDQo+IGZv
ciBLU1o4OFgzIGZhbWlseSIpDQo+IFNpZ25lZC1vZmYtYnk6IE9sZWtzaWogUmVtcGVsIDxvLnJl
bXBlbEBwZW5ndXRyb25peC5kZT4NCj4gUmV2aWV3ZWQtYnk6IEhhcmlwcmFzYWQgS2VsYW0gPGhr
ZWxhbUBtYXJ2ZWxsLmNvbT4NCg0KQWNrZWQtYnk6IEFydW4gUmFtYWRvc3MgPGFydW4ucmFtYWRv
c3NAbWljcm9jaGlwLmNvbT4NCg0K

