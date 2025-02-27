Return-Path: <netdev+bounces-170107-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D304A47473
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 05:28:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A0191887EB6
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 04:27:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 042CD1F180C;
	Thu, 27 Feb 2025 04:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Lrn4Fzgy";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="c9yhzi77"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A2781EFF97
	for <netdev@vger.kernel.org>; Thu, 27 Feb 2025 04:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740630416; cv=fail; b=kalweMkQcQcOBKnAtuHQWUfAsgX9s+wHob8pg0t69ynEtU+I8AaEH3GyVHBaGINzqnCkB/cSpAxHqGcBQWz2tJC+1fUvHk434hIsXHzMCSQ2foWNU4i0CTN+OgdahgyKi9X6GtAJ/osZTmaabNXeAeh2QeVWzwSATkrFtQi41Gw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740630416; c=relaxed/simple;
	bh=NcoyylodknXRfht0kclkgDd5cMMdgYGe5Y7O5RXf2uE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SmVN8vX4xJ8zSD/FFQX+raqEyKexVQe5Ee5T4gcsA1zij6Ftmigd6eAu/DEqboweNMj8tcjN79OHTz1Qdw6QonwglTdolYyZ+RE1GTehhCfcAgLC9tMe3QSTvypF3FRy1LiMA66XX2YCwrXLRvbZDTNQR6TLLAiiA+/OVAoQ+H8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Lrn4Fzgy; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=c9yhzi77; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51R1fgfx022987
	for <netdev@vger.kernel.org>; Thu, 27 Feb 2025 04:26:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=8Zm+lMhzv3aygbSKx91VFZdTFDg35d6F/N0EnHQfIMI=; b=
	Lrn4Fzgyqejnt7YJh3azp0/L8WE8uPJwXuCPUq02qjchJc2acPfclJXp+S0943gE
	19BAsLXApwfpPAgtPvREkb3GadRAuH+6COifG+qRkf5idcPw3mQjfd1hjWxr+v9w
	pi69RfFcWthnXbpYoammdZ+TARM5oeJda5e6BRFOqgQLtJjAYRQfJ2N0hAJJxDvf
	L6FaiiHbWjLWZUz8CJB7SJSONFdYJm9S9d8EZXqTDTs/4xUymzuf0Mt+xvL+Cp5h
	3APj8mQ6W2TQ0MZPuSo5tqtASvkAg3D4sXpN22VZtio9fOA5HALZokF79bgD+DME
	pWA7ordE9eyPOBpH6Z3ISw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 451psf2hky-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <netdev@vger.kernel.org>; Thu, 27 Feb 2025 04:26:54 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51R2n7JW024337
	for <netdev@vger.kernel.org>; Thu, 27 Feb 2025 04:26:52 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2172.outbound.protection.outlook.com [104.47.56.172])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 44y51bneb7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <netdev@vger.kernel.org>; Thu, 27 Feb 2025 04:26:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q6+JjWiuY1Mk7dDtLsQGGUACH2YuFhUHiJ2ZJZovAZg9kDfdBk/d66mEK9a4RtjN6gpeA/Bm5Grms2lZ7KRKRZpvHVb8N38WEN6VBHJ43/lQxPW4ORmLVECwE3cki34xav9FglhIvWRHpStTPhaL2AvySy9WdGPGQiVQ+p0XxSuNYq5jf2YK5894tcukCXXmSRugjvh+uDKiHJ71x149WoShTKdDFGirImITh5y7eCtSuE9AtGr5Ie11GfSWlFWXIzl318rieiXseUHvMCQYrpLGu6Zk0XsYNVnA9/RWjtl0hMWVw7isMgJgjnKCs4vLop9zLqHn8gMzu9KuKo970w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8Zm+lMhzv3aygbSKx91VFZdTFDg35d6F/N0EnHQfIMI=;
 b=gOVvkcE153ExK4iAGn8V3mnnbk3QiQCRqVx3q3hdDPxLwl3QcL/5K7pQnPiciv/JWkY50Jg06pewX1bxg82+Z4UbVVCovwNU3fJ8+iXm3NrqwBpPJ0vDCNFoT02ApZvfjWciSIqXqMpE4j/dexjafd7M8rjvwWcuppOhhvtyprWqdQsWL9ubJ2LMCsMGl0ESSYdGx3pAccoXeo4xaqhsyGNfkaXloCFMXg5/rm3yb4U6lPJM+ZSFFnbGZwJ7u8QJHSeht6Bpcda9npZVIvn7Udrsq4KsWkyWfCcFuWy2GRLjWCxdHohFMS36hRtMpK+90HhfGm/foQnxN8yokK2ozQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8Zm+lMhzv3aygbSKx91VFZdTFDg35d6F/N0EnHQfIMI=;
 b=c9yhzi77x+1GZLKZCQSaC7zdTBvU5Vx3mwXIBGY4D+gRcjlMxtsn03a/jgpg/eAiQ/cvEzXag7PiV4i51vYv+fRYUQIG93b6jfX+4DbzSrK8zxS+J2NkEDb6W29l7SUoTzk5spg6kDYUqEI61/Ix+bh2sgwujz3g4J5P/yyAsuc=
Received: from BY5PR10MB4306.namprd10.prod.outlook.com (2603:10b6:a03:211::7)
 by SA1PR10MB7587.namprd10.prod.outlook.com (2603:10b6:806:376::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Thu, 27 Feb
 2025 04:26:50 +0000
Received: from BY5PR10MB4306.namprd10.prod.outlook.com
 ([fe80::b78:9645:2435:cf1b]) by BY5PR10MB4306.namprd10.prod.outlook.com
 ([fe80::b78:9645:2435:cf1b%7]) with mapi id 15.20.8489.019; Thu, 27 Feb 2025
 04:26:50 +0000
From: allison.henderson@oracle.com
To: netdev@vger.kernel.org
Subject: [PATCH 6/6] net/rds: Encode cp_index in TCP source port
Date: Wed, 26 Feb 2025 21:26:38 -0700
Message-ID: <20250227042638.82553-7-allison.henderson@oracle.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250227042638.82553-1-allison.henderson@oracle.com>
References: <20250227042638.82553-1-allison.henderson@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH7P220CA0135.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:327::35) To BY5PR10MB4306.namprd10.prod.outlook.com
 (2603:10b6:a03:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4306:EE_|SA1PR10MB7587:EE_
X-MS-Office365-Filtering-Correlation-Id: 77667438-62c3-48ce-1a54-08dd56e6f49c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?VWsIIr/Qmk5ryC+IKa/Q+h/PPKkkVjuTCegtZJRU3mdmbbulvspf30EGaVlS?=
 =?us-ascii?Q?gpOfSmEaIrnR+sXWWnpqM1Sk8QqIlVVEjzZu8FZLYCFblruFw2SYGrmYoOMR?=
 =?us-ascii?Q?PCByOtW59nU/9lJf0shF57stxGvlHpMULx6S2+Gn6H0j82Dgljky0SqNhc8D?=
 =?us-ascii?Q?7UFRFkqno2ackxkWbyGsfb4//7jS5DF3zwpdkGy1rVmCwQnCY8UYGhkORT/i?=
 =?us-ascii?Q?aD7SkmFMYOh+ll4zOHK0qgmpquduBMPWaFV/tS8K5hN8/u6TMisoh0aHzqC+?=
 =?us-ascii?Q?py+c3XDd5W+WaoCheDuMzdHWRQotc5IYTDKYuZySE96akTSBX/jq1l/lbT5G?=
 =?us-ascii?Q?vVVq89wxjUvjNBFsTR0wfgMd6hXDfSb7tUCOx/o+C53Z1MMt3Zess52HxCcR?=
 =?us-ascii?Q?COp5MxvF6CfdFkrZZeiwJfMfsfmMqjMpZAP+EiP8o0hohaXZ6erZli1xy2hL?=
 =?us-ascii?Q?mQ5lxEOIUfx7xC+XncH6kLlI1WHdsz4MOz0GJfFIw5/+MCjJB+YSjMt73Yf5?=
 =?us-ascii?Q?s3q8zFeMcnW2K0B0SO9j77gzrY5FAlUbDBhfuEkz/njR2KnnPZG5hoG3Egwz?=
 =?us-ascii?Q?AhRw60gNlmnt1Gn0T/5SIwsdBdU2KdRsYpnZ0MwQy+nKzYzidsuX1kFh8wZ+?=
 =?us-ascii?Q?p0KcfCdUh5uV5Rl2ExIbUHQ6o21rZQ9XwADo/GwzVGETaTI6EMCLOEQ13IiG?=
 =?us-ascii?Q?krVzrNtdYfyWtcTa2+/KZv39+UvGYlYgDB+NE2xlS3I51wedELPDMKjnJrtU?=
 =?us-ascii?Q?yUE1l5WlgF3c/j9m8+ThkZ+C2M5NHJ1+n2HKTrmXfbrSP2bNAQNAz2oHpWuU?=
 =?us-ascii?Q?Pv66c+fEeYLqEyHy4iI+fczWdAkDjmcbQhnMakCiI23ELZMBX6iT4VpPhieK?=
 =?us-ascii?Q?dZ5w9shu5qtUNpHy2UOXTAlar+Xcm9Ciw6JsTXAdwIlTEyF/UnyNfUVFyft8?=
 =?us-ascii?Q?YqXBB/ZWabt0PXwG4SLsXhM0Uf5cHKCpT/tChDFCeo11ZWHlMGs9ghJGr6yt?=
 =?us-ascii?Q?6ko2tVsTY08t+BRKMRHGP4y/Jg9rLba0oVc9QCFpnBJrmLDgvhVNC2Ot+IY+?=
 =?us-ascii?Q?JSW9Csp1aIJ72Oely1PioJFROcGCU82upg09F4aOMsroCrHh/j19hxqmjvgn?=
 =?us-ascii?Q?UwppIW9M843j2GeNnxs5miDJVvQxHjBxykncQjACCa2RsA8dzJt5wksMwy41?=
 =?us-ascii?Q?O6EtA2gqo9vq07HJ74LeNjkQBV9Fz0SoLHMp94L8Ii3awbW0O37wADiYMoAc?=
 =?us-ascii?Q?vBQrTxlLvVWooLcjhiisqiSNWSpAfDZTlDRzftrd3x1S0LKEF2B9XI39/oj8?=
 =?us-ascii?Q?pa2Q59OcnNf2agZlNR9N2KcR05G7B/T8ZdYjb2i+YuBK3OFa6nmHRb2jfHIB?=
 =?us-ascii?Q?G/hZNf5ushmfVVTiC8unEdTMEsDH?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4306.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Z6x0g9tkWQEgNrEUjIkOJgVRkn8oR3rA5QAUE+i/2R2gk9X2QC4znY3+2mtX?=
 =?us-ascii?Q?W137jYBVKW/KUt89i5V02x/ZXZhnXqmcU7sLa5/4OaZd+kxtM0sT4ZdOrCxG?=
 =?us-ascii?Q?+QhT+lFFEKU1eV1e65Fg27ct9E3sITfQ1mvy4W9vI0dHDYqFzf5K2He9oKTs?=
 =?us-ascii?Q?582Yg1/5kMpvbleFQKwUv9qdiDY2vNtru9Rqf/x4q5QOSJsG/fXJpqCM3ycL?=
 =?us-ascii?Q?A4jtZZ9KeYfufFlqb8c1gEteDh67ID6zV87AJjfCq6TtG1xCQFEounyrfRqS?=
 =?us-ascii?Q?NDKquyLddAQ9TdR4PTUZfGa+Hi1mmy8NNfWgt+VBZx5DVSJ+T4jKf1Ph/03U?=
 =?us-ascii?Q?engOEeLpTgw9SrS68MamGkg4xS+MSS1KIspTl+BrSl4NySOpPNW4qCZynGtJ?=
 =?us-ascii?Q?J9U8w+DTrQXOYIkbdTizyGUT3Fs3zNJEVpH6aKyaX3i2LD7nA+ZGuNTPaO6p?=
 =?us-ascii?Q?bAXbCgmJQMs5pMhXA9pkHnaWphZ+O83loIdXm9A/v1OaKRpsJeztHUZ89dn1?=
 =?us-ascii?Q?N7tsiFB2oyQ7erRQTYvFo8TUsJ6n55n5/uxfi3Nv4RJ5QBAAlaD1+QV0LCR2?=
 =?us-ascii?Q?OeHY9emsfoVZe2IuD/U7Fg0fXz3f+ZIRyyNydOMaA436VwWl+rcj/nLTlDFJ?=
 =?us-ascii?Q?0QVTpm3BogC6Q+0uEULVzV+uMWWc0dvbHJV6PfB56KKYwTvJmUti8+lTNVnY?=
 =?us-ascii?Q?2qvZXCpop3YVX/BcuVksfjd0RZapI5w/FbOtf2UucfVg24J08GTZL6ZpQQUy?=
 =?us-ascii?Q?Mbm0CCXfqZG1tYUxTd3k8C/3qrq/eS3cXk6i2awSnAy8UE4Qp43lm8izrsuI?=
 =?us-ascii?Q?OmNzPJAZIvQMuTv3MseKoY6a8PsCvHDsp6/ufL6ue579WfkW1TLQoFlpNfTV?=
 =?us-ascii?Q?hJpJFZfV56impCAMVT74FHmt8cQYORmH35mqj5dvpJsYzdnW+WFatRIoKS+v?=
 =?us-ascii?Q?WTqHlMewd6A7Msdysn8s10KMBgBw3/1h12dpUKLBIkxN6cy0i51ssbf/nF3i?=
 =?us-ascii?Q?44XWQXRi8IuGW2CJidRqDswaOtaKSfq2tYPeQJrAofUxEYrE3W1EznTKXjZq?=
 =?us-ascii?Q?w8YciobPHQXlD21rxctGUpPE8LECmygAbkbPMs6J/v6YIVvzKGQcr/FMlPqI?=
 =?us-ascii?Q?GNczghgdfs/3+09noM/WrnkuBa32UqEsvMc05hl5iy5ZFJKHsMLMClSAH2ok?=
 =?us-ascii?Q?/mvCQTOuzQ4fKHpiPH/XVjMG+O8wx90+HGQpV4FHCRgPocASkhVw6rWvizXc?=
 =?us-ascii?Q?5dm0hi2EoPIR/JSRPKbRpY9lcsWtnHL04qcAt8V4IbW6c3z230yZKF7WsctA?=
 =?us-ascii?Q?1t9f3VtuX1aUBszlK0roruPhBK7DB0ZNotypDekz4hsEOLsu2SD3DRx9Jlsa?=
 =?us-ascii?Q?HO6aN83MAuwBhAe9N1kpRBywwkHcTEpM1/LnS3fqnBmSwOA/bvvEBCIwlVcB?=
 =?us-ascii?Q?ep0Q3CtN2XOSwVVpNZxB7OnJdmDiL8VzD4NonWvEG0g9UtgtDSf+qxMevOiT?=
 =?us-ascii?Q?UasqWcA4XrKDxeSAkrxrKdUDSiYuE90nKjMkKKFrF8xIn1lK4g4gpn00t19S?=
 =?us-ascii?Q?7EQcpEUC9dQYMB3B/n4xgM2/A2HrQci5lmCx3XAgEDEbM2vEULvlKQKx0fxs?=
 =?us-ascii?Q?ng=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	aqZeAjx2s4632bPeKMGIVxw/+uYUXhPKrZ0dZLajwvHztJlou7/64bovfkzyvK5ho1GcO+nbD6sJ7vG+GYpX9R0XhYZPVQtFrgJarvk718ObcTZMrOzKKNVNLnb75NAg1lIqQSIY55iwv/8Ld/lxGOaOM5u+wDOUQT9w4LS2jyaoujcSIm7zhbvdpjZn0Nk9/y1zBc88YECaiQG+W1v66MAHgSRf4WGrAs/7oukMXlmP3m9wCvkBxtWY+mGo7880UMpN2CUmiaNO1NUcTXs6phMJFt4b4p52n2g6IIhjkq3hYcJewAvGt5uGp/38cSBeK0W2sfpj0z8ChSVg4ph1J8C7pDVrxEKQrMvJZiv0Cj+FIKa1hPcm8fSgox8jXHNq5vUpkyN6PW+zRpjBeg/leenKXb4BJJg0SOR0US2HVIz9KQ/M6s4cvKs2HoOR1onweQlyurhX/B/HyyTrSARhGvmy2yHV+zuIcj4OEBjL5a6F/jVP/vezFR4VDGGXHxeE90Nb3d49WRqKcFQLnpDLw64OoLFalNqNnrmylfQJJGMCy/bM1odMaAZ70FTT39xoLYd3qI4RFvpq5Q+MwNbjTINXrbSnhD9OCp3e4OfNV3Y=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77667438-62c3-48ce-1a54-08dd56e6f49c
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4306.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2025 04:26:50.4165
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U9YaYTnSGwGUV4lAXrZs5HYDVJgVvlGMlQvdEtnNGai5JA+1pn6jb9aPNvvNirgk1YYwfixarh/fHOAw3v/3uKVTu3mwNZQimMRGv7hHd4I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB7587
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-27_02,2025-02-26_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 adultscore=0 mlxlogscore=999 bulkscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502100000 definitions=main-2502270031
X-Proofpoint-ORIG-GUID: rHFPl1Fq1yQkwaud9XjfpzK5nXsfLhPW
X-Proofpoint-GUID: rHFPl1Fq1yQkwaud9XjfpzK5nXsfLhPW

From: Gerd Rausch <gerd.rausch@oracle.com>

Upon "sendmsg", RDS/TCP selects a backend connection based
on a hash calculated from the source-port ("RDS_MPATH_HASH").

However, "rds_tcp_accept_one" accepts connections
in the order they arrive, which is non-deterministic.

Therefore the mapping of the sender's "cp->cp_index"
to that of the receiver changes if the backend
connections are dropped and reconnected.

However, connection state that's preserved across reconnects
(e.g. "cp_next_rx_seq") relies on that sender<->receiver
mapping to never change.

So we make sure that client and server of the TCP connection
have the exact same "cp->cp_index" across reconnects by
encoding "cp->cp_index" in the lower three bits of the
client's TCP source port.

A new extension "RDS_EXTHDR_SPORT_IDX" is introduced,
that allows the server to tell the difference between
clients that do the "cp->cp_index" encoding, and
legacy clients that pick source ports randomly.

Signed-off-by: Gerd Rausch <gerd.rausch@oracle.com>
Signed-off-by: Allison Henderson <allison.henderson@oracle.com>
---
 net/rds/message.c     |  1 +
 net/rds/rds.h         |  3 +++
 net/rds/recv.c        |  7 +++++++
 net/rds/send.c        |  5 +++++
 net/rds/tcp.h         |  1 +
 net/rds/tcp_connect.c | 22 ++++++++++++++++++++-
 net/rds/tcp_listen.c  | 45 +++++++++++++++++++++++++++++++++++++------
 7 files changed, 77 insertions(+), 7 deletions(-)

diff --git a/net/rds/message.c b/net/rds/message.c
index 7af59d2443e5..31990ac4f3ef 100644
--- a/net/rds/message.c
+++ b/net/rds/message.c
@@ -46,6 +46,7 @@ static unsigned int	rds_exthdr_size[__RDS_EXTHDR_MAX] = {
 [RDS_EXTHDR_RDMA_DEST]	= sizeof(struct rds_ext_header_rdma_dest),
 [RDS_EXTHDR_NPATHS]	= sizeof(u16),
 [RDS_EXTHDR_GEN_NUM]	= sizeof(u32),
+[RDS_EXTHDR_SPORT_IDX]  = 1,
 };
 
 void rds_message_addref(struct rds_message *rm)
diff --git a/net/rds/rds.h b/net/rds/rds.h
index 422d5e26410e..1df58011e796 100644
--- a/net/rds/rds.h
+++ b/net/rds/rds.h
@@ -150,6 +150,7 @@ struct rds_connection {
 				c_ping_triggered:1,
 				c_pad_to_32:29;
 	int			c_npaths;
+	bool			c_with_sport_idx;
 	struct rds_connection	*c_passive;
 	struct rds_transport	*c_trans;
 
@@ -266,8 +267,10 @@ struct rds_ext_header_rdma_dest {
  */
 #define RDS_EXTHDR_NPATHS	5
 #define RDS_EXTHDR_GEN_NUM	6
+#define RDS_EXTHDR_SPORT_IDX    8
 
 #define __RDS_EXTHDR_MAX	16 /* for now */
+
 #define RDS_RX_MAX_TRACES	(RDS_MSG_RX_DGRAM_TRACE_MAX + 1)
 #define	RDS_MSG_RX_HDR		0
 #define	RDS_MSG_RX_START	1
diff --git a/net/rds/recv.c b/net/rds/recv.c
index c0a89af29d1b..f33b4904073d 100644
--- a/net/rds/recv.c
+++ b/net/rds/recv.c
@@ -204,7 +204,9 @@ static void rds_recv_hs_exthdrs(struct rds_header *hdr,
 		struct rds_ext_header_version version;
 		u16 rds_npaths;
 		u32 rds_gen_num;
+		u8     dummy;
 	} buffer;
+	bool new_with_sport_idx = false;
 	u32 new_peer_gen_num = 0;
 
 	while (1) {
@@ -221,11 +223,16 @@ static void rds_recv_hs_exthdrs(struct rds_header *hdr,
 		case RDS_EXTHDR_GEN_NUM:
 			new_peer_gen_num = be32_to_cpu(buffer.rds_gen_num);
 			break;
+		case RDS_EXTHDR_SPORT_IDX:
+			new_with_sport_idx = true;
+			break;
 		default:
 			pr_warn_ratelimited("ignoring unknown exthdr type "
 					     "0x%x\n", type);
 		}
 	}
+
+	conn->c_with_sport_idx = new_with_sport_idx;
 	/* if RDS_EXTHDR_NPATHS was not found, default to a single-path */
 	conn->c_npaths = max_t(int, conn->c_npaths, 1);
 	conn->c_ping_triggered = 0;
diff --git a/net/rds/send.c b/net/rds/send.c
index 85ab9e32105e..4a08b9774420 100644
--- a/net/rds/send.c
+++ b/net/rds/send.c
@@ -1482,6 +1482,7 @@ rds_send_probe(struct rds_conn_path *cp, __be16 sport,
 	    cp->cp_conn->c_trans->t_mp_capable) {
 		u16 npaths = cpu_to_be16(RDS_MPATH_WORKERS);
 		u32 my_gen_num = cpu_to_be32(cp->cp_conn->c_my_gen_num);
+		u8 dummy = 0;
 
 		rds_message_add_extension(&rm->m_inc.i_hdr,
 					  RDS_EXTHDR_NPATHS, &npaths,
@@ -1490,6 +1491,10 @@ rds_send_probe(struct rds_conn_path *cp, __be16 sport,
 					  RDS_EXTHDR_GEN_NUM,
 					  &my_gen_num,
 					  sizeof(u32));
+		rds_message_add_extension(&rm->m_inc.i_hdr,
+					  RDS_EXTHDR_SPORT_IDX,
+					  &dummy,
+					  sizeof(u8));
 	}
 	spin_unlock_irqrestore(&cp->cp_lock, flags);
 
diff --git a/net/rds/tcp.h b/net/rds/tcp.h
index 2000f4acd57a..3beb0557104e 100644
--- a/net/rds/tcp.h
+++ b/net/rds/tcp.h
@@ -34,6 +34,7 @@ struct rds_tcp_connection {
 	 */
 	struct mutex		t_conn_path_lock;
 	struct socket		*t_sock;
+	u32			t_client_port_group;
 	struct rds_tcp_net	*t_rtn;
 	void			*t_orig_write_space;
 	void			*t_orig_data_ready;
diff --git a/net/rds/tcp_connect.c b/net/rds/tcp_connect.c
index 97596a3c346a..950de39ac942 100644
--- a/net/rds/tcp_connect.c
+++ b/net/rds/tcp_connect.c
@@ -94,6 +94,8 @@ int rds_tcp_conn_path_connect(struct rds_conn_path *cp)
 	struct sockaddr_in6 sin6;
 	struct sockaddr_in sin;
 	struct sockaddr *addr;
+	int port_low, port_high, port;
+	int port_groups, groups_left;
 	int addrlen;
 	bool isv6;
 	int ret;
@@ -146,7 +148,25 @@ int rds_tcp_conn_path_connect(struct rds_conn_path *cp)
 		addrlen = sizeof(sin);
 	}
 
-	ret = kernel_bind(sock, addr, addrlen);
+	/* encode cp->cp_index in lowest bits of source-port */
+	inet_get_local_port_range(rds_conn_net(conn), &port_low, &port_high);
+	port_low = ALIGN(port_low, RDS_MPATH_WORKERS);
+	port_groups = (port_high - port_low + 1) / RDS_MPATH_WORKERS;
+	ret = -EADDRINUSE;
+	groups_left = port_groups;
+	while (groups_left-- > 0 && ret) {
+		if (++tc->t_client_port_group >= port_groups)
+			tc->t_client_port_group = 0;
+		port =  port_low +
+			tc->t_client_port_group * RDS_MPATH_WORKERS +
+			cp->cp_index;
+
+		if (isv6)
+			sin6.sin6_port = htons(port);
+		else
+			sin.sin_port = htons(port);
+		ret = sock->ops->bind(sock, addr, addrlen);
+	}
 	if (ret) {
 		rdsdebug("bind failed with %d at address %pI6c\n",
 			 ret, &conn->c_laddr);
diff --git a/net/rds/tcp_listen.c b/net/rds/tcp_listen.c
index e44384f0adf7..9590db118457 100644
--- a/net/rds/tcp_listen.c
+++ b/net/rds/tcp_listen.c
@@ -62,19 +62,52 @@ void rds_tcp_keepalive(struct socket *sock)
  * we special case cp_index 0 is to allow the rds probe ping itself to itself
  * get through efficiently.
  */
-static
-struct rds_tcp_connection *rds_tcp_accept_one_path(struct rds_connection *conn)
+static struct rds_tcp_connection *
+rds_tcp_accept_one_path(struct rds_connection *conn, struct socket *sock)
 {
-	int i;
-	int npaths = max_t(int, 1, conn->c_npaths);
+	union {
+		struct sockaddr_storage storage;
+		struct sockaddr addr;
+		struct sockaddr_in sin;
+		struct sockaddr_in6 sin6;
+	} saddr;
+	int sport, npaths, i_min, i_max, i;
+
+	if (conn->c_with_sport_idx &&
+	    kernel_getpeername(sock, &saddr.addr) == 0) {
+		/* cp->cp_index is encoded in lowest bits of source-port */
+		switch (saddr.addr.sa_family) {
+		case AF_INET:
+			sport = ntohs(saddr.sin.sin_port);
+			break;
+		case AF_INET6:
+			sport = ntohs(saddr.sin6.sin6_port);
+			break;
+		default:
+			sport = -1;
+		}
+	} else {
+		sport = -1;
+	}
+
+	npaths = max_t(int, 1, conn->c_npaths);
 
-	for (i = 0; i < npaths; i++) {
+	if (sport >= 0) {
+		i_min = sport % npaths;
+		i_max = i_min;
+	} else {
+		i_min = 0;
+		i_max = npaths - 1;
+	}
+
+	for (i = i_min; i <= i_max; i++) {
 		struct rds_conn_path *cp = &conn->c_path[i];
 
 		if (rds_conn_path_transition(cp, RDS_CONN_DOWN,
 					     RDS_CONN_CONNECTING))
 			return cp->cp_transport_data;
 	}
+
 	return NULL;
 }
 
@@ -222,7 +255,7 @@ int rds_tcp_accept_one(struct rds_tcp_net *rtn)
 		 * to and discarded by the sender.
 		 * We must not throw those away!
 		 */
-		rs_tcp = rds_tcp_accept_one_path(conn);
+		rs_tcp = rds_tcp_accept_one_path(conn, listen_sock);
 		if (!rs_tcp) {
 			/* It's okay to stash "new_sock", since
 			 * "rds_tcp_conn_slots_available" triggers "rds_tcp_accept_one"
-- 
2.43.0


