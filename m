Return-Path: <netdev+bounces-101328-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78F938FE24D
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 11:16:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6DAB61C21D8B
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 09:16:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04BA61514EE;
	Thu,  6 Jun 2024 09:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ju8sxcUF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB18313E03C;
	Thu,  6 Jun 2024 09:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717665116; cv=none; b=rphVHB+vVthnpcko8HCjklXbg69K1NA9t2UNRrFkFgHpAvowIDtmMcOMHwuuUaa7ROsfumY+OUlV3dWJAtwinsAhOckPbXljG6zmtSfgWcTyqpiG7Zk+i5lvIYzEbdvzbAZVuzRqmBoXN/bC8J25JEEzvspBUvxhniO1Pbi46V4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717665116; c=relaxed/simple;
	bh=eC5wX2eAW1HqPpt0NLbi0EUof17svVNQi4hnTqBuM1Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Tl8lLTBW/YTAqhIoaAMu+tGqXEe4FrJ6Cm7BL4o9rMoMHcXELBTgtJpszf41rYEPz+Yi3Z7WS9izTj1OU4gcyRlflWU+iqvv7NvjyDRLqecwMua03oTaNbH70LcTGBFYhEsr/sAId4LFwmKRfQd+D7y3ZabuhCzFhQ1R5aZeG2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ju8sxcUF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D2F0C2BD10;
	Thu,  6 Jun 2024 09:11:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717665116;
	bh=eC5wX2eAW1HqPpt0NLbi0EUof17svVNQi4hnTqBuM1Y=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Ju8sxcUFv/x6oSnDewNWGfttFoWiXZaGTGlTQrjw2RjVabkmKyvBgzrGPeLIhX48z
	 9hskYqu2ZuB5QgVA/vmbFcqdWAG6DzIjl+U9Yt4qTKOShiQSvKR4zg1B1O5wvcwUlM
	 /wTbxKmT3X0RXSc1IWpQJRvz7k1PENGFEyOQs96mJNvD9ZLaKuzZ5FHKtBvtQQcseE
	 LVTNi3AmvyqQNRUmS1o+cmcjkYrQ8w/ZL/Q8vSslkitlRaq14/6T2ZOU5+t9UdIj4u
	 zV+JBQcqcJgF3agocC7dggwuEnCK9HD+KzT7bQIV6jBSxu1QXkqfPt7GUEzLcUUgaY
	 QsZ9BdWs/VXZw==
Message-ID: <92c1cb53-ec2b-4153-b97d-c2b8c0fdfaf2@kernel.org>
Date: Thu, 6 Jun 2024 11:11:38 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH net-next v3 3/6] net/tcp: Move tcp_inbound_hash() from
 headers
Content-Language: en-GB
To: 0x7f454c46@gmail.com, Eric Dumazet <edumazet@google.com>,
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>,
 Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Jonathan Corbet <corbet@lwn.net>
Cc: Mohammad Nassiri <mnassiri@ciena.com>, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org
References: <20240606-tcp_ao-tracepoints-v3-0-13621988c09f@gmail.com>
 <20240606-tcp_ao-tracepoints-v3-3-13621988c09f@gmail.com>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 xsFNBFXj+ekBEADxVr99p2guPcqHFeI/JcFxls6KibzyZD5TQTyfuYlzEp7C7A9swoK5iCvf
 YBNdx5Xl74NLSgx6y/1NiMQGuKeu+2BmtnkiGxBNanfXcnl4L4Lzz+iXBvvbtCbynnnqDDqU
 c7SPFMpMesgpcu1xFt0F6bcxE+0ojRtSCZ5HDElKlHJNYtD1uwY4UYVGWUGCF/+cY1YLmtfb
 WdNb/SFo+Mp0HItfBC12qtDIXYvbfNUGVnA5jXeWMEyYhSNktLnpDL2gBUCsdbkov5VjiOX7
 CRTkX0UgNWRjyFZwThaZADEvAOo12M5uSBk7h07yJ97gqvBtcx45IsJwfUJE4hy8qZqsA62A
 nTRflBvp647IXAiCcwWsEgE5AXKwA3aL6dcpVR17JXJ6nwHHnslVi8WesiqzUI9sbO/hXeXw
 TDSB+YhErbNOxvHqCzZEnGAAFf6ges26fRVyuU119AzO40sjdLV0l6LE7GshddyazWZf0iac
 nEhX9NKxGnuhMu5SXmo2poIQttJuYAvTVUNwQVEx/0yY5xmiuyqvXa+XT7NKJkOZSiAPlNt6
 VffjgOP62S7M9wDShUghN3F7CPOrrRsOHWO/l6I/qJdUMW+MHSFYPfYiFXoLUZyPvNVCYSgs
 3oQaFhHapq1f345XBtfG3fOYp1K2wTXd4ThFraTLl8PHxCn4ywARAQABzSRNYXR0aGlldSBC
 YWVydHMgPG1hdHR0YmVAa2VybmVsLm9yZz7CwZEEEwEIADsCGwMFCwkIBwIGFQoJCAsCBBYC
 AwECHgECF4AWIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZUDpDAIZAQAKCRD2t4JPQmmgcz33
 EACjROM3nj9FGclR5AlyPUbAq/txEX7E0EFQCDtdLPrjBcLAoaYJIQUV8IDCcPjZMJy2ADp7
 /zSwYba2rE2C9vRgjXZJNt21mySvKnnkPbNQGkNRl3TZAinO1Ddq3fp2c/GmYaW1NWFSfOmw
 MvB5CJaN0UK5l0/drnaA6Hxsu62V5UnpvxWgexqDuo0wfpEeP1PEqMNzyiVPvJ8bJxgM8qoC
 cpXLp1Rq/jq7pbUycY8GeYw2j+FVZJHlhL0w0Zm9CFHThHxRAm1tsIPc+oTorx7haXP+nN0J
 iqBXVAxLK2KxrHtMygim50xk2QpUotWYfZpRRv8dMygEPIB3f1Vi5JMwP4M47NZNdpqVkHrm
 jvcNuLfDgf/vqUvuXs2eA2/BkIHcOuAAbsvreX1WX1rTHmx5ud3OhsWQQRVL2rt+0p1DpROI
 3Ob8F78W5rKr4HYvjX2Inpy3WahAm7FzUY184OyfPO/2zadKCqg8n01mWA9PXxs84bFEV2mP
 VzC5j6K8U3RNA6cb9bpE5bzXut6T2gxj6j+7TsgMQFhbyH/tZgpDjWvAiPZHb3sV29t8XaOF
 BwzqiI2AEkiWMySiHwCCMsIH9WUH7r7vpwROko89Tk+InpEbiphPjd7qAkyJ+tNIEWd1+MlX
 ZPtOaFLVHhLQ3PLFLkrU3+Yi3tXqpvLE3gO3LM7BTQRV4/npARAA5+u/Sx1n9anIqcgHpA7l
 5SUCP1e/qF7n5DK8LiM10gYglgY0XHOBi0S7vHppH8hrtpizx+7t5DBdPJgVtR6SilyK0/mp
 9nWHDhc9rwU3KmHYgFFsnX58eEmZxz2qsIY8juFor5r7kpcM5dRR9aB+HjlOOJJgyDxcJTwM
 1ey4L/79P72wuXRhMibN14SX6TZzf+/XIOrM6TsULVJEIv1+NdczQbs6pBTpEK/G2apME7vf
 mjTsZU26Ezn+LDMX16lHTmIJi7Hlh7eifCGGM+g/AlDV6aWKFS+sBbwy+YoS0Zc3Yz8zrdbi
 Kzn3kbKd+99//mysSVsHaekQYyVvO0KD2KPKBs1S/ImrBb6XecqxGy/y/3HWHdngGEY2v2IP
 Qox7mAPznyKyXEfG+0rrVseZSEssKmY01IsgwwbmN9ZcqUKYNhjv67WMX7tNwiVbSrGLZoqf
 Xlgw4aAdnIMQyTW8nE6hH/Iwqay4S2str4HZtWwyWLitk7N+e+vxuK5qto4AxtB7VdimvKUs
 x6kQO5F3YWcC3vCXCgPwyV8133+fIR2L81R1L1q3swaEuh95vWj6iskxeNWSTyFAVKYYVskG
 V+OTtB71P1XCnb6AJCW9cKpC25+zxQqD2Zy0dK3u2RuKErajKBa/YWzuSaKAOkneFxG3LJIv
 Hl7iqPF+JDCjB5sAEQEAAcLBXwQYAQIACQUCVeP56QIbDAAKCRD2t4JPQmmgc5VnD/9YgbCr
 HR1FbMbm7td54UrYvZV/i7m3dIQNXK2e+Cbv5PXf19ce3XluaE+wA8D+vnIW5mbAAiojt3Mb
 6p0WJS3QzbObzHNgAp3zy/L4lXwc6WW5vnpWAzqXFHP8D9PTpqvBALbXqL06smP47JqbyQxj
 Xf7D2rrPeIqbYmVY9da1KzMOVf3gReazYa89zZSdVkMojfWsbq05zwYU+SCWS3NiyF6QghbW
 voxbFwX1i/0xRwJiX9NNbRj1huVKQuS4W7rbWA87TrVQPXUAdkyd7FRYICNW+0gddysIwPoa
 KrLfx3Ba6Rpx0JznbrVOtXlihjl4KV8mtOPjYDY9u+8x412xXnlGl6AC4HLu2F3ECkamY4G6
 UxejX+E6vW6Xe4n7H+rEX5UFgPRdYkS1TA/X3nMen9bouxNsvIJv7C6adZmMHqu/2azX7S7I
 vrxxySzOw9GxjoVTuzWMKWpDGP8n71IFeOot8JuPZtJ8omz+DZel+WCNZMVdVNLPOd5frqOv
 mpz0VhFAlNTjU1Vy0CnuxX3AM51J8dpdNyG0S8rADh6C8AKCDOfUstpq28/6oTaQv7QZdge0
 JY6dglzGKnCi/zsmp2+1w559frz4+IC7j/igvJGX4KDDKUs0mlld8J2u2sBXv7CGxdzQoHaz
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <20240606-tcp_ao-tracepoints-v3-3-13621988c09f@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Dmitry,

On 06/06/2024 02:58, Dmitry Safonov via B4 Relay wrote:
> From: Dmitry Safonov <0x7f454c46@gmail.com>
> 
> Two reasons:
> 1. It's grown up enough
> 2. In order to not do header spaghetti by including
>    <trace/events/tcp.h>, which is necessary for TCP tracepoints.
> 
> While at it, unexport and make static tcp_inbound_ao_hash().

Thank you for working on this.
 > Signed-off-by: Dmitry Safonov <0x7f454c46@gmail.com>
> ---
>  include/net/tcp.h | 78 +++----------------------------------------------------
>  net/ipv4/tcp.c    | 66 ++++++++++++++++++++++++++++++++++++++++++++--
>  2 files changed, 68 insertions(+), 76 deletions(-)
> 
> diff --git a/include/net/tcp.h b/include/net/tcp.h
> index e5427b05129b..2aac11e7e1cc 100644
> --- a/include/net/tcp.h
> +++ b/include/net/tcp.h
> @@ -1863,12 +1863,6 @@ tcp_md5_do_lookup_any_l3index(const struct sock *sk,
>  	return __tcp_md5_do_lookup(sk, 0, addr, family, true);
>  }
>  
> -enum skb_drop_reason
> -tcp_inbound_md5_hash(const struct sock *sk, const struct sk_buff *skb,
> -		     const void *saddr, const void *daddr,
> -		     int family, int l3index, const __u8 *hash_location);
> -
> -
>  #define tcp_twsk_md5_key(twsk)	((twsk)->tw_md5_key)
>  #else
>  static inline struct tcp_md5sig_key *
> @@ -1885,13 +1879,6 @@ tcp_md5_do_lookup_any_l3index(const struct sock *sk,
>  	return NULL;
>  }
>  
> -static inline enum skb_drop_reason
> -tcp_inbound_md5_hash(const struct sock *sk, const struct sk_buff *skb,
> -		     const void *saddr, const void *daddr,
> -		     int family, int l3index, const __u8 *hash_location)
> -{
> -	return SKB_NOT_DROPPED_YET;
> -}

It looks like this no-op is still needed, please see below.

>  #define tcp_twsk_md5_key(twsk)	NULL
>  #endif
>  

(...)

> diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> index fa43aaacd92b..80ed5c099f11 100644
> --- a/net/ipv4/tcp.c
> +++ b/net/ipv4/tcp.c
> @@ -4456,7 +4456,7 @@ int tcp_md5_hash_key(struct tcp_sigpool *hp,
>  EXPORT_SYMBOL(tcp_md5_hash_key);
>  
>  /* Called with rcu_read_lock() */
> -enum skb_drop_reason
> +static enum skb_drop_reason
>  tcp_inbound_md5_hash(const struct sock *sk, const struct sk_buff *skb,
>  		     const void *saddr, const void *daddr,
>  		     int family, int l3index, const __u8 *hash_location)
> @@ -4510,10 +4510,72 @@ tcp_inbound_md5_hash(const struct sock *sk, const struct sk_buff *skb,
>  	}
>  	return SKB_NOT_DROPPED_YET;
>  }
> -EXPORT_SYMBOL(tcp_inbound_md5_hash);
>  
>  #endif
>  
> +/* Called with rcu_read_lock() */
> +enum skb_drop_reason
> +tcp_inbound_hash(struct sock *sk, const struct request_sock *req,
> +		 const struct sk_buff *skb,
> +		 const void *saddr, const void *daddr,
> +		 int family, int dif, int sdif)
> +{
> +	const struct tcphdr *th = tcp_hdr(skb);
> +	const struct tcp_ao_hdr *aoh;
> +	const __u8 *md5_location;
> +	int l3index;
> +
> +	/* Invalid option or two times meet any of auth options */
> +	if (tcp_parse_auth_options(th, &md5_location, &aoh)) {
> +		tcp_hash_fail("TCP segment has incorrect auth options set",
> +			      family, skb, "");
> +		return SKB_DROP_REASON_TCP_AUTH_HDR;
> +	}
> +
> +	if (req) {
> +		if (tcp_rsk_used_ao(req) != !!aoh) {
> +			NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPAOBAD);
> +			tcp_hash_fail("TCP connection can't start/end using TCP-AO",
> +				      family, skb, "%s",
> +				      !aoh ? "missing AO" : "AO signed");
> +			return SKB_DROP_REASON_TCP_AOFAILURE;
> +		}
> +	}
> +
> +	/* sdif set, means packet ingressed via a device
> +	 * in an L3 domain and dif is set to the l3mdev
> +	 */
> +	l3index = sdif ? dif : 0;
> +
> +	/* Fast path: unsigned segments */
> +	if (likely(!md5_location && !aoh)) {
> +		/* Drop if there's TCP-MD5 or TCP-AO key with any rcvid/sndid
> +		 * for the remote peer. On TCP-AO established connection
> +		 * the last key is impossible to remove, so there's
> +		 * always at least one current_key.
> +		 */
> +		if (tcp_ao_required(sk, saddr, family, l3index, true)) {
> +			tcp_hash_fail("AO hash is required, but not found",
> +				      family, skb, "L3 index %d", l3index);
> +			return SKB_DROP_REASON_TCP_AONOTFOUND;
> +		}
> +		if (unlikely(tcp_md5_do_lookup(sk, l3index, saddr, family))) {
> +			NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPMD5NOTFOUND);
> +			tcp_hash_fail("MD5 Hash not found",
> +				      family, skb, "L3 index %d", l3index);
> +			return SKB_DROP_REASON_TCP_MD5NOTFOUND;
> +		}
> +		return SKB_NOT_DROPPED_YET;
> +	}
> +
> +	if (aoh)
> +		return tcp_inbound_ao_hash(sk, skb, family, req, l3index, aoh);
> +
> +	return tcp_inbound_md5_hash(sk, skb, saddr, daddr, family,
> +				    l3index, md5_location);

Many selftests are currently failing [1] because of this line: if
CONFIG_TCP_MD5SIG is not defined -- which is currently the case in many
selftests: tc, mptcp, forwarding, netfilter, drivers, etc. -- then this
tcp_inbound_md5_hash() function is not defined:

> net/ipv4/tcp.c: In function ‘tcp_inbound_hash’:
> net/ipv4/tcp.c:4570:16: error: implicit declaration of function ‘tcp_inbound_md5_hash’; did you mean ‘tcp_inbound_ao_hash’? [-Werror=implicit-function-declaration]
>  4570 |         return tcp_inbound_md5_hash(sk, skb, saddr, daddr, family,
>       |                ^~~~~~~~~~~~~~~~~~~~
>       |                tcp_inbound_ao_hash

Do you (or any maintainers) mind replying to this email with this line
[2] so future builds from the CI will no longer pick-up this series?

pw-bot: changes-requested

[1]
https://netdev.bots.linux.dev/contest.html?pw-n=0&branch=net-next-2024-06-06--06-00&test=build
[2]
https://docs.kernel.org/process/maintainer-netdev.html#updating-patch-status

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.


