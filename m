Return-Path: <netdev+bounces-231697-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 86160BFCB51
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 16:55:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E67F43584B1
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 14:55:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6A633431E9;
	Wed, 22 Oct 2025 14:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=aeberlede.onmicrosoft.com header.i=@aeberlede.onmicrosoft.com header.b="FIsiOVOM";
	dkim=pass (2048-bit key) header.d=a-eberle.de header.i=@a-eberle.de header.b="LPkjxH57"
X-Original-To: netdev@vger.kernel.org
Received: from mx-relay36-hz1-if1.hornetsecurity.com (mx-relay36-hz1-if1.hornetsecurity.com [94.100.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06BA734A3AC
	for <netdev@vger.kernel.org>; Wed, 22 Oct 2025 14:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=94.100.128.46
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761144850; cv=fail; b=LXNMS7f6KMcrGfj1vOHOpAQY/PRJqCYIyw+jCf5KgLjLcpchkvCTG9ESrpk/BNL0FCIUk9L6UTnrOywrC898d52qoswzgC4SmkAac9/86dWT6lIVZ8DjK/I16QJtTW23J2VtijGna1EqS1gaCK0BYStvMCm3DLzEIE+k9oxBWUM=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761144850; c=relaxed/simple;
	bh=MVupZ7NDYSaJnmbrsyINObGh4L99K5FzsZvKz533hog=;
	h=From:Subject:Date:Message-Id:To:Cc:MIME-Version:Content-Type; b=oEyX/hwfj8xg0nWkSCMu9q8QcvaFdRrkJnH9h1YorqYMMfqDuRVgddA3Ja+ZfxBcqXdhh7CPvOMmzTIdrnX6+Z8TpKBGWhMkYN7xTZREU9ethxflfJTxChCSuWzqWu3Oh4+hvbKInkl7g8EykGFdhL35JwDKw/UaQFJLZFF3KU0=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=a-eberle.de; spf=pass smtp.mailfrom=a-eberle.de; dkim=fail (0-bit key) header.d=aeberlede.onmicrosoft.com header.i=@aeberlede.onmicrosoft.com header.b=FIsiOVOM reason="key not found in DNS"; dkim=pass (2048-bit key) header.d=a-eberle.de header.i=@a-eberle.de header.b=LPkjxH57; arc=fail smtp.client-ip=94.100.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=a-eberle.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=a-eberle.de
ARC-Authentication-Results: i=2; mx-gate36-hz1.hornetsecurity.com 1;
 spf=softfail reason=mailfrom (ip=40.107.130.96, headerfrom=a-eberle.de)
 smtp.mailfrom=a-eberle.de
 smtp.helo=mrwpr03cu001.outbound.protection.outlook.com; dkim=permfail
 header.d=aeberlede.onmicrosoft.com; dmarc=fail header.from=a-eberle.de
 orig.disposition=quarantine
ARC-Message-Signature: a=rsa-sha256;
 bh=wZ2UUa/EvKNw8IfV/WD0OYTSPeXD+3m/D7qUpneT2xI=; c=relaxed/relaxed;
 d=hornetsecurity.com; h=from:to:date:subject:mime-version:; i=2; s=hse1;
 t=1761144783;
 b=AXRqr84C3EVN9GDVbjIzFnELUEOjOLk+kWJCQyUYQkYDC385pPFutaYlu8FqEQD0mLTGDSJQ
 01iBRgokpditYwIuRZ2QRDpfGy0ClNRv6NbcovD2I2e+w6dNy+4m6lYqNIoERp1jDN8LAq9DjQd
 LsAPtPeT8cx7T+QWLycDaPxKu96wcriCiiHYCJLVqyg/OLm2Xuo7oANJoUIlhI6akxq4FJZ9mVT
 SFiaND8tuJhzk2vOJfgRDwXQVx6ZVhJLjhNo1QpGEM7WM+e9p7Wyzh7V4wyTG+Wcjfm8sWW6+6f
 Lu2D3f/UbXLia1WFo5vkpDBzT3O6r+42NuW0wCqMNQJwQ==
ARC-Seal: a=rsa-sha256; cv=pass; d=hornetsecurity.com; i=2; s=hse1;
 t=1761144783;
 b=DXMEIdOVShWAVduxLaQqIcq4+BekeW/mcMD2bdLvJGWhmyELGIYS043iYuVMMUBBuN8aaiKa
 zhCJYwnVlRgTRDrYNwBsMWjjFyeRs8SS8VTwAFrbxB4oEKprgawXFwCMY6u2spXWhxtQAjK+vZ1
 0A3FyLIEQmGHV7MPcqYuKEvupO0x74aKY8uAO5hVDYJXBg0znFii1vO8kld4XKNnYX8dSjjy2YY
 eeHDWakvRwnZx+GvWrKuqONyiijQn80krzoNlroizMTZa7BncOUZ/3PzRlNI1luBcObh1yS+7by
 SLsF4VxgOdi8TUQrWnXq0Uo32QH8RuWYOr9zbe4yVbGhQ==
Received: from mail-francesouthazon11021096.outbound.protection.outlook.com ([40.107.130.96]) by mx-relay36-hz1.antispameurope.com;
 Wed, 22 Oct 2025 16:53:02 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gmLS5oPkj7tW0MfjMIvhWKumLDRF2iM7HwUqFp/2GyOrxIJS99xcxeXMoEg1NL3fnFy5xnKvJ04yYcYAdzE9jXNWqygSH7LM1fyLLqWHiK0Nv7KORr/lghvI6DWLGlJLLa5qoMYFyAe/LtZ2sOkz9K9CmYoJEcm5tATNNTpLWi0V7onZ6KnZvMn75JZSGRrjX5hGt9lPyaShwaqwPwE+1s8dSePYGm6Dv5DWRCawX4ED/BLR8vUfadX49L+dhaqpTWLWwIvrKXhsJxrN5NQta6niq/0Hz0/h9CpcBKAvYICNoYwJvfOP8gdXAGp/Ow3LHK/OOAgov0vL2YhZOXwaTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1cLnb+FlHZ+eAuvEY8iXhiPdZHcTj/PEkFbgMapiqG4=;
 b=NbALiOnYDdBo8UFyp/usuj/lF9wb/tFYm2eh3BgV+QUkyJxC2cy0S0t9V6w4Zp1MOauHOXVc/keHWNOeyoXqAc+rn5y5OTLfaNtKRE6RrjR2valof8zAXCV9AaXYFU3NYSz+am0sjcQQQhucAZpOr4RkdiUKTfSOba3Xzq5WZFwwhZms9HMo+6HkeF5X/xE4bvC0KH5r74OcAVrrfy7lCAVKtx0uR2s5nqLm78V/+2r9VK7dniPh6FOWXMdXKiH2hmSD6tihQvqhVAMegsLVCIK31I4Xuv1WCtMdZzxhwqpJH4c/RiC0lJdPrQeL3Pw2/vFdzmQUxAam5+5TF7R8Hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=a-eberle.de; dmarc=pass action=none header.from=a-eberle.de;
 dkim=pass header.d=a-eberle.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=aeberlede.onmicrosoft.com; s=selector1-aeberlede-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1cLnb+FlHZ+eAuvEY8iXhiPdZHcTj/PEkFbgMapiqG4=;
 b=FIsiOVOMshNlmE7zUmnrlF3+Eka7A8WTFpNWX8QYsTdE6TzQ7gFJdsbPyJvB2mV7ctUlCh9P251+lo6DEToatdFfBeuahmQeIv08OijtsyfgnlZ04El1nmdorypCNECTWu3UHuzpHSs2nCDoWGLLibNvZIWiNwVA5Gh/z9jx9yI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=a-eberle.de;
Received: from AM7PR10MB3873.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:17a::7)
 by AM8PR10MB4036.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1c9::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.12; Wed, 22 Oct
 2025 14:52:51 +0000
Received: from AM7PR10MB3873.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::14af:ad35:bd6b:f856]) by AM7PR10MB3873.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::14af:ad35:bd6b:f856%2]) with mapi id 15.20.9253.011; Wed, 22 Oct 2025
 14:52:51 +0000
From: Johannes Eigner <johannes.eigner@a-eberle.de>
Subject: [PATCH ethtool v2 0/2] fix module info JSON output
Date: Wed, 22 Oct 2025 16:52:42 +0200
Message-Id: <20251022-fix-module-info-json-v2-0-d1f7b3d2e759@a-eberle.de>
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALrv+GgC/4WNSw7CIBCGr9LM2jEM1hJdeQ/TRSuDxVQwoETTc
 HfHXsDl9z8XyJw8Zzg2CyQuPvsYBPSmgcs0hCujt8Kgld6T0oTOv/Ee7WsWJ7iItxwDqla3pIw
 x5Bik+kgsuXX23AtPPj9j+qwvhX7qn8FCqFCR7Wikg9m57jQgj5xm3lqGvtb6Bdj4Xam6AAAA
To: netdev@vger.kernel.org
Cc: Michal Kubecek <mkubecek@suse.cz>, 
 Danielle Ratson <danieller@nvidia.com>, 
 Stephan Wurm <stephan.wurm@a-eberle.de>, 
 Johannes Eigner <johannes.eigner@a-eberle.de>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761144770; l=2025;
 i=johannes.eigner@a-eberle.de; s=20251021; h=from:subject:message-id;
 bh=bxNzpOIfmKF9KoquuSEKKAMrh1JN2CHFM5QzSEoCF6c=;
 b=zh4PbaC4wSoi9f69OwH9W3SurZj9uJHdiTR0s6wtqjYewDT2/mqYn4zeyer5M8oTOMQJmnp9f
 5a6eWXMD5YtBVZhCMeVmZFQNeoyUiy5swHR9slWXme2dgCH60G30pfa
X-Developer-Key: i=johannes.eigner@a-eberle.de; a=ed25519;
 pk=tjZLx5Tp2iwCN/XmbFBW4CrbjZnFMF6fyMoIgx/dEws=
X-ClientProxiedBy: FR4P281CA0149.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b8::15) To AM7PR10MB3873.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:17a::7)
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM7PR10MB3873:EE_|AM8PR10MB4036:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f090ae3-a8cd-4fb0-901f-08de117aac3e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RlJRQnpvQ2JBek95MnRFRWZkTnJKaWtqektuNDF5ajM3SVEvNlg4MWRRRSs2?=
 =?utf-8?B?THQrQllhZ1NFUkZ5TXZiUmoxdVgreEdlb2ZiejZGQU1saW54NUdWZ3M2NFZ3?=
 =?utf-8?B?SG9nNEw3dnQzYXEzaVJJbnBDMzJPZ1BvTHZmTklGdXhldjI1NmtsamxRVFVl?=
 =?utf-8?B?UDlNdVNCUFlySjJXNWFRUlN5OHBGRElvYURpN3kzTmgwYk5XdFYrSW9RUmRl?=
 =?utf-8?B?NXBENW9zRWJWN1N1TWVrcDgycGl1TFNvYmRkRHpMYllKN1FOZng1Q1BEV250?=
 =?utf-8?B?ZXVCbEVnYW9ERzRhdktJajhZU0NZTmtvY1BsUnRDR253MWdKQUN1T1EwRWpj?=
 =?utf-8?B?czYyeWRUS0o2QUp5SFlyMlNLVjlYUmRUdVNWUGZsTWZ2VENQQjJ4bjdYenFP?=
 =?utf-8?B?YTFTbVgwd3pzZUg3cVQ1MVRCNDROTklmUStIT0VDRjREYUxBZDVxeXk0aWlD?=
 =?utf-8?B?UzVMK0tOR2xUbVMzVXdRendIeStXL256ZXJST293VVlnais5ZG4yeUVqb2V3?=
 =?utf-8?B?YUtoaHF6bVNMRlFXc0JGeUE5Q0NMWFFuVkMyWk9DMHFRYVlIVDJPVW56WTBW?=
 =?utf-8?B?U1FueHVGV0xRVzdJTUpJRXNrL1IyWGJsY0hBMVR5c3g3eGE2ZkhJRkhhbEJF?=
 =?utf-8?B?OExXUFFFZGx0eG9iNEVCWUpqOVVQT3hTUXQ3dHJyYWZHamlvNFkrZHQ4bWhl?=
 =?utf-8?B?cURKaVBGNGJPRGtBcFkzT0svdGpFS3JYcGtKMGw3OUlBSG8weU9xb0c0Tm1H?=
 =?utf-8?B?MSswZXF5ZUFZU1ZmdXpxVUZOTWRxa21tblFlb0REc3VZRzMxQ2NwNC9kNGNv?=
 =?utf-8?B?SzdyZ0hDbkk4S2VwR05oenFzdzB6NlF2Z0llZSsraTRyWTR4T3Mxa1M2MEdx?=
 =?utf-8?B?OTQ1ZWZRSEErYjVUWGV2MGlXLy8wYmVYaU0reS9DOUVnWUZqYVFHODNleTUx?=
 =?utf-8?B?MkJHZEpDWTc5UEQ5TkJhZmo5UEN3VERERXlIZ2xJNGsxY1hzOXEzWXVKbVNN?=
 =?utf-8?B?cjB0cHFWdmFsQzZDZGdaQUhwSWkyM3RQUTlnTXk1ZnZpN0tpdEdNSFdrcUxI?=
 =?utf-8?B?OXBFbVpnRWIvVDVlS0V0bWxURFpLRkNJeHAvZkV6OVcySDM2YVVOSmJXczVp?=
 =?utf-8?B?WWhqN2p4amJ4TU9mM2gzWENjVnN5NUl0WHROSGV1SnByRVhRWUJ5M1pzTzY4?=
 =?utf-8?B?MVRlMzJwdmI5Q0RHVEpuTk00Y3JBbmhCZjJnMkVSQXk2UW5QMU05QVQ1ZlFp?=
 =?utf-8?B?TVN4aU84dXkzakFYYVh1Q2pHWlhlWlBQYlkzeXJJL2dSb1ZUWUVJT1hvd3hz?=
 =?utf-8?B?di9QdU8weXFDaUJoQmpYR0pBdlFYbHR4bWwvU1N4Nm9XR2FyTG5OOU9WTksv?=
 =?utf-8?B?citVaTk5dk5hQU1RcG9ERGk1NHBhSDZCQ056MktjTXBiSTMwaVJxSjNDVEhD?=
 =?utf-8?B?SEt0SjlvQmxSL0ZRYmFrTjFCSjdhVXFNUkdmVWtma2pQb0lkbjczOWR1SjYr?=
 =?utf-8?B?cmpJT2EwRGcwZSt2WDh3MGhVams5VUcyaWlYREgzRG9uaFhzYWphV3JuOVN4?=
 =?utf-8?B?dVplQnVLOStiTGZuZDJ2WENOeTczZUp4UkEwWTVLZG9kSjFod3h1cy83Y3Ar?=
 =?utf-8?B?OEZXcElZQkZtMHl5NXdTWkU3a0gwRm83VFNMWDB5NDA0azhuK3J1R3NtYWI3?=
 =?utf-8?B?ZmF5Z0JEbktteUhzei9LdGhLcnpxRjJhOVZRSmRwNUlyT0E3TzdBME1oTzNI?=
 =?utf-8?B?N0FmdzRXVm5DYkRYVm5paGlJZUN0bVUrNHkxSysxbjk4TWR0RjRBSHBWdElN?=
 =?utf-8?B?MkxEa3VTSmw5djBLYUE3SFpyeEdCaDk4RnN4YXBRUGE0cmh5T1NON2FvUFFn?=
 =?utf-8?B?dytMRVNPKzhwbkMwVUZqZDZUaWpIbVpKOTVPOTJaQlE5S0NJNE9JUFM1akpC?=
 =?utf-8?B?SHNpUGxPcmYrT0V5VjdTVks0MXVKOXhrTXZxNG5vL01lQkdRYkhSK09URFAx?=
 =?utf-8?B?WFplMTA0WndRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR10MB3873.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SmhaRW9PZVZCN0dyQ3Fvd3hFZHJkclFLNkVObUl4WTBGWjJtNlZJUEt3R2pn?=
 =?utf-8?B?eWl3VS9wYlRVTWRObDJiR1NvcjZrTmhpeTRyYlBTTFUraXFlNTVXOGdJRWo2?=
 =?utf-8?B?YXlPUkl5K2NodzhYVHVMOVBOTHhVeWx2TE4vK0N5RWhyblRiT3h2cldGbi9u?=
 =?utf-8?B?eGVqSnZkZVlsRE1NK1gwSk1XN3p1TDdPTmp1SExzUGpmekFnRnhMblFsbXZk?=
 =?utf-8?B?VkxWVmIwQTBKR1AzcVRCQk1uY2lxRmFIb09ITUJwVCtlQ2VPZDFNdEd1RzBv?=
 =?utf-8?B?dEtJSWpwZXJFaGRGVzZZSGxid294cHlwSjJkNEtETm1McHNzNXVUT0gvN2pR?=
 =?utf-8?B?QXBBek0zS3B5WEVsTUMzdW50aktoSU9pRHVnWXBRaHRvdk5ERk96d29Qbksx?=
 =?utf-8?B?c1NCS1dIajRkZmFOSFNVcmVzU1h4OWx4elR0R0RaUnhOOHBsS0t0Mm9iRXVx?=
 =?utf-8?B?K1NLbjlxOXpVM0U3YXNwNmcxYnNFUzdZRUk3YkNHVHVzZ3VGTnB6V1AwN3Ru?=
 =?utf-8?B?ZG1WYm94Q3JIV014N0FHakRPWDdacUZWc29hYm5UTlhDTnpUakJndkEvUnQx?=
 =?utf-8?B?S0xpbTNuZS9Ddm5IaGhIZU43S0twc2pvTW5pTEFzMUtaNVFPSDZ3MXhEV3Y1?=
 =?utf-8?B?ckd1T1hQK0NBQ0RCb2tsbzRMbTJBMi8vTU8zVWhJbkgyOEJ6dGN1L01Nang4?=
 =?utf-8?B?azlPZjZSMk9HZ1BwaWZUdHYvZ0tKa0thTFB5bi9leVB4bnlia3NtRDlDd2hF?=
 =?utf-8?B?NzlnRTM1YlVnMWp5UmE5TVFocHhOb2ZlTWZQZ0RRUHJwTEljbmdPRFRrVE4w?=
 =?utf-8?B?VjlvL25rR1A4WHNpRy9XSzdkMWtCemwzdkowUHIwMjVGK2ZKZ2craFBUbklK?=
 =?utf-8?B?bWtOZldvdjh5MCtCWnRacmRUNkdiR0hIZEVqRWVCOFg3emFSQi8vKzJ5VTRN?=
 =?utf-8?B?ZHpmZlFOTS9oTnJtbHVzVDVnaGNlbmNlQkVmS3RQcmR3bDZINmxTVHhXU0xr?=
 =?utf-8?B?b3AzZXZWVVVmNGJIdS9qdmZMcG1ZanN6QzRWdmZJVXNIWDA1TW9ranpLQUV2?=
 =?utf-8?B?dmFsUk51MTlkejAyc2hxUTdQb3l5WlFIVVBJN1Y5Zm1aMnZyTVByWjEvTnRB?=
 =?utf-8?B?bHk1b01haDV2K0lUUjExWkZZTWlkNVZ4YWd3VEdoWkhlSFhZa1ZoOUdLSWhW?=
 =?utf-8?B?QnRrK3hkeFRPcWRMcUtNRk85cGNiTmN5em8xK0orTG1YbEF5QXFDcVdDYUgy?=
 =?utf-8?B?QjRDNTQzVk15TnlsL2x6dWhlL2RaU0p1VkRxMmhpckF6TFVralZha3BNcmpX?=
 =?utf-8?B?OXJGZ1dITzZJcEQzYm1OWmhsMDdQejFEek9DakFDYTV4TWNaZXR6S3ZaTHl3?=
 =?utf-8?B?U2RaOEhoUXZhSlQyVzBYYjh2VU8vZllCK01JdjhvMlkvNk5iYmRNTGZteU9S?=
 =?utf-8?B?MmRpaEdnQlVpSkdiZ3lzcUdxQUd0bVRhZEZRa2xBZ1VWcElHRlBNUmF0Z2Zx?=
 =?utf-8?B?UzlGamNYQXc5eXZXUlBvV0M4YUpUUkFzKzNFQXNqbDEyc0g1bnhlR0xxaGRm?=
 =?utf-8?B?SWs3czlBcGxNb3BLTklvTkJXR3VRZHVoWVRjUzVhc0FkYWtPWWxxYkNIQ1Vv?=
 =?utf-8?B?WFZwV0p5UE11NmFDM2lnRHBKN1NvTVN0cVp6amdWM3IyWWZOQnhQdWtocTZS?=
 =?utf-8?B?eEdoNm41ajc0emlhM1U5NXNqblg2U1hYNk9wKy8yUUVDNy9TSzMwMEdvemxh?=
 =?utf-8?B?alBjWlJuNiszNW04ZVYrdW13ZHBBV04zenc2QkhiSEgxNDdLS3NqN3BQbWtp?=
 =?utf-8?B?VFR3NktHeE1FSDdzUnRhdlRtK2VTSFltRkZSMmdVWUgyZHpyUlFMOU8yRTdV?=
 =?utf-8?B?TnkrLysyNnVJOWhXSUVSYWphSGxxaTFZQW9HN3JNS0tUUndUWFhiMGY3WWZj?=
 =?utf-8?B?aXFvalQ4Y3lCdnF3QktxUFdtTDV6VzAxT29yZWNkN2xsOUx0bTBlTTFsQnIx?=
 =?utf-8?B?RW5sdVhyQmMzeUdOaUFSRjR5QnYwYmE1U3BpUWh4cUR4VlpqVUJiZzZHSTFF?=
 =?utf-8?B?cEpaQnkySmJqdVNCMjFNdk9KUUl3dWxLU3UxUEFjMDgwU0RNbTQ1VTlGWFFw?=
 =?utf-8?B?a0ZiU1NQZTYrTk1ic3podlp1U3VSMnJQMDJlaGZhTEhDUWRyeTVOeWVOaVZ5?=
 =?utf-8?B?RlE9PQ==?=
X-OriginatorOrg: a-eberle.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f090ae3-a8cd-4fb0-901f-08de117aac3e
X-MS-Exchange-CrossTenant-AuthSource: AM7PR10MB3873.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2025 14:52:50.9568
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: c2996bb3-18ea-41df-986b-e80d19297774
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aJ+74cJETFumzIJzDH0VxXSZLsNQKtUTMmyGdwALxJIorDSEHccj9mtb1N3x3QcbjOJM5uxt/4CrSNXKNKe75CACYjM/GMtHKTRrhOOIZYo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR10MB4036
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/x-pkcs7-signature"; micalg="sha-256"; boundary="----A3B11A87AF72B28D8C083ACCF0DBB925"
X-cloud-security-sender:johannes.eigner@a-eberle.de
X-cloud-security-recipient:netdev@vger.kernel.org
X-cloud-security-crypt: load encryption module
X-cloud-security-crypt-policy: TRYSMIME
X-cloud-security-Mailarchiv: E-Mail archived for: johannes.eigner@a-eberle.de
X-cloud-security-Mailarchivtype:outbound
X-cloud-security-Virusscan:CLEAN
X-cloud-security-disclaimer: This E-Mail was scanned by E-Mailservice on mx-relay36-hz1.antispameurope.com with 4csBwh1cm6z2HYt3
X-cloud-security-connect: mail-francesouthazon11021096.outbound.protection.outlook.com[40.107.130.96], TLS=1, IP=40.107.130.96
X-cloud-security-Digest:a432f4609086a3d64bb875658305b025
X-cloud-security-crypt: smime sign status=06 sign_complete
X-cloud-security:scantime:2.005
DKIM-Signature: a=rsa-sha256;
 bh=wZ2UUa/EvKNw8IfV/WD0OYTSPeXD+3m/D7qUpneT2xI=; c=relaxed/relaxed;
 d=a-eberle.de; h=content-type:mime-version:subject:from:to:message-id:date;
 s=hse1; t=1761144782; v=1;
 b=LPkjxH57EEfe2wSyCE+anO8en0LnxPHy2eeJUzpA4efKgoX6rF9clUAMzZr3lB1HEBc0EoZT
 i1oZ1U4++fWgsAAJS+5g7y91OT+gBXkQRpbqfCuR8VhsunnekBto3qt6V68TxW/mIJdCogyAYLg
 yktn2aeqjDP8SX0nN+XRh9/bK+5s9KdMO9MGQ1bEJcUBynGLPtSm6wCH25Qn+an0UFffuo7e4xq
 5oxwLp58wgQkpdq2v3G4UCw3ONmrJeCfDvlB76UepaI9QWKw3Aigt4ypWgcsKy2SJfy11+93LyU
 cZuip1xtOQAeMNkOhpS1KnGA4pBjJgmhkloEw8ELrul8g==

This is an S/MIME signed message

------A3B11A87AF72B28D8C083ACCF0DBB925
To: netdev@vger.kernel.org
Subject: [PATCH ethtool v2 0/2] fix module info JSON output
Cc: Michal Kubecek <mkubecek@suse.cz>, 
 Danielle Ratson <danieller@nvidia.com>, 
 Stephan Wurm <stephan.wurm@a-eberle.de>, 
 Johannes Eigner <johannes.eigner@a-eberle.de>
Date: Wed, 22 Oct 2025 16:52:42 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

In one of our products we need to show the SFP diagnostics in a web
interface. Therefore we want to use the JSON output of the ethtool
module information. During integration I found two problems.

When using `ethtool -j -m sfpX` only the basic module information was
JSON formatted, the diagnostics part was not. First patch ensures whole
module information output is JSON formatted for SFP modules.

The same keys were used for both the actual and threshold values in the
diagnostics JSON output, which is not valid JSON. Second patch avoids
this by renaming the threshold keys.
This solution is not backward compatible. I don't see a possibility to
fix this in a backward compatible way. If anyone knows a solution,
please let me know so I can improve the patch.
Another solution for the second patch would be to rename the keys for
the actual values instead of the thresholds. But this is also not
backward compatible. I decided to rename the threshold keys, as this
aligns with the naming used for the warning and alarm flags.
Second bug is definitely affecting SFP modules and maybe also affecting
QSFP and CMIS modules. Possible bug for QSFP and CMIS modules are based
on my understanding of the code only. I have only access to hardware
supporting SFP modules.

Signed-off-by: Johannes Eigner <johannes.eigner@a-eberle.de>
---
Changes in v2:
- Add fixes tags
- Do not close and delete a never created json object
- Link to v1: https://lore.kernel.org/r/20251021-fix-module-info-json-v1-0-01d61b1973f6@a-eberle.de

---
Johannes Eigner (2):
      sfpid: Fix JSON output of SFP diagnostics
      sff-common: Fix naming of JSON keys for thresholds

 sff-common.c | 50 +++++++++++++++++++++++++-------------------------
 sfpid.c      |  9 +++++----
 2 files changed, 30 insertions(+), 29 deletions(-)
---
base-commit: 422504811c13c245cd627be2718fbaa109bdd6ec
change-id: 20251021-fix-module-info-json-0424107771fe

Best regards,
-- 
Johannes Eigner <johannes.eigner@a-eberle.de>


------A3B11A87AF72B28D8C083ACCF0DBB925
Content-Type: application/x-pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"

MIIQNQYJKoZIhvcNAQcCoIIQJjCCECICAQExDzANBglghkgBZQMEAgEFADALBgkq
hkiG9w0BBwGgggw7MIIGEDCCA/igAwIBAgIQTZQsENQ74JQJxYEtOisGTzANBgkq
hkiG9w0BAQwFADCBiDELMAkGA1UEBhMCVVMxEzARBgNVBAgTCk5ldyBKZXJzZXkx
FDASBgNVBAcTC0plcnNleSBDaXR5MR4wHAYDVQQKExVUaGUgVVNFUlRSVVNUIE5l
dHdvcmsxLjAsBgNVBAMTJVVTRVJUcnVzdCBSU0EgQ2VydGlmaWNhdGlvbiBBdXRo
b3JpdHkwHhcNMTgxMTAyMDAwMDAwWhcNMzAxMjMxMjM1OTU5WjCBljELMAkGA1UE
BhMCR0IxGzAZBgNVBAgTEkdyZWF0ZXIgTWFuY2hlc3RlcjEQMA4GA1UEBxMHU2Fs
Zm9yZDEYMBYGA1UEChMPU2VjdGlnbyBMaW1pdGVkMT4wPAYDVQQDEzVTZWN0aWdv
IFJTQSBDbGllbnQgQXV0aGVudGljYXRpb24gYW5kIFNlY3VyZSBFbWFpbCBDQTCC
ASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAMo87ZQKQf/e+Ua56NY75tqS
vysQTqoavIK9viYcKSoq0s2cUIE/bZQu85eoZ9X140qOTKl1HyLTJbazGl6nBEib
ivHbSuejQkq6uIgymiqvTcTlxZql19szfBxxo0Nm9l79L9S+TZNTEDygNfcXlkHK
RhBhVFHdJDfqB6Mfi/Wlda43zYgo92yZOpCWjj2mz4tudN55/yE1+XvFnz5xsOFb
me/SoY9WAa39uJORHtbC0x7C7aYivToxuIkEQXaumf05Vcf4RgHs+Yd+mwSTManR
y6XcCFJE6k/LHt3ndD3sA3If/JBz6OX2ZebtQdHnKav7Azf+bAhudg7PkFOTuRMC
AwEAAaOCAWQwggFgMB8GA1UdIwQYMBaAFFN5v1qqK0rPVIDh2JvAnfKyA2bLMB0G
A1UdDgQWBBQJwPL8C9qU21/+K9+omULPyeCtADAOBgNVHQ8BAf8EBAMCAYYwEgYD
VR0TAQH/BAgwBgEB/wIBADAdBgNVHSUEFjAUBggrBgEFBQcDAgYIKwYBBQUHAwQw
EQYDVR0gBAowCDAGBgRVHSAAMFAGA1UdHwRJMEcwRaBDoEGGP2h0dHA6Ly9jcmwu
dXNlcnRydXN0LmNvbS9VU0VSVHJ1c3RSU0FDZXJ0aWZpY2F0aW9uQXV0aG9yaXR5
LmNybDB2BggrBgEFBQcBAQRqMGgwPwYIKwYBBQUHMAKGM2h0dHA6Ly9jcnQudXNl
cnRydXN0LmNvbS9VU0VSVHJ1c3RSU0FBZGRUcnVzdENBLmNydDAlBggrBgEFBQcw
AYYZaHR0cDovL29jc3AudXNlcnRydXN0LmNvbTANBgkqhkiG9w0BAQwFAAOCAgEA
QUR1AKs5whX13o6VbTJxaIwA3RfXehwQOJDI47G9FzGR87bjgrShfsbMIYdhqpFu
SUKzPM1ZVPgNlT+9istp5UQNRsJiD4KLu+E2f102qxxvM3TEoGg65FWM89YN5yFT
vSB5PelcLGnCLwRfCX6iLPvGlh9j30lKzcT+mLO1NLGWMeK1w+vnKhav2VuQVHwp
Tf64ZNnXUF8p+5JJpGtkUG/XfdJ5jR3YCq8H0OPZkNoVkDQ5CSSF8Co2AOlVEf32
VBXglIrHQ3v9AAS0yPo4Xl1FdXqGFe5TcDQSqXh3TbjugGnG+d9yZX3lB8bwc/Tn
2FlIl7tPbDAL4jNdUNA7jGee+tAnTtlZ6bFz+CsWmCIb6j6lDFqkXVsp+3KyLTZG
Xq6F2nnBtN4t5jO3ZIj2gpIKHAYNBAWLG2Q2fG7Bt2tPC8BLC9WIM90gbMhAmtMG
quITn/2fORdsNmaV3z/sPKuIn8DvdEhmWVfh0fyYeqxGlTw0RfwhBlakdYYrkDmd
WC+XszE19GUi8K8plBNKcIvyg2omAdebrMIHiAHAOiczxX/aS5ABRVrNUDcjfvp4
hYbDOO6qHcfzy/uY0fO5ssebmHQREJJA3PpSgdVnLernF6pthJrGkNDPeUI05svq
w1o5A2HcNzLOpklhNwZ+4uWYLcAi14ACHuVvJsmzNicwggYjMIIFC6ADAgECAhAl
5qzXGH8Da+FSta/hHFZ+MA0GCSqGSIb3DQEBCwUAMIGWMQswCQYDVQQGEwJHQjEb
MBkGA1UECBMSR3JlYXRlciBNYW5jaGVzdGVyMRAwDgYDVQQHEwdTYWxmb3JkMRgw
FgYDVQQKEw9TZWN0aWdvIExpbWl0ZWQxPjA8BgNVBAMTNVNlY3RpZ28gUlNBIENs
aWVudCBBdXRoZW50aWNhdGlvbiBhbmQgU2VjdXJlIEVtYWlsIENBMB4XDTIzMDcx
OTAwMDAwMFoXDTI2MDcxODIzNTk1OVowLDEqMCgGCSqGSIb3DQEJARYbam9oYW5u
ZXMuZWlnbmVyQGEtZWJlcmxlLmRlMIICIjANBgkqhkiG9w0BAQEFAAOCAg8AMIIC
CgKCAgEAwEFNcbuq7Ae+YCfg2alacqHWh08bvE6bFOZZ1Rxl1w/sFuXUwJ8o+gbB
TA/mmITzst+fnsjwMmrjtCecn8wILPitSD2wXy+yiaWmn8ywuBBw8toRX0xSMgif
KM494f9SSFjJDOgZGmAG+umMO6v5KNA1K0wSWrlZmG0yC0pzp6FFVVyMnp4/vJh3
6BuYgOf0s7KK5ShCQ4mKOD0dOOcMTBFHcQuD8d2Ha9lH5KzF4CVR6W3p+DUs2r6o
WwSPc0MrTqq0Ci9KPaKmvxzMQRZqSqa5ySqyw4guw0vnPYwtS0BEYZM+mL/5BwAP
Uga7nUg/9tjzyEgUY3tmimfWD0UIi9oDHT59n4s5iriWcnZNS5dAWnu7NqEBs+w6
lpWo2g60mmxPULNnwSUYxqdfXn5udIde0boYLKfEy11JC9xkshXBgLPhq4xTkbWs
fkoH+EQyEdep5AhaLeTsJHpw0tp2whpeH9Fwck8tx/nWtudo7bfYZUF4lDtyEHmi
p7UJa6x4LKEO2XFlY5v6ZOfVAm+zqNWEdDGO3bfv3HO5ciIHjXHLVFx/XI73OVsC
aObazBuEcqXafTK9ThLS5Sh4uZ3nLv3n5m8m/UUUKbOmOI7MTId7WlP9hOeNAzEu
SiA/n8VFk4RO7iwajXximGU/0rxuUJtN7RJFumksH7sbO5ypjCcCAwEAAaOCAdQw
ggHQMB8GA1UdIwQYMBaAFAnA8vwL2pTbX/4r36iZQs/J4K0AMB0GA1UdDgQWBBSz
BXMVnJ+omSJdNUgpzP64lg+gRDAOBgNVHQ8BAf8EBAMCBaAwDAYDVR0TAQH/BAIw
ADAdBgNVHSUEFjAUBggrBgEFBQcDBAYIKwYBBQUHAwIwQAYDVR0gBDkwNzA1Bgwr
BgEEAbIxAQIBAQEwJTAjBggrBgEFBQcCARYXaHR0cHM6Ly9zZWN0aWdvLmNvbS9D
UFMwWgYDVR0fBFMwUTBPoE2gS4ZJaHR0cDovL2NybC5zZWN0aWdvLmNvbS9TZWN0
aWdvUlNBQ2xpZW50QXV0aGVudGljYXRpb25hbmRTZWN1cmVFbWFpbENBLmNybDCB
igYIKwYBBQUHAQEEfjB8MFUGCCsGAQUFBzAChklodHRwOi8vY3J0LnNlY3RpZ28u
Y29tL1NlY3RpZ29SU0FDbGllbnRBdXRoZW50aWNhdGlvbmFuZFNlY3VyZUVtYWls
Q0EuY3J0MCMGCCsGAQUFBzABhhdodHRwOi8vb2NzcC5zZWN0aWdvLmNvbTAmBgNV
HREEHzAdgRtqb2hhbm5lcy5laWduZXJAYS1lYmVybGUuZGUwDQYJKoZIhvcNAQEL
BQADggEBAMJhsGQW6C4UBZr7OpMg/n65GOd5Iy7i3vXW7gO7sgPe1pHYi1LJZ68J
lB9sP93yDViPMJ4Cir+/QqU7AtLyKkf+oo8nQTlx5gQeJnftZ/O6RkCS20I18GxC
aRDRRwD2JViL5Dk9uB87sV5DlOZV8w2VNWh+mm8wZGonaQ3NoNX+7jHcF5QX23Hx
x8ikwfv4jj3qajpv1l362Wl5FySKhdEXB/hhyxLjMfHEYs8PKHnjeWGbMPnqyTtt
xgnK+Gtmc4fjSlRf8Nzpr/q3iPppdSOmVk1lGmaGTJ+7ItiA1OTcFf7Atm8GomFp
QXdyoI/DW3zj355K+YADYhwhosfaQY4xggO+MIIDugIBATCBqzCBljELMAkGA1UE
BhMCR0IxGzAZBgNVBAgTEkdyZWF0ZXIgTWFuY2hlc3RlcjEQMA4GA1UEBxMHU2Fs
Zm9yZDEYMBYGA1UEChMPU2VjdGlnbyBMaW1pdGVkMT4wPAYDVQQDEzVTZWN0aWdv
IFJTQSBDbGllbnQgQXV0aGVudGljYXRpb24gYW5kIFNlY3VyZSBFbWFpbCBDQQIQ
Jeas1xh/A2vhUrWv4RxWfjANBglghkgBZQMEAgEFAKCB5DAYBgkqhkiG9w0BCQMx
CwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0yNTEwMjIxNDUyNTZaMC8GCSqG
SIb3DQEJBDEiBCAnTNqQOesqc9HWiMXs+ulUpvpisQ31AZRxqEA0Usz5JTB5Bgkq
hkiG9w0BCQ8xbDBqMAsGCWCGSAFlAwQBKjALBglghkgBZQMEARYwCwYJYIZIAWUD
BAECMAoGCCqGSIb3DQMHMA4GCCqGSIb3DQMCAgIAgDANBggqhkiG9w0DAgIBQDAH
BgUrDgMCBzANBggqhkiG9w0DAgIBKDANBgkqhkiG9w0BAQEFAASCAgBR4Fj+4UCa
4IuLCVRAAmkqizkzdijeku0aDCM9uTLq/bqbgpfmD81sjyIber7PJjMU027slzUn
FgEkqUe66hWA1QaAYGPtwbdFgJP5ucJCYEUnG0YzBLyPyApvnSECjPR9+RVmEwLf
yScgYe7zOpsQj2G8n/VNyxfZjdyWRDwYPUnkjt5MZd+aOtqJ4Cd18pklCRaMFDd8
9HnEVUW8SgVhkqUEEyvbMvyYDlPHzYjPOCT5EMevf76JK2z5MAOAaArSZ4D8MmNY
y7gB9lxcbL+sYyCl+ZDlauwqUL2y+oJOxJ6rts65VRgq/Xi7ndAnYid7AMHjGvE3
/DjKNtmoxjIRS3qKPPdtW8RUYQe6a8J3DXg4gFqRc82mMSkG0qCMGZpqXboMCTDV
i+d+m0OVFAOw+FMJ7ZnEdcbp7CneDj5poaQ7tJ6eT8OdXclAjt/gXhjSb1OHncMT
lP9FB0/FYuGNivs8nl1nS86zbkRzcWtGdrPe9KN22dabvjgLTWsSMIjzGDgyDlU8
ASpdDJwAu65hYPyRHKfrnlSkOcqgmcWFX050xCltSpRkOejaHzDbE4OyS6FCRVLd
N0klEv7Qqk+dXrk2M9Z1BawZcjNfe+wI918O/rMu63Gc0+ecQP0UQs9z4Rp2C4vB
4ynV9lP5YwKQKf+n2bMZg1rRdyDH382jIQ==

------A3B11A87AF72B28D8C083ACCF0DBB925--


