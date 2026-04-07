Return-Path: <netdev+bounces-276199-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id pbw9JdeI1Wlt7QcAu9opvQ
	(envelope-from <netdev+bounces-276199-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 00:44:39 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B4CB3B5578
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 00:44:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1013F300BE0E
	for <lists+netdev@lfdr.de>; Tue,  7 Apr 2026 22:44:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0ED038737E;
	Tue,  7 Apr 2026 22:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DPwF08TD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FADB38736A
	for <netdev@vger.kernel.org>; Tue,  7 Apr 2026 22:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775601873; cv=none; b=GpDGZAX6hiONw13VM1rOjHy3Bp+dQNWJiZV6WkuTMIVoiGcYALpgrRtiHd95UaQJVFHEW2vfqVdcp0KNEE+TXomE0djOnPx7Q0+JihbsI/rUFyfeMmzMUshhRXVuKwFVm4pS4rLiKekc9GmLfhrCi3H6ioNbPN2Jj2E+msJ5Qts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775601873; c=relaxed/simple;
	bh=QYe2CABe/K8aAq+mMY7kr5WIVl3EH4Ux1O+PbOiy6ME=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fnAcsueHgyC09ZOOhzA6vjIIuiu5f9LUrghIBh0eWh6MGl3eaix2mPNInY9+4vOYSdTVFIgtY3/rmDZyD7YITdbRyT4vKGXeGi/KF9T6q+0YypTQgpBtDc+5vQhfeNYMveBR5M1iX1ThIeXzmVVoSu/cumO4xu4t1CgNoUpOqsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DPwF08TD; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-43d43e09de5so1105579f8f.1
        for <netdev@vger.kernel.org>; Tue, 07 Apr 2026 15:44:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775601870; x=1776206670; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aFn1KgMBqfqOO+z80s7xp5NsiGDLmr86FdDFazjaA0U=;
        b=DPwF08TDxAnzAsIVSuuziICUSwZB5X5fHoDT/CNdytENUt+k5ZPnT+X7wdny4v/1z1
         +muQ33qFnG6H47RXJ/MqjVf6eFnndeQzGOCzE4PBSpDtyX4OuLGu8Kc6JFWtCoF+yP3k
         ybAEZO7jBVIU0EnfexCKXNvWAIQ3AJHnhp/VJmYspsh8hnefD1vvczv/SFu1q9oQh9Vp
         tn+By9Zc1zz/l9JXy9N70r5uDo20ppWDe1Rz/Eb5fEuawuoEtlt86TkLKtHABjk8L6TI
         9ARx+DuG9sYhoGuHWVvkdzurj5/HA8KR0PzHXChtJN5k8ByrO9xZ2ImRNWPl4FeugG4g
         Q6Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775601870; x=1776206670;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aFn1KgMBqfqOO+z80s7xp5NsiGDLmr86FdDFazjaA0U=;
        b=mCKvZ+cXgnbs9It9iqQqonLboc6ndH+1eQmHsUEkTAnvMTQ2BmKFfrHcB1HLeQKGsF
         y5o+lCXELayXb63s+pPz2w6BPIulm4dm7Iuwi2Xl96sA0VncDgXFd6yEjiv8R8LqdyO8
         X+OhhEVI3rLJYFZ6grtKcw6XCO0TFgYm9voo4PI+4KkYt8ZldJC07hkQgIZmxLWDwCAd
         B3CM1oYsR2VlWEm7Lz6MjGfmauv+dwcztwqu3ASI6NIFN/xE+a6Tvo/pqqMchFK1q3Mx
         /jfzWWUOZxIt3QiDpaFLFNy92mHU75PY+CbGE3hVDryqfzJLX4b4AW/bhZq+1kvborTA
         k9IA==
X-Forwarded-Encrypted: i=1; AJvYcCWrJNJmyxcX1+a+2vh2FlQrQrI3G1K62zDywtHWNjls724sw4u8KIwtD/JM4wFqX7x4pbgEvXg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGec8Mhaq0cEUAN9RG7qjzj9JJSVO0PWuJGdb/qsc8t3zo/bHw
	JMehaCM1LuoFI9UI+8LTbh1AvtEZW+HY5FWuKNr6H2JaFB2pDH1u7zne
X-Gm-Gg: AeBDietljD3NZ9qVw3wsab46r42tvEJrbzedQJuo/yQ2Rgcp8mlIezUedTeb3c1z2pM
	lFZVeCq/6zRZ/r2GEwS9K9kdfj6QM09QT/63aXA4IcOKnK0o3acWoGoDgNx5cIf5LbWpvRmHTC1
	OiPxlxkLtJxYcZCoGPIJbwEmcBVd2FvW3UVaAGwyS7umjBVTdSc1e7GSZmSy9CAT/OXxInAw0FB
	ekhWyGDSsClZaBoEQQlbDAqxH/tpqrL9U2RSq7y1dtYE35KuoZag3ljigD48Zzw8rs7/dYXbtS9
	xqVoWsCPz/R/S1FmBp7hheE9wbYseyuHAjfa0aYM9rYD5ZeSmzVD6ErXGsLfyF/XqlBr3Jnc7mR
	THV4NcuU2VtDV1itMrVMztCAR7w6aAPR9kPZOR35yIsSfyJa+WiQ+v4YkjUO4isoxBsgInaXgt0
	X2JKn/Vr7qFVDxapID4fXhZ3xA0Pw=
X-Received: by 2002:a05:6000:611:b0:43c:fbfa:20a0 with SMTP id ffacd0b85a97d-43d292cb9cemr30197739f8f.25.1775601870318;
        Tue, 07 Apr 2026 15:44:30 -0700 (PDT)
Received: from google.com ([37.228.206.31])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d1e4e6224sm53900233f8f.25.2026.04.07.15.44.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 15:44:29 -0700 (PDT)
Date: Tue, 7 Apr 2026 23:44:27 +0100
From: Fabio Baltieri <fabio.baltieri@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Heiner Kallweit <hkallweit1@gmail.com>, nic_swsd@realtek.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Russell King - ARM Linux <linux@armlinux.org.uk>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v1] r8169: implement get_module functions for
 rtl8127atf
Message-ID: <adWIy9d9VgDha_ub@google.com>
References: <20260404201333.2849-1-fabio.baltieri@gmail.com>
 <4f8310c2-07be-452a-84fa-0ec87d985651@gmail.com>
 <368d3f30-b4af-4548-a4b9-f8e4e4f9a4cb@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <368d3f30-b4af-4548-a4b9-f8e4e4f9a4cb@lunn.ch>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,realtek.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,armlinux.org.uk,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-276199-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fabiobaltieri@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.993];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8B4CB3B5578
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, Apr 05, 2026 at 12:46:41AM +0200, Andrew Lunn wrote:
> > Hi Fabio, thanks for the patch. Being able to access the SFP I2C bus is an
> > important step towards future phylink/SFP support.
> > 
> > @Russell/@Andrew
> > I'm not really familiar with the phylink and sfp code. And I would like to have
> > the functionality being implemented here reusable once we do further steps
> > towards phylink support in r8169. So how shall the code be modeled, which
> > components are needed?
> > - Shall the SFP I2C bus be modeled as a struct i2c_adapter?
> 
> Yes, that would be best. Call i2c_add_adapter() to add it to the I2C
> core. The SFP code in drivers/net/phy can then make use of it.

Hey Andrew, thanks for the pointers, I was able to instantiate the dw
i2c controller, same as txgbe/txgbe_phy.c really.

For some reasons I had to revert 560072246088, was getting a "spurious
STOP detected" but I'll follow up on that separately. Also find an issue
in the txgbe driver (I think?), sent
https://lore.kernel.org/netdev/20260405222013.5347-1-fabio.baltieri@gmail.com/
for it.

> > - Shall we (partially?) implement a struct sfp, so that functions like
> >   sfp_module_eeprom() can be used (implicitly)?
> > 
> > I assume this patch includes logic which duplicates what is available in
> > phylink/sfp already. I'd a appreciate any hints you can provide.
> 
> No. phylink etc will end up populating netdev->sfp_bus, and then
> get_module_eeprom_by_page() should then just make the module work in
> ethtool.
> 
> The interesting bit if gluing it all together, without DT. But
> txgbe_phy.c should be something you can copy from.
> 
> Does the out of tree driver give access to GPIOs connected to the SFP
> cage pins? Ideally you want those as well, for loss of signal,
> transmitter disable, knowing when a module has been inserted into the
> cage, etc.

It doesn't, but I was able to find them anyway, just dumping registers
randomly. :-) It looks like that is a bit more than "Ideally", the sfp
driver probes happily with no gpios defined but then it doesn't have
any ways to detect module changes (insertion/removal), it doesn't even
go into polling mode but even then it seems like it doesn't do detection
without a detect pin. I think the sfp probe function could be a bit more
defensive to inoperable configurations.

Anyway I was able to make detection and los work, so I have some code
with gpio, i2c and the sfp module detect and showing up in hwmon, and
sitting in waitdev state.

> 
> And you will need a PCS driver.
> 
> But first step is probably to work with the existing Base-T devices
> and convert the driver to phylink.

Ok I was going to ask how to connect the one above with the ethtool
handlers, so you are saying that first the whole driver needs to be
converted to use phylink/pcs and then that should work automatically-ish
right?

Can I send the current code I have as an RFC in the meantime to get some
early feedback? And then I guess it'll have to be reworked on top of the
phylink stuff (which I did not try to implement).

It's a pretty substantial amount of boilerplate code so I suspect Heiner
may want to refactor things about it, feels like it could live in its
own file.

Thanks for the help so far,
Fabio

