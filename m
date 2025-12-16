Return-Path: <netdev+bounces-244983-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 659D3CC495E
	for <lists+netdev@lfdr.de>; Tue, 16 Dec 2025 18:11:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6F91C3124209
	for <lists+netdev@lfdr.de>; Tue, 16 Dec 2025 17:03:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44A2232572F;
	Tue, 16 Dec 2025 17:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="sN6l/h9Y";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="F8JNB6U0"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3833F319850;
	Tue, 16 Dec 2025 17:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765904595; cv=fail; b=P7fWh4h8poM4WEKMQOIE2b21UGYRz8d5cqnUDbCRIEt14fmHezC3F/CuDs8xYfc4it9cqxV6ehcb2kViJ1MBpyV12z0E8xdIrhvfXB2u2YGny4ogwy+pSREDVBTu8fYFhpPiK7cQXmIiJGSBMNF3hg2OXEz7786q2Z0YYCGwfrs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765904595; c=relaxed/simple;
	bh=clvmzOQi/+/zUkttZt70yGKh7X3DUm6trILee1g71WE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=DhTOB245gX44d8SjB0nfToJPS5zJ7iasqX5UyWFcBu1PjBJm/QU9SNBL2sFoQfRPSKE/245w73U1xziY1G2M4IwT4AdzzY7Z/qPobmu+He16NwUQI0c7Dsnt+tSeLqiSlzHTiS5pSjSsdP+qkA7V+Br6CEawChHshj6i62yCatQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=sN6l/h9Y; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=F8JNB6U0; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BGDuNm7506188;
	Tue, 16 Dec 2025 17:03:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=PiRW9b25hnUY5aDBVv7g5MSIBayMasS6+xQ61lOj8Lg=; b=
	sN6l/h9YFuVguIrrIwccNEYYBP/zE9dr4fW7aMEoVV3F636WKdOsXDlKC3N3xY1D
	Q2wkFaAvJLv6DGNA3vD3prnddeGjXSKzvLmlAmW7WAwLjv1BYT+vUQpOhG3gQg+C
	WUXIAwf6r3ADRB2YokaeFrZyEY7dla9zc0r6gKRiiET6LtsEzFQI8S5MKvdI8JAi
	B2mp24TLWF28FD39+9AHooO/fXyrU1VjAmeJAJSvtuRfJNhNhzAqX1kKtz3Px8tA
	Pc+JSwE5AE79HUUt6WLVzj7qlNdhvj1CJ5+CjT/uEffcYmOsRqOnTHaVD/40IePf
	gklSqsPIoZXOtIgeo3iC1w==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4b0y28ccu6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 16 Dec 2025 17:03:01 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5BGGR5VV016301;
	Tue, 16 Dec 2025 17:03:00 GMT
Received: from cy7pr03cu001.outbound.protection.outlook.com (mail-westcentralusazon11010055.outbound.protection.outlook.com [40.93.198.55])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4b0xkm0301-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 16 Dec 2025 17:03:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VTyzD0jclE+Ac07BggXkdo8+xIpWovrjmaZO1ZzKACpWXxKkT3hDoL/OcWNs6WuH07O4rSIWePpMdzD7QfWEKL5wULVqYSiY+Avu2DK8ER20aF07tVOfSwGXUWs6yQXXntuvrgQ0BOUmCcg8HU+Gl/EnLXc7YTOLphULqvdQGb+TaMBxAlXLdslKsjg3dr6HravlBawTmfchhyHHc/J9mPh7J3breEmpBslGRZDRmhWr+zQ3/VSHrQMVe4d1hbyrhXH+nuGA5vfKguVg3VK3uR4l7MkB2eB5FiiauawSQBUUhTmOjxKP+kCiFQ+wYSkx+ogW5+nEi7k4xPPJ2ErLTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PiRW9b25hnUY5aDBVv7g5MSIBayMasS6+xQ61lOj8Lg=;
 b=b82NZSDhjUJjNRf+hQE2+itsTvrObOWysufHU/GSersHH9p59OB/PGQIdiX+N3segxIbU/jGCSexvCaKn0jokNG5uqimFJLZP/AMMsOKaduvM5W8omDzRWQmPK9qxD2aGs/bcJIB9ft1I3J/vTKjQTFHCJvdURBdIw7wst4OTEVM5BkIl/iTguuVITdiL4093Kyabv5+l4RHkpWTVZ3fbmrxC1SQjNwEmlTfPvSEQsKYV2DcPw+GNSgH3vv1/RnH6aGIZhoRX07lczfh4HVxVe5QHazdJ5fS0giOs4GpXF8/OXQF+cPzqDyixrkaSm2XWGjqGXq4UTFZ3410azK87Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PiRW9b25hnUY5aDBVv7g5MSIBayMasS6+xQ61lOj8Lg=;
 b=F8JNB6U0QJ0JNn/Vc2DRh2itanSy261WC9ls1nijkzSD11odS0NH1p6vEmGqNMInUA6C9T+pMdZWllOo0bSf2tbGaG7PUxbg3FTYOYleDZwEEo9kJGxGHjv/vI77LZ3lLttgbNxcuAT99Oi6mLdBfXw0cstya9eKWY5xYDn87TE=
Received: from DS7PR10MB5328.namprd10.prod.outlook.com (2603:10b6:5:3a6::12)
 by PH7PR10MB7838.namprd10.prod.outlook.com (2603:10b6:510:30a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Tue, 16 Dec
 2025 17:02:57 +0000
Received: from DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c]) by DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c%6]) with mapi id 15.20.9412.011; Tue, 16 Dec 2025
 17:02:57 +0000
Message-ID: <19c0f063-94ab-480a-8322-b182164512f4@oracle.com>
Date: Tue, 16 Dec 2025 22:32:51 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [External] : [PATCH 1/2] net: phy: adin: enable configuration of
 the LP Termination Register
To: Osose Itua <osose.itua@savoirfairelinux.com>,
        netdev <netdev@vger.kernel.org>
Cc: devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Michael Hennerich <michael.hennerich@analog.com>,
        =?UTF-8?Q?J=C3=A9r=C3=B4me_Oufella?= <jerome.oufella@savoirfairelinux.com>
References: <1695319092.1512780.1765900119201.JavaMail.zimbra@savoirfairelinux.com>
Content-Language: en-US
From: ALOK TIWARI <alok.a.tiwari@oracle.com>
In-Reply-To: <1695319092.1512780.1765900119201.JavaMail.zimbra@savoirfairelinux.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0018.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:62::30) To DS7PR10MB5328.namprd10.prod.outlook.com
 (2603:10b6:5:3a6::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5328:EE_|PH7PR10MB7838:EE_
X-MS-Office365-Filtering-Correlation-Id: 306dbdd0-7fd4-4f10-f910-08de3cc4f5b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?L2k5VjVzY1B3L1M2b25hbUswVHpueXE3RzMvY3R1cU5LWWRhWStlNGtoQVpC?=
 =?utf-8?B?azJ1dzhEbzh5b1JYbTlESkorUmQ3V3dEUHNybkhPNHd2b2JmMzR6dWNVWDlQ?=
 =?utf-8?B?RTJ6dDBhQVlpYlNJWElQOGUvelpjUHN2Vk5WdlFPUVdIQ3F0YWFPNktFQVpw?=
 =?utf-8?B?Vm5sSmZpRGhNcGc0eVJUd05CeGRQN29FWWNuWDhWaGsrc2htelp4RXlEVmxP?=
 =?utf-8?B?QS9XTWhPOWNsUlhtUnFTc0EzMk5WWHdHRTBLUE8rREsxL0dXWTJCRnZRelZl?=
 =?utf-8?B?eHNGd0p2aTFqRUdHcnVHQlNqUnYwZmQzYnBMTTdVTFNEbFR4Z2tBc21QOER2?=
 =?utf-8?B?L09mdXdwekw4Q0o5WXExK1p3bmphREhEYWpiVzFtMStiUWMyaFVjaEhOSEZ2?=
 =?utf-8?B?eUhtcnhRTytuZWdvOXg0TEZEUjRrVEMzcnFqQ3JUSkVDSTdkY1B5eW5XamJL?=
 =?utf-8?B?djJBL20rakZVRW9FQVdld1g3TFdhSlRiRlgyQUVWeElYaWt0eGp0Q0kxa3Ry?=
 =?utf-8?B?VFl2TC9TWjlpN3NBWkFMYlBEN3YyUytkSENEMXZtUFZuWDdGdEo5ZHlwZEV4?=
 =?utf-8?B?ME00eHZsdGJ1MnhmRDhscDVxRk5EcWNWU2JVQ0wyakkxY0YvSC83OTdydnJR?=
 =?utf-8?B?QU1lRDd3VGJKeHRmVGdoY2R0d3pwWUFWSzB5bVZhNmJDVCtJam9Ka0FvK3Fu?=
 =?utf-8?B?SGh1eGlRT21DTXh6L25MM1FsS1VNOGxObWMremdBYkNMY2lSZGJQNk5OM29M?=
 =?utf-8?B?dTU0dG1iWGFUcUFMY0dBS1BiY3gxSkxlN0xmUTFySEhqY20xcVJ4aC9rYlhZ?=
 =?utf-8?B?Q3ZEVlM1OHZ2WVpaM0lyQVRoS0ZmOTNOcGxkYk5zVnFPQnpmWk9UbEYxYUdW?=
 =?utf-8?B?NTBEY1NNcUlNUEpqRFpFbW1aR3l1akQ0N0NOVHBBR1U2blhxNWxIUVd4c1hX?=
 =?utf-8?B?VDFqRWFYc2hTS2RTQm8rWE9PMEFIWDVFUzRrZmdZWFk0QnBUTnJZOHBmdFky?=
 =?utf-8?B?Qng0amN4dXhwZUdVaEVqV3k4MU1HSG1jRGlBUDA4MEwxc2lrcXZyZlQ5cnRD?=
 =?utf-8?B?WHFFY00vTE0vWTZDMkJaOVpKZHdHVTAyY0NoR0xuemcwVENSRStSOWtNcWZz?=
 =?utf-8?B?VGZGYUEvRnYxS1g1OGo2cmc3MEVxZjBCaG5aTkpMeTJEb3dmRVdpY1lzdWZt?=
 =?utf-8?B?NG5ib1ZOOVlUTmN5VytaMVlGdThPbmZNTHdhRTRLVElIdmVHYlZHNXlXQ1p3?=
 =?utf-8?B?cHI3eXdxbzA3emV3alAzM3JYWjBNa2IvUGtYNFlOeTJzWTc2cFJBYm0xaUQw?=
 =?utf-8?B?YU1DdzF6UklHSGRvLzlWRFBFTTVNV1QzZDB6eGlwSm1rZnlLWVZ2c24xa1dk?=
 =?utf-8?B?YjRXN1owT3cwOHUyU2YyYy9TSW5UN2VrWWgyNlFGdWJOcHFrL3NCZ1B0Z0I4?=
 =?utf-8?B?RGx2OVgwa0lENFl6N3poRGdDSExIS2xLdHVScXZHSXFJWXluc3ZkYlFlWWpN?=
 =?utf-8?B?Uzhqa3NWNFBlTlZicUZmOTdRTnBIekRzVEhIWVVNY0dyZCtJSlRId2U3czhw?=
 =?utf-8?B?YnpWLytyYzhBQ1VnMk0yRm1mRXhrMU1EWFhWVlcwT1ZjSmU2NGp4aFAyb0J4?=
 =?utf-8?B?MmlYeHZINktKVS9EOFcvc0RjQzZwWkZxOEhDWVdVSWlMODVMZUtFNitLMmpI?=
 =?utf-8?B?YjlIZEFmYVlOSHFjcmxITHVvWkxDMDNObmRlVXcxcWVLK2wwN2VSaVRJbWd4?=
 =?utf-8?B?ZWVsUTIrUEtmRHZCZ1QyZ1dJUXVhMExEd3lDbU1HMHFDK2JjWCtiaVBqMUR4?=
 =?utf-8?B?bVd5UTdZenQvdWNRZkFNNHYrM3lCNG9wY1E3TWJmbjA1QU5aZjMwRzhjSFMx?=
 =?utf-8?B?SnI0ZDF6SEluT2h5NUUyazJZUnNYTCt2eVNhNTVFaXlERTJPQ1ZWYnpFWDFD?=
 =?utf-8?Q?T7puhUxHS+EyKXrvttJkoHlLeavd5d8u?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5328.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cllybkN5UWJidmhGMDZEeGpxeGpyRkxja2RzcC91RlZQK0lOMVhmWTVGb0k0?=
 =?utf-8?B?c2hPR1JORUN2aVMveGdUMklzb2N3Y1ZTck51Q1R6OU5lVG9Ia016UDNLbzhz?=
 =?utf-8?B?QXFjNDRQUjZTb1FpRXRHOG9iSjVWRTljSzVFbXp3RXlSWUpmUUFoTmxtMk42?=
 =?utf-8?B?V1JNaTR1cDhaU1dQak52R05IU0ZuakJyaUJYVHdrSFkvajc1OGhrL2FiUElj?=
 =?utf-8?B?dncvRFI0THhsYXJNelU4WDdrcXMwNWJSZTI1OXl6QVlhd0k1NU5naWxTdFFt?=
 =?utf-8?B?bGpEVHFtN1paTk9WRk9NZldpOExsSXlBUjAzQW1rTFZrZmxDUElTVFkxcnkz?=
 =?utf-8?B?amNCcGVuSjhZT3ZJbW9sRTEzanBuaDdqTXVyVDNvMmFrMHc0U2s5UE9rQVA4?=
 =?utf-8?B?ZTNWUWV0YUtqazJxM0c4SW9MNS9lSEV0OXB5Rzh5a0NhM2ZUd3hIRUNGbzNY?=
 =?utf-8?B?ZnZndWltZ0xxSmFQL09QeXVYbHpIaEd1VUpUcEc3MW9uV1FXeWJLejJQa1FG?=
 =?utf-8?B?bVNkaHR3K0lJNkl5RkpCaE52ZVBQZ0xlZlZTcy9yR0ZUbXJ0YTRjZkRoZjFF?=
 =?utf-8?B?bDdGSC9iMVNXRDhvbjRPSnBxQmFwTzVSaG11QmhxdEtONG5QQmhjTnhtNGFU?=
 =?utf-8?B?a2ZXaGswMnVtV1FTYnoxM0YzTHVqbSs3dVhrM1o1OWdQYWQ5WlMyalV4d2JL?=
 =?utf-8?B?OXRrWnpueWFsVUgxVU5lTldnNnFaZXJxa3I4NEV2dGdqcGg2RGN1c3ZBNXFY?=
 =?utf-8?B?aVpZem4yNlZpQVhuOWxYY0VRc01KbG9Vd3RZRFVqV0QvdytraUVwcUhGMmFR?=
 =?utf-8?B?bDlpRWR4aTJkalJUczRnaVdTcllWdVFndG5PdVBqUmhhdkp3VkhabmFVVU1n?=
 =?utf-8?B?K3Z1SFA3RndxQ2FjRHJhd3BFSWJaQkVYK2tUUnlqMWFoLy9pWFhSRXoxQld1?=
 =?utf-8?B?bnkzV2ZGVmE3UWNZZGdwaDJpZStYSXUxQitWejRRYUV1MUR4cWFRcXdpTVc1?=
 =?utf-8?B?WThpRTk1NWUrL0Ntd0ZFbStHRm9EM3Z4dmRCZjkvbnUwZWFNOERjOWhUdlhv?=
 =?utf-8?B?VHAzSEx6WVVqQTB3WkhrcWQ0UHJVQUtyYjB0eExrTis2eGs3dnJOaUxLWGE3?=
 =?utf-8?B?c2d5MFRQZmtQdjJ2RlRsaGE3R001azA3QjV5dFdWSDl6cGlUY0dWZlppekZB?=
 =?utf-8?B?T0ZZVWs4K3lrcUsxWTVIUElyRGs5bW9VOFRSK3dMRHNLK3NOYWlsT293OTZk?=
 =?utf-8?B?TVdEK241TmZTN0IwUnQxWnlKempIOGh6V212SXFVZ2VaTENIcktLeHBmU0ZC?=
 =?utf-8?B?UFBtOG9CVHpWc0NwTXZreUxhczI2cmF5VTN0eVRDcHR0RUZxWFB2elpaUXNz?=
 =?utf-8?B?S0xIaGtCZGNEdGVIMFNiQUxzTnJkVlVDOEdCTjNmajJBUmh5eU9OdzJuTDIr?=
 =?utf-8?B?SDdrTVNmSm12RmRMY2NuZW9jMFYvaWw3N25lZXlLQUFySFZ5cVRUS2s1SzBh?=
 =?utf-8?B?bFZIYXpTRWVlc2VTR09YV2x3bkVINE9BWmVGSlVZdUdGNFNwSzl2VDJueVNE?=
 =?utf-8?B?OGVZUUphMkhtMzVQa0I3RkxDNUFpMmI0dUh3OEdIKzNDem5rWnZ1WVphbEox?=
 =?utf-8?B?ZnRlL2tNSGl6UjFNQTJ2eGFCVHRRcC9wVS8rcnZReFJnUndaT2ljTXhhNUgr?=
 =?utf-8?B?N0JsS25sQTJLTUhBaGFmTVhGUldZV09uc0hOb2NoeitzbDRPVG9MVUJwUm9O?=
 =?utf-8?B?U0xRZ0xIcHdia1RzSkQ4dE14MWlwU0M5Zzk1R2tUWDJjSTFsaXFXSy8rdzlj?=
 =?utf-8?B?N2Rac2JSSFZCeTBITDBaWThHbVZlT0krVGVFUStlV2dhMXQ0SWEyNEpDYXQ5?=
 =?utf-8?B?TmpJTER1VXVuWUhUc2NXaVcyMzNyQmNTeW1nWTJKUVpQNFVWTk1hdG1GTFdV?=
 =?utf-8?B?ODIyN2IrZDNvaFdMVEJEK1VnNDFEVm9WVDZuK0k4ckdLZkRFMHI1NTgySkZR?=
 =?utf-8?B?YkdrMHoreGRyMXQ0cUJOcjM2cGNubkgxekRnY1Y5ejBBVVArMW5SNCtBMWpB?=
 =?utf-8?B?Zm1hdVVPcmZFWC9Eb0dLTWxXVnlvdFRMUXBlT21TSEwrcE5ZcldJOGE0c0M4?=
 =?utf-8?B?ck9LZjVWNFcrdmlVOTU2K0oxTUc4TDQ5NUVhbUIxcDloalVRWlE1QTJFb1g3?=
 =?utf-8?B?V3c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	6Uh5MS54eU/TkKIpnz214NuA/KgpXV2hfF3u8Z9h6VJCyLTfazqpg0rjZiMV3dqwVt5EaV2l+CnJIE+B2h5XS7zai8U8vliV4HdutYRqXKkG+Ea9UtS5BBXRynIffyz02C5N8o9N9LpadTwsV2WWRmphdePbxk+/pCw7Ts+Qb9FjuTtCoxC+7H4xIt7vJ91CEynJbrlHRit60e7in3clHPQ1ZcRO2bHIevSyGDbvkIH7ZWQkuSxgMVGarbrilP9obM2ishSiaiDPgrjOiUd4vDVr21F3eBxGqSCEkkPY/X/Q8qonPW1yYNamk6048V0eF0LrqikDZa/3xoHbYpebhcCAcZMj36b2hcas1LpxVFYGK+6pAC3ZocDuI/eDX4m/++/GHIOXHeBiZAeSFISRM2urRJ6zelG8E/YXvJvye3oX2hfyKcjuSZI9ynOt2G2CR7aVWqHFRrstLCxxahIInfRfEoy0ST3334SAFY50+dMk/gre1h/L3wZTPYys0GCYzPZ+QkSOzMBZNZzDnPoEeDnQFkHxOAnuFdSeS0yb+KuuWLIyY+wtXFQoIljmNDVTddMazWZ65Fxk5eZ+fq6w40KrTd3MhvPgWy9LzrboJE4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 306dbdd0-7fd4-4f10-f910-08de3cc4f5b6
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5328.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2025 17:02:56.9406
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NF/OC0bLY4vbALn4M6hh2TK4vSE4wMR7ojADYMdQ2s5q/tCo6FVCOAm1ehSbpFmFK4w/111Mfp4c0NXD/w+2Vp+XvnoAEvlKi5NS4hpVYzY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB7838
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-16_02,2025-12-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 mlxscore=0
 suspectscore=0 phishscore=0 malwarescore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2512160146
X-Proofpoint-GUID: Rc36itMOxwSC7inqjfPDxSGbLaMexXOK
X-Proofpoint-ORIG-GUID: Rc36itMOxwSC7inqjfPDxSGbLaMexXOK
X-Authority-Analysis: v=2.4 cv=fOQ0HJae c=1 sm=1 tr=0 ts=694190c5 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=wP3pNCr1ah4A:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=aRxQL1JOAAAA:8 a=1AmAjypbCYY3lO0qBD8A:9 a=QEXdDO2ut3YA:10
 a=lBRdisTmIr2YKkuu8atg:22 cc=ntf awl=host:12110
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE2MDE0NiBTYWx0ZWRfXxYrrXM9BmwIj
 hEfhgcBjBS37H/WDjCNngIL80wI/RD/XDRP6brGVtk2m8VwMKev6SJPLw/Eam29v1Nym7DXo28B
 qclMrP5umI+iu7kqvkdSzvE+UxiBWgPSv8E5zBY5NykikwMWkGITNuVqwEAdkRvR52xwTTjJvlb
 8gNIpdB4TVPgthO6KTkqSWY1AKKPo6SqJIch0++6VV0d4TNBc32YKamQm0VoCNfmNivguYv+jPk
 300d4F4AVy1iE9RamYjfSBWlHBpad3ARo7WAawWT5T0M+94seYXgLHB0lrMqngVi10uKBApL25/
 kvtUIQ7woHRiRmp2tti/LBzngl00MQbPB9WnV9iyNLwfma3g8+Fv9sbev5S3U12BSq22oNE1i6R
 x8VAERIaXLmUzEM+u0pb9aCogAvFEZK4hR6C73R6nlE6p0NMd2c=



On 12/16/2025 9:18 PM, Osose Itua wrote:
>  From 9c68d9082a9c0550891f24c5902c1f0de15de949 Mon Sep 17 00:00:00 2001
> From: Osose Itua <osose.itua@savoirfairelinux.com>
> Date: Fri, 14 Nov 2025 17:00:14 -0500
> Subject: [PATCH 1/2] net: phy: adin: enable configuration of the LP
>   Termination Register

Double space between LP Termination.

> 
> The ADIN1200/ADIN1300 provide a control bit that selects between normal
> receive termination and the lowest common mode impedance for 100BASE-TX
> operation. This behavior is controlled through the Low Power Termination
> register (B_100_ZPTM_EN_DIMRX).
> 
> Bit 0 of this register enables normal termination when set (this is the
> default), and selects the lowest common mode impedance when cleared.
> 
> Signed-off-by: Osose Itua <osose.itua@savoirfairelinux.com>
> ---
>   drivers/net/phy/adin.c | 32 ++++++++++++++++++++++++++++++++
>   1 file changed, 32 insertions(+)
> 
> diff --git a/drivers/net/phy/adin.c b/drivers/net/phy/adin.c
> index 7fa713ca8d45..2969480a7be3 100644
> --- a/drivers/net/phy/adin.c
> +++ b/drivers/net/phy/adin.c
> @@ -89,6 +89,9 @@
>   #define ADIN1300_CLOCK_STOP_REG			0x9400
>   #define ADIN1300_LPI_WAKE_ERR_CNT_REG		0xa000
>   
> +#define ADIN1300_B_100_ZPTM_DIMRX		0xB685
> +#define ADIN1300_B_100_ZPTM_EN_DIMRX		BIT(0)
> +
>   #define ADIN1300_CDIAG_RUN			0xba1b
>   #define   ADIN1300_CDIAG_RUN_EN			BIT(0)
>   
> @@ -522,6 +525,31 @@ static int adin_config_clk_out(struct phy_device *phydev)
>   			      ADIN1300_GE_CLK_CFG_MASK, sel);
>   }
>   
> +static int adin_config_zptm100(struct phy_device *phydev)
> +{
> +	struct device *dev = &phydev->mdio.dev;
> +	u8 reg;
> +	int rc;
> +
> +	if (!(device_property_read_bool(dev, "adi,low-cmode-impedance")))
> +		return 0;
> +
> +	/* set to 0 to configure for lowest common-mode impedance */
> +	rc = phy_write_mmd(phydev, MDIO_MMD_VEND1, ADIN1300_B_100_ZPTM_DIMRX, 0x0);
> +	if (rc < 0)
> +		return rc;
> +
> +	reg = phy_read_mmd(phydev, MDIO_MMD_VEND1, ADIN1300_B_100_ZPTM_DIMRX);

phy_read_mmd return int, but u8 reg
reg < 0 will never be true

> +	if (reg < 0)
> +		return reg;
> +
> +	if (reg != 0x0)
> +		phydev_err(phydev,
> +			   "Lowest common-mode impedance configuration failed\n");
> +
> +	return 0;
> +}
> +
>   static int adin_config_init(struct phy_device *phydev)
>   {
>   	int rc;
> @@ -548,6 +576,10 @@ static int adin_config_init(struct phy_device *phydev)
>   	if (rc < 0)
>   		return rc;
>   
> +	rc = adin_config_zptm100(phydev);
> +	if (rc < 0)
> +		return rc;
> +
>   	phydev_dbg(phydev, "PHY is using mode '%s'\n",
>   		   phy_modes(phydev->interface));
>   
> 


