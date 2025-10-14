Return-Path: <netdev+bounces-229164-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E91F6BD8BA0
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 12:21:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E5C904FD217
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 10:21:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D803F2F656B;
	Tue, 14 Oct 2025 10:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="SLohDCUE";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="bMSn29kX"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 201022F60A1;
	Tue, 14 Oct 2025 10:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760437274; cv=fail; b=JjIVxh71TJHMCNi5gx3IA3mVoOat7qdCzwsPjaZzmiJ/54vDjGUwCchMF/w0FwyIwU13eS3K8NWfuchebk4NTexHmcOqOgd6LC9zE9JDYJ4YxmYVRf+9zEZ/eIcNDz8BTq7S94abhNwC/QmxYa60ADHYPH29AQm4Mq8CJ7Ux1Tc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760437274; c=relaxed/simple;
	bh=57EFiSLWm8uCzoU1JkjyVxZiuQJO4knfDl03iI5193U=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Nqs1A6h/c4t10YizuJcUOvcrhYNo/9sDcGmaxk+hKT1EoW4p/XTYfc99G3MTLvm0kbXJcfqqlir+3wqC2MZV43XHXYImK9WHo6PjrDqCHPHf9/tHd/wEP+69MXCYZkbwmzZHNPNM2pVMKD4HgbM/yt9PME5quF7OFHPwOgW42rg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=SLohDCUE; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=bMSn29kX; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59E9u2bj032328;
	Tue, 14 Oct 2025 10:21:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=glw2hE/vaG3a2g8QnuXAbi7tKcZekjtaXbxAHOo5mWA=; b=
	SLohDCUE1W+iVVc9Ie2l3hoFiIcLta0dMKcp63rT8yQCBQm/zqHkJlxmlzw02XOI
	Fxjyv8r1kUBagX3x+jwUOrJiKxZpQYnuJn6ZD/gfAKVWCiRpfzv2EV+vVeXRFzcj
	8SOKvIRDNlfZy3gzGPylHCb3ZkubmTpSNN70OhFk30PL5p3jcSRYrUt4vAyOxuSP
	KOTsWE8vOhGgIxuTthKkK14So6rFRRXMwI5RLPDzWSUY/cj8lUw4tevKZHPopoVl
	QMQz3h1cLCDE7zkmZiXNUxvyuoip47YdHwi2DwIONiHKd5GY7gqbQsYHGA+khyg6
	6TQZlvFgPyW4g0e78ErwgA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49ra1qb3yv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 14 Oct 2025 10:21:01 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59EA2cxx026232;
	Tue, 14 Oct 2025 10:21:00 GMT
Received: from sj2pr03cu001.outbound.protection.outlook.com (mail-westusazon11012051.outbound.protection.outlook.com [52.101.43.51])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 49qdp8gb5p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 14 Oct 2025 10:21:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B8/IlZSz2W73fkTJ07vQ6I6a4VWYmEjyAFC/X985p3j7tW0TsBRKv1rpIKbSxb1rd3B6QXRLF9EgQiRRJuq0bUy0IJwdWkbtdGEXt77cre2sKqc+Zm2lcqCRih0tm56SBG11dAkxKFkiOcCfqDAqFXP4QiuTY5FFR9aySrvqNfK0lXIhiiJkNW8IfcyetGauIbBi1D8nWzIeMV6GTgrTW/MIUsUhQhawOfj8aeJ3VXNcSGmyw+y3TeRQYTm0sGomYT5JmmugxxeRCai2PvpR3x+XaUey851J5bt3RY17Lu9gkR8MV6wGg0Rq2EHG52IxpigYigPauoHRXGI02kZe6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=glw2hE/vaG3a2g8QnuXAbi7tKcZekjtaXbxAHOo5mWA=;
 b=U87QcjUszqWUS87zvBQsIgSBVdcFq4jyTHzg3FdUMUEoQIlUe1LwXS0tna10XIku5pD2RFeEVQSIqn5woTmCUY3gUgOp/ngFsDrQErMspP87JQ1TKMwRorNQLvn7M96zVvbF/rkxz1lF5LdMYGBykdzzNUBMlt2GWltnhkj+6exLlLMiGreZ4Ci442I/dhQ/Tvskt39gXEQQYAcIDm48C7GxAEFZkFKGJ0YN3uHIWu+8vcfgp9PSvu+12KDyIE4cUd011TB9LwcAZc07wYd6zx//JEwyTY3S9NcHQnmfb6fhumD26XgHV6Zo5+fCbyz3HjkRJMOUyz5i9p3V0eJAxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=glw2hE/vaG3a2g8QnuXAbi7tKcZekjtaXbxAHOo5mWA=;
 b=bMSn29kXDmqIgk6Eh3zaJ9RdDjAhiASHDsRaF8i3jgAWOit4qCeUJ5L42TdAQ1goMoRtjd4mPwrfsf2+4tggLaDR+19aS3BqsiteVcs04IB6c5DLDHDI67Z/cr1da4xM6K58hZLBH9ATQzk8UoiiPYduPeRr1xsC3wopngW5jbc=
Received: from DS4PPF5E3A27BDE.namprd10.prod.outlook.com
 (2603:10b6:f:fc00::d20) by IA3PR10MB8042.namprd10.prod.outlook.com
 (2603:10b6:208:50c::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.12; Tue, 14 Oct
 2025 10:20:57 +0000
Received: from DS4PPF5E3A27BDE.namprd10.prod.outlook.com
 ([fe80::aa3d:bc4c:4114:cd4e]) by DS4PPF5E3A27BDE.namprd10.prod.outlook.com
 ([fe80::aa3d:bc4c:4114:cd4e%4]) with mapi id 15.20.9203.009; Tue, 14 Oct 2025
 10:20:57 +0000
Message-ID: <ec88f0a0-12ee-4c16-bb0a-fb572d6e020b@oracle.com>
Date: Tue, 14 Oct 2025 15:50:47 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Octeontx2-af: Fix pci_alloc_irq_vectors() return value
 check
To: Sunil Goutham <sgoutham@marvell.com>, Linu Cherian
 <lcherian@marvell.com>,
        Geetha sowjanya <gakula@marvell.com>, Jerin Jacob <jerinj@marvell.com>,
        hariprasad <hkelam@marvell.com>,
        Subbaraya Sundeep <sbhatta@marvell.com>,
        Andrew Lunn
 <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Nithya Mani <nmani@marvell.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: dan.carpenter@linaro.org, kernel-janitors@vger.kernel.org,
        error27@gmail.com
References: <20251014101442.1111734-1-harshit.m.mogalapalli@oracle.com>
Content-Language: en-US
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
In-Reply-To: <20251014101442.1111734-1-harshit.m.mogalapalli@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0167.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18a::10) To DS4PPF5E3A27BDE.namprd10.prod.outlook.com
 (2603:10b6:f:fc00::d20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF5E3A27BDE:EE_|IA3PR10MB8042:EE_
X-MS-Office365-Filtering-Correlation-Id: b97d84b5-fda1-4357-9bc3-08de0b0b5d52
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|366016|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Q2R5bVpzZjRZNTlxd2lyZEE1Yk9wb0l4dXRaUG5RZDhaRFJTWlEyMm44ZDU4?=
 =?utf-8?B?NDNsRklTWklsNnlwMnQrUnNJZ3hpam5aVm40Q2tiOWhPRG5iRGVkUFUzeGZv?=
 =?utf-8?B?blRSMC9Dc0Y2cFEvZU5nM2h0VnB1d3dDdVBFTlcyU1RHTlhDN21UODAyR2to?=
 =?utf-8?B?RWFYcWJXdkpHRmJzRDNOUFBrK1BhWk9xOTVNdnpvMzFnWXZzL1lrMER6dFVq?=
 =?utf-8?B?UWdTa1dkQXlDZ1B4WUQ2cjlhSHRGSEcwaWpIWHo0LzRTNmVWdnNzQ1dhZ2I0?=
 =?utf-8?B?Y1BJWi8xclpqVm1zcFgyZy9NMFlLNDlmK3FoeitOSUdUeHduZ2cxMjhlb2lB?=
 =?utf-8?B?dXpmSXlUVmNxZUdLYlRaZnVqdktUMEh4b1RQTTBJWWVDY3ZLOVZGVUNXQWpZ?=
 =?utf-8?B?NE1YcUdKYklZdTNmNno2d09sRTlCbFdEeHQ5LzJQVzRWWVFZOVpjbTJlMVBm?=
 =?utf-8?B?NUtvY3lNdnlUbzc3aFVMNHJKWkszQlBDcUYxaG1GYW56TXNWK0tqbzd5N3JF?=
 =?utf-8?B?dUlNcmxjMHdIOHREd081WlZ6Vk04Q1FEc1JsQTh4UFU4OHRTbWozQmVwOWNK?=
 =?utf-8?B?VUxVaDlxWEVCYUZ2WWErMncrdWZGc1pOZk5jS2J2RTFtVGpyUzBRbG1EZkpK?=
 =?utf-8?B?YnJiKzcxL04xKzJ4b3Z2TW5zOWV2ZEVpUm9rM0Jjdkdyc2NJYUdEVnQ0RUxQ?=
 =?utf-8?B?RVF0TzF3YU5mUXFROUY1ek9ScnY0ZzRpRVpVWFBMa0EwQU5QNDZFY1pSOXUx?=
 =?utf-8?B?eUI0Ni9Fak1WUkJLK1FHUW5uRENXUWFjdFhqZ0pJMCtRYi9yV2pGalExTzY0?=
 =?utf-8?B?YVdlVE90TmRTT0RyTkErdU1uR05Rb2JYbFRLTlFaTVB0RlkxdVZpd2h5VWlN?=
 =?utf-8?B?dzJtZHhxSGtaOG44MGhkbk41UFQvYXY5Q1REcy80MEFBd01OZ2owa2YvNnY3?=
 =?utf-8?B?TE1YWmVkR2dUNmtSVFJxYVZrVEhnL2oxNlRZdVBoNmljNVp4bUhzdktjc0ZQ?=
 =?utf-8?B?TUtPdngwS0FXL1FoTmxMb1hzMUwwckJ0SHhPYll3UkdmdXV4czdrVGlPcWdG?=
 =?utf-8?B?WkIzaVhwdDJKdVFpMS9xOFFkY0FGSUpjME1yNXZFeEY2TmhtQ2dhVW5UcWN5?=
 =?utf-8?B?eTFRVi9jKzlibnBXQWdXMkl0UW92eis4SjFrZDV3cXkvMzVqRDlXMmNSY09Q?=
 =?utf-8?B?RkNnZXVXcnJ0MFo5RjZDYUJzcjFVZkJqNzdwK3Blbzhmd3Y2RDh5ZzVWTUxw?=
 =?utf-8?B?NVhmUXVnam1LZ2NjTEI5U0wzc2c4NHJPeFpsUVVpQkl4SC9wcHZsRWhncDVF?=
 =?utf-8?B?bHExWWQrUUl2dTVubjYxQjQ2czZRWWFCTVR6cmxMejVnL1p1NlZjREhrWkxD?=
 =?utf-8?B?cTgxdzBYME9WZ2xLdkhkckFEOVFQMU9Pc2tIRUZwcDU3b3dGVC9FQ20vMlUy?=
 =?utf-8?B?Z29JTDA3ZUxBNjZCem8wMFFpK0VEc2VXalg2VDNkYjlhdmRyYW1oTlRuamEz?=
 =?utf-8?B?aHdXZDdjc1E1Um1GRWZxc0F0WXEwbCtadjFQRkNLbGpqdFRCNW1ORTUwdm1n?=
 =?utf-8?B?Q1FmUlFvclFZeDJMMHE2aW1XOS9wVXpaNHBnclQ2MHNzTlNRajQzeFhsQkVD?=
 =?utf-8?B?TTM2dkZjOWQ4Zy9qd0pGbkh3WERiakUwWDlKWG1aaUgzU0JvTDgrWitPdjBn?=
 =?utf-8?B?L2pkbTRnYmkxbFFRZ2UxN0RhZERmaDJtQUtWaXpqRnN3YmM2T1NjalhQRXBE?=
 =?utf-8?B?NDBKRngzazZLdUxiNHBJaFRCUTNXMy8vdmpuNzhka0hyaTFSaVRkSWVSNDU2?=
 =?utf-8?B?aHlaMSswckdReUxzNlR3WmpYQzd0L2VOR3hQTVpINkU0Z2tjaGkwOTREMTNS?=
 =?utf-8?B?bGdQRENUUUNMbHRLdGptenpuWHBoSlEvcHdjZldjQi8rWVdKcjNtVjR2dWQ4?=
 =?utf-8?B?Rmk0N3ZXSVBvbDhmNFhobDVITGJ5cGViL2F0SmFqY3Zpd0dLYURrbkN1dlZw?=
 =?utf-8?Q?+oUx0OgmRzd6abai6OW+unp6oK2RRU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF5E3A27BDE.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(376014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MU5rTWsyRTJRNnRkQ3g3cUd0WUdISDhZbjBXbzQ1bXgrUmJ2dVpRSmpQSlVQ?=
 =?utf-8?B?SDQyazBVenQzTGp6UC9mNStmc0F1VVNoTFgvSlZsZytXZVQ5MjJCOVVsSVpK?=
 =?utf-8?B?d0FpOEcxSVdZcnNOL0JSa1ZtenR1eVVwdlBNSGRSWnJRS2VSRFdZRGRZcmtm?=
 =?utf-8?B?dWVNbkVwY2NmcWY3YU14SXBIeXorQUNqbnVNUEdrcElVWUJxRmZVSjArQXpQ?=
 =?utf-8?B?UDJkY2ExbWdITllrMEZWK2xCNTJsbWc4MmpxbFlYS0RwQlFLNkR4ck11ZUVm?=
 =?utf-8?B?Mk9EOHhNc0V0R052L2dCSC9waXFXem9mTkF3VlA4Zlg3RUdWQitRZTB5VllG?=
 =?utf-8?B?YS92SDU1cXBqVVNoYWhpSE5xc3l0OTJGcXFDQlRjbDZWcit5MXNmd1NoM0Zp?=
 =?utf-8?B?aWdhRU5TdnhCKzd1T2FhN0pJazdMR3NmV2lRcnBNbGxabHRxOWlGbGNvekwv?=
 =?utf-8?B?aXVZZHBuS0Vwc3lveFcxWXVSd2lVa083V0JYNUNtSFZ0bEo5b3pNSlMyWTlk?=
 =?utf-8?B?SVRoUXl6ei92clZnZ1AvMkNDWjh4dlB0N1d6bnV4ZG1lYmR2REc3RVRtN3Js?=
 =?utf-8?B?WGNuY241TDd1N3BuSVJlK2tZME1nQVdRM3o1VTRaU0JNaXNLeEJQaWxNd3I4?=
 =?utf-8?B?cFg0M0g3ZUVVTkNJaUY1TjNGd1lmQlZWcDVvK1kyVGtLaGk4K1FUSkFXeEph?=
 =?utf-8?B?SDU0bTZGZC9mZW5DVlFFZ1k5L04xODJ6Z0FKQ0ZuU3lnRU91dFpWRGJjVUYz?=
 =?utf-8?B?VUY4WlFxRTZINENyWHNvTDBjSUdtU0JjMXRGczA4NG1FUTBXN1JLZ0MwaFhP?=
 =?utf-8?B?cFVKL0UvNmhCby9mNkpKR2NpbEFTY0g2ci9jTWprVGgrWHRvR1RMNWtiVVdB?=
 =?utf-8?B?dldDc01DQ202MEVCb0VtamZuRGkvZzRsYmNJMEVPM2t1NUpKZHNVSnppOVFR?=
 =?utf-8?B?YTF5bHM4WXZyM21tTnhmMWU5ajhURTR4YWdZOUFicG04S1lXRE1EcUVOUnpn?=
 =?utf-8?B?c1oyUFprYXpWeU9VZmErRlNCUmxPdDRSK284RWQrN0FiSzQ3M3lLWXpNSmM4?=
 =?utf-8?B?anQ4Q1ZadDdjR3NYYm5OUXU2ZHFkb0JtZ0RZT2NuS1k3aVFYaERVclNDYnps?=
 =?utf-8?B?c01uQWJ1QStjWG1vWGQ0MjdVYzBybTJSYS9PRGR1UjNTTnlTYk8xblRQOVFW?=
 =?utf-8?B?ekhocURydmt0bHRnUFhQMWdqUlBHODJEcUZoQW5rcW1CYzYzeStIdm1xeUNH?=
 =?utf-8?B?M3orNHF6akNoMmFVdUl3UDlUZmtLUDhReTYzREZsc2d3YUp5WTZVMzhQR0g0?=
 =?utf-8?B?K1RxNHJwNnRYRnVLY0dwT2pKYkwvV1FEY0ZldWtYc2RLcHpMWkdYRU04NEc5?=
 =?utf-8?B?SjZLeUdaVUd4VzhLOW5NaDh4LzhLdTZEOGxEcVpXUVhlTlZIZC90QjRHZzl1?=
 =?utf-8?B?UVFqNHo4UGpGQjBKai9scW1kRlNCRTVteVAxYldpSDdSUW9CNDRRbjZqazN0?=
 =?utf-8?B?Z3JLR3BXM3RMcHVZSjdxemJtdGR1RVRYcldodGNGZWdqT1NVck5QcSs0a3lB?=
 =?utf-8?B?UnNYclhjUHJUaGdJeDduSWM4Q01iL3NJRVhWdkpncDFjeTZIVWpXbmZicVhn?=
 =?utf-8?B?UHJPQkY5K3g0STk5TWxPelJTYmZlajVpSm9UMG5uWjhGZkRrL3NFVWdid21l?=
 =?utf-8?B?ZUhVaFY0T1ZRYjZORFpKQW01S0JoOE5LUkhCTUFaNVdpajQzczFLOE5qbXZR?=
 =?utf-8?B?QUNsU2Z4TmMwUUxPUTVyT3VSZ3JMVWwxcWdwZUNVdmNKTDhZd1lJWTU1Y3lK?=
 =?utf-8?B?bzRrTnFxWnEyTnFFWEc1MjRCUHY0QU5Xdkt3QkwvYVd2MkRRUlJnK3ByRUpB?=
 =?utf-8?B?K1F1LzliaG5CYnVkU0dDbmFORThhRDk4M05HekFhektMNEVkcEhiT2NJUmdK?=
 =?utf-8?B?N1BBMVZsMHBBNnlxZXZLTXR4Q3RWZW5xN2ZDSFQxZ2pVYzVqVXVQMFVlRUJU?=
 =?utf-8?B?TkFhNmQ5Z1lUL3JLWmwzbE5vN2t1TitCcHFmRUxGRzE3TEhMWXRjaGRKb0ow?=
 =?utf-8?B?TFVBZHorYnpjczMxVGQzTktXNzcyTWhTVHl5cmRTaXhjd0F2K2l1c3UxTlRh?=
 =?utf-8?B?YXY2b0YxSlMyMjZZajFuaWNUUFpXZjFrYkI5NkNOd2VxcHFKb2FBcEVuY2lN?=
 =?utf-8?Q?qC4hztEISpwQObHEsvnKKzQ=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	puZVFj7KhKDZ1ntluYD6wZobVRA4rTM4KWex5ydkhHjiAyHy73ewQge68N2kzXs6cqPo41aJ9oI74kDn8csB/jRXaP657gTcSQpcQVbrRdrRxZMR9gs//hHk23LW+9U8tVJ7P1qwK+QWSXnpkpRYvtH4TzbGuXtIxZMIl8wIPqCNWY5vuVcorWXzu584Zsir04oo8GEHJKrwg6h1Xle4f8EbfVUuVZeCIDVdziArsFwnCk4lITVoIUA+IEH6E040TNiLdF00xI5PdYZALA0n76HSuY0xv3wM5qdOQnuUxvssfsusi4xX3EzsdcOM4UIo/jssN+6oxWofvTJrMxNOqJG+88HnoFeyMXz6fBQkt2HB6kvp2IWe/rO8Uoh66k8WGpJGoxK2tYjA4/zvWlhPVP424YHu1L4oVdb8AUx7VNtBQWI2z6mVR5XrJaF/TZAcoXwurbUNqSES2dYLUo4hA1P00RijQGAD9kBcQrLxerkAZM1DxQA5K67ilmMSL4XHXIAsZ0Yz0YvFIm+ja/5hCWLxIpypDw9sPmOYSJWpRLIL6VBqqUz5dertG8jKwFRMQ9psLlzc0hJH7mQN8fkUmAlBamr/yzuCc/ELLph8V18=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b97d84b5-fda1-4357-9bc3-08de0b0b5d52
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF5E3A27BDE.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2025 10:20:57.4315
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CRmCPs+qV1vufFL1Movyo2WsTYTuQ7k+Ciw6onNEbr1EseC+q1Qh7QQenDNueGplJRNclGX2WPuMCNc21k3MMJvRbkvaVF8fgAlNnglEPndYfavf6q6qDtnroXnSrOo4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR10MB8042
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-14_02,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0
 phishscore=0 mlxlogscore=999 spamscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510020000 definitions=main-2510140081
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDEyMDA1MSBTYWx0ZWRfX8FGxMRAxqiny
 +vBWe4inhY+Oy5n2BKO2DiTnGbEwF9YabcVyGht+N+Eyaw8GPByayIXjUQMaK6OJJyV6VnKxm5H
 2K2h2+z1vyJK1oKv6X48479hF+0eIw8nR3hVT960EXlFjf/rxmWtRRlVFVFeg7ojdz25/1gkxlt
 p5iEpwkzsH5ZGVnD7PtBt84DHlS7HY0Hiix3F2AYza+J0hbhNhaW0OzGfMygtfih114MW6jeeng
 mQIfzimwD7Bn4CzQL3cifUyL1pDiDMNmJgQWo+gbrzLNSugtMff62TP/tMqTM2GdX/+HSoLfsWm
 Bq0fIOnjFEENCLsHqmq94GW3sVxhIUk+A5sy14BYL/H1eKKwNtSzgMjISnMBpnfpBYbevnADEzU
 FoIvSYGBkkpYcnVBFczaMvhZ3yDWpah5DGHWyDL/bncl8MICl94=
X-Proofpoint-GUID: FehJQRFGrPIqYtudbkyaGHfG5v0Q7Dah
X-Proofpoint-ORIG-GUID: FehJQRFGrPIqYtudbkyaGHfG5v0Q7Dah
X-Authority-Analysis: v=2.4 cv=GL0F0+NK c=1 sm=1 tr=0 ts=68ee240d b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=x6icFKpwvdMA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=20KFwNOVAAAA:8 a=yPCof4ZbAAAA:8 a=TdluKZFAUOgqkLHptxwA:9 a=QEXdDO2ut3YA:10
 cc=ntf awl=host:13624

Hi,

On 14/10/25 15:44, Harshit Mogalapalli wrote:
> In cgx_probe() when pci_alloc_irq_vectors() fails the error value will
> be negative and that check is sufficient.
> 
> 	err = pci_alloc_irq_vectors(pdev, nvec, nvec, PCI_IRQ_MSIX);
>          if (err < 0 || err != nvec) {
>          	...
> 	}
> 
> Remove the check which compares err with nvec.
> 
> Fixes: 1463f382f58d ("octeontx2-af: Add support for CGX link management")
> Suggested-by: Paolo Abeni <pabeni@redhat.com>
> Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
> ---
> Only compile tested.
> ---
>   drivers/net/ethernet/marvell/octeontx2/af/cgx.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cgx.c b/drivers/net/ethernet/marvell/octeontx2/af/cgx.c
> index d374a4454836..f4d5a3c05fa4 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/cgx.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/cgx.c
> @@ -1993,7 +1993,7 @@ static int cgx_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>   
>   	nvec = pci_msix_vec_count(cgx->pdev);
>   	err = pci_alloc_irq_vectors(pdev, nvec, nvec, PCI_IRQ_MSIX);
> -	if (err < 0 || err != nvec) {
> +	if (err < 0) {
>   		dev_err(dev, "Request for %d msix vectors failed, err %d\n",
>   			nvec, err);


Now that I think about it more, maybe we want to error out when err != 
nvec as well ? In that case maybe the right thing to do is leave the 
check as is and set err = -EXYZ before goto ?

Thanks,
Harshit>   		goto err_release_regions;


