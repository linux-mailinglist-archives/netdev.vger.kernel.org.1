Return-Path: <netdev+bounces-281338-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +J2UNIBp72l3BAEAu9opvQ
	(envelope-from <netdev+bounces-281338-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 15:49:52 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DE54473BB1
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 15:49:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3558A301601E
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 13:45:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 818513CF02E;
	Mon, 27 Apr 2026 13:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ASQNs6R6";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="mUw7bjgB"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E52763C942B;
	Mon, 27 Apr 2026 13:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777297557; cv=fail; b=kwl18p0352+23dlbOvHYR7Bvr/lR3O3Cl9jPYMRgS8NYVe712oOmFQqBXveLUaNelTdFv+gtgfOJE74DPMRoIMyGPWMA1zCOMJYmObN1SnRq/RSX2KB9zB85hH0Xn7fs3OozMdb2Z/ox+Gb84Jv7CM2VTRxHAZOGdASglHBvajA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777297557; c=relaxed/simple;
	bh=vxHjX/CR3y8D80fwebbNEo/R9uWgXmqDiZxEv3BNcEQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=lhjd4NlmrDh9nyDUm6WXz+qENBOds4Q82gTGE+y79bFKNjchTd1DWm/TRCE7OYpxbm73HA6Hs5aqOs4agV3VfJZt0+i1B6R9w6XSVPhtOZWqBvlEArEpWiX8pK2IL/4HQAPSrGfj7YLVEMDGXjF7G0XXWYXD4nFFLP8Xy1ROyPE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ASQNs6R6; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=mUw7bjgB; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63R1JOwb021470;
	Mon, 27 Apr 2026 13:45:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=OKeZVFmFB42omyWQ+nLuQv16vq+GW7lLmIPUvCgh2kQ=; b=
	ASQNs6R6oZjHX+oyL/UzsS0YtVTm3ywiM5f/kgNuu7WdxwudqTwE9ZOaHjd2Mn5f
	XwBtFuh45nrk8Wz6bR0+WQPj6li4d/N/4peZ/+UaSHpdblsNwNlJ0baS/YM1SHW+
	ujg+qmG2XWkkRdvLJP6Tsjj4BBkcCySulAMrkzWzKHgYVbW5H1yFaCQy0xvRlGdj
	SI0VzPp+plSDWas/sfalnq808WpXfFNhs3C968yWzHIdU7jS2P1Aj4y18Jfn4+LG
	BEomEJVyFE0+7ql7OMyW2e7gXjpiuh5ulDCRCSaFinzdR4T/vtCsqknZuT+EAW/Y
	XxONh6uf9mpABNwhwE1fEQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4drmha36tq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 27 Apr 2026 13:45:52 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 63RDaEV4024256;
	Mon, 27 Apr 2026 13:45:51 GMT
Received: from bn1pr04cu002.outbound.protection.outlook.com (mail-eastus2azon11010045.outbound.protection.outlook.com [52.101.56.45])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4drm2afr2u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 27 Apr 2026 13:45:51 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x2AEWX1+edqRHuzVMC++tfonyUtF+RKYOqG2sbwSIs87sFROyH2mDzdWPDQJKGDAA6mcFi6j4ms+BhrDLKojTJv+oWBacwK5/gsg0g16Zr8HVMOba8vAjw0IDllTs6fafOX6fHTDvtLAf9K48TP5HqXUjdO90+UgqZn8ZG045Q4O3l2He39M1B0K1U0prJqNW04ShmWvb2DfDjGDxfmkgw/OoLmKrvB+quvgc21ckyoO+GR7Xsuo5VOjBzurChBbXjPI4d4PHbnhdT9tzxSO7dLj0yIiLKpc9Z49Jxz25NAxh7ngyYgi98aylYhvsXDQRr8aEhAgzs6J3Pr46Y5CnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OKeZVFmFB42omyWQ+nLuQv16vq+GW7lLmIPUvCgh2kQ=;
 b=szj1jzSYvmYsDMttI9FBXsQ6o516c6mkDA9GN6Q3f/JdAKHo6LB8xnAysjxm7IBANoszT7U25mi6FiIAlAKD4VxE0Qz8vtnPam8dcNNBh5YtegjjslGMwtHhWPpLNK71NupQhVANyLthu6S0X1WolOMGZXDsedOpoZStz3/AMyv5gB3WzagcKcgXJKwQVK6Uy+fYPRaACy+oGH93GZiFeo97o6vqCYWmrxzuyFk8aUxBtZsrS5TAaMFsraISSshJzu4Ok4V00aK9GaueoiRa19oxryt0bFDYE/XBGeSP+Uswc7Kk0hSDmtD4qKMgcfeJI/ANQs+IhvcSUZWEvnPqhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OKeZVFmFB42omyWQ+nLuQv16vq+GW7lLmIPUvCgh2kQ=;
 b=mUw7bjgB3A3DWzk8+E9c8592uKlCXsq4rCRKm6zCGpJzznWuD/5yDwuUDm72ZR+W3DO4vM/C6EUQlM3l9TLu5OpGaFJAtu5M2+BMNkNUEDabHUe2MsHzqbsSps3laPGQ/Svz+KDS5Ky7naMwa0JKLiLGtntEI5hP/FCdfXFXmZ4=
Received: from BN0PR10MB4901.namprd10.prod.outlook.com (2603:10b6:408:126::19)
 by PH7PR10MB6310.namprd10.prod.outlook.com (2603:10b6:510:1b1::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.26; Mon, 27 Apr
 2026 13:45:48 +0000
Received: from BN0PR10MB4901.namprd10.prod.outlook.com
 ([fe80::19a8:41b4:f519:1b79]) by BN0PR10MB4901.namprd10.prod.outlook.com
 ([fe80::19a8:41b4:f519:1b79%3]) with mapi id 15.20.9846.025; Mon, 27 Apr 2026
 13:45:48 +0000
Message-ID: <45b0cbcb-fc79-43fb-9ee0-8506ee0f75c0@oracle.com>
Date: Mon, 27 Apr 2026 14:45:43 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: linux-next: build failure after merge of the bfp-next tree
To: Thierry Reding <thierry.reding@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>
Cc: Eduard Zingerman <eddyz87@gmail.com>, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, netdev@vger.kernel.org,
        linux-next@vger.kernel.org
References: <20260427132604.3754048-1-thierry.reding@kernel.org>
 <20260427132604.3754048-2-thierry.reding@kernel.org>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <20260427132604.3754048-2-thierry.reding@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0307.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f6::20) To BN0PR10MB4901.namprd10.prod.outlook.com
 (2603:10b6:408:126::19)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB4901:EE_|PH7PR10MB6310:EE_
X-MS-Office365-Filtering-Correlation-Id: c5c9b68d-32a2-44a2-cd5c-08dea46349fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	YdhXyKeVS0PIeu+o/I2g2on/1jpJLOX7BJv+PzxkQR4jyC1+hKdzbvoyKvgA0X/gOyyi8bcsEi60FcG/nQt2P31wQFJTnaYv1pFbASPQboB2FL05i2hHdazcAQfOO3ZZSLvZ5JEy+kchmduwYxhEo+HDyLSBJybQQlIq3ISdtAlW2grphOhxohctR0ZINKD62f/9GJuqHORH5/tkHf/3mDrQxW//8ZvHn3k5ehoKTQwTSDm6uCx3curXLvbwz4XaOetyF9oKLCV/p3nisAVDxxkWT+bLSOB1RsBxvOep9dwj4wveYM9SP9ClP7kjeoU2w32aJt7a2pJ8PuhLGaQ3uHwnTPjqBN5taHsAEZYzVyjM9HuMJdShp6+S27Rz2zCWIWuh2vwNjpvWjxwlsQkfJfCQ5aGRwSQjLxfmdsLMI88yvLZAhmBo4lSjBTQvgOTNuXcfvRZU7YBapU8VD9qs5ulHROrYBMMsq9RubtTwzrsZbbUmdUMvyUYfRwlWUTwOsMGFfG1XoVdJTJzjmOS0J3iVsbt12ntt3apEyhS39gCMpSxwVtvwhmvctuNHsRDuIGVztpqGQqkATu6YOUD1D6MVRVGWSTyRUp8pMukU3fxYLGDzRyYK+PH4CdUB3jc0mO6GBs1lcoLDOmA4A/xyvJgAIi6ws8b80Ew9LVThbSnNOSB18i3VNcHDMjA3SQ/cK2sEyjnlmFZvTfpbstVNeGHSnNkGgNsycqaxSRMl6pMZrwFaM1W4RnAMpzB+UQ//
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB4901.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eEFSa0psWDZ5MHFrVzlrMHNGVDV6UEowVURXZnErNG5jNXU1UWtpYXFTZGgy?=
 =?utf-8?B?UzNyMXZkV2loQm1HTzM3ZVp5RGdKQnNVQmI0VllaWjk0c25OMkdQYzZuS0lL?=
 =?utf-8?B?OVFWSDBLSDdTcWF4Q1ZGaFd2U0IwWmk5Vm9vTUdOSjlySjk2RnUrNllUZ3NR?=
 =?utf-8?B?RW8rUXZUYXpEVjZzYWVHQWJQc1Naalo1Sk5VV3JRT3NMZGdWZmY2SDUybDdW?=
 =?utf-8?B?YlVLYlJzRGRaSDRRcytndkQxM3owZzBkVmRoREJaZmZ4TEVwWGJjaDgwRVVr?=
 =?utf-8?B?K0dhenJFYmNKL1RXQlB6c0VpNHROZEtIclBmcExuaXFSbmdOb292c3pNVW02?=
 =?utf-8?B?WFplbGtrOFBSZWdGWnJpZy9NckFkUFJid2hvVENEWGxjb2J2Ry9LWDZWTkxL?=
 =?utf-8?B?bWVFRk96UnQxVWNOTW14V3ZYZHZZSDdsRzNnaFNOQm85WkFBVzRsOG05Z2RO?=
 =?utf-8?B?c3d2TmFQWitIekJZR0ZZM3cxWmI0Q05YY0oxY1VOWUcrdjNHSzB4bzRlbS9Y?=
 =?utf-8?B?bWpKTUlGVGFqNm9kdkRzbTZrRUhoUDdqNjE0YXBiRE5lejdZMHlNck8raVRa?=
 =?utf-8?B?bXBnejlZaEdNa200L0VRLzVRUUxNV2F4cTFQaElaWGtlV3pyaWR3K2t2bWVN?=
 =?utf-8?B?TWE4aDNYci9aTmxvTDd5OFVQaHR6TEtUWjRjY1U3MkllQmRJYzFpSXM0eHE5?=
 =?utf-8?B?UE5aS2hvZW9DYXduYkxPOENoUGVBOEdRcmMzZVoyTGFOdWRURytYWldaVTk3?=
 =?utf-8?B?ZTBkZWE2KzA1OVFpTFpacXQvcWlKdWQzZXllYmdQRW9kYXhEcTA0cHBUOHBW?=
 =?utf-8?B?RlREVWdtSWd4ajJZSWxFQlVTRWcwME9lY0srVTIveG53d2x4TW5iTFBkbWVW?=
 =?utf-8?B?THRPeS8vQnYzR0JXY3AxT1pXVjdhaDAwazFqOW1jTVV3ZVMxSm9oUFowNHlF?=
 =?utf-8?B?K1dVQ1pzbkFROWRLdy9PcHhySi81dll6c2c0MXYvSklnditLOGtUbVNaTUFI?=
 =?utf-8?B?Q0VqSVhKZWpSaDFISFl2UTZGVVZYaUJiZGJiOXp3RU1samFrcGV4MTNrN0VG?=
 =?utf-8?B?Q0dzaWJVeUE5YmJ1YU1BaGROb0xXREhyb3E0RVZQbnhiQmpBbEtiVnZMTk5T?=
 =?utf-8?B?N2NXdHhHYXZuNVZHNmhncUpmQVU1OTZNTytGVWt1bytTL2RlVXRYZ2tiQlY2?=
 =?utf-8?B?V08zTS9MOEtsM0xMdjVvbnE5OWdmZlF0UDEyd2RYdGgvVzdaRHRyWk5tQlIw?=
 =?utf-8?B?QVRpN3dVc0ZyTllTNWNxWXNqNGh0OUpVS0U2a1EzdFdmY3gvM05xTFU4ajNP?=
 =?utf-8?B?QndBbE5Rbjhla2F3eENwa0VGc3IxMFdrTi9Md2Vmd0lCdmhkQmUydDY0Nzlk?=
 =?utf-8?B?ak9OcWkwelBLNERBaVBxeEw4Q2NrZk5xQ0pXMXhERHZIQTlxWTlXUGkxWXJT?=
 =?utf-8?B?ZCsyb2o1YStXcFNCK243SGxnelpNM21oOGt1TG81OGp3Z00xUGxqN1hYVjhE?=
 =?utf-8?B?Mms5SDNFbzhSTEFVRzlLQTVMK2dYaWVsQmM0ckdMMEZIcFdaYXpmVnFwMEUv?=
 =?utf-8?B?K3dieVZLSk9iWE9mWnNaVTR1aHdJRThUNnBIbFhyZ3gydnJ3ak5zZDBBejhQ?=
 =?utf-8?B?blR4Qks1WUgwdUNKaWF6K1pGOEZYam5mc3o2VTlINzJmVmEwT2VDb0FnWG9W?=
 =?utf-8?B?UjhwWFc1RzI3bFZVZXN5L1NGZnBQWnk2UTBTUlZyUGJ5TXZ1dTdXaHhMRlg1?=
 =?utf-8?B?cjdYWWVGOUhLRUZpeGJGQ2xyZUpWQXpwemppZ1RwUzN1amlMSGlIK2U3eEli?=
 =?utf-8?B?a09pTmRhMDhXenlNU2VTY2RWMkRMWmpGQWgwUHRzMzhKd0toWXdFbFkrdDlG?=
 =?utf-8?B?WE5JZm5sUWNxYmc4cHI3SUxQWVkwOXlYQ3QrZXNhR21GTnlDTUFIZ3pDZnJt?=
 =?utf-8?B?aUgyUjMrWE9ydmw2dzFUYlY3Kzhkcmw1NVh2YWxkWjhYejh5dEFRbGtOYll0?=
 =?utf-8?B?elBHZURaVzYzL25yelZKbUx4YU9MalpBanJRekRWRWY0QzRkdDBnalFKS0FF?=
 =?utf-8?B?Z3c5a1NDTnBNekFDZVV2cWFoanV4RnppcXlac0lXZUg4UHFyRCtmc0puVVpx?=
 =?utf-8?B?ejJoK1JLV0huam14L2NyT3pmSmxjdEg2emxYenpDRjJwWFcvOU1PZFVpU3I0?=
 =?utf-8?B?bGJuNHlaZ1JlZk5LWFBPaFFMTzIySVplSVRRNlFJM2czSlhoQ0NIWkUwQTRW?=
 =?utf-8?B?Ti9ZMEtkNGNpRWJiMWpUTjJYdDJZOVNqazExZlpaNU81bExmb0R3eVlPTGVh?=
 =?utf-8?B?ckViOFMrTVJBeWZ4UldpZCt1TlFVWjFnVVFtVVNwZUI2dEF5S3p6QT09?=
X-Exchange-RoutingPolicyChecked:
	l6vbJ8dwe0oNPLYTBG7tGJe8wBs1mBreL6msXIQ6JBLYoJARLijQzSvMQKWonje9xqaVMeWW35EtoqfOSBv+5hL8CEHqgtivRSZ8evVT0dxHBUKEYfHxM3Am/TIahfeymYBwV/alm2WZaFYT20j3V+Hk/qXb2JFECZZsFdY6pYhSs+VSoBwnYV81uzuE4XRkx2ctzYehYR6ZOklQwgUkf1Q74eiaT+y5mhe46S1L2C+FHpNOSbVTV1j+sPs8kZD7Ph8x3morW7o+DRp3QmqdY3yFDG/XQ4Vbz8MLt8MpzSiw+yOKghg/FMY9yMtpGEnlspLh82sjMMWXJqzdXU4jIg==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	IsBK5rSetMMe3NAc9r5FciduvX0Pu5QsO8UfB19oEtZ4hjwDz8dveMq/m3k4aUQ9VQ5U7SWP9YtaWLdbSKaCR6pQygch5eujdaelx7ueG6GsAV7ckkFhLijJtEQkYnTJDiHQIrjwIZirfyrHfiMYr32lPWi7hGNhjO4YWWzhc+Jd8yqvcq+SJCW+EmmRwkizcMX/3iKvDxwgFV8ZaBSS9et/ePi/2nLVJUP1ljv38wMASNsxppo+ABu7MIzxn1JafkrlzyK7Wq2wn7G7vfpQKLz6k7AnQlFwmz4MjgHFUEIxD5FuDbstkro5wBCw0iLGlu+sQxphhdtoLUU0RGg6DfUqWBwIs74xS+XVDGRS0beDuLO7v66j8mqt/aalwVnL7OFHM2NyFELOKQ84+wMB8FAHUBmkchMY2jliL+Zdc3BqLF4FZmConDiszBCxyiDjRQKlG1BVWcoIIzwrYIOFud85MGWc0dSlu5GBnvRY+NYi13BmHzIg6dzOmD3zVdS6n09ONg8a4DQdy5Kvf+xqSNOTOTuDs5ggoV5wLp0GdhEb57HmylBvPZOzJI0D6Phgbf8CmBbj3bfwMS1CmAgcVclhCizJgR3AdH+mAjTOBhg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5c9b68d-32a2-44a2-cd5c-08dea46349fc
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB4901.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2026 13:45:48.5122
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8V7SEisWemh2xyro8kcPp9CSw2XGc3WD3X2pOazFbbHtiQg7DrxFT4UIq48r1moywfJ8WQHqcHlrkGc6w1VTWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6310
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-27_04,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 suspectscore=0 adultscore=0 mlxlogscore=999 spamscore=0 malwarescore=0
 lowpriorityscore=0 phishscore=0 mlxscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2604200000 definitions=main-2604270145
X-Proofpoint-GUID: dWMI9HUAO4OaOsyf9hY63RPrZ2fNEkte
X-Proofpoint-ORIG-GUID: dWMI9HUAO4OaOsyf9hY63RPrZ2fNEkte
X-Authority-Analysis: v=2.4 cv=CrOPtH4D c=1 sm=1 tr=0 ts=69ef6890 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=x0eKOSpe3m1H3M0S9YoZ:22 a=VwQbUJbxAAAA:8
 a=yPCof4ZbAAAA:8 a=sN0n8s7yz5lX8rxT4tMA:9 a=QEXdDO2ut3YA:10 cc=ntf
 awl=host:12310
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI3MDE0NyBTYWx0ZWRfX6GG9ZWHEcXBX
 G3lJU0CMZE3m0wHzAFOJJggfWpNt/EuVkCYGikpq2QbBUckZlAEp2jEbunDpZM/eHYZBZO7rQn1
 TG8N/mXOKWNyDS+kWIRp3RTDaYcZ9WlFDbrY8pBD0bMjDr+UtFWi5ItoFgMVKeNgleAx2ryYzN2
 OH4use3NJYwM3UG4lkONd5FsbOohGAmKndCrb/cBO4SP5p7nFaFFZ/2wwlJrfyDzBGhEAVPz2yj
 uUfedUipksOaLrgmdIPCJoxpEp4eyPzxz9+FAq1xzWeTN7rsRPEHpcsJ7Gj6QU4L60CDOAGAX2H
 L+b5fMZaw2TBqDXWXsgXarn4sovNcLjHp9Lp8dHAk7k72YdqdXtUEc7wQTYmaWoZHg7fPnYxZUx
 YgSDHNZHs7Fq38HVwleXoL28juX4+E0Yei77pKs4IuIqVaGWvM/Ai01u1593/npez6MMRhRppvJ
 HXCYliBKtCDZtQdGXu5sAnNzbINjXgz1dAbO0uDA=
X-Rspamd-Queue-Id: 3DE54473BB1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-281338-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,oracle.onmicrosoft.com:dkim];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alan.maguire@oracle.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[9]

On 27/04/2026 14:26, Thierry Reding wrote:
> Hi all,
> 
> After merging the bfp-next tree, today's linux-next build (x86_64
> allmodconfig ) failed like this:
> 
>     ERROR: modpost: "cnum64_umin" [drivers/net/ethernet/netronome/nfp/nfp.ko] undefined!
>     ERROR: modpost: "cnum64_umax" [drivers/net/ethernet/netronome/nfp/nfp.ko] undefined!
> 
> Caused by commit
> 
>     b93f7180f0bc ("bpf: use accessor functions for bpf_reg_state min/max fields")
> 
> It looks like the issue here is that these new accessor functions are not
> exported symbols and therefore can't be used by a driver that is built as
> a module.
>

See [1] for a proposed fix; thanks for reporting this!

[1] https://lore.kernel.org/bpf/20260427112205.1346733-1-alan.maguire@oracle.com/
 
> I've used the previous tree for today's linux-next.
> 
> Thanks,
> Thierry
> 


