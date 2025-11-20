Return-Path: <netdev+bounces-240228-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 55FF1C71BF6
	for <lists+netdev@lfdr.de>; Thu, 20 Nov 2025 03:01:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7F05B35151A
	for <lists+netdev@lfdr.de>; Thu, 20 Nov 2025 02:00:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4617F23B609;
	Thu, 20 Nov 2025 02:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="RkdZeBge";
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="ZDd797yV"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-002c1b01.pphosted.com (mx0b-002c1b01.pphosted.com [148.163.155.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E26D226FA5B;
	Thu, 20 Nov 2025 02:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.155.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763604048; cv=fail; b=OJu65r39w8SI0d77XknxpCKQnq2kmC5Ccinep/5fcRIh4Tl608ZchrfKOobrDztOP9+cMplr6Xgv1ywqMCc/QBU09laRM3hxYpmD4nZj/YOKHSGE2Smg4iIIY3H0mFrbF07NebCa60C2U17gQOsW+f+csv4MGSyNw1KJSKcYfO4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763604048; c=relaxed/simple;
	bh=exTDmbhjM0HaKPlqbYmvYU3wmLJJtC/paJ5/ZU6f6zE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=lqa8z+5E6zhlb42CbgRDRFeSHXfdmSnV7GqW3XIkML2LFAKD7FAuB91x75IDS6AKPq/J666+syF5gOmO6EqUycyLxGZr4zlkqxXwmTMyZtS///wS3S4xUGq9BYbDxqHcW2tX5vbEwuM5jIQZihx2lIWyDk+5AHACe8Hq2c0fK+U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nutanix.com; spf=pass smtp.mailfrom=nutanix.com; dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b=RkdZeBge; dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b=ZDd797yV; arc=fail smtp.client-ip=148.163.155.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nutanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nutanix.com
Received: from pps.filterd (m0127841.ppops.net [127.0.0.1])
	by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AJGRiqY3611788;
	Wed, 19 Nov 2025 18:00:16 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	proofpoint20171006; bh=exTDmbhjM0HaKPlqbYmvYU3wmLJJtC/paJ5/ZU6f6
	zE=; b=RkdZeBger7FWh8lBZrJDEsGejFEtfE0NcB7XxsLR16E8mgLnNMFM1V9ud
	KULgCoaReSgS+rmSC3GWV4q1HWoh5eXtz8pE9rVPYi7Da5j0m7s2wOBVWUfpYX/e
	Pd3cPJaRNM67GPGDfn6H1uu6kB2Mu39LK4ugFp26zBg5BzuCF/6Xdrxre/GhRWqk
	ZVIVv6rjF4uxtkhmUva+nvEuGFu3CZRCQkQE/eOXLAm6yba1cDmIomyOGsjxa0Nn
	VK7y5RFQsUbY3iaOw8ysE3R25Mh8lmli7FamKYbdSYNFiaRiT+GicmX0PkiS8to1
	XBzZ7qGj3p6LdF2xvykPdc2jMbieg==
Received: from bl2pr02cu003.outbound.protection.outlook.com (mail-eastusazon11021133.outbound.protection.outlook.com [52.101.52.133])
	by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4aga0peckg-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 19 Nov 2025 18:00:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tb34RWPNYFFnSA+R61LCXhdK1zqqJlC5fqHDnOplUehdKYSqmVp4Um5mlfIq0mXv/RyIgw7KQGeknim4cAegw0gHgn8x2ByXpVIo8nW04lYlzjzN4/OKup1l4zJbJhXrAb1U5X4zqjig7k+on0KJnVq+nJNcYwfA5goyonnfMPbVdiQO6HTH/izebnW9hMMHBdhJ9G4NAr7Ahya76M2evIDu6ebfeSOntSUjVcvbuH9/6bk8QRljW1o91TXJhvrF/Iexpej2PHuh3VDJpfYRYSjPXqpcrlGOA28eHhbLpMRvsg1awvtiw2KG48pYURDYwOSUYkLM1DX2AWEDakyMzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=exTDmbhjM0HaKPlqbYmvYU3wmLJJtC/paJ5/ZU6f6zE=;
 b=ecY42ShQM9n5SF7O+Krsgj5Gw/CCl/iwhzS9f0aXV+RhLkfBZWh0EhBN7JOLy2NOJ8NZvLzxaJpKzs3azIDNmHFU5B1PRbCRRE0cj3R+fNs9LBB8DK6RbMdnHskSnsXQk0MbiDwlhQM7qnukVM4k58Sr5NsDmEqCZGTVKT52HyromFn4Av45xfKX/ZPraL9y9nYHrAdk1B8PGbcKzDip7ODsl3gIsYgA9fGRCT5bBCiSRlBldPl0jpaLSZpG0GzznNVxxQO2LK2dL02wZTx/CZej5pgmkYZvqbjpPgk3IzroLDmHHktUYBKp00SV1+ZCB+Os/ENjMxDrHffgw1eo5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=exTDmbhjM0HaKPlqbYmvYU3wmLJJtC/paJ5/ZU6f6zE=;
 b=ZDd797yVpOktCeK2aE15A/l1nee86HRXZ5kugy2+LxQmnzKVsGQqZWvCMVHEx3/xrDfk8GA9mGAVE+5Xrsjpit5+NDp0RLSMLDmneRLhCX2jDOqSa9oG6k36mmlhVnWfSf9JDqy85j2a1XbQr4E5cFeoSCpym35nhrC38oxQ4cshv/VE8fA3nNCj00klkbrmzZZbxfWg5vxxkvCpXY5WoHR2tQIFSfnJqm9yyK5kx5D6AKwVhEwLGAY1IBkTK6ECkJJDg/upb8Q0UQbshBwI0jwgqmnIVxUAHYMxkKPcbyqS+527tLLewkMuMdzMYbBMhrdPgetMcfABzL20Pjykrg==
Received: from LV0PR02MB11133.namprd02.prod.outlook.com
 (2603:10b6:408:333::18) by CO6PR02MB7811.namprd02.prod.outlook.com
 (2603:10b6:303:a4::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Thu, 20 Nov
 2025 02:00:12 +0000
Received: from LV0PR02MB11133.namprd02.prod.outlook.com
 ([fe80::10e5:8031:1b1b:b2dc]) by LV0PR02MB11133.namprd02.prod.outlook.com
 ([fe80::10e5:8031:1b1b:b2dc%4]) with mapi id 15.20.9343.009; Thu, 20 Nov 2025
 02:00:12 +0000
From: Jon Kohler <jon@nutanix.com>
To: Jon Kohler <jonmkohler@icloud.com>
CC: Eric Dumazet <edumazet@google.com>, "Hudson, Nick" <nhudson@akamai.com>,
        Jason Wang <jasowang@redhat.com>,
        Willem de Bruijn
	<willemdebruijn.kernel@gmail.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
        Simon Horman <horms@kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] tun: use skb_attempt_defer_free in tun_do_read
Thread-Topic: [PATCH] tun: use skb_attempt_defer_free in tun_do_read
Thread-Index: AQHcWcFnUQqtBOkli0a3kVsOu9uBaA==
Date: Thu, 20 Nov 2025 02:00:12 +0000
Message-ID: <CB96779A-3AFF-4374-B354-0420123D368E@nutanix.com>
References: <20251106155008.879042-1-nhudson@akamai.com>
 <CACGkMEt1xybppvu2W42qWfabbsvRdH=1iycoQBOxJ3-+frFW6Q@mail.gmail.com>
 <5DBF230C-4383-4066-A4FB-56B80B42954E@akamai.com>
 <CANn89iK_v3CWvf7=QakbB3dwvJEOxuVjEn14rjmONaa1rKVWKw@mail.gmail.com>
 <7D7750CA-4637-4D4A-970C-CB1260E3ADBC@akamai.com>
 <CANn89iKr4LUSaXk_5p-cot6rxDngLJ8G6_F1eouF3mGRXdHhUg@mail.gmail.com>
 <AD5D3F27-9E32-4B18-97D8-762F0C3A9285@icloud.com>
In-Reply-To: <AD5D3F27-9E32-4B18-97D8-762F0C3A9285@icloud.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3826.700.81)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV0PR02MB11133:EE_|CO6PR02MB7811:EE_
x-ms-office365-filtering-correlation-id: f7c210fa-d256-4ceb-c5e1-08de27d88a63
x-proofpoint-crosstenant: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|366016|1800799024|10070799003|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?a1kyT1FaNUN3TEc4aEkrMko2djZvL1hvMlo0aWtMKzlBc3F0cGtQQlJWUGsr?=
 =?utf-8?B?VXJrZ29uQjN2WUJPdS9haHFaNDFBZGFlKytXNUxGQmcza1dsNERpQm81dFcw?=
 =?utf-8?B?Z2E5QUZzdHIvWERPRDRWdEtxOTBOcTh6R24reUlYTTZDaHpRaC9GN3M0dzF5?=
 =?utf-8?B?cDNLd1R1YVErNWxNbXFtZlh3RTl6bGNsZFBTT0NCeEpPNlpGejRTVnlpR0tu?=
 =?utf-8?B?cG0wRGNZeVErd1AveDMxdSs0RUFYdDFobFdvZVh0ay9xcmpwWUFTU1R5ZXQv?=
 =?utf-8?B?dXVMYmdVaHVFTzRabzlrUEJLekV4WGVMWUM3T2QxSUx0Y2l2Q2xEbEYxR25N?=
 =?utf-8?B?dzhYWmkrd0dsVUpLQWwzdEFheW9URldLUVFOanhwZkRJZlE5cHpWOXQ3dEhN?=
 =?utf-8?B?NGVEaGVDY281RjRHQ3ozWlpkSGlYcGFHL1FIWDJ4ZDg1VlFlMDVZOHFYdjdJ?=
 =?utf-8?B?TmtPaW9SQXNLUjdRY3YvTnBpZEtkNU5MaXBZNDgwVEdrQkhYNE9qaFJuaWZD?=
 =?utf-8?B?aEtrRk1qdm96b2dxa2ZIbHpDTnYwaldLWXZsY3p0bEk1WHFEd2krUFFzR25Z?=
 =?utf-8?B?OEExMHp4Y25JaE96eFcvc0xrRTBsOHZnOGhPNmFtZUNSak82WTY2RzRXbnlX?=
 =?utf-8?B?RWUxbTg5UmRmWEhaVUduWDBBMDUvOTNOQm13MWlXNkkvK2JCVDVVK3hYTEl2?=
 =?utf-8?B?c0NOMlVQcHRkVjI1RWljTWFMdEtCcnpEZXBhRUhlMktRcmhCUTFweUU3a3FL?=
 =?utf-8?B?T2JaNDVwdGJGdGdSS0RKMmxUZkt1ZjJnVHViUi9zd3VFbExHK1RyZktBUnpU?=
 =?utf-8?B?ZElMQ0MrRmN5ZmZqN3RlSWFkNTVRQThOdVFRZ2IvR2g5SHM5UmdYN0JzcnRj?=
 =?utf-8?B?QThRbCt4YXdKajk3ZlhPNkJmeTFKVDRuWWliMHd4UUhHSVk5VU40WXgvLzln?=
 =?utf-8?B?eGJQOXBFM0I5OEpLMlpFU0tGbWEwYkw0WTZGbE9mUmZwd3ZFWUhtUW8xSHVB?=
 =?utf-8?B?MDMvR0VhY3hVVEgxSlVqS0tydm9LSjlvYVNBTHMrNTlvK0VSemtsV0N3VkIw?=
 =?utf-8?B?dnltN0VBT1B2eUpreFVxZHMzdG1rNXdqMnhLb2J5bVByUW1VWVkwOEVxTE1z?=
 =?utf-8?B?RERTbXZkOURhZ0xyUW4wVHRvc2ptMXlJQlc5b0hCamVwUGg4SXZtRk9weFpL?=
 =?utf-8?B?aDhSYmpGdm9xaTcybm1EUnRnelE2dWRwUzc1TVRBQnpSbGp6TmNJQTNwRy9m?=
 =?utf-8?B?T3lmSFhQTW03eDI0K2J4NndROGh5MDJwbkVUcktEbktZNE1aRDgyRWMwL2pk?=
 =?utf-8?B?SGU2ZkZOTUNOV2hnbm5pT1NWcjJvN2E4bkthdk9uVXQ2NFVlRGtVakxqbVBt?=
 =?utf-8?B?YnVjMlJSSHV1cnBlTkhQZG1ncy8vRHBRWHo5VlMzNVZhazJQNS93eFZTVzhN?=
 =?utf-8?B?K2I0ZGZvVkYyTHQ3bFpIVEI5TGNETFRYbnZBOXY3Z3BSMkhPM0ErVXU3K2hw?=
 =?utf-8?B?OGVEUUlvWlEwY0JLQnZJWE1TalM5YTY0emRkaE9JcTFKRFNZMWxIQ2lNMDJ5?=
 =?utf-8?B?SS83Vm05MFp5NHhlNE9hcDByZHdhL1hGSlNJUmFMejdTK2h0THpJTWFFN3pu?=
 =?utf-8?B?NzdOUkx1ZEJIMm1aaEFqeHJyR0xoUGJFYkYwOWt4UTR0bWx1ZTVVUWJ0MXRk?=
 =?utf-8?B?QUxiV2pEWjA4U00xcHFpaENXUlRIMmIyWXMzSjZMTlNqWkdYQ1JBZ1F5TzNa?=
 =?utf-8?B?MzF1UjA3dDdabG1HangxWS85d3hjSWxncHA5UGZiWHBFd2VtaWlVRHNNVTBM?=
 =?utf-8?B?cEdTUGZiai9LMi9aSWdnU3ZYdElDSk5YUTI5Tko4bjZvSU5lOUJhTy9GV1d6?=
 =?utf-8?B?d2ltZ1pjdGJTSFZVTUpkYVJZZjhFVFhGRmNxTEpmdEIyUHVNcjdVbWNyRUlT?=
 =?utf-8?B?MU5pZThuZXBmaUROSVk4WEJYbk5TTTVXVkp5dWl6QnprLzgzQnkwd0MwcCtC?=
 =?utf-8?B?ZnFLUm84U2dRQnpHZm4zYlgzVWJ1VU9oeUJ3Z0NtY1ZKTHI4VlNFbTJiemZV?=
 =?utf-8?Q?dtgTfB?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV0PR02MB11133.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(10070799003)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NEVmcmFGekhtMzZYa0RmVndJdFFaYnZrbXBnWktHNm5pc1VuU2ZPd0RRY0Rv?=
 =?utf-8?B?V3JkeThqeGYwUC9sc0hzcGZqK1pDYUdpYnQwb1VPdEd5UnJGWjlhajhTV2lk?=
 =?utf-8?B?TmxNVEJ0ODFOY1d0d2NPc29mUUtETkNXazZNMk5GZkVrVnJVcFpxNzlKeHh5?=
 =?utf-8?B?cmRKNWYxRjhhTWNwRC9haHNlaEdySFdOSG0rNTZLU0JqRVdYV0lHMW1YdXo1?=
 =?utf-8?B?YlFYWktMTGZyeGlqK2NMUjBDWHZmV3c1SzF6NmpucTdZMGROd0tNekhJd0dx?=
 =?utf-8?B?bm9mNVh5Q09tczN3VEZLRUNmSngvR2dyaHNBSFpQaGdMcHVNKy85cnNzWTM5?=
 =?utf-8?B?Mk9Oc0Z5VkJUQ0Q5ZVJnbFR3b2hwSmJ2bnNJVldrcjF3dkx4eEdiQVF1L3Bh?=
 =?utf-8?B?bWtjU2hSdHhocVhDUDVKWDU1dlBON2FBbk1GVXFGNFd1UHYwSEg1TGNSbjdY?=
 =?utf-8?B?YlM3MWZGcUE1aGdMV3pVbHc0YU1YNG9teUdCMU1wQU84TnNqaUJDakVzeTBX?=
 =?utf-8?B?Z0g1aUdRbXdFd2xSaVlhdnNLQXo5Qml2elREeUtZalFKdFJ2SkpySG56TThk?=
 =?utf-8?B?cjhJWUJQVWZWMytOalFGbGtOQkRhWWUyOStWc2hJSU1lTGJuUHdoM3dLOWd2?=
 =?utf-8?B?NkNyMTVFU2hQNVJNZ2V6WCtyU3dNYkFYeTQwNWdxS3lqQjBwTnlBZUdTLzZ3?=
 =?utf-8?B?T1QwTWFQeXZQWCs5enRGbFQyWDE4V2N2a2RXRkFidE1MZDNPcmJsMnlYTGNM?=
 =?utf-8?B?aXRFbERUT1huZGFFZGVXK1dFTngrRTFQYkE0T1F2c0ZVVk9UY0pPcnIxTDZx?=
 =?utf-8?B?WGVqR2lheDdaSGpFT2JlbUNmb2k4anFSaHFHTE9RY1l4SVhQS0YvbHBIRUdp?=
 =?utf-8?B?TUs2Y1JnQ1VjY2xWbzZBNEs3b003ME9Tejg5M0FkcERmejRRQW02L2ZFSXY0?=
 =?utf-8?B?NXRBeUZvclJ5TmJzRkJUKzhpd0hEQTlpTzc5OVBSMFFTN0lQWGZIVDIxMlRs?=
 =?utf-8?B?ajJnZUlmMXlJeWNUdmxDcEYvTG5mSmZzZm9ROEY4dHFsUXllem56Q05KQ243?=
 =?utf-8?B?LzdJbDk5RVdUVmNtaHB1WUZrSXUvdEVuNU40U2ZpUGQxMkJPYTB6WXlBenp3?=
 =?utf-8?B?S0Q0U3duWmVtNmVBSVdYMHBUTThBaElFS2hualRDQ0NPS0xhM0NmMTk4MXBG?=
 =?utf-8?B?Qm1tdlNWVWY2eURrOEdOamZOSVJ5Szd4dENZMTBYQktzaXB2VmZpM0JzWDdJ?=
 =?utf-8?B?Y2FzUDVRL0EvZnZLNmltRnFQajNKbjg5cFM4NEpSaGo1UGNzbmk4VjVrZ1Rn?=
 =?utf-8?B?dkxKZzNlY2x1UlZkL0RWVTYxMTlXL1lrYUtkOVVuR3g2a1l3UU5FZ2ZSZGgy?=
 =?utf-8?B?T3lWWVB0VnluRUMwc3pFNzFEdWEwa0xUV2dnWEowVk8rZW1WakRab3lGUms0?=
 =?utf-8?B?ZW1OOXNWeFQrRlNadXdRb0xCSXVYeXg1T2NjdkRIaStGWUczOThLL2JUSWZT?=
 =?utf-8?B?NHRkcHJCd1crWFZ5Q3hTNnBOV0p1MHhlWUFCOE0rSnFuNDZXSVgvYyszRUcr?=
 =?utf-8?B?WDlndXVjenRMVElXUTQ0RDd5dmVFRWczNE12dDhubUhiM2VsbWhYdmJhK2Uz?=
 =?utf-8?B?ZHJtclNZRHIydklMSGF1cG90SUFNSGppc3FXZERvdGF0WHBHK1g4NGc0NlFq?=
 =?utf-8?B?aWxTRUtZRnpFRHlyVUlybzJzeU5pWFIra0ZTejc3ZlNycHRVZHlUQlRSTXZr?=
 =?utf-8?B?SnFLZVdsUlZnRHBHMERScUdySERoakw5eDlVWlJ1N1piT3N6UmRUclhWOUdw?=
 =?utf-8?B?U3dTV2NaSmc3YU03YzYzemRtR0RPc0hqVC9KT2ZhQ3kwdytqOFQ4dUJ3MllP?=
 =?utf-8?B?bWtPNFFMOGtkakJqQmFEblFLOXVlcGUzbzVXR2VjSXpXZnk0ejhQSDdpdW15?=
 =?utf-8?B?SWxNL083MytIZkJ2czVRNk5PSU5xbEZhUUpha1hFdUtNbGxSbllYdWtUa3JX?=
 =?utf-8?B?d29PcDM2RDY3WHhCN3pPUFhHZkUvRGsyemNkOFVTUjhxc0R0ZW93QVFuNkd3?=
 =?utf-8?B?NnhNZzhWa0hWOUV0YUJUcFgxanpFUklKZHpTenZIbEJRTFJqWFk5QjJxSzdw?=
 =?utf-8?B?dlNOdzE2eTFwYWwrUm1YVVFzS2dPVkhlWUlwdzd4UVRWQk8wYjJnb1dvN0Ix?=
 =?utf-8?B?VVYwSGRvTVhCZTVFbjRnYStidXUwaW4rejFLVlFoL0NwVXJLRi9UbVlvL1d5?=
 =?utf-8?B?UWhYL0F4RzFFdkRnNlYvSXpicEZnPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1BDA7963F883064F9D87435ADE3ACF51@namprd02.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV0PR02MB11133.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7c210fa-d256-4ceb-c5e1-08de27d88a63
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Nov 2025 02:00:12.0858
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2WCKUlJLAMHEk9G2pAPKUjJ8k3Ut21H4+RGKQHrtwYG+wtHPVys8mA+8OFGSvjKHXvK7IKnEQHGJjchudb91xO495cxaUlyeLE3/kO/ydCk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR02MB7811
X-Proofpoint-GUID: nbACLVQT5jnLDGsqFGXfPiY6ovG6rIZh
X-Proofpoint-ORIG-GUID: nbACLVQT5jnLDGsqFGXfPiY6ovG6rIZh
X-Authority-Analysis: v=2.4 cv=DYIaa/tW c=1 sm=1 tr=0 ts=691e7630 cx=c_pps
 a=zQVrRFDx79pk1Kc/J51lMQ==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=0kUYKlekyDsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=64Cc0HZtAAAA:8 a=v3ZZPjhaAAAA:8 a=1XWaLZrsAAAA:8
 a=X7Ea-ya5AAAA:8 a=20KFwNOVAAAA:8 a=sW28boA9-avS9VLl3joA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTIwMDAwOSBTYWx0ZWRfX1YPwIKdGCI82
 dUxb6rIOBXzWOBf40CyCHdHwonlYv0Qgke9K8r/c7y2QHhXJE4m9dqwoJRTeMjMyCcd9H2vSQP6
 G0ey1K9ZUEydx090QXjnrvtCtZ5M99K8rJtKZph7WbbmNEAZZlReDmaWEyPWvgLtaoEDSAOXPoo
 c3ZJUoayd5jL0+Cbz91YSXnm8L2YO0QlvmFsOly9+vN4w/VsqZMDokNCS4FMYwBGsmVfoHbLvbY
 4Wol9a2SL/60p+IUxoRm/Np8nsm3VCjp55ZDfcNH23w48ny3Seil2fnDPgqp0anUjXOSGrPSUZf
 fxpfgkzb2/ojAFLtemSwF29n0IniuK+auc5BaUi75kUmAJ59DD+025pZhCj++iEiFaNlGLwnb0o
 JCWIenI4Tlob6EQVrf8vx9IGjskwfw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-20_01,2025-11-18_02,2025-10-01_01
X-Proofpoint-Spam-Reason: safe

DQoNCj4gT24gTm92IDE5LCAyMDI1LCBhdCA4OjQ54oCvUE0sIEpvbiBLb2hsZXIgPGpvbm1rb2hs
ZXJAaWNsb3VkLmNvbT4gd3JvdGU6DQo+IA0KPiANCj4+IE9uIE5vdiA3LCAyMDI1LCBhdCA0OjE5
4oCvQU0sIEVyaWMgRHVtYXpldCA8ZWR1bWF6ZXRAZ29vZ2xlLmNvbT4gd3JvdGU6DQo+PiANCj4+
IE9uIEZyaSwgTm92IDcsIDIwMjUgYXQgMToxNuKAr0FNIEh1ZHNvbiwgTmljayA8bmh1ZHNvbkBh
a2FtYWkuY29tPiB3cm90ZToNCj4+PiANCj4+PiANCj4+PiANCj4+Pj4gT24gNyBOb3YgMjAyNSwg
YXQgMDk6MTEsIEVyaWMgRHVtYXpldCA8ZWR1bWF6ZXRAZ29vZ2xlLmNvbT4gd3JvdGU6DQo+Pj4+
IA0KPj4+PiAhLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLXwNCj4+Pj4gVGhpcyBNZXNzYWdlIElzIEZyb20gYW4gRXh0ZXJu
YWwgU2VuZGVyDQo+Pj4+IFRoaXMgbWVzc2FnZSBjYW1lIGZyb20gb3V0c2lkZSB5b3VyIG9yZ2Fu
aXphdGlvbi4NCj4+Pj4gfC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0hDQo+Pj4+IA0KPj4+PiBPbiBGcmksIE5vdiA3LCAy
MDI1IGF0IDEyOjQx4oCvQU0gSHVkc29uLCBOaWNrIDxuaHVkc29uQGFrYW1haS5jb20+IHdyb3Rl
Og0KPj4+Pj4gDQo+Pj4+PiANCj4+Pj4+IA0KPj4+Pj4+IE9uIDcgTm92IDIwMjUsIGF0IDAyOjIx
LCBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPiB3cm90ZToNCj4+Pj4+PiANCj4+Pj4+
PiAhLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLXwNCj4+Pj4+PiBUaGlzIE1lc3NhZ2UgSXMgRnJvbSBhbiBFeHRlcm5hbCBT
ZW5kZXINCj4+Pj4+PiBUaGlzIG1lc3NhZ2UgY2FtZSBmcm9tIG91dHNpZGUgeW91ciBvcmdhbml6
YXRpb24uDQo+Pj4+Pj4gfC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0hDQo+Pj4+Pj4gDQo+Pj4+Pj4gT24gVGh1LCBOb3Yg
NiwgMjAyNSBhdCAxMTo1MeKAr1BNIE5pY2sgSHVkc29uIDxuaHVkc29uQGFrYW1haS5jb20+IHdy
b3RlOg0KPj4+Pj4+PiANCj4+Pj4+Pj4gT24gYSA2NDAgQ1BVIHN5c3RlbSBydW5uaW5nIHZpcnRp
by1uZXQgVk1zIHdpdGggdGhlIHZob3N0LW5ldCBkcml2ZXIsIGFuZA0KPj4+Pj4+PiBtdWx0aXF1
ZXVlICg2NCkgdGFwIGRldmljZXMgdGVzdGluZyBoYXMgc2hvd24gY29udGVudGlvbiBvbiB0aGUg
em9uZSBsb2NrDQo+Pj4+Pj4+IG9mIHRoZSBwYWdlIGFsbG9jYXRvci4NCj4+Pj4+Pj4gDQo+Pj4+
Pj4+IEEgJ3BlcmYgcmVjb3JkIC1GOTkgLWcgc2xlZXAgNScgb2YgdGhlIENQVXMgd2hlcmUgdGhl
IHZob3N0IHdvcmtlciB0aHJlYWRzIHJ1biBzaG93cw0KPj4+Pj4+PiANCj4+Pj4+Pj4gIyBwZXJm
IHJlcG9ydCAtaSBwZXJmLmRhdGEudmhvc3QgLS1zdGRpbyAtLXNvcnQgb3ZlcmhlYWQgIC0tbm8t
Y2hpbGRyZW4gfCBoZWFkIC0yMg0KPj4+Pj4+PiAuLi4NCj4+Pj4+Pj4gIw0KPj4+Pj4+PiAgICAx
MDAuMDAlDQo+Pj4+Pj4+ICAgICAgICAgICAgIHwNCj4+Pj4+Pj4gICAgICAgICAgICAgfC0tOS40
NyUtLXF1ZXVlZF9zcGluX2xvY2tfc2xvd3BhdGgNCj4+Pj4+Pj4gICAgICAgICAgICAgfCAgICAg
ICAgICB8DQo+Pj4+Pj4+ICAgICAgICAgICAgIHwgICAgICAgICAgIC0tOS4zNyUtLV9yYXdfc3Bp
bl9sb2NrX2lycXNhdmUNCj4+Pj4+Pj4gICAgICAgICAgICAgfCAgICAgICAgICAgICAgICAgICAg
IHwNCj4+Pj4+Pj4gICAgICAgICAgICAgfCAgICAgICAgICAgICAgICAgICAgIHwtLTUuMDAlLS1f
X3JtcXVldWVfcGNwbGlzdA0KPj4+Pj4+PiAgICAgICAgICAgICB8ICAgICAgICAgICAgICAgICAg
ICAgfCAgICAgICAgICBnZXRfcGFnZV9mcm9tX2ZyZWVsaXN0DQo+Pj4+Pj4+ICAgICAgICAgICAg
IHwgICAgICAgICAgICAgICAgICAgICB8ICAgICAgICAgIF9fYWxsb2NfcGFnZXNfbm9wcm9mDQo+
Pj4+Pj4+ICAgICAgICAgICAgIHwgICAgICAgICAgICAgICAgICAgICB8ICAgICAgICAgIHwNCj4+
Pj4+Pj4gICAgICAgICAgICAgfCAgICAgICAgICAgICAgICAgICAgIHwgICAgICAgICAgfC0tMy4z
NCUtLW5hcGlfYWxsb2Nfc2tiDQo+Pj4+Pj4+ICMNCj4+Pj4+Pj4gDQo+Pj4+Pj4+IFRoYXQgaXMs
IGZvciBSeCBwYWNrZXRzDQo+Pj4+Pj4+IC0ga3NvZnRpcnFkIHRocmVhZHMgcGlubmVkIDE6MSB0
byBDUFVzIGRvIFNLQiBhbGxvY2F0aW9uLg0KPj4+Pj4+PiAtIHZob3N0LW5ldCB0aHJlYWRzIGZs
b2F0IGFjcm9zcyBDUFVzIGRvIFNLQiBmcmVlLg0KPj4+Pj4+PiANCj4+Pj4+Pj4gT25lIG1ldGhv
ZCB0byBhdm9pZCB0aGlzIGNvbnRlbnRpb24gaXMgdG8gZnJlZSBTS0IgYWxsb2NhdGlvbnMgb24g
dGhlIHNhbWUNCj4+Pj4+Pj4gQ1BVIGFzIHRoZXkgd2VyZSBhbGxvY2F0ZWQgb24uIFRoaXMgYWxs
b3dzIGZyZWVkIHBhZ2VzIHRvIGJlIHBsYWNlZCBvbiB0aGUNCj4+Pj4+Pj4gcGVyLWNwdSBwYWdl
IChQQ1ApIGxpc3RzIHNvIHRoYXQgYW55IG5ldyBhbGxvY2F0aW9ucyBjYW4gYmUgdGFrZW4gZGly
ZWN0bHkNCj4+Pj4+Pj4gZnJvbSB0aGUgUENQIGxpc3QgcmF0aGVyIHRoYW4gaGF2aW5nIHRvIHJl
cXVlc3QgbmV3IHBhZ2VzIGZyb20gdGhlIHBhZ2UNCj4+Pj4+Pj4gYWxsb2NhdG9yIChhbmQgdGFr
aW5nIHRoZSB6b25lIGxvY2spLg0KPj4+Pj4+PiANCj4+Pj4+Pj4gRm9ydHVuYXRlbHksIHByZXZp
b3VzIHdvcmsgaGFzIHByb3ZpZGVkIGFsbCB0aGUgaW5mcmFzdHJ1Y3R1cmUgdG8gZG8gdGhpcw0K
Pj4+Pj4+PiB2aWEgdGhlIHNrYl9hdHRlbXB0X2RlZmVyX2ZyZWUgY2FsbCB3aGljaCB0aGlzIGNo
YW5nZSB1c2VzIGluc3RlYWQgb2YNCj4+Pj4+Pj4gY29uc3VtZV9za2IgaW4gdHVuX2RvX3JlYWQu
DQo+Pj4+Pj4+IA0KPj4+Pj4+PiBUZXN0aW5nIGRvbmUgd2l0aCBhIDYuMTIgYmFzZWQga2VybmVs
IGFuZCB0aGUgcGF0Y2ggcG9ydGVkIGZvcndhcmQuDQo+Pj4+Pj4+IA0KPj4+Pj4+PiBTZXJ2ZXIg
aXMgRHVhbCBTb2NrZXQgQU1EIFNQNSAtIDJ4IEFNRCBTUDUgOTg0NSAoVHVyaW4pIHdpdGggMiBW
TXMNCj4+Pj4+Pj4gTG9hZCBnZW5lcmF0b3I6IGlQZXJmMiB4IDEyMDAgY2xpZW50cyBNU1M9NDAw
DQo+Pj4+Pj4+IA0KPj4+Pj4+PiBCZWZvcmU6DQo+Pj4+Pj4+IE1heGltdW0gdHJhZmZpYyByYXRl
OiA1NUdicHMNCj4+Pj4+Pj4gDQo+Pj4+Pj4+IEFmdGVyOg0KPj4+Pj4+PiBNYXhpbXVtIHRyYWZm
aWMgcmF0ZSAxMTBHYnBzDQo+Pj4+Pj4+IC0tLQ0KPj4+Pj4+PiBkcml2ZXJzL25ldC90dW4uYyB8
IDIgKy0NCj4+Pj4+Pj4gbmV0L2NvcmUvc2tidWZmLmMgfCAyICsrDQo+Pj4+Pj4+IDIgZmlsZXMg
Y2hhbmdlZCwgMyBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+Pj4+Pj4+IA0KPj4+Pj4+
PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvdHVuLmMgYi9kcml2ZXJzL25ldC90dW4uYw0KPj4+
Pj4+PiBpbmRleCA4MTkyNzQwMzU3YTAuLjM4OGYzZmZjNjY1NyAxMDA2NDQNCj4+Pj4+Pj4gLS0t
IGEvZHJpdmVycy9uZXQvdHVuLmMNCj4+Pj4+Pj4gKysrIGIvZHJpdmVycy9uZXQvdHVuLmMNCj4+
Pj4+Pj4gQEAgLTIxODUsNyArMjE4NSw3IEBAIHN0YXRpYyBzc2l6ZV90IHR1bl9kb19yZWFkKHN0
cnVjdCB0dW5fc3RydWN0ICp0dW4sIHN0cnVjdCB0dW5fZmlsZSAqdGZpbGUsDQo+Pj4+Pj4+ICAg
ICAgICAgICAgIGlmICh1bmxpa2VseShyZXQgPCAwKSkNCj4+Pj4+Pj4gICAgICAgICAgICAgICAg
ICAgICBrZnJlZV9za2Ioc2tiKTsNCj4+Pj4+Pj4gICAgICAgICAgICAgZWxzZQ0KPj4+Pj4+PiAt
ICAgICAgICAgICAgICAgICAgICAgICBjb25zdW1lX3NrYihza2IpOw0KPj4+Pj4+PiArICAgICAg
ICAgICAgICAgICAgICAgICBza2JfYXR0ZW1wdF9kZWZlcl9mcmVlKHNrYik7DQo+Pj4+Pj4+ICAg
ICB9DQo+Pj4+Pj4+IA0KPj4+Pj4+PiAgICAgcmV0dXJuIHJldDsNCj4+Pj4+Pj4gZGlmZiAtLWdp
dCBhL25ldC9jb3JlL3NrYnVmZi5jIGIvbmV0L2NvcmUvc2tidWZmLmMNCj4+Pj4+Pj4gaW5kZXgg
NmJlMDE0NTRmMjYyLi44OTIxN2M0M2M2MzkgMTAwNjQ0DQo+Pj4+Pj4+IC0tLSBhL25ldC9jb3Jl
L3NrYnVmZi5jDQo+Pj4+Pj4+ICsrKyBiL25ldC9jb3JlL3NrYnVmZi5jDQo+Pj4+Pj4+IEBAIC03
MjAxLDYgKzcyMDEsNyBAQCBub2RlZmVyOiAga2ZyZWVfc2tiX25hcGlfY2FjaGUoc2tiKTsNCj4+
Pj4+Pj4gICAgIERFQlVHX05FVF9XQVJOX09OX09OQ0Uoc2tiX2RzdChza2IpKTsNCj4+Pj4+Pj4g
ICAgIERFQlVHX05FVF9XQVJOX09OX09OQ0Uoc2tiLT5kZXN0cnVjdG9yKTsNCj4+Pj4+Pj4gICAg
IERFQlVHX05FVF9XQVJOX09OX09OQ0Uoc2tiX25mY3Qoc2tiKSk7DQo+Pj4+Pj4+ICsgICAgICAg
REVCVUdfTkVUX1dBUk5fT05fT05DRShza2Jfc2hhcmVkKHNrYikpOw0KPj4+Pj4+IA0KPj4+Pj4+
IEkgbWF5IG1pc3Mgc29tZXRoaW5nIGJ1dCBpdCBsb29rcyB0aGVyZSdzIG5vIGd1YXJhbnRlZSB0
aGF0IHRoZSBwYWNrZXQNCj4+Pj4+PiBzZW50IHRvIFRBUCBpcyBub3Qgc2hhcmVkLg0KPj4+Pj4g
DQo+Pj4+PiBZZXMsIEkgZGlkIHdvbmRlci4NCj4+Pj4+IA0KPj4+Pj4gSG93IGFib3V0IHNvbWV0
aGluZyBsaWtlDQo+Pj4+PiANCj4+Pj4+IC8qKg0KPj4+Pj4gKiBjb25zdW1lX3NrYl9hdHRlbXB0
X2RlZmVyIC0gZnJlZSBhbiBza2J1ZmYNCj4+Pj4+ICogQHNrYjogYnVmZmVyIHRvIGZyZWUNCj4+
Pj4+ICoNCj4+Pj4+ICogRHJvcCBhIHJlZiB0byB0aGUgYnVmZmVyIGFuZCBhdHRlbXB0IHRvIGRl
ZmVyIGZyZWUgaXQgaWYgdGhlIHVzYWdlIGNvdW50DQo+Pj4+PiAqIGhhcyBoaXQgemVyby4NCj4+
Pj4+ICovDQo+Pj4+PiB2b2lkIGNvbnN1bWVfc2tiX2F0dGVtcHRfZGVmZXIoc3RydWN0IHNrX2J1
ZmYgKnNrYikNCj4+Pj4+IHsNCj4+Pj4+IGlmICghc2tiX3VucmVmKHNrYikpDQo+Pj4+PiByZXR1
cm47DQo+Pj4+PiANCj4+Pj4+IHRyYWNlX2NvbnN1bWVfc2tiKHNrYiwgX19idWlsdGluX3JldHVy
bl9hZGRyZXNzKDApKTsNCj4+Pj4+IA0KPj4+Pj4gc2tiX2F0dGVtcHRfZGVmZXJfZnJlZShza2Ip
Ow0KPj4+Pj4gfQ0KPj4+Pj4gRVhQT1JUX1NZTUJPTChjb25zdW1lX3NrYl9hdHRlbXB0X2RlZmVy
KTsNCj4+Pj4+IA0KPj4+Pj4gYW5kIGFuIGlubGluZSB2ZXJzaW9uIGZvciB0aGUgIUNPTkZJR19U
UkFDRVBPSU5UUyBjYXNlDQo+Pj4+IA0KPj4+PiBJIHdpbGwgdGFrZSBjYXJlIG9mIHRoZSBjaGFu
Z2VzLCBoYXZlIHlvdSBzZWVuIG15IHJlY2VudCBzZXJpZXMgPw0KPj4+IA0KPj4+IEdyZWF0LCB0
aGFua3MuIEkgZGlkIHNlZSB5b3VyIHNlcmllcyBhbmQgd2lsbCBldmFsdWF0ZSB0aGUgaW1wcm92
ZW1lbnQgaW4gb3VyIHRlc3Qgc2V0dXAuDQo+Pj4gDQo+Pj4+IA0KPj4+PiANCj4+Pj4gSSB0aGlu
ayB5b3UgYXJlIG1pc3NpbmcgYSBmZXcgcG9pbnRz4oCmLg0KPj4+IA0KPj4+IFN1cmUsIHN0aWxs
IGxlYXJuaW5nLg0KPj4gDQo+PiBTdXJlICENCj4+IA0KPj4gTWFrZSBzdXJlIHRvIGFkZCBpbiB5
b3VyIGRldiAuY29uZmlnIDogQ09ORklHX0RFQlVHX05FVD15DQo+PiANCj4gDQo+IEhleSBOaWNr
LA0KPiBUaGFua3MgZm9yIHNlbmRpbmcgdGhpcyBvdXQsIGFuZCBmdW5ueSBlbm91Z2gsIEkgaGFk
IGFsbW9zdCB0aGlzDQo+IGV4YWN0IHNhbWUgc2VyaWVzIG9mIHRob3VnaHRzIGJhY2sgaW4gTWF5
LCBidXQgZW5kZWQgdXAgZ2V0dGluZw0KPiBzdWNrZWQgaW50byBhIHJhYmJpdCBob2xlIHRoZSBz
aXplIG9mIFRleGFzIGFuZCBuZXZlciBjaXJjbGVkDQo+IGJhY2sgdG8gZmluaXNoIHVwIHRoZSBz
ZXJpZXMuDQo+IA0KPiBDaGVjayBvdXQgbXkgc2VyaWVzIGhlcmU6IA0KPiBodHRwczovL3BhdGNo
d29yay5rZXJuZWwub3JnL3Byb2plY3QvbmV0ZGV2YnBmL3BhdGNoLzIwMjUwNTA2MTQ1NTMwLjI4
NzcyMjktNS1qb25AbnV0YW5peC5jb20vDQo+IA0KPiBJIHdhcyBhbHNvIG1vbmtleWluZyBhcm91
bmQgd2l0aCBkZWZlciBmcmVlIGluIHRoaXMgZXhhY3Qgc3BvdCwNCj4gYnV0IGl0IHRvbyBnb3Qg
bG9zdCBpbiB0aGUgcmFiYml0IGhvbGUsIHNvIEnigJltIGdsYWQgSSBzdHVtYmxlZA0KPiB1cG9u
IHRoaXMgYWdhaW4gdG9uaWdodC4NCj4gDQo+IExldCBtZSBkdXN0IHRoaXMgYmFieSBvZmYgYW5k
IHNlbmQgYSB2MiBvbiB0b3Agb2YgRXJpY+KAmXMNCj4gbmFwaV9jb25zdW1lX3NrYigpIHNlcmll
cywgYXMgdGhlIGNvbWJpbmF0aW9uIG9mIHRoZSB0d28NCj4gb2YgdGhlbSBzaG91bGQgbmV0IG91
dCBwb3NpdGl2ZWx5IGZvciB5b3UNCj4gDQo+IEpvbg0KPiANCg0KQmFoLCBlcGljIGZhaWwsIEkg
c2VudCB0aGF0IGZyb20gbXkgaUNsb3VkIGFjY291bnQuIEJhY2sgYWdhaW4NCndpdGggbXkgd29y
ayBhY2NvdW50LiBJ4oCZbGwgZ28gZ2l2ZSBpdCBhIHdoaXJsIHRvbmlnaHQgYW5kIHNlZQ0Kd2hh
dCB0cm91YmxlIEkgY2FuIGdldCBpbnRvDQoNCg==

