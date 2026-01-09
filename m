Return-Path: <netdev+bounces-248530-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CCEED0AA1D
	for <lists+netdev@lfdr.de>; Fri, 09 Jan 2026 15:29:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3E5693041AF0
	for <lists+netdev@lfdr.de>; Fri,  9 Jan 2026 14:28:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06B4B33CE92;
	Fri,  9 Jan 2026 14:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="f/Zkgw2m"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84B1035CB97;
	Fri,  9 Jan 2026 14:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.156.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767968898; cv=fail; b=Qb5ZN4lbvWagVuTFgxfTkMXqgPiBvY3yXr3eU+cN4WH+Hk4DdXGlMGS9m6xtDrf6PT5YDyHyhjreRIin/KxtE85hE6oWuR9rsodcOxtxvlKFA2jDCFhI10+JHNitmbgr7kdyTxES/3hUGhgkMsFkc16t2KW4Yp4ch43PrPWcjFE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767968898; c=relaxed/simple;
	bh=RCXMJH/YvqDuynLscn6JoLS6mowkyYRuvZfvTSwdPVo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=WS8EEdS87N47EprdVmvXBJaNusKRl0PWNigz0WhhNNQN9dvXlsC9sswBd53OUp+Fc91/atDhFXANmOYHOimob8to0IPFCJr6Sz/6Hg7gcWTreHSh1srMl8L8jEu9PbjA2Cl+hsGeY2AAjpHotZMa0amFsvRHaW3jrQb1jb+eTh8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=f/Zkgw2m; arc=fail smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60966pLx2094753;
	Fri, 9 Jan 2026 06:28:07 -0800
Received: from cy3pr05cu001.outbound.protection.outlook.com (mail-westcentralusazon11023099.outbound.protection.outlook.com [40.93.201.99])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4bj181chff-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 09 Jan 2026 06:28:06 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ah5dpJFYqev1xHDVSPh6mkj07QbfvqmFZfas/kV/2x+vacQqmYtXj8lMc/VjZKMYOIvmhPChY6oIQgaqE2e1FqtcmIqcobyVR6hE3nl8ii5ddLv1YYXsM65FxefYL0RTAPfVZAxfGB2rpqmGoc3UtoT+0JqnN7U10Ymlk7BxCy3IPAt/EwN7dVmGbRLR5TvDW0YHW1UOo7agen5BUlqK7Vz2iWJEQ6WT5EJ2i7NyFb09Qhb5vuprnVkZSIBiY6GXsNPA9S99llRsoidyto2JTwSzNl8fWI9trk7Tdya/RkHEpaV5qj7WlECs3279tYhDWrz+6nSHneVHxXydMDf/KA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RCXMJH/YvqDuynLscn6JoLS6mowkyYRuvZfvTSwdPVo=;
 b=YqirT55gDorqHqnXTW/GKbYhZBanVZ6mLuvKc+IOWhBkozJjAGqnpRx/LYOkUHIrwxls2sSNASF+2xfAmvj9wgvUFFazui7EzW0VofL7caSjE8om4sZ5VyxrpCsl+dgkgZE/AqTsYX7yKZTvJsG1Dgg1IQOjEA3loYnIVdRLEbH+epjjntr1Amy7bPQyuFYqMi0uxWP3bBvm/UClj55FyJtWi1RxsYlndh8/Y/C31gSSMAxg+dtV6t/r9RNX/161m7okrAzV/1Wyl/g+wJL2/GWJd5Jq50SqzTY4XGXfFyCm4WtjwcjtvFsvzotv2grlgOftHBZCYxFgYlVF824WTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RCXMJH/YvqDuynLscn6JoLS6mowkyYRuvZfvTSwdPVo=;
 b=f/Zkgw2mSwMBl/NYcpZkZ9CR7KD7Yl+nvS/uRiDj3q1S+CO4A5jE+mACTY9UxS8lGE0qWZCCFpe6gPp1LFYriWIKeyGdneVIxiHSOwIhTvFiBdUG7gkud2h4QJb4y61vI6cVhbUBiDcHboi4CcSZo8lLIOFuvXutOTWHC67VMzM=
Received: from MN6PR18MB5466.namprd18.prod.outlook.com (2603:10b6:208:470::21)
 by LV8PR18MB6046.namprd18.prod.outlook.com (2603:10b6:408:231::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Fri, 9 Jan
 2026 14:28:02 +0000
Received: from MN6PR18MB5466.namprd18.prod.outlook.com
 ([fe80::bf0a:4dd:2da5:4ab2]) by MN6PR18MB5466.namprd18.prod.outlook.com
 ([fe80::bf0a:4dd:2da5:4ab2%4]) with mapi id 15.20.9499.004; Fri, 9 Jan 2026
 14:28:02 +0000
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
        Satananda Burla <sburla@marvell.com>,
        Andrew Lunn
	<andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>
Subject: RE: [EXTERNAL] Re: [PATCH net v1 2/2] octeon_ep_vf: avoid compiler
 and IQ/OQ reordering
Thread-Topic: [EXTERNAL] Re: [PATCH net v1 2/2] octeon_ep_vf: avoid compiler
 and IQ/OQ reordering
Thread-Index: AQHccLlffMiCzyQRokiCUpNLw/HqRbU43BUAgBEqMxA=
Date: Fri, 9 Jan 2026 14:28:02 +0000
Message-ID:
 <MN6PR18MB5466A9FC65A7122D84985C9FD382A@MN6PR18MB5466.namprd18.prod.outlook.com>
References: <20251219072955.3048238-1-vimleshk@marvell.com>
 <20251219072955.3048238-3-vimleshk@marvell.com>
 <106d58e5-bf93-4ff8-9c1d-9064847dd892@redhat.com>
In-Reply-To: <106d58e5-bf93-4ff8-9c1d-9064847dd892@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN6PR18MB5466:EE_|LV8PR18MB6046:EE_
x-ms-office365-filtering-correlation-id: 39f8e5e5-90be-410a-3e0a-08de4f8b4ba0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?WkdEWkhmbC95VDQvOXB3blZtelFKdWZrOGZqVVpSUUkrclpYNzZEY01zOTMy?=
 =?utf-8?B?bUE1Uk9rL25DSndaMGxROUlRRGY5YjRuWnZqZFRLMzRkaEdsT05kS3pNOGxK?=
 =?utf-8?B?WDdnNnRhQmNEazlsem1aOUxVRWxRM2hGdG5OUGxPaUlZOVl0Rm5wWVp5TXlN?=
 =?utf-8?B?a29lenR1OEVtY1hmOFh5YThkRmVRdTNDeHVieDFIRG5PQUVFRG9ZcG9UcldL?=
 =?utf-8?B?emtoUmIramMrUVhEanJGRkt5bnQ5VVlKejJ3SVBiY1k0UUc5SXNOU2VkYVcx?=
 =?utf-8?B?TVY4N0JOa1kvZm1rNFNqMlAxN0drZXNqMzZNc2NKQ2M2bDVVdVlaZ1JaellB?=
 =?utf-8?B?cSs3TTdSTVIwcm5QUmJHaHhQM0RnaHJJUzdudTZheHZNQzVDMDJ0UUFFVHpF?=
 =?utf-8?B?S2JNMEFQcXZHSkJ4WFFQT3NKT29DWVdIQ0lESDFERlJQbmUweVh6czl5TlB5?=
 =?utf-8?B?dk5LZkNDSVdvdmRudUViL2pTRWZ5bjNvMExtbUlsTXQ5N09McEFmSFF6RGpU?=
 =?utf-8?B?cERqQ3gzdHNlaUc1TG1oZWY4cmFTU2o5RmtoOFNGbEI1SUd5VTE2Zy9SeTk3?=
 =?utf-8?B?ejB6dnZ4V0ViNnpRc0s3a1JKSXdjd3lhbEU5ZFhCcDNrMU1mdmZ3a0hIVEVz?=
 =?utf-8?B?cHJUWEJvb1hqL2xBREltanRkQUp4Y3FnYUVRallhakJLaGN4TUhvbDMrRGhP?=
 =?utf-8?B?K1VEaFpzMzlMRkNIZ1oxVFg3TnFmVG5rVElabGl4VDdvSjRzZzY5aUVkYy9o?=
 =?utf-8?B?VG0rN2NxMGpBM1pETUdMTEEzVlY4Wko2UEFkaW85SUtoK2U2aW5nVTNpQ24y?=
 =?utf-8?B?bWNVOHlKVEtuL2JUWVdHanNXVHJ6K2lMTWZRU0FPQnp6Nnd3b05EODFIR1lw?=
 =?utf-8?B?M3ZpdWtPdVF3WEFPQWN6YktHcmMwZGsyTDlISk9KUTBWbkk0Y0JLSHg2NXJ3?=
 =?utf-8?B?UEc5MVdkVUI1M2RScS9FUFFHMDI5MFByTmFRZlFVWGt4dWZ4RFpkK2dtRUh2?=
 =?utf-8?B?cDZUV2dZKzBFaHVDQ2FUWEJleXhLb1NNazdoSWVNSFp0UGZrK1l0VS9FNTVB?=
 =?utf-8?B?UjNWc0VWc2dZd3lHbEZSelBmNmlpaXpod2h3bldIQXYzZ285NDRRb3dFQjdN?=
 =?utf-8?B?MHdOdURhV1Q3NHVYS3NsSXdwZmNOSnNUUlBoaWVNSFYyLzNhd3RQcFZUZng4?=
 =?utf-8?B?dVpwQTlpRjR5T3ZVYyt5ejVGWlEzQ0lqZU1SQlJUT2VwWEQ0TE5qWkVaaHkv?=
 =?utf-8?B?MjBZL0hxZGdpeEdEN1RpL2tPSHJtVTF6Zjl6bkxoaE9EUkhONUkwK2djZHpr?=
 =?utf-8?B?aXpxTE1HMXlEMjR6UjVUSG42dmxUdzlCaFVjVGFObm9mNmFJSmpYcFBiQkc4?=
 =?utf-8?B?K1V1ZXdSYzlDUzZpdzN0VWgrVVhrQnJ6QnAwYm43clVsNXV4RkJKZUI3K08r?=
 =?utf-8?B?dWFSL2o3b1ZneFlDeEtEN2szamZseVRxU3JIVEY5MFJsd0JJak05UG9NOEJ0?=
 =?utf-8?B?dWkzMWMvem1ERWkySVNrM3huS0x1WGlicDlNbVBUTEhIVTh6bWs4QndBaEpk?=
 =?utf-8?B?UzdrR3dCSFdnQUVhT0hDcjVaQkNjYkZPNGdqTEp6eWVYaHF0bDZZOGVPdlRs?=
 =?utf-8?B?ZWZibTFUSVo2S2x1SFNFUGp5RjRuMXNwZVIvcDNUTTJpa1VKWE9xM2lVUFZt?=
 =?utf-8?B?UjRQZU8rNnIrNFdhQnFOL0JIVWt4RS90OGhwdUc4TzVUQlVsK0Q1UUt5SGhK?=
 =?utf-8?B?R0d1WVFGdEFYK3ZLLzh2Tk1BdG0vNndQc2Zsc1M3L21DcG9Ea0g4UVdnYlNR?=
 =?utf-8?B?WmFVTHRvRzU3MVpiMjRzVlBsK3JRN2tYTURxdng2UUFKTXVsaW4xbGFnYW8y?=
 =?utf-8?B?RXA0eVh6NmpVdkR6QnBObmZIRkFtVGpaY2hTUU84MElSZVpndFRDVzR1d3Vt?=
 =?utf-8?B?QzdCU21iWkxpSlBrM2NVNE5tZElyd0pyNlVQcUpRdmJYZC9RYkE0OEcrQ1ha?=
 =?utf-8?B?SVY1NWtvaWRYNG9kOUpISGtnb0NIYy8raU96M0JxK1pEdW45MWZSbFluRHh6?=
 =?utf-8?Q?ljzX9K?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR18MB5466.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?K3JqcEZaT3R1L25kaDFDWWVMTGxDUUNJc3ROb0RpVVFqRWtPdnJGbS9qSUtC?=
 =?utf-8?B?eGdoOHFwQU1mTjhpNk1DSCsvaWRzL0ZyTVdmaFNaVmNVYkFETWFjeFFVLzd1?=
 =?utf-8?B?OTJHTzh3RVVIMmZMN0hjWWV3ZUQ0UkhYR3RheG1BZzJSQXNnK0hCL2xSdjk2?=
 =?utf-8?B?WlVtQkppTnVCdm9xOVhGY0lLQzBlL0RKUjNteEhVemJGSXlJSzBEMTRqZSto?=
 =?utf-8?B?TWczL2Y0ODVreWUwa09OMXArdW1tc0dPZ3AwVitUUmJuOElsSUo3OHdyeWRP?=
 =?utf-8?B?SzQrUmFKdnlBVWIrQWNUaDlnOEc5dDhsWmd0akR2aGdzZVRlWG9JMCtZdGhh?=
 =?utf-8?B?bXJNMkdyUWVGVUgwRG13VG8xR2FZYVlzaG9XQisyWW5VV1RvVmdIWVR2VlJL?=
 =?utf-8?B?UTFrdExBcmg0YlBHWnNhM1pRd2ZYSldyQzRuZ0tkY2o3WmYyM2pseVNuaGpn?=
 =?utf-8?B?bnlSNlpRdlduVmJQUmIzK3hWTlJ4U3J1TE4za3FmbU5LeGN3VDVhUFZVNHZ1?=
 =?utf-8?B?Vk9NSWloOU5YNWtmTjJuUEVkWDVrN1FpQU5QbytFUkYwOTF3dmtmTDRCV3ZS?=
 =?utf-8?B?bHdmNFZhcC8wZG1ab2xoQno4b1V2bVlicnU3dFNoNW8vaHpDMW1VUldnTk5V?=
 =?utf-8?B?SVliSnRVZ0xndUVqZnBZTStRN042YVVpV1NvQnlCNTkza1FQSW5zM2Fja1kr?=
 =?utf-8?B?WlU1U01WZC8yK04yc1h5dWxpMUZtRFZsYVBjVWo3QWpNS0dSbk96cGExNUho?=
 =?utf-8?B?ZUtyRE90dldNMUlybEFKNDNuQzVHT0xORktNYXNab080enZtUUxpenlBR2Zv?=
 =?utf-8?B?SU1aTk1DL2VEN21xb2xkbW5WR00yZmhkTWxPSEZSYnp1Vm1hWFYzOGhVOUds?=
 =?utf-8?B?UDRMbkVCeS9rWERqRnV6VlVJYWxSczE2TnEyZGx4dVlzTWJsQmdMdzN0RS9s?=
 =?utf-8?B?eUg2c2V6UlV6VmlUTDVUZ2s3UTFwcU9VZURzTWMzMUsxNm9VMmRYM3hKM1dv?=
 =?utf-8?B?eHV1N1VQVmdjRTlmYlBvcEJwdTM4WElmSng3Z1NsbWxsUXZOK2VSOUxRdFBy?=
 =?utf-8?B?aFdaYVZGdUREVng4ZmZnTnovbEhEMmJvVG05endpbitlSW1VVGp5UWlnQkM4?=
 =?utf-8?B?eDMvYkpOazVUaE9UdnUxMjRaQk0zdjVycDh5ZlZpd2V2MWJwclZrMUlaSkZk?=
 =?utf-8?B?YURqRGgxdEkwU1AwZEVodUR1Y0FzdWZGdUx1emN4alpEZkQyNmhKQmxUTHAv?=
 =?utf-8?B?cmM0T0xsZDRHVXM1Vm53S3E0ZGxtRElpamRrb1ZLRVNybzRvM2crQThBSDhT?=
 =?utf-8?B?TWxQZkU4ZGN3UXdTaHhWRGgzdk9EbCtIRVM2WTE0b3RMWm1oN2NSNnlvbGpU?=
 =?utf-8?B?REJ2eHpTYUxjdzhkY3V0cnMrYlN1L3R1bUF4NitlT2FnWFVpVTFPMTZlam40?=
 =?utf-8?B?b0VjM2ZqS0M3blpieTd5UE1iczNESEIvVFZXOU5IcS9iOGQ1KzlLaVpZY1Nl?=
 =?utf-8?B?dG5Bczh2MmdxVUlTVHhxKzFESUkydHJ5czZwT2VyL2RLcHBKeW9iSmtobUVa?=
 =?utf-8?B?eGhLSFhSTWxrais1d0kya282SytFTUM0aWlzaVp1WkxVMHNuZk1YVlYyelcw?=
 =?utf-8?B?QmlKYjk3aFNKQmkyYmlPTElzZHNtaDdGN0wvTm9xQ1NLQWFXUnBpa1Q1VDVC?=
 =?utf-8?B?aFdjbUlQbVUwOVVnMm0yVnZjL0ZlWWticEJMSGVVOTA3R2xYMEtVeUJ3SDJn?=
 =?utf-8?B?WXRMc2M5WEp6bWJKZlBkcEVaS2NDRkVmWkVkRG9mdzk4UHE5S1RqNWVNMUFI?=
 =?utf-8?B?Y1Rrb0JlY215OXpCd3lhRmpBN0hobkhoZHdCTW5vNDR0OEg2S2NiZUZQTVIy?=
 =?utf-8?B?QWowYUk5Nm84Mmx5OWw3NjNVZ0g4SkRSMmtmNDVjS2JRMEpkY0R3VzlmUlNW?=
 =?utf-8?B?Ty9sYWVWZWkzR3JubEZzeXk2T1V0eEF2VTV2Mno4bzZYZFV0Slp2VEJhUUht?=
 =?utf-8?B?TS9CdEF4a1VhcFllZmQyUHlXRHlySWtTeG1GaXRCZEJaNzAwdnREWkdVbzMr?=
 =?utf-8?B?WUltRkZXaSt0T2psdTdXTm1PWmp5Y3BNL01qSnN5RHZld2l1UitVZW1EM1Zy?=
 =?utf-8?B?bjY3cFlCcFRoNk5SREVNMExhMi8reXY2V3daYjBjdXp2Y2lvbWord0JTUENP?=
 =?utf-8?B?NEVza2JJcE42ZWFrOTZiYk11QWFTdWNjcjdTSW9WZW03bEZHUFBLZ09vQ01D?=
 =?utf-8?B?MnlKb1dRdUFoVm1lOU5GWnE1K3kyYnZSejlqL2szNXhrZG9DcUU1eDdXOFI5?=
 =?utf-8?Q?z/uAZnXPAy9jFV4Mo8?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 39f8e5e5-90be-410a-3e0a-08de4f8b4ba0
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jan 2026 14:28:02.0930
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: k7xieLptMgBZ1PDHoyeJeIzYOhvDOOADqSWFSZnZbzUFe/gP+cEU8hoBwgoMT21HcKDCUjVAVy/u4/mkVzBE5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR18MB6046
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA5MDEwNyBTYWx0ZWRfXz2CYhRPQb/33
 h4VqtxyCVSY2BDli4qkPJRHf4Rc5vRJ8axNwyIYz8M658BrYhVunWyHmmxVfMWvjDP6CqMhS3Zi
 +DqRFLJUErjDTGYJCdW3hbhnRPY7mmOLTGu1OW6XGSoW+1q1IpDMqCGJgZyYqoBF4LgFb7BatPK
 5t+Tyb0+hanLIgJ+cy9HMuod1SVNQpEQpAVqCfOEqFQLk3AZ37yV8xeCxSRYrhEA9i6x4zafjAO
 gJssbx58w1Swpp8aONjgfX4VXU5nJNITVm9mm+NRIoZlWerjimx0CtDEbUfmt0dSrW77RhPf4ba
 S2ndBjZYyaRlsByokV+Z6jdbXXEfiHfjRJwQGzUKxF91bZUXcYD+F1yqkUL1lhW09P1t+aZTp2V
 r2gz/WdhxmgDAOFkqwZs86XCvs4aEGLkTYq8iV+UbD48P5+aJQHgZ0TdVkRq78smWxKY54i1hk8
 uEhJSjk8JnGH0By9jhg==
X-Authority-Analysis: v=2.4 cv=Vdf6/Vp9 c=1 sm=1 tr=0 ts=69611076 cx=c_pps
 a=ajv5h6Eily4lkhfMD1AUMQ==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=vUbySO9Y5rIA:10 a=-AAbraWEqlQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=20KFwNOVAAAA:8 a=M5GUcnROAAAA:8 a=VwQbUJbxAAAA:8 a=J1Y8HTJGAAAA:8
 a=1XWaLZrsAAAA:8 a=56Ltkgn-K9RAQ_UlPw4A:9 a=QEXdDO2ut3YA:10
 a=OBjm3rFKGHvpk9ecZwUJ:22 a=y1Q9-5lHfBjTkpIzbSAN:22
X-Proofpoint-GUID: gsPfp1ur-F5exN5C8gXInmk8wHsdvbCB
X-Proofpoint-ORIG-GUID: gsPfp1ur-F5exN5C8gXInmk8wHsdvbCB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-09_04,2026-01-08_02,2025-10-01_01

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUGFvbG8gQWJlbmkgPHBh
YmVuaUByZWRoYXQuY29tPg0KPiBTZW50OiBNb25kYXksIERlY2VtYmVyIDI5LCAyMDI1IDk6NDgg
UE0NCj4gVG86IFZpbWxlc2ggS3VtYXIgPHZpbWxlc2hrQG1hcnZlbGwuY29tPjsgbmV0ZGV2QHZn
ZXIua2VybmVsLm9yZzsgbGludXgtDQo+IGtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4gQ2M6IFNh
dGhlc2ggQiBFZGFyYSA8c2VkYXJhQG1hcnZlbGwuY29tPjsgU2hpbmFzIFJhc2hlZWQNCj4gPHNy
YXNoZWVkQG1hcnZlbGwuY29tPjsgSGFzZWViIEdhbmkgPGhnYW5pQG1hcnZlbGwuY29tPjsNCj4g
VmVlcmFzZW5hcmVkZHkgQnVycnUgPHZidXJydUBtYXJ2ZWxsLmNvbT47IFNhdGFuYW5kYSBCdXJs
YQ0KPiA8c2J1cmxhQG1hcnZlbGwuY29tPjsgQW5kcmV3IEx1bm4gPGFuZHJldytuZXRkZXZAbHVu
bi5jaD47IERhdmlkIFMuDQo+IE1pbGxlciA8ZGF2ZW1AZGF2ZW1sb2Z0Lm5ldD47IEVyaWMgRHVt
YXpldCA8ZWR1bWF6ZXRAZ29vZ2xlLmNvbT47DQo+IEpha3ViIEtpY2luc2tpIDxrdWJhQGtlcm5l
bC5vcmc+DQo+IFN1YmplY3Q6IFtFWFRFUk5BTF0gUmU6IFtQQVRDSCBuZXQgdjEgMi8yXSBvY3Rl
b25fZXBfdmY6IGF2b2lkIGNvbXBpbGVyIGFuZA0KPiBJUS9PUSByZW9yZGVyaW5nDQo+IA0KPiBP
biAxMi8xOS8yNSA4OuKAijI5IEFNLCBWaW1sZXNoIEt1bWFyIHdyb3RlOiA+IFV0aWxpemUgUkVB
RF9PTkNFIGFuZA0KPiBXUklURV9PTkNFIEFQSXMgZm9yIElPIHF1ZXVlIFR4L1J4ID4gdmFyaWFi
bGUgYWNjZXNzIHRvIHByZXZlbnQgY29tcGlsZXINCj4gb3B0aW1pemF0aW9uIGFuZCByZW9yZGVy
aW5nLiA+IEFkZGl0aW9uYWxseSwgZW5zdXJlIElPIHF1ZXVlIE9VVC9JTl9DTlQNCj4gcmVnaXN0
ZXJzIGFyZSBmbHVzaGVkDQo+IE9uIDEyLzE5LzI1IDg6MjkgQU0sIFZpbWxlc2ggS3VtYXIgd3Jv
dGU6DQo+ID4gVXRpbGl6ZSBSRUFEX09OQ0UgYW5kIFdSSVRFX09OQ0UgQVBJcyBmb3IgSU8gcXVl
dWUgVHgvUnggdmFyaWFibGUNCj4gPiBhY2Nlc3MgdG8gcHJldmVudCBjb21waWxlciBvcHRpbWl6
YXRpb24gYW5kIHJlb3JkZXJpbmcuDQo+ID4gQWRkaXRpb25hbGx5LCBlbnN1cmUgSU8gcXVldWUg
T1VUL0lOX0NOVCByZWdpc3RlcnMgYXJlIGZsdXNoZWQgYnkNCj4gPiBwZXJmb3JtaW5nIGEgcmVh
ZC1iYWNrIGFmdGVyIHdyaXRpbmcuDQo+IA0KPiBTYW1lIHF1ZXN0aW9uIGhlcmUuDQo+IA0KUGxl
YXNlIGNoZWNrIG15IHJlcGx5IG9uIHBhdGNoIDEvMi4gVGhhbmtzDQo+IC9QDQoNCg==

