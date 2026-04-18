Return-Path: <netdev+bounces-279476-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id PMZUBm4e42nOCAEAu9opvQ
	(envelope-from <netdev+bounces-279476-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 18 Apr 2026 08:02:22 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C990420167
	for <lists+netdev@lfdr.de>; Sat, 18 Apr 2026 08:02:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E1BB5302A681
	for <lists+netdev@lfdr.de>; Sat, 18 Apr 2026 06:02:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F236727AC45;
	Sat, 18 Apr 2026 06:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rK84Jq0F"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89A8D2475E3
	for <netdev@vger.kernel.org>; Sat, 18 Apr 2026 06:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776492138; cv=pass; b=TYmPjTA79Govs2vXF+ittrzpUTQW9aUWhqnJuzUnD+ejZUJcDhq5DaTxAq+dOFm1aCv8pZ42hlZ5DOffVHMH3GsbbfzZEAMDd4aL85PU6fuuvQNk0gEUl4lFMgM0IEgxReqVrsze/VClEYjC8gG5/oEwBI8n33l42CUVd9E2FPE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776492138; c=relaxed/simple;
	bh=+DxAgjOGYsbq78L0ygJnRzmXFkqF5BzidbIYSSplQ98=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uhSizKgfV6sr/pGqEzipSE6Vla/3OWQqhlYOY5Nf/MddkS3KmBFo9k4bKcQ3lDPuv1gvJySdsCa3qxa3S6UeR0HyqF052SaRxQJxK0DPWeCqL/eSzXoW4K2em3FsFhCChwihDqMAgxV/UU5RfQ8oWKm6nD+N9mE8/vkC9dDmx20=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rK84Jq0F; arc=pass smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-8aca0469204so15426906d6.2
        for <netdev@vger.kernel.org>; Fri, 17 Apr 2026 23:02:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776492136; cv=none;
        d=google.com; s=arc-20240605;
        b=PLZ4QVm18ZqPCmvkP8SNUaJfRXPSuxqmvUMdwwixrHfuIQewaZWwy4bJI9OCjtBUnW
         CCJw0I1ikylZMTVwU677lJmb5Syhd24gbf5j57LvYkc9U8aK9bcpRJhTLgDPsBpbPOrI
         38/h9nkmzsym/pyB04c9ZNqKukf7FyyybrHVpqIk4QodL0e5XOUM4bFKzIVIk7AjRvtM
         kaEeckPG8qLVXgpEC5X+xnlg6ytAeYRUH268L+R0Ga7ywpcmZMZovhVGOxtySkQrGBt/
         vEMyAGlJ9mSOKj02vdjFCY9+DnA28rKJmrF3NUkZLr33im1ujd0oqOua42pFXdU2e+Cn
         0jng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=D8Cw2/LxkFW8q0BKiXupLWBPBKSpdwnTq/LIei0Fzfc=;
        fh=Awrco3dRq6rRba0geolah6bcgAgwGukE+i0cFcadf3U=;
        b=hfExQg76dJ4p0zjYupKe4jz9fXUBXmDP2cecjl0WBRLe98VT1Z82yNhPaqUuhezXbi
         5drM1kPPBaAOELLUSEMHQZ+7hX8nBp34i6QevCOPFtu/uXBsqGhVguPpe/Zhwv2lX+BG
         Yy66mdX8apm7/D50SCZG7ptEKL2aEosEYxFeerxKOe17DrfX88IkvFxcldbpjPdmdXKL
         DXA3XI6WtATq0MYvhwnQLaAAuO+9yyibXoFOaVQBQDxc9BdMlHxDPtP6cZrF/dTZKcP9
         svktU8FXx7zsr8JJj+p1rc2UrVJlCjCdIw2+uXchkJ35EeEphRmTMTfvwqWKLRf/0OnW
         RwAA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776492136; x=1777096936; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D8Cw2/LxkFW8q0BKiXupLWBPBKSpdwnTq/LIei0Fzfc=;
        b=rK84Jq0FT1tYluOd8vbtfXAC10Qs9byzVsz6z0XwZdY0qmt0Q7SDK8sw4Hc2tfiweP
         sXTUgDzb5H8kpMCOGQooa8XvvELGL0txWrO9CP7gyVimrDL6Ov05YAKYABm/6LIuSPm4
         1drGyZdMz6XLmgLVZt1hIpWgF7k0y3bjllAkWiQhxzcO8nS5MMtxMB0LlQNhgdiH6AuW
         dai/E4nVrgioJWmlHOZWXUp5CPOEUTxLgUYj0g/F455C4jcQTh6gQOQbb7nLvUqIMzGf
         wjXiCigFI0iYIWyTyG2iBG0QPUeNP3QSzDfi1rCp5Kr78IXp9RWZ5l1kYFHmT99su8Md
         ESDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776492136; x=1777096936;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=D8Cw2/LxkFW8q0BKiXupLWBPBKSpdwnTq/LIei0Fzfc=;
        b=de765P0pCAjJllD1RB45ihsrdOVWWsZbDKe12GQAYAup40V+XN9rOsYxYEAxlq4uCw
         7KCfAUN/oGXcpEzptoEB2/DC0jSyGHWnaCW9Q1Ujo2dybAmwvP6R0rb4ZFWoF5JhtbFq
         3Z05w5ae72+y5DF90k9TEYlXe3tKKx4kFLPKj4KrO3kBtFjQkN1bFElteqSYcX8eBBPY
         UahYBD3Ku1dz6yni1ue9jKvRaWoOQR/rG+Vpyq8dpXhfMdBfqc8cHOSuV7PztC9z7fe5
         3W9BxhFGJoK3eHl4XURmzqX5SwGV9P/sqCVm0GbPJSBTgFf7V5NUv8ucWOJD+Lx/Dx4E
         3/Dw==
X-Gm-Message-State: AOJu0YzVPVuMmRW8RQMMlaOSsqp+AwHJOkyeF2wUtdO8vF1ib2+O4xiT
	n9xDvU73kkvZaUr3A2G4iuV0XEjdFqwIeIta+E1jQttuglyC4011BhuStCUE2SRQ3RKWEpsumaI
	n66wRJ6Ksd2yZCpirUPJIhwjOYkZ9EEW0Tk4umLgl
X-Gm-Gg: AeBDiesQNyCSQm7hfaqyFDa/fGefyBJi04of50CqJqllgTrrwMcovQoN8nRTZxvlpIK
	VumLpqtAsY++hQTfkcjD+tyRb3hNKccv9+V95EmMkm0l4yFzXMB1gbrURY4/vQ0KLjqdZk1+AEI
	0SQuimQoJaQq84LvzECs22TvqsFgknggUEsXIm4DHmU30wYY0x5ShkhOplnu+V0vJxF/41iyEOc
	QLnafIg4WHaK+DeGid/oo3S9BApuldqo1IBYju3erkO/s04LuGpp3fgIdRJUUMBPlQQ8x8LBJQ6
	kuIEvfgctjZTte2WJkqsOF4byPzkusLCxAy/28Dm/0wqLWbgr1dU6JUEa1uIHN6Uhkjw9TD4VaO
	GHaazsObk
X-Received: by 2002:a05:6214:4e14:b0:89c:eabb:f58d with SMTP id
 6a1803df08f44-8b02813b256mr81180536d6.47.1776492136072; Fri, 17 Apr 2026
 23:02:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260418041633.691435-1-jt26wzz@gmail.com> <20260418041633.691435-2-jt26wzz@gmail.com>
In-Reply-To: <20260418041633.691435-2-jt26wzz@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 17 Apr 2026 23:02:04 -0700
X-Gm-Features: AQROBzA36i8s0WTRa6QsFOr6av2JTG94HxbtoID-4rUHJyFb0GkqUURu9fQz6kk
Message-ID: <CANn89iJOfDB+5oORjWPbP7Z1SyqUhMzVR8u8i+8P8MPDgg_EGA@mail.gmail.com>
Subject: Re: [PATCH net 1/2] tcp: call sk_data_ready() after listener migration
To: Zhenzhong Wu <jt26wzz@gmail.com>
Cc: netdev@vger.kernel.org, ncardwell@google.com, kuniyu@google.com, 
	davem@davemloft.net, dsahern@kernel.org, kuba@kernel.org, pabeni@redhat.com, 
	horms@kernel.org, shuah@kernel.org, tamird@kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-279476-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 5C990420167
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Apr 17, 2026 at 9:17=E2=80=AFPM Zhenzhong Wu <jt26wzz@gmail.com> wr=
ote:
>
> When inet_csk_listen_stop() migrates an established child socket from
> a closing listener to another socket in the same SO_REUSEPORT group,
> the target listener gets a new accept-queue entry via
> inet_csk_reqsk_queue_add(), but that path never notifies the target
> listener's waiters.
>
> As a result, a nonblocking accept() still succeeds because it checks
> the accept queue directly, but waiters that sleep for listener
> readiness can remain asleep until another connection generates a
> wakeup. This affects poll()/epoll_wait()-based waiters, and can also
> leave a blocking accept() asleep after migration even though the
> child is already in the target listener's accept queue.
>
> This was observed in a local test where listener A completed the
> handshake, queued the child, and was closed before userspace called
> accept(). The child was migrated to listener B, but listener B never
> received a wakeup for the migrated accept-queue entry.
>
> Call READ_ONCE(nsk->sk_data_ready)(nsk) after a successful migration
> in inet_csk_listen_stop().
>
> The reqsk_timer_handler() path does not need the same change:
> half-open requests only become readable to userspace when the final
> ACK completes the handshake, and tcp_child_process() already wakes
> the listener in that case.
>
> Fixes: 54b92e841937 ("tcp: Migrate TCP_ESTABLISHED/TCP_SYN_RECV sockets i=
n accept queues.")
> Cc: stable@vger.kernel.org
> Signed-off-by: Zhenzhong Wu <jt26wzz@gmail.com>
> ---
>  net/ipv4/inet_connection_sock.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection_s=
ock.c
> index 4ac3ae1bc..da1ce082f 100644
> --- a/net/ipv4/inet_connection_sock.c
> +++ b/net/ipv4/inet_connection_sock.c
> @@ -1483,6 +1483,7 @@ void inet_csk_listen_stop(struct sock *sk)
>                                         __NET_INC_STATS(sock_net(nsk),
>                                                         LINUX_MIB_TCPMIGR=
ATEREQSUCCESS);
>                                         reqsk_migrate_reset(req);
> +                                       READ_ONCE(nsk->sk_data_ready)(nsk=
);

I think this is adding a potential UAF (Use Afte Free).
@nsk might have been freed already by another thread/cpu.
Note the existing code already has similar issues.

Untested patch:

diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection_soc=
k.c
index 4ac3ae1bc1afc3a39f2790e39b4dda877dc3272b..287b6e01c4f71bfec3dd2a708f3=
16224d9eb4a64
100644
--- a/net/ipv4/inet_connection_sock.c
+++ b/net/ipv4/inet_connection_sock.c
@@ -1479,6 +1479,7 @@ void inet_csk_listen_stop(struct sock *sk)
                        if (nreq) {
                                refcount_set(&nreq->rsk_refcnt, 1);

+                               rcu_read_lock();
                                if (inet_csk_reqsk_queue_add(nsk,
nreq, child)) {
                                        __NET_INC_STATS(sock_net(nsk),

LINUX_MIB_TCPMIGRATEREQSUCCESS);
@@ -1489,7 +1490,7 @@ void inet_csk_listen_stop(struct sock *sk)
                                        reqsk_migrate_reset(nreq);
                                        __reqsk_free(nreq);
                                }
-
+                               rcu_read_unlock();
                                /* inet_csk_reqsk_queue_add() has already
                                 * called inet_child_forget() on failure ca=
se.
                                 */

