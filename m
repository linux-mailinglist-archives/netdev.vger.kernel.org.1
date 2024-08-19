Return-Path: <netdev+bounces-119568-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D9FCF95642C
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 09:12:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 016F01C2180B
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 07:12:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D2C5156F55;
	Mon, 19 Aug 2024 07:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="rZnOYL+6";
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="OiGUHp9e"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E694F156C65;
	Mon, 19 Aug 2024 07:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.153.233
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724051561; cv=fail; b=bklBSkRRaOjE/lIzBj/CQZlWId1UuhusNntwWPauIt3wAFDQsSiwfIY4dwFXNEJjT+XKbVNIERBBBnmTsK4hlZ1ADafYkxpJuszbP5TdFeRptDLlD94bmkfxNQS+UR3gyWdta351SqWwUs5GfldBbaK6Jsg6zf4Vhz4HHbEvRuU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724051561; c=relaxed/simple;
	bh=6DgBMBF6OSBvcEq9jpysROH7sEiz5KcNha68APhf+4k=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=g5wTrAZ/a1zFlWnH3KiLaxf4nf79POJ5nXaOeu6odSck78IzasqkW6emdN3xXou0KlvRU3TtstImcCREZZoT3AWzsOuR8pJeSq2MmkX2j2udC+l1cxhwKY/D1V3wXMk9LNiMdifePFBQcqbMBEZmZXayoa3Tl3i4urnf76feec0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=rZnOYL+6; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=OiGUHp9e; arc=fail smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1724051559; x=1755587559;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=6DgBMBF6OSBvcEq9jpysROH7sEiz5KcNha68APhf+4k=;
  b=rZnOYL+6HpgiXdnG2tPO3QnT1QHGMUDkcYQAAM2aULXlRfFfZzCPxGoP
   +iZMnh3NR3ziZIQgMJ+Qn9AtIjrDu9ccvsjFF8/twmZyI0j5z4bH42fo8
   dAvjU8B1yihPEkjdbOyqz3FUwa2HSA97MIkprnYmldQZbqXvh4/HnGhWU
   cwnX0i6iqbkcN1envHeOhJ+vIlKFZ9F6OYP7eeoCj+HmQk+tyW0WZP70C
   8VnVlRB7l2aaM9iTAlYWZdwyVwu/AOeV4rRXJtgvKFjYYoiR1EtxOBJNL
   Ix6XhKiHS5M1J6ld6CdvUnOxWv9ikmS8tbaCOSWnBV59QmRLAT6ndacc4
   w==;
X-CSE-ConnectionGUID: e1y573SLQFSgOCBFR8subw==
X-CSE-MsgGUID: 1Oxl9fw/S1eChCGbWy27Bg==
X-IronPort-AV: E=Sophos;i="6.10,158,1719903600"; 
   d="scan'208";a="261566660"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 19 Aug 2024 00:12:31 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 19 Aug 2024 00:12:20 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (10.10.215.250)
 by email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 19 Aug 2024 00:12:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DvtnPq7YkRjEAAl8YZ1+StyYCsXUyLJ18CQCtJTsDIxTIx1rUlDSBinvAay6m9OBz0mMhzd0u0fq1R3qbssQU2Ew5JmnBYUKvPD/oMZGFX7zpL5W7oa4k8ZGeKdQh5I2mc61qiH2EQ6cZ1uuJZxPVxZqZD4Ct7N6Bqbiidy7dHij2woegOo3PTJLuC2nEgQQsYjowUKd5t6CGkZ0u6fSnWaOlAoQ9jG8m0wrw6rYY1jdR64hsagr8moH4/HXgDER+LOYeFVBwcISp/J93SelKF7eyxYK8RqEz9k/LNwouUaTlGtCwwMqOiQlvVJphRPUEc5iqg6Xs7gikGFeExMrfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6DgBMBF6OSBvcEq9jpysROH7sEiz5KcNha68APhf+4k=;
 b=PVPxecZWGla0ofLC4tZQ7Lfk8ypWEOqZyYsV4zlhiaAcYPPppLWmvMl2oF/3Y/p1UfTYUbOtUWqahedDta5fKjD/9K0/lBbN7bz+1wcbavQIv4zoPxOh1Fa5hNL/gVmbBdPAvpDOFSid5nECYnJmk3mi1l1NW8Yd7MvoPFtNPMc/wowzTWDZ1j9MrOLI+kXVHFNF4cTuE9jxHSeeTFeV2QOR6wRX2knignayu1lFqFzpdfMBeQvISHrBA+UEZeuej0iMeycpRtOKOR2lNVzGptORWPihi2JMr/MflR70ZXnQWdfF4swzWPprZB+Uy9YMBbNkOwVsTYOTX+0x2oqfHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6DgBMBF6OSBvcEq9jpysROH7sEiz5KcNha68APhf+4k=;
 b=OiGUHp9elVKfgiBzfIVSIBwLCYhRqoNBI74Hhje6S2Ap0jlWVsb/ypYNiJEO+Mpj6SqMT58SKOl4lul7a3g/mdl/fXtFMS32e9rdzJwjRufZGpOTsRnvjsEGQmUrba8L3n6RHJp6BBXCO+zmrFYg3g3BfTrFZkV2fr+RA1XyZQ/oEYD7/zm3tya4CEmpLzAB0v156EPEJft1p2LfETlysSF0wcbvdQFnXx6I48ZHaX0K6bs169pSjHwGUCIPAE2O28GdMg7k2uROKRQvKczpFY+brDXy/uSCDLGPhZeXFrICMbIR8NjE7NEke6L8WAJA25lkZhPgXdsqbOaSZ7plzQ==
Received: from SA1PR11MB8278.namprd11.prod.outlook.com (2603:10b6:806:25b::19)
 by IA1PR11MB7892.namprd11.prod.outlook.com (2603:10b6:208:3fc::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Mon, 19 Aug
 2024 07:12:15 +0000
Received: from SA1PR11MB8278.namprd11.prod.outlook.com
 ([fe80::84fa:e267:e389:fa9]) by SA1PR11MB8278.namprd11.prod.outlook.com
 ([fe80::84fa:e267:e389:fa9%5]) with mapi id 15.20.7875.019; Mon, 19 Aug 2024
 07:12:15 +0000
From: <Parthiban.Veerasooran@microchip.com>
To: <kuba@kernel.org>
CC: <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
	<horms@kernel.org>, <saeedm@nvidia.com>, <anthony.l.nguyen@intel.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, <andrew@lunn.ch>,
	<corbet@lwn.net>, <linux-doc@vger.kernel.org>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
	<devicetree@vger.kernel.org>, <Horatiu.Vultur@microchip.com>,
	<ruanjinjie@huawei.com>, <Steen.Hegelund@microchip.com>,
	<vladimir.oltean@nxp.com>, <masahiroy@kernel.org>, <alexanderduyck@fb.com>,
	<krzk+dt@kernel.org>, <robh@kernel.org>, <rdunlap@infradead.org>,
	<hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<UNGLinuxDriver@microchip.com>, <Thorsten.Kummermehr@microchip.com>,
	<Pier.Beruto@onsemi.com>, <Selvamani.Rajagopal@onsemi.com>,
	<Nicolas.Ferre@microchip.com>, <benjamin.bigler@bernformulastudent.ch>,
	<linux@bigler.io>, <markku.vorne@kempower.com>
Subject: Re: [PATCH net-next v6 13/14] microchip: lan865x: add driver support
 for Microchip's LAN865X MAC-PHY
Thread-Topic: [PATCH net-next v6 13/14] microchip: lan865x: add driver support
 for Microchip's LAN865X MAC-PHY
Thread-Index: AQHa7KKQuPfLIdMOXUqnVJuW3dmwpLIqI8KAgAQRNAA=
Date: Mon, 19 Aug 2024 07:12:15 +0000
Message-ID: <6dcc69b1-33b9-4a55-a1e4-cf639bcbdf3c@microchip.com>
References: <20240812102611.489550-1-Parthiban.Veerasooran@microchip.com>
 <20240812102611.489550-14-Parthiban.Veerasooran@microchip.com>
 <20240816100537.7457ba58@kernel.org>
In-Reply-To: <20240816100537.7457ba58@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR11MB8278:EE_|IA1PR11MB7892:EE_
x-ms-office365-filtering-correlation-id: 45730e45-78b5-4560-5a3b-08dcc01e40f1
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB8278.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?QTk1ZDhpMVlhTmZYMkNacW50Rk01RjA4cTQvL2VpV0tMci9IQ0c2WCszajFa?=
 =?utf-8?B?dmlwL2FLSU9nWVdtQXdsZ0lIeW92NWFkUXZpbkpLLzNNUUtSMUVRdFZjN2xO?=
 =?utf-8?B?NExYQVh0d3NDTzRuNGVDZG1XK1JnVjY1ZnFTamlXMjh1SFNwZXorTlFkNGxa?=
 =?utf-8?B?WnlnTm54RCsvcG41Nk1Eanp1WGdMa0oycVNpWkhQWEpWNW1GaFFyS2NSb1p5?=
 =?utf-8?B?U2J2TmcwTWRreE41U0pkdTBwWG1iRDhqN0wwcGJlNDEwaUptNEd1aTJzRkRO?=
 =?utf-8?B?TjNFUHhOZEVRWDZTVVNraU9HbVZHNkF6NnFaTENQdndtMmRzRmpVKzk3VmhG?=
 =?utf-8?B?NGxxWkEybHdFdk9IY1JYUjZnNWJyL3pvTGRTQUc2QzlPcWhqd2JNRVFhMjJZ?=
 =?utf-8?B?L2RhUzBQN05tNVAvNEN3MExZT3FKWGRacmN3VUtkZnFQMTB4VWF1SjRQYUU2?=
 =?utf-8?B?em5UTlR5aEdjaEVvTUYwKzVDYk9CZU9WMmtaUU0wVUpxNEFHMUJvNWRjaTU3?=
 =?utf-8?B?dmdzMlZoZkZ1bGcvK0tadTlzYTFpRzVSd0trbGZabmtoUzJMTElWdllDa0NQ?=
 =?utf-8?B?MkVGL0xTSlYxc2Q2cHdGK05UdWNVaGxsZnNoZFN2Zmh1dlZtUjU2SXZyaHRa?=
 =?utf-8?B?QWZCbldIaVVqdjRuVzY4dUZIYndlSk51akwrdjRTRVVkVGVJN3B6QW1VWFZN?=
 =?utf-8?B?RjdjRjFKeVgxdHRSUUtXZVR4L1lBb1l3a1RscWVwa05QNEx1TllIa0l4UHNh?=
 =?utf-8?B?dG1aZEkvTXF3Uzh5YkVmSjNEbWdjSXZhWXdBaDRFYnFNR3lkVFRsSkgyWE5N?=
 =?utf-8?B?M2grQzdXUzVBTFlzdWN4bmR6bTZySEYxR0k3aXVncG5CamMzZlZRMzNuckw3?=
 =?utf-8?B?R0p4OWRabElyamI3VHBHMGtoU0U0NEVBU3VoZFJYeGMvcFg0ZU1qa2wwcHNF?=
 =?utf-8?B?b3JSZ2JoeTlmQkRkR0FLZGI1bHFYQnpOSGFSV1BTaXgwK2tEREd1WnVLZ3I1?=
 =?utf-8?B?ek9tY28yRTdPRHJ6YThjVFlWclQ3MVZEdnZjOUtMY3lJWVVKS05RUmtFY1hQ?=
 =?utf-8?B?UDVCQ2tUS1plNVFaZnJ5b1E3YXRIaWdtcStZa1NiVW9vZlZrZkptQWExZytR?=
 =?utf-8?B?UWZFT2U0KzVLQ0JlaFRDSUJUWCtZNmQzejFZNTlWNTRkZFJEbHNKOERjaklL?=
 =?utf-8?B?MThCLzFQWDA2clA1YjlaTDNjVEF3T3lpZnBUcVRaTVZaVUQrcjIvSDNQM1Vt?=
 =?utf-8?B?SVV3UXYzc2QwNkhQbjcxVnlhUGhvWk9DYVJNak41dGFzYXpFM1NUOG43aDQ0?=
 =?utf-8?B?SmNla1BPdFRUTDNsVm5rZW8xOThMRmNMbWVoVHU0RnRCdmFtNHdhRWdMbGZw?=
 =?utf-8?B?U0ZaKzJjOHNucHM0Z3AzOHlHS2NNQmVXMkkzRGM0bjUvU1UzUU9PVGplRThG?=
 =?utf-8?B?MUcyNlVHbVJwQ2VqeFBWT0lXKys4QUVUSjBoaDlPcllLZm1sWm5veHcrMWM2?=
 =?utf-8?B?SStyNURKTkhqdVpqKzRxT3hwSXJVcFJLWEJEY21VUGEyQ3M3MlB0bnNIb0ov?=
 =?utf-8?B?RHZNSTZzeWcyaVVTWVhGQmxvY2NXNG4xdWpZY0tWbm9xbXdqc2lqTWVpOERz?=
 =?utf-8?B?cVdYd0V4SDVQbFRiTzhZeGFXNVM2b0xtazcrZzNMUnBmZ1FkYWl2VDMzR1Bp?=
 =?utf-8?B?Njhlbjd3MTdENi9TOWV1dnJzbDhCSC8vci92N0dsOXQ0akZYRzlId3hzN2hL?=
 =?utf-8?B?QStmaVpJenNFS1RxQzFwYXZ5OW1YWFozeUhXNGh2ckdWakdqTlRKOHBzeEpa?=
 =?utf-8?B?NUhHdG5zMkdUdHhCaEhOVURVZzhla0lpMXRGUGU0ZHRteEZDQndjVkNYaEJn?=
 =?utf-8?B?MkJsdC9WUFlCT2Z2WHNHVVU0VUhGeS9vcHYwcGp0MDBDUmc9PQ==?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ajNNZ2tscnBXYW40cU5WVFlZNXhOU3hjem01NFdtRkdqelFDc3VGMU5IVjdR?=
 =?utf-8?B?blJmbndSU2VOanhMSVZnTDRmRWYzQXJBYWxEVUZXZ3ZpWGIvWDFtRDVaUjBy?=
 =?utf-8?B?aXR4NjZ2ZDFVUncxdTU2TUdGQURPSHkvYkhneUd1dHlWaTFPaDBPQzNPTnhk?=
 =?utf-8?B?dGROSmFMQVFTMEpYckluUThvcnE1RkdTcE4wc3BTbnRnbnVoeHE3dmFMTjZn?=
 =?utf-8?B?NlZ4Y1hsN3ZCTnU5TzdQOXUzdlEvSXN3YTdDVmJ4N2VIL0JxL0V4T0lGcnVl?=
 =?utf-8?B?dG90YStDVG05U29pcGlIMW1MMTVjeEFEa09BaFl0UUN5RUdFaWpYeGk3WW01?=
 =?utf-8?B?U3NWenUzbTJ3N1B5U1o0bE9lZU1Zd2VDekYybkhRMjEvOTJmMC9qb1FtTk1o?=
 =?utf-8?B?Zi8wUXZZVWFjdG4xYTREZ3B3K0wvTWVISkxBenk3cC93dlBEUGd1SFl2QU5J?=
 =?utf-8?B?TTVEZDQzZTBTMi9sQUtieWluWGpYWnIrMkFZbERQbnEvclU5WUN3Uk1yaytH?=
 =?utf-8?B?SEh0NFVod2F3NDA4QkZZYi9XRXRtRHEvV1MzM2RhN0U3Rzd0UUIwZzhHRHV2?=
 =?utf-8?B?dTZaN1hYRm5FeTE2T1B1cUxmM3NqYmZiRDdsekVUNEczcHNQVlBDRGhTMzF4?=
 =?utf-8?B?THhFMEQ2NE1kQnl0SGtMazRIVU9qdGJzekNkWTNBRWxVbnAxVHJFVVJzbWhH?=
 =?utf-8?B?U2ZETDBoM28rdGd5VEZFVnNuaVQ4eHpKSXdHMThYU0M5RDBUNnYwNlJkQkpB?=
 =?utf-8?B?THRQUUV5VmNLOHM2V25iWUp2d3c3dytCQjYweTlsYWVDNndhV3lxZkF6QWJy?=
 =?utf-8?B?cmc0Qm9WMGw2T0h3NXNEQXNWN05tZ1lRY2grTklPK2JRRzVVMDV6VGp3TGc2?=
 =?utf-8?B?OXpKR0VVaUFhckVRR2dHT0hDWUk1eVdVZENycm9Gci9RdlFKZ3NDVGJQdXlK?=
 =?utf-8?B?dHVpSlo4cFBWKzNzU0t5c0ZtMElZUnUwY1A4c3BIUUREcUUzM0FKby81NUV2?=
 =?utf-8?B?Qm9CME5FRVBHMWd2Rlo5MHhOeE8wVXFCQzg3WTljZUROVE9UYXVhay8ra2lQ?=
 =?utf-8?B?VS9DN1hoc21WcmkvZDRvVDBRdUp6RFhKemc4N0xaRlgzQnlTd05LdkI2MnJB?=
 =?utf-8?B?SlZOMkk4SFFSbnFnVXRVVldrQnpzR2orL1Rici9RRS9JTUs4cVBlS3dsVTJJ?=
 =?utf-8?B?WUo1U2dKRGZFRU84Z3NiS21mVStBS0R1cUQzV2lFVjNBaGh3ckhPRzBZS3pY?=
 =?utf-8?B?bW9kM2NZR1hUalVjZGc1NWFrNVhMYmE1Rlp3ZkpJWEtNekJ4d0pVdnBNRUFP?=
 =?utf-8?B?UmNVUmJFUk5waWVGVGh3TXUwREpJekx3cUh2V1J3OW15NXRoZ1ZmdmN5Q2NM?=
 =?utf-8?B?RjdQS1ZCd1pMMU9YWVlETUJEKzN4SGUyUGpVUHFKVW1VZ2JuS29lN3VySlRQ?=
 =?utf-8?B?VEZEdUFuaGQ2OXlYZjBFQnh5K3JmbHQ1elBHZVBEVlU2VlFwWUpoelRuYWZL?=
 =?utf-8?B?UFdGSXhLdGg4Y3p2RWt5WEErTnBCcnBtQ1lmVzNyV1FNOWhiR096clZnT1ZE?=
 =?utf-8?B?N1kxU3ZoSlRUQkNrSU5ySVhHZmF2RE9idUQ4anV3ejcrQy9lc0VMR250M0Jz?=
 =?utf-8?B?NUMvcW9CR3VESmcwbWpuY3ZIL1AzVWt0bXBtbTZzdkpacjdyQzFXY2NHbWRk?=
 =?utf-8?B?cjZTZzFxOVdIYXJnTUt5cFVmWlZ0UDZTREZaYWY3b0l5Ui8yMkdlT3MycXBI?=
 =?utf-8?B?WVAycitvRm9pQWVIOVFxVWF1Ukp3NGQ2MUdVZzJOMDlQU0tIRGQvTEhpMFNW?=
 =?utf-8?B?Zk1hWDFkdExkMUNWdlVFMWJWMnFTRGltQVcyVTVuVmk4bW1DRUJqUXlwUC96?=
 =?utf-8?B?andxMGsrS29hRndLRHliQXBMMVE2WDN4NjJIQzVjMHVTcHUxR29WQllqMGdD?=
 =?utf-8?B?L20yc040MTR6NFJxK3dWOEdSMVBiRmFwVmJMVkxoemZZaisySWl2U3FZbEU0?=
 =?utf-8?B?U2dsK0ZBYWFKbXU0SkNMTWkzZmhOcW9XbUhXc3hsT0RZSkUxRzEzSFZldGYv?=
 =?utf-8?B?bk1pUzYvSDJUYW1EeW1JOGhhRjVGR2NnWkpQa05tSnBPM2ZJZGdwbVBPdkox?=
 =?utf-8?B?WEJxTjd4Ylg3bTVCN2VSZ0tzM05kQld0QTFKUFFFZnJua2lVWHA5WllQWC90?=
 =?utf-8?B?bFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <78D2614084690C49AB0FCECCE9F4C520@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB8278.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45730e45-78b5-4560-5a3b-08dcc01e40f1
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Aug 2024 07:12:15.0692
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dmvU+hapRIU9l1XpXjCeIVzoe4nGVtnaGUImWbzKtwey/qwmGd3YssSNB19g/CSu5Mp1jFr9ouYD6WbzkWVQTTvEuAQl1z1Ahs1JuSlJKl8g/cVL2tXvQOUuuNYcWfEd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7892

SGkgSmFrdWIsDQoNCk9uIDE2LzA4LzI0IDEwOjM1IHBtLCBKYWt1YiBLaWNpbnNraSB3cm90ZToN
Cj4gRVhURVJOQUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRz
IHVubGVzcyB5b3Uga25vdyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiBPbiBNb24sIDEyIEF1
ZyAyMDI0IDE1OjU2OjEwICswNTMwIFBhcnRoaWJhbiBWZWVyYXNvb3JhbiB3cm90ZToNCj4+ICtz
dGF0aWMgdm9pZA0KPj4gK2xhbjg2NXhfZ2V0X2RydmluZm8oc3RydWN0IG5ldF9kZXZpY2UgKm5l
dGRldiwgc3RydWN0IGV0aHRvb2xfZHJ2aW5mbyAqaW5mbykNCj4+ICt7DQo+PiArICAgICBzdHJz
Y3B5KGluZm8tPmRyaXZlciwgRFJWX05BTUUsIHNpemVvZihpbmZvLT5kcml2ZXIpKTsNCj4+ICsg
ICAgIHN0cnNjcHkoaW5mby0+YnVzX2luZm8sIGRldl9uYW1lKG5ldGRldi0+ZGV2LnBhcmVudCks
DQo+PiArICAgICAgICAgICAgIHNpemVvZihpbmZvLT5idXNfaW5mbykpOw0KPj4gK30NCj4+ICsN
Cj4gDQo+IENvdWxkIHlvdSBjaGVjayBpZiBkZWxldGluZyB0aGlzIGZ1bmN0aW9uIGhhcyBhbnkg
ZWZmZWN0Pw0KPiBDb3JlIHNob3VsZCBmaWxsIGluIHRoZSBiYXNpYyBpbmZvIGF1dG9tYXRpY2Fs
bHksIG1vZGVybg0KPiBkcml2ZXJzIHVzdWFsbHkgb25seSBoYXZlIHRvIGZpbGwgaW4gRlcgdmVy
c2lvbiwgaWYgYXQgYWxsLg0KQWggb2ssIHRoYW5rcyBmb3IgdGhlIGluZm8uIEkgdmVyaWZpZWQg
dGhlIG91dHB1dCBvZiAiZXRodG9vbCAtaSANCjxldGhfZGV2aWNlPiIgd2l0aCBhbmQgd2l0aG91
dCBvZiB0aGlzIGZ1bmN0aW9uIGFuZCBhcyB5b3UgbWVudGlvbmVkLCANCmdvdCB0aGUgc2FtZSBy
ZXN1bHQgaW4gYm90aCB0aGUgY2FzZXMuIFNvIEkgd2lsbCByZW1vdmUgdGhpcyBmdW5jdGlvbiBp
biANCnRoZSBuZXh0IHZlcnNpb24uDQo+IA0KPiBJZiB3aXRob3V0IHRoZSBjYWxsYmFjayBldGh0
b29sIC1pIGRvZXNuJ3QgcmVwb3J0IHRoZSByaWdodA0KPiBpbmZvLCBwbGVhc2UgbWFrZSBzdXJl
IFNFVF9ORVRERVZfREVWKCkgZ2V0cyBjYWxsZWQuDQpZZXMsIGl0IGlzIGFscmVhZHkgY2FsbGVk
IGluIHRoZSAib2FfdGM2X2luaXQoKSIgZnVuY3Rpb24gb2YgDQpkcml2ZXJzL25ldC9ldGhlcm5l
dC9vYV90YzYuYyBmaWxlLg0KDQpCZXN0IHJlZ2FyZHMsDQpQYXJ0aGliYW4gVg0KPiANCg0K

