Return-Path: <netdev+bounces-258207-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4My6KYczjGkAjAAAu9opvQ
	(envelope-from <netdev+bounces-258207-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 08:45:11 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CC66121F01
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 08:45:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BCE06301DE29
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 07:45:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A3B7244670;
	Wed, 11 Feb 2026 07:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="oL/fdMhd"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37B2C22B5A5
	for <netdev@vger.kernel.org>; Wed, 11 Feb 2026 07:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.148.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770795909; cv=fail; b=PXKoaBHLiiavLIoQ4qYA7vHgZdqk37jZzFN6TvZRDJjA5DT9nhj2oiXUCfQvs/F2BHB1CXjEXTtOw7Rlk5wUG5vTpt48vhqCpIig2L53yr1Dq6z+pQlADTkz/WTvfVU+82HDFOzirgYmCHoCzLzLDI1d6IykHR5PzhjHYIFZfKg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770795909; c=relaxed/simple;
	bh=yXDZSuzmi1EXcO3vZCyDOzztTp59ZcXNb3WnlA8OKEE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=AWL3S/teOyQLt//xSNRBApn3j6lfCa6mHg65EcaQGmZjfl6imeBXTXX/OM/2TPgsLchbbrxD4tdVGrBVDI9w4xXPm4MnK2/ra8+fALq5ovHPtRWIrEYtu6UmHhrQiF0o2cFEIl2XCiT040yKPjbgA0mK9uwGkhtIn+eLSv6RuPU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=oL/fdMhd; arc=fail smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61B5HE0K3998280;
	Tue, 10 Feb 2026 23:44:57 -0800
Received: from dm1pr04cu001.outbound.protection.outlook.com (mail-centralusazon11020102.outbound.protection.outlook.com [52.101.61.102])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4c7s9cbxja-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 10 Feb 2026 23:44:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sqDGnDqP0is5FW2lL2m6A4uCVfkoiSrTxUug11h1yn/bwDBmErfNMWss8Alg6Zt2g4FdIRymxMC+0X/qxV5AURKnn7XrBXY44A3jyIb2HQzSxWTtq1e/n5x5qRAC199ZirxKuOjFGRbk4u5HcTmojO5xXDAAqg9aDfxDBNfRoQUDVxa7EO5YPgyBdn1GqY7Re7zPl/g+iCLff/lOWgHDg87rv+hB3WgSGFRc/8odGXI2t93hdiVXl5VxHDZL57GhON+gGtXJEMKWwlCttxemmqDmoF6ZIxpeABR7VnnGGk1/iOGJeAGbzaenODyIoJ/wlCm4rvm2L+7areiHCnR5nQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yXDZSuzmi1EXcO3vZCyDOzztTp59ZcXNb3WnlA8OKEE=;
 b=ZVt0x+df8KF10wI59Mpa4MaMc9khsKi9gzT6DF9F4ejIGvbz6JryXSz3V4GBRLYoylDomWt4q2TaqxaCRlL+34+9BG57L3mfjplpPMn8mzxavhPFjzOKGTpQK18ycia3VmNvnZPJ82+yJwQPdO5hYovbngXX0+LZDAQl5vhAXXIDNDfoOVbO/KX7FDfF4Few0gm44rnsDInbcrDhb6xz14BDJZurg/s8mB/pXJdS/pUSWZWrOt9VqHpGMqe2f2wRM+UrEkxmpatuX4++G+HQQN1ZEZ+84OSvCK+I37KpMJhJup7yuldfNOpsD3xtyEC3rxoUMmiT2bBqm7A9cRF1/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yXDZSuzmi1EXcO3vZCyDOzztTp59ZcXNb3WnlA8OKEE=;
 b=oL/fdMhdw/1/MUwDf0e0uzQ7ndVlOu6zp9Br8yK1K+d2jJm45rQocyxLtu1M2Fv5BnbFUMwF00/vV7BQ0qEEhCOuZnmwhW8UsPf/TCcYwdq6aj0iorUwy9dPFgUc8/DvU7DpMeX12x4dwQpxf9h3uCXriVe6tobngfvEeUn6nhM=
Received: from CH3PR18MB6379.namprd18.prod.outlook.com (2603:10b6:610:205::13)
 by DM3PPF465B07FD6.namprd18.prod.outlook.com (2603:10b6:f:fc00::69e) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.10; Wed, 11 Feb
 2026 07:44:54 +0000
Received: from CH3PR18MB6379.namprd18.prod.outlook.com
 ([fe80::a4a5:2144:64cb:7fac]) by CH3PR18MB6379.namprd18.prod.outlook.com
 ([fe80::a4a5:2144:64cb:7fac%4]) with mapi id 15.20.9611.008; Wed, 11 Feb 2026
 07:44:54 +0000
From: Srujana Challa <schalla@marvell.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, Jakub Kicinski <kuba@kernel.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "virtualization@lists.linux.dev" <virtualization@lists.linux.dev>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "jasowang@redhat.com"
	<jasowang@redhat.com>,
        "xuanzhuo@linux.alibaba.com"
	<xuanzhuo@linux.alibaba.com>,
        "eperezma@redhat.com" <eperezma@redhat.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com"
	<edumazet@google.com>,
        Nithin Kumar Dabilpuram <ndabilpuram@marvell.com>,
        Shiva Shankar Kommula <kshankar@marvell.com>
Subject: RE: [EXTERNAL] Re: [PATCH v2 net-next] virtio_net: Improve RSS key
 size validation and use NETDEV_RSS_KEY_LEN
Thread-Topic: [EXTERNAL] Re: [PATCH v2 net-next] virtio_net: Improve RSS key
 size validation and use NETDEV_RSS_KEY_LEN
Thread-Index: AQHcl2Bnnph4NcKMQkKIjFDXE6aND7V2kJwAgABwn4CABiDWAA==
Date: Wed, 11 Feb 2026 07:44:54 +0000
Message-ID:
 <CH3PR18MB6379AC9DFA09E80668BC0BF8A063A@CH3PR18MB6379.namprd18.prod.outlook.com>
References: <20260206120154.2548079-1-schalla@marvell.com>
 <20260206191308.7fdbfef4@kernel.org>
 <20260207045416-mutt-send-email-mst@kernel.org>
In-Reply-To: <20260207045416-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR18MB6379:EE_|DM3PPF465B07FD6:EE_
x-ms-office365-filtering-correlation-id: d18868cf-19c5-4d7d-e4bd-08de69417262
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|7416014|376014|366016|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?VmJDV01HWVpyKzBlbE41a3h2QUpTUEl3bVY2QTZVb3RTcjgyMHI1TWdRRWVo?=
 =?utf-8?B?ZjYya0ZQQmxwb3lKM3V0V1NYVDArNjVuems1OWtQQm9NUnU3VFo1QzNlZUx6?=
 =?utf-8?B?SWIvY0JnTFRIRnVndlFkR2lsWndxNHB4Syt3dzV4cjU1N2hxMXRDTmljdFJu?=
 =?utf-8?B?cmpzbjB0eUtMMjRuTS9jR0hIZ3R0bFR4VjQwYzc2QTNNcklGNWFnNmNLUC9K?=
 =?utf-8?B?d2NWZEk1MXZNLzhkd3lwRC9QTnJEbFBPZngxZzdrOU5HQmw2VW1GVjRBOUll?=
 =?utf-8?B?eG4yeXdOTC9HOUpQMEZBUHRERklRZ3FCVTkyK1Y1TkdHd05adVVPcGppdXkz?=
 =?utf-8?B?emFEaTZ4S0NOL3B0ZUtmdjk2VVp0TUxWRHdNejdHTlB6OXJlVUlibENTZkE5?=
 =?utf-8?B?cU4rRWhVOHFWQU0wVDA3Z3lBOEIyRkFURFNGUFVPajRWYVpzZWM1ei9rb1Zm?=
 =?utf-8?B?dEM2dzhZM095dERFNGF2ZVF3cTl3WUV6dUZzQi9yN2plWnN2cnBCSVVURVJl?=
 =?utf-8?B?bjVPcjVzejlYVWVOZ3Q3MFZsT0lWRGg1c3l2RXBvdkRZaGE4Y1Y5T3VNd25I?=
 =?utf-8?B?SVJ0UU81b2MraGxmVVByYnAzNEsyRUxvdzQ5dDFuWGxRWGlLdFRaVHFkZDBJ?=
 =?utf-8?B?Ym1XZ096VnpEL3hYamE3Rzh3bWJlU3BIU1dWNmI5eHB6S0NDaGNIbWorcjB5?=
 =?utf-8?B?dEhjeFJocTZzSm5Tcmc0cDhvT2w0S2xpZzMzdW9WSklETzRxcTdWZTFPL08v?=
 =?utf-8?B?Q0ZaZFlQNlp6Nys1YkhGZWR6YVc4OSsrNGx1NWxINUxnVUE3SXk3REpYMnBP?=
 =?utf-8?B?TlpTaDMzd2x6bTJTdXlxNlNnQ1phbmFmK0tsOGhpV1JpOW1ndmx2WXBFVWJQ?=
 =?utf-8?B?UWN6TUdtQUxidzhyZVFNQm04UUZGVG9RYWRqUzBQbVBSZWtMUXR2NjFVM1JF?=
 =?utf-8?B?R3Z6U2hueTRpNTVORlpPKzJicForUHJBTXJ3anViMTdXWmphbVBJQ1RtN1VG?=
 =?utf-8?B?eTIwRlQ4UHUraHZDZzJsS3NTMzhienU4eGdUcC9sZFBNd2RwV3dqZUJzeFFn?=
 =?utf-8?B?T053YWVuNy9Dc2RhSk5Ed1o2Nm0waHpRNVNlZFVpbWRKUlZZY1hRZXdNTXVJ?=
 =?utf-8?B?NWh1ZDVzVWlqV0RBWlVQUVJXOEZFNXp2S3p1RStGUWkrK2VQU05iOW9DSzln?=
 =?utf-8?B?QUtWNTgzNW1jblBpRVloRlpVYzBGMTVhd0V3SERQMFAraUg2dk1DTFhrVVEw?=
 =?utf-8?B?dnY2djdYeUtZeGF2VzVxZFFXczVCWU1EQ0FtbFJKWW85OE5HOWx2YW81UGNv?=
 =?utf-8?B?ZDdJaUhoNlJkZzFpUnJaeFNMM2hvNlo1bWx5SlVyNDZ1dlRlMlpEdmIxSTZu?=
 =?utf-8?B?TTF6dnhjQVZ6QXQzdGtqa2dtSEh4elRaR09CTktXR0ZobzNNaHZWNE5Edmxr?=
 =?utf-8?B?bmptMGZBcmJta0QrUXNIN1B3UFlqVFJjQ0UvSmhlbWUwVXhtazh2bmt3Wk81?=
 =?utf-8?B?KzF1QUZXM2xaTE85ZFJ4WFJIdlZJR0ZrclNPRkdmM1RPY3IyZit0T0cwTllx?=
 =?utf-8?B?SjFjZ1ZVL2NYQnVTZkM0bEhFM1cveHROVmw5enMvUjBoY2NuZWk2MGpJZ1VU?=
 =?utf-8?B?S0YrU05kbHgxaDhIdkFGRVhhZzhPV2IybGpIbDVoSlFzaW96YlA2dU5MMmYw?=
 =?utf-8?B?OHRCSTFSQWFMd1NkcmM1VEh6bm1uNWtnZCtpOEVOWVdKNFI4Z1BHaVFjeGVR?=
 =?utf-8?B?d2VOT1hKRWhqVDBJSkJCVWY5YkJCSENEZUhYSkFFMWFjcWFuZnNFVVk2S1cy?=
 =?utf-8?B?czYycXAwR2hwNnlmeVgxeFBnV2NCY0lxMjF5L1Vwa2lNRWVCSFpKT3pFam9T?=
 =?utf-8?B?bGovaWh2SkJ3OThvRFFoOWtDbis1Skxmb2l4U0xOOWEwS1NBSTc2ZE8zUHRE?=
 =?utf-8?B?c3l1bjFXcVVLWXJOaDhHRHN1dzQvQW5nQzRCMTJ6K1JqQkV2UTdsMVA0Mlhi?=
 =?utf-8?B?NlVMNWF1UjVweGNsdkMwSXZOeCtiS2xEbzVGbWhkbmlJWHFkYjlUbXI0cWVs?=
 =?utf-8?B?aW9PWm8vQTMreXV2Z2JUcDFvR0JIelhTaUZrcVFhamFZM285YWNoTGhubnN6?=
 =?utf-8?B?TVFWbjI1WmYxWFEybjA0UzVQdUJFU0Vzdnc4citOR2NlN3JjSmRvOUFucTNO?=
 =?utf-8?Q?ztaoCdXKodwerXrzJyxn3JA=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR18MB6379.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZEpRQ1BBbXRMUkVCb3M3QVI4T3B2L3h6ZS9PN0F2THJrTm8zTWptc3ZGM3l4?=
 =?utf-8?B?SWE1VUxJSkF3VzJTUmtpekorWWgzY2plSHpGeTV4M1hmR1JoOHdtVmVuYlZS?=
 =?utf-8?B?QitmbTgvU2dNUmNqTmRGK3VhQjdETm1UL0QwNzJIQ0s0bGcycVpBKzdhdmZx?=
 =?utf-8?B?aE9uYUk3R3dvY2RpTUJZay9vcDhxbDRqU0hpUW1zdjFqNyt2bkRFdDBnWEpY?=
 =?utf-8?B?U1pZaUQ2RXQ4TllsOW9Eamp4VDdUWGphOExwUDl5ZU9pY3FyVDVlRXE5VHFm?=
 =?utf-8?B?NlpjdktRNEV5em1rSWNxTGZMOHUwUmJSamxGVER0R2Q0aGg1WE93dDNsN044?=
 =?utf-8?B?VTJkendOeWRKaEZ0NlRWdUxMM2ViSTdtQWw0OTVmNEw1aWI3NGE0Z3FZQkM1?=
 =?utf-8?B?TElQREd5M01kS3ljMmM0KzI2VHNTdkZLMkZ1dWxaT3BjYUZuZzltV25zeHhG?=
 =?utf-8?B?V3FadTRxanczMlpaTHdwaW1Pb0xoT0lrTjdJeXJCVkdTZ2I2TUR4SDcyRXlL?=
 =?utf-8?B?NTZlUnJ1SFFHOGVSbDd6M0g5aGpJSXVneUxHRGdoeHc5Vlp5dEZiREs1RHlZ?=
 =?utf-8?B?aEwzZ1ErZFh6VXJ3ZXpucXA4RWZ0TGpwcHRaeVJzMGZRSlZ4MkRwTXlHRHp3?=
 =?utf-8?B?Q2Z3RERBcEhOdzNiL3lPL0R6U0E5THhEOXUyNDZ1aW45NXFCVGUzYTB2T2pH?=
 =?utf-8?B?ZUtLMHFBZ1hsclpQUEFqczV6cFBMTG95RmlaWlE5aWpITnZBeDAzNVpZQW44?=
 =?utf-8?B?c2FUUzJhbFRNVFpDUk5YUy9qRU01Y0ptZHU1bVI5bVplTmhNQUtvQWEyK3dv?=
 =?utf-8?B?eVo1amlzdml6dGpqdWpWbTgveVJyZ1NHU3F2MThuZXJlcmdiSXpob3gwQkwv?=
 =?utf-8?B?R1RSVDFFaXBUWFBYbU9iRThBcm8vLzVTMmducmlwTExKS0ZVUXJyZ1B6K2Ft?=
 =?utf-8?B?WUtOdmJBSlJ1d2NzdStxZ3pyR2gyVTZoQStwYklaSTBZcDJaK0pmYVlqTHJN?=
 =?utf-8?B?a1AzSUU4aWpjUFNLM3ZNYmhuMDVFOHEyMWpLTmNhcFBPZzNvSnhoeHhWRlhF?=
 =?utf-8?B?a1lkbW52ZU45SFFYMDVhRUI2TWZGRDYzSTBXV0dIL0w4T2IwYlQ5RGJrUmJH?=
 =?utf-8?B?Tm43Y012enpOVzR0czE1ZitRSXBkd0pQaE50RUFRUXFYWnRMc3R5cmpvOGQx?=
 =?utf-8?B?bEIwcXRJQkNjQ1pGaW9IdkJ4eVhDWmVTdXdaL0doNFpXZEJCcGhYaCtjaU1w?=
 =?utf-8?B?ZFdvSEc3Y3dDYUxyeUNGbWY5UEdvdjI4S0hXQUs0bFNEU1BDZDlnMC90Z1kv?=
 =?utf-8?B?R0dlTUhzcGdSOElLNDNyVC8yS2Z1U1ZaTXJjdnN2U0ptS3E1dStTRmJJVDdL?=
 =?utf-8?B?dWFEaERsMVRSdWg0cGZXQ1ZPRnZtZGdGWVoxNXZQVEpIRXlDbXJCd3U4ajJp?=
 =?utf-8?B?WGZ2eXc4WFB1dURoQlZSckFlNGViWms1c25NaVdTZmlXRGN2Um1VS2Q0TjRF?=
 =?utf-8?B?UlJrZkxhK2N2UXB3SktBU0tnOXlEcTQ0MWUwNWwyWEtNbVhpd3o0NkFMZ2R2?=
 =?utf-8?B?eUoyU0V1alViR05KcWc0bjFWOUVZN3NyeThYK3o4UXpUL0l4LzZiQjJnYkRU?=
 =?utf-8?B?UC9uRzMvK1cxRlkrbTNtenpYR1ZKN2JwRkFOK2NOeXlnclg2aWxkbWVTWWFx?=
 =?utf-8?B?MnY3S1Z6NGsxSFY2VUdGTkN6ZVhFclZvd0hvWm9TZUN6NjhPMXBQbDNrb2Fr?=
 =?utf-8?B?dkR1bkRHZWVzVkIvMzBZVjdwMm5UcFY5WXZoVGJ5bFB1M3FOVzk2cEk5enNy?=
 =?utf-8?B?Q3FkaUs1djZuY1c3djV0bi9zdUN5b1ExckhNbzJpNVcycWtiUkt2RktHcGl1?=
 =?utf-8?B?Umc2L1p4RjNyNU5RSWZRWWcvSVNrdTQ5czd0RnFSNDJqT0Z6bGc3Y3hpU3Rk?=
 =?utf-8?B?Z2JlaWo3dURkNHhsSUY4ZWpoOGNodGR1bThlMVQ1a3dFTzF0OHdnbFlBZHZy?=
 =?utf-8?B?U0lVOXYvMVV3Z29DNTNRUWtLOTFkUnVLemNXb3YwdC9xUHVWVWhnMVBacEpF?=
 =?utf-8?B?R05IWkxmWUJPNlU0ZjV3czZCSlhEekpwbUFtY0NCazNnSzdHR2k4OWlKTjU0?=
 =?utf-8?B?cmpIMTJZc0NTdVl3SVh2QXFyOTdXa1RmQmZzcHRNd2lPbW04QjdhU0FRTnQz?=
 =?utf-8?B?SDl1UUEzQ2hJdU5FZXZnUzgwTFp5S0FpVC8rNEU3NWhzOCtkM1NtYkxjbS9K?=
 =?utf-8?B?Wno4blhOZjFMT05tdzFSNno1N29KaUZ0K2tXNDVwV2p0Z3hlYVIvdnB5Uk8v?=
 =?utf-8?Q?2hAm1qu5JY8six6kBR?=
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
X-MS-Exchange-CrossTenant-AuthSource: CH3PR18MB6379.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d18868cf-19c5-4d7d-e4bd-08de69417262
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Feb 2026 07:44:54.5786
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AcORYYRziDwhP0aFkxV+A2uNz/7607Jr5x8mNC7CfpiS093jIFu2pXFgtrA0iQcfEzOhD2boy5EnwWUnwiMXZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPF465B07FD6
X-Proofpoint-ORIG-GUID: Uo9AjMny6OF2R5wRdBQbVC5w58UnD6A2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjExMDA2MiBTYWx0ZWRfX6V9CVm6DtEUV
 8dNEFjjl/+HZJ+SnbSDYwsqGr/Qv3+7FvQYjcIMXq9yfmMyU0caqZHUxSVb5xBIE5ZuYlGvTxTM
 O7xOeWBmJw6JGITECUHHZmx5BKjY7lms+Hi7ofi0GEnxAnygnf4K4dWuCVPksCI1qOjCgC3pgK+
 6QukgM2daIBxzVUimHXrW+gfJhXOEPDliFLY1hEAw/BCr/1e5qlgaAdm81ceMrXlLs7djnU9MOL
 Qa7speOg6tzj7zCpGljf06KTDiBJcE29vAKlHE9qVIq/IZ420oHE2VIw2Y+Ehl1ZuD5zPvtr2Lj
 tZis7wbiTaYr6Q8uMFwP5Gh8rqrRI7+jQEqPId2i/ayxK/S9GDIiSOmkuGBh39U3TLhTAixGTBy
 zBnVvVR+crTX/vgEZsk0S/3nNmHEyw==
X-Proofpoint-GUID: Uo9AjMny6OF2R5wRdBQbVC5w58UnD6A2
X-Authority-Analysis: v=2.4 cv=c7WmgB9l c=1 sm=1 tr=0 ts=698c3379 cx=c_pps
 a=M2+OpPQAT0SLGkNgjpGDNg==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=HzLeVaNsDn8A:10 a=-AAbraWEqlQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=x4tZEo8Rq4ZuCZP9qTgA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-10_03,2026-02-10_03,2025-10-01_01
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.94 / 15.00];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[marvell.com,none];
	R_DKIM_ALLOW(-0.20)[marvell.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-258207-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[marvell.com:dkim,CH3PR18MB6379.namprd18.prod.outlook.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[schalla@marvell.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[marvell.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 2CC66121F01
X-Rspamd-Action: no action

PiBPbiBGcmksIEZlYiAwNiwgMjAyNiBhdCAwNzoxMzowOFBNIC0wODAwLCBKYWt1YiBLaWNpbnNr
aSB3cm90ZToNCj4gPiBPbiBGcmksIDYgRmViIDIwMjYgMTc6MzE6NTQgKzA1MzAgU3J1amFuYSBD
aGFsbGEgd3JvdGU6DQo+ID4gPiBSZXBsYWNlIGhhcmRjb2RlZCBSU1MgbWF4IGtleSBzaXplIGxp
bWl0IHdpdGggTkVUREVWX1JTU19LRVlfTEVOIHRvDQo+ID4gPiBhbGlnbiB3aXRoIGtlcm5lbCdz
IHN0YW5kYXJkIFJTUyBrZXkgbGVuZ3RoLiBBZGQgdmFsaWRhdGlvbiBmb3IgUlNTDQo+ID4gPiBr
ZXkgc2l6ZSBhZ2FpbnN0IHNwZWMgbWluaW11bSAoNDAgYnl0ZXMpIGFuZCBkcml2ZXIgbWF4aW11
bS4gV2hlbg0KPiA+ID4gdmFsaWRhdGlvbiBmYWlscywgZ3JhY2VmdWxseSBkaXNhYmxlIFJTUyBm
ZWF0dXJlcyBhbmQgY29udGludWUNCj4gPiA+IGluaXRpYWxpemF0aW9uIHJhdGhlciB0aGFuIGZh
aWxpbmcgY29tcGxldGVseS4NCj4gPg0KPiA+IEhtLCBGV0lXIGNsYW5nIHNheXM6DQo+ID4NCj4g
PiBkcml2ZXJzL25ldC92aXJ0aW9fbmV0LmM6Njg0MTozMTogd2FybmluZzogcmVzdWx0IG9mIGNv
bXBhcmlzb24gb2YgY29uc3RhbnQNCj4gMjU2IHdpdGggZXhwcmVzc2lvbiBvZiB0eXBlICd1OCcg
KGFrYSAndW5zaWduZWQgY2hhcicpIGlzIGFsd2F5cyBmYWxzZSBbLQ0KPiBXdGF1dG9sb2dpY2Fs
LWNvbnN0YW50LW91dC1vZi1yYW5nZS1jb21wYXJlXQ0KPiA+ICA2ODQxIHwgICAgICAgICAgICAg
ICAgIH0gZWxzZSBpZiAodmktPnJzc19rZXlfc2l6ZSA+IFZJUlRJT19ORVRfUlNTX01BWF9LRVlf
U0laRSkNCj4gew0KPiA+ICAgICAgIHwgICAgICAgICAgICAgICAgICAgICAgICAgICAgfn5+fn5+
fn5+fn5+fn5+fiBeIH5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fg0KPiA+DQo+ID4gV2hpY2gg
aXMga2luZGEgYW5ub3lpbmcgYmVjYXVzZSB0aGUgdmFsdWUgd2FzIGluY3JlYXNlZCBpbiBuZXQt
bmV4dC4NCj4gPiBJZiBNYWNoYWVsIHdhbnRzIHRoaXMgYmFja3BvcnRlZCB0aGVuIHdlIG5lZWQg
dG8ga2VlcCB0aGUgY2hlY2sgYW5kDQo+ID4gZm9sbG93IHVwIGluIG5ldC1uZXh0PyBXZSBjb3Vs
ZCB0cnkgdG8gY2FzdCB0aGUgdTMyIGF3YXkgYnV0IHRoYXQNCj4gPiBmZWVscyBkaXJ0eS4uDQo+
IA0KPiANCj4gSSdkIHNheSB5ZXMuIHRoZSB3YXJuaW5nIGlzIGhhcm1sZXNzLg0KPiBzbw0KPiBw
YXRjaCAxIC0gdGhpcyBjb2RlDQo+IHBhdGNoIDIgLSByZXBsYWNlIHdpdGggQlVJTERfQlVHX09O
DQo+IA0KPiBidXQgaSBhc2sgdGhlbiB3aGV0aGVyIHRoaXMgY29kZSB3YXMgYWN0dWFsbHkgdGVz
dGVkIGFnYWluc3QgbmV0LW5leHQuDQpZZXMsIHRlc3RlZCBhZ2FpbnN0IG5ldC1uZXh0IChiZWZv
cmUgTkVUREVWX1JTU19LRVlfTEVOIHdhcyBjaGFuZ2VkIHRvIDI1NikuDQpCVUlMRF9CVUdfT04g
d291bGQgYWx3YXlzIGZhaWwgYXMtaXMgb24gbmV0LW5leHQgc2luY2UgcnNzX2tleV9zaXplIGlz
IHU4Lg0KQ2FuIHdlIGNhc3QgdGhlIGNvbXBhcmlzb24gdG8gdTMyIGluc3RlYWQ/DQpUaGFua3Mh
DQoNCj4gDQo+IC0tDQo+IE1TVA0KDQo=

