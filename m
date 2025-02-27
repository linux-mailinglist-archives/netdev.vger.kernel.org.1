Return-Path: <netdev+bounces-170101-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A0FE9A4746A
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 05:26:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 98E0E16F3A4
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 04:26:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B912B1D90DB;
	Thu, 27 Feb 2025 04:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Y3M/Hw+b";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="QTblVV/h"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3BFF1A38E3
	for <netdev@vger.kernel.org>; Thu, 27 Feb 2025 04:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740630406; cv=fail; b=ao4BBMTRx9lrTr6jNldfGWh8bcoIl/gL5ozsctmvuGckdXDBI07OXJiK39hUYyPBmBaZxLoQ7ZKwXk7D79Km7QD0m4Y0VVYo41G++W8rhBr+vaMutgO00dF8osy72yy2QGEBC/6RoOQbdKJNKI2XHbGleTVtph2TJoK5s2aJ6Yk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740630406; c=relaxed/simple;
	bh=Mew04myXvH4nSPwDYay5XdUa1fe440BDOgwc9l1eaZM=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=SCYnZhWO6Ko+awBvtUbwv9fI5+o38bKhKIsdNsMiarW3+UxbEbuTAVjOXCNweMW97iqfQZ79tZIxnyMZPbbxVgaEU/nsUvekIfJsvfGMscg3J9xUNeA4twLFBPpG73QuHEZt9cjii04H6ho/JKjI6WkBveigeKalRnkcCVw/7Q4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Y3M/Hw+b; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=QTblVV/h; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51R1g9hB021117
	for <netdev@vger.kernel.org>; Thu, 27 Feb 2025 04:26:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2023-11-20; bh=Nw2aaSNGCJZ45uPN
	T4IKt/jwShYFhQ7MSdMOR3/olqA=; b=Y3M/Hw+bpa/uHpIqo+Bz4xwe7G2Pu7/I
	qvnC8VefkmvYHbL5pkuDKQkSJhEErzlfjlVxR75LVt5XTk6mBGENnxrMedAkuYmS
	+LK6jQ5XZjNLNdUG70oBVlTrPfPQpMibOjjRgWa99JvmX8k0KNbrou61WkISTYln
	WXeSt7btOjEd6X0Gg9d83CUr8ZaDYTBNshGDRjSd4DEVc/xnfSv61VyHXSTTM7uT
	kW/moMLDgBPBSPdHGyW5kF9Qeo80pu/TsGKbbUXaRrNH7ieXgEjNykhEkVeVMCgn
	eM5W+IbNHJjRvWZ69JF03ZwZG4m8qlIADG/Pz9ZkQq3/lP7+IWESNw==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 451pscanda-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <netdev@vger.kernel.org>; Thu, 27 Feb 2025 04:26:42 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51R2vpZN008222
	for <netdev@vger.kernel.org>; Thu, 27 Feb 2025 04:26:41 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2045.outbound.protection.outlook.com [104.47.74.45])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 44y51hnk8r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <netdev@vger.kernel.org>; Thu, 27 Feb 2025 04:26:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I2MlP7VPMm8HpFlrOQ+Bfig7y8rf/8IQrZ1x9AvtN0IQg12YRgvCnSJM3qsIgg3e9O49ovTHRyj8jM6qKD40OgULrl04q4Y3jidpzUFHjXJX+ENH0Mq3D0fXuwa9gV+YzMZurf7k8DYEmmsizHplQDOtyS2TMJpvoRs0brakIRy13cLnLbK3DJqUXxBfFFVosgJvTQC0uiVSUw5kU3/E+PRX+Sn2QhaHqTvj/V8Di2LKhihxRxseq88OzS8op0Wo9yYvbdKtX4KdWh+F+XeZxjAtFKLBUNbqphFCssVxh5E89L6XLs1Dlwon4qzmpj5hCvBbXd08rNhNa/TSWjhy6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nw2aaSNGCJZ45uPNT4IKt/jwShYFhQ7MSdMOR3/olqA=;
 b=n2YLff1SlFZ7C4Fk6d1+2WboWkhuQ49cQuxMpzA87KnsD05sZEe+x+9iB+CPxHvMwH8Vn4HJXpLiL6RyX30RXO3c4LzXFK5IqhEtF9rPsvJxS6/unL02fFGGAHNjiZsQAvROamtYhuMcHSugpb0Xk5h9t4Fw/o62YMwppqWgpUHuUf5g7NLCNXx+IM0as8udCo7JpljqG9m6wAQVOAMaRuPuaaaYnPiT2Aj6p/9p6pFeGemzYy2LW2V+kHoTTvA6quTgb9N7PpmZ3KmblKE3nhY5Py06VkvBDv5uFOyv4qScQ3JL/Daq5I/86wcd83vhiMd44q+ZldAR0g58+ijLtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nw2aaSNGCJZ45uPNT4IKt/jwShYFhQ7MSdMOR3/olqA=;
 b=QTblVV/huIPVqw3OP/BkvhGxJauXAHWveM7OEcMQFV+wtVJkE/WTpUZBNx1TeNZqrXpSiyYwAYYZx3bvLtXCuo/WB92Ya9himtpkCq0ro6kLiY3yXXuV8g+sXr606bHn8CGeXPFqYLM0NRYC4ybhUNw3IXLwUN/ryQeyFUMNw5Y=
Received: from BY5PR10MB4306.namprd10.prod.outlook.com (2603:10b6:a03:211::7)
 by SA1PR10MB7587.namprd10.prod.outlook.com (2603:10b6:806:376::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Thu, 27 Feb
 2025 04:26:40 +0000
Received: from BY5PR10MB4306.namprd10.prod.outlook.com
 ([fe80::b78:9645:2435:cf1b]) by BY5PR10MB4306.namprd10.prod.outlook.com
 ([fe80::b78:9645:2435:cf1b%7]) with mapi id 15.20.8489.019; Thu, 27 Feb 2025
 04:26:40 +0000
From: allison.henderson@oracle.com
To: netdev@vger.kernel.org
Subject: [PATCH 0/6] RDS bug fix collection
Date: Wed, 26 Feb 2025 21:26:32 -0700
Message-ID: <20250227042638.82553-1-allison.henderson@oracle.com>
X-Mailer: git-send-email 2.43.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PH7P220CA0059.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:32b::23) To BY5PR10MB4306.namprd10.prod.outlook.com
 (2603:10b6:a03:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4306:EE_|SA1PR10MB7587:EE_
X-MS-Office365-Filtering-Correlation-Id: 667f1d32-64a4-48ba-a709-08dd56e6ee6f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QUwxZnVUd2dxbUNxakdTY0k0SGVPZDNoY1hXQ2JxMmtYMjcwdnMvaUFuY1pi?=
 =?utf-8?B?S2dpb05IdWltMUV6dHFWVE1IK1N5WFFvMHN4dUVSTGNPdnFwMC8zdmwyME9p?=
 =?utf-8?B?Zis1R3hSWDVWWHRrUnpsR3BUU1NWUFlpd2w4ZXd1VVEvbWQvTkJTUkY5YWo4?=
 =?utf-8?B?N0JqRkUrc0U5b3pndE14OStrYndtWHhuRGNMS1gvUENmMTQzWTMxaU9aRmwz?=
 =?utf-8?B?NTRUOFJBME92UkpxWGg2YlR6aXVpZDI0QnV2WGw2ckFnYjVMZ0pPRlhlWmc4?=
 =?utf-8?B?cXZRZm9sd2NpRkQ1QTNxZWV4MEZscGFZNFRFeE5lbjREbklNeWEzMVpWazFq?=
 =?utf-8?B?U1lsTUFpZ0poOHNZZUNDL2FRNHpHM0ZiSU9kdis3dDJaOVVzMTFCRWdpWHR1?=
 =?utf-8?B?RVZ1ekJScVNUV2VoelhaSC9LVHhqbmxZZWZvQ3ZBLzAwZjdKS09lcEhXZ3Fq?=
 =?utf-8?B?THE2YXdSclBPT25hMUg5T2djWUNQUFFaUFNabEh5ekFrSC9JS2ltTXlBR1Nh?=
 =?utf-8?B?dGxWdXN5bTBVQXBHRnNYby9OMnBac1IyQWgzdnQ0cXdqNytWTElLTmRud1I1?=
 =?utf-8?B?QWZxbkZLNFhmQU9CUnFvNnhFRTZzSTYvanZMRDRpMjdhUlRKRlBDSVJqdWxL?=
 =?utf-8?B?MFhPM1NYdzFmU3REUHV3ZHVpSmloM2xjbVFkZlI2WHIybVVMdm92Y1hqSjBt?=
 =?utf-8?B?R2JKcUszQis0VUVIbjFGVm56c0V5a3UySHNwdCtETkdLb2JtUVlRZDgrZjRt?=
 =?utf-8?B?ZHpZZHEzR1krUEpUMm9yVS9qMlYvbWJad2tCSkd6anNHT0ROanN3UEw1SFdT?=
 =?utf-8?B?UWQwV0oyYlBFSlpLTEQ0R2RhTEZQemZ1bzRIZkpTZVBiOWdqNHVMWEJLeGJF?=
 =?utf-8?B?VWdjYTdhMy9ZMSttYUN4VGcyT0tOWm1ZSU5SQUp2STJSM1J6aXFpWmhvYjlC?=
 =?utf-8?B?UWZTdGpHaUlOZnRrT2FGZlpnS2s2MTBBNWVySjJ2TmxXTWU0Z3BJVkgxTEpO?=
 =?utf-8?B?SnlobHEwMDR0MDNUTmtBaFZIaDk5OU5Pd1dMVk5SUy9kSHlVZDNIaDlFRW5i?=
 =?utf-8?B?dDZYQVgrN0Q1WmF5RTZ1NVVVWUVhMGt1bThuSlprM3B5d21UcW5TR3l5SHgr?=
 =?utf-8?B?aDNMeGNnMTlCQU94azVKSVJpS1ZYWTdZbkRSbTk2YzdMVERvMXhockllUmor?=
 =?utf-8?B?NVNkNTd3RTI4WS8vZ3ZRdHoxS1BWOUxWdjBWcnd6a3I5UHZoZktaWVp0QkZT?=
 =?utf-8?B?RDBoN3EyZDZaZ2RMdXRPWlBEQVFSMDRqRjlRaVZqbWFSOEF5VUVRN0huTU4v?=
 =?utf-8?B?ZnRCNnVFdGl3WlFPT05TS0pOeGxGeVArdXZRSVlUUmtDdmROdGFLSkhHajZ3?=
 =?utf-8?B?UzcvdW10b05zWHR5TlhrVzlObFZDR0hhLzZCRWFpSGtaVDBMaGlLTlFDelha?=
 =?utf-8?B?YkRhTElyc1hldDhZSWZmNjlEVzRjR0NCcUREaFErVjVyRk9oOUNDbEQwbmEr?=
 =?utf-8?B?WTdtYnpXZnMvcW9nZjkxR0lrNFlRZUc2Wkp6c29RZVFIRTFmSk5Lb3BPUytz?=
 =?utf-8?B?TkJwbFZvV3dKV2tJREJpQW40Y2dheFBseU9xR090NGhjZXRIRlRPUHhVMDlT?=
 =?utf-8?B?STRvOVhnbHp6NTdPZUZYamczS212MVdvdWlNVFVuT3BWeXI4UVNVWUV4QXgz?=
 =?utf-8?B?bnNFdlc0RDVDS2E1MW56bXQveVhmMW1vbFp1d2hKb01KenpJSExEQXNGaXdM?=
 =?utf-8?B?bUttVlkvSTdZa3FlM2RGZUMyR05xVUNzcnBNV2c4RE8rcUZpalBnR2xWSEJq?=
 =?utf-8?B?Y2pkT2w5eTlvVm0rWU5yM2JKUFZrckE2UmtCMmk2K1BDOUxRYkFtekxSNzFh?=
 =?utf-8?Q?YUIhfVsCTZfkK?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4306.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UFNNTDk1TktxMjhGSXpKdy80dFVuT00yaU9tU0IzQ0s0aDdXNE5hbjFuZ044?=
 =?utf-8?B?VjRacDZpamNTTXpwRHo3cGtrRG53aHc0ZHB1YXNTakVseTdvNHdNUjJEVEVx?=
 =?utf-8?B?V0lvdWRkV3IrTkdkRFp2dEV4WXN2QVpwUDMxWlk2QjA1a3U1YW5vTzJybzBG?=
 =?utf-8?B?bDJGWFYzUVRuYTQzdkh0ZWR3TmhvL3QyS1lLU2tibXJKR2tweUF1NTFmLzd5?=
 =?utf-8?B?NHc2bi9YVVFVWmFaS2JpZlhESUovMC9CbHBzRGtzRDh4ZXE1MzIwSFFEWmdH?=
 =?utf-8?B?TmRmdGdyYSt6RHN3ME5JSWJxTDBuV212ekV5S2N6SXRtcUJINzR1Wm5iRXVm?=
 =?utf-8?B?RzdDaE5iVWlsUmsyU210c2IzNGVwNWRsZU5jOTNIelZadkxNOW9Pak5jd05r?=
 =?utf-8?B?a3NxMUw0WmdpNVVZTDdKWGpiazJ2Vmx3aVF1alplRWwwMjBuekp2b2NhVGc0?=
 =?utf-8?B?Z2JKN0RwY0RTaUVqSmxSVllTQnRvRFNFMjBpSWhpckZISWkrRzZaWEZTVzlk?=
 =?utf-8?B?dXF5WnVLaWQwblJoakJ5dExoc0ZBeGpNMTNhRU5acEloNVZPNHY0d3J0NlVk?=
 =?utf-8?B?a0RMejJEVVBoVmZHR094dWtJUFpxMTZJWmw4RUJSS3lWa24rc0M4YzMveWFi?=
 =?utf-8?B?dHNyYk9DK0o1WE9Yd3NJS0NVSnlBQjYwVlRKdFB2Rm5MRU10MDFheWJUaEdu?=
 =?utf-8?B?Q2c2VUNENElzU3gya0p2aE9JK0o4RTJ0R3lpeGdaQUllWE5JZ1ljUkpscmVJ?=
 =?utf-8?B?NGZlNlRSRmZWUHhGakpwcGl3eUxWdXpSSVlMbzJ3YVFiNUFIS1BncTRPWG5P?=
 =?utf-8?B?THFQazRJWXprQ0dCakxaS290RXJHL0F1MmZhb253MHoreTI5N3FPdWtlR2lN?=
 =?utf-8?B?RExxeFFlYUtTRUcrNmdJcTB2YVhHK3cxYVlyYVdNcDBHQzBMaW9DaXowVk1h?=
 =?utf-8?B?RUhxczBwU1pLc2pCdDk1dkR0Snl4NWdoQm9kM1hNNlpScUc3V3EzcU1sWU9C?=
 =?utf-8?B?SkNGdUtFdXFxWlpCUmd2L05oZDRHVWdSblZJNndONm1kMkVBRHA5S1VDLzlh?=
 =?utf-8?B?VjlCVXNGRzEyU25SQ3ovSUFDR1h3RkFrMGlkK1A2KzJNYzVyaFk4S3NkYnJY?=
 =?utf-8?B?Z3ZxSGFFU3ZaMkdkek1yK0VqbzUyc3FvVmRCZFYwQ2FBa1NYTU5vSmZ2UWVR?=
 =?utf-8?B?RTBCOWh5aUNpQ3NHY0Zaajl4TnZkbmFKM0t3NGo4cWZJUC9OeWF0UjBlaGNZ?=
 =?utf-8?B?L0hUTlloejNZdGpiWkwzNGd0bnpnbFdCL1dCN085WUxWcmlyNTU1RmtqVVA5?=
 =?utf-8?B?SUxoQi9UdEovaHJ2dkZNSmRkY2xwdUE5ZGFrL2FaWEdYeVBtS3NSQlZLYm5t?=
 =?utf-8?B?NjNiQUhyTnArOHRuREhtYzg4NnVFTGcvaWo2WkRSN1FvTFJhNVBKQXB6THBD?=
 =?utf-8?B?TG1naEFXd3p2TDZ4UlRHWjc2RktkSWFlcUdmUHUwRVdHRmNXTEV6MCtYVnla?=
 =?utf-8?B?cmNOWHBBK1R2ZXNFSW9QNDZEZXRlYnliR3JWakhnYmMxWFB1Qnd5ZFNjbFhl?=
 =?utf-8?B?RENhVlJTRkJaVDNvRU1mU29KRnNYK0NKNjR4QjJYcVlBblp0WWswT01Ndm1N?=
 =?utf-8?B?VTFLSllVZVBNdTB3UEdPbWlzcVp5RUZMRE1CcWRzZE5uV01YZ2JZa2VISFNY?=
 =?utf-8?B?aGxPRldDaEliRHpRZGZIZEpaUlNBWWdvUHlaMDVLcFJreW5PNzFEbEo3bStw?=
 =?utf-8?B?UXBISENIWmJqZWxLdFZ2U0ZIVmJib0M4enU2ZThzaW54Tk1YcitqZFVtNEVJ?=
 =?utf-8?B?RDRnejVMeXI1VEhhbGF3Z1l3TDZQRE9ZanRjV0JST3pHVmZPRitNZjBobnJq?=
 =?utf-8?B?OC9GcW1CUVFFOFJ2YWVXTlZWWVJCTWM1NjlsSGkyaG0weGxVNzNmY0ZNT3M1?=
 =?utf-8?B?dnJpd2ozSDBoRCtvU2d5Yk5HekNZY3dyTDFvMmJUeHJTNHJnVXMrcE9rV09P?=
 =?utf-8?B?WDZoV2I0NGh5NVVUUk5OOFVuQXBKUnJKS0Y4Vy85VkUreVQ5Z0YvekNlZEo0?=
 =?utf-8?B?VGMwYzhnUmRSTlFNZXo2TFRWbEVyUTdmS3ZlSWFhcEZoTGJoRnhwd1ZZTmNG?=
 =?utf-8?B?ZzJSZmgvdllTOWtLYWRJQUk1ak9VMXBoNWVEYXprVjRuNzZVYmR0cHIyQWdt?=
 =?utf-8?B?T1E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ODLdKuKBcMoPxuc+aPpc+iyQ9xfubHpRKwI1Dy3DKdPQmnDc5Gjm01886MOF3Nx94CDmbZOVJtE3XVoeLO0ygjU+fxGJ/g1IQR+T0K8c7w+Mh5+ZRGV/nDy1n4BlcOb5cqdmn2soWgWkPgYPv8fe7iTQHh0aA3WyQ8QuPZ5zM7kj3q0FibM4fIK0s1bEBSKGr1hsoTTuB307vUorzwEgLDbRFJviarzTD2py+qJBPNXpiq1ltNFM4mUlxCxI9wkhzfu7aClwl3ROSnK7UklwYBiyYsmsKrOtst10Uoutn9bqs4xvknUAhnzG1smgyNext4h+Oq5bLYXVSapbdo15BXNWGHpx7FWg4h93dlYm3f7iivnacp5nkWEgBjJq/X0PuG5p/1oo52sOFS/5z6sVNHEo1V6DPV5wJSPhc+kLPSo3yr+yi7IHTFWBY7pUQ+OXR3MqxAMY8YPVidFQcKQhZUN6GKgLSYh2+EhEhO/I/VXWNvxzRlAM9GcF+Av7lhGoE+GQxvwRwykbnDRQBNnoj6rB+19ekG6og1H5FimESeGK0FfeRzpGDcRB6O3NOWBmtVIQt1FiJaJ18mSIjrV+PGYIGal3DIz57gUTYtp+L+0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 667f1d32-64a4-48ba-a709-08dd56e6ee6f
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4306.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2025 04:26:40.0093
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2L3JRUGQMX5/VWqhR1rn5ajYmIpYXPZJ22HVPmAAKvGd20NfF75LlBqArSA/FU+fKzdSLkpB9vNrroruTIEAsXFCt7hq9NEG2qyHy+87Ieg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB7587
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-27_02,2025-02-26_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 suspectscore=0 adultscore=0 phishscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502100000 definitions=main-2502270031
X-Proofpoint-GUID: A6yx9EhxQ7nQXUSa-dGNWp4sd-6XVZ7j
X-Proofpoint-ORIG-GUID: A6yx9EhxQ7nQXUSa-dGNWp4sd-6XVZ7j

From: Allison Henderson <allison.henderson@oracle.com>

Hi Everybody!

This set is a collection of bug fixes I've been working on porting from
uek rds to upstream rds.  We have some projects that are exploring the
idea of using upstream rds, but under enough stress, we've run into
dropped or out of sequence message bugs that we would like to fix.  We
have patches to address these, so I've ported them along with a handful
of other fixes they depend on.  There's still a few other quirks we'd
need to correct, but I think this is a good collection of patches to
start with.  I'm still learning much about this code as I go, so I'd
certainly appreciate a good review, and I'll do my best to answer any
questions.

Questions, comments, flames appreciated!
Thanks everybody!

Allison

Gerd Rausch (3):
  net/rds: No shortcut out of RDS_CONN_ERROR
  net/rds: rds_tcp_accept_one ought to not discard messages
  net/rds: Encode cp_index in TCP source port

Håkon Bugge (2):
  net/rds: Avoid queuing superfluous send and recv work
  net/rds: Re-factor and avoid superfluous queuing of reconnect work

Ka-Cheong Poon (1):
  net/rds: RDS/TCP does not initiate a connection

 net/rds/af_rds.c      |   1 +
 net/rds/connection.c  |  19 ++--
 net/rds/ib_recv.c     |   2 +-
 net/rds/ib_send.c     |   2 +-
 net/rds/message.c     |   1 +
 net/rds/rds.h         |  59 +++++++++++-
 net/rds/recv.c        |  11 +++
 net/rds/send.c        |  57 +++++++++---
 net/rds/tcp.c         |  39 ++++----
 net/rds/tcp.h         |  23 ++++-
 net/rds/tcp_connect.c |  23 ++++-
 net/rds/tcp_listen.c  | 205 ++++++++++++++++++++++++++++++------------
 net/rds/tcp_recv.c    |   2 +-
 net/rds/tcp_send.c    |   2 +-
 net/rds/threads.c     |  34 ++++---
 15 files changed, 366 insertions(+), 114 deletions(-)

-- 
2.43.0


