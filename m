Return-Path: <netdev+bounces-304766-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id NU5XIiFBSmp7AAEAu9opvQ
	(envelope-from <netdev+bounces-304766-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 05 Jul 2026 13:33:53 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 75FB4709D2C
	for <lists+netdev@lfdr.de>; Sun, 05 Jul 2026 13:33:52 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=QYnMdMyH;
	dmarc=pass (policy=reject) header.from=nvidia.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304766-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-304766-lists+netdev=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id AB79F3002B46
	for <lists+netdev@lfdr.de>; Sun,  5 Jul 2026 11:33:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61E0E283C82;
	Sun,  5 Jul 2026 11:33:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010051.outbound.protection.outlook.com [52.101.46.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11618433E74
	for <netdev@vger.kernel.org>; Sun,  5 Jul 2026 11:33:45 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783251227; cv=fail; b=A+FYU/jZe7C45IDkzspOrpgdcrlNfcSkuoRHqnhRK6yn+D/8V2Ig8o/Yd6vKpOCHBjc/6/MV/BPh45Ae704IzGRh5x5aEYJW+AYNkVPSjMe7A83zYE54RUMzKArjVMthLyLIjWGiHwSQ7pgbdTurxwfBhGBfKcBU7qO34eYb1Uo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783251227; c=relaxed/simple;
	bh=enU9Kv1Jh3dW+j6t1GmpoYyckH5qY0ZNBSueGh5hU/g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=WgD3ey/PJyAN6CmvzCJ0aeIOd33CwDWnJ6YhBgozxuMBZp5nwSp6ALlpAM6tkOyjKCAfMSmGiDfesflmAPeCbTlBQ38ZAIcDdmPSAC9TcNifnCJmPpHlpkjYImOT6+3k54sDF2p171BhF8c/3tp1Eb+HeX9qpTNeq6N6BZTCMRE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=QYnMdMyH; arc=fail smtp.client-ip=52.101.46.51
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hJxdNokH5VgDipIvWodwDZoURzHg/lg+0k8Y/XooRd9h5z55polcqQZ+q42JqKrlcIPt2NCzn0RiFsD6a2zCDMQ1Vo3ud2J6nDbJkvbK2Dd2gTV4lTZplccwm0vH63wsOCi3zr3O9vXbwblIAHkJqL2TdWfZ9AL9BhBXshnxgAwDemwnOZnjDp27+gesgtrhO8xRgLCu6UAh3rg9OCLqE7CNat9wB/zx53/7wYflZi5X14+OU0uFf37k9Or675C7PQtQ/L1wpF7ZADQ7s0Vfu610qajMeXxE8I4mzT04FZ067hgVO2SOY0X+BUAVOuXkfxmi6rQGsn3wzYL+PXXkew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EP1XobODemv5ttG9L2zq+qfcE6eOwUP1zx93Mm05zjk=;
 b=wFtsHsKtNQJ8hDTXHR0kuCe9JVOMA+w4zN58K4kblxmJScUzkSm0pjIgqzlRlSj2hJ4fuJIDRPsigKqn1fRNuDkzr8dgTTjHeV0iNagHegZiaiVFgXVAgQoGSJeHSZRpi7P1R1eXxBjfJF0v4zB1I4uuusTYtBo7LOZRyIzTQM5TDaxwsk28u4MRDK4SFJRViBddxw77oyFTMaCm0Pif7g7MTS/SjU8c9qvuBJJLDKBEKO6hbkh6QjirezVE7gRg0j/zkfAQDU4g/3VSHF5hKe23n+3rVEAml7anhEV/heBajVu3ujmCvmO+oW+vJYGDaNxAMt5NVE7mF68JZcgQdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EP1XobODemv5ttG9L2zq+qfcE6eOwUP1zx93Mm05zjk=;
 b=QYnMdMyHx04CaalUEYVQSwKxcm2s9e6Hrf84K1nE7uJHuE+zVSQbYBDgtl6lNAZHudGoG5moNgvN6yKRtBVlYxJfzxHwV02CKYLz8DVgC1yKAA3eaKxfp5RPRA2wWlLArrFn+2AmOSdUCBsybJoh1SCIxlhq7/HfrAv5owrfdVjsJcSxcbvcG78IqqFKXVmPrMM1Ss/WvLXriIzsRcixWPHM605rc7WjyEGVZUPHmbFdWwPUTyAP6lyBigj+IZjKxNVQlmrE11vabHXX8c9+2RZZJCLfOVSHOZTBu5Yfo83Evirlul7qVPiQAzlC2PSJkkSDHiyFmpzbkYZ4tr4wbQ==
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by CH2PR12MB9517.namprd12.prod.outlook.com (2603:10b6:610:27f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Sun, 5 Jul
 2026 11:33:41 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%6]) with mapi id 15.21.0181.010; Sun, 5 Jul 2026
 11:33:41 +0000
Date: Sun, 5 Jul 2026 14:33:32 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org,
	eric.dumazet@gmail.com,
	Zero Day Initiative <zdi-disclosures@trendmicro.com>
Subject: Re: [PATCH net 1/3] ipv4: igmp: Fix potential UAF in
 igmp_gq_start_timer()
Message-ID: <20260705113332.GA194488@shredder>
References: <20260704194346.4065071-1-edumazet@google.com>
 <20260704194346.4065071-2-edumazet@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260704194346.4065071-2-edumazet@google.com>
X-ClientProxiedBy: FR3P281CA0191.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a4::9) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|CH2PR12MB9517:EE_
X-MS-Office365-Filtering-Correlation-Id: 474dc360-b27e-459a-81c5-08deda894358
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|23010399003|366016|1800799024|4143699003|11063799006|22082099003|56012099006|6133799003|18002099003;
X-Microsoft-Antispam-Message-Info:
	/n3iagNDzbVja8NziVHbDv6XIybe3tRD7cYaMQjuK3uxKQwEK6HTMoKDWNKP67FLwiLysxRf76P31bGvlvCrlo0lc8H+tQnjPv7E0PvhMlPYsBEFkNJJreAGWZe0h/rHLxuPyr2qBPbxf1/YHrcT9fjvQ2iSJbGljkIQzP6qQ+Wo2NgxtlXsKl+W0v1Z1zP2Qz8b5SE8vFnzMXy/Y8YlKlCkkgViOmcYI+Ys97gZS5J/wVe4i9dSP6A3sl0qEyxWBJH9tnJ+cumlZq7Bqh4Ys5JrIsy++hCeCTNzn2I6z5bv/wApn6iy0s8IAthhrXw+che4SH+WkroCB6jJTEvsZ24AQsuOs9Dy3kzKfrPlWzyWFe2cOM2ae/L+WWcTNdvdS728dU/DGFeCophHYxic/jKS2tw4fg8upl01dzRxt/3vZo6Fi4BW0NmnWJ6h3Aujlrl5NsuXVnVf7PcgS0izSgINZSGbB6AnSS95ciQczTSa3WwkMV/jdfUmMFcJGvAtHh6RLBs5qnpydoeW24bzWVBbKmGUI9L9TNZYwHCo451a7Uu5gv4p8RzAKU3ptutXrwi1PF56bFz4cVaFP5F0ks96+vx/Q3GZBCpx+QYw9HuYIHo7u/kaicHnNDegRu7Jmy8Cul5LZhClIxDrkAkPWAFIJs/sxSUD8uMpX41q9zI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(366016)(1800799024)(4143699003)(11063799006)(22082099003)(56012099006)(6133799003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?sWKnL3NAHuveFYfeKc3RwmaYkGirg5EgGeanxrYg0XIPqJDsyGZtLHTkXJEI?=
 =?us-ascii?Q?g9TrAwrr9i6fqlVPWkl0b4tkZj/wNbTDENBgRjyM+QYucs4PRj/OJdbmLbJI?=
 =?us-ascii?Q?hIxJK/fx3WsUY6f6QmHMvnSlAeoWwBvxLY+IwIsFDekaoQTXHtB2T70igPrF?=
 =?us-ascii?Q?jed2L5gd7u0ef6AXP9evdGxvGXCrUZPm6XIf9VUiQCSfNUhxL85VaT2JkLio?=
 =?us-ascii?Q?FrbH80FWct6J2IimU9KgshwN7YsIIzz+0hxCzhaHMs4RHlOyVXmXHtwuYkiC?=
 =?us-ascii?Q?9P+6ChKwkalKuolQL7qiE76tVPzK130T5ptAwC0ZS3V4jy2uBgLKBeEfy+Sb?=
 =?us-ascii?Q?XTRzP6npTWP+iuwxfyvvlpnoy/jYBShP9Td2iVTDUms0GV1LupuNFn0bV8n5?=
 =?us-ascii?Q?veskckJKtmXqhXteVbJGidIkJFnNcwnStDqr8LPyEMNZEyjLrw7QDLjzzcOg?=
 =?us-ascii?Q?ffngPLx0iq0Q/CxDJ6ye7D4dhA2JKUy5h69jnWOoxrUHm+sKMrC8s4j0altz?=
 =?us-ascii?Q?X2h1CFUuMQGkG00QKVE28AK0WhFHdP1pc+Nj5N8P4CFULDxxjV1HTtC0kM0n?=
 =?us-ascii?Q?ftYijGUVvpc/OvXkJhNmEtsSmQkN4hh7aL/QJyHL8ey6Z3RUuPpPTZyCC9Gp?=
 =?us-ascii?Q?zqB6MbtYMa2+6Els/TF2uQ1R3/N9eJNqpeCWCSwZAcTFS86pn2ZwNpJyK+dB?=
 =?us-ascii?Q?liKQp/jvc2ijK1eF/Vdv7+/WMxyrN6mjhgx4JL2+2X1yAkG94fJngceaHnGf?=
 =?us-ascii?Q?XMscS36nBNsoA3lWAa0ZpTgePp+0DE72H6b8SMLr1N/X79kdZCmnuJ0X4MeQ?=
 =?us-ascii?Q?rC8ZoaRXizWrwi/8nDvKSd7xdGm5adwOXTAj/tqCzZzaiTG4a7ynFGowZ79P?=
 =?us-ascii?Q?pOaErL0IK4aG5BjkHJkqQ6rgtgDs0pDr6KKdx3UxfqZIbUZlaRc2wrFIr9lI?=
 =?us-ascii?Q?ndBvoRtcMjIXh2CITU8O8giTnSTE6OsujbO52b7wTDvmcgEKlRVoxUQyhrXt?=
 =?us-ascii?Q?SIJ8s511LywQYXDHcPaqjANAKqKI23UQVJ+I66ZPqcSltRDVxGN7ySEG5/Zt?=
 =?us-ascii?Q?Al5q0Y8IgTD+2uwPTDelJu1CFrYiSB3NcP5Io3FJs/6GFItD3G+SEvZ1VE95?=
 =?us-ascii?Q?6drpEuHmKJFloAtmciSbXc9qmtm2bjpuj1tAEXhae1+XMiwUwR25GoOFdogh?=
 =?us-ascii?Q?pEU/CGAb5AURuQcfUu7WJFae5Yvto4/TQVoj1N9+r03UCchzzErBOtITwFXs?=
 =?us-ascii?Q?5PVNCuqiVq7FIke0HBDE+vrdQSbNYWp6J3Q4iL/wNr2hx8rm+0XeZhke+07v?=
 =?us-ascii?Q?IV4MBbSfnnCk10vHbikifD55ppfVDpRzrGeZ4ZgQI4MZIBl+NzPY0aLVyFDb?=
 =?us-ascii?Q?VUgXkcc08RSJ9v2W6YUcZZTVyruQ73l9FZlFih37c1z6uo7ULd9eIR7myUii?=
 =?us-ascii?Q?PqsMhkMjShdRVVO6rrC+K+T7iwDHbInJ/Y3YwBrexPxeWk9hhwNmdUQQOslU?=
 =?us-ascii?Q?+RwoHvm2afXyJqhAB8FtM0UdeaMN2MLCCCTCl/P+cFsT/Z/cI0c1ArUjWJ1G?=
 =?us-ascii?Q?gbtPsVxaSVJE2DBYw0xTPoCRl9bIuwVZD/cBa0V0k6SfpeRbigaALjUYvbpz?=
 =?us-ascii?Q?TlIzJeOuw+D3r+Z5hCwgKABkzVP6jqUsWVoKBp35+ZfegE25dsVv0MikuvKV?=
 =?us-ascii?Q?p18QOyaUL8OWDVRpGXS8j87CgDx6VxG3o0c4OzBnqKItQGrf?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 474dc360-b27e-459a-81c5-08deda894358
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2026 11:33:41.0539
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mzFSHy1gqeqrbixNiVMboWwK4YoKOMQ9tbT6L4BKYWD7fQi1xlnHY04eqIwyZq7SN6AVEsTGcPnavwHTpPcoRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB9517
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_DMARC(-7.00)[nvidia.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:edumazet@google.com,m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:kuniyu@google.com,m:dsahern@kernel.org,m:netdev@vger.kernel.org,m:eric.dumazet@gmail.com,m:zdi-disclosures@trendmicro.com,m:ericdumazet@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-304766-lists,netdev=lfdr.de];
	FORGED_SENDER(0.00)[idosch@nvidia.com,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,google.com,vger.kernel.org,gmail.com,trendmicro.com];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[idosch@nvidia.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 75FB4709D2C

On Sat, Jul 04, 2026 at 07:43:44PM +0000, Eric Dumazet wrote:
> A race condition exists between device teardown (inetdev_destroy) and
> incoming IGMP query processing (igmp_rcv), leading to a Use-After-Free
> in the IGMP timer callback.
> 
> During device destruction, inetdev_destroy() drops the primary reference
> to in_device, which can drop its refcount to 0. The actual freeing of
> in_device memory is deferred via RCU (using call_rcu()).
> 
> Concurrently, igmp_rcv() runs under RCU read lock and obtains the
> in_device pointer. Because the memory is RCU-protected, CPU-0 can safely
> dereference in_device even if its refcount has hit 0.
> 
> However, if CPU-0 calls igmp_gq_start_timer() and re-arms the timer, it
> attempts to acquire a reference using in_dev_hold(). This increments the
> refcount from 0 to 1, triggering a "refcount_t: addition on 0" warning.
> Since the in_device memory is still scheduled to be freed after the RCU
> grace period (as the free callback does not check the refcount again),
> the device is freed while the timer is still armed. When the timer
> expires, it accesses the freed memory, causing a kernel panic.
> 
> Fix this by using refcount_inc_not_zero() (via a new helper
> in_dev_hold_safe()) to prevent acquiring a reference if the device is
> already being destroyed. If the refcount is 0, we do not arm the timer.
> 
> A similar issue in IPv6 MLD is fixed in a subsequent patch.
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Reported-by: Zero Day Initiative <zdi-disclosures@trendmicro.com>
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>

