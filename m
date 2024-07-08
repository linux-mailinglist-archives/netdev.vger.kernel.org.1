Return-Path: <netdev+bounces-109953-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3893492A75D
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 18:32:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3AAB2817AA
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 16:32:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 411CC13E8AE;
	Mon,  8 Jul 2024 16:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="BKQbaEm9";
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="FagZdzGK"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95240139579;
	Mon,  8 Jul 2024 16:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.153.233
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720456346; cv=fail; b=Yj3qbDrcggKnv1+XO+vLiXdt/h2dAlLDvLqnKOd8nprUmvJT9/7jiPHdgsCzjtrz8B6sJWoOzGqNMvBQ8vqIdcmObyxVCxFbCxuKkLangEW3nSy5Uy4O7tuZlMq3D46NEvmftMjeCJiLaLDPg7AD97Cc1Vuw8YJinVTTO6x5uNk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720456346; c=relaxed/simple;
	bh=/JkSt77oxfp+PUMEGOPhJ3jPxaGlkACUJEqlGnf49Ho=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=j3e8UWmuXF/QyUjOMhplTrszSqav6W0+H5eaLRl9QaxjkVECQ5YbxH9a7pYmoYrscaQOIc4lYRBTNGN7nRjxvP2TfdA2nn7jYY5Ln4nZCnj+psid54QSqZyU57P0HGQGqjrzF0epYR3PDt9DNJMOVpuqoBHe1rCsaUGiKuTHJ2w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=BKQbaEm9; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=FagZdzGK; arc=fail smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1720456344; x=1751992344;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=/JkSt77oxfp+PUMEGOPhJ3jPxaGlkACUJEqlGnf49Ho=;
  b=BKQbaEm96jF8iRYTU19fgn6GjtzqiAYQC+69JDaVJgS6vTUhEMNJKPyX
   95RPAR8o20haIRZlXnwvqT1A21mMH1A6IfwqPLazULXDT1NQtgvVtVF7K
   zY37CxOKjLu/x0nN7oOsUu2lNiMdVOocRyUXYiovLtWEjdML6hcCAsza4
   A8gmqMTpFT2obfVlwJxnTrvd5PT+BUFF7tJJvyJn7dsV+fzhLSsITBb1B
   DDaKCIaZwdnov9Dk7GmfbdLooztN/g4cnQU+7CNeQHKyUgqdMmHIUKJtA
   OsUeh/2MAtohkpaMVYqwizW3pKGIIHbHiADvs9k9hgSMUb0L6IXCLfBMb
   g==;
X-CSE-ConnectionGUID: PGlcsJ+fS8OPAPjq274bnQ==
X-CSE-MsgGUID: 4xG0w/ipQZyDHtiQrkMcXg==
X-IronPort-AV: E=Sophos;i="6.09,192,1716274800"; 
   d="scan'208";a="28971166"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 08 Jul 2024 09:32:23 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 8 Jul 2024 09:31:56 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (10.10.215.250)
 by email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 8 Jul 2024 09:31:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QNnM77Pki3P5+HaF8FCVvmoskSZ5ESLG5AMnFDmViTaJVDGcVqG+4WJETbbG/E9EfKfp2RyRXe/Q/w3cpMxUS3ELpW3mh8/3P5rgQyFB26BM2Cv41n/UZF9cZ5xRQKJkjN9N85fKSjz27heZtag2vbgFezPRWnLujl4CqQ2nslAGwoR0x3z1iPN+niR48F4MoCnmzrSDd5p2heJIRyvX01xfgnLeiKGhrU4qZNR2s56BKZA0s+OMPJgmL6S3io6/mncU8PKZ5t0aOYIa5e5XjfKw8BtcSDG6sIKRvZkV6uft4rhaBGmkEMeK8ko6DWWxOYnUGRuf4sO1omd+FtomxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NYJQ2FX87QF2QMc++w5NqUde9UvxyEmkFfQwoYaW13s=;
 b=dr9oOv2LdMByHHMdWnrKSUpRT48e4AYVBHkninzMdjVKnM0rKHCFLsVWI1yuzXIMRuIBvXsYQ/da6xOjwaHrUI+qm/WzSN+/ZEnZArxdb5/TLpl4i0tYmAfSoPNDm1oVy4a8ZOPydDZCJxZhjEii+6pqP+v4arDk9hEDYr/zZSipDcqwWl/5zcpmoJRZqAketxydqrOVpQfDRqtSv011msCGo047bfgEKDVhGXTRtluDt+nTzFApri8KRHiyvVFkp/A16RAykJbdk5AyLa9D5GA1FT0BuJJOALTmxVFOSG0aHX21oWN8+ErDFgFVwHEMWqwf8xEIPNE7YvXmOfZiSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NYJQ2FX87QF2QMc++w5NqUde9UvxyEmkFfQwoYaW13s=;
 b=FagZdzGKoVA3yf3f55QcO9UOP61eopsAIu3i+DB6tFyPR78ZCoAqyXJ9kQZ0s8rgUkSeNqsMqEBz3XTC5t8sLBaPicQiIM7dj65EVhNLVA0/TyKjzL1C3MxToWtv0IwzuS3TMd6+aYmC7HHwaGUo5jKMic9n/DpEjO/nb2Dl3t0iJL5pg05ig0ndTqmovYU1rsa/w5gEKd+trfrrKjPQowMRJLdRAvbfxh67jOD/PlkGC/CZydDnI5LpzWwjgtR7sLQQ8SChYu+HpXD60ObyygBABicJhcCCyEN+YLMseqVOXBdwqf3g61wKJtpoqRcHoBItMmIdHudRqi3PiQRI5w==
Received: from BL0PR11MB2913.namprd11.prod.outlook.com (2603:10b6:208:79::29)
 by SA1PR11MB6968.namprd11.prod.outlook.com (2603:10b6:806:2be::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.31; Mon, 8 Jul
 2024 16:31:53 +0000
Received: from BL0PR11MB2913.namprd11.prod.outlook.com
 ([fe80::3bc1:80d8:bfa5:e742]) by BL0PR11MB2913.namprd11.prod.outlook.com
 ([fe80::3bc1:80d8:bfa5:e742%3]) with mapi id 15.20.7698.025; Mon, 8 Jul 2024
 16:31:53 +0000
From: <Woojung.Huh@microchip.com>
To: <o.rempel@pengutronix.de>, <mkubecek@suse.cz>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<jiri@resnulli.us>, <vladimir.oltean@nxp.com>, <andrew@lunn.ch>,
	<Arun.Ramadoss@microchip.com>
CC: <kernel@pengutronix.de>, <netdev@vger.kernel.org>,
	<UNGLinuxDriver@microchip.com>, <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH net v2 1/1] ethtool: netlink: do not return SQI value if
 link is down
Thread-Topic: [PATCH net v2 1/1] ethtool: netlink: do not return SQI value if
 link is down
Thread-Index: AQHaz2hPBJHkRhkuYUSe5weabIoP1LHtB1JQ
Date: Mon, 8 Jul 2024 16:31:53 +0000
Message-ID: <BL0PR11MB29139867F521F90347B6904EE7DA2@BL0PR11MB2913.namprd11.prod.outlook.com>
References: <20240706054900.1288111-1-o.rempel@pengutronix.de>
In-Reply-To: <20240706054900.1288111-1-o.rempel@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL0PR11MB2913:EE_|SA1PR11MB6968:EE_
x-ms-office365-filtering-correlation-id: 58c65d50-4f59-4bc9-c243-08dc9f6b79e3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|1800799024|366016|376014|921020|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?1yv97AiLXF+XlTcQqGTGnYI6Df443IspN3xzSMFuUbsJyFiYU6oHX1LCdUmx?=
 =?us-ascii?Q?bRcZ6ioOer5xq5IlmdDBbC8BPXJsbV5zOQeo8A/BhnJBUozRCQ57DIRDu9LS?=
 =?us-ascii?Q?lW7cQZPXZIChCTBesDh7FJ/EsOSXUIw/R/mkE1o/Qm+Jagm7yMGTC4PnkYEW?=
 =?us-ascii?Q?5TiAjDq+O6JNEUjykuN9YXjbSR9+ijdzI39gsV/O5jqti5hFdT1fQ4SwRk82?=
 =?us-ascii?Q?s+bxm50rcZc/+NyIU15brbAO5rtRCe8wzdr5wHWPN28aQlonRoILZdy5BesR?=
 =?us-ascii?Q?K5p0CJfwbCET5/Z3/khwMwFbGkYtZgwMKo1BLX4UrT+qVxXaWUp2kpemNE8S?=
 =?us-ascii?Q?NGIkZ+9ICnOzeeTnePgEswhrwovF+OY105ERbBVhtn+hw16ozcfAOizCVrCF?=
 =?us-ascii?Q?gtCS3lINe1UC5tdwwpYb+22FKy9B07gmP05kgIM4AGiy5rHcZpZa/diJfjas?=
 =?us-ascii?Q?Vkd6cM6/WTQIyxLEPo9y271wpJ+cE1wRhBwG6Qr4TOBzkuWeo8w4c4w5dI6k?=
 =?us-ascii?Q?GSglXKx7yL6WROvz0KW2K0nUqxSbGRRQ8i5zUWQx7/OiFlY1hrvT3YK477db?=
 =?us-ascii?Q?/z8ZlO0iD9tw5+JPLWR6o9vohVR+ws4jc/5ml1qh1cXr41pY6/i6sQ9wy8rz?=
 =?us-ascii?Q?EH01QPTBs0ZuuevJDqKOcS+R3Tm1NhmUi9MmsKZd78OgB/y1rALY20d8zM69?=
 =?us-ascii?Q?dAP6lQ79MdDlLNVQCyAMb3N0LTZO0iyhaxcu3eiGh34e8n2S3Ju5JJNEriSN?=
 =?us-ascii?Q?lu3JMOnTv211WJu5H0JLrddAu+f1V+2K2GldQmYxUefDSOeQaVL0lwbFtLol?=
 =?us-ascii?Q?HmAlkK4XKiLBvChL+tbeskN2g2rkMXFSB4DEayizX2YsHjBA45KzvRhwa3RB?=
 =?us-ascii?Q?mTo3qfY1FpCrxqXCuKr7DNX1YYPmDI4mB52s7CDvIZrOWFeYJzh9J4levh/e?=
 =?us-ascii?Q?MpSbgwv6voN2bjFo+0hX20Rrr3Vzc9tT7mRFZITK+o9jJjOum3jpvut4xNCB?=
 =?us-ascii?Q?VmjB4OopNma3nP+kTLv1VWSfdEyOsjEFrxnV3tVg8xr2NnX9G3vG00yyH5d3?=
 =?us-ascii?Q?KYYXz2rmIqmD8WOdEMfrYzA/GiQ9v1cxJ33zPK4jv69bvASn8yjauiwDRCKx?=
 =?us-ascii?Q?2jEK11W2nHfFNeFxdDhS1HJmfobETT8G8CtgQRA1qJ8DwCZQmLPxKqY8Qlvt?=
 =?us-ascii?Q?0hWi6Bzs+i5OBu4jxgF57umFmYyWCFBcQp2t0sZS2VpfDIKjyo3UVt2++/XR?=
 =?us-ascii?Q?8wZ2fXALpVq/qBp1Zwj6WUWCGS1mc8OZJTNBl2JFEjZ+e5gnxn3psgbDi/Hg?=
 =?us-ascii?Q?MtWbXcitbw7jBtEl50NvqkTZYLFKzAstafksE83lq4VrCtiCb9HGYgMTumh1?=
 =?us-ascii?Q?NNxArAsWpvOx+wGyRxO5sU77s0mHOOEZ1uSSU7ffOu6HKWVOkFAuQJ/VKgay?=
 =?us-ascii?Q?Jp1VITvd0z4=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR11MB2913.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(366016)(376014)(921020)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?3f6xXI56eIrx6aJNMlLo1CfgM+98GE9BYS49iuLOpRttrGZqvsvzZKeuNkMR?=
 =?us-ascii?Q?Ug1ZNp9DQ6ACvRJv4329AQzGmNppqLIBi+OWrwCXda0CZwcC4OJwaG5ZOEYe?=
 =?us-ascii?Q?x8Z6fo1mVIrd2fsUaWV3d/vQcvwPnJszC05+hsDqo1LOReEZrnpp+bnbjtMV?=
 =?us-ascii?Q?El80xGO7JJPKVgm8TFnIn6ZzE3hho7LjE0E/pcYEewCFOUJY6q3TQWTBXtK8?=
 =?us-ascii?Q?BS34HAtNsIUU/YYtxNNRUyOz0U1MzyiIOK4EpUdxQCzVrh8cI8S2y1zdbZma?=
 =?us-ascii?Q?ZWqgbBc8tOPlUkU9loH9cK3lLpgpXB1V/4LsnKA/FU29pWRgA1nRajC7djI6?=
 =?us-ascii?Q?W+gslNJ1PvO1B2jtEYzBWC/G3mbEsYAlLeZnTI5tC+d6mK/z3sv/nJnBgZ7H?=
 =?us-ascii?Q?NdmyVZMr07lEs5eEGyqZmwxQdmgsJ3Atb+j82zuNTbrJSE14w6UOj07qsjbm?=
 =?us-ascii?Q?K6peDSKBBoEVnZGLsrwQr3Ui2+mg7rCYZb+y1SPBUzELVFPFFITvfFtuYoVS?=
 =?us-ascii?Q?eClGSsbVHRUIbJ0j0k0WV9kQMZ7Qx76bqwGgpheWjHhGlZ4lNDwx0dDoLCeQ?=
 =?us-ascii?Q?Mdug6g6Kg7te/tPg+4EX44VjvemQ4t+s8lFDd7sbBGXVwVywTuBrAaa8DeVo?=
 =?us-ascii?Q?ckObDmCt6N2uUiVgDQBg0Vk4eOltgBmA37LM1sjnjzrrjf83OoV+QOapbXpf?=
 =?us-ascii?Q?2ukdYcNGbnZ7QL2vQY9OypwHlwThXMQJkIx2/lR3A0P+ZmBYdKBQS4olmZ3v?=
 =?us-ascii?Q?Unq/v145l+Iu4bWQ4M3kE4/+MMqioMczM2eRiLfQFvHlrzhBvyRCG8I6Gauy?=
 =?us-ascii?Q?h2GRHGK7l7M8F3VaZ6JUHtRg1VoMqaajewpOImKBhEZW1VCCLetA9zm2A864?=
 =?us-ascii?Q?dLLow4htHHxWyT5nkGgYU2DIZK9tbhaNWvyyh0nS74fQ9jGxDk1uNeaZo6VT?=
 =?us-ascii?Q?5LtHA0Xn6Kax9648Jyl0MgyMEErCx23z4OIwYpuxUK/lmZdDzJT79wpE5f0H?=
 =?us-ascii?Q?zUUME1XSIaF+c/c1P1CZ/GYEhJ5JNdz9Q57kt0I3jZPypNvCFKQ9jRqB4DpB?=
 =?us-ascii?Q?he0VXMPwdgBqL7DoqGsUOhu/J4YZaQig4eJMcKcQOoVspBUxAJI00EhyJAle?=
 =?us-ascii?Q?/nY+kSXARmSX5Wa8eeJQ/4mANiuAzk6gx4w5IhvQvrbrCJzMnvbZV7KrNR0M?=
 =?us-ascii?Q?wQRAIoMTKKNdQIUXc6Ub/N3FTFakOheyrAdD94xLk22QgaqWkipHEga4ExUI?=
 =?us-ascii?Q?6aSIJmIhxwxqGW0Haidz5i4t7Ch0DYztHEuu2xEXFuVaBYhVqE/cAyIJs2o9?=
 =?us-ascii?Q?ao0gG6RDYHXLeLm08eQGv3jCoinJpR7Mw9QyVoabKOLJXJebAxIfMe7vFXYn?=
 =?us-ascii?Q?M6jVjqJCivpksTbG71FV+FkDarujZcxzVuJzPdyibU3Vsb4ZIZ6uGoo0jbWK?=
 =?us-ascii?Q?r0WwYlp8fHx1XgKLRcreZ47VG5Ft0Zjn7egw0bvDBD3d4k7LkFJen/C6l7eQ?=
 =?us-ascii?Q?Ikh6VbR1Tp0fXu6JfE8wrgNlFVYgVAONl/Jd1p97uUZ8Lib8GcXhJN0ovclH?=
 =?us-ascii?Q?thzkHZIKAbx8/IEgHsHpQEuiohs8xtD8/4MncN1I?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 58c65d50-4f59-4bc9-c243-08dc9f6b79e3
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2024 16:31:53.4776
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CYFP8JCQYHkJ21TQw2VImhq0CpQ7blzdb6Zh/UaPdzuc2GGx4SPkaDCnhY0tyfpPdipAb1CSaOyO826KFpTEUuoMmvuF31NEI/JkGqkV8DE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6968

Hi Oleksij,

> diff --git a/net/ethtool/linkstate.c b/net/ethtool/linkstate.c
> index b2de2108b356a..4efd327ba5d92 100644
> --- a/net/ethtool/linkstate.c
> +++ b/net/ethtool/linkstate.c
> @@ -37,6 +37,8 @@ static int linkstate_get_sqi(struct net_device *dev)
>         mutex_lock(&phydev->lock);
>         if (!phydev->drv || !phydev->drv->get_sqi)
>                 ret =3D -EOPNOTSUPP;
> +       else if (!phydev->link)
> +               ret =3D -ENETDOWN;
>         else
>                 ret =3D phydev->drv->get_sqi(phydev);
>         mutex_unlock(&phydev->lock);
> @@ -55,6 +57,8 @@ static int linkstate_get_sqi_max(struct net_device *dev=
)
>         mutex_lock(&phydev->lock);
>         if (!phydev->drv || !phydev->drv->get_sqi_max)
>                 ret =3D -EOPNOTSUPP;
> +       else if (!phydev->link)
> +               ret =3D -ENETDOWN;
>         else
>                 ret =3D phydev->drv->get_sqi_max(phydev);
>         mutex_unlock(&phydev->lock);
> @@ -62,6 +66,16 @@ static int linkstate_get_sqi_max(struct net_device *de=
v)
>         return ret;
>  };
>=20
> +static bool linkstate_sqi_critical_error(int sqi)
> +{
> +       return sqi < 0 && sqi !=3D -EOPNOTSUPP && sqi !=3D -ENETDOWN;
> +}
> +
> +static bool linkstate_sqi_valid(struct linkstate_reply_data *data)
> +{
> +       return data->sqi >=3D 0 && data->sqi_max >=3D 0;

If PHY driver has get_sqi, but not get_sqi_max, then data->sqi could have
a valid value, but data->sqi_max will have -EOPNOTSUPP.
In this case, linkstate_sqi_valid() will return FALSE and not getting=20
SQI value at all.

If both APIs are required, then we could add another condition of
data->sqi <=3D data->sqi_max in linkstate_sqi_valid()

And, beside this, calling linkstate_get_sqi and linkstate_get_sqi_max
could be moved under "if (dev->flags & IFF_UP)" with setting default=20
value to data->sqi & data->sqi_max.


> +}
> +

Thanks.
Woojung

