Return-Path: <netdev+bounces-296939-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id jBMJDKfEJ2pX1wIAu9opvQ
	(envelope-from <netdev+bounces-296939-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 09:45:43 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ECA165D593
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 09:45:42 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=RnkYnqjO;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296939-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-296939-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4CD993001582
	for <lists+netdev@lfdr.de>; Tue,  9 Jun 2026 07:45:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFDE4332906;
	Tue,  9 Jun 2026 07:45:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012060.outbound.protection.outlook.com [52.101.53.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 010F1375F88;
	Tue,  9 Jun 2026 07:45:16 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780991121; cv=fail; b=rBpZeHZiH7IF0/eV4TwwTeNYt3qzLajGkF57ACUs8R/agd++BdXzTR+yTeNTx1pUEezztg2PnAz44MPxAr30e5kbwF/nbGKRIlEYFGn/qsAF1w3OeOlRHMGfCFCDAEePItS7eQrdKrEt9P7hDeg+lqOv/00TL7eqtbA0YjuzFxw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780991121; c=relaxed/simple;
	bh=m/zn+1Cij14wBBZUAa2oPmo1zLAKTsQvxTL2s9Cbtno=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=t1sPfT4nGDTB8rDKS03YaTFjf08Zj1EROFKMWNwkQK/sT9Kchy8a29qUzznx2EbPkhq9HoK4ArLFXynaoPxPywMIUcHTHsHNXRznNyFhd6+OxsYSSfaPXnLvxxxaemYxE5ffpilzoi26Y9wV8L4bY1elwiuKh59n/dFIR6NyyZM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=RnkYnqjO; arc=fail smtp.client-ip=52.101.53.60
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fhBfbTDhz4akwH6bfjMTVvurN8hdmbwpvf21vVN+ypHFJQohINyfTiQb+AVPzKVQcDOJyPlkiP96/nJpJeqLQ1OVqAlwEgvOD9Q/0F0wla9nDWamtaTU+lkV1gSXokJk+qKWVHbwd2LMPMf5KwT7U7XG8lDdDOC40Et0nabDLMwPgXXWRp5COZMy2rNRk86Yj7G61tU6HaRxPKBThwuuBas3crYl0FHvdZkhABFivnEJIrYe74f1496KNLmY17OeIY+mZFs0NAMKkDnTGvWgft9qn0u+LSasX5Ajfh5N1Qk2o+QaUB7Tf/gWvzJU4imcnBF9lJnT6Kmb1AB4FqXSUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QflJygDG5p/fnO+IKoy2GYz5jSrpKzufp9b0UWbLqwQ=;
 b=wIEjsktOZbfPDpQedtqqQQDyMUBnnpXme4+zLjJZEz18hnCqB73AoKi/lJ8/xDnTSvoa1fIm9qmAhDgvuB/hMknL/pIea8juf8B56jYnd834Al05O4nHHhTzPljuPDeqWw2UmuRX4CiBX0G9TLzLh9j/KE3gPAEs4bPDQxSu4d+OTLc6vNurkCQ0xdyFmCMO/yYk9R6OSvfOTgejEvHWPDiFveDPR/0Ss3QbJpo+m8/bpqUtE9HBLawWsE9jJLUxWsaasZ+DhgWyi7PsG7il3quLVzH0vm7iqOIyVnbT1XGGp/LsaewoNSrneequZsgwm/QIcipZjGp7Iiz/iEKWaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QflJygDG5p/fnO+IKoy2GYz5jSrpKzufp9b0UWbLqwQ=;
 b=RnkYnqjOH/FryRgK2oQ4nXpPKr8DU9IzUgSFEO0rioYYNbNCqBV+7egN8tj7iyUiMIDQ9BaLNvfbxWqNvaR4TcnIfZgbWjg+KUqkyDBsIbC422bU1G/ZoJVnTnxV3lnGko2Mqeg8BladS6XV2kc/yOIRYUEOBNVmrLyMgMG39CrNCoy+QDY+EFnzBwAvSov/wBitj1XT1ZBU0PsKeSGozypft8qN/fvy+gJlBj7yCjyUzHG8/cKl71FREuDP9WQAlwM8b8Aasw86z1w2er1hQwkkH5Czct30E9Cb/DUiX2tHNhGAEGOnQ/DfAr7WPLq0aATCs7tBVJpM8WmGvC2PBA==
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by CH3PR12MB8994.namprd12.prod.outlook.com (2603:10b6:610:171::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.12; Tue, 9 Jun 2026
 07:45:13 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%6]) with mapi id 15.21.0092.010; Tue, 9 Jun 2026
 07:45:13 +0000
Date: Tue, 9 Jun 2026 10:45:03 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Yuyang Huang <sigefriedhyy@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next 1/2] ipv6: mcast: annotate data-races around
 mca_flags
Message-ID: <20260609074503.GB663407@shredder>
References: <20260605145759.59639-1-sigefriedhyy@gmail.com>
 <20260605145759.59639-2-sigefriedhyy@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260605145759.59639-2-sigefriedhyy@gmail.com>
X-ClientProxiedBy: FR2P281CA0005.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a::15) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|CH3PR12MB8994:EE_
X-MS-Office365-Filtering-Correlation-Id: 2790ed88-a691-44db-7140-08dec5fb0a0f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|18002099003|22082099003|11063799006|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info:
	k4L80vFlF+A7RVu+lWLsiFU5BBDFNutnI8VtC4lGmt5UayonMePCxyxZXByGUfBSPwC4b35N4syVM/HEVf0qmT2CQXCrSSQ4ogxxlfPoE3tFlthT5aih29oQoE5JzyhqYsFsBZ8pUljZljOQEkh3TVIrPjyZzm6P7PusYSZmG77+kphGXCKorOdT7EnX5ZyjnBSKQRyAl29yn5yb+yIDeA8faDiJtw7WiqEuW4BJHKFkBlW7AMs9v6iVCboIeEnx9xGygUJiZUwxSXLF2lZFUm7tveCN7Ul32ubJLbrEbx4pabwiKqR8mJFKMU78nv6DaftI5ylNiEvD9fYsfqIHzTEZUYpE4svXOAJQ3QjfnWV9vpzKrnkG1QWc+bdgyEk71WNnV/cU+28y7WBbna3un+Yj4Sz2KtTEDfKnom4zsTQlpYWutCucJRS8wC643j6RMu+Ko9aEkgJ06hufAfTXx+fD1I9ogYXjzx4m8pBnaqjDBvkwyVQLiO9TwfLLb7sfsCxyAOC+2Ir47B/BTi5LJoIgFwXW3Nru2oz70ZDpwrcJmWGl7HHcV0qhTo3x3jPY97YDYblHCBn1xFZMishYBBj61Yi9Fz3GAwtlqbyrDGLVh7xX516w5pUrs17FPO0pGv4X3NykhvR+cjZgI999qATkfwMkIYIumpdnqfzqVPSqfzDMbNX4OXxl7gX8EEQ+
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(18002099003)(22082099003)(11063799006)(4143699003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GzQFKJGXj3TttVh98TSXWifJ1p6juGRSyld8PBVPm/keV+MEEwJu/l+npFr9?=
 =?us-ascii?Q?XIYOVxqgLtfEwmMAKgNdrxjrJk9VxetTcxC1IxEik0JeVtcFbEB/o6fPmRT3?=
 =?us-ascii?Q?aC3d5+yD8Pstabv5IBqrt9j7H13+9clQqs7kdEGte1lFt5nyDz92CdWfKKN/?=
 =?us-ascii?Q?yQhnk119PbedO8BZzQ+M6c1xTvrIE2Nazrb9WvPAp8nTH+V3el1/cBgV6T45?=
 =?us-ascii?Q?cvfnMiEdO4Tjprj/JXc7cy7cW7qLrxhl5cgA3gT6rzNuEc1LWrRL5ubJl6UX?=
 =?us-ascii?Q?CPEC52pipSXwHbeG4Md34X6Q4gvYI998BVs3WdU6mKaatBtiryyKE+DGnvsd?=
 =?us-ascii?Q?nS/8Cr2mv9qwrC5O4fBIcQp/LCa0QaH4dz7leAeQgqksvHR/6XOSW8pFalMp?=
 =?us-ascii?Q?7afBhyKDxWPwDwODYgs1p54VRGt6w4/eoHUR4bY0fBoK2ttzOXASIGZUzA8j?=
 =?us-ascii?Q?rtGuZQ3pRIu4fiYPKU3dd7M1HXMOz0YfBthzWDmiHXtsY0kWwXbEqpCEfJ+l?=
 =?us-ascii?Q?fIsFSifrjcQQuhPtfTG60PHwcJOZYrd6z8ycd5xCLW4CjckogV2Vx+6oUhro?=
 =?us-ascii?Q?gNhio1QA+/bhKpoMj3DUw/6dhQzk5JD1C+dS1MSZHQpLnptz9PtL07kO0TXa?=
 =?us-ascii?Q?TQhFRAeqv1MFBw9m+vhzG722wthjzBZ8D9srNpeDiPL1jRdMghF086Koho+p?=
 =?us-ascii?Q?gIZDJJa+/AWIiJfEmZy9Phf9Q7Hspn33Qm7DoTyKJRbzalIXFJFxt236MTEX?=
 =?us-ascii?Q?zPIm5NF0I2aIKf954ZbxH03Ga7Gw3/K+g6oJgm6cAkfnSQXg+0JcQIiwQ4gn?=
 =?us-ascii?Q?9+k4QuxLUlUaluNI+HEWj+1+tLQUk03qNU2nAN7PTckC/VUwcmsi+bSBe1kH?=
 =?us-ascii?Q?NHBYyTH0lv4LpNRD2Fv/pmQOcoowpS8k2mu86xnOa91ZHO2/W/4/NQeE8J5L?=
 =?us-ascii?Q?Fhz+vd4B8KR/hBcbxgt6axQa5NR/a+aaTE8noRoD1t7YyPwsui6Y9HdHEKVY?=
 =?us-ascii?Q?niqQmsXLkGv6r53gW7hh/GkWmOwNO23DjNhR4bTX7ZbvrCjmwzji9tYUg+dG?=
 =?us-ascii?Q?y6SGZ648IkksjbgTINu0eqGWU3Ynp82hUA2GUPu1fEcO+Y5VN3V/5b85QVyZ?=
 =?us-ascii?Q?M1xey0YsOAVIjH9srIPN1cEmtvayZEl/aO//62L1YMvLyv5dqj/YVwtE/Kgk?=
 =?us-ascii?Q?5i6YLvxRFt0EdJj3SSUrTf9Vj2nWTW8ieTlgGtEnqb59DuegMrT1YmOkWQ+V?=
 =?us-ascii?Q?JCRCHViKietj9/rY7SQqM3FV9NCaOnTntTtqfqRtTVNhuXRFK+DLm+vVkMbT?=
 =?us-ascii?Q?xtxv4+5f/yx7ED6zh1PvsCrD309s1Cc6Czzpan5gr/9UL+u9QidztX+xFLXp?=
 =?us-ascii?Q?H04ahZOZxHWbvie/aNHr/sUZ4NFkfAz9uQSCDqT0/zVs/kG2wQE/JdXc5ZLt?=
 =?us-ascii?Q?Gmps/aYFkiRvdEbtbBR8BdvYGCBDtE3sIMtvRKHytqe77/8m9VY7DqtNm1LE?=
 =?us-ascii?Q?au4YmJnERM/91fYIveV4gYxl0mKLmAt7B4Qs5b/eVNvdUEuldZBlCnLYi0S9?=
 =?us-ascii?Q?/VIjJo8OH4rtGeZxb8ILeGLawi1mUNytOMlCry7vMO2GQ87P3A4QBtjvzorC?=
 =?us-ascii?Q?r9Bm1FJbkiyeOidiv4/9y2Oe/Otoc8k29/TxGpVvI1o/aBbDQwy7wjkN+kwS?=
 =?us-ascii?Q?hNPAqnsmytKqDBMhqSbAwDI9StJ4sfb5+/SNv0dmOR1gWk7I?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2790ed88-a691-44db-7140-08dec5fb0a0f
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2026 07:45:13.0379
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c6NM4EYSsK6dUt8UEHQvXnXXTuVovP+4z9DCv6ReI/pcpd5MaVQUtWEHb0dqfVAtz+XzQFZuDDfx/4R/xpU2Xw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8994
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-296939-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:sigefriedhyy@gmail.com,m:davem@davemloft.net,m:dsahern@kernel.org,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[idosch@nvidia.com,netdev@vger.kernel.org];
	URIBL_MULTI_FAIL(0.00)[sin.lore.kernel.org:server fail,shredder:server fail,Nvidia.com:server fail,nvidia.com:server fail,vger.kernel.org:server fail];
	FREEMAIL_TO(0.00)[gmail.com];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[idosch@nvidia.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0ECA165D593

On Fri, Jun 05, 2026 at 11:57:58PM +0900, Yuyang Huang wrote:
> /proc/net/igmp6 walks IPv6 multicast memberships under RCU and
> prints mca_flags without holding idev->mc_lock. The multicast paths
> update the field while holding idev->mc_lock.
> 
> Annotate this intentional lockless snapshot with READ_ONCE() and the
> matching writers with WRITE_ONCE().
> 
> Signed-off-by: Yuyang Huang <sigefriedhyy@gmail.com>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>

