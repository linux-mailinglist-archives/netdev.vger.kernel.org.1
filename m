Return-Path: <netdev+bounces-124011-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FA6F9675D4
	for <lists+netdev@lfdr.de>; Sun,  1 Sep 2024 11:52:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40BB92822B3
	for <lists+netdev@lfdr.de>; Sun,  1 Sep 2024 09:52:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EF4314B972;
	Sun,  1 Sep 2024 09:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="sjj139JA"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62F3113E02C;
	Sun,  1 Sep 2024 09:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.156.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725184340; cv=fail; b=aEe7+5LB9kEB9FnF78PwIstcfy1tHSqYjmIuv8KcPiU//SV8VhipZwEnCBmkqQnSYRL45Or2kMsn7EtXN81eSWaBuu1WHWr0AJYocbuAsVeZvguJDyyYCbTV/qAeI0Qoh7bQgJ2PaqvEBDMoy6y+q9yRgZLJ1e5cGl+RvOL+3NY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725184340; c=relaxed/simple;
	bh=UvKSOoCE+1NU/LEh6yEFq6FZmTTNhMqhLd2wr3mRIyo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=JePvGUMAOiZRNW+eAKq5THaIwc6Y8pF3XXMjjdXQcg0yZ8ab3Oh9z01Usp9iMcA5sf69L9fxP1OSZYoFz/ZzpqS5tsXsg69LqDDePUuYQEwPjPHN0H5nnFnDbQU05r9af3I1c4B2yXfxMKR9ZrcwF9CuUUwxqxpSqL9xiqKwbHo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=sjj139JA; arc=fail smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4819deW7025954;
	Sun, 1 Sep 2024 02:52:10 -0700
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2175.outbound.protection.outlook.com [104.47.55.175])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 41c2pgt7df-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 01 Sep 2024 02:52:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J6xETy6S9EjFnoV5ScHBcrp4pePlXC+Oe4MO9M8Dji8ZoZmNlnW4SjtuRzW5IBK9NcjrmryciiMWFasFQVUuh36Ofg7s7fSgxnHJd/XVjszqKB6+7PUYZYuM9w7GwGBdPGFok2C9aRSf1+uc43Sc5KEcd+E1RxVioFA9uA9kmRm2daSVWbHoBReHEPpDHQZkYwSUyMzBkQmz5rjECpmA9mAiXcO/r8AeIJTQIlaXkirKqgITwgEVbm53YOZyCua3S+U4hRb5GSUmMZQHLZY5EP3XF/CqX5Z0/jqIdFVr8FcngTtodOd6tiXZIvd/jO949Jq6eJY164Kwt/GexVYIMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UvKSOoCE+1NU/LEh6yEFq6FZmTTNhMqhLd2wr3mRIyo=;
 b=TGQjSw7fpVzATZ7Vm+A6NfRGvlDaDk8Y1tUf2Oh76gYoe4w/oIT8VSfjcT/GhaD2MTVJuCnHxF8pxDOFycIr1OPTJgzxrCG70y8SVgKBXMJXnsttxJjQGQ5C/rmAkNLecElSUGOrkwnKRClo0zAfq7FrppOxA/5VY4NDcqqvY9Z78o0EgG/HShjdRf03Qz2ezINWGxrrXRfi3bdWZr8MLLMKPUSo59FT03DrvcAlnKrx2a1DbHJZw2CIwe9+QFoh8AJXDhMZtChGSb/pJm19Q6o9EdAQG71O7tnV4GMmLPrH+ll7awgsZfvMwDbXEwIx1F2ArovB5co6G5ehhHPkMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UvKSOoCE+1NU/LEh6yEFq6FZmTTNhMqhLd2wr3mRIyo=;
 b=sjj139JAjjVuyTEyFpXyrm+TkomYkhnMDotb1USIowrASlSzuxeupbhcth85RwMWWdh3mgHXXf1CV1FnhG6mzYgB2Z6LXhaPG5hmwap6xUbnmtLTzsnKBEvpao8sl53W6Fr5a2TMPS+riDgHDHdr4xMNsBnfr/SgfottdKf+iUQ=
Received: from CH0PR18MB4339.namprd18.prod.outlook.com (2603:10b6:610:d2::17)
 by PH8PR18MB5265.namprd18.prod.outlook.com (2603:10b6:510:25c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.23; Sun, 1 Sep
 2024 09:52:04 +0000
Received: from CH0PR18MB4339.namprd18.prod.outlook.com
 ([fe80::61a0:b58d:907c:16af]) by CH0PR18MB4339.namprd18.prod.outlook.com
 ([fe80::61a0:b58d:907c:16af%5]) with mapi id 15.20.7918.020; Sun, 1 Sep 2024
 09:52:04 +0000
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
Subject: RE: [EXTERNAL] Re: [net-next PATCH v10 01/11] octeontx2-pf:
 Refactoring RVU driver
Thread-Topic: [EXTERNAL] Re: [net-next PATCH v10 01/11] octeontx2-pf:
 Refactoring RVU driver
Thread-Index: AQHa5z16bLt3siVov02ZB0iTBLEH/bIdhGaAgAxb6aCAAB1RgIAJc4WAgA9lxRA=
Date: Sun, 1 Sep 2024 09:52:04 +0000
Message-ID:
 <CH0PR18MB4339BD8152531267E11509DFCD912@CH0PR18MB4339.namprd18.prod.outlook.com>
References: <20240805131815.7588-1-gakula@marvell.com>
 <20240805131815.7588-2-gakula@marvell.com>
 <ZrTnK78ITIGU-7qj@nanopsycho.orion>
 <CH0PR18MB4339720BC03E2E4E6FAC0251CD812@CH0PR18MB4339.namprd18.prod.outlook.com>
 <Zr9d18M31WsT1mgf@nanopsycho.orion> <ZsdLe-FY3bzzgU9v@nanopsycho.orion>
In-Reply-To: <ZsdLe-FY3bzzgU9v@nanopsycho.orion>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR18MB4339:EE_|PH8PR18MB5265:EE_
x-ms-office365-filtering-correlation-id: 3538c008-43c8-4710-7a61-08dcca6bbbfa
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?a2hGbk8xSG1GVWoyNk80bmcxdjVvaE15bktBVXNUbUdTWFEvYmZGam1SUDlj?=
 =?utf-8?B?Q2h4aUc2bkJnSThLZlI2WXhHWFQ1R2NqeWFHdjVZN1NPNFhwWkxHSmFHeENx?=
 =?utf-8?B?NHhxTytnNEJEVDh3TFNKVjdDVGVKYmlzM2RRY3dmaDFzUFZGRVY4NXR0eGZ0?=
 =?utf-8?B?aG1tMkJTbHFvTXdRSGxJbnNCUEVMZm84dE0va0dQUHcrY1BMTzN5NWJ0dVBk?=
 =?utf-8?B?MTZPc041M2dmT0E0QWs0WnU5K3VrYXo3QklyK0ZVdmxFWDRaa2ZtMVNSWFdE?=
 =?utf-8?B?MGI0MHhCU1d5WjVJQzU3UEZ6SVhxVFRPckx4SlpaYU5DUklNR29wMng4bmt3?=
 =?utf-8?B?YzEzUWxXUFd2OElpUWZxVU9PdmVwWHM3bWFRSklhOEw3SE1xK1AyZ1hpV1Ix?=
 =?utf-8?B?WFRYbExJbVpUQ2pqdGNDdE0vQ0pMY2hOMUF0VXZxVzFsN1BPSnNPNnhXbkQr?=
 =?utf-8?B?ZE1ReG9xK2lOdDhyQmg4c0lWeU51SlEwUm9lWXdweERvWmEzOEV2Y3BmVm5Q?=
 =?utf-8?B?UEZqVjl4MEowdFk4Wk1EMmlVU1hOdExNajJja2d3dCtoWGZwS0VSVWw2cXFv?=
 =?utf-8?B?K0oxd3UweXpnaTAxMDA1REhpMytrUk44YnlBVGdrWlN0eDhFMy92UjNsT05j?=
 =?utf-8?B?ZTVDVUtyR1ljak9EbEhMOXZrMmR1WUtmTXk1QUNLRFhrK0p1Y2dkUk12QnlI?=
 =?utf-8?B?dzUxSWdua1hycmpXWHI3Uzg4d1VIV1l0UW9kMHkrdmF3aFJWcnd6NUtoZ1Zm?=
 =?utf-8?B?MVJ1ODRUYWNBTWxLd2IrRWkvN3VHK3BjSFpqZlFjL2MwK3VrQVVzNWlNY1lC?=
 =?utf-8?B?K0YvVVlHRHRmY1RRR05zUENnQkRGdnJSSUM4ODdpcmVjSlg2MW9ycnlmWWds?=
 =?utf-8?B?aStOejlpT085Ync1WnE0L1hPSlRXeDJNWUszdWNweW5Jd09EL002VDJmSEE3?=
 =?utf-8?B?c20renMveG9PYXNKMmZIMC9HR2xZSW9XWVR0UDZOaktYOHd6MGVDNWYwTjBn?=
 =?utf-8?B?QjA4QUNRdFI1VVJReCtVOS9oVWZYbUE5ZzBLRFRRS01FL0NUQldCMDR2elFh?=
 =?utf-8?B?eDNtemRrYzQxRVU0dHhZcm9hVU1oc21aZzRSU3JhRFQ5R3pmS2dCcitab1Rm?=
 =?utf-8?B?UUlyVHc3aHplQmNDVFUvR3BEK1Yvc3NOak1kZ0ZRRWFneHdGazVOdjZkdjg1?=
 =?utf-8?B?V0pCejc1UmhEc2xMdzlxRVJjZ0xGUEFRZDlEd2hscVJDTmxnWXM3bWpURGVh?=
 =?utf-8?B?SlRWaUVsdFQ5YjRuT3EvWjJqbDlOVEEzMWRkb1NrZVRTQUFaaS80eWNQM2NX?=
 =?utf-8?B?cm4yMEp2aEVNTjlIVlYvQXc2bU0rRVBqQ1hrS0hRbkU5dU52dTJuNTRlcVEr?=
 =?utf-8?B?RElITXdwOVZabXlwMHd5TnZsb1ZMOW1ZVEtDTSsvTGFZbUVzWDNxTC9qdVNt?=
 =?utf-8?B?ZDBscnFlNE9yNVZFbGlrdm1WekNEN3BZWC9tQmVySDZJb0FmRFFJRFhIRmJl?=
 =?utf-8?B?c295UjZJNnN0OE1YYVVwdXd0RUhxVjFYMmZHeGRpOFdEOEJUMU5NY3J4SjE0?=
 =?utf-8?B?bzV5SHMyR1dMZDZZL2lkWWRIaVoxdi9lcVFBMnhIVVl6VklDVkIxdXgvcjRZ?=
 =?utf-8?B?M2NyVE8xZ3VHWEZFWWIyQW1Cbkp4Ulc4bHdHc1doRXdhZEIrRy9qczZqNmU2?=
 =?utf-8?B?bnJxTmRnM3Nab2ZBS2tMcmptelJkQzZmVXFZbW5Nb09pZjNzVU5DVVZJVGdW?=
 =?utf-8?B?TklzcmpBc3NZV3ZWakxYN1M4QWV5U0xQbHVZdThZTDRKYlFuVzRBaUNuZ1hv?=
 =?utf-8?B?ZjVBekVza0M3TDAxTGowc3hFb0NlbGh0ZHBzYzlWN0NWQmxKdThST2ZTcjU3?=
 =?utf-8?B?V0lRelRXQVN5eFBxOVg2K2dVVFA0b0NIR2F1ZWtxZ29ya2c9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR18MB4339.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NUVMd2pwY04wdzJ1NDcvWEdTdTRhMUNNeWpqV3lkODJZTjJ3RXNnK3pjbUhy?=
 =?utf-8?B?cCtwMlVBMkluaENrd2VpU0R5eml6ejQ4VE1Ybk9wWGMreHI1anlSMEhrbWJB?=
 =?utf-8?B?cnV6YWRLOEluQ25ScDcwYk8vRmkySlA4UENOR0tSMERnMUtqZjR1Vy9nbFVT?=
 =?utf-8?B?amFqV1VsWjVxSDJMNExwV1Z0SDFmUDhVNEhpZDN6NGJxTm52UUczcTB1MVNR?=
 =?utf-8?B?MEp0MmJ5TnFISHprVmNtajROOUVYOTJKSmdOaUg1WEtpbWJDQjlpK1Mvbjd3?=
 =?utf-8?B?NHh3MTdDN244MWFnUEs1OXlSUVlpQVNEd1VLVDJQdHYrU2JndG5HancwQ2VL?=
 =?utf-8?B?SC9OMnhYZUhJWmFUWmJza3Brb0xjbXd2d21EaVZSMmhnSlZjcTVobjRjeGVW?=
 =?utf-8?B?WnJ6Vk5pRytkbVR5cWFiRDhVZFVia3JFMVBhb0NvK1FUQ3VsUzRjVWd2M3dU?=
 =?utf-8?B?L3FmYWRiczBZU3lwV2hiMzdaK1dkck5MUHpzSklnWGtUeUhaYU9mYzFrNmRP?=
 =?utf-8?B?UmYvWG5ZdTNqOHg5MkJJc3ltcGFVL2hNaE9GVzNKdnNOUmRucHg5dXpRa1Vu?=
 =?utf-8?B?cEM4QS9ROERzN1UxQVE4WFZmczhxbnRLQzh1QmdYRFgzc3BKa0wyOS9jYmhE?=
 =?utf-8?B?SER0cUJhb0x5U2llK0xJU1k3L2c0MTdiZ3FtTlhvZGQ1bmpqUitLK1o4eUZF?=
 =?utf-8?B?eHdDcTUrYUJKTmxVTUVtRXR2NkJVTnFYRzdlNUJCaUV5Y0hmM3dudnptcXJ6?=
 =?utf-8?B?NzkxRGRWN2NpOEdMUWtGdUE0WTArWTNiTituSkRXSGxXUSswSmw0eENPMEhR?=
 =?utf-8?B?QStDc2hESmdHVzgxTUpMbWMrV3hjbFNNcHFOUFkzNzh3TjBzMytja1VRRWp4?=
 =?utf-8?B?Z2pIbkN6QXkrYkU3Mlo5VURCcW9BY1ZabUxFYjNqV2l3c2ptRkl2dXphb2FI?=
 =?utf-8?B?cU0xTDZKb0VPSGNFTG9ZNnRVaGNiRU16MVVxQVUyQmp3cVZjQXdVUUpqTzRM?=
 =?utf-8?B?OU9aZmgxWDBWN1l4RWdjNVhSeEYyMllHcTlXcDV2SjdFa1FPK0ljemdqSThn?=
 =?utf-8?B?aEZoOXhXRWZPT052OWxPR0lJM0w4OGR6UmZxR1hsWmFnamdveVdIWnlMVU5V?=
 =?utf-8?B?Z05qaytYaW4vNGkxOE9TbHh2d3FZNGNGVUNJZlZLTWY2L2RaenZKOXJRWjRj?=
 =?utf-8?B?UFBMRVVIVm5JbEgwbmlMWXFTbG5qcXljYmphK3RtbzY3MTR2bHk0Z0dTZFNz?=
 =?utf-8?B?ajdEcmVEelRaRGJNN1ZqZUVvN2UzWFlWbFI2ZVJWQ0JSYzdtNVJOaSt3S29O?=
 =?utf-8?B?T2d3U1NoL1p4b29pbVZMaXhwWTlJMXZ3WUhBZzNYMFRSL2doekx6UG52THE5?=
 =?utf-8?B?UWJLdTdQVlg2NVZmUldHQXo2TFRYUkhqNDFVbjExSkc5ck40N1ZhRjBiN01J?=
 =?utf-8?B?UWFtaktOSXNVMnBNeWxqWVZUckhlVW5jMHM4VFJaRnZNbEEzOU5qRmw3aTBX?=
 =?utf-8?B?QSt1YkFvaUtjRUhCckNJVlZXbi8wTXJQdGRiYjBsSFhuVThTU0VYdlNtcTJG?=
 =?utf-8?B?VWhUV1JmTENrbEROUTd3V0tGWkJhL294ZEFFYjVnbmdwRU9lV1ZudS9HYnIy?=
 =?utf-8?B?T2tJZVNYc2owblZxbVRadUY3OVd2OWtCZVE5b2lZSy9YZjRad2ZBNFFLbmRo?=
 =?utf-8?B?bGpVRFpJSlBLdkpqU3N6WFZLV2pLM0xRYVg2ajRnZnZPQk50aW8raUJIaEw1?=
 =?utf-8?B?Y0kxK2d1NTNjQmF5VFpnTXduMWh0RUhieWJKU2ZjZzBrNW9La1dDM0FGR0Vv?=
 =?utf-8?B?cW1WcDFTV2l4T0xqeTREQ2Z5dnJzN2NLYTlhZ1FBcE1TUS9BWGZDRFc0Y3J5?=
 =?utf-8?B?SkFzWmhzNSs0Y3o2d2pzWmxSazdQRHZVUWFzTGlvaDRDeEd1K0tkRGdFN05M?=
 =?utf-8?B?RDNGVGVCbTdQM293bzNKcU5PZXM1bTk2cVlsblNkam1qem9Pa0pKRnhmS0Nm?=
 =?utf-8?B?a1A3T2ptOXM3b01yWmkwTXJPVnc3YWdYS3RubnkrRTh2WnQyVWM4T3hVNGJB?=
 =?utf-8?B?NHJHYWdYOE9zUk0zUXA5VXZXT2FXQ0FTTkFOYnFIdlV4NmxjTDM4Vjk3WjVH?=
 =?utf-8?Q?90wlTxCSW5cLS8Eb2iFfE30GU?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 3538c008-43c8-4710-7a61-08dcca6bbbfa
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Sep 2024 09:52:04.3624
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Tgmknr34PGkDxQYDWppiXYS06hqg0Oo8qvUL0ZDflcQdGspr5vuAh1wtPOgrhv3clFY52HC9RfJECApwJvg6pg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR18MB5265
X-Proofpoint-ORIG-GUID: KvqUH6mk78LohPQsaZuHi01jFKgNfN8V
X-Proofpoint-GUID: KvqUH6mk78LohPQsaZuHi01jFKgNfN8V
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-31_04,2024-08-30_01,2024-05-17_01

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IEppcmkgUGlya28gPGppcmlA
cmVzbnVsbGkudXM+DQo+U2VudDogVGh1cnNkYXksIEF1Z3VzdCAyMiwgMjAyNCA4OjAwIFBNDQo+
VG86IEdlZXRoYXNvd2phbnlhIEFrdWxhIDxnYWt1bGFAbWFydmVsbC5jb20+DQo+Q2M6IG5ldGRl
dkB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGt1YmFAa2Vy
bmVsLm9yZzsNCj5kYXZlbUBkYXZlbWxvZnQubmV0OyBwYWJlbmlAcmVkaGF0LmNvbTsgZWR1bWF6
ZXRAZ29vZ2xlLmNvbTsgU3VuaWwNCj5Lb3Z2dXJpIEdvdXRoYW0gPHNnb3V0aGFtQG1hcnZlbGwu
Y29tPjsgU3ViYmFyYXlhIFN1bmRlZXAgQmhhdHRhDQo+PHNiaGF0dGFAbWFydmVsbC5jb20+OyBI
YXJpcHJhc2FkIEtlbGFtIDxoa2VsYW1AbWFydmVsbC5jb20+DQo+U3ViamVjdDogUmU6IFtFWFRF
Uk5BTF0gUmU6IFtuZXQtbmV4dCBQQVRDSCB2MTAgMDEvMTFdIG9jdGVvbnR4Mi1wZjoNCj5SZWZh
Y3RvcmluZyBSVlUgZHJpdmVyDQo+DQo+RnJpLCBBdWcgMTYsIDIwMjQgYXQgMDQ6MTA6MzFQTSBD
RVNULCBqaXJpQHJlc251bGxpLnVzIHdyb3RlOg0KPj5GcmksIEF1ZyAxNiwgMjAyNCBhdCAwMzoz
Njo0MVBNIENFU1QsIGdha3VsYUBtYXJ2ZWxsLmNvbSB3cm90ZToNCj4+Pg0KPj4+DQo+Pj4+LS0t
LS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4+Pj5Gcm9tOiBKaXJpIFBpcmtvIDxqaXJpQHJlc251
bGxpLnVzPg0KPj4+PlNlbnQ6IFRodXJzZGF5LCBBdWd1c3QgOCwgMjAyNCA5OjEyIFBNDQo+Pj4+
VG86IEdlZXRoYXNvd2phbnlhIEFrdWxhIDxnYWt1bGFAbWFydmVsbC5jb20+DQo+Pj4+Q2M6IG5l
dGRldkB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7DQo+Pj4+
a3ViYUBrZXJuZWwub3JnOyBkYXZlbUBkYXZlbWxvZnQubmV0OyBwYWJlbmlAcmVkaGF0LmNvbTsN
Cj4+Pj5lZHVtYXpldEBnb29nbGUuY29tOyBTdW5pbCBLb3Z2dXJpIEdvdXRoYW0NCj48c2dvdXRo
YW1AbWFydmVsbC5jb20+Ow0KPj4+PlN1YmJhcmF5YSBTdW5kZWVwIEJoYXR0YSA8c2JoYXR0YUBt
YXJ2ZWxsLmNvbT47IEhhcmlwcmFzYWQgS2VsYW0NCj4+Pj48aGtlbGFtQG1hcnZlbGwuY29tPg0K
Pj4+PlN1YmplY3Q6IFtFWFRFUk5BTF0gUmU6IFtuZXQtbmV4dCBQQVRDSCB2MTAgMDEvMTFdIG9j
dGVvbnR4Mi1wZjoNCj4+Pj5SZWZhY3RvcmluZyBSVlUgZHJpdmVyDQo+Pj4+DQo+Pj4+TW9uLCBB
dWcgMDUsIDIwMjQgYXQgMDM6MTg6MDVQTSBDRVNULCBnYWt1bGFAbWFydmVsbC5jb20gd3JvdGU6
DQo+Pj4+PlJlZmFjdG9yaW5nIGFuZCBleHBvcnQgbGlzdCBvZiBzaGFyZWQgZnVuY3Rpb25zIHN1
Y2ggdGhhdCB0aGV5IGNhbg0KPj4+Pj5iZSB1c2VkIGJ5IGJvdGggUlZVIE5JQyBhbmQgcmVwcmVz
ZW50b3IgZHJpdmVyLg0KPj4+Pj4NCj4+Pj4+U2lnbmVkLW9mZi1ieTogR2VldGhhIHNvd2phbnlh
IDxnYWt1bGFAbWFydmVsbC5jb20+DQo+Pj4+PlJldmlld2VkLWJ5OiBTaW1vbiBIb3JtYW4gPGhv
cm1zQGtlcm5lbC5vcmc+DQo+Pj4+Pi0tLQ0KPj4+Pj4gLi4uL2V0aGVybmV0L21hcnZlbGwvb2N0
ZW9udHgyL2FmL2NvbW1vbi5oICAgIHwgICAyICsNCj4+Pj4+IC4uLi9uZXQvZXRoZXJuZXQvbWFy
dmVsbC9vY3Rlb250eDIvYWYvbWJveC5oICB8ICAgMiArDQo+Pj4+PiAuLi4vbmV0L2V0aGVybmV0
L21hcnZlbGwvb2N0ZW9udHgyL2FmL25wYy5oICAgfCAgIDEgKw0KPj4+Pj4gLi4uL25ldC9ldGhl
cm5ldC9tYXJ2ZWxsL29jdGVvbnR4Mi9hZi9ydnUuYyAgIHwgIDExICsNCj4+Pj4+IC4uLi9uZXQv
ZXRoZXJuZXQvbWFydmVsbC9vY3Rlb250eDIvYWYvcnZ1LmggICB8ICAgMSArDQo+Pj4+PiAuLi4v
bWFydmVsbC9vY3Rlb250eDIvYWYvcnZ1X2RlYnVnZnMuYyAgICAgICAgfCAgMjcgLS0NCj4+Pj4+
IC4uLi9ldGhlcm5ldC9tYXJ2ZWxsL29jdGVvbnR4Mi9hZi9ydnVfbml4LmMgICB8ICA0NyArKy0t
DQo+Pj4+PiAuLi4vbWFydmVsbC9vY3Rlb250eDIvYWYvcnZ1X25wY19mcy5jICAgICAgICAgfCAg
IDUgKw0KPj4+Pj4gLi4uL2V0aGVybmV0L21hcnZlbGwvb2N0ZW9udHgyL2FmL3J2dV9yZWcuaCAg
IHwgICA0ICsNCj4+Pj4+IC4uLi9tYXJ2ZWxsL29jdGVvbnR4Mi9hZi9ydnVfc3RydWN0LmggICAg
ICAgICB8ICAyNiArKw0KPj4+Pj4gLi4uL21hcnZlbGwvb2N0ZW9udHgyL2FmL3J2dV9zd2l0Y2gu
YyAgICAgICAgIHwgICAyICstDQo+Pj4+PiAuLi4vbWFydmVsbC9vY3Rlb250eDIvbmljL290eDJf
Y29tbW9uLmMgICAgICAgfCAgIDYgKy0NCj4+Pj4+IC4uLi9tYXJ2ZWxsL29jdGVvbnR4Mi9uaWMv
b3R4Ml9jb21tb24uaCAgICAgICB8ICA0MyArKy0tDQo+Pj4+PiAuLi4vZXRoZXJuZXQvbWFydmVs
bC9vY3Rlb250eDIvbmljL290eDJfcGYuYyAgfCAyNDAgKysrKysrKysrKystLS0tLS0tDQo+Pj4+
PiAuLi4vbWFydmVsbC9vY3Rlb250eDIvbmljL290eDJfdHhyeC5jICAgICAgICAgfCAgMTcgKy0N
Cj4+Pj4+IC4uLi9tYXJ2ZWxsL29jdGVvbnR4Mi9uaWMvb3R4Ml90eHJ4LmggICAgICAgICB8ICAg
MyArLQ0KPj4+Pj4gLi4uL2V0aGVybmV0L21hcnZlbGwvb2N0ZW9udHgyL25pYy9vdHgyX3ZmLmMg
IHwgICA3ICstDQo+Pj4+PiAxNyBmaWxlcyBjaGFuZ2VkLCAyNjYgaW5zZXJ0aW9ucygrKSwgMTc4
IGRlbGV0aW9ucygtKQ0KPj4+Pg0KPj4+PkhvdyBjYW4gYW55b25lIHJldmlldyB0aGlzPw0KPj4+
Pg0KPj4+PklmIHlvdSBuZWVkIHRvIHJlZmFjdG9yIHRoZSBjb2RlIGluIHByZXBhcmF0aW9uIGZv
ciBhIGZlYXR1cmUsIHlvdQ0KPj4+PmNhbiBkbyBpbiBpbiBhIHNlcGFyYXRlIHBhdGNoc2V0IHNl
bnQgYmVmb3JlIHRoZSBmZWF0dXJlIGFwcGVhcnMuDQo+Pj4+VGhpcyBwYXRjaCBzaG91bGQgYmUg
c3BsaXQgaW50byBYIHBhdGNoZXMuIE9uZSBsb2dpY2FsIGNoYW5nZSBwZXIgcGF0Y2guDQo+Pj5J
ZiB0aGVzZSBjaGFuZ2VzIGFyZSBtb3ZlZCBpbnRvIGEgc2VwYXJhdGUgcGF0Y2hzZXQuICBIb3cg
Y2FuIHNvbWVvbmUNCj4+PnVuZGVyc3RhbmQgYW5kIHJldmlldyB0aGVtIHdpdGhvdXQga25vd2lu
ZyB3aGVyZSB0aGV5IGdldCByZXVzZWQuDQo+Pg0KPj5EZXNjcmliZSBpdCB0aGVuLiBObyBwcm9i
bGVtLg0KPg0KPkkgdGhpbmsgeW91IG1pc3VuZGVyc3Rvb2QuDQo+DQo+WW91IHNob3VsZCBkZXNj
cmliZSB0aGUgbW90aXZhdGlvbiBmb3IgdGhlIHJlZmFjdG9yLiBEbyB0aGUgcmVmYWN0b3IgaW4g
YQ0KPnNlcGFyYXRlIHBhdGNoc2V0LCBvbmUgbG9naWNhbCBjaGFuZ2UgcGVyIHBhdGNoLiBJbiB0
aGUgY292ZXIgbGV0dGVyIHRlbGwgd2hhdA0KPnlvdSBkbyBhbmQgd2h5LiBUZWxsIGl0IGlzIGEg
cHJlcGFyYXRpb24gZm9yIGZvbGxvdy11cCBwYXRjaHNldCB0aGF0IGRvZXMgWC4NCj5TaW1wbGUg
YXMgdGhhdC4NCj4NCj4+DQpPayB3aWxsIHNlbmQgdGhlbiBhcyBhIHNlcGFyYXRlIHBhdGNoIHNl
dC4gDQo=

