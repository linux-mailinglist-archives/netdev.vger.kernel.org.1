Return-Path: <netdev+bounces-294199-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id EZx+MX7MHmoXVQAAu9opvQ
	(envelope-from <netdev+bounces-294199-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 14:28:46 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1321062E084
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 14:28:46 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=wWTjWBjw;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294199-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-294199-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D131D300B113
	for <lists+netdev@lfdr.de>; Tue,  2 Jun 2026 12:28:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1224D3D9DD4;
	Tue,  2 Jun 2026 12:28:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6AF03D3D03
	for <netdev@vger.kernel.org>; Tue,  2 Jun 2026 12:28:42 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780403324; cv=pass; b=HBmVYoAH0jzTCRiqyUptYXFKb9E3I/AtwhFpEYTlUIsYTs+n7G9wtZQ1ygPbZBFc8ur1FXUQrrY7XtKZOR0UqlVJE5c/9valbn8AYko2B7DwnOzH6BqbqCdem8hdIdbSbFt9IZXyCuAObboc5GoFvHK4QSGYoKbE+O0SUGEms0M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780403324; c=relaxed/simple;
	bh=rAuKYYc1LLtsk/192M65WuzUGm7pFeBN31468/4VGfU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F6uS+NsOXP4Z0LvKmDURh3KKVKFblSDPMeMs0o2Uy+0Hd/6/Lo+DcS6yfmqTeoAulixqufC06aXdKNw15F7byReyaBcVPQlYNdZ/KCSEKS9zTIQr3QCmSjjxarEMIzMDZqkXTWqonh0Hu6yLXWV+3LCqPOmmV5wrysK9waT/cmE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wWTjWBjw; arc=pass smtp.client-ip=209.85.160.179
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-5174a3a025aso25393761cf.3
        for <netdev@vger.kernel.org>; Tue, 02 Jun 2026 05:28:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780403322; cv=none;
        d=google.com; s=arc-20240605;
        b=Hqggb1yQEZiPh+dnK8Q8h7LsIaVOhFFeOf81DZRLfy++3FFjvjvtz7McTbgZeNKxE+
         k3NoCyrsPDu4Ue6uTMRMZ4h887geSqS369rtW8ny3S/VSl7+cdVNOP9sQc6T0Uiq7815
         OVd6ZkmUBR3Bfppz/TfFATdUspIwJlhWGMr0eeDWseoXzHN1MuUx8gxo/OpowK0GxHpL
         PNT0JZXxtxgQi747xiGHX/h14HcIy0Ofdbg1fitOWmst0WojeaHAIkBZG6TBstA5RLvW
         vh2zlCYfrFQW6Li9Jw1kvM/Z7pBQZiY/xNPjdrsFo3pM+EyK7zq8vKEakIe7C2HinMKv
         8KxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=huMNWkQ3hEk+5oV0bypdpkcKUY2+EcTvl7D6WUQHUeU=;
        fh=DiYfPblFjd1FDCrLej9xpDFMrFfuYisMj3oDbroe4j4=;
        b=F3IxEW+poL/7cEqlxV2vGOrk3jQdYr4LEQxjqyvcQEWsE2X/6e2lTkWLcKaWBEJdKD
         lpnoQZIWNLzw1W5FLsPrsTl23/9jY5BEyyyGLWdylpnUDAe0rx5TXE52OONz5e6x72U2
         0F+TbLPAVLQ2HkhFUyIX2oy7a2QXFy39PreSeUvRTavZp48UEmc+RwT1sdSxWUo0jjmQ
         TUyW/L/CrmZEGZUbX0hZPNfO0v0naAIW18UXgHF6IECQhHboq//f83j1zolttFxcVN5x
         Wt2CKTcilQTQroByhGWUSO0Kv2TZCfzrYqDCg4sIHakbUCrgAiLs+9NIZ8Za8CF8DJk0
         ojqw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780403322; x=1781008122; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=huMNWkQ3hEk+5oV0bypdpkcKUY2+EcTvl7D6WUQHUeU=;
        b=wWTjWBjwFuVz594ASqf8hvmpYylSANTxDhM0GLgv9r7HBc2e1UdBXbyRLSUxZPSFhT
         ytnJXGBLrPMLZFumw4o/gLE2Fqpb0CDTEgqmBXrpTSDGJpc493Jy34WlvYLd8B+hiVIO
         wUPT4KOoW4oe7IqUays6PXh6e6iwGUvZE8Xd2N7R/I14JloHM3fT3DUz1My9GvRDFNZ4
         kWpoTeq0qfBzEBzd/OySTqgTFuoZW09SUrBo+zWgC/xWAQIpZUQYudZyYNdXVHwEWUBT
         gJb6tYwIrA1GgpOm23spN/ncgRjIviYGGHx+/8bIqQjRPm6NGKli5aHQhvYZkFqQEKrM
         FYkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780403322; x=1781008122;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=huMNWkQ3hEk+5oV0bypdpkcKUY2+EcTvl7D6WUQHUeU=;
        b=NHdJBLJ544HrGCM7OADn1Buu36yfBDfP4PLiiezU8snapz5Z4Ybj1r3WrRMzVC8agA
         xXCbSI/YLXmr9GP4GJMPXPndGlXzkCYW6Bi9aTur6pZUvyAnTkiQC5MSFpGT9tPZUCVX
         7gw3rIUKY0e+FhFnQi4bO4Qx8wCylgnGcChL1NqTjc1f/GyV1Q4uxlAiOP8L94Om+8AV
         lLBcPvHnDVKIo0jE0nHjdkS+v5DSr829eB61wGdJRHqPHiUJv0Nq0ePS0Fb+tlWYuct5
         xdaDkhIvMN/7oKUtNpT5Zd/mj4VY177+yzulCvDFPNfS7bCbTnim88ru5QSZMpHVhCs4
         9rQA==
X-Forwarded-Encrypted: i=1; AFNElJ+7cbpbBh+AFkQh7kGwD73AhEwjI0Erhb06rWpe9FS3tiz1KXS36nw0yEAA6jmQxLtQ4Y6LcrY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqQNDEnjqGbT7cdJwqLOKNV/iaKNnwnZ3hUA1RiqwxkMkFg4ym
	Q+jbKohwv90PDisV+ZiKdF4/V76dhI5xiPGuQnOZ/2hvNE0ZlrDFnl2FZbVTcLPNCsttZFDoDUK
	EEQ69X387oL4T+dvnryxR58xy4t3iHicd35zf4xIt
X-Gm-Gg: Acq92OGp5dy2Io/wbXX2+ffLMjBxhrsSXfVyIDrycL30iYHhwlasS3Mk6sJ0516LpXX
	TUwG20Ji9RlrF9Fu9/2KqUqZTwzGuo9jCP6a9YtsRCbl8FYQs7us8lPub9N/cZhFHEu4oC7Gabf
	9iHj2NLIiEUkV4HJmtXVHD4lGxTivoYsyhnNLSXZUSy1+tyf5K2i9M25VBmXFWNQxdJNO25P7pV
	Ir4/yF4zCLEMQapdkZhTY5sS7p14TOMF9yGMRoCjOjD/lnY6vKVcbVnqRsJB31b5PkzM9zQTQi3
	d7RvAzwViFBMWXqGnRMKEw0ZRPShdAYm4XWlO30iIu/R59neL7gm5NS5xOmHcLtio+333n/9aiP
	oNYXbsiLFBipCnZhFYKKxvTGW0SQu
X-Received: by 2002:a05:622a:a94a:10b0:516:d4b1:48e4 with SMTP id
 d75a77b69052e-5173a6d4975mr164866051cf.4.1780403316498; Tue, 02 Jun 2026
 05:28:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260601091816.444738-1-edumazet@google.com> <e218a832-2321-4758-be2a-0b0a51c700f5@kernel.org>
In-Reply-To: <e218a832-2321-4758-be2a-0b0a51c700f5@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 2 Jun 2026 05:28:23 -0700
X-Gm-Features: AVHnY4JaklF5cevzZ3AJ63bzYM9qW2G36AIp93UzxzlXPcUwsMxycKKSe_WhloI
Message-ID: <CANn89i+Lte7065CaZegV1PQ8hXpzbgN94UB-H2j8LtbC15ijHg@mail.gmail.com>
Subject: Re: [PATCH net-next] mptcp: change mptcp_established_options() to
 return opt_size
To: Matthieu Baerts <matttbe@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-294199-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,google.com,vger.kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:matttbe@kernel.org,m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:ncardwell@google.com,m:kuniyu@google.com,m:martineau@kernel.org,m:geliang@kernel.org,m:netdev@vger.kernel.org,m:eric.dumazet@gmail.com,m:ericdumazet@gmail.com,s:lists@lfdr.de];
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
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1321062E084

On Mon, Jun 1, 2026 at 3:17=E2=80=AFAM Matthieu Baerts <matttbe@kernel.org>=
 wrote:
>
> Hi Eric,
>
> On 01/06/2026 19:18, Eric Dumazet wrote:
> > Instead of passing opt_size address to mptcp_established_options(),
> > change this function to return it by value.
> >
> > This removes the need for an expensive stack canary in
> > tcp_established_options() when CONFIG_STACKPROTECTOR_STRONG=3Dy.
> >
> > $ scripts/bloat-o-meter -t vmlinux.old vmlinux.new
> > add/remove: 0/0 grow/shrink: 0/3 up/down: 0/-92 (-92)
> > Function                                     old     new   delta
> > tcp_options_write.isra                      1423    1407     -16
> > mptcp_established_options                   2746    2720     -26
> > tcp_established_options                      553     503     -50
> > Total: Before=3D22110750, After=3D22110658, chg -0.00%
>
> Thank you for looking at that!
> > diff --git a/include/net/mptcp.h b/include/net/mptcp.h
> > index f7263fe2a2e40b507257c3720cc2d78d37357d6d..cd4639beceaa53c573135dd=
aeb7528a80b4ca824 100644
> > --- a/include/net/mptcp.h
> > +++ b/include/net/mptcp.h
> > @@ -149,9 +149,9 @@ bool mptcp_syn_options(struct sock *sk, const struc=
t sk_buff *skb,
> >                      unsigned int *size, struct mptcp_out_options *opts=
);
> >  bool mptcp_synack_options(const struct request_sock *req, unsigned int=
 *size,
> >                         struct mptcp_out_options *opts);
> > -bool mptcp_established_options(struct sock *sk, struct sk_buff *skb,
> > -                            unsigned int *size, unsigned int remaining=
,
> > -                            struct mptcp_out_options *opts);
> > +int mptcp_established_options(struct sock *sk, struct sk_buff *skb,
> > +                           unsigned int remaining,
> > +                           struct mptcp_out_options *opts);
> >  bool mptcp_incoming_options(struct sock *sk, struct sk_buff *skb);
> >
> >  void mptcp_write_options(struct tcphdr *th, __be32 *ptr, struct tcp_so=
ck *tp,
> > @@ -266,13 +266,13 @@ static inline bool mptcp_synack_options(const str=
uct request_sock *req,
> >       return false;
> >  }
> >
> > -static inline bool mptcp_established_options(struct sock *sk,
> > -                                          struct sk_buff *skb,
> > -                                          unsigned int *size,
> > -                                          unsigned int remaining,
> > -                                          struct mptcp_out_options *op=
ts)
> > +static inline int mptcp_established_options(struct sock *sk,
> > +                                         struct sk_buff *skb,
> > +                                         unsigned int *size,
>
> I guess this line should be removed: that's the version when MPTCP is
> not enabled.


Ack, I am sending a V2 fixing this. Thanks!

