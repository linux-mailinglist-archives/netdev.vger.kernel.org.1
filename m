Return-Path: <netdev+bounces-181742-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0616A86533
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 20:04:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C55D3ADD89
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 18:02:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3C4D259CAF;
	Fri, 11 Apr 2025 18:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="RHa7Qr6R";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="a179gjl1"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E81FB259C82
	for <netdev@vger.kernel.org>; Fri, 11 Apr 2025 18:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744394547; cv=fail; b=Kb38x9t8GihyK9HHlwo6mW5GZviz7qbw1jobMg7N0c5NE9YoElrTnplg+NJJOqkm9sJOR4pxsfFCb0IOcOV2b4+uTrdinZ38SBNo68wCImvXsCR2e4ktH1yMBjhmh7i69L10l8s1A3yLkJL1dkcvqZl62ZJ2nVM11QpSGvwZOPw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744394547; c=relaxed/simple;
	bh=B4cPiz0eZNhRA1OPDNDtNFCJzXLgONP6mh/Lafbyp7g=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dS7OB+DQdJkRCjlMcvWfT0u2YQziC4A4m3GmAru76D+jsSQjBWn9eFDR3kcTfGwSS8jvhgRDWCktQTdOz8l2fESMS6u1AA9Q3X579g2QH5B//bayggoWTF7pGluvjnhxVKGrrKrn7P5yVJOT3/Pta1omGNCDLqDyHErAO5AgCXc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=RHa7Qr6R; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=a179gjl1; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53BHs6ec006967
	for <netdev@vger.kernel.org>; Fri, 11 Apr 2025 18:02:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=R74tB0yAzAUjPm4rbmv8AEYNc74BCRGXcRm/sj8yLXo=; b=
	RHa7Qr6Rj/FZ081Kj5Z6VY2sJP2u/PTIHuni7c+T5h6N7eVlAjS9fAbzzBsVNveA
	Q5D7MTmbppgnVMtyNDl/GfyQ1f4XXUgl4MBJYIccz9IJr3LWOjiDC9j6Qp4o2Rnq
	FBJdXIgNgpHtkVcCu6GaKP4mmufnK+ETy4eg9SPsPkbyo/h7dHmuR0zJRT4L65Wd
	i5N0ltqQY2feFMAGoCQbQkcm69IvSmHcyWE5cTDQawb7DCiwB7hzJrjQeTwFZTQ4
	8nQ7uCc0WbcyGloWS5AmsbhxJccwSbaGroBEyc4FpKsxdYTNZMsKX5uinCgX1hhX
	9SO6kOwCJvag5e+e3otrIQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45y7vd00e8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <netdev@vger.kernel.org>; Fri, 11 Apr 2025 18:02:24 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 53BGVgZR016129
	for <netdev@vger.kernel.org>; Fri, 11 Apr 2025 18:02:23 GMT
Received: from dm5pr21cu001.outbound.protection.outlook.com (mail-centralusazlp17011031.outbound.protection.outlook.com [40.93.13.31])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 45ttydyngu-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <netdev@vger.kernel.org>; Fri, 11 Apr 2025 18:02:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SSEX3ICIyIZQ6R9wdzHaCPvNrC0zGzWZZaA7m9mQrHoUOlYK4rOyGFbU8VxmkOjInLZlRcSrHH7D5lMYlK+A2+hHf+8rZNQecNqQTgjzPr32bE8Q83y4woyR3qbY0nTaJzXDLktjR9UAKt9mjEDPkOKuIYFQpeD3kBaO6X4pDXwsPJP3CckigQ2jb3T+FfdvG51lEyCKr/1Ltkc1MXr74CJl/qvzgI+gdHBewlmQaVqBfriEEfzTsT6uH+YDGO5YH1fzf9sfCwbdH4DdZo7GhgwixA2E+Tjzmf0HVacp3NXdexUNra0JsPDBeWhTEhf5HCd2YFpOzLHYJjxjzP9OZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R74tB0yAzAUjPm4rbmv8AEYNc74BCRGXcRm/sj8yLXo=;
 b=Csej8dArcaxOZbfIlMeuUDn37FnDB1i2+Z/gclFEwvYB1jsp8TASiYhzZXysz1mhsuuGc2yn+m1umVC4dHbecURD93TewSRlvmTM6xOLUvD6/JpNTuigPycMLAkKXENXG9IvGngAZTuqdOwe3RRs0HoZZATMK6oFDlTSsfsz6AZTMuvfRnw8jYkQu4P54scSceTXzPWT7crgbqKghBBMMEEBs+YzizIoyr5fVfK4TG2T4P9u56Yb0qtR1TUOy5AR+3YYseCRr+2C7UTjXrNfJlYI1Knmm4nvLWr71EB3CS7rPi8vKJUbJr6vBjNfqzXRpaentDkk6omnh/fEu12Skw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R74tB0yAzAUjPm4rbmv8AEYNc74BCRGXcRm/sj8yLXo=;
 b=a179gjl1GSHgYw/4LZfRPd8LWFfHcP5Tn0jcs3BW0/oJottKnphdzfZVZHsDPZsQHTm54gn16xzpJ7c3yiHBEVldE14W/NDm3DKtYVkblTMMBFWBmXnTwfWtW8rIqSHzl98F8eICkqSiJAxZ81eXdVBeEq8EKQu/4+YJW7SH8iM=
Received: from BY5PR10MB4306.namprd10.prod.outlook.com (2603:10b6:a03:211::7)
 by SA2PR10MB4636.namprd10.prod.outlook.com (2603:10b6:806:11e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.21; Fri, 11 Apr
 2025 18:02:21 +0000
Received: from BY5PR10MB4306.namprd10.prod.outlook.com
 ([fe80::b78:9645:2435:cf1b]) by BY5PR10MB4306.namprd10.prod.outlook.com
 ([fe80::b78:9645:2435:cf1b%5]) with mapi id 15.20.8606.029; Fri, 11 Apr 2025
 18:02:21 +0000
From: allison.henderson@oracle.com
To: netdev@vger.kernel.org
Subject: [PATCH v2 7/8] net/rds: rds_tcp_conn_path_shutdown must not discard messages
Date: Fri, 11 Apr 2025 11:02:06 -0700
Message-ID: <20250411180207.450312-8-allison.henderson@oracle.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250411180207.450312-1-allison.henderson@oracle.com>
References: <20250411180207.450312-1-allison.henderson@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0076.namprd03.prod.outlook.com
 (2603:10b6:a03:331::21) To BY5PR10MB4306.namprd10.prod.outlook.com
 (2603:10b6:a03:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4306:EE_|SA2PR10MB4636:EE_
X-MS-Office365-Filtering-Correlation-Id: 16712e56-2d3a-4ff9-87c1-08dd792301c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7BLGQZ64LSF+c2iunWooqSEjgi/BogEZwbwtT/H2z/1oh2jCxFOZuvW+tEgR?=
 =?us-ascii?Q?aVtj3W5/WvSoXFcjBPo1BmPwwAxxk6n+sXvAEf8j8NiMJAvKIaQOgLy94jgP?=
 =?us-ascii?Q?Xua/nKqvk/j2E9HqkO2LF5ax1dlNl7wYPcD70Uw+jkauwng1G6oiV7NBepXu?=
 =?us-ascii?Q?Z2dkIuE+jg4IHUAY7jkZ1sVL0yTKaUjHSfNVXMG9KTqlszmvBtmxi4f1o0Zk?=
 =?us-ascii?Q?lUc9omlwXFT+Y0pIUpNDmSAePD45HuO1nt+n1tpB884QtTpCA4dP7P6vTDq9?=
 =?us-ascii?Q?zufW4BEuJceQpG2RFtIQ2F2+eCF1XeiwJ8tXbiOA6J844QuPaQV/bQjyT20U?=
 =?us-ascii?Q?FDulRdBCTVX4x1hYDR4JKkPNUShGvvU3mhppzqmyc82o8PlBKd3190zgIh0R?=
 =?us-ascii?Q?G4Qr60dPKDmmbsFRwF0GIJWnBc2iJkK/9dMSCd5+gsSY12BcAd9VQ6SS1GPr?=
 =?us-ascii?Q?zHyFngIPjy4nAJnNlwoPk1l22t/BTyTVrp8vwqJcnA2gfLqpY6ik1WWfts+A?=
 =?us-ascii?Q?waODeT/gkZw6uXrMOPPz45dK2LVNO4SIMqB6YfHirsNqxe5YhZvJpQIOtRQQ?=
 =?us-ascii?Q?hgmjqEbO5qoamfWIf7/AHAach/uI2pA4elyxJzoTnZbOKmmTOBHKPrNIdFI1?=
 =?us-ascii?Q?wzaQW4cfnJs5DGcr1BF/zwnpSmXBXbA6NIF4UoHWVpjw7UaJ+SqK5uzKfJvX?=
 =?us-ascii?Q?SjinV4lheZf5UXaEetOyPw5a62otOtKuoYO/SKit4sfFrq/ZYd69s+mtWVJf?=
 =?us-ascii?Q?5DgPP6mBTzohyDyFYKLlLsQl+D9hQgAk8B+qiOkvxIw2DLW3LWTXpwsF/eDV?=
 =?us-ascii?Q?kdbcHKyRFDVKZwjQQpHyBRONccsL5wWBz15Dy1yuHrkKTsLiKo8oyZdg3PTn?=
 =?us-ascii?Q?fDq//UbFxWul0fCoRwKnBr4ByDhxO/9ehLVMReAD49PsI7qsgZs6F/Ltv+gD?=
 =?us-ascii?Q?/zhp4dKbpdOQpB+uImnat75MMCwmv8c0f6oh95SKnwh6F5RbpNvwoF3KnnN6?=
 =?us-ascii?Q?cofWqkM+fmnwed+mnLy/YnqrRCiWbRGZKL6uYqcBnucTRcwa+wUUedOQpzFu?=
 =?us-ascii?Q?Q/21tPtnveDZ2K5F2bJlP9hSbUR72pSxOlTbP4ArkMPV/SA1eyrQ93uJnwMB?=
 =?us-ascii?Q?v0fzhLV6t5eYYHC5bih7od9va+NWxi9TMCbDaeG0roRdvOgtOk+Wodvr2u3f?=
 =?us-ascii?Q?G9jXDL3hRMWUAK0uUzybv/Mhv6y35kk/ITTD2MpxxDMreCr9Qro/ulhlTDOT?=
 =?us-ascii?Q?UCr4A4xVWrkJhyg9L3Y41r9pS8VpCLqRP5iFpifAPZhgoYudQOYfVp7jbdi/?=
 =?us-ascii?Q?WYZMvS0R35oWjy0Tv0X//xWqSTIpI1EoESau3tqcC3H3s6Q3b+6ZQhS7CcGU?=
 =?us-ascii?Q?EunENf2w1t4OE3JHm21RhHsSO/6VswA6V6YNt3VRhkpVdrrpLOWB4SJHN1tV?=
 =?us-ascii?Q?v3kmVWAWJSU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4306.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Oeq/9ZDKIaOJ5fEm3NPizHu72HjGDcwC7/cFieRVEOZ0FnwXkGVKLy43KGaF?=
 =?us-ascii?Q?VGA9HHdW0trtGy++wIUsvz5LO+7mff6coM7Ikt37PQlPlbRAJeUgyNjh0JAW?=
 =?us-ascii?Q?SypEjRYcEsP91rKp/hShuzby91/+stIFPT4rL9gIw4vs22AewBSb6ZP12fI1?=
 =?us-ascii?Q?iugkggGcTG/uoj5Ep3VlzuNGmsdRjHw3ajN+nLN5CvMiaEntOPAh4ICPGZMI?=
 =?us-ascii?Q?J+Rui98Ih87/rVa4Zuzwc9eXE3pe+w6EZV7lCxxLH4tEskDfRSLOURIJg7RK?=
 =?us-ascii?Q?dElid778GKB8HYvPMUziCOLHAkghetVsix3RgrqacMcex0kAmZAndOQQd8Ev?=
 =?us-ascii?Q?jOi+OYq2TMq5JC98wPFq6D6ig4LWia1PuzfM39WfMmf/j0tZzqKaikDwNdAO?=
 =?us-ascii?Q?jqf/yqFCPzsocUOsHJKZdb1fflv+oIICBlaRasKbxdXV5zZD6ogZw3QiwA9g?=
 =?us-ascii?Q?Kkt0tm1uJOwzY3I4du4Pya7V3js0hF/WjvciovxOM0JoaqXyXvtc2/SBgMDx?=
 =?us-ascii?Q?cg+dv02kxZi7LQAcWFKHb6Hm5uvfGGMbfxWxIYUqLCQy5Q+ubnqqqetQANj8?=
 =?us-ascii?Q?JjnHaD1zZ6UIHzjipg1ISGD4RzqV5ASsNdHthsYEXfzOHNewgrjiNnVWpcPN?=
 =?us-ascii?Q?RDvREK9X8eXNjQU/Jw7ntdZU7WxBWpJvBuikRM2m4eUg28wJEQOWMz8zT3ym?=
 =?us-ascii?Q?VS4041Tegspg+0fg3hY5nluWNildvgxAP6u/SGEMjN420jkVauxAOWHeORAX?=
 =?us-ascii?Q?TEMY4fjAoEWVA4IDRk1OfubYG+ueygAxy46Rn3Uc5cHR+2vOdRWVWx+wDLoi?=
 =?us-ascii?Q?BzR8xcMu7Aj8heJKbqSJXb1bsano8zAZliZmj8OnpETIVHv61crSn1TEHrgW?=
 =?us-ascii?Q?83fUfLZWR5o3hp4/4fDv2edOM00dCoHtRpvi+gEgCnJOfZOcIf05yNe7fa1c?=
 =?us-ascii?Q?j+3yJIjL5Uao5lrbJb+qp9FUICY2yUk/+/iEtGrTbduwQIYKsUCeIg47t52z?=
 =?us-ascii?Q?T635lv49uNPPZjQwJbylsvvuMRbzGmI/rAcATtIsDGgX2RahBEXTMOHMKDgw?=
 =?us-ascii?Q?XkcMo0/Zop72BIconrRBDWqvZjqd4o0/H79nyB8S58KUKH2nD6PmN2hT9LGL?=
 =?us-ascii?Q?Vi/igFJkm1+4E+AbiWArqV8jbDi7WSTBmH823mswbxkZCXdoL6qclNzDOSSH?=
 =?us-ascii?Q?Fxr6TcAWtmuRS8CzPAKRGY0u284Llpq9rWuHuw2WoBcEQQxcQFpNqgWEf3iW?=
 =?us-ascii?Q?foA3iL9rVD04UG00/xyy+GqiKffmR9pLSsT3OaVMjjS9UdL6/eyjbIG7KX47?=
 =?us-ascii?Q?Wd62xbh37tYGtdnLLF6JaU3Aq51Oh1s+yfmFKz/KddbDtwIPk7tc9BsCa4ju?=
 =?us-ascii?Q?z2nrDt7gkQ+wDeOgtu0zEOcwHBqClb4+1LkS9IM9WpU8tGNlEorlG9NQyp3N?=
 =?us-ascii?Q?HuIlQJUdx31mSAULItbHLpdtVZvtG5SoiC07/iTZtEyrzH7fmGUl5Oui2hUS?=
 =?us-ascii?Q?uKbjy2oN6+spTxp8r1VV6+UMI7jVQwydp3zyJA0aVG+HLm024+OW9xR+GVyl?=
 =?us-ascii?Q?7yEenyhgGzYFZZtA8/MdZuFqMgno+wldnA2eXbCUc1PrpvThIKVU9oDVZkfm?=
 =?us-ascii?Q?5Q=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	08yvuI2X6hTQ786YHSvU746/Bj3HIxUtLqFCNxq57eniwviFUeu1FVczDalNB9YJePtm2CHiBSNd5d+AnyQULKp+ENaECKMmCdt0Y4/ioLfXLgdVPtwcV3p2QyhFxjRBmJG/POrNqju7qef1g4DY9gs5c2kI46NZ7TOriiG5fUGYTG9LtEaDUiLuor01Io4NfDNDJOLNAXD9w2KoAXJqL8HLqvZn1Qs5oBtEobiucski1t2Xhk1OYZwIArlkg0gemciAC1j4Bqo1yyMcIF6tsA2ch4sXCdHPbID9se6OjZau/mJis1l7kznqw1EA54edH1MIVzk6E1Ptmxe8WSGaA4IwQUGJsZdMLZvGQONhKpdWBdJ7ZTh8ETsemtu4kN6DNg4c494WVNMF8aMDF9iL4DQXJ+pHx/SXwc28V5OlttghsCbk7/eyAaEzr/zrz+5F/JQoh7E9ZePhlBXo9M6c8zkBsfbe8GYtg5YR+8GFAMml7Mc0GsvobL8xk0/KqzIVY7RDjSO9fZw6CeuEO2R4/CrINVAhNXhbYUgEQ/IGY4d7NBKCVUoL6BxYbfzqmCXbwooZf7ZsYf0KGOMNCOgRM7Xh1QRk2WRWVOJE0+Ke0Dk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16712e56-2d3a-4ff9-87c1-08dd792301c6
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4306.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2025 18:02:21.8861
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R6fU82Xs8dzbgsDeXlJ6TFQ851OvybmYcRrY9ovWSvJm2E6UigYcDmJMl4S8K/mnVWQ2jyVcCSnxG3PEMcwLC/sdslpp3r5743Hc+GiOAM4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4636
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-11_07,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 suspectscore=0
 bulkscore=0 adultscore=0 malwarescore=0 phishscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502280000
 definitions=main-2504110114
X-Proofpoint-ORIG-GUID: p11ImQKJF_svxCMvFY9HyOsajrkaEOjW
X-Proofpoint-GUID: p11ImQKJF_svxCMvFY9HyOsajrkaEOjW

From: Gerd Rausch <gerd.rausch@oracle.com>

RDS/TCP differs from RDS/RDMA in that message acknowledgment
is done based on TCP sequence numbers:
As soon as the last byte of a message has been acknowledged by the
TCP stack of a peer, rds_tcp_write_space() goes on to discard
prior messages from the send queue.

Which is fine, for as long as the receiver never throws any messages
away.

The dequeuing of messages in RDS/TCP is done either from the
"sk_data_ready" callback pointing to rds_tcp_data_ready()
(the most common case), or from the receive worker pointing
to rds_tcp_recv_path() which is called for as long as the
connection is "RDS_CONN_UP".

However, as soon as rds_conn_path_drop() is called for whatever reason,
including "DR_USER_RESET", "cp_state" transitions to "RDS_CONN_ERROR",
and rds_tcp_restore_callbacks() ends up restoring the callbacks
and thereby disabling message receipt.

So messages already acknowledged to the sender were dropped.

Furthermore, the "->shutdown" callback was always called
with an invalid parameter ("RCV_SHUTDOWN | SEND_SHUTDOWN == 3"),
instead of the correct pre-increment value ("SHUT_RDWR == 2").
inet_shutdown() returns "-EINVAL" in such cases, rendering
this call a NOOP.

So we change rds_tcp_conn_path_shutdown() to do the proper
"->shutdown(SHUT_WR)" call in order to signal EOF to the peer
and make it transition to "TCP_CLOSE_WAIT" (RFC 793).

This should make the peer also enter rds_tcp_conn_path_shutdown()
and do the same.

This allows us to dequeue all messages already received
and acknowledged to the peer.
We do so, until we know that the receive queue no longer has data
(skb_queue_empty()) and that we couldn't have any data
in flight anymore, because the socket transitioned to
any of the states "CLOSING", "TIME_WAIT", "CLOSE_WAIT",
"LAST_ACK", or "CLOSE" (RFC 793).

However, if we do just that, we suddenly see duplicate RDS
messages being delivered to the application.
So what gives?

Turns out that with MPRDS and its multitude of backend connections,
retransmitted messages ("RDS_FLAG_RETRANSMITTED") can outrace
the dequeuing of their original counterparts.

And the duplicate check implemented in rds_recv_local() only
discards duplicates if flag "RDS_FLAG_RETRANSMITTED" is set.

Rather curious, because a duplicate is a duplicate; it shouldn't
matter which copy is looked at and delivered first.

To avoid this entire situation, in recognition that can't fix
all of this brokenness in a single commit, we simply make
the sender discard messages from the send-queue right from
within rds_tcp_conn_path_shutdown().
Just like rds_tcp_write_space() would have done, were it
called in time or still called.

This makes sure that we no longer have messages that we know
the receiver already dequeued sitting in our send-queue,
and therefore avoid the entire "RDS_FLAG_RETRANSMITTED" fiasco.

Now we got rid of the duplicate RDS message delivery, but we
still run into cases where RDS messages are dropped.

This time it is due to the delayed setting of the socket-callbacks
in rds_tcp_accept_one() via either rds_tcp_reset_callbacks()
or rds_tcp_set_callbacks().

By the time rds_tcp_accept_one() gets there, the socket
may already have transitioned into state "TCP_CLOSE_WAIT",
but rds_tcp_state_change() was never called.

Subsequently, "->shutdown(SHUT_WR)" did not happen either.
So the peer ends up getting stuck in state "TCP_FIN_WAIT2".

We fix that by checking for states "TCP_CLOSE_WAIT", "TCP_LAST_ACK",
or "TCP_CLOSE" and drop the freshly accepted socket in that case.

This problem is observable by running "rds-stress --reset"
frequently on either of the two sides of a RDS connection,
or both while other "rds-stress" processes are exchanging data.
Those "rds-stress" processes reported out-of-sequence
errors, with the expected sequence number being smaller
than the one actually received (due to the dropped messages).

Signed-off-by: Gerd Rausch <gerd.rausch@oracle.com>
Signed-off-by: Allison Henderson <allison.henderson@oracle.com>
---
 net/rds/tcp.c         |  1 +
 net/rds/tcp.h         |  4 ++++
 net/rds/tcp_connect.c | 46 ++++++++++++++++++++++++++++++++++++++++++-
 net/rds/tcp_listen.c  | 14 +++++++++++++
 net/rds/tcp_recv.c    |  4 ++++
 net/rds/tcp_send.c    |  2 +-
 6 files changed, 69 insertions(+), 2 deletions(-)

diff --git a/net/rds/tcp.c b/net/rds/tcp.c
index 31e7425e2da9..45484a93d75f 100644
--- a/net/rds/tcp.c
+++ b/net/rds/tcp.c
@@ -384,6 +384,7 @@ static int rds_tcp_conn_alloc(struct rds_connection *conn, gfp_t gfp)
 		tc->t_tinc = NULL;
 		tc->t_tinc_hdr_rem = sizeof(struct rds_header);
 		tc->t_tinc_data_rem = 0;
+		init_waitqueue_head(&tc->t_recv_done_waitq);
 
 		conn->c_path[i].cp_transport_data = tc;
 		tc->t_cpath = &conn->c_path[i];
diff --git a/net/rds/tcp.h b/net/rds/tcp.h
index 3beb0557104e..1893bc4bd342 100644
--- a/net/rds/tcp.h
+++ b/net/rds/tcp.h
@@ -55,6 +55,9 @@ struct rds_tcp_connection {
 	u32			t_last_sent_nxt;
 	u32			t_last_expected_una;
 	u32			t_last_seen_una;
+
+	/* for rds_tcp_conn_path_shutdown */
+	wait_queue_head_t	t_recv_done_waitq;
 };
 
 struct rds_tcp_statistics {
@@ -105,6 +108,7 @@ void rds_tcp_xmit_path_prepare(struct rds_conn_path *cp);
 void rds_tcp_xmit_path_complete(struct rds_conn_path *cp);
 int rds_tcp_xmit(struct rds_connection *conn, struct rds_message *rm,
 		 unsigned int hdr_off, unsigned int sg, unsigned int off);
+int rds_tcp_is_acked(struct rds_message *rm, uint64_t ack);
 void rds_tcp_write_space(struct sock *sk);
 
 /* tcp_stats.c */
diff --git a/net/rds/tcp_connect.c b/net/rds/tcp_connect.c
index 6b9d4776e504..f832cdfe149b 100644
--- a/net/rds/tcp_connect.c
+++ b/net/rds/tcp_connect.c
@@ -75,8 +75,16 @@ void rds_tcp_state_change(struct sock *sk)
 			rds_connect_path_complete(cp, RDS_CONN_CONNECTING);
 		}
 		break;
+	case TCP_CLOSING:
+	case TCP_TIME_WAIT:
+		if (wq_has_sleeper(&tc->t_recv_done_waitq))
+			wake_up(&tc->t_recv_done_waitq);
+		break;
 	case TCP_CLOSE_WAIT:
+	case TCP_LAST_ACK:
 	case TCP_CLOSE:
+		if (wq_has_sleeper(&tc->t_recv_done_waitq))
+			wake_up(&tc->t_recv_done_waitq);
 		rds_conn_path_drop(cp, false);
 		break;
 	default:
@@ -225,6 +233,7 @@ void rds_tcp_conn_path_shutdown(struct rds_conn_path *cp)
 {
 	struct rds_tcp_connection *tc = cp->cp_transport_data;
 	struct socket *sock = tc->t_sock;
+	unsigned int rounds;
 
 	rdsdebug("shutting down conn %p tc %p sock %p\n",
 		 cp->cp_conn, tc, sock);
@@ -232,8 +241,43 @@ void rds_tcp_conn_path_shutdown(struct rds_conn_path *cp)
 	if (sock) {
 		if (rds_destroy_pending(cp->cp_conn))
 			sock_no_linger(sock->sk);
-		sock->ops->shutdown(sock, RCV_SHUTDOWN | SEND_SHUTDOWN);
+
+		sock->ops->shutdown(sock, SHUT_WR);
+
+		/* after sending FIN,
+		 * wait until we processed all incoming messages
+		 * and we're sure that there won't be any more:
+		 * i.e. state CLOSING, TIME_WAIT, CLOSE_WAIT,
+		 * LAST_ACK, or CLOSE (RFC 793).
+		 *
+		 * Give up waiting after 5 seconds and allow messages
+		 * to theoretically get dropped, if the TCP transition
+		 * didn't happen.
+		 */
+		rounds = 0;
+		do {
+			/* we need to ensure messages are dequeued here
+			 * since "rds_recv_worker" only dispatches messages
+			 * while the connection is still in RDS_CONN_UP
+			 * and there is no guarantee that "rds_tcp_data_ready"
+			 * was called nor that "sk_data_ready" still points to it.
+			 */
+			rds_tcp_recv_path(cp);
+		} while (!wait_event_timeout(tc->t_recv_done_waitq,
+					     (sock->sk->sk_state == TCP_CLOSING ||
+					      sock->sk->sk_state == TCP_TIME_WAIT ||
+					      sock->sk->sk_state == TCP_CLOSE_WAIT ||
+					      sock->sk->sk_state == TCP_LAST_ACK ||
+					      sock->sk->sk_state == TCP_CLOSE) &&
+					     skb_queue_empty_lockless(&sock->sk->sk_receive_queue),
+					     msecs_to_jiffies(100)) &&
+			 ++rounds < 50);
 		lock_sock(sock->sk);
+
+		/* discard messages that the peer received already */
+		tc->t_last_seen_una = rds_tcp_snd_una(tc);
+		rds_send_path_drop_acked(cp, rds_tcp_snd_una(tc), rds_tcp_is_acked);
+
 		rds_tcp_restore_callbacks(sock, tc); /* tc->tc_sock = NULL */
 
 		release_sock(sock->sk);
diff --git a/net/rds/tcp_listen.c b/net/rds/tcp_listen.c
index 30146204dc6c..a9596440a456 100644
--- a/net/rds/tcp_listen.c
+++ b/net/rds/tcp_listen.c
@@ -299,6 +299,20 @@ int rds_tcp_accept_one(struct rds_tcp_net *rtn)
 		rds_tcp_set_callbacks(new_sock, cp);
 		rds_connect_path_complete(cp, RDS_CONN_CONNECTING);
 	}
+
+	/* Since "rds_tcp_set_callbacks" happens this late
+	 * the connection may already have been closed without
+	 * "rds_tcp_state_change" doing its due dilligence.
+	 *
+	 * If that's the case, we simply drop the path,
+	 * knowing that "rds_tcp_conn_path_shutdown" will
+	 * dequeue pending messages.
+	 */
+	if (new_sock->sk->sk_state == TCP_CLOSE_WAIT ||
+	    new_sock->sk->sk_state == TCP_LAST_ACK ||
+	    new_sock->sk->sk_state == TCP_CLOSE)
+		rds_conn_path_drop(cp, 0);
+
 	new_sock = NULL;
 	ret = 0;
 	if (conn->c_npaths == 0)
diff --git a/net/rds/tcp_recv.c b/net/rds/tcp_recv.c
index b7cf7f451430..49f96ee0c40f 100644
--- a/net/rds/tcp_recv.c
+++ b/net/rds/tcp_recv.c
@@ -278,6 +278,10 @@ static int rds_tcp_read_sock(struct rds_conn_path *cp, gfp_t gfp)
 	rdsdebug("tcp_read_sock for tc %p gfp 0x%x returned %d\n", tc, gfp,
 		 desc.error);
 
+	if (skb_queue_empty_lockless(&sock->sk->sk_receive_queue) &&
+	    wq_has_sleeper(&tc->t_recv_done_waitq))
+		wake_up(&tc->t_recv_done_waitq);
+
 	return desc.error;
 }
 
diff --git a/net/rds/tcp_send.c b/net/rds/tcp_send.c
index 4e82c9644aa6..7c52acc749cf 100644
--- a/net/rds/tcp_send.c
+++ b/net/rds/tcp_send.c
@@ -169,7 +169,7 @@ int rds_tcp_xmit(struct rds_connection *conn, struct rds_message *rm,
  * unacked byte of the TCP sequence space.  We have to do very careful
  * wrapping 32bit comparisons here.
  */
-static int rds_tcp_is_acked(struct rds_message *rm, uint64_t ack)
+int rds_tcp_is_acked(struct rds_message *rm, uint64_t ack)
 {
 	if (!test_bit(RDS_MSG_HAS_ACK_SEQ, &rm->m_flags))
 		return 0;
-- 
2.43.0


