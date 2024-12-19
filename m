Return-Path: <netdev+bounces-153441-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EA439F7FBB
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 17:28:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A890B162185
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 16:28:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E50AC22653B;
	Thu, 19 Dec 2024 16:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="dr1Yw9E/"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F7192AE96;
	Thu, 19 Dec 2024 16:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.156.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734625724; cv=fail; b=ILxabYgft8tpe3/I7xND5DcjnQVcibhlyPv9tNYHWg4gVA6Fwxr5E7kGoznNNeGuI8DF7EjI1VGwq0cbv2enjJtlzcBgdLf6hzCa4aX00jSdFMTGx+3wjI+YE043Jvv5zo9Y/dETjhk52xVaHcPPP5lKDNDC/C3s+fteGySWOvg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734625724; c=relaxed/simple;
	bh=guhqIh/T+dw+ZIlMosQu1qeakhC81qRWOhwesSgseMc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=PjWrmMGhJLTaiADFdKprSIM1VPWgdJ5oDDCtudLZLe0OReAIOSgife+MN0s1rAMnoU9es8JxQKn8AUQnPi2qclzK3HdXuLubhsdj9U74PVu3Gfr4hwcgaA7q4NSeey9qRq2L1uldctjFrY/oMWJ5zNMtjFWwLIzt1vaS8lK0rQs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=dr1Yw9E/; arc=fail smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BJF3quQ030935;
	Thu, 19 Dec 2024 08:28:26 -0800
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2176.outbound.protection.outlook.com [104.47.56.176])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 43mnt2r5xq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 19 Dec 2024 08:28:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ewgfPuhrNLrOKC3lQ0u1BvJ35MpwIbmYgDVtF2HmYv30wnHgrapK76ThqLI5TVj1c/25tSmmg+CWxk2U01vgAgufaS9O+G81HLMhMIxdCOAyJYaDXTW2Bb9gWG3vYOrMTvht0V473q8Mp0PP8UwDwXJlvTsDX4j041fMgh2PnS/lSpG5l/7w4zjJLdcnQtKfVcOhJnvnjrAmVRzKAG0SNKFfnBSehGycBqJfFmaYb6WufemnfcNAWmEPaAK0HFMy533gJwPQ9RjmDTTUk7YfvmOuTLyMk/u5pnDND3KDZtEL1Wr6dXIaER1vg+VvyGeSb4lcmemDp9gl/J48bVwM4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=guhqIh/T+dw+ZIlMosQu1qeakhC81qRWOhwesSgseMc=;
 b=kKpHJmCvIOxsdia14HYO60d3PGVigzZRj3wYQY4UWAK4M1v9mIP7rpFk8JDqcvVgxgvCuVIW2zQUXqA60BDeYOEQADGyQEst0wjMW7mZN3n+bgTXdRRiF/aPCR5AYjLpU/P8SoK7sjzvNioVJJgrjqeZCUgOwzl/QCebIswxLAah49UpxzYKk31zmJWGz7PywJw3RsMx36XZJ45Vp933nXVhQMHziMF034LP20uV5Bnt4jYge+QN/7m6KJsbKhv7glGIbM3G/hHkqQwAUQ3javBn99IwA6nL6obOfJi6ryA436TMXdmyW+mQ/Bz8n6rEA1JNMiVdhmeVLrb7kCkd8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=guhqIh/T+dw+ZIlMosQu1qeakhC81qRWOhwesSgseMc=;
 b=dr1Yw9E/ZlupHL5gqS/tncGpaSgwvC8hIuUjWQMl8LWf0z0AThhyp2QjGAYs8UEWtH5Pl6sJ5pmIRaMxW9/O5Mo2FPkz4RIHluyOhSOX1ASfeb3KdA5l7d42gjxSoHltgKckpQodSb3f//HrwcLz1nZITa2MRqtzM8l7KYxsQRM=
Received: from CO1PR18MB4729.namprd18.prod.outlook.com (2603:10b6:303:e8::13)
 by SA1PR18MB5719.namprd18.prod.outlook.com (2603:10b6:806:3aa::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.14; Thu, 19 Dec
 2024 16:28:21 +0000
Received: from CO1PR18MB4729.namprd18.prod.outlook.com
 ([fe80::3fc5:bf52:d1d0:3d9e]) by CO1PR18MB4729.namprd18.prod.outlook.com
 ([fe80::3fc5:bf52:d1d0:3d9e%7]) with mapi id 15.20.8272.013; Thu, 19 Dec 2024
 16:28:21 +0000
From: Shinas Rasheed <srasheed@marvell.com>
To: Eric Dumazet <edumazet@google.com>
CC: Larysa Zaremba <larysa.zaremba@intel.com>,
        "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        Haseeb Gani <hgani@marvell.com>, Sathesh B
 Edara <sedara@marvell.com>,
        Vimlesh Kumar <vimleshk@marvell.com>,
        "thaller@redhat.com" <thaller@redhat.com>,
        "wizhao@redhat.com"
	<wizhao@redhat.com>,
        "kheib@redhat.com" <kheib@redhat.com>,
        "konguyen@redhat.com" <konguyen@redhat.com>,
        "horms@kernel.org"
	<horms@kernel.org>,
        "einstein.xue@synaxg.com" <einstein.xue@synaxg.com>,
        Veerasenareddy Burru <vburru@marvell.com>,
        Andrew Lunn
	<andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
        Abhijit Ayarekar
	<aayarekar@marvell.com>,
        Satananda Burla <sburla@marvell.com>
Subject: RE: [EXTERNAL] Re: [PATCH net v2 1/4] octeon_ep: fix race conditions
 in ndo_get_stats64
Thread-Topic: [EXTERNAL] Re: [PATCH net v2 1/4] octeon_ep: fix race conditions
 in ndo_get_stats64
Thread-Index:
 AQHbT5BaYIqjRH+Vi0yNdgQ+YpYURrLo7ucAgAAEnACAAD0IMIABfHCAgAAKTTCAAUofAIAAD6YAgAAH6gCAAAPGAIAAAZdwgAAIpoCAANsEIA==
Date: Thu, 19 Dec 2024 16:28:21 +0000
Message-ID:
 <CO1PR18MB472962C9345E15B8F1988E25C7062@CO1PR18MB4729.namprd18.prod.outlook.com>
References: <20241216075842.2394606-1-srasheed@marvell.com>
 <20241216075842.2394606-2-srasheed@marvell.com>
 <Z2A5dHOGhwCQ1KBI@lzaremba-mobl.ger.corp.intel.com>
 <Z2A9UmjW7rnCGiEu@lzaremba-mobl.ger.corp.intel.com>
 <BY3PR18MB4721712299EAB0ED37CCEEEFC73B2@BY3PR18MB4721.namprd18.prod.outlook.com>
 <Z2GvpzRDSTjkzFxO@lzaremba-mobl.ger.corp.intel.com>
 <CO1PR18MB472973A60723E9417FE1BB87C7042@CO1PR18MB4729.namprd18.prod.outlook.com>
 <Z2LNOLxy0H1JoTnd@lzaremba-mobl.ger.corp.intel.com>
 <CANn89iJXNYRNn7N9AHKr0jECxn0Lh6_CtKG7kk9xjqhbVjjkjQ@mail.gmail.com>
 <Z2Lg/LDjrB2hDJSO@lzaremba-mobl.ger.corp.intel.com>
 <CANn89iJQ5sw3B81UZqJKWfLkp3uRpsV_wC1SyQMV=NM1ktsc7w@mail.gmail.com>
 <BY3PR18MB472105E5D09B8FE018DBFC15C7052@BY3PR18MB4721.namprd18.prod.outlook.com>
 <CANn89iJ-vz8dfrHv2QChiQWUk14bQJfykTTYLMmOuHejgii4nA@mail.gmail.com>
In-Reply-To:
 <CANn89iJ-vz8dfrHv2QChiQWUk14bQJfykTTYLMmOuHejgii4nA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR18MB4729:EE_|SA1PR18MB5719:EE_
x-ms-office365-filtering-correlation-id: 0d457e72-325b-486e-726e-08dd204a2743
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?aUhPdHBBRjNmRkRaZ0ZoUkxib3lIVGx0dkF6KzJieGp6TExPeUQ0cU4vZ1Fo?=
 =?utf-8?B?eVRrMlcreDVzV2ZsNTVtUVQ4U3paOUhRdzRNb1lhVzlBd3htT2dMV3lEUmU5?=
 =?utf-8?B?b0pwSDJmQ09CU1ovQXpPWnRUMGVOeXdhZXdHNE8wZHh1MDd5SDlUclJaTjlM?=
 =?utf-8?B?eWQ5VTFkaTRCL3Z2ZFN0cjJ0V1A0Ymh1ZW5jQ2F4N0doVzljSmlHYXRjSmZT?=
 =?utf-8?B?anNVcVBsSHdOcGk2OVBseWs4OER0TWFYczJTaC8yMVpPUnNhZDczeGlZK2Ri?=
 =?utf-8?B?Rlk2Y0FCZktoK0E4VnNkc3ErZDBCVTg1LzFhOFNjb1ZVem16WmtYMkNKV2xR?=
 =?utf-8?B?KzEzRDNsSVZwYUpjYzlYRHRQUktHbW10QW0wSDlaY05NYSsxWFRkdFo3UTUy?=
 =?utf-8?B?a3JaZFZ5UWhyVVNwR0xWZjZ3bUFNM3cyTXIyRElTZE1FWW82ZTdzbDFNU3E0?=
 =?utf-8?B?MitjSDErSkdjbUd4bStmVndUVjFOU0Z2bSt1M0dBbmp3UmhobVhHVWZmRWxh?=
 =?utf-8?B?KytzK3J5TXhkVTRDbCtsYThGOXNnTllqaTJOeU13b0lTWDgvNDVDVitLMklI?=
 =?utf-8?B?anBuNmJFRnBFM0FBcUNuMXNoVmdKQUlTU2IvL2orRjJtcUdQV3JES0twQUxR?=
 =?utf-8?B?Q25WOUwweEZpYzdhN3pNdTA2QkdQeUdRVkc5QW84Nmx2OGh3bUZ6b29Xa1hT?=
 =?utf-8?B?T0dFNlFPaWZwdmN4d3VqTjlNYWM3a2VFUjYyQWc4ZlBuWFN3R1NZcFhFaTFY?=
 =?utf-8?B?bjlVVlZKY2prcEpZRDlUU1JMbEIyU1k1cEVNV2RaUU5NV0FyZnRENGx5UWFX?=
 =?utf-8?B?WlZXNjZGbHMxS1o2eWNCb0tuYXVvenZKV09lcmMrUHcxTmFtTUNZa0o0d094?=
 =?utf-8?B?UytQYm5WaC94Z2NhUzY1ODBwVnZkVC93cnR6TVhPQmRmNEMrRnc2UnJjNzRr?=
 =?utf-8?B?SjR3NWJyOFRGeU9JelpkbWdueGdCcWV5ZHQ0U0RUUUhhSXBEUFZFRko2T2lC?=
 =?utf-8?B?Rm1RMWs5NUY1KzVORFArd01WdE0rZWViZHJnbkdCN3dZVVp2cHBwUDFHVGFP?=
 =?utf-8?B?dXVETnZFNEZhUU9Md09JQkNTV3dyWjBSYTgyelVyS3Fvc3RzSjcvTEdIU2M0?=
 =?utf-8?B?QmdEOVpsRFQrUHovejlMT0RESURpRnlQQ2ZaUW92OEFTOS9UN1o4UzR3RzMz?=
 =?utf-8?B?aXAvTk9mZ2FhYkovRUhLSE9Bam9lM3dLdHh4OVhGQng4QnVqaTNtcGo3T1NC?=
 =?utf-8?B?R2d6MGRYVXVmVm5RT1J6eGxwb014T2dwUWlzSVVDTlV0TndjK2xCTkhOdkVk?=
 =?utf-8?B?OVJzTGZXb01wQmNTYm0xNFVBV2lWN1crTVZJNGxTR0NVcjZzVnhjOGdncjBY?=
 =?utf-8?B?OVN0NzNWNi8yMEtvZzlZUnNUL1cwZElIZjE3SGd3Z3I4WWdtRXFNRGJ1MGZH?=
 =?utf-8?B?TExkdC9yU2F4YkE5QUJYck5FV1J6MXQ0NUt5dmtJbFA2Q3RGaDczTFJvay9v?=
 =?utf-8?B?UXFNN3l0Uzc1c2FSU2puN3NSRTZoclZ0Uzc5MzZEeE84WmRvVDJvWG1reHpT?=
 =?utf-8?B?dHJlbC9oSmxpM0MzdCsrL2lTT0JFUDIyMkVuT3J2cHJPSSt3djByaDdzaFk1?=
 =?utf-8?B?RHV1U09WcXBtMnFwQ2s3NWh2NmEzRnZMMVZPazNqR1Z1RWl6TVlncE1yRHZm?=
 =?utf-8?B?NnhkaXFacmFGdFYrelROVWFNZGRDNVcvblJVbnRoWXR3WnBlTkhiNFU5amor?=
 =?utf-8?B?cWZIcTcwY0t1WjVxeGMrcWtkUlBqcVg5NHBycXlodjZjUGFNRzcxdWlCeEI3?=
 =?utf-8?B?WXhUNyttdzdoVGVWYmFkZnhiNGloUUxPaWtoM25BRGh4RjIzYlJFWjVHWmYz?=
 =?utf-8?B?Mk1DT3BlTzIwZUxIS0JUczdEMTl1K1dJdGZrM1JaUzQvMXVCT2RJOXN4RENX?=
 =?utf-8?Q?S7gKGq0KeDq7SsTqPsuADu0zI3sH6Jnf?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR18MB4729.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RzVNMkpxdUNST3BhNFIxdGs1M0RqbUZOSDZvNzNQd1NJU0krTGU4Y0dVTDNz?=
 =?utf-8?B?d0lVZTBjb21mbjVUOWtjN2JEN29mYUlJRjlSTGZGcU01cVhXclYvS1BLTDU1?=
 =?utf-8?B?MXUxMFlVM2RmRU1RcTZGaVJ4YTVhM1VxSThXOFNCMDR5ZHlhdU1ORE10cG5V?=
 =?utf-8?B?N2ttSm9zMW93akhRaDhna0k2T2pNdTFNYWd4Y0lZK3ZSeFljRW51RXYyd2pt?=
 =?utf-8?B?ZSs1N21ZWlFiMGNTT3hEd3p4aHRFR2FnNSs3K1pmeXVjMlR2eng1WHlJLzg0?=
 =?utf-8?B?WUN1S3Z0UTRoSHJtc2dVQnYrSkFzaHoxNndmNXlSMEdJZnc3WEFHMzBNV1Nj?=
 =?utf-8?B?UFZHK2pYTUxnanp5bzdCSGZKeVRNd3V2Z1N0Z2JramhiNEQ1M3hGODZRN2dt?=
 =?utf-8?B?clhMdXNCcTNDWkFZQndZdkM3VVd2eGZMUVB1ZVJlc0tYcFViYmYvYVFqYzFI?=
 =?utf-8?B?RjUrOUpJOXdxaGVOTXlCNFM1bnBXTU1zVHJwVDdaQlY4ZTAzbElyNnFWUk5w?=
 =?utf-8?B?ZnBTNUUrVTAvOW56MVYzVHFGYmM2RFBrZWFCdk9RREpMWW1HMTdsckNHcFNw?=
 =?utf-8?B?SWp2UXdFaEQyU3RSQm0rdkorN3lNOW5UcEV6aUVpS0RpTThjSmNURGZCdEtB?=
 =?utf-8?B?VUNYem81Rmc2S2ZwcnAzQW9MaURTdUVRdlZmRmZRN2hjSUNZV1hSZmI0OVhM?=
 =?utf-8?B?T2xjK3Y2YlRmZGJWcjRBbk91NmdZTlI1M25QemhPbEhPdlRwK3VLL1dSTDJs?=
 =?utf-8?B?Q1BVdk1oS3FITFliaGkwTVFPc3hGeWNhdFU2YTR6K01OZXFjZ3pnU0hidTlp?=
 =?utf-8?B?VmxvY0oxR0VyT3JmMmcrbWVGakJlMlhnK2pMdFZFOCtabDlWcmU0U1VJQWVo?=
 =?utf-8?B?eHpQRTlEWDRnR2V3R3kzcFF3OE9MbDM4OWowRDlKTkJTQUVQVTF1Q1lEc0cr?=
 =?utf-8?B?SlhnWVUxdnV3eTVHNzVPUitHcHNKTW9nRFBETlp2KzdaQjdCWDAvQVNVZDhE?=
 =?utf-8?B?MzlRbG1GZ1p6Qmc2Qmp6SFg1cUpXd3BxQTh2REZod1lHaUIrTWwxV1hGajJh?=
 =?utf-8?B?eHQ3VUhtb3F6aGFCMlB5SUN3YjQ0TDF3SVNpTDJkRkpZZUxlUlcwN1YxY045?=
 =?utf-8?B?V2NDRTlxNVBTTXpEeS9zc2lJYk5kNDdFdzg1bmlGYWlGaURVTnpKcVd0dTg4?=
 =?utf-8?B?c200MjJMRVFxMjZXa3NQNEFObmxsSEt1UWpHT2t4cUlmc1o5RUhQZVJ4a3ZB?=
 =?utf-8?B?Uno5MkZwYjhTZWJXamhxd0dxMzRCU0F1Tlc2eG5IZU1LTzdHNC9oK2c4aXdT?=
 =?utf-8?B?TG5YNTZmWWFoYUIvbzdzbHlPS2FNbGt6QnJUVjZqb2JWQU92eXR5RDZFb2ZK?=
 =?utf-8?B?Q2NrNXFxQnVIbk9zWVM1RmNLY1BjQjF2UEtsTE1KbHpjSkhkYkxaWUl1cEo1?=
 =?utf-8?B?ZFFpNTNzbzA3bVg4Z211aTI4T3RZclVwTjBUczM4d1c0bjdHb2x5d1RWckpw?=
 =?utf-8?B?UlNZTW41ZFAyOSthYXo3c1E3MWRxVkVhME1TQkp1NDRHN0QzaHVOUjJYalJi?=
 =?utf-8?B?cU5oMmFaRGQrZFAvc2JVeTdqME5VQzZaSnZ0Z010SGtpWW1mbzltMzRvdS9H?=
 =?utf-8?B?dEFpZ25zTGtSK01LbCtOSThCZ2dadzNJL1U3STlqeHRvMTZBZWJ0M09aM3Jn?=
 =?utf-8?B?MVdHTmVQUFBhL01GOVRxOVZxTHVpc3ErM1dUR0x4QVk2WTh6My9iV1hnS1dj?=
 =?utf-8?B?dWpYanFmeXN6b1d0aWJWZUJFc3FoR3BidytnZDRSNXYxY00yUFlDdUpzbER3?=
 =?utf-8?B?NFg4OWcyS3pWNU9KVU0wWUJIQTVJYkkwanFxdXlORFF0Q1ZxQ01CT0RZaVZz?=
 =?utf-8?B?NXU2KzRuUFh6VDRSZGZXSnZBdTNra3V0VEpMRXRLVjJxdUVFQ2toTldjWDhX?=
 =?utf-8?B?Z0Nwdmh3K094TG5KMGp3VkJxdk9GTXhwTE1JRW9lQ0ZjNHcyYlhFemFVci91?=
 =?utf-8?B?WjF6WU1mVW92SWpSdmk3L3NTZ1NpMGgzYTJMSnVOS1ZyMEhKM1BSTTdyMGU5?=
 =?utf-8?B?R2VDckROalllajB6R2Y1SkprbUFSZlhnRktsMjhkVGlnRXBteTB0QXN0dFBu?=
 =?utf-8?Q?jPTiimcI30IUsNTlJ3KR8J81v?=
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
X-MS-Exchange-CrossTenant-AuthSource: CO1PR18MB4729.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d457e72-325b-486e-726e-08dd204a2743
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Dec 2024 16:28:21.4854
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jozyhvNb1H+fEDCS3FzFSF0mIrDWcq2Zl3vctf2eFGq683MlFV1hruyc4+fiT5xaAqNf+Q1cE7oeyRSw844w3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR18MB5719
X-Proofpoint-ORIG-GUID: _ZJc7yF9NVCPnSSTWRLYUbzrpXYgQWDo
X-Proofpoint-GUID: _ZJc7yF9NVCPnSSTWRLYUbzrpXYgQWDo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01

SGkgRXJpYywNCg0KPiBPbiBXZWQsIERlYyAxOCwgMjAyNCBhdCA0OjI14oCvUE0gU2hpbmFzIFJh
c2hlZWQgPHNyYXNoZWVkQG1hcnZlbGwuY29tPg0KPiB3cm90ZToNCj4gDQo+ID4gSGkgRXJpYywN
Cj4gPg0KPiA+IFRoaXMgcGF0Y2ggaXMgbm90IGEgd29ya2Fyb3VuZC4gSW4gc29tZSBzZXR1cHMs
IHdlIHdlcmUgc2VlaW5nIHJhY2VzIHdpdGgNCj4gcmVnYXJkcw0KPiA+IHRvIHJlc291cmNlIGZy
ZWVpbmcgYmV0d2VlbiBuZG9fc3RvcCgpIGFuZCBuZG9fZ2V0X3N0YXRzKCkuIEhlbmNlIHRvIHN5
bmMNCj4gd2l0aCB0aGUgdmlldyBvZg0KPiA+IHJlc291cmNlcywgYSBzeW5jaHJvbml6ZV9uZXQo
KSBpcyBjYWxsZWQgaW4gbmRvX3N0b3AoKS4gUGxlYXNlIGxldCBtZSBrbm93IGlmDQo+IHlvdSBz
ZWUgYW55dGhpbmcgd3JvbmcgaGVyZS4NCj4gDQo+IFdlIGRvIG5vdCBhZGQgYSBzeW5jaHJvbml6
ZV9uZXQoKSB3aXRob3V0IGEgdmVyeSBzdHJvbmcgZXhwbGFuYXRpb24NCj4gKGRldGFpbHMsIG5v
dCBhIHdlYWsgc2VudGVuY2UgaW4gdGhlIGNoYW5nZWxvZykuDQo+IA0KPiBXaGVyZSBpcyB0aGUg
b3Bwb3NpdGUgYmFycmllciBpbiB5b3VyIHBhdGNoID8NCj4gDQo+IEkgYW0gc2F5aW5nIHlvdSBk
byBub3QgbmVlZCB0aGlzLCB1bmxlc3MgeW91IGNhbiBzaG93IGV2aWRlbmNlLg0KPiANCj4gSWYg
eW91ciBuZG9fZ2V0X3N0YXRzKCkgbmVlZHMgdG8gY2FsbCBuZXRpZl9ydW5uaW5nKCksIHRoaXMg
d291bGQgYmUNCj4gdGhlIGZpeCBJTU8uDQoNClRoZSBzeW5jaHJvbml6ZV9uZXQoKSBpcyBzdXBw
b3NlZCB0byBzeW5jIGFsbCBwcmV2aW91cyBjYWxscyBvZiBuZG9fZ2V0X3N0YXRzKCkgYW5kIHdh
aXQgZm9yIHRoZWlyIGNvbXBsZXRpb24gYmVmb3JlIGNsb3NpbmcgdGhlIGRldmljZS4NCkFnYWlu
IHRoaXMgc2VlbXMgdG8gYmUgdGhlIHYyIG9mIHRoaXMgcGF0Y2guIEluIHRoZSB2MywgSSBoYXZl
IHByb3ZpZGVkIHRoZSB3YXJuIGxvZyBhcyB3ZWxsIGluIHRoZSBjb21taXQgbWVzc2FnZSBmb3Ig
cmVmZXJlbmNlLCBpbiBhbnN3ZXIgdG8NCnRoZSBjaGFuZ2Vsb2cgY29tbWVudCBmb3IgbW9yZSBj
bGFyaWZpY2F0aW9uLg0KDQpBcyBJIHN0YXRlZCwgdGhpcyBpcyBuZWVkZWQgYmVjYXVzZSBuZG9f
c3RvcCgpIHJhY2VzIHdpdGggbmRvX2dldF9zdGF0cygpLCBhbmQgYSAnbG9jaycgb3IgYSBzaW1p
bGFyIG1lY2hhbmlzbSBzZWVtcyByZXF1aXJlZCB0byBhbGxldmlhdGUgdGhpcy4NCkZpeGVzIGlu
IHRoZSBzYW1lIHZlaW4gc2VlbSB0byBiZSBjb21tb24sIGFzIEkgZG8gc2VlIG90aGVyIGRyaXZl
cnMgdXRpbGl6aW5nIGEgbG9jayBtZWNoYW5pc20gd2hpbGUgcmV0cmlldmluZyBzdGF0aXN0aWNz
IHRvIHJlc29sdmUgdGhlIHNhbWUgDQooaWU7IHJhY2Ugd2l0aCByZXNvdXJjZSBkZXN0cnVjdGlv
biBpbiBuZG9fc3RvcCgpKS4gU28sIGp1c3QgdG8gc3RhdGUsIEknbSBub3QgdHJ5aW5nIHRvIGRv
IGFueXRoaW5nIG5ldw0KaGVyZS4NCg0KQ2FuIHdlIHBsZWFzZSBjb21tZW50IGZ1cnRoZXIgb24g
dGhlIHYzIG9mIHRoaXMgcGF0Y2g/IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2FsbC8yMDI0MTIx
ODExNTExMS4yNDA3OTU4LTEtc3Jhc2hlZWRAbWFydmVsbC5jb20vDQoNClRoYW5rcyBhIGxvdCBm
b3IgeW91ciB0aW1lIGFuZCBjb21tZW50cw0K

