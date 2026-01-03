Return-Path: <netdev+bounces-246637-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 14888CEF9F4
	for <lists+netdev@lfdr.de>; Sat, 03 Jan 2026 02:26:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C11E1301FF7F
	for <lists+netdev@lfdr.de>; Sat,  3 Jan 2026 01:26:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E9EE23D7EC;
	Sat,  3 Jan 2026 01:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="DQsR16jG"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 462EA21D599;
	Sat,  3 Jan 2026 01:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.156.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767403573; cv=fail; b=U0GFW4WcfW74Ru3S1JVm7cG708obLYPCXH6To5ghXmoXDuP3XRud7q1ozx0wQjrPsNPGNsFwR855BY/0K91a55Z4RSsP5SHS793GeJbFMt6FybcpfdDyybL/53eVvaYGiamT2+AR1E15O4CVYfYx50LuyzLnLeRHyBCzDY6TQnQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767403573; c=relaxed/simple;
	bh=Q7G4dc9vj/XrWv4elQLoO2Xx2fnsN3X+b1gdr4cpGNI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=oSmYNO5+dszhWypuCnoTIrxQN1n1ECfO4vuBiOZgWD0ZxDRQumOZmV8AmB6p9US1OkG2LiY/1T7OjzyWl/MDgp6UQCXctu6o2ZYdolDCCWoQjbzM5Du6llUwlQ2xWPxbUSRMxzTcPaIkXpT1CuBBycDJfH4ZjKAu1tduWfaFTpU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=DQsR16jG; arc=fail smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6031IuKS1848056;
	Fri, 2 Jan 2026 17:25:54 -0800
Received: from mw6pr02cu001.outbound.protection.outlook.com (mail-westus2azon11022109.outbound.protection.outlook.com [52.101.48.109])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4be89ahe4j-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 02 Jan 2026 17:25:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ydtVldziP//GoUow21lPtf47VACKVPf+sjpu122uVrfi1LZqtFDp7o1G9x7baNK4dsEtb6Eo409YT2DQ/1vPn8ItrMnYVgS/yQ9K4iGFKC7+cj+X3X4UuVg59XacALZiyp2MMCqfVqk594qSKA72KLUD14+1TVHZIDZQiUYYn4LtJQGIMqi9XGei5w901mZD2KryJz+4bIcB+9ANUChJogMmosO0TX9MwZ8xp+MY/JezC/jQgozAvGoEquzVTKuBvg38RoZhVufa9BZatvFcNRE6iFiOFGIDi/kgiK6J7mQd7iDlWCeP6xLt+lXVkHWpwWi/wm0CH6xOOTwcuDFgHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q7G4dc9vj/XrWv4elQLoO2Xx2fnsN3X+b1gdr4cpGNI=;
 b=cXR81YMCqoxbqbi1UpLwDhTYjD+sjp0vD3Xw3cfy8fuLMeMB2U7xOX18fNHbvBoBxKSznqf/8nampQDdeJ1nKkySJhE+O6CAl/mCqzyX2AQj7R2gNUDw4SJs3SXXyYkM7u8WUxkQcHbuEjM8l18QQ6HzHNarzIEEfhJfE5GuxfLyszUVTAcAYnkYXsdi+gkoaNrsKLppL7l79RGS6mARI6pD3jP3U+9qMMkwatSm9S/F8viE/8H8SSoYd128hTHMqtidXiAHZ0XrEF0punfW10aF09S9MGQKC6uBt1xZwuNPMDV3J8FxzmADSaoaZvgpXJ2yLaAnTDA8Fxz4fNB/9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q7G4dc9vj/XrWv4elQLoO2Xx2fnsN3X+b1gdr4cpGNI=;
 b=DQsR16jGpLDG1uf2GIfcdZ6urRPMOqD2SMOF6CFvpNmGxy01i/gtQ0j581JrEGK0ydDp0mZ3eCxgS0AYGM76pnafws7ctw3SD2m3jnt64NXYbvVaJ4RJg+m8+Lsea6ffeb6QTnInM9LCAqXeqeYhq6CUBpE3hoDm4H7MWbONO20=
Received: from DM4PR18MB4269.namprd18.prod.outlook.com (2603:10b6:5:394::18)
 by SN7PR18MB3998.namprd18.prod.outlook.com (2603:10b6:806:f6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Sat, 3 Jan
 2026 01:25:51 +0000
Received: from DM4PR18MB4269.namprd18.prod.outlook.com
 ([fe80::9796:166:30d:454a]) by DM4PR18MB4269.namprd18.prod.outlook.com
 ([fe80::9796:166:30d:454a%6]) with mapi id 15.20.9478.004; Sat, 3 Jan 2026
 01:25:50 +0000
From: Shiva Shankar Kommula <kshankar@marvell.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "jasowang@redhat.com"
	<jasowang@redhat.com>,
        "xuanzhuo@linux.alibaba.com"
	<xuanzhuo@linux.alibaba.com>,
        "eperezma@redhat.com" <eperezma@redhat.com>,
        "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
        "davem@davemloft.net"
	<davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "virtualization@lists.linux.dev" <virtualization@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jerin Jacob
	<jerinj@marvell.com>,
        Nithin Kumar Dabilpuram <ndabilpuram@marvell.com>,
        Srujana Challa <schalla@marvell.com>
Subject: RE: [EXTERNAL] Re: [PATCH net] virtio_net: fix device mismatch in
 devm_kzalloc/devm_kfree
Thread-Topic: [EXTERNAL] Re: [PATCH net] virtio_net: fix device mismatch in
 devm_kzalloc/devm_kfree
Thread-Index: AQHce9rgpsIvt6q0nUSRXKXOqZrbI7U/p0IA
Date: Sat, 3 Jan 2026 01:25:50 +0000
Message-ID:
 <DM4PR18MB42697C299DC7372D83476259DFB8A@DM4PR18MB4269.namprd18.prod.outlook.com>
References: <20260102101900.692770-1-kshankar@marvell.com>
 <20260102062457-mutt-send-email-mst@kernel.org>
In-Reply-To: <20260102062457-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR18MB4269:EE_|SN7PR18MB3998:EE_
x-ms-office365-filtering-correlation-id: 37c0e247-ae34-48a2-954c-08de4a6707e8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?Vy9QdlpHbURSZDFpUFBhNmVUVWZGN0RjWGdvZ2pRUXFTWVZpdXExR0QvNzVP?=
 =?utf-8?B?cWRna0RLSnhsN1dIbldvZ2x2VnViV1I1RXR2aFpRN0JQcTRIWXhnQ2tCRzc0?=
 =?utf-8?B?YVA1bUNXcHJKUWxHVkl3K0pDNXB2TTJaM0cweHVoeXdSallXaWJTclYyQWlq?=
 =?utf-8?B?RVdqTzE2K3NhamZRVUV1TCt2d001SnBnOHRMdDNISGEvK2RKYi9haGNwUEV1?=
 =?utf-8?B?dzRjVm5RYUxWek9pQk56Um1LYzFydHdxcDVmdnRYSXlJUFhHQzQzbVJuTjhN?=
 =?utf-8?B?MEZvemxzUXc0YVJnYjcxakRBdWlwVDFxNGF6OC9JU0RPWW9JUk05RE9WWEpo?=
 =?utf-8?B?OTFxbmpWN0U1MWJYU3JSUjhvT2NRUFl6anJmdHNzbjRtMXR5RTFKVUhHRzV5?=
 =?utf-8?B?TW1NT2MraEdoa0hOTStBK1hWamwrTGxicVoyYXBQRndQdWtlSnZ1Wlp1b0F4?=
 =?utf-8?B?TFl5WHBhbjUyMEVZQjlGMWo3UGc1ckZLenJZT1VBOVp4SFBYYUtyWGlyTDk2?=
 =?utf-8?B?bGwvdVlNWmtSYWRMa2dWSjJJNjNoRjFJUHZlNkdsWlNQdVg4SXE1Wm1XSW5a?=
 =?utf-8?B?bUJQbkdPK01GNEZYUW1QM24xMDNXNlVCUWJTSGlXVWtvMGw4ZWY0c01haFVh?=
 =?utf-8?B?amlrVVo5M2JlVmphZW5CelJxUHdzM3pTZW9ySHpQMFFwMGU2K2JYcnVQMDhT?=
 =?utf-8?B?Q3FQbTZ5OEp1K0MrWGtZU3lpenZJQUdFZ2ptNU1hTWpJN1dyOFZhazd3RUFm?=
 =?utf-8?B?cStMYmt4TkozUzBtSTVXT1hNek9zcUgzN2k3WElDVG9FQjE1OHBlV3IyanNG?=
 =?utf-8?B?NDdDVTVqN0QyWGRZdWltZmlaMUJZZWRoVWtxWWdkNnRpS1hlTU5CN3I4SW5m?=
 =?utf-8?B?V3o1dU5hRGZFYTF0K1o2VVluM1A3ODZ5UzZzemZ5ZkcxYlNFYnF2YjJsMDY4?=
 =?utf-8?B?anE2NnEzQ0FRMFpLWkZvZFhkZUI3cVI5cVBSRHRLV0phMVdrM05ScERia1pm?=
 =?utf-8?B?RGYvdE1CVzN1dmNIaGZXRmtJbHhTTllwTGNYbDU0NDJzaXpyN0tZT2lPd0Vm?=
 =?utf-8?B?L3gyaGFQdlkzVzVJOFZYL3ZSbWZ0VTNkaTcvV0lBSUF1S1MvR2hTZEV6TXpQ?=
 =?utf-8?B?VE5jMnE0V3JmRkNnTnYxSDVFYlhvSVJmbFFuUlNCNEtqQlZSKytxdU8vS2JQ?=
 =?utf-8?B?Rmt4UnZIbWI0bldWN1l0L0dFOWI5OFFTUnI4WS9tTjc1Zi91VWdUcldDaWwy?=
 =?utf-8?B?bERtaDY5d3lVOFE4NkVMaXJYZ05xMlljRUJJbkV0ZzhDb1RBOFVWYjVoYzQz?=
 =?utf-8?B?Z2FteDVJSUtXMDZ3K1RqR2dXUjFSc0ZwbTF2WjNVY0FRcnEybDF3MlBaa21R?=
 =?utf-8?B?ZTM2eTZVV2ZkWjMwMzRFdi9vRXBpU3EwNVhXZnVGa2k4SmhkTm1xK3UyeEJw?=
 =?utf-8?B?Z0E0ZDd3MW9JMWd6N2RzNkIwRHIwMzJnZVArSnd6dkU5aHVNcVBFejd4a3dU?=
 =?utf-8?B?VlpqUXV0SnFncWpwSzV1RTZCUzlET2h1SzY1bWozOU8rMkFjTFdDc3BwY1cv?=
 =?utf-8?B?eFVlRVhWanRacWFGVUdjWitndVZFSVdEamFkSlR4Wk9MNW9adS9GOFl1QTlQ?=
 =?utf-8?B?bHkvNTZJSnNtZDRqV0VqNmJTYnZZNjMwQmFxRmF1N3ZqTERHMFg5YnJ4aVph?=
 =?utf-8?B?cGhBeW1DRFgycDJnMVpWUFNwVFdhY2EzdjNHbjViM0VMTDRteWF6VTRuMmNX?=
 =?utf-8?B?K0FNYWFIbEhCZFo0c1lDb2VBNXNKeFlNVG1mMXJZS2NPbWlxM3Z5UFl3cnl6?=
 =?utf-8?B?R2pNZ25wa1JVSUVVeVNBSHF0WXc3VVNUZHM2eGNscmlUMEYvaFYwM1VIT0xj?=
 =?utf-8?B?dmdmMFFNcHJaYmV5L2ZCaGszVjh1c2YwWmwxbTYyN1NhRzZ1aE43STJzN3Nt?=
 =?utf-8?B?Z09tS21uaGdwb0pPcUdTd2pDeUkyVmloQlBWeGF5dTBuQmN6Ni9zaWVIS2dH?=
 =?utf-8?B?Y1I5Z3hDQk0vOGw2R2M4RHVvNjdXSFpJdFVaNEJvc3RFN1c3bGFsY2IzU2E1?=
 =?utf-8?Q?cwklDF?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR18MB4269.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bXRwVDJhNXdGc1EybVhmQmlGV1I2azV1NFFMZmZjSFNFbWhOMzFNeFRDbFZ5?=
 =?utf-8?B?MVBUT0NpNXh1LzJCOUpoNkVkOTNxak5BWFhLS3hXa2NlWTdwVjVUTk5wU1Fr?=
 =?utf-8?B?WVZZSnlacWU0a1lmSHBXZmUyanZnQy9BRGxvNlN0K25mdERLVmdaM1RFeVY0?=
 =?utf-8?B?d0R4K0d0RU1KOUQrQTFKMTlWZ1VobkRzQTFNRnNIeElXQUphbGJXRjZybU9L?=
 =?utf-8?B?c1BoZEFtMHJSTDJXWWp5aktJYlFlUERHTmNyc1E0NzZXc2ZZa0dFMGk3bWxv?=
 =?utf-8?B?aEcxcFc1MU4wOFRTWklQMzJKSVFCMmFOcnFZc2lZMmhwYzVwMGkwNzVyT3lm?=
 =?utf-8?B?MmE4UktJR0RzS3N1UHV3d2Y0cGxEb0d2TzJWQXhRVVFuUE00cWR3UGxYTzRq?=
 =?utf-8?B?TmpFaXIzUjB3UnpOVG1naTU2MENkNVdkUi9ZUEdHK2hFTTd3eEQvUFFVTk1q?=
 =?utf-8?B?cVlGeTM1am5MRHB2Q1FkWHdqUDVvUFdiK1dia3NyazEwQ2FMNVhycy85N214?=
 =?utf-8?B?UjhydFBuWWg3Z21ZYURBNUszUzUzLzMvZFZ1YmF5SHpXdVFENDk0bmsrQkY0?=
 =?utf-8?B?dE1nWlJqOGphcm1KOHNQKzZUcTNkdkllZHEyb0FHZTZOcUFETTFEMW5YRU5x?=
 =?utf-8?B?VjRGaXUxbStYSDJaUXVqYXNQajMrUXlCUU5PcStkcWxyaFFpVjdVMmhETDMr?=
 =?utf-8?B?am0yOUdtRzBsSTRWbWNCR1Z5OEJIaTREMzZWNmdZNUdSUTVHY2ZhaUNqeXpX?=
 =?utf-8?B?S3pjSzBlb3l4ZHR0M2U2NlhteVZxNm40WGUvNDFuZy81L1A0R2JuNC9kdUl0?=
 =?utf-8?B?ZHBtemh5MjEzaFNXeStQWk5JbTR4elRUMXpMOHF2K3FMVFNuWEpGMnh6d3Rn?=
 =?utf-8?B?NEl6QmtHZzFpdFVYZXZyRHVlaU8yci82bkYzT3E3NmhvNGdQR2kxRmpPRks1?=
 =?utf-8?B?ekZaQSthczNodGdKMzdqNTR1OG9ISkwzbk9hYlFOMmRSRUZ0Wkdqb1FnelBZ?=
 =?utf-8?B?VFc4ZzVFTmF1UC92Yk9paUhrVlRveDFWOFJ6RnlGS1pIcEczQ1YrS0grc2lL?=
 =?utf-8?B?T1YyakRCcEdnWGkvejh4ODBTRWRSLzY0ZDNzaVpUQVAwWVJXdFRZOTVsaVpi?=
 =?utf-8?B?d29sTzRoelgyQWRTbkFqai8zWkVuZk5sY21acW8rVWNhRzMwV1k2YXpLaS9H?=
 =?utf-8?B?OUJxSnZ2ZUtqQ3dyV0dEbGVUaklyTmNXbkl3QXpBYWJYMmRIM3JlYXBnUXRR?=
 =?utf-8?B?U3hINVdwZjU1bTZWdjlNQW9hbUJsM1pFd3FWSDJPMTEzS0NaN3ZvakpzK1NN?=
 =?utf-8?B?NFBKVW9VR1p0TlpjNzYxQ0VTOElWMnMzUmZSOVhZdGdpWVJzY0FDNlowdVR6?=
 =?utf-8?B?cUZRc2tIYmRPOTBBcmtmSllXSWNnVW1BVzIzNlNxbzRudXRaQ2dhbUsrVzN3?=
 =?utf-8?B?ZzlOaklKeHo2enR6TmhZSGdVU1o3R3JBSWIxSGNxaTNMSWhUZ1RtbTRQVmFT?=
 =?utf-8?B?QmhSb1crVHowcnB5TWZ5c3FpOWJyQ0QwWFh0SldaZEcrMEMybjVzQ3VJOU8x?=
 =?utf-8?B?REJrcjBhbytPYS9LOVpRRmFVUmZFYzlXSDdka0NEdHJ5Z1A3L2NCUlkxVVo1?=
 =?utf-8?B?K2xjNmpVRk1VdE9UenNLcTJtSy9tUEs0M0VwTnRXakdST2hGc2pwMG1EeVJa?=
 =?utf-8?B?ZVM0NmptUDBrNm0rS256Nk5uUE9MM3BLR1V4SnkwdzloUHhaR3RCZk4rWkQz?=
 =?utf-8?B?Y0tyUzROYnVVUDNpdWdrckVJdEpaUkwwT0pqbEpQYlJRWnBwNm5sZUVUbmV3?=
 =?utf-8?B?OFlaUUo3bmU3b3QwSGt0ckFkbmpxeDBWeGJGcjRFcGRmSkVrRFFKNitORFc2?=
 =?utf-8?B?RVBFZXFjdmJYY3A2UjJvVHJ6QVlpdU5ZU0lKb2xiUk9WczhxQXBKWUhNZ0cr?=
 =?utf-8?B?ZUJsTlhpUHh3dTBmZlVXTG5heHF3UmF4RVRad0xNTFVnVlRxY0VqejIxdS9N?=
 =?utf-8?B?amdEZ1dxY2JGdFA0bjk5Z1IzRm0rcTdtWDZaR3BRKytQd2g5Y1p2dnBsRlBF?=
 =?utf-8?B?S1k2QUJYOVZwVDZ4R1VVTVJKU0FNWUFDQ3A0bTFvVTFMcGxoN2lKSHFDNS9E?=
 =?utf-8?B?Nm91UXpqRDJYVlhCa3hGTzRodDMybU16d0VnRXlyWCsyRTJyTTlaaUFZNlBw?=
 =?utf-8?B?TE5YRmQwRlU4VW1EcTFTTVhLNDZYMWVtRnhIV0VhOEdvZ3pDbzN5N1ovSnFQ?=
 =?utf-8?B?bXJBdldCZXVPYThjZ3ZYNkt2N2ZPV0pDbG1jZkxNRFRtM1AyeTJXSFB5Tis1?=
 =?utf-8?Q?quOeFs4HPBFvT/QUzA?=
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
X-MS-Exchange-CrossTenant-AuthSource: DM4PR18MB4269.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37c0e247-ae34-48a2-954c-08de4a6707e8
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jan 2026 01:25:50.7878
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8m4TSm8pp1ciP3xRjedYduMcEICHNbUurLxhtnxKUZ5aTrtKUPACMAv/f9nlfOIKWBXUjXk/Yx0UYNkIL5hx4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR18MB3998
X-Proofpoint-GUID: hv-EOJcyfMV7c8xeIWKwXMth9XM0_z-r
X-Proofpoint-ORIG-GUID: hv-EOJcyfMV7c8xeIWKwXMth9XM0_z-r
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTAzMDAxMSBTYWx0ZWRfXyZkoYfYpXWHL
 5YtygXn+XPMH0f17wqhyrCbIduRMFsGBAHlzxPZbTN10lBSu58rzuHlk6G2KUDedXjpvMc7Bghb
 BsmcLE2BNnR3OQxWonCLmmrdml1KTS2ANXZ7x4blmxPAj28d+vQK+fHZqnbVMdrDOp8t4g/dnxQ
 99UTkJi7C/2YS9IeOP9zaY32TrG3DRENJhpI+WiJ+KQvUbF4HoFGPyKVz654wAmZ233AHb99+Ho
 bSQ7dT6E8MMmynQNHMZTUpd0Yqh5PdLg7p7WA2iUfVqMxMZ989jFFkXHikGJESJzdIhdzsqYW6A
 qElwHzMal3zpWxcUZuPI3mYBcTqWv9plXaUBjaOBsbtnjbDtQKQtwTl+kyKQ5UzOdXQq5VCXs0N
 fsCAl9f8bIfcBwdvyFMU9zTeaIjDeqliuGw+K9yiuxAXbiNB7CugeNTJH5u/ZPnzopKBxjO+5kR
 u3DK7zfxfhDlzAcgKXg==
X-Authority-Analysis: v=2.4 cv=ZbcQ98VA c=1 sm=1 tr=0 ts=69587022 cx=c_pps
 a=d6SuDfCU3ZZz3a5uGz2bWA==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=vUbySO9Y5rIA:10 a=-AAbraWEqlQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=20KFwNOVAAAA:8 a=M5GUcnROAAAA:8 a=VwQbUJbxAAAA:8 a=SRrdq9N9AAAA:8
 a=J1Y8HTJGAAAA:8 a=1XWaLZrsAAAA:8 a=RpNjiQI2AAAA:8 a=nOLp-5-4cuHo-82UfpAA:9
 a=QEXdDO2ut3YA:10 a=OBjm3rFKGHvpk9ecZwUJ:22 a=y1Q9-5lHfBjTkpIzbSAN:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-02_04,2025-12-31_01,2025-10-01_01

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTWljaGFlbCBTLiBUc2ly
a2luIDxtc3RAcmVkaGF0LmNvbT4NCj4gU2VudDogRnJpZGF5LCBKYW51YXJ5IDIsIDIwMjYgNDo1
OCBQTQ0KPiBUbzogU2hpdmEgU2hhbmthciBLb21tdWxhIDxrc2hhbmthckBtYXJ2ZWxsLmNvbT4N
Cj4gQ2M6IG5ldGRldkB2Z2VyLmtlcm5lbC5vcmc7IGphc293YW5nQHJlZGhhdC5jb207DQo+IHh1
YW56aHVvQGxpbnV4LmFsaWJhYmEuY29tOyBlcGVyZXptYUByZWRoYXQuY29tOw0KPiBhbmRyZXcr
bmV0ZGV2QGx1bm4uY2g7IGRhdmVtQGRhdmVtbG9mdC5uZXQ7IGVkdW1hemV0QGdvb2dsZS5jb207
DQo+IGt1YmFAa2VybmVsLm9yZzsgcGFiZW5pQHJlZGhhdC5jb207IHZpcnR1YWxpemF0aW9uQGxp
c3RzLmxpbnV4LmRldjsgbGludXgtDQo+IGtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IEplcmluIEph
Y29iIDxqZXJpbmpAbWFydmVsbC5jb20+OyBOaXRoaW4gS3VtYXINCj4gRGFiaWxwdXJhbSA8bmRh
YmlscHVyYW1AbWFydmVsbC5jb20+OyBTcnVqYW5hIENoYWxsYQ0KPiA8c2NoYWxsYUBtYXJ2ZWxs
LmNvbT4NCj4gU3ViamVjdDogW0VYVEVSTkFMXSBSZTogW1BBVENIIG5ldF0gdmlydGlvX25ldDog
Zml4IGRldmljZSBtaXNtYXRjaCBpbg0KPiBkZXZtX2t6YWxsb2MvZGV2bV9rZnJlZQ0KPiANCj4g
T24gRnJpLCBKYW4gMDIsIDIwMjYgYXQgMDM64oCKNDk64oCKMDBQTSArMDUzMCwgS29tbXVsYSBT
aGl2YSBTaGFua2FyIHdyb3RlOiA+DQo+IEluaXRpYWwgcnNzX2hkciBhbGxvY2F0aW9uIHVzZXMg
dmlydGlvX2RldmljZS0+ZGV2aWNlLCA+IGJ1dCB2aXJ0bmV0X3NldF9xdWV1ZXMoKQ0KPiBmcmVl
cyB1c2luZyBuZXRfZGV2aWNlLT5kZXZpY2UuID4gVGhpcyBkZXZpY2UgbWlzbWF0Y2ggY2F1c2lu
ZyBiZWxvdyBkZXZyZXMNCj4gWmpRY21RUllGcGZwdEJhbm5lclN0YXJ0IFByaW9yaXRpemUgc2Vj
dXJpdHkgZm9yIGV4dGVybmFsIGVtYWlsczoNCj4gQ29uZmlybSBzZW5kZXIgYW5kIGNvbnRlbnQg
c2FmZXR5IGJlZm9yZSBjbGlja2luZyBsaW5rcyBvciBvcGVuaW5nDQo+IGF0dGFjaG1lbnRzIDxo
dHRwczovL3VzLXBoaXNoYWxhcm0tDQo+IGV3dC5wcm9vZnBvaW50LmNvbS9FV1QvdjEvQ1JWbVhr
cVchdGMzWjFmOFVZblg2OUUtDQo+IDhlWjNhemp0NUVCX2N6N1NZWFd0MnFWbUJXWnNXaTBLOFJk
cUp6TVo1ekswVnNYUkFUMDl0RHI5dDRnckNDDQo+IGNUemQ1ckZIUXI5TzI3VkJJbyQ+DQo+IFJl
cG9ydCBTdXNwaWNpb3VzDQo+IA0KPiBaalFjbVFSWUZwZnB0QmFubmVyRW5kDQo+IE9uIEZyaSwg
SmFuIDAyLCAyMDI2IGF0IDAzOjQ5OjAwUE0gKzA1MzAsIEtvbW11bGEgU2hpdmEgU2hhbmthciB3
cm90ZToNCj4gPiBJbml0aWFsIHJzc19oZHIgYWxsb2NhdGlvbiB1c2VzIHZpcnRpb19kZXZpY2Ut
PmRldmljZSwgYnV0DQo+ID4gdmlydG5ldF9zZXRfcXVldWVzKCkgZnJlZXMgdXNpbmcgbmV0X2Rl
dmljZS0+ZGV2aWNlLg0KPiA+IFRoaXMgZGV2aWNlIG1pc21hdGNoIGNhdXNpbmcgYmVsb3cgZGV2
cmVzIHdhcm5pbmcNCj4gPg0KPiA+IFsgMzc4OC41MTQwNDFdIC0tLS0tLS0tLS0tLVsgY3V0IGhl
cmUgXS0tLS0tLS0tLS0tLSBbIDM3ODguNTE0MDQ0XQ0KPiA+IFdBUk5JTkc6IGRyaXZlcnMvYmFz
ZS9kZXZyZXMuYzoxMDk1IGF0IGRldm1fa2ZyZWUrMHg4NC8weDk4LCBDUFUjMTY6DQo+ID4gdmRw
YS8xNDYzIFsgMzc4OC41MTQwNTRdIE1vZHVsZXMgbGlua2VkIGluOiBvY3RlcF92ZHBhIHZpcnRp
b19uZXQNCj4gdmlydGlvX3ZkcGEgW2xhc3QgdW5sb2FkZWQ6IHZpcnRpb192ZHBhXQ0KPiA+IFsg
Mzc4OC41MTQwNjRdIENQVTogMTYgVUlEOiAwIFBJRDogMTQ2MyBDb21tOiB2ZHBhIFRhaW50ZWQ6
IEcgICAgICAgIFcNCj4gNi4xOC4wICMxMCBQUkVFTVBUDQo+ID4gWyAzNzg4LjUxNDA2N10gVGFp
bnRlZDogW1ddPVdBUk4NCj4gPiBbIDM3ODguNTE0MDY5XSBIYXJkd2FyZSBuYW1lOiBNYXJ2ZWxs
IENOMTA2WFggYm9hcmQgKERUKSBbDQo+ID4gMzc4OC41MTQwNzFdIHBzdGF0ZTogNjM0MDAwMDkg
KG5aQ3YgZGFpZiArUEFOIC1VQU8gK1RDTyArRElUIC1TU0JTDQo+ID4gQlRZUEU9LS0pIFsgMzc4
OC41MTQwNzRdIHBjIDogZGV2bV9rZnJlZSsweDg0LzB4OTggWyAzNzg4LjUxNDA3Nl0gbHIgOg0K
PiA+IGRldm1fa2ZyZWUrMHg1NC8weDk4IFsgMzc4OC41MTQwNzldIHNwIDogZmZmZjgwMDA4NGUy
ZjIyMCBbDQo+ID4gMzc4OC41MTQwODBdIHgyOTogZmZmZjgwMDA4NGUyZjIyMCB4Mjg6IGZmZmYw
MDAzYjIzNjYwMDAgeDI3Og0KPiA+IDAwMDAwMDAwMDAwMDAwM2YgWyAzNzg4LjUxNDA4NV0geDI2
OiAwMDAwMDAwMDAwMDAwMDNmIHgyNToNCj4gPiBmZmZmMDAwMTA2ZjE3YzEwIHgyNDogMDAwMDAw
MDAwMDAwMDA4MCBbIDM3ODguNTE0MDg5XSB4MjM6DQo+ID4gZmZmZjAwMDQ1YmI4YWIwOCB4MjI6
IGZmZmYwMDA0NWJiOGEwMDAgeDIxOiAwMDAwMDAwMDAwMDAwMDE4IFsNCj4gPiAzNzg4LjUxNDA5
M10geDIwOiBmZmZmMDAwNDM1NWMzMDgwIHgxOTogZmZmZjAwMDQ1YmI4YWEwMCB4MTg6DQo+ID4g
MDAwMDAwMDAwMDA4MDAwMCBbIDM3ODguNTE0MDk4XSB4MTc6IDAwMDAwMDAwMDAwMDAwNDAgeDE2
Og0KPiA+IDAwMDAwMDAwMDAwMDAwMWYgeDE1OiAwMDAwMDAwMDAwMDdmZmZmIFsgMzc4OC41MTQx
MDJdIHgxNDoNCj4gPiAwMDAwMDAwMDAwMDAwNDg4IHgxMzogMDAwMDAwMDAwMDAwMDAwNSB4MTI6
IDAwMDAwMDAwMDAwZmZmZmYgWw0KPiA+IDM3ODguNTE0MTA2XSB4MTE6IGZmZmZmZmZmZmZmZmZm
ZmYgeDEwOiAwMDAwMDAwMDAwMDAwMDA1IHg5IDoNCj4gPiBmZmZmODAwMDgwYzhjMDVjIFsgMzc4
OC41MTQxMTBdIHg4IDogZmZmZjgwMDA4NGUyZWViOCB4NyA6DQo+ID4gMDAwMDAwMDAwMDAwMDAw
MCB4NiA6IDAwMDAwMDAwMDAwMDAwM2YgWyAzNzg4LjUxNDExNV0geDUgOg0KPiBmZmZmODAwMDgz
MWJhZmUwIHg0IDogZmZmZjgwMDA4MGM4YjAxMCB4MyA6IGZmZmYwMDA0MzU1YzMwODAgWw0KPiAz
Nzg4LjUxNDExOV0geDIgOiBmZmZmMDAwNDM1NWMzMDgwIHgxIDogMDAwMDAwMDAwMDAwMDAwMCB4
MCA6DQo+IDAwMDAwMDAwMDAwMDAwMDAgWyAzNzg4LjUxNDEyM10gQ2FsbCB0cmFjZToNCj4gPiBb
IDM3ODguNTE0MTI1XSAgZGV2bV9rZnJlZSsweDg0LzB4OTggKFApIFsgMzc4OC41MTQxMjldDQo+
ID4gdmlydG5ldF9zZXRfcXVldWVzKzB4MTM0LzB4MmU4IFt2aXJ0aW9fbmV0XSBbIDM3ODguNTE0
MTM1XQ0KPiA+IHZpcnRuZXRfcHJvYmUrMHg5YzAvMHhlMDAgW3ZpcnRpb19uZXRdIFsgMzc4OC41
MTQxMzldDQo+ID4gdmlydGlvX2Rldl9wcm9iZSsweDFlMC8weDMzOCBbIDM3ODguNTE0MTQ0XSAg
cmVhbGx5X3Byb2JlKzB4YzgvMHgzYTAgWw0KPiA+IDM3ODguNTE0MTQ5XSAgX19kcml2ZXJfcHJv
YmVfZGV2aWNlKzB4ODQvMHgxNzAgWyAzNzg4LjUxNDE1Ml0NCj4gPiBkcml2ZXJfcHJvYmVfZGV2
aWNlKzB4NDQvMHgxMjAgWyAzNzg4LjUxNDE1NV0NCj4gPiBfX2RldmljZV9hdHRhY2hfZHJpdmVy
KzB4YzQvMHgxNjggWyAzNzg4LjUxNDE1OF0NCj4gPiBidXNfZm9yX2VhY2hfZHJ2KzB4OGMvMHhm
MCBbIDM3ODguNTE0MTYxXSAgX19kZXZpY2VfYXR0YWNoKzB4YTQvMHgxYzANCj4gPiBbIDM3ODgu
NTE0MTY0XSAgZGV2aWNlX2luaXRpYWxfcHJvYmUrMHgxYy8weDMwIFsgMzc4OC41MTQxNjhdDQo+
ID4gYnVzX3Byb2JlX2RldmljZSsweGI0LzB4YzAgWyAzNzg4LjUxNDE3MF0gIGRldmljZV9hZGQr
MHg2MTQvMHg4MjggWw0KPiA+IDM3ODguNTE0MTczXSAgcmVnaXN0ZXJfdmlydGlvX2RldmljZSsw
eDIxNC8weDI1OA0KPiA+IFsgMzc4OC41MTQxNzVdICB2aXJ0aW9fdmRwYV9wcm9iZSsweGEwLzB4
MTEwIFt2aXJ0aW9fdmRwYV0gWw0KPiA+IDM3ODguNTE0MTc5XSAgdmRwYV9kZXZfcHJvYmUrMHhh
OC8weGQ4IFsgMzc4OC41MTQxODNdDQo+ID4gcmVhbGx5X3Byb2JlKzB4YzgvMHgzYTAgWyAzNzg4
LjUxNDE4Nl0NCj4gPiBfX2RyaXZlcl9wcm9iZV9kZXZpY2UrMHg4NC8weDE3MCBbIDM3ODguNTE0
MTg5XQ0KPiA+IGRyaXZlcl9wcm9iZV9kZXZpY2UrMHg0NC8weDEyMCBbIDM3ODguNTE0MTkyXQ0K
PiA+IF9fZGV2aWNlX2F0dGFjaF9kcml2ZXIrMHhjNC8weDE2OCBbIDM3ODguNTE0MTk1XQ0KPiA+
IGJ1c19mb3JfZWFjaF9kcnYrMHg4Yy8weGYwIFsgMzc4OC41MTQxOTddICBfX2RldmljZV9hdHRh
Y2grMHhhNC8weDFjMA0KPiA+IFsgMzc4OC41MTQyMDBdICBkZXZpY2VfaW5pdGlhbF9wcm9iZSsw
eDFjLzB4MzAgWyAzNzg4LjUxNDIwM10NCj4gPiBidXNfcHJvYmVfZGV2aWNlKzB4YjQvMHhjMCBb
IDM3ODguNTE0MjA2XSAgZGV2aWNlX2FkZCsweDYxNC8weDgyOCBbDQo+ID4gMzc4OC41MTQyMDld
ICBfdmRwYV9yZWdpc3Rlcl9kZXZpY2UrMHg1OC8weDg4IFsgMzc4OC41MTQyMTFdDQo+ID4gb2N0
ZXBfdmRwYV9kZXZfYWRkKzB4MTA0LzB4MjI4IFtvY3RlcF92ZHBhXSBbIDM3ODguNTE0MjE1XQ0K
PiA+IHZkcGFfbmxfY21kX2Rldl9hZGRfc2V0X2RvaXQrMHgyZDAvMHgzYzANCj4gPiBbIDM3ODgu
NTE0MjE4XSAgZ2VubF9mYW1pbHlfcmN2X21zZ19kb2l0KzB4ZTQvMHgxNTgNCj4gPiBbIDM3ODgu
NTE0MjIyXSAgZ2VubF9yY3ZfbXNnKzB4MjE4LzB4Mjk4IFsgMzc4OC41MTQyMjVdDQo+ID4gbmV0
bGlua19yY3Zfc2tiKzB4NjQvMHgxMzggWyAzNzg4LjUxNDIyOV0gIGdlbmxfcmN2KzB4NDAvMHg2
MCBbDQo+ID4gMzc4OC41MTQyMzNdICBuZXRsaW5rX3VuaWNhc3QrMHgzMmMvMHgzYjAgWyAzNzg4
LjUxNDIzN10NCj4gPiBuZXRsaW5rX3NlbmRtc2crMHgxNzAvMHgzYjggWyAzNzg4LjUxNDI0MV0N
Cj4gX19zeXNfc2VuZHRvKzB4MTJjLzB4MWMwIFsNCj4gPiAzNzg4LjUxNDI0Nl0gIF9fYXJtNjRf
c3lzX3NlbmR0bysweDMwLzB4NDggWyAzNzg4LjUxNDI0OV0NCj4gPiBpbnZva2Vfc3lzY2FsbC5j
b25zdHByb3AuMCsweDU4LzB4ZjgNCj4gPiBbIDM3ODguNTE0MjU1XSAgZG9fZWwwX3N2YysweDQ4
LzB4ZDANCj4gPiBbIDM3ODguNTE0MjU5XSAgZWwwX3N2YysweDQ4LzB4MjEwDQo+ID4gWyAzNzg4
LjUxNDI2NF0gIGVsMHRfNjRfc3luY19oYW5kbGVyKzB4YTAvMHhlOCBbIDM3ODguNTE0MjY4XQ0K
PiA+IGVsMHRfNjRfc3luYysweDE5OC8weDFhMCBbIDM3ODguNTE0MjcxXSAtLS1bIGVuZCB0cmFj
ZQ0KPiA+IDAwMDAwMDAwMDAwMDAwMDAgXS0tLQ0KPiA+DQo+ID4gRml4IGJ5IHVzaW5nIHZpcnRp
b19kZXZpY2UtPmRldmljZSBjb25zaXN0ZW50bHkgZm9yIGFsbG9jYXRpb24gYW5kDQo+ID4gZGVh
bGxvY2F0aW9uDQo+ID4NCj4gPiBGaXhlczogNDk0NGJlMmY1YWQ4YyAoInZpcnRpb19uZXQ6IEFs
bG9jYXRlIHJzc19oZHIgd2l0aCBkZXZyZXMiKQ0KPiA+IFNpZ25lZC1vZmYtYnk6IEtvbW11bGEg
U2hpdmEgU2hhbmthciA8a3NoYW5rYXJAbWFydmVsbC5jb20+DQo+IA0KPiBBbmQgbm90IGp1c3Qg
YSB3YXJuaW5nLCBpdCBjYW4gYmUgYSBtZW1sZWFrL2RvdWJsZSBmcmVlLCByaWdodD8NCkFncmVl
ZC4gTWVtb3J5IGxlYWsgb2NjdXJzIGluIHRoaXMgc2NlbmFyaW8uIA0KPiANCj4gQWNrZWQtYnk6
IE1pY2hhZWwgUy4gVHNpcmtpbiA8bXN0QHJlZGhhdC5jb20+DQo+IA0KPiA+IC0tLQ0KPiA+ICBk
cml2ZXJzL25ldC92aXJ0aW9fbmV0LmMgfCA2ICsrKy0tLQ0KPiA+ICAxIGZpbGUgY2hhbmdlZCwg
MyBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvbmV0L3ZpcnRpb19uZXQuYyBiL2RyaXZlcnMvbmV0L3ZpcnRpb19uZXQuYyBpbmRleA0K
PiA+IDFiYjNhZWNhNjZjNi4uMjJkODk0MTAxYzAxIDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMv
bmV0L3ZpcnRpb19uZXQuYw0KPiA+ICsrKyBiL2RyaXZlcnMvbmV0L3ZpcnRpb19uZXQuYw0KPiA+
IEBAIC0zNzkxLDcgKzM3OTEsNyBAQCBzdGF0aWMgaW50IHZpcnRuZXRfc2V0X3F1ZXVlcyhzdHJ1
Y3QgdmlydG5ldF9pbmZvDQo+ICp2aSwgdTE2IHF1ZXVlX3BhaXJzKQ0KPiA+ICAJaWYgKHZpLT5o
YXNfcnNzICYmICFuZXRpZl9pc19yeGZoX2NvbmZpZ3VyZWQoZGV2KSkgew0KPiA+ICAJCW9sZF9y
c3NfaGRyID0gdmktPnJzc19oZHI7DQo+ID4gIAkJb2xkX3Jzc190cmFpbGVyID0gdmktPnJzc190
cmFpbGVyOw0KPiA+IC0JCXZpLT5yc3NfaGRyID0gZGV2bV9remFsbG9jKCZkZXYtPmRldiwNCj4g
dmlydG5ldF9yc3NfaGRyX3NpemUodmkpLCBHRlBfS0VSTkVMKTsNCj4gPiArCQl2aS0+cnNzX2hk
ciA9IGRldm1fa3phbGxvYygmdmktPnZkZXYtPmRldiwNCj4gPiArdmlydG5ldF9yc3NfaGRyX3Np
emUodmkpLCBHRlBfS0VSTkVMKTsNCj4gPiAgCQlpZiAoIXZpLT5yc3NfaGRyKSB7DQo+ID4gIAkJ
CXZpLT5yc3NfaGRyID0gb2xkX3Jzc19oZHI7DQo+ID4gIAkJCXJldHVybiAtRU5PTUVNOw0KPiA+
IEBAIC0zODAyLDcgKzM4MDIsNyBAQCBzdGF0aWMgaW50IHZpcnRuZXRfc2V0X3F1ZXVlcyhzdHJ1
Y3QNCj4gPiB2aXJ0bmV0X2luZm8gKnZpLCB1MTYgcXVldWVfcGFpcnMpDQo+ID4NCj4gPiAgCQlp
ZiAoIXZpcnRuZXRfY29tbWl0X3Jzc19jb21tYW5kKHZpKSkgew0KPiA+ICAJCQkvKiByZXN0b3Jl
IGN0cmxfcnNzIGlmIGNvbW1pdF9yc3NfY29tbWFuZCBmYWlsZWQgKi8NCj4gPiAtCQkJZGV2bV9r
ZnJlZSgmZGV2LT5kZXYsIHZpLT5yc3NfaGRyKTsNCj4gPiArCQkJZGV2bV9rZnJlZSgmdmktPnZk
ZXYtPmRldiwgdmktPnJzc19oZHIpOw0KPiA+ICAJCQl2aS0+cnNzX2hkciA9IG9sZF9yc3NfaGRy
Ow0KPiA+ICAJCQl2aS0+cnNzX3RyYWlsZXIgPSBvbGRfcnNzX3RyYWlsZXI7DQo+ID4NCj4gPiBA
QCAtMzgxMCw3ICszODEwLDcgQEAgc3RhdGljIGludCB2aXJ0bmV0X3NldF9xdWV1ZXMoc3RydWN0
IHZpcnRuZXRfaW5mbw0KPiAqdmksIHUxNiBxdWV1ZV9wYWlycykNCj4gPiAgCQkJCSBxdWV1ZV9w
YWlycyk7DQo+ID4gIAkJCXJldHVybiAtRUlOVkFMOw0KPiA+ICAJCX0NCj4gPiAtCQlkZXZtX2tm
cmVlKCZkZXYtPmRldiwgb2xkX3Jzc19oZHIpOw0KPiA+ICsJCWRldm1fa2ZyZWUoJnZpLT52ZGV2
LT5kZXYsIG9sZF9yc3NfaGRyKTsNCj4gPiAgCQlnb3RvIHN1Y2M7DQo+ID4gIAl9DQo+ID4NCj4g
PiAtLQ0KPiA+IDIuNDguMQ0KDQo=

