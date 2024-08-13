Return-Path: <netdev+bounces-118167-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DCE87950D22
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 21:29:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 608F21F216DF
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 19:29:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A06D91A4F13;
	Tue, 13 Aug 2024 19:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="c2xW6Wuc";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="qUThE/fn"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99CBA22F11
	for <netdev@vger.kernel.org>; Tue, 13 Aug 2024 19:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723577359; cv=fail; b=bj/vzL/Jk0zQrcw5P+5Cg4qZawgP5EGt44zcanHXo0EjWpFUtJw0vZYVQDY40qF2O+ZfH6oMmslWmj2XfzyzmrqjQ1rPZg+W6EGpwBtajn7Sawnm3TkkTg5hy1ct1MIj2eYs0iehhna53hiRbu+twNq/s/KT1DKTmUmRZ6W6yjk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723577359; c=relaxed/simple;
	bh=0M0vHqhFyUBXPT/upFzCsKE4nljWd33mtTiRCo1zb54=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=d3UCgrcJ3EXxSUO+jP/y3ZcXeNvLnxfUBqZtakdgAebBmvqMg2/Q4OuNRlZa/u4TCY5VYpUwF0689geE+PP1JPAyjbnGvw/PuJY8rM2oF71Ns1hQFoqzTY1bI2LNcjgooK2h0RrZ6glq1l3D0Kj97iD7j/ROj1vNlsw7gG0S+YU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=c2xW6Wuc; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=qUThE/fn; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47DJBVVo022968;
	Tue, 13 Aug 2024 19:29:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=T5vcxD6Omt4t3YpkxZH3vGcdU8IEO0l0L2J7Vet5wJg=; b=
	c2xW6WucRdOD6AMO2aPKy+VSiHYS4TGMHCatcGC76HaVeBkwLb70xjc9eZ60cfSU
	N81jg7vD0wqQ3Ew06Oyv/xoIanDS5z9Et0+pTwSuoPfr7xOKp4VVu54uCj6DhL5e
	TVucu/dGFrPKIiv98vCvTvrg3XkrqSTB/U4Zep+9fzQQwEsBhVFGxvzvsuZz2zdc
	G26J8KOEwolm/rlTIRhskhA1h2bApqbgG43TjTagqFkzg86+JUOQLFUtKiRKYtwr
	CUuuSjhDhKklNzeULN3M04ktTXMmaKyQ48Cif+FvbNFLxKAuH4du2yF7CLO9p7Ah
	65Ie1aQ6BAwtfbbMdnw/1A==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40x0396p15-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Aug 2024 19:29:03 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 47DIPjUE003637;
	Tue, 13 Aug 2024 19:29:03 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2047.outbound.protection.outlook.com [104.47.74.47])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 40wxn8wfd3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Aug 2024 19:29:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JjwvmPP2qEPMFLyfAO1KmpVwbV4Sxc8nG2xjnliIb5RINuON95DSGrimN4vu3V+09nsEfo2oZuiy6sCWDIVzD2pPoUSRc2Md0/LXjoGXdVYFFry03elI8Ill+eHm7I522MbcbuPFTmTR6LuSfVaJyrlY5dOK7YmdHC5tAnK7gerByyGrfois7eumoVZaUGNGeQh8hpaj7Bwhlyw1uo+On9t/FsD1Nwzb8Ir4KkT956e+web3RRPgzxQgUfeCDX0a0OckLlo72TmMHRhwqvHIqHKx8ZVhUf1zUrQt8Jhkw4Nx3HipvD8k6q+OJPV0IJprTBb4qiahBm9BPphrIsEmzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T5vcxD6Omt4t3YpkxZH3vGcdU8IEO0l0L2J7Vet5wJg=;
 b=o9DsLTJT0SFXlQcLHVpHOsgbXjy5QP58v7FAG1a23xmNQRyhgTijfubel4UtbzC8OVgEoWKA2MjvO03j06qmbDtilu/zXuRbU7UR9D8AJeQQ3GKQpzXNukQtzSXVaxO/SH5lP0gz38PW3QgVqxhcaUJ8uJqdFblKZsb+KetTv6qDJZGZlNMt96+GF3M9j18nMszMfyAGp4XWNVPgXuxFBhN0HxmClS1qOglF9q9hcZbxczuJ0CqqB3Y4zGmdCb1Sr9qb482oL8JujZA3Y7MRiQxc7R9oGlRzg3CUoHsl5pnzmIkAqjOjykfOyY9jfKiIoBqDzHsKCEihqWDErreMmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T5vcxD6Omt4t3YpkxZH3vGcdU8IEO0l0L2J7Vet5wJg=;
 b=qUThE/fnTapOnu+CT7BXbbSZoSXHy4tQCO1Qk9rwSZh5GjLy5mSvhcGvmzQWiIA1Avfn6RbVECHAkkUC0sfWwW6aDWaIa/0OhReUBEVP1lGz5ev0xENpI+BEvqo0vu/FBflGSRhXdkqDRVR9dpLQiPrqK9acd2UqbubZAk1lB2E=
Received: from MW4PR10MB6535.namprd10.prod.outlook.com (2603:10b6:303:225::12)
 by PH0PR10MB4791.namprd10.prod.outlook.com (2603:10b6:510:3a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.15; Tue, 13 Aug
 2024 19:28:49 +0000
Received: from MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::424f:6ee5:6be8:fe86]) by MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::424f:6ee5:6be8:fe86%3]) with mapi id 15.20.7875.016; Tue, 13 Aug 2024
 19:28:49 +0000
Message-ID: <8b20cc28-45a9-4643-8e87-ba164a540c0a@oracle.com>
Date: Tue, 13 Aug 2024 12:28:41 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5 1/4] virtio_ring: enable premapped mode
 whatever use_dma_api
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, netdev@vger.kernel.org,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>, Jakub Kicinski <kuba@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
        virtualization@lists.linux.dev, Darren Kenny <darren.kenny@oracle.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>
References: <20240511031404.30903-1-xuanzhuo@linux.alibaba.com>
 <20240511031404.30903-2-xuanzhuo@linux.alibaba.com>
Content-Language: en-US
From: Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20240511031404.30903-2-xuanzhuo@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P265CA0155.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c7::7) To MW4PR10MB6535.namprd10.prod.outlook.com
 (2603:10b6:303:225::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR10MB6535:EE_|PH0PR10MB4791:EE_
X-MS-Office365-Filtering-Correlation-Id: d01df24e-c328-46e1-2c8b-08dcbbce2835
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UVdickRQbk91emlIM0pBZjZKSnFETHRWTXFsMEN3UVVKK2VoRHVlb2FQNFpq?=
 =?utf-8?B?T1kyTm9lcjJVS0dmY0dpN0dFQWU3ZkF4N0EyczhVVlh0T1JYQ2xyT1YrRjBy?=
 =?utf-8?B?aWhvTnFFaGwwUzE5VDQrTnNTbklsVWRCRzRDZVRPUDBUOWJSY1JKUnJoZHoz?=
 =?utf-8?B?c29YZXpmQ2lRbGlaejNQTXlYN1NwblRhOHVHdER5bFgrZTFZc1dXL1VDcERP?=
 =?utf-8?B?MlZpb2ZTaTJ2bEVBWTUySHZWQ1pJL3BSK01yY1dZSEQ5bnEwQVJoQlREcVRI?=
 =?utf-8?B?Q1BvNFAxTjNQMFg5K2lNOTNtOFcydmNYVHI5b20vOUd1YTJLQlFWYVRiTEpn?=
 =?utf-8?B?WkdNc1BXYVZ0WkJ2M3lZM3NjTnYrRjZQUkYwUGJVMUtiRCt4K0dGeWtNeUo5?=
 =?utf-8?B?N3VYQU9oMmI4ZVBaRVlvaER6OEoyeEZCL0Z4b2E4UHAza05GdFp2YUI4bk9U?=
 =?utf-8?B?SUpiSEl0YzhkUjlyYndya1RkZzhyaWl2MFFHeTFXZU1GMTBHeEY2MnNiS0VR?=
 =?utf-8?B?M3Zub1J2R1hONFhWQjZWemkrTDlmV2cwREdaQUN5ZVduQ29IZ0kvY0daM3A2?=
 =?utf-8?B?ektSOHUxN3JEaGd5OUxnTnZtWHhxM29GdTB2eHI5RnlaNzFwVzAxbi9DU2Nz?=
 =?utf-8?B?ck1YUW5xMDJFSXR0eGFnSlgvbHRmVGN1YTZLdS9xZ1QrNHNqd0tnb1JVbWt1?=
 =?utf-8?B?WDQvUUVqbUZOeDVFdHl6bE1vMW55L01oYng0YVBveCtrRW9VTUV2YnZWTmF5?=
 =?utf-8?B?QnZKQ01Ya1hoUWZ0WEJramxYSEZ0Ykg1YUFwWHNzdTBrYnBuR3VhL2E5c0dp?=
 =?utf-8?B?KzU2ZkNGY0tOeHpTYWNtMXRqbEROdDBRVUptWU4rZkE3K0dYYVdxOTkrUURB?=
 =?utf-8?B?Zm8wRlhPQS9ITlpLVWo2ZEpmVzhhWlVvUU1CUmI1VmNCb3BnQlZqTTMzTnpO?=
 =?utf-8?B?UDFLV1hkK2thQWpoN2FNeXVCVUdkK1dNcVJiR0tvVG45U3MyUzJhbnpOeFFn?=
 =?utf-8?B?TmNlUVpNZm5DZUFLQXBORjJrcnRBaUkxcUJmUnFFTHgwWXI4YXBDQ1BRMEVJ?=
 =?utf-8?B?NWN2SE02ZkVwSVgrRjNHZngzQ0oxOEE5ZkFxZ1A4bWFhNjgyNHgxRzNKWGh5?=
 =?utf-8?B?T255ZW5MKzdMOXFiMnBsR2N0N3BhTkFyOGNQbWpHUW5hRWF5REFzalhZZGxl?=
 =?utf-8?B?SzJIQ2V5bFE1RHVSU3Yrc3o1L3V5c0hsc2tuZ3BPb0RrVWViQ3NDOW9iTjdF?=
 =?utf-8?B?VjVXY29IMTEwRlV6MTNWblo4ZmdRQ0diOTB3ZGxuZXFCaXpHby9qaGFnSjln?=
 =?utf-8?B?NDhwdjZwNlAwM2tSYkRJN3JRTHVjSHdNOXJSb01TZHNleHRGS1pSUkhVWXN1?=
 =?utf-8?B?NStlQ0NuTEdxYVNxdjloY1NqeTJ4eE05QWhmN2J1YUhrTG9MYWdIdmdMQ05x?=
 =?utf-8?B?RkJPUkgxZUhkTGIzODdkQkZ0aGxONzlsbmdXcEpBZFI4ME9BMnRMQmF2OVhH?=
 =?utf-8?B?c1hsMVVYd0VPRDM5SkRGWTFycW5lQlZaNER4aXBlaUlscUJlR096V3JlL093?=
 =?utf-8?B?U2g5VEJnMnF6Z3NUSDRIVW9IUFJnQnhZTW9jSnhUSTVvdFd0c3p6VXN6UFA4?=
 =?utf-8?B?ZDN5Y2xFdXNkWUNHTDAxTnhkdER2US9QdEZzbnpNa0FnSU94ZVZlTWFwKy9U?=
 =?utf-8?B?QzIvT0tQMkRCbFgvYTlEcGF6ZVB6Yk93R1pjcXdYUk9XT0JtbHQrU04rVXBM?=
 =?utf-8?B?UFIxU0svRFk0czB3S1hJaEVHbElmM213MVJxQ3JzckF0MDNZbDRwd3l6Wm8w?=
 =?utf-8?B?a292Qm5hVEx1cWFRRnRHUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR10MB6535.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TVFsTHdjdTZLMGRpczFOQWlybGhocmpMOVhBbHI3K3NmRVRyS0dQNzVCS3Ry?=
 =?utf-8?B?WVZ1TERickJISm1iZjBWMVFPNE9wNmxIdFg3NGphajBOUkZ0cWk3N1pNdUxo?=
 =?utf-8?B?cGVleWZxaWU1dUxVMnNnd3ZJUEFNMWVxM1ZLL2JScFRHbkU5eW1ZUXpMdTZI?=
 =?utf-8?B?RHNKcTh3V2FqNjZWT1JDZ01CN2ZTeXMzSTdSS2F2cU5JNlNCYlF6emZMWjBj?=
 =?utf-8?B?UWdJc1Q2ckZwdUppUkpWem1ZcnRVUSt1UFFCVkxpRGdZMUJxV2E5bGhiekhC?=
 =?utf-8?B?UG1NOERjQUxEUVp1eUhaRk1GMndtSU5RaTBVdWh6Q0M0Sm4yR2NtNlU2Lzgz?=
 =?utf-8?B?eGI1U1U1WUxQdGVQcGgvWEpOakRXY3RIcHhaRnI3T0JPRkI4SUR0VVRMYkRs?=
 =?utf-8?B?OVkycDhaRVZTSTd5bWN2ZzYrNE0vajdpeE16OXRidXdFck1iWk93dE1Qbk4z?=
 =?utf-8?B?RE1XQUNSZWxIakl4R0F6M2IrUDZSSUpZbk9tSVRXYzZRV1JXTjQrMS80U2lK?=
 =?utf-8?B?MCs5eEE5UEs3N283cmIvVkNwb2IxRUw4bTUrell5b2x1WTVQUkxmTDNBQUdE?=
 =?utf-8?B?R2o5QjloZCtWdzVHRU1tZHgzUmlkTFdRZE83SDFTNVdsWlArVXVaM1JCa2FO?=
 =?utf-8?B?aVBJWUdGaGdwQXdVMGZYVE82M1NlUnVRSHZmYTQ2U3RFdXhwNEcwd0djSWhQ?=
 =?utf-8?B?S1RkNjhSSlNKT2s0TDU2OUxIL2MxOWs3ajEyU0NQdWIvbWE4Z2FUUjVTVXUz?=
 =?utf-8?B?R2cxUmg4ZkFYcldoUHZWQVp5Z3VWdS8rRURNWDVpUFlJdmRVMzR0Q2U0UEdK?=
 =?utf-8?B?NDl6NTd3RjBvalA0d0lvRitxVWNsTnZhemtES1VuM0N6OHNSMnp4UVFhSlBL?=
 =?utf-8?B?d1dOeU1pMm9pbzV4b0tMbk1uVHlKdmdHYlJjbDZrTzltS0xPWmJUem9OTXFp?=
 =?utf-8?B?MHVGdkYxc0Jlc0t0VnpzUHoyUmhvMTJJVmxkODFPdTdYMEJDeXQ1alB5N0N4?=
 =?utf-8?B?Ry83T2trTFczenllNXNTbzZVWVRHUWJMSy9LNngwQ05YcUFzeUlxcEFldVRz?=
 =?utf-8?B?MHdOR0hkb1hOVnRWelFFeHRRNjJQUjUyRVV4dnpFblBFWkQrTnptR2RISUNQ?=
 =?utf-8?B?Q3hBQ29OSW4xcG92MjdoL21SNlVBV2Fkd01jQjhOV3c4NTM1U1FySHp6djk5?=
 =?utf-8?B?aUpiTWJoMEdVWWZaQnd1SVBCZmduNk9jT2N3YkJtd0svWnVhMHBmZ0o1bWlv?=
 =?utf-8?B?b25sMG9ZcHZqcXdVWE84OTRCYnROdUcrcjJraXk3TEM1OG5XYkdHK3ZWdzhS?=
 =?utf-8?B?YUVxTEpGKzBvYzAxSWZJb2VGNTRDTlFjOG5MdmxlTHdpcHdCbWlrMmpjTHdv?=
 =?utf-8?B?QzlYRjJtZ211Ym1iTUdVejMyREtBVDBmYWd5ZXN3TEJDYXN0WGx4R21VN01Z?=
 =?utf-8?B?WUpPcDgrSHNxNjZIb201YkFUL0pEM2pPODA0SnBKZmJoWVNHMUZudGQ5dFQ0?=
 =?utf-8?B?dzVsWWdCVHVVajZ6cTNtTFBaVDJPWXYyRGN2UWRoTWVPb1gwZ1ZtSGRJWjBP?=
 =?utf-8?B?cTR2eEdRMnprVzMwZ2t4RDRETlM3bTNUT05DOWJjNXltWENNN0lhTzJ5YUVi?=
 =?utf-8?B?VnMzcUlmaGU5MVV6R0VKdnVEYXovY25QY0NQOUdNY1pxdmtuNmY3NmwrMVJa?=
 =?utf-8?B?a2RRVGRsY0gzSGM4enc4dTJUbGFyUnh2NkR6MFNFcWQ3V2U1dVJaOWZLZDZL?=
 =?utf-8?B?ZlYzZE1JSTBGeUlxV3k3K0ZhMGkxSitzUVNRcmpjLzVJb0s0aktwT0x3emxt?=
 =?utf-8?B?aUtPR0ZkN2ZyUFNiT1NPR3E2ZTlxeDEzTkFYZVNiZnUzenM4ZnhCbjZHWk1r?=
 =?utf-8?B?aks3ME0vVW05LytLZzljSGdQT250cTNiQjZHQWJrMDNrakxIYzE4cnNyZVVK?=
 =?utf-8?B?VFMxcUJaTFJZeUdSWEpnQnJ6cFM5WnVlSDlheHFWd3VKNXdITWtRVktBOEh5?=
 =?utf-8?B?bURKUlhMdXNNSHZmR3NrZUFYRStjM0xucGdLOWFKVWh6TUVHLzF5VDVDV0lp?=
 =?utf-8?B?UVlHZFUwV0ZmakxVZkdCZ2Z5dXJFWmFsdm54SFhvcDlLQ0JsbE5vQVRLM01v?=
 =?utf-8?Q?vv+OQL6HGlYQT9nlgI/IToh/f?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	WTaaSI/f9BpDHV34C4HOlRuZCK/61i3DF+q4/Z5EA+g4C1y/G0BMdzubFZDmeiAGe+CDYn81/F184nRVHHBgI+0xxMpDAqasb4Fc8SuGt1nnCBQ/aVMAi4uYNyV/PDxdxX8R0Yj0fLH0SHZg6KjPFwpQY6tjCltzsIPUpYTfVqnW9U2fnd6pRTcr9cliPmZO/qDi+SZwbFt4goJ1WgouHlD1DEIh5uXK1AcAs0Zn962sFNlfDa3VmVG9Hani5HSJz9te9TZqagAx00ZPm/2M7iQi9yh0lL6ti7thvIN/1cxfgvLwkwAV1GHLg+UQc2Gs2qjaniPnrhg735BPakpS8cPQhxeU6PVDrYnEMO1DYMByRdKWAGKGboOXcJsd6sh1Lj7PhSeYFaByz+DM8xTMTAfVRRAYhVisqOxbCdjuV26XuUHPcc37uCyQqhdlJptgVuV/YAYSfaPFjxyA6jPGX0T0yn5BXxUlrK1rPTO4jOpfkE4zRfN9bn9bLw0QNfEhN5mN5JexhWVdyUBHHN3RgW+LxNxK1edEETSz7knCbbT23Jq9xJOqF3wWfP2Heu2/TUXQowh3sOjKxQ/A1gftv/RC/snBJuYhHusyBFgJ7co=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d01df24e-c328-46e1-2c8b-08dcbbce2835
X-MS-Exchange-CrossTenant-AuthSource: MW4PR10MB6535.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2024 19:28:49.5468
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wK46pg9IY0Rp6hbfZYGDzm6leYb1X0F1hjLSZ/hJD7IjT2YMXQT3N/p1J9+NCkApwO/zB2Hv/pd+W5j9SV/YzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4791
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-13_10,2024-08-13_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0
 mlxlogscore=999 phishscore=0 bulkscore=0 malwarescore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2407110000 definitions=main-2408130140
X-Proofpoint-ORIG-GUID: pDpEuO0JLQK1tmWhTj2dcNIYxGFghCJu
X-Proofpoint-GUID: pDpEuO0JLQK1tmWhTj2dcNIYxGFghCJu


Turning out this below commit to unconditionally enable premapped 
virtio-net:

commit f9dac92ba9081062a6477ee015bd3b8c5914efc4
Author: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Date:   Sat May 11 11:14:01 2024 +0800

leads to regression on VM with no ACCESS_PLATFORM, and with the sysctl 
value of:

- net.core.high_order_alloc_disable=1

which could see reliable crashes or scp failure (scp a file 100M in size 
to VM):

[  332.079333] __vm_enough_memory: pid: 18440, comm: sshd, bytes: 
5285790347661783040 not enough memory for the allocation
[  332.079651] ------------[ cut here ]------------
[  332.079655] kernel BUG at mm/mmap.c:3514!
[  332.080095] invalid opcode: 0000 [#1] PREEMPT SMP NOPTI
[  332.080826] CPU: 18 PID: 18440 Comm: sshd Kdump: loaded Not tainted 
6.10.0-2.x86_64 #2
[  332.081514] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 
1.16.0-4.module+el8.9.0+90173+a3f3e83a 04/01/2014
[  332.082451] RIP: 0010:exit_mmap+0x3a1/0x3b0
[  332.082871] Code: be 01 00 00 00 48 89 df e8 0c 94 fe ff eb d7 be 01 
00 00 00 48 89 df e8 5d 98 fe ff eb be 31 f6 48 89 df e8 31 99 fe ff eb 
a8 <0f> 0b e8 68 bc ae 00 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90 90
[  332.084230] RSP: 0018:ffff9988b1c8f948 EFLAGS: 00010293
[  332.084635] RAX: 0000000000000406 RBX: ffff8d47583e7380 RCX: 
0000000000000000
[  332.085171] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 
0000000000000000
[  332.085699] RBP: 000000000000008f R08: 0000000000000000 R09: 
0000000000000000
[  332.086233] R10: 0000000000000000 R11: 0000000000000000 R12: 
ffff8d47583e7430
[  332.086761] R13: ffff8d47583e73c0 R14: 0000000000000406 R15: 
000495ae650dda58
[  332.087300] FS:  00007ff443899980(0000) GS:ffff8df1c5700000(0000) 
knlGS:0000000000000000
[  332.087888] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  332.088334] CR2: 000055a42d30b730 CR3: 00000102e956a004 CR4: 
0000000000770ef0
[  332.088867] PKRU: 55555554
[  332.089114] Call Trace:
[  332.089349] <TASK>
[  332.089556]  ? die+0x36/0x90
[  332.089818]  ? do_trap+0xed/0x110
[  332.090110]  ? exit_mmap+0x3a1/0x3b0
[  332.090411]  ? do_error_trap+0x6a/0xa0
[  332.090722]  ? exit_mmap+0x3a1/0x3b0
[  332.091029]  ? exc_invalid_op+0x50/0x80
[  332.091348]  ? exit_mmap+0x3a1/0x3b0
[  332.091648]  ? asm_exc_invalid_op+0x1a/0x20
[  332.091998]  ? exit_mmap+0x3a1/0x3b0
[  332.092299]  ? exit_mmap+0x1d6/0x3b0
[  332.092604] __mmput+0x3e/0x130
[  332.092882] dup_mm.constprop.0+0x10c/0x110
[  332.093226] copy_process+0xbd0/0x1570
[  332.093539] kernel_clone+0xbf/0x430
[  332.093838]  ? syscall_exit_work+0x103/0x130
[  332.094197] __do_sys_clone+0x66/0xa0
[  332.094506]  do_syscall_64+0x8c/0x1d0
[  332.094814]  ? srso_alias_return_thunk+0x5/0xfbef5
[  332.095198]  ? audit_reset_context+0x232/0x310
[  332.095558]  ? srso_alias_return_thunk+0x5/0xfbef5
[  332.095936]  ? syscall_exit_work+0x103/0x130
[  332.096288]  ? srso_alias_return_thunk+0x5/0xfbef5
[  332.096668]  ? syscall_exit_to_user_mode+0x7d/0x220
[  332.097059]  ? srso_alias_return_thunk+0x5/0xfbef5
[  332.097436]  ? do_syscall_64+0xba/0x1d0
[  332.097752]  ? srso_alias_return_thunk+0x5/0xfbef5
[  332.098137]  ? syscall_exit_to_user_mode+0x7d/0x220
[  332.098525]  ? srso_alias_return_thunk+0x5/0xfbef5
[  332.098903]  ? do_syscall_64+0xba/0x1d0
[  332.099227]  ? srso_alias_return_thunk+0x5/0xfbef5
[  332.099606]  ? __audit_filter_op+0xbe/0x140
[  332.099943]  ? srso_alias_return_thunk+0x5/0xfbef5
[  332.100328]  ? srso_alias_return_thunk+0x5/0xfbef5
[  332.100706]  ? srso_alias_return_thunk+0x5/0xfbef5
[  332.101089]  ? srso_alias_return_thunk+0x5/0xfbef5
[  332.101468]  ? wp_page_reuse+0x8e/0xb0
[  332.101779]  ? srso_alias_return_thunk+0x5/0xfbef5
[  332.102163]  ? do_wp_page+0xe6/0x470
[  332.102465]  ? srso_alias_return_thunk+0x5/0xfbef5
[  332.102843]  ? __handle_mm_fault+0x5ff/0x720
[  332.103197]  ? srso_alias_return_thunk+0x5/0xfbef5
[  332.103574]  ? __count_memcg_events+0x4d/0xd0
[  332.103938]  ? srso_alias_return_thunk+0x5/0xfbef5
[  332.104323]  ? count_memcg_events.constprop.0+0x26/0x50
[  332.104729]  ? srso_alias_return_thunk+0x5/0xfbef5
[  332.105114]  ? handle_mm_fault+0xae/0x320
[  332.105442]  ? srso_alias_return_thunk+0x5/0xfbef5
[  332.105820]  ? do_user_addr_fault+0x31f/0x6c0
[  332.106181]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[  332.106576] RIP: 0033:0x7ff43f8f9a73
[  332.106876] Code: db 0f 85 28 01 00 00 64 4c 8b 0c 25 10 00 00 00 45 
31 c0 4d 8d 91 d0 02 00 00 31 d2 31 f6 bf 11
00 20 01 b8 38 00 00 00 0f 05 <48> 3d 00 f0 ff ff 0f 87 b9 00 00 00 41 
89 c5 85 c0 0f 85 c6 00 00
[  332.108163] RSP: 002b:00007ffc690909b0 EFLAGS: 00000246 ORIG_RAX: 
0000000000000038
[  332.108719] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 
00007ff43f8f9a73
[  332.109253] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 
0000000001200011
[  332.109782] RBP: 0000000000000000 R08: 0000000000000000 R09: 
00007ff443899980
[  332.110313] R10: 00007ff443899c50 R11: 0000000000000246 R12: 
0000000000000002
[  332.110842] R13: 0000562e56cd4780 R14: 0000000000000006 R15: 
0000562e800346b0
[  332.111381]  </TASK>
[  332.111590] Modules linked in: rdmaip_notify scsi_transport_iscsi 
target_core_mod rfkill mstflint_access cuse rds$
rdma rds rdma_ucm rdma_cm iw_cm dm_multipath ib_umad ib_ipoib ib_cm 
mlx5_ib iTCO_wdt iTCO_vendor_support intel_rapl_$
sr ib_uverbs intel_rapl_common ib_core crc32_pclmul i2c_i801 joydev 
virtio_balloon i2c_smbus lpc_ich binfmt_misc xfs
sd_mod t10_pi crc64_rocksoft sg crct10dif_pclmul mlx5_core virtio_net 
ahci net_failover mlxfw ghash_clmulni_intel vi$
tio_scsi failover libahci sha512_ssse3 tls sha256_ssse3 pci_hyperv_intf 
virtio_pci libata psample sha1_ssse3 virtio_$
ci_legacy_dev serio_raw dimlib virtio_pci_modern_dev qemu_fw_cfg 
dm_mirror dm_region_hash dm_log dm_mod fuse aesni_i$
tel crypto_simd cryptd
[  332.115851] ---[ end trace 0000000000000000 ]---

and another instance splats:

BUG: Bad page map in process PsWatcher.sh  pte:9402e1e2b18c8ae9 
pmd:10fe4f067
[  193.046098] addr:00007ff912a00000 vm_flags:08000070 
anon_vma:0000000000000000 mapping:ffff8ec28047eeb0 index:200
[  193.046863] file:libtinfo.so.6.1 fault:xfs_filemap_fault [xfs] 
mmap:xfs_file_mmap [xfs] read_folio:xfs_vm_read_folio [xfs]
[  193.049564] get_swap_device: Bad swap file entry 3803ad7a32eab547
[  193.050902] BUG: Bad rss-counter state mm:00000000ff28307a 
type:MM_SWAPENTS val:-1
[  193.758147] Kernel panic - not syncing: corrupted stack end detected 
inside scheduler
[  193.759151] CPU: 5 PID: 22932 Comm: LogFlusher Tainted: G 
B              6.10.0-rc2+ #1
[  193.759764] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 
1.16.0-4.module+el8.9.0+90173+a3f3e83a 04/01/2014
[  193.760435] Call Trace:
[  193.760624]  <TASK>
[  193.760799]  panic+0x31d/0x340
[  193.761033]  __schedule+0xb30/0xb30
[  193.761283]  ? srso_alias_return_thunk+0x5/0xfbef5
[  193.761605]  ? enqueue_hrtimer+0x35/0x90
[  193.761883]  ? srso_alias_return_thunk+0x5/0xfbef5
[  193.762207]  ? srso_alias_return_thunk+0x5/0xfbef5
[  193.762532]  ? hrtimer_start_range_ns+0x121/0x300
[  193.762856]  schedule+0x27/0xb0
[  193.763083]  futex_wait_queue+0x63/0x90
[  193.763354]  __futex_wait+0x13d/0x1b0
[  193.763610]  ? __pfx_futex_wake_mark+0x10/0x10
[  193.763918]  futex_wait+0x69/0xd0
[  193.764153]  ? pick_next_task+0x9fb/0xa30
[  193.764430]  ? __pfx_hrtimer_wakeup+0x10/0x10
[  193.764734]  do_futex+0x11a/0x1d0
[  193.764976]  __x64_sys_futex+0x68/0x1c0
[  193.765243]  do_syscall_64+0x80/0x160
[  193.765504]  ? srso_alias_return_thunk+0x5/0xfbef5
[  193.765834]  ? __audit_filter_op+0xaa/0xf0
[  193.766117]  ? srso_alias_return_thunk+0x5/0xfbef5
[  193.766437]  ? audit_reset_context.part.16+0x270/0x2d0
[  193.766895]  ? srso_alias_return_thunk+0x5/0xfbef5
[  193.767237]  ? syscall_exit_to_user_mode_prepare+0x17b/0x1a0
[  193.767624]  ? srso_alias_return_thunk+0x5/0xfbef5
[  193.767972]  ? syscall_exit_to_user_mode+0x80/0x1e0
[  193.768309]  ? srso_alias_return_thunk+0x5/0xfbef5
[  193.768628]  ? do_syscall_64+0x8c/0x160
[  193.768901]  ? srso_alias_return_thunk+0x5/0xfbef5
[  193.769225]  ? audit_reset_context.part.16+0x270/0x2d0
[  193.769573]  ? srso_alias_return_thunk+0x5/0xfbef5
[  193.769901]  ? restore_fpregs_from_fpstate+0x3c/0xa0
[  193.770241]  ? srso_alias_return_thunk+0x5/0xfbef5
[  193.770561]  ? switch_fpu_return+0x4f/0xd0
[  193.770848]  ? srso_alias_return_thunk+0x5/0xfbef5
[  193.771171]  ? syscall_exit_to_user_mode+0x80/0x1e0
[  193.771505]  ? srso_alias_return_thunk+0x5/0xfbef5
[  193.771830]  ? do_syscall_64+0x8c/0x160
[  193.772098]  ? srso_alias_return_thunk+0x5/0xfbef5
[  193.772426]  ? syscall_exit_to_user_mode_prepare+0x17b/0x1a0
[  193.772805]  ? srso_alias_return_thunk+0x5/0xfbef5
[  193.773124]  ? syscall_exit_to_user_mode+0x80/0x1e0
[  193.773458]  ? srso_alias_return_thunk+0x5/0xfbef5
[  193.773781]  ? do_syscall_64+0x8c/0x160
[  193.774047]  ? srso_alias_return_thunk+0x5/0xfbef5
[  193.774376]  ? task_mm_cid_work+0x1c1/0x210
[  193.774669]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[  193.775010] RIP: 0033:0x7f4da640e898
[  193.775270] Code: 24 58 48 85 c0 0f 88 8f 00 00 00 e8 f2 2e 00 00 89 
ee 4c 8b 54 24 38 31 d2 41 89 c0 40 80 f6 80 4c 89 ef b8 ca 00 00 00 0f 
05 <48> 3d 00 f0 ff ff 0f 87 ff 00 00 00 44 89 c7 e8 24 2f 00 00 48 8b
[  193.776404] RSP: 002b:00007f4d797f2750 EFLAGS: 00000282 ORIG_RAX: 
00000000000000ca
[  193.776893] RAX: ffffffffffffffda RBX: 00007f4d402c1b50 RCX: 
00007f4da640e898
[  193.777355] RDX: 0000000000000000 RSI: 0000000000000080 RDI: 
00007f4d402c1b7c
[  193.777813] RBP: 0000000000000000 R08: 0000000000000000 R09: 
00007f4da6ece000
[  193.778276] R10: 00007f4d797f27a0 R11: 0000000000000282 R12: 
00007f4d402c1b28
[  193.778732] R13: 00007f4d402c1b7c R14: 00007f4d797f2840 R15: 
0000000000000002
[  193.779189]  </TASK>
[  193.780419] Kernel Offset: 0x13c00000 from 0xffffffff81000000 
(relocation range: 0xffffffff80000000-0xffffffffbfffffff)
[  193.781097] Rebooting in 60 seconds..

Even in premapped mode with use_dma_api, in virtnet_rq_alloc(), 
skb_page_frag_refill() could return order-0 page in honor of disabled 
high order page allocation. Though I still see

        alloc_frag->offset += size;

gets accounted irrespective of the actual page size returned (dma->len). 
And virtnet_rq_unmap() seems only cares for high order pages.

Suggest to revert this whole series, or at least the 
virtqueue_set_dma_premapped() should block !use_dma_api user from using 
the virtio DMA APIs.

Regards,
-Siwei


On 5/10/2024 8:14 PM, Xuan Zhuo wrote:
> Now, we have virtio DMA APIs, the driver can be the premapped
> mode whatever the virtio core uses dma api or not.
>
> So remove the limit of checking use_dma_api from
> virtqueue_set_dma_premapped().
>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> Acked-by: Jason Wang <jasowang@redhat.com>
> ---
>   drivers/virtio/virtio_ring.c | 7 +------
>   1 file changed, 1 insertion(+), 6 deletions(-)
>
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index 6f7e5010a673..2a972752ff1b 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -2782,7 +2782,7 @@ EXPORT_SYMBOL_GPL(virtqueue_resize);
>    *
>    * Returns zero or a negative error.
>    * 0: success.
> - * -EINVAL: vring does not use the dma api, so we can not enable premapped mode.
> + * -EINVAL: too late to enable premapped mode, the vq already contains buffers.
>    */
>   int virtqueue_set_dma_premapped(struct virtqueue *_vq)
>   {
> @@ -2798,11 +2798,6 @@ int virtqueue_set_dma_premapped(struct virtqueue *_vq)
>   		return -EINVAL;
>   	}
>   
> -	if (!vq->use_dma_api) {
> -		END_USE(vq);
> -		return -EINVAL;
> -	}
> -
>   	vq->premapped = true;
>   	vq->do_unmap = false;
>   


