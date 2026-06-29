Return-Path: <netdev+bounces-302792-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id RgpvFSC9QmqMAQoAu9opvQ
	(envelope-from <netdev+bounces-302792-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 20:44:48 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id D23C96DE1F6
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 20:44:47 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=trailofbits.com header.s=google header.b=gjGSI5Q0;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302792-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-302792-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=trailofbits.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3934A300D37F
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 18:44:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B493B3D0BFB;
	Mon, 29 Jun 2026 18:44:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47A0C3B27D9
	for <netdev@vger.kernel.org>; Mon, 29 Jun 2026 18:44:42 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782758683; cv=pass; b=l0kgGNpEGglvxaVL9z130ySsJ6NPkKyk1SqnsND4p38j1uTZmNC9x7b8rQhobV+Swr/h1iPe15463irbtDAi5CX9WYmbq4em7jffF9ATnLi4Dk2Y79f9z462q8Ppc9o74eCA/nWuXJbBVBtzZBtQK1SX8iwrmVznvEiZqI+Lz1U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782758683; c=relaxed/simple;
	bh=Od9JhScxwqVpLsN3Iyre6FiJ55V11ZHFsfQKfHK/TAo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E45BU1v1SBuCSKx/EI0Snj57PbgvZfiZ1QE6F4xfdkQ/7TzGQPlzcNGOZvgUIP1FmZa/OhlY0aBkJ7oCx4A6UxwQuo07h6IT9VvI/eO+uXYCzQqJW6fTTffVSmno7R0EPNK9+O08tYwxtXviwRgTSbkZEEG4ToYqDeZGCq0+MZw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com; spf=pass smtp.mailfrom=trailofbits.com; dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b=gjGSI5Q0; arc=pass smtp.client-ip=209.85.167.44
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5aeae771c49so1780833e87.3
        for <netdev@vger.kernel.org>; Mon, 29 Jun 2026 11:44:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782758680; cv=none;
        d=google.com; s=arc-20260327;
        b=n7LWYy7MBMMwUGBBDTR/ejf9Zgo8yv4mtORN3JQDO//vI9PX/VjxpiVMQXhdziN5DR
         Uh2nLP1wjNCl0mOp80/sTMoSGw1gsmjoSIx8Fqukmz1afOdRX/dugbQivw/g7Z/o9MkG
         d6vXZoOncF85lFBgGes5qaTffUZN9b2zAvmtxnUVbnIXP/d1tCOl4Q+TnIoGrS+6PEqX
         pz8I6i39FcDkFwStSoecJ0OoW8BFvoJYsHgpMEUVBm9Uqb17NLQxwr81Z8C32D81npSo
         m1ZjJVVtM42HW+APlNnwLMtzL7PzYVfR/qlAgkikzJs7lShKVaStqeMf+d8UrOZW0NRh
         8mOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=h8GXVWaPeCuflzpz/fudyGnPI2CJbmSQwizJP5KijfQ=;
        fh=1CxIttprsN4knxoVxaRqdZOE1t+CdzkJ2nprAuANWK8=;
        b=jomEAndtgMHiBK7ibo2yg+FVOUoqbAxPfwpozhRMLwehm/JarGbvTGcOWBencMQf8w
         bTfr6hAxuPQQWZXOfoFYMBTKLOeoF2s5kU3CVpRl5w6eVtTG8Vifsi2fvL5Pp/GPY7Wd
         IcWI4SLJslLkcgwa+qkLG5a8ucrY4uZYztkASTvZEclUwKVEO6QdzdeMpnYdPLeulfRE
         WO4qV3wX5UPw1+U1u32XQQtCJYiOdIR9qhsJ8fuRALAGC8ZXu3rL3zMtExUH/4iuppey
         eZp3uIjw+MEiclmsHz8WhTKYhV9rKAyVSsbJ5iDmJbjfnp0vVIm8hN/4TrauPMC7NzYy
         R9wg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=trailofbits.com; s=google; t=1782758680; x=1783363480; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h8GXVWaPeCuflzpz/fudyGnPI2CJbmSQwizJP5KijfQ=;
        b=gjGSI5Q0GPgvWnYlH9e4J37sQmWfr/uBVK13q2uKeEBMPnqrVZiZz4iTkfn05ldoI/
         dEUvJBSlDjls/nVOhkM2KuUyit+ShU4FAlROy/hDXXRbkXAQ8x6wsQj4iPb+O7XPiNwl
         L1ua/Yf+IxRozkMjWNJaIHU8vFLVAaHLwI6jQE+h1sb0MCH1blFWqpjqhBQFgm1wZfb7
         o7zHdRsc5V/lXXYW1yx0RhNCxiLMjPtsmf4HSDuGx+mBCro/aM4+LRaJQ0GUu4j0wBRy
         zEMtlj+34BoTsQSIPfMjV0XJ91x/bJy4rJCtX33WJnCe/uwxqT0rK3nddWzM9rlFWFhy
         GFnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782758680; x=1783363480;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=h8GXVWaPeCuflzpz/fudyGnPI2CJbmSQwizJP5KijfQ=;
        b=dqPaTGAl60KCIn6W+P1DsUOQNIuAymku3iweF9PieElmbhz689nae8MJOGWpDWpUzH
         gCRny/0PE0/o8YWAIxZrUCPJ82MrRW+jkwQjZE6t4XoIaa9SxECAWhM0lajkwZgw49Ss
         sBfnDIBrZK/oxhn1CJsVwc0/n+oxejqgiV1XbMmlnpqyfk8swqp+s9MB1AsEhdVoiqSi
         sUqa7W3CNX3t/oTTbj9gJ1jjYEE1uVOxGHHeOtyS5lbM8HSaZtttkomi9Vb3BY3aVTdP
         dzBo+QBrSbXNw4WW/gkkUZypQ174tlqE2oh/ljyjY4RrIb0QLNlJYOD1F5cnGt02gFiC
         Kl7Q==
X-Forwarded-Encrypted: i=1; AHgh+Rrglvd8jxTsX2/iFN2g3CFIsiWPdG8mmEbGqNJVH0IWz58DR7JQgjRBAaWjVfyznR04cioxCHU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPD5mcVgXPfrjZUBTiIvRKN3ih3/z6zOX3kW/3/S6mPl4Jr+KO
	ujpBxnulPh/KhSF/M1oVTshqB4HD5H0FW96BHU2+U8Qg/xfa9OLeaQIj35Am+YghbTJ/aP9lhD+
	eDbqt0hrqTB72kCaJCDQH+BlrKIhhFV5UqrUp0JkaBQ==
X-Gm-Gg: AfdE7ck6YGuAYKmZDRgXVVYX0k8cmimptzokworBMmWywFx/UkCs1Ufoxdx3UkbsWdf
	7+X/sT9SLN8GoQx8Fw6141JxfSEvGaTQOcT02DOhxbZaJyNN5JfbHWLQyVFuMBmBssCX+ff3hCY
	JGbK9o33W2MVjqZECC+c7Oz0/GNwvJmAYQQruKx8NpNjG0AaqNBtDzuU1vQcoulXwd0tCu154mw
	+wPaH4p5+GAULLUaDT7S1XMXz6KorimKS8CRUGlq1iwogjFJbn0TwCvNI/mUnHSmCePJrc=
X-Received: by 2002:ac2:454e:0:b0:5ae:b019:af66 with SMTP id
 2adb3069b0e04-5aebdbb2550mr64975e87.39.1782758680559; Mon, 29 Jun 2026
 11:44:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260609232935.1602659.8545fdb04fbe.cake-overhead-underflow@trailofbits.com>
 <20260613142626.1b2183eb@kernel.org> <CAE+C+DZpYpJDJOaCK48KBpayXSYorFRSvTE903RBqyPyYkWcCg@mail.gmail.com>
In-Reply-To: <CAE+C+DZpYpJDJOaCK48KBpayXSYorFRSvTE903RBqyPyYkWcCg@mail.gmail.com>
From: Samuel Moelius <sam.moelius@trailofbits.com>
Date: Mon, 29 Jun 2026 14:44:28 -0400
X-Gm-Features: AVVi8CemPKN3BPaGiEa1_mcG3yW7cCKSdTjgFUbLx24prCZ6rrSJeilUHeOCVxY
Message-ID: <CAE+C+Da2-t1t76M6T9p=s6frGgOwj8LpOtVxBnmWa6kVHx9kpw@mail.gmail.com>
Subject: Re: [PATCH net v2] net/sched: cake: reject overhead values that
 underflow length
To: Jakub Kicinski <kuba@kernel.org>
Cc: =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@toke.dk>, 
	Jamal Hadi Salim <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	"moderated list:CAKE QDISC" <cake@lists.bufferbloat.net>, 
	"open list:TC subsystem" <netdev@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[trailofbits.com,reject];
	R_DKIM_ALLOW(-0.20)[trailofbits.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-302792-lists,netdev=lfdr.de];
	TO_DN_ALL(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[sam.moelius@trailofbits.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:kuba@kernel.org,m:toke@toke.dk,m:jhs@mojatatu.com,m:jiri@resnulli.us,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:horms@kernel.org,m:cake@lists.bufferbloat.net,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[trailofbits.com:+];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sam.moelius@trailofbits.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,mail.gmail.com:mid,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D23C96DE1F6

On Mon, Jun 29, 2026 at 1:24=E2=80=AFPM Samuel Moelius
<sam.moelius@trailofbits.com> wrote:
>
> On Sat, Jun 13, 2026 at 5:26=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> =
wrote:
> >
> > On Tue,  9 Jun 2026 23:29:36 +0000 Samuel Moelius wrote:
> > > +static const struct netlink_range_validation_signed cake_overhead_ra=
nge =3D {
> > > +     .min =3D -64,
> > > +     .max =3D 256,
> >
> > Both Sashiko's complain - these values are neither safe nor sufficient.
> >
> > How was the -64 chosen? It looks suspiciously close the min ethernet
> > frame length.
>
> That's how it was chosen. But as you've shown, it was not a good choice.
>
> I would like to submit a revised patch that does the check on the
> datapath, as you suggested. Should I send that patch? Or would you
> prefer to wait for a response from Toke?

Apologies. I just noticed Toke did reply. Should I send a patch
consistent with what he suggested?

