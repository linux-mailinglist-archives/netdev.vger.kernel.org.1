Return-Path: <netdev+bounces-144204-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D36DF9C606F
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 19:30:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9379E282C75
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 18:30:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92DF02170D3;
	Tue, 12 Nov 2024 18:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="Vw6x0rmG"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4DC31FF7C4;
	Tue, 12 Nov 2024 18:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.148.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731436250; cv=fail; b=Kqet2usrVn9xzl2hBA8mfYRTkWPiU1Jf/t0K3AgO7V1WE+1cmJ0YKJyGoRzxFP3oz8iVrxfR6IeoERnHAxMyYQZ5uepemq5qOvZuHFz7oOBGktwKGVKM0L4iu/tLx2Jpmb+8Lte2af58F5P1BEIqlhDVdnJkkDrMkPh64c8Cy9o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731436250; c=relaxed/simple;
	bh=94Gjc/QsQisrTQ5Mvqb5P95xULZIxQq90bGZRY79sWU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=JnEPa+oaa96dXyNAIKtPBXEF0t77wgSLlrTrGy442G+rbmg71qo5oeDZWH3+igSmy9jxu3OjqVzjksVdkb1HRN1JN7NMvn1meu+B8r/y4iuaFKIRC+39gJSa6EyPNDM7c1XyzZsWAyKme6MRUQe9J8cVz/4M8SSdU4i4TsvoVYY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=Vw6x0rmG; arc=fail smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4ACI4DEL003700;
	Tue, 12 Nov 2024 10:30:31 -0800
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2045.outbound.protection.outlook.com [104.47.58.45])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 42v9xdrd6v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 Nov 2024 10:30:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F69iRO2PhXS+tejYYw8QwUnyfe1w9y+2Fh8mVgwzcSpguDI7jeOvtZu99l/WPvAjS0kMMg5c77vhJ0XmpkuRf7t4LzVtml+APa25bdTPPg/UExYUD7U5N8EUVjZVRFHtOu7vL+cVe2gw2BFfua4mp7gIY6/8eVx1AhhwcKq28I8Saakv+7s+bGPkGR9Q1iCaWJ9daVd16/t2cIQCyrAJesB27nxdg3XO99bT7JikqNXacWBS8hcyw/cCcE32ayiklmz3BWzgJpTVJEuULdwHBllSfxOlevoXXCVWRxCwgTYawVD7/Mi7u5Npdp6hh4KajT935xBDp475O5LTxTyRNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=94Gjc/QsQisrTQ5Mvqb5P95xULZIxQq90bGZRY79sWU=;
 b=xjcvfWdd0jBHY7PR/Psa9xtjzWGNHXew7qq1EGIp/nRB2mOvap4XxKUvS8mZ7ao6i1OmEb57beQI2/9L6V9hG93QcLPB5fhVqYqSIZ+0euXXpYe9qKlv9Oqekmd4Xr3peZvr7ursDk6SWh4lXpd2BJ1keknUKzkyy2nrj/vty+kY2UtbBSJbyFGT6qjqvlPZNXKFIGjsHz9w1bMZiMgIShPRbhEBQdGIj/9EEMw/bEBiVlKZQuxTiJtkqcj3nchWX64aFwPMNDmeehXmG+SATpAvyfKx3Yq6ruk2Fp26Atu+aD6dzYwWKlThnklGH9zQ+aE3DOGb02pYIAUQ40RySw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=94Gjc/QsQisrTQ5Mvqb5P95xULZIxQq90bGZRY79sWU=;
 b=Vw6x0rmGQph7C589svKccAxirTHm434QxFz75v3RqHPt/93U+lhn3OI+kQUea5+VQ3jvs5GdBdIJlBUKsBm/d/yQndaCZyxdaPgEdDFobSzwi1AIm5CLTFlNSsy86RRGQ6WSws1rS2Bl/ySkZNniCt6k1KcCBcUo6DRG3uTeYeI=
Received: from PH0PR18MB4734.namprd18.prod.outlook.com (2603:10b6:510:cd::24)
 by MW4PR18MB5133.namprd18.prod.outlook.com (2603:10b6:303:1b4::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.17; Tue, 12 Nov
 2024 18:30:24 +0000
Received: from PH0PR18MB4734.namprd18.prod.outlook.com
 ([fe80::8adb:1ecd:bca9:6dcd]) by PH0PR18MB4734.namprd18.prod.outlook.com
 ([fe80::8adb:1ecd:bca9:6dcd%3]) with mapi id 15.20.8137.027; Tue, 12 Nov 2024
 18:30:23 +0000
From: Shinas Rasheed <srasheed@marvell.com>
To: Kalesh Anakkur Purayil <kalesh-anakkur.purayil@broadcom.com>
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
        "egallen@redhat.com" <egallen@redhat.com>,
        "konguyen@redhat.com" <konguyen@redhat.com>,
        "horms@kernel.org"
	<horms@kernel.org>,
        "frank.feng@synaxg.com" <frank.feng@synaxg.com>,
        Veerasenareddy Burru <vburru@marvell.com>,
        Andrew Lunn
	<andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni
	<pabeni@redhat.com>
Subject: RE: [EXTERNAL] Re: [PATCH net-next] octeon_ep: add ndo ops for VFs in
 PF driver
Thread-Topic: [EXTERNAL] Re: [PATCH net-next] octeon_ep: add ndo ops for VFs
 in PF driver
Thread-Index: AQHbMQ7r6a98mFMvh0GRdt6yXROXLLKxnkYAgAJfKvA=
Date: Tue, 12 Nov 2024 18:30:23 +0000
Message-ID:
 <PH0PR18MB47349C92B56274AFF1D0D51AC7592@PH0PR18MB4734.namprd18.prod.outlook.com>
References: <20241107121637.1117089-1-srasheed@marvell.com>
 <CAH-L+nO97YLd+gG1dGfyi=xZUCLJg+GsGAv=Dyf-4hA3-TP--A@mail.gmail.com>
In-Reply-To:
 <CAH-L+nO97YLd+gG1dGfyi=xZUCLJg+GsGAv=Dyf-4hA3-TP--A@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR18MB4734:EE_|MW4PR18MB5133:EE_
x-ms-office365-filtering-correlation-id: 1245af8d-7ec7-43c9-483b-08dd03481246
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|7416014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?ME9qVkpXVXI1YmlLWUREaXhEMmZtTWJuMmZUQjQ2SEtsUWtmeGVZUFM2TjFT?=
 =?utf-8?B?NmxoUzhKUGdsYURFZ2hyR3VYOEhvcDRRc2JNMUx6NklzaExiUGk1Qk9SYWVG?=
 =?utf-8?B?WlZlcEp0YlBkTGxoRU1hMTBvK2ZyRTdaL1NScTJQZHFKK2RtOFVNRE04TVpZ?=
 =?utf-8?B?alFvKzVvM2lRV1ZCSGppYVRYdkRnTGVldlRtczF1K3ZHMkI4RXVOV0Rvc0RO?=
 =?utf-8?B?eUtyR0J2M1E5dUhZaTZia1MwRDdQc1Bpc1hOUjRycjFaNnJWZWJOUHV0UzU0?=
 =?utf-8?B?NHVEbzJzUjE1S2JOL2oxUXZ5a0FwUlk1Mlk4cXZEMnRyOG1rS0k1dVhGSHMr?=
 =?utf-8?B?TVNicHBONVVkdzRvVkpaNFFNSENiUW1mcGFEQ0VnMGxEL2Zkb0FYdkRKM1Zi?=
 =?utf-8?B?M1ZhSXRBR0ljd1FSVmtQNUJOdDRQVWt5dEhVT3JHakQ1RWxyOUpGakpYR0gz?=
 =?utf-8?B?REtwZHJXdFFsY1A3L094VFRXMjNuNmg5QXMyV3dJcHpsKzREVnlSakJjQzB1?=
 =?utf-8?B?MGF6My9JREpNbVgvSXd2RC9pMHBNcFEwR0YvRGlKZWkySFVYenIwblF1eXZR?=
 =?utf-8?B?RGpob3hjSUt6NXRNa1Nrbnd2SFpQKzZtdmpZTXBrMWs2ZjVXS1U2RWdsMXUv?=
 =?utf-8?B?MFlkaEo3Z2dRcUtTRDllMFJJNnB5K0ZtZFFCeGZ4cm90Y28rbjBNREVZVi9C?=
 =?utf-8?B?RStyR083anpNenA0NVdPSDl4ZUp6MEVlZDA3NHBsWVA5Q05MaGJ5MXdYaWZp?=
 =?utf-8?B?b1NDbkpsb0h0RkpFK1RZdDBNZUdjNkhYY2NhZ2lQS3daK2EvWnI2dnJlOHdJ?=
 =?utf-8?B?WUhPMGR4Z3lQWk9wQlZFdUh3MGxBVHVaU21JL05nUHF6b1pjRU5MWXZaakIy?=
 =?utf-8?B?Vmp3OXp6K0Z4WjNaUDVuOFdnV0ZhWVVOekE0dUtyUzNWTG9EcDhuVTFDZFpn?=
 =?utf-8?B?czFLOGRySjdnYi9mSGhXTGhxN25UVFJCMWtmZjM3ZVhQaTJHQStBc1hUNlRG?=
 =?utf-8?B?OFkzQkZSWk5Yb01wSnNrZ0NJK3RKOHRKTi9uZ0Z1eEV4UnBCNkxIRWlZQ1Nu?=
 =?utf-8?B?SDJDMk5MUGZRUUF0K0RuTWtNZ3psK0Ixc2dOSEhnK0tDWUlmc1ZIYS9VVGtU?=
 =?utf-8?B?QkxwcU9nRyszZTFXZWZ6d3BmeFhpNTdzTHI1Z1p6SmwvWDBHMzlGZkttZXhL?=
 =?utf-8?B?VXcxejRFVnpPU2d5cXU4SDVYMkJqUHgyKzEzK2J4SmRKdi9Kejh3c2F6djR0?=
 =?utf-8?B?dDNZZHIyMGtvUndadVI4b3p6SGo0dWY5d3lmVm1ZNUhDaDVhQjg0emZyOEZm?=
 =?utf-8?B?QitNNFBBcUVXNFIwT1FMZ0wwNld2enJLdnFRTlBZcHVEVWs1T2dwZkNocmlU?=
 =?utf-8?B?Q0Vndi80em44VHppREZnVWdQbVhIUVNDRndZaUJSZis3L1N2UmtSQ2FZWkdU?=
 =?utf-8?B?Um9iR1Fkb0ZTSE4ySzVaN0k1SE1aNzlwZElQVEJJN2xLRmU2K3RxOWNmdU1V?=
 =?utf-8?B?ZUp0Z3hrS25FSVFlZkVsMGsxYjV4OTBSOFFaL2I4QVZXYndETStKZkV4WDV4?=
 =?utf-8?B?UHlCbm5NVlhGNDRwcXNsYjJIRFlHRXRnTkZlcktZT2FJMnhyMENseCtJOFU5?=
 =?utf-8?B?bnJDNloxRnhjYitMdnA5TEhRM2RqNzNmYjNmcXRTMjJ1MmtVSGJIeENnMnFk?=
 =?utf-8?B?bENuaFZqRGE5QzBrbUFpRFVoQ3o3cDAxSW1TT0loNXY5LzlJYXcza3RiYlN0?=
 =?utf-8?B?SDJYcnpyeG9yOVZyamZWY2VXeUJLazdlY1BabHorN1dHaFZDS1Q1WDBSYlFq?=
 =?utf-8?Q?0PcAWDaLnPxiB8F8gam8slBAee4f6XEqLQzAg=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR18MB4734.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Q1l3MUtzdTZWZ2wxYk5jeTMxNi83RlVMR2VuVDc5YXhFNW82Y2lHQ1ExeDAx?=
 =?utf-8?B?VDR0UG5oQVpCYlU2ZVNEMi9Ya05OM2VJQVlqMnhoQjdlWm5GbXZ5ek9zdGJY?=
 =?utf-8?B?OUhTSXV2akwvTTlYV3l0eXhpMTArN0tqRGUxSGdNQTV2RmR6UFY2cVFocXFv?=
 =?utf-8?B?ZkkzU0JaVEtzWjY4UHZKVVRRL2xBbllxSzVCWjJoR0NLQ09NWXZtZm5VMjJz?=
 =?utf-8?B?amM2S2wyZ2lpTXRaa2FDM0ZZdTJTRnFMaFhrd2JJRndtWlFnL3N0dUliWThG?=
 =?utf-8?B?emlMUGZ5ZTBOcjVkd0hCbXhKUXFDVkdTdmNpUm4yL1ZtT1pwb2ZsUlMramVB?=
 =?utf-8?B?K21aZGdiRjNqcmEzaHBJMy9kVUNDMkRjRnM0TG42TVVFakYxN0JLRDJsbzlH?=
 =?utf-8?B?c21PaXNaNkc2RDd6Q1RXanN4Y2JDZW80RWo3TFB4V3laaTRDLzkyaGN3V0JY?=
 =?utf-8?B?NURnTmJXbk9PVjRBOG9ZQ21xaUsvQitnUzVuZUNKTXl4cGVjTjhNNDk3bEVG?=
 =?utf-8?B?QkNZeFlQdHNYSmJ6WmY5Z3NiTjd4a2pYMFRpMnpsU2ZvM09rbEc4dzY1ZFF6?=
 =?utf-8?B?WUcrZi93UENOZElFcXg0MEUveVE0Z08wK1BRRk5lL0ZuVk5jY1k2SDNUOUxV?=
 =?utf-8?B?Sm1Ed3psZzlveE9pVyt0WSt1cm9JVi9FUzhORVUyRVNzUkdYZE5ySjMzbGZm?=
 =?utf-8?B?azNOMzB0b2l6Tm9pT1RqSkhrQlR5SllPSmp0V0VaOE1mWnVDYU5aZC9RNjR3?=
 =?utf-8?B?bDVtMmpQUGladzVyNUw1SEpGMWZ1c2NudVE1Q1daNkNqYm4wZjdtd05iNnE2?=
 =?utf-8?B?b3dvV3ZTQ3dEM2NqS1B2dVNEQW04MmJHTUxkZ251dktCYXdsTnkxWEF6cFJv?=
 =?utf-8?B?UHVjZGErRTdHUE9uSmIxdTRielFCOEMyRlcrMFdYUjc3ZmUzb1FYWXhQeGFq?=
 =?utf-8?B?TlZJcy9uZytSbVZudnFWcitHZm16R0dWMmh1T1ZQZW9PejRkS1NaZkI3bWhD?=
 =?utf-8?B?U3JHWVYxdndXaVgvL2pjV3FOUUFQWmdSRU1MNmMyMEwwQVVRRUpCRXlPbW9n?=
 =?utf-8?B?U0t3NWszSEpYMHlscGJoWFkxM3haVFNMQUh6ZTkwa0d2THhNRFJGUXZXWllP?=
 =?utf-8?B?M3kwTTA4YnBlYXRuTzZibWoxajdKNSt2OFlqaDVEK2JVMUFrb210eXpRZ3Ns?=
 =?utf-8?B?c0l5UEpkWXVXay9jM0FDbEpNZDd0d1ZGM0diczEzRW9TV3h3bXNqd0drRnZs?=
 =?utf-8?B?cGxYVlJjVzRqNEcwZUVUZWpST2plUHhJUlVEQ3Q0RjUzT29ESnVFNGs3Rysx?=
 =?utf-8?B?WHo3ZFRKdXZPUUUvYVJnUGdCRTNIS2dJOC9oaWJyank1TGJUSHBJalJxQXBB?=
 =?utf-8?B?VGxaWnQ4WlJIZjdqZmh1ZVlVQVlReUE3cEdMdHJFWFhGZks3aWhndjlyVnlw?=
 =?utf-8?B?R3lhaUZUOVNHRzgxdkxlRzlveW9keDVYQkxpM2tLaDZCR3JVOGdoU1dFYm9l?=
 =?utf-8?B?NTRtTUJkR0tWWmU4LzVQbTFYb2FCcEdjR3V1N0EvYjZCZEJUcXlKZFBTc2pL?=
 =?utf-8?B?R2VhR2hFTzNhaG1JSEdFSURnaW5JZVZCd2RkSnBlUzF5ZkR5dWRtLzlRZEtW?=
 =?utf-8?B?bVNLUDMyblBRNWxGNHJuYWhIbUVwK21USnpZV2NLVm5kV080cjdTWUdDMFJ0?=
 =?utf-8?B?bi9IMXNJYmc2cWJsOW9LVC93WUlQQTBUdm1LLzZRbTFFVUluT0RsN05YSTRh?=
 =?utf-8?B?UysvZXgybEV3WUFsc05uTEU4clh2TFBwZnBUeDVDZks0aW1SYTNiUENpMFVs?=
 =?utf-8?B?N1lVMlJiUFFscWQ4ZVBkeGVwYk5wMFAyZGJvWVVKU00vbE96eVltZUFHc1Zs?=
 =?utf-8?B?cjF0YzRJUy9aRzh5Ly9mUlIvN1J6aE43UEFld0JNa1lud055U2l2NlEzZGhN?=
 =?utf-8?B?d0FRaUZ5VDhrdCsxc1hVUVV0ZlJVMWVEeURTZlNRUzJjbWkyWEk5MUdtR242?=
 =?utf-8?B?cVZ3M0wyeEFqclhFamNJUFpoeEg2dVl1TjF5U3FWaDVBWjdDL3UzYUJ4UzFL?=
 =?utf-8?B?T2E3Y3U5U0FKdWN5TlhlNU9uZEdIa1NmUnVtWkxHVFdiNVJvN0t2N29KSlVI?=
 =?utf-8?Q?XaNwEMw6BwH8lxPOsq1oeaFwQ?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 1245af8d-7ec7-43c9-483b-08dd03481246
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Nov 2024 18:30:23.5501
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: H1yZrTaED+VEGZyOzkByv+1jzzKY1EsIT48o+NSigrggQjq/Zv+op/hnLA62CMi9GAgbccX2ad5DHqx+Ky4LKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR18MB5133
X-Proofpoint-GUID: nFGUEnnp4TwhBIcVttwr8eDeCoXn3VUy
X-Proofpoint-ORIG-GUID: nFGUEnnp4TwhBIcVttwr8eDeCoXn3VUy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01

SGkgS2FsZXNoLA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEthbGVz
aCBBbmFra3VyIFB1cmF5aWwgPGthbGVzaC1hbmFra3VyLnB1cmF5aWxAYnJvYWRjb20uY29tPg0K
PiBTZW50OiBNb25kYXksIE5vdmVtYmVyIDExLCAyMDI0IDExOjM5IEFNDQo+IFRvOiBTaGluYXMg
UmFzaGVlZCA8c3Jhc2hlZWRAbWFydmVsbC5jb20+DQo+IENjOiBuZXRkZXZAdmdlci5rZXJuZWwu
b3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBIYXNlZWIgR2FuaQ0KPiA8aGdhbmlA
bWFydmVsbC5jb20+OyBTYXRoZXNoIEIgRWRhcmEgPHNlZGFyYUBtYXJ2ZWxsLmNvbT47IFZpbWxl
c2gNCj4gS3VtYXIgPHZpbWxlc2hrQG1hcnZlbGwuY29tPjsgdGhhbGxlckByZWRoYXQuY29tOyB3
aXpoYW9AcmVkaGF0LmNvbTsNCj4ga2hlaWJAcmVkaGF0LmNvbTsgZWdhbGxlbkByZWRoYXQuY29t
OyBrb25ndXllbkByZWRoYXQuY29tOw0KPiBob3Jtc0BrZXJuZWwub3JnOyBmcmFuay5mZW5nQHN5
bmF4Zy5jb207IFZlZXJhc2VuYXJlZGR5IEJ1cnJ1DQo+IDx2YnVycnVAbWFydmVsbC5jb20+OyBB
bmRyZXcgTHVubiA8YW5kcmV3K25ldGRldkBsdW5uLmNoPjsgRGF2aWQgUy4NCj4gTWlsbGVyIDxk
YXZlbUBkYXZlbWxvZnQubmV0PjsgRXJpYyBEdW1hemV0IDxlZHVtYXpldEBnb29nbGUuY29tPjsN
Cj4gSmFrdWIgS2ljaW5za2kgPGt1YmFAa2VybmVsLm9yZz47IFBhb2xvIEFiZW5pIDxwYWJlbmlA
cmVkaGF0LmNvbT4NCj4gU3ViamVjdDogW0VYVEVSTkFMXSBSZTogW1BBVENIIG5ldC1uZXh0XSBv
Y3Rlb25fZXA6IGFkZCBuZG8gb3BzIGZvciBWRnMgaW4NCj4gUEYgZHJpdmVyDQo+IA0KPiBIaSBT
aGluYXMsDQo+IA0KPiBPbiBUaHUsIE5vdiA3LCAyMDI0IGF0IDU6NDfigK9QTSBTaGluYXMgUmFz
aGVlZCA8c3Jhc2hlZWRAbWFydmVsbC5jb20+DQo+IHdyb3RlOg0KPiA+DQo+ID4gVGhlc2UgQVBJ
cyBhcmUgbmVlZGVkIHRvIHN1cHBvcnQgYXBwbGljYWl0b25zIHRoYXQgdXNlIG5ldGxpbmsgdG8g
Z2V0IFZGDQo+IFtkXSB0eXBvIGluIGFwcGxpY2F0aW9ucw0KPiA+IGluZm9ybWF0aW9uIGZyb20g
YSBQRiBkcml2ZXIuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBTaGluYXMgUmFzaGVlZCA8c3Jh
c2hlZWRAbWFydmVsbC5jb20+DQo+ID4gLS0tDQo+ID4gIC4uLi9ldGhlcm5ldC9tYXJ2ZWxsL29j
dGVvbl9lcC9vY3RlcF9tYWluLmMgICB8IDk4ICsrKysrKysrKysrKysrKysrKysNCj4gPiAgLi4u
L2V0aGVybmV0L21hcnZlbGwvb2N0ZW9uX2VwL29jdGVwX21haW4uaCAgIHwgIDEgKw0KPiA+ICAu
Li4vbWFydmVsbC9vY3Rlb25fZXAvb2N0ZXBfcGZ2Zl9tYm94LmMgICAgICAgfCAyMiArKysrLQ0K
PiA+ICAuLi4vbWFydmVsbC9vY3Rlb25fZXAvb2N0ZXBfcGZ2Zl9tYm94LmggICAgICAgfCAgMyAr
DQo+ID4gIDQgZmlsZXMgY2hhbmdlZCwgMTIyIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0p
DQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvZXRoZXJuZXQvbWFydmVsbC9vY3Rl
b25fZXAvb2N0ZXBfbWFpbi5jDQo+IGIvZHJpdmVycy9uZXQvZXRoZXJuZXQvbWFydmVsbC9vY3Rl
b25fZXAvb2N0ZXBfbWFpbi5jDQo+ID4gaW5kZXggNTQ5NDM2ZWZjMjA0Li4xMjljNjhmNWE0YmEg
MTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9uZXQvZXRoZXJuZXQvbWFydmVsbC9vY3Rlb25fZXAv
b2N0ZXBfbWFpbi5jDQo+ID4gKysrIGIvZHJpdmVycy9uZXQvZXRoZXJuZXQvbWFydmVsbC9vY3Rl
b25fZXAvb2N0ZXBfbWFpbi5jDQo+ID4gQEAgLTExMzcsNiArMTEzNyw5NSBAQCBzdGF0aWMgaW50
IG9jdGVwX3NldF9mZWF0dXJlcyhzdHJ1Y3QgbmV0X2RldmljZQ0KPiAqZGV2LCBuZXRkZXZfZmVh
dHVyZXNfdCBmZWF0dXJlcw0KPiA+ICAgICAgICAgcmV0dXJuIGVycjsNCj4gPiAgfQ0KPiA+DQo+
ID4gK3N0YXRpYyBpbnQgb2N0ZXBfZ2V0X3ZmX2NvbmZpZyhzdHJ1Y3QgbmV0X2RldmljZSAqZGV2
LCBpbnQgdmYsIHN0cnVjdA0KPiBpZmxhX3ZmX2luZm8gKml2aSkNCj4gPiArew0KPiA+ICsgICAg
ICAgc3RydWN0IG9jdGVwX2RldmljZSAqb2N0ID0gbmV0ZGV2X3ByaXYoZGV2KTsNCj4gPiArDQo+
ID4gKyAgICAgICBpdmktPnZmID0gdmY7DQo+ID4gKyAgICAgICBldGhlcl9hZGRyX2NvcHkoaXZp
LT5tYWMsIG9jdC0+dmZfaW5mb1t2Zl0ubWFjX2FkZHIpOw0KPiA+ICsgICAgICAgaXZpLT52bGFu
ID0gMDsNCj4gPiArICAgICAgIGl2aS0+cW9zID0gMDsNCj4gPiArICAgICAgIGl2aS0+c3Bvb2Zj
aGsgPSAwOw0KPiA+ICsgICAgICAgaXZpLT5saW5rc3RhdGUgPSBJRkxBX1ZGX0xJTktfU1RBVEVf
RU5BQkxFOw0KPiA+ICsgICAgICAgaXZpLT50cnVzdGVkID0gdHJ1ZTsNCj4gPiArICAgICAgIGl2
aS0+bWF4X3R4X3JhdGUgPSAxMDAwMDsNCj4gPiArICAgICAgIGl2aS0+bWluX3R4X3JhdGUgPSAw
Ow0KPiA+ICsNCj4gPiArICAgICAgIHJldHVybiAwOw0KPiA+ICt9DQo+ID4gKw0KPiA+ICtzdGF0
aWMgaW50IG9jdGVwX3NldF92Zl9tYWMoc3RydWN0IG5ldF9kZXZpY2UgKmRldiwgaW50IHZmLCB1
OCAqbWFjKQ0KPiA+ICt7DQo+ID4gKyAgICAgICBzdHJ1Y3Qgb2N0ZXBfZGV2aWNlICpvY3QgPSBu
ZXRkZXZfcHJpdihkZXYpOw0KPiA+ICsgICAgICAgaW50IGksIGVycjsNCj4gPiArDQo+ID4gKyAg
ICAgICBpZiAoIWlzX3ZhbGlkX2V0aGVyX2FkZHIobWFjKSkgew0KPiA+ICsgICAgICAgICAgICAg
ICBkZXZfZXJyKCZvY3QtPnBkZXYtPmRldiwgIkludmFsaWQgIE1BQyBBZGRyZXNzICVwTVxuIiwg
bWFjKTsNCj4gPiArICAgICAgICAgICAgICAgcmV0dXJuIC1FQUREUk5PVEFWQUlMOw0KPiA+ICsg
ICAgICAgfQ0KPiA+ICsNCj4gPiArICAgICAgIGRldl9kYmcoJm9jdC0+cGRldi0+ZGV2LCAic2V0
IHZmLSVkIG1hYyB0byAlcE1cbiIsIHZmLCBtYWMpOw0KPiA+ICsgICAgICAgZm9yIChpID0gMDsg
aSA8IEVUSF9BTEVOOyBpKyspDQo+ID4gKyAgICAgICAgICAgICAgIG9jdC0+dmZfaW5mb1t2Zl0u
bWFjX2FkZHJbaV0gPSBtYWNbaV07DQo+IFtLYWxlc2hdIElzIHRoZXJlIGFueSByZWFzb24gdG8g
bm8gZG8gYSBtZW1jcHkgaGVyZSBvciBhIGV0aGVyX2FkZHJfY29weSgpPw0KDQpBQ0sNCg0KPiA+
ICsgICAgICAgb2N0LT52Zl9pbmZvW3ZmXS5mbGFncyB8PSAgT0NURU9OX1BGVkZfRkxBR19NQUNf
U0VUX0JZX1BGOw0KPiA+ICsNCj4gPiArICAgICAgIGVyciA9IG9jdGVwX2N0cmxfbmV0X3NldF9t
YWNfYWRkcihvY3QsIHZmLCBtYWMsIHRydWUpOw0KPiA+ICsgICAgICAgaWYgKGVycikgew0KPiA+
ICsgICAgICAgICAgICAgICBkZXZfZXJyKCZvY3QtPnBkZXYtPmRldiwgIlNldCBWRiVkIE1BQyBh
ZGRyZXNzIGZhaWxlZCB2aWEgaG9zdA0KPiBjb250cm9sIE1ib3hcbiIsIHZmKTsNCj4gW2RdIGxv
b2tzIGxpa2UgdGhpcyByZXR1cm4gaXMgdW5uZWNlc3NhcnkuIFlvdSBjYW4gInJldHVybiByYyIg
YXQgdGhlDQo+IGVuZCBvZiB0aGUgZnVuY3Rpb24uDQoNCkFDSw0KDQo+ID4gK3N0YXRpYyBpbnQg
b2N0ZXBfZ2V0X3ZmX3N0YXRzKHN0cnVjdCBuZXRfZGV2aWNlICpkZXYsIGludCB2Ziwgc3RydWN0
DQo+IGlmbGFfdmZfc3RhdHMgKnZmX3N0YXRzKQ0KPiA+ICt7DQo+ID4gKyAgICAgICBzdHJ1Y3Qg
b2N0ZXBfZGV2aWNlICpvY3QgPSBuZXRkZXZfcHJpdihkZXYpOw0KPiA+ICsNCj4gPiArICAgICAg
IGRldl9lcnIoJm9jdC0+cGRldi0+ZGV2LCAiR2V0dGluZyBWRiBzdGF0cyBub3Qgc3VwcG9ydGVk
XG4iKTsNCj4gPiArICAgICAgIHJldHVybiAwOw0KPiA+ICt9DQo+IFtLYWxlc2hdIERvIG5vdCBl
eHBvc2UgdGhlIHN1cHBvcnQgZm9yIHRoZXNlIHVuc3VwcG9ydGVkIGhvb2tzIGluDQo+IHN0cnVj
dCBuZXRfZGV2aWNlX29wcy4gU3RhY2sgaGFzIGEgY2hlY2sgZm9yIHRoZSBzdXBwb3J0IGJlZm9y
ZQ0KPiBpbnZva2luZyB0aGUgY2FsbGJhY2suDQoNCkFDSw0KDQo+ID4gKw0KPiA+ICBzdGF0aWMg
Y29uc3Qgc3RydWN0IG5ldF9kZXZpY2Vfb3BzIG9jdGVwX25ldGRldl9vcHMgPSB7DQo+ID4gICAg
ICAgICAubmRvX29wZW4gICAgICAgICAgICAgICAgPSBvY3RlcF9vcGVuLA0KPiA+ICAgICAgICAg
Lm5kb19zdG9wICAgICAgICAgICAgICAgID0gb2N0ZXBfc3RvcCwNCj4gPiBAQCAtMTE0Niw2ICsx
MjM1LDE1IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgbmV0X2RldmljZV9vcHMNCj4gb2N0ZXBfbmV0
ZGV2X29wcyA9IHsNCj4gPiAgICAgICAgIC5uZG9fc2V0X21hY19hZGRyZXNzICAgICA9IG9jdGVw
X3NldF9tYWMsDQo+ID4gICAgICAgICAubmRvX2NoYW5nZV9tdHUgICAgICAgICAgPSBvY3RlcF9j
aGFuZ2VfbXR1LA0KPiA+ICAgICAgICAgLm5kb19zZXRfZmVhdHVyZXMgICAgICAgID0gb2N0ZXBf
c2V0X2ZlYXR1cmVzLA0KPiA+ICsgICAgICAgLyogZm9yIFZGcyAqLw0KPiA+ICsgICAgICAgLm5k
b19nZXRfdmZfY29uZmlnICAgICAgID0gb2N0ZXBfZ2V0X3ZmX2NvbmZpZywNCj4gPiArICAgICAg
IC5uZG9fc2V0X3ZmX21hYyAgICAgICAgICA9IG9jdGVwX3NldF92Zl9tYWMsDQo+ID4gKyAgICAg
ICAubmRvX3NldF92Zl92bGFuICAgICAgICAgPSBvY3RlcF9zZXRfdmZfdmxhbiwNCj4gPiArICAg
ICAgIC5uZG9fc2V0X3ZmX3Nwb29mY2hrICAgICA9IG9jdGVwX3NldF92Zl9zcG9vZmNoaywNCj4g
PiArICAgICAgIC5uZG9fc2V0X3ZmX3RydXN0ICAgICAgICA9IG9jdGVwX3NldF92Zl90cnVzdCwN
Cj4gPiArICAgICAgIC5uZG9fc2V0X3ZmX3JhdGUgICAgICAgICA9IG9jdGVwX3NldF92Zl9yYXRl
LA0KPiA+ICsgICAgICAgLm5kb19zZXRfdmZfbGlua19zdGF0ZSAgID0gb2N0ZXBfc2V0X3ZmX2xp
bmtfc3RhdGUsDQo+ID4gKyAgICAgICAubmRvX2dldF92Zl9zdGF0cyAgICAgICAgPSBvY3RlcF9n
ZXRfdmZfc3RhdHMsDQo+ID4gIH07DQo+ID4NCj4gPiAgLyoqDQo+ID4gZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvbmV0L2V0aGVybmV0L21hcnZlbGwvb2N0ZW9uX2VwL29jdGVwX21haW4uaA0KPiBiL2Ry
aXZlcnMvbmV0L2V0aGVybmV0L21hcnZlbGwvb2N0ZW9uX2VwL29jdGVwX21haW4uaA0KPiA+IGlu
ZGV4IGZlZTU5ZTBlMDEzOC4uM2I1NjkxNmFmNDY4IDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMv
bmV0L2V0aGVybmV0L21hcnZlbGwvb2N0ZW9uX2VwL29jdGVwX21haW4uaA0KPiA+ICsrKyBiL2Ry
aXZlcnMvbmV0L2V0aGVybmV0L21hcnZlbGwvb2N0ZW9uX2VwL29jdGVwX21haW4uaA0KPiA+IEBA
IC0yMjAsNiArMjIwLDcgQEAgc3RydWN0IG9jdGVwX2lmYWNlX2xpbmtfaW5mbyB7DQo+ID4gIC8q
IFRoZSBPY3Rlb24gVkYgZGV2aWNlIHNwZWNpZmljIGluZm8gZGF0YSBzdHJ1Y3R1cmUuKi8NCj4g
PiAgc3RydWN0IG9jdGVwX3BmdmZfaW5mbyB7DQo+ID4gICAgICAgICB1OCBtYWNfYWRkcltFVEhf
QUxFTl07DQo+ID4gKyAgICAgICB1MzIgZmxhZ3M7DQo+ID4gICAgICAgICB1MzIgbWJveF92ZXJz
aW9uOw0KPiA+ICB9Ow0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L2V0aGVybmV0
L21hcnZlbGwvb2N0ZW9uX2VwL29jdGVwX3BmdmZfbWJveC5jDQo+IGIvZHJpdmVycy9uZXQvZXRo
ZXJuZXQvbWFydmVsbC9vY3Rlb25fZXAvb2N0ZXBfcGZ2Zl9tYm94LmMNCj4gPiBpbmRleCBlNmVi
OThkNzBmM2MuLmJlMjFhZDVlYzc1ZSAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL25ldC9ldGhl
cm5ldC9tYXJ2ZWxsL29jdGVvbl9lcC9vY3RlcF9wZnZmX21ib3guYw0KPiA+ICsrKyBiL2RyaXZl
cnMvbmV0L2V0aGVybmV0L21hcnZlbGwvb2N0ZW9uX2VwL29jdGVwX3BmdmZfbWJveC5jDQo+ID4g
QEAgLTE1NiwxMiArMTU2LDIzIEBAIHN0YXRpYyB2b2lkIG9jdGVwX3BmdmZfc2V0X21hY19hZGRy
KHN0cnVjdA0KPiBvY3RlcF9kZXZpY2UgKm9jdCwgIHUzMiB2Zl9pZCwNCj4gPiAgew0KPiA+ICAg
ICAgICAgaW50IGVycjsNCj4gPg0KPiA+ICsgICAgICAgaWYgKG9jdC0+dmZfaW5mb1t2Zl9pZF0u
ZmxhZ3MgJiBPQ1RFT05fUEZWRl9GTEFHX01BQ19TRVRfQllfUEYpIHsNCj4gPiArICAgICAgICAg
ICAgICAgZGV2X2Vycigmb2N0LT5wZGV2LT5kZXYsDQo+ID4gKyAgICAgICAgICAgICAgICAgICAg
ICAgIlZGJWQgYXR0YW1wdGVkIHRvIG92ZXJyaWRlIGFkbWluaXN0cmF0aXZlIHNldCBNQUMNCj4g
YWRkcmVzc1xuIiwNCj4gW2RdIHR5cG8gaW4gImF0dGVtcHRlZCINCg0KQUNLDQoNClNoYWxsIHBv
c3QgbmV4dCBwYXRjaA0KDQpUaGFua3MsDQpTaGluYXMNCg==

