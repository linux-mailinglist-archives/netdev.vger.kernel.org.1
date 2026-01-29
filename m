Return-Path: <netdev+bounces-254811-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uKoELzxle2l2EQIAu9opvQ
	(envelope-from <netdev+bounces-254811-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 14:48:44 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F758B090A
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 14:48:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4F9093017277
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 13:46:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B72AE305E3B;
	Thu, 29 Jan 2026 13:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="C87cdl59"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADC06242D60
	for <netdev@vger.kernel.org>; Thu, 29 Jan 2026 13:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769694374; cv=pass; b=G/ObxwjWI/kRc5KOZqAEL/AfU6Y2KIEf8A0GGI6DJnp9D6NaJVaVmqZY7bwCiWS64NnyodvzuFhrw2Hcs+T/ALQ7LEQ3JQHI84au8z3YNHhltN+Ed0P4OS8utGvi616x1pcvjob6rX5m3ccESv6FAmwjUJaeGHrbmy1PdbF1lGI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769694374; c=relaxed/simple;
	bh=FVF7JxhMSZ+jyL1X5JPYnMI8hKnMPd92PJE21AQ0fd8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ivHCXLAfsEeJn0TD9bwe9iuqXYmcVq5WlitU70GwQINMvPaffckQR6YZlyiqVsf3nqLHS2f7V5obvqYuzybGeUy1CjcXQbkFFOmrpKgZ4cOPFoD7lMx+yeRYe/7HfOkPx+sdg7C7HgIeP4WcXHCY5QBWd1ypqxHcNO+YPuqd1/0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=C87cdl59; arc=pass smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-658cb3ee91aso1692338a12.0
        for <netdev@vger.kernel.org>; Thu, 29 Jan 2026 05:46:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769694371; cv=none;
        d=google.com; s=arc-20240605;
        b=GKk5hZH1GOiKk+cCPSMRWKf7g3T9jyVJvUGPpDeOmkrx92cw6ZLn8b3p3ucWU4UY7L
         DchUecCeTaty+oxOtS1dttldDoaavPZXjZq6X7OdNkzsivPwc0PLuAfgm67k5+9NS7DP
         DqrfOmW1hAx3nDs48bO1UwlpifTR3S7W5KoZeHGai2oGItA1arPSgoCUInherpmRWQ8z
         fPwSPomzqaYOnS1DtkPH5UiIkfoOSm/PX2r0M7fQWd/3uU80uDQmJ+OmBwVcKrO4xQIQ
         Mt0CmaUYbmNaC/3CJVbQSEF7Ubm3uJqgfV6RxZvpj77+yPTRE9vUg5xNOEOlYfMsi6sx
         dU3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=ok1T5yGKDmAmT0BHb7DhO7NcpXgpsjNNJLpNZQI3pio=;
        fh=UCQ4WL8YuwnXd5zGJOkpZuC8PmpMgiA9KWrC7igwljI=;
        b=WYv/HDxzOqaqVXFyzHw7zORo2Db1EBELwSuK6E/DKtXh6BnxnBSHgw6RjcDu8IWT3R
         RGe6fZjo+ccIcLd5uoyAUJ4N5Q8dFcdGxcLaIf9CUG/KpnVMP8kqVDQ/8MPxHQchPy7c
         cFjp1AuA03J4GvgsZdVjL8AchVs0pnSefjF4MBtmpDViTyyycUTs5R9MFLmqfRBj6dOJ
         0IFEHWWXIVZtV6iNE/k5dJccI/BvcC7HBk50B1Mr0+khPYuGmDFqoN6uZIYqo1cwjMza
         2hLW7c+iOKkPvNUJ/hN53OlBWcofrWckpCy3Q5jEOlberNLMiy/PkfwY2elGlv77Sqp0
         P+jg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1769694371; x=1770299171; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ok1T5yGKDmAmT0BHb7DhO7NcpXgpsjNNJLpNZQI3pio=;
        b=C87cdl59yRHDShXCxD4Eb3BCC2P6KPNWMYFECLcfIsi+iE7eVNIeHAl26V+hrAPbr8
         mvg8gylJbNGAFCaCseuWvVcDd2R7WBsb/XlZBRbWol5mq1x+N0NKbYnc4I0LbDs5IGPl
         Q3JeD+KVAp6CUmhw1wPXNULmsGofCNSErqDcORXJHnuBF/Xtsb0XfxpjMUHBxusG0p0+
         Zh0WqPW6jsrNI7QTiqwT0o9/qGnWTYQY5ruU3zCnjxNmga/ia5d+id8Ev/qCrBQnU3Uc
         //NgwbiASOhTn0q90x1Jhta6BWwG6NUh1FAzdAy5tI8wA1ZDfEMmN4bll7OeCMUhPL6P
         vKWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769694371; x=1770299171;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ok1T5yGKDmAmT0BHb7DhO7NcpXgpsjNNJLpNZQI3pio=;
        b=UTrzmUMdEB73aCPjQlt1kA7L0FoWgfNgZeRE1y92zauv56/5hVoz3qWu19gVRQWQT2
         tZAGaicKXIDUgNuOU8+yD6s2qLhL+gmsmRi/f9dRZWNvsbjvghgaANNmwB3y7qadf1ea
         xf4C4udq2YvixHig3fSrZ45t+DtXu9iuDegHRSQHiRytMTfglPdEUGwZ77EOkVO6HLru
         JZsQI9FTOJsI37gKQilmVGol6u96FLMd54kVfyolLMuVxhhxfyxxbzw0ZtugGkWKEQ/V
         jEJj2WPGbqYQoT6adOZwSl+1xUwAmVgNEeFahlRiN7GHU1eqd/zefrPjOQOcbPsIWhi8
         vnyQ==
X-Forwarded-Encrypted: i=1; AJvYcCXU2wzuF+z9HRYL3wTvlc72xatFNaSx9HzeVugBmhfWS+T4Su7Ebdj3kaNfuSxZGcYuRb33uxY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy91/Cl8HRb3FOj6W711rofwXXyGEt2ATGQxICNoreE8x0QBR0H
	R1lrMDJRwYCPiRslBVEA4t1bvF+2VYfiSYJmzMD0VzRfGcdm1yb348O9M5cHuQj1KX+LOXoXc+L
	KUHUoU3SEq2D1+zn4Ct7o8Ybh8zuMjhCyNa6lvcbCyA==
X-Gm-Gg: AZuq6aKALQV3wafODKYcDBkcS5byTgQld826ybefipp4d76wWPIGO8nO3uMtAYk2Xha
	0QIfZ3Tz9GAk+cCTXuc3Dj4XKgqNHNbYMHHOI0DfNEv26jEbcEJGVD4PuIh0Tdu0APUQ9315+HN
	F9Ig4layisBQl9C3uSlRTPMtcz5PM7/DlllYHDleAKGPSK9yt9osFwdYORLj4tFSETqeIw7Tg/v
	fjcNOu/O25L7do8EUNHiwj8iy0Yqh1x3sUovC68QgCyhUbQG6HUtVLI4c0npliTZx8ww2lXf8ky
	XNUEg8uU19Y81WJdR+eJqyoB
X-Received: by 2002:a05:6402:26d4:b0:658:c043:6a5b with SMTP id
 4fb4d7f45d1cf-658c0436b9cmr2360410a12.32.1769694370785; Thu, 29 Jan 2026
 05:46:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260126092159.815968-1-vincent.guittot@linaro.org>
 <20260126092159.815968-4-vincent.guittot@linaro.org> <aXtS-Yan4HkXZlDD@shell.armlinux.org.uk>
In-Reply-To: <aXtS-Yan4HkXZlDD@shell.armlinux.org.uk>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Thu, 29 Jan 2026 14:45:59 +0100
X-Gm-Features: AZwV_QiabLNjn8YnhRXNiAMfl90Rxlw1Vjj6PXig98KuvyBH9m5MNPhf3K_NWig
Message-ID: <CAKfTPtDdpfGK2JE57kwLMEzpi2MuLOBe0FaeOaqgjqPPV-9pLA@mail.gmail.com>
Subject: Re: [PATCH 3/4] phy: s32g: Add serdes xpcs subsystem
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: vkoul@kernel.org, neil.armstrong@linaro.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, ciprianmarian.costea@oss.nxp.com, s32@nxp.com, 
	p.zabel@pengutronix.de, ghennadi.procopciuc@nxp.com, 
	bogdan-gabriel.roman@nxp.com, Ionut.Vicovan@nxp.com, 
	alexandru-catalin.ionita@nxp.com, linux-phy@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org, 
	Frank.li@nxp.com
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254811-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vincent.guittot@linaro.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[linaro.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev,dt];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,nxp.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linaro.org:email,linaro.org:dkim]
X-Rspamd-Queue-Id: 1F758B090A
X-Rspamd-Action: no action

On Thu, 29 Jan 2026 at 13:30, Russell King (Oracle)
<linux@armlinux.org.uk> wrote:
>
> On Mon, Jan 26, 2026 at 10:21:58AM +0100, Vincent Guittot wrote:
> > s32g SoC family includes 2 serdes subsystems which are made of one PCIe
> > controller, 2 XPCS and one Phy. The Phy got 2 lanes that can be configure
> > to output PCIe lanes and/or SGMII.
> >
> > Add XPCS and SGMII support.
> >
> > Co-developed-by: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
> > Signed-off-by: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
> > Co-developed-by: Alexandru-Catalin Ionita <alexandru-catalin.ionita@nxp.com>
> > Signed-off-by: Alexandru-Catalin Ionita <alexandru-catalin.ionita@nxp.com>
> > Co-developed-by: Ghennadi Procopciuc <ghennadi.procopciuc@nxp.com>
> > Signed-off-by: Ghennadi Procopciuc <ghennadi.procopciuc@nxp.com>
> > Co-developed-by: Ionut Vicovan <Ionut.Vicovan@nxp.com>
> > Signed-off-by: Ionut Vicovan <Ionut.Vicovan@nxp.com>
> > Co-developed-by: Bogdan Roman <bogdan-gabriel.roman@nxp.com>
> > Signed-off-by: Bogdan Roman <bogdan-gabriel.roman@nxp.com>
> > Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
>
> I'm not doing a full review for this patch yet.
>
> > +/*
> > + * Note: This function should be compatible with phylink.
> > + * That means it should only modify link, duplex, speed
> > + * an_complete, pause.
> > + */
> > +static int s32g_xpcs_get_state(struct s32g_xpcs *xpcs,
> > +                            struct phylink_link_state *state)
> > +{
> > +     struct device *dev = xpcs->dev;
> > +     unsigned int mii_ctrl, val, ss;
> > +     bool ss6, ss13, an_enabled, intr_en;
> > +
> > +     mii_ctrl = s32g_xpcs_read(xpcs, SR_MII_CTRL);
> > +     an_enabled = !!(mii_ctrl & AN_ENABLE);
> > +     intr_en = !!(s32g_xpcs_read(xpcs, VR_MII_AN_CTRL) & MII_AN_INTR_EN);
> > +
> > +     /* Check this important condition */
> > +     if (an_enabled && !intr_en) {
> > +             dev_err(dev, "Invalid SGMII AN config interrupt is disabled\n");
> > +             return -EINVAL;
> > +     }
>
> This isn't an interrupt handler. Phylink calls it from the state
> resolver, which _may_ be triggered by an interrupt handler, but will
> also be called at other times.
>
> > +
> > +     if (an_enabled) {
> > +             /* MLO_AN_INBAND */
> > +             state->speed = SPEED_UNKNOWN;
> > +             state->link = 0;
> > +             state->duplex =  DUPLEX_UNKNOWN;
> > +             state->an_complete = 0;
> > +             state->pause = MLO_PAUSE_NONE;
>
> Have you looked at the initial state that phylink sets up before
> calling the .pcs_get_state() method? See phylink_mac_pcs_get_state().

okay, I'm going to have a look

>
> speed/duplex/pause/an_complete are already setup like that for you if
> autoneg is enabled. link is the only member you'd need to touch.

Okay

>
> > +             val = s32g_xpcs_read(xpcs, VR_MII_AN_INTR_STS);
> > +
> > +             /* Interrupt is raised with each SGMII AN that is in cases
> > +              * Link down - Every SGMII link timer expire
> > +              * Link up - Once before link goes up
> > +              * So either linkup or raised interrupt mean AN was completed
> > +              */
> > +             if ((val & CL37_ANCMPLT_INTR) || (val & CL37_ANSGM_STS_LINK)) {
> > +                     state->an_complete = 1;
> > +                     if (val & CL37_ANSGM_STS_LINK)
> > +                             state->link = 1;
> > +                     else
> > +                             return 0;
> > +                     if (val & CL37_ANSGM_STS_DUPLEX)
> > +                             state->duplex = DUPLEX_FULL;
> > +                     else
> > +                             state->duplex = DUPLEX_HALF;
> > +                     ss = FIELD_GET(CL37_ANSGM_STS_SPEED_MASK, val);
> > +             } else {
> > +                     return 0;
> > +             }
> > +
> > +     } else {
> > +             /* MLO_AN_FIXED, MLO_AN_PHY */
>
> This function won't be called in those modes, so this is a misleading
> comment. It can be called in MLO_AN_INBAND but when autoneg is disabled.

Okay

>
> > +             val = s32g_xpcs_read(xpcs, SR_MII_STS);
> > +             state->link = !!(val & LINK_STS);
> > +             state->an_complete = 0;
> > +             state->pause = MLO_PAUSE_NONE;
> > +
> > +             if (mii_ctrl & DUPLEX_MODE)
> > +                     state->duplex = DUPLEX_FULL;
> > +             else
> > +                     state->duplex = DUPLEX_HALF;
> > +
> > +             /*
> > +              * Build similar value as CL37_ANSGM_STS_SPEED with
> > +              * SS6 and SS13 of SR_MII_CTRL:
> > +              *   - 0 for 10 Mbps
> > +              *   - 1 for 100 Mbps
> > +              *   - 2 for 1000 Mbps
> > +              */
> > +             ss6 = !!(mii_ctrl & SS6);
> > +             ss13 = !!(mii_ctrl & SS13);
> > +             ss = ss6 << 1 | ss13;
> > +     }
> > +
> > +     switch (ss) {
> > +     case CL37_ANSGM_10MBPS:
> > +             state->speed = SPEED_10;
> > +             break;
> > +     case CL37_ANSGM_100MBPS:
> > +             state->speed = SPEED_100;
> > +             break;
> > +     case CL37_ANSGM_1000MBPS:
> > +             state->speed = SPEED_1000;
> > +             break;
> > +     default:
> > +             dev_err(dev, "Failed to interpret the value of SR_MII_CTRL\n");
> > +             break;
> > +     }
> > +
> > +     val = s32g_xpcs_read(xpcs, VR_MII_DIG_CTRL1);
> > +     if ((val & EN_2_5G_MODE) && state->speed == SPEED_1000)
> > +             state->speed = SPEED_2500;
> > +
> > +     /* Cover SGMII AN inability to distigunish between 1G and 2.5G */
> > +     if ((val & EN_2_5G_MODE) &&
> > +         state->speed != SPEED_2500 && an_enabled) {
> > +             dev_err(dev, "Speed not supported in SGMII AN mode\n");
> > +             return -EINVAL;
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> > +static int s32g_xpcs_config_an(struct s32g_xpcs *xpcs,
> > +                            const struct phylink_link_state state)
> > +{
> > +     bool an_enabled = false;
> > +
> > +     an_enabled = linkmode_test_bit(ETHTOOL_LINK_MODE_Autoneg_BIT,
> > +                                    state.advertising);
> > +     if (!an_enabled)
> > +             return 0;
>
> Don't check the autoneg bit. This is the media-side autoneg, not
> the PCS autoneg.

Okay

>
> > +
> > +     s32g_xpcs_write_bits(xpcs, VR_MII_DIG_CTRL1,
> > +                          CL37_TMR_OVRRIDE, CL37_TMR_OVRRIDE);
> > +
> > +     s32g_xpcs_write_bits(xpcs, VR_MII_AN_CTRL,
> > +                          PCS_MODE_MASK | MII_AN_INTR_EN,
> > +                          FIELD_PREP(PCS_MODE_MASK, PCS_MODE_SGMII) | MII_AN_INTR_EN);
> > +     /* Enable SGMII AN */
> > +     s32g_xpcs_write_bits(xpcs, SR_MII_CTRL, AN_ENABLE, AN_ENABLE);
> > +     /* Enable SGMII AUTO SW */
> > +     s32g_xpcs_write_bits(xpcs, VR_MII_DIG_CTRL1,
> > +                          MAC_AUTO_SW, MAC_AUTO_SW);
> > +
> > +     return 0;
> > +}
> > +
> > +static int s32g_xpcs_config(struct s32g_xpcs *xpcs,
> > +                         const struct phylink_link_state state)
> > +{
> > +     struct device *dev = xpcs->dev;
> > +     unsigned int val = 0, duplex = 0;
> > +     int ret = 0;
> > +     int speed = state.speed;
> > +     bool an_enabled;
> > +
> > +     /* Configure adaptive MII width */
> > +     s32g_xpcs_write_bits(xpcs, VR_MII_AN_CTRL, MII_CTRL, 0);
> > +
> > +     an_enabled = !!(s32g_xpcs_read(xpcs, SR_MII_CTRL) & AN_ENABLE);
> > +
> > +     dev_dbg(dev, "xpcs_%d: speed=%u duplex=%d an=%d\n", xpcs->id,
> > +             speed, state.duplex, an_enabled);
> > +
> > +     if (an_enabled) {
> > +             switch (speed) {
> > +             case SPEED_10:
> > +             case SPEED_100:
> > +             case SPEED_1000:
> > +                     s32g_xpcs_write(xpcs, VR_MII_LINK_TIMER_CTRL, 0x2faf);
> > +                     break;
> > +             case SPEED_2500:
> > +                     s32g_xpcs_write(xpcs, VR_MII_LINK_TIMER_CTRL, 0x7a1);
> > +                     s32g_xpcs_write_bits(xpcs, VR_MII_DIG_CTRL1, MAC_AUTO_SW, 0);
>
> Configuring the link timer _after_ the link has already come up looks
> completely wrong to me... this should be done when .pcs_config() detects
> that the PHY interface mode has changed.

Okay

>
> > +                     break;
> > +             default:
> > +                     dev_err(dev, "Speed not recognized. Can't setup xpcs\n");
> > +                     return -EINVAL;
> > +             }
> > +
> > +             s32g_xpcs_write_bits(xpcs, SR_MII_CTRL, RESTART_AN, RESTART_AN);
>
> As this is called from the .pcs_link_up() method, expect the link to
> go bouncey bouncy bouncy if you restart AN _after_ the link has
> come up.
>
> > +
> > +             ret = s32g_xpcs_wait_an_done(xpcs);
> > +             if (ret)
> > +                     dev_warn(dev, "AN did not finish for XPCS%d", xpcs->id);
> > +
> > +             /* Clear the AN CMPL intr */
> > +             s32g_xpcs_write_bits(xpcs, VR_MII_AN_INTR_STS, CL37_ANCMPLT_INTR, 0);
> > +     } else {
> > +             s32g_xpcs_write_bits(xpcs, SR_MII_CTRL, AN_ENABLE, 0);
> > +             s32g_xpcs_write_bits(xpcs, VR_MII_AN_CTRL, MII_AN_INTR_EN, 0);
> > +
> > +             switch (speed) {
> > +             case SPEED_10:
> > +                     break;
> > +             case SPEED_100:
> > +                     val = SS13;
> > +                     break;
> > +             case SPEED_1000:
> > +                     val = SS6;
> > +                     break;
> > +             case SPEED_2500:
> > +                     val = SS6;
> > +                     break;
> > +             default:
> > +                     dev_err(dev, "Speed not supported\n");
> > +                     break;
> > +             }
> > +
> > +             if (state.duplex == DUPLEX_FULL)
> > +                     duplex = DUPLEX_MODE;
> > +
> > +             s32g_xpcs_write_bits(xpcs, SR_MII_CTRL, DUPLEX_MODE, duplex);
> > +
> > +             if (speed == SPEED_2500) {
> > +                     ret = s32g_serdes_bifurcation_pll_transit(xpcs, XPCS_PLLB);
> > +                     if (ret)
> > +                             dev_err(dev, "Switch to PLLB failed\n");
> > +             } else {
> > +                     ret = s32g_serdes_bifurcation_pll_transit(xpcs, XPCS_PLLA);
> > +                     if (ret)
> > +                             dev_err(dev, "Switch to PLLA failed\n");
> > +             }
> > +
> > +             s32g_xpcs_write_bits(xpcs, SR_MII_CTRL, SS6 | SS13, val);
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> > +/*
> > + * phylink_pcs_ops fops
>
> They are not "fops" which commonly refers to struct file_operations
>
> > + */
> > +
> > +static void s32cc_phylink_pcs_get_state(struct phylink_pcs *pcs, unsigned int neg_mode,
> > +                                     struct phylink_link_state *state)
> > +{
> > +     struct s32g_xpcs *xpcs = phylink_pcs_to_s32g_xpcs(pcs);
> > +
> > +     s32g_xpcs_get_state(xpcs, state);
> > +}
>
> Seems to me a pointless wrapper.

okay

>
> > +
> > +static int s32cc_phylink_pcs_config(struct phylink_pcs *pcs,
> > +                                 unsigned int neg_mode,
> > +                                 phy_interface_t interface,
> > +                                 const unsigned long *advertising,
> > +                                 bool permit_pause_to_mac)
> > +{
> > +     struct s32g_xpcs *xpcs = phylink_pcs_to_s32g_xpcs(pcs);
> > +     struct phylink_link_state state  = { 0 };
> > +
> > +     if (!(neg_mode == PHYLINK_PCS_NEG_INBAND_ENABLED))
> > +             return 0;
> > +
> > +     linkmode_copy(state.advertising, advertising);
> > +
> > +     return s32g_xpcs_config_an(xpcs, state);
>
> Given this is the only callsite for this function, and the only thing
> you pass is the advertising mask, why pass a struct phylink_link_state
> rather than the advertising mask?

fair enough

>
> > +}
> > +
> > +static void s32cc_phylink_pcs_restart_an(struct phylink_pcs *pcs)
> > +{
> > +     /* Not yet */
> > +}
> > +
> > +static void s32cc_phylink_pcs_link_up(struct phylink_pcs *pcs,
> > +                                   unsigned int neg_mode,
> > +                                   phy_interface_t interface, int speed,
> > +                                   int duplex)
> > +{
> > +     struct s32g_xpcs *xpcs = phylink_pcs_to_s32g_xpcs(pcs);
> > +     struct phylink_link_state state = { 0 };
> > +
> > +     state.speed = speed;
> > +     state.duplex = duplex;
> > +     state.an_complete = false;
>
> an_complete is never an "input" to drivers. It's a state from PCS
> drivers back to phylink. Also, s32g_xpcs_config never looks at this.
>
> > +
> > +     s32g_xpcs_config(xpcs, state);
>
> Again, the only things that this function uses are the speed and
> duplex, so why wrap them up into a struct?

will clean this

>
> > +}
> > +
> > +static const struct phylink_pcs_ops s32cc_phylink_pcs_ops = {
> > +     .pcs_get_state = s32cc_phylink_pcs_get_state,
> > +     .pcs_config = s32cc_phylink_pcs_config,
> > +     .pcs_an_restart = s32cc_phylink_pcs_restart_an,
> > +     .pcs_link_up = s32cc_phylink_pcs_link_up,
> > +};
>
> Please implement .pcs_inband_caps. As you don't support disabling
> inband for SGMII, that means you can't support MLO_AN_PHY mode
> reliably.

okay

>
> Also note that there are PHYs out there that do _not_ provide SGMII
> inband, which means if you have it enabled, and you're relying on it
> to complete, you won't be able to interface with those PHYs. There's
> such a PHY on a SFP module.
>
> If this driver is purely for a network PCS, then please locate it in
> drivers/net/pcs.

That was an one open point for me because the content of this file is
only called by
drivers/phy/freescale/phy-nxp-s32g-xpcs.c
So locating both in the same place looked reasonable but I can but
files in different dir

>
> I'm pretty sure there's other stuff I've missed as far as the phylink
> API goes, so please expect further review once you've addressed the
> comments above.

Thanks

>
> --
> RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

