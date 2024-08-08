Return-Path: <netdev+bounces-117012-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7B8694C5AD
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 22:24:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F1EF4B25A7A
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 20:24:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 498701591E2;
	Thu,  8 Aug 2024 20:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="MRp1HkrA";
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="XBcZxrAp"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D23E09460;
	Thu,  8 Aug 2024 20:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.153.233
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723148655; cv=fail; b=pLz/6DsJF5O92Xn4w+8rys1iwnwd8izsENnvS3MZeFE8Xg7CpB0YFwHAtPggk6NHUe/0tWEraNKO8IHGnzmTpUsyka0bYQQ11UiE94k4T0bHjB51nS/r1tSew/TQ8JJ/HAIdUxkIxv7YJl28ADzL2xjFT9TxPZwYb0oIuXg4c6U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723148655; c=relaxed/simple;
	bh=cgTW/AD/r0nVex417MAhsk/IMmjQuNj8Bo5Ra8hLcCU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=S/wzT/xyXPCqTs6e2i7PL3Hn5fH3HwkQfp4kaeMKn2FsVJ/TPx1PgoAVnPEMIo+61CQt/krlEYU9X52/KgQD+/jGQOtkkRC2ukLml/ZjJduA50RgO4E4aQvL1vQCmRcPZwZw8rri1M8wu33PtXnFlkUjuX0oo+02BOOMR2pjzlk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=MRp1HkrA; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=XBcZxrAp; arc=fail smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1723148653; x=1754684653;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=cgTW/AD/r0nVex417MAhsk/IMmjQuNj8Bo5Ra8hLcCU=;
  b=MRp1HkrAm54RxOUvSZyLWdNZiuqVWwNK5NRKbJNpTokk0yMdkOrDZU0q
   1+RMQU2Axd5IefPF93KYfJklx3PLFHp01pYe7MmbNfUpbFk2n7b5KZZsO
   16VLNCp1TRjsLL6CHGlqUZxE5RssZqyM8ffA3bjpAOScB2wEGiCb9+o++
   2zVIIaBZWFM8IJ2LZWLil2ivI4jek5t1BikQMRiUvDtiSRnjOnoE4LJwB
   lhj9WN6Rk0wRlKdl+Gwyw7nE1KSq5VpoTSmN+dkSmFNpi1UWNlQ+QIPr+
   nwyYfKyhF0ZLFF+upufVi4qJ5VRwEJWDT1fMV0TKh86DQPEDzJrFVR7iM
   Q==;
X-CSE-ConnectionGUID: Bac9zoLYTnur09/B9/SBZg==
X-CSE-MsgGUID: CG6bzpoCQGu1IWeLn8lfsg==
X-IronPort-AV: E=Sophos;i="6.09,274,1716274800"; 
   d="scan'208";a="261188279"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 08 Aug 2024 13:24:12 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 8 Aug 2024 13:23:42 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (10.10.215.250)
 by email.microchip.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 8 Aug 2024 13:23:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d8Urrx12La6r0EgCWTb4JnCUzeD8lfmgS7lAPkgQad2Od/QJSSfQyv3ClnaAJC+bk5EOjWIHxlHvFaVmjsHG1Og7IDdzaFr74AlfG5VDkfOhpEh3GY4u7KVX6xn61pf5Fym/KhJyEAbPte79krAJiUQitavTVrQEEIdNynD6t1Ys6etoxmJ8RrKgR6/LN+W7TJZe66mWBWRC22iyLkSbohufnXFNyY0GLcKeexO8psBxVfS72JyYGhHLntRu3rLRBLv82XvIx9g3RS+70wR8N9Df2yGJy0i5gnxBU9shLvBPWzbWZGZlYqhqkxb3J2aJZM97BGW4ychwAFRTx0wQfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cgTW/AD/r0nVex417MAhsk/IMmjQuNj8Bo5Ra8hLcCU=;
 b=a5YLUZCsBK3VB5Yd/Od+YLmk7/7lCjtc12arYdnKLZBrfF1BDKsltNSj1590kkookkckt2ZQULPPeigL2ywq4PjZUA5Cc2btnEQQ9ouwnpIbcXYJsgjFUvBqLQDOi04wBFc+VTQDrpv11qHu/8N4Io0xn7/tpIKubA6tm37ii4hdXYfY7RlYv+SkWNWQVW7UXrRoOOqIvEGDfMPfHMWd6HQgzIYteJ6p4FhbrYHhP3kM2MuhIGuleuGz98EGAQMS4TqaKZJtRZSKM81bMh2mLgKeiVYINc6dJCLhv9Xz8LIsdgxsMp2VIrT6kLGaDqhVpElt2gOicw4bkQWzSvj/UA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cgTW/AD/r0nVex417MAhsk/IMmjQuNj8Bo5Ra8hLcCU=;
 b=XBcZxrApunxg1ZcRIwPyY9ASx1X5Dbeq/PVSSUMGX4a+6PtLR0JASc1lX56S8wSa1kWtntP6XupcTx9E+YJzygt+xBt8lIucdZt5KweXPMaXzt+/CQrZK+zwWJAlxWb2C9W7WnJsTp9Ejl9GKKweoC6+rQvhI8TJ2A2VU73Ko6K3uHK2iGr6H5rRsY0XjF0AhgR02tRQXYYxT80vQc8vdmmyu3m4ir2wmWtn3PkkpRiv+FTR/CIyHa00f3w/8uAPzknEY45FQXuzxw7FW2tKC95VBDnQFcLJDNvu2FFeuTN3Tmbpz50/BAsRRhjU5gRaI3VAn5JJVkri5NXsgmehuw==
Received: from PH8PR11MB7965.namprd11.prod.outlook.com (2603:10b6:510:25c::13)
 by DM4PR11MB7301.namprd11.prod.outlook.com (2603:10b6:8:10a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.29; Thu, 8 Aug
 2024 20:23:39 +0000
Received: from PH8PR11MB7965.namprd11.prod.outlook.com
 ([fe80::ad6c:cf56:3c3d:4739]) by PH8PR11MB7965.namprd11.prod.outlook.com
 ([fe80::ad6c:cf56:3c3d:4739%2]) with mapi id 15.20.7828.021; Thu, 8 Aug 2024
 20:23:38 +0000
From: <Ronnie.Kunin@microchip.com>
To: <linux@armlinux.org.uk>
CC: <Raju.Lakkaraju@microchip.com>, <netdev@vger.kernel.org>,
	<davem@davemloft.net>, <kuba@kernel.org>, <andrew@lunn.ch>,
	<horms@kernel.org>, <hkallweit1@gmail.com>, <richardcochran@gmail.com>,
	<rdunlap@infradead.org>, <Bryan.Whitehead@microchip.com>,
	<edumazet@google.com>, <pabeni@redhat.com>, <linux-kernel@vger.kernel.org>,
	<UNGLinuxDriver@microchip.com>
Subject: RE: [PATCH net-next V3 3/4] net: lan743x: Migrate phylib to phylink
Thread-Topic: [PATCH net-next V3 3/4] net: lan743x: Migrate phylib to phylink
Thread-Index: AQHa4oo5BwbfSBGoKU+hL6P+F4sZeLIPXFSAgALjZYCAAFqPAIAAdOawgACaGICACiT/cA==
Date: Thu, 8 Aug 2024 20:23:38 +0000
Message-ID: <PH8PR11MB796562D6C8964A6B6A1CC7E595B92@PH8PR11MB7965.namprd11.prod.outlook.com>
References: <20240730140619.80650-1-Raju.Lakkaraju@microchip.com>
 <20240730140619.80650-4-Raju.Lakkaraju@microchip.com>
 <Zqj/Mdoy5rhD2YXx@shell.armlinux.org.uk>
 <ZqtrcRfRVBR6H9Ri@HYD-DK-UNGSW21.microchip.com>
 <Zqu3aHJzAnb3KDvz@shell.armlinux.org.uk>
 <PH8PR11MB79655D0005E227742CBA1A8A95B22@PH8PR11MB7965.namprd11.prod.outlook.com>
 <Zqyau+JjwQdzBNaI@shell.armlinux.org.uk>
In-Reply-To: <Zqyau+JjwQdzBNaI@shell.armlinux.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH8PR11MB7965:EE_|DM4PR11MB7301:EE_
x-ms-office365-filtering-correlation-id: 8f2cb344-3b48-4a0f-aa94-08dcb7e7fcbb
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB7965.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?msoyWrdicGsL+7orFEhp60MCUhrCS5kAPeppp5BMFpXz/bYn3fpwp+C6msis?=
 =?us-ascii?Q?6T+AnPA5T4+p+mu92njDoKP+R8YevFfaYybimeP7SShMDY5mQ6vU/oka6nt8?=
 =?us-ascii?Q?8qXT5JaWFmO5MO30yKNLJYGERJI2PzqydOI6/QVyRNTYcFgYccgbBOV7e/ol?=
 =?us-ascii?Q?pN0CGgXg+AU9HkQaMhaW2fOggYY7nxL4RvpLbAb+Gi8y82UgbtcYJBzbwb9U?=
 =?us-ascii?Q?p6BDS3xTEkZsgvggFLqtMjv1HidCbsXQ1zhOdKzZeN/bIphRmJtHbFn0rALy?=
 =?us-ascii?Q?Ng07TK/JNLmwVFX/KY8I+yo/8JcpdlFsuK5uqJum4L8H5rDw23eQSuLp5VSA?=
 =?us-ascii?Q?363ioeVrQOaZFxRBQcUb01fqIfCGnyNAcm0EXfTxltwG3/WCs6UtwGee/u6t?=
 =?us-ascii?Q?YbyA3pMI4//JilsgI5s3visHxsSTo/2cfpe5/JMfMQ/73UADO8DaiiBZPIzE?=
 =?us-ascii?Q?CZyZzu3nL45ygvVHV8/0yp7oCyCtMYd6WjT8BstJcOt35MT+n18cl3QAHy+n?=
 =?us-ascii?Q?ndTnMgroqlgkgFAUIC9gZ3V8Y98I5gDwY7jHfGPmclcK2FKKIWVHCCUh4hLQ?=
 =?us-ascii?Q?3KGy/toXj8VYQ/99+UglR/MsWf1akZ9ZImf6PxOKq6AzuqsFarSKEBXeQCOX?=
 =?us-ascii?Q?h3hFVpftdo1gzpbAcNgg94fSOiLx/41Oth3NUrL4Pdk70uiElMc76XdeE33p?=
 =?us-ascii?Q?0opKJ9QxRo9G4YatscgYAduZFKEdu5imwmZhf3tgPWbgIYOH8oPzhK4duTho?=
 =?us-ascii?Q?Hude4oAxTVmg3/5M+UZ2cQ13X48tDWxtEAOBACdbqxUZ4+imAgxRQYqfeUhQ?=
 =?us-ascii?Q?ouhtVIW6cA37u1Qe02rC25F/z4qoS27AR55Tpeb0aFIRejFTjdXx7t4hgN7I?=
 =?us-ascii?Q?XiugWrIcM00es8k7JhgtQV2JwQaGFumPP0pDuoA4YPO3fov387sd+LmxXnVr?=
 =?us-ascii?Q?Ks4d8mS8B/v70l02WzEJjlZIH93RaV/MgNdmLwil9XlnGdT3AXW4gxeN4qiy?=
 =?us-ascii?Q?1C6eKbIfFUwXwSzeZbvkoc4s611OCMzYP4Ofqd6N8HSLx8N+JRNKfF0WJRiS?=
 =?us-ascii?Q?scC+C9J/FtIlmoWRqHu7oc6UUaOhKES0ddUv+MipWmWon6vhcq/NJLQsUqPh?=
 =?us-ascii?Q?uQiCQACZt/LTLfu0gsr2RkASKzy9RGgAXSkNmMHOFMhIS1405ViUeNwR85tD?=
 =?us-ascii?Q?X67Jqtzc0k6nRfnZ4AOrYPR21nd1l2AmFvJ1ocIDyZ8v/LyX+gkEJv4KtAsh?=
 =?us-ascii?Q?ADPCh/0EVtiZGHXkYQPZamgJ3gOOYkOMclfRit1m+oMxpRW6n3GZUv9KWtwY?=
 =?us-ascii?Q?/QQzFNn/iMC0LyfASz77B4xUA7O5AnK/dGi5E13ECynkBEakbjkCvXfnMpem?=
 =?us-ascii?Q?pnUh0pc=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?EzkrpB2kJ+ZJg2VdZbIDbPn8Q2EaJD8RmOHxBRO5XQyUBiPlChSv8MG1sko/?=
 =?us-ascii?Q?mOAp3cpram54u3vFC+LcKaZbjyt7wC624GOjmG70kDKsmkm/RtFjtsKmAaqR?=
 =?us-ascii?Q?SQfr7RJjfup63olHzzHvaFUBUu8ywqAtuQIziikevcKCuDEdbJCASE6bBgM7?=
 =?us-ascii?Q?P+lUy3tyiVxMX4U1B7U9qGQhSfdSwVAk4hVeF58A7odxMjXbFzPHD30XkTWz?=
 =?us-ascii?Q?IzDnFPVzWcw352Fi2v7kFE4x57NBOZyxWCKRd3nP3PE2NOyUjIR7YyOsIyND?=
 =?us-ascii?Q?qd/HfSxo1hbBKzs4BVn6xt7CPmewYNNU1+3Vg+eteh+jwjTMMNdwpAmrdfC+?=
 =?us-ascii?Q?0IH/1N8gVMGNGlexTeEOSBjMOugQuEqBgDriHVVjvnLDgixVCI0l37dv21fa?=
 =?us-ascii?Q?WdNyWSf2uRXQTC2Oc0BgD0TLce7JEy1tvdsDdlWqUNP4bDo2xIb93DCLRsyX?=
 =?us-ascii?Q?ClIcNV6Z5zgY8ZH6eI0gaNi2NcplX/gRcuR1JnBHiEtTNVyGuhKe5bjDMnCk?=
 =?us-ascii?Q?4ZSn3ldpQukUBrNS0RmmIBov7jivv4QcvOrCHptkQC2SwB/IvBEh5NIegSZd?=
 =?us-ascii?Q?9UHN0aA8qPvhw6a0i3NxHHlz51fp/OJskDQKnsAfR+7sFscOaQoEF+q46fNc?=
 =?us-ascii?Q?LCAWdwKxFsaxffEsSc/HSrLjag2EILcnYuszyJpFVA+wInbfqdLGLxwWyhYC?=
 =?us-ascii?Q?PQ16ybWgAwaX7oQ+lwFcJkTmQudgQUFS7dbN5ni+vxz9aF9a3y+fD6m03DQf?=
 =?us-ascii?Q?tNr0AYLTWmtezyJ1omny4eAudJF5+Brr7Yr3twOtNfSfLJxe88YouVjvgUfa?=
 =?us-ascii?Q?E5RZO+qM0mRTtCl/6XXxMwvWUtAbM8Lru7+L9/oUiaThmdPIEBXRIve+Sr9G?=
 =?us-ascii?Q?vmQHCxZNCYF7rv69B5TqdfQAPC1IFsEDN8aeskazzDroo39yQ2llHuqCu4UV?=
 =?us-ascii?Q?SbqFem82yOIa77oHE7tzlNFKMCB4Moq1dsvAcpcL2CpHxPWfSkLRdUTC4IKn?=
 =?us-ascii?Q?YIugAPvvvIrHIGyGtLeKlPSRGjnAsv0Fz5jdoILbH/jVOS8F7QE1gmtWeWQe?=
 =?us-ascii?Q?pNqBTxauh1TRMegSO+OVOKmTdrtZOR32aH+Ta0l+LiK84wVZEuM7skqh9qwT?=
 =?us-ascii?Q?Pe5pNPPYNW6U7hu6ugE8ALyOylm0euIaw8gQTfg/PLhQR8fujU3gHcEX+5Dm?=
 =?us-ascii?Q?Wl0YoHVH3iDui78lI250Jdvi0s/Iuc0pteV1ZLjVJOVBINhJ1Fj5FZwHQBE2?=
 =?us-ascii?Q?3YJJvBqPShb+SiFkPrQenrE5IHsKjJY4e+tkdM7IwbvJGtQarsRWcyDK4/LL?=
 =?us-ascii?Q?8cEkbAUCsr8kgU97us3A1XkFtyDHg5X6vb6fgkSseAf3NGib7v4qJYIKeR2z?=
 =?us-ascii?Q?kVqILM/7s+SfZ55UbzkYdGlRb5hHtUOcYeBINVCV0zyNIIGj/Ixrh21WBeML?=
 =?us-ascii?Q?tSnb2hQWOb0kdw1lQj7p+9TBJ2nyMi+nWZqodn6lb5tJB53byaTrTbqUbh+w?=
 =?us-ascii?Q?Uq0rNe0Kp/iaWIPWzTzlUSiRZ7w6aH62ITklZyNXUt2Px44vMwzmW3TopM73?=
 =?us-ascii?Q?dfvREyKFG/CdFEfLh595197s0Qwy1bP8aHrM/vYV?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB7965.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f2cb344-3b48-4a0f-aa94-08dcb7e7fcbb
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Aug 2024 20:23:38.5113
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1V14ROLAZeUTR+Nojsrx1zD4I6+uuMjrpOYAJBtlk/EzVqtaU219RnpBflmvpbhOThWjFKufjWWUczZd9jaajJPW1a2UIPYAbRmUxaW0cNs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB7301


> -----Original Message-----
> From: Russell King <linux@armlinux.org.uk>
> Sent: Friday, August 2, 2024 4:37 AM
> To: Ronnie Kunin - C21729 <Ronnie.Kunin@microchip.com>
> Cc: Raju Lakkaraju - I30499 <Raju.Lakkaraju@microchip.com>; netdev@vger.k=
ernel.org;
> davem@davemloft.net; kuba@kernel.org; andrew@lunn.ch; horms@kernel.org; h=
kallweit1@gmail.com;
> richardcochran@gmail.com; rdunlap@infradead.org; Bryan Whitehead - C21958
> <Bryan.Whitehead@microchip.com>; edumazet@google.com; pabeni@redhat.com; =
linux-
> kernel@vger.kernel.org; UNGLinuxDriver <UNGLinuxDriver@microchip.com>
> Subject: Re: [PATCH net-next V3 3/4] net: lan743x: Migrate phylib to phyl=
ink
> ...
> > In the longer term, it would probably make sense for phylink to provide=
 a mechanism where a MAC
> >driver can tell phylink to switch to using a fixed-link with certain par=
ameters.
> ...
> I think it's time to implement the suggestion in the last paragraph rathe=
r than using fixed-phy.
>

We looked into an alternate way to migrate our lan743x driver from phylib t=
o phylink continuing to support our existing hardware out in the field, wit=
hout using the phylib's fixed-phy approach that you opposed to, but without=
 modifying the phylib framework either.=20
While investigating how to implement it we came across this which Raju borr=
owed ideas from: https://lore.kernel.org/linux-arm-kernel/YtGPO5SkMZfN8b%2F=
s@shell.armlinux.org.uk/ . He is in the process of testing/cleaning it up a=
nd expects to submit it early next week.


