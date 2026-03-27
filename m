Return-Path: <netdev+bounces-272627-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cHORCPjFxmm8OQUAu9opvQ
	(envelope-from <netdev+bounces-272627-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 19:01:28 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 91304348C76
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 19:01:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 768393068276
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 17:54:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 647053FEB15;
	Fri, 27 Mar 2026 17:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="cP7N4QU0"
X-Original-To: netdev@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010040.outbound.protection.outlook.com [52.101.85.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D5C83FA5E1
	for <netdev@vger.kernel.org>; Fri, 27 Mar 2026 17:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774634084; cv=fail; b=M2Rh5XWXQBxCrmI+s0c0huxfTl3hntgf/xl9g2Y6hnvU9mmSNpHCyFB5/Eb7Z0fXWwOwXjVYF48EV57HALvtOxBHjpcfiS88Pl35EvXZ5PC0FYGUF2sV67h5bpSJDHWAfcnp4pJIAJ3amZmx6G60XCTlbPJ0JghIDmMztREhyPk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774634084; c=relaxed/simple;
	bh=KcpSmRCjarAnxHIXKKHj1q4hHtXUnu4fpGkwoJynuAI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=PG9XOzinPhyaWrlJUX++yzAPBe9+mYENuO3Zam0actTiPJ3FPvtdiUIEyE1IJpSjS3MX3MHuuqxvKpKaT6flq/6wuSSSCK5aZRQiTQvhLGAwqO01mu+0DeLm1LDTQlwUepGjzNOebLvgXal/a7VPuSBnZSfA7wJt2gQ0mV1b6AY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=cP7N4QU0; arc=fail smtp.client-ip=52.101.85.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bNvI3xsMPGop8U+dy49peDxbYU1OVaqhtc/DNMZNZZSliILqbr6wbG3mnN63o/BzIIlWDUGMENZngNeqeJ2lgJqtpAD/O/bNSGkxHkeAH7cDry/NFMLgXZDJ4wrziT11BZ9/8Cg1eLz4Fmv7cX2E1NIRa03Rn5XytWT80kTmYZFrFN3sDSo5XkHoPR4iNp5HtJez7hqf7tNygu5fihHk2SfyTlnsEJ2O1CekaKR8AqrWbijRFeXiIB37pwqsHwNTVVuwddZIwy/jf7dpLga4hgFkpp5jdLMLJ73sl83fDI2INElYe7WktbL4ii4TxFo0/4+z18FeTg0F+zxRRexHIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e9oQfE0/sy/F72xD1K+Wt7QpU5zhlZBE4zCE2wkQ1Iw=;
 b=jXOkYDAYsTrxYkk+jaHgdgNOgdBFeryRKQ5Pj8G4G85KR8yFpWSBYOC13LqKP3cRiPKNQ+cT3EECIHDleKP2nnanYbAMxNlmcH0i8ldKFxN5xKZR1OSoSjVL3+j2EqqEoaDGxu75DImGgOWouezQL3yi7uLRuWkp12P3sa3yiYdHbiV4639CQMPPjPSS5lptv3i9lT8947TWDHLJaNv/PDJ+L9Ajvpma14SOajisar+VrrtMQnB0auZrgIhBAT5S90RHTNGYilvjQB5ftd0Mc2h4JVlZWTPRW5178uxKVQNO8Xkl30SpH2iu94KGNSmamQ88eLEyo4R5y9ySl73kaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e9oQfE0/sy/F72xD1K+Wt7QpU5zhlZBE4zCE2wkQ1Iw=;
 b=cP7N4QU0Z3PC6SMQsp0rN5uKpPUXbyZZoh2IeGm/YTPUakJy5w9pXQ6lYF9RM4C9SbzS8WHWWDVfhFtao/Y7wqKTiIvxvib9kLMWS1jtmn6Y9E5oKGviNP3ZVIvkvGhb80GekkrM8csepxJqlChK9NvfLn846/eXlQTOlne+2vztkhM3VXOslKuON8Nwc/Vs2rCfNFtFSStxyG7mxqe8gT22+yyRMC5YD1CCgb1Dj6O4r9c1dOjlsepD0uDXFyMP9POn5/9a1X0QGESGBbqfxOFCZNIk86vVVx8eZRrycPl/ODPxcdf21vx3enVVGq+qWAGw3VPot5u6UnPyVxsroQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by LV8PR12MB9617.namprd12.prod.outlook.com (2603:10b6:408:2a0::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.8; Fri, 27 Mar
 2026 17:54:37 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%6]) with mapi id 15.20.9769.009; Fri, 27 Mar 2026
 17:54:37 +0000
Date: Fri, 27 Mar 2026 20:54:28 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>,
	netdev@vger.kernel.org, eric.dumazet@gmail.com,
	Oskar Kjos <oskar.kjos@hotmail.com>
Subject: Re: [PATCH net] ipv6: icmp: clear skb2->cb[] in
 ip6_err_gen_icmpv6_unreach()
Message-ID: <20260327175428.GA1152445@shredder>
References: <20260326202608.2976021-1-edumazet@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260326202608.2976021-1-edumazet@google.com>
X-ClientProxiedBy: TL2P290CA0027.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:3::11) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|LV8PR12MB9617:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d228505-da18-4d04-b284-08de8c29e9ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	99FyW0PkrsLemKBN+TGOMjAp5Zm1D+3qFWGuNxauw9gHS62tqXzSFejeadQUjR8JETBfggU9W32QVrIqzSKFVx9diNW4IWm2zQuk/g5UbNpBUkSXlh+Sl9/+SSGMoGtbnfDAc0y+qVp9nH6hk3sJPP0R4zJ6Rx/o29A5zdmVwEYnSXeSdmvzSqy/shddUvb84U0s1nDHUfDwwoX0Ny0g6KYyqOCnfP6F2oSFgH1L8YpCT0hQUFNAI1TW4h5dSuTdsnqOtH6FqmdqUrGaX6h3FHOIxqgBe1x1i6/AIuxYfSOEXaHgpYOdhOPVDLLi253y6fdCunamtI4cW1Pi3EELxqeWLJuNtL5G9cFopoCFQ3ZEfGj7TCZyaRpCaGgHGTcBVoFXyAhR4btCmOM8tZjacFr++c5k9uiw26dTKsaZbIYZ3tJgqO+3hZ5OI851FbIxJXOo8gBHx7fjIs6lUiMFJZz9K5pQ7NxPG+AqBPaM82j39ChZ3HwNp2ybjXdps04vARjmmJiwILiuMts8BYn/7U2ipvKS9mgqZsnFqX8CjugNs2V2aP8yGfPCeldzSa1v4LcaCgk2R77dbNoIK3VMbaqSiUNTROple/fp9KcZwxV6+6PujklN2ncyxxUHDV1mFnCXSBUmXvYkkEN+Z5/XtXpEU3WL8RWCOX7+bi2cJyfg+4tNt0vKYzXuN/0ClrIRsO7JPy6JPvALw66GBlkvz7/uTHxgy/qJurodqAdPKHE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3r9p18+GMKVGelxsOc+ebmkkRC/59T5pJxc1txvu5EVwmvOi9iF/M+qSYlMF?=
 =?us-ascii?Q?fcQJXDGg//RoQcaZRsjDHXeBwcc5l2iw34o70nXjhS6lIPlrKhD4SOGzUeuj?=
 =?us-ascii?Q?8mNvCfANlP7raTngvDhGt6PfFy8bCbHqc5fMbMAzjjk5rkJLJ0/ZGHk6ZJ2z?=
 =?us-ascii?Q?lnkrk3MKXsIqanmrI7ON54iBwCVD5DUA08pwMT5QWfh/ZDl285GXlFfKPV4l?=
 =?us-ascii?Q?iq1X2wSw7p2X9cdpNW3MhCYHSIb/wnMaFUxmklEn80KqLDpAu+8zMZ17R02Q?=
 =?us-ascii?Q?0eZ1vs36nhxL1pINSMU1eNcqr4PTdikVe+3KfoMwxr+uo7u9HadVab5w1CGJ?=
 =?us-ascii?Q?Jbs/xp9m98CyxIhnwCp8/pnSWOEvbKNdL7vZnl+6saA0R5rfqDPCWefX/NpH?=
 =?us-ascii?Q?qIB1UWoh0yDQHpdnQUGc732AT1vAx/5cZqbXFMzWB2HuZ33yQzL6bwlJUPkY?=
 =?us-ascii?Q?9zbFdm4cZUTu4gn4q1cgr1zg75wtn/yeiIos/XNaN5EFC0v179HIdL4C+P23?=
 =?us-ascii?Q?ymZMXYaRL9iNcKKC1efTgVti87dSCf7n2rnNQoUoU+nnjEIj5EODBFNetdiq?=
 =?us-ascii?Q?FC/JiVJr1zuwSj/pQEcRUjq2u9BnsZJF2568mdKLO0j5Wl97IXpS7HKtRF3s?=
 =?us-ascii?Q?MbiTn+MjQHDTutwfZHD+dmX2C979nIQ9H/HggDoPcfsv0ofhF8dI/zL9zE74?=
 =?us-ascii?Q?qbi08NPSd8j0MNZ0o+2c+l1y46DMZeBxbk868zi2GfJjZ5EuB2RTQwDM5mP2?=
 =?us-ascii?Q?kKOUwv2WWL5BNXM4I1YE3bGYkr0FLlBgSGysptl1cvvK2joBuAML9gZWvofU?=
 =?us-ascii?Q?xx7nrwE+GKTMZwsxIl8tMc3Ptnfg2SVFCOvKqohcGf+pqXIZa/L0NY/OvAXE?=
 =?us-ascii?Q?lsS9RXiewxSlfAR2j49S5PNH1iOalHm1PnCymbCPlEUUVAjbrH9SQ61zmTpL?=
 =?us-ascii?Q?d7jBdjapADhzOH56B9ER9UBozYNl5osT7GvxsV2zkyztAdZKvCZCsKN5iXIk?=
 =?us-ascii?Q?gr/mFbYUb6DbSlFwHaQkY9UF417nYpQMbz2och50UtjSXlHi1OdQ+9o/i/B8?=
 =?us-ascii?Q?T7HvvbnqegJ3jf1lqvbVP12bwVEmwO3Hf7ya4NV2nwej68NunDuWO12nKNs6?=
 =?us-ascii?Q?aN+R9wvELf0TNKnfZeSWVs92pGPIo3GEjv4CWelMwZrAq6WIXQnfamkuDY6q?=
 =?us-ascii?Q?mdInA9VN28Uw9eQFJA0/KVAIvN68SiuPtKQ6dxl5ZYFFAe5se0+LlYUDCP44?=
 =?us-ascii?Q?Dcsl2qypXIIldfBi9rkXOx9AHV2NpOuL8JxYnoiuaXqXANocveiTWWKCdAZF?=
 =?us-ascii?Q?eS2qhIX6kXoxAlFww7hvNKwGu2nM9daoRW0JhE5DI7Jeqh9HWL+SDHOybXPR?=
 =?us-ascii?Q?Ma7tkCOQONWBrYalZtNTzKkMf9fhz8EKDNKJnuFOr+gf+mUdWTSobpkrH03X?=
 =?us-ascii?Q?dVXTklk/GJ7nAeksn47dDbTRxZBh8xGsQOxB6i9RVUszFo4tWynI3EVh4NNO?=
 =?us-ascii?Q?gbZUPL4ewHetYs5b/V//scMu8jY71a8Cf9GhXny7elcjANsCX8EV4u8cLenk?=
 =?us-ascii?Q?pG4qVERQ5OEc+ChQHotJgIhAq9VnACR+7EAHGSMUu03PYzNFTVJWnDmT3VqG?=
 =?us-ascii?Q?8axow+afqVskxIjsqq1+7fUifu2TvLcodhVyZey8pFolynQsHP/Zl0m0iaMI?=
 =?us-ascii?Q?dTS9DWKpf8kN4HWPK8IAHknQH9K5K9iBa9h0Avz4kNbgaDDwI5xVi+QVyJ1c?=
 =?us-ascii?Q?bbr/KoG32g=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d228505-da18-4d04-b284-08de8c29e9ad
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2026 17:54:37.7588
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oUclx1engiXTSHYP4V5A59N4FH2nQPHxO2UftbmmMm4fdjxlhf1E3oeWXdgQK/1mGFQoqWTWy+60tiz8rdBNjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9617
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-272627-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,vger.kernel.org,gmail.com,hotmail.com];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[idosch@nvidia.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,Nvidia.com:dkim,nvidia.com:email,sashiko.dev:url]
X-Rspamd-Queue-Id: 91304348C76
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Mar 26, 2026 at 08:26:08PM +0000, Eric Dumazet wrote:
> Sashiko AI-review observed:
> 
>   In ip6_err_gen_icmpv6_unreach(), the skb is an outer IPv4 ICMP error packet
>   where its cb contains an IPv4 inet_skb_parm. When skb is cloned into skb2
>   and passed to icmp6_send(), it uses IP6CB(skb2).
> 
>   IP6CB interprets the IPv4 inet_skb_parm as an inet6_skb_parm. The cipso
>   offset in inet_skb_parm.opt directly overlaps with dsthao in inet6_skb_parm
>   at offset 18.
> 
>   If an attacker sends a forged ICMPv4 error with a CIPSO IP option, dsthao
>   would be a non-zero offset. Inside icmp6_send(), mip6_addr_swap() is called
>   and uses ipv6_find_tlv(skb, opt->dsthao, IPV6_TLV_HAO).
> 
>   This would scan the inner, attacker-controlled IPv6 packet starting at that
>   offset, potentially returning a fake TLV without checking if the remaining
>   packet length can hold the full 18-byte struct ipv6_destopt_hao.
> 
>   Could mip6_addr_swap() then perform a 16-byte swap that extends past the end
>   of the packet data into skb_shared_info?
> 
>   Should the cb array also be cleared in ip6_err_gen_icmpv6_unreach() and
>   ip6ip6_err() to prevent this?
> 
> This patch implements the first suggestion.
> 
> I am not sure if ip6ip6_err() needs to be changed.
> A separate patch would be better anyway.
> 
> Fixes: ca15a078bd90 ("sit: generate icmpv6 error when receiving icmpv4 error")
> Reported-by: Ido Schimmel <idosch@nvidia.com>
> Closes: https://sashiko.dev/#/patchset/20260326155138.2429480-1-edumazet%40google.com
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Cc: Ido Schimmel <idosch@nvidia.com>
> Cc: Oskar Kjos <oskar.kjos@hotmail.com>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>

