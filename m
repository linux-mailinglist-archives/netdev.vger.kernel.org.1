Return-Path: <netdev+bounces-151471-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2504D9EF7B3
	for <lists+netdev@lfdr.de>; Thu, 12 Dec 2024 18:36:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D520D28E3CB
	for <lists+netdev@lfdr.de>; Thu, 12 Dec 2024 17:36:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89B2C223C57;
	Thu, 12 Dec 2024 17:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="RAh0zyMH";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="oV4hycA+"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 142C8223C54
	for <netdev@vger.kernel.org>; Thu, 12 Dec 2024 17:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734024968; cv=fail; b=pXz2M6/glFxCQYtfDk5E1ivSlYCIytJinx7oicQQ8GREYXmde0DvvjYMUA2TB6uuVC+UeYoPrg4Jqa0NDF7xH2hs+ubJmq02xuQJn/uiCwtLG9bHSSCT11oMQux29MCxOWKDSF1nmuRfMuYsenCcsYupOkWErurVWh0AUqlTo5Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734024968; c=relaxed/simple;
	bh=8E1yuNkO5N9IotuD2MXyRzj0i/M3m4e4v1awpXW1Rgk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Z2WSPFln8J0ijqRgIGj/JgiDWXib47LUScYgrcNgyS+PFrNmLAQP90sMd1UxydIb3m21BcGSGpjyMvSEnXOabvdgC6aOiXkSKjCXIRkywCAnEcSnBVu4rlrlVwCeoICbn1PTqaijN1KoOQ3YGMu2m2xUrCiLcsFMf6h/68bzt6U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=RAh0zyMH; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=oV4hycA+; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BCBhU58025546;
	Thu, 12 Dec 2024 17:35:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=8E1yuNkO5N9IotuD2MXyRzj0i/M3m4e4v1awpXW1Rgk=; b=
	RAh0zyMHfRe327M3FpWB2eaDvB5s4ZbnZaHQ7VsnkvzHHZJlJ/efmDuaMoL4eGET
	XOmCAthPyhxSJbv1MnVPGQ19uQMVZDHZD2+9BcrPs5Bx7GtMitLTdIPu4GtlqVdK
	bVV3EkZq1eGvjdq0y9N+knwlKWZMd0Xtnpz+IYvws20gVayBFJVmT09Qn1hUI6nT
	R3vySCkEq/L18WSxmFqdyzKX5BWkQOGUo2Lsevm9g5a7kK+AZl8RDhmIy5yVVeoU
	Tm0g10OXPQ4amDPA+m0DwF67Xqrd7Z87oFF74OSIlsbk8iNguEVp0MuuMPoks+Ts
	uaeC/3T1wjQAW0PQFJhg6A==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43dx5s8v22-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 12 Dec 2024 17:35:43 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4BCGFLrp008663;
	Thu, 12 Dec 2024 17:35:42 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2046.outbound.protection.outlook.com [104.47.70.46])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 43cctbf4hw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 12 Dec 2024 17:35:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Aj+Ca+bNKk19t0szRb3bJsWiunen1xEbTgm+0YZtoBK3QlhV7cQPkxK7/ATXQRqmspv/fBlOxvnDeV7omqrd6Db8jQvvFvGVrD9XvrUPC5sNfUk1c3JBqXnfXdNkqadf2KfKkYmkB4tEe8D879ecCnV0D+4KehAQFvxuoIdigT2gpQXh9tK7kp+TX46sAbwTiA0Ia+QBKxfhmjUwYd1ilgjLj6tRaRpgD9vIchqFvfoqsBqmgBuUSEdx3jDKI3yVdFEhgoL6QtiBIBbhKcldShL3n2TafkmEvDMiF499ALQae5aROlm4IDjb/OH7r4V47R1KSuFQnzsWe9vlNxZKxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8E1yuNkO5N9IotuD2MXyRzj0i/M3m4e4v1awpXW1Rgk=;
 b=f5DAvSvglLXeKPnaugyZ1y1kqvJqQVsCSV4ru3RoNlUEdjAR+ydQcFHDkQic5jpc3mzuAaZqgrFt1H/SOEELFlrLfTPPz4hmiyZHa5OV/4f+u6AYbwVcBsVQQDHlAn735m+y9UDvcaxOJ72k5mutl+nsalNQa27tgNFXs3IWh7VPxOVORfVQJvc0FEFT+qnF35OMxy0LyylgM3LKJLOu+doX3gvhKOeGmIYt4wOd3CtBt25v35SlbovWhZoo5aqI59sC08TevENNA8TjJO/w7oY1m8OfGOu1HnhyGV56SdHbStGKIPUQ68uPJz0ps4q50UtZwjcaDJ6Eujl1bUczbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8E1yuNkO5N9IotuD2MXyRzj0i/M3m4e4v1awpXW1Rgk=;
 b=oV4hycA+1W8kz8iUqBrkQs8Pyd3EMf7xFtG5Xlx4KeIojSsyc8jD/U0TlICPxaE1aA2iokeQvF4+jBCfUYgyt0LmOETgweGSeMOqWpCf8xCJdBEq85PDp7URs3uaSnWhZPn2cXqo9TdbHH3R2jGLvqa1dFEOwgCMRoOVQGPDeQc=
Received: from BY5PR10MB4306.namprd10.prod.outlook.com (2603:10b6:a03:211::7)
 by BL3PR10MB6041.namprd10.prod.outlook.com (2603:10b6:208:3b1::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.15; Thu, 12 Dec
 2024 17:35:39 +0000
Received: from BY5PR10MB4306.namprd10.prod.outlook.com
 ([fe80::b78:9645:2435:cf1b]) by BY5PR10MB4306.namprd10.prod.outlook.com
 ([fe80::b78:9645:2435:cf1b%6]) with mapi id 15.20.8251.008; Thu, 12 Dec 2024
 17:35:39 +0000
From: Allison Henderson <allison.henderson@oracle.com>
To: "kuba@kernel.org" <kuba@kernel.org>,
        "kuniyu@amazon.com"
	<kuniyu@amazon.com>
CC: "davem@davemloft.net" <davem@davemloft.net>,
        "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>,
        Chuck Lever III <chuck.lever@oracle.com>,
        "kuni1840@gmail.com" <kuni1840@gmail.com>,
        "wenjia@linux.ibm.com"
	<wenjia@linux.ibm.com>,
        "jaka@linux.ibm.com" <jaka@linux.ibm.com>,
        "sfrench@samba.org" <sfrench@samba.org>,
        "matttbe@kernel.org"
	<matttbe@kernel.org>,
        "horms@kernel.org" <horms@kernel.org>,
        "edumazet@google.com" <edumazet@google.com>,
        "jlayton@kernel.org"
	<jlayton@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>
Subject: Re: [PATCH v2 net-next 12/15] socket: Remove kernel socket
 conversion.
Thread-Topic: [PATCH v2 net-next 12/15] socket: Remove kernel socket
 conversion.
Thread-Index: AQHbStckRy9FJQSwF0KxV0/DWxdF77LgULIAgAKSIoA=
Date: Thu, 12 Dec 2024 17:35:39 +0000
Message-ID: <19e15f0686ed67d5d9031ae17bb0762f8a09ed77.camel@oracle.com>
References: <20241210073829.62520-1-kuniyu@amazon.com>
	 <20241210073829.62520-13-kuniyu@amazon.com>
	 <20241210182004.16ce5df7@kernel.org>
In-Reply-To: <20241210182004.16ce5df7@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR10MB4306:EE_|BL3PR10MB6041:EE_
x-ms-office365-filtering-correlation-id: 0039f384-ca29-4f6f-ba3e-08dd1ad3650f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?Ni9qYUsxSFlqemdVcG1kbURMZjIvL0FLS2JUTEVORkZaNERxV2RaUHNOQWxV?=
 =?utf-8?B?bWg4aVh3RERKZFQ0Rit5QWw2SEIxckREZk44Qzd5aTV1em16dXUrQi9wQzZE?=
 =?utf-8?B?MkJ3YTl3TnEwaWJvLzRrVWJ2WElvQVorYjZ1eEZmVmJLZ1FwTVZ6MTlXT29k?=
 =?utf-8?B?RS9TQ2ttM0lzY2cyQk1sOWQwLzNtbjlXUGxWWFB2aXkya0pHYytKS3RUNFZQ?=
 =?utf-8?B?RHJmbU9rYUVsNW5PdGdyUk8raFF1bmQzV0MxTXUvKzNzdzFUSExtKzBwV0Zp?=
 =?utf-8?B?VTY3VHdsWFF0VWVtVFk3dHBZSDVuU01BaGRkQlBITjZJQ2NHSlUvYTkzV2xj?=
 =?utf-8?B?T0VTUDlyMVdPVW1nNVhQOEt6N2hHSkF3b1ZRWkh3NkFxc2RNUFcxdXZOelBj?=
 =?utf-8?B?RFpDVlNMMk1sQzI4b2JIRmF2QVJtb0IxV2g0eTRHSDUzNHhlOHRkOVFmamZp?=
 =?utf-8?B?MEluR21CNGpHeXpuQ0hIajY5VmxKdWtZS2lRTzJwMlpnUGpaMWhHTEIwbEN1?=
 =?utf-8?B?ZlVqZ0tGSHRIazBMUURRZHdheHlwNHV1dzJCd1RSUFl6aGhSZXpCUURPRzlQ?=
 =?utf-8?B?ZlF5eGREVS9YN3QzaC9Ubm1VOFNFSEdCT1VSYzMyMXZMYjBwUWxpeFVQcUs1?=
 =?utf-8?B?WE9qQkg1bXdOZXZPTWtiNGdPcWNVbFVrS1E2dENCdmRKeVpPRkU5QXhNaGJn?=
 =?utf-8?B?dDM4MUVrOC9oMDVLcEVrZHZvUmpwUEQxSXlxS3hPTW5ndHZ1eWdsWStBTHho?=
 =?utf-8?B?dmFhSzNxcC9WUzFNTFZCcjc4NmJLY1NTRVFaZGIvcE5PU0ZwMERrelFYVmRL?=
 =?utf-8?B?UEgxRFk2VlVncmM3c1EvMVYvYThDeEVrS2FTYmZVY2hLcm8zOVFUOWlPYllR?=
 =?utf-8?B?dGg2U1g5T3JjcTgwYzIyN2R3b21rSm5uS1hOcGhUeHdWRitkbStib1pBRlR0?=
 =?utf-8?B?aWt4dExoWFIrR0RsbHRLQUs2Y2pNZGRwWS9yVUxNV0ZzcGVkakZsVUo4dHRq?=
 =?utf-8?B?UStZSnBvMUNjZU1ObjBsVmVsbVZhTktvNitSS0RiaUlVMDFHb0FONVltUldL?=
 =?utf-8?B?L2F6ZnhVMlJEWUN0Tk11RmVLTEF0MmQ3SjRsTnhsVXZCcUk5dVlkWHNyZEJI?=
 =?utf-8?B?bVYrQlZyZlM3MW9yZVIrNGl1elJvZ2FsblNzdTZTM1hUUmFnQmQvamVYVmh2?=
 =?utf-8?B?bDJlVjlpQUFPYlJNRzU5VXVaZWh1WDJGVDI0RWJWOVdRNzB6WVpZcUpFYWx2?=
 =?utf-8?B?YWk2aVFxR0NrYXVaV3NtRjlsaXVqTDBQRCt5YUNNWlo0KytNY1pnWnY2RnFm?=
 =?utf-8?B?ZkwwOXd1anFXS20zQ1BMT2hyVWxxOE1VYVBKWk9RU2VyektvdGxPbmpKYlBs?=
 =?utf-8?B?VHJjQ3NSZHUrV29DU3RlbVNwelVQN05CN0g2NkJXUS95K1FXczVFSytCeUxs?=
 =?utf-8?B?SnZQZjhiMHZWVnJqbFhDcXdQYWQzMzlFVGJ0TlJ4TWw4MmpINC9kUGN1TWRG?=
 =?utf-8?B?UDkvNmh2a08zTHE0V1NvNWhWUG4vQTIxdmNpejFFWnRlb1U2S050S3h3N3lT?=
 =?utf-8?B?WW1XZmZucy9ZNXFXUHdKVzQ0eldsTlYydVZzcnljVGRVUFUrSHNTQ1FaZXNG?=
 =?utf-8?B?Y0pEVjlOQnhZOFMxWnd4VDJ0UlEzUUh5NWM5ZTJHdjVrYm1veWNQY0ZlaW1I?=
 =?utf-8?B?QWFrV1QxekxpZlRDZTRsb1hnUTJxOHFqU2J4T1F4YXRWOXhGN1JteVlpUXNF?=
 =?utf-8?B?ekNPZTZoMFROcHhucnBucC82WWZZc2ZKSTFHTElXbjFVditPVXhsMW1oQ0Zm?=
 =?utf-8?B?ZlhTOHYvQnVwd2ZEMnBzUzRaaWcxY0srQmdqM2dLcXFXSys3NVY2MDdIWWxr?=
 =?utf-8?B?b3dIZXRHWWE0NXdKKys5WXNxRzlyMkR2cU5KdThjKzRhTmc9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4306.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bU1sYVlhYXNya3pYNDc3ekdqMEJ3SFYzTkVaQllWdVdhL3BxbjRYNEJraUhz?=
 =?utf-8?B?SEVXd25XOWZpUktXekhwUzZqTlc3RG1pVUtxQzJGVktJQ2lySEdPalFEY29S?=
 =?utf-8?B?aU5BQmYwN21kQUZBZE9vVVM0L0wralRPZkx0WU5ZMUMxeVdad2NLczlZRTJL?=
 =?utf-8?B?b0dvNWtLUjJFUmZBRjE5dDhnUTF2NWpSQURLU3djTEkrZkcvcjBLclhVd0I1?=
 =?utf-8?B?L0xYMC9TR1lHaUQxc2N3QVdJeU5DN01yTitERTZrTm9DUnhsYURGanlQYVJl?=
 =?utf-8?B?TUprbDZDdjZSVVU1cmdDMVhJRWJtU3h6SVY3R3BQVHl3a01YcS9ma3kvNEJP?=
 =?utf-8?B?OHB5aEc1OTY4UWk2VG5ITDVYVjFpbnFEUUhCdjBSYXY2akhGRHpVaEdCdlp5?=
 =?utf-8?B?ZjRxak5MY08rTFFDOVZORjBpU2xoYjVibE1tWk1GYVNSUUphN1ZFWWUrdjhD?=
 =?utf-8?B?Z1F4WjNVZ09aYW5kdE0wM2FieHZRZFZ4Ykx2Y094WjVhWjAySlNMVjM3MWdW?=
 =?utf-8?B?WGhyb1VqR1NRTmtSMG5RZkttRVJGcUhydm5XZXozQ01HVGRpNWw4RHV5a2t0?=
 =?utf-8?B?Vm95cStFblg4cG80TXowenA1cmR5d3lmT20xcDRuZ2piNE1Eb1NQYnJGOWFJ?=
 =?utf-8?B?RTVkblNDNUUwL1ZoWkwvZzFUdzJaNHJodUpxSjVDRDBnbTI3WE8reXlPQ0h5?=
 =?utf-8?B?MUJlVDF2bHFEQzFYeFBhbWhNazF5M2x3NFN0RFdQY28vb3dkVXNmbHg4ZzZT?=
 =?utf-8?B?Mm8xU0dnM3lJTkN3elcxS2t4NjF6d3R5d3B5czFONHhKMzl3N1E3b0E5ZzBG?=
 =?utf-8?B?dTRabnRoWGVQbnEwN0h2NW1RREpwZVJwUnFiZVVtQVkrTW9kd2w3UjRPSWpv?=
 =?utf-8?B?VTZON0E2czlsRXp3UUd1K1VZWTJmUXZISnhzeUUwZVZMUStlWHh1VkFQNkda?=
 =?utf-8?B?ZDhNeHFDRCt0WWQzRVdwQlJkUDEzYmhnTkFRM0QyaEhSelFsUEZVWDByZHY3?=
 =?utf-8?B?eTVZUzRPTlNaQU5FYS9NdUdpb0MvcW5zY0RLOCtRUGtwNm1ONzJMOFM5RUdk?=
 =?utf-8?B?MGZoYW1KcVJReG96UlduNXR3SUpNNjl1aGovT3hSNzJ5Q2p1anMxRWlVcVc5?=
 =?utf-8?B?SlRBV2x4Q0lWelJIU0VldnhwYmIySzMzR0x2UG8ybUt3NlRkUEs1bnAxUVk4?=
 =?utf-8?B?azhwZDJIYWtjaXF6VU93NWNyVVpmdFFZQ1BQdHk0SjB5eE1laFFZZ08wSVBa?=
 =?utf-8?B?QWFMUlhTdHRVMGNHOWhnQTBZVXlGQ1l5WExwTUtwYVJKbFZmRkpQWUp4SHV0?=
 =?utf-8?B?bDM5NndzVndoRWl6SkRzL2kwWTcyTy8rYitNYUdJSTRnMHl4Sm9Remszci8x?=
 =?utf-8?B?R2F3U1BLVExZM2FNSGxFRllyVlIxbi8xeVVWdEt6WUF1V1laT2owRm04YS8v?=
 =?utf-8?B?dVdHNG9XbVFLeUdGQ3NkbFJOQ2dDWGhqaDVhRGxaUjc2SVBYaTA2dW1yM3BD?=
 =?utf-8?B?Q3ZWNzBycHRCbkNxWTdQVFNQd3o1WXBCYXM1dHlLRjlwR0kxWjJXK3J4aUI2?=
 =?utf-8?B?clBGTk12bnZtZ0pOYnZzcjBVMGFjQ0ZYYnJUMnJjRUJTZnRDSjY2OTFuTXFC?=
 =?utf-8?B?YXdOTTlvTlRjTTlOSERORk5RUExrVXlqN2ZDejhvV1NyMzNQL0xRbVFQTjVn?=
 =?utf-8?B?TjdnK0ovZmVINXdUYVN0RXRzeVBCYkJ3TkFwajFIaFRJQlpuWHc5SG9yckhX?=
 =?utf-8?B?eVpTbEhKaGZ4eFNOeWQ2b3A4QzNhTk1FRVZGTXZNVjludzA3VWUzTUJ1Nmpz?=
 =?utf-8?B?dkxuUFNsd0UyQnl1Z1Q0ay8rOERrT1FSdTJwNmZCRFFTK2N4NFlyN0xPWndt?=
 =?utf-8?B?SkEyNzV6NnUvTEFjY2ZaVzVTNGRZV1BGNW9XWWtIajc0OW5GekFORlpYSUM1?=
 =?utf-8?B?dk1wZnVpVHlBZDhQUnNNcVh3cXdPbW1nQy9kVTNTdTNNRFRPNk15L2tGVTdQ?=
 =?utf-8?B?RWcyTkVWTDNoRkxGbjQvV1NVQWFoZVRzaE04Z0FrMGZZa293S2hFOHVoZ3BO?=
 =?utf-8?B?T3BWM1JxUXk4K1BxM2xXTjlNSEtYWXVBbTlULzhMVmQwTHlDamsyNUJtQ2J3?=
 =?utf-8?B?VGhGQnFTenYyZ2g1TU50K0FCWXJRN0FiaituL1BFQVZkbE01V2VuZkFoaEJF?=
 =?utf-8?B?Y2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <588C357F3539CC48A79ADC575C275658@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Y7uYVtgHgxYIxo9f1+Oo7z8uxygrddoqB3zxjun4/2QeX6XEj2LxRWXNDJbaziBeWkdxNFgmM9onTYxwVOM7rmSUpjTqsw6yD1BYe8wYu2z6RVk2BfEIdqxfwgbylyRkTxffahRtpEm4NLzdHzzBliRSGLi9Bj3QHNGP48Mplsjz7h2lBrrjNBbsJ0528VBn+XLofzhN4MycfJPStmoxYfRzFEA9SUCpcj/t4YQ3BJzI+84xfyw5pX5Wy8f9sv6lr5LmZZfgehOC7KbqQIDA9TcpreGfaB3WeZHtW38s+ZJHgIBhEOtbEXDQzxFC2DNW2i4bDKPCtBQ00JGO8VFuiPpQcvo1m5u042D9rVgVj7KgGaOF6bnVgeMk5Dw0kAIEv5J4xqmBybnbFeQYiZO+0TpZOiZjpxwkF/yOrZHSAxAjlXooI92u1jZ5CJqopNLvTJcYNR+/OJBA8wQGTe999a+I8iIsiDlzkiTonhiw8d/LsS2ne0gZcKFNLYoo4Us0Zj2O12w6eneNxpbTWBVavyDCRWN2W5/n/KDwsFkgib7AsZMAha0letCjiuJ1AYUE3bIAsolxW1JsKF8jFw/K09sjedNoknUn85QpZdUcqQg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4306.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0039f384-ca29-4f6f-ba3e-08dd1ad3650f
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Dec 2024 17:35:39.1735
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SVtcsDBfmw6oKhLbrxZDC7kZ25B76AEyeTLfbdxGJwJRxoERRLU+ugX2vuO6e9seZhcUn2+t+uDydxIi5B6fqFzabvm53wkqt4RQLcGN97Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR10MB6041
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-12_09,2024-12-12_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 adultscore=0
 malwarescore=0 mlxlogscore=999 bulkscore=0 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2412120126
X-Proofpoint-ORIG-GUID: SROiqWURrJ1XEW5_M8aI7YIwK0rIaDUh
X-Proofpoint-GUID: SROiqWURrJ1XEW5_M8aI7YIwK0rIaDUh

T24gVHVlLCAyMDI0LTEyLTEwIGF0IDE4OjIwIC0wODAwLCBKYWt1YiBLaWNpbnNraSB3cm90ZToN
Cj4gT24gVHVlLCAxMCBEZWMgMjAyNCAxNjozODoyNiArMDkwMCBLdW5peXVraSBJd2FzaGltYSB3
cm90ZToNCj4gPiArCW5ldCA9IHJkc19jb25uX25ldChjb25uKTsNCj4gPiArDQo+ID4gIAlpZiAo
cmRzX2Nvbm5fcGF0aF91cChjcCkpIHsNCj4gPiAgCQltdXRleF91bmxvY2soJnRjLT50X2Nvbm5f
cGF0aF9sb2NrKTsNCj4gPiAgCQlyZXR1cm4gMDsNCj4gPiAgCX0NCj4gPiArDQo+ID4gKwlpZiAo
IW1heWJlX2dldF9uZXQobmV0KSkNCj4gPiArCQlyZXR1cm4gLUVJTlZBTDsNCj4gDQo+IEZXSVcg
bWlzc2luZyB1bmxvY2sgaGVyZS4NCg0KT2gsIGdvb2QgY2F0Y2ghICBZZXMsIHdlIG5lZWQgYSBt
dXRleCB1bmxvY2sgYmVmb3JlIHRoZSByZXR1cm4gLUVJTlZBTC4gIEt1bml5dWtpLCBjYW4geW91
IHNlbmQgYW4gdXBkYXRlPyAgVGhhbmtzIQ0KDQpBbGxpc29uDQoNCg==

