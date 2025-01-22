Return-Path: <netdev+bounces-160421-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 17D18A199A0
	for <lists+netdev@lfdr.de>; Wed, 22 Jan 2025 21:19:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C1036188896F
	for <lists+netdev@lfdr.de>; Wed, 22 Jan 2025 20:19:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2718321578F;
	Wed, 22 Jan 2025 20:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="hu/3LsDt";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="kPjrpvfx"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E9201EB2F;
	Wed, 22 Jan 2025 20:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737577149; cv=fail; b=SCCk7RL9Xt5IAIh49yZHw9Y2f4id9R/81KMqL9wJm+DwtHEnR5K+wq1pA+Mx8PpB7u9OQuT8AmTMIBfr3Cp7syMPRD9c4CSf1MFP5CYN44LFippk0AceBfoTXs8RfvheiS3KS7nurVvUcfksxI0MaXGcr8iRKOOG24Pxp4scdAs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737577149; c=relaxed/simple;
	bh=FkQwjU9eM0h9yph/EsX77+3eqtZu0R4xr6sOMMBicFY=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=oHlYQkYMbtFm/uDAFvJrtncowXo7RWbEXcaBOVlS3qW1dvWex+hLmKatviHdWFAVgEx8JlQftMhZX/Iqfh0Od9kiY8OGNSbpcO3v/B3w09buDf5yoAOIYcOSTc4FDAjDpiEABsOAJ5TujJJc6vk3Seqzm9db7W/umz8ZqLL0Zjc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=hu/3LsDt; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=kPjrpvfx; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50MJYem4012523;
	Wed, 22 Jan 2025 20:19:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=artNa+WY/axKNekPqJXJ5y93xucDFRRPWoABwSO3UGQ=; b=
	hu/3LsDtLCPNfv4HluY10wCMXIbWem7Jox5Cifinb/7tBn/kl3Ykkw8cqNZpIrHa
	SqRZgA4mcbP97OCJTwV+Ku9D/q1vrV9/BfjSaIVZ3IRZcr+cloYt/ZxwgQlUq4oN
	etxfj49kMt/kJfASf+vjoMWN4BS7q+F+h9kL11Z7CNRw1/YyvduR5qYgjzIrv/Dr
	T9zLok4PxXTOpPbkukwcHNjpcCy+wW80fEA4zp5WT62gMQVc8MENK0C7xrHKkOnc
	4sfGUFcfm4HAWqKAijv+GRSSaGVvd8csOIHSu0DQXCoKRz8kXp1y5UbyQKBvcP3M
	gdl51Pak9zXXj8NkQWkVDw==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44awyh19hc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 22 Jan 2025 20:19:02 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 50MInxPo019489;
	Wed, 22 Jan 2025 20:19:01 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2040.outbound.protection.outlook.com [104.47.70.40])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4491c43vf8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 22 Jan 2025 20:19:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KoUDwnlCz1s0K5zWRS9oJ3yC1L9WLaOGni0wpv6AB8UZQGiFy4IGbkxXa/Hf0gVLwD+7xM/hAJWITryvPHqEH7mxdOgDkpiUqoiLCIU46GVK2bLzwrbY89Lo/QhV1KifDSxzzpCWkkIoak9Q+e7ib7s6ccXi5c3PgziZ4otZlgB6SzZ6+nu7WYQ+JIIBnXzND2I1vuz+Z7m8mQlzfsB/apvmcO6D+qvVp1Og5VSuBmz/AKo7265nbNqpuHTvKyvBv21UQaEQrKec4EW2b5+fK4yYFwW+3Z8wtS5SQtLX6NK9WYTO9ZTAgsye59Gx3SpM34ApbsoeJSgTibii613Hmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=artNa+WY/axKNekPqJXJ5y93xucDFRRPWoABwSO3UGQ=;
 b=cEWGnlZZkW/wwhNhDizBboCeC8Uxzg73kusZj2Kn+k6zZYwD7dGELr9LfeJKN+glkAbwEygK2Fw0PBdX95jhdufzGnenyOYIXS/EbgW/2c6WNNuIGTzyJFhEVJOboClQS3w5PPinSTzIY8BNEHzk9UHk/E1gMHhzGjGREvQxBU1J2LkXkdRE10XOwM6GkQfDvtqC5uxEsXyiYoIyBLauI+S4Jp6rOQ0C2wMksWBFcp25Yy260hHtqaSsWK3wXTHOPQQyAhqP6By+9hgwNlzZFA2HCJk3eLkEI6NZlHB9MxZFgER6M4d8m12oPkyvjxXCHcWs9bkL+KIzasLrL+rDFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=artNa+WY/axKNekPqJXJ5y93xucDFRRPWoABwSO3UGQ=;
 b=kPjrpvfxocnJSRuGIDnr+Mz92CIz9mbQTaDLfslyRJTYHQfE0sbIbI3YbYnvPTfBL+6FDcLnW1yGI+jGPa5OkJ++LeB3pR9ZaSjUww3nkAhGp72ZfrSqC1llTU0bdzxRy89jf9vs1lFP4jVqxerftzR0BYMDIjdf//kN5ah86Zo=
Received: from CY8PR10MB7243.namprd10.prod.outlook.com (2603:10b6:930:7c::10)
 by IA0PR10MB7134.namprd10.prod.outlook.com (2603:10b6:208:403::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.21; Wed, 22 Jan
 2025 20:18:59 +0000
Received: from CY8PR10MB7243.namprd10.prod.outlook.com
 ([fe80::b779:d0be:9e3a:34f0]) by CY8PR10MB7243.namprd10.prod.outlook.com
 ([fe80::b779:d0be:9e3a:34f0%3]) with mapi id 15.20.8356.020; Wed, 22 Jan 2025
 20:18:59 +0000
Message-ID: <cb7df64b-7a0a-47c6-9b62-76890edd32bf@oracle.com>
Date: Wed, 22 Jan 2025 14:18:57 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 6/6] vhost_scsi: Add check for inherit_owner status
To: Cindy Lu <lulu@redhat.com>, jasowang@redhat.com, mst@redhat.com,
        sgarzare@redhat.com, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
References: <20241230124445.1850997-1-lulu@redhat.com>
 <20241230124445.1850997-7-lulu@redhat.com>
Content-Language: en-US
From: Mike Christie <michael.christie@oracle.com>
In-Reply-To: <20241230124445.1850997-7-lulu@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR07CA0007.namprd07.prod.outlook.com
 (2603:10b6:610:20::20) To CY8PR10MB7243.namprd10.prod.outlook.com
 (2603:10b6:930:7c::10)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR10MB7243:EE_|IA0PR10MB7134:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d0283bb-83b8-40a3-a004-08dd3b22010b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MFQ3UGNCZ2ZFc1FPN0xHbXdpdmw2ZmtaYTZxeVlPbFV5Y0dIaVA0VkR4dSsx?=
 =?utf-8?B?UDFWcDJCTWhrTHd6VkVTcTg0RkFHZ3VDOThpM3JRV04vaFBJNEl0RDcxalJB?=
 =?utf-8?B?OXFyNkNxL2Flbkk1NGpUQWdjL2lBQ2NqUTdUWXFkUXlwb2VaUCtURktDTk5y?=
 =?utf-8?B?WFFZL0c5ZzcvblhpSGxoQXI2WS9iWGZvV3AxdVgrNEh6RWVtWHVFZUwzZHpC?=
 =?utf-8?B?LzVlN2ZML3hyVzFUNUd2VmUxdVJ4Y2p1NkJvdloyclRnMXM0Q29ncVdJK1k5?=
 =?utf-8?B?QmlJNFlrOE1CUUpmL1VQVEdsVkpUN2tOUmF0QmVKZXdWSnZrbS9tcWs0NlBm?=
 =?utf-8?B?a0s0WnJMUGJhUC9ZNlJFUml2Y0dPR0FkbklnbkFmUGtoTEUrSENNSW53WU9a?=
 =?utf-8?B?S05EOHpJVnlvaFhRVXA5ZlF5dFQwMS9XSTBBeVJ6R0UyRzFBYml2R1UxZXNI?=
 =?utf-8?B?cUMzcVo2SlZvRE9ydVkrQTY0c1daYythbHh1UmRUVEYzWlFuR1R1U1c3ckhZ?=
 =?utf-8?B?bFZUcnJuUW80ZkM3S1BKbklHZTlMVEVGenFvbkY2dG5HOGw0OVJ0anY4UWNq?=
 =?utf-8?B?L1hEODlpWEJsUkhrQW8xVjF0cXdlZVFqRzI4aVpmZVBnTFpiZnV3SnZPcWlE?=
 =?utf-8?B?aVVZZGRUZkJXRDh2aENkNUFwVlI1RzNNU0xhOHNseExCdWZRT0lId1VZOTNF?=
 =?utf-8?B?cHNFR2FsMGF3NVpoSjdDcnAvbE1uTi93WU0zV1dUeWdrY2lxSkZTaHdTaU9m?=
 =?utf-8?B?TlZtaUhkS2hIbUR6WnBjcE43OTFqNzV4cmhOSDU2djd0S0RqOUgwUlRzdzF2?=
 =?utf-8?B?TFBuS1FtMmg5SGwxTTRlbnhCeThPcVJsUGhVbEJ1SHRXZVloYTgvU2VML0JW?=
 =?utf-8?B?VXFsK1VubkxhOTJGamlzOFM1WHlJZjJkNXJDZGQyK0VMWXoxSVo2YmFpVHhk?=
 =?utf-8?B?YW1iVmpiTDJUdEx5dzRUZTdteDVKRkIxMnFDOEtHRWRCMVlMbElmQVRQQ3Mw?=
 =?utf-8?B?TWpJaDJ6Wmg4c00xSmZ5dU1BNzBKeVZ2bWtHQVRRYnJwMmNEU0c5RTc3anlU?=
 =?utf-8?B?QnN6eTJaWmdGWGRwcG9RYUkwMnFKOUJpVkJDc0g5VmVmYU40Vi96TlVQZS9Y?=
 =?utf-8?B?Z0VCdUF4TE5qSkRySFhXY0l3Wm1YRkJDbVRHN0lMamh0d3kwaEwrcjl4K3R0?=
 =?utf-8?B?SUhIaTk1SlMrMzhES1huMDFhUGtBR0hVNk0wVVpPbVdoV3BUUWlWc0RRUzFT?=
 =?utf-8?B?VkVJdmNpaTFUUnc2VXJCWGlzZCszVExQZFAwSmRuLzJZVmxnV2NiMHpRR2dn?=
 =?utf-8?B?bUdvbUcyQzViWHZHN3RVQ1F5Y3pYbVZVRFRpaFJGcUgvcXJSbjgraEZsRXJx?=
 =?utf-8?B?dVdPclY5NWRlUDJmaTF3OTd6dEh5cTk3MVZaL0tTbDArNTBScll3UVU1VFRo?=
 =?utf-8?B?c2ZhZXJENEt3L294N0E1OUhRdFFxNXRkelFwcVgzaGtzclFmamlWaGZXMXVr?=
 =?utf-8?B?aytIallLRXpnRlE1ck9jcUIzZHR0Q1lma2RZSjlBeGpFcjgxSTBSMEpFRlVY?=
 =?utf-8?B?RTJOWWlZcE0vWXFGa3NRMFRzVGdzV1paUDhmVkNZS3hZRkY5T3pvME1CTnFL?=
 =?utf-8?B?WXFmdks2RGF1blEwUHhvOU5FaEtHbGRhRzlJWFU1R0NuQk1CTS90bFdGQnN3?=
 =?utf-8?B?RmFJNHVtQk9JeFFGUHlvQjdHRlRoMVZmMTRVL2JZNnF5NDZQRFpadi9UZHlT?=
 =?utf-8?B?R1VWMTYzWGg2N2p4TSt0aFhuSGlUWDMwWVphRDJFN2ZLMWo1MU9za2g3SGRk?=
 =?utf-8?B?bkNzVTFuOThNUGdkN3pzUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR10MB7243.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QURGQTM3YlhFK2wzQUhIUmI3UVNQM2l6RXJRZ01CbmVreW00VGRMVXAzd2tw?=
 =?utf-8?B?MEpua3J6RDFuZjcxeXA4QWRoMklSTFJnK0QyZzRJdHJaa2tXaWp3bDI3bDJS?=
 =?utf-8?B?NVJZdnJUOGpKNWtCSHZKSHVxcmJXNHJ0eVplVzl3RFN5aXdhM3AzVzRIOGtS?=
 =?utf-8?B?MjViWUkvd3hybHo3T3J5cmgxNitUdWNCZHhVRFN4VlZZOWhLbW9zVG8vZVU0?=
 =?utf-8?B?c0E0OWRYUmVxME51NzMveUpKdzlGaVZ0MlhUVnllU2Z1Z3lWSkJ1V2dyTjFY?=
 =?utf-8?B?cUxsQzJuSmVwTVhuVzdVSks4U0I3amk0ekl4MzR3MWNVN3A4NU80VE82NVV2?=
 =?utf-8?B?V2xidTlKaCtia05nVjhBTjZKT2pSZjdPTCt0VGlldHg0bVlZSFZvVnNMU2ZH?=
 =?utf-8?B?clZRaVEvUlFZNXdRVzZKa3JuZk1uM2JsYk1qUldaSEpzeFlReGpvQm1MNW1j?=
 =?utf-8?B?Zm4zclRRYm5RT084QVVtNXM1YW45ZUJPRXU0d2VkYzRkWlM1K21uOTdaQ0px?=
 =?utf-8?B?RmFQcmVhOTNlQ2t3eUlUZG5jb3krWEJ6UWNVb3pQbXJXcXI1Y1M0L0FwM0RQ?=
 =?utf-8?B?WTBzWFJNVlNOWjFQcW8yRDdIUFVuMWFHSGRwR3RSNVhrRnVKTjNtVUIwVmhW?=
 =?utf-8?B?T1plZVBFVWFiSkdTQmVyN0g5T2d4OEZqbUlmd09oY0tiNkRVcklEQ3lyajVK?=
 =?utf-8?B?OVBHWjdMMzFMM3p1eTduQ29tTW1kUjNoUFZLWmtVbk5SMklFeXg0TEFRTTdM?=
 =?utf-8?B?SWwwb3VYcyt2VE12NlhxOUZJL2NZT2xFbDV4M1p4RVJTZE9kY1Jhc001eHM2?=
 =?utf-8?B?Qk0vUXFVeWZCeCtqb2pHaURibklVYnExbk5LdzRaRzNPbjFJSWJtdkVtcGtv?=
 =?utf-8?B?TXVkV1hzRXBRMkZ6YmFDMEVFRmp0cmFzSDlIYWNzcVNVZnpoUG56TUkzcWNL?=
 =?utf-8?B?bUI5a2JNY0pMdFlxTjRRRm1XR1h3RFRBYzVkQ21aYVpCbzJQTmdOTVVxNUtm?=
 =?utf-8?B?Rk1VbWdWeTJpa21ERDFZcjc2S05seU16YzJFSXg5bXloUXViMEU5cm50RDA3?=
 =?utf-8?B?b1JkVzNCOW1iaTZkdkxCY1p3Ym4zd1diemFHVnpsS3ZrODdDb3BuZWpvVEVn?=
 =?utf-8?B?WjkxVTdnejdNSjh5UEd5dDVsekFYbCsvMjRsU25ackFQckJTQnNEeThvNVRq?=
 =?utf-8?B?bXQzMU1tNjB5K0dPZmhyUWxDcTZnSDdlUThKMDhMQ044Q2M2TzlhZFp4eTRP?=
 =?utf-8?B?dXRzeWxPQUNaalcrMTNkMnZBdGRWYStqSlZZajBDNEdMcVlaR0NDa0JJc1dL?=
 =?utf-8?B?Q0QwNXk2SlRWTjZiRHl3aWtTaHhucDVReGw1UVBMWE1YbFNFVloveW0wY2VJ?=
 =?utf-8?B?akpNcDFZT240ekFyRTFHYUFSeVQ2V3FmaUE5TzVRcTFBQmtqeXExVisyditv?=
 =?utf-8?B?MlpiZS9oTHBXcDRmaE5zWmJXRExpRThqZGovcGd1NWo3bnpKcUVKNnRuL2lG?=
 =?utf-8?B?dC9iNGR4NWlBWEtlWENRVHN4TWhwZS8vN2t1WHprSGxKZkhublVQb2MwV2Ru?=
 =?utf-8?B?VGdpQzlvVFYxbVBhWEV6T1dFN3dYMUYvNTI0UVhmd1B5R3BIU0pnRk5wQ2pl?=
 =?utf-8?B?Vkx1VjZTQnp2Mk1BZEVlbXBwVnJKWkN1SmRRSURyRlBQRTkzVE9zZzkzb3My?=
 =?utf-8?B?L0dHWGhwRTE3L042SzYwOUhveFRmK20ydWtEQ2VxSE52YmZEZ1oyZm9qOW9X?=
 =?utf-8?B?UzdMQVhCankrSll3NEppTkVPV3JhMWc1M2ErdmhMSWlBaGFxZkExRlcyaVl0?=
 =?utf-8?B?VVJINS9OWDVJeHdhaUNJM1pXSG9tazRrRjJzMUg4bXVoU3J0Q1RrUVhWZ0Ur?=
 =?utf-8?B?Y1NWMDR2Nm84Y1BWdkt5NEFhb05wU3p4V0M4UkhEdzBVZ0FtaVFtZlJuRXRU?=
 =?utf-8?B?TkR4cWEvV29ISEIrMGozU0JlNGFYZTlrb2lGb2s5MDVzVC9qdVgwNHk5Lzha?=
 =?utf-8?B?VVVMYWpURkRJTURDN3RkTGRiTU9yT0VianJoZUNaenNhb3IxU3BKUERHaThO?=
 =?utf-8?B?UTBKaWVXOEVhU0lXeTUzR3dOb2ZTajVIWUR6S0xqYmpEZTdCS2tFWDdtZy93?=
 =?utf-8?B?V1hqUTNYTnhpeXVZU3NkVVZ0dGJOVUdGMmJyR2tMVjdTcHcwTnlFMjJyNWVj?=
 =?utf-8?B?dGc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	42rBgHBXy0XbR6zJhdyu4bFIza2kNoBlxGunMk5B8pgah8OqYS8mfDspvEujT69/DxSCoRGKf5RUZ6yz22Bbae+DyzQJ0Mj+8oviJcQWXc3aRYosgPX354FDNMHHyhuJN7B2YwydhiabVmTPV5grNiOJxigm674zYtdMIMYsLtTYM5SEeldHSoyY9GqS60QOxdTxwbD1i7JQzkqqAym3SYsL/WYzmTWkI/a78vLOQbazEf1etBLQ6P0IDsO5FSKSqMq1n/kAIGNmq7Shlvo98KGfk8r/u1Hjx8tQmCaDQbcZ4T0aLfVRjcGDZxZmapKOSGCazTclqncJTy5af4YbrKqA77RxhIHXuhtVHcRLcEvq8fm8QU/1rPVq+3C868ORJ7UMgAALsEggox6fR9CV+fLnnXkBd5VmX3F0dGq4vknXHQL5IOb+X9wSzKab3+qzPMnt8mkSeQVYddqddjOWBADWCNXNAolZQcJapsOvLM3vwDAhN51+OONHbTty1PFG7RWYiv6DRJU/5B/7MhBjmPGslDR8DHI0gue9tcZav8DVmY2HxHbbVo0tjd5TbyOH4p7CB4YpWVnqbBY8LZbgsAQg/ekmV8pxrAgIav2W52U=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d0283bb-83b8-40a3-a004-08dd3b22010b
X-MS-Exchange-CrossTenant-AuthSource: CY8PR10MB7243.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2025 20:18:59.0465
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9Xpbz8GVsqdTEATy5I5WOL9HC8jk+9kOJ8tN0PFd+SZInXb0dOxGJ2o+aEl9veX1PrN32jOTZjV4F89AHllP/00v7tT1RsDX5DIaUOcNZhU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7134
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-22_09,2025-01-22_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 phishscore=0
 adultscore=0 bulkscore=0 mlxscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501220146
X-Proofpoint-ORIG-GUID: 99QJ6bxb-iRdc1BkC7yceYSkVkFFEZd2
X-Proofpoint-GUID: 99QJ6bxb-iRdc1BkC7yceYSkVkFFEZd2

On 12/30/24 6:43 AM, Cindy Lu wrote:
> The vhost_scsi VHOST_NEW_WORKER requires the inherit_owner
> setting to be true. So we need to implement a check for this.
> 
> Signed-off-by: Cindy Lu <lulu@redhat.com>
> ---
>  drivers/vhost/scsi.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/vhost/scsi.c b/drivers/vhost/scsi.c
> index 718fa4e0b31e..0d63b6b5c852 100644
> --- a/drivers/vhost/scsi.c
> +++ b/drivers/vhost/scsi.c
> @@ -2086,6 +2086,14 @@ vhost_scsi_ioctl(struct file *f,
>  			return -EFAULT;
>  		return vhost_scsi_set_features(vs, features);
>  	case VHOST_NEW_WORKER:
> +		/*
> +		 * vhost_tasks will account for worker threads under the parent's
> +		 * NPROC value but kthreads do not. To avoid userspace overflowing
> +		 * the system with worker threads inherit_owner must be true.
> +		 */
> +		if (!vs->dev.inherit_owner)> +			return -EFAULT;

Why did you keep this here? I had mentioned it belonged in the common code:

https://lore.kernel.org/virtualization/3864ae3b-d6cd-4227-b4bb-56e014c71667@oracle.com/T/#u

because the limitation applies to all drivers. I didn't see a reply about it
but saw you did fix up the comment. Not sure if I missed it or there was
a technical issue you hit.


> +		fallthrough;
>  	case VHOST_FREE_WORKER:
>  	case VHOST_ATTACH_VRING_WORKER:
>  	case VHOST_GET_VRING_WORKER:


