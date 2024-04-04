Return-Path: <netdev+bounces-84694-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B1495897E06
	for <lists+netdev@lfdr.de>; Thu,  4 Apr 2024 05:41:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D502287618
	for <lists+netdev@lfdr.de>; Thu,  4 Apr 2024 03:41:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AC381CD32;
	Thu,  4 Apr 2024 03:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="e5MBUh+n";
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="WYLemuWF"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDAF418AF4
	for <netdev@vger.kernel.org>; Thu,  4 Apr 2024 03:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.154.123
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712202105; cv=fail; b=UtgtyBmZjM5HdKnNB/CZUFz/mc+VatIWre61LcFxOe6RN9rJP3x7BW8vWzrqFG5bYIwgHWahpNg/vzjtyaEEPDngGDEWefx7jL/UtdZ4/bip2OXyqnA+JlZ2MyKMucswbrRUZX6Bv2eiB1JNW2YaIN7rA9tsI9ZSbktJF5Ejz0I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712202105; c=relaxed/simple;
	bh=bkrEVUrJafsi2zFN+C8Du9PDQzN+BDRt2fA6+/An2OI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HYJLMira0TnDp7vb3qQ4Uzz5qvtze3V0+o1IOs4bkyejMhujirjzjDle7mVOa0uOcNyIb/jCfvmwrtmq5SBc/O9QBcfa7j2WZo2GlbOwJj5Ia8ejbmSUkCNH4Sg3XKK+4WMDdRkBOnRyv/7QanQ9I9xA8f3QRKqLZYaTtdQnVaQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=e5MBUh+n; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=WYLemuWF; arc=fail smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1712202103; x=1743738103;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=bkrEVUrJafsi2zFN+C8Du9PDQzN+BDRt2fA6+/An2OI=;
  b=e5MBUh+nIKF3H8p8nXV3hKBwg4PZMEXBVAS6nBpZ+o/U/otP57AbQRel
   txHiem58AkYrPKFc5oOc9z5hrtXvqKvyGVW5nzWIm/hk39yiFBNVoCZ3E
   zugzUWyPrg1vk1Ux/Nv6tBOtIvqnq5khNF4iBk5Vcb8CwA7PMqzXjzoMh
   5sEdmQUO5LnP1xZRyjENT2lbWGzJGVVZtIHf+WY8E3WFGujhaBMQc7NxB
   Cm3UpOiGR9pgofmf8OZbaNqaXVHJ7ifD3M2pQUmCdp8/40zB4xFMHmYZO
   sNByFf3u25lCKjbT5YkT6hACEUgbeh+p9lKog48KjlWo/pIRGrmKJdmnR
   Q==;
X-CSE-ConnectionGUID: nSf+O+3fQwWvqDAI8GcFjQ==
X-CSE-MsgGUID: 1/esvV6hSnO1Vm4COfLv4w==
X-IronPort-AV: E=Sophos;i="6.07,178,1708412400"; 
   d="scan'208";a="19356341"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 03 Apr 2024 20:41:42 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 3 Apr 2024 20:41:27 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (10.10.215.250)
 by email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 3 Apr 2024 20:41:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZGblolc+eahWLUg4o1MrlrbZEZd0/S0cDyJfbFwQlrKvIL6LFu6pViWuorGdqF8MX9YjJStxA0xJKSR8Wcj/JcFAO9frZRR+MgBDssIia7nNGQbfuGEE5o0CsJ8+gF84xy76byEQhwXd59B9fF24dz0q3dZ5s5s1dt80gjKU7gWtd4rvMa4vbY4YkOJi6mEDWZxYncxgZXN31AnTV1czAorn+U9smE94NWgQELEk8c2vFMEGhu4v+vSdcz6E0Bm2oJVgdFNuLjGnaI+Xwo7YwZAMfp/ypekQ8q9bxIG2H8051ZK3iKgHSQ898hemqMcML0fe9Hb+v5XqhHGQrxDWCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bkrEVUrJafsi2zFN+C8Du9PDQzN+BDRt2fA6+/An2OI=;
 b=W9rIrZAIHMfio941mg+pX4Qt4QK+nPFvLDf/kBOxbcDky/m9UuGFKv2qGLn2EinJGpARCMNxKemcgSXwDjzoFk3RstnU9To3MlXRXeOu+dE7TuDqsqe+bhsZSKS00vD8cGcBRFuW2yYhFtYDxlyGN6bWKsgrVGdZIyjveJqjlYFNBOmPf3UC/thUaoByNjKT3rtRCzVWoskxGMgm0U+0/FaeKp/Jy2UpxhkEQ46X6XM/ItnJUugtX1n6EuUdpzIbd/Dl/PlxibMXbiv5X2sdAjo0WcIYay08VrXndCPqyrYqUjBQDfUBgd6j+5b8Ois8J+MQ1pe6qbSBXRDiP4Ebdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bkrEVUrJafsi2zFN+C8Du9PDQzN+BDRt2fA6+/An2OI=;
 b=WYLemuWF7u5yq9Yig8BDlNg3GIstMFiStRAQ0Z51wdA+yK29pvGX1HtWLJuoXMKJ/StOnph1iCIE2aZ0ejhUFWb6m8FCGLcAR1XJAK9oDF3xkzZxxXLWI84HS2ccL4szRkHrrHRAhVIvVbCcPLPKYP3zpjDcA6SGzxqufJl96c1ekvYTLaJUnAS9w8EPylL0xck1I8ixu08uF9vcsjCN2XBELpnYFCDlNvrINqvj2/kLQ7aqcwoDTo7Q8ou04W7AU6oz0UCbEZKAPzl2liY82UAcIGMhRdmj5um3KCAOCIIesV/5Er24mNr4C7RKE+1SVpYGRYKRV6k2rop9Ftr3EA==
Received: from PH7PR11MB8033.namprd11.prod.outlook.com (2603:10b6:510:246::12)
 by PH7PR11MB8525.namprd11.prod.outlook.com (2603:10b6:510:304::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.25; Thu, 4 Apr
 2024 03:41:24 +0000
Received: from PH7PR11MB8033.namprd11.prod.outlook.com
 ([fe80::d529:f716:6630:2a1d]) by PH7PR11MB8033.namprd11.prod.outlook.com
 ([fe80::d529:f716:6630:2a1d%3]) with mapi id 15.20.7409.031; Thu, 4 Apr 2024
 03:41:21 +0000
From: <Arun.Ramadoss@microchip.com>
To: <l.stach@pengutronix.de>, <olteanv@gmail.com>,
	<Woojung.Huh@microchip.com>, <UNGLinuxDriver@microchip.com>,
	<andrew@lunn.ch>, <f.fainelli@gmail.com>
CC: <kernel@pengutronix.de>, <patchwork-lst@pengutronix.de>,
	<netdev@vger.kernel.org>
Subject: Re: [PATCH 1/3] net: dsa: microchip: lan9372: fix TX PHY access
Thread-Topic: [PATCH 1/3] net: dsa: microchip: lan9372: fix TX PHY access
Thread-Index: AQHahfEtQYIs3MKw/E6hW9sVGOfsXLFXeGeA
Date: Thu, 4 Apr 2024 03:41:21 +0000
Message-ID: <8066744273f2000c0c02d04632ab26a207c57da2.camel@microchip.com>
References: <20240403180226.1641383-1-l.stach@pengutronix.de>
In-Reply-To: <20240403180226.1641383-1-l.stach@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.36.5-0ubuntu1 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB8033:EE_|PH7PR11MB8525:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: T6jgbgGW8hCXBSI63GTy/YSL/TRlWiS+ByRrNyg7khcc3gkKP+ZQ1BWYj2IVcEqhh/vQkscV1VNFwpIO3wM0VX2PnQtmmexx1y9ZPjtktBSs7mf+aK68PmtH2O/P/8uzyMPcWYvd3bLU0JXrFTWwqURlFcGKIaixuA86enxB6CchDRl7LuzdddLBcg0n0/9vyZ0/loS+XiNC7cgsvA7eJdTt1ZJruwV4ds7JSBq5NGexks+cJBwBa5do7o8s8XIjbAM4X7OV2HOHuxfzNQTYX5+1XGtFopQEV/DmY7PDhzirnwbMWEO8q2WZOlkuHBrwE0OZ0g49TecQmb7v6Gf3OYj/33ZYrD0xsWX7biEnky5SKluSDuxoBH5f0b5opr2Ke0ha/p3MXO7fJzP0lcvA3oFlGHeLe4FamWjLQOx0saeD7PC8zL7Ma13NsppU5/ov5kkw7pITmhpB+fM1t7doWCZxJh9oT5ZR8oXWiaE7ud07eSnrafdVxT4EuMBnP3wLQ906Wujcnyl5mpGJDTV0PqUQgpXHjlYlqJlhO+/emVxlWh9FOKv4QDSw2ywLEYFD+eawNhpdZ8WB0mbia7Vjbbvj42h0Uko2um3s/XK8X3xSx22GfodK2zkqXV0IhR0SevGZVtsnCHObi4kp2SyS51SGbd9J72Ai9G6zj+U/khI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB8033.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UHBMZU1YeUdYNWRWa3BDVXNuci94L2RpZ0lvWU1JR3YvdWpxR1NnSkhuRWZC?=
 =?utf-8?B?N2NxQnkrcjM5V2Z5V3JUZFF1a0J0eEVwREhwTERSM0V6aGRsNEpIamw3MGtB?=
 =?utf-8?B?T2o2djZXTXhvRWFMb3B3MUUvSVdmd0hNaVZFUkRiZVJQSjRaaUMydHdHR01D?=
 =?utf-8?B?RmN6U0xiRWpJMGE5OUZIRERzbWdJbmlxVHVvak1kZFdtM2dYc2JNQklqb2dl?=
 =?utf-8?B?Sy9ZRU80ZEVIRk05R0ZaazNBTE9LL3FDZDA0L2FFUEt1OUU5UnJuMmliTmx4?=
 =?utf-8?B?b0pGK2huVXJ2aVNMeGNMd0NaZEsvRTNwb0w2OXJXOGRIMzNhR1RuYU55T3ht?=
 =?utf-8?B?RzNRZURUTTdzQzB0Z09hTjQ2cGY2TUpsRWdHa1c1ZVdseFl0VDBWWmpjNmlt?=
 =?utf-8?B?eDhOR0NTaTJUSk9TREhEd0hoYUZnd3FwWHRSNm4yaFNQbDBPbWR5V2lLdEhR?=
 =?utf-8?B?MDBZbTIrNzFzeHZrdVJaK2J1ZEpJVldEYzVrRzJhOW5CZDM1RlpTTUMxWll3?=
 =?utf-8?B?SzE2WUdKYmYwUUw3YXVSczQ4ZVk3dnRoV0dlck5WUzBON1cvSGptUHdvNjJv?=
 =?utf-8?B?WkR4dkV3d2dXMHQvcE96a1ZaUnJGRi9zKzRRQWFuMTlTVm16dWszRTArazh6?=
 =?utf-8?B?eHFyTzNPQ0l5TmxRcjJUUzZZTXUvRHczZVF0MCtmNGttbGtCa0RhZ2VRSHJ2?=
 =?utf-8?B?elFaWVV2VWlFbWs2RW5xTlVqVzdTemZxalowb1crSlJHM01MTHB4YTAzQ0dY?=
 =?utf-8?B?NjNBRnpCbGtRd0t6RUpIcUNpNFR1Ry9jbmNQdCtXZTVQRCtUNnZ4aVJFdG1i?=
 =?utf-8?B?VmJiVEJhZnp3RXN6eGdrYWFRTmJmQVhINzR5NXR1aHBad2ttVFlVSGd2eklV?=
 =?utf-8?B?bDliNndCMTVuVWdhRHVyblFtUUQ3NVVoMEpsL2FTYW9LcmQwdEF3eGg2LzdB?=
 =?utf-8?B?cEtLM0NXUXZYemphblFxQ3pYdVpMZkpQR0s4RktpTFQ5N040a2MxdlNLZXlt?=
 =?utf-8?B?YkVha3J0U2ZRTkFEVXVuamUwYkxPUTNxRFBCaGw3MjRnVXR4aWJ2azI2ZmlF?=
 =?utf-8?B?Z1JJbVQ5UXE2blJoaUlPSmR6L0JNWTcxdWM2NjU4ZmxwRzNoQUwyMUZ4OWVT?=
 =?utf-8?B?TmdaYUloSWx1OGV2T01MdnpBd3I0QStoMEc4QzZnNEdTbXJMbkhZZFVhcVNN?=
 =?utf-8?B?Ump0MmxCbEJKaFVaRlM1UVdyOWZiSm1jVW9IRFU5aVhySXFpZ3hWM2JMcjZS?=
 =?utf-8?B?TEFnaEVMeTdPMFNSNGt6S0I4a3VaZmZZZWRVWFF4ZTdCMEptTWN3dDNvalp3?=
 =?utf-8?B?SFNiNmlCRjRreTZIMkZYZXBvQS90YmZkR1FXalUrakFvdTZGUEpNZXZkV0Iv?=
 =?utf-8?B?L2U4aGVSTG00a1dMZytPbmM3TnYzcUsxZFF1eGlBeTZJSEZWY0MrQlczTjBD?=
 =?utf-8?B?WHQrakI0UUtLekNKS0M2dFQ5RmVuc1pBWm4zQ0xUUjJIaWxiRTMvQ1JnRmtJ?=
 =?utf-8?B?a0NQeGZ1N2U1ck1ONEdHK3R4U2F2U1o3YzFYeVFxN1JLTTNUK05XbUdjaUZM?=
 =?utf-8?B?U0hxZ1Bsb0NIaEd2VzczSXFPTktiMGYvbTVneDRwQm5lV1BjZ1l4MlJPbnZp?=
 =?utf-8?B?VURvK3dCdGVQNGVZTlpvcGhXRmRhUlJIZG5ONkJqNFVLaXhYRnBBdkpRdkc1?=
 =?utf-8?B?RFQvNy8ybkFJSzBxdVVHQ3ZqWlR1OGpBa1RjY3hNYWQ1VUJEd2pKTnJBb3Qr?=
 =?utf-8?B?VTJ0V21idU90N0piS1JxV3N0SG5JeE9RaVd2Y3JZSnpDMFUvQWoweEJaeDMw?=
 =?utf-8?B?NjIyaE9UbDBhOVI5L0RpRkRTSjFIdEk4RkErUCs1cElzUEZLZ1l5ejVMVVhG?=
 =?utf-8?B?aDlKWHlEaDlPdldMYXZ6TkRFRFNwb2VSZ1hnQ24xSHBkRW1yMWFranl6K2gx?=
 =?utf-8?B?eGwzMEgyZHQ5VC9WTjZ2SnU3OExocnF3OERuQ3FoMlhtQXZ6L0VZRHdHYkRu?=
 =?utf-8?B?MytWdURRNlhlL1NrN3BzR0F0NytMaTcrK0RlSm54UHl0UlgwSDNwdjZ0TDhw?=
 =?utf-8?B?NC8xWmtVdS8wTGJSSmtVVUdjWGEwbkl3TDg0K1o2Z2xsTjE5S1hZZ2lmcGh6?=
 =?utf-8?B?V0FPd2trWTlGTGFoZHZuVTRNaTBOT2xWSVhrRGpOZVJrT1BpMHd1OGlqdy9N?=
 =?utf-8?B?WkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1EC0350E44664F4598ACA0A72D328CB4@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB8033.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fec62f4-b3c0-4d26-1962-08dc54591860
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Apr 2024 03:41:21.7285
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Z720W9huw+d0bgc4uc08ofiiJ3RIZjMrCNs6IPD+fkRxUFv4Fcx1xdqRYBmv4W/iD3tf8qAKAw1dRyZUu2bYy+J0zShmNbzYk55xHKfMDag=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8525

T24gV2VkLCAyMDI0LTA0LTAzIGF0IDIwOjAyICswMjAwLCBMdWNhcyBTdGFjaCB3cm90ZToNCj4g
W1NvbWUgcGVvcGxlIHdobyByZWNlaXZlZCB0aGlzIG1lc3NhZ2UgZG9uJ3Qgb2Z0ZW4gZ2V0IGVt
YWlsIGZyb20NCj4gbC5zdGFjaEBwZW5ndXRyb25peC5kZS4gTGVhcm4gd2h5IHRoaXMgaXMgaW1w
b3J0YW50IGF0IA0KPiBodHRwczovL2FrYS5tcy9MZWFybkFib3V0U2VuZGVySWRlbnRpZmljYXRp
b24gXQ0KPiANCj4gRVhURVJOQUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0
dGFjaG1lbnRzIHVubGVzcyB5b3UNCj4ga25vdyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiBP
biB0aGUgTEFOOTM3MiB0aGUgNHRoIGludGVybmFsIFBIWSBpcyBhIFRYIFBIWSBpbnN0ZWFkIG9m
IGEgVDEgUEhZLg0KPiBUWCBQSFlzIGhhdmUgYSBkaWZmZXJlbnQgYmFzZSByZWdpc3RlciBvZmZz
ZXQuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBMdWNhcyBTdGFjaCA8bC5zdGFjaEBwZW5ndXRyb25p
eC5kZT4NCg0KQXMgaXQgaXMgdGFyZ2V0dGVkIG5ldCwgaXQgc2hvdWxkIGhhdmUgZml4ZXMgdGFn
LiANCg0KPiAtLS0NCj4gIGRyaXZlcnMvbmV0L2RzYS9taWNyb2NoaXAvbGFuOTM3eF9tYWluLmMg
fCAzICsrKw0KPiAgZHJpdmVycy9uZXQvZHNhL21pY3JvY2hpcC9sYW45Mzd4X3JlZy5oICB8IDEg
Kw0KPiAgMiBmaWxlcyBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKykNCj4gDQo+IGRpZmYgLS1naXQg
YS9kcml2ZXJzL25ldC9kc2EvbWljcm9jaGlwL2xhbjkzN3hfbWFpbi5jDQo+IGIvZHJpdmVycy9u
ZXQvZHNhL21pY3JvY2hpcC9sYW45Mzd4X21haW4uYw0KPiBpbmRleCBiNDc5YTYyOGIxYWUuLjZh
MjBjYmFjYzUxMyAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9uZXQvZHNhL21pY3JvY2hpcC9sYW45
Mzd4X21haW4uYw0KPiArKysgYi9kcml2ZXJzL25ldC9kc2EvbWljcm9jaGlwL2xhbjkzN3hfbWFp
bi5jDQo+IEBAIC01NSw2ICs1NSw5IEBAIHN0YXRpYyBpbnQgbGFuOTM3eF92cGh5X2luZF9hZGRy
X3dyKHN0cnVjdA0KPiBrc3pfZGV2aWNlICpkZXYsIGludCBhZGRyLCBpbnQgcmVnKQ0KPiAgICAg
ICAgIHUxNiBhZGRyX2Jhc2UgPSBSRUdfUE9SVF9UMV9QSFlfQ1RSTF9CQVNFOw0KPiAgICAgICAg
IHUxNiB0ZW1wOw0KPiANCj4gKyAgICAgICBpZiAoZGV2LT5pbmZvLT5jaGlwX2lkID09IExBTjkz
NzJfQ0hJUF9JRCAmJiBhZGRyID09IDMpDQo+ICsgICAgICAgICAgICAgICBhZGRyX2Jhc2UgPSBS
RUdfUE9SVF9UWF9QSFlfQ1RSTF9CQVNFOw0KDQpMQU45MzcxIGlzIHNpbWlsYXIgdG8gTEFOOTM3
MiwgaXQgYWxzbyBoYXZlIDR0aCBpbnRlcm5hbCBwaHkgYXMgVHggUGh5Lg0KQ2FuIHlvdSBwbGVh
c2UgYWRkIExBTjkzNzEgYXMgd2VsbCBoZXJlLiANCg0KPiArDQo+ICAgICAgICAgLyogZ2V0IHJl
Z2lzdGVyIGFkZHJlc3MgYmFzZWQgb24gdGhlIGxvZ2ljYWwgcG9ydCAqLw0KPiAgICAgICAgIHRl
bXAgPSBQT1JUX0NUUkxfQUREUihhZGRyLCAoYWRkcl9iYXNlICsgKHJlZyA8PCAyKSkpOw0KPiAN
Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L2RzYS9taWNyb2NoaXAvbGFuOTM3eF9yZWcuaA0K
PiBiL2RyaXZlcnMvbmV0L2RzYS9taWNyb2NoaXAvbGFuOTM3eF9yZWcuaA0KPiBpbmRleCA0NWI2
MDZiNjQyOWYuLjdlY2FkYTkyNDAyMyAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9uZXQvZHNhL21p
Y3JvY2hpcC9sYW45Mzd4X3JlZy5oDQo+ICsrKyBiL2RyaXZlcnMvbmV0L2RzYS9taWNyb2NoaXAv
bGFuOTM3eF9yZWcuaA0KPiBAQCAtMTQ3LDYgKzE0Nyw3IEBADQo+IA0KPiAgLyogMSAtIFBoeSAq
Lw0KPiAgI2RlZmluZSBSRUdfUE9SVF9UMV9QSFlfQ1RSTF9CQVNFICAgICAgMHgwMTAwDQo+ICsj
ZGVmaW5lIFJFR19QT1JUX1RYX1BIWV9DVFJMX0JBU0UgICAgICAweDAyODANCj4gDQo+ICAvKiAz
IC0geE1JSSAqLw0KPiAgI2RlZmluZSBQT1JUX1NHTUlJX1NFTCAgICAgICAgICAgICAgICAgQklU
KDcpDQo+IC0tDQo+IDIuMzkuMg0KPiANCg==

