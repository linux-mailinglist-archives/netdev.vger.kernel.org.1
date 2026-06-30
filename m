Return-Path: <netdev+bounces-303355-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id VJ1GDzYgRGqNowoAu9opvQ
	(envelope-from <netdev+bounces-303355-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 21:59:50 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BD8A6E7B2B
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 21:59:49 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=XqG5s2Vq;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303355-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-303355-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 92E78306961B
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 19:59:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F07B6472767;
	Tue, 30 Jun 2026 19:59:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012051.outbound.protection.outlook.com [40.107.209.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F245374735;
	Tue, 30 Jun 2026 19:59:45 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782849586; cv=fail; b=kLwy+S+KrAjr3pDhJ1MYXSUh2lJ1ILwvthiZpIU0e6b7Qhd54io96PzCaS2YuXoKXodDyMOO22CM2q3k26doVruaU6g7EE1VDxtpCGtRsZM51jpxhXUkxjx/B1eWKCtJwpbaJjRnvzm0hCt0nfZ7kLvA+82nbbHDM4yH4xnS7Vo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782849586; c=relaxed/simple;
	bh=gI/6QAxlaH9fRXzSqJtsNtxPGd8cu/h3hdUwmlWFpGw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=o0BFOkGq1aEoK/1XP+gG860Xa2cdzBCQaHJP/rkGq5Jb+KOmq9sAcYmthWWCQrGK/VQEPmPFRbky0zR+Cr9Bj5RW0DG3STOhJpO7uwa8H1OnINLgycNBnwjF0vMFTCyMlYM4nhD3T608QMA+9swNz26XujTo9GbxTf3RCY1jvJY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=XqG5s2Vq; arc=fail smtp.client-ip=40.107.209.51
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZOtaa3CjYnSFypjSam/PNQzFv+GLc+atkBSB7tNGFXFlnxcs1sfomkN0kAIab2UbdNPY8IraXvo+sa7k4MHRW5aJh8CDNTRQ8hbKXLZSd6QZF9VzUjn4kiPj8HnytC8hLz/mJsb7Hid3q56ULPLfgYjfbpi/Xd3VwLz/aTaoqhp7OM43erXZH1uiF7/2ZubwlxQzhSauPCjy+Lfz3cghy3AhLMpY8A8oMcESAQjdIJLIeTHhkFFghQX414ZEV7DmH7lrf0m6LhUPK8GvPQkwBl4ZT6ZfOJgP3TuoneFpq0xFvCc2quiOA5j+nPJ8zqVRZk0XJ3JwP00RK9pv3c9/lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4B00NnSUMaoz9VTGt+4HL7l0Lz6+ZG3gHM8U3eCcnpE=;
 b=cGV6Fcf/Nyorav8yKROvaXriYU10h3IkxTGdDxm8R2je2Qcv+NXFdA+xvX7iAOob3Gpp64OC0Bz8S+xlDhZauxGOBXecIyYQjqWLtiwaGs4WNeI21f1CENjm7+v92YfhBjMH9tYYrn5nbXqAYQ0eKM9OqmknpoFEH5bRNHpuFdiePdMWBxTqmXUIKpsCSyMZe9sGwwSi6ZGGMpM/UJ81nLa6gvEGJY2CARMnfF251hQQldhjvmYoYqO86168W84wjZ7sgtAFiXeRub1J+DYTYZMFk4ImAVI+sFulteRYLO3QVUdsMViDzbyn3B5bYGNM+fIcL8phweclnJMgYI21SQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4B00NnSUMaoz9VTGt+4HL7l0Lz6+ZG3gHM8U3eCcnpE=;
 b=XqG5s2VqRJCzb3utH7kVOFxognP6EbPRmx7XuOfauFRNyt44EihhXGUUeccqPzmZZ7tPk+e8/3oVNgSWs8LjJ61rYK5DlQbK3fmUOBB/GorVn3rl+jUnLbaPr/eG2Dg47vcmse+QenO23+u8v7hm3A+d6GEaMoacgKudiV5RhpHea3KjN8G6/rSz4D6sF3njuCxGkrA3HhhOYZKzLwLdR63BbJ8vcO7p8R6q/8H1mgBQkSDwUnGG8QRBQrEDI+0NEsk/dZpL7cgrZROMlLQaATwoEX5EqOaw3glwx2fKZ3ofN7TpMKRmnmxu1ZYyXfoZYQVl2xa+yKk25aa5+JpK1A==
Received: from MW4PR12MB6802.namprd12.prod.outlook.com (2603:10b6:303:20f::19)
 by DS7PR12MB5816.namprd12.prod.outlook.com (2603:10b6:8:78::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Tue, 30 Jun
 2026 19:59:40 +0000
Received: from MW4PR12MB6802.namprd12.prod.outlook.com
 ([fe80::51f4:a3d9:b44e:9587]) by MW4PR12MB6802.namprd12.prod.outlook.com
 ([fe80::51f4:a3d9:b44e:9587%5]) with mapi id 15.21.0159.018; Tue, 30 Jun 2026
 19:59:40 +0000
Message-ID: <275f8738-51d5-488d-9934-3018fbe7a899@nvidia.com>
Date: Tue, 30 Jun 2026 22:59:33 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] selftests: net: bump default cmd() timeout to 20
 seconds
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 shuah@kernel.org, petrm@nvidia.com, leitao@debian.org, dw@davidwei.uk,
 gal@nvidia.com, linux-kselftest@vger.kernel.org
References: <20260629233348.2145841-1-kuba@kernel.org>
Content-Language: en-US
From: Nimrod Oren <noren@nvidia.com>
In-Reply-To: <20260629233348.2145841-1-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0083.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1f::21) To MW4PR12MB6802.namprd12.prod.outlook.com
 (2603:10b6:303:20f::19)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6802:EE_|DS7PR12MB5816:EE_
X-MS-Office365-Filtering-Correlation-Id: d0632495-4422-4305-5d08-08ded6e21f01
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|23010399003|376014|6133799003|3023799007|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	Ib0MnkpAjxBYFZ0DBab4IUkoy/Ww7Xc1zGWlMxtTl5ZNFEWmAu0UDNp45Vq++kDkqdsiZ7eoobW7nS4dRcwbKckDp3vgAGgglyd/80DFc7oTXq89stBO4lmC5J3ZFWC2NaWs3QnVF2eyJOL6gvwkfiK9euPj8iVw+Cn4Z/adQhYya7dazzfabzwn5NHVXEYIpiR/m8x+vTz8xXhV3l/1WUvr9vKQZgEq8/Lc+Jr0bNvhvaUlucaAewvUs8YMPfU3GM82IJro6I+LekcKriCxjFrA0r4DzwMLaNXfMYz7C3jQzwYRzreE7Qv4p1TR9YsKw0BbrlUeelPx6UbIhTDMpnkihNqyY4xQA8Tqk0OYkQv5LjX1cQtIM+G5Og2/N7P/NoO5BhwuvatVLfZzYlcU1LxjqikZfh4+TtlFUEzMU0m0rUcQOZkB6Lk5Iil4gvQH5QCa6RfiDtD7w846Def3Rv237O3+PIv91wOqk2pY0e3OP6ONXhxK9jhr7n0uxidYUAqnKFeirZdeiDXZC0P2Nzay8vW76XAAVh5uGDxsCsA7MswukZNS80YaEk567u0LbgZGPiDn4kY2g80nf46Kdgd8qx3y4sLWHdwilxLCeSaoqcVihICmqViOEjC+7l2KmRY3oqoJ7t2IxOZXfr/+pC8z6EhxsFGKhWsr84ID9J4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR12MB6802.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(23010399003)(376014)(6133799003)(3023799007)(11063799006)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Q1FEYVQvVVVyUXorMUN6Q2toREs5WkFWS3ByN3ZRRC9HVVFIa0J2M0hYdVRY?=
 =?utf-8?B?azJTbVdsdkNoVHZDSnY2YktxaTRHbWtrOGNTclJuL3NuV0ZwRHRlVzNzSU50?=
 =?utf-8?B?bG0xa3FmaWhxVVB6TnRXOHF3akZwUG5Zck0yelBEcEtVbitkbFpUYXFscTFu?=
 =?utf-8?B?b3A0U1NDV2VKdEl1SE9nSEZkOGU1dzVic0lVMU9heFNMMVlWdEQrT0o3YmlE?=
 =?utf-8?B?R1FhQmdGa0FTUkN6RTAxTnQyWWRBQ3RrVkVQNmVwS1BJR0lSUXN3T2UwZkZX?=
 =?utf-8?B?WWIreC9pVzIwcTkwL2Q5eXdkNmFLWE51TklpSDFYdjV6UE5zekZRSjlXM2F0?=
 =?utf-8?B?M3c2dlhuemZrYkk5SUlqOFIxeFMzVVR0Ykt3WmpXVUFPMXRnNkhJWWQyRm1T?=
 =?utf-8?B?M2dIUU9SVGJMcUd1dFR4bWxQNkY5UlZPVnYvQ3NHUmxSOFdWeHFvRU9seldv?=
 =?utf-8?B?K0puRSthaEJvcW1mT3pRenlRa3BmL3FnTjg0ajgrK2tETEQ2SXJGSDh5dDRP?=
 =?utf-8?B?eGRleDFaMjlySFNYZVFyUGlWQjlOTUJTN2tsdlowUWZJQmdmOEgva2Y3cmw0?=
 =?utf-8?B?N1R4enRRczRVQmc4RHlBSm1YREpqTDFPM2pVWXRmWERqUi9JZm9YNFlDaW5O?=
 =?utf-8?B?ejRHcUF2VTJ5YVB1VmFvR0tFODJha0pCcTNIbDVyb05NV3lLVHNWV1pRaFJx?=
 =?utf-8?B?RmdKZUpON2M4cG5RbXVqeHF1dUpxVzl4Y3BNK2RpTHRKQTdGNVIxaDdpd0tw?=
 =?utf-8?B?TVZmaWh6Vi8zb2pCSFNKdTJBd2ZEUURnNWhIekcxb0dsK2tYZnltOEZYbWE4?=
 =?utf-8?B?a29MQjlqNEVaK1UwRFFjc2oydGN0ckhEa1FrRy95WU1CSTRXSENnY01ER21h?=
 =?utf-8?B?K1VZNzUzVFgrZkl0TWdwS2FRTzRRQlpwd05NOUhzU0h2WHIxTy9sd2NUbWpT?=
 =?utf-8?B?R2lUTUhkL0d0YW9MbnRwQVdvbGNNMnB0bzhpZ1RjVC9rSDJSNFYzRFRXc1Z2?=
 =?utf-8?B?cE5tbmZXQThlZEVJR05YcTRqODRBdzh3UmZIbGhTTXYxSkhxOGJ3NWl3WDVY?=
 =?utf-8?B?ODNZQ0FLQkZpKzdKNFpqL2pKc0hmak8ybEt4Q1pxeTVCamFXMElGMngxM3or?=
 =?utf-8?B?VUNUckdwRWd4N1ZISUhXejhJV1Y0MEo4ZEp1ODduc2RsbjNuRjdINHZhWTJ0?=
 =?utf-8?B?ZjV0Zk9Za2tUdUZaS1lTYW9KMkliRVMyZExEQVV6NGs5UWlvSFY2RHEveTND?=
 =?utf-8?B?QlFIMFkvNDJIMHorUU1NWWUzai8rSkNTWm1VTk5FeWxVZ0lVbHkwSFl3Nmt1?=
 =?utf-8?B?cEt4TDFESkhMcDdoRUxUT0IreU4xMlpkYTh4ZzNZcVRUQjVKcEZNTGpaUm9V?=
 =?utf-8?B?WE5WNVlJUDhyQVFtNDdmKzJJNm1RS1hrajRNUXVsOEpSK1c0Zk9FR0sxTkUy?=
 =?utf-8?B?L1N5TThLMG50Ky83Y21Rc1A3eWY4TXMvQlRSMy9tQVpRZEtjM1ZrdHY4S1VF?=
 =?utf-8?B?YWFaT3JvdEkvWkI3dEQ4MnJoeFd0YWRsc0NHQ1FEOFl5MkVDMW1vbTRkZFNE?=
 =?utf-8?B?SnV3Vmh4V3N3NHFSNURFY0o0M1RGVnRxemplSnNXSUN3aisxazRkZ3N4WFhn?=
 =?utf-8?B?dTNESG1DK1NiYVBWR0s3UGlIT2RyeFdoRmhqalJWeHpMNUpPNnRRZlNRc3FQ?=
 =?utf-8?B?SnRDR3pnS1JBMWVBS01OY3crZWxtaFowV095SHdLZytncE9kU0ljT0Q1MVc5?=
 =?utf-8?B?KzQvRTVHSTMxU1hxWTU2S2NKZ3A3L2t1VW4yYWdJSm9xVW1sa0c4WkUzYlNL?=
 =?utf-8?B?RklwbHArZ3NwY3F2bjBWNytDdE1UUFhaaVhnWXJaekJ3QUcrMml4OUlxeWNJ?=
 =?utf-8?B?VXFySnZzNC9lN3d4U2FZdU45TWZ0SGE1K092UTNCRjdqWjBVTlZZSllTUS8y?=
 =?utf-8?B?c1F2MU1jbmZxZUxrSXZWd1dUSzROazBKZVd0aWR5dUNmMW1rZ01lWlUwWDBm?=
 =?utf-8?B?QllNTVBHTjAxSlcyY3I3RWFHMWpRRkhlbVVYTDBBUXZYbTU1WGV3VkdKek9E?=
 =?utf-8?B?dWw1SGloN1BUQ1Q0VUhXOEJyTktabU5SY0ZoK3J3VTBIYlZIam5VL3JmVnVM?=
 =?utf-8?B?RXRRMDY5Nk5TcXl1bDBKRHZ5dmJRMHJJZHV3TTRvaDkvcWt1eWkxbDNVMkVD?=
 =?utf-8?B?WStnUW5HL1pqSTduWm5pbXdxcFYzMm9IODZHZnJ5eklGK0dqMXRxSGlwTjV4?=
 =?utf-8?B?UjZkN3dZT2h6N21QdVZLYkFCQjJxK1ZLTVBJV2RZQ3FidFM4STVwOUhQbDRG?=
 =?utf-8?Q?LYTm5mQ5YdgN1Y611f?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0632495-4422-4305-5d08-08ded6e21f01
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6802.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2026 19:59:40.6376
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EkkktMWDrZzURWc3lzFm8HTq/Ux6xjfyMW9TFWPBVbITf9j77MnlU7JcgMJg20/CLfYiciS6l50MmS+dzM+pDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5816
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.66 / 15.00];
	WHITELIST_DMARC(-7.00)[nvidia.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-303355-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[noren@nvidia.com,netdev@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:kuba@kernel.org,m:davem@davemloft.net,m:netdev@vger.kernel.org,m:edumazet@google.com,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:horms@kernel.org,m:shuah@kernel.org,m:petrm@nvidia.com,m:leitao@debian.org,m:dw@davidwei.uk,m:gal@nvidia.com,m:linux-kselftest@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[noren@nvidia.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,nvidia.com:email,nvidia.com:mid,nvidia.com:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,Nvidia.com:dkim,davidwei.uk:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8BD8A6E7B2B

On 30/06/2026 2:33, Jakub Kicinski wrote:
> We always used 5 sec as the default command timeout. But soon after
> it was introduced, David effectively made us ignore the timeout
> (it was passed to process.communicate() as the wrong argument).
> Gal recently fixed that, but turns out the 5 sec is not enough
> for a lot of tests and setups. The fix regressed regressions.
> 
> In particular running reconfig commands (e.g. XDP attach) on mlx5
> with 32 rings and 9k MTU, on a heavily-debug-enabled kernel takes
> more than 5 sec. The XDP installation command will time out after
> 5 sec but since the sleeps in the kernel are non interruptible
> the command finishes anyway, leaving the XDP program attached,
> but with non-zero exit code. defer()ed cleanups are not installed,
> breaking the environment for subsequent tests.
> 
> Since "install XDP" is a pretty normal command a "point fix"
> does not seem appropriate. 32 rings is a fairly reasonable
> config, too, so we should just increase the timeout to 20 sec.
> 
> There's no real reason behind the value of 20.
> 
> Fixes: 1cf270424218 ("net: selftest: add test for netdev netlink queue-get API")
> Fixes: f0bd19316663 ("selftests: net: fix timeout passed as positional argument to communicate()")
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> CC: shuah@kernel.org
> CC: petrm@nvidia.com
> CC: leitao@debian.org
> CC: dw@davidwei.uk
> CC: noren@nvidia.com
> CC: gal@nvidia.com
> CC: linux-kselftest@vger.kernel.org
> ---
>  tools/testing/selftests/net/lib/py/utils.py | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 

Reviewed-by: Nimrod Oren <noren@nvidia.com>

> diff --git a/tools/testing/selftests/net/lib/py/utils.py b/tools/testing/selftests/net/lib/py/utils.py
> index 308c91833239..9b40049e2dbb 100644
> --- a/tools/testing/selftests/net/lib/py/utils.py
> +++ b/tools/testing/selftests/net/lib/py/utils.py
> @@ -44,7 +44,7 @@ import time
>      Use bkg() instead to run a command in the background.
>      """
>      def __init__(self, comm, shell=None, fail=True, expect_fail=False, ns=None,
> -                 background=False, host=None, timeout=5, ksft_ready=None,
> +                 background=False, host=None, timeout=20, ksft_ready=None,
>                   ksft_wait=None):
>          if ns:
>              if hasattr(ns, 'user_ns_path'):
> @@ -113,7 +113,7 @@ import time
>  
>          return stdout, stderr
>  
> -    def process(self, terminate=True, fail=None, expect_fail=False, timeout=5):
> +    def process(self, terminate=True, fail=None, expect_fail=False, timeout=20):
>          if fail is None:
>              fail = not terminate
>  


