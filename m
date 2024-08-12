Return-Path: <netdev+bounces-117734-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3128B94EF92
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 16:30:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A7AAE1F22F9B
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 14:30:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E81EC17DE16;
	Mon, 12 Aug 2024 14:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="Bnk1tryA";
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="r4HI4eJo"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1213914C5A4;
	Mon, 12 Aug 2024 14:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.153.233
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723473027; cv=fail; b=mcHg1l0eIE+XypCVR93Ct6HdxQj0KtgrRbc6j1AoMHUT472/qmP4+DBoh/WjOPx2N8nqJdKg8YmOCcHGztMOOqtqcibH/UsP1WqKfin8TGItRc9qnZ2jwdQtH4FJJFc+GEnCDixhLVyWbaGCxOs0lrCRdxMZGsiJJUsQ7f1nWnc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723473027; c=relaxed/simple;
	bh=qX7geWc0H8TKsevn8/SNZMDI0cSVjB4Wort9ebkeMUw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=kLY98RW7IKT6Xmy636zu4ZC98AsGqWzgBw95mqD93BKlbemZEJBrjFRnTQ0XyYDljvKuoucxySW0nlcvThVHoS6qQ2DeEyqxp8NugFgF1xv6PvxrCbiW0Ky8JxnycGOTRUWav5C7sbY7ENa+m17yPoWguK4TwiXnBYXsDrj2Bdc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=Bnk1tryA; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=r4HI4eJo; arc=fail smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1723473026; x=1755009026;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=qX7geWc0H8TKsevn8/SNZMDI0cSVjB4Wort9ebkeMUw=;
  b=Bnk1tryA2WiBGRYCKNHNCF+2ayinMIHe77svdK3+CPLibblGZ13dxIO8
   Y7MJri26AAeoKBNjbsioKPHdTTk2OgOXrTC7H2YwMJVySGttJh7VjNoc2
   /W7l8kELTNiGf+BL6tpiq1xonR+XjL+3gJT8IG2mmIyRGTDybXc6Jjx+k
   ETG5mFO7pQde8Pfz4n1cOqfvZRSP54Dpj9lb7A8+gaORDt7jLFopx30Jm
   APCOQ+cv7FPZR20aBdOUXutUHYk+qqSQWCIh/d9vuqugxcReOOGQj6lym
   nqOsGwWGvdK12sSifRaVdCg1pEn6o8xNqULszdLiCzDuyPLS3NegiegIG
   g==;
X-CSE-ConnectionGUID: wjIoYyLYSDaIj0uP6tEoLg==
X-CSE-MsgGUID: O716vnrqQ2Wyy/yKuTPYUg==
X-IronPort-AV: E=Sophos;i="6.09,283,1716274800"; 
   d="scan'208";a="30390249"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 12 Aug 2024 07:30:24 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 12 Aug 2024 07:29:53 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (10.10.215.250)
 by email.microchip.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 12 Aug 2024 07:29:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=erG+JXDbhgD3I0pjZWF90lzYRW3mje7UlFEYK/ACVLPS/R04ISXVay+Qmn11esaynRvQ90myx8IHWN/TM371GsHfbzW/CngXctT4avxsCTw4t7BkEPoFqT7d/zucBMSzYZ6ytLUv4niboLh1LBqSk9LEqhFuZJKleXaU3NMBnxApuZEdpSyMDcjvBckm4z/hKwvuVq1CTsI07G6gXEhMuUw6Hp31TV78nVPSlHeeeFrEol0xbOpH1JTROcFxPjXuWkmmWOdKfLSZezOXcVIqXqByRKgR5dbGBjR9qFm5fTFsSH2vygRkXa66O08mHgTowQK1uX04fh0m+1R6g5h6pA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qX7geWc0H8TKsevn8/SNZMDI0cSVjB4Wort9ebkeMUw=;
 b=hcaFqlBKEbKOrhHRCIHNlwSQwoAeJmZZpqK3p9KcmkpQG4MgQSmKzjZSlptRte//Ud19UNiILN4Ei1zzuB+hBItyDORGtRu2xnMCfhc2Ij6M93GGgr+59nAKDhOMWAkP5ErOQ4Kqlo9gEWy5g2OGqLcs+SkJ7uzPQqcNfsL8egHyj7Cc8qhuQb5TI1OYNsKMdXpWBI7bdpYltxfcRNXF4tvjUn2PeUbHlczHQwdVQv/SALxTBVHGZwP4+rnEkOPGx6s487q0AREtt6Fsfo487vUAZMiu+HHeB7N88wx4i96hdcjxX3aA4ltsktEsBKt6Aj4OTdr/DP1rwai7478CkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qX7geWc0H8TKsevn8/SNZMDI0cSVjB4Wort9ebkeMUw=;
 b=r4HI4eJoq8CYrqbWLORaI6N69yCvkYL6A0+kCW3MgZTGQyDkgU0PiDWCWn66pcINY75YHhpb1PcU4MXvYYVKpb178PxCynnUbdDbXEb61H+4tsaMk8rUpslJ77g1r6FhKh975klsUAHxlpanVlSNYmba4lG/1sj9QW9sXHsMHW5A0Z7NeeJhzvwyAXIPtUk2Uo9mI0h/J4G4RhU3QYJfCVIiMHtlISDHZTp/FVV34dSDs8FhgWuBcUxtnsmCH15OyDrrJKPGEIC/PTFyYPWrfHVnAMQbMSs6iKcO6ZOaUc3AbgXzcE7qUl3AxaKcSZRg9vsNSV6+VGIsoH8sKi5XVA==
Received: from PH7PR11MB8033.namprd11.prod.outlook.com (2603:10b6:510:246::12)
 by SJ0PR11MB5165.namprd11.prod.outlook.com (2603:10b6:a03:2ad::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.27; Mon, 12 Aug
 2024 14:29:50 +0000
Received: from PH7PR11MB8033.namprd11.prod.outlook.com
 ([fe80::22a1:16dd:eea9:330c]) by PH7PR11MB8033.namprd11.prod.outlook.com
 ([fe80::22a1:16dd:eea9:330c%6]) with mapi id 15.20.7828.023; Mon, 12 Aug 2024
 14:29:49 +0000
From: <Arun.Ramadoss@microchip.com>
To: <vtpieter@gmail.com>
CC: <andrew@lunn.ch>, <olteanv@gmail.com>, <robh@kernel.org>,
	<Woojung.Huh@microchip.com>, <pieter.van.trappen@cern.ch>,
	<davem@davemloft.net>, <marex@denx.de>, <conor+dt@kernel.org>,
	<edumazet@google.com>, <UNGLinuxDriver@microchip.com>,
	<devicetree@vger.kernel.org>, <linux@armlinux.org.uk>,
	<linux-kernel@vger.kernel.org>, <pabeni@redhat.com>, <krzk+dt@kernel.org>,
	<kuba@kernel.org>, <netdev@vger.kernel.org>, <f.fainelli@gmail.com>
Subject: Re: [PATCH net-next v4 5/5] net: dsa: microchip: apply KSZ87xx family
 fixes wrt datasheet
Thread-Topic: [PATCH net-next v4 5/5] net: dsa: microchip: apply KSZ87xx
 family fixes wrt datasheet
Thread-Index: AQHa7JTUj0lWJtr2M0OrmoRoNPOKzrIjcRwAgAAB+oCAADyIAA==
Date: Mon, 12 Aug 2024 14:29:49 +0000
Message-ID: <039c9a99c890472bea5ca4e4a8abc0830fe7b607.camel@microchip.com>
References: <20240812084945.578993-1-vtpieter@gmail.com>
	 <20240812084945.578993-6-vtpieter@gmail.com>
	 <e93d13b451a263470e93706faa3afbfe2b5cd57b.camel@microchip.com>
	 <CAHvy4Aq8G2vLzFCCRRQV5kCD4jp8oYW+c=m_foyHXKoeiCod5A@mail.gmail.com>
In-Reply-To: <CAHvy4Aq8G2vLzFCCRRQV5kCD4jp8oYW+c=m_foyHXKoeiCod5A@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.36.5-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB8033:EE_|SJ0PR11MB5165:EE_
x-ms-office365-filtering-correlation-id: 271e0b34-45cb-4094-fade-08dcbadb3907
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB8033.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|7416014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?cU1Obk5qd2JVZHFIREs1ZFo5T3gwVVJuTVdHempGTU5Pcy9ndFNYRTJ2WkQv?=
 =?utf-8?B?VXlweC9GMHI2UE9BOUwwOW1XOWNKY1E4RVF3NHRUTU5kV0lrNGplc3Q4T3RL?=
 =?utf-8?B?bWo4RWxuWU1oVUcwbjZoSkRPbWRhaEp2YkovejhyUGNxQnNvdHcrT3dxRy9w?=
 =?utf-8?B?NW8yT0VtZnJyaUFTazhXdTU0eFdNQk0yK1BWemxYcHVIc2pKOFVINGNXczRr?=
 =?utf-8?B?akhzSWFQWHFUa1FCQjlqY0xidEFTY281SGFCUjd5WWdhaENQNTlqbVdHS2tL?=
 =?utf-8?B?bUowRnFxWWkrZ0JxNiszdWk4dDhVUklrWGlsYzZUS2xFNVh3TVVaQ3RJT01D?=
 =?utf-8?B?dEVsOW9VT2pYMlVVckU0NHNFTkxvL01HZmhkTFlhSHcxekR2eG9UUmFMYjlu?=
 =?utf-8?B?MHdWd3lrZUlUTGVxODQ0YXFBWmhleEVqamh5MkFzbmFSV016aGYreFYySHVh?=
 =?utf-8?B?VVl1RkljYkFadFJaYkhtQ21TeWRrTS9NYWRlcDlSUkNDVG41OFdFQ1I3dGlr?=
 =?utf-8?B?L1ZEZllUelZRcjd0amJNNEVESDN6N2VBcnBkVDNNd0ZzY25GTjJ5bC9QMi8y?=
 =?utf-8?B?cjZXVnJmM0VTN2JyS1ZYd01IaGdLUU9ZRmYrVm1sdzBUVTFpN0dTdGVEVW5J?=
 =?utf-8?B?aTVscjBRVXIwemxremhlSzlIbWk0OCtNc29WRzRmZEt5UVpEeGdWTHZpU3Bx?=
 =?utf-8?B?d3NpckF2N1o5Q2pxc2krZEFLQURhbEUwbzVmemMybFpyRlBxeXh2N1ZYbVpE?=
 =?utf-8?B?UmZOVjl4dHNUeUFlalhsbXF4RklDOXZ6NENHUlVNT1RwWCt6SzZWaU9nMEdY?=
 =?utf-8?B?aGJUeXo2VlBpS0pQSHJmQjNrNW5OWGNURHZtdXIyTkErUlZIdS9PVm9zUUgz?=
 =?utf-8?B?V0ZhRGVEMFRTSXgzOGNiZFBCNjNERFZ6MEJJa1N5VGRoN3UyVTFIVlNWc01D?=
 =?utf-8?B?NVY1NFJqQzZCRkpONllsYXd1UDdnYVhhSTRhU2pycWF0N2FVZ0orVjZIZDBy?=
 =?utf-8?B?Y0lncmRFSHpHUkwrLzdHK1E4bjN5UWoxZzR6TkNaZU1CMmFOU1hSVnJ6UFlk?=
 =?utf-8?B?bWFyK3FGNnhzcnZFNkdHK0JSQkhldXVjdXhMWnhSQUkyMGFuVlZyOWk4NDN5?=
 =?utf-8?B?MjZHbUxtRzgwd0t1RmtFb3NkWjNSUDc3b0cwU0xmNXRmQktQVzNyMnU1VlVJ?=
 =?utf-8?B?YStlOXBtNy9Eb2R4MEN0RUQ0MnpyQk01SU5Ncm1LTHlFOHU5VjRyS3d4RVQz?=
 =?utf-8?B?TkhuN1dFbzdHdGw4TWR2VnA5L2hKTElaQ3pPdnZseElGWTlIWnhPRVd5MEZE?=
 =?utf-8?B?Q2d6RVJWNU1MSUV5MXhDOUNPR051TDJJYVZaVEczcjdKWWNwZUM5bVMyZUI2?=
 =?utf-8?B?aVBUcTQ1RnV4UDc4WVRYem02NXZBenZJOUFITjNOeVpsYVNzYXBla2VVT2k1?=
 =?utf-8?B?ZGFLSy9YVXJpOUdYK21DVVBxYkNEM3dIWDkwVi9hdG9vUVo4b09kWW40eUR0?=
 =?utf-8?B?dkhtbG9aTUhqcjFuWVFUbkhuRkdzRGZNSGxCaVRLT0o2dlVGeTRVQlpSYUFs?=
 =?utf-8?B?bGdJK1ZLNE9FaFRBRDZCZktqV1VmdzU2YjRlTG1YYklNSHhwb0tySkhnRnB1?=
 =?utf-8?B?MTFQZ3VPeVQ3cUdEdmNUTlFsS2FoTldnbUREODA0dnBJWG43ZDFRV09iTTVa?=
 =?utf-8?B?YU01OWZlamtzc2o5NWZxKzdHc1k2TEJlRmpiVVE5Z3FldTBQT0oyZldCK2k3?=
 =?utf-8?B?eWZxUWhraVVHdkI1aW5UNTJlOTd2V3VHeE5CQ2pvWGI0SnBWR2pveW9jcDZF?=
 =?utf-8?B?dDhqd1AxKzJPeGhHaTA5UTdjSXdsQ3VtTnc4ODF5THZYTjFnQjBQU1ZSK3Yr?=
 =?utf-8?B?UWNxcTBTVUdHT3czRDRwNmJIUXpGQVlMalJwM2NTMjVIU0E9PQ==?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VUU4TzlTTjNramRkMEV2Vk90c3FuQlRyK0xrM3BCMmlSeVBibDVoUFlvcHRo?=
 =?utf-8?B?QmlpVFFvZEtNZzZFV1ZVdmN6eUxYM0ZBL2k1REpQNDFhOVNNQjNJOGlTbGtI?=
 =?utf-8?B?Q0JHY2xVcEM4ZUNpaGJNRjdMRlZCK2VzMWpESTRDcmpMb0w3U2l1elkvRE1J?=
 =?utf-8?B?RXpBOHNWMm5Xdy9xamU0OTNvb3l2Mi9jdktXNU9idnhaUXdpVHNxY25KdGFq?=
 =?utf-8?B?UkVtcFRwY21LNWxjMmhiWENSMzJ0b1d1UGVKNXZIUG9WeFcvT0pBRkZWcEFH?=
 =?utf-8?B?d3Mza3pxdExJc2x1c0dkRTZBSDBNSzFwRldkSXlTTTJXdU50TEtobU1IZmxX?=
 =?utf-8?B?VTNyS2tQbCtERjNSOGJBRXVKSjEzQStXRXFmZFd0ZE9ZZURrSnZOVkZqZnlW?=
 =?utf-8?B?dWp4aVdRZldvYUVRcnlXaE8ra0ZzeVcxN3FnVnNjUU1MRWJVYm9FQmczdk0w?=
 =?utf-8?B?aU9jd1JESmQ5QjlUM3QwZ25rUjBVRk5aazJLUHQ2RlBuU01EK2IxMjJCdjRw?=
 =?utf-8?B?K0hSbi9IeGdlZmtGTzF1c3BvZFJrWUNLTE04cUpLd1FkV0dLeVhaT1d0aGVv?=
 =?utf-8?B?SzBEam1pbnBrVmtUTUtJcXBOdEw1L2pmd3plb002UDZVSjFOY3cvUTRmQUJY?=
 =?utf-8?B?bnRsSU0veWpxWkFTWUJhYjh1SjltTE9aK3R6NVU0WUtUa01KRnNCV0QrQ1R0?=
 =?utf-8?B?WUN3d3dBZ1BNTjJaZlR4cnpLcEIzY0hZSXd6OTZmRCs4aTJCQTdwWVdPcjM3?=
 =?utf-8?B?cXU4WmZ4UFZDT0t2VVpZVzkrOWlCaUhEalRhYzgvTVFNUjYrQSt4OXYrbXlQ?=
 =?utf-8?B?amQyQjFjN0s4MkRTVWZRRlZ3U1lqWmZoL3JHbDgzTWZhL2VQV01RT2E0eFZH?=
 =?utf-8?B?b0RIbVJiY3lvTUJ2N2p3V1FoYXRwUXdKcjhnMHV3d3RpRXJUalVmVjVnUkwz?=
 =?utf-8?B?RVY2ME5MWjBXVWowamw2RTZUSkovb2E3QnpoVjNKSTZPbWlhZnNkMldzNXpu?=
 =?utf-8?B?QjFiaXhTZzRkL1FMVWdFRW4vY2NjRFNqbFpzVk1TYmhIMmFVVlJDbDZSdUNa?=
 =?utf-8?B?dURpb2ZqNEh1RjB4U0ZzRkxCVkRVcityYXlhWWxtL1VkOWh2Yzd3U3d4a0oz?=
 =?utf-8?B?cUVqSk1wVk9EZGxsbWJQWTZpOW9hZ2xxQ3l1aXFYVnd2SWhFbjcxeFFEOFlx?=
 =?utf-8?B?UG5raW10SGFobVZqbEQyT1pjdm1Gai92eUoycUFNNSs3MlBmM1k0enV1cStu?=
 =?utf-8?B?WW5zSExpSEg0eG5qK3RiYkpJTTRUdXRyODZ3akt2bk8vMUJuQ0dtMXFYVTZB?=
 =?utf-8?B?cmQrTWo5UWFkVkk1Q1dmU284OUVaWEF3VitwUSt3eXBBRml0UE0zUDg0Ui95?=
 =?utf-8?B?UC9UWGs1dGZITjNWUUFlM0NtQWVZSjR6TkRTOUtCVW5JNExMUER5Nk5NUkU0?=
 =?utf-8?B?K3Y1OUJGd09YY25mK2JoS0ZLMG1zaHpzc2ZxeHNYT3VZbzJray9UcndvMDVv?=
 =?utf-8?B?WTY2clJzeWJyK3FFSkJpdzBqaUJqTU1NbGgxT05UYVYwVVk0VkJ4SSs5WStV?=
 =?utf-8?B?eUZpSUIxZHpBR0o5MzRQSGh6YktHUXFJQk9wdGdaTlVjbjlsVjBVbVZObytI?=
 =?utf-8?B?cE0yRTc5bk5Lc0hrWkZsQzRkaDRxaDJNYjczbjVXRVlLSHNoRzJzVjRIeVB0?=
 =?utf-8?B?U0o4S2l2VE41ckwvQmRyNzArRFlRaHRtR3JTMlJrazQxR1p5MXBESnNacXNt?=
 =?utf-8?B?YTlmMjFqWFRZaGkvanJPeTV4NDE0clYycXZOa1ZHTlJmYnJzTStCRUZzZENJ?=
 =?utf-8?B?aUQyMnYrcUoxRnF1SE1OaWZlRU5WdGluZjhlalIyK1lEVHNZMnJtcy9WVUkr?=
 =?utf-8?B?UkEwUjFuYWVMYVdLdjNSbURJQ2doU095SHk3elE5L0d0cWp1d2U1ckpOTzZJ?=
 =?utf-8?B?OVJNaG81aXdVb3FCbVBMNXRKSnI2L2p4M3lCbDdXOHpsL2doanpaWldFTmRD?=
 =?utf-8?B?QUpyWmxwdUFMY01QT0haaDZuM0tPcUIzNDJKVFhRRUtUTXZHYWp1Y1Jta2tn?=
 =?utf-8?B?NURKRUlac0lUVnNTSnlmVUJ4LzBrT3JWaEQ4dzYzdkxLUFovL1NodFp3OWdm?=
 =?utf-8?B?V1RRMjFtM1JqNVYreGk4R0toRzRoRHlaZTZDYXJyOFI0RVVhVnlRcFd2QW1x?=
 =?utf-8?B?WHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B9760D18CD2A7F459AE8C1DB04CAA7A5@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB8033.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 271e0b34-45cb-4094-fade-08dcbadb3907
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Aug 2024 14:29:49.6711
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qxajucjnf4Cdqb39sFzOl+NTqqyMZi2JzWOqUu+37qr1SaZxVUUm2iaeY1zCMHlK5L66w+lkXReNJ6PXkOCp2oYPaFFZDgbxEEQAbU4LrLc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5165

T24gTW9uLCAyMDI0LTA4LTEyIGF0IDEyOjU1ICswMjAwLCBQaWV0ZXIgd3JvdGU6DQo+IEVYVEVS
TkFMIEVNQUlMOiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3Mg
eW91DQo+IGtub3cgdGhlIGNvbnRlbnQgaXMgc2FmZQ0KPiANCj4gSGkgQXJ1biwNCj4gDQo+ID4g
QEAgLTE0MSw3ICsxNDEsNyBAQCBzdGF0aWMgc3RydWN0IHNrX2J1ZmYgKmtzejg3OTVfcmN2KHN0
cnVjdA0KPiA+IHNrX2J1ZmYNCj4gPiA+ICpza2IsIHN0cnVjdCBuZXRfZGV2aWNlICpkZXYpDQo+
ID4gPiAgew0KPiA+ID4gICAgICAgICB1OCAqdGFnID0gc2tiX3RhaWxfcG9pbnRlcihza2IpIC0g
S1NaX0VHUkVTU19UQUdfTEVOOw0KPiA+ID4gDQo+ID4gPiAtICAgICAgIHJldHVybiBrc3pfY29t
bW9uX3Jjdihza2IsIGRldiwgdGFnWzBdICYgNywNCj4gPiA+IEtTWl9FR1JFU1NfVEFHX0xFTik7
DQo+ID4gPiArICAgICAgIHJldHVybiBrc3pfY29tbW9uX3Jjdihza2IsIGRldiwgdGFnWzBdICYg
MywNCj4gPiA+IEtTWl9FR1JFU1NfVEFHX0xFTik7DQo+ID4gPiAgfQ0KPiA+IA0KPiA+IFRoaXMg
Y2hhbmdlIGNhbiBiZSBzZXBhcmF0ZSBwYXRjaC4gc2luY2UgaXQgaXMgbm90IHJlbGF0ZWQgdG8N
Cj4gPiBrc3o4N3h4X2Rldl9vcHMgc3RydWN0dXJlLiBJcyBpdCBhIGZpeCBvciBqdXN0IGdvb2Qg
dG8gaGF2ZSBvbmUuIElmDQo+ID4gaXQNCj4gPiBpcyBhIGZpeCB0aGVuIGl0IHNob3VsZCBiZSBw
b2ludCB0byBuZXQgdHJlZS4NCj4gPiANCj4gDQo+IEl0J3MgYSBmaXggd3J0IHRvIGRhdGFzaGVl
dCBidXQgaW4gcmVhbGl0eSBJIGNhbiBzZWUgZnJvbSB0ZXN0cyB3aXRoDQo+IGEgS1NaODc5NCB0
aGF0IGJpdCAyIGlzIGFsd2F5cyAwIHNvIHRoZSBidWcgZG9lc24ndCBtYW5pZmVzdCBpdHNlbGYu
DQo+IA0KPiBQbGVhc2UgYWR2aXNlLCBrZWVwIGl0IGluIG5ldC1uZXh0IG9yIG1ha2UgYSBzZXBh
cmF0ZSBwYXRjaCBmb3IgdGhlDQo+IG5ldCB0cmVlPw0KDQpUaGVuIGl0IGNvdWxkIHBvaW50IHRv
IG5ldC1uZXh0LiBLZWVwIGl0IGFzIDZ0aCBwYXRjaCBvZiB0aGlzIHBhdGNoDQpzZXQuIEluc3Rl
YWQgb2YgMyBhcyBtYWdpYyBudW1iZXIsIGl0IGNhbiBiZSBtYWNyby4gDQo=

