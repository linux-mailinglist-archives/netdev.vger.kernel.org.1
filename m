Return-Path: <netdev+bounces-270687-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YJTeDvaTwWnuTwQAu9opvQ
	(envelope-from <netdev+bounces-270687-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 20:26:46 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AB322FC354
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 20:26:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A2C443031885
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 19:12:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CFD3334C00;
	Mon, 23 Mar 2026 19:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="AsYKsttg";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="PNSe9oHj"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AC053346B2
	for <netdev@vger.kernel.org>; Mon, 23 Mar 2026 19:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774293132; cv=fail; b=gDbT1+8xuQVk9bgSnomHSKdowEsPIrRQgfTrZOJ9ntIPb0lCCudr0xlwHAHiL9lvGL4O6t72b3BiVCfl1kt32iTgkNvX9zMOC1vYDH9Ax33UnKFk/E07ePq1gQSX+yzUmzu8lQ4S4PEKWdWcyhEb4aKcZWmbRdpO3Ssc2yZF5nQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774293132; c=relaxed/simple;
	bh=WX0qvYdF/6tW1t15A2cHejwuR5cZGSyhcVZd1CpZ3rE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=EUc1/6/5R7LdjgySDG9UNyXUZhaSV0LHl94/NgHsPQdrfDBiiUn9h+wlz890YDRehXYcx7NwSeVxGXTnFDGmuJxgGtKGBadu/Dh4TNlIFf8Rjdq8VZ3Z07yxwCJKgyq1rRUcHIoYnpQl+14nb5NaDFU6ewePSMFyrxPCHaCvzMU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=AsYKsttg; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=PNSe9oHj; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62NHNcst2016454;
	Mon, 23 Mar 2026 19:11:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=4XQM7bLUJvrvq+Tm+CB4VW8u83aBmKrGdwuoKpai7RM=; b=
	AsYKsttgulcHYvTyjSMMKz/ySUt13XyC3HnxU5q0hbuBIeMPHjEd/FNu5KdYsPgt
	ypeMCnmlraYhXadJLCrmT72snuCB9JjfkP4OJQXP43RmzWZtq8IBYt3pxV4abQMU
	uWjdjqrMMQRjV6UNZx40hX9wmc9mWQBePtaJYIUqEp6/22+ne+RbPOWVL6Z3qd15
	9VnqOl0Fl+WMS7Eeg8dmhEz2nt7DeY7jT0brk8qVmxhDe8oUN2YK14TOmxJogroj
	Q7QaPFRBql7tQB9F47n3WX6YBdpPPhhTehTLi4Rej4EWxrXR+/8cA2FLF3xRB2JM
	wUxohjgCHnyZyhDp1yP/rw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4d1kvnjxav-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 23 Mar 2026 19:11:10 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 62NIe85m038613;
	Mon, 23 Mar 2026 19:11:09 GMT
Received: from ch4pr04cu002.outbound.protection.outlook.com (mail-northcentralusazon11013023.outbound.protection.outlook.com [40.107.201.23])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4d26xngb87-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 23 Mar 2026 19:11:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j+q7Z5K0lnbeZj4EfqUW0w0k9oYCAt5sU+Q+VN1HCXWn5MRRm7JHoqaWyBf0Nt6Kqhnv+HBVv0Bw7YDu9TQh9yAvgmvr95OkqKwCepIWWUD39yFfKU93vlQTuzxTvoYOCD6LWUkRJ6fEWZM4PwKzNeNjSPP6f+w4ybnBXgAwdInsIr5wFvYKonKozh2GSE0h0NTkH2XuuMoA4onGH0fou1gqZjy3eflwOaBlrsQGbBq2CECQdtt/bAAXQxLdtTNgQkgGdv8hg05L7c2DkOANOYsfiP3uJNPxyRWlR5ADOAld0rdKdcOw22RR06D1U53gUXvXJ2xeRxTMNLX5ZcXHKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4XQM7bLUJvrvq+Tm+CB4VW8u83aBmKrGdwuoKpai7RM=;
 b=FfoXFhJs15ew/jWXr/mRii7v3UNe6qT+lhRttWkVm+Z6geNYwoL5dqRikUDE4eKa4pbW7HXP0SnZD0LmW5w4Un9JY0pioaz8eBSFY1Vd8sJoBFaV4xpXkNgJyIi4JAZRRlv9e436ElawX52BLvopoA+vadB2/WYM1OngZBMazkzAiJSez0Imd0eBHwVk8M/O3ZIL5pWDJQX2/MYNDfCVwvYTEc/kpCBA4k0S616v0N3Zq1bvPUMMWy8iO4+f8A8wQ76kzafNDRPT+DuxbMLdJVPE8lvGKQwID1I64XMrfmeGHaGfK+EcYRRNgmDxgnLm5EgvoG1uqvdXyivTPuSrLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4XQM7bLUJvrvq+Tm+CB4VW8u83aBmKrGdwuoKpai7RM=;
 b=PNSe9oHjeNnDvGk9GCU66SHw1hXrrZoJQ06Kw06ux1ImkGgonVxmzy7g+SHVID8aeH/uYO42IO7FfmB92EOEnNclOq1Uxyi14R8amn3NWch4qc6XtPjpCnHefOVhcZLOqLMBoOqvtPDp7ghX67o1TDAB5aXckdwq3bG+WQ0knh4=
Received: from DS7PR10MB5328.namprd10.prod.outlook.com (2603:10b6:5:3a6::12)
 by LV8PR10MB7846.namprd10.prod.outlook.com (2603:10b6:408:1f7::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.25; Mon, 23 Mar
 2026 19:11:06 +0000
Received: from DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::619b:1264:c089:7e90]) by DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::619b:1264:c089:7e90%6]) with mapi id 15.20.9723.030; Mon, 23 Mar 2026
 19:11:05 +0000
Message-ID: <3be153dc-1cf9-4e27-9aab-fc6845aff95d@oracle.com>
Date: Tue, 24 Mar 2026 00:40:58 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/2] net: huawei: hinic: correct IPv6 version
 check in TX checksum path
To: Simon Horman <horms@kernel.org>
Cc: gongfan1@huawei.com, cai.huoqing@linux.dev, andrew+netdev@lunn.ch,
        kuba@kernel.org, davem@davemloft.net, edumazet@google.com,
        pabeni@redhat.com, netdev@vger.kernel.org,
        alok.a.tiwarilinux@gmail.com
References: <20260321165238.647948-1-alok.a.tiwari@oracle.com>
 <20260323171149.GA111839@horms.kernel.org>
Content-Language: en-US
From: ALOK TIWARI <alok.a.tiwari@oracle.com>
In-Reply-To: <20260323171149.GA111839@horms.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0174.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b7::20) To DS7PR10MB5328.namprd10.prod.outlook.com
 (2603:10b6:5:3a6::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5328:EE_|LV8PR10MB7846:EE_
X-MS-Office365-Filtering-Correlation-Id: 27cef09e-4808-4f55-28d5-08de890fee90
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	6jT9z1cVu657bMumAIUZ7rqqj9QJJmLtn4Kir70Aazt34Vqol9Yf1V8Imz7RG3ktsU0XA6cM0a41ZyVDjGzZ+7mLVQvZ9uYSqxd4FtFOCJtQ34k/zVeGa4xFGivo1dnTNuF16q4tEEz0J0oW6+eR2SoLAtJ0HPKlK94MjzAxrPtei0Va5w6IXHEprFPk4In3nAGPr+ZddaYBx9OJMYP3oX4s07dowKhUP2omkcb1iZvOz9yjISum483vW/Sxbb2LB5fVHhilSqbkHWXGf/4jaxAfFoc0BPO5/IavX9QDtYfBQgIK9N792A2Y9/H4c7h8YErjty/SirHO04fDudgCZdCXxWNq3CZDR9Y/x5obcx0BUTmYbWuDyPXB6Ftj73u09k9lp3Fk+8KPrMch3azTLSNVQmHhb3WPKkSBpAEl53VUS/W84zxjXxAa2gmapr34Oeq5086cI2t6ktisBeLL2UKzeJRkuFqJMFSWntrx++7xnWvR+UuaCU/GU1p26tQwDb/lEudRhGimGDQgUQBqKFbKFtm2RByXgqHaDA+O1yECsb9zFdXWtXEDM4YyPBhGXMOgD4nTEXD6RVgD1F1yk9oUdEfZ+OokiXcbxc/gy+zIiaaNHCpQ21hDxXes6KvQCMLGce4WgFK7PMah3QYM0Tsd9WKRM3SUZnMepYWTP2jA30V8rwmfVC9obLmuzLzH5RZOi1201PbhI1+3ugZ6XmjfteBQXy4EiUdDcDQKay4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5328.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Z1crYVRyWjQvVFViQ2lHK3dHSSt3NnljeXBEU0YvUHZ4VTBXcUdsdjJpNmM1?=
 =?utf-8?B?MjFzcWlmY3R5UDlFN083SmkwQnoweEdaeEp0K3pCcHczZUU2ZTRrNmY1WCs2?=
 =?utf-8?B?L2FIcmNMVkdLSjZiZmlmdk4xTVhJN1huazg4UitIYzM1YkhERmczcmV2WVpk?=
 =?utf-8?B?cTVQTi9RT2JmUmNkVTQ4cGE0czFrTWFhTitoaDJtRHN6R0JUQlBQSWJRK2xX?=
 =?utf-8?B?amhFRHZmK3pyRUhuWUt3aUFNVnZTazVQbmtUM0ZCRjlWUHJabzRGWCs5dUVT?=
 =?utf-8?B?dlZSbVpLRlExSUt1c21tYys4K28zMjRGaWJDVkZvMEt0dGNsdUVsUjA1ZW5W?=
 =?utf-8?B?VThKUVcrRXU3WGdLdHBLUUJSM0JucWszOURub284ZXE5cXlxRlRVeXkvUDFj?=
 =?utf-8?B?Mlc5ZFdTcEZqN1ppS2JUajZJNFJLWHl2WGtkTThYU1BibVpZOW9HcndrbEpq?=
 =?utf-8?B?UWdoMWt2UFNTdnpsTW8yZUVWYnlUNlV3UEZJYUplOTRESjA3QmlKejgxaVds?=
 =?utf-8?B?T1o4MGtwTm5HZFk0ZHFQTjV4UmN3U0RDZ1pBWWQ2aTFhcTRWdjRlQ0drbit6?=
 =?utf-8?B?Z3U3U21MT3ozdFpVNitXZlVVV0ZHc2VUWTZGUkhCZzdoWFFvWEtEQlVPcUpK?=
 =?utf-8?B?bFhvYUpNc3NoRjMzUEt6REhGSHVTL2RxS2MzaEw1NDRDZmg3SDVKR0JIb2Vv?=
 =?utf-8?B?cmV2dXdubTg2VmpISWtlVFkrd01ZVlFyQUxlb0o4czM5K0tKQ1lneUJqM2JH?=
 =?utf-8?B?TDNTUzh4Mkhhb2xjbGZEUWF0QzVMMUZsaUsveStYTVBScDBhRVZIUmxMNGRH?=
 =?utf-8?B?Szh4Kzk1QStPWXN3WlVzRDA1eC9hQkpITm1EeWxLaWRRdzFCdi9VVGpmZW5v?=
 =?utf-8?B?OWhSemJxaXAxT3R1Wkp0UUE5ZEc0RnR6SHZLZ2crcW8zSzBXRXh0VTFJcFln?=
 =?utf-8?B?R01UaFl5anFNMTI1YlNpd3RDNUFIVEZubUs2ekEzSld1R0J4N0hRTVVzZnhr?=
 =?utf-8?B?Rk8rMzcrMWF5eVdBRVZEK3VqdEZ2T01mYUgzY00zemdYbTRrS0o4UTdHZ0s5?=
 =?utf-8?B?a1J1RmFyZjA5QUtHekUyL0UzVStqTUZ0ZUREa0Qwcldwck1VbmdLRXo5ai8w?=
 =?utf-8?B?bGtMYm9DVW1od1k5dkFzcnU2QU10MVAvUHJpVXV6TGNwM3BIZm4yVkpEdW1y?=
 =?utf-8?B?MjVFdUJzTW5ERTdyNU16ZDRKWGk4RnBXOXlCVFFrSlVBLzh4TzdiNFFiRmJH?=
 =?utf-8?B?dVdKVy94V0w5MngwRTM0UUxwcWJvaEwwK1RZUmN0enZKNmZGT285UWpBbzFU?=
 =?utf-8?B?WDQyKzRNR1JCOFpQUU9nUkdsNmcwUVRqWDVLc1B5UWRtNWw3Snd4MjZ2UStr?=
 =?utf-8?B?M0pMNjFRT1FYQ1hENkZMODFZUXlFcGFINWwzTnpWNkUzNnZJa281SlA5T1RM?=
 =?utf-8?B?ejlCNXNuczBMdXJwQ0VSS3d0ZmhEY1NjUVZJS3hmUGMvSG9GRFJiOS8vNmlo?=
 =?utf-8?B?bVdpcGUrSFhkL2RjRDA4RDBLVmRRcmY0ZzV4a3N1elA4OG1vSE9YODZKeXBC?=
 =?utf-8?B?cHpUd3QyM01hQjFaaTFzZE5WaHhxSllBMXlhNW9jdWFveW5EMGdURG4zZHVS?=
 =?utf-8?B?TGg4SmlrV1UyTmgvMDVDZG5ibnh4cTdxejFzT09XQXBEbWI5Mmw0d3hFQ01C?=
 =?utf-8?B?SDkrYWIxTmpTdHpIazZmREFGbFcraXprMFZ5b0tjWmVoSmRvTXl4QXlSTURH?=
 =?utf-8?B?dGRMb3l3cnV3QVdtRDMyVkNyQlJMa1NFN0Z2QjdGM000ZVZIeEpBemw2RTJB?=
 =?utf-8?B?aHd1NGpNeGZjNjU2c1VTaytrdGNWN1JNM0thYm1qVWRIa2tGVWg3dDlhRXJM?=
 =?utf-8?B?NEVySUFPZnRIUlhWYzkrTGVWbFBpamlSaVY3SFMzU1V5M3lYUWtxa1JhZ2ti?=
 =?utf-8?B?K3h2S0dZZXVaQ0poVWxwSW1TUU9lQTF5bjRVY0ZXSVZBUW9mVjg2a0c0b2VD?=
 =?utf-8?B?bFVWL3laaldjTEZsRDZEM0h1YnNSbHBFSzBwMnpOajJEbTZRY1o3U1J1ZFBW?=
 =?utf-8?B?UlpCaFYyVzdXMkZkMlVNNjNRVzVlYTdBSVZNamtYc1Jub3V1eGxpcTlGa0ph?=
 =?utf-8?B?TTRtNytQTGxsR0IzejA0WjVjcjA1c0FBbHVyWkI4cHRSTWE0ZDdyQzRuN2xX?=
 =?utf-8?B?dnlsdzErSndHbkR1bEtQR2VQdVpLOTV6YmhmdHpRcXpuWG5QWEwrSzhIYkNM?=
 =?utf-8?B?ZUI5RDhsZjlWai9zQWFZUnZLcEt0V2VrSEQvSGNrQWJzZThSMmIwMSt2WUlX?=
 =?utf-8?B?eVllcjM4YmVVRTlTMWxZVmlBSDU1QnpBdEFmTDUxWGVCL0hvbnlzVjVkdFBy?=
 =?utf-8?Q?VBf6fNmndUfI/TrI=3D?=
X-Exchange-RoutingPolicyChecked:
	g5+d/uTXWHmnTXnuRM+ikGInAPtCndfEYkWYLiKqQiEhmtY3Gtb3poW22/Io1ptFofyACRkJ/iToMZ6qV8qDEZ3vLOmLs5Lc9ioOhQvsT8ydyX1YRhFFixUODJhEq4VAv8hLduHsLllxJtNmhKWWdTn4/ExjZC/4JwP7gpAPeLOGCVm4rg1WTy36i1N5THFznVrhnnAKYQruxG9C+HDSWGVLfYeNmJ6X2mVtjCIBQi4SurwjgKtnQ/hNAf5Am5ThGJ2MD1QRplsgLrD0m+fjF5TBGkIs0Kgga08uinzFF2Aa2ndyeRZzKImLs3IBYB9SSCtwz7PXu/iS93lR1kaTdw==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	06/PR04IRARnLB948CZtusNQxe7mWx2ndnliyxOPgUKMt2tyNDBTHMWQhkEh0py4dfKzYBkaj468vVlTVpbRZZx3kARKR/qGfOUBYj6SxJupin2jKwdAakVHvx+lsP8SGXaX4XcHNVovhL/gXJqb8p+PF65NQXa4Fp8HASpW4mN/ZUwjE3c/3cVcdRBlvuYimRQFGrcKIS6cDwIoJ/Z3ZfEwQXXPloMRxeJXcsU8A6KcGH69Iuxfclvpabzl/Rj80m9TX+dLsJ+YDrZV3dYmWrdO3LwVlA+2zfDvvJgCXy2BwQT/oe2rUO5J02fEKZ1I32T7QcMuqBh9+jxLANYb/Cy+OqWfndFkdTSMUOPhkUM9uefIJoVGYqecM7XhpWlIifqGjU1B01VbTL4SNSXHGcN50XrDHOFIkwD0GuyatwAQ8PqHAiY7d9ARuroug8Eyij7dkNRspRMAzMTqs2zZzK3RVMriyqHe1E9ZTA5Sfx/J8R9FRsA5ylZTfFTSRrIdtf4LUuDZIPIfJnLbHppw6OmaCzi8QZruvhZQK5dhYYKyd0VGBYxfCndt2tm6JZsgP5k05JyPdOBs2Uu1OkJM+QyuZRoamm0ZSqi6shcZ8Lk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27cef09e-4808-4f55-28d5-08de890fee90
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5328.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2026 19:11:05.5275
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zSVhlzpfVFyi4oPmo8l1gyqj5lxNLaV1UwChQG/z89kWpnlvHLUj7cqKTJsvFm06O9pSDfeTKllLJxKBStug06OLF+Y9Vsqw24yYF4BpuYg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR10MB7846
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-23_04,2026-03-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 spamscore=0
 adultscore=0 phishscore=0 bulkscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2603050001
 definitions=main-2603230141
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIzMDE0MSBTYWx0ZWRfX/7qYi49/WEex
 9YS0rOI7WRJDO8ZEo3s221xj9uIPK0zZz8tBNd+xkDADqnB3Jy9ZG0OvfB7u5ssQkZ7NDilfKQE
 k0BZ/rtTskNff1gtebcHwEJXbA7muXSRRNM36fvzyg3H4nF3gs4P+kfFpydGFhyVAjZjdTsn1za
 M00YdsF7ws52WAZGpRVsMqWHJjPCFIeCh/hSap6NBRjel1wcNUABENE1yWY0ICIvTV7tbxwzdYy
 v11bCXVhQAknFtwPatqh7WHrsulGNB5P9OHgWxFFInoyA3Ew26rPS9/pyN1UnNGNsCxIIr49nrc
 ltNzG5zcbkylR6qo/Scqxy/P8E0BWhm4znsM9fcJDmIyH4DvP3YHXbaJQTJBCq7QSl/H7PRP23O
 zgyVy+hx6iaHwZdzAyLvmPQEHo3rgMT2g1H1l76HsxRmLgxXGvUnpGNo+0J3tL5o6bvrpgfsf7Z
 BgFF+yA6RVfEkmoi7pgQJ5bjyrQaEWttbcbmgvFY=
X-Proofpoint-GUID: CKbvuqCsQdr7FwN4BuxSwZjD-7m8J3Ss
X-Authority-Analysis: v=2.4 cv=GrtPO01C c=1 sm=1 tr=0 ts=69c1904e b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=7Gl3-_t3PgB9XO-mQDs3:22 a=yPCof4ZbAAAA:8
 a=l4PrjD9A3hpmDkmKiTsA:9 a=QEXdDO2ut3YA:10 a=zgiPjhLxNE0A:10 cc=ntf
 awl=host:12273
X-Proofpoint-ORIG-GUID: CKbvuqCsQdr7FwN4BuxSwZjD-7m8J3Ss
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[huawei.com,linux.dev,lunn.ch,kernel.org,davemloft.net,google.com,redhat.com,vger.kernel.org,gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,oracle.onmicrosoft.com:dkim,oracle.com:dkim,oracle.com:email,oracle.com:mid,sashiko.dev:url];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-270687-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alok.a.tiwari@oracle.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 3AB322FC354
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 3/23/2026 10:41 PM, Simon Horman wrote:
>> The TX checksum/offload code determines whether the network header is
>> IPv4 or IPv6 by checking the version field. The IPv6 case incorrectly
>> checked ip->v4->version for a value of 6. Use ip->v6->version instead to
>> match the header type being parsed.
>>
>> Use ip->v6->version in the IPv6 case to match intent and improve
>> readability.
>>
>> Signed-off-by: Alok Tiwari<alok.a.tiwari@oracle.com>
> Hi,
> 
> I see where you are going with this.
> 
> But I discovered sashiko.dev a bit earlier today and it's AI generated
> review of this patch-set points out that the same pattern also exists in
> offload_tso and offload_csum in this file.
> 
> And likewise, for patch 2/2, the pattern exists in get_inner_l3_l4_type()
> as well as where you updated it in hinic3_tx_csum().

Thanks, I will send v2.

Thanks,
Alok

