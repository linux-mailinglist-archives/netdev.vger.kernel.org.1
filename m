Return-Path: <netdev+bounces-281556-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qN25OJr472mFMwEAu9opvQ
	(envelope-from <netdev+bounces-281556-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 02:00:26 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D77347C06C
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 02:00:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BD3FD3008277
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 00:00:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B64C2DF6E6;
	Tue, 28 Apr 2026 00:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m+rcZ5O4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1A8E3C1F
	for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 00:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777334423; cv=pass; b=t9j9KlqV5fmisyF5kSyCUDaGXHQythluRJZXHZK0GwzoK8/GI5qIbrdHQ2DqA0RQA0yPTFWxG6s8djKVVTHk8CVYdZR1iF4a0D/YrQp4bFbRC4VKvFnQKHmGb2Q+m96SNf4ibnAr832LN/DwUXiKqsRmwugju6W60dlqJy7r/JQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777334423; c=relaxed/simple;
	bh=kY8ajUarq8aP3iReXTwYvnLU3kEyZk0lXPgo6J91jK8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iKoG+la/oMd4ssYt/hBiElpeS+TvjFbmpkqC10ScVr8geuYW/1k7mU3ZJpZVqrmhm29gyJg7Vc+vM3ahp2EyxyLjAgkgueH1QheijuAj3jLeLxSljNONPESc7Hx/5hLnJupxN4wacCkpRhmm2QZbRYQ3uL0zCcgRxiGttS79qzA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m+rcZ5O4; arc=pass smtp.client-ip=74.125.82.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-2dedf5f88adso5134875eec.1
        for <netdev@vger.kernel.org>; Mon, 27 Apr 2026 17:00:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777334422; cv=none;
        d=google.com; s=arc-20240605;
        b=Y4Bx3CvHo2ADeEN5HyufIKAOKLkV0TO8bA5svhK0yfDcgm1a9IfUDsADTVitR1UMIi
         VHBBdGXvLoZXFw2Gl+kdF1xVD+BehHeUSaPYZQ/38rr3iA17ErKGk/sND8roRNtXvdyL
         UAvVpp6u2UbKAwuhINaeZWXfnbpZ+3MFlxo2Fpm3895j4PPn6C7k1cYggRcbTsq1dyYX
         BaZSGVpUSo03N3hmRqmUxZ8AoQcp2bsy22L7bQKh0Mqyw7ErhHmN+kEPkbrSgaQhQsiZ
         iBM93a9E9SrVPcRQhVF4n3WmrJ9dhkKw/8Ws/RqNh+pBISyIqRLqOP2GpSYkfX8ZYwzR
         F6vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=KoA5YJGTIVDehubXJpZZlLbfoOKtW7Qf8V5dW+bI5v4=;
        fh=3S8fZFyz4ycAcssAS5dfAFJeGO3P6V90q3DOy9QCbC0=;
        b=PNeTichVvtpk2W9ysnSdFqh0qDPJWkkgyTXkwa/JUzV45Pph0Lwj5h+Z8DITEJbi6j
         Iljae0NB69QARTAQK2d1y6UDvZBfD6RIYWVIEAmYZOQhjuTV7L6GnkR281l3jsHSOkix
         5FdO9wZusY1LMXgV6tZ3n0AOBJbQCgNlzMFdNvy2RlU7l7t7nfqj8oi6XJWlocV5OI1D
         mdMkN6+cbgDaJvKb7kx7C0azr0E2rFZK2Zlyihf5/xPDCCL+pnPg+xKI04BQ933hztwK
         PqdAZ3haUp4RLPn2j26L95v8pX2VqUhKO2Mmg6gxD4Iidd9lcjNaMdJARcPfdY5Bz9F+
         ASKw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777334422; x=1777939222; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=KoA5YJGTIVDehubXJpZZlLbfoOKtW7Qf8V5dW+bI5v4=;
        b=m+rcZ5O4KbcWZPRJUTNeJ0AV1+pdOQzd+G+xruBRJUsbqKkhG4SXB/J5PsVlnv7C79
         kTE32h1GLvdr8bblvwYGlDfOAWT5M6VS/BumjWleQryxRFUHf78HY24bgPRcUdPCtHBi
         SO1ksW2Q4U9vafCBtH0m7QKTkwQP6N9h2TPpiQe1GHiRdwtE7LNwrxokm79SZusBTlko
         I2zq8JtrJQ7e+N799mvUSxZpoxw72ku6ox4sHYIe5xHedCYVf+equjwuzuPMbjprdQ5k
         OUAUvhh881/6Tj/6ivxAhMTThpTQ0rKpYPV4dZRcZGI3gYr45BsldyFsMSuZSRDTB9Ef
         hWKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777334422; x=1777939222;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KoA5YJGTIVDehubXJpZZlLbfoOKtW7Qf8V5dW+bI5v4=;
        b=pYqyAgSn3An53Kc53sXu7Ifqs856WDlO1S83Kg9cQ1SFqr730Lyffl1F0kVKXESEqZ
         axqIPAqeEVGp7VWifZm4tndgpqZjXbiAIgIB33gUJNobE6mJz7CO4Gk8qgI1rpCAkn1w
         gMyw8q0vHplABRmVEV3pT5PlTsmz2ZvG4MsqChuxM+ZxCVxHosXgZng4W0rFYjIj2Phf
         sr3SfIWZd72vx3Q7KyBRkR8L9+AeZmQ0LH9ni9curH2LE4VGY63K+M0fFQhunU0FGZBT
         hIT3wwwYF3ZSAxsU5KnUuoy+Z+fXDC/DWsm+xDbwgQy5ngzp5WwPkXkjH32hGGkL0rS5
         XTUA==
X-Forwarded-Encrypted: i=1; AFNElJ+BqbnaIcVcuIeBhM2nGYVfVARPsqnTFB+Qjz7AcyMyUt5cJfyC5S+Kya8luZ8fPEphXuQwJGk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyz05q9Ur7GxrjTEc99z49conwe9jmnv/e6QVyTIQxVduX/lSSI
	Y9PanS/uKuSk7KWRnxyhaytMaIHuAUTXtxAQOJnjH+F7YaW+ax2KXEBGdkzPMnvCxQyJP51rJQs
	OxurLQwboIouTPkV0l7IW+CZQllO7CAw=
X-Gm-Gg: AeBDies4DXPMksBrZF6vDviBeOULq6dAvD6DlfqfpJGgj8h5mt7OtKKwGbnM2ve58NT
	vHz49WwgMgf/S60pjzm6vGimxLOtA5RbS9XYIDkx6ojJjBhWGKEpDBCdY2q33GVWTg9sAyfuY53
	LviKPTrKch2NTJQF21baPhjZRWtzsHu2z7wVSeFe3B8rwy7LnSjSHls/9jsN+9GuWuJGkXOfvHd
	TaWJSGBaSRNnkzc5MxoXt0dvkjlHDjdJ9Mlohg8nxgoVx1j8O6zx7sZhf7sdOK7EhqPd+V5M2iw
	H/rv/dOM5wcqD31rJmyP5VXE7qbcMt8x/hcXEiTvZ71F2AHhwJ3GuEkHkihOVytqCOQ3BuctRm6
	C8XQV9OZuokxzJwq6F/xulfOb17RFUZg=
X-Received: by 2002:a05:7301:3fa6:b0:2d9:db50:c6ce with SMTP id
 5a478bee46e88-2ed0e2e56a6mr29805eec.3.1777334421260; Mon, 27 Apr 2026
 17:00:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260427172727.9310-1-ebiggers@kernel.org> <CAJwJo6Z9oJSMMBUL_pbYWN6ha3n4MRpKV_aVut8E+af3JUDFkw@mail.gmail.com>
 <20260427155538.2e1b8488@kernel.org>
In-Reply-To: <20260427155538.2e1b8488@kernel.org>
From: Dmitry Safonov <0x7f454c46@gmail.com>
Date: Tue, 28 Apr 2026 01:00:10 +0100
X-Gm-Features: AVHnY4IU52sIs7A9BJsD-ykwxp7flhe6McSxaUZIV17UJdFUfYdDqRdscJZ2HIk
Message-ID: <CAJwJo6Zh_1V009JSBGwAmR7GWj=2HdG6f=uBxK8krE4B1YrGkA@mail.gmail.com>
Subject: Re: [PATCH net-next v2 0/5] Reimplement TCP-AO using crypto library
To: Jakub Kicinski <kuba@kernel.org>
Cc: Eric Biggers <ebiggers@kernel.org>, netdev@vger.kernel.org, 
	linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Eric Dumazet <edumazet@google.com>, Neal Cardwell <ncardwell@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, "David S . Miller" <davem@davemloft.net>, 
	David Ahern <dsahern@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Ard Biesheuvel <ardb@kernel.org>, "Jason A . Donenfeld" <Jason@zx2c4.com>, 
	Herbert Xu <herbert@gondor.apana.org.au>, Dmitry Safonov <dima@arista.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 7D77347C06C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-281556-lists,netdev=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[0x7f454c46@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,mail.gmail.com:mid]

On Mon, 27 Apr 2026 at 23:55, Jakub Kicinski <kuba@kernel.org> wrote:
>
> On Mon, 27 Apr 2026 20:09:05 +0100 Dmitry Safonov wrote:
> > I do like these numbers quite much! Yet, as I mentioned in version 1,
> > removing a fallback for other algorithms' support does not sound good
> > to me. There are two reasons:
> > - Ronald P. Bonica (the original RFC5925 author), together with Tony
> > Li do have an active RFC draft to support the additional algorithms
> > [1], potentially in addition to TCP Extended Options [2]
> > - There is at least one open-source BGP implementation (BIRD) that
> > allows using the algorithms that you are removing [3]. Without a
> > deprecation period and communication with at least known open source
> > users, it implies intentionally breaking them, which I can't agree
> > with.
> >
> > I don't feel like Naking as we don't have any customers using anything
> > other than the 3 algorithms above (and BGP implementation is
> > [unfortunately] closed-source, so that would not feel appropriate even
> > if we had such customers), yet I do feel like it's worth and
> > appropriate to express my thoughts/concerns.
>
> What do you want to happen? You are the maintainer of this code,
> you don't get so say "i don't want to nack it but also no" :)

Yeah, that's not what I meant. I see value in Eric's contribution, and
I like getting rid of tcp-sigpool. So, anything but "nack" is not "no"
:-)

> Like Eric says if there are no real users code can be deleted.
> Adding deprecation warnings upstream is quite slow, IDK if injecting
> deprecation warnings to stable has been discussed..

FWIW, I've written to bird's mailing list inviting them to this
thread; in case if they need other algorithms to be supported,
hopefully that should avoid any breakages on their side.
I'm aware that ciena and fortinet use tcp-ao too, but I'm less
concerned, as they aren't open source.

Thanks,
             Dmitry

