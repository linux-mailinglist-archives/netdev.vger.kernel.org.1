Return-Path: <netdev+bounces-197654-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DD8C8AD9848
	for <lists+netdev@lfdr.de>; Sat, 14 Jun 2025 00:37:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C9AE41BC41B6
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 22:37:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 268DD28D8C0;
	Fri, 13 Jun 2025 22:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cern.ch header.i=@cern.ch header.b="FBr4v7bu";
	dkim=pass (1024-bit key) header.d=cern.ch header.i=@cern.ch header.b="FBr4v7bu"
X-Original-To: netdev@vger.kernel.org
Received: from ZR1P278CU001.outbound.protection.outlook.com (mail-switzerlandnorthazon11022075.outbound.protection.outlook.com [40.107.168.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B06AD23814C;
	Fri, 13 Jun 2025 22:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.168.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749854244; cv=fail; b=f0xZchZJ1pM3PriRJUj0CA7hC53GZO8okmHWGrlfNyr3vmXBy0ZSDNLleisdJ3yNiK/13oSiYCqIQhtPAWc78vJgoyxJdSbcT03fJNvBU5rYeOtJBO1JVQ2QPPlPxKRCF04muZwxXibPiZvCVkdGuZMUQD6FhBobTznPGbVXExU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749854244; c=relaxed/simple;
	bh=krNfD5+0FFxWTjiDjKSBgkSztqNBpVbxIW1K4epZsdU=;
	h=Message-ID:Date:Cc:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=l4N9nGJH3CwdI9+pPqFhxVnLmBH9qpnbwLVrlZI93YUVfZnTe54MFaRroQHo/jis81kUcblDqxZ4i/oLUd1wQjJIoxbQGcYzsi3sraw72Wgdykn37c1UTKuI8oHcCp1Ix9fE4pLZo55G+Mr0/byuqEkFI/w9K3ZWGHcWdsNgulA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cern.ch; spf=pass smtp.mailfrom=cern.ch; dkim=pass (1024-bit key) header.d=cern.ch header.i=@cern.ch header.b=FBr4v7bu; dkim=pass (1024-bit key) header.d=cern.ch header.i=@cern.ch header.b=FBr4v7bu; arc=fail smtp.client-ip=40.107.168.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cern.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cern.ch
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ltAEHNSa6XcFCOr1ghhV5CODdeUmik/stHKC4OE05xmylCaFnqrkucqSYmHq0meastKajA2wYv+GuYPddZ3y5wyWdJl+3YfeJ+h1jK+ypqvWQ6MFEYM4tDHRDtRwnb1ZmxbC9KUIoELMVEmNEWuxh1yZVcKyDNCchKtbIpjI41LZS+qdX5U2HZGRnO2nsbHaEuJK8ddSMjZqY3OXoQhTqD/IELd7vhvauV9XyLoPyay+gWxU8Hw3DTKNj6HHFPEmAF0SXnX61jGCwf/o+cD1sDB2T8mkqQ6uRp9d6kxdVML+DBYVOZzXCBjV4Mx7yEhtFpDy8WN69uYQg77jEhwI+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3Z3aNk1xr12pOXy1C12NrwzIgjcvgy11wyH0F3/ujP4=;
 b=cHEahUKg7ZoN9hkbaCnYqSoR1tlJsa3S8jAbxbC2hDUgyAR2WIfxxmT8A1cxHfBamHUNZY02Knq8cJAGMoB6gZy5N157vLlVZqs6DnmDE6WFIjoGS4Plcr0ou9THo9wOMCCkbqWgEf2V1m+hc1WSXIk6saj7SjsE7Zj075A2eks9zPNVxR9Ekk6MxiGQEKVAt+0n+NX0QKaGHuEIu/sq12l/uSK49BD3M434llnMxunLFKKdzym/3Gn/Djia0BqQyMw5OtqGFn0KuOt5b74IQ6oULLUhpHO0301AjYP33O2XlF+yMBQg7OjZKrHlgvZG6DtarhM8XhXYjrbRNOc+kQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 51.103.219.121) smtp.rcpttodomain=davemloft.net smtp.mailfrom=cern.ch;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=cern.ch;
 dkim=pass (signature was verified) header.d=cern.ch; arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cern.ch; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Z3aNk1xr12pOXy1C12NrwzIgjcvgy11wyH0F3/ujP4=;
 b=FBr4v7bul3wZiV7YMgxjxa3xTbQhrHPCJDpwm8xjwkxazfOYqUJhGpLwIfoGJdF/Q8kgosiymx1oCmC3nOMyJExEpJ4fb+BTmKthEjl/D4fx1IrMizptMS+dEM0paChGwd9WAYPyJUJwaytvP4uK7Et6l0Fh0yBO5k+6ME0r6PY=
Received: from PR0P264CA0214.FRAP264.PROD.OUTLOOK.COM (2603:10a6:100:1f::34)
 by GV0P278MB1767.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:70::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.23; Fri, 13 Jun
 2025 22:37:18 +0000
Received: from AMS0EPF000001B0.eurprd05.prod.outlook.com
 (2603:10a6:100:1f:cafe::e6) by PR0P264CA0214.outlook.office365.com
 (2603:10a6:100:1f::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.19 via Frontend Transport; Fri,
 13 Jun 2025 22:37:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 51.103.219.121)
 smtp.mailfrom=cern.ch; dkim=pass (signature was verified)
 header.d=cern.ch;dmarc=pass action=none header.from=cern.ch;
Received-SPF: Pass (protection.outlook.com: domain of cern.ch designates
 51.103.219.121 as permitted sender) receiver=protection.outlook.com;
 client-ip=51.103.219.121; helo=mx1.crn.activeguard.cloud; pr=C
Received: from mx1.crn.activeguard.cloud (51.103.219.121) by
 AMS0EPF000001B0.mail.protection.outlook.com (10.167.16.164) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.15
 via Frontend Transport; Fri, 13 Jun 2025 22:37:16 +0000
Authentication-Results-Original: auth.opendkim.xorlab.com;	dkim=pass (1024-bit
 key; unprotected) header.d=cern.ch header.i=@cern.ch header.a=rsa-sha256
 header.s=selector1 header.b=FBr4v7bu
Received: from GVAP278CU002.outbound.protection.outlook.com (mail-switzerlandwestazlp17010002.outbound.protection.outlook.com [40.93.86.2])
	by mx1.crn.activeguard.cloud (Postfix) with ESMTPS id 388D7FC37B;
	Sat, 14 Jun 2025 00:37:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cern.ch; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Z3aNk1xr12pOXy1C12NrwzIgjcvgy11wyH0F3/ujP4=;
 b=FBr4v7bul3wZiV7YMgxjxa3xTbQhrHPCJDpwm8xjwkxazfOYqUJhGpLwIfoGJdF/Q8kgosiymx1oCmC3nOMyJExEpJ4fb+BTmKthEjl/D4fx1IrMizptMS+dEM0paChGwd9WAYPyJUJwaytvP4uK7Et6l0Fh0yBO5k+6ME0r6PY=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cern.ch;
Received: from GVAP278MB0470.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:37::7) by
 GV0P278MB1617.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:66::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.26; Fri, 13 Jun 2025 22:37:15 +0000
Received: from GVAP278MB0470.CHEP278.PROD.OUTLOOK.COM
 ([fe80::a1a4:4bf:9fd5:2598]) by GVAP278MB0470.CHEP278.PROD.OUTLOOK.COM
 ([fe80::a1a4:4bf:9fd5:2598%4]) with mapi id 15.20.8835.026; Fri, 13 Jun 2025
 22:37:09 +0000
Message-ID: <25d73457-cfb7-4e65-bb19-a3a826790f32@cern.ch>
Date: Sat, 14 Jun 2025 00:37:07 +0200
User-Agent: Mozilla Thunderbird
Cc: petr.zejdl@cern.ch, "David S. Miller" <davem@davemloft.net>,
 David Ahern <dsahern@kernel.org>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: ipv4: ipconfig: Support RFC 4361/3315 DHCP client ID
 in hex format
To: Jakub Kicinski <kuba@kernel.org>
References: <20250610143504.731114-1-petr.zejdl@cern.ch>
 <20250612191726.2a226cdf@kernel.org>
Content-Language: en-GB
From: Petr Zejdl <petr.zejdl@cern.ch>
In-Reply-To: <20250612191726.2a226cdf@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MRXP264CA0037.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:500:14::25) To GVAP278MB0470.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:710:37::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	GVAP278MB0470:EE_|GV0P278MB1617:EE_|AMS0EPF000001B0:EE_|GV0P278MB1767:EE_
X-MS-Office365-Filtering-Correlation-Id: 8239a936-a66c-40d8-2429-08ddaacad9ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?V2E0b3ZKbmZGSTg4bDZpd05OVkw2NEtiUnJLc1ZlRVBnTWVmK3JYWlNYa2tH?=
 =?utf-8?B?cmNqcTdQenp6OFFvMEJHOWZxbzNVc3psdmFPNVk3VEVzeEdRL3JpMUx3ei95?=
 =?utf-8?B?MFFodFY0TnpwMGJPZmtpS1pHOXZGNHd6Q0Nsc05LWVpKYTNwQjQzQk5Jenhq?=
 =?utf-8?B?aE1iQUl6YXNrQXNvM2NQc2hEbFZnNkJMTGtxTGVxZGJrL0tNVHNXNWsrd2lQ?=
 =?utf-8?B?MlpOcW11VTNQTzdSdkxKd3l0QVV5NUVZQU5ld0NZVVVrYWRwSjg1RGZ1QjZv?=
 =?utf-8?B?ZEZDNnllYWdjUzRJNmhUY2VpOW5jelNUWXhxbXNSQ0xqZC9kTlBON3hvUGFZ?=
 =?utf-8?B?YWRZc0ZsdWZGUFJIM3ppdGE5dUNHMUIwT1Y4cktrY0JTbWlVVDBtamE3Qkd6?=
 =?utf-8?B?MmVEdFZaQ0hQdCs2NlQyaVJiK0dVVXY3KzJXRHkvQVRhRmQ2MjQ2U2JlNTRE?=
 =?utf-8?B?VUQzVG12K2l0OUtHejdva2t2Q0ZwRzhIanVOV1JmZkhmSGRsQ1JkMkwrNjBO?=
 =?utf-8?B?UWxtSHhqclVYc3RxMzd1T2o2VEhneFNjQjQ3Mko3eHNsa1BwN3lLeEpDVE4w?=
 =?utf-8?B?WUszRGI4NDN1QlViWkVDSnlsNnRIY1U3RDRoUE9ocXU1VXlyekxFVEsybTJN?=
 =?utf-8?B?ZDFlSkIvMEF0UmZWQXRWNFk1LzlTUzhwUkNEYkNTaEd4RVVMdG8zRnYxMGEz?=
 =?utf-8?B?a0tpOTNqUVRPKzNmL1pnUEhWeml6clhFb3JWajNhWSs5bUhMZUk4eE9UZitj?=
 =?utf-8?B?dWxsU0ZTV0hONzRVN25IcEh5YzFqQjNKSlZRQWZiU3NlSXpweXBFdmpjbUFK?=
 =?utf-8?B?WXA2cjJIejZDcG5VT0JoeSs0TXpoV0FnMWVTOUpHSVRkaEt2bmhJNlZzL09L?=
 =?utf-8?B?RDEwU1RBZ1VKeDQ3Z1NDd3UvNEhVaFliTjdCZDVnV3lZSlRJL0k2TjJmRjlD?=
 =?utf-8?B?NzBnUzljTTQ0aHp1Wk9WeXA3Qk16V3htaS9qOVJCZjdWSWtVU2FLdlA3NEk4?=
 =?utf-8?B?OFVMdWhFMFN5cHFEL3FWVEphYlV5N1VtYmp4c1dIWXBnUXc1Y2RRWDBQaklD?=
 =?utf-8?B?RTdKbEp6RS9oU0tBTlA5MDRJMVIram1rZHF4aXk2bHdCZEpYSmczQWtzZk1r?=
 =?utf-8?B?VnpFTndNbWdqYllSWGZaZjE0OEV0OTY0NXBPa3FjWGJWVzREUENTeUtOV3Q1?=
 =?utf-8?B?bnJBZHl2WHRjZ2JGbFdmU0hZcmRCUC9SWldiYkU1bEhLelI1Tk41RFF3UU1P?=
 =?utf-8?B?OGg0cEhEUGJMejJzdnZ3aXNRM0s1T2lzMlE4TWlsSTJ1dzRTRWdVclZNaVJH?=
 =?utf-8?B?RENzUVhhOC9PVEtjSzJCU1RCZ3BkWW10NVFPMHVaVkF5Mm1XTzdKMDI3Znpm?=
 =?utf-8?B?NFkzemlPbXZtWlRvNWZreFFnRTBBNTdvaHZocnFZaGNFWGp6eWxzODRHRlNz?=
 =?utf-8?B?Rkxnb0tEdHQvd2pzMU1uYjJnbys4elF4N0dBS0xrM1NJbW5sZGhUYTR1YWVq?=
 =?utf-8?B?eGF2MU9kRUdRazR5SHo3MExHU2pQeUF6eDhDVWtDVWNRdVhac3lqdWQzZFVV?=
 =?utf-8?B?a0pkUmlpTnRIYWc5U01CNEo2TFpoNVlsYWdsR0U2c0xmUjJxSUJ4QlRvWkdh?=
 =?utf-8?B?SmZKK2F0Yy9NNGhqSVBJNmptRFV5a0VZNis1VXRHNVFSczN4bFlqZVFTV2d5?=
 =?utf-8?B?enVMR2VSZ2MydlB0cFBTbm9pb0d2OVRtT3pvbFJ5YVJCYXVDdVFvSk13ai9v?=
 =?utf-8?B?UlhEekVPRytxdHFFc0t0NGNwWW5jeTFDazJYdDVNaXNpcmNJeUowREJEeklC?=
 =?utf-8?B?SU5LbFNxOTBwN3F2cXEwMEdCVm81ek4xTGdLM0VwUFB0V0w2cXRmZ0VmcjVw?=
 =?utf-8?B?SGtJSkJ4NUsrY1FKSTBtaitwcEM1dFMyZ01BTWYwSE14d1lIL1hBVjBkWXdh?=
 =?utf-8?Q?Sax3RVBTHLE=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GVAP278MB0470.CHEP278.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV0P278MB1617
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AMS0EPF000001B0.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	543ef5ba-62a0-4839-09eb-08ddaacad4ea
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|14060799003|36860700013|82310400026|1800799024|376014|35042699022;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SGtRRzd2K1pUVHJSTEVjK2daTzNKU3o2RUs3K3RtSUM4NFJ0ZXEvbStKUm1o?=
 =?utf-8?B?MDgyUmNjMHpjVHZ4MFBHY3lJbEd2d1ZBeEVSMEJxNEdiRkU0YlM0MnBoOCt1?=
 =?utf-8?B?dGZMVUt2WFUzeHpoUUtxVWxVQ1RwYTA4dXFicnFZV0pwL1dmaStoMG5yeXNk?=
 =?utf-8?B?VUhLcy9RcmQyUTU2UFlqT1dDeDJWbXFITHBjOUl5cjNvNnVQK0REaFV5dWxE?=
 =?utf-8?B?aVAyVzFRbTNPc0dpYVh5WnlJL3V4OFd5b09XZ0J5NlNGNTd2U1JacEUvQ05y?=
 =?utf-8?B?UUZEdng5SzVQRUppUmVEV1hRVVFsaUJUK0lzYXNkS2VKRDlsZmFMb2pydnRj?=
 =?utf-8?B?Wk5ObjVnaWlrQTFtL05yRHYrQ1dwMnhOTjVwYm5LV2hxMVNGZXBJN2RsMjll?=
 =?utf-8?B?YUhPUzRwZ0hnK3RBeHF6N1dzVFhrTytxRW9TN1MxNUZFb0UyYjc4d0xJb1Nl?=
 =?utf-8?B?TXB4WkI3UlhoZDY4MlZub3IrbzBFUE1CUHNRb3FVanQ5THltSjhiVmNINlB2?=
 =?utf-8?B?d2tXamEySTB6Sjgwb24vOVVES1hEOGo4WThLek5iUE05SG0yNGFGL3p4YzJj?=
 =?utf-8?B?S05FMC9ySGhsSHJTWUlENEpieHBVWEViTDM1ZHhIbFNNZS9kL0JDRDRrc2h3?=
 =?utf-8?B?dE0wdU9tUGRYSmNtZDVWMDd0aTJEb25jMnZSRW9WNXhINHpaamtISU50TFQv?=
 =?utf-8?B?cGpQNEUyRlBYOGM0UVdndE4rNEh0KzYzSFEzekdtRDFyV1RQNnZjUGRlMy9i?=
 =?utf-8?B?VEppMDR3aHlTUEVlWEZQem4xVHhkWmtsMFhuNWs3U3ZURGhZcjJKWGt3a2hv?=
 =?utf-8?B?czgxcHNqdmpaQytkTlNqM0h0M3FVSXNlaTg4MnZTRFNZLzZqZWZrUzZ0ZEJE?=
 =?utf-8?B?ZHhjU01GVkJBQkI2Ukh5OEx2akh6cUdpbHoxUTUwUGV5V2FkNkNGYU9WV2Js?=
 =?utf-8?B?RllOOHRNbTc5TmN3Ymtyb2htTVB6QnFJMk1HRHZDM1NseWFwRVF4cGNTeGFi?=
 =?utf-8?B?SU1vVUgxVXR1aUY1dklEOGFQamFuMDFUSitWUnJSR3pWTmVyVzZnRkFzSUhY?=
 =?utf-8?B?a2dVT29pbE1mR2xDelMzalQ1enVPQXdOZWgvby80QmZsTE1MNlQ5UndTaGd2?=
 =?utf-8?B?dE85VmkzdEhJNU1xNzR2NFdIbEttdG83aE9hNFNNaWtFemN1bEE4SEVkR2kr?=
 =?utf-8?B?bzV2Ykg0Yzc2bmZhWTJQL0I4S1lBVkZWMjYxdHE5eUlNWFZnc1h2K0xjeTNM?=
 =?utf-8?B?WjVnbnJ1TWhtUklsak0ycnFUMytlS3k0amdhY21WWmFoYUJ5b0lGV3RCZy9O?=
 =?utf-8?B?UkhRbGo3TS9qdXMvTFhxdnU4WEFMRHFDWk9abDdJODliR3UrL2J4NE5YT3ZH?=
 =?utf-8?B?RURGeHpvc0h3TFpzQldLZmZlWGdwLy9hZXJnNGNJNVZoTklDMmhvS2QyK3dl?=
 =?utf-8?B?blU2YzY2Q0lacUxDWUNoQmMrZ1ZFSFU1R2plY0l3NTM1djFpTU5zM0JLQXlW?=
 =?utf-8?B?cGNzaWtpWjFVUnl3c1hRWU5NS2N1M1lxWldxc2IyWWFBMmt2SzlkSnVhVkQ5?=
 =?utf-8?B?ZHNZeVVTNk9UVkV1alhLMllQRVpsMGhOVC8rSTNCdW41ZVJhaTNiSnhBQncx?=
 =?utf-8?B?T3NYbDZqdjJaM1hrZHFydy9lR2pJQ1picklxOGwvNnZjaTREWDdhRHBJZjIw?=
 =?utf-8?B?VWhvUytXNE15NnEyeHVrV3JadmJpQWczU09vb0kyVnpSZHVHbzl2bjBQcExQ?=
 =?utf-8?B?a2NXY0EwNS9zMENkZ0hjenBZbWJxeldoLzJURk45OVpLSFhyZjVUVzBaTnlt?=
 =?utf-8?B?Wkc4NVRvN3JHZGhwa0Mrd2QvWFVSNi8rRHViUjdKQUFmYnlDc0xLY2lONTN4?=
 =?utf-8?B?S0NHVDJLVVFVTk5PQVpHazk3OGhnREoxV1M2czNOK0hkTmRKMUNBKzR0Tk1y?=
 =?utf-8?B?YjBTaG11MFJoRUtZVDVCSDF6WlM5RkhQVlgzQkVTY2cxMnptNlEzOUU1SXJp?=
 =?utf-8?B?THRmZnRRaDFqeXIzQmZEQzN4aTRMOWlQOWUzQWJIRklEaXVpT2RQakc1cHhi?=
 =?utf-8?Q?8eENFx?=
X-Forefront-Antispam-Report:
	CIP:51.103.219.121;CTRY:CH;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mx1.crn.activeguard.cloud;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(14060799003)(36860700013)(82310400026)(1800799024)(376014)(35042699022);DIR:OUT;SFP:1102;
X-OriginatorOrg: cern.ch
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2025 22:37:16.7768
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8239a936-a66c-40d8-2429-08ddaacad9ad
X-MS-Exchange-CrossTenant-Id: c80d3499-4a40-4a8c-986e-abce017d6b19
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c80d3499-4a40-4a8c-986e-abce017d6b19;Ip=[51.103.219.121];Helo=[mx1.crn.activeguard.cloud]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF000001B0.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV0P278MB1767

I'm sorry, now in the correct format.

On 13.06.2025 4:17, Jakub Kicinski wrote:
> On Tue, 10 Jun 2025 16:35:03 +0200 Petr Zejdl wrote:
>> -		len = strlen(dhcp_client_identifier + 1);
> maybe keep using len here? Assign dhcp_client_identifier_len to it?
> I don't think switching to dhcp_client_identifier_len improves the
> readability and it inflates the diff.

Indeed.

>> +/*
>> + *  Parses DHCP Client ID in the hex form "XX:XX ... :XX" (like MAC address).
>> + *  Returns the length (min 2, max 253) or -EINVAL on parsing error.
>> + */
>> +static int __init parse_client_id(const char *s, u8 *buf)
>> ...
> Feels like this helper should live in lib/net_utils.c or lib/hexdump.c
> as a generic thing?

Sounds good, will come with a new version.

I should also update 'Documentation/admin-guide/nfs/nfsroot.rst' with
the new Client ID format.

Thank you for the review.

Best regards,
Petr


