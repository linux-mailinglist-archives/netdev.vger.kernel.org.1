Return-Path: <netdev+bounces-94592-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5499B8BFF13
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 15:43:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D63241F27F62
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 13:43:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA0D985C65;
	Wed,  8 May 2024 13:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="oBfbulLh";
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="Gn1bqbQc"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD28284E0F;
	Wed,  8 May 2024 13:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.154.123
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715175719; cv=fail; b=NmrocTQmQZbJY/8ugeudXfbeYzndevTjvD5q7h9K5UzTm6FyuuEPsMDd3AyfgjZb+x0yOirBaC4r/QoQsgl8OYBV+mlgcCe8gkH9ex/FCoHI8QCbh9CKxm1fotdFjlmV9YQAjR7yiNnsiB0v5kAxjoquwQhW89H/a9Pi1UVHfUc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715175719; c=relaxed/simple;
	bh=V1pl2R5HIU9noxzl55tg/ezjkJ7c7Eg9C2GXe8SYB1I=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=kDoy7jCt1XYmWfItMQ8+Yr31ODB1ssPw8aBCpT19NFUQLnguKyNg46otLIxPHsSN3WB22+qJJqyEiXiXp/vDd3sRSk+mLaNJf/zOgaS2xLh77RvvXpEOiLjR9S6czxSCsKsh0GgZLotbvQttsD16hDm8WtguTVoPfY5ntO/FT/Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=oBfbulLh; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=Gn1bqbQc; arc=fail smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1715175717; x=1746711717;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=V1pl2R5HIU9noxzl55tg/ezjkJ7c7Eg9C2GXe8SYB1I=;
  b=oBfbulLhSluNeO5VHM7sGru458z/VA4cEJpSSaX0yduTu23+FuWmlkwi
   ZlW075zgBpPKero+QyX+0s+2enIoMrZ0qb36DtdQ02lKSWymLA+H7F7ec
   Z/wb2ylLxlT7vWzjbqnKUOaQZ5QGrogZqEkQLQ434PRvWQ88q3hPy5z8o
   pCf8K8o3gGN7vFFQQNetcyR6Yy2wBCFj+X/FQ+xF01qjfr/hbVqyp+qQt
   n8TMqdW1lakpGBwBe+3FJXnoNLUrV8Hl4Dk9Tk2MTHxNLqntIYAoxuyxz
   HbnYFHPP2rNUdi9ba8rZmFt0p2p1OvLQOK+wlbWuAP8a2Pxf+OLohbIg0
   g==;
X-CSE-ConnectionGUID: WIAKeA70T9e5O6NYhgdbjw==
X-CSE-MsgGUID: akh6ZRLpSHeUC6H31PeWBw==
X-IronPort-AV: E=Sophos;i="6.08,145,1712646000"; 
   d="scan'208";a="24716593"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 08 May 2024 06:41:56 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 8 May 2024 06:41:50 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (10.10.215.250)
 by email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 8 May 2024 06:41:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a71ecJI5/mhjhO/TFANtMi0cFx4gjChxvERZpx6tgsVrG06qdIX9/y2EwID1kwtI7CY92Jpgq+Ju+CFgJawkfqx/WlFcdwlripw64cYv9mxk8Pdp5PZRntqJrP8WtwNbBRD0EcPrKfxv2T9+L7TcW167ykNim76pFfEwjZINEs+QROQaQeChj9xgeSPiISs4UwT1W7y2mFQc3W94/jn9jaxMcTLH3jr59XfrEfk1Nm8/FbgiALihJXMkzmumno1Mlr8asNF7BeGhyUphVxHvUR7ee1TbCpvZ3+j4+4+rCl+agOcZKnoBB27erNXWDl1M8u5837BE7/EQGHBB9zKNYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tLTmB5v+V9pq0Hys/wEC7qFaIdmIcxmKlh16FC3Kj3g=;
 b=W/2aQBTXksme1pBnxwSNAHu0xcCuY29pDRZGupDtmeEowA9xWYDebCXYypUp99Sm1euV62NHHwVJVvaM370ZBw8FrqSssa6nIDrx1qJm/J0/MWnuXfxN1W+GnSrDU/22zj9q5lD3oNxAbWHAuCsVcs5Nb0cEPsbrccY5x+Zyux/TTWH4ogSvbaCG1HNntRE9vGXshxUwMiKZGidmrm28kdP1N3oJlAr7tqGG8PDFT94i3AbAIhp1NXJhals73x/tXEa1GZskte2zjgy1FTjXuW0scFFT8fllIcWZjBbtCLVEfTlLjLU0cP7SxN7XkmPxarfDapLl+P2DibDTdx1giA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tLTmB5v+V9pq0Hys/wEC7qFaIdmIcxmKlh16FC3Kj3g=;
 b=Gn1bqbQcSAMZeAAtLGVjnPOUpnEqLxIVQb2ssOHsOCwyBoReJbH4mu2uWgRHltM/YFVWnq0ikPaGHE7MMLrP+YC4qTdIyRnBX9FMSkAJxzKJ61lWSBv0tdLZbmSNzKVJ38ZdoMz9qfi70/98jFbzIkxi0qgvgAWdAbb7L8mXl6aq7gg948D9sGq1GoRqsZn9pAgJv+CaA4wnL7CTLZoicvypGRT83aov5+4pX7pev1y1P6mdCpLg/BZgyn5BeLSye+xOgIyTzPaxpP05TH+f0pnlqPnzzEz1wbwQaQlputxyaKcDf0PQ2xcrZnuOWN0Cj4oIqxz9teiK9JyQ6CBcWQ==
Received: from BL0PR11MB2913.namprd11.prod.outlook.com (2603:10b6:208:79::29)
 by PH8PR11MB8105.namprd11.prod.outlook.com (2603:10b6:510:254::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.41; Wed, 8 May
 2024 13:41:48 +0000
Received: from BL0PR11MB2913.namprd11.prod.outlook.com
 ([fe80::3bc1:80d8:bfa5:e742]) by BL0PR11MB2913.namprd11.prod.outlook.com
 ([fe80::3bc1:80d8:bfa5:e742%6]) with mapi id 15.20.7544.041; Wed, 8 May 2024
 13:41:48 +0000
From: <Woojung.Huh@microchip.com>
To: <o.rempel@pengutronix.de>, <davem@davemloft.net>, <andrew@lunn.ch>,
	<edumazet@google.com>, <f.fainelli@gmail.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <olteanv@gmail.com>, <Arun.Ramadoss@microchip.com>
CC: <kernel@pengutronix.de>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>, <UNGLinuxDriver@microchip.com>,
	<dsahern@kernel.org>, <horms@kernel.org>, <willemb@google.com>, <san@skov.dk>
Subject: RE: [PATCH net-next v1 2/3] net: dsa: microchip: dcb: rename IPV to
 IPM
Thread-Topic: [PATCH net-next v1 2/3] net: dsa: microchip: dcb: rename IPV to
 IPM
Thread-Index: AQHaoTQfG0BpAGYhr0agOcuX46Zh2bGNV6gQ
Date: Wed, 8 May 2024 13:41:47 +0000
Message-ID: <BL0PR11MB291304A2A9E43E7B7A533EE4E7E52@BL0PR11MB2913.namprd11.prod.outlook.com>
References: <20240508103902.4134098-1-o.rempel@pengutronix.de>
 <20240508103902.4134098-3-o.rempel@pengutronix.de>
In-Reply-To: <20240508103902.4134098-3-o.rempel@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL0PR11MB2913:EE_|PH8PR11MB8105:EE_
x-ms-office365-filtering-correlation-id: 53e3dbe1-c9d8-4c3e-a47b-08dc6f649bbb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|376005|1800799015|7416005|366007|38070700009;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?211lP3VwAx+/DAn59iAZiY/RfvvsF3nceCo1fOCdinTuyjTaCC7JApasJM?=
 =?iso-8859-1?Q?VJAZeIWtX8FI2kR/6DN29ww/k0SeCo0MvobMlVqyh+xpIK1FpqPHeD+9yJ?=
 =?iso-8859-1?Q?CHM+uhR32Y0zV/X5b6snjY6NNPrbma7j6OPOwYJO3bCvdAHQZr+9kXcpcL?=
 =?iso-8859-1?Q?h/0e7MVXJo8rYvJZujGsWPwdliUHGvAMy1BNBr8W6gbXGRuWa8hMwVKF0C?=
 =?iso-8859-1?Q?24Cmdm0GVhkflD8hDrAF+bVC+CS6Yrz6PJ0Z0R4vIwJrx3bx/NAP2UFahH?=
 =?iso-8859-1?Q?JjXsJII54Tz88njsoSGKG0nyhLyUmM64ekTwdDFVy3MTTppv6b2hdloo3L?=
 =?iso-8859-1?Q?hAJTKcEqCcRI5MDD0zq5L4yOEYCJU9C4xXtMi0MtkDr1aHkM5T1dce/EcH?=
 =?iso-8859-1?Q?t7NSfbFzx31hijCOuPYVUE7i2Q+1rkYI2IfVFHc6osEpHJ7F/BW9OEGj2t?=
 =?iso-8859-1?Q?L96FfqktbRCn634Bnje2zBNgeU1LleZssni1tvHDe5CB/avHBeHrgy4Npc?=
 =?iso-8859-1?Q?QAHuhoJDhuc3b/9tBL8BigbYL9HN4Pwj936Sb/p2xpXP24KqcJGoHQCnpb?=
 =?iso-8859-1?Q?MPQDqPbzAVX55u5A/5wea9zQ5sn3V1c6KElTvjHWsJmReKI6MX5TqE3CtU?=
 =?iso-8859-1?Q?ZTj/NlYI/KZ/AhA24xueOaeiju8/Bfi99JYkfIvPhpFVSSUTNxD6VGvel4?=
 =?iso-8859-1?Q?nxQZD4uIntKrhxP9/AF4+3zDcRpZRRp8bPh6KolJL3m15I63JvQTnPPLvw?=
 =?iso-8859-1?Q?UTKgtSvXjrDMHZrkQTwelFCyRl6OzijzwwQn3mSUgL12N1Qslm/wv/Ah0r?=
 =?iso-8859-1?Q?vzbrsDdlFi6C0rOKk8Xkbclj6JJDtzaqwc/XA8QdAY9Dwk+N88Acaf+uq1?=
 =?iso-8859-1?Q?5bJn1koSPYPU0PdESc56YOlk1edQlxwSxc/Y20AXE/wN3/n6beYhVQSuil?=
 =?iso-8859-1?Q?jm+8tCy4H5ZupIzehC7Iw+F7lRkDG8jbVOchns0o3crEhbPh9d+rMQdJRx?=
 =?iso-8859-1?Q?pkosHdVRyY/RfSNWuoF4F0l4g4RoM2Sp555qNNestWWa1c4OiRqHlOITLq?=
 =?iso-8859-1?Q?FORTn4s+JfqAocNHcMcaDxsLY47JhfwYMoG/63x99KmrRoRWmoB0LQnP8T?=
 =?iso-8859-1?Q?HITkagNoswdf9ueGVOmm6N9y651vixjvvTH5qGzLapWXPZiMFziAAhCXC5?=
 =?iso-8859-1?Q?GBfQsGWQrQgYUnpw60RIMxKRvtCsYNBEEa3PFvVKTP0L/vR/MgLd054oKp?=
 =?iso-8859-1?Q?/HyFj/7rIS3YZCydeGSL6OhPVJuLH0dyM4KhZgE+0I8TyOxHneaf8PeSkP?=
 =?iso-8859-1?Q?dniMKO5MAG246AylajGXvrmLCcQlGVs5XZovurvBjtkGD0kMUmKm6aqht3?=
 =?iso-8859-1?Q?VsOTRSrxZYmBjq+/YrpbxK+nRnH1ymiQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR11MB2913.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(7416005)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?PDovO3he3WSPC2E3DP5wyJ5+y+EjFBaW/i35fCUXYR0zCGWm6ZqpB390wo?=
 =?iso-8859-1?Q?67psPWOAizvQu3XT3ses3oQAIsKD3NYVmPYwsiqP2tJEuYHYFvVH2lNPtt?=
 =?iso-8859-1?Q?ZcybhebPZfkL+W52AJwgy2o6cVzQBOY1yv1luZ/2Rr2X1XRPXhbtpDaeBH?=
 =?iso-8859-1?Q?7C5zl9cibByzCsvjmoW1Kcoa5r2CrGX6GC6YUiyBBHzJpnvBWwLaNPcLF/?=
 =?iso-8859-1?Q?r3VTF2VN+U3+Wn/QUwgWQrt9E98t25qdjqYqnND6fkZbnfMy8I+3NWEWzY?=
 =?iso-8859-1?Q?uioFKR6z2DBV5zsD9tr1d8nL1Nc/LcYJBeu1QHbXKlxZgFeGJ+ayHqOh/U?=
 =?iso-8859-1?Q?nijqIzQo5MyZ65fPdcVieNhbkYBQ40Vd26i8J6lMY6qlMmaIosfbCZyCHb?=
 =?iso-8859-1?Q?5W0hkSUfrYRhM/9yibpncmzaCvISAGe2CMKgbqHr8ojtFZF/ZL6Q+sZnq+?=
 =?iso-8859-1?Q?HN6VZ3vN48AUrF+lykwdORjlYb4eKl61LQkNPyLe4ivmvTdE4pJk+p40am?=
 =?iso-8859-1?Q?PXtBkrPhZyM1Vdk6sDzaY58zI5W0UUQnUnN0RQh1V3Bf9VyoBwg0UYLIMH?=
 =?iso-8859-1?Q?VPswuea88NJL2kR/LwwPAB9+iIdOE3KxUYb9MNuh+b1Xs9jYtb3ewKMiQh?=
 =?iso-8859-1?Q?qoU/wttCpjL46DHm5mSyDaLffh9NhBsRD0ZLtoSQ4Bd+LsLStFtZLCVOM9?=
 =?iso-8859-1?Q?lvUP5FfkjdlOZpMTVGB1FbYX+VDC06vJSyfGGzaMov6sRITk8mGbcbke+x?=
 =?iso-8859-1?Q?vt+/NeR04vKHWcDhakIIi64HKmHSFXnbyHD7q1sFpuER8keKszSzecA+n8?=
 =?iso-8859-1?Q?idfJmBkiamlGnzXs9NKXL5KfOsrTNtYjyoIpYhxWrEGYABDp5A4/n55EXM?=
 =?iso-8859-1?Q?lmGmEofqkEmnBeKBJd95nqkWXetznEDzYP56FsvDulwqVOns0olQ5IaCyz?=
 =?iso-8859-1?Q?M3I0bJrTgxIHKrFNm5wmMt8Zl0/YuOwIJZ+bX9Hrrld7kTs1LOE/3mJ/l1?=
 =?iso-8859-1?Q?7zC8bwVE2q1KkHlFtuScS6DAOHOyT3SX2CJeNwucavhbxrynaQrJmZm2JV?=
 =?iso-8859-1?Q?LO9u7bwYgkJXdo4/wi69Mz9KFGwWGBkdZp9Mdt5fwqpIhSGGoy7ngeILRi?=
 =?iso-8859-1?Q?auO8EkUxuQ4RcjcsGnVkrCTDaA3p7QjU5OmXNxa1uf2zlgJZb7D4YIfdB0?=
 =?iso-8859-1?Q?yM5kYVg6frtZrOv11Q7nP915BY8F72UTJ/LU7DnmUo29nmooyJ9/dUC9B8?=
 =?iso-8859-1?Q?ejr47no9obIQUsYF4L4Ld4ClEQCd4L0cEwKWlxBudUkBvFSZi06imBgDPH?=
 =?iso-8859-1?Q?UoCZGS8iqN8qhgcno4Tfj04DjcFtzieEvUtfOfbAGzD0dnq/MFMSgH+o4V?=
 =?iso-8859-1?Q?1wS6ANnX57wklJtzEfWgRgigEaLPIW2hJ4cc9jGv0aGPXsTZEYlEeshpEA?=
 =?iso-8859-1?Q?vc+BXGv1G/I8pzbmqmguQ4h1eiMGeGSnCnGFODRvsiH/MoAbBLhOZKxp2f?=
 =?iso-8859-1?Q?7NQNu6KiYwoOG8ffUYMeGzp5SYDHJ3S3uZBsf2RtSU1CuEfrpHKRQzM6OS?=
 =?iso-8859-1?Q?9k5cvYDnMOEsWJUooCSwkPtIho+3zPsLsxftv08MOniMIyj87Lx0OHfOyH?=
 =?iso-8859-1?Q?HiC3gJO5zTUuIN8Lq2EeRlXvsj1LUfOSRl?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR11MB2913.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53e3dbe1-c9d8-4c3e-a47b-08dc6f649bbb
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 May 2024 13:41:47.9921
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BU24nZ9PhhS1xY5U4ALBVCpvlg5Gqkh+FaA9gS0F516swkewjdrxVkc2uZ+HjE3uq8X83JlnvDUgD76hj/MxTOBqboyV1sdaPWMCnffLz6M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB8105

Hi Oleksij,

Thanks for change.

> @@ -2726,20 +2726,20 @@ static int
> ksz9477_set_default_prio_queue_mapping(struct ksz_device *dev,
>                                                   int port)
>  {
>         u32 queue_map =3D 0;
> -       int ipv;
> +       int ipm;
>=20
> -       for (ipv =3D 0; ipv < dev->info->num_ipvs; ipv++) {
> +       for (ipm =3D 0; ipm < dev->info->num_ipms; ipm++) {
>                 int queue;
>=20
>                 /* Traffic Type (TT) is corresponding to the Internal
> Priority
> -                * Value (IPV) in the switch. Traffic Class (TC) is
> +                * Value (IPM) in the switch. Traffic Class (TC) is

Change "Value (IPM)..." to "Map (IPM)..."

After this change,

Reviewed-by: Woojung Huh <woojung.huh@microchip.com>


