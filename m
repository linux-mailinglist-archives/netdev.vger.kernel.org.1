Return-Path: <netdev+bounces-294220-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id FbrgBvLZHmrNWAAAu9opvQ
	(envelope-from <netdev+bounces-294220-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 15:26:10 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D65962E758
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 15:26:09 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=Nm5k1jQ5;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294220-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-294220-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DEF3F307C7D9
	for <lists+netdev@lfdr.de>; Tue,  2 Jun 2026 13:21:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB9EA3264DA;
	Tue,  2 Jun 2026 13:21:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012034.outbound.protection.outlook.com [52.101.53.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 528552F6577
	for <netdev@vger.kernel.org>; Tue,  2 Jun 2026 13:21:43 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780406504; cv=fail; b=a99OjdrAvIeIYB/cBUfMjuMcanLprd51T8v2MdPomscbjZXuklmhXXCNnzT7mVp5oCOEophz/BziucKyrbRmvxpA/OBlfb+C7u63Kia5vLhw5U78E+rxM/khA78dMoZiMh0doaz01+5Mq9SYexZdcW0UmPNfNWb+K98A+hoqlBE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780406504; c=relaxed/simple;
	bh=9zqtNl7a9/tLNY2Y5BEKCg/OV2fxBsObvwcM/pjHrc8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=osFlH2eFbY4fnF8UBrzaURTsTtrWPOgKtQzrhFY69sxWTKchY1Twglr8YOKU48oHNFaymjc/ssIxi+/gBkxziCPO5gNGmuviYyuahKQxc4WDZZFwta6nYZ4sNsfDEyUNJwMoKCVLuLmgF5/0jGxH32MY2jLZQxghqxiGBJAz5F8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Nm5k1jQ5; arc=fail smtp.client-ip=52.101.53.34
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jzlEU25+Rm4RI8U+kgD47PWK5P+jE36NlnMyouGlVRlSo7t7ZNrTl1ER+egAnycSOvJZ8fs0cYuAACMsv3UFwbdeThYYMM+OAz2RuP+LLBbALL3F0OQJ1F1Xf2ufZ5FZO6pFGLHHb1rKxKVU4zFtXZSBnfu56H1HDBb9izedE3G0ZKeVnYMqn86ISW8gOZ0GqXCmbx5qdhi+n23UNXf1A2jGyd+l+8pG9Ocb3hfkav4OoqxjLadlcX19A/VyajVlQOX1c0IxlRf6WO36okTQhd5SPTRKY4TJh2yrdkDJImDt6lREoVZTZT0DLvczPw659ZQPIIlMACuqh0P9IPAJBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GPQYRG7//VYXwFJvW7QIv2Lda1Pnk1pM45bESsjr5Ko=;
 b=Xb3aQ20SNBd8Ih0x/FB5p2FADdaRIcmxf1xGr7FuVci6zFareJHxZq0XQVLvQFs7cdA3KlgMjHuiohghweo1fq4l/ny/MAJ7ezucurMBQCv/RsKe3adaJ387OGE6qt2ahoh2QimKN9KAAbAIiNIpdaIkJSyvL1aqa8LKyBlvXNxf2/5EJttpRhGcBGF3cGQ/GvDmQP6dp5zWfUo6/onw6/6qDcegHLXhcu+bO3PTqG1G2J73qaNXfQ2pXQ4uB3E82CCaVh8WxlibxuYsvrmTO9iitG8Nc4KVqHCUfHF2Vew1Z0Z4kQ8nzufW8tZlPGMg5t1kPb+/Ay3lFHmzbNXBuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GPQYRG7//VYXwFJvW7QIv2Lda1Pnk1pM45bESsjr5Ko=;
 b=Nm5k1jQ5tRdh7KpAF6O1warDYbzGSsD225UlISom/xLuHbilaCoBnAuFqQhTT8VajcPZXpgn2YwAEsoGdXFJ0aTFgI2BLUcnN7OKM5NPJI00v9pKtMsaYjjxo0yhAbWn2SKPltzb1jnPJzhMaBHCOpagdyfDNe1hrrhCr1gx3n3oRLplzCX2DMi7EvHGRPKi1VvJX7BzSnRXiepoQgMa/5teQbDFmXnkeJb6sJP1RMtylpedT2zOXtBQoBhxy0QPhtkqR5dvjq9Jpi9AOWLeTbTPS2528eU/viXdB2h3ImBcuNCoDD8yvTS6URakEM5nudMA42vDFEXJzKNUYxxnhw==
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by DM4PR12MB7670.namprd12.prod.outlook.com (2603:10b6:8:105::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.16; Tue, 2 Jun 2026
 13:21:31 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%6]) with mapi id 15.21.0092.006; Tue, 2 Jun 2026
 13:21:28 +0000
Date: Tue, 2 Jun 2026 16:21:18 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Stefano Brivio <sbrivio@redhat.com>,
	Fernando Fernandez Mancera <fmancera@suse.de>,
	netdev@vger.kernel.org, yuhuang@redhat.com, justin.iurman@gmail.com,
	horms@kernel.org, pabeni@redhat.com, kuba@kernel.org,
	edumazet@google.com, davem@davemloft.net, dsahern@kernel.org,
	Chris Adams <linux@cmadams.net>,
	Beniamino Galvani <bgalvani@redhat.com>,
	Thorsten Leemhuis <regressions@leemhuis.info>,
	Andrew Lunn <andrew@lunn.ch>, ihuguet@redhat.com,
	regressions@lists.linux.dev
Subject: Re: IPv6 address insertion order (was Re: [PATCH net v2] Revert
 "ipv6: preserve insertion order for same-scope addresses")
Message-ID: <20260602132118.GA508395@shredder>
References: <20260529112357.5079-1-fmancera@suse.de>
 <20260529134045.56330243@elisabeth>
 <ah57wxGjL7JBORR1@zatzit>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ah57wxGjL7JBORR1@zatzit>
X-ClientProxiedBy: TLZP290CA0001.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:9::14) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|DM4PR12MB7670:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c54ad8d-d79d-4c65-efc7-08dec0a9da53
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|6133799003|22082099003|18002099003|56012099006|11063799006|4143699003|5023799004;
X-Microsoft-Antispam-Message-Info:
	kSZHcM4dxWmoFxNRqS679vfp0r1IqHK/l34YcSzMicxSJ2UYcLWqgvc7G2zzTHItXByruuG0xQ0Hf2knSIBuAGeIVkownG4WQ5LdDpGUDbIkymOGo1SoYZ2G5P4qEg7XjRov8EgHwh3wypdmEPjMJyjA+jXfAWNBkC82Ljz1upQbv20tOuYtMOwhSW0Ky/kH/ck6Lokr8D+JJ56ORkmjQPbsALX1AWC14ZTRF491q8XG8OXL6Vg4Zj4fG8X4glwLvEW827EOv06xYl3zNHInrj9UlesG5B46giSMYongCZVVysUWRAoWNUU81YDkTV1xrDCef2q5NO9Z+p2EhyBRNabN8kZuJX+HpBQLfTT8xMzoDSK6EvEGYSrgyqv2taUo55CfgOcZt1YoFYVmLuRMnQQeQulcKxU1OBa4OlzJ6QXFm39FUmtAocVykR89seszTFDmsbk5/E/dFaDsHckFDtTna1hQLpqPyQTugOWl8xxakXHil+/DRoduR9QdN9JfAu77ClRrs6zzNDyDyvFO6KxhE0BYORnHxwELXRO7Soo/NXotsT/HZA7yTWtiM6ySkNEqxV6jLyqYTIhlT0atWP2N4+LZSp/GHgPoVJfPeq1JzDo5apq2CVMEMpwDjwGWQzeQ76T1WfjuIKFTGd2GrgDm6AwdNnrTm19RhIrrul07CwGjxiJ0CJa9PEswfDkt6SmOGbn243odzEPAm3uU7A==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(6133799003)(22082099003)(18002099003)(56012099006)(11063799006)(4143699003)(5023799004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5y9jUkO6Cz9bkH2W/xgSlvFkyCDR7BTEycm5dzw4rzU7uwGRmBju9YJPYymr?=
 =?us-ascii?Q?ld0HaptE0WiBd5LYRk23f39uTZFpSwnqta1st35N+A2lOGaZoW9fHVgr+buY?=
 =?us-ascii?Q?CiN1tgVxaALl+3g7QixGAbWqn3K++0d9kLHzimLqYiT+hLKF4PP9Wt3occcM?=
 =?us-ascii?Q?8DFZLz4nw2Qlj7oAw4j8B+f7lMpEnbkYaHbppnMs18ElY+gdW6ceNsmJtfLU?=
 =?us-ascii?Q?GP51cLOvNGv0kNH60tG7rr/2Hnh6M5lJp+cFEE/mi4Mtgi0xI/rE6hLB7mMu?=
 =?us-ascii?Q?BBXPIdHW9bXax2FWD1PRDOMGMKUO9tiBOnxnuAn8EEu4AlsttRuKqut+OOHf?=
 =?us-ascii?Q?xeutjkG/c1UFwL54/OgQTyAtcxpC5n+NGAvQNQRZGBTusH06dYdGJ4l1Ok0B?=
 =?us-ascii?Q?OgWTOgT9+TyJQ2IY4JsupmaoawcEgXAOPmcRGRJsyJ0ALQCMTcxtl1Nh5Dgk?=
 =?us-ascii?Q?atJWHD/PteG5tQBM0WM2mbY5CVRGdTzTIQax+eQngUUtPYw2MLUiANgECO7j?=
 =?us-ascii?Q?6ymzLBINk0pLc1DUOj2ouE8qpQswo6ZZuJBcPKv24Ge0uyTRghKQksVMss7d?=
 =?us-ascii?Q?KRdp9APavAdF2yBU6+lUyDuM9WqP/lT0QdOe9NBrUdl6Ip7SYChU/xv3L6zX?=
 =?us-ascii?Q?dBIgS0lUtL4FkEZYLF4dlDu7mrB+MSg08mlD2LhhKEUxYUiB92Y0TdC+MTkX?=
 =?us-ascii?Q?b3zX8W3Ga7o47Fwemgrf560z5/r2enzNc4Zd0rnQd0tyfWXkhdGWF74UPx6T?=
 =?us-ascii?Q?+7Ps9a9Hs0KfPSdQFSSvK/3ejFrST9sOprlNrgdEPUs36UdIUb86jldtmPUD?=
 =?us-ascii?Q?WBWK7MpKQtwF4F7UwRSVsRhOpJVfYCZyJ+LpCZyLEOjT/d+kpZlkGJ+k0OgT?=
 =?us-ascii?Q?ZGA8QYQQvYhVOMkUEWH2S+amtNKx1bHqQojBPbkMjIMrIRSBp0qUeRA4Hted?=
 =?us-ascii?Q?WTC8WORcOyB+jaUasYX13rJZN3uCIO7b31SttV2wFHU/AaTSO5GUqsy8gVX8?=
 =?us-ascii?Q?VPq1j2C3QU8kLgTnFiImjiA8jlt7+PF6f/Gbwz/6wTIgIuHyUKq1eLQjK4NC?=
 =?us-ascii?Q?0ZPZNmq6qVvHmFZCQTpFFZt8hp3O8W/3Q6r4XFpOKjmjAbWdoh7OFQHPB2+/?=
 =?us-ascii?Q?nKO11XWwKdGIp9KWKUJINs3z4gv9RNvTgCig5TniKSUvWVmlkpZSgBYtFz30?=
 =?us-ascii?Q?9BouXwXPvzMbTiYGOGEZhdZlIiRRDV2aTUoSiV2jmRrcGN4q4ROb1m08U0O1?=
 =?us-ascii?Q?f2zxzRgDlORNO3jQXBuBc9DIu+QFZxwC3Bn99XSXqrCb2Yz0yz83To56uqa6?=
 =?us-ascii?Q?S29ACs/HD8Qa3lWn0b935e10RZyUsj0XMDeIC/gr8NxdiJqxDSK0cTNNa35j?=
 =?us-ascii?Q?CGIZ4asgkWuqa1a27ygejU077MDRgDd/eT1FrLBlS85ojH1OLbWShSuOFKLV?=
 =?us-ascii?Q?NlbBG9Y48d6bC/zRAv2L7kyt6ig5611DDyfvuGqKEcCHuSIhdEntnqahoBoP?=
 =?us-ascii?Q?Evm3tojYVW4+aXg51wCY1bj+mQAzsvax2GR8Qib06bOmRBm/ErPbvD4FYlsq?=
 =?us-ascii?Q?3ALxD1LdRqVfkfr0oSxN9a2/FHd7Q7e40jb7wVkaBQbXYjMP956rCa5xsVGH?=
 =?us-ascii?Q?UJ9SKkuyZOsFtjwoxkYuiN18l4XqmirOtKMlOWUkNueHKBt/DF6DFWczeVFp?=
 =?us-ascii?Q?PjiFb2Hknsqtw+EUQGrVT1OssvsMxudQfTp0ZKnjcipAqUIU?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c54ad8d-d79d-4c65-efc7-08dec0a9da53
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2026 13:21:28.1257
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /TtzeIO/47gZA1qTkcABIjnKmJd5DTqgABYao64YkpUjdzcW7SP2gXFXlmKcV0kk/VQdtt58WPRJXVhX2rWdpA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7670
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-294220-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[18];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[idosch@nvidia.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:david@gibson.dropbear.id.au,m:sbrivio@redhat.com,m:fmancera@suse.de,m:netdev@vger.kernel.org,m:yuhuang@redhat.com,m:justin.iurman@gmail.com,m:horms@kernel.org,m:pabeni@redhat.com,m:kuba@kernel.org,m:edumazet@google.com,m:davem@davemloft.net,m:dsahern@kernel.org,m:linux@cmadams.net,m:bgalvani@redhat.com,m:regressions@leemhuis.info,m:andrew@lunn.ch,m:ihuguet@redhat.com,m:regressions@lists.linux.dev,m:justiniurman@gmail.com,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[idosch@nvidia.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[redhat.com,suse.de,vger.kernel.org,gmail.com,kernel.org,google.com,davemloft.net,cmadams.net,leemhuis.info,lunn.ch,lists.linux.dev];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:from_mime,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,Nvidia.com:dkim,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6D65962E758

On Tue, Jun 02, 2026 at 04:44:19PM +1000, David Gibson wrote:
> I get the impression there's a rough consensus that the best we can do
> now is revert this change (already done), and make a new patch which
> changes the insertion order to the "correct" one conditional on a new
> flag.
> 
> Stefano has enough other fires to fight, so I'm taking a look at
> implementing that.  Some initial thoughts, that I'm soliciting
> feedback on:
> 
> 1) I'm assuming the idea here is to add the new flag to nlmsg_flags in
>    nlmsghdr
> 
> ifa_flags in ifaddrmsg would be the other candidate, but it looks like
> it's encoding properties of the address itself, not about the action
> of inserting it.  Plus all its bits are allocated, anyway.
> 
> 2) Could we re-use NLM_F_APPEND?
> 
> The short description of this existing flag in linux/uapi/netlink.h is
> "Add to end of list" which sounds like the right thing.  Looking
> closer, however, it seems like what is' used for so far is things
> where the entity added with the NEW<whatever> operation is itself a
> list, and NLM_F_APPEND causes it to be added to rather than replaced.
> It's not used for addresses at present, AFAICT the list of addresses
> is a semantic level above the address entity itself.
> 
> So maybe re-using it for the thing I tentatively called
> NLM_F_INSERT_LAST would be confusing?
> 
> On the other hand, it's not used for addresses at the moment, so
> AFAICT there's nothing actually preventing us reusing it for this
> purpose. That would save a bit - we only have 2 general and 4 NEW
> specific bits left, by the looks of it.

This is not really viable. Even if the kernel is not using NLM_F_APPEND
for RTM_NEWADDR, but not rejecting its presence either, then we can
create a change in behavior for a user space that is currently setting
it (intentionally or not).

Example:

https://lore.kernel.org/netdev/27c249d80c346a258cfbf32f1d131ad4fe64e77c.camel@debian.org/

> 
> 3) What other things might need changing to take advantage of the
>    kernel change
> 
> My innitial testing suggests that unknown nlmsg_flags bits are
> currently ignored by the kernel.

Which is a problem... From the looks of it, the same is true for
ifa_flags.

> That means that tools for which the new behviour is desirable, but not
> essential may be able to avoid probing - they can set the bit and
> hope.  I think that includes passt/pasta and also iproute's
> save/restore functionality.
> 
> That said, things which might want updating:
>  - iproute2 to use this for save/restore
>  - netlink(7) man page to detail the new flag / new flag semantics
>  - passt/pasta
>  - network-manager, here we require the exact behaviour be maintained,
>    so it would have to attempt the new flag, then apply the existing
>    workaround (reversing the order itself) if that fails.  Maybe more
>    trouble that it's worth?
> 
> Any others people can think of?

The safest route is probably a new attribute and a corresponding keyword
in iproute2. Note that new iproute2 versions need to be able to work
with old kernels, so iproute2 cannot use the new attribute by default
(it will be rejected by old kernels).

