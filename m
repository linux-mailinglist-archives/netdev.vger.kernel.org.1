Return-Path: <netdev+bounces-174163-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8E56A5DA8F
	for <lists+netdev@lfdr.de>; Wed, 12 Mar 2025 11:40:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D85B2167540
	for <lists+netdev@lfdr.de>; Wed, 12 Mar 2025 10:40:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B98AF23BD0F;
	Wed, 12 Mar 2025 10:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=uliege.be header.i=@uliege.be header.b="cJs5ssOJ"
X-Original-To: netdev@vger.kernel.org
Received: from serv108.segi.ulg.ac.be (serv108.segi.ulg.ac.be [139.165.32.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FE971DB124
	for <netdev@vger.kernel.org>; Wed, 12 Mar 2025 10:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.165.32.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741776013; cv=none; b=Mx7QxjzUc4uN5BOsiJVZgGQYV2C9ExS2s34cvBK3GQb6tAfcpwUBN/BzL8QZh9/0Jyw0Piel8iH85nS8xZW7a3GECh9YKe0ReQ/sFRVuiyWQL3IyIMCWww43S6YD12zrwdUTMy5V3ZlP7BDo1/gkfW/03cszVKgbamJc2qIvyPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741776013; c=relaxed/simple;
	bh=QFmMhLOu5lKLeogDNvJKfIjaAb5qDWz4drPOmMc8io8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JaSRSLWqq4QsUsuH12A1NmcCdpb3RH7Sr3pd97pgTsMkkdMUjtfIcR3uncGCY++hlcqWX06t+5mpgySqAcxhsJ0MiZyhlKbpmt1in8AhyYMR495gq5ElvP7qp5VpHeVh39POUN0sELHQ33yXDiGTsbGY3FWEYE9ApMSeRXR9N30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uliege.be; spf=pass smtp.mailfrom=uliege.be; dkim=pass (2048-bit key) header.d=uliege.be header.i=@uliege.be header.b=cJs5ssOJ; arc=none smtp.client-ip=139.165.32.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uliege.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uliege.be
Received: from [192.168.0.223] (unknown [195.29.54.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by serv108.segi.ulg.ac.be (Postfix) with ESMTPSA id 1C080200E2A2;
	Wed, 12 Mar 2025 11:40:09 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 serv108.segi.ulg.ac.be 1C080200E2A2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uliege.be;
	s=ulg20190529; t=1741776009;
	bh=e6Gj+m9nc9CLfjCqrqcCyEOHx98IvQCnCpG7BQOEFyE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=cJs5ssOJ2kQ/Lqen3D+nHIxqiDzDSywikfqWrbFAMK5h6liVYtoBXqd1rEnpf+qG3
	 MNt7kN8S9lsGaAoqDiaYUhyphTmyJCenazSrVKOZq27h7sUartbtD1qROxrGj+9KqV
	 GjRgu7udm8ZuG+d1dNnaHW3sBchcT8xszNnwBWKZT1LZnIADOFYRFLNE9Qv8TWcr0y
	 Lz4m/ozh05WSGgmqvddMpIawdU+tbWfTnmGFHusW7u1F3xXwz3q0AGJvI1stDmjOdW
	 n92zXcoCsTxP3iaZJHCPIREk+xzY/cSw4FY05MT9Yq2jmDFktsnhf9CekkbqtUG2GX
	 LILgSBJ+/AWlg==
Message-ID: <fb9aec0e-0d95-4ca3-8174-32174551ece3@uliege.be>
Date: Wed, 12 Mar 2025 11:40:06 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: lwtunnel: fix recursion loops
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, Roopa Prabhu <roopa@nvidia.com>,
 Andrea Mayer <andrea.mayer@uniroma2.it>,
 Stefano Salsano <stefano.salsano@uniroma2.it>,
 Ahmed Abdelsalam <ahabdels.dev@gmail.com>, Ido Schimmel <idosch@nvidia.com>
References: <20250312103246.16206-1-justin.iurman@uliege.be>
Content-Language: en-US
From: Justin Iurman <justin.iurman@uliege.be>
In-Reply-To: <20250312103246.16206-1-justin.iurman@uliege.be>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/12/25 11:32, Justin Iurman wrote:
> Different kind of loops in most of lwtunnel users were fixed by some
> recent patches. This patch acts as a parachute, catch all solution, by
> detecting any use cases with recursion and taking care of them (e.g., a
> loop between routes). This is applied to lwtunnel_input(),
> lwtunnel_output(), and lwtunnel_xmit().
> 
> Fixes: ffce41962ef6 ("lwtunnel: support dst output redirect function")
> Fixes: 2536862311d2 ("lwt: Add support to redirect dst.input")
> Fixes: 14972cbd34ff ("net: lwtunnel: Handle fragmentation")
> Closes: https://lore.kernel.org/netdev/2bc9e2079e864a9290561894d2a602d6@akamai.com/
> Cc: Roopa Prabhu <roopa@nvidia.com>
> Cc: Andrea Mayer <andrea.mayer@uniroma2.it>
> Cc: Stefano Salsano <stefano.salsano@uniroma2.it>
> Cc: Ahmed Abdelsalam <ahabdels.dev@gmail.com>
> Cc: Ido Schimmel <idosch@nvidia.com>
> Signed-off-by: Justin Iurman <justin.iurman@uliege.be>
> ---
>   net/core/lwtunnel.c | 65 ++++++++++++++++++++++++++++++++++++---------
>   net/core/lwtunnel.h | 42 +++++++++++++++++++++++++++++
>   2 files changed, 95 insertions(+), 12 deletions(-)
>   create mode 100644 net/core/lwtunnel.h
> 
> diff --git a/net/core/lwtunnel.c b/net/core/lwtunnel.c
> index 711cd3b4347a..0954783e36ce 100644
> --- a/net/core/lwtunnel.c
> +++ b/net/core/lwtunnel.c
> @@ -23,6 +23,8 @@
>   #include <net/ip6_fib.h>
>   #include <net/rtnh.h>
>   
> +#include "lwtunnel.h"
> +
>   DEFINE_STATIC_KEY_FALSE(nf_hooks_lwtunnel_enabled);
>   EXPORT_SYMBOL_GPL(nf_hooks_lwtunnel_enabled);
>   
> @@ -325,13 +327,23 @@ EXPORT_SYMBOL_GPL(lwtunnel_cmp_encap);
>   
>   int lwtunnel_output(struct net *net, struct sock *sk, struct sk_buff *skb)
>   {
> -	struct dst_entry *dst = skb_dst(skb);
>   	const struct lwtunnel_encap_ops *ops;
>   	struct lwtunnel_state *lwtstate;
> -	int ret = -EINVAL;
> +	struct dst_entry *dst;
> +	int ret;
> +
> +	if (lwtunnel_recursion()) {
> +		net_crit_ratelimited("%s(): recursion limit reached on datapath\n",
> +				     __func__);
> +		ret = -ENETDOWN;
> +		goto drop;
> +	}
>   
> -	if (!dst)
> +	dst = skb_dst(skb);
> +	if (!dst) {
> +		ret = -EINVAL;
>   		goto drop;
> +	}
>   	lwtstate = dst->lwtstate;
>   
>   	if (lwtstate->type == LWTUNNEL_ENCAP_NONE ||
> @@ -341,8 +353,11 @@ int lwtunnel_output(struct net *net, struct sock *sk, struct sk_buff *skb)
>   	ret = -EOPNOTSUPP;
>   	rcu_read_lock();
>   	ops = rcu_dereference(lwtun_encaps[lwtstate->type]);
> -	if (likely(ops && ops->output))
> +	if (likely(ops && ops->output)) {
> +		lwtunnel_recursion_inc();
>   		ret = ops->output(net, sk, skb);
> +		lwtunnel_recursion_dec();
> +	}
>   	rcu_read_unlock();
>   
>   	if (ret == -EOPNOTSUPP)
> @@ -359,13 +374,23 @@ EXPORT_SYMBOL_GPL(lwtunnel_output);
>   
>   int lwtunnel_xmit(struct sk_buff *skb)
>   {
> -	struct dst_entry *dst = skb_dst(skb);
>   	const struct lwtunnel_encap_ops *ops;
>   	struct lwtunnel_state *lwtstate;
> -	int ret = -EINVAL;
> +	struct dst_entry *dst;
> +	int ret;
> +
> +	if (lwtunnel_recursion()) {
> +		net_crit_ratelimited("%s(): recursion limit reached on datapath\n",
> +				     __func__);
> +		ret = -ENETDOWN;
> +		goto drop;
> +	}
>   
> -	if (!dst)
> +	dst = skb_dst(skb);
> +	if (!dst) {
> +		ret = -EINVAL;
>   		goto drop;
> +	}
>   
>   	lwtstate = dst->lwtstate;
>   
> @@ -376,8 +401,11 @@ int lwtunnel_xmit(struct sk_buff *skb)
>   	ret = -EOPNOTSUPP;
>   	rcu_read_lock();
>   	ops = rcu_dereference(lwtun_encaps[lwtstate->type]);
> -	if (likely(ops && ops->xmit))
> +	if (likely(ops && ops->xmit)) {
> +		lwtunnel_recursion_inc();
>   		ret = ops->xmit(skb);
> +		lwtunnel_recursion_dec();
> +	}
>   	rcu_read_unlock();
>   
>   	if (ret == -EOPNOTSUPP)
> @@ -394,13 +422,23 @@ EXPORT_SYMBOL_GPL(lwtunnel_xmit);
>   
>   int lwtunnel_input(struct sk_buff *skb)
>   {
> -	struct dst_entry *dst = skb_dst(skb);
>   	const struct lwtunnel_encap_ops *ops;
>   	struct lwtunnel_state *lwtstate;
> -	int ret = -EINVAL;
> +	struct dst_entry *dst;
> +	int ret;
>   
> -	if (!dst)
> +	if (lwtunnel_recursion()) {
> +		net_crit_ratelimited("%s(): recursion limit reached on datapath\n",
> +				     __func__);
> +		ret = -ENETDOWN;
>   		goto drop;
> +	}
> +
> +	dst = skb_dst(skb);
> +	if (!dst) {
> +		ret = -EINVAL;
> +		goto drop;
> +	}
>   	lwtstate = dst->lwtstate;
>   
>   	if (lwtstate->type == LWTUNNEL_ENCAP_NONE ||
> @@ -410,8 +448,11 @@ int lwtunnel_input(struct sk_buff *skb)
>   	ret = -EOPNOTSUPP;
>   	rcu_read_lock();
>   	ops = rcu_dereference(lwtun_encaps[lwtstate->type]);
> -	if (likely(ops && ops->input))
> +	if (likely(ops && ops->input)) {
> +		lwtunnel_recursion_inc();
>   		ret = ops->input(skb);
> +		lwtunnel_recursion_dec();
> +	}
>   	rcu_read_unlock();
>   
>   	if (ret == -EOPNOTSUPP)
> diff --git a/net/core/lwtunnel.h b/net/core/lwtunnel.h
> new file mode 100644
> index 000000000000..32880ecdd8bb
> --- /dev/null
> +++ b/net/core/lwtunnel.h
> @@ -0,0 +1,42 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +#ifndef _NET_CORE_LWTUNNEL_H
> +#define _NET_CORE_LWTUNNEL_H
> +
> +#include <linux/netdevice.h>
> +
> +#define LWTUNNEL_RECURSION_LIMIT 8
> +
> +#ifndef CONFIG_PREEMPT_RT
> +static inline bool lwtunnel_recursion(void)
> +{
> +	return unlikely(__this_cpu_read(softnet_data.xmit.recursion) >
> +			LWTUNNEL_RECURSION_LIMIT);
> +}
> +
> +static inline void lwtunnel_recursion_inc(void)
> +{
> +	__this_cpu_inc(softnet_data.xmit.recursion);
> +}
> +
> +static inline void lwtunnel_recursion_dec(void)
> +{
> +	__this_cpu_dec(softnet_data.xmit.recursion);
> +}
> +#else
> +static inline bool lwtunnel_recursion(void)
> +{
> +	return unlikely(current->net_xmit.recursion > LWTUNNEL_RECURSION_LIMIT);
> +}
> +
> +static inline void lwtunnel_recursion_inc(void)
> +{
> +	current->net_xmit.recursion++;
> +}
> +
> +static inline void lwtunnel_recursion_dec(void)
> +{
> +	current->net_xmit.recursion--;
> +}
> +#endif
> +
> +#endif /* _NET_CORE_LWTUNNEL_H */

Wondering what folks think about the above idea to reuse fields that 
dev_xmit_recursion() currently uses. IMO, it seems OK considering the 
use case and context. If not, I guess we'd need to add a new field to 
both softnet_data and task_struct.

Also, with Andrea, we discussed the choice to either keep and send 
packets, or drop them, in case of pathological configurations. If we 
were to drop them, then only this patch would suffice, making my series 
"net: fix lwtunnel reentry loops" not needed anymore (at least for most 
of lwtunnel users, not for ioam for example where it is needed anyway).

