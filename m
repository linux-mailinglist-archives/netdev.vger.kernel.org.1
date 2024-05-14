Return-Path: <netdev+bounces-96253-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D5A3D8C4BC3
	for <lists+netdev@lfdr.de>; Tue, 14 May 2024 06:48:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 042221C22F80
	for <lists+netdev@lfdr.de>; Tue, 14 May 2024 04:48:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B12511725;
	Tue, 14 May 2024 04:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="Uk7/zawC";
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="A3B/YZ1I"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F25A4ED8;
	Tue, 14 May 2024 04:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.154.123
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715662075; cv=fail; b=SLCgnAtxUkREgrNJHgv0BaUt5wvwBHiWOIFJaY5ue3BARGY02WoU00AaBxwEuSWsDn1SZ3UrurahmdWO+2FQh3JtCobQusjSOrK1A9T+OXNtePkn1Xj6947iPmv2JToB3R+N6lUVc9tsKqXkCqizM5zmqF0nVLEnD+rruMryyOw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715662075; c=relaxed/simple;
	bh=HcPpCeuZ03G72XLJv21gjJ/mlZ0VnVZg8Z2KlmdBhh8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=eA3tAMMLQvN/Kdxe++3U0SHyAFNJ4D/vkeHTZF8tP2h+PEEIxfZxuPpHoNINmdw+Hm89Yj9h3NPf33OXOhajBCG28b5J8y7c2TCokzflCkHy78cs7KcgdawWG+/TYMlC+D/VTpMX9FMp3vQZnNMjAbNoPWzYKK1OKDNCW71pxIc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=Uk7/zawC; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=A3B/YZ1I; arc=fail smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1715662072; x=1747198072;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=HcPpCeuZ03G72XLJv21gjJ/mlZ0VnVZg8Z2KlmdBhh8=;
  b=Uk7/zawCM7L/4TdSgjypGTssglVTRcPI9cUWBSUoAY+oeZ5FtVakCf8q
   Jkpbu9p7AdUqT+A7ORxD+lLzID79/l932bA3XkgJTj3SvdTGAbPsV+nIQ
   9ktBM4hPUd28byuqgP8g5pIi3d5uqUQ5Hw0qoEIOmrsZaLoQt5kIgm0bp
   iHa2a51N4hYaonKW9JVqqpmmzM1C6NcCof6DyLD2XwjD42uB4nZAaictv
   vc1vYauLJBtqh20S52uB+HEiSFDyvsvD/Y35qKMieLzPpOBPxtG+BC3ne
   y06u3oFHXqnS7PL4o5pLxr/I4LrV/ss7BepyfRmwDziTqPP4KCQRJJpPj
   g==;
X-CSE-ConnectionGUID: 4bL2kOjITg+NwECBLfsrjg==
X-CSE-MsgGUID: PWTUZ71eR1KMHXxeYYeZ1g==
X-IronPort-AV: E=Sophos;i="6.08,159,1712646000"; 
   d="scan'208";a="191953215"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 13 May 2024 21:47:46 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 13 May 2024 21:47:00 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (10.10.215.250)
 by email.microchip.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 13 May 2024 21:47:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ghfUI5uY4STNJXlMIaXLN2Mmrxkt/CjxZABh9a+Lit89JgwNT4E9KI22qWB05e2wPMDK58xXvWcjUmd6W626wGG1cTcXsr9hrsErq6gC8oHbgZfUkclGNdyjuOYwnGfPVwgkJGgLDsJ2nSzp1XyrXxi6JH6G5zq8K7Yc1Ci3Y78WDR6JE7P22zhDb3/dTKG687dS0fJnuzu2wYeKxUCZDgMtQ/Evv4/nFfALKdiSm5b1wlt9A0/ukV/Snn82dDbuFPeCIyCQC4hgsEi2dFlVRaHhi3/mJw00JvlNEUy+4XTXbN8nfuJu4vztheVLrTzvHRq7yOTp0xgkXsv3xJmUww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HcPpCeuZ03G72XLJv21gjJ/mlZ0VnVZg8Z2KlmdBhh8=;
 b=BEj5+UeghAAwSTStXcUB/pZF/7Vc+PlxF4OBz4K4Q6RRdEN7NxrKsIJFPKFqivPD0MLKJpOy9oibLF8J9L1KIGIua/YkiQS3VJUrls+AtTbo350vxWLxv+d9MyFq6nhatsuGSdxdP/vFp4/O8mbqtZ1fCPBN6kLs6/Ly5zbzOpS4N3P0Dvi/MzvBgwhRZIFsCfkWdJBkmsppkVlhhyxOA3DndEJHA1stA83ILl2BIxyuOuXJfT2bzsnSG8eI/MWxgqyryDYgGI8hLTmaqXzrlaLvobHiKW3tJC8Ii+WuxkSpBxyqqYv1fHTleo+LC1eCpeGgxhu9Hc2vvXA1UITO3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HcPpCeuZ03G72XLJv21gjJ/mlZ0VnVZg8Z2KlmdBhh8=;
 b=A3B/YZ1IG1MfyLVkkDXHiPS1l+OKbI/PN4xGJdfmvteD8uPxAKKUyEBfD443mSRJchRaCnsdIM6tzAivZz6QBRl9chItBOT9PEcCFd3+xg8Ngz22CWzIg8/JqeWogarglfg+8MOdkW0X6ZqaoXZJOF7AboGzUrEcmrOPT1DCFYfZdFfQQ34ZCP5kAXCR4we51WTBkCmnneKZz0JW/4UQlVi5c9zMvpyTWB5+lViBqqrjDg4/C0UCRGPgtZNGOyGy7aad7Tj7ALDvcKYOWyRyLUzGd9+s4xr3B+5C8fdpXhelNbx9XtJHW9oFS2ZM9DNJ3jV3PiOx/IzJNQqzR2IMEQ==
Received: from SA1PR11MB8278.namprd11.prod.outlook.com (2603:10b6:806:25b::19)
 by CH0PR11MB8189.namprd11.prod.outlook.com (2603:10b6:610:18d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Tue, 14 May
 2024 04:46:58 +0000
Received: from SA1PR11MB8278.namprd11.prod.outlook.com
 ([fe80::84fa:e267:e389:fa9]) by SA1PR11MB8278.namprd11.prod.outlook.com
 ([fe80::84fa:e267:e389:fa9%4]) with mapi id 15.20.7544.052; Tue, 14 May 2024
 04:46:58 +0000
From: <Parthiban.Veerasooran@microchip.com>
To: <ramon.nordin.rodriguez@ferroamp.se>, <andrew@lunn.ch>
CC: <Pier.Beruto@onsemi.com>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <horms@kernel.org>,
	<saeedm@nvidia.com>, <anthony.l.nguyen@intel.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <corbet@lwn.net>,
	<linux-doc@vger.kernel.org>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
	<devicetree@vger.kernel.org>, <Horatiu.Vultur@microchip.com>,
	<ruanjinjie@huawei.com>, <Steen.Hegelund@microchip.com>,
	<vladimir.oltean@nxp.com>, <UNGLinuxDriver@microchip.com>,
	<Thorsten.Kummermehr@microchip.com>, <Selvamani.Rajagopal@onsemi.com>,
	<Nicolas.Ferre@microchip.com>, <benjamin.bigler@bernformulastudent.ch>
Subject: Re: [PATCH net-next v4 05/12] net: ethernet: oa_tc6: implement error
 interrupts unmasking
Thread-Topic: [PATCH net-next v4 05/12] net: ethernet: oa_tc6: implement error
 interrupts unmasking
Thread-Index: AQHakZAQrurZHAw3l0Wxg+eFKGxGMbF8la2AgAAX2oCAANNtAIAAVU8AgATxiICAAQb4gIAAAoaAgAFdYYCABFWYgIAAWygAgAr+tICAAGnoAIAADcgAgAD6j4A=
Date: Tue, 14 May 2024 04:46:58 +0000
Message-ID: <6e4207cd-2bd5-4f5b-821f-bc87c1296367@microchip.com>
References: <Zi4czGX8jlqSdNrr@builder>
 <874654d4-3c52-4b0e-944a-dc5822f54a5d@lunn.ch> <ZjKJ93uPjSgoMOM7@builder>
 <b7c7aad7-3e93-4c57-82e9-cb3f9e7adf64@microchip.com>
 <ZjNorUP-sEyMCTG0@builder>
 <ae801fb9-09e0-49a3-a928-8975fe25a893@microchip.com>
 <fd5d0d2a-7562-4fb1-b552-6a11d024da2f@lunn.ch>
 <BY5PR02MB678683EADBC47A29A4F545A59D1C2@BY5PR02MB6786.namprd02.prod.outlook.com>
 <ZkG2Kb_1YsD8T1BF@minibuilder> <708d29de-b54a-40a4-8879-67f6e246f851@lunn.ch>
 <ZkIakC6ixYpRMiUV@minibuilder>
In-Reply-To: <ZkIakC6ixYpRMiUV@minibuilder>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR11MB8278:EE_|CH0PR11MB8189:EE_
x-ms-office365-filtering-correlation-id: 3ee76199-3560-48d9-7fc8-08dc73d0e336
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|366007|7416005|1800799015|376005|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?ak5kZVRQeFJHSFQ1RVpUTW14VEljN1lLTDRUVXBlR0IvYUlxNjZFOE5EdkJU?=
 =?utf-8?B?QVg2anFyRVpTU2V0RVhkNHoxRnFINE8yRFAwMllMV2hEbzQ0a1RVY3kwbUw4?=
 =?utf-8?B?UCs4MGZUZEhNbGpNT0h4MmFuZWRDdHcyM1pyUkZ4cnovQXBuVEtFUlNOajlO?=
 =?utf-8?B?aGF6ajZrSFVweGJlWUg1MTNGZGo2dE1tNEYvWjdwSzhKRGlYUUVBc2lwK2NZ?=
 =?utf-8?B?TEFTdFRIb0YzRGxrOEZDYzh1bi9YVXc5NXNRemY4eU9pbS9lUlp5UEE4UGVP?=
 =?utf-8?B?N21kNWRBOVg1QnJib2l4NHF1aHZzZCs4N3pWSXJiTm1WRDZYVm81NW53TkFE?=
 =?utf-8?B?dnR1RHFDbjFPY1F0dHhjUkRXc0FDelcrU1VLc01rTjByT0xxeEI0NEJtZ0JR?=
 =?utf-8?B?MzY4dElMd3Nmd1phMFRZditvd2VWNjNLL1liRFNoVm5hOWJjZjA5T0hkeFI0?=
 =?utf-8?B?VHd0a1RkSWtQUVZ2N3B2clp5WDMyWGlqNFZLcUZvY2hUdDlvNHY3ZjlNWk9l?=
 =?utf-8?B?N1VTZTQ0OTl5ZXJkL3JoSFJISUM3SWhHK2hqR3d0RjRjbWlub3E0dms1cGJJ?=
 =?utf-8?B?WG4rUGlhaVFUeHczNWVuMDFyWHkycU1nZ2pnZ0ptMlVuZUs1V3ZZVmRUSkFx?=
 =?utf-8?B?Q2laZnNwdFRnNjdiZUg4R0JhN2ZyUXE1M203Z3ZkV2VDSnh5TDFqVEU3ZXh1?=
 =?utf-8?B?OVlxQTdXSnErclRPb0d6UlZTWHRwVzR1M3BxTndWbjlTZGxMRlExVDJMSnpV?=
 =?utf-8?B?REJHcWc2ZDRZTUZzWGN5M3F1MEc4aEU4M1pHSGtKUU9lL3hYYmlxOURaYWVC?=
 =?utf-8?B?TnZYeFNvcXhReHJCZThqQ0hPdFk0MHRXRzV0Q0lWbGxOVkZpNlE1dHdoUEpN?=
 =?utf-8?B?ZlJ6TnR3VHBhUXp3SENXcS9HUGFyS3c0OW16NHh1YUlmYS9NOGtKTC9yT3lq?=
 =?utf-8?B?Q3FvL3VkKzNRN0IwVjJmeFM2ckR3ZW02LzRDaW5mdGduSnNTREROSElSRXVE?=
 =?utf-8?B?Q1NJcDBaQyt2MXBxa1orYXgydFF0K1gyTkgwd0lvdmlmV3hxZUMrbFBSVEFz?=
 =?utf-8?B?a0hOdnk0dVFBYzVKcldqZGswNGN1QmRlaVFHMkNuSmg0RVFFSGtzU08ySmxk?=
 =?utf-8?B?WXQyTGFxa1g1cktCZFpveE5PSUxxUjcxSVVLVzkzWEc1eHc0ajhBdnNab01Z?=
 =?utf-8?B?REd1dGVNL1I3RXZyVXVoUnRjRmJQaXNoUUNjczRMWCszS1cxeVAyRU9WNVJ6?=
 =?utf-8?B?d25COGJIb01lcHJkdlVFSng1THZqeHowczVwNHZqRVVqbDJvNnhHcnJKQUJE?=
 =?utf-8?B?ZzhuT3dadE9iU0x2N1ZhRjViU1hkTWZRenhVK3JaaVdvRGtjblhsZll4dktB?=
 =?utf-8?B?OG5ReWFYRSs0Ylh3UjBJaXFkV3VLUVRacnB6QTY0M3Y0cHJKMGdVKzFWdlFS?=
 =?utf-8?B?TjNLSTd0NndnbWZSQ0Q1eTZOTHlrWGtwbk9nK2VXWHNnUkQwQmRwU0xNcklv?=
 =?utf-8?B?M014cTUzK1NYUWtKMzZhbFA1U2svWUVCVzF6OGZ5Y25LYmcwUFpsS3BaTkJ4?=
 =?utf-8?B?TlFRWlNyVGMyRDZieWJ3ZTlOTVlOaWtGNWZSMndKSzZYUmV6VXh2SmdwdjVw?=
 =?utf-8?B?YjRFMHhuOXBGUC9LRjFDWEd1aEZRU0I2TVlVQ05EZ2JveU4wMEJVZ2tiaVJR?=
 =?utf-8?B?ZFc3VDZESktXMUJwY0NwQ3pibUlsTkdySjVNS0JEenZBUVA5dFNLM1dWRkRI?=
 =?utf-8?B?WWViWUFqcVFjYkpQcVVoRUwxWDJmOWwxWDc4eUZFS2x4WmlpcFcrN1p3SjN0?=
 =?utf-8?B?S2gxbUN0a3d1R1pLTnVSdz09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB8278.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(7416005)(1800799015)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?T0pmZkw0UEhoSFlYRmlZL1AyQ2pKY0FzWW5qZHhBdE9vVCtsQUdieHBGcks3?=
 =?utf-8?B?cEE3QWc5OWZQeUQ2NmJZSlJJM2xXK2pMNXpqQmhOcWNlT2JlQWNNaklhRXFU?=
 =?utf-8?B?THM1anVNNjZ2aHJ4VVlmSEVzUXF3NUZCcmpQalNEa3NZL0NzSnZlYndEZjE0?=
 =?utf-8?B?T09LYVdVMGwxQUVaR3N6OGZSc1JqWERGUDZaV0FnUGJjY2l4N05ZaC9EZjNs?=
 =?utf-8?B?NFZPOUN0NEhQelAvQ3B2WGNWMHkvbmdMZGxzcWRNVGY1SW5TV1NqSFhsYUlk?=
 =?utf-8?B?V3cyQmUrNHluU2JFbEVwSkJjbkl6bzNEdTM3RVJVZy9LaDRmUDdFZEZXNDZu?=
 =?utf-8?B?SG1OczhYcWd6c3hhUzZtek9MQ0tvWUlZYUN3VUJ5M04zMVJIMHlad2FOc3l1?=
 =?utf-8?B?eUFFSWFiZURISFEyUDRNd0djOHNMTzlLMUhWdHE1WE9tM1E2OEdPQmtFY1Yy?=
 =?utf-8?B?a2tGMnF6dEs0MmMyRzlHVjlLei9GLytmYy9rZmxhekkycWJuUytybzRxY2w0?=
 =?utf-8?B?eFJRR1lvQkJ3dDIzWUhUZHg1dytqUUVMb2s3YXlydWlGcXhUMW9QRUtKYjI0?=
 =?utf-8?B?cy80bEJ6azRLZGtoQTYwUncwY0ovZEk5dXRpdy9wY3pscTVaeUJkREZuUWVi?=
 =?utf-8?B?NHJybE5yZUlLQnZoNHRmRkUvN2NwR3h2THBmUHlQUEpuNjhnT3VVS2dGL1BB?=
 =?utf-8?B?TE5Mano2MlNaZkxHWFNaem5tcjFEMkJPVGVIa0h5MEpoODVvV0lDZ2M2MUJH?=
 =?utf-8?B?ZVM4cWJDTGRIOFJMcVdYZk01aTZOQmliR2hBblpWVDIxVHVSc1FYMlIvOVVH?=
 =?utf-8?B?dDVpYnB0VysveE1PRXhXOE9lano1K0FsYnI2MHNQSjFsekpvZWdDdVVDZ1dL?=
 =?utf-8?B?YWVmMzBQbVpTM1dpaGRDbVFxZk9IbUJTczdSUitWWWRqVHdOVldpeWJtL1NH?=
 =?utf-8?B?ZlNibjUyVDMxNnRCWnUzMUYyRi9KblM3a0d1VXhHR3NlK3BJL2doajdGRDVp?=
 =?utf-8?B?ejEvUFhqMWc5ZG1QL0R3d2YxQ2J4UjhjRGhDV2VnUEEwTFlFaE9SbEg4Q2FZ?=
 =?utf-8?B?ZGkxN21ueHE4N2RoUWpjNVBPTEJRL0hTS3cxVEZ1bFZFREo1NnIwSXNWVis2?=
 =?utf-8?B?VFhmRGhqWGdBR1crNlVYR05KUmYvNzdaNE5Lc2FyZUp4cHBtVlFTRk5heWcy?=
 =?utf-8?B?b09GQ2VVMTFLOVlKSUxwSW85anpXamZiNzlkS2QxYnNXcFBVdGpHYStLRnh1?=
 =?utf-8?B?S3RLVnMrWWZpU0dFbFRRSHFmbzU3VC9QZDFQMzVDRFJycEpOL3F3c2dzZTRa?=
 =?utf-8?B?MHFWRVZiRmgvaUhlQlFzRmRQVmR0SGQ2b0VTOXljajlsTGl3ZkNNdHVRRzcw?=
 =?utf-8?B?MDlNNVhNNFVBYXhXWStXMFNESmQyRTkvR0t1aG5RS2V0Nm9nT1hPUmMxcGZp?=
 =?utf-8?B?ei9zdCsrbURkSHQxNEswVlJKMXlyUEVia2JSdEJoR3VENkJTZk9VVG9OY3NE?=
 =?utf-8?B?VkdpKzV3cWhTT3dLVmJjM0llcVZtT0Q3Q1BnNlJXKzFRbi8wRXNNbXlrL3ZD?=
 =?utf-8?B?aFg5aUhmK1Z6U0VpNDQxc3dzbFRNMTNjeXl5WmF1ejdLb0Z2TFNLcXZ0Qmpz?=
 =?utf-8?B?OXVHVjZKVUpkSXUxakhCRWlFUk4yWGsxWU5SWCtTWWQ4bXF3dlNiNTBISDhN?=
 =?utf-8?B?enVsSmtwZHBBdzZYQXNNS1hya0xzdVBVWmlDNzJyaGNvMXZLdGtOWEg3eUIv?=
 =?utf-8?B?SWJUVnNiQU1IZnI0Wk82NE5PTkpCWUhLZk1lUDRuNCtMR1QyeFZnVnlxM2I1?=
 =?utf-8?B?a1VrTEU2WDJTTThRb25aUGF0TllDS0Q5KzZuT2NjQktOQ1RmNFYvMWRQTGFU?=
 =?utf-8?B?QWdqZzJOak1lSkxNWVI2RTZPRWlvcjFvQU02WU5qeGlBRUFldkErak5XWXUr?=
 =?utf-8?B?ZW5EWDFYL3YzQmcxTjhpMytxcTgyY2lOdzVZcEJsaHlCWjNLeHlzYWVpRmVP?=
 =?utf-8?B?dVBEZlUxS0c3QXdlNnZseDBkRk4wZit3V1lxUmdoa0ZyVS9kVXZPZjZZY0VC?=
 =?utf-8?B?YnBvWTZKNnYxeHlkTlkyWHVSeUkycCtxVjdnY1pteVZwUzFhY2V0eTFMY3J3?=
 =?utf-8?B?Q1VRejl4dG8zcXNDOFZ0bm1TYTJMOVBza29BQmdrZU9nWnFYWVFXMER2cm1x?=
 =?utf-8?B?WlE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C072FB3D26DDFD47B3D4B47E0AFDBAD5@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB8278.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ee76199-3560-48d9-7fc8-08dc73d0e336
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 May 2024 04:46:58.1545
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sVJHJOE62eyBQCV8Jnm0X/ZZfROduLj+NazIHUuD425mQ+JE5+MRQT4+aJ/x8uYyt8OFSX63AJI6nNifxCWq33yehSk5KSD5LbKKIek0xlr0J2vbMu4KK/eBB+Sk4x2s
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB8189

SGkgUmFtb24sDQoNCk9uIDEzLzA1LzI0IDc6MjAgcG0sIFJhbcOzbiBOb3JkaW4gUm9kcmlndWV6
IHdyb3RlOg0KPiBFWFRFUk5BTCBFTUFJTDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0
YWNobWVudHMgdW5sZXNzIHlvdSBrbm93IHRoZSBjb250ZW50IGlzIHNhZmUNCj4gDQo+IE9uIE1v
biwgTWF5IDEzLCAyMDI0IGF0IDAzOjAwOjQ4UE0gKzAyMDAsIEFuZHJldyBMdW5uIHdyb3RlOg0K
Pj4+IEkndmUgZW5hYmxlZCBzb21lIGRlYnVnZ2luZyBvcHRpb25zIGJ1dCBzbyBmYXIgbm90aGlu
ZyBzZWVtcyB0byBoaXQuDQo+Pj4gV2hhdCBJJ3ZlIGJlZW4gYWJsZSB0byBjb25jbHVkZSBpcyB0
aGF0IHRoZXJlIHN0aWxsIGlzIFNQSQ0KPj4+IGNvbW11bmljYXRpb24sIHRoZSBtYWNwaHkgaW50
ZXJydXB0IGlzIHN0aWxsIHB1bGxlZCBsb3csIGFuZCB0aGUgY3B1DQo+Pj4gZG9lcyB0aGUgYWNr
IHNvIHRoYXQgaXQncyByZXNldCB0byBpbmFjdGl2ZS4NCj4+DQo+PiBJcyBpdCBkb2luZyB0aGlz
IGluIGFuIGVuZGxlc3MgY3ljbGU/DQo+IA0KPiBFeGFjdGx5LCBzbyB3aGF0IEknbSBzZWVpbmcg
aXMgd2hlbiB0aGUgZHJpdmVyIGxpdmVsb2NrcyB0aGUgbWFjcGh5IGlzDQo+IHBlcmlvZGljYWxs
eSBwdWxsaW5nIHRoZSBpcnEgcGluIGxvdywgdGhlIGRyaXZlciBjbGVhcnMgdGhlIGludGVycnVw
dA0KPiBhbmQgcmVwZWF0Lg0KSWYgSSB1bmRlcnN0YW5kIGNvcnJlY3RseSwgeW91IGFyZSBrZWVw
IG9uIGdldHRpbmcgaW50ZXJydXB0IHdpdGhvdXQgDQppbmRpY2F0aW5nIGFueXRoaW5nIGluIHRo
ZSBmb290ZXI/LiBBcmUgeW91IHVzaW5nIExBTjg2NTAgUmV2LkIwIG9yIEIxPy4gDQpJZiBpdCBp
cyBCMCB0aGVuIGNhbiB5b3UgdHJ5IHdpdGggUmV2LkIxIG9uY2U/DQoNCkJlc3QgcmVnYXJkcywN
ClBhcnRoaWJhbiBWDQo+IA0KPj4NCj4+IFByb2JhYmx5IHRoZSBkZWJ1ZyB0b29scyBhcmUgbm90
IHNob3dpbmcgYW55dGhpbmcgYmVjYXVzZSBpdCBpcyBub3QNCj4+IGxvb3BpbmcgaW4ganVzdCBv
bmUgbG9jYXRpb24uIEl0IGlzIGEgY29tcGxleCBsb29wLCBpbnRlcnJ1cHRzDQo+PiB0cmlnZ2Vy
aW5nIGEgdGhyZWFkIHdoaWNoIHJ1bnMgdG8gY29tcGxldGlvbiBldGMuIFNvIGl0IGxvb2tzIGxp
a2UNCj4+IG5vcm1hbCBiZWhhdmlvdXIuDQo+IA0KPiBHb3RjaGEuIFRoZSAnZG8gd29yaycgZnVu
YyBjYWxsZWQgaW4gdGhlIHdvcmtlciB0aHJlYWRzIGxvb3AgZG9lcyBydW4NCj4gYW5kIHJldHVy
biwgc28gSSBndWVzcyB0aGVyZSBpcyBub3QgbXVjaCB0byB0cmlnZ2VyIG9uLg0KPiANCj4+DQo+
PiBJZiBpdCBpcyBhbiBlbmRsZXNzIGN5Y2xlLCBpdCBzb3VuZHMgbGlrZSBhbiBpbnRlcnJ1cHQg
c3Rvcm0uIFNvbWUNCj4+IGludGVycnVwdCBiaXQgaXMgbm90IGdldHRpbmcgY2xlYXJlZCwgc28g
aXQgaW1tZWRpYXRlbHkgZmlyZXMgYWdhaW4gYXMNCj4+IHNvb24gYXMgaW50ZXJydXB0cyBhcmUg
ZW5hYmxlZC4NCj4gDQo+IEdvb2QgaW5wdXQuIEknbGwgYWRkIHNvbWUgaW5zdHJ1bWVudGF0aW9u
L3N0YXRzIGZvciBob3cgbWFueSBqaWZmaWVzDQo+IGhhdmUgZWxhcHNlZCBiZXR3ZWVuIHJlbGVh
c2VzIG9mIHRoZSB3b3JrZXIgdGhyZWFkIGFuZCBmb3IgdGhlIGlycQ0KPiBoYW5kbGVyLiBJIGNh
biBwcm9iYWJseSBmaW5kIGEgZ3BpbyB0byB0b2dnbGUgYXMgd2VsbCBpZiBpdCdzIHJlYWxseQ0K
PiB0aWdodCB0aW1pbmdzLg0KPiANCj4gVGhlIGlycSBwaW4gaXMgaW5hY3RpdmUvaGlnaCBmb3Ig
MTAwcyBvZiB1cyB0byBtcyBpbiB0aGUgbWVhc3VybWVudHMNCj4gSSd2ZSBkb25lLiBCdXQgSSd2
ZSBiZWVuIHVzaW5nIG11bHRpcGxlIGNoYW5uZWxzIGFuZCBub3QgdGhlIGZhbmNpZXN0DQo+IGVx
dWlwbWVudCBzbyBzYW1wbGVyYXRlcyBtaWdodCBiZSBwbGF5aW5nIHRyaWNrcywgSSdsbCByZXJ1
biBzb21lIHRlc3RzDQo+IHdoaWxlIG9ubHkgbWVhc3VyaW5nIHRoZSBpcnEgcGluLg0KPiANCj4+
DQo+PiBJcyB0aGlzIHlvdXIgZHVhbCBkZXZpY2UgYm9hcmQ/IERvIHlvdSBoYXZlIGJvdGggZGV2
aWNlcyBvbiB0aGUgc2FtZQ0KPj4gU1BJIGJ1cz8gRG8gdGhleSBzaGFyZSBpbnRlcnJ1cHQgbGlu
ZXM/DQo+Pg0KPiANCj4gSXQncyBvbiB0aGUgZHVhbCBkZXZpY2UgYm9hcmQsIHRoZSBtYWNwaHlz
IGFyZSB1c2luZyBzZXBhcmF0ZSBzcGkgYnVzZXMsDQo+IG9uZSBjaGlwIHNoYXJlcyB0aGUgYnVz
IHdpdGggYW5vdGhlciBzcGkgZGV2aWNlLCBidXQgdGhlIG90aGVyIGlzIHRoZQ0KPiBvbmx5IHRl
bmFudCBvbiB0aGUgYnVzLg0KPiANCj4gTm8gZGV2aWNlIHNoYXJlcyBhbiBpcnEgbGluZS4NCj4g
DQo+IFByZXR0eSBzdXJlIEkgY2FuIHJlcGxpY2F0ZSB0aGUgcmVzdWx0IGZvciBib3RoIGRldmlj
ZXMsIGJ1dCBuZWVkIHRvDQo+IGRvdWJsZSBjaGVjaywgYmVlbiB0byBtdWNoIHRlc3Rpbmcgb2Yg
cmFuZG9tIHRoaW5ncyBmb3IgbWUgdG8ga2VlcCB0cmFjay4NCj4gDQo+IEknbGwgZG8gc29tZSBt
b3JlIGRpZ2dpbmcsIEkgdGhpbmsgd2UncmUgZ2V0dGluZyBwcmV0dHkgY2xvc2UgdG8NCj4gdW5k
ZXJzdGFkaW5nIHRoZSBiZWhhdmlvdXIgbm93Lg0KPiANCj4gUg0KDQo=

