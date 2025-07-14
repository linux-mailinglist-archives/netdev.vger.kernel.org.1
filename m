Return-Path: <netdev+bounces-206568-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A0E4EB037FF
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 09:30:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B3751189CE2D
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 07:30:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABE90235368;
	Mon, 14 Jul 2025 07:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="PnZSeUbm";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="OEkQO6o7"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F210D235044
	for <netdev@vger.kernel.org>; Mon, 14 Jul 2025 07:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752478188; cv=fail; b=myiC4p6VCRnPgCakBRDcJ1O/PnY/MOUDgeTmyWWvGWyLtaU38tfIAHIHb9CV/gzmvAlKheQ7swq5gjE4pXFQldsLoQB66FrpbZjQ/mQgMG1op9JsOrcnhhzSf26DuLlXvcjyzSoGuYPAEbz24Ym6/Ptgdkt+7O7X7SvdEr3fEYA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752478188; c=relaxed/simple;
	bh=KHWBFZXqVHLSf2zyucBzqL0dgzum6gJ2dXxk4U9mFic=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=uqowdYY0ATPSO0PN1ydU/7OGPt0GR/l7TSQiO56TLS5BBaA7/d4I3xYatlvHmzX3PNRwKh7MzFVZJlwNin+BS7MWo89rN1dGpNGXue0juBqVZ0TeVB0oKyC5jqQQXVVRF980gb0N/WLYgdUq4UQCZgyNxO84Pl5qUa0Xc86JJP0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=PnZSeUbm; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=OEkQO6o7; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56DMfKLH008410;
	Mon, 14 Jul 2025 05:06:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=KHWBFZXqVHLSf2zyucBzqL0dgzum6gJ2dXxk4U9mFic=; b=
	PnZSeUbmFKpWFYzuVWO6yawGBXjv6khmWWWSS+FMsU2LNrLh26U5lf9mce7Jzdf8
	PQqpCedLjkRbvl+QA0hbF/JS3rto4WqrrwqsAIfC1QumGlREW4xa5/c9xztrf1zA
	V/fSUKy5pN8lXXAT3ZO1Z2Ay7jZK+oU5RGFrUAb+QTH0N8PKy+uSZ6UQ5GUfq7vH
	lCjDM03ZQVfTOx039/D1cISNksH77ng2bUGdcjl8xo19ONfgeTf4FVnGRxzroVDO
	Qab+azZv3lr6CMM7ZvF4i0vsay52Yapox0F8INNADFo8dWQFfXtEwrNFqJKmfuuk
	p/aQyahY9O2bmvXaFt74mQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47ujy4kctj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 14 Jul 2025 05:06:25 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56E1KXSc029758;
	Mon, 14 Jul 2025 05:06:24 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11on2040.outbound.protection.outlook.com [40.107.220.40])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 47ue57v9xr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 14 Jul 2025 05:06:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f09fjq/BesAMOsv82/EMoxkg5VfbHNtwqRq64n46jERhlmKFfwsji4hMwc4IyorMDtl/pHxEDNzVx6SAqVfbmowCNK5ccKH1n2wzu4EdflV+fh53Tb4Ek8eoFgXyFB19RMksGdJo/p0wz3OpUyWK+3NfukhCPCF+JouRp7+ssytuefxBWhmLW8dW4+5Ddy+vvz57IylOMCNKPwIQt7PGpY2XUGpMBIJv3a1blELcCcOQde542wGNxfdywsBJ+/FPl3XaoKIMSSwQgBVsayrS7AKd0txOLuOT0eQFkBgkua3GBfnwxvSRMJ3FDwFo4orGJJP4iLP0paVybSU6ftng+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KHWBFZXqVHLSf2zyucBzqL0dgzum6gJ2dXxk4U9mFic=;
 b=l2IK+peppdg0xsI6RKitvY103Yz3s/ug8bnPKJ+6BEjuxLhA09QFz3AARsXWBDaVufXmaeYAw2f9iudHClwC47iRXUDNSA5w5APuQ0IA9fKdP9cfl2wnZS4ncXlUgVO/HgaDP5zYE0NPLVjp2GxJ1iq8p0nJrK9bLAaF9tz6P4uKaiPscw+f4slHvzvfQpzq0Nm+rOe5Xhl7wYljzTD2v4PHucghgluKYVlqCL16iqtO/oee7TmQgX3wKWGxorKWjz7dg+y6PVnkT67/xDWIuhuwmIaYwGGUVG98YgGZA6VAz1FjZyjpkFVe1FtE+0TuqBHqgawYJ5/cHFxrEywTHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KHWBFZXqVHLSf2zyucBzqL0dgzum6gJ2dXxk4U9mFic=;
 b=OEkQO6o7NqNaMPGRujN+PPnYR34uHCGvQSPo2thdAzmhkB+wdh4jqAKVtZ/N8NRcHpKSZviiupDbjPmb4YVxHQZ/FhWvSjUP2jaos/Ydmjwg36/rfaVQHGxgbuf/I/617SCn7gDdehSyvwCxk5aB4SpAXz6S3hck12vpzuzOL7M=
Received: from IA1PR10MB7417.namprd10.prod.outlook.com (2603:10b6:208:448::15)
 by IA1PR10MB6170.namprd10.prod.outlook.com (2603:10b6:208:3a6::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.26; Mon, 14 Jul
 2025 05:06:22 +0000
Received: from IA1PR10MB7417.namprd10.prod.outlook.com
 ([fe80::4970:7ab6:8d74:aaf9]) by IA1PR10MB7417.namprd10.prod.outlook.com
 ([fe80::4970:7ab6:8d74:aaf9%4]) with mapi id 15.20.8901.024; Mon, 14 Jul 2025
 05:06:22 +0000
From: Allison Henderson <allison.henderson@oracle.com>
To: "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [RFC][PATCH] don't open-code kernel_accept() in
 rds_tcp_accept_one()
Thread-Topic: [RFC][PATCH] don't open-code kernel_accept() in
 rds_tcp_accept_one()
Thread-Index: AQHb9CA2QLpUxMoCe0CMXsyeXGlURLQxCX2AgAADDQCAAAVJgA==
Date: Mon, 14 Jul 2025 05:06:22 +0000
Message-ID: <00c1f8e162f2b5b50d0326738230a7a6f55d971e.camel@oracle.com>
References: <20250713180134.GC1880847@ZenIV>
	 <2eb0df2c5dd8b16b5103f0e2859690519c4f2dad.camel@oracle.com>
	 <20250714044726.GD1880847@ZenIV>
In-Reply-To: <20250714044726.GD1880847@ZenIV>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.52.3-0ubuntu1 
autocrypt: addr=allison.henderson@oracle.com; prefer-encrypt=mutual;
 keydata=mQGNBGMrSUYBDADDX1fFY5pimVrKxscCUjLNV6CzjMQ/LS7sN2gzkSBgYKblSsCpzcbO/
 qa0m77Dkf7CRSYJcJHm+euPWh7a9M/XLHe8JDksGkfOfvGAc5kkQJP+JHUlblt4hYSnNmiBgBOO3l
 O6vwjWfv99bw8t9BkK1H7WwedHr0zI0B1kFoKZCqZ/xs+ZLPFTss9xSCUGPJ6Io6Yrv1b7xxwZAw0
 bw9AA1JMt6NS2mudWRAE4ycGHEsQ3orKie+CGUWNv5b9cJVYAsuo5rlgoOU1eHYzU+h1k7GsX3Xv8
 HgLNKfDj7FCIwymKeir6vBQ9/Mkm2PNmaLX/JKe5vwqoMRCh+rbbIqAs8QHzQPsuAvBVvVUaUn2XD
 /d42XjNEDRFPCqgVE9VTh2p1Ge9ovQFc/zpytAoif9Y3QGtErhdjzwGhmZqbAXu1EHc9hzrHhUF8D
 I5Y4v3i5pKjV0hvpUe0OzIvHcLzLOROjCHMA89z95q1hcxJ7LnBd8wbhwN39r114P4PQiixAUAEQE
 AAbQwQWxsaXNvbiBIZW5kZXJzb24gPGFsbGlzb24uaGVuZGVyc29uQG9yYWNsZS5jb20+iQHOBBMB
 CgA4AhsDBQsJCAcCBhUKCQgLAgQWAgMBAh4BAheAFiEElfnzzkkP0cwschd6yD6kYDBH6bMFAme1o
 KoACgkQyD6kYDBH6bO6PQv/S0JX125/DVO+mI3GXj00Bsbb5XD+tPUwo7qtMfSg5X80mG6GKao9hL
 ZP22dNlYdQJidNRoVew3pYLKLFcsm1qbiLHBbNVSynGaJuLDbC5sqfsGDmSBrLznefRW+XcKfyvCC
 sG2/fomT4Dnc+8n2XkDYN40ptOTy5/HyVHZzC9aocoXKVGegPwhnz70la3oZfzCKR3tY2Pt368xyx
 jbUOCHx41RHNGBKDyqmzcOKKxK2y8S69k1X+Cx/z+647qaTgEZjGCNvVfQj+DpIef/w6x+y3DoACY
 CfI3lEyFKX6yOy/enjqRXnqz7IXXjVJrLlDvIAApEm0yT25dTIjOegvr0H6y3wJqz10jbjmIKkHRX
 oltd2lIXs2VL419qFAgYIItuBFQ3XpKKMvnO45Nbey1zXF8upDw0s9r9rNDykG7Am2LDUi7CQtKeq
 p9Hjoueq8wWOsPDIzZ5LeRanH/UNYEzYt+MilFukg9btNGoxDCo9rwipAHMx6VGgNER6bVDER
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR10MB7417:EE_|IA1PR10MB6170:EE_
x-ms-office365-filtering-correlation-id: 2b897b79-afdf-4c78-5840-08ddc2942d29
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?a2JuWWVkQjFLbGlKZWZtREFJT2VZeDBSYzBFRWVFTmRjR1krWEJlcU5NVUt0?=
 =?utf-8?B?TlQraTN5VGhIcHNuRDFFdFcyTHlsYndvN1ZaQitpNHJ4b1BTWktzMHdUUTUw?=
 =?utf-8?B?dXFkdmZycmhEWTZYUk1FR2F5SnpwWDBwVEVEaHpqRU5pK2NhV0ZNcnhQNmM1?=
 =?utf-8?B?SlR4QlY5Y2FLbDlTNVVtZ3hTczJHS0ZvTWYxeXZMUEFwcUZtWFUyakpJUFdt?=
 =?utf-8?B?M2pZUzNHR2VuaE1STHhUQit5NzFoalFrY3JWcC8rSGE0VUI4b0UveUVqUnV1?=
 =?utf-8?B?cUpPRGlxYjc3NFpMK2dQMWZHSkNJdFVMZWVBblJiMWs3Z1kvRFpUdXo3amxH?=
 =?utf-8?B?YkhsM2VKZUw5OG14dTF2Mjh3Undhc3B0VDlQZklXZTNYQ0NQaUM0em5qQUxE?=
 =?utf-8?B?UGZJRCtlOHdIVU5uTzZrZHFjdWlNNHFqUGVYNHBnMXJtaExDakFpNUVEVkU4?=
 =?utf-8?B?OEJPTlFHMjcySWUyUDJaM3FYeXBWenkzV2hoRThxSEtZV2ZKYk9WUllXUUk1?=
 =?utf-8?B?dlNQei8vVjRZYzlMWU5jZnhwM21MV3grSG01NnZYaitXYVFRc1JBMzZXajJn?=
 =?utf-8?B?V0RZZkVmTnRPTkE1RXp4alJ5T3JwSjdJOVV5ZzR5Q2FCWWNmeVdSWGFtT0Nz?=
 =?utf-8?B?bU5PSHVtQnN1MnJaWlhEMUxCYVVQRU85ckNsc21jOVo5aTJkaUU5cmU1cmhk?=
 =?utf-8?B?Wlo3VTdRWmVnTEYwZUx3QU8zZTJHQUorVHNNc09mYjlKMWExdkMya2dSRXJj?=
 =?utf-8?B?bGR5S3ZEZXErMi9FTjVpSVI2ZEhkN1d5Z2ZqckxKYW9KVlYwVGk1TjBadlFG?=
 =?utf-8?B?WmpGOTFOYkVEMnAxZTY5Zmt5NDJBR1BrUVRqODJoenJjSWI0VUFEM1V5U25N?=
 =?utf-8?B?ZXQycm9CdmhpY2Zldi8ra1VyS3dia3FZMUYyQUVXR3h1dzhHMnBpcGcyNzMz?=
 =?utf-8?B?d1NHLzNWSGRwUGhtSjB2c29NcjNGNmRxWFpWdzdUcVdXQzRzMXZNNTJBYURr?=
 =?utf-8?B?SDJXbFFWMDhZVmg4b25ZV1BCeXgvaFJIWm5tVEk0eU1LK1ZOVGMwcmpVMVhh?=
 =?utf-8?B?UnVFKzBKb0xKWktZd1o5cFptaVRDUGJHMXBHaVNYOEx3SEZqV09nZmV5MDVV?=
 =?utf-8?B?bjJRUDJwUjQ1YWZJVXVPQVNtcS9BYk50QWtEMXlxL0hSeXNYdERUcGhIeng3?=
 =?utf-8?B?STJsWTJBaHZTc1d5QkZWN0puNkd5VnNNTGR0czllaTFXdCtyYWk3RjZOQVVj?=
 =?utf-8?B?dFBsVk9aajM5K1h0NXJDTldUZStKMW84UzZwSDBUSWQ5V0tGMUdKbXd3UGIw?=
 =?utf-8?B?aFQvb3Q2czl5VU5uUnNQcW9zRjJ5YTE3TG1CQ2xOSE85Qzh0SzhXS0oya2pi?=
 =?utf-8?B?M0FPOW9taWs4N0w1NDV3RWJteXJNUW1DWHZaNUM5V01lZzRGYndNL25PYWRn?=
 =?utf-8?B?WWNkQ3lBeHRkMUNXc1ZOT1NiVUpkZnZOTzA1VENjb1E1WndYenZacnBxR0pm?=
 =?utf-8?B?LzVWVWxWcHpaQjRNaHlSMnQ3MGx3ekVIUktxVWl5c0llb0s0OFJDT0xHRTFW?=
 =?utf-8?B?amt1dmZueTBRdnRlVVE0elI1VVUxYUUyNm1KTXZtUW9lK3dxMllmTnF4VThw?=
 =?utf-8?B?NVBieDZxak96Zk9nSnBGS2o2ejd3M2pPNncrSFJlR3VRR0Nncm43bUtXRUJh?=
 =?utf-8?B?bTdkVkdHZ1V3YWU0NTluODZTc2RGbXpOazFkZVlGcmZYdDlPcEswa0JoVk1H?=
 =?utf-8?B?bFFKb1I4WVM3ejRra2RFWWwzUlFuaHgzc05TM2ZPUDdkUE1OZElKS1JJY2tR?=
 =?utf-8?B?Ym1EZkw4aEVWQnUrY2hFWWxjTmw5eDhGaVN1Z1U1Qyt2MUtaL2FoNGpwOTgr?=
 =?utf-8?B?a0lxK2hWWk1RR1U4RW9iZDMyNmw2akJnUHl0cndmVHY5NEl3T2ZmU3lKcEpp?=
 =?utf-8?B?M2lGRE92dkNxRktYSU10bjJsUXV0djd1c2d4Y2dNMmFIYUFSYk93YlJWeE9C?=
 =?utf-8?B?V0pnSXIrMjlRPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR10MB7417.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SmhaSVFNZlZCRmxzUDNOZGYwTTJXSTBnTG82S0pMS2M5cFhyd2x5OGx4a1Qv?=
 =?utf-8?B?YVczdWVkdm1iRjYyaGhNbWN1KzBweDhkUU0zM21kMk4raGxOTGR0NUxxaW5k?=
 =?utf-8?B?RjRjdFF3dENPbXJuRU0yZ0dOS3JZQ1RJNjE3RGtHSTc3bUZoS0s5blB0Tllj?=
 =?utf-8?B?TnhreDlkQWRMZ1RhVTBCNUtMMVJTekJCdlpBaXBnV0NtNjhBei9zYVZkbG5o?=
 =?utf-8?B?ei9zZDlJYVhUalRGdURYSVdneGtySUEwTVNQUWJYUzJFSDQ3U3E2QTBFNEx5?=
 =?utf-8?B?cnNuZlJsai9UQVh5MnlkVmlaUFphY3VheVo3L0t1ZUp6aWpXQmVhUUNIY0tR?=
 =?utf-8?B?a2R3Qy93eFNCTmpGdHFHMlYwOE4vMld6K1JaSnhTeFNPbWdhQy94WGhoc2ov?=
 =?utf-8?B?cHZEeXplQ1R1L3ZUV2NHMHpVTVZzRzNPZzFqREpzWE13UTNXSDNJMlROaGJL?=
 =?utf-8?B?OGkzcDREUmY5cVFIalcrbWlhSzVwR2cwcTVQNXlYTUdRZ01ORTJ5N25kZjdL?=
 =?utf-8?B?bjViNHlPcWpObnFCTWZPZUF2UFJMV3RJdGdTOWNFb0NhQWVuNHNBRk90RHMy?=
 =?utf-8?B?ZllXd3pxSGhVNTdSYTZyUUZGTW84ektmaC83L3QzOUZQTkRmeGxkaitUZGZT?=
 =?utf-8?B?NVhqM29PY25BNG05aEI2Mno4ZUFYLzM4bFp3eGdpSXgrZHY5WUFKTHhwNTJu?=
 =?utf-8?B?SFA5QmFBOXljZ25PZE56VjJ0dXZURjI3L29WeUxFWVQxZmtHb0VnM3VxWTZJ?=
 =?utf-8?B?cWZOMjJBS290VjJlNk1saEVPU09NaGFaazFpaGg5MWRmSm80L0VmRW1vN2lX?=
 =?utf-8?B?c1UvOFd2L0hJbGk4S1BRajZablNiMnoyN3JxWEthMGVOWkoxZFdZalMwTlJJ?=
 =?utf-8?B?eHZ2Tm1KalIyN1VNM0plYUhvanFlOHRuaWxkUjU4eGFjRkdQb2hmb0lUY2ww?=
 =?utf-8?B?SDdKY0Y1VTJaV29BV3lINzZ3ck9GZ0EzVW4rUmtxT1RvMjlSZStlNE5sZzg0?=
 =?utf-8?B?cWRPWENTVGpKaDRXejQrdFFLd1lTbmF1OHRWSlowOFpRSmdqNGRwb25FcUN4?=
 =?utf-8?B?VlJjKzM0bDJBS2hjeEtqdHp3YzcwM2V4V0JydWxoSUZqN3YzMldlbHgydXBM?=
 =?utf-8?B?cklxWEF4TDlYbVlndk5hRENCcEJLenVxYlUzbjlkQU9DZDBZbjhoWkdGYmlS?=
 =?utf-8?B?WkJSMWNXUjV2OTZqVUR4MmpUVzk3ZWRwR2ZHNFJuVUNIUFBhcHhaQ3pBU0No?=
 =?utf-8?B?QThhc3JibW0yc2gxd01Vem14czh6YVY0cStkdGNtSHRLdjFpc1BKUzlyV0Er?=
 =?utf-8?B?cEVwMm5wOVBDSzhTYTVLQlJuYXJ3bGtLZnlvTjVOWFhwWG1haVo4SC9wUm14?=
 =?utf-8?B?UUpyaHJkSGtPcFVrQWxBc3laVkRaQWVBbE1meWNzUHV2OGJEaUxxalpLQ2lk?=
 =?utf-8?B?aWJ5NnBOaDFkemxDWTVML1lKdVlaREV1b2p1cHNOR05nekVYVkRGcFBSM243?=
 =?utf-8?B?UFFlcGVFNmZ6WTM1QXhOTWhEZUxSbjMzTEYxNmRWOHlCWm1ubWhHTkZHN3lD?=
 =?utf-8?B?Z0kwT1JoMkliT0JHNFdEV0YyR0d4THdRcHFjMExDbGNoaFhFM0NoRWE0eS9r?=
 =?utf-8?B?Mnp4SEw3b3BSSExVQWRFeDJDUk41eWg3Ym44dDQ2ZUFyaVRwZ1dYdVNUKzNx?=
 =?utf-8?B?Ykt0MnVGOEppd2tNZXFnNkNwS3hqbTEvbXk5R0k1U2Z6b1FhOXVjSDRkRHQw?=
 =?utf-8?B?bGtyKytvZnpPZklqV3RvQUJiai95aWp5NGhVSWZRdmlwZzhKVG8vYmNydlR1?=
 =?utf-8?B?QjlJT1FVSm9KT005eVR3emduOTFpV1dCaHZWeWI0SG13UmJuT1dsdGd0QkJ1?=
 =?utf-8?B?M3F4d050M3lqOVl1bnpKVzNsWGhSdVhhR1JkMFhpMWdSOE4zU2FMVE9hWjJD?=
 =?utf-8?B?RnV4cERZOThCQ1FibkZjOVNPbkNzL2NyL0J3QXkrOWthTENGZ3U1UlpQTEZL?=
 =?utf-8?B?V1lrTzh6enFJSHVRRndVeXRmR0owR2JBY1JHS25ncjIrNDEwdlpwaWFTSWRL?=
 =?utf-8?B?VjhicmwrODRjVDFGb0xjSlJYQWlSQXdSMU1XSEtkcEJFclZlQVZRd21EcUVC?=
 =?utf-8?B?bEFvdmtJVWoyYmQzZEVtY1UxWlA5UEgvWDZpUmRUcGxaL0lIZFBjamxXeFBt?=
 =?utf-8?B?ZkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BBBDB0C616FB3341B7C2C89D2145A6D7@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	5Mcu0pdjVmfl858rt9MZ4rAGpcReqajUex44P33iKuY6mvlWO3RYgasPDk/RsXk8Q/4Aq8lImlv21xXzw8V06ud/BP7WfH4K7MNU0niUGE8mKP6woCMJcCWZw9xMPPFOY/WMoyVZcr17LQPgkej9edsIf5dt2HGS9V4sZtbQCVsJHnYAwnLjn3LV3sjxvprS+W0RbC3cotFZqKW1yMGyjdpfLVcERTBdevxt6ICD/7f+yyQBhCsvxQIiHaOZxy9HMPROwV4x6Ici5lfmkvKDzm1O05H7fCMz6hybbT+RanFFOv8fgKcdHscUQjmQn6RQK50Em2vEiYku4AdgxgmK7LpcnfZ6lVmrEjgvQUyOZlTvPXHHPo+NMdJbfavUJh3wthRbbE/XmBJhM48vFJ1BCifUNPb2cR6wDV8BdNOuOtv0gne/lwkUbOZIwzVfDs2GtCIcNv4+copFqNPoleFZYxbAxNfKoy6bGlQU5oqo3yA+u1ncsFZE7+5ATHmjxHf1JTFtO3ECrmzf6Kj96ADWHX2G5T9oMxWn5XOMBqnmIOlbhDZ5rZM4HLfrlCjXnoo0+0N4ajJ7pTjebYZrSxc+3Ce8iQoBw06yOtpHQ9AAQV8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7417.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b897b79-afdf-4c78-5840-08ddc2942d29
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jul 2025 05:06:22.4874
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5UixSvqaDE9JIl0QikWuogcQP6isPxHkTPR8t6YQTkbif0T7499smmpz8cVLugWgHrKSUN4Z6rOMFZOiQbvRU7JtJOoLra3qnluq4kRzaHw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6170
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-14_01,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 spamscore=0
 suspectscore=0 adultscore=0 mlxlogscore=999 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507140027
X-Proofpoint-ORIG-GUID: lbfPmVXiCrVSKmiwsGt2PHndkoqUxYR-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE0MDAyNyBTYWx0ZWRfXxdhbzYfZ0GZg JycQ6PNsxG1HnSZCbYAeXEXOKS4lPZ7sAkJIZQnF9/nVXqrs4Ym32R/cBZ5AmEoCfS0wlNkO/90 AW4P+R+4+Asi+ZGT5boeSeZ0LRW0X5cAvugciqpDy5Kd+xizrC7+qSGLd/fTxHq7Ab2KhDsMD7T
 UNLEPPw3Ac+HOY7iVpxrb3ZxCk+QUJUCzcwMsX4hIilmeMPR/1qA1eblMEwI2nHaYb/m5bc4Kg/ B7tUvZPSTM42C4psQ9xr5h3pYvw3ZFpVd9y7+9Myn7eL+vxR4R4Qorw1O3F0mIrZ/sU+/Q34nGZ BdrxKPwpFcncUZ63paR1m4ki5vVcPlMoXaHSQbVkihiYtGB7EiCPgfCdoEBMzkEDIvYvoqughkr
 MSPhDju3+ikjh8IhMfeQyONei7c0NQDCQ5TzK7NVialQ1KCxbXa2ResF2cZn0fDDy2gQnAdl
X-Authority-Analysis: v=2.4 cv=Xtr6OUF9 c=1 sm=1 tr=0 ts=68749051 cx=c_pps a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=Wqh_DNTVE8qOCQbOHYoA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: lbfPmVXiCrVSKmiwsGt2PHndkoqUxYR-

T24gTW9uLCAyMDI1LTA3LTE0IGF0IDA1OjQ3ICswMTAwLCBBbCBWaXJvIHdyb3RlOg0KPiBPbiBN
b24sIEp1bCAxNCwgMjAyNSBhdCAwNDozNjozMkFNICswMDAwLCBBbGxpc29uIEhlbmRlcnNvbiB3
cm90ZToNCj4gDQo+ID4gPiAgCWlmICghc29jaykgLyogbW9kdWxlIHVubG9hZCBvciBuZXRucyBk
ZWxldGUgaW4gcHJvZ3Jlc3MgKi8NCj4gPiA+ICAJCXJldHVybiAtRU5FVFVOUkVBQ0g7DQo+ID4g
PiAgDQo+ID4gPiAtCXJldCA9IHNvY2tfY3JlYXRlX2xpdGUoc29jay0+c2stPnNrX2ZhbWlseSwN
Cj4gPiA+IC0JCQkgICAgICAgc29jay0+c2stPnNrX3R5cGUsIHNvY2stPnNrLT5za19wcm90b2Nv
bCwNCj4gPiA+IC0JCQkgICAgICAgJm5ld19zb2NrKTsNCj4gPiA+ICsJcmV0ID0ga2VybmVsX2Fj
Y2VwdChzb2NrLCAmbmV3X3NvY2ssIE9fTk9OQkxPQ0spOw0KPiA+ID4gIAlpZiAocmV0KQ0KPiA+
ID4gLQkJZ290byBvdXQ7DQo+ID4gPiAtDQo+ID4gPiAtCXJldCA9IHNvY2stPm9wcy0+YWNjZXB0
KHNvY2ssIG5ld19zb2NrLCAmYXJnKTsNCj4gPiA+IC0JaWYgKHJldCA8IDApDQo+ID4gPiAtCQln
b3RvIG91dDsNCj4gPiA+IC0NCj4gPiA+IC0JLyogc29ja19jcmVhdGVfbGl0ZSgpIGRvZXMgbm90
IGdldCBhIGhvbGQgb24gdGhlIG93bmVyIG1vZHVsZSBzbyB3ZQ0KPiA+ID4gLQkgKiBuZWVkIHRv
IGRvIGl0IGhlcmUuICBOb3RlIHRoYXQgc29ja19yZWxlYXNlKCkgdXNlcyBzb2NrLT5vcHMgdG8N
Cj4gPiA+IC0JICogZGV0ZXJtaW5lIGlmIGl0IG5lZWRzIHRvIGRlY3JlbWVudCB0aGUgcmVmZXJl
bmNlIGNvdW50LiAgU28gc2V0DQo+ID4gPiAtCSAqIHNvY2stPm9wcyBhZnRlciBjYWxsaW5nIGFj
Y2VwdCgpIGluIGNhc2UgdGhhdCBmYWlscy4gIEFuZCB0aGVyZSdzDQo+ID4gPiAtCSAqIG5vIG5l
ZWQgdG8gZG8gdHJ5X21vZHVsZV9nZXQoKSBhcyB0aGUgbGlzdGVuZXIgc2hvdWxkIGhhdmUgYSBo
b2xkDQo+ID4gPiAtCSAqIGFscmVhZHkuDQo+ID4gPiAtCSAqLw0KPiA+ID4gLQluZXdfc29jay0+
b3BzID0gc29jay0+b3BzOw0KPiA+ID4gLQlfX21vZHVsZV9nZXQobmV3X3NvY2stPm9wcy0+b3du
ZXIpOw0KPiA+ID4gKwkJcmV0dXJuIHJldDsNCj4gPiBJIHRoaW5rIHdlIG5lZWQgdGhlICJnb3Rv
IG91dCIgaGVyZSwgb3Igd2Ugd2lsbCBtaXNzIHRoZSBtdXRleCB1bmxvY2suICBPdGhlcndpc2Ug
a2VybmVsX2FjY2VwdCBsb29rcyBsaWtlIGEgcHJldHR5DQo+ID4gc3lub255bW91cyB3cmFwcGVy
Lg0KPiANCj4gV2hhdCBtdXRleF91bmxvY2soKT8NCj4gCWlmIChyc190Y3ApDQo+IAkJbXV0ZXhf
dW5sb2NrKCZyc190Y3AtPnRfY29ubl9wYXRoX2xvY2spOw0KPiB3b24ndCBiZSB0cmlnZ2VyZWQs
IHNpbmNlIHJzX3RjcCByZW1haW5zIE5VTEwgdW50aWwNCj4gCXJzX3RjcCA9IHJkc190Y3BfYWNj
ZXB0X29uZV9wYXRoKGNvbm4pOw0KPiB3ZWxsIGFmdGVyIGFueSBvZiB0aGUgYWZmZWN0ZWQgY29k
ZS4uLg0KPiANCj4gTm8sIHJldHVybiBpcyBwZXJmZWN0bHkgZmluZSBoZXJlIC0gZmFpbGluZyBr
ZXJuZWxfYWNjZXB0KCkgaGFzIG5vIHNpZGUNCj4gZWZmZWN0cyBhbmQgd2UgaGF2ZQ0KPiAJaWYg
KCFzb2NrKSAvKiBtb2R1bGUgdW5sb2FkIG9yIG5ldG5zIGRlbGV0ZSBpbiBwcm9ncmVzcyAqLw0K
PiAJCXJldHVybiAtRU5FVFVOUkVBQ0g7DQo+IGp1c3QgcHJpb3IgdG8gaXQuICBTbyBpZiB3ZSBu
ZWVkZWQgdG8gdW5sb2NrIGFueXRoaW5nIG9uIGtlcm5lbF9hY2NlcHQoKQ0KPiBmYWlsdXJlLCB0
aGUgc2FtZSB3b3VsZCBhcHBseSBmb3IgdGhlIGZhaWx1cmUgZXhpdCBqdXN0IGJlZm9yZSBpdC4u
Lg0KPiANCj4gDQpPaCwgeW91IGFyZSByaWdodCwgSSBtaXNzZWQgdGhhdCBoZSBhc3NpZ25tZW50
IGNhbWUgbGF0ZXIuICBUaGlzIHNob3VsZCBkbyBqdXN0IGZpbmUgdGhlbi4gIFRoYW5rcyENCkFs
bGlzb24NCg0KDQo=

