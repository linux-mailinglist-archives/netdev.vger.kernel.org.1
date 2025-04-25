Return-Path: <netdev+bounces-185952-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D31BA9C4CC
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 12:10:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A69941BA8707
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 10:10:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A31723A990;
	Fri, 25 Apr 2025 10:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="YVpLcpic";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="fUGxC1Zx"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B68423236D;
	Fri, 25 Apr 2025 10:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745575833; cv=fail; b=KVQlIFfOiN0iNqJFbKk+AqjmvCvPH6qpokHFDYWJ6cGscUBpHoSBozk8++dVTt0VPgNOBzcDeIR7yQGJGDbBp97PUnJQ1csFwrGr0Hg1GI20A10gCl5CifXyXG5z3yvx8AFAMz+wHY4TkUYRtB7ydNK6VuSb+S/jFeEKKfqB+AA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745575833; c=relaxed/simple;
	bh=JcqJvJujR0wZu3a7x7Q7uVx9in0qeGUQ1fGK3r8idfU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=MjaFiCL1ERWTxoQLaWZ1CDH6lxEZTDSP3/S0IX9GOVv/pUeSLyUjGXyQ24M1ertKc2q6NWR1Sa2WgsbvyKcolLszF6Oq+cdZEB+5DgXzi/gk2YWe85llfJVn8XB2sar4QMDN53NxP+Y3DtdvPSxm3vgiuZs41O8WXr5Lj2lxpbE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=YVpLcpic; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=fUGxC1Zx; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53P8iK8n018123;
	Fri, 25 Apr 2025 10:10:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=PeXSI12kg7mEmfQmImE0kUWvttusi9RiC5VryjawyxA=; b=
	YVpLcpicPOaj87umvS5EFbtxYY9Lb+TcFDtm1zzGtZpvKjM1sjXkdJ0JaCv/3ee6
	+PZQtq/z3cBNXee31T4ce4ynEX/ldNoFMdo0J/Qi9nCPahCLayPi9/qOyQUBHOAf
	1w2I35SzgCBjfmyKMQCA9sknClgKKwuyI+e+s6NiyHInFXoMpbpenQ9OtpGIpv7h
	c+2WYB1GODzJskmE5kQvY9605419Gu1hw9tr8yW+xEQVYQt4fDV1Jz1NylBtF1Vm
	lWIpKJoZuRrzK1jey1kRqfWEMOhucVwg7843FHV9zrvViQEF+MwzI6pLVZXjbyq7
	5lmZH8WvVNinT3rY0fjhHg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4686ev86u8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Apr 2025 10:10:16 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 53PA5uxr031173;
	Fri, 25 Apr 2025 10:10:15 GMT
Received: from ch5pr02cu005.outbound.protection.outlook.com (mail-northcentralusazlp17012051.outbound.protection.outlook.com [40.93.20.51])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 466k08e756-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Apr 2025 10:10:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CcZO/DvQ9MAN1L+Duf1i/jt7OYhYQ35UCuHFWT8dI1mb6T+BLBO29LaMq9cUCAUI4obHtkl0geprQl1bDCjXrR3f8rshzIC766SB8SVNoKsBI/ME8TEy5zBx8MINZsmv+VtmP73sJa+o/29gIMuIJCnTZu41FQZU/7+ETZoUBYlFAwyn3rIKvpSWtv5AVKhCqLszk9XmeBeE8rYeoMjsSf/iNNt0k1qszWL31mL1SxUm0W3gHkuNOeEMI0gsuzokQ56/lbXDSRxAecuRRw4F0GrQrJCj0GN08zBN2lgjhyyvL/1ir7Toidw0uX6gK+fxAMCdFJVC/4IZxBJuN5LNnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PeXSI12kg7mEmfQmImE0kUWvttusi9RiC5VryjawyxA=;
 b=gS7RRHUIIP2+sUzVxiRx0qwhVTZxskVk+RAMMZ/XLp53Z2B7g1LGV40L6gJdFbNRc0p1oqFuQMdKrhJBvoHZaUd7tsXvN122FWredyKi7AhknAm30U3DY7tmpX5yPun84PuGMLmrRlFHtZwKz7UJ3SkzFDebvHq/cuM/AygivKDKO+sJxE/p0zWHQWdRjm3lytTB+KGheGp5VFa4+CkoaA8sW4LsjwheGs2ywbH03kXxJZmR29xUuSoYlblBf9vZIdfWGGk8RJJP9kf3eKe4MqHzZ/dDeIUuF3af9Kcf+P8rWdS5yjei5rwdZrw+a/+N8eGyjER7gMgPDKMH+uPd/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PeXSI12kg7mEmfQmImE0kUWvttusi9RiC5VryjawyxA=;
 b=fUGxC1ZxACS3CRiuHrgNOaHm9dckpI2uA2by2s0XUVlfqZbuJmmTdWUK5Iuj8e6S35lO9uIP+lyHY1qBvq/Q7aNBdea3HgcGVN4DntpN+eFGYGSXp886Lq8HqL9y+soN2QX/9ZzYvGQ2zJo3AGvUdcw3sRPOpN/6bXkLc9cdCTA=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by SJ0PR10MB4527.namprd10.prod.outlook.com (2603:10b6:a03:2d5::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.26; Fri, 25 Apr
 2025 10:10:12 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23%7]) with mapi id 15.20.8678.025; Fri, 25 Apr 2025
 10:10:12 +0000
Date: Fri, 25 Apr 2025 19:10:03 +0900
From: Harry Yoo <harry.yoo@oracle.com>
To: Tejun Heo <tj@kernel.org>
Cc: Vlastimil Babka <vbabka@suse.cz>, Christoph Lameter <cl@gentwo.org>,
        David Rientjes <rientjes@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dennis Zhou <dennis@kernel.org>, Mateusz Guzik <mjguzik@gmail.com>,
        Jamal Hadi Salim <jhs@mojatatu.com>,
        Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
        Vlad Buslov <vladbu@nvidia.com>,
        Yevgeny Kliteynik <kliteyn@nvidia.com>, Jan Kara <jack@suse.cz>,
        Byungchul Park <byungchul@sk.com>, linux-mm@kvack.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 0/7] Reviving the slab destructor to tackle the
 percpu allocator scalability problem
Message-ID: <aAtfe1-ncE_oxt9H@harry>
References: <20250424080755.272925-1-harry.yoo@oracle.com>
 <aAqHKWU2xFk2X2ZD@slm.duckdns.org>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aAqHKWU2xFk2X2ZD@slm.duckdns.org>
X-ClientProxiedBy: SE2P216CA0192.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2c5::10) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|SJ0PR10MB4527:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c1fbc7c-c53a-4904-afb0-08dd83e15d94
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YVhCdzNBMlNTa1ZrR3NnVmxnMm82T3huWnY5Q3p0MXNURTRoVi92VG41cWVi?=
 =?utf-8?B?QitLSytKRWlCN3JJak43RWl0UnNwSmxoNE5CQXdHY043Y2U5NHByK3BYWGxm?=
 =?utf-8?B?L1RmZkIrNjEwK29IQzRqdzJUYjNJbzhYaWlzVTQvZHVDcFl6eWpUS0dDZm1Z?=
 =?utf-8?B?UDA2VzBOb1ZGdnUreENZOXNvZGJPb1FwaFJNR2RCR0RFV3lIVTdZR0VEcklv?=
 =?utf-8?B?S2RIcW42Mm5wTmwrRGZIZlBnVXRvQ2pSVUhQbTJySFVTYWhqbllLMFQ5NmhI?=
 =?utf-8?B?aUQzY1VXYVMwcHdkRzRpbE9ZaVZIRnNWWHZNK3l0cWdhcjZ0ZmNzdnE4aU9h?=
 =?utf-8?B?VXFlMnVzT2FOMTJ4N1RyY2FMN3hYc1lVTjZjN1AvaElFZEkrNUJSWnAyclZ6?=
 =?utf-8?B?eUVkSUo3L2orVUQrcG56Zkd2VUQvQVJ6R0hMVWZOOVdWRkovYVp0aGVYZzRr?=
 =?utf-8?B?Y2RNZ1RNdXQ2OGtDemZqV3BCZ252N1IxdStVOHI0SkJJOTk0MFVpaWUyM2Qz?=
 =?utf-8?B?VEtrQkVKSEo0ZnJNY0pVUG4vYUN4c0ZOUW80L1E4czBaY3pEVmROMDlvL2FV?=
 =?utf-8?B?S0xzM2VtZmVEc05Jai9SbWtSZXFlVEZCVzBwZnRBd3hRWFVocFhPN3VkU2tj?=
 =?utf-8?B?bk9pMVFUM2ZwejhraGJtNUt5WTdQcDQzRnREVUxuOThxRVFkd3BTWXFuK1NT?=
 =?utf-8?B?OVdDY1NnYWpISjFQQlpIYk1sMndrTWFyVWFpMUcvdUJMSDIxdjc2WThNT2p0?=
 =?utf-8?B?WjJxUDRDd2xBazVnWGQ1M2JZTDFYdDliazMvelh6enBmV21WS3cvNmlNZWZx?=
 =?utf-8?B?NS9GNDJLaFkxTUhVWEhLUFNQanZyQ3lsZmgxRjBPcUI1Zkx0YW9WZzZPUWFT?=
 =?utf-8?B?ck8zT0JXNzNHcEU1bFJuMHFSTHQvaStJd2F3Rk9CekhnajJaTDBKeWJsekM0?=
 =?utf-8?B?MHlsckFJRWZNN3ZGWmRrdUEwekRycENqSkJVNnA4TjZKSmtBbnNvNzRxNzlw?=
 =?utf-8?B?ZFp2ZHFOaDlIa01HVldMNDdUQlF5cGNQNjljUVhLOTVuanVlQzVWQ05IcUEy?=
 =?utf-8?B?eHBlZXo3YWRRazJTRzRzTmFTV0RKVEZRTDMxdFFEUk1rQzk1TWZIanJ3anJL?=
 =?utf-8?B?aUxHUHVseDRTTE5wMDdjbVVJSDllR1FaTWovQ2pxeGpLVW94d3daODlrYW9T?=
 =?utf-8?B?UjFKT1JDbnVZS21yVHdKUnA1M1RybzBpNXAwODByQXgxVVN5OTJjOTM3UUVq?=
 =?utf-8?B?SW9NbUZjZDg2UU16bDY2R1l1aHM4UGQ4OStkMUZiaUJ3T3YyT2Q5WFcwbUx3?=
 =?utf-8?B?alloYndQODFUQnZZWmJEalRPdzY4VWE1ekloMFozOW5OY0R3a2lNSzJ3SjR3?=
 =?utf-8?B?UUlEcWJTQ0tta1RBbHZUbnY1d0VISks2eGk0MngvVWlBNGErTzQ5ald2Nmsx?=
 =?utf-8?B?aG05Z09BbW55SnJ4ZG1ma2F4ZkFIZjdvREluM0J1STlRMktqTzc0ejJLWnZY?=
 =?utf-8?B?MDZhV1FpL3ZPVjI4QjVXdUtmNU9QMGZ4Wmhjd0NQVzlWcmxBQnkzdWRIZWZm?=
 =?utf-8?B?a1ZtdEpjUGRJSGZlNEdEMnNQbEQ3eFg4KzU4M0xZR0wxbjBzZlFVT2twblVI?=
 =?utf-8?B?cHU2cWVFZk5HS1VkSzNqNlh1b1Y3M1ZhWDZXdUFtT2E5cEN4bXdVNXo3OHdV?=
 =?utf-8?B?SlMxNlJoR2MxQTU1c2E5NE5IQzJtN2tYWEwzL2M1VTVrVzgvMlQ3Qm9zNzhP?=
 =?utf-8?B?QkFkUHVUZFFuUHJzY1lvVC82c2R6OGEwOCtzSDFJRzNYQW1IWnhORHV2dDVT?=
 =?utf-8?B?YmRZSEs1TGkybTBER1Eya1gvQ1BWRFRPUWhwdGErWXZvVGdLRDM0dFE3MG1N?=
 =?utf-8?B?SEJIZDZsOEtVelcxc1RWeHBXY0V1Uk5WOTJrNWtWdTMvK1hIeEdNV0VPQ1FR?=
 =?utf-8?Q?NF7wBCJjobY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RjlWd3FXNUNlazk5SEFWajdOZVNDT1RNK2FybktnS21zYTdvbW9XU0ZFWFVj?=
 =?utf-8?B?L01oQmRmaFkyKzJYRUxoTFZGQTkyekJ3ZXZLdXZHNVZ0TThoMzNmd1FaT3lM?=
 =?utf-8?B?T1dyS1g3SU5GY3RFdjJtcjhLanlUTTcwUmNZMFhQeDhXQk8vaFlCWkRhMVln?=
 =?utf-8?B?b2xSWTV3NDZ0N05xV3hIUlNXa2FOdFU0SGxNalB0dzEzL2IwNTV0cElpb1pC?=
 =?utf-8?B?VTJpOUJaSVowL21lckZaYWhRdWRHRXQzWTBHT0gybHFGQTBhWDVYeDRaRGhK?=
 =?utf-8?B?aFkyRXRqR3JnUEY5QStNOTBlcjY3UUs4WEwyUEpWK0laOU9HWWRVT1l2cEx6?=
 =?utf-8?B?N3hsRlVQdUZwL2Z0bThyUW5tanZlVExSR3dPSVdnaTBmdlp4VE1IWmhZWmZj?=
 =?utf-8?B?eW9mMlBsUEgxNzFWQ2hVczNUWlRNM3BqYXk5ZktYblhnd3JtWndkdlIyYlph?=
 =?utf-8?B?ZzdnblViRCswTHhRNEhHRk1xTk1ISm5wbytQVnNkYUdncCs5Sm1jUHlnM0NH?=
 =?utf-8?B?VkNZTmF5OUl1cVpqalE3c1gvL044Q0RLOUZSdHBNakNqNkNnaUJPSDNPOVB6?=
 =?utf-8?B?SDNmeHVWcHBobXAvT2RwN25NWStXUDl3UzI2SDZNcHFqL0xYeWVtM0pQb3ox?=
 =?utf-8?B?ZlVkVVJ6Q2pMR0dOQUZoK0dmb3hGZUxscFJnSHl0UWxIaXhBOS9OU1p0eFpQ?=
 =?utf-8?B?UW1zaWFRUkVOcThpMlFIcGlTTm9qRnF5TTA3SzJCT2NGZUhDc0dycWUwSXJZ?=
 =?utf-8?B?N00yQzJ3ZUFxTXBKVWEvdk55Z00yM3h2eHpnVjNzTlhCeW5xcmhDcTNXVXdJ?=
 =?utf-8?B?Q1dVU2ZwSTJFNytvVHpKSXM1eTlsbWtaM3BOMURMY2ZSUFMySmtyam9OZEsw?=
 =?utf-8?B?QVNuQ3ZCQ284OHM4eVpxWk5tK0xNcUw1S3d0MUtqRjVUMHh1WkQwNmlSWGdR?=
 =?utf-8?B?YnhPbytFSTgyT2pGU0NzQkZzQjJ0VTNDQUNzYkE0WG5yUTJ3TElXc2xNaWd1?=
 =?utf-8?B?VTY1NDRsVi81QXd4b1pwc0p2ejFqRmc3VmRlYytQK2kxdzF3KzBmc2pETG55?=
 =?utf-8?B?YVlpUFVuRzlqTk05cmhnZ0NsZURiTG4zaDRGOVcwTU1iek5kZ3JMWklpNFJO?=
 =?utf-8?B?WVhtekQ2cHNVeTJGVStVL0ZFUGlRRTk0Sk9ldmxpY05DT2M5VTJQZlY5a1Rs?=
 =?utf-8?B?VHdBQUpJODF5M1BVd0VDd1FGMVV4MUY5QUlwcS9KN1VRL0V1SnA1cDRkMXMr?=
 =?utf-8?B?di9XeTN6ZlVWamFsOWgrcWg3WUI3ZnIvK0wrb2tTSEZ1dUdCKzBhSUhEYmwx?=
 =?utf-8?B?bTJTbTY4VHlhb2ErV2JXSXlpNzBRSlpYNTN5aDFEWW05KzB5ckI4bi9uSWhW?=
 =?utf-8?B?TEFKc0dKazZWVmpzTUgzbGZyNThJWVFXTUU2cTd2SHhhK0tZaHdBZUZBakpX?=
 =?utf-8?B?SDhiSEU0eEM0OHBkME1vVEJDUzFkSG52YVNadmp2TSt5S0xqRW5LUlltdk43?=
 =?utf-8?B?aXloZURmMWN1Zk5qR3B1Q1gyeDA3TWV1OTI5VTBPeEJQRkt4czh1WHhqMW52?=
 =?utf-8?B?b3Y0N216cjVDSW9kN3Bpc0NzMDZyc3JnUnNNVS9yam54WmhLRTVRME1yVG5s?=
 =?utf-8?B?ZHMyNUFranE5c0dDRzVTa0g3RVJ2QVJmRHQ2emUvRGNPVVBrQzl1MUhIS0ZO?=
 =?utf-8?B?N0s1RDd4eWJGaXQ0SEQxNUowMXNTaDVyTEpaYUovSG5HcWtOQVRXOXlCbWhm?=
 =?utf-8?B?VHlmRW5VWDdlWm9VWnpEekJyTGs4VlNlazdhdWdhVnVzaVNRZzhXbVd0UC9n?=
 =?utf-8?B?dWZXOHB1Nml4SXhtaE8vbytIZWxVWFFUMzNUallPZ1JKWStWRGRXK2tqOEtP?=
 =?utf-8?B?Uk5hMFFPN1lDUkVDdFlaRzhSTnRubFBaMmtjcHQ3UFVPSnhod3BIS1NkRFBD?=
 =?utf-8?B?SE1uZlp2WXNLNkRFeGdmNVJabllpYjUrc1pWQUZVeFM1RXlSSjAwY0loRUQy?=
 =?utf-8?B?L01DbVBXT0x4OVJRUm9aZXNoZW1BdnRCK2ZmV1pvMHErYWpOcnNONkpBdjlz?=
 =?utf-8?B?M3FPM3k1TTdtWWRwNWFMaWcwVkR1bVQyVnlnVXY4NzNVellzaUd6UksrV20z?=
 =?utf-8?Q?TrcEh/1nyCGwvfbxtco2VumC6?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	94UN59vU0LjFeJLwhxpjFj+ahGsCbTw+h4ukpW1spmO9AenSWkYeZq/S0kF773Ufz3Wc8W2tpRukA+CyIAkRV/waGtj2IF7hqfsRiSNznQZE/G7CCzili2g3xyACfBPoRZRUY7q9Q7Q4jIQPwX72O9m5995FJe/jMtScdEONMW28z0EQ9eKTfxzR5ZFcCO1MUKYTiRtEYky+VuaYG/v1GPG/WzzV0ZwmhFPvYoVPQ7HsMjHn6JJwc4iUJVKhITkQqLu0Mdh/gq3o6gejNqMHL8SbMyjqRx8lOlxFw0mSPzzuEXIzmxDB0/ghS2BBEDltO7Mw+AReQTy9shTYy6bAlStf8cOElwxQ8DCmUa9n2ZTvjABSnrZem/MO1QCQuDnve3UHHY2IlmjlzXDM71gyDxHjr1/SBg6cyAg7dFgsZUljsAXnWPenfd1QAChb23H995gPrgAFfwSnVR51GCx9XHfAjZ6k8RcWXjhQRkhqBeP+az9fyB9mSaay1mYXJCmyLzZmSvj6ZPUhuG0EqXvEF7f4110jBuC3Ttak5IBRDad7yj8XoCq7SQu/wXt2uO3j/M7eqbWulILrxi6eTxZuBAS7fEvv+QjRcy+7HD/7j8w=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c1fbc7c-c53a-4904-afb0-08dd83e15d94
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2025 10:10:11.9802
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k/VXRrAjq5YePdkL7FT+FUvY0/ei9FjJOCyniN+mg3pSm8SoGZbiIfpHOdf3Lotrf5WN0HAYqCmr1MlvSgU3xA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4527
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-25_02,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 mlxscore=0
 spamscore=0 malwarescore=0 mlxlogscore=974 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2504070000
 definitions=main-2504250073
X-Proofpoint-ORIG-GUID: lHBVZ4u7dwLEaKJOcq0eWUmoTXMfjEUK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI1MDA3MyBTYWx0ZWRfX74f0TVAo7CQj CMN2IWGGpq5Dj/IfFS4FsgdNWblF4uRu0ZibXV/WXzUdMd/BfRvp/kqNvHj5xOAphyoezY3/c2J KtEkBJzL26vcImG2sLNkU4iky3SexpyZHBf13ccTmU1r8lithHn/2+C4LLHWhdCvez9f6Y5pl6i
 aA1Le5UownK+54uC2rJMmBJlFt80B8fGJIC9VyedxgPYdotTIw+SyQbb2Bg0A3DvWRFtvc2Z1Mn M+h9XIqJCewbynYJpcSBfq+/jXu0ANARzKAmFEgXlsAf5rflEDRO5VbirXJGpj0inSOS37O43q0 738xY4q/0ESUZQCly8g+T3jigI6cDqmFbDa2ECSgeOpgiOnx2ZRnqyljRW/ynzTtW3DheihnNA8 x6tWN5Jm
X-Proofpoint-GUID: lHBVZ4u7dwLEaKJOcq0eWUmoTXMfjEUK

On Thu, Apr 24, 2025 at 08:47:05AM -1000, Tejun Heo wrote:
> On Thu, Apr 24, 2025 at 05:07:48PM +0900, Harry Yoo wrote:
> ...
> > Eighteen years later, Mateusz Guzik proposed [1] re-introducing a slab
> > constructor/destructor pair to mitigate the global serialization point
> > (pcpu_alloc_mutex) that occurs when each slab object allocates and frees
> > percpu memory during its lifetime.
> > 
> > Consider mm_struct: it allocates two percpu regions (mm_cid and rss_stat),
> > so each allocate–free cycle requires two expensive acquire/release on
> > that mutex.
> 
> When percpu allocator was first introduced, the use cases were a lot more
> limited, so the single mutex and expensive alloc/free paths weren't a
> problem. We keep using percpu memory for more and more things, and I always
> thought we'd eventually need a more sophisticated allocator something with
> object caching.

Yeah, when you first write an allocator, it's an overkill to make it
too scalable. But over time, as with other allocators, more users show up
that require a more sophisticated allocator.

> I don't exactly know what that should look like but maybe a
> simplified version of sl*b serving power of two sizes should do or maybe it
> needs to be smaller and more adaptive. We'd need to collect some data to
> decide which way to go.

I'm not sure what kind of data we need — maybe allocation size distributions,
or more profiling data on workloads that contend on percpu allocator's locks?

> Improving percpu allocator in general is obviously a heavier lift but that
> may be a better long-term direction.

Yeah, if that's doable. But until then I think it still makes sense to cache
it within slab objects, ...or probably even after improving the percpu
allocator? It's a still churn that's incurred during each object's lifetime
regardless. (Need some data to see if justifiable)

And, as Mateusz explained, the percpu allocator isn’t the only motivation
for the ctor/dtor pair. Other expensive serializations like pgd_lock and
percpu_counters_lock are other motivations to do this.

-- 
Cheers,
Harry / Hyeonggon

