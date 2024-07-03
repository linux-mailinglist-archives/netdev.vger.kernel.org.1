Return-Path: <netdev+bounces-108775-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F426925625
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 11:09:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B2EA21C24AA5
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 09:09:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6AF213B5B4;
	Wed,  3 Jul 2024 09:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="kOyx8+c2"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50EF113BAE5;
	Wed,  3 Jul 2024 09:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.148.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719997766; cv=fail; b=oLvoClgdaDtjJdJiz1w/OtJFaQd2KZx0ykmQq1fWj5LvIj3DnutAvA8yE5yaJm24R8b4RRW8taFA0UMdB+hVPTN9dPsJaOtSDQdNIpYrD1K4MHXCpFlqRQu/dshNTLmGUTp+dABUDzVRMl/JJDWstYvvXXqY8PydmN+yzE6NgCA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719997766; c=relaxed/simple;
	bh=OPtgH2efZjm2gYSTTWiPrncr2V04Lv/pfgUS1gr/zuo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Q8aVgswi28/PXs10fFLRlnMGggddeI9gfFTtJ2J1Hf8DdbU94ZvQPCnldMgk3Yk6s/u7b7D7Z1/4YmT4SgXn6RmxFsTH4FKi+ExDnwR+hsM2YSsBvhJ6+on6EDUOhlL4SxnIxqKyCGn32sELmJlBcTBAAEPSDgPPHPpQHRdzC4w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=kOyx8+c2; arc=fail smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4638jbeo004390;
	Wed, 3 Jul 2024 02:09:17 -0700
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4053du8315-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Jul 2024 02:09:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A0cBCNB0q6KI13jamDzW5Xp39XCz9ubWmHIeJL2+hjlI03Kd8Ch7wwRZ4ZdqSaIc71b6KAHau7wakcq1YKJq2QKk8MJ2mI6lZscm9WGQ/YMqL/K27Me9vMrK7we/VKnIm7KCMNR7uVaXcQt8ODlwFxJeCLiaZs3mRd1RucPBf6dyPcwCqv4SdQsVBgnlKYNgdGhH05vA2ahfWvB+fqsowemoRwAXNQPW01LFWbO7xNQ79bIuYs2M6O3FEChcFkaTAAz/STtOqixkV1Mjiu4W84xBeCbmG90BdsLveiIxwohV4mpTAOJk0ZkC/Z3SDGSlf29ryAXY1G7Gs4cJXHZV8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OPtgH2efZjm2gYSTTWiPrncr2V04Lv/pfgUS1gr/zuo=;
 b=V/tO1T/cXjiqoQTN6xz564312VmDB7PyEaN5/c2PNTZMMkYynw71F/34xo78HhM5XYw7WHLzQJuT1GVPRYtRSje7sTQwkzAOl68JvW7cMaHpPBlIyg0rnXsWa4DtYUfgUNRvmgeOXkWregfNR2OOS7ML93nrA9UgKv0QbtnSrjEEpCaE0qEDv+CHLRfK2Vfnk2zlMZS/n2nqI2IqJCzcRJ2Avw2397CLQdZXERjqGTUegI0Jhnn2aKSGxxWm1Lz2YNPn4UY9ngVdNWlLHmUBHImMLppgcsFsro6Ak/p7RMkNW5tpCv9pN1TuwMLEFnE0Y9P4mbl5Bf7An2h/9RMBbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OPtgH2efZjm2gYSTTWiPrncr2V04Lv/pfgUS1gr/zuo=;
 b=kOyx8+c2TaUcih03sYpZXsm1JTBA5T6lOAxCHgSpYQBjyFFqfGQMEtxMbCLM34KvqmOcLDrNOw3J0+REvW2elsXzAR2mfMFtiD+ZrIEbQzQ432nqq8pYgtJuwABhpScf0+AuRQSxnUZTWJo3nclGHECWQXIeCMl/eC0jS3zz/j0=
Received: from CH0PR18MB4339.namprd18.prod.outlook.com (2603:10b6:610:d2::17)
 by SJ0PR18MB4106.namprd18.prod.outlook.com (2603:10b6:a03:2ca::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.33; Wed, 3 Jul
 2024 09:08:14 +0000
Received: from CH0PR18MB4339.namprd18.prod.outlook.com
 ([fe80::61a0:b58d:907c:16af]) by CH0PR18MB4339.namprd18.prod.outlook.com
 ([fe80::61a0:b58d:907c:16af%5]) with mapi id 15.20.7719.028; Wed, 3 Jul 2024
 09:08:13 +0000
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
Thread-Index: AQHayWAV6jXo8y46g0ScG9IqbaA7qrHiyOOAgAA3YLCAAHxYgIABPyaA
Date: Wed, 3 Jul 2024 09:08:13 +0000
Message-ID: 
 <CH0PR18MB4339BC156F808A319D1C8461CDDD2@CH0PR18MB4339.namprd18.prod.outlook.com>
References: <20240628133517.8591-1-gakula@marvell.com>
	<20240628133517.8591-7-gakula@marvell.com>
	<20240701201333.317a7129@kernel.org>
	<CH0PR18MB43395FC444126B30525846DDCDDC2@CH0PR18MB4339.namprd18.prod.outlook.com>
 <20240702065647.4b3b59f3@kernel.org>
In-Reply-To: <20240702065647.4b3b59f3@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR18MB4339:EE_|SJ0PR18MB4106:EE_
x-ms-office365-filtering-correlation-id: 80cad3a8-eb73-48f8-7e6b-08dc9b3fab22
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: 
 =?utf-8?B?WDN2TmkrMHMxSzNtN3FQZkVON0hST2pjbGlvcldTVnMrQlNwK2tBZHhjSEdH?=
 =?utf-8?B?RGJ2ODlQbkc5OVY4dndLUW9HK2NXTnpsNWN2RWdMYnR1YlNxYnNHeTZ1dlFF?=
 =?utf-8?B?S0pxT0ZCbllKbDg5YVlhcm9Ta1ZsTU1RbnMyWGZjMStYdGJxbWNLbStGRjdr?=
 =?utf-8?B?M0tnQkxEdDVyc1V0eTBBbVZhUi9CRVZHWEJjaGp6WVJ0WW5JQko5WnFvVkhY?=
 =?utf-8?B?S0J6ZytaYWhGMHpRMkRUeGlBWXFaUFROOW1GMzVLZzBXUHFnTS9EdUJ3bWp6?=
 =?utf-8?B?TGx4R1RQYmk0cVJFY2wzMmRLSjN6bnh2ajBmWGUwbk9hRE5nVEU3NDhWc1h2?=
 =?utf-8?B?djJlNmJDdnNaR2E1M3AwcklOTnpXQ2g5dVQvOHRsUC9TZmgyMmpYT3lTcVhu?=
 =?utf-8?B?QXNjS2ZkWXczQU4wMm1FVUtuazRFZjhacExrWHJtRlpNTDUwR29QREhiSXBI?=
 =?utf-8?B?Tkw0VWJURzR1bEJHSFRkYWswWGhmaWo1UzB4Zm1ldGFtdjdKUkw5Tk84TU5m?=
 =?utf-8?B?WjNNMFpqcHlkUVo2eFVSUis3UEk5NGZzUXlMblJrWEp2cmZNaHRxVW1Ndjc3?=
 =?utf-8?B?Ynp3bysvOEJZeWo3NkVhV0NkSTI0Mkk2SHVUMXM3YWpPckkrZ0VZMUduMWls?=
 =?utf-8?B?MTlEY2docExrb0hlN1Nralh5TUd0c3Q2THMxV0VmMExsenZZbXVpOVBTTUJV?=
 =?utf-8?B?ME4vQjN4bzIxZDU5Z1RRL3B2OTFTa0JOMHhXdWFrSWx1Q0RlcmZoWHo5Zk41?=
 =?utf-8?B?ak9ZanFpbjZmbU5BMTdXcENYMnpoMGhZbDhZY0I0Rzk2aXFTeGZZOEtEWnNr?=
 =?utf-8?B?Vi9ZelhmVFRkQmhHalZYclAyaWtjcFJZV2NPUlpiaWhzWWg4NU5xTE56MTFI?=
 =?utf-8?B?L1E3VDNvLzQ5UFhISENMY2xNVUQxU1FwT1AxYTRDSWZuVkJCMGZ2RktEN21v?=
 =?utf-8?B?WFhZcTk2U1hhUnJOOTVTWlR4M0JCbzl3YXpkallTNWpwS1VxWklteFpHanNE?=
 =?utf-8?B?UDc4c2lrNVZ1c3lOVVpTaUo3ZXJQbDZEQjBPWHR1MVFETzVLbUVPUGhGYmVr?=
 =?utf-8?B?bU9iRjBkNC92eXl1UkxHU3J1cDNsc0FNTCsrUVgyMytDaFRhYzdscXRrNFBN?=
 =?utf-8?B?OXNWMFIxU2JhdGNVS2c1M2Q5ZkRXbmcwdS9DRHlDQU1iUFhwUFlwNFR5blNS?=
 =?utf-8?B?cGhqRk9lRGR1ZXh4V3NCSm5iTDZWYnNuNjFLUk4vYjlRT1E1Zm16K3RiNlBw?=
 =?utf-8?B?eG5PMHRNM1VGajJFRGNwSVJXMFUwT1J0Q2R4c1hJODI3bEpTaDVHOU4wT0Ev?=
 =?utf-8?B?RktSWVFMNVJUTEFQSmdGVlV2Mk8wQ0dvNERZTlFIdnEvOXp5VDliK1JleWRP?=
 =?utf-8?B?U1UxZENDS1RsSWNudjdhZEQvZVYwb3JNT205VGNsazQyc3BFSHl5THVKUkJC?=
 =?utf-8?B?QWRxVXNDU2VJRGs0SWlsb25ja09USEZXcjZla3hVU254eWVYVFJ0UlBTQlcy?=
 =?utf-8?B?UlFSUWRDZWExTUZ6YnV4bmpKMW0zL0ZnV1JqMDJENkNsY29hZm9PV21BQUFG?=
 =?utf-8?B?UmxMSEs0c2RuUDBDQmErRUJ6UlB2ckIyOEliOHRIaStGZjMwVXZDMWtlVVdk?=
 =?utf-8?B?bk1MUFVSdmttRXVFcW1mOXo0b2pqbGpsMzdOemJQOG52b1pqMUQ1U2tyT3BX?=
 =?utf-8?B?dlhYWGNzRHYwejkyWEhRVitSMW5nTjV1SGRJQ25TSnpJMkgrbUV6d3Fsd0pC?=
 =?utf-8?B?eUZUQW9wZGdLV3VyU3FCbkJJelBsK211S0w1RUZ6bzRoTlNZdzAzRmx5c1V4?=
 =?utf-8?B?UjF5WkVVZU83Y0FjMjBiWkIySjdUWGFGVDloTGZYSy91TFZabnNCclc1bUx5?=
 =?utf-8?B?REp5T21ZK3hTUWpML2ZXVVBiRmlrRUNNa3MvQVhEUEc3UWc9PQ==?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR18MB4339.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?VUNCampaUEtmZGJ2a2hkNGZudHF5RTdYYnBRUlRyeXNxaFprY2hybUhKRlRR?=
 =?utf-8?B?ejd2aGh0cUI0WmQzQWtWdW40KzM0bFVRVS9ORk04RXVYWWZnMnA1RG55WHRM?=
 =?utf-8?B?OEIyNzVTSVB0dzAzdkZ6bUd6NVV5cE91ZzRQcjZxWXVXUjNnTmQza0ZVSGRT?=
 =?utf-8?B?RHY0R0FzdlYwZXRqdFNmQlZYV3pVUWN6NlNUS1ZPMStXWllJeWdybUhzOXRK?=
 =?utf-8?B?MG9XRnFLSmVja2g1SkF1TFRHeXl4YURTckxhcEpUd3czV09pYmFrMTJ0SmZW?=
 =?utf-8?B?Rml5UURvVzVMWGlYdWVMSm5YVmRsZzF6U1Fteng0NnpKd0t6bms4REZnYUJV?=
 =?utf-8?B?MlRDb3lqT0VyR0J1SXdmeHAwcGs5MFNrdFVIbTI5Zmg3OTNLWUs0N0t4N1I1?=
 =?utf-8?B?SGI1eWZUOHBHUGNWa1lpakdjOUdEZ08ralg2c2FWTnV4cE9oVk9CV3BjR0hU?=
 =?utf-8?B?eVhCbHlZeGdQOWVPekdkeDRlQitsK2kwM1RPcXA2bHdNcEU4cHp5RlBjZjZF?=
 =?utf-8?B?cEZ3cE1JTkFET3hNcDdyRHhrL3dPbHpDYW5SNE1EaFJCWjFBSk50TnlHRkhO?=
 =?utf-8?B?ZnRFODVrVTl4dVVlb3A2bmlKMVJTTm50T2NlZjVoSnV4dmVPdXg1QTJtQXJ6?=
 =?utf-8?B?QnBwSVp6YmNpN1VPM25LTVl2ejFENm54aXVlRXErYUlwUXNqcjlBeTY2Rm1Q?=
 =?utf-8?B?RDBiSmoyMEY2NmVXZFJzRHd4L0RLSlFzSlNBbTBWUWlZcGdHWDZLd0M5aDBx?=
 =?utf-8?B?TjFuSUk3YU9JSXduU0c0a2hseCtRU0RZc2JNLytPN05LUGd2bnRFSFRRYnp2?=
 =?utf-8?B?RVdVRTdpMUNBa0ZpR2U1N0tCVk41WENjM3JiVEY5bWtpWHBoL2lyczQybU1v?=
 =?utf-8?B?ekN0UkV2U2c4clNhMGl1R3U4enlsQk5uL2w3N0o3bzVQbW1vV0h2dEdodzJZ?=
 =?utf-8?B?eXhRZk4wb3hOQ0x3anB3WUdkdWJvZXQ4S1NhWktWZVBFQW5sbUg5elArS2x1?=
 =?utf-8?B?TlN1eXduYjc1RUdzTlVPcGtCMEhYNzJpUUl5ZWVoNVZUYU5LR2cxTHlaMnRU?=
 =?utf-8?B?TVRnZndxNjdmcG1NN2RwdTNULzAxQ1cvcVpOa3hqMGxYMGlieHlDQnFCSDVT?=
 =?utf-8?B?bTJXYnR1QmFqcDQ1UFNtU0RKdzJseHRsTUEwNzlpY044YU9DTmx2b3czSHpZ?=
 =?utf-8?B?Wk9ER2oxcHhqaFFNQkFDWThZTzM1NFJ0Ujh0TWlvdk1XMjNKbVJXMDN0dHl1?=
 =?utf-8?B?OFByL0ZFUkR2SWxDV1IreG5pSTZYdHhEKzAvY3BFNXpaU3BrVWNmUzlGWWV1?=
 =?utf-8?B?bnFGNjhqaDhWV2xBQWRnVS9GaVVKOTJadUtJekNENkloaW5yM000eWpScE55?=
 =?utf-8?B?eHc2dHBwSmx5d2pwTHRoUWtNZVVLMTZmeGZ0SEJlN2lWa3ljbmpNMEY5UzNF?=
 =?utf-8?B?eXdUOXAya2I0RzNoS1BHVmlSbWNwNzhQSWFTeHRvVzZNNklaL0tlNEhsSUM1?=
 =?utf-8?B?L0dUd2QyVU9rVTlKMHpRVVVST1ZzZm5SNlNzU3hiWi9ReTFtbFdxeWM2SHpr?=
 =?utf-8?B?TWdxT05mVEF1RXUwbDZTMWp5alorTnNHNFF3Y3ZpdU92QWtHTTl2V1pVUWc1?=
 =?utf-8?B?eG5DNGFIbDNpb0RnS1hhZlk1RTFBcjlLaG16dDFoZys5M0JBV0IvcSsxR2Nz?=
 =?utf-8?B?VEg2RXJNcWVmWEd3UUlXVHBMYmdUMkk1S0t0VWVKeWJ1OGg5VWlKZDR6NS9W?=
 =?utf-8?B?b20zN1E1cE5FUUR0WURKSjZxTENiZ0Z0MEI2K2dORzJJOFBySTFpM1A4b3Zw?=
 =?utf-8?B?WTVISU5uV0ZJY1NDakNzWWNnTDlnN0R6a3RWT0tjM3lTOVR5c3J5Z0J6Ylh0?=
 =?utf-8?B?UHdkR3kyTDZkd2gvRGtwVE92QXFiVE9mc1lxdmtQYnEzU3NEdi9MM0VMWmt1?=
 =?utf-8?B?bFNUVzlHdFFVbzFZKzE5c1VsVEg3cmxoNDdKcU91KzRYYlRKcmx1ZTd4MDlz?=
 =?utf-8?B?U1hjWFZDWVVqd0xRb1RBdUpyMjdPTG5pTmdLTFdiQTl6NG91YTRzak9FY21Y?=
 =?utf-8?B?M2xySDltWnB3UUt1VmtTZDk4NjNUU3ZtbHFvcXFmRlNrcjU3Y0QwcXVGeDV4?=
 =?utf-8?Q?iRJo=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 80cad3a8-eb73-48f8-7e6b-08dc9b3fab22
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jul 2024 09:08:13.6099
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: c03B9NKzEifx7Ay+BjSx5qjCGYiuVUBSWMxCVxSzZVqBsDZ7Y6FWBNcKXqCM4AYYcGXXyqG24hkA73mEwwWfkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR18MB4106
X-Proofpoint-ORIG-GUID: CdOOOyT6NrzVTmkk4mg74K-UP9pufiop
X-Proofpoint-GUID: CdOOOyT6NrzVTmkk4mg74K-UP9pufiop
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-03_05,2024-07-02_02,2024-05-17_01

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IEpha3ViIEtpY2luc2tpIDxr
dWJhQGtlcm5lbC5vcmc+DQo+U2VudDogVHVlc2RheSwgSnVseSAyLCAyMDI0IDc6MjcgUE0NCj5U
bzogR2VldGhhc293amFueWEgQWt1bGEgPGdha3VsYUBtYXJ2ZWxsLmNvbT4NCj5DYzogbmV0ZGV2
QHZnZXIua2VybmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsNCj5kYXZlbUBk
YXZlbWxvZnQubmV0OyBwYWJlbmlAcmVkaGF0LmNvbTsgZWR1bWF6ZXRAZ29vZ2xlLmNvbTsgU3Vu
aWwNCj5Lb3Z2dXJpIEdvdXRoYW0gPHNnb3V0aGFtQG1hcnZlbGwuY29tPjsgU3ViYmFyYXlhIFN1
bmRlZXAgQmhhdHRhDQo+PHNiaGF0dGFAbWFydmVsbC5jb20+OyBIYXJpcHJhc2FkIEtlbGFtIDxo
a2VsYW1AbWFydmVsbC5jb20+DQo+U3ViamVjdDogUmU6IFtFWFRFUk5BTF0gUmU6IFtuZXQtbmV4
dCBQQVRDSCB2NyAwNi8xMF0gb2N0ZW9udHgyLXBmOiBHZXQgVkYNCj5zdGF0cyB2aWEgcmVwcmVz
ZW50b3INCj5PbiBUdWUsIDIgSnVsIDIwMjQgMDY6NDE6NTEgKzAwMDAgR2VldGhhc293amFueWEg
QWt1bGEgd3JvdGU6DQo+PiA+PiBBZGRzIHN1cHBvcnQgdG8gZXhwb3J0IFZGIHBvcnQgc3RhdGlz
dGljcyB2aWEgcmVwcmVzZW50b3IgbmV0ZGV2Lg0KPj4gPj4gRGVmaW5lcyBuZXcgbWJveCAiTklY
X0xGX1NUQVRTIiB0byBmZXRjaCBWRiBodyBzdGF0cy4NCj4+ID4NCj4+ID5UaGVzZSBjb3VudCBh
bGwgdHJhZmZpYyBwYXNzaW5nIHRvIHRoZSBWRj8gQm90aCBmcm9tIHRoZSByZXByZXNlbnRvcg0K
Pj4gPmFuZCBkaXJlY3RseSB2aWEgZm9yd2FyZGluZyBydWxlcz8NCj4+IFllcywgaXQgcHJvdmlk
ZSBib3RoIHRoZSBzdGF0cy4NCj4NCj5Db3VsZCB5b3UgaW1wbGVtZW50IElGTEFfT0ZGTE9BRF9Y
U1RBVFNfQ1BVX0hJVCBhcyB3ZWxsLCB0byBpbmRpY2F0ZQ0KPmhvdyBtdWNoIG9mIHRoZSB0cmFm
ZmljIHdhc24ndCBvZmZsb2FkZWQ/DQoNCldpbGwgaW1wbGVtZW50IHdoaWxlIGFkZGluZyBUQyBo
dyBvZmZsb2FkIHN1cHBvcnQgZm9yIHRoZSByZXByZXNlbnRvciwNCndoaWNoIHdpbGwgYmUgc3Vi
bWl0dGVkIGFzIGRpZmZlcmVudCBwYXRjaCBzZXJpZXMuDQo=

