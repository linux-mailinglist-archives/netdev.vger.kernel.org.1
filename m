Return-Path: <netdev+bounces-254239-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0NPoJ5QBemn31QEAu9opvQ
	(envelope-from <netdev+bounces-254239-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 13:31:16 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FD60A144F
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 13:31:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E1EB33019F0C
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 12:27:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AFDB34DB4C;
	Wed, 28 Jan 2026 12:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lQp7rOmz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A528D2D7DF8
	for <netdev@vger.kernel.org>; Wed, 28 Jan 2026 12:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769603267; cv=pass; b=S9FSrAlXuvyT9lGTbyziRxCSW4nXM09k9N31qA+W3oGXKD9mJ420ueq0uXfpgmWHF8FyiKe4MuoEAy5b/TzPaq76rQfgbteYIeJk/EfcewTJOaa5mUtW/cPfnaOYAv9gtvgQjvsZseafB/+V/fd2cVLQ7wtoUYSbEsbHpoQFivU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769603267; c=relaxed/simple;
	bh=iC0oZSlUimz3WM18GXhEF/Bkrzim3RRziUZwDZJ85JI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DnF3OzL47XBIHgp7EmLi7/922ADO9EDglwoSlkwx8BbVgq5iKuGphLItv1vsiQdK7nJ028wV3Af3yPGCi5/Bj9YYwcMoKP9sRiF1pdCYyJtRJnAAPxb4flSB6ETgeoj/CgwdBUSWYAkHPcQFhHlH9oqMBAh9d0S7j2fT1WLQzjU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lQp7rOmz; arc=pass smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-78fba1a1b1eso13291447b3.1
        for <netdev@vger.kernel.org>; Wed, 28 Jan 2026 04:27:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769603265; cv=none;
        d=google.com; s=arc-20240605;
        b=BfzzxNdWpg9eNHMSmEfv2zz8sK8K4/Jft5YfwgAQBLab+dw/f8Dg371v5wX5pEKc6S
         u/EWPj9jzYEM+wAyKBu2QqZzVuAMwUnoB1pRjCSmCvg/poOcEbRS/9HsyNla8zz5yljz
         CJ/z+dMJUhUTOGfx9Xa+ou6rVkuLybTpO2f5qtqveIVPIWVzXC/1iTSdMz9hy0hhYS7G
         /TU4cwFsIbF+yzddQGBd5Jopo0vD1/+n7v0b6O7OGXf1qvQtRMVbfbk1mYmGUcUqLnKI
         Jp723ptdDYHlD6Uwq5mUPfp6Ru2tAveK1WQ8YM+M7eP0jn3+jRJ0etK6mefjjU1jAIZW
         zYWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=9S1V+rSgDNKqHee7GZu8pyip2y/WbDyMTMQsl2ChFX0=;
        fh=GG4ztfOnJk5Cd0c0fAIgQShhcB5h1Jfwa0rV+iWFgh8=;
        b=OSm39BqacC6ig8hOOhVeMgrNoEPj5rxQ7DD42KyYmr5Hv8u4oNNt7T7U86OswiiQ/D
         FZZRZgpwVIB1y2/zd5TDWFCy/nuiUA2uWbpgTikncBqitBmauCCZVEALyJyIZsNc8iuH
         b82HgVK3PvOFD4WFLKgY+2HZFkk4v74UjzjWO8M52KE1XOH9wjNQ63d9ndQAPggx/c8J
         n9RZUHIEPrL2Kkz54iXYqs2M3hOzWsIOMw0ch0Z4PxzV3H4XqWDLb8toS//5YyM74cwU
         j7oq2Lz97lYImdtVYaRmuxQF2MvRFunTuWrliXT0xlmzs0HgLQn1O0tm2uFhxNrdyG9R
         0MWA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769603265; x=1770208065; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9S1V+rSgDNKqHee7GZu8pyip2y/WbDyMTMQsl2ChFX0=;
        b=lQp7rOmzAO4G5nzScIe4jQoZ4WkjE/MNuP/JdCS+U3azGhtaDrSKsWZs6vumPGjity
         uBrUbag0OQ0qI06KJyBN0w+ANziZWbEYFVGPiHbl7AKdBbIHE1wCK8XN7P4Fk5Zo6AcJ
         QXDHpTsecNcOw0kgXhxLxUHZSeuOFLXHP6tVj9CImhVUrhXyhFoxQgH7H+9irsF+1Aii
         cAHz2H0v4KPwIa3ajqMAJegMJaDVoPMkEYgocvCQr6cgxxGblmKX68Pwpq4cYQcljbdb
         mcXEwGgTSg4gpEYevNeXX27sOELYAGLBYGo6iqIN+FPGSCAiC2+H5UXsMdMrZn7o0VLX
         pQZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769603265; x=1770208065;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9S1V+rSgDNKqHee7GZu8pyip2y/WbDyMTMQsl2ChFX0=;
        b=ZoA/T7OSbu22cN7BUb2/m7FKCY7s6CO8Os3qefsdEg9jwUfgj5b92oQ7BEDFNeWgc9
         6+T5BheueanW1Vo/vjqw0ztlVleQw5JzRH0KaeQjqiZqXIu7Phzg6wDUxoryXx7DBjm7
         RIpVSX3QpKBvs9g8mLHmh6wr89JrZsTTO0mDnM9kjeTqwd2kxUNJBauOq7+4rlgl/MZA
         u8sW8p2+ne8XBVDF3JhI4nrMBHp6JAcb/ZKgiNQHrz48T2jXKj9MuiK0FrMXlckbzyU2
         XlZNHjsG2fRLvXRJ9JBR2pWLFYaDZc29xfpmY1uMtggaDMbGOFjj7OFE36iijX4j+Xn5
         Rgyw==
X-Gm-Message-State: AOJu0YwdNJy/JAo+3OeD5Ra5svHSxQzDJzR/zk6pbfp59LZhgsvUjaHg
	xpp+C1KqrEqZcVTs6cPUfW76PLHaMBAXxxEEElLY7gVU7BCI1SHQKHaKJP7KX1OCrMFFM3FG/8p
	jkfutDYk+8JjH0A43Zrt4yWIYrcNC00s=
X-Gm-Gg: AZuq6aJFhctTM/Ra5+YkM+Dr9EoEPmWVNgy+2113wCGMMSJPYnrhuEtge2YMikIGREh
	tHNHPmQ/WWJubd0nw+7QiG6yyV0Cij3bCAIgTDf97093P4lEdCbmCnXx1uA2OMT3gQdHJfxV/WU
	yUPVJJWl478uAcaCXv0hoUUl5iD0hibgU6IcPS0mn1AyRNkA1ybKqpXPVgtALSVIfb/RCnRU9Hn
	suTM1TX3Zzg4piFEQgcpyyaZgcScLwqVH1E5jwuF8KVxCYaTrIQaaNV88LtelwkYSKx0FQ=
X-Received: by 2002:a05:690c:f14:b0:794:668:ef10 with SMTP id
 00721157ae682-7947abf39e0mr35250517b3.8.1769603264655; Wed, 28 Jan 2026
 04:27:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260128070311.48892-1-mahdifrmx@gmail.com> <CANn89iKwmhmAOConHjNP7XxVLghaJJgU4gDSH+To8Q1V67Jv0Q@mail.gmail.com>
In-Reply-To: <CANn89iKwmhmAOConHjNP7XxVLghaJJgU4gDSH+To8Q1V67Jv0Q@mail.gmail.com>
From: Mahdi Faramarzpour <mahdifrmx@gmail.com>
Date: Wed, 28 Jan 2026 15:57:34 +0330
X-Gm-Features: AZwV_QgqXef8J4EjVHZ_52ae7rSG7gsOm1Z2-3Wwv-QTwnTBPL01B7AcTl48uhQ
Message-ID: <CA+KdSGPvcGrUGeMiguBZ_RcHQjXeik+DgqetWaGNW8aGK3LUZg@mail.gmail.com>
Subject: Re: [PATCH net-next] udp: add drop count for packets in udp_prod_queue
To: Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, willemdebruijn.kernel@gmail.com, 
	davem@davemloft.net, dsahern@kernel.org, kuba@kernel.org, pabeni@redhat.com, 
	horms@kernel.org, kshitiz.bartariya@zohomail.in
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-254239-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,davemloft.net,kernel.org,redhat.com,zohomail.in];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mahdifrmx@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 2FD60A144F
X-Rspamd-Action: no action

On Wed, Jan 28, 2026 at 3:14=E2=80=AFPM Eric Dumazet <edumazet@google.com> =
wrote:
>
> On Wed, Jan 28, 2026 at 8:03=E2=80=AFAM Mahdi Faramarzpour <mahdifrmx@gma=
il.com> wrote:
> >
> > This commit adds SNMP drop count increment for the packets in
> > per NUMA queues which were introduced in commit b650bf0977d3
> > ("udp: remove busylock and add per NUMA queues"). note that SNMP
> > counters are incremented currently by the caller for skb. And
> > that these skbs on the intermediate queue cannot be counted
> > there so need similar logic in their error path.
> >
> > Signed-off-by: Mahdi Faramarzpour <mahdifrmx@gmail.com>
> > ---
> > v6:
> >   - increasing a single counter based on socket family
> > v5: https://lore.kernel.org/netdev/20260122185357.50922-1-mahdifrmx@gma=
il.com/
> >   - check if drop counts are non-zero before increasing countrers
> > v4: https://lore.kernel.org/netdev/20260108102950.49417-1-mahdifrmx@gma=
il.com/
> >   - move all changes to unlikely(to_drop) branch
> > v3: https://lore.kernel.org/netdev/20260105114732.140719-1-mahdifrmx@gm=
ail.com/
> >   - remove the unreachable UDP_MIB_RCVBUFERRORS code
> > v2: https://lore.kernel.org/netdev/20260105071218.10785-1-mahdifrmx@gma=
il.com/
> >   - change ENOMEM to ENOBUFS
> > v1: https://lore.kernel.org/netdev/20260104105732.427691-1-mahdifrmx@gm=
ail.com/
> > ---
> >  net/ipv4/udp.c | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> >
> > diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
> > index ffe074cb5..dd302f5fb 100644
> > --- a/net/ipv4/udp.c
> > +++ b/net/ipv4/udp.c
> > @@ -1797,10 +1797,13 @@ int __udp_enqueue_schedule_skb(struct sock *sk,=
 struct sk_buff *skb)
> >                         skb =3D to_drop;
> >                         to_drop =3D skb->next;
> >                         skb_mark_not_on_list(skb);
> > -                       /* TODO: update SNMP values. */
> >                         sk_skb_reason_drop(sk, skb, SKB_DROP_REASON_PRO=
TO_MEM);
> >                 }
> >                 numa_drop_add(&udp_sk(sk)->drop_counters, nb);
> > +               SNMP_ADD_STATS(__UDPX_MIB(sk, (sk->sk_family =3D=3D PF_=
INET)),
> > +                              UDP_MIB_MEMERRORS, nb);
> > +               SNMP_ADD_STATS(__UDPX_MIB(sk, (sk->sk_family =3D=3D PF_=
INET)),
> > +                              UDP_MIB_INERRORS, nb);
> >         }
>
> Hmm.. I have not followed your prior attempts, sorry for coming late.
>
> Note that an UDP AF_INET6 socket for which ipv6_only_sock(sk) is false
> can receive
> IPv4 and IPv6 UDP packets, if bound to any addresses.
>
> The to_drop list could contain a mix of IPv4 and IPv6 packets.
>
> Ideally we should track SNMP values in the proper space (Ipv4 , IPv6).
>
> See IPV6_V6ONLY and /proc/sys/net/ipv6/bindv6only for reference.
This is the exact discussion I had with Willem de Bruijn:
https://lore.kernel.org/netdev/willemdebruijn.kernel.17f36003699cb@gmail.co=
m/

