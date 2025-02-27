Return-Path: <netdev+bounces-170105-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FE7CA47471
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 05:27:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 38AFB16F83D
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 04:27:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 548081EB5EC;
	Thu, 27 Feb 2025 04:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="F4+BP5xc";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="NS8b8EH2"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89F971EB5F6
	for <netdev@vger.kernel.org>; Thu, 27 Feb 2025 04:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740630413; cv=fail; b=cOhfPVlzUalsuEkehI6s3EwqkzzU1Q+dSd3MaH0ieTdqluOrq4NrP1k27giPP8truXJWB61NODW8Wxk0ibEO+7G2jDUY+nhv7Q6cqxA3/fNzu66FMd0yB5/n/jcAQGuqusaCxwYhAKDZwdx/2WC297DutQ8Go+LONe/C3+vnHfo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740630413; c=relaxed/simple;
	bh=u8TNcM5GZe9CxOPgI/so8BMLQTdOhzOl/MFnpuUmoHc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IY5vo9FN0NOSKWWs+WRi01gLaQS65CRRgXbwxWmi4u54SoctE/PkTeHSsibnUU+W7dWIFeQkk5v1Z2wsezcQWuAn97uXRQ+J9eCRlO9h75YBqFg+XvUepxB8xjZkgrev/D+1X+wgA2z2DBZVfYWEX1pFHMTsXcFaTtgeVJwOJok=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=F4+BP5xc; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=NS8b8EH2; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51R1fs4k027616
	for <netdev@vger.kernel.org>; Thu, 27 Feb 2025 04:26:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=Jy0UIDj2jf9ADtWk3KVXlP9OQMSqaD0e7Dn95+8ojJk=; b=
	F4+BP5xcqz6z2dF6PIakCC6Y4h0US7RvK7XHCB0cybaxLSYBFwd2len/BZhS69lC
	Xp1J48+SFBFCYeGcLAFHW6nfmXysT+Kc7KIk2l7TIcbhCaXNpJGK4FTgr3ehjubJ
	0LvhVgFsOhHcnQmKFjTGRbHz/MsDOQIKx/Xj511H4Yq2d5E9PK6NRc6CkGScGbvC
	L6eFd1IHoDfL6r4cenQiFsggvum3wu8xjYKlkNLcJt8z06BE4lJlQjaoWfiiFD4w
	ry85c6s4DGwQISRQP3eaDa1NOBRrInzJ223yD7veHsK4xBpzPM/nVvvA40KaQ9qH
	D5VsqTIJOqdhECBJN4gC5A==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 451psdjkug-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <netdev@vger.kernel.org>; Thu, 27 Feb 2025 04:26:50 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51R3o4lq012657
	for <netdev@vger.kernel.org>; Thu, 27 Feb 2025 04:26:49 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2175.outbound.protection.outlook.com [104.47.56.175])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 44y51cuy3j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <netdev@vger.kernel.org>; Thu, 27 Feb 2025 04:26:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j2URw9nlyvI/DbQ/bOAZ13lmhVNK/UC+9Bn0BJ8RcpaPM+TYwjk4+y3v09SJILrbkKz4oN1TVepqKeXLRayPHHf0nVtIvH+cfCOVvo6MP3ivz46gLgm2Hxfsq1uwwmEf4jL5IIbGP+YGw1vN33ct+mojrrfxlFpMKwbzIEEQu1WXV4KsDkHAKR2gf7qou0xbDOMrCc2Z3HNWsam2jrpRo9LMMhDNfvF8B2kIGR0U5CcvBn6X2RchvgWw6G1yUMCKhUR+CxCYPeBQayPK24/iE5gJiS/TiYoeLOpfauC1X1pZxVEtdz0r+qR2jVgTF1WrXz/t4haZo1JQ5pGV0Jx7+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jy0UIDj2jf9ADtWk3KVXlP9OQMSqaD0e7Dn95+8ojJk=;
 b=CdTP6YjK2B5oN3JifpBKBfXsFkqwTAkYyC9Lt6xK5MPdMTYcu26wTpemlEO60HaL0DuRd8ACwEmuw866zM6PDPItEARdAXfMFYlp6m2FQSwckdXfqJSqfEFVwLLAgM00QjYI2S9/x0gPi/KTgyXhzuvh4VaxAuAZIqwo8RM6Ca6TLJ7Mev5wbA1WjfUlrLpHF03rD7xPGFSvHklUnW/cGvYYDZ9npGFyZtHScqnYG146zNLNaJC+hsX39KqlOB+ZMjK0N5SPkNxaN17yM4WZglyG+Z8GVYQ2oOtqf+lfV8sVMRACbgz66zzC7Rihis3ZEv9MG1Bd5Nf5Bkt2gt9FFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jy0UIDj2jf9ADtWk3KVXlP9OQMSqaD0e7Dn95+8ojJk=;
 b=NS8b8EH2kPGL5GOddWml/LSGjN+qGIV1ECQIeDKfQ1IZUZZ22qlRvMxdP8Muh/RZn15bsu9yE/6oDe+2W1+lf43qHlqOCQIUddteRhHio2mePVEh8gi05PO/Qo0NGz3FSDcH7H1KxUD1rAvSGCoLl1/I4DLDW6HsXPAQ2noVAnw=
Received: from BY5PR10MB4306.namprd10.prod.outlook.com (2603:10b6:a03:211::7)
 by SA1PR10MB7587.namprd10.prod.outlook.com (2603:10b6:806:376::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Thu, 27 Feb
 2025 04:26:46 +0000
Received: from BY5PR10MB4306.namprd10.prod.outlook.com
 ([fe80::b78:9645:2435:cf1b]) by BY5PR10MB4306.namprd10.prod.outlook.com
 ([fe80::b78:9645:2435:cf1b%7]) with mapi id 15.20.8489.019; Thu, 27 Feb 2025
 04:26:46 +0000
From: allison.henderson@oracle.com
To: netdev@vger.kernel.org
Subject: [PATCH 4/6] net/rds: No shortcut out of RDS_CONN_ERROR
Date: Wed, 26 Feb 2025 21:26:36 -0700
Message-ID: <20250227042638.82553-5-allison.henderson@oracle.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250227042638.82553-1-allison.henderson@oracle.com>
References: <20250227042638.82553-1-allison.henderson@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH7P221CA0047.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:510:33c::19) To BY5PR10MB4306.namprd10.prod.outlook.com
 (2603:10b6:a03:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4306:EE_|SA1PR10MB7587:EE_
X-MS-Office365-Filtering-Correlation-Id: ad487944-60d7-4716-751f-08dd56e6f26b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?I6L7930YkTVQ+OlV32PzbFMTS+WysRJuY8wXIXlLtH55yIdgTAkpSQsUbncz?=
 =?us-ascii?Q?J5vxnAGnH4zqKRJVvqZxW8oyVsP+smFLNsScm0DH8KIU75anMgqPk2HS5nal?=
 =?us-ascii?Q?u0bPh2252d5ReX/Bpu+ExprtH5yE6+4U8zZxv5KyQ453tpsojwqjXFUb7U75?=
 =?us-ascii?Q?1YiGGcdZ5o4PcQ1yki+vkjdHUNzoP8p/fwLU55i61FCW2nFhIqPq4CgU2E2t?=
 =?us-ascii?Q?U8stM0Mx0kZZDHaZf1v82XQUoEIEyKmxB2k9kvAU+RQqNz5qWZrgmncNrBzY?=
 =?us-ascii?Q?4UsUW0UJuGXu4qa0xrxBU1eQ/YvIqH9f9FOLMlmX5w9g23ylHKdpyNQ0kgZq?=
 =?us-ascii?Q?1yCzMX+zx1ZnKYoFQ4DeNxSnviWvMjlnWJEsq0wbx4Fdhc6w4gZuhyI0jTE2?=
 =?us-ascii?Q?sNSrmJjfK7lodvRInfp8PoxeXDK04RjzAZBSjI+HNDGsfuvnJZhdqrYku+44?=
 =?us-ascii?Q?SLGNDyB7ER7xr7h9su8qtixRBojfBaCHk1Q6oTr2ML6exk3KEyQ5ZdYAToZw?=
 =?us-ascii?Q?mmQlz89ocL63atOC9yKLt/Ozo7g9TEUODQw4cKtu017iRAdEgTQVJMfHK9nR?=
 =?us-ascii?Q?d9/mNaNaiom11C1r31RbvVyt3E+bv6Uv41F7yz2sRxWy++pfyXVLOkDBWcgV?=
 =?us-ascii?Q?qkIQVI+36Zw9Ns9DKxBlQA/D6EkWXPaprhPty8P3hppfB5WVmFCtmZksLzzi?=
 =?us-ascii?Q?Wfw+xL54IS7hviCq/c+IZieOJwqZCzt7KFFWE6jTe3PaNA0ewafpeEH5DvVn?=
 =?us-ascii?Q?qqxuB5Ztu0l9qwP4w/8dYFGw9n8CS7knqeP1XKAM0xZGMFD5KHzmL35r+8t4?=
 =?us-ascii?Q?Blye3W1Z30EnmBKb9Dg+XBbfTe4Dat5rjNKsmWU+QaySGh6uGU58VAiEF6Ss?=
 =?us-ascii?Q?BI1ygVC7ZonD/7I9wcWUAvpo/kz3JHu4xIcJGT8nfj49n2h9Hru2VGuflv/Q?=
 =?us-ascii?Q?KdH4XOD4mTjBxPXqNBkD5hPRMo+Nd5VdQbVxn3B60j4eIW3w3rtrFFco/UNk?=
 =?us-ascii?Q?T6Y0r8oBVr3oUWAub1aXgPlvVRw3QLusJJfgdY11hWzQe9RAfWGoAiPKRZhQ?=
 =?us-ascii?Q?hHexHFbZpEmZDKFBfJqJ7SwDI7ISamdfTufjCYI6MzhRmmF8hJf3hHE6vITh?=
 =?us-ascii?Q?uybIGQETlYarlUpf76KDiEok0/Lmv3xtiKMm9ora3AvSkSEFVUQ6+zQvEMpI?=
 =?us-ascii?Q?M3Vs5BDdqe5SdMvWO3lgLaFOyTL/n8cNcfzebzfKV0RcaPiXGqPsUKwY3VIA?=
 =?us-ascii?Q?3do0Xf1nE6RhTbj0fsRH0Wh4LUvu+oT6LXuisc/WkyEQn8TGwlIi9iSeDKQR?=
 =?us-ascii?Q?M+7Qg8DcF86wkK1YUxwhIUJOs8xplR7rdGjhO7pdi9r0lstDuP7DbNIrC9s7?=
 =?us-ascii?Q?aI1Ovki/4gv9XOgteQNzQx9Dy140?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4306.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SQ6xfWp6g4UWiiSfBrHWqxneAT940OCSRFDlQmY6DfKLszBmCJFHoyY+N6yV?=
 =?us-ascii?Q?8gsFS24ALB/pPmrOi5CJxzt8jnkHJgkg4h9+YSzYR425xIBo7m52LfD/U1jz?=
 =?us-ascii?Q?MNYT/zr9UfMJ7BBdPj6plm1Pt1x1lb+hoFNNJJDcmoWrX7xrUW3SNXb+mGhP?=
 =?us-ascii?Q?JrNYn3nmnGpnNhdOM/4MANt4n0GDpanaAgQdBRsxhzBfg6MDEgdTa5Zz77ik?=
 =?us-ascii?Q?jd1XiervDR2s17jrUiP39A3Jb2KIxpHtekfGdMcqwXHVRUb9jswQ3bhH8vAX?=
 =?us-ascii?Q?+4isACEM67QGIFwH3q4bzLsq9jjHklmVNy38unMUowKMLS799weg0+fgq+lf?=
 =?us-ascii?Q?4aKXNC5aADz/KnsVT2c9WGQjwzLZbxXnZgflfu8OpJ6mAMA9xhErNELHboVa?=
 =?us-ascii?Q?+tSaKVUTq2iz4wO24qy9lAymE2VQkrq+tS5ceITvVddaEIy5iXDaz9jTc82a?=
 =?us-ascii?Q?6vgtvip6Lpclcuq+Ky2aGWgsdvvyTviAD1zZ/QLaSIq1z68u5aQi5vyYHFJS?=
 =?us-ascii?Q?s1rvbxY3FntJtnVSqVFptqY1sScTzYm32DVJ4hw0sByPNMYVn1phLw9wths1?=
 =?us-ascii?Q?P/373LBnJSUQeBOPhKOpvL/aCbQ9Q3BhspAyo9lCNZzcG6wIduEM1bC33yyl?=
 =?us-ascii?Q?dtBSrU12piBWVWOxhJg9zLyj6oFdvpbcElh6rAZbsCUpGOCn7K88JvCDYmna?=
 =?us-ascii?Q?KN1DKPVRYpaAPgwbv2YRGMoP62sKT1CyO/gdAm1MXapKkeebCId2YyWRCijE?=
 =?us-ascii?Q?W5bdJqGievxspdEPZ3H4MRBKiWWrgPgqLAH4ssnBNa47QR0pWwTestawenag?=
 =?us-ascii?Q?CyKTRnEXLqoC8VGs+Giz3nmGvxlwfveZS9dY/89D4wpysjN4wwpbi2QO3y3e?=
 =?us-ascii?Q?6BC5O0LsZMXOQ08qifDyAqtn03b3zk7QhADiltT6wmXfQSokfHyXhvQbQy2h?=
 =?us-ascii?Q?NFo7887TChgoPcdbxMJ2ocNTzHjqj+nKTJO86YTo43rl//02+xCaLVaFDs3T?=
 =?us-ascii?Q?fgXRrDioQjom9FZgatABGbI0DAhRcMBJLRDmfBekhNO0Uhn0rcSDI1vJx/VM?=
 =?us-ascii?Q?dHPQXABTO9ocugZe3yRwhme5GzAX2eR+sXvd9XZc+fbveaCP2CgPe+b55haL?=
 =?us-ascii?Q?rtfzMlaiwE7NExUiAy1A7DFkW8aIMcAg3qJPocd5P1eBIHqr7hKBi3B4N60H?=
 =?us-ascii?Q?lTtfI4erac7RYSAPiefpiLqniSSOghxGzkwt8DjBKOfLpoApBw6L7FgpMwZg?=
 =?us-ascii?Q?5T14nQkFvrhpcCD/EvgYz8P+8cab0eK1LCTwUs99zIy8239bV/GgdDsn1IRc?=
 =?us-ascii?Q?IzINlBPlnC0wnn3pOdHdE9tso75q43psbwas60LJPbllxgyeXhSComElwl6l?=
 =?us-ascii?Q?N8Dnd4lNaXkrxvs2ACvjbgKiF3e+eDVnUoHTth9ATxjb07Rada7Eru8tse6J?=
 =?us-ascii?Q?dH4pHiwiWOTAzFmdht017Eg/q0gYF/v5jGcXzJrayGsD6QUL5qWGm8Z6HTPW?=
 =?us-ascii?Q?AUgBS1fchTwLNlqoehw0JYBi/xp/N6V4ftCOJbY7vFwAv/pJw0J2Rk92PTla?=
 =?us-ascii?Q?8/m/OxBkUEPb/UmdqgJrtRJDcB+HgxVywxqrgZBHexkm5asgYuB/W/yMtpWp?=
 =?us-ascii?Q?MA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	mzAikN6VJRx359c5GMDlt2y7Q9/AZWCJH2CwqL7kwmsB9Oyva4AOsUVQGMpEOPQeAzd5rjUMgYceqZFKqhV6GNcw5Ztt4n1orUznOfU+XhumB4LYyFdaqf/NbRTrNT1GjcUY+WKZnmrtC7dAFyvhYbCNp1hAiwvk5IADIiQW4/2ZDySpeq4RbHeWI1Lx2RdVthEd14mKXE0cd7UTK7vCxOOx0cbOxYqYArJMEm6y3cXDwvO4IbUqVX72BQLf7rCE8RwDmaAG+G6ICH1YMKTIhraIrg/6tVoQoTUTZCqr8gba9O+3RA5PR1sc9/ERimKcAE1XzoB08xAdkUEx6IHCzoTRX+H60JFtHoYy43FoGy5DRQJFIgkiH4SKvX6kteGw4lv+q5JPxAQ6FltJK+Mr1lwTbEyRo/Ov5zYzerW/uicd9Iilvkjir2ZcR4D/j4a2ZOqXNOS6LFFveWixbBhcPBJGWASPh+Pzcx9tEzKnd2eXr2DVfKYRZCt7p9yJ8i5TUVEcvQh6GHyy/SufZHOPJSpJoZyChMlUihQo5YxfDjwR7vX0VtPROSK6lrWZlH0rM0Et5Dfs3AUts7bALcztXVBKxI7+KY9hYZn1iT8KTqU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad487944-60d7-4716-751f-08dd56e6f26b
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4306.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2025 04:26:46.7653
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MuhWW1P95kkC9AbjArg271xqMoqlmG7+9NPDrTYCCDdV0IyGRsEmV/KDombDSMen3gx2IMniqFoDL9SItxzQz2D5iN83nTe3oS0fTgyY/NE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB7587
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-27_02,2025-02-26_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 mlxscore=0
 adultscore=0 bulkscore=0 mlxlogscore=999 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2502270031
X-Proofpoint-GUID: ceNKNPLRyuxZX9FZ8pSi-yzXWfEG8uex
X-Proofpoint-ORIG-GUID: ceNKNPLRyuxZX9FZ8pSi-yzXWfEG8uex

From: Gerd Rausch <gerd.rausch@oracle.com>

RDS connections carry a state "rds_conn_path::cp_state"
and transitions from one state to another are conditional
upon an expected state: "rds_conn_path_transition"

There is one exception to this conditionality, which is
"RDS_CONN_ERROR" that can be enforced by "rds_conn_path_drop"
regardless of what state the condition is currently in.

But as soon as a connection enters state "RDS_CONN_ERROR",
the connection handling code expects it to go through the
shutdown-path.

The RDS/TCP multipath changes added a shortcut out of
"RDS_CONN_ERROR" straight back to "RDS_CONN_CONNECTING"
via "rds_tcp_accept_one_path" (e.g. after "rds_tcp_state_change").

A subsequent "rds_tcp_reset_callbacks" can then transition
the state to "RDS_CONN_RESETTING" with a shutdown-worker queued.

That'll trip up "rds_conn_init_shutdown", which was
never adjust to handle "RDS_CONN_RESETTING" and subsequently
drops the connection and leaves "RDS_SHUTDOWN_WORK_QUEUED"
on forever.

So we do two things here:

a) Don't shortcut "RDS_CONN_ERROR", but take the longer
   path through the shutdown code.

b) Add "RDS_CONN_RESETTING" to the expected states in
   "rds_conn_init_shutdown" so that we won't get
   stuck, if we ever hit weird state transitions like
   this again.

Fixes:  ("RDS: TCP: fix race windows in send-path quiescence by rds_tcp_accept_one()")

Signed-off-by: Gerd Rausch <gerd.rausch@oracle.com>
Signed-off-by: Allison Henderson <allison.henderson@oracle.com>
---
 net/rds/connection.c | 2 ++
 net/rds/tcp_listen.c | 5 -----
 2 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/net/rds/connection.c b/net/rds/connection.c
index 84034a3c69bd..b262e6ef6b41 100644
--- a/net/rds/connection.c
+++ b/net/rds/connection.c
@@ -382,6 +382,8 @@ void rds_conn_shutdown(struct rds_conn_path *cp)
 		if (!rds_conn_path_transition(cp, RDS_CONN_UP,
 					      RDS_CONN_DISCONNECTING) &&
 		    !rds_conn_path_transition(cp, RDS_CONN_ERROR,
+					      RDS_CONN_DISCONNECTING) &&
+		    !rds_conn_path_transition(cp, RDS_CONN_RESETTING,
 					      RDS_CONN_DISCONNECTING)) {
 			rds_conn_path_error(cp,
 					    "shutdown called in state %d\n",
diff --git a/net/rds/tcp_listen.c b/net/rds/tcp_listen.c
index 60c52322b896..886b5373843e 100644
--- a/net/rds/tcp_listen.c
+++ b/net/rds/tcp_listen.c
@@ -59,9 +59,6 @@ void rds_tcp_keepalive(struct socket *sock)
  * socket and force a reconneect from smaller -> larger ip addr. The reason
  * we special case cp_index 0 is to allow the rds probe ping itself to itself
  * get through efficiently.
- * Since reconnects are only initiated from the node with the numerically
- * smaller ip address, we recycle conns in RDS_CONN_ERROR on the passive side
- * by moving them to CONNECTING in this function.
  */
 static
 struct rds_tcp_connection *rds_tcp_accept_one_path(struct rds_connection *conn)
@@ -86,8 +83,6 @@ struct rds_tcp_connection *rds_tcp_accept_one_path(struct rds_connection *conn)
 		struct rds_conn_path *cp = &conn->c_path[i];
 
 		if (rds_conn_path_transition(cp, RDS_CONN_DOWN,
-					     RDS_CONN_CONNECTING) ||
-		    rds_conn_path_transition(cp, RDS_CONN_ERROR,
 					     RDS_CONN_CONNECTING)) {
 			return cp->cp_transport_data;
 		}
-- 
2.43.0


