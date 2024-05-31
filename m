Return-Path: <netdev+bounces-99773-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E87B48D6576
	for <lists+netdev@lfdr.de>; Fri, 31 May 2024 17:14:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F52228D474
	for <lists+netdev@lfdr.de>; Fri, 31 May 2024 15:14:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A6FC52F71;
	Fri, 31 May 2024 15:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="JcA8YiTY";
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="NI8/gZq9"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 067182B9CE
	for <netdev@vger.kernel.org>; Fri, 31 May 2024 15:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.153.233
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717168495; cv=fail; b=X6CEXQ6vVKpzwH2cH1BjO997m++DqtwWhZiLZ3ymxip4HxaWKxF2lZsO5H0SRRmpdSAHTjqnyj0Mso2H1S7ClUoNGV1wK0UFZ8ou1+/m7UZoj1TTfpyuTE6Ucu3ZwZz52pVrY+Z+MKDfoe5aSALGREwDJwStnwJFtLilOL2FuiE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717168495; c=relaxed/simple;
	bh=gZltu/LGXgXmGUmBAVy4xaMj2QhdKpS4deXObwxINx4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MYOCJ7P2uFMAro6/RmSli3Hs9hrQpzA7NfXw8RTgla1SL+O0gr7f1meYRPSE6hUXa3xa943CFf+wtBrZZnzPGjD8OyzdK7jVzQ21a0uksMFz0QCEJ7FApCsV5yT0X8p4S/wBthrmm6vdY3NpMDLy0PC4jMd1HnEdw4k6rrHS2fs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=JcA8YiTY; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=NI8/gZq9; arc=fail smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1717168492; x=1748704492;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=gZltu/LGXgXmGUmBAVy4xaMj2QhdKpS4deXObwxINx4=;
  b=JcA8YiTYr9sJdbtGfgToizS8UZQgvQAf0A50AWz//c/RUoIAWF4NtDHs
   F8LxQIvl4QfBhmu3M0+T8XoSJ9djoZTcNSKwH8uNy3JModkyN96eJL6bb
   VfxbJnM3c+W0+8qodFYiUGGz47bxReF0KRSYpxx+fubiR6rtP84ocJcnu
   9kydzKW/yTqM+N11PLbNiO0c7JhUxd9tzKXoLkZOikyWQ8FDnCEmy0toc
   N2/kdmw9kwKF2E1n5OE3E3bn/sbvnYWqBjDtolAWb78yrdlpSuWncQG8Z
   zgvWF4WG8l4IVLwh0Zjuo3fqqnwnf/tfGE0Lj1BmatsrmYCaOKDrQVIHu
   w==;
X-CSE-ConnectionGUID: Kv4vGUPDSxmqG8AV+EsEjg==
X-CSE-MsgGUID: Hcs3+iNhQQaeF3o+a4gTrw==
X-IronPort-AV: E=Sophos;i="6.08,204,1712646000"; 
   d="scan'208";a="26810925"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 31 May 2024 08:14:50 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 31 May 2024 08:14:31 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (10.10.215.250)
 by email.microchip.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 31 May 2024 08:14:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XX0R8VvOiCy8B28+mtnV/TFZH1Iq1u0oUZYHDUjdLTS+pNKQf2R5vbRfMjxiIbkgVCSXTVsFbTIVWFGGM3bmjoSXN32+ZZUJum5M+qZzzc/YrQvS7dagRVnELAnYuWrYqZbniDCLSxI/tsn9OqpYVKmMtMCVKD/dzFea2lknC4P81cV6YywPk36vjMd3RhpJyGB4i2pcOQACFTR1Glu4GRmeQdfhFp8S+J/3ikLygrzRGlds/ggZmDxSHPWslxT/mIdQzQYtm2l3lgNaySE3bA/4hvl/MuTEngO1wuwySnJ27RRDBfiGDyiVDEqHczx5gIcUzEIdaLt78tCFmToE1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gZltu/LGXgXmGUmBAVy4xaMj2QhdKpS4deXObwxINx4=;
 b=Gqr40mKwYuwRlzUmWbUYlSYRhvENtf314DNiItS6cpi7aLc1F0E7iIrrh3IPa6efF/IYZgxpSMKBDMOgn3M/dZxaX7MtBmDPjXC5QcXjfNFKJ5IOwMWIMcDyoMtY85X206DNmpBdZ5JLpmHN2ibG0g1wIwdfGDXlFZlMVUb3LyhLZCr4UXvNXeJn9XAAV5OK1UWNkV+AKPSq0UJPCURULLz0rP1UfvrBNMiOl+aGb7kSsn+XLUKhpPcSIlYxyW8IPuNE4rGMgGs8K6L34Mk02FUeUC6KaOwiYjAs7Q/BJE3R3kcgD2GGaF7jf2ps9MRLLamNZV4sxUM50eA54DVfCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gZltu/LGXgXmGUmBAVy4xaMj2QhdKpS4deXObwxINx4=;
 b=NI8/gZq9UZkmn7HRJSC2d60ChTrh88p8TG7pstwkPqYvtF7EQujr6hVie1ReCOMBwMGsJVJCpbYR+zdYYx/Te/VLleb0mpI3snwveZLnbfbaHiMSQlbwf9NkdJitZNj07mh4fPWNvR9ERHHOH6gIEYAsIRkNJEuNz52YW5tsUNzP3yugY5msA3KxYNCoe3AS77D7eBErMhdgrOK4+JrlAqbSbHh8F+nGMMSFA6K1HoJoEf2n1CPSBUcq5tb7jwsGL74vSMnxFAFAQJgnSZkzj8veAA6vyDJRGyf7bCCLeocLDFUxRvCMQdpfcltI8BDINPwlSh1WtivDbFnzff0lFw==
Received: from SA3PR11MB8047.namprd11.prod.outlook.com (2603:10b6:806:2fc::22)
 by SJ0PR11MB6768.namprd11.prod.outlook.com (2603:10b6:a03:47f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.21; Fri, 31 May
 2024 15:14:29 +0000
Received: from SA3PR11MB8047.namprd11.prod.outlook.com
 ([fe80::a585:a441:db24:b547]) by SA3PR11MB8047.namprd11.prod.outlook.com
 ([fe80::a585:a441:db24:b547%3]) with mapi id 15.20.7633.018; Fri, 31 May 2024
 15:14:29 +0000
From: <Arun.Ramadoss@microchip.com>
To: <enguerrand.de-ribaucourt@savoirfairelinux.com>, <netdev@vger.kernel.org>
CC: <linux@armlinux.org.uk>, <Woojung.Huh@microchip.com>,
	<hkallweit1@gmail.com>, <UNGLinuxDriver@microchip.com>, <andrew@lunn.ch>
Subject: Re: [PATCH net v4 5/5] net: dsa: microchip: monitor potential faults
 in half-duplex mode
Thread-Topic: [PATCH net v4 5/5] net: dsa: microchip: monitor potential faults
 in half-duplex mode
Thread-Index: AQHas2ZhtHh0WQDHwUuzRwBsmDOnorGxdCQA
Date: Fri, 31 May 2024 15:14:29 +0000
Message-ID: <f24ce57f4e24da7c058ed15ecf2b7bf25237e998.camel@microchip.com>
References: <20240530102436.226189-1-enguerrand.de-ribaucourt@savoirfairelinux.com>
	 <20240531142430.678198-1-enguerrand.de-ribaucourt@savoirfairelinux.com>
	 <20240531142430.678198-6-enguerrand.de-ribaucourt@savoirfairelinux.com>
In-Reply-To: <20240531142430.678198-6-enguerrand.de-ribaucourt@savoirfairelinux.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.36.5-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA3PR11MB8047:EE_|SJ0PR11MB6768:EE_
x-ms-office365-filtering-correlation-id: bd0c13db-b790-4b42-84bf-08dc81845df8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|1800799015|376005|366007|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?STE0TW5zbXRXbHo3eGJvYUQ3a1FaRmx4cnpZOHlsRk9VWFAvSlBTR1U5Vngr?=
 =?utf-8?B?UUx3NzRXZGpwOFFJS2QwdVg2Wm96OG1QVlIwUmczM0F5V0lnYUhBcHJFRm9W?=
 =?utf-8?B?YmFnZzk5TlJUYi91WkZjRnFJSE9WWXJKNjBPZExvMTlTSkVaRzhLN3VDeTdQ?=
 =?utf-8?B?ZEZjMnVqdlRvZEhXMHNObkloVDlrT3ZUaGZUN255R3d4Q1NJaHRvUXVic1ZJ?=
 =?utf-8?B?SUphS0JsSzU1OEJBQ1J5YkozL0lEVDg5WFJtbkZyQzFpZ2JYeU9WUE0xL0xw?=
 =?utf-8?B?Q2c1SXB0d2ZLSmZ1YkdUV1dNL2dBeEtEZUNPdjRYY1lndFB1U0FFUFJHbVVE?=
 =?utf-8?B?ZEZOR0NNNkFqYkI3VWxONHNnVElCKytMRXQ0VjBrUk5ScVUwZkk5aFpvNlNl?=
 =?utf-8?B?TWE2ZEV0VnhROCtiZGNtbzlpOFhGbCtBbTV5bFhmWkpPNGhGM0NTVFFNNHFF?=
 =?utf-8?B?U0VFQlhTc3Uzb3RVNnFqc0xkYndzeHNHRTZNM0tuWWdOZkNkY2xrSWpNM3BX?=
 =?utf-8?B?andnalVuRm9ZUGdKWjU4b3FUY2p2L1Z3Q1UrQko1VnZSZjJDdjh0SFJ4UWNY?=
 =?utf-8?B?SGdxUnA3RXVYUFcyNnBNRll6UlIyNU0wbVZNa0hIWVFUNVNPVHVBMVpJNHdG?=
 =?utf-8?B?QjBzaXlIWjE3T1Zhdi9ZRWVScUFoY0Voa2xwTlYvczJWQWZCUFVVVzFlNFFh?=
 =?utf-8?B?dHVLT1dzQWc3ZTNLaWtvdXgxcHNUR3FEZ0pleklLdFpTc1RBc1lDVzBOTFMx?=
 =?utf-8?B?bTRuS1JPaDBaOE1pMzJCTzJXR1FwYld4YUhybkdaN1owZElMbG9zQW52NUMv?=
 =?utf-8?B?ZjdjR3hFZDQyTHhVRmwrODA5WXFJTVVVRnoxT04rT2x2cnVhZzYwSmNKWlpy?=
 =?utf-8?B?UHlGVklwSVpiUkVGYnZSY1FFM3Qxb3hBUkFrR2JRRTRGcEJlSVRMS3gzR2Rm?=
 =?utf-8?B?VzJlWURZMFlSZ3NpNXQ1VTJsdTIzWUlPeXJ3MEVSWTN2WThNSDZUSDlBUDZK?=
 =?utf-8?B?Z0NKQSs5Qld4c0ZBc1VWSHJFdFZpd1ZHZFY4cmowRWlsN0NIeTNGYUdPWjg3?=
 =?utf-8?B?czdHNEY5a0djV09Ybm5jNDIrbTdVYm5iUDJCTHVGblozYWIxeDFiWTRPa01X?=
 =?utf-8?B?YmxBVnNTMG1iM3ZhM2tXQnU5aHFwNWVkYlFyd1hFbFFUUklzN0hieTRsSVFz?=
 =?utf-8?B?bWFyMUNWOTEwb3JIbW5FdXlEMTRZanlCQzc2bzdUT2NaZFJ4NEcwL3IvUDRy?=
 =?utf-8?B?VVVublMxNHJYUHhwNklhMFZpa2FVanN5ZFdVR0RDM3FsQlhmOFpnNVVyb2hF?=
 =?utf-8?B?MGUxbml0NzFPOFd4Q2o5YkI5TzhqZ1J0UGM4TklOWmxjWUIxTURVM0IzeG5p?=
 =?utf-8?B?RE5DdFpGL1VPMWcxU2ZrSmFKM0ZWZ1Ird2wzSEtYbGxLTHJhZ2ZET0VwRWZK?=
 =?utf-8?B?dStDeUxVRXFaRDdCK0Z3L1YzakRCUWN6Sm9iZmJnWHNoc1NiWWl3UTVpSTBX?=
 =?utf-8?B?TDdGMTgvK2ZMdWo5TklZdXlUNkczS0J3SmFPMVdhVFUrVlpjb3psVUVjblZj?=
 =?utf-8?B?SUtKSW5VandnRkR6bnNSVERYaEhLRkJKTGR1QjYzSVFnMmlESUdHc1NPRk8v?=
 =?utf-8?B?T0xwdjJibFRxaXZ2VUU1QTVYVjVENWZIbDE5bHoxYUY0d3IzcEh0NHBpMzFo?=
 =?utf-8?B?NEhlVEg1QU1hYTlYeTkveUFZNnFDbXI4UmRTSWVBT3U3V2pQUmRmMFVqZmpE?=
 =?utf-8?B?L2VpRldQUlZocFQ4dEJ2NEc0SzdHTWxXQjQyL1Q2VUtiOUtZVGEwL2ZJTjZz?=
 =?utf-8?B?N0c1MW81WmJOR1VMeGhidz09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR11MB8047.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?N09NWmZHaGlLM3RXTVRUZVd1SXNkbjdoUWNCbFR3UDg2TWIybnRuRTR6KzZk?=
 =?utf-8?B?SHhVRUEyU2tGRGFSSUVCWnE1c2JNdGxISkFQdWQxTmcyNnFLNGE4alVwYlZ1?=
 =?utf-8?B?WnpXQndKRkhsTU43TlZVeE9URm9JRnRCRlpvQVpjbjMwUDIxaGFwVnMwMDNo?=
 =?utf-8?B?dXRrbmpXQVBQL0VLcmlUbENFT01XdUE2eStQeTdBZmpndllwdURuZmJLYUJ2?=
 =?utf-8?B?WmVjcDNUUHFDRHg3U041MGhkL0lCcDNvUmxNS1Z1TXlYU1dRMzVnS3haSHYz?=
 =?utf-8?B?NzBmeXlhMzQwVjJMWXZXdi9PdXZhcXJJdHNTWU5FWmtmNnhNbnJQS1RaL0Nl?=
 =?utf-8?B?WnA3WXhLYUhNV3pQVmQ3UlJOdytOT0JsQUlUeGl4ZGoxQ1VmaG9CVnJsWisr?=
 =?utf-8?B?b25Ub21yWWFPRDdxTmpUK2luTEcrRDlVd3VObnRkajI4M0d1ZXpRRnloNkV1?=
 =?utf-8?B?bmNmbmNtOWZJN2paeWtQb2owR09KS0pKeXNJMlVDY0xnbVRZbHc5Vm5PalNR?=
 =?utf-8?B?S08zd2wra0sxSUJxaS9pTlU5cmFMT05Xb0EydGxhOHBFRFRpQmkyeERmekV2?=
 =?utf-8?B?OVRQS1JSeWZtUGVaN2R0VFpRakFPSU5UQVhzWitSbjAxNlNkN3hWSU5vclBQ?=
 =?utf-8?B?U0M3algrZXNveDhEMFpoTHlrMWRlNFlHd0lUSnQxalU0N1VLN1RQV2dheXkr?=
 =?utf-8?B?cnREaVNDRE43dVcydHoyUm90ZWY2SS9tNHhsWlZ6SnhNQ29Ta2l2dzYxUC84?=
 =?utf-8?B?UHVSMENWckttM2c2UXh3a21DM0Mwa0F4LzEwVGZFdTdsbFBkU2hhaFVvemVM?=
 =?utf-8?B?eTg3M2xJcVJmR2Evenc2T1ZESGMxUlJZOC9MbHJmcFNOMVZ2WHE2ekN6NzFq?=
 =?utf-8?B?MGw4V3dnTDNyUlVOMzlyUkFLRjZLZktHZGgvSUlreG9BT0lEVHlDb0Y1L3FU?=
 =?utf-8?B?Qm5Wc3B1YmR2UUdUYnAvcmFkbkZXV1lQZUoxZDZwcUlWS2F1dHdGdXFxTlJo?=
 =?utf-8?B?VXJEUlNSelcveXljUUhqMG9SWGF1V3YvRnBCTmhPdm5jeFlHamJ1bFJETmlh?=
 =?utf-8?B?R1hsczNRM3JCSU5HcFVueHJUb0x2V0xCajJ4aDNIOGU3aGVUWVdNQ3FjRzBL?=
 =?utf-8?B?cWVSbmtNd2V5Ri9jOVhHOEtJZW5GbEVwNC91NXRHd0xFRWVFUVNPMUdXd1VS?=
 =?utf-8?B?REVIV2NMTVNxNlRvSG03d1JhVmZpUk5Obll6T2RHZUo1N0tRWTdINW1pWExY?=
 =?utf-8?B?bm50aDdSdzRXRWFad2lvOW1JT1VteXhVYXg1U1hMZGREYzdxVDFZaytGb0hW?=
 =?utf-8?B?UnhGSUtldUI1OXY5TStOMmtmY2lHd3hFTXcxa2hGLzEvWW80a0htcFo3U2xY?=
 =?utf-8?B?ZncveGJqdjlPQ0U0WXQzVFhEWG5sZzF4eWhuWE53YTFoVGtjMWdhR1pGU1ZS?=
 =?utf-8?B?Ly8veGxFTm03SkNCVkpaUzJxSEFqL3ZKL2RzS20yN0x4V1pTb0VsM1BCVFFi?=
 =?utf-8?B?L0w0cTBHNkFLcnZlU3J3d0F5NE9odFpqYlhsRDk3OEpkazQ0T3hGOWQ5STNV?=
 =?utf-8?B?d2ZTT2RxcWk3QnVoYXMyRmI3bHZ4SWNJVDFnYmZTQ1JROWtucER5ZlFWL2tG?=
 =?utf-8?B?ZENmVzVGeVhvYXFVWDUvK0RkVEZkUjg5aDNjMjYrTDRJWDhpNkVMOXpLN2Zy?=
 =?utf-8?B?UWdwQ3pOL2lwV09HT2tRQlBEQnhlNFlLMU94cXNWSXVCdkhDQ2xTWXRkcjgx?=
 =?utf-8?B?RkU4YzZzcGxYMllzYzFxMXI2SkVTRnRVY2pYMSs1RHhrSUFlcjBySVRkNTVD?=
 =?utf-8?B?ZEl2dkVQcENjR0tyL0N2UUVEK0E4NS9iZitRR0hYZVR1b2duTi9KNGRzSzht?=
 =?utf-8?B?eFc3eFo5NU5Pa1FPbEMyemdkWjhIY3B4b2lXRWV0YlRwS3BPT1pjRUJ0U3Zi?=
 =?utf-8?B?VTZwbThTQkZZNXUwUVgxck9vZTFSWE1GYlFxMEVQckhndi9VckdrZm8rT1dz?=
 =?utf-8?B?R1NMM3RHSnJML2hTbUIxTTFsZGhXRE5nWUtyTnJ2M1RpUTJtOEh0NUg0Ulh3?=
 =?utf-8?B?dHBkQnlKUWQyam41OE00SzR1YVozUHVxdGFUZFduakFYd3dWc1ZTVTB5S0x6?=
 =?utf-8?B?UGUzTmJaOEdXL3hic3lTVERlZ3NyOTFlWFQ3dzZIL1ZBbHY5bFlRdTFjMktr?=
 =?utf-8?B?Q3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <79FFCC72C24D64479F6B40F56FB548F8@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA3PR11MB8047.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd0c13db-b790-4b42-84bf-08dc81845df8
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 May 2024 15:14:29.1957
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Lgye6nPF2VU2yS2KBqZ07M8WbyS6kzeQpxhIb8dkIRc9Y9TJkYpB6i8QofGvzAj2zJ7ywqGXvJKpGumIcGRVaKcAArawJcYEGoAQ1lgiyUg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB6768

SGkgRW5ndWVycmFuZCwNCg0KT24gRnJpLCAyMDI0LTA1LTMxIGF0IDE0OjI0ICswMDAwLCBFbmd1
ZXJyYW5kIGRlIFJpYmF1Y291cnQgd3JvdGU6DQo+IEVYVEVSTkFMIEVNQUlMOiBEbyBub3QgY2xp
Y2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3MgeW91DQo+IGtub3cgdGhlIGNvbnRl
bnQgaXMgc2FmZQ0KPiANCj4gVGhlIGVycmF0YSBEUzgwMDAwNzU0IHJlY29tbWVuZHMgbW9uaXRv
cmluZyBwb3RlbnRpYWwgZmF1bHRzIGluDQo+IGhhbGYtZHVwbGV4IG1vZGUgZm9yIHRoZSBLU1o5
NDc3IGZhbWlsbHkuDQo+IA0KPiBoYWxmLWR1cGxleCBpcyBub3QgdmVyeSBjb21tb24gc28gSSBq
dXN0IGFkZGVkIGEgY3JpdGljYWwgbWVzc2FnZQ0KPiB3aGVuIHRoZSBmYXVsdCBjb25kaXRpb25z
IGFyZSBkZXRlY3RlZC4gVGhlIHN3aXRjaCBjYW4gYmUgZXhwZWN0ZWQNCj4gdG8gYmUgdW5hYmxl
IHRvIGNvbW11bmljYXRlIGFueW1vcmUgaW4gdGhlc2Ugc3RhdGVzIGFuZCBhIHNvZnR3YXJlDQo+
IHJlc2V0IG9mIHRoZSBzd2l0Y2ggd291bGQgYmUgcmVxdWlyZWQgd2hpY2ggSSBkaWQgbm90IGlt
cGxlbWVudC4NCj4gDQo+IA0KPiAgDQo+IA0KPiArdm9pZCBrc3o5NDc3X2VycmF0YV9tb25pdG9y
KHN0cnVjdCBrc3pfZGV2aWNlICpkZXYsIGludCBwb3J0LA0KPiArICAgICAgICAgICAgICAgICAg
ICAgICAgICAgdTY0IHR4X2xhdGVfY29sKQ0KPiArew0KPiArICAgICAgIHUzMiBwbWF2YmM7DQo+
ICsgICAgICAgdTggc3RhdHVzOw0KPiArICAgICAgIHUxNiBwcW07DQo+ICsNCj4gKyAgICAgICBr
c3pfcHJlYWQ4KGRldiwgcG9ydCwgUkVHX1BPUlRfU1RBVFVTXzAsICZzdGF0dXMpOw0KDQpJdCBn
b29kIHRvIGNoZWNrIHJldHVybiB2YWx1ZSBmb3Iga3N6X3ByZWFkOC8xNi8zMi4NCg0KPiArICAg
ICAgIGlmICghKChzdGF0dXMgJiBQT1JUX0lOVEZfU1BFRURfTUFTSykgPT0NCj4gUE9SVF9JTlRG
X1NQRUVEX01BU0spICYmDQo+ICsgICAgICAgICAgICEoc3RhdHVzICYgUE9SVF9JTlRGX0ZVTExf
RFVQTEVYKSkgew0KPiArICAgICAgICAgICAgICAgZGV2X3dhcm5fb25jZShkZXYtPmRldiwNCj4g
KyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIkhhbGYtZHVwbGV4IGRldGVjdGVkIG9uIHBv
cnQgJWQsDQo+IHRyYW5zbWlzc2lvbiBoYWx0IG1heSBvY2N1clxuIiwNCj4gKyAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgcG9ydCk7DQo+ICsgICAgICAgICAgICAgICAvKiBFcnJhdGEgRFM4
MDAwMDc1NCByZWNvbW1lbmRzIG1vbml0b3JpbmcgcG90ZW50aWFsDQo+IGZhdWx0cyBpbg0KPiAr
ICAgICAgICAgICAgICAgICogaGFsZi1kdXBsZXggbW9kZS4gVGhlIHN3aXRjaCBtaWdodCBub3Qg
YmUgYWJsZSB0bw0KPiBjb21tdW5pY2F0ZSBhbnltb3JlDQo+ICsgICAgICAgICAgICAgICAgKiBp
biB0aGVzZSBzdGF0ZXMuDQo+ICsgICAgICAgICAgICAgICAgKi8NCj4gKyAgICAgICAgICAgICAg
IGlmICh0eF9sYXRlX2NvbCAhPSAwKSB7DQo+ICsgICAgICAgICAgICAgICAgICAgICAgIC8qIFRy
YW5zbWlzc2lvbiBoYWx0IHdpdGggbGF0ZSBjb2xsaXNpb25zICovDQo+ICsgICAgICAgICAgICAg
ICAgICAgICAgIGRldl9jcml0X3JhdGVsaW1pdGVkKGRldi0+ZGV2LA0KPiArICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAiVFggbGF0ZSBjb2xsaXNpb25zDQo+IGRl
dGVjdGVkLCB0cmFuc21pc3Npb24gbWF5IGJlIGhhbHRlZCBvbiBwb3J0ICVkXG4iLA0KPiArICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBwb3J0KTsNCj4gKyAgICAg
ICAgICAgICAgIH0NCj4gKyAgICAgICAgICAgICAgIGtzel9wcmVhZDE2KGRldiwgcG9ydCwgUkVH
X1BPUlRfUU1fVFhfQ05UXzBfXzQsDQo+ICZwcW0pOw0KPiArICAgICAgICAgICAgICAga3N6X3Jl
YWQzMihkZXYsIFJFR19QTUFWQkMsICZwbWF2YmMpOw0KPiArICAgICAgICAgICAgICAgaWYgKCgo
cG1hdmJjICYgUE1BVkJDX01BU0spID4+IFBNQVZCQ19TSElGVCA8PSAweDU4MCkNCg0KbWFnaWMg
bnVtYmVycyBjYW4gYmUgcmVwbGFjZWQgYnkgbWFjcm9zLg0KQWxzbyBpdCBjYW4gYmUgcmVwbGFj
ZWQgYnkgRklFTERfR0VUKFBNQVZCQ19NQVNLLCBwbWF2YmMpDQo+IHx8DQo+ICsgICAgICAgICAg
ICAgICAgICAgKChwcW0gJiBQT1JUX1FNX1RYX0NOVF9NKSA+PSAweDIwMCkpIHsNCj4gKyAgICAg
ICAgICAgICAgICAgICAgICAgLyogVHJhbnNtaXNzaW9uIGhhbHQgd2l0aCBIYWxmLUR1cGxleCBh
bmQNCj4gVkxBTiAqLw0KPiArICAgICAgICAgICAgICAgICAgICAgICBkZXZfY3JpdF9yYXRlbGlt
aXRlZChkZXYtPmRldiwNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgInJlc291cmNlcyBvdXQgb2YNCj4gbGltaXRzLCB0cmFuc21pc3Npb24gbWF5IGJlIGhh
bHRlZFxuIik7DQo+ICsgICAgICAgICAgICAgICB9DQo+ICsgICAgICAgfQ0KPiArfQ0KPiArDQo+
ICB2b2lkIGtzejk0NzdfcG9ydF9pbml0X2NudChzdHJ1Y3Qga3N6X2RldmljZSAqZGV2LCBpbnQg
cG9ydCkNCj4gIHsNCj4gICAgICAgICBzdHJ1Y3Qga3N6X3BvcnRfbWliICptaWIgPSAmZGV2LT5w
b3J0c1twb3J0XS5taWI7DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC9kc2EvbWljcm9jaGlw
L2tzejk0NzcuaA0KPiBiL2RyaXZlcnMvbmV0L2RzYS9taWNyb2NoaXAva3N6OTQ3Ny5oDQo+IGlu
ZGV4IGNlMWU2NTZiODAwYi4uMzMxMmVmMjhlOTljIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL25l
dC9kc2EvbWljcm9jaGlwL2tzejk0NzcuaA0KPiArKysgYi9kcml2ZXJzL25ldC9kc2EvbWljcm9j
aGlwL2tzejk0NzcuaA0KPiBAQCAtMzYsNiArMzYsOCBAQCBpbnQga3N6OTQ3N19wb3J0X21pcnJv
cl9hZGQoc3RydWN0IGtzel9kZXZpY2UgKmRldiwNCj4gaW50IHBvcnQsDQo+ICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICBib29sIGluZ3Jlc3MsIHN0cnVjdCBuZXRsaW5rX2V4dF9hY2sNCj4g
KmV4dGFjayk7DQo+ICB2b2lkIGtzejk0NzdfcG9ydF9taXJyb3JfZGVsKHN0cnVjdCBrc3pfZGV2
aWNlICpkZXYsIGludCBwb3J0LA0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHN0cnVj
dCBkc2FfbWFsbF9taXJyb3JfdGNfZW50cnkNCj4gKm1pcnJvcik7DQo+ICt2b2lkIGtzejk0Nzdf
ZXJyYXRhX21vbml0b3Ioc3RydWN0IGtzel9kZXZpY2UgKmRldiwgaW50IHBvcnQsDQo+ICsgICAg
ICAgICAgICAgICAgICAgICAgICAgICB1NjQgdHhfbGF0ZV9jb2wpOw0KPiAgdm9pZCBrc3o5NDc3
X2dldF9jYXBzKHN0cnVjdCBrc3pfZGV2aWNlICpkZXYsIGludCBwb3J0LA0KPiAgICAgICAgICAg
ICAgICAgICAgICAgc3RydWN0IHBoeWxpbmtfY29uZmlnICpjb25maWcpOw0KPiAgaW50IGtzejk0
NzdfZmRiX2R1bXAoc3RydWN0IGtzel9kZXZpY2UgKmRldiwgaW50IHBvcnQsDQo+IGRpZmYgLS1n
aXQgYS9kcml2ZXJzL25ldC9kc2EvbWljcm9jaGlwL2tzejk0NzdfcmVnLmgNCj4gYi9kcml2ZXJz
L25ldC9kc2EvbWljcm9jaGlwL2tzejk0NzdfcmVnLmgNCj4gaW5kZXggZjNhMjA1ZWU0ODNmLi4z
MjM4Yjk3NDhkMGYgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvbmV0L2RzYS9taWNyb2NoaXAva3N6
OTQ3N19yZWcuaA0KPiArKysgYi9kcml2ZXJzL25ldC9kc2EvbWljcm9jaGlwL2tzejk0NzdfcmVn
LmgNCj4gQEAgLTg0Miw4ICs4NDIsNyBAQA0KPiANCj4gICNkZWZpbmUgUkVHX1BPUlRfU1RBVFVT
XzAgICAgICAgICAgICAgIDB4MDAzMA0KPiANCj4gLSNkZWZpbmUgUE9SVF9JTlRGX1NQRUVEX00g
ICAgICAgICAgICAgIDB4Mw0KPiAtI2RlZmluZSBQT1JUX0lOVEZfU1BFRURfUyAgICAgICAgICAg
ICAgMw0KPiArI2RlZmluZSBQT1JUX0lOVEZfU1BFRURfTUFTSyAgICAgICAgICAgMHgwMDE4DQoN
Cm5pdHBpY2s6IGl0IGNhbiBiZSByZXBsYWNlZCBieSBHRU5NQVNLKDQsMykNCg0KPiAgI2RlZmlu
ZSBQT1JUX0lOVEZfRlVMTF9EVVBMRVggICAgICAgICAgQklUKDIpDQo+ICAjZGVmaW5lIFBPUlRf
VFhfRkxPV19DVFJMICAgICAgICAgICAgICBCSVQoMSkNCj4gICNkZWZpbmUgUE9SVF9SWF9GTE9X
X0NUUkwgICAgICAgICAgICAgIEJJVCgwKQ0KPiBAQCAtMTE2Nyw2ICsxMTY2LDExIEBADQo+ICAj
ZGVmaW5lIFBPUlRfUk1JSV9DTEtfU0VMICAgICAgICAgICAgICBCSVQoNykNCj4gICNkZWZpbmUg
UE9SVF9NSUlfU0VMX0VER0UgICAgICAgICAgICAgIEJJVCg1KQ0KPiANCj4gKyNkZWZpbmUgUkVH
X1BNQVZCQyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgMHgwM0FDDQo+ICsNCj4gKyNkZWZp
bmUgUE1BVkJDX01BU0sgICAgICAgICAgICAgICAgICAgICAgICAgICAgMHg3ZmYwMDAwDQoNCm5p
dHBpY2s6IGl0IGNhbiBiZSByZXBsYWNlZCBieSBHRU5NQVNLKDI2LCAxNikNCg0KPiArI2RlZmlu
ZSBQTUFWQkNfU0hJRlQgICAgICAgICAgICAgICAgICAgMTYNCj4gKw0KPiAgLyogNCAtIE1BQyAq
Lw0KPiAgI2RlZmluZSBSRUdfUE9SVF9NQUNfQ1RSTF8wICAgICAgICAgICAgMHgwNDAwDQo+IA0K
PiANCj4gDQo=

