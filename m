Return-Path: <netdev+bounces-263940-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WIELJSpnqGl3uQAAu9opvQ
	(envelope-from <netdev+bounces-263940-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 18:08:58 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B1F83204E2C
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 18:08:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5A0D2300EAB0
	for <lists+netdev@lfdr.de>; Wed,  4 Mar 2026 17:02:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8C7C36492C;
	Wed,  4 Mar 2026 17:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t0UypVJe"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B628C33FE36
	for <netdev@vger.kernel.org>; Wed,  4 Mar 2026 17:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772643743; cv=none; b=mDXk336N5P2B3mLV4yHJAAHOiQvLSYx2GxyX8pUawCS4yIjtER5Q7l/90p1/JFwS5gpnNcUpjUEC1FQKxVUO++tFaIZqmHO8Ey7KALF6up2eDMJmpwWnPKhzy0D9sHbDnXwkGXqWj7RQ7mZzOixadnMDqAyd61W5ZZgjxu0CQl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772643743; c=relaxed/simple;
	bh=YHoWiN0Q/dqrpL8UBiuYjF8UcdsXI7XJMIeRNcVQWkY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T87VFxFHL4vNxkQVCE2f7z3ivKwkm6tyI0V1Gf7dzF5FF+m9lGvLQCct87FLzkVQZfi8B6vwWsmEapOa2G67I9x9pyk229nwj1xtkR9PYTci4hdo8dLjjDpEx17ekjETk/bcG/OrJl3uvxhpV5ltRD0EjZsJwVTuvigahot+iSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t0UypVJe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07107C4CEF7;
	Wed,  4 Mar 2026 17:02:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772643743;
	bh=YHoWiN0Q/dqrpL8UBiuYjF8UcdsXI7XJMIeRNcVQWkY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=t0UypVJeihA9Nt5LlzFSZE+KkIE3cTrd3WQpyTSkVUcE0skWQi5C5NNHM4I+XbGkO
	 2sWN5NECRhlF946zB2XB8Lik8aMWMGzgbpqCJKKF+rOsHUfHAQkGR7L0WF6jxXEOMd
	 2KP8UdoHfC3iugT2FOjT08awPNauWMWe1lbjym4KahENeFv4UddYAB4raMK/+YbBhM
	 0kKZfJq05SaPZaEymbg75cCtD872BUL7ymuFAiWGvCywUGKDPSXXjrOxNCqM4WrHkD
	 2UlhI84cPa+laiQMzy53HHVY2DF4lGjolxRIisuaIVkOSJqEqgArYevxiju0sA/FZA
	 e7ORgSAEJ5DIA==
Message-ID: <5201b1dd-ddf2-40d5-89d0-d83ad17d5df8@kernel.org>
Date: Wed, 4 Mar 2026 10:02:22 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] inet_diag: report delayed ack timer information
Content-Language: en-US
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Neal Cardwell <ncardwell@google.com>,
 Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org,
 eric.dumazet@gmail.com
References: <20260304094318.1769536-1-edumazet@google.com>
 <93b5fb6d-7aa0-481f-823f-995ed8ab0e52@kernel.org>
 <CANn89i+SQd4H7q=ELJp7-aaN5PyZ-Oakoy9MHZpbuX1iGKV1ag@mail.gmail.com>
 <CANn89iKvXbBGXb7Uzu9ZCi+M65SwmMxoGM0C-HR6cO1+PxyYbA@mail.gmail.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <CANn89iKvXbBGXb7Uzu9ZCi+M65SwmMxoGM0C-HR6cO1+PxyYbA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: B1F83204E2C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,google.com,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-263940-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dsahern@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On 3/4/26 9:55 AM, Eric Dumazet wrote:
> On Wed, Mar 4, 2026 at 5:00 PM Eric Dumazet <edumazet@google.com> wrote:
>>
>> On Wed, Mar 4, 2026 at 4:48 PM David Ahern <dsahern@kernel.org> wrote:
>>>
>>> On 3/4/26 2:43 AM, Eric Dumazet wrote:
>>>> inet_sk_diag_fill() populates r->idiag_timer with the following
>>>> precedence order:
>>>>
>>>> 1 - Retransmit timer.
>>>> 4 - Probe0 timer.
>>>> 2 - Keepalive timer.
>>>>
>>>> This patch adds a new value, last in the list, if other timers
>>>> are not active.
>>>>
>>>> 5 - Delayed ACK timer.
>>>>
>>>> A corresponding iproute2 patch is needed to replace "unknown"
>>>> with "delack":
>>>
>>> ...
>>>
>>>> diff --git a/net/ipv4/inet_diag.c b/net/ipv4/inet_diag.c
>>>> index 9d215485b5c7e7ba29dd53c924f0245439d74af5..e4cb18061aefcc22df04644c00bf5c7db4e150d2 100644
>>>> --- a/net/ipv4/inet_diag.c
>>>> +++ b/net/ipv4/inet_diag.c
>>>> @@ -298,6 +298,10 @@ int inet_sk_diag_fill(struct sock *sk, struct inet_connection_sock *icsk,
>>>>               r->idiag_retrans = READ_ONCE(icsk->icsk_probes_out);
>>>>               r->idiag_expires =
>>>>                       jiffies_delta_to_msecs(icsk->icsk_keepalive_timer.expires - jiffies);
>>>> +     } else if (timer_pending(&icsk->icsk_delack_timer)) {
>>>> +             r->idiag_timer = 5;
>>>
>>> How come the idiag_timer values an enum in
>>> include/uapi/linux/inet_diag.h since this is a uapi?
>>
>> Yes, this can be done, although we survived all these years without it.
>>
>> Do you want to send a patch or should I implement this idea ?
> 
> I will squash in V2 :
> 
> diff --git a/include/uapi/linux/inet_diag.h b/include/uapi/linux/inet_diag.h
> index 86bb2e8b17c9f197fd49cf7996d5e4f555a9b8e8..21f0d735fbae206cf2e1e573912a324bb2eb64d9
> 100644
> --- a/include/uapi/linux/inet_diag.h
> +++ b/include/uapi/linux/inet_diag.h
> @@ -129,6 +129,15 @@ struct inet_diag_msg {
>         __u32   idiag_inode;
>  };
> 
> +enum {
> +       IDIAG_TIMER_OFF,
> +       IDIAG_TIMER_ON,
> +       IDIAG_TIMER_KEEPALIVE,
> +       IDIAG_TIMER_TIMEWAIT,
> +       IDIAG_TIMER_PROBE0,
> +       IDIAG_TIMER_DELACK,
> +};
> +
>  /* Extensions */
> 
>  enum {
> diff --git a/net/ipv4/inet_diag.c b/net/ipv4/inet_diag.c
> index e4cb18061aefcc22df04644c00bf5c7db4e150d2..34b77aa87d0a48bcbceb7f2935a210a347812cc6
> 100644
> --- a/net/ipv4/inet_diag.c
> +++ b/net/ipv4/inet_diag.c
> @@ -241,7 +241,7 @@ int inet_sk_diag_fill(struct sock *sk, struct
> inet_connection_sock *icsk,
> 
>         inet_diag_msg_common_fill(r, sk);
>         r->idiag_state = sk->sk_state;
> -       r->idiag_timer = 0;
> +       r->idiag_timer = IDIAG_TIMER_OFF;
>         r->idiag_retrans = 0;
>         r->idiag_expires = 0;
> 
> @@ -284,22 +284,23 @@ int inet_sk_diag_fill(struct sock *sk, struct
> inet_connection_sock *icsk,
>         if (icsk_pending == ICSK_TIME_RETRANS ||
>             icsk_pending == ICSK_TIME_REO_TIMEOUT ||
>             icsk_pending == ICSK_TIME_LOSS_PROBE) {
> -               r->idiag_timer = 1;
> +               r->idiag_timer = IDIAG_TIMER_ON;
>                 r->idiag_retrans = READ_ONCE(icsk->icsk_retransmits);
>                 r->idiag_expires =
>                         jiffies_delta_to_msecs(tcp_timeout_expires(sk)
> - jiffies);
>         } else if (icsk_pending == ICSK_TIME_PROBE0) {
> -               r->idiag_timer = 4;
> +               r->idiag_timer = IDIAG_TIMER_PROBE0;
>                 r->idiag_retrans = READ_ONCE(icsk->icsk_probes_out);
>                 r->idiag_expires =
>                         jiffies_delta_to_msecs(tcp_timeout_expires(sk)
> - jiffies);
>         } else if (timer_pending(&icsk->icsk_keepalive_timer)) {
> -               r->idiag_timer = 2;
> +               r->idiag_timer = IDIAG_TIMER_KEEPALIVE;
>                 r->idiag_retrans = READ_ONCE(icsk->icsk_probes_out);
>                 r->idiag_expires =
> 
> jiffies_delta_to_msecs(icsk->icsk_keepalive_timer.expires - jiffies);
> -       } else if (timer_pending(&icsk->icsk_delack_timer)) {
> -               r->idiag_timer = 5;
> +       } else if ((READ_ONCE(icsk->icsk_ack.pending) & ICSK_ACK_TIMER) &&
> +                  timer_pending(&icsk->icsk_delack_timer)) {
> +               r->idiag_timer = IDIAG_TIMER_DELACK;
>                 r->idiag_expires =
> 
> jiffies_delta_to_msecs(icsk_delack_timeout(icsk) - jiffies);
>         }
> diff --git a/net/ipv4/tcp_diag.c b/net/ipv4/tcp_diag.c
> index d83efd91f461c8ad0157faeebae051b32cb07bf4..3e8ee2054466e109644a758f8b4f0a646e22e456
> 100644
> --- a/net/ipv4/tcp_diag.c
> +++ b/net/ipv4/tcp_diag.c
> @@ -212,7 +212,7 @@ static int tcp_twsk_diag_fill(struct sock *sk,
>         r->idiag_retrans      = 0;
> 
>         r->idiag_state        = READ_ONCE(tw->tw_substate);
> -       r->idiag_timer        = 3;
> +       r->idiag_timer        = IDIAG_TIMER_TIMEWAIT;
>         tmo = tw->tw_timer.expires - jiffies;
>         r->idiag_expires      = jiffies_delta_to_msecs(tmo);
>         r->idiag_rqueue       = 0;


thank you,.

Reviewed-by: David Ahern <dsahern@kernel.org>


