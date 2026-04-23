Return-Path: <netdev+bounces-280582-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wGGCBr+L6WkecwIAu9opvQ
	(envelope-from <netdev+bounces-280582-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 05:02:23 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 874EC44C6A9
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 05:02:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0907B302DE19
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 03:02:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FE0330F816;
	Thu, 23 Apr 2026 03:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P1WfLsmr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4AD178F4F
	for <netdev@vger.kernel.org>; Thu, 23 Apr 2026 03:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776913338; cv=pass; b=r/xGHnw52DlcVbi3QfoIPEHZs/BWolbQBURpq6E0L7CTWv4QvHIFUZUAdgqAQWEYMtprCa15OX3nxhzLdwwI4b4Y/PBji1YgIGu1BPsPZS1s7VcWmrEfvxwFW0IH6gxGMGchxOegD2EgsepmafUaZ+CS1JJLF9OeNWaLJ6bOQoM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776913338; c=relaxed/simple;
	bh=E6hkEOGESyKmWjWdt0okh8HE+iycOgibKcxZQyGHn6o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iOnqgjZOflCO52hZzd/TPpNOi/roHjVXbS5v5ArZxQ0tBORBO/aWd+zCVKk94gMVELAUs9UBTFbsB5uhZ4Jdv8YnoCNkXgzrzqjqyOMPCe5IGUlZpj2d628p0UNAxVV1Gi8ZlBcW7kUYPahqjn6naH8ObL4JS6CRGOHVj3lXimQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P1WfLsmr; arc=pass smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-43d75312379so4499743f8f.1
        for <netdev@vger.kernel.org>; Wed, 22 Apr 2026 20:02:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776913335; cv=none;
        d=google.com; s=arc-20240605;
        b=PNndt3RFUiGx4yWlIvc7TADam8YBO1/TSDki7wxf6wEZAghHNnrEwkPHmxyui9sn/9
         TikqbL210iftK9eni4jLqSrUsBy5MEF255n2gNs3vxzkW9WjObvqqMZzqpmQLXAYY9xm
         INrXjYQ1bEBo7VTdlM8ByDokMsacPBVR5N6sbTmfePyQA1sfy5QhkICI0ZuFCJEW/7gq
         AMT0F4Q1tCli7j3fs7PQgtx44U6TOispVMo1Qo0xsiadFa4hy/mwOl0XvY8tIgSp/A5b
         hH69AwoKztgcsMDL/nLQBPHcz3WD+aiO/Mb0ZjpI9DnxfOD7jScczJlo40JAjdaTSGu1
         fQFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=wCCN2vWTnn1FLYdK43Gndj8GHiNRh4VkMhL++OMbL20=;
        fh=enCVQP8DKrA1TQPsfbAQr/6NIA7rj5qICoqaC9MgWQA=;
        b=EENMN8B/ophHW44Qxw0CI1KI7Z8rcTqFgPopOmXh1oxOkmkjQJY6Y5LPT7BR6UpHlw
         SDZg8I/+wuRjeYGdWPZuQUsVQm7lVGFcXiWRoqGr8CUHUNTWNFf26crESqcJqgePobrz
         qOD8rHBIWUPDf9mbRDoni8USG6CZbcFtWPLrnHIEDtFXpywxd93xWpckcy/Qt4ZgGlVc
         4DHv2y9ZOKrqCNRUj/AgG/tsznwe9GUpnCVFLaiG66I/7JOVPQdAvS9VKIrbBcDQlFou
         fssVQQxLRv4ev3gvA8FK5qfO5o7IVm82EE2IzI8aQ+0Go5mDaXJJMuFNpc6JX83LpH7i
         2wSg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776913335; x=1777518135; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wCCN2vWTnn1FLYdK43Gndj8GHiNRh4VkMhL++OMbL20=;
        b=P1WfLsmrrEqNWzG+U0OJLBugq0kb7VU4eI3RvK0xBf/C9s1vCXVTmXuP7rW6o+yILy
         eC2sOlZ+lZTbVTTDx2X0SrNlfIPW/pSixdPo2PQitgpqWkLGLstAWy4f1aUaw1RNCYsP
         dL9LicI0N/QukUslHzh13cY3r54Bwc0rmcbMQx402P/f1f69N2Eqskjxga5XCBn2HQhH
         zVZl/HNKKhxeUmBD5WHQGLo0Wdr29vXZa02R84y+6apU9tejEc1N9jE8QradMrbESt3R
         QY8BvqTNH9oxX2ya6NjBs+R034wfwvGzm3F01y3tnVzGccsRfTJmny6fla3jc/gMDi4F
         Cjtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776913335; x=1777518135;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wCCN2vWTnn1FLYdK43Gndj8GHiNRh4VkMhL++OMbL20=;
        b=eVZFZvYU5iEa2zdRkBNFMt1ht+rcV3FIhfZdyQf30lhuA06qGLbI8+4SnZeFVMqG/e
         ffsSVhFuiJwbFG5IERyI+avmcbmbA/fDOvF9Pyv1YawvqvbUUpzztk1FLVhsKR6FVJ+j
         /vsfu3Yum91vDEH+bssOi+8HiEH/Z394PoPS79tgqz4bB936/oIrLvfEiIWt7DMQItty
         TnoSOyylRoflD0z1QPZxnuxmym0SWpZ7MiV+c3QbzzOLUfJijzfTz/MICoJEdCtx2k4H
         wpwUIa3cr05GuWnH8JXSvaqf/2cZwugtVHf+NcS2DYVhR8TMtwT3SYfRB327SnByxU2v
         GWpw==
X-Forwarded-Encrypted: i=1; AFNElJ9n4SPlkOW4RnHXQ21vX26MIxDneTPC2GIjOSv+fNmp4PB3rd4WuGq8Kn3diOe+ZJ1Mr/XCLXY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzor5aq07PuWWclLlsL3T9MJOj1yQhOkjmfqpzXiDJ2KZR1mBYN
	jmtKpzppgknXDu+Rhl6c8Y++MNLNeMVM5IHEcqAqh+SHYeqII19PGCzvcZiCd4xWqFC5BKGjIUe
	30DXRYtYOovwIR3dBxI0DGoglz+LKpUY=
X-Gm-Gg: AeBDietncckM/HIvDBNGCiqNAgMbXtBQ6YufgitvBC3o2MLtxVrGQ2KlSGSZ4IxlilQ
	/5TBgL+mNz5bGFoZ900jOxmDog5ujBY7XptkhtehQTuPT+TUPlrnOYEfJytrfAS4sM9YdMb0TYK
	HI6agAufhPUwX/dNw9rJj0mDQTfhUYt2NwKYj5JShHz4SYn3eGckMvMl7aELqv6+AwMzZ0Me1EZ
	dlZIHpWCS3CBQWmK4V0mKGBeZZtESHfTRfntp0PWTlH+8LWrpilewjOhWDtc1SwPgjuj9kUEzcw
	KnWb700grhpwnlLBq22gZb+Cn90xAsKPSH6CleJoG4LbaGVJ8w==
X-Received: by 2002:a05:6000:1846:b0:43b:5091:39db with SMTP id
 ffacd0b85a97d-43fe40737c5mr41041106f8f.13.1776913334883; Wed, 22 Apr 2026
 20:02:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260414013634.43997-1-ahacigu.linux@gmail.com>
 <CANn89i+vq9O8PJZaDf=0YjcKTM8=-64TcUn-i-F4siGKAMKz+A@mail.gmail.com>
 <CALjTKDkJ9L-88hdODbt-8D=eEDe6r5egtTfk_RnwgVq_NF+q+g@mail.gmail.com> <CANn89iKwgoxM==synaLGKEP3k0jtCJ4b+Bap8ZF9k8yHJGnORg@mail.gmail.com>
In-Reply-To: <CANn89iKwgoxM==synaLGKEP3k0jtCJ4b+Bap8ZF9k8yHJGnORg@mail.gmail.com>
From: Altan Hacigumus <ahacigu.linux@gmail.com>
Date: Wed, 22 Apr 2026 20:02:02 -0700
X-Gm-Features: AQROBzCvivoCD7FWwcAifCtw6r-Y5mvpGrUugIEjqEngrw9CdSKMIuv_-WRKNwU
Message-ID: <CALjTKDk464XE3tXieFDyeMjhqtPgbVruxnWZPdfwrMbAMaDQng@mail.gmail.com>
Subject: Re: [PATCH net] tcp: make probe0 timer handle expired user timeout
To: Eric Dumazet <edumazet@google.com>
Cc: Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	"David S . Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Enke Chen <enchen@paloaltonetworks.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-280582-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ahacigulinux@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 874EC44C6A9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Apr 22, 2026 at 12:39=E2=80=AFAM Eric Dumazet <edumazet@google.com>=
 wrote:
>
> On Tue, Apr 21, 2026 at 8:31=E2=80=AFPM Altan Hacigumus <ahacigu.linux@gm=
ail.com> wrote:
> >
> > On Mon, Apr 20, 2026 at 9:58=E2=80=AFPM Eric Dumazet <edumazet@google.c=
om> wrote:
> > >
> > > On Mon, Apr 13, 2026 at 6:36=E2=80=AFPM Altan Hacigumus <ahacigu.linu=
x@gmail.com> wrote:
> > > >
> > > > tcp_clamp_probe0_to_user_timeout() computes remaining time in jiffi=
es
> > > > using subtraction with an unsigned lvalue.  If elapsed probing time
> > > > already exceeds the configured TCP_USER_TIMEOUT, the subtraction
> > > > underflows and yields a large value.
> > > >
> > > > Handle this expiration case similarly to tcp_clamp_rto_to_user_time=
out().
> > > >
> > > > Fixes: 344db93ae3ee ("tcp: make TCP_USER_TIMEOUT accurate for zero =
window probes")
> > > > Signed-off-by: Altan Hacigumus <ahacigu.linux@gmail.com>
> > > > ---
> > > >  net/ipv4/tcp_timer.c | 5 ++++-
> > > >  1 file changed, 4 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/net/ipv4/tcp_timer.c b/net/ipv4/tcp_timer.c
> > > > index 5a14a53a3c9e..4a43356a4e06 100644
> > > > --- a/net/ipv4/tcp_timer.c
> > > > +++ b/net/ipv4/tcp_timer.c
> > > > @@ -50,7 +50,8 @@ static u32 tcp_clamp_rto_to_user_timeout(const st=
ruct sock *sk)
> > > >  u32 tcp_clamp_probe0_to_user_timeout(const struct sock *sk, u32 wh=
en)
> > > >  {
> > > >         const struct inet_connection_sock *icsk =3D inet_csk(sk);
> > > > -       u32 remaining, user_timeout;
> > > > +       u32 user_timeout;
> > > > +       s32 remaining;
> > > >         s32 elapsed;
> > > >
> > > >         user_timeout =3D READ_ONCE(icsk->icsk_user_timeout);
> > > > @@ -61,6 +62,8 @@ u32 tcp_clamp_probe0_to_user_timeout(const struct=
 sock *sk, u32 when)
> > > >         if (unlikely(elapsed < 0))
> > > >                 elapsed =3D 0;
> > > >         remaining =3D msecs_to_jiffies(user_timeout) - elapsed;
> > > > +       if (remaining <=3D 0)
> > > > +               return 1;
> > >
> > > I do not think this chunk is needed ?
> > > If @remaining is signed, then perhaps change the following line to:
> > >
> > > remaining =3D max_t(int, remaining, TCP_TIMEOUT_MIN);
> > >
> >
> > The if (remaining <=3D 0) return 1 handles the already-expired case and
> > mirrors the logic in tcp_clamp_rto_to_user_timeout().
>
> tcp_clamp_rto_to_user_timeout() has two conditionals.
>
> if (remaining <=3D 0)
>    return 1;
> return min_t(u32, icsk->icsk_rto, msecs_to_jiffies(remaining));
>
> First one was to avoid to call msecs_to_jiffies() with a negative number.
>
> tcp_clamp_probe0_to_user_timeout() has 3 tests already, you want to
> add a fourth one...
> I would prefer something less obscure.
> We do not care if we return 1 or 2 (TCP_TIMEOUT_MIN) jiffies
>

okay

> >
> > max_t(s32, remaining, TCP_TIMEOUT_MIN) with remaining changed to s32
> > also fixes the underflow; I used the explicit early return for symmetry
> > with the RTO helper, but I can switch that in v2 if you prefer.
> >
> > > Also, it would be great to have a  new packetdrill test.
> > >
> >
> > With packetdrill, AFAICS it would require a late ACK to be processed
> > after TCP_USER_TIMEOUT has elapsed but before tcp_probe_timer() runs th=
e
> > abort check - i.e. a race between the RX softirq path and the timer.
> > This is not purely an event/packet ordering problem, so it is not clear
> > to me how a deterministic behavior can be simulated with packetdrill
> > without tying it to exact probe timing.
>
> I was trying to sense if the bug was serious or not, considering last
> tcp_clamp_probe0_to_user_timeout()
> statement is:
>
> return min_t(u32, remaining, when);
>
> Perhaps you should give more details in the changelog. What were the
> symptoms of this bug, for TCP_USER_TIMEOUT users.

Yes, it at least clamps to @when, but still caused connection teardowns
to be intermittently delayed beyond the user's explicit timeout sockopt.

Will send a v2 accordingly.

Thanks.

