Return-Path: <netdev+bounces-117906-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D40D94FC38
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 05:29:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1D721C222C6
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 03:29:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9415C1B948;
	Tue, 13 Aug 2024 03:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="nWubJoAW";
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="3GU8KniS"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75D2218E29;
	Tue, 13 Aug 2024 03:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.154.123
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723519747; cv=fail; b=BF479DHpWhNDgbMiyOVM6xN4cfyT2a7xprq6AE0dsYtPKZgPfwHF0wa3W3x3qHwpZlNJnTCWIQ85c65cWIYnUWRlJX7/lvgvwvWKpE7aZU/uVA+wHfe6kqsQpVO9dEH70rjBsh76jpE2bWWBPnTxei9sZABT5kSAtgHT+xwZAJE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723519747; c=relaxed/simple;
	bh=rOPVEiqjH23WvyqidHeP/7Zw0Gp1PU1zpM4pqW3mIgE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hy8q+80mNpCkBT546HSv76LpMUOOwjSnd5yyiSItNM+lsHdEwJ3HjyLM4ByJq/PBbHWg2/eod6LOD4AyfNfRJsx1zE9q/AH/GRjJftG9L2mA/1pMcMW14w7AHCo9sGX9DPtxmlXxsBQKPgYKXrubstZT32hT6VQ9isCFNWtECvk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=nWubJoAW; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=3GU8KniS; arc=fail smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1723519745; x=1755055745;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=rOPVEiqjH23WvyqidHeP/7Zw0Gp1PU1zpM4pqW3mIgE=;
  b=nWubJoAW42QtptYkP104e06nBIg/rqxWaZ8074n7skxzo3Z8eBEyZixI
   AeM2FUVg8TuQlsQjq3PoYrwQUFSUBBLtj+dHJVeVv88KsedEfmg5X5Uw6
   AKov/pMTwoGPIpntdqDrkJl1OPlt9PG6R+czkd3MTur0F1MLniPeSvsvZ
   IajUT1ucNdXKgYgCkuKdnjey++NiImvfvwR2sA44CPfgi5n6BAEdGRzNW
   UuKfOsIBOsAiTEO4pBlQB4DyEgQ0a2TrNN1PSAjtMCpc/1sBTNAgjmogw
   bqsIQB3T+FPVoHwb1kVjA4VmGYLdvn0+4IOwIpv0jBIapRm9hpXoQdvKp
   Q==;
X-CSE-ConnectionGUID: SP6+KDUzQziWLM3kiuYYvg==
X-CSE-MsgGUID: Xs5AxwuFQ3u/eYfTXTNAUw==
X-IronPort-AV: E=Sophos;i="6.09,285,1716274800"; 
   d="scan'208";a="30376185"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 12 Aug 2024 20:29:04 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 12 Aug 2024 20:28:46 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (10.10.215.250)
 by email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 12 Aug 2024 20:28:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ab7/wZgJRpbuYrquu928TEDVA/zNqXWRKRNqBDGCD7AdBObyhVn29hoBYBh0BqWg384awLBQ+6+HjrdcE79pH/vbBSMnf/h4kzdPZuGPNpQPTk3M9IOg3BLTapKJAL9eJRQpuFGmh2pz7tzYWW66kgBevnZY3UnrQLvGgSeNAE/mLkT9oZW2fj3EPEyhOH5NSXSU7PoOK6ooybN03hNIMUxUffNx8GfcupmLL7Kfazd7AVLmeE2E2gDMiGmIpo2NclCMj71aw5HCOjUTXIY22mNiDeHfaqIvckuks35ZU/KTlaIubCf5MiscwEDEWfINUh/byCCga8HoeoV0XRQFdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rOPVEiqjH23WvyqidHeP/7Zw0Gp1PU1zpM4pqW3mIgE=;
 b=FvaarGi5ehTbsNiRXv60n5A+rd28PcF1BdRI/BYfIggI3858vzE4ztr9tKoXa6E3GFj7CIP7/IR0rl/ZftnvBCXg0JK57HRYF6+/MjUYdoDBHpsTBsXScb3c1JeDWdrz01Vt4SNQsZvNJFOjmQ15evKORcUAMQM2eRhV6x7grpII59I951Udv89kuzcDB2RINPDkVQrI0TLh824INWUWEr7y7OTd7Ct5vDHjZeFmGuuOdwBCfl46u9G71gjba3qDfW0ZHGcm8Qk2PJi1isrsCh7iJHbPURViEXHlbvXm45vEzPM18Oj5I7Zai1L3bg5wb/qA88iYii/VUZPm8Dfndw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rOPVEiqjH23WvyqidHeP/7Zw0Gp1PU1zpM4pqW3mIgE=;
 b=3GU8KniSknswOkHsSF49QOhLjv4DBzuTbAIjWG0LS+tKx9B8zkVdcl9GC/60LxBbyPJIcmvHPkBqcNzkrAmBoGbHC2NAeqxR/ByVp/vH+QyozcnvA9FS/ygINMiZrE7rwVg8RPC5+q8590MF+WktMASHXhLmiR4iEv5MYAYu0WdmnU3AmkpH649d6EpmZABcc44L2HdML/UC3ob6WtZbxIh3gH9BrMx3/PztHgpsF41lddyD17kGFP6jvc5yPQfrmragEiXoCvoUoRAbdSh9f9wQA3ijzyjVulesbz8m2QPrpJ/bwm/sAlW2jnK75TAVNFOFp1i9mYWcZtsEP4dcDg==
Received: from PH7PR11MB8033.namprd11.prod.outlook.com (2603:10b6:510:246::12)
 by PH7PR11MB8570.namprd11.prod.outlook.com (2603:10b6:510:2ff::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.33; Tue, 13 Aug
 2024 03:28:43 +0000
Received: from PH7PR11MB8033.namprd11.prod.outlook.com
 ([fe80::22a1:16dd:eea9:330c]) by PH7PR11MB8033.namprd11.prod.outlook.com
 ([fe80::22a1:16dd:eea9:330c%6]) with mapi id 15.20.7828.023; Tue, 13 Aug 2024
 03:28:43 +0000
From: <Arun.Ramadoss@microchip.com>
To: <andrew@lunn.ch>, <olteanv@gmail.com>, <davem@davemloft.net>,
	<conor+dt@kernel.org>, <Woojung.Huh@microchip.com>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <f.fainelli@gmail.com>, <kuba@kernel.org>,
	<vtpieter@gmail.com>, <UNGLinuxDriver@microchip.com>, <marex@denx.de>,
	<edumazet@google.com>, <pabeni@redhat.com>
CC: <pieter.van.trappen@cern.ch>, <devicetree@vger.kernel.org>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v5 6/6] net: dsa: microchip: fix tag_ksz egress
 mask for KSZ8795 family
Thread-Topic: [PATCH net-next v5 6/6] net: dsa: microchip: fix tag_ksz egress
 mask for KSZ8795 family
Thread-Index: AQHa7MzR7OE28nYpUE+YgSn2nZ+W37IkiN2A
Date: Tue, 13 Aug 2024 03:28:42 +0000
Message-ID: <edd2a9938f72748be76956594c0cb0f967c8abd4.camel@microchip.com>
References: <20240812153015.653044-1-vtpieter@gmail.com>
	 <20240812153015.653044-7-vtpieter@gmail.com>
In-Reply-To: <20240812153015.653044-7-vtpieter@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.36.5-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB8033:EE_|PH7PR11MB8570:EE_
x-ms-office365-filtering-correlation-id: a626164a-d3df-4c04-4f5c-08dcbb480840
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB8033.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016)(921020)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|7416014|366016|921020|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?azh5c3VWc3N0YjBDQk9RV25FdmVyMSs2UVpPeWw2RlhDWnhOMWpmWG1scWFj?=
 =?utf-8?B?WVV3NVdieXdTRFlsUEs4WnY3MUw5R2xabThrYzJ1RzBIeHNZd25najVqWHJp?=
 =?utf-8?B?V2VwRFM2dlNOa1AyWkg2enJudjg0cGlSc0NTczkrcmgrc2RzaDl1NDJrSUwv?=
 =?utf-8?B?UVUyYjNZQWlFSWhtMXh6cG1sWjF2M0tGSktYNlBLdWtzdE5ZTE1VSGkwdUd5?=
 =?utf-8?B?T3dsVkRRQkJiVmRWcnRUeHRkZUdPV1RZZk03a1B5clZQZHBSOFEwdnNydUpr?=
 =?utf-8?B?VVdvQ09zWnNrZTRuR1JTT1kwSXp6Yk5nVHRacWhzdEUwWEdzYkhkSmVUM2Yw?=
 =?utf-8?B?eVlRRjRJV3c4S3ZLWGlXbGxGWlhmcEdtc0JTbUZ5WmQvVEpmaUxqUkNqaWN5?=
 =?utf-8?B?VjErNkJWQ2ZRc2NrYThZV281cCs0UlVnRlFWc1JEQWIzUk1ZcGZhWDQ4Q1cy?=
 =?utf-8?B?MUJhbGE5NDJPaGg5R2VVampsd2IraUQ3N0psZkFXM2kxQU9DL0RwaDhlZjB6?=
 =?utf-8?B?empQUEFKUEUzN0lqOWxybitkZlJuRHVCdzZER213SmRadlgrT3JmLzNSOTZL?=
 =?utf-8?B?bGdvd1hXelN5Sk9idnMvNmd4aDNOaVpFL0hDRERIV0UrOHFUc3JWdWx4aUhM?=
 =?utf-8?B?UzdiODY1L2taZ3JhTGYwbTJFYU81eTlKUzA1NlhhaHJXcDNYV0JwaUdGcjVK?=
 =?utf-8?B?c2M0TkVYZUc5TnJITkFrZWNxdnVOVnpVZGwrZmpaczlORndxMWJGUitWcmpo?=
 =?utf-8?B?cUpQQTBXZ2tXemJvZzNuYzVrUTJaUUg4bnR5aVp4ZFNvUml4TXkrbmVHOEc3?=
 =?utf-8?B?K0VFKzdwMWR3THk3MVFIam9kUEZKWjVYMFk1Szk2QzN4cS9QdmhmM1VYcnls?=
 =?utf-8?B?ZkQ2YnRGOFlYQ1VBaDVoU1pVN3I4bWtuOVdvOFEzeFRSSHI1djhHVDZYczNS?=
 =?utf-8?B?M1BYemhnekRNd2V3eFB2S1RoTFpSQkJFRHZndGttVkRKb0I5dVV0QndFVWZn?=
 =?utf-8?B?U1l3alIyREZIajBoNUZ2SmgyVXZKMnN0aXhmblRYOVc1SnVJR2xqbkxkV1cv?=
 =?utf-8?B?cVdVTk5GWk1uTXRrT2RpNWFVbGdLTEMxaWFudWhXWCsrWVgzQ3h5aEtTdStQ?=
 =?utf-8?B?N1Q2SVl2dWVhb2s4NmQxQ2FjTS8zQnNkb2dienZUcjlLa0t0YzRmOHliQzZz?=
 =?utf-8?B?dmFIdVFUVS9kYWNHS1VVOWJUeG9pUldXbUw0U0NndHcvM3RSTnJvaW8xVFBn?=
 =?utf-8?B?d0pUWlNBSEF1R3NXMTJ5TERIVzhYcitjRFp3bGthZU5YejNIb2ptY2ZlaG5v?=
 =?utf-8?B?TFIrVWwzbmpWQXJzNSsvSnpuUWxZakdiUmFPN0t0U0lEbnp0WHNmREg3MUNy?=
 =?utf-8?B?V3ZoY3B1MGI4dUVxTVM5TjdzckxCSE5TdkQ5VTRJMWNKdXFsNy9JcUh2Q2da?=
 =?utf-8?B?dlVRVjlsWFVhWXdBejlOWklIaGY2WTBMT0VXN2MrUUpFbHhLUzErMW5TOVJX?=
 =?utf-8?B?Umh5R3dJaFJXSGZjMWFSbWtNbXVhZTJCS2JTVmw0VnVCdjVNRlErRDdyVkZq?=
 =?utf-8?B?bXl3VDc1Y3JoWWExZ0ovOXFZcFQwV1Q0cnVheWdpQkhmZVMvZjZRVnkydTdJ?=
 =?utf-8?B?VnU3c1BxQ1JON21LUlprMlQzMTF0ZFFGQklXMDF5TW1IY2c5UkVQSjJUQUlk?=
 =?utf-8?B?dndGOGo2UkZubE5aYndFWWlUMUwwNW5Lc0ppN3FMaEcrS2oyOStoN3JIVUor?=
 =?utf-8?B?VU9wckQwazNPemNEZnZNSngzQlJoS1kzSDRqc0Rxb0dMM0FWeWNpejBXRFgw?=
 =?utf-8?B?MUhLN2c2b3hWNjgrS1Z3dTR5WkxYeVRDSUN6RklMSyt5QjJGRno2VEttVTFk?=
 =?utf-8?B?cG45WkJGRU5VTTlidkpCM2lYVmxWU0V2dXdGSUVEZFEwKzZZUmcrL2g5VEhs?=
 =?utf-8?Q?/Fzjju/O0Y8=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NW13WUZTOVZBTVJ3UVcrdkJlNTRSTm9obUR1dzRaUU9XdkNsTDdwREJ1Unc2?=
 =?utf-8?B?V3NPb21BMnBSSENoc1BWV3l6THk5Q2FOd3NFRmY0MWk4ZmRnd3dLQ2RlUEgy?=
 =?utf-8?B?ckF5Z0tLK3hxdlB4cWZCL0tTYnFmVUpvcUtvTWFVbUZGUUQ3NmlDYlhRUUFB?=
 =?utf-8?B?MkI1UG80TjBLbDhlb091em5JVTN4VGZZUm5hcUxzYTZaNi9LMTBpRGgwM1Vi?=
 =?utf-8?B?MVoxMWNXZVVLZHZ4NXBkb3VpY05lTFF0WWdTa1gyM1RqSHI4M0V3RlVaTXhs?=
 =?utf-8?B?VnRUMGY3SytjeitDZ1BSL0QvNElBc0lGQUx5TTN3enowNXBRSFIyTlllRytB?=
 =?utf-8?B?YUxyRkt6dEFFUzVPTXRjMWZnc1BvVGNFQUtNRWM2T2g1c2ZzSXRuN3BOSzky?=
 =?utf-8?B?MXdmbjI2dDRrenV5VStzTFd2SkFqOVNBeUE2U0hoeFFmMU5qMjc2MzYvR3NK?=
 =?utf-8?B?UFhlVWJsNmlUNUkrcmtyRTlIQXNmaE5QRUpMQnZjN0Y5Q0JBZ3hkcFhYS0c3?=
 =?utf-8?B?L1A2NDY5ZlBTNTg0aTMzSzhtQkRSNk9MNzBqYWNYYVhnOElvbHE4bnNYcmo0?=
 =?utf-8?B?NUdSUVdrRS9teGhCMTl2eHYzTFE4eWRiaTBRSWxCdUpWcjFiYXBWeFd0ZVMw?=
 =?utf-8?B?WDJvTi93S3RYK1BWc2l1OXZxcC9jcS9PYkdFamVwMHFSNTMxVWNmN1BQNUJY?=
 =?utf-8?B?Zk4rVDBBL2FFUzhKaEF2K0xJcWZXZ0Q5WFJiVENQOGtWeWhFWXA5SzNDVStV?=
 =?utf-8?B?YTdEaFh0S2JLVE9lSEszczJySUtXWC8rTUFiWWQybWNuS0c5THJjU2IwdExP?=
 =?utf-8?B?YUtqSkVVdnpQRjcwSFE0SVk5aVJmd1NhdEdHUmJzV0NjSjV4SEFTLzN5UE1w?=
 =?utf-8?B?TXFmUjZZOTdJYXM0WW54RE1UUHpsbGhjWmVUajFzUlpJSG4yWGZ3MGxtM2dQ?=
 =?utf-8?B?dCtjN2RQRTUwRnlvendjVnJyblpVTGdmOVVQQU1hTEhXUVZ4S09lT0VHRXZz?=
 =?utf-8?B?WHlWTVRJczVTN016ZWJpQkMvem0xQStwUWhDLzVOYWI1Rng4YmNrN0pEMmc3?=
 =?utf-8?B?YlBtN2VSaXh6QkRDSVFDYkFEMytOaUtuTGdHOGpCeFNabWNmVXpud1B5N3F0?=
 =?utf-8?B?WEEzNERKUEhkTWFUeDVVWXg1UkJDM1R3ZDBNbFRTUWwxaitlZWxEZWxTeHg5?=
 =?utf-8?B?ZWwxV09NSnBiRnltNUh3QjhtaEY5M3d5bm9MY1FtRUozczhvM3oycndISFNY?=
 =?utf-8?B?V0lJeEpVMFRFV1ZqZTRocFRVY2ZhajJSOHhMS1MrQnRqOC9WODZ1YTRmd1F6?=
 =?utf-8?B?aUxxdE9RQ1NIa01PdEgyYVZibDFvWVZYVG5qSGM3QXo1VnJ0cE4vNGNMQi94?=
 =?utf-8?B?NlppQ1BiQndpdkpoN0RBd0hqeXQvbmN6a1BBMW1aR2ZCT3htZllFMFBqeDNk?=
 =?utf-8?B?SXd3ZkdnNmw3UUVzaVhHbXlVNXBCUC9weWhybjUzdW9FWUFiOXBZU011UXJP?=
 =?utf-8?B?aDdMMHFlMDR0Q3VXbExkM1IycGg4NGFnOUxQY0xidUxqOXA4ZGlUcGtmMmt3?=
 =?utf-8?B?TG9FTUdRV3hVaEdDbXkzYmdnMUtQdDVrdVg5M293cWFIN0k5d2tlUEhjcnRZ?=
 =?utf-8?B?ZDdiWUlJTzRrTDlkTVhWb0tZMWJPS3ArVThvOUVaM3NCS2JvdXE4a3NQUzhT?=
 =?utf-8?B?ckdqSlF6SHczZUFZZE9NK3FkNWdFUVpBaUMrRHUxRmZkdG1xcHhhK21WYzBq?=
 =?utf-8?B?RHY1VjZPcmlGcnlGWVdiWnZBR3RWOVY1SktMMFJZbHFCNHBjaWdNOHhITm94?=
 =?utf-8?B?Ymt4S3JwZkhhU0ttUWZvSTlmSStQTlg2Z2JyTFk0TCs1MURhT3dwMHlGQmN6?=
 =?utf-8?B?M0tjbWR6MzZranA4Ymlad1NTNnh6VkdYMEx4TWpiRDNUU0VRQmVtSFltaGlL?=
 =?utf-8?B?dm1NMEVnSnJlbjU5ZmxJKzV0ZEdFMFU1RWVVT3I3V1V5VExaeEtQSzQ2ODJW?=
 =?utf-8?B?UGFnWkNmQ2M4by9POXBaSU8vNTdtSnVkWUtxVFlLYXlyZk50Mlk2UHhlZkc3?=
 =?utf-8?B?UDVkQkRrVENQSERKa011UEN1VHkvbUNWY1VMZlltZGwzbkFqb0NkMzNaRWR4?=
 =?utf-8?B?T3FCSXpUbVFSSkF3dkdMdDdlTVJlS0pReVRKY2NzWWdnNHJaRTZZVFhacUFF?=
 =?utf-8?B?OXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0236244C82FADD43A44A4C65F84D17DB@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB8033.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a626164a-d3df-4c04-4f5c-08dcbb480840
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Aug 2024 03:28:42.9645
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EyL94QsDAJx0qLhYtF+tw3hvUPRtVZhfcH9LiyXOfA0rYDkOMgPLQm9n4Ibskiz4WkhBV3wZ454fTy0DerTc/PWnTTKzEqFgbhVTmMih9V0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8570

SGkgUGlldGVyLCANCg0KT24gTW9uLCAyMDI0LTA4LTEyIGF0IDE3OjI5ICswMjAwLCB2dHBpZXRl
ckBnbWFpbC5jb20gd3JvdGU6DQo+IEVYVEVSTkFMIEVNQUlMOiBEbyBub3QgY2xpY2sgbGlua3Mg
b3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3MgeW91DQo+IGtub3cgdGhlIGNvbnRlbnQgaXMgc2Fm
ZQ0KPiANCj4gRnJvbTogUGlldGVyIFZhbiBUcmFwcGVuIDxwaWV0ZXIudmFuLnRyYXBwZW5AY2Vy
bi5jaD4NCj4gDQo+IEZpeCB0aGUgdGFnX2tzeiBlZ3Jlc3MgbWFzayBmb3IgRFNBX1RBR19QUk9U
T19LU1o4Nzk1LCB0aGUgcG9ydCBpcw0KPiBlbmNvZGVkIGluIHRoZSB0d28gYW5kIG5vdCB0aHJl
ZSBMU0IuIFRoaXMgZml4IGlzIGZvciBjb21wbGV0ZW5lc3MsDQo+IGZvciBleGFtcGxlIHRoZSBi
dWcgZG9lc24ndCBtYW5pZmVzdCBpdHNlbGYgb24gdGhlIEtTWjg3OTQgYmVjYXVzZQ0KPiBiaXQN
Cj4gMiBzZWVtcyB0byBiZSBhbHdheXMgemVyby4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IFBpZXRl
ciBWYW4gVHJhcHBlbiA8cGlldGVyLnZhbi50cmFwcGVuQGNlcm4uY2g+DQo+IC0tLQ0KPiAgbmV0
L2RzYS90YWdfa3N6LmMgfCAyICstDQo+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyks
IDEgZGVsZXRpb24oLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9uZXQvZHNhL3RhZ19rc3ouYyBiL25l
dC9kc2EvdGFnX2tzei5jDQo+IGluZGV4IGVlN2IyNzJhYjcxNS4uMTVkOWY4ZDI4ZmZjIDEwMDY0
NA0KPiAtLS0gYS9uZXQvZHNhL3RhZ19rc3ouYw0KPiArKysgYi9uZXQvZHNhL3RhZ19rc3ouYw0K
PiBAQCAtMTQxLDcgKzE0MSw3IEBAIHN0YXRpYyBzdHJ1Y3Qgc2tfYnVmZiAqa3N6ODc5NV9yY3Yo
c3RydWN0IHNrX2J1ZmYNCj4gKnNrYiwgc3RydWN0IG5ldF9kZXZpY2UgKmRldikNCj4gIHsNCj4g
ICAgICAgICB1OCAqdGFnID0gc2tiX3RhaWxfcG9pbnRlcihza2IpIC0gS1NaX0VHUkVTU19UQUdf
TEVOOw0KPiANCj4gLSAgICAgICByZXR1cm4ga3N6X2NvbW1vbl9yY3Yoc2tiLCBkZXYsIHRhZ1sw
XSAmIDcsDQo+IEtTWl9FR1JFU1NfVEFHX0xFTik7DQo+ICsgICAgICAgcmV0dXJuIGtzel9jb21t
b25fcmN2KHNrYiwgZGV2LCB0YWdbMF0gJiBHRU5NQVNLKDEsIDApLA0KPiBLU1pfRUdSRVNTX1RB
R19MRU4pOw0KDQpJdCdzIG5vdCBsaWtlIGFkZGluZyBHRU5NQVNLKDEsMCkgaW5zaWRlIHN0YXRl
bWVudC4gWW91IGNhbiBhZGQgbWFjcm8NCmFib3ZlIHRoZSBrc3o4Nzk1X3htaXQoICkgbGlrZQ0K
DQojZGVmaW5lIEtTWjg3OTVfRUdfVEFJTF9UQUdfUE9SVF9NIEdFTk1BU0soMSwgMCkNCg0KQWxz
byB5b3UgbmVlZCB0byB1cGRhdGUgdGhlIGNvbW1lbnRzIGFib3ZlIGtzejg3OTVfeG1pdCggKSB3
aGVyZQ0KY29tbWVudHMgZXhwbGFpbnMgZm9yIGVncmVzcyBpdCBzdXBwb3J0cyB1cHRvIHBvcnQg
Ny4gS2luZGx5IHVwZGF0ZSBpdA0KYXMgd2VsbC4NCg0KICogdGFnMCA6IHplcm8tYmFzZWQgdmFs
dWUgcmVwcmVzZW50cyBwb3J0DQogKgkgIChlZywgMHgwMD1wb3J0MSwgMHgwMj1wb3J0MywgMHgw
Nj1wb3J0NykNCg0KWW91IGNhbiB3YWl0IGZvciAyNGhycyBiZXR3ZWVlbiB0d28gcGF0Y2ggc2V0
IHN1Ym1pc3Npb24sIHRvIGdldCByZXZpZXcNCmNvbW1lbnRzIGZyb20gb3RoZXIgcmV2aWV3ZXJz
IGFzIHdlbGwuIA0KDQo+ICB9DQo+IA0KPiAgc3RhdGljIGNvbnN0IHN0cnVjdCBkc2FfZGV2aWNl
X29wcyBrc3o4Nzk1X25ldGRldl9vcHMgPSB7DQo+IC0tDQo+IDIuNDMuMA0KPiANCg==

