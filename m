Return-Path: <netdev+bounces-247404-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 95297CF983D
	for <lists+netdev@lfdr.de>; Tue, 06 Jan 2026 18:02:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A180E310B202
	for <lists+netdev@lfdr.de>; Tue,  6 Jan 2026 16:52:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 302D2326D5D;
	Tue,  6 Jan 2026 16:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="Am+dhY/2"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22BAB337B8C;
	Tue,  6 Jan 2026 16:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.148.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767718329; cv=fail; b=UBFPB7dSvoHDvimS58TncOEEeZFkbgI/7VrPdzIjoGigiHZ+8KD/t2BzMpYmiyHDnarvDert4n2aY9FxXA90abdlidPcCycvIjMNTN4ooyiplkpz9Cm4G09EHfvBOljyxJ1s8ob9LXFO3H1dl21swPFb5h8h4vdU33AAVhkGpLw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767718329; c=relaxed/simple;
	bh=GohFCXI7GawsE+NHbbHbAAtgYusndncxltYd7GZ3w6A=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=POeZKAZ5f9laQBZOsYKUubyJI7CvjcSbgbgKCvVY1VoVnp9qODZkl0gJoiSgG4k8GkU9K6XBv4d/qwX05Djy9wjwx+6A/8ZDQLveUeSZYKb/P4SzjIBH7K94teGbNAjY4Kcrpt5yt74u7pZB3i0ipz4UzLZj4/LhUmz5diiPR9s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=Am+dhY/2; arc=fail smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6061nhXm128561;
	Tue, 6 Jan 2026 08:49:55 -0800
Received: from dm5pr21cu001.outbound.protection.outlook.com (mail-centralusazon11021078.outbound.protection.outlook.com [52.101.62.78])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4bg9crkbuk-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 06 Jan 2026 08:49:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JhT9ZKzjGBrj7yIzJbfkU2C2Q+oD+Z4o8s3/r3qURW9lY1rvBdyQABRsaQf8QQFoW7uunbQ3J/7dJoCds1fQW2Hp/l0RXFFBv1GIwVCXxaiJMlWANq/uwa0XRHNN1HdV1TUAh6gCul1yeDoe54f15Br4XYvyR5ZkGmNUXfZD7PvQIBOnA+bzCtRy+5YufLUlo+xgOh31ZmxvwauY+HSw3Xy/4HIniy8JDdm8w5DhqKP6Ao86KvDiMTB5gqA+BnlioZJDWECEuNZd1ORJ8YngmieVUYhiqb4+3C03+sr9zV6Nb8jF7X7MUkdZP1HYC/QTmIj6dNcZTHNDh3SMF1OLzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GohFCXI7GawsE+NHbbHbAAtgYusndncxltYd7GZ3w6A=;
 b=XS/NNWQEuR1WgYZngZgAvkj+ldxBccbzdgGTkONBUDXaHAQfNsnYsAG0i6xJYQ0IrGGVL6tCduVDybTfJfXU/fMFBBLZpV67D4teM2zEX7e7unGa7N7/9kdV3skQJyOf/+oEUs7hIocrkEwPwmvJOlshxCV1xfdKdDO5AFOGniwmQm7JewNJ9u3yZu95zP5S9B2oW1WlsWNFHFZOxZ7aRoCTDJguXa2DFOSL1xe464NSG0bJoIiI6ujOxdINC77oLsr7mHVgKXQa5gmYzBVRUB/qWcgo8vBxUn7RUmyWANza3PPmWKeruFk02ARZeX1WvlK3zkjQI+3JM5qLgFT7AQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GohFCXI7GawsE+NHbbHbAAtgYusndncxltYd7GZ3w6A=;
 b=Am+dhY/2yH27PFv8C3cdJPpr1Z/OGO33QW6W0Pf9q9aK5Pj4oZYtziWVuGkPK+dfN3+fCh/3yH8oGJyrgU1SdHfqSpZFv5lUmpBA1Owe8ZtYHNYtFZ7BI1AhKsXVynL291eRHbFyfSIIbP087U3JB9YnAFZYgxiSM+TpXT/n7IY=
Received: from BYAPR18MB3735.namprd18.prod.outlook.com (2603:10b6:a02:ca::16)
 by MW3PR18MB3644.namprd18.prod.outlook.com (2603:10b6:303:53::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Tue, 6 Jan
 2026 16:49:52 +0000
Received: from BYAPR18MB3735.namprd18.prod.outlook.com
 ([fe80::dc04:c5c6:6e8:53de]) by BYAPR18MB3735.namprd18.prod.outlook.com
 ([fe80::dc04:c5c6:6e8:53de%6]) with mapi id 15.20.9478.005; Tue, 6 Jan 2026
 16:49:51 +0000
From: Sai Krishna Gajula <saikrishnag@marvell.com>
To: Slark Xiao <slark_xiao@163.com>,
        "loic.poulain@oss.qualcomm.com"
	<loic.poulain@oss.qualcomm.com>,
        "ryazanov.s.a@gmail.com"
	<ryazanov.s.a@gmail.com>,
        "johannes@sipsolutions.net"
	<johannes@sipsolutions.net>,
        "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com"
	<edumazet@google.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "mani@kernel.org" <mani@kernel.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [net-next v4 2/8] net: wwan: core: split port creation and
 registration
Thread-Topic: [net-next v4 2/8] net: wwan: core: split port creation and
 registration
Thread-Index: AQHcfyx5WGpzaXcBBk60Da8xJYeceQ==
Date: Tue, 6 Jan 2026 16:49:50 +0000
Message-ID:
 <BYAPR18MB37352E69CB7B685926A574B9A087A@BYAPR18MB3735.namprd18.prod.outlook.com>
References: <20260105102018.62731-1-slark_xiao@163.com>
 <20260105102018.62731-3-slark_xiao@163.com>
In-Reply-To: <20260105102018.62731-3-slark_xiao@163.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR18MB3735:EE_|MW3PR18MB3644:EE_
x-ms-office365-filtering-correlation-id: 3d1ba476-9dc2-427b-efd4-08de4d439c55
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|7416014|366016|376014|38070700021|921020;
x-microsoft-antispam-message-info:
 =?utf-8?B?Y2J2QlI4NmQ3U3BFNXBJSDZsTnMrTnJmTmQ0OTVpVHNhb2trSjJjMXFBb2NG?=
 =?utf-8?B?QnJUb1ozV0srM0FuZk42NVI3OEVWTnVDZmh1Z25JN3c5WDUrUG1qUmpxdzk1?=
 =?utf-8?B?TWYyb253K1VsbVl2cmN1R0ZOR0JDai91czdxdncyWXMyT3JUZWg3Y01MWWVy?=
 =?utf-8?B?ZndDbmdmK0I4S2VONVM3a3Z2c1ZlU29xSXZVaFN4YlBMWWZ0NFNRK2hUYjRl?=
 =?utf-8?B?Q0QwckMzWW1SSFZWZi9mc0lRODkzQkdzaVFwMytYYVhiUGRybkFZczljdWxN?=
 =?utf-8?B?akFYek82cjNQbnNCeUNEb2x6RWpRUTlJM2plL3A3Q2t6MlZiL0F0WmFtQ3dX?=
 =?utf-8?B?Z1pGRnRLNWZNU2F4RTA0ZzEvdXhVUXRIbjduSEtkaFUvcGNlVkF2V0VsbElI?=
 =?utf-8?B?ZXBFaWJxbXkyQUVGOHFEZGQ3SHJZelYxNUVBa01XVUZOQ2xYbkU4dDRlekk0?=
 =?utf-8?B?VkE2d2ttQkdiTm9rQzgzZElzckg2eFlaT3E1bHRiUXVFUno1VkxJSVY1WkVs?=
 =?utf-8?B?V3ArYXpFU21WMTBwWkFvUFRXZ3lnaGRicklUNVJtUFlkZndWZUpKMUN0S1Ar?=
 =?utf-8?B?WmxHYjIyN1JXS0FrK0VldDVWZG1FVU90ZVdWSjFXNWRNeGFxNk1LSVArS3RJ?=
 =?utf-8?B?ZDQ1SkNNbi9GOEE5VTh1UjhqOC9hbUd3QlZRN01wTGV6MnVzeWZ4eUlrV2Ex?=
 =?utf-8?B?ZStWZWNyNHVIei92YnBaNlpvb1E2THBEK1BjTjNhQ0pvMlFBQjJpOFZNeFhD?=
 =?utf-8?B?TzF6eE53VExTcks2WHlTMVVkbHRPQkEzOWszUGxoSCt3b1VlK0tqMVJaTjMw?=
 =?utf-8?B?bjVCZGZ3d3VjeURyQjNrZVVCamNCOHBDaGZGWEU5K21PNERoUjdEbWNicy9w?=
 =?utf-8?B?M2tuZUNscllXb0pCWGkvR2kvb2ZCZ0l3VjkxQ3lDWldHOW0zSTVyVzFlV25v?=
 =?utf-8?B?ZlBJc2ZhLzIydWl2aXJvSWFtZkFkV0V4S0hyd2tkazRXcG03UDdDVm1xc3dQ?=
 =?utf-8?B?NmZOU2ZKNXBNK0FneFVFNW1rMEQ1eFphT250cmJhQ0IyN3NGemZYclovVWhH?=
 =?utf-8?B?c0ZRZm5xRWtzNWVMbzd0cEs5V0cyaExCSE5nWUpqdUt5TWVaaWpzTUUxa2hR?=
 =?utf-8?B?Ry9JRkVqMC9zempZd29FVGM3L01UNUsrWGlqNmZRdEtJNTc3SGYwWEdqdC91?=
 =?utf-8?B?OWJTazFrNVJKZEgxU1VaWWk2bzR6SnIxVGZPQ1g2bk95YWpMY1JSRGhaeTRx?=
 =?utf-8?B?aVBhWjZ3YStzd3dDY29vTTg1NVFaYWlZNzBuTkhmMW1OT0x0WVJSTUlySVkv?=
 =?utf-8?B?cnNlZUdBQXh2OFN1azdLaXlxOHh3Q3g4YXlGOExFZklxTk1mMzA0WmpKRTJo?=
 =?utf-8?B?NTN4QVlEWTF0dUtONlhjang5Z3NvN2srSHpieUJBT0tpN2hlSEYzVTVjTHJI?=
 =?utf-8?B?djliK3NZazNJUFEwMURIQ09OV3JxTTdqYWJ4UTZPN1pZN29EN3dub25SSDhW?=
 =?utf-8?B?TFFWbktTVU5rVWUyK0NyVS9GZUs2TzlpY3Q3bHE0QW1adHJEb3M4ejllQ3lu?=
 =?utf-8?B?RVZsYy9rS1JoSG9WZkExWU5mZURISkQ4TkF0bWVUWG8rbHJWQTI5aU14M0pO?=
 =?utf-8?B?cW5PWXNhQTJtWFFGUzlSTEs1ay96SHJqWUxRMENabTRVWDZyN1pGdE1UTldR?=
 =?utf-8?B?c3M3WHZqREttRFpGb1NRdkZ1TFpWN0FiS2pQOFk1aENURmF5a0kzR1dUUy90?=
 =?utf-8?B?QnRkQlo2NlAvdE1BQjZZbG43Q0JLVTFzY1hVbWplK1dib3NFcEdjS1NVWldj?=
 =?utf-8?B?Z3FzWG1tVXJwaUh4RXVPY25Wa0pEZVFRN0p6MEpxekIwcEtEc3A2bzRYV25P?=
 =?utf-8?B?dDYzMmxucVlUT0RUVU90cm5xZVhGVXplcW1SM1hxak1scjY5YVdvL2dCYnVV?=
 =?utf-8?B?TTE5bGdQZVVyVFBhSEhCU0hZWXZpdlV1aXVrQ0VmcXBRTko4OTFtM3JqZXBa?=
 =?utf-8?B?dUdwVFlXanR6YnAyU2JLYmxXTk1VMDE0cXJYdVFEdy84cTQvajhJa3AxbURG?=
 =?utf-8?B?QkQva0lFVWVpbWlPRTJVZkh5ZExiVEllWTdmQT09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR18MB3735.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(376014)(38070700021)(921020);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MUpMV0NobVVhWTZORGlKQ25KZ0xtU0pPbkRUWkc2MTFXRmtYRWM4Wm1hRXVi?=
 =?utf-8?B?UzJsVE5SQi8yQUhDTWM1QXdjV2hrY0hkVHdIaGFKRW1MWEx6QWYzZFBDb2Jl?=
 =?utf-8?B?NGlJRnhxVXNITW9tdy9OeTJjbHFHcHZ2UGU3MDZJRUE1bUtrUmsvVlVPYm5h?=
 =?utf-8?B?RzJ4c1FuSk9xbTFtTDFZMjMrT295dnpRWTVjRXorcHhpR2pWMmhCYUNLRUlP?=
 =?utf-8?B?dE1NdWVCRWYrOWh6RU9aa0hxQ3VyaUdmMWJOUW5UdjhRWmk1SzdTZXVzYWhV?=
 =?utf-8?B?ekVyeUtlUHUvMlArVDNBVWdSZ2N3T2NzK1NCYTBrTitibnJsTTJHd0tmNE5H?=
 =?utf-8?B?UytLVWxhZHoxTldiL2t4Z1M1Z2VIMllBQmV2SmY1ZlgvaVBHWVRxR2ZSUlVV?=
 =?utf-8?B?c1pFSmpjbDBqdmMyMGdoS2RlWDFwbm9JV0R6Ris1WloyWGhLVGJQNTJnSVJH?=
 =?utf-8?B?ZDViZlRrQ0djMmljeFdqS3FEcEVkV2ROS29lU3BtckRpOXdnMzdMb1lGa1d2?=
 =?utf-8?B?eElZK3Y4NXV6NGhLbTNkTSs2azZmcVl0NmJWUnhrY0srWGg3UXAyNTQ3R3lW?=
 =?utf-8?B?ZXExeGh2eVRDNWY4ZFJZaHREaVV3bWkrcmQrWlNlbC96WXloV2tVdGlMTExj?=
 =?utf-8?B?Z1RLZmRGcjNrWTF4RkhMWm8rdFFoUkhmVmJJcHJrS3o5emhlMDMzMHE0MVVz?=
 =?utf-8?B?SmRmRjhXSnF1T3JLVmphWDV5ZUhyWWozcmU3eUlxMFRkSkpPeDJSdjdicEJ0?=
 =?utf-8?B?RXNsOFdIbjI0S1dQNUF5enRNUHVweDNNUzk2YmFMWXdnL01wZUhyV1BWWElH?=
 =?utf-8?B?NGU1Q1dTZUJuVXQ3c0ZlTTlKSmNkWUx4TnRyM2ViMGc5WE03YVBwL1RPYWlH?=
 =?utf-8?B?ejJKWmxydS84SHNaOVcxcEhCUEFNVmVmemZ1QkxqTDY0WHplNEpBc2dRejl1?=
 =?utf-8?B?ZUZlSDRDOVpWdzY5ZE91djY1NjhyQ1hIRE4xeHZxVDV6UUlQUjVnL1BBMlNa?=
 =?utf-8?B?MThrbXpUcU9VY01hYnVOTkp5RlhLVFA2L09uVHM5WCtsUVZvbkcrUG1Ncm5Q?=
 =?utf-8?B?Y1RzVDNlV280K2FxOHJjZk0rS1V6cVBVUy9WQXN5QnV1eUljWHV2bEg5dDl3?=
 =?utf-8?B?VkJiOGpPVzllT2lkcTgvditzRVZlZnJjVjhObWZUZXl1RE5NNStKSDQxWEhU?=
 =?utf-8?B?YUtjamJHVXBIbDZ2RThpNGMzQTJtaysrYXFXdkdtWXBuUlhpWVljQjVYQzZv?=
 =?utf-8?B?Uzlua2I4K0lJNWRYbVRmdXVPNEtHdVpQU3VZY3NwMEJHa0ZLNkFDUlo0NDNW?=
 =?utf-8?B?c0RlUjlsOTNKSkdEaENWa1lCc1ZlK0F2WnlXKy91eGVsNU5kVDByb3BJL0Yx?=
 =?utf-8?B?VjllZm9Vc2hBTlZSVEFxQXhyd1AvZ09iV0cyZXhFQUY5MGdPOTNlVW1pVWdu?=
 =?utf-8?B?VWJVbGlLMmprOG9FdXF2VHVQVW1BOTdqLzFubFRVdGJmTlhvL2JyOUNOak02?=
 =?utf-8?B?MzYrY3Y2c3VSd3VEelQyK3hWdWRLeHUyRjBjMkZQWmdiMkw0RUNpWmpteTFR?=
 =?utf-8?B?R3JzQlhCOGRXVDQveklpd2h6RG9HbzduSGZPUzhMLzIxV2U5SkdYWFhyakN4?=
 =?utf-8?B?MXNBZVNuM2hBZUFNMmNVWlRENnRoRGdBbTl4MWlscW5qc0ErSENENEdpY2VZ?=
 =?utf-8?B?TFNFa1JxQTlHYVJLSk5ZOGhQdURneVRTaWl1R3phSWpQallDNERzTWp5NFpt?=
 =?utf-8?B?SUVTYm5hcndVd0FuRVZzYXJ5WllhSGJLRythUGEyK0xqa2d1NHVIKzZKVTRq?=
 =?utf-8?B?dU9GS3laWko5eTFaUVFzazJjOGJBZU4wejNZeDUrVks4UkcwVXRaK01lMmpw?=
 =?utf-8?B?SG9aMWEvc3d6Zys5d3RPSVk5anp3WFUxY0gvVW1GcGJOT3BFNmtKNWwyYnpl?=
 =?utf-8?B?RFdjT0wrcXFrNHFPMmREdUZXOXhkcjdsVkJNODMzcWNuaGRCU0VwVDBiWHUy?=
 =?utf-8?B?UC9BUkorNzFaeHV4UW8vbGF0dFdKZURJT2Ywa2hRODliS2VlQk1sajZMWWhH?=
 =?utf-8?B?dTY0eHRzakJxZWJENUhUZkFabmhvc2ZBN2lrdklaMUtEell4bS9rWWRKWDFT?=
 =?utf-8?B?Qnlld0xHa2lScmNlYkdjNmh6T2N4ODdYOGtSVlBHeXJOR2xlUnlEYlFxNHBF?=
 =?utf-8?B?c2Q5R0Y3UkNTU1BxWHhhZWF0Sm1zc2NXN3hEQ1gvNXF3dEcyWkRvdkh6RUlR?=
 =?utf-8?B?MlVJNEhURFpnMlhWRTloR2Iza0VNSHFUNUgzdU95aVQrbTVwZUpudHhiTUJR?=
 =?utf-8?B?eFNhQTdKZzJtUTE1RFBEVEV2TzV0NmZJMmJOekJPbjdzOHFNckpPZz09?=
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
X-MS-Exchange-CrossTenant-AuthSource: BYAPR18MB3735.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d1ba476-9dc2-427b-efd4-08de4d439c55
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jan 2026 16:49:51.3798
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PMe2j8Gw+0VEhtPi93L1nLToTIX1i0Vj3eq3LPWf1s/CVyjF8AH+6beiD6ZLxL7kGRCa3oPUmRDvp8YOXpKKLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR18MB3644
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA2MDE0NiBTYWx0ZWRfX66NEYrS4bcVd
 eX0PwsnmRjdW3Uge+a6h0Ypd965M+RZlnMcspFusES3xFR14bACsn89JpgQht0k4+XfhLPyDGNd
 yYbNbglIgSHcp4WAUk9A0ejltY38yb7eo2ExVrGkYrblxA4t0X3jzdyiS/m2N2giu6E4ZJkXmHl
 yDhSzUbm0doTsLshnX5WXuVn9NsBsq5NteNM/FIUo+hUA4CuL/SX2jltt3sIgfJ5OdXj2p8ZdN4
 YGyBJZYEJ8JzCth5WUZmOBCD75sN4W1j8Hh9FeTf7RlY9zMSTBqWZPiSoRRMKjbYGfs20cxNFq4
 nWIIPVUgmC5a/r90OepfIdfuUwD91wctrd3sq7J89qieFiNVJp6KP96KmeUTsMqIYX6C35IFoSi
 Ie1a8EMsxxtM/Ver8a9GzxQxj3FHOkfClNp6+6jkQIRHc+c9g5NO52kC8KPt4cULtTuDMZ2E4r0
 B2rfkzTsQhxfx8nmsFQ==
X-Proofpoint-ORIG-GUID: laKm94JM5OfejcW4e2A-OfaT41rwdI33
X-Authority-Analysis: v=2.4 cv=aLr9aL9m c=1 sm=1 tr=0 ts=695d3d33 cx=c_pps
 a=c/RC1Hvpwd1gfJZSTjwoVw==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=vUbySO9Y5rIA:10 a=-AAbraWEqlQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Byx-y9mGAAAA:8 a=EUspDBNiAAAA:8 a=pGLkceISAAAA:8 a=stkexhm8AAAA:8
 a=J1Y8HTJGAAAA:8 a=1XWaLZrsAAAA:8 a=VwQbUJbxAAAA:8 a=20KFwNOVAAAA:8
 a=cZGfZfm_mbGjjpRzKoQA:9 a=QEXdDO2ut3YA:10 a=pIW3pCRaVxJDc-hWtpF8:22
 a=y1Q9-5lHfBjTkpIzbSAN:22
X-Proofpoint-GUID: laKm94JM5OfejcW4e2A-OfaT41rwdI33
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-06_01,2026-01-06_01,2025-10-01_01

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFNsYXJrIFhpYW8gPHNsYXJr
X3hpYW9AMTYzLmNvbT4NCj4gU2VudDogTW9uZGF5LCBKYW51YXJ5IDUsIDIwMjYgMzo1MCBQTQ0K
PiBUbzogbG9pYy5wb3VsYWluQG9zcy5xdWFsY29tbS5jb207IHJ5YXphbm92LnMuYUBnbWFpbC5j
b207DQo+IGpvaGFubmVzQHNpcHNvbHV0aW9ucy5uZXQ7IGFuZHJldytuZXRkZXZAbHVubi5jaDsN
Cj4gZGF2ZW1AZGF2ZW1sb2Z0Lm5ldDsgZWR1bWF6ZXRAZ29vZ2xlLmNvbTsga3ViYUBrZXJuZWwu
b3JnOw0KPiBwYWJlbmlAcmVkaGF0LmNvbTsgbWFuaUBrZXJuZWwub3JnDQo+IENjOiBuZXRkZXZA
dmdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6
IFtuZXQtbmV4dCB2NCAyLzhdIG5ldDogd3dhbjogY29yZTogc3BsaXQgcG9ydCBjcmVhdGlvbiBh
bmQNCj4gcmVnaXN0cmF0aW9uDQo+IA0KPiBGcm9tOiBTZXJnZXkgUnlhemFub3YgPHJ5YXphbm92
LuKAinMu4oCKYUDigIpnbWFpbC7igIpjb20+IFVwY29taW5nIEdOU1MgKE5NRUEpDQo+IHBvcnQg
dHlwZSBzdXBwb3J0IHJlcXVpcmVzIGV4cG9ydGluZyBpdCB2aWEgdGhlIEdOU1Mgc3Vic3lzdGVt
LiBPbiBhbm90aGVyDQo+IGhhbmQsIHdlIHN0aWxsIG5lZWQgdG8gZG8gYmFzaWMgV1dBTiBjb3Jl
IHdvcms6IGZpbmQgb3IgYWxsb2NhdGUgdGhlIFdXQU4NCj4gZGV2aWNlLCBtYWtlIGl0IHRoZSAN
Cj4gRnJvbTogU2VyZ2V5IFJ5YXphbm92IDxyeWF6YW5vdi5zLmFAZ21haWwuY29tPg0KPiANCj4g
VXBjb21pbmcgR05TUyAoTk1FQSkgcG9ydCB0eXBlIHN1cHBvcnQgcmVxdWlyZXMgZXhwb3J0aW5n
IGl0IHZpYSB0aGUgR05TUw0KPiBzdWJzeXN0ZW0uIE9uIGFub3RoZXIgaGFuZCwgd2Ugc3RpbGwg
bmVlZCB0byBkbyBiYXNpYyBXV0FOIGNvcmUNCj4gd29yazogZmluZCBvciBhbGxvY2F0ZSB0aGUg
V1dBTiBkZXZpY2UsIG1ha2UgaXQgdGhlIHBvcnQgcGFyZW50LCBldGMuIFRvIHJldXNlDQo+IGFz
IG11Y2ggY29kZSBhcyBwb3NzaWJsZSwgc3BsaXQgdGhlIHBvcnQgY3JlYXRpb24gZnVuY3Rpb24g
aW50byB0aGUgcmVnaXN0cmF0aW9uDQo+IG9mIGEgcmVndWxhciBXV0FOIHBvcnQgZGV2aWNlLCBh
bmQgYmFzaWMgcG9ydCBzdHJ1Y3QgaW5pdGlhbGl6YXRpb24uDQo+IA0KPiBUbyBiZSBhYmxlIHRv
IHVzZSBwdXRfZGV2aWNlKCkgdW5pZm9ybWx5LCBicmVhayB0aGUgZGV2aWNlX3JlZ2lzdGVyKCkg
Y2FsbCBpbnRvDQo+IGRldmljZV9pbml0aWFsaXplKCkgYW5kIGRldmljZV9hZGQoKSBhbmQgY2Fs
bCBkZXZpY2UgaW5pdGlhbGl6YXRpb24gZWFybGllci4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IFNl
cmdleSBSeWF6YW5vdiA8cnlhemFub3Yucy5hQGdtYWlsLmNvbT4NCj4gLS0tDQo+ICBkcml2ZXJz
L25ldC93d2FuL3d3YW5fY29yZS5jIHwgNjYgKysrKysrKysrKysrKysrKysrKysrKy0tLS0tLS0t
LS0tLS0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgNDAgaW5zZXJ0aW9ucygrKSwgMjYgZGVsZXRpb25z
KC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvd3dhbi93d2FuX2NvcmUuYyBiL2Ry
aXZlcnMvbmV0L3d3YW4vd3dhbl9jb3JlLmMNCj4gaW5kZXggYWRlOGJiZmZjOTNlLi5lZGVlNWZm
NDhmMjggMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvbmV0L3d3YW4vd3dhbl9jb3JlLmMNCj4gKysr
IGIvZHJpdmVycy9uZXQvd3dhbi93d2FuX2NvcmUuYw0KPiBAQCAtMzYxLDcgKzM2MSw4IEBAIHN0
YXRpYyB2b2lkIHd3YW5fcG9ydF9kZXN0cm95KHN0cnVjdCBkZXZpY2UgKmRldikgIHsNCj4gIAlz
dHJ1Y3Qgd3dhbl9wb3J0ICpwb3J0ID0gdG9fd3dhbl9wb3J0KGRldik7DQo+IA0KPiAtCWlkYV9m
cmVlKCZtaW5vcnMsIE1JTk9SKHBvcnQtPmRldi5kZXZ0KSk7DQo+ICsJaWYgKGRldi0+Y2xhc3Mg
PT0gJnd3YW5fY2xhc3MpDQo+ICsJCWlkYV9mcmVlKCZtaW5vcnMsIE1JTk9SKGRldi0+ZGV2dCkp
Ow0KPiAgCW11dGV4X2Rlc3Ryb3koJnBvcnQtPmRhdGFfbG9jayk7DQo+ICAJbXV0ZXhfZGVzdHJv
eSgmcG9ydC0+b3BzX2xvY2spOw0KPiAgCWtmcmVlKHBvcnQpOw0KPiBAQCAtNDQwLDYgKzQ0MSw0
MSBAQCBzdGF0aWMgaW50IF9fd3dhbl9wb3J0X2Rldl9hc3NpZ25fbmFtZShzdHJ1Y3QNCj4gd3dh
bl9wb3J0ICpwb3J0LCBjb25zdCBjaGFyICpmbXQpDQo+ICAJcmV0dXJuIGRldl9zZXRfbmFtZSgm
cG9ydC0+ZGV2LCAiJXMiLCBidWYpOyAgfQ0KPiANCj4gKy8qIFJlZ2lzdGVyIGEgcmVndWxhciBX
V0FOIHBvcnQgZGV2aWNlIChlLmcuIEFULCBNQklNLCBldGMuKSAqLyBzdGF0aWMNCj4gK2ludCB3
d2FuX3BvcnRfcmVnaXN0ZXJfd3dhbihzdHJ1Y3Qgd3dhbl9wb3J0ICpwb3J0KSB7DQoNCkFzIHBl
ciBrZXJuZWwgc3R5bGUsIGJyYWNlcyBuZWVkIHRvIGJlIG9uIG5leHQgbGluZSANCmludCB3d2Fu
X3BvcnRfcmVnaXN0ZXJfd3dhbihzdHJ1Y3Qgd3dhbl9wb3J0ICpwb3J0KSANCnsNCi4uLg0KfQ0K
DQo+ICsJc3RydWN0IHd3YW5fZGV2aWNlICp3d2FuZGV2ID0gdG9fd3dhbl9kZXYocG9ydC0+ZGV2
LnBhcmVudCk7DQo+ICsJY2hhciBuYW1lZm10WzB4MjBdOw0KPiArCWludCBtaW5vciwgZXJyOw0K
PiArDQo+ICsJLyogQSBwb3J0IGlzIGV4cG9zZWQgYXMgY2hhcmFjdGVyIGRldmljZSwgZ2V0IGEg
bWlub3IgKi8NCj4gKwltaW5vciA9IGlkYV9hbGxvY19yYW5nZSgmbWlub3JzLCAwLCBXV0FOX01B
WF9NSU5PUlMgLSAxLA0KPiBHRlBfS0VSTkVMKTsNCj4gKwlpZiAobWlub3IgPCAwKQ0KPiArCQly
ZXR1cm4gbWlub3I7DQo+ICsNCj4gKwlwb3J0LT5kZXYuY2xhc3MgPSAmd3dhbl9jbGFzczsNCj4g
Kwlwb3J0LT5kZXYuZGV2dCA9IE1LREVWKHd3YW5fbWFqb3IsIG1pbm9yKTsNCj4gKw0KPiArCS8q
IGFsbG9jYXRlIHVuaXF1ZSBuYW1lIGJhc2VkIG9uIHd3YW4gZGV2aWNlIGlkLCBwb3J0IHR5cGUg
YW5kDQo+IG51bWJlciAqLw0KPiArCXNucHJpbnRmKG5hbWVmbXQsIHNpemVvZihuYW1lZm10KSwg
Ind3YW4ldSVzJSVkIiwgd3dhbmRldi0NCj4gPmlkLA0KPiArCQkgd3dhbl9wb3J0X3R5cGVzW3Bv
cnQtPnR5cGVdLmRldnN1Zik7DQo+ICsNCj4gKwkvKiBTZXJpYWxpemUgcG9ydHMgcmVnaXN0cmF0
aW9uICovDQo+ICsJbXV0ZXhfbG9jaygmd3dhbl9yZWdpc3Rlcl9sb2NrKTsNCj4gKw0KPiArCV9f
d3dhbl9wb3J0X2Rldl9hc3NpZ25fbmFtZShwb3J0LCBuYW1lZm10KTsNCj4gKwllcnIgPSBkZXZp
Y2VfYWRkKCZwb3J0LT5kZXYpOw0KPiArDQo+ICsJbXV0ZXhfdW5sb2NrKCZ3d2FuX3JlZ2lzdGVy
X2xvY2spOw0KPiArDQo+ICsJaWYgKGVycikNCj4gKwkJcmV0dXJuIGVycjsNClBsZWFzZSBjaGVj
aywgaWYgZnJlZWluZyB3aXRoIGlkYV9mcmVlIGlzIHJlcXVpcmVkIGJlZm9yZSByZXR1cm5pbmcg
ZXJyLg0KaWYgKGVycikgew0KICAgIGlkYV9mcmVlKCZtaW5vcnMsIG1pbm9yKTsNCiAgICByZXR1
cm4gZXJyOw0KfQ0KPiArDQo+ICsJZGV2X2luZm8oJnd3YW5kZXYtPmRldiwgInBvcnQgJXMgYXR0
YWNoZWRcbiIsIGRldl9uYW1lKCZwb3J0LQ0KPiA+ZGV2KSk7DQo+ICsNCj4gKwlyZXR1cm4gMDsN
Cj4gK30NCj4gKw0KPiAgc3RydWN0IHd3YW5fcG9ydCAqd3dhbl9jcmVhdGVfcG9ydChzdHJ1Y3Qg
ZGV2aWNlICpwYXJlbnQsDQo+ICAJCQkJICAgZW51bSB3d2FuX3BvcnRfdHlwZSB0eXBlLA0KPiAg
CQkJCSAgIGNvbnN0IHN0cnVjdCB3d2FuX3BvcnRfb3BzICpvcHMsIEBAIC0NCj4gNDQ4LDggKzQ4
NCw3IEBAIHN0cnVjdCB3d2FuX3BvcnQgKnd3YW5fY3JlYXRlX3BvcnQoc3RydWN0IGRldmljZQ0K
PiAqcGFyZW50LCAgew0KPiAgCXN0cnVjdCB3d2FuX2RldmljZSAqd3dhbmRldjsNCj4gIAlzdHJ1
Y3Qgd3dhbl9wb3J0ICpwb3J0Ow0KPiAtCWNoYXIgbmFtZWZtdFsweDIwXTsNCj4gLQlpbnQgbWlu
b3IsIGVycjsNCj4gKwlpbnQgZXJyOw0KPiANCj4gIAlpZiAodHlwZSA+IFdXQU5fUE9SVF9NQVgg
fHwgIW9wcykNCj4gIAkJcmV0dXJuIEVSUl9QVFIoLUVJTlZBTCk7DQo+IEBAIC00NjEsMTcgKzQ5
Niw5IEBAIHN0cnVjdCB3d2FuX3BvcnQgKnd3YW5fY3JlYXRlX3BvcnQoc3RydWN0IGRldmljZQ0K
PiAqcGFyZW50LA0KPiAgCWlmIChJU19FUlIod3dhbmRldikpDQo+ICAJCXJldHVybiBFUlJfQ0FT
VCh3d2FuZGV2KTsNCj4gDQo+IC0JLyogQSBwb3J0IGlzIGV4cG9zZWQgYXMgY2hhcmFjdGVyIGRl
dmljZSwgZ2V0IGEgbWlub3IgKi8NCj4gLQltaW5vciA9IGlkYV9hbGxvY19yYW5nZSgmbWlub3Jz
LCAwLCBXV0FOX01BWF9NSU5PUlMgLSAxLA0KPiBHRlBfS0VSTkVMKTsNCj4gLQlpZiAobWlub3Ig
PCAwKSB7DQo+IC0JCWVyciA9IG1pbm9yOw0KPiAtCQlnb3RvIGVycm9yX3d3YW5kZXZfcmVtb3Zl
Ow0KPiAtCX0NCj4gLQ0KPiAgCXBvcnQgPSBremFsbG9jKHNpemVvZigqcG9ydCksIEdGUF9LRVJO
RUwpOw0KPiAgCWlmICghcG9ydCkgew0KPiAgCQllcnIgPSAtRU5PTUVNOw0KPiAtCQlpZGFfZnJl
ZSgmbWlub3JzLCBtaW5vcik7DQo+ICAJCWdvdG8gZXJyb3Jfd3dhbmRldl9yZW1vdmU7DQo+ICAJ
fQ0KPiANCj4gQEAgLTQ4NSwyNyArNTEyLDE0IEBAIHN0cnVjdCB3d2FuX3BvcnQgKnd3YW5fY3Jl
YXRlX3BvcnQoc3RydWN0IGRldmljZQ0KPiAqcGFyZW50LA0KPiAgCW11dGV4X2luaXQoJnBvcnQt
PmRhdGFfbG9jayk7DQo+IA0KPiAgCXBvcnQtPmRldi5wYXJlbnQgPSAmd3dhbmRldi0+ZGV2Ow0K
PiAtCXBvcnQtPmRldi5jbGFzcyA9ICZ3d2FuX2NsYXNzOw0KPiAgCXBvcnQtPmRldi50eXBlID0g
Jnd3YW5fcG9ydF9kZXZfdHlwZTsNCj4gLQlwb3J0LT5kZXYuZGV2dCA9IE1LREVWKHd3YW5fbWFq
b3IsIG1pbm9yKTsNCj4gIAlkZXZfc2V0X2RydmRhdGEoJnBvcnQtPmRldiwgZHJ2ZGF0YSk7DQo+
ICsJZGV2aWNlX2luaXRpYWxpemUoJnBvcnQtPmRldik7DQo+IA0KPiAtCS8qIGFsbG9jYXRlIHVu
aXF1ZSBuYW1lIGJhc2VkIG9uIHd3YW4gZGV2aWNlIGlkLCBwb3J0IHR5cGUgYW5kDQo+IG51bWJl
ciAqLw0KPiAtCXNucHJpbnRmKG5hbWVmbXQsIHNpemVvZihuYW1lZm10KSwgInd3YW4ldSVzJSVk
Iiwgd3dhbmRldi0NCj4gPmlkLA0KPiAtCQkgd3dhbl9wb3J0X3R5cGVzW3BvcnQtPnR5cGVdLmRl
dnN1Zik7DQo+IC0NCj4gLQkvKiBTZXJpYWxpemUgcG9ydHMgcmVnaXN0cmF0aW9uICovDQo+IC0J
bXV0ZXhfbG9jaygmd3dhbl9yZWdpc3Rlcl9sb2NrKTsNCj4gLQ0KPiAtCV9fd3dhbl9wb3J0X2Rl
dl9hc3NpZ25fbmFtZShwb3J0LCBuYW1lZm10KTsNCj4gLQllcnIgPSBkZXZpY2VfcmVnaXN0ZXIo
JnBvcnQtPmRldik7DQo+IC0NCj4gLQltdXRleF91bmxvY2soJnd3YW5fcmVnaXN0ZXJfbG9jayk7
DQo+IC0NCj4gKwllcnIgPSB3d2FuX3BvcnRfcmVnaXN0ZXJfd3dhbihwb3J0KTsNCj4gIAlpZiAo
ZXJyKQ0KPiAgCQlnb3RvIGVycm9yX3B1dF9kZXZpY2U7DQo+IA0KPiAtCWRldl9pbmZvKCZ3d2Fu
ZGV2LT5kZXYsICJwb3J0ICVzIGF0dGFjaGVkXG4iLCBkZXZfbmFtZSgmcG9ydC0NCj4gPmRldikp
Ow0KPiAgCXJldHVybiBwb3J0Ow0KPiANCj4gIGVycm9yX3B1dF9kZXZpY2U6DQo+IC0tDQo+IDIu
MjUuMQ0KPiANCg0K

