Return-Path: <netdev+bounces-106706-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 677A7917542
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 02:37:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F79D28499C
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 00:37:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56102522A;
	Wed, 26 Jun 2024 00:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="oAK8uKri";
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="Cw75lCKs"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-002c1b01.pphosted.com (mx0b-002c1b01.pphosted.com [148.163.155.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA76479CE;
	Wed, 26 Jun 2024 00:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.155.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719362260; cv=fail; b=hR5QeMRTYwvm49QpDbd6QG+C3xInOB2I0TJhs+M6UfyDYEThjvjUaX8E/mfH7yTgayt7sAdv8WEZRiuHNn7NUAgJ2M2oLDcfLrws+KxuzPoNEWs7EgI1GJqIYPQL5QL+U7PpR8xEimpLCWSdQ6V6H1mtf+AjINqx7gJpuO4Z+4Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719362260; c=relaxed/simple;
	bh=ie8fgPC7ppAjlGQl1CIMe7lqYOFKIT5bH7uescY9BGg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=nqnjhBirmPqmPhg/GyX+g3SeZcS4b9pEXv2vgFn+00mlIZFDrzHdDX0ADvZUYq8NPIHaKOFlWMPAsYzzaT6m9LH8aioBlfx/udfRbQ2vyr7vNia9sDU3GRgryzHMjmzLupybJORRKb9o1fmb8qz/HjfzD3DKKTBEAGjHj9I6NsU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nutanix.com; spf=pass smtp.mailfrom=nutanix.com; dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b=oAK8uKri; dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b=Cw75lCKs; arc=fail smtp.client-ip=148.163.155.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nutanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nutanix.com
Received: from pps.filterd (m0127843.ppops.net [127.0.0.1])
	by mx0b-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45PK0FTO026437;
	Tue, 25 Jun 2024 17:37:28 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	proofpoint20171006; bh=ie8fgPC7ppAjlGQl1CIMe7lqYOFKIT5bH7uescY9B
	Gg=; b=oAK8uKriGmY+MfpUJM+HxAmiL/7c24NeewmDR1ukek+2Rf3wV7hTZDGa7
	Q44rJTccEhPVd/Zh0pnDgN4gBkuAhiv/K5Y1Jg9w3zn4r80bgjrroZiZ8dp46qa4
	ie/LhiW0waWpD2S7YMh6uzF9cmol4lo4JPqhgX0UxXNjkwFwpWbFgQCizbEX1jw8
	UXG402M1q0neZ5lxRRL4UK9SZbT7Nsoef5MFa5Rdw8/ppNWnIGnCfhrBMBeQyAGQ
	LBEWKV9QW0m7+KcbbuKqHJKZGeT8ZkVItYvT04YrydiWawkJK0cFTp4R59N9zMOC
	Pswn4a0BZ0USb+y1hv2+H88ss9OUg==
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2043.outbound.protection.outlook.com [104.47.74.43])
	by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 3ywvqfy515-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Jun 2024 17:37:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yo57maB84/IAQad+ifxanYQSeqTiT45rnCHwSVrBtSD/ywFje9IvyYuaBSDntVJPdNoBlTNLiIOz5qcy5IOs/S1RwxXBiMhYZK1cE96leONp0kqCc0U0l169FGTjWxUTujG32c9/RHoitXvjMgf4ZsakGI3Qu2qKpUnuBoaobyvLFMyhwO+eK/zW2RGA7WTYAU1xoDs7E6FIDMrI8C6vtKynyi6WGlhq2kiG+jfd9MshqEaji6xqXLcK4W5plnrss7G7N5B523S/663qfJHPjTlvn+JslFMow8W1X3HJFDj8rv5a8ueyM5Gf00ldDrvFSET3W3qmxzUcy54wS9p8yA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ie8fgPC7ppAjlGQl1CIMe7lqYOFKIT5bH7uescY9BGg=;
 b=iEe3pq3AvxPV7hYFktVs428qeIKHWuVnWJA1ukxDc6jcknP/ug7guEttE0KpAQIvzC5KT/Kku73smyiBFObxp3zWaKULPCMIuPUkPuEhOXSwxmir/wASiJ94jp8a4IBOhz6drQXbVzabzpViM9IDcGFKgVlWnoaQLcsKB1lyztZwpLjnPwezxzSeDKj5sJ+c6znchWad9fJE6pzCyr2MZ/TDsVRoJhL2WDRTVStAoFswkv02YNvKTwnOvNWe9Xtbct1WKWcVznWpDMmo4diMSIwRCc3CrFFuTZNCsfjhfUUEGWciJkcQef/ueSgnu4dawtCiGFv17KoLepZ4nmPy7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ie8fgPC7ppAjlGQl1CIMe7lqYOFKIT5bH7uescY9BGg=;
 b=Cw75lCKsvS4ICqWoJQYR2ebfnmyxRrF38KGfGHVYQLGy+oQin453LyVC9TN+xpQx2hr4xaepXWct4CPcVH6XoDdEeNpC+ytosclOnIPibuKP2OTCqqEe5Rz8HOIXuBdvDqqbaX/iy1Sz/ZYOdZnpFKdT3dCRr8bY/npTrUqEEEn7eYQrgxJ+F3etGjEP7VKV7c/TZrzQDgksMOEg/YIQS1fYglZ9l2ZfcIomhI+RpD4aIHjxpsY2ttUqfvt2jFxno+AWb0y+s2TjbRPVs3e7KerZWpL1trR5vhs+l08apqUO45kJZnUKtn7R7jQcsL432DgvC1M6iZVSt32nyej9JQ==
Received: from LV8PR02MB10287.namprd02.prod.outlook.com
 (2603:10b6:408:1fa::10) by SJ2PR02MB9315.namprd02.prod.outlook.com
 (2603:10b6:a03:4cf::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.31; Wed, 26 Jun
 2024 00:37:25 +0000
Received: from LV8PR02MB10287.namprd02.prod.outlook.com
 ([fe80::b769:6234:fd94:5054]) by LV8PR02MB10287.namprd02.prod.outlook.com
 ([fe80::b769:6234:fd94:5054%3]) with mapi id 15.20.7698.025; Wed, 26 Jun 2024
 00:37:25 +0000
From: Jon Kohler <jon@nutanix.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: Christian Benvenuti <benve@cisco.com>, Satish Kharat <satishkh@cisco.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
        "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] enic: add ethtool get_channel support
Thread-Topic: [PATCH v2] enic: add ethtool get_channel support
Thread-Index: AQHaxmV3ZX4ZExSXTk6BP3fPqsGVjrHZK7yAgAAJcwA=
Date: Wed, 26 Jun 2024 00:37:25 +0000
Message-ID: <EF2C8FF1-BD91-4F46-BFE4-D2855A43F739@nutanix.com>
References: <20240624184900.3998084-1-jon@nutanix.com>
 <20240625170325.77b9ddd5@kernel.org>
In-Reply-To: <20240625170325.77b9ddd5@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3774.300.61.1.2)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV8PR02MB10287:EE_|SJ2PR02MB9315:EE_
x-ms-office365-filtering-correlation-id: 99c4c684-5507-42cb-3ecd-08dc95782655
x-proofpoint-crosstenant: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230038|366014|376012|1800799022|38070700016;
x-microsoft-antispam-message-info: 
 =?utf-8?B?dlRiYThYQUhaeTI3WlBsTCtlYmE4TlBWc0lhdlA1eHFxeHZZRU5XK1dhTVBG?=
 =?utf-8?B?emVTQytseGViK1VYQVdtN0g3TUFuZjhmMFo2S2UzOHdaWTZ0dCtHS3FiYnA5?=
 =?utf-8?B?UmpxSzVmSEloVGdoVGZuWXZVUTRlRDhuTWdqQ3JDdVBpd2JBKzMwVDgwQjhD?=
 =?utf-8?B?cG9EU3ZvRjVXdzhIZFltNW5XSTFtcVp4dklHRlpkZlRBNDBUcTZ5UDhaVWor?=
 =?utf-8?B?dzJGOS9sNUt5OXNDbkMvTTN4WWhHSDFINHZXRFRGNGg2Y3JQNjBtNTY0NUl3?=
 =?utf-8?B?aVkxQ2hIWFRraDA1T1dhckJiNXQycFNjSW1FTDZTTGtEMFYrdVJKSVBhYjVH?=
 =?utf-8?B?WlF6OVFGOVNNTXRERlVTbXpObVNHWTZWdW40dlg3TFZaRVhuK0hnYXh5alo0?=
 =?utf-8?B?OWd4V29xUW1YbitKODNSbS9WYXhEcUZ1emt3dm5zTk5ZTE1oUnFheVpRL2tn?=
 =?utf-8?B?M2J2REZNVWdWSFBFWjZlOUFRNktLaHRtbGtUWXQwRVNSbFV4V3lZc0NGRDRI?=
 =?utf-8?B?b0Z6MFRYdW5MZmcxblpiYnlWZElKeDlJc2xXVWdPUnV6c3RaVUNLbHNwV2xi?=
 =?utf-8?B?RFBuMUVpL1g2NzVPN1Q0Q2JiN1poQ21hWWhmMTVhcEpBdTZBdVBsNHpkekJR?=
 =?utf-8?B?VWFNYk91WW5HRCtUOEJqZDJYMWR2Q2lNamFXY1dQMG9TeWJrK0JpbHZ5NEd4?=
 =?utf-8?B?M25JaFV5RjBhNG5pWDF1NlhNS3pvY1ljQ3FnT000aC9KV0t2OFRleC9wdmZw?=
 =?utf-8?B?ZWg0eDhSMmVOc2hWc1lpV1RqbDZvYjlnZHdlWVRPSUFrdmgrclRaR0YrZ0Rz?=
 =?utf-8?B?b2pXK0s4blpNMVV3OXordzNuODlRVzN2bzRCNTJJano5Zll1YUF3aDkwS0VP?=
 =?utf-8?B?TmdkeWtLaGMzRENjQ09wcDQvdi9vSFFRYTdoTVFDUm1QUkV3MlgxanBrWDRC?=
 =?utf-8?B?SWRWM05CV3MvRkdua3RwSXR0RTVwMllrR09TRFRCYmxjbXdPSzNSY1BrWVdO?=
 =?utf-8?B?T2kyOFdHVGs5U0JXODBwNE1sYnFqQm9vZDR2WTE2eTJHUUk4RVF3azBwaE82?=
 =?utf-8?B?b05SSTZyd1RCYTRCYXFBYjVEV29NV2hZSzB1UTJTSVBuS2lpbTJOcWF6MzRh?=
 =?utf-8?B?Y0tmL0taQ09lNUJjYXdBMlpLNzJma3dSMG9tM3lEUjdOaHBTbytIR0h0S2c1?=
 =?utf-8?B?cEZjLzhocW4rZVI3YzhnQjZxWnJuYlVRWXZtZ25lWUZRYXh6QmpZWE1EcEFq?=
 =?utf-8?B?dWxyTnhWTGVLYU4vRUtLQ01UL1E3RVdpakcza2VqU0k0ZFlnTXRDaW1RRnlP?=
 =?utf-8?B?N05aamFKL2lMdUk3SEM0ZWlRbnRtUlhINlA1NXIvTjVjaEltenVsbjlQVE1l?=
 =?utf-8?B?SitNcEFHeDVUQWhaSmdBbXBLOThDcmZUdENHNmRhdnRaL015WXlVbkNYMENS?=
 =?utf-8?B?VFp3TWRnblJRRmJMVGNxOVBQTVE1VWh6cy9JUEt2OXNEblkxV3VySmZMelp6?=
 =?utf-8?B?T0d0MndLWldJb0JCWFRuR3Vta0kwMW41WjZMM0NUbU9YOWg4ZlU4LzZSY3dO?=
 =?utf-8?B?eVo1RUx4dktXVStwMVVFcnJWZmJuNUkxQjdzME4xU2M5U2JTNnY5MzNiVFhS?=
 =?utf-8?B?VjhGdUpKeURwV2lXRmJhNkw2dUN5NVRURnFqVVdIWFY1bWw0M0xGRHNZZUkw?=
 =?utf-8?B?Q1BLV0orNU12dGJBaGZIczludlMwK1hwZnBWelZRUHVuRHNqakdGbG9ydFBN?=
 =?utf-8?B?MGp1RGwySDFqOXAwempUMFMxYkNoU3h3eVdnWEcvN0NkQitOV2puNC9saHpZ?=
 =?utf-8?Q?KGAOaeg8lj/nlGET7UsvxWwrnMmKm+TOieN8s=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR02MB10287.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230038)(366014)(376012)(1800799022)(38070700016);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?WS9sRlQzY0prdTA0b09KelhtYjlrL2FKTFRha1VrQXFmUE5BQXJkbGhaTEt4?=
 =?utf-8?B?cURuOEdYOU5IZlQ2cnFDVkw0Nm5yK3lDN3k3ZVl1TVB3a2pSVFZzSmdqTi90?=
 =?utf-8?B?Snh3Yk4zaTVkRG16QVVkMFVRSWFiVmZ5ek81eWxONG1rYkFCSitRTUJaeXNw?=
 =?utf-8?B?NzZlRmtFYVFKNW1ISEhQellHUXQ5T2R4K3BidnZXMlZvdEZCemd3Z0wvelpO?=
 =?utf-8?B?RWR3UXhxYm4zb2RJTmlRTzBHdDdZamtST0tqUDk0ZzE0TDdTU1VGaklaVlZZ?=
 =?utf-8?B?WWhsN0FxNlNERFFEL0RlWkdIRENCclpOSUpNZmVIOHVoMFgwRFB1QnZGN0p3?=
 =?utf-8?B?dDlOaHdSNVV0R0lxejhMRFNZZTdwY1E0bjlNcGxldGVlSXFDL3hjRnNKVnUy?=
 =?utf-8?B?alpnNkwvb2k1bmZpRzMzREVQbWZ3TXFtWjc3MkdJNDJNQmdZaElsRHVSWWdB?=
 =?utf-8?B?R3o2VkEwZ0ZZWHZ0QXJLRjU0MC9FNzBwdTVBa1lSQnJQNmJQMml1UExQNDBt?=
 =?utf-8?B?U3VTaXRFaUM1K2lKeVo3Q04xeVdaSzVrYThWbWxBMlFwM0t3Qi9UM0plNmE2?=
 =?utf-8?B?dk4xd2UwUlAvakR5WU9SSWFPdlpyR2QyQkhLUHFaSGFBdFV0WHV3a3VHYzNK?=
 =?utf-8?B?ckRpOWdrblF1a1BXTVIzSFY3dWNSaUlhTzU5WkRTYWNuWklwYTJuUGNYU0Zq?=
 =?utf-8?B?VnZnNEdDcmxwMlBKdXlqdDRLcURMN0cxOTExbUo4SjkrdWpzWEZKSHB4ZkQv?=
 =?utf-8?B?ZkljeFF6WW13NTczNWd0M2tKV1Vpa3VONjZJMlBiTzA0YVU3c0lKUjN6TTFW?=
 =?utf-8?B?eGgvSlJjR0NTN3l5NS9vSm5BZUc0cE1LNEZGV3FtL1hPWE1EamxvOGJjdk1R?=
 =?utf-8?B?WkhzUVlyM1pBZGthdDMxOTZPNStVelhZSGZmZi9FWkozR3lWWHpOVXVwQmhW?=
 =?utf-8?B?SGpQUVFFYWNDWkIxTEJIaERVZGJMcVhSUjF4OFV4YUl1VDRGS1pVd0x2Z3Vr?=
 =?utf-8?B?ZC9QV3ZlcU9KVi96bFJ3MThpSk4zcFZiYWpLeEZNTGNjbTlPNmVCTnJzUTAy?=
 =?utf-8?B?OEo1NVZVa1lsWEhjWTRNczAyYjBIVnYyTk1Md2Z3dnFuTjd1SDdWN1pVU2lx?=
 =?utf-8?B?NjhUMGc0WUE4UHc4MTdZL3kwcTFqbjZFdjJWYVcwM05DMDhnVEczMG8yOWRC?=
 =?utf-8?B?TVpPRTJuWmtqWEFTa0JFd1hvY1hkSGRlTlpkbndjcHZ1Z1ZpWUc0dldKOTRq?=
 =?utf-8?B?Ym1rcHRHdU1WY29FZUNLMHg2M1FPdWMyMWF4UlVYQ29NaVR4Mkh2dkJUbFk1?=
 =?utf-8?B?ak8zVmN6U282VXVFU2t4QUlPdWFXWjJEZnZNUXlaZENXU0RRNkM1ZEpsbmY0?=
 =?utf-8?B?RjB3TGlCV1pyNHpPV3UvaXVKTzg2ajRnNG0vSTgwUTV1T1YvM1RVYWJxS3Fy?=
 =?utf-8?B?VFpQYksyN1YrYVYxVkNmcTBGUXZSYU1BakNDR283TnpEekhobmNBb3VBSEFE?=
 =?utf-8?B?MTRBaUV4N3lTbmtZYkI2bkcxQUlEeFlidTN4STVpclAySGdJc3M1Q0N2bzdY?=
 =?utf-8?B?U2hxeTRvcTRLbVdYVFB5d0VaUVlKd2RaNFJWNGRiWGtndVJ4RVgzUDJ1QUc3?=
 =?utf-8?B?dTVVL0hlTnpmazZqOFBjOGw0Y2d3ejNSaHUwT1VkdExtZ1FjZ0QvSnd2TzVo?=
 =?utf-8?B?dWp3Rmd4RUlxZC9kVE1NNUNjZHJnbS9Ma1dpZFVkVWt6cmxIQVZzK1hwMy9z?=
 =?utf-8?B?MnROV01CRGZvckVPQnVabVNGd3VKT2phWFAzYnhEaUpQU3h4MmNiYzFkS0dK?=
 =?utf-8?B?RGROaUU2dkhqa2ZkQXIzS1QxWnNpVGtZWEN2Wm43RkxRVWtlK0VOdW5NaVdk?=
 =?utf-8?B?a1hmUEpJM0wwcnlUbW5seEI5ZURBOTk0cFNIOFd0cmRENDdFT0ptWWcxd3Bh?=
 =?utf-8?B?THBOMW9kUGJ6b1RyM3I4aHU4NFdHS0RhRmh3WEJwMkdiLzZ0UGMwUmVnWFNI?=
 =?utf-8?B?NEVNUVNmaHVkOW4vUk9tYTJvZENlSlBNakhGMVJ5RG90NTdVS1E3RUlucTEw?=
 =?utf-8?B?VUVhREszbnkzVzFsRFcxNThqdEloRlZlL0xJdGlDYXZyOWcwRFFiNUpsZFVM?=
 =?utf-8?B?blZIeTI0MklES2poV0g3TXpURzVuUkZoTDNUSGFVUTJlaDQxUXoycFNhQ3lV?=
 =?utf-8?B?Tjg1Tm5UTE5jZjE3eVlQeXFmMGZhekI4anpmNGJabHZPbEwzbmcwcE5MeFpG?=
 =?utf-8?B?NEs0L3l2WnFMRXlxbkw4NVo3S1N3PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <60DA5897FA028E4D9CD6D7F6EFF4F62F@namprd02.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 99c4c684-5507-42cb-3ecd-08dc95782655
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jun 2024 00:37:25.1178
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PDuZ3+L8hgLkSsivFQBcSnKtduoErB2Og8+BnSr5qtAyEEiDh9892sfe5WcPNPN3xsbkr1QxBkLmNPmXjwipXWWaQUW9mzaqGomHTBzriuI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR02MB9315
X-Proofpoint-ORIG-GUID: TeSZAnvjM4dPOBdDoDGP6sULBeyVgGIG
X-Proofpoint-GUID: TeSZAnvjM4dPOBdDoDGP6sULBeyVgGIG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-25_19,2024-06-25_01,2024-05-17_01
X-Proofpoint-Spam-Reason: safe

DQoNCj4gT24gSnVuIDI1LCAyMDI0LCBhdCA4OjAz4oCvUE0sIEpha3ViIEtpY2luc2tpIDxrdWJh
QGtlcm5lbC5vcmc+IHdyb3RlOg0KPiANCj4gT24gTW9uLCAyNCBKdW4gMjAyNCAxMTo0OTowMCAt
MDcwMCBKb24gS29obGVyIHdyb3RlOg0KPj4gKyBzd2l0Y2ggKHZuaWNfZGV2X2dldF9pbnRyX21v
ZGUoZW5pYy0+dmRldikpIHsNCj4+ICsgY2FzZSBWTklDX0RFVl9JTlRSX01PREVfTVNJWDoNCj4+
ICsgY2hhbm5lbHMtPm1heF9yeCA9IEVOSUNfUlFfTUFYOw0KPj4gKyBjaGFubmVscy0+bWF4X3R4
ID0gRU5JQ19XUV9NQVg7DQo+PiArIGNoYW5uZWxzLT5yeF9jb3VudCA9IGVuaWMtPnJxX2NvdW50
Ow0KPj4gKyBjaGFubmVscy0+dHhfY291bnQgPSBlbmljLT53cV9jb3VudDsNCj4+ICsgYnJlYWs7
DQo+PiArIGNhc2UgVk5JQ19ERVZfSU5UUl9NT0RFX01TSToNCj4+ICsgY2hhbm5lbHMtPm1heF9y
eCA9IDE7DQo+PiArIGNoYW5uZWxzLT5tYXhfdHggPSAxOw0KPj4gKyBjaGFubmVscy0+cnhfY291
bnQgPSAxOw0KPj4gKyBjaGFubmVscy0+dHhfY291bnQgPSAxOw0KPj4gKyBicmVhazsNCj4+ICsg
Y2FzZSBWTklDX0RFVl9JTlRSX01PREVfSU5UWDoNCj4+ICsgY2hhbm5lbHMtPm1heF9jb21iaW5l
ZCA9IDE7DQo+PiArIGNoYW5uZWxzLT5jb21iaW5lZF9jb3VudCA9IDE7DQo+PiArIGRlZmF1bHQ6
DQo+PiArIGJyZWFrOw0KPj4gKyB9DQo+IA0KPiBzb3JyeSBmb3Igbm90IHJlc3BvbmRpbmcgcHJv
cGVybHkgdG8geW91ciBlYXJsaWVyIGVtYWlsLCBidXQgSSB0aGluaw0KPiBNU0kgc2hvdWxkIGFs
c28gYmUgY29tYmluZWQuIFdoYXQgbWF0dGVycyBpcyB3aGV0aGVyIHRoZSBJUlEgc2VydmVzDQo+
IGp1c3Qgb25lIG9mIHtSeCwgVHh9IG9yIGJvdGguDQo+IA0KPiBGb3IgTVNJLCBJIHNlZToNCj4g
DQo+IDEgLiBlbmljX2Rldl9pbml0KCkgZG9lczoNCj4gbmV0aWZfbmFwaV9hZGQobmV0ZGV2LCAm
ZW5pYy0+bmFwaVswXSwgZW5pY19wb2xsKTsNCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIF5eXl5eXl5eXg0KPiANCj4gMi4gZW5pY19yZXF1ZXN0X2ludHIo
KSBkb2VzDQo+IHJlcXVlc3RfaXJxKGVuaWMtPnBkZXYtPmlycSwgZW5pY19pc3JfbXNpLCAuLi4N
Cj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXl5eXl5eXl5eXl5eDQo+IA0K
PiAzLiBlbmljX2lzcl9tc2koKSBkb2VzIA0KPiBuYXBpX3NjaGVkdWxlX2lycW9mZigmZW5pYy0+
bmFwaVswXSk7IA0KPiB0aHVzIG1hdGNoaW5nIHRoZSBOQVBJIGZyb20gc3RlcCAjMS4NCj4gDQo+
IDQuIGVuaWNfcG9sbCgpIGNhbGxzIGJvdGggZW5pY193cV9zZXJ2aWNlLCBhbmQgZW5pY19ycV9z
ZXJ2aWNlDQo+IA0KPiBTbyBpdCdzIGNvbWJpbmVkLCBBRkFJQ1QsIHNpbWlsYXIgdG8gSU5UWCBp
biB0aGUgcmVsZXZhbnQgcGFydHMuDQoNCk9rLCB0aGFua3MgZm9yIHRoZSB0aXAsIEkgYXBwcmVj
aWF0ZSBpdC4gSeKAmWxsIHNlbmQgb3V0IGEgdjMgc2hvcnRseQ0KDQo+IC0tIA0KPiBwdy1ib3Q6
IGNyDQoNCg==

