Return-Path: <netdev+bounces-248011-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 644C3D03242
	for <lists+netdev@lfdr.de>; Thu, 08 Jan 2026 14:48:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 156373071BAE
	for <lists+netdev@lfdr.de>; Thu,  8 Jan 2026 13:40:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 686963DA7F9;
	Thu,  8 Jan 2026 09:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="VuZiaUHX";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="esCVtQDV"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EE183EDD45;
	Thu,  8 Jan 2026 09:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767863287; cv=fail; b=LyXlvcMEIIFAfjuiQFPPCPYIEL0Kk2KSeiwHFUK7aVOGvmRn+r4itu3/njSHk9BMpYF5Dwwpih1jlc138zE498EMQcFL3QgyX4zo0m86evCetV27RIT9ua4HLx3CwVfpqX3Cl9eEqq53eby0MOG8dxW7RCU9Ja875IQCVI+IkBs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767863287; c=relaxed/simple;
	bh=HQJ/q+hxG457tlvbpQWQhesGddZHhV23H0ruLkZ0Rcs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Mu7zHzhTbTysYutsfDeon6m8KVH2QDLW5w92/sZmJLJYQTiIj1RyXs82emkO0HngxB5lNMYptPrkragf1ltmayNAgNbB0R32r1evumoBc4gfXivpR0WNbJicyXDBujoK80rkwHygRnHLNBUC3WS/bREBKxL95oaOSRWb8DSiKs8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=VuZiaUHX; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=esCVtQDV; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60871PFl3780187;
	Thu, 8 Jan 2026 09:07:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=nNX0AONehQsubIUtjW4E2qsMB1RZKgpPY1UrSDI87fg=; b=
	VuZiaUHXkU/hnyOH7YyB5ESqPF6BtjkMEoCbAhwpeScyLi+1hsyWc96I7b3tDfyl
	JIwnT/vzZoiFqwKxNCaEkuMOu9oCMkR55RlpXETXxpbGqL2vV2zPTQlwhzzARwYz
	qoa64n85q0VzpjEn9Xe6Q/Us0hiOBf2c39fsYokm28N/TkeFDfxkxEDxhnR/nI1M
	aibRhh/zv08/pEYlzJkc7UBi5/YqZSFEBx6wZyqwUAwh6l6Nd0LWD4+4BeivILNe
	3p1WtvdSwo2A3m1+9n/IdTrfuHkXJRjKFOpqdlOh0mJJApAhQ3FprZlKvmaKMZYS
	1TFaXEsC3NjGJGpjtAFzuw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4bj7tr03mx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 08 Jan 2026 09:07:49 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 6087npVk030838;
	Thu, 8 Jan 2026 09:07:48 GMT
Received: from mw6pr02cu001.outbound.protection.outlook.com (mail-westus2azon11012045.outbound.protection.outlook.com [52.101.48.45])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4besjew0cx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 08 Jan 2026 09:07:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=swdWnUNL1Ewtnm3wSPnYxhRqXr5sLK2zLLQfsT2oZC68fdZ7NwrUgl/OtX9OixjhAmbQXo9CGjxOqCM/ZybFdjPZLWn4HJ6JZIO0ZmdvDMzzzB/Y3KJdPOdYhbZ04SUk2CkwGvJh/xDrRGR8DDyzckdZHDPqo/3lGnn9Lfp4MEO+VsnuAavC+KHhqrmEYvxonNaBuJN52moKU+MbCXZ0unFAy/B8U9t/fehgrBW3QrNBEFfBilygeuSD5z7hongc9uh70kXjRiH/nkM8HPRyCLB7IKPIBBDRe1LDvTKsONAe/s08WLrWGx+mwKOlrxEf4n/m6/bQIgo+0E8iqrJw8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nNX0AONehQsubIUtjW4E2qsMB1RZKgpPY1UrSDI87fg=;
 b=pXokYs1Kvh6Fj+QQDuPhmmDqnsh7QpxUan/6E79zlfxjjO/Zg8Cc0GRowFUzQGuOzqMLtQ1BFLh8IUCUsEd40fpT4DidsAZkLkrLdltgc4JdEdsYc/uaa6KtqD+1O9UgJPD7D+QcjpUnkTeg1PqSsmCjY+1cMRh15jCXFlo423CXXt6i9JWK+WM9zG22vFRMMX6zBwwtrKnWrpgJi9yb9TLmajo0kj1enXjwboYP5XgcJUFoLGBJp6ef2+1qHxIgdJZ53Pl61QKYPiaL6ONpaO5T2w6BOF/PBuBvUmCSgG9YVHJ7QS2MBwxGW5JtFgTSwspt+OU0Hh/f/Ci8Wu3UHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nNX0AONehQsubIUtjW4E2qsMB1RZKgpPY1UrSDI87fg=;
 b=esCVtQDVGzrsgxxMrfEcdAL2Pe7UuXHiZCPdhPyw4My0ziaXitGn7xkuKCz6C0QzXny6G7t87bpuXqlD9h8ZErb07cPrs+x35oXAvae3H9CYuC1ToMKNXXTPdkROyNtS6p8XzgzOR3jk4OBcyWjbIQ4Y1YtwR2c3FjVFf1BH0Hs=
Received: from DS7PR10MB5328.namprd10.prod.outlook.com (2603:10b6:5:3a6::12)
 by BY5PR10MB4291.namprd10.prod.outlook.com (2603:10b6:a03:207::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Thu, 8 Jan
 2026 09:07:45 +0000
Received: from DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c]) by DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c%6]) with mapi id 15.20.9499.003; Thu, 8 Jan 2026
 09:07:45 +0000
Message-ID: <99647efb-537c-462e-bbef-a3c01ef1bd8c@oracle.com>
Date: Thu, 8 Jan 2026 14:37:38 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 07/10] octeontx2: switch: L2 offload support
To: Ratheesh Kannoth <rkannoth@marvell.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, andrew+netdev@lunn.ch
Cc: sgoutham@marvell.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com
References: <20260107132408.3904352-1-rkannoth@marvell.com>
 <20260107132408.3904352-8-rkannoth@marvell.com>
Content-Language: en-US
From: ALOK TIWARI <alok.a.tiwari@oracle.com>
In-Reply-To: <20260107132408.3904352-8-rkannoth@marvell.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P123CA0060.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1::24) To DS7PR10MB5328.namprd10.prod.outlook.com
 (2603:10b6:5:3a6::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5328:EE_|BY5PR10MB4291:EE_
X-MS-Office365-Filtering-Correlation-Id: ce6b4f9a-6ce8-488e-9876-08de4e956312
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?U0NDRUYzS3hvb0lub0hsRmdRSEVrZVFTN24xWktVemdiQmRmVWQ3b0wrWDI2?=
 =?utf-8?B?SUtudXQrUU54RldEelA1RTVYSTE5Tk9waDR5a0ZFblBhM0JSWXhaaVVSSExu?=
 =?utf-8?B?cU9qNFhpZW5tcmFPbzI5aE8wZk1jR294ckZkOFI2K3FBSnBibXhJK2tBa0Rn?=
 =?utf-8?B?YkVReXAxeEV1ejA3RGYwbHMzV0haZ1BSMU8vK3o1N3hTbUhTbWZ6K2lLeCth?=
 =?utf-8?B?NUNuaHdPS2ROZExIOWJ5cFJwMFFCUXMrZFlMMlBxV0JzVi8xMEd0aVRrTXJH?=
 =?utf-8?B?ZisxZ2EzV1dvK3JEYTg5ZHdvYnQ3QmcwYjd4cTN2SitQQmxIVzVMSUp6dlFS?=
 =?utf-8?B?UDZVemlqK01MdHpMUlZRbktGZTVwYmpDMDJ1OEIrZnROSEMvejMzUHV6SmVN?=
 =?utf-8?B?ellwQzVzL0p5YUVaNXRnd1ZWMk5ka1hwcWE3ampNbzgyM0hUbjVRVFV5Zlk3?=
 =?utf-8?B?QzdRVENtcHVkNkVIazhrQkhQLzZaNHZFaTNXQXpaMU9HWmpac1FoeE0wdDEr?=
 =?utf-8?B?TnpoZm1wd09tWFBQb3p1M1Q1R3NoTStwVG93NkN4NmVvSksxd2tjQVVQRlZ4?=
 =?utf-8?B?Tk1IS3h0Z1JySUg5ODV5MWFaNmJHTHNESzl0bmE4RndpbElVZ1QyVy81bUpw?=
 =?utf-8?B?MUo5ckhJZzRQU2hLczhMVE42YVJwWm41c2NaN1h2UG5wNzRkamZ5TmwycE4y?=
 =?utf-8?B?SzRXNUNRQ1lyam5zZ3JNWnYvNWQwYS9PM3M5NC90YXpyZ2txTGxyM05pZGFQ?=
 =?utf-8?B?ZEx0VmFFUVZ0cnc3VnhWVEUzNDVKN2RwZitBRWxNWGtqd1g2WkRvYXNJWTJw?=
 =?utf-8?B?WUZSQTR0MWkyNjdmK0c5eVZMN2JxcHNHVmd1VmxQZm8yUDh0UGhHOWFGYUpO?=
 =?utf-8?B?WHJLNzdXUVd0aktEYWlLdVpIaUlmOUZjUEhSTkcycm96amRqcm5zL3RFdlZq?=
 =?utf-8?B?blJlUEIxR3hVZDc2d0VtUHJDdFYrNWVDQzAvMW1JQkxXVmdkZWZYdC9SN1Fy?=
 =?utf-8?B?RjZudFp3TXc4L2N3Vi9MSkxSZW9ZUG5KdUJMVVplMkN1OUNJSTRWeVNJQnVm?=
 =?utf-8?B?bER2dHFXUnpMRG9FdlBuYXcwNEtDSVRRTkpkQksxRHBUN1pqT0N3OGhDdndZ?=
 =?utf-8?B?TU9DVFgraDJxK05JYjczeTVLaE5oWDF2dndJVEk4aGpRU2dPRldYanQ2WXg2?=
 =?utf-8?B?NGFBUmh1SDdjbEg4QlRQbDVJZjU3VEhwZ29GNFZBaCtpVVovZWw1aXBSbWh3?=
 =?utf-8?B?cUVUSGsvKzdtMWhpc0hTMFhhUU9jaXhkVTRZbkVTT0gyZVFyUWFWeC9qWlNP?=
 =?utf-8?B?UlpSbkg0VSsxdVB2WTF6ZUlQVWVyd0dwOGZPdkp4QnJvSmEwVkJOOUNBdzRn?=
 =?utf-8?B?R3lvbGZyUUN1R0U1NFZCMXl5bytUeVhOVmxkdk5nbk15SVNUSVZySFJOOUg2?=
 =?utf-8?B?QzdLZGljTldKb2pBei9KQlhBaURjdU9rZks2UTRWWUpnblpEZ1VNTDVjY2g2?=
 =?utf-8?B?ZVY5bU5OUnRCdVh5cUd3T1JIekFxb3czT3pTM055U1lCb25UK1ozNlVoQWJI?=
 =?utf-8?B?TXIxc0IrcTNuV1dPTG9WRDVGTm5KN09aSHFKdWtjdktLVzRiTlZzbGQzSE9S?=
 =?utf-8?B?bFhOc2NQMkxSbW1uQ1o4TDFZVmNZOFlOZ2kwNjBDYW81L0UzNWFTNWsxaFll?=
 =?utf-8?B?WmE0MVJ3MXpJL0tUM0oxWkZ5QVF3ODlNQ1JaUWZvN3ArdlJYOTRzSE8wTUxo?=
 =?utf-8?B?d1pjQ1pNaWIyU21EYnZYdXdKMUE1Sk1HanZhTEw5TCsvWDhqazNzM0FnVlZs?=
 =?utf-8?B?Mkw5bVUzdmdhY0NNUlppVjJsa2hLYzVWdERyd1VLZmVuQnA0L3NIdmpDMEVx?=
 =?utf-8?B?dGs3OC8xSXo3eTdLc1hvejVzcURtUGF4SVNXZ01ZMGUrd2xrY2RKL3ppbDNa?=
 =?utf-8?Q?t30wzyRKNfQBNVuytvzy30caOLkZoWSJ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5328.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?THE3WktFby8zTktrNlVwMHUrOWZqOFVIR293ckZ1MWxJWWV5dVB6bzJsZmhK?=
 =?utf-8?B?WXRtek1OSEtmVGxWMEsxaW1aNStjcndvak82bzRLallWWDJSMXlXcHlFQTN4?=
 =?utf-8?B?V3UxV0h2MTJNc2xZeU9zSCtTaXJhUGV3NktjanpaUThxaUJoS3grL3hHQmJp?=
 =?utf-8?B?ZFhlbUdOOE9PNm1Jc2xiVjR1Y3VrSXhpeDllMDBrSjlZeGYzVkdlWWxubXZS?=
 =?utf-8?B?VE1YTjNYbkRmbVdxemZ0aWg5N1BnWE1LYU9ueWhwU2VJcE1TQ2M2SG10bGI1?=
 =?utf-8?B?L3pzTFhjYVI4SThwY0ZMTDkyQ3Qwck9nMzVRU3BOT1lVL1ZjT1hmU25zYjZ2?=
 =?utf-8?B?MjhvWHpMZXdJTnRDSWhFTmU2N2w1YSszeVpIOHppV1R4YkZXbS9UcVNKdlN4?=
 =?utf-8?B?Q1Y2OTRTVnVTNEpobmhseWpCamRQS1RJc0hSRlZQdmR5RExzUGhHSGtKZ1hZ?=
 =?utf-8?B?Ri9Bd3pxZVAwWlZKc1Nkak9DNmNIVjhTWldGOHdhbEJkazIvMGJYenFLTGV1?=
 =?utf-8?B?NTFHeHQwMVdpdlJFUENHQUF2eWlTYzRkTHJHdkU3MVpvN1NDT3FPOU1STDBi?=
 =?utf-8?B?K3B1T3dGR29hdGdYT2cweXVhNjRYL3hESUNxaWRYRGhDTU9GWXVldEw4cjhB?=
 =?utf-8?B?a0JxZ2cybWhwU0M3WFIyUm1XeGRCejhIYi8razZMWGxrWmRsajZLdWN5MUxS?=
 =?utf-8?B?UE53TG8wVmdqaUI5Z1BXblo0Z3FPek1odk9vSFpOKzJFZ09CbUdrUXQwNFZP?=
 =?utf-8?B?aGZHbDA0Z1lsUlM5QTNJTmVES0ZVeFYzUVh1b3ByYVFBQWJSVjZuL2Z5aXV2?=
 =?utf-8?B?Vk0yNDJ2SXAwNlRHajB4LzJRajZjUkVWYlBkZFlFR25ubXlTMVFNdEFjTjM2?=
 =?utf-8?B?Q1poR3phL2hsMHhIS05BRVhjKzhNWWkyRzZ1a2kzdjRPU1pNWDdFc1dDREZh?=
 =?utf-8?B?alVHV1NVTWhjMmdBSWFVc3E2ZmI4d3FMeUZpdmpzTm9rd1kvaHZuRHRvTUNi?=
 =?utf-8?B?elhkN291T2ZTdS9QSnVBeEFwbVgwdVVEelZPdE1HZ0FDdlgrUjUwYmhoZTJu?=
 =?utf-8?B?ZUZzVjFRcVQraHlmTTB5L1JjK0swb05zVHoyRnBIOTNjTVpHZFZocGdkQTk4?=
 =?utf-8?B?MFB6YStkZ2JoNmkzYitZZjNzaUV5T3c2ZTBERnpHMUNzUEY0bFZLUWFwQmF3?=
 =?utf-8?B?RENzTlZPWU93M3I0d0lzT0ZUd0IwSW1SbTcyZjRWVmpyRkJRRjB5bUE2UGpC?=
 =?utf-8?B?WVI0K09ZRGdJV1orYWRNOUxDTWxlaDNkcDBIU091S2V0OEZLK2JqSDQ0blFi?=
 =?utf-8?B?eE1ZYmZnQnk4RzFJcHB0TUN5VWc1bHZzR3Zmb3JNWVc4NGxFMExtaFRKZXk1?=
 =?utf-8?B?SVlBa1AvMU80d2x4RFBxY25MU2g5YnVRLzU2eVk2WjVzTzdlVVNWdVNDbWJ1?=
 =?utf-8?B?RnFxMEtHZ1lKTGsxRzZ5bEJ5TSttaUNlU0pZZTVDeFVPS1BNQmFKVXZiSktC?=
 =?utf-8?B?OWNMT1N0RjVvWjVEZGV0NUNiL1BDTHM4SEJsUzJzdDZkdVdxTkdSZjlnYmlU?=
 =?utf-8?B?YmsrS2o3NVhJcHV1a2JBenhvVU42VFp2d05CUHIzdm9uNUluQlRteXJyT3Ax?=
 =?utf-8?B?dk8wdFdSclF2N2J2b1FmTkdvOEVnc2UvbVFhYThBQmZnQmpaWFRzVjNIWHpY?=
 =?utf-8?B?eTdFYWRxeFRydnRKQTJ6RjlDcFhtRHc0WUZPdGhkRDNOU2lwdXU4alZMRUN6?=
 =?utf-8?B?RVFrYmhJS0tGd3UwS3FHZzExZEZIQVZ4dExya2RhK2FYOEFvWUtUSmUrVjdv?=
 =?utf-8?B?VGpGYytlSTNHTzFTNnNlMHJRSjNMTVF1MHk5cUN1VkRYTTByYnVabHpTZDhi?=
 =?utf-8?B?MUViUUpBV1h0UEFCa3hUVTh0U0tEN0pMWDY1VkNqREJSL2RiWFlNZk1Ndkl5?=
 =?utf-8?B?Z05STUxYZ2Y5bjFVWm43QWZIb2JCV0QxNVFNRStWMERBd2VuZk5xUWRjWWg0?=
 =?utf-8?B?TE1GQmYvWnBjWGFjRFJMR01xNmU5MjJEOFYweUVLUjJtY3FGcGZtUTdsS1A4?=
 =?utf-8?B?aWd0UDJUWVdJN3ZqOWtCOVcyQW5DdThLYjJ6YXVuNnMrMkhrQ21kaHJXUU1O?=
 =?utf-8?B?b3ZKbGhoSHdud0lHYXRpR3ZCRlhZWUxaY3ZjdkRTcHQxUGpIR2JiNXY1MGpJ?=
 =?utf-8?B?RUxmdG5nU2x5YVRtTHpHTFpCelE0WWk3aUVMWUVJbHdWOGVuUlh0VHp6bU5W?=
 =?utf-8?B?TVd2SVRsQ1FkZmhMaFVpaHhkUWhsY25SNXlJN0lEMm5HN0RQN3plV0ppaSt3?=
 =?utf-8?B?Um83S0NLRzkrZ1A5QlhyZFdqbHZCMkNaUVdORFFFZWExYVUraERSSXZpNUMz?=
 =?utf-8?Q?y58AhosCAtkG96JA=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	kG3tx8RMWHOQFuMHy7mcysSQayAT9N8SseJw+jrpvUFatxF/8nxiO4YIEbWOK4TF4DIQfw74qpVHT29y4tMzU7p9wenKumrQMjUKpTE243keXMRtzXvj6V54+//wSJmJXR7disWKzc35hgGJvql9jAtt7Uyj9XjNmlhlnD+aCHBNFkQTiNvna4bYFNyCLo2NFztDe4KJkVbk2khoRbKxXTjYvbcWRoOQqnPrwNoFZ4gKFSg+X5DMNA9mgglWyJVmJ93K3Y6GUa9iWJa6O6n84rENroxu4yGC7GbnUNR4XDlaOx1ftryCzovS/oRWNZaJFPmId1bXe1TkgOVa/gZPXpNDYu9jcGTMkpU3tPT/XkLxnq34AkvQ5p0PkXYKNZzjlD4jtwnQ8giK6hwmB//zSTJ2D/o5F/eXL/ddUc/3Xfa4oxuKUEBJ6M9GfR30x5c2qEJTLYSSBV0uqwHKG8QOlRjaL5g3+g6pTqdamhdl3YvZbi2U5vinJ/v0K4OMjqIb9QlRx3yHvjfiOhSFC1FRcq43f7TsFDEzgATUvJ4JFEEowvxyBMKyZ7AoGiumjp1Ypi2yG0jcyO6qXtT+0XgUn0bdLNh1nA2OtegHBnfTZrY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce6b4f9a-6ce8-488e-9876-08de4e956312
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5328.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2026 09:07:45.5463
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RsKdso60sukIgerrGEZx/dSkySxdx7hNkigxn5NhSd4BePnQeoeVOx4B9sERj5ajxB5DaI5qqKaVsO4iJ3O86wEFSRpU171vvzxQ5ZZ45ok=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4291
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-08_02,2026-01-07_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 adultscore=0
 malwarescore=0 suspectscore=0 mlxscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2512120000
 definitions=main-2601080061
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA4MDA2MSBTYWx0ZWRfX/Zl0OCNc7sFG
 S3Ym6pBYbU0EilA1TbeEZgVDa5mF8Jpmapj7u8+ZWXZDybWqT1cCsRSbS2Jn8DuSGKDS3m9AkB7
 PhMHLn497wVpvBOIMkK1702g3O2ooOyJ6wPiczptHOkxlWjO3gmmOY7LizFBUlyTuvstJ7teqmx
 wKa0wxT5CpzGxiqKfBVUFhIBIPk5ZRyqcQJ8i/Qy0kuaKT6RyxBFEZNbIdxulS7CEpONKDACxg5
 z+5nqIcY46iB39NSyM68r8cvB0T3CO15BR97LNXKXn6npLOiLwqEfndtakbmhD+vzS/43O8f5E6
 iM5qyDBx3vU9kIeoGsu9zxPsoUzbVPwFDnFVw7UNWxsDi+OSSPfnD+IBkF2GDUZYqlhFwWfGitr
 7IZxEE4jfKcfPCgeZS+9yIovXk7YgQmfN/fpe6uwWVgEKgTi9q7T2q5f2BWl/cochakMoaPayyv
 9Wr9g4ZmIhmZLuN4VAWHe4u9a9sGPDrOOPsz77Xk=
X-Proofpoint-GUID: nEl8lMfGDH1xOEx60wEw7ODP1RHJxWnS
X-Authority-Analysis: v=2.4 cv=LN1rgZW9 c=1 sm=1 tr=0 ts=695f73e5 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=vUbySO9Y5rIA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Fq99xjXByLZgPzlzTk8A:9 a=QEXdDO2ut3YA:10 cc=ntf awl=host:13654
X-Proofpoint-ORIG-GUID: nEl8lMfGDH1xOEx60wEw7ODP1RHJxWnS



On 1/7/2026 6:54 PM, Ratheesh Kannoth wrote:
> +
> +static void rvu_sw_l2_offl_rule_wq_handler(struct work_struct *work)
> +{
> +	struct rvu_sw_l2_work *offl_work;
> +	struct l2_entry *l2_entry;
> +	int budget = 16;
> +	bool add_fdb;
> +
> +	offl_work = container_of(work, struct rvu_sw_l2_work, work);
> +
> +	while (budget--) {
> +		mutex_lock(&l2_offl_list_lock);
> +		l2_entry = list_first_entry_or_null(&l2_offl_lh, struct l2_entry, list);
> +		if (!l2_entry) {
> +			mutex_unlock(&l2_offl_list_lock);
> +			return;
> +		}
> +
> +		list_del_init(&l2_entry->list);
> +		mutex_unlock(&l2_offl_list_lock);
> +
> +		add_fdb = !!(l2_entry->flags & FDB_ADD);
> +
> +		if (add_fdb)
> +			rvu_sw_l2_offl_cancel_add_if_del_reqs_exist(l2_entry->mac);
> +
> +		rvu_sw_l2_offl_rule_push(offl_work->rvu, l2_entry);
> +		kfree(l2_entry);
> +	}
> +
> +	if (!list_empty(&l2_offl_lh))
> +		queue_work(rvu_sw_l2_offl_wq, &l2_offl_work.work);
> +}
> +
> +int rvu_sw_l2_init_offl_wq(struct rvu *rvu, u16 pcifunc, bool fw_up)
> +{
> +	struct rvu_switch *rswitch;
> +
> +	rswitch = &rvu->rswitch;
> +
> +	if (fw_up) {
> +		rswitch->flags |= RVU_SWITCH_FLAG_FW_READY;
> +		rswitch->pcifunc = pcifunc;
> +
> +		l2_offl_work.rvu = rvu;
> +		INIT_WORK(&l2_offl_work.work, rvu_sw_l2_offl_rule_wq_handler);
> +		rvu_sw_l2_offl_wq = alloc_workqueue("swdev_rvu_sw_l2_offl_wq", 0, 0);
> +		if (!rvu_sw_l2_offl_wq) {
> +			dev_err(rvu->dev, "L2 offl workqueue allocation failed\n");
> +			return -ENOMEM;
> +		}
> +
> +		fdb_refresh_work.rvu = rvu;
> +		INIT_WORK(&fdb_refresh_work.work, rvu_sw_l2_fdb_refresh_wq_handler);
> +		fdb_refresh_wq = alloc_workqueue("swdev_fdb_refresg_wq", 0, 0);

consider, "swdev_fdb_refresg_wq" -> "swdev_fdb_refresh_wq"

> +		if (!rvu_sw_l2_offl_wq) {

Checks rvu_sw_l2_offl_wq instead of fdb_refresh_wq

> +			dev_err(rvu->dev, "L2 offl workqueue allocation failed\n");

offl -> fbd

> +			return -ENOMEM;
> +		}
> +
> +		return 0;
> +	}
> +
> +	rswitch->flags &= ~RVU_SWITCH_FLAG_FW_READY;
> +	rswitch->pcifunc = -1;
> +	flush_work(&l2_offl_work.work);
> +	return 0;
> +}


Thanks,
Alok

