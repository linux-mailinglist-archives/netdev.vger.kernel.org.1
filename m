Return-Path: <netdev+bounces-77062-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49600870013
	for <lists+netdev@lfdr.de>; Mon,  4 Mar 2024 12:15:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6CEC2B220F1
	for <lists+netdev@lfdr.de>; Mon,  4 Mar 2024 11:15:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 671003839F;
	Mon,  4 Mar 2024 11:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="1jlwOGG2";
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="3OWJKfrk"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 621FB37718
	for <netdev@vger.kernel.org>; Mon,  4 Mar 2024 11:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.153.233
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709550928; cv=fail; b=gkBEyX88WQTVHk62Mej+zDPk4ZZxWN1UCCQGRDYnQ8mVAGaoXhOC8uQGLhVuo+K4Czjj+oBi+8lCzLwNuRm6RfNjbncfR2frnR3mlFGZMXbEZu+GO3CqBrChdZZKma5/XL/60IAzFn1jR9R1bBNikebU0iOjcHpiArCpMkp1NkI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709550928; c=relaxed/simple;
	bh=xXw4SGgGKOpnVDxV2c3Fgthobw0rVFcu8qNTQIOv4Og=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=i7kz7NLWiK7KYZpVGruqXrU+5CNX7ToyatYUFBbc9vhrD2fEmkiF6XqAO/XL+nJNhSrpvgFF/VodGmmBz6eXYRyoxKLANjw5m+XN3YhmMV2UWz6mqYVXX2MvnjygUbiOkEo7ctLwCDITnjbdA7kSOyEyK7UZb+2FF11grlonkOY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=1jlwOGG2; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=3OWJKfrk; arc=fail smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1709550925; x=1741086925;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=xXw4SGgGKOpnVDxV2c3Fgthobw0rVFcu8qNTQIOv4Og=;
  b=1jlwOGG2OPfiPlls31GCvktdKodP53bmtTve+H/0gwtTMZEctIDeTpJc
   /U6tmX22C0g24DE1kOZqRSNaKpgZUDOj/eeUPwJKgap9wGvmNCIyShha2
   c6LPTg9GehEvevDkzUgxKNQziTyP5jA0PGdEbIadHW+SvrZ/b1aK8/0aq
   vCeisfk1uRuHKFiWjwcIp5qXbksYqD8gm0dHz+jGkwxOJqd9rpLtvtYkB
   QVDZqvh3OyDoxWnAJKHDXYMJxwRrvqQ/FUq5bk9UJukcXdxYfc/KUtyfV
   eprS249GPacSv+SlyP63O4RvSksRd5meoTlK1BjLH9iJNpA/jY7+1sWMw
   w==;
X-CSE-ConnectionGUID: VtCQAlc6T0692UQXtmwBsg==
X-CSE-MsgGUID: jZ/NdBuUS8SKkNsiDp6zkA==
X-IronPort-AV: E=Sophos;i="6.06,203,1705388400"; 
   d="scan'208";a="18775217"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 Mar 2024 04:15:24 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 4 Mar 2024 04:14:54 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (10.10.215.250)
 by email.microchip.com (10.10.87.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 4 Mar 2024 04:14:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aA4wg0Y7/eWcDS9CveOj23efRKasGAXHYIk8Z4ad7g2PJR4sgVxv42vti58raH8zLqcWAQARoWA4pRhMX2eAY5M1w25Je4GZTjArVVXZRIAlGX+RmdPsRQK8NQ8ozDK5xBclQBbvxSj2dGkK66t09g+0phIPsrnvx2aYGr2ssDgKh1zcTu55XCn/f7fPE4UiZthfUtKdNIEci3LpSGillWo5TG2/AP23UJltvf5m3oYXc/4WIfogAYpq3Di5S07v7cQdTtvwb0ImPrj67xlJvKohWhH0dhazTXi5hTCXgqhBKbzwYbydJKRnBP3cnhd4l0Do5E0B29/dbM3CWH9/Fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xXw4SGgGKOpnVDxV2c3Fgthobw0rVFcu8qNTQIOv4Og=;
 b=dtrTf63I7LCu4Avn2md2cXBhlleKcAy0BGOEC4HwwhrEndU783Tk5BH6cBLQ5G2rC5cxMOy7yKmmeyycFX73y5Nos/6PTz0eZ8nib3zHdV9FAaU0fwzYvKMl7HykgJ9WoyuxDPWJz+c+hMsAEMGsXY4vY0YHHp/GfHkUVJoNRTJn31//eyzeKR1tjbDuBDc4/zapHTDsDEJvKHiMd5qnoCHtX2aTaxsQGNcrM8kJq3VeNjvN7dxhZQeAWSh+Kh5b82bILzBVvP+qevQhyHfuvsuuy7HAD1pAudKwyCibaz5wkH8WV0Esn5VZegipwk5v5WzHa6vAs7knOPEZdgXf7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xXw4SGgGKOpnVDxV2c3Fgthobw0rVFcu8qNTQIOv4Og=;
 b=3OWJKfrkOLhEgByFaIHQN45RODd85fsfPy4hEWC6AowWQg8+cmAoQf1e+gwd9AQMLroJFgu48TI7ZcukwgZ+VCbD+UL/B16iPHNcbyFm4XfxmLsBvoSOj4YyqUhzQ4SmzVDFPukR4q3ZTpC/K+xcsEJJPqmY2CCFZyr9rVUMSgPHvy03UT1avQghWn1qGEcyuxn2+Uowbpt5zZ5HMQ0X1G5nzfgDpT/tEv3/h/Rahvhqweh8ZjNUDCx8qlc4S2B5hk43vfNdN16+gE8Kn7vvNgSVhKgQUKK0QvVbuCojNQR1CIGgqkHz30OR4ZvDE160hpS+ghqyzNmOOC2UFWJbow==
Received: from SA1PR11MB8278.namprd11.prod.outlook.com (2603:10b6:806:25b::19)
 by PH7PR11MB6402.namprd11.prod.outlook.com (2603:10b6:510:1fa::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.22; Mon, 4 Mar
 2024 11:14:51 +0000
Received: from SA1PR11MB8278.namprd11.prod.outlook.com
 ([fe80::f633:b9d4:f539:177d]) by SA1PR11MB8278.namprd11.prod.outlook.com
 ([fe80::f633:b9d4:f539:177d%6]) with mapi id 15.20.7362.019; Mon, 4 Mar 2024
 11:14:50 +0000
From: <Parthiban.Veerasooran@microchip.com>
To: <andrew@lunn.ch>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <Steen.Hegelund@microchip.com>,
	<netdev@vger.kernel.org>, <Horatiu.Vultur@microchip.com>,
	<Woojung.Huh@microchip.com>, <Nicolas.Ferre@microchip.com>,
	<UNGLinuxDriver@microchip.com>, <Thorsten.Kummermehr@microchip.com>,
	<Pier.Beruto@onsemi.com>, <Selvamani.Rajagopal@onsemi.com>,
	<Steen.Hegelund@microchip.com>
Subject: Re: [PATCH net-next v2 0/9] Add support for OPEN Alliance 10BASE-T1x
 MACPHY Serial Interface
Thread-Topic: [PATCH net-next v2 0/9] Add support for OPEN Alliance 10BASE-T1x
 MACPHY Serial Interface
Thread-Index: AQHaBcg0J9X87rlKy0y2G/CzXLB1SbEOPx6AgAPmdICAAE9bgIAVydQA
Date: Mon, 4 Mar 2024 11:14:50 +0000
Message-ID: <04a2e78e-aac4-4638-b096-a2f0a8d3950b@microchip.com>
References: <20231023154649.45931-1-Parthiban.Veerasooran@microchip.com>
 <1e6c9bf1-2c36-4574-bd52-5b88c48eb959@lunn.ch>
 <5e85c427-2f36-44cc-b022-a55ec8c2d1bd@microchip.com>
 <e819bb00-f046-4f19-af83-2529f2141fa6@lunn.ch>
In-Reply-To: <e819bb00-f046-4f19-af83-2529f2141fa6@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR11MB8278:EE_|PH7PR11MB6402:EE_
x-ms-office365-filtering-correlation-id: 1d95c32c-2d73-4421-54c3-08dc3c3c4f7e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: O+u0MBnCsUZ6Q2/EJ5Xszzj+IyAajPF5c+AHBxFood1Jj/42gefQPJMKvKSwx+8ZgnHUwvuICsxNZV6nNj2IIDLUIYX5MS42TtpR2UY93KfFsPYlXrFcIUXraAE4H5cLJG3KwdOo84HGzLIuVWzlqHCc55ECPx3OE2ElLIXqf5WAFNlB9/VGY57uuJIfwBKCa6SzPLRBflRpyw6/3iw9LIhHzTv3O6LDzdxSdrDvj/4ytNDV9xLEFo0xXCXbWtmmoupzsVbgu4SJQD79az+XobsKgt19M1bngyw0dJty8S7OXAG5L8CKW/ZpfiE35eDnzEGZX1W/wsBGCH2RltsUcvvRQ0wwwya4QoZ3fKm/FjSIoJu7/Y/4Zp8fG9oE0IPUoFHXB1CgVOb7YN7lyku78yHnc/9TlXz8miBrYGMplNpEfmsZv6EmLiZ7UzovOhZTtNS2PkUJ6aiWsx1bGGbKufvTNZXFXtyiICfOeH7ymZX1geYidmw5uugM83RnMhn9an2MNLUEc2fdhYGJRIKdQZ40FxPJ/R4ViHkTExSw8+iHKvkZoHw+aodlomegSQin/PBDnYArY/kuhtT9LiPoagi4aCnK/+s1PfCnO+9DAEWCiL4DzH6188DzNbHx9/ddKiFUt6e1DtKGvS9MXp8sgPhr5FLyrX1UVuhOcpXwPYrEjOLW1OxIYlQenkW+jkBnOpO2uHaIXxkoPtK08GzQIOhs/PNosY/tYtzWaxcgAq4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB8278.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MG5OS1NnYUlYNDkwR05TYURTV0RnUGVtRlVzOHFVQTBGT3FTbjQwSlp0T2po?=
 =?utf-8?B?Qjh3UzIzelNMZXA1QlVSZnRHZlZPdkpzb3ZnVy8zdjV3SklZdVlJeERSb0pr?=
 =?utf-8?B?TU1QbXBzY1hXRFI1N0hFV2JqMjRKRjBKV1ZTOW1oS0dpa01iOVV0M3VnaTFp?=
 =?utf-8?B?VnZTYlNJZWp6YlR5V1FCdG10S2paaG81bDJqaVA5dkhsL0NNWWduYkcwaFc5?=
 =?utf-8?B?RzJ6MVhPU0lwamozYUhmVTRnaXlacWhFSU1yTVV2VWhmdmhockNsVU9UZjQw?=
 =?utf-8?B?TmhLN1I2d3AxTnVob3psWkMvUkdZdVRidm95dUxjb3VoY2tJYkFrVGVHcGlw?=
 =?utf-8?B?bWNSYk1VY2Y3QXNxUEdzQVYxVTRHdERkc2RpWkR6RDJrVGQ4cDY3dzR3V245?=
 =?utf-8?B?VFFYRitmQnhuZEtFL1FtR1VEaXpZMms0T3VTYmh2VS93ZHNDaktadEV2N2hZ?=
 =?utf-8?B?Q3VwU2JEaUFjbzNHcXFsbjkwVkNEOWRJVGZaZ3c5Yy9uOTB3aWh3Ymo5SlFt?=
 =?utf-8?B?em5WY1VIekJOK2FER0xaUmpxZ1FKRzc4TjBjOHFtR1ZTWUEzclJYTUljTC90?=
 =?utf-8?B?cjJreWhpYVVwZWVoOTF2UkRkbTN2ZlhFWVpwM0RZQ1NMZWNQTzJobE9yVTlH?=
 =?utf-8?B?aHZ2OUJPejlwbEUxM1ZyRWN1d28wOXR4Y1FXUHV5NlI4OHM1VUVVb2xxMWVL?=
 =?utf-8?B?ejkwOUI2eFA5OHU0R251RTNCKzc4RTZwcm1pcnVob3ZhTENna0svOGExMmNL?=
 =?utf-8?B?M3EzeFBpUXBVTDBPb0JLQXRmWHFZT1c0VklPYytQTlBSQkRpakpaTElJd2ZP?=
 =?utf-8?B?U0t3ZDdrYnk3cHhqd2dpWmM3Um9pT2ZkR0wwdCtKWlVHSFo4NU5ESFhvZVky?=
 =?utf-8?B?NTBoRFFnQTQ1dkY2aXo2cHVqYUFOK0R0Z1NWaUpzcWdIdXc1czVBOW9NN0VU?=
 =?utf-8?B?cWQ4TmZEVUVoWHJ4bmZWY3FBbjlzemR0aytuU0psWFNpUXI3UmE5TGZkdmJS?=
 =?utf-8?B?MWEyUkZ4NUdCQTBuRHB0Y1FRTExwenNpUTU0VDJLelY4VnZFZURuNlhOYis4?=
 =?utf-8?B?UjBhZGtObGUwQjh6TGpMSkhpYlROU2tHVWlmUVVaTFJrcFoyT2tQWWtxNyti?=
 =?utf-8?B?RUFicFdxQkF0UkNqY2wvVkYrUkpjcExuRktIVjEvTWVxZXhVVldZNS9HaUd5?=
 =?utf-8?B?Z3hVbk0rQmJoSnpERXd1ZU1UcHo4QjVLMzd4b2RIbDZ5bmZvV1lHdFZ5Szdl?=
 =?utf-8?B?dVFpRjAxeis0MHhGYTJCZlVKaVRyeXZpYmhXb3R1dHZsdWhzMmM4cG5Mb2ZR?=
 =?utf-8?B?K24vaTJrTCt1bFBoMC95dDd0ajUzZjBzWFlXWEUwOHZrQU9KS2N0aVBXYXVr?=
 =?utf-8?B?ZHBYL1lpYitnK2ZCemhCVkJhdnRnQ2V2dzhJczRVYnBzRzVlOWpUcTljNDJV?=
 =?utf-8?B?YWFDTEVVYS9CQXJ3NHR1eGNTVlhXU2tSL3ZXK3I0djVQK1FFZmcreE5DYzNn?=
 =?utf-8?B?Kzd0MFV3eU9STzlKbCs1ZTJxMHRJeHFYUnFqYnd5d0d3V1hXTjhqZERGOGF0?=
 =?utf-8?B?U1JiRmdDZFp0OXI5V3E3eWZlcS9URU5KV1Y5ZzZCVWVQMk92V0tiMFdYd3FU?=
 =?utf-8?B?djhydlRJMzA2WGtkemI3VUk4bjVRNHRpK1VFTnhSdElnMHNMbEljcGNPaVlj?=
 =?utf-8?B?ZEV6T212WkhzaXJUTk1oUC94WFZLODBxNzdoWkJib25SQkRYOHlBQUxGZkwx?=
 =?utf-8?B?aFNVbitFL25lVDVUNUp5Vk1kcVJiSExBUkdLWVhPbC9XR2hCK0t6bDdwbVJ6?=
 =?utf-8?B?dnJNdzJVYWdxenNMUXBPb1VDcTlFV0UySmF6YVZRRGNsTzh6WGtQNVJQYXlz?=
 =?utf-8?B?WmhEeDVjdnEzUmlMMUxXRzJkZ3FEZllVa3B4czVBT2IyclBIU2RvTU9PSDlx?=
 =?utf-8?B?QWl3dUJ1WUpPbkJ3Z0hma2pyWmJhL2tHazdwT2Mwdk9xVlFab3VZWkxDcEhO?=
 =?utf-8?B?NzNneTFmOUJ0YzZDTXY0ZmtYL3Q5Qi9jYll6TUx1ZWRRanMvb2xrb0ZWWFRQ?=
 =?utf-8?B?V1NNWVZLbjMxUmRNdHpDL3hwZjgvUVhDUm9sZkpNMGFGanVPZTlIemhBaStz?=
 =?utf-8?B?MEdTeUs2K2paUUZNMVVLNHY4NWhiQVdqQUdSVEdVa29adlN2V1FmdHk3bGxP?=
 =?utf-8?B?dEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7072A9219898714CAE937D8641046B29@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB8278.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d95c32c-2d73-4421-54c3-08dc3c3c4f7e
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Mar 2024 11:14:50.9105
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: V8ZnEEE8eApu6LrisCRLZwaX591awaje8l+BUpDcER0AV6VnGRJQeC4+pBVlp/0ZHb22BB3RdNdDQ+do+9dFPedEXKQD3OTC+09NHCdgC3YOYMor/po0e8N5CVQASv+I
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6402

T24gMTkvMDIvMjQgODowMCBwbSwgQW5kcmV3IEx1bm4gd3JvdGU6DQo+IEVYVEVSTkFMIEVNQUlM
OiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3MgeW91IGtub3cg
dGhlIGNvbnRlbnQgaXMgc2FmZQ0KPiANCj4+IEhpIEFuZHJldywNCj4+DQo+PiAgIEZyb20gTWlj
cm9jaGlwIHNpZGUsIHdlIGhhdmVuJ3Qgc3RvcHBlZC9wb3N0cG9uZWQgdGhpcyBmcmFtZXdvcmsN
Cj4+IGRldmVsb3BtZW50LiBXZSBhcmUgYWxyZWFkeSB3b3JraW5nIG9uIGl0LiBJdCBpcyBpbiB0
aGUgZmluYWwgc3RhZ2Ugbm93Lg0KPj4gV2UgYXJlIGRvaW5nIGludGVybmFsIHJldmlld3Mgcmln
aHQgbm93IGFuZCB3ZSBleHBlY3QgdGhhdCBpbiAzIHdlZWtzDQo+PiB0aW1lIGZyYW1lIGluIHRo
ZSBtYWlubGluZSBhZ2Fpbi4gV2Ugd2lsbCBzZW5kIGEgbmV3IHZlcnNpb24gKHYzKSBvZg0KPj4g
dGhpcyBwYXRjaCBzZXJpZXMgc29vbi4NCj4gDQo+IEhpIFBhcnRoaWJhbg0KPiANCj4gSXQgaXMg
Z29vZCB0byBoZXJlIHlvdSBhcmUgc3RpbGwgd29ya2luZyBvbiBpdC4NCj4gDQo+IEEgaGF2ZSBh
IGZldyBjb21tZW50cyBhYm91dCBob3cgTGludXggbWFpbmxpbmUgd29ya3MuIEl0IHRlbmRzIHRv
IGJlDQo+IHZlcnkgaXRlcmF0aXZlLiBDeWNsZXMgdGVuZCB0byBiZSBmYXN0LiBZb3Ugd2lsbCBw
cm9iYWJseSBnZXQgcmV2aWV3DQo+IGNvbW1lbnRzIHdpdGhpbiBhIGNvdXBsZSBvZiBkYXlzIG9m
IHBvc3RpbmcgY29kZS4gWW91IG9mdGVuIHNlZQ0KPiBkZXZlbG9wZXJzIHBvc3RpbmcgYSBuZXcg
dmVyc2lvbiB3aXRoaW4gYSBmZXcgZGF5cywgbWF5YmUgYSB3ZWVrLiBJZg0KPiByZXZpZXdlcnMg
aGF2ZSBhc2tlZCBmb3IgbGFyZ2UgY2hhbmdlcywgaXQgY2FuIHRha2UgbG9uZ2VyLCBidXQNCj4g
Z2VuZXJhbCwgdGhlIGN5Y2xlcyBhcmUgc2hvcnQuDQo+IA0KPiBXaGVuIHlvdSBzYXkgeW91IG5l
ZWQgdGhyZWUgd2Vla3MgZm9yIGludGVybmFsIHJldmlldywgdGhhdCB0byBtZQ0KPiBzZWVtcyB2
ZXJ5IHNsb3cuIElzIGl0IHNvIGhhcmQgdG8gZ2V0IGFjY2VzcyB0byBpbnRlcm5hbCByZXZpZXdl
cnM/IERvDQo+IHlvdSBoYXZlIGEgdmVyeSBmb3JtYWwgcmV2aWV3IHByb2Nlc3M/IE1vcmUgd2F0
ZXJmYWxsIHRoYW4gaXRlcmF0aXZlDQo+IGRldmVsb3BtZW50PyBJIHdvdWxkIHN1Z2dlc3QgeW91
IHRyeSB0byBrZWVwIHlvdXIgaW50ZXJuYWwgcmV2aWV3cw0KPiBmYXN0IGFuZCBsb3cgb3Zlcmhl
YWQsIGJlY2F1c2UgeW91IHdpbGwgYmUgZG9pbmcgaXQgbG90cyBvZiB0aW1lcyBhcw0KPiB3ZSBp
dGVyYXRlIHRoZSBmcmFtZXdvcmsuDQo+IA0KPiAgICAgICAgICBBbmRyZXcNCj4gDQpIaSBBbmRy
ZXcsDQoNCkdvb2QgZGF5Li4uIQ0KDQpGaW5hbGx5IHdlIGhhdmUgY29tcGxldGVkIHRoZSB2MyBw
YXRjaCBzZXJpZXMgcHJlcGFyYXRpb24gYW5kIHBsYW5uaW5nIA0KdG8gcG9zdCBpdCBpbiB0aGUg
bWFpbmxpbmUgaW4gdGhlIG5leHQgZGF5cy4gRllJLCBuZXh0IHdlZWsgKGZyb20gMTF0aCANCnRv
IDE1dGggTWFyY2gpIEkgd2lsbCBiZSBvdXQgb2Ygb2ZmaWNlIGFuZCB3aWxsIG5vdCBoYXZlIGFj
Y2VzcyB0byANCmVtYWlscy4gQWdhaW4gd2lsbCBiZSBiYWNrIHRvIHdvcmsgb24gMTh0aCBNYXJj
aC4gV291bGQgaXQgYmUgb2sgZm9yIHlvdSANCnRvIHBvc3QgdGhlIHBhdGNoIHNlcmllcyB0aGlz
IHdlZWsgb3Igc2hhbGwgSSBwb3N0IGl0IG9uIE1hcmNoIDE4dGg/IGFzIA0KSSB3aWxsIG5vdCBi
ZSBhYmxlIHRvIHJlcGx5IHRvIHRoZSBjb21tZW50cyBpbW1lZGlhdGVseS4gQ291bGQgeW91IA0K
cGxlYXNlIHByb3ZpZGUgeW91ciBzdWdnZXN0aW9uIG9uIHRoaXM/DQoNCkJlc3QgcmVnYXJkcywN
ClBhcnRoaWJhbiBWDQo=

