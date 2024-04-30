Return-Path: <netdev+bounces-92358-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8153F8B6CC5
	for <lists+netdev@lfdr.de>; Tue, 30 Apr 2024 10:26:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0871B1F216C3
	for <lists+netdev@lfdr.de>; Tue, 30 Apr 2024 08:26:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAF4C7BB15;
	Tue, 30 Apr 2024 08:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="C85HSStO";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="EbCK2N6a"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AD6E2BB07
	for <netdev@vger.kernel.org>; Tue, 30 Apr 2024 08:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714465611; cv=fail; b=lNTWJoCiX3Dou779tmCp+3EGTsEqookyxVDDfDti57UPKqChKVni9HCFblfg7173Mgn548voxVx+aAqSWRG2w4v+v1UyLYvb7zjtkr2uRGmxMR3Q/EbCaTaa2Q7y6sar4UdWxAfmfxDdtzfdh97qn2ryWqgptQQkpMwn8kRmTzI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714465611; c=relaxed/simple;
	bh=ak63VjWtRAivSPhcb3fI1V0xxUTyCRUgTUE88ptjxs0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=J7HpJA2Wpz31pAl49KdzyklDfoitpDpT9pvrdg5jgHxZKOBD9Se+usq73FUB6N1HV2DjBiHCwKUbgClyuIo2nY0QFnk/nTR4UbB65NWLzd9XE4AOXzEg3tqe0EVQEWJWVEhnTRS6lV7m1tEGi/dyQw42Ju/5U5L83OgBe8dbSYM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=C85HSStO; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=EbCK2N6a; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43U1hoEA016647;
	Tue, 30 Apr 2024 08:26:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=zZAOhwalmqpI1DptHwpX+TiqRKFZ/X7sPixWe9bqSpk=;
 b=C85HSStOAZOZtrjKR2UgSm4JBjtP5ulwfPVO0HbPGooa4aDLzUl3anhvTIkf8nGEsewL
 p6Tqk1depMF3fO+Xrr4tBz90B0qIySN13Ap91tlh8mZpb+lQiDx9GuxoH5PdpAHFbZMw
 HglHD4CWhNfF6roYYeWCS7z/jUVzU/FYYkTyDk6WyQmmg+9rSLy1hq84sIEoKaqYLRd9
 jwW0sD27ILcNKHHBvDPenC9bEjZKlC4RoAtM70FGSnaikzIq1QpML+PL+bGNyWTst8rE
 ikg7+tf0ANtHeHh5BHwscD1Dx6i+snhmbkzXnpeFNjwJl8SwH48WOdeENVLhzS4E364S bQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xrsdemdj1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 30 Apr 2024 08:26:41 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 43U7l7u0008850;
	Tue, 30 Apr 2024 08:26:40 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3xrqt7gv8d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 30 Apr 2024 08:26:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ob/5CMrfg/Cmxjx2x3vZUCFKGf9wEedCbji1gTi4KOQSZuO0J0DAN3H9KD8eP0nZ1pTmeqq09gcKuVZq6OzbouRq5YSh7c8VIajdgQWRmUzDijJgESiBkjkW/XnLDwXs38c6yTaNT9iVJCBVd9Dq40hYsbWoO3D1osS5XWP4kPaDv+Yt7H/HL3i/26Vz++1tqRJzrAE+9KEdhOkH1TFLVMGQl4qJBFJZSugVy+DE+gj6KQt3gpecJimUirglbm50nRoPfB0ZIoiSJwpBsQ/bKEkYnoBhUMbnQU1H1SqZiSR1OxJMwqrMtR8oYS8Qinv/kY891dNL76NhKePJ84/VIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zZAOhwalmqpI1DptHwpX+TiqRKFZ/X7sPixWe9bqSpk=;
 b=ESYoPZbNnCei0uftADKo8jU4AstxtBf/LX1wKn+RUqgYEH8qJaY9Qb1dnAzKpNBPuXz4r7scUCUOCJoDbSW9homZR7879bqmruFgg7UdpIoLY9iPp1l57kEHugGevx7AX8ISg6FuT3vDr6Dve5IiIUVAU+NqywUq6NkMbLanwmq0nGdwKwnCuhsovFoXVhxroVeDX6w1WGa4omMv55stwDtYjaufwOgs1Cph2XLtXYfI5PHztRROqmwhdsVP2qLyUK5KG9WTKlVmRRL4B3qlZC1/j9KGlhTqkaGoH0QYlwmkVjmxSli3rDbYTeL+JoOAQW46n35+PqzxIDFbZmg6lQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zZAOhwalmqpI1DptHwpX+TiqRKFZ/X7sPixWe9bqSpk=;
 b=EbCK2N6auqfuV/gS/kmvDhZD8aXIYPlWBnqUvCj+OSG1OywQHDKt6N1N4rjYJCOJoNyia8650H2Z4VK6IGlBQ2/flvxIQzCUj2I3QICoptLusJ6xIWOPRmT3qyt/pAT8wO7XBQo7nYpDk201pbl8A7iRzxh2kNIuhB2LwM9V4i4=
Received: from CH3PR10MB6833.namprd10.prod.outlook.com (2603:10b6:610:150::8)
 by DM4PR10MB6088.namprd10.prod.outlook.com (2603:10b6:8:8a::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7519.35; Tue, 30 Apr 2024 08:26:39 +0000
Received: from CH3PR10MB6833.namprd10.prod.outlook.com
 ([fe80::8372:fd65:d1ad:2485]) by CH3PR10MB6833.namprd10.prod.outlook.com
 ([fe80::8372:fd65:d1ad:2485%6]) with mapi id 15.20.7519.031; Tue, 30 Apr 2024
 08:26:38 +0000
Message-ID: <fbac2871-0ba5-4e36-a825-4ff3d6ef286c@oracle.com>
Date: Tue, 30 Apr 2024 01:26:36 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3] af_unix: Read with MSG_PEEK loops if the first
 unread byte is OOB
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        netdev@vger.kernel.org, pabeni@redhat.com
References: <5a2dc473-5b99-4798-8f23-c5316610af8e@oracle.com>
 <20240424013921.16819-1-kuniyu@amazon.com>
Content-Language: en-US
From: Rao Shoaib <rao.shoaib@oracle.com>
In-Reply-To: <20240424013921.16819-1-kuniyu@amazon.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR11CA0040.namprd11.prod.outlook.com
 (2603:10b6:a03:80::17) To CH3PR10MB6833.namprd10.prod.outlook.com
 (2603:10b6:610:150::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB6833:EE_|DM4PR10MB6088:EE_
X-MS-Office365-Filtering-Correlation-Id: f8660618-c7ab-4d08-6063-08dc68ef41a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|366007;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?OU1BU2dQK1phT3hCRFVLSEpqWHVia3ZQeGZFUjRxRk85OWdkU2VPazF1aVc1?=
 =?utf-8?B?U3JqUGppMnpHNVk0OHZGSTRLV1dPMmpKenFaVERJbEJOZHl2c04wK29nSTRM?=
 =?utf-8?B?eVllczF3RVlxZU4vZWloRjE5RnpQSjZQVGFkTjJWTXhORUtSSGQycVBOMnRj?=
 =?utf-8?B?NE1GQlowa0Z2WUw4bUxJWW1UdVRmU3QwTW90Y29aZVdQcGRXa205WWs5UXZL?=
 =?utf-8?B?VzRhU1ZNbXozSWpKd2w3aW1tUk5aVkY1R3N2RkZZNTBaZXZkM2t5VGpNSHNm?=
 =?utf-8?B?N25WUXMzdCtUKzRYamQxNjkybjR5QU9xZGVxcjR1SEFqQ1FIaTdXVGxZWHBH?=
 =?utf-8?B?eUttVXNxVHN6VjY5RFB0L0RjS201N0xhbEh0bE1remt0MEZvYnVZN2JnY3Zs?=
 =?utf-8?B?Q3BobzhCNDRxdDY4bmdxRVJWd2J5SXFoYUdVbzJyZk9WcWV2WE5ZMjdETURh?=
 =?utf-8?B?Mmh0dWgzMVpwYVBYdWRKa0JzQkpnMm40TFF1aUJVZCtlSWI3bkxZUUk1RUtO?=
 =?utf-8?B?eWNPQjdMK2ZNYTQ1OTZUUTI1Qk9aQUVVbWY4eUIwVzVoSkRUZElWd05ka2tv?=
 =?utf-8?B?bTBjVUIrLzNCZjNsZnVZMWRWSkdodXB5RlJJa3JFMm1VMnBVVW1KUnVQVGYw?=
 =?utf-8?B?M3FuZEdCYjBTaG5URlNwQmMrVFFDN0NPYWNqN200SGlpamhXMEtoZFBkVGlC?=
 =?utf-8?B?UUNVTzJ5clUrTTRiUmxsQStvb2hYUUI3UG1vdm9SbjkzcGR3RUpZbzEwMkF3?=
 =?utf-8?B?OXRiUzhKQTFsSkJrTzh5RzFxaG5QTHlEL2N0dkRrdWlob1JKRlpJd0w0RGhQ?=
 =?utf-8?B?eWVmaUJFU01VcHlEdDdBMW50UzBkQm1ta243a1dGWWtTdlNHSEprbkszbVZT?=
 =?utf-8?B?RkUwWHZWanh4KzNhdEpsOUhqQW5ZM2hPdVVRK1hQZC96M2lPUzNsY3JwOGRo?=
 =?utf-8?B?ZWc0RDdzYzZJbnBTbG5mWjgwelFPalVQT2IxcGJLbmFKOW5pMmJ6Nm9ZVlpQ?=
 =?utf-8?B?MGNnQ080cHdhRXdjeUxLRnZLa0pJSkNVcWw2alJ1WlRtN3JaQm1YWW9vQ3g1?=
 =?utf-8?B?K2pRVlFNM0FpeHNjQkNFdTZIdStLaVVhbi9oMG53OVlGODYrODdxZUgwYW5M?=
 =?utf-8?B?eE5Ic0M2VGorY1hRcTJUOGw3N1J2ZnFGRVVjeVVCS0FZYjhYUTJEbmN1V1Nl?=
 =?utf-8?B?c2s5Ly9ydStibVEwdEthOUprU1VDSjBxbEhiOHJQS3BVaHhVVWs1cy9SRjRS?=
 =?utf-8?B?aGplaWpMOWpnRlZkWUc5cEZvNzZJVEZaMHBRUlRzN3MvMFFINjFqRzJIMHN0?=
 =?utf-8?B?bmIzVTRkeEVxMXN0MWthbFA0SFBKVk1TRStGbkNoM3J4TlprYWVNeDZVQ2x1?=
 =?utf-8?B?LzZnbzZnbGpjTnVhNVdhblNEdUc2NFY3M3Q1QmdGbTZYd0wwN1E5ZUQ0MmVq?=
 =?utf-8?B?MUhFM0hkSUNKcStPY3d1M29jd0F5Ykk0aHE2ZmxpMmRBQmhJU1hRdE5BbHJy?=
 =?utf-8?B?UWhvaGpnNFpTSTFRZW9hRkpMS0ZMUnNZYlhHSGtpNlI4NWtubk8rZnpVTDR2?=
 =?utf-8?B?b0IwbldEemdqVEFrNDBZT2JQN0RCQThTYkt5R3EwT09RRjh1VVYwdXoyLytW?=
 =?utf-8?B?UzVQNzFrWktoZDl0SVVMNDRmY2JsZXJKL3VlWDlvYnljVDN1dTV5SHdIb1Ex?=
 =?utf-8?B?K3ZQNXI2ZEgyY2xaOGgrdWxVUXhrK1Z1cWZiMWhsTkxqOW5tdTJ5Z3hRPT0=?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB6833.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?Sjd5WnlwbTh2OEZkZnA3TEkxK0dJR1U0Ukw0c013OWRxQjM1MnozcFVGaVFw?=
 =?utf-8?B?UXEwditUWkdhVktBZEM3ZlVYblArcnFPRzM2ZCtrUTRvS05Kbno4eVQ3T2NF?=
 =?utf-8?B?NmtqUVp5T29kT3ZNMmtEQlk0NkUrTC85emxxb1ZMb1M0cVRvb2N0Z2JJb3Jj?=
 =?utf-8?B?ZVY2em43dW1zMVRaYzlWai96M0xBZmV6L3lySWdwRUZKMmpTQjBqRSt0aFoz?=
 =?utf-8?B?SEJHWFN5THdxdVVHalAyakNENFU3YWJnZHRHUHVma0dyZjFVVXUwRkc4dVlH?=
 =?utf-8?B?eUhWd0pGU0dVY2V5NEZ5WHV6YTVsZ1IyWVF1U29ETlE0aTVKN0JGNDRkdDZ6?=
 =?utf-8?B?ay9pTTAwcWNtZjUzQkxSQnY1ejZhaE1SMG9lTmlMdjBJQkE3cUk4dENkZ2VW?=
 =?utf-8?B?akczd3Bvb3Z0THBwVHBtaFl0Ny8vekpBa2t6Sys4aExxOVhFMXgrbjJmdEk4?=
 =?utf-8?B?cjBMaW5qSE4yRlFEVENyamZObUJ6MllTVU00UnVZR3FtZ3d6QWRpRldpeURq?=
 =?utf-8?B?Vis0eXErb1IrZGxaN2FhV3RDU0w5SkhYYVFNQ2MydDV6VmJCMkQrdENqQUNF?=
 =?utf-8?B?OHJRcXNuWUFGN2ZySmtaN3ROM0tZNHllTUtLb0JBNDY1YXp0ei9pem1SMTdN?=
 =?utf-8?B?QjZmanJXaWo0TEQyWnN3Y3pXN1VCdERROG1WdHA5bE1ZUHk3RE1UMEF1VTAv?=
 =?utf-8?B?dURhVHNCZHJXS01adkZuQXZMeXNTUmdSRXFNbWZGU1QxZ1BOSEhhbmNtN1Zs?=
 =?utf-8?B?YWFJV1lKVWk3R1hXejQyNUtYaG9CZ2lhZ0JKUUtxUGFGYUpVdm1ZZGZnekRl?=
 =?utf-8?B?dW1yRUpzU1RVeGNRcEYyY29IcXdvMDVySGdSMUpBN094RTQzTTRvTmJwclFX?=
 =?utf-8?B?WGlQQTFaN1NycWtkTHNuU2RCYWxzajk3NE5zUU85aFZqcVRYQmVYMVNSSEFn?=
 =?utf-8?B?Sm1IdlBIZWxwUU9nQkxLZ3FDSERKRzVYQzR3djhqR1lTeTZNVk1TS21nbGho?=
 =?utf-8?B?bi9BU3VXTXVaVC9ySXpjNHhNb3F4RCszU3hrOHpDdFk4emdyL3kzSTZ3amly?=
 =?utf-8?B?SWFuZk5qMmw3S2xVRUVlaDJ6NFdjV0cxOXV5eTdTUVZsMGVFaThPNVlCVXU2?=
 =?utf-8?B?a2RUcDIwa0hBMVRKWWZWN0JNLzdvUGZaN2hNQWp2OXRvbzRnTjl1UG5lRmZ2?=
 =?utf-8?B?MitHZkZEdVhrN2RHQWlYNlBjUTlYWnBsejFKeUVrQlZEcnVCdEQwT3lwT01X?=
 =?utf-8?B?Z0JNWDgzaXhPVkJZUmhwVHo0bldBbWVHWVBvUHFXdER2SnNseDk2TGZoeVFL?=
 =?utf-8?B?T2g5R0Q5SytXS21Bbk9jcVlUcUlYVS8wMUNFR2JzdnFQZUtBYytCU2xPM2hk?=
 =?utf-8?B?citQYm4xdHdsTU5oWlBpbDJiRk9GWXRJYm5LK1V5WDJwTzJ1VXd0NkJwVVg5?=
 =?utf-8?B?K3kzK2E5VG9RekhFcW1YWjd6bDY3T1Jjb0tHdllsMjFHSmRxQ3JWbklYYzIw?=
 =?utf-8?B?Mll4QkQ0cTdvSUZkVmJEaEt4QzZsNGhEOGVyb3dqcnoxWFRsT1hWU2xZV0Vl?=
 =?utf-8?B?MjdUOXFCN2VxWEQycFlzYURmckJkQUdMTG52YkdUNmJSMGdlNXJPdjJKYitE?=
 =?utf-8?B?dE0xQ0J4NlowZWVWVUw4RnExL2lJSEV0VnhiVm50QTFianpzYXk5RlplWldE?=
 =?utf-8?B?ZmJsUU9OWGxUV21aZVVaY3RWNGc5eGp5V2thYzBIOXo4bjJqU2VDdHJ5SnI3?=
 =?utf-8?B?WHNGeHRuTmNOZjNoTGp1cytlNXFVeDUzaUlNNndJTlF4Zzg3OEFTTnMzellp?=
 =?utf-8?B?QUdnUGI2MG1MekMvVnJ0bnZxTlJBb2lsMTJHT1BndGlhYWYyNU1WTm8rODVY?=
 =?utf-8?B?RmFnbk9hVThhTDl1cmtPaEZDcW5HK2gyNjViUHM0amdpZGNWV3V3OElRUTNr?=
 =?utf-8?B?dk9YWTQwT0h5eXZZZWRSSENVdy96dXFiZUt5Y2tTenBQN2tvZzhkZENUc3VG?=
 =?utf-8?B?UmMwUU5SZm5MRko5V1VBT1oxckhtL054K25MeUNKYURhTnFFTnI1RUhLbWY4?=
 =?utf-8?B?VDFXU0FISlE1ZDZzRGJjNDQya3lQMTAzT3ZuRkxnNTE3Yk1kOHZGeU5BZWl6?=
 =?utf-8?B?YldFbWRBWDhtVnVic1FURVB2U1MzQVNkZUtzekdqZnZ4dFJ4NVRVVlQ5ZjRo?=
 =?utf-8?B?Q0E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	hjeA7PI8fIQaVUqNVVJFiQ6a8dnXQ4A2LHzedGu6yq30irBqG3H9+XGqPrrtdKNaHdHIbRmWvBlnBfO0zGaS38hnbFQP+oCBYVxUAP63epuvVJ2PDql6rzSeg2oIhb629UgqJroNFVZSdb7/ELe/eo3gCbq1KNshozqosMyXGsffhPbO5R5TDwe4YyB7BUDRIclX0eFrZJW5a8QFN0oTG+G5QQzk+6ks0K4iJpOnuvY6BYvWg7WMc7V9CBJOGmQZiza7iwAbV+LVP1SQuemaOzHudOVSHRrMV2MJUu95Xk/1yfzM5pwk8yPAGMrhb8jsee+03UDd0NivKSI2BHYprVY4yOnq1B80yOiLPpYUQLNX88iB+PRJ/mGW0/9sRmAxQexnw0N3z5qA5NkVzUxMt7ABsOiDA5qPqR+AZdqMd4pm896VYkCZjjmwxwMarUosq+d0UgxqO/E4YHPcdBXjd/Ukn551WDXTE0XKYfCe6wpWNSesZNictvxvhEULyCCe/Uup/OfZXOoeMg2ZYfYBz/BuQOJwxBCIi+MpkIrWW655nZ7YFB4Kg2WL/Vgj0EzLuA2QRUaXooTKHAsuW803E2H+GKdp6pWrk7OYSZjiwrc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8660618-c7ab-4d08-6063-08dc68ef41a9
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB6833.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2024 08:26:38.9047
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7bs1STlbyhDjA0XWzqNedvIfyIGkXiMMvwuBpw7PTbETeQvIWuK1YtvUV5mtm5H2303P1R0j+gbzHIv4i5eYmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6088
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-30_04,2024-04-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0
 mlxlogscore=999 bulkscore=0 suspectscore=0 adultscore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404300060
X-Proofpoint-GUID: R6pHnb-XZMnvKZUQE1F1_qsuFuqgVzBe
X-Proofpoint-ORIG-GUID: R6pHnb-XZMnvKZUQE1F1_qsuFuqgVzBe



On 4/23/24 18:39, Kuniyuki Iwashima wrote:
> From: Rao Shoaib <rao.shoaib@oracle.com>
> Date: Tue, 23 Apr 2024 18:18:24 -0700
>> On 4/23/24 17:15, Kuniyuki Iwashima wrote:
>>> From: Rao Shoaib <Rao.Shoaib@oracle.com>
>>> Date: Mon, 22 Apr 2024 02:25:03 -0700
>>>> Read with MSG_PEEK flag loops if the first byte to read is an OOB byte.
>>>> commit 22dd70eb2c3d ("af_unix: Don't peek OOB data without MSG_OOB.")
>>>> addresses the loop issue but does not address the issue that no data
>>>> beyond OOB byte can be read.
>>>>
>>>>>>> from socket import *
>>>>>>> c1, c2 = socketpair(AF_UNIX, SOCK_STREAM)
>>>>>>> c1.send(b'a', MSG_OOB)
>>>> 1
>>>>>>> c1.send(b'b')
>>>> 1
>>>>>>> c2.recv(1, MSG_PEEK | MSG_DONTWAIT)
>>>> b'b'
>>>>
>>>> Fixes: 314001f0bf92 ("af_unix: Add OOB support")
>>>> Signed-off-by: Rao Shoaib <Rao.Shoaib@oracle.com>
>>>> ---
>>>>  net/unix/af_unix.c | 26 ++++++++++++++------------
>>>>  1 file changed, 14 insertions(+), 12 deletions(-)
>>>>
>>>> diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
>>>> index 9a6ad5974dff..ed5f70735435 100644
>>>> --- a/net/unix/af_unix.c
>>>> +++ b/net/unix/af_unix.c
>>>> @@ -2658,19 +2658,19 @@ static struct sk_buff *manage_oob(struct sk_buff *skb, struct sock *sk,
>>>>  		if (skb == u->oob_skb) {
>>>>  			if (copied) {
>>>>  				skb = NULL;
>>>> -			} else if (sock_flag(sk, SOCK_URGINLINE)) {
>>>> -				if (!(flags & MSG_PEEK)) {
>>>> +			} else if (!(flags & MSG_PEEK)) {
>>>> +				if (sock_flag(sk, SOCK_URGINLINE)) {
>>>>  					WRITE_ONCE(u->oob_skb, NULL);
>>>>  					consume_skb(skb);
>>>> +				} else {
>>>> +					skb_unlink(skb, &sk->sk_receive_queue);
>>>> +					WRITE_ONCE(u->oob_skb, NULL);
>>>> +					if (!WARN_ON_ONCE(skb_unref(skb)))
>>>> +						kfree_skb(skb);
>>>> +					skb = skb_peek(&sk->sk_receive_queue);
>>>
>>> I added a comment about this case.
>>
>> OK. I will sync up.
>>>
>>>
>>>>  				}
>>>> -			} else if (flags & MSG_PEEK) {
>>>> -				skb = NULL;
>>>> -			} else {
>>>> -				skb_unlink(skb, &sk->sk_receive_queue);
>>>> -				WRITE_ONCE(u->oob_skb, NULL);
>>>> -				if (!WARN_ON_ONCE(skb_unref(skb)))
>>>> -					kfree_skb(skb);
>>>> -				skb = skb_peek(&sk->sk_receive_queue);
>>>> +			} else if (!sock_flag(sk, SOCK_URGINLINE)) {
>>>> +				skb = skb_peek_next(skb, &sk->sk_receive_queue);
>>>>  			}
>>>>  		}
>>>>  	}
>>>> @@ -2747,9 +2747,11 @@ static int unix_stream_read_generic(struct unix_stream_read_state *state,
>>>>  #if IS_ENABLED(CONFIG_AF_UNIX_OOB)
>>>>  		if (skb) {
>>>>  			skb = manage_oob(skb, sk, flags, copied);
>>>> -			if (!skb && copied) {
>>>> +			if (!skb) {
>>>>  				unix_state_unlock(sk);
>>>> -				break;
>>>> +				if (copied || (flags & MSG_PEEK))
>>>> +					break;
>>>> +				goto redo;
>>>
>>> Here, copied == 0 && !(flags & MSG_PEEK) && skb == NULL, so it means
>>> skb_peek(&sk->sk_receive_queue) above returned NULL.  Then, we need
>>> not jump to the redo label, where we call the same skb_peek().
>>>
>>> Instead, we can just fall through the if (!skb) clause below.
>>>
>>> Thanks!
>>
>> Yes that makes sense. I will submit a new version with the jump to redo
>> removed.
> 
> If skb_peek_next() returns NULL, should it also fall down to the
> !skb case ?
> 
> TCP is blocked in the situation.
> 
> So, I think this hunk in unix_stream_read_generic() is not needed.

I do not understand can you please explain.

Regards,

Shoaib

> 
> ---8<---
>>>> from socket import *
>>>>
>>>> s = socket()
>>>> s.listen()
>>>>
>>>> c1 = socket()
>>>> c1.connect(s.getsockname())
>>>> c2, _ = s.accept()
>>>>
>>>> c1.send(b'h', MSG_OOB)
> 1
>>>> c2.recv(5, MSG_PEEK)
> ^C
> ---8<---

