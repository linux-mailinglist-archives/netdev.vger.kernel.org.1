Return-Path: <netdev+bounces-285275-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uK/pIU12/Gm3QQAAu9opvQ
	(envelope-from <netdev+bounces-285275-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 13:23:57 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 207854E7690
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 13:23:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E0D983002B2C
	for <lists+netdev@lfdr.de>; Thu,  7 May 2026 11:23:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F0B83BA22C;
	Thu,  7 May 2026 11:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="D+Y7CuWt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF4103C061D
	for <netdev@vger.kernel.org>; Thu,  7 May 2026 11:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778153033; cv=pass; b=Itvt2Cza2GqNkCVwIO9/1+Sutg816Qn1DzliUJ4es3Obj8M/nAkZaJYTa3ovb1sElsmWLqL3pi48TLXN37SC+MJXwCBmA60TeWcbwzHA4vkKmw0CHHyuFO6mIfQrvNKPsHKjn1OVDRbqhG8wnERWD8v78pmH3rJyyEDsQbdtlCc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778153033; c=relaxed/simple;
	bh=lUcXItKAzkLwbUQNbeI9J1RqdnwcBz/ibVSw0fQS32o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hkDOvvtjXJCBuIfzBlyI7fN+So+A1Z4oYYd94v6TH1MXE7RqlAoZ69LTHawkRtG3V8B9nYHEWZI8VwyLbSnPiCOZaf9GZLmEikHCcZJ5n0EQFHxZfxvHlejF/SP/dJ35VbpQN71vFE+IEeYA+zR7sJqJjLOMY32nq5kLr7BdxtQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=D+Y7CuWt; arc=pass smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-8ec9f099fc6so82362685a.0
        for <netdev@vger.kernel.org>; Thu, 07 May 2026 04:23:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778153031; cv=none;
        d=google.com; s=arc-20240605;
        b=fqJbeg5/gGC7MQdMI1ILXzBreewXSiEBnspdTlCcLyVUCfA0smc5PleJREDedlHkDx
         Yx581whH60LaGavuCzsMW+KoH0i6yGhHXQjJspUCBO4zn5EGUpHMjIygBY0cjsFr4NMY
         MBRz/lJ3xwCzWgvVLoSZWBXwckvQJ9aDKP2ujj5rxFfPxXmghkomkcDDBie9lqKY66rx
         AfyhpRJHJDO8VQblZiQQTyA2UIHSXdQzfHOdJpkTKwk7MYY8RI9OYpQvRzuCpN4OkpHf
         nucuvSvv/UvHxPGECRn9cSXO7GlSwLaJxIxJaH65EH+8NSN7QQ2qcMAkp4PVMuxUdilI
         Y/gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=r7h7XmqglP41BdFNbEQk9rwblD7SshsHQhUCVyrl82k=;
        fh=ItqZ38b9H5LKtulkjXopdt8a9EUfiM8/1zqto7UNN40=;
        b=fEfUrqohRrqlC9zqJ2mJW/9rRuXoAiR271Kpqgf4sVVrONCUCADxRM1DOkzGUk/gMc
         tuXmxJF31kmv666ussyJLqRVlXtFm6EHgX20Wx5Z0eNEpGm6i3NfOaU4zgmWVw8wIAzt
         S3a1oXqZyjBJoF3ZMJpQL0Q+o5izgkCY5G5Z5YdaT5hPetOq37nthBq89B8gzvyv0yZd
         Cw/mYna4KTIsiZaJ6hRK0zr3Y8qGGwaP4nEMTwr8lyBH2FnDZNnDfrl0Q8A7m7WV49DM
         jHkvngOD1bdPmSUT76wbszILiBttz81wWBKxpGXokJwl0x6I0YwC2QD2Qv8jjgAa8sEk
         qj7A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778153031; x=1778757831; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r7h7XmqglP41BdFNbEQk9rwblD7SshsHQhUCVyrl82k=;
        b=D+Y7CuWtVYrP0pa6A0QzsZ1quUD+Q1Q+eK+3y3tAVt06pO5BsoS8OHCSIOj0aWWDlg
         QyzX1wZXIHqur01rlYGBT4v6OKV7BboEfL4pnkFEklUlqxyDxGoRECgKETd0aLudCo2+
         fI6l2zWt3rkULCnjOk9xYv9ti5GnDXc39ToG5ymaLo2iaOHpB1pNpm7SPmUxmHvbYOef
         a5CQox3DQgkZXThYj7gO3P2nkGtFL0/hl13MvmYK0FJeagS2mATgrEci1AQiP1Mv7dbj
         K7f01C/eYUYP5GLmkx9TPQ2OL1sYCYvuLzas8Ox3b8e0ahwhxm8N6WfCPyX5+nrNoV/N
         DivA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778153031; x=1778757831;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=r7h7XmqglP41BdFNbEQk9rwblD7SshsHQhUCVyrl82k=;
        b=LcIwXPQf2sDBohTCGGOJseXU4EShBhnUTM42GaBEmR+wg7+dasQpHibaKXgkTZTQmZ
         N8IOiLLrCR2dYOE4wjXZsbzfKnBk/Ypnmu+fQmdOeJAgITCrXJNf4JvCG3rAE+x3C77w
         Wew0PnDI/CZzKSsyPZo32uj3Re9P3TzhBWIjglxY+h6B3APIfyTuKf1kjwwFZ253Taz2
         10cDgOhz0gHc0Xk+l/bxDHTM0pUbYsco//wHI60B0p7aLw0s8ZN6QzWLGwvB2sdylBhD
         d4T28UiMZ4CkkAgrJDbYegNHRHMa9VY9m2vOlDph5YT+CFAPKQ43xZpsfjlBTkbs1oJn
         axVQ==
X-Forwarded-Encrypted: i=1; AFNElJ9E7evHmAqzfmhK/xenQaJWtvSbLqus58giNR9Lq+ccnAEfLj7Wu8LaaBwlzsJP5daCXOhyPic=@vger.kernel.org
X-Gm-Message-State: AOJu0YzV//aBVQU241yBPIEsJ4HeTj7Zu8fckVnV52rP1/Cs3F8RXtjM
	ToJwGBuJDstaXZ9IS9bS3F5b3MaqB7PuXE8t/adgcOZm3raeAjwqbqPnpMXU7doClV3KxGmBapB
	TwZjv0fllYIpSPkiw2tEByn1a1q9/8NuEgQn3hdfE
X-Gm-Gg: AeBDieu6GqV52f/c+DXgpL4KSX/D8oBS7K+aFjKZFKrs2gThDiS9IQ1r58aB6IXiNY8
	LIzaQ6rV8XKhAiQPREBueoly6DSZbQf5kUomj2OGYxAlb4/eeb1VPE/Ti5QaeY1MNGjhnzMr2Xm
	JnJyRTvzFSiRlxqA5Rsi/SmaeFfaW6OJPenTesNcoiTrjjk/AnL5vTs51FRA0n70Acvuf0Xan0S
	Hr5Qkh2fWrT0G/hYWv7jfr3Z2s58I0E3VVkVLCF80v07eQ92Q94jxTQ42q9uFfOILmK+cgcRj4x
	34ko7YJMyUztC+FNj/qP1ZVw/t6+1DU4Ry+IxPkXUXc7uXm1kxRWRGbzCSKA9Ik/sIhr0NhVFiF
	ak7FdprV8IZ8ardLvizsn7DTq81j58J6C0C7y2OwG9mjsLwklkgK2
X-Received: by 2002:a05:622a:352:b0:50d:8db0:7abb with SMTP id
 d75a77b69052e-51461fc4f53mr99410211cf.42.1778153030058; Thu, 07 May 2026
 04:23:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260506172830.2237574-1-kuniyu@google.com>
In-Reply-To: <20260506172830.2237574-1-kuniyu@google.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 7 May 2026 04:23:38 -0700
X-Gm-Features: AVHnY4JAbHRUWR3w7dzRQ8QodojnytK_wqCoMW-FNYxXPp1Kv5QI0LVTOIMGQp8
Message-ID: <CANn89iJawd-gi4qoCZLA_mB6c-gLaqF5dirALS-ZSsFWpEB6Qw@mail.gmail.com>
Subject: Re: [PATCH v1 net] tcp: Fix out-of-bounds access for twsk in tcp_ao_established_key().
To: Kuniyuki Iwashima <kuniyu@google.com>, "Paul E. McKenney" <paulmck@kernel.org>
Cc: Neal Cardwell <ncardwell@google.com>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Dmitry Safonov <0x7f454c46@gmail.com>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, 
	Damiano Melotti <melotti@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 207854E7690
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[google.com,davemloft.net,kernel.org,redhat.com,gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-285275-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Action: no action

On Wed, May 6, 2026 at 10:28=E2=80=AFAM Kuniyuki Iwashima <kuniyu@google.co=
m> wrote:
>
> lockdep_sock_is_held() was added in tcp_ao_established_key()
> by the cited commit.
>
> It can be called from tcp_v[46]_timewait_ack() with twsk.
>
> Since it does not have sk->sk_lock, the lockdep annotation
> results in out-of-bound access.
>
>   $ pahole -C tcp_timewait_sock vmlinux | grep size
>         /* size: 288, cachelines: 5, members: 8 */
>   $ pahole -C sock vmlinux | grep sk_lock
>         socket_lock_t              sk_lock;              /*   440   192 *=
/
>
> Let's not use lockdep_sock_is_held() for TCP_TIME_WAIT.
>
> Fixes: 6b2d11e2d8fc ("net/tcp: Add missing lockdep annotations for TCP-AO=
 hlist traversals")
> Reported-by: Damiano Melotti <melotti@google.com>
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
> ---
>  net/ipv4/tcp_ao.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/net/ipv4/tcp_ao.c b/net/ipv4/tcp_ao.c
> index a97cdf3e6af4..e2720233e36b 100644
> --- a/net/ipv4/tcp_ao.c
> +++ b/net/ipv4/tcp_ao.c
> @@ -116,7 +116,9 @@ struct tcp_ao_key *tcp_ao_established_key(const struc=
t sock *sk,
>  {
>         struct tcp_ao_key *key;
>
> -       hlist_for_each_entry_rcu(key, &ao->head, node, lockdep_sock_is_he=
ld(sk)) {
> +       hlist_for_each_entry_rcu(key, &ao->head, node,
> +                                sk->sk_state =3D=3D TCP_TIME_WAIT ||
> +                                lockdep_sock_is_held(sk)) {
>                 if ((sndid >=3D 0 && key->sndid !=3D sndid) ||
>                     (rcvid >=3D 0 && key->rcvid !=3D rcvid))
>                         continue;

I wonder if a better fix would be to change __list_check_rcu() evaluation o=
rder.

Otherwise, this would mean that a TIME_WAIT socket would evade RCU
LOCKDEP checks.

If a fix in tcp_ao.c is te way to go, I would suggest the opposite of
what you did.

diff --git a/net/ipv4/tcp_ao.c b/net/ipv4/tcp_ao.c
index a97cdf3e6af4cf1ee1cd8c6361944536056543e6..0a4b38b315fed40899901ea5f66=
fbdffd776df38
100644
--- a/net/ipv4/tcp_ao.c
+++ b/net/ipv4/tcp_ao.c
@@ -116,7 +116,8 @@ struct tcp_ao_key *tcp_ao_established_key(const
struct sock *sk,
 {
        struct tcp_ao_key *key;

-       hlist_for_each_entry_rcu(key, &ao->head, node,
lockdep_sock_is_held(sk)) {
+       hlist_for_each_entry_rcu(key, &ao->head, node,
+                                sk_fullsock(sk) && lockdep_sock_is_held(sk=
)) {
                if ((sndid >=3D 0 && key->sndid !=3D sndid) ||
                    (rcvid >=3D 0 && key->rcvid !=3D rcvid))
                        continue;

