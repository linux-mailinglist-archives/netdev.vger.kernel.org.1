Return-Path: <netdev+bounces-300028-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id SmH8DJEnMmo5vwUAu9opvQ
	(envelope-from <netdev+bounces-300028-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 06:50:25 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3230E6967F1
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 06:50:24 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=VNTP5dnS;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300028-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-300028-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 05113302EF7B
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 04:48:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 189F931E827;
	Wed, 17 Jun 2026 04:47:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A5F531E822
	for <netdev@vger.kernel.org>; Wed, 17 Jun 2026 04:47:43 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781671665; cv=pass; b=emwATj2YO1CMmLL9Kz3VafsQqGRRiD1sXl2koM0G4mZgLjTPLWUMo7Gs1gqtvQhkks/8HBpVsU+Y97FjG8Vzhn4T7Tuazi8KKmCf6AjjD+abp3uqZPJqk/y+WovV+8EQBSnAPkAL2XCj6Rp5Xh1shMBn1YSHB1sx4lEig16XdYs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781671665; c=relaxed/simple;
	bh=YC4s6Z69YkWf/lSjYOa/1Nqx5dXVjNx1ObrqqXuOJZc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OKm7HQ73mtAUbfPC373P0YcJZjkN7AOQIHyWqhfGnvWMRe0yDZlllnpJ3YICeGZPBxIooCW8H8UpEBHtMreDUVYpahKl4MVhM8R4PgOu31/j1keAyO8oqDCruWSzeAR8Q1Glsnd3pMn+lkNkgEX22KKYk/DF52UxR/rlwhJ2r7I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VNTP5dnS; arc=pass smtp.client-ip=74.125.82.54
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-1370417c01cso6939390c88.1
        for <netdev@vger.kernel.org>; Tue, 16 Jun 2026 21:47:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781671663; cv=none;
        d=google.com; s=arc-20240605;
        b=VTR+w2BXCbvW9N1Nz+4He7KhiB3CB/nJK9n64mbHhNCKdTwv9BSjrfbM/JQhCnHu48
         ZYeUpNEjl2EVDfUF2mnm2NVS+mU66C5oqng7H/OWCDxT4MCaxDoowcToMyT2DoTfAiy5
         Z4H8aikSvavVMTjQOkLyH5jMFeUHF+xolV1iLq0/GZvFESb2rwfSef/eNvC+ocrwJ97s
         cr2AktC9kgfZeNGDz2d3YfX0bLNVhv3xcsGHgjMd7Al2YT/VB6+Hjm9kkG6UbgLIsAoU
         bp2l2qB++fXoPid4cg/WLFGinjhcfcA1l68c6qgv56NbI8ggwnT0Ip0+Rtw9uLHvCEWf
         SsPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=at1oYNu7sOJ8S/lnjUd3w2vOI/s4Lm6T5k9vWKNJoXU=;
        fh=zNxrugUBDdHghH1cq9wKVHOng0gKNCQkkVOsaHXmk2g=;
        b=aniKhuRRHVuu6nYVlA10IWSGbvSH7jL0rXuoyR5SQIHiZbiCGfZ7IqFYF9iG8mKKyI
         Sfx9ArKRqJ4jhzhxTDHeQQNG1HiWmC8/Q5Oy417IlVIjtOIJKOKdIxZCL+6pnj9Svd7U
         x7c89dKGa/8qPmLze8/n/gg/gghkX0Otc9Z1Vl68FKc8KPVgkfj9cYkl+KoKmorkgpXu
         e2n5eiwc+fkU7NBD1i1Ocj4NPwEkd9V33QzMp6kBr+wBABbds+r9pDHAaae7DX/NSsp/
         KUAY1oPbQVtcy2IfefnJR0qKxVQTpMdkMLMX91kWP6g2QdbuOVPQXF6o3r+W/v+Fkabw
         cdOQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781671663; x=1782276463; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=at1oYNu7sOJ8S/lnjUd3w2vOI/s4Lm6T5k9vWKNJoXU=;
        b=VNTP5dnSsfoZOD2fKIZuizZ6pIl2z+VBaOL3X9bUhBejIPF9LH8pZKK2ucCJZbP3Tz
         J3XriX7nR85v6bpI9jBvjlH1l09iLioIeRnzw7zDm7RZxq+JXjxQR12N1EHrfntNflXi
         vPUsc4dhJVHmcLxRUVaIg8Lt50sVXw6NMeBiNfL+3eMUneupK6TkuLprFGwXg9WEPn+F
         oC4F1y1SJ/mz486PkPNxqKwpcHmlzJIFM9cE4uAsxW6+i4yO3f7Off4wr2mxn353mUPa
         s+1Qqx94J0RV1MlJRoX2KNzHi9Sw+Wt3TGkNOHNepo8lmdY14zs0m72h4I9go2Z70iqJ
         OhLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781671663; x=1782276463;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=at1oYNu7sOJ8S/lnjUd3w2vOI/s4Lm6T5k9vWKNJoXU=;
        b=gvzqmT/tAG8UT1xrJXmK+abpdWAUwzul6cVWO86dYUvmn7EDWzhvoD0k45eAfamI/h
         xdyypEDh2xBt5Zta8Ulba313jYtY5AcFq2xjn5xiI7W7L9vqfA6EqPbTqzAyebY4ogqB
         C2PYvXSe1krAqPi53CpkYx9YkqiutbkwvJxSKNqA0IMroVrXhhFE2eWYuuYwDAaC6q5N
         +hNdu+uS5VLtUf19cekZKLYkBiJ+cSC9LBN1G9pB0AKCnArtgUTvEk1jAblFhsDdPSs1
         Ub9c/qYQJWzR7uAxJT1/Xwc4O16hRZBD9x2TntkqwQcahhboqCxeQ/sq6rWFsUzMF7GP
         3Tdg==
X-Forwarded-Encrypted: i=1; AFNElJ96vy61OXBj6/cBiqyCIAsVRexC7kfkcIYayuTqzHTHathlgjrA3ex05Rxo/3K8hatH7YvkOJQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWIvZgvuzRPTZ66cE7sX9JOuZ0+zOQVA/DKGIqrf+rTyhsbpwu
	weIn/MxpXJk+OX7bXoBJYY0X+yDIu9q9xFp4KywAcGbP2xv1doirGLxGl0owbAmR3DvDZQPbj65
	xjpcxEChWm1uyh14/wT0f+VBldoVw6VWZ6sYjXgDa
X-Gm-Gg: Acq92OFBr8f/PaoZDDG7HeD94ojyduPipx4ZvZ6Eq0yP8fmgnFinxSn1fdMCEeyzdP6
	9KePHfn+jB4zS5V5vedj3obbxJP3FZlfaEYwFF+FvfhBjOFpOYCGUGasIzrM7bOZoe/IOFXBpyN
	9ubihtVcU7aTwxg6FVzpNaYPDYjURBZvNEwcbv+XjDpuVxKaPIQVseBjfTVsh6pgdpFj73IN00m
	AdrcpW0NmkmvRGyDur9zePO93pDYVWEO2k3tkW+BoH+4WWZu72IRbk1qnZt3mqYk8ha9SKVKD3B
	jJ4eGkb/v5wiBKMT8bmIg2goMS668eZovp2USyWQy8NTLT9kgdW60SjPwSLgoYfdwOCKcdJTawF
	a4hW+tcUs0Uw/93ooJfwwzjAWBnbzFQYrTmqEyfmYy6uhmEguM2nm
X-Received: by 2002:a05:7022:628a:b0:136:5c88:d917 with SMTP id
 a92af1059eb24-1398f623328mr831219c88.2.1781671661786; Tue, 16 Jun 2026
 21:47:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260616191359.4142661-1-kuniyu@google.com> <178165020689.1270198.450287651539968178.git-patchwork-notify@kernel.org>
 <CANn89i+8Gz7t1r7X_BNYhSozGZb61wH7eMgkdbmXWYE7RRP7Pw@mail.gmail.com>
In-Reply-To: <CANn89i+8Gz7t1r7X_BNYhSozGZb61wH7eMgkdbmXWYE7RRP7Pw@mail.gmail.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Tue, 16 Jun 2026 21:47:30 -0700
X-Gm-Features: AVVi8Cexu9nOah-D-uO2HBlsXNthwhXEbFLIMgic7LmUCR1yFA5P7wI3RgCHaF0
Message-ID: <CAAVpQUC-an33Jtt0Fk+DagQA0X6Ubssq9WNEJRV7uaZn0sQzKA@mail.gmail.com>
Subject: Re: [PATCH v1 net-next] ipv4: fib_rule: Move fib4_rules_exit() to ->exit().
To: Eric Dumazet <edumazet@google.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-300028-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:edumazet@google.com,m:patchwork-bot+netdevbpf@kernel.org,m:dsahern@kernel.org,m:idosch@nvidia.com,m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:kuni1840@gmail.com,m:netdev@vger.kernel.org,m:syzbot+965506b59a2de0b6905c@syzkaller.appspotmail.com,m:patchwork-bot@kernel.org,m:syzbot@syzkaller.appspotmail.com,s:lists@lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,nvidia.com,davemloft.net,redhat.com,gmail.com,vger.kernel.org,syzkaller.appspotmail.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	TAGGED_RCPT(0.00)[netdev,netdevbpf,965506b59a2de0b6905c];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3230E6967F1

On Tue, Jun 16, 2026 at 9:21=E2=80=AFPM Eric Dumazet <edumazet@google.com> =
wrote:
>
> On Tue, Jun 16, 2026 at 3:50=E2=80=AFPM <patchwork-bot+netdevbpf@kernel.o=
rg> wrote:
> >
> > Hello:
> >
> > This patch was applied to netdev/net-next.git (main)
> > by Jakub Kicinski <kuba@kernel.org>:
> >
> > On Tue, 16 Jun 2026 19:13:48 +0000 you wrote:
> > > syzbot reported use-after-free of net->ipv4.rules_ops. [0]
> > >
> > > It can be reproduced with these commands:
> > >
> > >   while true; do
> > >       ip netns add ns1
> > >       ip -n ns1 link set dev lo up
> > >       ip -n ns1 address add 192.0.2.1/24 dev lo
> > >       ip -n ns1 link add name dummy1 up type dummy
> > >       ip -n ns1 address add 198.51.100.1/24 dev dummy1
> > >       ip -n ns1 rule add ipproto tcp sport 12345 table 12345
> > >       ip -n ns1 fou add port 5555 ipproto 47 local 192.0.2.1 peer 198=
.51.100.2 peer_port 54321
> > >       ip netns del ns1
> > >   done
> > >
> > > [...]
>
> Note that even with both patches:
>
> fib_net_ops runs its exit handler -> frees rules_ops and fib_table_hash.
>
> The devices are still fully UP (because default_device_exit_batch()
> has not run yet).

I think this does not happen thanks to register_pernet_device()
and register_pernet_subsys() ordering.

During netns dismantle, we traverse pernet_list in the reverse
order, and we should hit default_device_exit_batch() first and
the rest of _subsys ops.

Last year, I was writing patches to clarify this and move
default_device_exit_batch() into the same RTNL section
with ->exit_batch_rtnl().
https://github.com/q2ven/linux/commit/d96f837a0007c8acc4ba1dc0d2f5b7ba02dd6=
478

I posted a part of them as the ->exit_rtnl() series but
left default_device_exit_batch() as is since I saw an issue
(some _device ops->exit() must run before it ...AFAIR )


> An external packet (e.g., from the host side of a veth pair) arrives.
> In enqueue_to_backlog():
>
> Since the device is still UP, netif_running(dev) is still true.
> Our newly merged lock-serialized check will pass, and the packet is queue=
d.
>
> The softirq processes the packet and calls __fib_lookup() or
> fib_get_table() on the dying netns.
> It will hit a UAF on the already-freed rules_ops or fib_table_hash.
>
> If we want to make the netns exit 100% bulletproof against this
> remaining window (and not revert Kuniyuki patches)
> I have patches hardeniin the routing layers (RCU-safety), making
> rules_ops and fib6_table RCU-safe and checking for NULL),
> and additionally make fib_table_hash RCU-safe.
> This way, even if a packet arrives during this window, the lookup will
> safely fail-safe (returning -ENETUNREACH) instead of crashing.
>
> I had these patches written yesterday before realizing the issue I was
> looking at was generically fixed in enqueue_to_backlog()

