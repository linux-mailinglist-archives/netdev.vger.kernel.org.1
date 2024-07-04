Return-Path: <netdev+bounces-109169-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F4A4927335
	for <lists+netdev@lfdr.de>; Thu,  4 Jul 2024 11:39:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C11F1F2302D
	for <lists+netdev@lfdr.de>; Thu,  4 Jul 2024 09:39:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79AB61AB520;
	Thu,  4 Jul 2024 09:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="dyTjjbj3"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1BCC1AAE30;
	Thu,  4 Jul 2024 09:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.148.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720085972; cv=fail; b=cIALhinh39nvfrqHw8XxkdhwjEve/ZPrJqYh77+Uq2EBIrsNm82IjPK/CUyU/Py0kgzHcHaSY3yHUEznlQUov4AJ1su1i2Bm3f8RDjhEH+97PfYLhoNalRcaDq4mC3H0LZpS0yzPj69DHly+iraGlf78VhdRGwii1X1r3SZjmxI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720085972; c=relaxed/simple;
	bh=zbyA0mStQ9ZkPn/wiJxryEKlzgUhyYLwtfMIxwkQ+eg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=lyahO66VQIexh9pmPUWaoi3ne4ntbU0uPnuv47H2myqdMgF34dmOVYhXvr+owHw8tu01K6KI+urMxrM2Bufodpc4MziVWjpIGLeuuGVJxAiLfxOsKZ1WVSVGyf/fK+4Z/mBZUdO2njVwNHiHQfSrtcy96KYaw3ImimHA3BIlCIw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=fail (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=dyTjjbj3 reason="signature verification failed"; arc=fail smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4649Imbf008128;
	Thu, 4 Jul 2024 02:39:25 -0700
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2041.outbound.protection.outlook.com [104.47.73.41])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 405s01r359-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Jul 2024 02:39:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SjE7AvximqNUNZjOiQ8lBnenkaFnIRgiZSEhPmIHZozGoeFiuFmF8FQqOOU/sJGMzNoA9XwoITQ43IrdIe1LkTwRIvxnq7NxDlMMUIlu7NfB2tlC+sLHfBr6r9gMha5VH6i+8ivKIQ8YkHbwcpFrbeMAXCn01uDoj9E5psIWhkpbT0Nd5FqwvSfI2PXdy153dQTzOicBvhCtiGe6J8b9EXQTm6waphFlIbmnSEtVTXWuVBAF2fAYBT0bUL3KQvJlcqzhONku5Od/spqPQilQ5W8+aSZLsG0XhRw4aJG6VG7tgBu5yvqzJsZ4Mt+g8mwfMNqDZ1/tQStVT0WXLbab2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bpy7TXEkhagF+kCfWqSYbG24DRQ9ujRxh5G/fWm1KBw=;
 b=R+DEtq+71lxcIOWdb4G6pIZFkcAlnKIU+LCXlKqMatxGV86gDsTv0XY3TbEHBT+X1LHDPsIzuLJKJ2uFOChsOm2s8Wpmlx6CPt5CW7BXqA9VdROt4fWzf2ld6ogPu+DnAApi+Pugtcy9/Qc8YREkXF1RgroQ/X2WFnwrR7kB/kTpalGwCi3uk7MSzu1o5C3vT0EL0AnH64foJjaikWGUh7v+f0wiFbopScWV9oDn9UOwjMYLIOJXNNgcLd1RWdnlFjylTIpPyuH/NCMRYK5ulAugvIZ1LP0uogMK34kl1iE1nYS1iLtcPfdwh1v55/pj+vM8HIxm7rYVqUynbCIZcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bpy7TXEkhagF+kCfWqSYbG24DRQ9ujRxh5G/fWm1KBw=;
 b=dyTjjbj3HlS2J4umSpZMQpbcaHYZWA/fOb+d/Jwa+uHgZMlVeMQdbPp+himjLlHBfORFkbwT/VpAW9mWbvyHJNOMq1Mbe2ZV3GaYzK1K+Pu4S4MHjYeR7POpZTH0KY0N435Z6GgdJJeaXdQj6CrUHSoZV+dwQh4VO3wmKa85A08=
Received: from CH0PR18MB4339.namprd18.prod.outlook.com (2603:10b6:610:d2::17)
 by SA1PR18MB4694.namprd18.prod.outlook.com (2603:10b6:806:1d5::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.30; Thu, 4 Jul
 2024 09:39:21 +0000
Received: from CH0PR18MB4339.namprd18.prod.outlook.com
 ([fe80::61a0:b58d:907c:16af]) by CH0PR18MB4339.namprd18.prod.outlook.com
 ([fe80::61a0:b58d:907c:16af%5]) with mapi id 15.20.7741.027; Thu, 4 Jul 2024
 09:39:21 +0000
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
Subject: RE: [EXTERNAL] Re: [net-next PATCH v7 06/10] octeontx2-pf: Get VF
 stats via representor
Thread-Topic: [EXTERNAL] Re: [net-next PATCH v7 06/10] octeontx2-pf: Get VF
 stats via representor
Thread-Index: 
 AQHayWAV6jXo8y46g0ScG9IqbaA7qrHiyOOAgAA3YLCAAHxYgIABPyaAgACgcQCAAPyoAA==
Date: Thu, 4 Jul 2024 09:39:21 +0000
Message-ID: 
 <CH0PR18MB433980D41B8E77500CA9D3AFCDDE2@CH0PR18MB4339.namprd18.prod.outlook.com>
References: <20240628133517.8591-1-gakula@marvell.com>
	<20240628133517.8591-7-gakula@marvell.com>
	<20240701201333.317a7129@kernel.org>
	<CH0PR18MB43395FC444126B30525846DDCDDC2@CH0PR18MB4339.namprd18.prod.outlook.com>
	<20240702065647.4b3b59f3@kernel.org>
	<CH0PR18MB4339BC156F808A319D1C8461CDDD2@CH0PR18MB4339.namprd18.prod.outlook.com>
 <20240703113318.63d39ac4@kernel.org>
In-Reply-To: <20240703113318.63d39ac4@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR18MB4339:EE_|SA1PR18MB4694:EE_
x-ms-office365-filtering-correlation-id: 93d62342-3399-4e98-cfd5-08dc9c0d2f13
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: 
 =?utf-8?B?dk5oMjdsbk90eVYxbE0zUWs0U3BCS09zVmVWci80TGZXTFJ3Vm4xa1RIK2Rt?=
 =?utf-8?B?VU1BcnRhc3dUL2cvdkJwa1ZKd0JnUm1raWl5QjhKcDNhWGFBMURkQ2FLcXg4?=
 =?utf-8?B?WFgra1N0VXAvcEpKb2UxZlJ5TXBkc1g4UjludVpNdzRFaEl1aVBOcGhmK1kz?=
 =?utf-8?B?L1VQRjBsM1RGOWIzSzJLdG00QmdpbWVYcGV4b3dSLzJKN09ZRlZFOU1Vc0VF?=
 =?utf-8?B?a2ZRb1BlV08xeXVORUNqem9NWWpiYWxVRzRzbHlsZTBNTFRqbDEvZm5MNHJP?=
 =?utf-8?B?VnFFQlErMzVxelFXdTgwQ2M3cnJzaWY5UlhFMUNzajZzOVNCR1U2c09WaGR6?=
 =?utf-8?B?U2FSZU1QWEVHWlM1SkQ2bmZUaGRPLzd1MElkSTc2NGFuSjFCcGYyZTRUUkdS?=
 =?utf-8?B?STlwUU8rTmhUdEowYnFNZ0tiSHZ1NU9zTHJIdHcrTStXVFBIelVOeklsM0F0?=
 =?utf-8?B?a1JsMEtkL2ppMjlJaXc4clVJbUZML3RzMHY3OW0rUlB4VlJkMis3Nm9mZW1M?=
 =?utf-8?B?N0hMUUVJaDRyVzVwbkltOU5IUDU5NTU0Mm9sazRMNW9iOUVMbXFOZFpmck5Z?=
 =?utf-8?B?UjRqWE5nd095VWNVK0ZiMEVvcTB3dTR0VmVwaGJMZDlVWjdjTXJUMnBxcnAx?=
 =?utf-8?B?WFlQRnFVUjhyMjFxTmxOeUdDNVZFTzg1di9hS25tWGNJT3NYQXVhWHlxcG1q?=
 =?utf-8?B?UXNXTnJ3Ty9rZjFvaExCU2xIRlpSbzBodlVFalZVQm8vR0tXU3U4THQrL3Vu?=
 =?utf-8?B?bUxwVW1TWnBaZWFHcW5UOUx5QjBUQXFiTDdCWDhFeVF1M3VZaVcrK1BJYjRz?=
 =?utf-8?B?dndUZEcwK1dzazVhMjhEaGlIb0luTGd5QnNoMkZYc3J3cmtzOU1jencwQzl3?=
 =?utf-8?B?UFd0Q2o1M3JtOXdSTE5nbDhMSUVST0JSYWt6U1JOcVBWQUZuUDZNcEd0M1Fx?=
 =?utf-8?B?MWQ5cFh6K1Y4bG81ZXpwQ1U2QmIwWFNSR25GdTFOeUs5eXhOVzZUSjBHRmlm?=
 =?utf-8?B?aHZtZktzRDRMekNhb0E0bHRRRUNTcXB4MURDQTRMZk05dTc2NmlRQnlnaTBv?=
 =?utf-8?B?djFETWFGUUdxUlBGa0poanJiS3FKNGJuWm9kK0xrcG1LMzBkeFh2M0RsL01N?=
 =?utf-8?B?OEVsSnpnS2ZaZ1NHOGZQTDZHUEVrd2dNWThIdlRNcWNZZkkyTE1Ub0pjR3U4?=
 =?utf-8?B?d1JKQUUwTS94Q1FaczNmNFdsZmRKQ09CZGtGK3RDUHdjc3Zxc0EvRDRUOUM1?=
 =?utf-8?B?QWVKdjhQUjkzOTE1bmtDSk9JaTFQTnZsTnhhcVA2RUdxY2h5Tzg5TGhUOTNQ?=
 =?utf-8?B?ZVNybytZUzIzeTdzSXhNS1lzdWdrY3NUNTVSNXB5UGNUNGlIWWJRZ0hXQXNl?=
 =?utf-8?B?dSsrcXNkYnlzLzY2VkRFZkgvQlBodnpFcjlKUXFnTjROYkZCTU1RY1FzMUNS?=
 =?utf-8?B?Tll1eVl1Y1N3enZac2dzRU9ZVlg0TDEvSy9DMCtCekJaVEFYMUZsK1ZUZENT?=
 =?utf-8?B?RXBxd0RVNUFPdUV3N3hwdXE4VXZxcVR6Z0d5NGM1OXFEZlFlVnBZOTZkZzFh?=
 =?utf-8?B?dzBSR0hKdUZjN1kvWUVxWVpNWEtxS21SK0pKMm1wRi9ZSlM1MURxTHRScys3?=
 =?utf-8?B?SWdpQStYYnRjZkZvTzR2amRacktYUW81cTE0MGdUcHRHZmZCdUN0UHllMndM?=
 =?utf-8?B?akFyd0lFNlRFSzEvMkIyNmJHSitNS0VyRm4vUGE1ZHQ2RnpDZzhydUpUTWlP?=
 =?utf-8?B?T1lqODJvQ0tVT21lT3RJTjI0VitHd1FQMFpQSmtzKzE3d2FCMG5QUS8xenNX?=
 =?utf-8?B?bnk4VFF3YkIxbE1zd01ZU1RKUUtOaVpua25YVHFOUEZzUU45UDZhSmFVb1l2?=
 =?utf-8?B?TTQ5UEttUzdwMzFSd2swZkNGOW5xL3duSmwybm1XdklSa0E9PQ==?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR18MB4339.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?K0l0T3E5RXJTekpISldESTFTVElFeklRRzU1VzA0WGY1dFIvUGZnNCs0RDd5?=
 =?utf-8?B?b21LWCtHR0k1WXNKZ0xZNEFoZitJUmxwdzNnZTNpUnlIUTQzZU44alV5WWVY?=
 =?utf-8?B?ODl3SUdUZTh1UTVRNUxnbDhNaG5Qb0Z2YjNhVzBlM2hCd241NktvZnNJY2pS?=
 =?utf-8?B?c21PbXBERGhGS3M4YnhsNkticFRzZVFhM2pBaU4vV2hYU1JVQlN6aCtWWGhP?=
 =?utf-8?B?VTZ0WldXRW8zUmpRMTlqWVc5VXR0NVR1QXpSZkU1eFZGSTREL1FEMDVnR1Vn?=
 =?utf-8?B?RDRqZU5SeWdrbjRXcE04N2JOSmpwamM4MjFpRWQ3M1c1VWNsMFB2clhDbVZX?=
 =?utf-8?B?YkVTSXN1VXFXMXpER2NMR2lBaWNRdDAreXBRelg4T1FKbmRKSm4zcGNyWnh6?=
 =?utf-8?B?eXppZGxoY0pHSmlYVjRUcWV3L2ZnNm8xK0VWeE52VlFGZlh0SFUrQytvYnRM?=
 =?utf-8?B?N1VidExBYzJlM1o4SFc4SHZNU1NXV0pjZ2NrMCtFM0NDYm9vMFlveCtPU0R4?=
 =?utf-8?B?eG1ZM0F0ZHhxRDZIVUlhdEV6bmhPbWZOOHZZVUdJc2ZETG9LeExDcTNEUSt2?=
 =?utf-8?B?QkpoNXl3R3IzcU1HSUs2Qk5zWkhCUmZKNDlTTEloQVM1eCs2eU0vOEF1TDdO?=
 =?utf-8?B?TnRxUnp4UnlrYmVnYUZWd2E1bG1BbmgwZVVicm9rU0hkTlEzZ3FLWXU5RFlJ?=
 =?utf-8?B?RHhOUkczWFMreThJR3dSZjI1RFlrU3NDK0VPeUZmNXEza0ViQzVYWEVkeU5z?=
 =?utf-8?B?cmdqYkkxVmt2UjVYeEdBd1poUkVqZFZtT2FVcGlmbnhyWDVBMHdCellwUDZi?=
 =?utf-8?B?Y2NmRlNOYVNlUEhITnNtZUpzWnIvRUc4dENuZjVUNlM0WlV5WGFjS1JkM0c3?=
 =?utf-8?B?TnVRQmxsQWdHYTJnVlpFOHBEeTlRdkY1MWZkOW1MNWVjSFdtb0VVbWlBSmJK?=
 =?utf-8?B?VGlyTWxjdVpWK2xaMzE1U3FSUHB6M0JKZ1Zhc2k4ejYwMTF2NnRqSTNEVkl0?=
 =?utf-8?B?YXpTWE9sZjExeGJRNzRrRUErU3ZseHVQOVNJaEFHeFZhVGNJZmsvUDZSeEMy?=
 =?utf-8?B?cEhVUTdaWUV4aEpuSVVVbWNsSGMvSDdwNk95MmJmblVZVmFGUFJkSTB2ZkE4?=
 =?utf-8?B?MlFBeVZxdXVUaW5KMG5DZ2FkeVB1WVdBdkJtWEp2TElvMjM4QnFPczFtaUh6?=
 =?utf-8?B?bUVmREdxRWlLYit5SEQ4Q2xsamg4NlQwRVNxeVF0bmVJbDZldEVVSzZ5WmNk?=
 =?utf-8?B?em91VGE2QXRiUGhLWXcyQnVhNDJ0L3p1TldoR0FzaWZrTk1OWUdQOEsvRkVj?=
 =?utf-8?B?dGR0d3lKM1JnVmNHcmRJQzk3K21zQkxlSTBDQTh6VUIxWGVXTXdkZDBCUUEx?=
 =?utf-8?B?a21yTXpEWlV4VUYyY3JSRG16Z1dRQlF6Ymh3SmhFaWlwOFkvVHlNdnFFYUtw?=
 =?utf-8?B?VThoVGJwRzhZRFFmZ2V0elRNT1BOYnNUWmM0QWZTZEZwU253UlV6VzhpeVAv?=
 =?utf-8?B?ejdWUU5SUG9QTyt0b1cvQ2Z6RmFxc0NtUWEvbVdwYk5MOThMZ0duR3VERlBK?=
 =?utf-8?B?Z3lqOFR6R0wzV094ZlJSVHd2TkhwbUpGTjVyNVZnQUliTUVaamwzZ0xpcFBi?=
 =?utf-8?B?ZkpnWjJhdUh1WGhBdS9ES1NzZXQ0N3UvaFhQZFMrTFJmYkhhV3l1SE1wUXZw?=
 =?utf-8?B?WTFaQkRBYWJhRjVHRmd5b0NPQk8wUHlCZ2Y0bEM2TEFWRWswbFZOU2hPYy9y?=
 =?utf-8?B?SVVjcmQzMG5ncW10bXRLcit1L0hMN29sR2FmY1pybXV4YWFrR1BOdHFJWTNi?=
 =?utf-8?B?UWpBRGlQL0VqZU1IbjhMVXRWYWVqRGlYOG9PZFg2VkJnLzg2OU1pREw1R01Z?=
 =?utf-8?B?YVd2K1hKYkRhZUIydERnZTJtY0k1M1BVZS9ReFdOU0RROU5MTmFGT0NSWDFQ?=
 =?utf-8?B?WWJ0WjIvSUd0T0dETzFxckVjYnJzZnhwSDN5SC9kQTJIVjkxTzlwS2hEbC9H?=
 =?utf-8?B?T2w0a1F5QkpkS2JzeWRiYjdLd3N1cGdCODhPa3MzYXN3bm8yVlpYRWovRFVi?=
 =?utf-8?B?QnJ0QzhDbUtuUTl3RTVEdFlobmlnYm80U3dySTd6QjI1S1BHaHl2VlM3cDgz?=
 =?utf-8?B?V0t3d0RGUzcrN2RvQlVEMTBqcmR3RGVQZDU0OWhlTjlVQUFwSFBIZmVmbm5j?=
 =?utf-8?Q?hZ48EErZxj+Ke0NYXB8k+yaBG6H8Q4DtdjRYBGf5YN9p?=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR18MB4339.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93d62342-3399-4e98-cfd5-08dc9c0d2f13
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jul 2024 09:39:21.8073
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7wlebgZ6mRSKgjLD9zHX6MIN8qpTAPTI/j0InTU/1SotGlscWbKiYeZCWAlD5M1pMviOHCORWxPshuvBqyqaqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR18MB4694
X-Proofpoint-GUID: Az-x6YYyny92rbZ-HY_juFmfF4RnFNXA
X-Proofpoint-ORIG-GUID: Az-x6YYyny92rbZ-HY_juFmfF4RnFNXA
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-04_06,2024-07-03_01,2024-05-17_01



>-----Original Message-----
>From: Jakub Kicinski <kuba@kernel.org>
>Sent: Thursday, July 4, 2024 12:03 AM
>To: Geethasowjanya Akula <gakula@marvell.com>
>Cc: netdev@vger.kernel.org; linux-kernel@vger.kernel.org;
>davem@davemloft.net; pabeni@redhat.com; edumazet@google.com; Sunil
>Kovvuri Goutham <sgoutham@marvell.com>; Subbaraya Sundeep Bhatta
><sbhatta@marvell.com>; Hariprasad Kelam <hkelam@marvell.com>
>Subject: Re: [EXTERNAL] Re: [net-next PATCH v7 06/10] octeontx2-pf: Get VF
>stats via representor
>
>On Wed, 3 Jul 2024 09:=E2=80=8A08:=E2=80=8A13 +0000 Geethasowjanya Akula w=
rote: >> Could
>you implement IFLA_OFFLOAD_XSTATS_CPU_HIT as well, to indicate >> how
>much of the traffic wasn't offloaded? > > Will implement while adding TC hw
>offload=20
>On Wed, 3 Jul 2024 09:08:13 +0000 Geethasowjanya Akula wrote:
>>> Could you implement IFLA_OFFLOAD_XSTATS_CPU_HIT as well, to indicate
>>> how much of the traffic wasn't offloaded?
>>
>> Will implement while adding TC hw offload support for the representor,
>> which will be submitted as different patch series.
>
>I don't see why we need to wait. Offload is the opposite of the stats we're
>talking about here.

Ok, will implement in next version.=20

