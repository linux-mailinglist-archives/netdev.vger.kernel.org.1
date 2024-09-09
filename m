Return-Path: <netdev+bounces-126451-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F3A69712F0
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 11:06:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 038451F22D31
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 09:06:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EBF41B29BE;
	Mon,  9 Sep 2024 09:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="CKNiE4v4";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="HR+p2xhf"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7894E8F5A
	for <netdev@vger.kernel.org>; Mon,  9 Sep 2024 09:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725872779; cv=fail; b=Ku3BxWZGYeC6Sx1ts5Eb3SOXlrTwGDBtHqAYMh6QHOO/P62RkXhYgwxkvgqATXKFdpebgEFIkF6v5lQ/XFnWV+zxndV+jmi9GCXtEn9DpFGFptbphvMXivM2fBT56qTZXsMm8hiajSrAEleMlyjbvk5uw4PPf57mhNcK9V9iZdY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725872779; c=relaxed/simple;
	bh=XfAR0ZlV/Se4bA6HhlNXmFdnRqqlMt6/S2vfRK+xPyA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 Content-Type:MIME-Version; b=Yr/G1vxBNp4E45yBHsmr39epEGYmgBr31+xaSnKsrPGcV8NIqfuHqmj0+5rTJ90u9OjXzQ02UD2/3Iq9hPzXYFOn6r9hqGvO5P7cgMdHGhioOxvFVa1nKolj4FhHGYfz+AR8s8jUGZhTiYmnVKqCGGqp/a2tcqAPGhXHFp8mVFU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=CKNiE4v4; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=HR+p2xhf; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4891tnlq031238;
	Mon, 9 Sep 2024 09:05:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:in-reply-to:references:date:message-id
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=XfAR0ZlV/Se4bA6HhlNXmFdnRqqlMt6/S2vfRK+xPyA=; b=
	CKNiE4v47N1XfysPLKSbkeg4+QA5Yh+TeJ3ownldcvoQ7NunpIlEjfUNRz6AJrXz
	U1EjXHXAg9lHKpi7rKLmdO66kASjG8NkHZG1s6bO5ZUQwcbmC64B0OsT+MQp58JV
	14UTWv9Ujkb3dI1DEgr1MLVFXXpXdavMwj+iDofKCxBIF1DFZme44mXfhf0aBCd9
	5+2CBdlvSfB2X52xXBGc7y0S/Xxp3UgMyfC0BaweUOIZg+13yHVXCueVC1N54Thr
	ZWGX4uEeJ0nczeaAbuxpEjUKx7l8qebbvlh7YtEXytcyTNMooRF+iMQ5NLhDGwAU
	oIimqIM3ci+YwAG/PeWUMg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41gdrb2dae-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 09 Sep 2024 09:05:57 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4897l4E3004179;
	Mon, 9 Sep 2024 09:05:55 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2043.outbound.protection.outlook.com [104.47.70.43])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 41gd96xb2u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 09 Sep 2024 09:05:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M6pE5X19v9eNNRQ0mvW4Jueecc/F7+epFN5Ps5Sxjcxwrdk5HwgfCxlK9lvMQYRkb3jj76qLo+fYbQmfJzs9a3EdDwisVdyWCs+TJY99ARa4EdY6XV+5fp9UhiX/CvOsw/4SAE5I+Wlcq4OqWxd/9Wwa1hV0baXwrqsRYpU9t6xqAVVRsmK/zutAgh8pEeBOLud2NYXlf2E+xWJ0YBSfcdeoSbKwx9yWV3rCgD1kxGg1/m8yKm2RXvnmAL9pVnU21QdCJg9NdJ7j4lBDJzmhjuGQEcd9AO0lqs/Xb43WgRW2k6CRERyJC5rq79Bb5yRQqYsfiByqyGq/3usdKZO2Fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XfAR0ZlV/Se4bA6HhlNXmFdnRqqlMt6/S2vfRK+xPyA=;
 b=qemLY8hexzI0nZX+t7TjAQemHlb4NRrKCr696oeeqW421vAvXPi/QAxPy0ok/+ORv6LDiQ6bgfVgpGoy67Qo9aTOnIUqBQCnmwrPlmxRrbaP/zwWu7fe+rU7GbCttUMdaCGtbHkgb1ocsZjEqgjuiWGnE/KK6fhQPkge/GMfgy4uOTaCgU63dgmfOdvUBHGKHpDLQ9sgB7m0ApKIDmX8/mH+qfhqBs5XIxFMT0rgGEjcuwS6gVjpn85qT1PeF0gE6VQuUpUIFQ+PC5L0E2qyh4R1Y+ITw715LAOiyEyflL/KbJHxtOo84BNwoZV08qBZw1DRc/3z3KN/kxZ6fcY/fQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XfAR0ZlV/Se4bA6HhlNXmFdnRqqlMt6/S2vfRK+xPyA=;
 b=HR+p2xhf5ibfu3x2ZpLkplcjrA6cJwt1JyXBcfXDKln/O/MYb4XoVwQ2ymNaNNh6bHQm45FJUAbj8oyTSCfPf2r2eqMOld4YGuAmKx1NPdfodtFJSvQba3tUmGs3KI5UBsQYeMQDQ+4Zu/S+pHOa6hX1UT0gDkEPI1ptb7IsIxo=
Received: from PH8PR10MB6622.namprd10.prod.outlook.com (2603:10b6:510:222::5)
 by IA0PR10MB7642.namprd10.prod.outlook.com (2603:10b6:208:481::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.14; Mon, 9 Sep
 2024 09:05:53 +0000
Received: from PH8PR10MB6622.namprd10.prod.outlook.com
 ([fe80::510e:23a9:3022:5990]) by PH8PR10MB6622.namprd10.prod.outlook.com
 ([fe80::510e:23a9:3022:5990%6]) with mapi id 15.20.7939.010; Mon, 9 Sep 2024
 09:05:53 +0000
From: Darren Kenny <darren.kenny@oracle.com>
To: Takero Funaki <flintglass@gmail.com>,
        "Michael S. Tsirkin"
 <mst@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: netdev@vger.kernel.org, Jason Wang <jasowang@redhat.com>,
        Eugenio
 =?utf-8?Q?P=C3=A9rez?=
 <eperezma@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo
 Abeni <pabeni@redhat.com>, virtualization@lists.linux.dev,
        Si-Wei Liu
 <si-wei.liu@oracle.com>
Subject: Re: [PATCH net] virtio-net: fix overflow inside virtnet_rq_alloc
In-Reply-To: <CAPpodde7Bi4ewzPqPC0ZNAMdy=3LYgzUHsADZKFgGniUCRdrRg@mail.gmail.com>
References: <20240820071913.68004-1-xuanzhuo@linux.alibaba.com>
 <20240906044143-mutt-send-email-mst@kernel.org>
 <1725612818.815039-1-xuanzhuo@linux.alibaba.com>
 <20240906045904-mutt-send-email-mst@kernel.org>
 <1725614736.9464588-1-xuanzhuo@linux.alibaba.com>
 <20240906053922-mutt-send-email-mst@kernel.org>
 <1725615962.9178205-1-xuanzhuo@linux.alibaba.com>
 <20240906055236-mutt-send-email-mst@kernel.org>
 <CAPpodde7Bi4ewzPqPC0ZNAMdy=3LYgzUHsADZKFgGniUCRdrRg@mail.gmail.com>
Date: Mon, 09 Sep 2024 10:05:50 +0100
Message-ID: <m28qw1p575.fsf@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: DUZPR01CA0258.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b5::18) To PH8PR10MB6622.namprd10.prod.outlook.com
 (2603:10b6:510:222::5)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR10MB6622:EE_|IA0PR10MB7642:EE_
X-MS-Office365-Filtering-Correlation-Id: aaa1fda1-8aa3-43b8-7526-08dcd0ae9b95
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aEJ1U0RuSkJaZ0UxQXZUcXZEbXBrUFYvbXROeGszMUZHblhKM0p1ZWNsYy9T?=
 =?utf-8?B?OXNCNnNONFcvcE1NdU9YNUh4Wmc2V2NMY05HN255WGgxWFpmTFFYTDZBYlo1?=
 =?utf-8?B?QlVqRzJmdGF2MStqNDU0OERtMUtpOHZSTkJ6R3ZWVDZwMmkxQ3psVFh1cGxt?=
 =?utf-8?B?RmFRWnFxUnR0L1Q4MGM4c1VOTHpkY3VRZWYyUVZ4ck9Rb29XcERHMTVLQkRQ?=
 =?utf-8?B?eWw3R0F5VzJ3SFhtUEMvaFZ5S0RVTks5dTIzRkpVYnhpdVpjMkZBNUNEWm4v?=
 =?utf-8?B?YmtRS25tRHN2bEZlOEM0UGMrUWltdXdwYmcxdmtsZndqOElSa2JPdFlkZ0s1?=
 =?utf-8?B?V0dWdHRwZ1BkaHN2aUVXalNKODg1aUdoY2kzbUhPTWttSVpZU1dqdkc0dWM2?=
 =?utf-8?B?YVBzL0RVc0tteE5zNElwQ1g5eVBMNGR2UzlqdUl5MGFqS1FPYzdoZ2RDUThJ?=
 =?utf-8?B?aTJXcmJpeFQ5amZ2THBrS3pEamhRaURzTDlQd3pOM1FmK1libXVxeDRnNTAz?=
 =?utf-8?B?ZlhobDlSVVkyMUxZbVl4QklpVUdrQ2E0NGJWdnRRSDdzclhlSGJGUzg2VG5j?=
 =?utf-8?B?VEZwRytNVStwL2o5MTJqZG5MTzhzTkh1Q1hKdWRYaVd0UnY4K01kZTE1NjFE?=
 =?utf-8?B?RGJWSUVvZ0czRzBuNVJTYWl6MnJUVHlPcVhxN3lrZWZvbG00d2MrcmFObFFI?=
 =?utf-8?B?WVJqOE5vNW83Z29qdzZyN3NzUXN1Q090Ly9QeERHamU0dHNZR0daOFRRYzJo?=
 =?utf-8?B?QTE5UWI2KzRSaHdHZUc3TTlRSy9kK2VDcXlxenZKblQ0aHhnRlk1Vy9TQmwx?=
 =?utf-8?B?VmN3TlpuUmd6aVdubm5nVUNyLzdoMFMvZlBuOFpSc3NqRHVIN1ZLc1dyRTNR?=
 =?utf-8?B?UkQ4aklRYkRRbjNnRU5ZUTJ5aXJsbmdwYnEyZVRGcnIxYTh1enZJdTB1TU9I?=
 =?utf-8?B?aEZOdHVMOVlQSkF0S2hZRTJJNCs1MXJ6ZWc4MHQxbWxRSHZqRXNLcUVtbC81?=
 =?utf-8?B?eGhiMUtJUzhlR3FPb0JqYkdPK2lIc0UxSnlGc1JYcXBWU1B6WTBBVDRmMWdB?=
 =?utf-8?B?RGwzOGpBV0NGRktDdEU3RDdITHlySnRWenUyYlIrTGx4d2NJQ2NWNUp1VGlr?=
 =?utf-8?B?aHM3ZDdsNjlyWnNJS3Fra2dyQkJZd3BiM1ZKWTZHYWVLNHk2M2lMR2NxUU1j?=
 =?utf-8?B?NjY1QmxrYW9QUnNvaEdtaENNdzc1ZWdHbkQwc1NOcHN6amRDMngwYlhPTG5J?=
 =?utf-8?B?NDJyeTlkZmVSRTFZdHhENGdOaU9YeEJha3RzbEEyeWRYUTk2NTBBVkxkNDdj?=
 =?utf-8?B?cVJoZUFmYzd6czNRbHFqNFczcGl4ZFJza0RlN0FGZkxvWkhreCtSdndPMHRj?=
 =?utf-8?B?dUdzN0hnQXhEZEFkLzZUVDFlTWJUN0pHamJzSW5RZzU1L21RQTl1ZTFVQnha?=
 =?utf-8?B?SEVyc2VEMTRYNkJXNS9hSUJ6eHhFUHJycEdKMmpyVFBCdThhZW1mMmJYNjk3?=
 =?utf-8?B?dktSZXIzZnMrMS90SlpVU3BXams0TDVrTFBsaHhlVTZ5amw4TDQ0U3VJdUJN?=
 =?utf-8?B?YkxyS1pKRS9rWnVUbHMxZjdWQ2cydzJhMit5N21qMU1qTVI0WDF6dURPc3NR?=
 =?utf-8?B?VW9weWMzNjk0eUNFTjBzYVlWY3dpT09VdTM5c1FObTZ1cDZ1eE0zZldFQ1VB?=
 =?utf-8?B?WEtqQlM3MHFBZWFJdHNjSG5CU200QTVHRHp6S3g2S3FKZGVhTkhhZzhLY2RW?=
 =?utf-8?B?UldlQ1dDUm5JQ0NGMjZUUWp6cUpCenNyUWZ0V2t2SUZHdUtLVGNtQ2RUTXpi?=
 =?utf-8?Q?DsO5+O8pI5rKKT447CcDFRBe5y+cQ3gXIF40Y=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR10MB6622.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?K3Q5aDQ0bUgvYXNVdTQwQy8vK2lQMHQ2M2hzQzBEek1Lc21paGJCL24ydWtp?=
 =?utf-8?B?S21sMm12eHNRRVhqTTI1RTFpVmtNMHU1UjNqNFJzNzZ0cCtuYStuZHBjRlc3?=
 =?utf-8?B?cThKOVBJRVoxQlZQQ0V0RTgvUi8xaHI4eU5RWlFkUWE2TnVsTkpTSm1kRk9O?=
 =?utf-8?B?bVpqZWozMFdKWS9vbGxGRExXTHh1S2F6SmtGWjhzSkkrK2pNNk1uMWlaYzNV?=
 =?utf-8?B?WGorQytna0JXNUtJVFdWZjEwdU5RWFlrRGFRZDJFSUFGMXJnMXk5YVJhM2Ny?=
 =?utf-8?B?MkM3RDQwV1p2Syt2MkVQcDNEcU1CZ1UvTXJWRStjN2JlMTdFMk5IMG9MQWkz?=
 =?utf-8?B?b3FCaXJzRU5McWw3T2EwaE92YmVocVR2NTVudmExbG83ZzQ5VHZYdis5Tm9m?=
 =?utf-8?B?N0xQNjVXQVNXblVXNjNHYWdreFVubEFHd25GWTNZemJudk96LzJ3dzJ6bVpk?=
 =?utf-8?B?YTNheXp4TWhjTCtpdEk2TnoweGdIeWtHanNpbkFjY0lYVnlqeDdiRUl4OEVN?=
 =?utf-8?B?cHY3OGptZ2czZUQyYU5ncU5RTExMQ3c2ZkcwOE10MkhwUXpZbEJTajJpb1BB?=
 =?utf-8?B?Q2xvR0pON0J4Mm5LN0tRMDdBZXM0Y3ZtclE0UTRTbHBaNUY4MDlGRHBpdk1z?=
 =?utf-8?B?ZXpydmxlNngvOFBFTHR6VEh4aFpvcUhNLzZtRis0WDRaa1ZvcnlVUFZ5ODNZ?=
 =?utf-8?B?TXVNaU9Oa0VtV3B6aWEyR1VLZWtpV1Q0c0ZxUHBKWHpCMUNSL21iN05ZcFN0?=
 =?utf-8?B?bXhWUU1xUHZpR1RGLzZzRUZMdUFxT2kvTW5oYWJFTzNoUVlqQXhoNTVuWHEr?=
 =?utf-8?B?Q3dCajNWV0M5UzErTnphbEVvZFNPaFYwUVR5S1pxeVdaeUlBTXllMDlnbWxp?=
 =?utf-8?B?QlJ5R3VkVFQzczJtU3R0bVpLYWtEbTg3dytydEdjWFJCaVU3UlZBWE54THJ2?=
 =?utf-8?B?K2I1ay9obWw3OXhiU0h2VTVnK3FSZGpqKzhKbTNvampDQkhWOTZNamZGclU0?=
 =?utf-8?B?OXN0VHBSaUoyS1g2U0NqWFA3TmJYREVtdUF2emJranROZkQ4a3Ria245Slds?=
 =?utf-8?B?OU1hczZ4aFVGUXZ0RFkvQXNtWkZiTTBzUTZWVHlHRGx6THFhLzRkRE45Z05H?=
 =?utf-8?B?eG53QlZqYWEwWVB2bFNEY2ROekl4dU42amoveERkc0k3cUVhYkFhWFJucCtv?=
 =?utf-8?B?WlRXTE1LeXhHbWFVUG5ML1ZsaWE3ZldXZHA4WURiY1lXWVVqS0REeDUyV3pr?=
 =?utf-8?B?Y3N5RkIwcEk4Z0FyNWNyVE1tN2tvS3FjZXNQSWhwK3JXQ2p5QmV3YU5XaUIx?=
 =?utf-8?B?NmE3c1FhdTJodXpqNGthR29jbjhlaHJNdXowclU0bDFSbmZMS0hTcWNwdEJ0?=
 =?utf-8?B?YkRoOUtIMytrMGIxV2NKTnZ6cTFZOVRuZ1JwM2ZYdlNjYXdrYy9hNEdMQkNt?=
 =?utf-8?B?TkdFWUY2YUNRZnpoOGF1MHJTVlNhSHllcHdZcjFtVyt1Rjc4RGZiY0JFbnJu?=
 =?utf-8?B?QVVGZ1RWRUt0RzNiUUdOQm1VVkloMEszYVFwR1BUOW5qU0RMQzZ2NTZITElE?=
 =?utf-8?B?ZmttOUgvajhNLzVyZ3dla2FDbnFqcm16WG1laUdtemlOdk90STg3RmZRejQ3?=
 =?utf-8?B?b21HdUI0MnJYaTFsbkxkTnJnR3JUL0NJTTVRbitKK1ZJZTN6ZWtwdm5YRjVk?=
 =?utf-8?B?TnFCSVBKYVdvUVJYUHk1eW1oeWRNemhra2Z0VTFScmlPeC8rV282SHNORDY5?=
 =?utf-8?B?WVZpcENCUnNWdVdjdWpZU1Q0R2NBKzRCV2orSmRTOFpsdFY0WTlpdk1oak4r?=
 =?utf-8?B?RTd2VXFDSGpqd0tnVzVPdStSdU94YlhZUDNoWjcweG1Pcy8rRHJkcFJQZkdH?=
 =?utf-8?B?cW1kYS9OTnZjOGZMSE5DUElud1pWdktibS81bzVKSDNkM1JaR2NMZnFxTjFh?=
 =?utf-8?B?UVBNNVMrMTVveHpCT3kxL1lOMkNxcExROGNORlpibTJQZWhMWVFhUi82WmJr?=
 =?utf-8?B?WEprRVpWbjREVlRTa1hVSEQzUkVzMzh4Tzh1eG9iN1dsMktLMzIvdWgwdUZk?=
 =?utf-8?B?dlFCcjlwL2dkMU9Ma0J2dHloM3AzdzhBTkhDS3ZPaytrSTMwdUdmRndMRDNK?=
 =?utf-8?B?elgrRVNOR1BubmV5Q0ZIQ0lGNWFQNXNPRXIra1ROMDVWNXA0cjJITXA2dlBq?=
 =?utf-8?B?NGY2QzBqcVZhdnhuWjNlOFpxeU1YOFhrb1Z1WFJiKzdja1FMMFcxbGhRUkFl?=
 =?utf-8?B?UjZMaE1DVVd4dEM0L1VzMzV2RWZ3PT0=?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	/CiyRh8ywcOGIRPeXIfMcn0QfKHInLWZ5Go/oU5jIuXmhHU7dFy64PMuu6xJEqPkrrYFACFy4PZgH6UtLRPPrbq0Z0B1ExY6QVzExMlvgiyEOYAaZHjGyKg1nNEBItyUUKgDD1Swms5nXSs+NSWcv5PHNWs6lCNys4LG1lb+adWozuK42W3V/NLUOQ292dhRQdmDocC7VQde1pO2wAYfe5JpxT8CBwmhMZI4HPK0jyz6PKQdt4xt+XQ1ao1Cm9BKO9pEfwBeHnS1HXg0PoZ2ZEM7T/CSuMpGDdU+A9SK/P3F+nK/EOgaYHhVBmcyudMfRQWYQMMe5UWScP7hLlIy6HfSz6D2nF8M/1UBGx72BwgiCEMiJb8dYowG7W3Noy6R1UJLcqK1eofQPgdEY6scrldHAnaDiXwk7pvt4FIXaCpQcPz0fC1N2Ji+ifmDeBiafTbHA+OVhbhshO9vvKU2ThQGn6lZFIrfRou7+dTOJ/9UE/6e5WJNTbR0RBoSx5ecEamWddVbvSLLFJ7v0FqAtxjPh0+azuH8FVD6Z5bS6ziJYAADY5SXHmzpoPsOlQaFns88hMM0Br93nQREr0UuuaxQ0jaG2Xetj8pcIDPxxBo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aaa1fda1-8aa3-43b8-7526-08dcd0ae9b95
X-MS-Exchange-CrossTenant-AuthSource: PH8PR10MB6622.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2024 09:05:53.5457
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: me4Hm6baCCPqV3uJvciSHo3ik0SPevf3zuaCoiUFLXyboxAkCvMeQf0rwJbluyX9xw3DyTfqGw+jrq1jupB01w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7642
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-09_02,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0
 mlxlogscore=999 bulkscore=0 adultscore=0 phishscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2408220000 definitions=main-2409090071
X-Proofpoint-ORIG-GUID: AQCJa1FORiDU7Z3KBzceuoYOifVSzgKK
X-Proofpoint-GUID: AQCJa1FORiDU7Z3KBzceuoYOifVSzgKK

Hi,

Apologies, I've been OOTO for the best part of 2 weeks, I'll try get to
this as soon as I can, but playing catch-up right now.

Thanks,

Darren.

On Saturday, 2024-09-07 at 12:16:24 +09, Takero Funaki wrote:
> 2024=E5=B9=B49=E6=9C=886=E6=97=A5(=E9=87=91) 18:55 Michael S. Tsirkin <ms=
t@redhat.com>:
>>
>> On Fri, Sep 06, 2024 at 05:46:02PM +0800, Xuan Zhuo wrote:
>> > On Fri, 6 Sep 2024 05:44:27 -0400, "Michael S. Tsirkin" <mst@redhat.co=
m> wrote:
>> > > On Fri, Sep 06, 2024 at 05:25:36PM +0800, Xuan Zhuo wrote:
>> > > > On Fri, 6 Sep 2024 05:08:56 -0400, "Michael S. Tsirkin" <mst@redha=
t.com> wrote:
>> > > > > On Fri, Sep 06, 2024 at 04:53:38PM +0800, Xuan Zhuo wrote:
>> > > > > > On Fri, 6 Sep 2024 04:43:29 -0400, "Michael S. Tsirkin" <mst@r=
edhat.com> wrote:
>> > > > > > > On Tue, Aug 20, 2024 at 03:19:13PM +0800, Xuan Zhuo wrote:
>> > > > > > > > leads to regression on VM with the sysctl value of:
>> > > > > > > >
>> > > > > > > > - net.core.high_order_alloc_disable=3D1
>> > > > > > > >
>> > > > > > > > which could see reliable crashes or scp failure (scp a fil=
e 100M in size
>> > > > > > > > to VM):
>> > > > > > > >
>> > > > > > > > The issue is that the virtnet_rq_dma takes up 16 bytes at =
the beginning
>> > > > > > > > of a new frag. When the frag size is larger than PAGE_SIZE=
,
>> > > > > > > > everything is fine. However, if the frag is only one page =
and the
>> > > > > > > > total size of the buffer and virtnet_rq_dma is larger than=
 one page, an
>> > > > > > > > overflow may occur. In this case, if an overflow is possib=
le, I adjust
>> > > > > > > > the buffer size. If net.core.high_order_alloc_disable=3D1,=
 the maximum
>> > > > > > > > buffer size is 4096 - 16. If net.core.high_order_alloc_dis=
able=3D0, only
>> > > > > > > > the first buffer of the frag is affected.
>> > > > > > > >
>> > > > > > > > Fixes: f9dac92ba908 ("virtio_ring: enable premapped mode w=
hatever use_dma_api")
>> > > > > > > > Reported-by: "Si-Wei Liu" <si-wei.liu@oracle.com>
>> > > > > > > > Closes: http://lore.kernel.org/all/8b20cc28-45a9-4643-8e87=
-ba164a540c0a@oracle.com
>> > > > > > > > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
>> > > > > > >
>> > > > > > >
>> > > > > > > Guys where are we going with this? We have a crasher right n=
ow,
>> > > > > > > if this is not fixed ASAP I'd have to revert a ton of
>> > > > > > > work Xuan Zhuo just did.
>> > > > > >
>> > > > > > I think this patch can fix it and I tested it.
>> > > > > > But Darren said this patch did not work.
>> > > > > > I need more info about the crash that Darren encountered.
>> > > > > >
>> > > > > > Thanks.
>> > > > >
>> > > > > So what are we doing? Revert the whole pile for now?
>> > > > > Seems to be a bit of a pity, but maybe that's the best we can do
>> > > > > for this release.
>> > > >
>> > > > @Jason Could you review this?
>> > > >
>> > > > I think this problem is clear, though I do not know why it did not=
 work
>> > > > for Darren.
>> > > >
>> > > > Thanks.
>> > > >
>> > >
>> > > No regressions is a hard rule. If we can't figure out the regression
>> > > now, we should revert and you can try again for the next release.
>> >
>> > I see. I think I fixed it.
>> >
>> > Hope Darren can reply before you post the revert patches.
>> >
>> > Thanks.
>> >
>>
>> It's very rushed anyway. I posted the reverts, but as RFC for now.
>> You should post a debugging patch for Darren to help you figure
>> out what is going on.
>>
>>
>
> Hello,
>
> My issue [1], which bisected to the commit f9dac92ba908, was resolved
> after applying the patch on v6.11-rc6.
> [1] https://bugzilla.kernel.org/show_bug.cgi?id=3D219154
>
> In my case, random crashes occur when receiving large data under heavy
> memory/IO load. Although the crash details differ, the memory
> corruption during data transfers is consistent.
>
> If Darren is unable to confirm the fix, would it be possible to
> consider merging this patch to close [1] instead?
>
> Thanks.

