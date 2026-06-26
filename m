Return-Path: <netdev+bounces-302257-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id X057FdjQPmpXMAkAu9opvQ
	(envelope-from <netdev+bounces-302257-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 26 Jun 2026 21:19:52 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 723EE6CFE0E
	for <lists+netdev@lfdr.de>; Fri, 26 Jun 2026 21:19:51 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=co5BmxWq;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302257-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-302257-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 84D2A301ABB4
	for <lists+netdev@lfdr.de>; Fri, 26 Jun 2026 19:19:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E7243B8D4A;
	Fri, 26 Jun 2026 19:19:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55A5718871F
	for <netdev@vger.kernel.org>; Fri, 26 Jun 2026 19:19:46 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782501588; cv=fail; b=Fa7SU+AOpP6Qr7n5kSqe+QZVlEj1bFakVgN7tUjnmzuU1RC62dl8MxGw5WtuTQ2zNDusfaigU9LDcFVUL+7BNB4SJ/IsNO0DAhlxpCyPvV2eeIg5pqkQ/ZTnCwpUPi2daU6lZTvBnoFAs+b8E6WJ8lzpvjd0tpE/ycUl3cRP0r8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782501588; c=relaxed/simple;
	bh=rFKxf5JMvh3oYt9CYh0OvT2oqgD7Z14qCCX6W66r09I=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tGuOuVhMYfTnE0bAbGtNH9afMYZ9ABqmILZ/6EE4aH7x5VTYMmoNNKOXSzz+nKiVs+GPraxQ1HIYvLtR8kyHfDB08UrxCL/HylDOQDd1OrO74G94cqHgGg9b9bluAz34xnqz/xYqb0D8AJX3jomXSQXnNU+UWY6gfnKj6T0wZ7U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=co5BmxWq; arc=fail smtp.client-ip=198.175.65.11
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782501586; x=1814037586;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=rFKxf5JMvh3oYt9CYh0OvT2oqgD7Z14qCCX6W66r09I=;
  b=co5BmxWquvmftzevLBuudwmuaFE43mos7gVaTHtEfH6WFD2UbVWiAfk0
   bJI8//56QtjKTNCyKGw67nvgh1YvxGAoq+dnx66e/UBTMn5BOLcOpGYnh
   4dsdTlqqF+0q0hCKwvnY/scxSguZgfHFPi02EdFlR86bZSOFE6GOuVgTL
   Z12IJqefdT67L8QGn4BYQwFjftHNcVv3V6TmpP3td/L7XsdVQtAJku315
   As36YMd2Bg4lV45mcF8sjADDEFNT5izj89FcPZOCWCaGA/Ojkxi6cUyAj
   fsN/jJBYDdqwRHRFmxBH6XJPg+VJySD43ZyZ1nbIlvKHy6IYWa8fQLiFQ
   Q==;
X-CSE-ConnectionGUID: tsiyDX2LRC6paI3enXwq2w==
X-CSE-MsgGUID: zoUas2NjTLCURdJkMfEjWw==
X-IronPort-AV: E=McAfee;i="6800,10657,11829"; a="93651451"
X-IronPort-AV: E=Sophos;i="6.24,227,1774335600"; 
   d="scan'208";a="93651451"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2026 12:19:45 -0700
X-CSE-ConnectionGUID: xRkOjMpyQ4Cn7hySSpWW+A==
X-CSE-MsgGUID: elLIz5OOQQaTk57+ztC2mA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,227,1774335600"; 
   d="scan'208";a="248022735"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2026 12:19:45 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 26 Jun 2026 12:19:45 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 26 Jun 2026 12:19:45 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.62) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 26 Jun 2026 12:19:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xJrGx4Yi36hy87UAq825wIQJ9KpRf3jtyADPEFad7I0bLqWyX7woQEsVQcDWVYKqHUUVtyACQKaAiGhbSEFIkYdlPsAYazSjQ4ovC9Sj+KxFrhOn0oz6JalBJGY1U8eejRyRdx7gXLo6na0UZBD9tBErzProZZp6eEYuM/zMQvVsyMQF/pAaaFOlymSQT8vfDSejFIJya2C2M51PfJ0ylAt+F1Iq7F7xR8gLwwzZbViJGJ3YHyHVedDt3wysxZlZjxjniriAkdLWTjyxRSveOTPCVYWVgWwc02Frv09H7907cGU/1g0LMU8W+TV+CWEZW7bE23BlAAAEMBWTxwaXaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RKtu6IMYD8fbgwkLLCCDmNzn/vpKB9TiIJkQMU1lWbk=;
 b=hk1avnQ0FmT0dqYYZGFyEhsy0Ly+EZrJFgDIaLpPITrS3EmlU+hYzThwwxwyOt1YlDwwEDoDSa0sb6XfK/HOszAZpZfnoplDjWyxisHKQCj8ZqXNrLejxJVQXcEizmLkInRMea2Q1+5nSOVeLavnZi/ZdCY5GHRgvWDtu8L9H9q12ERfrcdjI4D/StFxwenmE1JrStY2J8fushu/ybw+4gu370H/7ktOo2L7qstZJHzWPBGwSZHPhkUpagxoIs4rDAVDhgj4YrLmEwwhmAPwR6akPegYFIV9llPVjpxqXfiHzgkLDTzNeRzU2U8iB+FE6jzBujiLlcPyqh/eVol3xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MW4PR11MB6912.namprd11.prod.outlook.com (2603:10b6:303:22a::9)
 by IA1PR11MB7871.namprd11.prod.outlook.com (2603:10b6:208:3f5::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.17; Fri, 26 Jun
 2026 19:19:42 +0000
Received: from MW4PR11MB6912.namprd11.prod.outlook.com
 ([fe80::1ee8:dc26:e7f3:3d4]) by MW4PR11MB6912.namprd11.prod.outlook.com
 ([fe80::1ee8:dc26:e7f3:3d4%6]) with mapi id 15.21.0159.016; Fri, 26 Jun 2026
 19:19:41 +0000
From: "D H, Siddaraju" <siddaraju.dh@intel.com>
To: Andrew Lunn <andrew@lunn.ch>, Maxime Chevallier
	<maxime.chevallier@bootlin.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Das, Shubham"
	<shubham.das@intel.com>, "Chintalapalle, Balaji"
	<balaji.chintalapalle@intel.com>, "Srinivasan, Vijay"
	<vijay.srinivasan@intel.com>
Subject: RE: the confusing 10000base_CR. Shouldn't it be 10000_SFI_DA?
Thread-Topic: the confusing 10000base_CR. Shouldn't it be 10000_SFI_DA?
Thread-Index: Ad0FbzNABPoQ31JxTh+QV3XDba1IJQACWbSAAAchFbAAAMJTgAAAOH5g
Date: Fri, 26 Jun 2026 19:19:41 +0000
Message-ID: <MW4PR11MB6912BABFEED268D38B4BC2BB9AEB2@MW4PR11MB6912.namprd11.prod.outlook.com>
References: <MW4PR11MB6912A234CAAAFD25EAC7C8909AEB2@MW4PR11MB6912.namprd11.prod.outlook.com>
 <2994edfc-0894-49c9-abac-6daea5e12075@lunn.ch>
 <MW4PR11MB6912BE7FEDE5C509B6C5D5DF9AEB2@MW4PR11MB6912.namprd11.prod.outlook.com>
 <2baa5a77-3305-4ed9-b56d-ba27cecc1911@lunn.ch>
In-Reply-To: <2baa5a77-3305-4ed9-b56d-ba27cecc1911@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW4PR11MB6912:EE_|IA1PR11MB7871:EE_
x-ms-office365-filtering-correlation-id: e8becd46-e6ac-4773-81b3-08ded3b7dfb7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|23010399003|10070799003|366016|4143699003|18002099003|22082099003|11063799006|56012099006|38070700021;
x-microsoft-antispam-message-info: 1lcDwyYpSmMGXQmsePfZt28KM0bjWMIv8YyPn8JRtNqAwmDwHf7f5Me6hm6jmZnqVNiR2dSF2JjRWUoPz2iPNMSJZ3RShz+tjov3E05os3WCSaSn0flO3vQUT0btl2MdohgywZP54u1Gf0G1VSgg8tyztJIrOWR4TbkOmuHoKCzW0FG4ChGKqbnTVto98sPQuInfpu6ooxDg26IN/KEe8gFNAqAZzJ4bVvP59Vgau0pkMAT+fyXlK63s+aLEB8VQI18YlyXOHFDL07hOVqrtJiP8PSxb1CQ07dq6JIP8PUy/Wwe/bVQzmr9+M2qdcVZXG1j0F5xjHMjH2SB6fKtf5OABaQrMqhtnH7eCcSAgWIki7PkNNJWPPsgOrpLh9913hoOr2wCkwpcBppAqw36wnc96S9sQ1V9iNENufSAcVKpm+559Z6Kzj9c5iXr7dpQSodrZMgARobN2rMDHXiiVsR88nltb20TbH0TtKbED29c0b0p+4doIiSKJK5TdhGcYH2j1y09e8BsSL/8QfwS7tf4VFH5g6lnPl9a/lwPqIM8DooWOUkLlE5SPHZKRg4VcRacbABn/dWjOJQZii3ESJ5XtFmm7RfQ7xqIDPD1E76/GIRwxTQdYRmThjxVnrg4Mt/oGG8vE1WXZeds1Sa96DIhTRCT+1m9NFE+BfWQOmECgTCz1o8S8RX1JdoXzcbWsWv/H/Fh/rnapkjkBQUufxpBA54RlfqRj7ty7WtAA3Q0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB6912.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(23010399003)(10070799003)(366016)(4143699003)(18002099003)(22082099003)(11063799006)(56012099006)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?OAfvyYGWtFy3VLRX/K0Xw58Dv/u0NIRsR0TWc3UoRd/uuEkqG7rOMBXzUUGa?=
 =?us-ascii?Q?thH3FufG5nHT1xO0gEOXb4KtNSx++w3mRdUGGKtkJNEteWogt6lBacRAHCQS?=
 =?us-ascii?Q?sYcvjwbwZAKobq6boxQepZuEHmYmRsS0AitmsQ/25UJdhcxHPpmDChD1e3CB?=
 =?us-ascii?Q?kdtTe6UydRaILP1Y/g2j3EfOsckE3RShh0AZQWNSxBTmQPSDlSteeD9lS2sb?=
 =?us-ascii?Q?x0zmTKhXTotAMzYiTTCFcRtsFCER90G/0QzE+H5On/FveKjh+yId/fb2gax2?=
 =?us-ascii?Q?pImFTH46hy1E37DkFavxQbIU6h9a5EqivwW49Y0gTzqY27zx8MWWinnREvBT?=
 =?us-ascii?Q?xkWPOAsUTlHloKz09OEXa2ZkTzpydFxLsGFySYaR6FTCdAUpXOgfmoGNoG5a?=
 =?us-ascii?Q?dr64h6v0uHuB2k5oQg5R7F9buUAIE0x3UjI1NVeMMDA/ozs/aJxOJRsX1VXK?=
 =?us-ascii?Q?hWXRtGr30S2aIpXsUYsynHfJfeN1Er13M3Sjd3h5aWCw/FvTTcbyL6VJPj9q?=
 =?us-ascii?Q?JbwD1Pt7iuY3cOHCSlyM2+vLX6DXpWtsg2w+ZNWNWvhXsd9A+Nit51L7LnYw?=
 =?us-ascii?Q?igLBTl5nQW1XyAdTkuFTfOUGi0wjhd+Z7KuvDLwBaUsy4xQy1rqjnAq3I8lG?=
 =?us-ascii?Q?IuXBrVKtUzdmc2pr1/rSktGFHTAhDI1JZj1NfPXyRNs68b41VNjTyGqi0uj1?=
 =?us-ascii?Q?qEoFM7pfA0lRc/ZUWE2PNubAz9svZNIZXPZU5g0I4wLh2tdtTxhPnjbZMhYX?=
 =?us-ascii?Q?gCM7xJAVQ23kI+Ce4grwAAIOwXHTVVvBL1l1UelxHLU/VoECM2bZgL2/uQgI?=
 =?us-ascii?Q?or7rsK2WxHGHGMhsDUfQeLcmyUj8z/vn8WgB7wwlNZxL1lyS3bsMqgB1vYHA?=
 =?us-ascii?Q?3NcYfP3aaPYnKHqGv9YTa2uc/LqHAI7PuwoEf0bwhMZqDeli7Q25c2HhlRr1?=
 =?us-ascii?Q?k/LgvY9pv4xUJ1YZFkzotiNnvoTjuXqfPOhLA3npBBcDnDtfY02Adz5mr7rx?=
 =?us-ascii?Q?UrV3IcBBeyty5FKIJEwwhJ+ulavnELAJP7bxAkGepQGU6B4h++tuPIJ9xeSU?=
 =?us-ascii?Q?jBg53Vh8c6AhX/62l+q2qD0u4uUvrkDKGc/x70zgjJzOFqsiOjf4V2Tw+keT?=
 =?us-ascii?Q?udKCNuLEqWL2zM6Y57VDQe1OwBJS1GDTArKePjM8rPCl5whz0m4u607xSPs/?=
 =?us-ascii?Q?MsZJHnxzY1NK6hIfgdmqooKRE/B2ITKwqAdL2To1ygAgq5emgHVwtimh6/9D?=
 =?us-ascii?Q?/FaV4TzmGFk12kZiXZVgXXS8k9UKNojLaOeq6etWGtQL2S2YIUhqyjZJTmCM?=
 =?us-ascii?Q?kOHjxwm3XzW+IzL49046pzAcXoF5IOlnwpYL7G6sekzNUFRKA2TX0ReA90JZ?=
 =?us-ascii?Q?vVJsJkm0Ld2n9kEDcm2dJsJjkf0MHU7427SJwtipx3QEBlS6ggZQSqkXvQM7?=
 =?us-ascii?Q?gHm1o3sImT4EU7qZF5k+/8FF+55wEQYehPmA/TUVIRAez/TTIQiy5WuD3chQ?=
 =?us-ascii?Q?ucrGWGmEe1/2j65LQaQmno21Hu1S526S3KZbQfpJqtELfI9jXvXW7fWyfK7+?=
 =?us-ascii?Q?Uu0dTWqDwiTNMQ9V6fEbPlnAtrapiOEaerQEGKkiutWhGtb1BQITReLodBZ8?=
 =?us-ascii?Q?tb6LSCXKA6Kv/IIeU4IUaRG9x6IVUKKrq66EDZOUAwJ4+hZ2IuwpKaxu/2ff?=
 =?us-ascii?Q?7et+TiseoEar6OZZTw83hnDQXFcAunIfbdUorgT7+I8EdJIYUWQE9Tx2wKY+?=
 =?us-ascii?Q?kZLeQM2FHnqB2Tnmp9JRRtHxzJPnuCsvmxAGBPZ/fv+QyB5Tpw3Gx3UylLIb?=
x-ms-exchange-antispam-messagedata-1: Xq3HXlYaLGYiEA==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: Xyw0FN7+mdCblHabwmTJD8hUVF/ErFm2C4gp2a55finnaxyFcjqUAZEBCEp2nRWiZs/6s3hmLqHipEbG0Pz6mKZUMVw9kQOwJpQKKuObH3vpJJNqu1prgHh2nmKWNV1O95H7cGRELUfcPpjikcNOSXjZ9E+Ym/hg0QDPJj+dOamah2wLnrVYSybAhwB2IJPavTDQF4Z6ZC9hIPs7IWaSDDuVvOmYL0tcSfVNfcutHrwgoa6l8Cm+8DTZ3kMn2DHJ8cRq6q2+W2yv0EF0G8b0RUQnsZIQJOGyTAbkpcjSRzwd/BHWXQ5CF/ZXwOTaOrntdcZRMJBAknU7UewoK0L2cQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB6912.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8becd46-e6ac-4773-81b3-08ded3b7dfb7
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jun 2026 19:19:41.8964
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2Rtef4vi1buwq9xS4vUNqH/NPlpUvuE/6+NmDusk4DBQwPEBPRF4f8XGprX2N7mOezERstmri/6/hN2tD+grmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7871
X-OriginatorOrg: intel.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	ARC_REJECT(1.00)[cv is fail on i=2];
	SUBJECT_ENDS_QUESTION(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-302257-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:andrew@lunn.ch,m:maxime.chevallier@bootlin.com,m:netdev@vger.kernel.org,m:shubham.das@intel.com,m:balaji.chintalapalle@intel.com,m:vijay.srinivasan@intel.com,s:lists@lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[siddaraju.dh@intel.com,netdev@vger.kernel.org];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,intel.com:dkim,intel.com:from_mime,MW4PR11MB6912.namprd11.prod.outlook.com:mid];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[siddaraju.dh@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 723EE6CFE0E

Sure, thanks for pointing them, Andrew, will follow.
Now I realized what you meant there, thank you for the quick feedback.

About options,
Ok, got it: "option-(a): renaming *10000baseCR*" is out.
  Sure, will support this from uAPI backward-compatibility point-of-view.

  Just to highlight Maxime, yes during exploration, we too came across
  those few vendor products. But when we looked further to understand
  which standard those 10GBaseCR cables were following, we found they all
  explicitly call out that its SFP+ DA conforming to SFF-8431.

What about
"option-(b): create a new enum ETHTOOL_LINK_MODE_10G_SFI_DA_Full_BIT"?
  Idea is just to create a new enum, with same enum value of 10000baseCR.
  This will NOT consume a bit position in "ethtool_link_mode_bit_indices".
  It just helps those tech-savvy people, who does not accept 10000baseCR
  and prefer 10000sfiDA for being explicit.

At worst case, hope we agree for
"option-(c): ethtool.8 man page help strings to indicate 10G_SFI_DA"
  Something like
    "10000baseCR (10G_SFI_DA    SFF-8431 SFP+ DA)
  under "advertise" mask values.

- Thank you,
Siddaraju D H

