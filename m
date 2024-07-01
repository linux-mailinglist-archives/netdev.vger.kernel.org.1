Return-Path: <netdev+bounces-108181-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD74591E2E1
	for <lists+netdev@lfdr.de>; Mon,  1 Jul 2024 16:56:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 16E83B22BA0
	for <lists+netdev@lfdr.de>; Mon,  1 Jul 2024 14:56:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60B2C16C6AA;
	Mon,  1 Jul 2024 14:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="NqPSwgoX";
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="TUAjujPc"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A7551411DF;
	Mon,  1 Jul 2024 14:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.154.123
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719845766; cv=fail; b=BYZfcju/fK2xmYChJrmDlEuNZG2WW2jx0BhqlqqYgzKL50QonO1P9YN+EGTgkd/QNfBMlQsTXPTHPQEMM7+72tDfvZ5JmnieMdYy3+bmuM3vqVMhBGBy6ZYbbnua0hR6MyspmeM12kMuv6/x3XSzGnbOuBi+TI/RWPQT5KJcMZA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719845766; c=relaxed/simple;
	bh=2xqweAgE6rL6OV93Puxkq/kiDvRhKKA59s5BM+2RN+E=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=eA/sHi6TEI2MqDRqW8x+a0Srt4qEWN89IxsTTxUubKi2y8MX687LOlfJIMSuwNXJPY0Jx6gmOIqZycSn8j2MAHIjdHMdsSeus2xoQnHTAVgDfDKJimr9B5IYvv8wWLtg1vEXDnDNShM5S9DJRTKgP4hbFEt4i1wrHuTUhFailNI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=NqPSwgoX; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=TUAjujPc; arc=fail smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1719845761; x=1751381761;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=2xqweAgE6rL6OV93Puxkq/kiDvRhKKA59s5BM+2RN+E=;
  b=NqPSwgoXNCAaiRN5MdvziFPe2L4682t7UeVjm1NPrHe436q8vq7aKZJF
   0MQjuGMMkhKYYBrrUvw6VrifxTb9HCSAwKCTrPybC0PKTfPW7w7IKApNb
   Dlym51/qFnDqcq+5A5zentMvHDCcrnzZ67HtKP0FBWQ0tHA0YFsa5sHNS
   7SgW+b/7lqicAiFtLXAofrk66jNTGfT8/tOK4Yf7pVxcqXHS3YfW1mxlN
   xWXfCv2vnxuTvhPogHsZOCAbkxYzLN18UX+swZO4bEOmRofXPyn1ZVAfd
   S7+gjPUeBx04+aWdMKcO9qbGQArzZn8x2/4ZvGPSLKzspQz6fVtnuoNtA
   w==;
X-CSE-ConnectionGUID: XmgpRwXoSCqjUgQvNOBtfA==
X-CSE-MsgGUID: Fz0A4y2fS2+W9nhSe2NPjw==
X-IronPort-AV: E=Sophos;i="6.09,176,1716274800"; 
   d="scan'208";a="29344523"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 01 Jul 2024 07:56:00 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 1 Jul 2024 07:55:15 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (10.10.215.250)
 by email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 1 Jul 2024 07:55:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C0NZy+BSR59E5B/a62Dm0rLTTq+CzGsvDl62C7RZU42lPJWOqC1bBtY5tQsCRCrOBJ+YMyRq6oCmppwtZ0UwUOo7SDYQOzlHgWGf4uAyct83SBBZqLTSrbJmWjxDZ6HHYbJksuYsIOiBCRp3Vz/62EWTz9hYl8ro1z8eqcpD8EBD1XFO+sKqivhDSHRzX03f3JXZ1k3MQxORILav0WCEFCrmKr2viQs8uLt4NmR9rRIX5/p0NdkrYd+AN+GR6JO0MBnyT8RvfjwPYFnsFQ8J6hQlV1x4semB3lwx94uij38nObRiAiiiOkl8fQLvux+NmAzBXdeQQevcNF3+TN+CzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2xqweAgE6rL6OV93Puxkq/kiDvRhKKA59s5BM+2RN+E=;
 b=llx6pD2QPqkiwv0+nLvwMl80GVwlNp0Wevs7ZgOxUEM8Rt1RILD5ycn34Nv9oOo+6TvpBrJHeTTOKQbEE+hUe3zLlc0dcojHseKhkWlFz7SwALzeUImtqW9xCIEUlqQrC7W+6hUTgSl2atoUJWV16UFCys7hoqokkhNqPFbeXGJG5mYtl7tHXbzQukpQ0GAWPcP8EJRG1F5b/+gIJ/yDUBLOz3ZPBntbEIDeO4zw8E5GrHSJLG8/A5easG41DVJt15x1ko88wcZvVjHtEa54rzdAOd5Wu6sw1m/YWJrYEBztYpq7n+Zi/3GoMYXxneCKBcs/OlZlOeQezH+xVtL/Qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2xqweAgE6rL6OV93Puxkq/kiDvRhKKA59s5BM+2RN+E=;
 b=TUAjujPcU5rV0mc4i3jzvLo6HFiOogmzXZLvUcb8K3WK+t9S13YDoDVKSjf3oidRfHpDttqeIcXxBTNreP1gRNxF/Ya8FPTsX2Tu5dgFuEoOyMJJYYQ5KSSKWDC1V9lfQNdlPD9WiIOXQbVmRZYlIpusHsUSf2U3CPyZr5c4T8n+lOpYUXx/v8/ZufLYa/1y+n5NaQKd/Cy/rSe7ZlF1K2FkepsqGWk+sgND599ysJEMFlffXqlbTcPD/9RZHux2tfDW/XcEBFPMIHZtb+qQJinZO8pGiUIqd4mp5Pcv5Dn3xoyFbK8KSYcSH/RfyH2YOLlhNRh2iK+DWqH3ArYJUA==
Received: from PH7PR11MB8033.namprd11.prod.outlook.com (2603:10b6:510:246::12)
 by MN0PR11MB6206.namprd11.prod.outlook.com (2603:10b6:208:3c6::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.28; Mon, 1 Jul
 2024 14:55:16 +0000
Received: from PH7PR11MB8033.namprd11.prod.outlook.com
 ([fe80::22a1:16dd:eea9:330c]) by PH7PR11MB8033.namprd11.prod.outlook.com
 ([fe80::22a1:16dd:eea9:330c%3]) with mapi id 15.20.7698.033; Mon, 1 Jul 2024
 14:55:16 +0000
From: <Arun.Ramadoss@microchip.com>
To: <andrew@lunn.ch>, <olteanv@gmail.com>, <davem@davemloft.net>,
	<Woojung.Huh@microchip.com>, <pabeni@redhat.com>, <o.rempel@pengutronix.de>,
	<edumazet@google.com>, <f.fainelli@gmail.com>, <kuba@kernel.org>
CC: <l.stach@pengutronix.de>, <kernel@pengutronix.de>,
	<linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
	<UNGLinuxDriver@microchip.com>
Subject: Re: [PATCH net-next v2 1/3] net: dsa: microchip: lan9371/2: add
 100BaseTX PHY support
Thread-Topic: [PATCH net-next v2 1/3] net: dsa: microchip: lan9371/2: add
 100BaseTX PHY support
Thread-Index: AQHay5RIMN9SDzovpEyYIiUO6f7fRrHh9tGA
Date: Mon, 1 Jul 2024 14:55:16 +0000
Message-ID: <c99fbe258965cc5b762eed06c01c06255dc42ae6.camel@microchip.com>
References: <20240701085343.3042567-1-o.rempel@pengutronix.de>
In-Reply-To: <20240701085343.3042567-1-o.rempel@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.36.5-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB8033:EE_|MN0PR11MB6206:EE_
x-ms-office365-filtering-correlation-id: 01a8f9ab-7ae8-4ca6-a6d8-08dc99ddd1c3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?MHRCQlc5dnEySzBiZ3llRndyL2k1M2ErcWhDdVhuYzgrM3FlbjFRT0JTOVhw?=
 =?utf-8?B?c1FoVlhUaXRRcVFmZnlFRXY2Z2ozOUJDSGQ3d3I5eEpDV3k3cWpXbFlCOTJu?=
 =?utf-8?B?UXJHd1l5YkRIMGVueGMzTFRGSVhLTlFPeFNxYkViTVc5NE1NYlduTDBUMlpa?=
 =?utf-8?B?V0FnWlFtd3FhV1Z1SnFob0Zzb3B4b0dGQmYyN2ZRclUxSE94T1NadVBTRkZB?=
 =?utf-8?B?U3RBR3pTbzRyL3FuSzVBeEtEb3JxUTFFY3ltWFc0OTQ4RGVpTnFEYUdOUzJF?=
 =?utf-8?B?MTgxM0N3bUU3NUpnMFRiOTYvZytHWlRIUE80RkJkelY2cTVxZUNyTTdvcEtB?=
 =?utf-8?B?c0MvcVR4SnhzQitsZSsvQ3RFa05qNU5DSWpVeEtDU0t2cEVyaUhjMnVuQTRO?=
 =?utf-8?B?c2c4SERMbWpJUHlaWEZHZXhQbWplVVhja1A1ZjNrYmxXc3dGek9nR3IzVFRD?=
 =?utf-8?B?NWdWTGRMTng5NlBpUnRURytnc3JXU2dLTTdDUFhxaFVpR0cwMkYrSTlhRzNM?=
 =?utf-8?B?ZVJNaVA2WitDR1EwTUwrNHcwekhVK3BSTzNHbmRpZDBvalpHcEhTR3RzNXgy?=
 =?utf-8?B?V2d3ZUlkYllBcERvdEI5US83ZmVyM2pjcnMzUElhTnIxZFZ1TVhHRXA5TVBh?=
 =?utf-8?B?ZVFmc3NNeFN4ZDlDekdLMXFvT29WR1JDQW1uT1V5VGh5M3gyZ3NXdWNNWnVj?=
 =?utf-8?B?bUttNEdESVFsbldIbnNKZXJ0dytVVXRpeXBpQ1J4UUxuSFl1b2p3RWZQbjZ1?=
 =?utf-8?B?UjRqYnp4eitLdmVucXgrZ2ZEZkRDTm1OTTQ0ZVdVNzY1VDBRRzZybC9IVTBh?=
 =?utf-8?B?UUxXR3VScWcwdXBWVkU1VGVYN1NoUkRxMWFyVy9xeWNMZ3l4SE5Ldko1OTJH?=
 =?utf-8?B?TWN3V043VEI5TGFJQVZjRTVUQ3pJdnZTUVBRaFBSZGJQbUwzZXZKbytlU3h2?=
 =?utf-8?B?VVE0QTE4TWlGL3B0L2hvSjIxY2gyeXczZXJmeE45U2lRNFFBWVQzQWpYRG03?=
 =?utf-8?B?Q2xOS21QRnV5YmhKYUROQlNUMlRURUFCYlU2RGZ5ZGdTRklIR0g0dkM0ZHNj?=
 =?utf-8?B?ZnRHdnBpRnYvUXgyc29lVDUvKzV6QVBaWlhLYzZ5UFdIN2FKbnpkRjI0cmpP?=
 =?utf-8?B?QnAraG1vVlVobEdiSXQ0Y2VRZndONWNVWHFWdHRZTEVVaGxpWnRiNk5GUTEy?=
 =?utf-8?B?enFrUURvams3V3MreE1YSkQrdTc4MGVKczdYVFhsaVFRb0RPZEtxcTAwUmNn?=
 =?utf-8?B?NTZESVNRVUZhMTZ4TFZ2UzlGVmxmN05tcUFDdnN4eURuVnJSNUZCUzVUQ1B0?=
 =?utf-8?B?QkkyQmNOVXB6RkxOV2hyRDlnMklqRURld3hPaTVmd0YycEtTaHhtN3pISzlB?=
 =?utf-8?B?RDRoRzA1NUpHeHNFaGxKbnhhTkEyYzRYRTJpTHg4WUxYRVRMWDhRc1Q1cHdv?=
 =?utf-8?B?ZERPSHRGbE5jL0E5L2R5U3dTRVdtZ0Uyb1Q4NXVoVGhGeVZqa3dSMmx2UHFo?=
 =?utf-8?B?dXFHeTRWNE5NRDlkTEFEWE8rQU8zWTRNL0g2VlF2Q1NweE5aWnBFZk8rYVVn?=
 =?utf-8?B?SUp6bWZKbmtHekdRSXRPS2VYdjcyWEUzT1duaFJCamtTaU14ZFBDYjhuVXJz?=
 =?utf-8?B?Y1R0djZzQzhvbzdtZE01RnozdDNLSkNCSzhxY1hPNndNeHBncWhTa05iMnJN?=
 =?utf-8?B?S2FiZDAyUmFyMTd5bTZpSXEydk95OTk1TktkMEJyYS93Y3dZZklXSmo1SktJ?=
 =?utf-8?B?RlVSQ21QS00xZXZoeWh2aElvcDRMMnY2Rjl3UEs0UjBLam9xOWduUzdiTE44?=
 =?utf-8?B?Uk9ETzdUeEpwS2o3aDhsV05uNU5ubXBJRXQ2OUc2bTRLOFhFeXg1TXhkNlZE?=
 =?utf-8?B?UW1yd0ZMRUQxUVZGL21CaFV1MlBjL0MrKzNQSlZIc0xXSWc9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB8033.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?a0I4MHljRHR2bVdoOVl2UmFncDlMMExiK3lZMTNzZU1OMWRlVjZrbUZSRTB3?=
 =?utf-8?B?NW1jK0s3SHplbkJ4M2RXNC96R3ViZHB5KytBcFd2ZWlzWVNRQ1AzSGNUV0N1?=
 =?utf-8?B?dmdJUFVzQlV4Q0dhb3NVVHpIUEJpWHd6c3g1bXJJTEZsOXVRL0hTTERvREtL?=
 =?utf-8?B?OVdWdGMxMCtVMmZscUgwdTN3aW4wZVJ5ZVBPOVlNdEs3eEYwVFM1WGdKcEVX?=
 =?utf-8?B?M0xHbjdaS0xwaktWT2RZUDR2OU5VMC81Qk1GK1hSU1FxdUVKZitrWW03aW81?=
 =?utf-8?B?bkM2M2lhUmEzOWtvSk1RK3VmNVdGb3RsTGdCNEJlUk1uelhCbS9IdW95KzFl?=
 =?utf-8?B?alhKT3NObUF0YnlYUStwOFlGTVNZYS9kTjdiZEFjQnhibmtUc2NETENwMS9v?=
 =?utf-8?B?VTl0cWV2eGFUWk56M3h6dSs2N0FwWEdxb0c3K0xraENTVXZFT3B1ZUhxejFM?=
 =?utf-8?B?YWtXVlNGMFpjSkFxL1VOZjNzQkNidFY4dDV3TEhJVDZSaVBQbWM0VzRyQ0Fa?=
 =?utf-8?B?TGZVejFjUWJXZFJuMittWkhDeEs4UjZWaHAyREZCRTFheDg4RFpVWHA3QTlU?=
 =?utf-8?B?M0s5RFZPaU8rbi9ORXFCd1pFSlFpY2d0aVJFL1NocmpKT2tuQ1JDeUFjZ0V2?=
 =?utf-8?B?WWR6U3VGQlRqOVVqVzYwZExFL0o1cStGTy96akRZencrdVBZQit6S3Mxd0ph?=
 =?utf-8?B?Z2grZDVlVm5JMlY3aFZTN0ZJT0QyVFJTcUZSSkwwdmNDNTV6OWRjaFpQR3pV?=
 =?utf-8?B?UXoxcE0rUFcvc3NXOWt5SFZ5U3R3THRJb2hLZ3hVa0Y5bkM4bXVLb0dNZGJi?=
 =?utf-8?B?WTdhZW8vOXpCT0JxSGlqOFd6ZVIxNFFOSnpIbVVtTm4zTW9YY2hGUjF0WTZD?=
 =?utf-8?B?bmhSVWIyZDRqYVovZXlrYm04WUx6SDRiUlFSeVdjMjQwL2dFOEVOdVhrMXJY?=
 =?utf-8?B?TnRRRDdJV0NwSDlCclpEUksyYzg1RXRwNTFoYllJSnY4cHdURWwyalNzRGJK?=
 =?utf-8?B?ek9sM2NJSlc3ZEJiYXVOWnJZSzRHbnd5S2F4SmNvL3YwZ2hWYnhhcmxHeHlE?=
 =?utf-8?B?L3pzYVJ1anBuZlZRYjgxMzVtcndwcEpzbjk3SnBiOW5tUkJ4YnlqRVBtdUFI?=
 =?utf-8?B?ZWprSFM2OWJ4ZVlmS2s1Z2dRdExBbmpSdnN4bVIyMVdFYlFwTU5USnNta29S?=
 =?utf-8?B?cDdqMmZPYldTZDFKSGFxUkhmUDBIMFM0djByMU84ejFxYzFtMllHTEFoNTZW?=
 =?utf-8?B?dmk5eG5mY1pXa2JOa3BoTGQ4VXU0SlBwYjFPNlduRFdONHdvYTloNmNTMXZH?=
 =?utf-8?B?VzJhQTV6eTgwMkxjWU4yQVhpVG1lOVUrM2JnZzZQdFZGKzdpd2puTlRiaVc2?=
 =?utf-8?B?OThNN2gyaFlLS0VuWlBSa1R3OS9SMFlMY1lONC95dmVvd3ZydXNwZXpWRnZy?=
 =?utf-8?B?Nnl6SWJ5QWEyNjFUaGlaWnNZZ3c0UWNjbE5CN0kvZVl5RW92dWk5Z0lJWTYx?=
 =?utf-8?B?aklKM1dQL2pqSkJuUno1RHM2NEZUa3h2a3lxRkN2ODNSUG5wU2R0TzNVekJG?=
 =?utf-8?B?UXdwMXpLSSsrT3ZXN2dxREI5OVdZaUZTU0JMbkxxc0dXVTgzT0FybmdNb2Qv?=
 =?utf-8?B?SWdtbFJzRkZuTlF4OFgrUlV5K2dONGVaTXQySjVieEhOSlROR0M2SmJoUDM4?=
 =?utf-8?B?RjZyVWs3dWpUOUo1b3lzVnlNa2hkVSs0R28xVkFPSnpzS0lCNUF3TE8rWm00?=
 =?utf-8?B?TjZnVWgyRzBaZFBQYjhtRjE4UnB2WjhLZ1JsVExJdnhYYWhOUFlLNnZUWFhU?=
 =?utf-8?B?YWJUM1BNY2pXSUFOWGJHSmVFTUMzbzJDVEtaRFluWkNVRE90V1F6M0dSZWZU?=
 =?utf-8?B?aDRRaW82Q3VVSXYxbDBrVGhCbzJCdCtmMFdic1JBTTJHbTVkcXJHdEJoNmhh?=
 =?utf-8?B?MS9UK2xZZGNqWG8wVkRzeWxSd2pxRUVUSXNHWmtUcmljQzNEZXVVUGd6N1Nh?=
 =?utf-8?B?MXdQeU5kWlptSTI2M2U4dnIvOXhIU04wQVV3NTZyVXVoRVlKQUR5MDM2RU1a?=
 =?utf-8?B?M21Qc1RLbVJjYnJGK2RPR2NjSGgyYnFKMXE5akh2NEI4eVZxdzZEdDZPbGph?=
 =?utf-8?B?QkdGS2xoekczdUxzMERKRFJOSkVGZ29RVFo3OEltODZzbXRCM0l5bFhXSkYx?=
 =?utf-8?B?c3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3611B940DE91854B8A00343AB3ED89B4@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB8033.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01a8f9ab-7ae8-4ca6-a6d8-08dc99ddd1c3
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jul 2024 14:55:16.5261
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 05rKWHqcYJY6q3YZXTLPes1rTBchZ8ZgAek75I2qPVpWiFUOpRxq2nOKZMEkvLfMBPLpZ6oITOqje7LiJnUQWvTKJ6kWfYcKZcw8b43uUEQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6206

T24gTW9uLCAyMDI0LTA3LTAxIGF0IDEwOjUzICswMjAwLCBPbGVrc2lqIFJlbXBlbCB3cm90ZToN
Cj4gRVhURVJOQUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRz
IHVubGVzcyB5b3UNCj4ga25vdyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiBGcm9tOiBMdWNh
cyBTdGFjaCA8bC5zdGFjaEBwZW5ndXRyb25peC5kZT4NCj4gDQo+IE9uIHRoZSBMQU45MzcxIGFu
ZCBMQU45MzcyLCB0aGUgNHRoIGludGVybmFsIFBIWSBpcyBhIDEwMEJhc2VUWCBQSFkNCj4gaW5z
dGVhZCBvZiBhIDEwMEJhc2VUMSBQSFkuIFRoZSAxMDBCYXNlVFggUEhZcyBoYXZlIGEgZGlmZmVy
ZW50IGJhc2UNCj4gcmVnaXN0ZXIgb2Zmc2V0Lg0KPiANCj4gU2lnbmVkLW9mZi1ieTogTHVjYXMg
U3RhY2ggPGwuc3RhY2hAcGVuZ3V0cm9uaXguZGU+DQo+IFNpZ25lZC1vZmYtYnk6IE9sZWtzaWog
UmVtcGVsIDxvLnJlbXBlbEBwZW5ndXRyb25peC5kZT4NCg0KQWNrZWQtYnk6IEFydW4gUmFtYWRv
c3MgPGFydW4ucmFtYWRvc3NAbWljcm9jaGlwLmNvbT4NCg0K

