Return-Path: <netdev+bounces-124269-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5434F968C15
	for <lists+netdev@lfdr.de>; Mon,  2 Sep 2024 18:37:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 739501C21C02
	for <lists+netdev@lfdr.de>; Mon,  2 Sep 2024 16:37:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2258919F114;
	Mon,  2 Sep 2024 16:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="tBp+x9ug"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0DED38DC0;
	Mon,  2 Sep 2024 16:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.148.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725295072; cv=fail; b=oZG3UoGyKoV9ci3He6EB/slEzdaLtoKDYugxo8YfqByoMfqciVCr0zOPNqv0y0xMhD0s5cBGAWhX5h+bVrG2X8Xvmc3JHFYPdivAa0BfY/+hIg0R2V7WX2FThGNr5DgRxKoNR6r0NTm4H906fDprwB9Xyd3YW7aQnQDp6+MdHRw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725295072; c=relaxed/simple;
	bh=f1LhSqE27FKV91RvWHh1P2p7N3TIbsjO8OizsMbZqgo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=pxARopNpJPs857p14JK6X4yyNh13JLkCN6MigTnZpPxKwXA8FHcIGEeaCWdk4bLC6vnIv13AbZmEsfN2eH2P297Y4uCBG7kATSlVhXjJzx4f7CpHFv8kyGzjknth04YmJ7qxV7WzFTh5VNWs5UQJ98bzE2o/g/4G3J1rUGN1PMU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=tBp+x9ug; arc=fail smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 482Ed6Fv011200;
	Mon, 2 Sep 2024 09:37:36 -0700
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 41dcatrru6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 02 Sep 2024 09:37:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xnJrgC+GRp/5+T+vYH/GTkrI1ifeePIRu88WJRCaFdkBrdKXI/81ZkULJ4OA2DBXzJKioZtaSU7y7026NPMNGBmTG6+iNEWN8oS1kZsuJoHps9Nhkk0Nt+VquzKMdP9F0bgf0s2RK0FF/f5MWsqEoVGop7as4CNPT2+sxeWJWg7r6HmVTa/fieTIcqXGOVpV3bFl555K2U10jhY1kfCp140HVRy5p3+kDjA8lEoANGkhkQBX0ygXkyezILDEmYENLqFip1xik7vBK8JDzf7Q/2/G6Mrv3ufykXDhYsf8jvVJQ8p4l7yL6y6vpJjMux3jdq6EPNMpl3LwriXWqQX2gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f1LhSqE27FKV91RvWHh1P2p7N3TIbsjO8OizsMbZqgo=;
 b=m8bBr7VhbEUX1N/I0r6Bl1JsPZpIbUe8G5ilzi9JfsTsZ09mKFiDM1y+CRfF/gqZ4CEBh7eMK+RkLIClnuCqhmTDX0s6akhD8/zqj9Lf5+NmeE478zZshNF5jXASuYU3QWya75I8XPrFX6L8LDqLqxEbiw0Y7oEjrjuAuSXeClKB7wwGDd7avJ4NI8OE6n5ecrhVn17sX3LDSdb9oiK+kfn1QPYle0/dEKEJEyuyGXz8VEPq0fnM+xdvWMX98biBXmbyY9pbidC1lrMnjO1v+jtTXb8pMaL4SpgVUwmGNG5ilvQxdMh9OkWrgDHmoG3NtjHXklD3svz+FwWWngTKQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f1LhSqE27FKV91RvWHh1P2p7N3TIbsjO8OizsMbZqgo=;
 b=tBp+x9ugGNQioizaO44K92N7NkOfQ6OaYqdz/c+IOdapfoebYIHPpqlFNX6yXOFffgiojiHXDdWE7kel4fElcAm1ycz0kzOfxh3PpJeVOptF3Ujz3weEtEaDhk/pgECCQD89AU+zTLW4c39xFIBUte2goU36x7ao9UmEBzXMaRc=
Received: from CH0PR18MB4339.namprd18.prod.outlook.com (2603:10b6:610:d2::17)
 by SA9PR18MB3776.namprd18.prod.outlook.com (2603:10b6:806:1d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.24; Mon, 2 Sep
 2024 16:37:33 +0000
Received: from CH0PR18MB4339.namprd18.prod.outlook.com
 ([fe80::61a0:b58d:907c:16af]) by CH0PR18MB4339.namprd18.prod.outlook.com
 ([fe80::61a0:b58d:907c:16af%5]) with mapi id 15.20.7918.024; Mon, 2 Sep 2024
 16:37:33 +0000
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
Subject: RE: [EXTERNAL] Re: [net-next PATCH v11 00/11] Introduce RVU
 representors
Thread-Topic: [EXTERNAL] Re: [net-next PATCH v11 00/11] Introduce RVU
 representors
Thread-Index: AQHa9JYYC2Ol1Al2pkyFXUK9ORGsiLIzWbAAgA9m3uCAAa3rAIAAUsoA
Date: Mon, 2 Sep 2024 16:37:32 +0000
Message-ID:
 <CH0PR18MB433993BD0B4FF3B1F98A7628CD922@CH0PR18MB4339.namprd18.prod.outlook.com>
References: <20240822132031.29494-1-gakula@marvell.com>
 <ZsdOMryDpkGLnjuh@nanopsycho.orion>
 <CH0PR18MB433945FE2481BF86CA5309FBCD912@CH0PR18MB4339.namprd18.prod.outlook.com>
 <ZtWiWvjlMfROMErH@nanopsycho.orion>
In-Reply-To: <ZtWiWvjlMfROMErH@nanopsycho.orion>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR18MB4339:EE_|SA9PR18MB3776:EE_
x-ms-office365-filtering-correlation-id: 35e2f06b-23a2-4b58-6305-08dccb6d8b65
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?b3B4dTlIeUhBd3RyUzhGbTNlZ05MOW9iem9MeURYVTJ0RmQ2ckNJR1FvUkRw?=
 =?utf-8?B?NlB0MDNIZDVXcEJzTHBsR3RJK3FDRnA0YlBqYk1pYTg4S2Y4ZEdEWnZoV0dL?=
 =?utf-8?B?Rm5lUFFzTUZkYU9QdG53di9NNXhmNmIzcllic3JlME55aXRObW0ySFBPN2ZF?=
 =?utf-8?B?dHdKSHR2akNUZ2NSTVpuSk52YXVKdElKUGFuUXBjWjNGRUsyalh6WmhFSWxB?=
 =?utf-8?B?cWVzdXo4a3VKVUFUbDFtT3R6NTFMR3BmYkUxK01vSU05b3JKTXpHYTlKUzFM?=
 =?utf-8?B?TEJFWjVmOGRWK1B3NVptMVozSUJ2MjFQYXFYVWd2WFFLTml5ajJKREZjT0dG?=
 =?utf-8?B?elhGRFdzcE54Zy82ZTNITEtGb3ZPVU1uL3QyS0lWaC84MVdRcGYrT0g1NnVE?=
 =?utf-8?B?aFpha0l1TWx6YTZlT2JJaGdjTXQvWlNVQ09vMCtCTmZteUpnenp3cTlSbm1G?=
 =?utf-8?B?Z3BWeDBFNEhlSCsyWWtjb1I5OFREeWdIMHR4Q2VmOFRmSVhDdmVQRDBocWhE?=
 =?utf-8?B?WitVME0zRlhpN2t2ZFVGbmRXWXFrNW1lR1NzeGxTQ2VMa3VYelFLdjltbFF5?=
 =?utf-8?B?K1VBL2RWbXExbDVZWDlmOW5ONTAvejNGNXFZdGIxVi90MWFSUXJoM0xRdkdN?=
 =?utf-8?B?TlRUUGM2SUo4R1Y1Q1VjTEkyVURRMmNNeUgvT0dDUjQ2TkFWZjRCSHA0L3R1?=
 =?utf-8?B?S1YwUVNUYWVVOStVMyt6V1poL0FvQWp3ZzVvZHJUNDdnUEppUm5lK1dQWStT?=
 =?utf-8?B?ajFHTEhQUGozUW04V3BWd2xWZkhjRWhMckVNOGxZaCtQbEpUc2Zvb3J6YVJm?=
 =?utf-8?B?NEJQKzQxcDZRV1krcUQ2dXdnTm1yM0NsUjBlRHR2RlA1eFpHZkY3S3FGeVZB?=
 =?utf-8?B?VFp4c2VpMnllZStqeXp4SE9jRmdTRk5DQkRVS0NiRW5aUnk2VGI3cjBtZVVm?=
 =?utf-8?B?bTNjWlRpODg2V2hBNjdTb21RRWpHTTc0b1FISFFmN0MyZGJWQ3ZuU3FmaXIw?=
 =?utf-8?B?bVY3c3VTRlRaUDlCQTU4dDlUUy9YVGdEZ1NJN0twR2ZOeXRNTWJYcU9TYS84?=
 =?utf-8?B?d0ZTbTE2Tm9rOVdwUzVyUHlEZnhXU1c2bnFLdkQvWXBOakhOcVMxQzdidnN0?=
 =?utf-8?B?bmU2WGNic0F1U3RKNFNPdThOcEFZcTNKV3pWdEJrcFpQUys0N0wydUI3TmdD?=
 =?utf-8?B?QktoR291TWJEMXNWZHJ4dHZPZVRubytkb0tsOVhnQ25aZmRoNm5QRlRlbFl3?=
 =?utf-8?B?L2Y5eGZ1RDY2SHdpakVmUVdLT0RuNVJ4em5lVDF2cTMrQkJQUGRtOFpmQ0Z3?=
 =?utf-8?B?L09KY3J0bkVPS05uejRzRXJhVzhyanpOQXp0TVR2Wkx2b3hBTVgrWGVpaTkz?=
 =?utf-8?B?OUVyNzhTZmc4VXBSb2g1cEF2b0lqTEdKVGNiRzFQVTh6WEpoVHVSY1IrRVRU?=
 =?utf-8?B?SThROHR0OVNrdUZpZGxZTTc0clNtL09jcDdYNzZLd05nQXoyZFlaWXlaMEhH?=
 =?utf-8?B?dzZVWm1LeDNmMjM4ZS85anpSeVA4K2FxekE5aDgwMTQ3QVFHTVVFdkE2NjZq?=
 =?utf-8?B?NUl5R1J1VkdLTXVWSlJoRmhDaXRtK3hJdWE5bjNzRzFLQWhSekRzY1Q1eGlD?=
 =?utf-8?B?YVByR0NCTG9SeTRhN3VmNmZqQVAwRVhuL3lCYllMNnRDZUJTbng5N013RzE4?=
 =?utf-8?B?VnNlU3ROQ3ltdEthYk5UQTA0cm5zSnhTZEFLbFR5LzBPK3pNTGlWU3F6THl2?=
 =?utf-8?B?dTFyZ1RHNnh5cVA1anBSK0pyNUJKa21QS1lOaWljQjlGSHNxbk5aRkQ2eGx2?=
 =?utf-8?B?Y2hUbjgzeGJxa09jN0lXdlJaN09uaSsxd2wxUTRMa0JkS3R4UnlvMHk0VXdU?=
 =?utf-8?B?d0ZXUW9QSWNKK21sZ01yaE9INDBwR1RCWmE2c2RJZE0yNEE9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR18MB4339.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dVB6R0xoeWxNb1dnaEVwbHl6N0RSMWhkTlBJVjBSQ1lsQWo1dm1HVVJNRXhi?=
 =?utf-8?B?eWRSdXlCMlhMN0pYRzVUYWlXSUpMRTAwZ3hRRVdFTjFLbUtMbHkzWFg2c014?=
 =?utf-8?B?b0hMM3NLRW52WnRyaEtPOXFUa3ltUzB6MHEzSzdFS29MYjc1YkRyeDVsaWVv?=
 =?utf-8?B?ZVA1YXhTZWduMHpQWThZdGVJM1BiMmNMVmRIRDVpbDkzbGNDTmRHeXZNVUtk?=
 =?utf-8?B?NUZQNXBrVlVoVUZlek5iUUh2Z1BLNkRwa3RaL3F4cEczaGtvWWtWeFJHWi9n?=
 =?utf-8?B?ZHNwckE3c2J5Zk5mV1cxK0RPbGJyRDZBQk1QVytZbHVlUnBQaWdYdXVjWVoz?=
 =?utf-8?B?UmQwdDNyUEUxeHJRQnFxVWdrMDZURUQ4WDd1VUg3d3BzSlFiZXhWM3VYOTg5?=
 =?utf-8?B?TC9QK2phdHBpOHJRKytFZDQ4aXR4Y21lV1ZNTnJZNFJCdjhCZU9GejFaZEh3?=
 =?utf-8?B?OE5sa2RxUVMzbzJFSmhDaG9pR3NORVI2N0ZSNE5lblpRWGk2V3lmUzFyNlVy?=
 =?utf-8?B?ZnpKQmhBY09FMkJtVjFEVXNlSWRNVDJLeXZnR2prUXRHUUJjcDdTakNzU1or?=
 =?utf-8?B?cEdTd01oUmpCN0Q5Q3BTUHc2K2pyVUQ3S29aQndQSGQ3RFBYN3hPOERLbElH?=
 =?utf-8?B?VEJWUHVlazkwVk0vUkdMYVF5aDVEY2JZMGN0QnMxV0Q1WXM5cDZSeHdrdjhV?=
 =?utf-8?B?Zkg0aWdPYTV1bWgwMmJQTUFGL1FVaVg3Z3ZBY2xIZHBGWExoN1pvQkVFVlN4?=
 =?utf-8?B?QVZORFd5andMMXBGd2dzc0FHSnZDMlcrQmJFS0FzdGdFMGFOUU9aTlRZUkFO?=
 =?utf-8?B?NlBnOEdWclI2WGVuajZ6Rm9BSnQwa3FaRGk5RHF0QThOZHVxb3UvRU5MSXMz?=
 =?utf-8?B?TGJjN0FNMEV0RzRXbWRBTjViMzlIZEd5M2J3YWhpc25PNU95TkNZZS9yc0lp?=
 =?utf-8?B?VEdwc0trR2hHelVDMUR3NzRHcm1rWTY1SFVkN05yb0Q4alVwc3Z1SFVRUGM0?=
 =?utf-8?B?Nmo1VXFhSHhXT1RabGgxT0F4ZU9UY1lhRTRoZ0YyQ3YyYUtRNEJIK1ZsOFZ6?=
 =?utf-8?B?UnlITnN2dGdyUnVaejVFUzNnTi9FUkV2YyswUkFtT2Z5ZG1yMWRxK0lnTjRo?=
 =?utf-8?B?RDc1SGNENVFuSUFhN0RFcEFvV2g5TkxxS3BhMWlydFJYSzYySzljYUd6bDZl?=
 =?utf-8?B?U3FIMi9jbmcrSUZQZGRCbGhBZktLbm9oYVFBeExoNm1tS09lZ09jMWd4L1RB?=
 =?utf-8?B?Z2NJemdpWFlLZDI5NjVNSzhXTXhvc3lTdHZrNmpSSGJrYUhYK2NpWCtsSTMr?=
 =?utf-8?B?NVpMb1pVS0ljc0NmRTM1R1F1UXF5aHI3bHVrczYvdmtUUVliNkpHaW9YZ1F6?=
 =?utf-8?B?MXl5Z2toN0FlNzJPYTd6Rkp2Vk9XWGdWSjJEZTNkZ3ozWnlib2x0OTNxc2dC?=
 =?utf-8?B?UmQ3a2tTbFZXSXptWFVYS2E5VDdvaGE1QmtrWXg3MmIreGd4TzVVTy9lamZ1?=
 =?utf-8?B?TU0yRVpOV2tHNkp2UzRGdTA2eDJxcFpwRTM1TFNFM282KzFpbVFsQnVKcnM5?=
 =?utf-8?B?WlJkWXNmaVJUWm1nUTVtdGltM2dLam44eWRzVmUvZk52UXpLL3JkRkxQY1FS?=
 =?utf-8?B?Q09iOVdqQ2pBc1F4SXhISjFSeGNNVkMrUmdLRXpDVGRRK2I3L2NGYnI1U0h5?=
 =?utf-8?B?bUdQV0trUi9HOGNaT2Vla255L08wME1GYVowWlJLa1FaNlN1aFBIUTJXZ2s0?=
 =?utf-8?B?TGNLNk9oemZ2VVJhb0l0RGw1RE85bUZxdjJjK3R1Unc3TFRkVTNEb0t5a0JE?=
 =?utf-8?B?UHdiRkZzdm9VVmswNFY2b0VTczd5anVaM3VURWY3Vy9wVTQ3YzNiQU03TVNK?=
 =?utf-8?B?TWdBTjJXL0t6ejRyaS96NGRHZkdwbTJCYmZUSFJFdFc5bU85cEVVZ1JqUGdj?=
 =?utf-8?B?ZUxiQjBBWnIyTFFEbEo4N2hYMGRCamVLQTlFQmtqR0lzVUMwUDgyUFRoK0VU?=
 =?utf-8?B?Ym1sZGZJL2VNTVpKMStQSTh5b3RRbGV5NURXbkJnaDQxSDFiZytLVEJNc0N4?=
 =?utf-8?B?QmtFL2tPLzRpbjFvZ3BLNTZ2Q1dDc3piZTNjeEJBcmlzNmF1ZmMzK3dKNkR2?=
 =?utf-8?Q?PAQw=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 35e2f06b-23a2-4b58-6305-08dccb6d8b65
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2024 16:37:33.0286
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wustbNdvREqsXx2XWFZgF4tHUXGy0J7g7bdhaxTC9SGNFua9/IrTIinVcCsymHto9D48M1BTYebjuCTstNR1Cg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA9PR18MB3776
X-Proofpoint-ORIG-GUID: XNg6b_4pTNCvXBRwKMSN2T2ebyJcOo9g
X-Proofpoint-GUID: XNg6b_4pTNCvXBRwKMSN2T2ebyJcOo9g
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-02_04,2024-09-02_01,2024-09-02_01

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IEppcmkgUGlya28gPGppcmlA
cmVzbnVsbGkudXM+DQo+U2VudDogTW9uZGF5LCBTZXB0ZW1iZXIgMiwgMjAyNCA1OjAzIFBNDQo+
VG86IEdlZXRoYXNvd2phbnlhIEFrdWxhIDxnYWt1bGFAbWFydmVsbC5jb20+DQo+Q2M6IG5ldGRl
dkB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGt1YmFAa2Vy
bmVsLm9yZzsNCj5kYXZlbUBkYXZlbWxvZnQubmV0OyBwYWJlbmlAcmVkaGF0LmNvbTsgZWR1bWF6
ZXRAZ29vZ2xlLmNvbTsgU3VuaWwNCj5Lb3Z2dXJpIEdvdXRoYW0gPHNnb3V0aGFtQG1hcnZlbGwu
Y29tPjsgU3ViYmFyYXlhIFN1bmRlZXAgQmhhdHRhDQo+PHNiaGF0dGFAbWFydmVsbC5jb20+OyBI
YXJpcHJhc2FkIEtlbGFtIDxoa2VsYW1AbWFydmVsbC5jb20+DQo+U3ViamVjdDogUmU6IFtFWFRF
Uk5BTF0gUmU6IFtuZXQtbmV4dCBQQVRDSCB2MTEgMDAvMTFdIEludHJvZHVjZSBSVlUNCj5yZXBy
ZXNlbnRvcnMNCj4NCj5TdW4sIFNlcCAwMSwgMjAyNCBhdCAxMjrigIowMTrigIowMlBNIENFU1Qs
IGdha3VsYUDigIptYXJ2ZWxsLuKAimNvbSB3cm90ZTogPiA+ID4+LS0tLS0NCj5PcmlnaW5hbCBN
ZXNzYWdlLS0tLS0gPj5Gcm9tOiBKaXJpIFBpcmtvIDxqaXJpQOKAinJlc251bGxpLuKAinVzPiA+
PlNlbnQ6IFRodXJzZGF5LA0KPkF1Z3VzdCAyMiwgMjAyNCA4OuKAijEyIFBNID4+VG86IEdlZXRo
YXNvd2phbnlhIEFrdWxhDQo+PGdha3VsYUDigIptYXJ2ZWxsLuKAimNvbQ0KPlN1biwgU2VwIDAx
LCAyMDI0IGF0IDEyOjAxOjAyUE0gQ0VTVCwgZ2FrdWxhQG1hcnZlbGwuY29tIHdyb3RlOg0KPj4N
Cj4+DQo+Pj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPj4+RnJvbTogSmlyaSBQaXJrbyA8
amlyaUByZXNudWxsaS51cz4NCj4+PlNlbnQ6IFRodXJzZGF5LCBBdWd1c3QgMjIsIDIwMjQgODox
MiBQTQ0KPj4+VG86IEdlZXRoYXNvd2phbnlhIEFrdWxhIDxnYWt1bGFAbWFydmVsbC5jb20+DQo+
Pj5DYzogbmV0ZGV2QHZnZXIua2VybmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9y
ZzsNCj4+Pmt1YmFAa2VybmVsLm9yZzsgZGF2ZW1AZGF2ZW1sb2Z0Lm5ldDsgcGFiZW5pQHJlZGhh
dC5jb207DQo+Pj5lZHVtYXpldEBnb29nbGUuY29tOyBTdW5pbCBLb3Z2dXJpIEdvdXRoYW0gPHNn
b3V0aGFtQG1hcnZlbGwuY29tPjsNCj4+PlN1YmJhcmF5YSBTdW5kZWVwIEJoYXR0YSA8c2JoYXR0
YUBtYXJ2ZWxsLmNvbT47IEhhcmlwcmFzYWQgS2VsYW0NCj4+Pjxoa2VsYW1AbWFydmVsbC5jb20+
DQo+Pj5TdWJqZWN0OiBbRVhURVJOQUxdIFJlOiBbbmV0LW5leHQgUEFUQ0ggdjExIDAwLzExXSBJ
bnRyb2R1Y2UgUlZVDQo+Pj5yZXByZXNlbnRvcnMNCj4+Pg0KPj4+VGh1LCBBdWcgMjIsIDIwMjQg
YXQgMDM6MjA6MjBQTSBDRVNULCBnYWt1bGFAbWFydmVsbC5jb20gd3JvdGU6DQo+Pj4+VGhpcyBz
ZXJpZXMgYWRkcyByZXByZXNlbnRvciBzdXBwb3J0IGZvciBlYWNoIHJ2dSBkZXZpY2VzLg0KPj4+
PldoZW4gc3dpdGNoZGV2IG1vZGUgaXMgZW5hYmxlZCwgcmVwcmVzZW50b3IgbmV0ZGV2IGlzIHJl
Z2lzdGVyZWQgZm9yDQo+Pj4+ZWFjaCBydnUgZGV2aWNlLiBJbiBpbXBsZW1lbnRhdGlvbiBvZiBy
ZXByZXNlbnRvciBtb2RlbCwgb25lIE5JWCBIVw0KPj4+PkxGIHdpdGggbXVsdGlwbGUgU1EgYW5k
IFJRIGlzIHJlc2VydmVkLCB3aGVyZSBlYWNoIFJRIGFuZCBTUSBvZiB0aGUNCj4+Pj5MRiBhcmUg
bWFwcGVkIHRvIGEgcmVwcmVzZW50b3IuIEEgbG9vcGJhY2sgY2hhbm5lbCBpcyByZXNlcnZlZCB0
bw0KPj4+PnN1cHBvcnQgcGFja2V0IHBhdGggYmV0d2VlbiByZXByZXNlbnRvcnMgYW5kIFZGcy4N
Cj4+Pj5DTjEwSyBzaWxpY29uIHN1cHBvcnRzIDIgdHlwZXMgb2YgTUFDcywgUlBNIGFuZCBTRFAu
IFRoaXMgcGF0Y2ggc2V0DQo+Pj4+YWRkcyByZXByZXNlbnRvciBzdXBwb3J0IGZvciBib3RoIFJQ
TSBhbmQgU0RQIE1BQyBpbnRlcmZhY2VzLg0KPj4+Pg0KPj4+Pi0gUGF0Y2ggMTogUmVmYWN0b3Jz
IGFuZCBleHBvcnRzIHRoZSBzaGFyZWQgc2VydmljZSBmdW5jdGlvbnMuDQo+Pj4+LSBQYXRjaCAy
OiBJbXBsZW1lbnRzIGJhc2ljIHJlcHJlc2VudG9yIGRyaXZlci4NCj4+Pj4tIFBhdGNoIDM6IEFk
ZCBkZXZsaW5rIHN1cHBvcnQgdG8gY3JlYXRlIHJlcHJlc2VudG9yIG5ldGRldnMgdGhhdA0KPj4+
PiAgY2FuIGJlIHVzZWQgdG8gbWFuYWdlIFZGcy4NCj4+Pj4tIFBhdGNoIDQ6IEltcGxlbWVudHMg
YmFzZWMgbmV0ZGV2X25kb19vcHMuDQo+Pj4+LSBQYXRjaCA1OiBJbnN0YWxscyB0Y2FtIHJ1bGVz
IHRvIHJvdXRlIHBhY2tldHMgYmV0d2VlbiByZXByZXNlbnRvciBhbmQNCj4+Pj4JICAgVkZzLg0K
Pj4+Pi0gUGF0Y2ggNjogRW5hYmxlcyBmZXRjaGluZyBWRiBzdGF0cyB2aWEgcmVwcmVzZW50b3Ig
aW50ZXJmYWNlDQo+Pj4+LSBQYXRjaCA3OiBBZGRzIHN1cHBvcnQgdG8gc3luYyBsaW5rIHN0YXRl
IGJldHdlZW4gcmVwcmVzZW50b3JzIGFuZCBWRnMgLg0KPj4+Pi0gUGF0Y2ggODogRW5hYmxlcyBj
b25maWd1cmluZyBWRiBNVFUgdmlhIHJlcHJlc2VudG9yIG5ldGRldnMuDQo+Pj4+LSBQYXRjaCA5
OiBBZGQgcmVwcmVzZW50b3JzIGZvciBzZHAgTUFDLg0KPj4+Pi0gUGF0Y2ggMTA6IEFkZCBkZXZs
aW5rIHBvcnQgc3VwcG9ydC4NCj4+Pg0KPj4+V2hhdCBpcyB0aGUgZmFzdHBhdGg/IFdoZXJlIGRv
IHlvdSBvZmZsb2FkIGFueSBjb25maWd1cmF0aW9uIHRoYXQNCj4+PmFjdHVhbGx5IGVuc3VyZXMg
VkY8LT5waHlzaWNhbF9wb3J0IGFuZCBWRjwtPlZGIHRyYWZmaWM/IFRoZXJlIHNob3VsZA0KPj4+
YmUgc29tZSBicmlkZ2UvdGMvcm91dGUgb2ZmbG9hZC4NCj4+UGFja2V0IGJldHdlZW4gIFZGcyBh
bmQgVkYgLT4gcGh5c2ljYWwgcG9ydHMgYXJlIGRvbmUgYmFzZWQgb24gdGNhbSBydWxlcw0KPmlu
c3RhbGxlZCBieSAgVEMgb25seS4NCj4NCj5XaGVyZSBpcyB0aGUgY29kZSBpbXBsZW1lbnRpbmcg
dGhhdD8NCldlIHBsYW5uZWQgdG8gc3VibWl0IGJhc2ljIFJWVSByZXByZXNlbnRvciBkcml2ZXIg
Zmlyc3QgZm9sbG93ZWQgYnkgDQpUQyBIVyBvZmZsb2FkIHN1cHBvcnQgZm9yIHRoZSByZXByZXNl
bnRvcnMuDQo+DQo+DQo+Pj4NCj4+Pk9yLCB3aGF0IEkgZmVhciwgZG8geW91IHVzZSBzb21lIGlt
cGxpY2l0IG1hYy1iYXNlZCBzdGVlcmluZz8gSWYgeWVzLA0KPj4+eW91DQo+Pk5vLCB3ZSBkb27i
gJl0IGRvIGFueSBtYWMgYmFzZWQgdHJhZmZpYyBzdGVlcnJpbmcuDQo+Pg0KPj4+c2hvdWxkIG5v
dC4gSW4gc3dpdGNoZGV2IG1vZGUsIGlmIHVzZXIgZG9lcyBub3QgY29uZmlndXJlIHJlcHJlc2Vu
dG9ycw0KPj4+dG8gZm9yd2FyZCBwYWNrZXRzLCB0aGVyZSBpcyBubyBwYWNrZXQgZm9yd2FyZGlu
Zy4NCj4+DQo+Pg0K

