Return-Path: <netdev+bounces-293405-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cJlOIKwpHGrqKgkAu9opvQ
	(envelope-from <netdev+bounces-293405-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 31 May 2026 14:29:32 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 26476616101
	for <lists+netdev@lfdr.de>; Sun, 31 May 2026 14:29:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DB7283001FF3
	for <lists+netdev@lfdr.de>; Sun, 31 May 2026 12:29:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EF9F37CD2B;
	Sun, 31 May 2026 12:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="GVclD6ra"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C275D364EA5
	for <netdev@vger.kernel.org>; Sun, 31 May 2026 12:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780230568; cv=pass; b=ErZBPmzzV0PSQYPbXppxdP3xumf8+FjVNGCgfYT17i7wmQ1IoF0h19bnIE7zFVE2dau5T2ulNZEffytZVpPobJf7ckORWH1zMKYXOWORUkhxF+0k9A4MGBJ/8CBJma+IlfM8eHQJWyDuVkBRfOv++ngcxF2xQhzkhrCMO9HrGHc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780230568; c=relaxed/simple;
	bh=HlhE5NVSGbTLNcUQbLKcVzX3x6onf9avbYbRkkHlpss=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PU/jYH4JjwNEQAKL4SDbcoU739UTARjQq2YdCabvFAYhwHQQYEG32TcMeMRVZh1Eud0GQvrwqh5qWJRPZHnKBKexPF5Y92+ikPZWLJzpGM/rm7ceUGwl1QgA9xSyJdEpqZ5gMzAujit3Y53kLAR9VD7h1zgQwgXoWOUcLYkszyQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=GVclD6ra; arc=pass smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-842358aaf36so191504b3a.2
        for <netdev@vger.kernel.org>; Sun, 31 May 2026 05:29:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780230566; cv=none;
        d=google.com; s=arc-20240605;
        b=kvdIiFRkzDdW3FNa9Gujy0gvofAywVSWosejEknBa7EhG/4rVPBF1INQbHg/ltWmiC
         MIknEJjaiaxj57HRbafRwyMCCk+lMYm5jmqVU8HlB1adi4yw5EQpFyA4pE35uuy/CK0i
         BhLRwQpU7Xsfn3vHWzfsKGvA1EVfzgf9hcK5WbA1dNPKvrOJg8lPKBxNIe4b9Kq8CtPZ
         2HfFQPr5xZ/dD7cNe1WlQbQr+yj36/piWN8EoBwhwCSUSxcl9otcOEr7BxHvVnzh0Cqz
         K3mZLXPPPCVs14/bhJp1BkommwCWZ280piOo5GaPapuETPLWQpnx2USlhya2TUVc1IqW
         p0/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=YFgEcZSfc5yP97jZFxA+JDodaniti4g996XJsD6nFn4=;
        fh=CZlqreM5+7+5mMHP6qPd1TfrehY9udzjmsxD3tzPdVA=;
        b=G5KIqgiWPuhSYWNj5nuqsI3Prt02aghoIvMo8ZmOFhU5l26JmS2/u/XVETWO3f7YgV
         xR6KOVbMWqMzEAmGIAL8/3oEZgS0QpGyBXDJ7332Pl9yzIOniLdRAXD4hjUPLYf+/i32
         8B6wjvfSFAy5SHGyfPPfIxiO+bCKWHz0BwF7eXgqWqQtD2a2GASb/9XxPdQLwLj7+aVP
         ItBApDy+8C5VyxTGSZSCQS/e+PRFokzSp5BTv7ApWlS0xUlKrHlQw0/y+aPawak3Wqpa
         OnRrQNZOAFa/dVmQVFInps3CcZDdcvcz+JJYV+XcruhLs0vqjCXcrnzcqD5qezo1WgVT
         i2NA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1780230566; x=1780835366; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YFgEcZSfc5yP97jZFxA+JDodaniti4g996XJsD6nFn4=;
        b=GVclD6rabhX5hq1BNBo1hmoubcQdesgwkul2R2wYjRh5wDI3iPYem2TwLjkdKlhP2k
         L81KeTdhJfhKJvpf7QrAXICuErzI/4j0ILrSE51QkPltuvMFGG7Ad6A5RHPQbx0KJLcL
         h49dt0sInqF4tUIvxsAvAy52wrBwt7f4NIb1g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780230566; x=1780835366;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YFgEcZSfc5yP97jZFxA+JDodaniti4g996XJsD6nFn4=;
        b=GR9e6pEtEDWAGFxVjcELa/2M1J1vLm0VNPIYHlLPpjIACQ+LBxIBzXfHP318soZaVI
         ZwRa39LMjpzxe6W1AKj5nC9RfoUb8hMjTHc9Uk5UCzX4m9DdwQIL2RJLPGC+Dd9cx3ad
         6StyBzfT+G7dJKZCrZJggpeA6jv5C0Ejt9/4geOb1zZjbk8yLOXGkOv8qwxTeng6IJ8q
         hK/1cl+3gY0j0RFqxI9hencpKI0yT1S0UPjuKGQ5M3cA/uLgRUrVSU2RpZ9ncthhlMw7
         6+/5h9y+7xf1DW/+F7XL6Q+q8Y3KXISB/DLHcPx3oaaWnbfJmTVBuhMLQboS1yhQtEZ9
         ANKA==
X-Gm-Message-State: AOJu0Yy0DFI4Z2dSZklDrZjvC3hjd6qWYqYk7wZfzEQjpXEWZZ5XEfiZ
	nidm0gTAaDlTiuzBGs3RSLrnFzI9zaBMbjfjHUaXcZ+eSccHgc1UGgQWk4qDKvgBm/dkJaTfVzR
	r6BgjpjeHDmROjHeTaD+QClLYuwoOd1m17f37R+NB
X-Gm-Gg: Acq92OGGrhxhtphj6djJ6ByCYSKg5Ok1GTB3ukixyNX9N3TLfvUVnY7RHs+FhomQMzS
	6S/mF1iXaQr5i3ppajv2hDX0CHkmTNXxqKlHHob3kYVxACrodEPB5qhh9mTyHL/MDQnuvcsELmJ
	NsANZ83tJnVdmTzjZFo2eJdGY5oRrKCiuha6vaOKBCWdPfuMgMDhVRk/Cpck3XxtM3ye1gYVg5i
	EMhOgm1vTQ9T+fDJvJieVU07WOpy/WUs7Gbt3IwYGj7D8amsVLN5vgEzGtx7JPQD7FdtMFqDJWk
	+iWCDJuuiUu4UBKy5OQ=
X-Received: by 2002:a05:6a00:3c91:b0:82f:38df:681c with SMTP id
 d2e1a72fcca58-842253d3c9amr6115185b3a.6.1780230565684; Sun, 31 May 2026
 05:29:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260530080643.1345521-1-jhs@mojatatu.com> <87bjdx2ads.fsf@toke.dk>
 <CAM0EoMmAs6N3xemJEcsKpG8OJZcxyB=U3nRa3vGwo+kbk8azfQ@mail.gmail.com> <CAM0EoMnJ7fjVKP+i8u9NpNZiPP8AQ-RdAbG14jUu8oMsBxhy_w@mail.gmail.com>
In-Reply-To: <CAM0EoMnJ7fjVKP+i8u9NpNZiPP8AQ-RdAbG14jUu8oMsBxhy_w@mail.gmail.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Sun, 31 May 2026 08:29:13 -0400
X-Gm-Features: AVHnY4LwfQHRm1QtZxZZ2XjIRBehSWXw3s0QUn5ZXuJe5TwVZBdEkPgMo8tqado
Message-ID: <CAM0EoM=CEJvaYi9fC-1BVTLaKjqbfiCNUeTKwEMEAuJytqy5kA@mail.gmail.com>
Subject: Re: [PATCH net v4 1/1] net/sched: fix pedit partial COW leading to
 page cache corruption
To: =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, jiri@resnulli.us, 
	victor@mojatatu.com, david.laight.linux@gmail.com, yimingqian591@gmail.com, 
	keenanat2000@gmail.com, 2045gemini@gmail.com, rollkingzzc@gmail.com, 
	dcaratti@redhat.com, security@kernel.org, linux-kernel@vger.kernel.org, 
	Rajat Gupta <rajat.gupta@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_DKIM_ALLOW(-0.20)[mojatatu.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[mojatatu.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-293405-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[mojatatu.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jhs@mojatatu.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,davemloft.net,google.com,kernel.org,redhat.com,resnulli.us,mojatatu.com,gmail.com,oss.qualcomm.com];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,mail.gmail.com:mid,mojatatu.com:email,mojatatu.com:dkim]
X-Rspamd-Queue-Id: 26476616101
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, May 31, 2026 at 5:58=E2=80=AFAM Jamal Hadi Salim <jhs@mojatatu.com>=
 wrote:
>
> "
>
> On Sat, May 30, 2026 at 12:15=E2=80=AFPM Jamal Hadi Salim <jhs@mojatatu.c=
om> wrote:
> >
> > On Sat, May 30, 2026 at 11:19=E2=80=AFAM Toke H=C3=B8iland-J=C3=B8rgens=
en <toke@redhat.com> wrote:
> > >
> > > Jamal Hadi Salim <jhs@mojatatu.com> writes:
> > >
>
> [..]
>
> > > Re-tested and LGTM. Let's hope this is the last one ;)
> > >
> >
> > Fingers crossed ;-> Let's see what our new overlords say tomorrow morni=
ng.
> >
>
> Sigh. Now both sashikos are complaining about the min() macro.
>
> Sashiko 1:
> =3D=3D=3D=3D=3D=3D=3D=3D=3D
>
>  + if (write_offset < 0) {
>  + if (skb_cow(skb, -write_offset))
>  + goto bad;
>  + if (write_offset + (int)sizeof(*ptr) > 0) {
>  + if (skb_ensure_writable(skb,
>  + min(skb->len,
>  +     write_offset + (int)sizeof(*ptr))))
>
> Could this min() macro trigger a build failure?
> skb->len is an unsigned int, but write_offset + (int)sizeof(*ptr) evaluat=
es
> to a signed int.
> The min() macro enforces strict type checking and usually triggers a stat=
ic
> assertion failure when mixing signed and unsigned variables.
> --------
>
> And Sashiko 2, on the same issue
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
> Will this build?  In the negative-offset arm the call is
> min(skb->len, write_offset + (int)sizeof(*ptr))
> skb->len is unsigned int and write_offset is a runtime int local, so
> the two arguments differ in signedness.  The min() macro in
> include/linux/minmax.h enforces signedness compatibility:
> #define __careful_cmp(op, x, y) \
> __cmp_once_check(op, x, y, ...)
> with
> BUILD_BUG_ON_MSG(!__types_ok(ux, uy), #op "(" #x ", " #y ") signedness er=
ror")
> __is_nonneg() relies on __builtin_constant_p(), which returns 0 for a
> runtime int such as write_offset, so the int side ends up signed-only
> while skb->len is unsigned-only and __types_ok() is 0.
> The matching positive-offset arm in the same hunk already uses
> skb_ensure_writable(skb, min_t(int, skb->len, write_len))
> and existing call sites such as those in net/core/skbuff.c and
> net/ipv4/tcp_output.c likewise use min_t(int, skb->len, ...).  Should
> the negative-offset arm use min_t(int, ...) for consistency and to
> avoid the signedness BUILD_BUG_ON?
> ------------
>
> So i looked at why this thing compiles despite the statements above...
> I could be wrong but I think the compiler optimizes away with -O2
> because under that if statement  "if (write_offset + (int)sizeof(*ptr)
> > 0)" IOW, the compiler already knows this is a positive outcome.
>
> David, this is what i had asked in the earlier discussion. It dos feel
> like it is safe as is,  I suppose given the compiler I am using but is
> it possible that older compilers may not do this optimization? It will
> also very likely fail at lower optimizations..
> Shall i restore to min_t()?

>
> David, I am going back to min_t.

That was definetely subliminal ;-> I am going to make another update.
David you can improve things after, I just want this thing to go in so
going back to min_t.

Although these changes should not affect functionality, to everyone
who tested and reviewed if you can go ahead and review/test.

cheers,
jamal

