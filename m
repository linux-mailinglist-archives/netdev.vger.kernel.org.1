Return-Path: <netdev+bounces-159163-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B695A14944
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 06:50:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9E0207A393D
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 05:50:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D75931D6DC5;
	Fri, 17 Jan 2025 05:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="c5DVKmig"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15C3522619;
	Fri, 17 Jan 2025 05:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.148.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737093016; cv=fail; b=iw9HNiGA/jcYk2mF9cMqJoMc5h/Agh6EngnO5eqpj2Ch2+MNLugfJYlw9n7XKVBCmLnjKc+unPaOPbinY3EjTEtZa/axfXs3r6AJrFBTILG/5EUdE8O5PcVhLuL5og24Du/ztDFGGvuxj0H53TEznWyaQpzKq9+H1d0lD7h/r8o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737093016; c=relaxed/simple;
	bh=GJHoJXM8pPNdB503sE3iNHEjWbLNemEAc7xEXIaTksI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FO/ud2cDe6dpBcDhh+XHSaH9zNcBLji5X4YdLLAkebORu1CSCd+wtMNK+TG+GB7qLGuI+RvtfetjSTeGF1xZKSTMd9Fq5QRMgmpRzWQsE5vNjQT5TTggVAIvgp33J4x+Z6l0JmpgJ/wxCpV08mJ3F28UAhSu9jv9vw3+aF7v4EE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=c5DVKmig; arc=fail smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50H4SaVk028348;
	Thu, 16 Jan 2025 21:49:47 -0800
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2177.outbound.protection.outlook.com [104.47.57.177])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 447g7b03yr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Jan 2025 21:49:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p/v0tQ9OEPDNQSS+RcPT6iQPwYVQ/KFjHaBp6XuhYN04fd/33QxybqvUU3jRwbzEVAWg2Y8yMzr/iZEXviU/vLCU2Ok4dyevDd/rZW/RLrFmyJ2wJjsdwOcvTbdxfHNh2a6BblyfFRAxgGY99scbWsL4PGlaW0sodH3dtXFt5gnYAJ/Kt3gdgM9QZOyLYzYC6W0vigZ68U1cclvrbPfDB/hsssRSt60yZsMAXleEfeOd00OCmQP2xOpIS5U2mX2Oh/96DgObXvILibHJ9RHVE3j4uFVrT2RJ4sBxMMLotKTAPfT/MYSBRI8/6XacyEaPc20EcES1i7Szwh0OiO3rwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GJHoJXM8pPNdB503sE3iNHEjWbLNemEAc7xEXIaTksI=;
 b=Xzl4X2Pw8Xz9bYjRtJZ/uPLIVKuQd0ffYgfykWFcKQOBTHkkEASEXRNONQJwi1VdUsTKUdTl/GFwc8XwUVPzuzS9hEZR9kg0HbX/8KgJ2JVsjtVbBmbOkLx5cEeSDRGhTQUY8d1D/CFfuqJil+D8F/MKwOjU/aAPELmDDvd9oBk7ZFpG4MygkykH0fl0RqzdCP6T0N0gkg7TsZ0SWN4BsrEnvMr/5aaxTN1/Ixo0crdFiIc4+c8T7difvROynB4GGI0Hz6/8meD4J5A18slEOuaMRepSzy2mD5KZjNV79RWae9WHB+9eHGG71+mHZwMGoPHxZJGn7kU3USDFLIs7yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GJHoJXM8pPNdB503sE3iNHEjWbLNemEAc7xEXIaTksI=;
 b=c5DVKmigdu9B2iwetXcI71e3UWaqzcJ7g3us7Baogr3ZPj7d3l4jjfD/Ms9jmOwl8ZB3Y/fxwCXIxw9r75NxEs9kmz7xrYcMBY9e+rr4nw3USq3jCw+ipELCEp/gjZVtfDCc5jiZgau5t4VDC/UsUbM6SuvWxg9JP++kwet17YQ=
Received: from PH0PR18MB4734.namprd18.prod.outlook.com (2603:10b6:510:cd::24)
 by SA1PR18MB5689.namprd18.prod.outlook.com (2603:10b6:806:3a6::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.18; Fri, 17 Jan
 2025 05:49:43 +0000
Received: from PH0PR18MB4734.namprd18.prod.outlook.com
 ([fe80::8adb:1ecd:bca9:6dcd]) by PH0PR18MB4734.namprd18.prod.outlook.com
 ([fe80::8adb:1ecd:bca9:6dcd%5]) with mapi id 15.20.8335.017; Fri, 17 Jan 2025
 05:49:43 +0000
From: Shinas Rasheed <srasheed@marvell.com>
To: Jakub Kicinski <kuba@kernel.org>,
        Larysa Zaremba
	<larysa.zaremba@intel.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Haseeb Gani
	<hgani@marvell.com>, Sathesh B Edara <sedara@marvell.com>,
        Vimlesh Kumar
	<vimleshk@marvell.com>,
        "thaller@redhat.com" <thaller@redhat.com>,
        "wizhao@redhat.com" <wizhao@redhat.com>,
        "kheib@redhat.com"
	<kheib@redhat.com>,
        "konguyen@redhat.com" <konguyen@redhat.com>,
        "horms@kernel.org" <horms@kernel.org>,
        "einstein.xue@synaxg.com"
	<einstein.xue@synaxg.com>,
        Veerasenareddy Burru <vburru@marvell.com>,
        Andrew
 Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
Subject: RE: [EXTERNAL] Re: [PATCH net v8 2/4] octeon_ep: update tx/rx stats
 locally for persistence
Thread-Topic: [EXTERNAL] Re: [PATCH net v8 2/4] octeon_ep: update tx/rx stats
 locally for persistence
Thread-Index: AQHbZ/IIxKpUL8HISEa62Brb9QckaLMZhhUAgACXH4CAAD1vcIAAHDhQ
Date: Fri, 17 Jan 2025 05:49:43 +0000
Message-ID:
 <PH0PR18MB4734EDD37FBEC7E82A5C2077C71B2@PH0PR18MB4734.namprd18.prod.outlook.com>
References: <20250116083825.2581885-1-srasheed@marvell.com>
	<20250116083825.2581885-3-srasheed@marvell.com>
	<Z4klGpVVsxOPR3RZ@lzaremba-mobl.ger.corp.intel.com>
 <20250116162711.71d74e10@kernel.org>
 <PH0PR18MB47349A17C33D8665C32513DAC71B2@PH0PR18MB4734.namprd18.prod.outlook.com>
In-Reply-To:
 <PH0PR18MB47349A17C33D8665C32513DAC71B2@PH0PR18MB4734.namprd18.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR18MB4734:EE_|SA1PR18MB5689:EE_
x-ms-office365-filtering-correlation-id: 1f4ab482-f5eb-4b48-40c5-08dd36babe16
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?UStZZzlmYkxTZXlSZlh1SjFlYjFHR3QydFdnZlVOMkhzc0p0QjNVY3NCbE1x?=
 =?utf-8?B?ZHlDZStSWmlXdmxER29CNFo2Slo0QWFjSTdpQnQvNlBrUjRhQUxtcFd4U3d1?=
 =?utf-8?B?UHBEdUhSanFMcTFmNCtkQmViRmppY1BvV0JiczRMaXBQZGRLN0lwcEdVL2Nv?=
 =?utf-8?B?ZGVFMEFUTnRzeUhJYXlqckdWeC9ETExyK3pmanZpbG95YWNPVjBuYkZTV3FT?=
 =?utf-8?B?RFQ1Tm9kL1c5cUVCRlp0SHM3MkdPT0lGUlhuR01FMUtUaDJ6bkhFd2NPKzdU?=
 =?utf-8?B?NWlPVlYrOWdBZWtkK1ZDN1B5MXJJRk52ck1id0orbUhuWCtOc1RKS3pkRXdx?=
 =?utf-8?B?QzFBWkhNVVV4bkpPVC81RWM0aC9BNzlPem9OaWFOSmExS3M2WS9lZ1dBcE5S?=
 =?utf-8?B?RTZLd3laQm92RUZjdi9YSkMvd0hseURpZmNpUmVSaWNXcFl1TDhwaml4WDJr?=
 =?utf-8?B?MENVbGdsN0hWMXRlSjNtZnJ2U2p1OEZrVW9icVVaMEFRWGJBWWJXWU53S1VR?=
 =?utf-8?B?UzlYTkNGc2FpRnhCODEybFpKQWdDNWZUeFlyV2N4QVY4M1VxbnZKRE9YYUJJ?=
 =?utf-8?B?MDg5b0dEc21tR21QcldPR0xJcFJuN1ZLMkJEVXV5UEJqTFM4MGE3TmxCVVAy?=
 =?utf-8?B?b2lIVnM2SHNvakxZaHIzVGZ2ejIyNmNkbUZQdFlFT0tKbXBzS00zbjVmWDVD?=
 =?utf-8?B?bEdwU0t3QlRFWnM3TFQrS0o5ajg4bTU2b2tHb2hnNG43MFczY241RmxwL2Zp?=
 =?utf-8?B?STBpREJCTGVjV3lrajB4K1Fkd2hBSkpLZFdoL0VxWm1ZcFBSMFNTVGpiSTFI?=
 =?utf-8?B?TzVWMkhxSnhIaHNCOC9mREhuOVlsYzUyR2ZPWkZBazVGMEFkQXdLa1pDakRQ?=
 =?utf-8?B?OG1mMVBQUXh0TVhOOVppK2JuZkxVVUhEOGVBSUx6VUFFYW1pS2Yxc3dkc1hv?=
 =?utf-8?B?bTgzRFB5bDVQVjdIRVk5Y1d4UzBoaEt1blcyNWtLcnZ5ckV0YnZkY3BqTm1R?=
 =?utf-8?B?WEFVUU5SY0R3YUc5UXRLUXh5a1dWekhpRkU5THJXR3IrY2xidE9wYVhEbEE3?=
 =?utf-8?B?TkFITG9tRjhqVWdnbVRPdENKSTc3aDZDQWV5NnpPZ21xcW1oVXphKzJ6NGtB?=
 =?utf-8?B?NkpOTHp4Y3FpSjlMMDZwS3B4Q3VYcHJNV2w1NWkzVjk0dkM5UituYWpUZE1t?=
 =?utf-8?B?ZnBMYmFRZjRkQWNrMjc2QzVqZWpiNGJkN1pWZTRPdVViK3JqbGVlZkNmbm1U?=
 =?utf-8?B?NXlzSFJlV0g5RzQwKzR1NGpqUTRnT3VOajc0THoyV09OS2MxVHd3NXVwaFRu?=
 =?utf-8?B?ZHNseWZINEk1OE1pWEhCRXNWcEYxVVJBOTZ6aTdha3FPMVIrb1NNMWJnY0tJ?=
 =?utf-8?B?bVE4eFFGQTErTlUvczdMK0s4SFZKVU53SEpBYWs0RWZWZXR3dUsvUVhoWno5?=
 =?utf-8?B?K1lMSmJONjFGdU1oWTRNV1VsbmNDS0htaWw3cnJVV0FJNE5YT2NjWE9lVjdD?=
 =?utf-8?B?UjVJUEJPRUdockZUVjhCQ2dRc0cxUmZNYjI5TnJmMGJ6bnhhTEhHLzVWMk54?=
 =?utf-8?B?RnFRem4zVDZoRUFsN21YSEF3RGZRNTg0NFZRek45WE9uc09VTWRreXpzQTR2?=
 =?utf-8?B?TXExYmwrd0hac1dDanJPOGZmL0w2bVhib3duUER3ZmFXdjA5dHNWK2xoUHdY?=
 =?utf-8?B?VmRnd1UyYlhETFV2N0RwZFc4M3FHWkdNakxWK2FIRHZRREtZaHBpRzE3bXNR?=
 =?utf-8?B?QjVEOXIzTnpiQ2R5R25HSFpVWldvM3RMY3Uzck9pSTAxT3F1c2o1RWxhd3ZQ?=
 =?utf-8?B?MjRjeGNYeDBFV0w2dUxjOVlFeGluZTFRRzNYR2RnYk5KUENNRmhkbys3QWl0?=
 =?utf-8?B?Q1hqenloWUd5OXIwUllnRURVTG9GVzZYbDltSnJmeG5nS042TVJveUdoL0VU?=
 =?utf-8?Q?KRPZn7lVvLHxigTLn0kS/t5IBJ5TB7ph?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR18MB4734.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?d1JYdGhtZnY5TS9tMnFzRDRFWi9vZks3K2NaYmRmYXJ1NDZRbC8ySWw4cGFj?=
 =?utf-8?B?VzEveEdYWXRwWUM1L3JnL0tXSFBIaXpCTEw0Z2tVVnlWZFNQbm1UZjVDT25W?=
 =?utf-8?B?TTY4dGc5QnlHc0FmOEY4MytlcHJKcHY4TDJsTlRoQTNCSGtKVEpJR09iciti?=
 =?utf-8?B?b0J1RElPVWxKb3ZSOG9JL2JsZEJva3NSb2R4ZXJtTDFJdnVQekdlcHNhaEUy?=
 =?utf-8?B?b3RxUXFWQzF6MDJTMk9tRmdZdm5JR093RFUySW9Pb1Zzc3lVZzYzYmNCR0po?=
 =?utf-8?B?UnllbThkQkpCOHY3UGdsb3RZb0hIZmErSXB2cjV6bzFuYzUvM2Rmb0ljK2pv?=
 =?utf-8?B?WURWbVdOWXVWUWpLV2JxVEZrQVJ5NUxzR3hrZkw5cEo3ditiVnZKekpTcUla?=
 =?utf-8?B?VzdFcm9XdGpjOTNGRFp0Yjl3ekFTeEtrbHdGeW1yWDUraVcxbWIyNURzRHA4?=
 =?utf-8?B?azVtbjAvbGZ6QXovb3lickpEMmRmb2UrWEc3UWVTeGFWNE1xUkdBalhEMzBP?=
 =?utf-8?B?N1V3VVpiTXNYZFYvcjZKRi9GclBSTkV4Nkc2WmN5MUxmZFJIQWF1MVpvMmNw?=
 =?utf-8?B?WlFxM0JRM2crT1FLenZsK1lrU3g3cjRwS1JzV2ZaK3hGUTZmUmZvdC9laUV1?=
 =?utf-8?B?MHY5ZWw1bW9DQjg3MHNDbmE3N3NQeFVrY1luK3FiTkFlMjdvUFlmR2E1SDdJ?=
 =?utf-8?B?V3Rua2dpRytQUG45Z0QybkhxNjgvU2pjNEVmeGU1RFF1MndZL0NGVDMzUkc3?=
 =?utf-8?B?WXdlQ0tISytVTkhJQm1pR1lqbTZvS28yamo3QXltcFJrdkFJV2RvR0VDWXNx?=
 =?utf-8?B?TzV5dWdibCtsRTl3aGVBTHNrOTl3OTdBU2FBWWs1M0VzRHdXYllFVkRkMmJv?=
 =?utf-8?B?QytXR1c3eHN4bDhZZEd5NGoyeEhzM0RMaWJRaHg1eXN5QWdkbkhCRk5KWkNQ?=
 =?utf-8?B?RlJxc3RNdDRFQzJUMmprbUg3UmFaNzhGT1Q0alVzcllHK2tNektlWHhYT1Rj?=
 =?utf-8?B?ZjVCaHZjeEY5ZldxaUVGRXlrLzBwOUFvZ3J4YTdjcForSzBoOXlEVGdweWJl?=
 =?utf-8?B?TTdQaUIybnpjcW93T2FZRU41bFRQVGRYUHpPbnJndzdSV2t6aFRHTEhYZ1Nh?=
 =?utf-8?B?emZlM3FPNUVhYzFiMDZGcU9CbFU3RWIxQUNyYlVRbU84MTNVT0lwTzJWajll?=
 =?utf-8?B?b0I5QWp4Zy9UMFlvZDFwRkQ3SXhEdGVvRzBLREF6WG9xZlJLazJKN0tNV084?=
 =?utf-8?B?K3BQUjg3SEtxd21tV1hrM0hHOEsxZmdjMjR2MlE5MDRxVWp2VkxRZW05Q0pK?=
 =?utf-8?B?N3hCTjRQSjVBRDlJR0owbFBXRnZ6SW8zTzlSL0hRYy83NGMrQTNUcDRxUW1D?=
 =?utf-8?B?V3Zjc0p2M0Q0bWhTY0F3MmRWRHdYUWR6L25wMzFGNTZGYU5pMGRwT2Z4eE9w?=
 =?utf-8?B?TjAxSjk4aWI1UFdTVVNRTTZaTmJDSlVQNDdSVzZKSWhvOHhYS1VxV3F2REhN?=
 =?utf-8?B?S2k2VjQwMWZ6Rml6dkkzSUhyUTVLNTdvekplN1l1VnNDVk56TWRKbm1CKzE1?=
 =?utf-8?B?RXRKcm9VMys3YTN2YVdVbDN1c0RPTVVYRGJYV3FTVnUyR2ZoQXBUVmxCalo0?=
 =?utf-8?B?ekg4akhuS29qbUxDQmV6ODA2Nm9QeWFQMnQxRndPUmVlTGVzcVpNNXE4aFhI?=
 =?utf-8?B?YXNqL0tVZndsdGZiOVJhR2lqSkpzV0czQ3pvZkcxYStzWTZXREVJNzNBMjJ5?=
 =?utf-8?B?WVl4Lyt6TEJ6VzVQMWh6R2NXU0ROK2w2ekIycGVCU0RPT3VGalhwS1oxanh6?=
 =?utf-8?B?NklLdEZQam1qL3pxYzY0YmxNcTRFN1FOMnJ3WFJWWXZzT2MxRzFQOERwNXN6?=
 =?utf-8?B?cVhySC9XclFnUnZlR0x5b3AzWHRrUVlPaW9XQjhHNVJHMXcxdE9OZWpZYVo2?=
 =?utf-8?B?NE92T0ozMm9GS2JZNjQ5WTdLMEdGMDJRM0VVN3oyaHplOUdPWFRWUkFROW9a?=
 =?utf-8?B?eU9ZOXNUMlUzT09nZk5kL1oxK3ZJaDNuT0pQc1FRbk56eXcraXBFNk1EcXdQ?=
 =?utf-8?B?WGRLRWw4UGlyMHJTVVRFQUx0Q1ZQdEMzYVQ4Zm5XSFFvTHFXN05vVGtvN2Nw?=
 =?utf-8?Q?cojRgUYePVrMiB56dcgpKJTUN?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR18MB4734.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f4ab482-f5eb-4b48-40c5-08dd36babe16
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jan 2025 05:49:43.7248
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7RHsxdStcCSkKOFJB2TzE4pyp3vTSWbxfJPeWLR3fNSExTAXRMilVd4+La49dtbqAlZDP198zDHxQsbvQkfBDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR18MB5689
X-Proofpoint-GUID: 3N0ip1nfEXqPvp0bzjdELprSfUwoYyJE
X-Proofpoint-ORIG-GUID: 3N0ip1nfEXqPvp0bzjdELprSfUwoYyJE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-17_02,2025-01-16_01,2024-11-22_01

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogU2hpbmFzIFJhc2hlZWQN
Cj4gU2VudDogRnJpZGF5LCBKYW51YXJ5IDE3LCAyMDI1IDk6NDIgQU0NCj4gVG86IEpha3ViIEtp
Y2luc2tpIDxrdWJhQGtlcm5lbC5vcmc+OyBMYXJ5c2EgWmFyZW1iYQ0KPiA8bGFyeXNhLnphcmVt
YmFAaW50ZWwuY29tPg0KPiBDYzogbmV0ZGV2QHZnZXIua2VybmVsLm9yZzsgbGludXgta2VybmVs
QHZnZXIua2VybmVsLm9yZzsgSGFzZWViIEdhbmkNCj4gPGhnYW5pQG1hcnZlbGwuY29tPjsgU2F0
aGVzaCBCIEVkYXJhIDxzZWRhcmFAbWFydmVsbC5jb20+OyBWaW1sZXNoDQo+IEt1bWFyIDx2aW1s
ZXNoa0BtYXJ2ZWxsLmNvbT47IHRoYWxsZXJAcmVkaGF0LmNvbTsgd2l6aGFvQHJlZGhhdC5jb207
DQo+IGtoZWliQHJlZGhhdC5jb207IGtvbmd1eWVuQHJlZGhhdC5jb207IGhvcm1zQGtlcm5lbC5v
cmc7DQo+IGVpbnN0ZWluLnh1ZUBzeW5heGcuY29tOyBWZWVyYXNlbmFyZWRkeSBCdXJydSA8dmJ1
cnJ1QG1hcnZlbGwuY29tPjsNCj4gQW5kcmV3IEx1bm4gPGFuZHJldytuZXRkZXZAbHVubi5jaD47
IERhdmlkIFMuIE1pbGxlcg0KPiA8ZGF2ZW1AZGF2ZW1sb2Z0Lm5ldD47IEVyaWMgRHVtYXpldCA8
ZWR1bWF6ZXRAZ29vZ2xlLmNvbT47IFBhb2xvDQo+IEFiZW5pIDxwYWJlbmlAcmVkaGF0LmNvbT4N
Cj4gU3ViamVjdDogUkU6IFtFWFRFUk5BTF0gUmU6IFtQQVRDSCBuZXQgdjggMi80XSBvY3Rlb25f
ZXA6IHVwZGF0ZSB0eC9yeCBzdGF0cw0KPiBsb2NhbGx5IGZvciBwZXJzaXN0ZW5jZQ0KPiANCj4g
SGkgSmFrdWIsIExhcnlzYQ0KPiANCj4gPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+
IEZyb206IEpha3ViIEtpY2luc2tpIDxrdWJhQGtlcm5lbC5vcmc+DQo+ID4gU2VudDogRnJpZGF5
LCBKYW51YXJ5IDE3LCAyMDI1IDU6NTcgQU0NCj4gPiBUbzogTGFyeXNhIFphcmVtYmEgPGxhcnlz
YS56YXJlbWJhQGludGVsLmNvbT4NCj4gPiBDYzogU2hpbmFzIFJhc2hlZWQgPHNyYXNoZWVkQG1h
cnZlbGwuY29tPjsgbmV0ZGV2QHZnZXIua2VybmVsLm9yZzsNCj4gbGludXgtDQo+ID4ga2VybmVs
QHZnZXIua2VybmVsLm9yZzsgSGFzZWViIEdhbmkgPGhnYW5pQG1hcnZlbGwuY29tPjsgU2F0aGVz
aCBCDQo+IEVkYXJhDQo+ID4gPHNlZGFyYUBtYXJ2ZWxsLmNvbT47IFZpbWxlc2ggS3VtYXIgPHZp
bWxlc2hrQG1hcnZlbGwuY29tPjsNCj4gPiB0aGFsbGVyQHJlZGhhdC5jb207IHdpemhhb0ByZWRo
YXQuY29tOyBraGVpYkByZWRoYXQuY29tOw0KPiA+IGtvbmd1eWVuQHJlZGhhdC5jb207IGhvcm1z
QGtlcm5lbC5vcmc7IGVpbnN0ZWluLnh1ZUBzeW5heGcuY29tOw0KPiA+IFZlZXJhc2VuYXJlZGR5
IEJ1cnJ1IDx2YnVycnVAbWFydmVsbC5jb20+OyBBbmRyZXcgTHVubg0KPiA+IDxhbmRyZXcrbmV0
ZGV2QGx1bm4uY2g+OyBEYXZpZCBTLiBNaWxsZXIgPGRhdmVtQGRhdmVtbG9mdC5uZXQ+OyBFcmlj
DQo+ID4gRHVtYXpldCA8ZWR1bWF6ZXRAZ29vZ2xlLmNvbT47IFBhb2xvIEFiZW5pIDxwYWJlbmlA
cmVkaGF0LmNvbT4NCj4gPiBTdWJqZWN0OiBbRVhURVJOQUxdIFJlOiBbUEFUQ0ggbmV0IHY4IDIv
NF0gb2N0ZW9uX2VwOiB1cGRhdGUgdHgvcnggc3RhdHMNCj4gPiBsb2NhbGx5IGZvciBwZXJzaXN0
ZW5jZQ0KPiA+DQo+ID4gT24gVGh1LCAxNiBKYW4gMjAyNSAxNjoyNjoxOCArMDEwMCBMYXJ5c2Eg
WmFyZW1iYSB3cm90ZToNCj4gPiA+ID4gKwlmb3IgKHEgPSAwOyBxIDwgb2N0LT5udW1faW9xX3N0
YXRzOyBxKyspIHsNCj4gPiA+ID4gKwkJdHhfcGFja2V0cyArPSBvY3QtPnN0YXRzX2lxW3FdLmlu
c3RyX2NvbXBsZXRlZDsNCj4gPiA+ID4gKwkJdHhfYnl0ZXMgKz0gb2N0LT5zdGF0c19pcVtxXS5i
eXRlc19zZW50Ow0KPiA+ID4gPiArCQlyeF9wYWNrZXRzICs9IG9jdC0+c3RhdHNfb3FbcV0ucGFj
a2V0czsNCj4gPiA+ID4gKwkJcnhfYnl0ZXMgKz0gb2N0LT5zdGF0c19vcVtxXS5ieXRlczsNCj4g
PiA+DQo+ID4gPiBDb3JyZWN0IG1lIGlmIEkgYW0gd3JvbmcsIGJ1dCB0aGUgaW50ZXJmYWNlLXdp
ZGUgc3RhdGlzdGljcyBzaG91bGQgbm90DQo+IGNoYW5nZQ0KPiA+ID4gd2hlbiBjaGFuZ2luZyBx
dWV1ZSBudW1iZXIuIEluIHN1Y2ggY2FzZSBtYXliZSBpdCB3b3VsZCBiZSBhIGdvb2QNCj4gaWRl
YQ0KPiA+IHRvDQo+ID4gPiBhbHdheXMgaXRlcmF0ZSBvdmVyIGFsbCBPQ1RFUF9NQVhfUVVFVUVT
IHF1ZXVlcyB3aGVuIGNhbGN1bGF0aW5nIHRoZQ0KPiA+IHN0YXRzLg0KPiA+DQo+ID4gR29vZCBj
YXRjaCENCj4gDQo+IFRoZSBxdWV1ZXMgd2hpY2ggYXJlIGl0ZXJhdGVkIG92ZXIgaGVyZSByZWZl
ciB0byB0aGUgaGFyZHdhcmUgcXVldWVzLCBhbmQgaXQNCj4gaXMgaW4gZmFjdCBpdGVyYXRpbmcg
b3ZlciBhbGwgdGhlIHF1ZXVlcy4NCj4gQ2FuIHlvdSBwbGVhc2UgY2xhcmlmeSBtb3JlPw0KPiAN
Cj4gVGhhbmtzDQoNCk9rYXksIEkgdGhpbmsgSSB1bmRlcnN0YW5kDQo+IA0KPiA+IC0tDQo+ID4g
cHctYm90OiBjcg0K

