Return-Path: <netdev+bounces-256500-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aIWEOFabgmlgWwMAu9opvQ
	(envelope-from <netdev+bounces-256500-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 02:05:26 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E059E045C
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 02:05:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D2684307AA62
	for <lists+netdev@lfdr.de>; Wed,  4 Feb 2026 00:56:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DC5C22D9F7;
	Wed,  4 Feb 2026 00:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gateworks.com header.i=@gateworks.com header.b="ayWvQu+I"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F416225A3B
	for <netdev@vger.kernel.org>; Wed,  4 Feb 2026 00:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770166605; cv=pass; b=sWIR9iTcpDGJ/NpmB/zAojLi4lPoo6ES2e5/WnNZq8eOlS8eD//kh9n7SPQw0eOsI5vR2VHnlFaLS9qKx06WyqRV221s9m/7s/AvKMcotfD3yESQI1VZmTVB9fqvCcJBv30hLQQqwMfHC0Z+MZ0wkpOseXuf30NYAXpckQpC2M0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770166605; c=relaxed/simple;
	bh=QW1dxCfaKLqaEEdNBhDLbZpo7SdFsyada/I8/fAHcMY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ifBJfRej+XijlDt/CtB0WRrZ63Xa1g23iVMtKijae5Bc7L0C6f15DPqS1xhgHO6lNmoGwWzP3HZ6VGTVNJaPXDHva0Ui6KRYI8M/fzG3wGxK5wO2x9/dcIWCMqrKTtVFf0Zs/04tzNRgRWPjwarMos0mVt+/ilN8x1IIOPJt4D8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gateworks.com; spf=pass smtp.mailfrom=gateworks.com; dkim=pass (2048-bit key) header.d=gateworks.com header.i=@gateworks.com header.b=ayWvQu+I; arc=pass smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gateworks.com
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-40970f97638so3661420fac.3
        for <netdev@vger.kernel.org>; Tue, 03 Feb 2026 16:56:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770166602; cv=none;
        d=google.com; s=arc-20240605;
        b=A5OPwRkQaVPvrKB+wjci7IWDV9+sDI0PHiRgExe1KeTXk5lUr3BN4Cm/a4h9j6AXHH
         Pmge4Xpwt31/61uCLKQ1AWuz+MncjcdXstp/WARbASe63a0IlOpCEL5VY4EcdF/iDgR7
         KBDaEQ1eHXCJzZAY9qHHyxubrCLeBgolt6RUtepAXo+zxo1UWliKAw9ZC+NWhJ9eJ+qH
         UgRz6R+5AowuubSuRYm7WK9r+7TinyLKJ/QS/la65gCo5hU3qObbFNwNfLl8q2XyMhYK
         VUAq+nyZModiPUFYMIIQeR+94pEq+1jxP2Z8p9ApW6ieI2Z3GjC8fvnCz/H6tFpZMs7z
         oK7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=iqvRyV0cstrkegqBYYgFhMwUpn5+Sg/eykdipjghBHE=;
        fh=95mb6VOG95To0en3TybK1Twi1tibzz17pRRtepEFGok=;
        b=WpToNfa9fMXRwr4aiWw9Z3UQVXM2PNw/SyXAAqLKq24jouc6nI6SisT1aIBJ/ZDD6n
         NHnxPhFtH+ruTz19dKpuOmJNi7nOKdvle0uUq0eVL+cpLNZQ2kuE4L2MxoDU6E0G2F+1
         mUvacEG5iWXKFZDGIKYMhIyOKyfAfiiRq/XbVRgYnrI8ADhl9L5bS2nmE5cl0w1Gcfyf
         FJJBkSlkDeCEcPdi68EXrCiFDqIxOhiR/2HU1I/prCqT7mRC9nBLZmtzWO20ByHy/hoI
         NZV8GUmfrD1io92yE7dUT6MiKhaNQErd4CWZk1M1phx4K5+eFpNeIIjWrmbx+2N2wp5y
         fQLQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gateworks.com; s=google; t=1770166602; x=1770771402; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iqvRyV0cstrkegqBYYgFhMwUpn5+Sg/eykdipjghBHE=;
        b=ayWvQu+Il4pk33xBZSXVRVdxZJy9NgmZj/c1rRNZvEOZo7sCeSMaW8+XjAxbPenO6R
         Afk5gRNzZjjOpBFHdkBwQg6HFFSJXED00h3tyqlGEKwHgBXt8k5Fy5NW+nsrvSpy1s8o
         yewTDGHdrIZfYlO5Rtd6oXVT3pwtvzArwSLd2WQan1lu6+FhPJlAg8CMOqcWGFMXC0bp
         U1acf/nCVvEFs2AZkVkbvpHQQeTFqj2RoDIJbgUFaRNf0harCpH0uAghGOdbSzN+rZOd
         zto1JG5jJioiUtkSDI97GuG8RWZNf7es9XHoQ/IIlD3NAFnxn23pLyAS3zjF3YntQdNX
         oc7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770166602; x=1770771402;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iqvRyV0cstrkegqBYYgFhMwUpn5+Sg/eykdipjghBHE=;
        b=VFgPW0r1Ix4WR/ECNdGHZAhu7UAA0OVdNLj7cvII8OyXQHcMPwuU44mWf3kztjh/f+
         kgP1lhSwIkI85GaAOvMtjLl+n5cgRq3ITwBadhP2B26l7dKEK5FXm1LriLeGJ47Pqb1A
         TGq57KjqiIcgvuGjWjFa+mDh8XsKvbxOgftZWyT8rzCdz4ATfxrpz8GFsQfRrSxEzBsw
         6k9KdH7+NB0OSPWINGGcBudYzKi97RYZxjx2CYP7ylVdBVJqh5pHZ0NmhFrxo0au/Nv/
         21bzNW+pwEMBRJI/WhQgJIG1Z7GvyWYuS7FCK9ignXdJSqYNtBi0vYn56kV+nMZk0fN1
         nEGQ==
X-Gm-Message-State: AOJu0Yw8c4K1Ku/Mah3nO76pga8UEAg8lcBYyZoFSEyAg/M0V3Nd495/
	2gv0ieLYGljUIHUEiKBNgbq0c2WCut1ZgKQ800jlUuKyQfkdjT/dMRur0/NuKL3iShgHKmAScrc
	TrTAQtd0fkONeZSsW5Hs8xvN0Ks2Ou6RuXzxcC9zr2A==
X-Gm-Gg: AZuq6aJkGcONQMQ5xVp+DhsGwZ2ZTsq2BeJQDHmBE2JEjxo9YRjmCeQPUaTDmFtI/QM
	CViNQfz8NMNDk64VoatC20sjvItm9VQtLRviZYR3DMeFPpVraE4+6vub3lCbLMVB5kB1EhizTU1
	SaVkujqYfJA/BBYpU6FV/B0A1Zfp0zDHHogJO/RkOiKPZTTX0Bt8Lb4Sygqgw/7KyTiEC03Zl1d
	s8ImLzp7+P+kbUK5ksDY4PcobEaLYu8qVCIOxKR3Km53RNeIk9MZv19Sv1Jhkqx08uy4jw=
X-Received: by 2002:a05:6820:8188:b0:65d:22b:416f with SMTP id
 006d021491bc7-66a2371c3f1mr790821eaf.65.1770166602354; Tue, 03 Feb 2026
 16:56:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJ+vNU2c+kt3vX6PzqALakdwzyb5qh6O7Oj4xyxsWnsXCAUaRw@mail.gmail.com>
 <xannp3dq73ufdyvke535opvb2hb7zra3tbxcvfkso2ossjf2hf@tucgd7qfwwcp>
In-Reply-To: <xannp3dq73ufdyvke535opvb2hb7zra3tbxcvfkso2ossjf2hf@tucgd7qfwwcp>
From: Tim Harvey <tharvey@gateworks.com>
Date: Tue, 3 Feb 2026 16:56:30 -0800
X-Gm-Features: AZwV_QihsX3VAcPOVtrCuizmD6fda3xODYCvQn9akk3F_JQ3aj--Qv2aGAV36Yk
Message-ID: <CAJ+vNU2Qw2mJv4QwUee0UAxpis03238oJksRSdXZ2UG2MM=xXw@mail.gmail.com>
Subject: Re: [v1,3/3] net: dsa: microchip: add single-led-mode support for KSZ9477
To: Heinrich Toews <ht@twx-software.de>
Cc: netdev <netdev@vger.kernel.org>, Andrew Lunn <andrew@lunn.ch>, 
	Florian Fainelli <f.fainelli@gmail.com>, Vladimir Oltean <olteanv@gmail.com>, 
	Rob Herring <robh+dt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gateworks.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gateworks.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_ALL(0.00)[];
	TAGGED_FROM(0.00)[bounces-256500-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,lunn.ch,gmail.com,kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tharvey@gateworks.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gateworks.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev,dt];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid,twx-software.de:email]
X-Rspamd-Queue-Id: 4E059E045C
X-Rspamd-Action: no action

On Tue, Feb 3, 2026 at 8:58=E2=80=AFAM Heinrich Toews <ht@twx-software.de> =
wrote:
>
> Hi Rob,
>
> On Fri, Jan 30, 2026 at 01:46:52PM -0800, Tim Harvey wrote:
> > >
> > > diff --git a/drivers/net/dsa/microchip/ksz_common.c
> > > b/drivers/net/dsa/microchip/ksz_common.c
> > > index e5fa1f5fc09b3..bef8ec51d9483 100644
> > > --- a/drivers/net/dsa/microchip/ksz_common.c
> > > +++ b/drivers/net/dsa/microchip/ksz_common.c
> > > @@ -815,6 +815,9 @@  static const u16 ksz9477_regs[] =3D {
> > >   [PTP_RTC_SEC] =3D 0x0508,
> > >   [PTP_SUBNANOSEC_RATE] =3D 0x050C,
> > >   [PTP_MSG_CONF1] =3D 0x0514,
> > > + [P_PHY_MMD_SETUP] =3D 0x011A,
> > > + [P_PHY_MMD_DATA] =3D 0x011C,
> > > + [P_PHY_DIGITAL_DEBUG_3] =3D 0x013C,
> > >  };
> > >
> > > @@ -3241,6 +3244,14 @@  static u32 ksz_get_phy_flags(struct dsa_switc=
h
> > > *ds, int port)
> > >   if (!port)
> > >   return MICREL_KSZ8_P1_ERRATA;
> > >   break;
> > > + case KSZ9477_CHIP_ID:
> > > + /* KSZ9477S Errata DS80000754F
> > > + *
> > > + * Module 19: Single-LED Mode Setting Requires Two Register Writes
> > > + *   The PHY Port LEDx_0 pin does not go low in the presence of link
> > > + *   activity when Single-LED Mode is selected in the MMD LED Mode R=
egister.
> > > + */
> > > + return MICREL_KSZ9_LED_ERRATA;
> > >   }
> > >
> >
> > Hi Heinrich,
> >
> > Thanks for doing this. I have two boards I work with that have a
> > KSZ9897S switch and use single-led mode (imx8mp-venice-gw74xx.dts and
> > imx8mm-venice-gw7901.dts) that suffer from this issue. In my scenario
> > I take care of this in the bootloader but when ksz9477_reset_switch()
> > is called and sets the SW_RESET bit of REG_SW_OPERATION it resets all
> > registers and reverts to tri-color dual-led mode thus we really do
> > need a dt prop and handling for this.
>
> I agree. To support these use cases, a specific Device Tree property
> would be the right thing here.
>
> > You can add the errata for KSZ9897 as well here:
> > +       case KSZ9897_CHIP_ID:
> > +               /* KSZ9897S Errata DS80000759F: Module 18 */
> > +               return MICREL_KSZ9_LED_ERRATA;
> >
> > And because this errata applies to multiple chips it's probably best
> > to describe the workaround once and refer to the errata # in the cases
> > statements.
>
> I did some research on this and it seems that nearly all members of the
> KSZ9xxx series are affected, including:
>
> KSZ9477 / KSZ9897 / KSZ9896
> KSZ9567 / KSZ8567 / KSZ9893
> KSZ9563 / KSZ8563 / KSZ8565
>
> So MICREL_KSZ9_LED_ERRATA should be enabled for these CHIP_IDs.
>
> > > +static void ksz_enable_single_led_mode(struct ksz_device *dev, int
> > > port, struct phy_device *phydev)
> > > +{
> > > + const u16 *regs =3D dev->info->regs;
> > > +
> > > + ksz_pwrite16(dev, port, regs[P_PHY_MMD_SETUP], 0x0002); /* Set up
> > > register address for MMD */
> > > + ksz_pwrite16(dev, port,  regs[P_PHY_MMD_DATA], 0x0000); /* Select
> > > Register 00h of MMD */
> > > + ksz_pwrite16(dev, port, regs[P_PHY_MMD_SETUP], 0x4002); /* Select
> > > register data for MMD */
> > > + ksz_pwrite16(dev, port,  regs[P_PHY_MMD_DATA], 0x0011); /* Write
> > > value 0011h to MMD */
> >
> > These are wrong: The MMD_SETUP and MMD_DATA regs you are using here
> > 0x011a and 0x11c are actually 0xN11a 0x 0xN11c (where N is the port)
> > so they port specific so the above only would set them for port0.
> > Because these registers correspond to standardPHY register 0x0d and
> > 0x0e which are defined in mii.h you can just use those.
> >
> > What you want here is to use ksz_phy_write16 on the port which will
> > call the chip-specific w_phy which will handle writing to the port
> > specific register:
> > ksz_phy_write16(dev, port, MII_MMD_CTRL, 0x02);
> > ksz_phy_write16(dev, port, MII_MMD_DATA, 0x00);
> > ksz_phy_write16(dev, port, MII_MMD_CTRL, MII_MMD_CTRL_NOINCR | 0x02);
> > ksz_phy_write16(dev, port, MII_MMD_DATA, 0x10);
>
> I added debug output and tested my setup on all 4 external ports and it
> works:
>
> ksz-switch spi1.0: ksz_pwrite16: port: 1, offset: 0x011a, data: 0x0002
> ksz-switch spi1.0: ksz_write16: reg: 0x0000211a, value: 0x0002
>                                                           ^^^^
>                                                           The port index
>                                                           is set
>                                                           correctly.
>
> [...]
>
> ksz-switch spi1.0: ksz_pwrite16: port: 2, offset: 0x011a, data: 0x0002
> ksz-switch spi1.0: ksz_write16: reg: 0x0000311a, value: 0x0002
>                                                           ^^^^
>                                                           The same here
>                                                           on port 2.
>
> Is see activity on the leds connected to LEDx_0.
>

Hi Heinrich,

My apologies - you are correct. I accidentally missed the hunk where
you set your registers in ksz9477_regs causing it to not work for me.

> ksz9477_get_port_addr() is adding the port index by PORT_CTRL_ADDR(port, =
offset).
>
> But since I'm accessing PHY registers here, I'll switch to ksz_phy_write1=
6() in v2.

Yes, that would be best as you would no longer need to add custom registers=
.

I have:

        ksz_phy_write16(dev->ds, port, MII_MMD_CTRL, 0x0002);
        ksz_phy_write16(dev->ds, port,  MII_MMD_DATA, 0x0000);
        ksz_phy_write16(dev->ds, port, MII_MMD_CTRL,
MII_MMD_CTRL_NOINCR | 0x02);
        ksz_phy_write16(dev->ds, port,  MII_MMD_DATA, 0x0010); /* set bit 4=
 */
        /* LED_ERRATA requires writing 0xfa00 to Debug Register 3 (PHY
register 0x1e) */
        if (phydev->dev_flags & MICREL_KSZ9_LED_ERRATA)
                ksz_phy_write16(dev->ds, port, 0x1e, 0xfa00);

I look forward to seeing your next submission.

Best Regards,

Tim

>
> > Note on that last one, the errata says to write 0x11 but that's a typo
> > as if you read closely it says 'setting bit 4' and looking at the
> > datasheet bit0 is reserved, so the 0x11 should be 0x10.
>
> Yes, you're right. I remember seeing it before. Thanks.
>
> > Similarly the errata specifies this as PHY register 0x1E (which is a
> > vendor specific register so not defined in mii.h):
> >
> > ksz_phy_write16(dev, port, 0x1e, 0xfa00);
>
> May be I should add a local macro define for it.
>
> > Your original patch doesn't work in my case (maybe it worked for you
> > because you were trying to address port0?). With the above changes the
> > LED's are properly configured on my boards.
>
> Okay. But I don't really understand why its not working in your
> case.
>
> Thanks for you're feedback.
>
> Regards,
> Heinrich.

