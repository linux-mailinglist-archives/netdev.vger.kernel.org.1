Return-Path: <netdev+bounces-301795-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id s0nJD7ZYPGoDnAgAu9opvQ
	(envelope-from <netdev+bounces-301795-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 00:22:46 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id C59ED6C1BB3
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 00:22:45 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=JKj7yS1M;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301795-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-301795-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1BAE9301C2D9
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 22:22:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 481FB2F5474;
	Wed, 24 Jun 2026 22:22:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5943286415
	for <netdev@vger.kernel.org>; Wed, 24 Jun 2026 22:22:40 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782339762; cv=pass; b=Jm5TLDPyU8udkBgjSpRPUVPiqWe6HmlPTgk4EXPsR9th972j0OprEysj0CBucPp/lz8oFrSyNSzWT0wuQJ0O8L9a0SRzT82oSHYTNyJHLgz0G5d8guKMPSabw3GcIeA5xIO1l8rzRsMj5o/5ivUdfU5V2wjgbKstVDz9Ylfh0qY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782339762; c=relaxed/simple;
	bh=5VlpqCGU1q1I49q7nKHuT13zBfrNqDmjX6Vl4W3t8rw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Zn5yhhkhqRKKVAYnE1XP6yaBRC8YdsHGKtQRddFgIJXmOSYuJCD54BRoW0GyvITWSO0cLB9etn1yRxcfS2QKY9mU9+5Z3BnWYv9v7+n8xUYhCpJhU+yfzFAgRQBMww4hL+dqeFm/wyhSPGswc9BtOK27gshtbEJMRaPXYR5WY1c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JKj7yS1M; arc=pass smtp.client-ip=209.85.221.52
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-46cdcec58c2so151548f8f.1
        for <netdev@vger.kernel.org>; Wed, 24 Jun 2026 15:22:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782339759; cv=none;
        d=google.com; s=arc-20240605;
        b=C4wQ97yH/AXX7ZB4djUXKCYcZ20g4dAXp3AP7tgIFwmfVVw27IEcu1+2CRjWznHKzt
         P24VXlShHk7Bq+T9dpE+STRn9g1/eXyoekcgimpEk0v6fblK2w3bU9ubd30BRKOppKGI
         1eu6F1Sawxc/3u3R6pxxIROx7s+fkh90tkJ5w1A6kUV83cQ6UrQvBID6LxODbgS9XDjn
         xmmZsIioexaHehdwaPOXSNckNj5qsGCBl0Tyfz7HwTGBojKITtcZydWtE16lLc4CEHJB
         rOyxFo1AC/A79fx85YEEP/mefuOkBUkVCb2PE6sz5g72Rfvp88oRa+swNUJlVt8K5hLo
         AXAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=vuJl+Bg+2bV1wge+DbmfgL7AjZRt4WMMPEu+xxJXlSU=;
        fh=YUTz5FIFFh7C2Yp+6B0aLY9woBEZ1pV6jregA8FE3hE=;
        b=I0FXH8CLBzPqn5BT+hJPHKur/brF54n5JpOWocWOzqnYFVIV9aFcjSR89C9rSSI0pj
         sXmqwHAzX+HyrgJu/NM0jNvOzTROQF+teBGQirtyqfwIN9S/HzP9/CspPkMM8hivffV8
         3eAiIVpfy/yhRDaAVNLIV3e/tn04ZJtxlqn8N9OVvaeq+Hpesy3mlICgEBUglq2YFO1A
         +GudeKoFgtVqF3VcWK+YW0IyPOCrouNLSQAbhuWCrqcaryVZSWTO1k98ukd7udRLj6xH
         uJCD74ZLc7lsa1Bwj8AwjgHbAgPsYI81yb4k8xkIWKLZTXOXqqNoxCbmVez9AL6iNfXj
         nOAQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782339759; x=1782944559; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vuJl+Bg+2bV1wge+DbmfgL7AjZRt4WMMPEu+xxJXlSU=;
        b=JKj7yS1MWq5SnXx4qXLG+j5MbvwxK8Nd9H7q8lBnEtM6hfxtgCO/z+nfhJ3dZaSBW7
         RI1GBu+bDmK1cTq5dHW1iwC/o1Oeo2u8NEm2LhN2bqPkexyR5w8e047u1KPLd9ppXPrQ
         KxI2V1LeTjltpxAvGVqr09jNT4T2dleHS3qIQsq0dlmkjeBaqcCElE2QBDC9gheHeYNE
         XQz9kGR7YY3TG1W4F6J54rsMj+8JW+o3NFHKLYAo6vDB27nnqJR7b1oyQyisXzxeC8XK
         /CBR8ziql5+OI7he+6P3AMtbhK6fx8RWzJH+wlXNT6Bk2rJimPGOw+2BrasX3dyvDA45
         OYug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782339759; x=1782944559;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vuJl+Bg+2bV1wge+DbmfgL7AjZRt4WMMPEu+xxJXlSU=;
        b=prd0rl3Jxtjv2/1K3ag36Pgh0aW+mlkPGNLVhFh8x2S26y5JqZQKsT+JDhPrndD7j4
         5uqoqdw3C1Eep4fu66B4ODrJVKHfpDoIiSSEzcU1X57+/bQnzNF44VWmGTS2ciHb+9es
         m2eQ0CVtOzdQ95RA6jBVw/W3pJ4emW1Vj+dAWZsfHv2rNvhZ9Bw+4xVCYFwVdNmOWqhw
         kPDCS7J+8uLZiZMoaogt8m+BXAIr0uzOPmHi6FZix7kvSdiEmYwi/SKK+vZ40Rbn0yMk
         4JNgaRINImVM56HsKJRD2f6Hl3VSiOAMS0LtAfBl/EfNGAEGWgyduo86/FbgqB5oEHJ0
         5umw==
X-Forwarded-Encrypted: i=1; AHgh+RrUrtHIawG//QfjiZrvSMTaqLu+Aiawvk2xme6/3EM/R/NQQLDw/GIlkEFu43e0ddTGq61DT4Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDJo4+rLTd2gXvtKLxYBNBEsbfqSoj86Z6PGbhJ1ItijLX0yTT
	gK+DwK4wIAqwC3FyMKLCv0N7ewrwjr1IYtURTlsU2uhTdHInq8GRfzztlveFHRNB2DvgKGqR2Pk
	Bna/mnUnJyD2ht0azfbEI/ag1NxigpJI=
X-Gm-Gg: AfdE7ckTyoQtQMzy9hsoObRDmH7kxYFL9AQrD78FyxvUW8DHRHz47RJfVhMQtIfi0dm
	wmxd0ARklS7V7ROVlYqrOm4e+9YGMxKB3Aivi1zprcvsa9TUyruRRlCbpXOZiCNLlJJtaJkIkCQ
	JfBLjQkdZYEu8cpRLkl8uMU3pAmlgqI+jnMmMMilKi3zNWmhJFFWDm0L2TLa3MHQfcD098iQ/nu
	kWL7JMW6ZciHn/0qCbhXcYxjduonrtwEhxKGQPieK3QCpH53QVzG7ClaxOzE4a9GgyaBJc2JSTi
	PXxYTdcy1As70lmfDjSFvWEPn337nAl8oD67UQQxjuwEjLbOBnMqVg==
X-Received: by 2002:a05:6000:2488:b0:464:c5be:37fe with SMTP id
 ffacd0b85a97d-46d04d45829mr2957273f8f.15.1782339759159; Wed, 24 Jun 2026
 15:22:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260624200514.1332788-1-zinclim@meta.com> <0673af7d-51a6-484c-be38-3f46849ebb30@lunn.ch>
 <f2ecb668-ec56-4c84-ac97-474a2d761005@lunn.ch>
In-Reply-To: <f2ecb668-ec56-4c84-ac97-474a2d761005@lunn.ch>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Wed, 24 Jun 2026 15:22:01 -0700
X-Gm-Features: AVVi8Cc-lGFigjd_GNJEAb-CaiVR2AemzJb_22M2NOs-5hBez_OQRdMgtyJ7NRk
Message-ID: <CAKgT0UeU=8b6a3w6GA-0fB2bU12HsREZphchojoYW0h6wr8Qag@mail.gmail.com>
Subject: Re: [PATCH net] eth: fbnic: fix race between concurrent hwmon sensor reads
To: Andrew Lunn <andrew@lunn.ch>
Cc: Zinc Lim <limzhineng2@gmail.com>, Alexander Duyck <alexanderduyck@fb.com>, 
	Jakub Kicinski <kuba@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, kernel-team@meta.com, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, zinclim@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:andrew@lunn.ch,m:limzhineng2@gmail.com,m:alexanderduyck@fb.com,m:kuba@kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:kernel-team@meta.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:zinclim@meta.com,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-301795-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[alexanderduyck@gmail.com,netdev@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alexanderduyck@gmail.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[gmail.com,fb.com,kernel.org,lunn.ch,davemloft.net,google.com,redhat.com,meta.com,vger.kernel.org];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,lunn.ch:email,vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C59ED6C1BB3

On Wed, Jun 24, 2026 at 2:56=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wrote:
>
> On Wed, Jun 24, 2026 at 11:51:29PM +0200, Andrew Lunn wrote:
> > On Wed, Jun 24, 2026 at 01:05:14PM -0700, Zinc Lim wrote:
> > > From: Zinc Lim <limzhineng2@gmail.com>
> > >
> > > Reading an hwmon sensor
> >
> > Since this is a hwmon related patch, it is a good idea to Cc: the
> > hwmon Maintainer.
> >
> > I don't know hwmon too well, i've never had to look at locking, but...
> >
> > static int hwmon_thermal_get_temp(struct thermal_zone_device *tz, int *=
temp)
> > {
> >       struct hwmon_thermal_data *tdata =3D thermal_zone_device_priv(tz)=
;
> >       struct hwmon_device *hwdev =3D to_hwmon_device(tdata->dev);
> >       int ret;
> >       long t;
> >
> >       guard(mutex)(&hwdev->lock);
> >
> >       ret =3D hwdev->chip->ops->read(tdata->dev, hwmon_temp, hwmon_temp=
_input,
> >                                    tdata->index, &t);
> >
> > Could you explain why this lock in the hwmon core is not sufficient?
> > It could be i'm reading it wrong, but it looks like the lock is shared
> > by all hwmon instanced registered by a
> > hwmon_device_register_with_info() call.
>
> Documentation/hwmon/hwmon-kernel-api.rst
>
> When using ``[devm_]hwmon_device_register_with_info()`` to register the
> hardware monitoring device, accesses using the associated access function=
s
> are serialised by the hardware monitoring core. If a driver needs locking
> for other functions such as interrupt handlers or for attributes which ar=
e
> fully implemented in the driver, hwmon_lock() and hwmon_unlock() can be u=
sed
> to ensure that calls to those functions are serialized.

I did some digging and it looks like 3ad2a7b9b15d ("hwmon: Serialize
accesses in hwmon core") landed into 6.18. This was a patch put
together based on issues reported in an earlier kernel version and
explains how this got missed. So what we have is a redundant fix. We
can drop this for upstream and probably look at pulling the upstream
fix into our kernels that were having the issues.

Thanks for the review feedback.

- Alex

