Return-Path: <netdev+bounces-125693-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 80B7496E433
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 22:37:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 396EF2846A4
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 20:37:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F4C31A255F;
	Thu,  5 Sep 2024 20:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="TCFyAQFq";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="E/HSYEnL"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEB9917741;
	Thu,  5 Sep 2024 20:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725568645; cv=fail; b=LjPL5e4KinVClXDzeN1IWyULwNzNM7M/k/hH/3XJTJsxEvz9XYM9Q0nZe7Zg+puXhin89JMR/op5rGseQWWci6xuWBbb8OtJHqgecbVfD0ba/Na6h6L2iMaAwtrBC0NCGZE7odLqZqhAYQk1Tlx8wTVN0XhwgN1Gx3+6zE9WDww=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725568645; c=relaxed/simple;
	bh=3rZgulhWHVxSVAYW2Y1jtL2An/GlYXgnE6ENnQiHE4k=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=I9bxfO3wV8G/mb3j6VeT3Fm1gQ7ZV0Eou7fjiigC1zJKyzuAoDcAMhIsmthlqdNHRLo7DPhuhGwaYY39LeO697/e5KSmLQFu+L22Gq3BXY/NTracKL9gLT86hb5gkg6qhX9WB83JKV9i6R6fF4ZXAdS9DBskKjSrOdXAZujY8VI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=TCFyAQFq; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=E/HSYEnL; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 485KZ5Vu018837;
	Thu, 5 Sep 2024 20:37:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:from:to:cc:references:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=u6Bjg6nlqUv8H7MUSQVAg+81kaATiN9RBPDSX8/746w=; b=
	TCFyAQFqmeHenX32v9SsOTfz1IjfqY4cou7j29LgtCjKx33zBho6nAyypGSp7PaD
	o+MiU4wO5UT/iB35EXEVYB6VCeDJYokuu359dT9DM5sHKpgs7eUcT9nB+2nrsP/z
	y+l5FNkTRIGE1Pz5pjF84rS0MaYTBQtpk2PGsvYmZ9mJfX9NSuh5UDBjMyViPkSO
	JREN1KUJWDEKfcZtBS75FnjlwH7yvfuZBD23SE+bNHsm1bR+QGDMlazchHTHRI0r
	A2m//giUtbS3ypM5RuMJrTg77GMtpsJt2asoJu+4c+fXUVcxucWOCFAuV50l3uhf
	45cIbJ8dzgFfrvXVuiBdew==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41fhwjg8ag-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 05 Sep 2024 20:37:12 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 485K7Nvo040916;
	Thu, 5 Sep 2024 20:37:10 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2176.outbound.protection.outlook.com [104.47.58.176])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 41fhyb53yn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 05 Sep 2024 20:37:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g0qFHclZdl/gE6aFFn80gH0OREdkKE/sXcnyReqzJDU8TE1SDAcrFHhaQ4wGQoaQZmQggX0y6g1j1JHawH9vKLvck5f8Mhm2X/vh2Iao5In81KlqbZx3KuDKB6wwmGpfg4Hz9yZqyEVs9zZhrGKrPWRixsTsirrAQyHV6eh+zEtLMSUO0yBi2+4yDHShVmR/Kg0s3XLY0fnFsj8ZHNjfCnCq0W2wOK+rQUI0PmtlobZoiu3cJF17wrja2aKuvmUwqxEaWQpV+D1IjrcW9NnzFfLMlM8aCaQEx+ep7gcS9/mFer2QfMzV+VUmMA25ojw67dS1T1mAjmFSBzbjD+tkOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u6Bjg6nlqUv8H7MUSQVAg+81kaATiN9RBPDSX8/746w=;
 b=em5EnUXfhm2sydKYDS3I9B9eMOCQWvxOSpv16ZV63fD+z71mI3kvkI90bIz5lAhyqlORMnOjmfrUb05lJXhQ8omD9v5zEUS0zhytvkgO7IeJIsoPmIaAYh5FjIiR7I0e0ThoKeHCEiTnRTVAjZHlYAGsOn/PYRYnduwZhI52zmXQhPNtqsKB/rJPWPICvJ/dPLxq5ILmFXZUrAloluSQCus7BvQVW1bSi9clZaCyzEes+BVXcKdqucMKQpn8VaGMseyKtjqX6rsdbqp0XnsAp3EFxiDE8rXVdEZ19yrME/0Y1mOy+9/1K/4sRqihYGk/gARWEVjYYwdEkTb+iD+8rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u6Bjg6nlqUv8H7MUSQVAg+81kaATiN9RBPDSX8/746w=;
 b=E/HSYEnLlwOHwclthL1YJjb8vyD+Zg8etuZ/gr/EJzoheDsLi2uNkvV5k1NV5GvdoWi6nz9NarxBo9sC3l0vbeR05FbIN9L9KXubLhZtMYf3lap5BkZFg0mWRu0WQdF4+uXr+pmTEE9xr7bZQjV9NRJ/PIgMLs+2gH9BzJvsAWo=
Received: from CH3PR10MB6833.namprd10.prod.outlook.com (2603:10b6:610:150::8)
 by DS0PR10MB6974.namprd10.prod.outlook.com (2603:10b6:8:148::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.24; Thu, 5 Sep
 2024 20:37:08 +0000
Received: from CH3PR10MB6833.namprd10.prod.outlook.com
 ([fe80::8372:fd65:d1ad:2485]) by CH3PR10MB6833.namprd10.prod.outlook.com
 ([fe80::8372:fd65:d1ad:2485%6]) with mapi id 15.20.7939.016; Thu, 5 Sep 2024
 20:37:07 +0000
Message-ID: <68873c3c-d1ec-4041-96d8-e6921be13de5@oracle.com>
Date: Thu, 5 Sep 2024 13:37:06 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [net?] KASAN: slab-use-after-free Read in
 unix_stream_read_actor (2)
From: Shoaib Rao <rao.shoaib@oracle.com>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        pabeni@redhat.com,
        syzbot+8811381d455e3e9ec788@syzkaller.appspotmail.com,
        syzkaller-bugs@googlegroups.com
References: <13a58eb5-d756-46a3-81f0-aba96184b266@oracle.com>
 <20240905194616.20503-1-kuniyu@amazon.com>
 <e500b808-d0a6-4517-a4ae-c5c31f466115@oracle.com>
Content-Language: en-US
In-Reply-To: <e500b808-d0a6-4517-a4ae-c5c31f466115@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR03CA0002.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::15) To CH3PR10MB6833.namprd10.prod.outlook.com
 (2603:10b6:610:150::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB6833:EE_|DS0PR10MB6974:EE_
X-MS-Office365-Filtering-Correlation-Id: bf83990f-fdf2-4cd0-d317-08dccdea829d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YktQZlo5TmZEdUFpRXNzcjZKYWdHUmxNd3c4U3NIc1JnZ0FhUTJFN2ZYY3Zp?=
 =?utf-8?B?R2k3OUpLZWVvV20yZTVlQ29rSlF6RWEwaUQ2OG05aXBkVXZDeHNhNVhzanpi?=
 =?utf-8?B?STlXMzMyVGpWZTZ2akE2MDZabTZSQXRkVVRxcERzdkc5UXBhWkpEN08xMDdW?=
 =?utf-8?B?c2dSWkY3TVZRbG9lS1IrRFF4NmZtUzNVZy9wWHFUTzdxVEV0M0ZBa1BwK0hp?=
 =?utf-8?B?UE12MUhFUEEyNDcySWFSNUdoK2dMMmV0Z054ZUQ1NHVXTWJlT3NXcHZMZmJ2?=
 =?utf-8?B?cmh2UzF1bmw0Q3hzdWsrcExrV3AzcVhQNStqVFZDRnZVS01PMGg3NGhDR0lV?=
 =?utf-8?B?NnNzMEVUM1owK0xqTlBKbHBRMCsyM1AwWWNlRXNxWjNmYzYyRkR5b3BKWUpJ?=
 =?utf-8?B?L3d1L2FubUJZZ1VBb1ZIV1k2Q2hyL3BueFFNdTV1RDRnY25oamRUdkljbGtw?=
 =?utf-8?B?VHkxOHhuRSs0ZVd1RjVtZy9scXhRS2w4SmJiK2RsbW1YRFJ6TU0vVU8yejhE?=
 =?utf-8?B?Tnk2cUZwZTFPR0VBR2hsakVrOWVyYjdCS0c0c1BidGVONUM3QlNlTmI5eGx2?=
 =?utf-8?B?VkdPdkxiclNHTnRjTUp5RDkxZDlITFkyY0lyVGtScjJNZXdNZnl0d3ZaelV2?=
 =?utf-8?B?SnEzSUxteGdvYm1WMjYvNDN6ZU1BNE94Y0F5TWdhRTFVaUFwQjA0S0ZtdHRy?=
 =?utf-8?B?UUpRT0pkSWwvWDN2b2ppWGplNWtac0xFd0FoT09QUUNydFp6d3REbWszZ2hI?=
 =?utf-8?B?S1prZlZxWFYyNlZ5VFY5U3FTQjI3VGNjMmZ0V0lmY1FJNVRDQ0F2ang0U1NO?=
 =?utf-8?B?TjlLQ1lYNVZ4cEFRSGRPWXBaZUF6QUdpL1RlcS85TXpXb0NsZXliNHQraElX?=
 =?utf-8?B?eDZJbjFsS1Q5UGZzMDJhS3J5dnlacStaRDhzWDduWTYzYzZsbVZjc3p1eVhw?=
 =?utf-8?B?cElKcTNmUUlvWlgyQnZsT0R5SkhVUXNDZTVqZVBYRkFDWkpjcXQ1MWdGaUc4?=
 =?utf-8?B?ZnlFc0oreWJrVlFrUVp0cm1pZ0dhalF2WWdIbFRyeVJ3TEs2VXpzUGhrKzZp?=
 =?utf-8?B?UXZzakpsNlRWbnNHSEZLNkUwd1NGdGFUdm5TRzhQNGhEWURGbkVudXZoL3BK?=
 =?utf-8?B?SkZBc2lkRFA3a1hiZG5Yd3pHMDRFQ1dKWGxQcmg3bXVIdW1qWVFzUHMwaTlM?=
 =?utf-8?B?c2ZUWTBpNVl6VkVPc3JCalV0SXFSLzJCOE5YNjUrcmttQUxDWmV1MkN1ZEVH?=
 =?utf-8?B?b1RnK0o3U0lmRCtzT3BGTytKd3lsdGx1SlM3Vms3Mkk0ck1xS3RoUXBCcnpF?=
 =?utf-8?B?aCtjUWg2YU9tSFIvRS83blZVZUs5KzlNZENvanV4L0dSa1QyNWFFMVpCaWxW?=
 =?utf-8?B?YU95bHJldnhXQUs3dUJpRENxV3lNTWhaWlI2UlIySlJLQzAyUFRiYUxMR1Rn?=
 =?utf-8?B?SnZXTVdmWFQxUC9oa1BoR2RPamZhY1ZkYksyTmRXYmRRdmRZcXY1bEJvUkha?=
 =?utf-8?B?cmM5aFFpUzZGRlVzR2ltWi9uN2VuQ3BLbUtUVHN2dksrZk5oNFhaVmRlWVVt?=
 =?utf-8?B?M3dsTHplcitlWEZ1TUtad1RYOWFCME9hd1k4R0VIblRhakl0b0FER3NKVXl5?=
 =?utf-8?B?NVpnNWpEVWRDeGdLcFJtaDhRMXhQWXVDazdpaXA2MDJvc1Y5dTF6ZDFGMUps?=
 =?utf-8?B?UTFCZC83amFOR3lpNzJ3UUlQejZ3bldGLzVvc0wyWmRza1dBZVVvMndkczlQ?=
 =?utf-8?B?YXMzTXV2MTd2dUlXdWFOYnU2MnF4MWFzT3ZLMlhRMXhKTzZUVzBVZFExbERC?=
 =?utf-8?Q?RHD7FUfsb2ly5otUQwjeqLWNUway4VsIr0A64=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB6833.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YXYwYTFkN0hzWWVrVHFReUsrblBtZ3lkUURvbVBWMXJabEhuWTU5VThMMXl6?=
 =?utf-8?B?d05SVW9HcmlNUHQ4UW12MDVuOFVvR1FTZWJWc04xaENpeXBQWVdWMzN2MThL?=
 =?utf-8?B?RVhuVzdWbU5qRzhJcXZRMVRSOFJoNEJnRDYvZENwdU9mKzdFQ3hKRWhLWStJ?=
 =?utf-8?B?UGt6b3ZCYWg3cGk0MGZHWDdweVlqTE15dHJTeXNjQk83WSswQVZLVEV1VlZs?=
 =?utf-8?B?WnhKdks1Sjh4S29wc3ovS1VscURTZEc5MVUyU3duWXlvaVNpMVk1NWo3TUsw?=
 =?utf-8?B?ellUZjFNRkdQYlRkQ2pUUXVxOG54bEJtR3NtNlhONUJXdmhxREtNUm1qamlB?=
 =?utf-8?B?YnA1Nm5ja0ttQzA0dm1ubDEyd1VXMllBbGlWOFJFMzNTUWxDdG5hYkxpaDBr?=
 =?utf-8?B?dER5aUdkMWFVaVFzMmtMZ29TTTVPWWhldjQzdS92R3lEUEJMVHBWYU5xMm9k?=
 =?utf-8?B?MUc0ZFNjV1hkcHVQMzhia2JsTHBIcVpsR3B6VFFrQS9iODRlMkdWYnBWMStV?=
 =?utf-8?B?MnVvOE0vY0FJdXpaWkx5QTVTTndMVkt3ejdmNVRKOHB5Vnk2Zm1xUkZ4WWJR?=
 =?utf-8?B?Sk9IaWY3WkNPekNCdURQN2VETm51OFRDOEhXTDZGMmhFdkdtWldCaXg5SUlP?=
 =?utf-8?B?R2VLYUxFVzVFRE4wWmRpTE5tQjRlOHRzd1lHZGxBK2tnTEIzRHhSZkw0V2Jn?=
 =?utf-8?B?WEk4UmJtL1FYMTlOU09VY3AwNS8vcXhySmo1NVRqT0JMMXA1cjdnekhBN2Zs?=
 =?utf-8?B?MmlsVmxxWUxZbFV0Skxmb212L1JTZnQ3NFI4dlp4bWpsZU5GUGFaTHdINlVE?=
 =?utf-8?B?bFdoVkQ4WXRHOGFSNDVyd2xSeERheFRBdkxnNlBWQnE0OEFXV25VdHI4L2M4?=
 =?utf-8?B?UW1TVXNLZ2lZZ3Y5dkQ1R0lTUitiOHRENUk0RmMwdzJVcHVNMUt0K2FYL0dJ?=
 =?utf-8?B?emp1NElpcUJKOTFFTUJSMjRKeWFyc29ZN09xaFF3NU9xTk51VC81NWdTNUpQ?=
 =?utf-8?B?UTlTSkoxcXdRSmpScUtBOExJbXRUb0s0bGFXZEF5MndPQmpQMm9DVnpnTlBs?=
 =?utf-8?B?R3RYRm81STZDaXRoL085MmFlZldSaXFhRytaaml6N09xcGJoR1dsTjNSMURt?=
 =?utf-8?B?VE1mQWNrTEtkYS9sK0h0dTBlcVFyZ3B2TU9nVkROa2xwTXZ6UFJJSTV1R2NX?=
 =?utf-8?B?cElva3p3Sk54aGQ2blMrcWdGeXord084Ymx1SFBpN2ZuVkJGaHFNalhzd21L?=
 =?utf-8?B?OXRWaGIzd3hWNExoclJMT1lGMWtWWEl0NzdQaWpCVDNRWC9LY1VaKzUwUWtJ?=
 =?utf-8?B?Y29qMUVHeGtJL3lrZzRBa1RlVHg4Z0ljbXJjODBsbkRyRmdlYTRxTUROOW9p?=
 =?utf-8?B?S2did004N1dnU0xnUEtxMVFVSWR1UC9Ca1N2UktmYUZ6ZHFMZkVvaEx6Z3hM?=
 =?utf-8?B?a1JObEpXalE3S2RaVUx3R1pNSFd2SC9wZCtHSXBITTVxYjJ1NGhHaUgxQ0VY?=
 =?utf-8?B?WUVqakFBcE9TcE85Qk5MWmd3SnhXeDhyZHhqU0lJUVY3MlNCelhFRGNxckxL?=
 =?utf-8?B?RmFqTHVieWdhUDNOZXdVWUJQOThSNUlQSTV0MVZMQkcwM2ZDajNYSThqM3Vp?=
 =?utf-8?B?eG1hU2RnMUhGekdLN3RJcVF4amxrcGNDZlB0eWdnT0hBc0pWdjBuaEFNRFNv?=
 =?utf-8?B?eExhbDNyaFpBdGg3SUovRHBCMVIrckZjNlNWY1U5djYwa0w4eG9USTlMV1J4?=
 =?utf-8?B?Zm5NNXo4SkZ5TnZTUlJrcTBEK0l3ZFZwSWYweUl4WStCODZaYjQ4WjlDMUZu?=
 =?utf-8?B?MUxIc09ub3loTHRUbUlDdGgyWjg4aHZYSXU1ZkFrRFlCbWQ1Sk1meFR3MmNw?=
 =?utf-8?B?WTduTStVUDlRZVlpTVFBUjEybGcrMCszd2tiRWY0cnhxckhDeUxlUVdaRHRs?=
 =?utf-8?B?UGJ0MWdOS0lGczdXaUZPaW9CYlhRVEZzNm05ZVdUSW8rME1LTFNTemZpOXdw?=
 =?utf-8?B?NGhJQk1xaDJWK01YLzM3R3lZMmJwQnJxcmZWTTN4S0VVY09HLzEvekVsSldn?=
 =?utf-8?B?ck1tU3dRVU4yNnh1U0lZQjRqMzMwSGo4QVovK3preVpubk5qaTRqL05UZ0lU?=
 =?utf-8?B?Wmh2YU1scnhKajMwQ0FaVVFYTlNBbWo2VXQ3cWw5VTk1TTY0Nmx4TDF2RGdF?=
 =?utf-8?B?NVE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	HqElbo24Uy0DrtzIkutpAUOphge6X9jvP+vHZQ+9qppfwgN1t6JWbqgydTHqs8fNRzouDxYr3UJ0l8KfFOrOoP3qFkocvUOLf6zaCGa9mAYjBC+siquWodp9d5t9dJetwW90vWrul6TjBL61aUQRZX0/a6m7o/tyTttubx2iyWzubxECORRp78YFc0oJPxErKsu3lbcg4Ljc05xJpAGE/oWDVUceSjq0p+cS6zQxSBmRXFI1IbFMALNtkpvF5oLqJW4zSkYF0HB3rVMKa3AtfdTsOg3pfT2kWDNZy5+9/VWwpQMzE45z8TjpR7eDL/beUDQxi5sv6KLfnbgoj010B1auKrPuqJKDMu3uG0E9YNxllw9TUJ5ri3Xqei0bf9Y8AF33sa0Palio3RWzouLl//nCK3a/6O4nGMwyMmeUKaXuS60hVoxH/kstgHhOW3f4X3znylrmyL9M3GlOxFvmKYIaHo8q9b6kLLPzkDdrDzZwWjZxY6GHWaCbn+CxJBImAJqWsMRjFVja8rhoZBAjd67KQsSOc+wm+D958W1L0p3jQO2Ka/IshwT38h/jJawiFwFykVRVj63b+EiD4bWQ6n2lUv4EvJErpVte+ZyeJD4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf83990f-fdf2-4cd0-d317-08dccdea829d
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB6833.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2024 20:37:07.9153
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: akV5sdXeDiPAiTS9m7kDo8Lu2uEYE/mZ8G2lmaeAGpVCefkR/EG4dEpzNIq5N4YECF5+KrVNjA5lyatl5AUVIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6974
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-05_15,2024-09-05_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0
 mlxlogscore=999 bulkscore=0 phishscore=0 suspectscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2408220000 definitions=main-2409050152
X-Proofpoint-ORIG-GUID: wYii7CAl6kh1K-6oz8XCQP55ys3863x0
X-Proofpoint-GUID: wYii7CAl6kh1K-6oz8XCQP55ys3863x0


On 9/5/2024 1:15 PM, Shoaib Rao wrote:
>
> On 9/5/2024 12:46 PM, Kuniyuki Iwashima wrote:
>> From: Shoaib Rao <rao.shoaib@oracle.com>
>> Date: Thu, 5 Sep 2024 00:35:35 -0700
>>> Hi All,
>>>
>>> I am not able to reproduce the issue. I have run the C program at least
>>> 100 times in a loop. In the I do get an EFAULT, not sure if that is
>>> intentional or not but no panic. Should I be doing something
>>> differently? The kernel version I am using is
>>> v6.11-rc6-70-gc763c4339688. Later I can try with the exact version.
>> The -EFAULT is the bug meaning that we were trying to read an 
>> consumed skb.
>>
>> But the first bug is in recvfrom() that shouldn't be able to read OOB 
>> skb
>> without MSG_OOB, which doesn't clear unix_sk(sk)->oob_skb, and later
>> something bad happens.
>>
>>    socketpair(AF_UNIX, SOCK_STREAM, 0, [3, 4]) = 0
>>    sendmsg(4, {msg_name=NULL, msg_namelen=0, 
>> msg_iov=[{iov_base="\333", iov_len=1}], msg_iovlen=1, 
>> msg_controllen=0, msg_flags=0}, MSG_OOB|MSG_DONTWAIT) = 1
>>    recvmsg(3, {msg_name=NULL, msg_namelen=0, msg_iov=NULL, 
>> msg_iovlen=0, msg_controllen=0, msg_flags=MSG_OOB}, 
>> MSG_OOB|MSG_WAITFORONE) = 1
>>    sendmsg(4, {msg_name=NULL, msg_namelen=0, 
>> msg_iov=[{iov_base="\21", iov_len=1}], msg_iovlen=1, 
>> msg_controllen=0, msg_flags=0}, MSG_OOB|MSG_NOSIGNAL|MSG_MORE) = 1
>>> recvfrom(3, "\21", 125, MSG_DONTROUTE|MSG_TRUNC|MSG_DONTWAIT, NULL, 
>>> NULL) = 1
>>    recvmsg(3, {msg_namelen=0}, MSG_OOB|MSG_ERRQUEUE) = -1 EFAULT (Bad 
>> address)
>>
>> I posted a fix officially:
>> https://urldefense.com/v3/__https://lore.kernel.org/netdev/20240905193240.17565-5-kuniyu@amazon.com/__;!!ACWV5N9M2RV99hQ!IJeFvLdaXIRN2ABsMFVaKOEjI3oZb2kUr6ld6ZRJCPAVum4vuyyYwUP6_5ZH9mGZiJDn6vrbxBAOqYI$ 
>>
>
> Thanks that is great. Isn't EFAULT,  normally indicative of an issue 
> with the user provided address of the buffer, not the kernel buffer.
>
> Shoaib
>
Can you provide the full test case that you used to reproduce the issue.

Thanks,

Shoaib



