Return-Path: <netdev+bounces-256363-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sIApBWYpgmnFPwMAu9opvQ
	(envelope-from <netdev+bounces-256363-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 17:59:18 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B6CCADC67D
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 17:59:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B5D6530480B7
	for <lists+netdev@lfdr.de>; Tue,  3 Feb 2026 16:58:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A79403D348B;
	Tue,  3 Feb 2026 16:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=twx-software.de header.i=@twx-software.de header.b="flYl0/L+"
X-Original-To: netdev@vger.kernel.org
Received: from mail.twlab.de (mail.twlab.de [80.151.39.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEAEF3D3483
	for <netdev@vger.kernel.org>; Tue,  3 Feb 2026 16:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.151.39.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770137921; cv=none; b=bFaxqqr2SREbHdeV6PJ/rKEreBr1Oyn4/hTQK4NNgxvkTWHzPq/Lr9L10VXFsTC01fyV4vJKe6Xxg2WehTAqoExPnbfXYWxxp7kvzvTTAatp+hFMRcPHBQih7qbth6U1CKgVo3gYE70bVMqDzaZXqaC7W0j1RsI6AWuZCm0QGAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770137921; c=relaxed/simple;
	bh=BF6do8fKz4iarIg9phCU0jb0BBJ9U7FkePh/tlrxcsw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q7KML9B5B4U9fB5fqLjJik/8ZBgOqJbraTw9+o1QQx73BOiMOfUlXAynPZIoVlZOBdAlI7sOX7RUTDxQWO9TqLQfJVgmV4C83mIxmKKH5ZnKizEE+7jK5v2ZA6GD/VO63Va+Rx9jbAfCtkkNytKo8M+lWpNd9KnWRrQTyXVkdkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=twx-software.de; spf=pass smtp.mailfrom=twx-software.de; dkim=pass (2048-bit key) header.d=twx-software.de header.i=@twx-software.de header.b=flYl0/L+; arc=none smtp.client-ip=80.151.39.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=twx-software.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=twx-software.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 5B5745E88C5;
	Tue,  3 Feb 2026 17:58:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=twx-software.de;
	s=dkim; t=1770137917;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=ZZgoYlVwmtWFoX6N1E/cgYWzZjDLJBFXtzgmK08GReo=;
	b=flYl0/L+r08z8ilgnOD+8g4o/ZAcCPPnHA3x7jkbCDBF6YeWarM3bTIJbfA+MMBLhb6eVC
	H78pox0juCpoqRkyoZpgEvb3zBRFHXvbfROpAt5QIkO7jZ0EN9am+1akDCBELBJtYO1pqy
	+MJskbqC6NO/bqotO3wJYJOADmE9xiCaVd1valuiYRo9eLnf676VL3xFsKfeFTqb/ySShJ
	GyOISm9xWOTUarCIqq2OVuGIiVyHpD7yWBHqR6OYueNo7Nso9N2CLnQMMWdSqSTa5h0jwu
	YRc4K9zqyw2iCoE9c93SikY6YAcO1yxglbWkdYIA+fGxh0EDTWLNTRQyuTRPAw==
Date: Tue, 3 Feb 2026 17:58:19 +0100
From: Heinrich Toews <ht@twx-software.de>
To: Tim Harvey <tharvey@gateworks.com>
Cc: netdev <netdev@vger.kernel.org>, Andrew Lunn <andrew@lunn.ch>, 
	Florian Fainelli <f.fainelli@gmail.com>, Vladimir Oltean <olteanv@gmail.com>, 
	Rob Herring <robh+dt@kernel.org>
Subject: Re: [v1,3/3] net: dsa: microchip: add single-led-mode support for
 KSZ9477
Message-ID: <xannp3dq73ufdyvke535opvb2hb7zra3tbxcvfkso2ossjf2hf@tucgd7qfwwcp>
References: <CAJ+vNU2c+kt3vX6PzqALakdwzyb5qh6O7Oj4xyxsWnsXCAUaRw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJ+vNU2c+kt3vX6PzqALakdwzyb5qh6O7Oj4xyxsWnsXCAUaRw@mail.gmail.com>
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[twx-software.de,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[twx-software.de:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-256363-lists,netdev=lfdr.de];
	TO_DN_ALL(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lunn.ch,gmail.com,kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	NEURAL_HAM(-0.00)[-0.998];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ht@twx-software.de,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[twx-software.de:+];
	TAGGED_RCPT(0.00)[netdev,dt];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6]
X-Rspamd-Queue-Id: B6CCADC67D
X-Rspamd-Action: no action

Hi Rob,

On Fri, Jan 30, 2026 at 01:46:52PM -0800, Tim Harvey wrote:
> >
> > diff --git a/drivers/net/dsa/microchip/ksz_common.c
> > b/drivers/net/dsa/microchip/ksz_common.c
> > index e5fa1f5fc09b3..bef8ec51d9483 100644
> > --- a/drivers/net/dsa/microchip/ksz_common.c
> > +++ b/drivers/net/dsa/microchip/ksz_common.c
> > @@ -815,6 +815,9 @@  static const u16 ksz9477_regs[] = {
> >   [PTP_RTC_SEC] = 0x0508,
> >   [PTP_SUBNANOSEC_RATE] = 0x050C,
> >   [PTP_MSG_CONF1] = 0x0514,
> > + [P_PHY_MMD_SETUP] = 0x011A,
> > + [P_PHY_MMD_DATA] = 0x011C,
> > + [P_PHY_DIGITAL_DEBUG_3] = 0x013C,
> >  };
> >
> > @@ -3241,6 +3244,14 @@  static u32 ksz_get_phy_flags(struct dsa_switch
> > *ds, int port)
> >   if (!port)
> >   return MICREL_KSZ8_P1_ERRATA;
> >   break;
> > + case KSZ9477_CHIP_ID:
> > + /* KSZ9477S Errata DS80000754F
> > + *
> > + * Module 19: Single-LED Mode Setting Requires Two Register Writes
> > + *   The PHY Port LEDx_0 pin does not go low in the presence of link
> > + *   activity when Single-LED Mode is selected in the MMD LED Mode Register.
> > + */
> > + return MICREL_KSZ9_LED_ERRATA;
> >   }
> >
> 
> Hi Heinrich,
> 
> Thanks for doing this. I have two boards I work with that have a
> KSZ9897S switch and use single-led mode (imx8mp-venice-gw74xx.dts and
> imx8mm-venice-gw7901.dts) that suffer from this issue. In my scenario
> I take care of this in the bootloader but when ksz9477_reset_switch()
> is called and sets the SW_RESET bit of REG_SW_OPERATION it resets all
> registers and reverts to tri-color dual-led mode thus we really do
> need a dt prop and handling for this.

I agree. To support these use cases, a specific Device Tree property
would be the right thing here.

> You can add the errata for KSZ9897 as well here:
> +       case KSZ9897_CHIP_ID:
> +               /* KSZ9897S Errata DS80000759F: Module 18 */
> +               return MICREL_KSZ9_LED_ERRATA;
> 
> And because this errata applies to multiple chips it's probably best
> to describe the workaround once and refer to the errata # in the cases
> statements.

I did some research on this and it seems that nearly all members of the 
KSZ9xxx series are affected, including:

KSZ9477 / KSZ9897 / KSZ9896
KSZ9567 / KSZ8567 / KSZ9893
KSZ9563 / KSZ8563 / KSZ8565

So MICREL_KSZ9_LED_ERRATA should be enabled for these CHIP_IDs.

> > +static void ksz_enable_single_led_mode(struct ksz_device *dev, int
> > port, struct phy_device *phydev)
> > +{
> > + const u16 *regs = dev->info->regs;
> > +
> > + ksz_pwrite16(dev, port, regs[P_PHY_MMD_SETUP], 0x0002); /* Set up
> > register address for MMD */
> > + ksz_pwrite16(dev, port,  regs[P_PHY_MMD_DATA], 0x0000); /* Select
> > Register 00h of MMD */
> > + ksz_pwrite16(dev, port, regs[P_PHY_MMD_SETUP], 0x4002); /* Select
> > register data for MMD */
> > + ksz_pwrite16(dev, port,  regs[P_PHY_MMD_DATA], 0x0011); /* Write
> > value 0011h to MMD */
> 
> These are wrong: The MMD_SETUP and MMD_DATA regs you are using here
> 0x011a and 0x11c are actually 0xN11a 0x 0xN11c (where N is the port)
> so they port specific so the above only would set them for port0.
> Because these registers correspond to standardPHY register 0x0d and
> 0x0e which are defined in mii.h you can just use those.
> 
> What you want here is to use ksz_phy_write16 on the port which will
> call the chip-specific w_phy which will handle writing to the port
> specific register:
> ksz_phy_write16(dev, port, MII_MMD_CTRL, 0x02);
> ksz_phy_write16(dev, port, MII_MMD_DATA, 0x00);
> ksz_phy_write16(dev, port, MII_MMD_CTRL, MII_MMD_CTRL_NOINCR | 0x02);
> ksz_phy_write16(dev, port, MII_MMD_DATA, 0x10);

I added debug output and tested my setup on all 4 external ports and it
works:

ksz-switch spi1.0: ksz_pwrite16: port: 1, offset: 0x011a, data: 0x0002
ksz-switch spi1.0: ksz_write16: reg: 0x0000211a, value: 0x0002
                                                          ^^^^
							  The port index
							  is set
							  correctly.

[...]

ksz-switch spi1.0: ksz_pwrite16: port: 2, offset: 0x011a, data: 0x0002
ksz-switch spi1.0: ksz_write16: reg: 0x0000311a, value: 0x0002
                                                          ^^^^
							  The same here
							  on port 2.

Is see activity on the leds connected to LEDx_0.

ksz9477_get_port_addr() is adding the port index by PORT_CTRL_ADDR(port, offset).

But since I'm accessing PHY registers here, I'll switch to ksz_phy_write16() in v2.

> Note on that last one, the errata says to write 0x11 but that's a typo
> as if you read closely it says 'setting bit 4' and looking at the
> datasheet bit0 is reserved, so the 0x11 should be 0x10.

Yes, you're right. I remember seeing it before. Thanks.

> Similarly the errata specifies this as PHY register 0x1E (which is a
> vendor specific register so not defined in mii.h):
> 
> ksz_phy_write16(dev, port, 0x1e, 0xfa00);

May be I should add a local macro define for it.

> Your original patch doesn't work in my case (maybe it worked for you
> because you were trying to address port0?). With the above changes the
> LED's are properly configured on my boards.

Okay. But I don't really understand why its not working in your
case.

Thanks for you're feedback.

Regards,
Heinrich.

