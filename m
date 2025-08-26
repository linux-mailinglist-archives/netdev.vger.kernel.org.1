Return-Path: <netdev+bounces-216975-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 720C5B36D98
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 17:21:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 081C37A3F08
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 15:20:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 951B226D4DD;
	Tue, 26 Aug 2025 15:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="droL8YPs";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="QurJsXBB"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBAF025B1DA;
	Tue, 26 Aug 2025 15:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756221699; cv=fail; b=QBat/bNLcesDa9K7KaHP8nBm+ym59iW321jPHPIe5ev52lgRQWuBYiVLaHcuIBZX/0bS9r/euf6PjKtu/55El/PO87HErkC2go+75mnHM6h1G68tZ5VgPqPeHtoc+zPEoRdanH0UYRDEERxBMA3tnLrRgJz6geS4gVn1fq4HbnE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756221699; c=relaxed/simple;
	bh=Sg2juMU33jP6s1wiNrABOYCc8v8PyVTdcBNJaF+kFzI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=FC0Dx18/NlxI7wRMf3Bh1K4M9Ya4IWBIvOLmgc8+say1xWnCtfXtuN4VTDiL7vFbiOdi2i/tDiFgxx9o1IKfq6/Bycp/4PxYj/G4LuNh2AM6SsR4hGmYxleI+SiBAkV/y5cxCFrleE4Bi2jw0375ssR4E7LC0lvaF3msz0+oIv8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=droL8YPs; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=QurJsXBB; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57QFC3xM010455;
	Tue, 26 Aug 2025 15:21:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=328ySkyQX3FFPtP0IMcpxsgPq6XbFMMmg4S3yNBZs50=; b=
	droL8YPs8jo3MxL0Hgqdiv9mxsgvEVvV977nez+4ZGdohwELqV76yTK3ijgGQqz8
	YbALzYxlC1p3fQfnGAMqOxxQ26epcvT3+W7cc/eckRgaCPZnj/EeS20Aq35fx+1b
	Q4zH3MpZJVWALftRnPx3ilgAYrn22FsxP0/hrRD7Hy5jKEMDqVctrN/8DVCVTrzS
	9L4VsGAwggss65SaEazWMK+tvo0sgGES8Vq0uAKi4LFsYTTFD/GKnHmbxMWAb6M6
	QOFp0oRcvRMwv+13zo0b4DiDN6HbYeoA6Gz4hfEOOR1pu7fOUnGERbrX5+mWutDV
	EwzoNHRKTysEd4MteHZ2Hw==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48q5pt4sb5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 26 Aug 2025 15:21:05 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57QF3DcP005033;
	Tue, 26 Aug 2025 15:21:04 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12on2055.outbound.protection.outlook.com [40.107.237.55])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 48qj89ww2n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 26 Aug 2025 15:21:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Byxy6yzaclDA+BG8if3B+GawuPuB4pd0woBY/Oxzxc+nLusT02kYSj3lREX3R56I1RtkuFPluXite05Uut4floyJp9wDtK5zGR7U3qv9lunpJ8+87i/zkI7wKkBhfQdFVhYHSVkJmoP0eFJS2ws7+15kojvGDDFu0W4ZtYoZSKv4c5HilgT1Frtm6FV3C80DB9S8n9wyNB2BJKOhSNFdmqdlbEp50oGOGVzY1hHz136oyXdq679s0FVDYRk5xLgAKXT1OSOvmJJj9iXH+E4Mq8i03NeGV0qBr1GbBrlbYibD4nTA2pu2O36FL0tcCyGQd+A0Sg7+XQicBvMaL97rug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=328ySkyQX3FFPtP0IMcpxsgPq6XbFMMmg4S3yNBZs50=;
 b=HKqG7tJlC2WWCQ/s8Z4qnZMZbTp2TnprFE+EEY90Ee6ft/TBhZdwHg5qUyVh3lpRDP1VF8xY39oECyvuVGvPH2sEWiwJibUzmPAv7jw4DZmt0rFDjQ0JgU6SOePgxiT77J7IkrvuypfkLRPwN2eg/u2nkVH5EXgX8PuDKYr/cV1M0w0rGppiwOcLG1rVOBG4mawVe2e21eCXg403peB9a2Ru7sHm8op3BZjU14TlOC2J4uBv0/JyILV9LAo8i/T4/rKAjNsDbx6x6Qqlm3S0BfzeW3XxEixxnEO9ouG/0EaWkx/62AkWn+Hg8Rs3+nNxSHP6T8yuLIQIsdSp+EXpNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=328ySkyQX3FFPtP0IMcpxsgPq6XbFMMmg4S3yNBZs50=;
 b=QurJsXBBKzQRXJmZqBRKQsxFbuk3tHzb6anh3jZjEucX3ZbXRQW9KT6xr83kgCXD3ys+WsLjEhnWn0mNRa5X2QodoAvsAPtkGSOoaDsw0SPwiaD7ZzoIv2Scv9vV1aGVdZsTPQIMpAvg/jdhE755ImK13fZi566aPbMBU7u5QZo=
Received: from DS7PR10MB5328.namprd10.prod.outlook.com (2603:10b6:5:3a6::12)
 by IA1PR10MB6806.namprd10.prod.outlook.com (2603:10b6:208:42a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.20; Tue, 26 Aug
 2025 15:21:02 +0000
Received: from DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c]) by DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c%5]) with mapi id 15.20.9052.017; Tue, 26 Aug 2025
 15:21:02 +0000
Message-ID: <81a8ba60-d07b-42f1-a3cd-25a11c9f1f45@oracle.com>
Date: Tue, 26 Aug 2025 20:50:53 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [v4, net-next 5/9] bng_en: Allocate packet buffers
To: Bhargava Marreddy <bhargava.marreddy@broadcom.com>, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        andrew+netdev@lunn.ch, horms@kernel.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        michael.chan@broadcom.com, pavan.chebbi@broadcom.com,
        vsrama-krishna.nemani@broadcom.com,
        Vikas Gupta <vikas.gupta@broadcom.com>,
        Rajashekar Hudumula <rajashekar.hudumula@broadcom.com>
References: <20250826164412.220565-1-bhargava.marreddy@broadcom.com>
 <20250826164412.220565-6-bhargava.marreddy@broadcom.com>
Content-Language: en-US
From: ALOK TIWARI <alok.a.tiwari@oracle.com>
In-Reply-To: <20250826164412.220565-6-bhargava.marreddy@broadcom.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0359.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f4::19) To DS7PR10MB5328.namprd10.prod.outlook.com
 (2603:10b6:5:3a6::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5328:EE_|IA1PR10MB6806:EE_
X-MS-Office365-Filtering-Correlation-Id: 69c6d542-d52c-480f-dd7f-08dde4b42ad9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Qkpwa0ZFcWR6eEtNM0dQN0ZzdGFlTkF0YXZDWTVCN0FHNC9CNlZmMWdPMUE2?=
 =?utf-8?B?UFQ0YkZYYjlMdmppTGQwR2lFRnZITVo3bm9aeUlCODJ1QXQwYkN6ZU44dVVC?=
 =?utf-8?B?NUxNUmkwajl2U0tnUmFjbmlBU2s0MUUzeWFVVWdDcWpvc3hwZDlSakFtaTRo?=
 =?utf-8?B?WWp2aVViOENWZThid2h0YUJZM0xsV3BDNEJJYURDQXRrUWtqekZVZzRaV2xh?=
 =?utf-8?B?Nlc0Nmx4cDFNenBENC9nRHFqZmFQdTlab0MvRVZ4UmNXY2ZhRWRlTm52SG0r?=
 =?utf-8?B?d2pHakNFbXF3U3Z2NjFPYllYRTdxU2xubHY3TUFoajdsSTllc041djRvOWNj?=
 =?utf-8?B?YmIyakxMTHlsNnRjQkpDTS9XVzJTWnNpL2FmSEtXcnVZT2tqNnFZYVJXb2Nn?=
 =?utf-8?B?Uk9BMXUzUGZGVHJ4SVphZGdHd1dJY2xuZWpjcFU4QTRpQmpYaXEvcSsyaFB2?=
 =?utf-8?B?WDVoK2lTNWNGbU5UZElBOUlxeTZpcmg2WDdZN0RaVEowR3k0K3BjNjRVdnJE?=
 =?utf-8?B?dlZUMVpYWEQ1bHk4ZmpSZUJCd0dWWUxNT1ZMRGZ1RjJWZ1IvL01haUVpK0tW?=
 =?utf-8?B?MFJOZWt3Ukh1TGYvc2RzZWQ2Tml2T2NzNVloamFLN1R4bzJVVGlnbnZickhG?=
 =?utf-8?B?cWxzbjU3aHZuZ0cxUUkzcWFLMEszbzVuS1RabXhiS2VBblp2ajREYUxIdHN2?=
 =?utf-8?B?YXdkZlZyVGMrOFZDQ0RoOWt3S3lqbDg1WUYwem55RW5EcCs1OWttRTZyT3ZU?=
 =?utf-8?B?SkZoQWM2N1hjMDQvWUtwd1lXazBxRFkwUDNrRE5VeEZvUXZEZ1VQeFV5anVK?=
 =?utf-8?B?SUxRcXQ5SUV1UmNzS1poa0YvakpjTm5Ram5mZnJKZFNZK3YwNTFQWDJhODdQ?=
 =?utf-8?B?T2wxTGxncitDS3Zram5GcVlicmJjV0UyQ1AzejdxcHQxZmRYOXZoYmVnaWlX?=
 =?utf-8?B?QW1jUVhkNkNlcGVpVzZ6L3c2aWxGV3A3QVd1ODg1R3YrMVE4T0YzYUhqV1lU?=
 =?utf-8?B?Y1BjdXpOamVLcW13cVF5MURTdHgvdlY4cmFmbVl6dkl5Unp1cmViZXZVWU5T?=
 =?utf-8?B?V1g3NzhndzN5VEZDVUVTQ0ZTbFdlaG03QU1JbFl3SG9mY0Erd0xJcktyS05D?=
 =?utf-8?B?NTRJbHBJYzA5UGJTUUZQWDBocWJMN0g3UGFJOUtRWDd3bXR1NTMzeUpDWWJE?=
 =?utf-8?B?dXpmdExaSTg3YWtmUnJPam9kVUkrcmhpZC9Yc3d0WHFtNW00RjRiSTJldTR5?=
 =?utf-8?B?QkNQMldBemhmRERUUlBmK0RNMUxoUTQxaUVkL3B0TktTb1liM2xQZldmeVhD?=
 =?utf-8?B?MUEwOE02Q0lRQjZyK0tmNTRUOGwvODlneFc3bU9mcko4bjBVUmxLRUlHaWdG?=
 =?utf-8?B?cFdXWG5HZXNCZjNxM2hwd1VaamM1Wjl1R2ZyYW5TTWVJYUNUZkdMTENVc2g4?=
 =?utf-8?B?cEtUOUQwMjhWdmRPU0NPVGR2c1c1Q0lvclptb0poZFIzTUJUcCt0UVp0RFFV?=
 =?utf-8?B?SlM5QXBVVXRwRjI4Ulg2Q1czRGJ0ckVUMDNrU0F1T1d4d1pNUit5TnJNeEZT?=
 =?utf-8?B?NDByMjhuSzhSNnZZaGNIdmwvb05iaW5FcEJHOCt6STJoRktrYmdxaUZJNzBt?=
 =?utf-8?B?SHpGZk1veFQyMElSNTQwT2FGT08wcms0OHlaclJYaDFTT0JUMWF2SXc3dis3?=
 =?utf-8?B?OFB5VitDSWw1dzdnSWN6ZWxsR2pSb2U0M0ZiSmFMenRNem0wQWVaL1Q5Q1pC?=
 =?utf-8?B?MUo1RitOWUczdk50VWgvVDZLRVNVbWx5MG1yVWw5OUJJaytoSkV1ZFhibkxH?=
 =?utf-8?B?d0xCTkVCOGpZUkJBdDdTSnlQM2lyaE14Y2NFMzlHNDgzOU14Q010RXI5WDZr?=
 =?utf-8?B?Z25yRlpsVGdqRjhtVkdMVTNMUXYrd2dvYnRvSEErWmVCNGxCTkpVa3Z4c3Vu?=
 =?utf-8?Q?HeYweelIyyg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5328.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SUovakN5SjM4TmNkZllNem5BSWlWV0M2YmZIZjExVHYwQzY4czYyOVkvc0Yz?=
 =?utf-8?B?VW1HbjBob0VuZHRhL1huRXNnVm5CZXdndGZTZVRFcEpuN0YvUHNDYkZma0E0?=
 =?utf-8?B?VkI0WUxVL0FrSkowc1R1SlArb0ljbEJzdVloVFJlSXJUSGJ4aXZqN2EzME5W?=
 =?utf-8?B?d1pUZWNFZTIxb2NFSm9qZlI1UmpYR0ZWQUNBSGpIeUhrWnpZczcza3U4d0Rt?=
 =?utf-8?B?QlBHSXRJWm12ZGJxb2FHWEJoRlVDTnoza0d4N3lwVnljUnhhZEhMMWRyVEJw?=
 =?utf-8?B?dHQydTZ3MzM3UzJ4ZldTYXR0Vkd6UDR0ZkJjUnROcDVIaDZlMlZqY21XcDcr?=
 =?utf-8?B?MDJ2UTQralpudEtxOHI3SjU3MlVoOTlUUUdGUVpHS1pIcURvSEtJQkVjdzBk?=
 =?utf-8?B?a2xaNW1hcVA4MU9NMjRUQXUyd3Yyd2FaVEdsRENvYllsMExWUmltN0orZFdG?=
 =?utf-8?B?czgvdzN0OWtxTzFkSmtOYmwvRE0rMzJDYXpad3lUMTlVdUVQUmNqbVVFUVg3?=
 =?utf-8?B?ME91THpHTDlJa2V0RGZ4RkJzdTlMa2dtOUFMV0k5ejJDWHN3aXMyT0VLbU1l?=
 =?utf-8?B?S29ER0pZdTA4ZjFqMFl3Z2FrcUFFZEkxOFdJa0x3eXFNTWNhamtoOElidFRy?=
 =?utf-8?B?U1pMK1NZN05WTzZVVitPd1k2a0dKL2xKcXRNLzJUcmtaVmI0eC8waXAwS0lW?=
 =?utf-8?B?NmhabFZqRVRiRGpuRXJXa29xUVhrNjNhT0pLSm5uWkIyQ2pWNEp6RGNhSWdC?=
 =?utf-8?B?NVk4SnAzbllqdmJ5aEkyY3lNaCswMHFHWThUNDkrSE9RVU5LRWt6UTRqZnps?=
 =?utf-8?B?UDJXQ002WDhaQUNCSTh0ZUt2enhjdXZvbTJwclRHNVBmQTFUZVZUWWluUTBC?=
 =?utf-8?B?ZDc2UmRoQ3FKNnJaamp4dTdEdGdoZzRxMndGRGpGUXJoMDJaVytpMHRMVEdB?=
 =?utf-8?B?dVNWejQrQTJDWGY2R0ZEUzd3ZUZPSWtTRkpucy9wMEdsOFBrRWUrM0hrcS9R?=
 =?utf-8?B?bG9nRzBETzVETjBWUnNXdzkrU3RIMG5pVUVNbGJ5ZVdjVFVhaHlra3lndWpU?=
 =?utf-8?B?YXRWV3BlQUJlUlRUZmFob3VrQmZieTBJdTNoejR0ZE5kL25SWVZSdjNxQ2U3?=
 =?utf-8?B?cDE5YmdHSExnMGZPNmFta0ovWUVKUlVYdUxMVzRnZ3VnaGt4Z1JpeFRwZmpD?=
 =?utf-8?B?YWwrYkNWVWgxblVYZzhIaUdZbkJGbXRtTzVGcjZjTTJ1cEZ6Q3duMlJrZmNm?=
 =?utf-8?B?ZllOOE1HdWVwa3Iyc0xncjV3MUlZQlpDbWE1Vlk3QmRWaU8xSTg0eEJrRVE1?=
 =?utf-8?B?NWNPblN3Q29NS1BvaWQ4c1VkWVhSQTRaV29SbFRWaWxPT2RabmxranNlQ09U?=
 =?utf-8?B?cGw1eHZzWkJSVWYrMjFwbjRPSCtFVDNhdktxUFR5YTZsMFhrU2lLMFZXUUN3?=
 =?utf-8?B?WWUzMUlCTUU1YXMvcWF2Y2N6c0FMdnZQWGpUV01uaXJnKzU3Z0ZadXpXMmhv?=
 =?utf-8?B?UytQOWlQR0t1cXBqdUlKM0VBamoxVzVoNWtFY2NjVVR0YjJTZDFGMHpJSG1u?=
 =?utf-8?B?Q1VuRU5JdVllT2dyejR5cUcvbklCNzlsYmhHWTF5SzI4ZEZlSzdLcEhxOXA4?=
 =?utf-8?B?cUhMZ2tGTThlQWg5MjZ0S3Z3WjZ0bjhJVDJjVURNY1UyL2NQeCtRb0U1WFJ6?=
 =?utf-8?B?ckhNcTNzZlUxY3NiQnJlaUlsSkRYVTE4NnVFSndtOUpYdnFWNDZTL1NRUVBw?=
 =?utf-8?B?Yi9MWFZMN0dBc0IwNG1ueTY0YWZWZHpqd1E0VTE4UTA0VGJZbGZsV0tGSlNG?=
 =?utf-8?B?L3N5TkpqSTU4Y3ZFaGxoOWlSbFA1ZThrczZkUERiWjR0Mm1NbnRQb3hpRmh6?=
 =?utf-8?B?WmxwaXFPZkhQY2JpdVdWYkl3K3RWdExuU0h4WDBwa0t4TWIrdnlNblQ0a01F?=
 =?utf-8?B?ejAyN0JFeTRtaGFNQjkvaE5xTmZTcDJ6RUN1VEdBbmZvaTNEa1FLYjlzRHpQ?=
 =?utf-8?B?NTl4S003SG5FNUJmZWNJMGJ1TExCT2NldXQ2VDVWdVNxWHp2SUNkaHErTjgw?=
 =?utf-8?B?KzExMVBSMDR5YklQTnZXWGlRLzA4UEd2Y21UU3BqM2pYNEViemNDdGo3L3dn?=
 =?utf-8?B?RGIrdWpsYk9jS0xVUG9NQTE4NW1qN1BMemFMUVNWSmh2L1VZOVBkMEhZcFE3?=
 =?utf-8?B?SVE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	01H6ajwUh9lThOiBPIKOdCzFYsxR5HwNKW07Wzp8ou0JGMGMay0Up85zgPRRxobEjHUekZQKaD9X2aoo+grq/GJW/6UgabY6R8kUGFAs+/lkz5mvQdrbby/nVGnnoPFWd/9dYSNl5lX+ZF7mBfHPj3EZRXQo1OvzVSORvjwpvTzcL/m/ua1xCVCBtFba3O3GC4X1EQyVfbS4cBUqd++wEDVH4LtSW+7Lfy0xwPAaWqCi0OHBwl8p6y9+FuzPhM05B893fbq2e2kx8lel3ibtkfcGBe5+cs3Yh2b8RazKFUjQN/Gl1o/zvZHTYo7MGSSMH0HFgZkDFtfb2ZvwSNHlMQ9fBNgemw+099dtttWxgi2Q9HwyJojD4cDY2PNgQibgG+RlRuRVQV39s8uXcjYXx8OoWafAbfhAWCDeQ+57l7GKKubVl7PV2TR/dXMus3wIN/Y3y2lvmF/mBOEYA7ZDqUcS2fr091v8rJIWw5uOOJkUFGlgBNq1ph2L3vFpaxGtgQoOfaDXWzoU09aZBkZ41X7yhbhELAspJ9c1806/6CEl1Ak+a/m4uhjqZ/iNge1BQMNW642Y454ak2oy335KWlZZbrvC2ck3q305z1cZ6co=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69c6d542-d52c-480f-dd7f-08dde4b42ad9
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5328.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2025 15:21:02.3085
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Xc4bbo6y5pMXmpA1i7C9RSNsoL2SsOnYROPIs5qfdrdy39tpo07Vcg65AXwh/0Mu2bfrD7b8IQZvUWHe7GCQpFhqtYyl5lmqQsEyKXhga4I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6806
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-26_02,2025-08-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0 spamscore=0
 phishscore=0 bulkscore=0 mlxscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2508260135
X-Proofpoint-ORIG-GUID: f4dYbQTg9CPlgcrW0Muf2EiJvQeNAtsK
X-Proofpoint-GUID: f4dYbQTg9CPlgcrW0Muf2EiJvQeNAtsK
X-Authority-Analysis: v=2.4 cv=EcXIQOmC c=1 sm=1 tr=0 ts=68add0e1 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=LNW5RvK7P8_Ne4qntpQA:9
 a=QEXdDO2ut3YA:10 cc=ntf awl=host:12068
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAzMCBTYWx0ZWRfX6qXibkGBRkQE
 2yGQhJOUiWg+zvs93TRgfasDsV+7lfaAZmT7PyBq4OcW6CGOw8mQ8kJcHEAXE8TbLpyzxs4ThCB
 X3id9dfmAw+e5nEeGKeyAzqqgVMZyjWlIsyAoeG+dbknqbS1vDuw5LEZauhIvdXvXudj8vLdXvn
 CM0GV6b+uGkwOJe94U7HX5D9DWzOYDgRJF5JLLzJJVD0qa+e68/yA1PZtXTHYhuhJQ8HTFdXvV7
 qjxlr/7w4mP4sNeUHpV9VfrsxeOrnVE3R9gbcs1UIjRtgbVhljldY1AGqAJvP37Yegqfe/DOvBa
 JHFnVeyFHNeQFzZlU4os/i45DaMm3CC5MnheiiUEIYKvExf1kyLFiCf7hLAY/FK4utcrAnKXVdA
 7PUyYJwSWBNjozJbySItMaj57FLZYA==



On 8/26/2025 10:14 PM, Bhargava Marreddy wrote:
> +static void bnge_alloc_one_rx_ring_netmem(struct bnge_net *bn,
> +					  struct bnge_rx_ring_info *rxr,
> +					  int ring_nr)
> +{
> +	u32 prod;
> +	int i;
> +
> +	prod = rxr->rx_agg_prod;
> +	for (i = 0; i < bn->rx_agg_ring_size; i++) {
> +		if (bnge_alloc_rx_netmem(bn, rxr, prod, GFP_KERNEL)) {
> +			netdev_warn(bn->netdev, "init'ed rx ring %d with %d/%d pages only\n",
> +				    ring_nr, i, bn->rx_ring_size);

Looks good, but would bn->rx_agg_ring_size be more accurate here instead 
of bn->rx_ring_size? since this loop is allocating the AGG ring.

> +			break;
> +		}
> +		prod = NEXT_RX_AGG(prod);
> +	}
> +	rxr->rx_agg_prod = prod;
> +}


Thanks,
Alok

