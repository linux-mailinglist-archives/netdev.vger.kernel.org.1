Return-Path: <netdev+bounces-253655-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cDi7FAQeeGkKoQEAu9opvQ
	(envelope-from <netdev+bounces-253655-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 03:08:04 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C16768EDF9
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 03:08:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8E9483031030
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 02:07:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 240CB284669;
	Tue, 27 Jan 2026 02:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="L3NQO6yf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DA7C2BE7D1
	for <netdev@vger.kernel.org>; Tue, 27 Jan 2026 02:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769479621; cv=pass; b=OoUDxos9zsKp9pyKy9UE9SRJqchvgpb+0FDT6iOh1DvJpInTPWXrbQ3PTSTIvo33cUcPYDKSWn7zliLYMPb9ahFkNWd6vGRZQGmGWFSJrPMYDzP2L5jZmm084q3QTKqa6LPmTPHy/FDenukgqLN78b4gMAiQobAHGLd85LIPQ/c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769479621; c=relaxed/simple;
	bh=GkcehKoQpcM72Bkf5NtN/ey6Zoa56vvQxc0nnSFeNKY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sa1hP0UlAIBJ2tYEsVfHBKHKDPN0xII7dK3ZJV+8Df9E52z59o/AOobj/AIb/6F33mw+zC3RGAlTM1XAoFm3Y8DiFah22ImnJGszkRk2ylKWnufn85Jn1BSMB+rEfVC6C4EK5JxOOV2o5L9CS3BZ+c30K8JY5wZaLoJIyQsjsbw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=L3NQO6yf; arc=pass smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-5014e8a42aeso73659101cf.2
        for <netdev@vger.kernel.org>; Mon, 26 Jan 2026 18:06:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769479608; cv=none;
        d=google.com; s=arc-20240605;
        b=YP6UmPjpcG59DC3nG4IwfCVKIkhmwVbgjogb/KrEHJrOIB6x0F1hEOdtx69synHjmM
         jYDBVWPER6TIshwfiOzxNV9d09/BHnjQycqpp9bskd2WPWJAubCi2KNfmRkYEbtaAWdJ
         6aYR0N+EBkjCrCqF9g6ynawZHNMKZ2yIyJig7VJeogkrqavJ2IQ01kyXYWTY1APQlJRA
         KdnFkj9LxxCarMLjKO2EOGjgGkVoYrPIukq1G1rNu/yGcCXvD0JZLr3BSk/CZPc7HuUv
         uV5QwIj53lbKA/LMctCrcxejwQ43j8eYP23MrWLyuDVuN2xJ61yniFVu3jmXoUtzpWdf
         z5YA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=NuUUo3qfOa6WUnQ6fm/hKaevO6wQzG59TvjMz40D9jw=;
        fh=Y0ydq08vRfaS7eZYFwstz6LQbyWBwdSP40VqLMslpQg=;
        b=I09YsCm4ryEbdidMEnR/2Fja5kZtDHK9Ako+Vqc+oxx8ANT4SRXhM5cGN7W/9vKcbf
         Sce6yZUdGeByH0SFAsYyrUE5YKEpHY4A+uq24gp6onAlvZUcHmOB6TmXI58RIUK0WQXe
         qsYh208YgAOMTBUz4vO7NAhVpkHCv1Qz51W6Tv5KsT6joyeGAbvTZ9IEIZixTR4wlb7K
         WJok2ZcjpHSGmbEFwpKxhaCV34g699Tz9Cg2X/kX88oJ1Rb3UpxjBrxykjezvlYeWEiA
         LzHEQO4ce9AAB4fiotqhlNgO2dmNBuiMIUaEj0NBQDtMxhWmHvEVxp0/6LsqCTUjWFVb
         eIPg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769479608; x=1770084408; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NuUUo3qfOa6WUnQ6fm/hKaevO6wQzG59TvjMz40D9jw=;
        b=L3NQO6yfz4mpI/u8Nsvu+L3KdS3TZ/hkVreYP7THL91ZJHV9j/druDnWHAf/IwLwLm
         mJg8Tvn2ixnnOFQGvhn/QQ8KqRioK8LDv/4pQVUAGU4WJBXLCybFKn7b0MAD+1GbnIh8
         f+5/IqvUdwnYcHqart0ANk8785eHUP/Zg7NM01dOM2CTYEYFmFjcNtL5rOoPPNrHhkXv
         7oHw0V1JQ7OOsWBJhxIr4jzfzPO440KnJDJaxdxrwvmrsVKKyaD5btFNzTg/NJjqY8nO
         BtOqni8F/n+kJipm3oeXzSws2W0v2hCIzGiUGQok9jAxwdY6HULP+Sty65NZ53qty8gI
         jKXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769479608; x=1770084408;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NuUUo3qfOa6WUnQ6fm/hKaevO6wQzG59TvjMz40D9jw=;
        b=b7kIAAkeel0RKCBOxZeLJApxaedFzwbcKq15ob3IXASmGVJijKeU5thprt1YqMKpH1
         fBxzg3iNa/Z1uiXU4zAb2KZjtSzS8ZwGr5SkUKeS+7QTzI8a7mh3eOqynVtfzSHtCDHW
         /MAmHPPt54vFh/swNckBAGWVVL+ZHxQRYN0qkEbyUuxTRpb4Y+hpqprfoHBY5INXggIk
         mQ1w82vf/Q7s3p00cWZAdVfiI8jbJwGfwxFSZHk6eV/ZqxI0TstsWiMFnTCZPrtTmX83
         mWmM1DCTTKeCHYmH/uG7BXyyh9uzxehAuhmCGGfN8Iq+nQPOtPTs/riNQfD7NLV28FWw
         AUzg==
X-Forwarded-Encrypted: i=1; AJvYcCVtcRWNpv0CDXioMiR7FBwsThk989Z12eQQbMp3iGoenIQMTVZHMydYinBLTCSTbdE0X5C+3EU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCtQlmyQnr+PjF4DdfukeSIo02Pb30IuV0Qf0yqUyv+1gjCOtM
	V4ii0GQoL19ddqkuzkhHsMannHPn9ha2pVzvjJXhqLv9qJ+X9nYkiLvOFBbbAp1lqV5y4CSu4l4
	M3aMV2E5Te3Ho35wvjoTD43OPC/tzTlvHedDXQnba
X-Gm-Gg: AZuq6aIyQzKY+H3rpz+r4DeBuRW/9V+xoCs6DzoQIFPNsnn0Yc040IPuOC/m4J61Vy8
	b63OZ0qDMoE39vPwRyH24eFjBSLl3GJj5mfyyVdB2ZhxSA97RV2bFz0dayTUax1/4rfN6lhyfyD
	4e7wELE2FG7gJoD06+BsLxsa3dhSmhmBFm2fIrqg0mAKhxIMh9UwchtW/uBI/4WVDao/BH9gMy4
	4v3oR8d/rXIli3uBq9neZ7usbpaFMZFrSBbdH4NKRAPy8vbuH4gdXq1jp1BlZxGGCf5s65wZRTO
	9gHMrzQ=
X-Received: by 2002:a05:622a:14b:b0:502:a2d8:453d with SMTP id
 d75a77b69052e-5032fb1d7f5mr1609811cf.66.1769479607750; Mon, 26 Jan 2026
 18:06:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260123111605.4089200-1-edumazet@google.com> <CADVnQyktV_z9=SoT7yhkT6mBQKRjaJgpwLhR2SdWGQS3iKD3Tw@mail.gmail.com>
 <ebb3a731-a3ec-444e-8efe-aa13cb76adad@redhat.com> <CANn89iL=a922QTQUwr5EK6XeL+gQu-zeqca1PYhs-NBu3aeyzg@mail.gmail.com>
 <CAL+tcoCsAJ+pOs6M2E2xRMa=VKNB9wwoR2DEbiFyvOmfe_dkGQ@mail.gmail.com>
In-Reply-To: <CAL+tcoCsAJ+pOs6M2E2xRMa=VKNB9wwoR2DEbiFyvOmfe_dkGQ@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 27 Jan 2026 03:06:36 +0100
X-Gm-Features: AZwV_QgusQWfaiWsKd4hXnvEucyTzP8Plqs38lKiWhgSUBSGbvUof1auEv6HmrI
Message-ID: <CANn89iK60d+X0eRffN2jrJAON4DLsLH2Y+Yg5f+OOsr5mGGsNg@mail.gmail.com>
Subject: Re: [PATCH net-next] tcp: move sk_forced_mem_schedule() to tcp.c
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: Paolo Abeni <pabeni@redhat.com>, "David S . Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Neal Cardwell <ncardwell@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253655-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[redhat.com,davemloft.net,kernel.org,google.com,vger.kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid,vmlinux.new:url]
X-Rspamd-Queue-Id: C16768EDF9
X-Rspamd-Action: no action

On Tue, Jan 27, 2026 at 2:56=E2=80=AFAM Jason Xing <kerneljasonxing@gmail.c=
om> wrote:
>
> Hi Eric,
>
> On Mon, Jan 26, 2026 at 4:45=E2=80=AFPM Eric Dumazet <edumazet@google.com=
> wrote:
> >
> > On Mon, Jan 26, 2026 at 9:18=E2=80=AFAM Paolo Abeni <pabeni@redhat.com>=
 wrote:
> > >
> > > Hi Eric,
> > >
> > > On Fri, Jan 23, 2026 at 6:16=E2=80=AFAM Eric Dumazet <edumazet@google=
.com> wrote:
> > > > TCP fast path can (auto)inline this helper, instead
> > >  of (auto)inling it from tcp_send_fin().
> > > >
> > > >> No change of overall code size, but tcp_sendmsg() is faster.
> > > >
> > > > $ scripts/bloat-o-meter -t vmlinux.old vmlinux.new
> > > > add/remove: 0/0 grow/shrink: 1/1 up/down: 141/-140 (1)
> > > > Function                                     old     new   delta
> > > > tcp_stream_alloc_skb                         216     357    +141
> > > > tcp_send_fin                                 688     548    -140
> > > > Total: Before=3D22236729, After=3D22236730, chg +0.00%
> > > >
> > > > BTW, we might change tcp_send_fin() to use tcp_stream_alloc_skb().
> > > >
> > > > Signed-off-by: Eric Dumazet <edumazet@google.com>
> > >
> > > I've a question out of sheer curiosity: are you using some specific t=
ool
> > > to look for inline opportunity, or "just" careful code and/or objdump
> > > analysis?
>
> Paolo, right, you beat me to it! I'm also curious :)
>
> >
> > I am studying performance profiles on a stress test using Google
> > production kernels,
> > on platforms that are a big chunk of the fleet.
> > These kernels are very close to upstream (at least for core and TCP
> > networking stacks), and use clang and FDO.
> >
> > I am currently focusing on some functions that even FDO does not
> > inline, for some reasons.
>
> Eric, could you share your more valuable experience and methodology behin=
d this?
>
> Prior to the recent work you've done, I completely missed that we
> could even do something with the inline functions. Normally using perf
> doesn't give us a clear micro observation of those functions
> especially about some hints on whether we should inline some
> functions. If there is any tool, it would be super awesome!
>

perf is your friend, and a deep knowledge of your cpu-du-jour behavior
(assembly)

perf record -C xxx -g sleep 10
perf report --no-children

<Use the perf UI appropriately>

> Let me guess, are you trying to avoid function call action as much as
> you can in the hot path based on your deep understanding of
> ingress/egress performance?

I think you could answer the question by parsing the changelogs of my
recent commits ;)

