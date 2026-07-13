Return-Path: <netdev+bounces-307142-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id /6PLOM/aVGqafwAAu9opvQ
	(envelope-from <netdev+bounces-307142-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 14:32:15 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E1DDE74AF7C
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 14:32:14 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b="Hw3QrDO/";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307142-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-307142-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4BC55300AD65
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 12:24:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D7883BBFBA;
	Mon, 13 Jul 2026 12:24:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011018.outbound.protection.outlook.com [52.101.62.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 320312E414;
	Mon, 13 Jul 2026 12:23:59 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783945441; cv=fail; b=jnuNU/ebECrcspoOOXjl8un0HQJ1tvaChq/mj8GpUG/wXPruQvq7INP+O5rkWaXGG+Fd2Ukv1Mf9Oj53opA7QKPc6Q1soxs+wVMLGeB84L2+zL59HKIdnf5ynw6bH8V59M+PGJB5YyO5YnY1fsZaHSwGyTlPTl1LOKfuMGPWbeY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783945441; c=relaxed/simple;
	bh=XQzL8vAkuV6tPraSLZPl0bRUpANrWo2Iw3baZgQVOYU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=BgmQx2WXE23ed/z0c//xGoc7nYPc57jITFK+IppHDVJEWSeemg6bKhkoCnn+JvZ+hJTowBMbowxqEtX9AdJSRCzQTzAJ7oVHBiZd+qEPZMZK0rafLWTPOF5qjqo9VZP1bkn6ERdi7pb/iZVa2eA/gZo9qr77tb2aI2EwtzXZnDI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Hw3QrDO/; arc=fail smtp.client-ip=52.101.62.18
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FdNDUAHlVdEcStnycsv8vaOARqZ8idJh2VflzxzqqhTPjTVCQXwJLcHzOhC3fzcusARrHSG0qTuCSdR0KXQaYf4su1lFFG6CmozQPfdbNH7p4cm/7l5tW0RE4G9yNy7BNiwwnMuWQVBguBxp+0QiKXKs+Gvw3R+sBnx3gZPGcjDYzx+alCkRIfPojO1uLC0ErOiLPAugR0J7Zf7BHeEvB0PhAVaNBMm6DW6oanNYpuCF75dWdkeKi+8Kw59sTl91zxjDYY4HhOa/FYyJd8aymyy+ArLpSpQrA8gEAoKOLxkTVZ6egv+x2K2oPrZniAhmo2BoxIuty0qVoj5o1B9oJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kajdhxabYxVE93f5Jw711hrTUl4X2MzCH3HJeH2YASA=;
 b=uT6VE7OHC6i4RG+xl7JRUYDyjyCPxDRfP6mtpJaH+tWZlPcYs0sm3w9b4Nie6feXcYdrHYrsa3BdAloCPAjO6ryAF6AqcHkoIiw0ng3eb3d29COMZTL1/jO9xKkZ0OWQY9PiC+yZyX92Jk4oG5wBEy7wskOt/IM5ytrcNRxGMmrXBD9Gm/bTKc3xZT6eJrtaSa1LrM8/mPabGQCNE6Rl7MO7nvpoiFRMsp/x8PqprBS/jgNtnKyqxODYmKlTbQ254ZcRcn8/qEdp2GymvmYwk1ssHKwNIOix719SMG78ToM84m5tfvLJGUFZI8I6BM1aFdPh8LdGf+k7LPOBhh8RJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kajdhxabYxVE93f5Jw711hrTUl4X2MzCH3HJeH2YASA=;
 b=Hw3QrDO/GvFqfYXHmw9ERUa+6c/1ob6Mj7j3nT5tGuDOl7ZoYWOoyM9Zj59fTKrbHfnXLIeMTwIYa5JcKOu3O9zusyqRed5zIEt0TqGWCrrtQcGXkoGGT6eIKh24NNx0J9gtU3TMPfafexfMwZoks7/wLBffTGGU6SzXTH0L63UtpOm/e2pY3QRqu+f6A/d15xHyPCtINb51/kcGc8XFG1A/bctdV4bu0Et6hHg7pw6LV1GV5iqdQkQNucK5vQJtKvUjyv2My3OxwhNbksEhdr7TCUfFSYvCtw5byRAInrL48SjsZWgQ4dav60ZcJaI3cgi543wX46MQn9Oz3k9OyA==
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by CY8PR12MB7172.namprd12.prod.outlook.com (2603:10b6:930:5b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.19; Mon, 13 Jul
 2026 12:23:52 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%5]) with mapi id 15.21.0202.014; Mon, 13 Jul 2026
 12:23:48 +0000
Date: Mon, 13 Jul 2026 15:23:39 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Jack Ma <jack4it@gmail.com>
Cc: netdev@vger.kernel.org, David Ahern <dsahern@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 0/3] net: nexthop: per-nexthop UDP dst port for
 fdb (VXLAN) nexthops
Message-ID: <20260713122339.GA548566@shredder>
References: <20260712191218.236-1-jack4it@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260712191218.236-1-jack4it@gmail.com>
X-ClientProxiedBy: TL2P290CA0002.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:2::12) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|CY8PR12MB7172:EE_
X-MS-Office365-Filtering-Correlation-Id: cde293c8-49e8-49a4-a4ea-08dee0d996e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|7416014|366016|1800799024|22082099003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	VOYvWWL6hRGvWoppc9WWxXqdj7LGm0lSIA+NopCx3ryEo9RohwBWMmhWrbvgssy3GjqU+30ZevS9vySG8r58lXnPGzJG7+p1LxqC/rUQC41B96HwUIfiPWJAIUWCY6eCEZdOMq1j94aogCFfbQNCzlrSmj6mYo4KSZ7XQw41fz4up/3a3ZC5mqRexfpaECuze2zCaACnhZ0oVXXFNvaEh6E8IRonWlpuY8d9IML7D7hf5dHOb6kLSxNB2+08KSA+UD5fJyDUs9CgPlmeZossfcQ1hK/sLYsUkM7mSqzkON+pzGFlSPa5jEKRLcI8yhoKfOvpZQE2YJhHDCSp5eZeAouSQ8+zGH0fDIdlCWnmnbk9DxQARQXZakBZVOqtBOnJVOMNUgZAz04T+sqhHABFqsDqcbsVE/ry9HTVophp4BKE310EARlXdcIZih3cE6wRRyyGsRSCm7TkStusR3k7r9IrU+F0WSxP3O1nhAG7wZVZWZQRWd7Xt02MXF/aKj12Um1FLRj6EyxQG6xn7+Ux/DPtVALnGiaS3jyRVEhszWm1C2Ri76PWAbxqvu2h2MyzY/jdXu2b8jQ6JsPXtcQ4CeXszoqoQVgqz+0gCv9ogDkmGa+koRHjggiJvFefTFLFeMEWtWeDoMhYKEqrP3dW+tZwyXOVORZaGTAkdP4zg80=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(7416014)(366016)(1800799024)(22082099003)(18002099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bLYnzMBDZYVfFkE4atc8+B9SRQQM616Mnz1JaB2Ldrl3HlnoIzVu37+wzlh8?=
 =?us-ascii?Q?gspPzMri0dig5iOIs3wib2dOOh2PxxwvKCom6phYWxFOLfETmxe/qDJjSDQY?=
 =?us-ascii?Q?W2eHZptk0xod68y1vKXjdxIhhysWoJojXF3IRuTrD2VgGMnq2ECzsAk22DBN?=
 =?us-ascii?Q?W6taWB4WflkxsYqfiNuYgA6xPgj1mMfYvG+qMvFdk0KTLoaw1FmJhcXr8w5Y?=
 =?us-ascii?Q?yEkpUZK7rEoUZtw58jUfx3Z1X80NiL4lESsDW7UE5rS4IXS6ZefQRaxmJH3N?=
 =?us-ascii?Q?aL7qfVZT7jXP3HYkVGLMES7te/Mjf77BRWP2UKiXxFvjFDzbxM9NMIu7CA/q?=
 =?us-ascii?Q?NOPAn6zMZ9Jz7XlWS3q03QteIjNXq3Zr5InkX9vTMAtdGAkD0QX/YuVBXj0U?=
 =?us-ascii?Q?A88RwLMg7FbbnYYQ0cA57VtIyi/b9aupdsCpRwTH1ANNSaV3Kg3gcON+TgSH?=
 =?us-ascii?Q?nfZMyR8CpoQtzjxNtgLLzYgz2HVIEwGNOP/uszJtORpY0xhLpbm5H6MjGfRM?=
 =?us-ascii?Q?g4UPc/B287/h0wfh+c+r//ltE4AJCuIxvaUCYBMSUKacRKB+Iqil5qP+wXf/?=
 =?us-ascii?Q?Zms8NjLZqH9g0vL8xeH0OgPShZ1NHyikH2qtaGnt0Brdgp1ZxrEGqFcQnPcf?=
 =?us-ascii?Q?++BVkahITuJqp3njidrbxrF2aC2p7WPH2akBxJSwW4Aaz6rpRAH8teX3ec9r?=
 =?us-ascii?Q?xZ/+FSIuL1CG+K5KCQaOKegg42iB4oGGHlLmn7ULp64yZKyNQThAjXRhJEzY?=
 =?us-ascii?Q?NgHa/wR6qUeVgnqHPFTjtR9avF/2HSBT0b1AiQR063588jxM2wlwQAoOGBTt?=
 =?us-ascii?Q?csTQ5D+zojOTvIdiyN3p9EBJzodkivQPtjOZYAS2ysVY6G842uaz9X4nSwn2?=
 =?us-ascii?Q?3Mk2Xt31rC+6zprBjfGQbQfAVNNYntuSrSOjCMy6YcZ7G22Fy6BszIl0j3Ee?=
 =?us-ascii?Q?+U0lDCbMlW8R13JEj+VOdY3Phn/UADVCIRiSERzWLqXFGW0ZILSXptEPgDDF?=
 =?us-ascii?Q?VGxnW0KEvDaWZxV4QvTTsB6I7iv2W0lzafRw0W/u9t6+k27FS0U6Q2N9guk7?=
 =?us-ascii?Q?o9+fnfOhtu4EEhHhxqGGJtApPzBzJhuJ4GXgf3p/RJwy6VNlMLET0A7TPHLJ?=
 =?us-ascii?Q?bUPBnfP34vTKdBObE2NZpujtAZm3WGiR8fqJ7dtn68ZQh/WnKb4458zBej6H?=
 =?us-ascii?Q?OGoBWS6sm+NvDqQVmvatu3wuk5CejrSetn0gG6xZpaAb816q2mT9whHWY4Ld?=
 =?us-ascii?Q?diH/hG6hNJ5y7szoS7GRsHnD/t8+Kl8HXb6E+/F7ltU3XpGpdSCjLy+R0dQd?=
 =?us-ascii?Q?IJIYyyRUq+PCFlK3HbPLaHUjp2nQpHJxBDO+ZdEaB4vKTCX5uDr4yq5fnUfT?=
 =?us-ascii?Q?+nXNuBvZfeTwRQoLrdtmu25CBu2n6G6siI8+CNMiohoMpT5oOUq6SXRPV0Ht?=
 =?us-ascii?Q?Xjb2GqW7aSraUQkmLgJQUS+TlbpG6I8hRsw7vPh3eq50/638M2upDRZZeY4M?=
 =?us-ascii?Q?2FoOJC12sws8UyxvQNJlA9FGZ761kYugy2WXjgvpWfnjxZkjYUO2b9wJy85+?=
 =?us-ascii?Q?ds3idZt46rfvRATD0t9IosP7xegBWWa5T4SiRmJa1yidBJ3/0KVcAM5x/qHh?=
 =?us-ascii?Q?61y7VDF7KiC4aHkad5I7GvnNJQnLpZ45ELTXSFfJGEhYgV7Z8OaXZnLrwjQq?=
 =?us-ascii?Q?3HVLFvRRjYyya9TTbMnXssdMUD5+Tf+IjZ+Vf7rOETNAu1Ww?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cde293c8-49e8-49a4-a4ea-08dee0d996e7
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2026 12:23:48.0312
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ln3WAuxgzlxeUZnpfzZXpwymMIHoS5b10Kp1AkqNGZjIMbGTLCq1djgTDUC5S9SVZIdPjCJNfL1RBJ0ESEhkeg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7172
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-6.66 / 15.00];
	WHITELIST_DMARC(-7.00)[nvidia.com:D:+];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-307142-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[idosch@nvidia.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:jack4it@gmail.com,m:netdev@vger.kernel.org,m:dsahern@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:shuah@kernel.org,m:linux-kselftest@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[idosch@nvidia.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[shredder:mid,vger.kernel.org:from_smtp,Nvidia.com:dkim,nvidia.com:from_mime,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E1DDE74AF7C

On Sun, Jul 12, 2026 at 07:12:15PM +0000, Jack Ma wrote:
> FDB nexthops let a VXLAN fdb entry point at a group of remote VTEPs, with the
> kernel flow-hashing across the group (commit 1274e1cc4226 ("vxlan: ecmp support
> for mac fdb entries")).  Each leg carries its own remote IP, but the UDP
> destination port is always taken from the VXLAN device (vxlan->cfg.dst_port)
> and cannot be set per leg.
> 
> Some deployments pack several receivers behind a single underlay IP and tell
> them apart by UDP destination port.  To spread flows across such receivers they

I don't understand the "tell them apart" phrasing. Aren't all of these
receivers interchangeable given you are load balancing between them?

> need a nexthop group whose legs share the remote IP but differ in UDP port,
> which is not currently expressible.

I think you will need to provide more details about the use case given
you are asking us to accept new uAPI which we will need to maintain
forever. The FDB nexthop groups make sense when you want to spread
overlay traffic between several distinct VTEPs. In the EVPN-MH use case
these VTEPs are different TOR switches. In your use case, why can't the
load balancing happen at the target host (e.g., using XDP / TC /
SO_REUSEPORT / flow classification)?

To be clear, I'm not strictly against the idea (we can talk about the
implementation later), but I would like to understand why your use case
can't be addressed using existing mechanisms (or why it's undesirable).

Thanks

