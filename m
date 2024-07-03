Return-Path: <netdev+bounces-108690-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02835924F58
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 05:20:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA59228CDC7
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 03:20:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86B2A4778E;
	Wed,  3 Jul 2024 03:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="ain+WNgI";
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="htqlmwPm"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFB244642D;
	Wed,  3 Jul 2024 03:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.153.233
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719976193; cv=fail; b=tjwsusU4AI8cklhZB1VtTdYV8hvrh4y7xfz7bPRB2VdhcvKLEwIHLvRZIq1T1NTQvqPI4JMx10Jtw7ny6nq+vfmTb9SrMz4Hv8/GoZZW+RpI4qW5x0SRUlgLziAIGwWVvwwGwccT7d29Dh7dJrVdXi/jL9ejDeZnhBFfQITp8c0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719976193; c=relaxed/simple;
	bh=Lat7cfajb73Q2zMhsyk8t5ceM1zNHhcePVkkAGFGtZE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=bAjpLoOKc1ZeOVWmolkKUXspHlAQsbyBRpPW5HqzKkPIc9KFdrszlcqIUHTBd9weJ8YOzZL1mARxYEEQaymsOwOFyXF9y5IRy6bZYuJV9VxqQSVuIElA63JW4DxEgQNmkXreKMr1TOsJqW61Ke9STGefhzyDS66oHXqp7LF84fw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=fail smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=ain+WNgI; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=htqlmwPm; arc=fail smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1719976190; x=1751512190;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Lat7cfajb73Q2zMhsyk8t5ceM1zNHhcePVkkAGFGtZE=;
  b=ain+WNgI5QMVCrjILnIGmUhMyOMtbTmpJWKehT014vSKp86Ujyq2CZ3P
   XOoUAPC4AGzGOabFlTUXsWmF5XfAplFjyPFmQcTZomxI3L8lerYArNm0K
   eOcM0ztuKFJmd4H1OGNnPrImm8cGKiSRY/1rU3mTo6W37J83Blmsgis/y
   HxvuAc787434Qr6Bi/2xmRwFguLs36AUVofhGwnzgAzxRjNm/MyWJgwmQ
   Iv8iowqBBH4x3yabqGZOlpkAPB8S4OHiSzdkKIAdjOKm26yMYIbPtcP5N
   Wc51GmOn4PDT4HjtL7KAJLo4a6Kw+0oWGfduCQS70h3eKI6vXHt7mmMcQ
   A==;
X-CSE-ConnectionGUID: 27cCq/f8Tc6mdR2WoVyV3g==
X-CSE-MsgGUID: VFaG+oCER66QWWLSfJCLXA==
X-IronPort-AV: E=Sophos;i="6.09,180,1716274800"; 
   d="scan'208";a="31401286"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 02 Jul 2024 20:09:43 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 2 Jul 2024 20:09:37 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (10.10.215.250)
 by email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 2 Jul 2024 20:09:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RmW4Uh9qGlGkEN2p8ylCtFjUdm64TvqqAQx9a4JAZ6ZMSGGwzdKaALtEhBzOaWxzcbIlHGFHPl7fBc8B3WJ7Tg4UNBq+P4MXxwJ42QWfnDhgpQY30MoR0Gp3bORRutb5V1m35ie82K6o0xkSf/Q9yLljYvG4U47mGaZZTHodC1bsXgxPyDjYBK55BK5D4cLYxDR3qYAlW2t4XpG2Dk2sVihHwqKi3Xg2C3XM9+7uerAPUN6iok9IcYuzIfAlxvQ7UKkc3QWBMKueAFVP8lKK0k51LkjJnQ9DjH5JU3nCEZ7oQ09Jb4medMDKmjxVbVKFxEMYI+SNGoD4RGZ/7CexZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lat7cfajb73Q2zMhsyk8t5ceM1zNHhcePVkkAGFGtZE=;
 b=f26PeCrfgpHSuB3sL3WCMbU7CqoUs1cCwCNNk5FxMr+79qVO1Co8wnwt30/MrY2So94AcxlHH+ld2gtaNLBtlMdTTjorf6hSd/2ny/9U1TXCsVLPYl1AwybCL91Fmi6OW4NB85ohLqUH7hVpDDN97RhTOL0RtioeJUm26ZLdVXIZq7Sc7VWWIcaigTkoPEmgUxcGDlolqGU9CXF4HZdQLDnLvrkriAQYS/CLCfSPk0S2/tEZqgyiTEcNbaq9jT0CmpcJU0MBLclN7ZZUIvmPTyAFO8b3WSZ4oaMG8gr9xO4i79Qorw0WYIMZC58+gQX+gVmyoJNBVGVL5+3Vie0aIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lat7cfajb73Q2zMhsyk8t5ceM1zNHhcePVkkAGFGtZE=;
 b=htqlmwPmwr8rwR8R/qC8RayFBJb3dMzq+hCm2IA/e7k9k9vVy/9OCEuqH4W1fJyIwRJ/G1XmkSB/nWvCElz4FrkIzC/tMQ5UdNevidw2XoLkkW04oznmZu3jOQUJza9nxXzu8L3JBWm6VztUcTZoSSqA0/oippEtjvDmvO80lBfHQI967d+orbdBWvlQuEJZX5JAKsZrnYDNCm0MsaPzX30p0zEGGpNsTQ/7YcWdP/bvfCXomzV3BCkbZphK8Z0O+j0Vksl8GcOTpsaI+mkwTL4SzlhRGa7bWIWJdmy61JtDsdK/XkpncRH0Qbljvfc4kXE5RZfFDBOOgfJVdwq5eQ==
Received: from PH7PR11MB8033.namprd11.prod.outlook.com (2603:10b6:510:246::12)
 by IA1PR11MB7269.namprd11.prod.outlook.com (2603:10b6:208:42b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.33; Wed, 3 Jul
 2024 03:09:34 +0000
Received: from PH7PR11MB8033.namprd11.prod.outlook.com
 ([fe80::22a1:16dd:eea9:330c]) by PH7PR11MB8033.namprd11.prod.outlook.com
 ([fe80::22a1:16dd:eea9:330c%3]) with mapi id 15.20.7698.033; Wed, 3 Jul 2024
 03:09:33 +0000
From: <Arun.Ramadoss@microchip.com>
To: <andrew@lunn.ch>, <olteanv@gmail.com>, <davem@davemloft.net>,
	<Woojung.Huh@microchip.com>, <pabeni@redhat.com>, <o.rempel@pengutronix.de>,
	<edumazet@google.com>, <f.fainelli@gmail.com>, <kuba@kernel.org>
CC: <l.stach@pengutronix.de>, <kernel@pengutronix.de>,
	<linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
	<UNGLinuxDriver@microchip.com>
Subject: Re: [PATCH net-next v2 2/3] net: dsa: microchip: lan937x: disable
 in-band status support for RGMII interfaces
Thread-Topic: [PATCH net-next v2 2/3] net: dsa: microchip: lan937x: disable
 in-band status support for RGMII interfaces
Thread-Index: AQHay5RFH4RfEgObIEe9Dk3MN8WFZ7HkVk2A
Date: Wed, 3 Jul 2024 03:09:33 +0000
Message-ID: <c3bd53402133e727bb34b6655d62fc2d472e2ede.camel@microchip.com>
References: <20240701085343.3042567-1-o.rempel@pengutronix.de>
	 <20240701085343.3042567-2-o.rempel@pengutronix.de>
In-Reply-To: <20240701085343.3042567-2-o.rempel@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.36.5-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB8033:EE_|IA1PR11MB7269:EE_
x-ms-office365-filtering-correlation-id: b1ff96c3-136f-439c-3db5-08dc9b0d9014
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?M0JFRFB6TEdlazV5cmx5ZXdjL3BlanZyTTNVaVdFL3Y4andxS3lGblErMWls?=
 =?utf-8?B?b1hYcVVRUVlHcW14SS9hS3FUVkc5UXdHeUlJTkFMMGlwemM3QkozSUtycmtN?=
 =?utf-8?B?eVF2NkpMVDQ2cTJpRjUwOGlKMWFFYUFwY1VKSXB5Y05lZkorak9zdWRYOUlM?=
 =?utf-8?B?d2xOS3JDLzRHa2F3RzhvdUZzVzlsbW5YandZeDVCZFlXL0lmVTJGWXlMYWcw?=
 =?utf-8?B?ZDdXMFFSWlRQUlZCeWdBdm9aQ0huS2hPM1FlQkdYRVBPYlFhQmd5M1RUMHgz?=
 =?utf-8?B?TWRIMkw1TzRKYmFFNElySitpR3JRZDZuVDlqOHFYLzh2cjAwQ1RzVVBXM2U3?=
 =?utf-8?B?Z3BSVEM0RDVzUjlzRHNWVkQ4T2Z4V1hZcC9uVFFpZWxMSER5d0pHUUpuUnlp?=
 =?utf-8?B?cXJjUm02akZnc2ZWcEpmRkZtOXFPTmpHR2ZKNk5HNnZRK1hTZDFLTVlTR1Ez?=
 =?utf-8?B?MXE1U3V1OTNpMjVjZ1J0V05xNWhKK1pTUnRUT243RDlkN3dSNWVsUEZMMFNT?=
 =?utf-8?B?RWJqNmc4eENWd2ErODFrd29NL0p1ZTV3YUFwbklkTHVWaW1vellCQ3ZHMHo4?=
 =?utf-8?B?T09tWHh2enV4WUpEc0QwOHVVYVlzbHRNSHo5a3J6TkY2eStubzhMZ1UyN3pH?=
 =?utf-8?B?K0tKUkZCWXR6QWlld2pmK1BIVXdWM2lqUlZFbnhMMEkzQVRRNVp6ODF3WWhz?=
 =?utf-8?B?Wk9KRTlXNHRZb2ZFU1gxRFRhZFRvcHlsTjExcTNqemZQcjhqeWN5OXZhVGgz?=
 =?utf-8?B?RURyMGpqNThTTEtvNVp2TURtZjUvQXRiNEp0T2F1aVNBT29IMEovWkpCdDAw?=
 =?utf-8?B?R09VWmNrS3U5YVg5NHhkbyt1QWlSc1ZQZHhtRWtzZ2hDTlJ5Y3M5dVpKZkpk?=
 =?utf-8?B?VGpraWVLMFFJYzNTVDZRWXNaZ3Y5WXlOQTEyM0thalRiU2hxVWsyT0NKZGtE?=
 =?utf-8?B?Y29NMUdWaE0vYXRnZjFvSUhvUFkrUmNZR3hFRGhqdWxVZDJsc0VvNTYyR0hz?=
 =?utf-8?B?NVpoTXRsS2dhM3VDT29kdmxzWndxdkpjYW9LdGRRMm9yb3FHRmFhUXpOTTF3?=
 =?utf-8?B?S1gyYWgxSS9XYVFrSllvRStzeExNc2Y2bnhhd1dSZk5UUk80VmVGbWI4VDFG?=
 =?utf-8?B?amhFMjdXUklFMFF4Y29lMmUrYXFkUUdYVGs5b1pJQ0xTMGpQZG10ZENVRXpH?=
 =?utf-8?B?d3ZpVFhtb3RNdmJvcHRxNjZtZ0JycTExdzRZQU9icEUwbGQ4S01WYm4yUmtw?=
 =?utf-8?B?eGl5TjhUbFhPLzA3KzhybmVnTnJBQlBVY2Mxb3NkSklYRWpxT2RSWUJhTGpl?=
 =?utf-8?B?UEp4UUU1NERrMm5JUy9qRUdCcTlJOXkyVEZiLzRsTjFTZXJRaU9malhZa3BC?=
 =?utf-8?B?VEttdUlac3hDNkR1TVB5Qk5VTzlKUi9tOWpORmJ2bzl0L1JNQlk5b1JXK09I?=
 =?utf-8?B?SEE0cVFITENmOW9IRHhGTVlhU2xTd1JLSGhkN3Rlc1I2RFBUY2tUcnl3VnAv?=
 =?utf-8?B?Y3ZrZVN1emc3bStiYnpaejNVMktPRkZYYWxqbTM0YlFObW82RnlHV1F5Y2Vv?=
 =?utf-8?B?bnhsakxtMXpOOUJOYUJoOEV1SlRXd3h1OUhkSm1ocVlNOUdObUZMZVlsMG9v?=
 =?utf-8?B?Qk9hZlNmM2NiY1A3cjA2ZEk1ZjdlYjZ6bm1oRmR6RFNvblpVTGg2SmpqK2lj?=
 =?utf-8?B?Q2NaR3pxTUxkanVSNVZmSE40NUoxMFdaYmRvZHFaejZmSURxekkwK2ZFTWJt?=
 =?utf-8?B?NzhvcEhYeG1MZDdEWFgvck1TYmdidlpZYkN2YlNodWpGWkFwcUQvTHRHMy9J?=
 =?utf-8?Q?dpN+GFDT83+CBpZAw0X46PeaaQVWcUtASIcI0=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB8033.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SVhHYVMvWFBiNWpTb0hOdXNiRThSeG9zWXZLVEJTWTVSVDkyN0V3K2loMXNM?=
 =?utf-8?B?dnBnS3BOVmI3TDE0N090V05FTmp6R1RFcjZvRzJWWE1iV0NzWUUwTGo0Zkc1?=
 =?utf-8?B?cVpyR2k4SlVZaGg1aTkySDNXdGhoQjU0eXRENFozaW5MR3ZzVmdXa29iUXht?=
 =?utf-8?B?T0psMTdyOVBXNjkxTkNSNXhhTkVBN1N6ZUlBdjRiKzdSNGFsWHBOTGIzM0tq?=
 =?utf-8?B?bnlJYXg2a1l0TTBCRGlKOTBiSkx0RmxUNmxKMkdhRGVyczNBSDVTRXpQTFNz?=
 =?utf-8?B?UWRkRC9RaHlXSnhORE1iaGo3aEZJSzBQRm1kSmppSENvU3l0Mm1Wa1pBWUFH?=
 =?utf-8?B?YVpjb3hvMlp6eWZKUmk4ZTVnSkp0WDdFVHVBZEdWZ1lCdjkyYUdRK0FPQy9q?=
 =?utf-8?B?Q3o0TllqWTZEeFJ4TFJoSGcwNFdoWEdIazhXdFhFeFlxWTBVSmZKQzNwZVRF?=
 =?utf-8?B?M0VuT1FvWkt1dVpEdmpabmJDQ25uRHhMMldaalRTZjRXc0Q0ZWJHblJLc0FC?=
 =?utf-8?B?eXFNdWh4N3pSSXQxVC93WmtkbDJkRHFtdzNlRHVMK0pVemNPWXRRWHFzZk9I?=
 =?utf-8?B?QWJoU2g0TFlQMEdxTWd0dnhZbGtOMEx3dzNLaWFRRTFnMlpmRUo5T0w2bDR1?=
 =?utf-8?B?YVMxeFhOMEZpbzl2dFhkT1Ixejdpb3dneTdPenN4WllaWklSRHJqSWoxeWsv?=
 =?utf-8?B?dUQxdTRNWlRVS09JdTZQV3B3b3FWU25oRFQxdGVSclNSbmVYczZFdE9VcjNm?=
 =?utf-8?B?QmhzKzJ4enU4QTBPUjZKRFl6blhyYytIeVVKVk1MWnJGUENNTXdFbUVybHVx?=
 =?utf-8?B?TkRKL2lJZEx6djM0THlKK1lFN1lhZitaU0VLU2xaS2htVG1PQnV2eGw5TlVn?=
 =?utf-8?B?dUw3OEJidUJLUkh2bVlxM3Z5NjhpOVZlV1cvQU9CZEJaTXUrSjU5aUQxVTln?=
 =?utf-8?B?cnFrd2J4UURRLzQ1dSt5ekY2KzRkVnpRRzVMblBFcmU5a1FmL2MwQ2VYYUg0?=
 =?utf-8?B?WTJ6OUF6NmtFYXoxR2ZmNWI4dXA2VlBJWnVVSWxFc0x1KysyTURjSGNJZWw3?=
 =?utf-8?B?bHdxRVhxc2RpZ05SVUhJMFMzV1pNa043cDJIWFY0Tzd4ejNPNGZiU0gzWHBS?=
 =?utf-8?B?WmMwOWVhWU9adktxMERiODBjMnloajh1MHRyRlB3MDZEd2I0NkUxeTNvT2c4?=
 =?utf-8?B?azBWVVhGZ21IUld4RUVWYW16TWU3Um1rMzE1YVRvUm1xckVVTHBqS0JseFp3?=
 =?utf-8?B?ZGpzWmN6K2R3ZGMrNzl2MDlyTmxoQzNzSzh5N0NtWlpMRWJJYkg3bjVFMjhX?=
 =?utf-8?B?UzN4bVRSTkE0cjlObkQ1SjJtamhDYWZybjUyN0tqNXM1ajBsWm9VK2gwQmpl?=
 =?utf-8?B?N2QySmpzZFplQ1dJaVVMbVFKWkh0UW50dnNzc1pmUUtGUVJiVGx2c0ZMb0Ir?=
 =?utf-8?B?d2JtWmE4dkdJZ3gyZklGU0J2L2dtTy9ocHBHcFcySmxObURNZ2RaakFIOXZJ?=
 =?utf-8?B?ay9tNlNkR00zeVB0NXdJeXNlanBxanFCN1lhVTJXbE5oWjdlcVlHTWpUV3My?=
 =?utf-8?B?NzZTNVRkUG5JWDVOQlZIN2pmV1lBMmdDdlBlNUdzR0lXa3dQOHhNdGViMTlK?=
 =?utf-8?B?c0puWXlGci9iYVBvYUt5VG51Sk1Hc0RvQkt1cThBSEJvSENDMk11K0JEYnU2?=
 =?utf-8?B?aFN1TXdrdlRwRTQyMlJ0dnMwR0pZNmRDUXJESCtZOWZ0RVd5UXA5dUk3OENY?=
 =?utf-8?B?VmtOcVNHaVF0Q3FmSWhxMXZpSXdzN2M1REw1Q1Z3cVg1eGYyMnFkZkZxRHlV?=
 =?utf-8?B?Nm9GaFlkWW8xQ0E3UHpGc1BGaWg0dUgyYWx0MUg1UHVRMEVVS3VVdzIyeVVN?=
 =?utf-8?B?dE4zbENSYUgzREZtblAxaEtVR1BTQm92UU9menEwbHFCNUZnL2VnQWx3TXI4?=
 =?utf-8?B?dVV6UGxKWHlCRHhTYWpyQVBwaWduMWlZSkE2K21qc2IrTWE0NFpaZHV3aG5M?=
 =?utf-8?B?bjd3eDkzd01WWi9UU0l1WUZDOXd1NzllQjRKdkR5aTgrODU1TVJ5ZVB0Mncx?=
 =?utf-8?B?ZWRXOWVyc1l6d0hRWVZ0bG9LRERiejBXckd2QzVibXVUTldDMVQ1ZWFYQ1Fw?=
 =?utf-8?B?NjVTeC95UEMxYitGMGtHUC8vR1FKVE5SUFlWd0o0bzR1cU1tSm55Z2k3U1dp?=
 =?utf-8?B?Y2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7989F0DCC34FC34C8812A7F34DD60521@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB8033.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1ff96c3-136f-439c-3db5-08dc9b0d9014
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jul 2024 03:09:33.3848
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AI5Znm8CAISmlrQmwUUAwXh0BeNeWb+Ni11NGBPX7/LdMWT1mJD1kL5QHRSYoi059yBm7CcSj3X3bW9w0njsjvsv2XzQplJ0dqYehTTFQq4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7269

SGkgT2xla3NpaiwNCk9uIE1vbiwgMjAyNC0wNy0wMSBhdCAxMDo1MyArMDIwMCwgT2xla3NpaiBS
ZW1wZWwgd3JvdGU6DQo+IEVYVEVSTkFMIEVNQUlMOiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3Bl
biBhdHRhY2htZW50cyB1bmxlc3MgeW91DQo+IGtub3cgdGhlIGNvbnRlbnQgaXMgc2FmZQ0KPiAN
Cj4gRnJvbTogTHVjYXMgU3RhY2ggPGwuc3RhY2hAcGVuZ3V0cm9uaXguZGU+DQo+IA0KPiBUaGlz
IGRyaXZlciBkbyBub3Qgc3VwcG9ydCBpbi1iYW5kIG1vZGUgYW5kIGluIGNhc2Ugb2YgQ1BVPC0+
U3dpdGNoDQo+IGxpbmssIHRoaXMgbW9kZSBpcyBub3Qgd29ya2luZyBhbnkgd2F5LiBTbywgZGlz
YWJsZSBpdCBvdGhlcndpc2UNCj4gaW5ncmVzcw0KPiBwYXRoIG9mIHRoZSBzd2l0Y2ggTUFDIHdp
bGwgc3RheSBkaXNhYmxlZC4NCj4gDQo+IE5vdGU6IGxhbjkzNzIgbWFudWFsIGRvIG5vdCBkb2N1
bWVudCAweE4zMDEgQklUKDIpIGZvciB0aGUgUkdNSUkgbW9kZQ0KPiBhbmQgcmVjb21tZW5kWzFd
IHRvIGRpc2FibGUgaW4tYmFuZCBsaW5rIHN0YXR1cyB1cGRhdGUgZm9yIHRoZSBSR01JSQ0KPiBS
WA0KPiBwYXRoIGJ5IGNsZWFyaW5nIDB4TjMwMiBCSVQoMCkuDQo+ICBCdXQsIDB4TjMwMSBCSVQo
Mikgc2VlbXMgdG8gd29yayB0b28sIHNvDQo+IGtlZXAgaXQgdW5pZmllZCB3aXRoIG90aGVyIEtT
WiBzd2l0Y2hlcy4NCj4gDQo+IFsxXSANCj4gaHR0cHM6Ly9taWNyb2NoaXAubXkuc2l0ZS5jb20v
cy9hcnRpY2xlL0xBTjkzN1gtVGhlLXJlcXVpcmVkLWNvbmZpZ3VyYXRpb24tZm9yLXRoZS1leHRl
cm5hbC1NQUMtcG9ydC10by1vcGVyYXRlLWF0LVJHTUlJLXRvLVJHTUlJLTFHYnBzLWxpbmstc3Bl
ZWQNCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEx1Y2FzIFN0YWNoIDxsLnN0YWNoQHBlbmd1dHJvbml4
LmRlPg0KPiBTaWduZWQtb2ZmLWJ5OiBPbGVrc2lqIFJlbXBlbCA8by5yZW1wZWxAcGVuZ3V0cm9u
aXguZGU+DQoNCkJ1dCBJZiB5b3Ugd2FudCBJQlMgdG8gYmUgZW5hYmxlZCwgdGhlbiB3ZSBuZWVk
IHRvIHNldCBib3RoIHRoZSBiaXQNCjB4TjMwMSBCSVQoMikgYW5kIDB4TjMwMiBCSVQoMCkuDQoN
CkFja2VkLWJ5OiBBcnVuIFJhbWFkb3NzIDxhcnVuLnJhbWFkb3NzQG1pY3JvY2hpcC5jb20+DQoN
Cg==

