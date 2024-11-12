Return-Path: <netdev+bounces-144193-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C6AED9C5F6C
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 18:48:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8706B282790
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 17:48:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CDD9213EE8;
	Tue, 12 Nov 2024 17:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="RFFEtln1"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A33BB214409;
	Tue, 12 Nov 2024 17:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.156.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731433706; cv=fail; b=VT7gxQSdYa0NERp5A5qeR1QG8YrEAq6WZSfbedKrsyg4qnbIM3jIGQVMDZL1CyQ7lznMD/s3oU4qnK3Q7noFnIjcaRRHKIdpDoq2wd3hiJtOgupee2pJwYE1OHMTNjT5PAwz4ilLBKKD0JIzG2AAGuPjXbHEV4SE5yKfmOCswQ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731433706; c=relaxed/simple;
	bh=D7q9fTH85cUtSmO+y5CozZG2QXFCkQ5k/fRWVw6Obys=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=KgWlTIRscNdX5am8TAugHTjSLTtUm5r6VzQIP2pnJG7hzzLQqdL4kL3hYpreUCETicI3QHgkyAUjaXO4dzrt0KqRk+oRtyIdl8lVWiQ/Lt2hhzUhILQzt7JyRkEr70HmG+GOMElR5k17Tux4o3+0Gu5ZaXnPjwwabXRufFuWvTY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=RFFEtln1; arc=fail smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4ACFpETG025806;
	Tue, 12 Nov 2024 09:48:15 -0800
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2046.outbound.protection.outlook.com [104.47.57.46])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 42va1609en-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 Nov 2024 09:48:15 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WOd6D+ZQS5+uL0BmU/KlhexCpTNT8D3/zwKZe2Qcz1PiB45yDhG8WzRaHXnAyaafTiixjkYlwii7OnTj1QuqUyim785kcKAovKEuCS08dQWnumKW6yFXwqWLJIq+rxgtR8hvs1BuCC21JwRB3pvRTFOCkLRfGRLBYFJ0wes+WjckAfTahQZ4WDM0Fa+b0t2+GkcE7tpJEb4/Wy8JQtYspk3eOVtxpIWQ8HAKKSoishrqZHr9yw5/1hLpvU3dTWbaFxyXqhTJKRoK+B1d+kxknsM/kAwkKrZO5DsNmn/lbaM77G0iPWAWZeK6GLjUMNNMFxyh0p6k1NXy+2PN8xotdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D7q9fTH85cUtSmO+y5CozZG2QXFCkQ5k/fRWVw6Obys=;
 b=SnzknPxmtRC4QQddAUZ5toxfdq28BrKQoVwoSTdtBExbseH/DosRVuv0oEOaFaUP/QET3uXUT/00cJxjoLKZ3ZjUMhj8jc9ZTV0b76616SnkXrTkL8KzApZPoJQrF1FncjLSRESXQJjFabMe7Tbxmd4BLzRaA0u4H1cti2XWRM1TyVyT83iYGeopAps2koVTWSyOZJ62A/r4zAsOnYzcKscA2CQ75Mr27F1KSYrPsKYvdvIzS3d+s0ecBSiO9XHnCprIGdyxWfwqfizIWvDQQBILAnHapJCk5nsJWTRyAVfGGwcv72GzPsnL8gzk+PQLwByE1ueGHP4j860HbvQEkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D7q9fTH85cUtSmO+y5CozZG2QXFCkQ5k/fRWVw6Obys=;
 b=RFFEtln1BnujMbRreifxj28AsXLI7XXP7KUNbHehsWOI1q+QkXAGjog2LQpswrN86WvbNPS9F4QjXB6a+2f0PcsHXtqDINGLya6iuEkcf12n72/h8OpKVFsXC3ddZ17rNFby25NV5O3gtZiioJ/QeaJEqQra1+E7SPV8EzNyPXY=
Received: from SA1PR18MB4709.namprd18.prod.outlook.com (2603:10b6:806:1d8::10)
 by SJ0PR18MB5056.namprd18.prod.outlook.com (2603:10b6:a03:43f::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.27; Tue, 12 Nov
 2024 17:48:11 +0000
Received: from SA1PR18MB4709.namprd18.prod.outlook.com
 ([fe80::cfa8:31ef:6e1b:3606]) by SA1PR18MB4709.namprd18.prod.outlook.com
 ([fe80::cfa8:31ef:6e1b:3606%7]) with mapi id 15.20.8137.027; Tue, 12 Nov 2024
 17:48:11 +0000
From: Sai Krishna Gajula <saikrishnag@marvell.com>
To: Simon Horman <horms@kernel.org>
CC: "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com"
	<edumazet@google.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        Sunil Kovvuri Goutham <sgoutham@marvell.com>,
        Geethasowjanya Akula <gakula@marvell.com>,
        Linu Cherian
	<lcherian@marvell.com>, Jerin Jacob <jerinj@marvell.com>,
        Hariprasad Kelam
	<hkelam@marvell.com>,
        Subbaraya Sundeep Bhatta <sbhatta@marvell.com>,
        "kalesh-anakkur.purayil@broadcom.com" <kalesh-anakkur.purayil@broadcom.com>
Subject: Re: [net-next PATCH v2 6/6] octeontx2-pf: CN20K mbox implementation
 between PF-VF
Thread-Topic: [net-next PATCH v2 6/6] octeontx2-pf: CN20K mbox implementation
 between PF-VF
Thread-Index: AQHbNSsKXzm3idhPqU6Tqjj5Q5HAYQ==
Date: Tue, 12 Nov 2024 17:48:11 +0000
Message-ID:
 <SA1PR18MB4709BA010D07990C70A68AC8A0592@SA1PR18MB4709.namprd18.prod.outlook.com>
References: <20241022185410.4036100-1-saikrishnag@marvell.com>
 <20241022185410.4036100-7-saikrishnag@marvell.com>
 <20241101100404.GB1838431@kernel.org>
In-Reply-To: <20241101100404.GB1838431@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR18MB4709:EE_|SJ0PR18MB5056:EE_
x-ms-office365-filtering-correlation-id: e32d915e-2045-43dc-ef12-08dd03422ce6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?aE02U1JyR3NSaVQ5SDZsYjNBbEcvdWZ0UEVvRzF0TnFOT2pUbVEyeExXZTRO?=
 =?utf-8?B?am9iRWlYcGphUDBtODVLaVJMNkQzZkY2OUJiZk5ONnhOVjFJenQ5Y3YxWVNz?=
 =?utf-8?B?eWF4aUR5NVl5d1JHSkUya3p1aXBxZmVKYzlSYkRjWjZEZ3k1bEtZSnVjQlNL?=
 =?utf-8?B?THFiK2xncGcrR0V4dXp4WW4rK0l0WDdjMGREV1hxaVdTMDdtOEU1bVhGU2w4?=
 =?utf-8?B?M3RvQjVoU2JsR0cxdHQ1RU5xOW5jVENIbHQ3TFljdHpEL2theGpUV3Q1Y0I0?=
 =?utf-8?B?SWpEWUpBbjNlU083MFp3UnA0L1dBUUJsT1BKZ0RycjUraldvOUEyMTR2a2Z1?=
 =?utf-8?B?eDF3WnhhWlZkZXBJQXQ1dFk3R0NOZjhMNjQxWWlLYkVCZGZOZ3lEcWU5cFNv?=
 =?utf-8?B?elJ0NC82MzlSN21CMytETW8raDVGM0tUSVFpVkxyK0loZUdKSDE2UzdDbnBV?=
 =?utf-8?B?SHd5RUh6YlQ1YUxGYk5Vb2RjVkNocFY2Ukp1MTJia3YwVjUrMi93emhCbGE4?=
 =?utf-8?B?MFE0dWN3d2hxVlVjellDNVREck9PTGdORnhrYWpMNFoyUEpyOHVDaXZ6R0FQ?=
 =?utf-8?B?WnJvQnVSTTRHNW55dkR3Qm9hU2dFckRuTlJXT2JkOElLSktOcDlrQW9mQWtZ?=
 =?utf-8?B?M0cybXd5UENUSENnb05ubXNVcjVBNTBWWUJUdDJrQjNBY0x1RFRFTVpLWGN0?=
 =?utf-8?B?dUdGR3pQZ0R1K3o1bnlsOXhYd0dKdjcwMUxkY25oazB3VkFYbFE0a2MzYk55?=
 =?utf-8?B?eVE4aHZKckVKcld5d3dZUlgyaVB6WHVpb2dVSWJTUUVvUXhPYVpTRUcyeDBW?=
 =?utf-8?B?a08veWhzSEpnOFJBYkpiUEVsaEZINWZERXpVYS9LUUpNQ095RVR4TlY1WkRs?=
 =?utf-8?B?bGFLYTI5czRSVDluMVNNVDZ0akRqcDRrcUtEL1h4QTZ4eEpEL2h0VU1DUnNK?=
 =?utf-8?B?ekJlNkdJa3hZZEp1VmowUW1FYUZTTnZzZmhLR2FwL0RReUlyNEgzRlk0THZG?=
 =?utf-8?B?WU91UWM1aE03Z2FRYjFFZExkbnIrcWg2YTU1czM1VEN2bldYWWQ5Nm0xMkVO?=
 =?utf-8?B?U3YrRVFLQm14Q1VlMFhCNk9GcEVaTGVleTlXa2ZhMEtkc1BXNm1UR3czRzIv?=
 =?utf-8?B?N1Zqd3VUYm0xZ2M5ZWp6SE9uQVRXYS93Z3d4UTlGZGNCajQ1b0FrREVsQnAx?=
 =?utf-8?B?TE9EMGpoNEI0cW1YTm9XbGxQTHFta3o5dXpsOTRFcThNR0tvUGd6UHYxQXJL?=
 =?utf-8?B?YkpxUmNWdWRsVzI2TVYvZ1g3MmFwUUVLU05Wc0VRSXNjTGk2RHFwMlhwYm1U?=
 =?utf-8?B?YzRZc3RhanFZbUc4S2o5S2xVR1hlZkNhOU9zaXhQQklqc1IwOHE2cXNBeHBj?=
 =?utf-8?B?VmFXVk5XUzNvNlQ4enpFVlVKSGpEVGdjUktsam9Ubk5Bb1cySU02clhLTVR3?=
 =?utf-8?B?ZEZOOUhkY2dCUGJkNkhzYTVxRjJlekR3OURTTjR1cDc2UWJ1aktOK3ZmTGt1?=
 =?utf-8?B?c2NYb0htUUhhTUZRVElwRUNTaWF2alFoclJxWFFLV2p2YVhpdC84bUlPclln?=
 =?utf-8?B?dmFEb09PZzUrS2ZjaGh4MENKbDNGaDZRSDQ2QWI1S2xOYnlQbEQwbVBWOG9D?=
 =?utf-8?B?ek1pOVBmOVE3SXJ3bFA1ejRSdUdTZTZVakppL2h4RFZ3MGRaS09yVHBJeGcw?=
 =?utf-8?B?Q05VcEkvSTJxRVVwbWlidVM0ZitzVXZiRkcwVGU3dXA2WXhxTGhDbS8zcmtV?=
 =?utf-8?B?em42d2lCZkQrK3NHNWo3dCtHUU9iNXlROW8zTXl2M2xxYjFocXZHK2hpelRC?=
 =?utf-8?Q?TNmGT9bQsZTWNaj46q+U/DQ0elJmBGpWFTzNY=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR18MB4709.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?L2RUNGxSTHkzdXFOMzRnZGtRMCtjVVR6RzROeUFpZTZHbmRNNUpPQlBGREYy?=
 =?utf-8?B?Y0Nsa3ZTT29nbER5OVBNZWwvTGNLbWc5Tnl0bk40ekhLd0szRzJHd3QzWG95?=
 =?utf-8?B?SiszeVc3dDJGaVErZCtUSUpXSXF1TEx6NlZXMWJjbW8wL0ZOODUwWFRGTzAw?=
 =?utf-8?B?bHNLclh3Umc0b1ZqcDR0ejlmbWN1cVdvSEowVHdoTW9XTlFEeXRxVjBQQlY3?=
 =?utf-8?B?a0lrbHBuUkxEbnlYeUUzTWluakxLMVNiYkpnUklDSWw4Qzh1QTkzakJjTmxQ?=
 =?utf-8?B?VlRyYVk3d1FwNHZJSWl0cWFuek5UKzZlN1dBQ2lqYWhqaDlJQWxlYjFETVdm?=
 =?utf-8?B?bytmTklWWlVoZlo2ZkhKMDluYlNBUHFnQ0wxU1hVd0U1TnFxTFp4eS96WnNm?=
 =?utf-8?B?TW1oSit3Tmt4RXlFeU13M1BXSDZCVTVlYkxnWVhReWFKVWpQQ1RlN3lVejZk?=
 =?utf-8?B?WG90elRFUFNCRXBNdC9KZzZKdG9GTEpWd2N3QUpPZXZIQktJVFExUmdjOVZT?=
 =?utf-8?B?QUNzTWFqbXhNMHg4SVN1bkZVVkxQZXN6NU0vTk44alRZSTI4ZHQ1QVVFSEVO?=
 =?utf-8?B?dmFYK0swR21id3lxTlowT05hM3V5cnVhU0FDMzBONStoa01ZajNVanZQdC9Z?=
 =?utf-8?B?YVFTem4weDh0c0RxOEV4d1Y5QTBlMHlPRmFoazRUOU9wK3JCL1MzUEw4MVhy?=
 =?utf-8?B?ZHllMjE2bzNJZXprUU1lZEkxYURZaHBzOGthTk05ZzJZaFZwQWtGb2NGQzN4?=
 =?utf-8?B?VDJzSHJnU0szbUlGMGduRXJIbzI1RFFIWHNEV2trMmpLU2pZYTNpU1NoYXk4?=
 =?utf-8?B?SThoQ0JjV3ZWRHI4U0Jac0FJV0lybDJka1NXVndhdlc4UkpYaFh5dDRIN0hV?=
 =?utf-8?B?TjZkUkh6YkpqbGhJaGxidGt3cU5jSE1RWGN0MnJQQ1MrQXVjcDZKbHAyaC8y?=
 =?utf-8?B?eTNoZzFwdzVZcVpiWW15QmFoVllQeVhBbWxUWWp5cXlxa3h3d082eWNHQWcw?=
 =?utf-8?B?enNUN09maCtCOUhZcFBPb0RWdDA1TXAwSWp3Zzl5enlpZG9zQnp4VnhMT3FU?=
 =?utf-8?B?QXJCMTJtNFJ1bktJTkp3bndhZ2NxZXFrV21DaHlDWEEweS9VTk5PbnBLdnZK?=
 =?utf-8?B?MHNVTHdHd3pCSFBRVWVOdmZBYXRPbWVhSEFieFVPRzNzOGI0ZTgwalprczhl?=
 =?utf-8?B?MTV2V3k0dHd2MGRsWUp2TC8wWVRxM2lDUW5ZTm5OYk5uZDhnZ3AyYWNndW12?=
 =?utf-8?B?T2w1WmhuM1UwWVF2RFBpeVo2Z0hrM09CUm1jOUhJZW5mLysvZ2prWUdBVEtZ?=
 =?utf-8?B?UWpzWmxzVXU3NjgrSnY5VVUvQnlUc085cTU4TXVVVkEzaWVhdXpPMjZ5QXZN?=
 =?utf-8?B?VWkwUVJUNDczTzZNWEwvUExZTVBndlBZV01ZUU1sS0xSZHZySlRSdUZMMCt1?=
 =?utf-8?B?Ri9nc0hXMWxkTWk3bUtRR0xZemd6SVpzYXd2RHluTTUvTXR0NjFUSWlkUjU3?=
 =?utf-8?B?Z3hNV0kxc2JHZnhnTnpLaWFhVDNWVGNDcUdMdUNpcXlDd0hjM3UySFVWc2sy?=
 =?utf-8?B?eG5lVTgxam0yRlRKMmxYVnQ1Nk91b1lkc2JuMzZqWU1tUEMxVmxCdS9iZTVS?=
 =?utf-8?B?OTJUYTlXU1dCdFlseTlGUGthUXY2QldvdDFsZDNFS3MxSytHeDBHY3ZraEhz?=
 =?utf-8?B?NWordjVMZUVOMkdvaGhSZ1AzOUJqeXIrZ3dDZmRuVzlaV3pDMjNNZmlxVTho?=
 =?utf-8?B?Q2dPRzIrRjZlUjZHUFZrOU5qaW9OV1M0ajlVQVlUc1UxcXBNVm1Za1YvVGxx?=
 =?utf-8?B?Um1MVE1jRDZ5ek85bjJwTHhiWGhLUmlFWVI4SzAwUHFZU1BMSExYUXRyMGNq?=
 =?utf-8?B?RU1peFpBa1pOMHZxRnZhSFo2VEIyTG8xejZEbWRZa3pyWnVlVUdZeGt2by8w?=
 =?utf-8?B?MVZzUU42ek1QRndmVVVWWnZjNDVkVUVKM2FFZU4wbXk4RmUycTBKZEg3ckJP?=
 =?utf-8?B?TlhqMWU2Nm1OYWl3VGtuKysvUmcwU3o0UHBEMGpBRTFqdlQ5akRTeFNCN2ZX?=
 =?utf-8?B?b3R2ZXluUG1wSnpKdHFGd3RobklpZTRMTktzcjNIMUxNNmVVVTZlbGMrSDhs?=
 =?utf-8?Q?ZZRfI47n7EKl/KlVAiGnPSGPe?=
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
X-MS-Exchange-CrossTenant-AuthSource: SA1PR18MB4709.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e32d915e-2045-43dc-ef12-08dd03422ce6
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Nov 2024 17:48:11.2106
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hUMD98vCuIJwkd3/xlexur3kd3W94TzRF7bcDAPvk1hxmvjAoL8O8Wv8JaJ09upim/z9W7n/JgzMkk88k+QbPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR18MB5056
X-Proofpoint-GUID: kGDquXCDCMq8HtYE7Eog5hpPVLEiDPu2
X-Proofpoint-ORIG-GUID: kGDquXCDCMq8HtYE7Eog5hpPVLEiDPu2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFNpbW9uIEhvcm1hbiA8aG9y
bXNAa2VybmVsLm9yZz4NCj4gU2VudDogRnJpZGF5LCBOb3ZlbWJlciAxLCAyMDI0IDM6MzQgUE0N
Cj4gVG86IFNhaSBLcmlzaG5hIEdhanVsYSA8c2Fpa3Jpc2huYWdAbWFydmVsbC5jb20+DQo+IENj
OiBkYXZlbUBkYXZlbWxvZnQubmV0OyBlZHVtYXpldEBnb29nbGUuY29tOyBrdWJhQGtlcm5lbC5v
cmc7DQo+IHBhYmVuaUByZWRoYXQuY29tOyBuZXRkZXZAdmdlci5rZXJuZWwub3JnOyBsaW51eC1r
ZXJuZWxAdmdlci5rZXJuZWwub3JnOw0KPiBTdW5pbCBLb3Z2dXJpIEdvdXRoYW0gPHNnb3V0aGFt
QG1hcnZlbGwuY29tPjsgR2VldGhhc293amFueWEgQWt1bGENCj4gPGdha3VsYUBtYXJ2ZWxsLmNv
bT47IExpbnUgQ2hlcmlhbiA8bGNoZXJpYW5AbWFydmVsbC5jb20+OyBKZXJpbiBKYWNvYg0KPiA8
amVyaW5qQG1hcnZlbGwuY29tPjsgSGFyaXByYXNhZCBLZWxhbSA8aGtlbGFtQG1hcnZlbGwuY29t
PjsgU3ViYmFyYXlhDQo+IFN1bmRlZXAgQmhhdHRhIDxzYmhhdHRhQG1hcnZlbGwuY29tPjsga2Fs
ZXNoLQ0KPiBhbmFra3VyLnB1cmF5aWxAYnJvYWRjb20uY29tDQo+IFN1YmplY3Q6ICBSZTogW25l
dC1uZXh0IFBBVENIIHYyIDYvNl0gb2N0ZW9udHgyLXBmOiBDTjIwSyBtYm94DQo+IGltcGxlbWVu
dGF0aW9uIGJldHdlZW4gUEYtVkYNCj4gDQo+IE9uIFdlZCwgT2N0IDIzLCAyMDI0IGF0IDEyOuKA
ijI0OuKAijEwQU0gKzA1MzAsIFNhaSBLcmlzaG5hIHdyb3RlOiA+IFRoaXMgcGF0Y2gNCj4gaW1w
bGVtZW50cyB0aGUgQ04yMGsgTUJPWCBjb21tdW5pY2F0aW9uIGJldHdlZW4gUEYgYW5kID4gaXQn
cyBWRnMuDQo+IENOMjBLIHNpbGljb24gZ290IGV4dHJhIGludGVycnVwdCBvZiBNQk9YIHJlc3Bv
bnNlIGZvciB0cmlnZ2VyID4gaW50ZXJydXB0Lg0KPiBBbHNvIGZldyBvZiB0aGUgDQo+IE9uIFdl
ZCwgT2N0IDIzLCAyMDI0IGF0IDEyOjI0OjEwQU0gKzA1MzAsIFNhaSBLcmlzaG5hIHdyb3RlOg0K
PiA+IFRoaXMgcGF0Y2ggaW1wbGVtZW50cyB0aGUgQ04yMGsgTUJPWCBjb21tdW5pY2F0aW9uIGJl
dHdlZW4gUEYgYW5kDQo+IGl0J3MNCj4gPiBWRnMuIENOMjBLIHNpbGljb24gZ290IGV4dHJhIGlu
dGVycnVwdCBvZiBNQk9YIHJlc3BvbnNlIGZvciB0cmlnZ2VyDQo+ID4gaW50ZXJydXB0LiBBbHNv
IGZldyBvZiB0aGUgQ1NSIG9mZnNldHMgZ290IGNoYW5nZWQgaW4gQ04yMEsgYWdhaW5zdA0KPiA+
IHByaW9yIHNlcmllcyBvZiBzaWxpY29ucy4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFN1bmls
IEtvdnZ1cmkgR291dGhhbSA8c2dvdXRoYW1AbWFydmVsbC5jb20+DQo+ID4gU2lnbmVkLW9mZi1i
eTogU2FpIEtyaXNobmEgPHNhaWtyaXNobmFnQG1hcnZlbGwuY29tPg0KPiANCj4gLi4uDQo+IA0K
PiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC9ldGhlcm5ldC9tYXJ2ZWxsL29jdGVvbnR4Mi9u
aWMvb3R4Ml9wZi5jDQo+ID4gYi9kcml2ZXJzL25ldC9ldGhlcm5ldC9tYXJ2ZWxsL29jdGVvbnR4
Mi9uaWMvb3R4Ml9wZi5jDQo+ID4gaW5kZXggMTQ4YTVjOTFhZjU1Li4xYTc5MjAzMjdmZDUgMTAw
NjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9uZXQvZXRoZXJuZXQvbWFydmVsbC9vY3Rlb250eDIvbmlj
L290eDJfcGYuYw0KPiA+ICsrKyBiL2RyaXZlcnMvbmV0L2V0aGVybmV0L21hcnZlbGwvb2N0ZW9u
dHgyL25pYy9vdHgyX3BmLmMNCj4gPiBAQCAtNTY1LDYgKzU2NSwyMyBAQCBpcnFyZXR1cm5fdCBv
dHgyX3BmdmZfbWJveF9pbnRyX2hhbmRsZXIoaW50IGlycSwNCj4gdm9pZCAqcGZfaXJxKQ0KPiA+
ICAJcmV0dXJuIElSUV9IQU5ETEVEOw0KPiA+ICB9DQo+ID4NCj4gPiArc3RhdGljIHZvaWQgKmNu
MjBrX3BmdmZfbWJveF9hbGxvYyhzdHJ1Y3Qgb3R4Ml9uaWMgKnBmLCBpbnQgbnVtdmZzKSB7DQo+
ID4gKwlzdHJ1Y3QgcW1lbSAqbWJveF9hZGRyOw0KPiA+ICsJaW50IGVycjsNCj4gPiArDQo+ID4g
KwllcnIgPSBxbWVtX2FsbG9jKCZwZi0+cGRldi0+ZGV2LCAmbWJveF9hZGRyLCBudW12ZnMsDQo+
IE1CT1hfU0laRSk7DQo+IA0KPiBIaSBTYWkgYW5kIFN1bmlsLA0KPiANCj4gTUJPWF9TSVpFIGlz
IDB4MTAwMDAgKGkuZS4gMl4xNikuDQo+IA0KPiBCdXQgcW1lbV9hbGxvYygpIHdpbGwgYXNzaWdu
IHRoaXMgdmFsdWUgdG8gdGhlIGVudHJ5X3N6IGZpZWxkIG9mIGFuIGluc3RhbmNlIG9mDQo+IHN0
cnVjdCBxbWVtLCB3aG9zZSB0eXBlIGlzIHUxNi4gVGh1cyB0aGUgdmFsdWUgd2lsbCBiZSB0cnVu
Y2F0ZWQgdG8gMC4gSSBkaWRuJ3QNCj4gZGlnIGZ1cnRoZXIsIGJ1dCB0aGlzIGRvZXNuJ3Qgc2Vl
bSBkZXNpcmFibGUuDQo+IA0KPiBGbGFnZ2VkIGJ5IFNwYXJzZSBvbiB4ODZfNjQuDQo+IA0KPiBB
bHNvLCBub3Qgc3RyaWN0bHkgcmVsYXRlZCB0byB0aGlzIHBhdGNoc2V0OiBUaGVyZSBTcGFyc2Ug
ZmxhZ3MgYSBoYW5kZnVsIG9mDQo+IHdhcm5pbmdzIGluIC4uLi9tYXJ2ZWxsL29jdGVvbnR4Mi9u
aWMvb3R4Ml9wZi5jLA0KPiB3aGljaCBhbGwgc2VlbSB0byByZWxhdGUgdG8gX19pb21lbSBhbm5v
dGF0aW9ucy4gSXQgd291bGQgYmUgbmljZSB0bw0KPiBpbnZlc3RpZ2F0ZSBhbmQgcmVzb2x2ZSB0
aG9zZSBhdCBzb21lIHBvaW50Lg0KDQpBY2ssIHdpbGwgc3VibWl0IFYzIHBhdGNoIGFkZHJlc3Np
bmcgdGhlc2UgaXNzdWVzLg0KDQo+IA0KPiA+ICsJaWYgKGVycikgew0KPiA+ICsJCWRldl9lcnIo
cGYtPmRldiwgInFtZW0gYWxsb2MgZmFpbFxuIik7DQo+ID4gKwkJcmV0dXJuIEVSUl9QVFIoLUVO
T01FTSk7DQo+ID4gKwl9DQo+ID4gKw0KPiA+ICsJb3R4Ml93cml0ZTY0KHBmLCBSVlVfUEZfVkZf
TUJPWF9BRERSLCAodTY0KW1ib3hfYWRkci0+aW92YSk7DQo+ID4gKwlwZi0+cGZ2Zl9tYm94X2Fk
ZHIgPSBtYm94X2FkZHI7DQo+ID4gKw0KPiA+ICsJcmV0dXJuIG1ib3hfYWRkci0+YmFzZTsNCj4g
PiArfQ0KPiA+ICsNCj4gPiAgc3RhdGljIGludCBvdHgyX3BmdmZfbWJveF9pbml0KHN0cnVjdCBv
dHgyX25pYyAqcGYsIGludCBudW12ZnMpICB7DQo+ID4gIAl2b2lkIF9faW9tZW0gKmh3YmFzZTsN
Cj4gDQo+IC4uLg0KDQo=

