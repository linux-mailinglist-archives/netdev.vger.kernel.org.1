Return-Path: <netdev+bounces-248014-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id B5237D01F77
	for <lists+netdev@lfdr.de>; Thu, 08 Jan 2026 10:56:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 438A130010F5
	for <lists+netdev@lfdr.de>; Thu,  8 Jan 2026 09:56:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 987D341C2F6;
	Thu,  8 Jan 2026 09:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="fQ9/HPZ7";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="vqeVSp1z"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D01F410D24;
	Thu,  8 Jan 2026 09:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767863664; cv=fail; b=Y1moIHHNrazEfXmSu2PakyWdf4UobU/XrYX2M8hByCKKwzy2VV+cHY7+IaBEouqdzDZlSUY2fAww1dV0wdYD7wt0Idpir0SXPXoZ6r1dnSU0xDvEi/h83kG+f9/fYxA9C984kJCbBEflovphGJcEuwrk2BxBWorRTWBJRNbq/CU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767863664; c=relaxed/simple;
	bh=GOdfVgPIIvYmNZ/KTfptKco+iYobc+2jGejwvdC0PN0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=JsKWKfOgtvRiQDPVud3MIWv06qQ2SZO2V1t5UM/XKES9FyYODaAosKvvVKpWUd1D7sJMbYMqG+IGL+qWCaKsDAozYXOoAWsblXzEvZmfp+48ZvIrtzsbKgqg7RASUmGSlQ5hGIHkumxoVVhllVHkC+Sxa4DWGALEhGiWQNe5z0s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=fQ9/HPZ7; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=vqeVSp1z; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60871KVv3780131;
	Thu, 8 Jan 2026 09:13:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=GOdfVgPIIvYmNZ/KTfptKco+iYobc+2jGejwvdC0PN0=; b=
	fQ9/HPZ77+B15/ara4YBl1tzczZNXTEzbG9Px2Go3gvQfFVpYVtJRz/XKHKMr1Cy
	yR8C08SOMK/BspU73n7HewJuvp3o1AbWj47iIYTe43744nSEaPGEsZHp59KX5XmL
	dryMTtOktpa0XgE0Yjkhn/qLb0Xld7RX/HeuDmhKLMTjVMNsQHaR4rzMkQg0ePPd
	0l/0S+q0tFoj87NvU88maXn7gY4L1Qwd1yqcmAHrzKUSDe3SdSQw8Jd6AFpDnW8d
	eiAjulQ9L31fiZSSjLdzY7ZpjPwEuHc8fZQhhfwbTJQVk/HYLs0HfvnUyQg0lYXA
	0haHrGzw6Txmb3BTPYKGVQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4bj7tr03v9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 08 Jan 2026 09:13:56 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 608726IJ026338;
	Thu, 8 Jan 2026 09:13:55 GMT
Received: from byapr05cu005.outbound.protection.outlook.com (mail-westusazon11010063.outbound.protection.outlook.com [52.101.85.63])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4besjn4pkb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 08 Jan 2026 09:13:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G/Ce/iePlL3FxN1nzxG6DPW9ZD9N7zGPII24lQE3ZA9tdhbvqoPQvqm9puIS8s2iJQieJqDT6rDesUWRktqA9HV+dXr/KW+/BjDa8Hr5qFK4P4avXxytpCuWKHkcEcTall+W7MFebrSxS1JYJXqITl575KGkC81BN17p8FgMl92CCv463OfTHw91Mzmr7EiQItHaGagG1CFp8XmfWNhOjiKA0JC+gTAAx3bTvfqceSXf3ZzCzyAoKxefK9MpuCLwarKeKG/sT4yCRwdyhrU/iRFLs8sPsnkx+ginykn6VP4IesbQwyfbvPYtoFOehSfKWF52K4x7CqKUvTajhou5pQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GOdfVgPIIvYmNZ/KTfptKco+iYobc+2jGejwvdC0PN0=;
 b=LchL7jgOBWkIBtN+y8mMAGeIX9hHJVv/2U2Mti/tdGXPdEjLOk+yq+17rLGrStIPf0a/piC3aKb4eHlNCsSDkC9t8HEbEnpPkvCrduQXbqc+L+V1REnVc4qdhqyXRChJIPd00cXIe8IwqnIthYMfA8VKtcrNw2GE8atGgnOEIiu88jsRQ33dC0uo04pJhZK+esRHSUDNM+eEIGqIZlBX6yy1rZ1KzSxLBf6cQSWRkPBU/4fHuxovK1pbwYQ33+i9kstVK5Ox6LRU8QVE6aHp8OgMHiSSAjC6jTMLL3iFmonZKm8XuVZywLO6ywxkPNo9ib/McLRp8vA1Wd6o9SyAYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GOdfVgPIIvYmNZ/KTfptKco+iYobc+2jGejwvdC0PN0=;
 b=vqeVSp1zTEtKDArh4pGqoISfnWrPaqN7huuqC6MNfP3ididfO+cMqMTmCFaTfDDx7GejwyxweR/nsb5AXBDz3HF5uYgj5ZMHg3u+N6MVKHobTGd+ZbFYsdgAFcIAjWAms7+14g5xSVHSZx8sxqtA+w32D9gwRGrGukcOziesXbk=
Received: from DS7PR10MB5328.namprd10.prod.outlook.com (2603:10b6:5:3a6::12)
 by SJ2PR10MB7599.namprd10.prod.outlook.com (2603:10b6:a03:541::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Thu, 8 Jan
 2026 09:13:52 +0000
Received: from DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c]) by DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c%6]) with mapi id 15.20.9499.003; Thu, 8 Jan 2026
 09:13:52 +0000
Message-ID: <90d2b744-5895-446d-9d10-9d2cbf341c57@oracle.com>
Date: Thu, 8 Jan 2026 14:43:46 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 03/10] octeontx2-pf: switch: Add pf files
 hierarchy
To: Ratheesh Kannoth <rkannoth@marvell.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, andrew+netdev@lunn.ch
Cc: sgoutham@marvell.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com
References: <20260107132408.3904352-1-rkannoth@marvell.com>
 <20260107132408.3904352-4-rkannoth@marvell.com>
Content-Language: en-US
From: ALOK TIWARI <alok.a.tiwari@oracle.com>
In-Reply-To: <20260107132408.3904352-4-rkannoth@marvell.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0267.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:37c::7) To DS7PR10MB5328.namprd10.prod.outlook.com
 (2603:10b6:5:3a6::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5328:EE_|SJ2PR10MB7599:EE_
X-MS-Office365-Filtering-Correlation-Id: 4793824b-f302-4c9f-f549-08de4e963dd4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?a0FJNWFwMnU2YlZWd29hb1JGNE96UWx5MlVkOWlMRTNFYk9sOUs0N1VFOHJ5?=
 =?utf-8?B?SEd5WEJPOVlLc3NOcE03MHJ6RHlDL1VtTVdUU0wrOGhVRmJhU2hqQU5HT0tt?=
 =?utf-8?B?bUxOdGEycXlqcG0zc0MxTDhLN21zMnovandKaWM3czA2bW5LanZlYUovbGkw?=
 =?utf-8?B?Vm9tNC9ITGJmL2NIQWRuaGZmeHkycXkxdzlwN2xPTVFKUGxoZkx2YXNCcUhl?=
 =?utf-8?B?RFhxNXc1U2d6dVZzME1SQk5LWUQwWUNKRDExZ3hBMkVsc3NVQTNnWERpMkpE?=
 =?utf-8?B?NFdwOUJxangzWHpFL3FKbFpiOER5ZVFZVGh4ZTV4QTNENStsQjRSYXN4MWVF?=
 =?utf-8?B?cjRxZVJ2NmxmYjRML3RPalRNYStCUk9Ob0REdEVuUWMxTm9MeWoySW1XSXBt?=
 =?utf-8?B?RDEzT202cmQyVnFZYXRQejRlcW5INFgyeWhRTUFndTI2ZzZMWER2MmtCaUcv?=
 =?utf-8?B?ektUOVI3SDhkNUtwSEVrWS9zN1ZDZmlWR1daUFVxMmphd2o5MDBrTkJ0YzVB?=
 =?utf-8?B?cmVRamczSDZ3MEgyVmc4QXdocTFYaE1wZ2RwclRDakpYWVd2RVpwbG84UXlv?=
 =?utf-8?B?NSs1MlhVT293SzhTWVRqMW1GcWs5eHdJNzJFOEJoNFRMdmVpL25hSEhoTHF0?=
 =?utf-8?B?em5yZnJ5UGUxTGdiL25sZnVobENjY2JWUDdqWVBpYjZNenlXSkJVcm01eFNF?=
 =?utf-8?B?eGVIMHBRR3dWQnVsbHBXWm40WldORFdTQ3A3bFNSZnJsOVZ2c0dTcVFoN3Uz?=
 =?utf-8?B?NEovOTdqZk91UnhOcDJEcG1PbGFoNlg0WlpHd1VJNWQrRXd1WUVrNjVSWGxG?=
 =?utf-8?B?anNhUU01djBQNkVWNUkrRTNZdHQ3SWNDaXFiV0owUnk0bHFkQ2s3TDBZSUpP?=
 =?utf-8?B?NWFJZVNpUlVMcTdIY3hPdXEzdlZqMFMrTVJnc2tJZzQ1RUduSzBEVDdiVUVy?=
 =?utf-8?B?UnVBSEdRQVFoUFhXOGZSSERqWUhVSWFNUHFPdE9CUU9MYmVHbXV3VnBFdS9t?=
 =?utf-8?B?ZWd0UCtYRmU0cGNlRER6MHozbUVnK2szK1AwVGFRYkRoQTRTQWw2QzRQRzBn?=
 =?utf-8?B?K1MzWlpEVms5RTN3UnlkYm9SV0ZwTWkvVllMM0tvbFlkeGw4WGJiSGVqVmxN?=
 =?utf-8?B?amMwN1dZdWVzelpCTU1OYjF5Szl6LzVhc3VUbjZia1NFSVA0NHNiQ1d0YjRJ?=
 =?utf-8?B?eEFDTW95aHFzRHkvdm1KcXdnUVpkWXlkcTN1RXYxRTBSNml1TEVvN3JIanc4?=
 =?utf-8?B?WVhHNkQ2NjgxMXBVcjZXL3ZoWlh2T283bm5sL0s2WUJuUnpGOHlUOS9vcmVX?=
 =?utf-8?B?Mnc0dGExNm0wTC91a3lWZHVUcytLRnhZRTlQaUFsUDZGRVFUQks0MkE2RStW?=
 =?utf-8?B?eXBhUGVBQTJ5cHRwRm5vQVp0eDdqM09RREZEd1pBRk80SkFpb2dPaG9JZ2Fs?=
 =?utf-8?B?OHdZQVpZTmJnZzRZS2xOUGpNbzBmZFJDMDBCenBwL2RlQityamVsRXljZWlr?=
 =?utf-8?B?MjRpNVk4TUMyeFgyMEZTT1U5MXFvdGxPcHBCZ09HdE14TmJMQ1FNYUM2WmNo?=
 =?utf-8?B?anFoUkNrQlpHNGFkQWJONFVra0UwTjYvYm02bDg4TWpMOG9MS3BBQS9ZcWoy?=
 =?utf-8?B?bzRiK2tQOVpHUjh6ZUJhTWl5SXg2cWM4em9NNVdmUy9sRHRFQTNIamloUC92?=
 =?utf-8?B?ck5BdWFpbkd0ZG5hTU1yckRaWXBjQnJUaXZPTXNhcUJWekh6ZTZSdUJadUFT?=
 =?utf-8?B?TTAzL3dVRWhGOVdZMXBsZ3hkV0NOZVVEaVNkWGpLNjY1aUpPZTJmN3h2Vlh4?=
 =?utf-8?B?blhsSzBxL3ZJdU1mdUVyVHhXUVYvRy9OVVNydmF1OXlGMFhmeHhEMVpzdUdU?=
 =?utf-8?B?UjE4RnN2V1NLS1dxSGtsZElXaWp4OFo5U0JKK2ViN1Y4dUQ1aTl1cjVMdFhR?=
 =?utf-8?Q?07/NztgjEgSXKmI8L+R9efhUb/Urx09Z?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5328.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ajVwYmVmZzdTTFZUeVpNNGVhQmNlZFVoSG5zdjJRSzdVa3RzQVYycFpCSXh2?=
 =?utf-8?B?ZUwxemJCVmkzNDAwLytDQnNJY2hhS3JoSUhsV3JuM3dKZTU0V2FvQ3BFY1Iw?=
 =?utf-8?B?TC9YaWIxenhKZFlRdEFsbG4vYUF6andDL2xHbzFDb2ZiOHNBQnMwWHRMVjBK?=
 =?utf-8?B?Ty9CK2h4Y3crOThOaE11S2FFY1VjelplSlEwTGM0b2RPMFZZY1kybndqWnpR?=
 =?utf-8?B?dW9qQml3Znh1R2gzMG9DNzJlcVVmZVZpc21RdmlGbnFtV1ppb3BSQ3phWFRW?=
 =?utf-8?B?VmhLUUhhQ1MwbzUyVi81Yy9WSENFVUZ3Y0lUYXVRbFNQQU1iaFMyaVUzRDd3?=
 =?utf-8?B?VHNLMDYybzBxcGsyOEtpQUt6bC92Z3F1b2ZRMGI5NHd6aW8xeElnVTVLcksv?=
 =?utf-8?B?RFZmZjNiVTdmWWY3NFdlMERMellqTDNreWtVUjVPWW9mV093eU82eXVaOVZZ?=
 =?utf-8?B?Z05rQlJDanc2eVU2R1NZejRkM093ZnFDbjhpZm1FMkdFMkdqZlFxQ1BQOHl4?=
 =?utf-8?B?NzEzRDRid2g5NWt3KzZmVFZhb2FZN0laTnRqZGxBS29pdUxxYzd5d29YSWtF?=
 =?utf-8?B?L1llL05paDZIM1NZVFY0Z0E0OFZsZmp6OEJGMzVIcGJONHI0QUs2bVZrWGVK?=
 =?utf-8?B?TEU2eklhdHhQVGFPUWdlVDRSUjhZT1A4VHVkWDFkWnpjVmdKSzdZaDlHZ0lL?=
 =?utf-8?B?MmtSWmFvQS8wTlRJalpSUThzcHRsOFZFdWJuU2NpTndyWTJVUldEaTF4a2JC?=
 =?utf-8?B?WXNkWVMza1haR3RKSWVVRlV1djlFM29xdzlOVkhNb3d3YnhUY3lBMUxLS2tS?=
 =?utf-8?B?TnZIV2pFZDY5dWF2a2lhcDExMDhqQnF0dmhWcUwwd1JOek5aZGJzbCtkdFF5?=
 =?utf-8?B?S2Z5NHRxK0lvdTRzVXhnMDJrVVRRaDg5MVQ0c3lqcWQxQVdpZXk3OXZSQ3c0?=
 =?utf-8?B?TDQ3bXk3R3NPVWhwQ1hLTm51WlVuaEpyelVmZU9zM0tvWGhqMklWQmhGQUdt?=
 =?utf-8?B?VGMza0trSEhMUENkT05mdHFIVEV0UTRZMnFOQm9NU0ZjRXhpZEZ0R3pvT3o2?=
 =?utf-8?B?aU9EVm1mWmwveTQzY2ladTlsdUR5VXRRSEgxdmlFb0MzWW5ySVgvNFhVOC9y?=
 =?utf-8?B?N0trbWNjWFI3bkhMK1JFNVpQTWwxaDhod1BISFZLLytqR01KL3lZOG1oVENw?=
 =?utf-8?B?SXdBYWF1OW9TRVh6ZTdUSmp0TXJUY3JYbEYzTmVhTzVXK2gySDh6M1BWWnNs?=
 =?utf-8?B?STFJblJyQ00vUGoxc3lyVmtpL1lTcCthemtWK0hlRW9jWFF1THlyRFRMcHZJ?=
 =?utf-8?B?T1c2RUpqcXZpaXFlWFFSSEthUHE4c3RkTTBLTjNsbXhCMEhDZ1ZuUVExSTN4?=
 =?utf-8?B?YUVRandzZTVIWDhjWmFwNTljTGRFMCtXSHpadEVxc3J5Skt2cmM2ZkxXNWpG?=
 =?utf-8?B?Vng3bGlMdW9xOVRQUmcrRXRJUnh6TktLL2xlY2dqaGRkaUI0cGFtSXBvVTlM?=
 =?utf-8?B?ODEycnJuWDEvYXlncFRHYVJ4b2dhWXRTOTVKM054ZDBlcmxiay8zTThURzNq?=
 =?utf-8?B?Mk9zSjY3bnQ5YytwVDRCd3QxU3BrU3ZnbzVOZTlKUGZqc3JNTG9SMTZ2NUZn?=
 =?utf-8?B?bHRoZ0ZWQk5meXlCbXpjWU1YSExnQmc3THZFamtSN251dDlLa1FhK0NKR3FP?=
 =?utf-8?B?QVJsVVFTa0JUOTA1UU1aVVBGTjJHK1Y2NW94Y2hJVXliWmgvNWNIQnp2eFRU?=
 =?utf-8?B?MjdTbUNzUEJVWm5jT2QvZ1F0eHMza2lUcjVvOEtYWFNEa0xDb1ZFWU84RlVQ?=
 =?utf-8?B?THhDVEdmbEVmNHp5bXNaa2VEUDhSY1dicytndUh5WTMzcFp0U0psTWprS01L?=
 =?utf-8?B?Ynh4UlFxNkFNR0Z3RjNINHo4elBOSjhJdm5LMzZ6T0hNT2lUOE1UNDd5eTY3?=
 =?utf-8?B?KzJRT3JIZ2pUTU84TVZ6cTZpUHkzRDVIcDFDQzhhSnpTNFVBdWgrYmJnMkFV?=
 =?utf-8?B?TU1qRTV0Z0xnVzlrT3lLb08zTWhXWmR5a0tsak1xQ1NuaWo0cXdlMVlzTElZ?=
 =?utf-8?B?YlNKSDdpYUZralM1SnRFVXVEV1JhM3Z4MFp5c1BLWTdNT0hYZy80WjdvaVFv?=
 =?utf-8?B?TlpjanJjbFlGNGJBT0FJMDZxQ01VeE0xSlFUelJKSU0yc0sxUTBjMFI4Z2h5?=
 =?utf-8?B?WktEcTgzL0d0UXpkbGxKbkQ2VXpmWDUvOXBhS2ZVQmtBc0NydGZKMXNmTVkx?=
 =?utf-8?B?dnZQTTBxZlE1bXVvbEpWRDFpczRDcVRoUmM3M2JDQjI5WGU0cVhmTlR2cGox?=
 =?utf-8?B?MDY0cCtjU0VBM2UrTVI5RGJUYml6UkFrQUxyVVJrRlNxdEpYTHRWKzJCTko3?=
 =?utf-8?Q?PiVOpxq61+FPwJNo=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Cz1Wc1Ne4TYI7gCYOeJQN+l7oaAgumRa1mUrcV58rPMmtBrCaz9MKrOL2g/1B1XlN9rj5ccXUFu4SXo73t9qUy4h6VVj+XqPil7IEn5JRjTYUhczGPJC/1xYPUtZMIbX3xCMTUlnhWusR4Km3Nr3DRiGvCEesawL26KiWVxt/eGpTAdiYTRJZWAxpTRWnUZXQM3MzohpMKMthtN55WwzoUrTwzKdVIQQfTkcygLAXAvg2Taccv/M0Co1DcZTFY8wRsWw6y7bvLq3/L6QO2FXCSiUhEYolIwcYpyPP9U9vR3vLnJb8lNqTP1uJHaZHr6Xxw1CLYS2le0Btns+4PAG4C6Hy9EmzgDbJLBb9N+BgoUCPzgERmLdVh7okCSrDoiqDqTRKU4xC656ReG6HtJa/7qUZx+mPOwOP3PEmpn4PzZTkoVKWutejpjhJr2TchGQ/s3bzMr72x/92dwhuQEiaTpQtWYL8PSTvD7uJC9rCgGafeTmnh+40CaMcA+GGpH5hYj/dP5/K/AGz5vPevNF88SocTPvyggVvEPAMijLapjifWzOSFT8a/njQCAqt5XwxyoaxEVexYYBETm5tNUPmH8M+BXY3BqcxZSSKhQmuIA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4793824b-f302-4c9f-f549-08de4e963dd4
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5328.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2026 09:13:52.5647
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XAQ4nxqbhYzI30gCGf+/f9MYm7oaBOg8QyjOtFj7iKhVy0ZOwpFk0KH/PM1H1neuaoooJT6Ux+8OPuZhqy4FPGlBiN0ULulo3eLEdPtXv+U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB7599
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-08_02,2026-01-07_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 malwarescore=0
 spamscore=0 suspectscore=0 mlxscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2512120000
 definitions=main-2601080062
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA4MDA2MSBTYWx0ZWRfX7w75DZO+gtH/
 IoT2CTwVBx+8kTI1G+B8Ia5GUL8MTYseztEaH+SQDjQ9cGHiPawwyW1DVQdfHfhU5u+j8Txs5LK
 bqyeGu4zOaYi7vHi4kAt+F0i0braWf+LB64YcrV4gdLjxxBis6MDlenivrPGrDxui0hcNj2EEiG
 81Tul6RcUCRZjbuYne4oDn3gwL4xRYW2WuDoatmL/DVxCGUgaWo4cInKoGzK3iL1DiMuvz6X+FW
 r4bjfQO5SQORzszyFqfKxNZy9W0FnFFs2kGg3TPEEqp1bcL0DzIZcje3o8fx6XrBmPkBXNhs0FU
 0/qD/OIbmfUa8Tji6Cf36Dy7C9Fb0XsMpBZy6u/A5R9wqjqJJnKDyUnHazfgUvRe9mNW8zkK/B8
 qzgi0p2p6DpTf4kKhji1IkrEgJss0HSmJLNT0Z+/UNXWitSYiA63aVZ5qc8YdD0G9C50xM12YG7
 iUYI3IbCOfOR+RLlZLoMw1aMVD9eB/a7i8LYqR30=
X-Proofpoint-GUID: l5jntc3twT-Hs6mYPYUwtVQSS1RWSUvQ
X-Authority-Analysis: v=2.4 cv=LN1rgZW9 c=1 sm=1 tr=0 ts=695f7554 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=vUbySO9Y5rIA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=JRYGk8rH6YwwxxXYnZEA:9 a=QEXdDO2ut3YA:10 cc=ntf awl=host:12110
X-Proofpoint-ORIG-GUID: l5jntc3twT-Hs6mYPYUwtVQSS1RWSUvQ



On 1/7/2026 6:54 PM, Ratheesh Kannoth wrote:
> +++ b/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_nb.h
> @@ -0,0 +1,13 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/* Marvell switch driver
> + *
> + * Copyright (C) 2026 Marvell.
> + *
> + */
> +#ifndef SW_NB_H_
> +#define SW_NB_H_
> +
> +int sw_nb_register(void);
> +int sw_nb_unregister(void);
> +
> +#endif // SW_NB_H__

SW_NB_H__ -> SW_NB_H_

Thanks,
Alok

