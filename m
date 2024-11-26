Return-Path: <netdev+bounces-147521-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 286059D9EC9
	for <lists+netdev@lfdr.de>; Tue, 26 Nov 2024 22:20:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A1BA165463
	for <lists+netdev@lfdr.de>; Tue, 26 Nov 2024 21:20:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37F481DF27B;
	Tue, 26 Nov 2024 21:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Y8v5KPWy";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="yHb6wfrm"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E38A1DF73C;
	Tue, 26 Nov 2024 21:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732656007; cv=fail; b=Jw0Ct6AzfLGAz3LMzrbe5rkkB/UECebEoY+cDWQ03LSK7HnIYpQxOZUJQbpQhXzOiibzU+8QCKYEChLQWCl6v5Ge8VOBckg8UC4MwiSx7B7IUmsO/R/2uxZchksrtPt4kaFXRl/bX2WgRuw/y2CgQpm35MXDJ+idaTJhsJXoprY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732656007; c=relaxed/simple;
	bh=EwGIsuXcXTvi0RUv+KnzegRWGRXLQZ64FdRfVEciIdA=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=QyueWkzJA7WdGNn9+LeRQ00fF+A0wlmbulgRt9gGpNoIaZkMkiSUxNuWcNfdgRvi9cV84gF5qKVg5v7w47Bzx/fTRS2icrYZKcdBikmFBv1VqQdao8eK4AC1sBNZ34aCe5D/eORN2pZAN1Y2v9VCqWpsfIGCNX8bLWowdIZ2qxU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Y8v5KPWy; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=yHb6wfrm; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AQLBY6G005351;
	Tue, 26 Nov 2024 21:20:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=2xpLcx5hVKH2v+fw0/aTytCZwoDR4WeqwHq3bDRvjkU=; b=
	Y8v5KPWyTTfVxmH56d3URwbNARxX4xbg0uysS7SVxXDFOVvCilKys1Mr6YLY4gai
	wU78dVKzAHGOfcf+Nm6fi6zvinB+jYDJwnGSgwj9GrSgfT+qk8BJRaRpbbErQY3e
	cy+jH3HYWOpodVP9w7q94J/WcrR9ltmr/hyT+aD/Xo8yvWwh1drGarNX6m4iF3tS
	R7ZGiiXEe3PeSPDWJvIT6p9NmQpBy6TTeaduAZ6Ca5DXKI0tIERU0dJymlBgMXby
	PZsQENEdqsUmlcLaTXjlrhrGYVwUiaIyw+d3MM0+93k++StKf7qmZlv8M3xDwR1P
	Jtofu9ZGjdVT7cJ0X2IRRA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43382kefup-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 26 Nov 2024 21:19:59 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4AQL3Mqc004590;
	Tue, 26 Nov 2024 21:19:58 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2047.outbound.protection.outlook.com [104.47.51.47])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4335g9h9yr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 26 Nov 2024 21:19:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xBOgevG9Ym5falvvamIKJqrLC22bcvzj7fBY3Z/MUliH5Ull9fi2C3n58yPlAA303J34UxIXDKYOZYYLWUTWa54dt1bhW3yOVdJOtUvimBAefOf9uskboZZzLpzIetKqibiInQ+Up6GZBjsrBsGep91Xha7pf6IJcuX6A6rpxQ4RHnWuBEiDfRdTRlMq753jR7RczQ7RGJKG6UXcQk5JGZDD2VDlwCgS749yk+nZIxZv5GVq6xcpBnIK4h4zlq6/fULOu2gbSXiR9FKSvhLJa40iucNcwX7ofzVxVNoJ2SNtXFDESomEsUSixf6sPk/FCdEMX8atj1RMzjXHVK8nSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2xpLcx5hVKH2v+fw0/aTytCZwoDR4WeqwHq3bDRvjkU=;
 b=Y4zo/JDsmUfp9IZ20Gel6kkurARHpzcJPKD33yLWuLC6Kv4cJ2TFfT4+7z6w3zby4bUfpHv5peNjImqR79G3YIoL0Uo2Tltstyc5lqE58lHm/fta1h8sKY3K+NdkrRtKKxuoT6URE0fxjgjc7k7hHzBhRNGg+OmToNmxLDc13siJ1zZsX3k+qsYqEqWQI7PrLdVfqxDwNWEvpZmPoNr0wOJkcU+mnbSEPAMPvb1VZtfPeAYWR53j6rExAbqITBMFfj4gve14MgC9wGzM546Ms4gRsoFe2/nQPo6gvSWoyqDwemiPTK2OYplZ27WVbrpohXeF4alHzk1cHCe8wOaKpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2xpLcx5hVKH2v+fw0/aTytCZwoDR4WeqwHq3bDRvjkU=;
 b=yHb6wfrm9mrSKjfoGKqLYPUd59KzFXApX77+kxsHA5hKVM3DcLBAWAc7E7IDCRpKkDcUzdpeq6Y746gOqtt95h6U/W5hxVIxsxWYtx9ktghOOM9YZy8Zwd5wr/JwRXZmY/g5/2Wunr5iKqyrNrHl2j8AvsuhG7l9oTdFE2U2MzY=
Received: from CY8PR10MB7243.namprd10.prod.outlook.com (2603:10b6:930:7c::10)
 by IA1PR10MB7237.namprd10.prod.outlook.com (2603:10b6:208:3f7::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.19; Tue, 26 Nov
 2024 21:19:54 +0000
Received: from CY8PR10MB7243.namprd10.prod.outlook.com
 ([fe80::b779:d0be:9e3a:34f0]) by CY8PR10MB7243.namprd10.prod.outlook.com
 ([fe80::b779:d0be:9e3a:34f0%5]) with mapi id 15.20.8182.018; Tue, 26 Nov 2024
 21:19:54 +0000
Message-ID: <5dcd0aa9-f098-4aac-a053-9693761ff550@oracle.com>
Date: Tue, 26 Nov 2024 15:19:52 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/9] vhost: Add kthread support in function
 vhost_worker_create
To: Cindy Lu <lulu@redhat.com>, jasowang@redhat.com, mst@redhat.com,
        sgarzare@redhat.com, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
References: <20241105072642.898710-1-lulu@redhat.com>
 <20241105072642.898710-5-lulu@redhat.com>
Content-Language: en-US
From: michael.christie@oracle.com
In-Reply-To: <20241105072642.898710-5-lulu@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR03CA0073.namprd03.prod.outlook.com
 (2603:10b6:5:333::6) To CY8PR10MB7243.namprd10.prod.outlook.com
 (2603:10b6:930:7c::10)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR10MB7243:EE_|IA1PR10MB7237:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a34b5f4-e85f-442a-7476-08dd0e601260
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WFEvOUVhTUtQbUNHWmxtcFJPZU4xRThpRnBReTE1a3Zhd3ZEcTJTWmhUcFVP?=
 =?utf-8?B?V0ZRdmJ2MWtPUitaL2s5UUY2UytpYlIzQzlhejREOXlIdjZEQUJuTkw5N2Nx?=
 =?utf-8?B?WFNldy9FUFBENncyQUxGWmNwQTZMRHdSanJrMkNydUVDbUFQK0ExOHlXV0ZF?=
 =?utf-8?B?anc5SjNCcTBSRjVGaUF5eUNteGxtNHFRK2pqQWZUVUwwZ2NXdjV3c1gvaDN6?=
 =?utf-8?B?YjcwTC9rSlFDbThmT2c5VWcrNzRSRzcyRFZCZnNwMzFlRnpNUmxBUVRydm5r?=
 =?utf-8?B?c3VXVUYrbFJSeVA2enE5SUtESnQ2YzEzODBjclo3S3Z1OGlUYVB2OWdMalp5?=
 =?utf-8?B?TWFrSlArbm1OU242dGloK2tHWjhqT2tjOXVld2JnOERIOUZxTFFKRFBHR01k?=
 =?utf-8?B?WFBuVzJxeDljd3Vvakg3dGYxRGZ0YkFwMGxGcmxvbmpCNFRRa1Jpalk4b1BT?=
 =?utf-8?B?dG9JdVhWUFBHZndEaWhJS3dNUHZzbzZjcGlpYTJVb3hhQVl1eVJkYklhcUww?=
 =?utf-8?B?S21tSFVud1VyTW5CRnFvOTZUN2oxNFZBUHVFSjZBUVEwNHB2WSs1VVhPMkZR?=
 =?utf-8?B?WnF5ankzNHZKYlJxVDNLekVxdUVxemo5R0wvYlY3cUFuWU55MzNtdUhPTGVt?=
 =?utf-8?B?d2NhZHZvcGNMeW9teDh2OVRIWE9SVjNkTSsvYWwxVVZxcHZMb3BZVDhFZWRV?=
 =?utf-8?B?OHN6VFI4RHhVaTl2TlNEWUMyWXpPRGtDOHN0WXQydU90Tk9MSlRSVDdoWWRr?=
 =?utf-8?B?c2dSMGhaNnZmT3d2VisrTHdZdEFGTWo5U0Y5cGJGdjM5QThLaG5OaHRZWWFC?=
 =?utf-8?B?Q2tmYWxONEE5aGdIdnF3S2JnUHRkTW9Xd05rVitjTHNpMlNnZTUvdS8yMWQx?=
 =?utf-8?B?SDV0Mkd6Skl4NWRUcXR0dWxtaG5mWWd1ekdhTU84djZQbmI1cUltaUxpeHky?=
 =?utf-8?B?cnplekY0MmZKTTAzN2U1Nlg5dUV5alZ2dWxEeGVYb0NNRmRVUVZ6ZHdta0R4?=
 =?utf-8?B?WEsrcW5UbTNvTjMxSC9pTVUzOVFmRThoL2VUSXVZNnJtWVRqcThlK25GL1Yv?=
 =?utf-8?B?cXR4a2NnQnh4ZnljYy90MjVJeCtsT0RnakVZOXZlNVdvRzZXeDhwc0RtYnMz?=
 =?utf-8?B?UCt5OE1QSW9qZUYvYnNPQ3ZodFMySkVTcVJ1Nm5YVGMybjFwUHRGUGNsN0g1?=
 =?utf-8?B?WFlYU05MRHl3RWxibThPWE9Zd1hmUkh6MUQ5ekJLRWkweE93bk5LMWdhMFly?=
 =?utf-8?B?UUdQVExENFhscGlFdTBFdjhMRFM3Q1F3YVhhOUUzLzFLRHBHNnpUVlVHU2do?=
 =?utf-8?B?MU5LeXowRm44SFF5WTRQY3QvTG5PdzR4NE5DekNoSjRQaVk3Q3I5WHFla25a?=
 =?utf-8?B?dTNaR2w3b0lrMFlWQ3h0SEpRakpyd2RabmtMYUhiWDRSeXR3dUFPTUZJUUFB?=
 =?utf-8?B?ZWZ0WUhOV083YktHQjdxTEJxaDhOVGF1d0ZRVXVuUVlYcFlFUlhBK2RadTFo?=
 =?utf-8?B?QnVGVS9TYzBnZE1XcDVIdk8rWW5HY2tGN2xJYkRxZjI3cmZ0YmJYNVArd0RE?=
 =?utf-8?B?bDRadytGTnFXUzNSQmlMSWF2RHU5UU15bVdDQ3JRTUwyaWVoMnV1Zmo3YTdH?=
 =?utf-8?B?dmk2VjRVRVYreVdVQ1ZvYW9PZ21lN2tYSFF0MjIrM0NlYWpmTmNIUmZtNnp4?=
 =?utf-8?B?a0UrL0VYb01uSWVjK2toYzZWdnVJek9VdHFINGlpdzg0dWdwZGRCWGFiNjJh?=
 =?utf-8?B?VDB6cklubXhSY2hVbE1xT1VXNHB3b2E3SUoybGdLQlVwK0YxcVliWkRtOEg4?=
 =?utf-8?B?MldMcDhJNm9SN0huMnF6QT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR10MB7243.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Y3dCdUZjSE0raVNkSVZSaWhOSEhkSFk3Snd5MVZDZVlEcnZtOFNBdW8ybVg0?=
 =?utf-8?B?MEorbWpOQkljSklVWWUwRHU0dVF3K0FoSmZZejRmLzBkb2crR0pibU5JQVFS?=
 =?utf-8?B?R09DOXpBS05MdEpVaVM5RjRVOCt4bklyN0MxQW5pdy84OHVPUUZ6ekQvNTlL?=
 =?utf-8?B?QWFwVVBxYjlNWkZYLzdaYmkvck5CNDhnbzh2QVpxajhxVGFwdlpHSFN0TFIy?=
 =?utf-8?B?SVI5T1QrUjZpREhWdU9pcFlIdTJFRThIWDJzWEl2VFdwWEdqanZMczQ3MVhM?=
 =?utf-8?B?ZWdDalFqMHZTTHJyaTZuVzAvbHg4b1hjYVJIRC9Jb2F5Z05pNFFGbWhvYXVL?=
 =?utf-8?B?MFVCYUp5NVRWRmYxV09sS2lZbEVkU0xPTTNTTGNRY0JUMmtTU2ZTbE9XUWpN?=
 =?utf-8?B?S2pBdDRDSDRXNXYrOG1rVW5PaVJZL2k4OHVHZWJLSjBKZW1aRk5TeVZLWFk5?=
 =?utf-8?B?Nm9GVzNrUThycE90Y1lBZE5Jb0dHMkJHc1hpcUVRZmRlU2NUUTUvdGkzU2RG?=
 =?utf-8?B?eW41RDdMZlp2M3NzVUk5N3NidXhxZ1c3TFFxUzhiUm9vRm1YL0wrQWU0dmRh?=
 =?utf-8?B?U1g3dzFLUTN1c1VVY1h0SjQ5cjNBbXBjb2VUWkR2czhsWk9jR3ZlOCtuL3VK?=
 =?utf-8?B?MitlYTl2OHV5K09jMEZTeTdYbzFPVWo4VlBwdlgvdXE5TjhXQVlsKzVBam0v?=
 =?utf-8?B?U0dhRllqWmxzbm11VnVXSnNaZ0d6ZXRydE9STEpZMnlWalJRaFdBNUlYWkNB?=
 =?utf-8?B?ZC9nay80TXJ2UUtPVUVSZXlMM3RNYitkUUZETExWTnppMzJJV21MWTh1WHJV?=
 =?utf-8?B?R0pzTGdGVEkvTWxjeDBxMEgzbTZzT21MTHlHOWZMbzBZVVRlc0hqbnZCbWFT?=
 =?utf-8?B?SlVWVjM3M3VMdCtnbVhwRFVDU3NkSFpBRGtUZ20xRnRGUEhkQm1TaW5aWHI3?=
 =?utf-8?B?b2RIU2c1dWF0cmxSV0prUDRaWlYxZHRmaUNibEt5alN6aDRLcyt0aUxhN3NS?=
 =?utf-8?B?SHVpOFkxWkhlMmV2RlVPR0M1ampjeFdQSVF3SmhWQUdDQWppek1YaWFla3JI?=
 =?utf-8?B?Q1NkSVhndG96a1pUYUNYUkRKZWlrcUZGeUtpbk1HWCtOYjJUZEppWm9oNDlL?=
 =?utf-8?B?SXJjUisveUJwTytaQ2s2b1RPWjRxWVpGaXM3RndoWGZIMmVXZDM0b0JSQTlW?=
 =?utf-8?B?b3crRU1CWU1KYVdPUk42MDNPTkFjR09BVkE1QnRIa1ZTaXczOUtVY0JWWjZQ?=
 =?utf-8?B?dWtRVlJNcVVhems2K0xSQlpQOXE0K2IwSk9nUWdiak51cU1RYnZxallVWkVh?=
 =?utf-8?B?Q0lnY2VKb0plMTl2cTV1RHUrWCtSQnR3aVBIeUR5MWVzZ3I3ZE01cnMvUFQ2?=
 =?utf-8?B?bWs0RUxtcXJFa3dIZFpodmUvRTJEek96ZGpnSzR4QmJYNWVhSEllTWd0aTl1?=
 =?utf-8?B?a3RXclQxTXpwQzY2MXVTZmxyYXYxN2VUejNpai9BcDlmYnZLSC9rT3RzR2xB?=
 =?utf-8?B?cncxNE9IMFhnQjNBVnl6YTlVVXJpRTQ3ZWkra0M5blY2R2p0QmQ0NWZuc09Q?=
 =?utf-8?B?V3V5MXhub0dIT1NGVXl1T0h6VmRSMHJaWk90NGs1cUtvc1FYd3F0VWhFTmI0?=
 =?utf-8?B?ZTlSUVN3dDIrMlJYV1RJSEFBUktvZkJ2VlRnTjg2NXczUjB4UnRieDc4em94?=
 =?utf-8?B?TTF4Qm4rNkxzeFlzU1JFWHZlMFlqeWdBRi8xVzVNd2FmM1FkKzNDZHpucThN?=
 =?utf-8?B?S25KMC9DdldraE1PUi9XM083QVVETS9yZlhvOEZ4QlUvaW96UHJLMCsvYXBP?=
 =?utf-8?B?WFVEQTlkOUVnQ0tuZERqaW5nUmRhT0N6Vm9XNkkzRHlmMXBPWGFZRDl6STF6?=
 =?utf-8?B?RGRKdXUza0Z4ZGlCbzJ6d2E3VGFwR2Y0WUNmeVVDYnBLMnNCN3lSNExUTDY3?=
 =?utf-8?B?SnlJaWVUSHVTV0NMbmdHbkNscTQvZjhINU5DdEQzSDBoVEZBNFBBYm50NzdI?=
 =?utf-8?B?MXhtYWpKTmpyQk5meFpCUkdFbEJiSU1udktnZjZEelV1ZDBjVUN2Y3BHMjhh?=
 =?utf-8?B?K3RqYlMrQVZBdTQ5VG5LRnFQVk50R0xpcGYvYW9TMTB4Vkp3VzY0RE01R3F1?=
 =?utf-8?B?TldPb3hPck5lNWErYjFrVjlRZjY1ZmJQN3NJeXUyTllpN0RFM2gvd0g1Q1Iy?=
 =?utf-8?B?bXc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	AJBETRzFY6+1FjNfl+mlwbVfC3Q4nMJhJ4vRStmQ+HnIPWvhsB4zvp3QHFNHRLPstBF3KynpxjIlLFhILvR5ND9iA7Htbe/j32lxmAoaCZxfajgzV3k6dI6rI6TqZ88LBG1WTrXym8aCJq0SpSPdF9v6IyqzNSYUMrKXm9BfQ+qr7RuOjD8yllhdY6lM5w/c0eEYiegEFLnKFgXlu1QwUVsescPUE2nCrbYKUUclei37gEximizbqIbn0aswxZL4ZMNNa3LFqIWA6yKilBwdGDad/TG6cOKAlrsGNDcafRfcvXptWLTw+ceNpQ9kulSojDx80JI06Gj/RnYZI4AzCLjxCvWazmyn/p1MDotL3fE7dDCU/k/476u6umeMxsOBIg3zUvaVVpgiMEOOWXuGnqvJehmxn+BNYJsy71t+OPl2CjjQKHlAy7aNOOEhd/+mHo359vNxcAAAeT33JPmWA1s5gQf5HxBQ+Wi+hR1dUMNXecVzSLaU3IpEkdtmRMJZDLWf42dyKNCdNFQ6AXo1cEqaQMFzoCAf0zS6fNLOYi6AXVw93ve6HL3nxCCTgEwFNrGlt+mzGftOPmxyqGoHn+ZhZVOaqSKemfU/wq8on3s=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a34b5f4-e85f-442a-7476-08dd0e601260
X-MS-Exchange-CrossTenant-AuthSource: CY8PR10MB7243.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2024 21:19:54.5856
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cI849bxXFiz6umgxDLLmK2bSVrNX+LYU1S7YN3bhc4Bv8RbxTBYtO2BPsPiseawL5E5tcZ6VkBrrsvs5tl3NY5GGCDr4u8bUZHQ1gDVDHbs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7237
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-11-26_14,2024-11-26_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 adultscore=0
 malwarescore=0 spamscore=0 mlxlogscore=999 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2411260170
X-Proofpoint-ORIG-GUID: 1gsscWLKozYMkW-B5yMlFh3SSb3V-1R0
X-Proofpoint-GUID: 1gsscWLKozYMkW-B5yMlFh3SSb3V-1R0

On 11/5/24 1:25 AM, Cindy Lu wrote:
>  static struct vhost_worker *vhost_worker_create(struct vhost_dev *dev)
>  {
>  	struct vhost_worker *worker;
> -	struct vhost_task *vtsk;
> +	struct vhost_task *vtsk = NULL;
> +	struct task_struct *task = NULL;
>  	char name[TASK_COMM_LEN];
>  	int ret;
>  	u32 id;
>  
> +	/* Allocate resources for the worker */
>  	worker = kzalloc(sizeof(*worker), GFP_KERNEL_ACCOUNT);
>  	if (!worker)
>  		return NULL;
>  
> +	worker->fn = kzalloc(sizeof(struct vhost_task_fn), GFP_KERNEL_ACCOUNT);
> +	if (!worker->fn) {
> +		kfree(worker);
> +		return NULL;
> +	}

Why dynamically allocate this?

You could probably even just kill the vhost_task_fn struct since we just
have to the 2 callouts.

> +
>  	worker->dev = dev;
>  	snprintf(name, sizeof(name), "vhost-%d", current->pid);
>  
> -	vtsk = vhost_task_create(vhost_run_work_list, vhost_worker_killed,
> -				 worker, name);
> -	if (!vtsk)
> -		goto free_worker;
> -
>  	mutex_init(&worker->mutex);
>  	init_llist_head(&worker->work_list);
>  	worker->kcov_handle = kcov_common_handle();
> -	worker->vtsk = vtsk;
>  
> -	vhost_task_start(vtsk);
> +	if (dev->inherit_owner) {
> +		/* Create and start a vhost task */

Maybe instead of this comment and the one below write something about
what inherit_owner means. We can see from the code we are creating a
vhost/kthread, but it's not really obvious why. Something like:

/*
 * If inherit_owner is true we use vhost_tasks to create
 * the worker so all settings/limits like cgroups, NPROC,
 * scheduler, etc are inherited from the owner. If false,
 * we use kthreads and only attach to the same cgroups
 * as the owner for compat with older kernels.
 */



> +		vtsk = vhost_task_create(vhost_run_work_list,
> +					 vhost_worker_killed, worker, name);
> +		if (!vtsk)
> +			goto free_worker;
> +
> +		worker->vtsk = vtsk;
> +		worker->fn->wakeup = vhost_task_wakeup_fn;
> +		worker->fn->stop = vhost_task_stop_fn;
> +
> +		vhost_task_start(vtsk);
> +	} else {
> +		/* Create and start a kernel thread */
> +		task = kthread_create(vhost_run_work_kthread_list, worker,
> +				      "vhost-%d", current->pid);
> +		if (IS_ERR(task)) {
> +			ret = PTR_ERR(task);
> +			goto free_worker;
> +		}
> +		worker->task = task;
> +		worker->fn->wakeup = vhost_kthread_wakeup_fn;
> +		worker->fn->stop = vhost_kthread_stop_fn;
> +
> +		wake_up_process(task);
> +		/* Attach to the vhost cgroup */

You don't need this comment do you? The function name tells us the same
info.

> +		ret = vhost_attach_cgroups(dev);

I don't think this works. Patch 3/9 did:

+	xa_for_each(&dev->worker_xa, i, worker) {
+		ret = vhost_worker_cgroups_kthread(worker);

but we don't add the worker to the xa until below.

You also want to just call vhost_worker_cgroups_kthread above, because
you only want to add the one task and not loop over all of them.

I would then also maybe rename vhost_worker_cgroups_kthread to something
like vhost_attach_task_to_cgroups.



> +		if (ret)
> +			goto stop_worker;
> +	}
>  
>  	ret = xa_alloc(&dev->worker_xa, &id, worker, xa_limit_32b, GFP_KERNEL);
>  	if (ret < 0)
>  		goto stop_worker;
>  	worker->id = id;
> -
>  	return worker;
> -
>  stop_worker:
> -	vhost_task_stop(vtsk);
> +	worker->fn->stop(dev->inherit_owner ? (void *)vtsk : (void *)task);

I don't think you need to cast since the function takes a void pointer.
Same comment for the other patches like 6/9 where you are calling the
callout and casting.

