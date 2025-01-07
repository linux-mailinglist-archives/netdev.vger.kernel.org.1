Return-Path: <netdev+bounces-155733-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43AA2A037BE
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 07:12:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4EF03A4B35
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 06:12:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAF251D90D7;
	Tue,  7 Jan 2025 06:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="RjtlP3Q3"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3DE915749C;
	Tue,  7 Jan 2025 06:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.148.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736230367; cv=fail; b=KAMpux0CHeIEe4sleKsQ2IQ7FRlL4YwK2c693QYcH145MSw2fgXgeq9WyxSgPMUT0uVkzYEY6sU2FFP5DsQPkEwQWQus/l7LYdIEjoF4HKbMXpAz33tbhq564UD0/MAFoLrLswCkk4Jm2IBJASQ799MkcpU7RUlei+L5RZAKA2c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736230367; c=relaxed/simple;
	bh=aikeizQjECHJLHWGIBI8CzLcQLBl3avuEh29Rm0M//Y=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Jss0ylsvvSBAlAOCGDNbaH8MjT42M3041fQShEvQSmnITVRUSuLvAHECgjhnWrdDbW/rqYn65bBXfMhp7RBroSI220Fo4eU/a+BVjzpCtXnVe/0+eRzFRdcsNK7HW6WEv9hyoduUD6+KPJGoJ7MPXiZJmJ3WbmV3Zn0i8bT3Ygg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=RjtlP3Q3; arc=fail smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5074ccDF002285;
	Mon, 6 Jan 2025 22:12:15 -0800
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2040.outbound.protection.outlook.com [104.47.55.40])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 440we104fc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 Jan 2025 22:12:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N7IXVv+jVY70GeFjd2gpscrWG8EtzyTeXABitU0I/dUCqiC4VsjdW5dBt4TA/dsoyHqgiH/f0P8wfLnO3EJ8qTc+6MIBE60HRKK/wzbzxeVqbfrXfp73CCV6bkqxWlOcm2HqIuhdG3AoLMwjFZ1vlRfuCG026Hc78A2qvPt4Pwn6MMu6fc1/yU7ZJTolcWHWcEv2ppBpKQFOy8fFXhLvpHMEMz5hH48kIv1YBOK19nx0APR3cGip7btzXM+UZXnWLKr8YfdHN4XQ2Za9Qbx1QLct6FbROL/I8/t5KXplFQJSevAhwRJBic+cr0tOByDT/Fyg8aLdR6o+DxvYz6jtxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aikeizQjECHJLHWGIBI8CzLcQLBl3avuEh29Rm0M//Y=;
 b=xdeFwBv6QKnYN80HoxuZb/cVywra6GWp/YnfP7Sn1xSIbUygcmDWJ3AG7/8jvGGrxmgnZl2MwhCOb1qV40tji0JnY0k0d5WNHnfakhqn1HyPguXDI4FJQyMGxHNo1des0S2loXOjWnMzvkWe20ki1snM55LieykkoNz7bfNnXPPMX4+xcg2KwF6McymNNtjNqOtjlaGsczGLtHFfpYaaK1J9ibqGt33bla8hivbGlhNWRbR8JN6YqcXE9APWtdjjEQDSuNIPgnKQ1DnuruNoGnOEJDjrDIMknbfgLhyYD+28P/AgZZ811zYBIgiMI+3bTsgiVK0G7nLhCzPHkSrrsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aikeizQjECHJLHWGIBI8CzLcQLBl3avuEh29Rm0M//Y=;
 b=RjtlP3Q3FpYtorVUWT4BECUsMDPNMZzsJpPMDrCF6IEviLsDaHVTJec3UcZjber0E3+MeCTt9Q0ZpBdsJ/fDuAvNDJkHedK8Zt8C+iFKBrYUrieC4ubA7sHsPX/JQDSJYg9QouQXJ3w3wH75Mr25DboaEqCrTBUijQgzwsRDOeY=
Received: from PH0PR18MB4734.namprd18.prod.outlook.com (2603:10b6:510:cd::24)
 by PH7PR18MB5621.namprd18.prod.outlook.com (2603:10b6:510:2ee::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.14; Tue, 7 Jan
 2025 06:11:59 +0000
Received: from PH0PR18MB4734.namprd18.prod.outlook.com
 ([fe80::8adb:1ecd:bca9:6dcd]) by PH0PR18MB4734.namprd18.prod.outlook.com
 ([fe80::8adb:1ecd:bca9:6dcd%4]) with mapi id 15.20.8314.015; Tue, 7 Jan 2025
 06:11:59 +0000
From: Shinas Rasheed <srasheed@marvell.com>
To: Jakub Kicinski <kuba@kernel.org>
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
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
        Abhijit
 Ayarekar <aayarekar@marvell.com>,
        Satananda Burla <sburla@marvell.com>
Subject: RE: [EXTERNAL] Re: [PATCH net v4 1/4] octeon_ep: fix race conditions
 in ndo_get_stats64
Thread-Topic: [EXTERNAL] Re: [PATCH net v4 1/4] octeon_ep: fix race conditions
 in ndo_get_stats64
Thread-Index: AQHbXQiwzwJw1r4OvUao3wqNxDVI6rMG2mqAgAJqK6CAAPx9gIAAmphw
Date: Tue, 7 Jan 2025 06:11:59 +0000
Message-ID:
 <PH0PR18MB4734B9F8B2219DF15294F014C7112@PH0PR18MB4734.namprd18.prod.outlook.com>
References: <20250102112246.2494230-1-srasheed@marvell.com>
	<20250102112246.2494230-2-srasheed@marvell.com>
	<20250104090105.185c08df@kernel.org>
	<PH0PR18MB473488467A2026CA30916528C7102@PH0PR18MB4734.namprd18.prod.outlook.com>
 <20250106125717.1a11e522@kernel.org>
In-Reply-To: <20250106125717.1a11e522@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR18MB4734:EE_|PH7PR18MB5621:EE_
x-ms-office365-filtering-correlation-id: ced1d1ab-7868-4424-24a3-08dd2ee2323d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?amIzRWMwbWMxUGRTWnZtc0xMMW43Rk5IVlZhcXhuU3A3WnhobjlpVHhqamlP?=
 =?utf-8?B?c2lzaGNoamxOaGFhMGlYVWZ6K29DV1U1SGRYallleE9CUWRLaXpaTE1aa3lE?=
 =?utf-8?B?QmFjc0NVa0I4SXFqUUx3dzVGQzAyNUY2SGNGS0xqTHptODV5YzFRdThvU2Nk?=
 =?utf-8?B?cGhLSG9ha2FNblZ5cTZZenZJUXJiSy9FbEhhR2JHcVJLbjlGSWFjZ2ZxaFF4?=
 =?utf-8?B?Q3ZLa0d2N3EyU1dnS2Y2enQzc0tUS2tWL1ZjUzA3alJ5eGwzYXpzVGdoUmxL?=
 =?utf-8?B?SHpvZTJGVTZ2OTVyb1JqQXo5Z3JiMWlhTHplUmdRR0tIendzdU0yckdVL0RZ?=
 =?utf-8?B?ZTE1SVhmUU9Jc1MwRHovaW1BSnpOK0dCTGNzN29SYThXcUt6S1hzU1lHWnV4?=
 =?utf-8?B?bWhFeEx3bnhBaFgwczQ2ZldKa1hyUnFwSkkwazVXQmdjMnVIRnhJM25Mckgr?=
 =?utf-8?B?dmZ2TDcwYldsdzV0KzVaWCtGdjZZcVFwcUo3MnBFV1BBdGJ3eHNyZk5JaWRY?=
 =?utf-8?B?c3ZDTUh6Z1dsL1RWQTcrK2hkT2hKd21UYXh5R2V5clZvSk5wb05JWngyMFpY?=
 =?utf-8?B?MVphUFMreGVuSXVHNUlkS2QzdWZJT2g2ZHhuMVpQQ091WXpJVFgzN1pvOVVs?=
 =?utf-8?B?ZXRvd2JDbDZZVEJPTUZvbnIyOTNkSHh3a0hrM2UwVkt2UVZkcksrK1U2bWp1?=
 =?utf-8?B?NHpsalBOU1BMQ3QwTXMxVlMrUnR6UnhvRHU3bEtmMzBTNHgrUEhhdml0V1cv?=
 =?utf-8?B?ckxuT1hyV1pkM1JEVEdmVlZlamJPZjJzVUs5RnR2UXVSMEp6dGF3OGlnUFZx?=
 =?utf-8?B?RGxuaS95dE53MHdiL0V1U09aZVdFejd3LzFFQzlVSWlKcG1jZ2VaTERhSVh3?=
 =?utf-8?B?VE56RlJJWUw1UXpHQjdCNDJWWU5YS25JUEdNNjNxNGdOclNSeDVkQ2V4a2Nz?=
 =?utf-8?B?bE9YT0ZZaGVoZUNkK0hDN2g1K05wdkcrTXcxT1ZMaWdYaGV3OW1zbDJkcjMv?=
 =?utf-8?B?VTc1c0Mrc3ZRemM2WHhqaTZiTWZLRlRENzBmUXBCa2JqN1pBTmc4QjdWTU03?=
 =?utf-8?B?MUJSYTIzMW4zcmZWODZxZzFGamNFc2Rqa204QlBleldsMy9zWnkzNTlJWjdu?=
 =?utf-8?B?S2dVeEQ3bkd4TTRUdUpkNW9vNm9NUjNoNWQ5SktqY0VDRS81RE4xa09DM3RX?=
 =?utf-8?B?QUxmVE9tNU16bDJYbHU3L2ZLbU1VZEhzdFBhSVhjRVZDZUtVVkRNblVXUEJm?=
 =?utf-8?B?czdOYjBiN3YxVUlIUFA1Yk9ybzNOVk9FWVFpdXAvT3JWZGRBNUxCVjc2eXNq?=
 =?utf-8?B?elFTb056ajh3UGtaOHczMExJOHRCQURYK3pKYmszK1E1eHdITE50V2Q5R2NB?=
 =?utf-8?B?K2pvWTNXd1BPSFRFOWdOZG5OdE4zQnIyWTUyUEZuUG5qOWpZV1RCYVZoZWc3?=
 =?utf-8?B?RVM2NmhOT3NRdHl1azFweGtqY2JEOWltUXBJaEp6QjQ1V1pKZUdSa2lMUGZL?=
 =?utf-8?B?aHRaWFM3WitCVTlNcUZ6Vng2VWVHaWNHRHcza0tkTkNnSWNLUisyMU9lM2o1?=
 =?utf-8?B?emFPbjg2OG9kd2h4UWFnMk03L2ZQWHF0bllzelY5bk11UjlWelIyVU5tbGta?=
 =?utf-8?B?SlM3VjhrOWc2SVQ2YzVMeDM3dmE3eDhtcUIwWXZ0ODNSSmM5UU44YjdDcHBL?=
 =?utf-8?B?TjRmeWwvSnJPMDdhcVhiZmZDbnl0SFVWVzZYZU9mMWhveS9kVXRRQllDNG4r?=
 =?utf-8?B?bE5RdkdSNk9rWUdUdUxCbTAxdjE3a0RUUnlBUUhTTnNzRlJHTXVhZXh0ajBO?=
 =?utf-8?B?d3d2RkN1dDRRdGZTSUMxS0RUc0x1aUxLNFk1WmR3WUthVW44VkdnbGMrOVVo?=
 =?utf-8?B?RytacVJUdWhHMjR0N3RQQlQ0OEFPZVJBS1FNbWUzZjNLc0E9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR18MB4734.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?aGg1SklVV3ozWXoySEZySFdWRWNXRFM1aUtXc0Nycjh0Z2xGV0pQUkk2akgr?=
 =?utf-8?B?cVBEZHJKd2phQ0djbDQ5UnZHRTNUN3h0SUMwamdiWHMxS2ttSm1PU04vSDZi?=
 =?utf-8?B?QUgzMk9LODNGVStQc2FBaDRIVTdwN1NiakQ0em5saWlOV2ZLcHpBUW9Yayt3?=
 =?utf-8?B?MVhuNkFmRUlFVHZZekh1dzZKTDI2QVhPNTV3MGRCeHgzUkdrOUMzcGJpY1JN?=
 =?utf-8?B?T2RyR1JJTkZGQUtXMmJDNklBY3NXejI0YjR4QllrZzZyOHBOSkZXNTdNNUxB?=
 =?utf-8?B?bTgxdmk4blVIeHAwY3BhYmlVL1NmV1JYU0JqbGRmTksyTWphV3AwdTNHVmF1?=
 =?utf-8?B?TVhXMTlEd2dUb0VmRzlpMGZMTDBYaDdsdzF2bUZRSmxRaklEa0lVTXRkYUFS?=
 =?utf-8?B?SHBHcUNmRURpRjdOU2RIRC9abU13dzR1a1RhVUZTa0U0enpVRXB0UldUZzhN?=
 =?utf-8?B?cWxTT0JPbmJMVkVndlFYaC9NUFdvWnFCREQ1SG52elI5WVFMc0xOTFhSTmlM?=
 =?utf-8?B?TjR3VFphU3NUaXovaFBDVXJEWEF3N0k3cEFza2xjR3JQRTU5eGJuNWh0YVVZ?=
 =?utf-8?B?ZldWdTdFRkZ6ZEN1S1BzdTR5L3l5anhtTS8wY2Zjd0xtOXBGcXdiVXkxRWJm?=
 =?utf-8?B?Zk1zZnN1R2JUYVJqT3hNS0hRZWlsSzNsWnNhdHZqL2xrNHQwVnFFcEtmejMx?=
 =?utf-8?B?dWxZLzcydk5mY0hFT0FQMGlxNVMyeG1LZVVQV2p5OUxYMGU5RStYdkh2WU05?=
 =?utf-8?B?NitGZXhSUUFPbjU4cVc3YWQyYi9ucitJR2VzWWpVdzFyNCtSWC82NGtiOW5K?=
 =?utf-8?B?ZmlJSDh2bnpvRWQ5OTZOY0E2dzNIME8yK2VZd04vWnpIWjJZb3d0NDdScDAx?=
 =?utf-8?B?OG5vMSt5ZmZGRTJYUERINFlyRksyRFA0dHc1VjUrMU10bzNwSFN4emdzSkJz?=
 =?utf-8?B?aUNkZ01vS3poM043aUNXanRPTFNDY1A4UWhOWmdicHB4MnFrb1hXU1hlbjlm?=
 =?utf-8?B?dFcvNTgrWUhnd2E4c2RWcnVTYVBueDVabjBzOGt0SWlhSng5SUU2WUN1UUhK?=
 =?utf-8?B?S1RZVWVZdStnZzhFL2M4U040U0VUUG5YTW1VYklVZzU1dVNYc3Y2aTYrSTBH?=
 =?utf-8?B?Smw1NXN4dk1pdVN0WVRLemo1czhSU3kyMmtnTmR5Sk1HbGRnSUlkUHpHbzNu?=
 =?utf-8?B?NWQrNEplY1V6VFc1SWlQV3dqSklDamJnbnJxOU03STlkWVI0YVIraGdZSTdM?=
 =?utf-8?B?MU1NMHhPdU5Fckx2YlcwVXJrVmd3amJmUGx4UTIzVzRiOWRMeWVvRTZSSVpP?=
 =?utf-8?B?dENsd0YrTDdYS3pWUVVEaHAvK2dBYUljNXlpWksyYnlha2R0b3lMOXpiRysy?=
 =?utf-8?B?c3Nhdll4SnpIZzhaNXo5YXJjekp2c2cvUE41bUFQYzlpbnI3N0VYYkw1cXU5?=
 =?utf-8?B?TlVWWDNnRm5HVU1VbEhrOGlUVytFZTVEYk9DVGtUckt0dVUxNFBoUDZpeTFk?=
 =?utf-8?B?QXBEY1FFUVBjVFRTME9qa1ZTcERENFAvNFQ3NGJHS0xiSys1cEVMaHl5MDZz?=
 =?utf-8?B?RmlzbVZrbVQ2YnMvOEV6SytmaWRvM1FTSENZZzNZMS9sVDZGQ3VrL01rZjBs?=
 =?utf-8?B?OS9udVl5dUdLbTRxVm5JVnpYVThkN21lbkVyYzJWMU9hVlhHWUhZcGt1S2E3?=
 =?utf-8?B?Ukw4RjVGdlFlL2ZuR3FKaTMyenBkTXVzNlNDeXIyc0FvdTB6TlUyZ3VWQzVE?=
 =?utf-8?B?T2l2b25IdFE4SVZ6ZTlGUWtlejFvVS9sT3VEd3Y0bWcwSE9CTyt6dnNDZ3lw?=
 =?utf-8?B?MGNZQ3dSYTUrWWhjdHRlRzlQalVFSjNTRjk5K0s1RnY3Q3dmR01yQVBjeVVv?=
 =?utf-8?B?TUFLQ3Z2MExKMGtGUmxzYzd1VlNLbWZZaWNQMS9YR0dZQTY3enpFNUwrUzBu?=
 =?utf-8?B?ZHJDVm1GQ21aRnJ6dUNxRFo5S1RNUTEzNVA0d1Q1MHdmazFJcVZHVTh0UStQ?=
 =?utf-8?B?V1J4Z09CYnMwUnc1ajBjaVlPQnRQQVY4VDgrdjNLQk13dUI0dFdTYlhmSytU?=
 =?utf-8?B?d2hBS1pDVkNMSkNSZzM0dWZyVUV6U3NSWDZrTGRYVGUzWkkyNXZieUxMRmlu?=
 =?utf-8?Q?0UMyeVzcs2PYYrLWwampK8nBK?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: ced1d1ab-7868-4424-24a3-08dd2ee2323d
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jan 2025 06:11:59.6358
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hecMCfK6yM1Yzrm4s6QDGKL4Cdzh/gtK53XPif5yPAomDCQLcnOwkNPbXqEO/iaNj3Q5FvCLPLSbJV/6JNYUQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR18MB5621
X-Proofpoint-ORIG-GUID: k4zjcc-YCbQhPbxdbRsO0U8jdS_wm6-7
X-Proofpoint-GUID: k4zjcc-YCbQhPbxdbRsO0U8jdS_wm6-7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.687,Hydra:6.0.235,FMLib:17.0.607.475
 definitions=2020-10-13_15,2020-10-13_02,2020-04-07_01

SGkgSmFrdWIsDQoNClRoYW5rcyBmb3IgdGhlIHJlcGx5LCB3aWxsIHJldmVydA0KDQo+IC0tLS0t
T3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEpha3ViIEtpY2luc2tpIDxrdWJhQGtlcm5l
bC5vcmc+DQo+IFNlbnQ6IFR1ZXNkYXksIEphbnVhcnkgNywgMjAyNSAyOjI3IEFNDQo+IFRvOiBT
aGluYXMgUmFzaGVlZCA8c3Jhc2hlZWRAbWFydmVsbC5jb20+DQo+IENjOiBuZXRkZXZAdmdlci5r
ZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBIYXNlZWIgR2FuaQ0KPiA8
aGdhbmlAbWFydmVsbC5jb20+OyBTYXRoZXNoIEIgRWRhcmEgPHNlZGFyYUBtYXJ2ZWxsLmNvbT47
IFZpbWxlc2gNCj4gS3VtYXIgPHZpbWxlc2hrQG1hcnZlbGwuY29tPjsgdGhhbGxlckByZWRoYXQu
Y29tOyB3aXpoYW9AcmVkaGF0LmNvbTsNCj4ga2hlaWJAcmVkaGF0LmNvbTsga29uZ3V5ZW5AcmVk
aGF0LmNvbTsgaG9ybXNAa2VybmVsLm9yZzsNCj4gZWluc3RlaW4ueHVlQHN5bmF4Zy5jb207IFZl
ZXJhc2VuYXJlZGR5IEJ1cnJ1IDx2YnVycnVAbWFydmVsbC5jb20+Ow0KPiBBbmRyZXcgTHVubiA8
YW5kcmV3K25ldGRldkBsdW5uLmNoPjsgRGF2aWQgUy4gTWlsbGVyDQo+IDxkYXZlbUBkYXZlbWxv
ZnQubmV0PjsgRXJpYyBEdW1hemV0IDxlZHVtYXpldEBnb29nbGUuY29tPjsgUGFvbG8NCj4gQWJl
bmkgPHBhYmVuaUByZWRoYXQuY29tPjsgQWJoaWppdCBBeWFyZWthciA8YWF5YXJla2FyQG1hcnZl
bGwuY29tPjsNCj4gU2F0YW5hbmRhIEJ1cmxhIDxzYnVybGFAbWFydmVsbC5jb20+DQo+IFN1Ympl
Y3Q6IFJlOiBbRVhURVJOQUxdIFJlOiBbUEFUQ0ggbmV0IHY0IDEvNF0gb2N0ZW9uX2VwOiBmaXgg
cmFjZSBjb25kaXRpb25zDQo+IGluIG5kb19nZXRfc3RhdHM2NA0KPiANCj4gT24gTW9uLCA2IEph
biAyMDI1IDA1OuKAijU3OuKAijA5ICswMDAwIFNoaW5hcyBSYXNoZWVkIHdyb3RlOiA+ID4gPiBz
dHJ1Y3QNCj4gb2N0ZXBfZGV2aWNlICpvY3QgPSBuZXRkZXZfcHJpdihuZXRkZXYpOyA+ID4gPiBp
bnQgcTsgPiA+ID4gPiA+ID4gLSBpZg0KPiAobmV0aWZfcnVubmluZyhuZXRkZXYpKSA+ID4gPiAt
IG9jdGVwX2N0cmxfbmV0X2dldF9pZl9zdGF0cyhvY3QsDQo+IE9uIE1vbiwgNiBKYW4gMjAyNSAw
NTo1NzowOSArMDAwMCBTaGluYXMgUmFzaGVlZCB3cm90ZToNCj4gPiA+ID4gIAlzdHJ1Y3Qgb2N0
ZXBfZGV2aWNlICpvY3QgPSBuZXRkZXZfcHJpdihuZXRkZXYpOw0KPiA+ID4gPiAgCWludCBxOw0K
PiA+ID4gPg0KPiA+ID4gPiAtCWlmIChuZXRpZl9ydW5uaW5nKG5ldGRldikpDQo+ID4gPiA+IC0J
CW9jdGVwX2N0cmxfbmV0X2dldF9pZl9zdGF0cyhvY3QsDQo+ID4gPiA+IC0JCQkJCSAgICBPQ1RF
UF9DVFJMX05FVF9JTlZBTElEX1ZGSUQsDQo+ID4gPiA+IC0JCQkJCSAgICAmb2N0LT5pZmFjZV9y
eF9zdGF0cywNCj4gPiA+ID4gLQkJCQkJICAgICZvY3QtPmlmYWNlX3R4X3N0YXRzKTsNCj4gPiA+
ID4gLQ0KPiA+ID4gPiAgCXR4X3BhY2tldHMgPSAwOw0KPiA+ID4gPiAgCXR4X2J5dGVzID0gMDsN
Cj4gPiA+ID4gIAlyeF9wYWNrZXRzID0gMDsNCj4gPiA+ID4gIAlyeF9ieXRlcyA9IDA7DQo+ID4g
PiA+ICsNCj4gPiA+ID4gKwlpZiAoIW5ldGlmX3J1bm5pbmcobmV0ZGV2KSkNCj4gPiA+ID4gKwkJ
cmV0dXJuOw0KPiA+ID4NCj4gPiA+IFNvIHdlJ2xsIHByb3ZpZGUgbm8gc3RhdHMgd2hlbiB0aGUg
ZGV2aWNlIGlzIGRvd24/IFRoYXQncyBub3QgY29ycmVjdC4NCj4gPiA+IFRoZSBkcml2ZXIgc2hv
dWxkIHNhdmUgdGhlIHN0YXRzIGZyb20gdGhlIGZyZWVkIHF1ZXVlcyAoc29tZXdoZXJlIGluDQo+
ID4gPiB0aGUgb2N0IHN0cnVjdHVyZSkuIEFsc28gcGxlYXNlIG1lbnRpb24gaG93IHRoaXMgaXMg
c3luY2hyb25pemVkDQo+ID4gPiBhZ2FpbnN0IG5ldGlmX3J1bm5pbmcoKSBjaGFuZ2luZyBpdHMg
c3RhdGUsIGRldmljZSBtYXkgZ2V0IGNsb3NlZCB3aGlsZQ0KPiA+ID4gd2UncmUgcnVubmluZy4u
DQo+ID4NCj4gPiBJIEFDSyB0aGUgJ3NhdmUgc3RhdHMgZnJvbSBmcmVlZCBxdWV1ZXMgYW5kIGVt
aXQgb3V0IHN0YXRzIHdoZW4gZGV2aWNlIGlzDQo+IGRvd24nLg0KPiA+DQo+ID4gQWJvdXQgdGhl
IHN5bmNocm9uaXphdGlvbiwgdGhlIHJlYXNvbiBJIGNoYW5nZWQgdG8gc2ltcGxlIG5ldGlmX3J1
bm5pbmcNCj4gY2hlY2sgd2FzIHRvIGF2b2lkDQo+ID4gbG9ja3MgKGFzIHBlciBwcmV2aW91cyBw
YXRjaCB2ZXJzaW9uIGNvbW1lbnRzKS4gUGxlYXNlIGRvIGNvcnJlY3QgbWUgaWYgSSdtDQo+IHdy
b25nLCBidXQgaXNuJ3QgdGhlIGNhc2UNCj4gPiB5b3UgbWVudGlvbmVkIHByb3RlY3RlZCBieSB0
aGUgcnRubF9sb2NrIGhlbGQgYnkgdGhlIG5ldGRldiBzdGFjayB3aGVuIGl0DQo+IGNhbGxzIHRo
ZSBuZG9fb3AgPw0KPiANCj4gSSBkb24ndCBzZWUgcnRubF9sb2NrIGJlaW5nIHRha2VuIGluIHRo
ZSBwcm9jZnMgcGF0aC4NCj4gDQo+IEZXSVcgSSBwb3N0ZWQgYSB0ZXN0IGZvciB0aGUgcHJvYmxl
bSB5b3UncmUgZml4aW5nIGluIG9jdGVvbiwNCj4gc2luY2UgaXQncyByZWxhdGl2ZWx5IGNvbW1v
biBhbW9uZyBkcml2ZXJzOg0KPiAgaHR0cHM6Ly91cmxkZWZlbnNlLnByb29mcG9pbnQuY29tL3Yy
L3VybD91PWh0dHBzLQ0KPiAzQV9fbG9yZS5rZXJuZWwub3JnXzIwMjUwMTA1MDExNTI1LjE3MTgz
ODAtMkQxLTJEa3ViYS0NCj4gNDBrZXJuZWwub3JnJmQ9RHdJQ0FnJmM9bktqV2VjMmI2UjBtT3lQ
YXo3eHRmUSZyPTFPeExENHktDQo+IG94cmxnUTFyalhnV3RtTHoxcG5hRGpEOTZzRHEtDQo+IGNL
VXdLNCZtPTlnc0gzY3VPSm9GcGJnTmlRYzJncVk2X0N1Z2g1R2VCQ0tGVTltbWJsc0J4cHNsUFcy
cQ0KPiBWVkJhMUxHN3c4cW1iJnM9LTlHYW8zb1N3NHdBcDZMOFY4NmhsaTRCbXF1M1BvOGpmT3FO
T3RZd0wtDQo+IG8mZT0NCj4gc2VlIGFsc286DQo+ICBodHRwczovL3VybGRlZmVuc2UucHJvb2Zw
b2ludC5jb20vdjIvdXJsP3U9aHR0cHMtM0FfX2dpdGh1Yi5jb21fbGludXgtDQo+IDJEbmV0ZGV2
X25pcGFfd2lraV9SdW5uaW5nLTJEZHJpdmVyLQ0KPiAyRHRlc3RzJmQ9RHdJQ0FnJmM9bktqV2Vj
MmI2UjBtT3lQYXo3eHRmUSZyPTFPeExENHktDQo+IG94cmxnUTFyalhnV3RtTHoxcG5hRGpEOTZz
RHEtDQo+IGNLVXdLNCZtPTlnc0gzY3VPSm9GcGJnTmlRYzJncVk2X0N1Z2g1R2VCQ0tGVTltbWJs
c0J4cHNsUFcycQ0KPiBWVkJhMUxHN3c4cW1iJnM9cTh1UE5OYWVfLQ0KPiA0cHMxOEJUNlhPZWw5
SHNZQXBzeGg0SU4wMUhGMl9BUncmZT0NCg==

