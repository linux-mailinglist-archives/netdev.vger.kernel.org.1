Return-Path: <netdev+bounces-248529-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E36ACD0AA0E
	for <lists+netdev@lfdr.de>; Fri, 09 Jan 2026 15:27:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 78CC2305CA91
	for <lists+netdev@lfdr.de>; Fri,  9 Jan 2026 14:25:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F183B35E530;
	Fri,  9 Jan 2026 14:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="eN41+Mss"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 892D81A238F;
	Fri,  9 Jan 2026 14:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.148.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767968753; cv=fail; b=mvYMWvBpa/qwAlpKVn+8gpF8ipXw9YzxUur5oemQd9PG48OxJOiBx7IeFKogkOMSVw1y8HFg1bOGOOEULBZ8NukXxJkHl+I3mwBCLG2wbUl7UD4MztdRaJyjyd6zoinNCmB0/muFXNf9EU1wd+LhiqfAdRz+yT1po4kCulYyUI4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767968753; c=relaxed/simple;
	bh=KTwzpIEeejDRvjWq2Wv8AhaGYi4LxFAkuT1lpv4ctYw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jq/l1jdDH30TMXFCnWQkr8m4u0MHEhLoEMWxuxnfjvfbNoggcK7tOl6pYW8Tbw3bwg2nRrJiyPmGV9XmTS3QxyzaezHgCRm/hPBWcZ/yNTf6wBmdIGNs5NHgWyWtyS/C1o2fhG58Pr0gavCeTXuxAxaEgqlEZr96QZFScrNX60g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=eN41+Mss; arc=fail smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 609E4T5N2938365;
	Fri, 9 Jan 2026 06:25:43 -0800
Received: from ph7pr06cu001.outbound.protection.outlook.com (mail-westus3azon11020134.outbound.protection.outlook.com [52.101.201.134])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4bhwh2w163-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 09 Jan 2026 06:25:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EpLyRGxz9159UZRjFfmgkEr0GnnJXaBXKSMXt2PNiQfw+Oj56XgZKGPJurWQjNSOF1P4F3l2IWnP6dYWoUF1lOkxxEocpLTSjUkD2RBE/IWONmb7qgr2+gG6CZWSXhXrA8DABNRKFkVf42UgWjbPSlSn+n0klm8qaFg9XzFtkzzXBz5T6vnw7IKuptj0DVqIEItSOV2vbcm1QL6FQF/nl/adtXxi+CozjmeBaLw4ajVRyAUGRQGrUkgFufZzWI15Los1LNbs/L17uLkZnws2ENYXONznx2vordeFpAx3qK6uVl1OAiGP8hxPuE+1M/HCUqFlV/F+DFdo9sGLnA/Lzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KTwzpIEeejDRvjWq2Wv8AhaGYi4LxFAkuT1lpv4ctYw=;
 b=dUJwEQS1rNCv8/idcB2rVjzigSwtMMd+Gbpl0+vO1XeI5zoXIpTw/cK921/d3k88Po/rzkC/iDx1I/R1SYIFeATnoe5EOAo6eAInvOBK+9jthuMDMeRHtNTZ1Hef8LBcU/NT0OjRGOWfuADUDICxIDijFX57F0JerquvfVpNfUK4G8b5U07HbukGsIWW+JrIAzjwxEzwZ149cVy41eAl+ZE6sgDQaI/x2q9/Mkbu/Wl4B7I/F3fkTEYCZ1nFe8/KNH2UfCX5HPxwdqeuAifZvz0t4umdPRmIUEIcpaTJ3kQveeKIXe2lfYU1ypMNY8pJ3cRgGnPoD8aVeXCWDLXAJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KTwzpIEeejDRvjWq2Wv8AhaGYi4LxFAkuT1lpv4ctYw=;
 b=eN41+Mss1rr7Y65Jl0pPWZlWVk1I23Lp2ZbY80Ms9eI0L/XKKk8MZoTpPNZ1+GAmzqzvR4xbmxSPq3ZpFRuNtl1Y5TLTlRRPV6akXR1SZZUtVCO3Y3QGGGyEGW9qy73wqmWK7rIn7V6eUdbEzMTMBUrRzxZxLJhVZDL2uo82uj0=
Received: from MN6PR18MB5466.namprd18.prod.outlook.com (2603:10b6:208:470::21)
 by SJ0PR18MB5037.namprd18.prod.outlook.com (2603:10b6:a03:43d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.5; Fri, 9 Jan
 2026 14:25:40 +0000
Received: from MN6PR18MB5466.namprd18.prod.outlook.com
 ([fe80::bf0a:4dd:2da5:4ab2]) by MN6PR18MB5466.namprd18.prod.outlook.com
 ([fe80::bf0a:4dd:2da5:4ab2%4]) with mapi id 15.20.9499.004; Fri, 9 Jan 2026
 14:25:40 +0000
From: Vimlesh Kumar <vimleshk@marvell.com>
To: Paolo Abeni <pabeni@redhat.com>,
        "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
CC: Sathesh B Edara <sedara@marvell.com>,
        Shinas Rasheed
	<srasheed@marvell.com>,
        Haseeb Gani <hgani@marvell.com>,
        Veerasenareddy Burru
	<vburru@marvell.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller"
	<davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>,
        Satananda Burla <sburla@marvell.com>,
        Abhijit Ayarekar
	<aayarekar@marvell.com>
Subject: RE: [EXTERNAL] Re: [PATCH net v1 1/2] octeon_ep: avoid compiler and
 IQ/OQ reordering
Thread-Topic: [EXTERNAL] Re: [PATCH net v1 1/2] octeon_ep: avoid compiler and
 IQ/OQ reordering
Thread-Index: AQHccLlQ3GvyfvdkTUyVidEYACbE+7U42zwAgBEqDZA=
Date: Fri, 9 Jan 2026 14:25:39 +0000
Message-ID:
 <MN6PR18MB54664C5630DDD9D2D1380495D382A@MN6PR18MB5466.namprd18.prod.outlook.com>
References: <20251219072955.3048238-1-vimleshk@marvell.com>
 <20251219072955.3048238-2-vimleshk@marvell.com>
 <eed3d1c1-7b7d-4aea-a816-2046cfa88529@redhat.com>
In-Reply-To: <eed3d1c1-7b7d-4aea-a816-2046cfa88529@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN6PR18MB5466:EE_|SJ0PR18MB5037:EE_
x-ms-office365-filtering-correlation-id: 0d94c494-bd80-4814-912c-08de4f8af6e6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?Zit3Vk9wM29aYzNTRmVXeDZmUGFxdlJhS1RLcGYwZjMraklCZDlHRWlyaTdt?=
 =?utf-8?B?dWp2REhUb3ZhdC9KME8vL2p0UTJhblV1aFc2Q05HTHZrcHFvNjgxWVNkKzFB?=
 =?utf-8?B?aTdzcDVyd3R4NGtlZ0ZHTmo1d3NNTVg0Z1U1akVJZUdsQkpsbExoQmlRNzlN?=
 =?utf-8?B?OEFkbWZtYVBRV3RkdXphY2UydXhRK1dBellkYVFiczh0Z1pLbk9udkhuSTVo?=
 =?utf-8?B?dUdSVUFFY0d1L2FMWmRMc1c1cFUwT2Y1K3dKUm41SEViMnZQTzlGbHBSWkFa?=
 =?utf-8?B?TnhIRkRaWEs1ZUVwNnM1OXc1WjlXdGJ3bVBRWFBDbS9KZG5SL2Y4KzZ0OXZ1?=
 =?utf-8?B?aWRmam5OZ2xBSnkzdkdNdzdST0w1WmhJRldwcmU2MjNENnpBdmxqS0xDb3hw?=
 =?utf-8?B?eXlMaUpoWkJnd3pjMnRFcnJWRmRIQnpBaFVYdHV2djdSdnhPNG8vSUZaTTd6?=
 =?utf-8?B?am1zK2RHWTBBL3daOGpVZmRheE5NZkk3OW5lOFoxSTRzdHlSRUdBbXZGNXVa?=
 =?utf-8?B?Sy9PZVRwb0tnR0tiWXBmd3Q4SXNOZzNHaW1KTy9zbkc1REdkQjhLQ0lIL2wy?=
 =?utf-8?B?ZUJRYnlxbW84VHc5S1VqZWRTSXNJQkJ2Z05lT05TMUtDaHFuVzJqakdxaDB3?=
 =?utf-8?B?MkNDNnZ5ckY3ZEEzZ21mS0QrT0ZLRXdqUDJTcGVocmRqY0F6aElkUVloUyto?=
 =?utf-8?B?MnFJL25FN3VkWDhpdmE4bWVYS3JwVHhTTVZzTmxkUFVVK2U0UEM4ZUtZSlpU?=
 =?utf-8?B?N1RNbzBaeGhSVm9GcUpVaUJUSUxCWmNxOUxuUldUN0tKTGJMNEpkWmI0Zm9j?=
 =?utf-8?B?d1FrSW5zUkZvd2xkaW9aVWRBenU5d1JkaFJHSEVHK1gzRWNKK0ZxVGhOdnMr?=
 =?utf-8?B?a0NmVHhjWEczd210RWdyV2xYeFNXM3lTeGM0eFAvNFdtK3pCbjNoUllEYldl?=
 =?utf-8?B?T3orUHlWVUFHaDZXdVRiUllFbWVtQWx3amJJa3QzZTI5S3JScEVhQi9HbFRt?=
 =?utf-8?B?NkZhTndmeFU0NzMvT3pWZEVkVDJqOVpHVGlTNW1iNHFrSXBDODdtd2pRdlhl?=
 =?utf-8?B?RWNhazIrb3V2Vys0akQwNjJ0WjRlaTRUUHJyVW1BMDR2ZFFRNjJDM2U2WU5I?=
 =?utf-8?B?NERIUFpnSXZIN25DaWFYMlNoTVNuaXl6enlwQ2h4MVFLRm91MXZUWEZaazRl?=
 =?utf-8?B?ZzNiUFN6bnZlQ2lCd3AxTlI3clI4MFZxSFA4Uk96NmZDVHEzYlJIS2Z1VVBC?=
 =?utf-8?B?MWd6RWU0RVlXYlp6Nkx4TnArRVpqbjlpeWZUQjFqS1ptNFRYUjRrNWVtR1Vo?=
 =?utf-8?B?ZW1pbHdVVDdDSEcyZHNEaUQ3MEFOcWNEaEJha1ZKb2FOaU1QbWpnNGx3K3dH?=
 =?utf-8?B?a2dlTm82TjV0d0gwend5am1mZU55MVZPa3daS1VybXVVT00xZ3hjRU93dTRE?=
 =?utf-8?B?UjBoVE9Ody9BWHJmUDVleHY2ektmQlQzMHVlZDhQdmpxWktTU052R0h1WTFt?=
 =?utf-8?B?Y3pXL3lKYmtPV3hOZDZOYkJnMmd3UnlCRmdJWjdqUUxrb2lnMEVBUEN5V2NL?=
 =?utf-8?B?MDJLaXpyVjVkVS85bVdRbGJzSnVlV0wwY1hoTjVQUk9UNVBpbFQ5ZkFYUWdz?=
 =?utf-8?B?d3ZDY09YUGZPWmxTK0JIQUQ5MVZhSjhLV2lDcENRTm05SjNxVjFNQ0V0N01z?=
 =?utf-8?B?SG9YNUw1c29PSDQ5dTdnNUplcVlWNkZLeXYyMkF5aHZkVTkyRmNDdFZHS0w3?=
 =?utf-8?B?MTFTc0IxOUJueG1FblpYT2ZRN01zWU9FeWNKeWRITkVseERleGhNS0FFNkxy?=
 =?utf-8?B?Rm00VGRpWk1UVHhWN0JmWDAwa29SOW13TVlVLzQ4SVloVW9jWitRWDE1QVNB?=
 =?utf-8?B?UDdPQkJoNkh2bCtybGtiSFdyUFVCdlZ1V2IxOFBUTXQvWlFvSUJORVVvWUtr?=
 =?utf-8?B?SHlxR0RzTWg1TXQzenV5RkxOQ0d0TmIrZ2Vja2VOYWdybGtNQWlaaG9RNkZl?=
 =?utf-8?B?b1BEQlVFd1ZTSno1L0YvbEtxRWVURlNXd25OSzhWV1VlK25tRWJRRFhQcjY3?=
 =?utf-8?Q?+MiJ7A?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR18MB5466.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dWFIaS9Mem13bCt5dXpiWUxFOGRpVW5TZDBPVVRyR1ZPWEdDaHp4WnljblRR?=
 =?utf-8?B?bjVHVkVnSzhpRlNocVNGbUpnTGN5YnlyZDVVa1pHYlJYeVMrenVnd0RXSDIx?=
 =?utf-8?B?MGJyMFhVTFBTU1FMVWlxRFhhbTVNdHZVZVRaWG5qY0xoSkttaEN6Mko5dFNX?=
 =?utf-8?B?UkorZkNqem5aRS9sTCtUOEpqeTBmSUZoVXphNDRTKzRmU3pDbnNiTXR2ankr?=
 =?utf-8?B?Qyt3TFFGVFRZWWp4ZmhjeTU3MkZMeFdVZzVJUVNGb0hXMHJLa1JQL2pYYjg3?=
 =?utf-8?B?bUF5czFBOW9Rc3VzYkJZRUhvUXBLR2tjdFFKT2FvTzFoOFVKWDRvZFJkbVVT?=
 =?utf-8?B?TXRUamQ5bXdzaFpiYjVROGRQaCsyYmhvc3Zmd2tVcWJvdEJYWDkxcEYrTisx?=
 =?utf-8?B?dGx6RHltZEhuRHhDcTBncDZNcmFlSHNNK0p2OVYyeE9wT0JDM09USlVzQmtz?=
 =?utf-8?B?S3VyT1lLK0I5Z1p2eUN5RTB5cDJPWGhEZVlqb1dCeERCanJ3NlJUdUNXYnZu?=
 =?utf-8?B?NEtNeHlCM1lwQzFFbytUa2JiaUNSWWNpdDZoLzNlS1cwSTNBQVE1WDkwQ00x?=
 =?utf-8?B?THBPNitBTUlNWVB1MEQ0VVdkRnFiRWNGYTV3dTh0MVlLU1oyWTg4N3dpblFU?=
 =?utf-8?B?WEUyOGl4enAra2NkRGlWMHlVMFV5cUpuQktjQUVGSGZndWEyeng1b2l3b0VP?=
 =?utf-8?B?MlVsU0xwdzJ6UVArUFRsdld3a2pGYjFkRGJXRnFsc1RDMGRvNXVHMHpSVVNm?=
 =?utf-8?B?VGlubFpPVzhhaDhiVWhhUkM5U1F5QVNJdHU3SFVGampyaGVWcnlkSzlKRlRj?=
 =?utf-8?B?Qm5YRUM3K1ZBcW1uM3ZJbG1ZMnQ5NWdZWU83SjczdElmcm1remJsZlFzd1lG?=
 =?utf-8?B?UFl4c2wxWWdTVTJKTnQzUnFpWlpkK20zWWc0aC80Yk8vdDRKcExsS3BWelpV?=
 =?utf-8?B?QnpDbDdjWnRrU0lrQ1ovUlVvbEUvZ3hEYUlTL0NEUkNGNWNKakdhdTI1a1Fy?=
 =?utf-8?B?dFlYNnUyY0NhUllaWUd2aDRXNEo1VGNBczhvNU5xeXVrL3MvS0ZlVndMZVNM?=
 =?utf-8?B?cmlxUnlHTk1VallxZjIvZVg4LzNibmRqbUpSRmdKUHhmUC9SL3ppYTEzKzZD?=
 =?utf-8?B?bVJGRkE0TnIvcWV1aTVuOE11K2l1OFEvZEhVTmg0TWZ5MXg0VkNGQmxIbFEz?=
 =?utf-8?B?NmxxbU43elVQc0dUTjhtUSs2VStsRDErc1RkUWJ6NWJlYmFpaWl6emFPbVM3?=
 =?utf-8?B?RE9DbktxRGJhWitBOGhYVGUzM0lYQVdiSGNYV3EwQmJka2lBN2ovak9YdHNn?=
 =?utf-8?B?ZTJFdnJ6V1M2SmpNMWtIWUR0ekg1MXRFRkNWZ0tVZmpSQWdobU1zbEY1V3BZ?=
 =?utf-8?B?bUc4RWsrTUp4ZEs2TlBGVzBJMTdPcDFKUjkwaUNScGdOUGFoS1JNQmJIOTli?=
 =?utf-8?B?WGYrU0tzTWNXSXZKUE9Mdy9ieE5BeVNqMDhNUFlrU3pmbFZyalVOOGt2RnNt?=
 =?utf-8?B?dC9EL1lhU091dEVXQmZhNnpybEN6cHR1Q3FKMXpIalNSR0FER1pxK0Q0UTlT?=
 =?utf-8?B?eU9FcFluR0s3am9mQmU0enphSERWa3JWV3ZaczFwbEZkLzU2RGVhallycmht?=
 =?utf-8?B?Ry9NU2R2UHpMdHVVdSs1SGE3M1FuVURUWFM5QTNaSGdKWXFrbWFNZnBKRDB6?=
 =?utf-8?B?UE9mMlAySGtMRWtrSUFTZC9SYlBZMjNORXJicHJvUndpSFRLMlZkZnlhN1l5?=
 =?utf-8?B?THJ2MDJKNkJRdUdiSElKdStYZ1hxUysxU3QxcFlLTjBRS0VXNEtpR1pOS3FI?=
 =?utf-8?B?TjFGU2E1Tm1MZ0doQlViYjRmRFRaK05MVDRiREZkMnU1YjQzbGxQald2VzA0?=
 =?utf-8?B?Skh5MlhheGJwTHEraDlFSlFIanF1ZWZhR2NMRlFmV0lJb2dsOEJRUEMzMks4?=
 =?utf-8?B?WmNpL1BXZWhYbU1vNFJZL0lyakVGa3pzb0tSWmRpbW1xTmlxQWNuSmdIVDFW?=
 =?utf-8?B?NlM3Ly83YlRZc0Q5M3duWkZkMUpuMzJhMndFVVplVzViSHV1VDg1czRzZ2g1?=
 =?utf-8?B?eFNMQ0RJaXdhdi9LTTZaaGFMZEU2T1M5VWRiaGJZZGR1YndvOW1qK3d1ZVdG?=
 =?utf-8?B?cWtseXdwNEF2VEdVejRzVnpVbmtiemNtRTlxdXFidWlSNEp3WGlLRVp4TExL?=
 =?utf-8?B?RWR4S3lTeFFnM0U5b3M0d1BtRXB2MzVyVGttVmR2K2lKaFVjOVluamorcjRW?=
 =?utf-8?B?SllMRjZEcUZDcnE3N1B0R2NOT1E4cnVhbWtqSUVMQkZta0NNTURkOHBWa1RV?=
 =?utf-8?Q?lapkA0U5F/564jjKPG?=
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
X-MS-Exchange-CrossTenant-AuthSource: MN6PR18MB5466.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d94c494-bd80-4814-912c-08de4f8af6e6
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jan 2026 14:25:39.8929
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NkH61dQIONg/usP6vS6N5fm8F40BhMAj2UsX51Jmqv7qJSm2QFeX2x/DacIKNzP6tkGm3e83P/lQaUmI/GstOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR18MB5037
X-Proofpoint-GUID: kOAALnqTOurYYjN4x5ciqM-djQ2SHFQx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA5MDEwNyBTYWx0ZWRfX6b8FgrFymex4
 FZImVmLd+4Jh4qOGn+PQErwsafDYdhgUaZNn3Nul9iWkXzeeU5gFtqg4XeZnNIJ5kDqI5o6UNPi
 7CK3EcAkwQjay3AJSPvgye5RBnl7MxYJ8i0+XEYt8Wi4Osa/0u2zgvm7fIrgH6g1RxqPMnLC0eB
 EL4GRzmUyLsDC9IjkElhuBe8FDfZqFvWdGy5WGapprtplGhc6NjCHXcdQadQqHGnkau77YP+h2g
 +L6N4n1mg2bHhwGybWQTnjAqQMe+6cfWi4k8fVoX+deD4riDDqCd5vQc6d26NZBVaTrmRVpAGfH
 W3NAC3xart8Sxmb7afgS/oy0fdr8MKyPRIUNWhg3Ag6ocQ2q1+LYV1mxIT2F2Ej08Mo1AJ2So5j
 J1yydRlRtPDjC+JnanzntICGxbMyBOFejLHCd+Fsgs30/FLL9CW1XA2QeemfCOgCU/QM+oABG49
 4/MkLTK6XIJxdULJSig==
X-Authority-Analysis: v=2.4 cv=ROO+3oi+ c=1 sm=1 tr=0 ts=69610fe7 cx=c_pps
 a=h3Jk+6XEKCuoUZR+ZnWw9Q==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=vUbySO9Y5rIA:10 a=-AAbraWEqlQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=20KFwNOVAAAA:8 a=M5GUcnROAAAA:8 a=VwQbUJbxAAAA:8 a=J1Y8HTJGAAAA:8
 a=1XWaLZrsAAAA:8 a=ct_4CVhOAOOLMjlNK7AA:9 a=QEXdDO2ut3YA:10
 a=OBjm3rFKGHvpk9ecZwUJ:22 a=y1Q9-5lHfBjTkpIzbSAN:22
X-Proofpoint-ORIG-GUID: kOAALnqTOurYYjN4x5ciqM-djQ2SHFQx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-09_04,2026-01-08_02,2025-10-01_01

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUGFvbG8gQWJlbmkgPHBh
YmVuaUByZWRoYXQuY29tPg0KPiBTZW50OiBNb25kYXksIERlY2VtYmVyIDI5LCAyMDI1IDk6NDUg
UE0NCj4gVG86IFZpbWxlc2ggS3VtYXIgPHZpbWxlc2hrQG1hcnZlbGwuY29tPjsgbmV0ZGV2QHZn
ZXIua2VybmVsLm9yZzsgbGludXgtDQo+IGtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4gQ2M6IFNh
dGhlc2ggQiBFZGFyYSA8c2VkYXJhQG1hcnZlbGwuY29tPjsgU2hpbmFzIFJhc2hlZWQNCj4gPHNy
YXNoZWVkQG1hcnZlbGwuY29tPjsgSGFzZWViIEdhbmkgPGhnYW5pQG1hcnZlbGwuY29tPjsNCj4g
VmVlcmFzZW5hcmVkZHkgQnVycnUgPHZidXJydUBtYXJ2ZWxsLmNvbT47IEFuZHJldyBMdW5uDQo+
IDxhbmRyZXcrbmV0ZGV2QGx1bm4uY2g+OyBEYXZpZCBTLiBNaWxsZXIgPGRhdmVtQGRhdmVtbG9m
dC5uZXQ+OyBFcmljDQo+IER1bWF6ZXQgPGVkdW1hemV0QGdvb2dsZS5jb20+OyBKYWt1YiBLaWNp
bnNraSA8a3ViYUBrZXJuZWwub3JnPjsNCj4gU2F0YW5hbmRhIEJ1cmxhIDxzYnVybGFAbWFydmVs
bC5jb20+OyBBYmhpaml0IEF5YXJla2FyDQo+IDxhYXlhcmVrYXJAbWFydmVsbC5jb20+DQo+IFN1
YmplY3Q6IFtFWFRFUk5BTF0gUmU6IFtQQVRDSCBuZXQgdjEgMS8yXSBvY3Rlb25fZXA6IGF2b2lk
IGNvbXBpbGVyIGFuZA0KPiBJUS9PUSByZW9yZGVyaW5nDQo+IE9uIDEyLzE5LzI1IDg6MjkgQU0s
IFZpbWxlc2ggS3VtYXIgd3JvdGU6DQo+ID4gVXRpbGl6ZSBSRUFEX09OQ0UgYW5kIFdSSVRFX09O
Q0UgQVBJcyBmb3IgSU8gcXVldWUgVHgvUnggdmFyaWFibGUNCj4gPiBhY2Nlc3MgdG8gcHJldmVu
dCBjb21waWxlciBvcHRpbWl6YXRpb24gYW5kIHJlb3JkZXJpbmcuDQo+ID4gQWRkaXRpb25hbGx5
LCBlbnN1cmUgSU8gcXVldWUgT1VUL0lOX0NOVCByZWdpc3RlcnMgYXJlIGZsdXNoZWQgYnkNCj4g
PiBwZXJmb3JtaW5nIGEgcmVhZC1iYWNrIGFmdGVyIHdyaXRpbmcuDQo+IA0KPiBQbGVhc2UgZXhw
bGFpbiB3aHkgc3VjaCBfT05DRSgpIGFubm90YXRpb24gYXJlIHJlcXVpcmVkLCBhbmQgd2hhdCBj
b3VsZCBiZQ0KPiByZW9yZGVyZWQgb3RoZXJ3aXNlLg0KPiANCj4gSSBkb24ndCB0aGluayB0aGV5
IGFyZSBuZWVkZWQsDQo+DQoNCldlIHVzZSBSRUFEX09OQ0UgYW5kIFdSSVRFX09OQ0UgQVBJcyBp
biB0aGUgZGF0YSBwYXRoIHRvIHByZXZlbnQgdGhlIGNvbXBpbGVyIGZyb20gb3B0aW1pemluZyBv
ciByZW9yZGVyaW5nIHJlYWQvd3JpdGUgb3BlcmF0aW9ucy4NClRoZSBBUElzIGFyZSB1c2VkIHRv
IGFjY2VzcyBSWCBhbmQgVFggcXVldWUgY291bnRlciBmaWVsZHMgdGhhdCBhcmUgc2hhcmVkIGJl
dHdlZW4gdGhlIE9jdGVvbiBoYXJkd2FyZSBkZXZpY2UgYW5kIGl0cyBkZXZpY2UgZHJpdmVyLiBU
aGVzZSBBUElzIGVuc3VyZSB0aGF0IHRoZSBkcml2ZXIgYWx3YXlzIHJlYWRzIHRoZSBtb3N0IGN1
cnJlbnQgdmFsdWVzIGZyb20gdGhlIGhhcmR3YXJlIGZvciB2YXJpb3VzIFJYIGFuZCBUWCBjb3Vu
dGVyIGZpZWxkcy4gQWRkaXRpb25hbGx5LCB0aGV5IHByZXZlbnQgdGhlIGNvbXBpbGVyIGZyb20g
b3B0aW1pemluZyBvciByZW9yZGVyaW5nIHJlYWQvd3JpdGUgb3BlcmF0aW9ucyBvbiB0aGVzZSBj
b3VudGVyIGZpZWxkcy4NCiANCj4gL1ANCg0K

