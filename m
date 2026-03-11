Return-Path: <netdev+bounces-266458-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4InJF97ssGm3ogIAu9opvQ
	(envelope-from <netdev+bounces-266458-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 05:17:34 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C59AA25BE72
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 05:17:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CF454306984E
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 04:17:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 775152BE033;
	Wed, 11 Mar 2026 04:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lnhgTLyR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 791FC28CF4A
	for <netdev@vger.kernel.org>; Wed, 11 Mar 2026 04:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773202635; cv=pass; b=gEFH/KD8DI6OmHTV3ewTNlVXl3RvANcaK5iRUG9XnMlBQTlz6N7Iu0/Hken6A7iS+2kYT12TTdw2t2HyuJdr1whXhaSfqY+1yFFZvl2nHkbdZFNXVJjwLwXuQBjyBV7f0SLx4teHksc/JUIbT7K1Ua1GKb9ul4m/DbW3MiX//Nw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773202635; c=relaxed/simple;
	bh=LYiHq7xvyxJ+Ss27zWLVJLl6BJmg3VSJZYbOUkB7Et8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KMksM/ju48fPik2Z2wMOkkPI5MBIkOwES0UQSikiYqfuFDRVyqVdY4qw+6sxwYHkQlN2w+pK95OUeGqlcQBFJXPAqLSvGp4nmmaSIULDPs145en91NCvKhyPZNlwlfL83laEAmEskGMZM0yNL0+G2QRrO05q5GRUx1YwK/v6y04=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lnhgTLyR; arc=pass smtp.client-ip=74.125.82.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-1271195d2a7so978656c88.0
        for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 21:17:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773202632; cv=none;
        d=google.com; s=arc-20240605;
        b=S4Mm/n6rWkXNebOFFjyBZUG993mEcQ0cIU6C1JikfMEOsfnumeHsuxxLQpHH+tvg0N
         soVKEOdlgL0Gx3FePvndNEa6dA25ohXVpvR7WtnG5urd/cXaCAFWVIgrXzvDPMvXpZps
         AxWimidm6VsqDWij8U60ysbaB0HrODQDQrtesumq81xCWLKUFeO3sK9eh6Y6cQ/hBkMu
         Dq3xau4PufArITFTWymZuzx35Zbh4B1OcFw35p3HBqoEfRL/A2HzfQq6k1pkvA0gnb42
         bbt3xtKmE1G6LkP0yvXSFUdBeCvrTxOBkSsTpvBHH+jblXv7R1FiOcMVKrQMLjr/abga
         M2/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=uENPJmAfC/lW/uop31YwmYzEuEawM2Qvzy11V2b8dlU=;
        fh=kR8e6ZuaHnI0UsFpNaFG7v9nHiyuAL8ry1JSvZm4Zg4=;
        b=UeZkVK4NV4WbpLfjsZZZYNVEkwyzD7s17o7s8b6WX9Qtj8PCjzH6hxludtrs0LmJ0S
         fOBVGvfdBNi+cJBIBqbcS+QWqfVKb81o6xVq1vhNkmW+0MCmg8g1i392Z8x+3V3EsIZO
         EcIN+8PAXsqEs+e16jqvQhjhPSJb6EWglCzZfFyCQmbCZ8wJliBmSBuZtYR6HqhlhmeQ
         JUcvyBKkF/kaaMONgT2ikpIb91pxqpCn5LE5devlNC8gazhho5y/XM2oPAv5UVfYCjnj
         Po2nzGTTqlaT3GztsxtBuysjLgMSUkiCt288EAEXbPdcepwOW8QvJC6l+w5TMzcdkQch
         G97A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773202632; x=1773807432; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uENPJmAfC/lW/uop31YwmYzEuEawM2Qvzy11V2b8dlU=;
        b=lnhgTLyRfLVfMewUYVaEOeEyDtRq9LacjcKIl7iSSNaiLlzNuvgapW+38BKUUvxksN
         XOkduwzTcEWihHbJ5W2lWVEOudewen18SLETQNoLpBZ7U6CC2fkOps7/U9bkwuoX3jsa
         +czBy1YXuGAt+uxVc7GIQlcLZIxSZVcUNjS7XG71NaenNTfU/KWlE1MZET0i98+Q1CMh
         KiXTEm6ZcKg9zsVMRY6dgARuZgFBWaqtp+FyBX+2vYR4v/nokRnxCmir6NyUeF004xn4
         zp5BMFHbPH3v3yEARAbdjlm44OOcAoOXWfXWTisLseXXZp4LlDEhpeIu4ShzYvISJHg9
         DSsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773202632; x=1773807432;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uENPJmAfC/lW/uop31YwmYzEuEawM2Qvzy11V2b8dlU=;
        b=AgCnhVKMjkVMiDdEPYHef6bzinat9A/vU9I4OozqfF5LebSZIotLv+LRQ7MOP78DKr
         EDT33NmQrk8CCpiDXZ7X0y4QwQhlyvemvUtA8KVNE9GZdZqGogPL9LIzOs2F9nJ9U9ff
         p+bUmb4KPS4T9I2niGohAotDy/QYfUk7UiugqZqabU7teHFZQ9goVCFt0x2HQ/MMPBim
         W9Mp71t0J78T0oZHhuKG5YVKHEzopTmb86SAJRVxdAuT0YpDKQz25PCamB5E7XRlorf6
         mTIf2j6p1M3396i453IUmSYWejpExafK9PVYIFlYrumk62dB2Of3yJXa5DgXyaGWE0Fs
         RJ5Q==
X-Forwarded-Encrypted: i=1; AJvYcCUH483/M2yHdGygd8oB5pomTynHneJ3P2Fo9VA7Dg692ta6IWBYYsQBxk2UsnkDOsq98RjxVZw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxB3sECBgGvQJvhkuO3Z2vf7vil0MNxmPNJ/lwKQVVj1ZI2p6xh
	MTwYh6uyrtFjQnmARQwe2L5y+IEp7q8N5Ta1HINmRN7Evj/3t45/pHthumNoQ351wwEFzoj63PP
	JFiXO8jm2Vu50pFnMqnY9ldgTdFP9eLUFJ7AwZVr2
X-Gm-Gg: ATEYQzwdIT1gRYYpanDETJoxK4w2LVEl/nGy9U4diKdmlKHDtnSrKBU3kgAYLzxZ16r
	D8W33hD6u2gLDv4qqyCZFSRnWKy/oaAYt9WbO97Kk1pdGHIR/WjZ1DxSgOzeJc0tEYI71Edgcrl
	KP0tYWGkG9s47it0BTSGXus30OwJeneFtfY3N4oLQU17NSgnj9BmUQkf8JrI14T3mKKUw24hApA
	Fv46tRZrwWlIzcKItuNhERnp23s007SV2xQy8yqSQL8MMRVEWuNH+Y8QxVI8lLdq8cfThVoKB6h
	blpJxp86iMxhYpQsNtBS4TRhRDGYVn2wiw4UXhbOSrHx3wGUW6fK7Sp6iPmDZQqaDgcI4Hg=
X-Received: by 2002:a05:7022:6098:b0:124:9acd:328d with SMTP id
 a92af1059eb24-128e780fa81mr554744c88.22.1773202631872; Tue, 10 Mar 2026
 21:17:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260306-unix-proto-update-null-ptr-deref-v3-0-2f0c7410c523@rbox.co>
 <20260306-unix-proto-update-null-ptr-deref-v3-2-2f0c7410c523@rbox.co>
 <CAAVpQUCdzpwbu=fOrwCnaCFuD3U5SL73PB2nroqgUB4QdJ69og@mail.gmail.com> <3bf84a79-7335-483c-b629-2437e360387d@rbox.co>
In-Reply-To: <3bf84a79-7335-483c-b629-2437e360387d@rbox.co>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Tue, 10 Mar 2026 21:17:00 -0700
X-Gm-Features: AaiRm50MuWsI0wVYgHjWFEMgL9Nc1lx7e73JLHzLZPG4BRs6YGGTA8FHDUMRMq4
Message-ID: <CAAVpQUB8fvyKSQ8UjBs4=FHmz0iME4SO=3CviS_dCzLNTLkjHQ@mail.gmail.com>
Subject: Re: [PATCH bpf v3 2/5] bpf, sockmap: Use sock_map_sk_{acquire,release}()
 where open-coded
To: Michal Luczaj <mhal@rbox.co>
Cc: John Fastabend <john.fastabend@gmail.com>, Jakub Sitnicki <jakub@cloudflare.com>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Willem de Bruijn <willemb@google.com>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>, Yonghong Song <yhs@fb.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Shuah Khan <shuah@kernel.org>, Cong Wang <cong.wang@bytedance.com>, netdev@vger.kernel.org, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: C59AA25BE72
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-266458-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[27];
	FREEMAIL_CC(0.00)[gmail.com,cloudflare.com,google.com,redhat.com,davemloft.net,kernel.org,fb.com,iogearbox.net,linux.dev,fomichev.me,bytedance.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,mail.gmail.com:mid,rbox.co:email]
X-Rspamd-Action: no action

On Fri, Mar 6, 2026 at 6:05=E2=80=AFAM Michal Luczaj <mhal@rbox.co> wrote:
>
> On 3/6/26 06:44, Kuniyuki Iwashima wrote:
> > On Thu, Mar 5, 2026 at 3:32=E2=80=AFPM Michal Luczaj <mhal@rbox.co> wro=
te:
> >>
> >> Instead of repeating the same (un)locking pattern, reuse
> >> sock_map_sk_{acquire,release}(). This centralizes the code and makes i=
t
> >> easier to adapt sockmap to af_unix-specific locking.
> >>
> >> Signed-off-by: Michal Luczaj <mhal@rbox.co>
> >> ---
> >>  net/core/sock_map.c | 21 +++++++--------------
> >>  1 file changed, 7 insertions(+), 14 deletions(-)
> >>
> >> diff --git a/net/core/sock_map.c b/net/core/sock_map.c
> >> index 02a68be3002a..7ba6a7f24ccd 100644
> >> --- a/net/core/sock_map.c
> >> +++ b/net/core/sock_map.c
> >> @@ -353,11 +353,9 @@ static void sock_map_free(struct bpf_map *map)
> >>                 sk =3D xchg(psk, NULL);
> >>                 if (sk) {
> >>                         sock_hold(sk);
> >> -                       lock_sock(sk);
> >> -                       rcu_read_lock();
> >> +                       sock_map_sk_acquire(sk);
> >>                         sock_map_unref(sk, psk);
> >> -                       rcu_read_unlock();
> >> -                       release_sock(sk);
> >> +                       sock_map_sk_release(sk);
> >>                         sock_put(sk);
> >>                 }
> >>         }
> >> @@ -1176,11 +1174,9 @@ static void sock_hash_free(struct bpf_map *map)
> >>                  */
> >>                 hlist_for_each_entry_safe(elem, node, &unlink_list, no=
de) {
> >>                         hlist_del(&elem->node);
> >> -                       lock_sock(elem->sk);
> >> -                       rcu_read_lock();
> >> +                       sock_map_sk_acquire(elem->sk);
> >>                         sock_map_unref(elem->sk, elem);
> >> -                       rcu_read_unlock();
> >> -                       release_sock(elem->sk);
> >> +                       sock_map_sk_release(elem->sk);
> >>                         sock_put(elem->sk);
> >>                         sock_hash_free_elem(htab, elem);
> >>                 }
> >> @@ -1676,8 +1672,7 @@ void sock_map_close(struct sock *sk, long timeou=
t)
> >>         void (*saved_close)(struct sock *sk, long timeout);
> >>         struct sk_psock *psock;
> >>
> >> -       lock_sock(sk);
> >> -       rcu_read_lock();
> >> +       sock_map_sk_acquire(sk);
> >>         psock =3D sk_psock(sk);
> >>         if (likely(psock)) {
> >>                 saved_close =3D psock->saved_close;
> >> @@ -1685,16 +1680,14 @@ void sock_map_close(struct sock *sk, long time=
out)
> >>                 psock =3D sk_psock_get(sk);
> >>                 if (unlikely(!psock))
> >>                         goto no_psock;
> >> -               rcu_read_unlock();
> >>                 sk_psock_stop(psock);
> >> -               release_sock(sk);
> >> +               sock_map_sk_release(sk);
> >
> > I think sk_psock_stop() was intentionally put outside
> > of rcu_read_lock() to not extend the grace period
> > unnecessarily. e.g. while + __sk_msg_free().
> >
> > Maybe add __sock_map_sk_release() without
> > rcu_read_unlock() ?
>
> How about dropping this patch completely? The more I stare at it, I see n=
o
> reason why af_unix state lock would matter in any of these places.

I agree.  Actually, once it's held, it can be released right away.
The lock is only to ensure that peer is set after checking
TCP_ESTABLISHED, but it continues holding unix_state_lock()
unnecessarily long.

Honestly I prefer Martin's idea, using unix_peer_get() in
unix_stream_bpf_update_proto().

