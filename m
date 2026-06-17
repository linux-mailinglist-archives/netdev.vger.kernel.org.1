Return-Path: <netdev+bounces-300031-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id rUbkH6coMmqgvwUAu9opvQ
	(envelope-from <netdev+bounces-300031-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 06:55:03 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id EB822696888
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 06:55:02 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=SWiJoqko;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300031-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-300031-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 008D23015884
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 04:55:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CC55339870;
	Wed, 17 Jun 2026 04:55:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E2DF34750A
	for <netdev@vger.kernel.org>; Wed, 17 Jun 2026 04:54:48 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781672099; cv=pass; b=J0N33gZTiK3wkFXwqNEp0jxZhCRIBnQBw1y8qvgX8KIWvmDB5OSkKcqgbKHzOcLi2YvyzOenPTTOapEIVjmGTSg5W9WjCr8q2TBnFBblGHkMaGaypyCwX09ryBWczIpWTqE4Ygvsd5kWwJb1+QrwWi9CG97gHnp89iYIE6JgWLw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781672099; c=relaxed/simple;
	bh=3KtsgtFqVai3l9m88WUTC2KsD0ALyFW9uXbRgrkeegA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qbXDfHOaffFWTZAFCN4dEJm6w42M1iLC87SiqsnX5AahQoGXjetkj1VujZaPROi3CaRBosH6Adye7E3AghOtVY7W77G8Y//63W4lfyHiRKDYGw89u5zy6HRP/mzG23Sc4E36RAz8Q/URr1QAqXjynsibPlKyVRa7EYWYjmXCTak=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SWiJoqko; arc=pass smtp.client-ip=209.85.160.174
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-5199da044e6so13530251cf.3
        for <netdev@vger.kernel.org>; Tue, 16 Jun 2026 21:54:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781672087; cv=none;
        d=google.com; s=arc-20240605;
        b=CDLHQ+uadV8TjwVAK0O//Gr7Edlym4j1/fhL9dO1AldVdR91djqEc8Hg2/draLHnyq
         UUKKMGOdwRz0gS80GTdaoc9IoEn1IP6F+ikxSpnDI7ppaGjgOIEa6uhTLhRdJtd2LyvN
         h8y8ojMJVDbDwKEoSQA8CwOvpMlrL4OcwH3awoIfum8WSvQYFDoIh7n1XI+LbSD7Hp8R
         g+zmVBAPO7jXjyRDHUE2w6CFrpPy+CISRxCv10mftD0NjWjBdwOSTPsy8b6jG/afEi1t
         8x5FbzygvY/BZ8h9YaR8r4Zacwv2riM8ksQ0WYyFf+XD4Uttzn1bDi9HVsbvaEphz+Zp
         hmMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=AsFkfVabSHYhskGjh51r3j95v8fFqbvuElqDhsQPgmk=;
        fh=6yKvTscpfuMARuCGpsDdYduitbQOXdmxHMt3+piapp8=;
        b=LmGq6zQRdsgYdu1pgby+5Nc9mxj8RXnAZjw4CIdP5+ULb4igFqTOqH0sER8FHQYEGB
         M0a3GYVDGxYnZvCinCgBPLmlMnXjL1G4NrNzpnBUGKBdH9xL2UDwlqWFTZDKEozEJltv
         ThHQrz1SC49rU+L1TOU4SF4a8U988gSkWpSLKJ/qBwvF5Mz0QJJdvJzTwWOBPViP4jno
         SdhjlUTBGca1apUM9zVixWH5uJmik+TEVjlNHzg3qwY2RSy6qV4BBJBqkv2YLTs843kX
         0r9dPqZkVyz3S2tNaIw1sjdq0Sf9NQc+OgPczqSCqNJXKpMGiDkecJC2YnN8gHrYJbIU
         LBpA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781672087; x=1782276887; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AsFkfVabSHYhskGjh51r3j95v8fFqbvuElqDhsQPgmk=;
        b=SWiJoqkoGPrIIYxW4Hb9KqVmHy3z9yfZ7nXmIvb0w1pgTGsqL6KvYIURvdXvX1DXcL
         EtB1u7HCPazj05/x8cOjmbem+dZ4pw2CpzQZdAUctsBvr51ttkZFtjWWCJJzap1m/I7p
         i6g+B8NqtgG9HEnWI03bzq83JFru1e3A+ei1gfwKma/LnDJY8pdleBvlyTCpVqK62lnp
         YnrQDg1+ifbdHl1KAoBlo7a17Rms4LdlvJlvsN7EHx9uY0qKmX+SpGe6Q/SSUxYPy9FU
         3ciOY25pX9nbmBAUlE1aLxORRrsIlZYLpbJiYOdBKu1BO4YYLQ8PqWvbBRDnK6kh9i+9
         QZ3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781672087; x=1782276887;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AsFkfVabSHYhskGjh51r3j95v8fFqbvuElqDhsQPgmk=;
        b=Sv9mjX5Y1zTWo6kq/kvBjnoBwgCoSJAus/a6tl3V7lOFCqFdcqtnHpphzroC76mcWo
         Nqi2OKxF4nAGRYBcUNzWnbQlrkcnzX4e2i5z3cNyJl4hki6IqxF2NpjmfHXX3fWltwXP
         EGioNDVb30VJSg2Ey1jQ6+f9aiqE7SEnhFhJRDV4BTfQm4yt43spTUssJpdzBMFFR8Ne
         9MQFFu1Dj1skEd+3e0f3xVLT29jUlpgJEspLHj52JdWbt7nDUQruXG53YVF9njHOFqWN
         zsnaseQgc+r+e2y0RUTdvSvSocBKUkx7nu55iao55x7V0QWHWgENDR0U9OFU3MyV4NnL
         3ICQ==
X-Forwarded-Encrypted: i=1; AFNElJ8qpw5x9DtJEVnT0NQguFoRQHesn82pKAhBYNA2YOF+pPUFc3ir+YvGxOKnNjrvE02d3eWWEIM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMn9B88F4j+VaH6iugzXxcjZKVu39XY3Wp/3/6FqbVSgH4K35l
	4lyApagXhaosQXKqIgdAGN2n8btnXjYskHp+sNOczQb62+/PeQHi6VEko4+JP7y2Pht7hCGFxjD
	ageIFl+z00QksJAcSCvghivTlMe6KJJgHT1RqNjya
X-Gm-Gg: Acq92OFMIuJoTCIIZqf3E4i84SAs1NsgdcaGCIhfdr/FPhMu9jEuB9K4q8xnxi4HZgY
	vyJSp/UkKs0V25IW2PX+yzcgKCb0jseEr3vEbkloBG5Ulgcs8GzjE4yu476G71TT3ZxucfU4zaJ
	fdEBUjBXb0QqcKOZQvPDIkGeB7apd81vTTfaw4BLHCSNKh3rDOP/knEZ0kc07XCyC+2XwMsVIm3
	vnBa1yezA4wj4ivNUTWAdNIQdOyWB2OwfVC8vJDBT4hBlRX1sG8EzWfuqB+aivAIBfEtVNacE5d
	fMg+r094NA91ZUaAKYw/CFDqTYsdxzGQkRfeKC61gbCKoEb/9YSljQga70BgXgkNmkJJ1fIqXid
	mEF22S8w7dfydkgNjCzM=
X-Received: by 2002:ac8:6548:0:b0:519:55d9:f7b with SMTP id
 d75a77b69052e-519a8fa65efmr38914971cf.30.1781672086680; Tue, 16 Jun 2026
 21:54:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260616191359.4142661-1-kuniyu@google.com> <178165020689.1270198.450287651539968178.git-patchwork-notify@kernel.org>
 <CANn89i+8Gz7t1r7X_BNYhSozGZb61wH7eMgkdbmXWYE7RRP7Pw@mail.gmail.com> <CAAVpQUC-an33Jtt0Fk+DagQA0X6Ubssq9WNEJRV7uaZn0sQzKA@mail.gmail.com>
In-Reply-To: <CAAVpQUC-an33Jtt0Fk+DagQA0X6Ubssq9WNEJRV7uaZn0sQzKA@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 16 Jun 2026 21:54:35 -0700
X-Gm-Features: AVVi8CeGJUXnKsWsrZ1oF7Dh5v8LhJMv4tpfki44h44fOJduhmtSRfXyPIxgsjo
Message-ID: <CANn89iJmgEe9QGD5Yf-XzAxhvdVunFgy=HdU8jmfX5bidpxsog@mail.gmail.com>
Subject: Re: [PATCH v1 net-next] ipv4: fib_rule: Move fib4_rules_exit() to ->exit().
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: patchwork-bot+netdevbpf@kernel.org, dsahern@kernel.org, idosch@nvidia.com, 
	davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	kuni1840@gmail.com, netdev@vger.kernel.org, 
	syzbot+965506b59a2de0b6905c@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-300031-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[kernel.org,nvidia.com,davemloft.net,redhat.com,gmail.com,vger.kernel.org,syzkaller.appspotmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:kuniyu@google.com,m:patchwork-bot+netdevbpf@kernel.org,m:dsahern@kernel.org,m:idosch@nvidia.com,m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:kuni1840@gmail.com,m:netdev@vger.kernel.org,m:syzbot+965506b59a2de0b6905c@syzkaller.appspotmail.com,m:patchwork-bot@kernel.org,m:syzbot@syzkaller.appspotmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	TAGGED_RCPT(0.00)[netdev,netdevbpf,965506b59a2de0b6905c];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: EB822696888

On Tue, Jun 16, 2026 at 9:47=E2=80=AFPM Kuniyuki Iwashima <kuniyu@google.co=
m> wrote:
>
> On Tue, Jun 16, 2026 at 9:21=E2=80=AFPM Eric Dumazet <edumazet@google.com=
> wrote:
> >
> > On Tue, Jun 16, 2026 at 3:50=E2=80=AFPM <patchwork-bot+netdevbpf@kernel=
.org> wrote:
> > >
> > > Hello:
> > >
> > > This patch was applied to netdev/net-next.git (main)
> > > by Jakub Kicinski <kuba@kernel.org>:
> > >
> > > On Tue, 16 Jun 2026 19:13:48 +0000 you wrote:
> > > > syzbot reported use-after-free of net->ipv4.rules_ops. [0]
> > > >
> > > > It can be reproduced with these commands:
> > > >
> > > >   while true; do
> > > >       ip netns add ns1
> > > >       ip -n ns1 link set dev lo up
> > > >       ip -n ns1 address add 192.0.2.1/24 dev lo
> > > >       ip -n ns1 link add name dummy1 up type dummy
> > > >       ip -n ns1 address add 198.51.100.1/24 dev dummy1
> > > >       ip -n ns1 rule add ipproto tcp sport 12345 table 12345
> > > >       ip -n ns1 fou add port 5555 ipproto 47 local 192.0.2.1 peer 1=
98.51.100.2 peer_port 54321
> > > >       ip netns del ns1
> > > >   done
> > > >
> > > > [...]
> >
> > Note that even with both patches:
> >
> > fib_net_ops runs its exit handler -> frees rules_ops and fib_table_hash=
.
> >
> > The devices are still fully UP (because default_device_exit_batch()
> > has not run yet).
>
> I think this does not happen thanks to register_pernet_device()
> and register_pernet_subsys() ordering.
>


Oh right, thanks for clarifying this.

> During netns dismantle, we traverse pernet_list in the reverse
> order, and we should hit default_device_exit_batch() first and
> the rest of _subsys ops.
>
> Last year, I was writing patches to clarify this and move
> default_device_exit_batch() into the same RTNL section
> with ->exit_batch_rtnl().
> https://github.com/q2ven/linux/commit/d96f837a0007c8acc4ba1dc0d2f5b7ba02d=
d6478
>
> I posted a part of them as the ->exit_rtnl() series but
> left default_device_exit_batch() as is since I saw an issue
> (some _device ops->exit() must run before it ...AFAIR )
>
>
> > An external packet (e.g., from the host side of a veth pair) arrives.
> > In enqueue_to_backlog():
> >
> > Since the device is still UP, netif_running(dev) is still true.
> > Our newly merged lock-serialized check will pass, and the packet is que=
ued.
> >
> > The softirq processes the packet and calls __fib_lookup() or
> > fib_get_table() on the dying netns.
> > It will hit a UAF on the already-freed rules_ops or fib_table_hash.
> >
> > If we want to make the netns exit 100% bulletproof against this
> > remaining window (and not revert Kuniyuki patches)
> > I have patches hardeniin the routing layers (RCU-safety), making
> > rules_ops and fib6_table RCU-safe and checking for NULL),
> > and additionally make fib_table_hash RCU-safe.
> > This way, even if a packet arrives during this window, the lookup will
> > safely fail-safe (returning -ENETUNREACH) instead of crashing.
> >
> > I had these patches written yesterday before realizing the issue I was
> > looking at was generically fixed in enqueue_to_backlog()

