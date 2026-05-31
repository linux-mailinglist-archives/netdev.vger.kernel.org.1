Return-Path: <netdev+bounces-293485-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QAsCHB/HHGq6SQkAu9opvQ
	(envelope-from <netdev+bounces-293485-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 01:41:19 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B54406184FE
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 01:41:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6C721301AF77
	for <lists+netdev@lfdr.de>; Sun, 31 May 2026 23:41:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 391C03806B5;
	Sun, 31 May 2026 23:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NGDmDQl2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C59636F8E6
	for <netdev@vger.kernel.org>; Sun, 31 May 2026 23:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780270864; cv=pass; b=CsxuS2DxBr1CVa0Vd7UlS6Dv+rtujtbf48JYhvSuF8NJDF3Hw0rw0v/+tvu0ibXD7xkaX7CRZ+R4cSRtEPSDOSjua0Y1d34ujtrmCJKT0osxLd04dT9kwgG0TWnMMjC3g57XtGomQwQAT27z6Br1/vwCE/jFuQRPcF4V/OuDmC0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780270864; c=relaxed/simple;
	bh=AV3ARaOteMScWrHid/tvvUxL75OgNht8/SFK+Cms5yw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NC0Bnc2Gqzsf8/SVxCZeLGM9PkDSpWwaXOswYkTrerjHu/zuck0qxTeKL5U33tx+TuQVlOSBx5RAHEbKALwRTzEco9M4H4v5doF+QUHGsjFAcIRGWBzKSY+Zi0WI6Sb5s1QZH+dml+BTTrFbifymTbETHBw5nJRpRj39jadojdQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NGDmDQl2; arc=pass smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-bebac79fff8so100948866b.0
        for <netdev@vger.kernel.org>; Sun, 31 May 2026 16:41:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780270860; cv=none;
        d=google.com; s=arc-20240605;
        b=eUhYEMmzRBDgnhxY1fi8AgAAbgt4tCTwNcJmW769LsOGOYNBGBttCMilKihasC6r0g
         SozSjKPwsWHYu9aSU5O6v0lFeWwVN32x8Lh8dCRNyEw9mteBgfyuqrMoFt6ROqHLREQ9
         cmc94LMhtWC7ka3x5AIe9EhggR1UiwOZo7bVTM/uVPeS+5oQFJLMV3+0Q3yAO8M9lvvq
         aFDGcV6TfXvJ6xZKRGC19DJ40Ay6+a7CmxciacbvPjIW/GnXysZyj+rlG4Gn5p2E4RGG
         mBxgaSZLMldm6Ur2I71J/Wwx9NSQYE+3Szlu1p8c0bcjYpzpvP2XMfJUv/HYZ7OylmdJ
         N9ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xX8Opank1z1GKY0HdNCo2xf4uEvQT++yJKA98mdxaPw=;
        fh=9qs7J2ij9l1jwcrECCkxzrXUjTRTgACkgSN7OSp4xq4=;
        b=UbjSdKJpxSSe3wt15h+iR7unDu55bQ+4nRfhoBbgb6PtpsXcB7V0FbCir/75d9bkYb
         VRsirYY3VlRC0H83y4WmKFEbj2woj6WKXbPtVIFRzMQ1grqXwAKYqvE+YDAJWt1B+vzM
         em1nk8M2sh88tsjKg8zR5qu3ggKj2W4JerS5MbN/W4WPaYG87gnG6JVP2nQVtm1U5Z7+
         KS7APZxeS7b2iBO1EaUGz/2nBUDhG8OZZESEPxwtn3rLsgSUh6cRc/fhlV3pMOGcHMde
         kd7dJSENO/Rt9qxAPY7zgavpwgyo8MZ0hRyrcBAh4B+XUf/F040BVGZ41+1eCpGLr39o
         kRtw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780270860; x=1780875660; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xX8Opank1z1GKY0HdNCo2xf4uEvQT++yJKA98mdxaPw=;
        b=NGDmDQl2mqSxd2vlDfKdKnsi9HZTnyq/GfMYHTVcaZQMBWE5MGjZhwMuLrPsYbESba
         Egw8jofu/LlRhr6IB1fySLvze4eaSBLt9OmFatiz3B28RnCNR/BYxzw400wHjHkFG43R
         LBR8MF3yc/EJvahUVvuPzPrs6DspLIWTK1qtWhSOTVHcEpP5lJ49g8imQHcIS4OWWLl0
         kitgybagHUvPoqUGcF0Eu806/CX84xu0kkVtWQrM/4P2w+0uXX2kSdYywg3eUPX2Pqr7
         BmnGEFGeTsIzaqB793YnerO8rb0W53lfJ8/GxMvRImzaQLSRsJATkzaipmFgy4OJiJp/
         9Kew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780270860; x=1780875660;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xX8Opank1z1GKY0HdNCo2xf4uEvQT++yJKA98mdxaPw=;
        b=HCpaUk1EETb2MSxprn71eqco8rSiseAlFM8AkUoV0IyGHoAqTiupLO7VcPyYIIJOn0
         Q8c7KvXz68se6cBK2XAc++sit/dMTnWN8WrfgilY3PVFc4KujqnyvX8y7JYjjlNNWHEr
         IlXh7mNd9GR1kJlA4ZHVhQbCc0F0BFyZ7k15OOPISQRsKhbrTOtHnwkX6XPEiSPsh+Ct
         CJfrLgK/34CJ4ff0+JTzbZI5ZpZGtN4MXI1gP3RLA1IVmryUtLRL2yUE7nCqfKbUFvf7
         Gv5dEEqFkSyWGP6MayoELp+VrMjzE8s0C3gdpRZdpfgozH6hKpWsWh9hjqLxDAFljOeB
         Zk3Q==
X-Gm-Message-State: AOJu0Yw+JyK0W3eVJgbKcufF1bgbHM//n0yJ16grsbaEYcFHjXpyIfgW
	Lv30Xq0+uAR5fpMBAr2Ocg8eDmIqhAfJEqZGxxsJScFQYfHLg4HyNJtVEz5nqd8nWeshuAEGHrN
	+pTZ0arP4yhnzDN9WyAqCfS9A653p2RA=
X-Gm-Gg: Acq92OHdHAhY+JzG2JjYeGzowwAyQxV5JSWYBAS3/SeSbRjT7GpuMO7hROnbk2dAwy9
	SqB8EG3H0c+UZHFyYTfyX3XIi1+/V31SKN9u94kn+7ESU+BrdVNc+96OOPJHoToAsqYWDfUxwh1
	Mg5KBw57NuHm12r9C6Ba0GFV//8B/6abR4p7KUs3NFsB+CpPeiGo74E3ctHK+J5HX5PSiMdDt/W
	1prekAIK8TTQ6eHhk7s4wsKbEymL4M768X72eBggIWxtwPkKoRkM1Dg+yOdxEhWvXE10tqJAu97
	9qjbv0XxG4bZcrheughpihRUXXPgeLEkeyc3ouwmmVoraFXDzORnfWvS7iP4/2901kCW+wKO3G+
	c4KXCZUXqwkGNvnaHVSAcTREo4tx0sZuYti0fTHw+srHbbjMX/HvKWLe0wcA6oVZ7/qcm
X-Received: by 2002:a17:907:b02:b0:bed:441a:b26a with SMTP id
 a640c23a62f3a-bed442a0c05mr71646366b.20.1780270859764; Sun, 31 May 2026
 16:40:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260531022219.607001-1-rosenp@gmail.com> <9f01c5c2-873e-46ff-821d-3f36ab023555@lunn.ch>
 <CAKxU2N9U-OZd-1PYnRurXrC8e+VP3Ow=XCdQ9hMUG0CwN+NNLw@mail.gmail.com> <5c0f8926-0461-4cbe-b362-a23edd22bd61@lunn.ch>
In-Reply-To: <5c0f8926-0461-4cbe-b362-a23edd22bd61@lunn.ch>
From: Rosen Penev <rosenp@gmail.com>
Date: Sun, 31 May 2026 16:40:48 -0700
X-Gm-Features: AVHnY4IKRaLoTh9vEWv37RR8sEDLfCNBWJxeI7JzIp6upJ2RLeRBDfcAq_rIsG8
Message-ID: <CAKxU2N_RFhM3Tfct0mCs+1b-Q7hdZzh3T9gKWLmPAHRLqUGS-Q@mail.gmail.com>
Subject: Re: [PATCH net] net: ibm: emac: Fix NULL pointer dereference in emac_probe
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-293485-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rosenp@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com]
X-Rspamd-Queue-Id: B54406184FE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, May 31, 2026 at 4:06=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wrote:
>
> On Sun, May 31, 2026 at 01:52:04PM -0700, Rosen Penev wrote:
> > On Sun, May 31, 2026 at 7:39=E2=80=AFAM Andrew Lunn <andrew@lunn.ch> wr=
ote:
> > >
> > > On Sat, May 30, 2026 at 07:22:19PM -0700, Rosen Penev wrote:
> > > > Move devm_request_irq() after devm_platform_ioremap_resource() so t=
hat
> > > > dev->emacp is mapped before the interrupt handler can fire.  An ear=
ly
> > > > interrupt hitting emac_irq() would dereference the NULL dev->emacp =
and
> > > > crash.
> > >
> > > Please add an explanation how this can happen, given that iser is
> > > written in open() not probe().
> > https://sashiko.dev/#/patchset/20260517033621.1839397-1-rosenp%40gmail.=
com
> >
> > Also, does requesting the hardware interrupt before mapping the device =
I/O
> > registers create a NULL pointer dereference regression in emac_probe()?
> > The hardware interrupt is requested and enabled via devm_request_irq()
> > before the device I/O registers are mapped via
> > devm_platform_ioremap_resource().
> > If an interrupt is asserted early, emac_irq() will execute immediately =
and
> > attempt to read the ISR register by dereferencing dev->emacp. Since
> > dev->emacp is still NULL at this point, this would cause a kernel panic=
.
>
> You have still not explained how an interrupt could happen before the
> interrupts are enabled by writing to the iser in open(). I don't care
> too much what the AI says, i want a human to explain how this can
> happen. You have put your Signed-off-by: here, so it is down to you to
> explain your patch, even is AI told you to do this, and you blindly
> did it.
Beats me. When I did the devm conversions, I tested the hardware to
make sure it comes up and is usable. Various probe ordering tests were
not done.

FWIW, the AI is probably correct. How correct it is is beyond my pay grade.
>
> > Having devm_platform_ioremap_resource earlier
> > like this is more consistent with other drivers as well.
>
> So maybe this is a better thing to put in the commit message, rather
> than something you cannot actually explain?
Sure. Although this patch is targeted towards net, not net-next. Just
saying it's more consistent will get a flat out rejection.
>
>      Andrew

