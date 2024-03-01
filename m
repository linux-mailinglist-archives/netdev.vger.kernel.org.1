Return-Path: <netdev+bounces-76590-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68A7E86E4C3
	for <lists+netdev@lfdr.de>; Fri,  1 Mar 2024 16:55:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7E07288FD8
	for <lists+netdev@lfdr.de>; Fri,  1 Mar 2024 15:55:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FD0870CAF;
	Fri,  1 Mar 2024 15:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZgZQ4aR/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C8EF70CA8
	for <netdev@vger.kernel.org>; Fri,  1 Mar 2024 15:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709308533; cv=none; b=mUPJ4FirD0P8gOiYm0xZfzW+inYtJLlSCovhFOzHiRqQGS4vTrdXfVBQev6wsSxCOugNbW7qFTjCgjvTDAbW1AEibZUyusFV6lKLhlmKR2L02amq6zMfEn4xeeo1Zzc+Z/GAuAi/3R2i6w4a1R1yd5kZFpOuDB9spscGDkGLk3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709308533; c=relaxed/simple;
	bh=c0Y5s3hakvePLjsoF32IA/VPnJGfXvrmicIb0uuXJMg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gOdWrHg64GonN/jjA8h6tWxRdZG4k8kkeekrhdzRtJl4v5cn9ZB29I1sTEpptp5UmJuwONh3XzYxL0yyh7gjAHGlyBTpJ5+E5pBD+gAUlDMfSSgJ4Q6KbG8L6ucpw4k5EgMKvy0hF6nl8EjP8V2MjonsGVVfV2EVxL3AQiqKYf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZgZQ4aR/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9A9CC433F1;
	Fri,  1 Mar 2024 15:55:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709308532;
	bh=c0Y5s3hakvePLjsoF32IA/VPnJGfXvrmicIb0uuXJMg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ZgZQ4aR/DQC5/CpUh9RxNAjtqf5NVHGO5Hb6szcBKhcmmIfZwNj/7N4pF7/1i9omG
	 Zkq+ew4jLMhRoeVbJbJVWcpY/ox+9/pxnUZaxggP8ahfDm+fG/fMAHPrThicm3wju2
	 anqs6k/8ZsRNH3RgevBowfsjWAtGUMLn+AuJshelStiChQsDu/cw4JoPIOvRCqxi/B
	 CGmdPoY8T5LZyzz4Q/XgkcJ+aKDhdoEWKOwasgGc9BBdv6cJqHey5ZBzty/HcF2yR0
	 liWnLFn5ic/tPew3m9haDhqEpxgS6//hoVpSNcADdGiFxAXgFu0UtZmf/lV2Q1l5Yt
	 p7C2cUvQ3TVkg==
Message-ID: <386b5f4d-2228-4e57-a4b3-fb17facf9029@kernel.org>
Date: Fri, 1 Mar 2024 08:55:30 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 7/7] net: nexthop: Expose nexthop group HW
 stats to user space
Content-Language: en-US
To: Petr Machata <petrm@nvidia.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
Cc: Ido Schimmel <idosch@nvidia.com>, Simon Horman <horms@kernel.org>,
 mlxsw@nvidia.com, Kees Cook <keescook@chromium.org>
References: <cover.1709217658.git.petrm@nvidia.com>
 <f35433867d7bab05bbe0a1b4a09c3454cdefeb7b.1709217658.git.petrm@nvidia.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <f35433867d7bab05bbe0a1b4a09c3454cdefeb7b.1709217658.git.petrm@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/29/24 11:16 AM, Petr Machata wrote:
> From: Ido Schimmel <idosch@nvidia.com>
> 
> Add netlink support for reading NH group hardware stats.
> 
> Stats collection is done through a new notifier,
> NEXTHOP_EVENT_HW_STATS_REPORT_DELTA. Drivers that implement HW counters for
> a given NH group are thereby asked to collect the stats and report back to
> core by calling nh_grp_hw_stats_report_delta(). This is similar to what
> netdevice L3 stats do.
> 
> Besides exposing number of packets that passed in the HW datapath, also
> include information on whether any driver actually realizes the counters.
> The core can tell based on whether it got any _report_delta() reports from
> the drivers. This allows enabling the statistics at the group at any time,
> with drivers opting into supporting them. This is also in line with what
> netdevice L3 stats are doing.
> 
> So as not to waste time and space, tie the collection and reporting of HW
> stats with a new op flag, NHA_OP_FLAG_DUMP_HW_STATS.
> 
> Co-developed-by: Petr Machata <petrm@nvidia.com>
> Signed-off-by: Petr Machata <petrm@nvidia.com>
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> Reviewed-by: Kees Cook <keescook@chromium.org> # For the __counted_by bits
> ---
> 
> Notes:
>     v2:
>     - Use uint to encode NHA_GROUP_STATS_ENTRY_PACKETS_HW
>     - Do not cancel outside of nesting in nla_put_nh_group_stats()
> 
>  include/net/nexthop.h        |  18 +++++
>  include/uapi/linux/nexthop.h |   9 +++
>  net/ipv4/nexthop.c           | 133 ++++++++++++++++++++++++++++++++---
>  3 files changed, 151 insertions(+), 9 deletions(-)
> 


> diff --git a/net/ipv4/nexthop.c b/net/ipv4/nexthop.c
> index 15f108c440ae..169a003cc855 100644
> --- a/net/ipv4/nexthop.c
> +++ b/net/ipv4/nexthop.c
> @@ -43,7 +43,8 @@ static const struct nla_policy rtm_nh_policy_new[] = {
>  static const struct nla_policy rtm_nh_policy_get[] = {
>  	[NHA_ID]		= { .type = NLA_U32 },
>  	[NHA_OP_FLAGS]		= NLA_POLICY_MASK(NLA_U32,
> -						  NHA_OP_FLAG_DUMP_STATS),
> +						  NHA_OP_FLAG_DUMP_STATS |
> +						  NHA_OP_FLAG_DUMP_HW_STATS),
>  };
>  
>  static const struct nla_policy rtm_nh_policy_del[] = {
> @@ -56,7 +57,8 @@ static const struct nla_policy rtm_nh_policy_dump[] = {
>  	[NHA_MASTER]		= { .type = NLA_U32 },
>  	[NHA_FDB]		= { .type = NLA_FLAG },
>  	[NHA_OP_FLAGS]		= NLA_POLICY_MASK(NLA_U32,
> -						  NHA_OP_FLAG_DUMP_STATS),
> +						  NHA_OP_FLAG_DUMP_STATS |
> +						  NHA_OP_FLAG_DUMP_HW_STATS),

2 instances of the same mask; worth giving it a name.

Reviewed-by: David Ahern <dsahern@kernel.org>



