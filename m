Return-Path: <netdev+bounces-138082-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CF399ABD96
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 07:01:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B98771F22C85
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 05:01:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02E581369BB;
	Wed, 23 Oct 2024 05:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=drivenets.onmicrosoft.com header.i=@drivenets.onmicrosoft.com header.b="WY97jCyK"
X-Original-To: netdev@vger.kernel.org
Received: from dispatch1-eu1.ppe-hosted.com (dispatch1-eu1.ppe-hosted.com [185.183.29.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18C372837A
	for <netdev@vger.kernel.org>; Wed, 23 Oct 2024 05:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.183.29.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729659684; cv=fail; b=laibBGd9/6MTvnB611Qrtq3pk+upp7TkgTW1exnilo5y/sebU9Vh1wCOZA4Zkt3C5xN1fVt4yThiAbBLXd78Js8N8KtDpaN1EhkIawBFWFc3RrxzT1NfrPX1/UZG9EcR4D80a4A14vXGrQyD1HPnNdwhm5jG4MvrdhMyo9DA/4M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729659684; c=relaxed/simple;
	bh=aorJ1Ahh9LpxXXHG2CVvAPp/KXW9ELRWbMv4vWlyUlo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nRNDxCSaCrXivzsp5UDq6um8gl6DSAxZkrWwE408wMD+eG8pJuZknZ4qq9js0K45jTswD7dIE1Dxs9SMZGNIYgYQHUSQODlNkkUSVzAN0VCi0jdZuUlzyqAUWJQj02bUXNDejkAuvCfUzPjVQdm2xhCHrLMPyqDtKSec6atI+ho=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=drivenets.com; spf=pass smtp.mailfrom=drivenets.com; dkim=pass (1024-bit key) header.d=drivenets.onmicrosoft.com header.i=@drivenets.onmicrosoft.com header.b=WY97jCyK; arc=fail smtp.client-ip=185.183.29.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=drivenets.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=drivenets.com
X-Virus-Scanned: Proofpoint Essentials engine
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03lp2174.outbound.protection.outlook.com [104.47.51.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1-eu1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id 44A52340051;
	Wed, 23 Oct 2024 05:01:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rNz+la++IDlcYcvASP24j1aG9U8rD7gkr0FOA8VOz56ZlL3ifGefxEgCZGR2IpkA9SenGw448i4jhLL3y7I7Ki6ggrhwkOWXRalunTptl8/pjUA2mh8cfqLT2Ohi6/HK90NS1wE8iiT2EEqEeafKrFkv2PcOnWdyi8XiUdJqtaA8xOgoeQ37jFJgAcieMbTT7HS5pOBXTO1eWaFmIZq85IAZqK52L4j5RYtjAkS3BBP3BDP83a1PAyBXZFZLdA+VT4hDc0LphIyzk8J94lyXilnwRIVgkNPlROJS0LDzq7JtLWYEVoej58pO80jz9rNvSjt/bvdJdAVKMuSfe6n/Mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5NmIWOs8r7UBcMQzU2uphKWLnCY+02aVo1cw9kk+snk=;
 b=ATXOEyVjMPVfdXyte5CT19xMX/P2j9lXwb7ngYb7p6Ew9AQsZ+RQwUu5k4TBC0BoR0PoRM7u1Y1K8b4h05jGV+QLO0/sUCF87Y4fIb+Fhew9LtYT/x0nn7tNUnSWdngcqfsauEvyxAIoIYpAAst5H1z46wVVz8CtICLwPgrKHInqHpgGiY+w5yxzvup3x4B/VtQeObyRvg6NleXWJX8bnHPxWeDrbcIvXG1bGbFm1CB4cNiYzfma3YN+ihLdPWNYK/iVXLIGL1CD4KcZjC0qwNYTnAoviHtnlpRua53GGuNVH3WrO5PWiO+NKlk8lIovmriVCtT1Wj84SnONxmjp/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=drivenets.com; dmarc=pass action=none
 header.from=drivenets.com; dkim=pass header.d=drivenets.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=drivenets.onmicrosoft.com; s=selector2-drivenets-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5NmIWOs8r7UBcMQzU2uphKWLnCY+02aVo1cw9kk+snk=;
 b=WY97jCyK0riwOfpOmP21Ae1MPZiTzOBoVH+I9FJZqz9RXn9lnKKc2q/CB8LB40ujkVhL795QFAakxswpzyrROzIRX6CzmnV5BR6dxKynJrSa+fOqbYuqbHLGqwvvzUgJJABhCjGlSb49BKAOOpHeNfQsSf6Sm9B6ZkoikE6IbuE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=drivenets.com;
Received: from DB8PR08MB5388.eurprd08.prod.outlook.com (2603:10a6:10:11c::7)
 by PAVPR08MB8990.eurprd08.prod.outlook.com (2603:10a6:102:326::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.27; Wed, 23 Oct
 2024 05:01:18 +0000
Received: from DB8PR08MB5388.eurprd08.prod.outlook.com
 ([fe80::29dd:6773:4977:dc4e]) by DB8PR08MB5388.eurprd08.prod.outlook.com
 ([fe80::29dd:6773:4977:dc4e%5]) with mapi id 15.20.8069.027; Wed, 23 Oct 2024
 05:01:17 +0000
From: Gilad Naaman <gnaaman@drivenets.com>
To: stfomichev@gmail.com
Cc: davem@davemloft.net,
	edumazet@google.com,
	gnaaman@drivenets.com,
	kuba@kernel.org,
	kuniyu@amazon.com,
	netdev@vger.kernel.org,
	pabeni@redhat.com
Subject: Re: [PATCH net-next v7 0/6] neighbour: Improve neigh_flush_dev performance
Date: Wed, 23 Oct 2024 05:01:10 +0000
Message-ID: <20241023050110.3509553-1-gnaaman@drivenets.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <Zxg52Ccb8FF8MCt0@mini-arch>
References: <Zxg52Ccb8FF8MCt0@mini-arch>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0419.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18b::10) To DB8PR08MB5388.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8PR08MB5388:EE_|PAVPR08MB8990:EE_
X-MS-Office365-Filtering-Correlation-Id: ee374028-2ccf-4c1e-f329-08dcf31fba5f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gSfg7eMwWbXyQ6AbXD5NhqzzHRFCuWpylp9Cvfno8eq/yE4fZllNXGNXQfMO?=
 =?us-ascii?Q?GjGQC17HJGYm6WMBEyq8MYN8UOaH8hx2GL3xrzNAqtlVMViekEVc1gkVgvnc?=
 =?us-ascii?Q?KwAyzzK/gQE/ZNO6w6QTJKG2euNp6Ua6JVF7YF68rizNseORDrkClNNiHIh0?=
 =?us-ascii?Q?1VsK4JxSQs7Xa0rPIco4k1z/ZgwOeILMokd3r+t7zJym/gyX3UjivzYItLGg?=
 =?us-ascii?Q?8NfjvZnkxR1cHfNFXVI9YRFamtb1v+P5XuzYTs2zKWquD+HOP7kjDA2fiUCb?=
 =?us-ascii?Q?aBmYLxWrNEPEu+hyAx8dzfc6kmQMOYH1sf3wDFmjAPr85HXnnqcGVFSmT09N?=
 =?us-ascii?Q?qU83DuOQM9Vw18xVmyouR3PPfA0K0EBCIBr9wHdxDSx38XzPgd2cnKffppVl?=
 =?us-ascii?Q?WHu5rN41jIA/DSh5WbFt2oB7ofQ/7THwsSZoYV3H0wGo1immiOkKfFwbS81O?=
 =?us-ascii?Q?EwAlRJ0Tau8sk+XqFngkylwlYiNI1ikV31DHSNigQuyuRyWjb/pThIww+GSp?=
 =?us-ascii?Q?dLcpNguObI/sgEMDdwvPqCllkWAtKmtJq2CivLzWQCkcRjmfkKE0eYKOFR7J?=
 =?us-ascii?Q?0lQMw9ZYM/gy85uxJwLUhLdpQf5h06i03uEsq7t02p4FfOFV+O8sGAQwBRWY?=
 =?us-ascii?Q?isWSdi2xXJXh5zZzTRGTPu/Nn+tQ6BjfLDBhkss7L09NS93pN5VKOJKMUrmn?=
 =?us-ascii?Q?jVIFikUn08stad5ZjzrLkxFz5AT26I9yu++66ktmNn/rUjYmiDqw18lhOLG2?=
 =?us-ascii?Q?JKB6rrY8XXzO7trYIS+y+ERJS4rquSqJp5kG6wHSAooskbIyU6f+3NS2nF5r?=
 =?us-ascii?Q?9xiYWI8SaFnX1MOETbGN5yM//588H/3Mzoh2OUjBmh32g0vw6HzERS/xr/gY?=
 =?us-ascii?Q?II0YpZvbIYG2zFchLodus1urB/6H5dulYuq4hmmJp4JVPiRYA4kJzfMCAdkM?=
 =?us-ascii?Q?PAlE6EjDN2FHKr/D9eFwiGPBqTAKgnF5BRSpRorZ0KXXYE1R4e8Nk0St/Y2k?=
 =?us-ascii?Q?jkfywEDe5SYAw8qez5VA5kGIUHEOsQiiEj3VYmgfBij6ZmyD8OKHhbylt0w/?=
 =?us-ascii?Q?Hrgd616+1lvZWG06lKY4VzsHEfllOb+wwOu2BUHWye4O9IcFpZvim9YL3djz?=
 =?us-ascii?Q?62CbjA0CGA2nBVaW21bRDfhvnG37vA2O2GctzaqtXJH04hfQC3B10/p6VJ9u?=
 =?us-ascii?Q?8Pw6vAEWBo3kMJsRy5oopislJ/nY0LbjOC9Rq7SJrv6g7Jp05f2e9RqJ9mNO?=
 =?us-ascii?Q?QY8gmX8PJnU7lSOjYVbDWnphwo6eXjRg9ZviNbZwRpF35qyFimFeH9I2+7sA?=
 =?us-ascii?Q?s99N5pnPwTXWHjR2KGUtudz4ZWgzU1v2+GggG+1cWeSK8RDNb/bzonxaZ8zc?=
 =?us-ascii?Q?em508co=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR08MB5388.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?b9cH1/k4tEplU+6a3ZeJ7/b172gWUtgzew2bn/Oucsmi6Z9B9IGhQvlN7NVE?=
 =?us-ascii?Q?VR8NtDi0s9OLya6ncfRrdXzragTXRVNIjBmvz8I8BdZpj47h98nFA3Z/lZDT?=
 =?us-ascii?Q?225MFPbEsMRBc58gZi2zXgG4YWyC3Vd41zqPSEH+3be5oyyQgs5bjv6FfMyw?=
 =?us-ascii?Q?TuN2ZG4l0+ycq+qy4OSXccrlMatchpfQh1D095HT3DXeyC7wfYIReaqy+ShT?=
 =?us-ascii?Q?5TjLsl6rvojbip66X2D8n1R5qjgZ0DURKck6OvkqtX+flSk2aWi6MGNyIyho?=
 =?us-ascii?Q?79De4Cfv5VQT7V3Ru5Le26CPQWR+TrkFODT5MkU21sWqoDXen+ZUvZAqJ5PA?=
 =?us-ascii?Q?mDXPaE6SL8Iw/aPZvfBI2Gg37Wf+M7vSizZhg08uqZnusUxos85Ru0W2OGYE?=
 =?us-ascii?Q?yDtFXkAStKv7fd9ZIE2gKyyq/oSboF8Jvd1xHUjV4K4/Z0ieFO1JiiKTvCg2?=
 =?us-ascii?Q?vWaRsEpl6XODn2v+/UIXMAftCXBa+GP0EEwKKukylKv5EM39BNuFp98lU/g5?=
 =?us-ascii?Q?rii9H+HJseW1sbYnTkVwpnKJ7qrDR0PcgEfOa8HiCNJY1LwasCjapDhlxk6S?=
 =?us-ascii?Q?KhmoPlb3bClqK24j1z9M/1SJphMclzuFdh+/fKoHSAuu39aVQoc+LkAGTWuF?=
 =?us-ascii?Q?cAGI6uA6wEK3lDjdYlq0cpk83M6MsmncDE01WLvvYCvqF+dBF4NVqVwCZ37r?=
 =?us-ascii?Q?uRe8QqzP/YpNghzb88I/n+cUvFJh3hWsiynMhLEioFYVK95Ql6PLr6TPBZAt?=
 =?us-ascii?Q?4/zqMrqsAEpIGxvgJSQkiezXY2iJsx2ULDlKLQBVYo9pMksWNIt2ayYs+Kzp?=
 =?us-ascii?Q?6k0NeUeCrk9B0QMrrR5nzNBVies/gPqPAdFKGdS6ziQIyiL96F9HdcLlrTMK?=
 =?us-ascii?Q?sQDLmsZDtyaqfhIZl2mfH5jNgKV1795PmnVoxddBpLOxa+VnMS2U2hRp8MIy?=
 =?us-ascii?Q?ZH1sIhrpaDbjHmNYf704c3nySsa1aa+ta7m5n/sf/jHvey5bpO6B1jmMeBlI?=
 =?us-ascii?Q?QFCZ68RDo5jDulORRtZTPD3sxkRAmUichfXbKnVgB6Rv8rNGA94Y9LOjSwk3?=
 =?us-ascii?Q?3Tiqr6yTll2ZInRBaDHaIDkEUGoKjSfhw0jFrpatkoPHo+dFIQlqHu39weOy?=
 =?us-ascii?Q?ztSlb8QWU2VsIN5Xo7Kp7kZv4Tz/5C9KMQ1MhBwQ8EvYCIOH5r5duwQ+/wxm?=
 =?us-ascii?Q?OcsOTCtH93qdRhwe9Rummqi57cA92WBky7uc6IE5xLU5tRaXTY4dVQHZaMgA?=
 =?us-ascii?Q?l/MFd1Tqs4dLnYIGlTkx0L72lm0QXRQkCMmOSWXs96Nc5VwOZ4jnL627RO9y?=
 =?us-ascii?Q?nGbTGI7Ey9GPjtIq9Z644OENQSwydEMFWmOrZsoVkV58xJQkOFRY3bldwsAr?=
 =?us-ascii?Q?94vWWFGkjOvBVM5em3ejkLtQwvIkOms5kFY4zwy+w8W2jBpXDP6VqWT4ymxa?=
 =?us-ascii?Q?OUklSL6fK8HIWwqVGZw+wB0ruIRnVsLpz4xex7EJrH6k0Bu/KK8K4Crv/W1J?=
 =?us-ascii?Q?2ZyLODGR0EtQqdCTe1WAEfl2YS3vrnSnr+xtKn+c9ADYqm0Rmiiks1PZFsSe?=
 =?us-ascii?Q?uXY5WYahgfQw1d0Bly/Aw+4xLnI/gFDz1BXxWHCR?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	5aiaBd4p4L4BoHKyU0PRKKw74E8e1fxGhDXbjkqf55uMAxz368Fp8wPSsUI7pTdtqrlVjHTPpo8eX4RqIdKODn2LeXX8rS95P8vkXBWS3CEQ/3A1+7ZmnZGfDd4IECPhussE9D5Da9avMlgZyPnCi3aEwn0gAc3A9S1EQCMV25a4IJu5mGBin25YrJ5ukn3FFfVBUf5MovCVoz/Zkallu8V7Xcpsn+uVZpAcSu4kr/kuWZOq09ZKRBDQk5ERUaAnsxG6Jfp3nKxiq5Vw3Xk8SAzhH6FAjdjg5i7HpI7hCbaTx65rK9OS4pU7dbAXB3OXTmnrMfQPWCzhEPDZmL02DXpzhSYPYcIV6YNQikNTwP6RXj0sWtqlSSOQRCN969GwferIgHWen1NwiLo7yyhL6lUcTbg/STvePFcnXR6lklD6GWNIGHM60FLp4u/1lacbizZ8Q3hyL8E5kbBCSdLy8jl8masf9dvaT1R+7V6zp6s/FgR06dNRdZ6UH3sb6oB4/AeRElgdiYwrTHd1JFca05IHWVa92DfiXoqWMow/dMyHz0e5MMPDibj7kk2cUh+pqJcSMlzIQV2Hl1Aco+IL42dZbImEWo9vxVPoo+6rnxrIZ22Asmm7mhP68Tuih5EB
X-OriginatorOrg: drivenets.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee374028-2ccf-4c1e-f329-08dcf31fba5f
X-MS-Exchange-CrossTenant-AuthSource: DB8PR08MB5388.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2024 05:01:17.8516
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 662f82da-cf45-4bdf-b295-33b083f5d229
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PniZZjF+wAy63ONdE1LsOiOSbBKQlfq9UcTghCYSntIJNf12tdaS6g0Qa04b2dTYimTPjfYOv2UJ9N0wZ8QO0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR08MB8990
X-MDID: 1729659681-GwrTgMigY9LD
X-MDID-O:
 eu1;ams;1729659681;GwrTgMigY9LD;<gnaaman@drivenets.com>;7d4d5839adf16a847fd5f829897ca436
X-PPE-TRUSTED: V=1;DIR=OUT;

> Looks like the test is still unhappy. Can you try to run it on your side
> before reposting? Or does it look good?

Hey,

Apologies if I missed anything.

I ran this before posting, after applying the entire series, and found no crashes:

    sudo make -C tools/testing/selftests run_tests TARGETS=net

Is there more info about this run?
Was this ran on an intermediate patch in the series or all of it?

