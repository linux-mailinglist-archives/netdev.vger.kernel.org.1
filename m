Return-Path: <netdev+bounces-86356-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A56F089E739
	for <lists+netdev@lfdr.de>; Wed, 10 Apr 2024 02:49:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B0AA1F22389
	for <lists+netdev@lfdr.de>; Wed, 10 Apr 2024 00:49:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C78838F;
	Wed, 10 Apr 2024 00:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Am39TZG0";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="C71B7J/I"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C3D68C09
	for <netdev@vger.kernel.org>; Wed, 10 Apr 2024 00:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712710135; cv=fail; b=FEeCa/z3uuBLuROJYxpienHIDN3YN2lXs5EuCwtx9w7BXOEyvYBgF5sFSCjrUBhz9DORG85TsN/jy85v6wcqK0JyCuACQFJf1PeP038qFNL87Tc7X+33NO2u2KDzNP09KFjGO5t7yb+bxAj2tXhSDcMN49oQSQWeO2BHNIdB9xY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712710135; c=relaxed/simple;
	bh=Sq3nsLFnW6pIK4WXvth1SVvbOkCdmzjQ6fdx0Di7bgs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=QkqytXjx5aoUg3wlas+yac0tcaFU2LF2GNa2eYTo7uX/FgTi3WMfLPdvQ/UdzSMPevJaoTM3a9jXIhmt+Wx655a4gkThY3YJR/r892KNQkG1paZje2C4oIol+RqAShqZUM1G+/g3w182oFu7mF0/Lnpo9jh4Ve8H9UzrFcAswsw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Am39TZG0; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=C71B7J/I; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 439NTxCo029283;
	Wed, 10 Apr 2024 00:48:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=dkFg88ZMhTfH95cNRs3ZTOClik7uk93TOCMCHtwvOLY=;
 b=Am39TZG0YLOXzX/qnRjB/a8ZT1Kacw0R0OYTNcdaKE+U3m8N/SvpulUr+5WmXTjKGb3o
 us0gpkkXTaiq4MPfbAgPkUmOLDHig6me21ld+YWuTx7cGHS2LrEvIs6CId9RRp4fE8HU
 QbDUMUcnPRhPdLnSb9hKJy3XQrG6KTXRaSO+G9PwGUriVOo8KJun7qsEHfE2s0JK+WqH
 7go7eaCaH1uEGiMlXiPamgbvTI9Kj/XLGzCiAa0I6uzuSMrsT1OrSUIh5xwzpPteqFbR
 nCimE5i7rc7ro/NEWwfbR4DOGhJEbobIF4WOXgplIGJXyFlAyT0csYHR/22lIGDl9iX5 cg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xawacpa2y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Apr 2024 00:48:43 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 439NOt54032367;
	Wed, 10 Apr 2024 00:48:43 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3xavu7xfnq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Apr 2024 00:48:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eEHW/tYe22xvGSRzw7jlXM+rNukG3DUuYstXwu+jU8VmmzVsYutKLoCIx83BhaH9JmINm+pPs71psQ7xTthk8uQPM+D0S6BKP137DhB/IL+hvMxX4w5m87URnHMUEC37ssR7VwXc0EjGXRekgOMiTtWb34NtQD1bH0xoGThdryyjxC0jB7BENGstcu/hgbEiFn54IP9MIgct4ncv9vF3nLMgAkCASrrmjoWqXxzQB0rSjZ/Cc1iTRGFbxkvD/6gdljbX96nv9U6K9n+9It+X+htQxUjftNvpdA+Ba67c07k/kjmmXvMXbXFKrz3vKiaMCD9YEiUG0E1b70uCO2jEXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dkFg88ZMhTfH95cNRs3ZTOClik7uk93TOCMCHtwvOLY=;
 b=nL3GqCTVQBe2vJ5PnszdzDUUOxpOIfIXPyL6VM5FOWQ1iX1vmAB/OwdYTaj8jHlW/zOLNp3lQVnc0E40IfzSzHSlCmYqA4HcP3W7jdXSGx5DgYFF2eLsQNT/HMjaV39p8E2nx3NQQ/2a12Q654lebMIQ9KUdLyVHDUwl1zm2AM1ERZf0wjZE42kTsFFFCA3c1O+BRP1lLwF18roHhSPcRR67Km8CjaJdAI+3gJECsv14s/yW/qUuMC+HDoDxFfJ6wHyf+Yr2bJ+gJ4bLtV/7EryG1a45Ogx2FJGt0v77TpKzQw8VIoHe26AdA7uAO8h5u60n6W37fUlQw85ttHzxjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dkFg88ZMhTfH95cNRs3ZTOClik7uk93TOCMCHtwvOLY=;
 b=C71B7J/I0rwdshn4AaNegi3ECMAi1Xqu27rmNzbCeMeZsUSOYplKyNuG0069qfMa37V/RKWCGEw8YI2CW73jyS8BTohkBsvhNyYzULj2wjPaEIEB5j9LyXzmOlyGvWxi4YfeZYpHYuy87IB5YCLp1BAyrC7Wkr/cP5gIqE9Zloo=
Received: from CH3PR10MB6833.namprd10.prod.outlook.com (2603:10b6:610:150::8)
 by SJ2PR10MB7016.namprd10.prod.outlook.com (2603:10b6:a03:4cf::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Wed, 10 Apr
 2024 00:48:41 +0000
Received: from CH3PR10MB6833.namprd10.prod.outlook.com
 ([fe80::40af:fb74:10b1:1300]) by CH3PR10MB6833.namprd10.prod.outlook.com
 ([fe80::40af:fb74:10b1:1300%5]) with mapi id 15.20.7409.042; Wed, 10 Apr 2024
 00:48:41 +0000
Message-ID: <22994084-e0a2-4829-b759-73e98418b510@oracle.com>
Date: Tue, 9 Apr 2024 17:48:37 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 net 3/3] af_unix: Prepare MSG_OOB deprecation.
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        kuni1840@gmail.com, netdev@vger.kernel.org, pabeni@redhat.com
References: <bef45d8e-35b7-42e4-bf6c-768da5b6d8f2@oracle.com>
 <20240410002708.66697-1-kuniyu@amazon.com>
Content-Language: en-US
From: Rao Shoaib <rao.shoaib@oracle.com>
In-Reply-To: <20240410002708.66697-1-kuniyu@amazon.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR05CA0060.namprd05.prod.outlook.com
 (2603:10b6:a03:39b::35) To CH3PR10MB6833.namprd10.prod.outlook.com
 (2603:10b6:610:150::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB6833:EE_|SJ2PR10MB7016:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	rItR77YW2zh9YSnfeqw1AtyvQ4JzDds5kx1kwBaPuTsQEa+ddQraK5alMzaYjYkkJBnkpAC1eTcIWD4NU5a2wnJR8AN5HkEKj3QrSVLRC6i0mxb4o1NF4zMpzVjB+qSnzqNdw1Z2PdEDsOTotb6ljXnwGMgGFGLy2yLjdfEtV3aa7ZQYcibAjWazXORaXaDbJPVyEMbGcCuj+rfoNkCXZmMi4dE1XU2gN/AqcXjUe0cZaMEd6ktZ6qN0rXuJT8NHVGZ6CFSRjmPcBfvhrG/WTcuYfJOZjxBgH9cTCAvubcolG/TUzO32Uw8Y6VyvARMDQF8IuFWUzOBOaemKTBP9UskjZUIs6LNo44t+Y9tzHFTr0y7fLDpbQ3nxtoxp26y5X/NXlOctMnAgZCOclxgn0ZFDAHNyFC6MVCPUm8s3pWV6xRyxtaGpzEgHMDibsCnqqAlbDExZYC1NwpNA9msXHa2+ode0JepuLONWXFB97w1fZbkZ4TfW+xEnn6dqzoWrK2wo0sAyQG8xID7DQj4bPH/4t5Wasn1VEPhpcLPuypa5yZR0bUxWnvKkg3z1/pKJ71YZmS/L5Z1SFGDMgjIuB9WXzCx6dUIcvAbRcraqkoUQfjWnUi9bOR7rS9MfUg4M8EsrgLlGnAwXe8F9I2KaSQlY9KUxMnnxoIoYhbLYef8=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB6833.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?Uk9kNk5VMG9CK1JiYk5BYUtvZWFpeCtkam9idWhXQTBXUkNaOWFENDBzaWJn?=
 =?utf-8?B?S2VQdDFTN0NzWnJ5aU5PMlFYamMwYmJaUVpsVDhvd2xEQmNvYzd4THFsRlV2?=
 =?utf-8?B?clN1a0lsTTNCeWk2NFY2Z3dMdk1CYzlwMkFKRXllNmZPaG43NDVad1ZMaDh4?=
 =?utf-8?B?MUJ6RXlYT3dIZ2xRNm05S0VnTDI5N1FaYkI2SEc3RGNuVHdybHFxOEZTR05R?=
 =?utf-8?B?Y1JPaitSTjdwRXJidDUxSUZhNGJPU0RtNENxMDBDVVI0UzYyc2NNTWRqV2Jn?=
 =?utf-8?B?NmxpNjZKTElmTDlkZ0JldFUvTmlQUzlYRXd4VWJsUlhyRGNHbXRubG02b2o5?=
 =?utf-8?B?N2pVRlpOQmYxL05sN3QyU0xMNDdyam5HREN6dGVNRE02NDBCdk90am5ubkdw?=
 =?utf-8?B?Yk9WV3lzYWNpVngyQ09zc1c0Z0J3Y1ZjWTk3UjhWTXdFMks1YnlVVW9BdEtP?=
 =?utf-8?B?NDZ6eE5XZTNNSll0NUxnL1N2UXFEdFNWWHcvZ0J2a2xhVXpPWEhxMFJ1cjNq?=
 =?utf-8?B?UXMzcXdzWDh5YkxKVE9rcFE4R1hEcTB6M0JEaURXK0FGa0ZkUlJsaXNHZ3lJ?=
 =?utf-8?B?M3BGRWpRR2I2SHQ5TU1OTlpEalBhTGNkT04wTUszRzltSzBYSHp1N01mWi96?=
 =?utf-8?B?NVBhVzA4dHVXYWdPbVM3OXhhWkNvVjVIdlZuU0FMZHluUklYUlZJMWZHdkgz?=
 =?utf-8?B?Z01xZFFTZWtaNXM2Q0kxTXByWGxiTDhjNkFFV2NUcnJDNjN5TUl1NlZWdUh1?=
 =?utf-8?B?dTMrNzlwM05mVmhsckNJTVE2c1VibXMvNUc2cjNvSGFMUHZUSE9raTVuSS9R?=
 =?utf-8?B?bGRaWWd0UWVoL08xaDhQSW9TTVBWRTRSaGUzOXpLdUJkT05rR1VmcENXdUQ5?=
 =?utf-8?B?Y2VmSUhpVVJESDg1UVZZM2lPNHhKeHBvdGxIQm0yWDdleVNvUzJ3UFJKOVFq?=
 =?utf-8?B?VzFUTmRINjI0NlR6K043TnBTb0xXOFJWMHpDYmhncWFWeXJ5Ym5JSWJNcGRN?=
 =?utf-8?B?d0s4NWs2bjhDMWdBc051UWZWQmxlTmlWVGU1NUFCd2E5SjZXd2JBazcrdTBr?=
 =?utf-8?B?MzNzY1RkaWxNNklTLzlUdkx6YW40TUlJRFNWbEtzVmVHNTJzT2xoc0ZkYU4w?=
 =?utf-8?B?SktzbXBVMitHR0NxcnN1bVIxY1lGRzlsWVBqOXlZV3FoRXhpaG9KVjZpV3g1?=
 =?utf-8?B?MGRjSmprYVJXN1F1UlVRUDkwandsNHpZWUIvNktYOTNISHJsM2NFRllZaytQ?=
 =?utf-8?B?QWdlK2IzaGpJUHNYTXpCYnY4Y2RRTSsvY1FxenZWVzlSWmdPbVJqMWpRMHpr?=
 =?utf-8?B?Y2FTb3BKQjNCQWMwK1A2UFFVcXVjenZzTzdhT1J1cVM3enZMQnR3amcybGh2?=
 =?utf-8?B?b2Z4eUlPajdPeGtkOGp5dkF1ci9NWEg3TDF5Uk1ZUGRPRENydThQY2F3cVdE?=
 =?utf-8?B?YXA3WjAraE5reDNOajZEb1NyRmN5eGdtU2Y4cDA0LzZydUNyUGk1NXBVc0Nq?=
 =?utf-8?B?alEyaGoyUWlHS0NqQVE2SFFIcHRVa3dxOHlyNkhabW5ab2Y3dEZwNkl1Nm1O?=
 =?utf-8?B?NlhEWCtpNzJMMXZKNEQ0NVF4NkswNjhldjMrZHNKNlNQNHY4VStUbmVDekpJ?=
 =?utf-8?B?Ykxyd2pqNXRPbGJiV1NlbndpMGQxb1pZM2VDSk5sMS9JNGdwTG9UdmNYcWlI?=
 =?utf-8?B?V2F6OXNXYkd3SDBCK1NxTlVQZnNLVkJicnh5dTRlV1JpNjdGcGlHd2hLZUQv?=
 =?utf-8?B?YlpQSVV3TlRZb3htWnlTbnd0elN0KytqSnVVdWdLZndyZGZycWZlbEV0VWZn?=
 =?utf-8?B?ZDFRZVl6amRBS3NCQ3Y3QVpJUUdHd3Z1dnlJQ1JrZlRndnFlTzFUaTRXY1d3?=
 =?utf-8?B?SjNZWnpsd3VBczQzYkdKMzc5YnU5WEdJZGF1SDFRKzQwd2ZwNEY2Vi9OZ2tt?=
 =?utf-8?B?REljSVUzZVB2VXdHOW1JUnpabytMN3pROEpReXZTQkhuZU9PeitVb1dSR2sy?=
 =?utf-8?B?bnJCU0ppcG94bGViMDhvQlg3U3ZKVDlDUzErYWFEV2dIYlUzcFZac2s5dEdp?=
 =?utf-8?B?dlZJVzdVQjFkM2xxa3pwbnY4Q2JzYmNiZ3NUNXR1Tkc5a3BMRWJNNWJ4YWxI?=
 =?utf-8?Q?XVuUV9rJf0zHYX453GdTBSl9T?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	Mb7/V6OboxplqM2Z9wYcRBnVj6qJ1VtADG4Q+xHb+ncu/ny/0bk5+Z1EcGArl7Rbtqs8WcbEGaEWoF5dNCW6hxCgptf3OubyobqEUKA8nnPGTTjRvLdaZgx/chrVlDQjZ439QoDbLtj5J3IzzXD7wksU+6gqaa7IxX+QBYrFPEkyKJwzwb5T6Cm9jqVjLezVRXc4JOyUVKZWLd7nnITf/YZN+bb9vt+RQg7c3Kcn38MItA/PAIVgDK/q+0gcCpeTDAGhInZIF9mzE8c0uVlvsIEICUWnod8BJ0ezOkUZ/j+qMWvGGCGssHw4VjbifuGfaHX9RlEkNQ7fpIQhZ97BdAu+4Db57szlEhFlKxGi4VMEQNkwx32nn3TMmmTfrDXlH7vBpOUR7ibnzx3WEn9zMtmuqFD1UzAfB1VAjH2HYOAPfn7hSyiAU0d/PlP/2SfhCz1JRWU3VMNXZT0qGhHBgbkK+oqhUlMs5DdDTlxy5FQuQfI8HshoccToR6B6T3aryimLu+QIXSBaeQSA98+6Wz46pqq9kkHDjHdKGkK+lpyrS40OYA3saZTWSnrPHk/0r1Qz5tZnFCTsdxPFBnJApO+o5CjC9OyK9faYnURlW2k=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8681729-728b-4736-ddc7-08dc58f7f734
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB6833.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2024 00:48:40.9103
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uVgMlLTFMU/CtjYpozIX1+L6S25Rof/qYEOLTWscpzhl8M6lOsKcz4etUvsHcL+nYka2pQGCLzvG/SXHUsij1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB7016
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-09_12,2024-04-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 bulkscore=0 mlxlogscore=663 mlxscore=0 adultscore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404100004
X-Proofpoint-GUID: tWW18pbvgknEycoB6hut5pi856r1VfV5
X-Proofpoint-ORIG-GUID: tWW18pbvgknEycoB6hut5pi856r1VfV5



On 4/9/24 17:27, Kuniyuki Iwashima wrote:
> From: Rao Shoaib <rao.shoaib@oracle.com>
> Date: Tue, 9 Apr 2024 17:09:24 -0700
>> This feature was added because it was needed by Oracle products.
> 
> I know.  What's about now ?
> 
> I just took the silence as no here.
> https://urldefense.com/v3/__https://lore.kernel.org/netdev/472044aa-4427-40f0-9b9a-bce75d5c8aac@oracle.com/__;!!ACWV5N9M2RV99hQ!Nk1WvCk4-rstASn7PUW4QiAejf0gQ7ktNz-AhuB2UHt9Vx7yUVcfcJ82f9XM3tsDanwnWusycGdUfF4$
> 
> As I noted in the cover letter, I'm fine to drop this patch if there's
> a real user.
> 
> 
>> The
>> bugs found are corner cases and happen with new feature, at the time all
>> tests passed.
> 
> Yes, but the test was not sufficient.
> 

Yes they were not but we ran the tests that were required and available.
If bugs are found later we are responsible for fixing them and we will.

> 
>> If you do not feel like fixing these bugs that is fine,
>> let me know and I will address them,
> 
> Please do even if I don't let you know.
> 

The way we use it we have not run into these unusual test cases. If you 
or anyone runs into any bugs please report and I personally will debug 
and fix the issue, just like open source is suppose to work.

> 
>> but removing the feature completely
>> should not be an option.
>>
>> Plus Amazon has it's own closed/proprietary distribution. If this is an
>> issue please configure your repo to not include this feature. Many
>> distributions choose not to include several features.
> 
> The problem is that the buggy feature risks many distributions.
> If not-well-maintained feature is really needed only for a single
> distro, it should be rather maintained as downstream patch.
> 
> If no one is using it, no reason to keep the attack sarface alive.

Tell me one feature in Linux that does not have bugs?
The feature if used normally works just fine, the bugs that have been 
found do not cause any stability issue, may be functional issue at best. 
How many applications do you know use MSG_PEEK that these tests are 
exploiting.

Plus if it is annoying to you just remove the feature from your private 
distribution and let the others decide for them selves.

Shoaib

