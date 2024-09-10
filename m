Return-Path: <netdev+bounces-127101-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 298E19741DC
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 20:17:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A56A1F27330
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 18:17:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 335561A08C4;
	Tue, 10 Sep 2024 18:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="nWMUY/FV";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="d1Izyt5r"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CF54175D4A;
	Tue, 10 Sep 2024 18:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725992242; cv=fail; b=qWPc+0Pn61wvaMBj4EjbY1VuadsQo8X/pW5n5+GloY9aYoVjVTJ5qA18Zkz1JvaSSt9U1bpV5JWLE08fZOe3EgVOzfO+j6HeDTSxDuAnBWTUM3YKoC19AIyznW1Nrmg15vt54MVymNPGavCLPKdl0Jj2RZh/Vpxgs6ZmR2B4DqY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725992242; c=relaxed/simple;
	bh=sqi90WRAG91gNZ2icHvaayrUPioA7/Tz/kVwybK2FcI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=oLjalaRaskO5ZAZKreqjS08ey/QPH6ywBNh6bFaIaM+/CGs80oiD+JQsb4kIYV09BCi/L8k0MXY2yB5zSwrDC3CChoH90Y3JG3GtU+lcgAvl/D+diDS26dgztcccES/gjLDqc1D+4tcdj0eFznKYsg3+cKjpFwoBrNovT8bU2YY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=nWMUY/FV; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=d1Izyt5r; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48AHNauf014807;
	Tue, 10 Sep 2024 18:17:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=qeSNQ/GhlMQR2PiT766gyIPJ9TSVJiBG8eBzNqyzoIo=; b=
	nWMUY/FVpLBq+tw3WpRyDHs6wUSQg5XRncWm9rffodxjzDIPDLyhsnM5LMFZn5UX
	4LxnZh2vffojSGrZpKn6KxzyK82Ja8ytZR97RniOfM75c5l5U4D61YRVQRASO7ul
	uZYfBcgYXOaUOCqTnXKCTpxIZn0XccsJmXAH98DtFRPi0l8d7efP53bqKrdjWgan
	kF+Au74Xx1RCAEUm1aS8HIsCK4WikXB/DKEBz7cjvF0Y49T2oMiARThaPODcYGb1
	5iUPzUQHRgIy4cDfllpo4dWmPy+5FLAeLaLp7ctO4KPFMmgSrEy00bAI+oK952aT
	5oz6YVmn2aWhhr7J9SF2Gg==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41gdm2pb4u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 10 Sep 2024 18:17:08 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 48AHa0BP035580;
	Tue, 10 Sep 2024 18:17:07 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2048.outbound.protection.outlook.com [104.47.73.48])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 41gd98ym91-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 10 Sep 2024 18:17:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fso95Fq9JfaiqTixzqQ2Inx2YnFV4ZInrwKixVvmhzS6ioFIVxEDGNrzPCcEw/py3kD36VedD7gfVA6w4nFJjUVcS4JIPcRDhf1BVNMisevM5vl7rfpl/WNXWdtmXBhd9eHVrEV+6TaWIRPppg2wyMY/ONix/5jFlHVf05wIUyAxlnXC9yKY2I4OgpZGhJqdCePkCGtKWjpZuUb7z+xGY4wlNfuROItug4As2ov2/fKxPGw15vzmWvXEVQXNKm/lYGsUtmesuebBCRxXPVDsHANcnX7djR0BlIrX9vCrd6T0Io++TE12ZtoUZSMEE7N0y0u0JGi/9ITAgcwJjyNUAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qeSNQ/GhlMQR2PiT766gyIPJ9TSVJiBG8eBzNqyzoIo=;
 b=xAq+R/BBOJTIyJHGQl/zZaiuXDE8JUvqNlHgU1Vm9kW4VeuzfLgP/bqrkF4AfHUy1uLWgPjEuNGmk6TPTwhkk6ApnWyHasrYNAc/icKXxzKM++g2+KoyIAJaLuMlzQqtEh8oXuZdzN4o6g/2bpgTN+RS4w4Eh+KxYl6qcdQg/N9HeqkMZNGaeaZjy/3wXiBoJPdWDK5WONT1VQlFZxAynQy73TPhhO1XOy8V+S1L7cabT0sBdc7x2rPYcPfCPeAwpyDjznGx8SGcbQE5Fq9fJxsXvRX1EIKCKIRzktPJgXjGlQwqQpwuawnFqaKYJ6n70TA8o8Ad98quzPHzK8MmMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qeSNQ/GhlMQR2PiT766gyIPJ9TSVJiBG8eBzNqyzoIo=;
 b=d1Izyt5r6gwma8NfrzGm7bsjfUN5cqBlh4D9HNCAcBIIeFNNZIkJYctqF6WBaU3w3CJn95ERFntBSEjbdSeMjP9lOjtOJMDgfNnvL9SS6Mn+yy5W7MPlujAYVlVoONl7ARJNvfNsDG1rDSRPuysfUgaG9zAXTjAjcUEH0eFoZA8=
Received: from CH3PR10MB6833.namprd10.prod.outlook.com (2603:10b6:610:150::8)
 by DS0PR10MB7980.namprd10.prod.outlook.com (2603:10b6:8:1b9::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.14; Tue, 10 Sep
 2024 18:17:01 +0000
Received: from CH3PR10MB6833.namprd10.prod.outlook.com
 ([fe80::8372:fd65:d1ad:2485]) by CH3PR10MB6833.namprd10.prod.outlook.com
 ([fe80::8372:fd65:d1ad:2485%6]) with mapi id 15.20.7939.016; Tue, 10 Sep 2024
 18:17:01 +0000
Message-ID: <83913196-1240-45b4-9d7b-6f5dffc528c6@oracle.com>
Date: Tue, 10 Sep 2024 11:16:59 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [net?] KASAN: slab-use-after-free Read in
 unix_stream_read_actor (2)
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        pabeni@redhat.com,
        syzbot+8811381d455e3e9ec788@syzkaller.appspotmail.com,
        syzkaller-bugs@googlegroups.com
References: <943f2045-a89e-4d00-958d-e27c22918820@oracle.com>
 <20240910175737.78567-1-kuniyu@amazon.com>
Content-Language: en-US
From: Shoaib Rao <rao.shoaib@oracle.com>
In-Reply-To: <20240910175737.78567-1-kuniyu@amazon.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR02CA0050.namprd02.prod.outlook.com
 (2603:10b6:a03:54::27) To CH3PR10MB6833.namprd10.prod.outlook.com
 (2603:10b6:610:150::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB6833:EE_|DS0PR10MB7980:EE_
X-MS-Office365-Filtering-Correlation-Id: 15f2631f-7e01-43d2-9f39-08dcd1c4c407
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QkgrOS8xZ24zckh4K1l0TGV0MDZBeXVtY1JXOC9CTUpIdmRiUW51ZUdsd2Jw?=
 =?utf-8?B?UXJuODFabnEzL3ZQR2I0S2lRcFFNdHYzbUh6VGpBZENsWXNnSWtUTk1lNTNR?=
 =?utf-8?B?bmROWEcyWTl0ZlczMkxxKy9xQVQzNlhvMW5obC9keUxOdnA5N3RYQmEzYmpW?=
 =?utf-8?B?cXlua2JUd3NaOWJIcXdqSlFuUEh5aGU1Zkh2QUVneXg1Sll1UDQ3aG5FeTBU?=
 =?utf-8?B?bmozVlR1bGxtZ2VwajBBRXBzZS9TbUhHanVKRDZKZjkySVgxS3ViaUdwa3Nq?=
 =?utf-8?B?b2FxcGxISmZaQ1VqbVJEUUY3VHZ5d3ZZL2lPVThmc1duVlRobnRkRHFGS041?=
 =?utf-8?B?TVBhTTJWOU4zOHgydnBGNVZXVnJzcDQ4a1d3OTgvTFgyMWI0M21jck5KYUFy?=
 =?utf-8?B?T002Z3ZMU3NsREtUZ1QyS09XTDZrajh2dWlyVW5tNUg3eTM0QmVxTUI1eStQ?=
 =?utf-8?B?bXY5ZkVOWXBCSWszSW9LdU1hY3pXdVZ3TEFLSjd6NlBTV2RyLzBVckMvQ0Fx?=
 =?utf-8?B?VytyYU5LREgwR0Y4QVAra3JURW5uQ1NMeUhZTE5sM0lwWWxJc01ZKzEwUWtX?=
 =?utf-8?B?U1VHTFpvbEtMVE9UM29rbzdqZGFxK1ptWWgvbFdkb2M1YUxMcWp3cnZ5Mk4x?=
 =?utf-8?B?eW5md0tlUDBQMHNUZWtNb3JsdWV2VE1zTEJEaXh3elIyQzQ5SVArR1JtRXJT?=
 =?utf-8?B?dGNPM002S09veUpnNjNDVUNCdUtkeTBUNkdRSmp2cGRJRVlWa2FXdWc3ZjBv?=
 =?utf-8?B?MW9MSWRYU0NoWjhTWWZVb2JsMXdzZGZYVnUvcnF5NURlSmZ6aTlmV3V0anhp?=
 =?utf-8?B?bzZmai9QbldDS08rYlYrWmlaamNLK3Q4aWl1akNOd0FjNVJOWFNMZE91dGd1?=
 =?utf-8?B?L0dGRUdlcDg0L1pDUEN5dmZFUHFJazVQNURuczdJMldiTno2UWZ6OUNTZUxw?=
 =?utf-8?B?ZENiUmtXemVXQjBUM0s0TVAwa21RN0NUbEl6V3NwaU1qeDB2aGI0eVhxQjNE?=
 =?utf-8?B?MjhsdmFkRGh5TUhKZXNWaldQZmF6UGlkSjdLK0JmbVRmRmJZakRlYTJrdmhp?=
 =?utf-8?B?enU5anJ5THNydVkzNVBkOVJZOEhiRC9keXRIMnY3eS9ianYwcXl3SzlHSGxt?=
 =?utf-8?B?Q0ptVzZpdkpGZ0cxNmlnL2pHcC9aeGhLS21FaXZUZVdnRXE4RHI5eUI0UjNQ?=
 =?utf-8?B?SkE1ajR4Z2doMFNkMFpXSzFUMDhjejJ2MFhrZTRwa3RJc2R1V0FSbVVtWkph?=
 =?utf-8?B?WWdWQzFsV3NwRVZ2MHBBY2dIU2J5SlBZS0FWR2RsN09qNll4a2tmZ0xkekNi?=
 =?utf-8?B?OXh6QnJRZC9QdjlLQ0hmUUg1dWR5VkgzRDFsNDQ5bEN3MUhsWXcvMjc2UC9M?=
 =?utf-8?B?aTBYaGgxRStKcTZ1NWRiMStmbnRiaTl0b09PRUVBV2V3K2lsNjdGSldrb1BZ?=
 =?utf-8?B?alNOK2NjV0xiYU5GKzNTY3hVME0wYUxvL0pScDZONHNNTkRmaCtHWWZmK2pt?=
 =?utf-8?B?Q21DMDltSDRWb1JaNE1tRHBncTZ3cUJxSE8vTXNyd0hJc01kZ0xRYkZmdDJ0?=
 =?utf-8?B?dGJDS1J2a0RKS1dKVWVpRDhEK1pRd3IxR01UTHEwNXFlRUNsUnJ3RVJFa1dB?=
 =?utf-8?B?ci9lbUVzbGJKVkZMYkZMNXhmby9EMDFWMDBxdFpuWEpXRnNTZmJUS3YrYXBm?=
 =?utf-8?B?K2ZRb3gyQWt3T2hLVGo2VyttcElQdWY2a3UxbEZ1MWhCSk1LbWo1M0txRzBJ?=
 =?utf-8?B?NlJXTTdzTCtTamI0QWd5RXlXZnZIbmhDMVY2dWhYNnVIWlBCVjZuaHNaUEJV?=
 =?utf-8?Q?E/lPPAC7sxP56DCEiWEFLCNxBGoHt5ixyzeHg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB6833.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dnJKSUF6ZGYyWDFDOTNLU0xOUUdJT1NBM1lsblBYWVNQeXRmMHpsRlRybHIz?=
 =?utf-8?B?UldxNjM2YzVNOUdhK0diUlh4aWUxZDZQazlYVFlBOW5zaVdlQlpva1paYWEx?=
 =?utf-8?B?QTNxQmlJL2NNdC9VM05PbkhXcktEQjZMOEsrWnlwU3JRc0lwcWk2eUJCak05?=
 =?utf-8?B?RktzYjBLaUltMHE3bTRNL3FJRXU1QjM5bC9XN1hMTTJQb2RZVTZqNWgrUUla?=
 =?utf-8?B?Y1N1MWVOREIvRXpVUWIrUVJWdzZKVGpaMkhQU0dSaTNnelVJaUdTaWZTQU1l?=
 =?utf-8?B?c2Fxa3JxK0dudTlLU3lra3R6c2F5M3Zhd3d5eU5FZkh3TlBOYTBFakRCU3Jq?=
 =?utf-8?B?YlBnem5BcTF4OFpzL2hUQnRNRWxIQmNPUkg0YTJRZTBJbDd6QWtXQTB5Sm9t?=
 =?utf-8?B?SFF3SFFydW9FTEJ4S01kU0hqL0xscDdURFlNMHIwdGdKUFRsdjc3emQ1Yzh5?=
 =?utf-8?B?aUpkWm56bEdMOEk4SmV0aTlSdmdYYm1haTRXbU9jdElaa0pPa1JBVlhlTk9Q?=
 =?utf-8?B?dWExamtNdWprcGR1ZFlhN2VOc2Z1STdlRTI1SUozWlRRK0xGZXhUcGdGdis1?=
 =?utf-8?B?cTVkMFdxSmc5S2tuOWpGWmJ3SkhRRFJjZVU2aU5tYmttanRnZW12NjVINTl1?=
 =?utf-8?B?WGdpbnZSZVI4WlJ5UE5YaXY2b2xWTHVVYi9Jem1rVHZ3azNUcHRzbFVlQkZC?=
 =?utf-8?B?QjVzWkdPb0hOTzRtSmEzWk1KRkhpVjVhYmhheGxXajJMVVBCcVg0eGh4VUFj?=
 =?utf-8?B?SWNTTlVBSCttT0hrL1dobDNkNkxFOUJZM0xBSUt1a0p6V1VEbUhLMTJ1b1hJ?=
 =?utf-8?B?QW16SXV6NEdVY3RPYVhzRFo3aE8wTUExd0NhRm5ydElTcEl2SDNEVEVXMkpN?=
 =?utf-8?B?TUpzcUZEZjNIWExHTHZ3UkMrSDFCQ2hOVjRqMk9naGhRMTNVckxkUzd4UDZ6?=
 =?utf-8?B?Y3hwZEhjOGYrT3N5Nm4xSEswMWN1ZWpHVWsrZzhxV0xaVlVNdkNqNHJTNzg2?=
 =?utf-8?B?cCs0OWFvV25xeW9oV0J4RGRJNThNd0xVRDhiTngrbEVBcGZkRmNjTEZzdGky?=
 =?utf-8?B?cG53bVpKRXhUbzBmLzVMZFI4Z0JTTXN6bzBxQkhTWndkaE11RkVmbHcrTURu?=
 =?utf-8?B?b1hndTkxbHN4Qm1FUDFpQWRYUzl0UVgrVUxEVFRlT3Y1UG4vM2kySVh1aVlM?=
 =?utf-8?B?ODlWKzkzaUdMbk1wTzFqa1ZrMGN3WU90bG82aWZYQ0pRbWU4NWhBTCsyaVkv?=
 =?utf-8?B?REc4K09rYVppZFJRUzRXbFhsRjVwQjZVWEM4RWFVWXZpNWMvcU5BRVZZRVFs?=
 =?utf-8?B?TlRZVENtVEp2a3FtdDR5Q3NmemVzWXJ2U0JteCtPN0VuZmNGMlFadFNlWTFz?=
 =?utf-8?B?ajJ0YjlXbGhXZkJST0FQbkRqSjdCTDJPZlBEWnRlTUNRdFRhS2taWnZJemV1?=
 =?utf-8?B?dlpEejRETmg5bUlKZDNYMEMzNnJ3UGRwUFpCMkk1elRXSGg4dldLK0xUQWFy?=
 =?utf-8?B?aWtRRzJCWlFBdjdYbXpvT1d3ZkN2bmVNUmFISGk5ZjdPbmxMcTZoSUZEQ1JO?=
 =?utf-8?B?eUtpYTZ3TkVIZytnYzloK2pwQ3Z4ekF6TTVzYjh2NzVvV05aNzlsMERxVklJ?=
 =?utf-8?B?TkxPWDg2bStKcURBNGJVa0JEYzNjMUw2NWJrZnZrbzM4Ym41WUp4amh4cGZG?=
 =?utf-8?B?YXNiL2xmUXJnRkhIZXdUTERVVEFlOWxlb2dycWc0cVo5S0NLa1ZnditQTXBO?=
 =?utf-8?B?aXlQU0l2cHpycjU2WVB3c2pibE1aVWRTYkRpcW5zcWxCQ05RMlBwZEw2ODY3?=
 =?utf-8?B?ZnprMlRlbnE3eVJsclY4akxDd0w2ckRWbXMwYTJYWnRMQUUwd0Q0aG4xOHZS?=
 =?utf-8?B?ZG1PWUxqQitwdjIzc3ozc1NTOU55VXBRWnNWTnU5dUdQdyttMmhjUEI3Mi9p?=
 =?utf-8?B?Y3RleTBTMDN5T3VPOWl5STg2bGJZMHR4WktjT3BnWUNjbVFibG0zaUJZRnNK?=
 =?utf-8?B?cFF1Y0E5ZkJPdm12MWRUby9XS1pQT2ZreDQrQmZJK1ljUlp4V2lndVBiM0k3?=
 =?utf-8?B?NFQ4Mys5Y1RzMGppclRKcjJuSFp2QUdTMW9VTi9jRlBXTkhTZ2Z4MUxLUHpa?=
 =?utf-8?B?Yjk2QkZkMjhBN3RUSGFsOGZJUjhkZ3JPak8rYUtWOWpBNUluZnNaNFZUdCs3?=
 =?utf-8?B?RXc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	NNz6TIeYOPcErmqy+yWTURJiNhjKlL7sHvdacpJKVO8KjHQMd8jkmLwGCjOMX7R2/QrG6JT3cVazp/FPe1gJeplIxkvfHzH/tMCbr7ctaFa8d1QtaRp8TDzNZe6ziL3dyzm1YrsBddUHIVwON4l51uI6u1V1esT1SV6GAa4lCZFCUd8vkiM1QBKAehNhUjL24GvKIIAaYwcdv7ND2b4A4FTAmd8XL3nLoxFnIMle7m3fhig8IM+QUWaLMSvoUYbO2qK4+uzx2Al7kYL/WZvRYjspFvckc3LA2lmjFX0IUcgdk0HiTkrSFMp9uFdu7WSP3lOmUeCgFFzFapVO+SlzkE5oRtdMvoQXF1thXUN8NgVIQpz/5YovJii2g3Q637i20tZx2gWxtF3PQvpfRf7G5Pl+F/qgTcKgTnhmIjdoYl2AwpWmYyN9KzulgkTYmDLot5TQBn1QVg213xF6YOidIf4iQld2GG0+EQg9a2AclLSYc5yokQSlefkpNS+T0ap20lQflwlFRNGg1Q29HyfORwWVeMzzeScxxfSDRqkkdFJkHZ7IlmEFsvhpI36vQj0TJGWXOEnrii8Uhg6cLGJwgTqy4QMw1pl+PWA3okPVJJE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15f2631f-7e01-43d2-9f39-08dcd1c4c407
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB6833.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2024 18:17:01.5020
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sENx2ylj1fUHUTAxaBDZUvo4HgjEAwujjqD9ou7WUGpnygB1dWhM/C2ZPLjb07V/DibbTBEX07llk2Jii3cn+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7980
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-10_06,2024-09-09_02,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 phishscore=0
 spamscore=0 malwarescore=0 adultscore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2408220000
 definitions=main-2409100136
X-Proofpoint-GUID: Khx-FmeKWMWmtibd-IQYd9fqhMuXbPyp
X-Proofpoint-ORIG-GUID: Khx-FmeKWMWmtibd-IQYd9fqhMuXbPyp



On 9/10/2024 10:57 AM, Kuniyuki Iwashima wrote:
> From: Shoaib Rao <rao.shoaib@oracle.com>
> Date: Tue, 10 Sep 2024 09:55:03 -0700
>> On 9/9/2024 5:48 PM, Kuniyuki Iwashima wrote:
>>> From: Shoaib Rao <rao.shoaib@oracle.com>
>>> Date: Mon, 9 Sep 2024 17:29:04 -0700
>>>> I have some more time investigating the issue. The sequence of packet
>>>> arrival and consumption definitely points to an issue with OOB handling
>>>> and I will be submitting a patch for that.
>>>
>>> It seems a bit late.
>>> My patches were applied few minutes before this mail was sent.
>>> https://urldefense.com/v3/__https://lore.kernel.org/netdev/172592764315.3964840.16480083161244716649.git-patchwork-notify@kernel.org/__;!!ACWV5N9M2RV99hQ!M806VrqNEGFgGXEoWG85msKAdFPXup7RzHy9Kt4q_HOfpPWsjNHn75KyFK3a3jWvOb9EEQuFGOjpqgk$
>>>
>>
>> That is a subpar fix. I am not sure why the maintainers accepted the fix
>> when it was clear that I was still looking into the issue.
> 
> Just because it's not a subpar fix and you were slow and wrong,
> clining to triggering the KASAN splat without thinking much.
> 
> 
>> Plus the
>> claim that it fixes the panic is absolutely wrong.
> 
> The _root_ cause of the splat is mishandling of OOB in manage_oob()
> which causes UAF later in another recvmsg().
> 
> Honestly your patch is rather a subpar fix to me, few points:
> 
>    1. The change conflicts with net-next as we have already removed
>       the additional unnecessary refcnt for OOB skb that has caused
>       so many issue reported by syzkaller
> 
>    2. Removing OOB skb in queue_oob() relies on the unneeded refcnt
>       but it's not mentioned; if merge was done wrongly, another UAF
>       will be introduced in recvmsg()
> 
>    3. Even the removing logic is completely unnecessary if manage_oob()
>       is changed
> 
>    4. The scan_again: label is misplaced; two consecutive empty OOB skbs
>       never exist at the head of recvq
> 
>    5. ioctl() is not fixed
> 
>    6. No test added
> 
>    7. Fixes: tag is bogus
> 
>    8. Subject lacks target tree and af_unix prefix

If you want to nit pick, nit pick away, Just because the patch email 
lacks proper formatting does not make the patch technically inferior. My 
fix is a proper fix not a hack. The change in queue_oob is sufficient to 
fix all issues including SIOCATMARK. The fix in manage_oob is just for 
correctness. In your fix I specifically did not like the change made to 
fix SIOCATMARK.

What is most worrying is claim to fixing a panic when it can not even 
happen with the bug. Please note I am not pushing that my patch be 
accepted, I have done what I am suppose to do, it is upto the 
maintainers to decide what is best for the code.


Shoaib

