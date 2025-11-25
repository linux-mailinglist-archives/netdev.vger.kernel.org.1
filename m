Return-Path: <netdev+bounces-241621-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE3FCC86E79
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 21:01:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 676473B4866
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 20:01:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BF3123ED6A;
	Tue, 25 Nov 2025 20:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="hHAIM1Hh";
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="FbsR8EDq"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-002c1b01.pphosted.com (mx0a-002c1b01.pphosted.com [148.163.151.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A3051A9FA4;
	Tue, 25 Nov 2025 20:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.151.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764100878; cv=fail; b=Gv/V65N9D908TB46kmgRCPh4bevZ8WdWODBxd8KpHcZdR+dcEsafrrW/MnGQuqeYw1gdEulj1xNiKrfV60wLMdqf75C4cG9O+VBDZSr3ip264B5h+PTVEtv+8fBKBRpPZ5Sz/XXD3VPx/eFGZ2DAGEdW7pc6zB5VrFL99WVq4LA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764100878; c=relaxed/simple;
	bh=MQmW/GGuGpofxAA6WIWTg8egtWFhiH2JxGcK9lkwejE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=A55eDO3XrVjjuqBb4CdmaiHx3GvYo3bFM24cLjdQWu4l8GewLsHbEa1adlH9kcO5fyBAmhZkNKxNG2yHJL37RBDLzSDC98KCrL9VDC6dzj7x3CJEelBqywIB+m1Axy5cXBSTwykzwP5l7DdDJ5nOS46LBfbkMDA77R52/fPNjUk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nutanix.com; spf=pass smtp.mailfrom=nutanix.com; dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b=hHAIM1Hh; dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b=FbsR8EDq; arc=fail smtp.client-ip=148.163.151.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nutanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nutanix.com
Received: from pps.filterd (m0127837.ppops.net [127.0.0.1])
	by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5APGKYjr2183742;
	Tue, 25 Nov 2025 12:01:02 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	proofpoint20171006; bh=MQmW/GGuGpofxAA6WIWTg8egtWFhiH2JxGcK9lkwe
	jE=; b=hHAIM1HhJ+zj4N/1IknjpzVSyV1IBoNxEm35fiikkrr4FpurbGa5Tc6Lv
	aUhSKgL+Q8DmGNYQ/n0pCoWZB75Vt0RtQpikim2257Nzhtp1rZ0O39T07yRzw+k6
	WVy+/I8/CMiWopxQA5op29XXa3VwLHuYvKcXP11m1w2Tc2AuGem/RoA4Tc+F4bnb
	Zmgd3ZXVwiFr/smV6Tq/vMnb/Wbf28RFFCGo2fLs8yO0p5nebnmOmWSd0lUVikXC
	uDpv2ww+CbXlfWCTtaLhpfOtbeKEy8vXSERpMVajw7jVXuAC4chOw9iENMCyZivm
	NyaE4aIAsq0MzQ9p2tECy1oWpivUQ==
Received: from dm1pr04cu001.outbound.protection.outlook.com (mail-centralusazon11020079.outbound.protection.outlook.com [52.101.61.79])
	by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4anfw40f6p-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 25 Nov 2025 12:01:01 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dGNOGYoOpmv66ZSQBEHXCyTq55fjoMBX4/ThW8wORdXKXQotuIjC+oG/PmHnj2u/0xtEQ8D2np3hVfpdIV5/wr53uOp0TpGUakM2t0GudgCTrzYOKlEBgz9ixBpwCyMQOXHfxD9dPLQlL6mXTCsA3EtKIj7wT2e5mQpKxrYu+c4PyUZlZFI3IBUx6Qjh375wi9RtwjyqtdkJF+Ns2ZpBga1be8c4cCM9yR2kLmOI2reo5AmUDuwCaNvRjBEin1U70AtLskAZHS1COYFz/wLlfv+GbAXSd2bzjpruQzy8Ys1bXrBqrMy73sc+oKDOehJ6lekUWyGu5eGUEeztscvozA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MQmW/GGuGpofxAA6WIWTg8egtWFhiH2JxGcK9lkwejE=;
 b=UiPDWmM19EaTVJcaPXyu/huuhBz8Tes/OYUKIWDXH4VDVGi0afuiXLktoKYqgOkA9Yid1HjjP2/ibXb5VsNnWzlikVdc7T0T7GqKiNNkZK4KlgL1paGoPv3eqtW/IuB3u55+O0+N5nPUKLwlFnXnpir8yWLc6om2chTvIa8h3dzsZbsSXys8kEPzdjJLr77FUZ6B1WHNsW/zYEAYaO6xcUroFlSWiGLa7m3Aj8D27KbJvTwh7iSahwrIivr4XSr5wRZMHE8J+iamzxi48dEyinX6s0FnhOJTvk0iHlwHb7OaWs9gFaTXHhsWmsEiADWi1m75TochVrofvlZYQdyFPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MQmW/GGuGpofxAA6WIWTg8egtWFhiH2JxGcK9lkwejE=;
 b=FbsR8EDqpcfXaEOulG60zqkIyHnIWSXjoT4Fdk9+SjyH9nDkEbnnfJL7DtmndQoJYa40sg2UcwGb4UV44NlWJuZYairXwj2l8MMtrQjpv5G/bi7djkFPqrmq1e2liKfm1oGX0QZqlTEIP1Pw3rV4KYy6Nu6LWLYeTBOCQGaJYKdxUbdvANL6ksJxCwSWAAbRx1L5PWphhnHdj2clK0wBdnLjnFwNbNZBuZH+IfpHI7qWQwwd57cYlcHAGoOgaBhWqa1aCkiNlZA0tH97ZT1hIEgVs5xD4Yl2Cb8ws2OrfFXZDS90bDSlnMIrvUte1M0i4hBatgKlluMM0OIvXFwXGg==
Received: from LV0PR02MB11133.namprd02.prod.outlook.com
 (2603:10b6:408:333::18) by IA1PR02MB9232.namprd02.prod.outlook.com
 (2603:10b6:208:424::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.17; Tue, 25 Nov
 2025 20:00:55 +0000
Received: from LV0PR02MB11133.namprd02.prod.outlook.com
 ([fe80::10e5:8031:1b1b:b2dc]) by LV0PR02MB11133.namprd02.prod.outlook.com
 ([fe80::10e5:8031:1b1b:b2dc%4]) with mapi id 15.20.9343.016; Tue, 25 Nov 2025
 20:00:55 +0000
From: Jon Kohler <jon@nutanix.com>
To: Paolo Abeni <pabeni@redhat.com>
CC: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        =?utf-8?B?RXVnZW5pbyBQw6lyZXo=?=
	<eperezma@redhat.com>,
        "virtualization@lists.linux.dev"
	<virtualization@lists.linux.dev>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
Subject: Re: [PATCH net-next] virtio-net: avoid unnecessary checksum
 calculation on guest RX
Thread-Topic: [PATCH net-next] virtio-net: avoid unnecessary checksum
 calculation on guest RX
Thread-Index: AQHcXi4zHSZXDxRn7E2vwL8pjtv0WLUDramAgAAiWAA=
Date: Tue, 25 Nov 2025 20:00:55 +0000
Message-ID: <3ED1B031-7C20-45F9-AB47-8FCDB68B448E@nutanix.com>
References: <20251125175117.995179-1-jon@nutanix.com>
 <276828c5-72cb-4f5c-bc6f-7937aa6b6303@redhat.com>
In-Reply-To: <276828c5-72cb-4f5c-bc6f-7937aa6b6303@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3826.700.81)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV0PR02MB11133:EE_|IA1PR02MB9232:EE_
x-ms-office365-filtering-correlation-id: e4c0e364-db08-429e-2d1a-08de2c5d57fb
x-proofpoint-crosstenant: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|10070799003|376014|366016|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?Y0d3R3hiSTdsS3QweHpMMUNGUGM1ek1QNjVPaGV3SE9UcEFuVWJCK3lobzNQ?=
 =?utf-8?B?VmJ3eG1YeDgxR1AraFJDYitNWklEdHRmNEpPRFN2MVhXcytZdVZzdGJIN0ow?=
 =?utf-8?B?Y1dBS3MrVDNEWTNLdjJpN0lwUTg5VVJONlRsOU1ONmlvdWZBWGw1M08xcG5Q?=
 =?utf-8?B?azZYY1V1TVBXdkFJUjZLL3BRb3ZHdUhSZnhnSXpFSEpqb0liK0tYOThhcmhP?=
 =?utf-8?B?UjhVQ3daZkEveFlKcUFBd09WblUyUDYvampVODhadGgxSFF1YTA3YUlTNjV3?=
 =?utf-8?B?bkZjYzFUQVBkY1dUZ0dUdWVUNVVFODFObGNhSnVxNkdqZnk3VUlxQlRnR0Rx?=
 =?utf-8?B?M1c5V25rQ0RlSnNKeWJyVE1iVy9nZ0lTZVorQ01xWFliZDVTWEZKS3d0UEFo?=
 =?utf-8?B?RHJJZTk5NkZuR2s2UFdNbkZ4YzlIZ3hRbVAyM0pOdjBlNEZ0Z1pBTCtoZUZB?=
 =?utf-8?B?U3dEb05BajBEaHk5Mi9YWTQ4eSt6K05rbkV5UU5zY3k3dFNQYk1VYk85NmhK?=
 =?utf-8?B?MlhJNUFLYmFEUGdveFZZeVhRRWszNkJKdFMyVmZKTHEvTkl4SktEcWRPRlZ1?=
 =?utf-8?B?V3FRVEx0TEJBNWN0RWRXK080akVkYXBlallDWlpCd25Lc3crN2gvaXNxaVVE?=
 =?utf-8?B?QkFpVHE3dGN2Tys2WTZyMzJWa2R3S3lycThQT21WTXJhSnhWZjFhUDVURWxu?=
 =?utf-8?B?MVQzdVY3TGEwSU9rc1kzdGVLMlp6ZXFyU3YrYk9PS3kzcjlJaTlRWDdBRzVV?=
 =?utf-8?B?VUdCdVZ2ekRmc3ZwV0hwenR1VUZlZHhLUU9qbk5nRjhVOGVTTGF0aGpaa2xx?=
 =?utf-8?B?dExPTTZSZVFjOGRGOGo2akc2VmU3Zm9HSFkrWVU1OTh3OEo4RnNoK2xkYVg2?=
 =?utf-8?B?bTZlamkrMkpNVEZ0TENCRWF3aWZvN1pzYVhjTFpWTWFBeXQ2N2FxN3VXVjEz?=
 =?utf-8?B?Q0kxZDBiL29DaEdWam9EKzI2aTVjZFRyTHB4N1RidW1HNU4yUFBNSUZvb25M?=
 =?utf-8?B?aVJCcFhibzlCSGVmdDVaTTh0dmUvYk92NW9tYlV3QmVYbTZnczBxQk9td0ts?=
 =?utf-8?B?UkhOZEprM0JYMlpxVXRhY2JWaUtPcUx5OWdnajlib1QzdU5VOVBzSHNDZHZi?=
 =?utf-8?B?V0pvUFZFWnA3ZmZWOGk5dUIycExKYlN0ajQ2MjZvdXZacUpjQmZmQ1Q5dEFT?=
 =?utf-8?B?S3RVeWZodFBac1hzd1Q4dS92ZDE2eUt6SHhOWVVGOSs3Z0Y3SThIOWRwUlJp?=
 =?utf-8?B?UkdkODhpc3ZYMmhBYWdGTnNSZDdUY3ZVdkdPMTBMUnYySlBNVkh0amJSdTFs?=
 =?utf-8?B?LzZQSVRiZ2NRNUdxVTkxUlUvRGhPSzhBeUx6S3lwRHI0ZXRaeHJUc2ZMOXVp?=
 =?utf-8?B?Znp2ZUlUNzljcFY0b29iQ1FuaTVhMmQ3VU9FOGJ1TXJSQXZiRlJEL1FrK3ZG?=
 =?utf-8?B?NkkzOFBaVWlLdTRzVTl4czYyc0pMViszZFVncWVYYmpFOERKR1gwck5GYlBH?=
 =?utf-8?B?MFNCMjBIbjF5QTYvd3RUT0JMeGhhME1RaHo1d1ZwOGRIVGRXNnF4bVpEaHU2?=
 =?utf-8?B?RGJRbE5saSt6RjlaK2JYSzd0dHBnaks3UFVZYit6NmZocVZ5T25EMlRjMnFq?=
 =?utf-8?B?NlBLQjA1VXBicGlWaW9QRHB5eTNab3pZRE1oTlA4SkJBaklYeGVGSGFrSFZQ?=
 =?utf-8?B?QmtNRDZ6SmVXZWUrOXIvQTg4bU9kS2p1bHRqN2I1VFNWL2NpeStHUXA5OVBt?=
 =?utf-8?B?SHBra2g4Mk9IcDFxeitZT0tvTHBFOTA5M1UwUmZ4Q2Rlb0wrdHppbkpSbUpV?=
 =?utf-8?B?UHlFSDFRZ1NOb3RadkxzQzU3Z0RRMFE5UTVEZ2VKdURZcWdiVUxxeFBtVEpY?=
 =?utf-8?B?NFBnOE83bUZ6R0M1YW9ZMHNxeHNNbmsyQXlIdFdJcWE1WU9tMVRrQ09LUCt6?=
 =?utf-8?B?YzY2SWN2NEF2UEd6UlF0QkI1alh2bkRnTWJMZ216V0lPK1VNeVJZODBUTzEw?=
 =?utf-8?B?ZnAzN0xtUXpJamhZNkU2TVpKQlR2SXdWMXdDTE5oa3FWVUVYOXRWUkUwVEwy?=
 =?utf-8?Q?8/gX9Q?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV0PR02MB11133.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(376014)(366016)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?S0tQYlFSblZRc1VOUm03SGFqcWNXb2FkS0FGZU5EaTVPdi80YWsrN0VjLzB4?=
 =?utf-8?B?QmdGSDdScnFPSENOTjNkVVYzUVZDQjgrZGNxaUtvWGtEYVAyYUZxT09na25X?=
 =?utf-8?B?R3BWcnFQZWprbnJWTm1JZFNCWlhvczMrOVp0ckFFRit3OWZXSGFqd1NSNjd2?=
 =?utf-8?B?UTBpa05lUHhkQjFBWStRQ0RrS21Tc1RPRlc3bVRNOEo1bEVPZUdIWjlSeGxo?=
 =?utf-8?B?clBMZlp1T3o2bUJnLzRvbmM5eWRRR3hieWRUSXYzU2VuZGRXNGowSXN5Z2dW?=
 =?utf-8?B?aWJDZlE2RkZOZkoyTkMrVkRHalR2RDZwdE5Za0lSTURjbGJ2ajNyTld0dUpl?=
 =?utf-8?B?TVVtY3FFMFVmTDBEbjY2WTNCMWtrYk1uZ1hhTGZlUC9PY0RYczlqeEYzU21j?=
 =?utf-8?B?aFJKVTNheXYyd1pSR3RhZUgwY3VyRmEwU1dBL29yUmZvS016dy82d0c1UmNI?=
 =?utf-8?B?NENwWEdYa1NvelN3VWpMR1l6YkN4SWJ2RlZGUExyQy9COVhpeENkblA2cldP?=
 =?utf-8?B?MXFpOXJIYkw1L3hSV3Y4Z09kcG9wTzJGcGRJZXh0NWc2Um13bm9CdlBlSVVR?=
 =?utf-8?B?SmlHS2hhMnBQc0RSMVhLODV2ZXdwcUJ2TmRQU2c0K0J6Y3NCNWZSRGVCalZD?=
 =?utf-8?B?SnYySWUxMTZobW54RWE3TmVjd2Z6dGNYLy83WGJMQzRod0ljYWI1Y0pDU2U4?=
 =?utf-8?B?cG1Cb1o5cVlSL0pMYXgrZkZzUXhPeVpJZXdKS292ak9KOUV0VXRTWXhhV29F?=
 =?utf-8?B?anVHWHp2U3RUU2ZDa2dNenB3NUZUZE4zanFhZkNCcGVhTDRvempiR0tDWjBP?=
 =?utf-8?B?VDhGL0VBUEZLMmx6cVZ4dlZjMGVWZEV1SHZMRXdGcTVUajN2MWtTVkFJbHhE?=
 =?utf-8?B?eG5rYUl5MHJ6WVo5MHpQVHlWU2pQVlNTc3ZrMVFtVXoycU9pcnhjQmhzb1d1?=
 =?utf-8?B?YTdSM3ptTzhONGJiSlFHWk0xUDJaUlMyVk5UWmc1OG5mQXdQUFlmUk04ODlz?=
 =?utf-8?B?NWV6TXFFZGlMb3NadGNPblNIaTNvUlc1bnNxTDJZdWNyME1xZC9Gb3JvS2J2?=
 =?utf-8?B?S3NqTlZyZWRWZm8raWZKaS9jYWxtcmhQVSs4cU5jSjNtTy8yWXJZdThDZGRv?=
 =?utf-8?B?S1V5RE81QlYyNHAvUE12SFhwS0tOMFoycjJpS0xDZzdEUUxPdmZkR3JIM3RB?=
 =?utf-8?B?SnNYbllCU21lS2NodGQwcFNzR0dGaW1QTXBpOStXUHR5OTlZVWpxaHc2SjRl?=
 =?utf-8?B?Y09WbGVTbThiWk92ZkZFOW1qNmlEV1dGMXpPR1RCT1ZqcXVmaUdzcUJmcFhI?=
 =?utf-8?B?T2JiTXZEVGNnTGVkWmppTEVDeG5Ja2pQWVd3QlBsaVd4MFhmb0tGdUliUUp0?=
 =?utf-8?B?K1Bsb0dlY0Q3THdmRWcrRCtRVThGdzVYWDBuUXErcnRaTnJPa3dDMklBWFp4?=
 =?utf-8?B?QzZiMGYwcUtYRkxHa1Fkb21FWkptd1RXYXRqeXRYT0tXRzJBSHVLYlZEN1h0?=
 =?utf-8?B?emJOR0xiVW9vNW5GVVhFOFhldWN3c1RNUTIzNGxKSGJwVDNRZ1ZKd01IRWdV?=
 =?utf-8?B?Yk93WjIvcVJDQ2c3bGV3d2Q5MUFSMVJzNkFLTWxsbEhuYkg2SzhWeGREOTZI?=
 =?utf-8?B?MnRjWU1McnlPTVMrSkJkYm8xLzc0L0lDVnNyMVlwRGUwQzluMm1pdlh3VEMw?=
 =?utf-8?B?NXhrQ0NZVEpkZWZaeDRHU1RiYi9wSExNL3BZUTgxR1Y0S3hmcnJsUUtWZHp6?=
 =?utf-8?B?WE1udklTUFlWdEtZOVZJMHVxbkJ6bjFtSWQ3azNaQ2VjRTRUMXRZUXBISy9V?=
 =?utf-8?B?azVhQnlEZENFY3ZQRnhKZVdqWE5ybFZNU0l6VXVnZzY0d3JvK2lJdk5DclZy?=
 =?utf-8?B?Mk45TEZtSm5DVzdXSkh4T2VVWGdUK3E4WGxWZTFOY0JNaFk1U0JzVXRpWjc2?=
 =?utf-8?B?Szc3ekNKWkcwNXdRcE8wWE80VlkzbzIwN1lld3o2bTA5am9xR2t4OFJJWlBK?=
 =?utf-8?B?V2ppZnNaRDdiVVdkVkZYZnpnc0lUU0RhUEpLV2xWMCs4bzRtZHRFRjJLK08v?=
 =?utf-8?B?UmM5SEZSSmdLKy9CV3lpU2c5aEhIRm9vSmlTSFhreHA5UFpuMmpDcFIwOU41?=
 =?utf-8?B?TnBLWmpIZGRpWjgxeEZ0Rjdway9CbjVSVGZHeWJZZk9qTlplWmV4bHN1OHIz?=
 =?utf-8?B?cXpsVVNWdG9TMlQzYU9US2E1SjZ6NkRUdHE1RkFXV3ZSSXRnWjVvNWhOV0Mz?=
 =?utf-8?B?WmxzYXkwY3AwOUthTUN5YWR0R3ZRPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A8DF616BD8E85749A96E08F1C0369530@namprd02.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV0PR02MB11133.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4c0e364-db08-429e-2d1a-08de2c5d57fb
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Nov 2025 20:00:55.2063
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ruZgWuHSm1HsNbUTzbfiu6CiGKHcfmUr6wVzKC/RyetlsXOmlvUfHQgwExM6chCBBheuq+bi46wdZhS6Q+ROJB4UkiRuzl6+442IoCkr1Gc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR02MB9232
X-Proofpoint-GUID: iwEOkpD25WPRxC4O6Le7RZ6ObXJSk-kX
X-Authority-Analysis: v=2.4 cv=NfzrFmD4 c=1 sm=1 tr=0 ts=69260afd cx=c_pps
 a=tlGIxjjmudfNB24gcMuLIA==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=0kUYKlekyDsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=20KFwNOVAAAA:8 a=64Cc0HZtAAAA:8 a=qoV-IuvPFgGxuQk0rBEA:9
 a=lqcHg5cX4UMA:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: iwEOkpD25WPRxC4O6Le7RZ6ObXJSk-kX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI1MDE2NiBTYWx0ZWRfX+wSWkjayd/E2
 FBaf++OoMFzPRsEvGmFAL6OOQvahoTzPkuZO0dDGUCiqK/1OoE9xowe62aA+yiAon1LDZFk5Bhp
 yuFDduM7NnZVFVqdPZOKWur3v/nGyiiXtUyzmY/IMVcmM/RVlKXCN3txAfqZwUMhAAO+wkBKDaK
 jfMcQH8ES9TzvbaJnbPjfl9trd4cco5ZYN+NmmTrT29jKt5sfMzWWxUKS6XWVfE4NmV4EMjAn8S
 YHZze1PiLdiHKhkClDPdGBIkxGW1Y79HES/QCvVX8sNbVG4IT8tXYEFngiDt5rIgIOUCIj6BbLe
 8fnP9KnNo6FbeWorce34i2lo2TKcAg0XpkeEmKuCvJWPEhOWy669BXTDhahVwz/IyF9DcIWuUaF
 da8F6rPhCDGALuJl+k9R59g/rR5bpA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-25_02,2025-11-25_01,2025-10-01_01
X-Proofpoint-Spam-Reason: safe

DQoNCj4gT24gTm92IDI1LCAyMDI1LCBhdCAxMjo1N+KAr1BNLCBQYW9sbyBBYmVuaSA8cGFiZW5p
QHJlZGhhdC5jb20+IHdyb3RlOg0KPiANCj4gQ0MgbmV0ZGV2DQoNClRoYXRzIG9kZCwgSSB1c2Vk
IGdpdCBzZW5kLWVtYWlsIC0tdG8tY21kPScuL3NjcmlwdHMvZ2V0X21haW50YWluZXIucGwsDQpi
dXQgaXQgbG9va3MgbGlrZSBpbiBNQUlOVEFJTkVSUywgdGhhdCBvbmx5IHdvdWxkIGhhdmUgaGl0
DQpWSVJUSU8gQ09SRSBBTkQgTkVUIERSSVZFUlMsIHdoaWNoIGRvZXMgbm90IGluY2x1ZGUgbmV0
ZGV2QA0KDQpTaG91bGQgdGhhdCBoYXZlID8NCkw6IG5ldGRldkB2Z2VyLmtlcm5lbC5vcmcgPG1h
aWx0bzpuZXRkZXZAdmdlci5rZXJuZWwub3JnPg0KDQpTYWlkIGFub3RoZXIgd2F5LCBzaG91bGQg
YWxsIGNoYW5nZXMgdG8gaW5jbHVkZS9saW51eC92aXJ0aW9fbmV0LmgNCmJlIGNj4oCZZCB0byBu
ZXRkZXYgREw/DQoNCkkgc3VzcGVjdCB0aGUgYW5zd2VyIGlzIHllcywgSeKAmWxsIHNlbmQgYSBw
YXRjaCBmb3IgdGhhdCBpbiB0aGUNCmludGVyZXN0IG9mIG5vdCBoYXZpbmcgdGhpcyBpc3N1ZSBh
Z2FpbiA6KQ0KDQo+IA0KPiBPbiAxMS8yNS8yNSA2OjUxIFBNLCBKb24gS29obGVyIHdyb3RlOg0K
Pj4gQ29tbWl0IGEyZmI0YmM0ZTJhNiAoIm5ldDogaW1wbGVtZW50IHZpcnRpbyBoZWxwZXJzIHRv
IGhhbmRsZSBVRFANCj4+IEdTTyB0dW5uZWxpbmcuIikgaW5hZHZlcnRlbnRseSBhbHRlcmVkIGNo
ZWNrc3VtIG9mZmxvYWQgYmVoYXZpb3INCj4+IGZvciBndWVzdHMgbm90IHVzaW5nIFVEUCBHU08g
dHVubmVsaW5nLg0KPj4gDQo+PiBCZWZvcmUsIHR1bl9wdXRfdXNlciBjYWxsZWQgdHVuX3ZuZXRf
aGRyX2Zyb21fc2tiLCB3aGljaCBwYXNzZWQNCj4+IGhhc19kYXRhX3ZhbGlkID0gdHJ1ZSB0byB2
aXJ0aW9fbmV0X2hkcl9mcm9tX3NrYi4NCj4+IA0KPj4gQWZ0ZXIsIHR1bl9wdXRfdXNlciBiZWdh
biBjYWxsaW5nIHR1bl92bmV0X2hkcl90bmxfZnJvbV9za2IgaW5zdGVhZCwNCj4+IHdoaWNoIHBh
c3NlcyBoYXNfZGF0YV92YWxpZCA9IGZhbHNlIGludG8gYm90aCBjYWxsIHNpdGVzLg0KPj4gDQo+
PiBUaGlzIGNhdXNlZCB2aXJ0aW8gaGRyIGZsYWdzIHRvIG5vdCBpbmNsdWRlIFZJUlRJT19ORVRf
SERSX0ZfREFUQV9WQUxJRA0KPj4gZm9yIFNLQnMgd2hlcmUgc2tiLT5pcF9zdW1tZWQgPT0gQ0hF
Q0tTVU1fVU5ORUNFU1NBUlkuIEFzIGEgcmVzdWx0LA0KPj4gZ3Vlc3RzIGFyZSBmb3JjZWQgdG8g
cmVjYWxjdWxhdGUgY2hlY2tzdW1zIHVubmVjZXNzYXJpbHkuDQo+PiANCj4+IFJlc3RvcmUgdGhl
IHByZXZpb3VzIGJlaGF2aW9yIGJ5IGVuc3VyaW5nIGhhc19kYXRhX3ZhbGlkID0gdHJ1ZSBpcw0K
Pj4gcGFzc2VkIGluIHRoZSAhdG5sX2dzb190eXBlIGNhc2UuDQo+PiANCj4+IENjOiBQYW9sbyBB
YmVuaSA8cGFiZW5pQHJlZGhhdC5jb20+DQo+PiBGaXhlczogYTJmYjRiYzRlMmE2ICgibmV0OiBp
bXBsZW1lbnQgdmlydGlvIGhlbHBlcnMgdG8gaGFuZGxlIFVEUCBHU08gdHVubmVsaW5nLiIpDQo+
PiBTaWduZWQtb2ZmLWJ5OiBKb24gS29obGVyIDxqb25AbnV0YW5peC5jb20+DQo+PiAtLS0NCj4+
IGluY2x1ZGUvbGludXgvdmlydGlvX25ldC5oIHwgMiArLQ0KPj4gMSBmaWxlIGNoYW5nZWQsIDEg
aW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pDQo+PiANCj4+IGRpZmYgLS1naXQgYS9pbmNsdWRl
L2xpbnV4L3ZpcnRpb19uZXQuaCBiL2luY2x1ZGUvbGludXgvdmlydGlvX25ldC5oDQo+PiBpbmRl
eCBiNjczYzMxNTY5ZjMuLjU3MGM2ZGQxNjY2ZCAxMDA2NDQNCj4+IC0tLSBhL2luY2x1ZGUvbGlu
dXgvdmlydGlvX25ldC5oDQo+PiArKysgYi9pbmNsdWRlL2xpbnV4L3ZpcnRpb19uZXQuaA0KPj4g
QEAgLTM5NCw3ICszOTQsNyBAQCB2aXJ0aW9fbmV0X2hkcl90bmxfZnJvbV9za2IoY29uc3Qgc3Ry
dWN0IHNrX2J1ZmYgKnNrYiwNCj4+IHRubF9nc29fdHlwZSA9IHNrYl9zaGluZm8oc2tiKS0+Z3Nv
X3R5cGUgJiAoU0tCX0dTT19VRFBfVFVOTkVMIHwNCj4+ICAgICBTS0JfR1NPX1VEUF9UVU5ORUxf
Q1NVTSk7DQo+PiBpZiAoIXRubF9nc29fdHlwZSkNCj4+IC0gcmV0dXJuIHZpcnRpb19uZXRfaGRy
X2Zyb21fc2tiKHNrYiwgaGRyLCBsaXR0bGVfZW5kaWFuLCBmYWxzZSwNCj4+ICsgcmV0dXJuIHZp
cnRpb19uZXRfaGRyX2Zyb21fc2tiKHNrYiwgaGRyLCBsaXR0bGVfZW5kaWFuLCB0cnVlLA0KPj4g
ICAgICAgIHZsYW5faGxlbik7DQo+PiANCj4+IC8qIFR1bm5lbCBzdXBwb3J0IG5vdCBuZWdvdGlh
dGVkIGJ1dCBza2IgYXNrIGZvciBpdC4gKi8NCj4gDQo+IHZpcnRpb19uZXRfaGRyX3RubF9mcm9t
X3NrYigpIGlzIHVzZWQgYWxzbyBieSB0aGUgdmlydGlvX25ldCBkcml2ZXIsDQo+IHdoaWNoIGlu
IHR1cm4gbXVzdCBub3QgdXNlIFZJUlRJT19ORVRfSERSX0ZfREFUQV9WQUxJRCBvbiB0eC4NCg0K
QWghIEdvb2QgZXllLCBJ4oCZbGwgc2VlIHdoYXQgdHJvdWJsZSBJIGNhbiBnZXQgaW50byBhbmQg
c2VuZCBhIHYyDQo+IA0KPiBJIHRoaW5rIHlvdSBuZWVkIHRvIGFkZCBhbm90aGVyIGFyZ3VtZW50
IHRvDQo+IHZpcnRpb19uZXRfaGRyX3RubF9mcm9tX3NrYigpLCBvciBwb3NzaWJseSBpbXBsZW1l
bnQgYSBzZXBhcmF0ZSBoZWxwZXINCj4gdG8gdGFrZSBjYXJlIG9mIGNzdW0gb2ZmbG9hZCAtIHRo
ZSBzeW1tZXRyaWMgb2YNCj4gdmlydGlvX25ldF9oYW5kbGVfY3N1bV9vZmZsb2FkKCkuDQo+IA0K
PiBBbHNvIHlvdSBuZWVkIHRvIENDIG5ldGRldiwgb3RoZXJ3aXNlIHRoZSBwYXRjaCB3aWxsIG5v
dCBiZSBwcm9jZXNzZWQgYnkNCj4gcGF0Y2h3b3JrLg0KPiANCj4gL1ANCg0KTm8gcHJvYmxlbXMg
b24gY2PigJlpbmcgbmV0ZGV2LCBqdXN0IGRpZG7igJl0IHJlYWxpemUgdGhpcyBvbmUgaGVhZGVy
IGRpZG7igJl0DQphdXRvIGNjIHRoZSBsaXN0LiBXaWxsIGtlZXAgYW4gZXllIG9uIHRoYXQsIGFu
ZCBoYXBweSB0byBzZW5kIGEgcGF0Y2ggdG8NCk1BSU5UQUlORVJTIGZpbGUgZm9yIGRpc2N1c3Np
b24u

