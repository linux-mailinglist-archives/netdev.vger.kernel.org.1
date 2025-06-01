Return-Path: <netdev+bounces-194536-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AB1C5ACA066
	for <lists+netdev@lfdr.de>; Sun,  1 Jun 2025 22:40:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 587061707E2
	for <lists+netdev@lfdr.de>; Sun,  1 Jun 2025 20:40:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A9FB23816E;
	Sun,  1 Jun 2025 20:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="i7U2d3HX";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="dL4mO5sc"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA54242A92;
	Sun,  1 Jun 2025 20:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748810434; cv=fail; b=put+AoFbT3RbmRP7UtCUxMelrGnHEyz3MSB2sntcGgKcMu4fm/SRutwU3uZuShYHUEM7KamYM23IuRUx63om+39dpQe5ikG6jhwRnP9MGiI+CAnbyQOb8Akq0meOrnkyYzO2zgslcvSacauXeoWawa+jBTmzmNDuV2e324fW6Uw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748810434; c=relaxed/simple;
	bh=3lXE33DoeJGJ7liioKo/efVFhqBKJ/FjtqRXuI40BOs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=fOkZraM9Lmq+Fjnvx3UoO28Xx5IWSJbUW36DZexoLUwaNQsRoay9gTtgJzllp435xReGLNt6ZdDGfKd55HSH9bN4GhkM9WHDlqM6lRft4m22paUZGfKXElbk2gAUdGSKpShXfOAdgtYTKZeH4dwncPgcQc6wBO9pjlkfS8IvZqQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=i7U2d3HX; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=dL4mO5sc; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 551FCkXh032189;
	Sun, 1 Jun 2025 19:52:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=W0W+rtllHIJWIoXeCEQs0knlT0GpMXVgLIfEd4zAlLY=; b=
	i7U2d3HXATcRfyhj0/0s2BQGMPsNlFXxMmv0W7ejm7MfhqhfCVnlxnk+Bb3jkt11
	5oGepYEtN/nDxpKq7hM5vISUsKa7ycA/ugAWZf0N9+ViosZKr8ehI2lgJDmpU92W
	mLPZP9ZGSfnHhcGEW199X974SWgZQi7Oc2fqWCHCCLxDrtwU9KQdtzVAv8vAvHyc
	aiZ0+A6x9ThCVNU3EJGxB2xwLZiOXSFdyWU7zj3/4yksmLLTDfQdcD+7RRy/9Hu5
	TwVagD/Ig1ezRFAlIvSOGiM3eE25IblMcD1Lw673mybSOqLhSh6zpb+v97fpxksu
	/371OFcyoiEMIJ4Crkov9g==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46ystesey0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 01 Jun 2025 19:52:00 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 551IYTfH035005;
	Sun, 1 Jun 2025 19:51:59 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11on2072.outbound.protection.outlook.com [40.107.236.72])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 46yr77g5ut-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 01 Jun 2025 19:51:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mIcPHYf7UC2X3jXJ/UHZpb8BAPDub8LTDL4CgUwm1Hb6C7HrsY5dcDvzRMH2jMoHY9xdBuZDhzTFZEoam+a4RQhcdZTc22zDrZjQNMf59Ml2a/JjR8EWU6tyEWyzGe9NGPpFE8W/juh8aYuZGwcxTxw2FzsW1V1LdJgRJq/xD7GzvN8b94sAwnpN+nEQa39kWsXiZ4Y/gVPVQgQJhblDjHyTFOuIIYaWuFnnrKJN1SIB4h1vtX6UC3y2/UqlON6hSrhuI0T+B4z0IZBcTEgjNxVoZsODojPhrxoy0eXAWWH1aUCjkS2HsFnWZFdRZm8McIdVkAbis2QcyvJxH7pqqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W0W+rtllHIJWIoXeCEQs0knlT0GpMXVgLIfEd4zAlLY=;
 b=PtjqIJinmV7GNPhTgEe8MnK9vsKywqJZnHwOpilONZriNrXMs94vfdtLkyS8YPHaoN4ctL1ouSsriSPVmtCxWs9m0xHXzBubddvO3sHu8j351rUjbRlwiP9Nre9SL2SiG/dziSb5FFqR4vdagqyLx7fjaW4+yXRqQCg3zAw1m+LwGCi2PxpYFFqsXXkizfIW4oxZD90ug3UMsFjQnCkANAVTTK9FSqp6177sSJFxdFAApv5tWp45I0DIHsBdzZVzBkR/G48ShE2TR5NAnZ/93dVQF0/trDSXjl51Q4Zk5PdqepAIBORPLZ9FyzTzlcQHtftIODMTdP8t+YpndlJ5VA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W0W+rtllHIJWIoXeCEQs0knlT0GpMXVgLIfEd4zAlLY=;
 b=dL4mO5sc/P8pTDm53t4bX9MRAtIcUNxpkgFkXR0SFI4YRlT4PntIkcLo8qmlqHQyM0OeRz0Sq3olaLocFVmEIcym4oT1JHhe4yacKHL/RzOV0wg3D0RyHZcXq054oGfxlaD1fVLhntwvLDlyMeve3FeTphoWoIIoifsU2EM5hTo=
Received: from DS7PR10MB5328.namprd10.prod.outlook.com (2603:10b6:5:3a6::12)
 by BLAPR10MB5058.namprd10.prod.outlook.com (2603:10b6:208:320::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.40; Sun, 1 Jun
 2025 19:51:56 +0000
Received: from DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c]) by DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c%2]) with mapi id 15.20.8746.035; Sun, 1 Jun 2025
 19:51:55 +0000
Message-ID: <cc05cbf5-0b59-4442-9585-9658d67f9059@oracle.com>
Date: Mon, 2 Jun 2025 01:21:48 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [External] : [PATCH] gve: add missing NULL check for
 gve_alloc_pending_packet() in TX DQO
To: Mina Almasry <almasrymina@google.com>
Cc: bcf@google.com, joshwash@google.com, willemb@google.com,
        pkaligineedi@google.com, pabeni@redhat.com, kuba@kernel.org,
        jeroendb@google.com, hramamurthy@google.com, andrew+netdev@lunn.ch,
        davem@davemloft.net, edumazet@google.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, darren.kenny@oracle.com
References: <20250601193428.3388418-1-alok.a.tiwari@oracle.com>
 <CAHS8izOqWWdsEheAFSwOtzPM98ZudP7gKZMECWUhcU1NCLnwHA@mail.gmail.com>
Content-Language: en-US
From: ALOK TIWARI <alok.a.tiwari@oracle.com>
In-Reply-To: <CAHS8izOqWWdsEheAFSwOtzPM98ZudP7gKZMECWUhcU1NCLnwHA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG3P274CA0005.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::17)
 To DS7PR10MB5328.namprd10.prod.outlook.com (2603:10b6:5:3a6::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5328:EE_|BLAPR10MB5058:EE_
X-MS-Office365-Filtering-Correlation-Id: a03eb219-7f86-45e7-9545-08dda145c311
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Z3BQSmdsdW5SRkhDUHo0QkphN2t4amVUem1LMFk4Zm5oV0ppWEE5dWpLbnJ0?=
 =?utf-8?B?UDVkQWZaWTVOOHhsTWkrSHBqZitPMUEzUmVDQ01TbkZwbEVKd3E4WFJXaTkz?=
 =?utf-8?B?UFc3OC9HZkhYbjU0NFlVQkRDV2d6LzVCc3lwUnF2aWNtd1B4S0VnMWhhcDM5?=
 =?utf-8?B?ZGVvMHErdzBITnBrbmRqVmxlNlVwOHprQTBGVGNlZW0yekVBektqalJLOVhH?=
 =?utf-8?B?anM2Tnd0RkZPK2NuVmM1U2dKbXk2STlmcU04R3FoOEZxam1zWHBoTmZ6ZURS?=
 =?utf-8?B?MzZxcEtrbTQrVmdWdjhDcUhoUlRRNzEzNHJnaGtkOHRiVWtQZTRBbFZaaHQy?=
 =?utf-8?B?ampmeWtweHgzamlydnpnR3BPV0hVdWV4Q25pUkpEOTJXL2dDaGd0V0hzemp6?=
 =?utf-8?B?eVZjQlVHTDFPK0Y3bEZ6V2hSTDNlQ2VFMUlmcll3NkJzZWI4SUlPYTdMSjVo?=
 =?utf-8?B?QU9mUXRTZ3BwSENuRTVBY0ppbXcxQnpkUVpTb1Z2KzZZRG9sQmlzQXZUbm9K?=
 =?utf-8?B?bVRINzBSR2QyZ2tIU2VuZ1d3TVZhQnJnTEN6eTR1SVd2Yzd5endTeUQzSkRC?=
 =?utf-8?B?L21qaDlicGRIR0I4a3U2Z3dGeUxGUmF3MVMrME5VbXBIUzdJVk9OZnZjQU9G?=
 =?utf-8?B?Z21FaEt4MVBkNzJyZUpVdXl6OE16V1I5VG9aT2tVUVJsVm9pMFdRajRTaDZW?=
 =?utf-8?B?Z3RyT1FEUnczYVZFbjQ4YXM0ODE0eDVuUEgvckNodmRVcXVSUHd1dFJUNWw0?=
 =?utf-8?B?VjVVanI5NW1CUEZCdDJZWWVpeTE1NzcyVGdQNTV6VzUzVTkvODYwamZ4UFhq?=
 =?utf-8?B?eGxKSFR6Tk4veEQxQjdDUVJjWUZ0VWdqOGw0Uks4clFKRGNya2pPcnRtTFhK?=
 =?utf-8?B?STdSaVlOdm90ZjFkaVpDUFkzUGhtTkNoVVIzYm1yT3ZuWUZCYWdFOTNEbFlm?=
 =?utf-8?B?c2k0a2UyeHFZOFRxNnBHL0RGRHVlSnY2OTlzS2ErT09ZMDZWdUhqZ051Ymg2?=
 =?utf-8?B?RlhPN1FyRHMzUFl3NmtRcHFlNFBDK2RFdm5pQVBKbGs4Ny9jOFJlZmI0ek5P?=
 =?utf-8?B?TzhZWFQxMzVnNm8vdTJETDV3bmIya2lMNE12SW5NQ0xOa2FwV1JOWmxrc0pk?=
 =?utf-8?B?dnBpTE9YQjQ5bUZTampxNXYydVN5bDBNQzhJTnUwSkljTXJDWUJZU2FiTjJN?=
 =?utf-8?B?WEVPdTJOUHJJL3VDNVFxQml2UkpBdzdOaGhQbVlYd3dBemR5UEFqaVRUSFYx?=
 =?utf-8?B?S3BoNDZtd0JTQ1dSMGRhQnJ3TEExbHhReUpVOGNTc1JXQm5obkdLSjU2SlFv?=
 =?utf-8?B?eGlhYnBoaHpycURsRGdRM09ha21vaksyZ3VEVVEyV2RRcUVKVnF3MXY1akJY?=
 =?utf-8?B?bnQ0ZmpYVmVtenZGS0g5Y0tTcXBMeDNwOHZZWkhETEdSSHg2MXN6Uk1PUnlK?=
 =?utf-8?B?dGF1SzdDcVcrVkRPVjJLNEhvN0R1SXpBejNaQll0OG5HeVpEMDdvajZNVmZw?=
 =?utf-8?B?R2VvSjZnWXZOSXJNVjk2STBjRmFLbDBKMmkreVJSako0cmJ6QlNBd0M0RDJS?=
 =?utf-8?B?MXpyd0packdEQzdLZUZzVENQQlBlZVg0LytHa3BFeFA4YlJrNUdFd2FVVWRC?=
 =?utf-8?B?Q1hQL2J2QkZBeDVYUGFHMEN0WEYvQ29TNVphaEFzU01WMWFhdGhqYU1ERE9o?=
 =?utf-8?B?SlMxRFFudkptT0RHTGY3R0JXeWk5ZVhPczJXSWtoRUVwNkRkN29Vd1RWL1Fz?=
 =?utf-8?B?NGxZSWtRcXZrNGg4dVc1dGdUR1pRRWhpNzZCMWFVUmpTVW9SbHowc2psTVRG?=
 =?utf-8?B?WHRPdytIS0dJSGsxRTNlb0RjS2dSdFMzRzhWVTVMUFY0RHNwelA4K3llOUla?=
 =?utf-8?B?a3g1WnhsTjNPWDlaZ1dTTnlRM2g3aWRWNklvUkhDNjdKUll1NWUvSTYxc1M5?=
 =?utf-8?Q?2dWxaSg8zMw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5328.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dFQ1cTZvWDZuK04zMUs0c2lOVXNaQzVHWUlyWXlGS3B0UEh4U3N0MWY4bTl0?=
 =?utf-8?B?Sm1SaTZuKzFZS1J4a0VtL3lqWXRvNTBWVlpQSnY0NjNtSXFEOTZCbVlVUi9K?=
 =?utf-8?B?ZUI0NHMwVXYyYjJPU3AzVlBDa1pvQll5UGJOM2c4dlkrVHNlY05tV0gvL3h0?=
 =?utf-8?B?SWhXWjk4MUZVT2I5RFVrRjBrZVJBRmZtRFZ6RHZjYkJBMHEzUnRtVEtyem50?=
 =?utf-8?B?Q2V5ZWcycVkrckk1YzF1TU5hL25CL3FKK2lTdFdsSlRoanVQazJQWDMxbnpZ?=
 =?utf-8?B?M0JmbDEyZ1JVVE80WUJYeDJFQTZuTmdPUE0zeFdSYkNING5pT0dOcUd6S0Jq?=
 =?utf-8?B?cnhGdTA1TXpCTTdCTndlTEZaTUtCVFVFdVI1enFTNzVpZ3ZaUUhYTjN6VldX?=
 =?utf-8?B?Sm1YLzVvYkE4VGIyR1d6R2hLWjg2ZXZTWFZBSjdYOUtnVTlZS1dpc3NScGR3?=
 =?utf-8?B?T3lCbEd1c1hEcEkzMERaOXhMdjJWYXhLSnNUdmZXQmxZOVVPSEMyOHZhenRZ?=
 =?utf-8?B?NzZnSTB1SytHM1F1ejZja3IrT1NXUWRraHJvbXkzQ2E1dEw4aERrVmdnTGNW?=
 =?utf-8?B?NlBYVHdrV3kvVTFBcytsUHZydHYyQnczaVVHR3RDZDQzbnlmbGhJdkRLREJZ?=
 =?utf-8?B?N3RMNWg0bTczRG1zbFJiS1BtcnRHd21nV0VFK1B2RXNOSEkwbTYwNUdMTEZh?=
 =?utf-8?B?Ky9tNXpmM25OaW96QWxMeUJncVoyanBHS0xFdTgxRGhReW1nSkhEdUtvN3ZV?=
 =?utf-8?B?V3VZMVRrS3N4MEZ2TlRKNnNpR1JNZUM4NUV3MUoxdTYvR2hJQzUya3h1eVNq?=
 =?utf-8?B?dTFzQWM4a0xyK0pCTzRoTm84VUI3b0h5S0ZRaHI1U0tlTmtnTUJUblluOEha?=
 =?utf-8?B?OGFtZkJXWXF1SGhBVERGMTAwcFJSc3Y2VUJhUThOYWtRNzk1ZUxtaG5XVGxk?=
 =?utf-8?B?Z0RvRndyT3k2dlpVZk5PdVp0aXhzemY2Q1lGenVWcGd0N0tLSHJjZXNObnMr?=
 =?utf-8?B?dHVkcHFhS0JpMnU1dm5BemNFOHpZdmU3RDVsdUlkT21KWThZdnFBQ1M1QmpC?=
 =?utf-8?B?ZEszQXM5M2JlOE4zUlJMVnZibkZEcEUvL1lpN1FGQzl3Z3YxVDNJSE9WbUd5?=
 =?utf-8?B?L0dkSk1vc2I0aVpXUGxoWVRoQ1hxRzNxT2lEU3pFRS9rVlU1UGZpVFJqYjZz?=
 =?utf-8?B?UWhPZ1lrblFDaTlpOVNsRy9ZN1c2K1hnN2ZadDdrWVdiWjJQSk1TV2lxSTJp?=
 =?utf-8?B?a296K2xJWTQ4Q3ZwaTM1a1h6VzRpV0RIVkUyMVRnMERNTnBtaHlRK1hSTGNl?=
 =?utf-8?B?YTN4dlFiM042cjEzMitGUlN6a0dXRkZEKzVoYmtFaWpzaW5Pa0QrUjZVY1Vo?=
 =?utf-8?B?L05taEEybjkzUGFMYjZOQ3NsTGIwSjAwVXZ0SWdmU0JVZllTU3dvZ0hkZ2Qy?=
 =?utf-8?B?bUZ2RFp4QnF5b3RkTzRzN1hpZWNpYUxUR1RCTzNPZExsUWRkd1A3all2Qkk4?=
 =?utf-8?B?VVl3dEt5NGV4aGFya0NhYVRvaEJjTHlSZ05mMk0zSTdBQnZ6dTkyVW9xZU9M?=
 =?utf-8?B?blpuVTMrT3RPR1pYNVNHbjJxNElsT0xxTkE3L3hTV3BFa1FQOVNTc2hSTHkz?=
 =?utf-8?B?YTNXbUN5Tk1mTm9HaG5VU3BkMWRhWm9rRFU0VU9UUmU2MmN3SUM2VnJ4OG1h?=
 =?utf-8?B?dThCOEhrdWxvTlZ0Sk9sMDEvaUIxUkVvTi96aStSVjdBWmpDYjBLUG9YTnBE?=
 =?utf-8?B?N245QTBEZldiVURILzlTdXNJaUZ0VjVxbDdrSThHS3UxbVVmeEpXVTBNZlhX?=
 =?utf-8?B?MU5CVVdMY0Q1bXpiQytmZWpnQWl0Z0wrVHh0ZndMblBJUkh3SmdrVzY5cVRx?=
 =?utf-8?B?VkF3MGVNY285bmZRcEFZMmE0Q0RjSkF5eFVRVEphNWlXczFCS25BcTNoU3RV?=
 =?utf-8?B?cS93Ym1Ca0JSSkpLQ2d2SWpkOEN6Rmh2ZDk2cE1DOUFrZHZUSkxIamRBRVlw?=
 =?utf-8?B?QjhtRG5INjNJZ0dIN2NvbDkwNk9nK1pPZExDTnZFUUhhRmttWlR2VkhHd1cz?=
 =?utf-8?B?REVkTzdSc0Jic3BNbzNpVmRlV2tUN1FSQWxrWno5QXZnbVZFWjhMTG1XSUNH?=
 =?utf-8?B?eDZqS21nOG9BZEVacTN2QkFVVGx0YnlmUmZiNkxmZUlLcjhXVlVwZHNHRGxu?=
 =?utf-8?B?SXc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	qzkA+7spswzH/0TnJHENu14yrtd4LWj1zikZJyaXEc+hqcVy/Dk4lMnGQM3bcW9a4xEr6E3yY8XztSTYHiKUi2pXvr+vpzniZCOtkaFwzEVhq1xfVFFSWhYIunQJJK9Z5MUyaY6NoZJ3qRqmHNwiZq7YfVY/Lo4513r6QbQBorq+n1FfMfXTi+/TXQIE6/Y7HrS5v7VmZH72qVk++bKpXkHX8ir8GffqPRakHzF/14NG5+QM/CImKAnhBTw2U8SF6wF8dwctfihwKC79eHu82Zbqu1kZVB3AMJPpLeynb2I6u5GogzRADk6UiCusIUXceJ651HD7PNDODuBGRS/7LfXzm6jHbaDC5fLih4Tm9N/FihE3JeJmAuKYcLIoTPvq/iaTk15VQoUSUTxfPMRDYJDlYbDjV8B8Ta0DP+nz5nBlVcmEwCW6vjlAG9wug/s1QuISz8d2oBkfUZ3cus/htB3ZPqFRmJBoAk/gTkgk+yyBs8HO0BW6V8PKExLc4WexFhlsYkKuf+HYYU2sdScW0wu/tQHy/qTKu6531w+/NzBk6JoMABMFokJ7ywXXTEGf9vvfufWYwm9YnplqCk2OwvaA6L4i1QezWglCed62QoY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a03eb219-7f86-45e7-9545-08dda145c311
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5328.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2025 19:51:55.8509
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y9byUiTWirc2VqKdDYAcpdV7JfWsdT8xZP2HR13yngqNWwy1l9r7cwZPQdFyuIvq20zmBQ+GgjJmbOktgbCNW4V7+QtR9umgLGB7W8ZNrOs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5058
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-01_09,2025-05-30_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 bulkscore=0 spamscore=0 suspectscore=0 malwarescore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2506010173
X-Proofpoint-ORIG-GUID: 2LfOxwLYBBa6imKeEZxZFh_sqoV2eG3c
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjAxMDE3MyBTYWx0ZWRfX2gOcFTcuos3Y Veaq7rDQcwzSGyspyXw9pcjvu46tjutggcMIRGfKt7RoGVWwdqsAhA+YjwUsdG2T3S2QAV9RgCX NjF7SSfguosR4F4IkOCoGX1TCbG8FQCXFK2uLLckWnkH4DoSgCaRZp9aZFOxaWY8g3YV6s2odgm
 XGTjVGU0mePWvN+8E47kiWl/YTkrpqUWmVM82delabxDWgUTfweOxiKyAe15qIYJic8F+2jkpk5 kZa5EidbdCitcIpDU5m8IaadSu9GtHlq+LBa8U6JGBG/H33U3hTDMG92VBycvA4F7FTJvS1q5OZ aTxVUUkIkmU0Kz+mtVEvslc9FktGUTRyvNIFSGwiEPo//s1TvCX43Jg5PI+x+EZfosuutlJPDqT
 5LrlvQVh07/ona0pvlFEQJhwHv2OJyXIuikoZYJM7nJ8gZkyey+YZYECPYypGZ88RRqH5Wto
X-Proofpoint-GUID: 2LfOxwLYBBa6imKeEZxZFh_sqoV2eG3c
X-Authority-Analysis: v=2.4 cv=XpX6OUF9 c=1 sm=1 tr=0 ts=683caf61 b=1 cx=c_pps a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=1XWaLZrsAAAA:8 a=E8e6kc4AU0M9f4V3sIsA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=1oIdJCuH23UA:10



On 02-06-2025 01:19, Mina Almasry wrote:
> On Sun, Jun 1, 2025 at 12:34 PM Alok Tiwari <alok.a.tiwari@oracle.com> wrote:
>>
>> gve_alloc_pending_packet() can return NULL, but gve_tx_add_skb_dqo()
>> did not check for this case before dereferencing the returned pointer.
>>
>> Add a missing NULL check to prevent a potential NULL pointer
>> dereference when allocation fails.
>>
>> This improves robustness in low-memory scenarios.
>>
>> Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>
> 
> Patch itself looks good to me, but if you can, please designate it to
> the net tree by prefixing the patch with `[PATCH net v2]` as mentioned
> in our docs:
> 
> https://urldefense.com/v3/__https://docs.kernel.org/process/maintainer-netdev.html__;!!ACWV5N9M2RV99hQ!JPpnRT9itx84rhzAaeGelVD-bnJR8vFksx2OjGzAKZWf_A6o8hEY0CUMMUO_NuSStcCyBGnvhoJAJlADszR4D_aj$
> 
> Also, if possible, add `Fixes: commit a57e5de476be ("gve: DQO: Add TX
> path")` to give it a chance to get picked up by stable trees.
> 
> With that:
> 
> Reviewed-by: Mina Almasry <almasrymina@google.com>
> 


Thanks for your review.

I will send v2 and add Fixes tag.
Thanks,
Alok

