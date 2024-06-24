Return-Path: <netdev+bounces-106235-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A9E591568A
	for <lists+netdev@lfdr.de>; Mon, 24 Jun 2024 20:37:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7ED201F23D2E
	for <lists+netdev@lfdr.de>; Mon, 24 Jun 2024 18:37:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 855491A01BE;
	Mon, 24 Jun 2024 18:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="rdzkDVKD";
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="C7i3YMQ2"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-002c1b01.pphosted.com (mx0a-002c1b01.pphosted.com [148.163.151.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 616961A01A6;
	Mon, 24 Jun 2024 18:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.151.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719254236; cv=fail; b=YoHNZwqOeU4SiSjbrRaUZuhW/DMvepdlLDkLXHawRl7kDwcmq9E2uOZuo51zGrJ6Zy6eJE/tdiEIMQ5lyw0jN9Jdd9s3bPJAAB7ilCnLb1WhBD0AdYdr4g3H6YnVrnJOrSBdL4UEi2LdXTpLiOCqTknEBcQ3oujyrbJ+C0C2JuM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719254236; c=relaxed/simple;
	bh=vSuIr1lPzHYTTdpxF+GfAgopCoRCvQiauRpOAV0B7Jg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=kaUZmH5fLSXu8/tZqdPxZaOOrK2bxIZ0OnUF+c1UM4GqIxHy3QL9YDdcTaVIeA6c1jQ/xNESsQF23h5bsMl/RL0ATJaGQiETeJKgWZFrCWVVbU1/8PbjjAbpRC1IJD3r+TmCoQ7Yv70Dl0/i82Um01Um55KMz6cMolwOSCqpog4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nutanix.com; spf=pass smtp.mailfrom=nutanix.com; dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b=rdzkDVKD; dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b=C7i3YMQ2; arc=fail smtp.client-ip=148.163.151.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nutanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nutanix.com
Received: from pps.filterd (m0127840.ppops.net [127.0.0.1])
	by mx0a-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45O9O77J016998;
	Mon, 24 Jun 2024 11:37:00 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	proofpoint20171006; bh=vSuIr1lPzHYTTdpxF+GfAgopCoRCvQiauRpOAV0B7
	Jg=; b=rdzkDVKDB/7FLRzr8kOIllK9EeEk14lt1D0mjdlBsltR9wFR72kOs2yP4
	QXPA2QyNpi5Stf+sQmuN6ZHLBnrO0//rrorShv11dhV+rBvyeJy1adsVs3alnNbL
	H6vlYI0bGH/UB3EDO2vuxU2VIqlb6uinMu0GgKiyynbqwHXTfdmZmJANowv1p2MP
	tuAPzHRFzLfdulOPEtVFFboH51NO7RPG7AcUtm4lA3k7+5RrF8NGmSYtin2YvkkB
	c3+K06IX1DqcWCa6RyYcMEW6X1JgMCi4vjIy+CUe1riOe5g1vcFr4AFiQTjEI18k
	6o1wvUU7PXBmNQsJesWGZO2M2FHfQ==
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2174.outbound.protection.outlook.com [104.47.55.174])
	by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 3ywtxr43x5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Jun 2024 11:37:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ihxQBkQ1kMo/2+Ae3/LlVLc0L1YrZKuEpsMlY8j2umxIFVQSYJYxY4lhFRX59jMv3lxdTLyGMDHS15Ube13lzXb0gXm67LGaNPR1ARlHf0USZqDTN94HyxWoR7I1cCqrF4YtsPB4dTRmlzt6cAZJ+2Zxrj+FqQDMMJo0Ivn0WfUiXM5NWyredwIWKCjTKSqX5TwURuy+DCqhhCbwiy11fvj0+HwzYHq/Sxj4E4bPKIdC6eSsWGxNAfWVRoHSmJ64+lUqPuYFd6g0dPG/dQ4Tpwb0fX01JcKrXX6RYKk4lQxrOngHXRu389jmxeHuGfc1s1nN/YglD7g0cZsWuD+nPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vSuIr1lPzHYTTdpxF+GfAgopCoRCvQiauRpOAV0B7Jg=;
 b=UUJQxQwelqd5JGw+7qGt9YkGnoOg0nb9EvlDv9nAB4isdL3ZkWb7qqw+X08N8wxQtZjNTD2hPYbcy3tJE2mHKf6u65f5WzQ8ms1WN7CcfbgPTCRTkuWFuXWoXAyrzOfbxDhbyoxTfRJSCTjq9J1peRkxMUNsk7/S/Tl/MAJGV1dnSJojtQBAMRD2+9bcUqYiAgu7eIoAih+xtguij4+JHtr2rJculken3rw9qAAP4kIKSGKCm0d+kEyQZo+EfuWtejsfSfEsOGeR83qDDCt7kyh+bNf+fL7JhziDD2bkFeoBCBuCWRvxAlzsWf9E/EtX6ivfriiBhrKBc/TJcfBtUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vSuIr1lPzHYTTdpxF+GfAgopCoRCvQiauRpOAV0B7Jg=;
 b=C7i3YMQ2pzDKqCgn1zsBKmfTXWEULTX3yE6vGsmaxg8chbBoBdaDriuaGmcKDi26TPV5fhLL5KLyW4URzux/IcVXHW0QeHlv3un8C/CihCEXgoTZxWjn7Uj9O44RPj3slwyUspKzbi4hIgJNGnaEzxrGlhftFAtRHR5E4YpHY6FnyoQ/yKvrkWObvztsEzD1wfwosacJiOR7rFgvlwsQ/ak3OJbReEW5VYx5o+qs/koL6stQMShWXZSmz5casrdfCqlrWHKtwG3z1Mw21zN5Z5ABNKyWrlef8ufd+sw8jGQUDGw01NsX/71PhMrWfDQ2hAu9W0WB00ogtIEJoRGvTw==
Received: from LV8PR02MB10287.namprd02.prod.outlook.com
 (2603:10b6:408:1fa::10) by SJ0PR02MB8499.namprd02.prod.outlook.com
 (2603:10b6:a03:3e7::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.30; Mon, 24 Jun
 2024 18:36:58 +0000
Received: from LV8PR02MB10287.namprd02.prod.outlook.com
 ([fe80::b769:6234:fd94:5054]) by LV8PR02MB10287.namprd02.prod.outlook.com
 ([fe80::b769:6234:fd94:5054%3]) with mapi id 15.20.7698.025; Mon, 24 Jun 2024
 18:36:58 +0000
From: Jon Kohler <jon@nutanix.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: Przemek Kitszel <przemyslaw.kitszel@intel.com>,
        Christian Benvenuti
	<benve@cisco.com>,
        Satish Kharat <satishkh@cisco.com>,
        "David S. Miller"
	<davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Paolo Abeni
	<pabeni@redhat.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Larysa Zaremba
	<larysa.zaremba@intel.com>
Subject: Re: [PATCH] enic: add ethtool get_channel support
Thread-Topic: [PATCH] enic: add ethtool get_channel support
Thread-Index: 
 AQHawZcrbaLWefPNP0aAi0Gu7Ms7PbHNs7oAgAAFRICAAg6kAIABSyOAgAACl4CABjJlgA==
Date: Mon, 24 Jun 2024 18:36:58 +0000
Message-ID: <9650C08B-4F8C-43F6-A87E-35EE6F7019FC@nutanix.com>
References: <20240618160146.3900470-1-jon@nutanix.com>
 <51a446e5-e5c5-433d-96fd-e0e23d560b08@intel.com>
 <2CB61A20-4055-49AF-A941-AF5376687244@nutanix.com>
 <20240619170424.5592d6f6@kernel.org>
 <0201165C-1677-4525-A38B-4DB1E6F6AB68@nutanix.com>
 <20240620125851.142de79c@kernel.org>
In-Reply-To: <20240620125851.142de79c@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3774.300.61.1.2)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV8PR02MB10287:EE_|SJ0PR02MB8499:EE_
x-ms-office365-filtering-correlation-id: ac97f04d-ecaa-4959-548b-08dc947ca14f
x-proofpoint-crosstenant: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230037|366013|7416011|376011|1800799021|38070700015;
x-microsoft-antispam-message-info: 
 =?utf-8?B?VFRSd0c4dWhtVTVET0ltb01CZ0dCTEFuMjdaQ3hzZXVITnArTkdUbEJxZ1lh?=
 =?utf-8?B?c3lVRDdvNG9kUDZjOFVzQ0EvU2lvNndwZzM5bUxsa3pTREdUQjEwY0hDR3dr?=
 =?utf-8?B?Z3R6QTF0Ym8zdFJJbWIxRlgvQVFNK3FNNXNPYUxKWnZ5NGNWdlJTanJDalJZ?=
 =?utf-8?B?MGQvY1dmZUcrMURnVkVDUzJzbEFZK2pXLzFPcmhqVEFFVFlLSExJMEo1aTJz?=
 =?utf-8?B?bDFaV3d1TW5NU3R3RFFnZi82WXVFeFBOY3hONUc5UzdnTjE1TUNkR0JZK2Vt?=
 =?utf-8?B?bEQ3djdsM0hMM0VyUWQzK2lFQXhHYnpVNEZYMExqZXpLM3kvNkg5Y2FZTkF2?=
 =?utf-8?B?NjB1cXhGazlCNUNMRHFja2FpanFadms2dTRBN1cwY1NDWGY0aFppNnhIUVlk?=
 =?utf-8?B?eUFKYWJkTmxxRlNnQXI4UFhSUkZzd29hY1RmT0dUbHFLTmd5bDAreG1ROGpa?=
 =?utf-8?B?OG83OFc1VjRtSUFaWThMZFN5QlpudVUxU0p3TjR3Szh0ZzBPTFNXYktxekg0?=
 =?utf-8?B?RkVDRGgyME5mVnBESlNlcGJ2My9pU3dnbzZZQStsZE5JL2xUbk9wQjR3bDUr?=
 =?utf-8?B?WlVseUdpM3YzaDduWVR5SVB6cER2K0UyeHh5UjB5VlRVQTBBenlmSGJTVVY5?=
 =?utf-8?B?cmR0WnJTNmI4TStkR3FKU0RvMU5Ua000bEtDK01GcUE0RlJadkx0THJrTmcv?=
 =?utf-8?B?R2lWL3BKY2RZRDFLZWloM2Y3WStRaWhtdHRqaXJkMnMvcEdrRXkwUnZIUjF0?=
 =?utf-8?B?OHlWUUtuRXZTZjZrWWtqTUNzWUIrNTUrbm9oTXJHVU4vbW1peFdSN1hWK1R0?=
 =?utf-8?B?cGlmS1Ezd1AyZ3QrMTVMVnAxSE1iSUtrTFR1UEFiRDhubHNCZWJRd2FMV1Ft?=
 =?utf-8?B?WkYrQTRoZjRvUndqcUplTkZhVFYxY3BWakhqMko2U1JWb3JFeWFnZWZReUgz?=
 =?utf-8?B?ZU9YaWcxYzFpdlFVeGhZQmt1V0M0SG8rdlA5YkdSOURVYnVyb0ZDMGNUYTJM?=
 =?utf-8?B?d2o0dFVmRFlIR3krTkFMZjlVMno3Q1RJV2RYNm0rdEJFQlFnWnVRWUJxUHBK?=
 =?utf-8?B?eFM0aUNPNlZoM2Y2bkdIY0xkNUtKYXhXMlVtczVpNjlEak16TG5QYm5OQzEx?=
 =?utf-8?B?NGFZZWY5SWgwdXN5ZC9rcmxsMmJ2SG1WMEpoYmY1elRVN2FNdXpMZHB5aGZq?=
 =?utf-8?B?LzF1emhUOU56YnNtbzhPekM2cVFVa3BUZHdFMmQvNkVHbzc2WjFDZFVvY0ho?=
 =?utf-8?B?NjZINFRQU0FVVFV0MTRTNTRDTFFkZU5mNElka0NTbUoyT3QzOEJ6M1N6K0Ny?=
 =?utf-8?B?R1FRZW8vY2tSRVY2RDBEQVhKVXUzSEFVdWV2MVFqbzcxVWFTdnpranFlWHc4?=
 =?utf-8?B?dzFtc3QyVm81RDdWZ2x0SjBpdGdMUGVPYjlHditudzZxeDBYV2cvMTExcjhT?=
 =?utf-8?B?bHFHYmNMQ0NpMmVWYTNoUXBXTk1QclNzRlpyZ2haMmNzR2VYZjFCbzMzcHVD?=
 =?utf-8?B?UmlqemZUUHdBOFpxVnVrczROQXpZTTF3ZHZodGpXazlpQmhveWRjd25SaktE?=
 =?utf-8?B?c3o3QjV0Wk81dFVWWWlIUytEODNNbkhlbWk1UHVOTjI0UFZYbGFQaW5qV2N2?=
 =?utf-8?B?MiswclNtU3FhQzN0dDJVT3pIdXNkaXJhNVkvdExTbWdqZWhLdHNFQS9KdnVN?=
 =?utf-8?B?MldMYmkvclZWQkJXRHhEaHRZYUNEYUFWNXAwKzZEcjBwZi9zN3BwQTU0TUd4?=
 =?utf-8?B?bGdZbHVLdW9tSDhUOG1XQW5nWnJNanFJd0VzVlBoUVBicUphQUJXeTRMSU13?=
 =?utf-8?Q?HPvLfl2/zMBpjvg3wlH9KFe3vG9a8TR57yH+o=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR02MB10287.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(366013)(7416011)(376011)(1800799021)(38070700015);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?WXJ0RitsQXZzVmlMaEx4M2Rsd3BHd2gwWVNWYnRtNU1rODhUYXlvdFppbGIz?=
 =?utf-8?B?WmZFVW4yZUhBalJPZnlNQ3QrYktKVW94MWRSNHo4d2RjcytrMFpSd2NpZ2E2?=
 =?utf-8?B?RGJiTHFYYzgwSFU3NDJJbzIvcEs2SGVjcXpBcjE4K3hGQkVzby9tK1BkNSs1?=
 =?utf-8?B?RzJRVXE0TTlGNWxJWTcxZ2x1djBwbyt2ZUQ0N3RJYW1yRE1pS0NmVVpaTlM4?=
 =?utf-8?B?bVFHQVc2enZ0aStnMW9yeWV1N0NMWW9rU3VwQnlFajVNMUJZK20wTHpTYzRG?=
 =?utf-8?B?SkJrTncweEtwSGEwZ2hPQUpsSjRCL05PSHJoYldSeVdDN3dML3NvRGlEc0dN?=
 =?utf-8?B?WTlhUmpwRktsaTFEV0Fvdnl5S3hsQ0Y4UitvMFAzSEt6bmFwakZuN0pFQkJl?=
 =?utf-8?B?WGllQXhJcEJ0dHkxQ25tRGE4emhlSWlYWTd3MHR3QUtmN2wwNzMzRldGWGNH?=
 =?utf-8?B?UEoxaXlRQzY4Y0N2elluYTVqRmdXUndKM3ByZmFwRnM4WHY2aEFxN0xyeU94?=
 =?utf-8?B?RUtGR1kvd1VpRlVzRURxRlNzZExQWUN2WlNNZlVrRE1MSVZRdkhVUndMY2p2?=
 =?utf-8?B?UUwzOUFvV2EvbUJFa0d5a2FvbjNkM2RDbVY1MUtnU1BDMDFYdHc4QlNSNi9i?=
 =?utf-8?B?TFBSYkF2R2pXVmo1RW9qUlc4SFRxZHlpTmpvNlNQRTRPWmt5TVo2MG9ybk04?=
 =?utf-8?B?akFSSVpTUU5CSlVRakdXQ3N5U05zTnRIRXBucmRIR0o2OE0xSXZ0aDNiWUMv?=
 =?utf-8?B?cUFtUUg1ZTJPR1B3SFRNY0QvL3h4S3IzV2lTL0lsbHFxdFVWMjNlZ2loLy9Q?=
 =?utf-8?B?aklwYlRoaG55VlpKN3graWRCVVUzVmJoT3NTMWs0SFVkUHJkVTF0NEc0QVlZ?=
 =?utf-8?B?eU0wZUVQOTBScHRQeDNPdjUvMkM5Q0Ixbm1GVHJHVlBWQldTanptNGhyT25P?=
 =?utf-8?B?SDd5QjZFVG1paHA5eW12d1VMZElqazY3anhHSUNaV2ZMYTJmTjl2UDBBaHRU?=
 =?utf-8?B?RUJEWTIyUGZkUWJDNnNCWXNJTEE5MmJNWXVLQkV0TTBYdVJxRVNtYUdJMVBD?=
 =?utf-8?B?WlBWN3BMS21zd0UyU3hjS09ZS1dKQXl6b2U5NFhKSGd6aXFheGM4c3Q2RzQy?=
 =?utf-8?B?YXRRWjZqU1VBdjhLZkRBOEUzV3Z3TkVPNGUxZ1kvTzFHQ1lyRWFBVFhacTRF?=
 =?utf-8?B?d0NzTDBYYWUyUHcyY2QyQU9nRm1oUWQzaFBiTjJKV0dCZU4yTlRLaitPZWxD?=
 =?utf-8?B?VlhsSlFjZW9TUm9SdXNSVTZqRVB1TE1pNDNYSzdFRjB3aVora3FEK0R3ZXBU?=
 =?utf-8?B?aUZPK3dDTHpXNVFLM3ZNM2pzR3VpaVZVSnJPVnJhZUNqeklNMmJ2T1J3ZEtP?=
 =?utf-8?B?VUNOUUNuVUNtakNKbklmNjVVUnB1Q2prQlQyZ3RZdEs0ZHRDcXdPUHBKbnNp?=
 =?utf-8?B?S2NkbTVISmVTZVRMclRzUmNMNE54c1ZhdkRNeks5NFFISkUzWU5yVXExVGJ1?=
 =?utf-8?B?cXNRUDB5U3U2L3R0bysraWhsQnVnbitIV0h1T1ZxTEd1SElMRStHeis5Z05G?=
 =?utf-8?B?TVVqVitUbmFoVVMrVXhUM1lHT0pWL2ZqNW5JQm52QkJqV01MdVUvY1hTaTFa?=
 =?utf-8?B?Q0Y5RzdhU2NXdDFqTGNydFRPaTh3eE9raXlZK1VHYm5TVXlvaVd3alhKelpD?=
 =?utf-8?B?TkNnZEtjT1ZRdzVBM3BIeEFaUjFsMnkxeXF4N2d0VEVXSmZld0J2YVN0bGIz?=
 =?utf-8?B?cjJCM2tycGFnOEx0VjRuK2oxTWVvd2w4ZitETGVSbTY0a2wrVEQrVktEblFy?=
 =?utf-8?B?aWFUbzAvaElXVXlwN05wQTRHenhEYTd2cmRMR0VtUjkxOGpETUdmUk1QazFu?=
 =?utf-8?B?NW1ucllSVUR5SlZ0RTFtZTFwc2JXZTNyZHdabTBuNWJxdUtrQStoOTZ3b1BN?=
 =?utf-8?B?Z1FZSjhKRmYvY1Jsang4SEExbWZ6MlFCV2ticTRjS1MzSDNBYXNGV0xmVlgw?=
 =?utf-8?B?bHYyWXFPT3VVUUtnU0h5QXZUSlpiWEJzVHlpMzlRbmNyZ3ZnT3FEdUpLZWtl?=
 =?utf-8?B?cFU1RzZCL2VzU1RZa1BlYnJVM2NOWEFYczJvYjFsd2trRzhBamVQbHBndHdJ?=
 =?utf-8?B?UkIyN2NWWGIrWVZOZjBXek5Cb1pzd00welBLOWI3QXRES0YzU2gzOU03M3Ay?=
 =?utf-8?B?NUkxdW1TbUVTczB5ZzMzclBUVTErOFJpL09ycHBoQlVWNUVIbXFaZWIyZ0ZG?=
 =?utf-8?B?T2xEaG9EMGhsbDI2R0pxbVk3US9nPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DAD9598D28A28D41B3EA951ED9339F96@namprd02.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV8PR02MB10287.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac97f04d-ecaa-4959-548b-08dc947ca14f
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jun 2024 18:36:58.2628
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: X0iUyHqgF+JNNBTV2CC7HKYT5a/o6R45xx1d2OiP3v6M1x0Fcr7XrBdaSjmDcMAXfNL8KnQ4DE7SZlcZkVckJjT3KclK7BGlG5fRR8+3MMY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB8499
X-Proofpoint-GUID: OIj4s_owDKHbNXVKiQSIzrKi5XtVHnCu
X-Proofpoint-ORIG-GUID: OIj4s_owDKHbNXVKiQSIzrKi5XtVHnCu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-24_15,2024-06-24_01,2024-05-17_01
X-Proofpoint-Spam-Reason: safe

DQoNCj4gT24gSnVuIDIwLCAyMDI0LCBhdCAzOjU44oCvUE0sIEpha3ViIEtpY2luc2tpIDxrdWJh
QGtlcm5lbC5vcmc+IHdyb3RlOg0KPiANCj4gT24gVGh1LCAyMCBKdW4gMjAyNCAxOTo0OTo0NSAr
MDAwMCBKb24gS29obGVyIHdyb3RlOg0KPj4+IGNoYW5uZWwgaXMgYSBiaXQgb2YgYW4gb2xkIHRl
cm0sIHRoaW5rIGFib3V0IGludGVycnVwdHMgbW9yZSB0aGFuDQo+Pj4gcXVldWVzLiBldGh0b29s
IG1hbiBwYWdlIGhhcyB0aGUgbW9zdCBpbmZvcm1hdGl2ZSBkZXNjcmlwdGlvbi4gIA0KPj4gDQo+
PiBUaGFua3MgZm9yIHRoZSBwb2ludGVyIG9uIG1hbiBldGh0b29sIC0gb25lIHF1ZXN0aW9uLCBQ
cnplbWVrIGhhZA0KPj4gYnJvdWdodCB1cCBhIGdvb2QgcG9pbnQgdGhhdCBldGh0b29sIHVhcGkg
c2F5cyB0aGF0IGNvbWJpbmVkIHF1ZXVlcw0KPj4gdmFsaWQgdmFsdWVzIHN0YXJ0IGF0IDE7IGhv
d2V2ZXIsIEkgZG9u4oCZdCBzZWUgYW55dGhpbmcgdGhhdCBlbmZvcmNlcyB0aGF0DQo+PiBwb2lu
dCBpbiB0aGUgY29kZSBvciB0aGUgbWFuIHBhZ2UuDQo+PiANCj4+IFNob3VsZCBJIGp1c3Qgb21p
dCB0aGF0IGNvbXBsZXRlbHkgZnJvbSB0aGUgY2hhbmdlLCBzaW5jZSB0aGUgZmllbGRzDQo+PiBh
cmUgemVybyBpbml0aWFsaXplZCBhbnlob3c/DQo+IA0KPiBOb3Qgc3VyZSB3aGF0IHRoZSBjb21t
ZW50IGFib3V0IDEgdG8gbWF4IGlzIGludGVuZGluZyB0byBjb21tdW5pY2F0ZS4NCj4gQnV0IEkn
ZCBndWVzcyBpdCB0cnlpbmcgdG8gY29udmV5IHRoYXQgb24gU0VUIGRyaXZlciBkb2Vzbid0IGhh
dmUgdG8NCj4gd29ycnkgYWJvdXQgdGhlIHZhbHVlIGJlaW5nIGNyYXp5LCBpZiBpdCBzZXRzIG1h
eCBjb3JyZWN0bHkuDQoNCkpha3ViIC0gdGhhbmtzIGZvciB0aGUgcG9pbnRlciBvbiB0aGUgY29k
ZSBzdWdnZXN0aW9uLiBJ4oCZbGwgc2VuZCBvdXQgYSB2Mg0Kc2hvcnRseS4gTm90ZSwgY2hlY2sg
b3V0IGVuaWNfc2V0X2ludHJfbW9kZS4gSW4gYm90aCBNU0kgYW5kIElOVFggY2FzZXMNCnJxX2Nv
dW50IGFuZCB3cV9jb3VudCB3aWxsIGJlIDEsIHRob3VnaCBpbiBJTlRYIHRoZSBmaXJzdCBJTlRS
IGlzDQp0cmVhdGVkIGFzIGNvbWJpbmVkLiA=

