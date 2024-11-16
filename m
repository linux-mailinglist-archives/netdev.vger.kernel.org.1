Return-Path: <netdev+bounces-145587-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A1C99D0010
	for <lists+netdev@lfdr.de>; Sat, 16 Nov 2024 18:26:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E15931F2307F
	for <lists+netdev@lfdr.de>; Sat, 16 Nov 2024 17:26:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B08BD18CC10;
	Sat, 16 Nov 2024 17:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="ThY3aZXr"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B8CF8172A;
	Sat, 16 Nov 2024 17:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.156.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731777963; cv=fail; b=QT02NyQcATVfHdbxP+xLA1xPGuxWzUZ4jZp9K0jsHk25cFHKik2EaZaNzVubBHHpAFJuGnYfSQ4NDAlRUeNq8UTFUAQU0cvXUrYDBJCiRZ3iSeCToPP724Gjg658sqr+UldWtyd6IFZ+JvEEf1H/FWJuUdXc8x2MM5v86KgvU84=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731777963; c=relaxed/simple;
	bh=ozPNsGsxtI1LDiwk1e2rt4Z4Xyd03mGX4VIrWrhWScg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=C0rIzuJ7I250dQCk9NYYKn+FbGso1mEdkd8gm6DZs/P6T2XXZSDubNO808uLYbeGeyy/v68anw/vYgSrBt4RNK3WJJxxYw1HuUXNcfLDDGnCk/fmJO3+CA6tgF0mcLWJ5iif9iS6qoY3vdX8jKHjR367ogmwxmDF/VxxlL5hXgo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=ThY3aZXr; arc=fail smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AGHDO9Y030822;
	Sat, 16 Nov 2024 09:25:33 -0800
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2176.outbound.protection.outlook.com [104.47.57.176])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 42xw10054p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 16 Nov 2024 09:25:32 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qVVji5MHILylktnhTEwPiXt7e2vVQsxcvJpeZ+RhpdMCQOsMyI2hDI1k3lthiour/RkJ6OJihKs8DDfRBJ9VOvwbfjRVp71rZX7cAKcNcAlyWMPBBMHIYadbOOc8ZBVcTFDmVknxjKZ4GkDDh4F9+7mZTEJ6MFnOzGGYdz3GqfRA9Zz5ZylbC/jRQHwos6EOlYGKNF93rVfsA4VYY0dhuYm032ZdIPlLiSXwZL80hSrTMKT1NW6x9BVgSlBaxuPMekQpDdyVaN49lFEF8kPfeg5bpLnEaJZ2bIpzOphGGUArFo0g7LCHlL7g8AsdbOkOy01KpBrPBGgwV28vyewA0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ozPNsGsxtI1LDiwk1e2rt4Z4Xyd03mGX4VIrWrhWScg=;
 b=SC1RnWCu1/CBOgmlyUP308g7bL/9s2x5z1Oz5ZkIaP1qb9dRNwMC6CBJbmaWIhIHEV44NRinEz+GKVWE+wynahbTpBHztUXmRvPgZwWiq3Dgzp54YdFmg/zx7HAeDhhDxeDIQOxwdxfZH2x6OITla1aChGlgsY9QBsW4ySA3lhKPtQIl/rmBZ/RlsaDVERhENQVzlBs/4YqfXhOOtdObPzoQmdG1IuLQvpRYjky/VUsTWdFwe5k4gsKwlfflcQiqdLuvHt2ZnE0lRyYy6Q+ccR7XD30s46Qt/LjJ/APZ5PqMQcPkE/OVYO7b4g745HdSCEFaqvfUOnOYJ4e+AQMQqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ozPNsGsxtI1LDiwk1e2rt4Z4Xyd03mGX4VIrWrhWScg=;
 b=ThY3aZXrgpiMBrOWaaZK06V8ehqWrEw3jyYncdwiSYr6VusxPOEfYNvYlPq4XXphRwLAmJMMr5xm7b1wb0RpjERgZsIGmsUZgainm9P98YuGsG+8S9XcBTe9FLst0RO2nHOZyhe7wCSD0YPXjbKTH2kIkPrNvGhACpgtQXDgavc=
Received: from PH0PR18MB4734.namprd18.prod.outlook.com (2603:10b6:510:cd::24)
 by IA3PR18MB6311.namprd18.prod.outlook.com (2603:10b6:208:529::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.20; Sat, 16 Nov
 2024 17:25:29 +0000
Received: from PH0PR18MB4734.namprd18.prod.outlook.com
 ([fe80::8adb:1ecd:bca9:6dcd]) by PH0PR18MB4734.namprd18.prod.outlook.com
 ([fe80::8adb:1ecd:bca9:6dcd%3]) with mapi id 15.20.8158.019; Sat, 16 Nov 2024
 17:25:29 +0000
From: Shinas Rasheed <srasheed@marvell.com>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>,
        "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
CC: Haseeb Gani <hgani@marvell.com>, Sathesh B Edara <sedara@marvell.com>,
        Vimlesh Kumar <vimleshk@marvell.com>,
        "thaller@redhat.com"
	<thaller@redhat.com>,
        "wizhao@redhat.com" <wizhao@redhat.com>,
        "kheib@redhat.com" <kheib@redhat.com>,
        "egallen@redhat.com"
	<egallen@redhat.com>,
        "konguyen@redhat.com" <konguyen@redhat.com>,
        "horms@kernel.org" <horms@kernel.org>,
        Veerasenareddy Burru
	<vburru@marvell.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller"
	<davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Abhijit Ayarekar
	<aayarekar@marvell.com>,
        Satananda Burla <sburla@marvell.com>
Subject: RE: [EXTERNAL] Re: [PATCH net v4 1/7] octeon_ep: Add checks to fix
 double free crashes
Thread-Topic: [EXTERNAL] Re: [PATCH net v4 1/7] octeon_ep: Add checks to fix
 double free crashes
Thread-Index: AQHbNb0RQc020HgX5E6gYTB4lCpykLK1zieAgARereA=
Date: Sat, 16 Nov 2024 17:25:29 +0000
Message-ID:
 <PH0PR18MB473449C495237697452E777DC7252@PH0PR18MB4734.namprd18.prod.outlook.com>
References: <20241113111319.1156507-1-srasheed@marvell.com>
 <20241113111319.1156507-2-srasheed@marvell.com>
 <03ccdc24-27af-4b4e-baf3-40d89ae72e99@linux.dev>
In-Reply-To: <03ccdc24-27af-4b4e-baf3-40d89ae72e99@linux.dev>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR18MB4734:EE_|IA3PR18MB6311:EE_
x-ms-office365-filtering-correlation-id: 3e81fa87-9442-4cc1-b89f-08dd0663aaae
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?cWRjQW9Wb1ZrVVhqV0xabFhQSTQ3cDlNRUkwdVFJTW5hSHhxaGRHMDdvOVJy?=
 =?utf-8?B?S0dCQlNaZ2k5NFNGZG1yTW0xeEZzN0xRMEZhcEhhdXB2VkJNU3pTSmgxSlhr?=
 =?utf-8?B?bTJ4OTRmWmEwSDVyT0dDWjYxOHRZcVJKb0pCV2svNFg3ZmRDUU02Q01DOWMx?=
 =?utf-8?B?UVFGQmxtSGlnTlNVcDBha2NuQytJZEdHdWFEMGVMT00wdmNUUHU3UmlWZkpa?=
 =?utf-8?B?OVc1SENBWFdxOGRBNit4RVg3VTlXRWZ5enhGSyszS0RSVy9XeWpqU0xFbVJJ?=
 =?utf-8?B?S0ZhRlIvNUs2b2x2cFNGOHk3Y3k5WTBQRndHN2ZWRW5ZblhnS2lGUWJhZWdI?=
 =?utf-8?B?MkJjSmo4OVZwTk5EUktkTEdJaUpNeU0zS3UzZGtDL2owNmNVRkxEcXZ3TDZK?=
 =?utf-8?B?ajB3eDlXaDJYOFNpR0xOdUFKSGRadnU1bTllNmQ5cmd4OGVoYVhOaWdFZDhq?=
 =?utf-8?B?Qm1DaUNJbzlxMHIwSzdHQjR5L09WcGU2VDUzdUZIZmsxSXdmYXZnaGF6L05Z?=
 =?utf-8?B?TkR2YkhYWHAzREk1c0lvVkhHdmZ5aDRLcTVUVUpPZTZhN0Nqc3JaYUN0SHBo?=
 =?utf-8?B?YW9SaysyNHlSdkhOSjA5ZStUUisvQ1lrZzl1RmFSOEUzTU04UThxdnlQVkJ3?=
 =?utf-8?B?NGxQLzFCYXB3d0VqYUI0dFZaSEE2NGN1UW95NWxucW1UZjF6MHl0ZDJ5UnMw?=
 =?utf-8?B?YmJlcVBWWDBJdWZvaEdzRTZBaXdtNlVIbGllK1RMdHcweHE2MEV0U3NCSXBG?=
 =?utf-8?B?cFhMOVl0TExDaGI0dFA1VGFBM3hUdnNhVlBMbXhRbHFUT1R4NmQ5OC94NTZ3?=
 =?utf-8?B?RlpaMlNqOFBrajA1MHo4MzdlWEVvTm5mTEFWRzFKclo2S0x4eHNFUVNxMnk5?=
 =?utf-8?B?Ri9Cc1hWVldYWTQyNGJrRlZ4Q3pXVmVtR2RaUTU5Vlc4d1d4WC9TMUt1ZjFq?=
 =?utf-8?B?WW8zb0JDK29qS1kwbU90RjA2OEYvRjBYR3pLMkVkaFJDcmZEc1pjZHFEZElW?=
 =?utf-8?B?MEhiei95a1ltL1hKcmdzaE9ORFNIOHdyWUdVMUU4UkVjTVZZZlZUZFpQN2J0?=
 =?utf-8?B?NW80NFJQcnMvcXJFbUxweWcxNHdFTWZHTmtWcDVDM1pucDEyYzI1am9kNllv?=
 =?utf-8?B?aWRLTXhWWHExa3YyVEtUdENpaEZobXBLMGV4NjRodVcrQTd0ZkVFOVVmMVEr?=
 =?utf-8?B?THBRV05jZTc0bXJ2dHhXeE5MRjdTU0UrVWI1T1JEeS9ESzhLZ201bVJyMCsy?=
 =?utf-8?B?dGFwM3UzaXBiVkNwQndTL0NXZVpoUDcwNGhVbWNxUU9LQzNGSXNRUG9wWDZX?=
 =?utf-8?B?RkhXSVZETi9YSkZzSkR2ZE9xRUYyeDZ2TjhZcUVYWHJ2NWlTc1RQeHgwL0xV?=
 =?utf-8?B?U2V0dEhlWHFiNzF3Lzl0Qllsd3E5SCtlelVrZTJuZUJRTHhzc2ZDZjdMQ1Bj?=
 =?utf-8?B?TGRGeVBDTHV6UEpMRVBYSTFNQjBaZGJ6QWVLc1o0Qnl4RFB2eloxZnJUOVhl?=
 =?utf-8?B?NnZqdFN6MGxKcVF6akI1TUtPN2tERmtEZk9lVnJhQm5KVnY3anM0ZDc5b2VN?=
 =?utf-8?B?NS9rK3picVJSb0NkY2pMeFQ3SXd4NTN6eWhZY2w0dXpIa2czeGhHRitEdisz?=
 =?utf-8?B?OHZTMGMrY3ZmYlF5eExwSitvd2VZNm05N1Arb3FDbFYxbVpLM3ZmQjdDUXJa?=
 =?utf-8?B?d1IxWEorbDJPRTNYZ1dZQTFVaUZPZUEyampJZlNqMWxvNlNOczNjNTRYSUg5?=
 =?utf-8?B?RWF6dHhpemRIVGNqZnZmeVlnOGM2SFNCbTVQVCtnd1NqS09QVFJkd205QXEr?=
 =?utf-8?Q?DbIFSjxy2zTUzplROti2P8jUhaOCYc9gut33A=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR18MB4734.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?aHF0N0N3NFMxakVhdzBwRDA1SVNhUlVzUGl5aEhCeGJKZE5nQldCcW5pNnZ4?=
 =?utf-8?B?TGhFWUM2a0s5UUpCNlQxM3pobThIZnJId3VxaUFNdkpwdEFKSVZiOG94Ymh2?=
 =?utf-8?B?UmJNZWZpQXpWT3orSnNLVVFrRXFqMG5EbERaeEtOZ2hTR09Kc0ZBTFZlMlp2?=
 =?utf-8?B?N0tBK1dmNWZLL01MVmJSeVhCQytVWTAyWXBKM3YvOWg2eURCTE1VWlhsL1FO?=
 =?utf-8?B?SGh3RnNRWExtczh2Z2hrOEJ3ZDBsQWhSWnowUjFVeFJFS2crenRTZEtEZ1pX?=
 =?utf-8?B?Syt2NWtSU25pOEV3VEl3bHUvZWdPcDlUV1o5MmE5UVk4elpoSEIwZUZjMCtK?=
 =?utf-8?B?LzFLV0hQUVBnVTM5K0xaRXpNZk00d2NpMnkwQVpGSkxTK1ZrL3ZBZXNWZVdL?=
 =?utf-8?B?dlVSKzNPL1RTNzJYNUs2ZEsvNmhMemVFd25OVldub0V5a1N4MEE1SFVON1VE?=
 =?utf-8?B?NFRmV3dUL0FMTGgxSE4rVDkxZkkyQjhWOG0xTnVTdVBoRHJxT0Qyd2h0eXVJ?=
 =?utf-8?B?WVRuSm1jb3NQbG12ZWdITHZITEY5QncxamgyMmJ5eWg4TkdDZUVxYitYWDBX?=
 =?utf-8?B?bG5QSTcrSjZ2Y1hqRU1GUGZ5Ti9JZ3o2aDlGSVByT1VnUjJ0UzduKzcvUmgr?=
 =?utf-8?B?VUxXSmtZV3Z3UzNrTDRJalVKYy9hZG4xTisyZWRZcGJGR3RTNTdabnI3OEdV?=
 =?utf-8?B?YWYwKzhmUnJ1T2JLcjVoUFhqS3ZKZjk4QnJyMERlWXEwREJCWEpHZytSM2xL?=
 =?utf-8?B?VnhkVTM2WVUybWd1czJLdktGckpDakk0WXlpYVNhZ2NvSzMwZC91Z2JUMnF5?=
 =?utf-8?B?eHBwa0J2dFU2eU1CSkZTZUFJbGRudlo4NUdFWkc3cGo4dzFIMk1PWU9pcDNV?=
 =?utf-8?B?TmdQU1d5b3dlNGVaYTVQNllQb1ZYdUtRZnNzSjdzT0d2dzRlNXBleFV6LzFF?=
 =?utf-8?B?RWZhOGlqZFJBMU1INVA2VlZVQk9sM1VMVC8ybU1aUFRDRE9FdnI1OHp5TWRu?=
 =?utf-8?B?blBWM09ZeHFYU09IVTBrMUVoMll5RlorVERPNytXUVpuMmJMemVHUXhzQmVP?=
 =?utf-8?B?TmZnamFqQWZFOEQ3UUF6Q0w2cmxLc2ZacUllUW1HakoyMm9aZkxkQm82WWNZ?=
 =?utf-8?B?aFZ1S1N2eXBHdjZ3ZUhtazFHNDBxRmYxb0d0OGFVZnVUSGwwdFZYbmFqZGQy?=
 =?utf-8?B?UEZlTGl1WHdSY3RrVnZuMy85dTRtdFNzTVZrY1M0eVdOdXREZnhQb0M1SUJI?=
 =?utf-8?B?czJyaHRWUFlUU241bnlhM29PQkpxWXFDRnpRVkM1c0FYSDljbzhOcWdsYWRi?=
 =?utf-8?B?ZWo5dmV1NkNvNURQd01UWHNHRGI5RDdBNElYWU55V29Lci92ZGh0Rk1Xd3dy?=
 =?utf-8?B?M1ZJZVI5Zk9mWDY2WU9lRVlQM24wQU5yS3BkL3MwaWViWHdPait2UnlUeXFo?=
 =?utf-8?B?Vk1yemw2SXZDRGhuSXFvbm9OQjFKcnA1WDlEbkhnQUZhb1cyUGd4Y283S3Q2?=
 =?utf-8?B?UVZyK3ptUjIxZGxiUzF5R3NYVVhwVndXaXFaZTVSV3l2cVZLMUZaMlBwUWZZ?=
 =?utf-8?B?RTQ0MnNNbzVkT2htWmVwanBOYUhRaXlPZC9yOWx1M2VCWHZ5M0IvY00xRWxE?=
 =?utf-8?B?cy94eTU0dVdWZHBUdlFVeGNHYzNvWUZsQ0ZGUDlOS3lmZm1BZnVWZ2lDRER2?=
 =?utf-8?B?SDNRWEpCQUVlZXZnc3NBaWpkRFcxRjN5MjVob0NBYTI4dVBHT3RLSmllQllt?=
 =?utf-8?B?eVduWUdaaTh4NDUxellNL0Zldk9DTzE1dnh5a2NwamhYNXZBZVB6SjBrMElj?=
 =?utf-8?B?WmJoOWhqQUlzK2xlN1lkQXcwSVcrbWwrL3BCZHlsQWMwZGhDdTdqbXhZa0tL?=
 =?utf-8?B?dmIzOEkrTm9SSmQvMjh0QVdkRHphcGw0ZEFHZVViZVdmQS80VkpYbitLZm1R?=
 =?utf-8?B?amxYRENWTDFqNEpBQWZwWDl4bytUbzh2ZjFnUUxybmhFb3RBMGliVitBVkhr?=
 =?utf-8?B?SHVwQmc0MUZHWDZ6K2RmQkNOUGprd1ZTWTFRNXAxWmFjRng2Y1djVkVFbUJL?=
 =?utf-8?B?ODBEdnM5VWxWWlZKcG9DV3VkWnZmQVlTSEdEaG1sU2w1ZVUxakZpNzZDa1ZE?=
 =?utf-8?Q?u84LHTRDYjvh2LMKkG4O8NdBL?=
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
X-MS-Exchange-CrossTenant-AuthSource: PH0PR18MB4734.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e81fa87-9442-4cc1-b89f-08dd0663aaae
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Nov 2024 17:25:29.1266
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: A0BS63biTLfvFrBntNwF0O9swv1wwKtZ89EXCzpQDq3WfpmLPGs1Oz45PqiX2N03wFNu1Lf5g70F7gh4JLXW2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR18MB6311
X-Proofpoint-GUID: XQN_pEaSBtXPitYMRfDFjZUx9xhzIg9V
X-Proofpoint-ORIG-GUID: XQN_pEaSBtXPitYMRfDFjZUx9xhzIg9V
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.687,Hydra:6.0.235,FMLib:17.0.607.475
 definitions=2020-10-13_15,2020-10-13_02,2020-04-07_01

SGkgVmFkaW0sDQoNCj4gT24gMTMvMTEvMjAyNCAxMToxMywgU2hpbmFzIFJhc2hlZWQgd3JvdGU6
DQo+ID4gRnJvbTogVmltbGVzaCBLdW1hciA8dmltbGVzaGtAbWFydmVsbC5jb20+DQo+ID4NCj4g
PiBBZGQgcmVxdWlyZWQgY2hlY2tzIHRvIGF2b2lkIGRvdWJsZSBmcmVlLiBDcmFzaGVzIHdlcmUN
Cj4gPiBvYnNlcnZlZCBkdWUgdG8gdGhlIHNhbWUgb24gcmVzZXQgc2NlbmFyaW9zLCB3aGVuIHJl
c2V0DQo+ID4gd2FzIHRyaWVkIG11bHRpcGxlIHRpbWVzLCBhbmQgdGhlIGZpcnN0IHJlc2V0IGhh
ZCB0b3JuDQo+ID4gZG93biByZXNvdXJjZXMgYWxyZWFkeS4NCj4gDQo+IEknbSBsb29raW5nIGF0
IHRoZSB3aG9sZSBzZXJpZXMgYW5kIGl0IGZlZWxzIGxpa2Ugd2UgaGF2ZSB0byBkZWFsDQo+IHdp
dGggdGhlIHJvb3QgY2F1c2UgcmF0aGVyIHRoYW4gYWRkIHByb3RlY3RpdmUgY29kZSBsZWZ0IGFu
ZCByaWdodC4NCj4gDQo+IFRoZSBkcml2ZXIgbWF5IHBvdGVudGlhbGx5IGhhdmUgc29tZSBsb2Nr
cyBtaXNzaW5nIHdoaWNoIHdpbGwgY2F1c2UNCj4gbWlzc2luZyByZXNvdXJjZXMsIGFuZCB0byBm
aXggdGhlIHJvb3QgY2F1c2UgdGhlc2UgbG9ja3MgaGF2ZSB0byBiZQ0KPiBhZGRlZC4gV0RZVD8N
Cg0KSSB3aWxsIHJld29yayB0aGlzIHBhdGNoIHNlcmllcy4gSSB0aGluayBzb21lIG9mIHRoZSBw
YXRjaHNldHMgbmVlZCBub3QgYmUgcHJlc2VudCB1cHN0cmVhbQ0KYXMgdGhleSBoYXZlIGNvbWUg
ZnJvbSBzb21lIGN1c3RvbWVyIGNyYXNoZXMgd2hpY2ggb25seSBvY2N1ciBpbiBjb25qdW5jdGlv
biB3aXRoIG90aGVyDQpwcm9wcmlldGFyeSBtb2R1bGVzIGFuZCBmZWF0dXJlcyBwcmVzZW50LiBJ
IHdpbGwgcmV3b3JrIHRoaXMgb25lIHRvIG9ubHkgaW5jbHVkZSBjaGFuZ2VzIHBlcnRpbmVudA0K
dG8gY29kZSB1cHN0cmVhbS4NCg0KVGhhbmtzIGEgbG90IGZvciB5b3VyIGNvbW1lbnRzDQo=

