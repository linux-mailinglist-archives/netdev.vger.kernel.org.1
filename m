Return-Path: <netdev+bounces-95023-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 10D278C140F
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 19:30:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 940E91F22D47
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 17:30:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B1D51862E;
	Thu,  9 May 2024 17:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Uc++5CaR";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="V5IyYzq5"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61B2C8BF1;
	Thu,  9 May 2024 17:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715275805; cv=fail; b=sQ6KWXorspUJkjWvyb2bBi+yaaSLsGSQGdRIWq1chg26zAKcbJ0VT602Y5flJLpr7IVolInT3hj7ZNAXpFH3LSUt6YghfwWC77y/6z3tM1igQlibyc8w5Nz1GpduU4L3oJOxkkapHsjpbBVCj9KmBu1H0Q2eKO0jsyt1+e39G+g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715275805; c=relaxed/simple;
	bh=cA8GhgEcSvMA0MYy8o4CRNfysjQuO3tI30mTZEa7XHw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=WpagFDOwm2F7qTyS3Yu3T/nOu/tI3Shn9VFSSVhQKNCbEYSFmEm+ENKVDn1OhS43EDx9kjRO2FueUQJk/+nBCSiC84O/P+u2ivyUOs/IMTUfprV4xxghqRnItKxPwXPoUoo+0Qhx5jRqSMkl90Yz7j/rOamQU9flRkMeEv+TgOE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Uc++5CaR; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=V5IyYzq5; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 449HKPZ5030862;
	Thu, 9 May 2024 17:29:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=hx6NSTaMgX2JnZZ/0GaS1KEaK8SqIeCBwxKV9bq4vaI=;
 b=Uc++5CaRzOb/FmRl07bMahxqqrCS9WymcaUr66Cf4D9xEj6r1yobM9rloRNyvVXB9PUl
 HKVmrA4Nn7EEYvH3ntcxr0bfrzMnYm8OkzM90DMnjfR5QBK6/RQ2CsF3B462wD/jcGfa
 lBnUYMpKifr1wwyc8FzkwzcN1GpqMI6t0uuwF1hhdwNGoKtu800K9sQjpa1KNijNhAGy
 RFhmv/4pVF5mA9FaA6bMhNC4XjHN1loSSxNUHxyg8ij9gNqeQ/UqzG1zCvliJ3MyFRpm
 he78ZO/WV8O19FQE0Xm+y81P9UdZ9Avfte8nNHoSK8ngR7Lmx8TKo9LgQ66kCJ108l0h dA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3y11t5045c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 09 May 2024 17:29:57 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 449HPKIG031066;
	Thu, 9 May 2024 17:29:56 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3xysfkj5x1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 09 May 2024 17:29:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I89e0sujvL00SCb5oO6GMZSoL+mPUWfD0ARsBEms7wsgE+eZJcvBtWwGdB5cpnVdYkvrMLTtgNLlk4+o8FHJnjzP9k168T2rTgAQBWSjOeLuNPmeGzGPYeRtrSNQuLl1Qs25VhEZhUCSCX+qR9Hl/avMGFXxJ9JDjZmyt6fAksph9ELfY2MOtwVlCQkKvz1Haec/0dRgBJNeUP526LddfR9pFBThro8/lZ1gwpBLD0ybc6c0gWGF13qlA9XgW1OqW25tFWVYvD8yUWLnw2MEiYcjHZsUnZ+y9v2TFZOpqSVRfMA2j0yBo5/V/OoOosKUqFrn0q1r0IqxMzpITBZMSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hx6NSTaMgX2JnZZ/0GaS1KEaK8SqIeCBwxKV9bq4vaI=;
 b=eNEcb5+3H5a1LQpf/uFBzFM1+8ZPBGU5g+drzvfP2zpbK5AvOjSQbgAGpwFziZYCEqib1Tx941n82MzRZMjo+P639zJbLv4wFHqLYp4RyMDqezM/8Ah8+EGAZbeBX4gFOcCt2ftmgtLyJaTdFNPrj7knsca3PJRZ/t39SiaQHlvBdscRNrvxBMBykqE+FOwKYp7rrqjMS9r9qGSAeiG/ZzEJNnhOfdj8w/LpuwIjkzDg+iYJEPQRYk46uqs8a6n9/OFHqZYD1oaT/sVhXONZHDHphlHq5GMZ4YLQeD/w2ynYFH0HHRmtvA2SnlJSP+dVlUqFjJPu9m1bIFqG8k38gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hx6NSTaMgX2JnZZ/0GaS1KEaK8SqIeCBwxKV9bq4vaI=;
 b=V5IyYzq5jDmofnLqoFMEuKWuN0k4qBuE4Z0PSamYU9lQu7B0/mw7wH8Th15bC7dxKJFFVLiGcELJcXGLWrNkT3Sz8kDJOlQDo9UmilxQaD1QFKBLxrkkos07iTZkaNjh+SH6bw+92ADdDBEJiNvxYqMYZdHpLKpLWEmkpx1OY8s=
Received: from DS0PR10MB6056.namprd10.prod.outlook.com (2603:10b6:8:cb::7) by
 PH7PR10MB5675.namprd10.prod.outlook.com (2603:10b6:510:127::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7544.48; Thu, 9 May 2024 17:29:52 +0000
Received: from DS0PR10MB6056.namprd10.prod.outlook.com
 ([fe80::a504:4492:b606:77c2]) by DS0PR10MB6056.namprd10.prod.outlook.com
 ([fe80::a504:4492:b606:77c2%7]) with mapi id 15.20.7519.031; Thu, 9 May 2024
 17:29:52 +0000
From: Mohith Kumar Thummaluru <mohith.k.kumar.thummaluru@oracle.com>
To: Yuan Fang <yf768672249@gmail.com>,
        "edumazet@google.com"
	<edumazet@google.com>
CC: "davem@davemloft.net" <davem@davemloft.net>,
        "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [External] : [PATCH 1/2] tcp: fix get_tcp4_sock() output error
 info
Thread-Topic: [External] : [PATCH 1/2] tcp: fix get_tcp4_sock() output error
 info
Thread-Index: AQHaoct9vkofYpmciUWhqVxrc622UbGPJ7bw
Date: Thu, 9 May 2024 17:29:52 +0000
Message-ID: 
 <DS0PR10MB6056248B2DFFC393E31B4A1B8FE62@DS0PR10MB6056.namprd10.prod.outlook.com>
References: <20240509044323.247606-1-yf768672249@gmail.com>
In-Reply-To: <20240509044323.247606-1-yf768672249@gmail.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR10MB6056:EE_|PH7PR10MB5675:EE_
x-ms-office365-filtering-correlation-id: 23fec94f-8949-480d-923b-08dc704da295
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|376005|1800799015|366007|38070700009;
x-microsoft-antispam-message-info: 
 =?us-ascii?Q?tE5YTinAWv7/Hk59WAcDRIe3uxvT5XAhYMVB5pxPc10VdOQ3veAHT0mHkpIC?=
 =?us-ascii?Q?74w+8RDNrdzI+FkGEdlC4/nfKJUq7yPVLicQRYvkJ0CZdYIPPg9DzzXWgR3t?=
 =?us-ascii?Q?syuP9gqrdrRHGsC6Wx+byWqG4HqBP5A5ixEpicenb7kSeZN0uO6SgOAxSWYA?=
 =?us-ascii?Q?hrslXU19yvlEWGewTHkB30Pe6bGbk/MNzpdeb5xZPQ1y15iYX2v0Mvg8ksEf?=
 =?us-ascii?Q?NIlTCByE8jsKkCazICoMf+vhkj5ybJi5J+6nQSUfJc5nne1pkYr3KHdngjV7?=
 =?us-ascii?Q?OngV1zPlAhYRDZ/SVrYOtDwXYx85rEfM1UW1tPzgNU6ijS/pcPk4gi1p9Jf2?=
 =?us-ascii?Q?NO44+lv3AMvbtAt7QrRk2WmYNWozGd7PxJf5jT6ez2Q8ODZQEYzH56RVTTex?=
 =?us-ascii?Q?WZtA/9UOP7Zp5ql2YB0u3fXZpZGDnzZmoBU7bWSJZKTpP1eUZv6V9egvCA4e?=
 =?us-ascii?Q?ucGoj0IKIHNz/gQRKPAnCs3InMps65l93vJoZx7XFJt8Tcqe2aL2FlM/jgI7?=
 =?us-ascii?Q?Jn8ATiZf6g87Imi2A2TlsODe1xirZ3WS85faz+HzJsFDZ1AL6R2F0APfoyK8?=
 =?us-ascii?Q?gHIDsuMnA60YfO25KMO3fGW4KLJJ2T9IfaYWI9NkLs+B0LJ2ZvSxCcdRgWYZ?=
 =?us-ascii?Q?LRf2hwQo4csJ4sN+iKwawVMhKWosUNyMA1y3etsuW6DkLj31cWCgGLIWjGeH?=
 =?us-ascii?Q?h8/iLNtnZE8tsLwILJ88aaao5lgUMWt0B6xnbQj56AH/4ShpnsVgooJ9Ajig?=
 =?us-ascii?Q?0cI6jHajUK8WlLrrAn6Jo8wf6lCezNsk0zHEG+Vb76FUC3vcI+pWbvIgxy3w?=
 =?us-ascii?Q?2ibUdvtxvnkq33APwHCdXe7BYMAJEm4nWspbxOArGFpLBpdgmnWME0wHRQNZ?=
 =?us-ascii?Q?cARwnWUjxKulCB3JlotoL8qWY+COXuKKIvU9jEXSIm7rGaaILjvATcevgkyu?=
 =?us-ascii?Q?ZnmwV+Iz2V6NQPYQ/0l1NsVLMgL5vDwj6bMeRvZwW9IHx7x/8v4Sw0MG6EJA?=
 =?us-ascii?Q?/u8jb/+lMUMOc3BF90/YuaQZPmWxndkIBOkCUuVIzlDQWZ42aVlvutHubqIm?=
 =?us-ascii?Q?le65CeTrpYYscoLnX3V1yDcNrRKdnF6WTnpQMlebhbucrwtG9rUpQWWP9S/P?=
 =?us-ascii?Q?/KrtjrXaLTFjMESPopvTGOnxAveJv9JkJ79erlVeG92EXgRkPctuHP+SPevc?=
 =?us-ascii?Q?LoyT4ygeNbxl2MgFrTnWZyKCTszcwSDlZPhF0a0w8rdNwbwcvc/wzNaVW2gD?=
 =?us-ascii?Q?QOKpZkmkqozWE/uRUMNqSfCaS2cOEdRBitYLoDoPUDbD1PLLDy0KKGJOhj0h?=
 =?us-ascii?Q?R3N3qUOZwtFpRqV5pG2DUBKf9Nx6oP4KNqGWJ6Pn7/ivNg=3D=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6056.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?W3Bl1n8FiI4Xdhp0y35bkAp2Vaw8fhUxJG9DqVwLbpi/TwUHcJI+xyOFZ2i6?=
 =?us-ascii?Q?0Wo/Br+ZVuNWdmaedyAyrcSGMeRLfOnYyrXU0f3kannMftEy9NhblmDHZymx?=
 =?us-ascii?Q?3GiHin8vJjdZhEjzwpQvVUAZ2ky6UnXRnATTiZDu9nAKbiq5VtvdDUWwymBA?=
 =?us-ascii?Q?tcWchcVLBRiz6K1HaEThJiwqnFG4d5KrrhTbAYp0SsdKl62iPB2Gfl9d5E2W?=
 =?us-ascii?Q?FbiJcog/HtEHFfcTaPLZ7Z1wvzIWc34GfA1C7OB1Y0OVYFgcdee2+xNCLGbe?=
 =?us-ascii?Q?81yjt/HN1EKAayY3Nnsr8Q/6TRxlGFB28A1exzsUkXlAAjJ/HKkUX60FbxDy?=
 =?us-ascii?Q?9A8U7GIUTpzTCE7v8z3agmRqlpC9DEsb8L/d2ufijBUUrC6p6zIrvULEeUIR?=
 =?us-ascii?Q?316uQzK4wrOiAD6tF/xUaSowTCYS74K3Eab7sCrn+hk3jT4gRzxhxg2pkjlZ?=
 =?us-ascii?Q?UQH8NeN7c7mFo8eAcPkyYMtFtexvejjYydfLFregPMuIOs2G0sf7bKN708CO?=
 =?us-ascii?Q?Vgy4K2adi7IW8SoXPEh0MVQ7ryMihjWyEbUnnsY5HQSXR/KzdGKAFODM/vI5?=
 =?us-ascii?Q?Isqt0QqPeSrqWnrEoo22+YWStoqEsLBIcfP8CtwowjFBiN+6oZFryPRicFeZ?=
 =?us-ascii?Q?3DSN16FCoOWyfEUsEE9eY6fkSc7ZGHvvOqSF5cmaP+PkwtlX4o4Zevp4CW2a?=
 =?us-ascii?Q?bdQkWzCMFmLMRVT38dB+EbNCOIoGwcPLhnzOQorHNvdT7QFMiGDiUXZuffwL?=
 =?us-ascii?Q?EIWvAPhxbqPc3tN9zreBStrxCidlWXrzsV+3/7CJdrItK0kXswlFuIDA8969?=
 =?us-ascii?Q?KisW7K44z2xRpMxkURZ12UD+jBwvnx+tufDa2/U8S3QNdD4pmNpYNiBXSQIn?=
 =?us-ascii?Q?1gitb4hIlhYhm0UfrA+4U2FCO9k0CstPWSlGtrl4CxlQBObFa79VVkJMfbiK?=
 =?us-ascii?Q?eVUPFRimWfLp6KEnWNLM6gjc1/u7ygA+7TNslAm7XJLyZfRCx2wAnlr67JJB?=
 =?us-ascii?Q?c+qnr+i7NfdGTXKvgbVc8SW17Hn738/XiyGkYLoGWS7RSa9GJ7Oj70AOVYJi?=
 =?us-ascii?Q?bR7DfbARG9dW2J9xfgVqBti+l22VwUAdFRo11jAZSCefy7UULSm+nXy75kr0?=
 =?us-ascii?Q?eogaEiF1rHycHpL8X5+Z7P24bHYqa3u4j8+IMgT6AXRnqkWaJeGYO6cXy+1I?=
 =?us-ascii?Q?TuUHlovXJY2oUJr16JZqOCErY846nORyFtG6agjL7VlvOHmUaPL1g5jzJAfA?=
 =?us-ascii?Q?QLfELRNKGvxxZPisMU4vKT7+CzSAcKNVLLuTnFroP5ZCFAPSX7k1G4+DBy5v?=
 =?us-ascii?Q?QEvUla8lamBoJDDBi2ibWDCR8Wsa/25SPmd/YLzhehx5ULjCkPedj1TFCWdH?=
 =?us-ascii?Q?GOcllZSXWFJN9f7pwfWEdTmwh+PjIueWFmfRSYcnsxAS5bWR7BZhxPFSqI5P?=
 =?us-ascii?Q?AZ2E3A+OwI80CKmvEGeF9U9jLRoNyVBIvKkHSgxwWfB3YQebUKyPZRXCuwgo?=
 =?us-ascii?Q?6g1ArqqRap6vjGUBcCBNkJizuEgnrzWGAwSgWFxpjrwUHdy0UOY2djuo9xLE?=
 =?us-ascii?Q?stVyDLpeIHdMjMTyVsPG5h7Xs8rz4FNC6HBjFjCBVd+YgDWnhxY5ii5C76Q2?=
 =?us-ascii?Q?keD8EeFjVgRjwN59tvCFKh8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	NBO+jrrQZMFKdEwRmABspFAmRLTyDbxKG+I95eS25eeHuHvlfoO1a54v+8MwU4kFEdmlFlOhEPHEc3qubkDy5bpBiXpgfCfT9sC3T16vR9YYIVqQCzW06D/k+wSKRmZJy80PNodq+ZEgL9vEJ1HPdJol5sfJjyscNhy2stR8idNz+V6+laIT69GFA1+vNKIzcRZZXzno384eZ9YGXZmLTNrgCR6T0sYtD/NLsAnutBTtxB+di1vU8zrvTCvZAWUj0aY6kIXgCmcZbp15YXk/aqG4V7gWAz/EDC1YHb8RoXu0cYqC2eNK5kF6gaev7i7NAUd17RhSykZnyBIAkrMw6arKNfxO85cahk/r5lNAkaPWBQCBThqSq91tKCMiusZ6loyNnkG1gTnhEGeEWFSjmd4DqFBF+7T/lGObczURoUTpWRqlMwt23CUPhdBAtIAvmq37Cys4tl0DzJ86Za8/VIPjChx0aPvyY34bOJtYp5JYsTndgzPskabRpxfYIv2Wv+gZb6pdBk04G89kRjSarVDPygNesuM12uCStONN5vuGTyqjLxfrRvG/WpBL/JGx4TIG31q3qhjmhO6U6VQGBRSEypzEzdQ9rIiijEMj1Ms=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6056.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23fec94f-8949-480d-923b-08dc704da295
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 May 2024 17:29:52.1933
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: o8cVistS7MfMLHRbW0B3yqvUb7p3kPHVHkL1u48fztUVjGDou9lvm9U5FVMt8QSQ2y5AQLvZn1qNNLk165u3FNh/tmBl5+DgbS1gyD3CwODvuL78cN4wxeXuzomImpmi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB5675
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-09_09,2024-05-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999
 adultscore=0 suspectscore=0 malwarescore=0 phishscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2405090120
X-Proofpoint-ORIG-GUID: mEOTEeRqUmwb8UdwleODRt34YiLonf1G
X-Proofpoint-GUID: mEOTEeRqUmwb8UdwleODRt34YiLonf1G

Good catch! Thanks for this fix.=20

LGTM.

Reviewed-by : Mohith Kumar Thummaluru <mohith.k.kumar.thummaluru@oracle.com=
>
Tested-by: Mohith Kumar Thummaluru <mohith.k.kumar.thummaluru@oracle.com>

Regards,
Mohith

-----Original Message-----
From: Yuan Fang <yf768672249@gmail.com>=20
Sent: 09 May 2024 10:13
To: edumazet@google.com
Cc: davem@davemloft.net; netdev@vger.kernel.org; linux-kernel@vger.kernel.o=
rg; Yuan Fang <yf768672249@gmail.com>
Subject: [External] : [PATCH 1/2] tcp: fix get_tcp4_sock() output error inf=
o

When in the TCP_LISTEN state, using netstat,the Send-Q is always 0.
Modify tx_queue to the value of sk->sk_max_ack_backlog.

Signed-off-by: Yuan Fang <yf768672249@gmail.com>
---
 net/ipv4/tcp_ipv4.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c index a22ee5838751..=
70416ba902b9 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -2867,7 +2867,7 @@ static void get_tcp4_sock(struct sock *sk, struct seq=
_file *f, int i)
 	__be32 src =3D inet->inet_rcv_saddr;
 	__u16 destp =3D ntohs(inet->inet_dport);
 	__u16 srcp =3D ntohs(inet->inet_sport);
-	int rx_queue;
+	int rx_queue, tx_queue;
 	int state;
=20
 	if (icsk->icsk_pending =3D=3D ICSK_TIME_RETRANS || @@ -2887,19 +2887,22 @=
@ static void get_tcp4_sock(struct sock *sk, struct seq_file *f, int i)
 	}
=20
 	state =3D inet_sk_state_load(sk);
-	if (state =3D=3D TCP_LISTEN)
+	if (state =3D=3D TCP_LISTEN) {
 		rx_queue =3D READ_ONCE(sk->sk_ack_backlog);
-	else
+		tx_queue =3D READ_ONCE(sk->sk_max_ack_backlog);
+	} else {
 		/* Because we don't lock the socket,
 		 * we might find a transient negative value.
 		 */
 		rx_queue =3D max_t(int, READ_ONCE(tp->rcv_nxt) -
 				      READ_ONCE(tp->copied_seq), 0);
+		tx_queue =3D READ_ONCE(tp->write_seq) - tp->snd_una;
+	}
=20
 	seq_printf(f, "%4d: %08X:%04X %08X:%04X %02X %08X:%08X %02X:%08lX "
 			"%08X %5u %8d %lu %d %pK %lu %lu %u %u %d",
 		i, src, srcp, dest, destp, state,
-		READ_ONCE(tp->write_seq) - tp->snd_una,
+		tx_queue,
 		rx_queue,
 		timer_active,
 		jiffies_delta_to_clock_t(timer_expires - jiffies),
--
2.45.0



