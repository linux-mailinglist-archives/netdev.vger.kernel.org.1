Return-Path: <netdev+bounces-279693-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8DhJBvjv5WnCpQEAu9opvQ
	(envelope-from <netdev+bounces-279693-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 11:20:56 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A078428C7D
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 11:20:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8B79D3008261
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 09:20:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B08DC389E1F;
	Mon, 20 Apr 2026 09:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vhr8lB6W"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C0E4386551;
	Mon, 20 Apr 2026 09:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776676852; cv=none; b=md+jMu7pzKkm6A5Yrm/VmW8LNI8rymgjMEy88SFkFRl8euaC8DVYWR/sverDRYoCmoxhFPY+rKAfbBqGbd3e7TwcAEE4BtqK8HaMDJAbCf37y1ZEGtBIflj8HLW6sZ7r/4HuePoKS4jqsBiPAI5PkTKLTzLKScI/gid+0ra0pb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776676852; c=relaxed/simple;
	bh=gkxq/Nwp4gagSaRmvJoBhNBlh7EipRtZPgiQOKbMmbY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=quwuBfsGfy57DqduQ/noiCcS8xLSt8TlXvJZIOQWZJ5KSzOZO0qVT4Ypqp3l3ggIYEOCbu9sAyfb1EhkeW/IyYzFIRQWP8Mn3l6tqbJ+ehqgEVpRVG43k3UmDxmornMhA+q8T4qn1SNz+AodvEm84nG1SlxwVyqJXvXVkloF1Hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vhr8lB6W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABA9BC19425;
	Mon, 20 Apr 2026 09:20:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776676852;
	bh=gkxq/Nwp4gagSaRmvJoBhNBlh7EipRtZPgiQOKbMmbY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Vhr8lB6WPXOuWuiUUP+s1XBKwOSqKNCLG1s4ZC4gD7FFdxX8lAhpVu3POQ/U3bEU2
	 tVZGt5hbIQkFAlhdw+2hOl7GF2xFPO+W1LLqocpDf/EyYetBJhPKASiw4Hik0DM0p4
	 QXqjgyJiWfOJDuqL3nnbsURXqzV8pdnoXVLfjYcZrf0H7RINmNdv2cmFvU2tmZUgQr
	 ehL5rvLWiMVRvf5OPVzFLuI0AM0kxSfe9HNOvyNlOXkNpWqGWVSWTOnVAozykwlVO6
	 hAXu05YwiM84o017wMRAfKcn1oRhxDmISEzP9WUCX/CaV0e/kl9Cx3ngjvp+JL2nw2
	 AHIyKG2eJdx+w==
Message-ID: <fcdaad38-573e-47c1-b8d4-f89fcc728142@kernel.org>
Date: Mon, 20 Apr 2026 11:20:44 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [RFC PATCH net] mptcp: pm: fix ADD_ADDR timer infinite retry on
 option space insufficient
Content-Language: fr
To: Li Xiasong <lixiasong1@huawei.com>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev,
 linux-kernel@vger.kernel.org, yuehaibing@huawei.com,
 zhangchangzhong@huawei.com, weiyongjun1@huawei.com,
 Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>
References: <20260418100018.2219500-1-lixiasong1@huawei.com>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <20260418100018.2219500-1-lixiasong1@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-279693-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	HAS_ORG_HEADER(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[matttbe@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9A078428C7D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Li,

On 18/04/2026 12:00, Li Xiasong wrote:
> When TCP option space is insufficient (e.g., IPv6 with tcp_timestamps
> enabled), the original code jumped to out_unlock without clearing the
> addr_signal flag. This caused mptcp_pm_add_timer to keep rescheduling
> indefinitely without sending ADD_ADDR,

Funny, I was looking at this issue on Friday evening :)

> preventing the endpoint list from being traversed.

It might help to add a bit of context: I guess here you meant that it
prevent advertising other ADD_ADDR, not using other subflows when
sending data, right?

> In a pure ACK scenario (indicated by drop_other_suboptions=true), if
> the option space is insufficient to carry the ADD_ADDR suboption, it
> is appropriate to drop this address signal to allow the timer handler
> to move on to other addresses.
> 
> Fixes: 00cfd77b9063 ("mptcp: retransmit ADD_ADDR when timeout")
> Signed-off-by: Li Xiasong <lixiasong1@huawei.com>
> ---
> 
> Seeking feedback on:
> 
> When announcing addresses to the peer, MPTCP sends a pure ACK packet
> to carry MPTCP options (ADD_ADDR). In this scenario, if the option space
> is insufficient for ADD_ADDR, clearing addr_signal would:
> 
>   - Prevent the timer from retrying infinitely
>   - Allow the timer to continue traversing and processing other addresses
>   - Not block other subflow creation or address announcement operations
> 
> Is there any scenario where we should retry later instead of clearing
> the address signal/echo flag? However, if a pure ACK doesn't have
> enough space for the flag, subsequent packets won't either.

That's correct: for the moment, if it is a pure ACK and there is not
enough space, no need to retry later because it is not possible to have
more space. It should only happen with an ADD_ADDR containing an IPv6
address and a port number. It might be good to specify this in the
commit message.

> ---
>  net/mptcp/pm.c | 17 ++++++++---------
>  1 file changed, 8 insertions(+), 9 deletions(-)
> 
> diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
> index 57a456690406..1d49779c6a1f 100644
> --- a/net/mptcp/pm.c
> +++ b/net/mptcp/pm.c
> @@ -881,19 +881,18 @@ bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk, const struct sk_buff *skb,
>  	}
>  
>  	*echo = mptcp_pm_should_add_signal_echo(msk);
> +	add_addr = msk->pm.addr_signal &
> +		~(*echo ? BIT(MPTCP_ADD_ADDR_ECHO) : BIT(MPTCP_ADD_ADDR_SIGNAL));
>  	port = !!(*echo ? msk->pm.remote.port : msk->pm.local.port);
> -
>  	family = *echo ? msk->pm.remote.family : msk->pm.local.family;

nit: while at it, maybe clearer to have a dedicated 'if (*echo)' instead
of 3 lines with '*echo ? ... : ..., no?

  if (*echo) {
      add_addr = ...
      port = ...
      family = ...
  } else {
      add_addr = ...
      port = ...
      family = ...
  }

> -	if (remaining < mptcp_add_addr_len(family, *echo, port))
> -		goto out_unlock;
>  
> -	if (*echo) {
> -		*addr = msk->pm.remote;
> -		add_addr = msk->pm.addr_signal & ~BIT(MPTCP_ADD_ADDR_ECHO);
> -	} else {
> -		*addr = msk->pm.local;
> -		add_addr = msk->pm.addr_signal & ~BIT(MPTCP_ADD_ADDR_SIGNAL);
> +	if (remaining < mptcp_add_addr_len(family, *echo, port)) {
> +		if (*drop_other_suboptions)
> +			WRITE_ONCE(msk->pm.addr_signal, add_addr);

If it is dropped, it would be helpful to increment the ADDADDRTXDROP MIB
counter, and ideally check that in the MPTCP selftests (e.g. adding a
new subtest in mptcp_join.sh, in add_addr_ports_tests()?).

Also, I wonder if it would not be clearer to jump to a new label here...

> +		goto out_unlock;
>  	}
> +
> +	*addr = *echo ? msk->pm.remote : msk->pm.local;
>  	WRITE_ONCE(msk->pm.addr_signal, add_addr);
>  	ret = true;

... inverting the two lines above, and adding "drop_signal_mark" label?

Apart from the comments above, I think your patch is doing the right thing.

Also, one last request: do you mind sending the v2 only to the mptcp ML,
please? I have a bunch of related fixes [1] plus this one is not urgent.

In fact, except for (urgent) fixes, it might be better to send MPTCP
patches only the to MPTCP ML: to a restricted number of people for the
first versions, there is enough traffic on Netdev.

[1]
https://lore.kernel.org/20260415-mptcp-inc-limits-v5-0-e54c3bf80e4e@kernel.org

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.


