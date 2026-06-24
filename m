Return-Path: <netdev+bounces-301638-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id PvikHuLQO2qXdggAu9opvQ
	(envelope-from <netdev+bounces-301638-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 14:43:14 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C7F7D6BE3A5
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 14:43:13 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=GLm8a53u;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301638-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-301638-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3CA2E30053EB
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 12:42:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C05C82D780C;
	Wed, 24 Jun 2026 12:42:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 446C72D0C62
	for <netdev@vger.kernel.org>; Wed, 24 Jun 2026 12:42:47 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782304968; cv=pass; b=I/QO4QKX1VMbBDXy1232cMVoico8S+7WcEyDEUHc8DdHy9PG5G+qqzLsOw46W7zR0ceFiFXVnguVODIami+UiWaUd4TjyFHBbMtu0HIKV8W5jf6bzI3UOoOEjXfjyGxeCtzbd3RAaKsksGToRXTuxT22KzQaRUtyeONUr6lqckY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782304968; c=relaxed/simple;
	bh=I+Qom+9LmpPvzBG1r/Jc81pDsOI54B4duT+qSCri+lc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i7CS7f9Q4DDrUj3OMbl1Ah4jHW23pR3HE+U9vnFZFGG/Faszju0NLgKItdGBLgoXWkQaACfA/JYLK+ZcePYHakjEf7JNVrEsSppzJUFm701JXaQge2+dyp4zBmXN1PAMvAemAHzifnbxFTGrmhIQOHlt2t/thUyOZsSLqdJCwoQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GLm8a53u; arc=pass smtp.client-ip=209.85.160.170
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-5177945a22eso6504161cf.1
        for <netdev@vger.kernel.org>; Wed, 24 Jun 2026 05:42:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782304966; cv=none;
        d=google.com; s=arc-20240605;
        b=dELEOusNMcAXFBYYuv4aGw67QFjJp55ikZzWa60i+zQk8maJkDJrlj3Y/sICbNQtFt
         MJnPsBc65YiBcFBcfIyiULtCxrZQC6w1FmOKxUIAZr6hPscWsAFA+Vbzm0+h0zbgqEg3
         vVor64VQzFesyM+F7wzLXDu1ouZk2l12JwGkgeFpFRBWjeXs/+LDDTYYiPtzPeyxsDNO
         350A17wLtVZP+TBp8yw+TVr81medwtUiLpoJPiJn0UBjME0INQvxZLxPZ8lxDYOevcCF
         lEQqf7MMRR/Aw+MhZr6BVJN57BWIu6G+PK4JNCiBAD9vYJEdOD7UGCJgPRFbj5NIPMU4
         k52A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=n8yYm0QTBvSQvWPsonaqjgvsrY08hPfAKC5sb0175JY=;
        fh=Ee0/Wjo4lKgW9uJ/yO5nqjJgkUHU3WhhWp7TANMdNPM=;
        b=UimTk9WbQQC7bQUkmUlvdG6KKSD8Ctm3P1evJ14Tb4oMZcGJ4C6IMCqwSUR89EUFyQ
         evWzkqu6mykp86CqHpvUdIECc5rvLiqe5Zdu6FyZwN+L6nkSrUsHsJ0OD0Q/Fh+7n79s
         MkzRsxWcgHBcxcMeJD353SMp3yWU7a3ebqvKnGIcX2G1M2BN07deu95Y/FuNs5PiFXmH
         qVb0uIkTfyubUrwbc6dcVuOJ4RxU00Tq/Auk+dpy/0RgWAbKO0XTpukL7UBTlU71I/Zj
         6pSIOIuKjsLerNJ+7QmAYm3V8Hv9l+dV6/0SrnyUogMHSPkEEnns2mMaB6Cg/LeXQHN/
         KtgA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782304966; x=1782909766; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n8yYm0QTBvSQvWPsonaqjgvsrY08hPfAKC5sb0175JY=;
        b=GLm8a53uj6iyKoN7jP9GsAdZMXTWruPnyuNWBulfKKkjBGd6oFkKgNDWZPDhXQyVjA
         z/y/5EUw21mN+AyDOLDxepCBgBaouhYPSAebWof8ArFpI6IMeY8Xw0+16lmve8lKSrqf
         HprnbFna6gGnXtF7J9V5tjGeXvN9IBsIZztisKKEHEysA2gcNqXLu38Lz4mcvS4GeDZV
         jg3yOgj9+E6rhDyh8JgnNt1aCjV4Z5PToLlOfgjpyAEb1MIUYEgF5HcuvqwERn1F3QgS
         NI+RjZA+4Nm+PbfQV4qOHjp379aSs37TRNsnJc87XaUQerDlz+Ya4U8xoQtBPUFAOvnH
         SZOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782304966; x=1782909766;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=n8yYm0QTBvSQvWPsonaqjgvsrY08hPfAKC5sb0175JY=;
        b=bZ5tXYoowcVW1R4yP3M1QlEOW1DuKHCPJDz3Z25OqZjtSKH7YPZwo50/b3VwnUuMiV
         LaRMdHm3igVRi1QqxI4HOpLpowjnn6u3kaW5VxBEbX9Esdgn1ccVZ0Gz7aGFnZpPU5K9
         tqNfDYQvHzylyjcMlkOczMozyziZhBE9RyymY96950G8p+0CrldDoe6BIWFL3jN/q7WN
         QYv4sDIfHdnlz3NdbIE9t2JISOdZ8ceYtATJkpxhM4XuCxBSETETJ1F1YNv0G1FlZc3y
         RU0/6AMGYTRPUSHW4Fc7Ni8SFJbtI435IUkuXimwWJH1VU9zLGSMGqGcMWaEgjwWmJAS
         XL5Q==
X-Forwarded-Encrypted: i=1; AFNElJ/vHhMfSBaM5ovwE93ZWWfkJCnBj8trOUnsaR+kwgbR290+JPlFkcEubZEov1Mv9R62Y3ItcMY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsmG26YJQH4UJZcKPubFWtbhTYW2OZi6C42PoToBSX422chdWr
	EZi+fEclVEd3TaOcVE8nNVAfhr1nEP3bHQhJrNKb9ARnObxLVRcuqk6FbQTY8HZYE0ovZ75wEel
	1YzbufzGM7gwsXiUlGv2WCpsa3MnPiVDwDpsw2/tu
X-Gm-Gg: AfdE7ck16bwYo2GJN7UN7cDCZOvAOlEiA1mK4bl3aHYh6hY36joR640rtH7vbUwk3tP
	IIMaxdeS+BM27tLszd/iQx4PxBNSTppQI3cIglNLh7+zsuP/y+d6QrYRDccAWuoIHbxtu23KLBZ
	G7AZJTMc7WZQNj6RJYSvwYaUH9mFaEf6bpG3lVO49uArhDFdViTS7TAoOnkLsIPy/Wb07UTapwH
	6cve3whrZC460d3E0ixODJocIE1mK1absDBqXYpA0Qfjo3J6lgwsLax7iqazhrSGLe7rfTTbC3a
	nAWh4q3m3zy6RWawxNINBSReQDoKasreQuaD5tsg8meFZ2MQ0oSxDW5R8Sn3LR0NyjNyTfoAMpv
	n848Tu0pHnA==
X-Received: by 2002:a05:622a:487:b0:519:b15c:69b2 with SMTP id
 d75a77b69052e-51a61d7c7d9mr45373301cf.15.1782304965407; Wed, 24 Jun 2026
 05:42:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260623173030.2925059-1-edumazet@google.com> <20260623173030.2925059-2-edumazet@google.com>
 <GV1P189MB198820F9C95A5FF9A110EA19C6ED2@GV1P189MB1988.EURP189.PROD.OUTLOOK.COM>
In-Reply-To: <GV1P189MB198820F9C95A5FF9A110EA19C6ED2@GV1P189MB1988.EURP189.PROD.OUTLOOK.COM>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 24 Jun 2026 05:42:34 -0700
X-Gm-Features: AVVi8CeNcIyMLNibEJ82RdZ80fbwYYS4Ynp1dD-QpHV0hfeYls2WK3eN9Kq3A6c
Message-ID: <CANn89iK8DzT7+hW8LmgwHtVVsUmDydH9=zM9UA+hd6FoLLaj1w@mail.gmail.com>
Subject: Re: [PATCH v2 net 1/2] tipc: fix UAF in cleanup_bearer() due to
 premature dst_cache_destroy()
To: Tung Quang Nguyen <tung.quang.nguyen@est.tech>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, Xin Long <lucien.xin@gmail.com>, 
	Jon Maloy <jmaloy@redhat.com>, 
	"tipc-discussion@lists.sourceforge.net" <tipc-discussion@lists.sourceforge.net>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "eric.dumazet@gmail.com" <eric.dumazet@gmail.com>, 
	"syzbot+e14bc5d4942756023b77@syzkaller.appspotmail.com" <syzbot+e14bc5d4942756023b77@syzkaller.appspotmail.com>, 
	"David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-301638-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:tung.quang.nguyen@est.tech,m:horms@kernel.org,m:kuniyu@google.com,m:lucien.xin@gmail.com,m:jmaloy@redhat.com,m:tipc-discussion@lists.sourceforge.net,m:netdev@vger.kernel.org,m:eric.dumazet@gmail.com,m:syzbot+e14bc5d4942756023b77@syzkaller.appspotmail.com,m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:lucienxin@gmail.com,m:ericdumazet@gmail.com,m:syzbot@syzkaller.appspotmail.com,s:lists@lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,google.com,gmail.com,redhat.com,lists.sourceforge.net,vger.kernel.org,syzkaller.appspotmail.com,davemloft.net];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev,e14bc5d4942756023b77];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,mail.gmail.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,est.tech:email,appspotmail.com:email,perches.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C7F7D6BE3A5

On Wed, Jun 24, 2026 at 5:04=E2=80=AFAM Tung Quang Nguyen
<tung.quang.nguyen@est.tech> wrote:
>
> >Subject: [PATCH v2 net 1/2] tipc: fix UAF in cleanup_bearer() due to pre=
mature
> >dst_cache_destroy()
> >
> >TIPC UDP media bearer teardown calls dst_cache_destroy() on its replicas=
t
> >caches before calling synchronize_net() to wait for concurrent RCU reade=
rs
> >(transmitters) to finish:
> >
> >static void cleanup_bearer(struct work_struct *work) { ...
> >       list_for_each_entry_safe(rcast, tmp, &ub->rcast.list, list) {
> >               dst_cache_destroy(&rcast->dst_cache);
> >               list_del_rcu(&rcast->list);
> >               kfree_rcu(rcast, rcu);
> >       }
> >...
> >       dst_cache_destroy(&ub->rcast.dst_cache);
> >       udp_tunnel_sock_release(ub->sk);
> >       synchronize_net();
> >...
> >}
> >
> >This is highly buggy because dst_cache_destroy() immediately frees the p=
er-
> >CPU cache memory (free_percpu()) and releases the cached dst entries
> >without any synchronization.
> >
> >If a concurrent transmitter (e.g., tipc_udp_xmit()) is running on anothe=
r CPU
> >under RCU protection, it can call dst_cache_get() concurrently, leading =
to:
> >1. Use-After-Free on the per-CPU cache pointer itself (crash).
> >2. "rcuref - imbalanced put()" warning if it attempts to release a
> >   dst that was concurrently released by dst_cache_destroy().
> >
> >Furthermore, calling kfree(ub) immediately after synchronize_net() witho=
ut
> >closing the socket first (or waiting after closing it) leaves a window w=
here a
> >concurrent receiver (tipc_udp_recv()) could start after synchronize_net(=
),
> >access ub, and suffer a UAF when kfree(ub) runs.
> >
> >To fix this, we must defer dst_cache_destroy() and kfree(ub) until after=
 we have
> >ensured that no more readers can see the bearer/socket and all existing
> >readers have finished:
> >
> >1. Defer rcast entry destruction (both dst_cache_destroy() and kfree())
> >   to an RCU callback using call_rcu_hurry().
> >   Using call_rcu_hurry() ensures the dst entries are released quickly.
> >
> >2. Release the bearer socket using udp_tunnel_sock_release() (stops
> >   new receive readers).
> >
> >3. Call synchronize_net() to wait for all outstanding RCU readers
> >   (both transmit and receive) to finish.
> >
> >4. Now that it is safe, call dst_cache_destroy() on the main bearer
> >   cache, and free ub.
> >
> >Note: 3) and 4) can be changed later in net-next to also use
> >call_rcu_hurry() and get rid of the synchronize_net() latency.
> >
> >Fixes: e9c1a793210f ("tipc: add dst_cache support for udp media")
> >Reported-by: syzbot+e14bc5d4942756023b77@syzkaller.appspotmail.com
> >Closes:
> >https://lore.kernel.org/netdev/6a396a66.52ae72c2.136ac7.0003.GAE@google.
> >com/T/#u
> >Signed-off-by: Eric Dumazet <edumazet@google.com>
> >Cc: Xin Long <lucien.xin@gmail.com>
> >Cc: Jon Maloy <jmaloy@redhat.com>
> >Cc: tipc-discussion@lists.sourceforge.net
> >---
> >v2: addressed Xin Long feedback
> >v1:
> >https://lore.kernel.org/netdev/CANn89i+dkbrSAwvaWXW7yWMfcwUebuTBLG
> >5T7AGZaZcpVYGyfQ@mail.gmail.com/T/#m7bbeedffe3bedb69e33236410e383
> >3c7ce809850
> > net/tipc/udp_media.c | 15 +++++++++++----
> > 1 file changed, 11 insertions(+), 4 deletions(-)
> >
> >diff --git a/net/tipc/udp_media.c b/net/tipc/udp_media.c index
> >988b8a7f953ad6da860e6190f1f244650f121dce..66f3cb87a0aaaac8f40e8f237a
> >b9a44d539b1cd8 100644
> >--- a/net/tipc/udp_media.c
> >+++ b/net/tipc/udp_media.c
> >@@ -803,6 +803,14 @@ static int tipc_udp_enable(struct net *net, struct
> >tipc_bearer *b,
> >       return err;
> > }
> >
> >+static void rcast_free_rcu(struct rcu_head *rcu) {
> >+      struct udp_replicast *rcast =3D container_of(rcu, struct udp_repl=
icast,
> >+rcu);
>
> This line is long (over 80 columns). Please break it into 2 lines (refer =
to linux/Documentation/process/coding-style.rst).

I prefer it this way.

BTW:

commit bdc48fa11e46f867ea4d75fa59ee87a7f48be144
Author: Joe Perches <joe@perches.com>
Date:   Fri May 29 16:12:21 2020 -0700

    checkpatch/coding-style: deprecate 80-column warning

    Yes, staying withing 80 columns is certainly still _preferred_.  But
    it's not the hard limit that the checkpatch warnings imply, and other
    concerns can most certainly dominate.

    Increase the default limit to 100 characters.  Not because 100
    characters is some hard limit either, but that's certainly a "what are
    you doing" kind of value and less likely to be about the occasional
    slightly longer lines.

    Miscellanea:

     - to avoid unnecessary whitespace changes in files, checkpatch will no
       longer emit a warning about line length when scanning files unless
       --strict is also used

     - Add a bit to coding-style about alignment to open parenthesis

    Signed-off-by: Joe Perches <joe@perches.com>
    Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>

