Return-Path: <netdev+bounces-184399-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BC199A95380
	for <lists+netdev@lfdr.de>; Mon, 21 Apr 2025 17:17:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA66316F269
	for <lists+netdev@lfdr.de>; Mon, 21 Apr 2025 15:17:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4293519F42C;
	Mon, 21 Apr 2025 15:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="M753ORyK";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="XIg41Zo2"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B428184
	for <netdev@vger.kernel.org>; Mon, 21 Apr 2025 15:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745248651; cv=fail; b=AHSixQj6JB5EOuyFYzNoDn0Whee33xHBfqeCaWWOPEXvzdTujJLk38UHGA9krHeo5QiAPJMVX95/oMUyCgtEZRCG0m5UgydYrSdo5FzhZJbCY10zpLiAMR/mgKuAPhvqMBETdDDu18k0J1MIenJLJdcx6hV5vuaacbb7LFXvqYk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745248651; c=relaxed/simple;
	bh=ivn7zyZlYnhYXlcJR1zT3HTfntZkkxdyUfcxV8sTYqM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=EbSiPbFoyo673yM8yf2fZgfuP9nkmtcpclWUkayG9eVHIjdYlXQiPQ6vuG/tMLkRQH7udzNFhHrMDpWBp2HoJyWbqQw+iQ98IxBizgrjyw0/B5tjD9k63lZUZmg9A+kyLtoVgWYE26aVRZ9o6qe4+4bTokJsJS5Va82OQa5eV2E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=M753ORyK; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=XIg41Zo2; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53LCAsDC015895;
	Mon, 21 Apr 2025 15:17:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=ivn7zyZlYnhYXlcJR1zT3HTfntZkkxdyUfcxV8sTYqM=; b=
	M753ORyKwUUzRL5+5pyILMQVxYtIytPZB5h5gWzFrwAEd2StM9yYb/aHoSINepB9
	hJOeHIs9lQC4dm2ESsINOj5yxC2lGapc6EvEuP8N8E5IXRUhUtDNYohDn2bdTxpw
	DXtmf7L4VqFSqWjJGV9qzz7oU+AHAlmRtZtuA969tdsGvwobx/hxe+q7uPhxWNiP
	rt3+B29XM3dlc7UrK5tmlctz2nYu0B44hNef0tntjgcyeQsGi9AZ9zSmypdl/3EO
	1UnyqsDC01Inm7pZgatwdiNOruXz747wgXwXugVGaZqMfk5y0f4lUY0anCnQEdx8
	kZWsoNb1LhUNCDW7Q+FuEw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4642e0apx7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 21 Apr 2025 15:17:26 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 53LEULXF005943;
	Mon, 21 Apr 2025 15:17:25 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 464298d13k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 21 Apr 2025 15:17:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EzORiciB6RK/SSZEzFz1yKlC4lG2tAj+Av7VHyBreuYbMpli7/XTF4KLqtVIEOo5mDvLwvf9pYhtGJbeIi/ljoDJv77tcmb5h/a2h6tok1EwxCxXpk7W+QiPjchxodkaracVKXsDJXYda9/eRMyUmOhLwiRKK3Pzby01Bl69PNusdTx38ftvAK3FLsGDh/Bdqm7AOeNNax9KuoBTHXV2V/zsC7190A1s9pvXt+ZrooZt7QPiE95NsRq0lZ46JwNTIn6g5ZOCYltO3tI04B4Z/TUYC6/+01X889YKcEmqxren9vyE8dbFepQRh9ayJPvtcgDy09SSZ9mSSn4KC7HD1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ivn7zyZlYnhYXlcJR1zT3HTfntZkkxdyUfcxV8sTYqM=;
 b=UE/ei+LezWXA3sNYl/PrQ31iD/VhuijuX7qv0Gxg0BJ4WmVxLtb+UsOyEgOIU9RNSJUXZ/TTm59dPmWMe+tuk2dyTS/XesVPKzFfy2T7nygTFK+huYxYT2zloUc8mXzpYEw0upSYqaglk0VB8WZQUq4cC7ZdLvFcCitQyHnSO+pTthTtKjgRsUkmFa4BztTAKh0WpJhZigVjNhmxkuYyc39ZQgqt9hmu87Mc+EGzTlpP124jlkgnDCAbzkfGWBdckpbhMjCvXnIZPylfXKCKyJSc7nPde+pGfmu/0l1ALPv/Pg7dVinf7fyM1Kp0d/oQkToUNxTAsKxD3SGvy2KFdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ivn7zyZlYnhYXlcJR1zT3HTfntZkkxdyUfcxV8sTYqM=;
 b=XIg41Zo2wc19z8KkSwHkyMJjB7MBLSwvAa3jhAAona3cUTSCls3DDJUvyuJSXOMedBgRaw3/LT04pcZNh3dpWccijwFe30FRGPbEaTn/ig2vQshJmTC4RbbPtyRFU5Z/ru0bj8Yer3qbFcJxz9nXV59/xbanJ0ndIyWTFdPYTYM=
Received: from BY5PR10MB4306.namprd10.prod.outlook.com (2603:10b6:a03:211::7)
 by SA1PR10MB7596.namprd10.prod.outlook.com (2603:10b6:806:389::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.33; Mon, 21 Apr
 2025 15:17:23 +0000
Received: from BY5PR10MB4306.namprd10.prod.outlook.com
 ([fe80::b78:9645:2435:cf1b]) by BY5PR10MB4306.namprd10.prod.outlook.com
 ([fe80::b78:9645:2435:cf1b%3]) with mapi id 15.20.8655.033; Mon, 21 Apr 2025
 15:17:22 +0000
From: Allison Henderson <allison.henderson@oracle.com>
To: "horms@kernel.org" <horms@kernel.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH v2 1/8] net/rds: Add per cp work queue
Thread-Topic: [PATCH v2 1/8] net/rds: Add per cp work queue
Thread-Index: AQHbqwvZzf4DFH4fLUSCyePpLRUrErOnpKEAgAamPAA=
Date: Mon, 21 Apr 2025 15:17:22 +0000
Message-ID: <1bbdace69013f5467c50d983b40378a8fd7e1620.camel@oracle.com>
References: <20250411180207.450312-1-allison.henderson@oracle.com>
	 <20250411180207.450312-2-allison.henderson@oracle.com>
	 <20250417094450.GC2430521@horms.kernel.org>
In-Reply-To: <20250417094450.GC2430521@horms.kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.52.3-0ubuntu1 
autocrypt: addr=allison.henderson@oracle.com; prefer-encrypt=mutual;
 keydata=mQGNBGMrSUYBDADDX1fFY5pimVrKxscCUjLNV6CzjMQ/LS7sN2gzkSBgYKblSsCpzcbO/
 qa0m77Dkf7CRSYJcJHm+euPWh7a9M/XLHe8JDksGkfOfvGAc5kkQJP+JHUlblt4hYSnNmiBgBOO3l
 O6vwjWfv99bw8t9BkK1H7WwedHr0zI0B1kFoKZCqZ/xs+ZLPFTss9xSCUGPJ6Io6Yrv1b7xxwZAw0
 bw9AA1JMt6NS2mudWRAE4ycGHEsQ3orKie+CGUWNv5b9cJVYAsuo5rlgoOU1eHYzU+h1k7GsX3Xv8
 HgLNKfDj7FCIwymKeir6vBQ9/Mkm2PNmaLX/JKe5vwqoMRCh+rbbIqAs8QHzQPsuAvBVvVUaUn2XD
 /d42XjNEDRFPCqgVE9VTh2p1Ge9ovQFc/zpytAoif9Y3QGtErhdjzwGhmZqbAXu1EHc9hzrHhUF8D
 I5Y4v3i5pKjV0hvpUe0OzIvHcLzLOROjCHMA89z95q1hcxJ7LnBd8wbhwN39r114P4PQiixAUAEQE
 AAbQwQWxsaXNvbiBIZW5kZXJzb24gPGFsbGlzb24uaGVuZGVyc29uQG9yYWNsZS5jb20+iQHOBBMB
 CgA4AhsDBQsJCAcCBhUKCQgLAgQWAgMBAh4BAheAFiEElfnzzkkP0cwschd6yD6kYDBH6bMFAme1o
 KoACgkQyD6kYDBH6bO6PQv/S0JX125/DVO+mI3GXj00Bsbb5XD+tPUwo7qtMfSg5X80mG6GKao9hL
 ZP22dNlYdQJidNRoVew3pYLKLFcsm1qbiLHBbNVSynGaJuLDbC5sqfsGDmSBrLznefRW+XcKfyvCC
 sG2/fomT4Dnc+8n2XkDYN40ptOTy5/HyVHZzC9aocoXKVGegPwhnz70la3oZfzCKR3tY2Pt368xyx
 jbUOCHx41RHNGBKDyqmzcOKKxK2y8S69k1X+Cx/z+647qaTgEZjGCNvVfQj+DpIef/w6x+y3DoACY
 CfI3lEyFKX6yOy/enjqRXnqz7IXXjVJrLlDvIAApEm0yT25dTIjOegvr0H6y3wJqz10jbjmIKkHRX
 oltd2lIXs2VL419qFAgYIItuBFQ3XpKKMvnO45Nbey1zXF8upDw0s9r9rNDykG7Am2LDUi7CQtKeq
 p9Hjoueq8wWOsPDIzZ5LeRanH/UNYEzYt+MilFukg9btNGoxDCo9rwipAHMx6VGgNER6bVDER
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR10MB4306:EE_|SA1PR10MB7596:EE_
x-ms-office365-filtering-correlation-id: 42868990-a02b-4d84-7acb-08dd80e79db5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?N1RhR0FCenR0eGU2bGdlUmdiUTJibHluNTZRdjlKYmJ0amdMTVcyYVcwMzZ4?=
 =?utf-8?B?RDltRmE0UXdJRGk4dWc4Sk9MaUJQU1Z3ZEZxdjR0N0FxcDFGeUs0ZGF2dE9X?=
 =?utf-8?B?WE5XeWdaWXdHMExmVXRlUE9DdDZDeTROQ0ZqY3I5K1hZc1ZnaVJMR1BKL2NU?=
 =?utf-8?B?V01hZ2o3SmVTSUxIK0ZtcHNVZHV5YTZheWlCVHJsc2VrcWp3RXNvOExpSUJT?=
 =?utf-8?B?OUZyK2tEbWh3OExVVVZxZVJjZERoMHpXYlUzK2xlcVFpcE5IcjNoSDFJTlZJ?=
 =?utf-8?B?RWZOd2pxMTdyS2hxVGpxWlVEQ0lXQlYvSzB2TVZYSlZMMnMydG9TNFU5WkRk?=
 =?utf-8?B?SWhHcXZZdWs1YStjRVllODJHOUxlRkc1RFdjQUlMc3JQRHk0UzJVRFdvaVVo?=
 =?utf-8?B?MFJ6VHdYN0F6VlFXSkcvRnJ0SkpNOE1PUUNvNUlTbWN4SnRiVmVCOUFNL0Qx?=
 =?utf-8?B?NVViL0o5a1YxbE1ja1VSY082cVJXSXI4WXVmN0JTdnpUS1lrZ2JJUG1kSk5F?=
 =?utf-8?B?THNVS3BVb21CNW9QRDZVZ0JIdDlvVlJSTEQzNFBpaEF0NlFsbEI5ZTN2Rkln?=
 =?utf-8?B?dzdvWTduL0dzeXdZSk1GazN5ZVBEdU1nbC9ub29ReEpYVUdmaHJnWGFYSWp4?=
 =?utf-8?B?RFdnQVNMOVQwUUFLTTZ1Q2xNNkozRXdiYVNOL0VPZG1lakZtYWdZcTcvQ3Mv?=
 =?utf-8?B?TldYa1c5OENKcEtVMDY4V0pra3haMDBteFY1MWtWdTAwbGpGc2ZObk5JdlhV?=
 =?utf-8?B?clNMZ3VSL3Yzd2FkRnd5SmVmekt5bkx0NjU2U3JLVjZkWVhFd0hTWXdkTEY2?=
 =?utf-8?B?cEhWY05sL0RoSVAvR2F0d2MrVmcrbVhoRFcvQUpGTnd6YnA5R0l4TTJ6WkZv?=
 =?utf-8?B?LzBjcE9PVHpXcUhHTThRckpQaURPeGE0U2F3eWh4bGh3VHVjWC9PRHBiTlBP?=
 =?utf-8?B?RGZGWUZoeENyOUNtdndKaEVzaDA0WHlCbWhCS0RlV01OU21XK0xhUWc4anVX?=
 =?utf-8?B?V0RwVE1LZW9Qdm1TUjN5K3hpcDNVY3JFTDRwSEltNnN6NVdJcDd6U3JMYVJz?=
 =?utf-8?B?L1YrZVhlTnExN3Jna0hwTW1WY05KamtHUjJwSGpaQkp2dzY3MHhuNzNLZDBZ?=
 =?utf-8?B?eW8yeTRhQzdXMVN4Mm5VYXhtd01ONkovNFBZcE5QZml2dFZMTWVVTmIzSU5m?=
 =?utf-8?B?THpGdTNzazB0eVUxanFaSXIxV3c5clVGT2phZGtUcGREV0t5WU5BcGVybjM5?=
 =?utf-8?B?UWtqTlNDamxZa1h2Njhrb3oyeEJJVXovbEZmZXRBZzVnZ04zbnMzNGZzYzBm?=
 =?utf-8?B?VnVoMGJ0cm52Z08rK0xYVGdLdWxUemhiSlY4UnpVQnpUOVBTc2V1L2lhbDRn?=
 =?utf-8?B?d2Q2R213RGlIODBuMHoyeU9Oc3VOYUMwV3JrQzJCeU95UEcxaHNZUHkwenhH?=
 =?utf-8?B?L0poU2ljRG1LTkRDU1l1VHNuQm12RlNOWUlPckswdU05L095OUczditMeDEx?=
 =?utf-8?B?ekFxUWlvUmEwMHU5eVdQUTVkcExVN0d6VWtyU1JYZXJpZUFoamFQL25QL3R6?=
 =?utf-8?B?WVUwVi96L1c5dWM5b0o0aU9PQlY1YUp0TmFyYm40WGp6cWJKdWJ2YWxBSUg2?=
 =?utf-8?B?YW5kZ3pOZm85VnFvTlJWckUwUStvbDU4dXFlU1lsWjNGakpCakloRVNjUEU0?=
 =?utf-8?B?cHFBZzlEQnZUVHFjSjFWMkRaUFhhR1ZMOUQzaFAyVkFKQWNwWm5wK0kxM0kv?=
 =?utf-8?B?cGgzcVVJYVRrM2RaTCtnWmtSM1ZVSTVWNGFhVGc2N1h0ZXNGRDduMzFlSGh3?=
 =?utf-8?B?SzFJY3l4UHpLRHEzc2NhMWFXS1ZnajJZZ2tRUUJ4cldFOFN6M01JS05CSDNL?=
 =?utf-8?B?R0xmR2ZxbkdZem9kK3lGZDBUUDh5dzBqKy9GU3pINXNlSzB3alpTZUZsa0Zs?=
 =?utf-8?B?YWl6MjdyS2s5d0dQQmk5ckxIT3R3WFNHSHJ1K05sMGhkbzhnWjFqL09YQlVP?=
 =?utf-8?Q?9TqA7yjUEe4tj+r9cavNld7+d5jWSM=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4306.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?QlAza3ZjT3dkMzFYNDZ3dWdMNmJhMWdnZGtCYS9MdXFJSElVbnc5Nklrbmdz?=
 =?utf-8?B?SzVpQkljakNHbGNhYWRwdDNXdjJGSjlEb0pubFBYbUJtTTVNT1JOekxiQjBD?=
 =?utf-8?B?OVZhMDkxUi93YmxJSTI1Wmd5M2pUSitTajJFczZzMU5Yd1NjdXlObUQ4ZG1G?=
 =?utf-8?B?Y0p2WjMvc1RoVUpJcmpoYW1aaFFCTXRKVUxWVXhWN2xlSlNCOWI0amdpTmEv?=
 =?utf-8?B?NHY3aTZSRnVxTG5VTmpQVURHalF1d1dURmR0YW0vcWFzMWkrNG8vWGMrdkt5?=
 =?utf-8?B?VjN3bWVVaFNrSEM1UWZUTy91bHl2YkRCZWFNZVRTaUZCRmR2UEJ4bHJLa09Z?=
 =?utf-8?B?YXlGeEhLaUVkKzRoLy9WSWdGWGltUTVvNHhPeTRscnNpYUplNnY1dktvaHNM?=
 =?utf-8?B?TUltaWZNQ3FrdmtWNE1pellSYXhiSFladjJ0QkJWTzYybGN0RWF3LzRqVVAv?=
 =?utf-8?B?MTY3R1BvaVhMcllPcFAyK0tmdzJmR2NNYUJMcloxZEFmUzhDTGZ6Z1QzZGls?=
 =?utf-8?B?VE8xVkhTWmRpMzBTejNXVFhqei9RZ3E3YnlRU0lrWVdTOEd3MzZFYngrTmkw?=
 =?utf-8?B?Z1JBWjZSYkxBZVpQdnhwaHd5a3pRMXM0dWg2MCszbHhJWjZGZ3dWK2FvdFlN?=
 =?utf-8?B?Nk1sVGNSVW9yL1ZuU2EweHJJUkRqY3dvU3VPRDRaa2dlSVVwOWNXYnpCTE5y?=
 =?utf-8?B?SGVOQ2dER25NL0RHVGhyMklSYlNTUitVSGsxeTRXSDd6QlNUbFlvc0dhcGpL?=
 =?utf-8?B?dE4vWUJTUWlMOUlnWGl1NERZKzQ0T1BUNG1vWGJRWi90T002OWFRUi91WU1q?=
 =?utf-8?B?V0lOQ3Z2OHFhT2xCS1ZSQ2lEanBqQmdCQ1FUNkRuejZ2SkxJcmp4a1JObEJH?=
 =?utf-8?B?VUlFMllUMnhSYVlKQXpGOVgzSlB2b0l1Y1FhZVYvNEJXa09lTTZ0anhvN2FQ?=
 =?utf-8?B?d3NFRnB5d0llTk9iS0R4MENLTG5HR2FkOVhuTEJtU0pJV3VmeXkySDI2RWkr?=
 =?utf-8?B?eXA0bkVxRXZuVGd1b0J5RmdORlpXRktmQkt6WmdSYVhtdkhTUXZMZ1EzVHox?=
 =?utf-8?B?c2JsSjEwcm0zUEF5SXYrR0lxVG9PaXBWSWI4QXBCbUhicjI1WDVwMGdVdFRa?=
 =?utf-8?B?VnltTE9kREs2ZEpmWEgyaCtTZk11U0J2YkRsbzNhZit3R2dPaVNGRVJ4NHR4?=
 =?utf-8?B?d0V1eGRwczFFRGxBb3QvN2MzYkp5ZUhIQ0RhNWt5bTQrcGlNNGp0akN2RUNq?=
 =?utf-8?B?MXpSN2pNUTdpT0RuZ3BmNUs2VFdXbnIzNXdVSjJtOG80WWJ1Q2xjdDNQNkVO?=
 =?utf-8?B?cTQxOWJweWVadzdrOTluTUk1NXZqQW1LRTkzd3p4cUtyNThvSGZwTzNUOHZ0?=
 =?utf-8?B?bk9PSnlrSXhqdU1ZUFFrVGFydkFsQUV0cmQwOHpqY21hYllNK2hhTE1JQ2ZW?=
 =?utf-8?B?YnREZjN4bUZDZUltbGFqRTZvSSt3RmlDVE16WjBVTkdoOXNnS1dHV3hGKzFl?=
 =?utf-8?B?UXZZTDZFdFBrNzdQYlcvT1RSeHJxbzVGMnd3ZjY2dllkODlGWS81YmdOeDhp?=
 =?utf-8?B?dTVtQ3hFNnlGaDVZVjA1QmFBcEFXdE1hRGVMN0VXUG1wM0ZpUHRlNzYyR0lw?=
 =?utf-8?B?V0pscnhtVVRNbGRNdWFCRDZIQVNtVW8zaXkreVJTV2dlSWYxd1ZOU2VsSTZC?=
 =?utf-8?B?SFRmYnllL1cvR2ZEbnJ4bGpGVGIvNUM1bDVTOU4vaWxNdmRyUnZzd09EL3hu?=
 =?utf-8?B?dFdPUHdtbzNiVWNMaWpPRjI2bHM2Yk10QUFyQm1qZnRzREFJOCthYm5HV3c1?=
 =?utf-8?B?cjMvM3Q5MndsQnlCTmdiaDAzUVVud21Ic1RSaWxlVUdRUlA3eUV0UDlkTm4v?=
 =?utf-8?B?R1VSc1hSQXhua080RWU1cXRYYnROcHozSDFrMENmS29SVDRVMjNNeTNpZ0pr?=
 =?utf-8?B?Q1oycWVzSHhzTHdJK1I1WTl4VW5UZ1RnaW9tU3lvdWcvK1NBckJvczZ5ZmUx?=
 =?utf-8?B?YW9rM0t3REU5VExuN1JMVzdJRC9hakRzeVBHYktGd3M4NWkvdDRmaDZodUNN?=
 =?utf-8?B?NGtsZHVTS1IxeHpVWmtMY0F5SElCazVkb3IxRDVPYkd4SS90V3JTSC9hMGRH?=
 =?utf-8?B?enZTYnVFbjBrR1pTUlhpdFlnZnBxdXdmM081MkViTXJ3a2d5OWxCaEdjeUE2?=
 =?utf-8?B?cUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <62539CA77B8F494FAF9DD4CF5842DF70@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	cT8Lgs7e4vgLft33384ZQyzL+wC8VpXYUDAoYgdnWEnES7LjXyYDsb/hizEvlP0zSZV0kA6gwJ1V73builvt/N74Ag1pMzspvKXnVIkNoL67duDFpzJE4xRXo5FCF8gZz0zLoZguLyK0C2xQnsRCFvsueOypGqAAR09be/T+PhSw5j45VvqhwzcWgDVq6XnObMWHYMxNCbDA/H/pofjtXmuumjViWNot3/F2ZYs6j1lO0avDhoFnuNg4xJORlMHDizQCRYWfuBRdiqA+O22DcUBFRqcddnZorX0TCSnLz9FoAaJoqp9LSPUTy50hzL0Zqhg1/OLSRaTfQN1QFFyiB1aIVqHyGpzKnMkVtQnnRzunh5SjCkEKnx/sZrWAWCvCXqAzjWidgHnPZkCAhrJ/Pf9Rv9ZmDEbc9cxcSoVkBMQmuo/qMzjB/G7riSC6KRw5xWgSKqasSQIExDmYvmZ/N2a+61rzLGYEI7Kcv98BP8uquBbsR7Fyzq1xZbuPB9xNg1Oc1yb6nlpS8/2q4WlX0KQRIDNdDJypbiorK+F9o5RCKhZSLEki8QoYRlMkEokqyEVvjKpOv6eDAfedqdQ3xJg0FOjQRKqkna7SLz2ZF9E=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4306.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42868990-a02b-4d84-7acb-08dd80e79db5
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Apr 2025 15:17:22.8080
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ICe2GA6W2DKBzplFcwhl/d9jantCDXy5pHaj3nnUHeGY/h8Xt1Xb3p/DqbEVxwJg2EX2S3PNvi129f4wDOy9T1osEUjKi2SQwTg9gCk9AMM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB7596
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-21_07,2025-04-21_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0
 mlxlogscore=998 mlxscore=0 malwarescore=0 spamscore=0 suspectscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502280000 definitions=main-2504210119
X-Proofpoint-GUID: XistEyoXUvQAsyYwahDzJBLujrY-OCUV
X-Proofpoint-ORIG-GUID: XistEyoXUvQAsyYwahDzJBLujrY-OCUV

T24gVGh1LCAyMDI1LTA0LTE3IGF0IDEwOjQ0ICswMTAwLCBTaW1vbiBIb3JtYW4gd3JvdGU6DQo+
IE9uIEZyaSwgQXByIDExLCAyMDI1IGF0IDExOjAyOjAwQU0gLTA3MDAsIGFsbGlzb24uaGVuZGVy
c29uQG9yYWNsZS5jb20gd3JvdGU6DQo+ID4gRnJvbTogQWxsaXNvbiBIZW5kZXJzb24gPGFsbGlz
b24uaGVuZGVyc29uQG9yYWNsZS5jb20+DQo+ID4gDQo+ID4gVGhpcyBwYXRjaCBhZGRzIGEgcGVy
IGNvbm5lY3Rpb24gcGF0aCBxdWV1ZSB3aGljaCBjYW4gYmUgaW5pdGlhbGl6ZWQNCj4gPiBhbmQg
dXNlZCBpbmRlcGVuZGVudGx5IG9mIHRoZSBnbG9iYWxseSBzaGFyZWQgcmRzX3dxLg0KPiA+IA0K
PiA+IFRoaXMgcGF0Y2ggaXMgdGhlIGZpcnN0IGluIGEgc2VyaWVzIHRoYXQgYWltcyB0byBhZGRy
ZXNzIG11bHRpcGxlIGJ1Z3MNCj4gPiBpbmNsdWRpbmcgZm9sbG93aW5nIHRoZSBhcHByb3ByaWF0
ZSBzaHV0ZG93biBzZXF1bmNlIGRlc2NyaWJlZCBpbg0KPiANCj4gbml0OiBzZXF1ZW5jZQ0KDQpB
bHJpZ2h0eSwgd2lsbCB1cGRhdGUuICBUaGFua3MhDQoNCkFsbGlzb24gDQo+IA0KPiA+IHJmYzc5
MyAocGcgMjMpIGh0dHBzOi8vdXJsZGVmZW5zZS5jb20vdjMvX19odHRwczovL3d3dy5pZXRmLm9y
Zy9yZmMvcmZjNzkzLnR4dF9fOyEhQUNXVjVOOU0yUlY5OWhRIUs2RDJ2QmUwNDZqeU5kaFRDc3lh
Z25aZEdtUjBkZ1NtLU9wcm13eldBcUtSVlNIMm5ZNjNaRmxLTGltYkxOd0xfQ3hsMkdxTHFXUXJx
dDAyTndrJCANCj4gPiANCj4gPiBUaGlzIGluaXRpYWwgcmVmYWN0b3JpbmcgbGF5cyB0aGUgZ3Jv
dW5kIHdvcmsgbmVlZGVkIHRvIGFsbGV2aWF0ZQ0KPiA+IHF1ZXVlIGNvbmdlc3Rpb24gZHVyaW5n
IGhlYXZ5IHJlYWRzIGFuZCB3cml0ZXMuICBUaGUgaW5kZXBlbmRlbnRseQ0KPiA+IG1hbmFnZWQg
cXVldWVzIHdpbGwgYWxsb3cgc2h1dGRvd25zIGFuZCByZWNvbm5lY3RzIHJlc3BvbmQgbW9yZSBx
dWlja2x5DQo+ID4gYmVmb3JlIHRoZSBwZWVyIHRpbWVzIG91dCB3YWl0aW5nIGZvciB0aGUgcHJv
cGVyIGFja3MuDQo+ID4gDQo+ID4gU2lnbmVkLW9mZi1ieTogQWxsaXNvbiBIZW5kZXJzb24gPGFs
bGlzb24uaGVuZGVyc29uQG9yYWNsZS5jb20+DQo+IA0KPiAuLi4NCg0K

