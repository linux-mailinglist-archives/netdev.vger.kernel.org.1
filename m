Return-Path: <netdev+bounces-236406-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 82655C3BEF0
	for <lists+netdev@lfdr.de>; Thu, 06 Nov 2025 16:02:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA4BF1884589
	for <lists+netdev@lfdr.de>; Thu,  6 Nov 2025 14:57:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87A5BEACE;
	Thu,  6 Nov 2025 14:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uFI9yH65"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FB79303CA8
	for <netdev@vger.kernel.org>; Thu,  6 Nov 2025 14:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762441028; cv=none; b=Fc3fbfPDpVSYl7DuxCZMdUK3SkBkojxV06H8+GMvJIQ9dzoZi++QjesrwpVXy5wTFAhNzI24JfbQTlj5AiEPrDCNs/qj1YvTDD5jKt9k18vwl8DZThUgiwbW8X79jhXacbJNOqCNMl1/2bt7C7RpEbrBzgQuYjbB3og/NjV8PvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762441028; c=relaxed/simple;
	bh=epY9yCwjum0Gz0P+Spesm56f/Fc1oNQHj3RX42pw+mE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e56aae3sO9D5OIEIR/JNjGtzYllAwou0LqwROMFQl2or16udHnsMOnRhhZKec8o97qEULpz594bN5NrgDVykamk3wSoO8QFS5gx+qicYNnfqnOD3HMrumNUAXE+2p8fAKpro32RP1cuWCWObulro/4H2AssdvLa3AH1sbzP6CcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uFI9yH65; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFBF4C116C6;
	Thu,  6 Nov 2025 14:57:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762441024;
	bh=epY9yCwjum0Gz0P+Spesm56f/Fc1oNQHj3RX42pw+mE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=uFI9yH65oN3oTj6YqMZxeC20tcUHyQcxcP8u0nhC4Ntl+gMcjZUfJan1WOk3tfJZg
	 p4bz+On/PYcYihEZov+89wC6FPDZio5xJNVAGdeXXm2KPYXwK+wMlT0OpmVEZdua7a
	 1V3yc8mlEgsJHV7AHzqD0L7SmfYBZmmQETgz0HrW4D7cmQli3WqYImw3aKk3lxwtJq
	 Yfntc6NvvDTgBTf/LvW2Y1VmklJZ6L2NIUVChIxoxe/Nf3X/+aokmYeue/+skXcz3f
	 BvwEBgR2WUUt4vfWySFGW99WReQ8me43Z78RZV46d6PQlTkwKKejM8A03KSZ6s4woZ
	 Pgcewuoq/jykg==
Message-ID: <0eecf17d-2606-4304-bc75-efe4c7ec73b9@kernel.org>
Date: Thu, 6 Nov 2025 15:56:59 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] tcp: add net.ipv4.tcp_comp_sack_rtt_percent
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Neal Cardwell <ncardwell@google.com>,
 Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org,
 eric.dumazet@gmail.com
References: <20251105093837.711053-1-edumazet@google.com>
Content-Language: en-US
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <20251105093837.711053-1-edumazet@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 05/11/2025 10.38, Eric Dumazet wrote:
> TCP SACK compression has been added in 2018 in commit
> 5d9f4262b7ea ("tcp: add SACK compression").
> 
> It is working great for WAN flows (with large RTT).
> Wifi in particular gets a significant boost _when_ ACK are suppressed.
> 
> Add a new sysctl so that we can tune the very conservative 5 % value
> that has been used so far in this formula, so that small RTT flows
> can benefit from this feature.
> 
> delay = min ( 5 % of RTT, 1 ms)
> 
> This patch adds new tcp_comp_sack_rtt_percent sysctl
> to ease experiments and tuning.
> 
> Given that we cap the delay to 1ms (tcp_comp_sack_delay_ns sysctl),
> set the default value to 100.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---
>   Documentation/networking/ip-sysctl.rst | 13 +++++++++++--
>   include/net/netns/ipv4.h               |  1 +
>   net/ipv4/sysctl_net_ipv4.c             |  9 +++++++++
>   net/ipv4/tcp_input.c                   | 26 ++++++++++++++++++--------
>   net/ipv4/tcp_ipv4.c                    |  1 +
>   5 files changed, 40 insertions(+), 10 deletions(-)
> 
> diff --git a/Documentation/networking/ip-sysctl.rst b/Documentation/networking/ip-sysctl.rst
> index 7cd35bfd39e68c5b2650eb9d0fbb76e34aed3f2b..ebc11f593305bf87e7d4ad4d50ef085b22aef7da 100644
> --- a/Documentation/networking/ip-sysctl.rst
> +++ b/Documentation/networking/ip-sysctl.rst
> @@ -854,9 +854,18 @@ tcp_sack - BOOLEAN
>   
>   	Default: 1 (enabled)
>   
> +tcp_comp_sack_rtt_percent - INTEGER
> +	Percentage of SRTT used for the compressed SACK feature.
> +	See tcp_comp_sack_nr, tcp_comp_sack_delay_ns, tcp_comp_sack_slack_ns.
> +
> +	Possible values : 1 - 1000

If this is a percentage, why does it allow 1000 as max?

> +	Default : 100 %
> +
>   tcp_comp_sack_delay_ns - LONG INTEGER
> -	TCP tries to reduce number of SACK sent, using a timer
> -	based on 5% of SRTT, capped by this sysctl, in nano seconds.
> +	TCP tries to reduce number of SACK sent, using a timer based
> +	on tcp_comp_sack_rtt_percent of SRTT, capped by this sysctl
> +	in nano seconds.
>   	The default is 1ms, based on TSO autosizing period.
>   
>   	Default : 1,000,000 ns (1 ms)
> diff --git a/include/net/netns/ipv4.h b/include/net/netns/ipv4.h
> index 0e96c90e56c6d987a16598ef885c403d5c3eae52..de9d36acc8e22d3203120d8015b3d172e85de121 100644
> --- a/include/net/netns/ipv4.h
> +++ b/include/net/netns/ipv4.h
> @@ -221,6 +221,7 @@ struct netns_ipv4 {
>   	int sysctl_tcp_pacing_ss_ratio;
>   	int sysctl_tcp_pacing_ca_ratio;
>   	unsigned int sysctl_tcp_child_ehash_entries;
> +	int sysctl_tcp_comp_sack_rtt_percent;
>   	unsigned long sysctl_tcp_comp_sack_delay_ns;
>   	unsigned long sysctl_tcp_comp_sack_slack_ns;
>   	int sysctl_max_syn_backlog;
> diff --git a/net/ipv4/sysctl_net_ipv4.c b/net/ipv4/sysctl_net_ipv4.c
> index 0c7c8f9041cbf4aa4e51dcebd607aa5d8ac80dcd..35367f8e2da32f2c7de5a06164f5e47c8929c8f1 100644
> --- a/net/ipv4/sysctl_net_ipv4.c
> +++ b/net/ipv4/sysctl_net_ipv4.c
> @@ -1451,6 +1451,15 @@ static struct ctl_table ipv4_net_table[] = {
>   		.mode		= 0644,
>   		.proc_handler	= proc_doulongvec_minmax,
>   	},
> +	{
> +		.procname	= "tcp_comp_sack_rtt_percent",
> +		.data		= &init_net.ipv4.sysctl_tcp_comp_sack_rtt_percent,
> +		.maxlen		= sizeof(int),
> +		.mode		= 0644,
> +		.proc_handler	= proc_dointvec_minmax,
> +		.extra1		= SYSCTL_ONE,
> +		.extra2		= SYSCTL_ONE_THOUSAND,
> +	},
>   	{
>   		.procname	= "tcp_comp_sack_slack_ns",
>   		.data		= &init_net.ipv4.sysctl_tcp_comp_sack_slack_ns,
> diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
> index 6db1d4c36a88bfa64b48388ee95e4e9218d9a9fd..d4ee74da018ee97209bed3402688f5e18759866b 100644
> --- a/net/ipv4/tcp_input.c
> +++ b/net/ipv4/tcp_input.c
> @@ -5893,7 +5893,9 @@ static inline void tcp_data_snd_check(struct sock *sk)
>   static void __tcp_ack_snd_check(struct sock *sk, int ofo_possible)
>   {
>   	struct tcp_sock *tp = tcp_sk(sk);
> -	unsigned long rtt, delay;
> +	struct net *net = sock_net(sk);
> +	unsigned long rtt;
> +	u64 delay;
>   
>   	    /* More than one full frame received... */
>   	if (((tp->rcv_nxt - tp->rcv_wup) > inet_csk(sk)->icsk_ack.rcv_mss &&
> @@ -5912,7 +5914,7 @@ static void __tcp_ack_snd_check(struct sock *sk, int ofo_possible)
>   		 * Defer the ack until tcp_release_cb().
>   		 */
>   		if (sock_owned_by_user_nocheck(sk) &&
> -		    READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_backlog_ack_defer)) {
> +		    READ_ONCE(net->ipv4.sysctl_tcp_backlog_ack_defer)) {
>   			set_bit(TCP_ACK_DEFERRED, &sk->sk_tsq_flags);
>   			return;
>   		}
> @@ -5927,7 +5929,7 @@ static void __tcp_ack_snd_check(struct sock *sk, int ofo_possible)
>   	}
>   
>   	if (!tcp_is_sack(tp) ||
> -	    tp->compressed_ack >= READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_comp_sack_nr))
> +	    tp->compressed_ack >= READ_ONCE(net->ipv4.sysctl_tcp_comp_sack_nr))
>   		goto send_now;
>   
>   	if (tp->compressed_ack_rcv_nxt != tp->rcv_nxt) {
> @@ -5942,18 +5944,26 @@ static void __tcp_ack_snd_check(struct sock *sk, int ofo_possible)
>   	if (hrtimer_is_queued(&tp->compressed_ack_timer))
>   		return;
>   
> -	/* compress ack timer : 5 % of rtt, but no more than tcp_comp_sack_delay_ns */
> +	/* compress ack timer : comp_sack_rtt_percent of rtt,
> +	 * but no more than tcp_comp_sack_delay_ns.
> +	 */
>   
>   	rtt = tp->rcv_rtt_est.rtt_us;
>   	if (tp->srtt_us && tp->srtt_us < rtt)
>   		rtt = tp->srtt_us;
>   
> -	delay = min_t(unsigned long,
> -		      READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_comp_sack_delay_ns),
> -		      rtt * (NSEC_PER_USEC >> 3)/20);
> +	/* delay = (rtt >> 3) * NSEC_PER_USEC * comp_sack_rtt_percent / 100
> +	 * ->
> +	 * delay = rtt * 1.25 * comp_sack_rtt_percent
> +	 */

Why explain this with shifts.  I have to use extra time to remember that
shift ">> 3" is the same as div "/" 8.  And that ">>" 2 is the same as
div "/4".  For the code, I think the compiler will convert /4 to >>2
anyway.  I don't feel strongly about this, so I'll let it be up to you
if you want to adjust this or not.


> +	delay = (u64)(rtt + (rtt >> 2)) *
> +		READ_ONCE(net->ipv4.sysctl_tcp_comp_sack_rtt_percent);
> +
> +	delay = min(delay, READ_ONCE(net->ipv4.sysctl_tcp_comp_sack_delay_ns));
> +
>   	sock_hold(sk);
>   	hrtimer_start_range_ns(&tp->compressed_ack_timer, ns_to_ktime(delay),
> -			       READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_comp_sack_slack_ns),
> +			       READ_ONCE(net->ipv4.sysctl_tcp_comp_sack_slack_ns),
>   			       HRTIMER_MODE_REL_PINNED_SOFT);
>   }
>   
> diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
> index b7526a7888cbe296c0f4ba6350772741cfe1765b..a4411cd0229cb7fc5903d206e549d0889d177937 100644
> --- a/net/ipv4/tcp_ipv4.c
> +++ b/net/ipv4/tcp_ipv4.c
> @@ -3596,6 +3596,7 @@ static int __net_init tcp_sk_init(struct net *net)
>   	net->ipv4.sysctl_tcp_comp_sack_delay_ns = NSEC_PER_MSEC;
>   	net->ipv4.sysctl_tcp_comp_sack_slack_ns = 100 * NSEC_PER_USEC;
>   	net->ipv4.sysctl_tcp_comp_sack_nr = 44;
> +	net->ipv4.sysctl_tcp_comp_sack_rtt_percent = 100;
>   	net->ipv4.sysctl_tcp_backlog_ack_defer = 1;
>   	net->ipv4.sysctl_tcp_fastopen = TFO_CLIENT_ENABLE;
>   	net->ipv4.sysctl_tcp_fastopen_blackhole_timeout = 0;


