Return-Path: <netdev+bounces-104428-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C2A990C7AB
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 12:50:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D238285C9B
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 10:50:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B1011BE87A;
	Tue, 18 Jun 2024 09:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="s1fH3JhD"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F8E01BE86E;
	Tue, 18 Jun 2024 09:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.148.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718701754; cv=fail; b=qJidsiHzaT1vN0LT2lQwBDm7sFd/b61r95faMgYgLOFb+76XX+8t2NxMb2ktECybo41gz5IuADfpZbJVYkDG86urfkJovnJc/t216u0+MJqN0dq8t1USwG8P4uodKcfyWxPBs1/X5Xd58nFFfj76OejI36D6bVmmewe46JmNk2s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718701754; c=relaxed/simple;
	bh=67k7hYcXDaX458A8c2cDDk+jeKm7+6G2j8iANpas6bw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MLmNx9RrF6Vq1tIGkYnYa8fc6surBL+XRl9UsuM9ys9OJNhb/rCoFMxcYgwx3yMx/bhaeehEF8c3h8Lp874spIC64vsX8pNGvGstEd0xs9N/iHv+8xsXeXvajf0pspIs4Dx+/daIe97jBOT/6I0550LdqBcz4t094BoFl8ubBKk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=s1fH3JhD; arc=fail smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45I1Wlwl015596;
	Tue, 18 Jun 2024 02:08:58 -0700
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3yu0nws5r8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Jun 2024 02:08:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DZzuyBPo1Zbm9Mv64AqFxI0T6cYGtrEqmFJcyAxcCQi4b0UuVUmjYqPnn8RzATctkmoG2OnE/oIq4ZVsR0jUwZPMOtICB7RqheMLYkXwv5RT8GMonU9bKMaQNk55BIfjskzFsRwiEaz4B1hSg7GtTxC4HrW3lIrw334blJZsN8o/1vWrbhOnWbxHk96SEcYnTo5GTQeYVOCRmHcRdJFnBo16HdSgN+lv9bbqyrjuw1I5STMKtY1zBq4XCpc0rkmolBlc50QB1f8Shps2wLr89H0SgBkjpcp8mXVkMZe6ABD3jwztkDU7ytKKLMgN4SpdVb2l0VHCfPIJvV8W00GZ6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=67k7hYcXDaX458A8c2cDDk+jeKm7+6G2j8iANpas6bw=;
 b=O4x7mE3G6Q8Hyqc4tvhdVB6KxTpeGWNswOB25DtJ73SIS1+/haZV4ZWAbcBOJhr3gZCIY1hJtZukRd2XvE/FXuY5WkwWny/kXRzaIQ1ZvIKIKSvV23DNo+9ifhjUkxfuybsCHJ1MS732mrG5ywWWLCplWbonATbdiwuX7SCL++1l06YkncVzP/0sjavDMjav12K9dCV0r0jnSLQeKmijsi/LcXagrakTXyZ3KzGCTzZcxEyW+ui9JMD1R62RpSs7fbdpWwLWDMPLT5tSLCUhehvjsTJzlT/b7TwohfaBqmtnu+SP94rcBfO6s4ik42uZsUjki0bwzl0MiDMHI9GTww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=67k7hYcXDaX458A8c2cDDk+jeKm7+6G2j8iANpas6bw=;
 b=s1fH3JhDMja+nNOKW3YFgLlEE18cJO9fRra3AWZetHw49zGGkQa1e6sv9vKc19EwHbwTHTljrQ1NWrC4Wi1ma6xMkyWaTrlYKf+lwx6GmmSg2mqIO1/vUwSxazLaw6karjqy1PrzSbbpSHVXIGmptZxrwGVb2M1dQ8kcN5dKwII=
Received: from CH0PR18MB4339.namprd18.prod.outlook.com (2603:10b6:610:d2::17)
 by CO6PR18MB4435.namprd18.prod.outlook.com (2603:10b6:5:355::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.18; Tue, 18 Jun
 2024 09:08:56 +0000
Received: from CH0PR18MB4339.namprd18.prod.outlook.com
 ([fe80::61a0:b58d:907c:16af]) by CH0PR18MB4339.namprd18.prod.outlook.com
 ([fe80::61a0:b58d:907c:16af%5]) with mapi id 15.20.7698.017; Tue, 18 Jun 2024
 09:08:56 +0000
From: Geethasowjanya Akula <gakula@marvell.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "pabeni@redhat.com"
	<pabeni@redhat.com>,
        "edumazet@google.com" <edumazet@google.com>,
        Sunil
 Kovvuri Goutham <sgoutham@marvell.com>,
        Subbaraya Sundeep Bhatta
	<sbhatta@marvell.com>,
        Hariprasad Kelam <hkelam@marvell.com>
Subject: RE: [EXTERNAL] Re: [net-next PATCH v5 02/10] octeontx2-pf: RVU
 representor driver
Thread-Topic: [EXTERNAL] Re: [net-next PATCH v5 02/10] octeontx2-pf: RVU
 representor driver
Thread-Index: AQHavBuNJ9JlozPAg02gBOC4U58P87HGhX8AgAa/hQA=
Date: Tue, 18 Jun 2024 09:08:56 +0000
Message-ID: 
 <CH0PR18MB43394E01E757C18D1F57A134CDCE2@CH0PR18MB4339.namprd18.prod.outlook.com>
References: <20240611162213.22213-1-gakula@marvell.com>
	<20240611162213.22213-3-gakula@marvell.com>
 <20240613190206.77280642@kernel.org>
In-Reply-To: <20240613190206.77280642@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR18MB4339:EE_|CO6PR18MB4435:EE_
x-ms-office365-filtering-correlation-id: f86c52ee-6e42-4c32-215d-08dc8f76486c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230037|1800799021|376011|366013|38070700015;
x-microsoft-antispam-message-info: 
 =?utf-8?B?T1Era01NSjJxWnZNbWJGY3pTZEd1Si9zQ1kyY3c3V3R1RnBYN2s5eGFDQm1S?=
 =?utf-8?B?SjBhWmNMVUFyTkxOSmVqVGFZTmtwMFhsdDBjd0l0U3lTbkQ1RUlDVlEza3Zt?=
 =?utf-8?B?SlZJcHU2VnR2WmR2Zng1SVVSSWpLYVZ0dVY2blV4T1RQWEtRanl6Q0Q5c0ZZ?=
 =?utf-8?B?a244ZlN1UWliM05ucFoyTUN6SnFDOHJ5Zml0OENPVm1JYmRmTnU0eklSclBI?=
 =?utf-8?B?UysrVGZVcVE1eWwzNHdkeEZ5Mm1vZGZDaDd2MGRzK1A4dElCYnRoeEtFZ0VH?=
 =?utf-8?B?OFVRN3ppZCtYOEppWkQrb2ZlL1FySSswd1FBbThpU1R0WUF6dTlZS0FGU1lE?=
 =?utf-8?B?WGc2SjRSVUlSVjZpQloveENmS25yRDZWTlFSQlRzWXF1VzBOQkdEWEJYaTdo?=
 =?utf-8?B?RFJVUzhCY2ZRU1NTR29TWktha05RK1RBclh2dk4zUVdhU0Zla0ZoQ3p5S3Vu?=
 =?utf-8?B?TDZCUHR1T2xLNU8xRGRsaEtoWlBtYkEvVDFRQk1MRTJJaXF1Y0hwWjRpajV6?=
 =?utf-8?B?d2JpOUdxVTNkd3prcktqREtycm84Y1hVd2JLN1Fac3YrSGptUzA1d1hGakxU?=
 =?utf-8?B?QlR5bE1OaWpycERqUWY2UXM5TkdVRlNnUjVmMGpSWFZxYm5rYXcxZHNGTlI0?=
 =?utf-8?B?WUZ0NVJkQXI5aW9JaWswN29abjlBellPemN1cGtFNzNhZTVvK1UybXJYMWN1?=
 =?utf-8?B?bU1LeW80N09ramlPQ2hYUGdqOWI3SUJ0Nk5IM2dDODdSUjNiRUlCTW9zVmZw?=
 =?utf-8?B?OW9NVjJCYWFqRTVib0VvWXVXOGR5RnB4eDFGdmYwVTVtcjRxQ205cjExZnl4?=
 =?utf-8?B?NUZUL1BTSHNza21JTGl0L21oald0b2pKYXFyVUZZR3lNcW9FVVl5YSs4RmJT?=
 =?utf-8?B?RUp6VnN6alAzYUtQODVwOW82ZUsrL2lSRUNoNTVrSFp6cW0rMm11SkVtVWgw?=
 =?utf-8?B?ZlExbE1LdUsrOUMrdFMxOExvOGREa2dKUGhqdXVrMHhab0QzeHZkajhHeThj?=
 =?utf-8?B?S0t6dXZ5ZmlrRVRtazdCTGlqbzNVZjNPcmIvandkelphdjBHZjJQVDEyUUU1?=
 =?utf-8?B?ZnJybXJ4KzAwbmdGYnVCWkd2NW83ZEMveVBhaHB4clp4TkJmbmN3WDF1TVBR?=
 =?utf-8?B?MTBVb1d0QzE5WmlIYmtLc1NGQ1RBSnl1d0dmQmFkS1BibUdZZzMyY1pySFB6?=
 =?utf-8?B?UkFPNHF3RG5VNnBkaVJkM0pkS3lKbGhhTUdIYnpmaUpuc0pYbk81U25yck5h?=
 =?utf-8?B?Ti90MHhNNVQ0dU9tdVZJNHVPNkRXQit6aS9uNkVQTHZGb1hLT1BTOUl3WUJr?=
 =?utf-8?B?dEsrM2pvZXZHeHhkQXgyQ0Jzd0VaU0Z4eXVFRzM3Q1VHVnViQ0NxS3N6MlFm?=
 =?utf-8?B?Ulp0NlVMWWFhM3VON1ZFV05XbVFEOTNKUmtqeFRmRHNBYjZaTldBU2dkVktB?=
 =?utf-8?B?UzlGVUd3YWN4MEV5QVJkU2RTQTNweE1GNThrZkVtR3BhRjBGOHlFUVQ1S3cr?=
 =?utf-8?B?dHB1U1ZWRGlJaWFISnBRcWlPNnNBOWFzbXd4QVV1YmN4SCtuMDhranF5Qlg2?=
 =?utf-8?B?M1R6dlN5dnk2NzlvRE0yVy9pbkhQTTlKSHBOVS83cVU0WENDcjBDRGdvdk5N?=
 =?utf-8?B?cDFBNDI4SXpWTEkzQmFUWTZseDMyRTFTSWJmc2graVFrMGVOTHMveGx4bSsx?=
 =?utf-8?B?eTFNS0loZ3RZYmN2WWtZbno4RWdZZUk2Z0RSb3lJSTJFb0JKNjBmd0dHL3Vy?=
 =?utf-8?Q?gZVK2mE4sZ+21N4Kr4FvRr+tZHNBAhvG06wMrWT?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR18MB4339.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(1800799021)(376011)(366013)(38070700015);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?Z0dVdWlNazl4QTF6Qmg1bjlieDVxbTdVNzNqNUNVRnpDMzVQdVZWVWprVkZS?=
 =?utf-8?B?N2RoVEV1RnErdkdMa1FQZjBBbldDV25Tb3FiZlRIWWZlMit0TkwvNVF1eHFs?=
 =?utf-8?B?alRERTZkMDIwNm9NcytKdGFReityaWdnSThoZnlhQWVESGp0MUNCZlExekdK?=
 =?utf-8?B?dno3Ri94TGt3MnlsajZvdjUrLzByRkNNMW9JYVNkaXc5U2J3OUJJY2NhbWo1?=
 =?utf-8?B?UEpDNko1K1Y5VDJ0MXBzWTdaQnpzdVpicHNKVzIvU2VzZUJrRlZMTXQ0UnVq?=
 =?utf-8?B?cFo2MHAraTYrNVdrUXdyL054U3pMWXptQ0FCRjdDZ1dBTytBR0JxVU5YK1Iy?=
 =?utf-8?B?QlJZYlZPK0JRSGN3V3ZzYWdWamh5MHhRN3ZLTUFZZ3Juc1JZZ1JKS0NiWDlq?=
 =?utf-8?B?bWEwUGlQSzVuVmZlUWZUeVVqRDNGV1h3OHBSQUFXRXUvQ3piR0VBYW11Qzgw?=
 =?utf-8?B?M25LOE8wQngvamJRbkxZSmVlTTVpa0RSdzhvNVhmNHptNk5iQ0FEcjZsR0hz?=
 =?utf-8?B?Rzlpa0x6UkJ2NmJmbnl4dmtnUWRmZWwwVXAyMkZhdE1NV08wR2kxbW5IT2Ni?=
 =?utf-8?B?SUc0S0RCeEc2Z094Z3NaUGtpTDFhV2xVdzVSUkN6dDNoWkszbVBqdjhQOVZG?=
 =?utf-8?B?eitqZGdvM3oyRXRvOEJYRUk3blNvRUdSNnNaOWMxdUZKbmNUWjJBUEJONWlp?=
 =?utf-8?B?YngvdDk1S1VzZEZITlZUaWUwRlBpSXB0a29MYlpBK3lrYjhIVm1oQThlRHlz?=
 =?utf-8?B?bEZza3pWQXJmckdpeUlycVk2R1NuWFlaaGFQN0xHRjk0U1Z2aS9tZnRLY29s?=
 =?utf-8?B?S2pNL0ozTmVReDd0WU11VUViTzBuSW5qY2N5TE5NOGRFcHljR1lmSTAyY2xz?=
 =?utf-8?B?WGdsb2FQN2pGdzcveDkxUGdFUTl1OGJKRVpVNFN0anRBZVUvNXY3RC9FNGZK?=
 =?utf-8?B?N0ZqZVpEL0loNGM0SHRPK1RRYUppa0JqZnNIVXQ3WDVmU2s3TGtnWEJUZ3Vk?=
 =?utf-8?B?aWJCN1k5MnF1Ujc0TTgyUjFzSkswOUpSUFV0Z1JnS1pBaEtNSFdrUDZuc1ZC?=
 =?utf-8?B?WTNpNFZSMUdSNkw2YlBSWXhHRU9TZUVGRzQwTlI0WXp4VGJzVGRSN2lVUzlp?=
 =?utf-8?B?QWhVUHNYbUNrRDJKbW1rNjhRcHV3VEZyNXhPbklodGhtL2YwWkVwMWZjVndB?=
 =?utf-8?B?cFM3dVdhQm5vTEg1MGFyK1NDZXQ0QXZaajhnQ1luUStTbTdvbGhNOTRRZ0Zr?=
 =?utf-8?B?YXRSN09ZTHdhSGJwMDM4d0p1OFBMZUpiRU9ZZWRlWEUxRXBCeWphcEJYRUtH?=
 =?utf-8?B?RSsxOXVBQ3AvcStaUXlSZlZqMzFOZWFrWmN4ZndxRDYyWmJHNGJQbHFyUWlj?=
 =?utf-8?B?dkt2bEthS0hFTThQYVdVNnlaTUhmSWNZL051YncvSmhoUEZFSGhJNitMTVlQ?=
 =?utf-8?B?UlB4UzUyNDNZc2E1eUNwOVhQaTB3YzhKalJ4dDVTSGxjUEFpQlNDL0pFWDdy?=
 =?utf-8?B?VjFIVlhRdkpmMTY3ZTNJUzkyeVN5aEZkaXlLR2ZvenlFYm1LSGlxRDNKN0VN?=
 =?utf-8?B?Zkx0Z3pMSjg0YWJIaVl0Y3dTdWJPN1A3NFNZS1VhQ2pndVl4NDJEWUdhdUFN?=
 =?utf-8?B?M25UZzg2bUMxUnNsN2diYk4wb25sdS92RXhUaEY4MU1XbkNwQTM3N005eWRL?=
 =?utf-8?B?ai8yaFZvNG1QaVNHRWljNHI3UkxkazcvaDluUXYwZ2NNQ2xkb25Vb0RwTFFK?=
 =?utf-8?B?T2IzbmZoUTFTSlJmeDJ2L2RzSVBPWDBNUUFKSWg2aEJFb3hITVVYSjVSUVZG?=
 =?utf-8?B?Y1d6TURTNEg3RkRtU28yOFZzM1VqdWNiS1pxU2YzbEdkdnI2K2JKT1NzeUUx?=
 =?utf-8?B?aG1RQmNKWkVlbzZzM3JFRGRKYnA3Lyt6MG9KRGJTTHZTUVJsQUh2S2JJdGlO?=
 =?utf-8?B?YmV0ckk3N3V2YjA0S1hWOXUydjVmL25rcm5kOEpDRDlWWjBQbXYwa1FKeCtJ?=
 =?utf-8?B?NnQ5a2pod0ZxVHRhRnpJNFpBN0lIeVBwRFYxUnR4YkFhUy9HT3VGRkJZMFpF?=
 =?utf-8?B?bUh2LzU3MUJDbHR6NFB2dG8wLzQ4NHVsR3ZaT3hjS1JyQWNCZ2xTcWowaUhH?=
 =?utf-8?Q?Xgr8=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: CH0PR18MB4339.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f86c52ee-6e42-4c32-215d-08dc8f76486c
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2024 09:08:56.3113
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: muooCnObHtOLGffA9eXckf97LWgMnQ+fFXela49hdHxkWggh9euK2zrYl6LmvKPhn2P/NwORUyGnmy6m6Hwpog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR18MB4435
X-Proofpoint-GUID: z34n2E037j2UlcUedPbcg0AQ7O3yECxd
X-Proofpoint-ORIG-GUID: z34n2E037j2UlcUedPbcg0AQ7O3yECxd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-18_02,2024-06-17_01,2024-05-17_01

DQoNCj5Gcm9tOiBKYWt1YiBLaWNpbnNraSA8a3ViYUBrZXJuZWwub3JnPiANCj5TZW50OiBGcmlk
YXksIEp1bmUgMTQsIDIwMjQgNzozMiBBTQ0KPlRvOiBHZWV0aGFzb3dqYW55YSBBa3VsYSA8Z2Fr
dWxhQG1hcnZlbGwuY29tPg0KPkNjOiBuZXRkZXZAdmdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJu
ZWxAdmdlci5rZXJuZWwub3JnOyBkYXZlbUBkYXZlbWxvZnQubmV0OyBwYWJlbmlAcmVkaGF0LmNv
bTsgZWR1bWF6ZXRAZ29vZ2xlLmNvbTsgU3VuaWwgS292dnVyaSBHb3V0aGFtIDxzZ291dGhhbUBt
YXJ2ZWxsLmNvbT47IFN1YmJhcmF5YSBTdW5kZWVwID5CaGF0dGEgPHNiaGF0dGFAbWFydmVsbC5j
b20+OyBIYXJpcHJhc2FkIEtlbGFtIDxoa2VsYW1AbWFydmVsbC5jb20+DQo+U3ViamVjdDogW0VY
VEVSTkFMXSBSZTogW25ldC1uZXh0IFBBVENIIHY1IDAyLzEwXSBvY3Rlb250eDItcGY6IFJWVSBy
ZXByZXNlbnRvciBkcml2ZXINCj5PbiBUdWUsIDExIEp1biAyMDI0IDIxOjUyOjA1ICswNTMwIEdl
ZXRoYSBzb3dqYW55YSB3cm90ZToNCg0KPj4gIG9iai0kKENPTkZJR19PQ1RFT05UWDJfUEYpICs9
IHJ2dV9uaWNwZi5vIG90eDJfcHRwLm8NCj4+ICBvYmotJChDT05GSUdfT0NURU9OVFgyX1ZGKSAr
PSBydnVfbmljdmYubyBvdHgyX3B0cC5vDQo+PiArb2JqLSQoQ09ORklHX1JWVV9FU1dJVENIKSAr
PSBydnVfcmVwLm8NCj4+ICANCj4+ICBydnVfbmljcGYteSA6PSBvdHgyX3BmLm8gb3R4Ml9jb21t
b24ubyBvdHgyX3R4cngubyBvdHgyX2V0aHRvb2wubyBcDQo+PiAgICAgICAgICAgICAgICAgb3R4
Ml9mbG93cy5vIG90eDJfdGMubyBjbjEway5vIG90eDJfZG1hY19mbHQubyBcDQo+PiAgICAgICAg
ICAgICAgICAgb3R4Ml9kZXZsaW5rLm8gcW9zX3NxLm8gcW9zLm8NCj4+ICBydnVfbmljdmYteSA6
PSBvdHgyX3ZmLm8gb3R4Ml9kZXZsaW5rLm8NCj4+ICtydnVfcmVwLXkgOj0gcmVwLm8gb3R4Ml9k
ZXZsaW5rLm8NCg0KPllvdSBnb3R0YSBmaXggdGhlIHN5bWJvbCBkdXBsaWNhdGlvbiBmaXJzdCwg
cGxlYXNlOg0KU3VibWl0dGVkIHRoZSBwYXRjaCB0aGF0IGZpeGVzIHRoaXMgaXNzdWUgdG8gbmV0
IGJyYW5jaC4NCmh0dHBzOi8vcGF0Y2h3b3JrLmtlcm5lbC5vcmcvcHJvamVjdC9uZXRkZXZicGYv
cGF0Y2gvMjAyNDA2MTgwNjExMjIuNjYyOC0xLWdha3VsYUBtYXJ2ZWxsLmNvbS8NCg0KPmRyaXZl
cnMvbmV0L2V0aGVybmV0L21hcnZlbGwvb2N0ZW9udHgyL25pYy9NYWtlZmlsZTogb3R4Ml9kZXZs
aW5rLm8gaXMgYWRkZWQgdG8gbXVsdGlwbGUgbW9kdWxlczogcnZ1X25pY3BmIHJ2dV9uaWN2ZiBy
dnVfcmVwDQo=

