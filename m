Return-Path: <netdev+bounces-266463-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0DpkIkz2sGmHpAIAu9opvQ
	(envelope-from <netdev+bounces-266463-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 05:57:48 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E19E525C18C
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 05:57:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 23D5E30FD73F
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 04:57:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 761313016F5;
	Wed, 11 Mar 2026 04:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fWiDsEEi"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 520A92E0925
	for <netdev@vger.kernel.org>; Wed, 11 Mar 2026 04:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773205060; cv=pass; b=W5BwLEGG5RTA+60Ev3YPDtVhS4No0wJxueUbZRUJ5hx9P1yL83MdcS1Jzj0mzbenTCXZqTYKhNad41GqhwY4mOQ+iCCReAXzbZ1T2f/wVF53v+ahiXDH7lsh8nawplm9HLcogIBqbQXH3w3DjLhsP51MXaYal5+zfkF+aMGoRfY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773205060; c=relaxed/simple;
	bh=tQUkS47wbxvGDRbtPbZgzsO0VSZeaXsZKqGOpWvmQkY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bXiWvjB/E7iMPOQ0fZ1fiWa1EbaYOGyU8Oj15O4RXi2OpfGeIzmTzU7Fj1pOzUff2/r6f+62L6t6WuP1VeIJ5SileR4girxSoQdIxqgEcmE+Ixp95AZwkpB+HZtbybiq82N5ngCxQDGFytBUWiwWSy4Qt2YbEIrCQy21mGsi1VM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fWiDsEEi; arc=pass smtp.client-ip=74.125.82.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-127380532eeso955166c88.1
        for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 21:57:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773205057; cv=none;
        d=google.com; s=arc-20240605;
        b=HVzkdANHIFlh7KAGvm6lpapLzjmsF3CApU7ruZ/o3OD4e+d9YNHTmYY4wfym9AmkwL
         mqjwFqSvl1i1laGA457V2sfbjT+v768oOR+RySKA28ap2yufaeDi3CZK4+qita9Dw9w9
         Ezq/udDae7dpENCE6+RrRKNjQEODtOkUMb94mVZpFDZO0VJ/NlH9g4U1kL0ebWsqhDgB
         sbzHDZ276Pj5gxvHQBmgj7jtCJ1y5OBjmd4zeXFjWazoIjANg5SI5Yn0mNZcxiDKp3Bt
         iJeA3urJ6rSnAl2S6mCJV2vETkzthrdefPY5XJYOAzLp3PtPPaLJUzxqInt/fmXdvNOC
         qp5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Ag1Q7iiQTmW1LyMcYibmgdn2+ZlfPyr/1PUridSt8jo=;
        fh=7/pcJOxJzsQz3zOCYfqq8aV2ADgynL68RuHIOcBoPDg=;
        b=VfnM1Nwe/1MNRB/YCCzliSRzs4YOso9l2vUDapyTkiFVEkyeO0NUIdPJpy0Qf+Wyqc
         Y9AM6of1ZLUWapKvQ7SNs5q7+xFjKdkQPqbMfd3HpXutRuUN/RjGKaF/+FTDkSRhUoVE
         i9iSGzPPWhV3RkgCIs3WOrqdpI7BBLmsKWzKeY1XibeIZ64imsml7LNOzVYTECkLdY1A
         3pVIuVFAcmHR43Y22IRIwNa4KuKl3VsvHcgmlIuEBJQb4KOrl7fAzW/EW2RPoWqleKEH
         /LfhqMoMe1RDvDb+5Y95fV8YHMmvtyoMR3/bwfCy/98uRJc7zVDr7s9zk+XMPrR3Bc3x
         RXmg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773205057; x=1773809857; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ag1Q7iiQTmW1LyMcYibmgdn2+ZlfPyr/1PUridSt8jo=;
        b=fWiDsEEiurloA2OPu/hA7DT4oA/Ty2jTmRrMNCl2H4+/oqq1o6x3oupb8fX4g7DJ+R
         K0lnaOXOnjNJBUf7mfiCkj+i/lusgOF/kwTlESfhj/FT/9+bO/fgYZXpnPKG37SHHSTW
         bf1nN/0VfsgITSYaxC5MTtAOchHoAxZkyddT4m5lRxtWNXVL0LUhKK9QhAmwXCIfMi6+
         GIwFOVWmkSvW0+gd3Pxr6cdHKhujg67rymMHtPd3ql4A6HrXEdH9ywwgANcLa6uSAqj7
         JZrOrEV0/PhGa49U7GCVGKgybiJt6A8cV+YqUmgWx2yG3R7kv4sm+LOdKiix+16vMDaZ
         M08w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773205057; x=1773809857;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Ag1Q7iiQTmW1LyMcYibmgdn2+ZlfPyr/1PUridSt8jo=;
        b=sGfRqmVvZa9p6E1mb5rLsMHE7W+ZEfL8VwpCWEVN/hCgdunpgavp/4/8AoecrNaKVm
         cwG6qXRdGI4WoIi4lIUybOw5Csb16DYN/Un7wBCGDwCW5mQ+9YqKTAtGiMUlSQIeEkvR
         hDlGI2ntWmrMG+vD+bmtNTtn8ZmTrSmue476n1wPjyEDJ+ud/trvxq6k/b1h62UoCUs2
         ew0VRvFYBB2/Q+ixzS7Nz52pWxB8NtZaSQob0XH3NiqAQ0CHxuouqgi7OMA5rDUxGcTW
         mi0oRMGj/Ej1sk/woMnbMXbTOEFubYWF573t/DoPdmOImU9+UNGxyDfPeE4HWU7G/2jf
         Czvg==
X-Forwarded-Encrypted: i=1; AJvYcCX95nmDU12IRc9OAhQLjh1OP0sDnwiZbaIPIsyp6dxpEeCYKi+giOJkP4z5BdhjVF8WUx7mhMs=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywz17Vef2A7CXgnNHO/179oPkQUbEffsE+kEvB/Y1DCyPooa2zU
	xflZ7lOqbhvzC+8bdYIBInIB2p8ZM20xuVkU68YLoAWPNWbWDY23D5qpPmb9b0vXarcpSXV+EZH
	my1UMOakhCS5FjM9xz/bObwS7jzH8Ky0bwRWF0cmC
X-Gm-Gg: ATEYQzyFs9+Qylk/aaK+d63A1JjkRyfgQpJKlxuxXGZ8k6Lmkbr3EkIls9TrToYb6pV
	WNoLYwAx0QZuKNMAKxYd4Uk25gyAGTuuEls0gjbBLsVaj2BypmEYBuaK6DWBG/Z+iwdRY/LEiZq
	IO7bVnf08jYVey/Pbap8A5UI4gIg289M35NuZBBsJAbUSRI2grQS1nsORGleXVnF3OiqI9A5apA
	PrmL4R0OqRdfoyw/O9v67FpFCV/kumN5SkzOM5MSABRmLMqhAprGZTD4ufmxY0d99CXSTClwYnE
	24u4wbYaA5mBA1pD5Mu2X8e+FUAUCVF5dc1exg+JOBZqwwaiUW9UP00AEVsEElMUSQEUt7mHnH2
	2Gsl/Jw==
X-Received: by 2002:a05:7022:6992:b0:128:ce44:be8f with SMTP id
 a92af1059eb24-128e779f435mr631048c88.2.1773205056860; Tue, 10 Mar 2026
 21:57:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260306-unix-proto-update-null-ptr-deref-v3-0-2f0c7410c523@rbox.co>
 <20260306-unix-proto-update-null-ptr-deref-v3-2-2f0c7410c523@rbox.co>
 <CAAVpQUCdzpwbu=fOrwCnaCFuD3U5SL73PB2nroqgUB4QdJ69og@mail.gmail.com>
 <3bf84a79-7335-483c-b629-2437e360387d@rbox.co> <CAAVpQUB8fvyKSQ8UjBs4=FHmz0iME4SO=3CviS_dCzLNTLkjHQ@mail.gmail.com>
In-Reply-To: <CAAVpQUB8fvyKSQ8UjBs4=FHmz0iME4SO=3CviS_dCzLNTLkjHQ@mail.gmail.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Tue, 10 Mar 2026 21:57:25 -0700
X-Gm-Features: AaiRm50dWB64huQ0DmvsBEvKGoF1e3fB43KjjwJ89Hmeo2RR70RzYJdAJbH7aDE
Message-ID: <CAAVpQUADj21wNH=OkUVxW81Zf8RPd1TxLgcfU1wVbWXDY+W6Sg@mail.gmail.com>
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
X-Rspamd-Queue-Id: E19E525C18C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-266463-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[rbox.co:email,mail.gmail.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Tue, Mar 10, 2026 at 9:17=E2=80=AFPM Kuniyuki Iwashima <kuniyu@google.co=
m> wrote:
>
> On Fri, Mar 6, 2026 at 6:05=E2=80=AFAM Michal Luczaj <mhal@rbox.co> wrote=
:
> >
> > On 3/6/26 06:44, Kuniyuki Iwashima wrote:
> > > On Thu, Mar 5, 2026 at 3:32=E2=80=AFPM Michal Luczaj <mhal@rbox.co> w=
rote:
> > >>
> > >> Instead of repeating the same (un)locking pattern, reuse
> > >> sock_map_sk_{acquire,release}(). This centralizes the code and makes=
 it
> > >> easier to adapt sockmap to af_unix-specific locking.
> > >>
> > >> Signed-off-by: Michal Luczaj <mhal@rbox.co>
> > >> ---
> > >>  net/core/sock_map.c | 21 +++++++--------------
> > >>  1 file changed, 7 insertions(+), 14 deletions(-)
> > >>
> > >> diff --git a/net/core/sock_map.c b/net/core/sock_map.c
> > >> index 02a68be3002a..7ba6a7f24ccd 100644
> > >> --- a/net/core/sock_map.c
> > >> +++ b/net/core/sock_map.c
> > >> @@ -353,11 +353,9 @@ static void sock_map_free(struct bpf_map *map)
> > >>                 sk =3D xchg(psk, NULL);
> > >>                 if (sk) {
> > >>                         sock_hold(sk);
> > >> -                       lock_sock(sk);
> > >> -                       rcu_read_lock();
> > >> +                       sock_map_sk_acquire(sk);
> > >>                         sock_map_unref(sk, psk);
> > >> -                       rcu_read_unlock();
> > >> -                       release_sock(sk);
> > >> +                       sock_map_sk_release(sk);
> > >>                         sock_put(sk);
> > >>                 }
> > >>         }
> > >> @@ -1176,11 +1174,9 @@ static void sock_hash_free(struct bpf_map *ma=
p)
> > >>                  */
> > >>                 hlist_for_each_entry_safe(elem, node, &unlink_list, =
node) {
> > >>                         hlist_del(&elem->node);
> > >> -                       lock_sock(elem->sk);
> > >> -                       rcu_read_lock();
> > >> +                       sock_map_sk_acquire(elem->sk);
> > >>                         sock_map_unref(elem->sk, elem);
> > >> -                       rcu_read_unlock();
> > >> -                       release_sock(elem->sk);
> > >> +                       sock_map_sk_release(elem->sk);
> > >>                         sock_put(elem->sk);
> > >>                         sock_hash_free_elem(htab, elem);
> > >>                 }
> > >> @@ -1676,8 +1672,7 @@ void sock_map_close(struct sock *sk, long time=
out)
> > >>         void (*saved_close)(struct sock *sk, long timeout);
> > >>         struct sk_psock *psock;
> > >>
> > >> -       lock_sock(sk);
> > >> -       rcu_read_lock();
> > >> +       sock_map_sk_acquire(sk);
> > >>         psock =3D sk_psock(sk);
> > >>         if (likely(psock)) {
> > >>                 saved_close =3D psock->saved_close;
> > >> @@ -1685,16 +1680,14 @@ void sock_map_close(struct sock *sk, long ti=
meout)
> > >>                 psock =3D sk_psock_get(sk);
> > >>                 if (unlikely(!psock))
> > >>                         goto no_psock;
> > >> -               rcu_read_unlock();
> > >>                 sk_psock_stop(psock);
> > >> -               release_sock(sk);
> > >> +               sock_map_sk_release(sk);
> > >
> > > I think sk_psock_stop() was intentionally put outside
> > > of rcu_read_lock() to not extend the grace period
> > > unnecessarily. e.g. while + __sk_msg_free().
> > >
> > > Maybe add __sock_map_sk_release() without
> > > rcu_read_unlock() ?
> >
> > How about dropping this patch completely? The more I stare at it, I see=
 no
> > reason why af_unix state lock would matter in any of these places.
>
> I agree.  Actually, once it's held, it can be released right away.
> The lock is only to ensure that peer is set after checking
> TCP_ESTABLISHED, but it continues holding unix_state_lock()
> unnecessarily long.
>
> Honestly I prefer Martin's idea, using unix_peer_get() in
> unix_stream_bpf_update_proto().

Pondering again, I'm leaning to towards my initial approach,
just null check for peer, which allows bpf_iter to acquire
unix_state_lock() and make sure the socket is alive.
(still lock_sock() is needed for bpf_setsockopt())

The check is lightweight and SOCKMAP does not need to
hold the lock unnecessarily, and we can provide stable
result to bpf_iter.

IOW, if we hold unix_state_lock() in the SOCKMAP path
(even unix_peer_get()), we cannot use unix_state_lock()
for bpf_iter and lose stability since it will trigger dead lock.

