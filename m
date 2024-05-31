Return-Path: <netdev+bounces-99827-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C90A8D69AF
	for <lists+netdev@lfdr.de>; Fri, 31 May 2024 21:21:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6DD84B25B12
	for <lists+netdev@lfdr.de>; Fri, 31 May 2024 19:21:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12EE8158D78;
	Fri, 31 May 2024 19:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="1Pfy8pxh";
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="NCBhL5np"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E5A51C6AE;
	Fri, 31 May 2024 19:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.153.233
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717183217; cv=fail; b=iB3MVSNnft24v3X747pEu9MBAWTNXuXYw42TMP5C8wsSKGCAp4W39s7vr4ooT2DKaxjWdQ6kaol/VI2SMU4SniM8Ha3gOPRIzc9SBKry9TwbogF1yeO0lFQ+jHQY6Mmm0yspEusssaM0WVwwMwAPaDgb/IfcZx+qJnMRm48sYOI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717183217; c=relaxed/simple;
	bh=wM6TPpzrUIjoHlP/oM/iqoUVgEXY97B3T+WPOGVzW5U=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hVYR9yZKlJbR3xGmIGzOf7c0NnbW40g//C0BdqkjxRLdXWd/3fdSAifn2nI+/PkO5/PDzQ77SzAXhwsbmHT9EBh7bZehU+mtc0gHyhqH2F0tfi+VF9HV1dNQysrjL2QdELl1ndixnaCVvQa8sDBe1J6KIuua1wz8OZqxozoMKsQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=1Pfy8pxh; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=NCBhL5np; arc=fail smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1717183215; x=1748719215;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=wM6TPpzrUIjoHlP/oM/iqoUVgEXY97B3T+WPOGVzW5U=;
  b=1Pfy8pxhkSbdIrpYU5zWWwalvRDvBoMAKWz3K+4NkUHxGjG5HIpi0vvK
   RXyc2iC1elq0xniOXmHa3BKOti6CLh3Hoz4OxTbVi8vGwv3Q9vPbeOWFG
   OsTpcFm3TkRHG2aoJ5RP9tLwlUNyuFOyR9kCrBACsYjHb03yNAlQJd9cs
   BenvC1YRRJpIYIbCogfgGEVYPHkKpavjf6uJTfAeioQ/QxSk4V6xBtpJ5
   J7xSrCU1NZJvHrnInsnWZF6sYEWgi5o43TJC5+7+16+u2T3vgyHay/7HE
   jSedn5jKAji/NTfTJwRhAtTaBHCE8QENVX4Yy4khLMcABa1q76gCNX4J/
   w==;
X-CSE-ConnectionGUID: pK9F25mGTS+qhWquMxr5BA==
X-CSE-MsgGUID: m2Ak2HaGTh6km1NjGkLuCg==
X-IronPort-AV: E=Sophos;i="6.08,205,1712646000"; 
   d="scan'208";a="257662503"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 31 May 2024 12:20:13 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 31 May 2024 12:19:56 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (10.10.215.250)
 by email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 31 May 2024 12:19:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=avVlY5oK+l360EMR5oeYi06rieWVybqirWG1x1EDAd3/YwNzH+Q3r/1P9RoAzl3nwFNbsLAvKgIXPkKLqFBFvGJDn+n+80iFGS6ZIPrgzKggtdCW2DY9ZRNBqyGU3+NkltxJFH29Go3mrNSvj7UmViVca/LH68HJqZq6Tn6y6AcE1odCx/H6w94sbQ1QRTtkh68moAXEAHODxYNzylBJuVlDlEqrGNBlN3r5FsMU+cDXVI2RhK0g+90ZNY0c6oXTbzU6hwAblWF3Cr1BixCwjmthO7H1pqa3sLk+VcTlMHLEDA1j7ab32Y3BkL2M0gBYKWlw8YJvfxLCKg7HisJeUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gDVG0UKdfKO2B9RwxSFQgrIAJFXYALejpLlMVVqHVjE=;
 b=SIt2EBQFvySNC3V2vm39N+dAB+44JLb7NlvE5tzbcATiiRpSbfJh5CnpdhDsKY1zhp5FWeq7KFdfB1pfI8ehW7cyV5NTUlWsK7zK5ml0wB+lX885CY6sYN1rGdJQZTt6x230oobjHLbyZ6+b/e7uC2+Q2yrWT3hha6WP/cZuZe+NIwdhfmS5ydkwC0dDsf6Doa6Um/u5NCEeAS1woKXAYds/IyQYrpMI2ELSl4WtExJEq+/P8lWwtNLrQagfQrYzsdcCicQ9LH1MhvolGIAG1Y8dgC6Am+uXzkBiskyG+DkGxUVUaZY59S59W37Kai9rbx95F/gWZBHaK0oNbuEH/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gDVG0UKdfKO2B9RwxSFQgrIAJFXYALejpLlMVVqHVjE=;
 b=NCBhL5np5UPiFOOBHICawxwYA+YjIIQ9RGcDfcx1PgkKpnUf2qT1Pw20KI3DzpoYm/omXkFiPjy635qTvpPkEtAbdegm/cHOH3CL3tJG8xnu0AUDftTIKYddZbR1dY2VLf3i2vyDXQDNRNXzvA2j3+xGi5dXz9DjiKwCk0+cctyJgZG/A76i210s73raATTuq3TFpjpN1/LguoM3oFFgrlLL/CyyzY/PNzKkXpU02K8h3y9X5Z34KDIzvhrpoyi6ieqdX5jfyFw+izDYTLGxOZ8NKMQNVvnamz/ja2xm7h29MElUSkVwFlnQkHyVhMi2iT3BdnSG4BILKiYGJH43KA==
Received: from BYAPR11MB3558.namprd11.prod.outlook.com (2603:10b6:a03:b3::11)
 by SJ2PR11MB8515.namprd11.prod.outlook.com (2603:10b6:a03:568::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.30; Fri, 31 May
 2024 19:19:55 +0000
Received: from BYAPR11MB3558.namprd11.prod.outlook.com
 ([fe80::c03a:b12:f801:d3f6]) by BYAPR11MB3558.namprd11.prod.outlook.com
 ([fe80::c03a:b12:f801:d3f6%6]) with mapi id 15.20.7611.025; Fri, 31 May 2024
 19:19:54 +0000
From: <Tristram.Ha@microchip.com>
To: <horms@kernel.org>
CC: <Woojung.Huh@microchip.com>, <andrew@lunn.ch>, <vivien.didelot@gmail.com>,
	<f.fainelli@gmail.com>, <olteanv@gmail.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<UNGLinuxDriver@microchip.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH net] net: dsa: microchip: fix initial port flush problem
Thread-Topic: [PATCH net] net: dsa: microchip: fix initial port flush problem
Thread-Index: AQHasUaa3Zq2wVoFDEumZ+nfFFvgXbGxt6MAgAADn3A=
Date: Fri, 31 May 2024 19:19:54 +0000
Message-ID: <BYAPR11MB35583B3BA16BFB2F78615DBBECFC2@BYAPR11MB3558.namprd11.prod.outlook.com>
References: <1716932145-3486-1-git-send-email-Tristram.Ha@microchip.com>
 <20240531190234.GT491852@kernel.org>
In-Reply-To: <20240531190234.GT491852@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR11MB3558:EE_|SJ2PR11MB8515:EE_
x-ms-office365-filtering-correlation-id: 7b42d3e2-6bc5-40a6-55fa-08dc81a6a72f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|7416005|1800799015|376005|366007|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?uyLAnKVVSbtieVsxdTy7HLtHjlUpFkY/XP/MwcdYY0eunjbnNJIEtFjXPQm6?=
 =?us-ascii?Q?TBb8soD/c+Pc8GopzMiBQcvhV1l2k9N0lLno5ktci2znjLQnNVucXS+wMu8/?=
 =?us-ascii?Q?HwMd/g0vlPYqk0bcFVbOQ/fItPm24zoRNdU8iePvCq9pgUl0nEFsoF8Y+Fib?=
 =?us-ascii?Q?QpyCqXkpcFTxgTpQnfhaRMjHllXCuk/1gU1szDk6TrYkvLvbqjdK7krOrFvu?=
 =?us-ascii?Q?/PwnckH76fbm2WDmKzyD3M7SQ3faYArtO+uZAaIVA11yoVUMSU/tVl6NnOOq?=
 =?us-ascii?Q?f4swiGLka3vypaGiznUBiOZDJqXLKsfHII6/yJu1AZk2MRgBlyotWc6RGaKb?=
 =?us-ascii?Q?XBFvxxq15295PlH92v5ourx996v+2qm1JlKBQYEfKrTszltsEvT4EdHobefz?=
 =?us-ascii?Q?b3ou5dljeD8xyQeLmjdKOY5L2s1MKorKbBOhidxUJi2OeaIxoPglfXxg7pd9?=
 =?us-ascii?Q?Xhnzplhtx/2GfKsGIEN7NdW5owJhGzZZlRRVr6q8bghTl0J9UZxyJvJhpWvW?=
 =?us-ascii?Q?AlcRJGADabuvRo48K6OCa0AUzlRYFfHWpDVZwO4LenrZbJh3Jr/NZAn+SJvH?=
 =?us-ascii?Q?2USUVFdBlfKZd3pZye0Ni5iFxKDCh3ThTyq1gfb/CM902TQKoTQmDh0Ci0tO?=
 =?us-ascii?Q?yphoOcisizBYOwhRHFcV1MlhNoeY0/w5rFdZTw8tiJWvyWjzBnfInr7R2kSp?=
 =?us-ascii?Q?OBclO5cnQD0s3ilvBJCMchPttPcX+0wa5ejbmCrx14oL2Hm5quN+zjYcP3Jg?=
 =?us-ascii?Q?48de/mgEdY+TzgHymN1sjTpmccD7sLt4QQcBfQvxIEZNWM4dOpbhC2bW2mwG?=
 =?us-ascii?Q?xfn1VK1FiLUiis74tatcpRV3DsmfPUuezBO7FNKBu6crRU6036Iolr11e76C?=
 =?us-ascii?Q?YPd4VUAUq3QUW4Jq9jFD26BoMv6pvUEy+lpHJsqtpbpipH/Wt+Ll1CmSbbN8?=
 =?us-ascii?Q?zNPE9di7ATA+/aaUwy57QrPVj2Xo7L/6R4hGjQyJgkxhFkiNnkg/8vYYZ0jf?=
 =?us-ascii?Q?pBnhUu/+ujWOIOGL0bIermL/mIylqbXD+vcl96Wtpc6Qo+e6EcGYdfvCebhk?=
 =?us-ascii?Q?eebs20J2WaGw0gAvdqHB+afGMx+o3WCZegyx0QeI7KupsGfXhx+/QNi19swm?=
 =?us-ascii?Q?o5TZzlkXbGtAx8APxxoWwA7p4H7husZ4dLyrfIkXA9Nn1o57aoDnwy9uj2Sd?=
 =?us-ascii?Q?PfBtNFBWRV2W4QRHZeeowpgGCUqUzsQmwhsCp7sSxpxkIeJtUsK7mXXbArAS?=
 =?us-ascii?Q?wXAXVu1ALfK+CwRajcCcxjdx48ThPnydCR1uaAeOGCuO16MZRAwJ/OHNHKB0?=
 =?us-ascii?Q?uq5vjkufZWpF82zZQ8ZVIevhhG4amtJ4mDtYm50A0CYOwQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3558.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(376005)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?19OtagTYn5FLO9IKwv9U83RbNQYSvSCX0A8L0MlyMGoSSRRahDGthOjM3izv?=
 =?us-ascii?Q?EiLftPA0DTUYqKybv2xpK9+KE5EFi1mj75Wsb5U+NDFT322qZynORN9Jr3wW?=
 =?us-ascii?Q?cOVx+SdcuIXaqSX5kkamMyHuFalEKhmyEbCsIr7M8v3Cx9umI6/YVaTd09u2?=
 =?us-ascii?Q?J5b2BWoqCRL+62IRJtHnjZpOcsu37cOaudRFUfNVSmHlHdRpxRIZkbXujucW?=
 =?us-ascii?Q?nK3xZ1z1zxEqn3eNxeCq7dLcsqKDjuioERlMHqjxgcNWPJXMVGm+TfxCnjGQ?=
 =?us-ascii?Q?95PHjhuNwLRC4fsBYZ5hwsJCymAQ0XhL+i/rrq8fTbivST/kaUqSB3i7Nivx?=
 =?us-ascii?Q?MiH6Y1SJ1BmEXBeCoWnGyKYV2RM+G9QN4DZiQPCsZozGLNGvegcy0yVVMB71?=
 =?us-ascii?Q?Cp6ySNIjBkHGHJrxcXGBJS4IluLF7Q3lBdLJLNoy8PXm0/BGWO055kFyBijl?=
 =?us-ascii?Q?+aiZ/fNMDQ0mW2Oj5fJDVuHqKYr6iV+f/4RiP75KOM/sC0XcNauPcPxZpsY8?=
 =?us-ascii?Q?H+MFnXoRtqC00lijKn+um+N/8qRj8asqdDgM7q6QJTEiEtrVZ4tUCNAhIhVN?=
 =?us-ascii?Q?SgMEEL63RkpV/46blzTaSKvFWm2nWqFMAIewOR47kjXrD8j0t5I+cYzcgkGX?=
 =?us-ascii?Q?tee6zb11xV74dVhSBuqHTLQGXvL4D/bosUSLcwNp/d/3cgBSxtTB+sEtEunm?=
 =?us-ascii?Q?8zgdM8gry977MdgOgHlIa/u++ZX0hBlvG0dcQtPAr61KzSDhfCklHjIX6Nis?=
 =?us-ascii?Q?mABiB0FkYNsxXwV+f0mkFWlDjzSKbDB2U7z4UbYxaJbCQdHTzSW1H8J14W7x?=
 =?us-ascii?Q?2Uhzjkcal2eZDZ6fiLPzPbkdU6WyXV5Mnhg9vsjA4GubQB2VlDDnUZc08pKE?=
 =?us-ascii?Q?Fh5U4goKlDzV5p3a9/MCMH3AXmJ/dSpThIV2J3oWnmaio2wfCUGi8J+OtXz+?=
 =?us-ascii?Q?aid1Ty9PxcGhSpkNJmwjQQFZ+bSmQRDmUqEPVvUGQ0GDZYph8SXjtRMBIRhk?=
 =?us-ascii?Q?FuIHGD2c1qtWxsBVITT1nXuL53UsEWg4Q3MA3HBqorCURT7CC8hmY9tHTmgr?=
 =?us-ascii?Q?Qsw800WabO2ivYz+s3zNiLbU8kEpWyO5Dhd47wASk9H0xzRVKE8A7qAGU3FB?=
 =?us-ascii?Q?W9AOcsNepFLZilfV4xkQxAxcqC4KKUrHn/9JM8cWdh3u4kHZCdrb1cedqDbs?=
 =?us-ascii?Q?CiYeCaYCei4BU4sgYS5vTjTg5l/HMacFFURgnEnnerDDDItxQjtMN4xRWyFL?=
 =?us-ascii?Q?h90wHyhSf2t6GAh2P+cQS+mv91SNuBwkb6iPDutwOm/cI55CbElLoBQ0D/Vp?=
 =?us-ascii?Q?K6LN36HyhM+qkqojROEoSFJVHA+LMp8TwuM1ZyH/QI+9kTqae6dfmaUOrZ0S?=
 =?us-ascii?Q?aCMWZIE4MU5WMlfQUY6Th6b7frplHVXFRroeM5+FUMj8WkNcuKN0DWx3ZeII?=
 =?us-ascii?Q?Jc7X8IrmCSeTFHhukM7FfuCoj9pcy9u/AF1NgwT82F3rhExTslPXHdzB32vh?=
 =?us-ascii?Q?qLA67UJuRNanSqpLMOu50DdGTO91YAO8AwJNMesEXQdNFOFv+fsRjbnacwRo?=
 =?us-ascii?Q?r3WcJxQ2NPrQGQ0+nO9LFIR8q168zR/1vJK2tsf5?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3558.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b42d3e2-6bc5-40a6-55fa-08dc81a6a72f
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 May 2024 19:19:54.8756
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dT2QDnwJk8qhNcW6pR2Yi9BwcBoAwqU/QA28pwvOk8b1bm0DHwhwtXZL8mSAJEZ3J1PpDfIgbDJfR3rw5RjeRD7rezJJttnH0ZXX9BCOHlU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8515

> Subject: Re: [PATCH net] net: dsa: microchip: fix initial port flush prob=
lem
>=20
> EXTERNAL EMAIL: Do not click links or open attachments unless you know th=
e content
> is safe
>=20
> On Tue, May 28, 2024 at 02:35:45PM -0700, Tristram.Ha@microchip.com wrote=
:
> > From: Tristram Ha <tristram.ha@microchip.com>
> >
> > The very first flush in any port will flush all learned addresses in al=
l
> > ports.  This can be observed by unplugging a cable from one port while
> > additional ports are connected and dumping the fdb entries.
> >
> > This problem is caused by the initially wrong value programmed to the
> > register.  After the first flush the value is reset back to the normal =
so
> > the next port flush will not cause such problem again.
>=20
> Hi Tristram,
>=20
> I think it would be worth spelling out why it is correct to:
> 1. Not set SW_FLUSH_STP_TABLE or SW_FLUSH_MSTP_TABLE; and
> 2. Preserve the value of the other bits of REG_SW_LUE_CTRL_1

Setting SW_FLUSH_STP_TABLE and SW_FLUSH_MSTP_TABLE bits are wrong as they
are action bits.  The bit should be set only when doing an action like
flushing.

> >
> > Fixes: b987e98e50ab ("dsa: add DSA switch driver for Microchip KSZ9477"=
)
> > Signed-off-by: Tristram Ha <tristram.ha@microchip.com>
> > ---
> >  drivers/net/dsa/microchip/ksz9477.c | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> >
> > diff --git a/drivers/net/dsa/microchip/ksz9477.c
> b/drivers/net/dsa/microchip/ksz9477.c
> > index f8ad7833f5d9..7cc92b90ffea 100644
> > --- a/drivers/net/dsa/microchip/ksz9477.c
> > +++ b/drivers/net/dsa/microchip/ksz9477.c
> > @@ -356,8 +356,7 @@ int ksz9477_reset_switch(struct ksz_device *dev)
> >
> >       /* default configuration */
> >       ksz_read8(dev, REG_SW_LUE_CTRL_1, &data8);
> > -     data8 =3D SW_AGING_ENABLE | SW_LINK_AUTO_AGING |
> > -           SW_SRC_ADDR_FILTER | SW_FLUSH_STP_TABLE | SW_FLUSH_MSTP_TAB=
LE;
> > +     data8 |=3D SW_AGING_ENABLE | SW_LINK_AUTO_AGING |
> SW_SRC_ADDR_FILTER;
> >       ksz_write8(dev, REG_SW_LUE_CTRL_1, data8);
> >
> >       /* disable interrupts */
> > --
> > 2.34.1
> >
> >

