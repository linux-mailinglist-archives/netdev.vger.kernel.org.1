Return-Path: <netdev+bounces-166318-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DD411A3577F
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 07:59:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B3B2D1892263
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 06:59:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82856205AA1;
	Fri, 14 Feb 2025 06:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="bHlU3AyQ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="j5JawTIP"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA7A02054F9;
	Fri, 14 Feb 2025 06:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739516357; cv=fail; b=XY3W/wz5bBWC60ioO/x2hT79wryqthZeuaUUUbFzYvr2bg9cGZYVdyvUp2sLdJHw8ItYLUEAfcRyfHannpV3ZCHT0U2QmYRqJdJnChnN9M5g9g5lbd4IecZzbK6efXk8ejt3wojYmakhxZoVB2UZ3CW2LHiB1IvxAebm/4MtsX0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739516357; c=relaxed/simple;
	bh=SgJH59y8F00dEYWDkf/JS80Upa+t7dKEGHoIRZH6WRM=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=KtAI5gYQDhKrp896R6rjJYgyeQoErZxTq/eUgzIfpbDNo3qJX6Fts7jIebgdDU+iVPj0ux2Z3LmWKD5pjgLCFF6PscsnpjRWewdRvYxIleNPF/qno/4GZO02zJa44x/6N7fsnnjY2AlHURzN3yxyb7mw0uc36KBLKVpTDtNHqXI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=bHlU3AyQ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=j5JawTIP; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51E1fjQn007001;
	Fri, 14 Feb 2025 06:59:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2023-11-20; bh=prvr7mrMLLl51pbO
	81GI8q8aAxBEorCyjVVlxtpM7M8=; b=bHlU3AyQX/OVuwRdgUBrXRXwsEwfOPwn
	Br32HzcapLE0KUNTqBicKa4G82XdlyXJexed9fVQq1vgPXG/rnWCY8Uhg77okvFC
	+e4Irp7Tqdl4DcfD+kLiUfn0A84dPvnxzDkN57dDpO5vHdnepU+TFzjjyc4BUaks
	0rdtR2fvmLhkxM3tTAp9l4q4McOVqsAAq/wKl38LvHgZojzD606XYMJ3G5Yrj8/6
	+vSGN2bjUSCSzG+CLJMo1ihxYFvdSWo8Xy5OfYMGS88h8OCqVXSuTtGbSnNT1Z0Q
	P2DFaYwrqq9b6PqU9c1qhX6hk0Kkyb8jsvfmTtWqblK+vq+zma4RCw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44p0tgb7ua-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 14 Feb 2025 06:59:01 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51E5hOKp025242;
	Fri, 14 Feb 2025 06:59:00 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2045.outbound.protection.outlook.com [104.47.70.45])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 44nwqkchkh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 14 Feb 2025 06:59:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QQmgmr2Ubxof2SW0lL/KNmrrCRXxnhhZiImP+5TU8tVaX/6yGo6/qDtf0Zswuq5eA5CfMCdtBuQaRrCKyEOsqI95+FBADihinR9YB+fA/X/TxjrPIMukkAIHE3R30qNyw/VaLbz5ZXYjoIjew7oQlWohozD4o9q+CaTyGjMl9l1Z+xFEPKjLq+KMYW6T30qjzpeALSOTbGtAWAlth/8PkXfvYoN3EgcAR5F5jwe4EUG5YVlfcmeTpL3nAz5NImTf1VUUeeVFGBO6Sb5bjBVrohRUz6kg1ldM48/OtGLXXsudkaoaOnhKtq7PtzOMYwNKXRPCFVeVs5Ge3AK3cpuVXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=prvr7mrMLLl51pbO81GI8q8aAxBEorCyjVVlxtpM7M8=;
 b=ognnHGuxvKtn5skBpwDBrQ+DJiQCekXw4Frnih6VEsrjvtPAQG4r8ndwDDUvxqxrHOZyUTN9+VuQsyb4rohtVZJjHydQ1KG8EBnWA7I9AMYb8PBtqRRPV27oC/n7DNR+Tj1LBUN3KrYS03UruLkLRsFPwrMicRrn3O2EKSBbUt5k3Pc1Q6kej2zhw7CzeJuiXUQi9ZHgn/xyC6HV7T6P6oeIKeHYV5IC4amPcyaLNsRiyAwL5pu5NQTp3o5+a1RXz9WnhePQYXmfiqEqD8gJ0U6zh35QevE9fHdiBpSTF5J3Tsfvk7zcWRWPqU2B10TFixHNw29fjiix5WY2buAD3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=prvr7mrMLLl51pbO81GI8q8aAxBEorCyjVVlxtpM7M8=;
 b=j5JawTIPVHF2yr+ydHcpAF1wt8GCoWTmT3y9ny9/+ma3jOEjqV2Sj3Vs1tWfJP+C3GPbtHREiKLBSsLGn2jagXzjtzAfcYErc/C14Ueg3fQnJkHhSMz60y8hnHJXJUXsFVtRNAhqug/YMDinut87xGU2VwysdI4Ax/XUIHmB9Qs=
Received: from PH0PR10MB5563.namprd10.prod.outlook.com (2603:10b6:510:f2::13)
 by MN2PR10MB4176.namprd10.prod.outlook.com (2603:10b6:208:1da::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.16; Fri, 14 Feb
 2025 06:58:58 +0000
Received: from PH0PR10MB5563.namprd10.prod.outlook.com
 ([fe80::1917:9c45:4a41:240]) by PH0PR10MB5563.namprd10.prod.outlook.com
 ([fe80::1917:9c45:4a41:240%5]) with mapi id 15.20.8445.013; Fri, 14 Feb 2025
 06:58:58 +0000
From: Siddh Raman Pant <siddh.raman.pant@oracle.com>
To: Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Paolo Abeni <pabeni@redhat.com>
Cc: netdev <netdev@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH] netlink: Unset cb_running when terminating dump on release.
Date: Fri, 14 Feb 2025 12:28:49 +0530
Message-ID: <20250214065849.28983-1-siddh.raman.pant@oracle.com>
X-Mailer: git-send-email 2.45.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0036.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::22) To PH0PR10MB5563.namprd10.prod.outlook.com
 (2603:10b6:510:f2::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5563:EE_|MN2PR10MB4176:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b439245-2776-4d3f-b8e1-08dd4cc50dfd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|10070799003|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HqBuajk0gGipHufvO/fJ0giJW5XYYmQ47Bk4jLLYsK592u5bFvi+VjZKoacF?=
 =?us-ascii?Q?f+zBlODjCEQAK7X2biH1HvrHvQrjN7s/Y6MBfW3x9EqVRy0EgjMoJuKRikEY?=
 =?us-ascii?Q?V8yyr2KtwP2yjsFMvDmlu293TbRphTS8u378vgKuZT5xgJj2Frde5YUBTRWN?=
 =?us-ascii?Q?ujP3FIUZ+K8Cn9mr9Rr44CnEDTa9n3+rmJy47ite02eWSJXOdRcvj/BLntk3?=
 =?us-ascii?Q?RHVT250AyuOpv8zfemmgsJNyJMNwHDoQaPZ9Rp4wRCNuN0nRBuVJM0pccQ2H?=
 =?us-ascii?Q?1WfhPrNB2gxAMJY/2oCQvmHr0pNob2M+o6xUWVDtTOsDGK+2OReuFqIMQo62?=
 =?us-ascii?Q?tC0ZOXcM4TEHqe3G8IPpcsBVML2GzZ/5SY8ILgYeFP+lshDwzVpeNJcqJy42?=
 =?us-ascii?Q?vPYPnJ9IhcA+T8WTIQDqLE9yJLvroPGjVSrzEd5JMlaSR6aV3zZxoSqGf/W/?=
 =?us-ascii?Q?n7MbR43w80rThkszTvFoxrnWKW/1pukm7eZmoM5U0m9ByaeNoJBnBn+kVUiW?=
 =?us-ascii?Q?ierl34RDRFFk9Ay7dKRDK/sA4NBDUv4UOxLeJt+m1FPiqwqK6ZVw1wBLYpPl?=
 =?us-ascii?Q?u9/jR0391Zls2FESawMMxV1rO6Vmvw7J2AhYBIR0SQUH9O4rO+437up5pV4f?=
 =?us-ascii?Q?kzra/vQCrLMPRinffrKEVEyKqf361YjsFDDbc/wyBgxBYR95G3IfqiLOp78e?=
 =?us-ascii?Q?jw0t+sUAook0YCuBlAZbn67+ZC+3VKJJrvYpRhXnURaBLlwvVtl73nOZEzjL?=
 =?us-ascii?Q?7spLrLWjLtfYoYZA1wNFg1YK8DBTy4o3uixqSLFinOcw7CNI6wPVaaqEfNi9?=
 =?us-ascii?Q?UL8wsBJNvsIK6ov/IxNULbpmgpqVkznEbzDPtcSuF6FUHURvL1Cs+i2YYoUp?=
 =?us-ascii?Q?AoRxFCIrUpAIw2R1w4hlTLjbCnshh+jGQvUa7unX18IYjznqZ0JER8qnjWNk?=
 =?us-ascii?Q?iccPkry2n2JHFB+d9xVDtQ3nmBroJ4hdfCLsyq+v3JUgGr1tnbBFUh5NkhwA?=
 =?us-ascii?Q?TmbzzQb8NIeQKCH+W+7b6eSkNOUr/xBb5Pmz5jHDLL0rkQLUA3xg8w3TpEir?=
 =?us-ascii?Q?emAXL9uv7TQTL+V1nx+ww/S5JSuvallzcQkYnY9HOXVXS0B5QbJtg7BqIqEq?=
 =?us-ascii?Q?Hwc07RQ05Hrks1dCasnfuKFG0JgrRFV9z+AZB+x8WDVpUwyXOMRfozsa6L3R?=
 =?us-ascii?Q?J2/ZEOj5FQidLITwyGk1U/Gyxl3BQ84c3XaiCptyGTC5Dao0uviF3buYIbOg?=
 =?us-ascii?Q?h04Mje0r6EnJDzC7u8q4Xi1W5btbAW398x+Yfggi4WLfk6nnI/VNdyrY4MF2?=
 =?us-ascii?Q?Gt1XiCf7HUlbe03dxoBwSdslWln+FNz0hl5zJ6V7beShr2jKXG9l4FMfRSbd?=
 =?us-ascii?Q?djUWTZ18GSbmfKWrM+URKgy3z9fp?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5563.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(10070799003)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?H2a1ZE8MSL/XwIy6wJP/Y41VwRrCrpx6aTRvPVF5ru319OoaBJuZTsW4J9UF?=
 =?us-ascii?Q?HffSiPvstyMnHWQSEe21eDa0Qe6k/hJLZ/8MMKwDiOEuSCnuq/nV1h27APOh?=
 =?us-ascii?Q?t4tN7FD1fqu0SUN/Ev+RYz9aI8GVoMGkVCOKSjI7Fs54jVrT0O6QExSTuOkC?=
 =?us-ascii?Q?cVLlMZm7oDvJx1Oqe4gdExxAFawoYYReJwTfFMGcFjtmFMHSmBS4y8ZlRCac?=
 =?us-ascii?Q?/NtSDNxs8iRxFsnYjVzP8ucos2qpd7kju7B+mJnHmTdXRlsvUGdbBLqivowC?=
 =?us-ascii?Q?mjBzhwn6Uj+V08IKcLCZ9mJS2Iv45uHbdSeS7a1NrfOmqLh9klFTFUWo/dsB?=
 =?us-ascii?Q?DU87L5cdk5aR7ocgtzpyRTm2PgQdnglrM2dm/AuSRrXliS//82t3YtIOYtts?=
 =?us-ascii?Q?GGaMEbLG41IX6QGxFgBbraGd4nIUBbAN5MpswsAsqhCiEV4qODV8PinSVA3g?=
 =?us-ascii?Q?WSc8wBstHoPQnTMZmBhcwayVpa6rq2q6zsOhDfj2E4NECua5I0GbzDDNlI5e?=
 =?us-ascii?Q?sMEMTfxQg4W/bxf7QNNiKaftv8LJ42DJNrKUoMNTJIl/Pe6/Q8lKzyNMiyDL?=
 =?us-ascii?Q?LuniAiYdd1r3x8HQJBIeMXXAYVBVNpR/i2iLiowJ3Yp/k4SFa/cI6NxcnhA8?=
 =?us-ascii?Q?ehK0/20DFUumwliJPXc8kYybQi6oS0WKS/J4/015TX5WMjEFKrzDdXzTKWRS?=
 =?us-ascii?Q?S/YOURWcB2h/kTwXMSaIv10HSQ03a2eK4EQmJPWO6nxXtCN5v94NT5AmbZ6Y?=
 =?us-ascii?Q?RGFwsUR7bpStgYIml1H3P82UPW7Yd6MHTVfbFcmTR17gkJZo4lXp8VjWG5nF?=
 =?us-ascii?Q?AFJxSLtVEWp9CiSdNFS3hF3e/9+Ac2iokYEoR2KA4AWcDCYkx/d8LMNE/Fa1?=
 =?us-ascii?Q?Mxg1s3Ls3FmHffpa2ci69txoyocUpWR7zUKgQDU8m7JGt1pWQLYUYtWNqrlj?=
 =?us-ascii?Q?PIQY4yhANJ1YOYoYZ75saP8gt08gmvNn5TVDahoU2Cb4a3S0iRwZYy3p31C0?=
 =?us-ascii?Q?N0DOuFdBQuRBw18IabtzffpK23jI8mFDYhqN4LdFm4DTavq8N9FnvqiMiNCH?=
 =?us-ascii?Q?OfMcqHEQD0HxYpFjv1mUgjoTSNc3LRFvF/WlSN2G/QRcgFjH3E0NFue28aIf?=
 =?us-ascii?Q?NBhmsPBbYsvfVcAqyMWpr2EP3lqFhlGIqlcTtcKQs/IFOyeUlrFQ4+UAXPxR?=
 =?us-ascii?Q?wvEeltlzCb6mPW/meoPjuMz2a0O4dVQdHtAMbW521eR90NSJFz3Ui/vLxb9L?=
 =?us-ascii?Q?lip0RisjsOYzLgUWfB+BccFp2OoiIdPyKcmsbe2ao49cjVPnyASXSX36Uijm?=
 =?us-ascii?Q?ClU7z89BJ2IBlETNV7yZXlVzAPEuf5flKe0v80mLTOiUWmqs3UIta5JTmb4i?=
 =?us-ascii?Q?JY0ikdCgbtQrS74hg84Gm7DuH9YBlmXhFvbhgnn65x5YUWH9+W9hHplT/ehl?=
 =?us-ascii?Q?LQFL9QxKWwya76yytGsohj16t/YkSfzZL2y14jZ5tqfTRG6HTdwPRt+qV60Q?=
 =?us-ascii?Q?gLJ+J4T2UgaPEUSPi07VTdPVpLkHEMrgaorKB8qTtW+1Srwy3k3hdWkraSUC?=
 =?us-ascii?Q?0R9JLc86y/FRBwFVuz0dvYXJYv1v9CVUPF1cSU09Sp7YtmcQFNEOXUBcDEe4?=
 =?us-ascii?Q?kwlhWlmQQG5LI9aSc4YcxRo=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	0nGIHkhVpiq31N6sLMLmJIib7OVwls/jg0+PgIE4e8KEywxkTQtZm8UeRBtXM+3YF1cXB/IT8vWjdM3K2NyDo+S6naceGisi0dLUkk2vGCVuAz9XEir0oo52Qj2E5EnjbfbhgjNFSsELZnMEOq2GRR1FsHqZHQfn7GKyV6s5WTk49YzJCqENfwSpzZlXYQ9OYYZVVAs/XhBzOmfM0y2RxLjdhMVfjM3/duRNPldePzgLLd3S+3gcicdfNPJs5SFVt/6T8bY7Y5/SNtVaKj2piuOxvUIOrwNG1xVaPjdNPpIqQoeZgit0Hhd+m9sCENyiYQFgtYG9lfgNmT8A1FM8JsyZmj8A48xlt55ib795ZpOmo3Pi9tx6xSOLWSN7cRae8MJ+9nRVKFJSnwMeP/kQP77S/RcrPhA17pcUr8iFWmi67E6QyaRBDwau3DWm+yrRUdB3Q19fe+/xTWflH/UHWnwYk/IRTHajR5jgGJ0A0ZLiozePoZwfOmB5YrAqZyXKEkdOQEMH0OfdWsLINfHmZhQJcNpLSU7zu4roEh3eKhEpOTT4iKT0RrG7eiIoEtRrUxH29L4CRHaneU6gzns8rgnZznFh7v87a1VhcNXiNNg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b439245-2776-4d3f-b8e1-08dd4cc50dfd
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5563.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2025 06:58:58.4609
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HOscEDrjcVK6mI4tDMu5WjD7RMQT4c/XQVfuZdiE++xEdzdVBVY15lxRIPl1wLntahfwe1JlP6Z1i27svT+gvhvMksLF2v3aAubW5J1Xc2M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4176
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-14_02,2025-02-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=999
 phishscore=0 malwarescore=0 mlxscore=0 spamscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2501170000 definitions=main-2502140051
X-Proofpoint-GUID: 0-9ojR_pX3FHducbjrtYwq4ijWMyTMGm
X-Proofpoint-ORIG-GUID: 0-9ojR_pX3FHducbjrtYwq4ijWMyTMGm

When we terminated the dump, the callback isn't running, so cb_running
should be set to false to be logically consistent.

Fixes: 1904fb9ebf91 ("netlink: terminate outstanding dump on socket close")
Fixes: 16b304f3404f ("netlink: Eliminate kmalloc in netlink dump operation.")
Signed-off-by: Siddh Raman Pant <siddh.raman.pant@oracle.com>
---
I found this by inspection and was thinking why it isn't being done. So
I thought I should ask by sending a patch.

 net/netlink/af_netlink.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/netlink/af_netlink.c b/net/netlink/af_netlink.c
index 85311226183a..f8f13058a46e 100644
--- a/net/netlink/af_netlink.c
+++ b/net/netlink/af_netlink.c
@@ -771,6 +771,7 @@ static int netlink_release(struct socket *sock)
 			nlk->cb.done(&nlk->cb);
 		module_put(nlk->cb.module);
 		kfree_skb(nlk->cb.skb);
+		WRITE_ONCE(nlk->cb_running, false);
 	}
 
 	module_put(nlk->module);
-- 
2.45.2


