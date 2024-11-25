Return-Path: <netdev+bounces-147240-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5B9F9D8907
	for <lists+netdev@lfdr.de>; Mon, 25 Nov 2024 16:19:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4745162257
	for <lists+netdev@lfdr.de>; Mon, 25 Nov 2024 15:19:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BAD21B3930;
	Mon, 25 Nov 2024 15:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ZcxC4j7L";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="qT36kdjZ"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 428731B4136;
	Mon, 25 Nov 2024 15:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732547980; cv=fail; b=lna2gGxHDuls/chCHTZ0ResyIacZjz5p9U05oTRqftoRZUx1MmrF4OK4Hd4fy++Gasp54YxTY3HTDRV/q2wxYdvnxPi2nRRFJyffdvUr0n7935vojnoel8LYRMnc2V3ckLbcFjYdLX2ok40fdFaaSGyDC03fuOwl0Gm3XM9EYBo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732547980; c=relaxed/simple;
	bh=3sGkc2CeLLCBVm+z3ejHGDouWMmN31Azw8v7QB0srv4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=LVAzUU0rt6aL9HLyArjf6pXmBOET90StzzK+mGT1S0FRdGDlsbqea5ffWAMw8vRXvoos4JdPVeF3zKCXi3wcq90bCH36NeHG184zwGY6IpSYfC869d1Cs1KoZwuaOdal5gjtyKAgdto21gKnVHpEj/GSNnlDs+eNJVWH4DHyAyo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ZcxC4j7L; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=qT36kdjZ; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AP6fhCO008505;
	Mon, 25 Nov 2024 15:19:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=EHWgO7aMPLgYCPgWnTLNHEksaKLShfvnMY60jLdNGA0=; b=
	ZcxC4j7LIRsMRqLTjz+XjdZA8EEpuP1b2YHV6mhCeSm+ZD87T9XE2wkSsVxMdUUK
	ZEBpRLc8AafidtZhHsjI8Ssbj67diLikd/a4kNXqe9mFAu1Ew9bHW6KjKvwA8WGl
	ODXQ7EEaq6n9J+HtIgR7DX+qPxbClHErFfT66lpAr/eUGCU42oQiaf0HSE79G4zl
	g4y3SVu3X8v89/I5Z4IHaEkvPwKyWxwlkK+/N/wPGuyT3mFchUYC06xyQmUwZo5n
	8QF3YrLJep5qSGWLDiRmJBgNf7yhXeT9mV+U4NPWk/QuxcXou40BhVc1aMIzzjwS
	d9Y0tNRsx+cxbGh8QmjGnQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43382kbbas-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 25 Nov 2024 15:19:33 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4APEIdRS009972;
	Mon, 25 Nov 2024 15:19:32 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2045.outbound.protection.outlook.com [104.47.66.45])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4335g7v07u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 25 Nov 2024 15:19:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=inLPruhSq+Bkb4xxGDVqwWA/4pKRWLubgPtC50/lcjAOnRNS+rORvup8qRRjvkSgPtsWTrfr6+j6W4wdYc8GbZ2/zNzQzp+lpmIZlQ/RwI1aTr/3vFhApbMLfQD7sGsOoAiHbqhQVrx6i8DdY9u0XF33SbUfWFeY8Q17nXhxjD1LuUslp7jIILotL1lDL/JAW+Yzdm5aRB+Q/iC/UlchzYze705LHLhJHlUxUqAAg+kR8/UXNyYCEslAqjZsa4HtACil11oqcnTP+kIeqGMjFHP0P8pT+SaCRChJSTz35i7kB16XwVDrzbqqSjv/0o8+NyQ4e3axk6LjyQOhIwvcOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EHWgO7aMPLgYCPgWnTLNHEksaKLShfvnMY60jLdNGA0=;
 b=mcMkiRFpFf3e8kk3Sd7IbJX0kzaYi1hnQOUpKgZWOksmWgPjn9Bzynq16q1gh1ZPnW9IpIVc3KeITfmW/qWo/7pHHXfrA+m4fvRCiYXlHK9UAV3A2420r+iaVSWGZ7+n/KJtf5GwaaodkJSz0K/K4sRD/dC22DeC4nnGHZiNgRX+G5U5IgApfVfoKv+ldnSMBbg+Svpf1xS9Hz3ycRoHvD3yMiJQNCnevy2jVZ3+UQ5VyDA1Wiqb5TGZqz4YHB71d9/04n2JSNU8uKPPCQnKJMHQ5O2Wbpm263JTiJaln4Z2kALPiNpDt6f2OETwrbNd/79edSUn51B9TjFKKSzyhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EHWgO7aMPLgYCPgWnTLNHEksaKLShfvnMY60jLdNGA0=;
 b=qT36kdjZgdQ5wiQCKh62rUbfShoaXdkjDwC6W9qxMGZ0qz1pDBrGT3d3OOw4NSl5ecFrLmhLxzssG6L5E9FlTEm5JOlLWK0T4S+PNX4y3UWhrMsgya3k1hgxwFtVA81nk3joR55VivmrmE2ewbqNJS1kUEEliwYhgg6O0o3l3jo=
Received: from CY8PR10MB7243.namprd10.prod.outlook.com (2603:10b6:930:7c::10)
 by DS7PR10MB5197.namprd10.prod.outlook.com (2603:10b6:5:3ab::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.20; Mon, 25 Nov
 2024 15:19:26 +0000
Received: from CY8PR10MB7243.namprd10.prod.outlook.com
 ([fe80::b779:d0be:9e3a:34f0]) by CY8PR10MB7243.namprd10.prod.outlook.com
 ([fe80::b779:d0be:9e3a:34f0%5]) with mapi id 15.20.8182.018; Mon, 25 Nov 2024
 15:19:26 +0000
Message-ID: <46dd43da-aaec-4349-884f-25b7d6e43049@oracle.com>
Date: Mon, 25 Nov 2024 09:19:25 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 7/9] vhost: Add new UAPI to support change to task mode
To: Jason Wang <jasowang@redhat.com>, Cindy Lu <lulu@redhat.com>
Cc: mst@redhat.com, sgarzare@redhat.com, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
References: <20241105072642.898710-1-lulu@redhat.com>
 <20241105072642.898710-8-lulu@redhat.com>
 <CACGkMEuEyXC7pOfwUTKSSrc-vrGW-v7SucV0qAHDE5Lo-b7zYA@mail.gmail.com>
Content-Language: en-US
From: Mike Christie <michael.christie@oracle.com>
In-Reply-To: <CACGkMEuEyXC7pOfwUTKSSrc-vrGW-v7SucV0qAHDE5Lo-b7zYA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0PR03CA0110.namprd03.prod.outlook.com
 (2603:10b6:610:cd::25) To CY8PR10MB7243.namprd10.prod.outlook.com
 (2603:10b6:930:7c::10)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR10MB7243:EE_|DS7PR10MB5197:EE_
X-MS-Office365-Filtering-Correlation-Id: c89367f9-1aa0-4acd-4087-08dd0d648c9e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Y2JkZWpWMkZQdGlKQWhPRitLMFBrUXRhdE41MVp6WkFHYXpXaVB0bHZQZmRN?=
 =?utf-8?B?TjE5blFYZHY0ZUl3bHBoNHJ1TkE1ci9UU1lhRlk4LzRuTmF3K2xZWW8vc0t5?=
 =?utf-8?B?WkN2RU9OV3kzNTRqRVJmM1FudUlOb1dWSUJYSWlHU3lKRDlpVGpUdmkzelFI?=
 =?utf-8?B?bDhmWnBVU0xtQjVwd0hPRXVGK3JHZ1RWenNETCtLYUdrUytrM01SMnpEcU9Y?=
 =?utf-8?B?YTZTQVh5aUsxTVhla2tkaFYzY0VpTUdsbUdIUFBzeTFHckUwWG1sYW1NNWhq?=
 =?utf-8?B?enYwRnl6TDU5NTRac1R3L21SVU9JdDYrQ0tBZkttdllrbktzL0VpNmM3MFE5?=
 =?utf-8?B?UUovRHYzdW9rRms2TnpiejNyZFhVVldqS05MdVNOVjgxMnFPcDBjRFdYaWpl?=
 =?utf-8?B?MzVYZ1pPelRPU3UxQVBkNXd4NzdOQk5UWnhxc3lUUUJUZWdkZk01eFU4dVBk?=
 =?utf-8?B?WWtrcHR5THhYZWVrS2tBRGNnYWxoMGVVbUZrWHliMG84VlBCUUdYbS9taGVF?=
 =?utf-8?B?a1ZoVnU0MU4wbU1NcXIyL3hGMGFRWk1XbjZTMHo3cG9icC9CYzQ3T0tqZmph?=
 =?utf-8?B?a0dpbEpSSElRZWNqY0c1SGc4bjQ5bkhqQnFoYmRVSy9TTUVKREpZRkVBMEpV?=
 =?utf-8?B?a08wTTRRTG1MempoOHM4dTZpak90b29LcGpxWVY5SW05Zi9EZFNiQUNHUURn?=
 =?utf-8?B?Vk9tZUR5Ly9Oak9MZkpVV1ppbFZmY3lRSmFCK3pXb0t3Z1Y2WDZhUDE2c3pU?=
 =?utf-8?B?Wms3T3gwOXIxcWU4bG1Xb1dWclhHQzVmRGNWOG5pUUVLdFdLSnlTV2dGTCsv?=
 =?utf-8?B?VkdzcGRYTFRvaGhBcVBWZGRZUWVvR0ZsYVlZVllwaWd0cHdOME1sUkVvYlQ4?=
 =?utf-8?B?N2gxTjZJalh4QUZQQjA2bW5vZWk3a0lqdVp3TFZGY3JwRk9naGZaaklOMmt2?=
 =?utf-8?B?SEQ0MzhYbVlnNVpiOEMvRUNnd1NIdE9ZL3RpWkdJZHRHR01lZ3FGS0lCZldD?=
 =?utf-8?B?d3Y2MGJiSmNOT2Vzekdob3pTcDBxVEVOa0dFRXVqam1oMkN6UThNMW5XMDhv?=
 =?utf-8?B?aTc4UnN2c3VHL2lvdGc3ZHBGWDdSSFozOUtiQ0JjK2xMbWtLVXcwWDFHZTF4?=
 =?utf-8?B?bWVGc3hFSy9vVXBYMGF3Wk5BUzZrN3V3U2FabDMvN2tWUWNZUmFJQTYwSzN0?=
 =?utf-8?B?akc4ZXprUW5RWXBnTndQcEMzLzhTRTJ2TzFVaFRZTHVCUUc1TCtwQkhpd292?=
 =?utf-8?B?cVNnbXZGSmZDelRsaER1YlpTU1ovRlZWanRycTZpcEdVajdKT29XYmxjOGVs?=
 =?utf-8?B?ajMxeEtONjBlYjZKSytxaWk5QTJqMEI1ODBOcTI0OXAvWEJVNTNCMUFQRkwy?=
 =?utf-8?B?U1VTMzZjS1dNOGluamtUakZXMGNVblJRazlnTTRBdndpV2Y5b2V5OTFCRUVP?=
 =?utf-8?B?Q3BZNHJYZjd0T1FPU01OdXVEU3Q2NVlTVnowaS9MR08yN09yNWZlanovdW93?=
 =?utf-8?B?T0pTbXNwVnhQZmU4dndpa3Ura09vbmZWeW9xOE1iRXFjOGhUSEFJZkpSZlJY?=
 =?utf-8?B?Rit5TUFkZ3JUY2RrNytRc2FqanhYd3dRR0JGSkJOQzhyb015bEI5M0NkS0pB?=
 =?utf-8?B?aUdhQnorMVRVNXhIVTNtdXAwMDBEWi9IQ2FGekQyQms5Wi8vMHJPR0FYWk4y?=
 =?utf-8?B?SFZEWUZQSlBMQmpTKzZhRHhUbGJRME5KOHpSRjN1anNvM1pFa29Pa2FHbnNT?=
 =?utf-8?B?aEZITFUwS2s2Q2QrVnhGSyswNGhFa2ZMdldNakVCK0JZeFg4bVdyaHFJQlpS?=
 =?utf-8?B?NE4wbUhlQ1VCaklRT0p5dz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR10MB7243.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SUFoOFZuNkJ6U2dlZmFRZ05YRUtONXNLNUVHSUNBK2E2RkRDcHRqNytVck5G?=
 =?utf-8?B?ckducUJLSkcrNC9TenNkYWxvSUMyMGJCeDlIQTBZOGUxcVJGMXA3bEZOUC9F?=
 =?utf-8?B?bW8rVjFVNGpxeHgrZmxGVG5yRWRoVUE0dlF5WXV3NGc1c3pEbEtxYU5rSVBm?=
 =?utf-8?B?M1IwcWQvVWNSdlJQOXdwN1FDRm1xWFpUcUZYNkVqTWJIdk5FcGJyUTBtRmtW?=
 =?utf-8?B?aCsrZlRyNHRHUkpNL1E4eVNHcTd0S1NuQzdsWTV4UmpacEpjYzdEWm0yR08x?=
 =?utf-8?B?NDcxV2Uvd3NWYWRiWEE5c29HTHp1Rkx5Q0J2TTZHa1V6K1Z3S3pkWjdlSmFy?=
 =?utf-8?B?eFVaT3VsY2tqTVVydWxlMloyUzNWUS9BelZnYUxEeW4zSTlsbXo4NnBsMlUy?=
 =?utf-8?B?K0Z2NTV0dzYxdld4TGtqRUsxRFBId2IvS2syWmIxUjlaQ21CVURMVDRTc2VB?=
 =?utf-8?B?L2ZXSkhKalpuY2V1dmFEZFFONUxOek1PZnNzYXZ3ei92Y0ovMEl1dnVEeXcx?=
 =?utf-8?B?UjcxdkZ1MVhyNldIWC9BUnJWQVN1WVpZM3RERHlJWFdnOWhWMlcxUm5UWGZJ?=
 =?utf-8?B?ckNRSC9KM0VNREhaZkdmZUJFVjcvcXVFZDBDaXVmN20rMStWcjRmRHFXL3cv?=
 =?utf-8?B?WU9QNnpVdlFFbFRuTEt2TUdoL3FoUFo3d3UzZWdUK0diQ1lSNlJ5TGhOakZX?=
 =?utf-8?B?SFc1NTdGaitRcXBlaU9RYStJdUVwQ2hUeUdwVHdsSFMyK2t1UFRnT0lGcGJ3?=
 =?utf-8?B?YTQvVHJYTUcra1ArTnBYdnQySlp4MTE5U3MvWUE4ZHVjMDNNUEU5aExSWUpr?=
 =?utf-8?B?dEJkRUIxNWVTcXZub1hrMUJMdGorb05JU3h5OGoxQkp5N29KZVgrUUVVNXhB?=
 =?utf-8?B?WmlxYmVLNkl5UzdLcURXc0pSNUR6ZnplSFFDdEtOZkhTYU9QVWNVN1lod25z?=
 =?utf-8?B?N2xnVzlUakZIWjZLOWtTQ1pxTTFlSUY2RFhEZXJscmxqekE5dHViUlBkdkll?=
 =?utf-8?B?TEZCcWcvSnVZdmJmUGtoQXBuNEZEenZRY2VWdlYyeVVlQS93YjlOY0tFU1Jw?=
 =?utf-8?B?aWpqV0hEb2ZneGFUSlQvTGRKbUI4azE2VHhwREtoVlc3NHp4N1ZURE4vZzVI?=
 =?utf-8?B?cWYyTXhOdHdnWGFoT1RyUEJoajdUODlLWG55NGJZdm9TVzV3NjhHUWhoZU1n?=
 =?utf-8?B?ZEhrV3pSZS80dG42QmpwZnMrb3I5VmFYSFdDdnFhdE9pOUlFajRTeGY0MTll?=
 =?utf-8?B?UVczYlBScXVQOGZNYjVpQUpjOVU4UEJIM05IN2FHdzlSL1JYaWZ2VFZPV1Nt?=
 =?utf-8?B?WFlXNWlXQzgwaW5PVUdURTdPS2RSYzZMdTRwVGM4ek9TbkEyOGFoT1hjNTQy?=
 =?utf-8?B?UnY3VHpmVEREYUFsakNGY2FOZVlPSVdWdm1iQk83clZiSVFuaStKY0t2WTk4?=
 =?utf-8?B?UjFnQzljVFQyT3dLM0lyTlhpTTVkQmZORWhoSk1NYlVsTzZhMndiK0orZ1d5?=
 =?utf-8?B?R2FFcVkzcGNjeHVYemFLM3E1aVpNNWhVbzVNYzROWjlqUHFWbHFvMlNVVkVM?=
 =?utf-8?B?UWZLT1BVMWhScjQ4L3I3UTE3dndUdkdCTnBNekZXVjIzUm43N21PMXQyYWhp?=
 =?utf-8?B?NlJDN04yNDA3MjQ0eHQ1UnJ5N0Y4S216Y09veWpqZjZvNGticlRDdVZpZ1Qr?=
 =?utf-8?B?VCtUSTlBTVZmeWgwanJLYUJpUHRjYmJrVHp6THhYdzJwTnpoMUJBS3c5TVNF?=
 =?utf-8?B?MGxlK1pjbGtKY1ZkQ3VQOUhFL3RpOTBNOFZlVUpDb21MWExVWCtRQW1EcHN3?=
 =?utf-8?B?ZnM2WW1tdlZmSmFIbFNWTlZnM0U3V1kxZjFoK3drMkx6Qm0wTGVqUVZWeWNt?=
 =?utf-8?B?enlEdDNMS0ZoRWxPYkJ1WWM0ckRwd2xGMm5POVp3MTVodmhDM3gzTVBkUHlk?=
 =?utf-8?B?cFRFZmFTbi9NMmxPQW40T2tRaXRKVnhrUFhoVkJvbEx3YWhTaWFyTXptOElT?=
 =?utf-8?B?dkJFWEowQjFzMHBHb0FBYlRCNy9MMWZ2V1hvS2tZZ005S0pkdkp4ajVqTGda?=
 =?utf-8?B?WjlYa3RudWZjM2NDWGNCVGhJdHdBeUErcG96N2tRVTJQWGpUcDlJcmJkQ3lr?=
 =?utf-8?B?dnczMUpqTHdDM3RyeUd5UEJNd2E1K0lOaEc2NWxRejRGM1hxS0dsN2JYQkZx?=
 =?utf-8?B?Mnc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	phmrmG+k4WMucpS/ICOVfbftfriQeKERGGdlsw+50/hcqpCLExg6SluSBJK7HDLjGqqPuV5GSNRZt50s+G2XsRDCfzwGtPkArrNMO/X2YLoloZUYDZLWiC+Ptg8Yhge0P1snoxIhrejXiDBlUFL7ykqpVGa0+XdjuXQYffc2tuey7JyZ/gct/+9cFaJaxi8DglG+dYD2LPMg2hoL0WZFZJMRc0QUnuhFmMAd7OhCKcCESk83c2Hln8sJ3uXHxWcxT6NnafPkb/8Q6JOcVHMTI7osX1Xn+bG0wXc+jixeXeB+poa1IVzdBw7NNMBdw7gVuuM0wBs4Gevidu7MgowCrJe2WqAeFeuKZPBDlIioE+tQOWlPN5nfmX8N/Z13GTTYqg1PtgGftbhhYIUC+hzOuv3gQXp5Cfmoaoy1TiGftg5uYYHgCFLSeI7JTqvYtNxG7kBryCxyL+1SKXa065ZzyuDx0ObYzOeIRktAnQ9X/+Vd/mMlnwilQyJJMHdJ9FxdY2TmrGM2eGxy3bEZ4OKA9gIKZLsY5iA9XgpoIGLaAqFPIbVRnjrsOa2pCgKHD8SwtUo+ObRr6pm9mTL4zNtlhPabyq6qkAb+N153Qxzn09o=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c89367f9-1aa0-4acd-4087-08dd0d648c9e
X-MS-Exchange-CrossTenant-AuthSource: CY8PR10MB7243.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2024 15:19:26.5504
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hm5JWKEMWFmeTGnscara4XfsiJOVXz563x5qDYa3ljngr8TnM8rOIHLk/de5WDZPZQ/kCZCw1WFsBGQ6yxc+lUtorhLBuuDkvXWLgRbsWq0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5197
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-25_10,2024-11-25_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 spamscore=0 suspectscore=0 mlxscore=0 phishscore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2411250129
X-Proofpoint-ORIG-GUID: jMvQHiXFQ2BPiJ-mmskLX37_DkKRToYg
X-Proofpoint-GUID: jMvQHiXFQ2BPiJ-mmskLX37_DkKRToYg

On 11/5/24 3:39 AM, Jason Wang wrote:
> On Tue, Nov 5, 2024 at 3:28 PM Cindy Lu <lulu@redhat.com> wrote:
>>
>> Add a new UAPI to enable setting the vhost device to task mode.
>> The userspace application can use VHOST_SET_INHERIT_FROM_OWNER
>> to configure the mode if necessary.
>> This setting must be applied before VHOST_SET_OWNER, as the worker
>> will be created in the VHOST_SET_OWNER function
>>
>> Signed-off-by: Cindy Lu <lulu@redhat.com>
>> ---
>>  drivers/vhost/vhost.c      | 15 ++++++++++++++-
>>  include/uapi/linux/vhost.h |  2 ++
>>  2 files changed, 16 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
>> index c17dc01febcc..70c793b63905 100644
>> --- a/drivers/vhost/vhost.c
>> +++ b/drivers/vhost/vhost.c
>> @@ -2274,8 +2274,9 @@ long vhost_dev_ioctl(struct vhost_dev *d, unsigned int ioctl, void __user *argp)
>>  {
>>         struct eventfd_ctx *ctx;
>>         u64 p;
>> -       long r;
>> +       long r = 0;
>>         int i, fd;
>> +       bool inherit_owner;
>>
>>         /* If you are not the owner, you can become one */
>>         if (ioctl == VHOST_SET_OWNER) {
>> @@ -2332,6 +2333,18 @@ long vhost_dev_ioctl(struct vhost_dev *d, unsigned int ioctl, void __user *argp)
>>                 if (ctx)
>>                         eventfd_ctx_put(ctx);
>>                 break;
>> +       case VHOST_SET_INHERIT_FROM_OWNER:
>> +               /*inherit_owner can only be modified before owner is set*/
>> +               if (vhost_dev_has_owner(d))
>> +                       break;
>> +
>> +               if (copy_from_user(&inherit_owner, argp,
>> +                                  sizeof(inherit_owner))) {
>> +                       r = -EFAULT;
>> +                       break;
>> +               }
>> +               d->inherit_owner = inherit_owner;
>> +               break;
> 
> Is there any case that we need to switch from owner back to kthread?
> If not I would choose a more simplified API that is just
> VHOST_INHERIT_OWNER.

I can't think of any need to be able to switch back and forth for
general use.

However for this patchset, I think in patch 9/9 we set the default as:

inherit_owner_default = true

so the default is to use vhost_tasks.

With that code, we would need VHOST_SET_INHERIT_FROM_OWNER so userspace
can set the kernel to use kthreads.

I'm not sure if in the past emails it was resolved what the default would
be.

