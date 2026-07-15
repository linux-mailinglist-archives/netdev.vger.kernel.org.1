Return-Path: <netdev+bounces-307694-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 9ro1IK09V2rcHwEAu9opvQ
	(envelope-from <netdev+bounces-307694-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 15 Jul 2026 09:58:37 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 664F075BAB3
	for <lists+netdev@lfdr.de>; Wed, 15 Jul 2026 09:58:36 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=S5VZ30UP;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307694-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-307694-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 432A2301C3FA
	for <lists+netdev@lfdr.de>; Wed, 15 Jul 2026 07:58:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C81E3C7E16;
	Wed, 15 Jul 2026 07:58:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed2-f1.google.com (mail-ed2-f1.google.com [74.125.228.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 951CF3C65F0
	for <netdev@vger.kernel.org>; Wed, 15 Jul 2026 07:58:00 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784102282; cv=pass; b=aK5cPZUgprGTtc6CmgcWuq8JIRN1Te/xuRjZe7CGcYCDnhWqMw/qfcAvWudDrWZo/IcuhastkEGk31KpN9SIKm2uoGuP3vV3czuESqaaEjhjOMAa42WQvO0S1yuC2X9V5vnNserfQqbZjnKDoNoN1+Ei5q5m4tmfe+Vyl8r6PrQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784102282; c=relaxed/simple;
	bh=4EV96JQm9dcVbfWRPQAuM7LuZkxzfemPOuDAZdxRrMw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LmmEg2YmN/doRtXlmwSlIU+92XlzRKPUaALMj/lGbVQDg3bIHbpQ82okctX1+7k2Qx32ZocnFwbSQoc3M/5ZJsSohIgbAfvvzCm8XOJ6Tq5tFYd87bKFdCWMc63COwNVtcAhHqznS/gmihliDpTtR3Zn3Vb4gadBEz7PldZTceA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S5VZ30UP; arc=pass smtp.client-ip=74.125.228.65
Received: by mail-ed2-f1.google.com with SMTP id 4fb4d7f45d1cf-69850336c9cso647900a12.1
        for <netdev@vger.kernel.org>; Wed, 15 Jul 2026 00:58:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784102279; cv=none;
        d=google.com; s=arc-20260327;
        b=Q63PeLSwOFCCbUI6vzJpjvseimsGYWnQK+zHTAG5ZotRzY8dFzoFy//pifwaN80bIc
         QCmTrhqagFjjSN/w5/0p0x7zZURZMvLwsyylNe8lkqO/sJWUCG7+bnCx7m4s5SwINAvb
         zYKCPzFQ7mFYeXf6lcVlhLiWulumT3WOesUIof5GVjoR1zLXgT8N5Mtvvgt24rDUS7SL
         /EygaJlK18QW37uT32Ue0dSm/V9oy4Hz9295h0lkh2B24e3HNRgyCtzrilIyrePL0c53
         Fc6pYw2W1OMqKuE0tqyz3dtmCW9uAMeCoLB8J2HjrYKLEI5lsYKhaZ2pQ2++j0CJxMAo
         ZnNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=wJj9Wc7Rwy3gTAMQK9yQ4wfZtHEgVyepO/YIt/wDURE=;
        fh=hTQ2OUg1vhUXWKPLts8W2UrOxRGQaLNmjouA25l1Mvs=;
        b=c+/FnrIY/813qJt5RLQfvnzLMFX0CeJOKYqqNVVbSH1o4EjN3Efa9gCwH82sF+bfWi
         K9f87hQE8anBDBf4YydnpMbokTWue0mtDF8Ah+lvM445Jg1m09tCaUUTtgkHEJ9P7HRR
         zHEexyNU0ZoDtN45+lsK6TfKHfUxpsWQwD9apVsrqg1eM0xxthb7LCYabHx5kuxe2rVX
         6VaPqPLIHDnKk9X6fBD92cOhuC1fxcVf5uizPTKzGX8+eUFeK7TlGurEpPTckoO9PZ/9
         e5ndCQFT2pWFhb4bpsbMZhFZyGTa/MzoCpkVt4PZ+ZGY8PJTm1Ezste06PG5GjvbA9b4
         L9NA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784102279; x=1784707079; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=wJj9Wc7Rwy3gTAMQK9yQ4wfZtHEgVyepO/YIt/wDURE=;
        b=S5VZ30UPxaQOYzUrF3XdoqpygIlSrwBPpYFNpJMZnpITfpEW/J5pSNZkmY670sMQ0F
         Yu+hxWsPMwnXklkamy7Cu7nZwKvOoTkJQo+k0BFn7i3HMoYrFqhfhXoUnFms5Ago141C
         HT7CL2baNN4o1xHMTgbEfCNdy9jbC+H+RZsodCqmxP9ED65um8AP/JX8YqZVZeCsYJHM
         6zblf2fG//PqTFOwBoBnFiq1zrre8SGhU51mYzXWuUg4egpSvidTTIY36YLaaYFZMiBo
         wDdsod+SkbPqSQlk7E0h/S8JJw/+kF48AddhTsGfWJPaDcU1HJn7uzMOtasaKKsbLXAQ
         gUcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784102279; x=1784707079;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wJj9Wc7Rwy3gTAMQK9yQ4wfZtHEgVyepO/YIt/wDURE=;
        b=DmLEjnfpiOeLQlKdLzNWHtG+A2BJMd6EdR0Ia3nuL4ylMIhHk02OSe52v1g0EnbjrH
         8kl6kMdIxe7NJPOgLbWKldH+EOEaFOf80rTyD9XmJWFGCI6sjNzwXjn6+FV8UfnXXl/W
         Qxi+8xjdDny4K3L/094JUOR4UNz72uvzFaTKNCn/Rt22laRuUDujkInVlR0Ro9GnTlZX
         vhv4HT9cNiXMfnQtyfN6m5raxhJFel/+uEgOPFokC6EOWEXq6nMeyqySb+/t/cTZQX8y
         7Up3AW5vVdUJ8nw5E+C7JEEB125h6FxiLgj8P1tz6cpJIQRZvA1fMHGL5dXOYDD16pt2
         BMlQ==
X-Forwarded-Encrypted: i=1; AHgh+RqXVGRnNTYzfla3ulUVVyPfdGqm203Fuiu8BSBbIM5cjEFED2CZv26uKtbh6FWjk/Fl01B7ZmU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsNBFqR31vQZHRDkpJVjxJrXTEWXfyiij4aih3NsCzBSUD9pjs
	mt8plrjLrl71RE8FevgHaa4NHardODMnzoj1vsdvHaVs91B2sA2Y2HRJcfNwBSrKZRnQVVgl4V8
	A3AVpvMbcJpZZxwiBvXwWVd3JmRfEAiE=
X-Gm-Gg: AfdE7cmCaf5maSBcXOlBxKotnh+2mzaD9Rl898duEvUdR059GvNCPnvJ+VxjXKTg8WO
	t7ex7JqylerSO9t8FIMRLI3DRmQO/KdE+HAyNTRKzRNuHQ8cqkjP70dijN/NKcX+nwF/PtNpR8M
	qcONpw9+R9d8WoQv1Xm3iIhcOZBXHUlvrPm5Jq6fcURbt6swK2tdEFrrOOO87+XMumM00ooNLfX
	5jRjLyd8zPN1JmGtXqz/Otocb7usZkbn0r8VR+4rLSV7EZX4xU383wd2N5IAkhbQL5iOt7Mf/4F
	UpejCCKc3Gg5KM1CJ6mdCw==
X-Received: by 2002:a17:906:9fce:b0:c16:11b2:ae9b with SMTP id
 a640c23a62f3a-c161e98c3ecmr826018266b.17.1784102278649; Wed, 15 Jul 2026
 00:57:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260714191341.690906-1-coiaprant@gmail.com> <20260714191341.690906-8-coiaprant@gmail.com>
 <4823c1d9-51d9-45fa-a96c-f2caab1cb29e@bootlin.com>
In-Reply-To: <4823c1d9-51d9-45fa-a96c-f2caab1cb29e@bootlin.com>
From: Coia Prant <coiaprant@gmail.com>
Date: Wed, 15 Jul 2026 15:57:47 +0800
X-Gm-Features: AUfX_mz1XbF_hj8SltUaP6VQCiYz735WcPjxUivwpVyatqEOGiO47eZKOAvcnaA
Message-ID: <CALj3r0h4cFd-tp9-UVxihL9-a1W7_4nvnKoXW_cP5WECKc66Hw@mail.gmail.com>
Subject: Re: [RFC PATCH 07/10] net: pcs: xpcs: add Rockchip RK3568 platform
 glue driver
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: kuba@kernel.org, davem@davemloft.net, edumazet@google.com, 
	pabeni@redhat.com, andrew+netdev@lunn.ch, robh@kernel.org, krzk+dt@kernel.org, 
	heiko@sntech.de, netdev@vger.kernel.org, linux-rockchip@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-phy@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:maxime.chevallier@bootlin.com,m:kuba@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:robh@kernel.org,m:krzk+dt@kernel.org,m:heiko@sntech.de,m:netdev@vger.kernel.org,m:linux-rockchip@lists.infradead.org,m:devicetree@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-phy@lists.infradead.org,m:andrew@lunn.ch,m:krzk@kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-307694-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[coiaprant@gmail.com,netdev@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[coiaprant@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev,dt];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,mail.gmail.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,radxa.com:url,bootlin.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 664F075BAB3

Maxime Chevallier <maxime.chevallier@bootlin.com> =E4=BA=8E2026=E5=B9=B47=
=E6=9C=8815=E6=97=A5=E5=91=A8=E4=B8=89 15:43=E5=86=99=E9=81=93=EF=BC=9A
>
> Hi,
>
> On 7/14/26 21:08, Coia Prant wrote:
> > The RK3568 SoC integrates a Synopsys DesignWare XPCS that is accessed
> > via APB3 memory-mapped registers.
> > This driver provides the glue logic to make the XPCS accessible to
> > the generic pcs-xpcs core.
> >
> > The XPCS block contains four MII ports (0..3), each of which can be
> > routed to GMAC0 or GMAC1 via the pcs-handle property in the MAC node.
> > The hardware maps these ports to different MMDs:
> >   - port 0: MMD 7 (ROCKCHIP_MMD_MII)
> >   - port 1: MMD 2 (ROCKCHIP_MMD_MII1)
> >   - port 2: MMD 3 (ROCKCHIP_MMD_MII2)
> >   - port 3: MMD 4 (ROCKCHIP_MMD_MII3)
> >
> > This driver creates a virtual MDIO bus that translates MDIO operations
> > to APB3 register accesses, with proper address remapping for each port.
> > The generic xpcs driver then creates a phylink_pcs instance on top of
> > this bus, allowing the MAC to use the PCS via the standard phylink API.
> >
> > Link: https://dl.radxa.com/rock3/docs/hw/datasheet/Rockchip%20RK3568%20=
TRM%20Part2%20V1.1-20210301.pdf (Page 2078)
> > Signed-off-by: Coia Prant <coiaprant@gmail.com>
>
> [...]
>
> > +static int xpcs_rk_probe(struct platform_device *pdev)
> > +{
> > +     struct dw_xpcs_rk *pxpcs;
> > +     int ret;
> > +
> > +     pxpcs =3D xpcs_rk_create_data(pdev);
> > +     if (IS_ERR(pxpcs))
> > +             return PTR_ERR(pxpcs);
> > +
> > +     /*
> > +      * The XPCS may be attached to a power domain (e.g. PD_PIPE). The=
 domain
> > +      * must be powered on before any register access, otherwise the S=
oC will
> > +      * trigger a synchronous external abort (SError).
> > +      *
> > +      * Accessing the XPCS registers also requires a TX clock from the=
 SerDes,
> > +      * which is needed for the soft reset.
> > +      */
> > +     ret =3D xpcs_rk_serdes_phy_init(pxpcs);
> > +     if (ret)
> > +             return ret;
> > +
> > +     ret =3D xpcs_rk_serdes_phy_poweron(pxpcs);
> > +     if (ret)
> > +             return ret;
> >
> There are 2 unusual things here.
>
> The first one is that you manage the serdes phy from the PCS driver, usua=
lly it's
> the MAC driver doing so. In stmmac, we have the serdes_poweron and serdes=
_poweroff
> callbacks to hook into for Serdes control.
>
> The second thing is that you're setting the serdes ON at probe time, ther=
e's no
> dynamic control of it. Usually we try to only power this on at admin-up t=
ime.
>
> Can you explain the rationale behind controlling the serdes here directly=
, and not
> from the MAC driver ? I don't see any mention of that in the commit log, =
and I'm not
> convinced this is the correct approach.
>
> Maxime

Hi Maxime,

Thanks for the review.

This is intentional. The SerDes is attached to the XPCS node because
on RK3568, a single SerDes serves all four XPCS MII ports in QSGMII
mode. If we managed it from dwmac-rk, we would need complex
refcounting across multiple MAC instances. Keeping it at the XPCS
level simplifies the design and prepares for future QSGMII support.

The probe-time power-on is a one-time initialization (mode selection),
not a runtime power toggle. The actual power is controlled by the
PD_PIPE domain via PM runtime. Also, phy_power_on() on this PHY is
effectively a no-op; only phy_init() is required.

I considered the stmmac serdes_poweron/serdes_poweroff callbacks, but
they do not handle shared SerDes well. I am happy to rework if the
community prefers otherwise, but this approach seems cleaner for
multi-port setups.

Thanks,
Coia

