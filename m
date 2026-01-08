Return-Path: <netdev+bounces-248010-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4524AD02239
	for <lists+netdev@lfdr.de>; Thu, 08 Jan 2026 11:35:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 351FE33E0427
	for <lists+netdev@lfdr.de>; Thu,  8 Jan 2026 09:54:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3182D39C655;
	Thu,  8 Jan 2026 09:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="o9w5qggq";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="GKZ/jl0M"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C8AB39B4A7;
	Thu,  8 Jan 2026 09:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767863006; cv=fail; b=SZMT/VTZdn3OLd9LOhN59AwQL0HdCqGrxvs6S9XrLamErsFscH5AV6lcQXovacfuf1YmElgLDqcgO0WX/OgimuW7RV0fTB5MQy4p/jvAMEpkCtGS0iPX6XTYG7zAGeqhw2C9GpMvLyNM4XNxhZdctSU02UY2EHezuqRq59gtI/g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767863006; c=relaxed/simple;
	bh=RfcggCGMZtQ1AMPa6DU7pUzaDpFLlilLqC751yXDi7o=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=kVhV/Q+tt6JwNIbXCbHziQUUcv73z0MdcP7soPVXoRaZ1JQ2d7jj7dqB9+a/IgzkZyiv+eBXToUY+mcaA4Gs5HvFjH6WLrIZKXSB7I5le5mAcoHw4CUj2usYHqf/ONXcy40vY8Rrd9iCDIgzLyk/aiKAy+3/r77mOQQ/Si4Wz24=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=o9w5qggq; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=GKZ/jl0M; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6088uU1a4152044;
	Thu, 8 Jan 2026 09:02:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=ZyFtcSwN/ojrTyGcr8IK4mcoXOmwC6KrVka8sAoth3A=; b=
	o9w5qggqV8xf4sv7W1N+4o8xe27J8/PEq4cG8NkCZooEHUumAg67NaJpFUTP0/Ed
	NH23b/8JQLrz82UZ/J1gYPahMk/wg3nXnnjDSq/m7luouR41wuunioEoFVx0AxOU
	gGiJb3aaUaP59JzUT4Cphv9lu17J45gjKsRyRq6/n0u0vYyshmOvGtUVBO/jeUmo
	pwQz6crgLLf6P2dedCvdiKHUhBUaUrYUHugr2817f6IqffB605RbrKyy+z9D4W8X
	y3dsCvnVVEbCzpDcWQdkB5t/Cs8CUW8fVCvbziTIXnFs96CtfxGu/dak7m2kot+Q
	kEQJfDKT1KehqEpYLtY41g==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4bj9gw807q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 08 Jan 2026 09:02:49 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 60881Bs5026752;
	Thu, 8 Jan 2026 09:02:49 GMT
Received: from ch5pr02cu005.outbound.protection.outlook.com (mail-northcentralusazon11012056.outbound.protection.outlook.com [40.107.200.56])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4besjakhaf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 08 Jan 2026 09:02:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y5r1r/mO/KCyxBe50Wp3EVYoa/36PdjHzuSQNH3xpJ0rJbWuh/n/WErSRTLlCz/XTEfDdL7Nl1iFwFVuAZh9Wbj4J61Z8v2m7GBqnSyaKUsfnuyFsQ5N/VxREDceZ6m8oyO1szpVj7PA6WfmWo3S8EyoJ1X1+3SLO/XCZaTjiJ7P+cykot48RRyu4PYm1jElxpvxAUxsE0eLU+1BBY6tkHrqRRzoJqMYCg2+2Tax7qc44cS+EJSbVwbLb+Spq9QAn7wRZcOnXAWJdMmOPa/xcjo6gv435bGruI1ex665MGUd4k7clA74F7+qpF/htIRRpspbzDVoh3byRuVGixU79g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZyFtcSwN/ojrTyGcr8IK4mcoXOmwC6KrVka8sAoth3A=;
 b=gtIa+ktEwSH6kWZCBNSOerVwFgZzRD8B2dmy6Ejcnl5FjpfVFlVk7ZDg8ZTXK7U+aUkiB5gO3C9M3LD9xvXs//bkbZIA0/rwlontHjPTL6e//xgxy0RPSOPfK592CdNVUkXhFPtkMAbu/vCIC787eXqvRTEiGj8U15UUwGu5OFitobvAUZhiOFtDjCGlZFf3o0tkjoISaaH48gcMHyea6K8i0rtu0hKy9g2XXI5N8qP+BXEvP0Py/2axSufN0XrD3lJAyQ+4b309SsTG9BZVBmSwSH+6J33KWzIrZhAGO5JhgT9pnowJr0EepCfWOtprjxAxkeCnGwC7qSrQkXLrjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZyFtcSwN/ojrTyGcr8IK4mcoXOmwC6KrVka8sAoth3A=;
 b=GKZ/jl0MJl4QewEuMbBC42oGIok9kFsY7IeuX0KQLi7XbdREGDn3TIGaGCH2cGcCkmhsxLPqe0BTGqw5UEr3pDp+MkYhjSztRwrr3oGdupBcSNR/raSmx+SNxvPevaqk5ibf3uFAOEXegzb9uqEk6d+bygt8TQWcQUnF4KqbR0A=
Received: from DS7PR10MB5328.namprd10.prod.outlook.com (2603:10b6:5:3a6::12)
 by BY5PR10MB4291.namprd10.prod.outlook.com (2603:10b6:a03:207::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Thu, 8 Jan
 2026 09:02:45 +0000
Received: from DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c]) by DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c%6]) with mapi id 15.20.9499.003; Thu, 8 Jan 2026
 09:02:45 +0000
Message-ID: <ea4fc014-251c-4d5f-adc6-0e3aa562862a@oracle.com>
Date: Thu, 8 Jan 2026 14:32:33 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 01/10] octeontx2-af: switch: Add AF to switch
 mbox and skeleton files
To: Ratheesh Kannoth <rkannoth@marvell.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, andrew+netdev@lunn.ch
Cc: sgoutham@marvell.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com
References: <20260107132408.3904352-1-rkannoth@marvell.com>
 <20260107132408.3904352-2-rkannoth@marvell.com>
Content-Language: en-US
From: ALOK TIWARI <alok.a.tiwari@oracle.com>
In-Reply-To: <20260107132408.3904352-2-rkannoth@marvell.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0552.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:319::14) To DS7PR10MB5328.namprd10.prod.outlook.com
 (2603:10b6:5:3a6::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5328:EE_|BY5PR10MB4291:EE_
X-MS-Office365-Filtering-Correlation-Id: ca5cc06d-203c-4992-bf50-08de4e94b013
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Sk1Ec2lwWEZUZmFrbkZDQm95S0hFRVVWVXpoQ2lpQVpQdjY1TzEya1o5Tkx1?=
 =?utf-8?B?OE8vVm5BeXhncGNVVW1BZHpmc1Q1SzlxVzhMVzU4cXJFMHFtQzZuK3BPWUk3?=
 =?utf-8?B?VnllL3EzU2hORERyQVIvbkF3cVBndzZlTmE5R2dKbnJGeW1SbENyRXRPT01R?=
 =?utf-8?B?NXBDSGgwSFVxRXAzOUEyWnFaV05Za0R5YkgxelZ3SDhhdlg4ZnZid01wcS9Q?=
 =?utf-8?B?QWVuS29GQUZDRVlhQ2dmK2JLQm14ZFZELzFnT1hNTkpGVEtHMjc1UnVXbW1B?=
 =?utf-8?B?cDhNTklKOEtMemJvQW1YdEJKTWRzdHdHWHkyUmQrUFBkb1VIM3BocFlreElD?=
 =?utf-8?B?bXZ0b0h6dXBLN0x5eXh1TmlsVE5YMGRJOFVCNnQrdFJiNXU2UC85ZVg3aWE5?=
 =?utf-8?B?YUFGRW9rZ2JEY0F6cStVUjVHZXh6a3VtRUJiV0kvcm9uV2c2amFnU2pLZjhP?=
 =?utf-8?B?aHJiOGl3VzdiRTBNRG8yRGJlWVBIM0RRSEl3alZESlhMYmcrb25paVlEOUxh?=
 =?utf-8?B?dGZsOUNXRWM3SDFENmh2SHF1eWQyTUhENWNFNGpNVHdrL0MzUWNmbVJQWUhv?=
 =?utf-8?B?aUh2akJnTXg2WmlpcWVVeDBKdGE4R1VMNXRQQ1pxVDA4QTltTythaHVKaTdT?=
 =?utf-8?B?V0FURUtSTnNJTjZqWTkzR3g2eklNOVRMd0tjblZUNlRJS2x2Ukg4U20zMm5K?=
 =?utf-8?B?SHBaL0ZOWDdsTWRWMFVBNWJXU1pCUElLWEErWFhVVk1IM0pteGUwVUdnL2k5?=
 =?utf-8?B?bDZXL0RuTjQydC9RSjlPS0dGdW56c01kV2h4eG9HcFZIckxIaE90aVdGdXkv?=
 =?utf-8?B?cGh4bStEbVZSei91a1dFSC9aRmxoVmVXSSswN1E0MlVtNk5FVEJDaVpEK2Z4?=
 =?utf-8?B?eG1SR2tBeC80MXlmcFU3cWhjYUxqd20rb0tYODZJSXF1aENMYXRJVVVTR0Jr?=
 =?utf-8?B?VVNDMFFxbi9vWXZtMHI1c0FEWlMvNWZFY2kwRmJwRGNvM1pZYWtkak0rQjRu?=
 =?utf-8?B?TzBMT3lCZ1lWb1hPREgrY0NDVUt2T0pyK1NzN0crNzl0R1ZQbEtUWDBLS0dJ?=
 =?utf-8?B?enYyMVVDYjlkM2Q3TXEyUTkrQ2RRQWpLalBSMDVMK29yYXRXYXhYenB2ajk3?=
 =?utf-8?B?dko4SU9vTUZsUDdtQkU5VTZRbU50TmdDWmcxcFFXRk5sdGMwNlZQdzE1WVM5?=
 =?utf-8?B?V2FIeTdWM3ROWEhQK1ZKRUx6dnBZUTdOVzFxV1Avcm93UlA4ZkFvZjNtYjhw?=
 =?utf-8?B?cnZ3OXRrSUFsZkhkOTE1RUFhd1ErTWg5MVozMUEyM3dqcEtVSUxrL2VaVFFn?=
 =?utf-8?B?QXJ4cng3U2wwZ1F0MkFNQU1mU2hnZmtlNTAwQmtrcm4reng0M09FK1ZDRk1j?=
 =?utf-8?B?WWJtQTJWV01JV3hlajFrbG8yeXNBWFJjUkhyYXNwMG8xUEtBQkgzbTlFRkxj?=
 =?utf-8?B?dzRQOTdVRDYyblE5S3pyWk1qaFV1MHJ4eXRncVZRM05RNlBKaThLeU1lZmdp?=
 =?utf-8?B?RTVIdk5tWEZUbnBtNHk2M3hnNmNyMXc3dWNsRzN2eERtZ09EL3pmYndtTldR?=
 =?utf-8?B?QjRWalFFRFB0TFZudnZVMDJqQ01nT3JXeDJXSzNoVjQrTUpkS3g3RjFlQ3I0?=
 =?utf-8?B?ajFHL0EzeC9KMVZocTFSclhVRC9na1RVWm5SbDBmQkVIbXNOQUNKS3YyYnpO?=
 =?utf-8?B?NDhYVzlzRWJzcGcwSlRFRmM0c201UWNVSlp0LytNWU1reFluTEhPSnpFMllo?=
 =?utf-8?B?RHFXeGhwZG04em96S3J0QkJPeWE4dEpNMy9qTFlSSzVEbEJVVWRseGNvTW5R?=
 =?utf-8?B?YS94MnBPMXNlOUpGUGdGVVMwTERsRGdDLzVFK0lwMVE0QXM2OFB0Z2I3dmVY?=
 =?utf-8?B?Nkt1dXRnWi9LemtZdzg3L0dKZU11dWJDakFET1cxWE10SVIrY0tyeGxRVi9O?=
 =?utf-8?Q?PySTtfJGdIEwrgpbSI/kxP9i2gfMQgyv?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5328.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WUQ3TVlaR0VsaUdQemFaQkZ3MlNZQy9TdEFrQWFYWWN3b2pNdERzWkc1ejk0?=
 =?utf-8?B?NkQ5MUVvK1l0U1YyR0hkbkwrVVlFclFIcmpFZ2ROMVd2eW9sMGJxVElpZXNp?=
 =?utf-8?B?aEJXeHZmeXlhYmpvdW1OLzZ2Q2tsTk4xS000bUM2OUpBYXlUV01haU5FNThG?=
 =?utf-8?B?bWNScFVWZXZ1S2VtNzBFSnQ5YnZMVnAyZDhsajBFbmtUaDJaNk8xVGpZejMw?=
 =?utf-8?B?Ukl6YU1JQmJTRElCS3dWaHRhUHpiNHIzSkI2Q2J5OEUzUTI3L1d4cnR0LzE5?=
 =?utf-8?B?cmhoTW90QitvcjVHM2lMR2taVHFqeDBKeGs1UFNRaVlCbyt3eU1oMzlsbXpQ?=
 =?utf-8?B?RXlVT05qdUsxbUVMTWdkV29qVXJNZ1UwcGpsNVlRR0xtdFhOS0d3V0JJNDU3?=
 =?utf-8?B?M2cyemhSVXpWVzZUbGp0MGlDUzEyb3plVlM0eHJJbE9RWGxUZFRiaStQUGpm?=
 =?utf-8?B?SWpOUGdOQXVGZlRDTXZDb2hGSEZ5SkdzNnQwbml0Ykk5cnJpMEFjc1puNkJU?=
 =?utf-8?B?SW1Lc2FENnJEWXdpdGlvRmcvMmF0dW1oREpTUDRkcDJuVnhJbkFXZkJNM2lQ?=
 =?utf-8?B?UENPZUp3UWZqdTBwR2R1Z1R0TzFvdndXM3pwUmg2bEpFNzk1YnVtZFdNVGg2?=
 =?utf-8?B?SkpQZkQ5b3J3QVZWNFRkb0hCaWpPQUhaZEQ4NVF6L1BCR0N3bGhTNk50U01p?=
 =?utf-8?B?ZW5NWEtQVDIxQVZ1dzBObjdIK0lhTGJEUHpDR1p0bWJTYXdDSWdZZmFvejlW?=
 =?utf-8?B?QjdoV1VHa0d4TDdWMktSdzlLNWVNL0JvSkVZcWJueHE5aDcrczVSSHJtYkxF?=
 =?utf-8?B?VVpXS0FwRCtzRmp5RjUwWnE3WWpKZ0NQTkxwOVM3T29GSUdpUnlueFM2Ym0y?=
 =?utf-8?B?M0drOVFJVWc1WG9qaFlLeFlSSGNJVXBSeER6YXljTHNGeHpkTTFoSnhUSjU1?=
 =?utf-8?B?a1dlYXNmWE5LQ1VLbjZ6cjEwTi9RckVCa0ZNNXlGWUtjaGI1VllWdk51Z0ZS?=
 =?utf-8?B?R0paVWJNVnVvRjBFSDZVdHg0L3Q2Z0pDUk9pcG4yYW9jYzl4MTNaeFlianVn?=
 =?utf-8?B?UmpaVFpYejVtYXR3WnRPT3lsUmgyVFVueHFpY3h4NWtsU2ozaW1aSFFXQnNj?=
 =?utf-8?B?VVNFZDlsM3R3czhGOTdGeVBmdFZJclluUThiRE5jMTg5Slp4d2ZhUWMrTlJ1?=
 =?utf-8?B?ZjFBZUhvZHFRdGRsaWU5MkhCcjIva1pMSDNkeFZ1UTJ4cUh0amNJTVNzUXQ2?=
 =?utf-8?B?ditrblJ2TUsvcmVHMmpCbDJscUZKVXJldFYvMzRSZ2N6eFpWWjF0T3RsQURt?=
 =?utf-8?B?Vko0ZG5VK2lBRXpUTmJ1RzhuSE1seElOMUVzNjN6OEFmcVRUNUttbzV3bXFB?=
 =?utf-8?B?T3M2L0tiZlZDeEZ4TlRxV2JOejd0ZHdCcjJ2NC96SE5EQ1YxSkF6RzV4SFNo?=
 =?utf-8?B?Q0YxNlY0NUxmYzRiRTNaZVdBdkZxUlE0MlVsK3FXZXQzZUNXNXFpSlRyR3Fr?=
 =?utf-8?B?U2pBVjF2OU93VEdjQS9oTnd1ekcxZXFQczZpS2I5dDNwVGJIVU9lMmczZVJE?=
 =?utf-8?B?VENHempvOXBjSmtBL3dKZExNSmo3Sm0wK1BLczdRZUV0eUp3aGpkWUMvTGZh?=
 =?utf-8?B?MnZoY1Zmd2l2NWRITHBVd0lqV3BNZmJraVVtd2U4ZUt4WjhQQ3JieWZvVmtL?=
 =?utf-8?B?QitwTklEZ3gyNWFSbjUvdHFtVEVYUTRsb0oyYkFoZE5FOHZYdVNScG8xODhW?=
 =?utf-8?B?Ymh4MDRyS1hBWEVjY0RmZk01RStVSVVIZ1J1WmhtcE41a1c5ZGZ2ZHQ2RlFk?=
 =?utf-8?B?R0YwSFVpVnZPeGxOM29ZajZERGVhbDhKVTRXMDUxN1lHWHFnbUxwazRyRkNU?=
 =?utf-8?B?alNiZW9QZ0JjVE8xMmJYZUsyTURyTUxuNU9lZ1dMem1FRjluUHRCNG80WDAr?=
 =?utf-8?B?MWlmWDBkYlc4SUxEcUtWZERsb1lmakplNUE0ZnMzbU5IUjBjNlBaQ01SSEQw?=
 =?utf-8?B?aTRWdzJQaHd3dDUrN0Y4dUFOcDVyODhRZlU2YjRGU3ZTSFlqZUlJNXJHaHV3?=
 =?utf-8?B?eDJGSEdITW5jR2NPenlDeWtFKy9hNUcwRm5GMU1LbHJpa0RjVnJaRjlOZXhr?=
 =?utf-8?B?OUFDRG1rdEZUVWNQa1hxN1QvU0Y5WXI0Z1R5L1ZXQUdQQTlVeTZOTUwvM3pK?=
 =?utf-8?B?R1pzaVdZKzJLU283d1pGVTZKaVJmU3I4SWdyOGFCWnVtcm1YdW1pNEpWTEdu?=
 =?utf-8?B?Zjd2QzM0WDh4R3dpelVhNllFd0NHbjV0YUpMbm5NeUtqeW5aM3A0cURaTU11?=
 =?utf-8?B?MnlKU3g4OVlsTnQvL1daQlVGSzdtSUs3dCtuWTU0WXd2T2NPYXNEZ1FYRklD?=
 =?utf-8?Q?f0yYepBaeGOwQKQo=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	xLyLPmUMrA9/9Itq1gLawFc21ZI6Pkdwop5pfTaAIca6ziaio6CK/iN36SYsD+ihd/VSZGPdfDNuwrVp2WN1+0qohzF6BdM/gJ1/U8Nbkmrdhx5p30xANWR4NmDpLN67aHgPy29O5jrLg12SDG1x+9pYiHLorRk01sQg2IIVAninVOMw5j40fzDxkR7wNPq/U961L1Js3hC2/yd+tP47iEFWcENLgBWmaAJIYmPZAIJ1hbcbjL0d9ZIG3Z//5+Bvum4doj+kiDpEtt18qiRE/noTNLa1X4Eo2BFiw+RtAhG7DwKBqAuiiDhi+8Yhq+gekBcfNCdT6v/FwixmFYi0gRxlGHWq0sgil0WO1YG557FcDvUE0iaVF32j1Y5roct2DboksqzN3+TJHt4nM96lhCN1CMlXxgljEDQmMEWkN9U/nKh9wbfRYxO+P2u+McXhOa3MIn9yXQsDeMh6XyQQRQBjScE3iozgNFs3GGMQKBy3Fk9VMXsAYtjXBO1tYzVs6QSWuc3KTq/uxJN18iFqGOW5AZGST1pa9d93fMHkBeSx1yQVxa9psNghFuWs74HfAQN2bEHHy0Cj/rZ9Huze5GHwbrDX30Mg5TTFNZ/YWNU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca5cc06d-203c-4992-bf50-08de4e94b013
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5328.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2026 09:02:45.1863
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: itN32hUcwnMbrTrKZDMgrBAaLNc1g/H9xUGYpxWol6paKTzBZS1/FdsAvvCH03H/hPMExGtIudck6F/aOAo+WCccZ36yeKxqn4Vqof+Waao=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4291
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-08_01,2026-01-07_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 suspectscore=0
 mlxscore=0 spamscore=0 mlxlogscore=999 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2512120000
 definitions=main-2601080060
X-Authority-Analysis: v=2.4 cv=EanFgfmC c=1 sm=1 tr=0 ts=695f72b9 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=vUbySO9Y5rIA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=M5GUcnROAAAA:8 a=P47KfbQMDw7L7twetUQA:9 a=QEXdDO2ut3YA:10
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: Gq4wOKvvesq50DDb7qrH6AlamluRsZc9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA4MDA2MSBTYWx0ZWRfXxs7n5OOera4h
 ekXq7LuWyh23owhB1zdeRSGLoNpgIRkIKhQnDYHPWHDWf7PW72cRLd8Kg1uLYRpM+FU/fLyKpWK
 WaI/A7Dy6KkO3vAlvyqt4fEhmbjSp/7DaYY0zMLGwSV9g1wwpI0YhzlCtKoNG5hiQqlevdgu9GA
 e7zcNT2Mpq/s5Tr9r/Ay1aY1RQbhIl+tYuApM4ZpQkO/VFRJyWjj1ZBvYtpX32gxzgF36BbuGFR
 EovfOrv/abkHlOKv6e2T4KA4RmIGD5oDcaaQJ9GlmRmJiLa1P5xqaMQXcUDL3aXnpHNerLTT4gZ
 XcII4hx8uqTihs/BpAEiTxghW5vNJ2X3Uxz2IX6dtOLvmpUr3nrRwYtJ7xACSPPwgz7IKjEifId
 OnSzpn5bT0GjBHuLv0r9F1OSUV/rIvPvyquDHGeFV6pWPgXjeUqtT5Q16rDCySwHAPF+R2WKWsI
 PZT/9vcrD5QgPu0hLlA==
X-Proofpoint-GUID: Gq4wOKvvesq50DDb7qrH6AlamluRsZc9



On 1/7/2026 6:53 PM, Ratheesh Kannoth wrote:
> The Marvell switch hardware runs on a Linux OS. This OS receives
> various messages, which are parsed to create flow rules that can be
> installed on HW. The switch is capable of accelerating both L2 and
> L3 flows.
> 
> This commit adds various mailbox messages used by the Linux OS
> (on arm64) to send events to the switch hardware.
> 
> fdb messages:     Linux bridge FDB messages
> fib messages:     Linux routing table messages
> status messages:  Packet status updates sent to Host
>                    Linux to keep flows active
>                    for connection-tracked flows.
> 
> Signed-off-by: Ratheesh Kannoth<rkannoth@marvell.com>
> ---
>   .../ethernet/marvell/octeontx2/af/Makefile    |  2 +
>   .../net/ethernet/marvell/octeontx2/af/mbox.h  | 95 +++++++++++++++++++
>   .../marvell/octeontx2/af/switch/rvu_sw_fl.c   | 21 ++++
>   .../marvell/octeontx2/af/switch/rvu_sw_fl.h   | 11 +++
>   .../marvell/octeontx2/af/switch/rvu_sw_l2.c   | 14 +++
>   .../marvell/octeontx2/af/switch/rvu_sw_l2.h   | 11 +++
>   .../marvell/octeontx2/af/switch/rvu_sw_l3.c   | 14 +++
>   .../marvell/octeontx2/af/switch/rvu_sw_l3.h   | 11 +++
>   8 files changed, 179 insertions(+)
>   create mode 100644 drivers/net/ethernet/marvell/octeontx2/af/switch/rvu_sw_fl.c
>   create mode 100644 drivers/net/ethernet/marvell/octeontx2/af/switch/rvu_sw_fl.h
>   create mode 100644 drivers/net/ethernet/marvell/octeontx2/af/switch/rvu_sw_l2.c
>   create mode 100644 drivers/net/ethernet/marvell/octeontx2/af/switch/rvu_sw_l2.h
>   create mode 100644 drivers/net/ethernet/marvell/octeontx2/af/switch/rvu_sw_l3.c
>   create mode 100644 drivers/net/ethernet/marvell/octeontx2/af/switch/rvu_sw_l3.h
> 
> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/Makefile b/drivers/net/ethernet/marvell/octeontx2/af/Makefile
> index 244de500963e..e28b1fc6dbc6 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/Makefile
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/Makefile
> @@ -4,6 +4,7 @@
>   #
>   
>   ccflags-y += -I$(src)

redundant include path

> +ccflags-y += -I$(src) -I$(src)/switch/
>   obj-$(CONFIG_OCTEONTX2_MBOX) += rvu_mbox.o
>   obj-$(CONFIG_OCTEONTX2_AF) += rvu_af.o


Thanks,
Alok

