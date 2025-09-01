Return-Path: <netdev+bounces-218861-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 41848B3EE15
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 20:47:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F410C4E34A2
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 18:47:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C49F86331;
	Mon,  1 Sep 2025 18:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="KhGHIum7";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="XGdJInNn"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2917469D;
	Mon,  1 Sep 2025 18:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756752451; cv=fail; b=VNb82pw5kkccPfaOqP7ukV4uu8QfT0/BPnZSQ8yB6S0KGMW36in+MfkCuZuwddcEohfEXJ663PIfcQoEarN4dwiIzk18MzR3Pokl7XsvR1g3XvNrzMzllaf+3yo0g5xveDhuiK2Cfd7bE9ow+s17aAP3ltpejcvTgN/6Pb2azwE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756752451; c=relaxed/simple;
	bh=zvxvwuKZVbbZd1jlSCB30kyhOTJPWqywGMpIgfN28h4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qD8E9WbnHUpn2SSrj+/KVNM1TsaUA30ftVt71RIQ5P3fuQkHh/xKPgoBQjp6MPrF4M8kBRObdhERopjRI7ghFv+Tmfd16zPuW95x0RFP1nUtB04giQUL/vEN3D2+gMxRbu2F6SBqUi8hMv9CwgDd8r0cxaoOKs0gCStS+QKuUwQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=KhGHIum7; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=XGdJInNn; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 581FMvY6021320;
	Mon, 1 Sep 2025 18:47:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=QjsSBQ5IU5Zhrwb5VCLP865TM2R8o5eOWWt7i8ND+q0=; b=
	KhGHIum71muN4mlcXY/Y28gSP98ot1BGFivdW2QmWXiN5KcosE21nq/3WALvSJ9e
	dgG30E5N1eaIkgWs2zVlvKsTOrfWyNhreVJRP+YyN8/s7N9JhchQ/4M5rm3odKPS
	Z+P1i+ojOMn9VyKtaMziGGSYCQCRUdzmhed+YYtBObEBJK8wpSiBmjDRs2Yu6Jx+
	nbdcAnhlO9/bAx7X8jcMfx9ARObXmY+fADPMXhlCXX6kYB06oYAQNteizg0c4Q3M
	3msQIQ1w8lEC6/uBzTshP99ZBFkdNtJcIvInArScta/BMk+XnKW7mpqo7BRXrqdJ
	BaWSjhbwURKnItbBho/MZA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48ushgtt2t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 01 Sep 2025 18:47:17 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 581G2IeQ026755;
	Mon, 1 Sep 2025 18:47:16 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02on2062.outbound.protection.outlook.com [40.107.95.62])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 48v01mkpy7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 01 Sep 2025 18:47:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oxGAXwPBXF+MX+MLHWEJBaMsAYI+vNG9YYszGNpIL7jsEhWVrtQ6WTCEwkokGaMw3B1n1h/tFN0s/3mG8tZl1Jx94/znEI6Jt8+jzFTJAigNzRlJc65Qku+4oCurfw8MU3tHTkg6Ej7BHOFYSYXYU19wfKmElFNalwTRyOWUOHkfSlv7ULeo84Eh/rRPQYHNkmLABjyO29KGFKypa0XtGnxYqMStzmCIur0Dd+48K48U5T9Z6TkugA3Y23Oj4RVVChHrdenaLtwnUh7rWXfivg38gBCdYrxAlUpyCp0vH5cPwVEM1sXOpkS+kFZtM8rnEqtH2zsOu6HXdpV5iVLbXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QjsSBQ5IU5Zhrwb5VCLP865TM2R8o5eOWWt7i8ND+q0=;
 b=UaBqR1v6w0jqrrleTvitJPInUzdqI5N3rHGEjBwFmTg9wsc6GxpVaBYunPrkFNR4FDJTTtzx/imX5GjAMi7VNzrbtcu2Fw+gHDqqdpLoelAXD0MMvuzaNhiFYJhlPyxdBxAnns8fnvsO5jEbA7gFIFCIE1mmWmPtY1niIDWjwc7d5M6PgK5fRR06wBwT5RN0DyjEI1YrK1XGx9kQLfErl4D+RjllaZBCoueduJ+Tu8P1m+9D6nzllisAcyXLQsMRZumahzsWu2ZLsTQKG6/gyt97vk7rUzkyBXuG0bZ9HtDaSZdYppqpl/UUB1ES5Ecwwg7k7bFMlCU+36XFcCYqwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QjsSBQ5IU5Zhrwb5VCLP865TM2R8o5eOWWt7i8ND+q0=;
 b=XGdJInNnyI2Ey6+KBTvNF05orTjU0d3hKKMvgjlfa8ftf0SWIWrYj3CDbVisd5IA1t4UZMRNQaHKwHaugCYQlc5zsyRYBOn1DQkzrov15PVahr+pHIOGsvHja+17O9Sger4OhgOTcfKdcqXrneDAe8dHtOgdgJWepLGiV2zepdk=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CH0PR10MB7481.namprd10.prod.outlook.com (2603:10b6:610:192::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Mon, 1 Sep
 2025 18:47:13 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%3]) with mapi id 15.20.9073.026; Mon, 1 Sep 2025
 18:47:13 +0000
Message-ID: <a4c38c47-64ee-4268-89e6-5c3ff72ed113@oracle.com>
Date: Mon, 1 Sep 2025 14:47:11 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net/tls: allow limiting maximum record size
To: Jakub Kicinski <kuba@kernel.org>,
        Wilfred Mallawa <wilfred.opensource@gmail.com>
Cc: kernel-tls-handshake@lists.linux.dev, donald.hunter@gmail.com,
        edumazet@google.com, horms@kernel.org, hare@kernel.org,
        john.fastabend@gmail.com, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, pabeni@redhat.com, wilfred.mallawa@wdc.com,
        Hannes Reinecke <hare@suse.de>
References: <20250901053618.103198-2-wilfred.opensource@gmail.com>
 <20250901113844.339aa80d@kernel.org>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20250901113844.339aa80d@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH5P221CA0018.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:610:1f2::13) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|CH0PR10MB7481:EE_
X-MS-Office365-Filtering-Correlation-Id: c4b2bc3c-eee9-4409-b55e-08dde987f717
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OG5oc2NmSHFrWGF0bGsrTjBpekttZ0tEby9vL0NDUSt0SzdjK3dsQ2pZODhW?=
 =?utf-8?B?bmhxTmo4NUNrd1hwd2FaNHRyRFZIUEVjdG5ybkdjME90a0V1UDZSWjZGUVQ3?=
 =?utf-8?B?TnE3SkpubnVMMlVFMXQ2eGg0Wnd3V0crdkgxUXllYUVvaHdDRGM0dGFtTTZE?=
 =?utf-8?B?b1dWN09RSVJhcmJjWk1iekxqejZNcitJK3VFaklPUlBtKzdNdFBkSnhCbDlr?=
 =?utf-8?B?OVZ5ZDVWaFV4Z25kRTgrdGlHS2JLL1E2eU84TG95aFFLRVVrak1MbjMwYXZ2?=
 =?utf-8?B?ZXZUY0NNbjRpNUIvbUJEWlZJdzh6OW9IUVNrd05UclE2K3RPV3AxTjljRmNw?=
 =?utf-8?B?TnN4cFFudGM4QjFIZXJ1WWVJSGp3KzhVVkVqSk0rbVljbHNsaEs1VTdRZXRO?=
 =?utf-8?B?OGl1RExjRjcrZmExOTNlZWg4d3lvZFROSjJ3Tnl4d0NCWE00SWVBMUFtVWZ1?=
 =?utf-8?B?dEpEbmorRXdNK25WU0YvWTBwdm15czVPNHVvMWhjWmNMbG1IZXRzd1ZNeldD?=
 =?utf-8?B?dG8vaUd4dVRmM3lqRlFUdnBQb1pKdVl5d0xScTAwd1JwWndjczZ5aGN2RlZv?=
 =?utf-8?B?TisxSXMwM1plb2I2TE81cnhPU0l3cXF3ckZ2S3lUb3hLTkRQdjlzRFJidE9G?=
 =?utf-8?B?RDI1TytyMGxXV2NlZDZLeWwvRWlUb0ZnYjExdkZ3RU9QcWNHczVwTE5yeExl?=
 =?utf-8?B?VXhjREhzQzZ4T28rUGdpOE1IN29PNFU4cEFNR1lzdnVJaWZmZkt6YzZQZGl2?=
 =?utf-8?B?NHJVdVhDU2VaOWsyc0IyMUNsOFU1MHJVYlM2aExzcmlreTdLK0U0WEgyNnZD?=
 =?utf-8?B?U0JieTF2cWI2WTkyQWU4ektHMzZyZzUzVHIwWVJJNldnQTdqN1haTkRFd09a?=
 =?utf-8?B?TlBrdnZzcklCOW91bnJmMGtmY2hUOGUwb1NCbnh5SUxJcXI1UFh2Q09HU1JN?=
 =?utf-8?B?ZlR3SkpEckJTVGZ1alNVODFWaFAwYWQ2cUU3akNnUlhXZVNadk8rR1B2Sk5Z?=
 =?utf-8?B?OUpPNGNkWlRFQ0VwVWJTWFdvckpDaUNKYmtGYXZYUUV1Z21BNXIxT0d2Q3Fk?=
 =?utf-8?B?V0hobzZ6YTlIMHB6bnFyMm5MM1hta2FhTUpFdGhSeVpXRFlud0dZNm1jaGNM?=
 =?utf-8?B?VEhCV3JOaEJJTWdsTlREa3poODkvRlBzaFlkNThhZVZ5aVRjTlN6OW9rWWxW?=
 =?utf-8?B?MnF2M0pqTGJZR1ZEdkFwQ1lKZGo2WVQxaU04M3NqeGJ0aUdDQ0xVRnUvZmJD?=
 =?utf-8?B?L0lFSE0xRGpQcDZuRStFdC9mSG14MnVmaXZ5RGtNbmRub2ZmYTY3UDFLVGJw?=
 =?utf-8?B?WlJiZ0RqWjR2bWIzV0U2T0JyTjVJQ3NWalRiNkNOWjQ0dG1IRTUrZDBHN0tn?=
 =?utf-8?B?TVdRY0VPbVB5L3lGMHpYcVh5UXpHNGZmYnhjdzlvbm1UR2pBSDJBV3BlZlVj?=
 =?utf-8?B?QVloVHdnTW5iMHNsNWlXWnpVa0xOdElUSk5BSXY0ZWlsb2FvT2g5NllvZXRt?=
 =?utf-8?B?a2h1MTFkZ2ZHRUFmTDJ2RWFvWHVhSjJYV3M4SlJtRkhrbmhLbWVrZm9sNlV6?=
 =?utf-8?B?TWR3NGcyQXVFdFhVcEZnZUVkaElCMk1hcU92dENvaE1EdU13RTR5TVdKdjZx?=
 =?utf-8?B?ck1aZ1dSK2FqeDR1M01mVzRJZGRPUGZydjR6TFdtOTh6QW1UK3VrNXJiZDdR?=
 =?utf-8?B?S0JTMmtBOUkycFlmVU5wcDlLdFdQZG82S3F0RkhrMXlzNGNpQVBMVk4ySlVE?=
 =?utf-8?B?YnBIK3J5ZWEveXZSdURyUXVaSmg3TDc0Sm9KV1dZemFnaWdRTHNMT0MzY096?=
 =?utf-8?B?aHZtblJkZVlueHZ5NmkwdFk5RzZOZm9iK1pYTC9RY2hNa2NmcnI2aTRrMUpP?=
 =?utf-8?B?WkIwWGR6MEFJaFRKZ1Y1K1BCeHFXdkNKTmwzNmNwU2xTcWVHL29kUjNHeW8v?=
 =?utf-8?Q?16nW8jUDgUc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cGJ6WS9HSzM2TjFybkVYb0hjc0pldkpOZko0Q3F4VG1RbDdFZWEzeExwZFV6?=
 =?utf-8?B?c1dNbUZML2VKa3VvWmRQOEpYRlAzWWNKOEl5QmxnQTFEY0lQSmR6Z3JhbTk3?=
 =?utf-8?B?L0xqMFRHSzRxQmhsOWRTS1gxTWRBeG5hM0ZiYkJzYlFzSktjNy9XTFExMmw3?=
 =?utf-8?B?aFFmakpwSFpiR3BZT3ZpV2xPeFhEKzVNdHJlQkhUWnU2Q2dxNTRwNThqZFkv?=
 =?utf-8?B?TVYzRDBvYVpscWp0VCtVQUxsdktrQUxyd2tUN2RyOWFiYy9XelYyUUVURTIz?=
 =?utf-8?B?SE9SaGFJTmQyMWprME9tUWFMOUlWT0pxSXJXZitNK2VlVEtlR1ZOYkhMcmZi?=
 =?utf-8?B?KzBOWitya2UzUW1jNXNUWkZZWnNTQ3lKWVNOblYxalp0MVd5ZjAxY0FIYm5U?=
 =?utf-8?B?OWJnYk1NL3VuT0hWRmptUjV0ZXIzNGkreHdxbVlhaWVSVnJnOUNmblNWenR6?=
 =?utf-8?B?V08xeUpKU0xicUZZd0JnUDlLUHp0UW5WTWhocVY3TUhlQkc5dEllWWxiNG9w?=
 =?utf-8?B?SWVYSFU3YjBHMEo0TUdNZ3dUYnhIdWgwWGRZZm8rS21pZHVYK3l3VjZoWkZO?=
 =?utf-8?B?eHU4K0V3NS9zVWhVOFFQb3Z4ZHdTVWV6TUFMZjA5bDhTNTE4Z1RmTmVIdWxv?=
 =?utf-8?B?VmVHWGNTQWRyL3lrUHZwUFZiYjBwVjRjRExvTGVsT084MFdLY3RTejVZRW1q?=
 =?utf-8?B?WnNHZHQ0dVVvQjRkUkdmaHlSMXY1ZFdmc1M5eTBPZUpIU0EzT0VYeFZxZURo?=
 =?utf-8?B?LzFtZUpRd3JVRlVnWkZCSnhLRFRBZ3JFM1B6VnQxaXprbEwvWWxXelU2Wk1i?=
 =?utf-8?B?NHNVUXliYjE5YjZmUXF5MnRPbG01L2JnZmF0YVh5YU9NeWplQmdMQ2FBYjRC?=
 =?utf-8?B?MTdpcWNyYzdmeTdsdER6RUsrRE9jdGttaFBqQlNJakZkaGJyb0VaMHE2YzZQ?=
 =?utf-8?B?OGJUbWlacE03NGY4bjlWTHlhcnVGZEszQkpWVHFJM0pNQWdDQVlvVkF2M1Bk?=
 =?utf-8?B?YmdYeDNWdis1TXdPVEIwa3hYblhTcGptc0lJeVllZHkwNVh6STFSbnNrS3FF?=
 =?utf-8?B?R1BGVWtvd2JublRpSXRNTkQrNE5wTlZ3dmk4QVZkSmNSbC9JS2NWdHRMOTB0?=
 =?utf-8?B?aUJzZkxydngxeGFiV08yOUVCYU5mYXVMTzBGZCtGdGpvVmM4eGtIeGNBWDJT?=
 =?utf-8?B?UHMxVTN5ajlwT2Y5bmFicXZUZ1F3V1pzdnZHbnZxQWoza0pSK1VrVmRWOWtV?=
 =?utf-8?B?dEZhNzJiTzRBNnlSZlZpbDh6VWxQRmJ0dXl0U3FMNDJWL0c2bmNsci9sVldY?=
 =?utf-8?B?M2ttMTNiRmcwY1NUczlHdWNYN2Vkamg4N2V3MUJ4WUxtd2pqL1VCM2ludmdk?=
 =?utf-8?B?SGdXVWZUR0RQbWowTVhZcVBtS2ZRSHhHK2V5K1NqZ1V3bzJBdlljeFJObzQ1?=
 =?utf-8?B?QnRuT3lPc1RhZXY1OWNINXEvVnJLcGIyUG1yMGR1Y3NMdjFOdVFPL0JnWTFK?=
 =?utf-8?B?YjJGczQ4V2xSeDVQZndRQWJaRExzTEU4c3Ezb1VZS3VlNGpDOE1FZ1FLRXJM?=
 =?utf-8?B?SjVFaHA3QVlZK2tnZ2ZPN2ZRbTZwcm9vb1FML0lmVkdFb2ZxaUpXS3AvZ1ZG?=
 =?utf-8?B?NTlkbmNLQnB5eS8xczFpSzJZeEtlek96akE2TEU3V2VSTUlKUjY3VWVISTNU?=
 =?utf-8?B?WFpML3UvREZmdC9FY2dVRVpueWNhdmJzbkZnM1luYVFSL1F3VEpqcnduZnpI?=
 =?utf-8?B?TUVaTEs5S1Npb2l0WjdlcjYzSW1nTHRJcENlNWczOS84U3lFL1Q2U3R4cWV4?=
 =?utf-8?B?aEFhekdoVmxMdm1COUFtbVBpMlJBZUZNRkZYS3YrQUpMV2p6V1V5N09zMVVr?=
 =?utf-8?B?TW1SSUEwd1ZqTFZJbU16UUxXR2V5ZVlOaFRVWWVycE54QS9LTUR2eHU4N08v?=
 =?utf-8?B?aWtyalVQV1U4dHovTkNqek1aZllyMDNabXNGYVF6WEhUSEN2TDlrSW5PTERr?=
 =?utf-8?B?c3E3TWRyTittWFluR0NqR2Z6dFJpUnA2ZGNIUHE2TlN2QkUyOUFZSkNjSmoz?=
 =?utf-8?B?WjlDSjM4M2docFkyWGwvQTVQSHBRMGM2cGlFZ0NLZE1Fd1JzaXNmcW03ckt6?=
 =?utf-8?Q?CZul7ifHQJsgtm68uFjzzHvMN?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	czTFnvDxtjddLdg1q4a2kLfINz+IPmqi25pbEFkg+lfM977gPcunJxB6xGuIFSpVoKAx47+1Lvukq3FWHI7/g95o/KZCRKMQgBD5O3AG334T1HBeMpZtEs9zHzNNsWXdqR6xf1SusE0LOOtEgiJmQl4LVGUcvLT/IsAxeIfGmH7hDkvzbhC/x3w4Woc/rhqkMD9GjK7KdUR1rCnLFixIcwAsrcHOq7uGf/PBnw6rRquB/qk792lCeH6+rVVi3sU2YMiMQn0Mi6HEBKRPuk8iy5dSWYkzu13jYZ+v9vy8e2cSCBaaXtSaiN3bSc6C3MPmIQEudsNgkS1aKJY0szRqiLCTa2edrFqPHHP3Fexlttdk6JgGRFRQpG14V3N3f53o74gCDVybdfk6dwpu66HFtlwwLzSNSZ8q1SS5E5cx5JzYdzDWGW9kSeR+fjKXTpaFeaBWiEAsV2xhDhJqkaKUIOBg9Des0Nw6riw4zaZQJUPZtgpJdv2byveA9fwbPUGJ5CSljXaxw8F8russWD6sMvWcn8W9PIy4EpesgPjnEGg1wXwiHG3UQIqxF6qCQWvZemPl2XQnvOn2dBpBs8jXfFovGY/4jNRXsfm9bWk6Sbo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4b2bc3c-eee9-4409-b55e-08dde987f717
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2025 18:47:13.3117
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MYZiUPpFUZ0Z2a5VegMGRsgwr38vweBQV/mqHzzP/+iZri8So8KuzrlljAe/Fe29WHtqH2tEnaVTzKGJU8AXFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB7481
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-01_07,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 bulkscore=0
 suspectscore=0 adultscore=0 mlxlogscore=999 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509010196
X-Proofpoint-ORIG-GUID: YGx5F7jU-TmptOFyTy3ITc_ar37xdOC_
X-Authority-Analysis: v=2.4 cv=YKifyQGx c=1 sm=1 tr=0 ts=68b5ea35 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=UIKPcKoqD8awHwKDxTMA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAzMiBTYWx0ZWRfX6tLJ8uEKeNAP
 jjgORnQZBOTY26ud5vcNhG6UWEmdGKiqZmIBYCE5+OX7nWMfJzp6yc79qXVtV2D/R3YVRPfVtsG
 pnIQHQdgHmw9JBMn0siw3UUsJAlygwKRqQgcr7rgzqGhCBrZWnq36rFxYeQPP5i853YCAp/tur9
 ZOXGbdB04ZPHhKdmuIdEkU9/NH/h5UNHRIuwDfurfnjnAUX0LBkaWnR0EF9oFzA9X8LuEGGEuAX
 OcmT4dZ9+xn1dWf0/5aHCI6DzBP/Gb7ZgtpfgtO6bdWXk1YHO2PfZZe2nr/UI7OHGejkWp9vuxu
 HyiFSBavmWQqPU5bt3yIQz6STUXhWFYZuXgy2l031LbwjRqYhB3hZRPeG/g+a1FJ9Uel98Vu3t5
 z9DRPZ+f
X-Proofpoint-GUID: YGx5F7jU-TmptOFyTy3ITc_ar37xdOC_

On 9/1/25 2:39 PM, Jakub Kicinski wrote:
> On Mon,  1 Sep 2025 15:36:19 +1000 Wilfred Mallawa wrote:
>> During a handshake, an endpoint may specify a maximum record size limit.
>> Currently, the kernel defaults to TLS_MAX_PAYLOAD_SIZE (16KB) for the
>> maximum record size. Meaning that, the outgoing records from the kernel
>> can exceed a lower size negotiated during the handshake. In such a case,
>> the TLS endpoint must send a fatal "record_overflow" alert [1], and
>> thus the record is discarded.
>>
>> Upcoming Western Digital NVMe-TCP hardware controllers implement TLS
>> support. For these devices, supporting TLS record size negotiation is
>> necessary because the maximum TLS record size supported by the controller
>> is less than the default 16KB currently used by the kernel.
>>
>> This patch adds support for retrieving the negotiated record size limit
>> during a handshake, and enforcing it at the TLS layer such that outgoing
>> records are no larger than the size negotiated. This patch depends on
>> the respective userspace support in tlshd [2] and GnuTLS [3].
> 
> I don't get why you are putting this in the handshake handling code.
> Add a TLS setsockopt, why any TLS socket can use, whether the socket 
> is opened by the kernel or user. GnuTLS can call it directly before 
> it returns the socket to kernel ownership.
> 
> I feel like I already commented to this effect. If you don't understand
> comments from the maintainers - ask for clarifications.

I don't recall seeing that comment before... but it makes sense to me.

After introducing the new socket option, instead of adding another
argument to the netlink protocol, just have tlshd do a setsockopt(3)
call before handing the socket back to the kernel. It already does
this to set the session key, for example.


-- 
Chuck Lever

