Return-Path: <netdev+bounces-98048-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFE008CEC4F
	for <lists+netdev@lfdr.de>; Sat, 25 May 2024 00:09:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1398D1C211B6
	for <lists+netdev@lfdr.de>; Fri, 24 May 2024 22:09:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D43A584DFD;
	Fri, 24 May 2024 22:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=onsemi.com header.i=@onsemi.com header.b="RmtnYoMd";
	dkim=pass (1024-bit key) header.d=onsemi.onmicrosoft.com header.i=@onsemi.onmicrosoft.com header.b="3i5cKQFH"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00183b01.pphosted.com (mx0a-00183b01.pphosted.com [67.231.149.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BC603C2F;
	Fri, 24 May 2024 22:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.149.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716588577; cv=fail; b=c6ZA1E5X+S9kv05GjExu5kofpwfDBWVWUhR2br9SKdWTKihYt0fb90e7rL8kTmd9YgJjETQPvO49tNfWrwTaSh+P7exFH+6umELjEr3ImOrcvBkHCYihDE06ld9obWRAriROpyTqYW02pORZ+y9J9K9kSPW2twsaDjKQ0fuWEqs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716588577; c=relaxed/simple;
	bh=P3fk5jxu9gSjyvDKhM6ejap+vAOO3xW4JE2pc8vd3Lg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=aVjWW1k/UxuaT//UDR7rSyZd7XMcQx+AyuhV5hu+GN53kovDtkAqZLPX0+dU0w6MaMJYm+CWtRyxUgZ6aI/B6zUXLJ47hIEPpnfcE95qr1xX72ONmI18dL3ZccxKObul3rjvI3PmxDEJTXDoIh52Mzl0w6qmmo6PnSyDf3uWb98=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=onsemi.com; spf=pass smtp.mailfrom=onsemi.com; dkim=pass (2048-bit key) header.d=onsemi.com header.i=@onsemi.com header.b=RmtnYoMd; dkim=pass (1024-bit key) header.d=onsemi.onmicrosoft.com header.i=@onsemi.onmicrosoft.com header.b=3i5cKQFH; arc=fail smtp.client-ip=67.231.149.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=onsemi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=onsemi.com
Received: from pps.filterd (m0059812.ppops.net [127.0.0.1])
	by m0059812.ppops.net (8.18.1.2/8.18.1.2) with ESMTP id 44O7QoJF008482;
	Fri, 24 May 2024 16:08:59 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onsemi.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	pphosted-onsemi; bh=P3fk5jxu9gSjyvDKhM6ejap+vAOO3xW4JE2pc8vd3Lg=; b=
	RmtnYoMdcjYlI/pOyYpI3O8RPCuxoqmap4Y8F37zgPFnNUJC62J1jgOhEWCs/zuj
	USb+4GQBl2YFYFfGo4Fp2qMXhxAu9Rzrot6r9wqfu1CZFwh5zJjR/HqGhoTsrVq+
	anC0xNyNLWZq60e6MrckjhCnS7JXsSw6Sssz/hzG4CG65DNRMNyv5ixmd3ZL0K8/
	itAkWjRrRoXhLGGbmeYeLKcp24TO2RkuQvoBSlgZtizK6jRpnb/eFXKo03SFhlf7
	7mkcaA0hTYLf6b/4opaeOvAhnp5PFXFIsY6fKA4WVx+BvAkjWVYOXJhWJEHxnyDZ
	Dw1egaKzS/485zXqHezb7Q==
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
	by m0059812.ppops.net (PPS) with ESMTPS id 3yaa9su2ab-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 May 2024 16:08:59 -0600 (MDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=meeEQDd9Y77COMuAGSN5PDYq55FBzMDri0HGoSQs/oSJHVQMqAQwadbIOPbuxjifvIKpzkTv9FbJG/HXxZ/CqmWIbJBf61AlQ8DDDe4FVZMwXIjqXA4PdsGetVHLPwJId/0At2lk1Z1lliSB2uhd/SAcUOU/OfVIew5BPlzpza7pWuPXjHhH0FdXreXkm2Jm052H2sTXwN1vVMM9MVrYeOMyv93PUwGslvO5a8/7ON3WD09xVkqM/XvLKzFOVWOLlMWMBOqxlTnlFFT2yXYtdiGv7QGjqveWwq6NMj4eqDYHUNEpRbxSHV0vHRpnMAhU327+nJemnDCos0O2grnPSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P3fk5jxu9gSjyvDKhM6ejap+vAOO3xW4JE2pc8vd3Lg=;
 b=BS3z50QEQo5kJVZVby89lUR0gj20KALhfuQ1b2m77SOGIqo7oRJHV15haUnv8TIQPA2tm3L6LRNC0irzdjK+/erJPMLfblar2E0k6XJBH9nGkd6BqJnMpiDdSQcPxcW73gG6Zrx/L3hHWhhSmjgpEjvQIcSxGWv7PDe/oNs6Ixrovf2khEZ58JZ7On3mbxAvhASuB3D4h7s0eenAs9hHfBpR9HJTLbBo/p1ounMQkYq+N/nfVjhrHx/0mFT2KpCGtvF4IfXHrdon1Fuetm0f6N+Nsv6WCoo4xOR4xvBmBwKstsY6pL5Fwu3znI+dcWmolg3x1m8VLYRjlwIk0GJAWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=onsemi.com; dmarc=pass action=none header.from=onsemi.com;
 dkim=pass header.d=onsemi.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=onsemi.onmicrosoft.com; s=selector2-onsemi-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P3fk5jxu9gSjyvDKhM6ejap+vAOO3xW4JE2pc8vd3Lg=;
 b=3i5cKQFHwLey+HVb1DDjhWxLi26h7PJjHx/D5M412jZ22vlbpgPhgdcDtJ4bfroIa7oKPPCt1NKbGPQD2sJoCUB3mU6AbxVR/GI+cz+d0qTweA8ponQdRKLtGk3wkcosw8qycApQpG+pS3B2Xbx+FHT9YiiQWbvIqPnNCdDcbYo=
Received: from BY5PR02MB6786.namprd02.prod.outlook.com (2603:10b6:a03:210::11)
 by PH0PR02MB7462.namprd02.prod.outlook.com (2603:10b6:510:15::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.21; Fri, 24 May
 2024 22:08:54 +0000
Received: from BY5PR02MB6786.namprd02.prod.outlook.com
 ([fe80::5308:8de6:b03e:3a47]) by BY5PR02MB6786.namprd02.prod.outlook.com
 ([fe80::5308:8de6:b03e:3a47%3]) with mapi id 15.20.7611.025; Fri, 24 May 2024
 22:08:54 +0000
From: Piergiorgio Beruto <Pier.Beruto@onsemi.com>
To: Andrew Lunn <andrew@lunn.ch>
CC: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>,
        "Parthiban.Veerasooran@microchip.com" <Parthiban.Veerasooran@microchip.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com"
	<edumazet@google.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "horms@kernel.org"
	<horms@kernel.org>,
        "saeedm@nvidia.com" <saeedm@nvidia.com>,
        "anthony.l.nguyen@intel.com" <anthony.l.nguyen@intel.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>,
        "Horatiu.Vultur@microchip.com"
	<Horatiu.Vultur@microchip.com>,
        "ruanjinjie@huawei.com"
	<ruanjinjie@huawei.com>,
        "Steen.Hegelund@microchip.com"
	<Steen.Hegelund@microchip.com>,
        "vladimir.oltean@nxp.com"
	<vladimir.oltean@nxp.com>,
        "UNGLinuxDriver@microchip.com"
	<UNGLinuxDriver@microchip.com>,
        "Thorsten.Kummermehr@microchip.com"
	<Thorsten.Kummermehr@microchip.com>,
        "Nicolas.Ferre@microchip.com"
	<Nicolas.Ferre@microchip.com>,
        "benjamin.bigler@bernformulastudent.ch"
	<benjamin.bigler@bernformulastudent.ch>
Subject: RE: [PATCH net-next v4 00/12] Add support for OPEN Alliance
 10BASE-T1x MACPHY Serial Interface
Thread-Topic: [PATCH net-next v4 00/12] Add support for OPEN Alliance
 10BASE-T1x MACPHY Serial Interface
Thread-Index: 
 AQHakZAxosrycArunkaHEujJo3A4abF0voeAgAA2YYCAGHiwAIAAQuMAgAFPWgCAAH78AIAA9q2AgBaf7QCAAAnBAIAAAr5ggAAE7gCAAADH4A==
Date: Fri, 24 May 2024 22:08:54 +0000
Message-ID: 
 <BY5PR02MB6786209192CB9B8A6EF5261F9DF52@BY5PR02MB6786.namprd02.prod.outlook.com>
References: <5f73edc0-1a25-4d03-be21-5b1aa9e933b2@lunn.ch>
 <32160a96-c031-4e5a-bf32-fd5d4dee727e@lunn.ch>
 <2d9f523b-99b7-485d-a20a-80d071226ac9@microchip.com>
 <6ba7e1c8-5f89-4a0e-931f-3c117ccc7558@lunn.ch>
 <8b9f8c10-e6bf-47df-ad83-eaf2590d8625@microchip.com>
 <44cd0dc2-4b37-4e2f-be47-85f4c0e9f69c@lunn.ch>
 <b941aefd-dbc5-48ea-b9f4-30611354384d@microchip.com>
 <BYAPR02MB5958A4D667D13071E023B18F83F52@BYAPR02MB5958.namprd02.prod.outlook.com>
 <6e4c8336-2783-45dd-b907-6b31cf0dae6c@lunn.ch>
 <BY5PR02MB6786619C0A0FCB2BEDC2F90D9DF52@BY5PR02MB6786.namprd02.prod.outlook.com>
 <0581b64a-dd7a-43d7-83f7-657ae93cefe5@lunn.ch>
In-Reply-To: <0581b64a-dd7a-43d7-83f7-657ae93cefe5@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR02MB6786:EE_|PH0PR02MB7462:EE_
x-ms-office365-filtering-correlation-id: 93615ff4-4946-487d-52f3-08dc7c3e1a06
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230031|366007|376005|7416005|1800799015|38070700009;
x-microsoft-antispam-message-info: 
 =?us-ascii?Q?wGBZRqAEi8a95TSx+vVs3A7XNZ6ksERLdmFOGnccdfzdwHL02TUnYRYFuO5c?=
 =?us-ascii?Q?5bNoM2M6XtBy5Ly1mkNK8jMk8XDkU8OHQ/jjOTNZrHSRpvJBf91zCNFph4pH?=
 =?us-ascii?Q?iLA6zN5iZcRxbWqPwqIxby9KIbWDg5autIqlZX6vgDA6gQu3y+6jMc4aEzRB?=
 =?us-ascii?Q?LCdZUPMaezunSY9ObHWath/tw6JhCzt6KEafxb7q84YPDVORXjD0TfNzPUwh?=
 =?us-ascii?Q?gWu9ScEd+qvo3co3ht4bF4rckCr2/gsczDZtjdopFS+8gfCAfxsEKQtD80I6?=
 =?us-ascii?Q?suul1JhFv5AOR0C2LqDwazrrM7/LvI0QrWIJk6B94Qdf1Qs2nt1yp6gaLM2V?=
 =?us-ascii?Q?feG5nRXndFIl+8jvGfxpVzU8ebSg54jBqKBi7IZ3C9abz57BMv8KJues2mf2?=
 =?us-ascii?Q?0SgdXvlqn4+ZqCWwoa5Gsx7zCjcxd7fOUnSXfk1Z/eKQyZbTDEr97GYFzU4t?=
 =?us-ascii?Q?zb6D+hQGdBvebj41aq57INUBpOIbl0p/TdB5l294GeAwTyfwqG4TfCACg2pU?=
 =?us-ascii?Q?5CjwaJNC+Zi6VRXz/8cH2ZE+wyTT5GrIknjfLRhO+PrQYyiG26wLOPB16TjE?=
 =?us-ascii?Q?LQxdKx3eMLShyJdvU7yqUwVfBNdwnctB9+Tl8NT3kiiO5QNACBHTvA1U8lSa?=
 =?us-ascii?Q?r9Rcvm0XqvNI01iAJhjsB5Mx91ZRww6RlZIRqjtkTCSeZSctDJbVqSpmAEMp?=
 =?us-ascii?Q?OWXkbg4Q08lsECg54PrwDcUsVl5FFpVUDzSFXmXk32h7Nj4p3wRZXnSU0gXx?=
 =?us-ascii?Q?gVAzbwBfNrQMd04OM76idQsMS7NxnUYMng5f93dzOIAF40c8SYIpxLaxJSsC?=
 =?us-ascii?Q?Xb6D6RdrxdoGI09+axgXgodI3/lV6vTHW/B8k5tUblobtUyl7mmLK2+MJcgO?=
 =?us-ascii?Q?wrO+SuICqargzGgo/TQ5eP1OVwxsTWieexkxxbgxp1E0i9AHF+WIW/vdhkSs?=
 =?us-ascii?Q?KqUdi8tAfNOdm3HkkdlBELztEL+dRlv+mo8U4RD/N/dVInWqyJnsaCqXWiQz?=
 =?us-ascii?Q?rkQOhbJ/0ns3zxgSOZpkQXFi5OqKF5o9bfoDz2R8UfwXthQetTsF8SVk0bmr?=
 =?us-ascii?Q?ynM5LwCcyhkYwCj3h01t6XHM6qLNxmMKGc8Wk5NN5ZVdz/N6IW2fdNVrA3Ck?=
 =?us-ascii?Q?b6BsB04ZnVvn6g0YBCkBARmcJ+wTlm36wSAh/h17r398gquzWfMQHYPwdIzs?=
 =?us-ascii?Q?fJIraeuUu/kvuR99qZxZ10sHeB9IPCy4m1edUME/Lmj9pwVbIvWr7GiZJSYG?=
 =?us-ascii?Q?tappIH8FqN60RiHDPhYL2YkX4zzQJEcP1tPlWt0fOJxL+7IcHsz/ZplRiL4L?=
 =?us-ascii?Q?rKfmgKOtG9QGUXMO4L8GdoGWMa7wmTaxgdZl6nD6+8W2Gw=3D=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR02MB6786.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(7416005)(1800799015)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?Ma9qE/JNWrJ2BDcqSd2oQM1ZVqQhoWiWwA/5oDv+isQWoML4HCUegSxSwyUH?=
 =?us-ascii?Q?BxN8QlCdH1Tlb5zrEbbGODRonNMVMZ+S+UOFS3fdlxbhQD2z7iV+Xn/sZXUM?=
 =?us-ascii?Q?Qqd5IX8DYoYiQh5F+3yldi+ImtBY9uYSp48Tp4lrtwWG8PKIpg3hrgvsFcYE?=
 =?us-ascii?Q?T2aAPt4K2gWeYmPKXmPnLq1oo10WZFL1pB1ZFdGZwG4Ywvuj/rYMPyusjNXV?=
 =?us-ascii?Q?puBsxKq4+IChtdCZVWBbGVLNsnmbu4R2EuaHFHjppOZXgrzpx0fVoUKGhpqe?=
 =?us-ascii?Q?WmDMW1AjQJ/j/LxmkD9OAmr4QQlvXYNyKkBrKULs0nE0hRVX9lkqmm1SH6fr?=
 =?us-ascii?Q?idGSBnJ5DpZeJWL5QYs0Yr/FI4edc1/OstD9yYBEWOeD3bjmz16b+xdfpG/3?=
 =?us-ascii?Q?z9VFZSeCfghN8Hog06wE9/hX/hfZ4HP7cstVWxwPLmqAQZWuBNVcRmqLfkJA?=
 =?us-ascii?Q?QQ6GsGcXCUGj21HJcNdlF2mXWGlbfRFW+iUfPPz50ZkodFjhqiUH5LzmK/2T?=
 =?us-ascii?Q?CTGBe08RDQDZHp7CFVm2JWoZlIhY7fv6ZY5/ZpLxPmmKp8/jmyLvF/85Gr02?=
 =?us-ascii?Q?Tv2LGuf3t2kLRzcUPUorTn0W0sX8Fw7pkRA2RPT7SqV2dcoVng5q6Mefj+k3?=
 =?us-ascii?Q?CMQz0yg2ry9xfD+xbauyZyIZvsL1a+5k4+vBNKmnSuabi+o2GbtpDo+etwpk?=
 =?us-ascii?Q?1OdM14BgWe6eTOv9uJ9vwehnH7Lexm9pJiHcMlinpNRfMoBOVKxjYYNVs3qf?=
 =?us-ascii?Q?OHYJV3AGb8D6EgnJ0oa9eQf+u74FbB5el3u3Vz+o7LQrklEAfBblySa+85HE?=
 =?us-ascii?Q?m34plFN1zv7P4JBy8hOcqMwh1Wp/AIi/rsYQYn5NqGJMh2KPBMIvbsscAbLl?=
 =?us-ascii?Q?75CE3Lff2Go/v403w3EevYXsAR7SASZs19bFUUMYSdh56VmBhKorOpWVO1/Q?=
 =?us-ascii?Q?bghd/55VkKwwuzkts/EWcO3rYzh9elkSpWIBqvNMaEsMavNO8xHiPpIW1w14?=
 =?us-ascii?Q?SL2PKWJyr9qETgfcPXmQNWvTnaJVM4XWmoF9DD8fKAtkw7IHvpyTCA8d8JCG?=
 =?us-ascii?Q?9A1TuyS7jN6IWjJVan93hRf1Ssm7pz5KMm7QDuq76yHPIukuXHJSJAKDKZz7?=
 =?us-ascii?Q?WtIPJMognO8cqDdeZKn9MjtVdcW1hHQZ+KGp7xzFIfDqTxEEmCo+C0vk5LDe?=
 =?us-ascii?Q?Bqa0RV86snLfF/rCGhVBNstWyHfWfoCoGb+S57v7g1FTYabAhZ2rvXiyu44z?=
 =?us-ascii?Q?E1CVIVfsW2aiFGRGtdh/+GRRI2PuWUxlrXcT5kE8dx00CVdKnLoaEv+ox6XR?=
 =?us-ascii?Q?mSRIkujx1R/yLKK3zGWl50idfXgGItafuVQNd1tGIPifAV0wHo4SXh3dq4LY?=
 =?us-ascii?Q?ATD0UjECzlFMCXTCyUdkJICGWOxZFby9Zm8FAlQ2C7e4loKQbSc2cKvtKZsV?=
 =?us-ascii?Q?OjBg3QfHnNKPirjZaBFWsrX+JJjmH8XYfI/TQlHdp0KLBMMBYfuJebnlPtHQ?=
 =?us-ascii?Q?lZBXUwpdxbHYF6f6QN2wrSwlZ+9Ir9cZsD+sMVl2s03ejocD+P0Pz5YJBS2h?=
 =?us-ascii?Q?1Wk8fugUDD121BNYa3QGK5OA3gOvwwJztCmKp1XY?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: onsemi.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR02MB6786.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93615ff4-4946-487d-52f3-08dc7c3e1a06
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 May 2024 22:08:54.6099
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 04e1674b-7af5-4d13-a082-64fc6e42384c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3Oxkvkf33oPASvMOBhQiUBvc7rDtF9uNXED5HGBr7Zevxk1+t0U+2hwermQZllqW+BOc5bruVJXf11igT0nXsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB7462
X-Proofpoint-GUID: uQpgz9y_c9s85-c90VH6TO1tq6MVH-Ic
X-Proofpoint-ORIG-GUID: uQpgz9y_c9s85-c90VH6TO1tq6MVH-Ic
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-24_08,2024-05-24_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 impostorscore=0
 suspectscore=0 mlxscore=0 phishscore=0 adultscore=0 clxscore=1015
 malwarescore=0 lowpriorityscore=0 bulkscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2405170001
 definitions=main-2405240160

> Having a GPIO driver within the MAC driver is O.K. For hardware diagnosti=
cs you should be using devlink, which many MAC drivers have. So i don't see=
 a need for the PHY driver to access MMS 12.
What I was trying to say is that I actually agree the PHY driver does not n=
eed to access MMS12.
But the MAC driver might need to access MMS-es for vendor specific stuff. I=
n our case, there is a model specific register we need to access during pro=
be.

> But we don't want vendor specific extensions. OS 101, the OS is there to =
make all hardware look the same. And in general, it is not often that vendo=
rs actually come up with anything unique. And if they do, and it is useful,=
 other vendors will copy it. So rather than doing vendor specific extension=
s, you should be thinking about how to export it in a way which is common a=
cross multiple vendors.

Fair enough, let's keep it for "hacks" then. Still, I think there are featu=
res that -initially- are kind of vendor specific, but in the long run they =
turn into standards or de-facto standards.
I assume we want to help this happening (step-wise), don't we?

For example, one big feature I think at some point we should understand how=
 to deal with, is topology discovery for multi-drop.
Maybe you've heard about it already, but in short it is a feature that allo=
ws one PHY to measure the distance (or rather, the propagation delay) to an=
other node on the same multi-drop segment.
Knowing the cable Tpd (~5ns/m), this allows you to get also the physical di=
stance.

It is a cool feature that has been also standardized in OPEN alliance and m=
any vendors are already implemented it.
As for other stuff, we put a lot of effort in convincing the committees to =
standardize the registers too, and fortunately we did it.

The "problem" with topology discovery is that it involves both physical lay=
er functions (to activate the functions that do the actual measurement) but=
 also "upper layer" protocols to communicate with the nodes and carry on th=
e actual measurement.
For this "upper layer" stuff we did not define a standard.

In my view, we should probably create some PHY extensions in the kernel to =
activate the physical layer part, leaving the "protocol" to the userland.
May I ask your opinion?

Thanks,
Piergiorgio

