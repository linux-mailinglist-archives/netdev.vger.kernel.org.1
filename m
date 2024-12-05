Return-Path: <netdev+bounces-149449-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 270479E5A2E
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 16:48:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6281289427
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 15:48:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2D9921CA1C;
	Thu,  5 Dec 2024 15:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="LfvSm1ih"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E48943A268;
	Thu,  5 Dec 2024 15:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.156.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733413683; cv=fail; b=t0igqdXZZMjxy8n1exUG+ibC5YCpt4HZHgiM6AePIEE/wMkQA7wF7RCKAp2EOqsCYkZntoOn1cYCDyLLnnFT4KIgVtoK7EBx1bmJfG/eSBTYOXUhWqJ8bShHYRpClyHhuz+pTcOmNavcBJY4ONJr0E2c9iDV14RCpXBrZqyblks=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733413683; c=relaxed/simple;
	bh=GGfbu+bTo5UefH+r3UmIjZdGwrGn9Mrd+J9mRlF5/jA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=VQkfT+6ponONpa0pZhEmH0L/sbirFZQV+zcYtsW3bWtTSvBBXZXqMjl7T7mhovAHBjU7QFB7YhbefYv4qmFFwLn3zgrbA/sTrmGG3A8mOiddQoYB4ZeYCYakLud6Qfu7VBFYcwHWgdjmP7/mQQk2w/UuwxXxBlsN71KTFi7+iiA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=LfvSm1ih; arc=fail smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B5FaWZp016931;
	Thu, 5 Dec 2024 07:47:34 -0800
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2174.outbound.protection.outlook.com [104.47.55.174])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 43beyf00ud-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 05 Dec 2024 07:47:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oqABmNjjJZre38sNI5TyvUWfgt05Q2XkFAEZMkM0EDkycaDnImrEx+c48SjHW8aCIwGf1Lg+qXzTnTDOVjA2j4IO9I9qEyKWOS8oa1cFyxIzLQmlMj9j33pwO0jmDAa3Y/kcG8ecVaH75fHsfq20GpL/026AsY5JvqXCnMJP2jJ90q+WvUrPlzeRYF+FFlFmoy5pGHrsXZBm5JWSRCuqEGhCrUXF2Dcfq6O/nNI27vispUfq7Vf19xPSWe3vn6+y60mEsk5G/sBaan5Cflxj6ZLo3cKwqTyYsoBAsHmbfqSIE+7A6eTuEVhhKdSl8jR4XPsaJKFS3rWyrxZB+YSZ7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GGfbu+bTo5UefH+r3UmIjZdGwrGn9Mrd+J9mRlF5/jA=;
 b=b0wldFI7ZxeUl0PDkFgYyl2Igy+y4ezYQQhwIq17X6pZkYEakhc0cBRinCnDkZRRfD8EFDGjEkKtK1lnhqwAhC98pWHqCUaAezYlK5/AD202ThTMeIYd1DxX9nRw3FHF7qJmfY9xyEoJOyWn6rW6ksTao6QlZrDd3MfWhW4U6K+huP1TCLb1EPkFHyHSUl09Hr6ktpHcVbZOI7Yhn5FlJp6waEh6gU1v0Ug7Yeu9FnhlBSd7mAtgQbqaIljOdKU7U124MJF/OuEKkhSiWRFt9SI/coBNfjYD64lc6sz9vMmXtQ8+hBglThdN8ol8zmIPHDvsPXtnDzfEfq+7I+910A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GGfbu+bTo5UefH+r3UmIjZdGwrGn9Mrd+J9mRlF5/jA=;
 b=LfvSm1ihvzAhZtNfD9XV80ZEoSQBxu3lk5Q1gYgSCDk/ni8xgfSywRhWvfPqg5l115NL+AbuVuDKROYqvUjn0e+ryelb4SwgukUxm+5ckukLGoe1ZYA6FPgI81w3/2/gF0tEX4zpm4ugjsipUOSsFl9mmtygKRA0/UmHRttc2FU=
Received: from PH0PR18MB4734.namprd18.prod.outlook.com (2603:10b6:510:cd::24)
 by BL4PR18MB6432.namprd18.prod.outlook.com (2603:10b6:208:5a7::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.14; Thu, 5 Dec
 2024 15:47:30 +0000
Received: from PH0PR18MB4734.namprd18.prod.outlook.com
 ([fe80::8adb:1ecd:bca9:6dcd]) by PH0PR18MB4734.namprd18.prod.outlook.com
 ([fe80::8adb:1ecd:bca9:6dcd%3]) with mapi id 15.20.8230.010; Thu, 5 Dec 2024
 15:47:29 +0000
From: Shinas Rasheed <srasheed@marvell.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Haseeb Gani
	<hgani@marvell.com>, Sathesh B Edara <sedara@marvell.com>,
        Vimlesh Kumar
	<vimleshk@marvell.com>,
        "thaller@redhat.com" <thaller@redhat.com>,
        "wizhao@redhat.com" <wizhao@redhat.com>,
        "kheib@redhat.com"
	<kheib@redhat.com>,
        "egallen@redhat.com" <egallen@redhat.com>,
        "konguyen@redhat.com" <konguyen@redhat.com>,
        "horms@kernel.org"
	<horms@kernel.org>,
        "einstein.xue@synaxg.com" <einstein.xue@synaxg.com>,
        Veerasenareddy Burru <vburru@marvell.com>,
        Andrew Lunn
	<andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
Subject: RE: [EXTERNAL] Re: [PATCH net-next v3 RESEND] octeon_ep: add ndo ops
 for VFs in PF driver
Thread-Topic: [EXTERNAL] Re: [PATCH net-next v3 RESEND] octeon_ep: add ndo ops
 for VFs in PF driver
Thread-Index: AQHbROiK4G9UfreQbkSH43B1xsIrdrLVX/AAgAJuthA=
Date: Thu, 5 Dec 2024 15:47:29 +0000
Message-ID:
 <PH0PR18MB47342ED76DCB583E62078808C7302@PH0PR18MB4734.namprd18.prod.outlook.com>
References: <20241202183219.2312114-1-srasheed@marvell.com>
 <20241203183318.16f378d1@kernel.org>
In-Reply-To: <20241203183318.16f378d1@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR18MB4734:EE_|BL4PR18MB6432:EE_
x-ms-office365-filtering-correlation-id: 697949cb-7979-4e3b-1f6f-08dd1544202f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?cERSbWRSZDd6QXlTeTFpTDMzNms1S3I2K1ZKVDhLWUJ3b2Z2UlVqZFhacElr?=
 =?utf-8?B?eno3cGpZUTRQQ2tsY1dHWnpObjdMUTNxYU1GMTBmMjFjQTZQSEVnOXIwcTF4?=
 =?utf-8?B?Z1Y0UEorUjJqVE1IZjNkYVBRSldNTG92YWNOaWpnOUtacjhEcHZOU3hhQXJK?=
 =?utf-8?B?ZWk1dmk5N081SWxKVW03VHh6SkprWTdMcU5rbDF3VUdMT00vSlpFazlwNGRh?=
 =?utf-8?B?c210dW9Ma1UwZUg2cnlKdUdFWXhESXpQVmNubjB6TkNhRW9BdXlHYkxDYjJS?=
 =?utf-8?B?OUtKdldnaVd1TndDQWVpdjdwYitxdHEzMS9hRXdSc2tTOVgrNmZMQmpzb0Ja?=
 =?utf-8?B?ck1Da2tKSzAxZ1k1NVBnLzZBcFFFM0t6cXVZSkx6UHFmbzUzSEpSUzJhbjdp?=
 =?utf-8?B?NVBpeEVpbmhMWkVqUjFrWGxnME82OENHRkNEYTA4WExHaElqR3R5ZDJUYmNu?=
 =?utf-8?B?SnNwOWJodzBJVWk0UVJVcWthUnVnZmhwY3laeGRkVHBBRnFrZDU5cURHMnQz?=
 =?utf-8?B?RExxcHRRTFpXbnloYTRDa2NUQW9pZXdySkZTZ0JweHpiWk5xczFTcmZEUmJH?=
 =?utf-8?B?NXdLaU5BZWdydEpUMVN4RldKOUxkMm8zTi9nVE9WUnlmQURFSks3VkdVdUg2?=
 =?utf-8?B?b3dvRjUzZ0NFd3VmWnZkWUNSVkRDUEJJTWZRaG4rMnJIVEVrQ0MrWFozYnhT?=
 =?utf-8?B?a0lidWhnT1prM2JWNDlrdUEwZkI1c2IxdXUrQWZsaERQdDY2cE9TS1A1TkFP?=
 =?utf-8?B?M1IxVFkrOEt5SFl3TU1UeEFKMU0wZjVjVGZ5Q0VGQmpKSTc1V2EvYW51ai81?=
 =?utf-8?B?cXdzL1lCUUhGRkhhZENmbU42THFhS3F4ZkNWeURuSktldm9INHhPL3RTTU9l?=
 =?utf-8?B?RjRDdmVIWGQxeVpoR29LenNnTm9NOWZlRU1lWE1hTU16dlQwZjdTL0FQUjZP?=
 =?utf-8?B?aWtWZWlJOGQ0NDN3MmZDL2pDVG9sUzB1cTVBK2hoQ2tSWFJza1oyaGxpdnZh?=
 =?utf-8?B?Q0NkN0NsdVd3cVBIU3FwVDNXL00yam5jZmZtcWo2eXduZWxpQk9RSmhQb2kr?=
 =?utf-8?B?Nyt5NDFOYS8zRnVoTzJxalA4SStsbjVJZWJsNVFjY3Z4U1NBMUN2VnlXTG54?=
 =?utf-8?B?eFhCcFRpZlZPVnY1NTdycWJRTWFYQWVBVFN6eHVTL1RBOHd6YXFlZWI4R2tU?=
 =?utf-8?B?UWpBTTN5SlA1Ungyb29HbTJxbWYyS1htczNNdTRSOEZjV0EzanRybDFMTG9w?=
 =?utf-8?B?VlkyNkJjWnRGNkxYTmdtck5aenZVZ2FGNWtCM213ak1RcE1hZk5zYk9vSTJQ?=
 =?utf-8?B?UE5JRlJudEE3c2JKMGJiUzArNWw5Sm9iQU5YOVRseFEzYXhWdmZnWm9lRFVI?=
 =?utf-8?B?eGdLa1RUMmJibTZaaWxvekYzckp4cWFTWlpNWE9rQ09nYkhhem9VamhOTFlk?=
 =?utf-8?B?Ynl4dHlIb2J0Z0l4bUxFWjNVaTI0dWRZTGlrUjZFS3VzUVFYbjlrVGxEQUdT?=
 =?utf-8?B?cHVITzFSQTI5dzAyeS81Z04xY2thUytpSEtEdnJEU2lIVllJVzZBS3luWGZt?=
 =?utf-8?B?d0k2SWNSNG9rS1BsVjR0bmVJK0MyUVJwT3pxTmJVQmR6VVQ5TjIwczhHNTFP?=
 =?utf-8?B?OTJFdzVjbWVuS2dUZ01rUnZuVXh0M0lNTlN4TlNBUXRYQjBvSTZLUk9vR3px?=
 =?utf-8?B?MmFYUCtNMFVUTkhuYlBieGdWSVF0TW5rRVN1ZWdkdW9xY2xmK0NOVUxFNmhl?=
 =?utf-8?B?MG9JWW5NdTJGemlXblg5L1owaDBCTzNiNjB5bjN4UC8za2x2YzVFMGZ0ZUJq?=
 =?utf-8?B?RXpwMytRV0tycGpGYy9adzJLUVZjY0t5WERGUDdCdXhLNWZtUE5RV1pDTUZu?=
 =?utf-8?B?czJta3ZPZUJjOGM4Y2x0NmhjM2gxaWdXRG1GZjFkY3dJRlE9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR18MB4734.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dVJ1eHJMT0xQdm14VUh4RE1mcmo0dzNXYkg1S3psL0xnbElvT2ZwVVBFTW1U?=
 =?utf-8?B?YkFGaCtQSlE1TWxuSDR6S2JXM2FDdHRGUnNBRkhpMlVzMlpWSVY4QnlDQTc4?=
 =?utf-8?B?cmV6cFJsTWRqNHVpbzlSa2hnK1IwU0FmR2N5eVgxQmZxSG1zclRzS0wyR2lk?=
 =?utf-8?B?ZW5GRG5HSGIwRG9hM0RYanc3ci9OeFRud3ZRaFlmN2JtTHFndUZLVHJTODdB?=
 =?utf-8?B?dm1Dc2dOM3hOeWlqUC9GSjB6QkFJMVFTR3lKRUJybXRQMWdxOFpOeVR3SGFN?=
 =?utf-8?B?NzZmSE9NV2dFUzM3VjJVUGtrenpTOUtTeDdBbHhQYzRGakxjOU5Hb0orTUFu?=
 =?utf-8?B?aWUwUVY2c0NUNk82dXUxUWtQeEZVNCtJaFJJbERQT2hSdlQ5c3NsaXUxZmFG?=
 =?utf-8?B?T3RSTWVzaVBCU3ZVS1BJL0xFNWdFWUFuQ2M5ZzBEYU42b0dMS1BIQmdkZkla?=
 =?utf-8?B?QmpTZ25TOFhGLzlXYmtvRVVSWkNVT0NOMFAwTmRKYU41cHFyc1pvYTN0U09i?=
 =?utf-8?B?Wm5vSjk0WTR6YTN5TVQ1SE1iVy8wbzYrdTJkQ2FUZEJZNEtaUERNanJjVDJu?=
 =?utf-8?B?WVhjZW9EU3c3TlE4RnRlVUhsMTRyaVFnb2hDcnVxNjljMXFJbjJseTNKNElV?=
 =?utf-8?B?VDg1eGFpYVB1TE02bkR0VVVmVzNYWTJ4SjcwbW4vSU5HMDc0SUt3aFhnWlYx?=
 =?utf-8?B?MUJzcE1kYXpsNWZLOXFpTERoU1FBSVkyR25LZE1qLzAzbzRsTmxUR1ZTZXZo?=
 =?utf-8?B?Z0JGNXoxTkUvZWs1ZmRIakdjQTFhOUZyQnEydTVrUkNuK0N0TEFIdmJqNWdq?=
 =?utf-8?B?dmhMNTRGZ1lzQ3drZlBPaUM2bUdUQnVBbGR2YVhLQWJvV2NnWnpDc3FzUW1W?=
 =?utf-8?B?N3k1UXpTc2d4S1FyRThvOEJ4amFGbWVla2dCVmNFYW5aeUFpeUJBaThYcmVa?=
 =?utf-8?B?WUU4eWQzQlQxa2hrVk5MU2R1ajY0YXFPYlY0bTc5R2NHOWR4U3pQU1YwdVB1?=
 =?utf-8?B?bE5tbXEwQm5BZ0k5ZitNcy8xL21tOFlUZ2t3TUZFWUNISVZNWkFLTDZNMW94?=
 =?utf-8?B?aUptaHR2RVNjZG5DejhlVzVFeVBRNk05MVBRUWJ3eW9WUCtXSUp0TThIRGpZ?=
 =?utf-8?B?bTJvUGVmYUQ0UENwQlZCc0tvK2lVUWkxM2VTM1lyTE92RVZicHZxMDZrbno0?=
 =?utf-8?B?SEdsVTM2a3IvLzNsVXg5MWxjdjd1S2grQTBEaEVpTUo2RnZkNXVqNUdaMUdI?=
 =?utf-8?B?bWRGSDNyR1dpZ1VaVVU1NFpqWjdNcmxRaVByZS9oMkVDUGtYajZ5dmN3N3N0?=
 =?utf-8?B?S1VvMjdIcjMwUzJ5VmhnUjQwdnFGTVF1UUpJaXpKTGxHbWpVWk5OdGlzSDVO?=
 =?utf-8?B?ZDhUN0VHVTJnbHZuTVBnNUhESDhma0RDKzQrZDNuK3MvZld3dmhvemhiaTZk?=
 =?utf-8?B?OTErbjd5KzQ1Y1RBdSswZHZPNWRPNzMvdzlPeU1wLzVSUTRzZE41alF1Z0dh?=
 =?utf-8?B?RTVkaTVwTUVMM2RZM2p0ZFI3YWJnTmhRRjRIK01wSWZSeU9EMXNwaUN0NURq?=
 =?utf-8?B?cy9JdGNMeUhzL2JncTZhNHl4Mm5mYm9jVU5Nam9NYkdtR0lFVVcrZm51TXB3?=
 =?utf-8?B?SG9aOWs4R285RXdZdjlQWFBVMDJscnlHK0kyNzczYVFoRWtqU3QrSE95MzdP?=
 =?utf-8?B?RGc5cVhtcW1ncTFJeHlwSGhidzZQc0xJRTJMNFB3QmMvS0ZjYk1FV1NiU0hl?=
 =?utf-8?B?czM1MThzcXRpYWpMV0c2Um5kdVVkK0hKQytWRHVLZHFEKzY4ZUd5SldQVmdC?=
 =?utf-8?B?Yko5RERsSFJIZHdKdW5PQkU5N1NtR1RHTlZKWmlBbklySFJaa2JEYkhaY1M0?=
 =?utf-8?B?d0lJOEhTSmpZMHhkck9LdERmTkFQdG1CcUljNnJxUkdoNi84VzJSUVliNDZa?=
 =?utf-8?B?R044eDJvZlNGb1BJbmFhV28rbTJyK3ZOaWw3UkxqTytRczNBMzExelpVazJp?=
 =?utf-8?B?L1NKY3JCRVo3Yiszcm5SRTFHWlZWUklqUFFGVWNVMzExcHRMWjRxN1VaT1Ev?=
 =?utf-8?B?THpKYkFwbEhQK1pUNXhzSHpuaEdJUVQrOGc5Skp5YXJ4YWVZemNiTFkrbTZ1?=
 =?utf-8?Q?j6X4B9aS9FacIxi5fnznAmroL?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 697949cb-7979-4e3b-1f6f-08dd1544202f
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Dec 2024 15:47:29.7998
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BkSML3mOeM8/qWdVPGCaKztzPOrwe3pMwJvnwanODLi5C6qPmnjkrK+Vg2n9ViARrej7xPHVB/m/2xaOdPfgkA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR18MB6432
X-Proofpoint-ORIG-GUID: NX6dUhTFI3SeqEZnGRsAu8m-CNQUITB3
X-Proofpoint-GUID: NX6dUhTFI3SeqEZnGRsAu8m-CNQUITB3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.687,Hydra:6.0.235,FMLib:17.0.607.475
 definitions=2020-10-13_15,2020-10-13_02,2020-04-07_01

SGkgSmFrdWIsDQoNCj4gT24gTW9uLCAyIERlYyAyMDI0IDEwOjMyOjE4IC0wODAwIFNoaW5hcyBS
YXNoZWVkIHdyb3RlOg0KPiA+IFRoZXNlIEFQSXMgYXJlIG5lZWRlZCB0byBzdXBwb3J0IGFwcGxp
Y2F0aW9ucyB0aGF0IHVzZSBuZXRsaW5rIHRvIGdldCBWRg0KPiA+IGluZm9ybWF0aW9uIGZyb20g
YSBQRiBkcml2ZXIuDQo+IA0KPiA+ICsJaXZpLT52ZiA9IHZmOw0KPiA+ICsJZXRoZXJfYWRkcl9j
b3B5KGl2aS0+bWFjLCBvY3QtPnZmX2luZm9bdmZdLm1hY19hZGRyKTsNCj4gPiArCWl2aS0+c3Bv
b2ZjaGsgPSB0cnVlOw0KPiA+ICsJaXZpLT5saW5rc3RhdGUgPSBJRkxBX1ZGX0xJTktfU1RBVEVf
RU5BQkxFOw0KPiA+ICsJaXZpLT50cnVzdGVkID0gb2N0LT52Zl9pbmZvW3ZmXS50cnVzdGVkOw0K
PiA+ICsJaXZpLT5tYXhfdHhfcmF0ZSA9IDEwMDAwOw0KPiANCj4gSSBzdGlsbCBmZWVsIGxpa2Ug
dGhpcyBpcyB1c2luZyB0aGUgcmF0ZSBsaW1pdGluZyBBUEkgdG8gcmVwb3J0IGZpeGVkDQo+IGxp
bmsgc3BlZWQsIHdoaWNoIGlzIHRhbmdlbnRpYWwgdG8gcmF0ZSBsaW1pdGluZy4uDQo+IA0KPiBV
bmxlc3MgdGhlIHVzZXIgY2FuIHNldCB0aGUgbWF4X3R4X3JhdGUgd2h5IHdvdWxkIHRoZXkgd2Fu
dCB0byBrbm93DQo+IHdoYXQgdGhlIGxpbWl0IGlzIGF0PyBJZGVhbGx5IHJlcG9ydGluZyByYXRl
IGxpbWl0IHdvdWxkIGJlIGRvbmUNCj4gaW4gYSBwYXRjaCBzZXQgd2hpY2ggc3VwcG9ydHMgc2V0
dGluZyBpdC4NCj4gDQpBY2sNCj4gPiArCWl2aS0+bWluX3R4X3JhdGUgPSAwOw0KPiANCj4gTm8g
bmVlZCB0byBzZXQgdGhpcyB0byAwLCBBRkFJUiBjb3JlIGluaXRpYWxpemVzIHRvIDAuDQpBY2sN
Cj4gPiAgLyoqDQo+ID4gQEAgLTE1NjAsOSArMTYwMSwxMiBAQCBzdGF0aWMgdm9pZCBvY3RlcF9y
ZW1vdmUoc3RydWN0IHBjaV9kZXYgKnBkZXYpDQo+ID4gIHN0YXRpYyBpbnQgb2N0ZXBfc3Jpb3Zf
ZW5hYmxlKHN0cnVjdCBvY3RlcF9kZXZpY2UgKm9jdCwgaW50IG51bV92ZnMpDQo+ID4gIHsNCj4g
PiAgCXN0cnVjdCBwY2lfZGV2ICpwZGV2ID0gb2N0LT5wZGV2Ow0KPiA+IC0JaW50IGVycjsNCj4g
PiArCWludCBpLCBlcnI7DQo+ID4NCj4gPiAgCUNGR19HRVRfQUNUSVZFX1ZGUyhvY3QtPmNvbmYp
ID0gbnVtX3ZmczsNCj4gPiArCWZvciAoaSA9IDA7IGkgPCBudW1fdmZzOyBpKyspDQo+ID4gKwkJ
b2N0LT52Zl9pbmZvW2ldLnRydXN0ZWQgPSBmYWxzZTsNCj4gDQo+IEkgZG9uJ3Qgc2VlIGl0IGV2
ZXIgZ2V0dGluZyBzZXQgdG8gdHJ1ZSwgd2h5IHRyYWNrIGl0IGlmIGl0J3MgYWx3YXlzDQo+IGZh
bHNlPw0KPiANCg0KSW4gY2FzZSB3ZSBuZWVkIHRvIHN1cHBvcnQgdGhlIGFwaSBpbiB0aGUgZnV0
dXJlLCBqdXN0IGFkZGVkIHRoZSBjb3JyZXNwb25kaW5nIGRhdGEgc3RydWN0dXJlIHRvIHRyYWNr
IGl0LiBQZXJoYXBzIGlmIHlvdSB0aGluaw0KdGhhdOKAmXMgd2FycmFudGVkIG9ubHkgJ3doZW4n
IHdlIHN1cHBvcnQgaXQgdGhlbiwgbWF5YmUgSSBjYW4gcmVtb3ZlIGl0LiBUaGUgZGF0YSBzdHJ1
Y3R1cmUgd2FzIHVzZWQgdG8gY2hlY2sgZm9yICd0cnVzdGVkJyB3aGVuIHZmIHRyaWVzIHRvIHNl
dCBpdHMgbWFjLg0KDQo+ID4gIAllcnIgPSBwY2lfZW5hYmxlX3NyaW92KHBkZXYsIG51bV92ZnMp
Ow0KPiA+ICAJaWYgKGVycikgew0KPiA+ICAJCWRldl93YXJuKCZwZGV2LT5kZXYsICJGYWlsZWQg
dG8gZW5hYmxlIFNSSU9WIGVycj0lZFxuIiwNCj4gZXJyKTsNCg==

