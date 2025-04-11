Return-Path: <netdev+bounces-181737-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D9A6A8652A
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 20:02:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F360E1B6138D
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 18:02:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1252258CE6;
	Fri, 11 Apr 2025 18:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ePZ3STeD";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="sbw09WwY"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA6AF23FC5A
	for <netdev@vger.kernel.org>; Fri, 11 Apr 2025 18:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744394539; cv=fail; b=fIfyrl2CG+ZPxUxfbkMApFpic1p9adU5r8QDXGy0Psmp2xMUv1Z83vdovqSp6c2U2fyh7b2ortw9xxsgmJ3LG3PZXN3VWNxitwj92XfnwOm2vooRUVnr5VHmBq1MADuIE6WItQIr2gMmgUD7hk933HHWBal+giIu2RUa7y35xuo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744394539; c=relaxed/simple;
	bh=iohR3lzN4xkAZrxmnO77PZ/IL8oknF8fYopWOjyCDMg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=C/fAQRg9p7QjHfN5n7YPuQOHhpjPP6jIWnzortQYOZB39mQkaTFQILtBjvPH/J23jSBetXXHt3QNe3uEJNIXa/tYf0GY1Mv999WdYZzeXBVTNzAmSz2A+cGK+a6r7ARJOSrNz4faC8v2elG/jMes1n8u9nl7Dl3oM+isjOC2GZc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ePZ3STeD; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=sbw09WwY; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53BHsLKN007492
	for <netdev@vger.kernel.org>; Fri, 11 Apr 2025 18:02:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=ferqQcMt071hJHQ99uwBdt6cin61y2DRqToj27tGtuY=; b=
	ePZ3STeDjjF2U0BCdCVLnWjspkjWYE9ct8LbVjFZ0r1uC+uz4oSXKu4N3gSFlrvm
	pKr6cJh2hBRR2H3tExCXu2NvwiWU0oPJEpEcr1Euvdl9YdJSaME+LQNl1iEXXhHZ
	mvNJ7jaXatMDZd4DqiErjaW7uQ0UnUGp4LZSb6P/Q5WRBoxwTVi4Je8/rvDwcwrh
	TS1dxon5kYJpynvJGJ09WuZp8k5EpFUPrKDveMC12iZmprRrJR7WGJ/R8SqJH7op
	YzavsZPYwR0hyHkgkdaC6M+lNjR7ZaxbD8dcgItc5bnKuyXyQ33LE7G6pC4Kxk+V
	qJZWFCN6e/XZw0EMjPLoLA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45y7vd00dx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <netdev@vger.kernel.org>; Fri, 11 Apr 2025 18:02:16 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 53BH0CLD016775
	for <netdev@vger.kernel.org>; Fri, 11 Apr 2025 18:02:15 GMT
Received: from co1pr03cu002.outbound.protection.outlook.com (mail-westus2azlp17010006.outbound.protection.outlook.com [40.93.10.6])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 45ttydyn9v-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <netdev@vger.kernel.org>; Fri, 11 Apr 2025 18:02:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q8X1WyOKB9LMLtRJemWWl5QZgNkE3hOrMbcuIGrMJniQY3Zc/f2oFB4vPqqlqkTfAOvAY3MYLjx+qX5Zl6lKiQU0F4HEOqpw3HLtHnbeJD2MFDHHgKoPXK33+cVlOtX6Oclnpy6uIw1FU40buT3yECzD5NimLfB0Vjd878JlJC0g2k7jd4NHsUgICUhypAZ3YI203GHrHN77zCBv7pnT/atqF6MYzZU0WQr2bqp+gTeIkB0kCGYXdXAto4PsH+ZhV4qO7oS/wYJ9vJvnv6OOOgmJIfizoPuc62QzaQzW4LbtcjsOsjlehwxMdCuf85J4eN6bTeurLi8oFks6b9Jiag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ferqQcMt071hJHQ99uwBdt6cin61y2DRqToj27tGtuY=;
 b=Syx+CVEcmXi51Z3HMMQy9mzeuUxwX/rmRjnMFjpKXEOx3wSSFPiIimNQia6qK37+KdyDIQoX+pLmW9v2mTalfaGSxGbAQOqi0L6JboQ23TXJ/JUMajenbMHhgUZZowBgRsHM0toDHiOoUGJMJpCmk/woQevhbyu/W+HDwC6XEIUREqMvyFM6gtEDP4LPJeKF85vauXSuCVd0lFDd91FO/W2gQoLcjwMCIXP8c/0Y3ZVYcnty+v8DQmWjesUC//Tx/hqRmyhDjnp7+PLgWq+acp94SMmiTVfDWAoDW7JwdFxn8ZsEI0xHnj/dKFfXZSQrpUh+FX2AcPqrBVIjzkaOJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ferqQcMt071hJHQ99uwBdt6cin61y2DRqToj27tGtuY=;
 b=sbw09WwYvfbflFlzhSZd5uQSQGghQRiJjjNHq7TQy9D4wZG0vXROzoalVGjldRxTSVAxEAE3XVOdE7eJXDCSLT7vT3tvpQ/0aBvCrWTtfIdldtI7NjRXI81H6Qw9ywLD0FOhaDhHSY1yZzPJkWalf2Wo3DNBI0jzX4e7X6hvpyE=
Received: from BY5PR10MB4306.namprd10.prod.outlook.com (2603:10b6:a03:211::7)
 by SA2PR10MB4636.namprd10.prod.outlook.com (2603:10b6:806:11e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.21; Fri, 11 Apr
 2025 18:02:13 +0000
Received: from BY5PR10MB4306.namprd10.prod.outlook.com
 ([fe80::b78:9645:2435:cf1b]) by BY5PR10MB4306.namprd10.prod.outlook.com
 ([fe80::b78:9645:2435:cf1b%5]) with mapi id 15.20.8606.029; Fri, 11 Apr 2025
 18:02:13 +0000
From: allison.henderson@oracle.com
To: netdev@vger.kernel.org
Subject: [PATCH v2 2/8] net/rds: Introduce a pool of worker threads for connection management
Date: Fri, 11 Apr 2025 11:02:01 -0700
Message-ID: <20250411180207.450312-3-allison.henderson@oracle.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250411180207.450312-1-allison.henderson@oracle.com>
References: <20250411180207.450312-1-allison.henderson@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0043.namprd03.prod.outlook.com
 (2603:10b6:a03:33e::18) To BY5PR10MB4306.namprd10.prod.outlook.com
 (2603:10b6:a03:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4306:EE_|SA2PR10MB4636:EE_
X-MS-Office365-Filtering-Correlation-Id: ae80393d-68c3-4f0d-637f-08dd7922fca2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MEJEalJDVGduMFVmcTBBQjAyNGdmTS9KeVNMYnpWK3ExTXFOU3JWaHlyRnh5?=
 =?utf-8?B?eUMreXJKbVhDc0ZSZ1VMT1pMc0c2Tk9jWE9MZnIzZzgzU1RVK1hZVjdMUml2?=
 =?utf-8?B?OCsxaTNWNTVHNDEwNU0rSFJ5aVNaZHhpOHdBUlZWSGdjTTlpc0xwbEk3VUhZ?=
 =?utf-8?B?bXZVQTRiWDNQSUZyZTdjYmdFVFJrT296REtWakVaL0sxUkNGd2UrVjZiQ1NI?=
 =?utf-8?B?Wm42S1NwWTVZYXdmWmJQRlpZdVN6VE9JOTZ3TGF5TWt3QVR0dW9ib2VacWNZ?=
 =?utf-8?B?cEorV3ZGOTBTVWdrd3BpR1pPYll2a1JrT0h4c2pNU3BKc09tN0tmMDQ5Mk9M?=
 =?utf-8?B?R1R4NklrcXlTR3hvdkRXVDFMckZ0UzNkSlI3SnovYWY0b2U4MWllbjBVdTht?=
 =?utf-8?B?bXFwL3lZK24yc3ljRGh1MllVTzY4L212QXhpdSt2YzhtMTg4NjdDL1hIMXVy?=
 =?utf-8?B?L2NxbStnOW9GdG9mMkxDTFBLUEljTStiMzVwTW43RGtRZVh4M0ZuVTh4d3Nq?=
 =?utf-8?B?akN0RlZtR3QrTk1PL1o1Sm5weHUzUzl0L2o1RjBTSVU5S3JEd29kZVBWWStT?=
 =?utf-8?B?VklZOE9rK2hrWjIrVEIydUdEeU52a090T1pGbVlTalh0Qmlsc3dWaVA3YXRp?=
 =?utf-8?B?ZmNkRFVoV3locXlPU2diZzZLMm5ReWtkcVBFQTBYaHlZS0JRMTAzcXh5NkVI?=
 =?utf-8?B?aEIzMUQyTzZnaHY4Z0ppakRwakpVckxpemVTSTVWN3VJOFRaSU4wNkhDZ1pK?=
 =?utf-8?B?TmYvUTh1dC9ENjhjcUtBdXlYOVJncnVCaGc5Tkwxc05YYzRHMkNXckx6YW1h?=
 =?utf-8?B?NUR5VWxSTnNEVkw5YkVtMTNVVnUxbzlVNGRaZ2ZYMUN4Q0dqa3lqK1A5ckNU?=
 =?utf-8?B?cVU5czAyVk1TWkw2VXZ5bU9NSEZyN1NmNjhrckJLMHQ3cWtneGtHMUFrRkdM?=
 =?utf-8?B?b2NHM25vNWRCck93ZFBncXVzejh2aFRPZ3BQV3lrZHFrdjdibkFOUWk2TU90?=
 =?utf-8?B?RHhpVnFuTDVTQ0lGK2ZTdjJPeU9XU0h0SzVhbWQrRGRyUmpxZXBTQjVsenpP?=
 =?utf-8?B?QzlNVTcveVFJeE9Dei94K0tGeXBvS0dJMkl2VVFXckNSVUNGTzVzS2d2R3VP?=
 =?utf-8?B?TEFRVjVyd2R0OVNzSE03VGRLb21QZU5FVzVUVHJMRm5vSlRoOHFaclo4VlBW?=
 =?utf-8?B?OFdZRmJwQkVkalZhNXFablU4RTdTRHdQdndCTTJZN3JVaGdnMzgrUFN5b2Jo?=
 =?utf-8?B?TjJiS2ZtTHFMd1BjUnZjVThKZzd3WW1TRUNwOHRWZEN2WExZWVhWR2ZRemho?=
 =?utf-8?B?eEJwczZsQURES0JTRFVvSDJ2NkRKbUpTVE9KWWUyTU9IVVJmWW96dDhrTzdi?=
 =?utf-8?B?UjdoQkd4a2RMSEFpMHFsSW5xRldKWTY2SmtGS2dBSGZjZFZ1ZkpKZC8ybTIz?=
 =?utf-8?B?akNuMWVwYnNvM1RXVEtQdW9aSHdNRE41L2pNRDRhRWhQUGVHeUdJMlRST20v?=
 =?utf-8?B?Qkt0ckxzNFBnQk9QeXZFQlZKNzRzQXZRYmsrcW9ONG9OSWlzVlVqQU5MVHB0?=
 =?utf-8?B?OFNWQVhnQnN3Wk4zcWw5elljMml6UW0reDlnZEl2Nml1L25wL2ptT3ZvRXFQ?=
 =?utf-8?B?NFhvNUhhWGROWnpGYzFEN1BMUkIzbVdVd0NJQ1J1RmtvTXZvdmdJM2JXYTJE?=
 =?utf-8?B?US91ZTVVRXVjMFBFdlZqUVFLUkpWRFZwRWNrWk5PcmFsMXdqOFJUblUxbEtK?=
 =?utf-8?B?eksycGlKZHdZWTAzU2tHTTBNdXo0STAybjAwbG9jbnpkVi9QQ25nWjdtbG1y?=
 =?utf-8?B?MUE1OENEM2dnUlp1WFFxNmlLZVRCOEtiWmdTUUd5K2RqdS9Vbm41Ry9UYS82?=
 =?utf-8?B?d0NLY3lXRWNEZXJmd25mQVJPOGtLODJZaXBxVmJpRkdRSXpFRzEyYzhueklt?=
 =?utf-8?Q?+lE4JMISa5M=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4306.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?R0ExK1k3aWlnSVZBSEUxRlE0T0FKRzkvZXluWFppWVEweEF5RWJIeVI2YXFN?=
 =?utf-8?B?cWxyWi94NnZOM2VReUtXa3NDdExZanROUDB3bmVvbDQ0UWx4eENRV3JQTGJM?=
 =?utf-8?B?T1d6ZmdpWi9OWHZoSFFKeHR6aFdEcTlWRGYxUmF4OTcyaFFKU0V3SS94RFJB?=
 =?utf-8?B?NXB2SDV5K2lnSzNWWURPdHZOdUkxYlFwMy9Sb1prMHpMOFZEdmVtZXlaSEl0?=
 =?utf-8?B?dFpiMHFXeFAvVW1OcUVlMTBKQkFTUU9WQU9CSnFZUUdNQnpSb1BocHdhL3dU?=
 =?utf-8?B?SnQrblc4Z0RhN2lUbGpoWTB6N3VZeTNudkthZE43SVo3cTRKcGRRNmlYbG9B?=
 =?utf-8?B?dnd5YVdqVGdhQVRzc1JVMUd2VzgzczRrMXZPSjRqcVVUUk1NYVExeDVIeDkw?=
 =?utf-8?B?TitjRXhzYTRqaENIalIzd0JNRmxhU2swNmVRRU15bm9oTWRCRU9SNlFUbWY1?=
 =?utf-8?B?OWo2SFFmNnNORFpsL3NjRll4QzdtVG9EVmF3cnpST2hsNDJINFhNclRFVTFk?=
 =?utf-8?B?R0JPVnhMZHRGMDdTcC9uS3JlQ1FrN3Z6RXZmQnplelNIdkJMbys5Nzh3bkh2?=
 =?utf-8?B?b01ZdjJYTEJXK2lwZVcwdmF6eGxMS2hCRFZSbWhXK3I4MXo3V1dBemJJVFZx?=
 =?utf-8?B?OGlhM0R2ajdUTEx0eVYxTVJjV1E4WjVIOEFlV0c3dFlCOHpHaEl5OFg4cHp5?=
 =?utf-8?B?UDZFRjFWdHd0MHBkWHYrSC9COGFKOGpnMTJiclNlMEdGZG91ZCt4eWVsb2VO?=
 =?utf-8?B?aFpWb1dJK2Q2N0EwLzhrTlJLVGlCa04yMGk3MHpEYmxOZFZLVVJ1enNMZzd6?=
 =?utf-8?B?TU96RU1iV0p2Rmp2Z0kvSng3MVhndnF1WEs5MFNuLzU4bzI4WjNCMWJxcVNR?=
 =?utf-8?B?MEY3K0hKOWV4OElGc1FDbTB1UjBWL0JyL2FLb0dGekxJbEZjdVRXaCtkVHhh?=
 =?utf-8?B?YlVvSmJxSng4a05GZzBFOUlYU3pzMW84UTREU2tYUUtqbnhVSVpIUEFUaElY?=
 =?utf-8?B?VGM5YmtKc1RISkd0anNJNWQrVnFLQ3AwaVdjcXM3Rk8yM3VnNGpNWGQzb00y?=
 =?utf-8?B?aC95WW5pUkw2Q2p1YS9BNEJqRVBTRDBoc1FkUHlPWGdUeEhMM20raTlvMy8w?=
 =?utf-8?B?V29WTWd0anVOQlJzS3B1UlJQKzJIRzZYY2FkQno3dVYwbExmTDk2TS9YOCtZ?=
 =?utf-8?B?eE9Wa2FQZnBoYVQzUld2Yi9jZTR0Nk5NS21LekFkY3htZGl4QURvc0w2UHR3?=
 =?utf-8?B?dCtldjdLKzVkdFF3N2l1bDFRbnQ3Z1ZGd0pMYTIwVXRIbHpIRk1xS3JuTExi?=
 =?utf-8?B?RVRFS042VUExak1JN1NFVEV2cWl5L3VmOTJvbVhncFhhd2FXeFdCbG9xNFNl?=
 =?utf-8?B?NkVSR3J5em9acDArY0E2cno3WDJFQ0N6N1dxSmM3bVpYS0sxZUZKWkhRK2RE?=
 =?utf-8?B?QUpiN3lrN1dYZ2xvNmNuVW1MV0N3d0xGbjc5Vy9lLzU1cTkvaG1RREVsdWVq?=
 =?utf-8?B?Q2hBRXJVem1MaXlOc0pEcFVCVTN2USsvS3hpdC82VGdzTDJiVi9lZWkwK3c3?=
 =?utf-8?B?MC9ucWl2Y1RURzJPd3V5NU5rSzVMcElNZXp0Mjhoc1p0V1Z2WXk2T3FUdHl1?=
 =?utf-8?B?ZGl4K0JhTzR5ZXRwdHFTR0NRd0Z4ZGxPeG5XdnZLQ09Rby96cFJTWTZMd3lX?=
 =?utf-8?B?UkpKbm84MG41WlowVHd4M3ZmdE5teXoyN2NJZm05alI2SXpNZFFFMzduQko3?=
 =?utf-8?B?Mk4yUVB4K3BieWRZcERld1NvYUxhdkV1VzM0V25Jci8rN1YzTjhVR1hzS0JM?=
 =?utf-8?B?aml1QVQreEJERlN0UjNsMEM2VnpUbnJWNDJ0UVBrdm1SQ2RIK1l3VVppc1E4?=
 =?utf-8?B?dGdLSHp2Z3cvSDNZaEJENVN0eGpEdTdZUkRZRm83TTY0WEs4RkJqMWlMRUdC?=
 =?utf-8?B?Tk1nNzJRaTFPZFFQRzRKdFBPMEVDSnNlWWEvcXpnemE4bWJGdXVhbmdwUlRK?=
 =?utf-8?B?M1ZGQjhCWW5aakhwKzZOL1VwcGI2a0ladDlOZE5pKytMQ1pBemR4bndpOHox?=
 =?utf-8?B?M1lVb3FtSGdjK1l0MWZaWGFJbkc4aVkxbWh1MTkvYVcyQVhxU0lzdDhQajFI?=
 =?utf-8?B?QjBFckVvYWh0enltSDlwWTU5bStxVkN3NDRkVEt1M1JpdmhEUkFaaFlFWXJo?=
 =?utf-8?B?Z1E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	q3XaUSdxcli7ECHc/I1ow2CP++yTo/EZLZsaXoj8Gqu9LsExgwtf5ZNMr5QzT8odEL2XYjyww0IQq4tZG5Eiz28qtVyhCxR1gSLN61XdIeucEO5dxKuS/ZMG6wqNAhZRT0zdaxmE8elwPp8qF4jI2fqoobPZlcqzZs8c+magm1w5Teg4I3SM0nXmiF8GQzRFi2XzllGAbScWqzJPp6W4c4B/cHpxwBHRGRy3de9vHSOSzrpD23uUAUhRQK06hA7W+1gqYQjhhChvG7kAcUmEwbFJETcVTQBrc21qkoo5802EA0KWt6XvuopV0BfAfr1T6gCMq8oXY9LylF/6vVKBSQKA1Rq5OGtvYaTgE1xb+RbVIwh8IdsOscIatktH+C2TqzotuGOImPYBUONueNblABzQyL7GRnoNdNsl8xMm6ZyGltg+azWz0b1yA9mF5UshKMKde33WD/EZhujfXmv8WO7u60l7EbRqeoSwawWAnNpXzb+Mc8SuRZNPKyofMCEnoVQqe2A1RTmgxziQE/VH3a7gAIURYSGoa0vsQDDRnDbx6O8dySpwFAhPwheSge3R+mS+7ffRN1VuMN/UN8nXZ20kI2ZJBie64HyG4kPCouY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae80393d-68c3-4f0d-637f-08dd7922fca2
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4306.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2025 18:02:13.2252
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rSdwY9lSH/T/ZEYDsYfZieD4byZaDrUzojTN5tqFjkg64KNvrLTEK6VQKSzeNDIDZQz6EGPwJIa27kvdAWywjPn6des4FdhwWJQ30rGodzg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4636
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-11_07,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 suspectscore=0
 bulkscore=0 adultscore=0 malwarescore=0 phishscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502280000
 definitions=main-2504110114
X-Proofpoint-ORIG-GUID: 6lz2aEm3MqajrlPwx4FiDdkGCqPvFDdh
X-Proofpoint-GUID: 6lz2aEm3MqajrlPwx4FiDdkGCqPvFDdh

From: Håkon Bugge <haakon.bugge@oracle.com>

RDS uses a single threaded work queue for connection management. This
involves creation and deletion of QPs and CQs. On certain HCAs, such
as CX-3, these operations are para-virtualized and some part of the
work has to be conducted by the Physical Function (PF) driver.

In fail-over and fail-back situations, there might be 1000s of
connections to tear down and re-establish. Hence, expand the number
work queues.

Signed-off-by: Håkon Bugge <haakon.bugge@oracle.com>
Signed-off-by: Allison Henderson <allison.henderson@oracle.com>
---
 net/rds/connection.c |  8 +++++++-
 net/rds/ib.c         |  5 +++++
 net/rds/rds.h        |  4 ++++
 net/rds/threads.c    | 23 +++++++++++++++++++++++
 4 files changed, 39 insertions(+), 1 deletion(-)

diff --git a/net/rds/connection.c b/net/rds/connection.c
index 372542d67fdb..f7f48abf7233 100644
--- a/net/rds/connection.c
+++ b/net/rds/connection.c
@@ -171,6 +171,10 @@ static struct rds_connection *__rds_conn_create(struct net *net,
 	unsigned long flags;
 	int ret, i;
 	int npaths = (trans->t_mp_capable ? RDS_MPATH_WORKERS : 1);
+	int cp_wqs_inx = jhash_3words(laddr->s6_addr32[3],
+				      faddr->s6_addr32[3],
+				      tos,
+				      0) % RDS_NMBR_CP_WQS;
 
 	rcu_read_lock();
 	conn = rds_conn_lookup(net, head, laddr, faddr, trans, tos, dev_if);
@@ -268,7 +272,9 @@ static struct rds_connection *__rds_conn_create(struct net *net,
 		__rds_conn_path_init(conn, &conn->c_path[i],
 				     is_outgoing);
 		conn->c_path[i].cp_index = i;
-		conn->c_path[i].cp_wq = rds_wq;
+
+		rdsdebug("using rds_cp_wqs index %d\n", cp_wqs_inx);
+		conn->c_path[i].cp_wq = rds_cp_wqs[cp_wqs_inx];
 	}
 	rcu_read_lock();
 	if (rds_destroy_pending(conn))
diff --git a/net/rds/ib.c b/net/rds/ib.c
index 9826fe7f9d00..6694d31e6cfd 100644
--- a/net/rds/ib.c
+++ b/net/rds/ib.c
@@ -491,9 +491,14 @@ static int rds_ib_laddr_check(struct net *net, const struct in6_addr *addr,
 
 static void rds_ib_unregister_client(void)
 {
+	int i;
+
 	ib_unregister_client(&rds_ib_client);
 	/* wait for rds_ib_dev_free() to complete */
 	flush_workqueue(rds_wq);
+
+	for (i = 0; i < RDS_NMBR_CP_WQS; ++i)
+		flush_workqueue(rds_cp_wqs[i]);
 }
 
 static void rds_ib_set_unloading(void)
diff --git a/net/rds/rds.h b/net/rds/rds.h
index 1c51f3f6ed15..71a0020fe41d 100644
--- a/net/rds/rds.h
+++ b/net/rds/rds.h
@@ -40,6 +40,9 @@
 #ifdef ATOMIC64_INIT
 #define KERNEL_HAS_ATOMIC64
 #endif
+
+#define RDS_NMBR_CP_WQS 16
+
 #ifdef RDS_DEBUG
 #define rdsdebug(fmt, args...) pr_debug("%s(): " fmt, __func__ , ##args)
 #else
@@ -994,6 +997,7 @@ extern unsigned int  rds_sysctl_trace_level;
 int rds_threads_init(void);
 void rds_threads_exit(void);
 extern struct workqueue_struct *rds_wq;
+extern struct workqueue_struct *rds_cp_wqs[RDS_NMBR_CP_WQS];
 void rds_queue_reconnect(struct rds_conn_path *cp);
 void rds_connect_worker(struct work_struct *);
 void rds_shutdown_worker(struct work_struct *);
diff --git a/net/rds/threads.c b/net/rds/threads.c
index 639302bab51e..f713c6d9cd32 100644
--- a/net/rds/threads.c
+++ b/net/rds/threads.c
@@ -33,6 +33,7 @@
 #include <linux/kernel.h>
 #include <linux/random.h>
 #include <linux/export.h>
+#include <linux/workqueue.h>
 
 #include "rds.h"
 
@@ -70,6 +71,8 @@
  */
 struct workqueue_struct *rds_wq;
 EXPORT_SYMBOL_GPL(rds_wq);
+struct workqueue_struct *rds_cp_wqs[RDS_NMBR_CP_WQS];
+EXPORT_SYMBOL_GPL(rds_cp_wqs);
 
 void rds_connect_path_complete(struct rds_conn_path *cp, int curr)
 {
@@ -251,16 +254,36 @@ void rds_shutdown_worker(struct work_struct *work)
 
 void rds_threads_exit(void)
 {
+	int i;
+
 	destroy_workqueue(rds_wq);
+	for (i = 0; i < RDS_NMBR_CP_WQS; ++i)
+		destroy_workqueue(rds_cp_wqs[i]);
 }
 
 int rds_threads_init(void)
 {
+	int i, j;
+
 	rds_wq = create_singlethread_workqueue("krdsd");
 	if (!rds_wq)
 		return -ENOMEM;
 
+	for (i = 0; i < RDS_NMBR_CP_WQS; ++i) {
+		rds_cp_wqs[i] = alloc_ordered_workqueue("krds_cp_wq_%d",
+							WQ_MEM_RECLAIM, i);
+		if (!rds_cp_wqs[i])
+			goto err;
+	}
+
 	return 0;
+
+err:
+	destroy_workqueue(rds_wq);
+	for (j = 0; j < i; ++j)
+		destroy_workqueue(rds_cp_wqs[j]);
+
+	return -ENOMEM;
 }
 
 /* Compare two IPv6 addresses.  Return 0 if the two addresses are equal.
-- 
2.43.0


