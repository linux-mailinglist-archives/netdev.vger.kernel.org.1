Return-Path: <netdev+bounces-203811-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 46DD7AF74C8
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 14:55:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 594B21C40531
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 12:55:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C7DA2E6D1A;
	Thu,  3 Jul 2025 12:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="GWcgO8rC";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="jJuCkCjB"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D6412E4994
	for <netdev@vger.kernel.org>; Thu,  3 Jul 2025 12:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751547332; cv=fail; b=YO+dvzJhtQ1JrmS468A66LbvgENM/7aM7NPtrzRZzB2GDpkQDGodLzPg2Y39xvCDpDH/CljvjMvUtftfEwvevQOZQB9Gk4pcrMaAdEa3Eo8j+un8+xsZP7XJqPO8AN29v3cArAGiWxVcefeViR/NZPekh6pGvLtMGJ3+R4zlDWs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751547332; c=relaxed/simple;
	bh=hEDrvBL0G/u9poJ2xwrOtODRBk8/BVqavKBRb2YdQEc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ajubnPqO1D0A/OV4YoES3VOI99q8w2dsIxYOxsXSxV+r/IQeQNOSmH5aykIG1uPE/W0D2E8TsZjjy1V4PPEkDUTHOwzOUlmXNcWzLX6tTFiMnjfMdvLKxnxr1/zqIA2n+lX75QRbnfKUNNSqnBSQ6/4kny5hO7nTkKkLuxMfaNk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=GWcgO8rC; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=jJuCkCjB; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5639YsIS008176;
	Thu, 3 Jul 2025 12:55:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=o51xpM7+NfPvy25SSy1cULf7uJuCFcf+MiG6e0Db3qc=; b=
	GWcgO8rC+TwX+bqEhQaHFNQLbIlQC7zQ6csiUzmubHqdK59vKVOqAOI0cnsjl5K0
	8OfUJ+ULwxcTj1Jc9PJ159mQ81vpqZzyWlZWAjIK6wcGYLL+z3Sl5BCibKjr/fl9
	FCmSTji/fm7zkx8MFPyUTzah6uxPHZJ4HWBVceVGCDd0VU0Y1Qz9bBZpKAwABG44
	pHCTv0qrX0lyZ6jdNqGH9lRZj0Mqtadf19GxVYOINFea7rPaeThSWHyjC5CugnFH
	0c9xoukivoTD7ZVOdFu9cPuvLfqSNAN0/IS7UC9OkL616p6RvHxrYM7xCUVa+Eke
	YXbP5lywfpLzqVNvb6e0QQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47jum806w5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 03 Jul 2025 12:55:24 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 563C1Jmg025008;
	Thu, 3 Jul 2025 12:55:22 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02on2064.outbound.protection.outlook.com [40.107.96.64])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 47j6ukuvc5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 03 Jul 2025 12:55:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FLCu2PFDlAsPUD6yj7uJPspPAo3sWvKYupJkBAFng1DUekJ+DZSgEoYzfMKrZOeZTcFnuL1sAR7iWqfXdh9ZlT2rXODJb5Gy2zv6ZL2BR25rlz/NPznpmmUCILdvZWoflQ1AWUI8WfxUxEp8cjjcWWJkYLZctiHfTz/IsFi7u4nPY9QIzztW1jG0ZBiv9ljEi0do/aHsxBCfvlFxTCajgJ3Yd35/meyPy9MI4u/wpUvP66IMlejkPsB6vXQHG3Fqkw/pv0uO156mwkhvyoIpsIVLR7H22BdsasTqThZgoHwtY+4uUaBzuh4kGy+r2Dzcb6Px2b6sG36oj7okWO+eHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o51xpM7+NfPvy25SSy1cULf7uJuCFcf+MiG6e0Db3qc=;
 b=AJI5rCgf9fXQf6pB7p9ndIpYmFalcDuUAXOG14FoZC3Gv72JwQMlrMK4Xx3tazqP6WIdgjdV3p/0UiYdfWhF5SV8f9V75lNErUegLP58KTsyfT0hAa8Orazkt7nje0Kz58/nBO++1RIegekMwE74s0ur9+UwTFinykS9xLYBT9dfNBwzlDk8lthOYrF522V2j6ZoxiABUrVVToZspM9IY8utAksfFnm7Bw6uvpm2xi2H8QWlVkT/FlS7YkGbl2amH0YTrTkv8UvX1sZDuIjL6YdLMl+8bvMVC1FbEVL3KO9bcR1wjDHoQDgd5h2PQmwno9nkhgB+aS+4rk75tPyz6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o51xpM7+NfPvy25SSy1cULf7uJuCFcf+MiG6e0Db3qc=;
 b=jJuCkCjBO0fenv22FN9JeA2aNgSqN4NeZIMin4B+CPBs1YQxSVqmC27BXSORQ7wpA9USHoBClUoFXbZAvP9srjp936QGbH+PKk3PxLwqkCB8mB2Y0+L51fmtSfkrQSsd7TzgIQU+gNsFds7UnKjqR+H7y5Q1ybZb6u/NegfYeDw=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by MW6PR10MB7616.namprd10.prod.outlook.com (2603:10b6:303:249::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.21; Thu, 3 Jul
 2025 12:55:20 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%5]) with mapi id 15.20.8901.021; Thu, 3 Jul 2025
 12:55:20 +0000
Message-ID: <df7a3f18-3971-434e-9222-6744d5b77f83@oracle.com>
Date: Thu, 3 Jul 2025 08:55:18 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net/handshake: Add new parameter
 'HANDSHAKE_A_ACCEPT_KEYRING'
To: Hannes Reinecke <hare@suse.de>, Jakub Kicinski <kuba@kernel.org>,
        Hannes Reinecke <hare@kernel.org>
Cc: kernel-tls-handshake@lists.linux.dev, netdev@vger.kernel.org
References: <20250701144657.104401-1-hare@kernel.org>
 <20250702135906.1fed794e@kernel.org>
 <5c465fcd-9283-4eca-aef4-2f06226629a3@suse.de>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <5c465fcd-9283-4eca-aef4-2f06226629a3@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH5P223CA0014.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:610:1f3::16) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|MW6PR10MB7616:EE_
X-MS-Office365-Filtering-Correlation-Id: cdfd3796-a8bc-4884-1750-08ddba30ddfa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ekxtRkJxYUxCWFF2V2xvMVdGWktaV3lZc1RVYk1RSlhhZTlybjk4QnRWMTdQ?=
 =?utf-8?B?cG9uVjZ2YUs1bHp6ZkwzcGVqY0QyVjByTHJHKzZkZG92YnVxWXBabGJOVzZv?=
 =?utf-8?B?YXVlbGhqSlAxWVFzdUNtdFhabnZkMUx2ZS9uQU5mZDg3L1RlSnNWdnBxUzUy?=
 =?utf-8?B?TGJnaDFEK2F6RkNQeFhGWitIMnJvWjZZU1hBMVBUalVRaE1jTEFMRzNLVzR6?=
 =?utf-8?B?b1RGM3ZUSEcyeUI2citCaXQzL28yUkpRZFJLdTBOakdjMVErMTBxZklMSkg2?=
 =?utf-8?B?Y1Y0eTAxTVFGdkJIVGM5L1YwTWg5L2h2eVBzbEd1blB1NFZ4M00zVW5nNmcx?=
 =?utf-8?B?bW96RWIwbWVvdmZGc3lJV0VrSG04QVpJbCsvVVE0dzArbHdjL01JVnhYS0F4?=
 =?utf-8?B?Rjk0Yks2VTNPS2taRXJUNUcvenFJK3d1VGhlcFlOV2xGeWRhTVBSMXJkaGMy?=
 =?utf-8?B?ZFlLcndkakZkeE1kU2d5Nmh3WTNGbUJoWCtIcDFmQk83czQ5VjV3cU01L2RF?=
 =?utf-8?B?YVJDQmRESmRMM3JkSUF6eE0xOXBRbU1DZ2k5V2E2SzdQdW0xalR2Q3pYVHlq?=
 =?utf-8?B?VW5NRTkvZGlZVDd3NmxseTc4SmFqeVB4VkhhWkNzcU5JRk9qWVJWQmw2OHhh?=
 =?utf-8?B?a2E2S2R4c0l3L25wY016eHZtc3FzRk9rbEZJdW9HNnVPVCtpUzB0cGo3cUxB?=
 =?utf-8?B?bWZmelBqdlk0bHcvd3Y5M0pXS0dxS21jMGF6Zlg4WHVLVW5XcWZZNU53elpy?=
 =?utf-8?B?ZkJtaDNzYnNYeFBNaEZXc0hCeFdRaFlyUUdXLzZTOGFXQUxIRTRlOW50S0VW?=
 =?utf-8?B?ZTU3ekFERmN3dUxHMlREZG9za2tjOURTamtLUjltQ0lUclVEa2NVUFhQTW93?=
 =?utf-8?B?Ujg2UGJsQlRoQlVCOVNpdlU4T3JXL1hrempWRjVUeU5HczRUNnBqUWZteGFv?=
 =?utf-8?B?SGJsNi9XeWZWTEEvS2tMbXFTZ1drR0pUVENmYjRxbDhmcGJQR0syRm1uWDVC?=
 =?utf-8?B?U0szMlUyd3RRczBIZENqY3JRd1lGNk1pSnkzVURjTHFzOHloSk1UaUZQbDdp?=
 =?utf-8?B?QnJpYXVXa2FDTkRCVFdUYXNVTHJBY1BRbXMxWmlQY09tVUpHTUpyK3hFeDlt?=
 =?utf-8?B?MHhHU1JsdG5lVXp3a3FNWkhQZVkyNWJpalF4NUNPRHRLTE9DRXNFUGY1bDNi?=
 =?utf-8?B?dDU5TFNOS25ObGp1RTNCN2pQb1dqbUhINVh6TXRMZ01lOVpvTXVZV2xQekIv?=
 =?utf-8?B?TGtUcGYwVFhjN1pjYmRsZldoV3JjWVRpcjIxMEprS1pGMGxVRDkrVHlDUFQ4?=
 =?utf-8?B?cUYxTTJrUGNHZjlEa3hsZEhpZGthaVNadEpHMEp0K2VXNm4rUkg5V1ZDTTZ3?=
 =?utf-8?B?b0h6TGN5cnV4WWgwYi9EbDBuZ21ySXNzWWYzM3I3emZSSzdNaEhpWGoxM1Bz?=
 =?utf-8?B?TkhHOGEyNE9xdHExVFBQVVdVeS9BYjZDTkRBbmVaY3JzRjJ0OHJFbnl3KzVD?=
 =?utf-8?B?WXNKMWIwYUxTc29JNGs5VnBQY1l0cjNHeTdORWFOQ2VLVHJ6TkM4MzFlUkgw?=
 =?utf-8?B?ODJ1TFlkUUdNRklQRWRGdlQ5RndPaHlvaFpLNHpERzA0Q2liSFNlUjZKTjJI?=
 =?utf-8?B?N3g3NUxnL3BOZERsT2FJMkFFdForMVR2TlhVR3FHWFpiOVJZWW56L2ZjU040?=
 =?utf-8?B?TGd3cjloZldGbFBrSDhaOUE0bFYybk15SlZzc0lDNklPVDA3WWRzL3RhaVFR?=
 =?utf-8?B?UDlPcExqM2MrcThFbFdNLy9tbkp0SjQvYWFQQStwUFkyb1V1VVVTcklwOUcx?=
 =?utf-8?B?TU9iNUs2KzU4NUFMK1ZqWllyMlhYMWhZZHprdUltaGsxbEgvVW5KYnlLTnRF?=
 =?utf-8?B?OXZaZDNUb0krcEpTQlRTTnNqZmtKSzJhSk1MNXJqTGlRTURyRVBjVEs3a2hX?=
 =?utf-8?Q?6NFs6N4e9nY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cmREQzNtWnI2WklCdy8vemtXem0wQW9NQXRKeW5rZ0ltTC9MbGRIdlhnNisx?=
 =?utf-8?B?OUdiMzJveFpoS2VCaElQa3VBSEhyWFRvUUhtSGRiREQrTTV3d3YxbUFzRVBa?=
 =?utf-8?B?TWlUUDlmODM5OEEwZDY1S0ZuMlFVVGpyRzFwaFErN3RjbnlVUHN2KzV4UnNM?=
 =?utf-8?B?ckptODRuZ1BBTmxReDM0YXI5a2tFMFVsODVpWEFRanZicVF4ZDZCVUxTblgw?=
 =?utf-8?B?R1pwUUVwUmZkQ29jVzVZNzY0RUFIWm5aU21qQ0Fzek9vZWZVdXlXY0NjQXlX?=
 =?utf-8?B?cGxCT0dsdzdhM1ZIbmFaMTNWSTRLcWV3Z3FnN1p0aWswVnp2SkE2SU1BUjVl?=
 =?utf-8?B?dHpsTFZ6YVUvbU9RNldDRGx5ckNQbmlMazZLc09PVGdZb2oycnJOUDNENGFL?=
 =?utf-8?B?cDA0R2VXQ01WTE95Z2Y2amFET3g5ajNKd2hMQ2xXeHhYSDdkMm5laEhxQkN4?=
 =?utf-8?B?SWRFZVVTbVgwUERhT0JQanBKQW1ma1N4OUZ3eldxMS96WHBQN0lJdkpWOVhY?=
 =?utf-8?B?cWN5RkF2VXZOWXFXbFJIa2FvTmYzSGRWZXNGUE9Zc09oN1NndnJJRHBtaEV0?=
 =?utf-8?B?Qk5EU2MwOVFUOE82ckxranRqYmZ4cXJWem9Ecm90VWYxajEvV25aNWx0b1dR?=
 =?utf-8?B?NXdqbG0wZTJ4WTU1VnloMzZDc3NYNlpjUzU1QURSaTYvdmlVNGtOR0N5aUhs?=
 =?utf-8?B?Vzh1blhwd1FvZFJjWG94K05kRUtDQjNFbENnMVJxOVNoOStldmNTS0tlbE5D?=
 =?utf-8?B?WWxtc0FwQ0F6RkxGalRucS9ZQ3grTDZQMEJJdCttZUc1UmpUaXZJeC9md3M4?=
 =?utf-8?B?STFtM2g3cGx6Z2NNVlgzWTY4OWs1Znl4Z2FaNEhYUlB3cDZhdHhIM3cwTm1u?=
 =?utf-8?B?Tk43cGRTTGpORmF3T0tWbVF6NmIreFZodXhxeW95WlArM3d3NUpPKzRNNDg4?=
 =?utf-8?B?YnFWNFUzUUhWRTVWRmZ6Yi9FY3QrM3JxMXQ1WGF1Vmo1RXlwcnpKY0VBTHk3?=
 =?utf-8?B?U3hCZy9GeFAwRGEwVTZJbldtVXI4NTY1QzAwTW0xOVI4TCtoU2NLdWxPeUFZ?=
 =?utf-8?B?VkxnMkp0STl6RHp6cjRjbWoxenNzYVBjbG5xRXhzYmdUbXNBbko5THMzWmRY?=
 =?utf-8?B?aEpiNjhIeHZzMFBEakFvREdPS28rZ1gyc2RTbUErTDZwSFZwNDZLaDFINGd3?=
 =?utf-8?B?Y0hGK010eWdTcTRqRlhwR0NkdXkxUWVqOWxGbkFHYThmaGppOW53NTFsOWEw?=
 =?utf-8?B?czJ2ME5JVUFNTHdZaWlVbkhwSFdlOG9rWjVKWm85ZzBtcDg5cDNFbit0eTF4?=
 =?utf-8?B?T01zZVIrTDlYdytnQTZ6bkxocUwzU2lIWENHbHJ4MmtGZHVDaWE3UlpNTWdr?=
 =?utf-8?B?QzU1UUt2N3M0Q3BUQTl4UVRLVEZqU3BzQjFuR3JXRE41MWNVK1pnd1p2NHRX?=
 =?utf-8?B?bEJkOTNPa1BTak1USEhpeDlETjRvMXNQeldpamtkcUF0VU5EcHlJeFpmc00z?=
 =?utf-8?B?SmNHSDBPTUc0THZUNndKaW54ZS81R2Rhb2ZDbWkwL1lra1FxWXBhdml2bG5V?=
 =?utf-8?B?VWtoVVFTTWpCZC8zWnozVld5S2FnUlBSZUsyNW5PNTcyODAvc3BVWWdKSHRD?=
 =?utf-8?B?aWZhTFhRZWh6N1BmazU5WkliUVdEaHczQ05FaklhUitmNGFTaC81ZUszRjdT?=
 =?utf-8?B?Kyt3d3hIclBDbis2emxtVHB6K0FPU2RsY1FqN1F2RzYwd3JSQVo1MWZZbGxR?=
 =?utf-8?B?ZE5DVUxDbzVOTkMxQTA3ZGU0OXB0c0NxeitvTWFINjRNRWpMeVh4UVpibEJ2?=
 =?utf-8?B?ekorL1Q2OHhsVXFHUmJNTHVXNjBTSGl2NHo4SkJLNS9EQWZTTk9iWk5jd1VS?=
 =?utf-8?B?NCtHK3BGdG52RVUrOEtkWm5IaTdyZzNmRGhGZU80dkF1Sm1HbVA3MFlLWWMw?=
 =?utf-8?B?dkZqaEh5Tk4ySDExYjBnTVV2VFRDbW1DUnpCNlpTUklOMnpiQ3BEbzZjaWpk?=
 =?utf-8?B?aDJkRmJLaTVqUzJWcGpZTFdueTBKaHl5U3M4YmhEQUZHeGh5U0d4dDNEKytM?=
 =?utf-8?B?YnlQU1RlUllWQXNoYVVQTi9Zai9RaGF4dzBpN1QrTmplOWErNnJtVmNHQlRK?=
 =?utf-8?Q?nsCQFaXmHU0l46mo9CMAMqUCT?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	yw9/XBtb8wYGu/QOvN2GbfXclgWqPyaqAQ5k/wFKnWAxdgtOtHln4R7ULvDe0HJHgsxLPEuZA2yLAovqK84GBKvp9H1AuH0CLFrgeZxsb4LxV/GdFOnBkSHVASK988p/3LG88caDIev6vYq1e2lmIun5rqy43x+KjNsiP03AHOk/WlpRi4RFBiangiDSmDxu2++6wuPUuFapeS3M4ZoffSURu8lBAZju+qygqRJrfJ4nMvgKXjLopD5tNEBchmYStYFtkve3a85WdoQqbcu+JABvJxXXJ6DNgKzsnb9wpj0sazO1RpXbj/g98JuzJTMyz4nBW8qzcmS3O15aOXRUKCUv2iIhzzrxYZ+fnfznC6jl0Vlqug+UTdg9ikbNMLcJgwuKzKN6wZw8uS76gbZQd6Weeq5pMbijkcR2yq3QYvdB1wEn8kJzGi7+l/CzsUiEun6Jhw/9TpphSUeso+tvE10Zt98leo9fwBZvZocXfEKwQ369F1bSBPoOtpzC4OSNoLnI6GJVka+WaGyvm68753tsezAqve/FF48qMUijwpmD0p/EEzMjw35t6J1oyeLC5610yaQ0GhODGyjCP+oDJ2T5YFT00TCmEUnezjSuokY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cdfd3796-a8bc-4884-1750-08ddba30ddfa
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2025 12:55:20.5172
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HyBTJADBdVuKTx2xYCU47F54NrMvbrY72iJXiwi7bWyWZ1rPHqdbEFxwHUn3l/DheD5D7zAC0UNsUjhVzHd4FA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR10MB7616
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-03_03,2025-07-02_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 bulkscore=0 malwarescore=0 spamscore=0 phishscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2507030108
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzAzMDEwOCBTYWx0ZWRfXyCt+fJSX/iFL 6hWF+IKDWvtfaULJMBKjgMai0gXMFgSFzXIZzE/qg84MC9X6SXtfuBB5Bb8W3TONaEv7b+5RMc8 ccUoPVLi4cngi5pY6JEPZ2sL7eJCg2EVUiQVEtW6oyvx9f587mVQaJ81BS0ejxpOQJIwLEgzV7d
 tnSi14FRoGZWgpjQVCOLuDG00AVD7HQfGIf4NKiN9+BD+J5yjAn9yostnMJVYQws8Am+0ZF9UZA Xj7y/hhrypIqdmgAB4fnacR3LmphpoKGKONWljaRaP/2BrxvxZxxJZfoxMfKMC4Un/dPLcsf4mO ByaBmNeqcvLRJ2IfpXJEPkUUghBN3VY4ynJKmdNKgh+lOb7mIRyH83Z9T1oAnIdoLXA6y1fQtyI
 BauBlIS1RfQYKHMSvCeF6tg6R0rhQotC1JWwJJ7yIzPk7TtQ/ZQ+i8wuFA+by0Gl2BKwXhRX
X-Authority-Analysis: v=2.4 cv=MvBS63ae c=1 sm=1 tr=0 ts=68667dbc b=1 cx=c_pps a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=5XWUz4BWlF1Jy79zzpsA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 cc=ntf awl=host:12057
X-Proofpoint-ORIG-GUID: TaLtkvUJNi8VPwYZBWR0m4UK3hE6MTUU
X-Proofpoint-GUID: TaLtkvUJNi8VPwYZBWR0m4UK3hE6MTUU

On 7/3/25 3:10 AM, Hannes Reinecke wrote:
> On 7/2/25 22:59, Jakub Kicinski wrote:
>> On Tue,  1 Jul 2025 16:46:57 +0200 Hannes Reinecke wrote:
>>> Add a new netlink parameter 'HANDSHAKE_A_ACCEPT_KEYRING' to provide
>>> the serial number of the keyring to use.
>>
>> I presume you may have some dependent work for other trees?
>> If yes - could you pop this on a branch off an -rc tag so
>> that multiple trees can merge? Or do you want us to ack
>> and route it via different tree directly?
>>
>> Acked-by:  Jakub Kicinski <kuba@kernel.org>
>>
> We are good from the NVMe side; we already set the 'keyring'
> parameter in the handshake arguments, but only found out now
> that we never actually pass this argument over to userspace...
> But maybe the NFS folks have addiional patches queued.
> Chuck?

Currently .keyring is used only with NVMe. I recall that hch has plans
to make the mount.nfs command set .keyring as well. However, nothing is
queued yet, as far as I know.


-- 
Chuck Lever

