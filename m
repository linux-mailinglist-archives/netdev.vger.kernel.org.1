Return-Path: <netdev+bounces-278485-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eOk8KkBV3mmoqgkAu9opvQ
	(envelope-from <netdev+bounces-278485-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 16:54:56 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 639153FB80F
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 16:54:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DB136300B994
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 14:54:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A83439A81B;
	Tue, 14 Apr 2026 14:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="kwxwXhS0"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C26CB27470;
	Tue, 14 Apr 2026 14:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776178474; cv=none; b=dFhTg4e/Oo0Bs0qZ7VzTdr8XgmRzX7kIsocR8gVm6A4Y7Oz4pFJphGG/gFx6PjocmVdufKYxBlwgxC5kxPBZB2c1/+tyAm843QY5l17ixqYIDjrc3kH/a5QyGS8Qu10/LG7/d9Ulpa8VcazdIUjKauLsEK8EwkYMyiI6ZYTqrT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776178474; c=relaxed/simple;
	bh=GySGflb+yx8HkAtjxWgclmKRF9aMiN3Y2FsCPjZRnYU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cHx9aPGn0S+iNuSWfaLXcq5bbb9EOWPrczZ/r2Q78Ug69ia/yTOyZx3QQLWnE2vkl36D1aJuQiAnc7Ry4jUPRCjoLXryKNucrV6GCcWZ+VivZRBCgyvjPcVk5tiZTehQqne5NpJ7iMYrQzhC8F9QSWSsYM/OWqzNa1rANWBdXSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=kwxwXhS0; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=vxRKW52fMMlDsBtAf4BxmXyd0sFK8uxO4jiS8du193o=; b=kwxwXhS08XvKdbqNvVua9AlLJo
	iwiTfBG5EyIKOZ7BxSVcy8B/JuGfQjuKN4O5xev16T50ahmWGns6v0VJS6WWuzcfO+DHoez9YnLOB
	i+RStt67SlvL1Vjk0cmMgYX9w8HLHoYmxuBQbfpHRfBrGrHpUjAqRNxgyrBgyNNQXiLA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wCf9c-00G415-OH; Tue, 14 Apr 2026 16:54:16 +0200
Date: Tue, 14 Apr 2026 16:54:16 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Fidelio LAWSON <lawson.fidelio@gmail.com>
Cc: Marek Vasut <marex@nabladev.com>,
	Woojung Huh <woojung.huh@microchip.com>,
	UNGLinuxDriver@microchip.com, Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Marek Vasut <marex@denx.de>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Simon Horman <horms@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Fidelio Lawson <fidelio.lawson@exotec.com>
Subject: Re: [PATCH v3 1/3] net: dsa: microchip: implement KSZ87xx Module 3
 low-loss cable errata
Message-ID: <d584bd42-ee6d-465f-b4f7-2edc992368d6@lunn.ch>
References: <20260414-ksz87xx_errata_low_loss_connections-v3-0-0e3838ca98c9@exotec.com>
 <20260414-ksz87xx_errata_low_loss_connections-v3-1-0e3838ca98c9@exotec.com>
 <ea90a671-70be-4d89-b842-1e54d687336f@nabladev.com>
 <d9b161dd-f698-4d7e-8ccb-9ec12411bf87@lunn.ch>
 <264667a8-bbb2-44ac-84e7-df6c506ae6fa@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <264667a8-bbb2-44ac-84e7-df6c506ae6fa@gmail.com>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-278485-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[nabladev.com,microchip.com,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,denx.de,bootlin.com,armlinux.org.uk,vger.kernel.org,exotec.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[lunn.ch:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,lunn.ch:dkim,lunn.ch:mid]
X-Rspamd-Queue-Id: 639153FB80F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Apr 14, 2026 at 03:48:33PM +0200, Fidelio LAWSON wrote:
> On 4/14/26 14:40, Andrew Lunn wrote:
> > On Tue, Apr 14, 2026 at 01:05:49PM +0200, Marek Vasut wrote:
> > > On 4/14/26 11:12 AM, Fidelio Lawson wrote:
> > > > Implement the "Module 3: Equalizer fix for short cables" erratum from
> > > > Microchip document DS80000687C for KSZ87xx switches.
> > > > 
> > > > The issue affects short or low-loss cable links (e.g. CAT5e/CAT6),
> > > > where the PHY receiver equalizer may amplify high-amplitude signals
> > > > excessively, resulting in internal distortion and link establishment
> > > > failures.
> > > > 
> > > > KSZ87xx devices require a workaround for the Module 3 low-loss cable
> > > > condition, controlled through the switch TABLE_LINK_MD_V indirect
> > > > registers.
> > > > 
> > > > The affected registers are part of the switch address space and are not
> > > > directly accessible from the PHY driver. To keep the PHY-facing API
> > > > clean and avoid leaking switch-specific details, model this errata
> > > > control as vendor-specific Clause 22 PHY registers.
> > > > 
> > > > A vendor-specific Clause 22 PHY register is introduced as a mode
> > > > selector in PHY_REG_LOW_LOSS_CTRL, and ksz8_r_phy() / ksz8_w_phy()
> > > > translate accesses to these bits into the appropriate indirect
> > > > TABLE_LINK_MD_V accesses.
> > > > 
> > > > The control register defines the following modes:
> > > > 0: disabled (default behavior)
> > > > 1: EQ training workaround
> > > > 2: LPF 90 MHz
> > > > 3: LPF 62 MHz
> > > > 4: LPF 55 MHz
> > > > 5: LPF 44 MHz
> > > I may not fully understand this, but aren't the EQ and LPF settings
> > > orthogonal ?
> > 
> > What is the real life experience using this feature? Is it needed for
> > 1cm cables, but most > 1m cables are O.K with the defaults? Do we need
> > all these configuration options? How is a user supposed to discover
> > the different options? Can we simplify it down to a Boolean?
> We were seeing random link dropouts with the default settings, and since
> enabling the workaround 2, the link has remained stable and we have not
> observed any further issues.

So for you, a boolean which enables workaround 2 would be sufficient.

Marek, what is your experience?

       Andrew

