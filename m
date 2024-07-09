Return-Path: <netdev+bounces-110404-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DF24E92C30F
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 20:04:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0EA1F1C22808
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 18:04:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38DC017B03F;
	Tue,  9 Jul 2024 18:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="LI5q049w";
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="h5SztFse"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12D451B86E8;
	Tue,  9 Jul 2024 18:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.154.123
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720548239; cv=fail; b=UNOnEdRmLXcq4Bbau1rUiEkCZuXlBm9GMIXM3A4FRfw8LC4WySCuNsowl60d10Whvb8moI8XFIFheE7b52GKciYw6UL+sUiXTLtwePGq+Ftj4LYY/Og94lj/9LiVm3ooz5NpTbJnkhf2nkAo3uQaSvzmJsDufo6NyL55rInxXxk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720548239; c=relaxed/simple;
	bh=nQ3wlmex5/6H4S1dgkTWP01yZXAhG0eh0SutR44IlGQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GVfWYbHXX6wOJKCjRNtXkmK8BjFyNtz9Dn03YfRuAlvQpzjL3ZteEpiHMAS0DDr+C4l7eE5LfGQRa85Mb5Ivx0l2iU5Ean0J5+soKW+ImYH7TGhRyXKwGzIFpLMRow0smh6h/B0HIvZtTrAYvQBhuLxOAhfZcOcC8LH4iEqlJz8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=LI5q049w; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=h5SztFse; arc=fail smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1720548237; x=1752084237;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=nQ3wlmex5/6H4S1dgkTWP01yZXAhG0eh0SutR44IlGQ=;
  b=LI5q049wIu5eW2MFax0iO1xh9qEix8Sw6AgLCGXxVePvp3OdivEi3XeB
   H7PuRTKPPJw+jIItPfs4NqzjqU2Q5FV1X+nkR0Avme4U8ZqqU0vm2DGVr
   kw3zESP3BBnmj1N7JXfznoQm0/AtdioeU0nhthpebTYWbMUqcH2WorVw8
   vPdMYM5qazPlbHkAPmyZub5OfY+WhnTqL/u3mWiJCkx4+vfU/WO7kHKP0
   9w/mBcjTnjNI0TyutehMmqiwT8Xyf0Gt7ZLgdH60BEZFVA5fTJLHpLW3e
   nSSF2ZNpncrEjeC4cRoL4vrUVfWI6wd8t7L6XrNOJfvPKwwB2Arjjs1xd
   Q==;
X-CSE-ConnectionGUID: H69xcO0iQ1yQlG+AtoeKEg==
X-CSE-MsgGUID: xtNaH7+LR6WWFIbWPt9fBw==
X-IronPort-AV: E=Sophos;i="6.09,195,1716274800"; 
   d="scan'208";a="29666713"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 09 Jul 2024 11:03:55 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 9 Jul 2024 11:03:27 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (10.10.215.250)
 by email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 9 Jul 2024 11:03:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZiWKCjSzhXhEwQjadv+QVg8Pl65cpog2kQCPEDjFbaUjzAxHjmPRQXv7H4yvhJuKidN88cQKNlgI7DE6IcUe4BSbpkvf23VY2rDbotedkYK6qJXmdH3yNuvEDNn9RDLGBAAZTsYyNz0sXImsr2GjfEpIsiPmAL9PVHA6aS6iOS3pDz2aiywzf8MR+rvHHch/BPWGJQoRKVTY4rW9wVgA7/xucxfeEi4/FZhn58XaYNPjL2jmCJiI70CCHM/9l0Jjb0FH6d6Na7C5IhgZzti2C2IrPfR8D81KfVg8HCItXOt4TpIxHzbUa5gQSHm/BHpN0D7/7A+4OuNoNc8HjHIkxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nQ3wlmex5/6H4S1dgkTWP01yZXAhG0eh0SutR44IlGQ=;
 b=cZ+gjucb/8flXowKg+3qxCcABcccEmMsG1iCHj2JRalo8FJVtv/wQr8QM1+9yuFSheyyLNObMYYJk1t4y3UboP1wg2FWCvbX4b2f8ZZtHooQbep6hI90tJoHvlxC1rEcn61tqaPRwNGQTVubsK1cpRbR6PRBCjIBxTpXy111sIxepP1zSmN5cknhVdPrEF/x/L7OTTr6434BrB/7bLRleWmSYbL1KkK821kuU2fjG0gxlfq4C3GluLTl+1nGIR1djuVhuCbEtTbopsiwt8lP1+/fyrpGD5+AQQLuOecrC7cyOv4QsEZUQ0tmC0xsphnTZw+LMVEZXwaARSy8xnsgRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nQ3wlmex5/6H4S1dgkTWP01yZXAhG0eh0SutR44IlGQ=;
 b=h5SztFse6VMCQdPq/yfmijgMru7PiWxEnlaW3jTXk5Haorv+Jqn0LS5aSmShFY8sS8TA6xTRTcr4NPvEPkKQtuzwuDhtQTlkKBoeE+nQg8ReS3rqEU+azRMSioYCXco0DVcZSP9ACoLNSDPir0dv7FAM1w4OygmP6rm/dNSWbemdWY6kAhbdCa2NETskMMTW+m6o/jTEVKMaGXqVSTgCc/3r6Qj7O1sn/08HWE+vrAdRvNTo+pbewnzTXeepG+6LwQvsHyy1ihjWhkx41I/DTqYAGjBODJ9N8Idr48Dc2rHaNcRZULvlIVUAVZCt/9+baVpoFA9E84u2HXQBApqnNQ==
Received: from BL0PR11MB2913.namprd11.prod.outlook.com (2603:10b6:208:79::29)
 by PH0PR11MB5094.namprd11.prod.outlook.com (2603:10b6:510:3f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.36; Tue, 9 Jul
 2024 18:03:24 +0000
Received: from BL0PR11MB2913.namprd11.prod.outlook.com
 ([fe80::3bc1:80d8:bfa5:e742]) by BL0PR11MB2913.namprd11.prod.outlook.com
 ([fe80::3bc1:80d8:bfa5:e742%3]) with mapi id 15.20.7698.025; Tue, 9 Jul 2024
 18:03:24 +0000
From: <Woojung.Huh@microchip.com>
To: <o.rempel@pengutronix.de>, <mkubecek@suse.cz>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<jiri@resnulli.us>, <vladimir.oltean@nxp.com>, <andrew@lunn.ch>,
	<Arun.Ramadoss@microchip.com>
CC: <kernel@pengutronix.de>, <netdev@vger.kernel.org>,
	<UNGLinuxDriver@microchip.com>, <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH net v3 1/1] ethtool: netlink: do not return SQI value if
 link is down
Thread-Topic: [PATCH net v3 1/1] ethtool: netlink: do not return SQI value if
 link is down
Thread-Index: AQHa0cgXPuqszqU38EqXJ2QuYYmP/LHusNWA
Date: Tue, 9 Jul 2024 18:03:24 +0000
Message-ID: <BL0PR11MB291373114256CDD26A8019A8E7DB2@BL0PR11MB2913.namprd11.prod.outlook.com>
References: <20240709061943.729381-1-o.rempel@pengutronix.de>
In-Reply-To: <20240709061943.729381-1-o.rempel@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL0PR11MB2913:EE_|PH0PR11MB5094:EE_
x-ms-office365-filtering-correlation-id: 13dc0bc2-e52e-4297-0d65-08dca0416cf8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014|921020|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?u0WPr6FbIVPmatTgcqDy8BKTzAUcRJyO9nwuRP3K9No5AdakU7gsz9bQNk+s?=
 =?us-ascii?Q?6/cfR16/fkquBJGZN/v0TRopP9t4P1MCM3gTNpOn+IAd/QcTpEerWeQOs7qa?=
 =?us-ascii?Q?G+Exx+hx+x+cBGYGY0e+hIpvDyqXzoZ7XRD3Jgs0O54l9Ciw9rGoy+Aigg61?=
 =?us-ascii?Q?OZ3nVWp5kZlfP0IqIqafAOXSnR8V8/zqYkNBrU6W196zR055VuaQv7wzzjMS?=
 =?us-ascii?Q?qEOxniHNTsGd2quDNrKnaYpzy9tbzFkwGf1IgtlYL/sXZou7Ew9w3R48XlE3?=
 =?us-ascii?Q?2oqFRe48EQhVIYJJbUztJuoOwzG+8Yc7E8ATKvx1nXMWCgEik0IMPRcv0wmY?=
 =?us-ascii?Q?8H5mZRKpev//dktyqsGdUoCTpu4cw8T3pKc/+bAsOrRBLErZZhdU52kJBhHq?=
 =?us-ascii?Q?LyyQcO7zPOswPjGnx0g6+s9tIt6Gub6JRmrez6e4ofPUx8a5RUHXvdWU+96Q?=
 =?us-ascii?Q?qCEz7lwn9qyACDUqB1FPRcNz3MR8ZeQ5jfpenTC9I1El/Kb/XAQvZ6OB4A1i?=
 =?us-ascii?Q?l8p+5e4/E190yzj/wUoed1ntTvgAZVLp/t2knSyi5ccn8E2CZgGZ8CeYfPP9?=
 =?us-ascii?Q?IvE2yrMN3DupoZcb9TOEXFz3Np6IUoBGuVqBpN0PFYoS2+W8430/Ij2Yx9oe?=
 =?us-ascii?Q?6C0h87IMJRZfaF0RXqm6rFi+K4yxZ4lj2b1E7KseNmR5KTWZjtDWk+6hv5RZ?=
 =?us-ascii?Q?X6mEkPNnTSssk7o+QwReWn5VGAEcAMZ0FOeq3CTSqVCpEiSO8ynm5ub04fgT?=
 =?us-ascii?Q?vLERyxIcjJ2kbS8zSGFBVgC+YwVZhS9hi/SiwnpAEsflEQAIwkCnIIhjGmKd?=
 =?us-ascii?Q?iB1vseqXzi90Gk8G2QHsmHopKI01cNmjxdSBaP7lEJZZfjoV7f26d3A8nd6k?=
 =?us-ascii?Q?LcP8JbFyBhNxNSuQOu1/kpGrLwa5eVGwZGBdtE6EJrdeZhJaj63z+BQgEQzF?=
 =?us-ascii?Q?O1tFmGFvAnVkXMkGZmcDR5NGV0xiGjd+HDaUoQjL2y4cW49gmgkv1Y1iOst/?=
 =?us-ascii?Q?87NM39DyFqbo7jWyfE7y4uUc/15l6E5fU91UseDDLZlGGXpnzDoiMho1wU++?=
 =?us-ascii?Q?0KHusvl2qhvER4hHnevFKLxCnHCXwt1yQT4iDbrKq9blfMSwkv9CiwNmnQ+1?=
 =?us-ascii?Q?1MHVSKhoObG03lZ92yBh+LmARSAoRpH/TUGaWv/FmdxZBiiESXSA8VNiwO0O?=
 =?us-ascii?Q?bLMNL66L4Gn6SUMrgbrn1o1og/VItGGBGdcEY+svoZYVHMBStjk7C84gqqOW?=
 =?us-ascii?Q?lzAAdfGrn3K6osDpg6J/BAZH1OitpkCG3iNGd91VT7PEd7VxlapAnc0IVLu4?=
 =?us-ascii?Q?VDzNPBu3Xs3OR76Vm/g3TiIuQZQhL08Eynjn1IgDqQI3mvjTbJPA6qutxSEd?=
 =?us-ascii?Q?GH9H3Dw=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR11MB2913.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(921020)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?V7L3V2WeYYiOEq85AO626Lz1rusvIqJb/8BkpXYC/TpJWS7RtCSq1/eiS49u?=
 =?us-ascii?Q?4XTSMQ+RchrHAELFEdvySxpb9vixZlY/Pb+dVICvgvKVccJSRZ2myttJbj8o?=
 =?us-ascii?Q?aNYVerizFrWVG92hPJSWitbsVPHrJdV6nJwywY+TexDGJ2GJzFRy/JvQQAFH?=
 =?us-ascii?Q?AoeeoNSc+LplOzhKKfgbpN1vRldClKqDJLG6VtNUsxhbw8cG8792hmkj52KM?=
 =?us-ascii?Q?gds5/dG+5BLBmuQvQ8Pgi54gN1QFQwgQ9jX9ZbU5F88UAa2dljpP7qBbSy8G?=
 =?us-ascii?Q?hkKkTr/0QHLLUySPC9R5iSk/ejZ0UHl3z+8WWPYn2yqTl57St8IKdvyP3pp7?=
 =?us-ascii?Q?jawVq/UeZ2CMWZZBlF0vDcToX+K4A+qoiOLDOURreYMATlHzH1vIyf/rDugW?=
 =?us-ascii?Q?Bnybzs0T/8y76uV7afKlDzXRVC/ZY12zRrbsJJ2+GaK8J6P9kBlohvhAsDj1?=
 =?us-ascii?Q?ijGNe5/U6RSUoIV+7x+DcFXFFxrR4LUJPUgbvt86SJflrbddi8JVajwMQEwj?=
 =?us-ascii?Q?okIvYV/D/Un2zc2wQdP5v0jN32hkVzZmDPujEAK81GO37xX5eTJEKFdU5af9?=
 =?us-ascii?Q?y3fZe7JWaynNg0U8WycX/teZ4heZ5tO+xXuAUE5fu3jsW52onH6v1WP9JadO?=
 =?us-ascii?Q?kcvxNANBD8jBdDbPSsFvQKIVa4QMtDxC1oKJuY2z6HMjgIrRMnxuwNMv5xnz?=
 =?us-ascii?Q?h8/coC1W0QXYWnbDA4PY7+PTQks3SYw3zeMpJix8432oP/1CAD435VERZlaB?=
 =?us-ascii?Q?y2DQBlY3JeIY1dT72WTwSwqwrAn5SRfaCO6oH9Mhw625YNT8ysB746IyPueM?=
 =?us-ascii?Q?di8cHjsS11tP+mDE9kEV+kEoaJA4KQ7rsnfFwkd5+CdMNSeAhAIWpNbhANcJ?=
 =?us-ascii?Q?TLDQ2VinHSb6oKkc3pKQncbJoxWRk0kz1DWDOBRdKTV5uO1KRhpl4FneaQ7Y?=
 =?us-ascii?Q?SyDIhd6FIdDyVHxZXkLWiwyKkgte3ePX7MVhpTGNGi4F6vr3gftrnELUPP4N?=
 =?us-ascii?Q?uF05fyEXtesneyJ88GeG/IUewSLAOgxc6g98XCVjHQYs5kxXw5eRClYkXJW+?=
 =?us-ascii?Q?9xWxcZgosUsxIAmaapwQTTr7y05bYLmXrBvDD93WHtLYd6jDb+wVk7g8rLEG?=
 =?us-ascii?Q?KxJho9KG6mQSNgQuyrDqDEArNISUBKVKoWrxS4UXg8AXC0rnyf8p13lvYT9J?=
 =?us-ascii?Q?40pjoDkqFwacW12EedSxgLNqoeb2C/WjJiKUuBBP+So75UKFTM0J2w3hhjW3?=
 =?us-ascii?Q?sfyhsxMoioogde3YYN4pxZzhX3sQms6LTreGiQ/XBXP/gLO8UzetogFdekUp?=
 =?us-ascii?Q?OuY0iMxFd2Ef/tpzQmOP0EsOQO49H6+4MRRggC1WOm32r5dBnHToiAAJXqXc?=
 =?us-ascii?Q?o6z7yS8sraahQ6fY9hYCoUPx7MtssDcYabmWmlSlrzp/Rjdc/XM/5l0xI/Fm?=
 =?us-ascii?Q?e2ujnvDks5J4dFR8scPHh5QXOP800lHgvJFcs9WNKBwllbtFkwniYBncjuw0?=
 =?us-ascii?Q?1A2LJtgU+e7A+OyWBOm7Mw9Sz9tlfA2SwvgnyyKQchZ2SInoAfJln+37C8WY?=
 =?us-ascii?Q?xrzeqAg4Ju9ALLjPZwSxtxU8kdaExGabADE6iHfM?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR11MB2913.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13dc0bc2-e52e-4297-0d65-08dca0416cf8
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jul 2024 18:03:24.1001
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5po1by4xYjXTpNXEZxoOqwEaccNuchXXRE8JJ0wAnk55ChxuWMhfjTnjVju8ksOEImWdmQChEIJNmEocd3w82mVTF3/fXqZbH47xW6VRuzo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5094

> -----Original Message-----
> From: Oleksij Rempel <o.rempel@pengutronix.de>
> Sent: Tuesday, July 9, 2024 2:20 AM
> To: Michal Kubecek <mkubecek@suse.cz>; David S. Miller <davem@davemloft.n=
et>;
> Eric Dumazet <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>; Pao=
lo
> Abeni <pabeni@redhat.com>; Jiri Pirko <jiri@resnulli.us>; Vladimir Oltean
> <vladimir.oltean@nxp.com>; Andrew Lunn <andrew@lunn.ch>; Arun Ramadoss -
> I17769 <Arun.Ramadoss@microchip.com>; Woojung Huh - C21699
> <Woojung.Huh@microchip.com>
> Cc: Oleksij Rempel <o.rempel@pengutronix.de>; kernel@pengutronix.de;
> netdev@vger.kernel.org; UNGLinuxDriver <UNGLinuxDriver@microchip.com>;
> linux-kernel@vger.kernel.org
> Subject: [PATCH net v3 1/1] ethtool: netlink: do not return SQI value if
> link is down
>=20
> EXTERNAL EMAIL: Do not click links or open attachments unless you know th=
e
> content is safe
>=20
> Do not attach SQI value if link is down. "SQI values are only valid if
> link-up condition is present" per OpenAlliance specification of
> 100Base-T1 Interoperability Test suite [1]. The same rule would apply
> for other link types.
>=20
> [1] https://opensig.org/automotive-ethernet-specifications/#
>=20
> Fixes: 806602191592 ("ethtool: provide UAPI for PHY Signal Quality Index
> (SQI)")
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> ---

Reviewed-by: Woojung Huh <woojung.huh@microchip.com>

Thanks.
Woojung

