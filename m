Return-Path: <netdev+bounces-181740-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B9A2DA86530
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 20:02:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 13EA7444C85
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 18:02:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D2CC258CDA;
	Fri, 11 Apr 2025 18:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="jHbMxGdU";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="WevWiNQK"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A5D9259C91
	for <netdev@vger.kernel.org>; Fri, 11 Apr 2025 18:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744394545; cv=fail; b=YZ94pzdaxDkMFxCXkaBU2x2EwXy6HAPbkgU9yXEhG8dyck683hBjqtq8s3IU5KCHln5s+8+DXUxP6/IqfpufWU/VMP0fh9Z6+gfF+VXpHRr3DLzlpw3qPLU+DhS1MV/Fah7ZoxHZaub/tjGNXbUtgS43Mi8JzMglosxCHv/7R3s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744394545; c=relaxed/simple;
	bh=Z8J7zsw1rEju6mDr64fGIt/cTc0ndQyfbd3Fbr+8VZE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FwMZ9MWg0Vfu1OEVFPNzdAS4NKoDbmAUc14poPQpnzUv335AMWUA1VHo6SluMQ8rQ2Zgzsc/ssk6DE6+Sb31uiPHdjeXjrdMwL0/YjpnvNjnM3y474hwFRWbgIwtg2fJoyOluWsTet6S3yJv4qoEXndaQcQbyHuDmcbPPUcCAHg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=jHbMxGdU; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=WevWiNQK; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53BHii66031878
	for <netdev@vger.kernel.org>; Fri, 11 Apr 2025 18:02:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=2ZPv/EWbbhsaxkIURjbJANYcrHBzlCzjkWg/2ojkDQk=; b=
	jHbMxGdUWT4/MQAsHQLQXwbVsSF5y6/DCw9RgxgWKWB/co+cYiX94mtCZ5H4LUB7
	PCop/GyBGurGc00MtFftT6+ia0BHi9TiKNjuPO0iSBAfrQUETgXZ8RAeVyrbXB6a
	RTsEMu2x1hhFK8Ei9PzQC2loPn4Khw9YSUc6P7gRre12ovVQyoXSm9RnGliC13Qr
	viYJmd04GuJWjR4KqBdRIlEYhoFfEQWtLTyL1OcrdxwHN3W93cxVSg3Dy17WGxvx
	dKyzI58h1scK2O+Thz9pKrxi0CZwRICY+NaTmXFOiLGcsGJyYraf+lbe72Ox7oWC
	CECQEu2UXNC0IjFoqiqQtA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45y7drg2m4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <netdev@vger.kernel.org>; Fri, 11 Apr 2025 18:02:21 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 53BGQeeV020907
	for <netdev@vger.kernel.org>; Fri, 11 Apr 2025 18:02:20 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2044.outbound.protection.outlook.com [104.47.66.44])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 45ttymcuff-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <netdev@vger.kernel.org>; Fri, 11 Apr 2025 18:02:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RXHrxl8wV9EoSSstfPKAksdD9bZeaBJqcjdxTq06unTxja8u+UPacXxm63M4LZ+nz/8BVxJJR9LG+nomkMBFdA/8K0Jc4u96kZY9IlvxvwtKX/ZbK0qSCqAop9SEm637XW5jTc9zwGG1eTQKOmG9M5AmkNAzZXYIbAuMXJ/yhXr5xOadCMhhMe8ba0l13UKcCQVVvakOvl2vp5/9iYHGupvM6gw0HWIJl98XOc0rLB/Wcf5nEi+D7hGsxi9QLlU/1xBPFVgY2L2nZPsOMWGwSu9Ck1LbzhHZhZvgL1lvqMwGspI+neOVs6jwp8fguPT/CrJeKNCmMkcSVxvkZIlTHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2ZPv/EWbbhsaxkIURjbJANYcrHBzlCzjkWg/2ojkDQk=;
 b=RRKsVhJN8CQtHtkV3n2klcEJ6e90/psRvOA1g0npdGCnP67F+hWqRaNVU2yV1Fr3yx6kpp6MnYNaYUrU6csRpNN5rDyFwcAP0nWTKw9LaWkEbGuEO6mzRvCkhYNw0tnFIBetQqLjeWLojO2s3/5afe0GUIJGT2Tw9IWfSin1cp3VKNSz5u0TunuyENSzOQS7S+tpUo0HwGZgx41Q8ZJ/HrLeTjE+lfyEoHBpY3+C82UNW8l7iGGg1cqmwS1zLNWHBnyeMW3PzqshX9v2UKC2c3kSAOk7W9qKw7UU1XYe8CKyJl9uMZXDSqQpf96ezuDRr+8OMS9rCi1N1D1Dz6xjLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2ZPv/EWbbhsaxkIURjbJANYcrHBzlCzjkWg/2ojkDQk=;
 b=WevWiNQKT5UeX1e7FnnRHf2PJcyubc0PlOXb2dIcQ+S0a4evZ0Tv0L+8tFQmvCpZjYNnEphlPeFiUmriBtO1Y+4fUN6BhFK7qSYI7SmjYp+kNZpjoQGIgXjWHawA7+jODKHS/xV3hdJtRStnauCTBL4yCA7IYDJvQOiHZGHQeRo=
Received: from BY5PR10MB4306.namprd10.prod.outlook.com (2603:10b6:a03:211::7)
 by CO1PR10MB4689.namprd10.prod.outlook.com (2603:10b6:303:98::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8583.50; Fri, 11 Apr
 2025 18:02:17 +0000
Received: from BY5PR10MB4306.namprd10.prod.outlook.com
 ([fe80::b78:9645:2435:cf1b]) by BY5PR10MB4306.namprd10.prod.outlook.com
 ([fe80::b78:9645:2435:cf1b%5]) with mapi id 15.20.8606.029; Fri, 11 Apr 2025
 18:02:17 +0000
From: allison.henderson@oracle.com
To: netdev@vger.kernel.org
Subject: [PATCH v2 5/8] net/rds: rds_tcp_accept_one ought to not discard messages
Date: Fri, 11 Apr 2025 11:02:04 -0700
Message-ID: <20250411180207.450312-6-allison.henderson@oracle.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250411180207.450312-1-allison.henderson@oracle.com>
References: <20250411180207.450312-1-allison.henderson@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0067.namprd03.prod.outlook.com
 (2603:10b6:a03:331::12) To BY5PR10MB4306.namprd10.prod.outlook.com
 (2603:10b6:a03:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4306:EE_|CO1PR10MB4689:EE_
X-MS-Office365-Filtering-Correlation-Id: c6006c72-23bf-41ea-17d3-08dd7922ff43
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Pav4vr3yQjT+zgSIw60DRT0nVktdrwWSlc60qBpWNukgrEyzW6UgOA6e6Ht2?=
 =?us-ascii?Q?qPyowKuWhCTQQjOapYQuBrP/A+a7dSAAIyzxMtq3tpU6k80XKhQAkuzs4JsM?=
 =?us-ascii?Q?VV+qs8htb2hhyhgA31Zk4dXAUmhvRp2wdFBo7WzdnX0tSLhvIdzaDosgOP1w?=
 =?us-ascii?Q?cWikoTx07blC5QcO0jsFG6K0eGZOI+z/nyqI8X5xB/3iDqn3P/HUpYLADKDT?=
 =?us-ascii?Q?cizFJef0F5mIGIP8+TMzWKaawlMZbicPwJBfmaYDMZ1xVwU4CwqPQRT/1JSx?=
 =?us-ascii?Q?tHD3o66oACNeamed79mMOb0IP1lIdmc7L6eJuYZdz2SgFeIRG8SNGff8akgM?=
 =?us-ascii?Q?O0Rr0qI+/pf6FKr77FAhmroTwRGnAWl2FN2pX2JuBMPsM+J0kbqdLFVxCPhu?=
 =?us-ascii?Q?K1ruxTKmhOlpaxsZuGScEzRLXXJBpcoiky+WgMQWm+i57GjdGWDVfL/92Zl5?=
 =?us-ascii?Q?IMwJwLjMWVs9k2vl6nvBT19MW4fGswPjtJHIeuXbDcf+huLM0dyfydLPat+9?=
 =?us-ascii?Q?4KhzuByDh/UXkC3PRSs82J1EgfUkKL7uRlmD4uLnK3m5foBYdki8BSnfsYQq?=
 =?us-ascii?Q?uVW6fSEWfFxNRnC4gm3BNTN+qJg8DgZ3IUZ04iBe3ki6nd2rhlMPnyOOzvub?=
 =?us-ascii?Q?P9GbdQcTJxcg10U9eBMxPMG6bJj0iJU5zMzFPvWJlDhih6aqChbUTYe0BRcg?=
 =?us-ascii?Q?vfEe6maItaFkeDDia7LLH2ModeUDNGfTGusUVcEWsKktJdjX7hPRpmPwe77D?=
 =?us-ascii?Q?ixDA2dLN9jhEYyCrcF6mvJnSOAhzZ2jminnAkyc5l2uX2vRm9GZ2fPn1AN+Q?=
 =?us-ascii?Q?ZcYAWnYO+7ovYj4C1VC28S4p6O4kWAk0qO+OqXY9+IrIwU0F946UxU2TFdGs?=
 =?us-ascii?Q?AgT1vySd+TvA9Wa4BO9il9l4srYny3UcA/QYymE+a8oX84Os3lSU6dg3iVcW?=
 =?us-ascii?Q?KMCRW1duC6mLxCGyaBqwPIvL2UzEdC/RjxQzcv56qeDYIkiDRcWDUQTDGS8M?=
 =?us-ascii?Q?z5UXFaM5YGRqqT4a49dhCCcT2qgeIWBK9tdIkPkIYJbtwS+VFi9bhc8L9Jm4?=
 =?us-ascii?Q?RcnvstrCXjbpicxyiVeopHzw2VGdTMsum98dbFCstaaMCubQRlKWf16P3bUG?=
 =?us-ascii?Q?ZgQqm/VMbdTk8pEO4SDthEtAr5wnG69DzbLIRxz/+FeWQUEGVuMuTHU8E8w9?=
 =?us-ascii?Q?QDU18lWC3Wi/RKZOGZdaCGSXDjon1yFVG0tPYa1tlJr8mm4chQyO6P4pu+d6?=
 =?us-ascii?Q?sx3/b80mDvsXURUKmoVYwcY0QcfVB5yG7dnPKmK7X5GoVLNnbo7oVt4O8Lpy?=
 =?us-ascii?Q?c9/Qh7rfx57M57iCKnPv0/QJRSf0qEf1Y6hY0O6myZPtK7qdnB07LoSE/hRd?=
 =?us-ascii?Q?Atgdl5DiSY7W+PYo9jKGTFAIg7IVHFCex6wJiY8kOMBB8miSqjjQS/1dNbh3?=
 =?us-ascii?Q?Gn0UcrEBf2A=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4306.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?O06knt0YJstg9EX9lHv+XENx8vmyQH/28cpj84o/NkXW9xTwb54662nCyBoG?=
 =?us-ascii?Q?U4lnKfXyqQaINAUorc1fA9k2B3go5EHoRoMbl6tQllDtJ3j9ZvvafvYi2pma?=
 =?us-ascii?Q?Vrbjuz9I89z5+EVptdh1rlN02N/TQBmLqMMXiRzVWEFc9IGdKBUWqTtWhgbU?=
 =?us-ascii?Q?40qGwXtlv7gWOZcczaNZxi4AU3L7nOaIhwqCNd6wr12P271SGiZFJaCXT6ee?=
 =?us-ascii?Q?iW5tB7Vab/1+FM2Oe6YTptl27X85CLqFhr6SJ/VIrPbWoEauRoqTvEugwHm3?=
 =?us-ascii?Q?iSCnr1aoU770STcFWiNjgp8AuDwcENZz9JO/OJ0Gpnz+7MMDDegha/Ck4Pxl?=
 =?us-ascii?Q?NG3BnVz28vJ4abWa4jpqBLCa9sxtvaeMkm2biefPeiLqveE/uBGmdIZTm5Xd?=
 =?us-ascii?Q?ztxwZ+hvEdSHfp+DudP3zqvu2Atb94pez5iQeRRDSJrUHmM8O3lhzWT1H3iI?=
 =?us-ascii?Q?SG+lp2FQpQ8sjiHLd1Pemr+WM2lEuZhar+KvuiYPYdfiZWf/XwCRnYAW6c1v?=
 =?us-ascii?Q?abBKkAYFpkMZzwOMeW8NH+M5F89GXNn/Zlzl5pXHiHnf3vDSNEqh3ZraSf9s?=
 =?us-ascii?Q?gW71R+iTnoWpB51gczD3eGj44z17eV7UlyXpB6pcVyRJSbwv66JHY9WCCMdx?=
 =?us-ascii?Q?mJSbixSzx/VHRK4dqhCeldpWo4pgoPH5REX1HVJkGy+U/BVMI6L5N5rklYZX?=
 =?us-ascii?Q?9dFs+S8nnkONZeBGWC4Afa01iBXX2ActbZkgqb4amrMFDBiSwogDNLEpNnB5?=
 =?us-ascii?Q?529/dTVHG1Yfbzpnz1GQOtZc4WHLU4ietqzQ32TRm7D1hMSNMtCJofMMUgl6?=
 =?us-ascii?Q?ImZfIpC0DSonz/ejFo2futram/RYgZI/c+m3zXDmjd40c8C/is9a6sCJe1xU?=
 =?us-ascii?Q?NmS+a+GFhYtNqQzN/hSNDguUB1LJNiNGMxL3R++AqIkjworWnkawK5GiKgWZ?=
 =?us-ascii?Q?q+DaOT4wN7331m6cOri35KOfftZY43FvHXtlxPY2XxelVwxuIT0Nj5aLaF5f?=
 =?us-ascii?Q?ND3+KtSy89F2T1lW2rnISWFVSDhkAhvy9gXyM17s7+PJ6Hk7hcbyQq3gc3Aj?=
 =?us-ascii?Q?8WvckxuD1qI3BGgxzkcl95OXsiqzLTEeM2xZjO2pH7HlGx6uLdzC0k7YCTOg?=
 =?us-ascii?Q?5ucaJNzdakL+Xv2SSrGP1GRQWTZxNmiqLHns0OqtuFzx15uJhel8JOYEFen+?=
 =?us-ascii?Q?Aru2jzI/SzW9s72cQljNC27vE6cNDkZecnLoXMZLsTpteRptOghs+8QBe65+?=
 =?us-ascii?Q?/b+UP0o+yTFC1GkypoCeEY6hQ2tNUSfBfGjeuCeCY7XeBjbLjh3voD0eSoL/?=
 =?us-ascii?Q?hEdwxz3Q46Ax6WnOt5ktNMQf2SWHz4KvbO7ZbrWy50gp/AZO7Y2C/MyLCgMo?=
 =?us-ascii?Q?s16b34j+6bg5SXWO9TPA3qUc0CjDm5fqiIXr+aDisrinj6OLOg6Ox+kGJvjw?=
 =?us-ascii?Q?hjXyhyEYqt9wovJ1LQXq5CT0OMnvR0ojgKUaAJYeq4Egip57Or9yAjQIIi/Q?=
 =?us-ascii?Q?V92xFMgotGRSOK6rR3IYDfNjIv03ervqH+NMkwl/Q0fFK8q0AetJ0Ub0IDUd?=
 =?us-ascii?Q?lh2CJomGND1rkBITuh9UQ5zbi6L4Rcfjp2PTstdb3RR+fUKShan9qu/Bj8+N?=
 =?us-ascii?Q?1g=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	hy4CvZq1s2smt9vNfdd56Y3jlzxafAhuVgbLAjoRH7OUZTnYG9JqyaofwO282j8gJS3rFuaoxh1lc6+FodwBTOqtXxngTaefg2ca80NE3gsaKm2GD4i6lqt43jud04wo5q8hTVdrdEiFh3vPQBN7mb9QuvrOokCAHzGWEJFOWPbvg6pEEGXOSSzaps2ZP7/C03HVS1BkECgLnbBNFxJQv3kFGQ4TgTtzLfun1Ayu9qj1Q810tfgJ2YoJRusGGPJWnVNacxlA2vCLm3WHW1sp4OxrIKff9Z9wOIgnW4siL6aZFFT8vG4meAPenh7k/vaZzWIl0ppDdZvloC5JeP6zwU6gdtMSuWmN/yIoDWBRmUkaiBYF5bvRf15dnX4l9Wx22ehyW6N9+6Pv3QCHx14ljO9MnZMf46sSGRYGqUZDM3lXgm0L9HplTpzBmkzy8GCY33b9PhH/EBVEhAzi3x6dn9NgGFeJUxHl0svlBb8/jn7/KtPziLgPwEHCta1FkiR+FJHhEkviHuJ19jG1t4Q6S8SOF/XjpSa0eEOnm9/V/zzVNW6dxJMntWNzPBUA9X7PjKJDOzMY7yIHdoT7XVNuNaCglbwfQ2+joIFlHJ7THD4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6006c72-23bf-41ea-17d3-08dd7922ff43
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4306.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2025 18:02:17.7691
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WjmbActw705ejeCOm716UX50DZH1HsvfB3S+z5I06oLbgaWBXGNh7MTaPbTKFPuBTRJMKRDGOhNO1w1T9crRB/GIYJIPUi1MHlgi/JhkQFg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4689
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-11_07,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0
 mlxlogscore=999 phishscore=0 bulkscore=0 adultscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502280000 definitions=main-2504110114
X-Proofpoint-GUID: z1JbV-T0kX4GzeLncP4Iz25dVDlZIYKs
X-Proofpoint-ORIG-GUID: z1JbV-T0kX4GzeLncP4Iz25dVDlZIYKs

From: Gerd Rausch <gerd.rausch@oracle.com>

RDS/TCP differs from RDS/RDMA in that message acknowledgment
is done based on TCP sequence numbers:
As soon as the last byte of a message has been acknowledged
by the TCP stack of a peer, "rds_tcp_write_space()" goes on
to discard prior messages from the send queue.

Which is fine, for as long as the receiver never throws any messages away.

Unfortunately, that is *not* the case since the introduction of MPRDS:
commit "RDS: TCP: Enable multipath RDS for TCP"

A new function "rds_tcp_accept_one_path" was introduced,
which is entitled to return "NULL", if no connection path is currently
available.

Unfortunately, this happens after the "->accept()" call, and the new socket
often already contains messages, since the peer already transitioned
to "RDS_CONN_UP" on behalf of "TCP_ESTABLISHED".

That's also the case after this [1]:
commit "RDS: TCP: Force every connection to be initiated by numerically
smaller IP address"

which tried to address the situation of pending data by only transitioning
connections from a smaller IP address to "RDS_CONN_UP".

But even in those cases, and in particular if the "RDS_EXTHDR_NPATHS"
handshake has not occurred yet, and therefore we're working with
"c_npaths <= 1", "c_conn[0]" may be in a state distinct from
"RDS_CONN_DOWN", and therefore all messages on the just accepted socket
will be tossed away.

This fix changes "rds_tcp_accept_one":

* If connected from a peer with a larger IP address, the new socket
  will continue to get closed right away.
  With commit [1] above, there should not be any messages
  in the socket receive buffer, since the peer never transitioned
  to "RDS_CONN_UP".
  Therefore it should be okay to not make any efforts to dispatch
  the socket receive buffer.

* If connected from a peer with a smaller IP address,
  we call "rds_tcp_accept_one_path" to find a free slot/"path".
  If found, business goes on as usual.
  If none was found, we save/stash the newly accepted socket
  into "rds_tcp_accepted_sock", in order to not lose any
  messages that may have arrived already.
  We then return from "rds_tcp_accept_one" with "-ENOBUFS".
  Later on, when a slot/"path" does become available again
  (e.g. state transitioned to "RDS_CONN_DOWN",
   or HS extension header was received with "c_npaths > 1")
  we call "rds_tcp_conn_slots_available" that simply re-issues
  a "rds_tcp_accept_one_path" worker-callback and picks
  up the new socket from "rds_tcp_accepted_sock", and thereby
  continuing where it left with "-ENOBUFS" last time.
  Since a new slot has become available, those messages
  won't be lost, since processing proceeds as if that slot
  had been available the first time around.

Signed-off-by: Gerd Rausch <gerd.rausch@oracle.com>
Signed-off-by: Jack Vogel <jack.vogel@oracle.com>
Signed-off-by: Allison Henderson <allison.henderson@oracle.com>
---
 net/rds/connection.c |   4 ++
 net/rds/rds.h        |  65 ++++++++++--------
 net/rds/recv.c       |   4 ++
 net/rds/tcp.c        |  27 +++-----
 net/rds/tcp.h        |  22 +++++-
 net/rds/tcp_listen.c | 156 ++++++++++++++++++++++++++++++-------------
 6 files changed, 186 insertions(+), 92 deletions(-)

diff --git a/net/rds/connection.c b/net/rds/connection.c
index cfea54740219..05adbcd3c7b3 100644
--- a/net/rds/connection.c
+++ b/net/rds/connection.c
@@ -435,6 +435,10 @@ void rds_conn_shutdown(struct rds_conn_path *cp)
 	 * to the conn hash, so we never trigger a reconnect on this
 	 * conn - the reconnect is always triggered by the active peer. */
 	cancel_delayed_work_sync(&cp->cp_conn_w);
+
+	if (conn->c_trans->conn_slots_available)
+		conn->c_trans->conn_slots_available(conn);
+
 	rcu_read_lock();
 	if (!hlist_unhashed(&conn->c_hash_node)) {
 		rcu_read_unlock();
diff --git a/net/rds/rds.h b/net/rds/rds.h
index d8d3abb2d5a6..0d66d4f4cc63 100644
--- a/net/rds/rds.h
+++ b/net/rds/rds.h
@@ -510,33 +510,6 @@ struct rds_notifier {
  */
 #define	RDS_TRANS_LOOP	3
 
-/**
- * struct rds_transport -  transport specific behavioural hooks
- *
- * @xmit: .xmit is called by rds_send_xmit() to tell the transport to send
- *        part of a message.  The caller serializes on the send_sem so this
- *        doesn't need to be reentrant for a given conn.  The header must be
- *        sent before the data payload.  .xmit must be prepared to send a
- *        message with no data payload.  .xmit should return the number of
- *        bytes that were sent down the connection, including header bytes.
- *        Returning 0 tells the caller that it doesn't need to perform any
- *        additional work now.  This is usually the case when the transport has
- *        filled the sending queue for its connection and will handle
- *        triggering the rds thread to continue the send when space becomes
- *        available.  Returning -EAGAIN tells the caller to retry the send
- *        immediately.  Returning -ENOMEM tells the caller to retry the send at
- *        some point in the future.
- *
- * @conn_shutdown: conn_shutdown stops traffic on the given connection.  Once
- *                 it returns the connection can not call rds_recv_incoming().
- *                 This will only be called once after conn_connect returns
- *                 non-zero success and will The caller serializes this with
- *                 the send and connecting paths (xmit_* and conn_*).  The
- *                 transport is responsible for other serialization, including
- *                 rds_recv_incoming().  This is called in process context but
- *                 should try hard not to block.
- */
-
 struct rds_transport {
 	char			t_name[TRANSNAMSIZ];
 	struct list_head	t_item;
@@ -549,10 +522,48 @@ struct rds_transport {
 			   __u32 scope_id);
 	int (*conn_alloc)(struct rds_connection *conn, gfp_t gfp);
 	void (*conn_free)(void *data);
+
+	/*
+	 * conn_slots_available is invoked when a previously unavailable connection slot
+	 * becomes available again. rds_tcp_accept_one_path may return -ENOBUFS if it
+	 * cannot find an available slot, and then stashes the new socket in
+	 * "rds_tcp_accepted_sock". This function re-issues `rds_tcp_accept_one_path`,
+	 * which picks up the stashed socket and continuing where it left with "-ENOBUFS"
+	 * last time.  This ensures messages received on the new socket are not discarded
+	 * when no connection path was available at the time.
+	 */
+	void (*conn_slots_available)(struct rds_connection *conn);
 	int (*conn_path_connect)(struct rds_conn_path *cp);
+
+	/*
+	 * conn_shutdown stops traffic on the given connection.  Once
+	 * it returns the connection can not call rds_recv_incoming().
+	 * This will only be called once after conn_connect returns
+	 * non-zero success and will The caller serializes this with
+	 * the send and connecting paths (xmit_* and conn_*).  The
+	 * transport is responsible for other serialization, including
+	 * rds_recv_incoming().  This is called in process context but
+	 * should try hard not to block.
+	 */
 	void (*conn_path_shutdown)(struct rds_conn_path *conn);
 	void (*xmit_path_prepare)(struct rds_conn_path *cp);
 	void (*xmit_path_complete)(struct rds_conn_path *cp);
+
+	/*
+	 * .xmit is called by rds_send_xmit() to tell the transport to send
+	 * part of a message.  The caller serializes on the send_sem so this
+	 * doesn't need to be reentrant for a given conn.  The header must be
+	 * sent before the data payload.  .xmit must be prepared to send a
+	 * message with no data payload.  .xmit should return the number of
+	 * bytes that were sent down the connection, including header bytes.
+	 * Returning 0 tells the caller that it doesn't need to perform any
+	 * additional work now.  This is usually the case when the transport has
+	 * filled the sending queue for its connection and will handle
+	 * triggering the rds thread to continue the send when space becomes
+	 * available.  Returning -EAGAIN tells the caller to retry the send
+	 * immediately.  Returning -ENOMEM tells the caller to retry the send at
+	 * some point in the future.
+	 */
 	int (*xmit)(struct rds_connection *conn, struct rds_message *rm,
 		    unsigned int hdr_off, unsigned int sg, unsigned int off);
 	int (*xmit_rdma)(struct rds_connection *conn, struct rm_rdma_op *op);
diff --git a/net/rds/recv.c b/net/rds/recv.c
index 5627f80013f8..c0a89af29d1b 100644
--- a/net/rds/recv.c
+++ b/net/rds/recv.c
@@ -230,6 +230,10 @@ static void rds_recv_hs_exthdrs(struct rds_header *hdr,
 	conn->c_npaths = max_t(int, conn->c_npaths, 1);
 	conn->c_ping_triggered = 0;
 	rds_conn_peer_gen_update(conn, new_peer_gen_num);
+
+	if (conn->c_npaths > 1 &&
+	    conn->c_trans->conn_slots_available)
+		conn->c_trans->conn_slots_available(conn);
 }
 
 /* rds_start_mprds() will synchronously start multiple paths when appropriate.
diff --git a/net/rds/tcp.c b/net/rds/tcp.c
index 3cc2f303bf78..31e7425e2da9 100644
--- a/net/rds/tcp.c
+++ b/net/rds/tcp.c
@@ -213,6 +213,8 @@ void rds_tcp_set_callbacks(struct socket *sock, struct rds_conn_path *cp)
 		sock->sk->sk_data_ready = sock->sk->sk_user_data;
 
 	tc->t_sock = sock;
+	if (!tc->t_rtn)
+		tc->t_rtn = net_generic(sock_net(sock->sk), rds_tcp_netid);
 	tc->t_cpath = cp;
 	tc->t_orig_data_ready = sock->sk->sk_data_ready;
 	tc->t_orig_write_space = sock->sk->sk_write_space;
@@ -378,6 +380,7 @@ static int rds_tcp_conn_alloc(struct rds_connection *conn, gfp_t gfp)
 		}
 		mutex_init(&tc->t_conn_path_lock);
 		tc->t_sock = NULL;
+		tc->t_rtn = NULL;
 		tc->t_tinc = NULL;
 		tc->t_tinc_hdr_rem = sizeof(struct rds_header);
 		tc->t_tinc_data_rem = 0;
@@ -458,6 +461,7 @@ struct rds_transport rds_tcp_transport = {
 	.recv_path		= rds_tcp_recv_path,
 	.conn_alloc		= rds_tcp_conn_alloc,
 	.conn_free		= rds_tcp_conn_free,
+	.conn_slots_available	= rds_tcp_conn_slots_available,
 	.conn_path_connect	= rds_tcp_conn_path_connect,
 	.conn_path_shutdown	= rds_tcp_conn_path_shutdown,
 	.inc_copy_to_user	= rds_tcp_inc_copy_to_user,
@@ -473,17 +477,7 @@ struct rds_transport rds_tcp_transport = {
 	.t_unloading		= rds_tcp_is_unloading,
 };
 
-static unsigned int rds_tcp_netid;
-
-/* per-network namespace private data for this module */
-struct rds_tcp_net {
-	struct socket *rds_tcp_listen_sock;
-	struct work_struct rds_tcp_accept_w;
-	struct ctl_table_header *rds_tcp_sysctl;
-	struct ctl_table *ctl_table;
-	int sndbuf_size;
-	int rcvbuf_size;
-};
+int rds_tcp_netid;
 
 /* All module specific customizations to the RDS-TCP socket should be done in
  * rds_tcp_tune() and applied after socket creation.
@@ -526,15 +520,12 @@ static void rds_tcp_accept_worker(struct work_struct *work)
 					       struct rds_tcp_net,
 					       rds_tcp_accept_w);
 
-	while (rds_tcp_accept_one(rtn->rds_tcp_listen_sock) == 0)
+	while (rds_tcp_accept_one(rtn) == 0)
 		cond_resched();
 }
 
-void rds_tcp_accept_work(struct sock *sk)
+void rds_tcp_accept_work(struct rds_tcp_net *rtn)
 {
-	struct net *net = sock_net(sk);
-	struct rds_tcp_net *rtn = net_generic(net, rds_tcp_netid);
-
 	queue_work(rds_wq, &rtn->rds_tcp_accept_w);
 }
 
@@ -546,6 +537,8 @@ static __net_init int rds_tcp_init_net(struct net *net)
 
 	memset(rtn, 0, sizeof(*rtn));
 
+	mutex_init(&rtn->rds_tcp_accept_lock);
+
 	/* {snd, rcv}buf_size default to 0, which implies we let the
 	 * stack pick the value, and permit auto-tuning of buffer size.
 	 */
@@ -609,6 +602,8 @@ static void rds_tcp_kill_sock(struct net *net)
 
 	rtn->rds_tcp_listen_sock = NULL;
 	rds_tcp_listen_stop(lsock, &rtn->rds_tcp_accept_w);
+	if (rtn->rds_tcp_accepted_sock)
+		sock_release(rtn->rds_tcp_accepted_sock);
 	spin_lock_irq(&rds_tcp_conn_lock);
 	list_for_each_entry_safe(tc, _tc, &rds_tcp_conn_list, t_tcp_node) {
 		struct net *c_net = read_pnet(&tc->t_cpath->cp_conn->c_net);
diff --git a/net/rds/tcp.h b/net/rds/tcp.h
index 053aa7da87ef..2000f4acd57a 100644
--- a/net/rds/tcp.h
+++ b/net/rds/tcp.h
@@ -4,6 +4,21 @@
 
 #define RDS_TCP_PORT	16385
 
+/* per-network namespace private data for this module */
+struct rds_tcp_net {
+	/* serialize "rds_tcp_accept_one" with "rds_tcp_accept_lock"
+	 * to protect "rds_tcp_accepted_sock"
+	 */
+	struct mutex		rds_tcp_accept_lock;
+	struct socket		*rds_tcp_listen_sock;
+	struct socket		*rds_tcp_accepted_sock;
+	struct work_struct	rds_tcp_accept_w;
+	struct ctl_table_header	*rds_tcp_sysctl;
+	struct ctl_table	*ctl_table;
+	int			sndbuf_size;
+	int			rcvbuf_size;
+};
+
 struct rds_tcp_incoming {
 	struct rds_incoming	ti_inc;
 	struct sk_buff_head	ti_skb_list;
@@ -19,6 +34,7 @@ struct rds_tcp_connection {
 	 */
 	struct mutex		t_conn_path_lock;
 	struct socket		*t_sock;
+	struct rds_tcp_net	*t_rtn;
 	void			*t_orig_write_space;
 	void			*t_orig_data_ready;
 	void			*t_orig_state_change;
@@ -49,6 +65,7 @@ struct rds_tcp_statistics {
 };
 
 /* tcp.c */
+extern int rds_tcp_netid;
 bool rds_tcp_tune(struct socket *sock);
 void rds_tcp_set_callbacks(struct socket *sock, struct rds_conn_path *cp);
 void rds_tcp_reset_callbacks(struct socket *sock, struct rds_conn_path *cp);
@@ -57,7 +74,7 @@ void rds_tcp_restore_callbacks(struct socket *sock,
 u32 rds_tcp_write_seq(struct rds_tcp_connection *tc);
 u32 rds_tcp_snd_una(struct rds_tcp_connection *tc);
 extern struct rds_transport rds_tcp_transport;
-void rds_tcp_accept_work(struct sock *sk);
+void rds_tcp_accept_work(struct rds_tcp_net *rtn);
 int rds_tcp_laddr_check(struct net *net, const struct in6_addr *addr,
 			__u32 scope_id);
 /* tcp_connect.c */
@@ -69,7 +86,8 @@ void rds_tcp_state_change(struct sock *sk);
 struct socket *rds_tcp_listen_init(struct net *net, bool isv6);
 void rds_tcp_listen_stop(struct socket *sock, struct work_struct *acceptor);
 void rds_tcp_listen_data_ready(struct sock *sk);
-int rds_tcp_accept_one(struct socket *sock);
+void rds_tcp_conn_slots_available(struct rds_connection *conn);
+int rds_tcp_accept_one(struct rds_tcp_net *rtn);
 void rds_tcp_keepalive(struct socket *sock);
 void *rds_tcp_listen_sock_def_readable(struct net *net);
 
diff --git a/net/rds/tcp_listen.c b/net/rds/tcp_listen.c
index fced9e286f79..78d4990b2086 100644
--- a/net/rds/tcp_listen.c
+++ b/net/rds/tcp_listen.c
@@ -35,6 +35,8 @@
 #include <linux/in.h>
 #include <net/tcp.h>
 #include <trace/events/sock.h>
+#include <net/net_namespace.h>
+#include <net/netns/generic.h>
 
 #include "rds.h"
 #include "tcp.h"
@@ -66,32 +68,46 @@ struct rds_tcp_connection *rds_tcp_accept_one_path(struct rds_connection *conn)
 	int i;
 	int npaths = max_t(int, 1, conn->c_npaths);
 
-	/* for mprds, all paths MUST be initiated by the peer
-	 * with the smaller address.
-	 */
-	if (rds_addr_cmp(&conn->c_faddr, &conn->c_laddr) >= 0) {
-		/* Make sure we initiate at least one path if this
-		 * has not already been done; rds_start_mprds() will
-		 * take care of additional paths, if necessary.
-		 */
-		if (npaths == 1)
-			rds_conn_path_connect_if_down(&conn->c_path[0]);
-		return NULL;
-	}
-
 	for (i = 0; i < npaths; i++) {
 		struct rds_conn_path *cp = &conn->c_path[i];
 
 		if (rds_conn_path_transition(cp, RDS_CONN_DOWN,
-					     RDS_CONN_CONNECTING)) {
+					     RDS_CONN_CONNECTING))
 			return cp->cp_transport_data;
-		}
 	}
 	return NULL;
 }
 
-int rds_tcp_accept_one(struct socket *sock)
+void rds_tcp_conn_slots_available(struct rds_connection *conn)
+{
+	struct rds_tcp_connection *tc;
+	struct rds_tcp_net *rtn;
+
+	if (rds_destroy_pending(conn))
+		return;
+
+	tc = conn->c_path->cp_transport_data;
+	rtn = tc->t_rtn;
+	if (!rtn)
+		return;
+
+	/* As soon as a connection went down,
+	 * it is safe to schedule a "rds_tcp_accept_one"
+	 * attempt even if there are no connections pending:
+	 * Function "rds_tcp_accept_one" won't block
+	 * but simply return -EAGAIN in that case.
+	 *
+	 * Doing so is necessary to address the case where an
+	 * incoming connection on "rds_tcp_listen_sock" is ready
+	 * to be acccepted prior to a free slot being available:
+	 * the -ENOBUFS case in "rds_tcp_accept_one".
+	 */
+	rds_tcp_accept_work(rtn);
+}
+
+int rds_tcp_accept_one(struct rds_tcp_net *rtn)
 {
+	struct socket *listen_sock = rtn->rds_tcp_listen_sock;
 	struct socket *new_sock = NULL;
 	struct rds_connection *conn;
 	int ret;
@@ -109,33 +125,40 @@ int rds_tcp_accept_one(struct socket *sock)
 #endif
 	int dev_if = 0;
 
-	if (!sock) /* module unload or netns delete in progress */
+	if (!listen_sock)
 		return -ENETUNREACH;
 
-	ret = sock_create_lite(sock->sk->sk_family,
-			       sock->sk->sk_type, sock->sk->sk_protocol,
-			       &new_sock);
-	if (ret)
-		goto out;
-
-	ret = sock->ops->accept(sock, new_sock, &arg);
-	if (ret < 0)
-		goto out;
-
-	/* sock_create_lite() does not get a hold on the owner module so we
-	 * need to do it here.  Note that sock_release() uses sock->ops to
-	 * determine if it needs to decrement the reference count.  So set
-	 * sock->ops after calling accept() in case that fails.  And there's
-	 * no need to do try_module_get() as the listener should have a hold
-	 * already.
-	 */
-	new_sock->ops = sock->ops;
-	__module_get(new_sock->ops->owner);
+	mutex_lock(&rtn->rds_tcp_accept_lock);
+	new_sock = rtn->rds_tcp_accepted_sock;
+	rtn->rds_tcp_accepted_sock = NULL;
+
+	if (!new_sock) {
+		ret = sock_create_lite(listen_sock->sk->sk_family,
+				       listen_sock->sk->sk_type,
+				       listen_sock->sk->sk_protocol,
+				       &new_sock);
+		if (ret)
+			goto out;
+
+		ret = listen_sock->ops->accept(listen_sock, new_sock, &arg);
+		if (ret < 0)
+			goto out;
+
+		/* sock_create_lite() does not get a hold on the owner module so we
+		 * need to do it here.  Note that sock_release() uses sock->ops to
+		 * determine if it needs to decrement the reference count.  So set
+		 * sock->ops after calling accept() in case that fails.  And there's
+		 * no need to do try_module_get() as the listener should have a hold
+		 * already.
+		 */
+		new_sock->ops = listen_sock->ops;
+		__module_get(new_sock->ops->owner);
 
-	rds_tcp_keepalive(new_sock);
-	if (!rds_tcp_tune(new_sock)) {
-		ret = -EINVAL;
-		goto out;
+		rds_tcp_keepalive(new_sock);
+		if (!rds_tcp_tune(new_sock)) {
+			ret = -EINVAL;
+			goto out;
+		}
 	}
 
 	inet = inet_sk(new_sock->sk);
@@ -150,7 +173,7 @@ int rds_tcp_accept_one(struct socket *sock)
 	peer_addr = &daddr;
 #endif
 	rdsdebug("accepted family %d tcp %pI6c:%u -> %pI6c:%u\n",
-		 sock->sk->sk_family,
+		 listen_sock->sk->sk_family,
 		 my_addr, ntohs(inet->inet_sport),
 		 peer_addr, ntohs(inet->inet_dport));
 
@@ -170,13 +193,13 @@ int rds_tcp_accept_one(struct socket *sock)
 	}
 #endif
 
-	if (!rds_tcp_laddr_check(sock_net(sock->sk), peer_addr, dev_if)) {
+	if (!rds_tcp_laddr_check(sock_net(listen_sock->sk), peer_addr, dev_if)) {
 		/* local address connection is only allowed via loopback */
 		ret = -EOPNOTSUPP;
 		goto out;
 	}
 
-	conn = rds_conn_create(sock_net(sock->sk),
+	conn = rds_conn_create(sock_net(listen_sock->sk),
 			       my_addr, peer_addr,
 			       &rds_tcp_transport, 0, GFP_KERNEL, dev_if);
 
@@ -189,15 +212,51 @@ int rds_tcp_accept_one(struct socket *sock)
 	 * If the client reboots, this conn will need to be cleaned up.
 	 * rds_tcp_state_change() will do that cleanup
 	 */
-	rs_tcp = rds_tcp_accept_one_path(conn);
-	if (!rs_tcp)
+	if (rds_addr_cmp(&conn->c_faddr, &conn->c_laddr) < 0) {
+		/* Try to obtain a free connection slot.
+		 * If unsuccessful, we need to preserve "new_sock"
+		 * that we just accepted, since its "sk_receive_queue"
+		 * may contain messages already that have been acknowledged
+		 * to and discarded by the sender.
+		 * We must not throw those away!
+		 */
+		rs_tcp = rds_tcp_accept_one_path(conn);
+		if (!rs_tcp) {
+			/* It's okay to stash "new_sock", since
+			 * "rds_tcp_conn_slots_available" triggers "rds_tcp_accept_one"
+			 * again as soon as one of the connection slots
+			 * becomes available again
+			 */
+			rtn->rds_tcp_accepted_sock = new_sock;
+			new_sock = NULL;
+			ret = -ENOBUFS;
+			goto out;
+		}
+	} else {
+		/* This connection request came from a peer with
+		 * a larger address.
+		 * Function "rds_tcp_state_change" makes sure
+		 * that the connection doesn't transition
+		 * to state "RDS_CONN_UP", and therefore
+		 * we should not have received any messages
+		 * on this socket yet.
+		 * This is the only case where it's okay to
+		 * not dequeue messages from "sk_receive_queue".
+		 */
+		if (conn->c_npaths <= 1)
+			rds_conn_path_connect_if_down(&conn->c_path[0]);
+		rs_tcp = NULL;
 		goto rst_nsk;
+	}
+
 	mutex_lock(&rs_tcp->t_conn_path_lock);
 	cp = rs_tcp->t_cpath;
 	conn_state = rds_conn_path_state(cp);
 	WARN_ON(conn_state == RDS_CONN_UP);
-	if (conn_state != RDS_CONN_CONNECTING && conn_state != RDS_CONN_ERROR)
+	if (conn_state != RDS_CONN_CONNECTING && conn_state != RDS_CONN_ERROR) {
+		rds_conn_path_drop(cp, 0);
 		goto rst_nsk;
+	}
 	if (rs_tcp->t_sock) {
 		/* Duelling SYN has been handled in rds_tcp_accept_one() */
 		rds_tcp_reset_callbacks(new_sock, cp);
@@ -227,6 +286,9 @@ int rds_tcp_accept_one(struct socket *sock)
 		mutex_unlock(&rs_tcp->t_conn_path_lock);
 	if (new_sock)
 		sock_release(new_sock);
+
+	mutex_unlock(&rtn->rds_tcp_accept_lock);
+
 	return ret;
 }
 
@@ -254,7 +316,7 @@ void rds_tcp_listen_data_ready(struct sock *sk)
 	 * the listen socket is being torn down.
 	 */
 	if (sk->sk_state == TCP_LISTEN)
-		rds_tcp_accept_work(sk);
+		rds_tcp_accept_work(net_generic(sock_net(sk), rds_tcp_netid));
 	else
 		ready = rds_tcp_listen_sock_def_readable(sock_net(sk));
 
-- 
2.43.0


