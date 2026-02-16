Return-Path: <netdev+bounces-258941-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GG/iJzxfk2kr4AEAu9opvQ
	(envelope-from <netdev+bounces-258941-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 16 Feb 2026 19:17:32 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 199BC146F46
	for <lists+netdev@lfdr.de>; Mon, 16 Feb 2026 19:17:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AE45130185AC
	for <lists+netdev@lfdr.de>; Mon, 16 Feb 2026 18:17:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FB551C7012;
	Mon, 16 Feb 2026 18:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pg5w7+UL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 137E435949
	for <netdev@vger.kernel.org>; Mon, 16 Feb 2026 18:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771265820; cv=pass; b=boejEiF/DJdnHRZwjxpjP93/grJ4iZeHc9+zAsiXIfwyQ7gAl4vg/fl4sGFT1D2C9pGuzeuMZAwud9etU24MZD91w+4yxdWscd+OsFBBSAQqA8yB7fp53s9LLE9WVUZeSUE5M0S6nDwLgSymQIpgvKqJTsGNmng9WvlkU0zvLj4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771265820; c=relaxed/simple;
	bh=Uo4JNKiF2/A9aQO02FToRCjqDOgG61bwBbeyQGs+97I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d4BkPJsLQ3SznBjo0H6dFNwOpdvajMynuk0UK+CKR1pyqJZMa7/drMINhRtwF3Y47wePbp1WoVaosNdTKB/Mtv4vcla3fc27EgiXn6IPEqrLzOySHq8RF8MNKLIHNQtvZSZjuLb2rO74HKQ9TLHQ73q3J7S5MFhmERgMGy+mIkk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pg5w7+UL; arc=pass smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-506a7bbe9d0so26757811cf.0
        for <netdev@vger.kernel.org>; Mon, 16 Feb 2026 10:16:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771265818; cv=none;
        d=google.com; s=arc-20240605;
        b=D79tvnyRZOPnyqu9FAKdNn+Cf+fGkgfPqAuoeOoWgKVUzDJV8/ZCnYF3LHh3ByE4Vs
         f2qpzQKe74/znJM9TrEmNyup0XKymSAh/cA4A223bn7x78Pvpb7FGUKaETN8YUUCMWAX
         21H/ygsIHgofyQZgYgnr6m+dTrlfl4spIB5wRFXRbo2TLdLL8Q4NMzC+SC6rF/idmts4
         dImogpYDXGveneuvfx6everdv/iWWWQZj8Q4IJFm3ncwpHgPHv875NPKJdKeEdRrQ+Mz
         UZD/ni9aIKxci3d7gxX2TlU63iTyqYgGs83nKNvmSfzkSY/QM3WeX6lSw5UUvJF6PN9W
         J4WA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=I9yEWBPrKOblvd34VDWmHAD2jvVK0y+VhzSO4cxEb3g=;
        fh=KzakYQ6u0fult4nWXIwyudwK/uTroBScW+Vh8G4BMGM=;
        b=km6aB9ziTw+Mu/qHJf8N3xrz+jAfeu2rwwO4qKm1YAshOhcJBn/jDZ4jN1JBNhSmXv
         zoxqAi3q0dX0rY5HbTob/mcegsbzZdauKqd3P9s9sYPqz5V45dh5t25H4uNMygZLlKG7
         9kLerko2C4aBmvVGjuosPWnLPuePj5mOU6tXtxnOe4LlmP2xamtUf06rkMYYjs87a8zb
         76LMFH/4QP5bkcYta/NqhG/ryFFa19mElrX/t9qEux3Ej6OALZTSsInAeZ2w4BKsmP8h
         L855BlTM7yk8iPCglU6Hq6cs9/aOxtvFBcDepnVxRssR37h55FCXZKxBdJ8UhBZfTpzP
         c43Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771265818; x=1771870618; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I9yEWBPrKOblvd34VDWmHAD2jvVK0y+VhzSO4cxEb3g=;
        b=pg5w7+ULbI9+Z9//nLaGw4PzZB3gcyjF1NV5d+Orr/SjT+5lghvzg4kIPM0u/D+CpC
         ghTJ85qSUj5VCrp5gcLMos6w2r2v+OAUSrv0Rj2UT93tSkm2RyCkituaFpWDgrxKNmTj
         1VvJWv1zIRLZ/BOSfBlDYdOFG4mcG9J9RP3PITgqAxvFRGr1lNu/d8fQQsbPMLp/qzLL
         /jPoDVJcV8SpaPhy0dAwL9U60ZIaMR1F4JMmhZgnMP2h0ek0FlddT9gZNnaZYsvrQEvl
         zrehCNtW8u0Aa52VvDFkiie6UzIjN49NkaxsWZerYmTbymUkDAiMkF2u5nXPb81Yx7pH
         Sb7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771265818; x=1771870618;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=I9yEWBPrKOblvd34VDWmHAD2jvVK0y+VhzSO4cxEb3g=;
        b=alk/u2M9zt8Acj/TAKnR5UbNfRBqEyZbBK6NiN4lWmIFEkKfRIeC7kEcXsCIIry8gq
         xKMJwJYwFHRZSB+EY6W08Awzva0a2FHHW2Wt8BjRMK1G8QcMcAhg6uhVE/skfJCzEj/W
         8fvRgZgsx0SWfMNEUqcwK98nttVn/+z8L6AqjeC9jP6LhP9BNG1U2Ir3vtW1whahi4C1
         D6EPGglXNWOR17dg462x2bxo7ip5GHYX57ibn+SNssSbKi34spVTwXMl8oB4zn9xu76V
         0OyU53Qf8T3DRpjxUhMRmz+AXaAhI8NhyZFycIPbANGwpmb7ZR0K8eNOBFRhbEN07WYe
         LhbQ==
X-Forwarded-Encrypted: i=1; AJvYcCVEAyd/nswfjgnDOOiTaR8QISm1BrnePRI33Lwb5bXa1J6FpZpAorAqo+u4QO2dfc9hMNLeVGY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyY8pVXOvVZq2JDNqN3icwdAmMijv6A66miaQnj7XCbxrwUv5jq
	nsJyuouNY3VP1veomTLDymr/BspoQ4Az1+C5HV0RDn1+OiiHy5CHG/QUmeDMxh4SgP3Ag4gyp/7
	QIchuiGutC6tV2BHCVVd40eqhWBVG53FTH1Xm0HT0
X-Gm-Gg: AZuq6aII4OZY6F0+fj4rWjERUZ9/n6fZ1ofuRMBFUoubJdD8mO8LA2G514UTJ0RXk3/
	grb3yK2ZjXct9TteEMz300oqiMsbYocA5HbD8TC19SqnNBgYvnvQHGAyeuuBke93PymYeVACOHx
	zY6VfZHNlFa/Bv3YRByRFGPmG25x5ECucI+sokG5GYFxSgKk8fF8CPBdmoalB1nUv6qn9WLVvAM
	sp79aU1hh/QJITWodLfdkWj5uYOWor/y+RVot8hR1VH/dLzKjsB1bFAbxKiYFjFZQZXpk68nLQI
	ER3DRQ==
X-Received: by 2002:ac8:5715:0:b0:4f4:c104:9519 with SMTP id
 d75a77b69052e-506a8319083mr152419991cf.42.1771265817256; Mon, 16 Feb 2026
 10:16:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260117164255.785751-1-kuba@kernel.org> <CANn89iKmuoXJtw4WZ0MRZE3WE-a-VtfTiWamSzXX0dx8pUcRqg@mail.gmail.com>
 <20260117150346.72265ac3@kernel.org> <CANn89iJ8+5OaWS2VzJqo4QVN6VY9zJvrJfP0TGRGv85mj09kjA@mail.gmail.com>
 <20260119090435.44b1da2d@kernel.org> <20260129150459.29419003@kernel.org>
 <CANn89i+P86WVVUY-4WppUAH1TGix1Z3KhgX9vSHok5nXqQAiHQ@mail.gmail.com>
 <20260216094936.5bf9d789@kernel.org> <CANn89iL+kzhRqwBr5wAcEBMdC_wbLFanHJ6VxS1r5ppGKUhftA@mail.gmail.com>
 <20260216101108.6b2319b2@kernel.org>
In-Reply-To: <20260216101108.6b2319b2@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 16 Feb 2026 19:16:46 +0100
X-Gm-Features: AaiRm53p4l0QkjSg25AvVWQ9VhgOc973Fy1GRiwGgJxpQmK2v1WZn9St9avpXyY
Message-ID: <CANn89iLURfPA69TjXjdBJjbc+Ad8X8XO-fiDQp=Uc8J+0PU5JQ@mail.gmail.com>
Subject: Re: [PATCH net-next] tcp: try to defer / return acked skbs to
 originating CPU
To: Jakub Kicinski <kuba@kernel.org>
Cc: kuniyu@google.com, ncardwell@google.com, netdev@vger.kernel.org, 
	davem@davemloft.net, pabeni@redhat.com, andrew+netdev@lunn.ch, 
	horms@kernel.org
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
	TAGGED_FROM(0.00)[bounces-258941-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 199BC146F46
X-Rspamd-Action: no action

On Mon, Feb 16, 2026 at 7:11=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Mon, 16 Feb 2026 18:58:08 +0100 Eric Dumazet wrote:
> > > > I think I totally missed your email :/
> > > >
> > > > What about not attempting defer for zero copy skbs ?
> > > >
> > > > It turns out existing patch e20dfbad8aab ("net: fix napi_consume_sk=
b()
> > > > with alien skbs") is already a problem for zcopy.
> > >
> > > We definitely need either this or the timer patch I attached, for UDP=
.
> > >
> > > I put the TCP write side on a back burner because slab sheaves got
> > > merged, I think skb defer free will still make a difference but IDK
> > > how much. Maybe juice will no longer be worth the squeeze?
> >
> > It depends how many frags are attached to each skb.
> >
> > page frags are not yet handled by SLUB sheaves :)
>
> Ack, my recollection is that more of the cycles are spent in slab than
> pcp handling, tho. I could be misremembering. But my thinking was that
> if we both:
>  - lose zc sends due to the unbounded completion time
>  - lose the slab benefit due to sheaves
> we are only left with fairly narrow case of page handling of small skbs.
> My gut feeling was that however unclean the timer fix would be best
> since it gives us zc back. But I don't have a way to experiment with
> sheaves yet to get data. All of this is pure speculation.
>
> Regardless the patch you shared earlier is probably best as a fix for
> zero-copy UDP for now.

I am cooking a formal patch, but I do not see why UDP is a problem today ?

Definitely I am seeing problems with  e20dfbad8aab ("net: fix napi_consume_=
skb()
with alien skbs"), so was tempted to use it for the FIxes: tag.

This is the first time a TX skb would be potentially delayed.

UDP use of skb_attempt_defer_free() is  with RX skbs, and normally
their zcopy status has been cleared ?

Thanks !

