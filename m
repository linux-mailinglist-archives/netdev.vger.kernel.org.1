Return-Path: <netdev+bounces-124012-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ECA9B9675D5
	for <lists+netdev@lfdr.de>; Sun,  1 Sep 2024 11:52:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 78CFB1F2230F
	for <lists+netdev@lfdr.de>; Sun,  1 Sep 2024 09:52:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C339F14F9F5;
	Sun,  1 Sep 2024 09:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="D0X97M0V"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C85F22BAEA;
	Sun,  1 Sep 2024 09:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.156.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725184340; cv=fail; b=CTUhGiYQugktkz98S7F715mEp4oxhAC054ZxwTvNtnZD6Ydhn65BdfctWl3rzMn0CGsgJ39pf3+rnRd5wHOvHQy8TNQSkvaMkDlB0qLneOneoc76q+06Ap7QZ2ZYge3Y+uOSqxnROvJ9k9W2/80NXbyOH3L4/tSGHKsY4mKKTS4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725184340; c=relaxed/simple;
	bh=tQJN4fa8nVhBfC1IDA4TYakP2Tz6blFjb9E7FGXGCKo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=RAoE514LDaH4iRPTrtFa7RiuKrgXyfeix0VGEmafwOYiN77XhsuBl6bhj/V06BEaqh4FnwbQjlZhbIb+b9I70KI3s5h1JOdmGOjMuoBFUOr71PVtXxQUKPzITF6NbJx70J6rRhYL27vChST62UquPHv/MOqVKNS5Yo/Lg647y/g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=D0X97M0V; arc=fail smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4819deW5025954;
	Sun, 1 Sep 2024 02:52:09 -0700
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2175.outbound.protection.outlook.com [104.47.55.175])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 41c2pgt7df-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 01 Sep 2024 02:51:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yTQKXM2/JBkYbOoff88qMyYb4khVCLJZ+NGxkKI/cz6eTpe/lzBJqH249GYjujaK2TJBEllFQFlRwVEmuBh3yo1Zcd8QoGpRYu2/mXfdtWekeCzvCgg8W1vztSM8iJopN8fCpKWc2I6ZV0SEctiEkeHH5vZnSS4GL/p5G00OtamBgeQUByKp++nhhX0Gj0v8DY32vUw2x83KDx+NbFGL5DVs/jGsEannbM/1AlIixTG2yOxFcaVAPRrRyluCnfYP9A+7lEoiVvneLvzGEvjT/7MuPpNwxo5PhkU7tEPDEkjPQAfRySrRhqwVl5t66MyAZcBQEiIMDD4jkVYiZoOU+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tQJN4fa8nVhBfC1IDA4TYakP2Tz6blFjb9E7FGXGCKo=;
 b=oEspOajPK+e+mnEkT6BdO7W0wjeN70uZbamAYqqJ/fWZGDv5AqjIzdpKaPdUC/HsmSPTKqPcfli0n9s8dEhTCCu2jlCURqv3pMYm0GbQLe/FWr3xmt2k4g3c9MX77TLeG2Ziuc4EbrVZ/VXNRK+1GIeBSwDi4NN+yyutm2iMMVH9Mfj5l0MgKjz9NSB9ERA8fzzx7Cpd3UlnJPegMLoTgCK54bNql15mknFuvob4DdMUQ39jbrEbrZdOYe/WN7PYu7IFDx3GETEJXAfPLUzw7xASL9lNoDuIOOxTM9sEaO+QoTGnwVS6X6SlrsfsLArktq3b1612Uwe9zxqxTYzGUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tQJN4fa8nVhBfC1IDA4TYakP2Tz6blFjb9E7FGXGCKo=;
 b=D0X97M0VXW95T2FqAXkGPRU22b57Xa8jyWRLCb7bd/c5YkzYYRuFXpu2Ns1geo6VUQGb+HPLQH44CFCgrDffGX+hOIqstErrEi3WgYxMZVS1GZSxo21myV6kSQ5yxwqpC/4FxiynqwYFXZHcB2Uxxc3AtcyrilV7V5zNIB7L28k=
Received: from CH0PR18MB4339.namprd18.prod.outlook.com (2603:10b6:610:d2::17)
 by PH8PR18MB5265.namprd18.prod.outlook.com (2603:10b6:510:25c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.23; Sun, 1 Sep
 2024 09:51:49 +0000
Received: from CH0PR18MB4339.namprd18.prod.outlook.com
 ([fe80::61a0:b58d:907c:16af]) by CH0PR18MB4339.namprd18.prod.outlook.com
 ([fe80::61a0:b58d:907c:16af%5]) with mapi id 15.20.7918.020; Sun, 1 Sep 2024
 09:51:49 +0000
From: Geethasowjanya Akula <gakula@marvell.com>
To: Jiri Pirko <jiri@resnulli.us>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "davem@davemloft.net"
	<davem@davemloft.net>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "edumazet@google.com" <edumazet@google.com>,
        Sunil Kovvuri Goutham
	<sgoutham@marvell.com>,
        Subbaraya Sundeep Bhatta <sbhatta@marvell.com>,
        Hariprasad Kelam <hkelam@marvell.com>
Subject: RE: [EXTERNAL] Re: [net-next PATCH v11 10/11] octeontx2-pf: Add
 devlink port support
Thread-Topic: [EXTERNAL] Re: [net-next PATCH v11 10/11] octeontx2-pf: Add
 devlink port support
Thread-Index: AQHa9JYvYFqSBM4RQES8UrIbdnD0orIzWImAgA9kG2A=
Date: Sun, 1 Sep 2024 09:51:49 +0000
Message-ID:
 <CH0PR18MB43399A980EC1A63728289311CD912@CH0PR18MB4339.namprd18.prod.outlook.com>
References: <20240822132031.29494-1-gakula@marvell.com>
 <20240822132031.29494-11-gakula@marvell.com>
 <ZsdNO2_Q9jTHLBEH@nanopsycho.orion>
In-Reply-To: <ZsdNO2_Q9jTHLBEH@nanopsycho.orion>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR18MB4339:EE_|PH8PR18MB5265:EE_
x-ms-office365-filtering-correlation-id: d40ec4e4-4380-4b05-4342-08dcca6bb326
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?NkFIcWwvVDhVVmdCVDUzZ0JWb2c5OGxqSDNoZGdjVVY3NU1EeHE5d21UcjZs?=
 =?utf-8?B?V1JyYzBxaFlDcUcvZ0VJRzZZZVAzL0NWUmVUKy9rdDVxSmlOMUdFRkw2RDJk?=
 =?utf-8?B?bzRyOTgzMnVSYnQ2ZmRnazEvcG9ML1BDdUFwY0hGRDVXUENCdWllYW1DQ01p?=
 =?utf-8?B?dEFya2YvUjVYL2N2cDFSRlRvK3dzVnBBeldyaUQxaC9Jd1lFblBiSm5HZzl1?=
 =?utf-8?B?eUxneVhKREhXNE9QdmRVZG1BTCtjdFBhQkN5aGx2UXJVNWJ2K01NSVRlK1pn?=
 =?utf-8?B?K1NhV0E1dlNHV3dZSXM5RDh0SDlUd2YwRzZ3aGlYb2tsRE5FdTc5VHdMajhP?=
 =?utf-8?B?MzR1S1BMZUNic0NBVk9aRlErR1dGTnp3VW1XblpERlpTTFE0ZXdTRUJDTXFY?=
 =?utf-8?B?a3VndEdabEhTeUovaGJxNWJHdVZnS0NWNXFKZXZrNjRJcWFZU2toNkhwTWVy?=
 =?utf-8?B?Z2VCTWVsVnloM0l4c1ZGb3BiR2t5WlVOWms4VDhnaHR6d2QrRHlMa0gvcyt4?=
 =?utf-8?B?NjhpNk82dng1ZnFXYmpkREw5WjZqSFZ4endja1BYVGhKT1dMY285bEpBbkxq?=
 =?utf-8?B?ckRHZGFrWFRMQWRoVGN0WEllUUcvTTFxYjB1QkhpSjNEekFnaUVhL2g4SU5G?=
 =?utf-8?B?Tld3LzNORWxqbFA3b1ZIQjNUQmxJMEhmL0FMSGpYUE5CNjE5VTNBWlJXZUZo?=
 =?utf-8?B?a1Nnalp0R1pDR1VUcmlaNzBWWTZTRDN0b2VsSmI1RTROMnZiS25YNWtLUlU4?=
 =?utf-8?B?WHlRc0V6elVPMW53cUFkZE5LWmpWSXFLRk5DTE9mM01TV0RCaXJIcEw3bW1U?=
 =?utf-8?B?TkZtV3FpSlJ2ZmxmZUE2dVlhVlphTll6TDdzM2J0bFFiUUc2R1FOVGhVbEll?=
 =?utf-8?B?Szc3UGFVMjIvLzRXRGFHUU5hRnRWYmt6b2J3dEN0ZzdqeHV0MzY3Z3lDVmsz?=
 =?utf-8?B?emF5L0pOYjNCNGRrdFBMd2lPV1k1QjNRWFA1UnZqTWxDOEpUcUtFeFR2Rytj?=
 =?utf-8?B?djlmKzNxWm9IWDFOZGpuQldNWWp3Z1QyTExRMzlHN1pUT0FXRnNxQkN2dGtn?=
 =?utf-8?B?c2RaZjk0NDUxYzdkb0x3OXBwR3pBdys4amFFRkk2K1BXMWw3ZHNZMS9iVmJp?=
 =?utf-8?B?WjN6RnptZitkWTV5UGVieC9XcytqaWR3RFFtSUJ0L01YU1VMM1RkNURnbVFk?=
 =?utf-8?B?UEVCTjAxM2Z0U1dBR2Q4enRFcU1sOS9jdmhyMHdzcGpzWkVQNzlCemdEZjRo?=
 =?utf-8?B?elMxOEJHeUk2SnVoMDlmcDdaNGJvT3lqRStWZkhuMDJHaEk4d0ZDMmNDNmVW?=
 =?utf-8?B?aW0vYWxMSVJZVi9PZWRrd0pJYmtMSk5VUHRjYlhUazg2WUxZdGFKdVplMm1w?=
 =?utf-8?B?Q0I3bVFJYWkvbEl2ZzlhcVBmdEpHZEhFamd4OXdYMXhMWUxXajhNMXZSZTNh?=
 =?utf-8?B?RlFGWEJwMExvRHZnMENGQlZuLzlBa21seFl2ZDd0eUpWQkZ3NFRIdG5vOC8z?=
 =?utf-8?B?UHVOR002OUxRMEVnNXNWSkFpeWdCUjBOTU9CZkJiNk9wU2Z3dTdvc1NuUVpm?=
 =?utf-8?B?MDJYWTRxbEp1bnlRMmNJYmpMbTFCd0RtemVuQVlIQlhtOC9uMm1Sb0VDSHJ5?=
 =?utf-8?B?NkY1WEtJRHUxa2w5NGczT2VQQlNhM0YrS3dEOExwWXR3ZzBGbW5VSGYrN3Zk?=
 =?utf-8?B?a1F5U3lldEI0QjV5dHZ3d0k5WXpCTHVvTDFSNExqNzNUV0U1cE9lOTF5VllV?=
 =?utf-8?B?UXpHcXh6Sk5FTjdtcnoyMmVMSHhRMDkraFBxTWtOeTFJSVhkMlJkSjRlVmRx?=
 =?utf-8?B?ajB3eHVERUhzb01xVHNCWXdZQVZab1V2aDhheTh2S2dQVUZkbkE0SnlhMDc1?=
 =?utf-8?B?VE55UUlNZFRHdnJ6c0JSU3ZlOGVMSE5ES0NyUjAzM3U4Tnc9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR18MB4339.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZWkzMlBSclU3d2xpVmo5QzBSV3BQVTBRUENJeldOeHVSY0wwU3EvMThxb2NW?=
 =?utf-8?B?b2l6dSs0L3M4TnRUL0NpR2dFQWRtR0VWYlZuZWNaTXpiZ3IyeVJrT1dJVUE0?=
 =?utf-8?B?OHAvS2g3eVY3NUw3SytveU85NW1PQldqb1ZXNEE5a1Zsb2RPWnNMWDAzcTdt?=
 =?utf-8?B?bVl2RnQxYUF4b2VtcXlFbjFYUU8rMm5lSktyWDJTdlgwTGNiMGV6RFRvOHBz?=
 =?utf-8?B?Qlc5aGViSlhtcDUyQTJMYUhCT01DeTZBVlVDajJLekFwZGJPZkpWK1VJamVU?=
 =?utf-8?B?b2FrWFFxVGtac3lJbGJUalI3eTBxMit1U29KRk04eEl1dTVsY1FxT2pWMDh6?=
 =?utf-8?B?cFRrcE5VZHVHT3FvQ2s2aDNuRHhEdThXbHFMVFB1WEJpa1hpVHhlVGQxWUF2?=
 =?utf-8?B?RDJPOGRsSk9JV1RpT244Ung5RUl0OCtwVVJYN280dGM2VkRnanFTb29teEdJ?=
 =?utf-8?B?eDJtc3FrdnVDM2RYc2pjNnMvaXJDNmNJelpGV0pWRmRweWEwSitrQUVETllh?=
 =?utf-8?B?bUhET3ZEWWJBeCtzV09ubjlSclRRREY5L0dWb1RScUpEUU9BMVBzeGpwaVd2?=
 =?utf-8?B?TnZyV0ExbWVOclJTWXJSMUR0enJkQVM0N1I1N3M3aUhLMkNLQ3BQQmFtRzEx?=
 =?utf-8?B?d1RCRjVqeVZNUkNSbXhjK05Za293VndMbmFTZlB6R2VHam8raXJDdUNWYTN4?=
 =?utf-8?B?UUxYRnY3bUUxYWpkUlRUSjR4VTRjZzlQWDN5RW5PTkxLOEdWZU44bStseWpv?=
 =?utf-8?B?ODZTVytrRWxZWWxDWFZ0YXhKL2tVOXR2bEt4MVNzRm5rSUtERTVwcGFmeTBy?=
 =?utf-8?B?dGtkNkJsdmRUeTE3S0NLSTJuZDNMbjc3NXVBRXdpRHlOL2VDUmNGQ2haSXhV?=
 =?utf-8?B?dDZTU0hCcVowaVVaZEF6Vkp1bHBtdVRvOEpkcWhoN2lGcG9hdCtFTVYxUkh2?=
 =?utf-8?B?aUE5ZDhQbEtIblR6TkJ0SG5lTSs3NnNtVENJZGxDR0d5NWdiVWNSVlZtMEdq?=
 =?utf-8?B?RFBMc1FVZm9rbUtGc2dyMFFPM1UzUXF6SHZzZml1THhEejZoZVpFLzFUdTA5?=
 =?utf-8?B?dlkwMmVUcENzTEJjdnJwR2pDM3A1VWRNVEtFSWtlTk4xNkZ2YVVab01lVnZv?=
 =?utf-8?B?RjllcFhOeGV2cTlaYkR3Vm12RmNFRXBLZnlHQ0cyR2dTdWdIaGdiUVVCUXdn?=
 =?utf-8?B?ZnpJYm04b2lkNmpORWtYVVExeDIrcWVOM1QxSzdmZFc3dGR1NHJ6d3h4Nm52?=
 =?utf-8?B?elprWHBqL2doM1I1ajRXbzhhSG8wQWtXczZKdWNOVGxidmFmRS9OV3d3R3Qz?=
 =?utf-8?B?UDB6K1ZkWXRGSncyYXdwWmViWmZUK0hSRndkR1FES0dzL0I3Z21RSGdyRjlw?=
 =?utf-8?B?ZnlKTnU2TXJmQ0huaDVNTnJHcXlzK0I5R29LVjhEWm1KT1FoVFhSbWNDRE1k?=
 =?utf-8?B?elcrZGhla2w3bWh3b1RDUTV2bmJqcVdPNkxmekZiTzUrTnRZRUgvWTBjWFFv?=
 =?utf-8?B?ejIyd1hYV1RHdU5VVDlNejR0MmlUR1hwMjdCYmxMazZ3RzRHMGY2MVVES2pt?=
 =?utf-8?B?cGxLREtaRGljRm9mYlppZWxYVkFBT1pxUHVaUm1BWURLVEpqRE1mSFVmQW9w?=
 =?utf-8?B?dkhQMDhkNDJZazdXeGxVRzE1UHAwdVdJa3RIWXVybXQ4WlpQZm5LQ2xCdXJN?=
 =?utf-8?B?akJMUjNiQld6anhJem9RbUNRY0R3M0NLTEtudWtZQWRBMWRHU2tLWGVYbWtz?=
 =?utf-8?B?bFVRWFhycTdsckJWSFpQMUo0WklWNjRlb1ZLRWdoUUM4NlhFNFhLUnRtYWhV?=
 =?utf-8?B?R3Q5T0duL21ZbU1WeW9sWTZ3a1JUbDVURFIyaDRmM1psczFEaXZyMWtBR3ZL?=
 =?utf-8?B?T2dNUEpPQXNPQXZQWTF2UENLS2F4NDcyNWgwTVl5ZTJLNmQvcWxpaUtsUy9T?=
 =?utf-8?B?ZmdvK0E5ZE1RQnl6YTRicVBDeUliMm9PdE0zRmVCMWZ4dWtQaW9NUVUwL1hz?=
 =?utf-8?B?K2hkOWhCdkhSNW5JNjcwS1dKSkFqNCswMzNscHAyVXQ4eFlSOCswbWRHMkxo?=
 =?utf-8?B?SlpuSldzMVk4NGw1VXdjbURyMUNOUWZhV2hrV0FHTk9ON2RYOXhVMURXRldR?=
 =?utf-8?Q?akH3VoWsAlNXYK1bmJkHxuW9S?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: d40ec4e4-4380-4b05-4342-08dcca6bb326
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Sep 2024 09:51:49.5324
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aR4dPdsxbOnN4+teGd9lOxGI/brEfBy2OmBldWaTb6+YkdLFavVTH1pzkoYujHRgx5LNHBss0fKHp2x5adrAlw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR18MB5265
X-Proofpoint-ORIG-GUID: N7by1e9hNTb6WfRlcv9Wg1QS4FYDIN1X
X-Proofpoint-GUID: N7by1e9hNTb6WfRlcv9Wg1QS4FYDIN1X
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-31_04,2024-08-30_01,2024-05-17_01

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IEppcmkgUGlya28gPGppcmlA
cmVzbnVsbGkudXM+DQo+U2VudDogVGh1cnNkYXksIEF1Z3VzdCAyMiwgMjAyNCA4OjA4IFBNDQo+
VG86IEdlZXRoYXNvd2phbnlhIEFrdWxhIDxnYWt1bGFAbWFydmVsbC5jb20+DQo+Q2M6IG5ldGRl
dkB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGt1YmFAa2Vy
bmVsLm9yZzsNCj5kYXZlbUBkYXZlbWxvZnQubmV0OyBwYWJlbmlAcmVkaGF0LmNvbTsgZWR1bWF6
ZXRAZ29vZ2xlLmNvbTsgU3VuaWwNCj5Lb3Z2dXJpIEdvdXRoYW0gPHNnb3V0aGFtQG1hcnZlbGwu
Y29tPjsgU3ViYmFyYXlhIFN1bmRlZXAgQmhhdHRhDQo+PHNiaGF0dGFAbWFydmVsbC5jb20+OyBI
YXJpcHJhc2FkIEtlbGFtIDxoa2VsYW1AbWFydmVsbC5jb20+DQo+U3ViamVjdDogW0VYVEVSTkFM
XSBSZTogW25ldC1uZXh0IFBBVENIIHYxMSAxMC8xMV0gb2N0ZW9udHgyLXBmOiBBZGQgZGV2bGlu
aw0KPnBvcnQgc3VwcG9ydA0KPg0KPlRodSwgQXVnIDIyLCAyMDI0IGF0IDAzOjIwOjMwUE0gQ0VT
VCwgZ2FrdWxhQG1hcnZlbGwuY29tIHdyb3RlOg0KPj5SZWdpc3RlciBkZXZsaW5rIHBvcnQgZm9y
IHRoZSBydnUgcmVwcmVzZW50b3JzLg0KPj4NCj4+U2lnbmVkLW9mZi1ieTogR2VldGhhIHNvd2ph
bnlhIDxnYWt1bGFAbWFydmVsbC5jb20+DQo+PlJldmlld2VkLWJ5OiBTaW1vbiBIb3JtYW4gPGhv
cm1zQGtlcm5lbC5vcmc+DQo+Pi0tLQ0KPj4gLi4uL2V0aGVybmV0L21hcnZlbGwvb2N0ZW9udHgy
LnJzdCAgICAgICAgICAgIHwgMzkgKysrKysrKysNCj4+IC4uLi9uZXQvZXRoZXJuZXQvbWFydmVs
bC9vY3Rlb250eDIvbmljL3JlcC5jICB8IDkxICsrKysrKysrKysrKysrKysrKysNCj4+Li4uL25l
dC9ldGhlcm5ldC9tYXJ2ZWxsL29jdGVvbnR4Mi9uaWMvcmVwLmggIHwgIDIgKw0KPj4gMyBmaWxl
cyBjaGFuZ2VkLCAxMzIgaW5zZXJ0aW9ucygrKQ0KPj4NCj4+ZGlmZiAtLWdpdA0KPj5hL0RvY3Vt
ZW50YXRpb24vbmV0d29ya2luZy9kZXZpY2VfZHJpdmVycy9ldGhlcm5ldC9tYXJ2ZWxsL29jdGVv
bnR4Mi5ycw0KPj50DQo+PmIvRG9jdW1lbnRhdGlvbi9uZXR3b3JraW5nL2RldmljZV9kcml2ZXJz
L2V0aGVybmV0L21hcnZlbGwvb2N0ZW9udHgyLnJzDQo+PnQgaW5kZXggMTEzMmFlMmQwMDdjLi4z
MzI1OGNjMThmNDUgMTAwNjQ0DQo+Pi0tLQ0KPj5hL0RvY3VtZW50YXRpb24vbmV0d29ya2luZy9k
ZXZpY2VfZHJpdmVycy9ldGhlcm5ldC9tYXJ2ZWxsL29jdGVvbnR4Mi5ycw0KPj50DQo+PisrKyBi
L0RvY3VtZW50YXRpb24vbmV0d29ya2luZy9kZXZpY2VfZHJpdmVycy9ldGhlcm5ldC9tYXJ2ZWxs
L29jdGVvbnR4DQo+PisrKyAyLnJzdA0KPj5AQCAtMzkzLDMgKzM5Myw0MiBAQCBUbyByZW1vdmUg
dGhlIHJlcHJlc2VudG9ycyBkZXZpY2VzIGZyb20gdGhlDQo+PnN5c3RlbS4gQ2hhbmdlIHRoZSBk
ZXZpY2UgdG8gbGVnYWN5DQo+PiAgLSBDaGFuZ2UgZGV2aWNlIHRvIGxlZ2FjeSBtb2RlOjoNCj4+
DQo+PiAJIyBkZXZsaW5rIGRldiBlc3dpdGNoIHNldCBwY2kvMDAwMjoxYzowMC4wIG1vZGUgbGVn
YWN5DQo+PisNCj4+Kw0KPj4rUlZVIHJlcHJlc2VudG9ycyBjYW4gYmUgbWFuYWdlZCB1c2luZyBk
ZXZsaW5rIHBvcnRzIChzZWUNCj4+KzpyZWY6YERvY3VtZW50YXRpb24vbmV0d29ya2luZy9kZXZs
aW5rL2RldmxpbmstcG9ydC5yc3QgPGRldmxpbmtfcG9ydD5gKQ0KPmludGVyZmFjZS4NCj4+Kw0K
Pj4rIC0gU2hvdyBkZXZsaW5rIHBvcnRzIG9mIHJlcHJlc2VudG9yczo6DQo+PisNCj4+KwkjIGRl
dmxpbmsgcG9ydA0KPj4rDQo+PitTYW1wbGUgb3V0cHV0OjoNCj4+Kw0KPj4rCSMgZGV2bGluayBw
b3J0DQo+PisJcGNpLzAwMDI6MWM6MDAuMC8wOiB0eXBlIGV0aCBuZXRkZXYgcGYxdmYwcmVwIGZs
YXZvdXIgcGh5c2ljYWwgcG9ydCAxDQo+c3BsaXR0YWJsZSBmYWxzZQ0KPj4rCXBjaS8wMDAyOjFj
OjAwLjAvMTogdHlwZSBldGggbmV0ZGV2IHBmMXZmMXJlcCBmbGF2b3VyIHBjaXZmIGNvbnRyb2xs
ZXIgMA0KPnBmbnVtIDEgdmZudW0gMSBleHRlcm5hbCBmYWxzZSBzcGxpdHRhYmxlIGZhbHNlDQo+
PisJcGNpLzAwMDI6MWM6MDAuMC8yOiB0eXBlIGV0aCBuZXRkZXYgcGYxdmYycmVwIGZsYXZvdXIg
cGNpdmYgY29udHJvbGxlciAwDQo+cGZudW0gMSB2Zm51bSAyIGV4dGVybmFsIGZhbHNlIHNwbGl0
dGFibGUgZmFsc2UNCj4+KwlwY2kvMDAwMjoxYzowMC4wLzM6IHR5cGUgZXRoIG5ldGRldiBwZjF2
ZjNyZXAgZmxhdm91ciBwY2l2Zg0KPj4rY29udHJvbGxlciAwIHBmbnVtIDEgdmZudW0gMyBleHRl
cm5hbCBmYWxzZSBzcGxpdHRhYmxlIGZhbHNlDQo+PisNCj4+K0Z1bmN0aW9uIGF0dHJpYnV0ZXMN
Cj4+Kz09PT09PT09PT09PT09PT09PT0NCj4+Kw0KPj4rVGhlIFJWVSByZXByZXNlbnRvciBzdXBw
b3J0IGZ1bmN0aW9uIGF0dHJpYnV0ZXMgZm9yIHJlcHJlc2VudG9ycy4NCj4+K1BvcnQgZnVuY3Rp
b24gY29uZmlndXJhdGlvbiBvZiB0aGUgcmVwcmVzZW50b3JzIGFyZSBzdXBwb3J0ZWQgdGhyb3Vn
aA0KPmRldmxpbmsgZXN3aXRjaCBwb3J0Lg0KPj4rDQo+PitNQUMgYWRkcmVzcyBzZXR1cA0KPj4r
LS0tLS0tLS0tLS0tLS0tLS0NCj4+Kw0KPj4rUlZVIHJlcHJlc2VudG9yIGRyaXZlciBzdXBwb3J0
IGRldmxpbmsgcG9ydCBmdW5jdGlvbiBhdHRyIG1lY2hhbmlzbSB0bw0KPj4rc2V0dXAgTUFDIGFk
ZHJlc3MuIChyZWZlciB0bw0KPj4rRG9jdW1lbnRhdGlvbi9uZXR3b3JraW5nL2RldmxpbmsvZGV2
bGluay1wb3J0LnJzdCkNCj4+Kw0KPj4rIC0gVG8gc2V0dXAgTUFDIGFkZHJlc3MgZm9yIHBvcnQg
Mjo6DQo+PisNCj4+KwkjIGRldmxpbmsgcG9ydCBmdW5jdGlvbiBzZXQgcGNpLzAwMDI6MWM6MDAu
MC8yIGh3X2FkZHINCj4+KzVjOmExOjFiOjVlOjQzOjExDQo+PisNCj4+K1NhbXBsZSBvdXRwdXQ6
Og0KPj4rDQo+PisJIyBkZXZsaW5rIHBvcnQgc2hvdyBwY2kvMDAwMjoxYzowMC4wLzINCj4+Kwlw
Y2kvMDAwMjoxYzowMC4wLzI6IHR5cGUgZXRoIG5ldGRldiBwZjF2ZjJyZXAgZmxhdm91ciBwY2l2
ZiBjb250cm9sbGVyIDANCj5wZm51bSAxIHZmbnVtIDIgZXh0ZXJuYWwgZmFsc2Ugc3BsaXR0YWJs
ZSBmYWxzZQ0KPj4rCWZ1bmN0aW9uOg0KPj4rCQlod19hZGRyIDVjOmExOjFiOjVlOjQzOjExDQo+
PmRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC9ldGhlcm5ldC9tYXJ2ZWxsL29jdGVvbnR4Mi9uaWMv
cmVwLmMNCj4+Yi9kcml2ZXJzL25ldC9ldGhlcm5ldC9tYXJ2ZWxsL29jdGVvbnR4Mi9uaWMvcmVw
LmMNCj4+aW5kZXggNWY3NjdiNmU3OWMzLi5hYWIxNzg0YjUxMzQgMTAwNjQ0DQo+Pi0tLSBhL2Ry
aXZlcnMvbmV0L2V0aGVybmV0L21hcnZlbGwvb2N0ZW9udHgyL25pYy9yZXAuYw0KPj4rKysgYi9k
cml2ZXJzL25ldC9ldGhlcm5ldC9tYXJ2ZWxsL29jdGVvbnR4Mi9uaWMvcmVwLmMNCj4+QEAgLTI4
LDYgKzI4LDkwIEBAIE1PRFVMRV9ERVNDUklQVElPTihEUlZfU1RSSU5HKTsNCj4+TU9EVUxFX0xJ
Q0VOU0UoIkdQTCIpOyAgTU9EVUxFX0RFVklDRV9UQUJMRShwY2ksIHJ2dV9yZXBfaWRfdGFibGUp
Ow0KPj4NCj4+K3N0YXRpYyBpbnQgcnZ1X3JlcF9kbF9wb3J0X2ZuX2h3X2FkZHJfZ2V0KHN0cnVj
dCBkZXZsaW5rX3BvcnQgKnBvcnQsDQo+PisJCQkJCSAgdTggKmh3X2FkZHIsIGludCAqaHdfYWRk
cl9sZW4sDQo+PisJCQkJCSAgc3RydWN0IG5ldGxpbmtfZXh0X2FjayAqZXh0YWNrKSB7DQo+PisJ
c3RydWN0IG90eDJfZGV2bGluayAqb3R4Ml9kbCA9IGRldmxpbmtfcHJpdihwb3J0LT5kZXZsaW5r
KTsNCj4+KwlpbnQgcmVwX2lkID0gcG9ydC0+aW5kZXg7DQo+PisJc3RydWN0IG90eDJfbmljICpw
cml2Ow0KPj4rCXN0cnVjdCByZXBfZGV2ICpyZXA7DQo+PisNCj4+Kwlwcml2ID0gb3R4Ml9kbC0+
cGZ2ZjsNCj4+KwlyZXAgPSBwcml2LT5yZXBzW3JlcF9pZF07DQo+DQo+c3RydWN0IHJlcF9kZXYg
Y29udGFpbnMgc3RydWN0IGRldmxpbmtfcG9ydC4gVXNlIGNvbnRhaW5lcl9vZiB0byBnZXQgaXQg
ZnJvbQ0KPnBvcnQgcG9pbnRlci4NCk9rIHdpbGwgZml4IGl0Lg0KPg0KPg0KPj4rCWV0aGVyX2Fk
ZHJfY29weShod19hZGRyLCByZXAtPm1hYyk7DQo+PisJKmh3X2FkZHJfbGVuID0gRVRIX0FMRU47
DQo+PisJcmV0dXJuIDA7DQo+Pit9DQo+PisNCj4+K3N0YXRpYyBpbnQgcnZ1X3JlcF9kbF9wb3J0
X2ZuX2h3X2FkZHJfc2V0KHN0cnVjdCBkZXZsaW5rX3BvcnQgKnBvcnQsDQo+PisJCQkJCSAgY29u
c3QgdTggKmh3X2FkZHIsIGludCBod19hZGRyX2xlbiwNCj4+KwkJCQkJICBzdHJ1Y3QgbmV0bGlu
a19leHRfYWNrICpleHRhY2spIHsNCj4+KwlzdHJ1Y3Qgb3R4Ml9kZXZsaW5rICpvdHgyX2RsID0g
ZGV2bGlua19wcml2KHBvcnQtPmRldmxpbmspOw0KPj4rCWludCByZXBfaWQgPSBwb3J0LT5pbmRl
eDsNCj4+KwlzdHJ1Y3Qgb3R4Ml9uaWMgKnByaXY7DQo+PisJc3RydWN0IHJlcF9kZXYgKnJlcDsN
Cj4+Kw0KPj4rCXByaXYgPSBvdHgyX2RsLT5wZnZmOw0KPj4rCXJlcCA9IHByaXYtPnJlcHNbcmVw
X2lkXTsNCj4+KwlldGhfaHdfYWRkcl9zZXQocmVwLT5uZXRkZXYsIGh3X2FkZHIpOw0KPj4rCWV0
aGVyX2FkZHJfY29weShyZXAtPm1hYywgaHdfYWRkcik7DQo+DQo+WW91IHNhdmUgdGhlIG1hYywg
eWV0IHlvdSBuZXZlciB1c2UgaXQuIFRvIGJlIGNsZWFyLCB0aGlzIG1hYyBzaG91bGQgYmUgdXNl
ZCBmb3INCj50aGUgYWN0dWFsIFZGLiBJIGJlbGlldmUgeW91IGFyZSBtaXNzaW5nIHRoYXQgY29k
ZS4NCldhcyBwbGFubmluZyB0byBpbXBsZW1lbnQgaW4gZm9sbG93IHVwIHBhdGNoLiAgQnV0IHdp
bGwgYWRkIGl0IGluIHRoaXMgc2VyaWVzLiANCj4NCj4NCj4+KwlyZXR1cm4gMDsNCj4+K30NCj4+
Kw0KPj4rc3RhdGljIGNvbnN0IHN0cnVjdCBkZXZsaW5rX3BvcnRfb3BzIHJ2dV9yZXBfZGxfcG9y
dF9vcHMgPSB7DQo+PisJLnBvcnRfZm5faHdfYWRkcl9nZXQgPSBydnVfcmVwX2RsX3BvcnRfZm5f
aHdfYWRkcl9nZXQsDQo+PisJLnBvcnRfZm5faHdfYWRkcl9zZXQgPSBydnVfcmVwX2RsX3BvcnRf
Zm5faHdfYWRkcl9zZXQsIH07DQo+PisNCj4+K3N0YXRpYyB2b2lkDQo+PitydnVfcmVwX2Rldmxp
bmtfc2V0X3N3aXRjaF9pZChzdHJ1Y3Qgb3R4Ml9uaWMgKnByaXYsDQo+PisJCQkgICAgICBzdHJ1
Y3QgbmV0ZGV2X3BoeXNfaXRlbV9pZCAqcHBpZCkgew0KPj4rCXN0cnVjdCBwY2lfZGV2ICpwZGV2
ID0gcHJpdi0+cGRldjsNCj4+Kwl1NjQgaWQ7DQo+PisNCj4+KwlpZCA9IHBjaV9nZXRfZHNuKHBk
ZXYpOw0KPg0KPklzIHBoeXNpY2FsIHBvcnQgdXNpbmcgdGhpcyBzd2l0Y2hfaWQgYXMgd2VsbD8g
SWYgbm90LCBpdCBzaG91bGQuDQpJdCBpcyB1c2VkIGJ5IHRoZSBwaHlzaWNhbCBwb3J0IGFzIHdl
bGwuDQo+DQo+DQo+PisNCj4+KwlwcGlkLT5pZF9sZW4gPSBzaXplb2YoaWQpOw0KPj4rCXB1dF91
bmFsaWduZWRfYmU2NChpZCwgJnBwaWQtPmlkKTsNCj4+K30NCj4+Kw0KPj4rc3RhdGljIHZvaWQg
cnZ1X3JlcF9kZXZsaW5rX3BvcnRfdW5yZWdpc3RlcihzdHJ1Y3QgcmVwX2RldiAqcmVwKSB7DQo+
PisJZGV2bGlua19wb3J0X3VucmVnaXN0ZXIoJnJlcC0+ZGxfcG9ydCk7DQo+Pit9DQo+PisNCj4+
K3N0YXRpYyBpbnQgcnZ1X3JlcF9kZXZsaW5rX3BvcnRfcmVnaXN0ZXIoc3RydWN0IHJlcF9kZXYg
KnJlcCkgew0KPj4rCXN0cnVjdCBkZXZsaW5rX3BvcnRfYXR0cnMgYXR0cnMgPSB7fTsNCj4+Kwlz
dHJ1Y3Qgb3R4Ml9uaWMgKnByaXYgPSByZXAtPm1kZXY7DQo+PisJc3RydWN0IGRldmxpbmsgKmRs
ID0gcHJpdi0+ZGwtPmRsOw0KPj4rCWludCBlcnI7DQo+PisNCj4+KwlpZiAoIShyZXAtPnBjaWZ1
bmMgJiBSVlVfUEZWRl9GVU5DX01BU0spKSB7DQo+PisJCWF0dHJzLmZsYXZvdXIgPSBERVZMSU5L
X1BPUlRfRkxBVk9VUl9QSFlTSUNBTDsNCj4+KwkJYXR0cnMucGh5cy5wb3J0X251bWJlciA9IHJ2
dV9nZXRfcGYocmVwLT5wY2lmdW5jKTsNCj4+Kwl9IGVsc2Ugew0KPj4rCQlhdHRycy5mbGF2b3Vy
ID0gREVWTElOS19QT1JUX0ZMQVZPVVJfUENJX1ZGOw0KPj4rCQlhdHRycy5wY2lfdmYucGYgPSBy
dnVfZ2V0X3BmKHJlcC0+cGNpZnVuYyk7DQo+PisJCWF0dHJzLnBjaV92Zi52ZiA9IHJlcC0+cGNp
ZnVuYyAmIFJWVV9QRlZGX0ZVTkNfTUFTSzsNCj4+Kwl9DQo+PisNCj4+KwlydnVfcmVwX2Rldmxp
bmtfc2V0X3N3aXRjaF9pZChwcml2LCAmYXR0cnMuc3dpdGNoX2lkKTsNCj4+KwlkZXZsaW5rX3Bv
cnRfYXR0cnNfc2V0KCZyZXAtPmRsX3BvcnQsICZhdHRycyk7DQo+PisNCj4+KwllcnIgPSBkZXZs
X3BvcnRfcmVnaXN0ZXJfd2l0aF9vcHMoZGwsICZyZXAtPmRsX3BvcnQsIHJlcC0+cmVwX2lkLA0K
Pj4rCQkJCQkgICZydnVfcmVwX2RsX3BvcnRfb3BzKTsNCj4+KwlpZiAoZXJyKSB7DQo+PisJCWRl
dl9lcnIocmVwLT5tZGV2LT5kZXYsICJkZXZsaW5rX3BvcnRfcmVnaXN0ZXIgZmFpbGVkOiAlZFxu
IiwNCj4+KwkJCWVycik7DQo+PisJCXJldHVybiBlcnI7DQo+PisJfQ0KPj4rCXJldHVybiAwOw0K
Pj4rfQ0KPj4rDQo+PiBzdGF0aWMgaW50IHJ2dV9yZXBfZ2V0X3JlcGlkKHN0cnVjdCBvdHgyX25p
YyAqcHJpdiwgdTE2IHBjaWZ1bmMpICB7DQo+PiAJaW50IHJlcF9pZDsNCj4+QEAgLTMzOSw2ICs0
MjMsNyBAQCB2b2lkIHJ2dV9yZXBfZGVzdHJveShzdHJ1Y3Qgb3R4Ml9uaWMgKnByaXYpDQo+PiAJ
Zm9yIChyZXBfaWQgPSAwOyByZXBfaWQgPCBwcml2LT5yZXBfY250OyByZXBfaWQrKykgew0KPj4g
CQlyZXAgPSBwcml2LT5yZXBzW3JlcF9pZF07DQo+PiAJCXVucmVnaXN0ZXJfbmV0ZGV2KHJlcC0+
bmV0ZGV2KTsNCj4+KwkJcnZ1X3JlcF9kZXZsaW5rX3BvcnRfdW5yZWdpc3RlcihyZXApOw0KPj4g
CQlmcmVlX25ldGRldihyZXAtPm5ldGRldik7DQo+PiAJfQ0KPj4gCWtmcmVlKHByaXYtPnJlcHMp
Ow0KPj5AQCAtMzgxLDYgKzQ2NiwxMSBAQCBpbnQgcnZ1X3JlcF9jcmVhdGUoc3RydWN0IG90eDJf
bmljICpwcml2LCBzdHJ1Y3QNCj5uZXRsaW5rX2V4dF9hY2sgKmV4dGFjaykNCj4+IAkJc25wcmlu
dGYobmRldi0+bmFtZSwgc2l6ZW9mKG5kZXYtPm5hbWUpLCAicCVkdiVkcmVwIiwNCj4+IAkJCSBy
dnVfZ2V0X3BmKHBjaWZ1bmMpLCAocGNpZnVuYyAmDQo+UlZVX1BGVkZfRlVOQ19NQVNLKSk7DQo+
Pg0KPj4rCQllcnIgPSBydnVfcmVwX2RldmxpbmtfcG9ydF9yZWdpc3RlcihyZXApOw0KPj4rCQlp
ZiAoZXJyKQ0KPj4rCQkJZ290byBleGl0Ow0KPj4rDQo+PisJCVNFVF9ORVRERVZfREVWTElOS19Q
T1JUKG5kZXYsICZyZXAtPmRsX3BvcnQpOw0KPj4gCQlldGhfaHdfYWRkcl9yYW5kb20obmRldik7
DQo+PiAJCWVyciA9IHJlZ2lzdGVyX25ldGRldihuZGV2KTsNCj4+IAkJaWYgKGVycikgew0KPj5A
QCAtNDAyLDYgKzQ5Miw3IEBAIGludCBydnVfcmVwX2NyZWF0ZShzdHJ1Y3Qgb3R4Ml9uaWMgKnBy
aXYsIHN0cnVjdA0KPm5ldGxpbmtfZXh0X2FjayAqZXh0YWNrKQ0KPj4gCXdoaWxlICgtLXJlcF9p
ZCA+PSAwKSB7DQo+PiAJCXJlcCA9IHByaXYtPnJlcHNbcmVwX2lkXTsNCj4+IAkJdW5yZWdpc3Rl
cl9uZXRkZXYocmVwLT5uZXRkZXYpOw0KPj4rCQlydnVfcmVwX2RldmxpbmtfcG9ydF91bnJlZ2lz
dGVyKHJlcCk7DQo+PiAJCWZyZWVfbmV0ZGV2KHJlcC0+bmV0ZGV2KTsNCj4+IAl9DQo+PiAJa2Zy
ZWUocHJpdi0+cmVwcyk7DQo+PmRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC9ldGhlcm5ldC9tYXJ2
ZWxsL29jdGVvbnR4Mi9uaWMvcmVwLmgNCj4+Yi9kcml2ZXJzL25ldC9ldGhlcm5ldC9tYXJ2ZWxs
L29jdGVvbnR4Mi9uaWMvcmVwLmgNCj4+aW5kZXggMGNlZmE0ODJmODNjLi5kODFhZjM3NmJmNTAg
MTAwNjQ0DQo+Pi0tLSBhL2RyaXZlcnMvbmV0L2V0aGVybmV0L21hcnZlbGwvb2N0ZW9udHgyL25p
Yy9yZXAuaA0KPj4rKysgYi9kcml2ZXJzL25ldC9ldGhlcm5ldC9tYXJ2ZWxsL29jdGVvbnR4Mi9u
aWMvcmVwLmgNCj4+QEAgLTM0LDEwICszNCwxMiBAQCBzdHJ1Y3QgcmVwX2RldiB7DQo+PiAJc3Ry
dWN0IG5ldF9kZXZpY2UgKm5ldGRldjsNCj4+IAlzdHJ1Y3QgcmVwX3N0YXRzIHN0YXRzOw0KPj4g
CXN0cnVjdCBkZWxheWVkX3dvcmsgc3RhdHNfd3JrOw0KPj4rCXN0cnVjdCBkZXZsaW5rX3BvcnQg
ZGxfcG9ydDsNCj4+IAl1MTYgcmVwX2lkOw0KPj4gCXUxNiBwY2lmdW5jOw0KPj4gI2RlZmluZSBS
VlVfUkVQX1ZGX0lOSVRJQUxJWkVECQlCSVRfVUxMKDApDQo+PiAJdTggZmxhZ3M7DQo+PisJdTgJ
bWFjW0VUSF9BTEVOXTsNCj4+IH07DQo+Pg0KPj4gc3RhdGljIGlubGluZSBib29sIG90eDJfcmVw
X2RldihzdHJ1Y3QgcGNpX2RldiAqcGRldikNCj4+LS0NCj4+Mi4yNS4xDQo+Pg0K

