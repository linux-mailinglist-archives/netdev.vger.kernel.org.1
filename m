Return-Path: <netdev+bounces-170103-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33C82A4746F
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 05:27:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE9113ABEEC
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 04:26:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18AD21EB5DD;
	Thu, 27 Feb 2025 04:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="bbQ+OWfE";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="V7YOnIPq"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 232E51E833A
	for <netdev@vger.kernel.org>; Thu, 27 Feb 2025 04:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740630410; cv=fail; b=DGcpG+2ZHBDGv7XdbJzhaAtpWdUlK4f9tkbAmLUrsrMwI6ISOqezT8FgX4N+t6ZyFlgfYSbaY/n8rrbcJ2czw/fzDsWNUw33VFvgqS/AN5OIhDgt96hYIiokMOan4TqT0w15MmxtJytkGeqCdMs+98VN8fh86Wj1sHl23HwnjtY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740630410; c=relaxed/simple;
	bh=1kAIcZFQaP83OKZqO670+TCpX+32YP7f+OrYwTGWjDI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SgI+inEq+uBMClI4mVw9FXB1D6pvXTYPVvySpi6YhrvODSt+nknN5q75psxlctDxM1C49ZTITD4VswvSfjhtV8LVm6b9ZifHLzuJDAfv9TUQGNkNrPlCw3n0kiVMGgi9hCM0a/EmBdnohnjXB4VIb8BCzk2LVE7IebjJGyDFocw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=bbQ+OWfE; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=V7YOnIPq; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51R1gAwA003113
	for <netdev@vger.kernel.org>; Thu, 27 Feb 2025 04:26:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=yBTkSA8Hze0Bbqotlo9kvgN2MtjoYlVtVshaQJrRcJg=; b=
	bbQ+OWfEDnnsihYnoca6ng9ubOl2ERuasTDb4B7BtRJ+wRhExnU/8a9agoYP+3/X
	p/UsJIzCE1JS4FtmdmZX5E4NhaAfCFn3TeHOfgMxN5Ohp7tZJCJ/023a0GgcuuR6
	K0mH06BLRmXVrRdeUn3PFp4gEgG2F42qxwD4JE6IfObTBS6N6EiWVpqBklkTfBkG
	9pJXRXB39OWd2rkGpeEj/QEzi2WXjOflTAI8CesttEAPqZ552Vv4qEwRbMHlfY1P
	oZ7grmcGNVkvLBzXmqNyl7Xz0bRdoX5/m5wDXbQZ+fOZi7mDbpTMpxo3fbg6P2Xq
	yQyIMAxf/kAzwP1aX7Gpcg==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 451pse2mmd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <netdev@vger.kernel.org>; Thu, 27 Feb 2025 04:26:46 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51R4DwQC012594
	for <netdev@vger.kernel.org>; Thu, 27 Feb 2025 04:26:45 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 44y51cuy22-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <netdev@vger.kernel.org>; Thu, 27 Feb 2025 04:26:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IKzdhjoBnbEd4hvYsdlYvA66ldubJgcdu/uu9UZ3kLO7Gfxgge2L3drp5yHE7Rm5WJSIeGdisG3Z/HOHP4tP9dWMbME145xaSIjINTN5pJ5STOa8GC5e3CVca52KvqaAVuf7Hy7imgeTIwo1jOn2ZI8j2qLB2KEGNmjP4Am7dwdM4zbnwkaMgePhNoMIdAOLR+M3EM43uekmPnBhI3w+zWPE6XcgR9pVXmeCBPYNfVPD2evtYQRkjdF/hPyXXSLHY9ZAWsawJ/vfroBh6ZYpUQLwSJ59ZrjQxTm1i6rrLysSSJPOiXjkzTSXzq5LdnDJ1R15H6EeC1CZwWy6B91NGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yBTkSA8Hze0Bbqotlo9kvgN2MtjoYlVtVshaQJrRcJg=;
 b=CppRyNMIf75oufLpRTjBh/9HwR0BheXturqFp/KEMgmHwFPXon9eKfCGMOLwBjvlmDxzwZJNdndi2mQo2gdQH1rA4lLr7BqSRjjJ0nO9oW7j41N/AET+coIOijHRj0DDBDx509Ux9+9Us2k/CiC1ozPxP11IlHJzZnzsBWdT/3plUGPRmgK6iQAvcW6dnA+tzPfZbF1BH6Bb0c7jR91vvf9yIlXMZwmArmzWBEbOF4H1+EZtxDZaYnGwVC+NCeN9feZlOb5NipKOjyi8vQL78rLOxLij88LZBV1JrgM8mwoPBRcm02vgL1g/X1ESMkhKp2sH+0k1cucbt4LwYoUczg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yBTkSA8Hze0Bbqotlo9kvgN2MtjoYlVtVshaQJrRcJg=;
 b=V7YOnIPqVXRwbpErVN+JdH+vWmLIXITDc6++lc4tq3oLosmKRLnIAS6SC82aJFOyegytH+tZjBS1W8UpaKS2fwJK9S09QATfCPR9iSWVwvM6yNaGH1MC048hJ0oRTLvDMm41hRcv6054aItLroO0uNmMQStYMGr6mK2hLSMoYvk=
Received: from BY5PR10MB4306.namprd10.prod.outlook.com (2603:10b6:a03:211::7)
 by SA1PR10MB7587.namprd10.prod.outlook.com (2603:10b6:806:376::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Thu, 27 Feb
 2025 04:26:43 +0000
Received: from BY5PR10MB4306.namprd10.prod.outlook.com
 ([fe80::b78:9645:2435:cf1b]) by BY5PR10MB4306.namprd10.prod.outlook.com
 ([fe80::b78:9645:2435:cf1b%7]) with mapi id 15.20.8489.019; Thu, 27 Feb 2025
 04:26:43 +0000
From: allison.henderson@oracle.com
To: netdev@vger.kernel.org
Subject: [PATCH 2/6] net/rds: Re-factor and avoid superfluous queuing of reconnect work
Date: Wed, 26 Feb 2025 21:26:34 -0700
Message-ID: <20250227042638.82553-3-allison.henderson@oracle.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250227042638.82553-1-allison.henderson@oracle.com>
References: <20250227042638.82553-1-allison.henderson@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PH7P220CA0130.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:327::14) To BY5PR10MB4306.namprd10.prod.outlook.com
 (2603:10b6:a03:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4306:EE_|SA1PR10MB7587:EE_
X-MS-Office365-Filtering-Correlation-Id: adb19c3e-c3df-4baf-328d-08dd56e6f065
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TFB0KzIrdFFkR0pCMmJNR2JNYmkzQ3hFQmw1K01UYm5ndEk3ODhpKzgyUHM3?=
 =?utf-8?B?T2Z1OG9PMG4xdGlPY1lVVTREMjJTZm5ZSkZLcUtmQTFTTGJCdDdiTEhEOXJT?=
 =?utf-8?B?UFk4cEtaMjNkdndlZ2VTMVozdGRBS2pXeFhicEFCUS9rTklDanJ0RU9OMlNE?=
 =?utf-8?B?L0VqNEkwMXRIM2ZFWjBvYmN2VDhSWkRlSjNQUHV3OWwwVEljSnp4ZUx0cVo1?=
 =?utf-8?B?YytOcjRoamxKUjVVa0xkeGRjTEFkMnlFZkcxbEZJWFNGTnJJK1VRWFoyMEZa?=
 =?utf-8?B?TmMxWTRjcnkyVGxpU1VCQ3VVQ05tWG9peGRsa0k2RG5pZFRBMnZFUmxOU3p5?=
 =?utf-8?B?dmNHTWsrTk8wYTVjeHloNm5HVHR4RC95WWIvNDlrUEFNMEdXWEJaWkh2V1g0?=
 =?utf-8?B?djFCME93d3VtMHAvaDhCMXkvaE8weWJTckU1MWFUM3ZKaTZncmZaL2Rpc2p1?=
 =?utf-8?B?M3RITWl5S090NGJSek1Uc2Fxd3poVzFTcWtVay90a0p5YTJKUzdYRWZnbEJr?=
 =?utf-8?B?RHBrKzB1S2xrSlZBQmt2MWNVZXlwSVBWdkVKMlQ2Q2ZLUU1UVUNmTm9NZkIr?=
 =?utf-8?B?bHlRWmN5MUtoMEJ3eGhEUU1yR2RTMnJpb09wRlpQL2FpcXBZNnFEdkE3TWtj?=
 =?utf-8?B?L0RTVFB3L1hrUmlTNU55VHo1THFHNm8xR1VqVDFFZU5aQ05KbmE4enZ3RGli?=
 =?utf-8?B?aFlISERHeFI5VXFkamk3Z0ZXUUJIaTRhb3hhdjBXQzFVbUg1dEpsRTM3VnF0?=
 =?utf-8?B?M21tRjhiQTFnSHE2Yk1ObGxKMDA2ZjkyQTNDYzVZS0RUQUt1dDhhR3B3MnRT?=
 =?utf-8?B?OEJyOG9hakxVeUJoSzZua1p5L0dIRTJqaHB0NkZKQ25NUXJCcHFMS0hRbTNF?=
 =?utf-8?B?SG5qZldReVU1YXh2OWN6TG9vODNHSm82M0RoY1cyWkkzL1J3YTlpTFN0QzJR?=
 =?utf-8?B?bXM0V1lzdXFidGwwUHNJYkYxQXM3UmxNNFBmZzVCNE03cy9vdWNubUI1Sit6?=
 =?utf-8?B?SFF0VGp0ZlBsZ3RHdWpoMEhYRnUxTUU1ajB2MW92WEp4UE9TRGpMQnFZRFEw?=
 =?utf-8?B?U3E0MlozZG1HQVNpYjRPWHRQZjRNQ1E3cVJjWlNXMm9GelQ0bS8xOEwyT29l?=
 =?utf-8?B?eVFqUVhoSHFZYjdFRDI3Sk1LWHdzSnVmbUZtdjNGaDRVOHN5eW1IRnBCUDNX?=
 =?utf-8?B?RGt6TVVlbzZsa0hET0hab1prejNLbTkzRk45aUZscmtUeXY3cWNBeEl4UW5l?=
 =?utf-8?B?OU8wL2M0Z0FWNkNYL2VlVmN1TWp0QTB1UzdWeEIzUkRERm5SaHpVeVdvaE9L?=
 =?utf-8?B?RW9VVmw1U29hUlhaVmtKcDdreWtEMWdKL0wyNHRybm9zNTQ1RTVSUVIzeXJn?=
 =?utf-8?B?RzVtVFJMeWNXek9DdWphMERtMGk3U29ucEtTZzRvUnd1T0c0T0dNZEkvRE1r?=
 =?utf-8?B?SUxWdWVMNjlia2xkOEtkNWNLc0Q0TzYva3JPYldZTENMclZJL0pLNHoyQUgy?=
 =?utf-8?B?SUxEZ3JqNkEvWktOc1ZMVFNwK09FYWdtbmxuNytyUDBQRHpJeDFYT25sRm0w?=
 =?utf-8?B?K081aFFnOVA4TG92U0R0U0tjTnJQM2ZDclZRLzIxcm9OTnJ3RmRiQkNiZnZB?=
 =?utf-8?B?RHV2VGhuNTdkODZnc0FaaGNLeFdmZ2MrOGUzWElhcTdIeVAxYkpCeGFkYnRp?=
 =?utf-8?B?MHZEaXlQZitIcDN1cmdod1Y0RWdlTlBBWmFQejBVckdUbWpTeUp3ejJDbjhV?=
 =?utf-8?B?VXc2clNwdFZwaDBSQ1NUbThsalN4RE9MVkpBWlVqVGpKTU42anlUZ21TRWdt?=
 =?utf-8?B?d3hUc3ZabnNLUXpUUGN0N3o5ZUwwUmtEQm1GcW9KNzVONzJmLy9hQ1FDb2NJ?=
 =?utf-8?Q?Tnc46dixocS75?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4306.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VXlRME5UR0NHRTJsL3NEblJjR3hPMW95YnV4THhoNHc5bEZNTUlmQ1pZV0lR?=
 =?utf-8?B?d1ovcGo4b044T2NJaUVsR2QrYm9BZytibm1EOUo5M3ZPanlQSjVIem1OenB5?=
 =?utf-8?B?RmRCS3hvaGRYeWZuTmViS0kzV3FoWHIwY04wRUNoSWNPWlIwb0VKZ0hiQ2ND?=
 =?utf-8?B?SENBbFZNSWUzVHI0b1ZjNnVadklyZlV1SWROc1U3RXYzUlIrR3FSNlJLRDIw?=
 =?utf-8?B?YVdHU1gyK25KY0oyV3BLckFodC9RSHNtR0Z6R1hFSFBlRnZMMjN6UGRtb1hH?=
 =?utf-8?B?Mk5ua0FMMmpNWHBQQjZray9xSWMrRFd2UTMyV2JoUHYraGxrbzE1NTA1QkFn?=
 =?utf-8?B?TVVzdWEvNFZnTFZtWHRTMTNmSlMxc3ltSTdodnhHV0djRkJNeDJPYytPR2lC?=
 =?utf-8?B?dkFIeG5aQVdhTmF3WlJSVU1MTVRselFibTZINndNWnFreUcwYitxQnFVN0c1?=
 =?utf-8?B?U1RQRXN2RUJ2YkFTTU0rSE5RVjlaMGZ3Z1BIWU5DYkh3b245SnJlVW9RL2Zy?=
 =?utf-8?B?OWxqWXdPNnhBS05yU2ozdWxWaUhscDJxU3RabDU5TDRxdUFrVVJWOXlkRCti?=
 =?utf-8?B?bldZcVVQL2F4SmtPT3VuaDdJa1VDOHdBbGtaUitLam5jN1BRV1doVDZMeER5?=
 =?utf-8?B?cVljZzlxS3MwUm1XaGZYbWRxQWFid3QwaUYxWkp3NnUxTzNSVXJVRzB0dUR0?=
 =?utf-8?B?bFJ0Z3V4Q2Myamxkb0tzVnp2cjRNK3hiUURMNHdQNDdqNUZ3Nm9QUU9lT202?=
 =?utf-8?B?MUJkd0R1ZG5BWjR2b0xiUHFGS1ZJNGNYaHdwRXRMZTRsdkdIdGN2OEhaVmMv?=
 =?utf-8?B?TFJ4K0Q0TC9ZRWdLU1ZhRnRPQUFDVHBSUEgxazFwKzJpMDltd0JudE9YY0NJ?=
 =?utf-8?B?U1JuSDZXeTAvVk1zRGx5SFVKQXZ0YnhJdytXMXBWWUxLekI5Z3V1T1ZhbERX?=
 =?utf-8?B?QlVYNjBYMTFSOXpoZi9PMll2VzFvZy9WNVQvSEsyZlhqUU9NNGx0cVhzazcy?=
 =?utf-8?B?RDBNWWhFeUpGVitMdVlvYnh1UEZha0ErK1NOWFhyWTc4MmtMWFZ0bkh2OU01?=
 =?utf-8?B?MFVRazNGUkFDallITVhQeXpyUWx6Q0xpZzBWK2dMRkE3eTRTRVQ4dndPbmxo?=
 =?utf-8?B?VTJCckNyREdCRkZJUVMxU1FXdlNKaUJJMFJpK05RYU1xQ0dFWHNDTHhOZXNi?=
 =?utf-8?B?V28ydFAvcVVKUzJUMWJDKzl2RWdwSzhsdnZ2VUZwNFhtQkpURmpsbWhGdU42?=
 =?utf-8?B?MlkwR3VIR0VFcjdIL0xqek9KNE1JNnVWcHpkcHA0RDlKSUxjVEszZVB1WVo0?=
 =?utf-8?B?ZEZQb3kyZFhRMmZEQ3AzYU1mNml4V0tZK0psWjFZejVuM2tsTkNQVkIzclF1?=
 =?utf-8?B?Z1JyQUtmNjBFQldXMkxHV1Y0MElIZjJ4bkVYamxiWjlEQzVUUnhHQitjb3ZU?=
 =?utf-8?B?ZkdmYkdJN2dTY1dXU2l2eFJuWW5ZcFhyRWJGdndUQ0Rkc1FCTW0vM1hLOGxE?=
 =?utf-8?B?YWovY0dTcWlTT0dJTlNhVFNTSWQxMjJ1eldna1RnZEtaZEJHcFVndm1iYWN2?=
 =?utf-8?B?Z3ZCS0J2NVpsMy9rL3NvMW40TDhxNGZnNGdzSFdsVGUzUFZ5bjU4cWxoejc1?=
 =?utf-8?B?VzN1cHFST1hSZ01HSFFPTWptRXFOajRjeksxTTZiNDBDakpabUwvS0dFMmVx?=
 =?utf-8?B?U21ybnkvb3hQSkdGbVBrVzMxblRCM0hmR2pNZTF1SWVqaVgxbTVVUUdlN0pB?=
 =?utf-8?B?NGQ2Z0doZks0V1NCYzcxTFBjNFE2L09qUGNVUGdSL2lLb3hwa251ckdBbkRx?=
 =?utf-8?B?cFROQjI3YmErbno0anlLUEpXaTNRWlFPNDZZaFJlbDgzSlliL0dEY1J5bnQ5?=
 =?utf-8?B?YnNPMUNIWGM2NU0rNkloVDZJNGpqZ0lhMmJXb3IzL1NySWs5dGU1c2VSS0tV?=
 =?utf-8?B?bUt0YStOOGZlODVRMEtZaTlDSEFuVytCZ0JaWlRYZ1pKTGI3Sit2MDlGWXFM?=
 =?utf-8?B?VlZUaVB5RDJyd3JoSG1WZ1UxcmJFRStKQVFUa1hhVXVkT2FwUkFGK1NoMERt?=
 =?utf-8?B?cHJnN0svVXFYK25zZm85WXlWMnVia002aXpBT0RZbk96eFg0U1JSbmd5NVRo?=
 =?utf-8?B?NFl5NmhNalRteGRBQVVpTkhvVTZpaUZMZjZSWTVqaUtTdzBSSTJkWEU1YzlS?=
 =?utf-8?B?bHc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	wpEwyPxbHAh2T9sPTT/iBser3czk3mG6NpLIWUOLMQmJPBN+XsOkOM/zZSx0yjEBT5wp2YCk7DHfcDfQJWox4HK4s+fIM7z1eVlEWWyW7/+l9A248ldROFdkuwokJer2jx35voNQX51WL9/3TVrqaDTmMChr4Ij6rrheVvfDZvGxnkiLSb3yDLcyXHa84HwrgjGVCgMlwxgRjaFmwrszRUIUzz564s5yOKA63HIHkF2MtVileLBUricTwObAq4c58Liy8fzci8dIC13ssCcK6tQgDlk0Ajtw6uR3UqH+HhujwQy0F4pPdiZbjFE645KjLDl6h8ObKMy/JbbXQDlcdreq4Lpcm8VPu0o8fxugon6DbqqAfiNq7ak03lCiKgrBQ4gaP6kExjp/D9/5TRJgpDnwmw7imIrQzZZRNt3GfuZF6iaqvKkSphJQQdqHP+eKi7DTQ5IpIWM0QzmT4rX4eoAqXmqz35TWaxCArJKyFOCSA4BrtEnzhK0/h/VaciCN6MxL2GaoPkfqJLrH2+3wiIGJCMbut1rkRmwn4IqysSUoChL0riEozQxV9y5GA9DtrAVHsr1iYo9yZAH/kSPVxupWm9+Q8UyctXdIMpJvtaQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: adb19c3e-c3df-4baf-328d-08dd56e6f065
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4306.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2025 04:26:43.3469
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rc9v0kzS+Zl1LuEBRp2TjOLP0jY0+UbSaum2JDID81z/yRXRmY7lt+MOq9k3xvWrSxmsd0139MkdJaHOs0P5RgTX/iL88v12PWSr2ulTS8E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB7587
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-27_02,2025-02-26_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 mlxscore=0
 adultscore=0 bulkscore=0 mlxlogscore=999 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2502270031
X-Proofpoint-ORIG-GUID: Xz0bjQRZkG9Fck-lyciKg2NTjeMO6k05
X-Proofpoint-GUID: Xz0bjQRZkG9Fck-lyciKg2NTjeMO6k05

From: Håkon Bugge <haakon.bugge@oracle.com>

rds_conn_path_connect_if_down() queues reconnect work with a zero
delay, not checking if it is a passive or active connector. Re-factor
by calling rds_queue_reconnect(). The zero re-connect delay on the
passive side may cause a connect race.

Helper functions are added to conditionally queue reconnect and
properly clear the RDS_RECONNECT_PENDING bit.

The clearing of said bit is moved to the end of the
rds_connect_worker() function and by that also fixing a bug when
rds_tcp is used, where the bit was never cleared.

Signed-off-by: Håkon Bugge <haakon.bugge@oracle.com>
Signed-off-by: Gerd Rausch <gerd.rausch@oracle.com>
Signed-off-by: Allison Henderson <allison.henderson@oracle.com>
---
 net/rds/connection.c |  5 ++---
 net/rds/rds.h        | 15 +++++++++++++++
 net/rds/threads.c    |  9 +++++----
 3 files changed, 22 insertions(+), 7 deletions(-)

diff --git a/net/rds/connection.c b/net/rds/connection.c
index 1d80586fdda2..73de221bd7c2 100644
--- a/net/rds/connection.c
+++ b/net/rds/connection.c
@@ -913,9 +913,8 @@ void rds_conn_path_connect_if_down(struct rds_conn_path *cp)
 		rcu_read_unlock();
 		return;
 	}
-	if (rds_conn_path_state(cp) == RDS_CONN_DOWN &&
-	    !test_and_set_bit(RDS_RECONNECT_PENDING, &cp->cp_flags))
-		queue_delayed_work(rds_wq, &cp->cp_conn_w, 0);
+	if (rds_conn_path_state(cp) == RDS_CONN_DOWN)
+		rds_queue_reconnect(cp);
 	rcu_read_unlock();
 }
 EXPORT_SYMBOL_GPL(rds_conn_path_connect_if_down);
diff --git a/net/rds/rds.h b/net/rds/rds.h
index c9a22d0e887b..1fb27e1a2e46 100644
--- a/net/rds/rds.h
+++ b/net/rds/rds.h
@@ -794,6 +794,21 @@ void __rds_conn_path_error(struct rds_conn_path *cp, const char *, ...);
 	__rds_conn_path_error(cp, KERN_WARNING "RDS: " fmt)
 
 extern struct workqueue_struct *rds_wq;
+static inline void rds_cond_queue_reconnect_work(struct rds_conn_path *cp, unsigned long delay)
+{
+	if (!test_and_set_bit(RDS_RECONNECT_PENDING, &cp->cp_flags))
+		queue_delayed_work(rds_wq, &cp->cp_conn_w, delay);
+}
+
+static inline void rds_clear_reconnect_pending_work_bit(struct rds_conn_path *cp)
+{
+	/* clear_bit() does not imply a memory barrier */
+	smp_mb__before_atomic();
+	clear_bit(RDS_RECONNECT_PENDING, &cp->cp_flags);
+	/* clear_bit() does not imply a memory barrier */
+	smp_mb__after_atomic();
+}
+
 static inline void rds_cond_queue_send_work(struct rds_conn_path *cp, unsigned long delay)
 {
 	if (!test_and_set_bit(RDS_SEND_WORK_QUEUED, &cp->cp_flags))
diff --git a/net/rds/threads.c b/net/rds/threads.c
index eedae5653051..634e9f431fd6 100644
--- a/net/rds/threads.c
+++ b/net/rds/threads.c
@@ -153,8 +153,8 @@ void rds_queue_reconnect(struct rds_conn_path *cp)
 		 conn, &conn->c_laddr, &conn->c_faddr);
 	rcu_read_lock();
 	if (!rds_destroy_pending(cp->cp_conn))
-		queue_delayed_work(rds_wq, &cp->cp_conn_w,
-				   rand % cp->cp_reconnect_jiffies);
+		rds_cond_queue_reconnect_work(cp,
+					      rand % cp->cp_reconnect_jiffies);
 	rcu_read_unlock();
 
 	cp->cp_reconnect_jiffies = min(cp->cp_reconnect_jiffies * 2,
@@ -171,8 +171,7 @@ void rds_connect_worker(struct work_struct *work)
 
 	if (cp->cp_index > 0 &&
 	    rds_addr_cmp(&cp->cp_conn->c_laddr, &cp->cp_conn->c_faddr) >= 0)
-		return;
-	clear_bit(RDS_RECONNECT_PENDING, &cp->cp_flags);
+		goto out;
 	ret = rds_conn_path_transition(cp, RDS_CONN_DOWN, RDS_CONN_CONNECTING);
 	if (ret) {
 		ret = conn->c_trans->conn_path_connect(cp);
@@ -188,6 +187,8 @@ void rds_connect_worker(struct work_struct *work)
 				rds_conn_path_error(cp, "connect failed\n");
 		}
 	}
+out:
+	rds_clear_reconnect_pending_work_bit(cp);
 }
 
 void rds_send_worker(struct work_struct *work)
-- 
2.43.0


