Return-Path: <netdev+bounces-304028-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 8KLrMTQfRmpPKQsAu9opvQ
	(envelope-from <netdev+bounces-304028-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 10:20:04 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2941A6F4B67
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 10:20:04 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=Zu16EyJ6;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304028-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-304028-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7E8AC30A9907
	for <lists+netdev@lfdr.de>; Thu,  2 Jul 2026 08:12:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA26A3C553A;
	Thu,  2 Jul 2026 08:12:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012003.outbound.protection.outlook.com [40.107.209.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B50AF412269;
	Thu,  2 Jul 2026 08:12:34 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782979955; cv=fail; b=Ti7IlGBi2UfVysDms+vRffqLhoZ8nUk1NfINHy2GVnWtqti/hMemXiM/NisX7xXs5FxKAhkrKUzAxtlGR8xDtF/zc2BEZUn9OeoZT0XqqGu52oZtUM+AaCnggrLTQoDe576AJBFSUmHHcUOf/hzDuObnPzQSkCRIpoTlekVFUO0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782979955; c=relaxed/simple;
	bh=L02+5G1PvUJCwJokOIda/qhg/1cvJB+3xI9Wx6q4UDI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=YnH4MqcfxH2PokJIJaLYR8OJLZG8oozd/nSmJJU+RlyKc2O+lyJcDnpfnzCB4hsw/9gM8ThZIbVhYuR1sIliqWUwScwGDgUAg9ya8tMqdx8+x90GLQ1K6n19L8ZyXSpMkadNN8XAWUlX24jT8JRu6f1+d9tuVknrCZk0TmelfYo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Zu16EyJ6; arc=fail smtp.client-ip=40.107.209.3
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tTcwadpT3Od+KFbU4wRJxVEgmnzncm1Kx3EHVpT8CtwHxiVaYbSVXReIlEfEnDn/BzxnNHTzrXblyPS7uyzIaAiA/+KhFCRlGoF1aTMb9MpswoqY/+EaADQ6cMdNwOR3ZQHr6MX8LU8Mcf9NCgu6Drp6qOglgKtBnYMLzO1dG5TMYHuA46HhymkqMgfvDgAn5PPC45hgYF2/2CaXZUsHf5hyhMnz64z3od6OjGIyrxKivgTz8DtD94IwVM/JnS30FPEe1ZeSfw5i/E3Oj4Df8Jl5vTcJXo9L83BfxzH5YGbJfa2cuFEeeb1EuE8AcV72dBT7ze0dtq2J4M6kYqiDgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uhY0waaxDWzDgxXwPRnhHtzMu8t+q8zwtA7spP7KSvw=;
 b=LDRk1/qDSRRyFYQNdakmiXYS4Gv8U0FYb3klxnfQbP1eXJN6I/sLG5rgPD4Z2khjTYbPuOm/nmR2SgpaNAaSE498pn+wY/LqhoVQAiy1b8E94W5fm1ZL/qCcw1f05je/e9OzW7DtDC5L1i6ouRZplr7uWRpcqdiyP0Ot4KWu20fcyaHga15cKxa1wmyZTDxwHKurDdoi6nMzQzHPstS5vbG8Wpkjznow3Y9Tpa5S+doe1oh5XXAs71b2E4FI9P2MPjvSG1W2aMH9tSMlHypWZHFI88ikvY6CUulajt5KMykTB0B5ZMl/ph5d6ndduBB8su0gC7ZYxsiE5Vdo0PFhHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uhY0waaxDWzDgxXwPRnhHtzMu8t+q8zwtA7spP7KSvw=;
 b=Zu16EyJ6PB0Na87Ir3pU+X7SHrU9y8K91iFqzMJJvUMQk9zwjtft2QCRZaiMlJ8e5RqNZTHYurOty8SWPQAwZ16yxPOvcpGRVZOVFe+awLXjlQTtdUh4oShNaYlbyMk9UPPQ9sTyK5loiuZ54YxexFa5o4z8T2g9m6MtrcEggMb3a5vGXAAuSUhEm+pFDs3epQ1SfOZZXfj83+i2H4yqbffO0rHeC7s/FMN4+6v/z9zA3co6XhWo/ZFBtCZMASsZS62MC8zKcUP2cH3/stUB0KB0RGUMOTsQfSIFvntwUrBIAyqBBBTJOpX4Fm4tIxRDenQsrjpiLpEuHWCIBhKdPg==
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by PH0PR12MB7485.namprd12.prod.outlook.com (2603:10b6:510:1e9::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Thu, 2 Jul
 2026 08:12:31 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%6]) with mapi id 15.21.0181.009; Thu, 2 Jul 2026
 08:12:31 +0000
Date: Thu, 2 Jul 2026 11:12:21 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Yuyang Huang <sigefriedhyy@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	David Ahern <dsahern@kernel.org>,
	Donald Hunter <donald.hunter@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>, Simon Horman <horms@kernel.org>,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next 2/3] net: ipv6: report multicast group user count
Message-ID: <20260702081221.GB1574313@shredder>
References: <20260630110207.37841-1-sigefriedhyy@gmail.com>
 <20260630110207.37841-3-sigefriedhyy@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260630110207.37841-3-sigefriedhyy@gmail.com>
X-ClientProxiedBy: FR5P281CA0034.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f3::13) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|PH0PR12MB7485:EE_
X-MS-Office365-Filtering-Correlation-Id: efbc0ac4-0436-470a-961e-08ded811aa40
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|376014|1800799024|366016|6133799003|56012099006|11063799006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	Q8W1Vrrlxw19ztUAP4eE83lBabzwg4WmvR4TrObSSRSO/7x0ygRKcuINyH043FxQhpzR3mXF3LrGZb7NDs787LnKm8ZA397Eev/h6MpHktOHbSc9rwgtvOtXB05u+VMixv2xRAomky+cUmOcKCdNbg2mIH74rxoHu1JSpDuytSaHnannGn5+o+lI2N3icm4AhMbu0z3x/pu/nZNUiUwydVpTJZ89DEfxYoKhGa3f84Q/pgYkUZZhEGv7Pa5ixnW9QLIYXbKyXdiLBc0qHrASfpPcYBXo+eHFCOD4G22yRaBY3SmJyFF9mjHn9E9jcPxsSsOnh28fEFLKDco/ApjixMCMUGFoUAGiR6VmqddWfZfNXf0NUJ1gULOZi08HxqUWVSAKjn1A5zQsi1eXvr2ZkLH4TBecI5Rb9koEEm/Vb3bMrD6W32C0koiKRcxPpYeiuoRylFjxwVMlx9K/bwPbq4WbED1I8G3H5d6SDvXDgJrC8TCt5JAj3WBNorjMTua3Rve8U6IEgwb2khL4PEL6s6R5dr2F+8WGQmppIHHa6hYGD6QmwQZXHAt/GPbzr0OBPZAGcFmX0MimOB5DFa3SO5AEiWQkZLz3zlIhk3aR5qa3SqVZadVnPP9eNENGZzBbJxjYZTYQe7LfCmAlDEg81KU2iaEXylEeuOSWNHaeZfo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(1800799024)(366016)(6133799003)(56012099006)(11063799006)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7GXB5Ym6HKoWZXaExw4dsV8MPJRa7mnbllND/xZZ+8v0EljZWVI/KOHQ4Cn1?=
 =?us-ascii?Q?CAcWnmyphy3hQU5UvMk5q5xQvjqWKQ/5nGu8PJv1X0G3HOee1MKMXTCo+qa0?=
 =?us-ascii?Q?0gF5HFc4X0BUED3X5vQ1cIV5tyQR4ZLgjuvRCK+ahHPQ0Lv8WZUGpueeGZo7?=
 =?us-ascii?Q?GzJZxDZVoElHW1YBKXFJIn6REZiwRPIrmH5MG0qKt8gWT9ZPqHxRMfblyBjp?=
 =?us-ascii?Q?Hi5TWfJKJs6oje0sN/gzw+B3sA7egCxlrAxABDTRb/kUuF0ZOOWAWojLSMEq?=
 =?us-ascii?Q?mxNthIO4bQyZ2RfxE3x8YXHNPjnxX7m5+tEyB5MCybimsWSkquHVvxUmW8VB?=
 =?us-ascii?Q?SgiUUwP1C/Ilcw/26Rhn2BpL5f76Vv174QPNMm/DqRQ5pS2wQxmWvps1nzod?=
 =?us-ascii?Q?ap004xFF8cVVx7TRkljNewSTQ8pWvKC6DtIQ++GkWd6+WYp1S+cRNp5i8Zvo?=
 =?us-ascii?Q?zU7Bug72C3bQwNpjfvGcyqwJPp+G3hbowYxDyKJylDVPi2Bs/D2+2GgdUxHO?=
 =?us-ascii?Q?8KLXkyyxR8+0nXLpRrBC7kNmengXmmiac6zjAn5FzkeB/lzU5FmCVYO4Qaos?=
 =?us-ascii?Q?fMK4t/vPAQdkD0u/EDNAMnaoLdzHTeZaEbD4LlnuqXUQqQE55ZuOVe3fja6a?=
 =?us-ascii?Q?mYJAKuw0va5TkLVpG8dNX2Tv6MsVyT0H+lGEqD2fXU5J3pUeuTXL77TcQbYu?=
 =?us-ascii?Q?XS9Fz4VznHpg+t5W7+8EdDwifeOZKUu4OAKVxikHS/XY5BxCD53MFPoJIQje?=
 =?us-ascii?Q?C1iz4KkuFMrUg4h9dQgysMvqaRsy4gJk6GlBiEkeNVbxgh3T9wD/tz4OdeT+?=
 =?us-ascii?Q?xxE1GBMTb75jkH/KLuUOyF33E3Uj8SWMI4NeQhO6d7MigDnWvvvdgazlAksG?=
 =?us-ascii?Q?t8lHIbPyq3mSTxAu1GAUjzslBsKkelZ6I0jCV6G3bejMAzueQwz8dVMmE6VZ?=
 =?us-ascii?Q?w1sI0Q5ryIXklVUTiyDsdwO4WxExiEcu7u7iDhPhrf66zvYaiz9Q2sBw01R7?=
 =?us-ascii?Q?abAYtSDHpe0xyD3VqPB8eAQlqGZdGOzCevpnVghLXaD4dqO4tx6P18aq11S4?=
 =?us-ascii?Q?EEZHJGnt67xGttply+/nLSVKAWIP7yYUMLEJgv5OxRVrMq2AE7zE26Lr06ok?=
 =?us-ascii?Q?r+aNefQH5m2ZNS1BPqfUvDvxHXsFQwjt0FXmMiwqEN0EVc9KCSRpO4WIAF5A?=
 =?us-ascii?Q?vLItHxDgySw5mu3fsVewgB4/CDLfhdKf2KEOqnl/yqQLJWwvIM8bsb+d/XrS?=
 =?us-ascii?Q?mDebycPVc9QQxNqwGCZflgy8wbSPsatvhU7OSU1u6QV5gZ+pFLhO9hVIGjr9?=
 =?us-ascii?Q?TBf8KhPh0e6fPvJZnRNoCmDFm0wvW4X3gxL0M8mpQaz9IHI34vj1ey7Ou3P1?=
 =?us-ascii?Q?4jAmFw6GPsCroTqk5GNQdBq08oTSK0R55jQ2cTDeSzrIljzh1d7rYa3c/o3Q?=
 =?us-ascii?Q?VQfjRAKoGTmy/wupGJ/fo6/l/vcbKiQYo7Xnx5D9l/ReL7aGQThKFU+WVt3F?=
 =?us-ascii?Q?iBAj7K4E6a3crsNUZADk60SSZ01Y4ml4sZXS6Rc3hl50sBcaO+CS3rnNA34D?=
 =?us-ascii?Q?2iE/kACjx4yXMGklQbWYi4V0vXQT7nD8Et97rRjFA+epMamtGy4WJtiKgb45?=
 =?us-ascii?Q?HMeUGrHMt0eUmtNnyeBJqZmPm3XMIDps1H1fPBsz9Kz5MlK46rEyEl+oxICC?=
 =?us-ascii?Q?dkq2e/iQ5axnaXuDtwowZPrjmqeAMD+k6Hs7iSSFEp3z5urCcA7nPb4Q6/Qj?=
 =?us-ascii?Q?c7LBjLb2mg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: efbc0ac4-0436-470a-961e-08ded811aa40
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2026 08:12:31.7350
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7Wgg6W26hdEFAb6Ua8PoIm1GwKJpiScdw+uU1UMqocflMZGqQqoBl69I+FS7OGy0O9MPL96k3yLY6SEyeZC/4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7485
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_DMARC(-7.00)[nvidia.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-304028-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[idosch@nvidia.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_RECIPIENTS(0.00)[m:sigefriedhyy@gmail.com,m:davem@davemloft.net,m:andrew+netdev@lunn.ch,m:dsahern@kernel.org,m:donald.hunter@gmail.com,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:shuah@kernel.org,m:horms@kernel.org,m:linux-kernel@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:netdev@vger.kernel.org,m:andrew@lunn.ch,m:donaldhunter@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[idosch@nvidia.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[davemloft.net,lunn.ch,kernel.org,gmail.com,google.com,redhat.com,vger.kernel.org];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,shredder:mid,vger.kernel.org:from_smtp,nvidia.com:from_mime,nvidia.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2941A6F4B67

On Tue, Jun 30, 2026 at 08:02:06PM +0900, Yuyang Huang wrote:
> The previous patch added IFA_MC_USERS and emits it for IPv4 multicast
> groups. Add the same snapshot attribute to IPv6 RTM_GETMULTICAST
> replies and entry-lifecycle notifications, carrying
> ifmcaddr6::mca_users.
> 
> This makes the multicast rtnetlink ABI symmetric across IPv4 and IPv6
> and gives userspace the same user count that /proc/net/igmp6 exposes.
> 
> Signed-off-by: Yuyang Huang <sigefriedhyy@gmail.com>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>

