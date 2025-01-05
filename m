Return-Path: <netdev+bounces-155294-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F2F6A01C06
	for <lists+netdev@lfdr.de>; Sun,  5 Jan 2025 22:30:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4BCA5161F6C
	for <lists+netdev@lfdr.de>; Sun,  5 Jan 2025 21:30:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CB321D5161;
	Sun,  5 Jan 2025 21:30:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from GBR01-LO4-obe.outbound.protection.outlook.com (mail-lo4gbr01on2112.outbound.protection.outlook.com [40.107.122.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F30101CEEAE;
	Sun,  5 Jan 2025 21:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.122.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736112642; cv=fail; b=q1LY33LZAi/g9/CZBRadV8U71vKor98pQlERk3KX7r00fEDQHhUWKV+eAAFCiEzSsxF8UDweqW7x+d2T8Z5fSOea5FLCsk6e21S6w0VyP7qm9fGkVqyBEtoFSKFAnR85V0WaXR5PLSJPRGOtMklwlfq+RdgAzwiHJbOctbsSTjc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736112642; c=relaxed/simple;
	bh=Zm96E2hsbQAAruZVve+WoYRJi3xV/NxOsAxWpf+jNyk=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=WZEn5BloGnKe5/Qk4+Xf/6RFB0FV8E2j5jJvp6iyR2awjEK0zIkLM838jOLgnyr6XVvUFxg9ftVyYeyIBPjK6KG/UrPCcES2yez8z+RYrbe2fjcWJiytM22PKXIWCgP9G0+BT78DnE5Aby//Sb9Y2pqXUTAjvLPEgcHhzBJXtrw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=40.107.122.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r0Wd9Wjd3OvpzAy+CTe6rcEjUtphpMErMbHj5TwvZAY6oxzQhxlZFoeefBoeztOnKt6VGkUOUdEki+gy+tKjZj9sMxl7bwzm7uMLGEkM2JygDQk2CvGe6xSiVcwILHIK6/RAYjG7lEdz9J0n2qEc32c7fKBB7WHXiQ99wYi3TLe1RpP/GgACEAOjCJ1d4NSb2tA/HPHvQi2Jfxfa3wWuzmyHWjlOYQpcgxXX7wRv7dio/OC8aEPLLiD5Ws61u5pV0fz/GbIZE1o7PWC1FvmXw1iUq5rCqsA2AbKN4pnYGKgNOQGqDzFB6gYslh2Bf15aG7D6VV+tsg/mSTP77dSg2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rNhB9H+iLNKIKG5ReauGPCEswDh3s5/3NZ3XrftCPWk=;
 b=zHWk4JytSPd6B0f2pbaLr3zsrWmLdPh3CLVSv9/Ta/THfpSrUrHou/AiecQuKqJk/pvtHjuj576/83fpat3FTN25jja4ublWEbpuRWeoIivLdIC+JFfOA++HYY46SzB4JCCwvnsSofOuIdYGzfik+9QcZWpuWVPfSMWloqIGgNEbyjMwaLWKVkkEz3gNErD1XJTsgl36Aln6WUjiP/tIyhd2u0RC/M4c3WJ95yPia+Jf+BGXkq9e5rVU8PXvNep8E/uHP89TdD4caweq4negUBRztulSnJ5bQXCSkL49b+VJNXDfU0hrjWck0uDF023+X47IJMVZITMyA1Sl1I0nLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:70::10)
 by CWXP123MB3461.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:7a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.17; Sun, 5 Jan
 2025 21:30:37 +0000
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::5352:7866:8b0f:21f6]) by CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::5352:7866:8b0f:21f6%7]) with mapi id 15.20.8314.015; Sun, 5 Jan 2025
 21:30:37 +0000
From: Aaron Tomlin <atomlin@atomlin.com>
To: ronak.doshi@broadcom.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: bcm-kernel-feedback-list@broadcom.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	atomlin@atomlin.com
Subject: [RFC PATCH 0/1] vmxnet3: Adjust maximum Rx ring buffer size
Date: Sun,  5 Jan 2025 21:30:35 +0000
Message-ID: <20250105213036.288356-1-atomlin@atomlin.com>
X-Mailer: git-send-email 2.47.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0578.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:276::8) To CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:70::10)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB3523:EE_|CWXP123MB3461:EE_
X-MS-Office365-Filtering-Correlation-Id: 4af4859a-cb41-401c-3fcb-08dd2dd0322b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vFfj4vyfIaIqx/g/GXFE4uM9ILzlP02SxNu77yo4FSoWrfVpKg1podymN9M3?=
 =?us-ascii?Q?D0i3h981YU4/Qt+wxZFTUj/0xZEvE53la8yV/to5X96SbNWMptmx9Sv8yByJ?=
 =?us-ascii?Q?PEd+MnOj245bLKpk+fXydLGiPciCmAcey5d5SWiZ9PRPb3ivCHAIfMkxVwhk?=
 =?us-ascii?Q?f4ktkqg0Uy+ufSb5rgstEEO7It+rEJy92RmRoNKDG74oRtFN7SFi+q3pJjg6?=
 =?us-ascii?Q?NjZPtb6TyNFDvFwsZbYYvyQYSUCLa2OWEuRHH9Drny/UA+RXEaSwQZ8SDnwp?=
 =?us-ascii?Q?qwPYz3KtwgZto7pZzw6AJ2jQZ7tkggAlRN4cPO+PSr5N+aKq8ZEebZdRxL0c?=
 =?us-ascii?Q?GEneZxG59AA4bGBUMa/Lbw0qkVSqppzzByh6Peq/RYy+6Dh8GU08Hs9IC2Ok?=
 =?us-ascii?Q?eIazpwgtTuv3MEx1hS0xr14MSKuAYPY+9PYt1AFtbbBVtv2a2ACJaCMfcHQ9?=
 =?us-ascii?Q?354FaE3qmJ9qRVX3rrqtkY4kK7UJmAysLwV0uhLdy3yBsvU9VcDnvBP8vAws?=
 =?us-ascii?Q?YjSVi6D9KpxtR+4A3qG5Jv6jaZ0guPo+bf0CcxvakcwNux6DRVitV5WikZBL?=
 =?us-ascii?Q?9EEq1Yj9jCAN4hBaB3GhctFOlDcCDUi2NvYMlMhUIL1m2k9hwhf1qahoCijH?=
 =?us-ascii?Q?kZeMJ6dL19YzJxcSjmEglAe4O7nOdaWsyKxBjuC84knLEXOycoPGdbnoZZ0e?=
 =?us-ascii?Q?y8VaaZZASc/3vnjNWKUS6IKYaf1RmTH5hU30tdCRyg8i1PeQ1wJYMeXaw4dy?=
 =?us-ascii?Q?256Us/9MMMSBFlj5rzWcB5sgZewCgnUkazzPwoBmW2R19dS3E1BkzK7Gs+vs?=
 =?us-ascii?Q?3DNpyGj0AythXP4nJU4PnMAHvqcj07+VHBQF/7ekSm8gfdTpdaUTPJp2UDi/?=
 =?us-ascii?Q?MtdKWFOvyPt/a1gNqkrNGI/rHtCckwY2IT9LPUt6eShbRPVr5/Jli1dxpLUE?=
 =?us-ascii?Q?hJ/gvw7fhpl+KlQhJ2Zwi96y6uOo9vnogVDbTWYN9HSeImhhjQRP59UiFJrK?=
 =?us-ascii?Q?EXKkPtsxtks/BB3C8OKA1jm8okNhu+Voqkb2oG1Rdg3qxsS29/6X7p1u5NnG?=
 =?us-ascii?Q?WYQv4d3KZlSkO2qRy1Nd+C7oDb6Vebqjo5Pkg91cyrZxI8MxzUyb5FDd07Xs?=
 =?us-ascii?Q?sngLM2pjbLm967m+KIRCuc3t+aYyaVwLrWcFQ+4MoXovdfv1cAekvb7fC5NJ?=
 =?us-ascii?Q?F4b9vzqnsV6lK08ixAuihjPLwevb+jGV1pKE3C5XxmZCqwBZ9Dfn8BQ82nm+?=
 =?us-ascii?Q?aVewnaV/aEN2Q6CLz+75fnLV6M5ZtAEHoBPdfdfCHmtQxNJkh7MFSC9WNblU?=
 =?us-ascii?Q?fsyr6PNR5jovvHdI/Kh6d74ueI4IZ944R3AQy/WEwGV8voURc6c+ilIXgJlO?=
 =?us-ascii?Q?H3VU1GsxuXEIzvMWMVXMsCD+HJdV?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?cUpukgQly2FvK7LlfGsXk1OEmk2hMiQrNK/3W1v7g1N+4ZgaRWCcq2tXUl+g?=
 =?us-ascii?Q?2pwMsvjkgeGKDvFxgIqAxLa2M+GzY3lVQP2IJanLQp79j3d1Tp24yRIlLd3f?=
 =?us-ascii?Q?ILCrFq/bAKvoRe4zV79RNld+bDhUu6V10SlaLDdAiYuWMN4sgnXpsalz2Npr?=
 =?us-ascii?Q?t0IvF0XGelwG2dyB5V4gZfTssUU2DR7QVwCW+m351ql6fjXdA0q7Rdxq/jIY?=
 =?us-ascii?Q?XeMbINywaXSTlTblk/pgN51BP2h3pGOFoullmbyVdDrvOnd6CzJL6q5JkrkG?=
 =?us-ascii?Q?l5oaSkzXD9It8kY9QMyBruLrR5Qz9bJljHXzzjC31+tWtvqgi/I/S3zD9yv0?=
 =?us-ascii?Q?PH3mC+oYI6jTOkBdm3dCkR7z8kIp7umiDmzQVVVL2l4qC542grCzheVjvxoc?=
 =?us-ascii?Q?cZ5ukG3Uz5Hh9n6M55L/HjFACVuwsUzsrEKJrF63jfoFGbSVlqjizTGDa8TO?=
 =?us-ascii?Q?yNx3Ud7TG0qSYcmh02eWhsRRVWcIrHn4e3wfWWUogpIfzZsckRPPkcszJ1G2?=
 =?us-ascii?Q?+d1VwPKHHWQ9VHa/ZRBZ9SRDPBZ9KTEwZPTiuVocFVT6jBwvtuXjzpCwDHac?=
 =?us-ascii?Q?IHuj89Iz//2x5kSgfGd8hEYM0m5SV8SFLyMATNAnHl+gew5qsCTdnBxSUomG?=
 =?us-ascii?Q?fAOfy3pHTqCkt0h2exsG2R9iJAkbUftqYNqKnSZ4CP1cFn/KqMhQ5nCLZD9c?=
 =?us-ascii?Q?Lx3twPmDdvX0vUCOedUsh/2rKR1uVYiqchbn7I4Jo20Q7kjjfB5keZbaQ3va?=
 =?us-ascii?Q?vCk2P3LTbMeQ1G8gygvcbjeSMpY4mlpRjS4DcIaIElRLX7p0Hyj3GrAiQ0Xw?=
 =?us-ascii?Q?/qUk1RM3YuCxcdliDWbGc6ddpNQAAsPmULz/HNJBrtqoO6Wa+D77twkDuqkW?=
 =?us-ascii?Q?svR481PM7FAY19bGZC8B1/7kFXxHQM+hBYyKt8Qe9bkOW+k31au9sVXHLmgd?=
 =?us-ascii?Q?ZCRvVTHc/taksB67XunKzmpfSYAuJdHKdIFr6VnIAbsq77FlwJSEtrdtYORb?=
 =?us-ascii?Q?/uhaal74KN9rk0pRyGCyZNvWqK/Ue11nzsagJ1b2F1xTm69MzaU/yW1lfens?=
 =?us-ascii?Q?P8dkn07rdJxwKbHvs3Z+rMQ8SA3sZJ686HQKrbnAyBvZvMmxLRNQLjEYEmFn?=
 =?us-ascii?Q?ZbHY8KF8cMtMsrp0iZqKMBuVB6tMYEi603xzmCizWJb4q61oP3VRVWsCVTNc?=
 =?us-ascii?Q?Awqg/X9KuKJzPiyNE9CiR+xvXmEKW0W9Bw51pBkut/r/SYmwDoOBnQaeN4Ra?=
 =?us-ascii?Q?8Q0ictayOj8aFPIjpd0RzralTmZKZMNGrr3aDjqXiAKibdNnoMmpTOejyIEK?=
 =?us-ascii?Q?Werga9dr9EMCIE4UZBeIT7QUwJfW3LQxYqgSk+LF0x7QqHejabfyrk0mmdH9?=
 =?us-ascii?Q?U5yvuJwgR7NmZNfEsuuPIkqT/hxSEYQLfYItIT/UJkjrngABQ9H8FSqUVSdE?=
 =?us-ascii?Q?T2AZdSFZZWnq8RT8mGARKZZx46xs9VLfTHyKChJwQ4rYSNoVlucdaEFL5Buu?=
 =?us-ascii?Q?osFgMQ+s8f8OoUMxKdpi5vTDwhY8LbBS4CGcro6osrW1CF+Krrm2TEpeYRTI?=
 =?us-ascii?Q?Ql2J/HBRLDZ44w8jodW78jFX4x36JKSk3PFyIhiF?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4af4859a-cb41-401c-3fcb-08dd2dd0322b
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2025 21:30:37.7359
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Zq5JlTCpFWxF5opTBniH51hq81hyQGZbujCRT+hXHsaUgYw6QDDMDFmOOXBTATEGmQWWZ8rApAiIDGbd4ce6KQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWXP123MB3461

Hi Ronak, Paolo,

I managed to trigger the MAX_PAGE_ORDER warning in the context of function
__alloc_pages_noprof() with /usr/sbin/ethtool --set-ring rx 4096 rx-mini
2048 [devname]' using the maximum supported Ring 0 and Rx ring buffer size.
Admittedly this was under the stock Linux kernel-4.18.0-477.27.1.el8_8
whereby CONFIG_CMA is not enabled. I think it does not make sense to
attempt a large memory allocation request for physically contiguous memory,
to hold the Rx Data ring that could exceed the maximum page-order supported
by the system.

I am not familiar with drivers/net/vmxnet3 related code.
Please let me know your thoughts. Thank you.



Aaron Tomlin (1):
  vmxnet3: Adjust maximum Rx ring buffer size

 drivers/net/vmxnet3/vmxnet3_defs.h | 4 ++++
 1 file changed, 4 insertions(+)

-- 
2.47.1


