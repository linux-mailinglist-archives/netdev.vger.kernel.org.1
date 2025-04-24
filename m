Return-Path: <netdev+bounces-185430-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DF78A9A556
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 10:10:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10DEE3B4E08
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 08:09:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60C72213E8B;
	Thu, 24 Apr 2025 08:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="j9XI366b";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="OzhEfmrq"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9491920298A;
	Thu, 24 Apr 2025 08:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745482144; cv=fail; b=k+ueojyNVNyhU6A5bkoGxirsqOp8ZfN3akx6VLc+kAqvugzATxrGqbKO16/edwqeXWxd8r+G0B0xbiytmHwPNvJuoFdYko4QVLN5zRuBjaewqE1j3nYA38+jcaZ+GbjDkF8f8IPfdI9HFP34GXFMhpNsfI8XwoWyCPsNj3bbI58=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745482144; c=relaxed/simple;
	bh=Ax9QYXaawaCc99DWWOkCL+XMmVOMz0GJArci0LK4vag=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rP/roo09C996c025RjrmmbJ7tGzSUcwrm4nOWGbwp20FdDs3c7FN3gsNHEOTd60sGm5SVVo1c3Tch3o1Wek7KPo55x8r5F/nFq0ZEnmw50POxH5k4NsTUUvHX0jHhdAXXyH6ab3x4UZanOsqr/0HKPkGUUokG+RHIG14lrDD+nI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=j9XI366b; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=OzhEfmrq; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53O6tvo5013966;
	Thu, 24 Apr 2025 08:08:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=1dMUuYCwRnXUShlrqrBY53jr8XsAGAoUAqEqwagrNSk=; b=
	j9XI366b3UoFf3+PwVmQRzE4l4pquixAffPgzoWyLdhdqsKpcZruraXCDyh95dwy
	Ymzm5qHUlO6WtU/FH0e9neFKp+XslaJBWRKL9M+jLAg58a49XUtkuXSTquF8oMYL
	4lk4r55dRM6P/RLBYhG+Gw4kum5TNPM870wwMS7M6+AEPbsUl0OoEmkBbRLrKN6P
	lSO14yyV0IXYbStsHBN7UDkCH8NlF+02vMXIycIc9h/Nhjj5tXc1Lc+hb8VOTB83
	tT08e9CP2WsM5U2cWcEV9Hmn/IiFWdQJ70JjR33X+LN/QnA26eVINYWx6RCwjJZD
	VCJqtlQZ9jiY2Fu6Dqc9pg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 467eghr8tx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 24 Apr 2025 08:08:43 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 53O7806D025207;
	Thu, 24 Apr 2025 08:08:42 GMT
Received: from sn4pr2101cu001.outbound.protection.outlook.com (mail-southcentralusazlp17012014.outbound.protection.outlook.com [40.93.14.14])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 466jbrqxv5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 24 Apr 2025 08:08:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R+ZCO/SHmGhHWZjfV0SlB4U1okpr3zVQXrF5/un6ayqR4NegHcHSmZ1IruPDpzPLj1DSjcPP+SrlLWIzgdiDvnGML3fGo7t2HQT6qf5Xv3Ozq/KNqnBOEyEP25H7BfQO3loC2R2pS2KG9rxLZ/8WIV/ln5ExWRvpIEoN+91WsoIvJruDY/qeDCwmivj+gRi+0dLfuByLy7oekgcI+StH3ef8RGxmRqKhhlNmUznUBdINctC73ZJJy1fP0LFQUNsYCK+jLtyCeu6AqEDLNduypvlZUvz24WSLoiEGuVQn0bSl6gM3tGrwOYKHVlqHlgvKMf6Zd7Ql/0cYdmty+wXArw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1dMUuYCwRnXUShlrqrBY53jr8XsAGAoUAqEqwagrNSk=;
 b=E0KUqfbRuiA66WLrqL25R0jSZgq8LUh8u/PGE2ANO4wHheutRXcmQ0z7RSRtlFfCiTJzv0umg+B2aHKVZmM3m5b9JUFyKm3XOHUJw3FjwBYS7U22//51/WWu5JEu6EBx7cEwsCVYvQFjTnvLkOsA4pEWa8PNKniF4viLB+YGrXkoUeedkkWDnc0qDGReB9B+NHmfW88hE1hgCdADi2nMrUFFPMnJ2LFwXlp6ERAT2J71er1+qR59hEFu0uq4JezZc8KUje3LwboVGSsP9MrcicFUozMCUNqvM5Q5Kak78W7Cm2k64G6wh0DEo+qa1VHGoYkNSeyauvyiVv8k8zEnqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1dMUuYCwRnXUShlrqrBY53jr8XsAGAoUAqEqwagrNSk=;
 b=OzhEfmrqJ6FQ7e8uH5KWEZRtVG5lke4lK31dEing8w1Olr+bRcsIYQAtjndy4Cl+46QQgfKXIEORe9WIK54D5oh/YP4QF86kaWGKrrqJ4Io6Oq4N6dy7tCVd9cr6beNf27yRDuHngfFXvf5kU5nEta+a+/gkUVxPofi09e2QjOw=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by LV3PR10MB8156.namprd10.prod.outlook.com (2603:10b6:408:285::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.23; Thu, 24 Apr
 2025 08:08:40 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23%7]) with mapi id 15.20.8678.021; Thu, 24 Apr 2025
 08:08:40 +0000
From: Harry Yoo <harry.yoo@oracle.com>
To: Vlastimil Babka <vbabka@suse.cz>, Christoph Lameter <cl@gentwo.org>,
        David Rientjes <rientjes@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
        Mateusz Guzik <mjguzik@gmail.com>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>,
        Jiri Pirko <jiri@resnulli.us>, Vlad Buslov <vladbu@nvidia.com>,
        Yevgeny Kliteynik <kliteyn@nvidia.com>, Jan Kara <jack@suse.cz>,
        Byungchul Park <byungchul@sk.com>, linux-mm@kvack.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Harry Yoo <harry.yoo@oracle.com>
Subject: [RFC PATCH 6/7] lib/percpu_counter: allow (un)charging percpu counters without alloc/free
Date: Thu, 24 Apr 2025 17:07:54 +0900
Message-ID: <20250424080755.272925-7-harry.yoo@oracle.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250424080755.272925-1-harry.yoo@oracle.com>
References: <20250424080755.272925-1-harry.yoo@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SE2P216CA0126.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2c7::10) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|LV3PR10MB8156:EE_
X-MS-Office365-Filtering-Correlation-Id: 62e3d334-9c42-4eb7-d3b7-08dd83073915
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SzlydnpMeGpaRVloVU9BRC9VcmRuak8xSTQ3SzFNU0tGdjFPOGtEQy9pd0Fv?=
 =?utf-8?B?NVQwQU5HOEJqbk5Ha2daYmh2ZzU2bW04bzdtYm9lVlNGSUdoSWV1K0Z1Zm9s?=
 =?utf-8?B?U2g4Y1g2NERiY01mWVYwSXlHazhtZDc5MnA5QklDMXFqdENlV25JdEtEWTRY?=
 =?utf-8?B?NDZvaGdUd1pnK2NEQ3VBb1F1KzFXT1g5TmVSWnNDMktFRmdJcHBSTFZva1VL?=
 =?utf-8?B?bFU5aGNURDljRXZBTGNRd1dBS2xJSzFVck8xWFV6OE5kQ3BYcnoydU9DREYy?=
 =?utf-8?B?cHpvSTJvZkdmajZzUXJCUkNVT3ZrTkRIS1hSN2xHM1FUMWpZN2JRT2xEeWlY?=
 =?utf-8?B?VVIvZG52VHd0eE9NQ1ZyU0RXVTZHb1pRNGlwczhCSFdad3Q3MGR5WUNzUGJ6?=
 =?utf-8?B?M3Q5MW8zaitaYXV4VVcvek40clQ3QjFDMTdYTnVRV2kyY3M1QjdMNEphVHAx?=
 =?utf-8?B?RlBMTjlSZzZDbktQSDJ6VnJkeDdBTTkxTHNUQ1pRNEMwTUxiZEhoUUQ5UytK?=
 =?utf-8?B?dzdDT0VlZitrd2xWSDhXSHRFTHExaW5vcE9SSHdNb3BhQUVLM0ZYYkU4cWRH?=
 =?utf-8?B?T2pRNjVyV05zeURrSUF0ZE16NXFtb0ZhcUpZalllTDJlOUM4L0hTQkw1RURS?=
 =?utf-8?B?eWlPeXhxdVB1WExiWDlVdnJ1cGViU29nZUxWUGxSd08velVmWWFaWDlzR3FJ?=
 =?utf-8?B?WStLMFFLNU02V3pzSjd5VGZ3aWJRbXRFZmRYTHpMUkVCWmNkRUNYanhYbFRz?=
 =?utf-8?B?VFNPaEE3bXY0SXFKbVdGMVhQcXFOT3VKajRNa1lnSU9ZbkMwRW5YSXVLRHhK?=
 =?utf-8?B?eWJKNVZhenJUWDZTSEw0QjR6NGo0eGF1cDRSY2ovQlByWlM3N0l0aXIrRjRy?=
 =?utf-8?B?aTg5RFlNaFY1OEtFUm56MTZoaUVaZWNtV3BCeWZhSUVWQjUwSW9RS003OWps?=
 =?utf-8?B?Y3NLdXdKMUhoWjliOUlHa1EreXVDU3NuNUFhdThrU2NQcCsySVM3WENtZGJH?=
 =?utf-8?B?VjFyL0VrbnZhZFVUcnNwcHBZWXZwZGJBdXBNYS9xbThGTXpvWWxVQUJUN2ht?=
 =?utf-8?B?aG9BT2tjRGFLUU1MRjhxOUMwR0NyZEg3cFprSHNKMi9ET2wxOW80WklVV3Bp?=
 =?utf-8?B?T1Q0UCsrNlVtV0hYdG9vYzB0YTdLZzlBclhzSzdoUktkUGt2VDF3aWZNai9G?=
 =?utf-8?B?UWR3dGhqU2dGRG03WnlEcm8rOCtPZkhTWHprNkl5ZTJ1M29oWXFwM2VsMjRk?=
 =?utf-8?B?VmpDNFVOVGt0MmF3SWt3SHBYbHBrYlFtZS9ZbGtRbkFhQ3p1UmpFd3l0QXYr?=
 =?utf-8?B?UXZHZjJZLzc2RlE5WTFxVGNkRmg2Um1YU01PUU9Uc01kbHkyMWpwdHo0VHNI?=
 =?utf-8?B?QkpzQTl6YThJbnRld2NGTWRtWjc5aXhicXpjZW1mVHp3bmVZRTEvNllYTHdL?=
 =?utf-8?B?TXIxbjM5K3dKd21UOFFpR2NxME9nYTg4SkxncU5lUFYweGo2R3RSYTYzWDlK?=
 =?utf-8?B?bldiSlJLSmxiVERVZXNuKy9KWWpwc2VtUm13dmxidEFVRXBteHk4Mjl0NUVQ?=
 =?utf-8?B?OXRtbXUydmNycUNaRGQwRzduTGVOb2o3SXNjdHlHeFUrNE4ycnJGbi9mejlS?=
 =?utf-8?B?YmpjL3prcUtsLzg1d3UwVFFtNDFDM2NMblZjZnhKZkJrQXphS1VCajZtM2NU?=
 =?utf-8?B?eUdsMmpOSTV5UmlCQW1EKzVJYjFGOE9nQzZzaHgvd1UxckhkelBYSEdwbkM2?=
 =?utf-8?B?M09RT3h6eHJDRGpDamFuZGw4V3dqeExuU3loTVpZWDJTT3RCNE5McEVpajY4?=
 =?utf-8?B?SjZSU1VJMkZGMHhXWnRWZlFNdG9XVXpvQVBvUkJzM2FNRy9uZXZIWXExVDNx?=
 =?utf-8?B?eGpaOU5TVHg4R0REUFJ0M3BMdThVTTk0SEVVbUQ0SmVCeE5teXU1R0NEdmhk?=
 =?utf-8?Q?wEBpajyjw5U=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WmhVYUw1VUZKSTljWkVWY28zWUI0L3VPM0ZtaVpEc05VT25YOHZLdTYvTnVr?=
 =?utf-8?B?OVU1VGd5MTJUZVg1Wk5tWlAzVjhtT3lXeWtFeUNQRWQ3OU12RVpQTTJQWGJ5?=
 =?utf-8?B?NlNFRUdFZlhSL2p1cVVHUE1DUE1ORm1PZW9NSkE5TmNpbFcvQVdBY1l3YlRL?=
 =?utf-8?B?MjVrRGE1R0RyZHFqSjBzaE5HQ21hZ1BVZ1JwZytPSVhDczNlM21mSmtFcmRw?=
 =?utf-8?B?N2JUVjc2L09CR3RDUzFaU3dJZGFVK1pITXhoTXVEY3YzMXpTK3R0R3dIS3dM?=
 =?utf-8?B?ZWtoZzYrZVNidENBMHF3QVNjYUlwb2tzUDJUZzBWcTdnTTN0TU56eVNmTmdz?=
 =?utf-8?B?dm41V0V2RVFsMHRZN2pWUS9KWUhNQTRtY090UGNDUUluSmlMd0Fkemh1anpn?=
 =?utf-8?B?b2xINExLdmNWNGs0ZTdib1MxWEdodnBoOVE4cFIvdk4ydzhLY1pYV0g2QWJT?=
 =?utf-8?B?c0hWMGdzUzZUemhPZkpwL3QvbjNmR0hKYkxidnlhcnE0QkE5cm9QVm1ublR6?=
 =?utf-8?B?NjJZb2NtMWRVOHgySEhTbnZtTGQ4WHdmaXpNTGFGYjg0eU1oMlBKb2NOMWl1?=
 =?utf-8?B?VmQ1S0JDbXRFam1YTElDdnFrM09hTksxbDFMb1BXR09EM2ZyUjdGQ2x5MXIz?=
 =?utf-8?B?RmdOajYrdWRRbVc4Q2RJMHZ0QS84REc2NVJUZkpLTWpZZlBHb1k4dlhvY0lH?=
 =?utf-8?B?QkhkVVJkaHBjYnQ1dEd5QjRsWHZmdXhLZDA2SVRpUmFockFhQWtXSUc4SDRP?=
 =?utf-8?B?RWlkOGRTODNXcEtta0MyQUQzMWo2U09jdDVWOXlJTmJuVjdYbzBvWGtQN3lQ?=
 =?utf-8?B?dTNrYUhtVC9sM1FESVNzVlRDMElrVVNJa2F2N2ZJU2ZOdVduYTRiMGxSQUc4?=
 =?utf-8?B?NE1mSzNGMzJJL1ZUQmxoMDRLT294U3h1OENQZVQ2UUFtc0FwL1BxcVF5b3hT?=
 =?utf-8?B?RFJPWnNZa3dJZm9PUUlmYXYzWjVORTlpSGFpakZvanZ5R1FsbVliWnVraTc2?=
 =?utf-8?B?S3Q4MmFMN25zNXdBMSsxWlVEZTRQa1hJTWFQa0F4NTl1VkFrVlYrM0tKM0pt?=
 =?utf-8?B?U3RoS0JMNXhNNkMzZnFZR1FOWTdXY25EVlFmTTMyMFNud3RsY2FLMVZkb2hp?=
 =?utf-8?B?cXFLV1NERC9mai9zc3dxWXZQSnBRakVKNzhJbVljbHRpOHBPQnFXcEVOV2hI?=
 =?utf-8?B?QWVXMTVXU0hQMGhyeDNxa1o1aW9rQzZDR2NYWXBtV0RhM3JRYldTV01rQ2tO?=
 =?utf-8?B?Zld1cDJHZHAxSnZRL0M0OGVxZ2R4SzF6ZTdGbkM0QmNiWGdXd1JnOEJIenRn?=
 =?utf-8?B?MXpmUGtWcENaZXFpbEhJQjA4NG5pbXI4WW5SVE9BSW8zUWZ6K09WQlNLUWpo?=
 =?utf-8?B?UnRYQ2d2WVBZcWJPek0rQURIQlI1SHhJcm4zOFN1YzgzdEsydks2STBDVC9i?=
 =?utf-8?B?QUsrVFJBRlhJbXRDNVZhc2dqVEdqRjg3N2t2S3dpRDllRFd6S3d3OHdSeXBw?=
 =?utf-8?B?akljaWlNcDk0ZnZubTdKOWM3ajdQSDRDNzFXdTRKb3NueUU0bDFybnlIaHQy?=
 =?utf-8?B?NmxnVzM3aUNGciswUzlRZVcvbXlCTHVXZUZtblBoZWdNZmp6bVBSOUwxazZ1?=
 =?utf-8?B?ZW40RUZmKzcxamZPRFNaYjhBREY0U0U3TEhhSzY4NzJqQ2ZGbFJJcEVsY1Nr?=
 =?utf-8?B?RGo3dWl4OGFIcVprTExLcHlYSE4rZ05Uc0ZkQlFkaEVST2JISlVYY3lPaEdz?=
 =?utf-8?B?SXV1dm93M3J5VGU3ZjRHMTBucU9pWjhndzhGRld2alR2aVprb0lMVkZndTVK?=
 =?utf-8?B?TTRTVU1LM1lGOEgzSjVlV0xnblI3b2pDUkJXNW95UVVPU3RSeU1KR3B5NjI4?=
 =?utf-8?B?eWpCVHJmdG1SdHlKanM2ZDFsUU5wRGF1SE9Vd1hrVEtMd1hlbDY3QTY0UkJp?=
 =?utf-8?B?RWVZOXF4WjdlQ2hFSm11bzVaYUlRZFhFVDVtZzVXcktvK2NXcWJyaHA0YW8x?=
 =?utf-8?B?TDRwSXY2SXBvRGFhMS8wMmRxd2c5aHpnTkt6ZWU1aUZrMUIwakVTRklWeFdN?=
 =?utf-8?B?dTZhTU04OElOUnhYMUhUVVZ4ZFp2eTBZOWNST3JZNDFMaUpxN0E2bTRRYUo0?=
 =?utf-8?Q?mYcesARIGk0hUYEuVhZLGl27N?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	EFx/pPF2XEfYrL+uCrGPjTwlr7PAZzBf7Qb0xqhL8fEAMxSiusfNBFmOLScJrU9mow+DHBxg3voxpbO10AZeYLe4nlyL2O8eVqIMcREqWXzLqFkuIpQD/5MJQWoCfpGS61oXbwo8pMGbsKWXsvE1BrKk524VFV4S01tkVN/yPZpbjl5iR+DznYUcV1EZ7TSHORguKL0ONQr/iFVtoDyG++UY2fwhC7Xmri44zCHaYulF8TzUCIYOO9SbLHHD9FkrtV1b5CUQpxCYKPfZ3AwEHzZD5tvE77CkzgZorAo7nixlntSsDBYMozFPu7NvEuBWGbzRBCpuH5zqjoPZiQTOFdmNCadTqxpFGt1D8UZRIWXeMTpnb77CwbsazE4iKizw/ZhrITSJ43L/PxI2XQTNcbNwH3lIR2t7+dhpcN60XnGCEiXgvzi0MP3gqpKPGQodRTzk0qLPSD4fR/LRu9VKERARgPPJj7T7pWK0emm7T2iNI1St7WbyQcoO0CqIFKuZvTHlaGqoLp4KPiligGHPeLo882WCi22Lz8mEXW/8jm2XyRtfO2ntusE3ETtIXwoOiuiB2OUugw4yRa7eDfmns36e6j3rrA3a6Lpu9MDv7bo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62e3d334-9c42-4eb7-d3b7-08dd83073915
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2025 08:08:40.3431
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ANTpOCDP0W95J5amKB9oh9gxolyd37BlTw4I4MQZCDM4wSCBrp0of5P2VrvwEsZvggfIWJ7UfxTToFpjsfTjSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB8156
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.680,FMLib:17.12.80.40
 definitions=2025-04-24_04,2025-04-22_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999
 suspectscore=0 malwarescore=0 bulkscore=0 phishscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2504070000 definitions=main-2504240053
X-Proofpoint-GUID: buUtswGaxlDXrVhHq-wViwpgRJTz4I63
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI0MDA1MyBTYWx0ZWRfXxUeO4H1y6Jou JPNhagubbFnTGxRqYb45GgnXeCK7Yj/iiqnbbFTkS364g0mrGsz0KE9wvj6sKOnA6o3INekDP4y alAoTcyjn1JRKg9JStn1k9TlhJGSLJnyJNIuDGZ+T43Ipt35fHQIAEchNi6EvNFSRxIAUO8ByZH
 K3BNBbW5qHxqZUJ+JYPBGu2nwAdfcXTiYt1OA2Hu7uk4IREGJHkpEbTRY+YbG9mVJD2B+q6axj/ 0xZ7m1x5gJOfGOWVeBKqnQc8X9K3DtVuwp2rDvrsVSayeGciRYEi8gRGdLyCfYP8aB9/oQjpXre OLAo2x3juyzntlzdM9f68Tbr3znKgHnXOgQEpILNVVvCS3BPxT/jvGqlqQh1podOWNQpX9yUteX fb9olRrk
X-Proofpoint-ORIG-GUID: buUtswGaxlDXrVhHq-wViwpgRJTz4I63

Introduce percpu_counter_{charge,uncharge}_many() to allow explicit
charging and uncharging of percpu memory used by percpu_counter, without
requiring allocation and deallocation of the counters just to
(un)charge.

This is useful in cases where percpu counters preallocated and reused
multiple times—for example, when a slab constructor allocates percpu
counters that are (un)charged multiple times over their lifetime,
until they are finally freed by the destructor.

Signed-off-by: Harry Yoo <harry.yoo@oracle.com>
---
 include/linux/percpu_counter.h |  2 ++
 lib/percpu_counter.c           | 25 +++++++++++++++++++++++++
 2 files changed, 27 insertions(+)

diff --git a/include/linux/percpu_counter.h b/include/linux/percpu_counter.h
index 3a44dd1e33d2..6e6b0752b1e4 100644
--- a/include/linux/percpu_counter.h
+++ b/include/linux/percpu_counter.h
@@ -46,6 +46,8 @@ int __percpu_counter_init_many(struct percpu_counter *fbc, s64 amount,
 #define percpu_counter_init(fbc, value, gfp)				\
 	percpu_counter_init_many(fbc, value, gfp, 1)
 
+bool percpu_counter_charge_many(struct percpu_counter *fbc, gfp_t gfp, u32 nr_counters);
+void percpu_counter_uncharge_many(struct percpu_counter *fbc, u32 nr_counters);
 void percpu_counter_destroy_many(struct percpu_counter *fbc, u32 nr_counters);
 static inline void percpu_counter_destroy(struct percpu_counter *fbc)
 {
diff --git a/lib/percpu_counter.c b/lib/percpu_counter.c
index 2891f94a11c6..a9fe96787725 100644
--- a/lib/percpu_counter.c
+++ b/lib/percpu_counter.c
@@ -224,6 +224,31 @@ int __percpu_counter_init_many(struct percpu_counter *fbc, s64 amount,
 }
 EXPORT_SYMBOL(__percpu_counter_init_many);
 
+bool percpu_counter_charge_many(struct percpu_counter *fbc, gfp_t gfp, u32 nr_counters)
+{
+	s32 __percpu *counters;
+	size_t counter_size;
+	size_t charge_size;
+
+	counter_size = ALIGN(sizeof(*counters), __alignof__(*counters));
+	counters = fbc->counters;
+	charge_size = nr_counters * counter_size;
+
+	return pcpu_charge(counters, charge_size, gfp);
+}
+
+void percpu_counter_uncharge_many(struct percpu_counter *fbc, u32 nr_counters)
+{
+	s32 __percpu *counters;
+	size_t counter_size;
+	size_t uncharge_size;
+
+	counter_size = ALIGN(sizeof(*counters), __alignof__(*counters));
+	counters = fbc->counters;
+	uncharge_size = nr_counters * counter_size;
+	pcpu_uncharge(counters, uncharge_size);
+}
+
 void percpu_counter_destroy_many(struct percpu_counter *fbc, u32 nr_counters)
 {
 	unsigned long flags __maybe_unused;
-- 
2.43.0


