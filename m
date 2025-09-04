Return-Path: <netdev+bounces-219973-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A0FCAB43F81
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 16:47:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 643281890140
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 14:44:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BAAE308F02;
	Thu,  4 Sep 2025 14:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Ewn2cx1t";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="vFhySr9J"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C7E01DBB2E
	for <netdev@vger.kernel.org>; Thu,  4 Sep 2025 14:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756996917; cv=fail; b=tI4DOUWwWwSJDUFAA8pobosOWW1clHLI6aptnoypwqJ8FUKPnbQEpNv5jFibhUK73pNOUsiIPrcTyY9NlCYKdjK6K0a3CGyy2XIp8iRuJS7YOnS0/DyYMWtDOsMZnUoPIqdmrsaSFWvNfyV+qTRbFoFN6cF2TNBY+5/pT2q/DkE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756996917; c=relaxed/simple;
	bh=qC0iwIowGAdRSFnvYJG7U+ptnW9wigYT37sIZD6x38g=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=edug/4oHO4XItNjcoK2YgMGsmPSM7vufDCQxR42UcHE5zSSh1pWSs3WKuYGhpdTpqvXFQalMWAGCESDNfea3F/4w8qeVlb3Y/rQ0Kw7aNtcjney/P3GRXEzf7qxt902aHPVZVBoXpye16T6owCb6Yog8pChqKWyAxqTpw8K0ZV4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Ewn2cx1t; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=vFhySr9J; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 584DoTAU008546;
	Thu, 4 Sep 2025 14:41:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=OZlvT1H7Jn8zjuEleIGUNEDqFC/UYg5pn61kk0wzfOU=; b=
	Ewn2cx1tEKQymeyCkbpyJJB2mX4rmjhJ+Mk3/KfImNLsveNWihvnOS+539lU4V0O
	7xrkgoYfeuFKcObd6kdrVJBNJI6+cyx2rXfi37++KYkjnnwrPkV9uItSiYOmXEID
	NLv3IRdGvedADPDDXefSxsEmWZPL2QPtuwcBCkZXlIAND0+44eh/mNMZ3s+lYBPY
	aAbbCrM/kNVpPtMVMXeh+gvBQJP5m8QB9FU1YyzDLfDs029QmHeJ+IS2kVXPA41Y
	5dD5GtnWxDRcWOgmKVkP8TaSQu85rg0HUMCrpkVafm+iZ5WQFzAzBM2kGQaQ2O7s
	/Ms9PeAkwDTyMQ5/SQ3DeQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48yc0dg3x8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 04 Sep 2025 14:41:46 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 584DbMZA032550;
	Thu, 4 Sep 2025 14:41:45 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11on2049.outbound.protection.outlook.com [40.107.236.49])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 48uqrj052v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 04 Sep 2025 14:41:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ysafiKKpHbhwG11nKnw7HPLcTvQnqXD/mxRsfQpXLZk4m6bkn7pDx1jURDSfIVnBfU/qIr8QTO0W0rt8mTeoXAb8H119FOMrLlmg5yM6hhowHQ706gvHI1Nejb2TVOfUgz4fmcl3MXKWWF6NVXak4Qecb7c0VzRNEZxwkxNMXv2s78Js13ztQYn3ArteI0oUJJBQZMBwg0nuIQJeWAEMkKaWTxQUzKIQ/pzS5e40KEuE4L8I/8mtGjvG7VIQJh6KWsLJk3HtDyt4/9wfXUozvLGwFzeRPfiIkDPAbhNo302FmqPGt8xSlSj11mnURYFLxgwyQTIrSc+0iognRHYX8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OZlvT1H7Jn8zjuEleIGUNEDqFC/UYg5pn61kk0wzfOU=;
 b=AbgoNJJ7r/iey5x6G3u/FCldCGo/SeGkS4vgYOY1xZVXSuksIlQzDq5XwsHLvDQVTrRwiEikltK5nntkoT4AqG4eKcW3JKm0AnhDPmORcpZm02BxtfiGj3QbO9myaThlfZxb3tO2yNZ+/CXmsdGiP7RtKF6egx96kWfL5OgWQL/vTWqmeSJpgElBxzGlJWENctnTy6DTS/gb/UzexcnSLX4s1PK0fBjgYNwnVxnstFdluomSkWw55fnYQ+iNh3x3cQdWKCq/QS2AaWEkH/JHFeIcBQFBv+ZngOndM6y9IT3+CSZMQVPU3vTOTL3hfwDb/w4wfqwmc8+Yr0GId++LWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OZlvT1H7Jn8zjuEleIGUNEDqFC/UYg5pn61kk0wzfOU=;
 b=vFhySr9JnQj1L8TLzeTRf6Z5f3KYAVs3iPTCIib5Z3ToFoycJmULb0WP8ZAlwQah9DAWyW9MujKILu84W76O7bqctbwa1oB+vj/Jp873Jtd9QyfMw2++juvjTSzg4zujU4mpEyAshYvy3pcVL91ohakAruES5Gju+eII7aMQx2Y=
Received: from DS7PR10MB5328.namprd10.prod.outlook.com (2603:10b6:5:3a6::12)
 by IA0PR10MB6889.namprd10.prod.outlook.com (2603:10b6:208:433::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Thu, 4 Sep
 2025 14:41:43 +0000
Received: from DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c]) by DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c%5]) with mapi id 15.20.9073.026; Thu, 4 Sep 2025
 14:41:43 +0000
Message-ID: <f45be394-9130-4452-afec-c441f6857708@oracle.com>
Date: Thu, 4 Sep 2025 20:11:36 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [External] : Re: [PATCH net-next] udp_tunnel: Fix typo using
 netdev_WARN instead of netdev_warn
To: Jakub Kicinski <kuba@kernel.org>
Cc: Simon Horman <horms@kernel.org>, dsahern@kernel.org, davem@davemloft.net,
        edumazet@google.com, pabeni@redhat.com, netdev@vger.kernel.org
References: <20250903195717.2614214-1-alok.a.tiwari@oracle.com>
 <20250904091832.GC372207@horms.kernel.org>
 <e022df33-8759-4fa5-a694-d0d16c51d575@oracle.com>
 <20250904072845.045a162b@kernel.org>
Content-Language: en-US
From: ALOK TIWARI <alok.a.tiwari@oracle.com>
In-Reply-To: <20250904072845.045a162b@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0687.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:37b::13) To DS7PR10MB5328.namprd10.prod.outlook.com
 (2603:10b6:5:3a6::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5328:EE_|IA0PR10MB6889:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b7afc54-5787-48f5-3b6c-08ddebc12a6a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Z3V5L2Mwa2EwbmNPcEJSRnZieXdybmczYzBqampRdEgzV0JTcUduR2UyTWFW?=
 =?utf-8?B?ZEM1dGJZZ2xDSVJ6TUpCQkVKUmRWTFYxUW15VXVTSTl5WlMrK1RoWUdJTWE1?=
 =?utf-8?B?TDE3ZnFFb1lpNGRhYkRpT3VPQmx3ZldtTHBmNUthM2t3Q21QWGxzcEFKUDEy?=
 =?utf-8?B?OHZVUlI0MlNVbk0yZHlabFFJNGsrREF6Ym0zNzl6YTNRZmJ5RnVxRUVxUnYw?=
 =?utf-8?B?Y3M2L09QRUdmMnZHdHFCVEh0a2grUHJscTNKREVqa3B6eVFLd2FUUmx2T28y?=
 =?utf-8?B?YmRCRXQ5MytiNzVSMjEwMEZvL1d2eVNURFNtRXd5NHA3M1grS3YyQVlKRlFV?=
 =?utf-8?B?eUErc2dZTlZ1K2d0SnpGQmZjbG1ObXhkSDZYVWkxTm16TlZVaW4xcmVad1NM?=
 =?utf-8?B?WUp2VkxkMFpzck1vc0RnTGRPNThtSWZGMks4clpndGFTK1dScWhJRGVHNjRz?=
 =?utf-8?B?b2NvU2M5Z3hXa2pVSWQ2TEVuUEhRQXRzcUVrNER0VmtlV2xWeitTYWJPTC9Z?=
 =?utf-8?B?OFB2dXJRNXJNUXFNZW9ZK3JEalRvblhMSklIKzkzd0xUdnc5bDB5d0tjbkxi?=
 =?utf-8?B?a3h0ekhWc2FPL1c2aEt5cmxKanoxTjhRU3dadGR2MVBsV2tSTTEvS2t5NFN1?=
 =?utf-8?B?RU1mNUJxYWZzYlovb0lHb2gycmhLMGc3anZmZjdabVFwUlQrQ0dKN2xyM3hm?=
 =?utf-8?B?ZjNzb3crTkg2QlJDZ0x4QVRXN2FxQUJ6M3FDVTBuOGx1d1QzKzJFN1dhSVJZ?=
 =?utf-8?B?YTc2aVlIY3YxdGFoeU8yQTRCeTBtV3FkTkFQNDEwVGxDSlBjSktXV0ZHcFlW?=
 =?utf-8?B?cGhmdDdaRGZCUFRveVRsd293NnpGQXk1aDUxWjZpcXhibVMzMUZKZ0tueG1U?=
 =?utf-8?B?YnBBQVkzcnA3YU0vZmlucStoSUs4REl4QlV3TmwwUVRma04rWjVhSW82ekhk?=
 =?utf-8?B?VHJCNldKNkNSRHdzbXdsc1J1YUpBeWZpcmtMMWdwL2xNTklkTG92eEZqLzkv?=
 =?utf-8?B?Nm5rSk5aM28wL0Z6bHNFbUNKU0VMcHNzLzBaa0FyMkdpMVFTbGRNZkMwbEM0?=
 =?utf-8?B?V0tQb0FsWUFQRjkyTEVFUDI5QlhYcWsxdDBNL1dyWnNMQ0VjbjEzWkRDd0la?=
 =?utf-8?B?NU1nVFRhdjdEcnBydFhCSXV3SUZkU2JrTVlXTnMwMjVRNmZUV0d3VVk4OS9T?=
 =?utf-8?B?Tm1paGlUTFNjcUlxd2I0QjhzNTdQRFhkL2QzY1Nmdk4valF4aG9mMjFhSkVQ?=
 =?utf-8?B?OXNETjFKc2lTQnJlZVh3OVNlMUtkUUR0MXQ4QkFEMUR5QmpKTkVzVVBWUVJO?=
 =?utf-8?B?MFRPUXF5TTNlWWJnaHJDWHhSNW04My8rMFdEV2Myekp1QjZyL1dvYU9YMlJo?=
 =?utf-8?B?eisrZ2lYV0hNeVVpbUVFcjZyYUtueUtXU0tpazJ0VWY3dHhwNy9hNDBqZDJt?=
 =?utf-8?B?R0tsUnk5elEyVmNuNUd0NGdhMHpPRmRLLytzSEQwRkdWMkM0TWFNK09QaEh3?=
 =?utf-8?B?ZW9BU1BxQ29CVE1wY3RuOVRKaGFvREtUU0VqMG9RQVljS0I3UTZkbEE2NnY5?=
 =?utf-8?B?RGRkUmRKMXBNUmIxazIvQkZXbEhPNjFDUHIxNVRyK0RianB4RXZVZUV2M2s3?=
 =?utf-8?B?bVFTam5ha2EwTHg1Unc0bnBLZ3U1SGo0OGQ4WnBvVTVyWlk0a1NNUzVCOGJr?=
 =?utf-8?B?a3JpMFNSUDZlSlNQZkt6c2tVK1Y2cUVvRmt0bllRZUZHY0VXQWxxb2JGTWRo?=
 =?utf-8?B?UVd4RkZpUENORGRlaS9wOVBwS0UrTEFzVjFFQVdWem5pdGZlMDN6TmYvVHg1?=
 =?utf-8?Q?7eOwxV8JNG0EXvTqFqe2FToL2+Pcps0odxIWg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5328.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?d0FSNE1tdUowUlJKS1NiVVhmdUFXbUNrUk8wZVpvbHYwNktqOWJPNWc2N1lM?=
 =?utf-8?B?V1NqZk1sd2ZxYVNSTnovRjZJdHUvNWpEdUVveXd1Q25QMDNNZHZ0U0JmRTJj?=
 =?utf-8?B?cm9FUC9VYkZRU0h5QzBPOVJLRlo0VHRjYlNoNDNyQ0VIZVp2a25welpFbTM5?=
 =?utf-8?B?czhUaENqaEJXS1FoOHFYVlEyS3pqclNxY0lENmtBVjZ5VXp3ZTFlSllJY014?=
 =?utf-8?B?U1B3RlhrcTlkcVVFUWRaak1RUUNROVlXUEdBNkYzUEFIUlJMenVuVnU3dG1I?=
 =?utf-8?B?cHFDV1FBbVNseWtnWm1TZFJxYk1NOUxrei85a1BoZ01tc05lM3VoTVJRVmhz?=
 =?utf-8?B?Uk5kVlpOcVFiVmJIai8vOGwwUHQ2eHdkVVZSM1poWHNwTGptM0R3RWFvL3VM?=
 =?utf-8?B?MGNLMGtWa0lxUEdmbGVxQktublhwMHJuRkxQa0V5MU8yclFtbGhvVEM1Z2R4?=
 =?utf-8?B?aTltMzE5Z2wzQ3FBTzc3R2Ntc1Vxa0g2L2VGd2dkUzIwcVV5OEkxNG1KbXVM?=
 =?utf-8?B?c3ZlWC9uczg2UkRJcEpIV2NuckhSRHlPVzZTQ205am9YMkdKeVpKWUI0am41?=
 =?utf-8?B?eS9hT053dmhzVDUwQnFQeDhTVDVOWlhiU1RCcVlmS1dBUGowNms4STlUYW1z?=
 =?utf-8?B?NmJvbkRLZ05sVVdnR0xnSGg5UE8zOEc2ZWtidWl2bjNkNW5tbTVpcVVzQmZU?=
 =?utf-8?B?eWYvZ3htazFyUlAyK1k4M3pGbWg5WVZ2TWorcmdMU0NpUnpBUVlBQTdhM2No?=
 =?utf-8?B?NDVvaTNiMEhzcG9PRExobjhkbzNoYmNMekJPL3lZc1JjN09mVXdzZUFvOFBY?=
 =?utf-8?B?QXoxdzFZQ2NrYVdTT3c4Uno1RHpWYmlsNzRSV2R6TFphTVNVREV0dDBXaUp6?=
 =?utf-8?B?dC92VWRkVGJ6R2d6R3ArOGxobElDOTJvRE9nMS8wejhnZFI1UUJEM0k3UzVt?=
 =?utf-8?B?b0Yvdkc2ZEFPakgzbVdnUUR2MmhPbVpiczlDZ2JnaHArVXBBZWVTdWNXSlhH?=
 =?utf-8?B?bk5HaFBwUjhycy84Z3NZTE9ocHBuSktpazNNS0d4bUVxYjY0a2NYL2dieVox?=
 =?utf-8?B?enpoa0cvK3QvaUo4bWdZaDVsNEtKeDVlckRhTWZvaWZzN0NnbE5ld1hkTjUz?=
 =?utf-8?B?TDBwUVg0QUFSTXVxRHgzYXFRN2ppYk9sb052SlI3Ujlvc0ZlSTdhU2x3R1pS?=
 =?utf-8?B?ZnpReEt6ODdJZEtnYkVhUElLTHVuTHlnYUk1dmYrOHRrdzJMMXRyTTlHQm41?=
 =?utf-8?B?S01Rdis2bHdoOGU1VXloQ2tiVUFlQzFnSVFjZjFxemRqM1drKzFqazlzcVRq?=
 =?utf-8?B?NGxsMUNyL2VxQW5Lb0ZoUUtuR3orOVVpU1g4WWFXRnVEZTJYQlZnU29iNnMr?=
 =?utf-8?B?WVl1TW1kSFZudUhvd1VWWkZnN2N2NG1sWmFLQm5CSGJQVlpzd2NlVUx6Y2d2?=
 =?utf-8?B?b01IejZpY3daaU5xZjA1RW1rVjZ0OGR0cFF5MnRRalF0MVdPeVFIV29jTXZk?=
 =?utf-8?B?K2g1MGlkZ0pEVzJaeDV3MGpYOUR2anhmZ2M4R2ViRTFRVGxRa0hDbFh5aitM?=
 =?utf-8?B?M1JzYnZYajBHUEhWTGFJWlhWaTltdnVZa2lQS09TN1IwdXRRWFNzd1BUTURm?=
 =?utf-8?B?VUtnZlBVY1NKaUM3bnNsRFpUalN5MjR2Y2tKa0VqL29hQkJpUnJ5ODFGQXha?=
 =?utf-8?B?RG9pbHVHdXBjeHduN2VidEY5MWtwTi9uRXlhdHhBVHlKS3FqY0w3cFFzaExU?=
 =?utf-8?B?UkpydjBJUjluR2JQK3BCcWt6Y1d6OUswdUo3ZnlQQ3Rkdm1WWC9wTlBJOEdL?=
 =?utf-8?B?Y2tsempwVWxBdDNRODArb0trdThHYkVFbndCdDlEU25uUG9kZnN4YnVRVzdh?=
 =?utf-8?B?bWs4ajRUNUtxRExkZ0REdk1xbkIySWJNcXB2WlIvblhMemVpRlNjREJ6UUQw?=
 =?utf-8?B?VE44NFB4NlVJT2IzcFdpbTRRYkFaMzR1UDN0MnhiOG9jVnE0bHphMVpFejhE?=
 =?utf-8?B?RjFrNktVR2hOd21DbjdodUlZRWVmYmYxUE5maFhZQ2toVzVxaGFoYXRrWXZi?=
 =?utf-8?B?Ri82WFV2Vkw0bTlaOVBRR1N0ZUVQY0lQd1ZGSXFZWUNaZGpGRDBWdVFkS2xK?=
 =?utf-8?B?aUFWYk5tSlRWdEI5c0ZzZTdZS0FOYmJZd3U5U1ZlMlJRTnNOd2xlbC94Z295?=
 =?utf-8?B?ZGc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	T5dKOK0B8xDnYG63GjuIpU3GBjbxRNQ5QRxnGLnRY1wUKaXGmuoX6Iyxwk8wylAwiva3GehaFLp2JONN+hAnxwLJfDjY+mqUqANA8KF2fKC9sTp+qJ2ApvAbbgDACd+y86w/Ijv2KVGfTU+JIADVeSak9Edj/L7t5xyKYra3m/6aAFJ090Ul7giehXng0XrNewaLDs3A91DAv8SmVRyFwdGHG6PjcbPgMf+yKP3czKk9U7HfHn6Oq2IbP7Q7lT9gnKkIJBPyifGr55/ehlmTVHIqFIIewEPpybUq8YcbV7Jii6dBaa2HctN1bSk+OLum//ycJgKkZwz+bzupgGTTa2ZwOLKGD4ghWpRDzQ/zhwbcNmpReLUzFQ1XwBcdzOPEM5aI5pmKSutxi7/Va0f2SRNYRn6AY4Xedq2CsaeSo7VbmSWWUPzIgtGSCH8jy+UVeqE0F6HqlEQMzZQe7czmQ/rZ96N+UC2QNkqAwjMrNoNjy9Ragqica+VG8AcdetzArgtBBlGtBokBfrRarKjGxev+PN2H7mG7ZRMXfae+jb4ISxguqaU0QgbxFjzuE720K5cmX6E4+W3X+7ozv1I9UhRIYK+6MsWd+kUvsQAboH8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b7afc54-5787-48f5-3b6c-08ddebc12a6a
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5328.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2025 14:41:43.1601
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z7WwBOveXcT8E1/0UaImzY3wM+MiK+bXZ55tCRRAjCDvGF5EuTchHkLQG5kuEqrLqoRXa6zT0zOlbFhvtGkjUwm9eGFauzLlbAjGuIpfJno=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB6889
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-04_05,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=841 adultscore=0
 suspectscore=0 malwarescore=0 spamscore=0 mlxscore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2508110000 definitions=main-2509040145
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA0MDEzNyBTYWx0ZWRfX0NfJz5xcy7P5
 E1yzPp8zfQPjnTi6JDlOZ/q6wdPEpsmADrru+6a+MuTojBP5kAHTWoh3MXHrkhtMiOosYWAO26W
 jtneWLF+jKygIcEMRy18CBLjjuuZe+9aq6+zIFIojIqRO6VD5fdsS6F4rXXnWWT8vl5i7B94N7H
 KrP+6XWGaKQGPSLoswH7mYd1H0OKS/xA+voOg/fT/InbRf52etpQjFgSEei06U4Fqok8MFlSgCe
 +2Ec6HJfNGN6OdWVdqtECL6jFxDrbNEEVTbMyREEn4P9nEvsy97pDnOcAnvK1Wjyv0Gk3MGKfut
 YDgS5S8CtwtUd0FtGra0W+CxYuy/two/BAztuzxk/m5d8odS2zmrSwhBoLRzxjpQNJmwWkv2VzT
 oUzG3S5uhiQ1RSgN4WFRz7R9bzIbdA==
X-Authority-Analysis: v=2.4 cv=Ws0rMcfv c=1 sm=1 tr=0 ts=68b9a52a b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=VaV5sgc-NJZzhsR5nyYA:9
 a=QEXdDO2ut3YA:10 cc=ntf awl=host:12069
X-Proofpoint-GUID: 3UKcyQZeS9O0zW13I4NSuQVh_5kSMwJy
X-Proofpoint-ORIG-GUID: 3UKcyQZeS9O0zW13I4NSuQVh_5kSMwJy



On 9/4/2025 7:58 PM, Jakub Kicinski wrote:
> On Thu, 4 Sep 2025 19:15:57 +0530 ALOK TIWARI wrote:
>> since WARN() triggers backtrace and dumps the file name
>> it is not require here. The failure in udp_tunnel_nic_register()
>> should just be treated as an expected operation failure, not as a kernel bug
> 
> You keep saying that without really explaining why.
> I can make a guess, but the motivation should really be part of
> the commit msg.


Thanks Jakub.

Thanks for pointing that out.

I was referring to the comment in include/linux/netdevice.h
which notes that netdev_WARN() uses WARN/WARN_ON to print
a backtrace along with file/line information.

In this case, udp_tunnel_nic_register() returning an error is
just a failed operation, not a kernel bug. So a simple warning
message is appropriate, and netdev_warn() should be used
instead of netdev_WARN().
That is my understanding here.

https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/include/linux/netdevice.h#n5525

Thanks,
Alok

