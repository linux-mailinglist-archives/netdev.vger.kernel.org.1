Return-Path: <netdev+bounces-170102-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B535A4746B
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 05:26:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 131BF16F4C2
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 04:26:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AE9C1E5217;
	Thu, 27 Feb 2025 04:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="K+BFy/Ma";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="CAzCiYct"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71F8314D2B7
	for <netdev@vger.kernel.org>; Thu, 27 Feb 2025 04:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740630407; cv=fail; b=IUVkIAH9meQRW7Amoe3fa7cNgFnt9LFRs96EsRlrah8dFBb3V4lhCuoCmynix1mvTQi6k6y1nW5ufJGlSLv9yPsGMFtwYGHavfcHTlnMED4EK0m96VUiZEsV3c961Z35NWrCqwOf2EhBzemGwGiLzW/hmF6q6QbBIk3ioP4Libo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740630407; c=relaxed/simple;
	bh=nOAxAUn+QZu4vZeowyHlXj5Z4komhZxeukLtux2xtjU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=auOmWAE7bRFC3IXeztC6byg3z4DLrmc2jP3Cz9U1mqKrM1N6kpx9dqtMtiKz66sZt3QWxjEza+cT05UFVkwPtZfRKrMiagPJnB41Maxok8yngjA/pVqh/4z2/TL1SHT08DaA2TkijQeRpeqNASz8wBqrm1AsZJVVvuOd8TAdUi8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=K+BFy/Ma; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=CAzCiYct; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51R1fnNJ027569
	for <netdev@vger.kernel.org>; Thu, 27 Feb 2025 04:26:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=zcUy3ZvSZzHYzYHCJLHxTbVOotZO06E2xO0eHqFhJ2w=; b=
	K+BFy/MaPfZIZTI29nP90BYvnrCrnn2HDslEY3Mpa/PmZJgp1kkj/TsjaeNPulGv
	QRbaS8/eo/4Ru1p/ivbDp0Aw9L4M9hYUfiMDiJqVLTM35LvbuPYGnzkBh8r/c1is
	CM+BWjvFvB9KRcRu2ok8a2szigUzdFufISkhhwOLTW2pXzmX1O0FesbE/i8b+Zy0
	TsrKS+ttlmUsZ8fWQy+64/OPc5d5lYx2Xuu+mc1A4XDlEC1JnFkEwzY8TIU6lsfD
	hOOeushgP8vD/r+yK88A5zBoNL79McGGB1HgP7QpW5ZRIlrEBBzZOAO5VI/rAvwu
	hEDZ1xL91OdC8MthCmoAJw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 451psdjkuc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <netdev@vger.kernel.org>; Thu, 27 Feb 2025 04:26:43 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51R2KOXd024318
	for <netdev@vger.kernel.org>; Thu, 27 Feb 2025 04:26:43 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2048.outbound.protection.outlook.com [104.47.74.48])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 44y51bne7p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <netdev@vger.kernel.org>; Thu, 27 Feb 2025 04:26:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gPcmpFD0zsFPENJr9dngIiq5QT3KG8WOw9VvvweDElVS+PtSPoH4AZ436aeCTQ+YlqCGL/fb/Ss3s7PtIZOlJSUw8Hc5okk3Ct+lmMlnfjHXA/4RF07WLQbjBuENHGLpD7EC61GFU8FULtGS/stS7/DNWuyHt2LOjQ/UBoT9H4wisVdXRSzRdRbRtoRrIoHZ3s0jzFwS3a7HKBNdSi0jiTpXwpCoSijsJ615lOh12D698yF53qq8QdTsR8ZhnyzxZ02OqlnsepNVZi2NMvK2JeEg6ZF7Y12TONfLRonFjx8RnnYR+/96pZg/pnLFAJB8XxcmLBlyAX59aiygo8pfDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zcUy3ZvSZzHYzYHCJLHxTbVOotZO06E2xO0eHqFhJ2w=;
 b=mKGf1Jo/7n+Py6FwwyXRFaFvcFUII2CtNTTqVLTo0jlXsceBxDKxZ96ipE/Cf5kHNLjplLEpCe0xOAX5qpw2dCh1s/4fqAJ+rdxvlXlZnC8/meHNbBgs+82JPcgvLvOLS7OPhxlcJ+KOMDmdGRqFPngwT81hbv/CF9N0S2hAiQ8lms58mTVeKAZaxefmCSjUVkWgIx3/iX+sCdklzAdmLU8Tz5liVwMY8gNHb0x9tw9BVRKv2M6MJPPxepkNtIxRyJaAGq2SJKedB6lL1//40/ZcDH09v1h6st0oxEqhQmHwGGtIIlJ0jkRK1hlAWqNfy5Hty+b3TzuyysbMzWEgNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zcUy3ZvSZzHYzYHCJLHxTbVOotZO06E2xO0eHqFhJ2w=;
 b=CAzCiYctMkaWuyAiE7j+xc0KTgF1HZA4FaV1j1gcGy/I4Kh/pOff5hRVWVD5HBMdwhK9aWKEVPwQz17yiIZOzfjwLddD9zN8BOb0PjhBieHGfITR5zuDmL8rUxhBoY8raUypPtfJrohne/0dztw0lv3lYNOIrUrqBBHv0brjxqQ=
Received: from BY5PR10MB4306.namprd10.prod.outlook.com (2603:10b6:a03:211::7)
 by SA1PR10MB7587.namprd10.prod.outlook.com (2603:10b6:806:376::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Thu, 27 Feb
 2025 04:26:41 +0000
Received: from BY5PR10MB4306.namprd10.prod.outlook.com
 ([fe80::b78:9645:2435:cf1b]) by BY5PR10MB4306.namprd10.prod.outlook.com
 ([fe80::b78:9645:2435:cf1b%7]) with mapi id 15.20.8489.019; Thu, 27 Feb 2025
 04:26:41 +0000
From: allison.henderson@oracle.com
To: netdev@vger.kernel.org
Subject: [PATCH 1/6] net/rds: Avoid queuing superfluous send and recv work
Date: Wed, 26 Feb 2025 21:26:33 -0700
Message-ID: <20250227042638.82553-2-allison.henderson@oracle.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250227042638.82553-1-allison.henderson@oracle.com>
References: <20250227042638.82553-1-allison.henderson@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PH7P220CA0167.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:33b::9) To BY5PR10MB4306.namprd10.prod.outlook.com
 (2603:10b6:a03:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4306:EE_|SA1PR10MB7587:EE_
X-MS-Office365-Filtering-Correlation-Id: f848b0cd-106b-472f-9019-08dd56e6ef5c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?enBnTTcwZDZQR3I5cmU0djRETkNKb3c2bWpmNkNSdFFPdGRKaVd1a1gvQlpQ?=
 =?utf-8?B?ZFdjUk5BZUVjQ2k5amlzMHZEUmRLbTIzdi84R1krRjE3MEdIZTI2c2l1MVFU?=
 =?utf-8?B?RWZXb2UrdU43U3d4ZWhMeEEwdHYvNWFOZTl2QlA1KzNBNHMyV2FVZ2RxaTdn?=
 =?utf-8?B?c2hVSzFadWZRTEovZk5ZZDRSUnF0MVpLT1FJUks3SzgrZXl4bTJ6ZTJZcDZV?=
 =?utf-8?B?UnNmN3dLditIOTgyeXQ4aUErNmNVTmxLSWxOSzcrWFFtenE2cW9ubnc3SVFR?=
 =?utf-8?B?U3RWQTVGakxqWWQvVXB5Yjc4c25pRkxFbU1tQWw2WG1vTG9WZEdTcjdnc1hl?=
 =?utf-8?B?YUpBZzZKK0cvRXdHaWExVGdBZTE2bXpHWU01RW8rMCtOK2N4OCtIQmczL0Zl?=
 =?utf-8?B?WTh5NVdvL092LytNTkdXMTFLbmVpbzFyNXZZelp2TlBRVDJrU29jSGowdk1S?=
 =?utf-8?B?MEJvalZWVUxzOXNJSUZ4MGtrcURrbG9xUzhpb1dNZnNOcHc5WUVRNzlWQVZY?=
 =?utf-8?B?eTZNQ1R5NHZLUDA3R3dxdFh3ZUJnSWtBMVppWDVXOFNFc3Q2VVk1SEZuMGVX?=
 =?utf-8?B?eGwwOVVKVmpnQmRhaHBWTWp1UnpIU3E4SWtIS2ZXNHBoWmxQUWc2SVdHTnVv?=
 =?utf-8?B?U1RmcmVpejBlREVxQkplaFZQaVF5WlBqNml4Wjk1am1XaFJjV21udktKNkNZ?=
 =?utf-8?B?c1pxWWgvb1RuR082QURBeG1oUlgrSFA3UXVDTU1XWHF3ZUxac3BoV2N5WDgv?=
 =?utf-8?B?WEVXOHl3ZVlHMmt1VUFLdDZBMU5vMks4VWtBYnVoNWo0bFdOOWlKVDNTV21p?=
 =?utf-8?B?bkZrZm90R0lRZmxzc3MrRHVEd09ONHl4S0h1aWZENUNiclFaUTNEYlVOTzVv?=
 =?utf-8?B?NGtpVlMwMlV2RitBWTVMc0k5UDdPVFhCSUc2WHlBQitKQTBhaHpYNWhNeDg5?=
 =?utf-8?B?ZnU5TjZYWXFXMEtPb3hKMnNYWG1tOU9ZMzVFSnpjbjVCNzJiV1h3T0pHMThs?=
 =?utf-8?B?Y0M4ZitjamVjVjV1OXBNVXQrQmhPOGE0UEdwOENScGdGWEVSMWM5WGVpeHZy?=
 =?utf-8?B?OUJNRDJ2NjFwTXJzZ0hIczRMa2RlaFZqV1UySjJldHRsVnBkTlpCTWpRRG1o?=
 =?utf-8?B?anZnNy9ycE5KemRja2l6UDFNaTNKR3JETkwxR01qdHJYbmFLRzJUcXpUT0Vx?=
 =?utf-8?B?R0swVTJWb3V5TkVBMk5FZHB0UWFqdGlPYkZ5NXlkTnN1VTVKK2lWY0hSSHVU?=
 =?utf-8?B?ZXB5MkEyZVV3ai9kaGwzSlQvbmtVLzlhTWJoSVNwYnFoTjhjMVdZSEhpMmc2?=
 =?utf-8?B?UVFCWDR1aTFSbUFMakdoaXlmUVFraEdvQ2YzeXA0OGtaak5FMlk3NWVDOTNO?=
 =?utf-8?B?N1FXWXdjRVFqblBmZGZnWEdyQVZZWVIwRE9QOFZPdXp0Vk1NbHhvVVREM2M1?=
 =?utf-8?B?Q2t5NC9iczM4ZTZpRDc0R1dzVXpQbUc2WWJjT0huZ251Q3U1ckZESDJ4bEcy?=
 =?utf-8?B?UmJBbUJia1Vyck95RlQxTjNvZmNaTHpoZjNBUk9TSWVBbkhzS3FLdGlIc3JJ?=
 =?utf-8?B?b0tPTlQxRmJaeWI5d1hBWHN1bmsrdEVSRzQ0Z0ZaRXBrVnpnaGcxWFdpSEhs?=
 =?utf-8?B?Y0gvMzJRZkFoVWhrVUJWdlpqSjlRcmwzRG9saUpLNEtGTjRCaGNpUktxZzcw?=
 =?utf-8?B?TGhhUUFBUEdManowd1l2VjVGaXRVU1A1cXNEZzExT1dTU3Bza3hCWmdEWkJF?=
 =?utf-8?B?cGhGcG9aKzVXNjJTSDFwQWw4WktOd3hwdUE2MlY5STB6L0JGWDUxTFJVdXlr?=
 =?utf-8?B?cG1scU1OQm1rdGxhK0Y4bzJmTHVyZHhrMERldFRGdVBPZm9sLy9vOVFzV1Jo?=
 =?utf-8?Q?rkZwedmny+xWd?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4306.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VDhIcnF1eERGMTYrZzB3OHR2WWVKT2ZSenE1U3pIcE9jbFR6Uk5mM09DZkR4?=
 =?utf-8?B?RVhEYkRoZCsrMFFIanEzaDNMMHN4RktKLzF5NE9LL3BGeDIrM0ROMzNNYmMr?=
 =?utf-8?B?R1NJbXFlTkpJTXg3QkVETU9kbHlwV0R0RFRUdTJqaDJOZVpnbWZYazEweHkx?=
 =?utf-8?B?eTk0UnR4bjF0WE4wNlZrbGcwRGtFNTdIclZ1SlVLdHRIcXRaVzZtMGE4Qmwx?=
 =?utf-8?B?c2JLRkQrY2tsRmRNa2NWZHp1V2p6RE5ESFNyMGZ4K0tWTXRUZGFmY3dVNEEv?=
 =?utf-8?B?VUx4Yk1VTUZHeU13TDcvcHZ3dkcxb0J0Z3AyOTBITHQ0VnhNYnZKclkzM2Zi?=
 =?utf-8?B?b1V3bkxFV0FveDNobGl6ajRDeGswSndKaVlianNiZE1ZWnhkaDJhMkVXMGdn?=
 =?utf-8?B?TzY1eXcvUksvMHEwVS9JK3lzUk9aeFd5WGNQRTIwb2JLYWxhWFh1MWV1VGlP?=
 =?utf-8?B?aXVZZVFJN1Z3QnRrTkNnY3BBVmgrQTJRVDlET3p0Q0xzNllSU2JNQmxYSDlH?=
 =?utf-8?B?c2lzMGxwRVY2UFEvQlpZQkovaWhkMjBZY1k0dGRnd0tDNE5GdEpSVmRYanpH?=
 =?utf-8?B?Z25HSFdPSUQrcHFuRjdIMVBBS3ViTUpUY2VvbmpRUFhKdjA3VlZMT1JNUXor?=
 =?utf-8?B?eGVrTkovaWRlcmNPNHNTT1MwNEFSbzNEUDZvNVF0VFNhZGZJMEJYZmFMeFl3?=
 =?utf-8?B?c0hLK3dENVJKZHZQL0I0WWFSNldTU2xPTlhIK3BvbllicG9QYXNZdHA0bktF?=
 =?utf-8?B?WEJlRUJNeHk5bnQzY3A4M0YyanJYc0tQbTlUeVVyUDFDMk9tdFNKNGtKeUx6?=
 =?utf-8?B?U3NBeWFna2xKN0ZjYjlOSThiQUd6TEtUSGxnTzFheGh5Y2ozL0FJU2RpYXZX?=
 =?utf-8?B?ZXpmMWdneVJCQTRYVm8vVW5IQU5qdVpOc2ZFQkRBdUlRaXRnSVAxVFpVRXVh?=
 =?utf-8?B?dTVES1FKVmlCRVF0S3ZBWkc1cTVwUjdPelgvVTAvMVJxMWlPSEdDMmlLeDdl?=
 =?utf-8?B?ZlZCTnYrTWNmUUcvK0FEa0dsRzN5TTlrbUovd1pZbmFJZlJVbWZ4STBZeVlT?=
 =?utf-8?B?ai9lTGhGZG5TMTc4R2Z1SWhvbHUyYzh6Y0N6TEo1N3ZDWUpyOUpZNEpFMXNF?=
 =?utf-8?B?UlRlQ00xM3c4S1JnQk5ZL3g2SDlERFJ0aGpvR081dnByWUVIeVJpUW56WU85?=
 =?utf-8?B?Ky80NE5QMUErR3hkT2VUMkNYQlp3clVxeGxtZGJOQWpLWEE4MWo3QmdMeGV0?=
 =?utf-8?B?REltbDhXM3pHNVVoN0N4bnRHOElRZHRzclJNUFNIeFU4akx4eEJ4TmpwYjZG?=
 =?utf-8?B?MG8vR2lOdXVBeXU5MDFjVVg4Uk9lamJ4MVhxbGF5SjZPZzlYcW1zdmRSdks5?=
 =?utf-8?B?aE50Z1hMU3Z2bzN6OFlZdDcwWkJWYU5OVlpITGNRTkljUnZaalExTFhnWjIz?=
 =?utf-8?B?WVd5b1ZGeWUrTlR2eEo5bDM2ajVwNlJkWWQvZmJ4RTRKNTdtSjFGMUI4NGto?=
 =?utf-8?B?OGMrWnNLb1pOUUFqQVhxc0YzTTRqUENQVFovOGs5cU5xUlRBWmhyZis1Nmov?=
 =?utf-8?B?bXhmZCtaWS8zamZkK29WeWNaYks2UFRvRTJFWXZ1cFhVb1pvVU9QWGgvTmxV?=
 =?utf-8?B?NXJhWG9ZZzRZNlowYzc3eXdobzJMVG93TTdBYTl3MzJmR3hPVnA2emFzaXFC?=
 =?utf-8?B?SlY0ekdDeENQT085cURJM0VYVkkzVzFvUXdTdHY3WGt2bHdtYklMTVBUcXB0?=
 =?utf-8?B?VDg2RVdvY3VKNFZrRlZ4MWREUDlEdkRFMSsrVUg3SDdRYWxMZnVKaWo2RnE0?=
 =?utf-8?B?ZzI1OU4wZzR6OFVwdFdOMHFoTXRTMUMvV2lSS1Btdm5KY21QR1pJL0V3c01I?=
 =?utf-8?B?YkdtM0hZeExJSjAvWEZ6UndQdXIvN1l1Sk4rNlB6S3l1MnVPQ2w0NkpvR290?=
 =?utf-8?B?QjFvNWFRcTUyYjZnMHNkWWxtTDVWWG90cGtYYzdMN0w5Z1IrTHA0OTBnWmZH?=
 =?utf-8?B?bnViS0xORm5wRG5NVUhXY3ZnNUllU05lR24wY3ZWWjROOTJ0dFBuTFBwRitq?=
 =?utf-8?B?YVpyZTBxOWpWZ0JzVVNocE1vNUtSQ0k3a1ROeG04ZEZhWDZ3YitlNDFiekpK?=
 =?utf-8?B?RXJMOEJOZ3NXQ3NJb3dPeTFvZnJtU2J5K05kOWE2K0ZjV3hjeFFaT1hFOTc5?=
 =?utf-8?B?T1E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	KZ4lbn7wAD1myLvW8rMQiL/qGquhDYVNBRf8ckZR9WyqfRvVBegq5CuwV0Y/XsiyKEGdMkPYZULZIDLFDzLcIRDlqGm6Jne1cRASEITv93wmeovuc4n2aijVPrpUAb126AKZB9Iw2jRPa6Q2HrGNYFCQLDakjptFJ7nro6/hI8cCY+8mmRxV7IF1C6YkEPP5rAblhaFlf2Bw4z/So2XJOySLh9a9QCXe7xcfVVlShR9hbNA6FXUPVYk8DtPCekCbYCDog5szCZREBaWcwZDvgUGmLPmQxNy/XMJk8e+Gqttl/rdjXDn2tvq4ODHDny8TubErZwdqLyS61RIR+Grr8giwl1HdH1FE3fxC0advvCF5iVw6KSXMReXNyWPJqi4NBW4H3OsRl775/WDN8LoK6+f02Y6CKh/m0G+xgy9bWwgP859OilxCg4WvONcm5kfdIFt7UUnuYeurGSIH2wnaOsnYtdhKZbBVmN0KABioK+VDSvaIMfH/pfka8GXUm95bqvh5ySfHaJmblQVxbiQ6igecA5HlkkFDxwVYd8pzqoAfZxqmM6ahdto8zJpKFeQIM7cgVq30z0EMQWqEAKCf/mz09Kwr+xsiAMMnrg7TH9I=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f848b0cd-106b-472f-9019-08dd56e6ef5c
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4306.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2025 04:26:41.6446
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UwU9LUHiq0v8sWnPXwXF2p0YDx9YzxSzaEzvOc64JuTl5cNDPRtmeirkGNI/mwyDmCFgOAoOc6uritaUoLsYuUCzT+AcIqRvHaeq8Sg2aRU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB7587
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-27_02,2025-02-26_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 adultscore=0 mlxlogscore=999 bulkscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502100000 definitions=main-2502270031
X-Proofpoint-GUID: ohWo2N5X7hmzy9GveFs9BYbr-gLtgwRm
X-Proofpoint-ORIG-GUID: ohWo2N5X7hmzy9GveFs9BYbr-gLtgwRm

From: Håkon Bugge <haakon.bugge@oracle.com>

Queuing work on the connect path's work-queue is done from a plurality
of places and contexts.  Two more bits in cp_flags are defined, and
together with some helper functions, the work is only queued if not
already queued.

This to avoid the work queue being overloaded, reducing the connection
management performance, since the connection management uses the same
work queue.

Signed-off-by: Håkon Bugge <haakon.bugge@oracle.com>
Signed-off-by: Gerd Rausch <gerd.rausch@oracle.com>
Signed-off-by: Allison Henderson <allison.henderson@oracle.com>
---
 net/rds/connection.c | 11 ++++++++---
 net/rds/ib_recv.c    |  2 +-
 net/rds/ib_send.c    |  2 +-
 net/rds/rds.h        | 33 +++++++++++++++++++++++++++++++++
 net/rds/send.c       |  6 +++---
 net/rds/tcp.c        | 12 ++++++++++--
 net/rds/tcp_recv.c   |  2 +-
 net/rds/tcp_send.c   |  2 +-
 net/rds/threads.c    | 25 +++++++++++++++++--------
 9 files changed, 75 insertions(+), 20 deletions(-)

diff --git a/net/rds/connection.c b/net/rds/connection.c
index c749c5525b40..1d80586fdda2 100644
--- a/net/rds/connection.c
+++ b/net/rds/connection.c
@@ -445,9 +445,14 @@ static void rds_conn_path_destroy(struct rds_conn_path *cp)
 	if (!cp->cp_transport_data)
 		return;
 
-	/* make sure lingering queued work won't try to ref the conn */
-	cancel_delayed_work_sync(&cp->cp_send_w);
-	cancel_delayed_work_sync(&cp->cp_recv_w);
+	/* make sure lingering queued work won't try to ref the
+	 * conn. If there is work queued, we cancel it (and set the
+	 * bit to avoid any re-queueing)
+	 */
+	if (test_and_set_bit(RDS_SEND_WORK_QUEUED, &cp->cp_flags))
+		cancel_delayed_work_sync(&cp->cp_send_w);
+	if (test_and_set_bit(RDS_RECV_WORK_QUEUED, &cp->cp_flags))
+		cancel_delayed_work_sync(&cp->cp_recv_w);
 
 	rds_conn_path_drop(cp, true);
 	flush_work(&cp->cp_down_w);
diff --git a/net/rds/ib_recv.c b/net/rds/ib_recv.c
index e53b7f266bd7..4ecee1ff1c26 100644
--- a/net/rds/ib_recv.c
+++ b/net/rds/ib_recv.c
@@ -457,7 +457,7 @@ void rds_ib_recv_refill(struct rds_connection *conn, int prefill, gfp_t gfp)
 	    (must_wake ||
 	    (can_wait && rds_ib_ring_low(&ic->i_recv_ring)) ||
 	    rds_ib_ring_empty(&ic->i_recv_ring))) {
-		queue_delayed_work(rds_wq, &conn->c_recv_w, 1);
+		rds_cond_queue_recv_work(conn->c_path + 0, 1);
 	}
 	if (can_wait)
 		cond_resched();
diff --git a/net/rds/ib_send.c b/net/rds/ib_send.c
index 4190b90ff3b1..95edd4cb8528 100644
--- a/net/rds/ib_send.c
+++ b/net/rds/ib_send.c
@@ -419,7 +419,7 @@ void rds_ib_send_add_credits(struct rds_connection *conn, unsigned int credits)
 
 	atomic_add(IB_SET_SEND_CREDITS(credits), &ic->i_credits);
 	if (test_and_clear_bit(RDS_LL_SEND_FULL, &conn->c_flags))
-		queue_delayed_work(rds_wq, &conn->c_send_w, 0);
+		rds_cond_queue_send_work(conn->c_path + 0, 0);
 
 	WARN_ON(IB_GET_SEND_CREDITS(credits) >= 16384);
 
diff --git a/net/rds/rds.h b/net/rds/rds.h
index dc360252c515..c9a22d0e887b 100644
--- a/net/rds/rds.h
+++ b/net/rds/rds.h
@@ -90,6 +90,8 @@ enum {
 #define RDS_IN_XMIT		2
 #define RDS_RECV_REFILL		3
 #define	RDS_DESTROY_PENDING	4
+#define RDS_SEND_WORK_QUEUED	5
+#define RDS_RECV_WORK_QUEUED	6
 
 /* Max number of multipaths per RDS connection. Must be a power of 2 */
 #define	RDS_MPATH_WORKERS	8
@@ -791,6 +793,37 @@ void __rds_conn_path_error(struct rds_conn_path *cp, const char *, ...);
 #define rds_conn_path_error(cp, fmt...) \
 	__rds_conn_path_error(cp, KERN_WARNING "RDS: " fmt)
 
+extern struct workqueue_struct *rds_wq;
+static inline void rds_cond_queue_send_work(struct rds_conn_path *cp, unsigned long delay)
+{
+	if (!test_and_set_bit(RDS_SEND_WORK_QUEUED, &cp->cp_flags))
+		queue_delayed_work(rds_wq, &cp->cp_send_w, delay);
+}
+
+static inline void rds_clear_queued_send_work_bit(struct rds_conn_path *cp)
+{
+	/* clear_bit() does not imply a memory barrier */
+	smp_mb__before_atomic();
+	clear_bit(RDS_SEND_WORK_QUEUED, &cp->cp_flags);
+	/* clear_bit() does not imply a memory barrier */
+	smp_mb__after_atomic();
+}
+
+static inline void rds_cond_queue_recv_work(struct rds_conn_path *cp, unsigned long delay)
+{
+	if (!test_and_set_bit(RDS_RECV_WORK_QUEUED, &cp->cp_flags))
+		queue_delayed_work(rds_wq, &cp->cp_recv_w, delay);
+}
+
+static inline void rds_clear_queued_recv_work_bit(struct rds_conn_path *cp)
+{
+	/* clear_bit() does not imply a memory barrier */
+	smp_mb__before_atomic();
+	clear_bit(RDS_RECV_WORK_QUEUED, &cp->cp_flags);
+	/* clear_bit() does not imply a memory barrier */
+	smp_mb__after_atomic();
+}
+
 static inline int
 rds_conn_path_transition(struct rds_conn_path *cp, int old, int new)
 {
diff --git a/net/rds/send.c b/net/rds/send.c
index 09a280110654..6329cc8ec246 100644
--- a/net/rds/send.c
+++ b/net/rds/send.c
@@ -458,7 +458,7 @@ int rds_send_xmit(struct rds_conn_path *cp)
 			if (rds_destroy_pending(cp->cp_conn))
 				ret = -ENETUNREACH;
 			else
-				queue_delayed_work(rds_wq, &cp->cp_send_w, 1);
+				rds_cond_queue_send_work(cp, 1);
 			rcu_read_unlock();
 		} else if (raced) {
 			rds_stats_inc(s_send_lock_queue_raced);
@@ -1380,7 +1380,7 @@ int rds_sendmsg(struct socket *sock, struct msghdr *msg, size_t payload_len)
 		if (rds_destroy_pending(cpath->cp_conn))
 			ret = -ENETUNREACH;
 		else
-			queue_delayed_work(rds_wq, &cpath->cp_send_w, 1);
+			rds_cond_queue_send_work(cpath, 1);
 		rcu_read_unlock();
 	}
 	if (ret)
@@ -1473,7 +1473,7 @@ rds_send_probe(struct rds_conn_path *cp, __be16 sport,
 	/* schedule the send work on rds_wq */
 	rcu_read_lock();
 	if (!rds_destroy_pending(cp->cp_conn))
-		queue_delayed_work(rds_wq, &cp->cp_send_w, 1);
+		rds_cond_queue_send_work(cp, 0);
 	rcu_read_unlock();
 
 	rds_message_put(rm);
diff --git a/net/rds/tcp.c b/net/rds/tcp.c
index 0581c53e6517..b3f2c6e27b59 100644
--- a/net/rds/tcp.c
+++ b/net/rds/tcp.c
@@ -168,8 +168,16 @@ void rds_tcp_reset_callbacks(struct socket *sock,
 	atomic_set(&cp->cp_state, RDS_CONN_RESETTING);
 	wait_event(cp->cp_waitq, !test_bit(RDS_IN_XMIT, &cp->cp_flags));
 	/* reset receive side state for rds_tcp_data_recv() for osock  */
-	cancel_delayed_work_sync(&cp->cp_send_w);
-	cancel_delayed_work_sync(&cp->cp_recv_w);
+
+	/* make sure lingering queued work won't try to ref the
+	 * conn. If there is work queued, we cancel it (and set the bit
+	 * to avoid any re-queueing)
+	 */
+
+	if (test_and_set_bit(RDS_SEND_WORK_QUEUED, &cp->cp_flags))
+		cancel_delayed_work_sync(&cp->cp_send_w);
+	if (test_and_set_bit(RDS_RECV_WORK_QUEUED, &cp->cp_flags))
+		cancel_delayed_work_sync(&cp->cp_recv_w);
 	lock_sock(osock->sk);
 	if (tc->t_tinc) {
 		rds_inc_put(&tc->t_tinc->ti_inc);
diff --git a/net/rds/tcp_recv.c b/net/rds/tcp_recv.c
index 7997a19d1da3..ab9fc150f974 100644
--- a/net/rds/tcp_recv.c
+++ b/net/rds/tcp_recv.c
@@ -327,7 +327,7 @@ void rds_tcp_data_ready(struct sock *sk)
 	if (rds_tcp_read_sock(cp, GFP_ATOMIC) == -ENOMEM) {
 		rcu_read_lock();
 		if (!rds_destroy_pending(cp->cp_conn))
-			queue_delayed_work(rds_wq, &cp->cp_recv_w, 0);
+			rds_cond_queue_recv_work(cp, 0);
 		rcu_read_unlock();
 	}
 out:
diff --git a/net/rds/tcp_send.c b/net/rds/tcp_send.c
index 7d284ac7e81a..cecd3dbde58d 100644
--- a/net/rds/tcp_send.c
+++ b/net/rds/tcp_send.c
@@ -201,7 +201,7 @@ void rds_tcp_write_space(struct sock *sk)
 	rcu_read_lock();
 	if ((refcount_read(&sk->sk_wmem_alloc) << 1) <= sk->sk_sndbuf &&
 	    !rds_destroy_pending(cp->cp_conn))
-		queue_delayed_work(rds_wq, &cp->cp_send_w, 0);
+		rds_cond_queue_send_work(cp, 0);
 	rcu_read_unlock();
 
 out:
diff --git a/net/rds/threads.c b/net/rds/threads.c
index 1f424cbfcbb4..eedae5653051 100644
--- a/net/rds/threads.c
+++ b/net/rds/threads.c
@@ -89,8 +89,10 @@ void rds_connect_path_complete(struct rds_conn_path *cp, int curr)
 	set_bit(0, &cp->cp_conn->c_map_queued);
 	rcu_read_lock();
 	if (!rds_destroy_pending(cp->cp_conn)) {
-		queue_delayed_work(rds_wq, &cp->cp_send_w, 0);
-		queue_delayed_work(rds_wq, &cp->cp_recv_w, 0);
+		rds_clear_queued_send_work_bit(cp);
+		rds_cond_queue_send_work(cp, 0);
+		rds_clear_queued_recv_work_bit(cp);
+		rds_cond_queue_recv_work(cp, 0);
 	}
 	rcu_read_unlock();
 	cp->cp_conn->c_proposed_version = RDS_PROTOCOL_VERSION;
@@ -193,9 +195,11 @@ void rds_send_worker(struct work_struct *work)
 	struct rds_conn_path *cp = container_of(work,
 						struct rds_conn_path,
 						cp_send_w.work);
+	unsigned long delay;
 	int ret;
 
 	if (rds_conn_path_state(cp) == RDS_CONN_UP) {
+		rds_clear_queued_send_work_bit(cp);
 		clear_bit(RDS_LL_SEND_FULL, &cp->cp_flags);
 		ret = rds_send_xmit(cp);
 		cond_resched();
@@ -203,15 +207,17 @@ void rds_send_worker(struct work_struct *work)
 		switch (ret) {
 		case -EAGAIN:
 			rds_stats_inc(s_send_immediate_retry);
-			queue_delayed_work(rds_wq, &cp->cp_send_w, 0);
+			delay = 0;
 			break;
 		case -ENOMEM:
 			rds_stats_inc(s_send_delayed_retry);
-			queue_delayed_work(rds_wq, &cp->cp_send_w, 2);
+			delay = 2;
 			break;
 		default:
-			break;
+			return;
 		}
+
+		rds_cond_queue_send_work(cp, delay);
 	}
 }
 
@@ -220,23 +226,26 @@ void rds_recv_worker(struct work_struct *work)
 	struct rds_conn_path *cp = container_of(work,
 						struct rds_conn_path,
 						cp_recv_w.work);
+	unsigned long delay;
 	int ret;
 
 	if (rds_conn_path_state(cp) == RDS_CONN_UP) {
+		rds_clear_queued_recv_work_bit(cp);
 		ret = cp->cp_conn->c_trans->recv_path(cp);
 		rdsdebug("conn %p ret %d\n", cp->cp_conn, ret);
 		switch (ret) {
 		case -EAGAIN:
 			rds_stats_inc(s_recv_immediate_retry);
-			queue_delayed_work(rds_wq, &cp->cp_recv_w, 0);
+			delay = 0;
 			break;
 		case -ENOMEM:
 			rds_stats_inc(s_recv_delayed_retry);
-			queue_delayed_work(rds_wq, &cp->cp_recv_w, 2);
+			delay = 2;
 			break;
 		default:
-			break;
+			return;
 		}
+		rds_cond_queue_recv_work(cp, delay);
 	}
 }
 
-- 
2.43.0


